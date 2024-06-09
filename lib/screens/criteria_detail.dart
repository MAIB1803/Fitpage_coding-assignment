import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../models/criteria.dart';
import '../models/sub_criteria.dart';
import 'variable_detail.dart';
import 'indicator_detail.dart';
import 'value_detail.dart';
import 'dart:convert';

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
          color: Colors.black,
          padding: EdgeInsets.all(8.0),
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
              ..._buildCriteriaList(context, criteria.criteria),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCriteriaList(
      BuildContext context, List<SubCriteria> criteriaList) {
    List<Widget> widgets = [];
    for (var i = 0; i < criteriaList.length; i++) {
      var subCriteria = criteriaList[i];
      if (subCriteria.type == "plain_text") {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              utf8.decode(subCriteria.text.runes.toList()),
              style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16),
            ),
          ),
        );
      } else if (subCriteria.type == "variable") {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: RichText(
              text: TextSpan(
                children: _getVariableTextSpans(context, subCriteria),
                style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16),
              ),
            ),
          ),
        );
      } else if (subCriteria.type == "value") {
        widgets.add(
          ListTile(
            title: Text(
              utf8.decode(subCriteria.text.runes.toList()),
              style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16),
            ),
            onTap: () {
              if (subCriteria.variable != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ValueDetail(
                      name: criteria.name,
                      value: subCriteria.variable!,
                    ),
                  ),
                );
              }
            },
          ),
        );
      }
      if (i < criteriaList.length - 1) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              'and',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        );
      }
    }
    return widgets;
  }

  List<TextSpan> _getVariableTextSpans(
      BuildContext context, SubCriteria subCriteria) {
    String text = utf8.decode(subCriteria.text.runes.toList());
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
                    builder: (context) => ValueDetail(
                      name: subCriteria.text,
                      value: variable,
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
