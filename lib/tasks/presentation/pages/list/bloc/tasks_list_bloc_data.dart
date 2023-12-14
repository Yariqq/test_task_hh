import 'package:equatable/equatable.dart';
import 'package:test_task_hh/tasks/domain/entity/task.dart';

const _mockedTasks = [
  Task(
    title: 'First task',
    description: 'Need to fix car',
    isActive: true,
  ),
  Task(
    title: 'Second task',
    description: 'Need to fix door',
    isActive: true,
  ),
  Task(
    title: 'Third task',
    description: 'Need to meet with parents',
    isActive: false,
  ),
  Task(
    title: 'Fourth task',
    description: 'Need to fix several bugs',
    isActive: true,
  ),
  Task(
    title: 'Fifth task',
    description: 'Need to fix finish test task',
    isActive: false,
  ),
];

class TasksListBlocData extends Equatable {
  final List<Task> tasks;

  const TasksListBlocData({
    required this.tasks,
  });

  TasksListBlocData copyWith({
    List<Task>? tasks,
  }) {
    return TasksListBlocData(
      tasks: tasks ?? this.tasks,
    );
  }

  const TasksListBlocData.empty() : tasks = _mockedTasks;

  @override
  List<Object?> get props => [tasks];
}
