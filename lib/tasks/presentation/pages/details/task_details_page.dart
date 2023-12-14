import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_hh/common/common_size.dart';
import 'package:test_task_hh/tasks/domain/entity/task.dart';
import 'package:test_task_hh/tasks/presentation/pages/details/bloc/task_details_bloc.dart';
import 'package:test_task_hh/tasks/presentation/pages/details/bloc/task_details_event.dart';
import 'package:test_task_hh/tasks/presentation/pages/details/bloc/task_details_state.dart';

class TaskDetailsPage extends StatefulWidget {
  final Task task;

  const TaskDetailsPage({required this.task, super.key});

  @override
  State<StatefulWidget> createState() {
    return _TaskDetailsPageState();
  }
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TaskDetailsBloc()..add(TaskDetailsEvent.initial(widget.task)),
      child: BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  Navigator.of(context).pop(state.data.task);
                },
              ),
              title: Text(state.data.task.title),
              actions: [
                if (!state.data.shouldEdit)
                  IconButton(
                    onPressed: () => _shouldEditTask(context),
                    icon: const Icon(Icons.edit),
                  ),
                if (state.data.shouldEdit) ...[
                  IconButton(
                    onPressed: () => _saveChanges(context),
                    icon: const Icon(Icons.check),
                  ),
                  IconButton(
                    onPressed: () => _cancelEditing(context),
                    icon: const Icon(Icons.clear),
                  ),
                ],
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CommonSize.paddingDefault,
                vertical: CommonSize.paddingDoubleDefault,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          enabled: state.data.shouldEdit,
                          controller: _titleController,
                          decoration:
                              const InputDecoration(labelText: 'Заголовок'),
                        ),
                        const SizedBox(height: CommonSize.paddingDefault),
                        TextField(
                          enabled: state.data.shouldEdit,
                          controller: _descriptionController,
                          decoration:
                              const InputDecoration(labelText: 'Описание'),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _onChangeTaskStatus(context),
                          style: const ButtonStyle().copyWith(
                            padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(CommonSize.paddingDefault),
                            ),
                          ),
                          child: Text(
                            state.data.task.isActive
                                ? 'Завершить'
                                : 'Активировать',
                          ),
                        ),
                      ),
                      const SizedBox(width: CommonSize.paddingDefault),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          style: const ButtonStyle().copyWith(
                            padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(CommonSize.paddingDefault),
                            ),
                          ),
                          child: const Text('Удалить'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _shouldEditTask(BuildContext context) {
    context.read<TaskDetailsBloc>().add(const TaskDetailsEvent.edit());
  }

  void _saveChanges(BuildContext context) {
    context.read<TaskDetailsBloc>().add(
          TaskDetailsEvent.saveChanges(
            title: _titleController.text,
            description: _descriptionController.text,
          ),
        );
  }

  void _cancelEditing(BuildContext context) {
    final stateModelTask = context.read<TaskDetailsBloc>().state.data.task;

    _titleController.text = stateModelTask.title;
    _descriptionController.text = stateModelTask.description;

    _shouldEditTask(context);
  }

  void _onChangeTaskStatus(BuildContext context) {
    context.read<TaskDetailsBloc>().add(
          const TaskDetailsEvent.onChangeTaskStatus(),
        );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
