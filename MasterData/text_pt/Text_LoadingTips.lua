__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_LoadingTips = readonly({
  LoadingTips_17465_LoadingTips = {
    Text = "\nTaxa de Afinidade: O grau de sincronização mental entre o Investigador, o Guardião e seu Despertar parceiro.\nQuanto maior a Taxa de Afinidade, mais profunda a compreensão, mais próximo o relacionamento e mais forte a confiança entre eles."
  },
  LoadingTips_17466_LoadingTips = {
    Text = "No Domínio, emoções, pensamentos, ideias e obsessões podem se manifestar como projeções observáveis. Essas projeções são geralmente itens intangíveis, ilusões enganosas criadas pela dimensão espiritual para enganar os sentidos dos indivíduos na dimensão real."
  },
  LoadingTips_17467_LoadingTips = {
    Text = "A transferência de gnose é um dispositivo especial instalado nas pastas dos Investigadores e Guardiões, possibilitando a transferência de consciência para Cartões de alta dimensão: Cartões de Comando, visíveis apenas através de equipamentos de observação de Dissolução."
  },
  LoadingTips_17468_LoadingTips = {
    Text = "Uma vez que uma D-Rift se forma, não pode encolher ou ser encerrada.\nMeios ordinários não podem afetar uma D-Rift, mas uma Chave Prata pode suprimir ou até mesmo \"fechar\" para algum grau."
  },
  LoadingTips_17469_LoadingTips = {
    Text = "A maioria dos indivíduos afetados pela Dissolução experimenta distúrbios mentais, como paranoia, TOC e mania, juntamente com perda de memória."
  },
  LoadingTips_17470_LoadingTips = {
    Text = "A corrosão da Dissolução pode ocorrer em seres orgânicos, incluindo humanos, animais e plantas, bem como em substâncias inorgânicas, como minerais e metais.\nNenhum material foi encontrado imune ao Fenômeno d."
  },
  LoadingTips_17471_LoadingTips = {
    Text = "A maioria dos humanos não pode observar o Fenômeno d a olho nu."
  },
  LoadingTips_17472_LoadingTips = {
    Text = "Corpos dissoludos podem ser geralmente classificados com base em diferentes aberrações. Os tipos mais comuns são corpos dissoludos cooperativos, corpos dissoludos de interferência e corpos dissoludos compostos."
  },
  LoadingTips_17473_LoadingTips = {
    Text = "Manifestações do Fenômeno d em materiais aparecem como buracos triangulares pequenos, invertidos, únicos ou múltiplos. \nEsses buracos variam em tamanho de aproximadamente 3mm a 1cm, com Marcas d se expandindo à medida que a dissolução avança."
  },
  LoadingTips_17474_LoadingTips = {
    Text = "A Dissolução é um fenômeno único de desintegração e dissolução material, com características regionais."
  },
  LoadingTips_17475_LoadingTips = {
    Text = "Em uma certa fase do desenvolvimento do Fenômeno d, há uma certa probabilidade de que crescimentos surgirão das Marca d.\nEsses podem ser membros extras, tentáculos ou talvez engrenagens e partes metálicas..."
  },
  LoadingTips_17476_LoadingTips = {
    Text = "D-Limo é hidrofóbico, impermeável e difícil de dissolver em água, com viscosidade moderada e alguma elasticidade.\nCentenas de anos atrás, humanos imprudentes tentaram usá-lo como material industrial e artístico."
  },
  LoadingTips_17477_LoadingTips = {
    Text = "\"Bem-vindo ao Celeiro—onde temos os maiores arquivos e os menores funerais.\"\nO Arquivo e Escritório de Registros do CMT é humoristicamente apelidado de \"Celeiro\" pelo Comitê devido à sua similaridade fonética."
  },
  LoadingTips_17478_LoadingTips = {
    Text = "Membros dos escultores costumam se referir a si mesmos como \"Pigmalião\", e seu logotipo organizacional também é um cinzel."
  },
  LoadingTips_17479_LoadingTips = {
    Text = "A Dissolução é desconhecida para os mundanos, mas em certas sociedades secretas, as pessoas acreditam firmemente que não é uma calamidade, mas sim uma benção de Deus."
  },
  LoadingTips_17480_LoadingTips = {
    Text = "\nUma enorme Marca d com um diâmetro superior a 5 metros e o potencial para expansão adicional é conhecida como uma Fenda d.\nO núcleo da fenda é chamado de \"Clades\"."
  },
  LoadingTips_17481_LoadingTips = {
    Text = "A Gnose de emergência impacta diretamente o espírito do Despertador, desbloqueando seu potencial e restaurando instantaneamente seu estado. O único lado negativo é seu alto custo."
  },
  LoadingTips_17482_LoadingTips = {
    Text = "Missões em campo são altamente imprevisíveis e repletas de fatores incontroláveis.\nPara lidar com isso, a Universidade Mythag fornece dispositivos de emergência para pessoal de campo, visando maximizar sua segurança."
  },
  LoadingTips_17483_LoadingTips = {
    Text = "Investigadores e Guardiões geralmente não lidam com eventos ordinários do mundo real, mas sim com eventos especiais envolvendo Dissolução, Corpos Dissolutos e conexões significativas com a Dimensão do Espírito."
  },
  LoadingTips_17484_LoadingTips = {
    Text = "Em áreas com Fenômeno d, as projeções da Dimensão espiritual são mais claras e os Domínios são mais fáceis de observar, embora sejam mais voláteis e perigosos."
  },
  LoadingTips_17485_LoadingTips = {
    Text = "Despertadores são aproximadamente divididos em quatro Reinos: Aequor, Caro, Ultra e Caos, com base em suas características."
  },
  LoadingTips_17486_LoadingTips = {
    Text = "Após o Ritual da Chave Mound, Investigadores e Guardiões devem completar uma tarefa de campo supervisionada com seus Despertadores parceiros para garantir que possuam a habilidade de realizar futuras tarefas de campo de forma independente."
  },
  LoadingTips_17487_LoadingTips = {
    Text = "O Comitê Mystia (abreviado como CMT) é uma organização secreta composta por humanos comuns, criada em conjunto pelos governos, mas existindo independentemente deles. \nÉ o primeiro descobridor e primeiro respondente ao Fenômeno d, \ne também a primeira linha de defesa para humanos comuns contra a Dissolução."
  },
  LoadingTips_17488_LoadingTips = {
    Text = "Despertadores diferentes no mesmo Reino podem cooperar melhor, enquanto pode haver alguma repulsão entre diferentes Reinos.\nApenas o Reino do Caos não apresenta esse fenômeno."
  },
  LoadingTips_17489_LoadingTips = {
    Text = "As Pratas geralmente existem em duas formas no mundo real: prata prime e Pratas romboédricas."
  },
  LoadingTips_17490_LoadingTips = {
    Text = "O índice gnóstico mede a estabilidade dos Fragmentos do Espírito em Pratas.\nDespertadores com índices mais altos têm menos probabilidade de perder o controle, e se o fizerem, causarão menos vítimas."
  },
  LoadingTips_17491_LoadingTips = {
    Text = "A criação de uma Chave de Prata envolve uma série de processos complexos, culminando na gravação de um número único.\nChaves de Prata são estritamente proibidas de serem comercializadas ou presenteadas, e serão reclamadas por Mythag quando não tiverem proprietário."
  },
  LoadingTips_17492_LoadingTips = {
    Text = "Os livros tabus estão trancados na prateleira mais alta da biblioteca e só podem ser acessados por pessoal autorizado."
  },
  LoadingTips_17493_LoadingTips = {
    Text = "A Universidade Mythag fornecerá suporte da Tecnologia de Chip Prata ao Comitê do Tratado Mystia conforme as cláusulas relevantes do Tratado Mystia para resistir conjuntamente à dissolução e enfrentar a crise"
  },
  LoadingTips_17494_LoadingTips = {
    Text = "Cada indivíduo resulta em diferentes quantidades de Prata ao se dissolver.\nIndivíduos com maior poder espiritual resultam em mais Prata quando dissolvidos, enquanto aqueles com menor poder espiritual resultam em menos."
  },
  LoadingTips_17495_LoadingTips = {
    Text = "Os itens representativos na Tecnologia de Chips de Prata incluem Equipamento de Observação de Dissolução, Comunicador da Universidade Mythag e Chave de Prata.\nO mais único e precioso deles é a Chave de Prata."
  },
  LoadingTips_17496_LoadingTips = {
    Text = "Na Cerimônia de Despertar, Investigadores e Guardiães usam Chaves de Prata para fortalecer a conexão entre a Prata e a Dimensão do Espírito.\nAtravés dessa conexão, Investigadores e Guardiães podem capturar Fragmentos de Espírito que vagueiam na Dimensão do Espírito e ancorá-los dentro da Prata."
  },
  LoadingTips_17497_LoadingTips = {
    Text = "Despertadores são criados à força quando a Prata captura e fixa Fragmentos de Espírito da Dimensão Espírito. Esses fragmentos são influenciados pela Dimensão Espírito, portanto, todos os Despertadores naturalmente entram em um Estado de Loucura ao serem despertados. Esse estado persiste até que um Investigador ou Guardião estabeleça um Link com eles."
  },
  LoadingTips_17498_LoadingTips = {
    Text = "A Universidade Mythag, estabelecida em 16 de outubro de 187 Hongji, é uma instituição de ensino superior dedicada a pesquisar e combater a Dissolução."
  },
  LoadingTips_17499_LoadingTips = {
    Text = "O antecessor da Universidade Mythag, o Colégio Mythag, foi fundado em 16 de outubro do Ano 90 da Era Hongji por Wald Phillips e dois outros fundadores."
  },
  LoadingTips_17500_LoadingTips = {
    Text = "Investigadores e Guardiões com uma Chave Prateada podem atravessar a Névoa do Pátio da Escola e entrar no campus com Despertadores Ligados."
  },
  LoadingTips_17501_LoadingTips = {
    Text = "Há 315 anos, um desastre massivo varreu o globo.\nEste ano foi marcado como o início de uma nova era— a Época da Inundação."
  },
  LoadingTips_17502_LoadingTips = {
    Text = "\"Que a Chave de Prata guie seu caminho.\"\nUma bênção comum entre os membros da Universidade Mythag, incorporando seu espírito indomável."
  },
  LoadingTips_17503_LoadingTips = {
    Text = "\"Jure perfurar a escuridão com a lâmina.\"\nUm juramento comum dos membros do Comitê do Tratado Mystia, refletindo sua determinação inabalável de lutar contra a Dissolução."
  },
  LoadingTips_17504_LoadingTips = {
    Text = "Aqueles talentos especiais que possuem mais habilidades e podem conectar mais Despertadores do que os investigadores comuns recebem o título de Guardião.\nAté agora, apenas alguns no mundo possuem o nome de Guardião."
  },
  LoadingTips_17505_LoadingTips = {
    Text = "Geralmente, um Investigador pode apenas se conectar a um Despertador por vez. No entanto, exceções existem."
  },
  LoadingTips_17506_LoadingTips = {
    Text = "Quando não há missões de campo, Investigadores, Guardiões e seus Despertadores descansam na Universidade Mythag.\nEles assistem aulas, fazem exames e completam longas tarefas extraclasse."
  },
  LoadingTips_17507_LoadingTips = {
    Text = "Todos os Despertadores devem respeitar as regulamentações do Tratado Mystia e registrar-se após o despertar"
  },
  LoadingTips_17508_LoadingTips = {
    Text = "Falando estritamente, os Despertadores também são uma forma de Tecnologia de Chip de Prata."
  },
  LoadingTips_36756_LoadingTips = {
    Text = "Dependendo do tipo da fissura, uma fissura pode ter um ou mais núcleos conhecidos como \"Catástrofe.\""
  },
  LoadingTips_36757_LoadingTips = {
    Text = "Mythag desenvolveu, refinou e personalizou uma série de processos de triagem baseados na teoria de \"Composição Mental e Potencial do Investigador\" para descobrir Investigadores potenciais sem alarmar o público em geral."
  },
  LoadingTips_36758_LoadingTips = {
    Text = "O espírito de todos é diferente, e as habilidades únicas de cada Guardião também variam.\nAs habilidades conhecidas atualmente incluem: Memória compartilhada, emoções compartilhadas e percepção de humor, entre outras."
  },
  LoadingTips_36759_LoadingTips = {
    Text = "Há 315 anos, uma grande inundação varreu o mundo. A ordem desmoronou, cidades ruíram e montanhas sob o mar surgiram repentinamente, formando novas terras."
  },
  LoadingTips_36760_LoadingTips = {
    Text = "Leo Fang, a moeda comum do Reino de Leo. Moedas auxiliares como Crina e Pensh também estão em circulação. 1 Leo Fang é igual a 10 Crinas, e 1 Crina é igual a 10 Penshs."
  },
  LoadingTips_36761_LoadingTips = {
    Text = "Um espaço especial temporariamente isolado com a ajuda de instrumentos e Prata, não afetado por outros espíritos ou pela dimensão real, é chamado de Domínio Artificial."
  },
  LoadingTips_36762_LoadingTips = {
    Text = "Através do elevador, você pode alcançar o espaço subterrâneo de Mythag.\nAlém da maior Fissura L-01 \"Piscina Negra\" em Londinium, há várias áreas restritas que requerem um certo nível de segurança para entrar."
  },
  LoadingTips_36763_LoadingTips = {
    Text = "Devido à conexão entre a chave de prata e a dimensão espiritual, a chave pode reagir quando perto de indivíduos com estados espirituais anormais"
  },
  LoadingTips_36764_LoadingTips = {
    Text = "Pactos são runas misteriosas registradas em materiais com Pratas usando métodos especiais.\nDiferentes pactos fornecem diferentes auxílios, e a mesma série de pactos pode oferecer mais assistência."
  },
  LoadingTips_36765_LoadingTips = {
    Text = "D-limo é uma gosma preta que permeia os D-marques.\nAssim como o próprio D-fenômeno, sem instrumentos especiais, pessoas comuns não podem observá-lo diretamente."
  },
  LoadingTips_36766_LoadingTips = {
    Text = "Alguns corpos dissolutos se transformam em um pó negro, conhecido como Poeira d, ao morrer."
  },
  LoadingTips_36767_LoadingTips = {
    Text = "O Reino do Leão está localizado a leste do Oceano Atlanta, fazendo fronteira com a Federação Constante e a União Evergreen.\nO reino é pequeno em tamanho, mas poderoso, sendo um dos primeiros a completar a reconstrução após o dilúvio."
  },
  LoadingTips_36768_LoadingTips = {
    Text = "A República Aglo está localizada no lado ocidental do Oceano Atlanta, cercada pelo mar e possuindo vastas áreas interiores.\nA República Aglo é altamente desenvolvida na indústria e nas finanças, com seu centro financeiro, Fletcher, sendo um ponto movimentado que muitos sonham em visitar."
  },
  LoadingTips_36769_LoadingTips = {
    Text = "No Domínio, emoções, pensamentos, ideias e obsessões podem se manifestar como projeções observáveis.\nEssas projeções geralmente são intangíveis ou se dissipam ao toque, ilusões da Dimensão Espiritual que enganam os sentidos dos indivíduos na dimensão física."
  },
  LoadingTips_36770_LoadingTips = {
    Text = "A Federação Constante está localizada no continente Leste de Laurasia, uma federação formada por vários pequenos países. Na federação, a arte é uma busca comum para todos."
  },
  LoadingTips_36771_LoadingTips = {
    Text = "Algumas projeções especiais podem ser capturadas pelo Transferência de Gnose e anexadas a cartões de comando, fornecendo bônus aos Despertadores. Essas projeções são chamadas de Oração."
  },
  LoadingTips_36772_LoadingTips = {
    Text = "Com base no tamanho dos D-Rifts, eles podem ser classificados grosso modo em seis categorias: C, B, A, S, SS e SSS."
  },
  LoadingTips_36773_LoadingTips = {
    Text = "Os Escultores, uma organização extrema obcecada por experimentos humanos pecaminosos, foi fundada por Robert Rosenthal, um traidor de Mythag."
  },
  LoadingTips_36774_LoadingTips = {
    Text = "Os Marinheiros são uma antiga organização religiosa liderada por Miryam.\nEles trabalham arduamente, tudo para o propósito de reviver seu único e verdadeiro Deus-Rei."
  },
  LoadingTips_36775_LoadingTips = {
    Text = "Diferentes áreas do Domínio produzem diferentes itens durante a Investigação. Mesmo itens aparentemente idênticos podem possuir essências vastamente diferentes."
  },
  LoadingTips_36776_LoadingTips = {
    Text = "Um Domínio é uma dimensão especial entre a dimensão espiritual e a dimensão física, e é o espaço mais próximo que os humanos podem fisicamente entrar na dimensão espiritual."
  },
  LoadingTips_36777_LoadingTips = {
    Text = "A Universidade Mythag é uma terceira parte absolutamente neutra. Todos os assuntos, grandes ou pequenos, são decididos em conjunto pelo diretor e pela equipe de gestão através de consultas, livres de quaisquer constrangimentos organizacionais."
  },
  LoadingTips_36778_LoadingTips = {
    Text = "D-Rifts não precisam depender de objetos físicos para existir; podem aparecer no céu, no oceano e em outros locais."
  },
  LoadingTips_36779_LoadingTips = {
    Text = "Igreja da Luz do Templo, uma seita secreta e maligna, parece ter laços profundos com os Escultores e Marinheiros."
  },
  LoadingTips_36780_LoadingTips = {
    Text = "O Comitê do Tratado Mystia é uma organização extremamente grande.\nAlém do Reino de Leo, possui filiais na República Aglo, Federação Constante e até mesmo no Império Remouahe."
  }
})
return Text_LoadingTips
