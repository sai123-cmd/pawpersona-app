# PawPersona Flutter App Scaffold

A modern Flutter app template for pet wearable devices with BLE, UWB, and cloud integration.

## Features

- BLE device pairing
- Real-time GPS tracking
- UWB proximity detection
- Video streaming support
- Cloud API integration

## Getting Started

```bash
flutter create paw_persona_app
cd paw_persona_app
flutter pub get
flutter run
```

## Architecture

```
lib/
├── features/
│   ├── home/
│   ├── diary/
│   ├── finder/
│   └── social/
├── core/
│   ├── ble/
│   ├── uwb/
│   └── api/
└── widgets/
```

## License

MIT
