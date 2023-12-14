import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_hh/common/common_size.dart';
import 'package:test_task_hh/tasks/domain/entity/task.dart';
import 'package:test_task_hh/tasks/presentation/pages/details/task_details_page.dart';
import 'package:test_task_hh/tasks/presentation/pages/list/bloc/tasks_list_bloc.dart';
import 'package:test_task_hh/tasks/presentation/pages/list/bloc/tasks_list_event.dart';

const _taskContainerRadius = 12.0;
const _containerShadowColorOpacity = 0.6;
const _containerShadowBlurRadius = 7.0;
const _containerShadowOffset = Offset(0, 1.0);

class TasksListContent extends StatelessWidget {
  final List<Task> tasks;

  const TasksListContent({required this.tasks, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: CommonSize.paddingDefault,
        vertical: CommonSize.paddingLarge,
      ),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _navigateToTaskDetails(context, tasks[index]),
                child: Container(
                  padding: const EdgeInsets.all(CommonSize.paddingDefault),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(_taskContainerRadius),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(_containerShadowColorOpacity),
                        blurRadius: _containerShadowBlurRadius,
                        offset: _containerShadowOffset,
                      ),
                    ],
                  ),
                  child: Text(
                    tasks[index].title,
                  ),
                ),
              ),
            ),
            Checkbox(
              value: !tasks[index].isActive,
              onChanged: (value) => _onChangeTaskStatus(
                context,
                task: tasks[index],
                value: value ?? false,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: CommonSize.paddingDefault);
      },
    );
  }

  void _onChangeTaskStatus(
    BuildContext context, {
    required Task task,
    required bool value,
  }) {
    context.read<TasksListBloc>().add(
          TasksListEvent.changeTaskStatus(task: task, value: value),
        );
  }

  void _navigateToTaskDetails(BuildContext context, Task task) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => TaskDetailsPage(task: task),
      ),
    )
        .then((value) {
      if (value is Task) {
        context.read<TasksListBloc>().add(
              TasksListEvent.replaceChangedTask(oldTask: task, newTask: value),
            );
      }

      if (value is bool && value == true) {
        context.read<TasksListBloc>().add(TasksListEvent.delete(task: task));
      }
    });
  }
}
