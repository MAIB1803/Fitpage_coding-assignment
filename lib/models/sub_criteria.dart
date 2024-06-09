class SubCriteria {
  final String type;
  final String text;
  final Map<String, dynamic>? variable;

  SubCriteria({required this.type, required this.text, this.variable});

  factory SubCriteria.fromJson(Map<String, dynamic> json) {
    return SubCriteria(
      type: json['type'],
      text: json['text'],
      variable: json['variable'],
    );
  }
}
