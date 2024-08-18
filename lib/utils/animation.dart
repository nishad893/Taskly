


import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:taskly/main.dart';
import 'package:taskly/utils/app_string.dart';

String lottieURL = "assets/image/todo.json";


//textfield warning


 dynamic EmptyWarning(BuildContext context){
  return FToast.toast(context
  ,msg: AppStr.oopsMsg,
  subMsg: 'You Must Fill all Fields!',
  corner: 20.0,
  duration: 2000,
  padding: EdgeInsets.all(20.0));
}
dynamic updateTaskWarning(BuildContext context){
 return FToast.toast(context
     ,msg: AppStr.oopsMsg,
     subMsg: 'You Must edit the task then try to update it',
     corner: 20.0,
     duration: 2000,
     padding: EdgeInsets.all(20.0));
}

  dynamic noTaskwarning(BuildContext context){
  return PanaraInfoDialog.showAnimatedGrow(context,
      title: AppStr.oopsMsg,
      message: "There is no task for delete!",
      buttonText: "Okay",
      onTapDismiss: (){
   Navigator.pop(context);
      },
      panaraDialogType: PanaraDialogType.warning,);
}
dynamic deleteTaskwarning(BuildContext context){
 return PanaraConfirmDialog.show(context,
     title: AppStr.areYouSure,
     message: "Do you Really want to delete all Tasks?",
     confirmButtonText: "Yes",
     cancelButtonText: "No",
     onTapConfirm: (){

    Basewidget.of(context).dataStore.box.clear();
    Navigator.pop(context);

     },
     onTapCancel: (){
  Navigator.pop(context);
     },
     panaraDialogType: PanaraDialogType.error,
 );
}




