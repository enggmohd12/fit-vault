import 'package:flutter/material.dart';
import 'package:flutter_unit_ruler/scale_controller.dart';
import 'package:flutter_unit_ruler/scale_line.dart';
import 'package:flutter_unit_ruler/scale_unit.dart';
import 'package:flutter_unit_ruler/unit_ruler.dart';

const darkThemeColor = Color(0xff310ecb);
const lightThemeColor = Color(0xffdce2e5);

class HeightScaleWidget extends StatelessWidget {
  final bool isDarkTheme;
  final ScaleController unitController;
  final ScaleUnit scaleUnit;
  final double currentHeightInKilogram;
  final Function(num) onWeightChanged;
  const HeightScaleWidget({
    required this.isDarkTheme,
    super.key,
    required this.unitController,
    required this.scaleUnit,
    required this.currentHeightInKilogram,
    required this.onWeightChanged,
  });

  @override
  Widget build(BuildContext context) {
    final rulerBackgroundColor = isDarkTheme ? darkThemeColor : Colors.white;
    final textColor = isDarkTheme ? Colors.grey : Colors.black54;
    double boxSize =
        MediaQuery.of(context).size.width * 0.41; // 70% of screen width
    Size size = MediaQuery.of(context).size;
    final containerHeight = boxSize * 2;
    return Container(
      height: containerHeight,
      width: boxSize,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: boxSize * 0.4, // Adjust width for responsiveness
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: RichText(
                    text: TextSpan(
                      text: currentHeightInKilogram.toStringAsFixed(0),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF283593), // Deep Blue
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: boxSize * 0.4, // Adjust width for responsiveness
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: RichText(
                    text: TextSpan(
                      text: currentHeightInKilogram > 0 ? 'inches' : 'inch',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF283593), // Deep Blue
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            child: UnitRuler(
              height: containerHeight,
              width: boxSize * 0.5, // Adjust width for responsiveness
              controller: unitController,
              scrollDirection: Axis.vertical,
              backgroundColor: rulerBackgroundColor,
              scaleUnit: scaleUnit,
              scaleAlignment: Alignment.centerLeft,
              scalePadding: EdgeInsets.only(
                left: 0,
                right: 0,
                top: size.width * 0.43,
              ),
              scaleMarker: Container(
                height: 2,
                width: 100, // Adjust marker width for responsiveness
                color: Colors.indigo,
              ),
              scaleMarkerPositionTop: containerHeight / 1.87,
              scaleMarkerPositionLeft: 0,
              scaleIntervalText: (index, value) => value.toInt().toString(),
              scaleIntervalTextStyle: TextStyle(
                color: textColor,
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
              scaleIntervalTextPosition: 0.5,
              scaleIntervalStyles: const [
                ScaleIntervalStyle(
                  color: Colors.blue,
                  width: 20,
                  height: 2,
                  scale: -1,
                ),
                ScaleIntervalStyle(
                  color: Colors.red,
                  width: 30,
                  height: 2.5,
                  scale: 0,
                ),
                ScaleIntervalStyle(
                  color: Colors.indigo,
                  width: 40,
                  height: 2,
                  scale: 6,
                ),
              ],
              onValueChanged: onWeightChanged,
              scaleMargin: 0,
            ),
          ),
        ],
      ),
    );
  }
}
