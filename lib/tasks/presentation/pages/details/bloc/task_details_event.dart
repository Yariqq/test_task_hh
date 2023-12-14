import 'package:equatable/equatable.dart';
import 'package:test_task_hh/tasks/domain/entity/task.dart';

abstract class TaskDetailsEvent extends Equatable {
  const TaskDetailsEvent();

  const factory TaskDetailsEvent.initial(Task task) = InitialEvent;

  const factory TaskDetailsEvent.edit() = EditEvent;

  const factory TaskDetailsEvent.saveChanges({
    required String title,
    required String description,
  }) = SaveChangesEvent;

  const factory TaskDetailsEvent.onChangeTaskStatus() = OnChangeStatusEvent;
}

class InitialEvent extends TaskDetailsEvent {
  final Task task;

  const InitialEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class EditEvent extends TaskDetailsEvent {
  const EditEvent();

  @override
  List<Object?> get props => [];
}

class SaveChangesEvent extends TaskDetailsEvent {
  final String title;
  final String description;

  const SaveChangesEvent({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}

class OnChangeStatusEvent extends TaskDetailsEvent {
  const OnChangeStatusEvent();

  @override
  List<Object?> get props => [];
}
