__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_State = readonly({
  State_100291_Desc = {
    Text = "A loucura causada por todos os despertos aumenta em 50%."
  },
  State_100291_Name = {Text = "desabafo"},
  State_100292_Name = {
    Text = "Início da Rodada"
  },
  State_100293_Desc = {
    Text = "A loucura causada por todos os despertos é reduzida em 50%. No final do turno, ganhe 1 camada de \"<DarkEgo:lado sombrio do eu>\": no início do turno, todos os despertos ganham 3 de loucura."
  },
  State_100293_Name = {
    Text = "Sombra da personalidade"
  },
  State_100295_Name = {
    Text = "Monitoramento de dano"
  },
  State_100296_Desc = {
    Text = "Para cada camada, no início do turno, todos os despertos ganham <Energy:3> de loucura."
  },
  State_100296_Name = {
    Text = "Lado Sombrio do Eu"
  },
  State_100297_Desc = {
    Text = "Ao final do turno, ganhe um escudo equivalente a 20% da saúde máxima."
  },
  State_100297_Name = {
    Text = "Barreira Mental"
  },
  State_100298_Desc = {
    Text = "Perda de 10% da vida atual após o início do turno, ganhe [DescArg1] de força."
  },
  State_100298_Name = {
    Text = "Destruição da Barreira"
  },
  State_100299_Desc = {
    Text = "Exaltar Contador"
  },
  State_100299_Name = {
    Text = "Exaltar Contador"
  },
  State_100302_Name = {
    Text = "Exaltar escuta"
  },
  State_100307_Desc = {
    Text = "Equipe única: Após o portador liberar a explosão de loucura, ganha 1 camada de \"Co-criação\". Na próxima explosão de loucura de outros despertos neste turno, poderá consumir \"Co-criação\", aumentando a taxa crítica dessa explosão em <WeaponEffect_Num:[StateArg1]%> e fazendo com que o despertador que consumir \"Co-criação\" ganhe uma quantidade de loucura equivalente a <WeaponEffect_Num:[StateArg1]%> da recarga de aliemus do portador."
  },
  State_100307_WeaponDesc = {
    Text = "Após o portador liberar a explosão de loucura, ganha 1 camada de \"Co-criação\". Na próxima explosão de loucura de outros despertos neste turno, poderá consumir \"Co-criação\", aumentando a taxa crítica dessa explosão em <WeaponEffect_Num:[StateArg1]%> e fazendo com que o despertador que consumir \"Co-criação\" ganhe <WeaponEffect_Num:[DescArg1]> pontos de loucura."
  },
  State_100326_Desc = {
    Text = "Para cada camada, no início do turno, todos os despertos ganham <Energy:3> de loucura."
  },
  State_100326_Name = {
    Text = "<DarkEgo:Lado Sombrio do Eu>"
  },
  State_100327_Desc = {
    Text = "Ao final do turno, ganhe um escudo equivalente a 20% da saúde máxima."
  },
  State_100327_Name = {
    Text = "<MindWall:Barreira Mental>"
  },
  State_100328_Desc = {
    Text = "A loucura causada por todos os despertos aumenta em 50%."
  },
  State_100328_Name = {
    Text = "<TrueConfess:confissão>"
  },
  State_100329_Desc = {
    Text = "A loucura causada por todos os despertos é reduzida em 50%. No final do turno, ganhe 1 camada de \"<DarkEgo:lado obscuro do eu>\": no início do turno, todos os despertos ganham 3 de loucura."
  },
  State_100329_Name = {
    Text = "<ShadowSelf:sombra da personalidade>"
  },
  State_100330_Desc = {
    Text = "Perda de 10% da vida atual após o início do turno, ganhe [DescArg1] pontos de <PowerIconKeywords:força>."
  },
  State_100330_Name = {
    Text = "<BarrierCrash:Destruição da Barreira>"
  },
  State_100395_Name = {
    Text = "Sangue de Graça Criado+"
  },
  State_100396_Name = {
    Text = "Sangue de Graça Criado"
  },
  State_100527_Desc = {
    Text = "Quando Pikman ativa o efeito \"descobrir\", adicione a opção \"Explosão de Inspiração!\": consuma 1 camada de \"devaneio\", escolha todos os efeitos e ganhe 1 camada de \"criatividade\"."
  },
  State_100527_Name = {Text = "Devaneio"},
  State_100541_Desc = {
    Text = "Se atualmente você tiver 10 camadas de \"criatividade\", após Pikman liberar a explosão de loucura e consumir toda a \"criatividade\", ganhe 1 camada de devaneio e faça com que todos os Despertados ganhem 15 pontos de loucura. O limite de criatividade é de 10 camadas, podendo ser herdado para a próxima batalha."
  },
  State_100541_Name = {
    Text = "<Chuangyi:Criatividade>"
  },
  State_100542_Desc = {
    Text = "Quando Pikman ativa o efeito \"descobrir\", adicione a opção \"Explosão de Inspiração!\": consuma 1 camada de \"devaneio\", escolha todos os efeitos \"descobrir\" e ganhe 1 camada de \"criatividade\"."
  },
  State_100542_Name = {
    Text = "<Kuangxiang:Devaneio>"
  },
  State_100544_Name = {Text = "Slime Doce"},
  State_100544_WeaponDesc = {
    Text = "O escudo e a recuperação de vida do portador aumentam em 6%. Se a maestria do domínio do portador for maior que 50, o escudo e a recuperação de vida aumentam em mais 6%"
  },
  State_100545_Name = {Text = "Slime Doce"},
  State_100545_WeaponDesc = {
    Text = "O escudo e a recuperação de vida do portador aumentam em 6%. Se a maestria do domínio do portador for maior que 50, o escudo e a recuperação de vida aumentam em mais 6%"
  },
  State_100558_Desc = {
    Text = "Na próxima explosão de loucura de outros despertos neste turno, a taxa crítica aumenta em [StateArg1]%, e ao usar, ganhe [DescArg1] pontos de loucura."
  },
  State_100558_Name = {
    Text = "cocriação"
  },
  State_100559_Desc = {
    Text = "Inclui as seguintes \"Criações do Capítulo Estelar\": Menino Malvado, Festival da Primavera, Cadeado Pesado, Ágata Enrolada, Sangue do Dom, Serra de Aço Enferrujada, Sonho Dourado, Seixo Ensanguentado."
  },
  State_100559_Name = {
    Text = "<Chuanggouzaowu:Criação de construção>"
  },
  State_100562_Desc = {
    Text = "Nesta rodada, o custo de poder das próximas [Layer] cartas de comando jogadas diminui em 2."
  },
  State_100562_Name = {
    Text = "Realidade, também é ilusão"
  },
  State_100564_Desc = {
    Text = "Inclui os seguintes \"selos\": aritmética, habilidade, loucura, catalisador, força bruta, muralha de ferro, exaustão, inspiração."
  },
  State_100564_Name = {
    Text = "<Chuanggoukeyin:Marca de criação>"
  },
  State_100566_WeaponDesc = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_100617_Desc = {
    Text = "No final do turno, ganhe 1 limite de tentáculos."
  },
  State_100617_Name = {
    Text = "Obsessão abissal"
  },
  State_100619_Desc = {
    Text = "Quando a força é reduzida, apenas 50% das camadas de força são diminuídas"
  },
  State_100619_Name = {
    Text = "Resistência ao Esgotamento"
  },
  State_100621_Desc = {
    Text = "Cada camada reduz em 25% o dano base causado pelo jogador, podendo guiar a direção da navegação posteriormente."
  },
  State_100621_Name = {
    Text = "Luz de vela fraca"
  },
  State_100623_Desc = {
    Text = "Cada camada reduz em 50% o dano base causado pelo jogador, após causar dano ativo ou de tentáculo, reduz [DescArg1] veneno em si mesmo."
  },
  State_100623_Name = {
    Text = "Luz Errante"
  },
  State_100639_Desc = {
    Text = "Dano de tentáculo causado temporariamente reduzido em 50%."
  },
  State_100639_Name = {
    Text = "A Cidade Perdida de Tempos Antigos"
  },
  State_100644_Desc = {
    Text = "Redução permanente da força do alvo, ganhando uma quantidade igual de força."
  },
  State_100644_Name = {
    Text = "<TouquKeywords: roubo permanente>"
  },
  State_100647_Desc = {
    Text = "Imune a todo dano."
  },
  State_100647_Name = {
    Text = "Imune a todo dano."
  },
  State_100694_Desc = {
    Text = "Cada camada reduz em 30% o dano básico causado pelo jogador, após causar dano ativo ou dano de tentáculo, reduz o envenenamento em si mesmo."
  },
  State_100694_Name = {
    Text = "Luz Errante"
  },
  State_116342_Desc = {
    Text = "Disparar uma carta <ErosionColorInkKeywords:Distorção de Percepção> faz com que \"O Artista\" ganhe 1 camada de <DecayDye:Tinta do Mundo Ilusório>."
  },
  State_116342_Name = {
    Text = "Paleta de Anomalias"
  },
  State_116406_Name = {Text = "Avançado"},
  State_116407_Name = {
    Text = "Estado vazio"
  },
  State_116858_Desc = {
    Text = "Este estado usa o multiplicador vulnerável, fazendo parecer uma zona de multiplicador independente.__\"Apenas para desenvolvimento\""
  },
  State_116858_Name = {
    Text = "Se possuir um determinado estado, o dano é dobrado"
  },
  State_116859_Desc = {
    Text = "No início do próximo turno, ganhe vulnerabilidade."
  },
  State_116859_Name = {
    Text = "Vulnerabilidade de latência"
  },
  State_116958_Desc = {
    Text = "Após jogar a carta, sofre dano correspondente ao número de camadas."
  },
  State_116958_Name = {
    Text = "<PVPCardLockColour:Bloqueio de ação>"
  },
  State_117154_Desc = {
    Text = "Este efeito só pode ser ativado uma vez em todos os Corpos Despertos da equipe e não pode ser acionado novamente."
  },
  State_117154_Name = {
    Text = "<TeamUnique: Equipe Única>"
  },
  State_117212_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Antes de usar uma «Habilidade» e no fim do turno, aplica <Damage:[Damage:StateArg1]> camadas de <PVPCorrosionKeywords:marca do pecado> ao inimigo com <HPAndShieldMax:maior vida e escudo>."
  },
  State_117212_Name = {Text = "Pólux"},
  State_117213_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>:\"Habilidade\" e ao final da rodada, causa [StateArg1] <PVPfengsuoKeywords:Bloqueio de surto> ao inimigo com mais Fúria."
  },
  State_117213_Name = {
    Text = "Imagem do Filho Santo"
  },
  State_117346_Desc = {
    Text = "Dano causado por Pollux adiciona [Layer]% de sangramento."
  },
  State_117346_Name = {
    Text = "Marca do Crime"
  },
  State_117355_Desc = {
    Text = "A próxima carta de comando disparada por Pollux tem efeito 2 vezes."
  },
  State_117355_Name = {
    Text = "Nova Aliança Divina"
  },
  State_117357_Desc = {
    Text = "Equipe Única: Após atualizar \"Marca de Fusão\" e \"Ruínas Cinzentas\", o portador ganha <WeaponEffect_Num:[StateArg1]> pontos de Fúria."
  },
  State_117357_WeaponDesc = {
    Text = "\"Marca de Fusão\" e \"Ruínas Cinzentas\" atualizadas fazem com que o portador ganhe <WeaponEffect_Num:[StateArg1]> pontos de Fúria."
  },
  State_117358_Desc = {
    Text = "Cada camada concede 1% de sangramento adicional ao dano causado por Pollux."
  },
  State_117358_Name = {
    Text = "<ZuiyinKeywords:Marca do Crime>"
  },
  State_117744_Desc = {
    Text = "<MaxHPKeywords:Vida máxima> -[Layer]. Ao ser ativado, sofre [Layer] de Dano Passivo. Persistente. Ao ser dissipado, a Vida máxima do alvo não se regenera."
  },
  State_117744_Name = {
    Text = "Marca do Crime"
  },
  State_117745_Desc = {
    Text = "Cada capa reduz a <MaxHPKeywords:Vida máxima> do alvo. Quando a Marca do Crime é ativada, o alvo sofre Dano Passivo igual ao número de capas. Ao ser dissipado, a Vida máxima do alvo não se regenera."
  },
  State_117745_Name = {
    Text = "<PVPCorrosionKeywords:Marca do Crime>"
  },
  State_117755_Desc = {
    Text = "Antes do fim do turno, não é possível realizar nenhuma ação"
  },
  State_117755_Name = {Text = "Desmaio"},
  State_117756_Desc = {
    Text = "Antes do fim do turno, não é possível realizar nenhuma ação"
  },
  State_117756_Name = {Text = "Desmaio"},
  State_117776_Desc = {
    Text = "Neste turno, o dano final e o escudo de [Layer] cartas de comando aumentam em [StateArg1]%."
  },
  State_117776_Name = {
    Text = "Chama Divina"
  },
  State_117777_Desc = {
    Text = "Equipe Única: O dano básico e o dano crítico causados pelas cartas do portador aumentam em <WeaponEffect_Num:[StateArg1]%. No início do turno e após o portador liberar a Fúria Explosiva, ganha 1 camada de Fogo do Coração; ao disparar uma carta de comando neste turno, o portador consome 1 camada de \"Fogo do Coração\", aumentando seu Dano Final e Escudo em <WeaponEffect_Num:[StateArg2]%. Durante o Turno Ultra, passa a ganhar \"Chama Divina\", e o efeito é duplicado."
  },
  State_117777_WeaponDesc = {
    Text = "O dano básico e o dano crítico das cartas do portador aumentam em <WeaponEffect_Num:[StateArg1] %>. No início do turno e após o portador liberar a Fúria Explosiva, ganha 1 camada de Fogo do Coração. Quando o portador dispara uma carta de comando neste turno, consome 1 camada de \"Fogo do Coração\", aumentando seu Dano Final e Escudo em <WeaponEffect_Num:[StateArg2] %>. No Turno Ultra, passa a ganhar \"Chama Divina\", com efeito em dobro."
  },
  State_117778_Desc = {
    Text = "Neste turno, o dano final e o escudo de [Layer] cartas de comando aumentam em [StateArg1]%."
  },
  State_117778_Name = {
    Text = "Fogo do Coração"
  },
  State_117779_Desc = {
    Text = "Equipe Única: No Turno Ultra, o portador ganha 3 camadas de \"Fogo do Coração\". Ao disparar cartas de comando neste turno, o portador consome 1 camada, aumentando seu Dano Final e Escudo em <WeaponEffect_Num:[StateArg1]%."
  },
  State_117779_WeaponDesc = {
    Text = "No Turno Ultra, o portador ganha 3 camadas de \"Fogo do Coração\". Ao disparar cartas de comando neste turno, o portador consome 1 camada, aumentando seu dano final e escudo em <WeaponEffect_Num:[StateArg1] %>."
  },
  State_117851_Desc = {
    Text = "Pollux desfruta de 50% de efeito adicional de \"Redenção da dor\" em cada Carta de comando, durando [Layer] turnos."
  },
  State_117851_Name = {
    Text = "A luz que ilumina a noite branca"
  },
  State_117853_Desc = {
    Text = "Pollux aumenta o dano das próximas [Layer] cartas de comando jogadas neste turno em [DescArg1], melhora o escudo em [DescArg2] e ganha 10 pontos de fúria."
  },
  State_117853_Name = {
    Text = "Redenção da dor"
  },
  State_117869_Desc = {
    Text = "A cada vez que liberar uma explosão de fúria, aumente 1 camada de \"chamar\", e a cada camada de \"chamar\" receba [DescArg1] pontos de força, com um limite de 5 camadas."
  },
  State_117869_Name = {
    Text = "Sacerdotisa marinheira"
  },
  State_117870_Desc = {
    Text = "Após a morte, o assassino restaura 20% do hp perdido."
  },
  State_117870_Name = {
    Text = "sashimi delicioso"
  },
  State_117875_Desc = {
    Text = "Se houver lugares vagos na fila de trás, após a ação, perca 1 camada e convoque 1 \"Sushi Delicioso\" \"Fritar.\""
  },
  State_117875_Name = {
    Text = "Contrato: enxame"
  },
  State_117876_Desc = {
    Text = "Os efeitos de <WeaknessIconKeywords:fraqueza>, <FragileIconKeywords:frágil> e <HeavyInjuryKeywords:perdição> aumentam para 50%."
  },
  State_117876_Name = {
    Text = "Fraqueza&Frágil&Agravamento de Ferimentos"
  },
  State_117880_Desc = {
    Text = "Na batalha, o \"Salto das Cardumes\" será ativado mais 1 vez."
  },
  State_117880_Name = {
    Text = "Ativação extra do cardume saltando"
  },
  State_117883_Desc = {
    Text = "Após atingir 5 camadas, sela imediatamente todos os Corpos Despertos e troca a intenção para: \"Glória de Lemúria!+\"."
  },
  State_117883_Name = {Text = "Chamar"},
  State_117885_Desc = {
    Text = "Quando afetado pelo efeito de redução de força, também causará uma redução de força equivalente ao lançador."
  },
  State_117885_Name = {
    Text = "Dente por dente"
  },
  State_117889_Desc = {
    Text = "Ao entrar, seu hp máximo aumenta em 10% e concede a outros aliados um acionamento extra de [DescArg1] <PowerIconKeywords:strength> para o <FishLeapWords:Power of Cohort> nesta batalha."
  },
  State_117889_Name = {
    Text = "Poder do enxame"
  },
  State_118112_Desc = {
    Text = "O dano único recebido tem um limite de [DescArg1] pontos, removido quando a vida está abaixo de 50%."
  },
  State_118112_Name = {
    Text = "Limite de Dor I"
  },
  State_118113_Desc = {
    Text = "Após sofrer dano ativo e perder vida, ganha um escudo equivalente a 15% da vida perdida e <AlertIconKeywords:precaução temporária> de 5% da vida perdida."
  },
  State_118113_Name = {
    Text = "Características do corpo macio I"
  },
  State_118114_Desc = {
    Text = "Após sofrer dano ativo e perder vida, ganha um escudo equivalente a 35% da vida perdida e <AlertIconKeywords:precaução temporária> de 10% da vida perdida."
  },
  State_118114_Name = {
    Text = "Características do corpo macio III"
  },
  State_118115_Desc = {
    Text = "Se houver lugares vagos na fila da frente, após a ação, perca 1 camada e convoque 1 \"Divisão do Oceano Profundo.\""
  },
  State_118115_Name = {
    Text = "Contrato de Cooperação: Excrescência Abissal"
  },
  State_118116_Desc = {
    Text = "O limite de dano único recebido é de [DescArg1] pontos, removido quando a vida estiver abaixo de 50%."
  },
  State_118116_Name = {
    Text = "Limite de Dor II"
  },
  State_118117_Desc = {
    Text = "O limite de dano único recebido é de [DescArg1] pontos, removido quando a vida estiver abaixo de 50%."
  },
  State_118117_Name = {
    Text = "Limite de Dor III"
  },
  State_118118_Desc = {
    Text = "Ganhe 1 tentáculo com <TentacleInjurieIconKeywords:Dano de tentáculo> igual a [TentaclePower:DescArg1] e limite de 5 tentáculos. No final do turno, ganhe 1 tentáculo. Efeitos de redução de Força –50%."
  },
  State_118118_Name = {
    Text = "Reunião de tentáculos"
  },
  State_118119_Desc = {
    Text = "Após sofrer dano ativo e perder vida, ganha um escudo equivalente a 25% da vida perdida e <AlertIconKeywords:precaução temporária> de 5% da vida perdida."
  },
  State_118119_Name = {
    Text = "Características do corpo macio II"
  },
  State_118319_Desc = {
    Text = "O limite de dano único recebido é de [DescArg1] pontos, removido quando a vida estiver abaixo de 50%."
  },
  State_118319_Name = {
    Text = "Limite de Dano do Escudo do Abismo"
  },
  State_118320_Name = {
    Text = "Contagem Temporária de Contramedida de Esgotamento"
  },
  State_118321_Name = {
    Text = "Contagem de Contramedida de Esgotamento"
  },
  State_118322_Name = {
    Text = "Marcador de Invocação Preparado"
  },
  State_118323_Desc = {
    Text = "Cardume saltando ativado"
  },
  State_118323_Name = {
    Text = "Marca de entrada do cardume saltando"
  },
  State_118324_Desc = {
    Text = "Cada vez que dano é causado, uma tentáculo temporário é gerado."
  },
  State_118324_Name = {
    Text = "Graça Divina"
  },
  State_118325_Desc = {
    Text = "Ao causar dano não bloqueado, embaralhe [DescArg1] cartas de asfixia no topo do mazo de robo"
  },
  State_118325_Name = {
    Text = "Chefe da Cobra do Novo Mundo Tremor"
  },
  State_118656_Desc = {
    Text = "Ao jogar a carta, receba [StateArg1] pontos de dano e remova 1 camada. Quando as camadas forem 0, incube um \"ser do mar\" mais fraco. Se o estado de parasita ainda existir no final do turno, incube um \"ser do mar\" de vida aumentando com as camadas"
  },
  State_118656_Name = {
    Text = "Parasitado múltiplas vezes"
  },
  State_118657_Desc = {
    Text = "Ao jogar a carta, receba [StateArg1] pontos de dano e remova 1 camada. Quando as camadas forem 0, incube um \"ser do mar\" mais fraco. Se o estado de parasita ainda existir no final do turno, incube um \"ser do mar\" de vida aumentando com as camadas"
  },
  State_118657_Name = {
    Text = "Ser Parasitado Novamente"
  },
  State_118659_Desc = {
    Text = "Ao jogar a carta, receba [StateArg1] pontos de dano e remova 1 camada. Quando as camadas forem 0, incube um \"ser do mar\" mais fraco. Se o estado de parasita ainda existir no final do turno, incube um \"ser do mar\" de vida aumentando com as camadas"
  },
  State_118659_Name = {Text = "Infestado"},
  State_118663_Name = {
    Text = "Monitoramento da Intenção do Chefe da Cobra do Novo Mundo"
  },
  State_118669_Name = {
    Text = "Inicialização do Chefe da Cobra do Novo Mundo"
  },
  State_118670_Desc = {
    Text = "Detecção de Contramedida de Esgotamento"
  },
  State_118670_Name = {
    Text = "Detecção de Contramedida de Esgotamento"
  },
  State_118671_Desc = {
    Text = "Detecção do Comportamento de Esgotamento do Jogador"
  },
  State_118671_Name = {
    Text = "Monitoramento de Contramedida de Esgotamento"
  },
  State_118672_Name = {
    Text = "Monitoramento da Intenção do Chefe da Cobra do Novo Mundo Resfriando"
  },
  State_118741_Name = {
    Text = "Remover tentáculos temporários"
  },
  State_118743_Name = {
    Text = "É necessário um marcador de invocação para a posição pré-requisito de invocação"
  },
  State_118759_Name = {
    Text = "Número de tentáculos permanentes do monstro"
  },
  State_118760_Name = {
    Text = "Limite de tentáculos permanentes do monstro"
  },
  State_118762_Name = {
    Text = "Dica de primeira decadência"
  },
  State_118763_Name = {
    Text = "Dica de primeira neurotoxina-Perfuração de Sangue"
  },
  State_118764_Name = {
    Text = "Dica de primeiro Sopro da Maldição"
  },
  State_118766_Name = {
    Text = "Monitoramento da Intenção do BOSS do Polvo do Anel Azul"
  },
  State_118769_Name = {
    Text = "Dica da Lanterna Núcleo de Prata"
  },
  State_118771_Name = {
    Text = "Dica de primeira tentativa"
  },
  State_118772_Name = {
    Text = "Dica de rasgo das serpentes pela primeira vez"
  },
  State_118935_Name = {
    Text = "Monitoramento da Intenção do Monstro Murphy"
  },
  State_118938_Desc = {
    Text = "A Dama das Profundezas Despertou, aumentando muito a quantidade de Escudo criada!"
  },
  State_118938_Name = {Text = "Criatura"},
  State_118943_Desc = {
    Text = "Dano recebido durante o próprio turno é dobrado. Ao perder vida, perde um número igual de camadas. Quando o número de camadas é 0, reduza permanentemente o número de tentáculos em 1 e reinicie as camadas, com um mínimo de 1 tentáculo."
  },
  State_118943_Name = {
    Text = "Sacrifício de Deipara"
  },
  State_118973_Name = {
    Text = "Gestão da Rebelião Contida"
  },
  State_119051_Desc = {
    Text = "Ativado no fim do turno: sofre dano passivo equivalente ao número de capas e remove metade das capas, não podendo ser dissipado."
  },
  State_119051_Name = {
    Text = "<PVPSacrificeKeyWords:Sacrifício>"
  },
  State_119052_Desc = {
    Text = "Após receber dano ativo, ganha [Layer]% de sacrifício."
  },
  State_119052_Name = {
    Text = "Cerimônia de Nascimento"
  },
  State_119053_Desc = {
    Text = "Ativado no final do turno: sofre [Layer] de dano passivo e remove metade das capas, não podendo ser dissipado."
  },
  State_119053_Name = {
    Text = "Sacrifício"
  },
  State_119058_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Ao fim do turno, aplica [StateArg1] de <PVPSacrificeKeyWords:Sacrifício> ao inimigo com menos Sacrifício, repetindo [StateArg2] vez(es). Todos os aliados não são mais afetados pelo Efeito de redução do <PVPCapKeywords:Limite de capacidade de cálculo>."
  },
  State_119058_Name = {
    Text = "Descanso na Escuridão"
  },
  State_119059_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Após \"Fúria Explosiva\", todos os inimigos sofrerão Sacrifício de [StateArg1]% de Dano após receber Dano ativo nesta rodada."
  },
  State_119059_Name = {
    Text = "Toxina do Anel Azul"
  },
  State_119060_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>:Dano de \"golpe\" aumenta em [StateArg1]%, após qualquer aliado disparar \"golpe\", compre [StateArg3] cartas, podendo ser ativado no máximo [StateArg2] vezes por turno (já ativado [DescArg1] vezes)."
  },
  State_119060_Name = {
    Text = "Carnificina até o fim do mundo"
  },
  State_119061_Desc = {
    Text = "<PVPWeaponKeywords:roda do destino>: Dano de \"golpe\" para todos os aliados aumenta em [StateArg1]%."
  },
  State_119061_Name = {
    Text = "Luz do Intelecto"
  },
  State_119063_Desc = {
    Text = "Após atingir 5 camadas, a intenção será trocada para: \"Glória de Lemúria!\"."
  },
  State_119063_Name = {Text = "Chamar"},
  State_119075_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_119075_Name = {
    Text = "Ainda não despertado"
  },
  State_119076_Desc = {
    Text = "Se houver espaço na linha de frente, após a ação, perca 1 camada e invoque aleatoriamente 1 \"Corpo Desperto de Lemuria\"."
  },
  State_119076_Name = {
    Text = "Contrato: Lemúria"
  },
  State_119077_Desc = {
    Text = "\"Chamar\" atinge 5 camadas, imediatamente sela todos os Corpos Despertos."
  },
  State_119077_Name = {
    Text = "Miriam Despertar!"
  },
  State_119077_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_119080_Desc = {
    Text = "Ao liberar \"Memória do Caos\" ou \"Amanhecer não esquecido\", a chave selecionada toma efeito 1 vez adicional."
  },
  State_119080_Name = {
    Text = "Vindo do esquecimento"
  },
  State_119082_Desc = {
    Text = "A cada vez que um Corpo Desperto libera Fúria Explosiva, o Aliemus Base +10."
  },
  State_119082_Name = {
    Text = "Agotamento da loucura"
  },
  State_119083_Desc = {
    Text = "Quando uma carta de comando é retirada do espaço hiperdimensional, o consumo de potência de cálculo é -1."
  },
  State_119083_Name = {
    Text = "Caminho do Fim do Outro Mundo"
  },
  State_119084_Desc = {
    Text = "A cada liberação da Ordem de chave, a Energia de chave necessária +100."
  },
  State_119084_Name = {
    Text = "Oscilação da Chave de Prata"
  },
  State_119085_Desc = {
    Text = "Após usar o Forno Carmesim, transforme 1 embrião em Filho da santidade, com um tempo de recarga de 3 turnos."
  },
  State_119085_Name = {
    Text = "Reprodução Carmesim"
  },
  State_119086_Desc = {
    Text = "A força da Reprodução está resfriando, restam [Layer] turnos."
  },
  State_119086_Name = {
    Text = "Poder de Reprodução - Tempo de resfriamento"
  },
  State_119104_Desc = {
    Text = "No início da rodada, ganhe [DescArg1] camadas de \"Contrato de Vida\""
  },
  State_119104_Name = {
    Text = "Ritual do Mar"
  },
  State_119105_Desc = {
    Text = "Após a morte, perca todos os \"contratos de vida.\" Restaure 1% do hp máximo por camada e aumente o dano de tentáculos em 1%."
  },
  State_119105_Name = {Text = "Pacto"},
  State_119106_Name = {
    Text = "Monitoramento da Intenção do Monstro Delírio Murphy"
  },
  State_119107_Name = {
    Text = "Gestão da Ordem do Reino Divino"
  },
  State_119108_Desc = {
    Text = "Ao perder hp, para cada 1 camada ganhe 1% do hp perdido como <SacrificeKeyWord:sacrifício>."
  },
  State_119108_Name = {
    Text = "Cerimônia de Nascimento"
  },
  State_119109_Desc = {
    Text = "Ao receber dano de fontes que não sejam <SacrificeKeyWord:Sacrifício>, perde uma quantidade equivalente de \"Ordem do Reino Divino\" e ganha <SacrificeKeyWord:Sacrifício> equivalente a 50% do dano. Se as camadas estiverem em 0, ganha 1 camada de \"Pacto\" e reinicia as camadas."
  },
  State_119109_Name = {
    Text = "Ordem do Reino Divino"
  },
  State_119132_Desc = {
    Text = "Neste turno, dano do \"golpe\" aumenta [Layer]%."
  },
  State_119132_Name = {
    Text = "Golpe & Fortalecer"
  },
  State_119134_Name = {
    Text = "Dica de primeiro Herdeiro da Ilusão"
  },
  State_119359_Name = {
    Text = "Contagem do Ritual da Chave de Prata"
  },
  State_119362_Name = {
    Text = "Realizar um ritual"
  },
  State_119363_Name = {
    Text = "Possuir cartas"
  },
  State_119364_Name = {
    Text = "Contagem de Ritual de Fúria"
  },
  State_119365_Desc = {
    Text = "Todos os despertos têm um aumento de 40% na recuperação de vida e escudo que causam."
  },
  State_119365_Name = {
    Text = "Calma e Composta"
  },
  State_119366_Desc = {
    Text = "Após descartar, retorna à mão"
  },
  State_119366_Name = {
    Text = "Após descartar, retorna à mão"
  },
  State_119367_Name = {
    Text = "Contagem do Rito de Vida"
  },
  State_119368_Desc = {
    Text = "No início de cada turno, ganhe 500 pontos de energia da chave de prata."
  },
  State_119368_Name = {
    Text = "Ver claramente"
  },
  State_119369_Desc = {
    Text = "A loucura causada por todos os corpos despertos aumenta em 50%."
  },
  State_119369_Name = {
    Text = "Ordem de peso"
  },
  State_119370_Name = {Text = "Criação"},
  State_119373_Name = {
    Text = "Inimigo impõe sacrifício"
  },
  State_119567_Name = {
    Text = "Completar o ritual"
  },
  State_119568_Desc = {
    Text = "Aumento de dano de golpe recebido em [Layer] pontos."
  },
  State_119568_Name = {
    Text = "golpear mais profundo"
  },
  State_119583_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Antes de \"Golpe\", \"Habilidade\" e \"Fúria Explosiva\", ganha temporariamente <StrongEffectKeywords:Eficaz> +[StateArg1], cada efeito só pode ser acionado uma vez por turno."
  },
  State_119583_Name = {
    Text = "Nós, finalmente, nos reencontraremos"
  },
  State_119588_Name = {
    Text = "Carne e sangue cd"
  },
  State_119589_Name = {Text = "Ultra cd"},
  State_119590_Desc = {
    Text = "Equipe Única: Após trocar de Postura de Tentáculo, usar o Forno Carmesim ou desencadear \"Aniquilação\", compra a Carta de comando do Portador ×1; cada efeito tem uma recarga de 3 turnos. Após a Exploração, todos os Corpos Despertos da equipe ganham +<WeaponEffect_Num:[StateArg1]%> de Taxa de Sincronização."
  },
  State_119590_WeaponDesc = {
    Text = "Ative a mudança para a Postura de Tentáculo (tempo restante de resfriamento [DescArg1] turnos), use o Forno Carmesim (tempo restante de resfriamento [DescArg2] turnos), após liberar \"Aniquilação\" (tempo restante de resfriamento [DescArg3] turnos), compre 1 carta de comando do portador, cada efeito com 3 turnos de resfriamento. Após concluir a exploração, a taxa de sincronização obtida por todos os Corpos Despertos aumenta em <WeaponEffect_Num:[StateArg1]%>."
  },
  State_119591_Name = {
    Text = "Mar Profundo cd"
  },
  State_119741_Desc = {
    Text = "Todos os corpos despertos recebem a redução de força em 50%."
  },
  State_119741_Name = {
    Text = "Maldição: queda"
  },
  State_119742_Desc = {
    Text = "Recupera 15% da vida perdida no início de cada turno."
  },
  State_119742_Name = {
    Text = "Bênção da Imagem: Sonho Eterno"
  },
  State_119743_Desc = {
    Text = "A recuperação de vida de todos os corpos despertos é reduzida em 50%."
  },
  State_119743_Name = {
    Text = "Maldição: morte"
  },
  State_119744_Desc = {
    Text = "\"Maldição da Imagem Sagrada: Ódio da Destruição\" desativada por 1 turno."
  },
  State_119744_Name = {
    Text = "Imunidade à Maldição da Imagem Sagrada: Ódio da Destruição"
  },
  State_119746_Name = {
    Text = "Perdas da Trava Dimensional"
  },
  State_119747_Desc = {
    Text = "Não sofrerá dano, por 1 turno."
  },
  State_119747_Name = {
    Text = "Chave Prateada, ilumine o caminho"
  },
  State_119748_Desc = {
    Text = "\"Maldição da Imagem: Lamento do Declínio\" desativada por 1 turno."
  },
  State_119748_Name = {
    Text = "Imunidade à Maldição da Imagem: Lamento do Declínio"
  },
  State_119749_Desc = {
    Text = "No início do turno do guardião, aplique 1 camada de <SlowIconKeywords:estagnação> à mão equivalente às camadas de \"<Abyssallock:Grilhões do sonho>\"."
  },
  State_119749_Name = {
    Text = "Grilhões dos Sonhos"
  },
  State_119750_Name = {
    Text = "Monitoramento da Intenção da Cortina do Céu"
  },
  State_119751_Name = {
    Text = "Cortina Reproduzir Liberar Marca"
  },
  State_119752_Desc = {
    Text = "No início de cada rodada, ganhe 5% da vida máxima em <PowerIconKeywords:força>, e a taxa crítica temporária aumenta em 25%."
  },
  State_119752_Name = {
    Text = "Bênção da Imagem Sagrada: Sonho de Poder"
  },
  State_119753_Name = {
    Text = "Contagem da Maré do Abismo Sombrio"
  },
  State_119754_Desc = {
    Text = "A loucura causada por todos os despertos é reduzida em 50%. No final do turno, ganhe 1 camada de \"<DarkEgo:lado sombrio do eu>\": no início do turno, todos os despertos ganham 3 de loucura."
  },
  State_119754_Name = {
    Text = "Maldição: tolice"
  },
  State_119755_Name = {
    Text = "Contagem de Morte"
  },
  State_119756_Desc = {
    Text = "\"Maldição da Ícone: Lamento da Estupidez\" desativada por 1 turno."
  },
  State_119756_Name = {
    Text = "Imunidade da Ícone: Lamento da Estupidez"
  },
  State_119757_Desc = {
    Text = "No início do turno do Guardião, aplica 1 camada de <SlowIconKeywords:Desaceleração> nas cartas na mão equivalentes ao número de camadas de <Abyssallock:Grilhões dos Sonhos>. Cada vez que a \"Cortina do Paraíso\" for rompida por Dano ativo, reduz 1 camada e faz com que o Corpo Desperto rompido seja \"completamente selado\" por 1 turno."
  },
  State_119757_Name = {
    Text = "Grilhões dos Sonhos"
  },
  State_119758_Desc = {
    Text = "No início de cada turno, todos os corpos despertos ganham 10 pontos de fúria."
  },
  State_119758_Name = {
    Text = "Bênção da Imagem Sagrada: Sonho do Conhecimento"
  },
  State_119760_Name = {
    Text = "Monitoramento da Morte"
  },
  State_119789_Desc = {
    Text = "No início do turno, recupere [Layer] pontos de vida."
  },
  State_119789_Name = {
    Text = "Florescer de Lodo"
  },
  State_119837_Desc = {
    Text = "A próxima carta de comando jogada por Ramona neste turno tem efeito 2 vezes."
  },
  State_119837_Name = {
    Text = "Novamente de mãos dadas"
  },
  State_119847_Desc = {
    Text = "Mude o poder de cálculo das cartas antes de disparar."
  },
  State_119847_Name = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_119928_Desc = {
    Text = "Após jogar, ativa-se adicionalmente [StateArg1] vezes, <DepleteIconKeywords:Consumo>. <RippleKeywords:Réplica>: compre 2 cartas."
  },
  State_119928_Name = {
    Text = "<Rune_20:Eco do Mar Profundo>"
  },
  State_119958_Desc = {
    Text = "Após a morte, invoque imediatamente um \"Cardume\" aleatório, reduzindo 1 camada de \"Migração dos Peixes\"."
  },
  State_119958_Name = {
    Text = "Migração dos Peixes"
  },
  State_119959_Desc = {
    Text = "Após a morte, invoque imediatamente 1 \"Grupo fetal\" aleatório, reduzindo 1 camada de \"Vida eterna\"."
  },
  State_119959_Name = {
    Text = "Vida eterna"
  },
  State_119960_Desc = {
    Text = "Dano ativo e Dano de tentáculo causados –35%. Este Estado é dissipado quando a Vida atual estiver acima de 50%."
  },
  State_119960_Name = {
    Text = "<PurpleKeyWord:Podridão>"
  },
  State_120215_Desc = {
    Text = "No início do turno do Guardião, aplica 1 camada de <SlowIconKeywords:Desaceleração> nas cartas na mão equivalentes ao número de camadas de <Abyssallock:Grilhões dos Sonhos>. Cada vez que a \"Cortina do Paraíso\" for rompida por Dano ativo, reduz 1 camada e faz com que o Corpo Desperto rompido seja \"completamente selado\" por 1 turno."
  },
  State_120215_Name = {
    Text = "Trava dimensional"
  },
  State_120216_Desc = {
    Text = "No início do turno do Guardião, aplica 1 camada de <SlowIconKeywords:desaceleração> nas cartas da mão equivalentes ao número de camadas de <Abyssallock:Trava dimensional>."
  },
  State_120216_Name = {
    Text = "Trava dimensional"
  },
  State_120218_Name = {
    Text = "Fim do turno, escolha suporte de Murphy"
  },
  State_120222_Name = {
    Text = "Escolher maldição de reverter no início do turno"
  },
  State_120292_Name = {
    Text = "Dor Não Aceita"
  },
  State_120293_Desc = {
    Text = "No fim do turno, recupera [Layer] de vida"
  },
  State_120293_Name = {
    Text = "Dor Não Aceita"
  },
  State_120312_Desc = {
    Text = "Após a morte, invoque imediatamente um \"Rei dos Peixes\" aleatório, fazendo com que sua \"Migração dos Peixes\" diminua 1 camada."
  },
  State_120312_Name = {
    Text = "Migração dos Peixes"
  },
  State_120320_Desc = {
    Text = "Cada camada aumenta em 20% a \"Cerimônia de Nascimento\" aplicada pela próxima \"Princesa Ilusória\", acumulando até 5 camadas. Ao atingir 5 camadas, o número de danos da próxima \"Princesa Ilusória\" dobra."
  },
  State_120320_Name = {Text = "Pacto"},
  State_120321_Desc = {
    Text = "Cada capa inflige capas de \"Sacrifício\" iguais a 1% do Dano ativo ou Dano de tentáculo recebido. Acumula até 75. Removido no fim do turno."
  },
  State_120321_Name = {
    Text = "<DwmofeiKeywords:Cerimônia de Nascimento>"
  },
  State_120322_Desc = {
    Text = "Equipe Única: Limite de cartas na mão +2, não se sobrepõe ao limite de cartas na mão fornecido por outras Rodas do Destino. O portador melhora o dano final causado pela Recarregar Chave de Prata e Fúria Explosiva em <WeaponEffect_Num:[StateArg1] %>. Ao mudar para a postura \"Mar Calmo\", o portador ganha <WeaponEffect_Num:[StateArg2]> pontos de Fúria, com um tempo de recarga de 3 turnos. Ao mudar para a postura \"Onda de Ira\", aplica <WeaponEffect_Num:[StateArg3]> camadas de <DwmofeiKeywords:Cerimônia de Nascimento> a todos os inimigos, com um tempo de recarga de 3 turnos."
  },
  State_120322_WeaponDesc = {
    Text = "Limite de cartas na mão +2, não se acumula com o limite de cartas na mão fornecido por outras Roda do destino. O portador ganha <WeaponEffect_Num:[StateArg1]%> de dano final e escudo aprimorado causado por Recarregar Chave de Prata e Fúria Explosiva. Ao mudar para a postura \"Mar Calmo\", o portador ganha <WeaponEffect_Num:[StateArg2]> pontos de Fúria, com um tempo de recarga de 3 rodadas. Ao mudar para a postura \"Onda de Ira\", aplica <WeaponEffect_Num:[StateArg3]> camadas de <DwmofeiKeywords:Cerimônia de Nascimento> em todos os inimigos, com um tempo de recarga de 3 rodadas."
  },
  State_120324_Desc = {
    Text = "Cada capa inflige capas de \"Sacrifício\" iguais a [Layer]% do Dano ativo ou Dano de tentáculo recebido. Acumula até 75. Removido ao final do turno."
  },
  State_120324_Name = {
    Text = "Cerimônia de Nascimento"
  },
  State_120351_Desc = {
    Text = "[Layer] poderá trocar novamente \"Reino Divino·Mar Calmo\" após o turno."
  },
  State_120351_Name = {
    Text = "Reino Divino·Mar Calmo em cooldown"
  },
  State_120354_Desc = {
    Text = "[Layer] pode alternar novamente \"Reino Divino·Onda de Ira\" após o turno."
  },
  State_120354_Name = {
    Text = "Reino Divino·Resfriamento da Onda de Ira"
  },
  State_120357_Name = {Text = "tentáculo"},
  State_120362_Desc = {
    Text = "Ao receber dano fora de <SacrificeKeyWord:sacrifício>, ganha 50% do dano como <SacrificeKeyWord:sacrifício>"
  },
  State_120362_Name = {
    Text = "Gerenciamento de Sacrifício de Monstros Genéricos"
  },
  State_120363_Desc = {
    Text = "Após o fim do turno, sofre [Layer] de dano e reduz 50% das camadas de <SacrificeKeyWord:Sacrifício>."
  },
  State_120363_Name = {
    Text = "<BlueKeyWord:Sacrifício>"
  },
  State_120364_Desc = {
    Text = "Invocação do \"Guarda do Marchador de Mares\" após a própria morte."
  },
  State_120364_Name = {
    Text = "Crença eterna"
  },
  State_120401_Desc = {
    Text = "O consumo aritmético desta carta diminui em [StateArg5], e ao disparar, compre [StateArg4] cartas."
  },
  State_120401_Name = {
    Text = "<OrangeQuality:Emblema de Mythag>"
  },
  State_120450_Name = {
    Text = "Polvo de anéis azuis registra a vida do jogador"
  },
  State_120462_Desc = {
    Text = "Permanece no baralho após o combate, mas será removida permanentemente ao ser Disparada ou consumida."
  },
  State_120462_Name = {
    Text = "<DestructionKeywords:Destruir>"
  },
  State_120900_Name = {
    Text = "Pronto para a invocação do \"Corpo Desperto de Lemuria\" contagem"
  },
  State_120907_Desc = {
    Text = "Se o ataque de tentáculo for bloqueado, causa [DescArg1] camadas de <IntoxicationIconKeywords:veneno>."
  },
  State_120907_Name = {
    Text = "Corrente sombria"
  },
  State_120908_Desc = {
    Text = "Se um ataque de tentáculo for bloqueado, causará a mesma quantidade de camadas de <IntoxicationIconKeywords:envenenamento>."
  },
  State_120908_Name = {
    Text = "Corrente sombria"
  },
  State_120910_Desc = {
    Text = "O consumo de potência de cálculo desta carta aumenta em +[StateArg5], dispare para comprar [StateArg4] cartas."
  },
  State_120910_Name = {
    Text = "<OrangeQuality:Emblema de Mythag>"
  },
  State_120924_Desc = {
    Text = "No início da próxima rodada, ganhe reforço."
  },
  State_120924_Name = {
    Text = "Reforço de latência"
  },
  State_120929_Desc = {
    Text = "A carta ganha Preservar, mas ao ser disparada, remove a poluição e invoca 1 \"Excrescência abissal\". Se não houver espaço para invocar, ganhará 1 camada de \"Pronto: Excrescência abissal\"."
  },
  State_120929_Name = {
    Text = "<SeastriderCurse:Maldição do Marchador de mares>"
  },
  State_120930_Desc = {
    Text = "Se houver espaço livre, perca 1 camada após a ação e invoque 1 \"Excrescência Abissal\"."
  },
  State_120930_Name = {
    Text = "Contrato de Cooperação: Excrescência Abissal"
  },
  State_120934_Desc = {
    Text = "Cada vez que sofrer Dano crítico, ganhe 3% de <Baojidikang:Resistência a golpes críticos Temporário>. No início de cada rodada, adicione \"<SeastriderCurse:Maldição dos Marchadores de Mares>\" a 2 cartas."
  },
  State_120934_Name = {
    Text = "Cerimônia de sacrifício no mar profundo"
  },
  State_120941_Desc = {
    Text = "Amplia as habilidades do inimigo. Perde uma camada a cada dano recebido"
  },
  State_120941_Name = {
    Text = "Juramento de Sangue"
  },
  State_121006_Desc = {
    Text = "Equipe Única: O recarregar da chave de prata do portador, o dano final causado pela explosão de fúria e o escudo melhorado aumentam em <WeaponEffect_Num:[StateArg1]%>."
  },
  State_121006_WeaponDesc = {
    Text = "Recarregar Chave de Prata, Dano Final causado pela Fúria Explosiva e Escudo melhorado <WeaponEffect_Num:[StateArg1]%>."
  },
  State_121014_Name = {
    Text = "Proteção do Feto Sagrado"
  },
  State_121015_Desc = {
    Text = "No início do turno, o escudo não será removido. Ao ter escudo, possui 50 camadas de <ReinforcePVEKeywords:Reforço>, que são removidas quando o escudo é quebrado."
  },
  State_121015_Name = {
    Text = "Proteção do Feto Sagrado"
  },
  State_121151_Desc = {
    Text = "A carta ganha Preservar, mas ao ser disparada remove a poluição e invoca 1 \"Excrescência abissal\". Se não houver espaço para invocação, ganhará 1 camada de \"Pronto: Excrescência abissal\"."
  },
  State_121151_Name = {
    Text = "<SeastriderCurse:Maldição do Marchador de mares>"
  },
  State_121210_Name = {
    Text = "Conceder a todos os inimigos um efeito negativo <PVPWonderfulEffectKeywords:Efeito Maravilhoso>, ativo 2 vezes"
  },
  State_121211_Name = {
    Text = "Compre 2 cartas, ganhe 2 poder de cálculo"
  },
  State_121212_Name = {
    Text = "Conceder a todos os aliados um <PVPWonderfulEffectKeywords:efeito maravilhoso> positivo, efetivo 2 vezes"
  },
  State_121213_Desc = {
    Text = "Imune a todo dano."
  },
  State_121213_Name = {
    Text = "Imune a todo dano."
  },
  State_121231_Desc = {
    Text = "Cada camada aumenta a próxima aplicação da \"Princesa Abissal\" do \"Ritual de Sacrifício\" em 20%, acumulando até 5 camadas, e quando acumulado até 5 camadas, a contagem de dano da próxima \"Princesa Abissal\" é dobrada."
  },
  State_121231_Name = {
    Text = "<MingqiKeywords:Pacto>"
  },
  State_121365_Desc = {
    Text = "Dano de tentáculo recebido adicional de [Layer]%."
  },
  State_121377_Name = {
    Text = "<RetainIconKeywords:Preservar>: No início de cada turno, ganhe 500 pontos de energia da chave de prata"
  },
  State_121378_Name = {
    Text = "<RetainIconKeywords:Preservar>: Aumenta em 40% a recuperação de vida e o escudo causados por todos os despertos."
  },
  State_121380_Name = {
    Text = "<RetainIconKeywords:Preservar>: A loucura causada por todos os corpos despertos aumenta em 50%"
  },
  State_121719_Name = {
    Text = "<RippleKeywords:Réplica>: Compre 1 carta, ganhe [DescArg1] pontos temporários de <PowerIconKeywords:força>"
  },
  State_121734_Desc = {
    Text = "Cada vez que jogar 1 carta de comando, descarte 1 carta desse despertador com o menor custo de aritmética."
  },
  State_121734_Name = {
    Text = "Fluxo da Loucura"
  },
  State_121735_Desc = {
    Text = "O custo aritmético de todas as cartas de comando aumenta em 1. A cada 3 turnos, ao final do turno, coloque 1 carta de \"petrificação gradual\" na sua mão."
  },
  State_121735_Name = {
    Text = "Torrente de Lamentos"
  },
  State_121736_Desc = {
    Text = "No final do turno, recupera 10% da vida perdida e remove os próprios estados negativos e os estados positivos do jogador."
  },
  State_121736_Name = {
    Text = "Corrente da Chegada"
  },
  State_121737_Desc = {
    Text = "No início da batalha, ganhe 15 camadas de \"barreira temporária\". No final do turno, ganhe 15 camadas de \"barreira temporária\" e adicione \"dissolução temporária\" a 10 cartas aleatórias."
  },
  State_121737_Name = {
    Text = "Corrente Gélida"
  },
  State_121738_Desc = {
    Text = "O efeito de <PowerIconKeywords:força> aplicado pelo corpo despertado é reduzido em 75%. Sempre que perder vida, ganhe <Block:[Block:DescArg1]> pontos de escudo e 1 camada de reforço temporário."
  },
  State_121738_Name = {
    Text = "Fluxo da Maldade"
  },
  State_121739_Desc = {
    Text = "O limite de loucura de todos os despertadores aumenta em 50%. No final de cada turno, todos os despertadores perdem 10 pontos de loucura e recuperam 3% da própria saúde máxima."
  },
  State_121739_Name = {
    Text = "Fluxo do Terror"
  },
  State_121740_Desc = {
    Text = "Ao início do combate e ao fim de cada rodada, obtém 2 camadas de <ResentChainsKeywords:Cadeia de Rancor> Temporária."
  },
  State_121740_Name = {
    Text = "Corrente Sinistra"
  },
  State_121797_Desc = {
    Text = "Todos os Danos, curas e efeitos de Escudo causados são reduzidos em 10%, limite de 2 camadas, não pode ser dispersado. Após a morte do último aplicador de Embriagado, todos os efeitos de Embriagado do alvo afetado serão removidos."
  },
  State_121797_Name = {
    Text = "<PVPLostSoulKeyWords:Encantado>"
  },
  State_121798_Desc = {
    Text = "O Dano causado, a cura e o Efeito de Escudo são reduzidos em [DescArg1]%, não pode ser dissipado. Máximo de 2 capas.\nRemovido após Eliminação<StatusApplier:>."
  },
  State_121798_Name = {Text = "Spellbound"},
  State_121799_Name = {
    Text = "Carta de Apoio de Lemúria do Quarto Capítulo"
  },
  State_121850_Desc = {
    Text = "Dano de tentáculo reduzido em 80%"
  },
  State_121850_Name = {
    Text = "Goliath: Suporte"
  },
  State_121863_Name = {
    Text = "<RippleKeywords:Réplica>: Compre 2 cartas"
  },
  State_121878_Name = {
    Text = "Selecionar pela primeira vez a trama da maldição reversa"
  },
  State_122428_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_122428_Name = {
    Text = "Ainda não despertado"
  },
  State_122431_Desc = {
    Text = "Quando Mouchette causar dano não bloqueado, ganhe 2 camadas de <Monster_Fervor:Fervor temporário>."
  },
  State_122431_Name = {
    Text = "Vestígios da Névoa"
  },
  State_122441_Desc = {
    Text = "<PVPWeaponKeywords:roda do destino>: Equipado, ganha 3 camadas de <PVPReciprocalKeywords:Momento da contagem regressiva>."
  },
  State_122441_Name = {
    Text = "Momento da contagem regressiva"
  },
  State_122442_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Equipe para ganhar <Block:[Block:StateArg1]> Escudo e <Energy:[Energy:StateArg1]> Aliemus. No final do turno, esta Roda do Destino se desune automaticamente, aumentando o Aliemus e o Escudo ganhos na próxima equipagem da \"Caixa da Infância\" em [StateArg2]."
  },
  State_122442_Name = {
    Text = "Diversão na Caixa"
  },
  State_122443_Desc = {
    Text = "No início da rodada, contagem de pilhas - 1. Uma vez que as pilhas estejam esgotadas, dissipe os debuffs de si mesmo e ganhe 100 Aliemus, em seguida, recupere 3 pilhas de Contagem Regressiva. Mudar a Roda do Destino removerá o estado de Contagem Regressiva."
  },
  State_122443_Name = {
    Text = "<PVPFlowerKeywords:Momento da contagem regressiva>"
  },
  State_122596_Desc = {
    Text = "Não pode ser jogado a carta, não é possível liberar a Fúria Explosiva."
  },
  State_122596_Name = {
    Text = "<Seal1:Selo>"
  },
  State_122636_Desc = {
    Text = "A cada turno, o primeiro \"skill\" disparado aumenta o dano, a cura e o escudo em [StateArg1]%."
  },
  State_122636_Name = {
    Text = "Broche de Rubi"
  },
  State_122650_Desc = {
    Text = "Criação <OrangeQuality:Luvas Mágicas> adicionou este cartão."
  },
  State_122650_Name = {
    Text = "Carta estranha"
  },
  State_122654_Name = {
    Text = "Sempre que o turno começar ou uma ação for concluída, será feita uma tentativa de reiniciar o baralho do jogador. Se não estiver vazio, o reinício não ocorrerá."
  },
  State_122706_Name = {
    Text = "<CardKeyWord:Reencontro de Desejo>"
  },
  State_122707_Desc = {
    Text = "Trate isto como a última \"Habilidade\" disparada neste turno. Consumo de potência de cálculo -1."
  },
  State_122707_Name = {
    Text = "<CardKeyWord:Reencontro de Desejo>"
  },
  State_123109_Desc = {
    Text = "Equipe Única: Ao comprar pela primeira vez uma \"Gravura\" na \"Marca de Fusão\", ou ao comprar pela primeira vez um item em promoção nas \"Ruínas Cinzentas\", a necessidade de Marca Negra é reduzida a <WeaponEffect_Num:[StateArg1]%> de chance para 0, podendo ocorrer no máximo 1 vez por exploração."
  },
  State_123109_WeaponDesc = {
    Text = "Na \"Marca de Fusão\", ao comprar \"Gravura\" pela primeira vez, ou ao comprar um produto com desconto nas \"Ruínas Cinzentas\" pela primeira vez, há uma chance de <WeaponEffect_Num:[StateArg1]%> de que o custo em Marca Negra se torne 0, podendo ocorrer no máximo 1 vez por exploração."
  },
  State_123177_Desc = {
    Text = "Limpe no início do turno. Após alcançar 10 camadas, na próxima vez que uma carta for disparada, Mouchette age imediatamente, removendo \"Fervor Temporário\" e adicionando a intenção \"Explosão Humana\"."
  },
  State_123177_Name = {
    Text = "Fervor temporário"
  },
  State_123178_Desc = {
    Text = "O efeito de Recuperar vida de <Guaiwusiwangdikang: Resistência à Morte> é aumentado para 5 vezes. Cada vez que o inimigo usar 1 Carta, você obtém 1 camada de <Monster_Fervor:Fervor temporário>."
  },
  State_123178_Name = {
    Text = "mal humor ao acordar"
  },
  State_123243_Desc = {
    Text = "Remove todas as capas deste estado ao eliminar um inimigo. Ganha a mesma quantidade de Fúria para cada capa removida. Limite de 2 capas."
  },
  State_123243_Name = {Text = "redemoinho"},
  State_123246_Desc = {
    Text = "Ao eliminar um inimigo, remove todas as capas e ganha uma quantidade igual de Fúria. Limite de 2 capas."
  },
  State_123246_Name = {
    Text = "<PVPWaterPowerKeyWords:redemoinho>"
  },
  State_123294_Desc = {
    Text = "Neste turno, [DescArg1] cartas foram compradas através de \"Investida\"."
  },
  State_123294_Name = {Text = "Slaughter"},
  State_123507_Desc = {
    Text = "Time Única: No início da exploração, adicione 1 \"Contagem Regressiva: 5\" ao baralho: Após jogar, compre 1 carta e embaralhe a próxima \"Contagem Regressiva\" na Pilha de Descarte. \"<DestructionKeywords:Destruir>\". \"Contagem Regressiva: 0\": Compre 3 cartas, ganhe 3 Aritmética e tenha uma chance de <WeaponEffect_Num:[StateArg1]%> de embaralhar \"Contagem Regressiva: 5\" na Pilha de Descarte. Mantenha. \"<DestructionKeywords:Destruir>\"."
  },
  State_123507_WeaponDesc = {
    Text = "No início da exploração, adicione 1 \"Contagem Regressiva: 5\" ao baralho: Após jogar, compre 1 carta e embaralhe a próxima \"Contagem Regressiva\" na Pilha de Descarte. \"<DestructionKeywords:Destruir>\". \"Contagem Regressiva: 0\": Compre 3 cartas, ganhe 3 Aritmética e tenha uma chance de <WeaponEffect_Num:[StateArg1]%> de embaralhar \"Contagem Regressiva: 5\" na Pilha de Descarte. Retenha. \"<DestructionKeywords:Destruir>\"."
  },
  State_123520_Desc = {
    Text = "Único na equipe: Após a primeira liberação de Posse em cada turno, há uma chance de <WeaponEffect_Num:[StateArg1]>% de comprar 1 \"Golpe\" do portador."
  },
  State_123520_WeaponDesc = {
    Text = "Após a primeira liberação de Posse em cada turno, há uma chance de <WeaponEffect_Num:[StateArg1]>% de comprar 1 \"Golpe\" do portador."
  },
  State_123521_Desc = {
    Text = "Único na equipe: O DANO Base da Exaltação e do Perseguimento do portador +<WeaponEffect_Num:[StateArg1]%>. Após jogar qualquer \"Golpe\" de Despertador neste turno, o DANO do \"Golpe\" do portador aumenta temporariamente em <WeaponEffect_Num:[StateArg2]%> do ATK do portador. Este efeito pode ser ativado até 8 vezes por turno."
  },
  State_123521_WeaponDesc = {
    Text = "O DANO Base da Exaltação e do Perseguimento do portador +<WeaponEffect_Num:[StateArg1]%>. Após jogar qualquer \"Golpe\" de Despertador neste turno, o DANO do \"Golpe\" do portador aumenta temporariamente em <WeaponEffect_Num:[DescArg2]>. Este efeito pode ser ativado até 8 vezes por turno."
  },
  State_123810_Desc = {
    Text = "Substitua a intenção atual do inimigo por \"Impotente\"."
  },
  State_123810_Name = {
    Text = "<HunmiKeywords:Desmaiar>"
  },
  State_123812_Desc = {
    Text = "No final do turno, o consumo de poder é reduzido."
  },
  State_123812_Name = {
    Text = "<PrepareKeywords:Preparar>"
  },
  State_123994_Desc = {
    Text = "Não pode realizar nenhuma ação."
  },
  State_123994_Name = {
    Text = "Sono refinado"
  },
  State_124010_Desc = {
    Text = "No início do próximo turno, ganhe [Layer] Poder de cálculo."
  },
  State_124010_Name = {
    Text = "Aritmética de atraso"
  },
  State_124024_Desc = {
    Text = "Neste turno, [Layer] cartas \"Golpe\" foram jogadas, desencadeando \"Encontro Dramático\" [DescArg1] vezes."
  },
  State_124024_Name = {
    Text = "Encontro Dramático"
  },
  State_124034_Desc = {
    Text = "O dano \"Golpe\" de todos os Despertadores é aumentado em [StateArg1] por [Layer] turnos."
  },
  State_124034_Name = {
    Text = "Brilho☆Redemoinho"
  },
  State_124037_Desc = {
    Text = "Número de instâncias de dano de Mouchette +1, o dano \"Golpe\" de todos os Despertadores aumenta em [StateArg1], durando [Layer] turnos."
  },
  State_124037_Name = {
    Text = "Brilho☆Redemoinho"
  },
  State_124107_Desc = {
    Text = "Após a morte do \"Broto Nascente,\" torne-se imune a todo dano e desperte, dobrando a Saúde Máxima e ganhando Saúde Máxima igual à Vida Restante. Após despertar, dissipe todos os estados negativos."
  },
  State_124107_Name = {
    Text = "Ainda não despertado"
  },
  State_124108_Name = {
    Text = "Vozes do Além Contam"
  },
  State_124109_Desc = {
    Text = "Você ganha um bônus adicional de 5% de <PowerIconKeywords:Força> de <RetaliateIconKeywords:Contra-ataque>. Após perder [DescArg1] HP em um único turno, troque de posição com o \"Cantor.\""
  },
  State_124109_Name = {
    Text = "Cradle Secundário"
  },
  State_124111_Desc = {
    Text = "A recuperação de HP da Resistência à Morte é aumentada para 25%. Para cada Carta de Comando jogada pelo inimigo, temporariamente <TouquKeywords:Roubar> [DescArg1] <PowerIconKeywords:FOR>."
  },
  State_124111_Name = {
    Text = "Esplendor Estelar Sem Limites"
  },
  State_124112_Desc = {
    Text = "Após a morte do \"Cantor\", torne-se imune a todo dano e desperte, dobrando a Saúde Máxima e ganhando Saúde Máxima igual à vida restante."
  },
  State_124112_Name = {
    Text = "Ainda não despertado"
  },
  State_124113_Desc = {
    Text = "O oponente não descartará a mão no final do turno. No final do turno, aplique 2 pilhas de <FragileIconKeywords:frágil>, <WeaknessIconKeywords:fraqueza>, <HeavyInjuryKeywords:ferimento grave>, e <VulnerabilityIconKeywords:vulnerável> na ordem."
  },
  State_124113_Name = {
    Text = "Voz fora do mundo"
  },
  State_124115_Desc = {
    Text = "Os efeitos de <FragileIconKeywords:Frágil>, <HeavyInjuryKeywords:Lesão grave> e <WeaknessIconKeywords:Sintoma: Enfraquecer> são aumentados para 50%. Após disparar mais [DescArg1] cartas de <SlowIconKeywords:Stase>, troque de posição com \"Broto Nascido nas Estrelas\"."
  },
  State_124115_Name = {
    Text = "Viajante planetário"
  },
  State_124121_Name = {
    Text = "Número de Viajantes Planetários"
  },
  State_124122_Name = {
    Text = "Visitante planetário Jogador Ouvinte"
  },
  State_124190_Desc = {
    Text = "Você ganha um bônus adicional de 5% de <PowerIconKeywords:Força> de <RetaliateIconKeywords:Contra-ataque>."
  },
  State_124190_Name = {
    Text = "Cradle Secundário"
  },
  State_124193_Name = {
    Text = "A recuperação de saúde da Resistência à Morte aumentou para 25%."
  },
  State_124198_Desc = {
    Text = "Os efeitos de <FragileIconKeywords:Frágil>, <HeavyInjuryKeywords:Lesão grave> e <WeaknessIconKeywords:Sintoma: Enfraquecer> infligidos são aumentados para 50%."
  },
  State_124198_Name = {
    Text = "Viajante planetário"
  },
  State_124277_Desc = {
    Text = "Visualização de valores intermediários no processo de execução."
  },
  State_124277_Name = {
    Text = "Imprimir Valor 2"
  },
  State_124278_Desc = {
    Text = "Visualização de valores intermediários no processo de execução."
  },
  State_124278_Name = {
    Text = "Imprimir Valor 4"
  },
  State_124279_Desc = {
    Text = "Visualização de valores intermediários no processo de execução."
  },
  State_124279_Name = {
    Text = "Imprimir Valor 5"
  },
  State_124280_Desc = {
    Text = "Visualização de valores intermediários no processo de execução."
  },
  State_124280_Name = {
    Text = "Imprimir Valor 1"
  },
  State_124282_Desc = {
    Text = "Visualização de valores intermediários no processo de execução."
  },
  State_124282_Name = {
    Text = "Imprimir Valor 7"
  },
  State_124283_Desc = {
    Text = "Visualização de valores intermediários no processo de execução."
  },
  State_124283_Name = {
    Text = "Imprimir Valor 8"
  },
  State_124284_Desc = {
    Text = "Visualização de valores intermediários no processo de execução."
  },
  State_124284_Name = {
    Text = "Imprimir Valor 9"
  },
  State_124285_Desc = {
    Text = "Visualização de valores intermediários no processo de execução."
  },
  State_124285_Name = {
    Text = "Imprimir Valor 10"
  },
  State_124286_Desc = {
    Text = "Visualização de valores intermediários no processo de execução."
  },
  State_124286_Name = {
    Text = "Imprimir Valor 6"
  },
  State_124287_Desc = {
    Text = "Visualização de valores intermediários no processo de execução."
  },
  State_124287_Name = {
    Text = "Imprimir Valor 3"
  },
  State_124736_Desc = {
    Text = "Verifique se o parâmetro 3 da interface BEAttachPostAction filtra ou aciona corretamente o gatilho correspondente."
  },
  State_124736_Name = {
    Text = "Teste do Ouvinte 1"
  },
  State_124747_Desc = {
    Text = "Verifique se o parâmetro 3 da interface BEAttachPostAction filtra ou aciona corretamente o gatilho correspondente."
  },
  State_124747_Name = {
    Text = "Teste do Ouvinte 2"
  },
  State_124748_Desc = {
    Text = "Quando o inimigo jogar cartas <BurningKeywords:queima>, conceda a si mesmo 1 pilha de <MonsterExFlameKeywords:combustão>, mas reduza temporariamente [DescArg1] <PowerIconKeywords:FOR>."
  },
  State_124748_Name = {
    Text = "Chama que não se apaga"
  },
  State_124752_Desc = {
    Text = "Verifique se o parâmetro 3 da interface BEAttachPostAction filtra ou aciona corretamente o gatilho correspondente."
  },
  State_124752_Name = {
    Text = "Teste do Ouvinte 3"
  },
  State_124753_Desc = {
    Text = "Verifique se o parâmetro 3 da interface BEAttachPostAction filtra ou aciona corretamente o gatilho correspondente."
  },
  State_124753_Name = {
    Text = "Teste do Ouvinte 4"
  },
  State_124754_Desc = {
    Text = "Verifique se o parâmetro 3 da interface BEAttachPostAction filtra ou aciona corretamente o gatilho correspondente."
  },
  State_124754_Name = {
    Text = "Teste do Ouvinte 5"
  },
  State_124765_Desc = {
    Text = "Taxa crítica aumenta em [Layer] %"
  },
  State_124765_Name = {
    Text = "Taxa de Crítico"
  },
  State_124766_Desc = {
    Text = "Durante esta batalha, a taxa crítica aumenta em [Layer]%"
  },
  State_124766_Name = {
    Text = "Taxa de Crítico"
  },
  State_124766_WeaponDesc = {
    Text = "Durante esta batalha, a taxa crítica aumenta em [Layer]%"
  },
  State_124767_Desc = {
    Text = "Dano Crítico +[Layer]%"
  },
  State_124767_Name = {
    Text = "Dano crítico"
  },
  State_124811_Desc = {
    Text = "Verifique se o parâmetro 3 da interface BEAttachPostAction filtra ou aciona corretamente o gatilho correspondente."
  },
  State_124811_Name = {
    Text = "Teste do Ouvinte 8"
  },
  State_124812_Desc = {
    Text = "Verifique se o parâmetro 3 da interface BEAttachPostAction filtra ou aciona corretamente o gatilho correspondente."
  },
  State_124812_Name = {
    Text = "Teste do Ouvinte 7"
  },
  State_124813_Desc = {
    Text = "Verifique se o parâmetro 3 da interface BEAttachPostAction filtra ou aciona corretamente o gatilho correspondente."
  },
  State_124813_Name = {
    Text = "Teste do Ouvinte 6"
  },
  State_124826_Desc = {
    Text = "Verifique se o parâmetro 3 da interface BEAttachPostAction filtra ou aciona corretamente o gatilho correspondente."
  },
  State_124826_Name = {
    Text = "Teste do Ouvinte 9"
  },
  State_124843_Desc = {
    Text = "Verifique os ouvintes dos gatilhos BSTAfterAttachPostAction e BSTAfterDoActiveDamage.AttachPostAction"
  },
  State_124843_Name = {
    Text = "Teste do Ouvinte 9"
  },
  State_124886_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após o portador jogar um cartão de habilidade, compre [StateArg1] cartas, priorizando cartas de outros Despertadores. O efeito pode ser ativado apenas uma vez por turno."
  },
  State_124886_Name = {
    Text = "Roda do Destino"
  },
  State_124887_Desc = {
    Text = "O número de Danos de \"têxtil\" deste Corpo Desperto aumenta em [Layer]."
  },
  State_124887_Name = {Text = "Textile"},
  State_124888_Desc = {
    Text = "Transforma-se em uma \"Habilidade\" inimiga aleatória com custo -1 após ser disparada."
  },
  State_124888_Name = {
    Text = "<CardKeyWord:Profecia>"
  },
  State_124890_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após \"Exaltar\", faça a próxima \"Habilidade\" [StateArg1] jogada ativar 2 vezes."
  },
  State_124890_Name = {
    Text = "Trama Eterna"
  },
  State_124892_Name = {
    Text = "<CardKeyWord:Profecia>"
  },
  State_124916_Desc = {
    Text = "No final do turno, remove todas as capas e causa [DescArg1] de dano passivo. Não pode ser dissipado."
  },
  State_124916_Name = {
    Text = "Morte do Destino"
  },
  State_124917_Desc = {
    Text = "No final do turno, remove todas as capas e causa dano passivo. Não pode ser dissipado."
  },
  State_124917_Name = {
    Text = "<PVPDestinedDeathKeyWords:Morte do Destino>"
  },
  State_124992_Desc = {
    Text = "As próximas [DescArg1] cartas de \"Habilidade\" têm efeito 1 vez adicional."
  },
  State_124992_Name = {
    Text = "Transcender"
  },
  State_124993_Desc = {
    Text = "Dano ativo fatal causado e recebido é aplicado como uma quantidade igual de <PVPDestinedDeathKeyWords:Presságio Destinado>. Não pode ser dissipado."
  },
  State_124993_Name = {
    Text = "Moira, Como Eu Decreto"
  },
  State_124997_Desc = {
    Text = "O Dano ativo letal causado ou recebido é convertido em aplicar a mesma quantidade de <PVPDestinedDeathKeyWords:Presságio Destinado>. Não pode ser dissipado."
  },
  State_124997_Name = {
    Text = "<PVPEternalDimensionKeyWords:Destino, conforme esta revelação>"
  },
  State_125002_Name = {
    Text = "Estado@Ouvinte do Valor do Escudo Após a Fase de Descarte Geral do Jogador"
  },
  State_125003_Name = {
    Text = "Valor do Escudo"
  },
  State_125004_Name = {
    Text = "Estado@Contagem de escudo aplicada ao jogador"
  },
  State_125472_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após «Explosão de Fúria», aplica [StateArg1] camadas de <PVPLostSoulKeyWords:êxtase> ao inimigo com <HPAndShieldMax:maior vida e escudo>."
  },
  State_125472_Name = {
    Text = "Isca da Magnólia"
  },
  State_125486_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após \"Fúria Explosiva\" de outros aliados, reduza o Consumo de potência de cálculo de todas as \"Habilidades\" do Portador na mão em [StateArg1]."
  },
  State_125486_Name = {
    Text = "Vãos Arrependimentos"
  },
  State_125925_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_125925_Name = {
    Text = "Ainda não despertado"
  },
  State_125926_Name = {
    Text = "Estado@Monstro Tawil Intenção de Troca Jogador Ouvinte"
  },
  State_125927_Desc = {
    Text = "Após jogar [DescArg1] cartas de comando, mude a intenção para \"Seis Asas\"."
  },
  State_125927_Name = {
    Text = "Quatro asas nascem gradualmente"
  },
  State_125928_Desc = {
    Text = "Após jogar uma Carta de Comando, sele o Exaltação do Despertador correspondente e todas as Cartas de Comando por 2 turnos."
  },
  State_125928_Name = {
    Text = "Asas que Transpõem a Linha do Tempo"
  },
  State_125929_Desc = {
    Text = "Após receber [DescArg1] de DANO em um único turno, ganhe 70 camadas de <ReinforceColour:Fortaleza> temporária e 1 pilha de <ResentChainsKeywords:Correntes de Ressentimento>."
  },
  State_125929_Name = {
    Text = "Existência inexistente"
  },
  State_125933_Desc = {
    Text = "Após jogar [DescArg1] Cartas de Comando, mude a intenção para \"Quatro Asas\"."
  },
  State_125933_Name = {
    Text = "Asas se abrindo pela primeira vez"
  },
  State_125934_Desc = {
    Text = "Ao consumir poder de cálculo, a energia da chave de prata obtida é reduzida em 50%. Após Tawil causar dano não bloqueado, coloque 1 carta de \"<DerivativeCardKeywords_131:Verdadeiro·Paradoxo do Ciclo de Reencarnação>\" em sua mão."
  },
  State_125934_Name = {
    Text = "Atravessar a Porta da Chave de Prata"
  },
  State_125935_Name = {Text = "Silêncio"},
  State_125935_WeaponDesc = {
    Text = "Ao comprá-lo, fique vulnerável por 1 rodada. Após o uso, fique vulnerável a todos os inimigos por 1 rodada. Não pode ser vendido"
  },
  State_125937_Desc = {
    Text = "Após jogar uma Carta de Comando, sele o Exaltação do Despertador correspondente e todas as Cartas de Comando por 2 turnos."
  },
  State_125937_Name = {
    Text = "Asas que Transpõem a Linha do Tempo"
  },
  State_125964_Desc = {
    Text = "Ao consumir Poder de cálculo, a Energia de chave obtida –50%. Após Tawil causar Dano não bloqueado, coloca 1 \"<DerivativeCardKeywords_131:Verdadeiro·Paradoxo do Ciclo de Reencarnação>\" na mão."
  },
  State_125964_Name = {
    Text = "Atravessar a Porta da Chave de Prata"
  },
  State_126010_Desc = {
    Text = "Equipe única: O veneno fixo e os efeitos de veneno causados pelo portador aumentam em <WeaponEffect_Num:[StateArg1]%>, e a <EmbryoFusionIconKeywords:Fusão do Embrião> restaurada automaticamente no Reino Caro é aumentada em <WeaponEffect_Num:[StateArg2]%.> Na primeira vez que o portador ativa \"Ressonância\" a cada turno, outros Despertadores ganham <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_126010_WeaponDesc = {
    Text = "O Efeito de Envenenamento fixo e de ativação de Envenenamento causados pelo Portador aumentam em <WeaponEffect_Num:[StateArg1]%>, e a <EmbryoFusionIconKeywords:Fusão de embriões> recuperada automaticamente pelo Domínio de Carne e sangue aumenta em <WeaponEffect_Num:[StateArg2]%>. Quando o Portador ativa \"Ressonância\" pela primeira vez em cada turno, os outros Corpos Despertos obtêm <WeaponEffect_Num:[StateArg3]> pontos de Fúria."
  },
  State_126463_Name = {
    Text = "Estado@Monstro Liz Captura de Mariposas Ouvinte de Dano de Fogo"
  },
  State_126464_Desc = {
    Text = "Máximo de 10 camadas, cada camada aumenta o dano causado por Liz em [DescArg1] pontos."
  },
  State_126464_Name = {
    Text = "<GreenWord:Faísca Verdejante>"
  },
  State_126465_Name = {
    Text = "Monitoramento da Intenção do Monstro Liz"
  },
  State_126466_Desc = {
    Text = "Seu oponente não descartará cartas no final de seu turno. Ao mudar para a intenção Chamas Verdes, se você tiver pelo menos 6 pilhas de <MonsterLizVerdantSpark:Brasa Esmeralda>, consuma 6 pilhas para atualizar a intenção para \"Chamas Mortais\" que causa <Damage:[Damage:DescArg1]> de DANO [AttackTimes:DescArg2] vezes; se você tiver pelo menos 3 pilhas, consuma 3 pilhas para atualizar a intenção para \"Chamas Corrompidas\" que causa <Damage:[Damage:DescArg3]> de DANO [AttackTimes:DescArg4] vezes."
  },
  State_126466_Name = {
    Text = "Chama Verde Imortal"
  },
  State_126467_Desc = {
    Text = "Este despertador ainda não despertou... Eles vão despertar quando estiverem prestes a ser derrotados, restaurar HP e lutar com toda a força, concedendo a habilidade de remover estados negativos para \"Dança para a Destruição.\""
  },
  State_126467_Name = {
    Text = "Ainda não despertado"
  },
  State_126468_Name = {
    Text = "State@Monstro Liz Reflexão Esmeralda Gestão"
  },
  State_126469_Desc = {
    Text = "Para cada [DescArg1] de HP perdido, ganhe [DescArg2] pilha(s) de <MonsterLizVerdantSpark:Brasa Esmeralda>."
  },
  State_126469_Name = {
    Text = "Imagem de Esmeralda"
  },
  State_126470_Name = {
    Text = "Estado@monstro Liz Dica Contador"
  },
  State_126479_Desc = {
    Text = "Máximo de 10 pilhas, aumenta o DMG causado por Liz."
  },
  State_126479_Name = {
    Text = "<GreenWord:Faísca Verdejante>"
  },
  State_126540_Desc = {
    Text = "Quando Xu ativa \"Ressonância\" [Layer] vezes, o efeito de \"Ressonância\" é duplicado."
  },
  State_126540_Name = {
    Text = "Voto na Névoa"
  },
  State_126568_Desc = {
    Text = "Cada vez que um Despertador causa dano ativo, ordene a 1 Tentáculo atacar o alvo, causando [Layer]% de dano de Tentáculo."
  },
  State_126568_Name = {
    Text = "Ondas furiosas"
  },
  State_126569_Desc = {
    Text = "Cada vez que o Corpo Desperto causar Dano ativo, ordene 1 tentáculo a atacar o alvo, causando 50% de Dano de tentáculo."
  },
  State_126569_Name = {
    Text = "Ondas furiosas"
  },
  State_126643_Desc = {
    Text = "Este estado MaxLayer=1. Fonte Despertador: [DescArg1]"
  },
  State_126643_Name = {
    Text = "Limite de nível 1"
  },
  State_126644_Desc = {
    Text = "Após obter, limpe e reaplique [Layer] camadas do estado de demonstração. \n O número máximo de camadas para o estado de demonstração é 1 camada."
  },
  State_126644_Name = {
    Text = "Superar o número máximo de camadas"
  },
  State_126645_Desc = {
    Text = "O Dano base de Ramona aumenta em [DescArg1]%"
  },
  State_126645_Name = {
    Text = "Tempera Sublime"
  },
  State_126651_Desc = {
    Text = "O ouvinte após liberar a Perseguição ficou satisfeito [Layer] vezes."
  },
  State_126651_Name = {Text = "Contador"},
  State_126652_Desc = {
    Text = "Após obtê-lo, faça com que os inimigos da linha de frente adicionem uma ação atrasada, disparando sua intenção atual."
  },
  State_126652_Name = {
    Text = "Fazer o monstro perseguir"
  },
  State_126653_Desc = {
    Text = "Após obtê-lo, faça com que o corpo desperto na posição 1 adicione uma ação atrasada para disparar sua carta de golpear."
  },
  State_126653_Name = {
    Text = "Fazer o Corpo Desperto perseguir"
  },
  State_126654_Desc = {
    Text = "Quando o Ouvinte Nomeado é acionado, imprima a contagem 1 vez."
  },
  State_126654_Name = {
    Text = "Ouvinte Nomeado"
  },
  State_126655_Desc = {
    Text = "Após obtê-lo, faça com que o Guardião do Segredo adicione uma ação atrasada, disparando a habilidade @Habilidade do Protagonista@Voz na mente."
  },
  State_126655_Name = {
    Text = "Ordenar o Guardião a perseguir"
  },
  State_126677_Desc = {
    Text = "Neste turno, o próximo [Layer] \"Lâmina da Desafiante\" terá efeito duplo."
  },
  State_126677_Name = {
    Text = "Leviatã Primal"
  },
  State_126678_WeaponDesc = {
    Text = "Todas as vezes que Salto da Baleia causa dano +1"
  },
  State_126714_Desc = {
    Text = "Aigis's próximo [Layer] \"Defesa\" tem efeito 3 vezes."
  },
  State_126714_Name = {
    Text = "Lágrima cristalizada"
  },
  State_126714_WeaponDesc = {
    Text = "Todas as vezes que Salto da Baleia causa dano +1"
  },
  State_126715_WeaponDesc = {
    Text = "Todas as vezes que Salto da Baleia causa dano +1"
  },
  State_126776_Desc = {
    Text = "Para cada pilha, o Veneno fixo recebido aumenta em 5%, o Dano causado diminui em [DescArg1]%, até [DescArg2] pilhas."
  },
  State_126776_Name = {
    Text = "<WitherKeywords:Encantado>"
  },
  State_126783_Name = {
    Text = "Desativado temporariamente"
  },
  State_126784_Desc = {
    Text = "Aumenta o veneno fixo recebido em [DescArg1]%, reduz o dano causado em [DescArg2]%, até [DescArg3] camadas."
  },
  State_126784_Name = {Text = "Spellbound"},
  State_126785_Desc = {
    Text = "Se outros Despertadores acumularem X cartas de comando jogadas, ative os seguintes efeitos após jogar. Reinicie sua contagem de Ressonância após jogar suas próprias cartas de comando ou no final do seu turno."
  },
  State_126785_Name = {
    Text = "<ResonanceKeywords:Ressonância X>"
  },
  State_126789_Desc = {
    Text = "Inflige 2 camadas de <WitherKeywords:encantado> a todos os inimigos."
  },
  State_126789_Name = {
    Text = "<WitherKeywords1:Betroth>"
  },
  State_126790_Desc = {
    Text = "Remova todos os <WitherKeywords:Embriagado> dos inimigos, cada pilha removida causa [DescArg1]% da Vida máxima do alvo como Dano Fixo e ativa 40% de envenenamento."
  },
  State_126790_Name = {
    Text = "<WitherKeywords2:Enredar>"
  },
  State_126803_Desc = {
    Text = "As próximas cartas de comando [DescArg1] jogadas serão enviadas para o futuro 3 turnos à frente."
  },
  State_126803_Name = {
    Text = "Roda do destino"
  },
  State_126893_Name = {
    Text = "Estado@destino Ultra Puro Identificador"
  },
  State_126895_Desc = {
    Text = "O Dano Final desta carta, o ganho fixo de <PowerIconKeywords:STR> & <TentacleInjurieIconKeywords:Dano de tentáculo>, o <IntoxicationIconKeywords:Envenenamento> & <RetaliateIconKeywords:Contrataque> fixo cada +[DescArg1]%; O Escudo Fixo Final desta carta, a Recuperação de Vida Fixa e a <ExhaustionIconKeywords:Redução de força> cada +[DescArg2]%. Cartas com \"Faro de Singularidade\" não podem acionar a \"Lançadeira Dimensional\"."
  },
  State_126895_Name = {
    Text = "<SingularityKeywords:Faro de Singularidade [DescArg2]>"
  },
  State_126896_Name = {
    Text = "Estado@Luz da Transcendência carta reduz capas de ajuste de potência de cálculo"
  },
  State_126900_Name = {
    Text = "Estado@destino Ultra Inicialização de Classe 2"
  },
  State_126901_Name = {
    Text = "Estado@destino Ultra Inicialização de Classe 1"
  },
  State_126903_Name = {
    Text = "Estado@Espaço HiperdimensionalTelecinese Marcador"
  },
  State_126927_Desc = {
    Text = "Único na equipe: O veneno fixo e os gatilhos de efeito de veneno do portador são aumentados em <WeaponEffect_Num:[StateArg1]%.> O portador ganha <WeaponEffect_Num:[StateArg2]> Aliemus na primeira vez que ativa \"Ressonância\" a cada turno."
  },
  State_126927_WeaponDesc = {
    Text = "Os efeitos de Veneno Fixo e de veneno do portador são aumentados em <WeaponEffect_Num:[StateArg1]%.> O portador ganha <WeaponEffect_Num:[StateArg2]> Aliemus na primeira vez que ativar \"Ressonância\" a cada turno."
  },
  State_126990_Name = {
    Text = "<IntoxicationColour: Envenenado>"
  },
  State_127108_Desc = {
    Text = "Inflige 5 camadas de <WitherKeywords:encantado> a todos os inimigos."
  },
  State_127108_Name = {
    Text = "<WitherKeywords3:Betroth>"
  },
  State_127109_Desc = {
    Text = "Remova todos os <WitherKeywords:Embriagado> dos inimigos, cada pilha removida acumula 20% de Constituição no Forno Carmesim, causa [DescArg1]% da Vida máxima do alvo como Dano Fixo e ativa 40% de Envenenamento."
  },
  State_127109_Name = {
    Text = "<WitherKeywords4:Enfeitiçar>"
  },
  State_127176_Desc = {
    Text = "Para cada pilha, o Veneno fixo recebido aumenta em 5%, o Dano causado diminui em [DescArg1]%, até [DescArg2] pilhas."
  },
  State_127176_Name = {
    Text = "<WitherKeywords0:Encantado>"
  },
  State_127264_Desc = {
    Text = "Ao jogar esta carta, o \"Perceptor\" ganha 1 pilha de <MonsterTimeBeacon:Loop>. Se esta carta for descartada, o \"Perceptor\" perde 1 pilha de <MonsterTimeBeacon:Loop>."
  },
  State_127264_Name = {
    Text = "<MonsterSightUnbound:Visão Desvinculada>"
  },
  State_127266_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_127266_Name = {
    Text = "Ainda não despertado"
  },
  State_127267_Desc = {
    Text = "No final do turno, ganhe 1 pilha de <MonsterTimeBeacon:Ciclo>."
  },
  State_127267_Name = {
    Text = "Inversão do aumento de entropia"
  },
  State_127271_Desc = {
    Text = "Após liberar Posse, ganhe 1 pilha de <MonsterTimeBeacon:Loop>."
  },
  State_127271_Name = {
    Text = "Prisioneiro de Mobius"
  },
  State_127272_Desc = {
    Text = "Máximo de 3 pilhas. Quando o \"Perceptor\" libera uma Intenção com 3 pilhas de <MonsterTimeBeacon:Loop>, acione o efeito <MonsterTimeBeacon:Loop>, limpe o <MonsterTimeBeacon:Loop> e remova estados negativos."
  },
  State_127272_Name = {
    Text = "<WhiteWord:Ciclo>"
  },
  State_127275_Desc = {
    Text = "Para cada pilha, o Veneno fixo recebido aumenta em 5%, o Dano causado diminui em [DescArg1]%, até [DescArg2] pilhas."
  },
  State_127275_Name = {
    Text = "<WitherKeywords:Encantado>"
  },
  State_127276_Desc = {
    Text = "Ao jogar esta carta, o \"Perceptor\" ganha 1 pilha de <MonsterTimeBeacon:Loop>. Se esta carta for descartada, o \"Perceptor\" perde 1 pilha de <MonsterTimeBeacon:Loop>."
  },
  State_127276_Name = {
    Text = "<MonsterSightUnbound:Visão Desvinculada>"
  },
  State_127312_Desc = {
    Text = "Quando a Onda Psíquica do Despertador atinge +12, o \"Axioma Absoluto\" é ativado, concedendo efeitos únicos."
  },
  State_127312_Name = {
    Text = "<UltraPotencyKeywords:Regra Final>"
  },
  State_127705_Desc = {
    Text = "A carta foi adulterada! Recebe [Layer] de dano ao ser disparada. Reduz as capas de <CardKeyWord:Sabotagem> pela metade."
  },
  State_127705_Name = {
    Text = "<CardKeyWord:Destruição Secreta>"
  },
  State_127705_WeaponDesc = {
    Text = "Após jogar a carta, sofre [StateArg1] de dano"
  },
  State_127708_Desc = {
    Text = "Após o inimigo Disparar uma carta não-Carta de comando, todos os aliados ganham [DescArg1] <plural value=\"[DescArg1]\" singular=\"camada\" plural=\"camadas\"> de <PowerIconKeywords:Força>. Efeito expira após as Cinzas antigas serem rompidas."
  },
  State_127708_Name = {
    Text = "Fios do Caos"
  },
  State_127709_Name = {
    Text = "Estado do jogador das Fios Negros"
  },
  State_127710_Name = {
    Text = "Gatilho do fio negro"
  },
  State_128026_Name = {
    Text = "Estado do jogador de fios brancos"
  },
  State_128027_Desc = {
    Text = "Após o inimigo disparar a Carta de comando, todos os aliados ganham [DescArg1] camadas temporárias de <ReinforcePVEKeywords:reforço>. As Cinzas antigas perdem efeito após serem rompidas."
  },
  State_128027_Name = {
    Text = "Fios da Lei"
  },
  State_128028_Desc = {
    Text = "A carta foi adulterada! Ao ser disparada, receba <FixedDamage:Dano Puro> e reduza as capas de <BrokenCard:Sabotagem> pela metade."
  },
  State_128028_Name = {
    Text = "<CardKeyWord:Dano Oculto>"
  },
  State_128028_WeaponDesc = {
    Text = "Após jogar a carta, sofre [StateArg1] de dano"
  },
  State_128029_Name = {
    Text = "Gatilho do fio branco"
  },
  State_128067_Name = {
    Text = "Estado@Servente Aranha Fria Cinzas Ouvinte"
  },
  State_128069_Name = {
    Text = "Estado@Detecção de Acerto de Enrolar da Servente da Aranha Fria"
  },
  State_128071_Name = {
    Text = "Estado@É necessário um marcador de invocação na posição de servente aranha fria"
  },
  State_128073_Desc = {
    Text = "Após cada ação, ganha [DescArg1] camadas de <ParcloseIconKeywords:barreira> e [DescArg2] camadas de <Chapter5_Monster_Fervor1:Fervor>."
  },
  State_128073_Name = {
    Text = "Berço da Mãe Tecelã"
  },
  State_128082_Desc = {
    Text = "Após jogar, hameln ganha 3 de aliemus"
  },
  State_128082_Name = {
    Text = "<XushiBKeywords:Som Acumulado>"
  },
  State_128086_Desc = {
    Text = "Após o inimigo Disparar uma Carta de comando, ganhe [DescArg1] <plural value=\"[DescArg1]\" singular=\"camada\" plural=\"camadas\"> de <Chapter5_Monster_Fervor1:Fervor>, e troque de posição com um aliado na retaguarda após \"Cinzas antigas\" serem esgotadas."
  },
  State_128086_Name = {
    Text = "Roda do Destino"
  },
  State_128087_Name = {
    Text = "Estado@Servente Aranha Fria: Marca de Desencadeamento do Ciclo Branco"
  },
  State_128089_Name = {
    Text = "Ressurreição Branca ativada"
  },
  State_128216_Name = {
    Text = "Estado do jogador do ciclo branco"
  },
  State_128245_Desc = {
    Text = "No início do turno, limpe. Após atingir 10 capas, ao jogar a próxima carta, ative imediatamente, remova <Chapter5_Monster_Fervor2:Fervor> e troque a intenção para infligir <FragileIconKeywords:Frágil> e anexar aleatoriamente <BrokenCard:Sabotagem> \"Fio do Colapso\"."
  },
  State_128245_Name = {
    Text = "Fervor temporário"
  },
  State_128246_Name = {
    Text = "Estado do jogador do ciclo negro"
  },
  State_128247_Desc = {
    Text = "Ressuscita após a morte com Imunidade ao dano e 100% de Vida. Troca a intenção para \"Fervor do Destino\": Após cada ação, ganha [DescArg1] <PowerIconKeywords:Força> e [DescArg2] <Chapter5_Monster_Fervor2:Fervor>."
  },
  State_128247_Name = {
    Text = "Emergência"
  },
  State_128248_Desc = {
    Text = "No início do turno, limpe. Após atingir 10 camadas, ao Disparar uma carta na próxima vez, ative imediatamente, remova <Chapter5_Monster_Fervor1:Fervor> e mude a intenção para \"Rede de Restrição\", que inflige <WeaknessIconKeywords:Enfraquecer> e sela aleatoriamente Cartas de comando."
  },
  State_128248_Name = {
    Text = "Fervor temporário"
  },
  State_128250_Name = {
    Text = "Ciclo Negro Ativado"
  },
  State_128251_Desc = {
    Text = "Após o inimigo jogar uma carta que não seja de Carta de comando, ganhe [DescArg1] <plural value=\"[DescArg1]\" singular=\"capa\" plural=\"capas\"> de <Chapter5_Monster_Fervor1:Fervor>, e troque de posição com um aliado na retaguarda após \"Cinzas antigas\" se esgotar."
  },
  State_128251_Name = {
    Text = "Roda do Abismo"
  },
  State_128253_Desc = {
    Text = "Ressurreição após a morte, imunidade ao Dano e 100% de Vida. Muda a intenção para \"Fervor do Destino\": Após cada ação, ganhe [DescArg1] <plural value=\"[DescArg1]\" singular=\"camada\" plural=\"camadas\"> de <ParcloseIconKeywords:Barreira> e [DescArg2] <plural value=\"[DescArg2]\" singular=\"camada\" plural=\"camadas\"> de <Chapter5_Monster_Fervor1:Fervor>."
  },
  State_128253_Name = {
    Text = "Emergência"
  },
  State_128257_Desc = {
    Text = "Após cada ação, ganhe [DescArg1] pontos de <PowerIconKeywords:força> e [DescArg2] camadas de <Chapter5_Monster_Fervor2:Fervor>."
  },
  State_128257_Name = {
    Text = "Sussurro da Mãe Tecelã"
  },
  State_128643_Name = {
    Text = "Estado@contagemDeSintomasJogadorNesteTurno"
  },
  State_128644_Desc = {
    Text = "Remova no início do turno. Ao alcançar 10 camadas, após disparar a próxima carta, ative imediatamente, remova <Chapter5_Monster_Fervor3:Fervor> e mude aleatoriamente a intenção."
  },
  State_128644_Name = {
    Text = "Fervor temporário"
  },
  State_128645_Desc = {
    Text = "A intenção será escolhida aleatoriamente entre quatro intenções, mas não se repetirá. Após liberar a Fúria Explosiva, a intenção muda imediatamente. Ao disparar uma Carta de comando, ganhe 1 camada de <Chapter5_Monster_Fervor3:Fervor>."
  },
  State_128645_Name = {
    Text = "Sincronização das mil faces"
  },
  State_128646_Name = {
    Text = "Estado@destino confuso desclassificação golpe pesado detecção de cartas jogadas"
  },
  State_128648_Desc = {
    Text = "Até o início da próxima rodada, a cada carta de comando jogada, ganhe [DescArg1] de <PowerIconKeywords:força> temporária."
  },
  State_128648_Name = {
    Text = "Casulo da Fúria"
  },
  State_128692_Desc = {
    Text = "Após sofrer dano ativo ou dano de tentáculo, remova uma quantidade equivalente de \"Cinzas Antigas\" e perca 300% da quantidade removida em vida. Ao sofrer outros tipos de dano, remova apenas metade. As camadas de \"Cinzas Antigas\" são redefinidas a cada turno."
  },
  State_128692_Name = {
    Text = "<AshesPastKeyWord:Cinzas antigas>"
  },
  State_128695_Name = {
    Text = "Estado@Intenção do Destino Desordenado"
  },
  State_129297_Desc = {
    Text = "No início das próximas [Layer] batalhas, reduza a vida de todos os inimigos para 1."
  },
  State_129297_Name = {
    Text = "Apoio do pequeno \"N\""
  },
  State_129569_Name = {
    Text = "Estado@Teatro da Alegria do Destino Caótico Marcador"
  },
  State_129570_Name = {
    Text = "Estado@Destino Deslocado Sussurro Marcador de Ativação"
  },
  State_129571_Name = {
    Text = "Estado@destino desordenado Nenhum Fim do Nada ativar marcador"
  },
  State_129612_Desc = {
    Text = "A intenção será escolhida aleatoriamente entre quatro intenções, mas não se repetirá. Após liberar a Fúria Explosiva, a intenção será trocada imediatamente. Ao disparar uma Carta de comando, ganhe 1 camada de <Chapter5_Monster_Fervor3:Fervor>."
  },
  State_129612_Name = {
    Text = "Sincronização de mil faces"
  },
  State_129625_Desc = {
    Text = "A intenção será escolhida aleatoriamente entre quatro tipos, mas não se repetirá. Mude imediatamente as intenções após liberar um Exalt. Ganhe 1 pilha de <Chapter5_Monster_Fervor3:Fervor> após jogar uma Carta de Comando. Ganhe 1 pilha de \"Fusão de Distorção\" cada vez que a intenção for mudada."
  },
  State_129625_Name = {
    Text = "Sincronização de mil faces"
  },
  State_129643_Desc = {
    Text = "A cada troca de intenção, ganha 1 capa. Quando tiver 10 capas de \"Destino Desfeito\", a intenção muda para a imutável \"Emergência Frenética\", que causa Dano massivo e inflige debuffs."
  },
  State_129643_Name = {
    Text = "Destino Torcido"
  },
  State_129644_Name = {
    Text = "Intenção de Bloqueio de Fusão Distorcida"
  },
  State_129650_Desc = {
    Text = "Equipe Única: Se o Portador for o Corpo Desperto \"Ramona: Desgastada\", a Taxa de Sincronização obtida pelos outros Corpos Despertos ao completar o estágio +<WeaponEffect_Num:[StateArg1]%>, mas o Portador não obtém nenhuma Taxa de Sincronização."
  },
  State_129650_WeaponDesc = {
    Text = "Se o Portador for o Corpo Desperto \"Ramona: Desgastada\", ao concluir uma fase, os outros Corpos Despertos ganham +<WeaponEffect_Num:[StateArg1]%> de Taxa de Sincronização, mas o Portador não ganha nenhuma Taxa de Sincronização."
  },
  State_129761_Desc = {
    Text = "Modifique o valor de retorno da interface de intensidade de crescimento dos jogadores no jogo, aumentando 1% para cada camada."
  },
  State_129761_Name = {
    Text = "Correção da intensidade de crescimento dentro da partida"
  },
  State_129845_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_129845_Name = {
    Text = "Ainda não despertado"
  },
  State_129846_Name = {
    Text = "Contagem de Oscilação Espacial"
  },
  State_129848_Desc = {
    Text = "Sempre que [DescArg1] cartas saírem da Fissura Dimensional, conceda a elas [DescArg2] camadas<BrokenCard:Destruição Oculta>."
  },
  State_129848_Name = {
    Text = "Inauguração do teatro de marionetes"
  },
  State_129849_Desc = {
    Text = "Gere uma cópia da primeira carta de comando jogada pelo inimigo em cada turno e coloque-a na Fissura Dimensional. Quando a carta entrar na Fissura Dimensional, conceda-lhe <DepleteIconKeywords:Consumo>. A primeira Ordem de chave liberada em cada turno retirará a carta mais à esquerda e a colocará no topo do mazo de robo."
  },
  State_129849_Name = {
    Text = "Tecendo o Destino"
  },
  State_129850_Desc = {
    Text = "Para cada carta de comando na Fissura Dimensional, o limite de cartas na mão do jogador é reduzido em 1. Se já estiver cheio, na próxima vez que uma carta for disparada, a \"Teia Eterna\" agirá imediatamente, e após a ação, a Fissura Dimensional será esvaziada, ajustando a intenção para \"Trágico canto da superioridade do destino\"."
  },
  State_129850_Name = {
    Text = "Oscilação Espacial"
  },
  State_129854_Desc = {
    Text = "Em cada Fissura Dimensional onde houver uma Carta de comando, o limite de cartas na mão do jogador diminui em 1. Se já estiver cheio, na próxima vez que disparar uma Carta, a \"Teia Eterna\" agirá imediatamente, e após a ação, a Fissura Dimensional será esvaziada, ajustando a intenção para \"Destino, conforme este aviso\"."
  },
  State_129854_Name = {
    Text = "Oscilação Espacial"
  },
  State_129864_Desc = {
    Text = "Sempre que jogar uma carta, remova 1 camada de \"sonolência\". No início do turno, restaure para 12 camadas de \"sonolência\"."
  },
  State_129864_Name = {Text = "Raiva"},
  State_129865_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_129865_Name = {
    Text = "Ainda não despertado"
  },
  State_129872_Desc = {
    Text = "Variável temporária."
  },
  State_129872_Name = {Text = "Contador1"},
  State_129873_Desc = {
    Text = "Obtém o estado de contagem da camada [Layer] _Contador de embalagem 1_."
  },
  State_129873_Name = {
    Text = "Teste de encapsulamento 1"
  },
  State_129874_Desc = {
    Text = "Variável temporária."
  },
  State_129874_Name = {
    Text = "Amplificador 1"
  },
  State_130358_Desc = {
    Text = "A próxima carta de comando jogada terá um efeito extra de 2 vezes."
  },
  State_130358_Name = {Text = "Marionete"},
  State_130387_Desc = {
    Text = "Depois que o \"Boneco de Marionete\" for consumido, a primeira carta de comando jogada em cada turno terá um efeito adicional de 2 vezes. Se for uma Batalha do Líder, todos os Corpos Despertos ganham 50 pontos de Fúria e 1000 pontos de Energia da Chave de Prata."
  },
  State_130387_Name = {
    Text = "Funeral do destino"
  },
  State_130388_Name = {
    Text = "<RetainIconKeywords:Preservar>: Ganhe [DescArg1] energia da chave de prata"
  },
  State_130389_Desc = {
    Text = "Disparar para fazer todos os Corpos Despertos ganharem [DescArg1] pontos de Fúria"
  },
  State_130389_Name = {
    Text = "Disparar para fazer todos os Corpos Despertos ganharem [DescArg1] pontos de Fúria"
  },
  State_130390_Desc = {
    Text = "Limite de capacidade de cálculo e limite de cartas na mão aumentados em 1."
  },
  State_130390_Name = {
    Text = "Perfil redundante"
  },
  State_130391_Desc = {
    Text = "Cada vez que disparar 1 \"Cartão de sintomas\", o consumo de potência de cálculo do \"Fantoche\" diminui em 1."
  },
  State_130391_Name = {
    Text = "Ecos de Impureza"
  },
  State_130490_Desc = {
    Text = "O dano, escudo, cura, força, exaustão, dano de tentáculo, envenenamento fixo e contrataque fixo causados por esta carta aumentam, multiplicando-se independentemente por 1+[Layer]%."
  },
  State_130490_Name = {
    Text = "Faro de Singularidadeα"
  },
  State_130498_Desc = {
    Text = "A próxima carta de comando jogada terá um efeito extra de 2 vezes."
  },
  State_130498_Name = {
    Text = "Funeral do destino"
  },
  State_130500_Desc = {
    Text = "Na Batalha do Líder, Resistência à Morte +100%. Após ativar \"Resistência à Morte\", na próxima rodada \"Marionete\" não será mais forçada a disparar a carta de comando, mas sim a escolher uma carta de comando na mão."
  },
  State_130500_Name = {
    Text = "O olhar do mártir"
  },
  State_130501_Desc = {
    Text = "O custo de poder da próxima carta de comando é reduzido para 0."
  },
  State_130501_WeaponDesc = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_130512_Desc = {
    Text = "A próxima carta de comando jogada terá efeito adicional 2 vezes e o consumo de potência de cálculo será reduzido em 2 pontos."
  },
  State_130512_Name = {Text = "Marionete"},
  State_130517_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Ao equipar e no início do turno, aciona aleatoriamente um dos seguintes Efeitos: obtém <Energy:[Energy:StateArg1]> de Fúria e aplica <PVPSlowKeywords:Desaceleração> a si mesmo; obtém <Energy:[Energy:StateArg3]> de Fúria; obtém <Energy:[Energy:StateArg4]> e [StateArg5] cartas de <PVPDerivativeCardKeywords_17:\"Inspiração\">."
  },
  State_130517_Name = {
    Text = "Sabedoria da Aposta"
  },
  State_131046_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Após \"Fúria Explosiva\", ganha <Block:[Block:StateArg1]> escudo e <DelayKeywords:Latência>: <Energy:[Energy:StateArg2]> Fúria."
  },
  State_131046_Name = {
    Text = "Jardim do Éden distante"
  },
  State_131047_Desc = {
    Text = "Nesta rodada, os próximos [Layer] usos de Bando terão efeito duas vezes."
  },
  State_131047_Name = {
    Text = "Ordem Dupla de Chave"
  },
  State_131048_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após usar uma «Habilidade» pela primeira vez em cada turno, causa <Damage:[Damage:StateArg1]> de dano ao inimigo com <HPAndShieldMin:menor vida e escudo>."
  },
  State_131048_Name = {
    Text = "Loucura aprisionada"
  },
  State_131055_Desc = {
    Text = "Desenhe -1 carta a cada turno. A recuperação de escudo e saúde de todos os Despertadores aumenta em 20%."
  },
  State_131055_Name = {
    Text = "Alinhar o cabelo"
  },
  State_131056_Desc = {
    Text = "Ao perder vida, converta uma quantidade igual de loucura retardada em escudo."
  },
  State_131056_Name = {
    Text = "Proteção de Vórtice"
  },
  State_131058_Desc = {
    Text = "Aumenta em 10 pontos a fúria base de todos os corpos despertos. Após liberar a Fúria Explosiva, ganha-se 1 Poder de cálculo; cada corpo desperto pode ser ativado apenas 1 vez por turno."
  },
  State_131058_Name = {
    Text = "Esfregar a bochecha"
  },
  State_131059_Name = {
    Text = "Marcador de melhoria do ultimate do Mosk"
  },
  State_131061_Desc = {
    Text = "Limite de Energia da Chave de Prata e Consumo de Tokens da Chave: Energia da Chave de Prata +350. O primeiro Token da Chave tem efeito 2 vezes a cada turno."
  },
  State_131061_Name = {
    Text = "Alimentação de petiscos"
  },
  State_131064_Desc = {
    Text = "Ganhe 1 Poder após liberar a Explosão de Frenesia, e cada Despertador só pode acioná-la uma vez por turno."
  },
  State_131064_Name = {
    Text = "Esfregar a bochecha"
  },
  State_131069_Desc = {
    Text = "A geração de escudo e a recuperação de HP de todos os Despertadores aumentam em +20%."
  },
  State_131069_Name = {
    Text = "Alinhar o cabelo"
  },
  State_131073_Desc = {
    Text = "Equipe Única: No início da batalha, ganha uma quantidade de Fúria equivalente a <WeaponEffect_Num:[StateArg1]%> da Fúria base. O Dano Final da Fúria Explosiva do portador aumenta em <WeaponEffect_Num:[StateArg2]%> da Fúria base. Ao mudar para a postura \"Onda de Ira\", ganha um Domínio de área temporário equivalente a <WeaponEffect_Num:[StateArg3]%> do Domínio de área atual, com um tempo de recarga de 3 turnos."
  },
  State_131073_WeaponDesc = {
    Text = "Ao começar a batalha, ganha [DescArg1] pontos de Fúria. O dano final da explosão de Fúria do portador aumenta em [DescArg2] %. Ao mudar para a postura \"Onda de Ira\", ganha [DescArg3] pontos de domínio de área temporário, com um tempo de recarga de 3 turnos(restante [DescArg4] turnos)."
  },
  State_131078_Desc = {
    Text = "A primeira ativação de Posse em cada turno tem efeito duplo."
  },
  State_131078_Name = {
    Text = "Alimentação de petiscos"
  },
  State_131118_Desc = {
    Text = "Cada vez que sofrer Dano ou perder Vida, o valor não pode exceder 5% da Vida máxima."
  },
  State_131118_Name = {
    Text = "Casulo do Destino"
  },
  State_131123_Desc = {
    Text = "Remova no início do turno. Ao alcançar 10 camadas, após disparar a próxima carta, ative imediatamente e mude para a próxima intenção, removendo <Chapter5_Monster_Fervor4:Fervor>."
  },
  State_131123_Name = {
    Text = "Fervor temporário"
  },
  State_131127_Desc = {
    Text = "Postura atada ao Destino. Cada vez que o inimigo Disparar 1 Carta de comando, a Arachne das trevas ganha 1 camada de \"Fervor temporário\"."
  },
  State_131127_Name = {
    Text = "Juramentador do destino"
  },
  State_131134_Desc = {
    Text = "Após a morte, Nefraea ganha [DescArg1] <plural value=\"[DescArg1]\" singular=\"capa\" plural=\"capas\"> de Fervor temporário, mas perde 3% de Vida máxima."
  },
  State_131134_Name = {Text = "Agitação"},
  State_131186_Desc = {
    Text = "Toma efeito 1 vez adicional, mas sofre [DescArg1] de Dano após ser Disparado."
  },
  State_131186_Name = {
    Text = "<ExclamationPointColour:destino fragmentado>"
  },
  State_131188_Desc = {
    Text = "A \"Habilidade\" Disparada entra na \"Fissura Dimensional\" e anexa \"Fragmento do destino\" a todas as Habilidades com o mesmo nome, removido ao sair da Fissura Dimensional. Quando a Fissura Dimensional estiver cheia, \"Teia da Traição\" Nefraea a limpa após a ação e transforma a próxima intenção em uma poderosa Fúria Explosiva."
  },
  State_131188_Name = {
    Text = "Fissura Dimensional"
  },
  State_131191_Name = {
    Text = "Transtorno cognitivo"
  },
  State_131242_Desc = {
    Text = "O dano, escudo, cura, força, exaustão, dano de tentáculo, envenenamento fixo e contrataque fixo causados por esta carta aumentam, multiplicando-se independentemente por 1+[Layer]%."
  },
  State_131242_Name = {
    Text = "Faro de Singularidade β"
  },
  State_131258_Desc = {
    Text = "Os fios da roda de fiar giram, perturbando o destino errado. Após Liberar uma Ordem de chave ou Disparar a Carta \"Destino Fragmentado\", remove 1 camada; ao remover todas as camadas, Arachne Libera o Perseguir \"Fios em Seus Lugares\", causando alto Dano. Após Liberar 3 vezes, o \"Casulo do Destino\" do inimigo será completamente destruído!"
  },
  State_131258_Name = {
    Text = "perturbação do destino"
  },
  State_131261_Name = {
    Text = "Teatro da Arachne"
  },
  State_131351_Desc = {
    Text = "Outros Corpos Despertos consomem 1 camada após liberar Fúria Explosiva, Mosk libera \"Vórtice! Fluxo! Tiro!\" para perseguir."
  },
  State_131351_Name = {
    Text = "Carregamento de redemoinho"
  },
  State_131439_Desc = {
    Text = "A próxima carta de comando disparada terá efeito adicional de 2 vezes e o consumo de potência de cálculo será reduzido para 0."
  },
  State_131439_Name = {Text = "Marionete"},
  State_131637_Desc = {
    Text = "Ao morrer, invoca um \"Enxame de Aranhas Abissais\" ou \"Enxame de Aranhas Frias\" aleatório, reduzindo seu \"Efeito de enxame\" em 1 pilha."
  },
  State_131637_Name = {
    Text = "Efeito de enxame"
  },
  State_131638_Desc = {
    Text = "Ao morrer, invoca uma \"Matriarca Fraturada\" ou \"Matriarca Espectral\" aleatória, reduzindo seu \"Efeito de enxame\" em 1 capa."
  },
  State_131638_Name = {
    Text = "Efeito de enxame"
  },
  State_131645_Desc = {
    Text = "Equipe Única: Ao alternar para a postura \"Onda de Ira\", ganha Domínio de área temporário igual a <WeaponEffect_Num:[StateArg1]%> do Domínio de área atual, com 3 turnos de cooldown."
  },
  State_131645_WeaponDesc = {
    Text = "Ao alternar para a postura \"Onda de Ira\", ganhe [DescArg2] pontos de Domínio de área temporário, com 3 turnos de cooldown (restante [DescArg1] turnos)."
  },
  State_131657_Desc = {
    Text = "Outros Corpos Despertos consomem 1 camada após liberar Fúria Explosiva, Mosk libera \"Vórtice! Fluxo! Tiro!\" para perseguir."
  },
  State_131657_Name = {
    Text = "<WhirlpoolKeywords:redemoinho carregando>"
  },
  State_131660_Desc = {
    Text = "A cada camada aumenta em 1 ponto a demanda de Fúria para liberar Fúria Explosiva."
  },
  State_131660_Name = {
    Text = "Correção de Valor Fixo de Consumo de Fúria"
  },
  State_131675_Desc = {
    Text = "Esta carta tem [StateArg1]% de probabilidade de tomar efeito 1 vez adicional na próxima vez que for disparada."
  },
  State_131675_Name = {
    Text = "<CardKeyWord:Aposta>"
  },
  State_131684_Desc = {
    Text = "As próximas [Layer] \"Vórtice! Fluxo! Bala!\" têm efeito 2 vezes."
  },
  State_131684_Name = {
    Text = "Merks! Grande! Boom! Explosão"
  },
  State_131749_Desc = {
    Text = "Equipe Única: Após o início da exploração, embaralhe 1 carta \"Sabedoria da Aposta\" no mazo de robo. \"Sabedoria da Aposta\": Consome 1 poder de cálculo. Embaralhe todas as cartas de comando na sua mão no mazo de robo. As cartas de comando embaralhadas têm <WeaponEffect_Num:[StateArg1]%> de probabilidade de tomar efeito 1 vez adicional na próxima vez que forem disparadas, e cada carta de comando embaralhada faz com que todos os Corpos Despertos ganhem 2 pontos de Fúria. <RetainIconKeywords:Preservar>. <DepleteIconKeywords:Consumo>. <GuyouKeywords:Inerente>."
  },
  State_131749_WeaponDesc = {
    Text = "Após o início da exploração, embaralhe 1 carta \"Sabedoria da Aposta\" no mazo de robo. \"Sabedoria da Aposta\": Consome 1 poder de cálculo. Embaralhe todas as cartas de comando na sua mão no mazo de robo. As cartas de comando embaralhadas têm <WeaponEffect_Num:[StateArg1]%> de probabilidade de ter efeito adicional 1 vez na próxima vez que forem disparadas, e para cada carta de comando embaralhada, todos os Corpos Despertos ganham 2 pontos de Fúria. <RetainIconKeywords:Preservar>. <DepleteIconKeywords:Consumo>. <GuyouKeywords:Inerente>."
  },
  State_131769_Name = {
    Text = "Estado@Reprodução Carne e sangue Inicialização de Classe 1"
  },
  State_131779_Desc = {
    Text = "Entrará na pilha de descarte e redefinirá o número de usos apenas após usar [Layer] vezes, mas a \"gravura\" só terá efeito na primeira utilização."
  },
  State_131779_Name = {
    Text = "Pode ser usado [Layer] vezes"
  },
  State_131789_Desc = {
    Text = "Meios alternativos. Adicione 1 carta com tid [Layer] à sua mão."
  },
  State_131789_Name = {
    Text = "Adicionar cartas específicas"
  },
  State_131807_Name = {
    Text = "Estado@Reprodução Carne Pura Identificador"
  },
  State_131824_Name = {
    Text = "Estado@Monstro Tawil Intenção de Troca Jogador Ouvinte"
  },
  State_131846_Desc = {
    Text = "Ao morrer, invoca um \"Enxame de Aranhas Abissais\" ou \"Enxame de Aranhas Frias\" aleatório, reduzindo seu \"Efeito de enxame\" em 1 pilha."
  },
  State_131846_Name = {
    Text = "Efeito de enxame"
  },
  State_131908_Desc = {
    Text = "Compartilha a Vida, Escudo do personagem e Fúria do alvo, mas não gera estatísticas de combate."
  },
  State_131908_Name = {
    Text = "Festim Podre de Salto"
  },
  State_131909_Desc = {
    Text = "Possuir este estado permite usar Fúria Explosiva."
  },
  State_131909_Name = {
    Text = "Selo permanente"
  },
  State_132366_Desc = {
    Text = "Realiza perseguição após outros Despertados usarem cartas de ataque"
  },
  State_132366_Name = {
    Text = "Perseguição"
  },
  State_132465_Desc = {
    Text = "O dano, escudo, cura, força, exaustão, dano de tentáculo, envenenamento fixo e contra-ataque fixo causados por este Despertado são aumentados, multiplicação independente de 1+[Layer]%."
  },
  State_132465_Name = {
    Text = "Devorar Reforçado α"
  },
  State_132469_Desc = {
    Text = "O dano, escudo, cura, força, exaustão, dano de tentáculo, envenenamento fixo e contra-ataque fixo causados por este Despertado são aumentados, multiplicação independente de 1+[Layer]%."
  },
  State_132469_Name = {
    Text = "Devorar Reforçado β"
  },
  State_132539_Desc = {
    Text = "Artefato de Teste de Conjunto"
  },
  State_132539_Name = {
    Text = "Artefato de Teste de Conjunto"
  },
  State_132539_WeaponDesc = {Text = "Teste"},
  State_132560_WeaponDesc = {
    Text = "Cada [Damage:StateArg2] vezes que o Fogo Verde causa dano, ganha uma carta de consumo [Chama Verde]"
  },
  State_132564_WeaponDesc = {
    Text = "Cada [Damage:StateArg2] vezes que o Fogo Verde causa dano, ganha uma carta de consumo [Chama Verde]"
  },
  State_132565_WeaponDesc = {
    Text = "Cada [Damage:StateArg2] vezes que o Fogo Verde causa dano, ganha uma carta de consumo [Chama Verde]"
  },
  State_132598_Desc = {
    Text = "Ao causar Dano de tentáculo neste turno, inflige adicionalmente Envenenamento igual a [Layer]% do Dano causado."
  },
  State_132598_Name = {
    Text = "Obsessão abissal"
  },
  State_132609_Desc = {
    Text = "Quando o escultor aplica o escudo, aumenta o dano de tentáculo [StateArg1]"
  },
  State_132609_Name = {
    Text = "Estado de Esquecimento"
  },
  State_132609_WeaponDesc = {
    Text = "Quando o escultor aplica o escudo, aumenta o dano de tentáculo [StateArg1]"
  },
  State_132669_Desc = {
    Text = "O dano, escudo, cura, força, exaustão, dano de tentáculo, envenenamento fixo e contra-ataque fixo causados pelas cartas deste Despertado são aumentados, multiplicação independente de 1+[Layer]%."
  },
  State_132669_Name = {
    Text = "Hiperdimensional Destinado α"
  },
  State_132840_Name = {
    Text = "O bônus do efeito de personalidade da Carta de comando de \"24\" é dobrado. Após \"24\" desencadear Fúria Explosiva, o efeito de bônus de personalidade dobrado expira neste turno"
  },
  State_132891_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Ao equipar, obtém [StateArg1] <StrongEffectKeywords:Eficaz>. Após a Fúria Explosiva de outros aliados, faz com que eles obtenham <PVPOneMeetingKeywords:Ichigo Ichie>."
  },
  State_132891_Name = {
    Text = "Devaneio Sob as Cerejeiras"
  },
  State_132892_Desc = {
    Text = "·Ao obter, remove o Estado \"Ichigo Ichie\" de outros aliados, obtendo o efeito Eficaz equivalente ao número de aliados equipados com \"Mistério sob as flores de cerejeira\", no máximo 3 camadas.\n·Personagens equipados com \"Mistério sob as flores de cerejeira\" não podem obter \"Ichigo Ichie\"."
  },
  State_132892_Name = {
    Text = "Ichigo Ichie"
  },
  State_133294_Name = {
    Text = "Convite para a residência real"
  },
  State_133353_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Após equipado, as descrições de \"golpear,\" \"Habilidade\" e \"Fúria Explosiva\" do Portador tornam-se não identificáveis, mas cada instância de Dano, Escudo e Recuperar vida é aleatoriamente aumentada em [StateArg1]%～[StateArg2]%."
  },
  State_133353_Name = {
    Text = "Conto de fadas na lama"
  },
  State_133354_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Preservada após a morte desta Roda do destino. Quando o Portador morre e ao fim dos [Layer] turnos seguintes no Estado de morte, os outros aliados obtêm <Heal:[Heal:StateArg1]> <PVPFeatheredSeedsKeyWords:Gineceu> e Vida."
  },
  State_133354_Name = {
    Text = "Que o mundo se transforme em fragrância"
  },
  State_133369_Desc = {
    Text = "As próximas [DescArg1] Cartas de comando não–Tawil Disparar entram em efeito duas vezes."
  },
  State_133369_Name = {
    Text = "Atravessar a Porta da Chave de Prata"
  },
  State_133372_Desc = {
    Text = "Se estiver atualmente em um Turno Ultra, ativa o efeito \"Warp de Singularidade\". \"Aniquilação de Singularidade\" também garante o próximo acionamento de \"Warp de Singularidade\" neste turno."
  },
  State_133372_Name = {
    Text = "<SingularityKeywords:Warp de Singularidade>"
  },
  State_133391_Desc = {
    Text = "Se a Vida do alvo for igual ou inferior ao número de capas, remove todo o Veredicto Final e o mata instantaneamente."
  },
  State_133391_Name = {
    Text = "<CutKeywords:Veredicto Final>"
  },
  State_133395_Desc = {
    Text = "As próximas [Layer] Carta(s) de comando Disparadas acionarão \"Transporte Dimensional\"."
  },
  State_133395_Name = {
    Text = "Transporte Dimensional"
  },
  State_133717_Desc = {
    Text = "O proprietário atual é [Layer], e todas as suas cartas atuais e futuras ganharão o atributo correspondente (Atual: Selo de Carta)."
  },
  State_133717_Name = {
    Text = "Propagação de Atributo de Carta"
  },
  State_133774_Desc = {
    Text = "Cada capa aumenta o Dano Final desta carta, o ganho fixo de <PowerIconKeywords:STR> & <TentacleInjurieIconKeywords:Dano de tentáculo>, o <IntoxicationIconKeywords:Envenenamento> & <RetaliateIconKeywords:Contrataque> fixo em 2%, e o Escudo Fixo Final, a Recuperação de Vida Fixa e a <ExhaustionIconKeywords:Redução de força> em 1%. Esta carta não pode acionar a <SingularityKeywords3:Lançadeira Dimensional>."
  },
  State_133774_Name = {
    Text = "<SingularityKeywords1:Faro de Singularidade>"
  },
  State_133775_Desc = {
    Text = "Cada capa aumenta o Dano Final desta carta, o ganho fixo de <PowerIconKeywords:STR> & <TentacleInjurieIconKeywords:Dano de tentáculo>, o <IntoxicationIconKeywords:Envenenamento> & <RetaliateIconKeywords:Contrataque> fixo em 2%, e o Escudo Fixo Final, a Recuperação de Vida Fixa e a <ExhaustionIconKeywords:Redução de força> em 1%"
  },
  State_133775_Name = {
    Text = "<SingularityKeywords2:Prisma de Singularidade>"
  },
  State_133961_Desc = {
    Text = "Equipe Única: Após o início da exploração, embaralhe 1 \"Mensagem Primaveril\" no baralho: Consumo de potência de cálculo 1, ganhe <WeaponEffect_Num:[StateArg1]> Energia de chave, transforma-se permanentemente em \"Flores de Sakura\" após ser disparada: Consumo de potência de cálculo 1, ganhe <WeaponEffect_Num:[StateArg2]> Energia de chave, após ser disparada transforma-se permanentemente em \"Hanafubuki\": Consumo de potência de cálculo 1, ganhe <WeaponEffect_Num:[StateArg3]> Energia de chave, transforma-se permanentemente em \"Ichigo Ichie\" após ser disparada: Consumo de potência de cálculo 1, escolha 1 entre 3 Ordens de chave desbloqueadas aleatórias para usar imediatamente e acionar 2 vezes, transforma-se permanentemente em \"Mensagem Primaveril\" após ser disparada. Todas essas cartas têm \"Preservar\"."
  },
  State_133961_WeaponDesc = {
    Text = "Após a exploração começar, embaralha 1 \"Mensagem Primaveril\" no deck: Consumo de potência de cálculo 1, ganha <WeaponEffect_Num:[StateArg1]> Energia de chave, transforma-se permanentemente em \"Flores de Sakura\" após Disparar: Consumo de potência de cálculo 1, ganha <WeaponEffect_Num:[StateArg2]> Energia de chave, após Disparar transforma-se permanentemente em \"Hanafubuki\": Consumo de potência de cálculo 1, ganha <WeaponEffect_Num:[StateArg3]> Energia de chave, transforma-se permanentemente em \"Ichigo Ichie\" após Disparar: Consumo de potência de cálculo 1, escolha 1 de 3 Ordem de chave desbloqueadas aleatórias para desencadear imediatamente e ativar 2 vezes, transforma-se permanentemente em \"Mensagem Primaveril\" após Disparar. Todas essas Cartas têm \"Preservar\"."
  },
  State_133994_Desc = {
    Text = "O Dano Final de todos os Corpos Despertos, o ganho fixo de <PowerIconKeywords:STR> & <TentacleInjurieIconKeywords:Dano de tentáculo>, o <IntoxicationIconKeywords:Envenenamento> & <RetaliateIconKeywords:Contrataque> fixo cada +[DescArg1]%; O Escudo Fixo Final desta carta, a Recuperação de Vida Fixa e a <ExhaustionIconKeywords:Redução de força> cada +[DescArg2]%"
  },
  State_133994_Name = {
    Text = "Prisma de Singularidade"
  },
  State_133998_Desc = {
    Text = "O Dano, Escudo e variação de Força causados por esta Carta aumentam em [DescArg2]%, e o Efeito final de Dano de tentáculo, recuperação de Vida, Envenenamento fixo e Contrataque fixo aumentam em [DescArg1]%. Removido ao fim do turno ou após ser Disparado."
  },
  State_133998_Name = {
    Text = "<TempPowerKeywords1:Reforço Temporário [DescArg1]>"
  },
  State_133999_Desc = {
    Text = "Cada capa aumenta o Dano Final desta carta, o ganho fixo de <PowerIconKeywords:STR> & <TentacleInjurieIconKeywords:Dano de tentáculo>, o <IntoxicationIconKeywords:Envenenamento> & <RetaliateIconKeywords:Contrataque> fixo em 2%, e o Escudo Fixo Final, a Recuperação de Vida Fixa e a <ExhaustionIconKeywords:Redução de força> em 1%. Remove-se ao ser disparada ou no fim do turno."
  },
  State_133999_Name = {
    Text = "<TempPowerKeywords:Reforço Temporário>"
  },
  State_134100_Desc = {
    Text = "Ao receber dano letal nesta batalha, ressuscita, recupera [Layer] pontos de vida e concede a todos os Despertados [StateArg1] pontos de fúria e [DescArg1] pontos de dano de tentáculo temporário. Não pode ser dissipado."
  },
  State_134100_Name = {
    Text = "Pássaro do Paraíso Imortal"
  },
  State_134191_Desc = {
    Text = "Único na equipe: Após o início da exploração, embaralha 1 carta \"Hora Secreta de Descanso\" no baralho de compra. \"Hora Secreta de Descanso\": Consome 1 poder de processamento. Dano crítico temporário +<WeaponEffect_Num:[StateArg1]%>. <RetainIconKeywords:Reter>. <DepleteIconKeywords:Consumir>."
  },
  State_134191_WeaponDesc = {
    Text = "Após o início da exploração, embaralha 1 carta \"Hora Secreta de Descanso\" no baralho de compra. \"Hora Secreta de Descanso\": Consome 1 poder de processamento. Dano crítico temporário +<WeaponEffect_Num:[StateArg1]%>. <RetainIconKeywords:Reter>. <DepleteIconKeywords:Consumir>."
  },
  State_134195_Desc = {
    Text = "As camadas de envenenamento fixo, contra-ataque fixo e julgamento do destino fixo causadas por esta carta são aumentadas, multiplicação independente de 1+[Layer]%."
  },
  State_134195_Name = {
    Text = "Força Trifásica α1"
  },
  State_134196_Desc = {
    Text = "As camadas de envenenamento fixo, contra-ataque fixo e julgamento do destino fixo causadas pelas cartas de comando deste Despertado são aumentadas, multiplicação independente de 1+[StateArg1]%."
  },
  State_134196_Name = {
    Text = "Força Trifásica β3"
  },
  State_134197_Desc = {
    Text = "As camadas de envenenamento fixo, contra-ataque fixo e julgamento do destino fixo causadas por esta carta são aumentadas, multiplicação independente de 1+[StateArg1]%."
  },
  State_134197_Name = {
    Text = "Força Trifásica β1"
  },
  State_134198_Desc = {
    Text = "As camadas de envenenamento fixo, contra-ataque fixo e julgamento do destino fixo causadas pelas cartas de comando deste Despertado são aumentadas, multiplicação independente de 1+[Layer]%."
  },
  State_134198_Name = {
    Text = "Força Trifásica α3"
  },
  State_134199_Desc = {
    Text = "As camadas de envenenamento fixo, contra-ataque fixo e julgamento do destino fixo causadas pela explosão de fúria deste Despertado são aumentadas, multiplicação independente de 1+[StateArg1]%."
  },
  State_134199_Name = {
    Text = "Força Trifásica β2"
  },
  State_134200_Desc = {
    Text = "As camadas de envenenamento fixo, contra-ataque fixo e julgamento do destino fixo causadas pela explosão de fúria deste Despertado são aumentadas, multiplicação independente de 1+[Layer]%."
  },
  State_134200_Name = {
    Text = "Força Trifásica α2"
  },
  State_134227_Desc = {
    Text = "Linhas tecidas pela Tecelã do Destino. Camada máxima [DescArg1], persiste entre batalhas e pode ser consumida pela Fúria Explosiva para liberar a Caçada: \"Fios Infinitos\"."
  },
  State_134227_Name = {
    Text = "<SilkKeywords:Tecer o Destino>"
  },
  State_134231_Desc = {
    Text = "Equipe Única: Escudo do personagem gerado pelo Portador +<WeaponEffect_Num:[StateArg1]%>, e quando o Portador usa \"Caçada\", Eficaz Temporário +<WeaponEffect_Num:[StateArg2]%>, até 5 vezes por turno. Sempre que \"Transporte Dimensional\" for acionado, o Portador ganha <WeaponEffect_Num:[StateArg3]> de Fúria."
  },
  State_134231_WeaponDesc = {
    Text = "Escudo do personagem gerado pelo Portador +<WeaponEffect_Num:[StateArg1]%>, e quando o Portador usa \"Caçada\", Eficaz Temporário +<WeaponEffect_Num:[StateArg2]%>, até 5 vezes por turno. Sempre que \"Transporte Dimensional\" for acionado, o Portador ganha <WeaponEffect_Num:[StateArg3]> de Fúria."
  },
  State_134237_Desc = {
    Text = "A Tecelã do Destino puxa seus fios. Máximo de [DescArg1] capas, persistem entre batalhas e podem ser consumidas por Fúria Explosiva para desencadear Caçada: \"<DerivativeCardKeywords_144:Fios infinitos>."
  },
  State_134237_Name = {
    Text = "Tecer o Destino"
  },
  State_134240_Desc = {
    Text = "Nas próximas [Layer] vezes que a \"Tecelagem Eterna\" gerar um \"Chamar da Teia\", coloque-o no mazo de robo e no monte de descarte."
  },
  State_134240_Name = {
    Text = "Rede da Morte"
  },
  State_134261_Desc = {
    Text = "As próximas [Layer] instâncias de dano causado são dobradas."
  },
  State_134261_Name = {
    Text = "Hora Secreta do Descanso"
  },
  State_134262_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após\"Explosão de Fúria\", o próximo dano causado por si mesmo é dobrado."
  },
  State_134262_Name = {
    Text = "Hora Secreta do Descanso"
  },
  State_134285_Desc = {
    Text = "Se a Vida do alvo for igual ou inferior ao número de capas, remove todo o Veredicto Final e o mata instantaneamente."
  },
  State_134285_Name = {
    Text = "Julgamento do Destino"
  },
  State_134313_Desc = {
    Text = "Equipe Única: Escudo do personagem gerado pelo Portador +<WeaponEffect_Num:[StateArg1]%>, e quando o Portador usa \"Caçada\", Eficaz Temporário +<WeaponEffect_Num:[StateArg2]%>, até 5 vezes por turno."
  },
  State_134313_WeaponDesc = {
    Text = "Escudo do personagem gerado pelo Portador +<WeaponEffect_Num:[StateArg1]%>, e quando o Portador usa \"Caçada\", Eficaz Temporário +<WeaponEffect_Num:[StateArg2]%>, até 5 vezes por turno."
  },
  State_134384_Desc = {
    Text = "As próximas [Layer] Carta(s) de comando Disparadas acionarão \"Transporte Dimensional\"."
  },
  State_134384_Name = {
    Text = "Transporte Dimensional"
  },
  State_134389_Desc = {
    Text = "O Dano Final desta carta, o ganho fixo de <PowerIconKeywords:STR> & <TentacleInjurieIconKeywords:Dano de tentáculo>, o <IntoxicationIconKeywords:Envenenamento> & <RetaliateIconKeywords:Contrataque> fixo cada +[DescArg1]%; O Escudo Fixo Final desta carta, a Recuperação de Vida Fixa e a <ExhaustionIconKeywords:Redução de força> cada +[DescArg2]%. Cartas com \"Faro de Singularidade\" não podem acionar a \"Lançadeira Dimensional\"."
  },
  State_134389_Name = {
    Text = "<SingularityKeywords:Faro de Singularidade [DescArg2]>"
  },
  State_134391_Desc = {
    Text = "A cada turno, após a primeira Carta de comando ser Disparada, este Efeito é acionado: a Cópia Original Temporária da Carta de comando Disparada é colocada no Espaço Hiperdimensional. Este Efeito não pode ser acionado durante Turnos Ultra."
  },
  State_134391_Name = {
    Text = "<SingularityKeywords3:Transporte Dimensional>"
  },
  State_135232_Name = {
    Text = "<SingularityKeywords:Warp de Singularidade>: Pelo resto deste turno, sempre que outro Corpo Desperto Disparar uma Carta de comando, consome 1 <SilkKeywords:Tecelã> para desencadear Caçada: <DerivativeCardKeywords_137:\"Fios Infinitos\">"
  },
  State_135233_Name = {
    Text = "<SingularityKeywords:Warp de Singularidade>: Pelo resto deste turno, sempre que outro Corpo Desperto Disparar uma Carta de comando, consome 1 <SilkKeywords:Tecelã> para desencadear Caçada: <DerivativeCardKeywords_137:\"Fios Infinitos\">"
  },
  State_135919_Name = {
    Text = "<SingularityKeywords:Warp de Singularidade>: Pelo resto deste turno, sempre que outro Corpo Desperto Disparar uma Carta de comando, consome 1 <SilkKeywords:Tecelã> para desencadear Caçada: <DerivativeCardKeywords_137:\"Fios Infinitos\">"
  },
  State_135920_Name = {
    Text = "<SingularityKeywords:Warp de Singularidade>: Pelo resto deste turno, sempre que outro Corpo Desperto Disparar uma Carta de comando, consome 1 <SilkKeywords:Tecelã> para desencadear Caçada: <DerivativeCardKeywords_137:\"Fios Infinitos\">"
  },
  State_135921_Desc = {
    Text = "Dano causado pelo corpo desperto aumentado em 25%"
  },
  State_135921_Name = {
    Text = "<CardKeyWord:Repreenda, para retribuir o ódio>"
  },
  State_138824_Desc = {
    Text = "Uma vida radiante que louva a liberdade e entoa um cântico de vitória, podendo ser consumida pela Fúria Explosiva de Saya para aumentar seu Efeito. Este Estado acumula no máximo 4 camadas e é Preservado após o fim do combate."
  },
  State_138824_Name = {
    Text = "<KaiHuajishu1:Gineceu>"
  },
  State_139039_Desc = {
    Text = "O efeito final do próximo Fúria Explosiva deste Corpo Desperto neste turno — incluindo Dano, Escudo fixo, Recuperação de Vida fixa, Força fixa, Redução de força, Dano de tentáculo aumentado, Envenenamento fixo e Contrataque fixo — aumenta em [Layer]%."
  },
  State_139039_Name = {
    Text = "<BreedingKeywords2:Festa de Propagação>"
  },
  State_139687_Desc = {
    Text = "Uma vida radiante que louva a liberdade e entoa um cântico de vitória, podendo ser consumida pela Fúria Explosiva de Saya para aumentar seu Efeito. Este Estado acumula no máximo 4 camadas e é Preservado após o fim do combate."
  },
  State_139687_Name = {
    Text = "<KaiHuajishu:Gineceu>"
  },
  State_139688_Desc = {
    Text = "Equipe Única: Limite de capacidade de cálculo +1, efeitos do mesmo tipo não acumulam.\nPara cada 10 de Fúria Básica que o Portador possui, ele inflige +<WeaponEffect_Num:[StateArg1]%> capas de <Corrosion:Corrosão> e causa +<WeaponEffect_Num:[Float:StateArg2]％> de Fusão de embriões."
  },
  State_139688_WeaponDesc = {
    Text = "Limite de capacidade de cálculo +1, efeitos do mesmo tipo não acumulam.\nPara cada 10 de Fúria Básica que o Portador possui, ele inflige +<WeaponEffect_Num:[StateArg1]%> capas fixas de <Corrosion:Corrosão> e causa +<WeaponEffect_Num:[Float:StateArg2]%> de Fusão de embriões."
  },
  State_139689_Desc = {
    Text = "Equipe Única: Após usar o \"Forno Carmesim\", o Portador ganha Fúria igual a <WeaponEffect_Num:[StateArg1]%> da Fúria Básica. Recarga de 3 turnos."
  },
  State_139689_WeaponDesc = {
    Text = "Após usar \"Forno Carmesim\", o Portador ganha <WeaponEffect_Num:[StateArg1]%> da Aliemus Base como Fúria, com recarga de 3 turnos."
  },
  State_139977_Desc = {
    Text = "Neste turno, se você Disparar \"golpear,\" \"golpear\" causa +[DescArg1]% de Dano com Penetração; caso contrário, ganha +[Layer] Barreira no final do turno."
  },
  State_139977_Name = {
    Text = "Fera Estelar"
  },
  State_140063_Desc = {
    Text = "Este é um \"vale\" criado ao emprestar Poder de cálculo do próximo turno. [Layer] Poder de cálculo será deduzido no início do próximo turno. Não pode ser dissipado."
  },
  State_140063_Name = {
    Text = "No Vermelho"
  },
  State_140068_Desc = {
    Text = "A(s) próxima(s) [DescArg1] Carta(s) de \"Habilidade\" custa(m) – [StateArg1] Poder de cálculo."
  },
  State_140068_Name = {Text = "Epifania"},
  State_140135_Desc = {
    Text = "Para cada camada possuída, o efeito final do próximo Fúria Explosiva deste Corpo Desperto neste turno — incluindo Dano, Escudo fixo, Recuperação de Vida fixa, Força fixa, Redução de força, Dano de tentáculo aumentado, Envenenamento fixo e Contrataque fixo — aumenta em 1%."
  },
  State_140135_Name = {
    Text = "<BreedingKeywords2:Festa de Propagação>"
  },
  State_140186_WeaponDesc = {
    Text = "Todas as vezes que Salto da Baleia causa dano +1"
  },
  State_140454_Desc = {
    Text = "Único na equipe: Para cada 1% de Marca Negra perdida pelo portador, Roda do Destino ou Pacto Secreto, recupera <WeaponEffect_Num:[StateArg1] %> de Vida Máxima após o combate. A cada fim de turno, esse efeito de recuperação é reduzido em 30%, calculado independentemente para cada instância. Após usar \"Percepção\" nas \"Ruínas de Cinzas\", a atualização desta \"Ruínas de Cinzas\" não consome Marca Negra."
  },
  State_140454_WeaponDesc = {
    Text = "Para cada 1% de Queda de marca negra que o Portador, suas Rodas do destino e Mystiks possuem, recupera <WeaponEffect_Num:[DescArg2]%> de Vida máxima ([DescArg1]) no final da batalha. Este efeito diminui em 30% no final de cada turno, e é calculado individualmente para cada batalha.\nApós escolher \"Indução\" em \"Ruínas Cinzentas,\" as atualizações serão gratuitas nesta \"Ruínas Cinzentas.\""
  },
  State_140456_WeaponDesc = {
    Text = "Jogue para removê-la permanentemente"
  },
  State_140458_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Ao equipar e após qualquer Despertado liberar uma \"Explosão de Fúria\", obtém <Block:[Block:StateArg1]> de escudo para si."
  },
  State_140458_Name = {
    Text = "Ex Stellaris"
  },
  State_140489_Desc = {
    Text = "Obtém uma quantidade igual de Vida Máxima. As acumulações não podem exceder a Vida Máxima inicial do Corpo Desperto."
  },
  State_140489_Name = {Text = "Gineceu"},
  State_140490_Desc = {
    Text = "Obtém uma quantidade igual de Vida Máxima. As acumulações não podem exceder a Vida Máxima inicial deste Corpo Desperto [DescArg1]."
  },
  State_140490_Name = {Text = "Gineceu"},
  State_140495_Desc = {
    Text = "O Poder de cálculo consumido pela próxima \"habilidade\" - [Layer] ."
  },
  State_140495_Name = {Text = "Reescrever"},
  State_140517_Desc = {
    Text = "O custo de poder de cálculo da próxima \"Habilidade\"– [DescArg1]."
  },
  State_140517_Name = {Text = "Reescrever"},
  State_140547_Desc = {
    Text = "Este efeito pode aumentar a Fusão Embrionária em no máximo + 100, não sendo afetado por bônus de aumento de Fusão Embrionária."
  },
  State_140547_Name = {
    Text = "Fusão de embriões Dupla"
  },
  State_140645_Desc = {
    Text = "Efeito de espera"
  },
  State_140645_Name = {
    Text = "Efeito de espera"
  },
  State_140647_Name = {
    Text = "Monitoramento de Dissonância Cognitiva jogado"
  },
  State_140648_Name = {
    Text = "Jogador possui contagem de Dissonância Cognitiva"
  },
  State_140650_Desc = {
    Text = "As primeiras 3 vezes a cada turno que você Disparar uma Carta de comando com \"Distorção de Percepção\", Saya ganha [Layer] de Fúria."
  },
  State_140650_Name = {
    Text = "Transformação Cognitiva"
  },
  State_140651_Desc = {
    Text = "Efeito de espera"
  },
  State_140651_Name = {
    Text = "Efeito de espera"
  },
  State_140653_Desc = {
    Text = "O Consumo de potência de cálculo desta Carta tem 10% de chance de -2, 25% de chance de -1, 30% de chance de não mudar, 25% de chance de +1, 10% de chance de +2. Remove este Estado ao Disparar ou descartar."
  },
  State_140653_Name = {
    Text = "<ExclamationPointColour:Tinta colorida>"
  },
  State_140654_Desc = {
    Text = "Efeito de espera"
  },
  State_140654_Name = {
    Text = "Efeito de espera"
  },
  State_140655_Desc = {
    Text = "Esta Carta está encoberta pela Dissolução e seu texto não pode ser visualizado. O Consumo de potência de cálculo tem 10% de chance de -2, 25% de chance de -1, 30% de chance de não mudar, 25% de chance de +1, 10% de chance de +2. Remove este Estado ao Disparar ou descartar."
  },
  State_140655_Name = {
    Text = "<ErosionColorInkKeywords:Dissolução Tinta colorida>"
  },
  State_140656_Desc = {
    Text = "O Consumo de potência de cálculo desta Carta tem 10% de chance de -2, 25% de chance de -1, 30% de chance de não mudar, 25% de chance de +1, 10% de chance de +2. Remove este Estado ao Disparar ou descartar."
  },
  State_140656_Name = {
    Text = "<ColorInkKeywords:Tinta colorida>"
  },
  State_140657_Desc = {
    Text = "Esta Carta está encoberta pela Dissolução e seu texto não pode ser visualizado. O Consumo de potência de cálculo tem 10% de chance de -2, 25% de chance de -1, 30% de chance de não mudar, 25% de chance de +1, 10% de chance de +2. Remove este Estado ao Disparar ou descartar."
  },
  State_140657_Name = {
    Text = "<ExclamationPointColour:Dissolução Tinta colorida>"
  },
  State_140658_Name = {
    Text = "Jogador possui Monitoramento de Dissonância Cognitiva"
  },
  State_140659_Desc = {
    Text = "Efeito de espera"
  },
  State_140659_Name = {
    Text = "Efeito de espera"
  },
  State_140662_Desc = {
    Text = "No início de cada turno, \"Distorção de Percepção\" é aplicada aleatoriamente a 2 Cartas de comando que não possuem \"Distorção de Percepção\"."
  },
  State_140662_Name = {
    Text = "Tratamento de Reconstrução da Vida"
  },
  State_140672_Desc = {
    Text = "Este Corpo Desperto cai no caos, reduzindo o Dano causado, a Recuperação de Vida e o Escudo em 15%~35% aleatoriamente, e não pode ser dissipado."
  },
  State_140672_Name = {
    Text = "<PVPCognitiveDissonanceKeyWords:Distorção de Percepção>"
  },
  State_140673_Desc = {
    Text = "Este Corpo Desperto cai no caos, reduzindo o Dano causado, a Recuperação de Vida e o Escudo em 15%~35% aleatoriamente, e não pode ser dissipado."
  },
  State_140673_Name = {
    Text = "Distorção de Percepção"
  },
  State_140683_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Ao equipar, obtém [StateArg1] <MaxHPKeywords:Vida máxima>. Ao fim do turno, recupera <Heal:[Heal:DescArg1]> de vida. A vida recuperada aumenta conforme a vida do portador diminui, com um aumento máximo de [StateArg3]%."
  },
  State_140683_Name = {
    Text = "Lily no País das Maravilhas"
  },
  State_140724_Name = {Text = "Alimentar"},
  State_140726_Desc = {
    Text = "O efeito final de dano, força, dano de tentáculo, veneno fixo, contra-ataque fixo, escudo, recuperação de vida e redução de força causados por esta carta é reduzido em [DescArg1]%."
  },
  State_140726_Name = {
    Text = "<AdaptKeywords1:Adaptação [DescArg1]>"
  },
  State_140727_Desc = {
    Text = "Quando a Fome atingir 5 camadas, ao final do turno, consome toda a Fome, muda a intenção para Ataque poderoso e obtém [DescArg1] pontos de Força."
  },
  State_140727_Name = {Text = "Fome"},
  State_140728_Desc = {
    Text = "No início de cada turno, obtém 1 camada de Fome. Ao causar Dano não bloqueado, obtém Escudo equivalente a 2% da Vida máxima ([DescArg1]). O limite máximo de camadas de Adaptação aumenta para 75."
  },
  State_140728_Name = {
    Text = "Guardar Comida"
  },
  State_140730_Desc = {
    Text = "Ao Disparar uma Carta de comando, aplica 10 camadas de <AdaptKeywords:Adaptação> às Cartas do Corpo Desperto correspondente em todos os locais, e remove 5 camadas de <AdaptKeywords:Adaptação> das Cartas dos outros Corpos Despertos. Cada camada de <AdaptKeywords:Adaptação> reduz em 1% o Efeito final do Dano, Força, Dano de tentáculo, Envenenamento fixo, Contrataque fixo, Escudo, Recuperação de Vida e Redução de força causados pela Carta, acumulando até no máximo [DescArg1] camadas."
  },
  State_140730_Name = {Text = "Mimetismo"},
  State_140838_Desc = {
    Text = "O Dano causado nesta rodada é reduzido em [Layer]%."
  },
  State_140838_Name = {
    Text = "Muralha de Pesadelo que Encobre o Sol"
  },
  State_140839_Desc = {
    Text = "Nesta rodada, o Dano Final de todos os Corpos Despertos aumenta em [Layer]%."
  },
  State_140839_Name = {
    Text = "Caçada Acompanhada"
  },
  State_140856_Desc = {
    Text = "O Corpo Desperto não pode agir. Remove 1 capa de Interferência de Consciência no final do turno. Após remover todas as capas, a próxima vez que este Corpo Desperto liberar Fúria Explosiva, será considerado como Superexaltação. Se a Superexaltação já foi liberada, retorna 100% do Aliemus Base."
  },
  State_140856_Name = {
    Text = "<Yishiganshe:Interferência de Consciência>"
  },
  State_140860_Desc = {
    Text = "O Corpo Desperto não pode agir. Remove 1 capa de Interferência de Consciência no final do turno. Após remover todas as capas, a próxima vez que este Corpo Desperto liberar Fúria Explosiva, será considerado como Superexaltação. Se a Superexaltação já foi liberada, retorna 100% do Aliemus Base."
  },
  State_140860_Name = {
    Text = "<Yishiganshe:Interferência de Consciência>"
  },
  State_140861_Desc = {
    Text = "A próxima vez que liberar Fúria Explosiva será considerado como Superexaltação. Se a Superexaltação já foi liberada, retorna 100% do Aliemus Base."
  },
  State_140861_Name = {
    Text = "Lily no País das Maravilhas"
  },
  State_140873_Desc = {
    Text = "Cada camada reduz em 1% o Efeito final do Dano, Força, Dano de tentáculo, Envenenamento fixo, Contrataque fixo, Escudo, Recuperação de Vida e Redução de força causados por esta Carta, até no máximo [DescArg1] camadas."
  },
  State_140873_Name = {
    Text = "<AdaptKeywords:Adaptação>"
  },
  State_140877_Name = {
    Text = "Ativa [DescArg1] vezes adicionais"
  },
  State_141468_Desc = {
    Text = "Ao acumular 5 camadas de Fome, ao final do turno consome toda a Fome, muda a intenção para Ataque Poderoso e obtém Força."
  },
  State_141468_Name = {
    Text = "<HungerKeywords:Fome>"
  },
  State_141504_Desc = {
    Text = "Acumula no máximo 3 cadáveres. Ao atingir o limite, o próximo \"Banquete de seres vivos\" poderá consumi-los e aumentar seus efeitos. Os restos são herdados para a próxima batalha."
  },
  State_141504_Name = {Text = "Esqueleto"},
  State_141950_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Ao equipar e ao fim do turno, <PVPDiscoveryKeyWords:Descobrir> [StateArg1] carta(s) de \"Habilidade\" com <PVPVoidKeywords:Nada> adicionado e colocá-la(s) na mão."
  },
  State_141950_Name = {
    Text = "Descida Ascendente"
  },
  State_141988_Desc = {
    Text = "O Dano, Escudo, cura causados por esta Carta, bem como a Força, Exaustão, Dano de tentáculo, Envenenamento, Contrataque, Veredito Final, Envenenamento fixo, Contrataque fixo e Veredito Final fixo aplicados têm seus Efeitos aumentados em [Layer]%."
  },
  State_141988_Name = {
    Text = "Carta Iridescente"
  },
  State_141989_Desc = {
    Text = "Cria Cartas aleatórias."
  },
  State_141989_Name = {
    Text = "<CardKeyWord:Descobrir>"
  },
  State_141991_Desc = {
    Text = "O Dano, Escudo, cura causados pela Fúria Explosiva deste Corpo Desperto, bem como a Força, Exaustão, Dano de tentáculo, Envenenamento, Contrataque, Veredito Final, Envenenamento fixo, Contrataque fixo e Veredito Final fixo aplicados têm seus Efeitos aumentados em [Layer]%."
  },
  State_141991_Name = {
    Text = "Fúria Explosiva Iridescente"
  },
  State_141992_Desc = {
    Text = "O Dano, Escudo, cura causados pelas Cartas deste Corpo Desperto, bem como a Força, Exaustão, Dano de tentáculo, Envenenamento, Contrataque, Veredito Final, Envenenamento fixo, Contrataque fixo e Veredito Final fixo aplicados têm seus Efeitos aumentados em [Layer]%."
  },
  State_141992_Name = {
    Text = "Carta Iridescente"
  },
  State_141993_Desc = {
    Text = "O Dano, Escudo, cura causados pelas Cartas de comando deste Corpo Desperto, bem como a Força, Exaustão, Dano de tentáculo, Envenenamento, Contrataque, Veredito Final, Envenenamento fixo, Contrataque fixo e Veredito Final fixo aplicados têm seus Efeitos aumentados em [Layer]%."
  },
  State_141993_Name = {
    Text = "Carta de Comando Iridescente"
  },
  State_141994_Desc = {
    Text = "Ao Disparar uma Carta, após Fúria Explosiva causar Dano, ganhar Escudo, curar, aplicar Força, Exaustão, Dano de tentáculo, Envenenamento, Contrataque, Veredito Final, Envenenamento Fixo, Contrataque Fixo, Veredito Final Fixo."
  },
  State_141994_Name = {
    Text = "Comando de Ativação Colorido"
  },
  State_142018_Desc = {
    Text = "No início do turno, ganhe 1 camada de <Guaiwucanhai:destroços>"
  },
  State_142018_Name = {
    Text = "Convite para a residência real"
  },
  State_142057_Desc = {
    Text = "Após usar uma Ordem de chave, alterna a própria intenção. Após o início do combate, o Nível de Carga da Chave de Prata de todos os Corpos Despertos aumenta em 25%."
  },
  State_142057_Name = {
    Text = "Epifania de Causa e Efeito"
  },
  State_142058_Desc = {
    Text = "O Dano básico, Envenenamento e Contrataque causado é reduzido em [DescArg1]%"
  },
  State_142058_Name = {Text = "Asa Imunda"},
  State_142060_Desc = {
    Text = "Cada vez que o inimigo usa uma Carta de comando, obtém 1 camada de Fervor temporário. Ao atingir 10 camadas de Fervor temporário, após a próxima Carta de comando disparada, age imediatamente e remove todo o Fervor temporário."
  },
  State_142060_Name = {
    Text = "Eco do Abismo"
  },
  State_142062_Desc = {
    Text = "O Efeito inicial de 0246 é aleatório a cada vez"
  },
  State_142062_Name = {
    Text = "Intenção Aleatória"
  },
  State_142063_Desc = {
    Text = "Durante o próprio turno, o Dano recebido é reduzido em [DescArg1]%."
  },
  State_142063_Name = {
    Text = "Asa Sagrada"
  },
  State_142065_Desc = {
    Text = "Removido no início do turno. Ao atingir 10 camadas, após a próxima Carta de comando disparada, age imediatamente e remove todo o Fervor temporário."
  },
  State_142065_Name = {
    Text = "Fervor temporário"
  },
  State_142066_Desc = {
    Text = "Os efeitos de <WeaknessIconKeywords:fraqueza>, <FragileIconKeywords:frágil> e <HeavyInjuryKeywords:perdição> aumentam para 50%."
  },
  State_142066_Name = {
    Text = "Discernimento Essencial"
  },
  State_142067_Desc = {
    Text = "O Dano de Força, Contrataque e tentáculo causado é reduzido em [DescArg1]%"
  },
  State_142067_Name = {
    Text = "Asa Amaldiçoada"
  },
  State_142072_Desc = {
    Text = "A cada vez que sofrer dano ou perder vida, não pode exceder 5% da vida máxima."
  },
  State_142072_Name = {
    Text = "Limiar de Dor Suportada"
  },
  State_142091_Desc = {
    Text = "Contagem de Duplicação das Seis Asas"
  },
  State_142091_Name = {
    Text = "Contagem de Duplicação das Seis Asas"
  },
  State_142092_Desc = {
    Text = "O Nível de Carga da Chave de Prata de todos os Corpos Despertos aumenta em 25%."
  },
  State_142092_Name = {
    Text = "Epifania de Causa e Efeito"
  },
  State_142093_Desc = {
    Text = "Progresso de consumo da Duplicação das Seis Asas: [DescArg1], Valor de dano necessário atual: [DescArg2]."
  },
  State_142093_Name = {
    Text = "Duplicação das Seis Asas"
  },
  State_142095_Desc = {
    Text = "Marcador de Duplicação das Seis Asas"
  },
  State_142095_Name = {
    Text = "Marcador de Duplicação das Seis Asas"
  },
  State_142166_Desc = {
    Text = "Veja a lógica da greve geral para efeitos específicos. __ \"Para uso de desenvolvimento apenas\""
  },
  State_142213_Name = {
    Text = "Reduzir o limite de capacidade de cálculo"
  },
  State_142215_Desc = {
    Text = "Se ainda estiver morto no início do próximo turno, ressurreição e obtém [StateArg1] de Escudo. Não pode ser dissipado."
  },
  State_142215_Name = {
    Text = "Obsessão Eterna"
  },
  State_142228_Desc = {
    Text = "Esta Carta foi criada pela Roda do destino \"Descida Ascendente\"."
  },
  State_142228_Name = {
    Text = "Descida Ascendente"
  },
  State_142229_Desc = {
    Text = "Equipe Única: Após o início da exploração, adiciona 1 carta de \"Lily no País das Maravilhas\" ao baralho. \"Lily no País das Maravilhas\": Consome 2 pontos de Poder de cálculo, fazendo o Portador obter <WeaponEffect_Num:[StateArg1]> pontos de Fúria e 3 capas de <Yishiganshe:\"Interferência de Consciência\">. <RetainIconKeywords:Preservar>. <DepleteIconKeywords:Consumir>."
  },
  State_142229_Name = {
    Text = "Lily no País das Maravilhas"
  },
  State_142229_WeaponDesc = {
    Text = "Após o início da exploração, adiciona 1 carta de \"Lily no País das Maravilhas\" ao baralho. \"Lily no País das Maravilhas\": Consome 2 pontos de Poder de cálculo, fazendo o Portador obter <WeaponEffect_Num:[StateArg1]> pontos de Fúria e <Yishiganshe:\"Interferência de Consciência\">. <RetainIconKeywords:Preservar>. <DepleteIconKeywords:Consumir>."
  },
  State_142452_Desc = {
    Text = "O Efeito de Redução de força recebido é reduzido em 50%."
  },
  State_142452_Name = {
    Text = "Existência Imortal"
  },
  State_142663_Desc = {
    Text = "No início do próximo turno, obtém <DelayKeywords:Latência>: [Layer] Fúria."
  },
  State_142663_Name = {
    Text = "Loucura retardada com Latência"
  },
  State_142688_Desc = {
    Text = "A Roda do destino equipada pelo alvo fica inativa. Não pode ser dissipado."
  },
  State_142688_Name = {
    Text = "Enrolar Super"
  },
  State_142692_Desc = {
    Text = "Uma nova ideia engenhosa está surgindo."
  },
  State_142692_Name = {
    Text = "Inspiração Repentina"
  },
  State_142715_Desc = {
    Text = "O dano dessa \"habilidade\" aumenta em [DescArg1]%, e a cada 1 ponto de Poder de cálculo necessário para essa habilidade, aumenta [StateArg1]%."
  },
  State_142715_Name = {
    Text = "Morte âmbar"
  },
  State_142887_Desc = {
    Text = "Se receber \"Paralisia\" novamente neste turno, todos os seus \"golpear\" se tornam \"Ilusão\", não pode ser dissipado, e dura até o final do turno."
  },
  State_142887_Name = {
    Text = "Um Pouco Paralisado"
  },
  State_142954_Desc = {
    Text = "O Limite de capacidade de cálculo é no mínimo 0. No início de cada turno, se for menor que 10, aumenta em 1. Após atingir 10, qualquer Limite de capacidade de cálculo adicional obtido será convertido em comprar a mesma quantidade de Cartas."
  },
  State_142954_Name = {
    Text = "Limite de capacidade de cálculo"
  },
  State_143002_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_143002_Name = {
    Text = "Sartogua SR(Texto temporário)"
  },
  State_143004_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_143004_Name = {
    Text = "Arma exclusiva de Satogua (texto temporário)"
  },
  State_143005_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_143005_Name = {
    Text = "Lantigos SR (Texto temporário)"
  },
  State_143006_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_143006_Name = {
    Text = "Arma exclusiva do Faraó Negro (texto temporário)"
  },
  State_143007_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Ao equipar e no início do turno, aplica [StateArg1] <plural value=\"[StateArg1]\" singular=\"capa\" plural=\"capas\"> de <PVPCompassKeywords:A Bússola Errante> a um inimigo aleatório."
  },
  State_143007_Name = {
    Text = "A Bússola Errante"
  },
  State_143008_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_143008_Name = {
    Text = "Arma exclusiva do Pássaro Shatak (texto temporário)"
  },
  State_143009_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_143009_Name = {
    Text = "Arma exclusiva de Aphogmon (texto temporário)"
  },
  State_143010_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Limite de cartas na mão+ [StateArg1]. Quando o Portador ou um aliado morre, suas Cartas não são mais convertidas em <PVPDerivativeCardKeywords_2:\"Ilusão\">, mas sim em <PVPDerivativeCardKeywords_30:\"Gaunt-Saqueador\">."
  },
  State_143010_Name = {
    Text = "Gaiola Viva"
  },
  State_143011_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_143011_Name = {
    Text = "Abutre SR (Texto temporário)"
  },
  State_143012_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_143012_Name = {
    Text = "Pássaro Shartak SR (Texto temporário)"
  },
  State_143013_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_143013_Name = {
    Text = "Gênesis Ogier SR (Texto temporário)"
  },
  State_143014_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Antes da \"Fúria Explosiva\", perde 25% da Vida atual; após a \"Fúria Explosiva\", causa [StateArg1] de Dano a todos os inimigos e Drena Vida equivalente."
  },
  State_143014_Name = {
    Text = "Engano adocicado"
  },
  State_143016_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_143016_Name = {
    Text = "Farao Negro SR (Texto temporário)"
  },
  State_143017_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_143017_Name = {
    Text = "Arma exclusiva de Lantigos (texto temporário)"
  },
  State_143018_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_143018_Name = {
    Text = "Gráfico de Origem SR (Texto temporário)"
  },
  State_143019_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Após \"Fúria Explosiva\", aplica [StateArg1] camadas de <PVPBless:Bênção> a todos os inimigos."
  },
  State_143019_Name = {
    Text = "A Doce Verdade"
  },
  State_143020_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_143020_Name = {
    Text = "Arma Exclusiva de Ogier da Origem (Texto Temporário)"
  },
  State_143022_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_143022_Name = {
    Text = "Arma exclusiva do Abutre (texto temporário)"
  },
  State_143023_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_143023_Name = {
    Text = "Afogomem SR (Texto temporário)"
  },
  State_143326_Desc = {
    Text = "Recarregar Chave de Prata aumenta em [DescArg1]."
  },
  State_143326_Name = {
    Text = "Epifania de Causa e Efeito"
  },
  State_143331_Desc = {
    Text = "Antes do fim do próximo turno, absorve metade do Dano por <StatusApplier:>, este Estado é Equipe Única, é removido quando qualquer um dos dois vinculados morre, não pode ser dispersado."
  },
  State_143331_Name = {
    Text = "Receber Dano"
  },
  State_143333_Desc = {
    Text = "Antes do início do próximo turno, <StatusApplier:> absorve metade do Dano por ele, este Estado é Equipe Única, é removido quando qualquer um dos dois vinculados morre, não pode ser dispersado."
  },
  State_143333_Name = {
    Text = "Desvio de Dano"
  },
  State_143336_Desc = {
    Text = "Ao Disparar \"Gaunt\", consome 1 camada para fazê-lo Tomar efeito 1 vez adicional, com limite de 9 camadas, não sendo removido ao fim do combate."
  },
  State_143336_Name = {
    Text = "<BattueKeywords:Caça>"
  },
  State_143340_Desc = {
    Text = "Ao Disparar \"Gaunt\", consome 1 camada para fazê-lo Tomar efeito 1 vez adicional, com limite de 9 camadas, não sendo removido ao fim do combate."
  },
  State_143340_Name = {
    Text = "<BattueKeywords:Caça>"
  },
  State_143386_Desc = {
    Text = "Absorve metade do Dano por <StatusApplier:>, não pode ser dispersado."
  },
  State_143386_Name = {
    Text = "Receber Dano"
  },
  State_143387_Desc = {
    Text = "<StatusApplier:> absorve metade do Dano por ele, não pode ser dispersado."
  },
  State_143387_Name = {
    Text = "Desvio de Dano"
  },
  State_143406_Name = {
    Text = "Esta Carta toma efeito [DescArg1] vez(es) adicional(is)"
  },
  State_143408_Desc = {
    Text = "Quando atacado por um inimigo, converte para a Fúria do atacante."
  },
  State_143408_Name = {
    Text = "A Bússola Errante"
  },
  State_143409_Desc = {
    Text = "Quando atacado por um inimigo, converte para a Fúria do atacante."
  },
  State_143409_Name = {
    Text = "<CardKeyWord:A Bússola Errante>"
  },
  State_143419_Desc = {
    Text = "Esta carta vem de <PVPDerivativeCardKeywords_31:\"Tesouro de Aurita\">."
  },
  State_143419_Name = {
    Text = "Tesouro de Aurita"
  },
  State_143426_Desc = {
    Text = "Após o início do turno, deduz [Layer] de Poder de cálculo, não pode ser dispersado."
  },
  State_143426_Name = {
    Text = "Dedução de Poder de cálculo com Latência"
  },
  State_143441_Desc = {
    Text = "Corpo Desperto selecionado na rodada [StateArg1] de operação."
  },
  State_143441_Name = {
    Text = "Marcador de Teste 1"
  },
  State_143442_Desc = {
    Text = "Corpo Desperto selecionado na rodada [StateArg1] de operação."
  },
  State_143442_Name = {
    Text = "Marcador de Teste 2"
  },
  State_143444_Desc = {
    Text = "Corpo Desperto selecionado na rodada [StateArg1] de operação."
  },
  State_143444_Name = {
    Text = "Marcador de Teste 4"
  },
  State_143445_Desc = {
    Text = "Corpo Desperto selecionado na rodada [StateArg1] de operação."
  },
  State_143445_Name = {
    Text = "Marcador de Teste 3"
  },
  State_143499_Name = {
    Text = "Imunidade a Dano ativo__\"Apenas para desenvolvimento\""
  },
  State_143500_Name = {
    Text = "Imunidade a Dano puro__\"Apenas para desenvolvimento\""
  },
  State_143541_Desc = {
    Text = "O Dano causado por todos os inimigos neste turno é reduzido em [DescArg1]%, e você obtém [DescArg2] pontos de Força."
  },
  State_143541_Name = {Text = "Guarda"},
  State_143542_Desc = {
    Text = "Dano Final Temporário +[DescArg1]%, e causa Corrosão de [DescArg2]% da Vida máxima a todos os inimigos."
  },
  State_143542_Name = {Text = "Caçar"},
  State_143548_Desc = {
    Text = "Causa Escudo e adiciona Estado, monstro, ramificação 1."
  },
  State_143548_Name = {
    Text = "Desvio de Escudo do Monstro 1"
  },
  State_143549_Desc = {
    Text = "Causa Escudo e adiciona Estado, Corpo Desperto, ramificação 2."
  },
  State_143549_Name = {
    Text = "Desvio de Escudo do Personagem 2"
  },
  State_143550_Desc = {
    Text = "Causa Escudo e adiciona Estado, Corpo Desperto, ramificação 1."
  },
  State_143550_Name = {
    Text = "Desvio de Escudo do Personagem 1"
  },
  State_143551_Desc = {
    Text = "Causa Escudo e adiciona Estado, monstro, ramificação 2."
  },
  State_143551_Name = {
    Text = "Desvio de Escudo do Monstro 2"
  },
  State_143552_Desc = {
    Text = "Causa Escudo e adiciona Estado, jogador, ramificação 1."
  },
  State_143552_Name = {
    Text = "Desvio de Escudo do Jogador 1"
  },
  State_143553_Desc = {
    Text = "Causa Escudo e adiciona Estado, jogador, ramificação 2."
  },
  State_143553_Name = {
    Text = "Desvio de Escudo do Jogador 2"
  },
  State_143573_Desc = {
    Text = "Gaunt é uma carta de bônus de Pontos, com 3 tipos: \"Gaunt-Invasor\", \"Gaunt-Provocador\" e \"Gaunt-Matador\". Ao gerar um \"Gaunt\" permanente, se o número de \"Gaunt\" permanentes exceder 6, um \"Gaunt\" permanente aleatório será melhorado para \"Gaunts Conjuntos\" com Consumo de potência de cálculo +1, mas que Toma efeito 1 vez adicional. Um \"Gaunts Conjuntos\" no baralho conta como 2 \"Gaunt\". Se todos os \"Gaunt\" já foram melhorados, coloque 1 \"Inspiração avançada\" com <DestructionKeywords:Destruir> na mão."
  },
  State_143573_Name = {Text = "Gaunt"},
  State_143578_Desc = {
    Text = "Neste turno, sempre que receber Dano ativo, coloque [Layer] carta(s) <PVPDerivativeCardKeywords_30:\"Thrall-Gaunt de Caça\"> na Mão."
  },
  State_143578_Name = {
    Text = "Ritual do Senhor"
  },
  State_143595_Desc = {
    Text = "Esta Carta recebeu <PrepareKeywords:Pronto> [StateArg1]."
  },
  State_143595_Name = {
    Text = "Passo de Dança do Cisne Negro"
  },
  State_143597_Desc = {
    Text = "Equipe Única: O efeito de Redução de força causado pelo Portador é aumentado em <WeaponEffect_Num:[StateArg1]%>. Ao alternar para a postura \"Onda de Ira\", o Dano Crítico Temporário aumenta em uma quantidade igual a <WeaponEffect_Num:[StateArg1]%> do próprio Dano Crítico base, com recarga de 3 rodadas."
  },
  State_143597_WeaponDesc = {
    Text = "O efeito de Redução de força causado pelo Portador é aumentado em <WeaponEffect_Num:[StateArg1]%>. Após alternar para a postura \"Onda de Ira\", o Dano Crítico Temporário aumenta em <WeaponEffect_Num:[DescArg1]%>, com recarga de 3 rodadas."
  },
  State_143598_Desc = {
    Text = "Equipe Única: O efeito de Redução de força causado pelo Portador é aumentado em <WeaponEffect_Num:[StateArg1]%>. Cada Eliminação de 1 inimigo aumenta em 2 pontos a Fúria recuperada de forma fixa ao final do turno de exploração do Portador nesta partida, podendo acumular no máximo <WeaponEffect_Num:[StateArg2]> vezes. Após alternar para a postura \"Onda de Ira\", o Dano Crítico Temporário aumenta em uma quantidade igual a <WeaponEffect_Num:[StateArg1]%> do próprio Dano Crítico base, com recarga de 3 rodadas."
  },
  State_143598_WeaponDesc = {
    Text = "O efeito de Redução de força causado pelo Portador é aumentado em <WeaponEffect_Num:[StateArg1]%>. Cada Eliminação de 1 inimigo aumenta em 2 pontos a Fúria recuperada de forma fixa ao final do turno de exploração do Portador nesta partida, podendo acumular no máximo <WeaponEffect_Num:[StateArg2]> vezes. Após alternar para a postura \"Onda de Ira\", o Dano Crítico Temporário aumenta em <WeaponEffect_Num:[DescArg1]%>, com recarga de 3 rodadas."
  },
  State_143683_Desc = {
    Text = "O Perseguir deste Corpo Desperto está Selado e não pode ser usado, o Selo é removido após [Layer] rodadas."
  },
  State_143683_Name = {
    Text = "<Seal1:Perseguir Selo>"
  },
  State_144381_Desc = {
    Text = "Não pode realizar Ações. Restante: [DescArg1] turno(s)."
  },
  State_144381_Name = {
    Text = "<Yishiganshe:Interferência de Consciência>"
  },
  State_144441_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Quando um aliado morre, ganha <Energy:[Energy:StateArg1]> de Fúria. Quando um aliado é ressuscitado, ele ganha <Energy:[Energy:StateArg2]> de Fúria. O efeito de ganho de Fúria só é ativado quando a Fúria do alvo não está cheia. Resta [Layer] ativação(ões); após esgotar as ativações, esta Roda do destino é Destruída."
  },
  State_144441_Name = {
    Text = "Sincronização de Almas"
  },
  State_144494_Desc = {
    Text = "Existem 7 tipos de efeitos, incluindo: comprar 8 cartas, ganhar 6 de Poder de cálculo, ganhar Energia de chave, todos os Corpos Despertos ganham Fúria Fixa, ganhar FOR, reduzir temporariamente a FOR de todos os inimigos, aumentar temporariamente o Dano potencializado."
  },
  State_144494_Name = {
    Text = "<Blessing:Bênção>"
  },
  State_144508_Desc = {
    Text = "\"Preço\" vem em 3 tipos:\n\nChance Perdida: Atrasa o efeito do \"Presente\" associado em 2 turnos.\nPalavras Douradas: Reduz o efeito do \"Presente\" associado em 50%.\nMalícia Velada: Inflige 1 efeito negativo aleatório na sua equipe:\n<Italic:2 turnos de Sintoma: Enfraquecer; 2 turnos de Frágil, 2 turnos de Lesão grave; capas de Envenenamento iguais a 1% da Vida máxima; 2 capas de Vazio; 1 capa de Stase em 2 cartas aleatórias na mão; ou gera 2 Cartões de sintomas Temporários (que não persistem entre batalhas) e os coloca no topo do Mazo de robo.>"
  },
  State_144508_Name = {
    Text = "<BlessingNegativeEffect:Preço>"
  },
  State_144519_Desc = {
    Text = "Valor de processo de teste, Atualizar após o início do turno ou ao Disparar uma Carta. Atualmente possui [Layer] espíritos do domínio."
  },
  State_144519_Name = {
    Text = "Espírito do novo Domínio do Caos"
  },
  State_145228_Name = {
    Text = "<WormGrowth:Repasto>"
  },
  State_145229_Desc = {
    Text = "Você faz parte da Bênção~! Pode ser consumido pela Fúria Explosiva de Caraboo para um bônus, acumula até 5 capas. Persiste entre batalhas."
  },
  State_145229_Name = {
    Text = "<SacrificialMark:Sacrifício>"
  },
  State_145436_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: O Dano de \"golpear\" aumenta [DescArg1]%, a cada \"golpear\" o Dano aumenta adicionalmente [StateArg2]%, podendo aumentar no máximo até [StateArg3]%."
  },
  State_145436_Name = {
    Text = "Ossos da Fome Imortal"
  },
  State_145437_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Ao equipar, obtém [StateArg2] capas de <EnergyStorageKeywords:Carregar>, o Dano de \"golpear\" aumenta [StateArg1]% e passa a ser <PVPPunctureDamagewords:Dano de perfuração>."
  },
  State_145437_Name = {
    Text = "Ruína Celestial"
  },
  State_145456_Desc = {
    Text = "Ao selecionar alvos, ignora Provocação, Infiltração e Mira. Se vários alvos tiverem condições iguais, prioriza o Corpo Desperto mais à frente."
  },
  State_145456_Name = {
    Text = "Vida e Escudo Mínimos"
  },
  State_145457_Desc = {
    Text = "Ao selecionar alvos, ignora Provocação, Infiltração e Mira. Se vários alvos tiverem condições iguais, prioriza o Corpo Desperto mais à frente."
  },
  State_145457_Name = {
    Text = "Vida e Escudo Máximos"
  },
  State_145495_Desc = {
    Text = "Esta Carta é disparada com Disparo Duplo."
  },
  State_145495_Name = {
    Text = "<CardKeyWord:Disparo Duplo>"
  },
  State_145554_Desc = {
    Text = "Único na equipe: Após o início da exploração, adicione 1 carta <Falltospace1[StateArg3]:「Pisar no Mundo dos Homens」> ao baralho. 「Pisar no Mundo dos Homens」: Consome 0 de poder de cálculo. Causa a todos os inimigos dano fixo de <WeaponEffect_Num:[StateArg1]%> do ataque do portador e <WeaponEffect_Num:[Float:StateArg4]%> da vida máxima de <Corrosion:erosão> fixa, faz com que as cartas de comando de outros Despertos em campo recebam <ErosionColorInkKeywords:confusão cognitiva> e embaralha 1 carta <Falltospace2[StateArg3]:「Queda Ascendente」> no monte de compras. <RetainIconKeywords:Reter>. <DepleteIconKeywords:Consumir>."
  },
  State_145554_Name = {
    Text = "Descida Ascendente"
  },
  State_145554_WeaponDesc = {
    Text = "Após o início da exploração, adicione 1 <Falltospace1[StateArg3]:\"Estadia Mortal\"> ao baralho. \"Estadia Mortal\": Consumo 0 Poder de cálculo. Causa <Corrosion:Corrosão> fixa a todos os inimigos igual a <WeaponEffect_Num:[StateArg1]%> da Força de ataque do Portador e <WeaponEffect_Num:[Float:StateArg4]%> da Vida máxima, faz com que as Cartas de comando de outros Corpos Despertos em cada local recebam <ErosionColorInkKeywords:Distorção de Percepção> e Embaralha 1 <Falltospace2[StateArg3]:\"Descida Ascendente\"> no Mazo de robo. <RetainIconKeywords:Preservar>. <DepleteIconKeywords:Consumo>"
  },
  State_145572_Desc = {
    Text = "A cada início de turno, todos os outros Corpos Despertos causam <Damage:[Damage:Layer]> de Dano de perfuração."
  },
  State_145572_Name = {
    Text = "Tempestade Devoradora de Cetus"
  },
  State_145590_Desc = {
    Text = "Quando uma Carta idêntica com a mesma origem é colocada na mão, o efeito de Fusão é ativado e essa Carta é consumida."
  },
  State_145590_Name = {
    Text = "<CardKeyWord:Fusão>"
  },
  State_145592_Desc = {
    Text = "Trava um inimigo, tornando-o o alvo de ataque prioritário. Ao selecionar um alvo único, só é possível selecionar o alvo travado, ignorando Provocação e ocultação."
  },
  State_145592_Name = {
    Text = "<CardKeyWord:Travar>"
  },
  State_145619_Name = {
    Text = "Lesão grave"
  },
  State_145620_Name = {Text = "Vazio"},
  State_145621_Desc = {
    Text = "O efeito \"Bênção\" é reduzido em 50%."
  },
  State_145621_Name = {
    Text = "<Bleesing_Exaggerate:Exagero>"
  },
  State_145622_Name = {
    Text = "Desaceleração"
  },
  State_145623_Desc = {
    Text = "Inflige 1 efeito negativo aleatório na sua equipe:\n<Italic:2 turnos de Sintoma: Enfraquecer; 2 turnos de Frágil, 2 turnos de Lesão grave; capas de Envenenamento iguais a 1% da Vida máxima; 2 capas de Vazio; 1 capa de Stase em 2 cartas aleatórias na mão; ou gera 2 Cartões de sintomas Temporários (que não persistem entre batalhas) e os coloca no topo do Mazo de robo.>"
  },
  State_145623_Name = {
    Text = "<Bleesing_Negative:Malícia Velada>"
  },
  State_145624_Name = {Text = "Fraqueza"},
  State_145625_Name = {
    Text = "2 \"Cartões de sintomas\" temporários idênticos"
  },
  State_145626_Name = {Text = "Frágil"},
  State_145627_Name = {
    Text = "Envenenamento"
  },
  State_145628_Desc = {
    Text = "Obtém o efeito \"Bênção\" após 2 turnos."
  },
  State_145628_Name = {
    Text = "<Bleesing_Delay:Oportunidade Perdida>"
  },
  State_145631_Desc = {
    Text = "O Dano de \"golpear\" aumenta [StateArg1]% e passa a ser <PVPPunctureDamagewords:Dano de perfuração>."
  },
  State_145631_Name = {
    Text = "Ruína Celestial"
  },
  State_145632_Desc = {
    Text = "Esta carta vem da Roda do destino \"Hora da Fortuna\"."
  },
  State_145632_Name = {
    Text = "Hora da Fortuna"
  },
  State_145638_Desc = {
    Text = "O Consumo de potência de cálculo desta Carta aumenta em [Layer]."
  },
  State_145638_Name = {
    Text = "Saudação Cruel"
  },
  State_145642_Desc = {
    Text = "Após 2 rodadas, todos os Corpos Despertos obtêm [StateArg1] pontos de Fúria [Layer] vez(es)."
  },
  State_145642_Name = {
    Text = "Loucura retardada"
  },
  State_145644_Desc = {
    Text = "Após 2 rodadas, obtém <Posse:[StateArg1]> pontos de Energia da Chave de Prata [Layer] vez(es)."
  },
  State_145644_Name = {
    Text = "Energia da Chave de Prata com Latência"
  },
  State_145645_Desc = {
    Text = "Após 2 rodadas, reduz temporariamente [StateArg1] pontos de <ExhaustionIconKeywords:Força> de todos os inimigos [Layer] vez(es)"
  },
  State_145645_Name = {
    Text = "Esgotamento retardado"
  },
  State_145646_Desc = {
    Text = "Após 2 rodadas, obtém [StateArg1] pontos de Poder de cálculo [Layer] vez(es)."
  },
  State_145646_Name = {
    Text = "Aritmética de atraso"
  },
  State_145647_Desc = {
    Text = "Após 2 rodadas, obtém [StateArg1] pontos de <PowerIconKeywords:Força> [Layer] vez(es)."
  },
  State_145647_Name = {
    Text = "Força com Latência"
  },
  State_145648_Desc = {
    Text = "Após 2 rodadas, compra [StateArg1] carta(s) [Layer] vez(es)."
  },
  State_145648_Name = {
    Text = "Tiragem atrasada"
  },
  State_145649_Desc = {
    Text = "Após 2 rodadas, Dano potencializado temporário [StateArg1]% [Layer] vez(es)."
  },
  State_145649_Name = {
    Text = "Latência de Dano Potencializado Temporário"
  },
  State_145652_Desc = {
    Text = "O consumo aritmético desta carta diminui em -[Layer]."
  },
  State_145652_Name = {
    Text = "Liberdade Inquebrável"
  },
  State_145654_Desc = {
    Text = "Teste. Após ser Disparada, ou ao sair da Mão, Destruir."
  },
  State_145654_Name = {
    Text = "Teste. Instante"
  },
  State_145660_Desc = {
    Text = [=[
Aliados
1.<AllyPosAwaker1Name:> [DescArg1]
2.<AllyPosAwaker2Name:> [DescArg2]
3.<AllyPosAwaker3Name:> [DescArg3]
4.<AllyPosAwaker4Name:> [DescArg4]
Inimigos
1.<EnemyPosAwaker1Name:> [DescArg5]
2.<EnemyPosAwaker2Name:> [DescArg6]
3.<EnemyPosAwaker3Name:> [DescArg7]
4.<EnemyPosAwaker4Name:> [DescArg8]]=]
  },
  State_145660_Name = {
    Text = "Variação de Vida após Redefinir"
  },
  State_145693_Desc = {
    Text = "Após o final do turno, consumo de aritmética -[Layer], mesmo ao ser descartado, esse efeito é ativado"
  },
  State_145693_Name = {
    Text = "<PrepareKeypvewordscolour:preparar[Layer]>"
  },
  State_145693_WeaponDesc = {
    Text = "As cartas não entram na pilha de descarte na fase de descarte, mas permanecem na mão"
  },
  State_145694_Name = {
    Text = "Empatia com o Pântano Negro"
  },
  State_145698_Desc = {
    Text = "Prioriza ATQ ao alvo com Travar <StatusApplier:>, ao selecionar um alvo único só pode selecionar alvos travados, ignorando Provocação e ocultação."
  },
  State_145698_Name = {Text = "Mira"},
  State_145699_Desc = {
    Text = "·Prioriza o ATQ ao <StatusApplier:> travado. Ao selecionar um alvo único, só é possível selecionar o alvo travado, ignorando Provocação e ocultação.\n·Após a própria morte, <StatusApplier:> ganha \"<PVPDerivativeCardKeywords_32:Venha Lutar!>\"."
  },
  State_145699_Name = {Text = "Mira"},
  State_145709_Desc = {
    Text = "Cada capa aumenta a Vida máxima em 10% da Constituição de Caraboo (máx. 50 capas). Ao atingir o máximo de capas, as capas excedentes curam em 3× esse valor de Vida. Até 10 capas de \"Saciedade\" podem ser obtidas por batalha sem Chefe. \"Saciedade\" persiste entre batalhas."
  },
  State_145709_Name = {
    Text = "<WormGrowth:Repasto>"
  },
  State_145710_Desc = {
    Text = "Você faz parte da Bênção~! Pode ser consumido pela Fúria Explosiva de Caraboo para um bônus, acumula até 5 capas. Persiste entre batalhas."
  },
  State_145710_Name = {
    Text = "<SacrificialMark:Sacrifício>"
  },
  State_145901_Desc = {
    Text = [=[
Nosso lado
1.<AllyPosAwaker1Name:> [DescArg1]
2.<AllyPosAwaker2Name:> [DescArg2]
3.<AllyPosAwaker3Name:> [DescArg3]
4.<AllyPosAwaker4Name:> [DescArg4]]=]
  },
  State_145901_Name = {
    Text = "Variação de Vida após Redefinir"
  },
  State_146041_Desc = {
    Text = "Este Corpo Desperto sente que se desligou do tumulto mundano.\nNão pode realizar nenhuma Ação antes do fim do turno, reduz 99% do Dano recebido; se o alvo não tiver Resistência, o alvo obtém Resistência.\nNão pode realizar nenhuma Ação antes do fim do turno, reduz 99% do Dano recebido; se o alvo não tiver Resistência, o alvo obtém Resistência.\n·Ao fim do Efeito, causa <Damage:[Layer]> de Dano passivo a todos os aliados.\n·Se o alvo possuir Resistência ao ser aplicado, Enganação termina imediatamente e o Dano ao alvo é dobrado."
  },
  State_146041_Name = {
    Text = "Enganação"
  },
  State_146043_Desc = {
    Text = "No início do próximo turno, deduz [Layer] de Fúria."
  },
  State_146043_Name = {
    Text = "Dedução de Fúria com Latência"
  },
  State_146058_Desc = {
    Text = "Valor de processo de teste, Atualizar após o início do turno ou ao Disparar uma Carta. Atualmente deve ter [Layer]% de eficiência de ATQ."
  },
  State_146058_Name = {
    Text = "Eficiência de ATQ da Ordem de chave"
  },
  State_146059_Desc = {
    Text = "Valor de processo de teste, Atualizar após o início do turno ou ao Disparar uma Carta. Atualmente deve ter [Layer]% de eficiência de Defesa."
  },
  State_146059_Name = {
    Text = "Eficiência de Defesa da Ordem de chave"
  },
  State_146079_Desc = {
    Text = "Esta Carta retorna à mão após sair da mão."
  },
  State_146079_Name = {
    Text = "<Recycle:Retorna à mão ao sair>"
  },
  State_146085_Desc = {
    Text = "Alterar Poder de cálculo da Carta antes de Disparar neste turno"
  },
  State_146085_Name = {
    Text = "Alterar Poder de cálculo da Carta antes de Disparar neste turno"
  },
  State_146085_WeaponDesc = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_146086_Desc = {
    Text = "Alterar Poder de cálculo da Carta antes de Disparar neste turno"
  },
  State_146086_Name = {
    Text = "Alterar Poder de cálculo da Carta antes de Disparar neste turno"
  },
  State_146086_WeaponDesc = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_146117_Desc = {
    Text = "Pode ser consumido por \"<DerivativeCardKeywords_157:Osso da Espada>\" para obter bônus. Este estado pode acumular no máximo 15 camadas."
  },
  State_146117_Name = {
    Text = "<Shimieluotanhuodong2:Vontade de Luta>"
  },
  State_146129_Desc = {
    Text = "Dano Final de todos os Corpos Despertos +[Layer]%."
  },
  State_146129_Name = {
    Text = "Intenção Assassina do Céu-Baleia"
  },
  State_146147_Desc = {
    Text = "Pode ser consumido por \"<DerivativeCardKeywords_157:Osso da Espada>\" para obter bônus. Este estado pode acumular no máximo 15 camadas."
  },
  State_146147_Name = {
    Text = "<Shimieluotanhuodong1:Vontade de Luta>"
  },
  State_146154_Desc = {
    Text = "Faz o Corpo Desperto se sentir bem. Sua \"Habilidade\" será transformada em \"Bênção?\", consumindo a quantidade equivalente de capas após a transformação."
  },
  State_146154_Name = {
    Text = "<PVPBlessColour:Bênção>"
  },
  State_146155_Desc = {
    Text = "Este Corpo Desperto se sente bem.\n·A seguir, [Layer] cartas de \"Habilidade\" serão transformadas em \"Bênção?\", consumindo capas equivalentes após a transformação."
  },
  State_146155_Name = {Text = "Bendição"},
  State_146155_WeaponDesc = {Text = "Não"},
  State_146202_Desc = {
    Text = "Faz o Corpo Desperto sentir que se desligou do tumulto mundano.\nNão pode realizar nenhuma Ação antes do fim do turno, reduz 99% do Dano recebido. Se o alvo não tiver Resistência, ele ganhará Resistência.\n·Ao fim do efeito, causa Dano passivo equivalente ao número de capas a todos os aliados.\n·Se o alvo possuir Resistência no momento da aplicação, a Enganação termina imediatamente e o Dano ao alvo é dobrado."
  },
  State_146202_Name = {
    Text = "<CardKeyWord:Enganação>"
  },
  State_146352_Desc = {
    Text = "A cada 1 dano recebido, acumula [StateArg1] camadas de <Shimieluotanhuodong1:Vontade de Luta>"
  },
  State_146352_Name = {
    Text = "Endurecido pela Batalha"
  },
  State_146363_Desc = {
    Text = "No início do próximo turno, remove [Layer] de Vida. Ao perder Vida, reduz a quantidade equivalente de capas deste Estado."
  },
  State_146363_Name = {
    Text = "Aquilo que Não é Mentira"
  },
  State_146383_Desc = {
    Text = "Após adicionar estado, após disparar uma Carta, atualiza e exibe o Nível de Carga da Chave de Prata de cada Corpo Desperto."
  },
  State_146383_Name = {
    Text = "Entrada de Eficiência"
  },
  State_146384_Desc = {
    Text = "Valor P1 [StateArg1], Valor P2 [StateArg2], Valor P3 [StateArg3], Valor P4 [StateArg4]."
  },
  State_146384_Name = {
    Text = "Valor de Eficiência"
  },
  State_146385_Desc = {
    Text = "Após adicionar estado, após disparar uma Carta, atualiza e exibe o Nível de Carga da Chave de Prata de cada Corpo Desperto."
  },
  State_146385_Name = {
    Text = "Entrada de Nível"
  },
  State_146386_Desc = {
    Text = "Valor P1 [StateArg1], Valor P2 [StateArg2], Valor P3 [StateArg3], Valor P4 [StateArg4]."
  },
  State_146386_Name = {
    Text = "Valor de Nível"
  },
  State_146446_Desc = {
    Text = "Defesa do Corpo Desperto, P1: [StateArg1], P2: [StateArg2], P3: [StateArg3], P4: [StateArg4]."
  },
  State_146446_Name = {
    Text = "Lista de atributos de Defesa"
  },
  State_146448_Desc = {
    Text = "Força de ataque do Corpo Desperto, P1: força[StateArg1]intensidade[StateArg2], P2: força[StateArg3]intensidade[StateArg4], P3: força[StateArg5]intensidade[StateArg6], P4: força[StateArg7]intensidade[StateArg8]."
  },
  State_146448_Name = {
    Text = "Lista de atributos de Ataque"
  },
  State_146452_Desc = {
    Text = "Equipe Única: O Dano crítico de \"golpear\" do Portador aumenta em <WeaponEffect_Num:[StateArg1]%>. No fim do turno, o Dano crítico da próxima Fúria Explosiva do Portador aumenta em uma porcentagem igual a <WeaponEffect_Num:[StateArg2]%> de sua Fúria Básica; pode acumular no máximo 5 vezes."
  },
  State_146452_WeaponDesc = {
    Text = "O Dano crítico de \"golpear\" do Portador aumenta <WeaponEffect_Num:[StateArg1]%>. Ao fim do turno, o Dano crítico da próxima Fúria Explosiva do Portador aumenta <WeaponEffect_Num:[DescArg1]%>, podendo acumular no máximo 5 vezes (atualmente com bônus de [DescArg2]%)."
  },
  State_146456_Desc = {
    Text = "Equipe Única: O Dano crítico de \"golpear\" do Portador aumenta em <WeaponEffect_Num:[StateArg1]%>."
  },
  State_146456_WeaponDesc = {
    Text = "O Dano crítico de \"golpear\" do Portador aumenta <WeaponEffect_Num:[StateArg1]%>."
  },
  State_146534_Desc = {
    Text = "Após o início da Fase, adiciona ao Guardião os contêineres de cada mecanismo do Caos Primordial."
  },
  State_146534_Name = {
    Text = "Inicialização do Caos Primordial"
  },
  State_146535_Desc = {
    Text = "Contêiner de atributos."
  },
  State_146535_Name = {
    Text = "Identificador do Caos Primordial"
  },
  State_146536_Desc = {
    Text = "Contêiner de mecanismos."
  },
  State_146536_Name = {
    Text = "Mecanismo do Caos Primordial"
  },
  State_146644_Desc = {
    Text = "O Despertar do Conhecimento Espiritual obtém Pronto 1, e na primeira vez que disparar por turno, libera automaticamente a Ordem de chave carregada."
  },
  State_146644_Name = {
    Text = "Eco Primordial"
  },
  State_146645_Desc = {
    Text = "O novo Domínio do Caos libera automaticamente a Ordem de chave ao Disparar Despertar do Conhecimento Espiritual pela primeira vez por turno. Atualmente disponível."
  },
  State_146645_Name = {
    Text = "Identificador Disponível"
  },
  State_146646_Desc = {
    Text = "O limite máximo de Energia da Chave de Prata base é alterado para 2000. A regra de obtenção de Energia da Chave de Prata é substituída por: quando o Corpo Desperto Disparar uma Carta de comando pela primeira vez por turno, obtém Energia da Chave de Prata igual a 3x Recarregar Chave de Prata + 100."
  },
  State_146646_Name = {
    Text = "Nova regra de Energia de chave do Caos"
  },
  State_146651_Desc = {
    Text = "Aumenta o atributo de Força de ataque deste Corpo Desperto em [Layer]%."
  },
  State_146651_Name = {
    Text = "Caos · Ataque"
  },
  State_146652_Desc = {
    Text = "Apenas 1 vez após o início do combate, altera a eficiência de Recarregar Chave de Prata de cada Corpo Desperto para a média dos Níveis de Carga da Chave de Prata."
  },
  State_146652_Name = {
    Text = "Equilíbrio Primordial"
  },
  State_146653_Desc = {
    Text = "Aumenta o atributo de Defesa deste Corpo Desperto em [Layer]%."
  },
  State_146653_Name = {
    Text = "Caos · Defesa"
  },
  State_146663_Desc = {
    Text = "Os próximos [Layer] \"golpear\" de Lotan: Cetarcon tomam efeito 1 vez adicional."
  },
  State_146663_Name = {
    Text = "Tempestade Devoradora de Cetus"
  },
  State_147058_Name = {
    Text = "Anel da Sala 36 de Acessórios"
  },
  State_147079_Desc = {
    Text = "Esta carta não pode ser descartada ou transformada."
  },
  State_147079_Name = {
    Text = "<RetainIconKeywordsColour:Preservar Forçado>"
  },
  State_147545_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Não configurado"
  },
  State_147545_Name = {
    Text = "Tinct: Vespera SR (Texto Temporário)"
  },
  State_147546_Name = {Text = "Deprecated"},
  State_147546_WeaponDesc = {
    Text = "Voz fora do mundo"
  },
  State_147584_Desc = {
    Text = "O efeito de <Blessing:Graça> da próxima <DerivativeCardKeywords_152:\"Graça da Fada\"> disparada aumenta em 50%"
  },
  State_147737_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Ao equipar, ganha [StateArg1] de <MaxHPKeywords:Vida máxima>. No início do turno, causa <Damage:[Damage:StateArg2]> de dano de <PVPBleedingKeywords:Sangramento> a todos os inimigos,"
  },
  State_147737_Name = {
    Text = "Da escuridão à escuridão"
  },
  State_147764_Name = {
    Text = "Estado@Contagem de escolhas erradas na atividade de Caraboo"
  },
  State_147765_Desc = {
    Text = "No início do próximo turno, perde 2 pontos de Poder de cálculo e compra 2 cartas a menos."
  },
  State_147765_Name = {
    Text = "Pistoles de Marie"
  },
  State_147768_Desc = {
    Text = "No início do próximo turno, obtém [DescArg1] Inspirações avançadas."
  },
  State_147768_Name = {
    Text = "Moedas de Ouro de Pistoles de Marie"
  },
  State_147769_Desc = {
    Text = "\"Repasto\" acumulou [Layer] camada(s) nesta batalha."
  },
  State_147769_Name = {
    Text = "Limite de Acúmulo"
  },
  State_147772_Name = {
    Text = "Estado@Atividade de Caraboo adiciona limite temporário de Energia de chave"
  },
  State_147773_Name = {
    Text = "Estado@Atividade de Caraboo adiciona limite temporário de Energia de chave"
  },
  State_147774_Name = {
    Text = "Estado@Atividade de Caraboo adiciona limite temporário de Energia de chave_Caos comum"
  },
  State_147797_Desc = {
    Text = "Pode ganhar ou perder Fúria, <PowerIconKeywords:Força>, Vida, Energia da Chave de Prata, Poder de cálculo e comprar cartas."
  },
  State_147797_Name = {
    Text = "Pistoles de Marie"
  },
  State_147800_Desc = {
    Text = "No início do próximo turno, perde 2 pontos de Poder de cálculo e compra 2 cartas a menos."
  },
  State_147800_Name = {
    Text = "Pistoles de Marie"
  },
  State_147869_Name = {
    Text = "Compre [Layer] cartões"
  },
  State_147870_Name = {
    Text = "Aplica [Layer] turnos de fraqueza a todos os inimigos"
  },
  State_147871_Name = {
    Text = "Obtenha [Energy:DescArg1] pontos de loucura"
  },
  State_147872_Name = {
    Text = "Causa [Layer] rodadas de vulnerável a todos os inimigos"
  },
  State_147873_Name = {
    Text = "Obtenha [Layer] aritmética"
  },
  State_147874_Name = {
    Text = "Obtenha [Block:DescArg1] escudo"
  },
  State_147962_Desc = {
    Text = "Quando o jogador dispara \"<DerivativeCardKeywords_158:Expiação>\", ela apenas dispersa 50% das capas de <MonsterSinMarkKeywords:Marca do Crime>, e para cada Carta de comando disparada, \"Filho Santo · Noite Branca\" ganha 1 capa de <MonsterSinMarkKeywords:Marca do Crime>."
  },
  State_147962_Name = {
    Text = "Caminho da Purificação"
  },
  State_147967_Desc = {
    Text = "O dano causado por \"Divus: A Noite Branca\" inflige [DescArg1]% de <BleedingIconKeywords:Sangramento>."
  },
  State_147967_Name = {
    Text = "Marca do Crime"
  },
  State_147968_Desc = {
    Text = "Limite de 3 camadas. Ao mudar para a intenção de ataque, aumenta o dano causado por \"Divus: A Noite Branca\" em 25% e consome 1 camada."
  },
  State_147968_Name = {
    Text = "Redenção da dor"
  },
  State_147969_Desc = {
    Text = "Quando \"Divus: A Noite Branca\" estiver na intenção \"Sagrado Coração\", a cada Carta de comando disparada acumula 2 camadas de <MonsterPolluxFever:Fervor>."
  },
  State_147969_Name = {
    Text = "Nova Aliança Divina"
  },
  State_147971_Desc = {
    Text = "Este Corpo Desperto ainda não Despertou... Quando prestes a ser derrotado, a Vida será restaurada e ganhará 1 capa de <InvincibleUntilRoused:Blindagem Impenetrável>. Após Despertar, <InvincibleUntilRoused:Blindagem Impenetrável> é removida e ele começa a batalha em sua forma verdadeira."
  },
  State_147971_Name = {
    Text = "Ainda não despertado"
  },
  State_147972_Desc = {
    Text = "Cada camada faz o dano causado por \"Divus: A Noite Branca\" infligir 1% de <BleedingIconKeywords:Sangramento>."
  },
  State_147972_Name = {
    Text = "<MonsterSinMarkKeywords:Marca do Crime>"
  },
  State_147974_Desc = {
    Text = "Removido no início do turno. Ao atingir 10 camadas, após a próxima carta ser disparada, age imediatamente, remove o Fervor e muda a intenção para \"Sagrado Coração\"."
  },
  State_147974_Name = {
    Text = "Fervor temporário"
  },
  State_147975_Desc = {
    Text = "No início do combate, coloca uma carta \"<DerivativeCardKeywords_158:Expiação>\" na mão. Ao fim do turno, obtém 5 camadas de <MonsterSinMarkKeywords:Marca do Crime>."
  },
  State_147975_Name = {
    Text = "Portador da Luz"
  },
  State_147993_Desc = {
    Text = "Limite de 3 camadas. Ao mudar para a intenção de ataque, aumenta o dano causado por \"Divus: A Noite Branca\" em 25% e consome 1 camada."
  },
  State_147993_Name = {
    Text = "Redenção da dor"
  },
  State_148020_Desc = {
    Text = "Imune a todo dano e não pode perder Vida; removido após Despertar."
  },
  State_148020_Name = {
    Text = "Solidificação do Núcleo de Prata"
  },
  State_148021_Name = {
    Text = "Estado@Identificador de limpeza de Imunidade antes do Despertar de ressurreição genérica de monstro"
  },
  State_148073_Name = {
    Text = "Compre 1 carta"
  },
  State_148074_Desc = {
    Text = "As cartas não entram na pilha de descarte na fase de descarte, mas permanecem na mão"
  },
  State_148074_Name = {
    Text = "<RetainIconKeywords:Manter>"
  },
  State_148074_WeaponDesc = {
    Text = "As cartas não entram na pilha de descarte na fase de descarte, mas permanecem na mão"
  },
  State_148076_Name = {
    Text = "Monitoramento de cartas jogadas em Caminho da Purificação"
  },
  State_148116_Desc = {
    Text = "Após 1 rodada, compra [StateArg1] carta(s) [Layer] vez(es)."
  },
  State_148116_Name = {
    Text = "Tiragem atrasada1"
  },
  State_148381_Desc = {
    Text = "Até o fim do turno, o dano causado por si mesmo aplica 100% de <BleedingIconKeywords:Sangramento>."
  },
  State_148381_Name = {
    Text = "Rancor encadeirado"
  },
  State_148383_Desc = {
    Text = "Máximo de 3 capas. Se 3 capas de \"Matança sem fim\" forem mantidas, na próxima vez que a Intenção mudar para \"Cadeia de Sangue\", mude a Intenção para \"Bola Sanguinária\" e limpe \"Matança sem fim\"."
  },
  State_148383_Name = {
    Text = "\"Ressentimento\""
  },
  State_148385_Desc = {
    Text = "Sempre que o inimigo disparar uma Carta de comando, obtém 2 camadas de <MonsterB05EXFever:Fervor temporário>."
  },
  State_148385_Name = {
    Text = "forma irregular"
  },
  State_148386_Desc = {
    Text = "Não é possível obter Escudo até o fim do turno."
  },
  State_148386_Name = {
    Text = "Cadeias de Restrição"
  },
  State_148387_Desc = {
    Text = "Este Corpo Desperto ainda não Despertou... Quando prestes a ser derrotado, a Vida será restaurada e ganhará 1 capa de <InvincibleUntilRoused:Blindagem Impenetrável>. Após Despertar, <InvincibleUntilRoused:Blindagem Impenetrável> é removida e ele começa a batalha em sua forma verdadeira."
  },
  State_148387_Name = {
    Text = "Ainda não despertado"
  },
  State_148391_Desc = {
    Text = "Até o fim do turno, o dano causado por si mesmo aplica 100% de <BleedingIconKeywords:Sangramento>."
  },
  State_148391_Name = {
    Text = "Cadeias de Restrição"
  },
  State_148392_Desc = {
    Text = "Removido no início do turno. Ao atingir 10 camadas, após a próxima carta ser disparada, age imediatamente, remove o Fervor e muda a intenção para \"Cadeia de Sangue\"."
  },
  State_148392_Name = {
    Text = "Fervor temporário"
  },
  State_148394_Desc = {
    Text = "No início do turno, obtém 1 capa de <ResentChainsKeywords: Cadeia de Rancor>. Quando a intenção muda para \"Bola Sanguinária\", fica imune a todo dano e efeitos de perda de Vida até o fim do turno inimigo."
  },
  State_148394_Name = {
    Text = "Declaração do Ceifador de Almas"
  },
  State_148395_Desc = {
    Text = "Imune a todo dano (incluindo Dano de perfuração) e não pode perder Vida; removido após o fim do turno inimigo."
  },
  State_148395_Name = {
    Text = "Declaração do Ceifador de Almas - Bola Sanguinária"
  },
  State_148421_Desc = {
    Text = "Após 1 rodada, reduz temporariamente [StateArg1] ponto(s) de <ExhaustionIconKeywords:Força> de todos os inimigos [Layer] vez(es)"
  },
  State_148421_Name = {
    Text = "Latência de Exaustão 1"
  },
  State_148422_Desc = {
    Text = "Após 1 rodada, Dano potencializado temporário [StateArg1]% [Layer] vez(es)."
  },
  State_148422_Name = {
    Text = "Dano potencializado temporário retardado1"
  },
  State_148423_Desc = {
    Text = "Após 1 rodada, obtém <Posse:[StateArg1]> pontos de Energia da Chave de Prata [Layer] vez(es)."
  },
  State_148423_Name = {
    Text = "Latência de Energia da Chave de Prata 1"
  },
  State_148426_Desc = {
    Text = "Após 1 rodada, obtém [StateArg1] pontos de Poder de cálculo [Layer] vez(es)."
  },
  State_148426_Name = {
    Text = "Latência de poder de cálculo 1"
  },
  State_148427_Desc = {
    Text = "Após 1 rodada, todos os Corpos Despertos ganham [StateArg1] ponto(s) de Fúria [Layer] vez(es)."
  },
  State_148427_Name = {
    Text = "Loucura retardada1"
  },
  State_148428_Desc = {
    Text = "Após 1 rodada, obtém [StateArg1] pontos de <PowerIconKeywords:Força> [Layer] vez(es)."
  },
  State_148428_Name = {
    Text = "Latência de Força 1"
  },
  State_148511_Desc = {
    Text = "Equipe Única: Após o início da exploração, adiciona 1 carta <Backupbody[StateArg3]:\"Sincronização de Almas\"> ao baralho. \"Sincronização de Almas\": Consumo de potência de cálculo 0; ao Disparar, ganha 1 ponto de Poder de cálculo. <RetainIconKeywords:Preservar>: Acumula nesta carta uma quantidade fixa de recuperação de Vida equivalente a <WeaponEffect_Num:[StateArg1]%> da Constituição do Portador e <WeaponEffect_Num:[StateArg2]> pontos fixos de Fúria. Se esta carta não for Destruída, pode imunizar uma morte e liberar toda a recuperação de Vida e Fúria acumuladas; em seguida, <DestructionKeywords:Destruir> esta carta."
  },
  State_148511_Name = {
    Text = "Sincronização de Almas"
  },
  State_148511_WeaponDesc = {
    Text = "Após o início da exploração, adiciona 1 carta <Backupbody[StateArg3]:\"Sincronização de Almas\"> ao baralho. \"Sincronização de Almas\": Consumo de potência de cálculo 0; ao Disparar, ganha 1 ponto de Poder de cálculo. <RetainIconKeywords:Preservar>: Acumula nesta carta uma quantidade fixa de recuperação de Vida equivalente a <WeaponEffect_Num:[StateArg1]%> da Constituição do Portador e <WeaponEffect_Num:[StateArg2]> pontos fixos de Fúria. Se esta carta não for Destruída, pode imunizar uma morte e liberar toda a recuperação de Vida e Fúria acumuladas; em seguida, <DestructionKeywords:Destruir> esta carta."
  },
  State_148513_Desc = {
    Text = "O oponente não descartará a mão no final do turno. No final do turno, aplique 2 pilhas de <FragileIconKeywords:frágil>, <WeaknessIconKeywords:fraqueza>, <HeavyInjuryKeywords:ferimento grave>, e <VulnerabilityIconKeywords:vulnerável> na ordem."
  },
  State_148513_Name = {
    Text = "Voz fora do mundo"
  },
  State_148520_Desc = {
    Text = "Não é possível obter Escudo até o fim do turno."
  },
  State_148520_Name = {
    Text = "Rancor encadeirado"
  },
  State_148522_Desc = {
    Text = "Equipe Única: O Escudo e a força causados pela \"Fúria Explosiva\" do Portador aumentam em <WeaponEffect_Num:[StateArg1]%>."
  },
  State_148524_Desc = {
    Text = "Equipe Única: O Escudo e a força causados pela \"Fúria Explosiva\" do Portador aumentam em <WeaponEffect_Num:[StateArg1]%>. O Escudo causado pela \"Defesa\" do Portador aumenta em <WeaponEffect_Num:[StateArg2]%>. Após o Portador Disparar \"Defesa\", ganha força equivalente a <WeaponEffect_Num:[StateArg3]%> da Força de ataque do Portador."
  },
  State_148540_Desc = {
    Text = "Latência[Layer]: O Consumo de potência de cálculo das [StateArg1] Cartas de comando com maior Poder de cálculo de <AwakerName:[DescArg1]> é reduzido em [StateArg2]."
  },
  State_148540_Name = {
    Text = "Espelho da Previsão – Latência[Layer]"
  },
  State_148541_Name = {
    Text = "Remover o efeito \"Stase\" da carta do Corpo Desperto selecionado na mão"
  },
  State_148544_Desc = {
    Text = "Latência[Layer] : A próxima Fúria Explosiva de <AwakerName:[DescArg1]> ganha [StateArg1] pontos de Energia da Chave de Prata para cada 1 ponto de Fúria consumido."
  },
  State_148544_Name = {
    Text = "Chave de Goetia - Latência[Layer]"
  },
  State_148547_Desc = {
    Text = "A próxima Fúria Explosiva de <AwakerName:[DescArg1]> é tratada como Explosão Superalimentada; se já for uma Explosão Superalimentada, devolve 100% da Fúria Básica."
  },
  State_148547_Name = {
    Text = "Coroa da Eternidade"
  },
  State_148548_Desc = {
    Text = "Preservar: Todos os Corpos Despertos ganham 5 de Fúria."
  },
  State_148548_Name = {
    Text = "Absorto em Reflexão"
  },
  State_148549_Name = {
    Text = "Aciona todos os efeitos \"Pronto\" na mão"
  },
  State_148553_Desc = {
    Text = "Latência[Layer]: As próximas [Layer] Cartas de comando Disparadas por <AwakerName:[DescArg1]> obtêm Escudo equivalente a [StateArg2]% da Vida perdida."
  },
  State_148553_Name = {
    Text = "Fruto da Tentação – Latência[Layer]"
  },
  State_148554_Desc = {
    Text = "Os danos causados pelas Cartas de comando de <AwakerName:[DescArg1]> aplicam [Layer]% de Sangramento."
  },
  State_148554_Name = {
    Text = "Olho da Ruína"
  },
  State_148556_Desc = {
    Text = "Enquanto na mão, todos os Corpos Despertos infligem 10% de Sangramento adicional ao causar Dano ativo."
  },
  State_148556_Name = {
    Text = "Um Pesadelo Anunciado"
  },
  State_148557_Desc = {
    Text = "As próximas [Layer] Cartas de comando Disparadas por <AwakerName:[DescArg1]> obtêm Escudo equivalente a [StateArg1]% da Vida perdida."
  },
  State_148557_Name = {
    Text = "Fruto da Tentação"
  },
  State_148559_Desc = {
    Text = "A próxima Fúria Explosiva de <AwakerName:[DescArg1]> ganha [Layer] pontos de Energia da Chave de Prata para cada 1 ponto de Fúria consumido."
  },
  State_148559_Name = {
    Text = "Chave de Goetia"
  },
  State_148561_Desc = {
    Text = "Ao Disparar esta carta, aciona aleatoriamente um dos três efeitos negativos a seguir: Efeito reduzido em 50%/Latência de 2 rodadas para entrar em vigor/Obtém aleatoriamente 1 efeito negativo."
  },
  State_148561_Name = {
    Text = "<ExclamationPointColour:Desejo Distorcido>"
  },
  State_148562_Name = {
    Text = "O Corpo Desperto selecionado obtém 10 pontos de Fúria"
  },
  State_148563_Desc = {
    Text = "Latência[Layer]: O Escudo e a Cura de Vida obtidos na próxima Fúria Explosiva de <AwakerName:[DescArg1]> aumentam em [StateArg1]%."
  },
  State_148563_Name = {
    Text = "Pena da Justiça – Latência[Layer]"
  },
  State_148566_Desc = {
    Text = "Os danos causados pela próxima Fúria Explosiva de <AwakerName:[DescArg1]> aplicam [Layer]% de Veredito Final."
  },
  State_148566_Name = {
    Text = "Fio do Destino"
  },
  State_148569_Desc = {
    Text = "O Escudo e a Cura de Vida obtidos na próxima Fúria Explosiva de <AwakerName:[DescArg1]> aumentam em [Layer]%."
  },
  State_148569_Name = {
    Text = "Pena da Justiça"
  },
  State_148571_Desc = {
    Text = "Latência[Layer] : Os danos causados pelas Cartas de comando de <AwakerName:[DescArg1]> aplicam [StateArg1]% de Sangramento."
  },
  State_148571_Name = {
    Text = "Olho da Ruína - Latência[Layer]"
  },
  State_148574_Desc = {
    Text = "Latência[Layer] : Os danos causados pela próxima Fúria Explosiva de <AwakerName:[DescArg1]> aplicam [StateArg1]% de Veredito Final."
  },
  State_148574_Name = {
    Text = "Fio do Destino - Latência[Layer]"
  },
  State_148575_Name = {
    Text = "O Corpo Desperto selecionado obtém 20 pontos de Fúria"
  },
  State_149089_Name = {
    Text = "Estado@Marcador de Fúria de Pequeno Devorador do Cão da Lanterna"
  },
  State_149092_Desc = {
    Text = "Devorou <Energy:[Energy:DescArg2]> pontos de Fúria de \"<AwakerName:[DescArg1]>\"; devolvidos após a morte."
  },
  State_149092_Name = {Text = "Devorar"},
  State_149094_Desc = {
    Text = "Equipe Única: O Escudo Base gerado pela Fúria Explosiva do Portador +<WeaponEffect_Num:[StateArg1]%>. Após o Portador Disparar uma Carta de comando que causa <WeaknessIconKeywords:Sintoma: Enfraquecer>, o Escudo Base gerado pela próxima Carta de comando de equipamento +<WeaponEffect_Num:[StateArg1]%>. Não acumula. Ao usar \"Forno Carmesim\", compra a carta de habilidade do Portador com o maior Consumo de potência de cálculo, <EmbryoFusionIconKeywords:Fusão de embriões> +<WeaponEffect_Num:[StateArg1]%>, recarga de 3 turnos."
  },
  State_149094_WeaponDesc = {
    Text = "O Escudo Base de Fúria Explosiva do Portador +<WeaponEffect_Num:[StateArg1]%>. Após o Portador Disparar uma Carta de comando que causa <WeaknessIconKeywords:Sintoma: Enfraquecer>, o Escudo Base da Carta de comando do Portador +<WeaponEffect_Num:[StateArg1]%>. Ao usar \"Forno Carmesim\", Comprar carta a Carta de habilidade do Portador com o maior Consumo de potência de cálculo, <EmbryoFusionIconKeywords:Fusão de embriões> +<WeaponEffect_Num: [StateArg1]>, recarga de 3 turnos."
  },
  State_149122_Desc = {
    Text = "Ao morrer, invoca imediatamente 1 \"Cão da Lanterna\" aleatório com seu \"Efeito de enxame\" reduzido em 1 capa."
  },
  State_149122_Name = {
    Text = "Efeito de enxame"
  },
  State_149123_Desc = {
    Text = "O dano recebido de Fúria Explosiva é reduzido em 50%."
  },
  State_149123_Name = {
    Text = "Mod da Lanterna Sombria"
  },
  State_149124_Desc = {
    Text = "O dano recebido de Cartas de comando é reduzido em 50%."
  },
  State_149124_Name = {
    Text = "Mod da Lanterna Glacial"
  },
  State_149125_Desc = {
    Text = "Congelou a Carta de comando de \"<AwakerName:[DescArg1]>\"; o congelamento desse Corpo Desperto é removido após a morte."
  },
  State_149125_Name = {Text = "Devorar"},
  State_149126_Desc = {
    Text = "Ao morrer, invoca imediatamente 1 \"Cão da Lanterna\" aleatório com seu \"Efeito de enxame\" reduzido em 1 capa."
  },
  State_149126_Name = {
    Text = "Efeito de enxame"
  },
  State_149128_Name = {
    Text = "Estado@Marcador de Carta Congelada do Pequeno Cão da Lanterna de Gelo"
  },
  State_149140_Desc = {
    Text = "Amplia as habilidades do inimigo. Perde uma camada a cada dano recebido"
  },
  State_149140_Name = {
    Text = "Juramento de Sangue"
  },
  State_149143_Desc = {
    Text = "Após a fase de Comprar carta, para cada [DescArg1] Carta(s) de comando de <SlowIconKeywords:Desaceleração> na mão do inimigo, obtém [DescArg2] capa(s) de <BloodOath_New:Juramento de Sangue>. Após causar dano não bloqueado, aplica [DescArg4] capa(s) de <SlowIconKeywords:Desaceleração> a [DescArg3] Carta(s) de comando sem <SlowIconKeywords:Desaceleração> aleatórias na Mão ou no Mazo de robo."
  },
  State_149143_Name = {
    Text = "Voto Congelado"
  },
  State_149162_Desc = {
    Text = "Ao causar dano não bloqueado, remove a Resistência à Morte."
  },
  State_149162_Name = {
    Text = "Feitiçaria do Extremo Oriente"
  },
  State_149163_Desc = {
    Text = "Reduz a Vida máxima em quantidade igual às capas; reduzida pela metade ao fim do combate."
  },
  State_149163_Name = {
    Text = "<BoneHitKeywords:Calafrio>"
  },
  State_149164_Desc = {
    Text = "Ao causar dano, aplica Calafrio."
  },
  State_149164_Name = {
    Text = "Frio Penetrante"
  },
  State_149167_Desc = {
    Text = "Vida máxima reduzida em [Layer], reduzida à metade após o combate."
  },
  State_149167_Name = {
    Text = "<BoneHitKeywords:Calafrio>"
  },
  State_149169_Desc = {
    Text = "Cada capa aumenta a Vida máxima em 10% da Constituição de Caraboo (máx. 50 capas). Ao atingir o máximo de capas, as capas excedentes curam em 3× esse valor de Vida. Até 10 capas de \"Saciedade\" podem ser obtidas por batalha sem Chefe. \"Saciedade\" persiste entre batalhas."
  },
  State_149169_Name = {
    Text = "<WormGrowth:Repasto>"
  },
  State_149172_Desc = {
    Text = "Equipe Única: Após o Portador Disparar uma Carta de comando que inflige <WeaknessIconKeywords:Sintoma: Enfraquecer>, o Escudo Base gerado pela próxima Carta de comando de equipamento +<WeaponEffect_Num:[StateArg1]%>. Não acumula."
  },
  State_149172_WeaponDesc = {
    Text = "Após o Portador Disparar uma Carta de comando que inflige <WeaknessIconKeywords:Sintoma: Enfraquecer>, o Escudo Base de sua próxima Carta de comando +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_149187_Desc = {
    Text = "Teste | Monitora após receber Dano Fixo e após Dano Fixo causar Eliminação, e imprime o valor de ativação e o associado."
  },
  State_149187_Name = {
    Text = "Teste de Dano Fixo"
  },
  State_149188_Desc = {
    Text = "Teste｜Após Dano Fixo causar Eliminação, aciona valor 1, dano real da Eliminação:[Layer]"
  },
  State_149188_Name = {
    Text = "Teste de Valor de Ativação 2 de Eliminação por Dano Fixo"
  },
  State_149189_Desc = {
    Text = "Teste | Após Dano Fixo causar Eliminação, Associado 2, Fonte da Eliminação: [Layer]"
  },
  State_149189_Name = {
    Text = "Teste de Associado 2 de Eliminação por Dano Fixo"
  },
  State_149190_Desc = {
    Text = "Teste｜Após Dano Fixo causar Eliminação, aciona valor 1, dano excedente da Eliminação:[Layer]"
  },
  State_149190_Name = {
    Text = "Teste de acionamento de valor 3 por Eliminação Fixa"
  },
  State_149191_Desc = {
    Text = "Teste | Após receber Dano Fixo, Valor de ativação 1, Dano total: [Layer]"
  },
  State_149191_Name = {
    Text = "Teste de Valor de Ativação 1 de Dano Fixo"
  },
  State_149192_Desc = {
    Text = "Teste | Após Dano Fixo causar Eliminação, Associado 1, Alvo eliminado: [Layer]"
  },
  State_149192_Name = {
    Text = "Teste de Associado 1 de Eliminação por Dano Fixo"
  },
  State_149193_Desc = {
    Text = "Teste | Após receber Dano Fixo, Associado 2, Alvo atingido: [Layer]"
  },
  State_149193_Name = {
    Text = "Teste de Associado 2 de Dano Fixo"
  },
  State_149194_Desc = {
    Text = "Teste | Após receber Dano Fixo, Valor de ativação 1, Dano total: [Layer]"
  },
  State_149194_Name = {
    Text = "Teste de Valor de Ativação 2 de Dano Fixo"
  },
  State_149195_Desc = {
    Text = "Teste | Após Dano Fixo causar Eliminação, Valor de ativação 1, Dano total da Eliminação: [Layer]"
  },
  State_149195_Name = {
    Text = "Teste de Valor de Ativação 1 de Eliminação por Dano Fixo"
  },
  State_149196_Desc = {
    Text = "Teste | Após receber Dano Fixo, Associado 1, Fonte do dano: [Layer]"
  },
  State_149196_Name = {
    Text = "Teste de Associado 1 de Dano Fixo"
  },
  State_149227_Desc = {
    Text = "O Escudo não desaparece no fim do turno. Ao possuir Escudo, o Aumento de Dano Exaltado recebido aumenta em 50% e o dano recebido de Cartas de comando é reduzido em 50%."
  },
  State_149227_Name = {
    Text = "Manto Glacial"
  },
  State_149228_Desc = {
    Text = "Ao causar dano, aplica Sangramento."
  },
  State_149228_Name = {
    Text = "Perfuração Sanguínea"
  },
  State_149229_Desc = {
    Text = "Ao entrar em campo, perde 25% da Vida máxima, convertendo-a em \"Escudo de Gelo\" equivalente a [DescArg1]% do valor perdido."
  },
  State_149229_Name = {
    Text = "Conversão de Escudo de Gelo"
  },
  State_149230_Desc = {
    Text = "O dano recebido de Cartas de comando aumenta em 50% e o Aumento de Dano Exaltado recebido é reduzido em 50%."
  },
  State_149230_Name = {
    Text = "Estado@Aumento e Redução de Dano do Manto Umbral"
  },
  State_149232_Desc = {
    Text = "O Escudo não desaparece no fim do turno. Ao possuir Escudo, o dano recebido de Cartas de comando aumenta em 50% e o Aumento de Dano Exaltado recebido é reduzido em 50%."
  },
  State_149232_Name = {
    Text = "Manto Umbral"
  },
  State_149233_Desc = {
    Text = "O Aumento de Dano Exaltado recebido aumenta em 50% e o dano recebido de Cartas de comando é reduzido em 50%."
  },
  State_149233_Name = {
    Text = "Estado@Aumento e Redução de Dano do Manto Glacial"
  },
  State_149234_Desc = {
    Text = "Ao entrar em campo, perde 25% da Vida máxima, convertendo-a em \"Proteção Amaldiçoada\" equivalente a [DescArg1]% do valor perdido."
  },
  State_149234_Name = {
    Text = "Conversão de Proteção Amaldiçoada"
  },
  State_149235_Desc = {
    Text = "Ao causar dano não bloqueado, remove a Resistência à Morte."
  },
  State_149235_Name = {
    Text = "Feitiçaria da Lanterna"
  },
  State_149250_Desc = {
    Text = "Dano de Carta de comando recebido +50%"
  },
  State_149250_Name = {
    Text = "Dano de Carta de comando recebido +50%"
  },
  State_149251_Desc = {
    Text = "Dano de Carta de comando recebido -50%"
  },
  State_149251_Name = {
    Text = "Dano de Carta de comando recebido -50%"
  },
  State_149252_Desc = {
    Text = "Dano de Fúria Explosiva recebido -50%"
  },
  State_149252_Name = {
    Text = "Dano de Fúria Explosiva recebido -50%"
  },
  State_149253_Desc = {
    Text = "Dano de Fúria Explosiva recebido +50%"
  },
  State_149253_Name = {
    Text = "Dano de Fúria Explosiva recebido +50%"
  },
  State_149265_Desc = {
    Text = "Após a morte, invoca imediatamente um \"Wendigo\" aleatório, reduzindo seu \"Efeito de enxame\" em 1 camada."
  },
  State_149265_Name = {
    Text = "Efeito de enxame"
  },
  State_149268_Desc = {
    Text = "Ao perder todos os Escudos, obtém 75 camadas de Reforço Temporário e remove 1 camada de \"Manto da Nevasca\", substituindo a intenção por um ataque poderoso que aplica <BoneHitKeywords:Calafrio>."
  },
  State_149268_Name = {
    Text = "Manto da Nevasca"
  },
  State_149269_Desc = {
    Text = "Ao perder todos os Escudos, obtém 75 camadas de Reforço Temporário e remove 1 camada de \"Manto das Sombras\", substituindo a intenção por um ataque poderoso que rouba Fúria."
  },
  State_149269_Name = {
    Text = "Manto das Sombras"
  },
  State_149270_Desc = {
    Text = "Após a morte, invoca imediatamente um \"Wendigo\" aleatório, reduzindo seu \"Efeito de enxame\" em 1 camada."
  },
  State_149270_Name = {
    Text = "Efeito de enxame"
  },
  State_149308_Name = {
    Text = "Estado@Registro de Capas de Desaceleração do Orador de Oração da Lanterna"
  },
  State_149391_Desc = {
    Text = "Este Corpo Desperto ainda não Despertou... Quando prestes a ser derrotado, a Vida será restaurada e ganhará 1 capa de <InvincibleUntilRoused:Blindagem Impenetrável>. Após Despertar, <InvincibleUntilRoused:Blindagem Impenetrável> é removida e ele começa a batalha em sua forma verdadeira."
  },
  State_149391_Name = {
    Text = "Ainda não despertado"
  },
  State_149398_Desc = {
    Text = "Quando a intenção de \"Branca de Neve a Fada\" muda para \"Feitiço Nevado\", consome 1 camada e transforma a intenção em \"Bênção Milagrosa\"."
  },
  State_149398_Name = {Text = "Repasto"},
  State_149399_Desc = {
    Text = "Após \"Branca de Neve a Fada\" usar \"Conto de Fadas Perfeito\", as próximas [DescArg1] intenções serão todas \"Feitiço Nevado\". A cada turno, embaralha [DescArg2] cartas de <Blessing:Bênção> aleatórias com [DescArg3] camadas de <SlowIconKeywords:Desaceleração> no baralho."
  },
  State_149399_Name = {
    Text = "Fruta do Mel Tentadora"
  },
  State_149418_Desc = {
    Text = "não pode causar Golpe Crítico, não é considerado Dano básico e não é afetado por bônus como Dano Final."
  },
  State_149418_Name = {
    Text = "<RealDamage:dano fixo>"
  },
  State_149419_Name = {
    Text = "<Rune_6:Fortaleza>"
  },
  State_149420_Name = {
    Text = "<Rune_3:Destreza>"
  },
  State_149421_Name = {
    Text = "<Rune_15:Explosão>"
  },
  State_149422_Name = {
    Text = "<Rune_4:Planejamento>"
  },
  State_149423_Name = {
    Text = "<Rune_11:Domínio>"
  },
  State_149424_Name = {
    Text = "<Rune_12:Sede de Sangue>"
  },
  State_149425_Name = {
    Text = "<Rune_1:vulnerável>"
  },
  State_149426_Name = {
    Text = "<Rune_14:força bruta>"
  },
  State_149427_Name = {
    Text = "<Rune_2:Fraqueza>"
  },
  State_149428_Name = {
    Text = "<Rune_9:Espinho>"
  },
  State_149429_Name = {
    Text = "<Rune_10:Veneno>"
  },
  State_149430_Name = {
    Text = "<Rune_18:Esgotamento>"
  },
  State_149576_Desc = {
    Text = "Quando a intenção de \"Branca de Neve a Fada\" muda para \"Feitiço Nevado\", consome 1 camada e transforma a intenção em \"Bênção Milagrosa\"."
  },
  State_149576_Name = {Text = "Repasto"},
  State_149618_Desc = {
    Text = "Após 2 rodadas, aciona os seguintes efeitos:\nObtém [DescArg1] ponto(s) de Poder de cálculo. \nObtém [DescArg2] ponto(s) de Força. \nObtém [DescArg3] ponto(s) de Energia da Chave de Prata. \nObtém [DescArg5] ponto(s) de Fúria. \nCompra [DescArg6] carta(s).\nObtém [DescArg7] ponto(s) de Dano potencializado temporário.\nFaz todos os inimigos reduzirem temporariamente [DescArg4] ponto(s) de Força."
  },
  State_149618_Name = {
    Text = "Oportunidade Perdida2"
  },
  State_149619_Desc = {
    Text = "Após 1 rodada, aciona os seguintes efeitos:\nObtém [DescArg1] ponto(s) de Poder de cálculo. \nObtém [DescArg2] ponto(s) de Força. \nObtém [DescArg3] ponto(s) de Energia da Chave de Prata. \nObtém [DescArg5] ponto(s) de Fúria. \nCompra [DescArg6] carta(s).\nObtém [DescArg7] ponto(s) de Dano potencializado temporário.\nFaz todos os inimigos reduzirem temporariamente [DescArg4] ponto(s) de Força."
  },
  State_149619_Name = {
    Text = "Oportunidade Perdida1"
  },
  State_149628_Desc = {
    Text = "Se antes do fim do turno o inimigo tiver pelo menos 1000 pontos de Energia da Chave de Prata, Devorar 1000 de Energia da Chave de Prata."
  },
  State_149628_Name = {
    Text = "Sacrifício de Energia de chave"
  },
  State_149629_Desc = {
    Text = "Se antes do fim do turno o Corpo Desperto com maior Fúria tiver pelo menos 100 pontos de Fúria, Devorar 50 pontos de Fúria dele."
  },
  State_149629_Name = {
    Text = "Sacrifício de Fúria"
  },
  State_149630_Desc = {
    Text = "Se antes do fim do turno o inimigo tiver pelo menos 1000 pontos de Energia da Chave de Prata, Devorar 1000 de Energia da Chave de Prata."
  },
  State_149630_Name = {
    Text = "Sacrifício de Energia de chave"
  },
  State_149631_Desc = {
    Text = "Se o inimigo possuir pelo menos 3 pontos de Poder de cálculo antes do fim do turno, Devora 3 pontos de Poder de cálculo."
  },
  State_149631_Name = {
    Text = "Sacrifício de Poder de cálculo"
  },
  State_149632_Desc = {
    Text = "Se o inimigo possuir pelo menos 3 pontos de Poder de cálculo antes do fim do turno, Devora 3 pontos de Poder de cálculo."
  },
  State_149632_Name = {
    Text = "Sacrifício de Poder de cálculo"
  },
  State_149633_Desc = {
    Text = "Se antes da fase de descarte o inimigo tiver pelo menos 4 Cartas de comando restantes na Mão, Devorar 2 Cartas de comando aleatórias."
  },
  State_149633_Name = {
    Text = "Sacrifício de Carta"
  },
  State_149634_Desc = {
    Text = "Se antes da fase de descarte o inimigo tiver pelo menos 4 Cartas de comando restantes na Mão, Devorar 2 Cartas de comando aleatórias."
  },
  State_149634_Name = {
    Text = "Sacrifício de Carta"
  },
  State_149635_Desc = {
    Text = "Se antes do fim do turno o Corpo Desperto com maior Fúria tiver pelo menos 100 pontos de Fúria, Devorar 50 pontos de Fúria dele."
  },
  State_149635_Name = {
    Text = "Sacrifício de Fúria"
  },
  State_149652_Desc = {
    Text = "Não pode causar Golpe Crítico, não é considerado como Dano causado pelo Corpo Desperto correspondente."
  },
  State_149652_Name = {
    Text = "<FixedDamage:Dano Puro>"
  },
  State_149660_Desc = {
    Text = "O dano, Escudo e alteração de força causados por esta Carta aumentam em [DescArg2]%, o Efeito final do dano de tentáculo, recuperação de Vida, Envenenamento fixo e Contrataque fixo aumentam em [DescArg1]%; removido após ser Disparado."
  },
  State_149660_Name = {
    Text = "Reforço [DescArg1]"
  },
  State_149664_Desc = {
    Text = "A cada camada, o dano causado por esta Carta, o Aumento de Dano de força fixa e tentáculo, Envenenamento fixo e o Efeito final do Contrataque fixo aumentam em 2%; o Efeito final do Escudo fixo, recuperação de Vida fixa e Redução de força aumentam em 1%; removido após ser Disparado."
  },
  State_149664_Name = {Text = "Reforço"},
  State_149719_Name = {
    Text = "Imunidade a Dano Puro PVP__\"Apenas para desenvolvimento\""
  },
  State_149736_Desc = {
    Text = "As próximas [Layer] Cartas de comando de <AwakerName:[DescArg1]> têm seu Escudo Base aumentado em [StateArg1]%."
  },
  State_149736_Name = {
    Text = "Engano adocicado"
  },
  State_149744_Desc = {
    Text = "A próxima Bênção disparada não acionará efeito negativo"
  },
  State_149744_Name = {
    Text = "Imunidade a Debuffs"
  },
  State_149772_Desc = {
    Text = "Cada vez que Dano ativo é recebido, todos os Corpos Despertos perdem 3 de Fúria. Aciona no máximo 5 vezes por turno. Remove o Estado \"Proteção Amaldiçoada\" após o Escudo ser quebrado."
  },
  State_149772_Name = {
    Text = "Proteção Amaldiçoada"
  },
  State_149773_Desc = {
    Text = "Cada vez que Dano ativo é recebido, aplica 1 capa de \"Stase\" Temporária em 1 Carta aleatória na mão. Aciona no máximo 5 vezes por turno. Remove \"Escudo de Gelo\" após o Escudo ser quebrado."
  },
  State_149773_Name = {
    Text = "Escudo de gelo"
  },
  State_149782_Desc = {
    Text = "Esgotar: Após comprar cartas no próximo turno, embaralhe 1 \"Fruta Proteiforme\" no Mazo de robo."
  },
  State_149782_Name = {
    Text = "Fruta Proteiforme"
  },
  State_149787_Desc = {
    Text = "A cada 1 camada, o Dano Final das Cartas de comando de Ogier·Voto Maldito aumenta em [DescArg2]%, o número de cartas compradas no início do turno diminui em 1, o Dano crítico aumenta em [DescArg3]%, limite de [DescArg1] camadas, não é removido ao fim da batalha."
  },
  State_149787_Name = {
    Text = "<KuangNu:Corrente sombria>"
  },
  State_149788_Desc = {
    Text = "Ao disparar a \"Habilidade\" de Oath-Breaker·Ogier, consuma 1 capa para Comprar carta 1 carta de \"Defesa\", que ganha Preservar antes do próximo disparo. Máximo de [DescArg1] capas. Não é removido ao fim da batalha."
  },
  State_149788_Name = {
    Text = "<ShuZui:Autoculpa>"
  },
  State_149789_Desc = {
    Text = "A cada 1 camada, o Dano Final das Cartas de comando de Ogier·Voto Maldito aumenta em 33%, o número de cartas compradas no início do turno diminui em 1, limite de [DescArg1] camadas, não é removido ao fim da batalha."
  },
  State_149789_Name = {
    Text = "<KuangNu:Corrente sombria>"
  },
  State_149790_Desc = {
    Text = "A cada 1 camada, o Dano Final das Cartas de comando de Ogier·Voto Maldito aumenta em [DescArg2]%, o número de cartas compradas no início do turno diminui em 1, limite de [DescArg1] camadas, não é removido ao fim da batalha."
  },
  State_149790_Name = {
    Text = "<KuangNu:Corrente sombria>"
  },
  State_149791_Desc = {
    Text = "Ao disparar a \"Habilidade\" de Oath-Breaker·Ogier, consuma 1 capa para Comprar carta 1 carta de \"Defesa\", que ganha Preservar antes do próximo disparo. Máximo de [DescArg1] capas. Não é removido ao fim da batalha."
  },
  State_149791_Name = {
    Text = "<ShuZui:Autoculpa>"
  },
  State_149814_Desc = {
    Text = "Dano potencializado temporário +[Layer]."
  },
  State_149814_Name = {
    Text = "Dano potencializado temporário"
  },
  State_149819_Desc = {
    Text = "Imune a todo dano"
  },
  State_149819_Name = {Text = "Imunidade"},
  State_149892_Desc = {
    Text = "As próximas [Layer] Cartas de comando de <AwakerName:[DescArg1]> têm seu Escudo Base aumentado em [StateArg1]%."
  },
  State_149892_Name = {
    Text = "Verdade suave"
  },
  State_149913_Name = {
    Text = "Estado@Efeito do Tesouro do Verme Macrófago_Tinct Danificado"
  },
  State_149914_Name = {
    Text = "Estado@Efeito do Tesouro do Verme Macrófago_William Danificado"
  },
  State_149915_Name = {
    Text = "Estado@Efeito do Tesouro do Verme Macrófago_William"
  },
  State_149916_Name = {
    Text = "Estado@Efeito do Tesouro do Verme Macrófago_Castor Danificado"
  },
  State_149917_Name = {
    Text = "Estado@Efeito do Tesouro do Verme Macrófago_Cadeia de Sangue Helot Danificado"
  },
  State_149918_Name = {
    Text = "Estado@Teste de Início de Turno do Verme Macrófago"
  },
  State_149919_Name = {
    Text = "Estado@Efeito do Tesouro do Verme Macrófago_Tinct"
  },
  State_149920_Name = {
    Text = "Estado@Efeito do Tesouro do Verme Macrófago_Arachne"
  },
  State_149921_Name = {
    Text = "Estado@Efeito do Tesouro do Verme Macrófago_Arachne Danificado"
  },
  State_149922_Name = {
    Text = "Estado@Efeito do Tesouro do Verme Macrófago_Castor"
  },
  State_149923_Name = {
    Text = "Estado@Efeito do Tesouro do Verme Macrófago_Cadeia de Sangue Helot"
  },
  State_149930_Desc = {
    Text = "Para cada capa, as Cartas de comando de Oath-Breaker·Ogier têm seu Dano Final aumentado em 50%. No início do turno, contagem de Comprar carta -1. Máximo de [DescArg1] capas. Não é removido ao fim da batalha."
  },
  State_149930_Name = {
    Text = "<KuangNu2:Corrente sombria>"
  },
  State_149931_Desc = {
    Text = "Existem 7 tipos de efeitos, incluindo: ganhar STR, acumular Responder do Forno Carmesim, todos os Corpos Despertos ganham Fúria, bônus de Fusão de embriões, Comprar carta, ganhar Energia de chave e bônus de Dano potencializado Temporário."
  },
  State_149931_Name = {
    Text = "<Blessing:Bênção>"
  },
  State_149933_Name = {
    Text = "Estado@Bolha de Oferenda do Monstro Caraboo"
  },
  State_149934_Name = {
    Text = "Estado@Bolha de Oferenda do Monstro Caraboo"
  },
  State_149939_Desc = {
    Text = "Não é possível obter Escudo até o fim do turno."
  },
  State_149939_Name = {
    Text = "Cadeias de Restrição"
  },
  State_19507_Desc = {
    Text = "Antes do início da próxima rodada, o dano do ataque ativo e o número de camadas de sangramento aumentam em 25%, o que é negado quando aplicado com reforço."
  },
  State_19507_Name = {
    Text = "<PVPVulnerabilityIconColour:Vulnerável>"
  },
  State_19508_Desc = {
    Text = "No final do turno, descarte esta carta"
  },
  State_19508_Name = {
    Text = "<PVPVoidKeyColour:Nada>"
  },
  State_19509_Desc = {
    Text = "Mudar temporariamente a carta Aritmética. __ \"Para uso de desenvolvimento apenas\""
  },
  State_19509_Name = {
    Text = "Mudança permanente do poder de cálculo das cartas"
  },
  State_19511_Desc = {
    Text = "Após a morte, substitua as cartas da mão por cartas de ilusão"
  },
  State_19511_Name = {
    Text = "Morte aciona substituição de cartas da mão por Ilusão"
  },
  State_19513_Name = {
    Text = "Aplique deathmatch __ \"Para Desenvolvimento Apenas\""
  },
  State_19516_Name = {
    Text = "Mudar temporariamente a carta Aritmética __ \"Para uso de desenvolvimento apenas\""
  },
  State_19517_Desc = {
    Text = "Para cada 2% de vida perdida, ganha 1 ponto de Fúria"
  },
  State_19517_Name = {
    Text = "Sofrer dano concede Loucura __ \"Para uso exclusivo de desenvolvimento\""
  },
  State_19519_Desc = {
    Text = "Após usar \"Golpe\", consuma todas as camadas; cada camada aumenta o dano causado por este \"Golpe\" em 50%, acumulando até 5 camadas. (Atualmente aumentado em [DescArg1]%)"
  },
  State_19519_Name = {Text = "Carregar"},
  State_19521_Desc = {
    Text = "Cada camada aumenta todo o dano causado nesta batalha em 1 ponto, não pode ser dissipada."
  },
  State_19521_Name = {
    Text = "<PowerColourKeywords:Força>"
  },
  State_19522_Name = {
    Text = "Mudar temporariamente a carta Aritmética __ \"Para uso de desenvolvimento apenas\""
  },
  State_19523_Name = {
    Text = "Mudança permanente do poder de cálculo das cartas"
  },
  State_19524_Desc = {
    Text = "Antes do próximo turno, cada vez que for atacado, cause [Layer] de dano passivo ao atacante"
  },
  State_19524_Name = {
    Text = "Contrataque"
  },
  State_19525_Desc = {
    Text = "Remova o escudo do Despertador antes do início da rodada__ \"Para uso de desenvolvimento apenas\""
  },
  State_19525_Name = {
    Text = "Remova o escudo do personagem antes do início da rodada__ \"Para uso de desenvolvimento apenas\""
  },
  State_19527_Desc = {
    Text = "Cada capa aumenta o Consumo de potência de cálculo de \"Habilidade\" em +1 neste turno, máximo de 3 capas. Após Disparar, se o número de capas for maior que 1, as capas diminuem em -1."
  },
  State_19527_Name = {
    Text = "<SlowColour:Retardo>"
  },
  State_19528_Desc = {
    Text = "Possui cartas com efeitos poderosos"
  },
  State_19528_Name = {
    Text = "<SilverKeyColour:Chave>"
  },
  State_19529_Desc = {
    Text = "Cada vez que você dispara outra carta, reduz o Consumo de potência de cálculo desta carta em 1 para o próximo disparo; após disparar esta carta, retorna-a à sua mão e aumenta seu Consumo de potência de cálculo em 1, depois a descarta no fim do turno."
  },
  State_19529_Name = {
    Text = "<CardKeyWord:Ilusão>"
  },
  State_19530_Desc = {
    Text = ": Os oponentes priorizam atacar esta unidade. Quando os inimigos usam habilidades de alvo único, eles só podem selecionar o Despertador com provocação.\nAo ganhar provocação, remova sua própria Furtividade e a provocação de outros aliados, enquanto desfaz a Furtividade dos inimigos."
  },
  State_19530_Name = {
    Text = "<TauntColour:Provocação>"
  },
  State_19532_Desc = {
    Text = "O dano causado antes do fim desta rodada diminui em [DescArg1]%, e ao serem aplicados, é reduzido pelo fortalecimento"
  },
  State_19532_Name = {Text = "Fraqueza"},
  State_19533_Desc = {
    Text = "O dano causado antes do fim desta rodada diminui em 50%, e ao serem aplicados, é reduzido pelo fortalecimento"
  },
  State_19533_Name = {
    Text = "<WeaknessColour: Fraqueza>"
  },
  State_19534_Desc = {
    Text = "Antes do início da próxima rodada, o dano do ataque ativo e o número de camadas de sangramento aumentam em [DescArg1]%, o que é negado quando aplicado com reforço."
  },
  State_19534_Name = {
    Text = "Vulnerável"
  },
  State_19535_Desc = {
    Text = ": Os oponentes priorizam atacar esta unidade. Quando os inimigos usam habilidades de alvo único, eles só podem selecionar o Despertador com provocação.\nAo ganhar provocação, remova sua própria Furtividade e a provocação de outros aliados, enquanto desfaz a Furtividade dos inimigos."
  },
  State_19535_Name = {
    Text = "Provocação"
  },
  State_19536_Desc = {
    Text = "Ganhe 10 Loucura no final do turno__ \"Uso em Desenvolvimento apenas\""
  },
  State_19536_Name = {
    Text = "Ganhe acionamento de loucura no final do turno__ \"Uso em Desenvolvimento apenas\""
  },
  State_19537_Desc = {
    Text = "Dano aumentado em [DescArg1]% até o fim do turno, anula fraqueza ao aplicar"
  },
  State_19537_Name = {Text = "Reforço"},
  State_19538_Desc = {
    Text = "·No início dos turnos 8 e 9, ganhe 1 camada.\n·Cada camada de Duelo Mortal reduz a cura e escudo recebidos em 50% e diminui as camadas acumuláveis de barreira em 1.\n·Duelo Mortal não pode ser dissipado e afeta Despertados mortos"
  },
  State_19538_Name = {
    Text = "Duelo Mortal"
  },
  State_19540_Name = {
    Text = "Limite de capacidade de cálculo"
  },
  State_19541_Desc = {
    Text = "Antes do fim do turno, não é possível realizar nenhuma ação"
  },
  State_19541_Name = {Text = "Desmaio"},
  State_19544_Desc = {
    Text = "Após usar \"Golpe\", consuma todas as camadas; cada camada consumida aumenta o dano causado por este \"Golpe\" em 50%, acumulando até 5 camadas."
  },
  State_19544_Name = {
    Text = "<EnergyStorageColour:carga>"
  },
  State_19545_Name = {
    Text = "Esta carta é considerada \"golpear\"."
  },
  State_19546_Desc = {
    Text = "Mude o poder de cálculo das cartas antes de disparar."
  },
  State_19546_Name = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_19547_Desc = {
    Text = "No final do turno, sofre [Layer] de dano passivo. Persistente."
  },
  State_19547_Name = {
    Text = "Envenenamento"
  },
  State_19549_Desc = {
    Text = "Antes do início da próxima rodada, o dano sofrido por ataques ativos reduz em 50%, sendo neutralizado por vulnerabilidade ao ser aplicado"
  },
  State_19549_Name = {
    Text = "<ReinforceColour:reforçado>"
  },
  State_19552_Desc = {
    Text = "Você possui [Layer] pontos de escudo, o escudo não excederá a saúde máxima, e dura 1 turno"
  },
  State_19552_Name = {Text = "Escudo"},
  State_19553_Desc = {
    Text = "Ganhe contra-ataque após a fase de puxar __ \"Apenas Para Desenvolvimento\""
  },
  State_19553_Name = {
    Text = "Desencadeamento retardado __ \"Para uso de desenvolvimento apenas\""
  },
  State_19554_Name = {
    Text = "Estado vazio"
  },
  State_19555_Desc = {
    Text = "·O Consumo de potência de cálculo de \"Habilidade\" aumenta em +[Layer] neste turno, máximo de 3 capas.\n·Após Disparar uma \"Habilidade\", se o número de capas for maior que 1, as capas diminuem em -1."
  },
  State_19555_Name = {
    Text = "Desaceleração"
  },
  State_19556_Desc = {
    Text = "No final do turno, o Custo Aritmético desta carta é reduzido em -[Layer]."
  },
  State_19556_Name = {
    Text = "<PrepareKeywords:Preparar [Layer]>"
  },
  State_19557_Desc = {
    Text = "Antes do início da próxima rodada, o dano sofrido por ataques ativos reduz em [DescArg1]%, sendo neutralizado por vulnerabilidade ao ser aplicado"
  },
  State_19557_Name = {Text = "Reforço"},
  State_19558_Name = {
    Text = "Reviver biblioteca de cartas adicionar gatilho de cartas__ \"Para uso de desenvolvimento apenas\""
  },
  State_19560_Desc = {
    Text = "Antes do final do turno, não é possível usar a exaltação"
  },
  State_19560_Name = {Text = "Selo"},
  State_19561_Name = {
    Text = "Pode ser usado 3 vezes"
  },
  State_19990_Desc = {
    Text = "No início do próximo turno, ganhe [Layer] de loucura"
  },
  State_19990_Name = {
    Text = "Loucura retardada"
  },
  State_19992_Desc = {
    Text = "Quando em Desmaio, o alvo não pode agir até o final do turno. Sofrer dano de Desmaio concede Resistência. Se a Resistência estiver ativa, o dano de Desmaio subsequente é dobrado, mas o efeito de Desmaio é anulado."
  },
  State_19992_Name = {
    Text = "<ComaColour:Desmaio>"
  },
  State_19995_Desc = {
    Text = "No final do turno, cause dano passivo igual ao número de camadas. Persistente."
  },
  State_19995_Name = {
    Text = "<IntoxicationColour: Envenenado>"
  },
  State_19996_Desc = {
    Text = "Dano aumentado em 25% até o fim do turno, anula fraqueza ao aplicar"
  },
  State_19996_Name = {
    Text = "<StrengthenColour:Fortalecer>"
  },
  State_19998_Desc = {
    Text = "Antes do próximo turno, cada vez que for atacado, cause ao atacante dano passivo igual ao número de capas"
  },
  State_19998_Name = {
    Text = "<RetaliateColour:balcão>"
  },
  State_20012_Desc = {
    Text = "A cada ponto de poder restante, você começa o próximo turno comprando 1 carta; a cada carta restante na mão, você ganha 1 ponto de poder no próximo turno"
  },
  State_20012_Name = {
    Text = "Fragmento do Sábio Mutante"
  },
  State_20012_WeaponDesc = {
    Text = "A cada ponto de poder restante, você começa o próximo turno comprando 1 carta; a cada carta restante na mão, você ganha 1 ponto de poder no próximo turno"
  },
  State_20013_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maestria em Domínios> aumenta 100. Recoloca a primeira carta jogada a cada turno na sua mão. No início do turno extradimensional, limite de cartas +5 e duplica sua mão"
  },
  State_20013_Name = {
    Text = "Estado@pêndulo crono espelho"
  },
  State_20014_Name = {
    Text = "Pêndulo Temporal \"Perdido\""
  },
  State_20016_Name = {
    Text = "Luvas Mágicas da Criação"
  },
  State_20017_Desc = {
    Text = "O próximo efeito de salto será garantido"
  },
  State_20017_Name = {Text = "Salto"},
  State_20021_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maestria em Domínios> aumenta 100. Recoloca a primeira carta jogada a cada turno na sua mão. No início do turno extradimensional, limite de cartas +5 e duplica sua mão"
  },
  State_20021_Name = {
    Text = "Estado@pêndulo crono espelho"
  },
  State_20023_Desc = {
    Text = "No início da batalha, adicione duas cartas de carga de loucura ao baralho"
  },
  State_20023_Name = {
    Text = "Híbrido do Caos"
  },
  State_20023_WeaponDesc = {
    Text = "No início da batalha, adicione duas cartas de carga de loucura ao baralho"
  },
  State_20024_Desc = {
    Text = "A cada vez que liberar aliemus, obtenha uma \"Infeção Tóxica\" que pode causar [Arg1] pontos de veneno. No final do turno, se você tiver 3 \"Infeções Tóxicas\", pode combiná-las em uma \"Eclosão Tóxica\" que dispara veneno"
  },
  State_20024_Name = {
    Text = "Estado@CriaçãoMutaçãoLínguaEstranha"
  },
  State_20026_Desc = {
    Text = "As cartas não entram na pilha de descarte durante a fase de descarte, mas permanecem na mão e ativam efeitos subsequentes."
  },
  State_20026_Name = {
    Text = "<RetainIconKeywords:Manter>"
  },
  State_20026_WeaponDesc = {
    Text = "Após jogar, a carta não irá para a pilha de descarte e não poderá ser usada novamente nesta batalha"
  },
  State_20028_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Domínio de área> aumenta 100. Cada carta jogada concede +10 de Fusão de embriões. Se a vida estiver abaixo de 25%, aumenta para 20. Máximo 10 vezes por turno."
  },
  State_20028_Name = {
    Text = "Estado@pêndulo crono corrosão"
  },
  State_20029_Desc = {
    Text = "A cada vez que liberar aliemus, obtenha uma \"Infeção Tóxica\" que pode causar [Arg1] pontos de veneno. No final do turno, se você tiver 3 \"Infeções Tóxicas\", pode combiná-las em uma \"Eclosão Tóxica\" que dispara veneno"
  },
  State_20029_Name = {
    Text = "Estado@CriaçãoMutaçãoLínguaEstranha"
  },
  State_20035_Name = {
    Text = "Estado@pêndulo crono não dorme"
  },
  State_20038_Name = {
    Text = "Corpo Simbiótico do Caos"
  },
  State_20038_WeaponDesc = {
    Text = "Quando a equipe é composta por Caos e outras classes, no início do turno, todos os Despertos ganham 20 de Loucura"
  },
  State_20039_Desc = {
    Text = "Se a fase de descarte ainda tiver cartas na mão, a carta será consumida e não aparecerá mais nesta batalha"
  },
  State_20039_Name = {
    Text = "<NothingnessIconKeywords: ilusão>"
  },
  State_20039_WeaponDesc = {
    Text = "Após jogar, a carta não irá para a pilha de descarte e não poderá ser usada novamente nesta batalha"
  },
  State_20040_Name = {
    Text = "Estado@pêndulo crono contagem não dorme"
  },
  State_20041_Desc = {
    Text = "Ao iniciar a rodada, ganhe 1 aritmética para cada inimigo presente e compre 1 carta. Ao matar um inimigo com dano ativo, cause sangramento equivalente ao dobro do excesso de dano a outros inimigos"
  },
  State_20041_Name = {
    Text = "Canção dos Alienados"
  },
  State_20042_Desc = {
    Text = "Dano aumentado em 25% contra inimigos com status negativo, ao matar um inimigo, o assassino ganha 20 de loucura"
  },
  State_20044_Desc = {
    Text = "Efeito de Sintoma: Enfraquecer aumentado em 10%. A cada 3 turnos, adiciona 1 capa de Sintoma: Enfraquecer a todos os inimigos."
  },
  State_20045_Desc = {
    Text = "Após o início do próximo turno, escolha 3 cartas do baralho para adicionar à mão"
  },
  State_20045_Name = {
    Text = "Pêndulo Temporal Voando"
  },
  State_20306_Name = {
    Text = "Luvas Mágicas da Criação"
  },
  State_20419_Desc = {
    Text = "A cada dano, aplica [Arg1] camadas de veneno no alvo. Após 25 ativações na batalha, aplica veneno em todos os inimigos"
  },
  State_20425_Desc = {
    Text = "No início do turno, ganhe [Layer] pontos temporários de <PowerIconKeywords:força> e escudo"
  },
  State_20425_Name = {
    Text = "Devorador sedento de sangre"
  },
  State_20600_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: A cada turno, as primeiras [StateArg2] \"habilidades\" consomem [StateArg1] menos Poder de cálculo."
  },
  State_20600_Name = {Text = "Epifania"},
  State_20601_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Dano de \"Golpe\" aumentado em [StateArg1]%. Ao ser atacado, ganhe [StateArg2] camadas de <EnergyStorageKeywords:Carga>."
  },
  State_20601_Name = {Text = "Gula"},
  State_20602_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: \"Golpe\" pode escolher o alvo e causa [StateArg1] camadas de <PVPSlowKeywords:Desaceleração>, o efeito dobra quando é acionado no primeiro alvo de cada turno."
  },
  State_20602_Name = {
    Text = "Mão Esquecida"
  },
  State_20603_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: \"Fúria Explosiva\" dá a si mesmo <Energy:[Energy:StateArg1]> Fúria."
  },
  State_20603_Name = {
    Text = "Restituição do corpo deformado"
  },
  State_20604_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: \"Golpe\" cura <Heal:[Heal:StateArg1]> vida a si mesmo"
  },
  State_20604_Name = {Text = "Sucção"},
  State_20605_Desc = {
    Text = "<PVPWeaponKeywords:wheel of destiny>: Quando equipado, <ComaKeywords:desmaiar> a si mesmo. Antes de \"exaltar\", dissipe todos os estados negativos dos aliados."
  },
  State_20605_Name = {
    Text = "Cajado do Lorde"
  },
  State_20606_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: \"Golpe\" dá <Energy:[Energy:StateArg1]> Loucura a si mesmo"
  },
  State_20606_Name = {Text = "Frenesi"},
  State_20607_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: «Golpe» ataca o inimigo com <HPAndShieldMax:maior vida e escudo>, causando adicionalmente [StateArg1]% do dano como <PVPBleedingKeywords:sangramento>."
  },
  State_20607_Name = {
    Text = "Cortar e Cicatrizar"
  },
  State_20608_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Ganhe <Energy:[Energy:StateArg1]> Fúria ao usar \"Habilidade\" e no final do turno."
  },
  State_20608_Name = {Text = "Sussurro"},
  State_20609_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: A loucura ganha por perder vida é dobrada"
  },
  State_20609_Name = {
    Text = "Sonho do Mar"
  },
  State_20610_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: O Dano de \"golpear\" aumentado em [DescArg1]%, após a \"Fúria Explosiva\" aumenta a própria <PVPPowerIconKeywords:Força> em + [StateArg2] e aumenta adicionalmente o Dano de \"golpear\" em [StateArg3]%, máximo de 100%."
  },
  State_20610_Name = {
    Text = "Besta Celestial"
  },
  State_20611_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: \"Habilidade\", e no final do turno, restaura <Heal:[Heal:StateArg1]> vida para o aliado com mais vida perdida."
  },
  State_20611_Name = {Text = "Esperança"},
  State_20612_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No final do turno, o aliado com menos Loucura ganha <Energy:[Energy:StateArg1]> Loucura e o aliado com mais vida perdida recupera <Heal:[Heal:StateArg2]> vida"
  },
  State_20612_Name = {
    Text = "Nutrição Misericordiosa"
  },
  State_20613_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No final do turno, outros aliados ganham <Block:[Block:StateArg1]> Escudo"
  },
  State_20613_Name = {
    Text = "A Terra da Inexistência"
  },
  State_20614_Desc = {
    Text = "<PVPWeaponKeywords:roda do destino>: no final do turno, ganha [StateArg1] <PVPRetaliateIconKeywords:balcão> temporário"
  },
  State_20614_Name = {
    Text = "Colapso do Núcleo"
  },
  State_20615_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: \"Golpe\" causa adicionalmente [StateArg1] de DANO, <PVPMethysisKeywords:Veneno>."
  },
  State_20615_Name = {
    Text = "Amarradura de maldição amarga"
  },
  State_20616_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Ganhos <Energy:[Energy:StateArg1]> Aliemus ao final do turno."
  },
  State_20616_Name = {
    Text = "Primavera em Acushnet"
  },
  State_20617_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No fim do turno, ganha <Block:[Block:StateArg1]> escudo"
  },
  State_20617_Name = {Text = "Exílio"},
  State_20618_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Antes de \"Exaltar\", faça ambos os lados descartarem todas as cartas na mão e comprarem a mesma quantidade de cartas descartadas +1."
  },
  State_20618_Name = {
    Text = "Espetáculo de Mágica Feliz"
  },
  State_20619_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Ao equipar, ganha <Energy:[Energy:StateArg1]> Fúria. Quando um aliado Corpo Desperto libera \"Fúria Explosiva\", ganha <DelayKeywords:Latência>: <Energy:[Energy:StateArg2]> Fúria."
  },
  State_20619_Name = {
    Text = "Hino do Soberano"
  },
  State_20620_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Limite de cartas na mão + [StateArg2]. No final do turno, ganha [StateArg1] cópias aleatórias de \"habilidades\" em suas cartas."
  },
  State_20620_Name = {
    Text = "Momento de encontro"
  },
  State_20621_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Antes de \"Fúria Explosiva\", <StrengthenKeywords:Reforço> e <ReinforceKeywords:Reforço> a si mesmo."
  },
  State_20621_Name = {
    Text = "Graça Através da Dor"
  },
  State_20622_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No fim do turno, ganha <Energy:[Energy:StateArg1]> Fúria. Consome todo o Poder de cálculo restante, ganha [StateArg3] Fúria adicional para cada 1 Poder de cálculo consumido."
  },
  State_20622_Name = {
    Text = "Nascimento Encoberto"
  },
  State_20623_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após \"Fúria Explosiva\", compre [StateArg1] cartas."
  },
  State_20623_Name = {Text = "Emergir"},
  State_20624_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: \"Fúria Explosiva\" compra [StateArg1] cartas e coloca [StateArg2] cópias delas em sua mão."
  },
  State_20624_Name = {
    Text = "Hora da Fortuna"
  },
  State_20625_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Após \"Fúria Explosiva\", <DelayKeywords:Latência>: Recupera <Heal:[Heal:StateArg1]> Vida de todos os aliados."
  },
  State_20625_Name = {
    Text = "O Conto do Glutão"
  },
  State_20626_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>:\"Golpe\" dano aumentado em [StateArg1]%, e se concede <ReinforceKeywords:Exaltar>."
  },
  State_20626_Name = {
    Text = "Vontade Inflexível"
  },
  State_20627_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No final do turno, recupera <Heal:[Heal:StateArg1]> vida de todos os aliados"
  },
  State_20627_Name = {Text = "Benção"},
  State_20628_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após \"Fúria Explosiva\", concede a outros aliados <Energy:[Energy:StateArg1]> Fúria. Se isso conceder a um aliado mais Fúria do que o necessário para ativar sua Fúria Explosiva, o Portador ganha metade do excedente."
  },
  State_20628_Name = {
    Text = "Dever cumprido"
  },
  State_20629_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: O dano, a cura e os efeitos de escudo de \"Exaltar\" aumentam em [StateArg1]%."
  },
  State_20629_Name = {
    Text = "Em Nome de Rosa"
  },
  State_20630_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No fim do turno, ganha <Block:[Block:StateArg1]> escudo e <Energy:[Energy:StateArg2]> loucura"
  },
  State_20630_Name = {
    Text = "Réquiem do Inverno"
  },
  State_20631_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: \"Golpear\" aplica <PVPVulnerabilityIconKeywords:Vulnerável> ao alvo. Ganha [StateArg1] <EnergyStorageKeywords:Carregar> ao equipar e no final do seu turno."
  },
  State_20631_Name = {
    Text = "Ponto Crítico"
  },
  State_20632_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Limite de cartas na mão +[StateArg1]"
  },
  State_20632_Name = {
    Text = "Espiral de Memória"
  },
  State_20633_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Quando o Portador for atacado ativamente pela primeira vez a cada turno, causa [StateArg1] Dano ao atacante, <PVPEntanglementKeywords:Entrelaçados>."
  },
  State_20633_Name = {
    Text = "Descendente Pálido"
  },
  State_20634_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: \"Golpe\", \"Habilidade\" e \"Exaltação\" aumentam o dano, a cura e o escudo em [DescArg1]%, <PVPGrowthKeywords:crescimento> [StateArg2]%."
  },
  State_20634_Name = {
    Text = "Pôr do Sol"
  },
  State_20635_Desc = {
    Text = "<PVPWeaponKeywords:roda do destino>：“exaltar” faz com que todos os aliados ganhem <StrengthenKeywords:fortalecer>"
  },
  State_20635_Name = {
    Text = "Poder do piedoso"
  },
  State_20636_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No fim do turno, ganha uma <PVPDerivativeCardKeywords_2:\"Ilusão\">. Para cada duas <PVPDerivativeCardKeywords_2:\"Ilusão\"> na mão, funde-as em uma <PVPDerivativeCardKeywords_12:\"Pequeno Desejo\">."
  },
  State_20636_Name = {
    Text = "Envelhecido"
  },
  State_20637_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: No final do turno, embaralhe [StateArg1] cópias de <PVPDerivativeCardKeywords_11:\"Troca Desigual\"> no baralho de compra."
  },
  State_20637_Name = {
    Text = "Dados São Carne"
  },
  State_20639_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No fim do turno, o portador causa [StateArg1] de dano ao inimigo com <HPAndShieldMax:maior vida e escudo>, aplicando <PVPMethysisKeywords:veneno>."
  },
  State_20639_Name = {
    Text = "Presente da Decadência"
  },
  State_20640_Desc = {
    Text = "<PVPWeaponKeywords: Roda do Destino>：Ao equipar e no início do turno, cause <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:sangrando> a todos os inimigos, cada carta na mão do alvo aumenta o dano <PVPBleedingKeywords:sangrando> em +[StateArg2]"
  },
  State_20640_Name = {
    Text = "Festa Sangrenta"
  },
  State_20641_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após a morte, concede [StateArg1] camadas de <PVPProtectiveKeywords:barreira> a outros aliados"
  },
  State_20641_Name = {
    Text = "Análise da Morte"
  },
  State_20642_Desc = {
    Text = "<PVPHoldingKeywords:Na Mão>: Após jogar um cartão, este cartão se torna outro \"Roda da Fortuna\" aleatório, e reduz seu custo aritmético em -1."
  },
  State_20642_Name = {
    Text = "Nascimento de uma alma"
  },
  State_20643_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Após \"Fúria Explosiva\", ganha [StateArg1] Poder de cálculo. <DelayKeywords:Latência>: desconta [StateArg2] Poder de cálculo."
  },
  State_20643_Name = {
    Text = "Síndrome de amnésia"
  },
  State_20644_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Equipado, causa [StateArg2] Dano a si mesmo, <PVPEntanglementKeywords:Entrelaçados>. A cada aliado caído, <StrongEffectKeywords:Eficaz> +[StateArg1]."
  },
  State_20644_Name = {
    Text = "Raridade Preciosa"
  },
  State_20645_Name = {
    Text = "Pacote do Aventureiro"
  },
  State_20646_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Dano de \"golpe\" aumenta em [StateArg1]%, e \"Fúria Explosiva\" recupera <Heal:[Heal:StateArg2]> vida."
  },
  State_20646_Name = {
    Text = "Canção de Ninar Devorada"
  },
  State_20647_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Após \"Fúria Explosiva\", coloca [StateArg1] <PVPDerivativeCardKeywords_11:\"Troca Desigual\"> na sua mão."
  },
  State_20647_Name = {
    Text = "Em Meio a Chuvarada"
  },
  State_20648_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No início do turno, ganha <PVPWonderfulEffectKeywords:Efeito Maravilhoso>, quando o inimigo usa \"Chave\" pela primeira vez a cada turno, coloca [StateArg1] cartas de \"Cenário Deslumbrante\" na mão"
  },
  State_20648_Name = {
    Text = "Banquete Silencioso"
  },
  State_20649_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após \"Exaltar\", devolva a última \"Habilidade\" jogada no turno anterior para sua mão; seu Custo de Aritmética -1. Se este tipo de efeito for ativado múltiplas vezes, retroceda ainda mais."
  },
  State_20649_Name = {
    Text = "Rebobinando o Tempo"
  },
  State_20650_Desc = {
    Text = "<PVPWeaponKeywords:wheel of destiny>: Quando equipado, <ComaKeywords:desmaiar> a si mesmo. Antes de \"exaltar\", dissipe todos os estados positivos dos inimigos."
  },
  State_20650_Name = {Text = "Delírio"},
  State_20651_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No fim do turno, compra [StateArg1] cartas"
  },
  State_20651_Name = {Text = "Ganância"},
  State_20652_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>:\"Exaltar\" causa [StateArg1] dano a todos os inimigos, <DisarmKeywords:Paralisia>."
  },
  State_20652_Name = {Text = "Punição"},
  State_20653_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: \"Golpe\" pode escolher o alvo e remover <Energy:[Energy:StateArg1]> Loucura do alvo"
  },
  State_20653_Name = {
    Text = "À Deriva em Desejos"
  },
  State_20654_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: no início do turno, causa <PVPSeriousInjuryKeywords:Lesão grave> a si mesmo e obtém <Damage:[Damage:StateArg1]> camada(s) de <PVPCorrosionKeywords:Marca do Crime>. No final do turno, aplica <ReinforceKeywords:Reforço> a si mesmo."
  },
  State_20654_Name = {
    Text = "Decreto da Rainha"
  },
  State_20655_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Dano de \"Golpe\" aumentado em [StateArg1]%, \"Golpe\" pode alvo qualquer inimigo."
  },
  State_20655_Name = {Text = "Favor"},
  State_20656_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: O dano, a cura e os efeitos do escudo causados por \"habilidade\" aumentam em [StateArg1]%. Após usar \"habilidade\", se não tiver <PVPProtectiveKeywords:barreira>, ganha 1 camada."
  },
  State_20656_Name = {
    Text = "O Último Verso"
  },
  State_20657_Desc = {
    Text = "<PVPWeaponKeywords: Roda do Destino>：A cada vez que o oponente jogar a [StateArg1]ª \"habilidade\" do turno, coloque uma cópia com custo de cálculo -[StateArg2] em sua mão"
  },
  State_20657_Name = {
    Text = "Discernimento"
  },
  State_20658_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Ataque\" ganha [StateArg1] Aritmética para cada alvo atingido."
  },
  State_20658_Name = {
    Text = "Canção do Limite"
  },
  State_20659_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após a morte, <PVPResurrectionKeywords:ressuscita> no início do próximo turno com <Heal:[Heal:StateArg1]> de vida e <Block:[Block:StateArg2]> de escudo, destruindo esta \"Roda do Destino\""
  },
  State_20659_Name = {Text = "Vitalidade"},
  State_20660_Desc = {
    Text = "<PVPWeaponKeywords:roda do destino>: Após \"exaltar\", todos os aliados ganham escudo <Block:[Block:StateArg1]>."
  },
  State_20660_Name = {
    Text = "Barreira do coração"
  },
  State_20661_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após \"Fúria Explosiva\", causa <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:Sangrar> de dano a todos os inimigos."
  },
  State_20661_Name = {
    Text = "Caminho Abandonado"
  },
  State_20662_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No fim do turno, por cada ponto de <PVPCapKeywords:limite de poder de cálculo>, causa [StateArg1] de <PVPBleedingKeywords:sangramento> ao inimigo com <HPAndShieldMin:menor vida e escudo>, causando um total de <Damage:[Damage:DescArg1]> de dano por <PVPBleedingKeywords:sangramento>."
  },
  State_20662_Name = {
    Text = "Esconder-se na noite"
  },
  State_20663_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Antes de \"Fúria Explosiva\", dissipa estados negativos próprios e ganha [StateArg1] camadas de <EnergyStorageKeywords:Carregar>."
  },
  State_20663_Name = {
    Text = "Correntes do Desvinculado"
  },
  State_20664_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>:\"Habilidade\" se concede <ReinforceKeywords:Exaltar>."
  },
  State_20664_Name = {
    Text = "O juramento de um Cavaleiro"
  },
  State_20665_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Ao dissipar estados negativos, se não houver nenhum, recupera <Heal:[Heal:StateArg1]> vida. No fim do turno, <DelayKeywords:atraso>: dissipa estados negativos"
  },
  State_20665_Name = {
    Text = "Velejo da Providência"
  },
  State_20666_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após «Explosão de Fúria», o aliado com <HPAndShieldMin:menor vida e escudo> obtém [StateArg1] camadas de <PVPProtectiveKeywords:barreira>."
  },
  State_20666_Name = {
    Text = "Ao querido amigo"
  },
  State_20667_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: O dano da primeira \"habilidade\" Disparada pelo Portador em cada turno aumenta em [StateArg1]%."
  },
  State_20667_Name = {
    Text = "Espada do Titã"
  },
  State_20668_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Quando um aliado despertado morre, causa <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:sangrando> de dano a todos os inimigos. Quando o portador morre, causa adicionalmente <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:sangrando> de dano."
  },
  State_20668_Name = {
    Text = "Morte da Sra. Coral"
  },
  State_20669_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Ao equipar e no início do seu turno, se não houver <PVPProtectiveKeywords:Barreira>, ganhe [StateArg1] camadas de <PVPProtectiveKeywords:Barreira>; caso contrário, reduza o Custo de Aritmética de 1 \"Habilidade\" na mão com o maior Custo de Aritmética em 1."
  },
  State_20669_Name = {
    Text = "Tábula das Escrituras"
  },
  State_20670_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: \"Ataque\" causa <PVPSeriousInjuryKeywords:Lesão Grave>, aumentando o dano em [StateArg1]%, mas fazendo com que o conjurador perca metade do dano causado como vida."
  },
  State_20670_Name = {
    Text = "Barbatana da Tristeza"
  },
  State_20671_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Após \"Fúria Explosiva\", recupera <Heal:[Heal:StateArg1]> Vida."
  },
  State_20671_Name = {
    Text = "Ascensão Imortal"
  },
  State_20672_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No final do turno, reduz o custo aritmético da carta na mão com maior custo aritmético em [StateArg1].<PrepareKeywords:Pronto>."
  },
  State_20672_Name = {
    Text = "Concentração mental"
  },
  State_20673_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: \"Fúria Explosiva\" faz com que ganhe <Block:[Block:StateArg1]> Escudo do personagem, e outros aliados ganham <Energy:[Energy:StateArg2]> Fúria."
  },
  State_20673_Name = {
    Text = "Fator Incalculável"
  },
  State_20696_Name = {
    Text = "Estado@medoDoGigante"
  },
  State_20723_Desc = {
    Text = "Dano do cartão de ataque é aumentado por [Layer]. __ \"Para Desenvolvimento Apenas\""
  },
  State_20723_Name = {
    Text = "Aumento fixo de dano para cartão de ataque __ \"Para Desenvolvimento Apenas\""
  },
  State_20724_Desc = {
    Text = "Dano do cartão de ataque é reduzido por [Layer]. __ \"Para Desenvolvimento Apenas\""
  },
  State_20724_Name = {
    Text = "Redução fixa de dano para cartão de ataque __ \"Para Desenvolvimento Apenas\""
  },
  State_20749_Desc = {
    Text = "Contagem Genérica de Rastreamento. __ \"Apenas Para Desenvolvimento\""
  },
  State_20758_Desc = {
    Text = "No início do próximo turno, compre [Layer] cartas"
  },
  State_20758_Name = {
    Text = "Tirada atrasada"
  },
  State_20766_Desc = {
    Text = "Veja a lógica da greve geral para efeitos específicos. __ \"Para uso de desenvolvimento apenas\""
  },
  State_20802_Desc = {
    Text = "Esta carta não pode ser jogada"
  },
  State_20802_Name = {
    Text = "Não pode ser jogado __ \"Somente para Desenvolvimento\""
  },
  State_20803_Desc = {
    Text = "Este cartão -1 custo de aritmética, após usar outros cartões, mudará para outro cartão de roda do destino aleatório"
  },
  State_20803_Name = {
    Text = "<CardKeyWord: Nascimento de uma Alma>"
  },
  State_20805_Desc = {
    Text = "As cartas não entram na pilha de descarte na fase de descarte, mas permanecem na mão"
  },
  State_20805_Name = {
    Text = "<RetainIconKeywords:Manter>"
  },
  State_20806_Desc = {
    Text = "Após jogar, não vá para a pilha de descarte, mas seja removido do baralho"
  },
  State_20806_Name = {
    Text = "<DepleteIconKeywords:Consumo>"
  },
  State_20820_Desc = {
    Text = "No início do próximo turno, reviva e ganhe [Layer] de vida e [Layer] de escudo"
  },
  State_20820_Name = {
    Text = "Ressurreição retardada"
  },
  State_20851_Name = {Text = "Dar cartas"},
  State_20981_Desc = {
    Text = "'O \"Carmim\" já despertou, e seu dano aumentará significativamente.'"
  },
  State_20981_Name = {
    Text = "¡Yū Hashi desperta!"
  },
  State_20981_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_20982_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_20982_Name = {
    Text = "Ainda não despertado"
  },
  State_20988_Desc = {
    Text = "Loucura inicial +80. Ganha 20 pontos de loucura por turno"
  },
  State_20988_Name = {
    Text = "Davendale·Primeiro Encontro"
  },
  State_20989_Desc = {
    Text = "Loucura inicial +80. Ganha 2 pontos de poder de cálculo e 20 de loucura por turno."
  },
  State_20989_Name = {
    Text = "Tulu · Primeiro Encontro"
  },
  State_21306_Desc = {
    Text = "Reseta combo a cada turno"
  },
  State_21306_Name = {
    Text = "Combo reiniciado"
  },
  State_21307_Desc = {
    Text = "Cada camada adiciona 1 ataque, perde 1 camada ao sofrer dano, mínimo de 1 camada, perde todas no fim do turno"
  },
  State_21307_Name = {Text = "Combo"},
  State_21342_Desc = {
    Text = "No início da próxima rodada, ganhe [Layer] de cura"
  },
  State_21342_Name = {
    Text = "Tratamento adiado"
  },
  State_21345_Desc = {
    Text = "Antes do início do Ritual Divino, ao morrer, você revive, remove estados negativos, é imune a danos e recupera 30% da vida. Após o início do Ritual, ao morrer, você revive completamente, remove estados negativos e obsessões do ritual, e convoca dois seguidores"
  },
  State_21345_Name = {
    Text = "Obsessão ritual"
  },
  State_21358_Desc = {
    Text = "Este jogador não tem limite de cartas na mão."
  },
  State_21381_Name = {
    Text = "Contagem de uso do selo"
  },
  State_21385_Desc = {
    Text = "A cada 1 ponto de vida perdido, reduz 1 camada. Quando as camadas chegam a 0, transforma a intenção em uma explosão de loucura que causa alto dano e remove o efeito de petrificação"
  },
  State_21385_Name = {
    Text = "Fúria Sanguinária"
  },
  State_21450_Desc = {
    Text = "No início do próximo turno, dissipa seus próprios estados negativos."
  },
  State_21450_Name = {
    Text = "Purificação retardada"
  },
  State_21488_Desc = {
    Text = "Veja a lógica da greve geral para efeitos específicos. __ \"Para uso de desenvolvimento apenas\""
  },
  State_21492_Desc = {
    Text = "Dano aumenta 50% em acertos críticos"
  },
  State_21492_Name = {
    Text = "<CardKeyWord:Crítico>"
  },
  State_21546_Desc = {
    Text = "No início do próximo turno, ganhe [Layer] de escudo"
  },
  State_21546_Name = {
    Text = "Escudo de latência"
  },
  State_21547_Desc = {
    Text = "No início do turno, mantenha metade do escudo"
  },
  State_21547_Name = {
    Text = "Resiliência"
  },
  State_21548_Desc = {
    Text = "No início da próxima rodada, ganhe fortalecimento"
  },
  State_21548_Name = {
    Text = "Fortalecimento adiado"
  },
  State_21580_Desc = {
    Text = "O Caçador de Crânios está rastreando seus movimentos, cada carta comprada dá ao Caçador [StateArg1] de força temporária"
  },
  State_21580_Name = {Text = "Rastrear"},
  State_21587_Name = {
    Text = "Neste turno, já encontrou um novo desperto aleatório"
  },
  State_21590_Name = {
    Text = "Tentando encontrar novo despertar"
  },
  State_21601_Name = {
    Text = "Novo Corpo Desperto encontrado"
  },
  State_21616_Desc = {
    Text = "Após usar a exaltação da loucura, sela todos os despertadores por um turno"
  },
  State_21616_Name = {
    Text = "Restos do Viajante"
  },
  State_21671_Name = {
    Text = "Causar dano de área __ \"Apenas para Desenvolvimento\""
  },
  State_21688_Name = {
    Text = "Pode ser usado 1 vez"
  },
  State_21689_Name = {
    Text = "Pode ser usado 2 vezes"
  },
  State_21720_Desc = {
    Text = "Afeta o despertado atrás do alvo com o mesmo efeito. Se não houver despertado atrás do alvo, apenas o alvo será afetado."
  },
  State_21720_Name = {
    Text = "<CardKeyWord:Perfuração>"
  },
  State_21726_Desc = {
    Text = "<PVPWeaponKeywords:roda do destino>：Após o portador usar \"habilidade\" pela primeira vez em cada turno, embaralha uma cópia de custo aritmético - [StateArg1] no baralho de compra"
  },
  State_21726_Name = {Text = "Fouetté"},
  State_21744_Name = {
    Text = "Tentando encontrar novo despertar"
  },
  State_21745_Name = {
    Text = "Novo Corpo Desperto encontrado"
  },
  State_21746_Name = {
    Text = "Neste turno, já encontrou um novo desperto aleatório"
  },
  State_21747_Desc = {
    Text = "Há [Layer] despertadores sendo caçados, cada despertador caçado que usa um cartão, \"Caçador de Cabeça Furiosa\" acumula 1 camada de marca de caça"
  },
  State_21747_Name = {
    Text = "Ritual de caça"
  },
  State_21751_Desc = {
    Text = "Puxar metade dos cartões com Marcas de Caça ([DescArg1]), e aumentar o número de Marcas de Caça no \"Caçador de Crânios Desgovernados\" em 1."
  },
  State_21751_Name = {
    Text = "<CardKeyWord:Caçado>"
  },
  State_21754_Desc = {
    Text = "Ao morrer, dissipe todo o STR Temporário de \"Caçador de Crânios Furiosos\" e reduza pela metade as camadas de sua \"Marca de Caça\"."
  },
  State_21754_Name = {
    Text = "Breve alívio"
  },
  State_21765_Desc = {
    Text = "· É possível equipar um Corpo Desperto com uma \"Roda do Destino\", fazendo com que ele ative o efeito da \"Roda do Destino\".\n· Ao reaplicar uma \"Roda do Destino\" em um Corpo Desperto, a antiga \"Roda do Destino\" será destruída e a nova \"Roda do Destino\" será preservada.\n· Após a morte do Corpo Desperto, a \"Roda do Destino\" equipada será destruída.\n· Se uma \"Roda do Destino\" for equipada em um Corpo Desperto que morreu, a \"Roda do Destino\" será destruída, e o jogador ganhará uma Ilusão e reembolsará o consumo de poder de cálculo."
  },
  State_21765_Name = {
    Text = "<PVPWeaponKeywords:Roda do Destino>"
  },
  State_21785_Name = {
    Text = "Grito de batalha"
  },
  State_21787_Name = {
    Text = "Adicionar Grito de Batalha"
  },
  State_21826_Name = {
    Text = "Discurso de abertura do líder das crianças"
  },
  State_21829_Name = {
    Text = "Efeito de morte"
  },
  State_21838_Name = {
    Text = "Introdução inicial"
  },
  State_21843_Name = {
    Text = "Adicionar estado no início"
  },
  State_21895_Name = {
    Text = "Chamada de abertura"
  },
  State_21905_Desc = {
    Text = "\"Ataque\" ganha 2 Aritmética e descarta 1 carta aleatória; \"Defesa\" compra 2 cartas e perde 1 Aritmética."
  },
  State_21928_Name = {Text = "Dica"},
  State_22054_Name = {
    Text = "Chamada de abertura"
  },
  State_22055_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_22055_Name = {
    Text = "Ainda não despertado"
  },
  State_22067_Desc = {
    Text = "Após o fim do turno, 1 tentáculo ataca [Layer] vezes"
  },
  State_22067_Name = {
    Text = "Reunião de tentáculos"
  },
  State_22074_Desc = {
    Text = "Sobreviva até o sétimo turno e mude a intenção para \"encarar\", no oitavo turno ou mais, mude para \"profanar\""
  },
  State_22134_Desc = {
    Text = "Causa Dano ao Escudo, Vida e Barreira do alvo simultaneamente."
  },
  State_22134_Name = {
    Text = "<CardKeyWord:Dano Perfurante>"
  },
  State_22157_Desc = {
    Text = "Quando a vida estiver abaixo de 50%([StateArg1]), dividir-se-á em \"Corrente\" e \"Maré\" com vida igual"
  },
  State_22157_Name = {Text = "Fissão"},
  State_22204_Desc = {
    Text = "Após o início da rodada, ganhe [Layer]% de taxa crítica temporária e dano crítico temporário"
  },
  State_22204_Name = {
    Text = "Som suave aumenta gradualmente"
  },
  State_22204_WeaponDesc = {
    Text = "Até o próximo turno não perder saúde, o critico do próximo turno aumenta em +[StateArg1]%"
  },
  State_22210_Desc = {
    Text = "Consumo de capacidade + 100, e não pode usar ataques, não pode ganhar aliemus"
  },
  State_22210_Name = {Text = "Superlento"},
  State_22238_Name = {
    Text = "Jogadores em duelo mortal"
  },
  State_22239_Name = {
    Text = "Aplique deathmatch de jogador __ \"Para Desenvolvimento Apenas\""
  },
  State_22249_Desc = {
    Text = "Após o início do próximo turno, compre [Layer] cartas a menos"
  },
  State_22249_Name = {
    Text = "Troca Desigual"
  },
  State_22300_Desc = {
    Text = "Este \"golpear\" não pode ser jogado."
  },
  State_22300_Name = {
    Text = "O cartão de ataque está desativado e não pode ser jogado __ \"Para Desenvolvimento Apenas\""
  },
  State_22303_Desc = {
    Text = "Sempre que sofrer dano, aplique uma camada de \"atraso\" temporário a uma carta aleatória na mão; após quebrar um escudo, remova o estado \"escudo de gelo\""
  },
  State_22303_Name = {
    Text = "Escudo de gelo"
  },
  State_22324_Desc = {
    Text = "Para cada camada, aumenta um ataque neste turno"
  },
  State_22324_Name = {
    Text = "Eco da Maré Furiosa"
  },
  State_22325_Desc = {
    Text = "Ao ser atacado, ganha [StateArg1] pontos de força temporária"
  },
  State_22325_Name = {
    Text = "Sangue de gigante"
  },
  State_22326_Desc = {
    Text = "Você está marcado! Após atacar, os guardas do marinheiro ganham 1 camada de loucura temporária, removendo a marca rugidora dessa carta de comando"
  },
  State_22326_Name = {
    Text = "<CardKeyWord: Marca Rugidora>"
  },
  State_22328_Desc = {
    Text = "Cada vez que uma carta de comando com a \"Marca Rugidora\" é utilizada, o número de ataques nesta rodada aumenta em 1"
  },
  State_22328_Name = {
    Text = "Eco da Maré Furiosa"
  },
  State_22334_Desc = {
    Text = "Sempre que jogar 1 carta de \"Impacto\", coloque [StateArg1] cartas de \"Ferida\" no topo da pilha de compra"
  },
  State_22334_Name = {Text = "Trauma"},
  State_22404_Desc = {
    Text = "Escudo gerado aumentado em [Layer] nesta batalha"
  },
  State_22404_Name = {Text = "Alerta"},
  State_22405_Desc = {
    Text = "Escudo gerado aumentado nesta batalha"
  },
  State_22405_Name = {
    Text = "<PVPAlertKeywords:Alerta>"
  },
  State_22702_Desc = {
    Text = "A primeira \"carta\" jogada em uma rodada aciona um efeito adicional"
  },
  State_22702_Name = {
    Text = "<CardKeyWord:Assalto>"
  },
  State_22706_Name = {
    Text = "Marca de ataque"
  },
  State_22707_Desc = {
    Text = "Após Disparar cartas em cada turno, marque o jogador com o Estado de Reserva de emboscada"
  },
  State_22707_Name = {
    Text = "Gatilho de Reserva de emboscada"
  },
  State_22721_Name = {
    Text = "Pêndulo Temporal \"Perdido\""
  },
  State_23405_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, ganhar um poder equivalente ao número atual de camadas de contra-ataque, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_23405_Name = {
    Text = "Ainda não despertado"
  },
  State_23406_Desc = {
    Text = "\"O 'Habitante do Abismo' ganha [StateArg1] camadas de Contra ao final de cada turno.\""
  },
  State_23406_Name = {
    Text = "¡Despertar de Caecus!"
  },
  State_23512_Name = {
    Text = "Conceda a Ilusão de Mil Faces"
  },
  State_23514_Name = {
    Text = "Conceda a Ilusão de Mil Faces"
  },
  State_23515_Name = {
    Text = "Conceda a Ilusão de Mil Faces"
  },
  State_23516_Name = {
    Text = "Conceda a Ilusão de Mil Faces"
  },
  State_23517_Name = {
    Text = "Conceder BUFF ao jogador"
  },
  State_23518_Desc = {
    Text = "Impor 2 rodadas de vulnerável / aumentar 1 ataque / impor redução de poder"
  },
  State_23518_Name = {
    Text = "<CardKeyWord:Escolha de Intenção>"
  },
  State_23519_Name = {
    Text = "Intenção 2b"
  },
  State_23520_Name = {
    Text = "Intenção 2c"
  },
  State_23521_Name = {
    Text = "Ao descartar, consuma, reduza toda a Fúria dos Corpos Despertos em [StateArg1] e embaralhe 5 cartas de \"Sintoma\" no Mazo de robo"
  },
  State_23522_Name = {
    Text = "Consuma ao descartar, reduza toda a Fúria dos Corpos Despertos em [StateArg1]"
  },
  State_23524_Name = {
    Text = "Intenção 3a"
  },
  State_23525_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_23525_Name = {
    Text = "Ainda não despertado"
  },
  State_23526_Name = {
    Text = "Intenção 2a"
  },
  State_23527_Name = {
    Text = "Intenção 3c"
  },
  State_23528_Name = {
    Text = "Intenção 3b"
  },
  State_23529_Desc = {
    Text = "Aumenta força / Causa dano extra / Ganha escudo"
  },
  State_23529_Name = {
    Text = "<CardKeyWord:Escolha de Intenção>"
  },
  State_23530_Desc = {
    Text = "Usar \"mil miragens\" requer escolher duas intenções. Se descartado, todos os despertadores perdem 20 de loucura e 5 cartas de \"sintoma\" são adicionadas ao baralho do jogador"
  },
  State_23530_Name = {
    Text = "¡Despertar de Davendale!"
  },
  State_23531_Name = {
    Text = "Conceda a Ilusão de Mil Faces"
  },
  State_23532_Name = {
    Text = "Conceda a Ilusão de Mil Faces"
  },
  State_23533_Desc = {
    Text = "Lavar a carta de sintoma / Causar sangramento / Reduzir a loucura"
  },
  State_23533_Name = {
    Text = "<CardKeyWord:Escolha de Intenção>"
  },
  State_23534_Name = {
    Text = "Intenção 1a"
  },
  State_23535_Name = {
    Text = "Intenção 1c"
  },
  State_23536_Name = {
    Text = "Intenção 1b"
  },
  State_23612_Desc = {
    Text = "A cada 1 ponto de vida perdido, reduz 1 camada. Quando as camadas chegam a 0, transforma a intenção em uma explosão de loucura que causa alto dano e remove o efeito de petrificação"
  },
  State_23612_Name = {
    Text = "Fúria Sanguinária·Final"
  },
  State_23687_Name = {
    Text = "Pêndulo Temporal \"Marés\""
  },
  State_23726_Desc = {
    Text = "Antes do próximo turno, evitará a morte do Despertado 1 vez, no máximo 1 camada"
  },
  State_23726_Name = {
    Text = "Resistência à Morte"
  },
  State_23732_Desc = {
    Text = "Até o início do próximo turno, ganha [Layer] <plural value=\"[Layer]\" singular=\"capa\" plural=\"capas\"> de <PainWord:Paciência> para cada instância de Dano ativo recebido."
  },
  State_23732_Name = {
    Text = "Zona Proibida dos Pântanos Negros"
  },
  State_23736_Name = {
    Text = "Número de cartas compradas neste turno"
  },
  State_23737_Name = {
    Text = "Registro de Contagem de Comprar Cartas"
  },
  State_23741_Name = {
    Text = "Aplicar registro de compra de cartas"
  },
  State_23744_Desc = {
    Text = "Se não houver \"Mortos\" no campo, invoque 1 \"Morto\" no início do turno, aumentando a vida a cada invocação"
  },
  State_23744_Name = {
    Text = "Invocação de mortos"
  },
  State_23747_Name = {
    Text = "Reforçar a vida"
  },
  State_23748_Name = {
    Text = "Contagem de Invocação"
  },
  State_23769_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_23769_Name = {
    Text = "Ainda não despertado"
  },
  State_23771_Desc = {
    Text = "\"A Mágica\" despertou. Cuidado com os engodos criados pelo seu \"Fantasma\". Para cada carta jogada pelo oponente após o despertar, Casiah ganha 1 camada de \"Fantasma\"."
  },
  State_23771_Name = {
    Text = "Kasía desperta!"
  },
  State_23771_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_23782_Desc = {
    Text = "Após ganhar 10 níveis de fantasma, esvazia os níveis de \"fantasma\" e invoca 1 clone à frente, podendo haver no máximo 2 clones. O clone invocado terá 3 níveis de <ParcloseIconKeywords:barreira>"
  },
  State_23782_Name = {Text = "Fantasma"},
  State_23786_Name = {
    Text = "Estado@despertador casiah telecinese"
  },
  State_23787_Name = {
    Text = "Estado@despertador casiah@telecinese@reduzir puxar"
  },
  State_23788_Desc = {
    Text = "No início da rodada 3, adicione 1 carta \"Ecos do Passado—Descarte todas as cartas, redefina a Vida e o Escudo atuais para o estado no final da rodada anterior. Retenha, Exausto.\" à sua mão."
  },
  State_23791_Name = {
    Text = "Mensagem de abertura"
  },
  State_23823_Name = {Text = "Bomba 1"},
  State_23825_Name = {
    Text = "Estado@despertador casiah@poof"
  },
  State_23827_Desc = {
    Text = "Após jogar, perca [DescArg1] pontos do máximo de saúde, o Grande Mágico ganha 1 camada de \"orgulho\" neste turno"
  },
  State_23827_Name = {
    Text = "<CardCheerKeywords:Aplauso>"
  },
  State_23828_Desc = {
    Text = "O grande mago agora está desfrutando muito de sua apresentação, a cada camada de “orgulho”, o efeito de sua habilidade será reduzido e a força diminuída [DescArg1], podendo acumular até 5 camadas"
  },
  State_23828_Name = {
    Text = "satisfeito consigo mesmo"
  },
  State_23871_Desc = {
    Text = "Aumentar a vida máxima não aumenta simultaneamente a vida atual; diminuir a vida máxima removerá a vida atual em excesso, com a vida máxima mínima sendo 1, não se reinicia após a morte."
  },
  State_23871_Name = {
    Text = "<MaxHPColour: saúde máxima>"
  },
  State_23934_Name = {
    Text = "Estado@TelecineseMonitoramentoDeCartas"
  },
  State_23935_Name = {
    Text = "Estado@despertador casiah@telecinese efetiva"
  },
  State_2393_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_2393_Name = {
    Text = "Ainda não despertado"
  },
  State_2394_Name = {
    Text = "Poder escarlate de iluminação"
  },
  State_2395_Name = {
    Text = "Festa Distante dos Acessórios"
  },
  State_2395_WeaponDesc = {
    Text = "\"Defesa\" aumenta o escudo em 30%. Se o personagem equipado tiver mais de 15% de queda de sigilo negro, \"Defesa\" concede um escudo adicional de 30%."
  },
  State_2396_Desc = {
    Text = "Dano Crítico +20%. Dano contra inimigos com escudo será sempre crítico"
  },
  State_2398_Desc = {
    Text = "Ao receber dano, ganha [Layer] escudo, que aumenta a cada dano recebido, restaurado no final do turno"
  },
  State_2398_Name = {
    Text = "Barreira dimensional"
  },
  State_2398_WeaponDesc = {
    Text = "Dano ativo recebido aumenta [Layer]. Cada dano recebido amplia a ferida corrosiva, restaurada no início do turno"
  },
  State_2399_Desc = {
    Text = "Após causar recuperação de vida, todos os despertadores ganham 3 de mania. Após cada 5ª recuperação de vida nesta batalha, o dano de exaltação aumenta em [Arg1]"
  },
  State_2400_Desc = {
    Text = "Limite de tentáculo aumentado em 1. Quando a vida está abaixo de 50%, o dano do tentáculo aumenta em [StateArg1] pontos"
  },
  State_2400_Name = {
    Text = "Tributo do Passado da Criação"
  },
  State_2400_WeaponDesc = {
    Text = "Limite de tentáculo aumentado em 1. Quando a vida está abaixo de 50%, o dano do tentáculo aumenta em [StateArg1] pontos"
  },
  State_2401_Desc = {
    Text = "No início do turno, adiciona o cartão no topo da pilha de descarte à mão"
  },
  State_2402_Desc = {
    Text = "No início do turno, para cada 1 cartão no espaço ultra, ganha [Arg1] pontos de força temporária neste turno"
  },
  State_2403_Desc = {
    Text = "Escudo aumentado em [Layer] nesta batalha"
  },
  State_2403_Name = {Text = "Alerta"},
  State_2403_WeaponDesc = {
    Text = "Escudo aumentado em [Layer] nesta batalha"
  },
  State_2404_Desc = {
    Text = "Ao pegar, remova 1 cartão sintoma. A taxa de marcas de sorte aumenta em 50%"
  },
  State_2405_Desc = {
    Text = "Alterar temporariamente o poder de cálculo da carta"
  },
  State_2405_Name = {
    Text = "Alterar temporariamente o poder de cálculo da carta"
  },
  State_2405_WeaponDesc = {
    Text = "Alterar temporariamente o poder de cálculo da carta"
  },
  State_2406_Desc = {
    Text = "Ao esgotar o último ponto de poder, ganha 2 de poder. Pode ser acionado até 2 vezes por rodada"
  },
  State_2407_Name = {
    Text = "Valor observado"
  },
  State_2408_Name = {
    Text = "Apito de Marinheiro"
  },
  State_2409_Desc = {
    Text = "Nesta rodada, cada carta de [Ataque] jogada reduz o consumo de Aritmética em 1."
  },
  State_2409_Name = {
    Text = "Lâmina Rebelde"
  },
  State_2409_WeaponDesc = {
    Text = "Nesta rodada, cada carta de [Ataque] jogada reduz o consumo de Aritmética em 1."
  },
  State_2410_Desc = {
    Text = "Impossível agir por 1 turno. Inimigos petrificados não podem ser afetados novamente pelo efeito de petrificação"
  },
  State_2410_Name = {
    Text = "<PetrifactionIconKeywords:Petrificação>"
  },
  State_2410_WeaponDesc = {
    Text = "Atordoa o monstro por um turno"
  },
  State_2411_Desc = {
    Text = "Ao final da rodada, aplique [Layer] camadas de sangramento à nossa equipe"
  },
  State_2411_Name = {
    Text = "Lâmpada de Sangue"
  },
  State_2411_WeaponDesc = {
    Text = "Ao final da rodada, aplique [Layer] camadas de sangramento à nossa equipe"
  },
  State_2412_Desc = {
    Text = "O dano causado no próximo turno será dobrado"
  },
  State_2412_Name = {
    Text = "Sobrevivência em situação desesperadora"
  },
  State_2412_WeaponDesc = {
    Text = "O dano causado no próximo turno será dobrado"
  },
  State_2413_Desc = {
    Text = "A loucura obtida por ataque e defesa reduzida em [Layer] %"
  },
  State_2413_Name = {Text = "Vazio"},
  State_2413_WeaponDesc = {
    Text = "A loucura obtida por ataque e defesa [StateArg1] %"
  },
  State_2415_Desc = {
    Text = "Se sofreu dano no turno anterior, ganha imunidade por 1 turno no início do turno"
  },
  State_2415_Name = {
    Text = "Adaptação"
  },
  State_2415_WeaponDesc = {
    Text = "Se sofreu dano no turno anterior, ganha imunidade por 1 turno no início do turno"
  },
  State_2416_Desc = {
    Text = "Os monstros invocados têm vida e dano dobrados"
  },
  State_2416_Name = {
    Text = "\"Mundo da Escultura de Cera\""
  },
  State_2416_WeaponDesc = {
    Text = "Os monstros invocados têm vida e dano dobrados"
  },
  State_24174_Desc = {
    Text = "Este Despertado não terá sua vida reduzida a menos de 1 por dano"
  },
  State_24174_Name = {
    Text = "Imunidade à morte"
  },
  State_2418_Desc = {
    Text = "[exaltar] concede 30 de loucura a si mesmo"
  },
  State_2418_Name = {
    Text = "Véu do Deus da Mutação"
  },
  State_2418_WeaponDesc = {
    Text = "[exaltar] concede 30 de loucura a si mesmo"
  },
  State_2419_Name = {
    Text = "Espelho Branco da Criação"
  },
  State_2420_Desc = {
    Text = "Nesta rodada, cada carta de [Defesa] jogada reduz o consumo de Aritmética em 1."
  },
  State_2420_Name = {
    Text = "Lâmina do Olho do Coração"
  },
  State_2420_WeaponDesc = {
    Text = "Nesta rodada, cada carta de [Defesa] jogada reduz o consumo de Aritmética em 1."
  },
  State_24210_Desc = {
    Text = "Neste turno, o ataque de tentáculo do Deus-Rei atinge todos os inimigos"
  },
  State_24210_Name = {
    Text = "Membro de Poço Divino - Ordem de chave"
  },
  State_24211_Desc = {
    Text = "·Ao final do turno, cause [DescArg4] vezes [DescArg2] de dano aos inimigos da linha de frente. Se matar, aumente o dano em [DescArg3], até 5 vezes (atualmente [DescArg6]).\n·Sempre que o Corpo Desperto usar Fúria Explosiva, realiza um ataque adicional nesta rodada.\n·Após o Guardião usar a Ordem de chave, os ataques desta rodada atingem todos os inimigos. Se for em uma Batalha do Líder, o dano causado pelo \"Membro de Poço Divino\" também aumentará em [DescArg5]."
  },
  State_24211_Name = {
    Text = "Membro de Poço Divino"
  },
  State_24213_Name = {
    Text = "Se esta carta estiver na mão, ao final da rodada, você ganha 150 pontos de s-energia"
  },
  State_24214_Desc = {
    Text = "·Ao final do turno, cause [DescArg2] de dano aos inimigos da linha de frente"
  },
  State_24214_Name = {
    Text = "Membro de Poço Divino"
  },
  State_24215_Desc = {
    Text = "·Ao final do turno, cause [DescArg2] de dano aos inimigos da linha de frente. Se matar, aumente o dano em [DescArg3], até 5 vezes (atualmente [DescArg4])"
  },
  State_24215_Name = {
    Text = "Membro de Poço Divino"
  },
  State_24217_Name = {
    Text = "Remove os estados<VulnerabilityIconKeywords:vulnerável>,<WeaknessIconKeywords:fraqueza> e <FragileIconKeywords:frágil>"
  },
  State_24220_Name = {
    Text = "Obtenha [DescArg1] pontos de escudo"
  },
  State_24222_Desc = {
    Text = "·Ao final do turno, cause [DescArg4] vezes [DescArg2] de dano aos inimigos da linha de frente. Se matar, aumente o dano em [DescArg3], até 5 vezes (atualmente [DescArg5] vezes).\n·Sempre que o Corpo Desperto usar Fúria Explosiva, realize 1 ataque adicional neste turno.\n·Sempre que o Guardião usar uma Ordem de chave, os ataques deste turno atingem todos os inimigos."
  },
  State_24222_Name = {
    Text = "Membro de Poço Divino"
  },
  State_24223_Desc = {
    Text = "·Ao final do turno, cause [DescArg2] de dano aos inimigos da linha de frente. Se matar, aumente o dano em [DescArg3], até 5 vezes (atualmente [DescArg4]).\n·Sempre que o Guardião usar uma Chave, os ataques deste turno atingem todos os inimigos"
  },
  State_24223_Name = {
    Text = "Membro de Poço Divino"
  },
  State_24224_Desc = {
    Text = "·Ao final do turno, cause [DescArg4] vezes [DescArg2] de dano aos inimigos da linha de frente. Se matar, aumente o dano em [DescArg3], até 5 vezes (atualmente [DescArg5] vezes).\n·Sempre que o Corpo Desperto usar Fúria Explosiva, realize 1 ataque adicional neste turno."
  },
  State_24224_Name = {
    Text = "Membro de Poço Divino"
  },
  State_24226_Desc = {
    Text = "·Ao final do turno, cause [DescArg4] vezes [DescArg2] de dano aos inimigos da linha de frente. Se matar, aumente o dano em [DescArg3], até 5 vezes (atualmente [DescArg6]).\n·Sempre que o Corpo Desperto usar Fúria Explosiva, realize 1 ataque adicional neste turno.\n·Na Batalha do Líder, toda vez que o Guardião usar a Ordem de chave, o dano do \"Membro de Poço Divino\" aumentará em [DescArg5]."
  },
  State_24226_Name = {
    Text = "Membro de Poço Divino"
  },
  State_24227_Desc = {
    Text = "·Ao final do turno, cause [DescArg2] de dano aos inimigos da linha de frente. Se matar, aumente o dano em [DescArg3], até 5 vezes (atualmente [DescArg5]).\n·Após o Guardião usar uma Ordem de chave, os ataques deste turno atingem todos os inimigos. Se for em uma Batalha do Líder, o dano do \"Membro de Poço Divino\" também aumentará em [DescArg4]."
  },
  State_24227_Name = {
    Text = "Membro de Poço Divino"
  },
  State_2422_Desc = {
    Text = "Após jogar, ganhe [StateArg1] pontos de escudo"
  },
  State_2422_Name = {
    Text = "<Rune_6:Fortaleza>"
  },
  State_24245_Desc = {
    Text = "No final do turno, reviva todos os seguidores de \"Hydra\". Reduza 1 camada cada vez que um seguidor morrer. Se as camadas chegarem a 0, \"Hydra\" mudará de forma para a batalha final"
  },
  State_24245_Name = {
    Text = "Maestro de milhares de cobras"
  },
  State_24247_Desc = {
    Text = "Dano recebido reduzido em 90%. Se no início do turno não houver camadas de \"Manipulação das Mil Serpentes\", remove este estado"
  },
  State_24247_Name = {
    Text = "Barreira em Forma de Serpente"
  },
  State_2425_Desc = {
    Text = "Após jogar, é consumido. Se for uma carta de comando, seu dano e defesa são dobrados"
  },
  State_2425_Name = {
    Text = "<CardKeyWord:Dissolver>"
  },
  State_2426_Desc = {
    Text = "A primeira carta que você jogar a cada turno terá uma eficácia adicional, mas você pode jogar no máximo 4 cartas por turno"
  },
  State_2427_Name = {
    Text = "Estado@chaveDePrataSonho:contagemCoracaoSanguinario"
  },
  State_2428_Desc = {
    Text = "O número de <ParcloseIconKeywords:barreiras> da Flor do Mal aumenta em [Layer] camadas"
  },
  State_2428_Name = {
    Text = "Barreira de ressentimento"
  },
  State_2428_WeaponDesc = {
    Text = "O número de barreiras da Flor do Mal aumenta em [Layer] camadas"
  },
  State_24292_Name = {
    Text = "Movimento da fileira traseira para a frente"
  },
  State_24293_Name = {
    Text = "Fila da frente para trás"
  },
  State_2429_Desc = {
    Text = "Dano causado reduzido em [Layer] %"
  },
  State_2429_Name = {
    Text = "Redução Temporária de Dano"
  },
  State_2429_WeaponDesc = {
    Text = "Dano causado reduzido em [Layer] %"
  },
  State_2430_Desc = {
    Text = "No início da batalha, todos os aliados ganham 3 camadas de [Armadura de Cera]. No final do turno, isso inflige [Arg1] camadas de Sangrando em nossa equipe."
  },
  State_2430_Name = {
    Text = "\"Senhor Cera\""
  },
  State_2430_WeaponDesc = {
    Text = "No início da batalha, todos os aliados ganham 3 camadas de [Armadura de Cera]. No final do turno, isso inflige [Arg1] camadas de Sangrando em nossa equipe."
  },
  State_2431_Desc = {
    Text = "Equipe Única: O escudo e a recuperação de vida causados pelo portador aumentam em <WeaponEffect_Num:[StateArg1]%> da Constituição do portador, o contrataque causado pelo portador aumenta em <WeaponEffect_Num:[StateArg3]%>, e ao disparar a \"Defesa\", também ganhará <RetaliateIconKeywords:Contrataque> equivalente a <WeaponEffect_Num:[StateArg4]%> da Defesa do portador. No início da batalha, ganha <PowerIconKeywords:força> equivalente a <WeaponEffect_Num:[StateArg2]%> da Constituição do portador. Se o domínio atual for \"Mar Profundo\", ganha também dano de tentáculo adicional equivalente."
  },
  State_2431_WeaponDesc = {
    Text = "O escudo causado pelo portador e o aumento de cura de vida aumentam em <WeaponEffect_Num:[DescArg1]> pontos, o contra-ataque causado pelo portador aumenta em <WeaponEffect_Num:[StateArg3]%>, ao disparar \"Defesa\", também ganha <WeaponEffect_Num:[Counterattack:DescArg3]> camadas de <RetaliateIconKeywords:contrataque>. Após o início da batalha, ganha <WeaponEffect_Num:[Power:DescArg2]> pontos de <PowerIconKeywords:força>. Se o domínio atual for \"Mar Profundo\", ganha também uma quantidade equivalente de dano de tentáculo."
  },
  State_2432_Desc = {
    Text = "Dano ativo e Dano de tentáculo recebidos +50%, remove 1 capa no fim do turno."
  },
  State_2432_Name = {
    Text = "<VulnerabilityIconKeywords: Vulnerável>"
  },
  State_2432_WeaponDesc = {
    Text = "Todo dano recebido aumentado em 50%"
  },
  State_2433_Desc = {
    Text = "No final de cada turno, ganhe [Layer] de força"
  },
  State_2433_Name = {Text = "raiva"},
  State_2434_Name = {
    Text = "Anel da Sala 36 de Acessórios"
  },
  State_2434_WeaponDesc = {
    Text = "Quando uma carta do Equipador é puxada, a aritmética varia aleatoriamente entre 0 e 3"
  },
  State_2435_Desc = {
    Text = "Evento 19_2"
  },
  State_2435_Name = {
    Text = "Evento 19_2"
  },
  State_2435_WeaponDesc = {
    Text = "Evento 19_2"
  },
  State_2436_Desc = {
    Text = "Força e escudo obtidos são reduzidos em 50%, dura [Layer] turnos"
  },
  State_2436_Name = {
    Text = "Maldição temporária"
  },
  State_2436_WeaponDesc = {
    Text = "Antes do fim do turno, imune a estados positivos"
  },
  State_2438_Desc = {
    Text = "Estado@CriaçãoContagemMáquinaDiferencialPrateada"
  },
  State_2438_Name = {
    Text = "Estado@CriaçãoContagemMáquinaDiferencialPrateada"
  },
  State_2438_WeaponDesc = {
    Text = "Estado@CriaçãoContagemMáquinaDiferencialPrateada"
  },
  State_2440_Name = {
    Text = "Compre 1 carta"
  },
  State_2441_Name = {
    Text = "Ganha 1 ponto de aritmética"
  },
  State_2442_Name = {
    Text = "Aplique 1 camada de <VulnerabilityIconKeywords:vulnerável> a todos os inimigos"
  },
  State_2443_Name = {
    Text = "Aplica 1 camada de <WeaknessIconKeywords:fraqueza> a todos os inimigos"
  },
  State_2444_Name = {
    Text = "Obter <Energy:[DescArg1]> de loucura"
  },
  State_2445_Name = {
    Text = "Outros despertos ganham <Energy:[DescArg1]> pontos de loucura"
  },
  State_2446_Name = {
    Text = "Adicione 1 <DerivativeCardKeywords_4:\"Inspiração\"> ao seu monte de compras."
  },
  State_2447_Desc = {
    Text = "Equipe Única: A taxa de crítico e o dano crítico da carta de comando do portador, o escudo causado pela carta de comando, a recuperação de vida, a fúria e a força aumentam em <WeaponEffect_Num:[StateArg1]%>. Se o domínio atual for \"Ultra\", após liberar \"Aniquilação\", ganha <WeaponEffect_Num:[StateArg2]> pontos de Energia da Chave de Prata. Após entrar no Turno Ultra, a próxima ordem de chave neste turno será liberada 2 vezes."
  },
  State_2447_WeaponDesc = {
    Text = "A taxa de crítico e o dano crítico das cartas de comando do portador, o escudo causado pelas cartas de comando, a recuperação de vida, a fúria e a força aumentam em <WeaponEffect_Num:[StateArg1] %>. Se o domínio atual for \"Ultra\", ao liberar \"Aniquilação\" ganhe <WeaponEffect_Num:[StateArg2]> pontos de energia da chave de prata. Após entrar no Turno Ultra, a próxima ordem de chave liberada neste turno será feita 2 vezes."
  },
  State_2448_Desc = {
    Text = "As cartas não entram na pilha de descarte na fase de descarte, mas permanecem na mão"
  },
  State_2448_Name = {
    Text = "<CardKeyWord:Manter>"
  },
  State_2449_Desc = {
    Text = "Ao receber dano real, ganha [Layer] escudo"
  },
  State_2449_Name = {Text = "buffer"},
  State_2449_WeaponDesc = {
    Text = "Ao receber dano real, ganha [Layer] escudo"
  },
  State_2450_Desc = {
    Text = "\"Ataque\" garante um acerto crítico. Dano crítico aumentado em 50%."
  },
  State_2451_Desc = {
    Text = "No final do turno, outros aliados ganham [Layer] de Força"
  },
  State_2451_Name = {
    Text = "\"Fogo da Iluminação\""
  },
  State_2452_Desc = {
    Text = "Após jogar, ganhe [StateArg1] pontos de força"
  },
  State_2452_Name = {
    Text = "<Rune_14_High:Força Bruta Avançada>"
  },
  State_2453_Name = {
    Text = "Ritual Fotossintético dos Acessórios"
  },
  State_2453_WeaponDesc = {
    Text = "Após o início da batalha, todas as cartas do portador ganham manter"
  },
  State_2454_Desc = {
    Text = "Após jogar, não vá para a pilha de descarte, mas seja removido do baralho"
  },
  State_2454_Name = {
    Text = "<DepleteIconKeywords:Consumo>"
  },
  State_2454_WeaponDesc = {
    Text = "Após jogar, a carta não irá para a pilha de descarte e não poderá ser usada novamente nesta batalha"
  },
  State_24556_Name = {
    Text = "Estado@magoHoudini@adicionarAplauso"
  },
  State_2455_Name = {
    Text = "Estado@dançarino da chama azul iluminação 7"
  },
  State_24560_Desc = {
    Text = "Sempre que usar a chave, o movimento \"ramona\" temporariamente aumenta a taxa crítica e o dano crítico em 25%"
  },
  State_24560_Name = {
    Text = "Viajante de Klein"
  },
  State_24562_Desc = {
    Text = "Após o final do turno, ganha 1 camada de negentropia"
  },
  State_24562_Name = {
    Text = "Viajante de Penrose"
  },
  State_24564_Desc = {
    Text = "Sempre que se tem 3 camadas de negentropia, jogar a carta de comando \"Ciclo·Ramona\" consumirá toda a negentropia e ativará um efeito extra de ciclo, com uma capacidade de acumular no máximo 3 camadas de negentropia"
  },
  State_24564_Name = {
    Text = "Negentropia"
  },
  State_2456_Name = {
    Text = "Estado@dançarino da chama azul iluminação 15"
  },
  State_2457_Name = {
    Text = "Compre 1 carta"
  },
  State_24584_Name = {
    Text = "Estado@Clone de N@Murmúrio1 troca de estado"
  },
  State_2458_Name = {
    Text = "Estado@efeito da joia abraço escarlate contagem"
  },
  State_24593_Desc = {
    Text = "Quando o nível for 0, a intenção mudará para \"Convocação Negra\", diminuindo 1 nível no final do turno, com um máximo de 4 níveis"
  },
  State_24593_Name = {Text = "Caos"},
  State_24595_Desc = {
    Text = "Após a morte, reduza imediatamente 1 camada de \"Caos\" de \"N\"."
  },
  State_24595_Name = {Text = "Dispersão"},
  State_24596_Desc = {
    Text = "Ao invocar o clone de \"N\", invocar 1 clone para cada camada de \"Escuridão\""
  },
  State_24596_Name = {Text = "escuridão"},
  State_2460_Desc = {
    Text = "Equipe única: O dano base do portador, <IntoxicationIconKeywords:veneno> e <RetaliateIconKeywords:contra-ataque> são aumentados em <WeaponEffect_Num:[StateArg1] %>, a taxa crítica e o dano crítico aumentam em <WeaponEffect_Num:[StateArg2] %>"
  },
  State_2460_WeaponDesc = {
    Text = "O dano básico causado pelo portador, <IntoxicationIconKeywords:veneno> e <RetaliateIconKeywords:balcão> aumentam <WeaponEffect_Num:[StateArg1]%>, a taxa crítica e o dano crítico aumentam <WeaponEffect_Num:[StateArg2]%>"
  },
  State_2461_Desc = {
    Text = "Nesta batalha, ao sofrer dano fatal, revive, recupera [Layer] pontos de vida e todos os despertadores ganham [StateArg1] pontos de loucura. Não pode ser dissipado."
  },
  State_2461_Name = {
    Text = "Pássaro do Paraíso Imortal"
  },
  State_2463_Desc = {
    Text = "No início da batalha, fusão de embrião +20%. Para cada Despertado com loucura cheia, fusão de embrião +20% extra"
  },
  State_24640_Desc = {
    Text = "Após o início do combate, Fusão de embriões +[Blood:DescArg1]. Cada vez que a Resistência à Morte é ativada, Fusão de embriões +[Blood:DescArg1]. Cada vez que Sorel causa Dano, o Dano causado por si mesmo neste turno aumenta em um valor igual a 4% da Força de ataque."
  },
  State_24640_Name = {Text = "Pérola"},
  State_2464_Desc = {
    Text = "Poder de Cálculo de Carta Aumentado"
  },
  State_2464_Name = {
    Text = "Aumento permanente do poder de cálculo da carta"
  },
  State_2464_WeaponDesc = {
    Text = "Poder de Cálculo de Carta Aumentado"
  },
  State_24654_Desc = {
    Text = "Após Daffodil matar um inimigo de qualquer forma, a taxa de crítico da equipe aumenta permanentemente em 5% para este nível, acumulando até 5 vezes. (Atualmente acumulado [DescArg1] vezes)"
  },
  State_24654_Name = {
    Text = "Névoa Avarenta"
  },
  State_2466_Desc = {
    Text = "Até o início do próximo turno, para cada instância de Dano recebido, o tentáculo realiza um Contrataque no atacante uma vez. Dano temporário de tentáculo +[Layer]."
  },
  State_2466_Name = {
    Text = "[Descartado] Linhagem de Heresia"
  },
  State_24678_Name = {
    Text = "Estado@Clone de N@Murmúrio2 troca de estado"
  },
  State_24679_Name = {
    Text = "Estado@Clone3 de N@Murmúrio6 troca de estado"
  },
  State_2467_Desc = {
    Text = "Estado@prologo análise ofensiva"
  },
  State_2467_Name = {
    Text = "Estado@prologo análise ofensiva"
  },
  State_2467_WeaponDesc = {
    Text = "Estado@prologo análise ofensiva"
  },
  State_24680_Name = {
    Text = "Estado@Clone2 de N@Murmúrio1 troca de estado"
  },
  State_24681_Name = {
    Text = "Estado@Clone de N@Murmúrio6 troca de estado"
  },
  State_24682_Name = {
    Text = "Estado@Clone3 de N@Murmúrio3 troca de estado"
  },
  State_24683_Name = {
    Text = "Estado@Clone2 de N@Murmúrio2 troca de estado"
  },
  State_24684_Name = {
    Text = "Estado@Clone de N@Murmúrio4 troca de estado"
  },
  State_24685_Name = {
    Text = "Estado@Clone de N@Murmúrio5 troca de estado"
  },
  State_24686_Name = {
    Text = "Estado@Clone3 de N@Murmúrio5 troca de estado"
  },
  State_24687_Name = {
    Text = "Estado@Clone3 de N@Murmúrio2 troca de estado"
  },
  State_24688_Name = {
    Text = "Estado@Clone2 de N@Murmúrio6 troca de estado"
  },
  State_24689_Name = {
    Text = "Estado@Clone3 de N@Murmúrio4 troca de estado"
  },
  State_24690_Name = {
    Text = "Estado@Clone3 de N@Murmúrio1 troca de estado"
  },
  State_24691_Name = {
    Text = "Estado@Clone2 de N@Murmúrio4 troca de estado"
  },
  State_24692_Name = {
    Text = "Estado@Clone2 de N@Murmúrio3 troca de estado"
  },
  State_24693_Name = {
    Text = "Estado@Clone de N@Murmúrio3 troca de estado"
  },
  State_24694_Name = {
    Text = "Estado@Clone2 de N@Murmúrio5 troca de estado"
  },
  State_2470_Desc = {
    Text = "Ao pegar, perca permanentemente [Arg1] pontos de alerta, e o dano ativo causado receberá um bônus de 1x de poder"
  },
  State_24719_Desc = {
    Text = "\"@2\"apareceu em sua forma liberada, com a Vida triplicada."
  },
  State_24719_Name = {
    Text = "Ressurreição do destino"
  },
  State_24719_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_2471_Desc = {
    Text = "No início do turno, reduz a nossa equipe em 1 alerta"
  },
  State_2471_Name = {Text = "Corrosão"},
  State_2471_WeaponDesc = {
    Text = "No início do turno, reduz a nossa equipe em 1 alerta"
  },
  State_24720_Desc = {
    Text = "O poder de uma existência desconhecida ainda permanece adormecido sob a piscina negra, prestes a ser derrotado antes de reviver completamente, retornando à vida e começando a lutar em sua forma libertadora"
  },
  State_24720_Name = {
    Text = "hibernação"
  },
  State_2472_Desc = {
    Text = "Dano simultâneo ao escudo e à vida, não pode ser imunizado"
  },
  State_2472_Name = {
    Text = "<PunctureDamagewords:dano por perfuração>"
  },
  State_2472_WeaponDesc = {
    Text = "Dano por perfuração ignora escudos, redução de dano e bloqueio do alvo, causando dano direto"
  },
  State_24730_Desc = {
    Text = "Aumenta temporariamente o Espaço Hiperdimensional, com um limite de 10. Na próxima vez que entrar em um Turno Ultra, as cartas no Espaço Ultra Temporário serão colocadas na mão, removendo o Espaço Ultra Temporário."
  },
  State_24730_Name = {
    Text = "<CardKeyWord:Espaço Temporário>"
  },
  State_24737_Desc = {
    Text = "No início do turno, causa sangramento ao oponente, cada 1 camada de destino causará [StateArg1] pontos de sangramento"
  },
  State_24737_Name = {Text = "destino"},
  State_24738_Desc = {
    Text = "Cada camada de destino ativada causará [StateArg1] pontos de sangramento, cada carta jogada reduz 1 camada de destino"
  },
  State_24738_Name = {Text = "destino"},
  State_24739_Name = {Text = "destino"},
  State_2473_Desc = {
    Text = "[Defesa] perde 1 Tentáculo, recupera [StateArg1] de Vida. [Ataque] perde [StateArg2] de Vida, gera 1 Tentáculo"
  },
  State_2473_Name = {
    Text = "Carne do Imortal da Criação"
  },
  State_2473_WeaponDesc = {
    Text = "[Defesa] perde 1 Tentáculo, recupera [StateArg1] de Vida. [Ataque] perde [StateArg2] de Vida, gera 1 Tentáculo"
  },
  State_2474_Desc = {
    Text = "Aumenta [Layer]% do ataque"
  },
  State_2474_Name = {
    Text = "Aumento Percentual de Ataque Geral"
  },
  State_2474_WeaponDesc = {
    Text = "Aumenta [Layer]% do ataque"
  },
  State_2475_Desc = {
    Text = "Único na equipe: O DANO Ativo causado pelo portador é aumentado em <WeaponEffect_Num:[StateArg3]%.> Após jogar ou descartar 1 Carta de Comando do portador, inflija <WeaponEffect_Num:[StateArg1]%> do ATK do portador como <IntoxicationIconKeywords:veneno> a um inimigo aleatório. Após o término da Rodada Ultra, há uma chance de <WeaponEffect_Num:[StateArg2]%> de ativar 100% de veneno para todos os inimigos."
  },
  State_2475_WeaponDesc = {
    Text = "O Dano ativo do Portador +<WeaponEffect_Num:[DescArg2]> pontos. Após Disparar ou descartar 1 Carta de comando do Portador, aplica <WeaponEffect_Num:[DescArg1]> capas de <IntoxicationIconKeywords:Envenenamento> a um inimigo aleatório. Após o término do Turno Ultra, há <WeaponEffect_Num:[StateArg2]>% de chance de ativar [DescArg3]% de Envenenamento em todos os inimigos."
  },
  State_2476_Name = {
    Text = "Estado@gênesis do conhecedor iluminar 1"
  },
  State_2478_Desc = {
    Text = "O escudo aplicado pelo Nautilus é dobrado"
  },
  State_2478_Name = {
    Text = "Mestre reparador"
  },
  State_2478_WeaponDesc = {
    Text = "O escudo aplicado pelo Nautilus é dobrado"
  },
  State_2479_Desc = {
    Text = "Cada vez que o Fogo Verde causa dano, aumenta uma camada"
  },
  State_2479_Name = {
    Text = "Contagem de Imagem de Esmeralda"
  },
  State_2479_WeaponDesc = {
    Text = "Cada vez que o Fogo Verde causa dano, aumenta uma camada"
  },
  State_2480_Desc = {
    Text = "Ao recuperar vida, ganhe [StateArg1] contra-ataque. O abissal, a cada carta jogada, recupera 1 ponto de vida"
  },
  State_2480_Name = {
    Text = "Corpo transformado"
  },
  State_2481_Desc = {
    Text = "Estado@prologoResetarBaralho0_2_3_1"
  },
  State_2481_Name = {
    Text = "Estado@prologoResetarBaralho0_2_3_1"
  },
  State_2481_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_2_3_1"
  },
  State_2482_Desc = {
    Text = "Vida abaixo de 50%, invoca um \"Triângulo Corrosivo\" com vida equivalente"
  },
  State_2482_Name = {
    Text = "Invocação"
  },
  State_2482_WeaponDesc = {
    Text = "Vida abaixo de 50%, invoca um \"Triângulo Corrosivo\" com vida equivalente"
  },
  State_2486_Desc = {
    Text = "Ao iniciar a rodada, ganhe 1 aritmética para cada inimigo presente. Ao matar um inimigo com dano ativo, cause sangramento equivalente ao excesso de dano a outros inimigos"
  },
  State_24879_Desc = {
    Text = "Mil anos se passaram, dez mil anos se passaram, eles esperam nas ruínas eternas. Após a morte, reduza imediatamente 1 camada de \"Caos\" de \"N\" e conceda a \"N\" [DescArg1] pontos de escudo e [DescArg2] pontos de força"
  },
  State_24879_Name = {
    Text = "Clone Ilusório"
  },
  State_2488_Desc = {
    Text = "Quando você joga uma Carta de Buff, Carta de Sintoma ou Carta de Estado, o Despertador com o menor Aliemus ganha 10 de Aliemus."
  },
  State_2489_Desc = {
    Text = "Taxa crítica aumenta em 10%. Após o primeiro crítico de cada rodada, aumenta a taxa crítica em mais 20%; após o terceiro crítico causado na rodada, aumenta o dano crítico em mais 50%"
  },
  State_2490_Desc = {
    Text = "Cada camada adiciona 1 ataque, perde 1 camada ao sofrer dano, perde todas no fim do turno"
  },
  State_2490_Name = {Text = "Oração"},
  State_2491_Desc = {
    Text = "Ao recuperar vida, ganha escudo equivalente"
  },
  State_2491_Name = {
    Text = "Endurecimento temporário"
  },
  State_2492_Desc = {
    Text = "Imune ao primeiro dano ativo a cada turno"
  },
  State_2492_Name = {Text = "Firmemente"},
  State_2492_WeaponDesc = {
    Text = "Imune ao primeiro dano ativo a cada turno"
  },
  State_2493_Desc = {
    Text = "Dano ativo reduzido em [Layer]"
  },
  State_2493_Name = {
    Text = "Redução de força"
  },
  State_2494_Desc = {
    Text = "Estado@prologoLoucura0_1_4_1"
  },
  State_2494_Name = {
    Text = "Estado@prologoLoucura0_1_4_1"
  },
  State_2494_WeaponDesc = {
    Text = "Estado@prologoLoucura0_1_4_1"
  },
  State_2495_Desc = {
    Text = "Estado@prologoLoucura0_1_4_2"
  },
  State_2495_Name = {
    Text = "Estado@prologoLoucura0_1_4_2"
  },
  State_2495_WeaponDesc = {
    Text = "Estado@prologoLoucura0_1_4_2"
  },
  State_24968_Desc = {
    Text = "Após o início do combate, Fusão de embriões +[Blood:DescArg2]. Cada vez que a Resistência à Morte é ativada, Fusão de embriões +[Blood:DescArg2]. Cada vez que Sorel causa Dano, o Dano causado por si mesmo neste turno aumenta em [DescArg1] pontos."
  },
  State_24968_Name = {Text = "Pérola"},
  State_2496_Desc = {
    Text = "Recupere [Arg1] de vida no início do turno. Se a vida estiver abaixo de 50%, a recuperação aumenta para [Arg2]"
  },
  State_2496_Name = {
    Text = "Sangue Bendito"
  },
  State_24976_Desc = {
    Text = "\"A Dama Crescente\" despertou. Cuidado com os danos causados pelos seus pratos especiais!"
  },
  State_24976_Name = {
    Text = "Karen Despertar!"
  },
  State_24976_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_24977_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_24977_Name = {
    Text = "Ainda não despertado"
  },
  State_2497_Desc = {
    Text = "Lily imitará a primeira carta de comando jogada pelo jogador a cada turno. Se for uma carta de ataque, Lily ganha +1 ataque; se for uma carta de defesa, Lily ganha um escudo de 10% de vida; se for outra carta de comando, Lily não sabe o que acontecerá e invocará uma pústula"
  },
  State_2497_Name = {
    Text = "Lili desperta!"
  },
  State_2497_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_2498_Name = {
    Text = "Coelho Amaldiçoado dos Acessórios"
  },
  State_2498_WeaponDesc = {
    Text = "O escudo e a recuperação de vida do portador aumentam em 6%. Se a maestria do domínio do portador for maior que 50, o escudo e a recuperação de vida aumentam em mais 6%"
  },
  State_2499_Name = {
    Text = "Maldição de estagnação"
  },
  State_2500_Desc = {
    Text = "Cada vez que causa dano real, adiciona veneno"
  },
  State_2500_Name = {Text = "toxina"},
  State_2501_Desc = {
    Text = "Equipe Única: O limite de vida da equipe aumenta em 10%. A cura e o escudo causados pelo portador aumentam em <WeaponEffect_Num:[StateArg3]%>. Após disparar o \"golpe\" do portador, recupera <WeaponEffect_Num:[StateArg1]%> da vida perdida. Após disparar a \"defesa\" do portador, ganha um escudo equivalente a <WeaponEffect_Num:[StateArg2]%> da vida atual. Esse efeito pode ser ativado no máximo 1 vez por turno."
  },
  State_2501_Name = {
    Text = "Nascimento de uma alma"
  },
  State_2501_WeaponDesc = {
    Text = "Aumenta o limite de vida da equipe em 10%. O tratamento e o escudo causados pelo portador aumentam em <WeaponEffect_Num:[StateArg3]%. Após disparar o \"golpe\" do portador, recupera [StateArg1]% (<WeaponEffect_Num:[Heal:DescArg1]>) da vida perdida. Após disparar a \"defesa\" do portador, ganha [StateArg1]% (<WeaponEffect_Num:[Block:DescArg2]>) de escudo da vida atual. Este efeito pode ser ativado no máximo 1 vez por turno."
  },
  State_2502_Desc = {
    Text = "Todo Dano ativo e Dano de tentáculo causado -50%."
  },
  State_2502_Name = {
    Text = "Fraqueza de Extinção"
  },
  State_2502_WeaponDesc = {
    Text = "Todo dano reduzido em 50%"
  },
  State_2503_Desc = {
    Text = "Equipe Única: O dano básico causado pelas cartas do portador aumenta em <WeaponEffect_Num:[StateArg1]%. No início do turno, há <WeaponEffect_Num:[StateArg2]%> de chance de gerar uma carta aleatória do portador na mão, com consumo adicional. Se o domínio atual for \"Carne e sangue\", ao usar \"embrião\" no portador, a taxa de crítico do próximo golpe da carta do portador neste turno aumenta em <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_2503_WeaponDesc = {
    Text = "O dano base causado pelas cartas do portador aumenta em <WeaponEffect_Num:[StateArg1]%>. No início da rodada, há uma probabilidade de <WeaponEffect_Num:[StateArg2]%> de gerar uma carta aleatória do portador na mão, com consumo adicional. Se o domínio atual for \"Carne e sangue\", ao usar \"embrião\" no portador, aumenta a taxa de crítico do próximo golpe das cartas do portador neste turno em <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_2504_Desc = {
    Text = "\"Ataque\" ganha 2 Aritmética e descarta 1 carta aleatória; \"Defesa\" compra 2 cartas e perde 1 Aritmética."
  },
  State_25056_Desc = {
    Text = "Ao consumir aritmética, fará com que karen obtenha [Layer] pontos de poder temporário"
  },
  State_25056_Name = {
    Text = "Bem alimentado e bem hidratado"
  },
  State_25057_Desc = {
    Text = "Ao consumir aritmética, fará com que karen obtenha [StateArg1] pontos de poder temporário; no final do turno, remove 1 camada"
  },
  State_25057_Name = {
    Text = "Bem alimentado e bem hidratado"
  },
  State_2505_Name = {
    Text = "Homenagem de Abril dos Acessórios"
  },
  State_2505_WeaponDesc = {
    Text = "No início da batalha, se o portador for da classe Transdimensional, ataque +25%"
  },
  State_2507_Desc = {
    Text = "Ao pegar, a vida máxima aumenta em 100%; no início do turno, perca [Arg1] pontos de vida"
  },
  State_2509_Name = {
    Text = "Estado@DomínioGeral"
  },
  State_2511_Desc = {
    Text = "Estado@prologoEnsinoDeEnergia"
  },
  State_2511_Name = {
    Text = "Estado@prologoEnsinoDeEnergia"
  },
  State_2511_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_2_2"
  },
  State_2512_Desc = {
    Text = "Ao jogar 1 carta com consumo de aritmética de 3 ou mais, puxe 1 carta e ganhe 1 de aritmética"
  },
  State_2514_Desc = {
    Text = "Escudo reduzido em [Layer] nesta batalha"
  },
  State_2514_Name = {
    Text = "Vigilância reduzida"
  },
  State_2514_WeaponDesc = {
    Text = "Escudo reduzido em [Layer] nesta batalha"
  },
  State_2515_Desc = {
    Text = "[ataque] aplica [StateArg1] níveis de veneno a todos os inimigos"
  },
  State_2515_Name = {
    Text = "Criação neurotoxina"
  },
  State_25163_Desc = {
    Text = "Ele é tão evasivo quanto a névoa"
  },
  State_25163_Name = {
    Text = "Sombra do passado"
  },
  State_25165_Desc = {
    Text = "Efeito extra exclusivo das cartas de comando de Círculo·Ramona, ativado quando possui 3 camadas de negentropia. O ciclo será herdado para a próxima batalha."
  },
  State_25165_Name = {
    Text = "<TimeBeacon:Ciclo>"
  },
  State_25166_Desc = {
    Text = "Sempre que se tem 3 camadas de negentropia, jogar a carta de comando \"Ciclo·Ramona\" consumirá toda a negentropia e ativará um efeito extra de ciclo, com uma capacidade de acumular no máximo 3 camadas de negentropia"
  },
  State_25166_Name = {
    Text = "<TimeBeacon2: negentropia>"
  },
  State_2516_Desc = {
    Text = "Não pode ser jogado"
  },
  State_2516_Name = {
    Text = "Não pode ser jogado"
  },
  State_2516_WeaponDesc = {
    Text = "A carta não pode ser jogada"
  },
  State_25179_Name = {
    Text = "Juízo de Loucura"
  },
  State_2517_Desc = {
    Text = "Após nossa equipe liberar a exaltação, perderá o poder naquele turno. Uma vez por turno"
  },
  State_2517_Name = {
    Text = "Temor da loucura"
  },
  State_25181_Name = {
    Text = "Efeito de Preservação de Reencarnação"
  },
  State_2518_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_1_3"
  },
  State_2518_Name = {
    Text = "Estado@prologoResetarBaralho0_1_1_3"
  },
  State_2518_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_1_3"
  },
  State_25194_Desc = {
    Text = "Após a morte, aumenta o escudo de \"N\" em [DescArg1] pontos e a força permanente em [DescArg2] pontos"
  },
  State_2519_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_1_3"
  },
  State_2519_Name = {
    Text = "Estado@prologoResetarBaralho0_1_1_3"
  },
  State_2519_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_1_3"
  },
  State_25204_Name = {
    Text = "Estado@Clone2 de N@Julgamento de intenção"
  },
  State_25205_Name = {
    Text = "Estado@Clone3 de N@Julgamento de intenção"
  },
  State_25206_Name = {
    Text = "Estado@N@Adicionar julgamento de clone N"
  },
  State_25207_Name = {
    Text = "Estado@Clone de N@Julgamento de intenção"
  },
  State_2520_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_1_2"
  },
  State_2520_Name = {
    Text = "Estado@prologoResetarBaralho0_1_1_2"
  },
  State_2520_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_1_2"
  },
  State_2522_Desc = {
    Text = "Hilota ya ha despertado, su intensidad de ataque y deseo aumentarán"
  },
  State_2522_Name = {
    Text = "Despertar de Shiro"
  },
  State_2523_Desc = {
    Text = "No início dos turnos ímpares, ganhe [Arg1] de poder neste turno. No início dos turnos pares, ganhe [Arg2] de alerta neste turno"
  },
  State_2524_Desc = {
    Text = "No início da batalha, ganhe 1 ponto de força"
  },
  State_2524_Name = {
    Text = "Renomeia-se de longe"
  },
  State_2525_Desc = {
    Text = "Ataques -1, ganha [Layer] de força"
  },
  State_2525_Name = {
    Text = "Dissipação"
  },
  State_2527_Name = {
    Text = "Bônus de Força Escarlate"
  },
  State_2528_Desc = {
    Text = "Ao jogar 1 carta com custo de aritmética real de 3, puxe 1 carta e ganhe 2 de aritmética"
  },
  State_2529_Desc = {
    Text = "Neste turno, dano crítico aumenta [Layer] %"
  },
  State_2529_Name = {
    Text = "Dano Crítico Temporário"
  },
  State_2529_WeaponDesc = {
    Text = "Neste turno, dano crítico aumenta [Layer] %"
  },
  State_2531_Desc = {
    Text = "Cada [Damage:StateArg2] vezes que o Fogo Verde causa dano, ganha uma carta de consumo [Chama Verde]"
  },
  State_2531_Name = {
    Text = "Imagem de Esmeralda"
  },
  State_2531_WeaponDesc = {
    Text = "Cada [Damage:StateArg2] vezes que o Fogo Verde causa dano, ganha uma carta de consumo [Chama Verde]"
  },
  State_2532_Name = {
    Text = "Palpitação Escarlate dos Acessórios"
  },
  State_2534_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_3_3"
  },
  State_2534_Name = {
    Text = "Estado@prologoResetarBaralho0_1_3_3"
  },
  State_2534_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_3_3"
  },
  State_2535_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_3_2"
  },
  State_2535_Name = {
    Text = "Estado@prologoResetarBaralho0_1_3_2"
  },
  State_2535_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_3_2"
  },
  State_2536_Name = {
    Text = "Estado@Aumento de dano crítico de carta de ataque temporário"
  },
  State_2537_Desc = {
    Text = "Quando a lâmina de fantasia aplica um escudo, ganha [StateArg2] pontos de defesa temporária"
  },
  State_2537_Name = {
    Text = "Insight de Batalha"
  },
  State_2537_WeaponDesc = {
    Text = "Quando a lâmina de fantasia aplica um escudo, ganha [StateArg2] pontos de defesa temporária"
  },
  State_2538_Desc = {
    Text = "Ao Disparar, ganhe [StateArg1] de <RetaliateIconKeywords:Contrataque>, em seguida cause Dano Real a todos os inimigos igual a [StateArg2]% do seu <RetaliateIconKeywords:Contrataque>"
  },
  State_2538_Name = {
    Text = "<Rune_9_High:Espinho Avançado>"
  },
  State_25391_Desc = {
    Text = "Um Despertar no grupo foi selecionado como o \"Público Sortudo\", e todos os cards desse Despertar têm o efeito \"Aplauso\"."
  },
  State_25391_Name = {
    Text = "Spectador de sorte"
  },
  State_25392_Desc = {
    Text = "Após jogar, perca 2% do máximo de saúde, o Grande Mágico ganha 1 camada de \"orgulho\" neste turno"
  },
  State_25392_Name = {
    Text = "<CardCheerKeywords:Aplauso>"
  },
  State_25401_Desc = {
    Text = "Este cartão, quando está na mão, aumentará o limite de cartas na mão em +1"
  },
  State_25401_Name = {
    Text = "Ignorar limite de cartas na mão"
  },
  State_25403_Desc = {
    Text = "Dano de tentáculo reduzido em 50%, cada vez que causar dano de tentáculo, ganhe [Layer] pontos de escudo"
  },
  State_25403_Name = {Text = "Mar Calmo"},
  State_25405_Desc = {
    Text = "Este cartão estará sempre na mão, independentemente da situação"
  },
  State_25405_Name = {
    Text = "Manter permanentemente"
  },
  State_25406_Desc = {
    Text = "Neste turno, não pode mudar a forma dos tentáculos"
  },
  State_25406_Name = {
    Text = "Loucura das Profundezas·Limitada"
  },
  State_25407_Desc = {
    Text = "O dano de tentáculo aumenta em 25%, e ao final da rodada, o número de tentáculos -1"
  },
  State_25407_Name = {
    Text = "Loucura das profundezas"
  },
  State_25415_Desc = {
    Text = "Após liberar a Chave de Comando, ganha [Layer] pontos de energia da chave"
  },
  State_25415_Name = {
    Text = "Energia Temporária do Caos Transbordando"
  },
  State_25417_Name = {Text = "Bomba 3"},
  State_25418_Name = {Text = "Bomba 2"},
  State_2542_Name = {
    Text = "Contagem do Membro Sem Nome da Criação"
  },
  State_2543_Name = {
    Text = "Estado@Fase2_14Batalha8Bolha1"
  },
  State_2544_Desc = {
    Text = "Estado@monstroPrologoPassivo"
  },
  State_2544_Name = {
    Text = "Estado@monstroPrologoPassivo"
  },
  State_2544_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo"
  },
  State_2545_Desc = {
    Text = "No início da batalha, fusão de embrião +20%. Para cada Despertado com loucura cheia, fusão de embrião +20% extra"
  },
  State_2547_Desc = {
    Text = "No início do turno, adiciona 1 cartão de \"tridente\" de força [Arg1] obtida neste turno à mão. Após liberar a exaltação, aumenta o poder de todos os \"tridentes\" na mão em [Arg2]"
  },
  State_2548_Desc = {
    Text = "Imune a uma morte, recupera 50 de vida após ativar e falha permanentemente"
  },
  State_2548_Name = {
    Text = "Boneco Substituto da Criação"
  },
  State_2548_WeaponDesc = {
    Text = "Imune a uma morte, recupera 50 de vida após ativar e falha permanentemente"
  },
  State_2549_Desc = {
    Text = "Reduz o dano causado por habilidades e tentáculos"
  },
  State_2549_Name = {
    Text = "<ExhaustionIconKeywords: força reduzida>"
  },
  State_2549_WeaponDesc = {
    Text = "Cada camada de exaustão reduz dano e dano de tentáculos em 1"
  },
  State_2550_Desc = {
    Text = "Ao sacar, torna-se vulnerável por 1 turno. Após usar, torna todos os inimigos vulneráveis por 1 turno. Não pode ser vendido"
  },
  State_2550_Name = {
    Text = "EstadoMaldiçãoColapso"
  },
  State_2550_WeaponDesc = {
    Text = "Ao sacar, torna-se vulnerável por 1 turno. Após usar, torna todos os inimigos vulneráveis por 1 turno. Não pode ser vendido"
  },
  State_2552_Desc = {
    Text = "As cartas não entram na pilha de descarte na fase de descarte, mas permanecem na mão"
  },
  State_2552_Name = {
    Text = "<RetainIconKeywords:Manter>"
  },
  State_2552_WeaponDesc = {
    Text = "As cartas não entram na pilha de descarte na fase de descarte, mas permanecem na mão"
  },
  State_2553_Desc = {
    Text = "No início do turno, ganha 1 ponto de aritmética"
  },
  State_2553_Name = {
    Text = "Relíquia Arcanum aritmética"
  },
  State_2553_WeaponDesc = {
    Text = "No início do turno, ganha 1 ponto de aritmética"
  },
  State_2554_Name = {
    Text = "Correio matinal de Putney"
  },
  State_2556_Desc = {
    Text = "Após a redução de HP, ganha um escudo igual a [Layer]% do valor reduzido"
  },
  State_2556_Name = {
    Text = "Escudo de sangue"
  },
  State_2556_WeaponDesc = {
    Text = "Após a redução de HP, ganha um escudo igual a [Layer]% do valor reduzido"
  },
  State_2557_Desc = {
    Text = "No início do próximo turno, ganhe [Layer] de escudo"
  },
  State_2557_Name = {
    Text = "Escudo de dor e prazer"
  },
  State_2558_Desc = {
    Text = "Quando a vida estiver abaixo de 50%([StateArg1]), se dividirá em 2 corpos de vida equivalentes \"dissoluto de interferência\""
  },
  State_2558_Name = {Text = "Fissão"},
  State_2558_WeaponDesc = {
    Text = "Quando a vida estiver abaixo de 50%([StateArg1]), se dividirá em 2 corpos de vida equivalentes \"escultura de cera tipo II\""
  },
  State_2559_Desc = {
    Text = "Ao ser atacado, perde [Layer] pontos de força temporária"
  },
  State_2559_Name = {
    Text = "O Preço do Impulso"
  },
  State_2560_Desc = {
    Text = "No início do próximo turno, ganhe [Layer] de escudo"
  },
  State_2560_Name = {
    Text = "Criação fechada"
  },
  State_2560_WeaponDesc = {
    Text = "No início do próximo turno, ganhe [Layer] de escudo"
  },
  State_2561_Desc = {
    Text = "Talento melancólico"
  },
  State_2561_Name = {
    Text = "Talento melancólico"
  },
  State_2561_WeaponDesc = {
    Text = "Talento melancólico"
  },
  State_2562_Name = {
    Text = "Estado@Capítulo3_Resonância1_Marca"
  },
  State_2563_Desc = {
    Text = "Sempre que jogar a 10ª carta, aumente o dano de tentáculo em 2 e faça todos os tentáculos atacarem 1 vez"
  },
  State_2563_Name = {
    Text = "Relíquia tridente"
  },
  State_2563_WeaponDesc = {
    Text = "Sempre que jogar a 10ª carta, aumente o dano de tentáculo em 2 e faça todos os tentáculos atacarem 1 vez"
  },
  State_2564_Desc = {
    Text = "Todos os escudos obtidos são reduzidos em [DescArg1]%"
  },
  State_2564_Name = {
    Text = "<FragileColour:Frágil>"
  },
  State_2564_WeaponDesc = {
    Text = "Todos os escudos obtidos são reduzidos em 33%"
  },
  State_2565_Name = {
    Text = "Abraço Escarlate dos Acessórios"
  },
  State_2565_WeaponDesc = {
    Text = "Ao causar dano, o equipador ganha 20 pontos de s-energia; se causar dano crítico, isso é alterado para 50 pontos de s-energia, podendo ser ativado no máximo 3 vezes por turno"
  },
  State_2566_Desc = {
    Text = "Após receber 3 ataques em um turno, ganha 1 pilha de Loucura Temporária."
  },
  State_2566_Name = {Text = "\"Dor Doce\""},
  State_2567_Desc = {
    Text = "Recebeu [Layer] de Dano; após atingir 3 vezes, \"Malevolência Doce\" ganha 1 pilha de loucura neste turno."
  },
  State_2567_Name = {
    Text = "Número de \"Dor Doce\""
  },
  State_2567_WeaponDesc = {
    Text = "Sofreu [Layer] de dano; após atingir 3 vezes, \"Docilidade Malévola\" ganha 1 camada de loucura neste turno."
  },
  State_2569_Desc = {
    Text = "Efeito de bônus da recomendação de domínio aumentado para 50%, no início da fase sua maestria em domínios aumenta em 100"
  },
  State_2569_Name = {
    Text = "Estado@chaveDePrataSonho:separacaoAdaptativa"
  },
  State_2570_Desc = {
    Text = "Jogue para comprar [StateArg1] cartas"
  },
  State_2570_Name = {
    Text = "<Rune_3:Destreza>"
  },
  State_2571_Desc = {
    Text = "Para cada [Chaos] Despertador na equipe, a saúde máxima de todos os membros (inacabada), defesa e ataque aumentam em 50%."
  },
  State_2571_Name = {
    Text = "Bônus de Caos"
  },
  State_2571_WeaponDesc = {
    Text = "Para cada [Chaos] Despertador na equipe, a saúde máxima de todos os membros (inacabada), defesa e ataque aumentam em 50%."
  },
  State_2572_Desc = {
    Text = "Ao Disparar, <EmbryoFusionIconKeywords:Fusão de embriões> +[StateArg1]."
  },
  State_2572_Name = {
    Text = "<Rune_12:Sede de Sangue>"
  },
  State_2573_Desc = {
    Text = "Ganhe 5 camadas de [Fuse]. Diminui em 1 ao jogar uma carta. Quando chega a 0, autodestrói, causando dano de Ataque * 2,5."
  },
  State_2573_Name = {
    Text = "Granada explosiva"
  },
  State_2573_WeaponDesc = {
    Text = "Ganhe 5 camadas de [Fuse]. Diminui em 1 ao jogar uma carta. Quando chega a 0, autodestrói, causando dano de Ataque * 2,5."
  },
  State_2574_Desc = {
    Text = "Dano Crítico +50%. Se não atacar em um turno, o próximo ataque será crítico"
  },
  State_2574_Name = {
    Text = "Estado@chaveDePrataSonho:dancaCircular"
  },
  State_2575_Desc = {
    Text = "Equipe Única: Ao começar a batalha, para cada Criação, a taxa de crítico das cartas de comando do portador aumenta em [StateArg1]%. Após o portador liberar a Fúria Explosiva, lance um dado de 4 lados; o portador ganha <WeaponEffect_Num:[StateArg2]> vezes o número mostrado no dado em Fúria e Dano Crítico Temporário. Se o resultado for 4 ou mais, outros Corpos Despertos também ganham metade."
  },
  State_2575_WeaponDesc = {
    Text = "Ao iniciar a batalha, para cada criação, a taxa crítica das cartas de comando do portador aumenta em [StateArg1]%. Após o portador liberar a Fúria Explosiva, ele lança um dado de 4 lados, ganhando <WeaponEffect_Num:[StateArg2]> vezes o valor do dado em Fúria e Dano Crítico Temporário; se o resultado for 4 ou mais, outros Corpos Despertos também ganham metade."
  },
  State_2576_Desc = {
    Text = "Sempre que uma carta entrar no espaço ultra, reduz seu custo de aritmética em -1"
  },
  State_2579_Desc = {
    Text = "Aumenta as instâncias de Dano ativo causado em [Layer] neste turno."
  },
  State_2579_Name = {
    Text = "Loucura Temporária"
  },
  State_2580_Desc = {
    Text = "Sempre que a carta da bruxa ceifadora entra ou sai do espaço ultra, ganhe 1 aritmética"
  },
  State_2580_Name = {
    Text = "Projeção dimensional"
  },
  State_2581_Desc = {
    Text = "O nível de Regeneração de Chave de todos os Despertadores aumentou em 30. Após liberar o Bando, embaralhe 3 <DerivativeCardKeywords_4:\"Inspiração\"> no seu baralho."
  },
  State_2581_Name = {
    Text = "Estado@pêndulo crono percepção"
  },
  State_2582_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_2582_Name = {
    Text = "Estado@ProtótipoCanhãoLaserLoucura"
  },
  State_2583_Desc = {
    Text = "Ao receber dano ativo, adiciona uma camada de contagem à equipe"
  },
  State_2583_Name = {
    Text = "Estado@grande lâmina da vingança contagem"
  },
  State_2583_WeaponDesc = {
    Text = "Ao receber dano ativo, adiciona uma camada de contagem à equipe"
  },
  State_2584_Desc = {
    Text = "Cada vez que o baralho é reiniciado, ganha [Arg1] força"
  },
  State_2586_Desc = {
    Text = "Todos os escudos obtidos são reduzidos em 25%, removido 1 camada no final do turno"
  },
  State_2586_Name = {
    Text = "<FragileIconKeywords: Frágil>"
  },
  State_2586_WeaponDesc = {
    Text = "Todos os escudos obtidos são reduzidos em 25%"
  },
  State_2587_Desc = {
    Text = "Dano da ferida dobrado. Cada vez que causar dano real, ganha [Layer] de escudo"
  },
  State_2587_Name = {
    Text = "Dente do Devorador Celestial"
  },
  State_2587_WeaponDesc = {
    Text = "Dano da ferida dobrado. Cada vez que causar dano real, ganha [Layer] de escudo"
  },
  State_2588_Desc = {
    Text = "Recebe [Layer] <FixedDamage:Dano Puro> e remove este Estado ao fim do turno. Ao restaurar Vida, remove capas de Sangramento iguais ao dobro da quantidade restaurada."
  },
  State_2588_Name = {
    Text = "Permanente <BleedingColour:sangrando>"
  },
  State_2588_WeaponDesc = {
    Text = "Após o final do turno, recebe [Layer] de dano e remove esse estado, cada cura pode reduzir as camadas pela metade"
  },
  State_2589_Name = {
    Text = "Gêmeos Torcidos Negros dos Acessórios"
  },
  State_2589_WeaponDesc = {
    Text = "No início dos turnos ímpares, adicione uma \"golpe\" do portador contendo ilusão e exausto à mão"
  },
  State_2590_Desc = {
    Text = "Ganha 10 selos negros ao se mover"
  },
  State_2590_Name = {
    Text = "Sacola sem fundo de Criação"
  },
  State_2590_WeaponDesc = {
    Text = "Ganha 10 selos negros ao se mover"
  },
  State_2592_Desc = {
    Text = "Ao perder 1 de vida, remova 1 camada. Ao zerar, ganhe [DescArg1] de escudo"
  },
  State_2592_Name = {
    Text = "Barreira dimensional"
  },
  State_2593_Name = {
    Text = "Estado@CançãoDeSangueEAreia"
  },
  State_2594_Desc = {
    Text = "Ao causar dano real, ganha escudo"
  },
  State_2594_Name = {
    Text = "Dente do Devorador Celestial"
  },
  State_2594_WeaponDesc = {
    Text = "Ao causar dano real, ganha escudo"
  },
  State_2595_Desc = {
    Text = "A cada dano, ganha [StateArg2] de força temporária"
  },
  State_2595_Name = {
    Text = "Espada da Rainha do Conhecimento"
  },
  State_2597_Desc = {
    Text = "Após o início do turno, ganhe [Layer] de escudo"
  },
  State_2597_Name = {
    Text = "Escudo de latência"
  },
  State_2597_WeaponDesc = {
    Text = "Após o início do turno, ganhe [Layer] de escudo"
  },
  State_2600_Desc = {
    Text = "Sempre que perder vida, o Despertado com menos loucura ganha 10 loucura. A cada 5 perdas de vida, ganha 1 camada de barreira"
  },
  State_2600_Name = {
    Text = "Pêndulo Temporal \"Análise\""
  },
  State_2601_Desc = {
    Text = "Nos turnos pares, dano recebido -50%, dano causado +33%"
  },
  State_2601_Name = {Text = "Caprichoso"},
  State_2601_WeaponDesc = {
    Text = "Nos turnos pares, dano recebido -50%, dano causado +33%"
  },
  State_2602_Desc = {
    Text = "Você foi marcado! Após jogar, o Fanático Eterno ganha [StateArg1] pontos de força temporária, removendo a marca de mergulho profundo deste comando"
  },
  State_2602_Name = {
    Text = "<CardKeyWord:Marca do Mergulho>"
  },
  State_2602_WeaponDesc = {
    Text = "Após jogar a carta, os elites do profundo recebem [StateArg1] de poder temporário"
  },
  State_2603_Desc = {
    Text = "Se \"Embrião\" estiver em sua mão, esgote todos os \"Embriões\". Cada \"Embrião\" ativa o efeito subsequente uma vez."
  },
  State_2603_Name = {
    Text = "<UnlimitedDevouredIconKeywords:Devorar Ilimitado>"
  },
  State_2604_Desc = {
    Text = "Neste turno, a taxa crítica aumenta em [Layer] %"
  },
  State_2604_Name = {
    Text = "Taxa de Crítico Temporária"
  },
  State_2604_WeaponDesc = {
    Text = "Neste turno, a taxa crítica aumenta em [Layer] %"
  },
  State_2605_Desc = {
    Text = "Quando a vida estiver abaixo de 95%([StateArg1]), dividir-se-á em 2 \"Estudos Experimentais\" com vida igual"
  },
  State_2605_Name = {Text = "Fissão"},
  State_2605_WeaponDesc = {
    Text = "Quando a vida estiver abaixo de 30%([StateArg1]), se dividirá em 3 corpos de vida equivalentes \"escultura de cera tipo II dissoluto\""
  },
  State_2606_Desc = {
    Text = "Quando a vida estiver abaixo de 90%([StateArg1]), dividir-se-á em 2 \"Estudos Experimentais\" com vida igual"
  },
  State_2606_Name = {Text = "Fissão"},
  State_2606_WeaponDesc = {
    Text = "Quando a vida estiver abaixo de 30%([StateArg1]), se dividirá em 3 corpos de vida equivalentes \"escultura de cera tipo II dissoluto\""
  },
  State_2607_Desc = {
    Text = "Ao final da batalha, recupere 5 de Vida"
  },
  State_2607_Name = {
    Text = "Dama côncava iluminar 3"
  },
  State_2607_WeaponDesc = {
    Text = "Ao final da batalha, recupere 5 de Vida"
  },
  State_2609_Desc = {
    Text = "Quando a vida estiver abaixo de 30%([StateArg1]), dividir-se-á em 2 \"Estudos Experimentais\" com vida igual"
  },
  State_2609_Name = {Text = "Fissão"},
  State_2609_WeaponDesc = {
    Text = "Quando a vida estiver abaixo de 30%([StateArg1]), se dividirá em 3 corpos de vida equivalentes \"escultura de cera tipo II dissoluto\""
  },
  State_2610_Desc = {
    Text = "Quando a vida estiver abaixo de 70%([StateArg1]), dividir-se-á em 2 \"Estudos Experimentais\" com vida igual"
  },
  State_2610_Name = {Text = "Fissão"},
  State_2610_WeaponDesc = {
    Text = "Quando a vida estiver abaixo de 30%([StateArg1]), se dividirá em 3 corpos de vida equivalentes \"escultura de cera tipo II dissoluto\""
  },
  State_2611_Desc = {
    Text = "Quando a vida estiver abaixo de 50%([StateArg1]), dividir-se-á em 2 \"Estudos Experimentais\" com vida igual"
  },
  State_2611_Name = {Text = "Fissão"},
  State_2611_WeaponDesc = {
    Text = "Quando a vida estiver abaixo de 30%([StateArg1]), se dividirá em 3 corpos de vida equivalentes \"escultura de cera tipo II dissoluto\""
  },
  State_2612_Desc = {
    Text = "Imitação do Antigo"
  },
  State_2612_Name = {
    Text = "Imitação do Antigo"
  },
  State_2612_WeaponDesc = {
    Text = "Imitação do Antigo"
  },
  State_2614_Desc = {
    Text = "Equipe única: Após jogar a carta de comando do portador, há uma probabilidade de <WeaponEffect_Num:[StateArg1]%> de adicioná-la de volta à mão a partir da pilha de descarte. Esse efeito só se aplica uma vez por rodada"
  },
  State_2614_WeaponDesc = {
    Text = "Após jogar a carta de comando do portador, há uma probabilidade de <WeaponEffect_Num:[StateArg1]%> de devolvê-la da pilha de descarte para a mão. Este efeito só pode ser ativado uma vez por turno"
  },
  State_2617_Desc = {
    Text = "No início do próximo turno, compra [DescArg1] Cartas adicionais."
  },
  State_2617_Name = {
    Text = "Sintoma: Empolgação"
  },
  State_2619_Desc = {
    Text = "Dano ativo reduzido em [Layer] nesta batalha"
  },
  State_2619_Name = {
    Text = "Redução de força"
  },
  State_2619_WeaponDesc = {
    Text = "Dano reduzido em [Layer] nesta batalha"
  },
  State_2620_Desc = {
    Text = "Faca Enferrujada da Criação"
  },
  State_2620_Name = {
    Text = "Lâmina de Folha de Salgueiro Enferrujada"
  },
  State_2623_Desc = {
    Text = "Ao iniciar a rodada, ganhe 1 aritmética"
  },
  State_2624_Desc = {
    Text = "Jogue para fazer todos os inimigos perderem [StateArg1] pontos de força temporária"
  },
  State_2624_Name = {
    Text = "<Rune_18:Esgotamento>"
  },
  State_2625_Desc = {
    Text = "Seu efeito de salto é ativado duas vezes. Ao entrar no turno extradimensional, todos os inimigos ganham 5 pontos de força temporária"
  },
  State_2625_Name = {
    Text = "Lâmpada de Pesadelo da Criação"
  },
  State_2626_Desc = {
    Text = "Limite de tentáculos reduzido em 1. No final do turno, todos os tentáculos atacam uma vez adicional"
  },
  State_2627_Name = {
    Text = "Obtenha [StateArg1] pontos de energia da chave"
  },
  State_2627_WeaponDesc = {
    Text = "A carta selecionada na \"escultura de cera inacabada\" ganha poder de chave"
  },
  State_2628_Desc = {
    Text = "As cartas copiadas na \"escultura de cera inacabada\" recebem efeito de oração"
  },
  State_2628_Name = {
    Text = "Estado@Capítulo2_Resonância3"
  },
  State_2628_WeaponDesc = {
    Text = "As cartas copiadas na \"escultura de cera inacabada\" recebem efeito de oração"
  },
  State_2629_Desc = {
    Text = "No \"esculture inacabada\", o intervalo de cópias de cartas foi ampliado"
  },
  State_2629_Name = {
    Text = "Estado@Capítulo2_Resonância2"
  },
  State_2629_WeaponDesc = {
    Text = "As cartas copiadas na \"escultura de cera inacabada\" e seu corpo recebem o efeito de \"inato\""
  },
  State_2630_Desc = {
    Text = "As cartas copiadas na \"escultura de cera inacabada\" e seu corpo recebem o efeito de \"manutenção\""
  },
  State_2630_Name = {
    Text = "Estado@Capítulo2_Resonância4"
  },
  State_2630_WeaponDesc = {
    Text = "As cartas copiadas na \"escultura de cera inacabada\" e seu corpo recebem o efeito de \"manutenção\""
  },
  State_2631_Desc = {
    Text = "Copia mais uma carta na \"escultura de cera inacabada\""
  },
  State_2631_Name = {
    Text = "Estado@Capítulo2_Resonância6"
  },
  State_2631_WeaponDesc = {
    Text = "Copia mais uma carta na \"escultura de cera inacabada\""
  },
  State_2633_Desc = {
    Text = "Cada vez que Dano ativo é recebido, adiciona 1 [Chama Verde] com Exaustão à mão por [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_2633_Name = {
    Text = "Fogo Atrativo para Mariposas"
  },
  State_2633_WeaponDesc = {
    Text = "Cada vez que você for atacado antes do seu próximo turno, adicione um [Chama Verde] à sua mão."
  },
  State_2634_Desc = {
    Text = "Ao jogar a carta, receba [StateArg1] pontos de dano e remova 1 camada. Quando as camadas forem 0, incube um \"ser do mar\" mais fraco. Se o estado de parasita ainda existir no final do turno, incube um \"ser do mar\" de vida aumentando com as camadas"
  },
  State_2634_Name = {Text = "Infestado"},
  State_2635_Desc = {
    Text = "Estado@prologo análise ofensiva marcador"
  },
  State_2635_Name = {
    Text = "Estado@prologo análise ofensiva marcador"
  },
  State_2635_WeaponDesc = {
    Text = "Estado@prologo análise ofensiva marcador"
  },
  State_2636_Name = {
    Text = "Estado@Capítulo4Resonância@PróximoTurnoCartas1"
  },
  State_2637_Desc = {
    Text = "Ao iniciar a rodada, ganhe [StateArg1] de aritmética"
  },
  State_2637_Name = {
    Text = "Relíquia injeção ativa"
  },
  State_2637_WeaponDesc = {
    Text = "Ao iniciar a rodada, ganhe [StateArg1] de aritmética"
  },
  State_2639_Desc = {
    Text = "Quando receber dano fatal durante a batalha, há uma chance de preservar 1 ponto de vida. Após isso, a probabilidade na investigação atual é reduzida pela metade, e a resistência à morte adquirida é reduzida pela metade"
  },
  State_2639_Name = {
    Text = "<DeathResistanceIconKeywords:Resistência à morte>"
  },
  State_2640_Name = {
    Text = "Efeito Repetido Geral 1 vez"
  },
  State_2645_Desc = {
    Text = "Estado@monstroPrologoPassivo1"
  },
  State_2645_Name = {
    Text = "Estado@monstroPrologoPassivo1"
  },
  State_2645_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo1"
  },
  State_2646_Desc = {
    Text = "Estado@monstroPrologoPassivo2"
  },
  State_2646_Name = {
    Text = "Estado@monstroPrologoPassivo2"
  },
  State_2646_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo2"
  },
  State_2647_Desc = {
    Text = "Estado@monstroPrologoPassivo3"
  },
  State_2647_Name = {
    Text = "Estado@monstroPrologoPassivo3"
  },
  State_2647_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo3"
  },
  State_2648_Desc = {
    Text = "Estado@monstroPrologoPassivo4"
  },
  State_2648_Name = {
    Text = "Estado@monstroPrologoPassivo4"
  },
  State_2648_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo4"
  },
  State_2649_Desc = {
    Text = "Estado@monstroPrologoPassivo5"
  },
  State_2649_Name = {
    Text = "Estado@monstroPrologoPassivo5"
  },
  State_2649_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo5"
  },
  State_2650_Desc = {
    Text = "Estado@monstroPrologoPassivo6"
  },
  State_2650_Name = {
    Text = "Estado@monstroPrologoPassivo6"
  },
  State_2650_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo6"
  },
  State_2651_Desc = {
    Text = "Estado@monstroPrologoPassivo7"
  },
  State_2651_Name = {
    Text = "Estado@monstroPrologoPassivo7"
  },
  State_2651_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo7"
  },
  State_2652_Desc = {
    Text = "Estado@monstroPrologoPassivo8"
  },
  State_2652_Name = {
    Text = "Estado@monstroPrologoPassivo8"
  },
  State_2652_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo8"
  },
  State_2653_Desc = {
    Text = "Estado@monstroPrologoPassivo9"
  },
  State_2653_Name = {
    Text = "Estado@monstroPrologoPassivo9"
  },
  State_2653_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo9"
  },
  State_2655_Desc = {
    Text = "Ao causar dano não bloqueado, restaura vida igual ao dano, removido ao causar dano"
  },
  State_2655_Name = {Text = "Vampirismo"},
  State_2656_Desc = {
    Text = "No início do próximo turno, fuja!!!!!!"
  },
  State_2656_Name = {Text = "escapar"},
  State_2660_Desc = {
    Text = "No início da batalha, ganhe força, mas o dano recebido aumenta em 5"
  },
  State_2660_Name = {
    Text = "Costas à água"
  },
  State_2661_Desc = {
    Text = "No início da batalha, todos os inimigos perdem [Arg1] pontos de força"
  },
  State_2662_Name = {
    Text = "Estado@Capítulo3_TesteDeEstado"
  },
  State_2663_Desc = {
    Text = "Ao comprá-lo, fique vulnerável por 1 rodada. Após o uso, fique vulnerável a todos os inimigos por 1 rodada. Não pode ser vendido"
  },
  State_2663_Name = {
    Text = "EstadoMaldiçãoFraqueza"
  },
  State_2663_WeaponDesc = {
    Text = "Ao comprá-lo, fique vulnerável por 1 rodada. Após o uso, fique vulnerável a todos os inimigos por 1 rodada. Não pode ser vendido"
  },
  State_2666_Name = {
    Text = "Taxa crítica da adaga do ciclo"
  },
  State_2667_Desc = {
    Text = "Dano de carta de ataque aumentado em [Layer] %"
  },
  State_2667_Name = {
    Text = "Dano de carta de ataque aumentado"
  },
  State_2667_WeaponDesc = {
    Text = "Dano de carta de ataque aumentado em [Layer] %"
  },
  State_2668_Desc = {
    Text = "Aumenta [Layer]% do ataque"
  },
  State_2668_Name = {
    Text = "Aumento Percentual Permanente de Ataque Geral"
  },
  State_2668_WeaponDesc = {
    Text = "Aumenta [Layer]% do ataque"
  },
  State_2669_Desc = {
    Text = "Dano crítico aumentado em [Layer]% nesta batalha"
  },
  State_2669_Name = {
    Text = "Dano crítico"
  },
  State_2670_Desc = {
    Text = "Você ganha [Arg1] pontos de escudo ao causar fraqueza; ao causar vulnerabilidade, você ganha [Arg2] pontos de poder. Se esses dois efeitos forem ativados dentro de 1 turno, você ganhará um adicional de [Arg1] pontos de escudo e [Arg2] pontos de poder"
  },
  State_2670_Name = {
    Text = "quadro pesado"
  },
  State_2671_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_2671_Name = {
    Text = "Ainda não despertado"
  },
  State_2672_Desc = {
    Text = "No início de cada turno, aplique [Vincular] à minha equipe."
  },
  State_2672_Name = {
    Text = "Restrição"
  },
  State_2672_WeaponDesc = {
    Text = "No início de cada turno, aplique [Vincular] à minha equipe."
  },
  State_2674_Desc = {
    Text = "Neste turno, a taxa crítica aumenta em [Layer] %"
  },
  State_2674_Name = {
    Text = "Taxa de Crítico Temporária"
  },
  State_2676_Name = {
    Text = "Palpitação Escarlate dos Acessórios"
  },
  State_2676_WeaponDesc = {
    Text = "Após liberar a chave, o portador ganha 15% de taxa crítica temporária. Se o dano crítico atual do portador for maior que 80%, ganha adicionalmente 15% de taxa crítica temporária"
  },
  State_2677_Desc = {
    Text = "Os primeiros 3 danos ativos/tentáculos recebidos a cada turno são reduzidos em 75%"
  },
  State_2677_Name = {
    Text = "\"Restos Imortais\""
  },
  State_2677_WeaponDesc = {
    Text = "Os primeiros 3 danos ativos/tentáculos recebidos a cada turno são reduzidos em 75%"
  },
  State_2679_Name = {
    Text = "Estado@Capítulo3_Resonância7_Marca"
  },
  State_2680_Desc = {
    Text = "Taxa crítica aumenta em 20%. Se a vida estiver abaixo de 25% no início da rodada, deverá ocorrer um crítico nesta rodada"
  },
  State_2681_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_2681_Name = {
    Text = "Ainda não despertado"
  },
  State_2682_Desc = {
    Text = "Escudo e cura têm seu efeito aumentado em 50%"
  },
  State_2682_Name = {
    Text = "Guardião do Jardim Alienado"
  },
  State_2682_WeaponDesc = {
    Text = "Escudo e cura têm seu efeito aumentado em 50%"
  },
  State_2683_Desc = {
    Text = "Comprar cartas de camadas de estado"
  },
  State_2683_Name = {
    Text = "Comprar carta"
  },
  State_2684_Desc = {
    Text = "Equipe única: O \"golpe\" do portador tem <WeaponEffect_Num:[StateArg1]%> de probabilidade de ganhar 1 aritmética e causar 10% de <IntoxicationIconKeywords:veneno> em todos os inimigos. Se o reino atual for \"aequor\", esse efeito faz com que 1 tentáculo ataque uma vez ao ser acionado. Este efeito só pode ser ativado uma vez por turno."
  },
  State_2684_WeaponDesc = {
    Text = "O \"Golpe\" do portador tem <WeaponEffect_Num:[StateArg1]%> de chance de ganhar 1 aritmética e causar [DescArg1]% de <IntoxicationIconKeywords:veneno> em todos os inimigos. Se o reino atual for \"Aequor\", esse efeito faz com que 1 tentáculo ataque uma vez ao ser acionado. Este efeito pode ser ativado no máximo 1 vez por turno."
  },
  State_2685_Desc = {
    Text = "Imunidade a estado de fraqueza, fragilidade e vulnerável, remove 1 camada no final do turno"
  },
  State_2685_Name = {
    Text = "<BlessingIconKeywords: Bênção>"
  },
  State_2685_WeaponDesc = {
    Text = "Neste turno, imune a estados negativos"
  },
  State_2686_Desc = {
    Text = "Cartões temporários fornecidos durante a batalha"
  },
  State_2686_Name = {
    Text = "<CardKeyWord: Carta de Estado>"
  },
  State_2687_Desc = {
    Text = "Neste turno, a taxa crítica aumenta 100%"
  },
  State_2687_Name = {
    Text = "Temporariamente garantido para explodir"
  },
  State_2687_WeaponDesc = {
    Text = "Neste turno, a taxa crítica aumenta 100%"
  },
  State_2688_Desc = {
    Text = "Após jogar a terceira carta de cada rodada, coloque 1 \"inspiração\" no monte de descarte. Após jogar a sexta carta de cada rodada, mova 1 \"inspiração\" do monte de descarte para a mão"
  },
  State_2689_Desc = {
    Text = "No início do turno, compre 2 cartas. Aumente a capacidade do slot dimensional em 2"
  },
  State_2689_Name = {
    Text = "Chapéu do Ilusionista da Criação"
  },
  State_2689_WeaponDesc = {
    Text = "No início do turno, compre 2 cartas. Aumente a capacidade do slot dimensional em 2"
  },
  State_2690_Desc = {
    Text = "Quando o Cavaleiro da Virtude joga o cartão, ganha [StateArg1] pontos de poder"
  },
  State_2690_Name = {
    Text = "Ardor Cavaleiro"
  },
  State_2691_Desc = {
    Text = "Equipe Única: Após o portador liberar a Fúria Explosiva, ganha <WeaponEffect_Num:[StateArg1]> pontos de Fúria e <WeaponEffect_Num:[StateArg2]> pontos de Energia da Chave de Prata, repetindo 1 vez a cada 4 cartas na mão. Se o domínio atual for \"Ultra\", as cartas do portador entram no Espaço Hiperdimensional e ganham uma força temporária equivalente a <WeaponEffect_Num:[StateArg3]%> da força de ataque do portador, podendo ser ativada no máximo 2 vezes por turno."
  },
  State_2691_WeaponDesc = {
    Text = "Após o portador liberar a Fúria Explosiva, ganha <WeaponEffect_Num:[StateArg1]> pontos de Fúria e <WeaponEffect_Num:[StateArg2]> pontos de Energia da Chave de Prata, repetindo 1 vez a cada 4 cartas na mão. Se o domínio atual for \"Ultra\", após as cartas do portador entrarem no Espaço Hiperdimensional, ganha <WeaponEffect_Num:[Power:DescArg1]> pontos de Força Temporária, podendo ser ativado no máximo 2 vezes por turno."
  },
  State_2693_Desc = {
    Text = "Estado@prologoLoucura0_1_2Efeito"
  },
  State_2693_Name = {
    Text = "Estado@prologoLoucura0_1_2Efeito"
  },
  State_2693_WeaponDesc = {
    Text = "Estado@prologoLoucura0_1_2Efeito"
  },
  State_2694_Desc = {
    Text = "A cada sigilo negro consumido, todos os despertadores ganham 1 aliemus"
  },
  State_2694_Name = {
    Text = "Estado da Flor Inversa da Criação"
  },
  State_2694_WeaponDesc = {
    Text = "A cada sigilo negro consumido, todos os despertadores ganham 1 aliemus"
  },
  State_2695_Desc = {
    Text = "Sempre que uma carta de Despertado entra no espaço dimensional, o Despertado correspondente ganha 15 loucura"
  },
  State_2696_Desc = {
    Text = "Estado@prologoLoucura0_1_2Ativada"
  },
  State_2696_Name = {
    Text = "Estado@prologoLoucura0_1_2Ativada"
  },
  State_2696_WeaponDesc = {
    Text = "Estado@prologoLoucura0_1_2Ativada"
  },
  State_2698_Name = {
    Text = "Ganhe +1 de Poder de cálculo no início do próximo turno"
  },
  State_2699_Name = {
    Text = "Ganhe +2 de Poder de cálculo no início do próximo turno"
  },
  State_2701_Desc = {
    Text = "Quando a donzela do profundo mar ganha um escudo, aumenta [StateArg1] o dano temporário de tentáculo"
  },
  State_2701_Name = {Text = "Criatura"},
  State_2701_WeaponDesc = {
    Text = "Quando a donzela do profundo mar ganha um escudo, aumenta [StateArg1] o dano temporário de tentáculo"
  },
  State_2702_Desc = {
    Text = "Ao pegar, ganha 100% de resistência à morte. Após ativar a resistência à morte, recupera [Arg1] de vida no início de cada turno nesta batalha"
  },
  State_2702_Name = {
    Text = "Sopro de vida"
  },
  State_2703_Desc = {
    Text = "A primeira carta de Despertado jogada em cada turno tem uma cópia temporária enviada à Fenda Dimensional, podendo ser usada para proteção em momentos de perigo!"
  },
  State_2703_Name = {
    Text = "Fissura Dimensional"
  },
  State_2705_Name = {
    Text = "Declaração de vingança"
  },
  State_2706_Desc = {
    Text = "Detecção de petrificação gradual"
  },
  State_2706_Name = {
    Text = "Detecção de petrificação gradual"
  },
  State_2706_WeaponDesc = {
    Text = "Detecção de petrificação gradual"
  },
  State_2707_Desc = {
    Text = "Neste turno, ataque dos tentáculos atinge todos os inimigos"
  },
  State_2707_Name = {
    Text = "Ataque Total de Tentáculos"
  },
  State_2707_WeaponDesc = {
    Text = "Neste turno, ataque dos tentáculos atinge todos os inimigos"
  },
  State_2708_Desc = {
    Text = "Limite de tentáculo aumentado em 1. Quando a vida está abaixo de 50%, o dano do tentáculo aumenta em [StateArg1] pontos"
  },
  State_2708_Name = {
    Text = "Tributo do Passado Alienado"
  },
  State_2708_WeaponDesc = {
    Text = "Limite de tentáculo aumentado em 1. Quando a vida está abaixo de 50%, o dano do tentáculo aumenta em [StateArg1] pontos"
  },
  State_2709_Desc = {
    Text = "Contagem da Faca Enferrujada da Criação"
  },
  State_2710_Desc = {Text = "Marca"},
  State_2710_Name = {Text = "Marca"},
  State_2710_WeaponDesc = {Text = "Marca"},
  State_2711_Desc = {
    Text = "Alterar temporariamente o poder de cálculo da carta"
  },
  State_2711_Name = {
    Text = "Alterar temporariamente o poder de cálculo da carta"
  },
  State_2711_WeaponDesc = {
    Text = "Alterar temporariamente o poder de cálculo da carta"
  },
  State_2712_Desc = {
    Text = "Aumentar o escudo gerado"
  },
  State_2712_Name = {
    Text = "<AlertIconKeywords: Alerta>"
  },
  State_2712_WeaponDesc = {
    Text = "Escudo obtido aumentado"
  },
  State_2713_Desc = {
    Text = "A Grande Lâmina da Vingança ganha força a cada turno"
  },
  State_2713_Name = {
    Text = "Despertar da Lâmina de Vingança"
  },
  State_2713_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_2715_Desc = {
    Text = "Escudo aumentado em [Layer] pontos nesta fase"
  },
  State_2715_Name = {
    Text = "Vigilância permanente"
  },
  State_2715_WeaponDesc = {
    Text = "Escudo aumentado em [Layer] pontos nesta fase"
  },
  State_2718_Desc = {
    Text = "Único na equipe: ao final do turno, o equipador ganha <WeaponEffect_Num:[StateArg1]> pontos de aliemus e um número equivalente de s-energia do equipador"
  },
  State_2718_WeaponDesc = {
    Text = "No final do turno, o portador ganha <WeaponEffect_Num:[StateArg1]> de loucura, ganhando a energia da chave de prata equivalente à recarga do portador"
  },
  State_2720_Desc = {
    Text = "Ao causar dano real, reduz a loucura do despertar mais alto em 10"
  },
  State_2720_Name = {Text = "Nada"},
  State_2720_WeaponDesc = {
    Text = "Ao causar dano real, reduz a loucura do despertar mais alto em 10"
  },
  State_2721_Name = {
    Text = "Estado@fase2_9batalha5bolha1"
  },
  State_2722_Desc = {
    Text = "Após jogar, coloque [StateArg1] cartas de \"inspiração\" de volta no baralho de puxar. \"Inspiração\": ganha 1 de aritmética, puxe 1 carta, reservar, consumir"
  },
  State_2722_Name = {
    Text = "<Rune_17_High:Inspiração Avançada>"
  },
  State_2723_Desc = {
    Text = "Após jogar, todos os inimigos se tornam vulneráveis [StateArg1] turno"
  },
  State_2723_Name = {
    Text = "<Rune_1_High:vulnerabilidade avançada>"
  },
  State_2724_Desc = {
    Text = "Ataques aumentam em 1"
  },
  State_2724_Name = {
    Text = "Contra-ataque do núcleo dos sonhos"
  },
  State_2726_Desc = {
    Text = "Após jogar, aplique [StateArg1] camadas de intoxicação a todos os inimigos, fazendo com que todos os inimigos acionem [StateArg2]% de intoxicação"
  },
  State_2726_Name = {
    Text = "<Rune_10_High:Veneno Avançado>"
  },
  State_2727_Desc = {
    Text = "Ao morrer, recupere 1 vida e remova este estado"
  },
  State_2727_Name = {Text = "Racine"},
  State_2727_WeaponDesc = {
    Text = "Ao morrer, recupere 1 vida e remova este estado"
  },
  State_2728_Desc = {
    Text = "No início do turno, ganhe 1 camada de <ParcloseIconKeywords:barreira> por cada aliado"
  },
  State_2728_Name = {
    Text = "Barreira de Link"
  },
  State_2728_WeaponDesc = {
    Text = "Ao iniciar a rodada, ganhe um escudo equivalente a [Layer]% da saúde máxima para cada aliado"
  },
  State_2729_Desc = {
    Text = "Ao acionar, compre uma carta correspondente ao corpo"
  },
  State_2729_Name = {
    Text = "Dobrador Espacial Mutante, compra de cartas"
  },
  State_2729_WeaponDesc = {
    Text = "Ao acionar, compre uma carta correspondente ao corpo"
  },
  State_2730_Desc = {
    Text = "Ao morrer, a Hidra perde 1 camada do estado \"Mestre das Serpentes\""
  },
  State_2730_Name = {Text = "Familier"},
  State_2732_Desc = {
    Text = "Estado@prologoLoucuraInicial0_2_3"
  },
  State_2732_Name = {
    Text = "Estado@prologoLoucuraInicial0_2_3"
  },
  State_2732_WeaponDesc = {
    Text = "Estado@prologoLoucuraInicial0_2_3"
  },
  State_2734_Name = {
    Text = "No início do próximo turno, compre +1 carta"
  },
  State_2735_Desc = {
    Text = "Se esta carta ativar \"Lançadeira Dimensional\" após ser jogada ou estiver atualmente em um Turno Ultra, ativa o efeito subsequente."
  },
  State_2735_Name = {
    Text = "<TransitionIconKeywords: Salto>"
  },
  State_2735_WeaponDesc = {
    Text = "Se estiver na rodada ultra, pode ativar o efeito de salto"
  },
  State_2737_Desc = {
    Text = "Quando o baralho da equipe for redefinido, ganhe [Layer] de força"
  },
  State_2737_Name = {
    Text = "Sempre congelado"
  },
  State_2738_Name = {
    Text = "Efeito de Fraqueza Aumentado"
  },
  State_2740_Desc = {
    Text = "As cartas copiadas e seu custo de aritmética na \"escultura inacabada\" diminuem em 1, enquanto se ganha uma carta de sintoma"
  },
  State_2740_Name = {
    Text = "Estado@Capítulo2_Resonância5_2"
  },
  State_2740_WeaponDesc = {
    Text = "As cartas copiadas na \"escultura de cera inacabada\" e seu corpo têm o custo de aritmética reduzido em 1"
  },
  State_2741_Desc = {
    Text = "As cartas copiadas e seu custo de aritmética na \"escultura inacabada\" diminuem em 1, enquanto se ganha uma carta de sintoma"
  },
  State_2741_Name = {
    Text = "Estado@Capítulo2_Resonância5_1"
  },
  State_2741_WeaponDesc = {
    Text = "As cartas copiadas na \"escultura de cera inacabada\" e seu corpo têm o custo de aritmética reduzido em 1"
  },
  State_2742_Desc = {
    Text = "Cada vez que o TikTok causa dano, ganha [StateArg2] de poder temporário, e cada vez que ganha um escudo, ganha [StateArg3] de alerta temporário"
  },
  State_2742_Name = {
    Text = "Ajuste de parâmetros"
  },
  State_2744_Desc = {
    Text = "Sempre que uma carta de Despertado entra no espaço dimensional, ganha 15 loucura"
  },
  State_2744_Name = {
    Text = "Relíquia dispositivo de salto"
  },
  State_2744_WeaponDesc = {
    Text = "Sempre que uma carta de Despertado entra no espaço dimensional, ganha 15 loucura"
  },
  State_2746_Desc = {
    Text = "Ataques +1, perde [Layer] de força"
  },
  State_2746_Name = {Text = "Impaciente"},
  State_2747_Desc = {
    Text = "Jogue para dar aos outros Despertados [StateArg1] Loucura"
  },
  State_2747_Name = {
    Text = "<Rune_16:Catalisar>"
  },
  State_2748_Desc = {
    Text = "Estado@ritualDaLanterna"
  },
  State_2748_Name = {
    Text = "Estado@ritualDaLanterna"
  },
  State_2748_WeaponDesc = {
    Text = "Estado@ritualDaLanterna"
  },
  State_2749_Desc = {
    Text = "Após causar dano de tentáculo nesta rodada, aplica [Layer] camadas de veneno ao alvo"
  },
  State_2749_Name = {
    Text = "Corrente obscura profunda"
  },
  State_2750_Desc = {
    Text = "Afunde no mar comigo"
  },
  State_2750_Name = {
    Text = "Néfia Despertar"
  },
  State_2752_Desc = {
    Text = "Quando o Lírio-d'água causa dano, ganha [StateArg2] loucura"
  },
  State_2752_Name = {
    Text = "Mar de Dor Submerso"
  },
  State_2752_WeaponDesc = {
    Text = "Quando o Lírio-d'água causa dano, ganha [StateArg2] loucura"
  },
  State_2753_Desc = {
    Text = "Ao iniciar a rodada, se a vida for maior que [Arg1], perca [Arg1] de vida, ganhando [Arg2] pontos de poder e [Arg3] pontos de alerta durante a rodada"
  },
  State_2754_Name = {
    Text = "Estado@Aumento de taxa crítica de carta de ataque temporário"
  },
  State_2757_Desc = {
    Text = "No início do próximo turno, obtém [DescArg1] pontos de Poder de cálculo adicionais."
  },
  State_2757_Name = {
    Text = "Sintoma: Desconfiança"
  },
  State_2758_Desc = {
    Text = "Todos os seus efeitos de recuperação de vida aumentam em [Arg1] pontos, e a vida excedente se transforma em escudo equivalente"
  },
  State_2758_Name = {
    Text = "Especime de borboleta"
  },
  State_2760_Desc = {
    Text = "Sempre que um Despertado realiza 1 devorar, outros Despertados ganham 10 loucura"
  },
  State_2762_Desc = {
    Text = "Após jogar, ative-se adicionalmente [StateArg1] vezes, ganhando [StateArg2] pontos de sigilo negro, exausto, inato"
  },
  State_2762_Name = {
    Text = "<Rune_7_High:Eco Avançado>"
  },
  State_2762_WeaponDesc = {
    Text = "Após jogar, ativa [StateArg1] vezes extras, consumo"
  },
  State_2763_Desc = {
    Text = "Quando o Senhor do Sono consome 1 de aritmética, aumenta o dano de tentáculo de [StateArg1]"
  },
  State_2763_Name = {
    Text = "Dignidade Imortal"
  },
  State_2763_WeaponDesc = {
    Text = "Quando o Senhor do Sono consome 1 de aritmética, aumenta o dano de tentáculo de [StateArg1]"
  },
  State_2764_Desc = {
    Text = "Ao causar dano não bloqueado, adicione [StateArg1] camadas de sangramento"
  },
  State_2764_Name = {
    Text = "Sangramento malicioso"
  },
  State_2765_Name = {
    Text = "Estado @George@ tratamento ao morrer"
  },
  State_2767_Name = {
    Text = "Estado@eficiência da chave de prata e do sigilo negro"
  },
  State_2769_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_2769_Name = {
    Text = "Ainda não despertado"
  },
  State_2771_Desc = {
    Text = "Força do Monstro"
  },
  State_2771_Name = {
    Text = "Força do Monstro"
  },
  State_2772_Name = {
    Text = "Estado@fase2_5batalha3bolha1"
  },
  State_2773_Desc = {
    Text = "No início da batalha, adicione 1 carta \"Momento Belo - Substitua todas as cartas de Despertar na mão por \"Golpe\" até o final do turno. Retenha, Consuma.\" à sua mão"
  },
  State_2775_Desc = {
    Text = "Número de cartas de retorno"
  },
  State_2775_Name = {
    Text = "Reinício da Contagem de Compras"
  },
  State_2776_Name = {
    Text = "Olho de Pedra, maldição do reforço"
  },
  State_2777_Name = {
    Text = "Estado@Capítulo3_EstadoVazio"
  },
  State_2778_Desc = {
    Text = "No início da batalha, ganhe [Arg1] de escudo. Após usar \"Defesa\" 7 vezes nesta batalha, ganhe imediatamente [Arg2] de escudo"
  },
  State_2778_Name = {
    Text = "Correio matinal de Putney"
  },
  State_2779_Desc = {
    Text = "Quando a vida estiver abaixo de 50%([StateArg1]), se dividirá em 3 corpos de vida equivalentes \"dissoluto de interferência\""
  },
  State_2779_Name = {Text = "Fissão"},
  State_2779_WeaponDesc = {
    Text = "Quando a vida estiver abaixo de 50%([StateArg1]), se dividirá em 2 corpos de vida equivalentes \"escultura de cera tipo II\""
  },
  State_2780_Desc = {
    Text = "Após jogar, ganhe [StateArg1] pontos de aritmética"
  },
  State_2780_Name = {
    Text = "<Rune_4:Planejamento>"
  },
  State_2781_Desc = {
    Text = "Sempre que jogar [Layer] cartas, se não tiver barreira, adicione uma camada de <ParcloseIconKeywords:barreira>"
  },
  State_2781_Name = {
    Text = "Barreira de carga"
  },
  State_2781_WeaponDesc = {
    Text = "Nossa equipe faz o monstro ganhar uma camada de barreira a cada [Layer] cartas jogadas"
  },
  State_2784_Desc = {
    Text = "Mesmo fora do turno extradimensional, pode ativar o efeito de salto uma vez por turno. A capacidade do espaço extradimensional aumenta em 2"
  },
  State_2785_Desc = {
    Text = "Equipe Única: Após o portador jogar uma carta, o portador ganha 1 ponto de Fúria. Ao começar a batalha, ganha uma quantidade de <PowerIconKeywords:Força> equivalente a <WeaponEffect_Num:[StateArg1]%> da força de ataque do portador. Se o domínio atual for \"Mar Profundo\", ganha adicionalmente <WeaponEffect_Num:[StateArg2]%> de <CardKeyWord:Dano de tentáculo>. No início de cada turno subsequente, ganha uma quantidade de <PowerIconKeywords:Força> equivalente a <WeaponEffect_Num:[StateArg3]%> da força de ataque do portador. Se o domínio atual for \"Mar Profundo\", ganha adicionalmente <WeaponEffect_Num:[StateArg4]%> de <CardKeyWord:Dano de tentáculo>."
  },
  State_2785_WeaponDesc = {
    Text = "Após o portador jogar uma carta, ele ganha 1 ponto de Fúria. Ao começar a batalha, ganhe <WeaponEffect_Num:[Power:DescArg1]> pontos de <PowerIconKeywords:força>. Se o domínio atual for \"Mar Profundo\", ganhe também <WeaponEffect_Num:[DescArg2]> pontos de <CardKeyWord:Dano de tentáculo>; em cada início de turno subsequente, ganhe <WeaponEffect_Num:[Power:DescArg3]> pontos de <PowerIconKeywords:força>. Se o domínio atual for \"Mar Profundo\", ganhe também <WeaponEffect_Num:[DescArg4]> pontos de <CardKeyWord:Dano de tentáculo>."
  },
  State_2786_Name = {
    Text = "Contagem do Seixo Ensanguentado da Criação"
  },
  State_2787_Desc = {
    Text = "Restaura vida, embaralha 1 [Terminação da Ilusão] no descarte. Permanente, destrói."
  },
  State_2787_Name = {
    Text = "<CardKeyWord:Busca pela Verdade>"
  },
  State_2787_WeaponDesc = {
    Text = "Restaura vida, embaralha 1 [Terminação da Ilusão] no descarte. Permanente, destrói."
  },
  State_2788_Desc = {
    Text = "No início do turno, compre [StateArg1] cartas"
  },
  State_2788_Name = {
    Text = "Lâmpada dos Desejos do Profeta da Criação 1"
  },
  State_2788_WeaponDesc = {
    Text = "No início do turno, compre [StateArg1] cartas"
  },
  State_2789_Desc = {
    Text = "A Carta foi adulterada por Jenkin! Recebe [Layer] de <FixedDamage:Dano Puro> ao ser Disparada."
  },
  State_2789_Name = {
    Text = "<CardKeyWord:Recebe [Layer] de dano após jogar>"
  },
  State_2789_WeaponDesc = {
    Text = "Após jogar a carta, sofre [StateArg1] de dano"
  },
  State_2790_Desc = {
    Text = "No fim do turno, pode manter [StateArg1] cartas na mão"
  },
  State_2790_Name = {
    Text = "Lâmpada dos Desejos do Profeta da Criação 2"
  },
  State_2790_WeaponDesc = {
    Text = "No fim do turno, pode manter [StateArg1] cartas na mão"
  },
  State_2792_Desc = {
    Text = "No início da batalha, todos os aliados ganham 3 camadas de [Armadura de Cera]. No início do turno, embaralhe uma [Convulsão] no monte de compra da nossa equipe."
  },
  State_2792_Name = {
    Text = "\"Dama de Cera\""
  },
  State_2792_WeaponDesc = {
    Text = "No início da batalha, todos os aliados ganham 3 camadas de [Armadura de Cera]. No início do turno, embaralhe uma [Convulsão] no monte de compra da nossa equipe."
  },
  State_2793_Desc = {
    Text = "Estado@OlhoDePedraLutaFinal"
  },
  State_2793_Name = {
    Text = "Estado@OlhoDePedraLutaFinal"
  },
  State_2793_WeaponDesc = {
    Text = "Estado@OlhoDePedraLutaFinal"
  },
  State_2796_Desc = {
    Text = "Sempre que perder vida, adiciona [Arg1] camadas de veneno a todos os inimigos. Aumenta o valor do veneno em [Arg2] por turno"
  },
  State_2797_Desc = {
    Text = "No início do turno, adiciona 1 cartão de \"guarda-chuva\" de alerta [Arg1] obtida neste turno à mão, após jogar 6 cartões, aumenta o alerta de todos os \"guarda-chuvas\" na mão em [Arg2]"
  },
  State_2798_Desc = {
    Text = "Quando o sacerdote amoroso aplica o escudo, ele faz com que 1 carta aleatória na mão até ser jogada tenha seu custo de aritmética reduzido em -1"
  },
  State_2798_Name = {
    Text = "A misericórdia do pai"
  },
  State_2798_WeaponDesc = {
    Text = "Quando o sacerdote amoroso aplica o escudo, ele faz com que 1 carta aleatória na mão até ser jogada tenha seu custo de aritmética reduzido em -1"
  },
  State_2799_Desc = {
    Text = "Quando a Medusa da Lua causar Dano ativo, aciona [StateArg1] Ataques de tentáculo no alvo."
  },
  State_2799_Name = {
    Text = "Auto-reprodução"
  },
  State_2799_WeaponDesc = {
    Text = "Quando a lua do mar causa dano, faz com que [StateArg1] tentáculos ataquem o alvo"
  },
  State_2800_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_2800_Name = {
    Text = "Estado@ProtótipoFacaDanoExplosivo"
  },
  State_2801_Desc = {
    Text = "Receber dano real aumenta camadas de corrosão profunda"
  },
  State_2801_Name = {
    Text = "Receber dano aumenta camadas de corrosão profunda"
  },
  State_2801_WeaponDesc = {
    Text = "Receber dano real aumenta camadas de corrosão profunda"
  },
  State_2802_Desc = {
    Text = "Aumenta a força temporária no início do turno"
  },
  State_2802_Name = {
    Text = "Aumentar força temporária"
  },
  State_2804_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_2804_Name = {
    Text = "Estado@ProtótipoCanhãoLaserDanoExplosivo"
  },
  State_2805_Desc = {
    Text = "No final do turno, outros aliados ganham Força"
  },
  State_2805_Name = {
    Text = "\"Fogo da Iluminação\""
  },
  State_2807_Desc = {
    Text = "No início do turno, adiciona 1 cartão de \"guarda-chuva\" de alerta [Arg1] obtida neste turno à mão, após jogar 6 cartões, aumenta o alerta de todos os \"guarda-chuvas\" na mão em [Arg2]"
  },
  State_2808_Desc = {
    Text = "No final do turno, gere 1 Fusão de Embrião. Se tiver um embrião na mão, recupere 15 de Vida"
  },
  State_2808_Name = {
    Text = "Anomalous Hemostat"
  },
  State_2808_WeaponDesc = {
    Text = "No final do turno, gere 1 Fusão de Embrião. Se tiver um embrião na mão, recupere 15 de Vida"
  },
  State_2809_Desc = {
    Text = "Ao pegar, perde permanentemente [Arg1] de força. Cada vez que causa dano, recupera [Arg2] de vida, até 6 vezes por turno"
  },
  State_2809_Name = {
    Text = "Beijo do Peixe-Bruxa"
  },
  State_2810_Desc = {
    Text = "Ao final da rodada, restaure [Layer]% da saúde máxima"
  },
  State_2810_Name = {
    Text = "Regeneração"
  },
  State_2810_WeaponDesc = {
    Text = "No final do turno do monstro, recupera [Layer]% da vida máxima"
  },
  State_2811_Desc = {
    Text = "Ao puxar uma carta de sintoma, ganha-se [Arg1] pontos de poder. Para cada 1 ímpeto maldito ou relíquia amaldiçoada que você possui, a taxa crítica e o dano crítico aumentam em 10%"
  },
  State_2812_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_2812_Name = {
    Text = "Ainda não despertado"
  },
  State_2813_Desc = {
    Text = "Ao iniciar a rodada, perca aritmética"
  },
  State_2813_Name = {
    Text = "Erro de cálculo!"
  },
  State_2814_Desc = {
    Text = "A marca obtida na vitória da batalha transforma-se em uma poderosa e perigosa maldição"
  },
  State_2817_Desc = {
    Text = "Cada camada reduz o dano recebido em [StateArg1], reduzindo 1 camada ao ser criticado"
  },
  State_2817_Name = {
    Text = "Armadura de cera"
  },
  State_2817_WeaponDesc = {
    Text = "Imune a estados anormais, removido após ser criticado"
  },
  State_2818_Desc = {
    Text = "Divida em Triângulo Corroído A e Triângulo Corroído B"
  },
  State_2818_Name = {Text = "Fissão"},
  State_2818_WeaponDesc = {
    Text = "Divida em Triângulo Corroído A e Triângulo Corroído B"
  },
  State_2820_Desc = {
    Text = "Após jogar, ganhe [StateArg1] pontos temporários de poder, esta carta de selo também pode se beneficiar do bônus de poder"
  },
  State_2820_Name = {
    Text = "<Rune_15:Explosão>"
  },
  State_2821_Name = {
    Text = "Imunidade Temporária a Vulnerabilidade"
  },
  State_2823_Desc = {
    Text = "Equipe Única: Ao início do combate, aplica 2 camadas de <VulnerabilityIconKeywords:Vulnerável> aos inimigos da linha da frente. Ao início do turno, inimigos em estado Vulnerável perdem <WeaponEffect_Num:[StateArg1]%> da Força de ataque do Portador em <PowerIconKeywords:Força> Temporária. Se o Domínio atual for \"Carne\", após o Portador liberar \"Fúria Explosiva\", Fusão de embriões +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2823_WeaponDesc = {
    Text = "Ao início do combate, aplica 2 camadas de <VulnerabilityIconKeywords:Vulnerável> aos inimigos da linha da frente. Ao início do turno, inimigos em estado Vulnerável perdem <WeaponEffect_Num:[Power:DescArg1]> pontos de <PowerIconKeywords:Força> Temporária. Se o Domínio atual for \"Carne\", após o Portador liberar \"Fúria Explosiva\", Fusão de embriões +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2825_Desc = {
    Text = "Limite de Slot de Carta Ultra Monstro"
  },
  State_2825_Name = {
    Text = "Limite de Slot de Carta Ultra Monstro"
  },
  State_2825_WeaponDesc = {
    Text = "Limite de Slot de Carta Ultra Monstro"
  },
  State_2826_Desc = {
    Text = "Ao ativar 2 cartas consecutivamente com um custo de aritmética menor do que a carta anterior, o despertador com a menor loucura atual ganha 50 de loucura"
  },
  State_2826_Name = {
    Text = "Relíquia Arcana da Criação"
  },
  State_2827_Desc = {
    Text = "Número de Dano e Aumento de Dano"
  },
  State_2827_Name = {
    Text = "<CardKeyWord:Upgrade>"
  },
  State_2829_Desc = {
    Text = "Ao causar dano real, ganha [Layer] de força"
  },
  State_2829_Name = {
    Text = "\"Personalidade Confusa\""
  },
  State_2830_Desc = {
    Text = "Para cada Despertador da classe [Aequor] na equipe, a Saúde Máxima de toda a equipe (não finalizada), Defesa e Ataque aumentam em 50%"
  },
  State_2830_Name = {
    Text = "Bônus das profundezas"
  },
  State_2830_WeaponDesc = {
    Text = "Para cada Despertador da classe [Aequor] na equipe, a Saúde Máxima de toda a equipe (não finalizada), Defesa e Ataque aumentam em 50%"
  },
  State_2832_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_2832_Name = {
    Text = "Estado@ProtótipoCanhãoLaserResistência"
  },
  State_2833_Desc = {
    Text = "Ao iniciar a rodada, compre 1 carta. Sempre que você comprar uma carta, altere aleatoriamente seu custo de aritmética (0-4)"
  },
  State_2835_Desc = {
    Text = "A cada devoração, rouba [Arg1] de força temporária de todos os inimigos"
  },
  State_2836_Name = {
    Text = "Estado@MaldiçãoConformidade"
  },
  State_2837_Name = {
    Text = "Estado@MaldiçãoConformidade"
  },
  State_2838_Name = {
    Text = "Estado@MaldiçãoConformidade"
  },
  State_2840_Desc = {
    Text = "Recebe [Layer] <FixedDamage:Dano Puro> e remove [DescArg1]% das capas ao fim do turno. Ao restaurar Vida, remove o dobro de capas de Sangramento em relação à quantidade curada."
  },
  State_2840_Name = {
    Text = "<BleedingColour:sangrando>"
  },
  State_2840_WeaponDesc = {
    Text = "Após o final do turno, recebe [Layer] de dano e remove esse estado, cada cura pode reduzir as camadas pela metade"
  },
  State_2842_Desc = {
    Text = "Ao Disparar, ganhe [StateArg1] de <RetaliateIconKeywords:Contrataque>, em seguida cause Dano Real a todos os inimigos igual a [StateArg2]% do seu <RetaliateIconKeywords:Contrataque>"
  },
  State_2842_Name = {
    Text = "<Rune_9:Espinho>"
  },
  State_2843_Desc = {
    Text = "Nossa equipe ganha [StateArg1] camadas de escudo a cada carta jogada. Dura 1 turno"
  },
  State_2843_Name = {
    Text = "Plumas voando pelo céu"
  },
  State_2843_WeaponDesc = {
    Text = "Nossa equipe ganha [StateArg1] camadas de escudo a cada carta jogada. Dura 1 turno"
  },
  State_2844_Desc = {
    Text = "Ao perder vida pela 1ª vez na batalha, ganhe 1 barreira que bloqueia um dano"
  },
  State_2845_Name = {
    Text = "Sussurros do Cemitério dos Acessórios"
  },
  State_2845_WeaponDesc = {
    Text = "No início da fase, resistência à morte aumenta em 25%. Após ativar a resistência à morte, o portador ganha 50 pontos de loucura"
  },
  State_2846_Desc = {
    Text = "Imune a uma morte, recupera [Arg1] vida após ativar e falha permanentemente"
  },
  State_2846_Name = {
    Text = "Boneca substituta"
  },
  State_2847_Desc = {
    Text = "Cada vez que um despertador ao caçador usa um cartão, acumula 1 camada de marca de caça e puxa metade das camadas de marca de caça em cartões"
  },
  State_2847_Name = {
    Text = "Ritual de caça"
  },
  State_2849_Desc = {
    Text = "Sempre que perder vida, ganha [Arg1] pontos de força, máximo de 10 camadas. Ao atingir o máximo, recupera 25% da vida perdida"
  },
  State_2849_Name = {
    Text = "Honra Suprema"
  },
  State_2853_Desc = {
    Text = "Contagem da Cadeira de Descanso da Criação"
  },
  State_2854_Desc = {
    Text = "Após a morte, não fornece loucura para o despertar"
  },
  State_2854_Name = {Text = "egoísta"},
  State_2854_WeaponDesc = {
    Text = "Após a morte, não fornece loucura para o despertar"
  },
  State_2855_Desc = {
    Text = "Dano da carta de golpe aumentado em [StateArg1]%, dura [Layer] turnos."
  },
  State_2855_Name = {
    Text = "Sobrevivência em situação desesperadora·Golpear"
  },
  State_2855_WeaponDesc = {
    Text = "Neste turno, dano das cartas de golpe aumenta [Layer]%"
  },
  State_2856_Desc = {
    Text = "Equipe Única: O escudo causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1] %>, e ao causar escudo, todos os aliados recebem <WeaponEffect_Num:[StateArg3] %> de Taxa de Crítico Temporária e <WeaponEffect_Num:[StateArg4]> de Energia da Chave de Prata do portador, podendo ser aplicado até 2 vezes por turno. Se o Domínio atual for \"Mar Profundo\", cada vez que 1 tentáculo atacar, o portador ganha 1 ponto de Fúria, podendo ganhar até <WeaponEffect_Num:[StateArg2]> pontos por turno."
  },
  State_2856_WeaponDesc = {
    Text = "O escudo causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]％>, e ao causar escudo, todos os aliados ganham <WeaponEffect_Num:[StateArg3]％> de Taxa de Crítico Temporária e <WeaponEffect_Num:[StateArg4]%> de Energia da Chave de Prata do portador, podendo ser ativado no máximo 2 vezes por turno. Se o domínio atual for \"Mar Profundo\", cada vez que 1 tentáculo atacar, o portador ganha 1 ponto de Fúria, podendo ganhar no máximo <WeaponEffect_Num:[StateArg2]> pontos por turno."
  },
  State_2857_Desc = {
    Text = "No início de cada rodada, todos os despertadores ganham 10 loucura. A saúde máxima diminui em 50%"
  },
  State_2858_Name = {
    Text = "Ao jogar, ganhe duas camadas extras de barreira"
  },
  State_2859_Desc = {
    Text = "No início da batalha, esta carta fica fixa na mão"
  },
  State_2859_Name = {
    Text = "<CardKeyWord:Inerente>"
  },
  State_2860_Desc = {
    Text = "Ao comprá-lo, reduza sua saúde máxima em 10%. Após o uso, todos os despertadores terão seu dano crítico aumentado em 100% nesta rodada. Não pode ser vendido"
  },
  State_2860_Name = {
    Text = "EstadoMaldiçãoCorrosão"
  },
  State_2860_WeaponDesc = {
    Text = "Ao comprá-lo, reduza sua saúde máxima em 10%. Após o uso, todos os despertadores terão seu dano crítico aumentado em 100% nesta rodada. Não pode ser vendido"
  },
  State_2861_Name = {
    Text = "(Restante:[Layer])"
  },
  State_2862_Desc = {
    Text = "No final do turno, recebe um dano de veneno adicional"
  },
  State_2862_Name = {
    Text = "Fraqueza constitucional"
  },
  State_2863_Desc = {
    Text = "Número de níveis de evolução"
  },
  State_2863_Name = {
    Text = "Número de níveis de evolução"
  },
  State_2863_WeaponDesc = {
    Text = "Número de níveis de evolução"
  },
  State_2864_Desc = {
    Text = "\"24\" já despertou, use o último \"me salve\" para encontrar uma oportunidade!"
  },
  State_2864_Name = {
    Text = "\"24\" Despertar!"
  },
  State_2864_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_2866_Desc = {
    Text = "Equipe Única: Limite de cartas na mão +2. Ao final do turno, ganhe Energia de chave equivalente a <WeaponEffect_Num:[StateArg1]%> da Recarregar Chave de Prata do portador. Após cada Ordem de chave ser Liberada, todos os Corpos Despertos ganham <WeaponEffect_Num:[StateArg2]> pontos de Fúria. Se o domínio atual for \"Carne e sangue\", também aumentará a Fusão de embriões em <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_2866_WeaponDesc = {
    Text = "Limite de cartas na mão +2. Ao fim da rodada, obtém <WeaponEffect_Num:[DescArg1]> pontos de Energia da Chave de Prata. Após cada Ordem de chave liberada, todos os Corpos Despertos obtêm <WeaponEffect_Num:[StateArg2]> pontos de Fúria. Se o Domínio atual for \"Carne e sangue\", também realiza Fusão de embriões <WeaponEffect_Num:+[Blood:StateArg3]> ."
  },
  State_2868_Desc = {
    Text = "No final do turno, para cada cartão não jogado na mão, todos os despertadores ganham 2 de loucura"
  },
  State_2871_Desc = {
    Text = "Vida abaixo de 50%([StateArg1]), invoca um \"Triângulo Corrosivo\" com vida equivalente"
  },
  State_2871_Name = {
    Text = "Invocação"
  },
  State_2871_WeaponDesc = {
    Text = "Vida abaixo de 50%([StateArg1]), invoca um \"Triângulo Corrosivo\" com vida equivalente"
  },
  State_2874_Desc = {
    Text = "O corpo desperto está sendo observado pelo Caçador de Crânios, usar suas cartas permitirá comprar 2 cartas adicionais."
  },
  State_2875_Desc = {
    Text = "Ao Disparar, <EmbryoFusionIconKeywords:Fusão de embriões> +[StateArg1]."
  },
  State_2875_Name = {
    Text = "<Rune_12_High:Sede de Sangue Avançada>"
  },
  State_2875_WeaponDesc = {
    Text = "Ao disparar, Fusão de embriões+ [Blood:StateArg1]."
  },
  State_2876_Desc = {
    Text = "Ao final da batalha, ganha adicionalmente 50 selos negros e 1 carta de sintoma"
  },
  State_2877_Desc = {
    Text = "Cada vez que a Dama Vermelha causa dano, ela ganha [StateArg2] de força temporária"
  },
  State_2877_Name = {
    Text = "Privilégio de boas-vindas"
  },
  State_2878_Desc = {
    Text = "Número de Dano +1, mas Dano reduzido em 25%"
  },
  State_2878_Name = {Text = "Frenesi"},
  State_2878_WeaponDesc = {
    Text = "Número de Dano +1, mas Dano reduzido em 25%"
  },
  State_2879_Name = {Text = "Slime Doce"},
  State_2879_WeaponDesc = {
    Text = "Após usar \"Aniquilação\", se estiver na postura \"Mar Calmo\" nesta rodada, o portador terá um aumento de 30% nos efeitos de escudo e cura nesta rodada."
  },
  State_2880_Name = {
    Text = "Estado@apóstolo do mar iluminar 7"
  },
  State_2881_Desc = {
    Text = "Sempre que uma carta \"Sagrado\" é convertida em \"Ilusão\", o dano base causado por Miryam neste combate aumenta em 15%"
  },
  State_2881_Name = {
    Text = "Ilusão desvanecida"
  },
  State_2883_Desc = {
    Text = "Equipe Única: Após o Portador causar Dano ativo, há <WeaponEffect_Num:[StateArg1]%> de chance de Comprar carta 1 de suas Cartas de comando e reduzir seu Consumo de potência de cálculo em 1. Este efeito é ativado apenas uma vez por turno."
  },
  State_2883_WeaponDesc = {
    Text = "Após o Portador causar Dano ativo, há <WeaponEffect_Num:[StateArg1]%> de chance de Comprar carta 1 de suas Cartas de comando e reduzir seu Consumo de potência de cálculo em 1. Este efeito é ativado apenas uma vez por turno."
  },
  State_2884_Name = {
    Text = "O dano causado é de <PunctureDamagewords:danos de perfuração>. Reduz em 1 o custo de aritmética da carta com maior aritmética em sua mão"
  },
  State_2885_Name = {
    Text = "Estado@inicioDoTurnoAdicionar2Cartas"
  },
  State_2887_Desc = {
    Text = "Equipe única: Após o portador liberar o exaltar, o dano crítico do portador neste turno aumenta em <WeaponEffect_Num:[StateArg1]%> e todas as cartas dos portadores têm uma probabilidade de <WeaponEffect_Num:[StateArg2]%> de reduzir o consumo de aritmética em 1 ponto neste turno"
  },
  State_2887_WeaponDesc = {
    Text = "Após o portador liberar a exaltação, o dano crítico do portador neste turno aumenta em <WeaponEffect_Num:[StateArg1]>, e todas as cartas do portador têm <WeaponEffect_Num:[StateArg2]%> de chance de reduzir o consumo de aritmética em 1 ponto neste turno"
  },
  State_2888_Desc = {
    Text = "Se houver um \"Embrião\" em sua mão, exaustar 1 para ativar efeitos subsequentes."
  },
  State_2888_Name = {
    Text = "<DevouredIconKeywords:Devorado>"
  },
  State_2888_WeaponDesc = {
    Text = "Descarte o embrião da mão para ativar um poderoso efeito devorador"
  },
  State_2889_Name = {
    Text = "Escolha um Despertado para ganhar <Energy:[DescArg1]> de Loucura"
  },
  State_2890_Desc = {
    Text = "No início da batalha, cause 1 camada de fragilidade à equipe"
  },
  State_2890_Name = {
    Text = "Penetrar Armadura"
  },
  State_2890_WeaponDesc = {
    Text = "No início da batalha, cause 1 camada de fragilidade à equipe"
  },
  State_2891_Name = {
    Text = "Aumento de Responder de Abertura de Fúria"
  },
  State_2892_Desc = {
    Text = "No fim do turno, recupera [Layer] pontos de vida."
  },
  State_2892_Name = {
    Text = "Recuperação de Vida Atrasada"
  },
  State_2892_WeaponDesc = {
    Text = "Até o fim do turno, cada vez que matar, recupera [Layer] pontos de vida"
  },
  State_2897_Desc = {
    Text = "Ao liberar a chegada do gênesis, diminua o poder temporário dos inimigos"
  },
  State_2897_Name = {
    Text = "Temor da loucura"
  },
  State_2899_Desc = {
    Text = "Se o oponente tiver 4 ou mais cartas na mão, ao receber dano, ganha [StateArg1] pontos de escudo"
  },
  State_2899_Name = {Text = "Serpente"},
  State_2900_Desc = {
    Text = "Dano aumentado em [Layer] nesta batalha"
  },
  State_2900_Name = {Text = "Força"},
  State_2900_WeaponDesc = {
    Text = "Dano aumentado em [Layer] nesta batalha"
  },
  State_2901_Desc = {
    Text = "[exaltar] concede 20 pontos de loucura a si mesmo"
  },
  State_2901_Name = {
    Text = "Véu do Deus Sem Nome da Criação"
  },
  State_2901_WeaponDesc = {
    Text = "[exaltar] concede 20 pontos de loucura a si mesmo"
  },
  State_2902_Desc = {
    Text = "Cérebro em um frasco restaura a vida em dobro"
  },
  State_2902_Name = {
    Text = "Separação da mente e do corpo"
  },
  State_2902_WeaponDesc = {
    Text = "Cérebro em um frasco restaura a vida em dobro"
  },
  State_2903_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_2903_Name = {
    Text = "Estado@ProtótipoFacaCrítico"
  },
  State_2904_Desc = {
    Text = "Ao receber dano real, ganha 10 pontos de escudo"
  },
  State_2904_Name = {Text = "buffer"},
  State_2904_WeaponDesc = {
    Text = "Ao receber dano real, ganha 10 pontos de escudo"
  },
  State_2905_Desc = {
    Text = "Equipe Única: O escudo causado pela \"Fúria Explosiva\" do portador aumenta em <WeaponEffect_Num:[StateArg2] %>. Após o portador liberar a \"Fúria Explosiva\", ganha <WeaponEffect_Num:[StateArg1]%> camadas de <PowerIconKeywords:força> temporária equivalente à defesa do portador. Se nossa equipe estiver em estado <FragileIconKeywords:frágil>, o efeito dobra."
  },
  State_2905_WeaponDesc = {
    Text = "O escudo causado pela exaltação do equipador aumenta em <WeaponEffect_Num:[StateArg2] %>. Após liberar o estado de exaltar, o equipador ganha [Power:DescArg1] pontos temporários de <PowerIconKeywords:poder>. Se nossa equipe estiver em estado <FragileIconKeywords:frágil>, o efeito dobra"
  },
  State_2906_Desc = {
    Text = "Ao causar dano real, reduz temporariamente a força da equipe em [Layer]"
  },
  State_2906_Name = {
    Text = "Paralisia elétrica"
  },
  State_2909_Desc = {
    Text = "Possui [Layer] pontos de loucura. Se a loucura for maior ou igual a 5, a intenção muda para \"festa dos mortos retorcidos\", e a loucura se recupera após a diminuição"
  },
  State_2909_Name = {
    Text = "Estado@monstro 24 festa dos mortos retorcidos contagem"
  },
  State_2909_WeaponDesc = {
    Text = "Possui [Layer] pontos de loucura. Se a loucura for maior ou igual a 5, a intenção muda para \"festa dos mortos retorcidos\", e a loucura se recupera após a diminuição"
  },
  State_2910_Desc = {
    Text = "Equipe Única: No início da exploração, adicione uma carta \"Inspiração\" e \"Golpe\" do portador ao baralho. O dano básico do \"Golpe\" do portador aumenta em <WeaponEffect_Num:[StateArg1]%> e, ao usá-lo, há <WeaponEffect_Num:[StateArg2]%> de chance de comprar 1 carta. Este efeito pode ser ativado até 1 vez por turno. Se o domínio atual for \"Ultra\" e estiver em um Turno Ultra, \"Golpe\" coloca 1 carta \"Inspiração\" na mão, podendo ser ativado até 1 vez por turno."
  },
  State_2910_WeaponDesc = {
    Text = "No início da exploração, adicione uma carta \"Inspiração\" e uma carta \"Golpe\" do portador ao baralho, aumentando o dano base de \"Golpe\" do portador em <WeaponEffect_Num:[StateArg1]%>. Após disparar, há <WeaponEffect_Num:[StateArg2]%> de chance de comprar 1 carta. Este efeito pode ser ativado no máximo 1 vez por turno. Se o domínio atual for \"Ultra\" e estiver no turno ultra, \"Golpe\" coloca 1 \"Inspiração\" na mão, podendo ser ativado no máximo 1 vez por turno."
  },
  State_2911_Desc = {
    Text = "Estado@ContagemDeMundoImaginárioBrancoModificado"
  },
  State_2911_Name = {
    Text = "Estado@ContagemDeMundoImaginárioBranco"
  },
  State_2911_WeaponDesc = {
    Text = "Estado@ContagemDeMundoImaginárioBrancoModificado"
  },
  State_2912_Desc = {
    Text = "Você está marcado! Após atacar, os guardas do marinheiro ganham [StateArg1] pontos de poder temporário, removendo a marca de profundidade desse comando"
  },
  State_2912_Name = {
    Text = "<CardKeyWord:Marca do Mergulho>"
  },
  State_2912_WeaponDesc = {
    Text = "Após jogar a carta, os guardas do profundo recebem [StateArg1] de poder temporário"
  },
  State_2913_Desc = {
    Text = "No início da batalha, vulnerabilidade por 3 turnos"
  },
  State_2913_Name = {
    Text = "Garra Estranha da Criação 2"
  },
  State_2913_WeaponDesc = {
    Text = "No início da batalha, vulnerabilidade por 3 turnos"
  },
  State_2914_Desc = {
    Text = "Vida abaixo de 50%, intenção muda para invocar um \"Triângulo Corrosivo\" com vida equivalente"
  },
  State_2914_Name = {Text = "Fissão"},
  State_2914_WeaponDesc = {
    Text = "Vida abaixo de 50%, intenção muda para invocar um \"Triângulo Corrosivo\" com vida equivalente"
  },
  State_2915_Desc = {
    Text = "Aumenta o número de danos de \"corrente de ressentimento\" em +[Layer]"
  },
  State_2915_Name = {Text = "ódio"},
  State_2915_WeaponDesc = {
    Text = "Aumenta o número de danos de \"corrente de ressentimento\" em +[Layer]"
  },
  State_2917_Desc = {
    Text = "Ao final da rodada, a cada 1 carta na mão, ganhe 1 ponto de poder ao iniciar a próxima rodada"
  },
  State_2917_Name = {
    Text = "Estado@chaveDePrataSonho:calculo"
  },
  State_2918_Desc = {
    Text = "Dano recebido reduzido em 99%. Após dano ativo, remove 1 camada, restaurado para 3 camadas no início do turno"
  },
  State_2918_Name = {
    Text = "\"Restos Imortais\""
  },
  State_2918_WeaponDesc = {
    Text = "Dano recebido reduzido em 99%. Após dano ativo, remove 1 camada, restaurado para 3 camadas no início do turno"
  },
  State_2919_Desc = {
    Text = "Estado@ImagemDeEsmeraldaAdiantada"
  },
  State_2919_Name = {
    Text = "Estado@ImagemDeEsmeraldaAdiantada"
  },
  State_2919_WeaponDesc = {
    Text = "Estado@ImagemDeEsmeraldaAdiantada"
  },
  State_2922_Desc = {
    Text = "A cada vez que consumir 1 ponto de poder, o correspondente despertador ganha 2 pontos de aliemus"
  },
  State_2923_Desc = {
    Text = "No final do turno, a Força aumenta [Layer]"
  },
  State_2923_Name = {
    Text = "Ritual de Descida Divina"
  },
  State_2923_WeaponDesc = {
    Text = "No final de cada turno, ganhe [Layer] de força"
  },
  State_2925_Desc = {
    Text = "Cada vez que o Fogo Verde causa dano, aumenta uma camada"
  },
  State_2925_Name = {
    Text = "Contagem de Imagem de Esmeralda"
  },
  State_2925_WeaponDesc = {
    Text = "Cada vez que o Fogo Verde causa dano, aumenta uma camada"
  },
  State_2927_Name = {
    Text = "Estado@MaldiçãoDelírioMudança"
  },
  State_2929_Desc = {
    Text = "Equipe Única: A cada 1 Dano causado pelo Portador, há <WeaponEffect_Num:[StateArg3]%> de chance de o Portador obter 2% de Dano Crítico Temporário. Após o Portador liberar Fúria Explosiva, causa 3 vezes Dano ativo equivalente a <WeaponEffect_Num:[StateArg1]%> da Força de ataque do Portador em inimigos aleatórios. Se o Domínio atual for \"Carne e sangue\", cada embrião Devorado pelo Portador realiza Fusão de embriões +<WeaponEffect_Num:[Blood:StateArg2]> ."
  },
  State_2929_WeaponDesc = {
    Text = "A cada 1 Dano causado pelo Portador, há <WeaponEffect_Num:[StateArg3]%> de chance de o Portador obter 2% de Dano Crítico Temporário. Após o Portador liberar Fúria Explosiva, causa 3 vezes [DescArg1] pontos de Dano ativo em inimigos aleatórios. Se o Domínio atual for \"Carne e sangue\", cada embrião Devorado pelo Portador realiza Fusão de embriões +<WeaponEffect_Num:[Blood:StateArg2]> ."
  },
  State_2930_Name = {
    Text = "Estado@George@Ganha força ao morrer"
  },
  State_2931_Desc = {
    Text = "A cada devoração, rouba 4 de força temporária de todos os inimigos"
  },
  State_2931_Name = {
    Text = "Seda de Ágata Alienada"
  },
  State_2933_Name = {
    Text = "Gêmeos Torcidos Brancos dos Acessórios"
  },
  State_2933_WeaponDesc = {
    Text = "Após o início do turno par, adicione a \"defesa\" de um portador com ilusão e exausto à mão"
  },
  State_2934_Desc = {
    Text = "Todo Dano ativo e Dano de tentáculo recebido +[DescArg1]%."
  },
  State_2934_Name = {
    Text = "<VulnerabilityColour: Vulnerável>"
  },
  State_2934_WeaponDesc = {
    Text = "Todo dano recebido aumentado em 50%"
  },
  State_2937_Desc = {
    Text = "A cada 3ª vez que ganhar um escudo, ganhe também a mesma quantidade de contra-ataque"
  },
  State_2938_Desc = {
    Text = "No início do turno, compre 1 carta. No final do turno, pode manter 1 carta na mão"
  },
  State_2939_Name = {
    Text = "Imunidade à fragilidade"
  },
  State_2940_Desc = {
    Text = "Efeito de regeneração aumentado"
  },
  State_2940_Name = {
    Text = "Suporta o fortalecimento do sangue aberrante"
  },
  State_2941_Desc = {
    Text = "Após jogar, aplique [StateArg1] camadas de intoxicação a todos os inimigos, fazendo com que todos os inimigos acionem [StateArg2]% de intoxicação"
  },
  State_2941_Name = {
    Text = "<Rune_10:Veneno>"
  },
  State_2942_Desc = {
    Text = "No fim do turno, cura [Layer]% de vida dos aliados e remove dano contínuo"
  },
  State_2942_Name = {
    Text = "Socorro no campo de batalha"
  },
  State_2946_Desc = {
    Text = "Golpes consecutivos da loucura concedem um escudo enorme"
  },
  State_2946_Name = {
    Text = "\"Fortaleza Imóvel\""
  },
  State_2946_WeaponDesc = {
    Text = "Golpes consecutivos da loucura concedem um escudo enorme"
  },
  State_2947_Name = {
    Text = "Dissolver 2"
  },
  State_2948_Desc = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_2948_Name = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_2948_WeaponDesc = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_2949_Name = {
    Text = "Desistir da marca na roda do destino"
  },
  State_2951_Desc = {
    Text = "Cadeira de Descanso da Criação"
  },
  State_2951_Name = {
    Text = "Luvas silenciadas"
  },
  State_2952_Desc = {
    Text = "Após o fim do turno, recupera [Layer] de vida. Para cada 5 de vida perdida, remove 1 camada"
  },
  State_2952_Name = {
    Text = "Regeneração"
  },
  State_2954_Name = {
    Text = "Estado@2-8Monstro24@Socorro"
  },
  State_2955_Desc = {
    Text = "Todos os inimigos perdem vida. Permanente, destrói"
  },
  State_2955_Name = {
    Text = "<CardKeyWord: Fim da Ilusão>"
  },
  State_2955_WeaponDesc = {
    Text = "Todos os inimigos perdem vida. Permanente, destrói"
  },
  State_2956_Desc = {
    Text = "Cada dano recebido concede [StateArg1] de loucura a todos os despertos"
  },
  State_2956_Name = {
    Text = "Feixe de Fantasia"
  },
  State_2956_WeaponDesc = {
    Text = "Cada dano recebido concede [StateArg1] de loucura a todos os despertos"
  },
  State_2957_Desc = {
    Text = "Após a morte, convoque um [Triângulo de Dissolução] com 1/3 do seu valor de vida no lugar"
  },
  State_2957_Name = {
    Text = "Dissolução"
  },
  State_2957_WeaponDesc = {
    Text = "Após a morte, convoque um [Triângulo de Dissolução] com 1/3 do seu valor de vida no lugar"
  },
  State_2960_Desc = {
    Text = "No turno par, quando sua aritmética for 0, ganhe 2 aritmética"
  },
  State_2960_Name = {
    Text = "Quebra-cabeça Antigo Alienado"
  },
  State_2960_WeaponDesc = {
    Text = "No turno par, quando sua aritmética for 0, ganhe 2 aritmética"
  },
  State_2961_Desc = {
    Text = "Equipe Única: O <IntoxicationIconKeywords:envenenamento> causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%>, antes de o portador liberar a Fúria Explosiva, aplique <WeaponEffect_Num:[StateArg2]%> de envenenamento equivalente à força de ataque do portador a todos os inimigos. Após usar a Ordem de chave, o portador ganha <WeaponEffect_Num:[StateArg3]> pontos de Fúria."
  },
  State_2961_WeaponDesc = {
    Text = "O envenenamento causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1] %>, antes de o portador liberar a Fúria Explosiva, aplique <WeaponEffect_Num:[Poison:DescArg1]> camadas de veneno a todos os inimigos. Após usar a Ordem de chave, o portador ganha <WeaponEffect_Num:[StateArg3]> pontos de Fúria."
  },
  State_2962_Desc = {
    Text = "Após jogar, enfraqueça todos os inimigos por [StateArg1] turno"
  },
  State_2962_Name = {
    Text = "<Rune_2:Fraqueza>"
  },
  State_2965_Name = {
    Text = "Estado @Dama do Crescente Iluminar 7"
  },
  State_2967_Desc = {
    Text = "Ao usar Cartões de sintomas, o estado de Pandia alterna entre \"Agitada\" e \"Dissipação\". Agitada: instâncias de Dano ativo +1, FOR reduzida. Dissipação: instâncias de Dano ativo -1, FOR aumentada."
  },
  State_2967_Name = {
    Text = "Pandia desperta!"
  },
  State_2967_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_2968_Name = {
    Text = "Estado@Fase2_14Batalha8Bolha4"
  },
  State_2969_Name = {
    Text = "Estado@Fase2_14Batalha8Bolha5"
  },
  State_2970_Desc = {
    Text = "Descendentes primordiais"
  },
  State_2970_Name = {
    Text = "Descendentes primordiais"
  },
  State_2970_WeaponDesc = {
    Text = "Descendentes primordiais"
  },
  State_2971_Desc = {
    Text = "Estado@prologoMeiaVida"
  },
  State_2971_Name = {
    Text = "Estado@prologoMeiaVida"
  },
  State_2971_WeaponDesc = {
    Text = "Estado@prologoMeiaVida"
  },
  State_2972_Name = {
    Text = "Estado@Fase2_14Batalha8Bolha2"
  },
  State_2973_Name = {
    Text = "Estado@Fase2_14Batalha8Bolha3"
  },
  State_2975_Desc = {
    Text = "Os primeiros 5 efeitos de salto na batalha ativam 1 vez extra"
  },
  State_2976_Desc = {
    Text = "No final do turno, se seu escudo for 0 ou múltiplo de 10, ganhe [Arg1] pontos de escudo. Se sua vida for múltiplo de 10, ganhe [Arg2] pontos de força"
  },
  State_2976_Name = {
    Text = "Sinal de SOS"
  },
  State_2977_Desc = {
    Text = "No turno ímpar, se não tiver cartas, compre 2"
  },
  State_2977_Name = {
    Text = "Quebra-cabeça Antigo Alienado"
  },
  State_2977_WeaponDesc = {
    Text = "No turno ímpar, se não tiver cartas, compre 2"
  },
  State_2978_Desc = {
    Text = "Cada ponto de dano recebido reduz uma camada. Quando as camadas chegam a 0, muda para modo de defesa"
  },
  State_2978_Name = {
    Text = "Contagem de cartas"
  },
  State_2978_WeaponDesc = {
    Text = "Cada ponto de dano recebido reduz uma camada. Quando as camadas chegam a 0, muda para modo de defesa"
  },
  State_2979_Desc = {
    Text = "Equipe Única: O envenenamento e o escudo causados pelo portador aumentam em <WeaponEffect_Num:[StateArg3]%. A taxa de crítico e o dano crítico do \"golpe\" do portador aumentam em <WeaponEffect_Num:[StateArg1]%, e ganha um escudo equivalente a <WeaponEffect_Num:[StateArg2]%> da vida máxima, com o efeito do escudo podendo ocorrer no máximo 1 vez por turno."
  },
  State_2979_Name = {
    Text = "Graça Através da Dor"
  },
  State_2979_WeaponDesc = {
    Text = "O envenenamento e o escudo causados pelo portador aumentam em <WeaponEffect_Num:[StateArg3]%>. A taxa de crítico e o dano crítico do \"golpe\" do portador aumentam em <WeaponEffect_Num:[StateArg1]%, e ganha um escudo equivalente a [StateArg2]% da vida máxima ([DescArg1]), com o efeito do escudo podendo ser ativado no máximo 1 vez por turno."
  },
  State_2983_Desc = {
    Text = "Se a fase de descarte ainda tiver cartas na mão, a carta será consumida e não aparecerá mais nesta batalha"
  },
  State_2983_Name = {
    Text = "<NothingnessIconKeywords: ilusão>"
  },
  State_2983_WeaponDesc = {
    Text = "Se ainda estiver na mão na fase de descarte, não vai para a pilha de descarte, mas não pode ser usada novamente nesta batalha"
  },
  State_2985_Desc = {
    Text = "Até o fim do turno, cada vez que causar dano, recupera [Layer] pontos de vida no fim do turno"
  },
  State_2985_Name = {
    Text = "Ovo de Pérola"
  },
  State_2985_WeaponDesc = {
    Text = "Até o fim do turno, cada vez que causar dano, recupera [Layer] pontos de vida"
  },
  State_2987_Desc = {
    Text = "Evento 19_1"
  },
  State_2987_Name = {
    Text = "Evento 19_1"
  },
  State_2987_WeaponDesc = {
    Text = "Evento 19_1"
  },
  State_2988_Desc = {
    Text = "Ao devorar um embrião, ele retorna do baralho de descarte para o baralho de mão, a aritmética se torna 0"
  },
  State_2988_Name = {Text = "Nascimento"},
  State_2988_WeaponDesc = {
    Text = "Ao devorar um embrião, ele retorna do baralho de descarte para o baralho de mão, a aritmética se torna 0"
  },
  State_2989_Desc = {
    Text = "Após evocar o cartão do despertador, coloque uma cópia temporária dessa carta, com custo reduzido em 1, no baralho"
  },
  State_2990_Desc = {
    Text = "Jogue para fazer todos os inimigos perderem [StateArg1] pontos de força temporária"
  },
  State_2990_Name = {
    Text = "<Rune_18_High:Esgotamento Avançado>"
  },
  State_2992_Desc = {
    Text = "Ao comprar \"Vazio\", a loucura adquirida por todos os despertos neste turno é reduzida em 50%"
  },
  State_2992_Name = {Text = "Vazio"},
  State_2992_WeaponDesc = {
    Text = "Ao comprar \"Vazio\", a loucura adquirida por todos os despertos neste turno é reduzida em 50%"
  },
  State_2993_Name = {
    Text = "Contagem da Pele de Cobra Estranha da Criação"
  },
  State_2994_Desc = {
    Text = "Quando o tentáculo transborda, o dano de tentáculo aumenta em [StateArg1]"
  },
  State_2994_Name = {
    Text = "Força de proteção"
  },
  State_2994_WeaponDesc = {
    Text = "Quando o tentáculo transborda, o dano de tentáculo aumenta em [StateArg1]"
  },
  State_2996_Desc = {
    Text = "Jogue para fazer um tentáculo atacar [StateArg1] vezes"
  },
  State_2996_Name = {
    Text = "<Rune_11:Domínio>"
  },
  State_2997_Desc = {
    Text = "Ao causar o 3º dano, ganhe [Arg1] de escudo. Ao 6º dano, ganhe [Arg2] de força"
  },
  State_2997_Name = {
    Text = "Passagem segura"
  },
  State_3001_Desc = {
    Text = "Ao ser atacado, aumenta 2 pontos de loucura recebida"
  },
  State_3002_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_3002_Name = {
    Text = "Estado@ProtótipoCanhãoLaserSorte"
  },
  State_3003_Desc = {
    Text = "Após jogar, não vá para a pilha de descarte, mas seja removido do baralho"
  },
  State_3003_Name = {
    Text = "<DepleteIconKeywords:Consumo>"
  },
  State_3003_WeaponDesc = {
    Text = "Após jogar, a carta não irá para a pilha de descarte e não poderá ser usada novamente nesta batalha"
  },
  State_3004_Desc = {
    Text = "[Layer] imunidade ao estado de veneno aplicado durante a rodada"
  },
  State_3004_Name = {
    Text = "Imunidade a envenenamento"
  },
  State_3008_Desc = {
    Text = "No início de cada rodada, adiciona 1 camada de atraso às cartas restantes na mão. Para cartas cujo custo de aritmética excede 5, transforme-as em pedra"
  },
  State_3008_Name = {
    Text = "Aigis Despertar!"
  },
  State_3008_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_3011_Desc = {
    Text = "Equipe Única: A taxa de crítico e o dano crítico da \"Fúria Explosiva\" do portador aumentam em <WeaponEffect_Num:[StateArg2] %>. Após liberar a \"Fúria Explosiva\", o portador ganha uma quantidade de <WeaponEffect_Num:[StateArg1]%> de Força equivalente à Constituição do portador. Se esta \"Fúria Explosiva\" ativar o efeito <CardKeyWord:Devorar>, ganha 1 vez adicional de <PowerIconKeywords:Força>."
  },
  State_3011_WeaponDesc = {
    Text = "A taxa de crítico e o dano crítico da \"Fúria Explosiva\" do portador aumentam em <WeaponEffect_Num:[StateArg2] %>. Após liberar a \"Fúria Explosiva\", o portador ganha <WeaponEffect_Num:[Power:DescArg1]> pontos de Força. Se esta \"Fúria Explosiva\" ativar o efeito <CardKeyWord:Devorar>, ganha 1 vez adicional de <PowerIconKeywords:Força>."
  },
  State_3012_Desc = {
    Text = "Estado vazio inútil"
  },
  State_3012_Name = {
    Text = "Estado vazio inútil"
  },
  State_3012_WeaponDesc = {
    Text = "Estado vazio inútil"
  },
  State_3013_Desc = {
    Text = "Pacientes sanguinários aumentam o poder de fusão de embriões em [StateArg1] pontos"
  },
  State_3013_Name = {
    Text = "Sedento de sangue"
  },
  State_3014_Desc = {
    Text = "Se o oponente tiver 4 ou mais cartas na mão, ao receber dano, ganha [StateArg1] pontos de escudo"
  },
  State_3014_Name = {Text = "Serpente"},
  State_3015_Desc = {
    Text = "Estado@ArmaduraDeCeraEquipe"
  },
  State_3015_Name = {
    Text = "Estado@ArmaduraDeCeraEquipe"
  },
  State_3015_WeaponDesc = {
    Text = "Estado@ArmaduraDeCeraEquipe"
  },
  State_3016_Desc = {
    Text = "A vida dos monstros invocados dobra"
  },
  State_3016_Name = {
    Text = "\"Fluxo transversal de vergonha\""
  },
  State_3016_WeaponDesc = {
    Text = "A vida dos monstros invocados dobra"
  },
  State_3017_Name = {
    Text = "Estado@MaldiçãoDelírio"
  },
  State_3018_Desc = {
    Text = "\"Cão Dimensional\" remove 1 camada para cada vida perdida; quando as camadas chegarem a 0, ganhe um escudo [StateArg1] e recupere barreiras dimensionais [StateArg2]."
  },
  State_3018_Name = {
    Text = "Barreira dimensional"
  },
  State_3019_Desc = {
    Text = "A cada 10 sigilos negros consumidos, recupere 1% da vida"
  },
  State_3019_Name = {
    Text = "Estado da Raiz Inversa da Criação"
  },
  State_3019_WeaponDesc = {
    Text = "A cada 10 sigilos negros consumidos, recupere 1% da vida"
  },
  State_3020_Desc = {
    Text = "Se sofreu dano no turno anterior, ganha imunidade por 1 turno no início do turno"
  },
  State_3020_Name = {
    Text = "Adaptação"
  },
  State_3020_WeaponDesc = {
    Text = "Se sofreu dano no turno anterior, ganha imunidade por 1 turno no início do turno"
  },
  State_3021_Desc = {
    Text = "Ao iniciar a rodada, ganhe 1 aritmética"
  },
  State_3021_Name = {
    Text = "Estado@máximo aritmética -2"
  },
  State_3023_Desc = {
    Text = "Cada vez que um Dano ativo é recebido neste turno, causa [Layer] de <FixedDamage:Dano Puro> à Fonte de Dano."
  },
  State_3023_Name = {
    Text = "Contra-ataque temporário"
  },
  State_3023_WeaponDesc = {
    Text = "Cada vez que um Dano ativo é recebido, causa [Layer] de <FixedDamage:Dano Puro> ao Atacante."
  },
  State_3024_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_3024_Name = {
    Text = "Estado@ProtótipoFacaResistência"
  },
  State_3025_Desc = {
    Text = "Sempre que jogar 1 carta, aumente a taxa crítica deste turno em 10%"
  },
  State_3026_Desc = {
    Text = "Após o início da batalha, embaralhe [StateArg1] cópias temporárias no baralho de compra; as cartas originais e as cartas espelhadas ganham manter"
  },
  State_3026_Name = {
    Text = "<Rune_8_High:Imagem Avançada>"
  },
  State_3026_WeaponDesc = {
    Text = "Após o início da batalha, embaralhe [StateArg1] cópias temporárias no baralho de compra"
  },
  State_3027_Desc = {
    Text = "Ao final da batalha, ganha adicionalmente 50 selos negros e 1 carta de sintoma"
  },
  State_3028_Name = {
    Text = "Estado@após o início da rodada aritmética +2"
  },
  State_3029_Desc = {
    Text = "Cada ponto de dano recebido reduz uma camada. Quando as camadas chegam a 0, muda para modo de defesa"
  },
  State_3029_Name = {
    Text = "Contagem de cartas"
  },
  State_3029_WeaponDesc = {
    Text = "Cada ponto de dano recebido reduz uma camada. Quando as camadas chegam a 0, muda para modo de defesa"
  },
  State_3033_Desc = {
    Text = "Sempre que jogar 10 cartas, ganhe uma barreira que bloqueia qualquer dano. Se já tiver uma barreira, recupere [Arg1] pontos de vida"
  },
  State_3034_Desc = {
    Text = "Equipe única: Ao jogar 1 carta do portador, ganha <WeaponEffect_Num:[StateArg1]> energia de chave de prata. Esse efeito só se aplica até 3 vezes por rodada"
  },
  State_3034_WeaponDesc = {
    Text = "Sempre que jogar 1 carta do usuário, ganhe <WeaponEffect_Num:[StateArg1]> s-energia. Este efeito é aplicado no máximo 3 vezes por único turno"
  },
  State_3035_Desc = {
    Text = "Jogue para fazer um tentáculo atacar [StateArg1] vezes"
  },
  State_3035_Name = {
    Text = "<Rune_11_High:Domínio Avançado>"
  },
  State_3035_WeaponDesc = {
    Text = "Jogue para fazer um tentáculo atacar todos os inimigos [StateArg1] vezes"
  },
  State_30364_Desc = {
    Text = "Este cartão, quando está na mão, aumentará o limite de cartas na mão em +1"
  },
  State_30364_Name = {
    Text = "Ignorar limite de cartas na mão"
  },
  State_30369_Desc = {
    Text = "Neste turno, limite de cartas na mão +[Layer]"
  },
  State_30369_Name = {
    Text = "Limite de cartas na mão"
  },
  State_3036_Desc = {
    Text = "Efeitos de fraqueza e vulnerabilidade aumentados de 33% para 50%"
  },
  State_3036_Name = {
    Text = "\"Ondas de Silêncio\""
  },
  State_3036_WeaponDesc = {
    Text = "Efeitos de fraqueza e vulnerabilidade aumentados de 33% para 50%"
  },
  State_3038_Desc = {
    Text = "Único da equipe: Após liberar Chave, o portador ganha <WeaponEffect_Num:[StateArg1]> Loucura"
  },
  State_3038_WeaponDesc = {
    Text = "Após liberar a Chave de Comando, o portador ganha <WeaponEffect_Num:[StateArg1]> de loucura"
  },
  State_3040_Desc = {
    Text = "No início de cada turno, aplique [Camada] de [Vincular] à minha equipe."
  },
  State_3040_Name = {
    Text = "Restrição"
  },
  State_3040_WeaponDesc = {
    Text = "No início de cada turno, aplique [Camada] de [Vincular] à minha equipe."
  },
  State_3041_Desc = {
    Text = "Permanente no baralho"
  },
  State_3041_Name = {
    Text = "<CardKeyWord: Carta de Sintoma>"
  },
  State_3042_Desc = {
    Text = "Cada vez que causa dano, ganha [Arg1] força temporária neste turno, até 3 vezes. Ao atingir o máximo, o efeito dobra"
  },
  State_3043_Desc = {
    Text = "Nos turnos pares, dano recebido -50%, dano causado +33%"
  },
  State_3043_Name = {Text = "Caprichoso"},
  State_3043_WeaponDesc = {
    Text = "Nos turnos pares, dano recebido -50%, dano causado +33%"
  },
  State_3045_Desc = {
    Text = "Após liberar a exaltação, o despertador correspondente ganha 20 de aliemus"
  },
  State_3045_Name = {
    Text = "Véu do Deus Sem Nome"
  },
  State_3046_Desc = {
    Text = "Equipe Única: Cada vez que um inimigo morre, ganhe [StateArg1] marcas negras. Após o portador eliminar um inimigo, o dano crítico do portador neste nível aumenta permanentemente em <WeaponEffect_Num:[StateArg2]%, com um máximo de 5 acumulações. Sempre que o portador ativa o efeito de salto, o dano final causado pelo portador neste turno aumenta em <WeaponEffect_Num:[StateArg3]%, com um máximo de 3 acumulações."
  },
  State_3046_WeaponDesc = {
    Text = "Cada vez que um inimigo morre, ganhe [StateArg1] Marca Negra. Após o portador eliminar um inimigo, o dano crítico do portador nesta fase aumenta permanentemente em <WeaponEffect_Num:[StateArg2]%, com um máximo de 5 acumulações. Cada vez que o portador ativa o efeito de salto, o dano final causado pelo portador neste turno aumenta em <WeaponEffect_Num:[StateArg3]%, com um máximo de 3 acumulações."
  },
  State_3047_Desc = {
    Text = "No início do turno, ganhe [Arg1] de escudo, aumentando em [Arg2] a cada turno"
  },
  State_3047_Name = {
    Text = "Mão do Guardião"
  },
  State_3048_Desc = {
    Text = "O espírito de luta de Lotan nunca para. No final de cada turno, Lotan remove 3 camadas de fraqueza e vulnerável"
  },
  State_3048_Name = {
    Text = "Rothan desperta"
  },
  State_3049_Desc = {
    Text = "Aumenta em 1 o número de danos do próximo ataque de George"
  },
  State_3049_Name = {Text = "Rancor"},
  State_3049_WeaponDesc = {
    Text = "Aumenta em 1 o número de danos do próximo ataque de George"
  },
  State_3050_Desc = {
    Text = "No início da batalha, embaralhe uma [Convulsão] na sua pilha de compras."
  },
  State_3050_Name = {Text = "Medo"},
  State_3050_WeaponDesc = {
    Text = "No início da batalha, embaralhe uma [Convulsão] na sua pilha de compras."
  },
  State_3051_Desc = {
    Text = "Ao causar dano não bloqueado, embaralhe uma carta de chorar e gritar no baralho de robo."
  },
  State_3051_Name = {
    Text = "Desejo das gotas de cera ardentes"
  },
  State_3051_WeaponDesc = {
    Text = "Ao causar dano real, embaralhe uma carta de choro no baralho de puxar"
  },
  State_3054_Name = {
    Text = "Estado@MaldiçãoChoque"
  },
  State_3055_Desc = {
    Text = "No início da batalha, cause 1 camada de fragilidade à equipe"
  },
  State_3055_Name = {
    Text = "Penetração"
  },
  State_3055_WeaponDesc = {
    Text = "No início da batalha, cause 1 camada de fragilidade à equipe"
  },
  State_3056_Desc = {
    Text = "Ao final da rodada, remova 1 camada de fraqueza e vulnerável"
  },
  State_3056_Name = {
    Text = "Intimidação"
  },
  State_3058_Desc = {
    Text = "Para cada tentáculo, ganha [Arg1] pontos de escudo no final do turno"
  },
  State_3058_Name = {
    Text = "Apêndice sem nome"
  },
  State_3060_Desc = {
    Text = "No início do próximo turno, ganhe [Layer] pontos de escudo"
  },
  State_3060_Name = {
    Text = "Reconstrução mental"
  },
  State_3060_WeaponDesc = {
    Text = "No início do próximo turno, compre [Layer] cartas"
  },
  State_3063_Desc = {
    Text = "Cada vez que causa dano real, adiciona [Layer] veneno"
  },
  State_3063_Name = {Text = "toxina"},
  State_3064_Desc = {
    Text = "Sofra dano equivalente ao número de camadas antes de jogar a carta. Remova no final do turno"
  },
  State_3064_Name = {
    Text = "Restrição"
  },
  State_3064_WeaponDesc = {
    Text = "Sofra dano equivalente ao número de camadas antes de jogar a carta. Remova no final do turno"
  },
  State_3065_Name = {
    Text = "Estado@CriaçãoTributoPassado2"
  },
  State_3068_Desc = {
    Text = "No fim do turno, recebe [Layer] de <FixedDamage:Dano Puro>."
  },
  State_3068_Name = {
    Text = "<IntoxicationColour: Envenenado>"
  },
  State_3068_WeaponDesc = {
    Text = "No fim do turno, recebe [Layer] de <FixedDamage:Dano Puro>."
  },
  State_3069_Name = {
    Text = "Deus Máquina dos Acessórios"
  },
  State_3069_WeaponDesc = {
    Text = "No primeiro turno de cada batalha, ganha 1 ponto adicional de aritmética"
  },
  State_3070_Desc = {
    Text = "Único na equipe: O \"Ataque\" do portador faz o inimigo perder <PowerIconKeywords:força> temporária igual a <WeaponEffect_Num:[StateArg1]%> do ataque do portador. Este efeito pode ser ativado até 3 vezes por turno"
  },
  State_3070_WeaponDesc = {
    Text = "O \"golpe\" do equipador reduz temporariamente em <WeaponEffect_Num:[Power:DescArg1]> pontos de <PowerIconKeywords:poder> do inimigo alvo. Este efeito pode ser ativado no máximo 3 vezes dentro de uma rodada"
  },
  State_3071_Desc = {
    Text = "Team Unique: Após jogar a \"defesa\" do portador, ganhe Temporário <PowerIconKeywords:STR> igual a <WeaponEffect_Num:[StateArg1]%> do ATK do portador"
  },
  State_3071_WeaponDesc = {
    Text = "Ao jogar a \"Defesa\" do portador, ganhe <WeaponEffect_Num:[Power:DescArg1]> pontos de <PowerIconKeywords:força> temporária"
  },
  State_3072_Desc = {
    Text = "Único na equipe: Após matar um inimigo, o portador ganha <WeaponEffect_Num:[StateArg1]> Loucura e 1% de Dano Crítico, válido durante toda a exploração"
  },
  State_3072_WeaponDesc = {
    Text = "Após matar inimigo, o portador ganha <WeaponEffect_Num:[StateArg1]> de Fúria e 1% de dano crítico, válido para toda a exploração"
  },
  State_3073_Desc = {
    Text = "Equipe única: Após o portador liberar o exaltar, todos os aliados aumentam a taxa crítica neste turno em <WeaponEffect_Num:[StateArg1]%>"
  },
  State_3073_WeaponDesc = {
    Text = "Após o portador liberar a exaltação, todos os aliados recebem um aumento de taxa crítica de <WeaponEffect_Num:[StateArg1]%> neste turno"
  },
  State_3074_Desc = {
    Text = "Único da equipe: Após jogar uma carta de sintoma, o portador ganha <WeaponEffect_Num:[StateArg1]> de loucura. Esse efeito pode ser ativado no máximo 2 vezes por turno. Após jogar uma carta de comando, ganha 1 de loucura"
  },
  State_3074_WeaponDesc = {
    Text = "Após jogar uma carta de sintomas, o portador ganha <WeaponEffect_Num:[StateArg1]> pontos de loucura. Esse efeito pode ser ativado no máximo 2 vezes por turno. Após jogar uma carta de comando, o portador ganha 1 ponto de loucura"
  },
  State_3075_Desc = {
    Text = "Equipe única: Após o portador liberar um exaltar, ganha um escudo equivalente a <WeaponEffect_Num:[StateArg1]%> da defesa do portador"
  },
  State_3075_Name = {
    Text = "Barreira do coração"
  },
  State_3075_WeaponDesc = {
    Text = "Após o portador liberar a exaltação, ganha <WeaponEffect_Num:[Block:DescArg1]> pontos de escudo"
  },
  State_3076_Desc = {
    Text = "Equipe Única: Após causar Dano ativo, a Taxa de Crítico do Portador + <WeaponEffect_Num:[StateArg1]%>. Após um acerto crítico, a Taxa de Crítico obtida por este efeito é reiniciada."
  },
  State_3076_WeaponDesc = {
    Text = "Após causar Dano ativo, a Taxa de Crítico do Portador + <WeaponEffect_Num:[StateArg1]%>. Após um acerto crítico, a Taxa de Crítico obtida por este efeito é reiniciada."
  },
  State_3078_Desc = {
    Text = "Neste turno, dano causado será sempre crítico"
  },
  State_3078_Name = {
    Text = "Temporariamente garantido para explodir"
  },
  State_3078_WeaponDesc = {
    Text = "Neste turno, a taxa crítica aumenta 100%"
  },
  State_3082_Desc = {
    Text = "Após liberar a exaltação, coloque uma carta aleatória correspondente ao despertador na sua mão, essa carta ganha exausto e ilusão"
  },
  State_3082_Name = {
    Text = "mala do médico"
  },
  State_3084_Desc = {
    Text = "Após jogar, copie [StateArg1] cartas da carta e adicione ao <DimensionalSpaceIconKeywords:ultra> temporário"
  },
  State_3084_Name = {
    Text = "<Rune_13_High:Salto Avançado>"
  },
  State_3084_WeaponDesc = {
    Text = "Jogue para consumir, mas copie [StateArg1] cartas temporárias para o Espaço Dimensional"
  },
  State_3087_Desc = {
    Text = "Dano de carta de ataque aumentado em [Layer] %"
  },
  State_3087_Name = {
    Text = "Dano temporário de carta de ataque aumentado"
  },
  State_3087_WeaponDesc = {
    Text = "Dano de carta de ataque aumentado em [Layer] %"
  },
  State_3088_Desc = {
    Text = "Dano ativo recebido aumenta [Layer]. Cada dano recebido amplia a ferida corrosiva, restaurada no início do turno"
  },
  State_3088_Name = {
    Text = "Profunda Erosão"
  },
  State_3088_WeaponDesc = {
    Text = "Dano ativo recebido aumenta [Layer]. Cada dano recebido amplia a ferida corrosiva, restaurada no início do turno"
  },
  State_3092_Name = {
    Text = "Se for uma batalha de líderes, todos os despertadores ganham 30 de aliemus e quebram o estado selado"
  },
  State_3093_Name = {
    Text = "Estado@contagemImitadorDeIlusionista"
  },
  State_3094_Desc = {
    Text = "Ao sacar, torna-se vulnerável por 1 turno. Após usar, torna todos os inimigos vulneráveis por 1 turno. Não pode ser vendido"
  },
  State_3094_Name = {
    Text = "EstadoMaldiçãoColapso"
  },
  State_3094_WeaponDesc = {
    Text = "Ao sacar, torna-se vulnerável por 1 turno. Após usar, torna todos os inimigos vulneráveis por 1 turno. Não pode ser vendido"
  },
  State_3095_Desc = {
    Text = "Dano aumentado em [Layer] pontos nesta fase"
  },
  State_3095_Name = {
    Text = "Força permanente"
  },
  State_3095_WeaponDesc = {
    Text = "Dano aumentado em [Layer] pontos nesta fase"
  },
  State_3096_Desc = {
    Text = "Ainda há um longo caminho a percorrer para convencer Lotan"
  },
  State_3096_Name = {
    Text = "Rothan desperta"
  },
  State_3098_Desc = {
    Text = "Ao pegar, escolha um cartão, transformando seu custo de aritmética permanentemente em 1"
  },
  State_3099_Desc = {
    Text = "Após liberar a exaltação, ganhe [Arg1] de poder"
  },
  State_3100_Desc = {
    Text = "No início de cada turno, a resistência à morte aumenta em 10%. Quando a resistência à morte está acima de 100%, ganha 30 pontos extras de maestria em domínios"
  },
  State_3104_Desc = {
    Text = "Neste turno, cada dano ativo recebido aumenta o número de ataques do \"Demônio Doce\" em 1"
  },
  State_3104_Name = {
    Text = "Compartilhamento de dor"
  },
  State_3104_WeaponDesc = {
    Text = "Neste turno, cada dano ativo recebido aumenta o número de ataques do \"Demônio Doce\" em 1"
  },
  State_3106_Desc = {
    Text = "Quando a vida estiver abaixo de 50%([StateArg1]), dividir-se-á em 2 \"Estudos Experimentais\" com vida igual"
  },
  State_3106_Name = {Text = "Fissão"},
  State_3106_WeaponDesc = {
    Text = "Quando a vida estiver abaixo de 50%([StateArg1]), se dividirá em 3 corpos de vida equivalentes \"escultura de cera tipo II\""
  },
  State_3108_Name = {
    Text = "Poema Circular dos Acessórios"
  },
  State_3108_WeaponDesc = {
    Text = "Após o início do turno par, ganhe 1 ponto de aritmética"
  },
  State_3109_Name = {
    Text = "Estado@quarto capítulo ressonância@aritmética -1"
  },
  State_3109_WeaponDesc = {
    Text = "“A ingênua retribuição” consome 1 de poder"
  },
  State_3110_Name = {
    Text = "Estado@quarto capítulo ressonância@aritmética -1"
  },
  State_3110_WeaponDesc = {
    Text = "“A ingênua retribuição” consome 1 de poder"
  },
  State_3111_Desc = {
    Text = "No início do próximo turno, converta o escudo restante em vida dobrada"
  },
  State_3111_Name = {
    Text = "Flor Imortal"
  },
  State_3112_Desc = {
    Text = "Equipe Única: O envenenamento causado pelo portador aumenta em <WeaponEffect_Num:[StateArg3] %>. Após liberar a Fúria Explosiva, recupera uma quantidade de vida equivalente a <WeaponEffect_Num:[StateArg1] %> da Constituição do portador, mais <WeaponEffect_Num:[StateArg2] %> da vida da Constituição do portador para cada ponto de Poder de cálculo restante."
  },
  State_3112_Name = {
    Text = "Banquete Silencioso"
  },
  State_3112_WeaponDesc = {
    Text = "O envenenamento causado pelo portador aumenta em <WeaponEffect_Num:[StateArg3]%>. Após liberar a exaltação, recupera <WeaponEffect_Num:[Heal:DescArg1]> pontos de vida, mais <WeaponEffect_Num:[Heal:DescArg2]> pontos de vida adicionais para cada ponto de aritmética restante."
  },
  State_3113_Desc = {
    Text = "Estado@prologoLoucura0_1_4"
  },
  State_3113_Name = {
    Text = "Estado@prologoLoucura0_1_4"
  },
  State_3113_WeaponDesc = {
    Text = "Estado@prologoLoucura0_1_4"
  },
  State_3114_Desc = {
    Text = "Estado@prologoLoucura0_1_2"
  },
  State_3114_Name = {
    Text = "Estado@prologoLoucura0_1_2"
  },
  State_3114_WeaponDesc = {
    Text = "Estado@prologoLoucura0_1_2"
  },
  State_3115_Desc = {
    Text = "Estado@prologoLoucura0_1_2"
  },
  State_3115_Name = {
    Text = "Estado@prologoLoucura0_1_2"
  },
  State_3115_WeaponDesc = {
    Text = "Estado@prologoLoucura0_1_2"
  },
  State_3116_Name = {
    Text = "Estado@prologoLoucura0_1_1"
  },
  State_3117_Desc = {
    Text = "Único para a equipe: O portador do \"Golpe\" e \"Exaltação\" tem o dano básico aumentado em <WeaponEffect_Num:[StateArg1]%>. Após o portador usar \"Golpe\", o portador ganha 5% de taxa crítica temporária, até 3 vezes por turno, e ao atingir 3 vezes, ganha 15% de dano crítico temporário"
  },
  State_3117_WeaponDesc = {
    Text = "O portador de \"impacto\" e \"explosão de loucura\" tem seu dano base aumentado em <WeaponEffect_Num:[StateArg1]%>. Após jogar \"impacto\", o portador ganha 5% de taxa crítica temporária, até 3 vezes por turno. Ao alcançar 3 vezes, ganha 15% de dano crítico temporário"
  },
  State_3118_Desc = {
    Text = "No início do turno, restaure [Layer]% da HP perdida."
  },
  State_3118_Name = {
    Text = "Proteção da Vela do Piloto"
  },
  State_3120_Desc = {
    Text = "[defesa] ganha [Arg1] níveis de balcão"
  },
  State_3121_Desc = {
    Text = "Se a intenção do inimigo não for ataque, causar dano ativo ou de tentáculo a ele adicionará sangramento correspondente à metade dos níveis de dano"
  },
  State_3123_Desc = {
    Text = "Equipe Única: O <RetaliateIconKeywords:Contrataque> do Portador aumenta em <WeaponEffect_Num:[StateArg3]%>. A cada ataque recebido, ganha <PowerIconKeywords:Força> Temporária equivalente a <WeaponEffect_Num:[StateArg1]%> da Força de ataque do Portador. Após o Portador usar a Fúria Explosiva, ganha <RetaliateIconKeywords:Contrataque> equivalente a <WeaponEffect_Num:[StateArg2]%> da Força de ataque do Portador."
  },
  State_3123_WeaponDesc = {
    Text = "O contrataque causado pelo portador aumenta em <WeaponEffect_Num:[StateArg3] %>. A cada 1 ataque recebido, ganha <WeaponEffect_Num:[Power:DescArg1]> pontos de <PowerIconKeywords:força> temporária. Após o portador usar a Fúria Explosiva, ganha <WeaponEffect_Num:[Counterattack:DescArg2]> pontos de contrataque."
  },
  State_3124_Desc = {
    Text = "Os selos negros ganhos por um detetive afortunado são dobrados"
  },
  State_3124_Name = {
    Text = "Sorte excepcional"
  },
  State_3124_WeaponDesc = {
    Text = "Os selos negros ganhos por um detetive afortunado são dobrados"
  },
  State_3127_Name = {
    Text = "Estado@Fase2_10Batalha3Bolha1"
  },
  State_3128_Desc = {
    Text = "Aumenta em [StateArg1]% o escudo e a cura causados por todos os despertos"
  },
  State_3128_Name = {Text = "berço"},
  State_3129_Desc = {
    Text = "Antes do início do próximo turno, cada instância de Dano ativo recebido aciona [Layer] contra-ataques adicionais e contra-ataques de tentáculo, causando 50% de dano."
  },
  State_3129_Name = {
    Text = "Proteção da Escama Inversa"
  },
  State_3130_Desc = {
    Text = "Neste turno, dano causado aumenta [Layer]"
  },
  State_3130_Name = {
    Text = "Força temporária"
  },
  State_3130_WeaponDesc = {
    Text = "Neste turno, dano causado aumenta [Layer]"
  },
  State_3135_Desc = {
    Text = "Cada camada concede +1 ataque ativo causado."
  },
  State_3135_Name = {
    Text = "<MadnessIconKeywords:Loucura>"
  },
  State_3136_Name = {Text = "Fúria"},
  State_3137_Desc = {
    Text = "Ao início da batalha, ganha 1 tentáculo, o dano do tentáculo aumenta permanentemente em [Arg1]"
  },
  State_3138_Name = {
    Text = "Paradoxo dos Acessórios"
  },
  State_3138_WeaponDesc = {
    Text = "Após o uso do aliemus pelo portador, sua equipe recebe 100% de <RetaliateIconKeywords:retaliação> baseado na defesa do portador; e aumenta sua atual <RetaliateIconKeywords:retaliação> em 10%"
  },
  State_3139_Desc = {
    Text = "Ao entrar na rodada ultra, anule sua fraqueza e fragilidade, e debilite e vulnerabilize todos os inimigos por 2 rodadas"
  },
  State_3140_Desc = {
    Text = "No início da batalha, coloque \"Fantasma\" no Espaço Ultra até que você tenha 4 cartas no Espaço Ultra."
  },
  State_3143_Desc = {
    Text = "Ao causar dano real, a equipe perde [Layer] de força temporária"
  },
  State_3143_Name = {Text = "Paralisia"},
  State_3144_Name = {
    Text = "As camadas de \"veneno\" e \"sangrando\" da nossa equipe foram reduzidas pela metade"
  },
  State_3145_Desc = {
    Text = "No [Layer], não é possível usar cartões"
  },
  State_3145_Name = {
    Text = "Não pode ser jogado"
  },
  State_3146_Desc = {
    Text = "Quando o Apóstolo do Mar joga 1 carta, gera [StateArg1] tentáculos temporários, ignorando o limite de tentáculos"
  },
  State_3146_Name = {
    Text = "Poder delegado"
  },
  State_3146_WeaponDesc = {
    Text = "Quando o Apóstolo do Mar joga 1 carta, gera [StateArg1] tentáculos temporários, ignorando o limite de tentáculos"
  },
  State_3149_Desc = {
    Text = "No início do próximo turno, todo Dano ativo e Dano de tentáculo recebido +50%."
  },
  State_3149_Name = {
    Text = "Atraso de vulnerabilidade"
  },
  State_3149_WeaponDesc = {
    Text = "Todo dano recebido aumentado em 50%"
  },
  State_3150_Desc = {
    Text = "Após receber 3 ataques em um turno, ganha 1 pilha de Loucura Temporária."
  },
  State_3150_Name = {Text = "\"Dor Doce\""},
  State_3151_Desc = {
    Text = "Ao pegar, ganha permanentemente [Arg1] de força"
  },
  State_3152_Name = {
    Text = "Estado@AcessórioReevolução"
  },
  State_3152_WeaponDesc = {
    Text = "No fim do turno, o portador ganha 3 de Fúria. Se a recarga de Fúria for maior que 10, ganha 2 de Fúria extra"
  },
  State_3153_Name = {
    Text = "Estado@MaldiçãoDelírioReversão"
  },
  State_3154_Name = {
    Text = "Taxa de Crítico"
  },
  State_3155_Desc = {
    Text = "Recupera 10% da vida perdida a cada turno"
  },
  State_3155_Name = {Text = "Medicina"},
  State_3155_WeaponDesc = {
    Text = "Recupera 10% da vida perdida a cada turno"
  },
  State_3156_Desc = {
    Text = "O primeiro dano recebido a cada turno é multiplicado por 5"
  },
  State_3156_Name = {Text = "Em pânico"},
  State_3160_Desc = {
    Text = "No início do turno, adiciona 1 cartão de \"guarda-chuva\" de alerta [Arg1] obtida neste turno à mão, após jogar 6 cartões, aumenta o alerta de todos os \"guarda-chuvas\" na mão em [Arg2]"
  },
  State_3161_Desc = {
    Text = "Reduz o número de cartas compradas pelo oponente [Layer], mas todas as cartas são mantidas"
  },
  State_3161_WeaponDesc = {
    Text = "Nossa equipe compra menos [Layer] cartas, todas as cartas são mantidas"
  },
  State_3163_Desc = {
    Text = "Após acionar resistência à morte, recupere [Layer] pontos de vida"
  },
  State_3163_Name = {
    Text = "Berço das Estrelas"
  },
  State_3163_WeaponDesc = {
    Text = "Após acionar resistência à morte, recupere [Layer] pontos de vida"
  },
  State_3164_Name = {
    Text = "Contagem de corrente de ressentimento"
  },
  State_3165_Name = {
    Text = "Despertador de Rastro 3"
  },
  State_3166_Name = {
    Text = "Esta batalha foi desencadeada"
  },
  State_3168_Desc = {
    Text = "No início do turno, adicione contagem de ataques a todos os monstros"
  },
  State_3168_Name = {
    Text = "Estado@grande lâmina da vingança dano de decapitação"
  },
  State_3168_WeaponDesc = {
    Text = "No início do turno, adicione contagem de ataques a todos os monstros"
  },
  State_3170_Desc = {
    Text = "Aplica o custo da impulsividade"
  },
  State_3170_Name = {
    Text = "Aplica o custo da impulsividade"
  },
  State_3170_WeaponDesc = {
    Text = "Aplica o custo da impulsividade"
  },
  State_3171_Name = {
    Text = "Estado@fase2_1batalha3bolha1"
  },
  State_3172_Desc = {
    Text = "Cada vez que causa dano, ganha [StateArg1] pontos de força temporária, até [StateArg2] vezes. Ao atingir o máximo, o efeito dobra"
  },
  State_3172_Name = {
    Text = "Seixo Ensanguentado da Criação"
  },
  State_3174_Desc = {
    Text = "Limite de Vida reduzido em 30%"
  },
  State_3174_Name = {
    Text = "Sextante de Criação 2"
  },
  State_3174_WeaponDesc = {
    Text = "Limite de Vida reduzido em 30%"
  },
  State_3175_Desc = {
    Text = "No início de cada turno, todos os despertos ganham 10 de loucura"
  },
  State_3175_Name = {
    Text = "Sextante de Criação 1"
  },
  State_3175_WeaponDesc = {
    Text = "No início de cada turno, todos os despertos ganham 10 de loucura"
  },
  State_3176_Desc = {
    Text = "Reiniciar Baralho do Prólogo 0_1_1_1"
  },
  State_3176_Name = {
    Text = "Reiniciar Baralho do Prólogo 0_1_1_1_2"
  },
  State_3176_WeaponDesc = {
    Text = "Reiniciar Baralho do Prólogo 0_1_1_1"
  },
  State_3177_Desc = {
    Text = "Quando a \"Alerta\" atingir 3 pilhas, recue e convoque uma \"Escultura de Cera de Isca\". As pilhas são redefinidas no início do turno."
  },
  State_3177_Name = {
    Text = "Vigilância"
  },
  State_3177_WeaponDesc = {
    Text = "Quando a \"Alerta\" atingir 3 pilhas, recue e convoque uma \"Escultura de Cera de Isca\". As pilhas são redefinidas no início do turno."
  },
  State_3178_Desc = {
    Text = "Aumenta o consumo de poder da carta"
  },
  State_3178_Name = {
    Text = "<SlowIconKeywords: Retardo>"
  },
  State_3178_WeaponDesc = {
    Text = "Cada camada de lentidão aumenta o custo de aritmética das cartas em 1 ponto"
  },
  State_3179_Desc = {
    Text = "Ao início da batalha, ganhe 20 escudos. Se houver escudos no início de cada turno, o escudo e a cura nesta rodada aumentam em 50%"
  },
  State_3179_Name = {
    Text = "Guardião do Jardim Alienado"
  },
  State_3179_WeaponDesc = {
    Text = "Ao início da batalha, ganhe 20 escudos. Se houver escudos no início de cada turno, o escudo e a cura nesta rodada aumentam em 50%"
  },
  State_3180_Desc = {
    Text = "Taxa crítica aumenta em 25%. Após causar recuperação de vida, há uma chance de causar 1 recuperação de vida adicional, com probabilidade igual à taxa crítica do causador"
  },
  State_3180_Name = {
    Text = "Estado@chave de prata dos sonhos: cura crítica"
  },
  State_3181_Name = {
    Text = "Taxa de Crítico"
  },
  State_3183_Desc = {
    Text = "Neste turno, dano crítico aumenta [Layer] %"
  },
  State_3183_Name = {
    Text = "Dano Crítico Temporário"
  },
  State_3185_Desc = {
    Text = "Aumentar a pressão adicional ao se mover"
  },
  State_3185_Name = {
    Text = "Bolsa Sem Fundo da Criação 2"
  },
  State_3185_WeaponDesc = {
    Text = "Aumentar a pressão adicional ao se mover"
  },
  State_3189_Name = {
    Text = "Força Atrasada do Monstro"
  },
  State_3190_Name = {
    Text = "Chave da Criação"
  },
  State_3193_Desc = {
    Text = "No início do próximo turno, ganhe [Layer] de escudo"
  },
  State_3193_Name = {
    Text = "Arte Perdida"
  },
  State_3193_WeaponDesc = {
    Text = "No início do próximo turno, ganhe [Layer] de escudo"
  },
  State_3196_Desc = {
    Text = "Após jogar, ganhe [StateArg1] pontos de aritmética"
  },
  State_3196_Name = {
    Text = "<Rune_4_High:Planejamento Avançado>"
  },
  State_3196_WeaponDesc = {
    Text = "Após jogar, ganhe [StateArg1] pontos de aritmética"
  },
  State_3197_Desc = {
    Text = "\"Strike\" restaura [Arg1] Vida e reduz pela metade suas pilhas de Sangrando e Veneno."
  },
  State_3197_Name = {
    Text = "Pinça hemostática"
  },
  State_3200_Desc = {
    Text = "Equipe Única: O dano básico e o escudo causado pelo portador aumentam em <WeaponEffect_Num:[StateArg1]%. No início da exploração, adicione uma carta \"Golpe\" e \"Defesa\" do portador ao baralho. Após disparar \"Defesa\", a taxa de crítico e o dano crítico da próxima \"Golpe\" do portador aumentam em 15%. Após disparar \"Golpe\", o escudo da próxima \"Defesa\" do portador aumenta em 15%, podendo ser empilhado até 3 vezes."
  },
  State_3200_WeaponDesc = {
    Text = "O dano básico causado pelo portador e o escudo aumentam em <WeaponEffect_Num:[StateArg1]%. No início da exploração, adicione uma carta \"Golpe\" e \"Defesa\" do portador ao baralho. Após jogar \"Defesa\", a taxa crítica e o dano crítico da próxima carta \"Golpe\" do portador aumentam em 15%. Após jogar \"Golpe\", o escudo da próxima carta \"Defesa\" do portador aumenta em 15%, acumulando até 3 vezes."
  },
  State_3201_Name = {
    Text = "Corrente de ressentimento"
  },
  State_3203_Desc = {
    Text = "Equipe Única: O Escudo causado pelo Portador aumenta em <WeaponEffect_Num:[StateArg3]%>. A \"Defesa\" do Portador causa <IntoxicationIconKeywords:Envenenamento> equivalente a <WeaponEffect_Num:[StateArg1]%> da Defesa do Portador ao inimigo com mais Vida. Se o Domínio atual for \"Carne\", ao aplicar <IntoxicationIconKeywords:Envenenamento>, <EmbryoFusionIconKeywords:Fusão de embriões> + <WeaponEffect_Num:[Blood:StateArg2]>; este efeito pode ser ativado no máximo 3 vezes por turno."
  },
  State_3203_WeaponDesc = {
    Text = "O Escudo causado pelo Portador aumenta em <WeaponEffect_Num:[StateArg3]%>. A \"Defesa\" do Portador causa <WeaponEffect_Num:[Poison:DescArg1]> camadas de <IntoxicationIconKeywords:Envenenamento> ao inimigo com mais Vida. Se o Domínio atual for \"Carne\", ao aplicar <IntoxicationIconKeywords:Envenenamento>, <EmbryoFusionIconKeywords:Fusão de embriões> +<WeaponEffect_Num:[Blood:StateArg2]>; este efeito pode ser ativado no máximo 3 vezes por turno."
  },
  State_3204_Desc = {
    Text = "Ao causar dano real, embaralhe [StateArg1] cartas \"feridas\" no baralho de puxar"
  },
  State_3204_Name = {
    Text = "Lesão por corte"
  },
  State_3204_WeaponDesc = {
    Text = "Ao comprá-lo, fique vulnerável por 1 rodada. Após o uso, fique vulnerável a todos os inimigos por 1 rodada. Não pode ser vendido"
  },
  State_3206_Desc = {
    Text = "Sempre que jogar 1 carta, aumente a taxa crítica deste turno em [StateArg1]%, acumulando até [StateArg2] vezes. Quando o número de camadas estiver completo, o efeito é dobrado"
  },
  State_3206_Name = {
    Text = "Espelho Ritual de Mênfis da Criação"
  },
  State_3206_WeaponDesc = {
    Text = "Sempre que jogar 1 carta, aumente a taxa crítica deste turno em [StateArg1]%, acumulando até [StateArg2] vezes. Quando o número de camadas estiver completo, o efeito é dobrado"
  },
  State_3207_Desc = {
    Text = "Ao perder 1 de vida, remova 1 camada. Ao zerar, ganhe [DescArg1] de escudo"
  },
  State_3207_Name = {
    Text = "Barreira dimensional"
  },
  State_3208_Desc = {
    Text = "Petrificado, incapaz de agir, removido no final do turno"
  },
  State_3208_Name = {
    Text = "<PetrifactionColour:Petrificar>"
  },
  State_3209_Name = {
    Text = "Extração de Vida dos Acessórios"
  },
  State_3209_WeaponDesc = {
    Text = "No início da batalha, se o portador for da classe Carne, ataque +25%"
  },
  State_3210_Name = {
    Text = "Estado@grande lâmina da vingança iluminar 1"
  },
  State_3211_Desc = {
    Text = "Limite de cartas +2, não descarte cartas no fim do turno. Ao perder vida, descarte 2 cartas aleatórias"
  },
  State_3212_Desc = {
    Text = "Dano ativo e Dano de tentáculo causados -25%, remove 1 capa no fim do turno."
  },
  State_3212_Name = {
    Text = "<WeaknessIconKeywords: Fraqueza>"
  },
  State_3212_WeaponDesc = {
    Text = "Todo dano reduzido em 25%"
  },
  State_3213_Desc = {
    Text = "Escudo e cura têm seu efeito aumentado em [Layer]%"
  },
  State_3213_Name = {
    Text = "Escudo temporário e cura eficaz"
  },
  State_3213_WeaponDesc = {
    Text = "Escudo e cura têm seu efeito aumentado em [Layer]%"
  },
  State_3215_Name = {
    Text = "Pêndulo Temporal \"Oculto\""
  },
  State_3216_Desc = {
    Text = "Ao final da batalha, ganha adicionalmente 100 selos negros, mas recebe uma carta de sintoma"
  },
  State_3216_Name = {
    Text = "Anel da Sorte da Criação"
  },
  State_3216_WeaponDesc = {
    Text = "Ao final da batalha, ganha adicionalmente 100 selos negros, mas recebe uma carta de sintoma"
  },
  State_3220_Desc = {
    Text = "Após liberar a exaltação, compre 1 cartão. Se a vida estiver abaixo de 25%, compre um cartão adicional"
  },
  State_3223_Desc = {
    Text = "Efeito de fraqueza aumentado em 10%. A cada 3 turnos, adiciona 1 camada de fraqueza a todos os inimigos"
  },
  State_3224_Name = {
    Text = "Relíquia Arcanum gravação aritmética"
  },
  State_3225_Name = {
    Text = "Golpe de pescoço"
  },
  State_3226_Desc = {
    Text = "Após jogar, a carta não irá para a pilha de descarte e não poderá ser usada novamente nesta batalha"
  },
  State_3226_Name = {Text = "Consumo"},
  State_3226_WeaponDesc = {
    Text = "Após jogar, a carta não irá para a pilha de descarte e não poderá ser usada novamente nesta batalha"
  },
  State_3227_Desc = {
    Text = "Preço de todas as criações reduzido em 50%"
  },
  State_3227_Name = {
    Text = "Medalha de Comércio da Criação"
  },
  State_3227_WeaponDesc = {
    Text = "Preço de todas as criações reduzido em 50%"
  },
  State_3228_Desc = {
    Text = "No início do turno, o despertar com menos loucura ganha 25 de loucura"
  },
  State_3228_Name = {
    Text = "Loucura Arcana da Criação"
  },
  State_3228_WeaponDesc = {
    Text = "No início do turno, o despertar com menos loucura ganha 25 de loucura"
  },
  State_3229_Desc = {
    Text = "Reiniciar Baralho do Prólogo 0_1_1_1"
  },
  State_3229_Name = {
    Text = "Reiniciar Baralho do Prólogo 0_1_1_1"
  },
  State_3229_WeaponDesc = {
    Text = "Reiniciar Baralho do Prólogo 0_1_1_1"
  },
  State_3230_Name = {
    Text = "Estado @ o atraso de poder de cartas gerais"
  },
  State_3232_Desc = {
    Text = "Estado@monstroSlotDimensional"
  },
  State_3232_Name = {
    Text = "Estado@monstroSlotDimensional"
  },
  State_3232_WeaponDesc = {
    Text = "Estado@monstroSlotDimensional"
  },
  State_3234_Desc = {
    Text = "No início da batalha, ganhe 3 pontos de força, mas o dano recebido aumenta em 5"
  },
  State_3234_Name = {
    Text = "Costas à água"
  },
  State_3235_Desc = {
    Text = "No início da batalha, ganhe [Layer] pontos de força, mas o dano recebido aumenta em 5"
  },
  State_3235_Name = {
    Text = "Costas à água"
  },
  State_3236_Desc = {
    Text = "Jogue para dar aos outros Despertados [StateArg1] Loucura"
  },
  State_3236_Name = {
    Text = "<Rune_16_High:Catalisar Avançado>"
  },
  State_3237_Desc = {
    Text = "A cada 3 turnos, ganha 3 tentáculos que ignoram o limite e são removidos no final do turno"
  },
  State_3238_Desc = {
    Text = "No início da batalha, aplique estado de aumento de dano recebido aos monstros"
  },
  State_3238_Name = {
    Text = "No início da batalha, aplique estado de aumento de dano recebido aos monstros"
  },
  State_3238_WeaponDesc = {
    Text = "No início da batalha, aplique estado de aumento de dano recebido aos monstros"
  },
  State_3239_Desc = {
    Text = "Aumenta [Layer] pontos de ataque"
  },
  State_3239_Name = {
    Text = "Aumento de Ataque Geral"
  },
  State_3239_WeaponDesc = {
    Text = "Aumenta [Layer] pontos de ataque"
  },
  State_3242_Name = {
    Text = "Adicione 2 <DerivativeCardKeywords_4:\"Inspiração\"> cartões ao monte de compra."
  },
  State_3243_Desc = {
    Text = "Poder de Cálculo de Carta Aumentado"
  },
  State_3243_Name = {
    Text = "Poder de Cálculo de Carta Aumentado"
  },
  State_3243_WeaponDesc = {
    Text = "Poder de Cálculo de Carta Aumentado"
  },
  State_3244_Desc = {
    Text = "A vida dos monstros invocados dobra"
  },
  State_3244_Name = {
    Text = "\"Fluxo transversal de vergonha\""
  },
  State_3244_WeaponDesc = {
    Text = "A vida dos monstros invocados dobra"
  },
  State_3245_Desc = {
    Text = "Ao início da batalha, a taxa crítica de nossa equipe diminui em 30%, enquanto o dano crítico aumenta em 30%"
  },
  State_3245_Name = {Text = "Inibição"},
  State_3245_WeaponDesc = {
    Text = "Ao início da batalha, a taxa crítica de nossa equipe diminui em 30%, enquanto o dano crítico aumenta em 30%"
  },
  State_3246_Desc = {
    Text = "No início da batalha, a vida dos inimigos normais aumenta em 30%; após a vitória na batalha, forneça 25 o sigilo negro adicionais"
  },
  State_3246_Name = {
    Text = "Bandeira de Batalha Quebrada da Criação"
  },
  State_3246_WeaponDesc = {
    Text = "No início da batalha, a vida dos inimigos normais aumenta em 30%; após a vitória na batalha, forneça 25 o sigilo negro adicionais"
  },
  State_3247_Desc = {
    Text = "[Exaltar] Reduza o custo de Aritmética de todos os cartões em 1."
  },
  State_3247_Name = {
    Text = "Luz da Civilização Mutante"
  },
  State_3247_WeaponDesc = {
    Text = "[Exaltar] Reduza o custo de Aritmética de todos os cartões em 1."
  },
  State_3249_Desc = {
    Text = "Outros aliados ganham 1 pilha de Loucura, que é removida com a morte desta unidade."
  },
  State_3249_Name = {Text = "Agitação"},
  State_3249_WeaponDesc = {
    Text = "Outros aliados ganham 1 camada de loucura, removida após sua morte"
  },
  State_3250_Desc = {
    Text = "Permanece no baralho após o combate, mas será removida permanentemente ao ser Disparada ou consumida."
  },
  State_3250_Name = {
    Text = "<DestructionKeywords:Destruir>"
  },
  State_3250_WeaponDesc = {
    Text = "Jogue para removê-la permanentemente"
  },
  State_3251_Desc = {
    Text = "Ao receber Dano ativo ou Dano de tentáculo, torna-se imune ao dano e perde 1 carga. Removido no início do turno."
  },
  State_3251_Name = {
    Text = "<ParcloseColour:Barreira Temporária>"
  },
  State_3252_Desc = {
    Text = "A flor de lodo aplica escudo, aumentando a saúde máxima em [StateArg2]"
  },
  State_3252_Name = {
    Text = "Acumulação de muco"
  },
  State_3252_WeaponDesc = {
    Text = "A flor de lodo aplica escudo, aumentando a saúde máxima em [StateArg2]"
  },
  State_3253_Desc = {
    Text = "Obtém [StateArg1] pontos de alerta temporário"
  },
  State_3253_Name = {
    Text = "<CardKeyWord:Arma Mecânica - Escudo>"
  },
  State_3253_WeaponDesc = {
    Text = "Obtém [StateArg1] pontos de alerta temporário"
  },
  State_3255_Name = {
    Text = "Contrataque"
  },
  State_3256_Name = {
    Text = "Estado@MaldiçãoExcitação"
  },
  State_3259_Desc = {
    Text = "Aumenta as instâncias de Dano ativo causado em [Layer]."
  },
  State_3259_Name = {
    Text = "<MadnessColour:Loucura>"
  },
  State_3260_Desc = {
    Text = "Quando o espaço ultradimensional atinge o limite, você ganha um turno extra, sem puxar cartas neste turno, mas colocando as cartas de espaço ultradimensional na mão"
  },
  State_3260_Name = {
    Text = "<DimensionalSpaceIconKeywords:Espaço dimensional>"
  },
  State_3260_WeaponDesc = {
    Text = "Quando o espaço ultradimensional atinge o limite, você ganha um turno extra ultrapassado, colocando todas as cartas de espaço ultradimensional na mão"
  },
  State_3261_Desc = {
    Text = "Os monstros invocados causam dano dobrado"
  },
  State_3261_Name = {
    Text = "\"Legião de Esculturas de Cera\""
  },
  State_3261_WeaponDesc = {
    Text = "Os monstros invocados causam dano dobrado"
  },
  State_3262_Desc = {
    Text = "Estado@RevestimentoDeCeraEquipe"
  },
  State_3262_Name = {
    Text = "Estado@RevestimentoDeCeraEquipe"
  },
  State_3262_WeaponDesc = {
    Text = "Estado@RevestimentoDeCeraEquipe"
  },
  State_3263_Name = {
    Text = "Estado@NautilusConchaContra-ataque"
  },
  State_3264_Name = {
    Text = "Garantizado"
  },
  State_3265_Name = {
    Text = "Descarte e remova"
  },
  State_3266_Desc = {
    Text = "Salto de fortalecimento da Cidade dos Sonhos Mortos"
  },
  State_3266_Name = {
    Text = "Estado@metrópole dos sonhos morte fortalecer salto"
  },
  State_3267_Desc = {
    Text = "No início da batalha, ganhe 5 camadas de [Armadura de Cera]."
  },
  State_3267_Name = {
    Text = "\"Senhor Cera\""
  },
  State_3267_WeaponDesc = {
    Text = "No início da batalha, ganhe 5 camadas de [Armadura de Cera]."
  },
  State_3268_Desc = {
    Text = "Ao iniciar a rodada, compre 1 carta. Sempre que você comprar uma carta, altere aleatoriamente seu custo de aritmética (0-4)"
  },
  State_3268_Name = {
    Text = "Caleidoscópio de Criação"
  },
  State_3268_WeaponDesc = {
    Text = "Ao iniciar a rodada, compre 1 carta. Sempre que você comprar uma carta, altere aleatoriamente seu custo de aritmética (0-4)"
  },
  State_3269_Desc = {
    Text = "Após obter o 2º escudo em cada turno, ganha [Arg1] camadas de contra-ataque. Após obter o 4º escudo em cada turno, causa 1 dano de contra-ataque a todos os inimigos"
  },
  State_3269_Name = {
    Text = "Verdade desvendada"
  },
  State_3270_Name = {
    Text = "Estado@Capítulo2ResonânciaCópia"
  },
  State_3271_Desc = {
    Text = "[ataque] aplica [Arg1] níveis de veneno a todos os inimigos"
  },
  State_3272_Desc = {
    Text = "Ao causar dano não bloqueado, restaura vida igual a 3 vezes o dano real, removido ao causar dano"
  },
  State_3272_Name = {Text = "Vampirismo"},
  State_3273_Desc = {
    Text = "Equipe única: Após jogar as cartas do portador, ganha um escudo equivalente à defesa do portador de <WeaponEffect_Num:[StateArg1]%>. Para cada tentáculo, o escudo aumenta a defesa do portador em <WeaponEffect_Num:[StateArg2]%>. Esse efeito só se aplica uma vez por rodada"
  },
  State_3273_Name = {
    Text = "Morte da Sra. Coral"
  },
  State_3273_WeaponDesc = {
    Text = "Após jogar a carta do portador, ganhe um escudo de <WeaponEffect_Num:[Block:DescArg1]>, e para cada tentáculo, o escudo aumenta <WeaponEffect_Num:[DescArg2]>. Este efeito só pode ser ativado uma vez por turno"
  },
  State_3274_Desc = {
    Text = "Ao receber dano ativo, adiciona uma camada de contagem à equipe"
  },
  State_3274_Name = {
    Text = "Estado@grande lâmina da vingança contagem da equipe"
  },
  State_3274_WeaponDesc = {
    Text = "Ao receber dano ativo, adiciona uma camada de contagem à equipe"
  },
  State_3277_Desc = {
    Text = "Jogue para o Despertado ganhar [StateArg1] de Loucura"
  },
  State_3277_Name = {
    Text = "<Rune_5:Fúria>"
  },
  State_3280_Name = {
    Text = "Espada do Destino"
  },
  State_3281_Desc = {
    Text = "Aumentar o dano ativo causado"
  },
  State_3281_Name = {
    Text = "<PowerIconKeywords:Força>"
  },
  State_3281_WeaponDesc = {
    Text = "Dano aumentado"
  },
  State_3282_Desc = {
    Text = "Número de Dano e Aumento de Dano"
  },
  State_3282_Name = {
    Text = "<CardKeyWord:Upgrade>"
  },
  State_3282_WeaponDesc = {
    Text = "Aumenta um dano"
  },
  State_3283_Desc = {
    Text = "No início de cada turno, recupera [StateArg1] de vida. Se a vida estiver abaixo de 50%, a recuperação aumenta para [StateArg2]"
  },
  State_3283_Name = {
    Text = "Elixir de Incenso de Criação"
  },
  State_3283_WeaponDesc = {
    Text = "No início de cada turno, recupera [StateArg1] de vida. Se a vida estiver abaixo de 50%, a recuperação aumenta para [StateArg2]"
  },
  State_3287_Desc = {
    Text = "No início da batalha, adicione 2 cartas de \"Inspiração\" ao seu baralho. Cada batalha vencida melhora esta criação, até um máximo de 3 vezes"
  },
  State_3288_Desc = {
    Text = "Estado@EstadoVazio"
  },
  State_3288_Name = {
    Text = "Estado@EstadoVazio"
  },
  State_3288_WeaponDesc = {
    Text = "Estado@EstadoVazio"
  },
  State_3289_Desc = {
    Text = "A cada 1 ponto de dano, diminui 1 camada. Quando o número de camadas chega a 0, substitua a intenção pela Flor da Eternidade e utilize um conjunto de habilidades voltadas para defesa"
  },
  State_3289_Name = {
    Text = "Flor Imortal"
  },
  State_3289_WeaponDesc = {
    Text = "Cada ponto de dano recebido reduz uma camada. Quando as camadas chegam a 0, muda para modo de defesa"
  },
  State_3290_Desc = {
    Text = "A estranha que antes era chamada de \"Miryam\" caiu em um estado extremo de obsessão e desespero, quebrando sua última ilusão, encerrando milhares de anos de loucura"
  },
  State_3290_Name = {Text = "Delírio"},
  State_3291_Desc = {
    Text = "Ao causar dano real, a equipe perde 3 de força temporária"
  },
  State_3291_Name = {Text = "Paralisia"},
  State_3292_Desc = {
    Text = "Ao liberar a exaltação, para cada dano que o inimigo está prestes a causar, aplique [Arg1] camadas de veneno"
  },
  State_3293_Desc = {
    Text = "Dano reduzido em [Layer] pontos nesta fase"
  },
  State_3293_Name = {
    Text = "Redução de força"
  },
  State_3293_WeaponDesc = {
    Text = "Dano e dano de tentáculo reduzidos em [Layer] pontos nesta fase"
  },
  State_3294_Name = {
    Text = "Estado@MaldiçãoParanoia"
  },
  State_3296_Desc = {
    Text = "Remova ao descartar ou jogar"
  },
  State_3296_Name = {
    Text = "Remova ao descartar ou jogar"
  },
  State_3296_WeaponDesc = {
    Text = "Ao comprá-lo, fique vulnerável por 1 rodada. Após o uso, fique vulnerável a todos os inimigos por 1 rodada. Não pode ser vendido"
  },
  State_3297_Desc = {
    Text = "Estado@RainhaDosEspinhosDespertar_Forma"
  },
  State_3297_Name = {
    Text = "Estado@RainhaDosEspinhosDespertar_Forma"
  },
  State_3297_WeaponDesc = {
    Text = "Estado@RainhaDosEspinhosDespertar_Forma"
  },
  State_3298_Desc = {
    Text = "Neste turno, o próximo efeito de salto será garantido"
  },
  State_3298_Name = {
    Text = "Salto sempre será ativado"
  },
  State_3298_WeaponDesc = {
    Text = "Neste turno, efeito de salto não precisa de condições"
  },
  State_3301_Name = {
    Text = "Contagem do Vinho das Estrelas"
  },
  State_3302_Desc = {
    Text = "Aplica congelamento eterno"
  },
  State_3302_Name = {
    Text = "Aplica congelamento eterno"
  },
  State_3302_WeaponDesc = {
    Text = "Aplica congelamento eterno"
  },
  State_3304_Desc = {
    Text = "No final do turno, o Despertado que jogou a última carta de comando ganha 15 de Loucura. Se possuir a \"Estátua da Mãe\", outros Despertados ganham 5 de Loucura"
  },
  State_3305_Desc = {
    Text = "Após jogar, coloque [StateArg1] cartas de \"inspiração\" de volta no baralho de puxar. \"Inspiração\": ganha 1 de aritmética, puxe 1 carta, reservar, consumir"
  },
  State_3305_Name = {
    Text = "<Rune_17:Inspiração>"
  },
  State_3307_Name = {
    Text = "(Restante:[Layer])"
  },
  State_3308_Desc = {
    Text = "Ao iniciar a rodada, se o número de cartas restantes do último turno exceder 2, ganhe 2 aritméticas"
  },
  State_3309_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_3309_Name = {
    Text = "Estado@ProtótipoEspadaLongaResistência"
  },
  State_3310_Desc = {
    Text = "Quando o Migrante aplica um escudo, ganha [Energy:StateArg2] de loucura"
  },
  State_3310_Name = {
    Text = "Auto-bloqueio"
  },
  State_3310_WeaponDesc = {
    Text = "Quando o Migrante aplica um escudo, ganha [Energy:StateArg2] de loucura"
  },
  State_3312_Desc = {
    Text = "Sempre que você recuperar vida, ganha [Arg1] pontos de contra-ataque; se a vida for maior que 75%, ganha [Arg2] pontos de contra-ataque extras"
  },
  State_3313_Desc = {
    Text = "Ao iniciar a rodada, otorgue [Arg1] pontos de poder nesta rodada; a cada carta jogada, perca [Arg2] pontos de poder nesta rodada"
  },
  State_3314_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_3314_Name = {
    Text = "Ainda não despertado"
  },
  State_3315_Desc = {
    Text = "Após jogar a primeira carta de cada rodada, transforme 2 cartas aleatórias da mão em cópias da sua versão original, restaurando no final da rodada"
  },
  State_3315_Name = {
    Text = "Sino do Encantamento da Criação"
  },
  State_3316_Desc = {
    Text = "No final do turno, o escudo é mantido"
  },
  State_3316_Name = {
    Text = "Proteção Guardiã"
  },
  State_3316_WeaponDesc = {
    Text = "No final do turno, o escudo é mantido"
  },
  State_3317_Desc = {
    Text = "No fim do turno, perde todo o escudo"
  },
  State_3317_Name = {
    Text = "Grilhetas: Pai biológico"
  },
  State_3318_Name = {
    Text = "Estado@sedento por sangue abraço devorador marcador"
  },
  State_3323_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_3323_Name = {
    Text = "Estado@ProtótipoEspadaLongaLoucura"
  },
  State_3324_Desc = {
    Text = "Neste turno, dano crítico aumenta [Layer] %"
  },
  State_3324_Name = {
    Text = "Dano Crítico Temporário"
  },
  State_3324_WeaponDesc = {
    Text = "Neste turno, dano crítico aumenta [Layer] %"
  },
  State_3325_Desc = {
    Text = "A cada vez que reiniciar o baralho, adicione 2 \"tridentes\" que obtiveram [Arg1] pontos de poder e 1 \"guarda-chuva\" que obteve [Arg2] pontos de alerta à sua mão"
  },
  State_3326_Desc = {
    Text = "Imune ao primeiro dano ativo a cada turno"
  },
  State_3326_Name = {Text = "Firmemente"},
  State_3326_WeaponDesc = {
    Text = "Imune ao primeiro dano ativo a cada turno"
  },
  State_3327_Desc = {
    Text = "Vida do Monstro antes da Morte"
  },
  State_3327_Name = {
    Text = "HP do monstro antes de morrer"
  },
  State_3327_WeaponDesc = {
    Text = "Vida do Monstro antes da Morte"
  },
  State_3328_Desc = {
    Text = "Nesta batalha, ao sofrer dano fatal, revive uma vez e recupera [Layer] pontos de vida, não pode ser dissipado."
  },
  State_3328_Name = {
    Text = "Pássaro do Paraíso Imortal"
  },
  State_3329_Desc = {
    Text = "Sempre que jogar 5 cartas, obtém uma cópia da carta mais à esquerda em sua mão, mas adiciona ilusão e exaustão"
  },
  State_3330_Desc = {
    Text = "O consumo aritmético da carta aumenta em [Layer] pontos. Este efeito negativo será removido após jogar a carta"
  },
  State_3330_Name = {
    Text = "<SlowColour:Retardo [Camada]>"
  },
  State_3330_WeaponDesc = {
    Text = "O consumo aritmético da carta aumenta em [Layer] pontos"
  },
  State_3332_Desc = {
    Text = "Ao receber Dano ativo ou Dano de tentáculo, fica imune ao Dano e perde 1 capa."
  },
  State_3332_Name = {
    Text = "<ParcloseColour:Barreira>"
  },
  State_3335_Desc = {
    Text = "No início da batalha, aplique 1 camada de Vulnerável a todos os inimigos. \"Maldição de Torpor\" aumenta o efeito de Vulnerável sobre os inimigos em 25%."
  },
  State_3335_Name = {
    Text = "Olho de Pedra, Iluminar 6"
  },
  State_3336_Name = {
    Text = "Estado @George@ tratamento ao morrer"
  },
  State_3337_Name = {
    Text = "Rito Vermelho"
  },
  State_3339_Desc = {
    Text = "Aumenta [Layer] pontos de ataque"
  },
  State_3339_Name = {
    Text = "Aumento temporário de ataque"
  },
  State_3339_WeaponDesc = {
    Text = "Aumenta [Layer] pontos de ataque"
  },
  State_3340_Desc = {
    Text = "Após liberar a exaltação, aumente o dano da exaltação na batalha atual em [Arg1], até um máximo de 5 vezes. Quando estiver totalmente acumulado, o despertador que liberou essa exaltação ganha 100 de aliemus"
  },
  State_3341_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_2_1"
  },
  State_3341_Name = {
    Text = "Estado@prologoResetarBaralho0_1_2_1"
  },
  State_3341_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_2_1"
  },
  State_3342_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_2_2"
  },
  State_3342_Name = {
    Text = "Estado@prologoResetarBaralho0_1_2_2"
  },
  State_3342_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_2_2"
  },
  State_3343_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_2_3"
  },
  State_3343_Name = {
    Text = "Estado@prologoResetarBaralho0_1_2_3"
  },
  State_3343_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_2_3"
  },
  State_3344_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_2_4"
  },
  State_3344_Name = {
    Text = "Estado@prologoResetarBaralho0_1_2_4"
  },
  State_3344_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_2_4"
  },
  State_3345_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_2_5"
  },
  State_3345_Name = {
    Text = "Estado@prologoResetarBaralho0_1_2_5"
  },
  State_3345_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_2_5"
  },
  State_3346_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_2_5"
  },
  State_3346_Name = {
    Text = "Estado@prologoResetarBaralho0_1_2_5"
  },
  State_3346_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_2_6"
  },
  State_3347_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_2_5"
  },
  State_3347_Name = {
    Text = "Estado@prologoResetarBaralho0_1_2_5"
  },
  State_3347_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_2_7"
  },
  State_3348_Desc = {
    Text = "Jogue para comprar [StateArg1] cartas"
  },
  State_3348_Name = {
    Text = "<Rune_3_High:Destreza Avançada>"
  },
  State_3348_WeaponDesc = {
    Text = "Jogue para comprar [StateArg1] cartas"
  },
  State_3350_Desc = {
    Text = "Após liberar a exaltação, perca 10% da vida atual e roube [Arg1] pontos de poder de todos os inimigos neste turno"
  },
  State_3351_Name = {
    Text = "Estado@adicionarAoBaralho"
  },
  State_3352_Name = {
    Text = "Astrolábio do Livro Secreto da Criação 1"
  },
  State_3354_Name = {
    Text = "Astrolábio do Livro Secreto da Criação 2"
  },
  State_3356_Name = {
    Text = "Fim do turno: Envenenamento por Asfixia"
  },
  State_3357_Desc = {
    Text = "No início do próximo turno, dano de tentáculo +[Layer]"
  },
  State_3357_Name = {
    Text = "Dano de tentáculo retardado"
  },
  State_3358_Desc = {
    Text = "No início do próximo turno, ganhe [Layer] pontos de escudo"
  },
  State_3358_Name = {
    Text = "Arte perdida - Escudo"
  },
  State_3359_Desc = {
    Text = "A cada 3 cartas que você joga, o efeito ocorre 2 vezes"
  },
  State_3359_Name = {
    Text = "Vinho das Estrelas da Criação"
  },
  State_3359_WeaponDesc = {
    Text = "A cada 3 cartas que você joga, o efeito ocorre 2 vezes"
  },
  State_3360_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_4_1"
  },
  State_3360_Name = {
    Text = "Estado@prologoResetarBaralho0_1_4_1"
  },
  State_3360_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_4_1"
  },
  State_3362_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_4_1"
  },
  State_3362_Name = {
    Text = "Estado@prologoResetarBaralho0_1_4_1"
  },
  State_3362_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_4_1"
  },
  State_3364_Desc = {
    Text = "Ao coletar, escolha uma carta e atribua a ela dois efeitos de fortalecimento de três opções. (Nota: semelhante a mil miragens.)"
  },
  State_3365_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_4_1"
  },
  State_3365_Name = {
    Text = "Estado@prologoResetarBaralho0_1_4_1"
  },
  State_3365_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_4_1"
  },
  State_3366_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_4_1"
  },
  State_3366_Name = {
    Text = "Estado@prologoResetarBaralho0_1_4_1"
  },
  State_3366_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_4_1"
  },
  State_3368_Desc = {
    Text = "Se o consumo de aritmética na fase de descarte for maior que 5, ele se tornará pedra"
  },
  State_3368_Name = {
    Text = "Petrificação"
  },
  State_3368_WeaponDesc = {
    Text = "Transforme as cartas em pedras antes da fase de descarte"
  },
  State_3369_Desc = {
    Text = "Todos os seus efeitos devoradores se tornam devoração infinita"
  },
  State_3369_Name = {
    Text = "Devorar sem limites"
  },
  State_3369_WeaponDesc = {
    Text = "Todos os seus efeitos devoradores se tornam devoração infinita"
  },
  State_3370_Desc = {
    Text = "Escudo reduzido em [Layer] pontos nesta fase"
  },
  State_3370_Name = {
    Text = "Redução Permanente de Alerta"
  },
  State_3370_WeaponDesc = {
    Text = "Escudo reduzido em [Layer] pontos nesta fase"
  },
  State_3372_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_3372_Name = {
    Text = "Ainda não despertado"
  },
  State_3373_Desc = {
    Text = "Ao causar dano real, embaralhe [StateArg1] cartas \"feridas\" no baralho de puxar"
  },
  State_3373_Name = {Text = "asfixia"},
  State_3373_WeaponDesc = {
    Text = "Ao comprá-lo, fique vulnerável por 1 rodada. Após o uso, fique vulnerável a todos os inimigos por 1 rodada. Não pode ser vendido"
  },
  State_3374_Desc = {
    Text = "Após o fim do turno, ganha camadas equivalentes de força"
  },
  State_3374_Name = {Text = "raiva"},
  State_3376_Desc = {
    Text = "Durante esta batalha, o dano causado pela explosão de loucura aumenta em [Layer] pontos"
  },
  State_3376_Name = {
    Text = "Dano de Fúria Explosiva Aumentado"
  },
  State_3378_Desc = {
    Text = "Após liberar a exaltação, o próximo cartão jogado tem efeito 2 vezes"
  },
  State_3378_Name = {
    Text = "Estado@chaveDePrataSonho:explosao"
  },
  State_3379_Desc = {
    Text = "Vida abaixo de 50%, o Quebrador de Correntes entra em fúria"
  },
  State_3379_Name = {
    Text = "Momento da vingança"
  },
  State_3379_WeaponDesc = {
    Text = "Vida abaixo de 50%, o Quebrador de Correntes entra em fúria"
  },
  State_3380_Desc = {
    Text = "No início da batalha, embaralhe uma [Confusão] na sua pilha de compras."
  },
  State_3380_Name = {
    Text = "Encantamento"
  },
  State_3380_WeaponDesc = {
    Text = "No início da batalha, embaralhe uma [Confusão] na sua pilha de compras."
  },
  State_3381_Name = {
    Text = "Inicialização de Classe Superdimensional"
  },
  State_3382_Desc = {
    Text = "Ganhe uma missão. Complete a missão para receber recompensas. [Event Placeholder]"
  },
  State_3383_Name = {
    Text = "Inicialização de Classe Superdimensional"
  },
  State_3385_Desc = {
    Text = "O dano ativo e de tentáculo recebido é reduzido em 33%"
  },
  State_3385_Name = {
    Text = "Escudo Espelho"
  },
  State_3385_WeaponDesc = {
    Text = "O dano ativo e de tentáculo recebido é reduzido em 33%"
  },
  State_3386_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_3386_Name = {
    Text = "Estado@ProtótipoEspadaLongaCrítico"
  },
  State_3387_Name = {
    Text = "Estado@fase2_3batalha3bolha1"
  },
  State_3388_Desc = {
    Text = "Após jogar, ganhe [StateArg1] pontos de força"
  },
  State_3388_Name = {
    Text = "<Rune_14:força bruta>"
  },
  State_3389_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_3389_Name = {
    Text = "Ainda não despertado"
  },
  State_3390_Desc = {
    Text = "Ao início da batalha, aplica fraqueza e vulnerabilidade a todos os inimigos por 1 turno"
  },
  State_3392_Desc = {
    Text = "Gain [Arg1] Força ao ser coletado. Cada vez que um \"Embrião\" é fundido, ganhe [Arg2] Força nesta rodada."
  },
  State_3393_Desc = {
    Text = "Ao iniciar a rodada, Fusão de Embrião +30%. Todos os seus efeitos devoradores tornam-se devoração infinita"
  },
  State_3394_Name = {
    Text = "Adicione 1 <DerivativeCardKeywords_4:\"Inspiração\"> ao monte de compra"
  },
  State_3395_Desc = {
    Text = "Equipe Única: O dano base do \"Golpe\" do portador aumenta em 25%, e o escudo base da \"Defesa\" aumenta em 25%. Ao disparar o \"Golpe\" do portador, ganha <WeaponEffect_Num:[StateArg1]%> de <PowerIconKeywords:força> temporária igual à força de ataque do portador, e ao disparar a \"Defesa\" do portador, ganha <WeaponEffect_Num:[StateArg2]%> de <AlertIconKeywords:Alerta> temporária igual à defesa do portador. Se o domínio atual for \"Ultra\", ao entrar no turno Ultra, ganha uma vez <PowerIconKeywords:força> temporária e <AlertIconKeywords:Alerta> temporária."
  },
  State_3395_WeaponDesc = {
    Text = "O dano básico do \"golpe\" do portador aumenta em 25% e o escudo básico da \"defesa\" aumenta em 25%. Ao disparar o \"golpe\" do portador, ganha <WeaponEffect_Num:[Power:DescArg1]> pontos de <PowerIconKeywords:força> temporária; ao disparar a \"defesa\" do portador, ganha <WeaponEffect_Num:[DescArg2]> pontos de <AlertIconKeywords:alerta> temporária. Se o domínio atual for \"Ultra\", ao entrar no turno Ultra, ganha uma vez <PowerIconKeywords:força> temporária e <AlertIconKeywords:alerta> temporária."
  },
  State_3397_Desc = {
    Text = "Ao jogar a 10ª carta, aumente o dano de tentáculo em [Arg1] e faça todos os ataques de tentáculo 1 vez"
  },
  State_3400_Desc = {
    Text = "Vida máxima dos inimigos de elite e chefes reduzida em 20%"
  },
  State_3401_Desc = {
    Text = "Após jogar, ative-se adicionalmente [StateArg1] vezes, ganhando [StateArg2] pontos de sigilo negro, exausto, inato"
  },
  State_3401_Name = {
    Text = "<Rune_7:Eco>"
  },
  State_3402_Desc = {
    Text = "\"Picareta de Ferro\" O dano do golpe pesado de Lusen aumentou em [Layer]%."
  },
  State_3402_Name = {
    Text = "Dano de Golpe Pesado Aumentado"
  },
  State_3402_WeaponDesc = {
    Text = "Dano de Golpe Forte de Picareta de Ferro aumentado em [Layer] %"
  },
  State_3403_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_3403_Name = {
    Text = "Ainda não despertado"
  },
  State_3405_Name = {
    Text = "Todos os inimigos temporariamente reduzidos em [Power:StateArg1] pontos de <PowerIconKeywords:força>, escudo e <PowerIconKeywords:força> reduzidos em 50% por 1 turno"
  },
  State_3406_Name = {
    Text = "Obtenha [StateArg1] pontos de <PowerIconKeywords:força>"
  },
  State_3407_Name = {
    Text = "Escolha 1 cartão da pilha de draw e coloque na sua mão, fazendo seu custo aritmético -1"
  },
  State_3408_Name = {
    Text = "Ganha <Posse:[DescArg1]> energia de chave de prata. O dano base de \"Decapitação\" e \"Mil Miragens\" aumenta 10% nesta batalha"
  },
  State_3409_Name = {
    Text = "Escolha um Despertado para ganhar <Energy:[DescArg1]> de Loucura"
  },
  State_3410_Name = {
    Text = "Esta carta aumenta a taxa crítica e o dano crítico em 50%, causando dano perfurante"
  },
  State_3411_Name = {
    Text = "Imune a <FragileIconKeywords:frágil>, <WeaknessIconKeywords:fraqueza>, <VulnerabilityIconKeywords:vulnerável> por 1 turno. Ganha <Block:[Block:StateArg1]> de escudo"
  },
  State_3412_Desc = {
    Text = "Imune a estados negativos, reduz 1 camada no final do turno ou após ser criticado"
  },
  State_3412_Name = {
    Text = "camada de cera"
  },
  State_3412_WeaponDesc = {
    Text = "Cada camada reduz o dano recebido em 10%, reduzindo 1 camada ao ser criticado"
  },
  State_3415_Desc = {
    Text = "Ao pegar, escolha 1 de 3 marcas de corrupção. As marcas de corrupção são mais poderosas que as marcas normais, mas consomem cartões ao serem jogadas"
  },
  State_3415_Name = {
    Text = "Impressão de Jade da Criação"
  },
  State_3415_WeaponDesc = {
    Text = "Ao pegar, escolha 1 de 3 marcas de corrupção. As marcas de corrupção são mais poderosas que as marcas normais, mas consomem cartões ao serem jogadas"
  },
  State_3416_Desc = {
    Text = "Equipe Única: Após o início do combate, obtém Contrataque equivalente a <WeaponEffect_Num:[StateArg1]%> da Defesa do Portador. Após ativar <DeathResistanceIconKeywords: Resistência à Morte>, obtém no máximo 2 camadas de \"berço\" no total: o Escudo e a recuperação de Vida causados por todos os aliados aumentam em <WeaponEffect_Num:[StateArg2]%>; ao fim do turno, remove 1 camada. Se o Domínio atual for \"Carne\", após ativar <DeathResistanceIconKeywords: Resistência à Morte>, Fusão de embriões <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3416_WeaponDesc = {
    Text = "Após o início do combate, obtém <WeaponEffect_Num:[Counterattack:DescArg1]> camadas de Contrataque. Após ativar <DeathResistanceIconKeywords: Resistência à Morte>, obtém no máximo 2 camadas de \"berço\" no total: o Escudo e a recuperação de Vida causados por todos os aliados aumentam em <WeaponEffect_Num:[StateArg2]%>; ao fim do turno, remove 1 camada. Se o Domínio atual for \"Carne\", após ativar <DeathResistanceIconKeywords: Resistência à Morte>, Fusão de embriões <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3418_Desc = {
    Text = "Após o fim do turno, perde força temporária"
  },
  State_3418_Name = {
    Text = "Esgotamento retardado"
  },
  State_3419_Desc = {
    Text = "Ao pegar, exiba 3 cartões com marcas avançadas ou amaldiçoadas, escolha um para atribuir a marca correspondente"
  },
  State_3420_Desc = {
    Text = "A cada ação, causa sangramento; o tratamento pode reduzir a quantidade de camadas de sangramento pela metade"
  },
  State_3420_Name = {
    Text = "Salpicadura de sangre"
  },
  State_3420_WeaponDesc = {
    Text = "A cada ação, causa sangramento; o tratamento pode reduzir a quantidade de camadas de sangramento pela metade"
  },
  State_3421_Desc = {
    Text = "No início do turno, adiciona 1 cartão de \"tridente\" de força [Arg1] obtida neste turno à mão. Após liberar a exaltação, aumenta o poder de todos os \"tridentes\" na mão em [Arg2]"
  },
  State_3422_Name = {
    Text = "Estado@AcessórioRevelaçãoPura"
  },
  State_3422_WeaponDesc = {
    Text = "Após liberar a chave, recupera [DescArg1] vida. Se o nível de recarga de chave de prata do portador for maior que 20, recupera adicionalmente [DescArg1] vida. Efeitos semelhantes não podem ocorrer simultaneamente"
  },
  State_3423_Desc = {
    Text = "Proficiência do reino 100, causando dano e dano temporário de tentáculo"
  },
  State_3423_Name = {
    Text = "Pêndulo Temporal \"Pesadelo\""
  },
  State_3424_Desc = {
    Text = "Ao iniciar a rodada, se o número de cartas jogadas no último turno exceder 3, compre 2 cartas"
  },
  State_3425_Desc = {
    Text = "Quando a vida estiver abaixo de 50% ([StateArg1]), a intenção se transforma em \"sobrevivente em um impasse\": remove fragilidade, fraqueza e estado de veneno, causando 99 camadas de fraqueza e fragilidade ao nosso time"
  },
  State_3425_Name = {
    Text = "Momento da vingança"
  },
  State_3425_WeaponDesc = {
    Text = "Quando a vida estiver abaixo de 50% ([StateArg1]), a intenção se transforma em \"sobrevivente em um impasse\": remove fragilidade, fraqueza e estado de veneno, causando 99 camadas de fraqueza e fragilidade ao nosso time"
  },
  State_3429_Desc = {
    Text = "A cada ação, anexa sangramento; o tratamento pode remover o efeito de sangramento"
  },
  State_3429_Name = {
    Text = "Ferimento grave"
  },
  State_3429_WeaponDesc = {
    Text = "A cada ação, anexa sangramento; o tratamento pode remover o efeito de sangramento"
  },
  State_3430_Desc = {
    Text = "Após liberar a exaltação, ganhe [Arg1] pontos de ataque. Se for a sexta vez que ocorrer nesta batalha, dobre seu ataque"
  },
  State_3431_Name = {
    Text = "Imunidade a envenenamento"
  },
  State_3432_Desc = {
    Text = "Consuma ao descartar"
  },
  State_3432_Name = {
    Text = "Custo de descarte"
  },
  State_3432_WeaponDesc = {
    Text = "Ao comprá-lo, fique vulnerável por 1 rodada. Após o uso, fique vulnerável a todos os inimigos por 1 rodada. Não pode ser vendido"
  },
  State_3434_Name = {
    Text = "Estado @ causar correção de vulnerável"
  },
  State_3436_Desc = {
    Text = "Há [Layer] Despertos sendo caçados"
  },
  State_3436_Name = {
    Text = "Ser caçado"
  },
  State_3437_Desc = {
    Text = "Estado@monstro salto de baleia fantasma planeta besta do caos"
  },
  State_3437_Name = {
    Text = "Estado@monstro salto de baleia fantasma planeta besta do caos"
  },
  State_3437_WeaponDesc = {
    Text = "Estado@monstro salto de baleia fantasma planeta besta do caos"
  },
  State_3438_Desc = {
    Text = "Obtenha [StateArg1] pontos de força temporária"
  },
  State_3438_Name = {
    Text = "<CardKeyWord:Arma Mecânica - Espada>"
  },
  State_3439_Desc = {
    Text = "No fim do turno, Tulu ganha 5 de loucura"
  },
  State_3439_Name = {
    Text = "As estrelas retornam ao seu lugar"
  },
  State_3440_Name = {
    Text = "Guia dourado"
  },
  State_3441_Desc = {
    Text = "Nos turnos ímpares, quando suas cartas na mão são 0, compre 2 cartas; nos turnos pares, quando sua aritmética é 0, ganhe 2 de aritmética"
  },
  State_3441_Name = {
    Text = "Quebra-cabeça Antigo Alienado"
  },
  State_3441_WeaponDesc = {
    Text = "Nos turnos ímpares, quando suas cartas na mão são 0, compre 2 cartas; nos turnos pares, quando sua aritmética é 0, ganhe 2 de aritmética"
  },
  State_3442_Desc = {
    Text = "Ao pegar, perde permanentemente [Arg1] de força. Cada vez que causa dano, recupera [Arg2] de vida, até 6 vezes por turno"
  },
  State_3442_Name = {
    Text = "Beijo do Peixe-Bruxa"
  },
  State_3444_Desc = {
    Text = "Compre 1 carta no início do turno"
  },
  State_3445_Desc = {
    Text = "Aumenta [Layer]% da defesa"
  },
  State_3445_Name = {
    Text = "Aumento Percentual de Defesa Geral"
  },
  State_3445_WeaponDesc = {
    Text = "Aumenta [Layer]% da defesa"
  },
  State_3446_Desc = {
    Text = "Ganhe 5 camadas de [Fuse]. Diminui em 1 ao jogar uma carta. Quando chega a 0, autodestrói, causando dano de Ataque * 2,5."
  },
  State_3446_Name = {
    Text = "Granada explosiva"
  },
  State_3446_WeaponDesc = {
    Text = "Ganhe 5 camadas de [Fuse]. Diminui em 1 ao jogar uma carta. Quando chega a 0, autodestrói, causando dano de Ataque * 2,5."
  },
  State_3447_Desc = {
    Text = "Ganhe 5 camadas de [Fuse]. Diminui em 1 ao jogar uma carta. Quando chega a 0, autodestrói, causando dano de Ataque * 2,5."
  },
  State_3447_Name = {
    Text = "Granada explosiva"
  },
  State_3447_WeaponDesc = {
    Text = "Ganhe 5 camadas de [Fuse]. Diminui em 1 ao jogar uma carta. Quando chega a 0, autodestrói, causando dano de Ataque * 2,5."
  },
  State_3448_Desc = {
    Text = "Após cada turno, ative todos os tentáculos"
  },
  State_3448_Name = {
    Text = "Ativação Automática de Tentáculos"
  },
  State_3448_WeaponDesc = {
    Text = "Após cada turno, ative todos os tentáculos"
  },
  State_3449_Desc = {
    Text = "Estado@prologoLoucura0_1_1Ativada"
  },
  State_3449_Name = {
    Text = "Estado@prologoLoucura0_1_1Ativada"
  },
  State_3449_WeaponDesc = {
    Text = "Estado@prologoLoucura0_1_1Ativada"
  },
  State_3450_Desc = {
    Text = "Ao receber Dano ativo ou Dano de tentáculo, fica com Imunidade ao Dano e remove 1 capa."
  },
  State_3450_Name = {
    Text = "<ParcloseIconKeywords:Barreira>"
  },
  State_3450_WeaponDesc = {
    Text = "Dano recebido -99%. Após receber Dano, perde 1 capa."
  },
  State_3451_Desc = {
    Text = "Ao morrer, todos os despertos ganham 10 de loucura"
  },
  State_3451_Name = {
    Text = "Lâminas de Prata Moribundas"
  },
  State_3451_WeaponDesc = {
    Text = "Ao morrer, todos os despertos ganham 10 de loucura"
  },
  State_3452_Desc = {
    Text = "A cada vez que jogar uma carta, sofrerá [StateArg1] de dano e removerá 1 camada. Se ainda existir no final do turno, você incuba uma \"criatura do mar\", aumentando em 10% para cada camada de vida"
  },
  State_3452_Name = {
    Text = "Invasão abissal"
  },
  State_3453_Name = {
    Text = "Estado@laminaVingativaMultiplicadorDeForça"
  },
  State_3455_Desc = {
    Text = "Estado@prologoLoucuraInicial0_2_3Efeito"
  },
  State_3455_Name = {
    Text = "Estado@prologoLoucuraInicial0_2_3Efeito"
  },
  State_3455_WeaponDesc = {
    Text = "Estado@prologoLoucuraInicial0_2_3Efeito"
  },
  State_3456_Desc = {
    Text = "[defesa] ganha [StateArg1] níveis de balcão"
  },
  State_3456_Name = {
    Text = "Colete de Urtiga da Criação"
  },
  State_3457_Name = {
    Text = "Imunidade a vulnerabilidade"
  },
  State_3458_Desc = {
    Text = "Após jogar [Ataque] e [Defesa], o corpo correspondente ganha 35 de aliemus. No entanto, o consumo de aritmética deles aumenta em 1"
  },
  State_3459_Desc = {
    Text = "Durante esta batalha, o dano causado pela explosão de loucura aumenta em [Layer] pontos"
  },
  State_3459_Name = {
    Text = "Dano de Fúria Explosiva Aumentado"
  },
  State_3461_Desc = {
    Text = "A cada 5º dano que você causa é um crítico garantido"
  },
  State_3462_Name = {
    Text = "Estado@laminaVingativaMultiplicadorDeForça3"
  },
  State_3463_Name = {
    Text = "Estado@laminaVingativaMultiplicadorDeForça2"
  },
  State_3464_Desc = {
    Text = "Limite de tentáculo aumentado em 1. Quando a vida está abaixo de 50%, o dano do tentáculo aumenta em [Arg1]"
  },
  State_3465_Desc = {
    Text = "Esta carta será levada para fora da batalha, é válida dentro do nível"
  },
  State_3465_Name = {
    Text = "<CardKeyWord:Perpétuo>"
  },
  State_3465_WeaponDesc = {
    Text = "Esta carta pode ser levada para fora da batalha, é válida dentro do nível"
  },
  State_3466_Desc = {
    Text = "Ao coletar, escolha um despertador para despertá-lo, sua carta de despertar terá o custo de poder reduzido permanentemente em 1"
  },
  State_34671_Desc = {
    Text = "Após jogar, retorna à mão"
  },
  State_34671_Name = {
    Text = "<CardKeyWord:Retorno>"
  },
  State_34685_Name = {
    Text = "Jogador de Bomba 2"
  },
  State_34689_Desc = {
    Text = "A cada 1 ponto de vida perdido, ganha 1 camada de <PainWord:suportar>, com limite de 100% da vida máxima. O suportar é transferido para a próxima batalha."
  },
  State_34689_Name = {
    Text = "<CardKeyWord: Suportar>"
  },
  State_3468_Desc = {
    Text = "Estado@ressentimentoDoDefeito"
  },
  State_3468_Name = {
    Text = "Estado@ressentimentoDoDefeito"
  },
  State_3468_WeaponDesc = {
    Text = "Estado@ressentimentoDoDefeito"
  },
  State_34691_Desc = {
    Text = "A cada 1 ponto de vida perdido, ganha 1 camada de <PainWord:Paciência> com um limite de [DescArg1] camadas. A Paciência é herdada para a próxima batalha."
  },
  State_34691_Name = {
    Text = "<CardKeyWord: Suportar>"
  },
  State_34696_Desc = {
    Text = "Este cartão estará sempre na mão e aumentará o limite de cartas na mão em +1"
  },
  State_34696_Name = {
    Text = "Manter permanentemente e ignorar o limite de cartas na mão"
  },
  State_3469_Desc = {
    Text = "Todo Dano ativo e Dano de tentáculo causado -[DescArg1]%."
  },
  State_3469_Name = {
    Text = "<WeaknessColour: Fraqueza>"
  },
  State_3469_WeaponDesc = {
    Text = "Dano causado reduzido em [DescArg1] %"
  },
  State_3470_Desc = {
    Text = "Aplica petrificação gradual"
  },
  State_3470_Name = {
    Text = "Aplica petrificação gradual"
  },
  State_3470_WeaponDesc = {
    Text = "Aplica petrificação gradual"
  },
  State_3471_Desc = {
    Text = "A cada [StateArg1] cartas que você joga, o efeito ocorre 2 vezes"
  },
  State_3471_Name = {
    Text = "Contagem do Vinho das Estrelas"
  },
  State_3471_WeaponDesc = {
    Text = "A cada [StateArg1] cartas que você joga, o efeito ocorre 2 vezes"
  },
  State_3473_Desc = {
    Text = "Quando a vida estiver abaixo de 50%, o \"Pastor da Lanterna\" invocará a \"descida do deus\", absorvendo todos os fiéis e então entrar em fúria"
  },
  State_3473_Name = {
    Text = "Marca da Wick"
  },
  State_3473_WeaponDesc = {
    Text = "Quando a vida estiver abaixo de 50%, o \"Pastor da Lanterna\" invocará a \"descida do deus\", absorvendo todos os fiéis e então entrar em fúria"
  },
  State_3475_Desc = {
    Text = "[ataque] e [defesa] consomem +1 de aritmética"
  },
  State_3475_Name = {
    Text = "Estela Amaldiçoada da Criação"
  },
  State_3475_WeaponDesc = {
    Text = "[ataque] e [defesa] consomem +1 de aritmética"
  },
  State_3476_Desc = {
    Text = "Sempre que perder vida, fusão de embrião +10%. Se a vida estiver abaixo de 50%, o efeito é dobrado"
  },
  State_3477_Desc = {
    Text = "Ao ser atacado, recupera [Layer] pontos de Vida; ao receber Dano superior a 15% da Vida máxima, atordoa e remove este estado"
  },
  State_3477_Name = {Text = "Caos negro"},
  State_3478_Name = {
    Text = "Estado@AcessórioPactoPadrão"
  },
  State_3479_Desc = {
    Text = "A cada sigilo negro consumido, todos os despertadores ganham 1 aliemus"
  },
  State_3479_Name = {
    Text = "Flor Inversa da Criação"
  },
  State_3479_WeaponDesc = {
    Text = "A cada sigilo negro consumido, todos os despertadores ganham 1 aliemus"
  },
  State_3480_Desc = {
    Text = "Até o fim do turno, a vida não cairá para 0"
  },
  State_3480_Name = {
    Text = "O ovo de pérola não morre"
  },
  State_3480_WeaponDesc = {
    Text = "Até o fim do turno, a vida não cairá para 0"
  },
  State_3481_Desc = {
    Text = "No início da fase, dobre sua taxa de resistência à morte e sua taxa de selos de sorte"
  },
  State_3481_Name = {
    Text = "Estado@chaveDePrataSonho:sorteDupla"
  },
  State_3482_Desc = {
    Text = "O efeito de vulnerabilidade causado aumenta em 25%. A cada 3 rodadas, adicione 1 camada de vulnerabilidade a todos os inimigos"
  },
  State_3483_Desc = {
    Text = "A cada ação, anexa sangramento; o tratamento pode remover o efeito de sangramento"
  },
  State_3483_Name = {
    Text = "Ferimento grave"
  },
  State_3483_WeaponDesc = {
    Text = "A cada ação, anexa sangramento; o tratamento pode remover o efeito de sangramento"
  },
  State_3484_Desc = {
    Text = "Ao causar dano real, ganha força"
  },
  State_3484_Name = {
    Text = "\"Personalidade Confusa\""
  },
  State_3485_Desc = {
    Text = "Estado@ritualDaLanternaAtivado"
  },
  State_3485_Name = {
    Text = "Estado@ritualDaLanternaAtivado"
  },
  State_3485_WeaponDesc = {
    Text = "Estado@ritualDaLanternaAtivado"
  },
  State_3486_Name = {
    Text = "Espada do Destino"
  },
  State_3488_Desc = {
    Text = "Ao jogar a carta, receba [StateArg1] pontos de dano e remova 1 camada. Quando as camadas forem 0, incube um \"ser do mar\" mais fraco. Se o estado de parasita ainda existir no final do turno, incube um \"ser do mar\" de vida aumentando com as camadas"
  },
  State_3488_Name = {
    Text = "Parasitado múltiplas vezes"
  },
  State_3489_Name = {
    Text = "No final do turno, se estiver na mão ou no <DimensionalSpaceIconKeywords:Espaço Dimensional>, evolui para \"Chama Verde da Corrupção\""
  },
  State_3489_WeaponDesc = {
    Text = "No final do turno, se estiver na mão ou no espaço ultra, receberá reforço"
  },
  State_3490_Desc = {
    Text = "Ao jogar a carta, receba [StateArg1] pontos de dano e remova 1 camada. Quando as camadas forem 0, incube um \"ser do mar\" mais fraco. Se o estado de parasita ainda existir no final do turno, incube um \"ser do mar\" de vida aumentando com as camadas"
  },
  State_3490_Name = {
    Text = "Ser Parasitado Novamente"
  },
  State_3492_Desc = {
    Text = "Cada turno par reduz a força da equipe em [Layer]"
  },
  State_3492_Name = {
    Text = "Desequilibrio"
  },
  State_3495_Desc = {
    Text = "A cada ação, anexa [Layer] de sangramento"
  },
  State_3495_Name = {
    Text = "Ferimento grave"
  },
  State_3495_WeaponDesc = {
    Text = "A cada ação, anexa [Layer] de sangramento; o tratamento pode remover o efeito de sangramento"
  },
  State_34964_Desc = {
    Text = "Após o início do turno, ganhe <PainWord:resistência> equivalente a 10% da vida máxima."
  },
  State_34964_Name = {
    Text = "Nunca esqueça"
  },
  State_3496_Name = {
    Text = "No final do turno, se estiver na mão ou no <DimensionalSpaceIconKeywords:Espaço Dimensional>, evolui para \"Chama Verde da Morte\""
  },
  State_3496_WeaponDesc = {
    Text = "No final do turno, se estiver na mão ou no espaço ultra, receberá reforço"
  },
  State_3497_Desc = {
    Text = "Quando a equipe é composta por Despertos de diferentes classes, vida, ataque e defesa da equipe aumentam 200%"
  },
  State_3497_Name = {
    Text = "Bônus misto"
  },
  State_3497_WeaponDesc = {
    Text = "Quando a equipe é composta por Despertos de diferentes classes, vida, ataque e defesa da equipe aumentam 200%"
  },
  State_3499_Desc = {
    Text = "Único na equipe: A quantidade de loucura gerada pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%>. Após o portador liberar uma exaltação, ganha <WeaponEffect_Num:[StateArg2]> pontos de energia da chave de prata."
  },
  State_3499_WeaponDesc = {
    Text = "O portador gera <WeaponEffect_Num:[StateArg1]%> mais loucura. Após o portador liberar uma exaltação, ganha <WeaponEffect_Num:[StateArg2]> pontos de energia da chave de prata."
  },
  State_3502_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_3502_Name = {
    Text = "Estado@ProtótipoFacaLoucura"
  },
  State_3504_Desc = {
    Text = "No início de cada turno, compra [StateArg1] cartas"
  },
  State_3504_Name = {
    Text = "Bússola Direcional da Criação"
  },
  State_3504_WeaponDesc = {
    Text = "No início de cada turno, compra [StateArg1] cartas"
  },
  State_3507_Name = {
    Text = "Forma Orgânica dos Acessórios"
  },
  State_3507_WeaponDesc = {
    Text = "Após o uso do aliemus, o escudo e a cura do portador são dobrados neste turno"
  },
  State_3508_Name = {
    Text = "Casulo da Donzela dos Acessórios"
  },
  State_3508_WeaponDesc = {
    Text = "No início da batalha, se o portador for da classe Caos, ataque +25%"
  },
  State_3510_Desc = {
    Text = "Escudo causado pelo corpo desperto aumentado em [Layer] pontos"
  },
  State_3510_Name = {
    Text = "<AlertColour: Alerta>"
  },
  State_3511_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_3511_Name = {
    Text = "Estado@ProtótipoEspadaLongaSorte"
  },
  State_35120_Desc = {
    Text = "Para cada instância de Dano ativo recebido, aplica [StateArg1] <plural value=\"[Poison:StateArg1]\" singular=\"capa\" plural=\"capas\"> de Envenenamento ao atacante, durando [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_35120_Name = {
    Text = "Flor imortal no lodo"
  },
  State_3512_Name = {
    Text = "Fragilidade de Imunidade Temporária"
  },
  State_3514_Desc = {
    Text = "No fim do turno, recebe <FixedDamage:Dano Puro> igual ao número de capas e remove este estado."
  },
  State_3514_Name = {
    Text = "<BleedingIconKeywords:sangrando>"
  },
  State_3514_WeaponDesc = {
    Text = "Receba dano no início do turno"
  },
  State_35158_Name = {
    Text = "Pêndulo Temporal \"Trance\""
  },
  State_3515_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_3515_Name = {
    Text = "Ainda não despertado"
  },
  State_35161_Name = {
    Text = "Pêndulo Temporal \"Reserva\""
  },
  State_3516_Name = {
    Text = "Estado@MaldiçãoDepressão"
  },
  State_3518_Desc = {
    Text = "A Feiticeira ganha [StateArg2] de força temporária ao disparar 1 carta."
  },
  State_3518_Name = {
    Text = "Prólogo do espetáculo"
  },
  State_3519_Desc = {
    Text = "Mesmo fora do turno extradimensional, pode ativar o efeito de salto uma vez por turno"
  },
  State_3519_Name = {
    Text = "Distortor de Espaço"
  },
  State_3519_WeaponDesc = {
    Text = "Mesmo fora do turno extradimensional, pode ativar o efeito de salto uma vez por turno"
  },
  State_3520_Desc = {
    Text = "No início da batalha, escolha um desperto e dê a ele 50 pontos de loucura"
  },
  State_35228_Name = {
    Text = "Pêndulo Temporal \"Reserva\""
  },
  State_3522_Name = {
    Text = "Relíquia tridente contagem"
  },
  State_35238_Desc = {
    Text = "Equipe única: O escudo e o veneno causados pelo portador aumentam em <WeaponEffect_Num:[StateArg1]%>. Sempre que a resistência à morte for ativada, todos os despertadores recebem <WeaponEffect_Num:[StateArg2]%> de taxa crítica e dano crítico temporários."
  },
  State_35238_WeaponDesc = {
    Text = "O escudo e o veneno causados pelo portador aumentam <WeaponEffect_Num:[StateArg1]%>. Sempre que a resistência à morte for ativada, todos os despertadores recebem <WeaponEffect_Num:[StateArg2]%> de taxa crítica e dano crítico temporário"
  },
  State_3523_Desc = {
    Text = "Após jogar, enfraqueça todos os inimigos por [StateArg1] turno"
  },
  State_3523_Name = {
    Text = "<Rune_2_High:Fraqueza Avançada>"
  },
  State_3524_Desc = {
    Text = "Dano recebido aumentado em [Layer] pontos"
  },
  State_3524_Name = {
    Text = "Boca de fusão"
  },
  State_3524_WeaponDesc = {
    Text = "Dano recebido aumentado em [Layer] pontos"
  },
  State_3525_Desc = {
    Text = "Toda vez que minha equipe joga uma carta, aplique 2 pilhas de [Bind]."
  },
  State_3525_Name = {
    Text = "\"Oferta Especial da Zona Leste\""
  },
  State_3525_WeaponDesc = {
    Text = "Toda vez que minha equipe joga uma carta, aplique 2 pilhas de [Bind]."
  },
  State_35264_Desc = {
    Text = "Nesta rodada, após jogar 1 carta, “ilusionista” ganha 1 camada de fantasma"
  },
  State_35264_Name = {
    Text = "Registro de Deslocamento de Sombra"
  },
  State_35277_Name = {
    Text = "A defesa mágica de Casiah"
  },
  State_3527_Desc = {
    Text = "No final do turno, o Despertado que jogou a primeira carta de comando ganha 15 de Loucura. Se possuir \"Espírito de Devoção\", outros Despertados ganham 5 de Loucura"
  },
  State_3528_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_3528_Name = {
    Text = "Estado@ProtótipoCanhãoLaserDomínio"
  },
  State_3529_Desc = {
    Text = "Imune a todo dano, removido no início do turno"
  },
  State_3529_Name = {
    Text = "Imunidade ao dano"
  },
  State_3530_Desc = {
    Text = "Estado@detetive sortudo tudo ou nada marcador 8"
  },
  State_3530_Name = {
    Text = "Estado@detetive sortudo tudo ou nada marcador 8"
  },
  State_3530_WeaponDesc = {
    Text = "Estado@detetive sortudo tudo ou nada marcador 8"
  },
  State_3531_Desc = {
    Text = "Equipe Única: Ao iniciar a batalha, o portador ganha <WeaponEffect_Num:[StateArg1]> de Fúria. Sempre que outros Corpos Despertos liberarem a Fúria Explosiva, o portador ganha <WeaponEffect_Num:[StateArg2]> de Fúria. Se o domínio atual for \"Mar Profundo\", após o portador liberar a Fúria Explosiva, ele recebe dano de tentáculo equivalente a <WeaponEffect_Num:[StateArg3]%> da força de ataque."
  },
  State_3531_WeaponDesc = {
    Text = "Ao iniciar a batalha, o portador ganha <WeaponEffect_Num:[StateArg1]> pontos de Fúria. Sempre que outros Corpos Despertos liberarem a Fúria Explosiva, o portador ganha <WeaponEffect_Num:[StateArg2]> pontos de Fúria. Se o domínio atual for \"Mar Profundo\", após o portador liberar a Fúria Explosiva, o dano de tentáculo aumenta em <WeaponEffect_Num:+[DescArg1]>."
  },
  State_3532_Desc = {
    Text = "Ao iniciar a rodada, ganhe [StateArg1] de aritmética"
  },
  State_3532_Name = {
    Text = "Vela Negra da Criação 1"
  },
  State_3533_Desc = {
    Text = "Aparece na mão inicial"
  },
  State_3533_Name = {
    Text = "<GuyouKeywords:Inerente>"
  },
  State_3533_WeaponDesc = {
    Text = "No início da batalha, esta carta fica fixa na mão"
  },
  State_3535_Desc = {
    Text = "O consumo aritmético da carta aumenta em [Layer] pontos. Este efeito negativo será removido após o final do turno ou ao jogar a carta."
  },
  State_3535_Name = {
    Text = "<SlowColour: Lentidão Temporária [Layer]>"
  },
  State_3535_WeaponDesc = {
    Text = "O consumo aritmético da carta aumenta em [Layer] pontos"
  },
  State_3536_Name = {
    Text = "Pode ser usado 3 vezes em batalhas contra chefes"
  },
  State_3537_Desc = {
    Text = "Ao obter \"retribuição ingênua\", é possível realizar uma oração"
  },
  State_3537_Name = {
    Text = "Estado@Capítulo1_Resonância4"
  },
  State_3537_WeaponDesc = {
    Text = "Ao obter \"retribuição ingênua\", é possível realizar uma oração"
  },
  State_3538_Desc = {
    Text = "Usar \"Presente Ingênuo\" aumenta a recuperação de loucura"
  },
  State_3538_Name = {
    Text = "Estado@Capítulo1_Resonância1"
  },
  State_3538_WeaponDesc = {
    Text = "Usar \"Presente Ingênuo\" aumenta a recuperação de loucura"
  },
  State_3539_Desc = {
    Text = "“A ingênua retribuição” consome 1 de poder"
  },
  State_3539_Name = {
    Text = "Estado@Capítulo1_Resonância3"
  },
  State_3539_WeaponDesc = {
    Text = "“A ingênua retribuição” consome 1 de poder"
  },
  State_3540_Desc = {
    Text = "“Presente Inocente” pode designar alvo"
  },
  State_3540_Name = {
    Text = "Estado@Capítulo1_Resonância2"
  },
  State_3540_WeaponDesc = {
    Text = "“Presente Inocente” pode designar alvo"
  },
  State_3541_Desc = {
    Text = "Kum caiu na armadilha que vocês montaram"
  },
  State_3541_Name = {
    Text = "Caído na armadilha"
  },
  State_3542_Desc = {
    Text = "Ao início da batalha, para cada selo em seu baralho, ganhe [Arg1] pontos de poder, e para cada relíquia, recupere [Arg2] pontos de vida"
  },
  State_3542_Name = {
    Text = "☆Medalha da Câmara de Comércio☆"
  },
  State_3545_Name = {
    Text = "Resistência do Esplendor Estelar Sem Limites"
  },
  State_3545_WeaponDesc = {
    Text = "Cada carta jogada concede [StateArg1]% de resistência à morte. Ao ganhar resistência à morte, recupere [StateArg2] de vida"
  },
  State_3546_Desc = {
    Text = "Toda vez que minha equipe joga uma carta, aplique [Layer] pilhas de [Bind]."
  },
  State_3546_Name = {
    Text = "\"Oferta Especial da Zona Leste\""
  },
  State_3546_WeaponDesc = {
    Text = "Toda vez que minha equipe joga uma carta, aplique [Layer] pilhas de [Bind]."
  },
  State_3547_Desc = {
    Text = "Toda vez que minha equipe joga uma carta, aplique [Layer] pilhas de [Bind]."
  },
  State_3547_Name = {
    Text = "\"Oferta Especial da Zona Leste\""
  },
  State_3547_WeaponDesc = {
    Text = "Toda vez que minha equipe joga uma carta, aplique [Layer] pilhas de [Bind]."
  },
  State_3548_Desc = {
    Text = "Ao comprá-lo, fique vulnerável por 1 rodada. Após o uso, fique vulnerável a todos os inimigos por 1 rodada. Não pode ser vendido"
  },
  State_3548_Name = {
    Text = "EstadoMaldiçãoFraqueza"
  },
  State_3548_WeaponDesc = {
    Text = "Ao comprá-lo, fique vulnerável por 1 rodada. Após o uso, fique vulnerável a todos os inimigos por 1 rodada. Não pode ser vendido"
  },
  State_3549_Name = {
    Text = "Estado joia steppenwolf"
  },
  State_3549_WeaponDesc = {
    Text = "O dano base do portador aumenta em 10%. Se o dano forte do portador for maior que 20%, o dano base aumenta em mais 10%"
  },
  State_35503_Name = {
    Text = "Pêndulo Temporal \"Propagação\""
  },
  State_3551_Desc = {
    Text = "Ao iniciar a rodada, se o número de cartas restantes do último turno exceder [StateArg1], ganhe [StateArg2] pontos de aritmética"
  },
  State_3551_Name = {
    Text = "Diferença Prateada da Criação"
  },
  State_3551_WeaponDesc = {
    Text = "Ao iniciar a rodada, se o número de cartas restantes do último turno exceder [StateArg1], ganhe [StateArg2] pontos de aritmética"
  },
  State_35539_Desc = {
    Text = "Dano recebido dobrado, dura [Layer] turnos"
  },
  State_35539_Name = {
    Text = "Restos do Viajante"
  },
  State_3553_Desc = {
    Text = "Taxa crítica aumenta em 25%. Após causar recuperação de vida, há uma chance de causar 1 recuperação de vida adicional, com probabilidade igual à taxa crítica do causador"
  },
  State_3553_Name = {
    Text = "Estado@chave de prata dos sonhos: cura crítica"
  },
  State_3554_Desc = {
    Text = "Escudo e cura têm seu efeito aumentado em [Layer]%"
  },
  State_3554_Name = {
    Text = "Escudo e Cura Eficaz"
  },
  State_3554_WeaponDesc = {
    Text = "Escudo e cura têm seu efeito aumentado em [Layer]%"
  },
  State_3555_Desc = {
    Text = "Ao pegar, ganha 100% de resistência à morte. Após ativar a resistência à morte, recupera [Arg1] de vida no início de cada turno nesta batalha"
  },
  State_3555_Name = {
    Text = "Sopro de vida"
  },
  State_3556_Desc = {
    Text = "Ao coletar essa relíquia, escolha uma carta para adicionar uma cópia dela ao seu baralho"
  },
  State_3558_Desc = {
    Text = "Ao iniciar a rodada, se o sigilo negro for maior que 10, gaste 10 de sigilo negro, o dano causado durante a rodada será o dobro"
  },
  State_3559_Desc = {
    Text = "Ao causar dano não bloqueado, causa 1 camada de vulnerabilidade"
  },
  State_3559_Name = {Text = "Garras"},
  State_3559_WeaponDesc = {
    Text = "Ao causar dano real, embaralhe [StateArg1] cartas \"feridas\" no baralho de puxar"
  },
  State_3561_Name = {
    Text = "Estado@chaveDePrataSonho:contagemAtaqueCaotico"
  },
  State_3562_Desc = {
    Text = "Após a morte, aumenta a força de outros aliados em [Layer]"
  },
  State_3562_Name = {
    Text = "língua morta"
  },
  State_35635_Name = {
    Text = "Estado@despertador casiah telecinese permite ativar"
  },
  State_35636_Name = {
    Text = "Estado@despertador casiah adiciona telecinese"
  },
  State_3563_Desc = {
    Text = "Ao causar dano não bloqueado, embaralhe [StateArg1] cartas \"feridas\" no baralho de puxar"
  },
  State_3563_Name = {
    Text = "Lâmina afiada"
  },
  State_3563_WeaponDesc = {
    Text = "Ao causar dano real, embaralhe [StateArg1] cartas \"feridas\" no baralho de puxar"
  },
  State_35645_Desc = {
    Text = "Neste turno, número de cartas compradas diminui [Layer]"
  },
  State_35645_Name = {
    Text = "Tiragem reduzida"
  },
  State_35646_Desc = {
    Text = "Neste turno, número de cartas compradas diminui [Layer]"
  },
  State_35646_Name = {
    Text = "Tiragem reduzida"
  },
  State_3564_Desc = {
    Text = "Após jogar, ganhe [StateArg1] pontos temporários de poder, esta carta de selo também pode se beneficiar do bônus de poder"
  },
  State_3564_Name = {
    Text = "<Rune_15_High:Explosão Avançada>"
  },
  State_3565_Desc = {
    Text = "Quando o escultor aplica o escudo, aumenta o dano de tentáculo [StateArg1]"
  },
  State_3565_Name = {
    Text = "Estado de Esquecimento"
  },
  State_3565_WeaponDesc = {
    Text = "Quando o escultor aplica o escudo, aumenta o dano de tentáculo [StateArg1]"
  },
  State_3566_Desc = {
    Text = "Ao iniciar a rodada, ganhe 3 de poder temporário, [exaltar] dobrará este poder temporário, com um máximo de 2 acúmulos"
  },
  State_3566_Name = {
    Text = "Pele de Cobra Estranha da Criação"
  },
  State_3567_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_3567_Name = {
    Text = "Estado@ProtótipoCanhãoLaserCrítico"
  },
  State_35684_Desc = {
    Text = "Após nossa equipe liberar a exaltação, perderá o poder naquele turno. Uma vez por turno"
  },
  State_35684_Name = {
    Text = "Temor da loucura"
  },
  State_35685_Desc = {
    Text = "Ao liberar a chegada do gênesis, diminua o poder temporário dos inimigos"
  },
  State_35685_Name = {
    Text = "Temor da loucura"
  },
  State_3568_Desc = {
    Text = "Quando Ramona causa dano, ganha [StateArg1] de aritmética"
  },
  State_3568_Name = {
    Text = "Primeira filosofia"
  },
  State_3568_WeaponDesc = {
    Text = "Quando Ramona causa dano, ganha [StateArg1] de aritmética"
  },
  State_3570_Name = {
    Text = "No início do próximo turno, compre +2 cartas"
  },
  State_3571_Name = {
    Text = "Imune Temporário à Fraqueza"
  },
  State_3572_Desc = {
    Text = "Os monstros invocados causam dano dobrado"
  },
  State_3572_Name = {Text = "Comandante"},
  State_3572_WeaponDesc = {
    Text = "Os monstros invocados causam dano dobrado"
  },
  State_3573_Desc = {
    Text = "O primeiro dano recebido a cada turno é multiplicado por 5"
  },
  State_3573_Name = {Text = "Orgulho"},
  State_3573_WeaponDesc = {
    Text = "O primeiro dano recebido a cada turno é dobrado"
  },
  State_3574_Desc = {
    Text = "Sempre que jogar cartas do mesmo Despertado consecutivamente, esse Despertado ganha 10 de Loucura"
  },
  State_35768_Name = {
    Text = "Ganha 300 pontos de s-energia"
  },
  State_35769_Name = {
    Text = "Ganha 1 ponto de aritmética"
  },
  State_35770_Name = {
    Text = "Dissipar o estado de <IntoxicationIconKeywords: veneno>, selar, <SlowIconKeywords: lentidão>"
  },
  State_35771_Name = {
    Text = "Obtém um escudo equivalente a [DescArg1]% (<Block:[DescArg2]>) da saúde máxima"
  },
  State_35772_Name = {
    Text = "Pode ser usado [StateArg1] vezes extra em batalhas contra chefes"
  },
  State_35774_Desc = {
    Text = "Antes da morte, chame uma vez pela ajuda de Celeste, restaurando toda a vida, aliemus e s-energia"
  },
  State_35774_Name = {
    Text = "Véu da Utopia"
  },
  State_3577_Name = {
    Text = "Aumento da Recuperação Automática de Fúria"
  },
  State_35809_Desc = {
    Text = "Dano causado reduzido em [StateArg1]%, dura [Layer] turnos."
  },
  State_35809_Name = {
    Text = "Herdeiro da Ilusão"
  },
  State_35809_WeaponDesc = {
    Text = "Estado@DamaDoMarCháECake"
  },
  State_3580_Desc = {
    Text = "[Layer] Dano de tentáculo é dano por punção durante o turno"
  },
  State_3580_Name = {
    Text = "Tentáculo perfurante"
  },
  State_35811_Desc = {
    Text = "Ao receber Dano ativo ou Dano de tentáculo, ganhe metade do dano como <SacrificeKeyWord:Sacrifício> por [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_35811_Name = {
    Text = "Herdeiro da Ilusão"
  },
  State_35819_Desc = {
    Text = "No final do turno, Murphy ganha 5 pontos de aliemus. Após soltar a chave, remove 2% da saúde máxima do <SacrificeKeyWord:sacrifício>"
  },
  State_35819_Name = {
    Text = "Chá preto e bolo"
  },
  State_3581_Desc = {
    Text = "Estado@ContagemDeDançaDePoderDaDamaVermelha"
  },
  State_3581_Name = {
    Text = "Estado@ContagemDeDançaDePoderDaDamaVermelha"
  },
  State_3582_Desc = {
    Text = "Mesmo fora do turno extradimensional, pode ativar o efeito de salto uma vez por turno. Ao ativar, compre uma carta correspondente ao Desperto"
  },
  State_3582_Name = {
    Text = "Dobrador Espacial Mutante"
  },
  State_3582_WeaponDesc = {
    Text = "Mesmo fora do turno extradimensional, pode ativar o efeito de salto uma vez por turno. Ao ativar, compre uma carta correspondente ao Desperto"
  },
  State_3584_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_3584_Name = {
    Text = "Estado@ProtótipoFacaDomínio"
  },
  State_35858_Desc = {
    Text = "No fim do turno, Murphy ganha 5 de loucura. Após liberar a Chave, ganha dano de tentáculo equivalente a 3% do ataque de Murphy"
  },
  State_35858_Name = {
    Text = "Chá preto e bolo"
  },
  State_3585_Desc = {
    Text = "Quando a vida estiver abaixo de 50% ([StateArg1]), o \"Pastor da Lanterna\" invocará a \"descida do deus\", absorvendo todos os fiéis e então entrar em fúria"
  },
  State_3585_Name = {
    Text = "Marca da Wick"
  },
  State_3585_WeaponDesc = {
    Text = "Quando a vida estiver abaixo de 50% ([StateArg1]), o \"Pastor da Lanterna\" invocará a \"descida do deus\", absorvendo todos os fiéis e então entrar em fúria"
  },
  State_3588_Name = {
    Text = "Relíquia Arcanum relíquia aritmética"
  },
  State_3589_Desc = {
    Text = "Ao receber Dano ativo ou Dano de tentáculo, fica imune ao Dano e perde 1 capa."
  },
  State_3589_Name = {
    Text = "<ParcloseColour:Barreira>"
  },
  State_3591_Desc = {
    Text = "Equipe Única: O <RetaliateIconKeywords:Contador> do Portador +<WeaponEffect_Num:[StateArg1]%>. \"Defesa\" concede Contador Temporário igual à Defesa do Portador ×<WeaponEffect_Num:[StateArg2]%>. Em Batalhas do Líder, isso se torna 3 vezes o Contador Temporário. Após a Resistência à Morte ser acionada, aciona [StateArg3]% de <RetaliateIconKeywords:Contador> contra todos os inimigos."
  },
  State_3591_Name = {
    Text = "Esconder-se na noite"
  },
  State_3591_WeaponDesc = {
    Text = "O <RetaliateIconKeywords:Contador> do Portador +<WeaponEffect_Num:[StateArg1]%>. Após Disparar a \"Defesa\" do Portador, ganha <WeaponEffect_Num:[Counterattack:DescArg1]> capas de Contador Temporário. Em Batalhas do Líder, isso se torna 3 vezes o Contador Temporário. Após a Resistência à Morte ser acionada, aciona [StateArg3]% de <RetaliateIconKeywords:Contador> contra todos os inimigos."
  },
  State_3592_Desc = {
    Text = "Aumentar o dano causado pelos tentáculos"
  },
  State_3592_Name = {
    Text = "<TentacleInjurieIconKeywords:Dano de Tentáculo>"
  },
  State_3592_WeaponDesc = {
    Text = "Aumenta o dano causado pelos tentáculos"
  },
  State_3593_Desc = {
    Text = "Único para a equipe: O <IntoxicationIconKeywords:veneno> causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%>. \"Golpe\" causa <IntoxicationIconKeywords:veneno> equivalente a <WeaponEffect_Num:[StateArg2]%> do poder de ataque ao alvo. Este efeito pode ocorrer até 3 vezes por turno"
  },
  State_3593_WeaponDesc = {
    Text = "O <IntoxicationIconKeywords:veneno> causado pelo equipador aumenta em <WeaponEffect_Num:[StateArg1]%>. \"Golpe\" causa <WeaponEffect_Num:[Poison:DescArg1]> camadas de <IntoxicationIconKeywords:veneno> ao inimigo alvo. Este efeito pode ser ativado no máximo 3 vezes por turno"
  },
  State_3596_Name = {
    Text = "Núcleo de Prata Residual"
  },
  State_35970_Desc = {
    Text = "Após a morte, aplique 1 rodada de <VulnerabilityIconKeywords:vulnerável> ao jogador"
  },
  State_35970_Name = {
    Text = "Morte precoce"
  },
  State_35971_Desc = {
    Text = "Ao entrar, ganha um escudo equivalente a 50% da saúde máxima"
  },
  State_35971_Name = {
    Text = "casca de ovo"
  },
  State_3597_Name = {
    Text = "Núcleo de Prata Residual"
  },
  State_3598_Name = {
    Text = "Núcleo de Prata Residual"
  },
  State_3599_Desc = {
    Text = "Ao jogar 1 carta com custo de aritmética real de 4 ou mais, o consumo de aritmética de outras cartas na mão diminui em 1"
  },
  State_36006_Desc = {
    Text = "Após a morte, gera um \"Filho do Sonho\" no local"
  },
  State_36006_Name = {
    Text = "Receber dano"
  },
  State_3600_Name = {
    Text = "Núcleo de Prata Residual"
  },
  State_36013_Desc = {
    Text = "Este estado também é considerado <SacrificeKeyWord:sacrifício>, no início do próximo turno, ganhe [Layer] camadas de <SacrificeKeyWord:sacrifício>"
  },
  State_36013_Name = {
    Text = "<BlueKeyWord:Sacrifício Atrasado>"
  },
  State_36014_Desc = {
    Text = "No fim do turno, sofre [Layer] de dano e reduz 50% das camadas de <SacrificeKeyWord:Sacrifício>"
  },
  State_36014_Name = {
    Text = "<BlueKeyWord:Sacrifício>"
  },
  State_3601_Name = {
    Text = "Estado@chaveDePrataSonho:contagemDancaCircular"
  },
  State_36022_Desc = {
    Text = "Ao receber dano fora de <SacrificeKeyWord:sacrifício>, ganha 50% do dano como <SacrificeKeyWord:sacrifício>"
  },
  State_36022_Name = {Text = "Visitar"},
  State_36023_Desc = {
    Text = "Após a morte, se houver outros aliados, gera um \"Filho da Água\""
  },
  State_36023_Name = {
    Text = "Receber dano"
  },
  State_36024_Desc = {
    Text = "Após a morte, se houver outros aliados, gera um \"Filho do Sonho\""
  },
  State_36024_Name = {
    Text = "Receber dano"
  },
  State_3603_Name = {
    Text = "Pode ser usado 2 vezes em batalhas contra chefes, e após o primeiro uso, retorna à mão"
  },
  State_3604_Desc = {
    Text = "Quando a equipe é composta por Despertos de diferentes classes, vida, ataque e defesa da equipe aumentam 200%"
  },
  State_3604_Name = {
    Text = "Estado@BônusMisto"
  },
  State_3604_WeaponDesc = {
    Text = "Quando a equipe é composta por Despertos de diferentes classes, vida, ataque e defesa da equipe aumentam 200%"
  },
  State_3607_Desc = {
    Text = "Após jogar, faça com que o corpo despertado ganhe um aumento especial de capacidade nesta batalha. Jogar a habilidade de despertar gnose não pode acumular efeitos"
  },
  State_3607_Name = {
    Text = "<ExaltIconKeywords:Despertar da Consciência>"
  },
  State_3607_WeaponDesc = {
    Text = "Após o disparo do despertar de gnose, permite que o despertador obtenha um aumento especial de habilidades nesta batalha. Contudo, despertares de gnose repetidos não se acumulam em eficácia"
  },
  State_3608_Name = {
    Text = "Todos os aliados ganham [StateArg1] de loucura"
  },
  State_36092_Desc = {
    Text = "Após a morte, se houver outros aliados, gera um \"Filho da Água\" no local"
  },
  State_36092_Name = {
    Text = "Receber dano"
  },
  State_36093_Desc = {
    Text = "Ao perder 1 de vida, remova 1 camada. Ao zerar, após o turno do monstro, invoque 1 \"Filho da Água\" e recupere [DescArg1] camadas de \"Hospedeiro da Água\", até 4 \"Filhos da Água\""
  },
  State_36093_Name = {
    Text = "Hospedeiro da Água"
  },
  State_36094_Desc = {
    Text = "Ao perder 1 de vida, remova 1 camada. Ao zerar, invoque 1 \"Filho da Percepção\" e recupere [DescArg1] camadas de \"Hospedeiro de Coral\", até 4 \"Filhos da Percepção\""
  },
  State_36094_Name = {
    Text = "Hospedeiro da Consciência Espiritual"
  },
  State_3609_Name = {
    Text = "No combate de chefe, pode ser usado 2 vezes e após o primeiro uso retorna ao baralho, reduzindo o custo de capacidade do card reabsorvido em 1 neste turno"
  },
  State_36111_Desc = {
    Text = "Ao morrer, adicione 1 \"Proliferação de Coral\" à mão do jogador."
  },
  State_36111_Name = {
    Text = "Coral parasitário"
  },
  State_3611_Desc = {
    Text = "Estado@monstroPrologoPassivo12"
  },
  State_3611_Name = {
    Text = "Estado@monstroPrologoPassivo12"
  },
  State_3611_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo12"
  },
  State_36124_Desc = {
    Text = "No final do turno, sofra [Layer] de dano e reduza as camadas de \"Sacrifício\" em 50%."
  },
  State_36124_Name = {
    Text = "<BlueKeyWord:Sacrifício>"
  },
  State_3612_Desc = {
    Text = "Estado@monstroPrologoPassivo13"
  },
  State_3612_Name = {
    Text = "Estado@monstroPrologoPassivo13"
  },
  State_3612_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo13"
  },
  State_36136_Name = {
    Text = "Enquanto estiver na mão, recebe [StateArg1] <FixedDamage:Dano Puro> para cada outra carta disparada."
  },
  State_3613_Desc = {
    Text = "Estado@monstroPrologoPassivo10"
  },
  State_3613_Name = {
    Text = "Estado@monstroPrologoPassivo10"
  },
  State_3613_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo10"
  },
  State_3614_Desc = {
    Text = "Estado@monstroPrologoPassivo11"
  },
  State_3614_Name = {
    Text = "Estado@monstroPrologoPassivo11"
  },
  State_3614_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo11"
  },
  State_36152_Desc = {
    Text = "No fim do turno, sofre dano equivalente às camadas e remove 50% das camadas de <SacrificeKeyWord:Sacrifício>. O sacrifício é herdado para a próxima batalha."
  },
  State_36152_Name = {
    Text = "<SacrificeKeyWord:Sacrifício>"
  },
  State_3615_Desc = {
    Text = "Estado@monstroPrologoPassivo16"
  },
  State_3615_Name = {
    Text = "Estado@monstroPrologoPassivo16"
  },
  State_3615_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo16"
  },
  State_3616_Desc = {
    Text = "Estado@monstroPrologoPassivo14"
  },
  State_3616_Name = {
    Text = "Estado@monstroPrologoPassivo14"
  },
  State_3616_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo14"
  },
  State_36173_Name = {
    Text = "Pode ser usado [DescArg1] vezes em batalhas contra chefes"
  },
  State_36174_Name = {
    Text = "（Restam [Layer] vezes）"
  },
  State_3617_Desc = {
    Text = "Estado@monstroPrologoPassivo15"
  },
  State_3617_Name = {
    Text = "Estado@monstroPrologoPassivo15"
  },
  State_3617_WeaponDesc = {
    Text = "Estado@monstroPrologoPassivo15"
  },
  State_36182_Name = {
    Text = "Obtenha [DescArg1]%(<Block:[DescArg2]>) de um escudo de saúde máxima e recupere uma quantidade equivalente de vida, com o escudo aumentando conforme a vida perdida"
  },
  State_3618_Desc = {
    Text = "Ao receber dano real, ganha escudo"
  },
  State_3618_Name = {Text = "buffer"},
  State_3618_WeaponDesc = {
    Text = "Ao receber dano real, ganha escudo"
  },
  State_36196_Desc = {
    Text = "Os danos do \"golpe\" de Lotan aumentaram em 30%"
  },
  State_36196_Name = {
    Text = "Vento de espada indomável"
  },
  State_3619_Desc = {
    Text = "Estado@dançarino da chama azul ataque de defesa"
  },
  State_3619_Name = {
    Text = "Estado@dançarino da chama azul ataque de defesa"
  },
  State_3619_WeaponDesc = {
    Text = "Estado@dançarino da chama azul ataque de defesa"
  },
  State_3620_Desc = {
    Text = "Sempre que receber uma carta de sintoma, aumente a saúde máxima em [Arg1] pontos"
  },
  State_3621_Desc = {
    Text = "Os crentes primordiais, sempre que jogarem 1 carta, compram [StateArg1] cartas e ativam 5% de envenenamento em todos os inimigos"
  },
  State_3621_Name = {
    Text = "Obsessão abissal"
  },
  State_3621_WeaponDesc = {
    Text = "Para cada carta jogada pelo Devoto Primordial, compre [StateArg1] cartas"
  },
  State_3622_Desc = {
    Text = "Reforçar o efeito das habilidades de \"caçador enlouquecido\" e \"morto\", ganhando [StateArg1] pontos temporários de poder no início de cada turno, e aumentando [StateArg1] pontos para cada camada de \"marca de caça\""
  },
  State_3622_Name = {
    Text = "Marca de caça"
  },
  State_36242_Desc = {
    Text = "No início da batalha, ganhe [StateArg1] escudo. Após perder vida, o \"Bebê Sagrado\" acorda e começa a chorar"
  },
  State_36242_Name = {
    Text = "Sono profundo"
  },
  State_3624_Desc = {
    Text = "Estado@conhecedor análise ofensiva redução de poder"
  },
  State_3624_Name = {
    Text = "Estado@conhecedor análise ofensiva redução de poder"
  },
  State_3625_Desc = {
    Text = "Quando você tem escudo, o dano causado aumenta em [Arg1]. Se o escudo for maior que a vida atual, o dano aumenta em [Arg2]"
  },
  State_36263_Desc = {
    Text = "Sem mais danos, preparando-se para liberar a \"Semente da Criação\""
  },
  State_36263_Name = {Text = "Imunidade"},
  State_3628_Name = {
    Text = "Estado@jogarQuebraDefesa"
  },
  State_3629_Name = {
    Text = "Compre 2 cartas"
  },
  State_3630_Name = {
    Text = "Aplique 2 camadas de <VulnerabilityIconKeywords:vulnerável> a todos os inimigos"
  },
  State_36315_Desc = {
    Text = "No final do turno, ganhe [Layer] pontos de Força"
  },
  State_36315_Name = {Text = "Bênito"},
  State_3631_Name = {
    Text = "Ganha 2 pontos de aritmética"
  },
  State_3632_Name = {
    Text = "Obter <Energy:[DescArg1]> de loucura"
  },
  State_36332_Desc = {
    Text = "No início de cada turno, escolha ganhar 1 camada de Poder da Mãe ou consuma o Poder da Mãe para obter uma ajuda de Murphy"
  },
  State_36332_Name = {
    Text = "Poder da Mãe Divina"
  },
  State_36334_Desc = {
    Text = "No final de cada turno, ganhe 1 tentáculo"
  },
  State_36334_Name = {
    Text = "Chamado da Espiral"
  },
  State_3633_Name = {
    Text = "Aplica 2 camadas de <WeaknessIconKeywords:fraqueza> a todos os inimigos"
  },
  State_36346_Desc = {
    Text = "Quando a vida chegar a 0, a vida será ajustada para 1 ponto, não sofrerá mais danos e se preparará para liberar \"Semente do Nascimento\""
  },
  State_36346_Name = {
    Text = "Semente de Nascimento"
  },
  State_3634_Name = {
    Text = "Adicione 2 <DerivativeCardKeywords_4:\"Inspiração\"> cartões ao seu monte de compra."
  },
  State_3635_Name = {
    Text = "Outros despertos ganham <Energy:[DescArg1]> pontos de loucura"
  },
  State_36360_Desc = {
    Text = "Após o início do turno, há [DescArg1]% de chance de ganhar 1 camada de Tentáculos Reunidos, podendo ganhar várias camadas se exceder 100%"
  },
  State_36360_Name = {
    Text = "Linha de retorno ao mar"
  },
  State_36361_Desc = {
    Text = "Quando entra, os aliados ganham [Layer] de força"
  },
  State_36361_Name = {
    Text = "Desvio Divino"
  },
  State_3636_Desc = {
    Text = "Estado@CriaçãoEncantamentoSinoAtivo"
  },
  State_3636_Name = {
    Text = "Estado@CriaçãoEncantamentoSinoAtivo"
  },
  State_3637_Desc = {
    Text = "Quando sua vida estiver abaixo de 25% e você não estiver morto, recupere [Arg1] pontos de vida. Desativa após 3 ativações"
  },
  State_3637_Name = {
    Text = "☆Alimentos de emergência☆"
  },
  State_3638_Desc = {
    Text = "Ao receber Dano ativo ou Dano de tentáculo, fica imune ao Dano e perde 1 capa."
  },
  State_3638_Name = {
    Text = "<ParcloseColour:Barreira>"
  },
  State_3638_WeaponDesc = {
    Text = "Dano recebido -99%. Cada vez que Dano é recebido, perde 1 capa."
  },
  State_3639_Desc = {
    Text = "Quando Ramona causa dano, ganha [StateArg1] de aritmética"
  },
  State_3639_Name = {
    Text = "Terceira filosofia"
  },
  State_3639_WeaponDesc = {
    Text = "Quando Ramona causa dano, ganha [StateArg1] de aritmética"
  },
  State_3641_Desc = {
    Text = "Escolha uma carta na \"escultura de cera inacabada\" e reduza seu custo de aritmética em 1"
  },
  State_3641_Name = {
    Text = "Estado@Capítulo2_Resonância_EfeitoBásico"
  },
  State_3641_WeaponDesc = {
    Text = "As cartas copiadas na \"escultura de cera inacabada\" aumentam de nível +1"
  },
  State_3642_Desc = {
    Text = "Sempre que você perder vida, ganha [Arg1] camadas de contra-ataque. Se for a 3ª ativação em um único turno, causa 1 dano de contra-ataque a todos os inimigos"
  },
  State_3642_Name = {
    Text = "Crono do falecido"
  },
  State_3646_Desc = {
    Text = "HP não pode cair abaixo de 1. Ao receber dano fatal, a intenção muda para Impasse de Sobrevivência. [Impasse de Sobrevivência]: Restaura 100% do HP Máximo, dobra a Força e Melhora as habilidades subsequentes."
  },
  State_3646_Name = {
    Text = "Sobrevivência em situação desesperadora"
  },
  State_3647_Name = {
    Text = "Contagem do Registro Arcano da Criação"
  },
  State_3648_Desc = {
    Text = "Único na equipe: Efeito de recuperação de vida do portador aumenta em <WeaponEffect_Num:[StateArg2]%>. No início do turno, ganha <PowerIconKeywords:força> e escudo temporários iguais à vida perdida no turno anterior <WeaponEffect_Num:[StateArg1]%>"
  },
  State_3648_WeaponDesc = {
    Text = "Efeito de cura do portador aumenta em <WeaponEffect_Num:[StateArg2]%>. No início do turno, ganha <WeaponEffect_Num:[StateArg1]%> da vida perdida no turno anterior como <PowerIconKeywords:Força> e escudo temporários"
  },
  State_3649_Desc = {
    Text = "Para cada Despertador da classe [Ultra] na equipe, a Saúde Máxima de toda a equipe (não finalizada), Defesa e Ataque aumentam em 50%"
  },
  State_3649_Name = {
    Text = "Bonificação Hiperdimensional"
  },
  State_3649_WeaponDesc = {
    Text = "Para cada Despertador da classe [Ultra] na equipe, a Saúde Máxima de toda a equipe (não finalizada), Defesa e Ataque aumentam em 50%"
  },
  State_3651_Desc = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_3651_Name = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_3651_WeaponDesc = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_3652_Desc = {
    Text = "Ao iniciar a rodada, se o número de cartas jogadas no último turno exceder [StateArg1], compre [StateArg2] cartas"
  },
  State_3652_Name = {
    Text = "Luvas Mágicas da Criação"
  },
  State_3652_WeaponDesc = {
    Text = "Ao iniciar a rodada, se o número de cartas jogadas no último turno exceder [StateArg1], compre [StateArg2] cartas"
  },
  State_3653_Name = {
    Text = "Bandeira de Batalha Quebrada da Criação 2"
  },
  State_3654_Desc = {
    Text = "Após o início do turno, ganhe [Layer]% de taxa crítica temporária"
  },
  State_3654_Name = {
    Text = "Som suave aumenta gradualmente"
  },
  State_3654_WeaponDesc = {
    Text = "Até o próximo turno não perder saúde, o critico do próximo turno aumenta em +[StateArg1]%"
  },
  State_3656_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_3656_Name = {
    Text = "Ainda não despertado"
  },
  State_3658_Desc = {
    Text = "Ao jogar a última carta da mão, compre 2 cartas. Máximo de 2 ativações por turno"
  },
  State_3659_Name = {
    Text = "Estado@golpe carta taxa crítica dano crítico aumentado"
  },
  State_36613_Name = {
    Text = "Estado@AcessórioContagemDeusMecânico"
  },
  State_3661_Desc = {
    Text = "Receber dano real aumenta camadas de corrosão profunda"
  },
  State_3661_Name = {
    Text = "Receber dano aumenta camadas de corrosão profunda"
  },
  State_3661_WeaponDesc = {
    Text = "Receber dano real aumenta camadas de corrosão profunda"
  },
  State_3662_Desc = {
    Text = "Dano crítico aumentado em [Layer]% nesta batalha"
  },
  State_3662_Name = {
    Text = "Dano crítico"
  },
  State_3662_WeaponDesc = {
    Text = "Dano crítico aumentado em [Layer]% nesta batalha"
  },
  State_36631_Desc = {
    Text = "A cada vez que liberar uma explosão de loucura, aumente 1 camada de \"gestação\", e a cada camada de gestação receba [StateArg1] pontos de poder, com um limite de 5 camadas"
  },
  State_36631_Name = {
    Text = "Falsa portadora"
  },
  State_36635_Desc = {
    Text = "A cada vez que liberar uma explosão de loucura, aumente 1 camada de \"gestação\", e a cada camada de gestação receba [StateArg1] pontos de poder, com um limite de 5 camadas"
  },
  State_36635_Name = {
    Text = "A Descida Final de Lemuria"
  },
  State_36636_Desc = {
    Text = "Ao alcançar 5 camadas, libere \"A Glória de Lemúria!\", causando danos massivos e convocando os parentes."
  },
  State_36636_Name = {
    Text = "Concepção"
  },
  State_36637_Desc = {
    Text = "Ao alcançar 5 camadas, libere \"Por Lemúria!\", causando danos massivos e convocando os parentes."
  },
  State_36637_Name = {
    Text = "Concepção"
  },
  State_3663_Desc = {
    Text = "Após jogar a primeira carta de cada rodada, coloque 1 \"Golpe\" de cada despertador na mão"
  },
  State_3664_Desc = {
    Text = "Após jogar, ganhe 5 pontos de loucura"
  },
  State_3664_Name = {Text = "Homenagem"},
  State_3664_WeaponDesc = {
    Text = "Após jogar, ganhe 5 pontos de loucura"
  },
  State_3665_Desc = {
    Text = "Quando a Fusão de embriões atingir o limite, coloque um \"embrião\" na sua mão."
  },
  State_3665_Name = {
    Text = "<EmbryoFusionIconKeywords:Fusão de embrião>"
  },
  State_3666_Desc = {
    Text = "Taxa crítica aumenta em [Layer] %"
  },
  State_3666_Name = {
    Text = "Taxa de Crítico"
  },
  State_3666_WeaponDesc = {
    Text = "Taxa crítica aumenta em [Layer] %"
  },
  State_36670_Name = {
    Text = "Estado@AcessórioReevoluçãoContagem"
  },
  State_36670_WeaponDesc = {
    Text = "No fim do turno, o portador ganha 3 de Fúria. Se a recarga de Fúria for maior que 10, ganha 2 de Fúria extra"
  },
  State_3667_Desc = {
    Text = "Equipe Única: O <RetaliateIconKeywords:Contrataque> causado pelo portador aumenta em <WeaponEffect_Num:[StateArg4]%. Após disparar uma carta, o portador ganha <RetaliateIconKeywords:Contrataque> equivalente à defesa do portador de <WeaponEffect_Num:[StateArg1]%, podendo ser ativado no máximo 2 vezes por turno. Se ele entrar no Espaço Hiperdimensional, o portador também ganhará <WeaponEffect_Num:[StateArg2]> pontos de Fúria. Após liberar a Fúria Explosiva, todos os inimigos perdem Força temporária equivalente à defesa do portador de <WeaponEffect_Num:[StateArg3]%."
  },
  State_3667_WeaponDesc = {
    Text = "O <RetaliateIconKeywords:Contrataque> causado pelo portador aumenta em <WeaponEffect_Num:[StateArg4] %>. Após o portador disparar uma carta, ganha <WeaponEffect_Num:[Counterattack:DescArg1]> pontos de <RetaliateIconKeywords:Contrataque>, podendo ser ativado no máximo 2 vezes por turno. Se ele entrar no Espaço Hiperdimensional, o portador também ganhará <WeaponEffect_Num:[StateArg2]> pontos de Fúria. Após liberar a Fúria Explosiva, todos os inimigos diminuem temporariamente <WeaponEffect_Num:[Power:DescArg2]> pontos de Força."
  },
  State_3668_Desc = {
    Text = "Estado@guardião do jardim alienado marcador"
  },
  State_3668_Name = {
    Text = "Estado@guardião do jardim alienado marcador"
  },
  State_3668_WeaponDesc = {
    Text = "Estado@guardião do jardim alienado marcador"
  },
  State_3669_Desc = {
    Text = "Imune à fraqueza, fragilidade e vulnerabilidade durante [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_3669_Name = {
    Text = "<BlessingColour: Bênção>"
  },
  State_3669_WeaponDesc = {
    Text = "[Layer] Imune a estados negativos durante o turno"
  },
  State_36710_Name = {
    Text = "Dança da Lua Convexa"
  },
  State_3673_Desc = {
    Text = "Ao coletar, escolha 2 cartas para remover e ganhe [StateArg1] poder"
  },
  State_3673_Name = {
    Text = "Cinzas da Estrela Negra da Criação"
  },
  State_3674_Desc = {
    Text = "No final do turno, reduza a loucura de todos os despertos em 10"
  },
  State_3674_Name = {
    Text = "Aniquilação"
  },
  State_3674_WeaponDesc = {
    Text = "No final do turno, reduza a loucura de todos os despertos em 10"
  },
  State_3675_Name = {
    Text = "Roba o número de cartas descartadas + 1 carta"
  },
  State_3676_Desc = {
    Text = "Durante o turno do oponente, dano recebido reduzido em [Layer] %"
  },
  State_3676_Name = {Text = "Vigilante"},
  State_3676_WeaponDesc = {
    Text = "Durante o turno da nossa equipe, os monstros recebem [Layer] % de redução de dano"
  },
  State_3677_Desc = {
    Text = "Aumenta [Layer]% da defesa"
  },
  State_3677_Name = {
    Text = "Defesa temporária aumentada em porcentagem"
  },
  State_3677_WeaponDesc = {
    Text = "Aumenta [Layer]% da defesa"
  },
  State_36781_Desc = {
    Text = "Quando a força é reduzida, apenas 50% das camadas de força são diminuídas"
  },
  State_36781_Name = {
    Text = "Vontade Sedenta de Receber dano"
  },
  State_3678_Name = {
    Text = "Estado@Criação de Evento1"
  },
  State_36797_Desc = {
    Text = "Nesta rodada, o dano de tentáculo diminui em [Layer] pontos"
  },
  State_36797_Name = {
    Text = "Dano de tentáculo reduzido"
  },
  State_3679_Name = {
    Text = "Estado@Criação de Evento2"
  },
  State_3680_Desc = {
    Text = "A cada dano, aplica [Arg1] camadas de veneno no alvo. Após 25 ativações na batalha, aplica veneno em todos os inimigos"
  },
  State_3681_Desc = {
    Text = "Ao causar dano não bloqueado, deixa [DescArg1] capas de <BrokenCard:Sabotagem> em 2 \"Cartas de comando\" aleatórias."
  },
  State_3681_Name = {
    Text = "Jenkin Despertar!"
  },
  State_3681_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_3682_Desc = {
    Text = "Cada 10% de vida perdida, todos os Despertados ganham 10 de loucura, aumenta dano de tentáculos após a morte"
  },
  State_3682_Name = {
    Text = "Núcleo de Prata Profundamente Enterrado"
  },
  State_3682_WeaponDesc = {
    Text = "Cada 10% de vida perdida, todos os Despertados ganham 10 de loucura, aumenta dano de tentáculos após a morte"
  },
  State_3683_Desc = {
    Text = "Equipe Única: O aumento de cura causado pelas cartas de comando do portador é de <WeaponEffect_Num:[StateArg2] %>. Antes de o portador liberar a \"Fúria Explosiva\", outros Corpos Despertos ganham <WeaponEffect_Num:[StateArg1]> pontos de Fúria. Se nossa equipe estiver em estado <VulnerabilityIconKeywords:Vulnerável>, o efeito dobra."
  },
  State_3683_WeaponDesc = {
    Text = "O aumento de cura causado pelas cartas de comando do portador é de <WeaponEffect_Num:[StateArg2] %>. Antes de o portador liberar a Fúria Explosiva, outros Corpos Despertos ganham <WeaponEffect_Num:[StateArg1]> pontos de Fúria. Se nossa equipe estiver em estado <VulnerabilityIconKeywords:Vulnerável>, o efeito dobra."
  },
  State_3684_Desc = {
    Text = "A cada 1 ponto de dano, diminui 1 camada. Quando o número de camadas chega a 0, substitua a intenção pela Flor da Eternidade e utilize um conjunto de habilidades voltadas para defesa"
  },
  State_3684_Name = {
    Text = "Flor Imortal"
  },
  State_3684_WeaponDesc = {
    Text = "Cada ponto de dano recebido reduz uma camada. Quando as camadas chegam a 0, muda para modo de defesa"
  },
  State_3685_Desc = {
    Text = "Ao comprá-lo, perca 1 aritmética, compre 1 cartão"
  },
  State_3685_Name = {Text = "Confusão"},
  State_3685_WeaponDesc = {
    Text = "Ao comprá-lo, perca 1 aritmética, compre 1 cartão"
  },
  State_3686_Desc = {
    Text = "Ao comprá-lo, perca 1 aritmética, compre 1 cartão"
  },
  State_3686_Name = {
    Text = "Selo dimensional"
  },
  State_3686_WeaponDesc = {
    Text = "Ao comprá-lo, perca 1 aritmética, compre 1 cartão"
  },
  State_36884_Desc = {
    Text = "Na última promessa desta batalha, não pode mais obter um escudo através da resistência à morte ativada"
  },
  State_36884_Name = {
    Text = "Último Juramento"
  },
  State_3688_Desc = {
    Text = "Ao ativar 2 cartas consecutivamente com um custo de aritmética maior do que a carta anterior, ganhe 2 de aritmética"
  },
  State_3688_Name = {
    Text = "Registro Arcano da Criação"
  },
  State_3688_WeaponDesc = {
    Text = "Ao ativar 2 cartas consecutivamente com um custo de aritmética maior do que a carta anterior, ganhe 2 de aritmética"
  },
  State_3689_Desc = {
    Text = "No início do turno, aumente a maestria dimensional em 30. Sem status negativo, aumente a maestria dimensional para 100"
  },
  State_3692_Desc = {
    Text = "Possui um milhar de cartas misteriosas em várias posturas. Escolha a que você mais precisa!"
  },
  State_3692_Name = {
    Text = "<CardKeyWord: Mil Miragens>"
  },
  State_3692_WeaponDesc = {
    Text = "Possui um milhar de cartas misteriosas em várias posturas. Escolha a que você mais precisa!"
  },
  State_3693_Desc = {
    Text = "Taxa crítica aumenta em 25%. Após causar recuperação de vida, há uma chance de causar 1 recuperação de vida adicional, com probabilidade igual à taxa crítica do causador"
  },
  State_3693_Name = {
    Text = "Estado@chave de prata dos sonhos: cura crítica"
  },
  State_3696_Desc = {
    Text = "A cada vez que causar dano, ganhe [Arg1] pontos de alerta neste turno. No início do turno, a cada 3 pontos de escudo restantes, ganhe 1 ponto de poder neste turno"
  },
  State_3696_Name = {
    Text = "Pêndulo Temporal \"Oculto\""
  },
  State_3697_Desc = {
    Text = "Ao iniciar a rodada, compre 1 carta. Ao jogar 2 cartas consecutivas com o mesmo custo de aritmética da última carta, compre 1 carta extra"
  },
  State_3698_Desc = {
    Text = "Após jogar, copie [StateArg1] cartas da carta e adicione ao <DimensionalSpaceIconKeywords:ultra> temporário"
  },
  State_3698_Name = {
    Text = "<Rune_13:Salto>"
  },
  State_3699_Name = {
    Text = "Núcleo de Prata Residual"
  },
  State_3700_Desc = {
    Text = "Aumenta [Layer]% do ataque"
  },
  State_3700_Name = {
    Text = "Aumento percentual temporário de ataque"
  },
  State_3700_WeaponDesc = {
    Text = "Aumenta [Layer]% do ataque"
  },
  State_3702_Desc = {
    Text = "Estado @ mudança geral da saúde máxima"
  },
  State_3702_Name = {
    Text = "Estado @ mudança geral da saúde máxima"
  },
  State_3702_WeaponDesc = {
    Text = "Estado @ mudança geral da saúde máxima"
  },
  State_3703_Name = {
    Text = "Estado@Capítulo4Resonância@PróximoTurnoCartas2"
  },
  State_3704_Desc = {
    Text = "Maestria em Domínios aumenta em 30. Ao pegar, escolha uma criação e troque por uma criação aleatória"
  },
  State_3705_Name = {
    Text = "Iluminações do Mar 3"
  },
  State_3707_Desc = {
    Text = "Após o início da batalha, embaralhe [StateArg1] cópias temporárias no baralho de compra; as cartas originais e as cartas espelhadas ganham manter"
  },
  State_3707_Name = {
    Text = "<Rune_8:Imagem>"
  },
  State_3708_Desc = {
    Text = "Ao final do turno par, cada carta restante fará com que você ganhe 1 aritmética no início do próximo turno"
  },
  State_3708_Name = {
    Text = "Fragmento do Sábio da Criação 2"
  },
  State_3708_WeaponDesc = {
    Text = "Ao final do turno par, cada carta restante fará com que você ganhe 1 aritmética no início do próximo turno"
  },
  State_3709_Desc = {
    Text = "No final dos turnos ímpares, cada ponto de aritmética restante faz você comprar 1 carta no início do próximo turno"
  },
  State_3709_Name = {
    Text = "Fragmento do Sábio da Criação 1"
  },
  State_3709_WeaponDesc = {
    Text = "No final dos turnos ímpares, cada ponto de aritmética restante faz você comprar 1 carta no início do próximo turno"
  },
  State_3711_Desc = {
    Text = "A cada ação, causa [Layer] de sangramento"
  },
  State_3711_Name = {
    Text = "Salpicadura de sangre"
  },
  State_3711_WeaponDesc = {
    Text = "A cada ação, causa [Layer] de sangramento; o tratamento pode reduzir a quantidade de camadas de sangramento pela metade"
  },
  State_3712_Desc = {
    Text = "Após jogar a carta, consuma-a, a carta de comando causa 3 vezes de dano e proteção, durando 1 turno"
  },
  State_3712_Name = {
    Text = "dissolução"
  },
  State_3714_Desc = {
    Text = "Após jogar, ganhe [StateArg1] pontos de escudo"
  },
  State_3714_Name = {
    Text = "<Rune_6:Fortaleza>"
  },
  State_3716_Desc = {
    Text = "Durante esta batalha, a taxa crítica aumenta em [Layer]%"
  },
  State_3716_Name = {
    Text = "Taxa de Crítico"
  },
  State_3719_Desc = {
    Text = "Para cada instância de Dano ativo recebido, o tentáculo realizará um Contrataque na Fonte de Dano uma vez, durando [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_3719_Name = {
    Text = "Sangue herético"
  },
  State_3720_Desc = {
    Text = "Aumentar [Layer] pontos de defesa"
  },
  State_3720_Name = {
    Text = "Aumento de Defesa Geral"
  },
  State_3720_WeaponDesc = {
    Text = "Aumentar [Layer] pontos de defesa"
  },
  State_3721_Desc = {
    Text = "Após jogar, não vá para a pilha de descarte, mas seja removido do baralho"
  },
  State_3721_Name = {Text = "Consumo"},
  State_3721_WeaponDesc = {
    Text = "Após jogar, a carta não irá para a pilha de descarte e não poderá ser usada novamente nesta batalha"
  },
  State_3722_Desc = {
    Text = "A cada vez que causar dano, aumente temporariamente o dano de tentáculo [StateArg1], acumulando até 5 vezes. Quando as camadas estiverem completas, crie 1 tentáculo"
  },
  State_3722_Name = {
    Text = "Cetro do Sacerdote da Criação"
  },
  State_3722_WeaponDesc = {
    Text = "A cada vez que causar dano, aumente temporariamente o dano de tentáculo [StateArg1], acumulando até 5 vezes. Quando as camadas estiverem completas, crie 1 tentáculo"
  },
  State_3723_Name = {
    Text = "Espelho Negro da Criação"
  },
  State_3724_Desc = {
    Text = "Ao pegar, perca todas as outras relíquias e ganhe aleatoriamente 2 relíquias de ouro"
  },
  State_3726_Name = {
    Text = "Banquete distorcido de corpos mortos"
  },
  State_3728_Desc = {
    Text = "No início da batalha, ganhe uma carta [Golpe]"
  },
  State_3728_Name = {
    Text = "Salto de Despertar das Baleias 1"
  },
  State_3728_WeaponDesc = {
    Text = "No início da batalha, ganhe uma carta [Golpe]"
  },
  State_3730_Desc = {
    Text = "Estado@monstro doce demônio tragédia cor de mel"
  },
  State_3730_Name = {
    Text = "Estado@monstro doce demônio tragédia cor de mel"
  },
  State_3730_WeaponDesc = {
    Text = "Estado@monstro doce demônio tragédia cor de mel"
  },
  State_3731_Desc = {
    Text = "Sempre que nossa equipe compra na loja, no próximo combate, extraímos 1 carta e ganhamos 1 ponto de aritmética a cada turno"
  },
  State_3732_Desc = {
    Text = "A cada 3 turnos, ganha 3 tentáculos temporários que ignoram o limite"
  },
  State_3732_Name = {
    Text = "Membro Sem Nome da Criação"
  },
  State_3732_WeaponDesc = {
    Text = "A cada 3 turnos, ganha 3 tentáculos temporários que ignoram o limite"
  },
  State_3733_Desc = {
    Text = "No final dos turnos ímpares, a aritmética restante se transforma em compra extra de cartas no próximo turno; no final dos turnos pares, as cartas restantes se transformam em aritmética extra no próximo turno"
  },
  State_3735_Name = {
    Text = "As camadas de \"veneno\" da nossa equipe são reduzidas pela metade"
  },
  State_3738_Desc = {
    Text = "No final do turno, Fusão de Embrião +15%. Se tiver um embrião na mão, recupere [Arg1] de Vida"
  },
  State_3738_Name = {
    Text = "Registro da Peste"
  },
  State_3739_Name = {
    Text = "Efeito da Forma Orgânica dos Acessórios"
  },
  State_3739_WeaponDesc = {
    Text = "Após o uso do aliemus, o escudo e a cura do portador são dobrados neste turno"
  },
  State_3740_Name = {
    Text = "Estado@ContagemDeCríticosDoDemônioDoce"
  },
  State_3741_Desc = {
    Text = "No início da rodada 3, adicione 1 carta \"Ecos do Passado—Descarte todas as cartas, redefina a Vida e o Escudo atuais para o estado no final da rodada anterior. Retenha, Exausto.\" à sua mão."
  },
  State_3742_Desc = {
    Text = "Após jogar, todos os inimigos se tornam vulneráveis [StateArg1] turno"
  },
  State_3742_Name = {
    Text = "<Rune_1:vulnerável>"
  },
  State_3743_Desc = {
    Text = "A cada 6 cartas que você joga, o efeito ocorre 2 vezes"
  },
  State_3743_Name = {
    Text = "Vinho das Estrelas da Criação"
  },
  State_3744_Name = {
    Text = "Contagem do Espelho Ritual de Mênfis da Criação"
  },
  State_3747_Name = {
    Text = "Escolha 1 cartão da pilha de draw e coloque na sua mão"
  },
  State_3748_Name = {
    Text = "A taxa de crítico do dano causado aumenta em [DescArg1]%, e o dano crítico aumenta em [DescArg2]%"
  },
  State_3750_Name = {
    Text = "Aumento temporário da taxa crítica +[DescArg1]%. No combate atual, o dano base de \"decapitação\" e \"mil miragens\" aumenta em 5%"
  },
  State_3751_Name = {
    Text = "Obtenha [StateArg1] pontos de <PowerIconKeywords:força>"
  },
  State_3752_Name = {
    Text = "Ganha <Posse:[DescArg1]> energia de chave de prata. Ganha <Block:[Block:StateArg1]> pontos de escudo"
  },
  State_3753_Desc = {
    Text = "As cartas não entram na pilha de descarte na fase de descarte, mas permanecem na mão"
  },
  State_3753_Name = {
    Text = "<RetainIconKeywords:Manter>"
  },
  State_3753_WeaponDesc = {
    Text = "As cartas não entram na pilha de descarte na fase de descarte, mas permanecem na mão"
  },
  State_3754_Desc = {
    Text = "Ao causar dano ativo, aumenta o dano de tentáculo em [Arg1] neste turno, até 3 vezes. Ao atingir o máximo, gera 1 tentáculo, removido no final do turno"
  },
  State_3755_Desc = {
    Text = "Equipe Única: O escudo causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%>, e a recuperação de vida aumenta em <WeaponEffect_Num:[StateArg1]%>. No final dos turnos ímpares, a taxa de crítico do portador aumenta em <WeaponEffect_Num:[StateArg2]%> e ganha <WeaponEffect_Num:[StateArg3]> pontos de fúria; no final dos turnos pares, o dano crítico do portador aumenta em <WeaponEffect_Num:[StateArg2]%> e ganha <WeaponEffect_Num:[StateArg4]> energia da chave de prata. Se o domínio atual for \"Carne e sangue\", o limite de acumulação da fornalha carmesim aumenta em <WeaponEffect_Num:[StateArg5]%>."
  },
  State_3755_WeaponDesc = {
    Text = "O escudo causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%>, e a recuperação de vida aumenta em <WeaponEffect_Num:[StateArg1]%>. No final dos turnos ímpares, a taxa de crítico do portador aumenta em +<WeaponEffect_Num:[StateArg2]%>, ganhando <WeaponEffect_Num:[StateArg3]> pontos de fúria; no final dos turnos pares, o dano crítico do portador aumenta em +<WeaponEffect_Num:[StateArg2]%>, ganhando <WeaponEffect_Num:[StateArg4]> pontos de energia da chave de prata. Se o domínio atual for \"Carne e sangue\", o limite de acúmulo da fornalha carmesim aumenta em <WeaponEffect_Num:[StateArg5]%>."
  },
  State_3757_Desc = {
    Text = "Nossa equipe ganha [StateArg1] camadas de escudo a cada carta jogada. Dura 1 turno"
  },
  State_3757_Name = {
    Text = "Plumas voando pelo céu"
  },
  State_3757_WeaponDesc = {
    Text = "Nossa equipe ganha [StateArg1] camadas de escudo a cada carta jogada. Dura 1 turno"
  },
  State_3759_Name = {
    Text = "Arma Mecânica 1"
  },
  State_3760_Desc = {
    Text = "Se ao menos possuir [StateArg1] o sigilo negro, [exaltar] perder [StateArg1] o sigilo negro, vulnerável e fraqueza todos os inimigos por 1 turno"
  },
  State_3760_Name = {
    Text = "Pássaro do Ritual do Destino da Criação"
  },
  State_3760_WeaponDesc = {
    Text = "Se ao menos possuir [StateArg1] o sigilo negro, [exaltar] perder [StateArg1] o sigilo negro, vulnerável e fraqueza todos os inimigos por 1 turno"
  },
  State_3761_Desc = {
    Text = "Sempre que a equipe comprar 1 carta de Cambaleio, ganhe [Layer] pontos de força"
  },
  State_3761_Name = {
    Text = "Cerimônia da Lanterna"
  },
  State_3761_WeaponDesc = {
    Text = "Sempre que a equipe comprar 1 carta de Cambaleio, ganhe [Layer] pontos de força"
  },
  State_3763_Desc = {
    Text = "Cada vez que o Corredor causa dano, o dano crítico aumenta em [StateArg3]% neste turno"
  },
  State_3763_Name = {
    Text = "Passagem dobrada"
  },
  State_3763_WeaponDesc = {
    Text = "Cada vez que o Corredor causa dano, o dano crítico aumenta em [StateArg3]% neste turno"
  },
  State_3764_Name = {
    Text = "Arma Mecânica 2"
  },
  State_3766_Name = {
    Text = "Adicionar Multiplicador de Força Escarlate"
  },
  State_3767_Desc = {
    Text = "Cause [Arg1] de dano a um inimigo aleatório no início do turno. Após jogar 7 \"Golpes\" nesta batalha, o dano aumenta para [Arg2]"
  },
  State_3767_Name = {
    Text = "Quebra-cabeça antigo"
  },
  State_3768_Desc = {
    Text = "Dano ativo recebido sempre crita, removido no final do turno"
  },
  State_3768_Name = {
    Text = "Vulnerabilidade"
  },
  State_3768_WeaponDesc = {
    Text = "Dano ativo recebido sempre crita, removido no final do turno"
  },
  State_3770_Name = {
    Text = "Contagem da Relíquia Arcana da Criação"
  },
  State_3771_Desc = {
    Text = "Ao início da batalha, ganha 3 pontos de aritmética"
  },
  State_3772_Desc = {
    Text = "A lâmina de vingança aumenta a força temporária em um valor equivalente ao dano atual de tentáculo a cada dano causado"
  },
  State_3772_Name = {
    Text = "Vingança preparada"
  },
  State_3773_Desc = {
    Text = "No fim do turno, recebe <FixedDamage:Dano Puro> igual ao número de capas."
  },
  State_3773_Name = {
    Text = "<IntoxicationIconKeywords:Envenenamento>"
  },
  State_3773_WeaponDesc = {
    Text = "Receba dano no início do turno"
  },
  State_3774_Desc = {
    Text = "A cada vez que liberar aliemus, obtenha uma \"Infeção Tóxica\" que pode causar [Arg1] pontos de veneno. No final do turno, se você tiver 3 \"Infeções Tóxicas\", pode combiná-las em uma \"Eclosão Tóxica\" que dispara veneno"
  },
  State_3776_Desc = {
    Text = "Ao receber dano ativo, ganha uma camada de \"Alerta\". Com 3 camadas, recua"
  },
  State_3776_Name = {
    Text = "Boneca medrosa"
  },
  State_3776_WeaponDesc = {
    Text = "Ao receber dano ativo, ganha uma camada de \"Alerta\". Com 3 camadas, recua"
  },
  State_3777_Desc = {
    Text = "Jogue para o Despertado ganhar [StateArg1] de Loucura"
  },
  State_3777_Name = {
    Text = "<Rune_5_High:Fúria Avançada>"
  },
  State_3777_WeaponDesc = {
    Text = "Jogue para o Despertado ganhar [StateArg1] de Loucura"
  },
  State_3778_Desc = {
    Text = "Dano aumentado em 25% contra inimigos com status negativo, ao matar um inimigo, o assassino ganha 20 de loucura"
  },
  State_3779_Desc = {
    Text = "Limite de tentáculos reduzido em 2. No final do turno, todos os tentáculos atacam uma vez adicional"
  },
  State_3779_Name = {
    Text = "Braço Sagrado da Dor da Criação"
  },
  State_3779_WeaponDesc = {
    Text = "Limite de tentáculos reduzido em 2. No final do turno, todos os tentáculos atacam uma vez adicional"
  },
  State_3781_Desc = {
    Text = "No início do turno, aplica \"Maldição de Estagnação\" em 2 cartões do topo do baralho"
  },
  State_3781_Name = {
    Text = "\"Olho Amaldiçoado do Abismo\""
  },
  State_3781_WeaponDesc = {
    Text = "No início do turno, aplica \"Maldição de Estagnação\" em 2 cartões do topo do baralho"
  },
  State_3782_Desc = {
    Text = "Único na equipe: No início da exploração, adicione uma \"Defesa\" do portador ao baralho. O escudo da \"Defesa\" do portador aumenta em <WeaponEffect_Num:[StateArg1]%>"
  },
  State_3782_WeaponDesc = {
    Text = "No início da exploração, adicione uma carta da \"Defesa\" do equipador ao baralho, aumentando o escudo de \"Defesa\" do equipador em <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3783_Desc = {
    Text = "Equipe única: Dano base da explosão de loucura do portador aumenta em <WeaponEffect_Num:[StateArg1]>, e regeneração de escudo e vida aumenta em <WeaponEffect_Num:[StateArg2]%"
  },
  State_3783_WeaponDesc = {
    Text = "O dano base do estado de exaltar do equipador aumenta em <WeaponEffect_Num:[StateArg1] %>, e a recuperação de escudo e vida aumenta em <WeaponEffect_Num:[StateArg2] %>"
  },
  State_3784_Desc = {
    Text = "Equipe única: Dano base da carta de comando do portador aumenta em <WeaponEffect_Num:[StateArg1]%>, e regeneração de escudo e vida aumenta em <WeaponEffect_Num:[StateArg2]%"
  },
  State_3784_WeaponDesc = {
    Text = "O dano base das cartas de comando do equipador aumenta em <WeaponEffect_Num:[StateArg1] %>, e a recuperação de escudo e vida aumenta em <WeaponEffect_Num:[StateArg2] %>"
  },
  State_3786_Desc = {
    Text = "Você foi marcado! Após jogar, todos os monstros ganham [StateArg1] pontos de força temporária, removendo a marca de mergulho profundo deste comando"
  },
  State_3786_Name = {
    Text = "<CardKeyWord:Marca do Mergulho>"
  },
  State_3786_WeaponDesc = {
    Text = "Após jogar a carta, os do profundos recebem [StateArg1] de poder temporário"
  },
  State_3787_Desc = {
    Text = "Equipe única: Após o portador liberar o exaltar, todos os aliados ganham <WeaponEffect_Num:[StateArg1]> de aliemus"
  },
  State_3787_WeaponDesc = {
    Text = "Após o portador liberar a exaltação, todos os aliados ganham <WeaponEffect_Num:[StateArg1]> pontos de aliemus"
  },
  State_3788_Desc = {
    Text = "Único na equipe: No início da exploração, adicione um \"Golpe\" do portador ao baralho. O dano base do \"Golpe\" do portador aumenta em <WeaponEffect_Num:[StateArg1]%>"
  },
  State_3788_WeaponDesc = {
    Text = "No início da exploração, adicione uma carta \"Golpe\" ao baralho e aumente o dano base de \"Golpe\" em <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3790_Desc = {
    Text = "Estado@Contagem de Substância Indeterminada"
  },
  State_3790_Name = {
    Text = "Estado@Contagem de Substância Indeterminada"
  },
  State_3790_WeaponDesc = {
    Text = "Estado@Contagem de Substância Indeterminada"
  },
  State_3791_Desc = {
    Text = "Sempre que causar dano, ganhe [Arg1] pontos de escudo, até 5 vezes por turno. Quando atingir o máximo, coloque uma carta \"Inspiração\" na mão"
  },
  State_3792_Desc = {
    Text = "Sem mais influência da petrificação"
  },
  State_3792_Name = {
    Text = "Resistência à petrificação"
  },
  State_3792_WeaponDesc = {
    Text = "Sem mais petrificação, recebe dano triplo"
  },
  State_3793_Desc = {
    Text = "Dano crítico aumentado em [Layer]% nesta fase"
  },
  State_3793_Name = {
    Text = "Dano Crítico Permanente"
  },
  State_3793_WeaponDesc = {
    Text = "Dano crítico aumentado em [Layer]% nesta fase"
  },
  State_3794_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_3794_Name = {
    Text = "Estado@ProtótipoEspadaLongaDanoExplosivo"
  },
  State_3796_Desc = {
    Text = "Cada 20% de vida perdida, todos os Despertados ganham 10 de loucura, aumenta dano de tentáculos após a morte"
  },
  State_3796_Name = {
    Text = "Partículas de Prata Precipitadas"
  },
  State_3796_WeaponDesc = {
    Text = "Cada 20% de vida perdida, todos os Despertados ganham 10 de loucura, aumenta dano de tentáculos após a morte"
  },
  State_3797_Desc = {
    Text = "Ao receber dano, ganha [StateArg1] pontos de força temporária, removidos no início do turno"
  },
  State_3797_Name = {
    Text = "Fúria do Enxame de Ratos!"
  },
  State_37980_Desc = {
    Text = "Maestria de domínio aumentada em [Layer] nesta batalha"
  },
  State_37980_Name = {
    Text = "Domínio de área"
  },
  State_3798_Desc = {
    Text = "Ao causar dano real, restaura vida"
  },
  State_3798_Name = {
    Text = "Lâmina Vampírica"
  },
  State_3798_WeaponDesc = {
    Text = "Ao causar dano real, restaura vida"
  },
  State_3799_Desc = {
    Text = "Para cada Despertador da classe [Caro] na equipe, a Saúde Máxima de toda a equipe (não finalizada), Defesa e Ataque aumentam em 50%"
  },
  State_3799_Name = {
    Text = "Bônus de carne e sangue"
  },
  State_3799_WeaponDesc = {
    Text = "Para cada Despertador da classe [Caro] na equipe, a Saúde Máxima de toda a equipe (não finalizada), Defesa e Ataque aumentam em 50%"
  },
  State_3800_Desc = {
    Text = "Causa dano a todos os inimigos. <CardKeyWord:força> tem efeito multiplicado neste dano"
  },
  State_3800_Name = {
    Text = "<CardKeyWord: Força da Grande Espada>"
  },
  State_3801_Desc = {
    Text = "Ao causar dano não bloqueado, adicione [StateArg1] camadas de sangramento"
  },
  State_3801_Name = {Text = "Sangrar"},
  State_3802_Desc = {
    Text = "Enquanto estiver na mão, ao usar 1 carta de comando, ela se transforma em uma cópia com aritmética 0"
  },
  State_3802_Name = {
    Text = "<CardKeyWord:Filho Sagrado>"
  },
  State_3802_WeaponDesc = {
    Text = "Enquanto estiver na mão, ao usar 1 carta, ela se transforma em uma cópia com aritmética 0"
  },
  State_3803_Desc = {
    Text = "Ao início da batalha, o dano, escudo e cura das cartas com custo de 1 de aritmética aumentam em [Arg1] pontos durante esta batalha"
  },
  State_3804_Desc = {
    Text = "Contagem do tridente alienado"
  },
  State_3804_Name = {
    Text = "Contagem do tridente alienado"
  },
  State_3804_WeaponDesc = {
    Text = "Contagem do tridente alienado"
  },
  State_3807_Name = {
    Text = "Sonho Medicinal dos Acessórios"
  },
  State_3807_WeaponDesc = {
    Text = "Após o início da batalha, embaralhe um conjunto de cartas do portador no baralho de compra"
  },
  State_3808_Desc = {
    Text = "Estado@AlterarVidaAtualGeral"
  },
  State_3808_Name = {
    Text = "Estado@AlterarVidaAtualGeral"
  },
  State_3808_WeaponDesc = {
    Text = "Estado@AlterarVidaAtualGeral"
  },
  State_3810_Desc = {
    Text = "Após a morte, aumenta a força de outros aliados"
  },
  State_3810_Name = {
    Text = "língua morta"
  },
  State_3811_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_4_1"
  },
  State_3811_Name = {
    Text = "Estado@prologoResetarBaralho0_1_4_1"
  },
  State_3811_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_4_1"
  },
  State_3813_Name = {
    Text = "Imune à fraqueza"
  },
  State_3815_Desc = {
    Text = "No final do turno, todos os despertadores perdem [Layer] pontos de aleimus."
  },
  State_3815_Name = {
    Text = "<EnergyColour:Vazio>"
  },
  State_3815_WeaponDesc = {
    Text = "Reduzir loucura em [Layer]%"
  },
  State_3817_Desc = {
    Text = "No início do turno, cause [DescArg1] de exaustão ao oponente"
  },
  State_3817_Name = {Text = "Dispersão"},
  State_3817_WeaponDesc = {
    Text = "No início do turno, a equipe recebe [DescArg1*Layer*0.01] camadas de exaustão"
  },
  State_3818_Name = {
    Text = "Estado@conhecedor iluminar 1"
  },
  State_3819_Name = {
    Text = "O Destruidor da Cadeia Ilumina 1"
  },
  State_3819_WeaponDesc = {
    Text = "Imitação do Antigo"
  },
  State_3821_Desc = {
    Text = "No início do turno, ganhe um escudo igual à metade da vida perdida no turno anterior"
  },
  State_3821_Name = {
    Text = "Dor e Alegria"
  },
  State_3821_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_3824_Desc = {
    Text = "Equipe Única: O dano básico da Fúria Explosiva do portador aumenta em [StateArg1]%. Ao iniciar a exploração, o portador entra no estado de personalidade de Erudito. Após liberar a Fúria Explosiva, o portador alterna entre a personalidade de Erudito e a de Palhaço. \nPersonalidade de Erudito: Ao final do turno, o portador ganha <WeaponEffect_Num:[StateArg2]> pontos de Fúria. \nPersonalidade de Palhaço: Ao final do turno, a taxa de crítico e o dano crítico do portador aumentam em <WeaponEffect_Num:+[StateArg3] %>."
  },
  State_3824_WeaponDesc = {
    Text = "O dano base da explosão de loucura do portador aumenta em [StateArg1]%. No início da exploração, o portador entra no estado de personalidade de erudito. Após liberar a explosão de loucura, o portador alterna entre a personalidade de erudito e a de palhaço. \n Personalidade de erudito: no final do turno, o portador ganha <WeaponEffect_Num:[StateArg2]> de Fúria. \n Personalidade de palhaço: no final do turno, a taxa de crítico e o dano crítico do portador aumentam em <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_3825_Desc = {
    Text = "Ao receber Dano ativo, causa <FixedDamage:Dano Puro> à Fonte de Dano igual ao número de capas."
  },
  State_3825_Name = {
    Text = "<RetaliateIconKeywords: balcão>"
  },
  State_3825_WeaponDesc = {
    Text = "Cada vez que Dano ativo é recebido, causa <FixedDamage:Dano Puro> ao atacante."
  },
  State_3826_Name = {
    Text = "Estado@chaveDePrataSonho:contagemExplosao"
  },
  State_3827_Desc = {
    Text = "Equipe única: A recuperação de vida do evocador aumenta em <WeaponEffect_Num:[StateArg1]%. Após liberar exaltar, no início do próximo turno, recupera <WeaponEffect_Num:[StateArg2]%> da vida perdida"
  },
  State_3827_WeaponDesc = {
    Text = "A recuperação de vida do equipador aumenta em <WeaponEffect_Num:[StateArg1] %>. Após liberar o estado de exaltar, no início da próxima rodada, recupera <WeaponEffect_Num:[DescArg1] %> da vida perdida"
  },
  State_3830_Name = {
    Text = "Toma efeito 1 vez adicional"
  },
  State_3831_Name = {
    Text = "Raiz Inversa da Criação"
  },
  State_3834_Desc = {
    Text = "O envenenamento causado pela aranha do labirinto é duplicado"
  },
  State_3834_Name = {
    Text = "Viagem Perdida"
  },
  State_3835_Desc = {
    Text = "Neste turno, dano crítico aumenta [Layer] %"
  },
  State_3835_Name = {
    Text = "Dano Crítico Temporário"
  },
  State_3835_WeaponDesc = {
    Text = "Neste turno, dano crítico aumenta [Layer] %"
  },
  State_3836_Desc = {Text = "Teste 123"},
  State_3836_Name = {Text = "Teste 123"},
  State_3837_Desc = {
    Text = "Equipe Única: A Fúria gerada pelo Portador +<WeaponEffect_Num:[StateArg1]%>, e o <IntoxicationIconKeywords:Envenenamento> infligido pelo Portador +<WeaponEffect_Num:[StateArg2]%>.\nApós o Portador causar Dano ativo, todos os Corpos Despertos ganham Dano Crítico Temporário igual a <WeaponEffect_Num:[StateArg3]%> do Dano crítico base do Portador.\nSe o Domínio incluir Mar Profundo, Limite de tentáculos +1 e invoca 1 tentáculo no início da batalha."
  },
  State_3837_WeaponDesc = {
    Text = "A Fúria gerada pelo Portador +<WeaponEffect_Num:[StateArg1]%>, e o <IntoxicationIconKeywords:Envenenamento> infligido pelo Portador +<WeaponEffect_Num:[StateArg2]%>.\nApós o Portador causar Dano ativo, o Dano Crítico Temporário de todos os Corpos Despertos +<WeaponEffect_Num:[DescArg1]%>.\nSe o Domínio incluir Mar Profundo, Limite de tentáculos +1 e invoca 1 tentáculo no início da batalha."
  },
  State_3839_Desc = {
    Text = "Ao início da batalha, para cada carta de sintoma em seu baralho, ganhe [Arg1] poder. Todas as suas cartas de sintoma ganham ilusão"
  },
  State_3840_Desc = {
    Text = "Cada vez que o valor da vida diminui, ganha [StateArg1] de alerta"
  },
  State_3840_Name = {
    Text = "Vigilância"
  },
  State_3842_Desc = {
    Text = "Todo Dano ativo e Dano de tentáculo causado -[DescArg1]%."
  },
  State_3842_Name = {Text = "Fraqueza"},
  State_3842_WeaponDesc = {
    Text = "Dano causado reduzido em [DescArg1] %"
  },
  State_3843_Desc = {
    Text = "A cada ação, anexa [Layer] de sangramento"
  },
  State_3843_Name = {
    Text = "Ferimento grave"
  },
  State_3843_WeaponDesc = {
    Text = "A cada ação, anexa [Layer] de sangramento; o tratamento pode remover o efeito de sangramento"
  },
  State_3844_Desc = {
    Text = "Todas as vezes que Salto da Baleia causa dano +1"
  },
  State_3844_Name = {
    Text = "Desejo de batalha incontrolável"
  },
  State_3844_WeaponDesc = {
    Text = "Todas as vezes que Salto da Baleia causa dano +1"
  },
  State_3845_Desc = {
    Text = "Poder de cálculo das cartas reduzido"
  },
  State_3845_Name = {
    Text = "Poder de cálculo das cartas reduzido"
  },
  State_3845_WeaponDesc = {
    Text = "Poder de cálculo das cartas reduzido"
  },
  State_3846_Name = {
    Text = "Impressão de Jade da Criação"
  },
  State_3848_Desc = {
    Text = "Durante esta batalha, a explosão de loucura de um despertador aleatório é selada e não pode ser usada"
  },
  State_3848_Name = {Text = "Selo"},
  State_3850_Desc = {
    Text = "A cada vez que jogar a [StateArg1] carta, aumentará o dano de tentáculo [StateArg2] e realizará 1 ataque de tentáculo"
  },
  State_3850_Name = {
    Text = "Forket de alienação"
  },
  State_3850_WeaponDesc = {
    Text = "A cada vez que jogar a [StateArg1] carta, aumentará o dano de tentáculo [StateArg2] e realizará 1 ataque de tentáculo"
  },
  State_3851_Name = {
    Text = "Gato do Teatro dos Acessórios"
  },
  State_3851_WeaponDesc = {
    Text = "Todo o dano causado aumenta, o aumento é igual a 10% da saúde máxima do portador"
  },
  State_3852_Desc = {
    Text = "Aumenta o número de danos por mordida [Layer]"
  },
  State_3852_Name = {
    Text = "Mordida crescente"
  },
  State_3852_WeaponDesc = {
    Text = "Aumenta o número de danos por mordida [Layer]"
  },
  State_3853_Desc = {
    Text = "Ao iniciar a rodada, transforme-se aleatoriamente em uma cópia de uma carta de comando no baralho de compra, seu custo de aritmética fixado em 3, retornando ao normal ao final da rodada"
  },
  State_3853_Name = {
    Text = "<CardKeyWord:Delírio>"
  },
  State_3853_WeaponDesc = {
    Text = "As cartas não entram na pilha de descarte na fase de descarte, mas permanecem na mão"
  },
  State_3854_Desc = {
    Text = "Compre 2 cartas, isso atrairá a atenção do Caçador de Crânios"
  },
  State_3854_Name = {
    Text = "<CardKeyWord:Caçado>"
  },
  State_3855_Name = {Text = "Força"},
  State_3856_Desc = {
    Text = "Estado@prologoResetarBaralho0_1_3_1"
  },
  State_3856_Name = {
    Text = "Estado@prologoResetarBaralho0_1_3_1"
  },
  State_3856_WeaponDesc = {
    Text = "Estado@prologoResetarBaralho0_1_3_1"
  },
  State_3859_Desc = {
    Text = "A loucura fornecida pelo Sopro da Abundância é dobrada"
  },
  State_3859_Name = {Text = "ver a mãe"},
  State_3859_WeaponDesc = {
    Text = "A loucura fornecida pelo Sopro da Abundância é dobrada"
  },
  State_3860_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_3860_Name = {
    Text = "Estado@ProtótipoFacaSorte"
  },
  State_3862_Name = {
    Text = "Estado@Fase2_15Batalha4Bolha1"
  },
  State_3863_Desc = {
    Text = "Após liberar 3 explosões de loucura, o custo de aritmética de todas as cartas é reduzido em 1"
  },
  State_3866_Desc = {
    Text = "Neste turno, limite de cartas na mão +[Layer]"
  },
  State_3866_Name = {
    Text = "Limite de cartas na mão aumentado"
  },
  State_3867_Name = {
    Text = "Contador de Classe Superdimensional"
  },
  State_3868_Desc = {
    Text = "Neste turno, escudo causado aumenta [Layer]"
  },
  State_3868_Name = {
    Text = "Precaução temporária"
  },
  State_3868_WeaponDesc = {
    Text = "Neste turno, escudo causado aumenta [Layer]"
  },
  State_3872_Desc = {
    Text = "Receber dano cancela força temporária"
  },
  State_3872_Name = {
    Text = "Vulnerabilidade"
  },
  State_38730_Desc = {
    Text = "Após o início do turno, há [DescArg1]% de chance de ganhar 1 camada de Tentáculos Reunidos, podendo ganhar várias camadas se exceder 100%"
  },
  State_38730_Name = {
    Text = "Linha de retorno ao mar"
  },
  State_38735_Desc = {
    Text = "Dano ativo causado -[StateArg1]%, dobra o número de ataques e dura [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_38735_Name = {Text = "Delírio"},
  State_38738_Desc = {
    Text = "Limite de 10 camadas, pode ser herdado para a próxima batalha"
  },
  State_38738_Name = {
    Text = "Guia de sonhos"
  },
  State_3873_Desc = {
    Text = "Maestria de domínio aumentada em [Layer] nesta batalha"
  },
  State_3873_Name = {
    Text = "Domínio de área"
  },
  State_3874_Name = {
    Text = "Estado@cartão de vento do sino restauração"
  },
  State_3876_Desc = {
    Text = "Cada turno par reduz a força da equipe"
  },
  State_3876_Name = {
    Text = "\"Buraco do Sonho da Morte\""
  },
  State_3878_Desc = {
    Text = "Para cada 2 pontos de vida perdidos, ganha [Layer] pontos de escudo no próximo turno"
  },
  State_3878_Name = {
    Text = "Dor e Alegria"
  },
  State_3878_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_3879_Desc = {
    Text = "Ao pegar, a vida máxima aumenta em [Arg1] pontos. Se a vida ao pegar estiver abaixo de 25%, o aumento da vida máxima muda para [Arg2] pontos"
  },
  State_3881_Desc = {
    Text = "Estado@monstroGeorgeComerEstatua"
  },
  State_3881_Name = {
    Text = "Estado@monstroGeorgeComerEstatua"
  },
  State_3881_WeaponDesc = {
    Text = "Estado@monstroGeorgeComerEstatua"
  },
  State_3882_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_3882_Name = {
    Text = "Ainda não despertado"
  },
  State_3883_Desc = {
    Text = "Nesta fase, a taxa crítica aumenta em [Layer]%"
  },
  State_3883_Name = {
    Text = "Taxa de Crítico Permanente"
  },
  State_3883_WeaponDesc = {
    Text = "Nesta fase, a taxa crítica aumenta em [Layer]%"
  },
  State_3884_Desc = {
    Text = "A cada turno, gera 1 grau de fusão de embrião adicional. Todos os seus efeitos de devorar se tornam devoração infinita"
  },
  State_3884_Name = {
    Text = "Cordão Umbilical da Criação"
  },
  State_3884_WeaponDesc = {
    Text = "A cada turno, gera 1 grau de fusão de embrião adicional. Todos os seus efeitos de devorar se tornam devoração infinita"
  },
  State_3888_Desc = {
    Text = "Impossível liberar a exaltação, remove 1 camada ao fim do turno"
  },
  State_3888_Name = {
    Text = "<CardKeyWord:Selar>"
  },
  State_3888_WeaponDesc = {
    Text = "A explosão de loucura de todos os despertadores não pode ser usada"
  },
  State_3890_Name = {
    Text = "Comprar + [DescArg1] cartas do descarte"
  },
  State_3893_Desc = {
    Text = "Ao causar dano, ganha [Arg1] de escudo. Ao curar, ganha [Arg2] de força temporária"
  },
  State_3893_Name = {Text = "Nossa casa"},
  State_3894_Desc = {
    Text = "Transforme as cartas em pedras antes da fase de descarte"
  },
  State_3894_Name = {
    Text = "Petrificação"
  },
  State_3894_WeaponDesc = {
    Text = "Transforme as cartas em pedras antes da fase de descarte"
  },
  State_3895_Desc = {
    Text = "Neste turno, a taxa crítica aumenta em [Layer] %"
  },
  State_3895_Name = {
    Text = "Taxa de Crítico Temporária"
  },
  State_3895_WeaponDesc = {
    Text = "Neste turno, a taxa crítica aumenta em [Layer] %"
  },
  State_3898_Desc = {
    Text = "No início do próximo turno, ganhe [Layer] pontos de escudo"
  },
  State_3898_Name = {
    Text = "Escudo de dor e prazer"
  },
  State_3900_Name = {
    Text = "A carta está selada, não pode ser jogada, é liberada ao ser descartada"
  },
  State_3901_Name = {
    Text = "Contagem do Cetro do Sacerdote da Criação"
  },
  State_3902_Desc = {
    Text = "Neste turno, dano ativo causado diminui [Layer]"
  },
  State_3902_Name = {
    Text = "Redução de força"
  },
  State_3902_WeaponDesc = {
    Text = "Neste turno, dano causado diminui [Layer]"
  },
  State_3904_Desc = {
    Text = "Ao perder 1 de vida, remova 1 camada. Ao zerar, ganhe [StateArg1] de escudo e recupere [StateArg2] camadas de Barreira de Sangue"
  },
  State_3904_Name = {
    Text = "Despertar - Barreira de Sangue"
  },
  State_3905_Desc = {
    Text = "Cada vez que um Dano ativo é recebido, causa [Layer] de <FixedDamage:Dano Puro> à Fonte de Dano."
  },
  State_3905_Name = {
    Text = "Contrataque"
  },
  State_3905_WeaponDesc = {
    Text = "Cada vez que um Dano ativo é recebido, causa [Layer] de <FixedDamage:Dano Puro> ao Atacante."
  },
  State_3906_Name = {
    Text = "Núcleo de Prata Residual"
  },
  State_3907_Name = {
    Text = "Núcleo de Prata Residual"
  },
  State_3908_Desc = {
    Text = "Quando o cérebro em um frasco aplica recuperação, puxe [Arg2] cartas"
  },
  State_3908_Name = {
    Text = "Dichotomia do Real e do Ilusório"
  },
  State_3908_WeaponDesc = {
    Text = "Quando o cérebro em um frasco aplica recuperação, puxe [Arg2] cartas"
  },
  State_3909_Name = {
    Text = "Núcleo de Prata Residual"
  },
  State_3910_Name = {
    Text = "Núcleo de Prata Residual"
  },
  State_3911_Name = {
    Text = "Núcleo de Prata Residual"
  },
  State_3912_Name = {
    Text = "Núcleo de Prata Residual"
  },
  State_3913_Desc = {
    Text = "Equipe única: A Geração de Escudo do portador +<WeaponEffect_Num:[StateArg1]%>. No início do turno, mantém <WeaponEffect_Num:[StateArg2]%> do escudo restante, até <WeaponEffect_Num:[StateArg3]%> do HP máximo."
  },
  State_3913_WeaponDesc = {
    Text = "A Geração de Escudo do portador +<WeaponEffect_Num:[StateArg1]%>. No início do turno, mantém <WeaponEffect_Num:[StateArg2]%> do escudo restante, até <WeaponEffect_Num:[StateArg3]%> do HP Máx."
  },
  State_3914_Desc = {
    Text = "Após liberar o 2º explosão de loucura em cada turno, todos os despertadores ganham 10 de loucura. Após liberar o 3º explosão de loucura em cada turno, a recarga de loucura de todos os despertadores é redefinida e ganham 10 de loucura"
  },
  State_3915_Name = {
    Text = "Núcleo de Prata Residual"
  },
  State_3916_Name = {
    Text = "Núcleo de Prata Residual"
  },
  State_3917_Desc = {
    Text = "Força temporária no próximo turno"
  },
  State_3917_Name = {Text = "Carregar"},
  State_3918_Desc = {
    Text = "No início de cada turno, ganhe o estado de dano dobrado na primeira vez que for atingido"
  },
  State_3918_Name = {Text = "Orgulho"},
  State_3918_WeaponDesc = {
    Text = "No início de cada turno, ganhe o estado de dano dobrado na primeira vez que for atingido"
  },
  State_3921_Desc = {
    Text = "Nesta rodada, cartas não entrarão na pilha de descarte durante a fase de descarte, mas serão mantidas na mão"
  },
  State_3921_Name = {
    Text = "<RetainIconKeywords:Manter>"
  },
  State_3921_WeaponDesc = {
    Text = "As cartas não entram na pilha de descarte na fase de descarte, mas permanecem na mão"
  },
  State_3923_Desc = {
    Text = "Poder de cálculo das cartas reduzido"
  },
  State_3923_Name = {
    Text = "Redução Permanente de Poder de Cálculo de Cartas"
  },
  State_3923_WeaponDesc = {
    Text = "Poder de cálculo das cartas reduzido"
  },
  State_3925_Name = {
    Text = "Estado@quarto capítulo ressonância@início da rodada da equipe aritmética 2"
  },
  State_3926_Desc = {
    Text = "\"Festa dos Mortos Torcidos\" aumenta dano em [Layer]."
  },
  State_3926_Name = {
    Text = "Distorção"
  },
  State_3926_WeaponDesc = {
    Text = "Aumenta dano de \"Fúria\""
  },
  State_3927_Desc = {
    Text = "Ao comprar \"Vazio\", a loucura adquirida por todos os despertos neste turno é reduzida em [Layer]%"
  },
  State_3927_Name = {Text = "Vazio"},
  State_3927_WeaponDesc = {
    Text = "Ao comprar \"Vazio\", a loucura adquirida por todos os despertos neste turno é reduzida em [Layer]%"
  },
  State_3928_Desc = {
    Text = "Quando o doce demônio causa dano, ganha [StateArg2] de contra-ataque"
  },
  State_3928_Name = {
    Text = "Dar e receber"
  },
  State_3929_Desc = {
    Text = "Força e escudo obtidos são reduzidos em 50%, removido 1 camada no final do turno"
  },
  State_3929_Name = {
    Text = "<CardKeyWord:Maldição>"
  },
  State_3929_WeaponDesc = {
    Text = "Neste turno, imune a estados positivos"
  },
  State_3930_Name = {
    Text = "Estado@quarto capítulo ressonância@início da rodada da equipe aritmética 1"
  },
  State_3931_Name = {
    Text = "Estado@CançãoDeSangueEAreia"
  },
  State_3932_Desc = {
    Text = "Faz a carta obter a manutenção, cada camada de maldição de estagnação aumenta o custo da carta em 1 ponto, removendo a maldição de estagnação ao ser jogada"
  },
  State_3932_Name = {
    Text = "Maldição de Paralisia ([Layer])"
  },
  State_3932_WeaponDesc = {
    Text = "Faz a carta obter a manutenção, cada camada de maldição de estagnação aumenta o custo da carta em 1 ponto, removendo a maldição de estagnação ao ser jogada"
  },
  State_3933_Desc = {
    Text = "Aumentar [Layer] pontos de defesa"
  },
  State_3933_Name = {
    Text = "Defesa temporária aumentada"
  },
  State_3933_WeaponDesc = {
    Text = "Aumentar [Layer] pontos de defesa"
  },
  State_3934_Desc = {
    Text = "Todos os escudos obtidos são reduzidos em 50%"
  },
  State_3934_Name = {
    Text = "Fragilidade de extinção"
  },
  State_3934_WeaponDesc = {
    Text = "Todos os escudos obtidos são reduzidos em 50%"
  },
  State_3935_Desc = {
    Text = "Nossa equipe ganha uma camada de \"Observação\" a cada carta jogada, ao atingir dez camadas, fica atordoada"
  },
  State_3935_Name = {
    Text = "Observação"
  },
  State_3936_Desc = {
    Text = "O equipador aumenta o dano, escudo e cura em [StateArg1]%. (temporário)"
  },
  State_3936_Name = {
    Text = "Estado@ProtótipoEspadaLongaDomínio"
  },
  State_3937_Desc = {
    Text = "Quando a Rainha dos Espinhos aplica um contra-ataque, ganha metade do escudo do contra-ataque"
  },
  State_3937_Name = {
    Text = "Parede de zumbis"
  },
  State_3938_Name = {
    Text = "Gerar uma figura de cera"
  },
  State_3941_Desc = {
    Text = "Ao devorar um embrião, ele retorna do baralho de descarte para o baralho de mão"
  },
  State_3941_Name = {
    Text = "Remoinho pálido"
  },
  State_3941_WeaponDesc = {
    Text = "Ao devorar um embrião, ele retorna do baralho de descarte para o baralho de mão"
  },
  State_3942_Name = {
    Text = "Linha de retorno do adorno"
  },
  State_3942_WeaponDesc = {
    Text = "No início da batalha, se o portador for da classe Abissal, ataque +25%"
  },
  State_3943_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_3943_Name = {
    Text = "Ainda não despertado"
  },
  State_3944_Desc = {
    Text = "Após o final do turno, todos os despertadores ganham 5 de exaltação. Para cada 1 ponto de aritmética restante, todos os despertadores ganham 3 de exaltação adicionais"
  },
  State_3945_Desc = {
    Text = "Preço de todas as criações reduzido em 50%"
  },
  State_39547_Desc = {
    Text = "Ao final da batalha, ganha adicionalmente 5 selos negros, este efeito é afetado pela bonificação de queda de selos negros. Após Wanda jogar uma carta, ganha 1 camada de Guia dos Sonhos, este efeito é ativado até 2 vezes por turno. Restam [DescArg1] ativações"
  },
  State_39547_Name = {
    Text = "Pelos e Vênus"
  },
  State_40483_Name = {
    Text = "Lança submersa quebrada"
  },
  State_40484_Desc = {
    Text = "Quando a habilidade de Wanda ativa o efeito de salto, se houver 5 camadas, consuma as 5 camadas e ganhe um efeito adicional. O limite máximo de Guia dos Sonhos é de 10 camadas e será herdado para a próxima batalha."
  },
  State_40484_Name = {
    Text = "<PurpleKeyWord:Sonho Guia>"
  },
  State_41337_Desc = {
    Text = "No fim do turno, recupera [Layer] de vida"
  },
  State_41337_Name = {
    Text = "Vitória da Rosa-Recuperação"
  },
  State_41340_Desc = {
    Text = "Equipe única: O escudo e o contra-ataque causados pelo portador aumentam em <WeaponEffect_Num:[StateArg1] %>. Cada vez que é atacado, há <WeaponEffect_Num:[StateArg2] %> de chance de fazer com que todos os despertadores ganhem 1 ponto de aliemus"
  },
  State_41340_WeaponDesc = {
    Text = "O escudo e a retaliacão causados pelo portador aumentam em <WeaponEffect_Num:[StateArg1]%>. Sempre que é atacado, há <WeaponEffect_Num:[StateArg2]%> de chance de fazer com que todos os despertadores ganhem 1 ponto de loucura."
  },
  State_41342_Name = {
    Text = "Alterar efeito __ \"Somente para uso em desenvolvimento\""
  },
  State_41344_Name = {
    Text = "Efeito de mudança"
  },
  State_41360_Desc = {
    Text = "Gaste 5 camadas de <DreamGuide: Guia dos Sonhos>, Wanda ganha <Energy:[StateArg1]> pontos de aliemus, recebendo um <RetaliateIconKeywords: Retaliação> temporário permanente equivalente a [StateArg2]%"
  },
  State_41360_Name = {
    Text = "Contra-ataque de sono profundo"
  },
  State_41361_Desc = {
    Text = "Esgota 10 capas de <DreamGuide:Guia de sonhos>, fazendo todos os inimigos entrarem no estado \"Murmúrio\" por 1 turno: Dano ativo causado -[StateArg3]%, mas o número de ataques é dobrado."
  },
  State_41361_Name = {
    Text = "Ecos de sussurros"
  },
  State_43818_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_43818_Name = {
    Text = "Ainda não despertado"
  },
  State_44398_Desc = {
    Text = "Após jogar a primeira carta de cada rodada, coloque 1 \"Defesa\" de cada Corpo Desperto na mão."
  },
  State_44484_Name = {
    Text = "Pode ser usado 3 vezes em batalhas de Líder"
  },
  State_44485_Name = {
    Text = "(Restante:[Layer])"
  },
  State_44491_Name = {
    Text = "Desativar Efeito __ \"Para uso de desenvolvimento apenas\""
  },
  State_44562_Name = {
    Text = "Desativar efeito"
  },
  State_44575_Desc = {
    Text = "Neste turno, escudo restante não será removido, será mantido para o próximo turno"
  },
  State_44575_Name = {
    Text = "Escudo mantido"
  },
  State_44653_Desc = {
    Text = "No início de cada rodada, todos os despertadores ganham 20 loucura. Ao coletar, a saúde máxima diminui em 50%"
  },
  State_44665_Desc = {
    Text = "A taxa crítica do \"golpe\" neste turno aumentou em [Layer] %"
  },
  State_44665_Name = {
    Text = "Aumentar a taxa crítica"
  },
  State_44667_Desc = {
    Text = "\"Strike\" ganha [DescArg1] Aritmética. Se a postura atual é \"Surge\", nenhuma Aritmética é ganha, mas 1 Tentáculo é ordenado para atacar [DescArg2] vezes."
  },
  State_44667_Name = {
    Text = "Tirania do Gigante"
  },
  State_44671_Desc = {
    Text = "No início de cada rodada, todos os despertadores ganham 25 loucura. Ao coletar, a saúde máxima se torna 3 vezes"
  },
  State_44672_Name = {
    Text = "Bênção·consciência de enxame"
  },
  State_44711_Desc = {
    Text = "Limite de relíquias +5, +1 nas renovações em [marca d]. Após o término da batalha, obtém 125 o sigilo negro, e ao coletar, pode escolher até 6 cartas de sintoma para remover"
  },
  State_44713_Desc = {
    Text = "Ao final da batalha, ganha adicionalmente 100 selos negros e 2 cartas de sintoma"
  },
  State_44730_Desc = {
    Text = "No início do turno, acumula <Heal:[Heal:StateArg1]> pontos de recuperação da fornalha carmesim"
  },
  State_44730_Name = {
    Text = "Oferecer redenção"
  },
  State_44731_Desc = {
    Text = "Com dor, usa a dor. Consumindo toda a quantidade de Recuperação restante do Forno Carmesim, cada ponto consumido aumenta o Dano em 3 (9 durante uma Batalha do Líder). A cada 1% de Vida máxima do Forno Carmesim consumido, aumenta o Dano Final em [DescArg1]%."
  },
  State_44731_Name = {Text = "Exorcismo"},
  State_44732_Desc = {
    Text = "Socorrer com sangue. Após causar dano, perca 10% da vida atual e acumule uma quantidade de recuperação da fornalha carmesim equivalente à vida perdida"
  },
  State_44732_Name = {
    Text = "Dedicação"
  },
  State_44739_Desc = {
    Text = "Ao pegar, perde permanentemente [Arg1] de força. Cada vez que causa dano, recupera [Arg2] de vida, até 6 vezes por turno"
  },
  State_44739_Name = {
    Text = "Pecado·Beijo do Peixe-Bruxa"
  },
  State_44740_Name = {
    Text = "Bênção·beijo da lampreia"
  },
  State_44741_Desc = {
    Text = "Ao pegar, perde permanentemente [Arg1] de força. Cada vez que causa dano, recupera [Arg2] de vida, até 6 vezes por turno"
  },
  State_44741_Name = {
    Text = "Pecado·Beijo do Peixe-Bruxa"
  },
  State_44742_Desc = {
    Text = "Ao pegar, perde permanentemente [Arg1] de força. Cada vez que causa dano, recupera [Arg2] de vida, até 6 vezes por turno"
  },
  State_44742_Name = {
    Text = "Bênção·beijo da lampreia"
  },
  State_44743_WeaponDesc = {
    Text = "No início da batalha, vulnerabilidade por 3 turnos"
  },
  State_44744_WeaponDesc = {
    Text = "No início da batalha, vulnerabilidade por 3 turnos"
  },
  State_44750_Desc = {
    Text = "Ao iniciar a rodada, ganhe [StateArg1] de aritmética"
  },
  State_44750_Name = {
    Text = "Vela Negra da Criação 1"
  },
  State_44751_Desc = {
    Text = "Ao iniciar a rodada, ganhe [StateArg1] de aritmética"
  },
  State_44751_Name = {
    Text = "Vela Negra da Criação 1"
  },
  State_44752_Desc = {
    Text = "Sempre que \"Sofia\" perde 1 ponto de vida, desce 1 camada, ao chegar a 0, muda a intenção para \"Olho por Olho\" e ganha [StateArg2] escudo. Na primeira ativação, restaura todas as camadas"
  },
  State_44752_Name = {
    Text = "Impulso Enterrado"
  },
  State_44762_Desc = {
    Text = "Ao jogar \"Defesa\", coloque 1 ferimento de volta no baralho de puxar"
  },
  State_44762_Name = {Text = "Rasgar"},
  State_44763_Desc = {
    Text = "O dano crítico de todos os despertos é reduzido pela metade"
  },
  State_44763_Name = {
    Text = "<PurpleKeyWord: Cegueira>"
  },
  State_44764_Desc = {
    Text = "Ao jogar \"Ataque\", coloque 1 ferimento de volta no baralho de puxar"
  },
  State_44764_Name = {Text = "Trauma"},
  State_44807_Desc = {
    Text = "Quando estiver prestes a ser derrotado pela primeira vez, restaure a vida e mude a intenção para \"júri do espelho\", reforçando-se. Quando estiver prestes a ser derrotado pela segunda vez, restaure a vida e mude a intenção para \"mordida da loucura\", causando dano extremo em um único golpe"
  },
  State_44807_Name = {
    Text = "Carnificina Enterrada"
  },
  State_44819_Desc = {
    Text = "Se não houver <ParcloseIconKeywords:barreira>, ganhe 1 camada de <ParcloseIconKeywords:barreira> temporária; caso contrário, ganhe 10% de taxa crítica e dano crítico"
  },
  State_44819_Name = {
    Text = "<CardKeyWord:Proteção do Pai>"
  },
  State_44828_Desc = {
    Text = "Equipe Única: Ao final do turno, o Portador ganha [StateArg1] Fúria. Ao receber Dano ativo e Dano de tentáculo, ganha Escudo igual a <WeaponEffect_Num:[StateArg2]%> do dano no início do próximo turno. Se o Domínio atual for Carne, ganha Forno Carmesim igual a <WeaponEffect_Num:[StateArg2]%> do dano."
  },
  State_44828_WeaponDesc = {
    Text = "Ao final do turno, o Portador ganha <WeaponEffect_Num:[StateArg1]> Fúria. Ao receber Dano ativo ou Dano de tentáculo, ganha Escudo igual a <WeaponEffect_Num:[Float:StateArg2]%> do dano no início do próximo turno. Se o Domínio atual for Carne, ganha Forno Carmesim igual a <WeaponEffect_Num:[Float:StateArg2]%> do dano."
  },
  State_44889_Name = {
    Text = "Estado@Chefe Cão com Rosto Humano@Espelho do Fim1"
  },
  State_44890_Name = {
    Text = "Estado@Chefe Cão com Rosto Humano@Espelho do Fim2"
  },
  State_44891_Name = {
    Text = "Estado@Chefe Cão com Rosto Humano@Espelho do Fim3"
  },
  State_44903_Desc = {
    Text = "Ao receber Dano ativo ou Dano de tentáculo, [StateArg1]% do dano será convertido em quantidade de recuperação para o Forno Carmesim, durando [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_44903_Name = {
    Text = "Bênção do Criador"
  },
  State_44909_Name = {
    Text = "Consumível"
  },
  State_45018_Desc = {
    Text = "Antes do fim do turno, não é possível usar \"Golpe\""
  },
  State_45018_Name = {Text = "Paralisia"},
  State_45025_Desc = {
    Text = "Veja a lógica da greve geral para efeitos específicos. __ \"Para uso de desenvolvimento apenas\""
  },
  State_45029_Desc = {
    Text = "Veja a lógica da greve geral para efeitos específicos. __ \"Para uso de desenvolvimento apenas\""
  },
  State_45032_Desc = {
    Text = "No final do próximo turno, receba [Layer] de dano"
  },
  State_45032_Name = {
    Text = "Sangramento"
  },
  State_45039_Desc = {
    Text = "Até o início do próximo turno, sempre que Dano ativo ou Dano de tentáculo for recebido, ganha Escudo do personagem igual a [Layer]% do Dano no início do próximo turno."
  },
  State_45039_Name = {
    Text = "Chegada do Milagre"
  },
  State_45040_Desc = {
    Text = "Até o início do próximo turno, sempre que Dano ativo ou Dano de tentáculo for recebido, acumula [Layer]% do Dano como cura para o Forno Carmesim."
  },
  State_45040_Name = {
    Text = "Chegada do Milagre"
  },
  State_45049_Desc = {
    Text = "Nega o Dano do próximo ataque ativo (até 3 capas). Cada capa de Duelo Mortal reduz as capas máximas de Barreira em 1, mas não remove Barreiras já obtidas."
  },
  State_45049_Name = {Text = "Barreira"},
  State_45050_Desc = {
    Text = "Nega o Dano do próximo ataque ativo (até 3 capas). Cada capa de Duelo Mortal reduz as capas máximas de Barreira em 1, mas não remove Barreiras já obtidas."
  },
  State_45050_Name = {
    Text = "<ReinforceColour:Barreira>"
  },
  State_45064_Name = {
    Text = "Contador do Banquete Silencioso__\"Dev Only\""
  },
  State_45069_Desc = {
    Text = "Veja a lógica da greve geral para efeitos específicos. __ \"Para uso de desenvolvimento apenas\""
  },
  State_45072_Name = {
    Text = "Contagem de Santificação"
  },
  State_45073_Desc = {
    Text = "Poder de cálculo das cartas reduzido"
  },
  State_45076_Desc = {
    Text = "Ao impor, dissipar o escudo do alvo e atrasar a cura, antes do final da rodada, a cura e os efeitos de escudo recebidos são reduzidos em 50%"
  },
  State_45076_Name = {
    Text = "Lesão grave"
  },
  State_45137_Desc = {
    Text = "Após usar a exaltação da loucura, sela todos os despertadores por um turno e ganha um turno de vulnerabilidade"
  },
  State_45137_Name = {
    Text = "Pecado original: Cadáver do Caminho"
  },
  State_45139_Desc = {
    Text = "Após usar a Fúria Explosiva, dissipa aleatoriamente 1 efeito negativo."
  },
  State_45139_Name = {
    Text = "Abençoado · Caminho dos Ossos"
  },
  State_45148_Desc = {
    Text = "O dano crítico de todos os despertos é reduzido pela metade"
  },
  State_45148_Name = {
    Text = "<PurpleKeyWord: Cegueira>"
  },
  State_45166_Desc = {
    Text = "A roda do destino equipada antes do fim da rodada torna-se inválida."
  },
  State_45166_Name = {Text = "Enrolar"},
  State_45206_Desc = {
    Text = "Com fé na redenção. Consumindo toda a quantidade de recuperação restante da fornalha carmesim, obterá um escudo de 150% da quantidade consumida, esse escudo não será afetado por bônus ou penalidades de escudo, mas ignora os limites de escudo"
  },
  State_45206_Name = {Text = "Redenção"},
  State_45248_Name = {Text = "Contador"},
  State_45328_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após \"Fúria Explosiva\", concede a si mesmo <TauntKeywords:Provocação> e <Block:[Block:StateArg1]> Escudo do personagem."
  },
  State_45328_Name = {
    Text = "Mágica 35mm"
  },
  State_45329_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: \"Golpe\" pode escolher o alvo. Antes de atacar, <PVPRepelKeywords:repelir> todos os estados positivos dissipáveis do alvo para o despertador atrás dele."
  },
  State_45329_Name = {
    Text = "O Chamado do Mar Profundo"
  },
  State_45331_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Ao equipar e após \"Golpe\", as \"Habilidades\" Não Derivadas do portador na mão mudarão sequencialmente para suas outras \"Habilidades\" [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_45331_Name = {
    Text = "Flores e Poemas do Passado"
  },
  State_45332_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Cada vez que o portador sofre DANO Ativo, outros aliados ganham <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_45332_Name = {
    Text = "O olhar de Isarau"
  },
  State_45333_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Limite de cartas na mão +[StateArg1], Após \"Fúria Explosiva\", ganhe <Energy:[Energy:StateArg2]> Fúria."
  },
  State_45333_Name = {
    Text = "Beijo Ardente de Despedida"
  },
  State_45334_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: \"Habilidade\" muda o próximo \"Ataque\" deste turno para atingir alvos aleatórios e adicionalmente ataca [StateArg1] alvos aleatórios."
  },
  State_45334_Name = {
    Text = "Homem no espelho"
  },
  State_45345_Desc = {
    Text = "Para registrar quantas vezes a habilidade de fertilidade de fase 1 foi usada"
  },
  State_45345_Name = {
    Text = "Identificação de Fertilidade 1"
  },
  State_45346_Desc = {
    Text = "Para registrar quantas vezes a habilidade de fertilidade de fase 2 foi usada"
  },
  State_45346_Name = {
    Text = "Identificação de Fertilidade 2"
  },
  State_45354_Desc = {
    Text = "Esta carta não pode ser jogada"
  },
  State_45354_Name = {
    Text = "Não pode ser jogado __ \"Somente para Desenvolvimento\""
  },
  State_45356_Desc = {
    Text = "No final do turno, transforme-se na última carta \"habilidade\" jogada, reduzindo seu custo de Aritmética em 2. Após jogá-la, \"Entidade da Névoa Cinza\" é embaralhada no baralho."
  },
  State_45356_Name = {
    Text = "<CardKeyWord:Verdadeira Forma da Névoa>"
  },
  State_45364_Desc = {
    Text = "No início do próximo turno, esta entidade acordada ganha [Layer] cartas de \"ataque\""
  },
  State_45364_Name = {
    Text = "Golpe retardado"
  },
  State_45385_Desc = {
    Text = "Durante esta batalha, todo o dano causado diminui em [Layer] pontos, não podendo ser dissipado, incluindo [DescArg1] camadas de redução temporária de poder, que serão removidas no fim do turno"
  },
  State_45385_Name = {
    Text = "Redução de força"
  },
  State_45387_Desc = {
    Text = "Todo o dano causado +[Layer] nesta batalha e não pode ser dissipado. [DescArg1] camadas de Força Temporária serão removidas no final do turno."
  },
  State_45387_Name = {Text = "Força"},
  State_45397_Desc = {
    Text = "No início do turno, converta 1 camada de barreira em força."
  },
  State_45397_Name = {
    Text = "Vitória da rosa"
  },
  State_45403_Desc = {
    Text = "No início do próximo turno, ganhe [Layer] de carga"
  },
  State_45403_Name = {
    Text = "Carga adiada"
  },
  State_45407_Desc = {
    Text = "A loucura obtida e a loucura retardada são reduzidas em 50%, e toda a loucura retardada é removida imediatamente."
  },
  State_45407_Name = {Text = "Vazio"},
  State_45656_Desc = {
    Text = "A terceira ressurreição da mãe árvore, ativando a habilidade de fertilidade 2"
  },
  State_45658_Desc = {
    Text = "A primeira ressurreição da mãe árvore, ativando a habilidade de fertilidade"
  },
  State_45661_Desc = {
    Text = "Quando a vida chegar a 0, a vida será ajustada para 1 ponto, não sofrerá mais danos e se preparará para liberar \"Fusão Múltipla\""
  },
  State_45661_Name = {
    Text = "Fusão múltipla"
  },
  State_45715_Desc = {
    Text = "Obter força temporária igual a [StateArg1]% do dano de tentáculo"
  },
  State_45715_Name = {
    Text = "usurpação"
  },
  State_45716_Desc = {
    Text = "Obtenha um poder temporário equivalente a [StateArg1]% de dano de tentáculo. Golias obtém 25% de taxa crítica temporária"
  },
  State_45716_Name = {
    Text = "usurpação"
  },
  State_45717_Desc = {
    Text = "Aumenta o dano base de \"força da grande espada\" e \"dano de decapitação\" em 25% nesta batalha. Golias recebe <Energy:[Energy:StateArg2]> pontos de loucura"
  },
  State_45717_Name = {
    Text = "hibernação"
  },
  State_45718_Desc = {
    Text = "Aumenta o dano base de \"força da grande espada\" e \"dano de decapitação\" em 25% nesta batalha"
  },
  State_45718_Name = {
    Text = "hibernação"
  },
  State_46057_Name = {
    Text = "Poder de cálculo"
  },
  State_46079_Desc = {
    Text = "Neste turno, cada vez que o alvo recebe dano ativo, cura o aliado com menos vida em [Layer]"
  },
  State_46079_Name = {
    Text = "Sangue Santo guia"
  },
  State_46119_Desc = {
    Text = "Na próxima vez que for atacado, aplique entrelaçar ao atacante"
  },
  State_46119_Name = {
    Text = "armadilha do labirinto"
  },
  State_46124_Desc = {
    Text = "Antes do fim do turno, não é possível realizar nenhuma ação"
  },
  State_46124_Name = {
    Text = "Petrificação"
  },
  State_46138_Desc = {
    Text = "Torna-se a última \"habilidade\" usada pelo oponente, com custo -1"
  },
  State_46138_Name = {
    Text = "<CardKeyWord:Estrela Mimética>"
  },
  State_46139_Desc = {
    Text = "Cada vez que for atacado ativamente, ganhe [Layer] camadas de carga e inflija [Layer] camadas de estagnação no atacante."
  },
  State_46139_Name = {
    Text = "Gravidade anômala"
  },
  State_46155_Desc = {
    Text = "Após a própria \"Habilidade\", ganhe [StateArg1] camadas de carga e reduza a contagem de camadas em 1. No final do turno, consuma todas as camadas, restaurando [StateArg2] de saúde para cada camada."
  },
  State_46155_Name = {
    Text = "Sangue aberrante"
  },
  State_46243_Name = {
    Text = "Contador de Discernimento__\"Dev Only\""
  },
  State_46255_Desc = {
    Text = "Veja a lógica da greve geral para efeitos específicos. __ \"Para uso de desenvolvimento apenas\""
  },
  State_46256_Desc = {
    Text = "Veja a lógica da greve geral para efeitos específicos. __ \"Para uso de desenvolvimento apenas\""
  },
  State_46322_Desc = {
    Text = "Ao iniciar a rodada, ganhe 30 de Fusão de embriões."
  },
  State_46322_Name = {
    Text = "Yū Hashi Demo"
  },
  State_46323_Desc = {
    Text = "Após o início do Turno Ultra, ganhe 100 pontos de Fúria e 7 pontos de Força no início do turno."
  },
  State_46323_Name = {
    Text = "Teste de Liz"
  },
  State_46324_Desc = {
    Text = "Ganhe 1 \"Inspiração\" por turno"
  },
  State_46324_Name = {
    Text = "Jenkins testa jogar"
  },
  State_46329_Desc = {
    Text = "Após o início da batalha, ganhe 600 pontos de s-energia, e o lotan ganha 50 pontos de aliemus; após o lotan liberar a exaltação, ganha mais 44 pontos de aliemus"
  },
  State_46329_Name = {
    Text = "Bônus de teste"
  },
  State_46330_Desc = {
    Text = "Ao iniciar a rodada, ganhe 30 de Fusão de embriões, 10 de Fúria, [DescArg1] de FOR, e adicione 3 \"golpear\" ao Mazo de robo."
  },
  State_46330_Name = {
    Text = "Teste de Shiro"
  },
  State_46333_Name = {
    Text = "Teste de Reya"
  },
  State_46334_Desc = {
    Text = "Após o início do 4º turno, ganhe 100 pontos de loucura"
  },
  State_46334_Name = {Text = "Falos Demo"},
  State_46336_Desc = {
    Text = "Ao iniciar a rodada, ganhe 30 de Fusão de embriões e 10 de Fúria."
  },
  State_46336_Name = {
    Text = "Agrippa Demo"
  },
  State_46337_Desc = {
    Text = "No início do turno, ganhe 10 de loucura"
  },
  State_46337_Name = {
    Text = "Caecus Demo"
  },
  State_46338_Desc = {
    Text = "Ao iniciar a rodada, ganhe 30 de Fusão de embriões e 10 de Fúria."
  },
  State_46338_Name = {Text = "Feint Demo"},
  State_46427_Desc = {
    Text = "Veja a lógica da greve geral para efeitos específicos. __ \"Para uso de desenvolvimento apenas\""
  },
  State_46428_Desc = {
    Text = "Veja a lógica da greve geral para efeitos específicos. __ \"Para uso de desenvolvimento apenas\""
  },
  State_46429_Desc = {
    Text = "Veja a lógica da greve geral para efeitos específicos. __ \"Para uso de desenvolvimento apenas\""
  },
  State_46441_Desc = {
    Text = "Imune a todo dano, removido no início do turno"
  },
  State_46441_Name = {
    Text = "Imunidade ao dano"
  },
  State_46442_Name = {
    Text = "Cartões são proibidos de modificar tipos de alvo de ataque __ \"Somente para uso em desenvolvimento\""
  },
  State_46500_Desc = {
    Text = "Veja a lógica da greve geral para efeitos específicos. __ \"Para uso de desenvolvimento apenas\""
  },
  State_46505_Desc = {
    Text = "Neste turno, sempre que receber Dano ativo, obtém [Layer] Fúria."
  },
  State_46505_Name = {
    Text = "Conversão de dor"
  },
  State_46508_Desc = {
    Text = "Ao sofrer Desmaio, o alvo não pode agir até o final do turno. Receber dano de Desmaio concede Resistência. Se a Resistência estiver ativa, o dano de Desmaio subsequente é dobrado, mas o efeito de Desmaio é anulado."
  },
  State_46508_Name = {
    Text = "Resistência"
  },
  State_46511_Desc = {
    Text = "O Dano de \"Superposição das mil faces\" deste Corpo Desperto aumenta em [Layer]."
  },
  State_46511_Name = {
    Text = "Superposição das mil faces"
  },
  State_46512_Desc = {
    Text = "Antes do fim da rodada, este despertador sofre [Layer] de dano após jogar uma carta."
  },
  State_46512_Name = {
    Text = "Bloqueio de Cartão"
  },
  State_46513_Desc = {
    Text = "Aumenta o próximo poema, concedendo um efeito extra, não pode ser dissipado."
  },
  State_46513_Name = {
    Text = "Tinta de luto"
  },
  State_46536_Desc = {
    Text = "Se o parâmetro de estado 1 for 0, compre cartas; caso contrário, apenas exiba o texto flutuante"
  },
  State_46536_Name = {
    Text = "Comprar carta"
  },
  State_46538_Desc = {
    Text = "No início da exploração, ganhe [StateArg1] de Loucura"
  },
  State_46538_Name = {
    Text = "Sinais Loucos"
  },
  State_47072_Desc = {
    Text = "Nesta rodada, a taxa crítica dos cartões de ataque aumenta em +[Layer]%"
  },
  State_47072_Name = {
    Text = "Crítico de ataque"
  },
  State_47089_Name = {
    Text = "Efeito do teste__\"Apenas para desenvolvimento\""
  },
  State_47096_Desc = {
    Text = "Sempre que jogar uma carta \"Inspiração\", Dafodil ganha [StateArg1] pontos de Loucura e [StateArg2] pontos de força, até 5 vezes por turno. (Restam [DescArg1] vezes)"
  },
  State_47096_Name = {
    Text = "Precipitado de protoplasma"
  },
  State_47189_Name = {
    Text = "Alternar para Personalidade Maníaca. Carne·Depressão: <EmbryoFusionIconKeywords:Fusão de embriões> +[Blood:StateArg5], acumular [StateArg6] pontos de recuperação do Forno Carmesim"
  },
  State_47192_Name = {
    Text = "Personalidade deprimida: Também faz com que outros Corpos Despertos obtenham [DescArg1] vezes a Fúria. Personalidade Maníaca: Obtém [DescArg2] vezes a Fúria adicionalmente"
  },
  State_47199_Name = {
    Text = "Mude para a Personalidade deprimida. Carne e sangue·Mania: O Dano recebe um bônus de [DescArg1]x <PowerIconKeywords:poder> e aplica <BleedingIconKeywords:Sangramento> igual a 200% do Dano causado ao alvo. Ganha [StateArg7] <PowerIconKeywords:poder>"
  },
  State_47204_Name = {
    Text = "Mude para a personalidade mania. Caos·depressão: Ganhe <Posse:[StateArg1]> pontos de s-energia, o próximo bando tem 2 ativações"
  },
  State_47206_Name = {
    Text = "Mude para a personalidade maníaca. Mar Profundo·depressão: <WeaknessIconKeywords:fraqueza> e <VulnerabilityIconKeywords:vulnerável> o alvo por 2 turnos, gera 1 tentáculo, <TentacleInjurieIconKeywords:dano de tentáculo>+ [TentaclePower:StateArg3]"
  },
  State_47209_Name = {
    Text = "Trocar para Personalidade deprimida. Ultra: Sintoma: Loucura: Obtém 15% do Dano causado como <RetaliateIconKeywords:Contador>, depois causa uma quantidade igual de <FixedDamage:Dano Puro> aos outros inimigos. Para cada carta de \"Discernimento\" disparada neste turno, aumenta este Dano em [StateArg9] pelo restante do turno, até [StateArg10]"
  },
  State_47211_Name = {
    Text = "Personalidade deprimida: Reduz o Consumo de potência de cálculo de [DescArg1] Cartas com maior Poder de cálculo na Mão em 1 ponto e obtém <RetainIconKeywords:Preservar> Temporário. Personalidade Maníaca: Causa [DescArg2] instâncias de Dano adicionalmente"
  },
  State_47212_Name = {
    Text = "Faz \"24\" alternar entre personalidades depressivas e maníacas, desencadeando efeitos adicionais conforme o domínio e a personalidade atuais"
  },
  State_47216_Name = {
    Text = "Mude para a personalidade depressiva. Aequor·mania: Este dano recebe [StateArg4]% <TentacleInjurieIconKeywords:dano de tentáculo> de bônus e causa 30% de dano a todos os inimigos <IntoxicationIconKeywords:veneno>"
  },
  State_47217_Name = {
    Text = "Mudar para personalidade depressiva. Caos·Mania: Causa 3 danos, aumentando todo dano causado por \"24\" em [StateArg2] pontos"
  },
  State_47218_Name = {
    Text = "Mudar para personalidade maníaca. Transdimensional·Depressão: Adicione 2 cartas \"Inspiração\" na sua mão, faz o alvo perder temporariamente [Power:StateArg8] pontos de <PowerIconKeywords:força>"
  },
  State_47222_Name = {
    Text = "Personalidade deprimida: Reduz o Consumo de potência de cálculo de [DescArg1] Cartas com maior Poder de cálculo na Mão em 1 ponto e obtém <RetainIconKeywords:Preservar> Temporário. <AwakerCard_24Lost:Personalidade Maníaca: Causa [DescArg2] instâncias de Dano adicionalmente>"
  },
  State_47224_Name = {
    Text = "Personalidade deprimida: Também faz com que outros Corpos Despertos obtenham [DescArg1] vezes a Fúria. <AwakerCard_24Lost:Personalidade Maníaca: Obtém [DescArg2] vezes a Fúria adicionalmente>"
  },
  State_47228_Name = {
    Text = "<AwakerCard_24Lost:Personalidade deprimida: Também faz com que outros Corpos Despertos obtenham [DescArg1] vezes a Fúria.> Personalidade Maníaca: Obtém [DescArg2] vezes a Fúria adicionalmente"
  },
  State_47229_Name = {
    Text = "<AwakerCard_24Lost:Personalidade deprimida: Reduz o Consumo de potência de cálculo de [DescArg1] Cartas com maior Poder de cálculo na Mão em 1 ponto e obtém <RetainIconKeywords:Preservar> Temporário.> Personalidade Maníaca: Causa [DescArg2] instâncias de Dano adicionalmente"
  },
  State_47451_Name = {
    Text = "A Ordem de chave de Ryker desativa os efeitos da Roda do destino"
  },
  State_47485_Name = {
    Text = "Personalidade deprimida: Reduz o Consumo de potência de cálculo de [DescArg1] Cartas com maior Poder de cálculo na Mão em 2 pontos e obtém <RetainIconKeywords:Preservar> Temporário. Personalidade Maníaca: Causa [DescArg2] instâncias de Dano adicionalmente"
  },
  State_47486_Name = {
    Text = "Personalidade deprimida: Reduz o Consumo de potência de cálculo de [DescArg1] Cartas com maior Poder de cálculo na Mão em 2 pontos e obtém <RetainIconKeywords:Preservar> Temporário. <AwakerCard_24Lost:Personalidade Maníaca: Causa [DescArg2] instâncias de Dano adicionalmente>"
  },
  State_47488_Name = {
    Text = "Personalidade deprimida: Obtém <Energy: [DescArg1]> pontos de Fúria adicionalmente. Personalidade Maníaca: Obtém [DescArg2] instâncias de Escudo adicionalmente"
  },
  State_47489_Name = {
    Text = "<AwakerCard_24Lost:Personalidade deprimida: Reduz o Consumo de potência de cálculo de [DescArg1] Cartas com maior Poder de cálculo na Mão em 2 pontos e obtém <RetainIconKeywords:Preservar> Temporário.> Personalidade Maníaca: Causa [DescArg2] instâncias de Dano adicionalmente"
  },
  State_47492_Name = {
    Text = "Personalidade deprimida: Obtém <Energy: [DescArg1]> pontos de Fúria adicionalmente. <AwakerCard_24Lost:Personalidade Maníaca: Causa [DescArg2] instâncias de Dano adicionalmente>"
  },
  State_47493_Name = {
    Text = "Personalidade deprimida: Obtém <Energy: [DescArg1]> pontos de Fúria adicionalmente. Personalidade Maníaca: Causa [DescArg2] instâncias de Dano adicionalmente"
  },
  State_47494_Name = {
    Text = "Personalidade deprimida: Também faz com que outros Corpos Despertos obtenham [DescArg1] vezes a Fúria, <WeaknessIconKeywords:Fraqueza> em todos os inimigos por [DescArg3] turnos. Personalidade Maníaca: Obtém [DescArg2] vezes a Fúria adicionalmente, <VulnerabilityIconKeywords:Vulnerável> em todos os inimigos por [DescArg3] turnos"
  },
  State_47495_Name = {
    Text = "Personalidade deprimida: Também faz com que outros Corpos Despertos obtenham [DescArg1] vezes a Fúria, <WeaknessIconKeywords:Fraqueza> em todos os inimigos por [DescArg3] turnos. <AwakerCard_24Lost:Personalidade Maníaca: Obtém [DescArg2] vezes a Fúria adicionalmente, Vulnerável em todos os inimigos por [DescArg3] turnos>"
  },
  State_47496_Name = {
    Text = "<AwakerCard_24Lost:Personalidade deprimida: Também faz com que outros Corpos Despertos obtenham [DescArg1] vezes a Fúria, Fraqueza em todos os inimigos por [DescArg3] turnos.> Personalidade Maníaca: Obtém [DescArg2] vezes a Fúria adicionalmente, <VulnerabilityIconKeywords:Vulnerável> em todos os inimigos por [DescArg3] turnos"
  },
  State_47498_Name = {
    Text = "<AwakerCard_24Lost:Personalidade deprimida: Obtém [DescArg1] pontos de Fúria adicionalmente.> Personalidade Maníaca: Causa [DescArg2] instâncias de Dano adicionalmente"
  },
  State_47499_Name = {
    Text = "<AwakerCard_24Lost:Personalidade deprimida: obtém [DescArg1] pontos de Fúria adicionais.>Personalidade Maníaca: obtém [DescArg2] Escudos adicionais"
  },
  State_47500_Name = {
    Text = "Personalidade deprimida: Obtém <Energy: [DescArg1] > pontos de Fúria adicionalmente. <AwakerCard_24Lost:Personalidade Maníaca: Obtém [DescArg2] instâncias de Escudo adicionalmente>"
  },
  State_47517_Desc = {
    Text = "<PVPWeaponKeywords:wheel of destiny>: No final do turno, descarte [StateArg1] cartas de outros despertadores. Se o descarte for bem-sucedido, compre [StateArg2] cartas."
  },
  State_47517_Name = {
    Text = "Determinação do Bacalhau Prateado"
  },
  State_47518_Name = {
    Text = "Contador da Determinação do Bacalhau Prateado__\"Dev Only\""
  },
  State_47528_Desc = {
    Text = "Neste turno, \"Golpe\" causa +[DescArg1]% de Dano. <PVPPenetrateKeywords:Penetração>."
  },
  State_47528_Name = {
    Text = "Resíduos da Besta Estelar"
  },
  State_47530_Desc = {
    Text = "Considerado como a \"Habilidade\" jogada por último neste turno."
  },
  State_47530_Name = {
    Text = "<CardKeyWord:Simulação>"
  },
  State_47557_Desc = {
    Text = "Equipe Única: O Portador muda para a Persona Bacalhau de Prata após o início da exploração. Ele alternará entre as Personas Bacalhau de Prata e Gato após usar a Fúria Explosiva.\nBacalhau de Prata: Ganha <WeaponEffect_Num:[StateArg1]> de Energia da Chave de Prata após causar Dano ativo. Gato: Ganha um aumento de Dano Crítico Temporário de <WeaponEffect_Num:+[StateArg2]%> após causar Dano ativo. Esses efeitos compartilham um máximo de 5 ativações por turno."
  },
  State_47557_WeaponDesc = {
    Text = "O Portador muda para a Persona Bacalhau de Prata após o início da exploração. Ele alternará entre as Personas Bacalhau de Prata e Gato após usar a Fúria Explosiva.\nBacalhau de Prata: Ganha <WeaponEffect_Num:[StateArg1]> de Energia da Chave de Prata após causar Dano ativo. Gato: Ganha um aumento de Dano Crítico Temporário de <WeaponEffect_Num:+[StateArg2]%> após causar Dano ativo. Esses efeitos compartilham um máximo de 5 ativações por turno."
  },
  State_47822_Desc = {
    Text = "Se receber \"Paralisia\" novamente no próximo turno, todos os seus \"golpear\" se tornam \"Ilusão\", não pode ser dissipado, e dura até o final do próximo turno."
  },
  State_47822_Name = {
    Text = "Um Pouco Paralisado"
  },
  State_47825_Desc = {
    Text = "No início do turno, o efeito correspondente da habilidade será ativado."
  },
  State_47825_Name = {
    Text = "<CardKeyWord:Atraso>"
  },
  State_47826_Desc = {
    Text = "·O Dano é dobrado quando o alvo está sob \"Paralisia\", caso contrário, \"golpear\" não pode ser usado neste turno.\n·Após 2 turnos consecutivos sob \"Paralisia\", todos os seus \"golpear\" se tornam \"Ilusão\"."
  },
  State_47826_Name = {
    Text = "<WeaknessColour:Paralisia>"
  },
  State_47827_Desc = {
    Text = "Cada camada diminui todo o dano causado nesta batalha em 1 ponto, não pode ser dissipada."
  },
  State_47827_Name = {
    Text = "<WeaknessColour: Redução de Poder>"
  },
  State_47828_Desc = {
    Text = "Quando este estado é infligido a um inimigo, causa a mesma quantidade de Dano. Se o alvo já estiver \"Entrelaçados\", o Dano causado é dobrado. \"Entrelaçados\" desativa a Roda do destino equipada do alvo até o final do turno."
  },
  State_47828_Name = {
    Text = "<WeaknessColour:Entrelaçar>"
  },
  State_47830_Desc = {
    Text = "Ao impor, dissipar o escudo do alvo e atrasar a cura, antes do final da rodada, a cura e os efeitos de escudo recebidos são reduzidos em 50%"
  },
  State_47830_Name = {
    Text = "<PVPVulnerabilityIconColour:Ferimento Grave>"
  },
  State_47831_Desc = {
    Text = "Quando em Desmaio, o alvo não pode agir até o final do turno. Sofrer dano de Desmaio concede Resistência. Se a Resistência estiver ativa, o dano de Desmaio subsequente é dobrado, mas o efeito de Desmaio é anulado."
  },
  State_47831_Name = {
    Text = "<ComaColour:Petrificação>"
  },
  State_47832_Desc = {
    Text = "Inclui ratos infectados, ratos elétricos, ratos dementes"
  },
  State_47832_Name = {
    Text = "<CardKeyWord:Cartão de Rato>"
  },
  State_47833_Desc = {
    Text = "Inclui lenço de pombo branco, caixa mágica de separação reversa, microfone de telepatia"
  },
  State_47833_Name = {
    Text = "<CardKeyWord:Magia Surpreendente>"
  },
  State_47841_Desc = {
    Text = "Usar a chave [Layer] vezes nesta batalha terá efeito duplo"
  },
  State_47841_Name = {
    Text = "Ordem Dupla de Chave"
  },
  State_47842_Desc = {
    Text = "A loucura obtida e a loucura retardada são reduzidas em 50%, e toda a loucura retardada é removida imediatamente."
  },
  State_47842_Name = {
    Text = "<PVPEmptinessColour:Vazio>"
  },
  State_47843_Desc = {
    Text = "Faz o despertador sair do estado de morte e coloca todo seu baralho de cartas no monte de compra"
  },
  State_47843_Name = {
    Text = "<PVPResurrectionColour:Ressurreição>"
  },
  State_47844_Desc = {
    Text = "Gera um efeito confuso aleatório"
  },
  State_47844_Name = {
    Text = "<PVPWonderfulEffectKeywords:Efeito Maravilhoso>"
  },
  State_47845_Desc = {
    Text = "A carta gera efeito enquanto estiver na mão"
  },
  State_47845_Name = {
    Text = "<CardKeyWord:Possuir>"
  },
  State_47873_Desc = {
    Text = "No final do próximo turno, cause dano igual ao número de camadas"
  },
  State_47873_Name = {
    Text = "<PVPVulnerabilityIconColour:sangrando>"
  },
  State_47887_Name = {
    Text = "Efeitos diferentes são obtidos de acordo com o domínio da equipe atual"
  },
  State_47888_Name = {
    Text = "Carne e sangue: a cada 1 ponto de Poder de cálculo consumido por \"24\", <EmbryoFusionIconKeywords:Fusão de embriões> +[Blood:DescArg1], obtém [StateArg3] pontos de <PowerIconKeywords:Força>. A Fúria Explosiva de \"24\" recebe um bônus adicional de 300% de Força"
  },
  State_47889_Name = {
    Text = "Aequor: O dano \"24\" recebe um bônus de [StateArg2]% <TentacleInjurieIconKeywords:dano de tentáculo> e inflige <IntoxicationIconKeywords:veneno> igual a 10% do dano causado. A exaltação de \"24\" pode desencadear [StateArg6]% de <IntoxicationIconKeywords:veneno> nos inimigos."
  },
  State_47892_Name = {
    Text = "Caos: A Taxa de Crítico e o Dano crítico de \"24\" +[StateArg4]%. Cada uso de Ordem de chave aumenta o Dano Final da Fúria Explosiva de \"24\" em [StateArg1]%"
  },
  State_47894_Name = {
    Text = "Dano causado por ultrapassado: \"24\" recebe bônus de dano [StateArg5]% <RetaliateIconKeywords:retaliação>, ao final do turno, 1 carta \"inspiração\" é embaralhada na pilha de descarte, limite de cartas na mão +2"
  },
  State_48009_Desc = {
    Text = "O primeiro efeito ativado em cada turno tem efeito extra [StateArg1] vezes"
  },
  State_48009_Name = {
    Text = "<Rune_19:Concerto>"
  },
  State_48010_Desc = {
    Text = "Marca de conjunto"
  },
  State_48010_Name = {
    Text = "Marca de conjunto"
  },
  State_48011_Desc = {
    Text = "O primeiro efeito ativado em cada turno tem efeito extra [StateArg1] vezes"
  },
  State_48011_Name = {
    Text = "<Rune_19_High:Concerto Avançado>"
  },
  State_48011_WeaponDesc = {
    Text = "Após jogar, ativa [StateArg1] vezes extras, consumo"
  },
  State_48012_Desc = {
    Text = "Fazer o cartão marcado efetuar 2 vezes na primeira utilização por turno"
  },
  State_48012_Name = {
    Text = "<CardKeyWord: Oração: Conjunto>"
  },
  State_48013_Desc = {
    Text = "Fazer o cartão marcado efetuar 3 vezes na primeira utilização por turno"
  },
  State_48013_Name = {
    Text = "<CardKeyWord: Oração: Conjunto Avançado>"
  },
  State_48019_Name = {
    Text = "<CardKeyWord:Simulação>"
  },
  State_48020_Name = {
    Text = "<CardKeyWord: Nascimento de uma Alma>"
  },
  State_48021_Name = {
    Text = "<CardKeyWord:Verdadeira Forma da Névoa>"
  },
  State_48078_Name = {
    Text = "<CardKeyWord:Estrela Mimética>"
  },
  State_48099_Desc = {
    Text = "Ao final do turno, \"24\" ganha [DescArg1] de exaltação, e a cada vez que \"24\" libera a exaltação, este efeito obtém 1 de exaltação"
  },
  State_48099_Name = {
    Text = "Pesquisa Comportamental de Pavlov"
  },
  State_48099_WeaponDesc = {
    Text = "No fim do turno, o portador ganha 3 de Fúria. Se a recarga de Fúria for maior que 10, ganha 2 de Fúria extra"
  },
  State_48100_Name = {
    Text = "Estado@24Contagem de Pesquisa de Comportamento Pavlov"
  },
  State_48100_WeaponDesc = {
    Text = "No fim do turno, o portador ganha 3 de Fúria. Se a recarga de Fúria for maior que 10, ganha 2 de Fúria extra"
  },
  State_48107_Desc = {
    Text = "A primeira \"Habilidade\" jogada pelo Portador em cada turno causa +[StateArg1] % de Dano."
  },
  State_48107_Name = {
    Text = "Espada do Titã"
  },
  State_48108_Desc = {
    Text = "Após o equipador jogar \"habilidade\" pela primeira vez em cada rodada, uma cópia que consome - [StateArg1] de aritmética é embaralhada no baralho"
  },
  State_48108_Name = {Text = "Fouetté"},
  State_48110_Desc = {
    Text = "\"Habilidade\" causa o próximo \"Ataque\" desta rodada a direcionar-se a um inimigo aleatório e além disso atacar [StateArg1] mais alvos aleatórios."
  },
  State_48110_Name = {
    Text = "Homem no espelho"
  },
  State_48140_Desc = {
    Text = "No início da exploração, \"24\" entra no estado de Personalidade deprimida.\n<School_1:Caos: Depressão>: ganha <Posse:[StateArg1]> pontos de Energia de chave. O próximo Ordem de chave tem 2 ativações.\n<School_1:Caos: Mania>: causa 3 danos, aumentando todo dano causado por \"24\" em [StateArg2].\n<School_2:Mar Profundo: Depressão>: aplica <WeaknessIconKeywords:Sintoma: Enfraquecer> e <VulnerabilityIconKeywords:Vulnerável> ao alvo por 2 turnos, gerando 1 tentáculo com <TentacleInjurieIconKeywords:Dano de tentáculo> +[StateArg3].\n<School_2:Mar Profundo: Mania>: este dano recebe um bônus de [StateArg4]% de <TentacleInjurieIconKeywords:Dano de tentáculo> e causa Envenenamento de 30% do dano a todos os inimigos <IntoxicationIconKeywords:Envenenamento>.\n<School_3:Carne: Depressão>: <EmbryoFusionIconKeywords:Fusão de embriões> +[Blood:StateArg5], acumulando [StateArg6] pontos do Forno Carmesim.\n<School_3:Carne: Mania>: o dano recebe um bônus de 6× <PowerIconKeywords:STR> e aplica <BleedingIconKeywords:Sangramento> de 200% do dano ao alvo, ganhando [StateArg7] de <PowerIconKeywords:STR>.\n<School_4:Ultra: Depressão>: adiciona 2 cartas de \"Discernimento\" à mão, reduzindo temporariamente o <PowerIconKeywords:STR> do alvo em [StateArg8].\n<School_4:Ultra: Mania>: ganha <RetaliateIconKeywords:Contrataque> igual a 15% do dano causado, em seguida causa a mesma quantidade de <RealDamage:Dano Fixo> a outros inimigos. A cada carta de \"Discernimento\" disparada neste turno, aumenta esse dano em [StateArg9], até um máximo de [StateArg10]."
  },
  State_48140_Name = {
    Text = "Domínio e Efeito de Personalidade"
  },
  State_48141_Desc = {
    Text = "<School_1:Caos>: A taxa crítica e o dano crítico de \"24\" +[StateArg4]%. Cada uso de ordem de chave aumenta o Dano Final da Fúria Explosiva de \"24\" em [StateArg1]%.\n <School_2:Mar Profundo>: O dano causado por \"24\" recebe um bônus de [StateArg2]% de <TentacleInjurieIconKeywords:Dano de tentáculo> e causa <IntoxicationIconKeywords:Envenenamento> equivalente a 10% do dano causado. A Fúria Explosiva de \"24\" pode desencadear 50% de <IntoxicationIconKeywords:Envenenamento> nos inimigos.\n <School_3:Carne e sangue>: A cada 1 ponto de poder de cálculo consumido por \"24\", <EmbryoFusionIconKeywords:Fusão de embriões> +[Blood:5], \"24\" ganha [StateArg3] <PowerIconKeywords:STR>. Sua Fúria Explosiva recebe um bônus adicional de 300% de STR.\n <School_4:Ultra>: O dano causado por \"24\" recebe um bônus de [StateArg5]% de <RetaliateIconKeywords:Contrataque>. Ao final do turno, 1 carta de \"Discernimento\" é embaralhada na pilha de descarte, limite de cartas na mão +2."
  },
  State_48141_Name = {
    Text = "Efeito de Domínio"
  },
  State_48149_Name = {
    Text = "Não ative efeitos especiais da face da carta __ \"Para uso de desenvolvimento apenas\""
  },
  State_48176_Desc = {
    Text = "Durante esta demonstração, ganhe 1 ponto de aritmética por turno, e para cada 1 ponto de aritmética consumido, ganhe 30 pontos de energia da chave de prata"
  },
  State_48176_Name = {Text = "\"24\" Teste"},
  State_48198_Desc = {
    Text = "Nesta demonstração, ganhe 1 carta \"Inspiração\" por turno"
  },
  State_48198_Name = {Text = "\"24\" Teste"},
  State_48199_Desc = {
    Text = "Durante esta demonstração, ganhe 1 ponto de aritmética por turno"
  },
  State_48199_Name = {Text = "\"24\" Teste"},
  State_48589_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e dobrar sua força, começando a lutar em sua verdadeira forma"
  },
  State_48589_Name = {
    Text = "Ainda não despertado"
  },
  State_48607_Name = {
    Text = "Arithmetica do Cartão Genérico reduzido __ \"Apenas Para Desenvolvimento\""
  },
  State_48822_Desc = {
    Text = "No início da rodada das mecânicas do domínio carnal, o ganho de fusão de embrião é aumentado em 50%"
  },
  State_48822_Name = {
    Text = "Vida eterna"
  },
  State_48923_Desc = {
    Text = "A sombra \"24\" já despertou, use o último \"salve-me\" para encontrar uma oportunidade!"
  },
  State_48923_Name = {
    Text = "Sombra \"24\" Despertar!"
  },
  State_48923_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_49063_Desc = {
    Text = "Os danos do \"golpe\" de Lotan aumentaram em 30%"
  },
  State_49063_Name = {
    Text = "Vontade de Luta Elevada"
  },
  State_49109_Desc = {
    Text = "A carta ganha <RetainIconKeywords:manter>, no final do turno, se estiver na mão, recebe 1 cópia original desta carta de comando com <DepleteIconKeywords:consumo>."
  },
  State_49109_Name = {
    Text = "<Rune_20_High:Gestação>"
  },
  State_49109_WeaponDesc = {
    Text = "Após jogar, ativa [StateArg1] vezes extras, consumo"
  },
  State_49148_Desc = {
    Text = "Após a morte, anexe \"deformidade 1\" a uma carta cujo consumo de potência de cálculo não seja 0. Deformidade: estado da carta, que ainda será mantido após o fim da batalha. Cada camada reduz o consumo de potência de cálculo em 1, mas ao ser jogada, cada camada adicionará 1 carta de deformidade aleatória à sua mão (ignorando o limite de cartas na mão) e removerá todas as deformidades."
  },
  State_49148_Name = {
    Text = "Feto Deformado"
  },
  State_49149_Desc = {
    Text = "Cada camada reduz o custo de aritmética das cartas em 1. Após ser jogada, para cada camada de distorção, adiciona uma carta de distorção aleatória à sua mão e remove esse estado. Esse estado será mantido após o fim da batalha"
  },
  State_49149_Name = {
    Text = "<ExclamationPointColour:Deformação [Layer]>"
  },
  State_49149_WeaponDesc = {
    Text = "Jogue para removê-la permanentemente"
  },
  State_49207_Name = {
    Text = "Obter 100 Energia de chave"
  },
  State_49225_Desc = {
    Text = "Após o fim do turno, 1 tentáculo ataca [Layer] vezes"
  },
  State_49225_Name = {
    Text = "<CardKeyWord:Tentáculos>"
  },
  State_49226_Desc = {
    Text = "No final do turno, para cada carta na mão, ative 3% de veneno em todos os inimigos e ganhe 3 pontos de loucura."
  },
  State_49226_Name = {
    Text = "Luz de vela fraca"
  },
  State_49260_Desc = {
    Text = "No fim do turno, recupera vida equivalente a 7,5% da constituição"
  },
  State_49260_Name = {
    Text = "Dor Não Aceita"
  },
  State_49270_Desc = {
    Text = "Dano de carta de ataque aumentado em [Layer] %"
  },
  State_49270_Name = {
    Text = "Dano de carta de ataque aumentado"
  },
  State_49270_WeaponDesc = {
    Text = "Dano de carta de ataque aumentado em [Layer] %"
  },
  State_49278_Desc = {
    Text = "No final do turno, recupere 5% da Vida perdida. Se a vida estiver abaixo de 50% ([StateArg1]), ganhe também [StateArg2] de Força"
  },
  State_49278_Name = {
    Text = "Altar Escarlate"
  },
  State_49430_Desc = {
    Text = "Dano recebido reduzido, cada camada reduz 1%. Estado removido após morte de outro aliado"
  },
  State_49430_Name = {
    Text = "<AberrationColour:esconder>"
  },
  State_49500_Desc = {
    Text = "Cada camada adiciona 1 ataque, perde 1 camada ao sofrer dano, perde todas no fim do turno"
  },
  State_49500_Name = {Text = "Oração"},
  State_49524_Desc = {
    Text = "Ao final da rodada, restaure 5% da vida perdida. Sempre que o jogador compra 1 carta de estado ou sintoma, todos os \"núbia\" ganham [StateArg1] pontos de poder temporário"
  },
  State_49524_Name = {
    Text = "Evangelho Sanguíneo"
  },
  State_49526_Desc = {
    Text = "Após a morte, recupera imediatamente para [StateArg2] pontos de vida e imunidade a danos por 1 turno, ajustando a intenção para \"Disseminação Impura\""
  },
  State_49526_Name = {Text = "Semear"},
  State_49542_Desc = {
    Text = "Único da equipe: No início da batalha, ganha força igual a <WeaponEffect_Num:[StateArg1]%> do ataque do portador. Se o domínio atual for \"Mar Profundo\", aumenta também o dano de tentáculo em <WeaponEffect_Num:[StateArg2]%> do ataque do portador"
  },
  State_49542_WeaponDesc = {
    Text = "Após o início da batalha, ganhe <WeaponEffect_Num:[Power:DescArg1]> pontos de <PowerIconKeywords:força>. Se o domínio atual for \"Mar Profundo\", ganhe também <WeaponEffect_Num:[DescArg2]> pontos de <TentacleInjurieIconKeywords:dano de tentáculo>."
  },
  State_49546_Desc = {
    Text = "Sempre aparece com 2 guardas de elite. Eles morrem quando ele morre"
  },
  State_49546_Name = {Text = "Formação"},
  State_49547_Desc = {
    Text = "Após a morte, faz com que o Capitão da Guarda Ailan ganhe [StateArg1] pontos de poder e um escudo de 50% da vida máxima"
  },
  State_49547_Name = {Text = "lealdade"},
  State_49558_Desc = {
    Text = "A força aumenta [StateArg1] a cada turno"
  },
  State_49558_Name = {
    Text = "Bênção da Areia"
  },
  State_49582_Desc = {
    Text = "Escudo restante a cada turno não será removido nesta batalha"
  },
  State_49582_Name = {
    Text = "Escudo permanentemente mantido"
  },
  State_49583_Desc = {
    Text = "Ao final da rodada, ganhe [StateArg1] pontos de escudo, com bônus de alerta"
  },
  State_49583_Name = {
    Text = "Escudo de Aran"
  },
  State_49595_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_49595_Name = {
    Text = "Ainda não despertado"
  },
  State_49596_Desc = {
    Text = "\"Sonho Lâmina\" despertou. Ela ganhará mais Escudos e Força."
  },
  State_49596_Name = {
    Text = "Elva Despertar!"
  },
  State_49596_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_49597_Name = {
    Text = "Este turno já foi atordoado __ \"Para uso de desenvolvimento apenas\""
  },
  State_49600_Desc = {
    Text = "Debilita todos os inimigos por 2 turnos"
  },
  State_49600_Name = {
    Text = "Sangue do medo"
  },
  State_49601_Desc = {
    Text = "Vulnerável a todos os inimigos por 2 turnos"
  },
  State_49601_Name = {
    Text = "Sangue putrefato"
  },
  State_49602_Desc = {
    Text = "Vulnerável a todos os inimigos por 1 turno"
  },
  State_49602_Name = {
    Text = "Sangue putrefato"
  },
  State_49603_Desc = {
    Text = "Fusão de embriões +[Blood:DescArg1]."
  },
  State_49603_Name = {
    Text = "Sangue de reprodução"
  },
  State_49604_Desc = {
    Text = "Fusão de embriões +[Blood:DescArg1]."
  },
  State_49604_Name = {
    Text = "Sangue de reprodução"
  },
  State_49605_Desc = {
    Text = "Debilita todos os inimigos por 1 turno"
  },
  State_49605_Name = {
    Text = "Sangue do medo"
  },
  State_49623_Desc = {
    Text = "Redução da recuperação de vida recebida em [DescArg1]%. Remove 1 camada no final do turno"
  },
  State_49623_Name = {
    Text = "<BaseDamageColour:Ferimento grave>"
  },
  State_49623_WeaponDesc = {
    Text = "Dano causado reduzido em [DescArg1] %"
  },
  State_49627_Desc = {
    Text = "Começa com 2 camadas de <ParcloseIconKeywords:Barreira>. Ao morrer, todos os \"Núbia\" ganham [StateArg1] de força"
  },
  State_49627_Name = {
    Text = "Sangue fervente"
  },
  State_49628_Desc = {
    Text = "Ao morrer, todos os \"Núbia\" ganham [StateArg1] Força."
  },
  State_49628_Name = {
    Text = "Ligação Sanguínea"
  },
  State_49638_Desc = {
    Text = "Identificar se é um monstro da série Cabra Negra"
  },
  State_49833_Desc = {
    Text = "No final do turno, aplique 1 turno de \"Cegueira\" a todos os inimigos. Se o escudo for quebrado, cancele o estado de \"Cegueira\""
  },
  State_49833_Name = {
    Text = "Barreira de Areia e Poeira"
  },
  State_49844_Desc = {
    Text = "Equipe Única: Ao final do turno, ganha <WeaponEffect_Num:[StateArg1]> pontos de Energia da Chave de Prata. Após ativar a Resistência à Morte, ganha <WeaponEffect_Num:[StateArg2]> pontos de Energia da Chave de Prata. Após usar o Corpo de Gnosis de Emergência, o limite de capacidade de cálculo aumenta em 3 e o número de cartas compradas por turno aumenta em 3."
  },
  State_49844_WeaponDesc = {
    Text = "No final do turno, ganhe <WeaponEffect_Num:[StateArg1]> pontos de energia da chave de prata. Após acionar a resistência à morte, ganhe <WeaponEffect_Num:[StateArg2]> pontos de energia da chave de prata. Após usar o Corpo de Gnosis de Emergência, o limite de capacidade de cálculo aumenta em 3, e o número de cartas compradas por turno aumenta em 3."
  },
  State_49877_Desc = {
    Text = "Reduz o consumo de poder da carta. Ao ser jogada, se houver 1 camada de distorção, adiciona uma carta de distorção aleatória à mão e remove esse estado. Esse estado será mantido após o término da batalha"
  },
  State_49877_Name = {
    Text = "<AberrationKeywords:Aberração>"
  },
  State_49877_WeaponDesc = {
    Text = "Cada camada de lentidão aumenta o custo de aritmética das cartas em 1 ponto"
  },
  State_49954_Desc = {
    Text = "O dano crítico de todos os despertos é reduzido pela metade"
  },
  State_49954_Name = {
    Text = "<BlindingKeywords: Cegueira>"
  },
  State_49954_WeaponDesc = {
    Text = "Cada camada de lentidão aumenta o custo de aritmética das cartas em 1 ponto"
  },
  State_49957_Desc = {
    Text = "Ao receber Dano ativo, sela a Fúria Explosiva e as Cartas de comando do Corpo Desperto atacante por 1 turno, remove 1 capa de <ResentChainsKeywords:Cadeia de Rancor>. Limpa no fim do turno."
  },
  State_49957_Name = {
    Text = "<ResentChainsKeywords:Cadeias de Rancor>"
  },
  State_49957_WeaponDesc = {
    Text = "Cada camada de lentidão aumenta o custo de aritmética das cartas em 1 ponto"
  },
  State_49958_Desc = {
    Text = "Ao receber Dano ativo e Dano de tentáculo, sela a Fúria Explosiva e as Cartas de comando do Corpo Desperto atacante por 1 turno, remove 1 capa de <ResentChainsKeywords:Cadeia de Rancor>."
  },
  State_49958_Name = {
    Text = "<ResentChainsKeywords1:Cadeia de Rancor>"
  },
  State_49959_Desc = {
    Text = "No início de cada turno, ganha 1 camada de <ResentChainsKeywords:correntes de ressentimento>"
  },
  State_49959_Name = {
    Text = "Trava Multidimensional"
  },
  State_50010_Desc = {
    Text = "Recuperação de vida recebida reduzida em 25%. Remove 1 camada no final do turno"
  },
  State_50010_Name = {
    Text = "<HeavyInjuryKeywords:Ferimento grave>"
  },
  State_50021_Desc = {
    Text = "Equipe Única: Após o Portador liberar Fúria Explosiva, obtém <PowerIconKeywords:Força> equivalente a <WeaponEffect_Num:[StateArg1]%> da Força de ataque do Portador. Se o Domínio atual for \"Carne e sangue\", após liberar Fúria Explosiva, Fusão de embriões <WeaponEffect_Num:+[Blood:StateArg2]> ."
  },
  State_50021_WeaponDesc = {
    Text = "Após o Portador liberar Fúria Explosiva, obtém <WeaponEffect_Num:[Power:DescArg1]> pontos de <PowerIconKeywords:Força>. Se o Domínio atual for \"Carne e sangue\", após liberar Fúria Explosiva, Fusão de embriões <WeaponEffect_Num:+[Blood:StateArg2]> ."
  },
  State_50302_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Resiste a uma morte e destrói esta \"Roda do Destino\", concede [StateArg1] camadas de <PVPProtectiveKeywords:Barreira>. Se o Portador for o único aliado vivo quando o efeito é ativado, concede [StateArg2] \"Ordem de chave\" aleatórias no início do próximo turno."
  },
  State_50302_Name = {
    Text = "Amanhecer e Crepúsculo"
  },
  State_50323_Desc = {
    Text = "Antes do próximo turno, ganhe [Layer] cartas de comando aleatórias"
  },
  State_50323_Name = {
    Text = "Chave retardada"
  },
  State_50333_Desc = {
    Text = "No final do turno, todos os despertadores perdem aliemus."
  },
  State_50333_Name = {
    Text = "<EmptinessKeywords: Vazio>"
  },
  State_50333_WeaponDesc = {
    Text = "Cada camada de lentidão aumenta o custo de aritmética das cartas em 1 ponto"
  },
  State_50352_Name = {
    Text = "Téïs Demo"
  },
  State_50353_Name = {
    Text = "Téïs Demo"
  },
  State_50358_Desc = {
    Text = "Dano recebido reduzido, cada camada reduz 1%. Estado removido após morte de outro aliado"
  },
  State_50358_Name = {
    Text = "<ConcealmentKeywords: Esconder>"
  },
  State_50375_Desc = {
    Text = "Esses efeitos incluem: ganhar 10 pontos de aliemus, outros aliados ganham 5 pontos de aliemus, aplicar 1 camada de vulnerabilidade a todos os inimigos, aplicar 1 camada de fraqueza a todos os inimigos, comprar 1 carta, ganhar 200 pontos de s-energia"
  },
  State_50375_Name = {
    Text = "<MysterybuffKeywords:Efeito Positivo Misterioso>"
  },
  State_50389_Desc = {
    Text = "No início do turno, coloca um \"Dados da Sorte de Ryker\" na mão"
  },
  State_50389_Name = {
    Text = "Suporte de Lek"
  },
  State_50390_Desc = {
    Text = "No início do turno, ganhe [StateArg1] de força"
  },
  State_50390_Name = {
    Text = "Conhecimento do campo de batalha"
  },
  State_50491_Name = {
    Text = "Pêndulo Temporal \"Equilíbrio\""
  },
  State_50735_Desc = {
    Text = "Ao estar prestes a ser derrotado pela primeira vez, recupere vida e mude a intenção para \"Lamento Lacrimogêneo\", causando dano único extremamente alto."
  },
  State_50735_Name = {
    Text = "Resiliência Inútil"
  },
  State_50854_Desc = {
    Text = "Ao início da batalha, ganha [StateArg1] pontos de <RetaliateIconKeywords:contra-ataque>. Após o final do turno, ganha [StateArg2] pontos de escudo, que aumenta em [StateArg3] a cada turno"
  },
  State_50854_Name = {
    Text = "Corteza resistente"
  },
  State_50861_Desc = {
    Text = "Sem mais danos, preparando-se para liberar a \"Mãe de Mil Descendentes\""
  },
  State_50861_Name = {Text = "derivado"},
  State_50862_Desc = {
    Text = "Sem mais danos, preparando-se para liberar a \"Procriação\""
  },
  State_50862_Name = {
    Text = "incubação"
  },
  State_50863_Desc = {
    Text = "Sem mais danos, preparando-se para liberar a \"Seiva Selvagem\""
  },
  State_50863_Name = {Text = "Imunidade"},
  State_50864_Desc = {
    Text = "Sem mais danos, preparando-se para liberar a \"Seiva\""
  },
  State_50864_Name = {Text = "Imunidade"},
  State_50891_Desc = {
    Text = "Sem mais danos, preparando-se para liberar a \"Fusão Múltipla\""
  },
  State_50891_Name = {Text = "Devorar"},
  State_51016_Desc = {
    Text = "Os efeitos de veneno que você recebeu se tornam 1000%"
  },
  State_51016_Name = {
    Text = "Madeira seca e podre"
  },
  State_51017_Desc = {
    Text = "Os efeitos de veneno que você recebeu se tornam 500%"
  },
  State_51017_Name = {
    Text = "Madeira seca e podre"
  },
  State_51607_Desc = {
    Text = "Imune a todo dano, removido no início do turno"
  },
  State_51607_Name = {
    Text = "Imunidade ao dano"
  },
  State_51695_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_51695_Name = {
    Text = "Ainda não despertado"
  },
  State_51696_Desc = {
    Text = "\"Apóstolo do Mar\" despertou, com resistência mais forte ao Exaltar."
  },
  State_51696_Name = {
    Text = "Miriam Despertar!"
  },
  State_51696_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_51739_Desc = {
    Text = "Ao final do turno, ganhe aleatoriamente 1 carta \"Fantasma do Reino Divino\", que não pode ser dissipada."
  },
  State_51739_Name = {Text = "Fim da Fé"},
  State_51740_Desc = {
    Text = "No início da batalha, adicione 1 carta \"Obstinação\" à sua mão"
  },
  State_51740_Name = {
    Text = "Devoção Imortal"
  },
  State_51741_Desc = {
    Text = "No início do turno, ganhe [Layer] pontos de escudo, que não podem ser dissipados."
  },
  State_51741_Name = {
    Text = "Mantenha sua autenticidade"
  },
  State_51742_Desc = {
    Text = "No início do turno, ganhe [Layer] pontos de dano de tentáculo e de força. Estado não pode ser dissipado."
  },
  State_51742_Name = {
    Text = "Consagrar-se à Revelação"
  },
  State_51743_Desc = {
    Text = "Neste turno, a cada ataque do tentáculo, ganha os seguintes efeitos conforme a postura do tentáculo: Onda: todos os Corpos Despertos ganham <Energy:[Energy:StateArg1]> pontos de Fúria; Mar Calmo: causa [StateArg2] pontos de <IntoxicationIconKeywords:envenenamento> em todos os inimigos; Onda de Ira: <TentacleInjurieIconKeywords:dano de tentáculo> temporário +[StateArg3]."
  },
  State_51743_Name = {
    Text = "Bênção da Mãe Deusa"
  },
  State_51745_Desc = {
    Text = "Quando o Apóstolo do Mar joga 1 carta, gera [StateArg1] tentáculos temporários, ignorando o limite de tentáculos"
  },
  State_51745_Name = {
    Text = "Poder delegado"
  },
  State_51745_WeaponDesc = {
    Text = "Quando o Apóstolo do Mar joga 1 carta, gera [StateArg1] tentáculos temporários, ignorando o limite de tentáculos"
  },
  State_51811_Name = {
    Text = "Efeito de Cura da Vela de guia"
  },
  State_51813_Desc = {
    Text = "Após o final do turno, consumo de aritmética -[Layer], mesmo ao ser descartado, esse efeito é ativado"
  },
  State_51813_Name = {
    Text = "<PrepareKeypvewordscolour:preparar[Layer]>"
  },
  State_51820_Desc = {
    Text = "\"Gestação\" ganha um efeito adicional: Com 5 pilhas, invoque instantaneamente 1 \"Filho da Água\", até um máximo de 2 \"Filhos da Água\"."
  },
  State_51820_Name = {
    Text = "Miriam Despertar"
  },
  State_51822_Desc = {
    Text = "A cada vez que liberar uma explosão de loucura, aumente 1 camada de \"gestação\", e a cada camada de gestação receba [StateArg1] pontos de poder, com um limite de 5 camadas"
  },
  State_51822_Name = {
    Text = "A Descida Final de Lemuria"
  },
  State_52068_Desc = {
    Text = "Transforme até 3 cartas de \"Ritual Sagrado\" na mão em \"Obstinação\", ganhando efeitos adicionais conforme a quantidade transformada"
  },
  State_52068_Name = {
    Text = "<CardKeyWord:Ritual>"
  },
  State_52087_Desc = {
    Text = "\"Pássaro da Felicidade Imortal\" pode aplicar o estado de revivificação novamente após [Layer] rodadas"
  },
  State_52087_Name = {
    Text = "Tempo de ressurreição"
  },
  State_52116_Desc = {
    Text = "Antes do fim da rodada, este despertador sofre [Layer] de dano após usar exaltação."
  },
  State_52116_Name = {
    Text = "Bloqueio de surto"
  },
  State_52369_Desc = {
    Text = "Após jogar [DescArg1] cartas de sintoma, ganhe o cartão de apoio \"Rei\" de tulu: causa grande dano e desmaia o alvo por 1 turno"
  },
  State_52369_Name = {
    Text = "O Reino Divino certamente retornará"
  },
  State_53115_Desc = {
    Text = "Na próxima ativação do efeito “ritual” por miryam nesta rodada, o aumento será de 50%"
  },
  State_53115_Name = {
    Text = "Reze ao Abismo"
  },
  State_53144_Desc = {
    Text = "No início de cada turno, ganhe <Block:[Block:StateArg1]> de escudo"
  },
  State_53144_Name = {
    Text = "<CardKeyWord:Persistir>"
  },
  State_53145_Desc = {
    Text = "Cada turno começa com <PowerIconKeywords:força> e <TentacleInjurieIconKeywords:dano de tentáculo> +[StateArg2]"
  },
  State_53145_Name = {
    Text = "<CardKeyWord:Revelação>"
  },
  State_53673_Desc = {
    Text = "A divisão glandular pode ter até 10 partes"
  },
  State_53673_Name = {
    Text = "Limite de Divisão de Glândulas"
  },
  State_53674_Desc = {
    Text = "Limite de cartas na mão +2. No início da rodada, Miryam ganha 20 pontos de loucura"
  },
  State_53674_Name = {
    Text = "Miriam Playtest"
  },
  State_53755_Desc = {
    Text = "Todos os despertadores aplicam <PowerIconKeywords:poder>, <RetaliateIconKeywords:balcão>, <IntoxicationIconKeywords:veneno> aumentam [DescArg1]%. O <PowerIconKeywords:poder> aplicado por \"Capítulo deslumbrante\" aumenta"
  },
  State_53755_Name = {
    Text = "Poema misterioso·Medo"
  },
  State_53756_Desc = {
    Text = "A loucura causada por todos os despertadores aumenta em [DescArg1]%, a aritmética e as cartas de comando ao final da rodada podem ser mantidas para a próxima rodada. A loucura causada pelo \"Capítulo deslumbrante\" aumenta"
  },
  State_53756_Name = {
    Text = "Poema fantasmal·alegria"
  },
  State_53758_Desc = {
    Text = "O dano final causado por todos os despertadores aumenta em [DescArg1]%, a taxa crítica e o dano crítico aumentados pelo \"Capítulo deslumbrante\""
  },
  State_53758_Name = {
    Text = "PoemaDeDevaneio·Fúria"
  },
  State_53759_Desc = {
    Text = "Os efeitos de escudo e regeneração de vida causados por todos os despertadores aumentam a redução aplicada de <PowerIconKeywords:poder> em [DescArg1]%, \"Capítulo deslumbrante\" aumenta a regeneração"
  },
  State_53759_Name = {
    Text = "Poema de luto · Luto"
  },
  State_53772_Name = {
    Text = "Paradoxo dos Acessórios"
  },
  State_53772_WeaponDesc = {
    Text = "Após o uso do aliemus pelo portador, sua equipe recebe 100% de <RetaliateIconKeywords:retaliação> baseado na defesa do portador; e aumenta sua atual <RetaliateIconKeywords:retaliação> em 10%"
  },
  State_53870_Name = {
    Text = "Anel da Sala 36 de Acessórios"
  },
  State_53870_WeaponDesc = {
    Text = "Quando uma carta do Equipador é puxada, a aritmética varia aleatoriamente entre 0 e 3"
  },
  State_53981_Name = {
    Text = "Correção do sigilo negro no sonho do adorno"
  },
  State_53981_WeaponDesc = {
    Text = "Após o início da batalha, embaralhe um conjunto de cartas do portador no baralho de compra"
  },
  State_54002_Name = {
    Text = "Estado@AcessórioSonhoDeRemédioMarcaDeSeleção"
  },
  State_54002_WeaponDesc = {
    Text = "Após o uso do aliemus pelo portador, sua equipe recebe 100% de <RetaliateIconKeywords:retaliação> baseado na defesa do portador; e aumenta sua atual <RetaliateIconKeywords:retaliação> em 10%"
  },
  State_54011_Name = {
    Text = "Estado@AcessórioSonhoDeRemédioCópia1Disponível"
  },
  State_54011_WeaponDesc = {
    Text = "Após o uso do aliemus pelo portador, sua equipe recebe 100% de <RetaliateIconKeywords:retaliação> baseado na defesa do portador; e aumenta sua atual <RetaliateIconKeywords:retaliação> em 10%"
  },
  State_54012_Name = {
    Text = "Estado@AcessórioSonhoDeRemédioCópia2Disponível"
  },
  State_54012_WeaponDesc = {
    Text = "Após o uso do aliemus pelo portador, sua equipe recebe 100% de <RetaliateIconKeywords:retaliação> baseado na defesa do portador; e aumenta sua atual <RetaliateIconKeywords:retaliação> em 10%"
  },
  State_54013_Desc = {
    Text = "Neste turno, maestria de domínio aumenta [Layer]"
  },
  State_54013_Name = {
    Text = "Domínio de área temporário"
  },
  State_54014_Desc = {
    Text = "Maestria em Domínios aumenta em [Layer] pontos"
  },
  State_54014_Name = {
    Text = "Domínio de área"
  },
  State_54043_WeaponDesc = {
    Text = "Após o uso do aliemus, o escudo e a cura do portador são dobrados neste turno"
  },
  State_54044_Desc = {
    Text = "Causa o dobro de Dano e adicionalmente ganha 600% de Energia de chave igual à Recarga de Chave de Prata de Ramona: Desgastada, mas <DepleteIconKeywords:Esgota> após Disparar."
  },
  State_54044_Name = {
    Text = "Canto ao futuro"
  },
  State_54045_Desc = {
    Text = "Ganha 3 pontos de aritmética"
  },
  State_54045_Name = {
    Text = "Jardim do Ciclo Eterno"
  },
  State_54046_Desc = {
    Text = "No início do turno, recupere [StateArg1] de HP por [Layer] turnos"
  },
  State_54046_Name = {
    Text = "Razão, Verdade e Realidade"
  },
  State_54071_Desc = {
    Text = "Contagem de Dano ativo de Ogier +1, durando [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_54071_Name = {
    Text = "Sete Artes, Oito Virtudes"
  },
  State_54121_Desc = {
    Text = "Nesta Batalha, o Dano básico causado pela 'Besta do caos' é aumentado em [Layer]%."
  },
  State_54121_Name = {
    Text = "Bicho do Caos"
  },
  State_54138_Desc = {
    Text = "Sorel ativa a carta de comando jogada [Layer] 2 vezes"
  },
  State_54138_Name = {
    Text = "Valsa do poder"
  },
  State_54384_Desc = {
    Text = "Aumenta a <IntoxicationIconKeywords:veneno> causado por nínfea em 50%, durando [Layer] rodadas"
  },
  State_54384_Name = {
    Text = "Cerimônia fúnebre de si mesmo"
  },
  State_54416_Desc = {
    Text = "Ao desbloquear a Fúria Explosiva Sobrecarregada, o medidor de Fúria pode ser preenchido duas vezes. Ao atingir a segunda carga completa, a habilidade é melhorada para Fúria Explosiva Sobrecarregada, adicionando efeitos bônus poderosos. Liberar uma Fúria Explosiva comum consumirá 50% da Fúria excedente."
  },
  State_54416_Name = {
    Text = "<OverLimitUtlSkillKeywords:superexaltação>"
  },
  State_54416_WeaponDesc = {
    Text = "Descarte o embrião da mão para ativar um poderoso efeito devorador"
  },
  State_54561_Desc = {
    Text = "Equipe única: O valor do dano causado pelo portador é aumentado em <WeaponEffect_Num:[StateArg1] %> do poder de ataque do portador. Se o reino atual for \"caro\", cada vez que o portador ativa o efeito devorador, causa um aumento adicional de 3 % no dano"
  },
  State_54561_WeaponDesc = {
    Text = "O dano causado pelo portador aumenta em [DescArg1]. Se o domínio atual for \"Carne\", sempre que o portador ativar o efeito Devorar, o dano causado pelo portador aumentará em [DescArg2] adicionalmente."
  },
  State_54568_Name = {
    Text = "até o fim do planeta"
  },
  State_54597_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após a morte de um Corpo Desperto inimigo, ganha [StateArg1] <StrongEffectKeywords:Eficaz>, e coloca a \"Habilidade\" com maior consumo de potência de cálculo com <PVPVoidKeywords:Nada> em sua mão."
  },
  State_54597_Name = {
    Text = "Milhões de Olhares Amorosos"
  },
  State_54704_Desc = {
    Text = "\"O próximo cartão de comando de '24' entra em vigor 3 vezes.\""
  },
  State_54704_Name = {
    Text = "Banquete distorcido de corpos mortos"
  },
  State_54798_Desc = {
    Text = "Todos os efeitos de escudo, cura e redução de força dos acordadores são aumentados em [StateArg1]%, e os efeitos de cura dos capítulos resplandecentes são aumentados."
  },
  State_54798_Name = {Text = "\"Ai\""},
  State_54799_Desc = {
    Text = "Todos os efeitos de contra-ataque, veneno e aquisição de força dos acordadores são aumentados em [StateArg1]%. A força dos capítulos resplandecentes é aumentada."
  },
  State_54799_Name = {Text = "\"Medo\""},
  State_54800_Desc = {
    Text = "O dano final causado por todos os despertadores aumenta em [StateArg1]%, e a taxa crítica e o dano crítico do Capítulo da Belamente Atraente aumentam"
  },
  State_54800_Name = {Text = "\"Raiva\""},
  State_55108_Desc = {
    Text = "No início do turno, atualize \"Chama Verde\" ou \"Chama Verde Corrompida\" na mão para \"Chama Verde Mortal\", por [Layer] turnos"
  },
  State_55108_Name = {
    Text = "Sinal de morte aparece"
  },
  State_55108_WeaponDesc = {
    Text = "Ao iniciar a rodada, se estiver nas cartas ou espaço ultra, receberá fortalecimento"
  },
  State_55113_Desc = {
    Text = "Após cada rodada em que Orla joga o primeiro poema, ela ganha 10 pontos de aliemus"
  },
  State_55113_Name = {
    Text = "Reencontro de Flor e Poema"
  },
  State_55465_Name = {
    Text = "Consumir [Layer] camadas de Metáfora \"Raiva\", causar [DescArg1] danos extras"
  },
  State_55466_Name = {
    Text = "Consumir [Layer] camadas de Metáfora \"Tristeza\", recuperar <Heal:[Heal:DescArg1]> de Vida"
  },
  State_55467_Name = {
    Text = "Consumir [Layer] camadas de Metáfora \"Medo\", ganhar [Power:DescArg1] de <PowerIconKeywords:Força>"
  },
  State_55469_Name = {
    Text = "Consumir [Layer] camadas de Metáfora \"Alegria\", ganhar <Energy:[Energy:DescArg1]> de Loucura"
  },
  State_55470_Name = {
    Text = "Golpe de pescoço"
  },
  State_55485_Desc = {
    Text = "As próximas [Layer] cartas que Casiah Disparar ganham Força equivalente a 10% da sua Força de ataque."
  },
  State_55485_Name = {
    Text = "Ria à vontade"
  },
  State_55486_Name = {
    Text = "Superexaltação da Cidade dos Sonhos Mortos isenta o custo de atração dos sonhos"
  },
  State_55487_Desc = {
    Text = "O \"ataque\" de Erica causa 2 danos adicionais, \"defesa\" recebe 2 escudos extras, durando [Layer] turnos"
  },
  State_55487_Name = {
    Text = "Cálculo múltiplo"
  },
  State_55489_Name = {
    Text = "Salto espaço-tempo"
  },
  State_55806_Name = {
    Text = "<PoetryKeywords:Sacrifício a Deus>:Concede a todos os inimigos um <PVPWonderfulEffectKeywords:Efeito Maravilhoso> negativo ou concede a todos os aliados um <PVPWonderfulEffectKeywords:Efeito Maravilhoso> positivo ou compra 1 carta, ganhando 1 Poder de cálculo. O último Sacrifício a Deus entra em vigor 2 vezes"
  },
  State_55807_Name = {
    Text = "Compre 1 cartão, ganhe 1 aritmética"
  },
  State_55808_Name = {
    Text = "<PoetryKeywords:offering>: Conceda a todos os aliados um <PVPWonderfulEffectKeywords:efeito maravilhoso> positivo ou compre 1 carta e ganhe 1 aritmética. A última oferta tem efeito 2 vezes"
  },
  State_55809_Name = {
    Text = "Conceder a todos os inimigos efeito negativo <PVPWonderfulEffectKeywords:maravilhoso>"
  },
  State_55811_Desc = {
    Text = "Escolha uma das opções listadas para ativar"
  },
  State_55811_Name = {
    Text = "<ComaColour:Escolha>"
  },
  State_55813_Name = {
    Text = "<PoetryKeywords:offering>: Conceda a todos os inimigos um <PVPWonderfulEffectKeywords:efeito maravilhoso> negativo ou compre 1 carta e ganhe 1 aritmética. A última oferta tem efeito 2 vezes"
  },
  State_55814_Name = {
    Text = "<PoetryKeywords:offering>: Conceda a todos os inimigos um <PVPWonderfulEffectKeywords:efeito maravilhoso> negativo ou conceda a todos os aliados um <PVPWonderfulEffectKeywords:efeito maravilhoso> positivo. A última oferta tem efeito 2 vezes"
  },
  State_55816_Name = {
    Text = "Conceder a todos os aliados efeito positivo <PVPWonderfulEffectKeywords:maravilhoso>"
  },
  State_55824_Desc = {
    Text = "Escolha uma das opções listadas para ativar, remova a opção escolhida, se houver opções restantes, coloque esta carta na mão do oponente"
  },
  State_55824_Name = {
    Text = "<ComaColour: Oferta>"
  },
  State_55836_Desc = {
    Text = "Ao final da rodada, a capacidade de consumo das cartas de comando do horla diminui em -1"
  },
  State_55836_Name = {
    Text = "Tinta Poética"
  },
  State_55839_Desc = {
    Text = "Ao pegar, perca todas as outras relíquias e ganhe aleatoriamente 2 relíquias de ouro"
  },
  State_55866_Desc = {
    Text = "Único na equipe: ao início da batalha, puxa 1 carta de comando do equipador, com uma chance de <WeaponEffect_Num:[StateArg1]%> de reduzir o custo de aritmética em 1. Cada vez que a resistência à morte for ativada, o efeito será ativado novamente"
  },
  State_55866_WeaponDesc = {
    Text = "Ao início da batalha, compre 1 carta de comando do equipador e há <WeaponEffect_Num:[StateArg1]%> de chance de reduzir o custo de aritmética em 1. Cada vez que a resistência à morte for ativada, o efeito será ativado novamente."
  },
  State_55992_Desc = {
    Text = "Quando a capacidade estiver baixa, aplica consumo e marcações às cartas"
  },
  State_55992_Name = {Text = "Cinzas"},
  State_55993_Name = {
    Text = "Marca de cinza"
  },
  State_56018_Desc = {
    Text = "Durante esta batalha, a saúde máxima aumenta em [Layer]%"
  },
  State_56018_Name = {
    Text = "Bênção da Musa - Destino"
  },
  State_56020_Desc = {
    Text = "Dano aumentado em [Layer]% nesta batalha"
  },
  State_56020_Name = {
    Text = "Bênção da Musa - Força"
  },
  State_56030_Desc = {
    Text = "O escudo e a cura causados pelo despertador nesta rodada aumentam em [Layer]%"
  },
  State_56030_Name = {Text = "Neve"},
  State_56031_Desc = {
    Text = "Nesta rodada, para cada dano causado, a taxa crítica temporária aumenta em +[Layer]%"
  },
  State_56031_Name = {Text = "borboleta"},
  State_56034_Desc = {
    Text = "Cada \"metáfora\" pode ter no máximo 3 camadas. Diferentes \"metáforas\" aumentam diferentes efeitos dos poemas: \n<D06CardKeyWordnu:Poema Frenético>: consome todas as metáforas \"Raiva\", causando 2 vezes mais dano por camada de metáfora. \n<D06CardKeyWordai:Poema de luto>: consome todas as metáforas \"Ai\", recuperando vida por camada de metáfora. \n<D06CardKeyWordxi:Poema fantástico>: consome todas as metáforas \"Alegria\", ganhando 10 pontos de Fúria por camada de metáfora. \n<D06CardKeyWordju:Poema enigmático>: consome todas as metáforas \"Medo\", ganhando <PowerIconKeywords:Força> por camada de metáfora."
  },
  State_56034_Name = {Text = "metáfora"},
  State_56208_Desc = {
    Text = "Canto da Chuva: Recupera <Heal:[DescArg1]> Vida.\nCanção do Vento: Obtém [DescArg2] <PowerIconKeywords:Força>.\nHino às Flores: Concede <Energy:10> Fúria a todos os Corpos Despertos.\nCanto Lunar: Taxa de Crítico +30% neste turno."
  },
  State_56208_Name = {
    Text = "Página de poema"
  },
  State_56330_Desc = {
    Text = "Obtém [DescArg1] pontos de escudo, se neste turno houve 3 ativações de exaltar, este cartão ativa adicionalmente 1 vez"
  },
  State_56330_Name = {
    Text = "Imagens avançadas"
  },
  State_56331_Desc = {
    Text = "Escolha 1 carta de comando da pilha de cartas e da pilha de descarte para adicionar à sua mão, diminuindo seu custo de aritmética em -2"
  },
  State_56331_Name = {
    Text = "Imagens avançadas"
  },
  State_56332_Desc = {
    Text = "Obtém [DescArg1] pontos temporários <PowerIconKeywords:poder>. Após jogar, neste turno, a cada dano causado, a taxa crítica temporária aumenta em +3%"
  },
  State_56332_Name = {
    Text = "Imagens avançadas"
  },
  State_56333_Desc = {
    Text = "Recupere 10% da vida perdida. Se a vida atual for inferior a 25%, este cartão terá efeito adicional uma vez"
  },
  State_56333_Name = {
    Text = "Imagens avançadas"
  },
  State_56334_Desc = {
    Text = "O próximo comando será ativado 2 vezes"
  },
  State_56334_Name = {
    Text = "Imagens avançadas"
  },
  State_56335_Desc = {
    Text = "Causa <FixedDamage:Dano Puro> igual a 150% da Vida máxima, com bônus de 10× <PowerIconKeywords:STR>."
  },
  State_56335_Name = {
    Text = "Imagens avançadas"
  },
  State_56336_Desc = {
    Text = "Compre 5 cartas"
  },
  State_56336_Name = {
    Text = "Imagens avançadas"
  },
  State_56337_Desc = {
    Text = "Obtenha [DescArg1] pontos temporários de <AlertIconKeywords:alerta>. Após jogar, aumente o escudo e a cura deste turno em [DescArg2]%"
  },
  State_56337_Name = {
    Text = "Imagens avançadas"
  },
  State_56338_Desc = {
    Text = "Ganha 3 pontos de aritmética"
  },
  State_56338_Name = {
    Text = "Imagens avançadas"
  },
  State_56339_Desc = {
    Text = "Dispersa 1 estado negativo aleatório. Esta carta tem efeito extra 3 vezes, consome"
  },
  State_56339_Name = {
    Text = "Imagens avançadas"
  },
  State_56340_Desc = {
    Text = "Aplique 3 turnos de <VulnerabilityIconKeywords:vulnerável> a todos os inimigos. Sempre que um inimigo morrer, coloque esta carta em sua mão"
  },
  State_56340_Name = {
    Text = "Imagens avançadas"
  },
  State_56341_Desc = {
    Text = "Maestria em Domínios +25 pontos, Maestria em Domínios Temporária +125 pontos"
  },
  State_56341_Name = {
    Text = "Imagens avançadas"
  },
  State_56342_Desc = {
    Text = "Todos os despertos ganham 15 pontos de loucura"
  },
  State_56342_Name = {
    Text = "Imagens avançadas"
  },
  State_56343_Desc = {
    Text = "Aplique 3 turnos de <WeaknessIconKeywords:fraqueza> a todos os inimigos, coloque uma cópia desta carta na pilha de descarte, adicionando <DepleteIconKeywords:exausto>, e <NothingnessIconKeywords:ilusão>"
  },
  State_56343_Name = {
    Text = "Imagens avançadas"
  },
  State_56372_Desc = {
    Text = "Ao morrer, remova o último estado negativo do jogador"
  },
  State_56372_Name = {
    Text = "Flor e poema"
  },
  State_56400_Desc = {
    Text = "Após \"Golpe\", as \"Habilidades\" na sua mão mudarão sequencialmente para outras \"Habilidades\" [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_56400_Name = {
    Text = "Flores e Poemas do Passado"
  },
  State_56402_Desc = {
    Text = "Possuir metáfora <D06CardKeyWordnu:\"Raiva\"> [DescArg2] camadas: quando \"Poema Frenético\" ativa o salto, causará dano adicional. \n Possuir metáfora <D06CardKeyWordai:\"Ai\"> [DescArg3] camadas: quando \"Poema de luto\" ativa o salto, recuperará vida adicional. \n Possuir metáfora <D06CardKeyWordxi:\"Alegria\"> [DescArg1] camadas: quando \"Poema fantástico\" ativa o salto, concederá Fúria adicional ao Corpo Desperto. \n Possuir metáfora <D06CardKeyWordju:\"Medo\"> [DescArg4] camadas: quando \"Poema enigmático\" ativa o salto, concederá Força adicional."
  },
  State_56402_Name = {Text = "metáfora"},
  State_57166_Desc = {
    Text = "Dano causado pelo corpo desperto aumentado em 25%"
  },
  State_57170_Desc = {
    Text = "Limite de cartas na mão +2, no final do turno, escolha 1 carta na mão para ganhar reserva e reduzir seu consumo de aritmética em -1, durando 3 turnos"
  },
  State_57170_Name = {
    Text = "Luz Errante"
  },
  State_57316_Desc = {
    Text = "No início de cada turno, converte 1 carta \"embrião\" em \"Filho da santidade\". Se não houver \"embrião\", <EmbryoFusionIconKeywords:Fusão de embriões> +[Blood:DescArg1], sem ser afetado pelo Efeito de aumento da Fusão de embriões. Sustentado por [Layer] turnos."
  },
  State_57316_Name = {
    Text = "Legado da Relíquia Eterna"
  },
  State_57317_Desc = {
    Text = "Quando esta roda do destino estiver no baralho, você verá as mudanças iminentes nas habilidades em sua mão."
  },
  State_57317_Name = {
    Text = "<PVPFlowerKeywords:Flores e Poemas do Passado>"
  },
  State_57324_Desc = {
    Text = "Se este Despertador ativar \"Flores e Poemas do Passado\", este cartão se transforma em <CardKeyWord:<SkillName1:>>."
  },
  State_57324_Name = {
    Text = "Flores e Poemas do Passado"
  },
  State_57325_Desc = {
    Text = "Se este Despertador ativar \"Flores e Poemas do Passado\", este cartão se transforma em <CardKeyWord:<SkillName2:>>."
  },
  State_57325_Name = {
    Text = "Flores e Poemas do Passado"
  },
  State_57326_Desc = {
    Text = "Se este Despertador ativar \"Flores e Poemas do Passado\", este cartão se transforma em <CardKeyWord:<SkillName3:>>."
  },
  State_57326_Name = {
    Text = "Flores e Poemas do Passado"
  },
  State_57335_Name = {
    Text = "Dano da carta recebe bônus de força de [DescArg1] vezes"
  },
  State_57356_Name = {
    Text = "Estado@mergulhador contra-ataque cálculo"
  },
  State_57368_Name = {
    Text = "Estado@mergulhador contra-ataque trampolim"
  },
  State_57413_Name = {
    Text = "Cada ponto de escudo aumenta o dano desta carta em [DescArg1] pontos"
  },
  State_57417_Desc = {
    Text = "A cada vez que uma Resistência à Morte é ativada, causa 100% de Dano Fixo de contrataque; a cada Resistência à Morte ativada nesta batalha, o Dano Fixo aumenta em 25%"
  },
  State_57417_Name = {
    Text = "Berço do amor"
  },
  State_57566_Name = {
    Text = "Sobrevivência em situação desesperadora"
  },
  State_57587_Desc = {
    Text = "Ao jogar \"Divisão de Glândula\", compre 1 cartão, com [Layer] usos restantes."
  },
  State_57587_Name = {
    Text = "Águas-vivas, reúnam-se!"
  },
  State_57665_Name = {
    Text = "Proteção da mãe divina"
  },
  State_57728_Desc = {
    Text = "O dano de Uvhash aumentou em 1"
  },
  State_57728_Name = {
    Text = "Dom da Blood Surge"
  },
  State_57751_Desc = {
    Text = "Equipe Única: O escudo causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1] %>. Após liberar a Ordem de chave, todos os Corpos Despertos recebem <WeaponEffect_Num:[StateArg2]%> de Taxa de Crítico Temporária e Dano crítico, mas com um sacrifício de 3% da Vida máxima. Se o domínio atual for \"Mar Profundo\", após liberar a Ordem de chave, também aumentará o Dano de tentáculo em <WeaponEffect_Num:[StateArg3]%> da Força de ataque do portador."
  },
  State_57751_WeaponDesc = {
    Text = "O escudo causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1] %>. Após liberar a ordem de chave, todos os corpos despertos ganham <WeaponEffect_Num:[StateArg2]%> de taxa de crítico temporária e dano crítico, mas recebem um sacrifício de [DescArg1] pontos. Se o domínio atual for \"Mar Profundo\", após liberar a ordem de chave, também aumentará o dano de tentáculo em [DescArg2] pontos."
  },
  State_57753_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Obtenha [StateArg1] camadas de <PVPSleepKeywords:Soninho de Qualidade> ao ser equipado."
  },
  State_57753_Name = {
    Text = "Dormir Sob a Geleira"
  },
  State_57766_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após o primeiro \"Exaltar\" a cada turno, ganhe <StrongEffectKeywords:Aumento> Temporário +[StateArg1]."
  },
  State_57766_Name = {
    Text = "Cajado do Pastor"
  },
  State_57767_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No fim do turno, remove <Energy:[Energy:StateArg1]> Loucura para converter em <PVPDerivativeCardKeywords_12:\"Pequeno Desejo\">, se a conversão falhar, ganha <Energy:[Energy:StateArg2]> Loucura."
  },
  State_57767_Name = {
    Text = "Apresentação que Nunca Para"
  },
  State_57768_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: O dano de \"habilidade\" aumenta em [StateArg1]%. Após \"Exaltar\", restaure [StateArg2]% do HP perdido."
  },
  State_57768_Name = {
    Text = "Até a fusão da montanha de neve"
  },
  State_57769_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após jogar um cartão de habilidade do portador, compre 1 cartão de habilidade do portador. O efeito é limitado a 1 vez por turno."
  },
  State_57769_Name = {
    Text = "Porta da Verdade"
  },
  State_57770_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: O Dano, a cura e o Efeito de Escudo causados pela \"habilidade\" aumentam em [StateArg1]~[StateArg2]% (atualmente [Layer] %), <PhantomKeywords:Fantasma>."
  },
  State_57770_Name = {
    Text = "Roulette do Destino"
  },
  State_57814_Name = {
    Text = "Quando este marcador estiver presente, indica que a Roda do destino está sendo trocada. Algumas lógicas precisam reconhecer este marcador."
  },
  State_57817_Desc = {
    Text = "Não pode agir. No final do turno, pilhas - 1. Uma vez que as pilhas estejam esgotadas, <StrongEffectKeywords:Amplicação> +5. Não pode ser dissipado. Mudar a Roda do Destino removerá o estado de Soneca de Qualidade."
  },
  State_57817_Name = {
    Text = "Sono refinado"
  },
  State_57854_Desc = {
    Text = "No início do turno, ganhe [StateArg1] pontos de escudo e [StateArg2] pontos de dano de tentáculo, gere 2 tentáculos temporários, por [Layer] rodadas."
  },
  State_57854_Name = {Text = "Voto livre"},
  State_57854_WeaponDesc = {
    Text = "Estado@DamaDoMarCháECake"
  },
  State_57864_Name = {
    Text = "Bônus de poder de atualização __ \"Para uso de desenvolvimento apenas\""
  },
  State_57942_Desc = {
    Text = "Fusão em [Layer]%. A 100%, inimigo força próxima fase com habilidades mais fortes"
  },
  State_57942_Name = {
    Text = "Grau de Fusão"
  },
  State_57952_Desc = {
    Text = "Quando a força é reduzida, apenas 50% das camadas de força são diminuídas"
  },
  State_57952_Name = {
    Text = "Mergulho Profundo"
  },
  State_57953_Desc = {
    Text = "No final do turno, gere 1 tentáculo. Remova este estado após despertar"
  },
  State_57953_Name = {Text = "Sono"},
  State_57955_Desc = {
    Text = "O dano causado por Hilota foi aumentado em [StateArg1]%, dura [Layer] turnos."
  },
  State_57955_Name = {
    Text = "Sobrevivência em situação desesperadora·Dano"
  },
  State_57968_Desc = {
    Text = "Sob a influência de Juliette, a cada fim de turno, o grau de fusão dos gêmeos aumenta em 10% e uma carta de \"distorção\" é embaralhada na pilha de compra"
  },
  State_57968_Name = {
    Text = "\"Canto de Yuliette\""
  },
  State_57970_Name = {
    Text = "Proteção da mãe divina"
  },
  State_57976_Desc = {
    Text = "\"Filho da Escuridão\" realiza Fusão forçada, causando Dano Fixo igual a 3 vezes sua Vida atual a \"Início do Esquecimento\""
  },
  State_57976_Name = {
    Text = "Sacrifício"
  },
  State_58051_Desc = {
    Text = "Dano Crítico +[Layer]%"
  },
  State_58051_Name = {
    Text = "Dano crítico"
  },
  State_58052_Desc = {
    Text = "A cada 1 ponto de sigilo negro consumido durante a exploração, o dano base de \"tudo ou nada\" aumenta em 0.5%. (Aumentado em [DescArg1]%)"
  },
  State_58052_Name = {
    Text = "Sem risco de perda"
  },
  State_58061_Name = {
    Text = "Integridade ao encontrar dinheiro"
  },
  State_58063_Desc = {
    Text = "Dano causado pelo corpo desperto aumentado em 25%, dura [Layer] turnos."
  },
  State_58063_Name = {
    Text = "Um Olhar que Ultrapassar os Tempos Antigos"
  },
  State_58144_Desc = {
    Text = "Nesta fase, a taxa crítica aumenta em [Layer]%"
  },
  State_58144_Name = {
    Text = "Taxa de Crítico Permanente"
  },
  State_58144_WeaponDesc = {
    Text = "Nesta fase, a taxa crítica aumenta em [Layer]%"
  },
  State_58259_Desc = {
    Text = "Equipe Única: A taxa de crítico do portador aumenta em <WeaponEffect_Num:[StateArg1]%. Após eliminar um inimigo, o portador ganha <WeaponEffect_Num:[StateArg2]> pontos de Marca Negra, podendo ser ativado no máximo 3 vezes durante a exploração. Após 3 ativações, a taxa de crítico do portador aumenta permanentemente em <WeaponEffect_Num:[StateArg3]%> durante esta exploração."
  },
  State_58259_WeaponDesc = {
    Text = "A taxa de crit. do portador aumenta em <WeaponEffect_Num:[StateArg1]%>. Após o portador matar um inimigo, ganhe <WeaponEffect_Num:[DescArg2]> pontos de Sigilo Negro, acionando no máximo 3 vezes durante a exploração ([DescArg1]/3). Após acionar 3 vezes, a taxa de crit. do portador aumentará permanentemente em <WeaponEffect_Num:[StateArg3]%> durante esta exploração."
  },
  State_58297_Desc = {
    Text = "Ryker ganha [DescArg3] marcas negras ao eliminar inimigos, com um máximo de 5 ativações por exploração. ([DescArg1]/5)\n Ao obter 50/125/250 marcas negras através da batalha, o limite de criação aumenta em 1, e ao final da batalha, escolha um \"Legado do Caos\" para adicionar à lista de criações. (Já obteve [DescArg2] pontos de marcas negras)"
  },
  State_58297_Name = {
    Text = "O vencedor leva tudo"
  },
  State_58447_Desc = {
    Text = "Inclui as seguintes três criações: \n \"Casaco de Vento Sortudo\": Aumenta a taxa crítica de todos os corpos despertos em 10%. Todos os efeitos aleatórios de Ryker e dados não terão um valor mínimo. \n <TentacleInjurieIconKeywords:Melhoria>: A taxa crítica aumenta para 15%, aumentando o valor máximo dos resultados aleatórios em 1. \n \"Dado viciado\": Sempre que liberar a ordem de chave, coloque 1 \"Dado viciado\" na mão. \n <TentacleInjurieIconKeywords:Melhoria>: Mude para colocar 1 \"Dado Viciado Brilhante\" na mão. \n \"Botão Boca Grande\": No início do turno e ao ativar o efeito aleatório de Ryker ou dos dados, ganhe 50 pontos de energia da chave de prata e 2% de dano crítico, com um máximo de 30% de dano crítico. \n <TentacleInjurieIconKeywords:Melhoria>: Mude para ganhar 100 pontos de energia da chave de prata e 4% de dano crítico, com um máximo de 50% de dano crítico."
  },
  State_58447_Name = {
    Text = "<CardKeyWord:Legado do Caos>"
  },
  State_58490_Desc = {
    Text = "Quando a sonolência é completamente removida, todos os despertadores e cartas serão selados, e a intenção de \"Senhor do Sono\" será ajustada para \"Autoridade Real\""
  },
  State_58490_Name = {
    Text = "Sonolência"
  },
  State_58491_Desc = {
    Text = "Sempre que jogar uma carta, remova 1 camada de \"sonolência\". No início do turno, restaure para 12 camadas de \"sonolência\"."
  },
  State_58491_Name = {Text = "Raiva"},
  State_58492_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_58492_Name = {
    Text = "Ainda não despertado"
  },
  State_58493_Desc = {
    Text = "Sempre que jogar uma carta, remova 1 camada de \"sonolência\". No início do turno, restaure para 12 camadas de \"sonolência\"."
  },
  State_58493_Name = {Text = "Raiva"},
  State_58947_Desc = {
    Text = "Nesta fase, a taxa crítica aumenta em [Layer]%"
  },
  State_59078_Name = {
    Text = ", pode ser usado 1 vez"
  },
  State_59079_Name = {
    Text = ", pode ser usado 2 vezes"
  },
  State_59080_Name = {
    Text = ", pode ser usado 3 vezes"
  },
  State_59117_Desc = {
    Text = "Dano Crítico +[Layer]%"
  },
  State_59117_Name = {
    Text = "Dano crítico"
  },
  State_59160_Desc = {
    Text = "Aumenta em 10% todo o Dano causado, Recuperar e efeitos de Escudo, não podendo ser dissipado."
  },
  State_59160_Name = {
    Text = "<CardKeyWord: Forte>"
  },
  State_59161_Desc = {
    Text = "O dano, a cura e os efeitos do escudo causados aumentam em [DescArg1]%, não podendo ser dissipados."
  },
  State_59161_Name = {Text = "Eficaz"},
  State_59169_Desc = {
    Text = "O Consumo de potência de cálculo básico desta carta não será superior ao Limite de capacidade de cálculo."
  },
  State_59169_Name = {
    Text = "Equilíbrio__ \"Uso de desenvolvimento apenas\""
  },
  State_59173_Name = {
    Text = "Quando esta marca estiver presente, indica que múltiplos golpes estão em andamento e não acionará novamente múltiplos golpes."
  },
  State_59208_Desc = {
    Text = "Reduz em 10% todo o Dano causado, Recuperar e efeitos de Escudo, não podendo ser dissipado."
  },
  State_59208_Name = {
    Text = "<WeaknessColour:Redução Forte>"
  },
  State_59209_Desc = {
    Text = "O dano, a cura e os efeitos de escudo causados são reduzidos em [DescArg1]%, não podendo ser dissipados."
  },
  State_59209_Name = {
    Text = "Redução poderosa"
  },
  State_59423_Desc = {
    Text = "Ryker ganha 5 marcas negras ao eliminar inimigos, e para cada 1% de queda de marca negra, a quantidade obtida aumenta em 1%, com um máximo de 5 ativações por exploração. \n Ao obter 50/125/250 marcas negras através da batalha, o limite de criação aumenta em 1, e ao final da batalha, escolha um \"Legado do Caos\" para adicionar à lista de criações."
  },
  State_59423_Name = {
    Text = "O vencedor leva tudo"
  },
  State_59424_Desc = {
    Text = "A cada 1 ponto de sigilo negro consumido durante a exploração, o dano base de \"tudo ou nada\" aumenta em 0.5%"
  },
  State_59424_Name = {
    Text = "Sem risco de perda"
  },
  State_59439_Desc = {
    Text = "Este estado usa o multiplicador vulnerável, fazendo parecer uma zona de multiplicador independente.__\"Apenas para desenvolvimento\""
  },
  State_59439_Name = {
    Text = "Se possuir um determinado estado, o dano é dobrado"
  },
  State_59519_Name = {
    Text = "Escolha 1 carta de comando da pilha de draw ou pilha de descarte e coloque na sua mão, fazendo seu custo aritmético se tornar 0"
  },
  State_59520_Desc = {
    Text = "Após jogar, compre 2 cartões e reduza seu custo de Aritmética pelo custo real de Aritmética do cartão de Oração, tendo efeito apenas uma vez por batalha."
  },
  State_59520_Name = {
    Text = "<WhiteQuality:Sabedoria>"
  },
  State_59521_Name = {
    Text = "Perder 10% da vida atual ([DescArg1])"
  },
  State_59522_Desc = {
    Text = "Jogue e então descarte todas as outras cartas, exceto por este despertador, ganhando 5 cartas aleatórias que não são despertadores; isso só tem efeito uma vez por batalha."
  },
  State_59522_Name = {
    Text = "<WhiteQuality:Alegria>"
  },
  State_59525_Name = {
    Text = "O Desperto correspondente à carta de comando ganha 50 pontos de Loucura"
  },
  State_59526_Desc = {
    Text = "Ao jogar, ganhe 3 cópias base <RetainIconKeywords:Retain> e <DepleteIconKeywords:Exhaust>, efetivo apenas uma vez por batalha."
  },
  State_59526_Name = {
    Text = "<WhiteQuality:Procriação>"
  },
  State_59534_Name = {
    Text = "Quando esta marca está presente, indica que esta carta proíbe a ativação do Fantasma."
  },
  State_59560_Name = {
    Text = "Escolha uma carta que tenha recebido três orações de matéria primária para adicionar à mão"
  },
  State_59671_Desc = {
    Text = "Neste turno, dano final de todos os despertos aumenta 15%"
  },
  State_59671_Name = {
    Text = "Relógio de Hipercorda"
  },
  State_59673_Name = {
    Text = "Caixinha de música"
  },
  State_59678_Desc = {
    Text = "Ao pegar, perca todas as outras relíquias e ganhe aleatoriamente 2 relíquias de ouro"
  },
  State_59878_Desc = {
    Text = "No final do turno, reduza 1 capa extra de \"Caos\" e ganhe [StateArg1] <PowerIconKeywords:FOR>. As cópias subsequentes de \"N\" invocadas terão 200% mais vida e ao morrer não reduzirão mais as capas de \"Caos\" nem ganharão <PowerIconKeywords:FOR>."
  },
  State_59878_Name = {Text = "Caos chega"},
  State_59991_Name = {
    Text = ", Este símbolo pode consumir até 5 camadas <EnergyStorageKeywords:carga> ao ser jogado"
  },
  State_59993_Name = {
    Text = "Recupere 10% da vida perdida ([DescArg1])"
  },
  State_60000_Desc = {
    Text = "Ganha 1 capa de <MadnessIconKeywords:Loucura> Temporária ao receber Dano ativo."
  },
  State_60000_Name = {
    Text = "Acumulação de raiva"
  },
  State_60028_Desc = {
    Text = "No início do turno do jogador, faça com que uma das cartas da mão tenha o custo de poder alterado para 3 neste turno. Após a morte, esse efeito se extingue e diminui o custo de poder de todas as cartas do matador em 1 para este turno"
  },
  State_60028_Name = {
    Text = "Delírio da Gaiola"
  },
  State_60044_Name = {
    Text = "Consome após [Layer] usos"
  },
  State_60083_Desc = {
    Text = "Dano recebido neste turno -[Layer]%."
  },
  State_60083_Name = {
    Text = "<ReinforceColour:reforçado>"
  },
  State_60083_WeaponDesc = {
    Text = "Dano causado reduzido em [DescArg1] %"
  },
  State_60085_Desc = {
    Text = "No início da batalha e do turno, ganhe reforçado temporário; quanto maior a vida do jogador, mais camadas serão obtidas, com um máximo de 50 camadas"
  },
  State_60085_Name = {
    Text = "Pupação final"
  },
  State_60085_WeaponDesc = {
    Text = "Dano causado reduzido em [DescArg1] %"
  },
  State_60086_Desc = {
    Text = "No início da batalha e do turno, ganhe reforçado temporário; quanto maior a vida do jogador, mais camadas serão obtidas, com um máximo de 25 camadas"
  },
  State_60086_Name = {Text = "Pupação"},
  State_60086_WeaponDesc = {
    Text = "Dano causado reduzido em [DescArg1] %"
  },
  State_60087_Desc = {
    Text = "Efeito de ferida reduzido em [Layer]% de recuperação de vida"
  },
  State_60087_Name = {
    Text = "<Rune_14_High:Ferida Aumentada>"
  },
  State_60087_WeaponDesc = {
    Text = "Dano causado reduzido em [DescArg1] %"
  },
  State_60088_Desc = {
    Text = "Cada capa reduz o Dano recebido em 1%."
  },
  State_60088_Name = {
    Text = "<ReinforcePVEKeywords:reforçado>"
  },
  State_60088_WeaponDesc = {
    Text = "Todos os escudos obtidos são reduzidos em 25%"
  },
  State_60089_Desc = {
    Text = "Dano recebido -[Layer]%."
  },
  State_60089_Name = {
    Text = "<ReinforceColour:reforçado>"
  },
  State_60089_WeaponDesc = {
    Text = "Dano causado reduzido em [DescArg1] %"
  },
  State_60106_Desc = {
    Text = "Após o início da rodada, o custo de aritmética de uma carta na mão muda para 3, recuperando-se ao final da rodada"
  },
  State_60106_Name = {
    Text = "Delírio da Gaiola"
  },
  State_60112_Desc = {
    Text = "Neste turno, cada carta de comando jogada dá 1 de loucura a todos os despertos"
  },
  State_60112_Name = {Text = "Concerto"},
  State_60115_Desc = {
    Text = "Após liberar a explosão de loucura nesta rodada, diminui a fusão dos gêmeos em 3%"
  },
  State_60115_Name = {Text = "Requiem"},
  State_60118_Desc = {
    Text = "O dano, veneno e contra-ataque causados nesta rodada aumentam em [Layer]%"
  },
  State_60118_Name = {Text = "Rapsódia"},
  State_60128_Desc = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_60128_WeaponDesc = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_60129_Desc = {
    Text = "Você jogou a seguinte carta de comando não derivada do [Layer], e o custo de poder é -2"
  },
  State_60129_Name = {
    Text = "Nota descendente"
  },
  State_60130_Desc = {
    Text = "Você jogou a seguinte carta de comando não derivada do [Layer], e o custo de poder é +2, efetivo 2 vezes"
  },
  State_60130_Name = {
    Text = "Nota ascendente"
  },
  State_60148_Desc = {
    Text = "No final do turno, recebe diferentes efeitos dependendo do estado: solto - ganha 1 camada de <MadnessIconKeywords:loucuras> temporária. fechado - ganha 50 camadas de <ReinforcePVEKeywords:reforçado> temporárias"
  },
  State_60148_Name = {
    Text = "Ajuste de parâmetros"
  },
  State_60150_Desc = {
    Text = "Sempre que sentir o jogador usar uma chave, alterna entre os modos Liberar e Conter. Ao alternar para Liberar, ganha [StateArg1] força temporária. Ao alternar para Conter, ganha [StateArg2] escudo"
  },
  State_60150_Name = {
    Text = "Sensibilidade funcional"
  },
  State_60151_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_60151_Name = {
    Text = "Ainda não despertado"
  },
  State_60154_Desc = {
    Text = "Atualmente, está na forma - Concentração. O equipamento mecânico ganhará escudo e alerta, e a intenção será focada em defesa"
  },
  State_60154_Name = {
    Text = "Arma Mecânica - Coletar"
  },
  State_60155_Desc = {
    Text = "Atualmente, está na forma - Dispensa. O equipamento mecânico ganhará força, e a intenção será focada em ataque"
  },
  State_60155_Name = {
    Text = "Arma Mecânica - Colocar"
  },
  State_60167_Desc = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_60167_WeaponDesc = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_60184_Desc = {
    Text = "Sempre que uma carta é jogada, \"Gêmeos Contraditórios\" muda sua intenção"
  },
  State_60184_Name = {
    Text = "contradição"
  },
  State_60187_Desc = {
    Text = "Fraqueza, vulnerabilidade e feridas graves causadas ao jogador são 50%"
  },
  State_60187_Name = {
    Text = "O fim é o começo"
  },
  State_60201_Name = {
    Text = "Força Atrasada do Monstro"
  },
  State_60263_Desc = {
    Text = "Efeito de fraqueza reduzido em [Layer]% e ganha escudo"
  },
  State_60263_Name = {
    Text = "<Rune_14_High:Fragilidade Aumentada>"
  },
  State_60264_Desc = {
    Text = "O efeito de sangramento causado só será removido automaticamente em 50% ao final da rodada"
  },
  State_60264_Name = {
    Text = "<Rune_14_High:Hemólise>"
  },
  State_60265_Desc = {
    Text = "O efeito de sangramento será removido automaticamente em 50% ao final do turno"
  },
  State_60265_Name = {
    Text = "<BleedingColour: Hemólise>"
  },
  State_60279_Name = {
    Text = "Esta carta será consumida no final do turno"
  },
  State_60284_Desc = {
    Text = "No início da batalha e do turno, ganhe reforçado temporário; quanto menor a vida do jogador, mais camadas serão obtidas, com um máximo de 50 camadas"
  },
  State_60284_Name = {
    Text = "Formação de Espada Inquebrável"
  },
  State_60284_WeaponDesc = {
    Text = "Dano causado reduzido em [DescArg1] %"
  },
  State_60297_Desc = {
    Text = "'@2 aparece com um aspecto libertador, a vida se torna 3 vezes mais. E a cada turno, questionará o guardião, colocando uma carta \"Resposta Tawil\" em sua mão.'"
  },
  State_60297_Name = {
    Text = "Pergunta de verdade"
  },
  State_60297_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_60298_Desc = {
    Text = "O poder de uma existência desconhecida ainda permanece adormecido sob a piscina negra, prestes a ser derrotado antes de reviver completamente, retornando à vida e começando a lutar em sua forma libertadora"
  },
  State_60298_Name = {
    Text = "hibernação"
  },
  State_60312_Desc = {
    Text = "A cada turno, ao acumular 10% de dano à vida, ganha [Layer] camadas de \"reforçado\""
  },
  State_60312_Name = {
    Text = "Escudo de Névoa Corrosiva"
  },
  State_60315_Desc = {
    Text = "Após liberar a explosão de loucura nesta rodada, restaura 5% ( [DescArg1] ) da vida perdida"
  },
  State_60315_Name = {Text = "Requiem"},
  State_60336_Name = {
    Text = "Após jogar, ganhe 1 ponto de aritmética e puxe 1 carta, mas esta carta será exaurida"
  },
  State_60339_Name = {
    Text = "Jogar este cartão concede 1 Aritmética e pesca 1 Cartão, mas este Cartão ficará Exausto"
  },
  State_60367_Desc = {
    Text = "No início do turno do jogador, faça com que uma das cartas da mão tenha o custo de poder alterado para 3 neste turno. Após a morte, esse efeito se extingue e diminui o custo de poder de todas as cartas do matador em 1 para este turno"
  },
  State_60367_Name = {
    Text = "Delírio da Gaiola"
  },
  State_60386_Desc = {
    Text = "Os efeitos incluem: causar 150% de dano por sangramento, causar 75% de dano por veneno, aplicar 1 camada de fraqueza, aplicar 1 camada de vulnerabilidade, reduzir temporariamente [DescArg1] pontos de poder"
  },
  State_60386_Name = {
    Text = "<MysterydebuffKeywords:Efeito Negativo Misterioso>"
  },
  State_60404_Desc = {
    Text = "A cada dano sofrido, obtenha 2 camadas de reforço temporário"
  },
  State_60404_Name = {
    Text = "Transformação Final"
  },
  State_60408_Desc = {
    Text = "Sempre que a vida cair para 33% (faltando [DescArg1] pontos), não receberá mais dano neste turno e ativará \"Mordida Fantasma\""
  },
  State_60408_Name = {
    Text = "Mordida da Máscara Fantasma"
  },
  State_60409_Desc = {
    Text = "Sempre que a vida cair para 66% (faltando [DescArg1] pontos), não receberá mais dano neste turno e ativará \"Metamorfose Final\""
  },
  State_60409_Name = {
    Text = "Espelho do Fim"
  },
  State_60429_Name = {
    Text = "Estado@despertador hameln@som primordial"
  },
  State_60430_Desc = {
    Text = "Ao jogar uma carta cujo custo real de aritmética e intenção esteja de acordo, ela será exaurida e todos os inimigos perdem [DescArg1] pontos de poder temporário"
  },
  State_60430_Name = {
    Text = "Ordem Rítmica de Notas"
  },
  State_60431_Name = {
    Text = "Estado@despertador hameln@som ascendente"
  },
  State_60432_Name = {
    Text = "Estado@despertador hameln@sinfonia da alma"
  },
  State_60433_Name = {
    Text = "Estado@despertador hameln@som descendente"
  },
  State_60434_Name = {
    Text = "Estado@despertador hameln@recital de reminiscência"
  },
  State_60435_Name = {
    Text = "Estado@despertador hameln@contagem de sinfonia da alma"
  },
  State_60436_Desc = {
    Text = "Ao causar dano não bloqueado, embaralhe [StateArg1] cartas \"feridas\" no baralho de puxar"
  },
  State_60436_Name = {
    Text = "Pré-lúdio da Alma"
  },
  State_60438_Name = {
    Text = "Estado@despertador hameln@monitoramento de som ascendente"
  },
  State_60439_Name = {
    Text = "Estado@despertador hameln@monitoramento de som descendente"
  },
  State_60440_Name = {
    Text = "Estado@despertador hameln@monitoramento de sinfonia da alma"
  },
  State_60441_Name = {
    Text = "Estado@despertador hameln@monitoramento de recital de reminiscência"
  },
  State_60442_Name = {
    Text = "Estado@despertador hameln@monitoramento de som primordial"
  },
  State_60486_Desc = {
    Text = "No início da batalha, a loucura de todos os despertos é reduzida pela metade"
  },
  State_60486_Name = {
    Text = "Absorção da Deusa Mãe"
  },
  State_60487_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, aumentando a saúde máxima em 200%, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_60487_Name = {
    Text = "Ainda não despertado"
  },
  State_60490_Desc = {
    Text = "Após a morte, todos os despertares ganham 30 pontos de loucura"
  },
  State_60490_Name = {
    Text = "Desejo de viver"
  },
  State_60491_Desc = {
    Text = "A loucura causada por todos os despertos é reduzida em 50%. No final do turno, ganhe 1 camada de \"<DarkEgo:lado sombrio do eu>\": no início do turno, todos os despertos ganham 3 de loucura."
  },
  State_60491_Name = {
    Text = "Ritual da Árvore Mãe"
  },
  State_60493_Desc = {
    Text = "A cada [Layer] pontos de vida acumulados que forem reduzidos, invoca-se um despertador mimético. Se já houver 2 despertadores miméticos em campo, a saúde máxima de todos os despertadores miméticos aumenta em 50%"
  },
  State_60493_Name = {
    Text = "Mãe Nutridora"
  },
  State_60500_Desc = {
    Text = "Se houver despertadores com mimetismo, você ganha 50 camadas de \"esconder\""
  },
  State_60500_Name = {
    Text = "Oculto na floresta"
  },
  State_60511_Desc = {
    Text = "Aparece na mão inicial"
  },
  State_60511_Name = {
    Text = "<GuyouKeywords:Inerente>"
  },
  State_60511_WeaponDesc = {
    Text = "Após jogar, a carta não irá para a pilha de descarte e não poderá ser usada novamente nesta batalha"
  },
  State_60522_Desc = {
    Text = "Efeitos de fraqueza e ferida aumentados para 50%"
  },
  State_60522_Name = {
    Text = "Destruição"
  },
  State_60523_Desc = {
    Text = "Cada camada adiciona 1 ataque, perde 1 camada ao sofrer dano, perde todas no fim do turno"
  },
  State_60523_Name = {Text = "Oração"},
  State_60524_Desc = {
    Text = "No início da batalha e do turno, ganhe [Layer] camadas de reforçado, no máximo 50 camadas"
  },
  State_60524_Name = {
    Text = "Sanctificação"
  },
  State_60524_WeaponDesc = {
    Text = "Dano causado reduzido em [DescArg1] %"
  },
  State_60527_Desc = {
    Text = "Após jogar, é consumido, mas reduz a força temporária do inimigo"
  },
  State_60527_Name = {
    Text = "<CardKeyWord:Paraíso Melódico>"
  },
  State_60543_Desc = {
    Text = "No final do turno, ganhe 10 Camadas de \"Juramento de Sangue\", que são removidas ao receber dano"
  },
  State_60543_Name = {
    Text = "Fogo da Meca"
  },
  State_60554_Name = {
    Text = "<HuihuanbKeywords:Som de eco>"
  },
  State_60558_Name = {
    Text = "<HuihuanbKeywords:Som de eco>"
  },
  State_60562_Desc = {
    Text = "Jogue para ativar 2 vezes, mudando para \"Som Acumulado\""
  },
  State_60562_Name = {
    Text = "<HuihuanaKeywords:Som de eco>"
  },
  State_60564_Desc = {
    Text = "Quando estiver prestes a ser derrotado pela primeira vez, recupere vida e mude a intenção para \"Evolução Final\", ganhando força e reforço. Quando estiver prestes a ser derrotado pela segunda vez, recupere vida e mude a intenção para \"Mordida da Máscara Fantasma\", causando dano extremo em um único golpe."
  },
  State_60564_Name = {
    Text = "Demônio Sombrio"
  },
  State_60567_Desc = {
    Text = "Após jogar, hameln ganha 3 de aliemus"
  },
  State_60567_Name = {
    Text = "<XushiAKeywords:Som Acumulado>"
  },
  State_60568_Name = {
    Text = "<XushiAKeywords:Som Acumulado>"
  },
  State_60569_Name = {
    Text = "<XushiBKeywords:Som Acumulado>"
  },
  State_60570_Desc = {
    Text = "Após jogar, hameln ganha 3 de aliemus"
  },
  State_60570_Name = {
    Text = "<XushiBKeywords:Som Acumulado>"
  },
  State_60571_Name = {
    Text = "<HuihuanaKeywords:Som de eco>"
  },
  State_60576_Desc = {
    Text = "No início do turno do jogador, faça com que uma das cartas da mão tenha o custo de poder alterado para 3 neste turno. Após a morte, esse efeito se extingue e diminui o custo de poder de todas as cartas do matador em 1 para este turno"
  },
  State_60576_Name = {
    Text = "Delírio da Gaiola"
  },
  State_60578_Desc = {
    Text = "Ao receber dano fatal, você recuperará 50% da vida, imunidade ao dano por 1 turno, a intenção se transforma em “quebrar a casca”"
  },
  State_60578_Name = {Text = "Eclosão"},
  State_60592_Desc = {
    Text = "Ao iniciar a exploração, adicione 1 \"Luz do Amanhecer da Chave de Prata\" com <DestructionKeywords:Destruir> ao baralho.\nSempre que a Ordem de chave for liberada, o Dano crítico do Portador +<WeaponEffect_Num:[StateArg1]%>.\nSempre que o Portador causar Dano ativo, sua Taxa de Crítico +<WeaponEffect_Num:[StateArg3]%> neste turno e você ganha Energia da Chave de Prata igual a <WeaponEffect_Num:[StateArg2]%> de seu Recarregar Chave de Prata, até 5 vezes por turno."
  },
  State_60592_WeaponDesc = {
    Text = "Ao iniciar a exploração, adicione 1 \"Luz do Amanhecer da Chave de Prata\" com <DestructionKeywords:Destruir> ao baralho.\nSempre que a Ordem de chave for liberada, o Dano crítico do Portador +<WeaponEffect_Num:[StateArg1]%>.\nSempre que o Portador causar Dano ativo, sua Taxa de Crítico Temporária +<WeaponEffect_Num:[StateArg3]%> e você ganha <WeaponEffect_Num:[DescArg1]> de Energia da Chave de Prata, até 5 vezes por turno."
  },
  State_60594_Desc = {
    Text = "Equipe única: Após o final do turno, o portador ganha 5 pontos de aliemus. Após liberar a exaltação, a próxima carta de comando jogada pelo portador neste turno terá sua taxa crítica, dano crítico, escudo e recuperação de vida aumentados em <WeaponEffect_Num:[StateArg1]%>."
  },
  State_60594_WeaponDesc = {
    Text = "Após o final do turno, o portador ganha 5 de exaltação. Após liberar a exaltação, a próxima carta de comando jogada pelo portador neste turno terá sua taxa critica, dano crítico, escudo e recuperação de vida aumentados em <WeaponEffect_Num:[StateArg1] %>"
  },
  State_60898_Desc = {
    Text = "Ao receber Dano ativo e Dano de tentáculo, sela a Fúria Explosiva e as Cartas de comando do Corpo Desperto atacante por 1 turno, remove 1 capa de <ResentChainsKeywords:Cadeia de Rancor>."
  },
  State_60898_Name = {
    Text = "<ResentChainsKeywords1:Cadeia de Rancor>"
  },
  State_60925_Desc = {
    Text = "Ao final da rodada, restaure 5% da vida perdida. Sempre que o jogador compra 1 carta de sintoma ou Estado, todos os aliados ganham [Layer] pontos de poder"
  },
  State_60925_Name = {
    Text = "Lanterna de Sangue"
  },
  State_60926_Desc = {
    Text = "No final do turno, se a vida estiver abaixo de 50%, ganhe [Layer] de Força e [StateArg1] Camadas de Barreira"
  },
  State_60926_Name = {
    Text = "Altar da Lanterna Sagrada"
  },
  State_60953_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: \"Exaltação da Loucura\" causa [StateArg1] camadas de <PVPSlowKeywords:Devagar> a todos os alvos inimigos antes de lançar."
  },
  State_60953_Name = {
    Text = "Réquiem Eterno"
  },
  State_60962_Desc = {
    Text = "Durante esta batalha, a saúde máxima aumenta em [Layer]%"
  },
  State_60962_Name = {
    Text = "Aumento de vida"
  },
  State_60964_Desc = {
    Text = "Dano aumentado em [Layer]% nesta batalha"
  },
  State_60964_Name = {
    Text = "Dano aumentado"
  },
  State_61038_Name = {
    Text = "Hamelin Demo"
  },
  State_61050_Desc = {
    Text = "Quando o efeito \"Melodia\" é ativado ou \"Sinfonia da Harmonia\" é disparada, Hameln ganha 1% de Taxa de Crítico e Dano crítico (atualmente ganhou [DescArg1]%). A cada 10 ativações, o número de acertos de Dano de \"Pré-lúdio da Alma\" e \"Nada da Origem\" +1 nesta batalha, com um máximo de 3 vezes."
  },
  State_61050_Name = {
    Text = "Rêverie sob a lua"
  },
  State_61051_Desc = {
    Text = "Quando o efeito \"Melodia\" é ativado ou \"Sinfonia da Harmonia\" é disparada, Hameln ganha 1% de Taxa de Crítico e Dano crítico. A cada 10 ativações, o número de acertos de Dano de \"Pré-lúdio da Alma\" e \"Nada da Origem\" +1 nesta batalha, com um máximo de 3 vezes."
  },
  State_61051_Name = {
    Text = "Rêverie sob a lua"
  },
  State_61056_Desc = {
    Text = "No primeiro turno, ganhe 100 pontos de força temporária"
  },
  State_61056_Name = {Text = "Fúria"},
  State_61084_Desc = {
    Text = "Na próxima [Layer] carta jogada nesta rodada: se o custo de poder computacional for maior ou igual a 3, ganhe 2 pontos de poder computacional, caso contrário, compre 2 cartas."
  },
  State_61084_Name = {
    Text = "Quarto movimento"
  },
  State_61085_Desc = {
    Text = "Consumo de capacidade - 2, efetiva 2 vezes após jogar, mudando para \"Música de Acumulação.\""
  },
  State_61085_Name = {
    Text = "<HuihuanbKeywords:Som de eco>"
  },
  State_61089_Desc = {
    Text = "A próxima carta de comando jogada ativa 2 vezes"
  },
  State_61089_Name = {
    Text = "Batuta de Orquestra"
  },
  State_61145_Name = {
    Text = "<BleedingColour:sangrando>"
  },
  State_61174_Desc = {
    Text = "Não pode ganhar escudo"
  },
  State_61174_Name = {
    Text = "Envio dos remanescentes"
  },
  State_61180_Desc = {
    Text = "O dano base de Corrente de Sangue: Hilota foi aumentado em [DescArg1]% nesta batalha."
  },
  State_61180_Name = {
    Text = "Lâmina de Vingança"
  },
  State_61185_Desc = {
    Text = "Amplia as habilidades do inimigo. Perde uma camada a cada dano recebido"
  },
  State_61185_Name = {
    Text = "Juramento de Sangue"
  },
  State_62213_Desc = {
    Text = "Altera o efeito de Sintoma: Enfraquecer para reduzir o Dano ativo e Dano de tentáculo causado em [Layer]%."
  },
  State_62213_Name = {
    Text = "<Rune_14_High:Fraqueza Aumentada>"
  },
  State_62309_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Equipado, ganha [StateArg1] <StrongEffectKeywords:Eficaz>. Sempre que o Portador perde vida e a vida atual estiver abaixo de [StateArg2]%, ganha <ReinforceKeywords:Reforço> e <StrengthenKeywords:Reforço>."
  },
  State_62309_Name = {
    Text = "Afogando-se em Carmesim"
  },
  State_62317_Desc = {
    Text = "Imune a todo dano, removido no início do turno"
  },
  State_62317_Name = {
    Text = "Imune completamente ao dano"
  },
  State_62336_Desc = {
    Text = "Sempre que jogar 3 cartas (sobrando [Layer] cartas), compre 1 carta e congele aleatoriamente 1 carta de comando na mão"
  },
  State_62336_Name = {
    Text = "O frio do inverno"
  },
  State_62337_Desc = {
    Text = "Sempre que jogar 3 cartas (sobrando [Layer] cartas), compre 1 carta e congele aleatoriamente 1 carta de comando na mão"
  },
  State_62337_Name = {
    Text = "O frio do inverno"
  },
  State_62338_Desc = {
    Text = "Este cartão não pode ser jogado, não será descartado no final da rodada e fará com que o despertador associado ganhe 5 pontos de aliemus, cancelando o congelamento após liberar a explosão de aliemus"
  },
  State_62338_Name = {
    Text = "<CardKeyWord:Congelar>"
  },
  State_65332_Desc = {
    Text = "Após a morte, todos os despertares ganham 30 pontos de loucura"
  },
  State_65332_Name = {Text = "Fusão"},
  State_65342_Desc = {
    Text = "Ao ser derrotado, ressuscite com 100% a mais de saúde máxima e libere \"Congelamento\"."
  },
  State_65342_Name = {Text = "Silêncio"},
  State_65346_Desc = {
    Text = "Após a morte, congele 2 cartas de comando do baralho de mão"
  },
  State_65346_Name = {Text = "Geada"},
  State_65358_Desc = {
    Text = "Equipe Única: O dano básico causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%. Antes de o portador liberar a Fúria Explosiva, o limite temporário de cartas na mão aumenta em +1, e o portador compra 1 carta de comando. Se o domínio atual for \"Carne e sangue\", ao ativar o efeito Devorar, o dano crítico temporário aumenta em <WeaponEffect_Num:[StateArg1]%, podendo ser ativado uma vez por turno."
  },
  State_65358_WeaponDesc = {
    Text = "O dano básico causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1] %>. Antes de liberar a Fúria Explosiva, o limite temporário de cartas na mão aumenta em +1 e o portador compra 1 carta de comando. Se o domínio atual for \"Carne e sangue\", quando o portador ativar o efeito Devorar, o Dano Crítico Temporário aumenta em <WeaponEffect_Num:[StateArg1] %>, podendo ser ativado no máximo 1 vez por turno."
  },
  State_65360_Desc = {
    Text = "Equipe Única: O dano básico causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%. No início da batalha, o portador ganha 25 camadas de \"Neve\". Após disparar uma carta, o portador ganha 2 pontos de Fúria e remove 1 camada. Após a remoção completa de \"Neve\", o portador ganha <WeaponEffect_Num:[StateArg2]%> de taxa crítica."
  },
  State_65360_WeaponDesc = {
    Text = "O dano básico causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%.> No início da batalha, o portador ganha 25 camadas de \"Neve\". Após disparar uma carta, o portador ganha 2 pontos de Fúria e remove 1 camada. Após a remoção completa de \"Neve\", o portador ganha <WeaponEffect_Num:[StateArg2]%> de taxa crítica (camadas restantes de Neve: [DescArg1])."
  },
  State_65362_Desc = {
    Text = "A cada [StateArg1] danos recebidos (restam [Layer]), congela aleatoriamente 1 carta de comando na mão"
  },
  State_65362_Name = {
    Text = "Retorno de Geada"
  },
  State_65463_Name = {
    Text = "Ganha 5 pontos o sigilo negro"
  },
  State_65490_Desc = {
    Text = "No final do turno, ganhe [StateArg1] Camadas de Escudo de Gelo e [StateArg2] Força"
  },
  State_65490_Name = {
    Text = "Zero Absoluto"
  },
  State_65497_Name = {
    Text = "Cadeia de Sangue · Shiro Teste"
  },
  State_65553_Desc = {
    Text = "No final do turno, ganhe força com base no número de cartas restantes na mão, [Layer] pontos por carta"
  },
  State_65553_Name = {
    Text = "Lâmina de Gelo"
  },
  State_65557_Desc = {
    Text = "Após receber dano fatal, restaura toda a vida, transforma a intenção em \"Olhar Verdadeiro do Vazio\", ganha 80 camadas de reforço temporário e remove todos os estados negativos em si e estados positivos do jogador. Ao final do turno, remove 20 camadas de reforço."
  },
  State_65557_Name = {
    Text = "Caos Antigo"
  },
  State_65558_Desc = {
    Text = "Após receber dano fatal, transforme a intenção em \"Atenção ao espaço profundo\" e ganhe 80 camadas de reforço temporário, recupere toda a vida, pode ser ativado [DescArg1] vezes. Após esgotar as ativações, ao receber dano fatal, preservará 1 ponto de vida e mudará a intenção para \"Olho do Mundo Infindável\". Ao final do turno, remova 20 camadas de reforço."
  },
  State_65558_Name = {
    Text = "Poeira de estrelas"
  },
  State_65559_Desc = {
    Text = "Após todos morrerem, Tohuwa Bovu aparecerá novamente."
  },
  State_65559_Name = {
    Text = "Fragmentos Antigos"
  },
  State_65564_Name = {
    Text = "\n<D05EX_Relic: As suspeitas dos membros da equipe de pesquisa sobre Hilota aumentam constantemente, você deve fazer uma escolha antes que o inimigo se aproxime e acalmar a equipe confusa>"
  },
  State_65565_Name = {
    Text = [[

<D05EX_Relic:Ignorar a suspeita dos membros e continuar em frente>]]
  },
  State_65566_Name = {
    Text = "\n<D05EX_Relic:Explicar a situação aos membros da expedição>"
  },
  State_65567_Name = {
    Text = [[

<D05EX_Relic: Restringir Hilota para proteger mais os membros da equipe>]]
  },
  State_65568_Name = {
    Text = [[

<D05EX_Relic: Restringir Hilota e usar o poder do despertador para proteger totalmente os membros da equipe>]]
  },
  State_65585_Desc = {
    Text = "Após Disparar esta carta, ela retorna à sua mão. A Oração é desativada até o final do turno."
  },
  State_65585_Name = {
    Text = "<CardKeyWord:Eco>"
  },
  State_66305_Desc = {
    Text = "Ao fim da rodada, obtém 1 camada de <ResentChainsKeywords:Cadeia de Rancor> Temporária."
  },
  State_66305_Name = {
    Text = "Trava de Tempos Imemoriais até o Presente"
  },
  State_66306_Desc = {
    Text = "Ao receber Dano ativo e Dano de tentáculo, sela a Fúria Explosiva e as Cartas de comando do Corpo Desperto atacante por 1 turno, remove 1 capa de <ResentChainsKeywords:Cadeia de Rancor>."
  },
  State_66306_Name = {
    Text = "<ResentChainsKeywords1:Cadeia de Rancor>"
  },
  State_66308_Desc = {
    Text = "Após receber dano fatal, bloqueia a vida em 1."
  },
  State_66308_Name = {
    Text = "Caos Antigo"
  },
  State_66311_Desc = {
    Text = "As memórias dos ativadores irrompem da borda da sua mente, enraizando-se e crescendo em seu cérebro. Não importa quantas vezes você as corte, não importa quantas vezes a dissolução as derrube, elas nunca partiram"
  },
  State_66311_Name = {
    Text = "Memórias Fragmentadas"
  },
  State_66313_Desc = {
    Text = "Cada vez que jogar 1 carta de comando, descarte 1 carta desse despertador com o menor custo de aritmética."
  },
  State_66313_Name = {
    Text = "Intimidação da Vontade Suprema"
  },
  State_66314_Desc = {
    Text = "Imune a todo dano."
  },
  State_66314_Name = {
    Text = "Imune completamente ao dano"
  },
  State_66317_Desc = {
    Text = "As memórias dos ativadores irrompem da borda da sua mente, enraizando-se e crescendo em seu cérebro. Não importa quantas vezes você as corte, não importa quantas vezes a dissolução as derrube, elas nunca partiram. No início de cada turno, retorne 1 ponto do limite de capacidade de cálculo e 2 pontos do limite de cartas na mão."
  },
  State_66317_Name = {
    Text = "Fragmento de memória"
  },
  State_66325_Desc = {
    Text = "As memórias dos ativadores irrompem da borda da sua mente, enraizando-se e crescendo em seu cérebro. Não importa quantas vezes você as corte, não importa quantas vezes a dissolução as derrube, elas nunca partiram. No início de cada turno, recupere 1 ponto de limite de capacidade de cálculo e 2 pontos de limite de cartas na mão."
  },
  State_66325_Name = {
    Text = "Fragmento de memória"
  },
  State_66358_Desc = {
    Text = "Ao ativar a resistência à morte pela primeira vez na exploração, adicione uma carta \"<DerivativeCardKeywords_39:Ecos do Passado>\" à sua mão"
  },
  State_66358_Name = {
    Text = "Existência inexistente"
  },
  State_66359_Desc = {
    Text = "Gere aleatoriamente várias opções para escolha."
  },
  State_66359_Name = {
    Text = "<FaxianKeywords:descoberta>"
  },
  State_66360_Desc = {
    Text = "Durante esta batalha, a taxa crítica aumenta em [Layer]%"
  },
  State_66360_Name = {
    Text = "Taxa de Crítico"
  },
  State_66362_Desc = {
    Text = "Dano crítico aumentado em [Layer]% nesta batalha"
  },
  State_66362_Name = {
    Text = "Dano crítico"
  },
  State_66409_Name = {
    Text = "O Julgamento do Árbitro"
  },
  State_66410_Desc = {
    Text = "A próxima carta de comando de Tawil jogada [DescArg1] terá efeito 2 vezes."
  },
  State_66410_Name = {
    Text = "Tudo converge para o um"
  },
  State_66414_Desc = {
    Text = "Enquanto estiver na mão, se a carta do topo do baralho for uma carta de comando, transforma-se em sua cópia"
  },
  State_66414_Name = {
    Text = "Compreender os Princípios de Tudo"
  },
  State_66454_Desc = {
    Text = "Redução do custo de habilidade da carta em \"esconder\", com no máximo 5 camadas; uma camada é removida ao sofrer dano ou usar uma habilidade"
  },
  State_66454_Name = {Text = "Esconder"},
  State_66456_Desc = {
    Text = "Redução do custo de habilidade da carta em \"esconder\", com no máximo 5 camadas; uma camada é removida ao sofrer dano ou usar uma habilidade"
  },
  State_66456_Name = {
    Text = "<YinniColour: Esconder>"
  },
  State_66465_Desc = {
    Text = "Após usar a exaltação, sofre dano correspondente ao nível"
  },
  State_66465_Name = {
    Text = "<PVPfengsuoColour:Bloqueio Explosivo>"
  },
  State_66522_Desc = {
    Text = "Cada 8ª carta jogada terá efeito duplo"
  },
  State_66522_Name = {
    Text = "Vinho das Estrelas"
  },
  State_66553_Desc = {
    Text = "Após jogar \"Ataque\" e \"Defesa\", o corpo correspondente ganha 35 de aliemus. No entanto, o consumo de aritmética deles aumenta em 1"
  },
  State_66553_Name = {
    Text = "Rosto quebrado"
  },
  State_66554_Desc = {
    Text = "Quando coletado, coloque 1 <DerivativeCardKeywords_1:\"Ethereal Echo\"> na sua mão."
  },
  State_66554_Name = {
    Text = "Equipamento de comunicação"
  },
  State_66555_Desc = {
    Text = "A saúde máxima aumenta em 1"
  },
  State_66555_Name = {
    Text = "Seringue ativa"
  },
  State_66556_Desc = {
    Text = "Sempre que jogar cartas do mesmo Despertado consecutivamente, esse Despertado ganha 8 de Loucura"
  },
  State_66556_Name = {
    Text = "Timer Preciso"
  },
  State_66557_Desc = {
    Text = "Ao perder vida, ganha [DescArg1] de <PowerIconKeywords:Força>, acumulando até 10 vezes por batalha. Ao atingir o limite, recupera 25% da vida perdida"
  },
  State_66557_Name = {
    Text = "Honra Suprema"
  },
  State_66558_Desc = {
    Text = "A cada 3 turnos, aplica 1 camada de <WeaknessIconKeywords:Fraqueza> a todos os inimigos. Causar dano a inimigos fracos concede [DescArg1] de <PowerIconKeywords:Força> temporária, até 3 vezes por turno"
  },
  State_66558_Name = {Text = "Momo"},
  State_66559_Desc = {
    Text = "Ao jogar 1 carta com consumo de aritmética de 3 ou mais, puxe 1 carta e ganhe 1 de aritmética"
  },
  State_66559_Name = {
    Text = "Beleza perdida"
  },
  State_66560_Desc = {
    Text = "\"Ataque\" ganha 2 Aritmética e descarta 1 cartão aleatório; \"Defesa\" compra 2 cartões e perde 1 Aritmética. Pode ser ativado até 3 vezes por turno."
  },
  State_66560_Name = {
    Text = "Disco feliz"
  },
  State_66561_Desc = {
    Text = "A cada 3 turnos, adiciona 1 camada <VulnerabilityIconKeywords:vulnerável> a todos os inimigos. Após causar dano a inimigos <VulnerabilityIconKeywords:vulnerável>, eles perdem [DescArg1] pontos de <PowerIconKeywords:força> temporários, até 3 vezes por turno."
  },
  State_66561_Name = {
    Text = "O Sacrifício da Primavera"
  },
  State_66562_Desc = {
    Text = "A cada 4 rodadas, o dano recebido por todos os inimigos é dobrado nesta rodada, mas após liberar a explosão da loucura nesta rodada, sela todos os despertadores por 1 rodada"
  },
  State_66562_Name = {
    Text = "Restos do Viajante"
  },
  State_66563_Desc = {
    Text = "Ao iniciar a rodada, se o número de cartas jogadas no último turno exceder 3, compre 2 cartas"
  },
  State_66563_Name = {
    Text = "Carteira nova"
  },
  State_66564_Desc = {
    Text = "Ao coletar, ganhe 3 pontos de poder"
  },
  State_66564_Name = {
    Text = "Espelho de relógio de bolso"
  },
  State_66565_Desc = {
    Text = "Ao coletar, aplique a todos os inimigos 1 turno de <WeaknessIconKeywords:ilusão> e <VulnerabilityIconKeywords:vulnerável>"
  },
  State_66565_Name = {
    Text = "Traje de Restrição com Mudança de Cor"
  },
  State_66566_Desc = {
    Text = "No início de cada turno, <DeathResistanceIconKeywords:resistência à morte> aumenta em 10% (a resistência à morte ganha é reduzida pela metade a cada ativação nesta fase). Quando a <DeathResistanceIconKeywords:resistência à morte> está acima de 100%, <ProficientInRealmsIconKeywords:Domínio de área> aumenta em 100."
  },
  State_66566_Name = {
    Text = "Lágrima de sereia"
  },
  State_66703_Desc = {
    Text = "Único de Equipe: O limite de carga de Chave de Prata aumenta em 100%. Tamanho Máximo de Mão +2, não pode ser empilhado com outros limites de cartões da Roda do Destino. A regeneração de flare da chave do portador aumenta em <WeaponEffect_Num:[StateArg1]%>. Após jogar um cartão, a taxa de crítico, dano crítico, escudo, aliemus e efeitos de ganho de FORÇA do cartão de comando do portador aumentam em <WeaponEffect_Num:[StateArg2]%>, empilhando até 5 camadas."
  },
  State_66703_WeaponDesc = {
    Text = "O limite de acúmulo de s-energia aumenta em 100%. Limite de cartas na mão +2, não se acumula com outros limites de cartas fornecidos pela Roda do Destino. O carregamento da chave de prata do portador aumenta <WeaponEffect_Num:[DescArg2]>. Após o portador disparar uma carta, a taxa de crítico e o dano crítico das cartas de comando do portador, bem como o escudo, a fúria e a força causados, aumentam em <WeaponEffect_Num:[StateArg2]%>, podendo acumular até 5 camadas (atualmente [DescArg1] camadas)."
  },
  State_66722_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Ao equipar e no início do turno, se não houver <PVPProtectiveKeywords:Barreira>, obtenha [StateArg1] camadas de <PVPProtectiveKeywords:Barreira>; caso contrário, ganhe <StrengthenKeywords:Fortalecer>."
  },
  State_66722_Name = {
    Text = "Roda Invisível"
  },
  State_66872_Desc = {
    Text = "O dano, escudo e recuperação de vida causados por Tawil aumentam temporariamente em [StateArg1]%, por [Layer] turnos."
  },
  State_66872_Name = {
    Text = "Brilho Infinito de Bilhões"
  },
  State_66884_Desc = {
    Text = "Ao final da rodada, o custo de poder diminui, e ao ser descartado, este efeito ainda se ativa"
  },
  State_66884_Name = {
    Text = "<PrepareKeypvewords:preparar 1>"
  },
  State_66888_Desc = {
    Text = "Único na equipe: Após liberar a ordem de chave, ganhe <WeaponEffect_Num:[StateArg1]%> de <PowerIconKeywords:força> e <WeaponEffect_Num:[StateArg2]%> de escudo. Após usar o corpo de Gnosis de emergência, no final do turno todos os corpos despertos ganham <WeaponEffect_Num:[StateArg3]> pontos de fúria."
  },
  State_66888_Name = {
    Text = "Coração de Prata"
  },
  State_66888_WeaponDesc = {
    Text = "Após liberar a chave, ganhe <WeaponEffect_Num:[Power:DescArg1]> pontos de <PowerIconKeywords:força> e <WeaponEffect_Num:[Block:DescArg2]> pontos de escudo. Após usar o despertador de emergência, no final do turno todos os despertos ganham <WeaponEffect_Num:[StateArg3]> pontos de loucura."
  },
  State_66893_Desc = {
    Text = "Único na equipe: Após o início da batalha, ganhe energia de chave de prata equivalente a <WeaponEffect_Num:[StateArg1]%> da recarga do portador. Após liberar a chave pela primeira vez em cada batalha, repita esse efeito uma vez."
  },
  State_66893_WeaponDesc = {
    Text = "Após o início da batalha, ganhe <WeaponEffect_Num:[DescArg1]> pontos de s-energia. Após liberar a chave de bando pela primeira vez em cada batalha, repita esse efeito uma vez"
  },
  State_66896_WeaponDesc = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_66900_Desc = {
    Text = "Este cartão aumenta o dano, cura e escudo em [StateArg1]%"
  },
  State_66900_Name = {
    Text = "Coração de Prata"
  },
  State_66901_Desc = {
    Text = "O dano, cura e efeitos de escudo causados aumentam em [DescArg1]%, durando 1 turno"
  },
  State_66901_Name = {
    Text = "Eficácia temporária"
  },
  State_66902_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após a morte de um aliado Corpo Desperto, ganha <Block:[Block:StateArg1]> Escudo do personagem, compra a \"Habilidade\" com menor custo desse aliado."
  },
  State_66902_Name = {
    Text = "Coração de Prata"
  },
  State_66971_Desc = {
    Text = "Quando a vida cair para 0, fará a vida ser 1 ponto, e não sofrerá mais dano"
  },
  State_66971_Name = {
    Text = "Mundo cortado"
  },
  State_67234_Desc = {
    Text = "No final do turno, invoque um \"Clone de cérebro em um frasco\", durando [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_67234_Name = {
    Text = "separação"
  },
  State_67235_Desc = {
    Text = "Ao morrer, restaure toda a vida, aumente o limite de vida em 100%, libere \"praga espiritual\""
  },
  State_67235_Name = {
    Text = "Ainda não despertado"
  },
  State_67237_Desc = {
    Text = "Ao alcançar o nível 10, a intenção muda para \"finalidade ilusória\": reduz a vida máxima do oponente para 1"
  },
  State_67237_Name = {Text = "Fim"},
  State_67238_Desc = {
    Text = "Ao final da rodada, obtém 1 camada de \"Fim\". Após receber dano letal, remove este estado e se torna imune ao dano por 1 rodada, restaura 15% da vida e adquire 10 camadas de \"Fim\""
  },
  State_67238_Name = {
    Text = "Peste de almas"
  },
  State_67240_Desc = {
    Text = "\"O Sábio\" ganha 25 camadas de <ReinforcePVEKeywords:Reforçado> temporário e [Power:StateArg1] pontos de <PowerIconKeywords:Poder> temporário, removendo este estado."
  },
  State_67240_Name = {
    Text = "<TuiyanColour: Dedução>"
  },
  State_67241_Desc = {
    Text = "Ao morrer, restaure toda a vida, aumente o limite de vida em 100%, libere \"entusiasmo do cavaleiro\""
  },
  State_67241_Name = {
    Text = "Ainda não despertado"
  },
  State_67242_Desc = {
    Text = "Ao morrer, restaure toda a vida, aumente o limite de vida em 100%, libere \"espírito e carne @1 minuto\""
  },
  State_67242_Name = {
    Text = "Ainda não despertado"
  },
  State_67243_Desc = {
    Text = "No final do turno, invoque um clone \"Cérebro em um Frasco\". Quando o clone \"Cérebro em um Frasco\" ativa \"Separação da Essência\", ele rouba adicionalmente 5% da sua Força."
  },
  State_67243_Name = {
    Text = "espírito e carne@1 ponto"
  },
  State_67245_Desc = {
    Text = "Ao final da rodada, ganhe [StateArg1] pontos de <PowerIconKeywords:poder>"
  },
  State_67245_Name = {
    Text = "Ardor Cavaleiro"
  },
  State_67246_Desc = {
    Text = "Ao romper o escudo pela primeira vez em cada turno, perca 25% da vida máxima, ganhe [Power:DescArg1] pontos de <PowerIconKeywords:força temporária> e [Layer] camadas de reforço temporário. No início do próximo turno, recupere <Block:[Block:DescArg2]> camadas de escudo, ganhando um escudo extra a cada vez que \"Credo do Cavaleiro\" for acionado."
  },
  State_67246_Name = {
    Text = "Credo do Cavaleiro"
  },
  State_67247_Desc = {
    Text = "Ao final de cada turno, reforça inimigos, com no máximo 2 inimigos simultaneamente. Após a morte de um inimigo, \"cérebro em decomposição\" perde 5% da saúde máxima"
  },
  State_67247_Name = {
    Text = "Porta dos Abismos"
  },
  State_67252_Desc = {
    Text = "Ao receber dano fatal, mova-se para a linha de trás e mantenha 1 ponto de vida, depois não poderá receber mais danos. <PowerIconKeywords:poder> aumenta [DescArg1]. O autoexplosão não ativará este efeito"
  },
  State_67252_Name = {
    Text = "Separação de essência"
  },
  State_67253_Desc = {
    Text = "Após jogar [Layer] cartas, gere 1 \"cérebro em um frasco\" à frente, com no máximo 3 cópias ao mesmo tempo"
  },
  State_67253_Name = {
    Text = "Cérebro em um Tanque"
  },
  State_67255_Desc = {
    Text = "Ao morrer, restaure toda a vida, aumente o limite de vida em 100%, libere \"primeira filosofia\""
  },
  State_67255_Name = {
    Text = "Ainda não despertado"
  },
  State_67256_Desc = {
    Text = "Após a fase de puxar, exiba aleatoriamente três cartas de comando da mão, escolha uma para conceder a marca \"Eco\" e descarte as outras cartas"
  },
  State_67256_Name = {
    Text = "Primeira filosofia"
  },
  State_67257_Desc = {
    Text = "A primeira vez em cada turno que um bando é liberado, todos os despertadores ganham 10 aliemus, mas o custo da liberação aumenta permanentemente em 10%"
  },
  State_67257_Name = {
    Text = "Link Gradualmente Quebrando"
  },
  State_67258_Desc = {
    Text = "Ao início da batalha, ganha <Block:[Block:DescArg1]> camadas de escudo. O escudo não desaparecerá ao final do turno"
  },
  State_67258_Name = {
    Text = "Resolução do Cavaleiro"
  },
  State_67347_Desc = {
    Text = "Enquanto estiver na mão, se a carta do topo do baralho for uma carta de comando, transforma-se em uma cópia com custo de aritmética -1"
  },
  State_67347_Name = {
    Text = "Compreender os Princípios de Tudo"
  },
  State_67353_Desc = {
    Text = "Após a morte, o \"cérebro em decomposição\" perde 5% da vida máxima"
  },
  State_67353_Name = {Text = "Fusão"},
  State_67358_Desc = {
    Text = "Sempre que o jogador consome 1 ponto de aritmética, recebe imediatamente <Block:[Block:StateArg1]> pontos de escudo e 3 camadas de reforçado temporário"
  },
  State_67358_Name = {
    Text = "Barreira indeterminada"
  },
  State_67414_Desc = {
    Text = "Olhos que não podem ser encarados. A aura que não pode ser desobedecida. As fragmentos do feito tudo são apenas fragmentos. Agora, prepare-se para o destino de destruição"
  },
  State_67414_Name = {
    Text = "Enfrente milhares de Origens"
  },
  State_67418_Desc = {
    Text = "Jogue e então descarte todas as outras cartas, exceto por este despertador, ganhando 5 cartas aleatórias que não são despertadores; isso só tem efeito uma vez por batalha."
  },
  State_67418_Name = {
    Text = "<WhiteQuality:teoria da alegre prazer>"
  },
  State_67419_Desc = {
    Text = "Após jogar, ganhe 3 cópias base com <RetainIconKeywords:retain> e <DepleteIconKeywords:exhaust> e reduza seu custo de Aritmética em 1, tendo efeito apenas uma vez por batalha."
  },
  State_67419_Name = {
    Text = "<WhiteQuality:teoria da alegre reprodução>"
  },
  State_67420_Desc = {
    Text = "Após jogar, compre 4 cartões e reduza seu custo de Aritmética pelo custo real de Aritmética do cartão de Oração, tendo efeito apenas uma vez por batalha."
  },
  State_67420_Name = {
    Text = "<WhiteQuality:Adv. Lex Nous>"
  },
  State_67598_Desc = {
    Text = "Após liberar a exaltação, coloque uma carta aleatória correspondente ao despertador nas mãos, que ganha <DepleteIconKeywords:exausto> e <NothingnessIconKeywords:ilusão>. Após o combate, recupere [DescArg1] pontos de vida"
  },
  State_67598_Name = {
    Text = "mala do médico"
  },
  State_67599_Desc = {
    Text = "Após jogar uma Carta de comando que não seja \"Golpear\" ou \"Defesa\", o Corpo Desperto correspondente ganha 15 de Fúria, sendo possível acionar no máximo 5 vezes por turno. Na primeira ativação de cada turno, a carta jogada retorna à sua mão."
  },
  State_67599_Name = {
    Text = "Pêndulo Temporal·Projétil"
  },
  State_67600_Desc = {
    Text = "A saúde máxima aumenta em 4. A cada vez que o baralho for resetado, adicione 4 <DerivativeCardKeywords_4:\"Inspiração\"> ao baralho de puxar"
  },
  State_67600_Name = {
    Text = "Bendito·Vela preta"
  },
  State_67602_Name = {Text = "Deprecated"},
  State_67603_Desc = {
    Text = "Dano aumentado em 20% contra inimigos com status negativo, ao matar um inimigo, o assassino ganha 20 de loucura"
  },
  State_67603_Name = {
    Text = "Cajado de sacerdote"
  },
  State_67604_Desc = {
    Text = "Cada carta de comando jogada que pertença a um Despertar diferente da anterior faz com que o Despertar correspondente ganhe 3 pontos de Fúria e acumule 1 camada de \"Vitalidade\". Ao acumular 10 camadas, todas as \"Vitalidades\" são limpadas, e uma carta de comando aleatória com custo de poder de cálculo reduzido em 1 e com \"Consumo\" é colocada na mão de cada Despertar, podendo ser eficaz no máximo 1 vez por turno."
  },
  State_67604_Name = {
    Text = "Pêndulo Temporal·Derivação"
  },
  State_67605_Desc = {
    Text = "Quando você possui um escudo, essa relíquia fornece [DescArg1] pontos de <PowerIconKeywords:força> temporária. Quando seu escudo está acima da vida atual, ele fornece adicionalmente [DescArg2] pontos de <PowerIconKeywords:força> temporária"
  },
  State_67605_Name = {
    Text = "Abanico de penas de pomba"
  },
  State_67606_Desc = {
    Text = "Ao iniciar a rodada, ganhe 1 aritmética para cada inimigo presente. Ao matar um inimigo com dano ativo, cause <BleedingIconKeywords:sangrando> equivalente ao excesso de dano a outros inimigos"
  },
  State_67606_Name = {
    Text = "Canto da Multidão"
  },
  State_67607_Desc = {
    Text = "Após liberar 5 explosões de loucura, o despertador que liberou a explosão de loucura ganha 100 de loucura"
  },
  State_67607_Name = {
    Text = "Pequeno envoltório"
  },
  State_67608_Name = {Text = "Deprecated"},
  State_67609_Desc = {
    Text = "Após liberar a exaltação, perca 8% da vida atual, roube [DescArg1] pontos de <PowerIconKeywords:poder> temporários de todos os inimigos; se houver apenas 1 inimigo, roube [DescArg2] pontos adicionais de <PowerIconKeywords:poder> temporários"
  },
  State_67609_Name = {
    Text = "Pássaro do Ritual de Azar"
  },
  State_67611_Desc = {
    Text = "A cada 2 turnos, o dano recebido por todos os inimigos dobra, neste turno cada vez que um êxtase for liberado, dissipa aleatoriamente 1 efeito negativo"
  },
  State_67611_Name = {
    Text = "Abençoado · Caminho dos Ossos"
  },
  State_67612_Desc = {
    Text = "Todo dano causado por \"golpes\" aumenta o dano crítico em 20%. Ao pegar, adicione 1 <DerivativeCardKeywords_40: \"Momento de Beleza\"> à mão"
  },
  State_67612_Name = {
    Text = "Momentos bonitos β"
  },
  State_67614_Desc = {
    Text = "No início de cada rodada, todos os despertadores ganham 25 loucura. Ao coletar, a saúde máxima se torna 1,5 vezes"
  },
  State_67614_Name = {
    Text = "Bênção·aparência de pesadelo β"
  },
  State_67615_Desc = {
    Text = "A cada 6ª carta de comando jogada, ela retorna da pilha de descarte para a mão"
  },
  State_67615_Name = {
    Text = "No crepúsculo"
  },
  State_67616_Name = {Text = "Deprecated"},
  State_67618_Desc = {
    Text = "No início de cada rodada, todos os despertadores ganham 25 loucura. Ao coletar, a saúde máxima se torna 1,5 vezes"
  },
  State_67619_Desc = {
    Text = "Limite de cartas na mão aumenta em 5. Ao pegar, preencha a mão até o limite. No início do turno, puxe 1 carta extra, e no final do turno, descarte todas as cartas de sintoma e estado na mão, mantendo as outras cartas"
  },
  State_67619_Name = {
    Text = "Bênção·impressão de consciência β"
  },
  State_67620_Desc = {
    Text = "Após jogar a terceira carta de cada rodada, coloque 1 <DerivativeCardKeywords_4:\"inspiração\"> no monte de descarte. Após jogar a sexta carta de cada rodada, mova 1 <DerivativeCardKeywords_4:\"inspiração\"> do monte de descarte para a mão"
  },
  State_67620_Name = {
    Text = "Luz da civilização"
  },
  State_67621_Desc = {
    Text = "Após liberar a exaltação, ganhe [DescArg1] pontos de poder temporários e roube [DescArg1] pontos de <PowerIconKeywords:poder> temporários de todos os inimigos; se houver apenas 1 inimigo, roube [DescArg2] pontos adicionais de <PowerIconKeywords:poder> temporários"
  },
  State_67621_Name = {
    Text = "Bênção·pássaro do ritual do infortúnio"
  },
  State_67622_Desc = {
    Text = "Ao esgotar o último ponto de poder, ganha 2 de poder. Pode ser acionado até 2 vezes por rodada"
  },
  State_67622_Name = {
    Text = "Diferenciador Prata-Branco"
  },
  State_67623_Desc = {
    Text = "Ao pegar, ganha permanentemente [DescArg1] <PowerIconKeywords:poder>. Sempre que causar dano, recupera [DescArg2] pontos de vida, podendo ativar no máximo 6 vezes por turno"
  },
  State_67623_Name = {
    Text = "Bênção·beijo da lampreia"
  },
  State_67624_Name = {Text = "Deprecated"},
  State_67625_Desc = {
    Text = "Ao jogar pela primeira vez uma carta de comando em cada turno e colocá-la na pilha de descarte, reduz o custo de aritmética da carta em 1, temporariamente copiando-a e embaralhando-a na pilha de puxar"
  },
  State_67625_Name = {
    Text = "Tocadiscos mudo"
  },
  State_67626_Desc = {
    Text = "A saúde máxima aumenta em 1. Quando jogar 2 cartas com custo de aritmética superior à da carta anterior, ganha 1 aritmética"
  },
  State_67626_Name = {
    Text = "Registro de Alcana"
  },
  State_67628_Name = {Text = "Deprecated"},
  State_67630_Name = {Text = "Deprecated"},
  State_67631_Desc = {
    Text = "A saúde máxima aumenta em 2. A cada vez que o baralho for resetado, adicione 1 <DerivativeCardKeywords_9:\"Tropeço\"> ao baralho de puxar"
  },
  State_67631_Name = {Text = "Vela preta"},
  State_67632_Name = {Text = "Deprecated"},
  State_67634_Desc = {
    Text = "No final do turno, para cada cartão não jogado na mão, todos os despertadores ganham 2 de loucura"
  },
  State_67634_Name = {
    Text = "Balança Desequilibrada"
  },
  State_67635_Desc = {
    Text = "Quando pegado, todos os Despertadores ganham 50 pontos de Aliemus e embaralhe 2 <DerivativeCardKeywords_1:\"Ethereal Echo\"> no monte de compra."
  },
  State_67635_Name = {
    Text = "Equipamento de Comunicação +β"
  },
  State_67636_Desc = {
    Text = "Dano Crítico +15%. Dano contra inimigos com escudo será sempre crítico"
  },
  State_67636_Name = {
    Text = "Princípios estéticos"
  },
  State_67637_Desc = {
    Text = "Ao iniciar a rodada, compre 2 cartas e ganhe 2 pontos de aritmética. Sempre que você comprar uma carta de comando ou despertar de gnose, altere aleatoriamente seu custo de aritmética (0-4)"
  },
  State_67637_Name = {
    Text = "Chapéu de Mágico"
  },
  State_67638_Desc = {
    Text = "Dano aumentado em 50% contra inimigos em estado negativo, e o executor ganha 100 de loucura ao matar um inimigo"
  },
  State_67638_Name = {
    Text = "Cajado de sacerdote+"
  },
  State_67639_Desc = {
    Text = "Taxa crítica aumenta em 50%, e o dano crítico aumenta em 100%"
  },
  State_67639_Name = {
    Text = "Bênção·garra estranha"
  },
  State_67640_Desc = {
    Text = "Taxa crítica e dano crítico aumentados em 100%. Cada vez que causar 1 dano/dano de tentáculo neste turno: a taxa crítica e dano crítico de todos os despertadores diminuem em 10%, até um máximo de 50%. O veneno e a retaliação causados aumentam em 10%, podendo aumentar até 50%"
  },
  State_67640_Name = {
    Text = "Pêndulo Temporal·Shift Surge"
  },
  State_67641_Desc = {
    Text = "Após liberar a exaltação, ganhe [DescArg1] pontos de <PowerIconKeywords:poder> temporários"
  },
  State_67641_Name = {
    Text = "Trava pesada"
  },
  State_67643_Desc = {
    Text = "Causa dano ativo e ganha [DescArg1] de escudo. Ao recuperar vida, ganha [DescArg2] de poder temporário <PowerIconKeywords:poder>"
  },
  State_67643_Name = {Text = "Nossa casa"},
  State_67645_Desc = {
    Text = "Taxa crítica aumenta em 10%. Após o primeiro crítico de cada rodada, aumenta a taxa crítica em mais 20%; após o terceiro crítico causado na rodada, aumenta o dano crítico em mais 50%"
  },
  State_67645_Name = {
    Text = "Saudações festivas"
  },
  State_67646_Desc = {
    Text = "No final dos turnos ímpares, se houver aritmética restante, puxe 2 cartas extras na próxima rodada; no final dos turnos pares, se houver cartas restantes, ganhe 2 aritméticas extras na próxima rodada"
  },
  State_67646_Name = {
    Text = "Roda do Sol e da Lua"
  },
  State_67647_Desc = {
    Text = "A cada 5ª carta de comando jogada, ela terá efeito 2 vezes e retornará à sua mão"
  },
  State_67647_Name = {
    Text = "Vinho das Estrelas+"
  },
  State_67649_Desc = {
    Text = "Intenção oculta do monstro. A cada turno, ganha-se 1 ponto de aritmética e compra-se 1 cartão"
  },
  State_67649_Name = {
    Text = "Campana Encantadora"
  },
  State_67650_Desc = {
    Text = "\"Ataque\" e \"Defesa\" ganham um adicional de 50 Keyflare. Cada vez que você jogar uma carta com um custo de Aritmética de 2 ou mais, compre uma carta com custo de Aritmética de 1 e reduza seu custo para 0, até 3 vezes por turno."
  },
  State_67650_Name = {
    Text = "Pêndulo Temporal·Gêmeos"
  },
  State_67651_Desc = {
    Text = "Ao pegar, a maestria do domínio da equipe aumenta para 150% do valor original. Após jogar a 5ª carta de comando em cada turno, todos os despertos ganham 20 de loucura"
  },
  State_67651_Name = {
    Text = "Pêndulo Temporal·Impuro"
  },
  State_67653_Desc = {
    Text = "Após liberar a explosão de loucura 2 vezes em cada turno, todos os despertadores ganham 8 de loucura. Após 3 liberações, todos os despertadores ganham mais 8 de loucura"
  },
  State_67653_Name = {
    Text = "Sangue dos Esquecidos"
  },
  State_67654_Name = {
    Text = "Ativa [DescArg1] vezes adicionais"
  },
  State_67656_Desc = {
    Text = "Taxa crítica aumenta em 50%, <FragileIconKeywords:frágil> aplica-se a si mesmo por 3 rodadas"
  },
  State_67656_Name = {
    Text = "Garra estranha"
  },
  State_67657_Desc = {
    Text = "Ao iniciar a rodada, compre 1 carta. Ao jogar 2 cartas consecutivas com o mesmo custo de aritmética da última carta, compre 1 carta extra, com um máximo de 3 vezes por rodada"
  },
  State_67657_Name = {
    Text = "Ritual de Gnosis Omnisciente"
  },
  State_67658_Desc = {
    Text = "Ao jogar 1 carta com custo de aritmética real de 3, puxe 1 carta e ganhe 2 de aritmética; ao jogar 1 carta com custo de aritmética real de 4 ou mais, o consumo de aritmética de outras cartas na mão diminui em 1"
  },
  State_67658_Name = {
    Text = "Pêndulo Temporal·Olho"
  },
  State_67659_Desc = {
    Text = "Ao iniciar a rodada, ganhe 2 aritmética para cada inimigo presente. Ao matar um inimigo com dano ativo, cause <BleedingIconKeywords:sangrando> equivalente ao dobro do excesso de dano a outros inimigos"
  },
  State_67659_Name = {
    Text = "Canto da Multidão+"
  },
  State_67660_Desc = {
    Text = "A cada 3ª vez que jogar \"Impacto\", cause [DescArg1] pontos de dano a todos os inimigos, e o despertar correspondente ganha 15 aliemus"
  },
  State_67660_Name = {
    Text = "Lâmina de Folha de Salgueiro Enferrujada"
  },
  State_67661_Desc = {
    Text = "Cada vez que consumir aritmética, compre 1 carta, ativa no máximo 5 vezes por turno. Cada vez que o baralho for resetado, receba 2 pontos de aritmética"
  },
  State_67661_Name = {
    Text = "Pêndulo Temporal·Insônia"
  },
  State_67662_Desc = {
    Text = "Sempre que você jogar uma carta que não seja de despertador, o despertador com a menor loucura ganha 10 de loucura"
  },
  State_67662_Name = {
    Text = "Álbum de Selos Exóticos"
  },
  State_67665_Desc = {
    Text = "A saúde máxima aumenta em 2. Após jogar \"Golpe\" ou \"Defesa\", o despertador correspondente ganha 5 pontos de aliemus. Após liberar aliemus, ganhe 1 \"Golpe\" que consome ilusão anexada ao despertador correspondente, após liberar o bando, ganhe aleatoriamente 1 \"Defesa\" que consome ilusão"
  },
  State_67665_Name = {
    Text = "Pêndulo Temporal·Asa"
  },
  State_67666_Desc = {
    Text = "A cada vez que causar dano, receba [DescArg1] pontos de <PowerIconKeywords:poder> temporário, acumulando até 3 vezes. Quando as camadas estiverem completas, o efeito é duplicado"
  },
  State_67666_Name = {
    Text = "Ágata Enrolada"
  },
  State_67667_Desc = {
    Text = "Após o final do turno, todos os despertadores ganham 5 de exaltação. Para cada 1 ponto de aritmética restante, todos os despertadores ganham 3 de exaltação adicionais"
  },
  State_67667_Name = {
    Text = "Bateria protótipo"
  },
  State_67668_Desc = {
    Text = "Dano crítico aumentado em 15%. A taxa crítica de \"golpe\" aumenta em 40%"
  },
  State_67668_Name = {
    Text = "Bico de corvo branco"
  },
  State_67669_Name = {Text = "Deprecated"},
  State_67670_Desc = {
    Text = "Após liberar a exaltação, compre 1 cartão. Se a vida estiver abaixo de 25%, compre um cartão adicional"
  },
  State_67670_Name = {
    Text = "Ciclo de Leitura para o Conhecimento"
  },
  State_67671_Desc = {
    Text = "A cada vez que causar dano ativo, recupere [DescArg1] vida e aplique [DescArg2] camadas de <BleedingIconKeywords:sangrando> ao alvo do dano"
  },
  State_67671_Name = {
    Text = "Bênção·consciência de enxame"
  },
  State_67672_Desc = {
    Text = "O efeito de <WeaknessIconKeywords:fraqueza> causado aumenta em 8%, o efeito de <VulnerabilityIconKeywords:vulnerável> aumenta em 25%. Ao aplicar <WeaknessIconKeywords:fraqueza> ou <VulnerabilityIconKeywords:vulnerável>, roube temporariamente [DescArg1] de <PowerIconKeywords:poder> do alvo"
  },
  State_67672_Name = {
    Text = "Foto desbotada+"
  },
  State_67673_Desc = {
    Text = "Compre 1 carta no início do turno"
  },
  State_67673_Name = {
    Text = "Bússola de orientação"
  },
  State_67674_Desc = {
    Text = "Cada vez que disparar 1 carta de comando, ganha [DescArg2]% de <DeathResistanceIconKeywords:resistência à morte> (a resistência à morte ganha é reduzida pela metade a cada ativação nesta fase). Se a sua <DeathResistanceIconKeywords:resistência à morte> for maior ou igual a 100%, passa a ganhar [DescArg1] pontos de <PowerIconKeywords:força> temporária."
  },
  State_67674_Name = {
    Text = "Restos da pele da serpente mutante"
  },
  State_67675_Desc = {
    Text = "No final do turno, se houver aritmética restante, na próxima rodada, compre 2 cartas extras; se houver cartas restantes, na próxima rodada, ganhe 2 pontos extras de aritmética"
  },
  State_67675_Name = {
    Text = "Roda do Sol e da Lua+"
  },
  State_67677_Desc = {
    Text = "Ao causar <WeaknessIconKeywords:fraqueza>, você ganha [DescArg1] pontos de escudo; ao causar <VulnerabilityIconKeywords:vulnerável>, você ganha [DescArg2] pontos de <PowerIconKeywords:força> temporária. Se esses dois efeitos forem ativados dentro de 1 turno, você ganhará um adicional de [DescArg1] pontos de escudo e [DescArg2] pontos de <PowerIconKeywords:força> temporária."
  },
  State_67677_Name = {
    Text = "quadro pesado"
  },
  State_67703_Desc = {
    Text = "Ao iniciar a rodada, se o número de cartas restantes do último turno exceder 3, ganhe 2 aritméticas"
  },
  State_67703_Name = {
    Text = "Emblema de Mythag"
  },
  State_67704_Desc = {
    Text = "Após liberar a exaltação, o despertador correspondente ganha 10 de aliemus e [DescArg1] pontos de escudo"
  },
  State_67704_Name = {
    Text = "Véu do Deus Sem Nome"
  },
  State_67796_Name = {
    Text = "<TongxiaoKeywords:Compreensão do Princípio de Tudo>: Ao ser usado, restaurar e ganhar <Energy:[StateArg1]> pontos de loucura"
  },
  State_67841_WeaponDesc = {
    Text = "Mude o custo das cartas antes de jogar"
  },
  State_67844_Desc = {
    Text = "Recupera toda a vida ao receber dano fatal, pode ser ativado @1 vez, já foi ativado [DescArg1] vezes"
  },
  State_67844_Name = {
    Text = "Caos Antigo"
  },
  State_67866_Name = {
    Text = "<BleedingColour:sangrando>"
  },
  State_68298_Desc = {
    Text = "Após receber dano fatal, transforme a intenção em \"Olhar do Espaço Profundo\" e ganhe 80 camadas de reforçado temporário, recupere toda a vida, pode ser ativado [DescArg1] vezes. Ao final do turno, remova 20 camadas de reforçado."
  },
  State_68298_Name = {
    Text = "Poeira de estrelas"
  },
  State_68554_Desc = {
    Text = "Após receber dano fatal, recupera toda a vida; remove este estado quando todos os outros inimigos estiverem mortos. Pode ser ativado @1 vez, já foi ativado [DescArg1] vezes."
  },
  State_68554_Name = {
    Text = "Fragmentos de Caos Antigo"
  },
  State_68621_Desc = {
    Text = "Ao início do combate e ao fim de cada rodada, obtém 2 camadas de <ResentChainsKeywords:Cadeia de Rancor> Temporária."
  },
  State_68621_Name = {
    Text = "Corrente Sinistra"
  },
  State_68622_Desc = {
    Text = "O efeito de <PowerIconKeywords:força> aplicado pelo corpo despertado é reduzido em 75%. Sempre que perder vida, ganhe <Block:[Block:DescArg1]> pontos de escudo e 1 camada de reforço temporário."
  },
  State_68622_Name = {
    Text = "Fluxo da Maldade"
  },
  State_68623_Desc = {
    Text = "Cada vez que jogar 1 carta de comando, descarte 1 carta desse despertador com o menor custo de aritmética."
  },
  State_68623_Name = {
    Text = "Fluxo da Loucura"
  },
  State_68624_Desc = {
    Text = "No final do turno, recupera 10% da vida perdida e remove os próprios estados negativos e os estados positivos do jogador."
  },
  State_68624_Name = {
    Text = "Corrente da Chegada"
  },
  State_68626_Desc = {
    Text = "O Aliemus Base de todos os Corpos Despertos aumenta em 50%. No final de cada turno, todos os Corpos Despertos perdem 10 de Fúria e recuperam 3% da própria Vida máxima."
  },
  State_68626_Name = {
    Text = "Fluxo do Terror"
  },
  State_68627_Desc = {
    Text = "No início da batalha, ganhe 15 camadas de \"barreira temporária\". No final do turno, ganhe 15 camadas de \"barreira temporária\" e adicione \"dissolução temporária\" a 10 cartas aleatórias."
  },
  State_68627_Name = {
    Text = "Corrente Gélida"
  },
  State_68632_Desc = {
    Text = "O custo aritmético de todas as cartas de comando aumenta em 1. A cada 3 turnos, ao final do turno, coloque 1 carta de \"petrificação gradual\" na sua mão."
  },
  State_68632_Name = {
    Text = "Torrente de Lamentos"
  },
  State_68635_Name = {
    Text = "Núcleo de Prata Pura· Medo"
  },
  State_68637_Desc = {
    Text = "Ao perder vida, reduza o número correspondente de camadas. Ao zerar, o jogador ganha 2 camadas de barreira temporária, você ganha [DescArg1] camadas de escudo e [DescArg2] camadas de reforço temporário, e recupera [DescArg3] camadas de Barreira Dimensional."
  },
  State_68637_Name = {
    Text = "Barreira dimensional"
  },
  State_68638_Name = {
    Text = "Núcleo de Prata Pura· Herege"
  },
  State_68646_Desc = {
    Text = "O dano base e o valor do escudo aumentam em 200%, mas são consumidos após serem jogados."
  },
  State_68646_Name = {
    Text = "<RedQuality1:Dissolução Temporária>"
  },
  State_68647_Name = {
    Text = "\"Núcleo de Som Puro · Loucura\""
  },
  State_68680_Desc = {
    Text = "Remover Fragmentos Antigos"
  },
  State_68680_Name = {
    Text = "Remover Fragmentos Antigos"
  },
  State_68704_Desc = {
    Text = "Restam [DescArg1] rodadas para a verdadeira chegada de Tohuwabohu..."
  },
  State_68704_Name = {Text = "Chegada"},
  State_68829_Desc = {
    Text = "Ao receber Dano ativo ou Dano de tentáculo, torna-se imune ao dano e perde 1 carga. Removido no início do turno."
  },
  State_68829_Name = {
    Text = "<ParcloseColour:Barreira Temporária>"
  },
  State_68829_WeaponDesc = {
    Text = "Dano recebido -99%. Cada vez que Dano é recebido, perde 1 capa."
  },
  State_70026_Desc = {
    Text = "Esta carta possui \"retenção\". Após ser jogada, a taxa crítica temporária de todos os despertadores aumenta em [StateArg1]% e remove \"domínio imutável\". Se o campo atual for Mar Profundo, após remover \"domínio imutável\", ganhe 1 ponto de aritmética."
  },
  State_70026_Name = {
    Text = "<OrangeQuality:Domínio Imortal>"
  },
  State_70031_Desc = {
    Text = "Equipe Única: Ao começar a batalha, conceda ao baralho de compra todas as cartas de comando do portador com consumo de potência de cálculo maior ou igual a 3 o efeito \"Domínio Imortal\": Esta carta possui \"Preservar\", após ser disparada, a taxa de crítico temporária de todos os corpos despertos aumenta em <WeaponEffect_Num:[StateArg1]%> e remove \"Domínio Imortal\". Se o domínio atual for Mar Profundo, após remover \"Domínio Imortal\", ganhe 1 ponto de poder de cálculo."
  },
  State_70031_WeaponDesc = {
    Text = "Ao início da batalha, conceda ao baralho de puxar o efeito \"Domínio Imortal\" de todas as cartas de comando do portador com custo de aritmética maior ou igual a 3: esta carta possui \"preservar\", após ser disparada, a taxa de crítico temporária de todos os corpos despertos aumenta em <WeaponEffect_Num:[StateArg1]%> e remove \"Domínio Imortal\". Se o campo atual for Mar Profundo, após remover \"Domínio Imortal\", ganhe 1 ponto de poder de cálculo."
  },
  State_70182_Desc = {
    Text = "Todos os escudos obtidos são reduzidos em [DescArg1]%"
  },
  State_70182_Name = {
    Text = "<FragileColour:Frágil>"
  },
  State_70182_WeaponDesc = {
    Text = "Todos os escudos obtidos são reduzidos em 33%"
  },
  State_70277_Desc = {
    Text = "Ao receber Dano ativo ou Dano de tentáculo, [StateArg1]% do dano será convertido em quantidade de recuperação para o Forno Carmesim, durando [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_70277_Name = {
    Text = "Rito de Criação"
  },
  State_70287_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No final do turno, aumenta em [StateArg1]% o Dano, Recuperar e Escudo das cartas de \"habilidade\" do Portador na sua mão."
  },
  State_70287_Name = {
    Text = "Trono de Pedra Azul"
  },
  State_70288_Desc = {
    Text = "O dano, cura e escudo causados por esta carta aumentam em [DescArg1]%."
  },
  State_70288_Name = {
    Text = "Trono de Pedra Azul"
  },
  State_70313_Desc = {
    Text = "Na batalha contra o chefe, no início do turno e após a \"Doll em Fusão\" liberar a exaltação, ganhe 1 camada de \"<Zhongmowuqiling:Fim>\". \"Fim\" pode ter no máximo 10 camadas e, ao alcançar 10 camadas, adicione 1 carta de \"Fim do Vazio\" à sua mão."
  },
  State_70313_Name = {
    Text = "Caminho da Aniquilação"
  },
  State_70318_Desc = {
    Text = "Inflige [StateArg1] <plural value=\"[StateArg1]\" singular=\"turno\" plural=\"turnos\"> de <VulnerabilityIconKeywords:Vulnerável> a todos os inimigos, obtém 1 turno do estado \"Empolgação\": Dano potencializado da equipe +[StateArg2]%."
  },
  State_70318_Name = {
    Text = "Empolgação"
  },
  State_70322_Desc = {
    Text = "Ao possuir 10 camadas de Fim, coloque 1 carta de \"Fim da Ilusão\" na sua mão."
  },
  State_70322_Name = {Text = "Fim"},
  State_70330_Desc = {
    Text = "Obtém 1 turno do estado \"Empolgação\": Dano potencializado da equipe aumentado em [Arg2]%."
  },
  State_70330_Name = {
    Text = "Empolgação"
  },
  State_70346_Desc = {
    Text = "Aplica [StateArg1] turnos de <WeaknessIconKeywords:fraqueza> a todos os inimigos e reduz [Exhaustion:StateArg3] pontos de <PowerIconKeywords:força> deles neste turno."
  },
  State_70346_Name = {Text = "maldição"},
  State_70347_Desc = {
    Text = "Faça com que todos os inimigos reduzam [Exhaustion:StateArg3] pontos de <PowerIconKeywords:força> neste turno."
  },
  State_70347_Name = {Text = "maldição"},
  State_70374_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: Nas primeiras [StateArg1] vezes por turno que o Portador receber um ATQ, causa <PVPEmptinessKeywords:Vazio> ao atacante."
  },
  State_70374_Name = {
    Text = "Modelo Anatômico do Esquecimento"
  },
  State_70379_Desc = {
    Text = "Causa <PVPEmptinessKeywords:Vazio> ao atacante. Remove este Estado após receber um ataque."
  },
  State_70379_Name = {
    Text = "Contrataque do Vazio"
  },
  State_70443_Desc = {
    Text = "Ao possuir 10 camadas de Fim, coloque 1 carta de \"Fim da Ilusão\" na sua mão."
  },
  State_70443_Name = {Text = "Fim"},
  State_70539_Name = {
    Text = "Peste de almas"
  },
  State_70589_Desc = {
    Text = "Ao ativar 2 cartas consecutivas com um custo de aritmética menor do que a carta anterior, aplique 40/80 de veneno a todos os inimigos, podendo ser acionado no máximo 5 vezes por turno."
  },
  State_70590_Desc = {
    Text = "Após usar diretamente o embrião pela primeira vez em cada turno, o dano ativo causará sangramento equivalente a 15/30% do dano neste turno."
  },
  State_70593_Desc = {
    Text = "Após jogar uma carta de comando não derivada, embaralhe 1/2 cópia temporária dessa carta com custo de aritmética reduzido em 2 no baralho de compra, com tempo de recarga de 3 turnos."
  },
  State_70594_Desc = {
    Text = "No final do turno, se estiver na postura \"Maré Alta\", ganhe 32/64 de dano de tentáculo, com tempo de recarga de 3 turnos."
  },
  State_70595_Desc = {
    Text = "No início da batalha, aplique 1280 níveis de veneno a todos os inimigos, o efeito é dobrado em batalhas contra chefes."
  },
  State_70598_Desc = {
    Text = "Sempre que uma carta entra no espaço ultra, se esta carta pertence a um proprietário diferente das outras cartas no espaço ultra, coloque 1/2 carta de inspiração na mão."
  },
  State_70600_Desc = {
    Text = "No fim do turno, recupera 32 pontos de vida."
  },
  State_70600_Name = {
    Text = "Sangue Bendito"
  },
  State_70602_Desc = {
    Text = "Após usar o Despertar da chave de prata, compre 4 cartas."
  },
  State_70603_Desc = {
    Text = "Após usar o Despertar com a chave de prata, todos os despertos ganham 10 pontos de loucura."
  },
  State_70605_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, ganhe 32 pontos de força."
  },
  State_70607_Desc = {
    Text = "Ao ativar 2 cartas consecutivamente com um custo de aritmética maior do que a carta anterior, ganhe 24/48 de retaliação, podendo ser acionado no máximo 5 vezes por turno."
  },
  State_70609_Desc = {
    Text = "Após usar o Despertar da chave de prata, ganhe 96 pontos de escudo."
  },
  State_70609_Name = {
    Text = "Especime de borboleta"
  },
  State_70611_Desc = {
    Text = "Após usar o Despertar da chave de prata, aumente o dano base causado por todos os despertadores em 25%/50%."
  },
  State_70614_Name = {
    Text = "Mandíbula de Laser+"
  },
  State_70617_Desc = {
    Text = "Os primeiros cinco danos causados em cada turno são aumentados em 15%/30%."
  },
  State_70618_Desc = {
    Text = "Compre 1 carta no início do turno"
  },
  State_70619_Desc = {
    Text = "\"Golpe\" causa veneno equivalente a 10%/20% do dano, no máximo 320/640 pontos por turno."
  },
  State_70620_Desc = {
    Text = "Quando atacado pelo inimigo, cause 1 vez de dano fixo equivalente a 25%/50% da saúde máxima do nosso lado, esse dano recebe um bônus de 100%/200% de contrataque, podendo ser ativado no máximo 1 vez por inimigo por rodada."
  },
  State_70620_Name = {
    Text = "Adaga do Ritual"
  },
  State_70621_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, ganhe 192 pontos de escudo."
  },
  State_70621_Name = {
    Text = "Espécime de borboleta+"
  },
  State_70623_Desc = {
    Text = "No início de cada turno, todos os despertos ganham 10 de loucura"
  },
  State_70624_Desc = {
    Text = "Após usar o Despertar com a Chave de Prata, todos os despertadores ganham 20 pontos de loucura."
  },
  State_70628_Desc = {
    Text = "No início do turno, compre 2 cartas."
  },
  State_70629_Desc = {
    Text = "No primeiro devorar de cada rodada, outros Despertados ganham 10/20 de loucura."
  },
  State_70635_Desc = {
    Text = "使用银钥觉醒后获得 416 反击点数。"
  },
  State_70636_Desc = {
    Text = "Perder vida para obter 10%/20% da quantidade de vida perdida na fornalha carmesim."
  },
  State_70637_Desc = {
    Text = "No início da batalha, limite de tentáculos aumentado em 1/2, ganhe 1/2 tentáculo."
  },
  State_70641_Desc = {
    Text = "Aniquilação: obtenha 160/320 escudos, tempo de recarga de 3 turnos."
  },
  State_70641_Name = {
    Text = "Relógio de Hipercorda"
  },
  State_70643_Desc = {
    Text = "Ao iniciar a rodada, ganhe 1 aritmética"
  },
  State_70644_Desc = {
    Text = "Após liberar a exaltação, ganhe 16/32 pontos de poder temporários."
  },
  State_70645_Desc = {
    Text = "Ao iniciar a rodada, ganhe 2 pontos de aritmética."
  },
  State_70646_Name = {
    Text = "Faca de Sacrifício Perdida+"
  },
  State_70647_Desc = {
    Text = "Todos os despertos têm um aumento de 30% no dano base causado."
  },
  State_70648_Desc = {
    Text = "No início da batalha, aplique 640 camadas de veneno a todos os inimigos. O efeito é dobrado em batalhas contra chefes."
  },
  State_70656_Desc = {
    Text = "\"Ataque\" causa um adicional 1/2 instância de dano igual a 60% do Ataque do Despertador, acionando até 3 vezes por turno."
  },
  State_70657_Desc = {
    Text = "No início da batalha, ganhe 32 pontos de força."
  },
  State_70660_Desc = {
    Text = "No início da batalha, ganhe 64 pontos de força."
  },
  State_70661_Desc = {
    Text = "No fim do turno, recupera 64 pontos de vida."
  },
  State_70661_Name = {
    Text = "Sangue da Graça+"
  },
  State_70662_Desc = {
    Text = "Após usar o Despertar da chave de prata, ganha 2 pontos de aritmética."
  },
  State_70664_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, ganhe 16 pontos de poder."
  },
  State_70666_Desc = {
    Text = "Após o início da batalha, ganhe 100/200 de Maestria em Domínios. Todos os Despertados têm um aumento de 10%/20% no veneno base causado e no veneno causado pelas criações."
  },
  State_70667_Desc = {
    Text = "Após usar o Despertar da chave de prata, obtenha 4 pontos de aritmética."
  },
  State_70670_Desc = {
    Text = "No início da batalha, ganhe 320 pontos de balcão, o efeito é dobrado em batalhas contra chefes."
  },
  State_70671_Desc = {
    Text = "Após entrar em um turno ultra, a primeira carta de comando não derivada jogada terá um efeito adicional de 1/2 vez."
  },
  State_70678_Desc = {
    Text = "No início da batalha, ganhe 640 pontos de <RetaliateIconKeywords:balcão>, o efeito é dobrado em batalhas contra chefes."
  },
  State_70681_Desc = {
    Text = "Todos os despertos têm um aumento de 60% no dano base causado."
  },
  State_70682_Desc = {
    Text = "Quando o número de cartas na mão for menor ou igual a 2, compre 1/2 carta, com um máximo de 2 ativações por rodada."
  },
  State_70683_Desc = {
    Text = "Aniquilação faz o Despertado com menos loucura ganhar 50/100 de loucura. Tempo de recarga: 3 turnos."
  },
  State_70684_Desc = {
    Text = "No início do turno, se a vida estiver abaixo de 25%, ganhe 72/144 de força temporária."
  },
  State_70685_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, aplique 416 níveis de veneno a todos os inimigos."
  },
  State_70686_Desc = {
    Text = "Após desencadear a Fúria Explosiva, todos os inimigos recebem <FixedDamage:Dano Puro> igual a 15%/30% da sua Vida máxima e são afetados com 10%/20% de Envenenamento."
  },
  State_70687_Name = {
    Text = "Relógio de Hipercorda+"
  },
  State_70689_Desc = {
    Text = "Após usar o Despertar da chave de prata, aplique 832 níveis de veneno a todos os inimigos."
  },
  State_70690_Desc = {
    Text = "Após o início da batalha, ganhe 100/200 de Maestria em Domínios. Todos os Despertados têm um aumento de 10%/20% na retaliação base causada e na retaliação causada pelas criações."
  },
  State_70691_Desc = {
    Text = "Cada vez que causar dano, ganhe 4/8 de força temporária, com um máximo de 15 ativações por turno."
  },
  State_70693_Desc = {
    Text = "A quantidade automática de fusão de embrião aumenta 100%/200%."
  },
  State_70694_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, compre 2 cartas."
  },
  State_70695_Desc = {
    Text = "No início de cada rodada, todos os despertadores ganham 5 de exaltação."
  },
  State_70696_Desc = {
    Text = "Após usar o Despertar da chave de prata, obtenha 208 pontos de contra-ataque."
  },
  State_70698_Desc = {
    Text = "Defesa ganha 200/400 de contra-ataque temporário, com um máximo de 3 ativações por turno."
  },
  State_70804_Name = {
    Text = "Prazo de vida ou morte"
  },
  State_70805_Desc = {
    Text = "Após o início da batalha, aplique 1/2 camada de <WeaknessIconKeywords:fraqueza> a todos os inimigos. O efeito é dobrado contra chefes. Todos os despertos têm um aumento de 15%/30% no dano base causado."
  },
  State_70806_Name = {
    Text = "Mão da Proteção+"
  },
  State_70808_Desc = {
    Text = "Use a postura \"Mar Calmo\" para aplicar 64/128 de exaustão a todos os inimigos, com 3 turnos de cooldown."
  },
  State_70809_Desc = {
    Text = "No início do turno, se a vida estiver abaixo de 25%, ganhe 100/200 de escudo."
  },
  State_70809_Name = {
    Text = "Mão do Guardião"
  },
  State_70810_Desc = {
    Text = "Use a postura Torrente de Raiva para imediatamente ativar todos os tentáculos para atacar o inimigo 1/2 vez, com 3 turnos de cooldown."
  },
  State_70812_Desc = {
    Text = "Após o início da batalha, aplique 1/2 camada de vulnerável a todos os inimigos, o efeito é dobrado contra chefes. Todos os despertadores têm um aumento de 15%/30% no dano base causado."
  },
  State_70832_Desc = {
    Text = "Equipe única: Ao iniciar a batalha, o portador ganha uma quantidade de aliemus equivalente a <WeaponEffect_Num:[StateArg1]%> da recarga de aliemus do portador. Após liberar a exaltação pela primeira vez em cada batalha, repete esse efeito."
  },
  State_70832_WeaponDesc = {
    Text = "Ao iniciar a batalha, o portador ganha uma quantidade de aliemus equivalente a <WeaponEffect_Num:[StateArg1]%> da recarga de aliemus do portador (<WeaponEffect_Num:[DescArg1]>). Após liberar a exaltação pela primeira vez em cada batalha, repete esse efeito."
  },
  State_70835_Desc = {
    Text = "Equipe única: O aliemus, envenenamento e recuperação de vida causados pelo portador aumentam em <WeaponEffect_Num:[StateArg1]%>. Após liberar a exaltação, o portador ganha uma quantidade de aliemus equivalente a <WeaponEffect_Num:[StateArg2]%> do aliemus consumido nesta exaltação."
  },
  State_70835_WeaponDesc = {
    Text = "O aliemus, envenenamento e recuperação de vida causados pelo portador aumentam em <WeaponEffect_Num:[StateArg1]%>. Após liberar a exaltação, o portador ganha uma quantidade de aliemus equivalente a <WeaponEffect_Num:[StateArg2]%> do aliemus consumido nesta exaltação."
  },
  State_70989_Desc = {
    Text = "Após liberar 4 explosões de loucura em um turno, ganhe 3/6 pontos de aritmética. Recarga em 3 turnos."
  },
  State_71001_Desc = {
    Text = "Após jogar 4 cartas de comando pertencentes a Despertados diferentes em um único turno, todos os Despertados ganham 20/40 de Loucura, com um tempo de recarga de 3 turnos."
  },
  State_71153_Desc = {
    Text = "No início do turno, Caecus ganha 15 pontos de loucura. Quando Caecus ganha um escudo, recupera vida equivalente a 50% do valor do escudo."
  },
  State_71154_Desc = {
    Text = "Ao iniciar o turno, Aigis ganha 15 pontos de aliemus. Quando Aigis causa dano a um inimigo com vulnerabilidade, também rouba 10 pontos de força temporária, podendo ser ativado no máximo 5 vezes por turno."
  },
  State_71155_Desc = {
    Text = "No início do turno, Reia ganha 15 pontos de loucura. Sempre que perder vida, ela ganha 8 pontos de poder, acumulando no máximo 10 vezes por batalha. Após acumular 10 vezes, o consumo de aritmética de \"Dor e Prazer\" se torna 1 e o número de acertos do dano aumenta em 1."
  },
  State_71156_Desc = {
    Text = "Ao iniciar o turno, Agrippa ganha 15 pontos de aliemus. \"A caridade impaciente\" também reduz o consumo de aritmética de Agrippa em 1 durante este turno, e pode ser usada apenas 1 vez por turno."
  },
  State_71157_Desc = {
    Text = "No início do turno, Shan ganha 15 pontos de loucura. No início da batalha, concede a todas as cartas de comando de Shan as palavras-chave \"Reservado\" e \"Preparado 1\", e obtém 24 pontos de escudo."
  },
  State_71157_Name = {
    Text = "Imagem Dimensional · Sanga"
  },
  State_71158_Desc = {
    Text = "Ao iniciar a rodada, Boneca ganha 15 pontos de loucura. Após o início da batalha, o custo computacional de poder de \"Intercâmbio Equivalente\" da Boneca se torna 0, e após ser jogada, na próxima rodada ela comprará 2 cartas adicionais."
  },
  State_71159_Desc = {
    Text = "No início da rodada, Faróis ganha 15 pontos de aliemus. Cada vez que causar 1 dano de tentáculo, o veneno causado por Faróis nesta batalha aumenta em 1%, até o máximo de 100%."
  },
  State_71160_Desc = {
    Text = "Ao início do turno, \"24\" ganha 15 de exaltação. Ao início do turno, se \"24\" estiver na \"Personalidade Depressiva\", ganha 25 de exaltação adicional; se estiver na \"Personalidade Maníaca\", aumenta temporariamente a taxa de acerto crítico e o dano crítico de \"24\" em 35%."
  },
  State_71161_Desc = {
    Text = "No início do turno, Desmaio ganha 15 pontos de loucura. Cada vez que a resistência à morte for ativada, aumenta em 20% os escudos, efeitos de retaliatória e recuperação de vida causados por Desmaio durante a exploração atual, com no máximo 5 ativações."
  },
  State_71162_Desc = {
    Text = "No início do turno, Golias ganha 15 de aliemus. Se Golias causar dano 3 vezes em um turno, o dano causado por Golias ganha um bônus adicional de 1 vez o poder nesta batalha, com recarga de 3 turnos."
  },
  State_71163_Desc = {
    Text = "Ao iniciar a rodada, Corrente de Sangue: Hilota ganha 15 pontos de insanidade. O dano ativo de Corrente de Sangue: Hilota aplica 20% de sangramento e, após matar um inimigo, causa sangramento aos outros inimigos equivalente ao dano excedente."
  },
  State_71164_Desc = {
    Text = "No início da rodada, Aurita ganha 15 Aliemus. A contagem de dano de \"Divisão de Glândulas\" aumenta em 1, e após jogar a \"Defesa\" de Aurita, coloca 1 \"Divisão de Glândulas\" na mão."
  },
  State_71166_Desc = {
    Text = "No início do turno, Lily ganha 15 pontos de aliemus. O limite de resistência de Lily aumenta em 100%. Ao liberar \"A flor imortal sobre o lodo\" ou \"golpe de recompensa\", recupera vida equivalente a 8% das camadas de resistência."
  },
  State_71167_Desc = {
    Text = "No início do turno, Lotan ganha 15 pontos de aliemus. Após jogar pela primeira vez a \"Defesa\" de Lotan em cada turno, coloque 2 \"Lâminas Teimosas\" com custo adicional e vazio na mão."
  },
  State_71168_Desc = {
    Text = "Ao início do turno, Pandia ganha 15 pontos de loucura. Ao início do turno, ganha 64 pontos de ataque. Para cada 4 pontos de ataque não temporários, o dano das cartas de comando de \"Pandia\" aumenta em 1."
  },
  State_71169_Desc = {
    Text = "Ao iniciar a rodada, Hilota ganha 15 de loucura. Sempre que uma carta é descartada, \"Hilota\" ganha 5 de loucura."
  },
  State_71170_Desc = {
    Text = "No início do turno, Tawil ganha 15 pontos de loucura. Se jogar 6 cartas de comando de Tawil em um único turno, coloque 1 carta \"Chave Prateada do Aurora\" em sua mão, com recarga de 3 turnos."
  },
  State_71171_Desc = {
    Text = "No início da rodada, Miriam ganha 15 pontos de sanidade e adiciona 1 carta \"Sacrário\" à mão."
  },
  State_71172_Desc = {
    Text = "No início do turno, Derretida Dore ganha 15 de loucura. Após Derretida Dore liberar a explosão de loucura, para cada 20 pontos de loucura consumidos, os outros despertadores ganham 1 ponto de loucura."
  },
  State_71173_Desc = {
    Text = "No início do turno, Salvador ganha 15 pontos de Loucura. Cada vez que acumula Fornalha Carmesim, também ganha 5% do poder acumulado. Os ataques \"Golpe\" e \"Sofrimento Inevitável\" de Salvador recebem um bônus adicional de 1x o poder."
  },
  State_71175_Desc = {
    Text = "No início do turno, Náutilo ganha 15 pontos de aliemus. Após liberar a \"exaltação\" de Náutilo, obtenha uma quantidade de contra-ataque equivalente a 50% do escudo atual, podendo ser acionado uma vez por turno."
  },
  State_71177_Desc = {
    Text = "Ao iniciar a rodada, Liz ganha 15 pontos de loucura. \"Dança para a destruição\" faz com que as cartas descartadas tenham 1 efeito adicional, com recarga de 3 turnos."
  },
  State_71178_Desc = {
    Text = "No início do turno, Ramona ganha 15 de Loucura. Cada 3ª carta de comando jogada por Ramona tem efeito adicional uma vez."
  },
  State_71179_Desc = {
    Text = "No início do turno, Youhahashi ganha 15 pontos de insanidade. O consumo de insanidade de Youhahashi é reduzido em 10 pontos e é reduzido em 5 pontos adicionais cada vez que liberar uma explosão de insanidade, podendo liberar 2 explosões de insanidade por turno."
  },
  State_71180_Desc = {
    Text = "No início do turno, Elva ganha 15 pontos de insanidade. Se Elva jogou 2 cartas de \"Defesa\" no turno anterior, coloque 1 \"Lâmina de Precisão\" com custo na mão; se jogou 2 cartas de \"Golpe\", coloque 1 \"Postura de Combate\" com custo na mão."
  },
  State_71181_Desc = {
    Text = "No início do turno, Sorel ganha 15 de Fúria. Cada vez que Sorel causar 1 instância de Dano, a Fusão de embriões aumenta em 10, acumulando até 10 vezes por turno. Após atingir 10 acumulados, o Dano crítico de Sorel nesta batalha aumenta em 20%."
  },
  State_71182_Desc = {
    Text = "No início da rodada, Hamlin ganha 15 pontos de sanidade. O custo de poder de \"Ária da Alma\" é reduzido em 1 e o número básico de golpes é aumentado em 1."
  },
  State_71183_Desc = {
    Text = "Ao iniciar o turno, Táias ganha 15 pontos de loucura. Após Táias jogar 2 cartas de comando no mesmo turno, ela recebe 1 \"Filho Sagrado\" e 72 pontos de poder temporário, com tempo de recarga de 3 turnos."
  },
  State_71187_Desc = {
    Text = "No início do turno, Celeste ganha 15 pontos de aliemus. Antes do final do turno, para cada carta de comando de Celeste na mão, um tentáculo ataca o inimigo e recupera 8 pontos de vida."
  },
  State_71188_Desc = {
    Text = "No início do turno, Murphy ganha 15 pontos de aliemus. O \"ataque\" e a \"defesa\" de Murphy podem converter 25% do <SacrificeKeyWord:sacrifício> em dano de tentáculo temporário, mas só podem ser ativados uma vez por turno."
  },
  State_71189_Desc = {
    Text = "No início do turno, Nínfea ganha 15 pontos de aliemus. Após jogar o \"ataque\" de Nínfea, aumenta em 20% o veneno causado por Nínfea nesta batalha; após jogar a \"defesa\" de Nínfea, ativa 50% de veneno em todos os inimigos. Cada um pode ser ativado no máximo uma vez por turno."
  },
  State_71190_Desc = {
    Text = "No início do turno, Ogier ganha 15 pontos de loucura. Após jogar pela primeira vez \"Lança Perfurante\" ou \"Golpe\" de Ogier em cada turno, aumente em 50% os escudos e o poder causados por Ogier neste turno."
  },
  State_71191_Desc = {
    Text = "No início do turno, Ryker ganha 15 Aliemus. O resultado da primeira jogada de dados de cada turno é sempre 6."
  },
  State_71192_Desc = {
    Text = "No início do turno, Círculo·Ramona ganha 15 pontos de loucura. Na primeira ativação de \"ciclo\" em cada turno, ganha 500 pontos de energia da chave de prata e 1 camada de \"negentropia\"."
  },
  State_71193_Desc = {
    Text = "No início do turno, Tulu ganha 15 de loucura. O consumo de loucura de Tulu é reduzido em 10 pontos e são gerados imediatamente 2 tentáculos temporários após liberar a explosão da loucura."
  },
  State_71194_Desc = {
    Text = "No início do turno, Karen ganha 15 pontos de insanidade. Jogar \"Vigília Silenciosa\" devolve o dobro do poder consumido, recarrega em 3 turnos."
  },
  State_71271_Desc = {
    Text = "No início do turno, Horla ganha 15 pontos de loucura. No início da batalha, obtenha 1 camada de metáfora para cada estado emocional. O efeito de \"metáfora\" aumenta em 50%."
  },
  State_71272_Desc = {
    Text = "No início da rodada, Jenkins ganha 15 pontos de sanidade e +5% de dano final. O dano base e o dano causado por \"Marrom, ataque!\" têm seu crescimento aumentado em 200%."
  },
  State_71273_Desc = {
    Text = "No início do turno, Dafodil ganha 15 pontos de loucura e 1 carta \"Inspiração\". Cada vez que \"Maré Heterogênea\" for jogada, o poder obtido por ela será permanentemente aumentado em 25% durante a exploração atual, até um máximo de 300%."
  },
  State_71274_Desc = {
    Text = "No início do turno, Tinta ganha 15 pontos de loucura. Quando uma carta de comando da Tinta é ativada com salto, ela retorna à mão; este efeito pode ser acionado no máximo 3 vezes por turno."
  },
  State_71275_Desc = {
    Text = "No início do turno, Wanda ganha 15 pontos de loucura e 1 camada de \"Guia dos Sonhos\". Se for o turno superdimensional, adicione adicionalmente 1 carta temporária de \"Corrente de Espinhos\" e \"Guardião Perdido\" na mão."
  },
  State_71276_Desc = {
    Text = "No início do turno, Erika ganha 15 pontos de loucura. Após Erika jogar 3 cartas de comando dentro de 1 turno, ela ganha 1 carta \"Inspiração\" e dobra o bônus de poder e prontidão concedido pela \"Explosão Eletromagnética\" nesta batalha."
  },
  State_71277_Desc = {
    Text = "Ao iniciar a rodada, Casiah ganha 15 pontos de loucura. Para cada carta comprada, Casiah ganha 1 ponto de loucura. Quando Casiah libera a exaltação, todos os inimigos perdem 32 pontos de poder."
  },
  State_71278_Desc = {
    Text = "No início do turno, Wen Ke'er ganha 15 pontos de Loucura. Sempre que outros Despertados usarem uma Exaltação, Wen Ke'er ganha 5 pontos de Loucura e o custo de poder de \"Reconstrução Espiritual\" na mão é reduzido em 1."
  },
  State_71279_Desc = {
    Text = "Dano potencializado da equipe aumentado em [StateArg1]%, durando por [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_71279_Name = {
    Text = "Empolgação"
  },
  State_71503_Name = {
    Text = "\"Forma Final\": compre 3 cartas adicionais, ganhe 3 pontos de poder computacional, ative [DescArg1]% de <IntoxicationIconKeywords:envenenamento> em todos os inimigos, aumente em 50 pontos o limite de loucura de \"Fusão·Doll\", podendo aumentar no máximo 3 vezes"
  },
  State_71581_Name = {
    Text = "Adaptabilidade de forma espiritual"
  },
  State_71589_Name = {
    Text = "Ative 1 tentáculo para atacar o inimigo e recuperar 8."
  },
  State_71605_Name = {
    Text = "Obtenha [StateArg1] pontos de escudo"
  },
  State_71650_Desc = {
    Text = "Após a morte, revive e convoca uma quantidade variável de clones, mas após reviver, não ganha nenhuma fortificação ou imunidade. Pode ser ativado [Layer] vezes."
  },
  State_71650_Name = {
    Text = "Besta de Míriades de Dimensões"
  },
  State_71651_Desc = {
    Text = "Sempre que perder vida, perde [StateArg1] pontos de força temporária. Pode ativar [Layer] vezes, com as ativações redefinidas a cada turno."
  },
  State_71651_Name = {
    Text = "Chapéu de Gentleman"
  },
  State_71707_Desc = {
    Text = "Para cada instância de Dano ativo recebido, recupera [StateArg1] de Vida, durando [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_71707_Name = {
    Text = "Caecus·Suporte"
  },
  State_71708_Desc = {
    Text = "No final do turno, para cada cartão na mão, todos os Despertados ganham [DescArg1] pontos de loucura."
  },
  State_71708_Name = {
    Text = "Kasía·Suporte"
  },
  State_71709_Desc = {
    Text = "No final do turno, ganhe 35 pontos de loucura, durando [Layer] turnos."
  },
  State_71709_Name = {
    Text = "Wenkel·Suporte"
  },
  State_71711_Desc = {
    Text = "Dano causado pelo corpo desperto aumentado em 25%, dura [Layer] turnos."
  },
  State_71711_Name = {
    Text = "Jenkin·Suporte"
  },
  State_71712_Desc = {
    Text = "Ao causar Dano ativo, aciona 1 Ataque de tentáculo uma vez, durando [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_71712_Name = {
    Text = "Aurita·Suporte"
  },
  State_71712_WeaponDesc = {
    Text = "Quando a lua do mar causa dano, faz com que [StateArg1] tentáculos ataquem o alvo"
  },
  State_71713_Desc = {
    Text = "Cada vez que \"Devorar\" é realizado, compre 2 \"Golpes\" e reduza seu consumo de Aritmética em 1, durando por [Layer] rodadas."
  },
  State_71713_Name = {
    Text = "Shiro·Suporte"
  },
  State_71740_Desc = {
    Text = "No início do próximo turno, ganhe [Layer] pontos de escudo"
  },
  State_71740_Name = {
    Text = "Reia Suporte Escudo"
  },
  State_71741_Desc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida neste turno, por [Layer] turnos."
  },
  State_71741_Name = {
    Text = "Reia·Suporte"
  },
  State_71741_WeaponDesc = {
    Text = "No início do próximo turno, ganhe escudo igual à vida perdida no turno anterior"
  },
  State_71742_Desc = {
    Text = "Dano da carta de golpe aumentado em [Layer]%."
  },
  State_71742_Name = {
    Text = "Shiro·Suporte"
  },
  State_71742_WeaponDesc = {
    Text = "Neste turno, dano das cartas de golpe aumenta [Layer]%"
  },
  State_71837_Desc = {
    Text = "No início da próxima rodada, ganhe vulnerabilidade."
  },
  State_71837_Name = {
    Text = "Atraso de vulnerabilidade"
  },
  State_71839_Desc = {
    Text = "Ao usar \"Despertar\", ganha [Layer] pontos de aritmética. Se o domínio atual for \"Mar Profundo\", gere adicionalmente [Layer] tentáculos temporários."
  },
  State_71839_Name = {
    Text = "Proteção estelar"
  },
  State_71856_Desc = {
    Text = "Sempre que perder vida, perde [StateArg1] pontos de força temporária. Pode ativar [Layer] vezes, com as ativações redefinidas a cada turno."
  },
  State_71856_Name = {
    Text = "Chapéu de Gentleman"
  },
  State_72016_Name = {
    Text = "Maestria de Carne e sangue"
  },
  State_72018_WeaponDesc = {
    Text = "Cada dano recebido aumenta a loucura de todos os despertos em 1"
  },
  State_72033_Name = {Text = "tentáculo"},
  State_72036_Name = {
    Text = "Inicialização de Classe Caótica"
  },
  State_72079_Name = {
    Text = "Onda de Ira"
  },
  State_72102_Desc = {
    Text = "Experiência clássica de jogo da \"Véspera do Esquecimento\"."
  },
  State_72102_Name = {
    Text = "Capítulo Esquecido"
  },
  State_72137_Name = {
    Text = "Potência de cálculo cheia"
  },
  State_72206_Name = {
    Text = "Progresso da pesquisa \"[DescArg1] / 15\""
  },
  State_72208_Name = {
    Text = "Progresso da pesquisa \"[DescArg1] / 2\""
  },
  State_72212_Name = {
    Text = "Progresso da pesquisa \"[DescArg1] / 10\""
  },
  State_72213_Name = {
    Text = "Progresso da pesquisa \"[DescArg1] / 30\""
  },
  State_72220_Name = {
    Text = "Progresso da pesquisa \"[DescArg1]/5\""
  },
  State_73518_Desc = {
    Text = "O dano causado aumenta em 100%, remove este estado após perder vida, mas ganha um escudo equivalente a 50% da saúde máxima."
  },
  State_73518_Name = {
    Text = "\"Assassino\""
  },
  State_73520_Desc = {
    Text = "Ao morrer, mantenha 1 ponto de vida e fique imune a todos os danos, transformando a intenção em \"Desvinculação\"."
  },
  State_73520_Name = {Text = "\"Conector\""},
  State_73533_Desc = {
    Text = "No final do turno do jogador, não descarte mais as cartas na mão. No início da batalha, o limite de cartas na mão do jogador se torna 8."
  },
  State_73533_Name = {
    Text = "Sentido do Enxame"
  },
  State_73535_Desc = {
    Text = "Dentro do próprio turno, dano recebido é reduzido em 75%. Quando a força é reduzida, apenas 50% das camadas de força são diminuídas."
  },
  State_73535_Name = {
    Text = "Auto-proteção"
  },
  State_73566_Desc = {
    Text = "Para cada carta não-comando jogada, ganha [Power:StateArg1] pontos de <PowerIconKeywords:força> e <Block:[Block:StateArg2]> pontos de escudo."
  },
  State_73566_Name = {
    Text = "Comunicador"
  },
  State_73567_Desc = {
    Text = "Para cada carta não-comando jogada, ganha [Power:StateArg1] pontos de <PowerIconKeywords:força> e <Block:[Block:StateArg2]> pontos de escudo."
  },
  State_73567_Name = {
    Text = "Comunicador"
  },
  State_73570_Desc = {
    Text = "Para cada carta não-comando jogada, ganha [Power:StateArg1] pontos de <PowerIconKeywords:força> e <Block:[Block:StateArg2]> pontos de escudo."
  },
  State_73570_Name = {
    Text = "Comunicador"
  },
  State_73573_Desc = {
    Text = "Para cada carta não-comando jogada, ganha [Power:StateArg1] pontos de <PowerIconKeywords:força> e <Block:[Block:StateArg2]> pontos de escudo."
  },
  State_73573_Name = {
    Text = "Comunicador"
  },
  State_73649_Desc = {
    Text = "Dano da equipe aumentado em [Layer]%."
  },
  State_73649_Name = {
    Text = "Modelo Anatômico do Esquecimento"
  },
  State_73655_Name = {
    Text = "Forma orgânica da identificação"
  },
  State_73664_Name = {
    Text = "Efeito da Forma Orgânica dos Acessórios"
  },
  State_73664_WeaponDesc = {
    Text = "Após o uso do aliemus, o escudo e a cura do portador são dobrados neste turno"
  },
  State_74012_Desc = {
    Text = "Causa <RealDamage:Dano Fixo> igual a [StateArg1]% da vida máxima de todos os inimigos (mínimo de [DescArg1]). Após o uso, a habilidade específica de \"Fusão · Dor\" é alterada para \"Fim\"."
  },
  State_74012_Name = {
    Text = "Fim do Néant"
  },
  State_74013_Desc = {
    Text = "Causa <RealDamage:Dano Fixo> equivalente a [StateArg1]% da vida máxima de todos os inimigos, esse dano não será inferior a 500% da própria vida máxima. Após usar, a habilidade específica de \"Fusão · Dor\" será alterada para \"Fim\"."
  },
  State_74013_Name = {
    Text = "Fim do Néant"
  },
  State_74014_Desc = {
    Text = "Causa <RealDamage:Dano Fixo> igual a [StateArg1]% da vida máxima de todos os inimigos (esse dano não será inferior a 500% da vida máxima própria), recupera 30% da vida perdida e, após o uso, a habilidade específica de \"Fusão · Dor\" é alterada para \"Fim\"."
  },
  State_74014_Name = {
    Text = "Fim do Néant"
  },
  State_74015_Desc = {
    Text = "Causa <RealDamage:Dano Fixo> igual a [StateArg1]% da vida máxima de todos os inimigos (mínimo de [DescArg1]), recupera <Heal:[Heal:DescArg2]> pontos de vida e, após o uso, a habilidade específica de \"Fusão · Dor\" é alterada para \"Fim\"."
  },
  State_74015_Name = {
    Text = "Fim do Néant"
  },
  State_74019_Desc = {
    Text = "Todos os despertos têm aumento de [Layer]% no dano base, contra-ataque e veneno causados."
  },
  State_74019_Name = {
    Text = "Infecção de loucura"
  },
  State_74142_Desc = {
    Text = "Após o início da exploração, aumente a constituição, o ataque e a defesa em [StateArg1]%"
  },
  State_74142_Name = {
    Text = "Adaptabilidade de forma espiritual"
  },
  State_74219_Name = {
    Text = "Após jogar, retorna à mão"
  },
  State_74273_Desc = {
    Text = "Quando Hilota causa dano ativo com Corrente de Sangue, aplica [StateArg1]% de sangramento, dura [Layer] turnos."
  },
  State_74273_Name = {
    Text = "Cadeias de Restrição"
  },
  State_74771_Desc = {
    Text = "O valor de loucura necessário para liberar uma exaltação."
  },
  State_74771_Name = {
    Text = "Limite de fúria"
  },
  State_74788_Desc = {
    Text = "\n·Existe paradoxo: No início da exploração, 75% da Resistência à Morte é convertida em bônus de Vida máxima, com um máximo de 300% de Resistência à Morte convertida, elevando no máximo 10% da Vida máxima. Cada vez que a Resistência à Morte é ativada, 1 carta de \"Luz sutil da chave de prata\" é adicionada à mão. \n·Cicatriz sem fundo: Durante a Batalha do Líder, a quantidade de vida recuperada pelo nosso lado reduz em 25% toda vez que atinge 100% do limite de vida, mas aumenta a quantidade total de Resistência à Morte atual em 25%, podendo ser ativado no máximo 3 vezes. \n·Lente prismática: No início do turno, se o Contrataque exceder 750% do limite de vida, a camada excedente é reduzida à metade, e o Contrataque Persistente pode ser acumulado até 2250% do limite de vida; se o inimigo for Envenenado além de 1000% do limite de vida, a camada excedente é reduzida à metade, e o Envenenamento pode ser acumulado até 3000% do limite de vida. O aumento de dano recebido pelo Corpo Desperto devido ao Contrataque é reduzido em 70%, mas todo o Envenenamento e Contrataque causado aumentam em 10%. No início do turno do inimigo, para cada Gnosis ativado, ganha-se 25% do Contrataque Persistente atual como Contrataque Temporário e provoca 25% de Envenenamento em todos os inimigos. \n·Cono de luz do destino: O número de turnos em que Monstros normais lançam \"Olhar\" é alterado para 6 turnos. Todas as batalhas têm um limite de 15 turnos, mas ao iniciar o 15º turno, 1 carta de \"Limite do Cone de Luz\" é adicionada à mão: ganha-se o limite de Energia da Chave de Prata em Energia da Chave de Prata, e todos os Corpos Despertos ganham o Limite de fúria em Fúria."
  },
  State_74788_Name = {
    Text = "(Temporariamente descartado)"
  },
  State_74791_Desc = {
    Text = "\nAjuste de potência de cálculo: Para cada Carta de comando disparada após a 10ª em um turno, ganhe 1 \"Ajuste de potência de cálculo\". Cada capa aumenta o custo da carta em 1 de Poder de cálculo, que é então convertido em 100% da Recarga de Chave de Prata do Corpo Desperto (acumulável). As capas são redefinidas ao entrar no Espaço Hiperdimensional.\nPotência de cálculo cheia: Ao disparar uma carta, remove seu efeito de redução de Consumo de potência de cálculo neste turno. Quando o Poder de cálculo atual exceder 12, cada ponto excedente é convertido em 300% da Recarga de Chave de Prata média da equipe.\nHarmonia Furiosa: O efeito de aumento de % de Fúria é reduzido à metade. Cada Fúria Explosiva aumenta a Fúria Básica em 10. Ganhe 200% da Recarga de Chave de Prata média da equipe no fim do turno para cada Corpo Desperto que não realizou Fúria Explosiva."
  },
  State_74791_Name = {
    Text = "Harmonização da Energia da Chave"
  },
  State_74809_Name = {
    Text = "\"Forma Final\": compre 3 cartas adicionais, ganhe 3 pontos de poder computacional, ative [DescArg1]% de <IntoxicationIconKeywords:envenenamento> em todos os inimigos, aumente em 50 pontos o limite de loucura de \"Fusão·Doll\", podendo aumentar no máximo 3 vezes"
  },
  State_74826_Name = {
    Text = "Causa [DescArg1] <FixedDamage:Dano Puro> aleatoriamente [DescArg2] <plural value=\"[DescArg2]\" singular=\"vez\" plural=\"vezes\"> (beneficia de 1× <PowerIconKeywords:STR>)"
  },
  State_74827_Name = {
    Text = "Neste turno, a taxa crítica e o dano crítico de todos os despertos aumentam [DescArg1]%"
  },
  State_74828_Name = {
    Text = "Causa [DescArg1] camadas de <IntoxicationIconKeywords:veneno> a todos os inimigos"
  },
  State_74829_Name = {
    Text = "Causa <FixedDamage:Dano Puro> a todos os inimigos igual a [DescArg1]% da Vida que lhes falta"
  },
  State_74830_Name = {
    Text = "Obtenha [DescArg1] pontos de força"
  },
  State_74831_Name = {
    Text = "Todos os despertos ganham [DescArg1] pontos de loucura"
  },
  State_74847_Desc = {
    Text = "Único para a equipe: O dano base da primeira carta de comando usada pelo portador em cada turno aumenta em <WeaponEffect_Num:[StateArg1]%>. Se ele entrar no hiperespaço, o portador ganha <WeaponEffect_Num:[StateArg2]> pontos de aliemus."
  },
  State_74847_WeaponDesc = {
    Text = "O dano base da primeira carta de comando usada pelo portador em cada turno aumenta em <WeaponEffect_Num:[StateArg1]%>. Se ele entrar no espaço dimensional, o portador ganha <WeaponEffect_Num:[StateArg2]> pontos de loucura."
  },
  State_74879_Name = {
    Text = "Obtenha [DescArg1] pontos de aritmética"
  },
  State_74881_Name = {
    Text = "Escolha um Despertado para ganhar [DescArg1] de Loucura"
  },
  State_74882_Name = {
    Text = "Obtenha [DescArg1] pontos de Maestria em Domínios"
  },
  State_74883_Name = {
    Text = "A próxima carta de comando jogada, dentre as [DescArg1], ganha [DescArg2] pontos de energia adicional"
  },
  State_74884_Name = {
    Text = "O veneno, contra-ataque e sangramento causados neste turno aumentam em [DescArg1]%"
  },
  State_74885_Name = {
    Text = "Todos os despertos ganham [DescArg1] pontos de loucura"
  },
  State_74887_Name = {
    Text = "Obtenha [DescArg1] pontos de escudo"
  },
  State_74888_Name = {
    Text = "Obtenha [DescArg1] pontos de resistência à morte"
  },
  State_74889_Name = {
    Text = "Ganha [DescArg1] camadas de balcão"
  },
  State_74890_Name = {
    Text = "Roube [DescArg1] pontos de força temporária de todos os inimigos"
  },
  State_74891_Name = {
    Text = "Causa [DescArg1] <FixedDamage:Dano Puro> aleatoriamente [DescArg2] <plural value=\"[DescArg2]\" singular=\"vez\" plural=\"vezes\"> (beneficia de 1× <PowerIconKeywords:STR>)"
  },
  State_74910_Desc = {
    Text = "Equipe Única: Se o Portador for o Corpo Desperto \"Ramona\", a Taxa de Sincronização obtida ao completar o estágio +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_74910_WeaponDesc = {
    Text = "Se o equipador for o despertador \"Ramona\", a taxa de afinidade obtida ao concluir a fase aumenta em <WeaponEffect_Num:[StateArg1]%>."
  },
  State_74932_Desc = {
    Text = "Jogar um cartão \"Strike\", um cartão \"Defesa\" ou um cartão \"Habilidade\" irá aprimorar o efeito correspondente em \"Tabu Comércio\"."
  },
  State_74932_Name = {
    Text = "Comércio Proibido"
  },
  State_74947_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No início do turno, aplica [StateArg1] camadas de bloqueio de ação ao inimigo com <HPAndShieldMin:menor vida e escudo>. Após o portador causar uma eliminação, este efeito é acionado imediatamente mais uma vez."
  },
  State_74947_Name = {
    Text = "Chapéu de Bruxa de Aba Larga"
  },
  State_74948_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após \"Exaltar\", faça o inimigo com o maior exaltar perder [StateArg1] pontos de exaltar e ganhar <PVPEmptinessKeywords:Vazio>."
  },
  State_74948_Name = {
    Text = "Pêndulo Hipnótico"
  },
  State_76236_Desc = {
    Text = "\nDespertar da Chave de Prata: Quando a Energia de chave estiver cheia, você pode adicionalmente escolher \"Despertar da Chave de Prata\" para colocar a carta de Despertar do Corpo Desperto designado na mão e conceder-lhe \"Preservar\" para esta batalha. \"Despertar da Chave de Prata\" só pode ser acionado uma vez por turno e tem um tempo de recarga independente de \"Ordem de chave\".\nSobrecarga de Chave de Prata: Ao usar \"Despertar da Chave de Prata\", para cada Corpo Desperto Despertado, 1000 de Energia de chave é deduzida, o que pode fazer a Energia de chave ficar negativa.\nMarcação de arquivo: Para cada Ordem de chave que o Guardião possui, a Profundidade de pesquisa de objetos e a Profundidade da Pesquisa da Consciência aumentam em 1%, até 50%. Todos os efeitos de Rodas do Destino R são alterados para aumentar a chance de a Criação de Imagem Dimensional do Portador aparecer em 100%."
  },
  State_76236_Name = {
    Text = "Brilho prateado cintilante"
  },
  State_76277_Desc = {
    Text = "Equipe Única: Após o início da Batalha do Líder, consuma até 50 Marca Negra, ganhando <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords: Resistência à Morte> para cada ponto de Marca Negra consumido. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76277_WeaponDesc = {
    Text = "Após o início da Batalha do Líder, consuma até 50 Marcas Negras, ganhando <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords: Resistência à Morte> para cada 1 ponto de Marca Negra consumido. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da Imagem Dimensional do portador\"."
  },
  State_76278_Desc = {
    Text = "Equipe Única: A cada novo espaço percorrido, recupera <WeaponEffect_Num:[StateArg1]%> da vida perdida. Após usar o Corpo de Gnosis de Emergência, a taxa de crítico e o dano crítico de todos os Corpos Despertos aumentam em 100%. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76278_WeaponDesc = {
    Text = "A cada novo quadrado percorrido, recupere [StateArg1]% da vida perdida ([DescArg1]). Após usar o Corpo de Gnosis de Emergência, a taxa de crítico e o dano crítico de todos os corpos despertos aumentam em 100%. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da Imagem Dimensional do portador\"."
  },
  State_76279_Desc = {
    Text = "Único na equipe: O custo para despertar o Corpo Desperto na Marca de Fusão é reduzido em <WeaponEffect_Num:[StateArg1]> pontos de Marca Negra. O Despertar do Conhecimento Espiritual do portador se torna inerente. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da Criação de Imagem Dimensional do portador\"."
  },
  State_76279_WeaponDesc = {
    Text = "O custo para despertar o Corpo Desperto na Marca de Fusão é reduzido em <WeaponEffect_Num:[StateArg1]> pontos de Marca Negra. O Despertar da Gnosis do Portador torna-se Inerente. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da Criação de Imagem Dimensional do Portador\"."
  },
  State_76280_Desc = {
    Text = "Equipe Única: A quantidade de recuperação na área de descanso aumenta em <WeaponEffect_Num:[StateArg1]%. Ao escolher recuperar vida, adicione 2 cartas de \"Inspiração\" ao seu baralho. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76280_WeaponDesc = {
    Text = "A quantidade de recuperação na área de descanso aumenta em <WeaponEffect_Num:[StateArg1]%>, ao escolher recuperar vida, adicione 2 cartas de \"Inspiração\" ao seu baralho. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76281_Desc = {
    Text = "Único na equipe: Após o término da batalha, o desperto com menos aliemus ganha <WeaponEffect_Num:[StateArg1]> pontos de aliemus. No Capítulo Estelar, o efeito é alterado para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76281_WeaponDesc = {
    Text = "Após o término da batalha, o despertador com menor quantidade de loucura ganha <WeaponEffect_Num:[Energy:StateArg1]> pontos de loucura. No Capítulo Estelar, o efeito é alterado para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76282_Desc = {
    Text = "Único no grupo: +1 nas vezes de renovação da marca d, redução de custo de renovação em <WeaponEffect_Num:[StateArg1]> pontos de sigilo negro. No Capítulo Estelar, o efeito muda para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76282_WeaponDesc = {
    Text = "Vezes de renovação da marca d +1, preço de renovação reduzido em <WeaponEffect_Num:[StateArg1]> pontos de sigilo negro. No Capítulo Estelar, o efeito é alterado para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76283_Desc = {
    Text = "Equipe Única: A Barra de Criação de Marca de Fusão muda para 3, sendo uma delas uma Criatura Amaldiçoada. Ao comprar uma Criatura Amaldiçoada, ganha-se <WeaponEffect_Num:[StateArg1]> pontos de Marca Negra. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da Imagem Dimensional do portador\"."
  },
  State_76283_WeaponDesc = {
    Text = "A Barra de Criação de Marca de Fusão muda para 3, sendo um deles uma Criatura amaldiçoada. Ao comprar a Criatura amaldiçoada, ganha <WeaponEffect_Num:[StateArg1]> pontos de Marca Negra. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da Imagem Dimensional do portador\"."
  },
  State_76284_Desc = {
    Text = "Equipe Única: Após o início da fase, todos os Corpos Despertos ganham <WeaponEffect_Num:[StateArg1]> pontos de Fúria. Após o início da Batalha do Líder, compre 2 cartas. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da Criação de Imagem Dimensional do portador\"."
  },
  State_76284_WeaponDesc = {
    Text = "Após o início da fase, todos os Corpos Despertos ganham <WeaponEffect_Num:[Energy:StateArg1]> pontos de Fúria. Após o início da Batalha do Líder, compre 2 cartas. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da Imagem Dimensional da Criação do portador\"."
  },
  State_76285_Desc = {
    Text = "Único na equipe: Após o início da fase, ganhe <WeaponEffect_Num:[StateArg1]> pontos de energia da chave de prata. Após o início de uma Batalha do Líder, ganhe 2 pontos de poder de cálculo. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da criação de imagem dimensional do portador\"."
  },
  State_76285_WeaponDesc = {
    Text = "Após o início da fase, ganhe <WeaponEffect_Num:[StateArg1]> pontos de s-energia. Após o início de uma batalha contra um chefe, ganhe 2 pontos de aritmética. No Capítulo Estelar, o efeito é alterado para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76286_Desc = {
    Text = "Único na equipe: Na área de descanso, uma opção adicional é oferecida: remover até 3 cartas de sintoma e ganhar <WeaponEffect_Num:[StateArg1]> pontos de marca negra. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da criação de imagem dimensional do portador\"."
  },
  State_76286_WeaponDesc = {
    Text = "No ponto de descanso, uma opção adicional é oferecida: remover até 3 cartas de sintoma e ganhar <WeaponEffect_Num:[StateArg1]> pontos de sigilo negro. No Capítulo Estelar, o efeito é alterado para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76287_Desc = {
    Text = "Equipe Única: Após o término da batalha normal, o número de gravuras selecionáveis torna-se 4, e as gravuras das cartas do portador têm <WeaponEffect_Num:[StateArg1]%> de probabilidade de serem melhoradas para gravura avançada. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da criação de imagem dimensional do portador\"."
  },
  State_76287_WeaponDesc = {
    Text = "Após o término da batalha normal, o número de selos que podem ser escolhidos torna-se 4, e há uma probabilidade de <WeaponEffect_Num:[StateArg1]%> de que os selos nas cartas do portador sejam aprimorados para selos avançados. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da criação de imagem dimensional do portador\"."
  },
  State_76288_Desc = {
    Text = "Único na equipe: Após o término da batalha, ganhe <WeaponEffect_Num:[StateArg1]> pontos de energia de chave de prata. No Capítulo Estelar, o efeito é alterado para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76288_WeaponDesc = {
    Text = "Após o término da batalha, ganhe <WeaponEffect_Num:[StateArg1]> pontos de energia de chave de prata. No Capítulo Estelar, o efeito é alterado para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76289_Desc = {
    Text = "Equipe Única: Durante a exploração, +1 no campo de visão. Após abrir completamente o mapa, ganhe <WeaponEffect_Num:[StateArg1]> pontos de Marca Negra. No início da Batalha do Líder, aplique <WeaknessIconKeywords:Fraqueza> e <VulnerabilityIconKeywords:Vulnerável> a todos os inimigos por 1 turno. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da Imagem Dimensional do portador\"."
  },
  State_76289_WeaponDesc = {
    Text = "Campo de visão +1 durante a exploração. Após abrir completamente o campo de visão do mapa, ganhe <WeaponEffect_Num:[StateArg1]> pontos de Marca Negra. No início da Batalha do Líder, aplique <WeaknessIconKeywords:fraqueza> e <VulnerabilityIconKeywords:vulnerável> a todos os inimigos por 1 turno. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da Imagem Dimensional do portador\"."
  },
  State_76290_Desc = {
    Text = "Único na equipe: Após o término da batalha normal, é possível optar por liberar a gravura, aumentando o limite de vida em <WeaponEffect_Num:[StateArg1]%. Esse efeito pode ser aplicado no máximo 2 vezes. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76290_WeaponDesc = {
    Text = "Após o término da batalha normal, é possível escolher liberar a gravura, aumentando o limite de vida em <WeaponEffect_Num:[DescArg1]>. Este efeito pode ser ativado no máximo 2 vezes. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76291_Desc = {
    Text = "Único na equipe: Após o início da fase, ganhe <WeaponEffect_Num:[StateArg1]> pontos de sigilo negro. Limite de relíquias +2. No Capítulo Estelar, o efeito é alterado para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76291_WeaponDesc = {
    Text = "Após o início da fase, ganhe <WeaponEffect_Num:[StateArg1]> pontos de sigilo negro. Limite de relíquias +2. No Capítulo Estelar, o efeito é alterado para \"aumentar em 100% a chance de surgimento da relíquia de imagem dimensional do portador\"."
  },
  State_76292_Desc = {
    Text = "Único na equipe: No local de venda de marcas, é permitido vender cartões de sintomas, e ao vender o cartão de sintomas, ganha-se <WeaponEffect_Num:[StateArg1]> pontos de marca negra. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da criação de imagem dimensional do portador\"."
  },
  State_76292_WeaponDesc = {
    Text = "Na loja de venda de marcas de fusão, é permitido vender cartões de sintomas, e ao vender cartões de sintomas, você ganha <WeaponEffect_Num:[StateArg1]> pontos de marca negra. No Capítulo das Estrelas, o efeito é alterado para \"aumentar em 100% a chance de surgimento da criação de imagem dimensional do portador\"."
  },
  State_76321_Name = {
    Text = "Lente prismática"
  },
  State_76323_Name = {
    Text = "Harmonia Furiosa"
  },
  State_76324_Name = {
    Text = "Ajuste de potência de cálculo"
  },
  State_76325_Desc = {
    Text = "Após jogar [DescArg1] cartas de comando, entre no estado de \"harmonização da aritmética\"."
  },
  State_76325_Name = {
    Text = "Ajuste de potência de cálculo"
  },
  State_76326_Name = {
    Text = "Existe paradoxo"
  },
  State_76328_Name = {
    Text = "Cono de luz do destino"
  },
  State_76337_Name = {
    Text = "Cicatriz sem fundo"
  },
  State_76338_Desc = {
    Text = "O jogador recebe [Layer]% menos cura."
  },
  State_76338_Name = {
    Text = "Cicatriz sem fundo"
  },
  State_76430_Name = {
    Text = "Imagem da Dimensão · Lily"
  },
  State_76433_Name = {
    Text = "Ajuste de potência de cálculo"
  },
  State_76434_Desc = {
    Text = "Sempre que jogar uma carta de comando, se for consumida aritmética adicional devido à harmonização de aritmética, ganhe adicionalmente 100% da s-energia da recarga de chave de prata do despertador. Acumulável."
  },
  State_76434_Name = {
    Text = "Ajuste de potência de cálculo"
  },
  State_76435_Name = {
    Text = "Lente prismática"
  },
  State_76528_Name = {
    Text = "Este cartão é considerado \"golpear\"."
  },
  State_76529_Desc = {
    Text = "Ao coletar, escolha uma carta de despertador, reduza seu custo de poder em 1, e após jogar, compre 1 carta, tratando-a como \"golpe\""
  },
  State_76533_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Ao equipar e no final do turno, aplique [StateArg2] camadas de <PVPAcheKeywords:Dor Oculta> às [StateArg1] cartas aleatórias na mão do inimigo."
  },
  State_76533_Name = {
    Text = "Angústia Velada"
  },
  State_76553_Desc = {
    Text = "O consumo aritmético desta carta diminui em [StateArg1]."
  },
  State_76553_Name = {
    Text = "Milhões de Olhares Amorosos"
  },
  State_77686_Name = {
    Text = "Forma Semi-Mecânica"
  },
  State_77688_Desc = {
    Text = "No início do quinto turno ou ao estar prestes a morrer, torna-se imune à morte e a intenção é ajustada para \"Ascensão Mecânica\"."
  },
  State_77688_Name = {
    Text = "Carne fraca"
  },
  State_77690_Desc = {
    Text = "Após transformar-se em \"Forma Semi-mecânica\", para cada camada de \"Fim\", ganha adicionalmente 10% de vida máxima. Enquanto estiver em \"Forma Semi-mecânica\", \"Fusão·Doll\" lançará habilidades mais ameaçadoras conforme aumenta o número de camadas de \"Fim\"."
  },
  State_77690_Name = {Text = "Fim"},
  State_77692_Desc = {
    Text = "No final do turno, invoque 2 criaturas corrosivas, com um máximo de 2 existentes ao mesmo tempo. Quando uma criatura corrosiva invocada morre, \"Dor, a Derretida\" perde 5% da sua vida máxima."
  },
  State_77692_Name = {
    Text = "Porta dos Abismos"
  },
  State_77693_Desc = {
    Text = "Após a morte, \"Derretimento·Dor\" perde 5% da vida máxima."
  },
  State_77693_Name = {Text = "Fusão"},
  State_78102_Desc = {
    Text = "Dano causado reduzido em 15%, dano recebido aumentado em 30%, durando até o fim da batalha."
  },
  State_78102_Name = {
    Text = "Paralisia de overclock"
  },
  State_78694_Desc = {
    Text = "No início da batalha, ganhe [Arg1] pontos de Força. A cada [Arg2] pontos de Força permanente no início do turno, ganhe [Arg3] pontos de Força temporária, até um máximo de [Arg4] pontos de Força temporária, e ao final do turno, perca metade do escudo ganho por esta Criação devido à Força temporária."
  },
  State_78696_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, selecione [Arg1] cartas de \"Habilidade\" correspondentes ao despertado, consuma-as e embaralhe [Arg2] cópias adicionais dessas cartas consumidas no baralho de compra."
  },
  State_78697_Desc = {
    Text = "No início da rodada, são aplicadas [Arg2] camadas de veneno, e você ganha [Arg1] pontos de poder para cada espaço vazio no hiperespaço."
  },
  State_78698_Desc = {
    Text = "Limite de aritmética -[Arg1]. Ganha 1 ponto de aritmética ao jogar cada carta com custo de aritmética maior ou igual a [Arg2], com um máximo de [Arg3] ativações por turno."
  },
  State_78699_Desc = {
    Text = "Após comprar cartas, compre [Arg1] cartas extras, mas escolha [Arg2] cartas da sua mão para descartar."
  },
  State_78700_Desc = {
    Text = "Todos os despertadores têm o dano base aumentado em [Arg1]%, recebendo um aumento adicional de [Arg2]% cada vez que o baralho é redefinido, mas colocando 1 carta \"Tropeço\" na mão, com um aumento máximo de [Arg3]%."
  },
  State_78701_Desc = {
    Text = "No início do turno, se tiver mais de [Arg1] tentáculos permanentes, perca [Arg2] tentáculos e ganhe [Arg3] tentáculos temporários; caso contrário, ganhe [Arg4] tentáculos temporários."
  },
  State_78702_Desc = {
    Text = "Após o Despertar da Chave de Prata, consome adicionalmente [Arg1] pontos de energia da chave de prata, fazendo com que o custo de aritmética das cartas de Despertar da Gnosis obtidas se torne 0, e após jogá-las, o despertado correspondente ganha adicionalmente [Arg2] pontos de loucura."
  },
  State_78703_Desc = {
    Text = "No início da batalha, cause [Arg1] pontos de <IntoxicationIconKeywords:veneno> a todos os inimigos. Antes do início do turno, remova [Arg2]% do <IntoxicationIconKeywords:veneno> do inimigo e aplique <BleedingIconKeywords:sangramento> equivalente a [Arg3]% da quantidade removida."
  },
  State_78710_Desc = {
    Text = "Cada carta de comando jogada aumenta em [Arg1]% o dano final causado pelo despertador correspondente neste turno, mas faz com que ele perca [Arg2] pontos de loucura, podendo ser ativado no máximo [Arg3] vezes por turno."
  },
  State_78712_Desc = {
    Text = "No início do turno, o nível de Fusão de embriões aumenta +[Arg1]. Seu embrião será descartado no final do turno."
  },
  State_78713_Desc = {
    Text = "Ao iniciar o turno, ganhe [Arg1] pontos de contra-ataque. Após liberar a exaltação [Arg2] vezes em um único turno, remova [Arg3]% do seu contra-ataque permanente e ganhe um contra-ataque temporário equivalente a [Arg4]% da quantidade removida. Recarrega em [Arg5] turnos."
  },
  State_78781_Desc = {
    Text = "Redução temporária da força do alvo, ganhe uma quantidade igual de força temporária."
  },
  State_78781_Name = {
    Text = "<TouquKeywords: roubar>"
  },
  State_79405_Desc = {
    Text = "Após jogar, aumente em 1 a \"Lembrança de Qingming\". Ao atingir 10, bloqueie-a por 1 turno e ganhe 3 \"inspirações\". No início do próximo turno, redefina para 5."
  },
  State_79405_Name = {
    Text = "O Passado Real"
  },
  State_79406_Desc = {
    Text = "Após jogar, reduza em 1 a \"Lembrança de Qingming\". Quando atingir 0, bloqueie-a por 1 turno e todos os Despertadores ganham 30 pontos de Loucura. No início do próximo turno, redefina para 5."
  },
  State_79406_Name = {
    Text = "Sonho Falso e Luxuoso"
  },
  State_80052_Desc = {Text = "Teste"},
  State_80052_Name = {Text = "Teste 123"},
  State_80052_WeaponDesc = {Text = "Teste"},
  State_80161_Desc = {
    Text = "Equipe Única: O dano básico causado pela explosão de Fúria do portador aumenta em <WeaponEffect_Num:[StateArg1]%>, e a recarga da Chave de Prata aumenta em <WeaponEffect_Num:[StateArg2]%>. Após entrar no Turno Ultra, todos os Corpos Despertos ganham <WeaponEffect_Num:[StateArg4]> pontos de Fúria. Após liberar \"Aniquilação\", o portador ganha <WeaponEffect_Num:[StateArg3]> pontos de Fúria."
  },
  State_80161_WeaponDesc = {
    Text = "O dano básico causado pela explosão de fúria do portador aumenta em <WeaponEffect_Num:[StateArg1]%>, e a recarga da chave de prata aumenta em <WeaponEffect_Num:[DescArg1]>. Após entrar no turno ultra, todos os corpos despertos ganham <WeaponEffect_Num:[StateArg4]> pontos de fúria. Após liberar \"Aniquilação\", o portador ganha <WeaponEffect_Num:[StateArg3]> pontos de fúria."
  },
  State_80174_Desc = {
    Text = "Equipe única: O carregamento de chave de prata do portador aumenta <WeaponEffect_Num:[StateArg1]%>. Após o início da primeira batalha, aplique 1 camada de fraqueza e vulnerabilidade a todos os inimigos."
  },
  State_80174_WeaponDesc = {
    Text = "O carregamento da chave de prata do portador aumenta <WeaponEffect_Num:[DescArg1]>. Após o início da primeira batalha, aplique 1 camada de <WeaknessIconKeywords:fraqueza> e <VulnerabilityIconKeywords:vulnerabilidade> a todos os inimigos."
  },
  State_80207_Desc = {
    Text = "Se esta carta ativar \"Lançadeira Dimensional\" após ser jogada, ativa o efeito subsequente. Consumo de potência de cálculo –1 quando retirada do Espaço Hiperdimensional."
  },
  State_80207_Name = {
    Text = "<WormholeKeywords:Telecinese>"
  },
  State_80328_Desc = {
    Text = "Ela está eternamente conectada à vontade coletiva do ninho em sentimentos, cognição e tudo. O \"Sentimento Compartilhado\" pode ser transformado, pela explosão de loucura de Clemantine \"Terapia de Reconstrução da Vida\", em efeitos negativos, acumulando até 15 camadas."
  },
  State_80328_Name = {Text = "Empatia"},
  State_80331_Desc = {
    Text = "Sob a erosão da Colmeia, suas fraquezas ficam completamente expostas. Dano ativo e Dano de tentáculo recebidos neste turno aumentados em [DescArg1]%."
  },
  State_80331_Name = {
    Text = "<D13Colour:Trauma psicológico>"
  },
  State_80332_Desc = {
    Text = "Ela está eternamente conectada à vontade coletiva do ninho em sentimentos, cognição e tudo. O \"Sentimento Compartilhado\" pode ser transformado, pela explosão de loucura de Clemantine \"Terapia de Reconstrução da Vida\", em efeitos negativos, acumulando até 10 camadas."
  },
  State_80332_Name = {Text = "Empatia"},
  State_80335_Desc = {
    Text = "Sob a erosão da Colmeia, suas fraquezas ficam completamente expostas. Dano ativo e Dano de tentáculo recebidos neste turno aumentados em [DescArg1]%."
  },
  State_80335_Name = {
    Text = "<D13Colour:Trauma psicológico>"
  },
  State_80336_Desc = {
    Text = "Sob a erosão da Colmeia, seus medos ficam expostos. Dano ativo e Dano de tentáculo causados neste turno reduzidos em [DescArg1]%."
  },
  State_80336_Name = {
    Text = "<D13Colour:Fixação Fóbica>"
  },
  State_80338_Desc = {
    Text = "Sob a erosão da Colmeia, seus medos ficam expostos. Dano ativo e Dano de tentáculo causados neste turno reduzidos em [DescArg1]%."
  },
  State_80338_Name = {
    Text = "<D13Colour:Fixação Fóbica>"
  },
  State_80575_Desc = {
    Text = "Após sofrer dano ativo ou dano de tentáculo, remova uma quantidade equivalente de \"Cinzas Antigas\" e perca 300% da quantidade removida em vida. Ao sofrer outros tipos de dano, remova apenas metade. As camadas de \"Cinzas Antigas\" são redefinidas a cada turno."
  },
  State_80575_Name = {
    Text = "Cinzas antigas"
  },
  State_80644_Name = {
    Text = "Estado@Luz da Transcendência"
  },
  State_80773_Desc = {
    Text = "Efeito de STR ▼ sofrido –50%. Durante o próprio turno, Dano não ativo e Dano de tentáculo recebidos +100%."
  },
  State_80773_Name = {
    Text = "Anticorpo extradimensional"
  },
  State_80774_Desc = {
    Text = "Após sofrer dano ativo ou dano de tentáculo, remova uma quantidade equivalente de \"Cinzas Antigas\" e perca 300% da quantidade removida em vida. Ao sofrer outros tipos de dano, remova apenas metade. As camadas de \"Cinzas Antigas\" são redefinidas a cada turno. Após a remoção total de \"Cinzas Antigas\", ganhe 50 camadas de \"Reforço\"."
  },
  State_80774_Name = {
    Text = "Cinzas antigas"
  },
  State_80777_Desc = {
    Text = "Ao início da batalha, reduz a taxa crítica de todos os despertados em 10%. Após a morte, outros aliados ganham [DescArg1] pontos de poder e [DescArg2] camadas de \"Cinzas Antigas\"."
  },
  State_80777_Name = {
    Text = "Empatia do Enxame: Legado"
  },
  State_80778_Desc = {
    Text = "Após a morte, outros aliados ganham 1 pilha de \"Loucura Temporária\"."
  },
  State_80778_Name = {
    Text = "Hive Empatia: Fusão"
  },
  State_80782_Desc = {
    Text = "Nesta batalha, a taxa crítica de todos os despertos diminui em [Layer]%."
  },
  State_80782_Name = {
    Text = "Taxa de Crítico Reduzida"
  },
  State_80783_Desc = {
    Text = "No fim do turno, ganhe 1 acúmulo de \"Loucura.\""
  },
  State_80783_Name = {
    Text = "Vínculo de Sangue"
  },
  State_80784_Desc = {
    Text = "Quando a vida ficar abaixo de 50%, invoque um \"Primeiro Mutante\" atrás de você. Pode ser ativado apenas uma vez por batalha."
  },
  State_80784_Name = {
    Text = "Empatia do Enxame: Fissão"
  },
  State_80785_Desc = {
    Text = "Força reduzida tem apenas 50% de efeito sobre este inimigo. Cada vez que você libera uma Fúria Explosiva, ganha 1 pilha de \"Loucura Temporária\"."
  },
  State_80785_Name = {
    Text = "Empatia do Enxame: Dimensão"
  },
  State_80788_Desc = {
    Text = "Força reduzida tem apenas 25% de efeito sobre este inimigo. Cada vez que você libera uma Fúria Explosiva, ganha 1 pilha de \"Loucura Temporária\"."
  },
  State_80788_Name = {
    Text = "Empatia do Enxame: Dimensão"
  },
  State_80789_Desc = {
    Text = "Dano ativo e Dano de tentáculo recebidos +100%, por 1 turno."
  },
  State_80789_Name = {
    Text = "hibernação"
  },
  State_80790_Desc = {
    Text = "Após a transformação, cada camada do poder etéreo cósmico se aperfeiçoará..."
  },
  State_80790_Name = {
    Text = "Energia Cósmica"
  },
  State_80792_Desc = {
    Text = "Sempre que você libera uma Fúria Explosiva, ganha 1 pilha de \"Loucura Temporária\"."
  },
  State_80792_Name = {
    Text = "Empatia do Enxame: Dimensão"
  },
  State_80794_Desc = {
    Text = "A carta não pode ser jogada e permanece na mão até o final do turno."
  },
  State_80794_Name = {
    Text = "<Boundkeywords:Atar>"
  },
  State_80807_Desc = {
    Text = "No início do quinto turno ou ao estar prestes a morrer, remova todos os outros inimigos e mude a intenção para \"Momento da Metamorfose\"."
  },
  State_80807_Name = {
    Text = "Momento de Metamorfose"
  },
  State_80809_Desc = {
    Text = "No final do turno, as cartas com ilusão na mão serão descartadas."
  },
  State_80809_Name = {
    Text = "<PVPVoidKeyColour:Nada>"
  },
  State_80810_Desc = {
    Text = "Após sofrer dano ativo ou dano de tentáculo, remova uma quantidade equivalente de \"Cinzas Antigas\" e perca 300% da quantidade removida em vida. Ao sofrer outros tipos de dano, remova apenas metade. As camadas de \"Cinzas Antigas\" são redefinidas a cada turno."
  },
  State_80810_Name = {
    Text = "Cinzas antigas"
  },
  State_80827_Desc = {
    Text = "A cada 15 cartas jogadas, substitua a intenção atual por \"Golpe Traumático\" (restam [Layer] cartas)."
  },
  State_80827_Name = {
    Text = "Castigo irado"
  },
  State_81022_WeaponDesc = {
    Text = "Cada dano recebido aumenta a loucura de todos os despertos em 1"
  },
  State_81027_Desc = {
    Text = "O dono desta carta é \"Insectoide\", Consumo de potência de cálculo -1, consumida após ser jogada."
  },
  State_81027_Name = {
    Text = "Rito de Vida"
  },
  State_81054_Desc = {
    Text = "Sob a erosão da Colmeia, seus medos são expostos. Para cada capa, Dano ativo e Dano de tentáculo causados neste turno -3%, acumulando até 15 capas."
  },
  State_81054_Name = {
    Text = "<D13AFKeyWordQ1:Fixação Fóbica>"
  },
  State_81055_Desc = {
    Text = "Sob a erosão da Colmeia, seus medos são expostos. Para cada capa, Dano ativo e Dano de tentáculo recebidos neste turno +3%, acumulando até 10 capas."
  },
  State_81055_Name = {
    Text = "<D13AFKeyWord2:Trauma psicológico>"
  },
  State_81056_Desc = {
    Text = "Sob a erosão da Colmeia, seus medos são expostos. Para cada capa, Dano ativo e Dano de tentáculo recebidos neste turno +3%, acumulando até 15 capas."
  },
  State_81056_Name = {
    Text = "<D13AFKeyWordQ2:Trauma psicológico>"
  },
  State_81057_Desc = {
    Text = "Sob a erosão da Colmeia, seus medos são expostos. Para cada capa, Dano ativo e Dano de tentáculo causados neste turno -3%, acumulando até 10 capas."
  },
  State_81057_Name = {
    Text = "<D13AFKeyWord1:Fixação Fóbica>"
  },
  State_81058_Desc = {
    Text = "Ela está eternamente conectada à vontade coletiva do ninho em sentimentos, cognição e tudo. O \"Sentimento Compartilhado\" pode ser transformado, pela explosão de loucura \"Terapia de Reconstrução da Vida\" de Clemantine, em efeitos negativos, acumulando até 15 camadas."
  },
  State_81058_Name = {
    Text = "<AnalysisKeywords3:Ressonância>"
  },
  State_81059_Desc = {
    Text = "Ela está eternamente conectada à vontade coletiva do ninho em sentimentos, cognição e tudo. O \"Sentimento Compartilhado\" pode ser transformado, pela explosão de loucura de Clemantine \"Terapia de Reconstrução da Vida\", em efeitos negativos, acumulando até 10 camadas."
  },
  State_81059_Name = {
    Text = "<AnalysisKeywords0:Ressonância>"
  },
  State_81073_Desc = {
    Text = "Após receber dano fatal, recupera imediatamente toda a vida e ganha 80% de reforço temporário. Invoca um \"Primeiro Mutante\" atrás de você, pode ser ativado 2 vezes."
  },
  State_81073_Name = {
    Text = "Empatia do Enxame: Fissão"
  },
  State_81278_Desc = {
    Text = "A primeira vez em cada turno que um bando é liberado, todos os despertadores ganham 10 aliemus, mas o custo da liberação aumenta permanentemente em 10%"
  },
  State_81278_Name = {
    Text = "Inibição de Chave de Prata"
  },
  State_81312_Desc = {
    Text = "Após receber dano fatal, recupere toda a vida e ganhe 50 camadas de reforçado temporário. Também pode ser ativado [Layer] vezes."
  },
  State_81312_Name = {
    Text = "Reencarnação Cósmica"
  },
  State_81331_Desc = {
    Text = "No início do turno, escolha 1 Despertado e sela todos os seus cartões e surto de loucura por 3 turnos."
  },
  State_81331_Name = {
    Text = "Confinamento de Consciência"
  },
  State_81340_Desc = {
    Text = "Esta carta está selada e não pode ser jogada; o selo será removido após [Layer] turnos."
  },
  State_81340_Name = {
    Text = "<Seal1:Selo de Carta>"
  },
  State_81341_Desc = {
    Text = "Este Corpo Despertado tem sua exaltação da loucura selada e não pode ser utilizada. O selo será removido após [Layer] turnos."
  },
  State_81341_Name = {
    Text = "<Seal1:Selo da Fúria>"
  },
  State_81354_Desc = {
    Text = "Jogue para sofrer [DescArg1] de dano. Se não for jogada até o final do turno, será consumida."
  },
  State_81354_Name = {
    Text = "<BurningKeywords:Queimar>"
  },
  State_81356_Desc = {
    Text = "Torna a carta em chamas. Após jogá-la, sofre [DescArg1] de dano. Se ainda estiver na mão no final do turno, será consumida."
  },
  State_81356_Name = {
    Text = "<BurningKeywords:Queimar>"
  },
  State_81356_WeaponDesc = {
    Text = "Cada camada de lentidão aumenta o custo de aritmética das cartas em 1 ponto"
  },
  State_83587_Desc = {
    Text = "Podem aumentar o efeito ao selecionar \"Zarpar\", limite de 10 camadas."
  },
  State_83587_Name = {
    Text = "\"Levantar velas\""
  },
  State_83589_Desc = {
    Text = "Podem aumentar o efeito ao selecionar \"Pausa na Costa\", limite de 10 camadas."
  },
  State_83589_Name = {Text = "\"Ancorar\""},
  State_83593_Desc = {
    Text = "Neste turno, o dano final causado por todos os despertos aumenta"
  },
  State_83593_Name = {Text = "Dano Final"},
  State_83596_Desc = {
    Text = "Limite de cartas +1. No início do turno, se \"Decisão do Piloto\" não estiver no baralho, coloque-a na mão. Sempre que o chefe perder 10% da vida máxima, ganhe 1 camada de \"Içar Velas\"; sempre que você perder 10% da sua vida máxima, ganhe 1 camada de \"Âncora\"."
  },
  State_83596_Name = {
    Text = "Orientação de Erasmo - \"Levantar a vela\""
  },
  State_83607_Desc = {
    Text = "Marcador de perda acumulada de 10% da vida do chefe"
  },
  State_83607_Name = {
    Text = "Estado@Marcador de perda acumulada de 10% da vida do chefe"
  },
  State_83609_Desc = {
    Text = "Marcador de perda de 10% da vida do jogador"
  },
  State_83609_Name = {
    Text = "Estado@Marcador de perda acumulada de 10% da vida do jogador"
  },
  State_83614_Desc = {
    Text = "Jogador com 10% da vida restante"
  },
  State_83614_Name = {
    Text = "Estado@Jogador com 10% da vida"
  },
  State_83615_Desc = {
    Text = "Após perder [Layer] pontos de vida, ganhe 1 camada de \"Içar Velas\"."
  },
  State_83615_Name = {
    Text = "Progresso de \"Levantar Velas\""
  },
  State_83616_Desc = {
    Text = "Perder [Layer] pontos de vida, ganhar 1 camada de \"Âncora\"."
  },
  State_83616_Name = {
    Text = "Progresso de \"Ancoragem\""
  },
  State_83617_Desc = {
    Text = "10% da vida do chefe"
  },
  State_83617_Name = {
    Text = "Estado@Chefe com 10% da vida"
  },
  State_83618_Desc = {
    Text = "Durante o teste, a vida atual é [Layer]."
  },
  State_83618_Name = {
    Text = "Contagem de vida atual do inimigo"
  },
  State_83619_Desc = {
    Text = "Durante o teste, a saúde máxima será de [Layer] pontos."
  },
  State_83619_Name = {
    Text = "Contagem da saúde máxima do inimigo"
  },
  State_83620_Desc = {
    Text = "O valor atual do parâmetro 4 multiplicado por 100 é [Layer] pontos."
  },
  State_83620_Name = {
    Text = "Parâmetro de impressão"
  },
  State_83621_Desc = {
    Text = "Valor intermediário da contagem de perda de 10% da vida do chefe"
  },
  State_83621_Name = {
    Text = "Estado@Valor intermediário da contagem de perda de 10% da vida do chefe"
  },
  State_83622_Desc = {
    Text = "Valor intermediário da contagem de perda de 10% da vida do jogador"
  },
  State_83622_Name = {
    Text = "Estado@Valor intermediário da contagem de perda de 10% da vida do jogador"
  },
  State_83627_Desc = {
    Text = "Perder [DescArg1] pontos de vida, ganhar 1 camada de \"Içar Velas\""
  },
  State_83627_Name = {
    Text = "Progresso de \"Levantar Velas\""
  },
  State_83805_Name = {Text = "Réplica"},
  State_83807_Name = {
    Text = "Afundado no mar distante"
  },
  State_83808_Desc = {
    Text = "Quando esta carta for descartada, ativa o efeito \"ressaca\"."
  },
  State_83808_Name = {
    Text = "<RippleKeywords:Réplica>"
  },
  State_83811_Desc = {
    Text = "Dano de tentáculo recebido adicional de [Layer]%."
  },
  State_83812_Desc = {
    Text = "Dano de tentáculo recebido adicional de [Layer]%."
  },
  State_83814_Desc = {
    Text = "10% da vida do chefe"
  },
  State_83814_Name = {
    Text = "Chefe com 10% da saúde"
  },
  State_84140_Desc = {
    Text = "Nesta batalha, [Layer] cartas de \"divisão glandular\" foram exauridas através de \"Oceano barulhento\"."
  },
  State_84140_Name = {
    Text = "Mar Agitado"
  },
  State_84184_Name = {
    Text = "O bônus adicional desta habilidade recebe um aumento de [Layer]% em força"
  },
  State_84255_Desc = {
    Text = "Único na equipe: Ao início da batalha, ganha um escudo equivalente a <WeaponEffect_Num:[StateArg1]%> da defesa do portador. Após ativar a Resistência à Morte, ative esse efeito novamente no início do próximo turno."
  },
  State_84255_Name = {
    Text = "Navegador no Mar"
  },
  State_84255_WeaponDesc = {
    Text = "Ao início da batalha, ganha <WeaponEffect_Num:[Block:DescArg1]> pontos de escudo. Após ativar a Resistência à Morte, ative esse efeito novamente no início do próximo turno."
  },
  State_84257_Desc = {
    Text = "Equipe Única: O escudo causado pela Fúria Explosiva do portador aumenta em <WeaponEffect_Num:[StateArg1]%>, após liberar a Fúria Explosiva, todos os Corpos Despertos têm seu Dano Crítico Temporário aumentado em <WeaponEffect_Num:[StateArg2]%, e a cada tentáculo adicional, aumenta em 1%. Após a primeira ativação da Resistência à Morte em cada exploração, no início do próximo turno, recupera <WeaponEffect_Num:[StateArg3]%> da Vida máxima."
  },
  State_84257_WeaponDesc = {
    Text = "O escudo causado pela explosão de fúria do portador aumenta em <WeaponEffect_Num:[StateArg1]%>, após liberar a explosão de fúria, o dano crítico temporário de todos os corpos despertos aumenta em <WeaponEffect_Num:[StateArg2]%, aumentando 1% para cada tentáculo adicional. Após a primeira ativação da resistência à morte durante a exploração, no início da próxima rodada, recupera <WeaponEffect_Num:[StateArg3]%> da vida máxima."
  },
  State_84272_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No final do turno, cura o aliado com mais vida perdida em <Heal:[Heal:StateArg1]>."
  },
  State_84272_Name = {
    Text = "Navegador no Mar"
  },
  State_84273_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Ao equipar e no início do turno, se não tiver <PVPProtectiveKeywords:barreira>, ganhe [StateArg1] camadas de <PVPProtectiveKeywords:barreira>, caso contrário, ganhe <Energy:[Energy:StateArg2]> Loucura."
  },
  State_84273_Name = {
    Text = "Navegador Flamenjante"
  },
  State_84364_Desc = {
    Text = "Dano Crítico +[Layer]%"
  },
  State_84364_Name = {
    Text = "Dano crítico"
  },
  State_84368_Desc = {
    Text = "Resfriamento por [Layer] turnos restantes."
  },
  State_84368_Name = {
    Text = "Afundado no mar distante"
  },
  State_84375_Desc = {
    Text = "No início do turno, ganhe [Layer] pontos de escudo."
  },
  State_84375_Name = {
    Text = "Navegador no Mar"
  },
  State_84376_Desc = {
    Text = "No início do turno, recupere [Layer] pontos de vida."
  },
  State_84376_Name = {
    Text = "Navegador Flamenjante"
  },
  State_84399_Desc = {
    Text = "No final de cada turno, o dano recebido aumenta em 5%, e o personagem ganha 2 camadas de barreira."
  },
  State_84399_Name = {
    Text = "Afundado no mar distante"
  },
  State_84400_Desc = {
    Text = "No início do próximo turno, converta cada camada de barreira em 1 camada de <ReinforcePVEKeywords:reforçado>."
  },
  State_84400_Name = {
    Text = "\"Navegação\""
  },
  State_84402_Desc = {
    Text = "Dano recebido aumentado em [Layer]%."
  },
  State_84402_Name = {
    Text = "Força de sobregiro"
  },
  State_89340_Desc = {
    Text = "Dano de tentáculo recebido adicional de [Layer]%."
  },
  State_89340_Name = {
    Text = "Tentáculo vulnerável"
  },
  State_89422_Desc = {
    Text = "A loucura gerada por todos os despertos aumenta em 100%, e eles podem liberar a explosão de loucura duas vezes por turno."
  },
  State_89422_Name = {
    Text = "\"Coração Indomável\""
  },
  State_89447_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Limite de cartas na mão +[StateArg2]. Ganhe [StateArg1] Poder de cálculo após \"Fúria Explosiva\"."
  },
  State_89447_Name = {
    Text = "Liberdade Inquebrável"
  },
  State_89448_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No final do turno, o aliado com menos HP e Escudo ganhará [StateArg1] <PVPDerivativeCardKeywords_16:\"Pluma de Ônix\">."
  },
  State_89448_Name = {
    Text = "Pena Solitária"
  },
  State_89554_Name = {
    Text = "Cono de luz do destino"
  },
  State_89555_Desc = {
    Text = "Equipe Única: Após o Portador liberar a Fúria Explosiva, Dano básico da Fúria Explosiva +<WeaponEffect_Num:[StateArg1]%>, Escudo do personagem e Recuperar vida +<WeaponEffect_Num:[StateArg2]%>, acumulando até 5 vezes. Durante a exploração, a Taxa de Sincronização obtida pelo Portador +<WeaponEffect_Num:[StateArg3]%>."
  },
  State_89555_WeaponDesc = {
    Text = "Após liberar a Fúria Explosiva, o dano básico da Fúria Explosiva aumenta em <WeaponEffect_Num:[StateArg1]%>, e a recuperação de escudo e vida aumenta em <WeaponEffect_Num:[StateArg2]%>, acumulando até 5 vezes. Após completar a exploração, a Taxa de Sincronização obtida pelo portador aumenta em <WeaponEffect_Num:[StateArg3]%>."
  },
  State_89557_Name = {
    Text = "Lente prismática"
  },
  State_89559_Desc = {
    Text = "\n·Paradoxo Existencial: No início da exploração, 75% da resistência à morte é convertida em bônus de vida máxima, convertendo no máximo 300% de resistência à morte e aumentando no máximo 10% da vida máxima. Cada vez que a resistência à morte for ativada, coloca adicionalmente 1 carta「Brilho da Chave de Prata」na mão.\n·Cicatriz Sem Fundo: Durante batalhas contra chefes, a cada vez que a quantidade de recuperação de vida recebida pela equipe atingir 100% do limite de vida, o efeito de recuperação de vida subsequente é reduzido em 25%, mas o total atual de resistência à morte aumenta em 25%, podendo ser ativado no máximo 3 vezes.\n·Lente Prismática: No início do turno, se a contra-ofensiva ultrapassar 2000% do limite de vida, os acúmulos excedentes são reduzidos à metade, e a contra-ofensiva permanente pode acumular no máximo 6000% do limite de vida; se o envenenamento do inimigo ultrapassar 3000% do limite de vida, os acúmulos excedentes são reduzidos à metade, e o envenenamento pode acumular no máximo 9000% do limite de vida. O bônus de dano obtido pelos Despertos com base na contra-ofensiva é reduzido em 70%, mas todo envenenamento e contra-ofensiva causados aumentam em 10%. A cada Desperto que desperta: ao final do turno, obtém contra-ofensiva temporária equivalente a 25% da contra-ofensiva permanente atual; ao final do turno inimigo, ativa adicionalmente 25% do envenenamento de todos os inimigos.\n·Cone de Luz do Destino: O número de turnos em que monstros comuns usam「Olhar Fixo」muda para 6 turnos. No início do 15º turno, coloca 1 carta「Limite do Cone de Luz」na mão: preenche a energia da Chave de Prata e a loucura de todos os Despertos ao valor máximo."
  },
  State_89559_Name = {
    Text = "Distorção espaço-temporal"
  },
  State_89567_Desc = {
    Text = "O consumo aritmético desta carta diminui em [StateArg1]."
  },
  State_89567_Name = {
    Text = "Reencarnação na Terra Aniquilada"
  },
  State_89568_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após a morte do portador, embaralha todas as \"habilidades\" com custo aritmético -[StateArg1] do próprio no baralho de compra, alterando a posse para o aliado restante com maior vida."
  },
  State_89568_Name = {
    Text = "Reencarnação na Terra Aniquilada"
  },
  State_89571_Name = {
    Text = "\"Teatro em Chamas\""
  },
  State_89572_Desc = {
    Text = "No início do turno, adicione <BurningKeywords:queima> a [DescArg1] cartas aleatórias na pilha de mão do oponente e ganhe [DescArg2] pontos de força temporária. A cada 2 turnos, o número de cartas com queima aumenta em 1 e a força temporária ganha aumenta em [DescArg3] pontos."
  },
  State_89572_Name = {
    Text = "\"Teatro em Chamas\""
  },
  State_89626_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, coloque 1 carta \"Brilho da Chave de Prata\" na sua mão. Após todos os despertos completarem seu despertar, no início de cada turno, receba aleatoriamente o apoio de 1 desperto."
  },
  State_89631_Desc = {
    Text = "Extra [Layer] saltos"
  },
  State_89634_Desc = {
    Text = "Despertar 4"
  },
  State_89634_Name = {
    Text = "Despertar 4"
  },
  State_89637_Desc = {
    Text = "A primeira carta de comando em cada turno toma efeito 1 vez adicional. Ao aniquilar, gera 1 tentáculo. Após mudar o tentáculo para a postura \"Onda de Ira\", os efeitos de salto de 2 cartas de comando neste turno ativam obrigatoriamente e entram no Espaço Hiperdimensional, com 3 turnos de cooldown."
  },
  State_89640_Desc = {
    Text = "Maestria em Domínios aumenta em 200 pontos. Ao consumir a fornalha carmesim, aumenta o dano dos tentáculos em 15% da quantidade consumida. A cada ataque de tentáculo, acumula [Arg3] pontos de recuperação da fornalha carmesim."
  },
  State_89642_Desc = {
    Text = "Limite de cartas na mão +2, após liberar Fúria Explosiva, o Dano Final aumenta temporariamente em 10%. Quando a carta entra no Espaço Hiperdimensional, 1 \"embrião\" na mão é transformado em \"Filho da santidade\". Para cada \"embrião\" gerado, o consumo de poder de cálculo de uma carta aleatória no Espaço Hiperdimensional diminui em 1."
  },
  State_89669_Desc = {
    Text = "Despertar da Chave de Prata 4"
  },
  State_89669_Name = {
    Text = "Despertar da Chave de Prata 4"
  },
  State_89759_Desc = {
    Text = "Após liberar a chave, Ramona ganha 50% de taxa crítica temporária."
  },
  State_89759_Name = {
    Text = "Vínculo Precioso"
  },
  State_90023_Name = {
    Text = "Estado utilizado na configuração da tabela de constantes, temporariamente abandonado."
  },
  State_90059_Desc = {
    Text = "Neste turno, ao receber Dano ativo ou Dano de tentáculo, remove Corrosão em quantidade igual e perde [DescArg1]% de Vida equivalente à quantidade removida. Ao receber outros tipos de Dano, remove Corrosão equivalente a 50% do Dano recebido."
  },
  State_90059_Name = {Text = "Corrosão"},
  State_90094_Name = {
    Text = "Pluma Negra"
  },
  State_90218_Desc = {
    Text = "Equipe Única: Limite de cartas na mão +2, efeitos similares não se acumulam. O escudo e o dano básico causados pelo portador aumentam em <WeaponEffect_Num:[StateArg1] %>, e ao entrar no Turno Ultra, ganha <WeaponEffect_Num:[StateArg2]> pontos de Fúria. Após liberar \"Aniquilação\", todos os Corpos Despertos recebem Dano Crítico Temporário +<WeaponEffect_Num:[StateArg3] %>, com um tempo de recarga de 3 turnos."
  },
  State_90218_WeaponDesc = {
    Text = "Limite de cartas na mão +2, efeitos semelhantes não se acumulam. O escudo e o dano básico causados pelo portador aumentam em <WeaponEffect_Num:[StateArg1] %>, e ao entrar no Turno Ultra, ganha <WeaponEffect_Num:[StateArg2]> pontos de Fúria. Após liberar \"Aniquilação\", todos os Corpos Despertos recebem um aumento temporário de dano crítico de <WeaponEffect_Num:[StateArg3] %>, com um tempo de recarga de 3 turnos."
  },
  State_90221_Desc = {
    Text = "Equipe única: O escudo causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%>, e no final do turno, ganha um escudo equivalente a <WeaponEffect_Num:[StateArg2]%> da defesa do portador, aumentando 2% da defesa a cada turno."
  },
  State_90221_Name = {
    Text = "Pena Solitária"
  },
  State_90221_WeaponDesc = {
    Text = "O escudo causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%>, e no final do turno, ganha <WeaponEffect_Num:[Block:DescArg1]> pontos de escudo."
  },
  State_90294_Desc = {
    Text = "Neste turno, ao receber Dano ativo ou Dano de tentáculo, remove Corrosão em quantidade igual e perde [DescArg1]% de Vida equivalente à quantidade removida. Ao receber outros tipos de Dano, remove Corrosão equivalente a 50% do Dano recebido."
  },
  State_90294_Name = {
    Text = "<Corrosion:Corrosão>"
  },
  State_90591_Name = {
    Text = "Coloque [Layer] cartas de \"Inspiração\" na sua mão"
  },
  State_90594_Name = {
    Text = "e [Layer] pontos de alerta temporário"
  },
  State_90599_Name = {
    Text = "Dá [Layer] pontos de loucura a todos os Despertados"
  },
  State_90600_Name = {
    Text = "Obtenha [Layer] pontos de s-energia"
  },
  State_90601_Name = {
    Text = "(Restam [DescArg1] vezes <harmonyKeyWord:\"Harmonização\">)"
  },
  State_90603_Name = {
    Text = "Obtenha [Layer] pontos de força temporária"
  },
  State_90604_Name = {
    Text = "Restaurar [Layer] HP, aumenta com a HP perdida"
  },
  State_90696_Desc = {
    Text = "Ao jogar, descubra 1 \"tempero\", coloque-o dentro e ative seu efeito. Nas batalhas contra chefes, aumente em 1 o número de harmonizações."
  },
  State_90696_Name = {
    Text = "<harmonyKeyWord:harmonização>"
  },
  State_91106_Desc = {
    Text = "Cada camada de fervor faz com que o dano ativo e o dano de tentáculo causados incluam sangramento equivalente a 10% do dano."
  },
  State_91106_Name = {Text = "Fervor"},
  State_91165_Name = {
    Text = "Ovo Pálido"
  },
  State_91235_Desc = {
    Text = "Ao perder Vida, reduza um número igual de capas. Quando Lesão chegar a 0, todos os Corpos Despertos ganham 10 Fúria e reiniciam as capas de Lesão."
  },
  State_91235_Name = {Text = "Lesão"},
  State_91236_Name = {
    Text = "Evento Roma aplica contagem de vida do chefe"
  },
  State_91329_Desc = {
    Text = "O consumo aritmético desta carta diminui em [StateArg1]."
  },
  State_91329_Name = {
    Text = "Iguaria Macabra"
  },
  State_91521_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: No final do turno, embaralhe [StateArg1] <PVPDerivativeCardKeywords_17:\"Insight\"> na mão."
  },
  State_91521_Name = {
    Text = "Treinamento de parceiro"
  },
  State_91522_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Ao equipar e no final do turno, o Portador causa <Damage:[Damage:StateArg1]> de Dano ao inimigo na retaguarda."
  },
  State_91522_Name = {
    Text = "Dia de abertura"
  },
  State_91676_Desc = {
    Text = "Veja a lógica da greve geral para efeitos específicos. __ \"Para uso de desenvolvimento apenas\""
  },
  State_91706_Desc = {
    Text = "No início do próximo turno, ganhe aritmética equivalente ao número de camadas."
  },
  State_91706_Name = {
    Text = "<CardKeyWord:Manter Aritmética>"
  },
  State_91717_Desc = {
    Text = "Acumula no máximo 3 cadáveres. Ao atingir o limite, o próximo \"Banquete de seres vivos\" poderá consumi-los e aumentar seus efeitos. Os restos são herdados para a próxima batalha."
  },
  State_91717_Name = {Text = "Esqueleto"},
  State_91759_Desc = {
    Text = "Pluma Negra pode fortalecer a habilidade do \"Filho Santo · Pluma Negra\"."
  },
  State_91759_Name = {
    Text = "Pluma Negra"
  },
  State_91761_Desc = {
    Text = "50% do Escudo inquebrado do \"Filho do Sagrado·Pena Negra\" será retido para a próxima rodada, e após o final da rodada, ganhará 1 camada de <Guaiwuheiyu: Pena Negra>."
  },
  State_91761_Name = {
    Text = "Anseios de Voo"
  },
  State_91797_Desc = {
    Text = "Após este cartão ser jogado e descartado, aplique uma quantidade igual de camadas de escudo aos inimigos da linha da frente."
  },
  State_91797_Name = {
    Text = "<PVPredKeyword:Dor Oculta>"
  },
  State_91799_Desc = {
    Text = "Esta carta, após ser jogada, aplica [Layer] de escudo ao inimigo da linha de frente."
  },
  State_91799_Name = {
    Text = "<PVPredKeyword:Dor Oculta [Layer]>"
  },
  State_91809_Desc = {
    Text = "O consumo aritmético desta carta diminui em -[Layer]."
  },
  State_91809_Name = {
    Text = "Concentração mental"
  },
  State_91819_Desc = {
    Text = "Obtém o aprimoramento correspondente com base no turno de batalha atual."
  },
  State_91819_Name = {
    Text = "<CardKeyWord:Crescimento>"
  },
  State_91827_Desc = {
    Text = "\"Golpe\" pode escolher o alvo. Ao atacar, repele todos os estados positivos do alvo para o despertador atrás dele."
  },
  State_91827_Name = {
    Text = "<CardKeyWord:Chamado do Mar Profundo>"
  },
  State_94410_Name = {
    Text = "Sempre que o turno começar ou uma ação for concluída, será feita uma tentativa de reiniciar o baralho do jogador. Se não estiver vazio, o reinício não ocorrerá."
  },
  State_94411_Name = {
    Text = "Sempre que o turno começar ou uma ação for concluída, será feita uma tentativa de reiniciar o baralho do jogador. Se não estiver vazio, o reinício não ocorrerá."
  },
  State_94426_Name = {
    Text = "Escudo passivo"
  },
  State_94540_Desc = {
    Text = "Se não houver outros Despertos atrás do alvo, dispersa o estado positivo do alvo."
  },
  State_94540_Name = {
    Text = "<CardKeyWord:Dispersion de estado positivo>"
  },
  State_94600_Desc = {
    Text = "Após receber dano letal, remove 1 camada e restaura 5% da vida máxima; a cada ativação neste turno, o restaurado aumenta em 1%."
  },
  State_94600_Name = {
    Text = "Resistência à Morte"
  },
  State_94603_Name = {
    Text = "Marca de Ghoul"
  },
  State_94608_Name = {
    Text = "Número de ativações de Resistência à Morte"
  },
  State_94623_Desc = {
    Text = "Cada camada de fervor faz com que o dano ativo e o dano de tentáculo causados incluam sangramento equivalente a 10% do dano."
  },
  State_94623_Name = {
    Text = "<Kuangre:Frenesi>"
  },
  State_94657_Desc = {
    Text = "Ao matar ou ativar o efeito de ressurreição do inimigo, ative o efeito correspondente"
  },
  State_94657_Name = {
    Text = "<KillKeywords:Derrubar>"
  },
  State_94692_Desc = {
    Text = "Após receber dano letal, remove 1 camada e restaura 5% da vida máxima; a cada ativação neste turno, o restaurado aumenta em 1%."
  },
  State_94692_Name = {
    Text = "<Guaiwusiwangdikang: Resistência à Morte>"
  },
  State_94693_Desc = {
    Text = "No início do turno, se houver outros aliados, perca [DescArg1] pontos de vida e adicione 1 camada de <Guaiwusiwangdikang:Resistência à Morte> e [DescArg2] pontos de <PowerIconKeywords:poder> ao aliado com mais vida."
  },
  State_94693_Name = {
    Text = "Divisão do Cadáver em Decomposição"
  },
  State_94708_Desc = {
    Text = "No início do turno, se houver outros aliados, perca [DescArg1] pontos de vida e adicione 1 camada de <Guaiwusiwangdikang:Resistência à Morte> e [DescArg2] pontos de <Duren:Lâmina Venenosa> ao aliado com mais vida."
  },
  State_94708_Name = {
    Text = "Divisão do Mar Profundo"
  },
  State_94730_Desc = {
    Text = "Causar dano ativo que não é bloqueado, aplicar [Layer] pontos de <IntoxicationIconKeywords:veneno>."
  },
  State_94730_Name = {
    Text = "Lâmina Venenosa"
  },
  State_94993_Desc = {
    Text = "Reseta o número de vezes da Maré Furiosa Estonteante a cada turno."
  },
  State_94993_Name = {
    Text = "Redefinir contagem da Maré Furiosa Estonteante"
  },
  State_94994_Desc = {
    Text = "Cada camada adiciona 1 ataque, perde 1 camada ao sofrer dano crítico, mínimo de 1 camada, perde todas no fim do turno."
  },
  State_94994_Name = {
    Text = "Número de vezes da Maré Furiosa Estonteante"
  },
  State_94995_Desc = {
    Text = "Cada vez que sofrer dano crítico, ganhe 3% de <Baojidikang:Resistência a golpes críticos Temporária>. Cada dano causado adiciona \"Marca de Mergulho Profundo\" a uma carta aleatória."
  },
  State_94995_Name = {
    Text = "Cerimônia de sacrifício no mar profundo"
  },
  State_94996_Desc = {
    Text = "Ao ser atacado, ganha camadas equivalentes de força temporária."
  },
  State_94996_Name = {Text = "Fúria"},
  State_94997_Desc = {
    Text = "Cada vez que sofrer dano crítico, ganhe 5% de <Baojidikang:Resistência a golpes críticos Temporária>. Cada dano causado adiciona \"Marca de Mergulho Profundo\" a uma carta aleatória."
  },
  State_94997_Name = {
    Text = "Cerimônia de sacrifício no mar profundo"
  },
  State_94998_Desc = {
    Text = "Quando <Guaiwusiwangdikang: Resistência à Morte> é acionada, aplica <SlowIconKeywords:atraso> em uma carta aleatória do baralho ou da mão."
  },
  State_94998_Name = {
    Text = "Encarnação do Desespero"
  },
  State_94999_Desc = {
    Text = "Reseta o número de Maremoto Devora-Céus a cada turno."
  },
  State_94999_Name = {
    Text = "Maremoto Devora-Céus - Reiniciar Número de Vezes"
  },
  State_95000_Desc = {
    Text = "Imune a estados negativos."
  },
  State_95000_Name = {
    Text = "Imune a estados negativos"
  },
  State_95001_Desc = {
    Text = "Cada camada adiciona 1 ataque, perde 1 camada ao sofrer dano crítico, mínimo de 1 camada, perde todas no fim do turno."
  },
  State_95001_Name = {
    Text = "Maremoto Devora-Céus Número de Vezes"
  },
  State_95002_Desc = {
    Text = "Neste turno, a probabilidade de receber um crítico diminui [Layer]%."
  },
  State_95002_Name = {
    Text = "Resistência a Crítico Temporária"
  },
  State_95002_WeaponDesc = {
    Text = "Neste turno, a probabilidade de receber um crítico diminui [Layer]%."
  },
  State_95035_Desc = {
    Text = "Ao causar dano ativo que não é bloqueado, aplique 1 ponto de <IntoxicationIconKeywords:veneno> para cada camada."
  },
  State_95035_Name = {
    Text = "<Duren: Lâmina Envenenada>"
  },
  State_95038_Desc = {
    Text = "Ao ser atacado, ganha camadas equivalentes de força temporária."
  },
  State_95038_Name = {
    Text = "<Kuangbao: Fúria>"
  },
  State_95040_Desc = {
    Text = "Registre a vida perdida"
  },
  State_95040_Name = {
    Text = "Registre a vida perdida"
  },
  State_95932_Name = {
    Text = "Sucção de Ghoul - Aguarde"
  },
  State_95937_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após \"Fúria Explosiva\", compre [StateArg1] cartas, priorizando \"habilidades\" próprias, e reduza o consumo de potência de cálculo delas em [StateArg2]."
  },
  State_95937_Name = {
    Text = "Iguaria Macabra"
  },
  State_95938_Desc = {
    Text = "Para cada carta removida, aumente 1 camada de saciedade. Limite máximo: 10 camadas"
  },
  State_95938_Name = {Text = "Saciamento"},
  State_95943_Desc = {
    Text = "Dano causado reduzido temporariamente em 30%."
  },
  State_95943_Name = {
    Text = "Interferência positiva"
  },
  State_95944_Desc = {
    Text = "Equipe Única: O dano básico causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%>, a cada eliminação, a taxa de crítico do portador aumenta em 2% durante esta exploração, e o dano básico da Fúria Explosiva aumenta em <WeaponEffect_Num:[StateArg2]%, até um máximo de 10 vezes. Se o domínio atual for \"Carne e sangue\", ao usar \"embrião\" diretamente no portador, ganha <WeaponEffect_Num:[StateArg4]> pontos de Fúria, com um tempo de recarga de 3 turnos."
  },
  State_95944_WeaponDesc = {
    Text = "O dano básico causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%>, e a cada eliminação, a taxa de crítico do portador aumenta em 2% durante esta exploração, além disso, o dano básico da Fúria Explosiva aumenta em <WeaponEffect_Num:[StateArg2]>, acumulando até 10 vezes. Se o domínio atual for \"Carne e sangue\", ao usar \"embrião\" diretamente no portador, ganha adicionalmente <WeaponEffect_Num:[StateArg4]> pontos de Fúria, com um tempo de recarga de 3 rodadas."
  },
  State_95948_Name = {
    Text = "Sugador de Morto-Vivo"
  },
  State_95949_Desc = {
    Text = "Jogue e faça com que Durexian perca metade da vida, transformando-se em <Guaiwucanhai:destroços>."
  },
  State_95949_Name = {
    Text = "Reserva de emboscada"
  },
  State_95953_Desc = {
    Text = "O efeito de recuperação de vida da Resistência à Morte é aumentado para 5 vezes."
  },
  State_95953_Name = {
    Text = "Véu do Sonho Profundo"
  },
  State_95954_Name = {
    Text = "Sucção de Ghoul - Versão Despertada"
  },
  State_95960_Desc = {
    Text = "O número de destroços aumenta o efeito de \"Coleta de Destroços\"."
  },
  State_95960_Name = {Text = "Esqueleto"},
  State_95962_Name = {
    Text = "Contagem de mortes __ \"Para uso de desenvolvimento apenas\""
  },
  State_95964_Desc = {
    Text = "Equipe única: O dano base causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%>. Se o domínio atual for \"Carne\", quando o portador matar um inimigo, acumula uma quantidade de fornalha carmesim equivalente a <WeaponEffect_Num:[StateArg2]%> do ataque do portador."
  },
  State_95964_WeaponDesc = {
    Text = "O dano base causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%>. Se o domínio atual for \"Carne\", quando o portador matar um inimigo, acumula <WeaponEffect_Num:[DescArg1]> pontos de recuperação da fornalha carmesim."
  },
  State_95966_Desc = {
    Text = "No início do próximo turno, compre [Layer] cartas do baralho do despertador."
  },
  State_95966_Name = {
    Text = "Saudação Cruel"
  },
  State_95967_Desc = {
    Text = "O número de destroços aumenta o efeito de \"Coleta de Destroços\"."
  },
  State_95967_Name = {
    Text = "<Guaiwucanhai:Esqueleto>"
  },
  State_95968_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Equipado, ganha [StateArg1] <StrongEffectKeywords:forte>. O dano excedente ao eliminar um inimigo é repassado ao aliado atrás."
  },
  State_95968_Name = {
    Text = "Beijo do Repouso"
  },
  State_96167_Desc = {
    Text = "Indisfarçável, quando um Corpo Desperto é eliminado, os outros aliados ganham [StateArg1] <StrongEffectKeywords:Eficaz>."
  },
  State_96167_Name = {
    Text = "Cinzas Ardentes da Estrela Negra"
  },
  State_96183_Desc = {
    Text = "No final do turno, se não houver outros aliados no campo, mude a intenção para autodestruição"
  },
  State_96183_Name = {
    Text = "Auto-destruição de ghoul"
  },
  State_96193_Name = {
    Text = "Etiqueta antes da refeição"
  },
  State_96330_Desc = {
    Text = "Para cada 1% de vida perdida, o dano base, escudo e consumo de loucura das cartas de comando de Dulsein aumentam em 1%."
  },
  State_96330_Name = {
    Text = "Sussurros Fantasmas"
  },
  State_96352_Name = {
    Text = "Contagem do Ghoul Primordial"
  },
  State_96354_Name = {
    Text = "Vida máxima inicial"
  },
  State_96355_Desc = {
    Text = "Probabilidade de crítico reduzida em [Layer]%."
  },
  State_96355_Name = {
    Text = "Resistência a golpes críticos"
  },
  State_96355_WeaponDesc = {
    Text = "Probabilidade de receber um golpe crítico reduzida em [Layer]% durante esta batalha."
  },
  State_96356_Desc = {
    Text = "Para cada [DescArg1] pontos de vida perdidos, ganhe [DescArg2] camadas de <ReinforcePVEKeywords:Reforçado>, com um máximo de [DescArg3] camadas. Após ativar \"<Guaiwusiwangdikang:Resistência à Morte>\", aumente sua saúde máxima em [DescArg4] %."
  },
  State_96356_Name = {
    Text = "Proteção de Ilaine"
  },
  State_96357_Desc = {
    Text = "Após o fim do turno, ganha camadas equivalentes de força"
  },
  State_96357_Name = {
    Text = "<Fennu: Raiva>"
  },
  State_96358_Desc = {
    Text = "Probabilidade de ser atingido com um golpe crítico reduzida em [Layer] %."
  },
  State_96358_Name = {
    Text = "<Baojidikang:Resistência a Crítico>"
  },
  State_96412_Name = {
    Text = "Monitoramento do Glutão"
  },
  State_96416_Desc = {
    Text = "Probabilidade de crítico reduzida em [Layer]%."
  },
  State_96416_Name = {
    Text = "Resistência a golpes críticos"
  },
  State_96603_Name = {
    Text = "Se não for jogado neste turno, no início do próximo turno ative uma vez o efeito \"harmonização\""
  },
  State_96610_Name = {
    Text = "Primeira Resistência à Morte"
  },
  State_96613_Name = {
    Text = "Monitoramento de Maré Furiosa"
  },
  State_96650_Desc = {
    Text = "Cada camada aumenta a taxa crítica de todos os Despertadores em [DescArg1]%."
  },
  State_96650_Name = {
    Text = "<ExclamationPointColour:Chama Escura Profunda>"
  },
  State_96719_Desc = {
    Text = "Quando uma carta de <BurningKeywords:Burning> é jogada neste turno, exaure 1 camada de <Heat:Dark Flame> para torná-la eficaz 2 vezes, e limpa <Heat:Dark Flame> no final do turno."
  },
  State_96719_Name = {
    Text = "Chama explosiva infinita"
  },
  State_96731_Desc = {
    Text = "Quando uma carta de <BurningKeywords:Burning> é jogada neste turno, exaure 1 camada de <Heat:Dark Flame> para torná-la eficaz 2 vezes, e limpa <Heat:Dark Flame> no final do turno."
  },
  State_96731_Name = {
    Text = "<Overload:Inflamação Sem Fim>"
  },
  State_96732_Desc = {
    Text = "Cada camada aumenta a taxa crítica de todos os Despertadores em [DescArg1]%."
  },
  State_96732_Name = {
    Text = "<Heat:Chama Escura Profunda>"
  },
  State_96740_Desc = {
    Text = "O dano de ataques ativos e o número de camadas de sangramento aumentam em 50%, e o dano é removido no início de cada rodada."
  },
  State_96740_Name = {
    Text = "<CardKeyWord:Vulnerabilidade>"
  },
  State_96741_Desc = {
    Text = "Se a Aritmética restante for maior que [StateArg1] após jogar, consuma adicionalmente [StateArg1] Aritmética para ativar efeitos subsequentes. __ \"Apenas para Desenvolvimento\""
  },
  State_96741_Name = {
    Text = "<CardKeyWord:Sobrecarga de poder de cálculo>"
  },
  State_96742_Name = {
    Text = "Marcador de sobrecarga de poder de cálculo"
  },
  State_96743_Desc = {
    Text = "Após jogar, se a aritmética restante for maior que a aritmética necessária para sobrecarga, consuma aritmética adicional para ativar o efeito subsequente."
  },
  State_96743_Name = {
    Text = "<CardKeyWord:Sobrecarga aritmética>"
  },
  State_96744_Desc = {
    Text = "O dano de ataques ativos e o número de camadas de sangramento aumentam em 50%, e o dano é removido no início de cada rodada."
  },
  State_96744_Name = {
    Text = "Vulnerabilidade"
  },
  State_96774_Desc = {
    Text = "Cada vez que sofrer dano crítico, ganhe 3% de resistência crítica temporária."
  },
  State_96774_Name = {
    Text = "Espírito Vingativo do Mar Profundo"
  },
  State_96780_Desc = {
    Text = "A carta mantém seu uso, mas quando jogada ou descartada, removerá a poluição e invocará 1 \"Aequor Spawn\", até 2. Se não houver espaço para invocar, ele concederá imediatamente [DescArg1] força e [DescArg2] hp ao fantoche da putrefação."
  },
  State_96780_Name = {
    Text = "<Kuangluan:Marinheiro Enlouquecido>"
  },
  State_96783_Desc = {
    Text = "Cada rodada, adiciona \"<Kuangluan:Frenesi do Marchador de mares>\" a 2 cartas."
  },
  State_96783_Name = {
    Text = "Ritual do Marchador de mares"
  },
  State_96784_Desc = {
    Text = "Reduz a ofensiva da Marionete da Maré da Corrosão, com um limite máximo de 5 camadas."
  },
  State_96784_Name = {Text = "Caos"},
  State_96808_Desc = {
    Text = "A cada [DescArg1] de vida perdida, ganha 15 camadas de \"<ReinforcePVEKeywords:Reforço>\", com um limite de 75 camadas. Ao ser rompido, limpa e ganha 1 camada de \"<Chaos:Caos>\". Se nunca tiver liberado \"Recomposição de Ossos e Sangue\", após receber dano letal, muda a intenção para \"Recomposição de Ossos e Sangue\" e ganha imunidade a todo dano."
  },
  State_96808_Name = {
    Text = "\"Marionete Chimera\""
  },
  State_96809_Name = {
    Text = "Contagem da Marionete Composta"
  },
  State_96810_Desc = {
    Text = "Dano causado reduzido em 25%."
  },
  State_96810_Name = {
    Text = "Véu do Sonho Profundo"
  },
  State_96813_Name = {
    Text = "Marcador de recombinação"
  },
  State_97114_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: \"Golpe\" ganha [StateArg1] de Aritmética, dano de \"Habilidade\" +[StateArg2]%."
  },
  State_97114_Name = {
    Text = "Sol Iminente"
  },
  State_97118_Name = {
    Text = "Impacto da Marionete Composta"
  },
  State_97119_Desc = {
    Text = "A carta mantém seu uso, mas quando jogada ou descartada, removerá a poluição e invocará 1 \"Aequor Spawn\", até 2. Se não houver espaço para invocar, ele concederá imediatamente [DescArg1] força e [DescArg2] hp ao fantoche da putrefação."
  },
  State_97119_Name = {
    Text = "<Kuangluan:Marinheiro Enlouquecido>"
  },
  State_97120_Desc = {
    Text = "Protegido pelo Círculo Mágico, o dano causado por todos os inimigos é reduzido em 25%."
  },
  State_97120_Name = {
    Text = "Véu do Sonho Profundo"
  },
  State_97131_Desc = {
    Text = "<PVPWeaponKeywords:Roda do destino>: O Dano da \"habilidade\" aumentado em [StateArg1]% para cada 1 de Poder de cálculo consumido. Após causar uma Eliminação, o Dano causado pela \"Fúria Explosiva\" aumenta em [StateArg2]%, bônus atual: [DescArg1]%."
  },
  State_97131_Name = {
    Text = "Morte âmbar"
  },
  State_97134_Desc = {
    Text = "Dano final causado aumentado em 50%"
  },
  State_97134_Name = {
    Text = "Cantar de Selene"
  },
  State_97135_Desc = {
    Text = "Dano final causado aumentado em 25%."
  },
  State_97135_Name = {
    Text = "Sussurro de Selene"
  },
  State_97136_Desc = {
    Text = "Dano final causado aumentado em 100%"
  },
  State_97136_Name = {
    Text = "Cântico de Selene"
  },
  State_97137_Desc = {
    Text = "Após descartar, retorna à mão."
  },
  State_97137_Name = {
    Text = "Após descartar, retorna à mão"
  },
  State_97137_WeaponDesc = {
    Text = "Ao comprá-lo, fique vulnerável por 1 rodada. Após o uso, fique vulnerável a todos os inimigos por 1 rodada. Não pode ser vendido"
  },
  State_97219_Desc = {
    Text = "As próximas <plural value=\"[Layer]\" singular=\"carta\" plural=\"cartas\"> que Wanda Disparar entram em efeito 1 vez adicional."
  },
  State_97219_Name = {
    Text = "Rainha dos Espinhos"
  },
  State_97251_Desc = {
    Text = ": Não pode ser priorizado ou selecionado como alvo único. Os oponentes não podem escolher o Despertador Furtivo ao selecionar alvos únicos.\nAo ganhar Furtividade, remove sua própria Provocação e a Furtividade de outros aliados. Se não houver outros aliados ou se um inimigo ganhar Provocação, remova a Furtividade."
  },
  State_97251_Name = {
    Text = "Infiltração"
  },
  State_97252_Desc = {
    Text = ": Não pode ser priorizado ou selecionado como alvo único. Os oponentes não podem escolher o Despertador Furtivo ao selecionar alvos únicos.\nAo ganhar Furtividade, remove sua própria Provocação e a Furtividade de outros aliados. Se não houver outros aliados ou se um inimigo ganhar Provocação, remova a Furtividade."
  },
  State_97252_Name = {
    Text = "<PVPSneakKeywords:Infiltração>"
  },
  State_97339_Name = {
    Text = "Taça de Ouro de Campeão de Mythag"
  },
  State_97742_Desc = {
    Text = "Cada vez que um Dano ativo é recebido, causa [Layer] de <FixedDamage:Dano Puro> à Fonte de Dano."
  },
  State_97742_Name = {
    Text = "Contrataque"
  },
  State_97743_Desc = {
    Text = "Dano ativo aumentado em [Layer]"
  },
  State_97743_Name = {
    Text = "<PowerColourKeywords:Força>"
  },
  State_97744_Desc = {
    Text = "Dano recebido -[Layer]%."
  },
  State_97744_Name = {
    Text = "<ReinforceColour:reforçado>"
  },
  State_97744_WeaponDesc = {
    Text = "Dano causado reduzido em [DescArg1] %"
  },
  State_97938_Desc = {
    Text = "Dano final aumentado em [DescArg1]%."
  },
  State_97938_Name = {
    Text = "Taça de Ouro de Campeão de Mythag"
  },
  State_97939_Desc = {
    Text = "Dano final causado aumentado em 50%"
  },
  State_97939_Name = {
    Text = "Taça de Ouro do Campeonato de Mythag"
  },
  State_97941_Desc = {
    Text = "Dano base aumentado em 100%."
  },
  State_97941_Name = {
    Text = "Taça de Ouro de Campeão de Mythag"
  },
  State_97942_Desc = {
    Text = "Ao liberar a exaltação, ganhe 35 pontos de loucura."
  },
  State_97942_Name = {
    Text = "Taça de Ouro de Mythag"
  },
  State_97943_Name = {
    Text = "Contagem de Manter Aritmética"
  },
  State_98055_Desc = {
    Text = "No final do turno, gere 1 tentáculo. Remova este estado após despertar"
  },
  State_98055_Name = {Text = "Sono"},
  State_98060_Desc = {
    Text = "Este despertador ainda não despertou... Vai despertar imediatamente antes de ser derrubado, restaurar a vida e começar a lutar em sua verdadeira forma"
  },
  State_98060_Name = {
    Text = "Ainda não despertado"
  },
  State_98068_Desc = {
    Text = "Ao possuir 10 camadas de \"chama explosiva\", ganha 2 pontos de aritmética e converte todas as \"gigafalhas\" em \"terafalhas\"."
  },
  State_98068_Name = {
    Text = "<BaoyanKeywords:Chama Explosiva>"
  },
  State_98139_Desc = {
    Text = "No início do turno do oponente, adicione aleatoriamente <BurningKeywords:queima> 1 carta da mão."
  },
  State_98139_Name = {
    Text = "Estado@Monstro Katigura - Marca de Despertar"
  },
  State_98140_Desc = {
    Text = "Após acumular 10 camadas de <MonsterExFlameKeywords:Chama Explosiva>, mude a intenção para o \"Bilhões de fulguras\" de dano extremamente alto!"
  },
  State_98140_Name = {
    Text = "<BurningColor:Chama Explosiva>"
  },
  State_98147_Desc = {
    Text = "Quando o inimigo jogar cartas <BurningKeywords:queima>, conceda a si mesmo 1 pilha de <MonsterExFlameKeywords:combustão>, mas reduza temporariamente [DescArg1] <PowerIconKeywords:FOR>."
  },
  State_98147_Name = {
    Text = "Estado@Monstro Katigura Combustão Ouvinte"
  },
  State_98148_Desc = {
    Text = "Esta pessoa ainda não despertou… Vai despertar imediatamente antes de ser derrubada, descartar todas as cartas restantes e conceder <BurningKeywords:Queimar>, recuperar vida e começar a lutar em sua verdadeira forma."
  },
  State_98148_Name = {
    Text = "Ainda não despertado"
  },
  State_98302_Desc = {
    Text = "Equipe única: O dano base causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%>, e o poder causado aumenta em <WeaponEffect_Num:[StateArg2]%>. Após jogar uma carta de comando do portador, ganhe poder temporário equivalente a <WeaponEffect_Num:[StateArg3]%> do ataque do portador, com no máximo 5 ativações por turno."
  },
  State_98302_WeaponDesc = {
    Text = "O dano base causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%>, e o poder causado aumenta em <WeaponEffect_Num:[StateArg2]%>. Após jogar uma carta de comando do portador, ganhe <WeaponEffect_Num:[Power:DescArg1]> pontos de poder temporário, com no máximo 5 ativações por turno (atualmente ativado [DescArg2]/5 vezes)."
  },
  State_98323_Desc = {
    Text = "A carta retornará para a mão após ser descartada"
  },
  State_98323_Name = {
    Text = "Após descartar, retorna à mão"
  },
  State_98341_Desc = {
    Text = "Pode ser misturado com outras cores primárias para formar uma nova cor."
  },
  State_98341_Name = {
    Text = "<Yellow:Cor Primária - Amarelo>"
  },
  State_98344_Desc = {
    Text = "Pode ser misturado com outras cores primárias para formar uma nova cor."
  },
  State_98344_Name = {
    Text = "<Red:Cor Primária·Vermelho>"
  },
  State_98345_Desc = {
    Text = "Pode ser misturado com outras cores primárias para formar uma nova cor."
  },
  State_98345_Name = {
    Text = "<Blue:Cor Primária·Azul>"
  },
  State_98366_Desc = {
    Text = "No início do turno, se a energia da chave de prata for maior que [Arg1], consuma [Arg1] pontos de energia da chave de prata para colocar 1 <DerivativeCardKeywords_115:\"Inspiração Avançada\"> em sua mão."
  },
  State_98435_Desc = {
    Text = "Vindo da combinação de vermelho e azul, ao causar 1 dano ativo, ganha <Block: [DescArg1]> de escudo."
  },
  State_98435_Name = {
    Text = "<PurpleKeyWord:Visão Púrpura>"
  },
  State_98436_Desc = {
    Text = "Resultante da mistura de tons vermelhos e amarelos, após liberar a exaltação, o despertador correspondente ganha <Energy:15> pontos de loucura."
  },
  State_98436_Name = {
    Text = "<ExclamationPointColour:Visão·Laranja>"
  },
  State_98437_Desc = {
    Text = "Dano final aumentado em 10%."
  },
  State_98437_Name = {
    Text = "<Red:Cor Primária·Vermelho>"
  },
  State_98438_Desc = {
    Text = "Originado da mistura de amarelo e azul, ao jogar \"Defesa\", recupere <Heal:[DescArg1]> pontos de vida."
  },
  State_98438_Name = {
    Text = "<GreenWord:Imagem Verde>"
  },
  State_98439_Desc = {
    Text = "Proveniente da mistura de amarelo e azul, ao jogar \"Defesa\", recupera <Heal:[DescArg1]> pontos de vida."
  },
  State_98439_Name = {
    Text = "<GreenWord:Visão·Verde>"
  },
  State_98440_Desc = {
    Text = "Combinado de vermelho e azul, ao causar 1 dano ativo, ganha <Block: [DescArg1]> de escudo."
  },
  State_98440_Name = {
    Text = "<PurpleKeyWord:Visão Púrpura>"
  },
  State_98441_Desc = {
    Text = "Vindo da mistura de vermelho e amarelo, após liberar a exaltação, o despertador correspondente ganha <Energy:15> pontos de loucura."
  },
  State_98441_Name = {
    Text = "<ExclamationPointColour:Visão·Laranja>"
  },
  State_98444_Desc = {
    Text = "Equipe única: O dano base causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%>. Após jogar 5 cartas de comando do portador, o portador ganha <WeaponEffect_Num:[StateArg2]%> de taxa crítica. Este efeito só pode ser ativado uma vez por turno."
  },
  State_98444_WeaponDesc = {
    Text = "O dano base causado pelo portador aumenta em <WeaponEffect_Num:[StateArg1]%>. Após jogar 5 cartas de comando do portador, o portador ganha <WeaponEffect_Num:[StateArg2]%> de taxa crítica. Este efeito só pode ser ativado uma vez por turno (já foram jogadas [DescArg1]/5 cartas)."
  },
  State_98466_Name = {
    Text = "<HuoyanKeywords1:Chama Viva 1>"
  },
  State_98468_Name = {
    Text = "<HuoyanKeywords3:Chama Viva 3>"
  },
  State_98470_Name = {
    Text = "<HuoyanKeywords2:Chama Viva 2>"
  },
  State_98474_Desc = {
    Text = "São as cores primárias, compostas por vermelho, amarelo e azul, que podem ser misturadas para criar outras cores."
  },
  State_98474_Name = {Text = "Primária"},
  State_98484_Name = {
    Text = "Mar de Dor Submerso"
  },
  State_98485_Desc = {
    Text = "O Dano Final e Força concedidos por esta carta +[DescArg1]%; Escudo do personagem e Fúria +[DescArg2]%. Ganha \"Preservar\". Após ser jogada, consome todas as camadas de \"Chama Viva\" e transmite 1 camada de \"Chama Viva\" para outra Carta de comando de Katie Gula na sua mão."
  },
  State_98485_Name = {
    Text = "<HuoyanKeywords2:Chama Viva 2>"
  },
  State_98486_Desc = {
    Text = "O Dano Final e Força concedidos por esta carta +[DescArg1]%; Escudo do personagem e Fúria +[DescArg2]%. Ganha \"Preservar\". Após ser jogada, consome todas as camadas de \"Chama Viva\" e transmite 1 camada de \"Chama Viva\" para outra Carta de comando de Katie Gula na sua mão."
  },
  State_98486_Name = {
    Text = "<HuoyanKeywords3:Chama Viva 3>"
  },
  State_98487_Desc = {
    Text = "O Dano Final e Força concedidos por esta carta +[DescArg1]%; Escudo do personagem e Fúria +[DescArg2]%. Ganha \"Preservar\". Após ser jogada, consome todas as camadas de \"Chama Viva\" e transmite 1 camada de \"Chama Viva\" para outra Carta de comando de Katie Gula na sua mão."
  },
  State_98487_Name = {
    Text = "<HuoyanKeywords1:Chama Viva 1>"
  },
  State_98488_Desc = {
    Text = "Cada camada de \"Chama Viva\" aumenta em 30% o dano final, escudo, fúria e poder causados pela carta, acumulando no máximo 3 camadas. As cartas que possuem \"Chama Viva\" ganham \"Retenção\"; após serem jogadas, consomem todas as \"Chamas Vivas\" e transferem 1 camada de \"Chama Viva\" para outra carta de comando de Katyura na mão."
  },
  State_98488_Name = {
    Text = "<HuoyanKeywords:Chama Viva>"
  },
  State_98492_Desc = {
    Text = "Após o início da exploração, aumente a constituição, o ataque e a defesa em [StateArg1]%"
  },
  State_98492_Name = {
    Text = "Adaptabilidade de forma espiritual"
  },
  State_98495_Desc = {
    Text = "Após o início da exploração, aumente a constituição, o ataque e a defesa em [StateArg1]%"
  },
  State_98495_Name = {
    Text = "Adaptabilidade de forma espiritual"
  },
  State_98507_Desc = {
    Text = "Após o início da exploração, aumente a constituição, o ataque e a defesa em [StateArg1]%"
  },
  State_98507_Name = {
    Text = "Adaptabilidade de forma espiritual"
  },
  State_98511_Name = {
    Text = "Obter carta derivada"
  },
  State_98551_Desc = {
    Text = "No início da batalha, aumente a maestria dimensional em +[Arg1]. No início dos turnos ímpares, compre 1 carta. No início dos turnos pares, ganhe 1 ponto de aritmética."
  },
  State_98553_Desc = {
    Text = "Ganhe [Arg1] Fornalha carmesim para cada \"embrião\" gerado, ativando até 3 vezes por turno."
  },
  State_98555_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada. Na primeira vez que aplicar veneno em um turno, compre [Arg2] cartas."
  },
  State_98556_Desc = {
    Text = "Todos os despertos têm um aumento de [Arg1]% no efeito base de recuperação de vida e escudo que causam."
  },
  State_98557_Desc = {
    Text = "Ganhe [Arg1] Fornalha carmesim para cada \"embrião\" gerado, ativando até 3 vezes por turno."
  },
  State_98559_Desc = {
    Text = "Cada vez que comprar ou descartar uma carta, ganhe [Arg1] de força temporária, com um máximo de [Arg2] de força temporária."
  },
  State_98560_Desc = {
    Text = "Todos os Despertadores têm um aumento de [Arg1]% no dano base causado. Antes de liberar a Explosão de Loucura, o Despertador que a liberar terá um aumento temporário de [Arg2]% no dano base causado."
  },
  State_98561_Desc = {
    Text = "No início do turno, se a vida estiver abaixo de 50%, aumente a força de dano temporária em +[Arg1]%. Se a vida estiver abaixo de 25%, compre [Arg2] cartas adicionais e ganhe [Arg2] aritmética."
  },
  State_98562_Desc = {
    Text = "Após causar dano ativo ou dano de tentáculo, aumente em [Arg1]% o dano de tentáculo recebido pelo alvo neste turno, com um máximo de 20 ativações por turno."
  },
  State_98563_Desc = {
    Text = "No início da batalha, ganhe [Arg1] de força. Cada vez que jogar uma carta de \"consumo\", ganhe [Arg2] de força temporária, com um máximo de [Arg3] ativações."
  },
  State_98564_Desc = {
    Text = "\"Exaltar\" ganha [Arg1] energia da chave de prata, aciona até 3 vezes por turno."
  },
  State_98565_Desc = {
    Text = "Sempre que uma carta entrar no espaço ultra, compre [Arg1] cartas de comando do proprietário desta carta do monte de compra. Se não for possível comprar, receba aritmética equivalente. Ativa no máximo 2 vezes por rodada."
  },
  State_98567_Desc = {
    Text = "Antes do fim do turno, o despertado proprietário de cada carta de comando na mão ganha [Arg1] de loucura."
  },
  State_98568_Desc = {
    Text = "Ao início da batalha, ganha força de dano +[Arg1]%. Após causar dano ativo, aplique [Arg2] camadas de veneno a todos os inimigos, com ativação adicional máxima de 5 vezes por rodada."
  },
  State_98569_Desc = {
    Text = "Após a primeira vez em cada turno que um \"mandato\" é usado, aplique [Arg1] camadas de veneno a todos os inimigos e ganhe [Arg2] camadas de contra-ataque."
  },
  State_98571_Desc = {
    Text = "Após usar o Despertar da chave de prata, recupere [Arg1] pontos de vida e obtenha [Arg2] pontos de s-energia."
  },
  State_98571_Name = {
    Text = "guarda-sol de viagem"
  },
  State_98572_Desc = {
    Text = "Após liberar o segundo \"bando\" em cada turno, ganhe [Arg1] pontos de s-energia e todos os despertados ganham [Arg2] pontos de loucura."
  },
  State_98575_Desc = {
    Text = "No início da batalha, ganhe força de dano +[Arg1]%. Após causar dano ativo, aplique [Arg2] camadas de veneno a todos os inimigos, podendo ser ativado adicionalmente no máximo 5 vezes por rodada."
  },
  State_98576_Desc = {
    Text = "Ao início da batalha, aplica [Arg1] camadas de fraqueza e vulnerabilidade a todos os inimigos. Este efeito também é ativado após a \"Aniquilação\", mas possui um tempo de recarga de 3 turnos."
  },
  State_98577_Desc = {
    Text = "Todos os Despertadores têm um aumento de [Arg1]% no dano base causado. Antes de liberar a Explosão de Loucura, o Despertador que a liberar terá um aumento temporário de [Arg2]% no dano base causado."
  },
  State_98579_Desc = {
    Text = "No início do turno, se a vida estiver abaixo de 50%, aumenta a força de dano temporária em +[Arg1]%. Se a vida estiver abaixo de 25%, compre [Arg2] cartas adicionais e ganhe [Arg2] pontos de aritmética."
  },
  State_98581_Desc = {
    Text = "Todos os despertados ganham [Arg1] pontos de s-energia ao usar uma \"carta de comando\" pela primeira vez em cada turno."
  },
  State_98582_Desc = {
    Text = "Após liberar \"exaltar\" 5 vezes, os próximos [Arg1] cartões de comando não derivados tomam efeito 1 vez adicional."
  },
  State_98583_Desc = {
    Text = "Todos os despertados ganham [Arg1] pontos de s-energia na primeira vez que uma \"carta de comando\" é jogada em cada turno."
  },
  State_98586_Desc = {
    Text = "No início do turno, todos os despertos que não têm Loucura suficiente para liberar a Explosão de Loucura ganham [Arg1] pontos de Loucura."
  },
  State_98587_Desc = {
    Text = "Cada vez que comprar ou descartar uma carta, ganhe [Arg1] de força temporária, com um máximo de [Arg2] de força temporária."
  },
  State_98588_Desc = {
    Text = "Antes do final do turno, cada Despertado proprietário de uma carta de comando na mão ganha [Arg1] de Loucura."
  },
  State_98589_Desc = {
    Text = "No início da batalha, faz todos os inimigos perderem temporariamente [Arg1] pontos de <PowerIconKeywords:força>. Usar a \"Fornalha Carmesim\" também aciona esse efeito, mas possui um tempo de recarga de 3 turnos."
  },
  State_98590_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada. Na primeira vez que aplicar veneno em cada turno, compre [Arg2] cartas."
  },
  State_98591_Desc = {
    Text = "Após a primeira utilização de \"Chave\" em cada turno, aplique [Arg1] camadas de veneno a todos os inimigos e ganhe [Arg2] camadas de contra-ataque."
  },
  State_98596_Desc = {
    Text = "Na primeira vez de cada turno, o \"bando\" devolve [Arg1]% da s-energia consumida."
  },
  State_98597_Desc = {
    Text = "Após usar o Despertar da chave de prata, recupere [Arg1] pontos de vida e ganhe [Arg2] pontos de s-energia."
  },
  State_98597_Name = {
    Text = "guarda-sol de viagem+"
  },
  State_98598_Desc = {
    Text = "Ao iniciar a batalha, obtenha [Arg1] pontos de poder. Cada vez que jogar uma carta de \"consumo\", ganhe [Arg2] pontos de força temporária, com um máximo de [Arg3] ativações."
  },
  State_98600_Desc = {
    Text = "No início da batalha, faz todos os inimigos perderem temporariamente [Arg1] pontos de <PowerIconKeywords:força>. Usar a \"Fornalha Carmesim\" também aciona esse efeito, mas possui um tempo de recarga de 3 turnos."
  },
  State_98602_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia de dano aumentada. Na primeira vez que receber um contra-ataque em cada turno, ganhe 1/2 ponto de aritmética."
  },
  State_98603_Desc = {
    Text = "No início da batalha, ganhe Dano potencializado +[Arg1]%. Após receber Dano Ativo ou Dano de tentáculo, ganhe [Arg2] Contrataque, até 3 vezes por turno."
  },
  State_98604_Desc = {
    Text = "No início da batalha, ganhe Dano potencializado +[Arg1]%. Após receber Dano Ativo ou Dano de tentáculo, ganhe [Arg2] Contrataque, até 3 vezes por turno."
  },
  State_98606_Desc = {
    Text = "Sempre que uma carta entrar no espaço ultra, compre [Arg1] cartas de comando do proprietário desta carta do baralho. Se não for possível comprar, receba aritmética equivalente. Ativa no máximo 2 vezes por rodada."
  },
  State_98607_Desc = {
    Text = "A primeira vez de cada turno que um \"bando\" é usado, ativa todos os tentáculos para atacarem [Arg1] vezes o inimigo, causando 50% de dano."
  },
  State_98608_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de aumento de dano. Cada carta de comando jogada de um despertador diferente concede adicionalmente 15/30% de aumento de dano temporário."
  },
  State_98610_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, as 2/4 cartas com a aritmética mais alta em sua mão ganham Retenção e Preparação antes de serem jogadas pela próxima vez, e você obtém 100/200 pontos de s-energia."
  },
  State_98611_Desc = {
    Text = "No início da batalha, aumente a maestria dimensional em +[Arg1]. No início dos turnos ímpares, compre 1 carta. No início dos turnos pares, ganhe 1 ponto de aritmética."
  },
  State_98612_Desc = {
    Text = "A primeira vez de cada turno que uma \"chave de ordem\" é usada aumenta a força de dano temporária em +[Arg1]%, sendo o efeito mais forte quanto menor for a vida."
  },
  State_98613_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de aumento de dano forte. Cada carta de comando de um despertador diferente jogada concede adicionalmente 15/30% de aumento de dano forte temporário."
  },
  State_98614_Desc = {
    Text = "Após liberar \"exaltar\" 5 vezes, os próximos [Arg1] cartões de comando não derivados tomam efeito 1 vez adicional."
  },
  State_98615_Desc = {
    Text = "Na primeira vez de cada turno, a \"Chave\" devolve [Arg1]% da s-energia consumida."
  },
  State_98616_Desc = {
    Text = "Todos os despertos têm um aumento de [Arg1]% no efeito base de recuperação de vida e escudo que causam."
  },
  State_98617_Desc = {
    Text = "Após causar dano ativo ou dano de tentáculo, aumente em [Arg1]% o dano de tentáculo recebido pelo alvo neste turno, com um máximo de 20 ativações por turno."
  },
  State_98619_Desc = {
    Text = "Se, no final do turno, a energia da chave de prata estiver cheia, consuma [Arg1] pontos de energia da chave de prata para colocar uma \"chave de prata brilhante\" na mão."
  },
  State_98621_Desc = {
    Text = "Se a energia da chave de prata estiver cheia no final do turno, consuma [Arg1] pontos de energia da chave de prata para colocar uma «chave de prata do alvorecer» na mão."
  },
  State_98623_Desc = {
    Text = "No início do turno, todos os despertos que não têm Loucura suficiente para liberar a Explosão de Loucura ganham [Arg1] pontos de Loucura."
  },
  State_98624_Desc = {
    Text = "Ao início da batalha e após ativar a resistência à morte, ganhe [Arg1] pontos de s-energia."
  },
  State_98625_Desc = {
    Text = "Ao início da batalha, aplica [Arg1] camadas de fraqueza e vulnerabilidade a todos os inimigos. Este efeito também é ativado após a \"Aniquilação\", mas possui um tempo de recarga de 3 turnos."
  },
  State_98626_Desc = {
    Text = "A primeira vez de cada turno que uma \"chave de ordem\" é usada, aumenta a força de dano temporária em +[Arg1]%, e o efeito é maior quanto menor for a vida."
  },
  State_98627_Desc = {
    Text = "\"Exaltar\" ganha [Arg1] energia da chave de prata, aciona até 3 vezes por turno."
  },
  State_98628_Desc = {
    Text = "A primeira vez de cada turno que um \"bando\" é usado, ativa todos os tentáculos para atacarem [Arg1] vezes o inimigo, causando 50% de dano."
  },
  State_98629_Desc = {
    Text = "Após liberar o segundo \"bando\" em cada turno, ganhe [Arg1] pontos de s-energia e todos os despertadores ganham [Arg2] pontos de loucura."
  },
  State_98630_Desc = {
    Text = "Ao início da batalha e após ativar a resistência à morte, ganhe [Arg1] pontos de s-energia."
  },
  State_98632_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada de dano. Na primeira vez que receber um contra-ataque em cada turno, ganhe 1/2 ponto de aritmética."
  },
  State_98686_Desc = {
    Text = "A próxima carta de comando não derivada do [Layer] terá um efeito extra adicional."
  },
  State_98686_Name = {
    Text = "Carta de comando não derivada ativa duas vezes"
  },
  State_98739_Desc = {
    Text = "Quando a intenção for alterada para Rotação Pálida, aumente a quantidade de ataques em um número equivalente às camadas do estado, e remova o estado no final do turno. Ao alcançar 3 camadas, mude imediatamente a intenção para Rotação Pálida."
  },
  State_98739_Name = {
    Text = "Beijo da Mulher-Aranha"
  },
  State_98742_Desc = {
    Text = "O veneno aplicado aumenta em 100% e, no final de cada turno, ganha <Block:[Block:DescArg1]> pontos de escudo."
  },
  State_98742_Name = {
    Text = "Viagem Perdida"
  },
  State_98743_Desc = {
    Text = "Após receber [DescArg1] pontos de dano durante o turno, ganhe 75 camadas de reforçado temporário, converta a intenção para \"Caridade da Intolerância\", remova o efeito de petrificação e ganhe 1 camada de \"Beijo da Aranha\"."
  },
  State_98743_Name = {
    Text = "Transgressor"
  },
  State_98752_Desc = {
    Text = "Torna a carta em chamas. Após jogá-la, sofre 5% de dano com base na vida máxima. Se ainda estiver na mão no final do turno, será consumida."
  },
  State_98752_Name = {
    Text = "<QueimarKeywords2:Queimar>"
  },
  State_98752_WeaponDesc = {
    Text = "Cada camada de lentidão aumenta o custo de aritmética das cartas em 1 ponto"
  },
  State_98887_Name = {
    Text = "alma artificial"
  },
  State_98889_Desc = {
    Text = "Ao jogar pela primeira vez uma carta de comando derivada ou uma carta de benefício com <DepleteIconKeywords:exausto> em cada turno, coloque-a na pilha de descarte."
  },
  State_98889_Name = {
    Text = "alma artificial"
  },
  State_98912_Desc = {
    Text = "Cada camada reduz o dano final causado por todos os despertos em 20%."
  },
  State_98912_Name = {
    Text = "<LostWay:Perdido>"
  },
  State_98913_Desc = {
    Text = "Cada camada reduz o dano final causado por todos os despertos em 20%."
  },
  State_98913_Name = {Text = "perdido"},
  State_99007_Desc = {
    Text = "Após jogar, não vá para a pilha de descarte, mas seja removido do baralho"
  },
  State_99007_Name = {
    Text = "<DepleteIconKeywords:Consumo>"
  },
  State_99007_WeaponDesc = {
    Text = "Após jogar, a carta não irá para a pilha de descarte e não poderá ser usada novamente nesta batalha"
  },
  State_99053_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após \"Exaltar\" outros aliados, compre [StateArg1] cartas."
  },
  State_99053_Name = {
    Text = "Pincel desejante"
  },
  State_99055_Desc = {
    Text = "<PVPWeaponKeywords:Roda do Destino>: Após \"Fúria Explosiva\", coloque aleatoriamente [StateArg1] \"Habilidade\" do Portador na mão e reduza seu Consumo de potência de cálculo para 0."
  },
  State_99055_Name = {
    Text = "Paradoxo do Realismo"
  },
  State_99056_Desc = {
    Text = "Equipe única: Após liberar a chave, a taxa crítica do portador aumenta temporariamente em <WeaponEffect_Num:[StateArg1]%>."
  },
  State_99056_WeaponDesc = {
    Text = "Após liberar a chave, a taxa crítica do portador aumenta temporariamente em <WeaponEffect_Num:[StateArg1]%>."
  },
  State_99134_Desc = {
    Text = "O \"Pintor\" usa tintas para pintar, que podem fortalecer os efeitos das habilidades. Ao jogar uma carta de \"<ColorInkKeywords:tinta colorida>\" ou \"<ErosionColorInkKeywords:dissolução tinta colorida>\", ela ganha 1 camada, com um máximo de 10 camadas."
  },
  State_99134_Name = {
    Text = "Tinta do Mundo Ilusório"
  },
  State_99237_Name = {
    Text = "Estado do acessório Ascensão"
  },
  State_99237_WeaponDesc = {
    Text = "O dano base do portador aumenta em 10%. Se o dano forte do portador for maior que 20%, o dano base aumenta em mais 10%"
  },
  State_99238_Name = {
    Text = "Estado do acessório Húmus"
  },
  State_99238_WeaponDesc = {
    Text = "O dano base do portador aumenta em 10%. Se o dano forte do portador for maior que 20%, o dano base aumenta em mais 10%"
  },
  State_99239_Name = {
    Text = "Estado do acessório Estige"
  },
  State_99239_WeaponDesc = {
    Text = "O dano base do portador aumenta em 10%. Se o dano forte do portador for maior que 20%, o dano base aumenta em mais 10%"
  },
  State_99258_Desc = {
    Text = "Único na equipe: Após liberar a segunda chave em cada turno, há <WeaponEffect_Num:[StateArg1]%> de chance de puxar 1 carta de comando do portador. Após jogar a terceira carta de comando do portador em cada turno, ganhe <WeaponEffect_Num:[StateArg2]> pontos de s-energia."
  },
  State_99258_WeaponDesc = {
    Text = "Após liberar a segunda chave em cada turno, há <WeaponEffect_Num:[StateArg1]%> de chance de puxar 1 carta de comando do portador. Após jogar a terceira carta de comando do portador em cada turno, ganhe <WeaponEffect_Num:[StateArg2]> pontos de s-energia."
  },
  State_99294_Desc = {
    Text = "A loucura causada por todos os despertadores aumenta em [DescArg1]%. A aritmética e as cartas de comando ao final do turno podem ser mantidas para o próximo turno. A loucura causada pelo \"Capítulo deslumbrante\" aumenta."
  },
  State_99294_Name = {Text = "\"Alegria\""},
  State_99295_Desc = {
    Text = "O Aliemus gerado por todos os Despertadores aumenta em [StateArg1]%, e os Cartões de Aritmética e Comando podem ser levados para a próxima rodada. O Aliemus do Capítulo Esplêndido também aumenta."
  },
  State_99295_Name = {Text = "\"Alegria\""},
  State_99336_Desc = {
    Text = "O \"Pintor\" usa tintas para pintar, que podem fortalecer os efeitos das habilidades. Ao jogar uma carta de \"<ColorInkKeywords:tinta colorida>\" ou \"<ErosionColorInkKeywords:dissolução tinta colorida>\", ela ganha 1 camada, com um máximo de 10 camadas."
  },
  State_99336_Name = {
    Text = "<DecayDye:Tinta do Mundo Ilusório>"
  },
  State_99533_Name = {
    Text = "Casulo da Donzela dos Acessórios"
  },
  State_99533_WeaponDesc = {
    Text = "No início da batalha, se o portador for da classe Caos, ataque +25%"
  },
  State_99534_Name = {Text = "Slime Doce"},
  State_99534_WeaponDesc = {
    Text = "O escudo e a recuperação de vida do portador aumentam em 6%. Se a maestria do domínio do portador for maior que 50, o escudo e a recuperação de vida aumentam em mais 6%"
  },
  State_99640_Desc = {
    Text = "Se atualmente você tiver 10 camadas de criatividade, após Pikman liberar a explosão de loucura e consumir toda a criatividade, todos os Despertados ganham 15 de loucura e recebem 1 camada de \"devaneio\". O limite de criatividade é de 10 camadas, podendo ser herdado para a próxima batalha."
  },
  State_99640_Name = {
    Text = "Criatividade"
  },
  State_99723_Desc = {
    Text = "Equipe única: O aliemus e o poder causados pelo portador aumentam em <WeaponEffect_Num:[StateArg1] %>. Após liberar a exaltação, o dano final, escudo e recuperação de vida da próxima exaltação de outros despertadores neste turno aumentam em <WeaponEffect_Num:[StateArg2] %>; se esta exaltação ativar \"Devorar\", o portador ganha <WeaponEffect_Num:[StateArg3]> pontos de aliemus."
  },
  State_99723_WeaponDesc = {
    Text = "A loucura e o poder causados pelo portador aumentam em <WeaponEffect_Num:[StateArg1]%. Após liberar a explosão de loucura, o dano final, escudo e recuperação de vida da próxima explosão de loucura de outros despertos neste turno aumentam em <WeaponEffect_Num:[StateArg2]%>. Se esta explosão de loucura ativar \"Devorar\", o portador ganha <WeaponEffect_Num:[StateArg3]> pontos de loucura."
  }
})
return Text_State
