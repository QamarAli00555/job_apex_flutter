import 'package:flutter/material.dart';

Widget buildStyleContainer(BuildContext context, Widget child,
    {bool showImage = false}) {
  return Container(
      decoration: BoxDecoration(
          image: showImage
              ? const DecorationImage(
                  image: AssetImage('assets/images/jobs.png'),
                  fit: BoxFit.cover,
                  opacity: 0.35)
              : null,
          borderRadius: const BorderRadius.all(Radius.circular(9))),
      child: child);
}
