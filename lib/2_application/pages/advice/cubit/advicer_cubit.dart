import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/usecases/advice_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advicer_state.dart';

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  AdvicerCubit() : super(AdvicerCubitInitial());
  final AdviceUsecases adviceUsecases = AdviceUsecases();

  void adviceRequestedEvent() async {
    debugPrint("fake get advice triggered");
    emit(AdvicerCubitStateLoading());
    final AdviceEntity advice = await adviceUsecases.getAdvice();
    debugPrint("got advice");
    emit(
      AdvicerCubitStateLoaded(
        advice: advice.advice,
      ),
    );
    // emit(AdvicerStateError(errorMessage: 'errorMessage'));
  }
}
