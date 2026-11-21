# COLOR GATE

COLOR GATE is a Flutter color puzzle game. This update is based on the repository's `main` branch.

## Updated in version 1.1.0

- Home dashboard with bottom navigation: Home, Levels, Profile and Settings.
- Drag the glowing ball with your finger through one of three colored lanes and release at the matching gate.
- Countdown timer, pause/resume and Game Over/retry flow.
- Level patterns grow in length and the time allowance tightens as levels increase.
- Animated ball pulse and lane effects.
- Sound effects use the existing files in `assets/sounds/`.
- Settings persist sound, vibration and reduced-motion preferences.
- How to Play, WhatsApp sharing and native Share action.
- Existing profile, level map, rewards and theme store screens are retained.

## Run locally

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Build Android APK

```bash
flutter build apk --release
```

APK output: `build/app/outputs/flutter-apk/app-release.apk`.

## Notes

The source ZIP does not contain a built APK. Build and device testing must be performed on a machine with Flutter/Android SDK installed. `share_plus`, `url_launcher` and `audioplayers` are declared in `pubspec.yaml`; run `flutter pub get` before building.
