import 'package:flutter/material.dart';
import 'package:jobseek/utils/color_res.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(35),
          height: 110,
          width: 110,
          decoration: BoxDecoration(
              color: ColorRes.white, borderRadius: BorderRadius.circular(25)),
          child:  CircularProgressIndicator(
            backgroundColor: ColorRes.containerColor.withOpacity(0.2),
            color: ColorRes.containerColor,
          ),
        ),
      ),
    );
  }
}
