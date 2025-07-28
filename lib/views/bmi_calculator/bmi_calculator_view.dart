import 'package:fitvault/views/bmi_calculator/components/male_female_container.dart';
import 'package:fitvault/views/bmi_calculator/components/weight_scale_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit_ruler/scale_controller.dart';
import 'package:flutter_unit_ruler/scale_unit.dart' show ScaleUnit, UnitType;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BMICalculatorView extends StatefulWidget {
  const BMICalculatorView({super.key});

  @override
  State<BMICalculatorView> createState() => _BMICalculatorViewState();
}

class _BMICalculatorViewState extends State<BMICalculatorView> {
  bool isSelected = true;
  double currentWeightInKilogram = 50.0;
  late final ScaleController _unitController;
  late final ScaleUnit _scaleUnit;
  double value = 4.0;

  @override
  void initState() {
    _scaleUnit = UnitType.weight.kilogram;
    _unitController = ScaleController(value: currentWeightInKilogram);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onLongPress: () {
            // print('Long Pressed on FitVault');
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
                    icon: FontAwesomeIcons.mars,
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
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      // WeightInKgNew(isDarkTheme: false),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
