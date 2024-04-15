import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inbank_frontend/widgets/loan_form.dart';

void main() {
  testWidgets('LoanForm displays the form and initial values',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: Column(
        children: const [LoanForm()],
      ),
    )));
    // Verify the form and initial values are displayed
    expect(find.text('Loan Amount: 2500 €'), findsOneWidget);
    expect(find.text('Loan Period: 36 months'), findsOneWidget);
    expect(find.text('Approved Loan Amount: -- €'), findsOneWidget);
    expect(find.text('Approved Loan Period: -- months'), findsOneWidget);

    // Verify sliders are displayed
    expect(find.byType(Slider), findsNWidgets(2));
  });

  // Test the slider behavior for loan amount
  testWidgets('LoanForm slider changes the loan amount',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
      body: Column(
        children: [LoanForm()],
      ),
    )));
    final Finder sliderFinder = find.byType(Slider).first;
    const double defaultValue = 2500;
    const double newValue = 2000;
    final initialSliderWidget = tester.widget<Slider>(sliderFinder);
    expect(initialSliderWidget.value, defaultValue);

    // Perform slider interaction
    await tester.drag(sliderFinder, const Offset(-1000, 0));
    await tester.pumpAndSettle();

    // Verify slider value changed
    final updatedSliderWidget = tester.widget<Slider>(sliderFinder);
    expect(updatedSliderWidget.value, newValue);
  });

  // Test the slider behavior for loan period
  testWidgets('LoanForm slider changes the loan period',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
      body: Column(
        children: [LoanForm()],
      ),
    )));
    final Finder sliderFinder = find.byType(Slider).last;
    const double defaultValue = 36;
    const double newValue = 12;
    final initialSliderWidget = tester.widget<Slider>(sliderFinder);
    expect(initialSliderWidget.value, defaultValue);

    // Perform slider interaction
    await tester.drag(sliderFinder, const Offset(-1000, 0));
    await tester.pumpAndSettle();

    // Verify slider value changed
    final updatedSliderWidget = tester.widget<Slider>(sliderFinder);
    expect(updatedSliderWidget.value, newValue);
  });
}
