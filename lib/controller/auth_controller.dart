import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopping_app/const/consts.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future<UserCredential?>loginMethod({context})async{
    UserCredential? userCredential;

  try{
    await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
  }on FirebaseAuthException catch(error){
    VxToast.show(context, msg: error.toString());
  }
  return userCredential;
  }

  Future<UserCredential?>signUpMethod({email,password,context})async{
    UserCredential? userCredential;

  try{
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }on FirebaseAuthException catch(error){
    VxToast.show(context, msg: error.toString());
  }
  return userCredential;
  }

  storeUserData({name,password,email})async{
    DocumentReference store= firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id':currentUser!.uid,
      'cart_count':"00",
      'order_count': "00",
      'wishList_count': "00",
    });
  }

  signoutMethod(context)async{
    try{
      await auth.signOut();
    }catch (error){
      VxToast.show(context, msg: error.toString());
    }
  }

}

