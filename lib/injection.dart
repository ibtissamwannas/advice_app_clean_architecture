import 'package:clean_architecture/0_data/data_sources/advice_remote_datasource.dart';
import 'package:clean_architecture/0_data/repositories/advice_repo_impl.dart';
import 'package:clean_architecture/1_domain/repository/advice_repo.dart';
import 'package:clean_architecture/1_domain/usecases/advice_usecases.dart';
import 'package:clean_architecture/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I;

Future<void> init() async {
  // ! application layer
  sl.registerFactory(
    () => AdvicerCubit(
      adviceUsecases: sl(),
    ),
  );

  // ! domain layer
  sl.registerFactory(
    () => AdviceUsecases(
      adviceRepo: sl(),
    ),
  );

  // ! data layer
  sl.registerFactory<AdviceRepo>(
    () => AdviceRepoImpl(
      adviceRemoteDatasource: sl(),
    ),
  );

  sl.registerFactory<AdviceRemoteDatasource>(
    () => AdviceRemoteDatasourceImpl(
      client: sl(),
    ),
  );

  // !externs : comes from packages
  sl.registerFactory(() => http.Client());
}
