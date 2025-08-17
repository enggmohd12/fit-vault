import 'dart:convert' show jsonDecode;

import 'package:fitvault/views/bmi_calculator/bmi_calculator_view.dart';
import 'package:fitvault/views/bmi_result/bmi_result_view.dart';
import 'package:fitvault/views/login/login_view.dart';
import 'package:fitvault/views/register/register_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter approute = GoRouter(
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
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterView(),
    ),
  ],
);
