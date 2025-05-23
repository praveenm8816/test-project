import sys
import os
import re
import argparse
import chardet

# Regex patterns
v_script_pattern = re.compile(r"^v(20[0-9]{2})(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])__[\w\-]+\.sql$", re.IGNORECASE)
r_script_pattern = re.compile(r"^r__((SIMDATA|CLP2ADMIN)\.[a-zA-Z0-9_]+)\.(pkb|pks|vw|trg|tps)\.sql$", re.IGNORECASE)

# Expected folder paths
V_SCRIPT_FOLDER = os.path.normpath("clpss-db/DB/sql/Data")

R_SCRIPT_FOLDERS = [
    os.path.normpath("clpss-db/DB/sql/Packages"),
    os.path.normpath("clpss-db/DB/sql/Functions"),
    os.path.normpath("clpss-db/DB/sql/Procedures"),
    os.path.normpath("clpss-db/DB/sql/Views"),
    os.path.normpath("clpss-db/DB/sql/*")
]

from pathlib import Path

def is_windows1252(filepath):
    # Use chardet to strictly check encoding
    try:
        with open(filepath, 'rb') as f:
            raw = f.read()
        result = chardet.detect(raw)
        encoding = (result['encoding'] or '').lower()
        confidence = result.get('confidence', 0)
        if encoding in ['windows-1252', 'iso-8859-1', 'ascii'] and confidence >= 0.7:
            return True
        print(f"[Encoding Error] File '{filepath}' detected as '{encoding}' (confidence: {confidence:.2f}), not Windows-1252.")
        return False
    except Exception as e:
        print(f"[Encoding Error] Could not check encoding for '{filepath}': {e}")
        return False

def is_valid_filename(filename):

    errors = []
    first_char = filename[:1].lower()

    if first_char == 'v':
        if filename.startswith('V'):
            errors.append("V script filenames must start with lowercase 'v'")
        if '__' not in filename:
            errors.append("V script must contain double underscore '__' after 'vYYYYMMDD__description.sql'")

        if not (match := v_script_pattern.match(filename)):
            if not re.match(r'^v\d+', filename):
                errors.append("V script must start with 'v' followed by a date in format YYYYMMDD.")
            errors.append("V script must follow naming: vYYYYMMDD__description.sql")
        else:
            year, month, day = match.groups()
            if not (2000 <= int(year) <= 2099):
                errors.append(f"Invalid year '{year}' in V script. Must be between 2000 and 2099.")
            if not (1 <= int(month) <= 12):
                errors.append(f"Invalid month '{month}' in V script. Must be between 01 and 12.")
            if not (1 <= int(day) <= 31):
                errors.append(f"Invalid day '{day}' in V script. Must be between 01 and 31.")

    elif first_char == 'r':
        if filename.startswith('R'):
            errors.append("R script filenames must start with lowercase 'r'.")
        if '__' not in filename:
            errors.append("R script must contain double underscore '__' after 'r'.")
        if 'SIMDATA/' not in filename and 'CLP2ADMIN/' not in filename:
            errors.append("R scripts must include either 'SIMDATA/' or 'CLP2ADMIN/' in the filename (e.g., r__SIMDATA/description.pkb.sql)")
        if not (filename.endswith('.pkb.sql') or filename.endswith('.pks.sql') or filename.endswith('.vw.sql') or filename.endswith('.trg.sql')):
            errors.append("R script must end with '.pkb.sql', '.pks.sql', '.vw.sql', or '.trg.sql'")
        if not r_script_pattern.match(filename):
            errors.append("R script must follow the naming pattern: r__SCHEMA/OBJECT.pkb.sql")

    else:
        errors.append("Filename must start with either 'v' or 'r' for reusable scripts.")

    return (False, "\n - " + "\n - ".join(errors)) if errors else (True, "")

def is_valid_folder(file_path):
    norm_path = os.path.normpath(file_path)
    file_name = os.path.basename(file_path)

    if os.path.basename(file_path).startswith('v'):
        if V_SCRIPT_FOLDER not in norm_path:
            return False, f"V script must be located in '{V_SCRIPT_FOLDER}'"
        return True, "Success"
    elif file_name.startswith('r'):
        for folder in R_SCRIPT_FOLDERS:
            if folder in norm_path:
                return True, "Success"
        return False, f"R scripts must be located in one of: {', '.join(R_SCRIPT_FOLDERS)}"

    return False, "Unknown script type for folder validation"

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
            "encoding": is_windows1252(file_path),
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

if __name__ == "__main__":
    main()