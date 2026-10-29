import 'package:flutter/material.dart';

// Paleta do app: azul-marinho (Marinha) e o amarelo do símbolo de radiação.
class Cores {
    static const Color fundo = Color(0xFFF1F4F7);
    static const Color superficie = Color(0xFFFFFFFF);
    static const Color tinta = Color(0xFF0F2033);
    static const Color tintaSuave = Color(0xFF5B6B7C);
    static const Color linha = Color(0xFFDCE3EA);
    static const Color amarelo = Color(0xFFF2B705);
    static const Color amareloClaro = Color(0xFFFFF3CC);
    static const Color acerto = Color(0xFF1E8A57);
    static const Color acertoClaro = Color(0xFFE1F3E9);
    static const Color erro = Color(0xFFC43D35);
    static const Color erroClaro = Color(0xFFFBE6E4);
}

// As 6 áreas de aplicação, na mesma ordem da tabela AREA do banco.
const List<String> areas = [
    'Saúde',
    'Indústria',
    'Agricultura e Alimentos',
    'Pesquisa Científica',
    'Geração de Energia',
    'Propulsão Naval',
];

Color corDaArea(String area) {
    if (area == 'Saúde') {
        return const Color(0xFF1F8A80);
    } else if (area == 'Indústria') {
        return const Color(0xFFD0662A);
    } else if (area == 'Agricultura e Alimentos') {
        return const Color(0xFF4E8F2F);
    } else if (area == 'Pesquisa Científica') {
        return const Color(0xFF6E4FC4);
    } else if (area == 'Geração de Energia') {
        return const Color(0xFFB03A48);
    } else {
        return const Color(0xFF1F5FA8);
    }
}

Color corClaraDaArea(String area) {
    if (area == 'Saúde') {
        return const Color(0xFFE0F2F0);
    } else if (area == 'Indústria') {
        return const Color(0xFFFBEBE1);
    } else if (area == 'Agricultura e Alimentos') {
        return const Color(0xFFE6F1DF);
    } else if (area == 'Pesquisa Científica') {
        return const Color(0xFFECE7F8);
    } else if (area == 'Geração de Energia') {
        return const Color(0xFFF6E3E5);
    } else {
        return const Color(0xFFE2ECF7);
    }
}

IconData iconeDaArea(String area) {
    if (area == 'Saúde') {
        return Icons.local_hospital;
    } else if (area == 'Indústria') {
        return Icons.factory;
    } else if (area == 'Agricultura e Alimentos') {
        return Icons.agriculture;
    } else if (area == 'Pesquisa Científica') {
        return Icons.science;
    } else if (area == 'Geração de Energia') {
        return Icons.bolt;
    } else {
        return Icons.directions_boat;
    }
}

// Estilos de texto usados em todas as telas.
class Estilos {
    static const TextStyle titulo = TextStyle(
        fontSize: 26,
        height: 1.15,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        color: Cores.tinta,
    );

    static const TextStyle subtitulo = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: Cores.tinta,
    );

    static const TextStyle corpo = TextStyle(
        fontSize: 15,
        height: 1.45,
        color: Cores.tintaSuave,
    );

    static const TextStyle rotulo = TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.1,
        color: Cores.tintaSuave,
    );
}

// Tema global: cores, botões e SnackBar.
ThemeData temaDoApp() {
    return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Cores.tinta,
            primary: Cores.tinta,
            secondary: Cores.amarelo,
            surface: Cores.superficie,
        ),
        scaffoldBackgroundColor: Cores.fundo,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: Cores.tinta,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
        ),
        snackBarTheme: const SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Cores.tinta,
        ),
    );
}

// AppBar padrão das telas internas.
AppBar barraDoApp(String titulo, {List<Widget>? acoes}) {
    return AppBar(
        title: Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        backgroundColor: Cores.fundo,
        foregroundColor: Cores.tinta,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: acoes,
    );
}

// Visual padrão dos campos do formulário.
InputDecoration decoracaoCampo(String rotulo, {String? sufixo}) {
    return InputDecoration(
        labelText: rotulo,
        suffixText: sufixo,
        filled: true,
        fillColor: Cores.superficie,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Cores.linha),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Cores.linha),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Cores.tinta, width: 2),
        ),
    );
}
