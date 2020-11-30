part of 'taskflow.dart';

class ParallelTaskResult extends TaskResult {}

class ParallelTask implements Task {
  @override
  Object get key => _key ?? this;
  final Object? _key;

  List<Task> tasks;

  ParallelTask(this.tasks, {Object? key}) : _key = key;

  @override
  Future<TaskResult> call(TaskFlowContext context) async {
    if (context.isCanceled) return TaskResult.canceled();

    await Future.wait(tasks.map((t) => t(context)));
    return ParallelTaskResult();
  }
}
