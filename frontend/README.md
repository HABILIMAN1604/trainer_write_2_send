# TrainerWrite2Send 🚀

**TrainerWrite2Send** is a Flutter-based mobile application designed to bridge the gap between manual handwriting and digital reporting. It is specifically built for production trainers who are more comfortable with handwriting than digital typing, ensuring they can fulfill digitalization requirements without the frustration of mobile keyboards.

---

## 📖 The "Why"
In the manufacturing sector, digitalization often forces workers to switch from familiar manual methods to inefficient digital typing (inefficient for those with less digital knowledge and literacy). For many, typing long lists of trainee names and employee IDs on a small screen is a significant barrier.

**The Solution:** This app allows the user to continue writing their report manually on paper—their most comfortable and efficient method. The app then captures the handwriting, extracts the data using OCR, and formats it into a professional digital report.

## ✨ Key Features
* **Analog-to-Digital Bridge:** Optimized to scan manual handwriting from paper.
* **Minimalist UI:** A "3-step max" workflow designed for users who aren't tech-savvy.
* **OCR Text Extraction:** Powered by **Google ML Kit** to translate handwriting into digital text.
* **Action Modes:**
    * **Passover Mode:** Automatically converts scanned names/IDs into a formatted WhatsApp message.
    * **Output Mode:** Directly maps scanned production data into Google Form entries.

## 🔄 Application Workflow
The process is designed to be lean and fast (processing time < 3s):

1.  **Manual Write:** The trainer writes the trainee list or production data on paper.
2.  **Capture:** User takes a photo of the handwritten list through the app.
3.  **Extract & Format:** Google ML Kit extracts the text; the app cleans and formats it.
4.  **Action:** One click to share via WhatsApp or auto-submit to a Google Form.

## 🛠️ Tech Stack
* **Frontend:** Flutter & Dart
* **OCR Engine:** Google ML Kit (Text Recognition)
* **State Management:** Riverpod
* **Local Storage:** SharedPreferences / Hive
* **UI/UX Design:** Figma (Focusing on accessibility and high-contrast visuals)

## 📋 Requirements
### Functional
* **Handwriting Recognition:** Must accurately capture and extract text from paper.
* **Mode Selection:** Toggle between "Passover" (WhatsApp) and "Output" (Google Form).
* **One-Click Action:** Minimize the need for corrections or manual typing after scanning.

### Non-Functional
* **Accessibility:** Large buttons and clear labels for ease of use by non-tech-savvy users.
* **Efficiency:** The end-to-end process must be significantly faster than typing the same data manually.
* **Performance:** Processing time from capture to output must be less than 3 seconds.

## 🚀 Getting Started

### Installation
1.  Clone the repository:
    ```bash
    git clone [https://github.com/HABILIMAN1604/trainer_write_2_send.git](https://github.com/HABILIMAN1604/trainer_write_2_send.git)
    ```
2.  Install dependencies:
    ```bash
    flutter pub get
    ```
3.  Run the app:
    ```bash
    flutter run
    ```

---
Developed with ❤️ by **Habil Iman** *Empowering manual workflows through technology.*