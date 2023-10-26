import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopping_app/const/consts.dart';
import 'package:shopping_app/views/Home%20screen/home.dart';
import 'package:shopping_app/views/auth%20screen/login_screen.dart';
import 'package:shopping_app/widgets/applogo_widget.dart';

class SplashSccreen extends StatefulWidget {
  const SplashSccreen({super.key});

  @override
  State<SplashSccreen> createState() => _SplashSccreenState();
}

class _SplashSccreenState extends State<SplashSccreen> {


changeScreen(){
  Future.delayed(const Duration(seconds: 2),(){
    // Get.to(()=> const LoginScreen());
    auth.authStateChanges().listen((User? user) {
      if(user == null && mounted){
        Get.to(()=>const LoginScreen());
      }else{
        Get.to(()=>const Home());
      }
    });
  });
}

@override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(alignment: Alignment.topLeft,  child: Image.asset(icSplashBg,width: 300,)),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox
          ],
        ),
      ),
    );
  }
}
