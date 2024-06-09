import 'sub_criteria.dart';

class Criteria {
  final int id;
  final String name;
  final String tag;
  final String color;
  final List<SubCriteria> criteria;

  Criteria(
      {required this.id,
      required this.name,
      required this.tag,
      required this.color,
      required this.criteria});

  factory Criteria.fromJson(Map<String, dynamic> json) {
    var list = json['criteria'] as List;
    List<SubCriteria> criteriaList =
        list.map((i) => SubCriteria.fromJson(i)).toList();

    return Criteria(
      id: json['id'],
      name: json['name'],
      tag: json['tag'],
      color: json['color'],
      criteria: criteriaList,
    );
  }
}
