part of 'advicer_cubit.dart';

sealed class AdvicerCubitState extends Equatable {
  const AdvicerCubitState();
}

final class AdvicerCubitInitial extends AdvicerCubitState {
  @override
  List<Object?> get props => [];
}

final class AdvicerCubitStateLoading extends AdvicerCubitState {
  @override
  List<Object?> get props => [];
}

final class AdvicerCubitStateLoaded extends AdvicerCubitState {
  final String advice;
  const AdvicerCubitStateLoaded({
    required this.advice,
  });

  @override
  List<Object?> get props => [advice];
}

final class AdvicerCubitStateError extends AdvicerCubitState {
  final String message;
  const AdvicerCubitStateError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
