import 'package:flutter_test/flutter_test.dart';
import 'package:plant_shop/main.dart';

void main() {
  testWidgets('PlantShopApp renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PlantShopApp());

    // Verify that our app starts with the home screen
    expect(find.text('Go Green'), findsOneWidget);
    expect(find.text('Welcome to Go Green!'), findsOneWidget);
  });
}