
import 'rekognition_face_liveness_platform_interface.dart';

class RekognitionFaceLiveness {
  Future<String?> getPlatformVersion() {
    return RekognitionFaceLivenessPlatform.instance.getPlatformVersion();
  }
}
