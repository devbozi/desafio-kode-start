import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
     required this.leftIcon});

  final Widget leftIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 360,
      decoration: BoxDecoration(color: Color(0xFF1C1B1F)),
      child: SafeArea(
        top: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(margin: EdgeInsets.only(top: 17, left: 14),
            child: leftIcon,
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Image.asset('assets/logo.png', width: 115, height: 77),
                  Text(
                    'RICK AND MORTY API',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12, right: 14),
              child: Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(135);
}
