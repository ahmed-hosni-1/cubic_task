import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/services/api_response.dart';
import '../../entities/auth/branch_entities.dart';

abstract class AuthRepo{

  Future<ApiResponse<List<BranchEntities>>> getBranches();
  Future<ApiResponse<UserCredential>> signInWithApple();
  Future<ApiResponse<UserCredential>> signInWithGoogle();
}