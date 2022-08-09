import 'package:firebase_auth/firebase_auth.dart';
import 'package:gasvigil/App/Utils/Routes/app_pages.dart';
import 'package:gasvigil/App/Utils/common_function.dart';
import 'package:gasvigil/App/Utils/pref_utils.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var gooleSignin = GoogleSignIn();
  signinWithGoogle() async {
    CustomDialogs.getInstance.showProgressDialog();

    final googleAccount = await gooleSignin.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          final authResult = await auth
              .signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          )
              .then(
            (value) {
              PrefUtils.getInstance.writeData(
                PrefUtils.getInstance.isUserLoginKey,
                true,
              );
              PrefUtils.getInstance.writeData(
                PrefUtils.getInstance.userInfo,
                {
                  "name": value.user!.displayName,
                  "email": value.user!.email,
                  "photo": value.user!.photoURL,
                  "phoneNumber": value.user!.phoneNumber,
                },
              );
              print(PrefUtils.getInstance
                  .readData(PrefUtils.getInstance.userInfo));
              Get.offAllNamed(
                Routes.dashBoardScreen,
              );
            },
          );
        } catch (e) {
          print(e.toString());
        }
      } else {
        print('show here data screenn');
      }
    } else {
      CustomDialogs.getInstance.hideProgressDialog();
    }
  }
}
