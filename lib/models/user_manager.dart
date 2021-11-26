import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/helpers/firebase_errors.dart';
import 'package:loja_virtual/models/user.dart';

class UserManager extends ChangeNotifier{

 final FirebaseAuth auth = FirebaseAuth.instance;

 bool _loading = false;
 bool get loading => _loading;

 Future<void> signIn({UserAuth? user, Function? onFail, Function? onSuccess}) async {
   loading = true;
  try {
       final UserCredential credential = await auth.signInWithEmailAndPassword(
           email: user!.email, password: user.password);
       onSuccess!();
     } on FirebaseAuthException catch (e){
       onFail!(getErrorString(e.code));
     }

   loading = false;
   }

set loading(bool value){
   _loading = value;
   notifyListeners();
}

}