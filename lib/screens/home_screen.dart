import 'package:flutter/material.dart';
import 'package:todo_demo_app/utils/app_color.dart';
import 'package:todo_demo_app/widgets/custom_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 1,
        itemBuilder: (context, index) {
          return CustomCard(
            title: 'Automated Testing Script',
            startDate: '21 Oct 2024',
            endDate: '23 Oct 2024',
            status: 'Incomplete',
            onValueChanged: (val) {},
          );
        },
      ),
    );
  }
}
