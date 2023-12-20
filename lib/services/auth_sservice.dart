import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String phoneNumber, String password) async {
    try {
      // Create the user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send OTP to the user's phone number and return verificationId
      String verificationId = await sendOtp(phoneNumber);

      return userCredential;
    } catch (e) {
      print("Error signing up: $e");
      rethrow;
    }
  }

  Future<String> sendOtp(String phoneNumber) async {
    try {
      String verificationId = "";

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // This callback will be invoked if the auto-detection is successful.
          // You can use credential.verificationId here.
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          print("Error sending OTP: $e");
        },
        codeSent: (String id, int? resendToken) {
          // Save the verificationId and use it when needed.
          verificationId = id;
          print('Verification ID: $verificationId');
        },
        codeAutoRetrievalTimeout: (String id) {
          // Save the verificationId and use it when needed.
          verificationId = id;
          print('Verification ID: $verificationId');
        },
      );

      return verificationId;
    } catch (e) {
      print("Error sending OTP: $e");
      rethrow;
    }
  }

  Future<void> updatePhoneNumberWithOtp(String verificationId, String smsCode) async {
    try {
      // Use the verification ID and SMS code obtained during phone number verification
      await _auth.currentUser?.updatePhoneNumber(PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      ));
    } catch (e) {
      print("Error updating phone number: $e");
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error during logout: $e");
      rethrow;
    }
  }
}