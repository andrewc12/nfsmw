import re
import sys
from typing import Optional, TextIO

def strip_cpp_comments(code: str) -> str:
    """
    Removes C++ style single-line (//) and multi-line (/* ... */) comments
    from a given string of C++ code.
    """
    # Regex to match multi-line comments (/* ... */)
    # It handles nested comments (though C++ doesn't officially support them)
    # and ensures it doesn't match across string literals.
    multiline_comment_pattern = r'/\*.*?\*/'
    
    # Regex to match single-line comments (//)
    # It matches from // to the end of the line.
    singleline_comment_pattern = r'//.*'
    
    # First, remove multi-line comments
    code_without_multiline_comments = re.sub(multiline_comment_pattern, '', code, flags=re.DOTALL)
    
    # Then, remove single-line comments
    code_without_comments = re.sub(singleline_comment_pattern, '', code_without_multiline_comments)
    
    return code_without_comments


def main() -> None:
    """Pipeable entry point that reads from stdin and writes to stdout."""
    # Read all input from stdin
    input_code = sys.stdin.read()
    
    # Remove comments
    stripped_code = strip_cpp_comments(input_code)
    
    # Write result to stdout
    sys.stdout.write(stripped_code)


def process_file(input_file: str, output_file: Optional[str] = None) -> None:
    """
    Process a file, removing C++ comments.
    
    Args:
        input_file: Path to input C++ file
        output_file: Optional path to output file. If None, prints to stdout.
    """
    with open(input_file, 'r', encoding='utf-8') as f:
        code = f.read()
    
    stripped_code = strip_cpp_comments(code)
    
    if output_file:
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(stripped_code)
    else:
        print(stripped_code)


if __name__ == "__main__":
    # Allow both pipe usage and file processing
    if len(sys.argv) > 1:
        # File mode: python script.py input.cpp [output.cpp]
        input_file = sys.argv[1]
        output_file = sys.argv[2] if len(sys.argv) > 2 else None
        process_file(input_file, output_file)
    else:
        # Pipe mode: cat file.cpp | python script.py
        main()