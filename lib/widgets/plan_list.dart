import 'package:flutter/material.dart';
import '../models/plan.dart';

class PlanList extends StatelessWidget {
  final List<Plan> plans;
  final Function(String) onToggle;
  final Function(String) onDelete;
  final Function(String, String, String, DateTime) onEdit;

  const PlanList({
    super.key,
    required this.plans,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index];
        return Dismissible(
          key: Key(plan.id),
          direction: DismissDirection.horizontal,
          onDismissed: (_) => onToggle(plan.id),
          background: Container(color: Colors.green, child: const Icon(Icons.check, color: Colors.white)),
          secondaryBackground: Container(color: Colors.red, child: const Icon(Icons.delete, color: Colors.white)),
          child: Card(
            color: plan.isCompleted ? Colors.green[200] : Colors.white,
            child: ListTile(
              title: Text(plan.name, style: TextStyle(decoration: plan.isCompleted ? TextDecoration.lineThrough : null)),
              subtitle: Text(plan.description),
              trailing: Text("${plan.date.toLocal()}".split(' ')[0]),
              onLongPress: () {
                onEdit(plan.id, plan.name, plan.description, plan.date);
              },
            ),
          ),
        );
      },
    );
  }
}
