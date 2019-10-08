import 'package:flutter/widgets.dart';

class DialogPageController extends PageController {
  goTo(int page) {
    this.animateToPage(page,
        duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
  }
}
