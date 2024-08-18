import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskly/extenton/space.dart';
import 'package:taskly/utils/app_colors.dart';

class CustomDrawer extends StatefulWidget {
 CustomDrawer({super.key});



  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final List<IconData> icons1 =[
    CupertinoIcons.home,
    CupertinoIcons.person,
    CupertinoIcons.settings,
    CupertinoIcons.info
  ];

  final List<String>texts1 = [
    "Home",
    "Profile",
    "Settings",
    "Details",
  ];


  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 90),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: Appcolor.primaryGradientColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
      )),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage("https://avatars.githubusercontent.com/u/91388754?v=4"),
          ),
          8.h,
          Text("Nishad",style: textTheme.displayMedium,)
          ,Text("Flutter developer",style: textTheme.bodySmall,),
          Container(
            width: double.infinity,
            height: 300,
            child: ListView.builder(

                itemCount: icons1.length,
                itemBuilder: (BuildContext context,int index){
                  return
                    Container(
                      child: ListTile(
                        leading: Icon(icons1[index],size: 30,color: Colors.white
                          ,),
                        title: Text(texts1[index],style:
                          TextStyle(color: Colors.white),),

                      ),
                    );
                }),

          )

          
        ],
      ),

    );
  }
}
