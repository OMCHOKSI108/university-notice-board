# 📱 University Notice Board App

A comprehensive, feature-rich Flutter application designed for university notice management. Built with modern UI/UX principles and powerful functionality to streamline communication between university administration and students.

## ✨ Features

### 🔐 **Authentication System**
- Secure login with CHARUSAT email credentials
- Password format: DOB_ID number (DDMMYYYY_ID)
- Mock user database for demonstration

### 📋 **Notice Management**
- **Create Notices**: Add new notices with title, description, category, and priority
- **Edit Notices**: Modify existing notices with full data preservation
- **Delete Notices**: Safe deletion with confirmation dialogs
- **File Attachments**: Support for attaching documents and files

### 🔍 **Advanced Filtering & Search**
- **Real-time Search**: Search notices by title, description, or author
- **Category Filters**: Filter by Exam, Event, Academic, or General notices
- **Priority Levels**: High, Medium, Low priority indicators
- **Favorites System**: Bookmark important notices

### 🎨 **Modern UI/UX**
- **Dark/Light Theme**: Seamless theme switching
- **Responsive Design**: Optimized for all screen sizes
- **Loading States**: Visual feedback for all operations
- **Professional Design**: Clean, intuitive interface

### 📊 **Dashboard Analytics**
- **Notice Statistics**: Overview of notices by category
- **Author Tracking**: Track notice creators
- **Timestamp Information**: Creation and modification dates
- **Priority Overview**: Visual priority indicators

## 📸 Screenshots

### Login Page
![Login Page](images/login-page.png)

### Dashboard
![Dashboard](images/dashboard.png)

### Add Notice
![Add Notice](images/add-notice.png)

### Event Details & Dark Mode
![Event Details](images/event.png)
![Filter Dark Mode](images/filterdark-mode.png)

## 🚀 Installation

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Android/iOS emulator or physical device

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/university-notice-board.git
   cd university-notice-board
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build Instructions

**For Android APK:**
```bash
flutter build apk --release
```

**For iOS (macOS only):**
```bash
flutter build ios --release
```

## 📱 Usage

### Login Credentials (Demo)
The app includes mock user accounts for testing:

| Email | Password | Format |
|-------|----------|--------|
| 23AIML010@charusat.edu.in | 14082006_23AIML010 | DDMMYYYY_ID |
| 23AIML047@charusat.edu.in | 19092005_23AIML047 | DDMMYYYY_ID |
| 23AIML123@charusat.edu.in | 05122004_23AIML123 | DDMMYYYY_ID |

### App Features Guide

1. **Login**: Enter your CHARUSAT email and DOB_ID password
2. **Dashboard**: View all notices with filtering options
3. **Search**: Use the search bar to find specific notices
4. **Filter**: Use category buttons or favorites toggle
5. **Add Notice**: Tap the + button to create new notices
6. **View Details**: Tap any notice to see full details
7. **Edit/Delete**: Use the action buttons in notice details
8. **Theme**: Toggle between light and dark modes

## 🛠️ Technologies Used

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Stateful Widgets
- **Storage**: SharedPreferences (Local)
- **File Handling**: File Picker
- **UI Components**: Material Design
- **Architecture**: MVC Pattern

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2
  file_picker: ^8.0.0+1
  uuid: ^4.2.1
  cupertino_icons: ^1.0.8
```

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point & theme management
├── login.dart                # Authentication screen
├── dashboard.dart            # Main dashboard with notice list
├── models/
│   └── notice.dart          # Notice data model
├── screens/
│   ├── add_notice.dart      # Add/Edit notice screen
│   └── notice_detail.dart   # Notice details screen
└── services/
    └── notice_service.dart  # Data persistence service
```

## 🔧 Development

### Code Style
This project follows Flutter's recommended code style and uses:
- `flutter analyze` for static analysis
- Proper error handling
- Clean architecture principles

### Testing
```bash
flutter test
```

### Code Generation
```bash
flutter pub run build_runner build
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Your Name**
- GitHub: [@your-username](https://github.com/your-username)
- LinkedIn: [Your LinkedIn](https://linkedin.com/in/your-profile)

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- Material Design for UI inspiration
- CHARUSAT University for the inspiration

---

**⭐ Star this repo if you found it helpful!**

For questions or support, please open an issue on GitHub.
