
import 'package:e_comm_app/data/dao.dart';
import 'package:e_comm_app/helpers/repository.dart';
import 'package:e_comm_app/helpers/route.dart';
import 'package:e_comm_app/helpers/viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void locator() {
  getIt.registerLazySingleton(() => Repository());
  getIt.registerFactory(() => MasterDataViewModel());
  getIt.registerLazySingleton(() => AppRouter());
  getIt.registerLazySingleton(() => CategoryDao());
  getIt.registerLazySingleton(() => ProductDao());
  getIt.registerLazySingleton(() => CartDao());
}