import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sapient/controllers/todo_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Color> colors = [
    Colors.pink.shade800,
    Colors.pink.shade700,
    Colors.pink.shade600,
    Colors.pink.shade500,
    Colors.pinkAccent,
    Colors.pink.shade400,
    Colors.pink.shade300,
    Colors.pink.shade200,
    Colors.pink.shade100
  ];
  final _formKey = GlobalKey<FormState>();
  TextEditingController _taskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(
        init: TodoController(),
        initState: (_) {},
        builder: (todoController) {
          todoController.getData();
          return Scaffold(
            appBar: AppBar(title: Text('My List')),
            body: Center(
                child: todoController.isLoading
                    ? const SizedBox(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: todoController.taskList.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            background: Container(
                              alignment: Alignment.centerRight,
                              color: Colors.red,
                              // ignore: prefer_const_constructors
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.delete),
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              todoController.deleteTask(
                                  todoController.taskList[index].id);
                              setState(() {
                                todoController.taskList.removeAt(index);
                              });
                            },
                            key: ValueKey(index),
                            child: Card(
                              color: colors[index],
                              child: ListTile(
                                leading: Checkbox(
                                    value:
                                        todoController.taskList[index].isDone,
                                    onChanged: (value) =>
                                        todoController.addTodo(
                                            todoController.taskList[index].task,
                                            !todoController
                                                .taskList[index].isDone,
                                            todoController.taskList[index].id)),
                                title:
                                    Text(todoController.taskList[index].task),
                                trailing: SizedBox(
                                    width: 50,
                                    child: Row(children: [
                                      IconButton(
                                          onPressed: () => addTaskDialog(
                                              todoController,
                                              'Update Task',
                                              todoController.taskList[index].id,
                                              todoController
                                                  .taskList[index].task),
                                          icon: const Icon(Icons.edit))
                                    ])),
                              ),
                            ),
                          );
                        })),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async =>
                  await addTaskDialog(todoController, 'Add Task', '', ''),
            ),
          );
        });
  }

  addTaskDialog(TodoController todoController, String title, String id,
      String task) async {
    if (task.isNotEmpty) {
      _taskController.text = task;
    }
    Get.defaultDialog(
      title: title,
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _taskController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Cannot be empty';
                }
                return null;
              },
            ),
            ElevatedButton(
              // ignore: await_only_futures
              onPressed: () async {
                // ignore: await_only_futures
                await todoController.addTodo(
                    _taskController.text.trim(), false, id);
                _taskController.clear();
                Get.back();
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
