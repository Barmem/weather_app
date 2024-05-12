
import 'package:flutter/material.dart';

class PageViewWithText extends StatelessWidget {
  final String title;
  final List<Widget> views;
  final double viewHeight;
  const PageViewWithText({
    this.title = "Title",
    this.viewHeight = 300,
    required this.views,
    super.key
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 16,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: viewHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0,16.0,0,0),
                    child: PageView(children: 
                      views
                    ),
                  ),
                )
            ]),
          ),
        ),
      ),
    );
  }
}
