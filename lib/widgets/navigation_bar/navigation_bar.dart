// import the package
import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'navigation_bar_mobile.dart';
import 'navigation_bar_tablet.dart';
import 'navigation_bar_web.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({required Key key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile:NavigationBarsMobile(destinations: [],),
      tablet: NavigationBarsTablet(destinations: [],),
      desktop: NavigationBarsWeb(destinations: [],),
    );
  }
}
