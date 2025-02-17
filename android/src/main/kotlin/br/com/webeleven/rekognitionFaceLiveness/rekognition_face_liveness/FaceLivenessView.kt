package br.com.webeleven.rekognitionFaceLiveness.rekognition_face_liveness

import android.content.Context
import android.view.View
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.ComposeView
import androidx.lifecycle.setViewTreeLifecycleOwner
import com.amplifyframework.ui.liveness.model.FaceLivenessDetectionException
import com.amplifyframework.ui.liveness.ui.FaceLivenessDetector
import com.amplifyframework.ui.liveness.ui.LivenessColorScheme
import io.flutter.plugin.platform.PlatformView

internal class FaceLivenessView(context: Context, id: Int, creationParams: Map<String?, Any?>?, val handler: EventStreamHandler) : PlatformView {
    private val composeView: ComposeView = ComposeView(context)

    override fun getView(): View {
        return composeView
    }

    override fun dispose() {}

    init {
        composeView.setContent {
            MaterialTheme(
                colorScheme = lightColorScheme(
                    primary = Color(0xFFFFA500),
                    onPrimary = Color.White,
                    background = Color.White,
                    onBackground = Color(0xFF0D1926),
                    surface = Color.White,
                    onSurface = Color(0xFF0D1926),
                    error = Color(0xFF950404),
                    onError = Color.White,
                    errorContainer = Color(0xFFB8CEF9),
                    onErrorContainer = Color(0xFF002266)
                )
            ) {
                FaceLivenessDetector(
                    sessionId = creationParams?.get("sessionId") as String,
                    region = creationParams["region"] as String,
                    onComplete = {
                        handler.onComplete()
                    },
                    onError = { error ->
                        when (error) {
                            is FaceLivenessDetectionException.SessionNotFoundException -> {
                                handler.onError("sessionNotFound")
                            }
                            is FaceLivenessDetectionException.AccessDeniedException -> {
                                handler.onError("accessDenied")
                            }
                            is FaceLivenessDetectionException.CameraPermissionDeniedException -> {
                                handler.onError("cameraPermissionDenied")
                            }
                            is FaceLivenessDetectionException.SessionTimedOutException -> {
                                handler.onError("sessionTimedOut")
                            }
                            is FaceLivenessDetectionException.UserCancelledException -> {
                                handler.onError("userCancelled")
                            }
                            else -> {
                                handler.onError("error")
                            }
                        }
                    }
                )
            }
        }
    }
}