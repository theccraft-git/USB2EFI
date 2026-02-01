# 🛠️ USB2EFI

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Version](https://img.shields.io/badge/Version-v0.1--beta-orange.svg)]()
[![Platform](https://img.shields.io/badge/Platform-Windows-lightgrey.svg)]()

**USB2EFI** is a lightweight automation script designed to bridge the gap between USB port mapping and OpenCore configuration. It eliminates the manual labor of moving kexts and editing `config.plist` files after using tools like USBToolBox.

---

## ❓ What does it do?

When you map USB ports on Windows, you usually get a `UTBMap.kext`. Traditionally, you have to:
1. Manually move the kext to your EFI folder.
2. Delete the old `UTBDefault.kext`.
3. Open a Plist editor and update the kext entries.
4. Fix the Architecture string for compatibility.

**USB2EFI automates all of this in seconds.**

## 🚀 Features

- **Automated Kext Injection:** Detects `UTBMap.kext` and moves it to the correct `OC/Kexts` directory.
- **Smart Cleanup:** Automatically removes `UTBDefault.kext` to prevent conflicts.
- **Plist Patching:** Uses PowerShell logic to update your `config.plist` without needing a GUI editor.
- **Architecture Fix:** Automatically sets kext architecture to `Any` (or your preferred string) to ensure it loads during boot.

---

## 🛠️ How to Use

1.  **Download:** Clone this repo or download the `USB2EFI.bat`.
2.  **Run:** `USB2EFI.bat`.
3.  **Follow the Steps:**
    * **Part 1:** Drag and Drop your EFI Folder.
    * **Part 2:** Drag and Drop your Kext.
4.  **Done:** Copy the final EFI to your USB drive.

---

## ⚖️ License & Credits

* **Developer:** [@theccraft-git](https://github.com/theccraft-git)
* **License:** This project is licensed under the [BSD 3-Clause License](LICENSE).

---

## 🤝 Contributing

Found a bug? Have a suggestion for this project? 
1. Fork the project.
2. Create your Feature Branch.
3. Open a Pull Request!
