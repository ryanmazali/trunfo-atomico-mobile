import 'package:flutter/material.dart';

import '../data/dados.dart';
import '../models/isotopo.dart';
import '../tema.dart';
import '../widgets/carta_isotopo.dart';
import 'detalhe_screen.dart';

class AlbumScreen extends StatefulWidget {
    const AlbumScreen({super.key});

    @override
    State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
    // 'Todas' ou o nome de uma das áreas.
    String _filtro = 'Todas';

    void _filtrar(String area) {
        setState(() {
        _filtro = area;
        });
    }

    List<Isotopo> _cartasFiltradas() {
        if (_filtro == 'Todas') {
        return isotopos;
        }
        List<Isotopo> resultado = [];
        for (Isotopo isotopo in isotopos) {
        if (isotopo.pertenceArea(_filtro)) {
            resultado.add(isotopo);
        }
        }
        return resultado;
    }

    void _abrirCarta(Isotopo isotopo) {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetalheScreen(isotopo: isotopo)),
        );
    }

    @override
    Widget build(BuildContext context) {
        List<Isotopo> cartas = _cartasFiltradas();

        return Scaffold(
        appBar: barraDoApp('Álbum'),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text(
                '${cartas.length} de ${isotopos.length} cartas · toque para abrir',
                style: Estilos.corpo,
                ),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                children: [
                    _botaoFiltro('Todas'),
                    ...areas.map((area) => _botaoFiltro(area)),
                ],
                ),
            ),
            const SizedBox(height: 12),
            Expanded(
                child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                itemCount: cartas.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                    Isotopo isotopo = cartas[index];
                    return CartaIsotopo(
                    isotopo: isotopo,
                    aoTocar: () => _abrirCarta(isotopo),
                    );
                },
                ),
            ),
            ],
        ),
        );
    }

    Widget _botaoFiltro(String area) {
        bool selecionado = _filtro == area;
        Color corTexto = Cores.tinta;
        if (selecionado) {
        corTexto = Colors.white;
        }

        return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: TextButton(
            onPressed: () => _filtrar(area),
            style: TextButton.styleFrom(
            backgroundColor: selecionado ? Cores.tinta : Cores.superficie,
            foregroundColor: corTexto,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: selecionado ? Cores.tinta : Cores.linha),
            ),
            ),
            child: Text(
            area,
            style: const TextStyle(fontWeight: FontWeight.w700),
            ),
        ),
        );
    }
}
