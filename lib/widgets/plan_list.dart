import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/plan.dart';

class PlanList extends StatelessWidget {
  final List<Plan> plans;
  final Function(int) onToggleComplete;
  final Function(int, String, String) onUpdate;
  final Function(int) onDelete;

  const PlanList({
    super.key,
    required this.plans,
    required this.onToggleComplete,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index];
        return GestureDetector(
          onDoubleTap: () => onDelete(index),
          onLongPress: () {
            TextEditingController nameController =
            TextEditingController(text: plan.name);
            TextEditingController descController =
            TextEditingController(text: plan.description);

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Edit Plan"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: nameController),
                    TextField(controller: descController),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      onUpdate(index, nameController.text, descController.text);
                      Navigator.pop(context);
                    },
                    child: const Text("Update"),
                  ),
                ],
              ),
            );
          },
          child: Slidable(
            key: ValueKey(plan.name),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => onToggleComplete(index),
                  backgroundColor: Colors.green,
                  icon: Icons.check,
                  label: plan.isCompleted ? "Undo" : "Complete",
                ),
              ],
            ),
            child: Card(
              color: plan.isCompleted ? Colors.green[200] : Colors.white,
              child: ListTile(
                title: Text(plan.name,
                    style: TextStyle(
                        decoration: plan.isCompleted
                            ? TextDecoration.lineThrough
                            : null)),
                subtitle: Text(plan.description),
                trailing: Text("${plan.date.toLocal()}".split(' ')[0]),
              ),
            ),
          ),
        );
      },
    );
  }
}
