import 'package:flutter_test/flutter_test.dart';
import 'package:rekognition_face_liveness/rekognition_face_liveness.dart';
import 'package:rekognition_face_liveness/rekognition_face_liveness_platform_interface.dart';
import 'package:rekognition_face_liveness/rekognition_face_liveness_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRekognitionFaceLivenessPlatform
    with MockPlatformInterfaceMixin
    implements RekognitionFaceLivenessPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final RekognitionFaceLivenessPlatform initialPlatform = RekognitionFaceLivenessPlatform.instance;

  test('$MethodChannelRekognitionFaceLiveness is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRekognitionFaceLiveness>());
  });

  test('getPlatformVersion', () async {
    RekognitionFaceLiveness rekognitionFaceLivenessPlugin = RekognitionFaceLiveness();
    MockRekognitionFaceLivenessPlatform fakePlatform = MockRekognitionFaceLivenessPlatform();
    RekognitionFaceLivenessPlatform.instance = fakePlatform;

    expect(await rekognitionFaceLivenessPlugin.getPlatformVersion(), '42');
  });
}
