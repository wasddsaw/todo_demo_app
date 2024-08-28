import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:todo_demo_app/models/todo.dart';
import 'package:todo_demo_app/repositories/todo_repository.dart';
import 'package:todo_demo_app/utils/app_color.dart';
import 'package:todo_demo_app/widgets/custom_button.dart';
import 'package:todo_demo_app/widgets/custom_date_picker.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _title = TextEditingController();

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  final String _status = 'Incomplete';

  final todoRepo = TodoRepository();

  addNewTodo() {
    final title = _title.text;
    final startDate = _startDate;
    final endDate = _endDate;
    final status = _status;

    final data = Todo(
      title: title,
      startDate: Jiffy.parseFromDateTime(startDate).format(pattern: 'dd MMM yyyy, h:mm a'),
      endDate: Jiffy.parseFromDateTime(endDate).format(pattern: 'dd MMM yyyy, h:mm a'),
      status: status,
    );

    todoRepo.addNewTodo(data).then((_) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new To-Do List'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'To-Do Title',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.subTitle,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _title,
              cursorColor: AppColors.black,
              maxLines: 4,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.black,
                  ),
                ),
                hintText: 'Please key in your To-Do title here',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Start Date',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.subTitle,
              ),
            ),
            const SizedBox(height: 10),
            CustomDatePicker(
              firstDate: DateTime.now(),
              lastDate: DateTime(2050, 1, 1),
              value: _startDate,
              onDateSelected: (selectedDate) {
                setState(() {
                  _startDate = selectedDate;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Estimate End Date',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.subTitle,
              ),
            ),
            const SizedBox(height: 10),
            CustomDatePicker(
              firstDate: DateTime.now(),
              lastDate: DateTime(2050, 1, 1),
              value: _endDate,
              onDateSelected: (selectedDate) {
                setState(() {
                  _endDate = selectedDate;
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomButton(
        label: 'Create Now',
        onPressed: addNewTodo,
      ),
    );
  }
}
