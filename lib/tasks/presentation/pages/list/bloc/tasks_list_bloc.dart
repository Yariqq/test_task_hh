import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_hh/tasks/domain/entity/task.dart';
import 'package:test_task_hh/tasks/presentation/pages/list/bloc/tasks_list_event.dart';
import 'package:test_task_hh/tasks/presentation/pages/list/bloc/tasks_list_state.dart';

class TasksListBloc extends Bloc<TasksListEvent, TasksListState> {
  TasksListBloc() : super(const TasksListState.initial()) {
    on<ChangeTaskStatusEvent>(_onChangeTaskStatusEvent);
    on<CreateTaskEvent>(_onCreateTaskEvent);
    on<ReplaceChangedTaskEvent>(_onReplaceChangedTaskEvent);
    on<DeleteTaskEvent>(_onDeleteTaskEvent);
  }

  void _onChangeTaskStatusEvent(
    ChangeTaskStatusEvent event,
    Emitter<TasksListState> emit,
  ) {
    final chosenTaskIndex = state.data.tasks.indexOf(event.task);
    final changedTask = event.task.copyWith(isActive: !event.value);

    List<Task> taskListToModify = List.from(state.data.tasks);

    taskListToModify
        .replaceRange(chosenTaskIndex, chosenTaskIndex + 1, [changedTask]);

    emit(TasksListState.success(state.data.copyWith(tasks: taskListToModify)));
  }

  void _onCreateTaskEvent(
    CreateTaskEvent event,
    Emitter<TasksListState> emit,
  ) {
    final newTask = Task(
      title: event.title,
      description: event.description,
      isActive: true,
    );

    List<Task> taskListToModify = List.from(state.data.tasks);

    taskListToModify.insert(0, newTask);

    emit(TasksListState.success(state.data.copyWith(tasks: taskListToModify)));
  }

  void _onReplaceChangedTaskEvent(
    ReplaceChangedTaskEvent event,
    Emitter<TasksListState> emit,
  ) {
    final taskIndex = state.data.tasks.indexOf(event.oldTask);

    List<Task> taskListToModify = List.from(state.data.tasks);

    taskListToModify.replaceRange(taskIndex, taskIndex + 1, [event.newTask]);

    emit(TasksListState.success(state.data.copyWith(tasks: taskListToModify)));
  }

  void _onDeleteTaskEvent(
    DeleteTaskEvent event,
    Emitter<TasksListState> emit,
  ) {
    List<Task> taskListToModify = List.from(state.data.tasks);

    taskListToModify.remove(event.task);

    emit(TasksListState.success(state.data.copyWith(tasks: taskListToModify)));
  }
}
