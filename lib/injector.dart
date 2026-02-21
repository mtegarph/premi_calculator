import 'package:calculator_agen/core/database/db_hive.dart';
import 'package:calculator_agen/core/database/secure_storage.dart';
import 'package:calculator_agen/features/calculator/data/datasource/local/premi_data_source.dart';
import 'package:calculator_agen/features/calculator/data/repositories/premi_repo_impl.dart';
import 'package:calculator_agen/features/calculator/domain/repositories/premi_repository.dart';
import 'package:calculator_agen/features/calculator/domain/usecases/get_list_product_use_case.dart';
import 'package:calculator_agen/features/calculator/domain/usecases/get_premi_user_use_case.dart';
import 'package:calculator_agen/features/calculator/domain/usecases/set_premi_user_use_case.dart';
import 'package:calculator_agen/features/calculator/presentation/bloc/premi_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initLocator() async {
  await _initCoreFeature();
}

Future<void> _initCoreFeature() async {
  final secureStorage = await SecureStorage.createInstance();
  sl.registerLazySingleton(() => secureStorage);
  await DbHive.init(secureStorage: secureStorage);
  sl.registerLazySingleton<PremiDataSource>(() => PremiDataSoureImpl());

  sl.registerLazySingleton<PremiRepository>(
      () => PremiRepoImpl(localDatasource: sl()));
  sl.registerLazySingleton(() => GetProductList(sl()));
  sl.registerLazySingleton(() => GetPremiUser(sl()));

  sl.registerLazySingleton(() => SetPremiUser(sl()));

  sl.registerFactory(() => PremiBloc(sl(), sl(), sl()));
}
