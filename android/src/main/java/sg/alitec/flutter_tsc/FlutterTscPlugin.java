package sg.alitec.flutter_tsc;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.example.tscdll.TscWifiActivity;

/** FlutterTscPlugin */
public class FlutterTscPlugin implements FlutterPlugin, MethodCallHandler {

  TscWifiActivity TscEthernetDll = new TscWifiActivity();

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_tsc");
    channel.setMethodCallHandler(new FlutterTscPlugin());
  }

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_tsc");
    channel.setMethodCallHandler(new FlutterTscPlugin());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("print")) {
      String ipAddress = call.argument("ipAddress");
      String label = call.argument("label");
      TscEthernetDll.openport(ipAddress,9100, 50);   	
	    TscEthernetDll.sendcommand("SIZE 75 mm, 50 mm\r\n");
	    TscEthernetDll.clearbuffer();
	    TscEthernetDll.sendcommand("SPEED 4\r\n");
	    TscEthernetDll.sendcommand("DENSITY 12\r\n");
	    TscEthernetDll.sendcommand("CODEPAGE UTF-8\r\n");
	    TscEthernetDll.sendcommand("SET TEAR ON\r\n");
	    TscEthernetDll.sendcommand("SET COUNTER @1 1\r\n");
	    TscEthernetDll.sendcommand("@1 = \"0001\"\r\n");
	    TscEthernetDll.sendcommand("TEXT 100,300,\"ROMAN.TTF\",0,12,12,@1\r\n");
	    TscEthernetDll.sendcommand("TEXT 100,400,\"ROMAN.TTF\",0,12,12,\"TEST FONT\"\r\n");
	    TscEthernetDll.barcode(100, 100, "128", 100, 1, 0, 3, 3, label);
	    TscEthernetDll.printerfont(100, 250, "3", 0, 1, 1, label);
	    TscEthernetDll.printlabel(1, 1);
	    TscEthernetDll.closeport();
      result.success("Success printing");
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }
}
