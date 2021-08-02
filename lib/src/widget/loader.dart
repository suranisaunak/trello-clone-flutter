import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      color: Colors.grey.withOpacity(0.5),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
