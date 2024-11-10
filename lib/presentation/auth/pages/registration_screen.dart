import 'package:animate_do/animate_do.dart';
import 'package:cubic_task/core/config/di/di.dart';
import 'package:cubic_task/core/extensions/context.dart';
import 'package:cubic_task/core/utils/app_regexp.dart';
import 'package:cubic_task/presentation/auth/widgets/change_langeage_widgte.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/app_assets/svg_assets.dart';
import '../../../core/config/page_routes_name.dart';
import '../../../domain/entities/auth/branch_entities.dart';
import '../manager/auth_cubit.dart';
import '../widgets/custom_auth_field.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  AuthCubit authCubit = getIt<AuthCubit>();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocProvider(
      create: (context) => authCubit..getBranches(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          var authCubit = context.read<AuthCubit>();
          if (state is GetBranchesStateSuccess) {
            authCubit.getBranchesFiltered();
          }
          if (state is RegisterSuccessState) {
            Toastification().show(
              context: context,
              type: ToastificationType.success,
              applyBlurEffect: false,
              alignment: Alignment.topCenter,
              backgroundColor: theme.scaffoldBackgroundColor,
              autoCloseDuration: const Duration(seconds: 2),
              title:
                  Text("auth.success".tr(), style: theme.textTheme.bodyMedium),
            );
            Navigator.pushReplacementNamed(context, PageRoutesName.mapScreen,
                arguments: authCubit.branchesFiltered.toList());
          }
          if (state is RegisterFailedState ||
              state is AuthWithAppleFailedState ||
              state is AuthWithGoogleFailedState) {
            Toastification().show(
              context: context,
              type: ToastificationType.error,
              applyBlurEffect: false,
              alignment: Alignment.topCenter,
              backgroundColor: theme.scaffoldBackgroundColor,
              autoCloseDuration: const Duration(seconds: 2),
              title:
                  Text(state.message ?? "", style: theme.textTheme.bodyMedium),
            );
          }
        },
        builder: (context, state) {
          var cubit = context.watch<AuthCubit>();
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: cubit.formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInDown(
                        child: Center(
                          child: SvgPicture.asset(
                            SvgAssets.instance.logo,
                            colorFilter: ColorFilter.mode(
                                theme.primaryColor, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Text(
                          "auth.registration".tr(),
                          style: theme.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomAuthField(
                        autovalidateMode: state is RegisterFailedState
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        title: "auth.name".tr(),
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              value.length > 3 &&
                              AppRegExp.instance.name.hasMatch(value)) {
                            return null;
                          }
                          return 'auth.invalid_name'.tr();
                        },
                        hintText: 'auth.hint_name'.tr(),
                        suffixIcon: const Icon(Icons.person),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomAuthField(
                        title: "auth.email".tr(),
                        autovalidateMode: state is RegisterFailedState
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              value.length > 3 &&
                              AppRegExp.instance.email.hasMatch(value)) {
                            return null;
                          }
                          return 'auth.invalid_email'.tr();
                        },
                        hintText: 'auth.hint_email'.tr(),
                        suffixIcon: const Icon(Icons.email_outlined),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomAuthField(
                        autovalidateMode: state is RegisterFailedState
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        title: "auth.phone".tr(),
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              value.length > 3 &&
                              AppRegExp.instance.phone.hasMatch(value)) {
                            return null;
                          }
                          return 'auth.invalid_phone'.tr();
                        },
                        hintText: 'auth.hint_phone'.tr(),
                        suffixIcon: const Icon(Icons.phone),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "auth.favorite".tr(),
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: theme.primaryColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownButton(
                              borderRadius: BorderRadius.circular(14),
                              isExpanded: true,
                              menuMaxHeight: context.height * 0.5,
                              underline: const SizedBox.shrink(),
                              style: theme.textTheme.bodyMedium,
                              hint: Text(
                                "auth.select_branch".tr(),
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: Colors.black54,
                                ),
                              ),
                              items: cubit.branches.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Row(
                                    children: [
                                      Text(e.branchName),
                                      const Spacer(),

                                      /// to indicate that the branch has location
                                      /// to enhance the user experience by making
                                      /// for users to know that the branch has location
                                      if (e.branchLat != null &&
                                          e.branchLng != null)
                                        Icon(
                                          Icons.location_on_rounded,
                                          color: theme.primaryColor,
                                        )
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                cubit.selectBranch(value as BranchEntities);
                              },
                              value: cubit.selectedBranch,
                            ),
                            if (state is GetBranchesStateLoading)
                              const Center(
                                child: LinearProgressIndicator(),
                              ),
                            if (state is GetBranchesStateFailed)
                              Text(
                                "auth.branches_not_available".tr(),
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(color: Colors.red),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                textStyle: WidgetStatePropertyAll(
                                  theme.textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                padding: const WidgetStatePropertyAll(
                                    EdgeInsets.all(6)),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                cubit.register();
                              },
                              child: Text("auth.register".tr()),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                cubit.signInWithApple();
                              },
                              child: SvgPicture.asset(
                                SvgAssets.instance.apple,
                                width: 50,
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                cubit.signInWithGoogle();
                              },
                              child: SvgPicture.asset(
                                SvgAssets.instance.google,
                                width: 44,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 18,
                      ),
                      const ChangeLanguageWidget()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
