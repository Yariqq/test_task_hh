import 'package:equatable/equatable.dart';
import 'package:test_task_hh/tasks/presentation/pages/details/bloc/task_details_bloc_data.dart';

abstract class TaskDetailsState extends Equatable {
  final TaskDetailsBlocData data;

  const TaskDetailsState(this.data);

  const factory TaskDetailsState.initial() = InitialState;

  const factory TaskDetailsState.success(TaskDetailsBlocData data) =
      SuccessState;
}

class InitialState extends TaskDetailsState {
  const InitialState() : super(const TaskDetailsBlocData.empty());

  @override
  List<Object?> get props => [];
}

class SuccessState extends TaskDetailsState {
  const SuccessState(TaskDetailsBlocData data) : super(data);

  @override
  List<Object?> get props => [data];
}
