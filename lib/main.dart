import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'models/plan.dart';

void main() {
  runApp(const AdoptionTravelPlannerApp());
}

class AdoptionTravelPlannerApp extends StatelessWidget {
  const AdoptionTravelPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adoption & Travel Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PlanManagerScreen(),
    );
  }
}

class PlanManagerScreen extends StatefulWidget {
  const PlanManagerScreen({super.key});

  @override
  _PlanManagerScreenState createState() => _PlanManagerScreenState();
}

class _PlanManagerScreenState extends State<PlanManagerScreen> {
  final List<Plan> _plans = [];

  void _addPlan(String name, String description, DateTime date) {
    setState(() {
      _plans.add(Plan(
        id: const Uuid().v4(),
        name: name,
        description: description,
        date: date,
      ));
    });
  }

  void _toggleCompletion(String id) {
    setState(() {
      final plan = _plans.firstWhere((p) => p.id == id);
      plan.toggleCompleted();
    });
  }

  void _editPlan(String id, String newName, String newDescription, DateTime newDate) {
    setState(() {
      final planIndex = _plans.indexWhere((p) => p.id == id);
      if (planIndex != -1) {
        _plans[planIndex] = Plan(
          id: id,
          name: newName,
          description: newDescription,
          date: newDate,
          isCompleted: _plans[planIndex].isCompleted,
        );
      }
    });
  }

  void _deletePlan(String id) {
    setState(() {
      _plans.removeWhere((p) => p.id == id);
    });
  }

  void _showCreatePlanDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Create Plan"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Plan Name"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    selectedDate = pickedDate;
                  }
                },
                child: const Text("Pick a Date"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _addPlan(nameController.text, descriptionController.text, selectedDate);
                Navigator.pop(context);
              },
              child: const Text("Add Plan"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adoption & Travel Planner")),
      body: ListView.builder(
        itemCount: _plans.length,
        itemBuilder: (context, index) {
          final plan = _plans[index];
          return GestureDetector(
            onDoubleTap: () => _deletePlan(plan.id),
            onLongPress: () {
              _showEditPlanDialog(plan);
            },
            child: Dismissible(
              key: Key(plan.id),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) => _toggleCompletion(plan.id),
              background: Container(color: Colors.green, child: const Icon(Icons.check, color: Colors.white)),
              secondaryBackground: Container(color: Colors.red, child: const Icon(Icons.delete, color: Colors.white)),
              child: Card(
                color: plan.isCompleted ? Colors.green[200] : Colors.white,
                child: ListTile(
                  title: Text(plan.name, style: TextStyle(decoration: plan.isCompleted ? TextDecoration.lineThrough : null)),
                  subtitle: Text(plan.description),
                  trailing: Text("${plan.date.toLocal()}".split(' ')[0]),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatePlanDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditPlanDialog(Plan plan) {
    TextEditingController nameController = TextEditingController(text: plan.name);
    TextEditingController descriptionController = TextEditingController(text: plan.description);
    DateTime selectedDate = plan.date;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Plan"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Plan Name")),
              TextField(controller: descriptionController, decoration: const InputDecoration(labelText: "Description")),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    selectedDate = pickedDate;
                  }
                },
                child: const Text("Pick a Date"),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                _editPlan(plan.id, nameController.text, descriptionController.text, selectedDate);
                Navigator.pop(context);
              },
              child: const Text("Update Plan"),
            ),
          ],
        );
      },
    );
  }
}
