import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:taskly/Models/task_Model.dart';
import 'package:taskly/View/home/widget/drawer_app.dart';
import 'package:taskly/View/home/widget/task_view.dart';
import 'package:taskly/extenton/space.dart';
import 'package:taskly/main.dart';
import 'package:taskly/utils/app_colors.dart';
import 'package:taskly/utils/app_string.dart';

import '../../../utils/animation.dart';
import '../components/slider_drawer.dart';
import 'Add_task.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  dynamic valueofindicator(List<Task> task){
    if (task.isNotEmpty){
      return task.length;
    }else{
      return 3;
    }
  }

  int checkDoneTask(List<Task> tasks){
    int i = 0;
    for(Task doneTask in tasks){
      if(doneTask.isCompleted){
        i++;
      }
    }
    return i;

  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final base = Basewidget.of(context);
    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTask(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();

          tasks.sort((a, b) => a.createdAtDate.compareTo(b.createdAtDate));
          return Scaffold(
              backgroundColor: Colors.white,
              floatingActionButton: (GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (_) => addTask(
                              titleTaskController: null,
                              discriptionTaskController: null,
                              task: null)));
                  // log("Task view "1);
                },
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Appcolor.primaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )),
              body: SliderDrawer(
                  key: drawerKey,
                  isDraggable: false,
                  animationDuration: 400,
                  appBar: HomeAppbar(drawerKey: drawerKey),
                  slider: CustomDrawer(),
                  child: _buildHomeBody(textTheme, base, tasks)));
        });
  }

  Widget _buildHomeBody(
      TextTheme textTheme, Basewidget base, List<Task> tasks) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              width: double.infinity,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                      value: checkDoneTask(tasks) / valueofindicator(tasks),
                      valueColor: AlwaysStoppedAnimation(Appcolor.primaryColor),
                    ),
                  ),
                  25.w,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStr.mainTitle,
                        style: textTheme.displayLarge,
                      ),
                      3.h,
                      Text(
                        "${checkDoneTask(tasks)} of ${tasks.length} task",
                        style: textTheme.titleMedium,
                      )
                    ],
                  )
                ],
              ),
            ),
            10.h,
            Divider(
              thickness: 2,
              indent: 100,
            ),
            SizedBox(
                width: double.infinity,
                height: 745,
                child: tasks.isNotEmpty
                    ? ListView.builder(
                        itemCount: tasks.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var task = tasks[index];
                          return Dismissible(
                              direction: DismissDirection.horizontal,
                              onDismissed: (_) {
                                base.dataStore.dalateTask(task: task);
                              },
                              background: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.delete_forever_outlined,
                                    color: Colors.grey,
                                  ),
                                  8.w,
                                  Text(
                                    AppStr.deletedTask,
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                              key: Key(task.id),
                              child: Taskview(
                                task: task,
                              ));
                        })
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeIn(
                            child: SizedBox(
                              width: 200,
                              height: 200,
                              child: Lottie.asset(
                                lottieURL,
                                animate: tasks.isNotEmpty ? false : true,
                              ),
                            ),
                          ),
                          FadeInUp(from: 30, child: Text(AppStr.doneAllTask))
                        ],
                      ))
          ],
        ),
      ),
    );
  }
}
