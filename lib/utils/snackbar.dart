import 'package:flutter/material.dart';
import 'package:meta_tube/utils/app_style.dart';

class Snack_bar{
  static void showSnackbar(
    BuildContext context, IconData icon, String message){
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(
      children: [Icon(icon, color: Apptheme.accent),SizedBox(width: 8,),
      Text(message)],
    )));
    }
  
}