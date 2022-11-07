# startup_namer

[codelabs](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1/?hl=ja#0)を参考にしたflutter学習用プロジェクト

## 開発環境
- [Dart 2.18.4(stable)](https://dart.dev/guides/whats-new#august-30-2022-218-release)
- [Any editor which Flutter plugin is available on](https://flutter.dev/docs/get-started/editor)
- [Android Studio Chipmunk 2021.3.1](https://developer.android.com/studio/)

## セットアップ方法

<details>
<summary>Steps</summary>

1. Install [Dart](https://dart.dev/)
    - Follow the instruction described at [Get the Dart SDK](https://dart.dev/get-dart)
    - If you're on macOS, you can install Dart with [Homebrew](https://brew.sh/)
      ```
      brew tap dart-lang/dart
      brew install dart
      ```
2. Install [fvm](https://github.com/leoafarias/fvm)
   ```
   dart pub global activate fvm
   ```
3. Install Flutter
   ```
   fvm install
   ```
4. Install Dart packages
   ```
   fvm flutter pub get
   ```
</details>