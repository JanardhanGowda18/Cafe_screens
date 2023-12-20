import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../helpers/helpers.dart';
import '../../screens/detail/widget/success_page.dart';
import '../../screens/home/home.dart';

class LoginController {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _cardSlideAnimation;
  late Animation<Offset> _imageSlideAnimation;

  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginController(TickerProvider vsync) {
    _controller = AnimationController(
      vsync: vsync,
      duration: Duration(seconds: 1),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _cardSlideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _imageSlideAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  Animation<double> getOpacityAnimation() => _opacityAnimation;

  Animation<Offset> getCardSlideAnimation() => _cardSlideAnimation;

  Animation<Offset> getImageSlideAnimation() => _imageSlideAnimation;

  Future<void> loginUser(BuildContext context) async {
    try {
      showLoader(context);

      final String emailOrPhone = emailOrPhoneController.text.trim();
      final String password = passwordController.text;

      // Check if the input is an email or a phone number
      if (emailOrPhone.contains('@')) {
        // It's an email
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailOrPhone,
          password: password,
        );
      } else {
        // It's a phone number
        // Send verification code
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: emailOrPhone,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            print('Verification Failed: $e');
            hideLoader(context);
            showErrorSnackBar(context, 'Invalid phone number');
          },
          codeSent: (String verificationId, int? resendToken) {
            // Navigate to the verification code input screen
            // You might want to replace the next line with the appropriate navigation logic
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => VerificationCodeScreen(verificationId)),
            // );
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            // The SMS code will be sent, and it will auto-retrieve. You can handle this if needed.
          },
        );
      }

      hideLoader(context);
      print('User signed in successfully');

      // Navigate to the home page or any other desired screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SuccessPage()),
      );
    } catch (e) {
      hideLoader(context);
      print('Error signing in: $e');
      showErrorSnackBar(context, 'Invalid email, phone number, or password');
    }
  }


  void showLoader(BuildContext context) {
    // Implement your loading indicator show logic here
  }

  void hideLoader(BuildContext context) {
    // Implement your loading indicator hide logic here
  }

  void dispose() {
    _controller.dispose();
  }
}