import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_flutter/appColors.dart';
import 'package:todo_c11_flutter/provider/provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<Myprovider>(context);
    return Container( 
      color: pro.isDarkMode()? Color(0xff141922 ,):Appcolors.whiteColor,
      child: Column(
        children: [
          InkWell(
              onTap: () {
                context.setLocale(Locale('ar'));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text(
                    "Arabic".tr(),
                    style: TextStyle(
                      color: pro.isDarkMode()?Appcolors.whiteColor :Color(0xff141922 ,)
                    ),
                  ),
                  Icon(Icons.done , color:pro.isDarkMode()?Appcolors.whiteColor :Color(0xff141922 ,)),
                ],
              )),
          SizedBox(
            height: 24,
          ),
          InkWell(
              onTap: () {
                 context.setLocale(Locale('en'));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("English".tr() , 
                  style: TextStyle(
                  color: pro.isDarkMode()?Appcolors.whiteColor :Color(0xff141922)
                  ),),
                  Icon(Icons.done , color: pro.isDarkMode()?Appcolors.whiteColor :Color(0xff141922,))
                ],
              )),
        ],
      ),
    );
  }
}
