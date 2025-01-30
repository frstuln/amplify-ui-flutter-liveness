import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'rekognition_face_liveness_platform_interface.dart';

/// An implementation of [RekognitionFaceLivenessPlatform] that uses method channels.
class MethodChannelRekognitionFaceLiveness extends RekognitionFaceLivenessPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('rekognition_face_liveness');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
