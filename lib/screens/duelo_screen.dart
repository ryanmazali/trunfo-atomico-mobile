import 'dart:math';

import 'package:flutter/material.dart';

import '../data/dados.dart';
import '../models/isotopo.dart';
import '../tema.dart';
import '../utils/formatar.dart';
import '../widgets/carta_isotopo.dart';

// Regras: cada um recebe uma carta sorteada. O jogador escolhe um atributo
// da própria carta e vence quem tiver o MAIOR valor nele.
class DueloScreen extends StatefulWidget {
    const DueloScreen({super.key});

    @override
    State<DueloScreen> createState() => _DueloScreenState();
}

class _DueloScreenState extends State<DueloScreen> {
    final Random _sorteio = Random();

    late Isotopo _minhaCarta;
    late Isotopo _cartaComputador;
    String? _atributoEscolhido;
    bool _revelado = false;
    int _meusPontos = 0;
    int _pontosComputador = 0;

    // 1 = jogador venceu, -1 = computador venceu, 0 = empate
    int _vencedor = 0;

    final List<String> _atributos = ['meia-vida', 'massa', 'usos'];

    @override
    void initState() {
        super.initState();
        _sortearCartas();
    }

    void _sortearCartas() {
        int primeira = _sorteio.nextInt(isotopos.length);
        int segunda = _sorteio.nextInt(isotopos.length);
        while (segunda == primeira) {
        segunda = _sorteio.nextInt(isotopos.length);
        }
        _minhaCarta = isotopos[primeira];
        _cartaComputador = isotopos[segunda];
    }

    String _nomeDoAtributo(String atributo) {
        if (atributo == 'meia-vida') {
        return 'Meia-vida';
        } else if (atributo == 'massa') {
        return 'Número de massa';
        } else {
        return 'Usos no álbum';
        }
    }

    double _valor(Isotopo isotopo, String atributo) {
        if (atributo == 'meia-vida') {
        return isotopo.meiaVidaDias;
        } else if (atributo == 'massa') {
        return isotopo.numeroMassa.toDouble();
        } else {
        return isotopo.aplicacoes.length.toDouble();
        }
    }

    String _valorEmTexto(Isotopo isotopo, String atributo) {
        if (atributo == 'meia-vida') {
        return formatarMeiaVida(isotopo.meiaVidaDias);
        } else if (atributo == 'massa') {
        return '${isotopo.numeroMassa}';
        } else {
        int usos = isotopo.aplicacoes.length;
        return usos == 1 ? '1 uso' : '$usos usos';
        }
    }

    void _jogar(String atributo) {
        double meuValor = _valor(_minhaCarta, atributo);
        double valorComputador = _valor(_cartaComputador, atributo);

        setState(() {
        _atributoEscolhido = atributo;
        _revelado = true;
        if (meuValor > valorComputador) {
            _vencedor = 1;
            _meusPontos++;
        } else if (meuValor < valorComputador) {
            _vencedor = -1;
            _pontosComputador++;
        } else {
            _vencedor = 0;
        }
        });
    }

    void _proximaRodada() {
        setState(() {
        _sortearCartas();
        _atributoEscolhido = null;
        _revelado = false;
        });
    }

