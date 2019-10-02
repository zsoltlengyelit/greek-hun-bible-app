import 'package:flutter/material.dart';

AppBar MyAppBar(String title, BuildContext context, [bool showNav = true]) {
  return AppBar(
      title: Text(title),
      leading: showNav
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                return Navigator.pop(context);
              },
            )
          : null);
}
