__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Tutorial = readonly({
  Tutorial_120371_Desc_1 = {
    Text = "Pode retornar a turnos vividos na batalha, podendo voltar a qualquer um dos 25 turnos anteriores da batalha."
  },
  Tutorial_120371_Title_1 = {
    Text = "Inversão Temporal"
  },
  Tutorial_124999_Desc_1 = {
    Text = "No modo <TutorialHighlight:Traphase-Draft Pick>, clique em \"Começar a correspondência\" no canto inferior direito da interface para entrar na busca de partidas sem precisar pré-montar uma equipe."
  },
  Tutorial_124999_Desc_2 = {
    Text = "Antes do início da partida, uma <TutorialHighlight:Relíquia> aleatória é escolhida para influenciar a batalha que se aproxima. Os jogadores então se revezam escolhendo Despertadores, Rodas do Destino e Posses de uma pool limitada para montar suas formações. Para ajustar sua estratégia, clique em quaisquer dois Despertadores para trocar suas posições (numeradas de 1 a 4, da frente para trás)."
  },
  Tutorial_124999_Desc_3 = {
    Text = "Para ajustar sua formação, clique em quaisquer dois Despertadores para trocar suas posições (numerados de 1 a 4, da frente para trás)."
  },
  Tutorial_124999_Title_1 = {
    Text = "Escalação da Escolha do Draft"
  },
  Tutorial_126878_Desc_1 = {
    Text = "Quando a Surge Psíquica de certos Despertadores atinge +12, eles ganham automaticamente o efeito \"Axioma Absoluto\", que varia para cada Despertador."
  },
  Tutorial_126878_Desc_2 = {
    Text = "Após desbloquear o \"Axioma Absoluto\" do Despertador, você receberá uma mensagem exclusiva do Despertador. Lembre-se de conferir!"
  },
  Tutorial_126878_Title_1 = {
    Text = "Regra Final"
  },
  Tutorial_126878_Title_2 = {
    Text = "Mensagem Exclusiva"
  },
  Tutorial_148475_Desc_1 = {
    Text = "Após a Taxa de Sincronização do Corpo Desperto atingir <TutorialHighlight:Lv20>, você poderá obter um <TutorialHighlight:Cintila> exclusivo."
  },
  Tutorial_148475_Desc_2 = {
    Text = "O <TutorialHighlight:Cintila> é a prova da União Sagrada entre você e o Corpo Desperto."
  },
  Tutorial_148475_Desc_3 = {
    Text = "Agora, as Cartas de comando deste Corpo Desperto serão exibidas de forma especial durante o combate e poderão ser mostradas a outros Guardiões do segredo em ocasiões sociais."
  },
  Tutorial_148475_Title_1 = {
    Text = "União Sagrada"
  },
  Tutorial_17805_Desc_1 = {
    Text = "Clique no inimigo para ver todos os seus status. <TutorialHighlight:Aviso> status requerem atenção especial, representam mecânicas especiais do inimigo, muitas vezes a causa do fracasso na investigação"
  },
  Tutorial_17805_Title_1 = {
    Text = "Estado do inimigo"
  },
  Tutorial_17806_Desc_1 = {
    Text = "Após derrotar inimigos, você pode escolher <TutorialHighlight:Gravura>, ou gastar <TutorialHighlight:Marca Negra> na <TutorialHighlight:Marca de Fusão> para comprar. <TutorialHighlight:Gravura> permite que cartas específicas obtenham diferentes efeitos adicionais. Cada carta específica pode ser gravada no máximo <TutorialHighlight:1> vez. Priorize a gravação em cartas de comando que são disparadas com mais frequência, isso pode aumentar os benefícios da gravura."
  },
  Tutorial_17806_Title_1 = {Text = "Gravura"},
  Tutorial_17807_Desc_1 = {
    Text = "Fornece várias propriedades ao Corpo Desperto, e se composto por <TutorialHighlight:conjunto>, terá efeitos especiais. Existem 6 partes, e os <TutorialHighlight:atributos principais> variam entre as partes. A Taxa de Crítico e o Dano crítico aparecerão nas partes I, II e III; o Nível de Recarga de Fúria e o Nível de Carga da Chave de Prata aparecerão nas partes I, IV e V; o Domínio de área e a Queda de marca negra aparecerão nas partes II, IV e VI; o Dano potencializado e a Resistência à Morte aparecerão nas partes III, V e VI."
  },
  Tutorial_17807_Title_1 = {Text = "Mystik"},
  Tutorial_17808_Desc_1 = {
    Text = "No modo de jogo <TutorialHighlight:Mergulho Fantasmagórico>, cada fase de desafio entrará aleatoriamente em um mapa. Ao completar o desafio com sucesso, você ganhará pontos correspondentes com base na dificuldade da fase, nos Despertadores Aprimorados e nos itens de pontuação dentro da fase. Diferentes Relíquias iniciais e Despertadores Aprimorados estarão disponíveis para desafios semanais."
  },
  Tutorial_17808_Desc_2 = {
    Text = "O Mergulho Fantasmal normalmente atualiza sua temporada a cada 28 dias. Concluir o Mergulho Fantasmal uma vez durante uma temporada permite que você participe do <TutorialHighlight:Ranking da Temporada>. Ao final da temporada, os rankings serão finalizados e as recompensas de ranking serão enviadas pela caixa de correio."
  },
  Tutorial_17808_Desc_3 = {
    Text = "Os \"Registros de Mergulho Profundo\" têm múltiplos objetivos, e recompensas correspondentes podem ser obtidas após a conclusão. Cada vez que você completa um objetivo de \"Registro de Mergulho Profundo\" ou vence um desafio de Mergulho Profundo, você ganhará <TutorialHighlight:EXP de Mergulho Profundo>. Quando a EXP de Mergulho Profundo atingir um certo valor, <TutorialHighlight:Nível de Mergulho Profundo> aumentará, permitindo que você receba recompensas abundantes. Você pode verificar os \"Registros de Mergulho Profundo\" e o \"Nível de Mergulho Profundo\" no canto inferior esquerdo da interface."
  },
  Tutorial_17808_Title_1 = {
    Text = "Mergulho Fantasmal"
  },
  Tutorial_17809_Desc_1 = {
    Text = "Através de eventos e marcas d, é possível obter <TutorialHighlight:Relíquia>, <TutorialHighlight:Relíquia> pode fortalecer a capacidade de combate da nossa equipe. Os excelentes guardiões geralmente escolhem os <TutorialHighlight:Relíquia> que mais se adequam às necessidades da equipe"
  },
  Tutorial_17809_Title_1 = {Text = "Criação"},
  Tutorial_17810_Desc_1 = {
    Text = "Dispersa a névoa, aumenta a visão do mapa em <TutorialHighlight:2> blocos, permitindo melhor planejamento de rotas"
  },
  Tutorial_17810_Title_1 = {
    Text = "projector de busca"
  },
  Tutorial_17811_Desc_1 = {
    Text = "O alvo em estado de <TutorialHighlight:veneno> sofre dano equivalente ao número de camadas de <TutorialHighlight:veneno> ao final do turno. O dano de <TutorialHighlight:veneno> <TutorialHighlight:não pode ser crítico>"
  },
  Tutorial_17811_Title_1 = {
    Text = "Envenenamento"
  },
  Tutorial_17812_Desc_1 = {
    Text = "Alvos em estado de <TutorialHighlight:Vulnerável> recebem 50% mais dano, removendo automaticamente 1 camada de <TutorialHighlight:Vulnerável> no final do turno. Aproveite quando o inimigo estiver em <TutorialHighlight:Vulnerável> para causar mais dano"
  },
  Tutorial_17812_Title_1 = {
    Text = "Vulnerável"
  },
  Tutorial_17813_Desc_1 = {
    Text = "Após concluir os estágios em \"Ruínas da Dissolução\", \"Convênio Proibido\" e \"Domínio Arcano\", esses estágios e os de dificuldade mais baixa podem ser <TutorialHighlight:Reencenados>. Ganhe rapidamente as recompensas dos estágios através de <TutorialHighlight:Reencenar>."
  },
  Tutorial_17813_Title_1 = {Text = "Reproduzir"},
  Tutorial_17814_Desc_1 = {
    Text = "<TutorialHighlight:Escudo> pode absorver dano em vez de vida, no final do turno <TutorialHighlight:remover automaticamente> todos os escudos, o limite do escudo é igual ao <TutorialHighlight:limite de vida> da equipe. Tente <TutorialHighlight:igualar o escudo ao total de dano de todos os inimigos neste turno> para obter a vitória na batalha com o menor custo possível."
  },
  Tutorial_17814_Title_1 = {Text = "Escudo"},
  Tutorial_17815_Desc_1 = {
    Text = "Obter repetidamente o Corpo Desperto irá convertê-lo em <TutorialHighlight:Fragmento>. Consumir <TutorialHighlight:Fragmento> para aumentar o Nível de Inspiração do Corpo Desperto, permitindo que as habilidades do Corpo Desperto obtenham capacidades especiais adicionais. Quando o Nível de Inspiração do Corpo Desperto estiver completo, obter o fragmento correspondente será convertido em <TutorialHighlight:Fragmento de Retrocesso Espiritual>."
  },
  Tutorial_17815_Title_1 = {Text = "Fragmento"},
  Tutorial_17816_Desc_1 = {
    Text = "O poder de cálculo é <TutorialHighlight:compartilhado por toda a equipe>, disparar cartas requer <TutorialHighlight:consumo de poder de cálculo>. O poder de cálculo será <TutorialHighlight:recuperado automaticamente até o limite> no início do turno, e será <TutorialHighlight:limpo automaticamente> após o final do turno. Para melhorar a eficiência do uso do poder de cálculo, tente <TutorialHighlight:consumir todo o poder de cálculo antes de terminar o turno>."
  },
  Tutorial_17816_Title_1 = {
    Text = "Poder de cálculo"
  },
  Tutorial_17817_Desc_1 = {
    Text = "Derrotar os inimigos em <TutorialHighlight:Existência Transcendental> concede materiais de <TutorialHighlight:Melhoria Avançada>, que podem ser obtidos uma vez por semana. Diversos materiais também podem ser sintetizados e trocados na <TutorialHighlight:Sala de Fundição>."
  },
  Tutorial_17817_Title_1 = {
    Text = "Existência Transcendental"
  },
  Tutorial_17818_Desc_1 = {
    Text = "Após obter, pode usar em <TutorialHighlight:inventário>, elevando rapidamente os níveis dos despertadores e habilidades conforme o valor predefinido"
  },
  Tutorial_17818_Title_1 = {
    Text = "Amplificador de Gnosis"
  },
  Tutorial_17819_Desc_1 = {
    Text = "Quando a fúria do Corpo Desperto atinge <TutorialHighlight:100>, é possível liberar <TutorialHighlight:Fúria Explosiva>. O efeito da fúria explosiva varia entre diferentes Corpos Despertos, e sua utilização adequada pode resultar em <TutorialHighlight:resultados muito mais eficazes>."
  },
  Tutorial_17819_Title_1 = {
    Text = "Fúria Explosiva"
  },
  Tutorial_17820_Desc_1 = {
    Text = "Alvos em estado de <TutorialHighlight:Frágil> recebem 25% a menos de escudo, removendo automaticamente 1 camada de <TutorialHighlight:Frágil> no final do turno. Se nossa equipe estiver em estado de <TutorialHighlight:Frágil>, lembre-se de encontrar uma maneira de remover o estado <TutorialHighlight:Frágil> antes de defender, ou mudar a estratégia e atacar com tudo neste turno."
  },
  Tutorial_17820_Title_1 = {Text = "Frágil"},
  Tutorial_17821_Desc_1 = {
    Text = "Equipar o despertador com <TutorialHighlight:roda do destino> pode aumentar seus atributos, além de obter habilidades especiais"
  },
  Tutorial_17821_Title_1 = {
    Text = "Roda do destino"
  },
  Tutorial_17822_Desc_1 = {
    Text = "O alvo em estado de <TutorialHighlight:sangramento> sofre dano equivalente ao número de camadas de <TutorialHighlight:sangramento> ao final do turno, depois <TutorialHighlight:remove o estado de sangramento>.\nAo <TutorialHighlight:recuperar vida>, remove camadas de sangramento equivalentes a <TutorialHighlight:dobro da quantidade recuperada>. O dano de sangramento <TutorialHighlight:não pode ser crítico>."
  },
  Tutorial_17822_Title_1 = {
    Text = "Sangramento"
  },
  Tutorial_17823_Desc_1 = {
    Text = "Os despertadores do caos podem <TutorialHighlight: superar as limitações do reino> e formar equipes com outros despertadores de reinos, resultando em diferentes efeitos de simbiose. Se houver um despertador do caos em qualquer equipe, receberá uma resistência à morte adicional de 100%"
  },
  Tutorial_17823_Desc_2 = {
    Text = "Comparado com equipes de outros domínios, as equipes do domínio do caos ganham energia da chave de prata mais rapidamente, e ao liberar a segunda ordem de chave, podem escolher entre todas as ordens de chave, e a ordem escolhida será ativada 2 vezes. Portanto, as equipes do domínio do caos dependem mais da colaboração entre as ordens de chave, e escolher a ordem de chave certa pode aumentar significativamente a força da equipe do domínio do caos!"
  },
  Tutorial_17823_Title_1 = {Text = "Caos"},
  Tutorial_17824_Desc_1 = {
    Text = "A cada 1 ponto de <TutorialHighlight:alerta>, toda vez que receber um escudo, obterá 1 ponto extra de escudo"
  },
  Tutorial_17824_Title_1 = {Text = "Alerta"},
  Tutorial_17825_Desc_1 = {
    Text = "Após completar a operação de investigação pela primeira vez, você poderá receber <TutorialHighlight: Material de ativação de ressonância>, que pode ser usado para ativar uma poderosa <TutorialHighlight: Ressonância>, que será efetiva em todos os níveis deste capítulo"
  },
  Tutorial_17825_Title_1 = {
    Text = "Resonância"
  },
  Tutorial_17826_Desc_1 = {
    Text = "Quando o nosso grupo está no estado <TutorialHighlight:Selo da Fúria>, não é possível liberar a Explosão de Fúria. Antes de o inimigo causar o <TutorialHighlight:Selo da Fúria>, é possível liberar a Explosão de Fúria para evitar o desperdício de fúria."
  },
  Tutorial_17826_Title_1 = {
    Text = "Selo da Fúria"
  },
  Tutorial_17827_Desc_1 = {
    Text = "Consumir <TutorialHighlight:Elixir de Gnosis> pode aumentar o nível do corpo desperto, e os atributos serão aprimorados após o ascenso. Após atingir o limite máximo de nível, será necessário realizar primeiro um Ascenso, que aumentará o limite máximo de nível do corpo desperto."
  },
  Tutorial_17827_Title_1 = {
    Text = "Elixir de Gnosis"
  },
  Tutorial_17828_Desc_1 = {
    Text = "<TutorialHighlight:Força> Cada ponto reduzido diminui o <TutorialHighlight:dano ativo> em 1 ponto"
  },
  Tutorial_17828_Title_1 = {
    Text = "Redução de força"
  },
  Tutorial_17829_Desc_1 = {
    Text = "Antes de receber dano, imuniza e remove 1 camada de <TutorialHighlight:Barreira>. Quanto maior o dano, maior o benefício da <TutorialHighlight:Barreira>"
  },
  Tutorial_17829_Title_1 = {Text = "Barreira"},
  Tutorial_17830_Desc_1 = {
    Text = "Alvos em estado de <TutorialHighlight:Fraqueza> recebem 25% menos dano, removendo automaticamente 1 camada de <TutorialHighlight:Fraqueza> no final do turno. Se a nossa equipe estiver em estado de <TutorialHighlight:Fraqueza>, lembre-se de encontrar uma maneira de remover o estado de <TutorialHighlight:Fraqueza> antes de atacar, ou mude a estratégia e defenda com todas as forças neste turno."
  },
  Tutorial_17830_Title_1 = {Text = "Fraqueza"},
  Tutorial_17831_Desc_1 = {
    Text = "Derrotar os inimigos no <TutorialHighlight:Registro Proibido> concede um <TutorialHighlight:Mystik> que aprimora a capacidade do Corpo Desperto. Concluir cada capítulo da história desbloqueará novas <TutorialHighlight:Registro Proibido> Fases. O Mystik também pode ser trocado na loja."
  },
  Tutorial_17831_Title_1 = {
    Text = "Registro Proibido"
  },
  Tutorial_17832_Desc_1 = {
    Text = "A cada turno, a cópia temporária da <TutorialHighlight:primeira> carta de comando jogada pela equipe ultra entra no <TutorialHighlight:Espaço Hiperdimensional> e ativa um poderoso efeito de salto. Quando o espaço hiperdimensional atinge o limite, ganhe 1 <TutorialHighlight:Turno Ultra> extra, <TutorialHighlight:O Turno Ultra pode ativar todos os efeitos de salto>. O segredo básico para jogar bem com a equipe ultra: planeje cuidadosamente a primeira carta jogada a cada turno."
  },
  Tutorial_17832_Title_1 = {Text = "Ultra"},
  Tutorial_17833_Desc_1 = {
    Text = "Quando a vida da nossa equipe se esgotar, é possível ativar <TutorialHighlight:Corpo de Gnosis de Emergência> para restaurar todos os estados. O Corpo de Gnosis de Emergência é restaurado automaticamente uma vez por dia, com um limite de <TutorialHighlight:5> usos. Aplique o Corpo de Gnosis de Emergência de forma razoável em <TutorialHighlight:combates difíceis>, e não o desperdice à toa."
  },
  Tutorial_17833_Title_1 = {
    Text = "Corpo de Gnosis de Emergência"
  },
  Tutorial_17834_Desc_1 = {
    Text = "Procure cuidadosamente os locais levemente iluminados no mapa e vá investigar, pode haver uma recompensa inesperada."
  },
  Tutorial_17834_Title_1 = {
    Text = "Ponto de extração"
  },
  Tutorial_17835_Desc_1 = {
    Text = "Representa o total de dano de todos os inimigos neste turno. Uma dica prática de combate para os Guardiões do Segredo: <TutorialHighlight: Tente igualar o escudo ao total de dano inimigo>"
  },
  Tutorial_17835_Title_1 = {
    Text = "Dano total do inimigo"
  },
  Tutorial_17837_Desc_1 = {
    Text = "Quando a <TutorialHighlight:Fusão de embriões> da equipe de Carne e sangue atingir seu limite, você receberá 1 <TutorialHighlight:\"embrião\">. Liberar a Fúria Explosiva consumirá o <TutorialHighlight:\"embrião\"> para acionar um poderoso efeito <TutorialHighlight:Devorar>. Portanto, é aconselhável Liberar a Fúria Explosiva quando houver <TutorialHighlight:\"embrião\"> na Mão; caso contrário, não será possível aproveitar ao máximo o potencial da equipe de Carne e sangue."
  },
  Tutorial_17837_Desc_2 = {
    Text = "Após cada batalha, acumula-se uma quantidade de recuperação de 5% da vida máxima no Forno Carmesim. Se houver <TutorialHighlight:\"embrião\"> não utilizado, cada embrião também acumulará 5% da vida máxima no forno. O Forno Carmesim pode ser usado para recuperar a vida da nossa equipe, podendo converter o forno em vida uma vez por turno. O Guardião deve planejar cuidadosamente o momento de uso do Forno Carmesim para alcançar um efeito de reviravolta na batalha."
  },
  Tutorial_17837_Title_1 = {
    Text = "Carne e sangue"
  },
  Tutorial_17838_Desc_1 = {
    Text = "No ponto de junção, você pode escolher restaurar 50% da vida perdida de nossa equipe ou designar 1 despertador para acordar. Quando a vida da nossa equipe estiver baixa, é recomendável escolher restaurar a vida, caso contrário, recomenda-se escolher acordar um despertador"
  },
  Tutorial_17838_Title_1 = {
    Text = "Ponto de contato"
  },
  Tutorial_17839_Desc_1 = {
    Text = "Local usado para consumir a Marca Negra para fortalecer nossa equipe, geralmente oferece 1 espaço para Gravura, 1 espaço para Criação de Prata e 1 espaço para Criação de Ouro. Se não houver itens necessários aqui, você pode clicar no canto superior direito em <TutorialHighlight:Atualizar>, a Marca de Fusão fornecerá novos itens."
  },
  Tutorial_17839_Title_1 = {
    Text = "Marca de Fusão"
  },
  Tutorial_17840_Desc_1 = {
    Text = "Forçar passagem pelo <TutorialHighlight:Ilusão> causará \"Sintomas\""
  },
  Tutorial_17840_Title_1 = {Text = "Ilusão"},
  Tutorial_17841_Desc_1 = {
    Text = "Através de cartas de comando, o despertador pode obter <TutorialHighlight:Aliemus>, quanto maior o nível da habilidade da carta de comando, mais aliemus é obtido"
  },
  Tutorial_17841_Title_1 = {Text = "Fúria"},
  Tutorial_17842_Desc_1 = {
    Text = "Derrotar inimigos e investigar eventos pode conceder <TutorialHighlight: O Sigilo Negro>, e a propriedade de <TutorialHighlight: Queda do Sigilo Negro> do despertador pode aumentar a quantidade de sigilos obtidos"
  },
  Tutorial_17842_Desc_2 = {
    Text = "Na marca d, você pode consumir <TutorialHighlight:o sigilo negro> para comprar selos e relíquias, e também pode ser usado para acordar despertadores. Antes da batalha final, tente gastar todos os sigilos negros para fortalecer nossa equipe"
  },
  Tutorial_17842_Title_1 = {
    Text = "Marca Negra"
  },
  Tutorial_17843_Desc_1 = {
    Text = "Ao ser atacado, causa dano equivalente ao número de camadas de <TutorialHighlight:balcão> ao atacante. O dano de <TutorialHighlight:balcão> <TutorialHighlight:não pode criticar>"
  },
  Tutorial_17843_Title_1 = {
    Text = "Contrataque"
  },
  Tutorial_17844_Desc_1 = {
    Text = "Para cada ponto de <TutorialHighlight:força>, aumenta 1 ponto de dano ao causar dano ativo"
  },
  Tutorial_17844_Title_1 = {Text = "Força"},
  Tutorial_17845_Desc_1 = {
    Text = "O despertador no despacho completou a missão de pesquisa, e após completar, poderá obter recompensas correspondentes. Quanto maior o <TutorialHighlight:Nível Total> do despertador, mais ricas as recompensas, até um máximo de 240 de nível total"
  },
  Tutorial_17845_Title_1 = {Text = "Envio"},
  Tutorial_17847_Desc_1 = {
    Text = "Ao sofrer dano fatal, há <TutorialHighlight: uma probabilidade equivalente à Resistência à Morte> de imunizar-se contra esse dano e preservar 1 ponto de vida, <TutorialHighlight: após ativar com sucesso, a Resistência à Morte é reduzida pela metade>. A Resistência à Morte da equipe é equivalente à soma da Resistência à Morte de todos os Corpos Despertos, aumentar a Resistência à Morte da equipe ajuda a melhorar a margem de erro durante a batalha."
  },
  Tutorial_17847_Title_1 = {
    Text = "Resistência à Morte"
  },
  Tutorial_17848_Desc_1 = {
    Text = "No início da batalha da equipe Mar Profundo, gera 1 <TutorialHighlight:tentáculo>. O <TutorialHighlight:tentáculo> ataca os inimigos da frente ao final do turno, e você pode entender o dano atual do tentáculo e o número de ataques através da fórmula abaixo do ícone do tentáculo. Alguns Corpos Despertos podem aumentar o Número de tentáculos e o Dano de tentáculo, causando grande quantidade de dano ao final do turno."
  },
  Tutorial_17848_Title_1 = {
    Text = "Mar Profundo"
  },
  Tutorial_17850_Desc_1 = {
    Text = "Jogar cartas da mão requer custo de aritmética, no final do turno, todas as cartas da mão irão para a <TutorialHighlight:pilha de descarte>. Planejar adequadamente a <TutorialHighlight:ordem de jogo> será a chave para a vitória na batalha"
  },
  Tutorial_17850_Title_1 = {Text = "Mão"},
  Tutorial_17851_Desc_1 = {
    Text = "Representar a ação que o inimigo tomará na próxima rodada, utilizando <TutorialHighlight:intenção> para decidir nesta rodada é o cerne do combate"
  },
  Tutorial_17851_Title_1 = {
    Text = "Intenção do inimigo"
  },
  Tutorial_17852_Desc_1 = {
    Text = "<TutorialHighlight:Habilidade de Corpo Desperto> pode melhorar os atributos do Corpo Desperto e aumentar os efeitos das cartas de comando. Clique em Próximo Nível na interface de habilidades do Corpo Desperto para visualizar os efeitos após o upgrade."
  },
  Tutorial_17852_Desc_2 = {
    Text = "Different awakened beings from various realms require different <TutorialHighlight:material para evolução de habilidade>."
  },
  Tutorial_17852_Title_1 = {
    Text = "Fortalecimento de habilidade"
  },
  Tutorial_20768_Desc_1 = {
    Text = "Quando o Corpo Desperto consome Poder de cálculo, pode obter <TutorialHighlight:Energia da Chave de Prata>. O atributo <TutorialHighlight:Recarregar Chave de Prata> aumenta a quantidade de <TutorialHighlight:Energia da Chave de Prata> obtida."
  },
  Tutorial_20768_Title_1 = {
    Text = "Energia da Chave de Prata"
  },
  Tutorial_20769_Desc_1 = {
    Text = "<TutorialHighlight: Porta Enferrujada> irá obstruir rotas de investigação importantes; tente procurar um objeto chamado <TutorialHighlight: Chave Enferrujada> no mapa, que pode ser utilizado para abrir a <TutorialHighlight: Porta Enferrujada>"
  },
  Tutorial_20769_Title_1 = {
    Text = "Porta enferrujada"
  },
  Tutorial_20770_Desc_1 = {
    Text = "<TutorialHighlight: Chave Enferrujada> pode abrir a <TutorialHighlight: Porta Enferrujada> que bloqueia seu progresso"
  },
  Tutorial_20770_Title_1 = {
    Text = "Chave enferrujada"
  },
  Tutorial_20771_Desc_1 = {
    Text = "<TutorialHighlight:Reino sem luz> contém uma série de fases com quatro domínios. Ao completar, você pode obter núcleos de prata, elixires de gnosis e outras recompensas. Ao acumular estrelas e atingir os requisitos especificados, você pode obter recompensas adicionais como núcleos de prata e núcleos imaculados!"
  },
  Tutorial_20771_Desc_2 = {
    Text = "As fissuras entre os diferentes reinos farão exigências sobre os despertadores da equipe de investigação, a equipe que <TutorialHighlight:satisfizer os requisitos> pode prosseguir com a investigação"
  },
  Tutorial_20771_Title_1 = {
    Text = "Reino sem luz"
  },
  Tutorial_20772_Desc_1 = {
    Text = "Quando a energia da chave de prata atingir <TutorialHighlight:1000>, você pode liberar a <TutorialHighlight:Ordem de chave> que possui. A cada turno, é possível liberar 2 ordens de chave, mas na segunda liberação, você deve escolher 1 entre 3 ordens de chave aleatórias, e a ordem selecionada não pode ser escolhida novamente nesta exploração. Ao formar a equipe, escolha as ordens de chave adequadas para o nosso grupo, o que pode tornar o processo de investigação mais suave."
  },
  Tutorial_20772_Title_1 = {
    Text = "Ordem de chave"
  },
  Tutorial_20773_Desc_1 = {
    Text = "Consumir a mesma <TutorialHighlight:Roda do destino> para Posição sobreposta pode aumentar os atributos e habilidades especiais da Roda do destino. Quando a sobreposição é de 1 a 3 vezes, o efeito da roda é aprimorado; de 4 a 15 vezes, os atributos da roda são aumentados. Você pode clicar no botão \"Próxima Fase\" na interface de sobreposição para visualizar as mudanças após a sobreposição."
  },
  Tutorial_20773_Title_1 = {
    Text = "Roda do destino"
  },
  Tutorial_22247_Desc_1 = {
    Text = "<TutorialHighlight:Melhoria de Mystik> pode aumentar a força dos atributos do Mystik, até o nível 12. A decomposição do Mystik pode resultar em um remanente correspondente, e a substituição de materiais nos recursos pode resultar em <TutorialHighlight:Selo de mil faces>. A melhoria do Mystik requer o consumo de <TutorialHighlight:Selo de mil faces>, e decompor um Mystik já melhorado também retornará o <TutorialHighlight:Selo de mil faces> consumido na melhoria."
  },
  Tutorial_22247_Title_1 = {
    Text = "Atualização do pacto"
  },
  Tutorial_22248_Desc_1 = {
    Text = "Através da transcrição, é possível fazer com que o <TutorialHighlight:Mystik> obtenha atributos de tipos e intensidades aleatórias, os atributos secundários não estão relacionados às partes, podendo aparecer 8 tipos: Taxa de Crítico, Dano Crítico, Nível de Recarga de Fúria, Nível de Carga da Chave de Prata, Domínio de área, Queda de marca negra, Dano potencializado e Resistência à Morte. Durante a transcrição, se desejar preservar um atributo, pode-se escolher <TutorialHighlight:Preservar>, os atributos preservados não sofrerão alterações durante a transcrição."
  },
  Tutorial_22248_Title_1 = {
    Text = "Transcrição do pacto"
  },
  Tutorial_23466_Desc_1 = {
    Text = "Com o aumento do nível do Guardião do Segredo, <TutorialHighlight: a força das Criações e Gravuras> também aumentará, e o <TutorialHighlight: impacto de cada ponto de Constituição do Corpo Desperto na vida da equipe> aumentará. É possível obter uma grande quantidade de Experiência do Guardião de Segredos através de Operações de investigação e interlúdios. Cada consumo de 1 ponto de energia resulta em 1 ponto de Experiência do Guardião de Segredos."
  },
  Tutorial_23466_Title_1 = {
    Text = "Nível do Guardião"
  },
  Tutorial_47538_Desc_1 = {
    Text = "A Zona de Desastre de Fusão é um sistema de jogo de alta dificuldade. Os Guardiões precisam montar equipes de desafio flexíveis para obter o máximo de pontos de treinamento e recompensas. Em alta dificuldade, os inimigos são mais fortes e há vários efeitos negativos"
  },
  Tutorial_47538_Desc_2 = {
    Text = "Na Zona Proibida de Catástrofe de Fusão, existem regras de restrição únicas: o mesmo Corpo Desperto e Ordem de chave, assim como Rodas do destino com o mesmo nome, não podem entrar em batalha novamente. O Guardião pode escolher a equipe para este desafio de forma flexível, com base nas Criações iniciais, monstros e níveis recomendados, adotando a estratégia de corrida de cavalos de Tian Ji para obter o máximo de Pontos de Treinamento possível. Os Corpos Despertos que entram em batalha através do método <TutorialHighlight:ajuda> não são afetados por essa restrição."
  },
  Tutorial_47538_Title_1 = {
    Text = "Zona Proibida de Catástrofe de Fusão"
  },
  Tutorial_54390_Desc_1 = {
    Text = "No modo <TutorialHighlight:traphase>, o estado da vitalidade e do aliemus de cada despertador aparecerá abaixo da vida e do aliemus de ambos os lados na interface de combate, clicando pode-se ver os efeitos específicos"
  },
  Tutorial_54390_Desc_2 = {
    Text = "Os seguintes pertencem a <TutorialHighlight:Estados positivos> (clique para ver detalhes): <TauntKeywords:Provocação>, <PVPPowerIconKeywords:Força>, <EnergyStorageKeywords:Carregar>, <PVPProtectiveKeywords:Barreira>, <PVPRetaliateIconKeywords:Contrataque>, <ReinforceKeywords:Reforço>, <StrengthenKeywords:Reforço>."
  },
  Tutorial_54390_Desc_3 = {
    Text = "Pertence ao<TutorialHighlight:estado negativo> o seguinte (clique para ver detalhes):<PVPEntanglementKeywords:enrolar>,<PVPVulnerabilityIconKeywords:vulnerável>,<PVPSlowKeywords:desaceleração>,<ComaKeywords:petrificação>,<DisarmKeywords:paralisia>,<PVPMethysisKeywords:envenenamento>,<PVPEmptinessKeywords:vazio>,<PVPBleedingKeywords:sangramento>,<PVPSeriousInjuryKeywords:lesão grave>,<ComaKeywords:desmaio>."
  },
  Tutorial_54390_Title_1 = {Text = "Estado"},
  Tutorial_54391_Desc_1 = {
    Text = "No modo <TutorialHighlight:Fase de Duelo>, algumas cartas dos corpos despertos terão diferentes efeitos de <TutorialHighlight:afixo>, que podem ser visualizados no sistema <TutorialHighlight:Coleção> ou pressionando longamente as cartas durante a batalha. Os afixos incluem (clique para ver detalhes): <PVPPenetrateKeywords:Penetração>, <PrepareKeywords:Pronto>, <PVPResurrectionKeywords:ressurreição>, <PVPHoldingKeywords:Manter>, <PhantomKeywords:Ilusão>, <PVPRaidKeywords:Assalto>."
  },
  Tutorial_54391_Title_1 = {Text = "Afixo"},
  Tutorial_54392_Desc_1 = {
    Text = "No modo <TutorialHighlight:Fase de Duelo>, os pontos de emparelhamento serão redefinidos ao final de cada temporada e ao início de uma nova. As informações sobre o nome da temporada e a duração podem ser visualizadas no lado direito da interface. Quando os pontos são redefinidos, os jogadores que ultrapassaram 1000 pontos na temporada anterior terão a parte excedente reduzida pela metade."
  },
  Tutorial_54392_Desc_2 = {
    Text = "Durante cada temporada, haverá <TutorialHighlight:Missões de Temporada>. Complete as Missões de Temporada para reivindicar recompensas valiosas. As Missões de Temporada serão redefinidas quando a temporada for atualizada."
  },
  Tutorial_54392_Title_1 = {Text = "Temporada"},
  Tutorial_54393_Desc_1 = {
    Text = "No modo <TutorialHighlight:traphase>, quando um corpo desperto morre, as cartas pertencentes a esse corpo na mão se tornam <TutorialHighlight:Ilusão>. Equipar <TutorialHighlight:Roda do Destino> a um corpo desperto já falecido também concede 1 Ilusão, ao mesmo tempo que devolve o poder de cálculo consumido. Ilusões também podem ser fundidas em <TutorialHighlight:Pequeno Desejo> através do efeito de certas rodas do destino."
  },
  Tutorial_54393_Title_1 = {Text = "Ilusão"},
  Tutorial_54394_Desc_1 = {
    Text = "No modo <TutorialHighlight:Fase de Duelo>, no primeiro turno ambos os lados têm 3 pontos de <TutorialHighlight:poder de cálculo> e limite, o segundo jogador receberá uma carta <TutorialHighlight:Contra-ataque> como compensação. Depois, no início de cada turno, o limite de poder de cálculo e a quantidade de recuperação aumentarão em 1 ponto até um máximo de 10 pontos. Além do aumento automático, também existem outros meios de aumentar ou diminuir o limite de poder de cálculo; quando o limite de poder de cálculo atinge 10, qualquer excesso de 1 ponto será convertido em comprar 1 carta."
  },
  Tutorial_54394_Title_1 = {
    Text = "Poder de cálculo"
  },
  Tutorial_54395_Desc_1 = {
    Text = "No modo <TutorialHighlight:Fase de Duelo>, cada Corpo Desperto também possui <TutorialHighlight:Fúria> e <TutorialHighlight:Fúria Explosiva>. É possível obter Fúria usando cartas de <TutorialHighlight:golpear> ou cartas de <TutorialHighlight:habilidade> específicas, e também ganhar Fúria ao perder Vida ao receber Dano (ganha-se 1 ponto de Fúria a cada 2% de Vida perdida ou quantidade equivalente de Escudo). Quando a Fúria atinge 100, clique no Corpo Desperto correspondente para escolher liberar a Fúria Explosiva."
  },
  Tutorial_54395_Title_1 = {Text = "Fúria"},
  Tutorial_54396_Desc_1 = {
    Text = "No modo <TutorialHighlight:Traphase>, completar os objetivos especificados nos \"Registros de Partida\" durante o emparelhamento permitirá que você reivindique recompensas correspondentes. Esta recompensa é uma recompensa única que não é redefinida com a temporada e pode ser visualizada através dos \"Registros de Partida\" no canto inferior esquerdo da interface."
  },
  Tutorial_54396_Title_1 = {
    Text = "Recorde de Xadrez"
  },
  Tutorial_54397_Desc_1 = {
    Text = "No modo <TutorialHighlight:traphase>, na guia \"Coleção\" à esquerda da interface, é possível visualizar todas as informações de despertadores, roda do destino e chaves"
  },
  Tutorial_54397_Title_1 = {Text = "Coleção"},
  Tutorial_54398_Desc_1 = {
    Text = "No modo <TutorialHighlight:traphase>, cada despertador possui 2 cartas <TutorialHighlight:golpe> e 3 cartas <TutorialHighlight:habilidade>. Geralmente, diferentes cartas de habilidade consomem diferentes quantidades de aritmética"
  },
  Tutorial_54398_Title_1 = {Text = "Habilidade"},
  Tutorial_54399_Desc_1 = {
    Text = "No modo <TutorialHighlight:Fase de Duelo>, o número de cartas compradas automaticamente por turno também é 5, e o <TutorialHighlight:limite de cartas na mão> padrão também é 10. É possível ver o número atual de cartas na nossa mão e o limite na parte inferior direita da interface de batalha, enquanto na parte superior direita, é possível ver a situação do oponente. É possível alterar o número de cartas compradas por turno e o limite de cartas na mão de outras maneiras."
  },
  Tutorial_54399_Title_1 = {Text = "Mão"},
  Tutorial_54400_Desc_1 = {
    Text = "No modo <TutorialHighlight:Fase de Duelo>, diferentes Corpos Despertos têm diferentes <TutorialHighlight:posicionamentos>, totalizando 5. Eles são, especificamente, <TutorialHighlight:Guardião>, <TutorialHighlight:luta>, <TutorialHighlight:Luminis>, <TutorialHighlight:Estrela Infausta> e <TutorialHighlight:Bênção>. Ao realizar a <TutorialHighlight:Formação>, é necessário selecionar 4 Corpos Despertos de diferentes posicionamentos para formar a equipe."
  },
  Tutorial_54400_Title_1 = {Text = "Posição"},
  Tutorial_54401_Desc_1 = {
    Text = "No modo <TutorialHighlight:Traphase-All Pick>, clicando em \"Começar a correspondência\" no canto inferior direito da interface, você será direcionado para a interface de Formação. Você também pode pré-construir sua equipe na <TutorialHighlight:All Pick Lineup> no lado esquerdo da interface."
  },
  Tutorial_54401_Desc_2 = {
    Text = "Formação permite salvar vários conjuntos de suporte, e no canto superior esquerdo você pode editar o nome da equipe, cada equipe consiste em 4 despertadores, 4 rodadas do destino e 2 chaves de bando"
  },
  Tutorial_54401_Title_1 = {
    Text = "Pré-grupo lineup"
  },
  Tutorial_54705_Desc_1 = {
    Text = "No modo <TutorialHighlight:traphase>, clique na sua <TutorialHighlight:imagem de perfil>, escolha a <TutorialHighlight:expressão de combate> que deseja enviar e expresse seus sentimentos ao seu oponente!"
  },
  Tutorial_54705_Title_1 = {Text = "Expressão"},
  Tutorial_54706_Desc_1 = {
    Text = "<TutorialHighlight: Traphase> é um jogo de dois jogadores, onde cada um utiliza suas próprias equipes pré-montadas para <TutorialHighlight: Combate de Emparelhamento>, combinando-se com oponentes de força equivalente"
  },
  Tutorial_54706_Desc_2 = {
    Text = "Ganhe <TutorialHighlight:EXP de Todas as Seleções> e <TutorialHighlight:EXP de Seleções de Draft> através de batalhas. Com base na experiência adquirida, você pode desbloquear <TutorialHighlight:recompensas únicas> em <TutorialHighlight:Nível de Todas as Seleções> e <TutorialHighlight:Nível de Seleções de Draft>!"
  },
  Tutorial_54706_Desc_3 = {
    Text = "A cada semana, com base na classificação de pontos, você receberá um <TutorialHighlight:Título> e obterá <TutorialHighlight:Cupom de ouro rosa> no dia seguinte.\n Se você participou tanto da \"Fase de Duelo\" quanto do \"Mergulho Fantasmal\", a contabilização do Cupom de ouro rosa será feita com base na recompensa <TutorialHighlight:maior> entre esses dois modos de jogo."
  },
  Tutorial_54706_Title_1 = {
    Text = "Introdução ao Duelo"
  },
  Tutorial_74798_Desc_1 = {
    Text = "Diferentes fases possuem diferentes ambientes de <TutorialHighlight:capítulos de fase>, que alteram significativamente as regras gerais e os efeitos das criações. Para mais detalhes, clique nas respectivas abas nas interfaces de cada fase."
  },
  Tutorial_74798_Title_1 = {
    Text = "Capítulo da fase"
  },
  Tutorial_81370_Desc_1 = {
    Text = "<TutorialHighlight:Despertar Corporal Regressivo> pode devolver vários custos de desenvolvimento do seu Corpo Despertado."
  },
  Tutorial_81370_Desc_2 = {
    Text = "<TutorialHighlight:Rastreamento de criação> irá redefinir o nível, ascenso, habilidades e estado de aprofundamento da alma desperta, e todos os materiais e cupons de ouro consumidos serão totalmente devolvidos."
  },
  Tutorial_81370_Desc_3 = {
    Text = "<TutorialHighlight:Recuperação de Inspiração> irá redefinir o estado de Inspiração do corpo desperto e redefinir o limite máximo de nível obtido através da Inspiração, e todos os materiais consumidos serão devolvidos."
  },
  Tutorial_81370_Desc_4 = {
    Text = "<TutorialHighlight:Devolver a Piscina Negra> incluirá o efeito de \"Regresso ao Desenvolvimento\" e também redefinirá o despertador em si, voltando ao estado de não desbloqueado."
  },
  Tutorial_81370_Title_1 = {
    Text = "Rastreamento do Despertado"
  },
  Tutorial_81371_Desc_1 = {
    Text = "<TutorialHighlight:Aprimoramento do Corpo Despertado> é uma das formas mais rápidas de aumentar os atributos do Corpo Despertado. Gastar <TutorialHighlight:Agente de Conhecimento> pode aumentar o nível do Corpo Despertado."
  },
  Tutorial_81371_Desc_2 = {
    Text = "Após atingir o nível máximo, o limite de nível do Corpo Despertado precisa ser aumentado por meio de <TutorialHighlight:Ascenso>. Diferentes Corpos Despertados de domínios distintos exigem diferentes <TutorialHighlight:Materiais de Ascenso>."
  },
  Tutorial_81371_Title_1 = {
    Text = "Upgrade do desperto"
  },
  Tutorial_81372_Desc_1 = {
    Text = "<TutorialHighlight:Ativação do Despertar Espiritual> pode aumentar drasticamente o efeito das cartas de comando do Corpo Desperto. O nível de Inspiração 7 desbloqueia <TutorialHighlight:Explosão Superalimentada>, concedendo efeitos adicionais ao Corpo Desperto durante a Fúria Explosiva. Os níveis de Inspiração 11 e 15 podem aumentar o limite máximo de nível do Corpo Desperto em 5 níveis"
  },
  Tutorial_81372_Title_1 = {
    Text = "Iluminação ativada"
  }
})
return Text_Tutorial
