import 'package:flutter/material.dart';

import '../models/isotopo.dart';
import '../tema.dart';
import '../utils/formatar.dart';

// Notação nuclear: número de massa pequeno no alto, símbolo grande (ex.: ⁶⁰Co).
class NotacaoNuclear extends StatelessWidget {
    final Isotopo isotopo;
    final double tamanho;
    final Color? corSimbolo;

    const NotacaoNuclear({
        super.key,
        required this.isotopo,
        this.tamanho = 40,
        this.corSimbolo,
    });

    @override
    Widget build(BuildContext context) {
        return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Padding(
            padding: EdgeInsets.only(top: tamanho * 0.08),
            child: Text(
                isotopo.massaNaNotacao,
                style: TextStyle(
                fontSize: tamanho * 0.34,
                fontWeight: FontWeight.w700,
                color: corDaArea(isotopo.areaPrincipal),
                ),
            ),
            ),
            const SizedBox(width: 2),
            Text(
            isotopo.simbolo,
            style: TextStyle(
                fontSize: tamanho,
                height: 1.0,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
                color: corSimbolo ?? Cores.tinta,
            ),
            ),
        ],
        );
    }
}

// Etiqueta com ícone e nome da área.
class EtiquetaArea extends StatelessWidget {
    final String area;

    const EtiquetaArea({super.key, required this.area});

    @override
    Widget build(BuildContext context) {
        return Row(
        children: [
            Icon(iconeDaArea(area), size: 14, color: corDaArea(area)),
            const SizedBox(width: 6),
            Expanded(
            child: Text(
                area.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
                color: corDaArea(area),
                ),
            ),
            ),
        ],
        );
    }
    }

    // Carta usada no álbum.
    class CartaIsotopo extends StatelessWidget {
    final Isotopo isotopo;
    final VoidCallback? aoTocar;

    const CartaIsotopo({super.key, required this.isotopo, this.aoTocar});

    @override
    Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(14),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                EtiquetaArea(area: isotopo.areaPrincipal),
                const SizedBox(height: 12),
                NotacaoNuclear(isotopo: isotopo, tamanho: 40),
                const SizedBox(height: 6),
                Text(
                    isotopo.nome,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: Cores.tinta,
                    ),
                ),
                const Spacer(),
                Container(height: 1, color: Cores.linha),
                const SizedBox(height: 8),
                const Text('MEIA-VIDA', style: Estilos.rotulo),
                const SizedBox(height: 2),
                Text(
                    formatarMeiaVida(isotopo.meiaVidaDias),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Cores.tinta,
                    ),
                ),
                ],
            ),
            ),
        ),
        );
    }
}
