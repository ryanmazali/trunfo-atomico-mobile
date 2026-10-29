// Um uso real de um isótopo (tabela APLICACAO do banco).
class Aplicacao {
    final String nome;
    final String descricao;
    final String area;

    const Aplicacao({
        required this.nome,
        required this.descricao,
        required this.area,
    });
}

// A carta do jogo (tabela ISOTOPO do banco) com o "Mito ou verdade?".
class Isotopo {
    final int id;
    final String nome;
    final String simbolo;
    final int numeroMassa;
    final bool metaestavel;
    final double meiaVidaDias;
    final String fonte;
    final List<Aplicacao> aplicacoes;

    // Mito ou verdade? (dados mockados só no app nesta Sprint)
    final String afirmacao;
    final bool afirmacaoVerdadeira;
    final String explicacao;
    final String fonteExplicacao;

    const Isotopo({
        required this.id,
        required this.nome,
        required this.simbolo,
        required this.numeroMassa,
        this.metaestavel = false,
        required this.meiaVidaDias,
        required this.fonte,
        required this.aplicacoes,
        required this.afirmacao,
        required this.afirmacaoVerdadeira,
        required this.explicacao,
        required this.fonteExplicacao,
    });

    // Número de massa como aparece na notação (ex.: 99m no tecnécio).
    String get massaNaNotacao {
        if (metaestavel) {
        return '${numeroMassa}m';
        }
        return '$numeroMassa';
    }

    // A área do primeiro uso define a cor da carta.
    String get areaPrincipal => aplicacoes[0].area;

    bool pertenceArea(String area) {
        for (Aplicacao aplicacao in aplicacoes) {
            if (aplicacao.area == area) {
                return true;
            }
        }
        return false;
    }
}
