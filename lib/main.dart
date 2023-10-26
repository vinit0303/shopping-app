import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shopping_app/firebase_options.dart';
import 'package:shopping_app/views/splash%20screen/splash_screen.dart';
import 'const/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: darkFontGrey),
              elevation: 0.0),
          fontFamily: regular),
      home: const SplashSccreen(),
    );
  }
}
