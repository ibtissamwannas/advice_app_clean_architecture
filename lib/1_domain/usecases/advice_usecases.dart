import 'package:clean_architecture/1_domain/entities/advice_entity.dart';

class AdviceUsecases {
  Future<AdviceEntity> getAdvice() async {
    // call repository to get the data
    await Future.delayed(const Duration(seconds: 3));
    return const AdviceEntity(
      id: 1,
      advice: "Hope your day is good",
    );
  }
}
