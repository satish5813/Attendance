import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Placeholder for map widget. In a real app, import google_maps_flutter and implement map.

void main() {
  runApp(const SampleCollectionApp());
}

class SampleCollectionApp extends StatelessWidget {
  const SampleCollectionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        title: 'Sample Collection',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const TaskListPage(),
      ),
    );
  }
}

class Task {
  final String id;
  final String description;
  final String customerLocation;
  bool assigned;

  Task({
    required this.id,
    required this.description,
    required this.customerLocation,
    this.assigned = false,
  });
}

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void assignTask(String id) {
    final task = _tasks.firstWhere((t) => t.id == id, orElse: () => throw Exception('Task not found'));
    task.assigned = true;
    notifyListeners();
  }
}

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: ListView(
        children: provider.tasks
            .map((task) => ListTile(
                  title: Text(task.description),
                  subtitle: Text(task.customerLocation),
                  trailing: task.assigned
                      ? const Icon(Icons.check, color: Colors.green)
                      : ElevatedButton(
                          onPressed: () => provider.assignTask(task.id),
                          child: const Text('Assign'),
                        ),
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addSampleTask(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addSampleTask(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      description: 'New sample order',
      customerLocation: 'Customer address',
    );
    provider.addTask(task);
  }
}
