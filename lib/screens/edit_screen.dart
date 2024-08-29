import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:todo_demo_app/models/todo.dart';
import 'package:todo_demo_app/repositories/todo_repository.dart';
import 'package:todo_demo_app/utils/app_color.dart';
import 'package:todo_demo_app/widgets/custom_button.dart';
import 'package:todo_demo_app/widgets/custom_date_picker.dart';

class EditScreen extends StatefulWidget {
  final Todo currentData;

  const EditScreen({super.key, required this.currentData});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController _title = TextEditingController();

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  final String _status = 'Incomplete';

  final todoRepo = TodoRepository();

  @override
  void initState() {
    super.initState();

    _title.text = widget.currentData.title ?? '';
    _startDate = Jiffy.parse(widget.currentData.startDate ?? '', pattern: 'dd MMM yyyy, h:mm a').dateTime;
    _endDate = Jiffy.parse(widget.currentData.endDate ?? '', pattern: 'dd MMM yyyy, h:mm a').dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit / Update To-Do List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete Operation'),
                  content: const Text('Are you confirm to proceed?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        child: const Text('No'),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        todoRepo.deleteTodo(widget.currentData).then((_) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        color: AppColors.primary,
                        padding: const EdgeInsets.all(14),
                        child: const Text('Yes'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
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
        label: 'Edit / Update',
        onPressed: () {
          final title = _title.text;
          final startDate = _startDate;
          final endDate = _endDate;
          final status = _status;

          final data = Todo(
            id: widget.currentData.id,
            title: title,
            startDate: Jiffy.parseFromDateTime(startDate).format(pattern: 'dd MMM yyyy, h:mm a'),
            endDate: Jiffy.parseFromDateTime(endDate).format(pattern: 'dd MMM yyyy, h:mm a'),
            status: status,
          );

          todoRepo.updateTodo(data).then((_) {
            Navigator.pop(context);
          });
        },
      ),
    );
  }
}
