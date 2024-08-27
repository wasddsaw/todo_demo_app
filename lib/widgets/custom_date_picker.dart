import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:todo_demo_app/utils/app_color.dart';

class CustomDatePicker extends StatelessWidget {
  final String? label;
  final DateTime? value;
  final String placeholder;
  final void Function(DateTime value)? onDateSelected;
  final bool isRequired;
  final String? format;
  final DateTime? lastDate;
  final DateTime? firstDate;
  final DateTime? initialDate;
  final bool onlyBottomBorder;
  final bool isLabel;

  const CustomDatePicker({
    super.key,
    this.label,
    required this.value,
    this.placeholder = "Choose date",
    this.onDateSelected,
    this.isRequired = false,
    this.format,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onlyBottomBorder = false,
    this.isLabel = true,
  });

  void _openDatePicker(BuildContext context) async {
    var result = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1960, 1, 1),
    );
    if (result != null && onDateSelected != null) {
      onDateSelected?.call(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isLabel
            ? label != null
                ? Column(
                    children: [
                      Text(label!),
                      const SizedBox(height: 8),
                    ],
                  )
                : const SizedBox()
            : const SizedBox(),
        InkWell(
          onTap: onDateSelected != null
              ? () {
                  _openDatePicker(context);
                }
              : null,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              // border: Border.all(
              //   color: AppColors.black,
              // ),
            ),
            child: InputDecorator(
              decoration: isLabel
                  ? const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(),
                    )
                  : InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      labelText: label,
                      border: const OutlineInputBorder(),
                    ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value != null ? Jiffy.parseFromDateTime(value!).format(pattern: 'dd/MM/yyyy') : 'Select a date',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  onDateSelected != null
                      ? const Icon(
                          Icons.date_range_outlined,
                          color: AppColors.black,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
