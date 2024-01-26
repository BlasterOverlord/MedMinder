import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medminder/database/databaseService.dart';
import 'package:medminder/model/helper_functions.dart';
import 'package:medminder/model/medicine_time.dart';
import 'package:medminder/model/medicine_type.dart';

class UpcomingMeds extends StatefulWidget {
  final DateTime selectedDate;
  const UpcomingMeds({super.key, required this.selectedDate});

  @override
  State<UpcomingMeds> createState() => _UpcomingMedsState();
}

class _UpcomingMedsState extends State<UpcomingMeds> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;

    return StreamBuilder(
      stream:
          DatabaseService().getMedicineTimesByUserID(uid, widget.selectedDate),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        } else if (snapshot.data == null) {
          return const Text('No data found!');
        } else if (snapshot.data!.isEmpty) {
          return const Text('No upcoming medicines');
        } else {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                MedicineTime medTime = snapshot.data![index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    enableFeedback: true,
                    leading: Image.asset(
                      medTime.medicine.medType?['image'],
                      width: 50,
                      height: 40,
                    ),
                    title: Text(medTime.medicine.name ?? 'No data found'),
                    trailing: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(formatTime(medTime.time)),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            const Text('Delete this medicine?'),
                                        content: const Text(
                                            'This will permanently delete the medicine!'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await DatabaseService()
                                                  .deleteMedicine(
                                                      medTime.medicine.id!);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              iconSize: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          medTime.medicine.amount ?? '',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          medTime.medicine.medType?['name'],
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
