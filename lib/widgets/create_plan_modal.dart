import 'package:flutter/material.dart';

class CreatePlanModal extends StatefulWidget {
  final Function(String, String, DateTime) onAddPlan;

  const CreatePlanModal({super.key, required this.onAddPlan});

  @override
  _CreatePlanModalState createState() => _CreatePlanModalState();
}

class _CreatePlanModalState extends State<CreatePlanModal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submit() {
    widget.onAddPlan(_nameController.text, _descriptionController.text, _selectedDate);
    Navigator.pop(context);
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create Plan"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Plan Name")),
          TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: "Description")),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: _pickDate, child: const Text("Pick a Date")),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(onPressed: _submit, child: const Text("Add Plan")),
      ],
    );
  }
}
