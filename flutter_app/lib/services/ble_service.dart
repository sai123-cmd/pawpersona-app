// PawPersona BLE Service
// BLE device pairing and communication service

import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rxdart/rxdart.dart';

/// BLE connection states
enum BleConnectionState {
  disconnected,
  scanning,
  connecting,
  connected,
  disconnecting,
}

/// BLE pairing states
enum BlePairingState {
  idle,
  scanning,
  connecting,
  authenticating,
  configuring,
  completed,
  failed,
}

/// BLE device model
class BleDeviceModel {
  final String id;
  final String name;
  final int rssi;
  final BluetoothDevice device;

  BleDeviceModel({
    required this.id,
    required this.name,
    required this.rssi,
    required this.device,
  });
}

/// BLE Service for device pairing
class BleService {
  // State streams
  final _connectionState = BehaviorSubject<BleConnectionState>.seeded(
    BleConnectionState.disconnected,
  );
  final _pairingState = BehaviorSubject<BlePairingState>.seeded(
    BlePairingState.idle,
  );
  final _scannedDevices = BehaviorSubject<List<BleDeviceModel>>.seeded([]);
  
  Stream<BleConnectionState> get connectionState => _connectionState.stream;
  Stream<BlePairingState> get pairingState => _pairingState.stream;
  Stream<List<BleDeviceModel>> get scannedDevices => _scannedDevices.stream;
  
  BluetoothDevice? _connectedDevice;
  
  /// Service UUID for PawPersona device
  static const String serviceUuid = "0000FEEO-0000-1000-8000-00805F9B34FB";
  static const String dataCharUuid = "0000FFE1-0000-1000-8000-00805F9B34FB";
  static const String configCharUuid = "0000FFE2-0000-1000-8000-00805F9B34FB";

  /// Start scanning for devices
  Future<void> startScan({Duration timeout = const Duration(seconds: 10)}) async {
    _pairingState.add(BlePairingState.scanning);
    _scannedDevices.add([]);
    
    try {
      await FlutterBluePlus.startScan(
        timeout: timeout,
        withServices: [Guid(serviceUuid)],
      );
      
      FlutterBluePlus.scanResults.listen((results) {
        final devices = results
            .where((r) => r.device.platformName.isNotEmpty)
            .map((r) => BleDeviceModel(
                  id: r.device.remoteId.str,
                  name: r.device.platformName,
                  rssi: r.rssi,
                  device: r.device,
                ))
            .toList();
        
        devices.sort((a, b) => b.rssi.compareTo(a.rssi));
        _scannedDevices.add(devices);
      });
    } catch (e) {
      _pairingState.add(BlePairingState.failed);
      rethrow;
    }
  }

  /// Stop scanning
  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
  }

  /// Connect to device
  Future<void> connect(BleDeviceModel device) async {
    _pairingState.add(BlePairingState.connecting);
    _connectionState.add(BleConnectionState.connecting);
    
    try {
      await device.device.connect(
        timeout: const Duration(seconds: 15),
        autoConnect: false,
      );
      
      _connectedDevice = device.device;
      _connectionState.add(BleConnectionState.connected);
    } catch (e) {
      _pairingState.add(BlePairingState.failed);
      _connectionState.add(BleConnectionState.disconnected);
      rethrow;
    }
  }

  /// Authenticate device
  Future<bool> authenticate(String password) async {
    _pairingState.add(BlePairingState.authenticating);
    // Implementation: send auth command via BLE
    return true;
  }

  /// Configure WiFi
  Future<bool> configureWiFi(String ssid, String password) async {
    _pairingState.add(BlePairingState.configuring);
    // Implementation: send WiFi config via BLE
    return true;
  }

  /// Disconnect
  Future<void> disconnect() async {
    _connectionState.add(BleConnectionState.disconnecting);
    await _connectedDevice?.disconnect();
    _connectionState.add(BleConnectionState.disconnected);
  }

  /// Dispose resources
  void dispose() {
    _connectionState.close();
    _pairingState.close();
    _scannedDevices.close();
  }
}
