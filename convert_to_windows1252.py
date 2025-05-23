import os

def convert_file_to_windows1252(src_path, dst_path=None):
    # Read as UTF-8, replace errors
    with open(src_path, 'r', encoding='utf-8', errors='replace') as f:
        content = f.read()
    # Encode to Windows-1252, replacing unsupported characters with '?'
    encoded = content.encode('windows-1252', errors='replace')
    if not dst_path:
        dst_path = src_path
    with open(dst_path, 'wb') as f:
        f.write(encoded)
    print(f"Converted: {src_path} -> {dst_path}")

if __name__ == "__main__":
    files = [
        r"clpss-db\DB\sql\Data\v20250522120000__UTF8_TEST_SAMPLE.sql",
        r"clpss-db\DB\sql\Packages\windows1252.sql",
        r"c:\Users\madan\Downloads\v20161223133700000_EMPL1252.sql"
    ]
    for file in files:
        if os.path.exists(file):
            convert_file_to_windows1252(file)
        else:
            print(f"File not found: {file}")