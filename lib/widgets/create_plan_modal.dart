import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreatePlanModal extends StatefulWidget {
  final Function(String, String, DateTime) onSubmit;

  const CreatePlanModal({super.key, required this.onSubmit});

  @override
  _CreatePlanModalState createState() => _CreatePlanModalState();
}

class _CreatePlanModalState extends State<CreatePlanModal> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create Plan"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Plan Name")),
          TextField(controller: _descController, decoration: const InputDecoration(labelText: "Description")),
          TextButton(
            onPressed: () async {
              DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100));
              if (picked != null) setState(() => _selectedDate = picked);
            },
            child: Text(DateFormat('yyyy-MM-dd').format(_selectedDate)),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onSubmit(_nameController.text, _descController.text, _selectedDate);
            Navigator.pop(context);
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
