import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../core/services/api_response.dart';
import '../../repositories/auth/auth_repo.dart';
@injectable
class SignInWithGoogleUseCase{
 final AuthRepo authRepo;

  SignInWithGoogleUseCase(this.authRepo);

  Future<ApiResponse<UserCredential>> call()async{
    return await authRepo.signInWithGoogle();
  }

}