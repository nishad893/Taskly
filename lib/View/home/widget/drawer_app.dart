


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:taskly/main.dart';
import 'package:taskly/utils/animation.dart';

class HomeAppbar extends StatefulWidget {
  const HomeAppbar({super.key, required this.drawerKey});

  final GlobalKey<SliderDrawerState> drawerKey;

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();
}

class _HomeAppbarState extends State<HomeAppbar> with SingleTickerProviderStateMixin {

  late AnimationController animateController;
  bool isDrawerOpenn= false;
  @override
  void initState() {
    animateController = AnimationController(vsync: this,duration:
    Duration(seconds: 1));
    super.initState();
  }
  @override
  void dispose() {
   animateController.dispose();
    super.dispose();
  }

  void onDrawerToggle(){
    setState(() {
      isDrawerOpenn = isDrawerOpenn;
      if(isDrawerOpenn){
        animateController.forward();
        widget.drawerKey.currentState!.openSlider();

      }else{
        animateController.reverse();
        widget.drawerKey.currentState!.closeSlider();
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    var base = Basewidget.of(context).dataStore.box;
    return SizedBox(
      width:  double.infinity,
      height: 50,

      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(onPressed: onDrawerToggle,

                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: animateController,
                    size: 40,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(onPressed:(){

                //remove all task in one click
                base.isEmpty ?noTaskwarning(context):
               deleteTaskwarning(context);


              },

                  icon: Icon(
                   CupertinoIcons.trash_fill,size: 30,color: Colors.black,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
