import 'package:clean_architecture/0_data/repositories/advice_repo_impl.dart';
import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

class AdviceUsecases {
  final AdviceRepo = AdviceRepoImpl();
  Future<Either<Failure, AdviceEntity>> getAdvice() {
    // call repository to get the data
    return AdviceRepo.getAdviceFromDataSource();
  }
}
