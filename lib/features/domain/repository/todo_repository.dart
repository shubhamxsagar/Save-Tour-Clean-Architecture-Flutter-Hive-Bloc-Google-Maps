import 'package:arpan/common/toast.dart';
import 'package:arpan/features/data/todo_model.dart';
import 'package:hive/hive.dart';

class TodoRepository {
  late Box<TodoModel> _todo;

  Future<void> init() async {
    Hive.registerAdapter(TodoModelAdapter());
    _todo = await Hive.openBox<TodoModel>('todo_box');
  }

  List<TodoModel> getTodos(final int code) {
    final todos = _todo.values.where((element) => element.code == code);
    return todos.toList();
  }

  void addTodos(final String code, final String lat, final String lng,
      final String name, final int time, final int statusIndex) {
    final todo = TodoModel(
        code: code,
        lat: lat,
        lng: lng,
        name: name,
        time: time,
        statusIndex: statusIndex);
    _todo.add(todo).whenComplete(() => showToast('$name added successfully'));
  }

  Future<void> removeTodos(final String code, final String name) async {
    final taskToRemove = _todo.values
        .firstWhere((element) => element.code == code && element.name == name);
    await taskToRemove
        .delete()
        .whenComplete(() => showToast('$name deleted successfully'));
  }

  Future<void> updateTodos(
      final String code,
      final String lat,
      final String lng,
      final String name,
      final int time,
      final int statusIndex) async {
    final taskToEdit = _todo.values
        .firstWhere((element) => element.code == code && element.name == name);

    final index = taskToEdit.key as int;

    await _todo
        .put(
            index,
            TodoModel(
                code: code,
                lat: lat,
                lng: lng,
                name: name,
                time: time,
                statusIndex: statusIndex))
        .whenComplete(() => showToast('$name updated successfully'));
  }
}
