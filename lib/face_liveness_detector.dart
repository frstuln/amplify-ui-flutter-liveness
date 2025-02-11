import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FaceLivenessDetector extends StatefulWidget {
  final String sessionId;
  final String region;
  final VoidCallback? onComplete;
  final ValueChanged<String>? onError;

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
  final _eventChannel = EventChannel('face_liveness_event');

  @override
  void initState() {
    super.initState();
    _eventChannel.receiveBroadcastStream().listen((event) {
      if (event == 'complete') {
        widget.onComplete?.call();
      } else {
        widget.onError?.call(event);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return const SizedBox();

    if (Platform.isIOS) {
      return UiKitView(
        viewType: 'face_liveness_view',
        layoutDirection: TextDirection.ltr,
        creationParams: {
          'sessionId': widget.sessionId,
          'region': widget.region
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return AndroidView(
      viewType: 'face_liveness_view',
      layoutDirection: TextDirection.ltr,
      creationParams: {'sessionId': widget.sessionId, 'region': widget.region},
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
