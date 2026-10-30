import 'package:flutter/material.dart';

import '../models/isotopo.dart';
import '../tema.dart';
import '../utils/formatar.dart';
import '../widgets/carta_isotopo.dart';

// Recebe o isótopo escolhido no álbum (passagem de parâmetro).
class DetalheScreen extends StatefulWidget {
    final Isotopo isotopo;

    const DetalheScreen({super.key, required this.isotopo});

    @override
    State<DetalheScreen> createState() => _DetalheScreenState();
}

class _DetalheScreenState extends State<DetalheScreen> {
    // null enquanto o usuário não respondeu ao "Mito ou verdade?".
    bool? _resposta;

    void _responder(bool resposta) {
        setState(() {
        _resposta = resposta;
        });
    }

    @override
    Widget build(BuildContext context) {
        Isotopo isotopo = widget.isotopo;
        String area = isotopo.areaPrincipal;

        return Scaffold(
        appBar: barraDoApp('Carta'),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                // Cabeçalho da carta
                Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: corClaraDaArea(area),
                    borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    EtiquetaArea(area: area),
                    const SizedBox(height: 16),
                    NotacaoNuclear(isotopo: isotopo, tamanho: 76),
                    const SizedBox(height: 8),
                    Text(isotopo.nome, style: Estilos.titulo),
                    ],
                ),
                ),
                const SizedBox(height: 12),
                IntrinsicHeight(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    Expanded(
                        child: _caixaDado(
                        'MEIA-VIDA',
                        formatarMeiaVida(isotopo.meiaVidaDias),
                        'tempo para perder metade da radioatividade',
                        ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _caixaDado(
                        'NÚMERO DE MASSA',
                        '${isotopo.numeroMassa}',
                        'prótons + nêutrons no núcleo',
                        ),
                    ),
                    ],
                ),
                ),
                const SizedBox(height: 8),
                Text(
                'Fonte da meia-vida: ${isotopo.fonte}',
                style: const TextStyle(fontSize: 12, color: Cores.tintaSuave),
                ),

                const SizedBox(height: 28),
                const Text('ONDE É USADO', style: Estilos.rotulo),
                const SizedBox(height: 10),
                ...isotopo.aplicacoes.map((aplicacao) => _cartaoAplicacao(aplicacao)),

                const SizedBox(height: 28),
                const Text('MITO OU VERDADE?', style: Estilos.rotulo),
                const SizedBox(height: 10),
                _blocoMitoOuVerdade(isotopo),

                const SizedBox(height: 24),
                SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                    onPressed: () {
                    Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Voltar ao álbum'),
                    style: TextButton.styleFrom(
                    foregroundColor: Cores.tinta,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                ),
                ),
            ],
            ),
        ),
        );
    }

    Widget _caixaDado(String rotulo, String valor, String legenda) {
        return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Cores.superficie,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Cores.linha),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(rotulo, style: Estilos.rotulo),
            const SizedBox(height: 4),
            Text(
                valor,
                style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Cores.tinta,
                ),
            ),
            const SizedBox(height: 4),
            Text(
                legenda,
                style: const TextStyle(
                fontSize: 12,
                height: 1.3,
                color: Cores.tintaSuave,
                ),
            ),
            ],
        ),
        );
    }

    Widget _cartaoAplicacao(Aplicacao aplicacao) {
        return Card(
        elevation: 0,
        color: Cores.superficie,
        margin: const EdgeInsets.only(bottom: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: Cores.linha),
        ),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: corClaraDaArea(aplicacao.area),
                    borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                    iconeDaArea(aplicacao.area),
                    size: 20,
                    color: corDaArea(aplicacao.area),
                ),
                ),
                const SizedBox(width: 14),
                Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                        aplicacao.nome,
                        style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Cores.tinta,
                        ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                        aplicacao.area,
                        style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: corDaArea(aplicacao.area),
                        ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                        aplicacao.descricao,
                        style: const TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Cores.tintaSuave,
                        ),
                    ),
                    ],
                ),
                ),
            ],
            ),
        ),
        );
    }

    Widget _blocoMitoOuVerdade(Isotopo isotopo) {
        return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Cores.tinta,
            borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
                '"${isotopo.afirmacao}"',
                style: const TextStyle(
                fontSize: 19,
                height: 1.35,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                ),
            ),
            const SizedBox(height: 18),
            if (_resposta == null) _botoesResposta() else _resultado(isotopo),
            ],
        ),
        );
    }

    Widget _botoesResposta() {
        return Row(
        children: [
            Expanded(
            child: ElevatedButton(
                onPressed: () => _responder(true),
                style: ElevatedButton.styleFrom(
                backgroundColor: Cores.amarelo,
                foregroundColor: Cores.tinta,
                ),
                child: const Text('Verdadeiro'),
            ),
            ),
            const SizedBox(width: 12),
            Expanded(
            child: ElevatedButton(
                onPressed: () => _responder(false),
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Cores.tinta,
                ),
                child: const Text('Falso'),
            ),
            ),
        ],
        );
    }

    Widget _resultado(Isotopo isotopo) {
        bool acertou = _resposta == isotopo.afirmacaoVerdadeira;
        String gabarito = isotopo.afirmacaoVerdadeira
            ? 'A afirmação é verdadeira.'
            : 'A afirmação é falsa: é um mito.';

        return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: acertou ? Cores.acertoClaro : Cores.erroClaro,
            borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
                children: [
                Icon(
                    acertou ? Icons.check_circle : Icons.cancel,
                    color: acertou ? Cores.acerto : Cores.erro,
                ),
                const SizedBox(width: 8),
                Text(
                    acertou ? 'Você acertou!' : 'Não foi dessa vez',
                    style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: acertou ? Cores.acerto : Cores.erro,
                    ),
                ),
                ],
            ),
            const SizedBox(height: 8),
            Text(
                gabarito,
                style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Cores.tinta,
                ),
            ),
            const SizedBox(height: 6),
            Text(
                isotopo.explicacao,
                style: const TextStyle(
                fontSize: 14,
                height: 1.45,
                color: Cores.tinta,
                ),
            ),
            const SizedBox(height: 10),
            Text(
                'Fonte: ${isotopo.fonteExplicacao}',
                style: const TextStyle(fontSize: 12, color: Cores.tintaSuave),
            ),
            ],
        ),
        );
    }
}