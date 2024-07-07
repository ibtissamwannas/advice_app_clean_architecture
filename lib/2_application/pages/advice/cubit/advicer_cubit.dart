import 'package:clean_architecture/1_domain/failures/failures.dart';
import 'package:clean_architecture/1_domain/usecases/advice_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advicer_state.dart';

const GeneralFailureMessage = "Unexpected Error";
const ServerFailureMessage = "Server Failure";
const CacheFailureMessage = "Cache Failure";

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  final AdviceUsecases adviceUsecases;
  AdvicerCubit({required this.adviceUsecases})
      : super(
          AdvicerCubitInitial(),
        );

  void adviceRequestedEvent() async {
    debugPrint("fake get advice triggered");
    emit(AdvicerCubitStateLoading());
    final failureOrAdvice = await adviceUsecases.getAdvice();
    failureOrAdvice.fold(
      (failure) {
        emit(
          AdvicerCubitStateError(
            message: _mapFailureToMessage(failure),
          ),
        );
      },
      (advice) {
        emit(
          AdvicerCubitStateLoaded(
            advice: advice.advice,
          ),
        );
      },
    );
    debugPrint("got advice");
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return ServerFailureMessage;
    case CacheFailure:
      return CacheFailureMessage;
    default:
      return GeneralFailureMessage;
  }
}
