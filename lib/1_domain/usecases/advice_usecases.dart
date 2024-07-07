import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failures/failures.dart';
import 'package:clean_architecture/1_domain/repository/advice_repo.dart';
import 'package:dartz/dartz.dart';

class AdviceUsecases {
  AdviceUsecases({required this.adviceRepo});
  final AdviceRepo adviceRepo;
  Future<Either<Failure, AdviceEntity>> getAdvice() {
    // call repository to get the data
    return adviceRepo.getAdviceFromDataSource();
  }
}
