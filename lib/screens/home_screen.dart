import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:todo_demo_app/models/todo.dart';
import 'package:todo_demo_app/repositories/todo_repository.dart';
import 'package:todo_demo_app/utils/app_color.dart';
import 'package:todo_demo_app/widgets/custom_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todoRepo = TodoRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.red,
        onPressed: () {
          Navigator.pushNamed(context, '/add').then((_) {
            setState(() {});
          });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: FutureBuilder(
        future: todoRepo.getAllTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final data = snapshot.data?[index];

                var id = data?.id ?? '';
                var title = data?.title ?? '';
                var startDate = data?.startDate ?? '';
                var endDate = data?.endDate ?? '';
                var status = data?.status ?? '';

                return GestureDetector(
                  onTap: status == 'Incomplete'
                      ? () {
                          Navigator.pushNamed(context, '/edit', arguments: data).then((_) {
                            setState(() {});
                          });
                        }
                      : null,
                  child: CustomCard(
                    title: title,
                    startDate: Jiffy.parse(startDate, pattern: 'dd MMM yyyy, h:mm a').format(pattern: 'dd MMM yyyy'),
                    endDate: Jiffy.parse(endDate, pattern: 'dd MMM yyyy, h:mm a').format(pattern: 'dd MMM yyyy'),
                    status: status,
                    isCompleted: status == 'Incomplete' ? false : true,
                    onValueChanged: (val) {
                      final data = Todo(
                        id: id,
                        title: title,
                        startDate: startDate,
                        endDate: endDate,
                        status: !val ? 'Incomplete' : 'Completed',
                      );

                      todoRepo.updateTodo(data).then((_) {
                        setState(() {});
                      });
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No Record Found'));
        },
      ),
    );
  }
}
