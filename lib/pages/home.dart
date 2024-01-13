import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medminder/widgets/upcoming.dart';
import '../widgets/calendar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: theme.textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Calendar(
                onDateChange: (date) => setState(
                      () => selectedDate = date,
                    )),
            const SizedBox(height: 8),
            Text(
              'Upcoming',
              style: theme.textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                DateFormat.yMMMd('en_US').format(selectedDate),
                style: theme.textTheme.labelSmall,
              ),
            ),
            const SizedBox(height: 16),
            UpcomingMeds(
              selectedDate: selectedDate,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            Theme.of(context).colorScheme.primary.withOpacity(0.75),
        foregroundColor: theme.colorScheme.onPrimary,
        shape: const CircleBorder(),
        elevation: 12.0,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
      ),
    );
  }
}
