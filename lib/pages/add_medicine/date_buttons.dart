import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerButtons extends StatefulWidget {
  final Function(DateTime) onStartChanged;
  final Function(DateTime) onEndChanged;

  const DatePickerButtons(
      {super.key, required this.onStartChanged, required this.onEndChanged});

  @override
  State<DatePickerButtons> createState() => _DatePickerButtonsState();
}

class _DatePickerButtonsState extends State<DatePickerButtons> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  bool isStartSet = false;
  bool isEndSet = false;

  Future selectDate(BuildContext context, bool isStart) async {
    // ignore: unused_local_variable
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          isStartSet = true;
          startDate = pickedDate;
          widget.onStartChanged(pickedDate);
        } else {
          isEndSet = true;
          endDate = pickedDate;
          widget.onEndChanged(pickedDate);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 25),
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: () => selectDate(context, true),
            child: isStartSet
                ? Text(DateFormat.yMMMd('en_US').format(startDate))
                : const Text('Start Date'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 25),
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: () => selectDate(context, false),
            child: isEndSet
                ? Text(DateFormat.yMMMd('en_US').format(endDate))
                : const Text('End Date'),
          ),
        ),
      ],
    );
  }
}
