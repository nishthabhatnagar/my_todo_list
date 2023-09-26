import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todos = [];

  void _addTodo(String todo) {
    setState(() {
      _todos.add(todo);
    });
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_todos[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _removeTodo(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTodo = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: Text('Add Todo'),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      autofocus: true,
                      onSubmitted: (value) {
                        Navigator.pop(context, value);
                      },
                    ),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      TextButton(
                        child: Text('Add'),
                        onPressed: () {
                          Navigator.pop(context, '');
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          );
          if (newTodo!.isNotEmpty) {
            _addTodo(newTodo!);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
