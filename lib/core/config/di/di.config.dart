// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../data/data_sources/auth/auth_data_source.dart' as _i1050;
import '../../../data/data_sources/auth/auth_data_source_imp.dart' as _i1024;
import '../../../domain/repositories/auth/auth_repo.dart' as _i736;
import '../../../data/repositories/auth/auth_repo_imp.dart' as _i990;
import '../../../domain/use_cases/auth/get_branches_use_case.dart' as _i317;
import '../../../domain/use_cases/auth/sign_in_with_apple_use_case.dart'
    as _i300;
import '../../../domain/use_cases/auth/sign_in_with_google_use_case.dart'
    as _i652;
import '../../../presentation/auth/manager/auth_cubit.dart' as _i873;
import '../../../presentation/map/manager/map_cubit.dart' as _i97;
import '../../services/web_service.dart' as _i1057;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i97.MapCubit>(() => _i97.MapCubit());
    gh.singleton<_i1057.WebService>(() => _i1057.WebService());
    gh.factory<_i1050.AuthDataSource>(
        () => _i1024.AuthDataSourceImp(gh<_i1057.WebService>()));
    gh.factory<_i736.AuthRepo>(
        () => _i990.AuthRepoImp(authDataSource: gh<_i1050.AuthDataSource>()));
    gh.factory<_i317.GetBranchesUseCase>(
        () => _i317.GetBranchesUseCase(authRepo: gh<_i736.AuthRepo>()));
    gh.factory<_i300.SignInWithAppleUseCase>(
        () => _i300.SignInWithAppleUseCase(gh<_i736.AuthRepo>()));
    gh.factory<_i652.SignInWithGoogleUseCase>(
        () => _i652.SignInWithGoogleUseCase(gh<_i736.AuthRepo>()));
    gh.factory<_i873.AuthCubit>(() => _i873.AuthCubit(
          gh<_i317.GetBranchesUseCase>(),
          gh<_i300.SignInWithAppleUseCase>(),
          gh<_i652.SignInWithGoogleUseCase>(),
        ));
    return this;
  }
}
