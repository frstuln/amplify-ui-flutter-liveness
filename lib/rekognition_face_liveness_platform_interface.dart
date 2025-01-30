import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'rekognition_face_liveness_method_channel.dart';

abstract class RekognitionFaceLivenessPlatform extends PlatformInterface {
  /// Constructs a RekognitionFaceLivenessPlatform.
  RekognitionFaceLivenessPlatform() : super(token: _token);

  static final Object _token = Object();

  static RekognitionFaceLivenessPlatform _instance = MethodChannelRekognitionFaceLiveness();

  /// The default instance of [RekognitionFaceLivenessPlatform] to use.
  ///
  /// Defaults to [MethodChannelRekognitionFaceLiveness].
  static RekognitionFaceLivenessPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RekognitionFaceLivenessPlatform] when
  /// they register themselves.
  static set instance(RekognitionFaceLivenessPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
