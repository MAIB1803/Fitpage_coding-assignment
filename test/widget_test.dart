import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stock_scan_app/main.dart';
import 'package:stock_scan_app/models/criteria.dart';
import 'package:stock_scan_app/models/sub_criteria.dart';
import 'package:stock_scan_app/screens/criteria_detail.dart';
import 'package:stock_scan_app/screens/criteria_list.dart';

void main() {
  testWidgets('CriteriaList and CriteriaDetail smoke test',
      (WidgetTester tester) async {
    // Mock Criteria data
    final mockCriteria = [
      Criteria(
        id: 1,
        name: "Top gainers",
        tag: "Intraday Bullish",
        color: "green",
        criteria: [
          SubCriteria(
              type: "plain_text",
              text: "Sort - %price change in descending order")
        ],
      ),
      Criteria(
        id: 2,
        name: "Intraday buying seen in last 15 minutes",
        tag: "Bullish",
        color: "green",
        criteria: [
          SubCriteria(
              type: "plain_text",
              text: "Current candle open = current candle high"),
          SubCriteria(
              type: "plain_text",
              text: "Previous candle open = previous candle high"),
          SubCriteria(
              type: "plain_text",
              text: "2 previous candle’s open = 2 previous candle’s high")
        ],
      ),
      // Add more mock data as needed
    ];

    // Build the CriteriaList widget
    await tester.pumpWidget(MaterialApp(
      home: CriteriaList(),
    ));

    // Verify that the CriteriaList displays the mock data
    expect(find.text('Top gainers'), findsOneWidget);
    expect(
        find.text('Intraday buying seen in last 15 minutes'), findsOneWidget);

    // Tap the first Criteria item and trigger a frame.
    await tester.tap(find.text('Top gainers'));
    await tester.pumpAndSettle();

    // Verify that the CriteriaDetail screen is displayed with correct data
    expect(find.text('Top gainers'), findsOneWidget);
    expect(find.text('Intraday Bullish'), findsOneWidget);
    expect(
        find.text('Sort - %price change in descending order'), findsOneWidget);

    // Tap the back button to return to the CriteriaList
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    // Verify that we are back on the CriteriaList screen
    expect(find.text('Top gainers'), findsOneWidget);
    expect(
        find.text('Intraday buying seen in last 15 minutes'), findsOneWidget);

    // Tap the second Criteria item and trigger a frame.
    await tester.tap(find.text('Intraday buying seen in last 15 minutes'));
    await tester.pumpAndSettle();

    // Verify that the CriteriaDetail screen is displayed with correct data
    expect(
        find.text('Intraday buying seen in last 15 minutes'), findsOneWidget);
    expect(find.text('Bullish'), findsOneWidget);
    expect(
        find.text('Current candle open = current candle high'), findsOneWidget);
    expect(find.text('Previous candle open = previous candle high'),
        findsOneWidget);
    expect(find.text('2 previous candle’s open = 2 previous candle’s high'),
        findsOneWidget);
  });
}
