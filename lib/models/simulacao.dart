import 'isotopo.dart';

// Um cálculo feito na tela "Quanto sobra?".
class Simulacao {
    final Isotopo isotopo;
    final double quantidadeInicial;
    final double tempo;
    final String unidade;
    final double quantidadeRestante;
    final double percentualRestante;
    final double meiasVidas;

    const Simulacao({
        required this.isotopo,
        required this.quantidadeInicial,
        required this.tempo,
        required this.unidade,
        required this.quantidadeRestante,
        required this.percentualRestante,
        required this.meiasVidas,
    });
}