    void _zerarPlacar() {
        setState(() {
        _meusPontos = 0;
        _pontosComputador = 0;
        _sortearCartas();
        _atributoEscolhido = null;
        _revelado = false;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: barraDoApp(
            'Duelo',
            acoes: [
            IconButton(
                onPressed: _zerarPlacar,
                tooltip: 'Zerar placar',
                icon: const Icon(Icons.restart_alt),
            ),
            ],
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                _placar(),
                const SizedBox(height: 16),
                Text(
                _revelado
                    ? 'Rodada encerrada. Compare as cartas.'
                    : 'Toque no atributo da sua carta que você acha que vence. Vence o maior valor.',
                style: Estilos.corpo,
                ),
                const SizedBox(height: 12),
                Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Expanded(child: _cartaDuelo(_minhaCarta, 'SUA CARTA', true)),
                    const SizedBox(width: 12),
                    Expanded(
                    child: _revelado
                        ? _cartaDuelo(_cartaComputador, 'COMPUTADOR', false)
                        : _cartaVirada(),
                    ),
                ],
                ),
                if (_revelado) ...[
                const SizedBox(height: 16),
                _resultadoDaRodada(),
                const SizedBox(height: 16),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                    onPressed: _proximaRodada,
                    child: const Text('Próxima rodada'),
                    ),
                ),
                ],
            ],
            ),
        ),
        );
    }

    Widget _placar() {
        return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
            color: Cores.tinta,
            borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
            children: [
            Expanded(child: _pontuacao('VOCÊ', _meusPontos)),
            const Text(
                '×',
                style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Cores.amarelo,
                ),
            ),
            Expanded(child: _pontuacao('COMPUTADOR', _pontosComputador)),
            ],
        ),
        );
    }

    Widget _pontuacao(String nome, int pontos) {
        return Column(
        children: [
            Text(
            '$pontos',
            style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: Colors.white,
            ),
            ),
            Text(
            nome,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
                color: Color(0xFFB7C3D0),
            ),
            ),
        ],
        );
    }

    Widget _cartaDuelo(Isotopo isotopo, String dono, bool ehMinha) {
        return Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Cores.superficie,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Cores.linha),
        ),
        child: SizedBox(
            height: 360,
            child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(dono, style: Estilos.rotulo),
                const SizedBox(height: 8),
                EtiquetaArea(area: isotopo.areaPrincipal),
                const SizedBox(height: 8),
                NotacaoNuclear(isotopo: isotopo, tamanho: 36),
                const SizedBox(height: 4),
                Text(
                    isotopo.nome,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                    fontSize: 13,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: Cores.tinta,
                    ),
                ),
                const Spacer(),
                ..._atributos.map(
                    (atributo) => _linhaAtributo(isotopo, atributo, ehMinha),
                ),
                ],
            ),
            ),
        ),
        );
    }

    Widget _linhaAtributo(Isotopo isotopo, String atributo, bool ehMinha) {
        bool podeEscolher = ehMinha && !_revelado;
        bool destacado = _revelado && _atributoEscolhido == atributo;

        Color fundo = Cores.fundo;
        Color borda = Cores.fundo;
        if (podeEscolher) {
        fundo = Cores.amareloClaro;
        borda = Cores.amarelo;
        }
        if (destacado) {
        fundo = Cores.tinta;
        borda = Cores.tinta;
        }

        return Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Material(
            color: fundo,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: podeEscolher ? () => _jogar(atributo) : null,
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borda),
                ),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                    _nomeDoAtributo(atributo).toUpperCase(),
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: destacado ? Cores.amarelo : Cores.tintaSuave,
                    ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                    _valorEmTexto(isotopo, atributo),
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: destacado ? Colors.white : Cores.tinta,
                    ),
                    ),
                ],
                ),
            ),
            ),
        ),
        );
    }

    Widget _cartaVirada() {
        return Container(
        height: 360,
        decoration: BoxDecoration(
            color: Cores.tinta,
            borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
                '?',
                style: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.w800,
                color: Cores.amarelo,
                ),
            ),
            SizedBox(height: 4),
            Text(
                'CARTA DO\nCOMPUTADOR',
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
                color: Color(0xFFB7C3D0),
                ),
            ),
            ],
        ),
        );
    }

    Widget _resultadoDaRodada() {
        String atributo = _atributoEscolhido ?? 'meia-vida';
        String titulo;
        Color cor;
        Color corFundo;
        IconData icone;

        if (_vencedor == 1) {
        titulo = 'Você venceu a rodada!';
        cor = Cores.acerto;
        corFundo = Cores.acertoClaro;
        icone = Icons.emoji_events;
        } else if (_vencedor == -1) {
        titulo = 'O computador venceu';
        cor = Cores.erro;
        corFundo = Cores.erroClaro;
        icone = Icons.smart_toy;
        } else {
        titulo = 'Empate';
        cor = Cores.tinta;
        corFundo = Cores.linha;
        icone = Icons.handshake;
        }

        String comparacao =
            '${_nomeDoAtributo(atributo)}: ${_minhaCarta.nome} tem ${_valorEmTexto(_minhaCarta, atributo)} '
            'e ${_cartaComputador.nome} tem ${_valorEmTexto(_cartaComputador, atributo)}.';

        return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: corFundo,
            borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
                children: [
                Icon(icone, color: cor),
                const SizedBox(width: 8),
                Text(
                    titulo,
                    style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: cor,
                    ),
                ),
                ],
            ),
            const SizedBox(height: 6),
            Text(
                comparacao,
                style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Cores.tinta,
                ),
            ),
            ],
        ),
        );
    }
}