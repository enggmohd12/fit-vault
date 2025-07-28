import 'package:flutter/material.dart';
import 'package:flutter_unit_ruler/flutter_unit_ruler.dart';

const darkThemeColor = Color(0xff310ecb);
const lightThemeColor = Color(0xffdce2e5);

class WeightInKgNew extends StatelessWidget {
  final bool isDarkTheme;
  final ScaleController unitController;
  final ScaleUnit scaleUnit;
  final double currentWeightInKilogram;
  final Function(num) onWeightChanged;

  const WeightInKgNew({
    required this.isDarkTheme,
    super.key,
    required this.unitController,
    required this.scaleUnit,
    required this.currentWeightInKilogram,
    required this.onWeightChanged,
  });

  @override
  Widget build(BuildContext context) {
    final rulerBackgroundColor = isDarkTheme
        ? darkThemeColor
        : Colors.white;
    final textColor = isDarkTheme ? Colors.grey : Colors.black54;

    double boxSize =
        MediaQuery.of(context).size.width * 0.41; // 70% of screen width

    return Center(
      child: Container(
        height: boxSize,
        width: boxSize,
        decoration: BoxDecoration(
          color: isDarkTheme ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // KG Value at the top
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: RichText(
                text: TextSpan(
                  text:
                      "${currentWeightInKilogram.toInt()} ${scaleUnit.symbol}",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    color: Colors.indigo,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),

            // Ruler at the bottom
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: UnitRuler(
                  height: 70,
                  width: boxSize,
                  controller: unitController,
                  scrollDirection: Axis.horizontal,
                  backgroundColor: rulerBackgroundColor,
                  scaleUnit: scaleUnit,
                  scaleAlignment: Alignment.topCenter,
                  scalePadding: EdgeInsets.only(
                    left: boxSize / 2 - 1.25, // Center the scale marker
                    right: 0,
                    bottom: 0,
                  ),
                  scaleMarker: Container(
                    height: 100,
                    width: 2.5,
                    color: Colors.indigo,
                  ),
                  scaleMarkerPositionTop: 0,
                  scaleMarkerPositionLeft: boxSize / 2,
                  scaleIntervalText: (index, value) => value.toInt().toString(),
                  scaleIntervalTextStyle: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                  scaleIntervalTextPosition: 5,
                  scaleIntervalStyles: const [
                    ScaleIntervalStyle(
                      color: Colors.blue,
                      width: 2,
                      height: 30,
                      scale: -1,
                    ),
                    ScaleIntervalStyle(
                      color: Colors.red,
                      width: 2,
                      height: 35,
                      scale: 5,
                    ),
                    ScaleIntervalStyle(
                      color: Colors.indigo,
                      width: 2,
                      height: 45,
                      scale: 0,
                    ),
                  ],
                  onValueChanged: onWeightChanged,
                  scaleMargin: 9,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
