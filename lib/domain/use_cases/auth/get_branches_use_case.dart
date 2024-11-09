import 'package:cubic_task/core/services/api_response.dart';
import 'package:cubic_task/domain/repositories/auth/auth_repo.dart';
import 'package:cubic_task/domain/entities/auth/branch_entities.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetBranchesUseCase {
  AuthRepo authRepo;

  GetBranchesUseCase({required this.authRepo});

  Future<ApiResponse<List<BranchEntities>>> call()async {
    return await authRepo.getBranches();
}}