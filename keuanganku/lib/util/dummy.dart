import 'package:flutter/material.dart';

dummyPadding({double height = 15}){
  return SizedBox(height: height,);
}

makeCenterWithRow({required Widget child}){
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [child],);
}