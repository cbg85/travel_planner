import 'package:flutter/material.dart';

class CreatePlanModal extends StatefulWidget {
  final Function(String, String, DateTime) onSubmit;

  CreatePlanModal({required this.onSubmit});

  @override
  _CreatePlanModalState createState() => _CreatePlanModalState();
}

class _CreatePlanModalState extends State<CreatePlanModal> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submit() {
    if (_nameController.text.isEmpty || _descriptionController.text.isEmpty) return;
    widget.onSubmit(_nameController.text, _descriptionController.text, _selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Plan Name')),
          TextField(controller: _descriptionController, decoration: InputDecoration(labelText: 'Description')),
          ElevatedButton(
            child: Text('Select Date'),
            onPressed: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (picked != null) setState(() => _selectedDate = picked);
            },
          ),
          ElevatedButton(onPressed: _submit, child: Text('Add Plan')),
        ],
      ),
    );
  }
}
