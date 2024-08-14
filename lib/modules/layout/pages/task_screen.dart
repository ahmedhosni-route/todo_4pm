import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_4pm/core/models/task_model.dart';
import 'package:todo_4pm/core/service/firebase_functions.dart';
import 'package:todo_4pm/modules/layout/manager/main_provider.dart';
import 'package:todo_4pm/modules/layout/widgets/task_widget.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: const Alignment(
                0,
                2.5,
              ),
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "To Do List",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                EasyInfiniteDateTimeLine(
                  // controller: _controller,
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  focusDate: provider.selectedTime,
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  activeColor: Colors.blue,
                  selectionMode: const SelectionMode.autoCenter(),
                  dayProps: EasyDayProps(
                      borderColor: Colors.blue,
                      activeDayStyle: DayStyle(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      disabledDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      todayStyle: DayStyle(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue.withOpacity(0.8))),
                      inactiveDayStyle: DayStyle(
                          decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ))),

                  showTimelineHeader: false,

                  onDateChange: provider.setTime,
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            FutureBuilder(
              future: provider.getTask(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("has Error"),
                  );
                } else {
                  List<TaskModel?> tasks =
                      (snapshot.data!.docs.map((e) => e.data()).toList());
                  return Expanded(
                      child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return TaskWidget(task: tasks[index]!);
                    },
                  ));
                }
              },
            )
          ],
        );
      },
    );
  }
}
