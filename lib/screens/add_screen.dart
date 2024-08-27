import 'package:flutter/material.dart';
import 'package:todo_demo_app/utils/app_color.dart';
import 'package:todo_demo_app/widgets/custom_button.dart';
import 'package:todo_demo_app/widgets/custom_date_picker.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

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
              value: null,
              onDateSelected: (selectedDate) {},
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
              value: null,
              onDateSelected: (selectedDate) {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomButton(
        label: 'Create Now',
        onPressed: () {},
      ),
    );
  }
}
