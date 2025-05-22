import sys
import os
import re
import argparse

# Regex patterns
v_script_pattern = re.compile(r'^(20[0-9]{2})([01][0-2])([0-3][0-9])_[\w\-]+\.sql$', re.IGNORECASE)
r_script_pattern = re.compile(r'^r__\w+\.(pkb|pks)\.sql$', re.IGNORECASE)

# Expected folder paths
R_SCRIPT_FOLDER = os.path.normpath("clpss-db/DB/sql/Data")

R_SCRIPT_FOLDERS = [
    os.path.normpath("clpss-db/DB/sql/Packages"),
    os.path.normpath("clpss-db/DB/sql/Functions"),
    os.path.normpath("clpss-db/DB/sql/Procedures"),
    os.path.normpath("clpss-db/DB/sql/Views")
]

def is_windows1252_encoded(file_path):
    with open(file_path, 'rb') as f:
        raw = f.read()

    result = chardet.detect(raw)
    encoding = (result['encoding'] or '').lower()
    confidence = result.get('confidence', 0)

    print(f"{file_path}: Detected '{encoding}' (confidence: {confidence:.2f})")
    return encoding == 'windows-1252' and confidence >= 0.7

def main(files):
    failed = False
    for file_path in files:
        if not os.path.isfile(file_path):
            continue
        if not is_windows1252_encoded(file_path):
            print(f"❌ File '{file_path}' is NOT Windows-1252 encoded!")
            failed = True
    if failed:
        sys.exit(1)
    print("✅ All files are Windows-1252 encoded.")

if _name_ == "_main_":
    main(sys.argv[1:])

def is_valid_filename(filename):
    if filename.startswith('v'):
        return bool(v_script_pattern.match(filename))
    elif filename.startswith('r'):
        return bool(r_script_pattern.match(filename))
    return False

def is_valid_folder(file_path):
    norm_path = os.path.normpath(file_path)
    if os.path.basename(file_path).startswith('v'):
        return V_SCRIPT_FOLDER in norm_path
    elif os.path.basename(file_path).startswith('r'):
        return any(folder in norm_path for folder in R_SCRIPT_FOLDERS)
    return False

def parse_status_files(status_string):
    status_dict = {}
    if status_string:
        lines = status_string.strip().split('\n')
        for line in lines:
            status, filename = line.strip().split(maxsplit=1)
            status_dict[filename] = status
    return status_dict

def main():
    parser = argparse.ArgumentParser(description="Validate files for encoding, naming, folder, and status.")
    parser.add_argument('files', nargs='+', help="List of changed files")
    parser.add_argument('--status-files', type=str, help="String containing file status and name")
    args = parser.parse_args()

    status_dict = parse_status_files(args.status_files) if args.status_files else {}

    results = {}
    failed = False

    for file_path in args.files:
        file_name = os.path.basename(file_path)
        status = status_dict.get(file_path, "Unknown")

        # If file is Modified ('M'), fail immediately for V scripts
        if status == "M":
            if file_name.startswith("v"):
                print(f"\nFile '{file_path}' is a V script and is Modified (M). Modifications are not allowed.")
                failed = True
                continue
            elif file_name.startswith("r"):
                print(f"File '{file_path}' is an R script and Modified (M) — allowed.")

        if not os.path.isfile(file_path):
            print(f"Skipping non-existent file: {file_path}")
            continue

        results[file_path] = {
            "encoding": is_windows1252_encoded(file_path),
            "naming": is_valid_filename(file_name),
            "folder": is_valid_folder(file_path)
        }

    for file, checks in results.items():
        errors = []
        if not checks["encoding"]:
            errors.append("Invalid encoding (not Windows-1252)")
        if not checks["naming"]:
            errors.append("Invalid naming convention")
        if not checks["folder"]:
            errors.append("Incorrect folder location")

        if errors:
            failed = True
            print(f"\nIssues found in file: {file}")
            for error in errors:
                print(f"  - {error}")

    if failed:
        print("\nOne or more files failed validation checks.")
        sys.exit(1)
    else:
        print("All files passed encoding, naming, and folder location checks.")

if _name_ == "_main_":
    main()
