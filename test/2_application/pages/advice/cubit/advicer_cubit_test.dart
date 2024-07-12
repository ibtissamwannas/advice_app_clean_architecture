import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failures/failures.dart';
import 'package:clean_architecture/1_domain/usecases/advice_usecases.dart';
import 'package:clean_architecture/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/scaffolding.dart';

class MockAdviceUseCases extends Mock implements AdviceUsecases {}

void main() {
  group('AdvicerCubit', () {
    group(
      'should emit',
      () {
        MockAdviceUseCases mockAdviceUseCases = MockAdviceUseCases();

        blocTest(
          'nothing when no method is called',
          build: () => AdvicerCubit(
            adviceUsecases: mockAdviceUseCases,
          ),
          expect: () => const <AdvicerCubitState>[],
        );

        blocTest(
          '[AdvicerStateLoading, AdvicerStateLoaded] when adviceRequested() is called',
          setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
            (invocation) => Future.value(
              const Right<Failure, AdviceEntity>(
                AdviceEntity(advice: 'advice', id: 1),
              ),
            ),
          ),
          build: () => AdvicerCubit(adviceUsecases: mockAdviceUseCases),
          act: (cubit) => cubit.adviceRequestedEvent(),
          expect: () => <AdvicerCubitState>[
            AdvicerCubitStateLoading(),
            const AdvicerCubitStateLoaded(advice: 'advice')
          ],
        );

        group(
          '[AdvicerStateLoading, AdvicerStateError] when adviceRequested() is called',
          () {
            blocTest(
              'and a ServerFailure occors',
              setUp: () =>
                  when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
                (invocation) => Future.value(
                  Left<Failure, AdviceEntity>(
                    ServerFailure(),
                  ),
                ),
              ),
              build: () => AdvicerCubit(adviceUsecases: mockAdviceUseCases),
              act: (cubit) => cubit.adviceRequestedEvent(),
              expect: () => <AdvicerCubitState>[
                AdvicerCubitStateLoading(),
                const AdvicerCubitStateError(
                  message: serverFailureMessage,
                ),
              ],
            );

            blocTest(
              'and a CacheFailure occors',
              setUp: () =>
                  when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
                (invocation) => Future.value(
                  Left<Failure, AdviceEntity>(
                    CacheFailure(),
                  ),
                ),
              ),
              build: () => AdvicerCubit(adviceUsecases: mockAdviceUseCases),
              act: (cubit) => cubit.adviceRequestedEvent(),
              expect: () => <AdvicerCubitState>[
                AdvicerCubitStateLoading(),
                const AdvicerCubitStateError(message: cacheFailureMessage),
              ],
            );

            blocTest(
              'and a GeneralFailure occors',
              setUp: () =>
                  when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
                (invocation) => Future.value(
                  Left<Failure, AdviceEntity>(
                    GeneralFailure(),
                  ),
                ),
              ),
              build: () => AdvicerCubit(adviceUsecases: mockAdviceUseCases),
              act: (cubit) => cubit.adviceRequestedEvent(),
              expect: () => <AdvicerCubitState>[
                AdvicerCubitStateLoading(),
                const AdvicerCubitStateError(message: generalFailureMessage),
              ],
            );
          },
        );
      },
    );
  });
}
