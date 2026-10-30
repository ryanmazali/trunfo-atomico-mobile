import '../models/isotopo.dart';

// Dados mockados da Sprint 1.
// Os 13 isótopos e as 19 aplicações são os mesmos do script do banco
// (TrunfoAtomico_BD.sql), com os mesmos nomes e números.
// Meia-vida sempre em dias; anos convertidos com 365,25 dias.

const String nndc = 'NNDC - NuDat 3.0 (Brookhaven)';
const String nidc = 'National Isotope Development Center';
const String iaea = 'IAEA - Nuclear Data Services';
const String cnen = 'CNEN - Aplicações da Energia Nuclear';
const String ipen = 'IPEN - Instituto de Pesquisas Energéticas e Nucleares';

const List<Isotopo> isotopos = [
    Isotopo(
        id: 1,
        nome: 'Flúor-18',
        simbolo: 'F',
        numeroMassa: 18,
        meiaVidaDias: 109.734 / 1440,
        fonte: nndc,
        aplicacoes: [
        Aplicacao(
            nome: 'PET-CT com FDG',
            descricao:
                'Uma glicose marcada mostra onde o corpo consome mais energia, o que destaca tumores e áreas do cérebro.',
            area: 'Saúde',
        ),
        ],
        afirmacao:
            'O flúor-18 usado no exame de PET-CT continua no corpo por semanas.',
        afirmacaoVerdadeira: false,
        explicacao:
            'Ele perde metade da radioatividade a cada 110 minutos. Em 24 horas já passaram 13 meias-vidas e resta menos de 0,02% do que foi aplicado.',
        fonteExplicacao: nndc,
    ),
    Isotopo(
        id: 2,
        nome: 'Tecnécio-99m',
        simbolo: 'Tc',
        numeroMassa: 99,
        metaestavel: true,
        meiaVidaDias: 6.0066 / 24,
        fonte: nndc,
        aplicacoes: [
        Aplicacao(
            nome: 'Cintilografia óssea',
            descricao:
                'O paciente recebe um radiofármaco e a câmara gama fotografa o esqueleto por dentro, sem cirurgia.',
            area: 'Saúde',
        ),
        ],
        afirmacao: 'Quem faz uma cintilografia fica radioativo para sempre.',
        afirmacaoVerdadeira: false,
        explicacao:
            'O tecnécio-99m perde metade da radioatividade a cada 6 horas. Em cerca de dois dias praticamente não resta nada no corpo.',
        fonteExplicacao: nndc,
    ),
    Isotopo(
        id: 3,
        nome: 'Molibdênio-99',
        simbolo: 'Mo',
        numeroMassa: 99,
        meiaVidaDias: 65.932 / 24,
        fonte: nndc,
        aplicacoes: [
        Aplicacao(
            nome: 'Gerador de tecnécio-99m',
            descricao:
                'Isótopo "pai" enviado aos hospitais: o tecnécio vai sendo extraído dele conforme se forma.',
            area: 'Pesquisa Científica',
        ),
        ],
        afirmacao:
            'O tecnécio usado nos hospitais nasce do decaimento de outro isótopo.',
        afirmacaoVerdadeira: true,
        explicacao:
            'O molibdênio-99 decai e vira tecnécio-99m. O hospital recebe um gerador com molibdênio e retira o tecnécio todos os dias, conforme ele se forma.',
        fonteExplicacao: ipen,
    ),
    Isotopo(
        id: 4,
        nome: 'Iodo-131',
        simbolo: 'I',
        numeroMassa: 131,
        meiaVidaDias: 8.0249,
        fonte: nndc,
        aplicacoes: [
        Aplicacao(
            nome: 'Tratamento de tireoide',
            descricao:
                'Dose maior que a de diagnóstico, tomada por via oral, para hipertireoidismo e câncer de tireoide.',
            area: 'Saúde',
        ),
        ],
        afirmacao:
            'É possível tratar doenças da tireoide com uma cápsula radioativa, sem cirurgia.',
        afirmacaoVerdadeira: true,
        explicacao:
            'A tireoide absorve iodo naturalmente. O iodo-131 tomado por via oral se concentra nela e age principalmente ali, poupando o resto do corpo.',
        fonteExplicacao: cnen,
    ),
    Isotopo(
        id: 5,
        nome: 'Irídio-192',
        simbolo: 'Ir',
        numeroMassa: 192,
        meiaVidaDias: 73.829,
        fonte: nidc,
        aplicacoes: [
        Aplicacao(
            nome: 'Braquiterapia',
            descricao:
                'A fonte é colocada dentro ou ao lado do tumor, concentrando a dose e poupando o tecido vizinho.',
            area: 'Saúde',
        ),
        Aplicacao(
            nome: 'Gamagrafia industrial',
            descricao:
                'Radiografia de peças metálicas: encontra falhas em soldas, turbinas e asas de avião sem cortar a peça.',
            area: 'Indústria',
        ),
        ],
        afirmacao:
            'Para descobrir se uma solda tem falha por dentro, é preciso cortar a peça.',
        afirmacaoVerdadeira: false,
        explicacao:
            'Na gamagrafia, a radiação do irídio-192 atravessa o metal e marca um filme do outro lado, como um raio X. A peça continua inteira.',
        fonteExplicacao: cnen,
    ),
    Isotopo(
        id: 6,
        nome: 'Cobalto-60',
        simbolo: 'Co',
        numeroMassa: 60,
        meiaVidaDias: 5.2714 * 365.25,
        fonte: nndc,
        aplicacoes: [
        Aplicacao(
            nome: 'Teleterapia (bomba de cobalto)',
            descricao:
                'Equipamento de radioterapia que irradia o tumor de fora do corpo.',
            area: 'Saúde',
        ),
        Aplicacao(
            nome: 'Esterilização de material médico',
            descricao:
                'Seringas, luvas cirúrgicas e gaze são esterilizadas já embaladas, sem calor e sem produto químico.',
            area: 'Indústria',
        ),
        Aplicacao(
            nome: 'Irradiação de alimentos',
            descricao:
                'Batata, cebola, alho e feijão passam por uma esteira sob o irradiador e duram muito mais tempo.',
            area: 'Agricultura e Alimentos',
        ),
        Aplicacao(
            nome: 'Técnica do inseto estéril',
            descricao:
                'Machos esterilizados por radiação são soltos no campo e a população da praga despenca.',
            area: 'Agricultura e Alimentos',
        ),
        ],
        afirmacao: 'Um alimento irradiado fica radioativo.',
        afirmacaoVerdadeira: false,
        explicacao:
            'A radiação atravessa o alimento e não fica nele, assim como uma mala não fica radioativa depois de passar pelo raio X do aeroporto.',
        fonteExplicacao: cnen,
    ),
    Isotopo(
        id: 7,
        nome: 'Trítio (Hidrogênio-3)',
        simbolo: 'H',
        numeroMassa: 3,
        meiaVidaDias: 12.32 * 365.25,
        fonte: nndc,
        aplicacoes: [
        Aplicacao(
            nome: 'Sinalização de emergência autoluminosa',
            descricao:
                'Placas de saída que brilham sozinhas, sem pilha e sem fiação, mesmo durante um apagão.',
            area: 'Indústria',
        ),
        ],
        afirmacao:
            'Existem placas de saída que brilham no escuro por anos sem usar energia elétrica.',
        afirmacaoVerdadeira: true,
        explicacao:
            'O trítio fica selado em tubos de vidro e faz uma tinta brilhar. A radiação dele é tão fraca que não atravessa o vidro.',
        fonteExplicacao: iaea,
    ),
    Isotopo(
        id: 8,
        nome: 'Estrôncio-90',
        simbolo: 'Sr',
        numeroMassa: 90,
        meiaVidaDias: 28.91 * 365.25,
        fonte: nndc,
        aplicacoes: [
        Aplicacao(
            nome: 'Radioterapia superficial',
            descricao:
                'Aplicador usado em lesões rasas, inclusive oftálmicas, por ter alcance muito curto.',
            area: 'Saúde',
        ),
        Aplicacao(
            nome: 'Medidor de espessura',
            descricao:
                'Mede a espessura de chapas e filmes em linha de produção sem tocar no material.',
            area: 'Indústria',
        ),
        ],
        afirmacao:
            'A radioterapia com estrôncio-90 atinge os órgãos mais profundos do corpo.',
        afirmacaoVerdadeira: false,
        explicacao:
            'A radiação do estrôncio-90 penetra só alguns milímetros. É por isso que ele serve para lesões rasas, como as da superfície do olho.',
        fonteExplicacao: cnen,
    ),
    Isotopo(
        id: 9,
        nome: 'Amerício-241',
        simbolo: 'Am',
        numeroMassa: 241,
        meiaVidaDias: 432.6 * 365.25,
        fonte: nndc,
        aplicacoes: [
        Aplicacao(
            nome: 'Detector de fumaça por ionização',
            descricao:
                'Uma fonte selada minúscula percebe a fumaça no ar antes de a pessoa sentir o cheiro.',
            area: 'Indústria',
        ),
        ],
        afirmacao:
            'Muitos detectores de fumaça têm uma pequena fonte radioativa dentro.',
        afirmacaoVerdadeira: true,
        explicacao:
            'O amerício-241 deixa o ar dentro do detector levemente carregado. Quando a fumaça entra, ela atrapalha essa corrente e o alarme dispara.',
        fonteExplicacao: iaea,
    ),
    Isotopo(
        id: 10,
        nome: 'Carbono-14',
        simbolo: 'C',
        numeroMassa: 14,
        meiaVidaDias: 5700 * 365.25,
        fonte: nndc,
        aplicacoes: [
        Aplicacao(
            nome: 'Datação por carbono',
            descricao:
                'Mede quanto carbono radioativo ainda resta no material para descobrir a idade de fósseis e papiros.',
            area: 'Pesquisa Científica',
        ),
        ],
        afirmacao:
            'O carbono-14 serve para descobrir a idade de rochas com milhões de anos.',
        afirmacaoVerdadeira: false,
        explicacao:
            'Com meia-vida de 5.700 anos, depois de uns 50 mil anos sobra pouco demais para medir. Rochas antigas são datadas com outros isótopos, como o potássio-40.',
        fonteExplicacao: nndc,
    ),
    Isotopo(
        id: 11,
        nome: 'Urânio-235',
        simbolo: 'U',
        numeroMassa: 235,
        meiaVidaDias: 704000000 * 365.25,
        fonte: nndc,
        aplicacoes: [
        Aplicacao(
            nome: 'Combustível de reator de potência',
            descricao:
                'A fissão aquece a água, gera vapor e move a turbina que produz eletricidade.',
            area: 'Geração de Energia',
        ),
        Aplicacao(
            nome: 'Combustível de reator naval',
            descricao:
                'Reator compacto que move a embarcação por longos períodos sem reabastecer.',
            area: 'Propulsão Naval',
        ),
        ],
        afirmacao:
            'O urânio de uma usina nuclear é o mesmo, na mesma concentração, de uma bomba atômica.',
        afirmacaoVerdadeira: false,
        explicacao:
            'O combustível de uma usina tem de 3% a 5% de urânio-235. Armas usam urânio com cerca de 90%. São materiais muito diferentes.',
        fonteExplicacao: iaea,
    ),
    Isotopo(
        id: 12,
        nome: 'Potássio-40',
        simbolo: 'K',
        numeroMassa: 40,
        meiaVidaDias: 1248000000 * 365.25,
        fonte: nndc,
        aplicacoes: [
        Aplicacao(
            nome: 'Datação potássio-argônio',
            descricao:
                'Usada para rochas e minerais, alcança idades de milhões a bilhões de anos.',
            area: 'Pesquisa Científica',
        ),
        ],
        afirmacao: 'O corpo humano é naturalmente um pouco radioativo.',
        afirmacaoVerdadeira: true,
        explicacao:
            'Uma pequena parte do potássio que comemos é potássio-40. No corpo de um adulto acontecem cerca de 4 mil decaimentos por segundo, sem fazer mal.',
        fonteExplicacao: cnen,
    ),
    Isotopo(
        id: 13,
        nome: 'Fósforo-32',
        simbolo: 'P',
        numeroMassa: 32,
        meiaVidaDias: 14.269,
        fonte: nndc,
        aplicacoes: [
        Aplicacao(
            nome: 'Traçador em adubo fosfatado',
            descricao:
                'O adubo é marcado e a radiação revela quanto a planta realmente absorveu, da raiz à folha, e quanto se perde no solo.',
            area: 'Agricultura e Alimentos',
        ),
        ],
        afirmacao:
            'Pesquisadores usam isótopos para saber quanto do adubo a planta realmente aproveita.',
        afirmacaoVerdadeira: true,
        explicacao:
            'O fósforo-32 funciona como uma etiqueta: medindo a radiação na planta, dá para ver quanto adubo ela absorveu e quanto foi desperdiçado.',
        fonteExplicacao: iaea,
    ),
];

int totalDeAplicacoes() {
    int total = 0;
    for (Isotopo isotopo in isotopos) {
        total = total + isotopo.aplicacoes.length;
    }
    return total;
}