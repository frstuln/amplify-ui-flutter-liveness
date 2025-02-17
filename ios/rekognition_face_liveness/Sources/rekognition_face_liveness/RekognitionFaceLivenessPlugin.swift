import Flutter
import UIKit
import Amplify
import AWSCognitoAuthPlugin


public class RekognitionFaceLivenessPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let handler = EventStreamHadler()
        let eventChannel = FlutterEventChannel(name: "face_liveness_event", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(handler)
        
        let instance = RekognitionFaceLivenessPlugin()
        let factory = FaceLivenessViewFactory(messenger: registrar.messenger(), handler: handler)
        registrar.register(factory, withId: "face_liveness_view")
        
        do {
            Amplify.Logging.logLevel = .verbose
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
        } catch {
            print("Unable to configure Amplify \(error)")
        }
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(FlutterMethodNotImplemented)
    }
}

class EventStreamHadler: NSObject, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?
    
    func onComplete() {
        guard let eventSink = eventSink else {
            return
        }
        eventSink("complete")
    }
    
    func onError(code: String) {
        guard let eventSink = eventSink else {
            return
        }
        eventSink(code)
    }
    
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}
