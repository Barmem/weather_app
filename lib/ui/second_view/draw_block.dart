import 'package:flutter/material.dart';


class CustomBlockWidget extends StatelessWidget {
  final double height;
  final double width;
  final String topText;
  final String bottomText;
  final String image;

  const CustomBlockWidget({super.key, required this.height, required this.width, required this.topText, required this.bottomText, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(topText),
        Material(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          elevation: 8,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Container(
              height: height, 
              width: width,
              color: Colors.blue, 
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.network(image),
              ),
            ),
          ),
        ),
        Text(bottomText)
      ],
    );
  }
}
