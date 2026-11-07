import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moodbloom/app.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('MoodBloom app loads successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MoodBloomApp());
    await tester.pumpAndSettle();

    expect(find.text('MoodBloom'), findsWidgets);
  });
}
