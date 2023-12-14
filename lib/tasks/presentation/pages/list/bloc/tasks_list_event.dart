import 'package:equatable/equatable.dart';
import 'package:test_task_hh/tasks/domain/entity/task.dart';

abstract class TasksListEvent extends Equatable {
  const TasksListEvent();

  const factory TasksListEvent.changeTaskStatus({
    required Task task,
    required bool value,
  }) = ChangeTaskStatusEvent;

  const factory TasksListEvent.createTask({
    required String title,
    required String description,
  }) = CreateTaskEvent;

  const factory TasksListEvent.replaceChangedTask({
    required Task oldTask,
    required Task newTask,
  }) = ReplaceChangedTaskEvent;

  const factory TasksListEvent.delete({
    required Task task,
  }) = DeleteTaskEvent;
}

class ChangeTaskStatusEvent extends TasksListEvent {
  final Task task;
  final bool value;

  const ChangeTaskStatusEvent({
    required this.task,
    required this.value,
  });

  @override
  List<Object?> get props => [task, value];
}

class CreateTaskEvent extends TasksListEvent {
  final String title;
  final String description;

  const CreateTaskEvent({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}

class ReplaceChangedTaskEvent extends TasksListEvent {
  final Task oldTask;
  final Task newTask;

  const ReplaceChangedTaskEvent({
    required this.oldTask,
    required this.newTask,
  });

  @override
  List<Object?> get props => [oldTask, newTask];
}

class DeleteTaskEvent extends TasksListEvent {
  final Task task;

  const DeleteTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}
