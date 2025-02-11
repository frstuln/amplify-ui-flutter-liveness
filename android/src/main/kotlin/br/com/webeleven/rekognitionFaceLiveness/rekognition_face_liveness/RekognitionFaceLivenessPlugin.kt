package br.com.webeleven.rekognitionFaceLiveness.rekognition_face_liveness

import androidx.annotation.NonNull
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.core.Amplify

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** RekognitionFaceLivenessPlugin */
class RekognitionFaceLivenessPlugin: FlutterPlugin {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var eventChannel : EventChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val handler = EventStreamHandler()
    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "rekognition_face_liveness_event")
    eventChannel.setStreamHandler(handler)

    flutterPluginBinding
      .platformViewRegistry
      .registerViewFactory("face_liveness_view", FaceLivenessViewFactory(handler))

    Amplify.addPlugin(AWSCognitoAuthPlugin())
    Amplify.configure(flutterPluginBinding.applicationContext)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
  }
}

class EventStreamHandler: EventChannel.StreamHandler {
  private var eventSink: EventChannel.EventSink? = null

  fun onComplete() {
    eventSink?.success("complete")
  }

  fun onError(code: String) {
    eventSink?.success(code)
  }

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    eventSink = events
  }

  override fun onCancel(arguments: Any?) {
    eventSink = null
  }
}