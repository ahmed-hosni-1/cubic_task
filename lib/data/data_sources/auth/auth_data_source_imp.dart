import 'package:cubic_task/core/services/api_response.dart';
import 'package:cubic_task/core/services/web_service.dart';
import 'package:cubic_task/core/widgets/custom_text_form_field.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/utils/keys.dart';
import 'auth_data_source.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImp implements AuthDataSource {
  WebService webService;
  AuthDataSourceImp(this.webService);

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:AppKeys.instance.clientId,
  );
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Response> getBranches() {
    return webService.dio.get('/api/getBranches');
  }

  @override
  Future<UserCredential?> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );
    if (oauthCredential.accessToken == null ||
        oauthCredential.idToken == null) {
      return null;
    }

    final userCredential =
        await _firebaseAuth.signInWithCredential(oauthCredential);

    return userCredential.user == null || userCredential.user?.email == null
        ? null
        : userCredential;
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    return userCredential.user == null || userCredential.user?.email == null
        ? null
        : userCredential;
  }
}
