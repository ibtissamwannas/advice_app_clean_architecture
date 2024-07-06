import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

class AdviceUsecases {
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    // call repository to get the data
    await Future.delayed(const Duration(seconds: 3));
    return right(
      const AdviceEntity(
        id: 1,
        advice: "Hope your day is good",
      ),
    );
  }
}
