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
      String lot = call.argument("lot");
      String product = call.argument("product");
      String number = call.argument("number");
      String demand = call.argument("demand");
      String uom = call.argument("uom");
      String received = call.argument("received");
      String poNum = call.argument("origin");
      String vendor = call.argument("contact");
      String expiryDate = call.argument("expiryDate");
      String currentDate = call.argument("currentDate");
      String location = call.argument("location");
      String staffId = call.argument("staffId") == null ? '' : call.argument("staffId") ;
      String productCode = call.argument("productCode") == null ? '' : call.argument("productCode");

      int num = Integer.parseInt(number);
      String uomString = received + "/" + demand + " " + uom;
      String poString = poNum + "(" + vendor + ")";
      String expString = "EXP: " + expiryDate;

      TscEthernetDll.openport(ipAddress,9100, 50);   	
      TscEthernetDll.setup(76, 25, 4, 12, 0, 3, 0);
      TscEthernetDll.clearbuffer();
      TscEthernetDll.sendcommand("DIRECTION 1\n");
      TscEthernetDll.sendcommand("SET COUNTER @1 1\n"); 
      TscEthernetDll.sendcommand("@1 = \"1\"\n"); 
      TscEthernetDll.barcode(16, 0, "128", 46, 3, 0, 2, 2,lot);
      TscEthernetDll.printerfont(328, 8, "3", 0, 1, 1, "Sea Bulk");
      TscEthernetDll.printerfont(552, 16, "3", 0, 1, 1, staffId);
      TscEthernetDll.printerfont(14, 80, "2", 0, 1, 1, product);
      TscEthernetDll.printerfont(328, 80, "2", 0, 1, 1, productCode);
      TscEthernetDll.printerfont(14, 104, "2", 0, 1, 1, uomString);
      TscEthernetDll.printerfont(328, 104, "2", 0, 1, 1, poString);
      TscEthernetDll.printerfont(14, 128, "2", 0, 1, 1, expString);
      TscEthernetDll.printerfont(328, 128, "2", 0, 1, 1, currentDate);
      TscEthernetDll.sendcommand("TEXT -14,-160,\"3\",0,1,1,@1\n");
      TscEthernetDll.printerfont(96, 160, "2", 0, 1, 1, "of");
      TscEthernetDll.printerfont(128, 160, "3", 0, 1, 1, number);
      TscEthernetDll.printerfont(256, 160, "4", 0, 1, 1, "INBOUND");
      TscEthernetDll.printerfont(462, 160, "3", 0, 1, 1, location);
	    TscEthernetDll.printlabel(num, 1);
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
