import 'package:astro_talkapp/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('portfolio renders primary hero content', (tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('Your\nName'), findsOneWidget);
    expect(find.text('View Projects'), findsOneWidget);
    expect(find.text('Contact Me'), findsOneWidget);
  });
}
