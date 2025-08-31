import 'dart:convert';

import 'package:fitvault/state/flutter_secure_storage/secure_storage_provider.dart';
import 'package:fitvault/views/bmi_calculator/bmi_calculator_view.dart';
import 'package:fitvault/views/bmi_result/bmi_result_view.dart';
import 'package:fitvault/views/locker_home/locker_home_view.dart';
import 'package:fitvault/views/login/login_view.dart';
import 'package:fitvault/views/register/register_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    final credStore = ref.read(credentialStoreProvider);
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          name: 'home',
          path: '/',
          builder: (context, state) => const BMICalculatorView(),
          routes: [
            GoRoute(
              name: 'result',
              path: 'result',
              builder: (context, state) {
                final params = state.uri.queryParameters;
                final bmiResult = params['bmiResult'] ?? '0.0 ';
                final gender = params['gender'] ?? 'Male';
                final weightInKg =
                    double.tryParse(params['weightInKg'] ?? '0.0') ?? 0.0;
                final heightInFeet = params['heightInFeet'] ?? "0' 0\"";

                final idealWeightRange = params['idealWeightRange'];
                final Map<String, double> idealWeightRangeMap =
                    idealWeightRange != null
                    ? Map<String, double>.from(
                        jsonDecode(idealWeightRange).map(
                          (k, v) => MapEntry(
                            k,
                            (v as num).toDouble(),
                          ),
                        ),
                      )
                    : {};
                return BmiResultView(
                  bmiResult: bmiResult,
                  weightInKg: weightInKg,
                  heightInFeet: heightInFeet,
                  gender: gender.toString(),
                  idealWeightRange: idealWeightRangeMap,
                );
              },
            ),
            GoRoute(
              path: '/login',
              builder: (context, state) => LoginView(
                credStore: credStore,
              ),
            ),
            GoRoute(
              path: '/register',
              builder: (context, state) => RegisterView(
                credStore: credStore,
              ),
            ),
            GoRoute(
              path: '/lockerhome',
              builder: (context, state) => LockerHomeView(
                credStore: credStore,
              ),
            ),
          ],
        ),
      ],
    );
  },
);
