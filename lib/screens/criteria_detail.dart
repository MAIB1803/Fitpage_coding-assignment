import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../models/criteria.dart';
import '../models/sub_criteria.dart';
import 'variable_detail.dart';
import 'indicator_detail.dart';
import 'value_detail.dart';

class CriteriaDetail extends StatelessWidget {
  final Criteria criteria;

  CriteriaDetail({required this.criteria});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          color: Colors.black, // Adjust the width as needed
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: const Color.fromARGB(255, 0, 125, 183),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        criteria.name,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        criteria.tag,
                        style: TextStyle(
                          color: criteria.color == 'green'
                              ? Colors.green
                              : criteria.color == 'red'
                                  ? Colors.red
                                  : Colors.yellow,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ...criteria.criteria.map((subCriteria) {
                  if (subCriteria.type == "plain_text") {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        subCriteria.text,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16),
                      ),
                    );
                  } else if (subCriteria.type == "variable") {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: RichText(
                        text: TextSpan(
                          children: _getVariableTextSpans(context, subCriteria),
                          style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16),
                        ),
                      ),
                    );
                  }
                  return Container();
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<TextSpan> _getVariableTextSpans(
      BuildContext context, SubCriteria subCriteria) {
    String text = subCriteria.text;
    List<TextSpan> children = [];
    RegExp regExp = RegExp(r'\$\d+');
    Iterable<RegExpMatch> matches = regExp.allMatches(text);

    int lastIndex = 0;
    for (var match in matches) {
      final variableKey = match.group(0)!;
      final variable = subCriteria.variable?[variableKey];
      final variableType = variable?["type"];
      final start = match.start;
      final end = match.end;

      if (start > lastIndex) {
        children.add(TextSpan(
            text: text.substring(lastIndex, start),
            style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 16)));
      }

      if (variableType == "value") {
        final values = variable?["values"];
        if (values != null && values.isNotEmpty) {
          final String valueText = '(${values[0]})';
          children.add(TextSpan(
            text: valueText,
            style: TextStyle(color: Colors.blue, fontSize: 16),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ValueDetail(name: variableKey, value: variable),
                  ),
                );
              },
          ));
        } else {
          children.add(TextSpan(
            text: '(N/A)',
            style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255), fontSize: 16),
          ));
        }
      } else if (variableType == "indicator") {
        final defaultValue = variable?["default_value"];
        if (defaultValue != null) {
          final String valueText = '($defaultValue)';
          children.add(TextSpan(
            text: valueText,
            style: TextStyle(color: Colors.blue, fontSize: 16),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IndicatorDetail(
                      indicator: variable,
                    ),
                  ),
                );
              },
          ));
        } else {
          children.add(TextSpan(
            text: '(N/A)',
            style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255), fontSize: 16),
          ));
        }
      }

      lastIndex = end;
    }

    if (lastIndex < text.length) {
      children.add(TextSpan(
          text: text.substring(lastIndex),
          style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255), fontSize: 16)));
    }
    return children;
  }
}
