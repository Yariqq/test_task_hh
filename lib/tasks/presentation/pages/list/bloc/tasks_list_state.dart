import 'package:equatable/equatable.dart';
import 'package:test_task_hh/tasks/presentation/pages/list/bloc/tasks_list_bloc_data.dart';

abstract class TasksListState extends Equatable {
  final TasksListBlocData data;

  const TasksListState(this.data);

  const factory TasksListState.initial() = InitialState;

  const factory TasksListState.success(TasksListBlocData data) = SuccessState;
}

class InitialState extends TasksListState {
  const InitialState() : super(const TasksListBlocData.empty());

  @override
  List<Object?> get props => [];
}

class SuccessState extends TasksListState {
  const SuccessState(TasksListBlocData data) : super(data);

  @override
  List<Object?> get props => [data];
}
