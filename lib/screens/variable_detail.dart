import 'package:flutter/material.dart';

class VariableDetail extends StatelessWidget {
  final Map<String, dynamic> variable;

  VariableDetail({required this.variable});

  @override
  Widget build(BuildContext context) {
    final values = variable["values"];
    final type = variable["type"];
    final studyType = variable["study_type"];
    final parameterName = variable["parameter_name"];
    final minValue = variable["min_value"];
    final maxValue = variable["max_value"];
    final defaultValue = variable["default_value"];

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studyType,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                if (values != null)
                  ...values.map<Widget>((value) => Text(
                        '$value',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                if (type != null)
                  Text(
                    'Type: $type',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                if (studyType != null)
                  Text(
                    'Study Type: $studyType',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                if (parameterName != null)
                  Text(
                    'Parameter Name: $parameterName',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                if (minValue != null)
                  Text(
                    'Min Value: $minValue',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                if (maxValue != null)
                  Text(
                    'Max Value: $maxValue',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                if (defaultValue != null)
                  Text(
                    'Default Value: $defaultValue',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
