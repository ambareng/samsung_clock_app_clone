import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:samsung_clock_app_clone/constants/text_styles.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Spacer(),
            BottomNavBarItem(itemText: 'Alarm', isSelected: true, namedRoute: '/alarm'),
            Spacer(),
            BottomNavBarItem(itemText: 'World clock', namedRoute: '/world_clock'),
            Spacer(),
            BottomNavBarItem(itemText: 'Stopwatch', namedRoute: '/stopwatch'),
            Spacer(),
            BottomNavBarItem(itemText: 'Timer', namedRoute: '/alarm'),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class BottomNavBarItem extends StatelessWidget {
  final String itemText;
  final bool isSelected;
  final String namedRoute;
  const BottomNavBarItem({
    Key? key,
    required this.itemText,
    this.isSelected = false,
    required this.namedRoute
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationService().pushNamed(namedRoute);
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: isSelected ? _underlined() : null,
        child: Text(
          itemText,
          style: GoogleFonts.nanumGothic(
            textStyle: isSelected ? selectedBottomNavBarText_1 : bottomNavBarText_1,
          ),
        ),
      ),
    );
  }

  BoxDecoration _underlined() {
    return const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.black,
          width: 2.0,
        )
      )
    );
  }
}