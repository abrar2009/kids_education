import 'package:flutter/material.dart';

class NextBtn extends StatelessWidget {
  const NextBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF4CDAFE),
                    shape: OvalBorder(
                      side: BorderSide(width: 7, color: Colors.white),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0xFF01B4ED),
                        blurRadius: 0,
                        offset: Offset(0, 7),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              // Add arrow image in the center
              Center(
                child: Image.asset(
                  'assets/images/next_arrow.png',
                  width: 65,
                  height: 65,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}