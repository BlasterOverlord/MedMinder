import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatefulWidget {
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _bloodGroupController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  bool _isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Profile' : 'Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditMode ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditMode = !_isEditMode;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground, // Default border color
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black12, // Default border color
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              enabled: _isEditMode,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground, // Default border color
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black12, // Default border color
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              enabled: _isEditMode,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _bloodGroupController,
              decoration: InputDecoration(
                labelText: 'Blood Group',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground, // Default border color
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black12, // Default border color
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              enabled: _isEditMode,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground, // Default border color
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black12, // Default border color
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              enabled: _isEditMode,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (Kg)',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground, // Default border color
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black12, // Default border color
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              enabled: _isEditMode,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
