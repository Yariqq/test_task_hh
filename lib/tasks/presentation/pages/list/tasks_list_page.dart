import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_hh/common/common_size.dart';
import 'package:test_task_hh/tasks/presentation/pages/list/bloc/tasks_list_bloc.dart';
import 'package:test_task_hh/tasks/presentation/pages/list/bloc/tasks_list_event.dart';
import 'package:test_task_hh/tasks/presentation/pages/list/bloc/tasks_list_state.dart';
import 'package:test_task_hh/tasks/presentation/pages/list/widgets/create_task_bottom_sheet.dart';
import 'package:test_task_hh/tasks/presentation/pages/list/widgets/tasks_list_content.dart';

const _tabBarLength = 2;

class TasksListPage extends StatelessWidget {
  const TasksListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksListBloc(),
      child: BlocBuilder<TasksListBloc, TasksListState>(
        builder: (context, state) {
          final activeTasks =
              state.data.tasks.where((e) => e.isActive).toList();
          final nonActiveTasks =
              state.data.tasks.where((e) => !e.isActive).toList();

          return DefaultTabController(
            length: _tabBarLength,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                bottom: const TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.deepPurple,
                  tabs: [
                    Tab(text: 'Активные'),
                    Tab(text: 'Завершенные'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  TasksListContent(tasks: activeTasks),
                  TasksListContent(tasks: nonActiveTasks),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => _showCreateTaskBottomSheet(context),
                child: const Icon(Icons.add),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCreateTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(CommonSize.defaultRadius),
          topRight: Radius.circular(CommonSize.defaultRadius),
        ),
      ),
      builder: (builderContext) {
        return CreateTaskBottomSheet(
          onCreate: (title, description) {
            Navigator.of(builderContext).pop();
            _onCreateTask(context, title, description);
          },
        );
      },
    );
  }

  void _onCreateTask(BuildContext context, String title, String description) {
    context.read<TasksListBloc>().add(
          TasksListEvent.createTask(
            title: title,
            description: description,
          ),
        );
  }
}
