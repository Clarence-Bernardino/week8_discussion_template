import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8datapersistence/Utilities/my_drawer.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';
import 'modal_todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    // access the list of todos in the provider
    Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todo;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
      ),
      drawer: MyDrawer(),
      body: StreamBuilder(
        stream: todosStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("No Todos Found"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: ((context, index) {
              Todo todo = Todo.fromJson(snapshot.data!.docs[index]);
              return Dismissible(
                key: Key(todo.id.toString()),
                onDismissed: (direction) {
                  context.read<TodoListProvider>().deleteTodo(todo);

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${todo.title} dismissed')));
                },
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete),
                ),
                child: ListTile(
                  title: Text(todo.title),
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: (bool? value) {
                      context
                          .read<TodoListProvider>()
                          .toggleStatus(todo, value!);
                    },
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          todo.id = snapshot.data?.docs[index].id;
                          // snapshop.data?.docs[index].id; // ACCESS ID
                          // snapshot.data?.docs[index].data() // ACESS DATA
                          // snapshop.data?.docs[index].data().title;
                          // snapshop.data?.docs[index].data().completed;
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => TodoModal(
                              type: 'Edit',
                              item: todo,
                            ),
                          );
                        },
                        icon: const Icon(Icons.create_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => TodoModal(
                              type: 'Delete',
                              item: todo,
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete_outlined),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => TodoModal(
              type: 'Add',
            ),
          );
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
