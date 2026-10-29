import 'dart:math';

import 'package:flutter/material.dart';

import '../data/dados.dart';
import '../models/isotopo.dart';
import '../models/simulacao.dart';
import '../tema.dart';
import '../utils/formatar.dart';

// Calculadora de decaimento:
// quantidade restante = quantidade inicial x (1/2) ^ (tempo / meia-vida)
class QuantoSobraScreen extends StatefulWidget {
    const QuantoSobraScreen({super.key});

    @override
    State<QuantoSobraScreen> createState() => _QuantoSobraScreenState();
}

class _QuantoSobraScreenState extends State<QuantoSobraScreen> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _quantidadeController = TextEditingController();
    final TextEditingController _tempoController = TextEditingController();

    Isotopo? _isotopo;
    String _unidade = 'dias';
    Simulacao? _ultima;
    final List<Simulacao> _historico = [];

    final List<String> _unidades = ['horas', 'dias', 'anos'];

    @override
    void dispose() {
        _quantidadeController.dispose();
        _tempoController.dispose();
        super.dispose();
    }

    // Aceita vírgula ou ponto como separador decimal.
    double? _lerNumero(String? texto) {
        if (texto == null) {
        return null;
        }
        return double.tryParse(texto.trim().replaceAll(',', '.'));
    }

    double _converterParaDias(double tempo, String unidade) {
        if (unidade == 'horas') {
        return tempo / 24;
        } else if (unidade == 'anos') {
        return tempo * 365.25;
        } else {
        return tempo;
        }
    }

    String? _validarQuantidade(String? valor) {
        if (valor == null || valor.trim().isEmpty) {
        return 'Informe a quantidade inicial';
        }
        double? numero = _lerNumero(valor);
        if (numero == null) {
        return 'Digite um número válido, como 100 ou 2,5';
        }
        if (numero <= 0) {
        return 'A quantidade precisa ser maior que zero';
        }
        return null;
    }

    String? _validarTempo(String? valor) {
        if (valor == null || valor.trim().isEmpty) {
        return 'Informe o tempo';
        }
        double? numero = _lerNumero(valor);
        if (numero == null) {
        return 'Número inválido';
        }
        if (numero < 0) {
        return 'Não pode ser negativo';
        }
        return null;
    }

    void _calcular() {
        FocusScope.of(context).unfocus();

        if (!_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Confira os campos destacados em vermelho.')),
        );
        return;
        }

        Isotopo isotopo = _isotopo!;
        double quantidade = _lerNumero(_quantidadeController.text)!;
        double tempo = _lerNumero(_tempoController.text)!;
        double tempoEmDias = _converterParaDias(tempo, _unidade);

        double meiasVidas = tempoEmDias / isotopo.meiaVidaDias;
        double fracaoRestante = pow(0.5, meiasVidas).toDouble();

        Simulacao simulacao = Simulacao(
        isotopo: isotopo,
        quantidadeInicial: quantidade,
        tempo: tempo,
        unidade: _unidade,
        quantidadeRestante: quantidade * fracaoRestante,
        percentualRestante: fracaoRestante * 100,
        meiasVidas: meiasVidas,
        );

        setState(() {
        _ultima = simulacao;
        _historico.insert(0, simulacao);
        });

        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
            'Restam ${formatarGramas(simulacao.quantidadeRestante)} de ${isotopo.nome}. Cálculo salvo no histórico.',
            ),
        ),
        );
    }

    void _limparHistorico() {
        setState(() {
        _historico.clear();
        _ultima = null;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: barraDoApp('Quanto sobra?'),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const Text(
                'Escolha um isótopo, a quantidade e o tempo. O app calcula quanto do material ainda resta.',
                style: Estilos.corpo,
                ),
                const SizedBox(height: 16),
                _formulario(),
                if (_ultima != null) ...[
                const SizedBox(height: 20),
                _cartaoResultado(_ultima!),
                ],
                const SizedBox(height: 28),
                Row(
                children: [
                    const Expanded(child: Text('HISTÓRICO', style: Estilos.rotulo)),
                    if (_historico.isNotEmpty)
                    TextButton(
                        onPressed: _limparHistorico,
                        style: TextButton.styleFrom(foregroundColor: Cores.erro),
                        child: const Text('Limpar'),
                    ),
                ],
                ),
                const SizedBox(height: 6),
                _listaHistorico(),
            ],
            ),
        ),
        );
    }

    Widget _formulario() {
        return Form(
        key: _formKey,
        child: Column(
            children: [
            DropdownButtonFormField<Isotopo>(
                initialValue: _isotopo,
                isExpanded: true,
                decoration: decoracaoCampo('Isótopo'),
                items: isotopos.map((isotopo) {
                return DropdownMenuItem<Isotopo>(
                    value: isotopo,
                    child: Text(
                    '${isotopo.nome}  ·  ${formatarMeiaVida(isotopo.meiaVidaDias)}',
                    overflow: TextOverflow.ellipsis,
                    ),
                );
                }).toList(),
                onChanged: (valor) {
                setState(() {
                    _isotopo = valor;
                });
                },
                validator: (valor) {
                if (valor == null) {
                    return 'Escolha um isótopo';
                }
                return null;
                },
            ),
            const SizedBox(height: 14),
            TextFormField(
                controller: _quantidadeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: decoracaoCampo('Quantidade inicial', sufixo: 'g'),
                validator: _validarQuantidade,
            ),
            const SizedBox(height: 14),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Expanded(
                    child: TextFormField(
                    controller: _tempoController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                    ),
                    decoration: decoracaoCampo('Tempo decorrido'),
                    validator: _validarTempo,
                    ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                    width: 120,
                    child: DropdownButtonFormField<String>(
                    initialValue: _unidade,
                    decoration: decoracaoCampo('Unidade'),
                    items: _unidades.map((unidade) {
                        return DropdownMenuItem<String>(
                        value: unidade,
                        child: Text(unidade),
                        );
                    }).toList(),
                    onChanged: (valor) {
                        setState(() {
                        _unidade = valor ?? 'dias';
                        });
                    },
                    ),
                ),
                ],
            ),
            const SizedBox(height: 18),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                onPressed: _calcular,
                icon: const Icon(Icons.hourglass_bottom),
                label: const Text('Calcular'),
                ),
            ),
            ],
        ),
        );
    }

    Widget _cartaoResultado(Simulacao simulacao) {
        String tempoTexto =
            '${formatarNumero(simulacao.tempo, 2)} ${simulacao.unidade}';
        double barra = simulacao.percentualRestante / 100;

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
            const Text(
                'RESTAM',
                style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
                color: Color(0xFFB7C3D0),
                ),
            ),
            const SizedBox(height: 4),
            Text(
                formatarGramas(simulacao.quantidadeRestante),
                style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Cores.amarelo,
                ),
            ),
            const SizedBox(height: 4),
            Text(
                'de ${formatarGramas(simulacao.quantidadeInicial)} de ${simulacao.isotopo.nome} depois de $tempoTexto',
                style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.white,
                ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                value: barra,
                minHeight: 10,
                color: Cores.amarelo,
                backgroundColor: const Color(0xFF2A3B50),
                ),
            ),
            const SizedBox(height: 16),
            Row(
                children: [
                Expanded(
                    child: _numeroResultado(
                    'DO MATERIAL',
                    formatarPercentual(simulacao.percentualRestante),
                    ),
                ),
                Expanded(
                    child: _numeroResultado(
                    'MEIAS-VIDAS',
                    formatarNumero(simulacao.meiasVidas, 2),
                    ),
                ),
                ],
            ),
            ],
        ),
        );
    }

    Widget _numeroResultado(String rotulo, String valor) {
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
            valor,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
            ),
            ),
            Text(
            rotulo,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
                color: Color(0xFFB7C3D0),
            ),
            ),
        ],
        );
    }

    Widget _listaHistorico() {
        if (_historico.isEmpty) {
        return const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
            'Nenhum cálculo ainda. Os resultados aparecem aqui.',
            style: Estilos.corpo,
            ),
        );
        }

        return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _historico.length,
        itemBuilder: (context, index) {
            Simulacao item = _historico[index];
            String area = item.isotopo.areaPrincipal;

            return Card(
            elevation: 0,
            color: Cores.superficie,
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Cores.linha),
            ),
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                children: [
                    Container(
                    width: 46,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: corClaraDaArea(area),
                        borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                        item.isotopo.simbolo,
                        style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: corDaArea(area),
                        ),
                    ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                            item.isotopo.nome,
                            style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Cores.tinta,
                            ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                            '${formatarGramas(item.quantidadeInicial)} · ${formatarNumero(item.tempo, 2)} ${item.unidade}',
                            style: const TextStyle(
                            fontSize: 13,
                            color: Cores.tintaSuave,
                            ),
                        ),
                        ],
                    ),
                    ),
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                        Text(
                        formatarGramas(item.quantidadeRestante),
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Cores.tinta,
                        ),
                        ),
                        Text(
                        formatarPercentual(item.percentualRestante),
                        style: const TextStyle(
                            fontSize: 12,
                            color: Cores.tintaSuave,
                        ),
                        ),
                    ],
                    ),
                ],
                ),
            ),
            );
        },
        );
    }
}
