import 'package:flutter/material.dart';
import 'package:cthulhu_solo_investigator_app/core/constants/app_images.dart' as Images;
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class TopNavigationBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _TopNavigationBarState createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBarWidget> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      surfaceTintColor: Color.fromARGB(255, 34, 34, 34),
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          SvgPicture.asset(
              Images.LOGO,
              width: 24,
              height: 24,
              color: const Color.fromARGB(255, 255, 255, 255),
          ),
          const SizedBox(width: 12.0),
          const Text(
            style:TextStyle(
              color: Colors.white
            ),
            'Solo Investigator'),
          
        ],
      ),
      // actions: [
      //   Container(
      //     width: 1,
      //     height: 24,
      //     decoration: const BoxDecoration(
      //       border: Border(
      //         right: BorderSide(
      //           color: Colors.grey,
      //           width: 1,
      //         ),
      //       ),
      //     ),
      //   ),
      //   IconButton(
      //     icon: const Icon(Icons.menu),
      //     onPressed: () {
      //       Scaffold.of(context).openEndDrawer();
      //     },
      //   ),
      // ],
    );
  }
}
