import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FaceLivenessDetector extends StatefulWidget {
  final String sessionId;
  final String region;
  final VoidCallback? onComplete;
  final VoidCallback? onError;

  const FaceLivenessDetector({
    super.key,
    required this.sessionId,
    required this.region,
    this.onComplete,
    this.onError,
  });

  @override
  State<FaceLivenessDetector> createState() => _FaceLivenessDetectorState();
}

class _FaceLivenessDetectorState extends State<FaceLivenessDetector> {
  final _eventChannel = EventChannel('rekognition_face_liveness_event');

  @override
  void initState() {
    super.initState();
    _eventChannel.receiveBroadcastStream().listen((event) {
      if (event == 'complete') {
        widget.onComplete?.call();
      } else if (event == 'error') {
        widget.onError?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: 'face_liveness_view',
      layoutDirection: TextDirection.ltr,
      creationParams: {'sessionId': widget.sessionId, 'region': widget.region},
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
