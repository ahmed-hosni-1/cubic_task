import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/services/api_response.dart';

abstract class AuthDataSource {
  Future<Response> getBranches();
  Future<UserCredential?> signInWithApple();
  Future<UserCredential?> signInWithGoogle();
}