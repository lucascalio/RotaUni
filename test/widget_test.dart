import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_rotauni/main.dart';

void main() {
  testWidgets('App inicia na tela de login', (WidgetTester tester) async {
    await tester.pumpWidget(RotaUniApp());

    // Verifica se aparece o título do app
    expect(find.text('RotaUni'), findsOneWidget);

    // Verifica campo de nome
    expect(find.byType(TextField), findsOneWidget);

    // Verifica botão entrar
    expect(find.text('Entrar'), findsOneWidget);
  });
}