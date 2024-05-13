import 'package:flutter/material.dart';

const standardRadius = Radius.circular(8);

class CustomBlockWidgetVertical extends StatelessWidget {
  final double heightLeft;
  final double heightRight;
  final double widthLeft;
  final double widthRight;
  final String maxTemp;
  final String minTemp;
  final String bottomText;
  final String image;
  final double normalized;

  const CustomBlockWidgetVertical({super.key, required this.heightLeft,required this.heightRight, required this.widthLeft, required this.widthRight, required this.maxTemp, required this.minTemp, required this.bottomText, required this.image, required this.normalized});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Expanded(
          flex: 4,
          child: Row(
            children: [
              const Spacer(),
              Text("$widthLeft% ",),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Material(
                    borderRadius: const BorderRadius.all(standardRadius),
                    elevation: 8,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(standardRadius),
                      child: Container(
                        height: heightLeft, 
                        width: widthLeft,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Image.network(image, scale: 1.5,),
                    ],
                  )
                ],
              ),
            ],
          ),
         ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(bottomText)
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              normalized > 0.7
              ? Material(
                borderRadius: const BorderRadius.all(standardRadius),
                elevation: 8,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: standardRadius, bottomLeft: standardRadius),
                      child: Container(
                        height: 50, 
                        width: 50,
                        color: Colors.amber[800],
                        child: Center(child: Text(minTemp)),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(topRight: standardRadius, bottomRight: standardRadius),
                          child: Container(
                            height: heightRight,
                            width: widthRight,
                            color: Colors.amber,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(maxTemp),
                        ),
                      ],
                    )
                  ],
                ),
              )
              : Row(
                children: [
                  Material(
                    borderRadius: const BorderRadius.all(standardRadius),
                    elevation: 8,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: standardRadius, bottomLeft: standardRadius),
                          child: Container(
                            height: 50, 
                            width: 50,
                            color: Colors.amber[800],
                            child: Center(child: Text(minTemp)),
                          ),
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(topRight: standardRadius, bottomRight: standardRadius),
                              child: Container(
                                height: heightRight, 
                                width: widthRight,
                                color: Colors.amber
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(maxTemp),
                  ),
                ],
              ),
              const Spacer()
            ],
          ),
        ),
      ],
    );
  }
}
