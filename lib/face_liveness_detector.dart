import 'dart:async';
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
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _eventChannel.receiveBroadcastStream().listen((event) {
      print('Face Liveness event: $event');
      if (event == 'complete') {
        widget.onComplete?.call();
      } else if (event == 'error') {
        widget.onError?.call(event.toString());
      } else {
        // Log other events for debugging
        print('Face Liveness unknown event: $event');
      }
    }, onError: (error) {
      print('Face Liveness stream error: $error');
      widget.onError?.call(error.toString());
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
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
    } else if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'face_liveness_view',
        layoutDirection: TextDirection.ltr,
        creationParams: {
          'sessionId': widget.sessionId,
          'region': widget.region
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else {
      return const Center(child: Text('Unsupported platform'));
    }
  }
}
