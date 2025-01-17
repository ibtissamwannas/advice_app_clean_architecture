import 'package:clean_architecture/2_application/core/services/theme_service.dart';
import 'package:clean_architecture/2_application/pages/advice/advice_page.dart';
import 'package:clean_architecture/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:clean_architecture/2_application/pages/advice/widgets/advice_field.dart';
import 'package:clean_architecture/2_application/pages/advice/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:provider/provider.dart';

class MockAdvicerCubit extends MockCubit<AdvicerCubitState>
    implements AdvicerCubit {}

void main() {
  Widget widgetUnderTest({required AdvicerCubit cubit}) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => ThemeService(),
        child: BlocProvider<AdvicerCubit>(
          create: (context) => cubit,
          child: const AdvicePage(),
        ),
      ),
    );
  }

  group(
    'AdvicerPage',
    () {
      late AdvicerCubit mockAdvicerCubit;

      setUp(
        () {
          mockAdvicerCubit = MockAdvicerCubit();
        },
      );
      group(
        'should be displayed in ViewState',
        () {
          testWidgets(
            'Initial when cubits emits AdvicerInitial()',
            (widgetTester) async {
              whenListen(
                mockAdvicerCubit,
                Stream.fromIterable(
                  [AdvicerCubitInitial()],
                ),
                initialState: AdvicerCubitInitial(),
              );

              await widgetTester.pumpWidget(
                widgetUnderTest(
                  cubit: mockAdvicerCubit,
                ),
              );

              final advicerInitalTextFinder = find.text(
                "Your Advice is waiting for you!",
              );

              expect(
                advicerInitalTextFinder,
                findsOneWidget,
              );
            },
          );

          testWidgets(
            'Loading when cubits emits AdvicerStateLoading()',
            (widgetTester) async {
              whenListen(
                mockAdvicerCubit,
                Stream.fromIterable(
                  [
                    AdvicerCubitStateLoading(),
                  ],
                ),
                initialState: AdvicerCubitInitial(),
              );

              await widgetTester
                  .pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
              await widgetTester.pump();

              final advicerLoadingFinder =
                  find.byType(CircularProgressIndicator);

              expect(advicerLoadingFinder, findsOneWidget);
            },
          );

          testWidgets(
            'advice text when cubits emits AdvicerStateLoaded()',
            (widgetTester) async {
              whenListen(
                mockAdvicerCubit,
                Stream.fromIterable(
                  const [AdvicerCubitStateLoaded(advice: '42')],
                ),
                initialState: AdvicerCubitInitial(),
              );

              await widgetTester
                  .pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
              await widgetTester.pump();

              final advicerLoadedStateFinder = find.byType(AdviceField);
              final adviceText = widgetTester
                  .widget<AdviceField>(advicerLoadedStateFinder)
                  .advice;

              expect(advicerLoadedStateFinder, findsOneWidget);
              expect(adviceText, '42');
            },
          );

          testWidgets(
            'Error when cubits emits AdvicerStateError()',
            (widgetTester) async {
              whenListen(
                mockAdvicerCubit,
                Stream.fromIterable(
                  const [
                    AdvicerCubitStateError(
                      message: 'error',
                    ),
                  ],
                ),
                initialState: AdvicerCubitInitial(),
              );

              await widgetTester
                  .pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
              await widgetTester.pump();

              final advicerErrorFinder = find.byType(ErrorMessage);

              expect(advicerErrorFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
