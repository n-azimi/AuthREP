# AuthREP: Unsuccessful Login Attempts Report Script

This bash script generates a report on unsuccessful login attempts. It filters entries related to authentication failures and allows the user to choose the output format (either `.txt` or `.csv`).

## 🛠️ Prerequisites

- The script assumes that the system is running a Unix-like operating system (Linux, macOS).
- You must have access to the `/var/log/auth.log` file or equivalent log file for authentication failures.
- The script requires basic command-line utilities like `awk`, `grep`, `sed`, and `sort`.

## 🖥️ Usage

1. Clone the script and navigate to the directory
   ```bash
   git clone https://github.com/n-azimi/AuthREP.git && cd AuthREP
   ```

2. Make sure the script is executable:
   ```bash
   chmod u+x script.sh
   ```

3. Run the script:
   ```bash
   ./script.sh
   ```

4. The script will display a summary of the unsuccessful login attempts from the `auth.log` file. It will include the following columns:
   - Timestamp (ISO 8601 format)
   - Login Name
   - Login Terminal
   - Login User
   - Remote User
   - Remote Host

5. You will then be prompted to choose the output format. You can choose between `txt` or `csv` format.

6. Once you select a format, the data will be saved to the current directory.

## 📜 Script Details

- **Color Coding**

- **Error Handling**

- **Supporting Common Output Formats**

## 🗂️ Example Output (TXT)

```
Timestamp (ISO 8601 format)    Login Name    Login Terminal    Login User    Remote User    Remote Host
2025-01-06T12:34:56+00:00      ubuntu        /dev/tty1         ubuntu 
2025-01-06T12:35:22+00:00      johnson       ssh                             johnson        192.168.1.101
```

## 🗂️ Example Output (CSV)

```
Timestamp,Login Name,Login Terminal,Login User,Remote User,Remote Host
2025-01-06T12:34:56+00:00,ubuntu,/dev/tty1,ubuntu,,
2025-01-06T12:35:22+00:00,johnson,ssh,,johnson,192.168.1.101
```
