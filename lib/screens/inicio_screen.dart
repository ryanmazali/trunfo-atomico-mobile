import 'package:flutter/material.dart';

import '../data/dados.dart';
import '../models/isotopo.dart';
import '../tema.dart';
import '../utils/formatar.dart';
import '../widgets/carta_isotopo.dart';
import 'album_screen.dart';
import 'duelo_screen.dart';
import 'quanto_sobra_screen.dart';

class InicioScreen extends StatelessWidget {
    const InicioScreen({super.key});

    void _abrir(BuildContext context, Widget tela) {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => tela),
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                    children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                        'assets/images/logo.png',
                        width: 44,
                        height: 44,
                        ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                        'Trunfo Atômico',
                        style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Cores.tinta,
                        ),
                    ),
                    ],
                ),
                const SizedBox(height: 28),
                const Text(
                    'O nuclear está mais perto do que você imagina.',
                    style: TextStyle(
                    fontSize: 30,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                    color: Cores.tinta,
                    ),
                ),
                const SizedBox(height: 12),
                const Text(
                    'Cada carta é um isótopo radioativo com uso real: exame médico, '
                    'detector de fumaça, conservação de alimentos, energia. '
                    'Colecione, duele e descubra quanto tempo cada um dura.',
                    style: Estilos.corpo,
                ),
                const SizedBox(height: 24),

                // A tese do projeto: a meia-vida vai de minutos a bilhões de anos.
                const Text('DE MINUTOS A BILHÕES DE ANOS', style: Estilos.rotulo),
                const SizedBox(height: 10),
                Row(
                    children: [
                    Expanded(child: _miniCarta(isotopos[0])),
                    const SizedBox(width: 10),
                    Expanded(child: _miniCarta(isotopos[5])),
                    const SizedBox(width: 10),
                    Expanded(child: _miniCarta(isotopos[11])),
                    ],
                ),
                const SizedBox(height: 28),

                _botaoMenu(
                    icone: Icons.style,
                    titulo: 'Álbum de cartas',
                    descricao:
                        '${isotopos.length} isótopos e ${totalDeAplicacoes()} usos reais, com mito ou verdade',
                    corFundo: const Color(0xFFE0F2F0),
                    corIcone: const Color(0xFF1F8A80),
                    aoTocar: () => _abrir(context, const AlbumScreen()),
                ),
                const SizedBox(height: 12),
                _botaoMenu(
                    icone: Icons.compare_arrows,
                    titulo: 'Duelo',
                    descricao: 'Escolha o atributo da sua carta e vença o computador',
                    corFundo: Cores.amareloClaro,
                    corIcone: const Color(0xFF9A7200),
                    aoTocar: () => _abrir(context, const DueloScreen()),
                ),
                const SizedBox(height: 12),
                _botaoMenu(
                    icone: Icons.hourglass_bottom,
                    titulo: 'Quanto sobra?',
                    descricao: 'Calcule quanto de um isótopo resta depois de um tempo',
                    corFundo: const Color(0xFFE2ECF7),
                    corIcone: const Color(0xFF1F5FA8),
                    aoTocar: () => _abrir(context, const QuantoSobraScreen()),
                ),
                const SizedBox(height: 32),
                const Center(
                    child: Text(
                    'Challenge FIAP 2026 · CTMSP / Marinha do Brasil',
                    style: TextStyle(fontSize: 12, color: Cores.tintaSuave),
                    ),
                ),
                ],
            ),
            ),
        ),
        );
    }

    Widget _miniCarta(Isotopo isotopo) {
        return Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: corClaraDaArea(isotopo.areaPrincipal),
            borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            NotacaoNuclear(isotopo: isotopo, tamanho: 28),
            const SizedBox(height: 8),
            Text(
                formatarMeiaVida(isotopo.meiaVidaDias),
                maxLines: 2,
                style: const TextStyle(
                fontSize: 12,
                height: 1.25,
                fontWeight: FontWeight.w700,
                color: Cores.tinta,
                ),
            ),
            ],
        ),
        );
    }

    Widget _botaoMenu({
        required IconData icone,
        required String titulo,
        required String descricao,
        required Color corFundo,
        required Color corIcone,
        required VoidCallback aoTocar,
    }) {
        return Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Cores.superficie,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Cores.linha),
        ),
        child: InkWell(
            onTap: aoTocar,
            child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
                children: [
                Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                    color: corFundo,
                    borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icone, color: corIcone, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                        titulo,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Cores.tinta,
                        ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                        descricao,
                        style: const TextStyle(
                            fontSize: 13,
                            height: 1.35,
                            color: Cores.tintaSuave,
                        ),
                        ),
                    ],
                    ),
                ),
                const Icon(Icons.chevron_right, color: Cores.tintaSuave),
                ],
            ),
            ),
        ),
        );
    }
}
