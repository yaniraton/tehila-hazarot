# 🛒 Tehila Hazarot — Flutter Supermarket Scanner

A simple web-based app built with Flutter that allows supermarket staff or vendors to quickly scan products by barcode, enter quantities, and export the list as a printable file.

## ✨ Features

- 📷 Scan barcodes using phone or webcam (web support via html5-qrcode)  
- 📝 Manually enter product name, barcode, and quantity  
- ➕ Add multiple products to a list  
- 📄 Export as printable PDF with Hebrew support (RTL)  
- 🌐 Flutter Web compatible and statically deployed via GitHub Pages  

## 🚀 Live Demo

🔗 [View the App](https://yaniraton.github.io/tehila-hazarot/)

## 🛠 Built With

- Flutter 3.10+  
- Flutter Web  
- `pdf` + `printing` (for PDF export)  
- `html5-qrcode` (JS barcode scanner)  
- GitHub Pages for deployment  

## 📦 Getting Started (for developers)

### 🔧 Prerequisites

- Flutter SDK: https://flutter.dev/docs/get-started/install  
- Chrome (for web testing)

### 📥 Clone the repo

```
git clone https://github.com/yaniraton/tehila-hazarot.git  
cd tehila-hazarot  
flutter pub get
```

### ▶️ Run Locally

```
flutter run -d chrome
```

## 🌍 Deployment

### 🛠 Build for Web

```
flutter build web
```

### 🚀 Deploy to GitHub Pages

```
cd build/web  
git init  
git checkout -b gh-pages  
git remote add origin https://github.com/yaniraton/tehila-hazarot.git  
touch .nojekyll  
git add .  
git commit -m "Deploy Flutter Web"  
git push -f origin gh-pages
```

Then enable GitHub Pages in the repository settings (choose `gh-pages` branch).

## 📁 Project Structure

```
lib/  
├── models/            # Product model  
├── widgets/           # UI components: form, list, export button  
├── utils/             # PDF & CSV export logic  
├── web/               # Web barcode scanner (html5-qrcode)  
├── pages/             # Main product scanning page  
└── main.dart          # Entry point  
```

## 🧾 License

This project is open-source and free to use.

## 🙏 Acknowledgments

- [`html5-qrcode`](https://github.com/mebjas/html5-qrcode) for browser-based scanning  
- [`pdf`](https://pub.dev/packages/pdf) & [`printing`](https://pub.dev/packages/printing) for Flutter PDF tools
