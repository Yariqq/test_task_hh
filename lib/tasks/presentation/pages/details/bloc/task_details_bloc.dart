import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_hh/tasks/presentation/pages/details/bloc/task_details_event.dart';
import 'package:test_task_hh/tasks/presentation/pages/details/bloc/task_details_state.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailsState> {
  TaskDetailsBloc() : super(const TaskDetailsState.initial()) {
    on<InitialEvent>(_onInitialEvent);
    on<EditEvent>(_onEditEvent);
    on<SaveChangesEvent>(_onSaveChangesEvent);
    on<OnChangeStatusEvent>(_onChangeStatusEvent);
  }

  void _onInitialEvent(
    InitialEvent event,
    Emitter<TaskDetailsState> emit,
  ) {
    emit(
      TaskDetailsState.success(state.data.copyWith(task: event.task)),
    );
  }

  void _onEditEvent(
    EditEvent event,
    Emitter<TaskDetailsState> emit,
  ) {
    emit(
      TaskDetailsState.success(
        state.data.copyWith(shouldEdit: !state.data.shouldEdit),
      ),
    );
  }

  void _onSaveChangesEvent(
    SaveChangesEvent event,
    Emitter<TaskDetailsState> emit,
  ) {
    emit(
      TaskDetailsState.success(
        state.data.copyWith(
          task: state.data.task.copyWith(
            title: event.title,
            description: event.description,
          ),
        ),
      ),
    );

    add(const TaskDetailsEvent.edit());
  }

  void _onChangeStatusEvent(
    OnChangeStatusEvent event,
    Emitter<TaskDetailsState> emit,
  ) {
    emit(
      TaskDetailsState.success(
        state.data.copyWith(
          task: state.data.task.copyWith(
            isActive: !state.data.task.isActive,
          ),
        ),
      ),
    );
  }
}
