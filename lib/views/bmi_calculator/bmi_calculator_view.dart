import 'dart:convert' show jsonEncode;
import 'package:fitvault/components/sharedpreference_key.dart';
import 'package:fitvault/views/bmi_calculator/components/age_scale_widget.dart'
    show AgeInYrWidget;
import 'package:fitvault/views/bmi_calculator/components/height_scale_wiget.dart';
import 'package:fitvault/views/bmi_calculator/components/male_female_container.dart';
import 'package:fitvault/views/bmi_calculator/components/weight_scale_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit_ruler/scale_controller.dart';
import 'package:flutter_unit_ruler/scale_unit.dart' show ScaleUnit, UnitType;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class BMICalculatorView extends StatefulWidget {
  const BMICalculatorView({super.key});

  @override
  State<BMICalculatorView> createState() => _BMICalculatorViewState();
}

class _BMICalculatorViewState extends State<BMICalculatorView> {
  bool isSelected = true;
  double currentWeightInKilogram = 50.0;
  double currentHeightinInches = 60;
  double currentAgeInYr = 25.0;
  late final ScaleController _unitController;
  late final ScaleUnit _scaleUnit;
  late final ScaleController _unitHeightController;
  late final ScaleUnit _scaleUnitHeight;
  late ScaleController _unitAgeController;
  late ScaleUnit _scaleUnitAge;
  double value = 4.0;

  @override
  void initState() {
    _scaleUnit = UnitType.weight.kilogram;
    _unitController = ScaleController(value: currentWeightInKilogram);
    _scaleUnitHeight = UnitType.length.inch;
    _unitHeightController = ScaleController(value: currentHeightinInches);
    _scaleUnitAge = UnitType.weight.kilogram;
    _unitAgeController = ScaleController(value: currentAgeInYr);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onLongPress: () async {
            final prefs = await SharedPreferences.getInstance();
            final isLoginSetupDone =
                prefs.getBool(SharedPreferenceKey.isLoginSetupDone) ?? false;
            if (isLoginSetupDone) {
            } else {}
          },
          child: RichText(
            text: TextSpan(
              text: 'FitVault',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              RichText(
                text: TextSpan(
                  text: 'BMI Calculator',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF283593), // Deep Blue
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Transform Your Numbers. Transform Your Life.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF283593), // Deep Blue
                  ),
                ),
              ),
              Row(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaleFemaleContainer(
                    gender: 'Male',
                    icon: FontAwesomeIcons.mars,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        if (!isSelected) {
                          isSelected = !isSelected;
                        }
                      });
                    },
                    size: size,
                  ),
                  MaleFemaleContainer(
                    gender: 'Female',
                    icon: FontAwesomeIcons.venus,
                    isSelected: !isSelected,
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          isSelected = !isSelected;
                        }
                      });
                    },
                    size: size,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  Row(
                    spacing: 15,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        spacing: 15,
                        children: [
                          WeightInKgNew(
                            isDarkTheme: false,
                            currentWeightInKilogram: currentWeightInKilogram,
                            scaleUnit: _scaleUnit,
                            unitController: _unitController,
                            onWeightChanged: (value) => setState(
                              () => currentWeightInKilogram = value.toDouble(),
                            ),
                          ),
                          AgeInYrWidget(
                            isDarkTheme: false,
                            unitController: _unitAgeController,
                            scaleUnit: _scaleUnitAge,
                            currentAgeInYr: currentAgeInYr,
                            onAgeChanged: (value) => setState(
                              () => currentAgeInYr = value.toDouble(),
                            ),
                          ),
                        ],
                      ),
                      HeightScaleWidget(
                        isDarkTheme: false,
                        unitController: _unitHeightController,
                        scaleUnit: _scaleUnitHeight,
                        currentHeightinInches: currentHeightinInches,
                        onWeightChanged: (p0) {
                          setState(() {
                            currentHeightinInches = p0.toDouble();
                          });
                        },
                      ),
                      // WeightInKgNew(isDarkTheme: false),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: size.width * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF3F51B5), // Indigo 500
                        Color(0xFF512DA8), // Deep Purple 700
                      ],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      final heightInMeters = currentHeightinInches * 0.0254;
                      final weightInKg = currentWeightInKilogram;
                      final bmi =
                          weightInKg / (heightInMeters * heightInMeters);
                      final bmiRounded = bmi.toStringAsFixed(2);
                      context.go(
                        Uri(
                          path: '/result',
                          queryParameters: {
                            'bmiResult': bmiRounded,
                            'gender': isSelected ? 'Male' : 'Female',
                            'weightInKg': weightInKg.toString(),
                            'heightInFeet': inchesToFeet(
                              currentHeightinInches.toInt(),
                            ),
                            'idealWeightRange': jsonEncode(
                              healthyWeightRange(currentHeightinInches),
                            ),
                          },
                        ).toString(),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Calculate BMI',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: size.width > 800 ? 24 : 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String inchesToFeet(int inches) {
    int feet = inches ~/ 12; // integer division
    int remainingInches = inches % 12; // remainder inches
    return "$feet' $remainingInches\""; // e.g., 5' 8"
  }

  Map<String, double> healthyWeightRange(double heightInches) {
    double heightMeters = heightInches * 0.0254;
    double minWeight = 18.5 * heightMeters * heightMeters;
    double maxWeight = 24.9 * heightMeters * heightMeters;
    return {
      "min": double.parse(minWeight.toStringAsFixed(1)),
      "max": double.parse(maxWeight.toStringAsFixed(1)),
    };
  }
}
