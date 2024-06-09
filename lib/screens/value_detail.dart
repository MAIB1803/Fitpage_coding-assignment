import 'package:flutter/material.dart';

class ValueDetail extends StatelessWidget {
  final String name;
  final Map<String, dynamic> value;

  ValueDetail({required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    final values = value["values"];

    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                if (values != null)
                  ...values.map<Widget>((v) => Text(
                        v.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
