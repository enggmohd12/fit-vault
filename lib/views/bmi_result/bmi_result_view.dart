import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BmiResultView extends StatelessWidget {
  final String bmiResult;
  final double weightInKg;
  final String heightInFeet;
  final String gender;
  final Map<String, double> idealWeightRange;
  const BmiResultView({
    super.key,
    required this.bmiResult,
    required this.weightInKg,
    required this.heightInFeet,
    required this.gender,
    required this.idealWeightRange,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Result',
          style: TextStyle(fontFamily: 'Poppins'),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              RichText(
                text: TextSpan(
                  text: 'Your BMI Result',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              RichText(
                text: TextSpan(
                  text: '${weightInKg}kg  |  ${heightInFeet}ft  |  $gender',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              SizedBox(
                height: size.height * 0.32,
                child: SfRadialGauge(
                  enableLoadingAnimation: true,
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: 50,
                      ranges: <GaugeRange>[
                        GaugeRange(
                          startValue: 0,
                          endValue: 18.5,
                          color: Colors.lightGreen,
                        ),
                        GaugeRange(
                          startValue: 18.5,
                          endValue: 24.9,
                          color: Colors.green,
                        ),
                        GaugeRange(
                          startValue: 25,
                          endValue: 29.9,
                          color: Colors.yellow,
                        ),
                        GaugeRange(
                          startValue: 30,
                          endValue: 34.9,
                          color: Colors.orangeAccent,
                        ),
                        GaugeRange(
                          startValue: 35,
                          endValue: 39.9,
                          color: Colors.orange,
                        ),
                        GaugeRange(
                          startValue: 40,
                          endValue: 50,
                          color: Colors.red,
                        ),
                      ],
                      pointers: <GaugePointer>[
                        NeedlePointer(
                          value: bmiResult.isNotEmpty
                              ? double.parse(bmiResult)
                              : 0,
                        ),
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          widget: SizedBox(
                            child: RichText(
                              text: TextSpan(
                                text: bmiResult,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          angle: 90,
                          positionFactor: 0.5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              RichText(
                text: TextSpan(
                  text: 'You are',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: bmiResult.isNotEmpty
                          ? double.parse(bmiResult) < 18.5
                                ? ' Underweight'
                                : double.parse(bmiResult) < 24.9
                                ? ' Normal'
                                : double.parse(bmiResult) < 29.9
                                ? ' Overweight'
                                : double.parse(bmiResult) < 34.9
                                ? ' Obesity Class I'
                                : double.parse(bmiResult) < 39.9
                                ? ' Obesity Class II'
                                : ' Obesity Class III'
                          : '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: bmiResult.isNotEmpty
                            ? double.parse(bmiResult) < 18.5
                                  ? Colors.lightGreen
                                  : double.parse(bmiResult) < 24.9
                                  ? Colors.green
                                  : double.parse(bmiResult) < 29.9
                                  ? Colors.yellow
                                  : double.parse(bmiResult) < 34.9
                                  ? Colors.orange
                                  : double.parse(bmiResult) < 39.9
                                  ? Colors.orangeAccent
                                  : Colors.red
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Align(
                alignment: Alignment.center,
                child: Visibility(
                  visible:
                      bmiResult.isNotEmpty && double.parse(bmiResult) >= 25 || double.parse(bmiResult) < 18.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: 'Your ideal weight is between ',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text:
                                '${idealWeightRange['min']?.toStringAsFixed(1)}kg',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text:
                                '${idealWeightRange['max']?.toStringAsFixed(1)}kg',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
