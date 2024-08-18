import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:intl/intl.dart';
import 'package:taskly/Models/task_Model.dart';
import 'package:taskly/extenton/space.dart';
import 'package:taskly/main.dart';
import 'package:taskly/utils/animation.dart';
import 'package:taskly/utils/app_colors.dart';
import 'package:taskly/utils/app_string.dart';

class addTask extends StatefulWidget {
  const addTask(
      {super.key,
      required this.titleTaskController,
      required this.discriptionTaskController,
      required this.task});
  final TextEditingController? titleTaskController;
  final TextEditingController? discriptionTaskController;
  final Task? task;

  @override
  State<addTask> createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  var title;
  var subTitle;
  DateTime? time;
  DateTime? date;

  //shoe selected time as string

  String showtime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm:a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm:a').format(time).toString();
      }
    } else {
      return DateFormat('hh:mm:a')
          .format(widget.task!.createdAtTime)
          .toString();
    }
  }

  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate).toString();
    }
  }

  // show select date as Dateformat for initial Time

  DateTime showDateasdatetime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.createdAtDate;
    }
  }

  bool isTaskAlreadyexist() {
    if (widget.titleTaskController?.text == null &&
        widget.discriptionTaskController?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  dynamic isTaskisAlreadyExistupdateotherwisecreate() {
    if (widget.titleTaskController?.text != null &&
        widget.discriptionTaskController?.text != null) {
      try {
        widget.titleTaskController?.text = title;
        widget.discriptionTaskController?.text = subTitle;

        widget.task?.save();
        Navigator.pop(context);
      } catch (e) {
        /// if user wANT TO UPDATE TASK BUT ENTERED nothing we will show this warning

        updateTaskWarning(context);
      }
    } else {
      if (title != null && subTitle != null) {
        var task = Task.create(
            title: title,
            subTitle: subTitle,
            createdAtDate: date,
            createdAtTime: time);

        /// we are this new task hive using base widget
        Basewidget.of(context).dataStore.addTask(task: task);
        Navigator.pop(context);
      } else {
        EmptyWarning(context);
      }
    }
  }

  ///delete task
  dynamic deleteTask(){
    return widget.task?.delete();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(CupertinoIcons.back)),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTopSidetext(textTheme),

                _addTaskViewwidget(textTheme, context),

                //slide button
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: isTaskAlreadyexist()
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceEvenly,
                    children: [
                      isTaskAlreadyexist()
                          ? Container()
                          : MaterialButton(
                              onPressed: () {
                                deleteTask();
                                Navigator.pop(context);
                              },
                              minWidth: 150,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 55,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Appcolor.primaryColor,
                                  ),
                                  Text(
                                    AppStr.deleteTask,
                                    style: TextStyle(
                                      color: Appcolor.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      MaterialButton(
                        onPressed: () {
                          isTaskisAlreadyExistupdateotherwisecreate();
                        },
                        minWidth: 150,
                        color: Appcolor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 55,
                        child: Row(
                          children: [
                            Text( isTaskAlreadyexist()?
                              AppStr.addTaskString : AppStr.updateTaskString,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(150);

  Widget _buildTopSidetext(TextTheme textTheme) {
    return Container(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
          RichText(
              text: TextSpan(
                  text: isTaskAlreadyexist()
                      ? AppStr.addNewTask
                      : AppStr.updateCurrentTask,
                  style: textTheme.titleLarge,
                  children: [
                TextSpan(
                    text: AppStr.taskStrnig,
                    style: TextStyle(fontWeight: FontWeight.w400)),
              ])),
          SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _addTaskViewwidget(TextTheme textTheme, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 530,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //task title
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              AppStr.titleOfTitleTextField,
              style: textTheme.headlineMedium,
            ),
          ),
          RepTextfiels(
            Controller: widget.titleTaskController ?? TextEditingController(),
            onFieldSubmitted: (String inputTitle) {
              title = inputTitle;
            },
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
          ),
          10.h,

          RepTextfiels(
            Controller:
                widget.discriptionTaskController ?? TextEditingController(),
            isFordiscription: true,
            onFieldSubmitted: (String inputsubTitle) {
              subTitle = inputsubTitle;
            },
            onChanged: (String inputsubTitle) {
              subTitle = inputsubTitle;
            },
          ),

          ///time
          dateimeselect(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) => SizedBox(
                        height: 260,
                        child: TimePickerWidget(
                          onChange: (_, __) {},
                          dateFormat: 'HH:mm',
                          onConfirm: (dateTime, _) {
                            setState(() {
                              if (widget.task?.createdAtTime == null) {
                                time = dateTime;
                              } else {
                                widget.task!.createdAtTime = dateTime;
                              }
                            });
                          },
                        ),
                      ));
            },
            title: "Time",
            time: showtime(time),
            istime: false,
          ),
          dateimeselect(
            onTap: () {
              DatePicker.showDatePicker(context,
                  maxDateTime: DateTime(2040, 10, 10),
                  minDateTime: DateTime.now(),
                  initialDateTime: showDateasdatetime(date),
                  onConfirm: (dateTime, _) {
                setState(() {
                  if (widget.task?.createdAtDate == null) {
                    date = dateTime;
                  } else {
                    widget.task!.createdAtDate = dateTime;
                  }
                });
              });
            },
            title: AppStr.dateString,
            time: showDate(date),
            istime: true,
          )
        ],
      ),
    );
  }
}

class RepTextfiels extends StatelessWidget {
  const RepTextfiels(
      {super.key,
      required this.Controller,
      this.isFordiscription = false,
      required this.onFieldSubmitted,
      required this.onChanged});

  final TextEditingController Controller;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final bool isFordiscription;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        title: TextFormField(
          controller: Controller,
          maxLines: isFordiscription ? 3 : null,
          cursorHeight: isFordiscription ? 30 : null,
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
              border: isFordiscription ? InputBorder.none : null,
              counter: Container(),
              hintText: isFordiscription ? AppStr.addNote : null,
              prefixIcon: isFordiscription
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: const Icon(
                        CupertinoIcons.bookmark,
                        color: Colors.grey,
                      ),
                    )
                  : null,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300))),
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class dateimeselect extends StatelessWidget {
  const dateimeselect(
      {super.key,
      required this.onTap,
      required this.title,
      required this.time,
      required this.istime});

  final VoidCallback onTap;
  final String title;
  final String time;
  final bool istime;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        height: 55,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textTheme.headlineSmall,
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                width: istime ? 150 : 80,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                ),
                child: Center(
                  child: Text(
                    time,
                    style: textTheme.titleSmall,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
