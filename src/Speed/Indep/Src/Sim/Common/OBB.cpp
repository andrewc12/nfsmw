#include "../OBB.h"
#include "Speed/Indep/Libs/Support/Utility/UMath.h"

OBB::OBB() {}

OBB::~OBB() {}

void OBB::Reset(const UMath::Matrix4 &orient, const UMath::Vector3 &position, const UMath::Vector3 &dimension) {
    shape = BOX;
    *reinterpret_cast<UMath::Vector3 *>(&this->position) = position;

    this->dimension[0] = dimension.x;
    this->dimension[1] = dimension.y;
    this->dimension[2] = dimension.z;

    this->normal[0].x = orient[0][0];
    this->normal[0].y = orient[0][1];
    this->normal[0].z = orient[0][2];

    this->normal[1].x = orient[1][0];
    this->normal[1].y = orient[1][1];
    this->normal[1].z = orient[1][2];

    this->normal[2].x = orient[2][0];
    this->normal[2].y = orient[2][1];
    this->normal[2].z = orient[2][2];

    this->extent[0].x = this->normal[0].x * this->dimension[0];
    this->extent[0].y = this->normal[0].y * this->dimension[0];
    this->extent[0].z = this->normal[0].z * this->dimension[0];

    this->extent[1].x = this->normal[1].x * this->dimension[1];
    this->extent[1].y = this->normal[1].y * this->dimension[1];
    this->extent[1].z = this->normal[1].z * this->dimension[1];

    this->extent[2].x = this->normal[2].x * this->dimension[2];
    this->extent[2].y = this->normal[2].y * this->dimension[2];
    this->extent[2].z = this->normal[2].z * this->dimension[2];

    collision_normal.w = 0.0f;
    collision_point.w = 0.0f;
    penetration_depth = -100000.0f;
}

// UNSOLVED but sould be functionally equivalent
bool OBB::CheckOBBOverlap(OBB *other) {
    if (this->shape != BOX || other->shape != BOX) {
        return CheckOBBOverlapAndFindIntersection(other);
    }

    UMath::Vector4 rel_position;
    UMath::Vector4 a_normal;
    UMath::Vector4 *b_extent;
    float projected_interval;
    float b_projected_interval;
    OBB *a = this;
    OBB *b = other;

    for (int cycle = 0; cycle < 2; cycle++) {
        if (cycle == 1) {
            a = other;
            b = this;
        }
        for (int a_lp = 0; a_lp < 3; a_lp++) {
            int a_normal_index = 2;
            if (a_lp != 1) {
                a_normal_index = (a_lp ^ 2) == 0; // really written this way?
            }
            a_normal = a->normal[a_normal_index];
            UMath::Subxyz(a->position, b->position, rel_position);
            projected_interval = fabsf(UMath::Dotxyz(rel_position, a_normal));
            projected_interval -= a->dimension[a_normal_index];
            b_extent = b->extent;
            for (int b_normal_index = 0; b_normal_index < 3; b_normal_index++) {
                b_projected_interval = UMath::Dotxyz(a_normal, *b_extent);
                projected_interval -= fabsf(b_projected_interval);
                b_extent++;
            }
            if (projected_interval > 0.0f) {
                return false;
            }
        }
    }
    return true;
}

bool OBB::BoxVsBox(OBB *a, OBB *b, OBB *result) {
    // TODO
}

