import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: OnboardingSignInButton(
                rightPadding: 75,
                text: "Continue with Google",
                onTab: () {
                  try {
                    signInWithGoogle().then((value) {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const Home()));
                    });
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                icon: "assets/images/google.svg",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) {
      throw Exception("User denied sign in");
    }

    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class OnboardingSignInButton extends StatelessWidget {
  final double rightPadding;
  final String text;
  final String? icon;
  final VoidCallback onTab;

  const OnboardingSignInButton({
    super.key,
    required this.text,
    required this.rightPadding,
    this.icon,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTab,
        child: Material(
          color: Colors.blue,
          elevation: 10,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: 286,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon == null
                    ? const SizedBox(width: 0)
                    : Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: SvgPicture.asset(
                              icon!,
                              height: 13.33,
                              width: 10.37,
                              fit: BoxFit.contain,
                            ),
                          ),
                          // SizedBox(
                          //   width: 40.sp,
                          // ),
                        ],
                      ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(right: rightPadding),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
