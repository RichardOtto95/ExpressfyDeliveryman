import 'package:firebase_auth/firebase_auth.dart';

import '../../models/agent_model.dart';

abstract class AuthServiceInterface {
  Future<User> handleGetUser();
  Future handleSetSignout();
  Future<String> handleGetToken();
  Future<User> handleGoogleSignin();
  Future<User> handleLinkAccountGoogle(User user);
  Future handleFacebookSignin();
  Future handleSignup(Agent model);
  Future<User> handleEmailSignin(String userEmail, String userPassword);
  Future verifyNumber(String userPhone);
  Future handleSmsSignin(String smsCode, String verificationId);
}
