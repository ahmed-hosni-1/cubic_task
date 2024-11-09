import 'package:cubic_task/core/services/api_response.dart';
import 'package:cubic_task/data/data_sources/auth/auth_data_source.dart';
import 'package:cubic_task/domain/entities/auth/branch_entities.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../models/auth/branch_model.dart';
import '../../../domain/repositories/auth/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImp implements AuthRepo {
  AuthDataSource authDataSource;
  AuthRepoImp({required this.authDataSource});
  @override
  Future<ApiResponse<List<BranchEntities>>> getBranches() async {
    try {
      var response = await authDataSource.getBranches();
      if (response.statusCode == 200) {
        BranchModel result = BranchModel.fromJson(response.data);
        return Success<List<BranchEntities>>(result.result ?? []);
      } else {
        return Error<List<BranchEntities>>(response.data['message']);
      }
    } catch (e) {
      return Error<List<BranchEntities>>(e.toString());
    }
  }

  @override
  Future<ApiResponse<UserCredential>> signInWithApple() async {
    try {
      var response = await authDataSource.signInWithApple();
      if (response != null) {
        return Success<UserCredential>(response);
      } else {
        return Error<UserCredential>("auth.signInWithAppleError".tr());
      }
    } catch (e) {
      return Error<UserCredential>(e.toString());
    }
  }

  @override
  Future<ApiResponse<UserCredential>> signInWithGoogle()async {
    try {
      var response = await authDataSource.signInWithGoogle();
      if (response != null) {
        return Success<UserCredential>(response);
      } else {
        return Error<UserCredential>("auth.signInWithGoogleError".tr());
      }
    } catch (e) {
      return Error<UserCredential>(e.toString());
    }
  }
}
