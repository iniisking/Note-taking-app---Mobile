import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notesapp/views/constants/colors/colors.dart';
import 'package:notesapp/views/constants/widgets/card.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: blackBg,
          leading: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: reusableCenteredCard(
                  50.h,
                  50.w,
                  blackBg2,
                  15.r,
                  const Icon(
                    size: 25,
                    weight: 500,
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
      backgroundColor: blackBg,
      body: const Center(
        child: Text(
          'Settings',
          style: TextStyle(color: white),
        ),
      ),
    );
  }
}
