import 'package:bloc/bloc.dart';
import 'package:cubic_task/domain/use_cases/auth/get_branches_use_case.dart';
import 'package:cubic_task/domain/use_cases/auth/sign_in_with_apple_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/services/api_response.dart';
import '../../../domain/entities/auth/branch_entities.dart';
import '../../../domain/use_cases/auth/sign_in_with_google_use_case.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._branchesUseCase, this._signInWithAppleUseCase,
      this._signInWithGoogleUseCase)
      : super(AuthInitial());
  final GetBranchesUseCase _branchesUseCase;
  final SignInWithAppleUseCase _signInWithAppleUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  static AuthCubit get(context) => BlocProvider.of(context);

  BranchEntities? selectedBranch;
  List<BranchEntities> branches = [];
  Set<BranchEntities> branchesFiltered = {};
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> getBranches() async {
    emit(GetBranchesStateLoading());
    final response = await _branchesUseCase.call();
    switch (response) {
      case Success():
        {
          response.data;
          branches = response.data;
          emit(GetBranchesStateSuccess(response.data));
          break;
        }
      case Error():
        {
          emit(GetBranchesStateFailed(response.message));
        }
    }
  }

  void register() async {
    if (!formKey.currentState!.validate()) {
      emit(RegisterFailedState("auth.all_fields_required".tr()));
    } else if (selectedBranch == null) {
      emit(RegisterFailedState('auth.select_branch_error'.tr()));
    } else {
      emit(RegisterSuccessState());
    }
  }

  Future<void> signInWithGoogle() async {
    if (selectedBranch == null) {
      emit(AuthWithGoogleFailedState('auth.select_branch_error'.tr()));
      return;
    }
    emit(AuthWithGoogleLoadingState());
    ApiResponse<UserCredential> response =
        await _signInWithGoogleUseCase.call();
    switch (response) {
      case Success():
        {
          response.data;
          emit(RegisterSuccessState());
          break;
        }
      case Error():
        {
          debugPrint(response.message);
          emit(AuthWithGoogleFailedState(response.message));
        }
    }
  }

  Future<void> signInWithApple() async {
    if (selectedBranch == null) {
      emit(AuthWithAppleFailedState('auth.select_branch_error'.tr()));
      return;
    }
    emit(AuthWithAppleLoadingState());
    ApiResponse<UserCredential> response = await _signInWithAppleUseCase.call();
    switch (response) {
      case Success():
        {
          response.data;
          emit(AuthWithAppleSuccessState(response.data));
          break;
        }
      case Error():
        {
          emit(AuthWithAppleFailedState(response.message));
        }
    }
  }

  selectBranch(BranchEntities branch) {
    selectedBranch = branch;
    emit(SelectBranchState());
  }
}
