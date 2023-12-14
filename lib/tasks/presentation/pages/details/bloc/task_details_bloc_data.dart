import 'package:equatable/equatable.dart';
import 'package:test_task_hh/tasks/domain/entity/task.dart';

class TaskDetailsBlocData extends Equatable {
  final Task task;
  final bool shouldEdit;

  const TaskDetailsBlocData({
    required this.task,
    required this.shouldEdit,
  });

  TaskDetailsBlocData copyWith({
    Task? task,
    bool? shouldEdit,
  }) {
    return TaskDetailsBlocData(
      task: task ?? this.task,
      shouldEdit: shouldEdit ?? this.shouldEdit,
    );
  }

  const TaskDetailsBlocData.empty()
      : task = const Task.empty(),
        shouldEdit = false;

  @override
  List<Object?> get props => [task, shouldEdit];
}
