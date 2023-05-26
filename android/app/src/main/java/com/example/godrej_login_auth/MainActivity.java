

package com.example.godrej_login_auth;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "your.channel.name";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        // Register the method channel
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                        if (call.method.equals("scanBarcode")) {
                            // Add code to invoke your device's scanner here
                            // Set the result value based on the scan result
                            // You can use any method to communicate the scan result back to the Flutter code (e.g., result.success(scanResult))
                        } else {
                            result.notImplemented();
                        }
                    }
                }
        );
    }
}


//package com.example.godrej_login_auth;
//import io.flutter.embedding.android.FlutterActivity;



//public class MainActivity extends FlutterActivity {
//}
