import 'package:flutter_test/flutter_test.dart';

import 'package:trunfo_atomico/main.dart';

void main() {
  testWidgets('A tela inicial mostra o nome do app e o menu', (tester) async {
    await tester.pumpWidget(const TrunfoAtomicoApp());

    expect(find.text('Trunfo Atômico'), findsOneWidget);
    expect(find.text('Álbum de cartas'), findsOneWidget);
    expect(find.text('Duelo'), findsOneWidget);
    expect(find.text('Quanto sobra?'), findsOneWidget);
  });
}
