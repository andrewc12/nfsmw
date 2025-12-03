ninja|| exit
sed -n "/\.fn BoxVsBox__3OBBP3OBBN21, global/,/\.endfn BoxVsBox__3OBBP3OBBN21/p" .\build\GOWE69\asm\Speed\Indep\SourceLists\zSim.s| python .\andrewtools\strip_comments.py >./BoxVsBox_orig.s
build\tools\dtk.exe elf disasm  C:\Users\andre\Documents\GitHub\nfsmw\build\GOWE69\src\Speed\Indep\SourceLists\zSim.o tmp.s
sed -n "/\.fn BoxVsBox__3OBBP3OBBN21, global/,/\.endfn BoxVsBox__3OBBP3OBBN21/p" tmp.s |python .\andrewtools\strip_comments.py >./wip.s
del tmp.s
type wip.s

jq --arg funcname "BoxVsBox__3OBBP3OBBN21" ".units[].functions[]? | select(.name == $funcname)" .\build\GOWE69\report.json