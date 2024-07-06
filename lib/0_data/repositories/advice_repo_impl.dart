import 'package:clean_architecture/0_data/data_sources/advice_remote_datasource.dart';
import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failures/failures.dart';
import 'package:clean_architecture/1_domain/repository/advice_repo.dart';
import 'package:dartz/dartz.dart';

class AdviceRepoImpl implements AdviceRepo {
  final AdviceRemoteDatasource adviceRemoteDatasource =
      AdviceRemoteDatasourceImpl();
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    final result = await adviceRemoteDatasource.getRandomAdviceFromApi();
    return right(result);
  }
}
