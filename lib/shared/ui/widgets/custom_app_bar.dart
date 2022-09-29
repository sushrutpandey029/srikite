import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_gradient.dart';
import '../../constants/textstyle.dart';

AppBar customAppBar(String title,
    {bool isHome = false,
    List<IconData>? actionIcons,
    List<VoidCallback>? actionFunctions}) {
  return AppBar(
    title: Text(
      title,
      style: heading2,
    ),
    // automaticallyImplyLeading: false,
    actions: [
      if (actionIcons != null)
        for (int i = 0; i < actionIcons.length; i++)
          IconButton(
              iconSize: 24.sp,
              onPressed: () {
                if (actionFunctions != null) {
                  actionFunctions.elementAt(i);
                }
              },
              icon: Icon(actionIcons.elementAt(i))),
      if (isHome)
        Builder(builder: (context) {
          return IconButton(
              iconSize: 24.sp,
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(Icons.menu));
        }),
    ],
    flexibleSpace: Container(
      decoration: BoxDecoration(gradient: gradient1),
    ),
  );
}
