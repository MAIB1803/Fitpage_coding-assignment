import 'package:flutter/material.dart';
import '../models/criteria.dart';

class CriteriaTile extends StatelessWidget {
  final Criteria criteria;

  CriteriaTile({required this.criteria});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(criteria.name),
      subtitle: Text(criteria.tag,
          style: TextStyle(
              color: criteria.color == "green" ? Colors.green : Colors.red)),
      children: criteria.criteria.map((subCriteria) {
        return ListTile(
          title: Text(subCriteria.text),
        );
      }).toList(),
    );
  }
}
