import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskly/Models/task_Model.dart';
import 'package:taskly/View/home/widget/Add_task.dart';
import 'package:taskly/extenton/space.dart';

import '../../../utils/app_colors.dart';

class Taskview extends StatefulWidget {
  const Taskview({super.key, required this.task});

  final Task task;

  @override
  State<Taskview> createState() => _TaskviewState();
}

class _TaskviewState extends State<Taskview> {

  TextEditingController title1EditingController =TextEditingController();
  TextEditingController subtitileEditingController =TextEditingController();

  @override
  void initState() {
    title1EditingController.text = widget.task.title;
    subtitileEditingController.text = widget.task.subTitle;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {


    title1EditingController.dispose();
    subtitileEditingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder:
        (ctx)=>addTask(
            titleTaskController:  title1EditingController,
            discriptionTaskController: subtitileEditingController, task: widget.task)));
      },
      child: AnimatedContainer(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: widget.task.isCompleted
                  ? Color.fromARGB(154, 119, 144, 229)
                  : Colors.white60,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    offset: Offset(0, 4),
                    blurRadius: 10)
              ]),
          duration: Duration(milliseconds: 600),
          child: ListTile(
            leading: GestureDetector(
              onTap: () {
                widget.task.isCompleted = !widget.task.isCompleted;
                widget.task.save();
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 600),
                decoration: BoxDecoration(
                    color: widget.task.isCompleted
                        ? Appcolor.primaryColor
                        : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: .8)),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                // color: Colors.white,
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 5, top: 3),
              child: Text(
                title1EditingController.text,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitileEditingController.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    decoration: widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('hh.mm.a')
                              .format(widget.task.createdAtTime),
                          style: TextStyle(fontSize: 14, color:
                          widget.task.isCompleted?
                          Colors.white:Colors.grey[800]!),
                        ),
                        Text(
                          DateFormat.yMMMEd()
                              .format(widget.task.createdAtTime),
                          style: TextStyle(fontSize: 14, color:
                          widget.task.isCompleted?
                          Colors.white:Colors.grey[800]!),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
