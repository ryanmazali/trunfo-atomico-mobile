// Formata número no padrão brasileiro: 5700.5 -> "5.700,5".
// Zeros no fim da parte decimal são removidos (8,00 -> 8).
String formatarNumero(double valor, int casas) {
    String texto = valor.toStringAsFixed(casas);
    String parteInteira = texto;
    String parteDecimal = '';

    if (texto.contains('.')) {
        parteInteira = texto.split('.')[0];
        parteDecimal = texto.split('.')[1];
    }

    bool negativo = parteInteira.startsWith('-');
    if (negativo) {
        parteInteira = parteInteira.substring(1);
    }

    String comPontos = '';
    int contador = 0;
    for (int i = parteInteira.length - 1; i >= 0; i--) {
        comPontos = parteInteira[i] + comPontos;
        contador++;
        if (contador % 3 == 0 && i > 0) {
        comPontos = '.$comPontos';
        }
    }

    while (parteDecimal.endsWith('0')) {
        parteDecimal = parteDecimal.substring(0, parteDecimal.length - 1);
    }

    String resultado = negativo ? '-$comPontos' : comPontos;
    if (parteDecimal.isNotEmpty) {
        resultado = '$resultado,$parteDecimal';
    }
    return resultado;
}

// O banco guarda a meia-vida em dias. Aqui ela vira um texto legível.
String formatarMeiaVida(double dias) {
  double horas = dias * 24;

    if (horas < 2) {
        return '${formatarNumero(horas * 60, 0)} minutos';
    }
    if (horas < 48) {
        return '${formatarNumero(horas, 1)} horas';
    }
    if (dias < 730) {
        return '${formatarNumero(dias, 1)} dias';
    }

    double anos = dias / 365.25;
    if (anos < 1000000) {
        return '${formatarNumero(anos, anos < 100 ? 1 : 0)} anos';
    }
    if (anos < 1000000000) {
        return '${formatarNumero(anos / 1000000, 0)} milhões de anos';
    }

    double bilhoes = anos / 1000000000;
    String palavra = bilhoes < 2 ? 'bilhão' : 'bilhões';
    return '${formatarNumero(bilhoes, 2)} $palavra de anos';
}

String formatarGramas(double gramas) {
    if (gramas == 0) {
        return '0 g';
    }
    if (gramas < 0.0001) {
        return 'menos de 0,0001 g';
    }
    if (gramas < 1) {
        return '${formatarNumero(gramas, 4)} g';
    }
    return '${formatarNumero(gramas, 2)} g';
    }

    String formatarPercentual(double percentual) {
    if (percentual > 0 && percentual < 0.01) {
        return 'menos de 0,01%';
    }
    if (percentual > 99.99 && percentual < 100) {
        return 'mais de 99,99%';
    }
    return '${formatarNumero(percentual, 2)}%';
}
