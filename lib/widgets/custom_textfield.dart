import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta_tube/utils/app_style.dart';
import 'package:meta_tube/utils/snackbar.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({super.key, 
  required this.maxLength, 
  this.maxLines, 
  required this.hintText, 
  required this.controller});


final int maxLength;
final int? maxLines;
final String hintText;
final TextEditingController controller;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

final _focusnode = FocusNode();
class _CustomTextfieldState extends State<CustomTextfield> {
FocusNode myFocusNode = FocusNode();

  @override
void initState() {
  super.initState();
  myFocusNode = FocusNode();
  print('FocusNode initialized');
}

@override
void dispose() {
  myFocusNode.dispose();
  print('FocusNode disposed');
  super.dispose();
}

void copyToClipboard(context, String text){
  Clipboard.setData(ClipboardData(text: text));
  Snack_bar.showSnackbar(context, Icons.copy, "copied text");
}
  @override 
  Widget build(BuildContext context) {
    return  TextField(
      focusNode: myFocusNode,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      controller: widget.controller,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      keyboardType: TextInputType.multiline,
      cursorColor: Apptheme.accent,
      style: Apptheme.inputstyle,
      decoration:  InputDecoration(hintStyle: Apptheme.hintStyle,
      hintText: widget.hintText ,
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Apptheme.accent,),
      ),suffix: _copybutton(context),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Apptheme.medium)),
      counterStyle: Apptheme.counterStyle,
      )
      
    );
  }
  IconButton _copybutton (BuildContext Build){
return IconButton(onPressed: widget.controller.text.isNotEmpty ? ()=> copyToClipboard(context,widget.controller.text): null,
color: Apptheme.accent,
disabledColor: Apptheme.medium,
highlightColor: Apptheme.accent,
icon: Icon(Icons.content_copy_rounded,
),
);
  }
}