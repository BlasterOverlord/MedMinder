import 'package:flutter/material.dart';
import 'package:week_date_picker/week_date_picker.dart';

class Calendar extends StatefulWidget {
  final Function(DateTime) onDateChange;
  const Calendar({super.key, required this.onDateChange});

  @override
  State<Calendar> createState() => _CalendarState();

  getSelectedDate() {}
}

class _CalendarState extends State<Calendar> {
  var selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return WeekDatePickerView(
      changeDay: (date) => setState(() {
        selectedDate = date;
        widget.onDateChange(selectedDate);
      }),
      selectedDay: selectedDate,
      config: WeekDataPickerConfig(
        enableWeekNumberText: false,
        weekDayCapitalize: true,
        backgroundColor: theme.colorScheme.background,
        selectedBackgroundColor:
            theme.colorScheme.primary.withOpacity(0.75),
        selectedDigitColor: theme.colorScheme.onPrimary,
        digitsColor: theme.colorScheme.onBackground,
        weekDayTextColor: theme.colorScheme.onBackground.withOpacity(0.5),
        weekDayType: WeekDayType.TYPE_3,
        enableMonthText: true,
      ),
    );
  }
}
