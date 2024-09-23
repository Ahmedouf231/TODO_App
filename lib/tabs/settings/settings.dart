import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_flutter/appColors.dart';
import 'package:todo_c11_flutter/provider/provider.dart';
import 'package:todo_c11_flutter/tabs/settings/LanguageBottomSheet.dart';
import 'package:todo_c11_flutter/tabs/settings/ThemeBottomSheet%20.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});
  @override
  Widget build(BuildContext context) { 
        var pro = Provider.of<Myprovider>(context);

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Language".tr(),
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold , 
            color: pro.isDarkMode()?Appcolors.whiteColor :Appcolors.blackColor),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return LanguageBottomSheet();
                },
              );
            },
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.zero),
                  border:
                      Border.all(color: Colors.grey, style: BorderStyle.solid),
                  color: pro.isDarkMode()? Color(0xff141922) : Appcolors.whiteColor),
              width: double.infinity,
              height: 50,
              child: Text(
                "  English",
                style: TextStyle(
                  fontSize: 22,
                  color: pro.isDarkMode()?Appcolors.whiteColor :Appcolors.blackColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "Theme".tr(),
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold ,
            color: pro.isDarkMode()?Appcolors.whiteColor :Appcolors.blackColor),
            
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
               showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ThemeBottomSheet();
                },
              );
            },
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.zero),
                  border:
                      Border.all(color: Colors.grey, style: BorderStyle.solid),
                  color: pro.isDarkMode()? Color(0xff141922) : Appcolors.whiteColor),
              width: double.infinity,
              height: 50,
              child: Text(
                "  Light",
                style: TextStyle(
                  fontSize: 22,
                  color: pro.isDarkMode()?Appcolors.whiteColor :Appcolors.blackColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
