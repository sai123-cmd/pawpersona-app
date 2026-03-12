# PawPersona - 宠物AI智能穿戴项圈

A modern Flutter app template for pet wearable devices with BLE, UWB, and cloud integration.

## Features

- BLE device pairing
- Real-time GPS tracking
- UWB proximity detection
- Video streaming support
- Cloud API integration
- AI-powered vlog generation

## Project Structure

```
src/
├── cloud/          # Cloud backend (FastAPI)
├── embedded/       # Embedded firmware
└── flutter_app/   # Flutter mobile app
```

## Documentation

- [产品规格说明书](docs/SPEC.md)
- [开发计划](docs/DEVELOPMENT_PLAN.md)

## Getting Started

### Flutter App

```bash
cd src/flutter_app
flutter create paw_persona_app
cd paw_persona_app
flutter pub get
flutter run
```

### Cloud Backend

```bash
cd src/cloud/api
pip install -r requirements.txt
python main.py
```

## License

MIT
