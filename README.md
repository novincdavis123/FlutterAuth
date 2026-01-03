# Flutter Auth App

A simple **Flutter** authentication app with **Login** and **Registration** pages, using **Riverpod 3** for state management. The app demonstrates form validation, password visibility toggles, and dynamic button enable/disable logic based on input fields.

---

## Features

- **Login Page**
  - Email/Username input
  - Password input with visibility toggle
  - Login button enabled only when fields are valid
  - "Forgot Password?" link (no functionality)
  - "Register" link navigates to Registration page

- **Registration Page**
  - Name, Email, Password, Confirm Password inputs
  - Password and Confirm Password visibility toggles
  - Real-time form validation
  - Register button enabled only when all fields are valid
  - "Back to Login" link

- **State Management**
  - Riverpod 3 NotifierProviders for:
    - Authentication state
    - Registration form state
    - Password visibility toggles
  - Pages extend `ConsumerWidget` to access `WidgetRef ref`, no extra `Consumer` widgets needed

- **Form Validation**
  - Email format
  - Password length
  - Confirm password matching

- **Navigation**
  - Login → Home on successful login
  - Registration → Home on successful registration

---

## Folder Structure

flutterauth/
│
├─ lib/
│ ├─ auth/
│ │ ├─ auth_provider.dart
│ │ └─ auth_state.dart
│ │
│ ├─ pages/
│ │ ├─ login_page.dart
│ │ ├─ register_page.dart
│ │ └─ home_page.dart
│ │
│ ├─ providers/
│ │ ├─ password_visibility_provider.dart
│ │ └─ register_form_provider.dart
│ │
│ ├─ utils/
│ │ └─ validators.dart
│ │
│ └─ widgets/
│ └─ form_textfield.dart
│
├─ pubspec.yaml
└─ README.md



---

## Getting Started

### Prerequisites

- Flutter SDK ≥ 3.0  
- Dart ≥ 2.18  
- IDE: VS Code or Android Studio  

### Installation

1. Clone the repository:

```bash
git clone https://github.com/novincdavis123/FlutterAuth.git
cd flutterauth


2. Install dependencies:

flutter pub get


3. Run the app:

flutter run


### How It Works

Riverpod 3 NotifierProviders are used to manage state for:

Authentication (authProvider)

Registration form validation (registerFormProvider)

Password visibility toggles (registerPasswordVisibilityProvider and registerConfirmPasswordVisibilityProvider)

CustomTextfield is a reusable widget with:

Controller

Validator

Optional suffix icon for password visibility

Register/Login Buttons update their color and enabled state dynamically based on form validation, without extra Consumer widgets.