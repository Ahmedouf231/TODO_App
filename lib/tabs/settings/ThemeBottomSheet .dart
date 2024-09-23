import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_flutter/appColors.dart';
import 'package:todo_c11_flutter/provider/provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<Myprovider>(context);

    return Container( 
      color: pro.isDarkMode()?Color(0xff141922 ,):Appcolors.whiteColor,
      child: Column(
        children: [
          InkWell(
              onTap: () {
                pro.changeTheme(ThemeMode.light);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Light".tr() , style: TextStyle(
                    color: pro.isDarkMode()?Appcolors.whiteColor :Appcolors.blackColor
                  ),),
                  Icon(Icons.done  , 
                  color: pro.isDarkMode()?Appcolors.whiteColor :Appcolors.blackColor,),
                ],
              )),
          SizedBox(
            height: 24,
          ),
          InkWell(
              onTap: () {
              pro.changeTheme(ThemeMode.dark);
      
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dark".tr(), style: TextStyle(
                    color: pro.isDarkMode()?Appcolors.whiteColor :Appcolors.blackColor
                  ),),
                  Icon(Icons.done , 
                  color: pro.isDarkMode()?Appcolors.whiteColor :Appcolors.blackColor,),
                ],
              )),
        ],
      ),
    );
  }
}