bool OBB::SphereVsBox(OBB *a, OBB *b, OBB *result) {
    UMath::Vector4 rPos;
    const float radius = a->dimension[0];
    float dists[3];
    float abs_dists[3];
    float penetration[3];

    VU0_v4subxyz(a->position, b->position, rPos);

    result->collision_point = UMath::Vector4::kIdentity;

    for (int a_lp = 0; a_lp < 3; a_lp++) {
        const float b_dim = b->dimension[a_lp];
        float dist = VU0_v4dotprodxyz(rPos, b->normal[a_lp]);
        dists[a_lp] = dist;

        float abs_dist;
        if (dist >= 0.0f) {
            abs_dist = dist;
        } else {
            abs_dist = -dist;
        }
        abs_dists[a_lp] = abs_dist;

        if (b_dim + radius <= abs_dist) {
            return false;
        }

        penetration[a_lp] = abs_dist - (b_dim + radius);
    }

    if (abs_dists[0] <= b->dimension[0] && abs_dists[1] <= b->dimension[1] && abs_dists[2] <= b->dimension[2]) {
        int nearestface = 0;
        for (int i = 1; i < 3; i++) {
            if (penetration[i] < penetration[nearestface]) {
                nearestface = i;
            }
        }

        float normal_dir;
        if (dists[nearestface] >= 0.0f) {
            normal_dir = 1.0f;
        } else {
            normal_dir = -1.0f;
        }
        result->penetration_depth = penetration[nearestface];
        VU0_v4scalexyz(b->normal[nearestface], normal_dir, result->collision_normal);
        VU0_v4scaleaddxyz(b->normal[nearestface], normal_dir * (penetration[nearestface] + radius), a->position, result->collision_point);
    } else {
        UMath::Vector4 *collision_point_ptr = &result->collision_point;
        for (int i = 0; i < 3; i++) {
            if (b->dimension[i] <= abs_dists[i]) {
                float normal_dir;
                if (dists[i] >= 0.0f) {
                    normal_dir = 1.0f;
                } else {
                    normal_dir = -1.0f;
                }
                float planedist = penetration[i] + radius;
                VU0_v4scaleaddxyz(b->normal[i], normal_dir * planedist, *collision_point_ptr, *collision_point_ptr);
            }
        }

        float coldist = VU0_sqrt(VU0_v4lengthsquarexyz(result->collision_point));
        if (coldist > radius) {
            return false;
        }
        if (coldist == 0.0f) {
            return false;
        }

        result->penetration_depth = coldist - radius;
        float rlen = VU0_rsqrt(VU0_v4lengthsquare(result->collision_point));
        VU0_v4scale(result->collision_point, rlen, result->collision_normal);
        VU0_v4addxyz(result->collision_point, a->position, result->collision_point);
    }

    if (result != a) {
        VU0_v4scalexyz(result->collision_normal, -1.0f, result->collision_normal);
    }

    return true;
}

bool OBB::SphereVsSphere(OBB *a, OBB *b, OBB *result) {
    UMath::Vector4 rPos;
    UMath::Subxyz(a->position, b->position, rPos);
    float dist = UMath::Lengthxyz(rPos);
    float radius_total = a->dimension[0] + b->dimension[0];

    if (dist == 0.0f) {
        result->collision_normal.x = 0.0f;
        result->collision_normal.y = -1.0f;
        result->collision_normal.z = 0.0f;

        result->collision_point.x = a->position.x;
        result->collision_point.x = a->position.y + a->dimension[0];
        result->collision_point.x = a->position.z;

        result->penetration_depth = -a->dimension[0];
    } else if (dist >= radius_total) {
        return false;
    } else {
        UMath::Unitxyz(rPos, result->collision_normal);
        result->penetration_depth = dist - radius_total;
        UMath::ScaleAddxyz(result->collision_normal, b->dimension[0] + result->penetration_depth, b->position, result->collision_point);
    }
    if (a == result) {
        result->collision_normal.x = -result->collision_normal.x;
        result->collision_normal.y = -result->collision_normal.y;
        result->collision_normal.z = -result->collision_normal.z;
    }
    return false;
}

bool OBB::CheckOBBOverlapAndFindIntersection(OBB *other) {
    this->penetration_depth = -100000.0f;
    if (this->shape == BOX) {
        if (other->shape == BOX) {
            return OBB::BoxVsBox(this, other, this);
        }
        if (other->shape == SPHERE) {
            return OBB::SphereVsBox(other, this, this);
        }
    } else if (this->shape == SPHERE) {
        if (other->shape == SPHERE) {
            return OBB::SphereVsSphere(this, other, this);
        }
        if (other->shape == BOX) {
            return OBB::SphereVsBox(this, other, this);
        }
    }
    return false;
}
