# Rekognition Face Liveness for Flutter

This package provides a **Flutter integration** for the **[Amplify Liveness](https://ui.docs.amplify.aws/swift/connected-components/liveness)** SDK, enabling biometric authentication with liveness verification in Flutter applications.

## 📦 Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  rekognition_face_liveness: ^1.0.0
```

Run:

```sh
flutter pub get
```

## ⚙️ Setup

Before using the package, you need to configure **Amplify** in your project. Follow these steps:

### 1️⃣ Set Up Amplify

Complete the **[Amplify Quickstart](https://ui.docs.amplify.aws/swift/connected-components/liveness#quick-start)** and **[Step 1: Configure Auth](https://ui.docs.amplify.aws/swift/connected-components/liveness#step-1-configure-auth)** before proceeding.

### 2️⃣ Configure Authentication

#### Android

1. Add the **Amplify configuration file** to your project:
    - Place `amplifyconfiguration.json` in `android/app/src/main/res/raw/`

2. Update `android/app/build.gradle`:

```gradle
android {
    compileSdkVersion 35

    defaultConfig {
        minSdkVersion 24
    }
}
```

3. Ensure that the `MainActivity` class extends `FlutterFragmentActivity` instead of `FlutterActivity`:

```kotlin
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity() {}
```

#### iOS

1. Add the **Amplify configuration files** to your project:
    - Place `amplifyconfiguration.json` and `awsconfiguration.json` in the `ios` directory.

2. Open **Xcode** and manually add these files to your project to ensure they are recognized.

3. Update your `ios/Podfile`:

```ruby
platform :ios, '13.0'
use_frameworks!
```

4. Run:

```sh
cd ios
pod install
cd ..
```

### 3️⃣ Grant Camera Permissions

Ensure you request **camera access** in both platforms:

#### Android

Add the following permission in `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA"/>
```

#### iOS

Add this to your `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>We need access to your camera for face liveness detection.</string>
```

## 🚀 Usage

Import the package:

```dart
import 'package:rekognition_face_liveness/face_liveness_detector.dart';
```

Start a liveness session:

```dart
FaceLivenessDetector(
  sessionId: 'fff3c26b-a372-446b-b017-fefb7965b5d4',
  region: 'us-east-1',
  onComplete: () {
    print('Face Liveness completed');
  },
  onError: (code) {
    print('Face Liveness error $code');
  },
);
```

## 📚 References

- [Amplify Liveness Documentation](https://ui.docs.amplify.aws/swift/connected-components/liveness)
- [Amplify Quickstart](https://ui.docs.amplify.aws/swift/connected-components/liveness#quick-start)
- [Amplify Auth Setup](https://ui.docs.amplify.aws/swift/connected-components/liveness#step-1-configure-auth)  
