import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_scan_app/models/criteria.dart';
import 'package:stock_scan_app/models/sub_criteria.dart';
import 'package:stock_scan_app/screens/criteria_detail.dart';

void main() {
  testWidgets('CriteriaDetail displays plain_text correctly',
      (WidgetTester tester) async {
    // Arrange
    final criteria = Criteria(
      id: 1,
      name: "Test Criteria",
      tag: "Test Tag",
      color: "green",
      criteria: [
        SubCriteria(type: "plain_text", text: "Test plain text"),
      ],
    );

    // Act
    await tester.pumpWidget(MaterialApp(
      home: CriteriaDetail(criteria: criteria),
    ));

    // Assert
    expect(find.text('Test Criteria'), findsOneWidget);
    expect(find.text('Test Tag'), findsOneWidget);
    expect(find.text('Test plain text'), findsOneWidget);
  });

  testWidgets('CriteriaDetail displays variable correctly',
      (WidgetTester tester) async {
    // Arrange
    final criteria = Criteria(
      id: 1,
      name: "Test Criteria",
      tag: "Test Tag",
      color: "green",
      criteria: [
        SubCriteria(
          type: "variable",
          text: "Test variable \$1",
          variable: {
            "\$1": {
              "type": "value",
              "values": [-3, -1, -2, -5, -10],
            }
          },
        ),
      ],
    );

    // Act
    await tester.pumpWidget(MaterialApp(
      home: CriteriaDetail(criteria: criteria),
    ));

    // Assert
    expect(find.text('Test Criteria'), findsOneWidget);
    expect(find.text('Test Tag'), findsOneWidget);
    expect(find.text('Test variable '), findsOneWidget);
    expect(find.text('(-3)'), findsOneWidget);
  });

  testWidgets('CriteriaDetail displays indicator correctly',
      (WidgetTester tester) async {
    // Arrange
    final criteria = Criteria(
      id: 1,
      name: "Test Criteria",
      tag: "Test Tag",
      color: "green",
      criteria: [
        SubCriteria(
          type: "variable",
          text: "Test indicator \$1",
          variable: {
            "\$1": {
              "type": "indicator",
              "study_type": "rsi",
              "parameter_name": "period",
              "min_value": 1,
              "max_value": 99,
              "default_value": 14,
            }
          },
        ),
      ],
    );

    // Act
    await tester.pumpWidget(MaterialApp(
      home: CriteriaDetail(criteria: criteria),
    ));

    // Assert
    expect(find.text('Test Criteria'), findsOneWidget);
    expect(find.text('Test Tag'), findsOneWidget);
    expect(find.text('Test indicator '), findsOneWidget);
    expect(find.text('(14)'), findsOneWidget);
  });
}
