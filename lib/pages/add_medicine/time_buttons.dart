import 'package:flutter/material.dart';
import 'package:medminder/model/helper_functions.dart';

class TimePickerButtons extends StatefulWidget {
  final Function(List<DateTime>) onTimeChanged;

  const TimePickerButtons({super.key, required this.onTimeChanged});

  @override
  State<TimePickerButtons> createState() => _TimePickerButtonsState();
}

class _TimePickerButtonsState extends State<TimePickerButtons> {
  List<DateTime> selectedTimes = [];

  Future selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        DateTime time = timeofDaytoDateTime(pickedTime);
        selectedTimes.add(time);
        widget.onTimeChanged(selectedTimes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (var time in selectedTimes)
                Chip(
                  avatar: const Icon(Icons.alarm),
                  deleteIconColor: Colors.red,
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  label: Text(formatTime(time)),
                  onDeleted: () {
                    setState(() {
                      selectedTimes.remove(time);
                      widget.onTimeChanged(selectedTimes);
                    });
                  },
                )
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 180,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 25),
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () => selectTime(context),
            child: const Text('Add Time (s)'),
          ),
        ),
      ],
    );
  }
}
