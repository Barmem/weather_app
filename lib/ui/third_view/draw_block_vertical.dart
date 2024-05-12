import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                    borderRadius: BorderRadius.all(standardRadius),
                    elevation: 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(standardRadius),
                      child: Container(
                        height: heightLeft, 
                        width: widthLeft,
                        color: Colors.blue,
                        child: const Text("")
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
              normalized > 0.6
              ? Material(
                borderRadius: BorderRadius.all(standardRadius),
                elevation: 8,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: standardRadius, bottomLeft: standardRadius),
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
                          borderRadius: BorderRadius.only(topRight: standardRadius, bottomRight: standardRadius),
                          child: Container(
                            height: heightRight, 
                            width: widthRight,
                            color: Colors.amber,
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(""),
                            ),
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
                    borderRadius: BorderRadius.all(standardRadius),
                    elevation: 8,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: standardRadius, bottomLeft: standardRadius),
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
                              borderRadius: BorderRadius.only(topRight: standardRadius, bottomRight: standardRadius),
                              child: Container(
                                height: heightRight, 
                                width: widthRight,
                                color: Colors.amber,
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(""),
                                ),
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
