__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_RelicConfig = readonly({
  RelicConfig_100300_BattleDesc = {
    Text = "Após o início da batalha, ganhe 3 camadas de \"<MindWall:barreira mental>\" e 1 camada de \"<TrueConfess:confissão>\". Após ativar 3 vezes \"<MindWall:barreira mental>\", ganhe 1 camada de \"<BarrierCrash:colapso da barreira>\". Após liberar a explosão de loucura, mude \"<TrueConfess:confissão>\" para \"<ShadowSelf:sombra da personalidade>\"."
  },
  RelicConfig_100300_Desc = {
    Text = "Após o início da batalha, ganhe 3 camadas de \"<MindWall:barreira mental>\" e 1 camada de \"<TrueConfess:confissão>\". Após ativar 3 vezes \"<MindWall:barreira mental>\", ganhe 1 camada de \"<BarrierCrash:colapso da barreira>\". Após liberar a explosão de loucura, mude \"<TrueConfess:confissão>\" para \"<ShadowSelf:sombra da personalidade>\"."
  },
  RelicConfig_100300_Name = {
    Text = "Análise da Mente"
  },
  RelicConfig_100300_StoryDesc = {
    Text = "Observe cuidadosamente seu coração, não faça a escolha errada."
  },
  RelicConfig_100399_BattleDesc = {
    Text = "Após acionar o efeito <DevouredIconKeywords:devorar>, outros Despertados ganham [Arg1] pontos de loucura, podendo ocorrer apenas 1 vez por turno."
  },
  RelicConfig_100399_Desc = {
    Text = "Após ativar o efeito <DevouredIconKeywords:devorar>, outros Despertados ganham [Arg1] pontos de loucura, podendo ser aplicado apenas 1 vez por turno."
  },
  RelicConfig_100399_Name = {
    Text = "<OrangeQuality:Terra dos Sonhos Dourados Copiada+>"
  },
  RelicConfig_100399_StoryDesc = {
    Text = "O dia da metamorfose será o seu fim"
  },
  RelicConfig_100400_BattleDesc = {
    Text = "No fim do turno, recupera [Heal:Arg1] de Vida."
  },
  RelicConfig_100400_Desc = {
    Text = "No fim do turno, recupera [Heal:Arg1] de Vida."
  },
  RelicConfig_100400_Name = {
    Text = "<OrangeQuality:Sangue de Graça Copiado+>"
  },
  RelicConfig_100400_StoryDesc = {
    Text = "Doce e suave, com aroma de rosas"
  },
  RelicConfig_100401_BattleDesc = {
    Text = "Perder vida para obter [Arg1]% da quantidade de vida perdida na fornalha carmesim."
  },
  RelicConfig_100401_Desc = {
    Text = "Perder vida para obter [Arg1]% da quantidade de vida perdida na fornalha carmesim."
  },
  RelicConfig_100401_Name = {
    Text = "<OrangeQuality:Serra de Aço Enferrujada Copiada+>"
  },
  RelicConfig_100401_StoryDesc = {
    Text = "O doutor da dissecação passou a vida sem ver uma bela mulher, apenas um saco cheio de ossos, nervos inflamados por doenças, músculos e tecidos"
  },
  RelicConfig_100402_BattleDesc = {
    Text = "Ao coletar, aplique [Arg1] camadas de <VulnerabilityIconKeywords:vulnerável> a todos os inimigos. Todos os despertos têm um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_100402_Desc = {
    Text = "Ao coletar, aplique [Arg1] camadas de <VulnerabilityIconKeywords:vulnerável> a todos os inimigos. Todos os despertos têm um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_100402_Name = {
    Text = "<WhiteQuality:O Sacrifício da Primavera Copiado>"
  },
  RelicConfig_100402_StoryDesc = {
    Text = "No riso da noite, a silhueta da canoa desliza suavemente sobre o lago"
  },
  RelicConfig_100404_BattleDesc = {
    Text = "Após liberar a \"exaltação\", ganhe [Arg1] pontos de <PowerIconKeywords:poder> temporários."
  },
  RelicConfig_100404_Desc = {
    Text = "Após liberar a \"exaltação\", ganhe [Arg1] pontos de <PowerIconKeywords:poder> temporários."
  },
  RelicConfig_100404_Name = {
    Text = "<WhiteQuality:Trava Pesada Copiada>"
  },
  RelicConfig_100404_StoryDesc = {
    Text = "Uma fechadura grossa e robusta, difícil de abrir sem chave.\nClaro, para um mestre ladrão, isso não é nada"
  },
  RelicConfig_100405_BattleDesc = {
    Text = "Ao coletar, aplique [Arg1] camadas de <WeaknessIconKeywords:fraqueza> a todos os inimigos. O dano base causado por todos os despertos aumenta em [Arg2]%."
  },
  RelicConfig_100405_Desc = {
    Text = "Ao coletar, aplique [Arg1] camadas de <WeaknessIconKeywords:fraqueza> a todos os inimigos. Todos os despertos têm um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_100405_Name = {
    Text = "<WhiteQuality:Momo Copiado>"
  },
  RelicConfig_100405_StoryDesc = {
    Text = "Nascido do puro mal, mesmo que não fosse sua vontade"
  },
  RelicConfig_100406_BattleDesc = {
    Text = "Após acionar o efeito <DevouredIconKeywords:devorar>, outros Despertados ganham [Arg1] pontos de loucura, podendo ter efeito apenas 1 vez por turno."
  },
  RelicConfig_100406_Desc = {
    Text = "Após acionar o efeito <DevouredIconKeywords:devorar>, outros Despertados ganham [Arg1] pontos de loucura, podendo ocorrer apenas 1 vez por turno."
  },
  RelicConfig_100406_Name = {
    Text = "<WhiteQuality:Terra dos Sonhos Dourados Copiada>"
  },
  RelicConfig_100406_StoryDesc = {
    Text = "O dia da metamorfose será o seu fim"
  },
  RelicConfig_100407_BattleDesc = {
    Text = "Cada vez que causar dano, ganha [Arg1] de <PowerIconKeywords:força> temporária, até 15 ativações por turno."
  },
  RelicConfig_100407_Desc = {
    Text = "Cada vez que causar dano, ganha [Arg1] de <PowerIconKeywords:força> temporária, até 15 ativações por turno."
  },
  RelicConfig_100407_Name = {
    Text = "<WhiteQuality:Ágata Enrolada Copiada>"
  },
  RelicConfig_100407_StoryDesc = {
    Text = "Provavelmente é apenas um padrão comum de ágata. Acho"
  },
  RelicConfig_100408_BattleDesc = {
    Text = "Após liberar a \"exaltação\", ganhe [Arg1] pontos de <PowerIconKeywords:poder> temporários."
  },
  RelicConfig_100408_Desc = {
    Text = "Após liberar a \"exaltação\", ganhe [Arg1] pontos de <PowerIconKeywords:poder> temporários."
  },
  RelicConfig_100408_Name = {
    Text = "<OrangeQuality:Trava Pesada Copiada+>"
  },
  RelicConfig_100408_StoryDesc = {
    Text = "Uma fechadura grossa e robusta, difícil de abrir sem chave.\nClaro, para um mestre ladrão, isso não é nada"
  },
  RelicConfig_100409_BattleDesc = {
    Text = "Ao coletar, aplique [Arg1] camadas de <WeaknessIconKeywords:fraqueza> a todos os inimigos. Todos os despertos têm um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_100409_Desc = {
    Text = "Ao coletar, aplique [Arg1] camadas de <WeaknessIconKeywords:fraqueza> a todos os inimigos. Todos os despertos têm um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_100409_Name = {
    Text = "<OrangeQuality:Momo Copiado+>"
  },
  RelicConfig_100409_StoryDesc = {
    Text = "Nascido do puro mal, mesmo que não fosse sua vontade"
  },
  RelicConfig_100410_BattleDesc = {
    Text = "Cada vez que causar dano, ganha [Arg1] de <PowerIconKeywords:força> temporária, até 15 ativações por turno."
  },
  RelicConfig_100410_Desc = {
    Text = "Cada vez que causar dano, ganha [Arg1] de <PowerIconKeywords:força> temporária, até 15 ativações por turno."
  },
  RelicConfig_100410_Name = {
    Text = "<OrangeQuality:Ágata Enrolada Copiada+>"
  },
  RelicConfig_100410_StoryDesc = {
    Text = "Provavelmente é apenas um padrão comum de ágata. Acho"
  },
  RelicConfig_100411_BattleDesc = {
    Text = "Ao coletar, aplique [Arg1] camadas de <VulnerabilityIconKeywords:vulnerável> a todos os inimigos. Todos os despertos têm um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_100411_Desc = {
    Text = "Ao coletar, aplique [Arg1] camadas de <VulnerabilityIconKeywords:vulnerável> a todos os inimigos. Todos os despertos têm um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_100411_Name = {
    Text = "<OrangeQuality:O Sacrifício da Primavera Copiado+>"
  },
  RelicConfig_100411_StoryDesc = {
    Text = "No riso da noite, a silhueta da canoa desliza suavemente sobre o lago"
  },
  RelicConfig_100412_BattleDesc = {
    Text = "No fim do turno, recupera [Heal:Arg1] de Vida."
  },
  RelicConfig_100412_Desc = {
    Text = "No fim do turno, recupera [Heal:Arg1] de Vida."
  },
  RelicConfig_100412_Name = {
    Text = "<WhiteQuality:Sangue de Graça Copiado>"
  },
  RelicConfig_100412_StoryDesc = {
    Text = "Doce e suave, com aroma de rosas"
  },
  RelicConfig_100413_BattleDesc = {
    Text = "Perder vida para obter [Arg1]% da quantidade de vida perdida na fornalha carmesim."
  },
  RelicConfig_100413_Desc = {
    Text = "Perder vida para obter [Arg1]% da quantidade de vida perdida na fornalha carmesim."
  },
  RelicConfig_100413_Name = {
    Text = "<WhiteQuality:Serra de Aço Enferrujada Copiada>"
  },
  RelicConfig_100413_StoryDesc = {
    Text = "O doutor da dissecação passou a vida sem ver uma bela mulher, apenas um saco cheio de ossos, nervos inflamados por doenças, músculos e tecidos"
  },
  RelicConfig_100539_BattleDesc = {
    Text = "Após usar diretamente o \"embrião\" pela primeira vez em cada turno, o dano ativo causará <BleedingIconKeywords:sangramento> equivalente a [Arg1]% do dano neste turno."
  },
  RelicConfig_100539_Desc = {
    Text = "Após usar diretamente o \"embrião\" pela primeira vez em cada turno, o dano ativo causará <BleedingIconKeywords:sangramento> equivalente a [Arg1]% do dano neste turno."
  },
  RelicConfig_100539_Name = {
    Text = "<WhiteQuality:Pedra de Calçada Encharcada de Sangue Pintada com Tinta colorida>"
  },
  RelicConfig_100539_StoryDesc = {
    Text = "Um, dois, três, quatro, cinco"
  },
  RelicConfig_100540_BattleDesc = {
    Text = "Após usar diretamente o \"embrião\" pela primeira vez em cada turno, o dano ativo causará <BleedingIconKeywords:sangramento> equivalente a [Arg1]% do dano neste turno."
  },
  RelicConfig_100540_Desc = {
    Text = "Após usar diretamente o \"embrião\" pela primeira vez em cada turno, o dano ativo causará <BleedingIconKeywords:sangramento> equivalente a [Arg1]% do dano neste turno."
  },
  RelicConfig_100540_Name = {
    Text = "<OrangeQuality:Pedra de Calçada Encharcada de Sangue Copiada+>"
  },
  RelicConfig_100540_StoryDesc = {
    Text = "Um, dois, três, quatro, cinco"
  },
  RelicConfig_116382_BattleDesc = {
    Text = "Um molho de chaves enferrujadas. Pode ser usado para abrir fechaduras"
  },
  RelicConfig_116382_Desc = {
    Text = "Um molho de chaves enferrujadas. Pode ser usado para abrir fechaduras"
  },
  RelicConfig_116382_Name = {
    Text = "Chave enferrujada"
  },
  RelicConfig_116383_BattleDesc = {
    Text = "Um molho de chaves enferrujadas. Pode ser usado para abrir fechaduras"
  },
  RelicConfig_116383_Desc = {
    Text = "Um molho de chaves enferrujadas. Pode ser usado para abrir fechaduras"
  },
  RelicConfig_116383_Name = {
    Text = "Chave enferrujada"
  },
  RelicConfig_116384_BattleDesc = {
    Text = "Um molho de chaves enferrujadas. Pode ser usado para abrir fechaduras"
  },
  RelicConfig_116384_Desc = {
    Text = "Um molho de chaves enferrujadas. Pode ser usado para abrir fechaduras"
  },
  RelicConfig_116384_Name = {
    Text = "Chave enferrujada"
  },
  RelicConfig_119371_BattleDesc = {
    Text = "Limite de cartas na mão +1. \nNo início do turno, se todos os rituais não estiverem completos, ganhe <SacrificeKeyWord:Sacrifício> equivalente a 10% da Vida máxima. Adicione 1 carta de \"Oferecer aos deuses\" à mão, mantendo no máximo 1 carta."
  },
  RelicConfig_119371_Desc = {
    Text = "Limite de cartas na mão +1. \n No início do turno, se todos os rituais não estiverem completos, ganhe 10% da Vida máxima como <SacrificeKeyWord:Sacrifício>. Adicione 1 carta de \"<DerivativeCardKeywords_119:Oferecer aos deuses>\" à mão, podendo manter no máximo 1 carta."
  },
  RelicConfig_119371_Name = {
    Text = "Incensário de latão"
  },
  RelicConfig_119371_StoryDesc = {
    Text = "\"Este incensário foi feito à semelhança da arte de Lemúria, que ele possa ajudá-lo a ter noites tranquilas. Miryam.\""
  },
  RelicConfig_120372_BattleDesc = {
    Text = "Limite de cartas na mão +[Arg1]. No início do turno, coloque [Arg2] cartas de \"<PVPDerivativeCardKeywords_11:Troca Desigual>\" na mão."
  },
  RelicConfig_120372_Desc = {
    Text = "Limite de cartas na mão +[Arg1]. No início do turno, coloque [Arg2] cartas de \"<PVPDerivativeCardKeywords_11:Troca Desigual>\" na mão."
  },
  RelicConfig_120372_Name = {
    Text = "<OrangeQuality:Caleidoscópio>"
  },
  RelicConfig_120373_BattleDesc = {
    Text = "Disparar as primeiras [Arg1] \"Roda do destino\" com consumo de potência de cálculo -5/-3/-1/+1, compre 1 carta."
  },
  RelicConfig_120373_Desc = {
    Text = "Disparar as primeiras [Arg1] \"Roda do destino\" com consumo de potência de cálculo -5/-3/-1/+1, compre 1 carta."
  },
  RelicConfig_120373_Name = {
    Text = "<OrangeQuality:Medalha de Mythag>"
  },
  RelicConfig_121214_BattleDesc = {
    Text = "Imunidade ao dano"
  },
  RelicConfig_121214_Desc = {
    Text = "Imunidade ao dano"
  },
  RelicConfig_121214_Name = {
    Text = "Criação de teste invencível"
  },
  RelicConfig_121689_BattleDesc = {
    Text = "Dano Final aumentado em 250%, a cada vez que causar 1 dano, reduz 50% e aumenta o Escudo causado em 10%, podendo ser acionado até 5 vezes, reinicia após o início de cada turno."
  },
  RelicConfig_121689_Desc = {
    Text = "Dano Final aumentado em 250%, a cada dano causado reduzido em 50%, e aumenta o Escudo causado em 10%, podendo ser ativado até 5 vezes, reiniciado após o início de cada turno."
  },
  RelicConfig_121689_Name = {
    Text = "<OrangeQuality:\"Retorno Prateado: Nascimento\">"
  },
  RelicConfig_121690_BattleDesc = {
    Text = "No início da batalha, escolha 3 cartas para que elas recebam \" <RippleKeywords:Réplica>: compre uma carta e ganhe [Arg3] pontos de força temporária\". No início do turno, compre 2 cartas que tenham <RippleKeywords:Réplica>, todos os efeitos de <RippleKeywords:Réplica> são acionados uma vez adicionalmente, e após acionar 10 vezes <RippleKeywords:Réplica>, adicione 1 <DerivativeCardKeywords_1:\"Eco do Espírito\"> à sua mão."
  },
  RelicConfig_121690_Desc = {
    Text = "No início da batalha, escolha 3 cartas para que elas ganhem \"<RippleKeywords:Réplica>: compre 1 carta, ganhe [Arg3] pontos de <PowerIconKeywords:poder> temporário\". No início do turno, compre 2 cartas que possuem <RippleKeywords:Réplica>, todos os efeitos de <RippleKeywords:Réplica> são ativados uma vez a mais, e após ativar 10 vezes <RippleKeywords:Réplica>, adicione 1 <DerivativeCardKeywords_1:\"Eco do Espírito\"> à sua mão."
  },
  RelicConfig_121690_Name = {
    Text = "<OrangeQuality:\"O Retorno da Prata Pura · Loucura\">"
  },
  RelicConfig_121691_BattleDesc = {
    Text = "O Dano Final da Fúria Explosiva de todos os Corpos Despertos aumenta em 100%. Cada vez que um Corpo Desperto usa Fúria Explosiva, obtém Energia de chave igual a 500% do Aliemus Base desse Corpo Desperto, e o Aliemus Base de todos os Corpos Despertos é reduzido em 20, com um máximo de 5 vezes."
  },
  RelicConfig_121691_Desc = {
    Text = "O Dano Final da Fúria Explosiva de todos os Corpos Despertos aumenta em 100%. Cada vez que um Corpo Desperto usa Fúria Explosiva, obtém Energia de chave igual a 500% do Aliemus Base desse Corpo Desperto, e o Aliemus Base de todos os Corpos Despertos é reduzido em 20, com um máximo de 5 vezes."
  },
  RelicConfig_121691_Name = {
    Text = "<OrangeQuality:\"O Retorno da Prata Pura · medo\">"
  },
  RelicConfig_121692_BattleDesc = {
    Text = "Todos os corpos despertos têm aumento de 50% no <RetaliateIconKeywords:contrataque>, <IntoxicationIconKeywords:envenenamento>, escudo e cura de vida. Ao final do turno, ganhe <RetaliateIconKeywords:contrataque> temporário de 500% do escudo atual."
  },
  RelicConfig_121692_Desc = {
    Text = "Todos os despertos têm aumento de 50% no <RetaliateIconKeywords:contrataque>, <IntoxicationIconKeywords:envenenamento>, escudo e recuperação de vida. Ao final do turno, ganhe um <RetaliateIconKeywords:contrataque> temporário de 500% do escudo atual."
  },
  RelicConfig_121692_Name = {
    Text = "<OrangeQuality:\"O Retorno da Prata Pura · Herege\">"
  },
  RelicConfig_121693_BattleDesc = {
    Text = "Limite de cartas na mão +5. No início do turno, compre 2 cartas e ganhe 2 pontos de poder de cálculo. Cada vez que o baralho for resetado, ganhe [Arg3] pontos de <PowerIconKeywords:Força> e [Arg4] pontos de <AlertIconKeywords:Alerta> temporários, gere 1 carta de cada tipo de carta de comando não derivada do Corpo Desperto com a maior Fúria e coloque no Mazo de robo, reduzindo seu consumo de potência de cálculo em 1 ponto."
  },
  RelicConfig_121693_Desc = {
    Text = "Limite de cartas na mão +5. No início do turno, compre 2 cartas e ganhe 2 pontos de poder de cálculo. Cada vez que o baralho for resetado, receba [Arg3] pontos de <PowerIconKeywords:Força> e [Arg4] pontos temporários de <AlertIconKeywords:Alerta>, gere 1 carta de cada tipo de carta de comando não derivada para o corpo desperto com a maior fúria e coloque-as no mazo de robo, reduzindo seu consumo de potência de cálculo em 1 ponto."
  },
  RelicConfig_121693_Name = {
    Text = "<OrangeQuality:\"O Retorno da Prata Pura · Calafrio\">"
  },
  RelicConfig_121694_BattleDesc = {
    Text = "Todos os Corpos Despertos ganham 25 pontos de Fúria na primeira carta de comando de cada turno e colocam uma <DerivativeCardKeywords_4:Inspiração> na mão. Após liberar 4 vezes a Fúria Explosiva, remove o estado de <Seal:Selo> de todos os Corpos Despertos e concede 50 pontos de Fúria a todos os Corpos Despertos."
  },
  RelicConfig_121694_Desc = {
    Text = "Todos os Corpos Despertos ganham 25 pontos de Fúria na primeira carta de comando de cada turno e colocam uma <DerivativeCardKeywords_4:Inspiração> na mão. Após liberar 4 vezes a Fúria Explosiva, remova o estado de <Seal:Selo> de todos os Corpos Despertos e faça com que todos os Corpos Despertos ganhem 50 pontos de Fúria."
  },
  RelicConfig_121694_Name = {
    Text = "<OrangeQuality:\"O Retorno da Prata Pura · Deceit\">"
  },
  RelicConfig_121695_BattleDesc = {
    Text = "Ao começar a batalha, ganhe [Arg4] pontos de <PowerIconKeywords:Força>, o limite de armazenamento de energia da chave de prata aumenta em 100%. A energia da chave obtida por ponto de consumo de poder de cálculo aumenta em 100%. Após usar o Despertar da Chave de Prata ou liberar a Ordem de Chave, ganhe 20% temporário de <PowerIconKeywords:Força> equivalente à força atual e faça todos os Corpos Despertos ganharem 20 pontos de Fúria."
  },
  RelicConfig_121695_Desc = {
    Text = "Ao começar a batalha, ganhe [Arg4] pontos de <PowerIconKeywords:Força>, o limite de armazenamento da energia da chave de prata aumenta em 100%. O ganho de energia da chave de prata ao consumir cada ponto de poder de cálculo aumenta em 100%; após usar o Despertar da Chave de Prata ou liberar a Ordem de chave, ganhe 20% temporários de <PowerIconKeywords:Força> equivalentes à atual <PowerIconKeywords:Força> e faça todos os Corpos Despertos ganharem 20 pontos de Fúria."
  },
  RelicConfig_121695_Name = {
    Text = "<OrangeQuality:\"O Retorno da Prata Pura · Choro de tristeza\">"
  },
  RelicConfig_122625_BattleDesc = {
    Text = "No início da batalha, coloque [Arg1] \"<PVPDerivativeCardKeywords_25:Chá Vermelho da Sylvia>\" na mão."
  },
  RelicConfig_122625_Desc = {
    Text = "No início da batalha, coloque [Arg1] \"<PVPDerivativeCardKeywords_25:Chá Vermelho da Sylvia>\" na mão."
  },
  RelicConfig_122625_Name = {
    Text = "<OrangeQuality:Chá preto de Ceilão>"
  },
  RelicConfig_122626_BattleDesc = {
    Text = "No início de cada rodada, coloque [Arg1] cartas \"<PVPDerivativeCardKeywords_14:Realidade imitada>\" no mazo de robo, pertencente a um corpo desperto aleatório."
  },
  RelicConfig_122626_Desc = {
    Text = "No início de cada rodada, coloque [Arg1] cartas \"<PVPDerivativeCardKeywords_14:Realidade imitada>\" no mazo de robo, pertencentes a um corpo desperto aleatório."
  },
  RelicConfig_122626_Name = {
    Text = "<OrangeQuality:Luvas Mágicas>"
  },
  RelicConfig_122627_BattleDesc = {
    Text = "O primeiro \"habilidade\" disparado em cada turno aumenta o dano, cura e escudo em [Arg1]%."
  },
  RelicConfig_122627_Desc = {
    Text = "O primeiro \"habilidade\" disparado a cada turno aumenta o dano, cura e escudo em [Arg1]% ."
  },
  RelicConfig_122627_Name = {
    Text = "<OrangeQuality:Broche de Rubi>"
  },
  RelicConfig_122628_BattleDesc = {
    Text = "No final do turno, ganhe adicionalmente <Energy:[Arg1]> de Fúria."
  },
  RelicConfig_122628_Desc = {
    Text = "No final do turno, ganhe adicionalmente <Energy:[Arg1]> de Fúria."
  },
  RelicConfig_122628_Name = {
    Text = "<OrangeQuality:Manifestação do Pesadelo>"
  },
  RelicConfig_122629_BattleDesc = {
    Text = "No mazo de robo haverá cartas de corpo desperto em dobro. Após disparar uma carta, se o número de cartas na mão for menor que [Arg1] pela primeira vez nesta rodada, compre [Arg2] cartas."
  },
  RelicConfig_122629_Desc = {
    Text = "No mazo de robo haverá cartas de Corpo Desperto em dobro. Após disparar uma carta, se o número de cartas na mão for menor que [Arg1] pela primeira vez nesta rodada, compre [Arg2] cartas."
  },
  RelicConfig_122629_Name = {
    Text = "<OrangeQuality:Disco feliz>"
  },
  RelicConfig_122630_BattleDesc = {
    Text = "Limite de cartas na mão +[Arg1]. No início de cada turno, coloque [Arg2] cartas de \"<PVPDerivativeCardKeywords_13:Funeral imortal>\" na pilha de compra."
  },
  RelicConfig_122630_Desc = {
    Text = "Limite de cartas na mão +[Arg1]. Em cada rodada, insira [Arg2] cartas de \"<PVPDerivativeCardKeywords_13:Funeral imortal>\" na pilha de compra."
  },
  RelicConfig_122630_Name = {
    Text = "<OrangeQuality:Faca Ritual Perdida>"
  },
  RelicConfig_122768_BattleDesc = {
    Text = "No início do turno, compre [Arg1] cartas \"Golpe\" com Custo de Aritmética -1. Após liberar Exaltação, gere [Arg2] cartas \"Golpe\" do Despertador correspondente com <DepleteIconKeywords:Exausto>, <PrepareKeypvewords:Preparar 1>, e <RetainIconKeywords:Retenção>. \n Para cada [Arg3] \"Golpe\" jogado em 1 turno, ganhe [Arg4] Temporário <PowerIconKeywords:Poder>; após jogar [Arg5] cartas \"Golpe\", compre [Arg6] cartas e ganhe [Arg7] Aritmética; após jogar [Arg8] cartas \"Golpe\", todos os Despertadores ganham [Arg9] Aliemus."
  },
  RelicConfig_122768_Desc = {
    Text = "No início do turno, compre [Arg1] cartas \"Golpe\" com Custo de Aritmética -1. Após liberar Exaltação, gere [Arg2] cartas \"Golpe\" do Despertador correspondente com <DepleteIconKeywords:Exausto>, <PrepareKeypvewords:Preparar 1>, e <RetainIconKeywords:Retenção>. \n Para cada [Arg3] \"Golpe\" jogado em 1 turno, ganhe [Arg4] Temporário <PowerIconKeywords:Poder>; após jogar [Arg5] cartas \"Golpe\", compre [Arg6] cartas e ganhe [Arg7] Aritmética; após jogar [Arg8] cartas \"Golpe\", todos os Despertadores ganham [Arg9] Aliemus."
  },
  RelicConfig_122768_Name = {
    Text = "Eco do Outro Mundo"
  },
  RelicConfig_122768_StoryDesc = {
    Text = "Ecos misturados na névoa de outro mundo, levando à distorção, à loucura e à realidade inegável."
  },
  RelicConfig_123724_BattleDesc = {
    Text = "No início do turno, Mouchette ganha [Arg1] pontos de loucura, gerando 1 carta de \"golpe\" temporária com custo de aritmética 0 de Mouchette. Cada vez que \"Encontro dramático\" é ativado, o efeito de aumento do dano básico e do dano de \"Brilho☆Redemoinho\" nesta batalha aumenta em [Arg2]%."
  },
  RelicConfig_123724_Desc = {
    Text = "No início do turno, Mouchette ganha [Arg1] pontos de loucura, gerando 1 carta de \"golpe\" temporária com custo de aritmética 0 de Mouchette. Cada vez que \"Encontro dramático\" é ativado, o efeito de aumento do dano básico e do dano de \"Brilho☆Redemoinho\" nesta batalha aumenta em [Arg2]%."
  },
  RelicConfig_123724_Name = {
    Text = "<OrangeQuality:Imagem Dimensional: Moxia>"
  },
  RelicConfig_125488_BattleDesc = {
    Text = "Todos os Corpos Despertos ganham [Arg1] pontos de Fúria ao disparar a carta de comando pela primeira vez em cada turno. Após disparar 4 cartas de comando pertencentes a Despertados diferentes em um único turno, aplique [Arg2]% da Vida máxima do nosso lado como <IntoxicationIconKeywords:envenenamento> a todos os inimigos."
  },
  RelicConfig_125488_Desc = {
    Text = "Todos os Corpos Despertos ganham [Arg1] pontos de Fúria ao disparar a carta de comando pela primeira vez em cada turno. Após disparar 4 cartas de comando pertencentes a Despertados diferentes em um único turno, aplique [Arg2]% da Vida máxima do nosso lado de <IntoxicationIconKeywords:envenenamento> a todos os inimigos."
  },
  RelicConfig_125488_Name = {
    Text = "A Arrogância das Concubinas"
  },
  RelicConfig_125489_BattleDesc = {
    Text = "No início do turno, Xu ganha [Arg1] de Aliemus e aplica 1 pilha de <WitherKeywords:Enfeitiçado> em todos os inimigos. A primeira Carta de Comando que Xu jogar a cada turno sempre ativará o efeito \"Ressonância\"."
  },
  RelicConfig_125489_Desc = {
    Text = "No início do turno, Xu ganha [Arg1] de Aliemus e aplica 1 pilha de <WitherKeywords:Enfeitiçado> em todos os inimigos. A primeira Carta de Comando que Xu jogar a cada turno sempre ativará o efeito \"Ressonância\"."
  },
  RelicConfig_125489_Name = {
    Text = "<OrangeQuality:Imagem Dimensional: Xu>"
  },
  RelicConfig_126673_BattleDesc = {
    Text = "Tamanho Máximo da Mão +3. Registre as primeiras 3 Cartas de Comando Não Derivadas jogadas a cada turno, e no início do turno 3 turnos depois, reduza seu Custo de Aritmética em 1 e adicione cópias com <DepleteIconKeywords:Esgotar> à sua mão."
  },
  RelicConfig_126673_Desc = {
    Text = "Tamanho Máximo da Mão +3. Registre as primeiras 3 Cartas de Comando Não Derivadas jogadas a cada turno, e no início do turno 3 turnos depois, reduza seu Custo de Aritmética em 1 e adicione cópias com <DepleteIconKeywords:Esgotar> à sua mão."
  },
  RelicConfig_126673_Name = {
    Text = "Roda do destino"
  },
  RelicConfig_126673_StoryDesc = {
    Text = "A roda gira para sempre."
  },
  RelicConfig_129304_BattleDesc = {
    Text = "<OrangeQuality:Harmonia Dourada>: \"Ajuste de potência de cálculo\" agora só aumenta o Consumo de potência de cálculo em 1. Cada 1% de Dano potencializado aumenta a Profundidade da Pesquisa da Consciência em 1%.\n<OrangeQuality:Presente Dimensional>: Ao iniciar a exploração, ganhe aleatoriamente 1 Criação de Imagem Dimensional. Limite de Mão +2.\n<OrangeQuality:Ritual de Benção>: As recompensas por derrotar o Líder da primeira e segunda fase mudam para uma seleção de 3 Criações Benditas.\n<RedQuality:Cansaço de longa distância>: Efeitos de recuperação de toda a Vida durante a batalha diminuem em 50%. Quando \"Enterro\" é selecionado em \"Ossos Desbotados,\" o efeito muda para restaurar 25% da Vida máxima.\n<RedQuality:Sinais de Tontura>: Ao iniciar a batalha, a Fúria e a Energia de chave atuais de todos os Corpos Despertos diminuem em 50%.\n<RedQuality:Corredor da Noite Eterna>: Ao iniciar a exploração, o Aliemus Base e o limite de Energia de chave de todos os Corpos Despertos aumentam em 50%."
  },
  RelicConfig_129304_Desc = {
    Text = "<OrangeQuality:Harmonia Dourada>: \"Ajuste de potência de cálculo\" agora só aumenta o Consumo de potência de cálculo em 1. Cada 1% de Dano potencializado aumenta a Profundidade da Pesquisa da Consciência em 1%.\n<OrangeQuality:Presente Dimensional>: Ao iniciar a exploração, ganhe aleatoriamente 1 Criação de Imagem Dimensional. Limite de Mão +2.\n<OrangeQuality:Ritual de Benção>: As recompensas por derrotar o Líder da primeira e segunda fase mudam para uma seleção de 3 Criações Benditas.\n<RedQuality:Cansaço de longa distância>: Efeitos de recuperação de toda a Vida durante a batalha diminuem em 50%. Quando \"Enterro\" é selecionado em \"Ossos Desbotados,\" o efeito muda para restaurar 25% da Vida máxima.\n<RedQuality:Sinais de Tontura>: Ao iniciar a batalha, a Fúria e a Energia de chave atuais de todos os Corpos Despertos diminuem em 50%.\n<RedQuality:Corredor da Noite Eterna>: Ao iniciar a exploração, o Aliemus Base e o limite de Energia de chave de todos os Corpos Despertos aumentam em 50%."
  },
  RelicConfig_129304_Name = {
    Text = "<OrangeQuality:Caos da Câmera Pequena\"N\">"
  },
  RelicConfig_129304_StoryDesc = {
    Text = "Quebrou tudo! A câmera quebrou de vez! Hã? Como ainda está funcionando? Espera! O que são essas limitações?!"
  },
  RelicConfig_129305_BattleDesc = {
    Text = "<OrangeQuality:Harmonia Dourada>: \"Ajuste de potência de cálculo\" agora só aumenta o Consumo de potência de cálculo em 1. Cada 1% de Dano potencializado aumenta a Profundidade da Pesquisa da Consciência em 1%.\n<RedQuality:Cansaço de longa distância>: Redução de 50% em todos os efeitos de recuperação de vida durante a batalha. Quando \"Enterro\" é selecionado em \"Ossos Desbotados,\" o efeito muda para restaurar 25% da Vida máxima."
  },
  RelicConfig_129305_Desc = {
    Text = "<OrangeQuality:Harmonia Dourada>: \"Ajuste de potência de cálculo\" agora só aumenta o Consumo de potência de cálculo em 1. Cada 1% de Dano potencializado aumenta a Profundidade da Pesquisa da Consciência em 1%.\n<RedQuality:Cansaço de longa distância>: Redução de 50% em todos os efeitos de recuperação de vida durante a batalha. Quando \"Enterro\" é selecionado em \"Ossos Desbotados,\" o efeito muda para restaurar 25% da Vida máxima."
  },
  RelicConfig_129305_Name = {
    Text = "<OrangeQuality:Câmera Completa do Pequeno\"N\">"
  },
  RelicConfig_129305_StoryDesc = {
    Text = "Não olhe mais, esta é a câmera! Novinha, sem enganação."
  },
  RelicConfig_129306_BattleDesc = {
    Text = "<OrangeQuality:Harmonia Dourada>: \"Ajuste de potência de cálculo\" agora só aumenta o Consumo de potência de cálculo em 1. Cada 1% de Dano potencializado aumenta a Profundidade da Pesquisa da Consciência em 1%.\n<OrangeQuality:Presente Dimensional>: Ao iniciar a exploração, ganhe aleatoriamente 1 Criação de Imagem Dimensional. Limite de Mão +1.\n<RedQuality:Cansaço de longa distância>: Todos os efeitos de recuperação de Vida durante a batalha são reduzidos em 50%. Quando \"Enterro\" é selecionado em \"Ossos Desbotados,\" o efeito muda para restaurar 25% da Vida máxima.\n<RedQuality:Sinais de tontura>: Ao iniciar a batalha, a Fúria atual de todos os Corpos Despertos e a Energia de chave são reduzidas em 50%."
  },
  RelicConfig_129306_Desc = {
    Text = "<OrangeQuality:Harmonia Dourada>: \"Ajuste de potência de cálculo\" agora só aumenta o Consumo de potência de cálculo em 1. Cada 1% de Dano potencializado aumenta a Profundidade da Pesquisa da Consciência em 1%.\n<OrangeQuality:Presente Dimensional>: Ao iniciar a exploração, ganhe aleatoriamente 1 Criação de Imagem Dimensional. Limite de Mão +1.\n<RedQuality:Cansaço de longa distância>: Todos os efeitos de recuperação de Vida durante a batalha são reduzidos em 50%. Quando \"Enterro\" é selecionado em \"Ossos Desbotados,\" o efeito muda para restaurar 25% da Vida máxima.\n<RedQuality:Sinais de tontura>: Ao iniciar a batalha, a Fúria atual de todos os Corpos Despertos e a Energia de chave são reduzidas em 50%."
  },
  RelicConfig_129306_Name = {
    Text = "<OrangeQuality:Pequena \"N\" Câmera Velha>"
  },
  RelicConfig_129306_StoryDesc = {
    Text = "Acabou! A câmera foi danificada! Deixe-me consertar... Ligou! Mas por que está parecendo estranho..."
  },
  RelicConfig_131079_BattleDesc = {
    Text = "No início do turno, Mosk ganha [Arg1] de Fúria. O primeiro \"Carregar!\" ou \"Carregar\" disparado em cada turno tem efeito 2 vezes."
  },
  RelicConfig_131079_Desc = {
    Text = "No início do turno, Mosk ganha [Arg1] de Fúria. O primeiro \"Carregar!\" ou \"Carregar\" disparado em cada turno tem efeito 2 vezes."
  },
  RelicConfig_131079_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Mosk>"
  },
  RelicConfig_131080_BattleDesc = {
    Text = "Nos primeiros 3 turnos, acione \"Dilema do Lontra\" uma vez a cada turno. No início do 5º turno, remova todos os efeitos negativos de \"Dilema do Lontra\" e ganhe \"<DerivativeCardKeywords_135:Impacto·Dois>\"."
  },
  RelicConfig_131080_Desc = {
    Text = "Nos primeiros 3 turnos, acione \"Dilema do Lontra\" uma vez a cada turno. No início do 5º turno, remova todos os efeitos negativos de \"Dilema do Lontra\" e ganhe \"<DerivativeCardKeywords_135:Impacto·Dois>\"."
  },
  RelicConfig_131080_Name = {
    Text = "Pequena bola de carvão, Segundo"
  },
  RelicConfig_131080_StoryDesc = {
    Text = "A senhora Mosk disse firmemente que isso é Criação.\n\"Mau, morde-o!\""
  },
  RelicConfig_131178_BattleDesc = {
    Text = "No Começar da batalha, Embaralhar uma \"<DerivativeCardKeywords_134:Verdade Proibida>\" no deck. Comprar carta +[Arg1] a cada turno. Após Disparar uma Carta de comando, conceder aleatoriamente <ErosionColorInkKeywords:Distorção de Percepção> a [Arg2] Cartas de comando na mão do oponente."
  },
  RelicConfig_131178_Desc = {
    Text = "No Começar da batalha, Embaralhar uma \"<DerivativeCardKeywords_134:Verdade Proibida>\" no deck. Comprar carta +[Arg1] a cada turno. Após Disparar uma Carta de comando, conceder aleatoriamente <ErosionColorInkKeywords:Distorção de Percepção> a [Arg2] Cartas de comando na mão do oponente."
  },
  RelicConfig_131178_Name = {
    Text = "Notas de Aoyá"
  },
  RelicConfig_131178_StoryDesc = {
    Text = "O conteúdo registrado contém setenta números primos de Mason."
  },
  RelicConfig_132540_BattleDesc = {
    Text = "Imunidade ao dano"
  },
  RelicConfig_132540_Name = {
    Text = "Artefato de Teste de Conjunto"
  },
  RelicConfig_13740_BattleDesc = {
    Text = "Taxa crítica aumenta em 15%. Se a vida estiver abaixo de 25% ([Arg1]) no início da rodada, a taxa crítica aumenta em mais 30% durante aquela rodada"
  },
  RelicConfig_13740_Desc = {
    Text = "Taxa crítica aumenta em 15%. Se a vida estiver abaixo de 25% no início da rodada, a taxa crítica aumenta em mais 30% durante aquela rodada"
  },
  RelicConfig_13740_Name = {
    Text = "<OrangeQuality:Astrolábio do Grimório>"
  },
  RelicConfig_13740_StoryDesc = {
    Text = "Mistérios do universo"
  },
  RelicConfig_13741_BattleDesc = {
    Text = "Dano Crítico +15%. Dano contra inimigos com escudo será sempre crítico"
  },
  RelicConfig_13741_Desc = {
    Text = "Dano Crítico +15%. Dano contra inimigos com escudo será sempre crítico"
  },
  RelicConfig_13741_Name = {
    Text = "<WhiteQuality:Estética>"
  },
  RelicConfig_13741_StoryDesc = {
    Text = "Artista de cera: ajudante do médico, cliente da indústria funerária, provedor dos vermes do túmulo"
  },
  RelicConfig_13742_BattleDesc = {
    Text = "Dano Crítico +50%. Cada terceiro ataque será crítico"
  },
  RelicConfig_13742_Desc = {
    Text = "Dano Crítico +50%. Cada terceiro ataque será crítico"
  },
  RelicConfig_13742_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Meditação\">"
  },
  RelicConfig_13743_BattleDesc = {
    Text = "Ao iniciar a rodada, o despertar com menos loucura ganha 15 de loucura. Ao jogar 2 cartas consecutivas com um custo de aritmética menor que a última, o despertar com menos loucura ganha 15 de loucura"
  },
  RelicConfig_13743_Desc = {
    Text = "Ao iniciar a rodada, o despertar com menos loucura ganha 15 de loucura. Ao jogar 2 cartas consecutivas com um custo de aritmética menor que a última, o despertar com menos loucura ganha 15 de loucura"
  },
  RelicConfig_13743_Name = {
    Text = "<OrangeQuality:Relíquia Arcana>"
  },
  RelicConfig_13743_StoryDesc = {
    Text = "Fim do destino"
  },
  RelicConfig_13744_BattleDesc = {
    Text = "Após o início do turno, o Despertado com menos loucura ganha 15 de loucura"
  },
  RelicConfig_13744_Desc = {
    Text = "Após o início do turno, o Despertado com menos loucura ganha 15 de loucura"
  },
  RelicConfig_13744_Name = {
    Text = "<WhiteQuality:Abotoadura de Louro>"
  },
  RelicConfig_13744_StoryDesc = {
    Text = "Abotoaduras de prata com padrão de folhas de louro.\nElas são bem feitas, brilhantes, e uma vez simbolizaram a amizade de duas crianças"
  },
  RelicConfig_13745_BattleDesc = {
    Text = "O efeito de bônus do reino foi aumentado para 50%, e sua taxa de impressão de sorte dobrará no início da fase"
  },
  RelicConfig_13745_Desc = {
    Text = "O efeito de bônus do reino foi aumentado para 50%, e sua taxa de impressão de sorte dobrará no início da fase"
  },
  RelicConfig_13745_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Sonho Profundo\">"
  },
  RelicConfig_13747_BattleDesc = {
    Text = "Imune a 1 morte, recupera 10% de vida após ativar, falha permanentemente após 3 ativações"
  },
  RelicConfig_13747_Desc = {
    Text = "Imune a 1 morte, recupera 10% de vida após ativar, falha permanentemente após 3 ativações"
  },
  RelicConfig_13747_Name = {
    Text = "<WhiteQuality:☆Comida de Emergência☆>"
  },
  RelicConfig_13747_StoryDesc = {
    Text = "Só em último caso, não coma isso"
  },
  RelicConfig_13748_BattleDesc = {
    Text = "Ao início da batalha, o dano das cartas com custo de 1 de aritmética aumenta em [Arg1] pontos, e o escudo aumenta em [Arg2] pontos durante esta batalha"
  },
  RelicConfig_13748_Desc = {
    Text = "Ao início da batalha, o dano das cartas com custo de 1 de aritmética aumenta em [Arg1] pontos, e o escudo aumenta em [Arg2] pontos durante esta batalha"
  },
  RelicConfig_13748_Name = {
    Text = "<OrangeQuality:Maria Pura>"
  },
  RelicConfig_13748_StoryDesc = {
    Text = "A lógica é como coquetel, em excesso perde seu benefício"
  },
  RelicConfig_13749_BattleDesc = {
    Text = "A cada 4 rodadas, dobra o Dano Ativo e Dano de tentáculo que todos os inimigos recebem nesta rodada. Porém, após liberar a Fúria Explosiva nesta rodada, sela todos os Corpos Despertos por 1 rodada"
  },
  RelicConfig_13749_Desc = {
    Text = "A cada 4 rodadas, dobra o Dano Ativo e Dano de tentáculo que todos os inimigos recebem nesta rodada. Porém, após liberar a Fúria Explosiva nesta rodada, sela todos os Corpos Despertos por 1 rodada"
  },
  RelicConfig_13749_Name = {
    Text = "<RedQuality:Cadáver do Caminho>"
  },
  RelicConfig_13749_StoryDesc = {
    Text = [[
Uma parte sagrada.
Mesmo separada do corpo, suas pegadas se espalharam pelos mares]]
  },
  RelicConfig_13750_BattleDesc = {
    Text = "No final do turno, se não houver escudo, ganhe 1 camada de <ParcloseIconKeywords:Barreira> que bloqueia um dano. Só funciona uma vez por batalha"
  },
  RelicConfig_13750_Desc = {
    Text = "No final do turno, se não houver escudo, ganhe 1 camada de <ParcloseIconKeywords:Barreira> que bloqueia um dano. Só funciona uma vez por batalha"
  },
  RelicConfig_13750_Name = {
    Text = "<WhiteQuality:☆Analgésico☆>"
  },
  RelicConfig_13750_StoryDesc = {
    Text = "Os efeitos não são tão permanentes"
  },
  RelicConfig_13751_BattleDesc = {
    Text = "Taxa crítica aumenta em 25%, e o dano causado na primeira vez de cada rodada é dobrado"
  },
  RelicConfig_13751_Desc = {
    Text = "Taxa crítica aumenta em 25%, e o dano causado na primeira vez de cada rodada é dobrado"
  },
  RelicConfig_13751_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Aprofundando\">"
  },
  RelicConfig_13752_BattleDesc = {
    Text = "Recupere [Arg1] de vida no início do turno. Se a vida estiver abaixo de 50%, a recuperação aumenta para [Arg2]"
  },
  RelicConfig_13752_Desc = {
    Text = "Recupere [Arg1] de vida no início do turno. Se a vida estiver abaixo de 50%, a recuperação aumenta para [Arg2]"
  },
  RelicConfig_13752_Name = {
    Text = "<WhiteQuality:Sangue Abençoado>"
  },
  RelicConfig_13752_StoryDesc = {
    Text = "Doce e suave, com aroma de rosas"
  },
  RelicConfig_13753_BattleDesc = {
    Text = "É um item de missão sem efeito"
  },
  RelicConfig_13753_Desc = {
    Text = "É um item de missão sem efeito"
  },
  RelicConfig_13753_Name = {
    Text = "Teste de criação da missão"
  },
  RelicConfig_13753_StoryDesc = {
    Text = "Criação que precisa de conteúdo adicional"
  },
  RelicConfig_13754_BattleDesc = {
    Text = "A cada 5º dano que você causa é um crítico garantido"
  },
  RelicConfig_13754_Desc = {
    Text = "A cada 5º dano que você causa é um crítico garantido"
  },
  RelicConfig_13754_Name = {
    Text = "<WhiteQuality:Corretor de Visão>"
  },
  RelicConfig_13754_StoryDesc = {
    Text = "Alguém uma vez encontrou a verdade através dele"
  },
  RelicConfig_13755_BattleDesc = {
    Text = "Ao iniciar a rodada, <DimensionalSpaceIconKeywords:ultra> para cada carta, receba [Arg1] pontos de <PowerIconKeywords:poder> temporário; se esta rodada for uma rodada ultra, ganhe [Arg2] pontos de <PowerIconKeywords:poder> temporário"
  },
  RelicConfig_13755_Desc = {
    Text = "Ao iniciar a rodada, <DimensionalSpaceIconKeywords:ultra> para cada carta, receba [Arg1] pontos de <PowerIconKeywords:poder> temporário; se esta rodada for uma rodada ultra, ganhe [Arg2] pontos de <PowerIconKeywords:poder> temporário"
  },
  RelicConfig_13755_Name = {
    Text = "<WhiteQuality:Prisma>"
  },
  RelicConfig_13755_StoryDesc = {
    Text = "\"A luz é composta de sete cores.\""
  },
  RelicConfig_13756_BattleDesc = {
    Text = "Ao pegar, perca todas as outras relíquias e ganhe aleatoriamente 2 relíquias de ouro"
  },
  RelicConfig_13756_Desc = {
    Text = "Ao pegar, perca todas as outras relíquias e ganhe aleatoriamente 2 relíquias de ouro"
  },
  RelicConfig_13756_Name = {
    Text = "<RedQuality:☆Observação Inversa☆>"
  },
  RelicConfig_13756_StoryDesc = {
    Text = "Na era estranha, as flores eram os primeiros espectadores da humanidade.\nNão se mova, elas preferem exposições silenciosas"
  },
  RelicConfig_13757_BattleDesc = {
    Text = "A cada 8ª carta de comando jogada, ela terá efeito 2 vezes"
  },
  RelicConfig_13757_Desc = {
    Text = "A cada 8ª carta de comando jogada, ela terá efeito 2 vezes"
  },
  RelicConfig_13757_Name = {
    Text = "<OrangeQuality:Vinho das Estrelas>"
  },
  RelicConfig_13757_StoryDesc = {
    Text = "Vagando entre as estrelas"
  },
  RelicConfig_13758_BattleDesc = {
    Text = "Ao ser coletado, aumenta a saúde máxima em [Arg1] pontos, e a loucura obtida ao receber dano aumenta em 2 pontos"
  },
  RelicConfig_13758_Desc = {
    Text = "Ao ser coletado, aumenta a saúde máxima em [Arg1] pontos, e a loucura obtida ao receber dano aumenta em 2 pontos"
  },
  RelicConfig_13758_Name = {
    Text = "<WhiteQuality:Tinta Doce>"
  },
  RelicConfig_13758_StoryDesc = {
    Text = "Alguém disse que é sangue de demônio, mas, ei, vamos tentar!"
  },
  RelicConfig_13759_BattleDesc = {
    Text = "Ao liberar a exaltação, cada vez que o inimigo causar 1 ponto de dano, aplique [Arg1] camadas de <IntoxicationIconKeywords:veneno>"
  },
  RelicConfig_13759_Desc = {
    Text = "Ao liberar a exaltação, cada vez que o inimigo causar 1 ponto de dano, aplique [Arg1] camadas de <IntoxicationIconKeywords:veneno>"
  },
  RelicConfig_13759_Name = {
    Text = "<WhiteQuality:☆Mandíbula a Laser☆>"
  },
  RelicConfig_13759_StoryDesc = {
    Text = "Ossos exibidos na galeria privada de um colecionador.\nO colecionador era fascinado pelo brilho bonito, admirando-o dia e noite, até morrer e se tornar um deles"
  },
  RelicConfig_13760_BattleDesc = {
    Text = "A saúde máxima aumenta em 1. Quando jogar 2 cartas com custo de aritmética superior à da carta anterior, ganha 1 aritmética"
  },
  RelicConfig_13760_Desc = {
    Text = "A saúde máxima aumenta em 1. Quando jogar 2 cartas com custo de aritmética superior à da carta anterior, ganha 1 aritmética"
  },
  RelicConfig_13760_Name = {
    Text = "<OrangeQuality:Registro Arcano>"
  },
  RelicConfig_13760_StoryDesc = {
    Text = "Tendência do destino"
  },
  RelicConfig_13761_BattleDesc = {
    Text = "Ao iniciar a rodada, se o número de cartas restantes do último turno exceder 3, ganhe 2 aritméticas"
  },
  RelicConfig_13761_Desc = {
    Text = "Ao iniciar a rodada, se o número de cartas restantes do último turno exceder 3, ganhe 2 aritméticas"
  },
  RelicConfig_13761_Name = {
    Text = "<WhiteQuality:emblema de mythag>"
  },
  RelicConfig_13761_StoryDesc = {
    Text = "O distintivo distribuído pela Universidade de Mythag aos investigadores. Ele não só simboliza a identidade do portador, mas também é uma ferramenta de comunicação remota"
  },
  RelicConfig_13762_BattleDesc = {
    Text = "Ao jogar \"Defesa\", ganhe [Arg1] pontos de <RetaliateIconKeywords:retaliar>"
  },
  RelicConfig_13762_Desc = {
    Text = "Ao jogar \"Defesa\", ganhe [Arg1] pontos de <RetaliateIconKeywords:retaliar>"
  },
  RelicConfig_13762_Name = {
    Text = "Colete de Urtiga Mutante"
  },
  RelicConfig_13762_StoryDesc = {
    Text = "Não pode identificar o líquido contaminado"
  },
  RelicConfig_13763_BattleDesc = {
    Text = "Ao início da batalha, ganha [Arg1] pontos de escudo. Se possui escudo no início do turno, o escudo e o efeito de cura neste turno aumentam em 50%"
  },
  RelicConfig_13763_Desc = {
    Text = "Ao início da batalha, ganha [Arg1] pontos de escudo. Se possui escudo no início do turno, o escudo e o efeito de cura neste turno aumentam em 50%"
  },
  RelicConfig_13763_Name = {
    Text = "Guardião do Jardim Alienado"
  },
  RelicConfig_13764_BattleDesc = {
    Text = "Ao pegar, ganha permanentemente [Arg1] de <PowerIconKeywords:força>"
  },
  RelicConfig_13764_Desc = {
    Text = "Ao pegar, ganha permanentemente [Arg1] de <PowerIconKeywords:força>"
  },
  RelicConfig_13764_Name = {
    Text = "<WhiteQuality:Broche de Rubi>"
  },
  RelicConfig_13764_StoryDesc = {
    Text = "Vermelho escorrendo"
  },
  RelicConfig_13766_BattleDesc = {
    Text = "Ao coletar, escolha uma carta e atribua a ela dois efeitos de fortalecimento de três opções. (Nota: semelhante a mil miragens.)"
  },
  RelicConfig_13766_Desc = {
    Text = "Ao coletar, escolha uma carta e atribua a ela dois efeitos de fortalecimento de três opções. (Nota: semelhante a mil miragens.)"
  },
  RelicConfig_13766_Name = {
    Text = "<OrangeQuality:☆Máquina de Escrever de Mestre☆>"
  },
  RelicConfig_13766_StoryDesc = {
    Text = "Dizem que as verdadeiras obras-primas foram escritas por máquinas de escrever"
  },
  RelicConfig_13767_BattleDesc = {
    Text = "Ao pegar, ganhe 1 entre 3 marcas avançadas aleatórias, e atribua à carta correspondente"
  },
  RelicConfig_13767_Desc = {
    Text = "Ao pegar, ganhe 1 entre 3 marcas avançadas aleatórias, e atribua à carta correspondente"
  },
  RelicConfig_13767_Name = {
    Text = "<WhiteQuality:Papiro de Reind>"
  },
  RelicConfig_13767_StoryDesc = {
    Text = "Agora, a pergunta: 10 monges dividem 6 pães, quanto cada um recebe?"
  },
  RelicConfig_13768_BattleDesc = {
    Text = "A saúde máxima aumenta em 2. Após jogar \"Golpe\" ou \"Defesa\", o despertador correspondente ganha 5 pontos de aliemus. Após liberar aliemus, ganhe 1 \"Golpe\" que consome ilusão anexada ao despertador correspondente, após liberar o bando, ganhe aleatoriamente 1 \"Defesa\" que consome ilusão"
  },
  RelicConfig_13768_Desc = {
    Text = "A saúde máxima aumenta em 2. Após jogar \"Golpe\" ou \"Defesa\", o despertador correspondente ganha 5 pontos de aliemus. Após liberar aliemus, ganhe 1 \"Golpe\" que consome ilusão anexada ao despertador correspondente, após liberar o bando, ganhe aleatoriamente 1 \"Defesa\" que consome ilusão"
  },
  RelicConfig_13768_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Asas\">"
  },
  RelicConfig_13769_BattleDesc = {
    Text = "No início do turno, <EmbryoFusionIconKeywords:Fusão de embriões>+30. Todos os seus efeitos de <DevouredIconKeywords:Devorar> se tornam <UnlimitedDevouredIconKeywords:Devorar sem limites>"
  },
  RelicConfig_13769_Desc = {
    Text = "No início do turno, <EmbryoFusionIconKeywords:Fusão de embriões>+30. Todos os seus efeitos de <DevouredIconKeywords:Devorar> se tornam <UnlimitedDevouredIconKeywords:Devorar sem limites>"
  },
  RelicConfig_13769_Name = {
    Text = "<RedQuality:Cordão Umbilical Contorcido>"
  },
  RelicConfig_13769_StoryDesc = {
    Text = "Entrelaçar em torno do pescoço"
  },
  RelicConfig_13770_BattleDesc = {
    Text = "No início do turno, ganhe [Arg1] de escudo, aumentando em [Arg2] a cada turno"
  },
  RelicConfig_13770_Desc = {
    Text = "No início do turno, ganhe [Arg1] de escudo, aumentando em [Arg2] a cada turno"
  },
  RelicConfig_13770_Name = {
    Text = "<WhiteQuality:Mão Protetora>"
  },
  RelicConfig_13770_StoryDesc = {
    Text = "Mãos de bênção, punhos firmes"
  },
  RelicConfig_13771_BattleDesc = {
    Text = "O nível de Regeneração de Chave de todos os Despertadores aumentou em 30. Após liberar o Bando, embaralhe 3 <DerivativeCardKeywords_4:\"Inspiração\"> no seu baralho."
  },
  RelicConfig_13771_Desc = {
    Text = "O nível de Regeneração de Chave de todos os Despertadores aumentou em 30. Após liberar o Bando, embaralhe 3 <DerivativeCardKeywords_4:\"Inspiração\"> no seu baralho."
  },
  RelicConfig_13771_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Soneca Leve\">"
  },
  RelicConfig_13772_BattleDesc = {
    Text = "Ao final da batalha, ganha adicionalmente 75 selos negros e 1 carta de sintoma"
  },
  RelicConfig_13772_Desc = {
    Text = "Ao final da batalha, ganha adicionalmente 75 selos negros e 1 carta de sintoma"
  },
  RelicConfig_13772_Name = {
    Text = "<RedQuality:Impressão de Jade>"
  },
  RelicConfig_13772_StoryDesc = {
    Text = "Esta impressão é imortal por mil anos"
  },
  RelicConfig_13773_BattleDesc = {
    Text = "A cada vez que causar dano ativo, aplique [Arg1] camadas de <BleedingIconKeywords:sangrando> a si mesmo e [Arg2] camadas de <BleedingIconKeywords:sangrando> ao alvo do dano. A cada inimigo morto, dissipe seu estado de <BleedingIconKeywords:sangrando>"
  },
  RelicConfig_13773_Desc = {
    Text = "A cada vez que causar dano ativo, aplique [Arg1] camadas de <BleedingIconKeywords:sangrando> a si mesmo e [Arg2] camadas de <BleedingIconKeywords:sangrando> ao alvo do dano. A cada inimigo morto, dissipe seu estado de <BleedingIconKeywords:sangrando>"
  },
  RelicConfig_13773_Name = {
    Text = "<RedQuality:Consciência do Enxame>"
  },
  RelicConfig_13773_StoryDesc = {
    Text = "Entrelaçar, simbiose, aglomeração; medo, desconhecido, controle"
  },
  RelicConfig_13774_BattleDesc = {
    Text = "Ao jogar 1 carta com custo de aritmética real de 3, puxe 1 carta e ganhe 2 de aritmética; ao jogar 1 carta com custo de aritmética real de 4 ou mais, o consumo de aritmética de outras cartas na mão diminui em 1"
  },
  RelicConfig_13774_Desc = {
    Text = "Ao jogar 1 carta com custo de aritmética real de 3, puxe 1 carta e ganhe 2 de aritmética; ao jogar 1 carta com custo de aritmética real de 4 ou mais, o consumo de aritmética de outras cartas na mão diminui em 1"
  },
  RelicConfig_13774_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Olho\">"
  },
  RelicConfig_13775_BattleDesc = {
    Text = "Ao pegar, escolha uma carta de comando para ganhar \"inato\", \"manter\" e \"compre 1 carta ao jogá-la\""
  },
  RelicConfig_13775_Desc = {
    Text = "Ao pegar, escolha uma carta de comando para ganhar \"inato\", \"manter\" e \"compre 1 carta ao jogá-la\""
  },
  RelicConfig_13775_Name = {
    Text = "<WhiteQuality:Pasta de Arquivos>"
  },
  RelicConfig_13775_StoryDesc = {
    Text = "Shhh, isso é um negócio secreto que pertence apenas a nós dois"
  },
  RelicConfig_13776_BattleDesc = {
    Text = "No início da batalha, ganhe 1 tentáculo"
  },
  RelicConfig_13776_Desc = {
    Text = "No início da batalha, ganhe 1 tentáculo"
  },
  RelicConfig_13776_Name = {
    Text = "<WhiteQuality:Caracol Amarelo>"
  },
  RelicConfig_13776_StoryDesc = {
    Text = "Este pequeno caracol amarelo é de origem nobre, com uma linhagem perfeita e impecável"
  },
  RelicConfig_13777_BattleDesc = {
    Text = "No final dos turnos ímpares, se houver aritmética restante, puxe 2 cartas extras na próxima rodada; no final dos turnos pares, se houver cartas restantes, ganhe 2 aritméticas extras na próxima rodada"
  },
  RelicConfig_13777_Desc = {
    Text = "No final dos turnos ímpares, se houver aritmética restante, puxe 2 cartas extras na próxima rodada; no final dos turnos pares, se houver cartas restantes, ganhe 2 aritméticas extras na próxima rodada"
  },
  RelicConfig_13777_Name = {
    Text = "<OrangeQuality:Roda do Sol e Lua>"
  },
  RelicConfig_13777_StoryDesc = {
    Text = "Adivinhe, é preto ou branco?"
  },
  RelicConfig_13778_BattleDesc = {
    Text = "Limite de tentáculo aumentado em 1. Quando a vida está abaixo de 50%, <TentacleInjurieIconKeywords:dano de tentáculo> aumenta em [Arg1]"
  },
  RelicConfig_13778_Desc = {
    Text = "Limite de tentáculo aumentado em 1. Quando a vida está abaixo de 50%, <TentacleInjurieIconKeywords:dano de tentáculo> aumenta em [Arg1]"
  },
  RelicConfig_13778_Name = {
    Text = "<OrangeQuality:Canção do Mar>"
  },
  RelicConfig_13778_StoryDesc = {
    Text = "Dizem que animais não comestíveis como o caramujo de tecido absorvem cerca de 80% dos nutrientes do oceano"
  },
  RelicConfig_13779_BattleDesc = {
    Text = "No início do turno, compre 1 carta. No final do turno, pode manter 1 carta na mão"
  },
  RelicConfig_13779_Desc = {
    Text = "No início do turno, compre 1 carta. No final do turno, pode manter 1 carta na mão"
  },
  RelicConfig_13779_Name = {
    Text = "<OrangeQuality:Lâmpada dos Desejos do Profeta>"
  },
  RelicConfig_13779_StoryDesc = {
    Text = "Atenda ao seu desejo"
  },
  RelicConfig_13780_BattleDesc = {
    Text = "Cada vez que você libera o Exaltar, ganhe 1 <DerivativeCardKeywords_7:\"Infestação Tóxica\">, e se você possuir 3 <DerivativeCardKeywords_7:\"Infestação Tóxica\"> na mão, sintetize em um <IntoxicationIconKeywords:Veneno> <DerivativeCardKeywords_8:\"Erupção Tóxica\"> que ativa."
  },
  RelicConfig_13780_Desc = {
    Text = "Cada vez que você libera o Exaltar, ganhe 1 <DerivativeCardKeywords_7:\"Infestação Tóxica\">, e se você possuir 3 <DerivativeCardKeywords_7:\"Infestação Tóxica\"> na mão, sintetize em um <IntoxicationIconKeywords:Veneno> <DerivativeCardKeywords_8:\"Erupção Tóxica\"> que ativa."
  },
  RelicConfig_13780_Name = {
    Text = "<OrangeQuality:Língua Estranha>"
  },
  RelicConfig_13780_StoryDesc = {
    Text = "Ele não é um demônio, mas transmite sussurros de além do mundo"
  },
  RelicConfig_13781_BattleDesc = {
    Text = "A cada vez que consumir 1 sigilo negro, todos os despertadores ganham 1 ponto de aliemus"
  },
  RelicConfig_13781_Desc = {
    Text = "A cada vez que consumir 1 sigilo negro, todos os despertadores ganham 1 ponto de aliemus"
  },
  RelicConfig_13781_Name = {
    Text = "Flor Inversa"
  },
  RelicConfig_13782_BattleDesc = {
    Text = "Imunidade ao dano"
  },
  RelicConfig_13782_Desc = {
    Text = "Imunidade ao dano"
  },
  RelicConfig_13782_Name = {
    Text = "Criação de teste"
  },
  RelicConfig_13783_BattleDesc = {
    Text = "Após jogar a terceira carta de cada rodada, coloque 1 <DerivativeCardKeywords_4:\"inspiração\"> no monte de descarte. Após jogar a sexta carta de cada rodada, mova 1 <DerivativeCardKeywords_4:\"inspiração\"> do monte de descarte para a mão"
  },
  RelicConfig_13783_Desc = {
    Text = "Após jogar a terceira carta de cada rodada, coloque 1 <DerivativeCardKeywords_4:\"inspiração\"> no monte de descarte. Após jogar a sexta carta de cada rodada, mova 1 <DerivativeCardKeywords_4:\"inspiração\"> do monte de descarte para a mão"
  },
  RelicConfig_13783_Name = {
    Text = "<WhiteQuality:Luz da Civilização>"
  },
  RelicConfig_13783_StoryDesc = {
    Text = "Meteoro rasgando a noite"
  },
  RelicConfig_13784_BattleDesc = {
    Text = "Ao iniciar a rodada, ganhe 1 aritmética para cada inimigo presente. Ao matar um inimigo com dano ativo, cause <BleedingIconKeywords:sangrando> equivalente ao excesso de dano a outros inimigos"
  },
  RelicConfig_13784_Desc = {
    Text = "Ao iniciar a rodada, ganhe 1 aritmética para cada inimigo presente. Ao matar um inimigo com dano ativo, cause <BleedingIconKeywords:sangrando> equivalente ao excesso de dano a outros inimigos"
  },
  RelicConfig_13784_Name = {
    Text = "<OrangeQuality:Canto do Povo>"
  },
  RelicConfig_13784_StoryDesc = {
    Text = "Feito para torturar seus ouvidos"
  },
  RelicConfig_13785_BattleDesc = {
    Text = "No fim do turno, <EmbryoFusionIconKeywords:Fusão de embriões> +15. Se houver <DerivativeCardKeywords_2:\"Embrião\"> na mão, recupera [Arg1] de vida"
  },
  RelicConfig_13785_Desc = {
    Text = "No fim do turno, <EmbryoFusionIconKeywords:Fusão de embriões> +15. Se houver <DerivativeCardKeywords_2:\"Embrião\"> na mão, recupera [Arg1] de vida"
  },
  RelicConfig_13785_Name = {
    Text = "<WhiteQuality:Diagnóstico de Peste>"
  },
  RelicConfig_13785_StoryDesc = {
    Text = "Peste—uma manifestação acidental da inquietação inconsciente da natureza"
  },
  RelicConfig_13786_BattleDesc = {
    Text = "Após liberar a exaltação, ganhe [Arg1] pontos de <PowerIconKeywords:poder> temporários"
  },
  RelicConfig_13786_Desc = {
    Text = "Após liberar a exaltação, ganhe [Arg1] pontos de <PowerIconKeywords:poder> temporários"
  },
  RelicConfig_13786_Name = {
    Text = "<WhiteQuality:Tranca Pesada>"
  },
  RelicConfig_13786_StoryDesc = {
    Text = "Uma fechadura grossa e robusta, difícil de abrir sem chave.\nClaro, para um mestre ladrão, isso não é nada"
  },
  RelicConfig_13787_BattleDesc = {
    Text = "No início do turno, causa [Arg1] de <FixedDamage:Dano Puro> a um inimigo aleatório. Após Disparar \"golpear\" 7 vezes nesta batalha, o Dano causado muda para [Arg2]. Após Disparar \"golpear\" 21 vezes, causa instantaneamente [Arg3] de <FixedDamage:Dano Puro> a todos os inimigos."
  },
  RelicConfig_13787_Desc = {
    Text = "No início do turno, causa [Arg1] de <FixedDamage:Dano Puro> a um inimigo aleatório. Após Disparar \"golpear\" 7 vezes nesta batalha, o Dano causado muda para [Arg2]. Após Disparar \"golpear\" 21 vezes, causa instantaneamente [Arg3] de <FixedDamage:Dano Puro> a todos os inimigos."
  },
  RelicConfig_13787_Name = {
    Text = "<OrangeQuality:Quebra-cabeça Antigo>"
  },
  RelicConfig_13787_StoryDesc = {
    Text = "A obra de arte que estava em uma moldura pesada sempre teve uma peça faltando desde o dia em que foi exibida"
  },
  RelicConfig_13788_BattleDesc = {
    Text = "Limite de tentáculos reduzido em 2. No final do turno, todos os tentáculos atacam uma vez adicional"
  },
  RelicConfig_13788_Desc = {
    Text = "Limite de tentáculos reduzido em 2. No final do turno, todos os tentáculos atacam uma vez adicional"
  },
  RelicConfig_13788_Name = {
    Text = "<RedQuality:Braço Sagrado da Dor>"
  },
  RelicConfig_13788_StoryDesc = {
    Text = "Desfrute da agonia"
  },
  RelicConfig_13789_BattleDesc = {
    Text = "Cada vez que o baralho é reiniciado, ganha [Arg1] <PowerIconKeywords:força>"
  },
  RelicConfig_13789_Desc = {
    Text = "Cada vez que o baralho é reiniciado, ganha [Arg1] <PowerIconKeywords:força>"
  },
  RelicConfig_13789_Name = {
    Text = "<WhiteQuality:Cachimbo Chorão>"
  },
  RelicConfig_13789_StoryDesc = {
    Text = "Isso é fruto do ódio ou resultado da vingança?"
  },
  RelicConfig_13790_BattleDesc = {
    Text = "Ao mover no mapa, recebe 10 sigilos negros, mas a pressão mental causada pela movimentação no mapa aumentará em 10 pontos"
  },
  RelicConfig_13790_Desc = {
    Text = "Ao mover no mapa, recebe 10 sigilos negros, mas a pressão mental causada pela movimentação no mapa aumentará em 10 pontos"
  },
  RelicConfig_13790_Name = {
    Text = "Bolsa sem fundo"
  },
  RelicConfig_13791_BattleDesc = {
    Text = "Ao pegar esta criação, escolha uma carta de comando e adicione uma cópia dela ao baralho"
  },
  RelicConfig_13791_Desc = {
    Text = "Ao pegar esta criação, escolha uma carta de comando e adicione uma cópia dela ao baralho"
  },
  RelicConfig_13791_Name = {
    Text = "<WhiteQuality:Fogo Efêmero>"
  },
  RelicConfig_13791_StoryDesc = {
    Text = "Luz oscilante, esperança fraca"
  },
  RelicConfig_13792_BattleDesc = {
    Text = "Sempre que perder vida, <EmbryoFusionIconKeywords:Fusão de embriões>+10. Se a vida estiver abaixo de 50%, o efeito é dobrado"
  },
  RelicConfig_13792_Desc = {
    Text = "Sempre que perder vida, <EmbryoFusionIconKeywords:Fusão de embriões>+10. Se a vida estiver abaixo de 50%, o efeito é dobrado"
  },
  RelicConfig_13792_Name = {
    Text = "<WhiteQuality:Serra de Aço Enferrujada>"
  },
  RelicConfig_13792_StoryDesc = {
    Text = "O doutor da dissecação passou a vida sem ver uma bela mulher, apenas um saco cheio de ossos, nervos inflamados por doenças, músculos e tecidos"
  },
  RelicConfig_13793_BattleDesc = {
    Text = "Ao coletar, o sigilo negro da equipe cai para 150% do valor original. Após recuperar vida, todos os despertadores ganham 3 pontos de aliemus; ao perder vida, ganhe [Arg1] pontos <PowerIconKeywords:poder> e dano de tentáculo, com efeito acumulativo de no máximo 5 vezes por turno"
  },
  RelicConfig_13793_Desc = {
    Text = "Ao coletar, o sigilo negro da equipe cai para 150% do valor original. Após recuperar vida, todos os despertadores ganham 3 pontos de aliemus; ao perder vida, ganhe [Arg1] pontos <PowerIconKeywords:poder> e dano de tentáculo, com efeito acumulativo de no máximo 5 vezes por turno"
  },
  RelicConfig_13793_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Lua\">"
  },
  RelicConfig_13794_BattleDesc = {
    Text = "Após o final do turno, todos os despertadores ganham 5 de exaltação. Para cada 1 ponto de aritmética restante, todos os despertadores ganham 3 de exaltação adicionais"
  },
  RelicConfig_13794_Desc = {
    Text = "Após o final do turno, todos os despertadores ganham 5 de exaltação. Para cada 1 ponto de aritmética restante, todos os despertadores ganham 3 de exaltação adicionais"
  },
  RelicConfig_13794_Name = {
    Text = "<OrangeQuality:Bateria Prototipo>"
  },
  RelicConfig_13794_StoryDesc = {
    Text = "Esperança portátil"
  },
  RelicConfig_13795_BattleDesc = {
    Text = "A saúde máxima aumenta em 1"
  },
  RelicConfig_13795_Desc = {
    Text = "A saúde máxima aumenta em 1"
  },
  RelicConfig_13795_Name = {
    Text = "<WhiteQuality:injeção ativa>"
  },
  RelicConfig_13795_StoryDesc = {
    Text = "Espasmos também são uma forma de atividade"
  },
  RelicConfig_13796_BattleDesc = {
    Text = "Quando a vida restante é inferior a 50% ao final da batalha, é promovido a uma relíquia de prata"
  },
  RelicConfig_13796_Desc = {
    Text = "Quando a vida restante é inferior a 50% ao final da batalha, é promovido a uma Criação de prata"
  },
  RelicConfig_13796_Name = {
    Text = "Caderno velho 2"
  },
  RelicConfig_13796_StoryDesc = {
    Text = "Um diário velho, cujas páginas internas estão cheias de folhas soltas, contendo pelo menos o mapa de Elworth, registros experimentais e uma carta cheia de marcas de erosão em triângulo. \n O início das anotações é claro e ordenado, mas, à medida que avança, torna-se cada vez mais confuso e desorganizado."
  },
  RelicConfig_13797_BattleDesc = {
    Text = "Após jogar 3 cartas de ataque, evolui para uma relíquia de ouro"
  },
  RelicConfig_13797_Desc = {
    Text = "Após Disparar 3 cartas de golpear, evolui para uma Criação de ouro."
  },
  RelicConfig_13797_Name = {
    Text = "Caderno velho 1"
  },
  RelicConfig_13797_StoryDesc = {
    Text = "Um diário velho, cujas páginas internas estão cheias de folhas soltas, contendo pelo menos o mapa de Elworth, registros de experimentos e cartas cobertas por marcas de erosão em forma de triângulo. \n O conteúdo no início do caderno é escrito de forma clara e ordenada, mas depois se torna progressivamente ilegível e desorganizado."
  },
  RelicConfig_13798_BattleDesc = {
    Text = "Ao início da batalha, todas as suas cartas de sintoma ganham <NothingnessIconKeywords:ilusão>, e para cada carta de sintoma em seu baralho, ganhe [Arg1] <PowerIconKeywords:poder>"
  },
  RelicConfig_13798_Desc = {
    Text = "Ao início da batalha, todas as suas cartas de sintoma ganham <NothingnessIconKeywords:ilusão>, e para cada carta de sintoma em seu baralho, ganhe [Arg1] <PowerIconKeywords:poder>"
  },
  RelicConfig_13798_Name = {
    Text = "<WhiteQuality:Elixir de Harford>"
  },
  RelicConfig_13798_StoryDesc = {
    Text = "Droga de composição desconhecida.\nDizem que o famoso violinista Eric a aprecia"
  },
  RelicConfig_13799_BattleDesc = {
    Text = "No início do primeiro turno da batalha, adicione <DerivativeCardKeywords_1:\"Eco do Espírito\"> à sua mão; no segundo turno, adicione <DerivativeCardKeywords_41:\"Resonância da Chave de Prata\"> à sua mão; no terceiro turno, adicione <DerivativeCardKeywords_39:\"Ecos do passado\"> à sua mão."
  },
  RelicConfig_13799_Desc = {
    Text = "No início do primeiro turno da batalha, adicione <DerivativeCardKeywords_1:\"Eco do Espírito\"> à sua mão; no segundo turno, adicione <DerivativeCardKeywords_41:\"Resonância da Chave de Prata\"> à sua mão; no terceiro turno, adicione <DerivativeCardKeywords_39:\"Ecos do passado\"> à sua mão."
  },
  RelicConfig_13799_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Estrelas\">"
  },
  RelicConfig_13800_BattleDesc = {
    Text = "No início do seu turno, adicione 1 <DerivativeCardKeywords_6:\"Parasol\"> à sua mão. Após jogar 6 cartas, aumente o <AlertIconKeywords:Alert> de todos os <DerivativeCardKeywords_6:\"Parasol\"> em sua mão em [Arg2]"
  },
  RelicConfig_13800_Desc = {
    Text = "No início do seu turno, adicione 1 <DerivativeCardKeywords_6:\"Parasol\"> à sua mão. Após jogar 6 cartas, aumente o <AlertIconKeywords:Alert> de todos os <DerivativeCardKeywords_6:\"Parasol\"> em sua mão em [Arg2]"
  },
  RelicConfig_13800_Name = {
    Text = "<WhiteQuality:Guarda-sol de Viagem>"
  },
  RelicConfig_13800_StoryDesc = {
    Text = "Floresce na terra sem luz"
  },
  RelicConfig_13801_BattleDesc = {
    Text = "Durante a batalha regular, a vida de todos os inimigos aumenta em 30%, e ao vencer, você ganha 25 selos negros adicionais"
  },
  RelicConfig_13801_Desc = {
    Text = "Durante a batalha regular, a vida de todos os inimigos aumenta em 30%, e ao vencer, você ganha 25 selos negros adicionais"
  },
  RelicConfig_13801_Name = {
    Text = "Bandeira de Batalha Destruída"
  },
  RelicConfig_13802_BattleDesc = {
    Text = "Ao pegar, a vida máxima aumenta em [Arg1] pontos. Se a vida ao pegar estiver abaixo de 25%, o aumento da vida máxima muda para [Arg2] pontos"
  },
  RelicConfig_13802_Desc = {
    Text = "Ao pegar, a vida máxima aumenta em [Arg1] pontos. Se a vida ao pegar estiver abaixo de 25%, o aumento da vida máxima muda para [Arg2] pontos"
  },
  RelicConfig_13802_Name = {
    Text = "<WhiteQuality:Chá Preto do Ceilão>"
  },
  RelicConfig_13802_StoryDesc = {
    Text = "Alimentação saudável começa conosco"
  },
  RelicConfig_13803_BattleDesc = {
    Text = "A cada 3 turnos, ganha 3 tentáculos temporários"
  },
  RelicConfig_13803_Desc = {
    Text = "A cada 3 turnos, ganha 3 tentáculos temporários"
  },
  RelicConfig_13803_Name = {
    Text = "<WhiteQuality:Capacete de Mergulho>"
  },
  RelicConfig_13803_StoryDesc = {
    Text = "Sonhos são estrelas e oceanos!"
  },
  RelicConfig_13804_BattleDesc = {
    Text = "No final do turno, ganhe [Arg1] pontos de escudo. Se seu escudo for 0 ou múltiplo de 3, ganhe [Arg2] pontos de <PowerIconKeywords:Força>"
  },
  RelicConfig_13804_Desc = {
    Text = "No final do turno, ganhe [Arg1] pontos de escudo. Se seu escudo for 0 ou múltiplo de 3, ganhe [Arg2] pontos de <PowerIconKeywords:Força>"
  },
  RelicConfig_13804_Name = {
    Text = "<OrangeQuality:Sinal de Socorro>"
  },
  RelicConfig_13804_StoryDesc = {
    Text = "Ele não esperou pelo resgate"
  },
  RelicConfig_13806_BattleDesc = {
    Text = "Ao comprar um cartão de sintoma, ganhe [Arg1] pontos de <PowerIconKeywords:poder> temporário. Para cada relíquia amaldiçoada que você possui, sua taxa crítica e dano crítico aumentam em 10%"
  },
  RelicConfig_13806_Desc = {
    Text = "Ao comprar um cartão de sintoma, ganhe [Arg1] pontos de <PowerIconKeywords:poder> temporário. Para cada relíquia amaldiçoada que você possui, sua taxa crítica e dano crítico aumentam em 10%"
  },
  RelicConfig_13806_Name = {
    Text = "<OrangeQuality:Comunicação do Abismo>"
  },
  RelicConfig_13806_StoryDesc = {
    Text = "Na periferia desolada, um telefone toca na cabine solitária.\n\"Escuridão... hiss... interminável... hiss... escuridão...\""
  },
  RelicConfig_13807_BattleDesc = {
    Text = "No início da batalha, <EmbryoFusionIconKeywords:Fusão de embriões>+50. Para cada Corpo Desperto com pelo menos 50 de Fúria, efeito adicional 1 vez"
  },
  RelicConfig_13807_Desc = {
    Text = "No início da batalha, <EmbryoFusionIconKeywords:Fusão de embriões>+50. Para cada Corpo Desperto com pelo menos 50 de Fúria, efeito adicional 1 vez"
  },
  RelicConfig_13807_Name = {
    Text = "<WhiteQuality:Querido Bebê>"
  },
  RelicConfig_13807_StoryDesc = {
    Text = "O carpinteiro fez um boneco de madeira para sua esposa, que substituiria seu filho, dormindo em seu ventre"
  },
  RelicConfig_13808_BattleDesc = {
    Text = "Após liberar a exaltação, coloque uma carta aleatória correspondente ao despertador nas mãos, que ganha <DepleteIconKeywords:exausto> e <NothingnessIconKeywords:ilusão>. Após o combate, recupere [Arg1] pontos de vida"
  },
  RelicConfig_13808_Desc = {
    Text = "Após liberar a exaltação, coloque uma carta aleatória correspondente ao despertador nas mãos, que ganha <DepleteIconKeywords:exausto> e <NothingnessIconKeywords:ilusão>. Após o combate, recupere [Arg1] pontos de vida"
  },
  RelicConfig_13808_Name = {
    Text = "<WhiteQuality:maleta do doutor>"
  },
  RelicConfig_13808_StoryDesc = {
    Text = "A mala que simboliza a identidade de médico é muito pesada.\n\nAquele que a abre pode não ser um verdadeiro médico.\n"
  },
  RelicConfig_13809_BattleDesc = {
    Text = "Preço de todas as criações reduzido em 20"
  },
  RelicConfig_13809_Desc = {
    Text = "Preço de todas as criações reduzido em 20"
  },
  RelicConfig_13809_Name = {
    Text = "<WhiteQuality:Língua Afiada>"
  },
  RelicConfig_13809_StoryDesc = {
    Text = "Não só os comerciantes são eloquentes, mas também os devotos"
  },
  RelicConfig_13811_BattleDesc = {
    Text = "A cada 3ª vez que \"golpear\" é Disparado, causa [Arg1] de <FixedDamage:Dano Puro> a todos os inimigos. O Corpo Desperto correspondente ganha 15 de Fúria."
  },
  RelicConfig_13811_Desc = {
    Text = "A cada 3ª vez que \"golpear\" é Disparado, causa [Arg1] de <FixedDamage:Dano Puro> a todos os inimigos. O Corpo Desperto correspondente ganha 15 de Fúria."
  },
  RelicConfig_13811_Name = {
    Text = "<WhiteQuality:Faca de Salgueiro Enferrujada>"
  },
  RelicConfig_13811_StoryDesc = {
    Text = "Não é adequado para cortar tecido vivo"
  },
  RelicConfig_13812_BattleDesc = {
    Text = "Ao pegar, a vida máxima aumenta em 100%; no início do turno, perca [Arg1] pontos de vida"
  },
  RelicConfig_13812_Desc = {
    Text = "Ao pegar, a vida máxima aumenta em 100%; no início do turno, perca [Arg1] pontos de vida"
  },
  RelicConfig_13812_Name = {
    Text = "<RedQuality:☆Carne do Imortal☆>"
  },
  RelicConfig_13812_StoryDesc = {
    Text = "\"A vida marinha frequentemente desprende membros para sobreviver.\""
  },
  RelicConfig_13813_BattleDesc = {
    Text = "No início da batalha, vida dos inimigos elite e chefe reduzida em 20%"
  },
  RelicConfig_13813_Desc = {
    Text = "No início da batalha, vida dos inimigos elite e chefe reduzida em 20%"
  },
  RelicConfig_13813_Name = {
    Text = "<WhiteQuality:☆Âncora Velha☆>"
  },
  RelicConfig_13813_StoryDesc = {
    Text = "Volte para casa, meu velho marinheiro"
  },
  RelicConfig_13814_BattleDesc = {
    Text = "No final do turno, para cada cartão não jogado na mão, todos os despertadores ganham 2 de loucura"
  },
  RelicConfig_13814_Desc = {
    Text = "No final do turno, para cada cartão não jogado na mão, todos os despertadores ganham 2 de loucura"
  },
  RelicConfig_13814_Name = {
    Text = "<WhiteQuality:Balança Desequilibrada>"
  },
  RelicConfig_13814_StoryDesc = {
    Text = "Não simboliza mais justiça"
  },
  RelicConfig_13815_BattleDesc = {
    Text = "Ao pegar, escolha um cartão, transformando seu custo de aritmética permanentemente em 1"
  },
  RelicConfig_13815_Desc = {
    Text = "Ao pegar, escolha um cartão, transformando seu custo de aritmética permanentemente em 1"
  },
  RelicConfig_13815_Name = {
    Text = "<WhiteQuality:☆Olho Artificial☆>"
  },
  RelicConfig_13815_StoryDesc = {
    Text = "Um olho que não é mais puro"
  },
  RelicConfig_13816_BattleDesc = {
    Text = "Ao início da batalha, todos os inimigos ganham [Arg1] pontos <RetaliateIconKeywords:balcão>. Sempre que causar dano, o despertador com a menor loucura ganha 6 pontos de loucura"
  },
  RelicConfig_13816_Desc = {
    Text = "Ao início da batalha, todos os inimigos ganham [Arg1] pontos <RetaliateIconKeywords:balcão>. Sempre que causar dano, o despertador com a menor loucura ganha 6 pontos de loucura"
  },
  RelicConfig_13816_Name = {
    Text = "<RedQuality:☆Sino do Lamento☆>"
  },
  RelicConfig_13816_StoryDesc = {
    Text = "Ding ling, ding ling, a criança chora;\nDing ling, ding ling, a criança grita.\nDing ling, ding ling, a criança lamenta;\nDing ling, ding ling, está com fome, você sabe"
  },
  RelicConfig_13817_BattleDesc = {
    Text = "Após jogar 6 cartas de comando, <TentacleInjurieIconKeywords: dano de tentáculo> +[Arg1]"
  },
  RelicConfig_13817_Desc = {
    Text = "Após jogar 6 cartas de comando, <TentacleInjurieIconKeywords: dano de tentáculo> +[Arg1]"
  },
  RelicConfig_13817_Name = {
    Text = "<WhiteQuality:Cisticerco>"
  },
  RelicConfig_13817_StoryDesc = {
    Text = "Só se nosso cérebro ainda for um mistério, não há nada de surpreendente em ter tentáculos crescendo nele"
  },
  RelicConfig_13818_BattleDesc = {
    Text = "Taxa crítica aumenta em 50%, mas no início do combate, <FragileIconKeywords:frágil> aplica-se a si mesmo por 3 rodadas"
  },
  RelicConfig_13818_Desc = {
    Text = "Taxa crítica aumenta em 50%, mas no início do combate, <FragileIconKeywords:frágil> aplica-se a si mesmo por 3 rodadas"
  },
  RelicConfig_13818_Name = {
    Text = "<RedQuality:Garra Estranha>"
  },
  RelicConfig_13818_StoryDesc = {
    Text = "Espécie indiscernível"
  },
  RelicConfig_13819_BattleDesc = {
    Text = "Ao jogar 1 carta com consumo de aritmética de 3 ou mais, puxe 1 carta e ganhe 1 de aritmética"
  },
  RelicConfig_13819_Desc = {
    Text = "Ao jogar 1 carta com consumo de aritmética de 3 ou mais, puxe 1 carta e ganhe 1 de aritmética"
  },
  RelicConfig_13819_Name = {
    Text = "<OrangeQuality:☆Beleza Perdida☆>"
  },
  RelicConfig_13819_StoryDesc = {
    Text = "Ninguém lembra mais da sua beleza"
  },
  RelicConfig_13820_BattleDesc = {
    Text = "Sempre que receber uma carta de sintoma, aumente a saúde máxima em [Arg1] pontos"
  },
  RelicConfig_13820_Desc = {
    Text = "Sempre que receber uma carta de sintoma, aumente a saúde máxima em [Arg1] pontos"
  },
  RelicConfig_13820_Name = {
    Text = "<WhiteQuality:☆Incenso☆>"
  },
  RelicConfig_13820_StoryDesc = {
    Text = "\"Um aroma doce e sedutor.\""
  },
  RelicConfig_13821_BattleDesc = {
    Text = "Após liberar a exaltação, compre 1 cartão. Se a vida estiver abaixo de 25%, compre um cartão adicional"
  },
  RelicConfig_13821_Desc = {
    Text = "Após liberar a exaltação, compre 1 cartão. Se a vida estiver abaixo de 25%, compre um cartão adicional"
  },
  RelicConfig_13821_Name = {
    Text = "<OrangeQuality:Roda do Conhecimento>"
  },
  RelicConfig_13821_StoryDesc = {
    Text = "Leia com segurança"
  },
  RelicConfig_13822_BattleDesc = {
    Text = "Ao causar dano ativo, ganhe [Arg1] de <TentacleInjurieIconKeywords:dano de tentáculo> temporário, até 3 vezes. Ao máximo, crie um tentáculo temporário extra"
  },
  RelicConfig_13822_Desc = {
    Text = "Ao causar dano ativo, ganhe [Arg1] de <TentacleInjurieIconKeywords:dano de tentáculo> temporário, até 3 vezes. Ao máximo, crie um tentáculo temporário extra"
  },
  RelicConfig_13822_Name = {
    Text = "<OrangeQuality:Prazer de Ló>"
  },
  RelicConfig_13822_StoryDesc = {
    Text = "Senhor do Sono, aguarda-te no sonho"
  },
  RelicConfig_13823_BattleDesc = {
    Text = "A cada [Arg1] carta de comando jogada, ela terá efeito 2 vezes e retornará à sua mão"
  },
  RelicConfig_13823_Desc = {
    Text = "A cada [Arg1] carta de comando jogada, ela terá efeito 2 vezes e retornará à sua mão"
  },
  RelicConfig_13823_Name = {
    Text = "<OrangeQuality:Vinho das Estrelas+>"
  },
  RelicConfig_13823_StoryDesc = {
    Text = "Vagando entre as estrelas"
  },
  RelicConfig_13824_BattleDesc = {
    Text = "No início de cada turno, <DeathResistanceIconKeywords:resistência à morte> aumenta em 10% (a resistência à morte ganha é reduzida pela metade a cada ativação nesta fase). Quando a <DeathResistanceIconKeywords:resistência à morte> está acima de 100%, <ProficientInRealmsIconKeywords:Maestria em Domínios> aumenta em 100."
  },
  RelicConfig_13824_Desc = {
    Text = "No início de cada turno, <DeathResistanceIconKeywords:resistência à morte> aumenta em 10% (a resistência à morte ganha é reduzida pela metade a cada ativação nesta fase). Quando a <DeathResistanceIconKeywords:resistência à morte> estiver acima de 100%, <ProficientInRealmsIconKeywords:Domínio de área> aumenta em 100."
  },
  RelicConfig_13824_Name = {
    Text = "<WhiteQuality:Lágrima de Sereia>"
  },
  RelicConfig_13824_StoryDesc = {
    Text = "Não coloque na água"
  },
  RelicConfig_13825_BattleDesc = {
    Text = "A cada 10 sigilos negros consumidos, recupere [Arg1] pontos de vida"
  },
  RelicConfig_13825_Desc = {
    Text = "A cada 10 sigilos negros consumidos, recupere 1% da vida"
  },
  RelicConfig_13825_Name = {
    Text = "Raiz Inversa"
  },
  RelicConfig_13826_BattleDesc = {
    Text = "Quando você joga uma Carta de Buff, Carta de Sintoma ou Carta de Estado, o Despertador com o menor Aliemus ganha 10 de Aliemus."
  },
  RelicConfig_13826_Desc = {
    Text = "Quando você joga uma Carta de Buff, Carta de Sintoma ou Carta de Estado, o Despertador com o menor Aliemus ganha 10 de Aliemus."
  },
  RelicConfig_13826_Name = {
    Text = "<WhiteQuality:Álbum de Selos Estrangeiros>"
  },
  RelicConfig_13826_StoryDesc = {
    Text = "Pensamentos quantificados"
  },
  RelicConfig_13827_BattleDesc = {
    Text = "Ao pegar, recebe 75 de sigilo negro. Escolha 1 relicário e transforme-o em 1 relicário amaldiçoada aleatória"
  },
  RelicConfig_13827_Desc = {
    Text = "Ao pegar, recebe 75 de sigilo negro. Escolha 1 relicário e transforme-o em 1 relicário amaldiçoada aleatória"
  },
  RelicConfig_13827_Name = {
    Text = "<RedQuality:Estela Amaldiçoada>"
  },
  RelicConfig_13827_StoryDesc = {
    Text = "Ouviu o chamado do mar profundo ao acariciar"
  },
  RelicConfig_13828_BattleDesc = {
    Text = "Ao jogar pela primeira vez uma carta de comando em cada turno e colocá-la na pilha de descarte, reduz o custo de aritmética da carta em 1, temporariamente copiando-a e embaralhando-a na pilha de puxar"
  },
  RelicConfig_13828_Desc = {
    Text = "Ao jogar pela primeira vez uma carta de comando em cada turno e colocá-la na pilha de descarte, reduz o custo de aritmética da carta em 1, temporariamente copiando-a e embaralhando-a na pilha de puxar"
  },
  RelicConfig_13828_Name = {
    Text = "<WhiteQuality:Vitrola Muda>"
  },
  RelicConfig_13828_StoryDesc = {
    Text = "Sua voz desapareceu no vento"
  },
  RelicConfig_13829_BattleDesc = {
    Text = "Um molho de chaves enferrujadas. Pode ser usado para abrir fechaduras"
  },
  RelicConfig_13829_Desc = {
    Text = "Um molho de chaves enferrujadas. Pode ser usado para abrir fechaduras"
  },
  RelicConfig_13829_Name = {
    Text = "Chave enferrujada"
  },
  RelicConfig_13830_BattleDesc = {
    Text = "Ao restaurar vida, também ganha [Arg1] de escudo. A partir do 3º turno, ganha [Arg2] de <AlertIconKeywords:alerta>"
  },
  RelicConfig_13830_Desc = {
    Text = "Ao restaurar vida, também ganha [Arg1] de escudo. A partir do 3º turno, ganha [Arg2] de <AlertIconKeywords:alerta>"
  },
  RelicConfig_13830_Name = {
    Text = "<WhiteQuality:especime de borboleta>"
  },
  RelicConfig_13830_StoryDesc = {
    Text = "Até hoje, ele é profundamente amado por alguém"
  },
  RelicConfig_13831_BattleDesc = {
    Text = "Sempre que uma carta de comando entra no <DimensionalSpaceIconKeywords:espaço dimensional>, o Despertado correspondente ganha 15 loucura"
  },
  RelicConfig_13831_Desc = {
    Text = "Sempre que uma carta de comando entra no <DimensionalSpaceIconKeywords:espaço dimensional>, o Despertado correspondente ganha 15 loucura"
  },
  RelicConfig_13831_Name = {
    Text = "<WhiteQuality:Verme do Tempo>"
  },
  RelicConfig_13831_StoryDesc = {
    Text = "Um relógio de bolso que existe tanto na loja de relógios quanto no museu de insetos.\nApós o início da era Hongji, foi adicionado à coleção da universidade"
  },
  RelicConfig_13832_BattleDesc = {
    Text = "Ao entrar na rodada ultra, anule seu próprio estado <WeaknessIconKeywords: fraqueza> e <FragileIconKeywords: frágil>, e <WeaknessIconKeywords: fraqueza> e <VulnerabilityIconKeywords: vulnerável> todos os inimigos por 3 rodadas; nesta rodada, o dano final de todos os despertadores aumenta em 15%"
  },
  RelicConfig_13832_Desc = {
    Text = "Ao entrar na rodada ultra, anule seu próprio estado <WeaknessIconKeywords: fraqueza> e <FragileIconKeywords: frágil>, e <WeaknessIconKeywords: fraqueza> e <VulnerabilityIconKeywords: vulnerável> todos os inimigos por 3 rodadas; nesta rodada, o dano final de todos os despertadores aumenta em 15%"
  },
  RelicConfig_13832_Name = {
    Text = "<WhiteQuality:Relógio de Bolso Supercorda>"
  },
  RelicConfig_13832_StoryDesc = {
    Text = "\"\"Oh não, o relógio de bolso parou.\""
  },
  RelicConfig_13833_BattleDesc = {
    Text = "A cada dano, aplica [Arg1] camadas de <IntoxicationIconKeywords:veneno> no alvo. Após 25 ativações na batalha, aplica veneno em todos os inimigos"
  },
  RelicConfig_13833_Desc = {
    Text = "A cada dano, aplica [Arg1] camadas de <IntoxicationIconKeywords:veneno> no alvo. Após 25 ativações na batalha, aplica veneno em todos os inimigos"
  },
  RelicConfig_13833_Name = {
    Text = "<OrangeQuality:☆Máquina de Costura empoeirada☆>"
  },
  RelicConfig_13833_StoryDesc = {
    Text = "Uma mãe carinhosa, remendando as feridas do coração"
  },
  RelicConfig_13834_BattleDesc = {
    Text = "A cada 5ª vez que ganhar um escudo, ganhe também <RetaliateIconKeywords:contra-ataque>, cujo valor é igual a [Arg1]% do escudo obtido"
  },
  RelicConfig_13834_Desc = {
    Text = "A cada 5ª vez que ganhar um escudo, ganhe também <RetaliateIconKeywords:contra-ataque>, cujo valor é igual a [Arg1]% do escudo obtido"
  },
  RelicConfig_13834_Name = {
    Text = "<OrangeQuality:Fragmento do Sábio>"
  },
  RelicConfig_13834_StoryDesc = {
    Text = "\"Quão tolos são os humanos, acreditando cegamente simplesmente porque é antiquado.\""
  },
  RelicConfig_13835_BattleDesc = {
    Text = "Compre 1 carta no início do turno"
  },
  RelicConfig_13835_Desc = {
    Text = "Compre 1 carta no início do turno"
  },
  RelicConfig_13835_Name = {
    Text = "<WhiteQuality:Bússola Direcional>"
  },
  RelicConfig_13835_StoryDesc = {
    Text = "Não aponta direção, apenas campo magnético"
  },
  RelicConfig_13836_BattleDesc = {
    Text = "Randomly place <DerivativeCardKeywords_4:\"Seizure\"> and <DerivativeCardKeywords_3:\"Inspiration\"> into <DimensionalSpaceIconKeywords:Ultra Space> until full at the start of battle. Gain [Arg1] <PowerIconKeywords:FORÇA> in Ultra Space turn."
  },
  RelicConfig_13836_Desc = {
    Text = "Randomly place <DerivativeCardKeywords_4:\"Seizure\"> and <DerivativeCardKeywords_3:\"Inspiration\"> into <DimensionalSpaceIconKeywords:Ultra Space> until full at the start of battle. Gain [Arg1] <PowerIconKeywords:FORÇA> in Ultra Space turn."
  },
  RelicConfig_13836_Name = {
    Text = "<RedQuality:Artefato de Afonso>"
  },
  RelicConfig_13836_StoryDesc = {
    Text = "Diferente do destino incerto, as estrelas têm suas próprias leis"
  },
  RelicConfig_13837_BattleDesc = {
    Text = "Ao pegar, ganha 100% de <DeathResistanceIconKeywords:resistência à morte> (a resistência à morte ganha é reduzida pela metade a cada ativação nesta fase). Após ativar a <DeathResistanceIconKeywords:resistência à morte>, recupera [Arg1] de vida no início de cada turno nesta batalha"
  },
  RelicConfig_13837_Desc = {
    Text = "Ao pegar, ganha 100% de <DeathResistanceIconKeywords:resistência à morte> (a resistência à morte ganha é reduzida pela metade a cada ativação nesta fase). Após ativar a <DeathResistanceIconKeywords:resistência à morte>, recupera [Arg1] de vida no início de cada turno nesta batalha"
  },
  RelicConfig_13837_Name = {
    Text = "<WhiteQuality:Respiração Artificial>"
  },
  RelicConfig_13837_StoryDesc = {
    Text = "Coisa imprescindível para exploradores. Depender demais, e tornará parte de você"
  },
  RelicConfig_13838_BattleDesc = {
    Text = "É um item de missão sem efeito 2"
  },
  RelicConfig_13838_Desc = {
    Text = "É um item de missão sem efeito 2"
  },
  RelicConfig_13838_Name = {
    Text = "Teste de criação da missão 2"
  },
  RelicConfig_13838_StoryDesc = {
    Text = "Criação que precisa de conteúdo adicional"
  },
  RelicConfig_13839_BattleDesc = {
    Text = "Ao jogar a última carta da mão, compre 2 cartas. Máximo de 2 ativações por turno"
  },
  RelicConfig_13839_Desc = {
    Text = "Ao jogar a última carta da mão, compre 2 cartas. Máximo de 2 ativações por turno"
  },
  RelicConfig_13839_Name = {
    Text = "<WhiteQuality:☆Luvas Mágicas☆>"
  },
  RelicConfig_13839_StoryDesc = {
    Text = "\"Não tenha medo, é apenas uma ilusão.\""
  },
  RelicConfig_13840_BattleDesc = {
    Text = "A cada 3 turnos, adiciona 1 camada de <WeaknessIconKeywords:fraqueza> a todos os inimigos. Causar dano a inimigos com <WeaknessIconKeywords:fraqueza> concede [Arg1] de <PowerIconKeywords:força> temporária, até 3 vezes por turno"
  },
  RelicConfig_13840_Desc = {
    Text = "A cada 3 turnos, adiciona 1 camada de <WeaknessIconKeywords:Sintoma: Enfraquecer> a todos os inimigos. Causar dano a inimigos com <WeaknessIconKeywords:Sintoma: Enfraquecer> concede [Arg1] de <PowerIconKeywords:FOR> Temporário, até 3 vezes por turno"
  },
  RelicConfig_13840_Name = {
    Text = "<WhiteQuality:Menino Travesso>"
  },
  RelicConfig_13840_StoryDesc = {
    Text = "Nascido do puro mal, mesmo que não fosse sua vontade"
  },
  RelicConfig_13841_BattleDesc = {
    Text = "Todos os \"Golpes\" causam 20% mais dano crítico. No início da batalha, adicione 1 <DerivativeCardKeywords_40:\"Momento Belo\"> à sua mão"
  },
  RelicConfig_13841_Desc = {
    Text = "Todos os \"Golpes\" causam 20% mais dano crítico. No início da batalha, adicione 1 <DerivativeCardKeywords_40:\"Momento Belo\"> à sua mão"
  },
  RelicConfig_13841_Name = {
    Text = "<WhiteQuality:Momento Belo>"
  },
  RelicConfig_13841_StoryDesc = {
    Text = "Preserve a beleza efêmera para sempre"
  },
  RelicConfig_13842_BattleDesc = {
    Text = "Imunidade a dano fatal não resistido que não ativou a resistência, recupera [Arg1] vida e torna essa relíquia inativa permanentemente"
  },
  RelicConfig_13842_Desc = {
    Text = "Imunidade a dano fatal não resistido que não ativou a resistência, recupera [Arg1] vida e torna essa relíquia inativa permanentemente"
  },
  RelicConfig_13842_Name = {
    Text = "<OrangeQuality:Boneco Substituto>"
  },
  RelicConfig_13842_StoryDesc = {
    Text = "Hehehe, hehehe. Você me deve, não é?"
  },
  RelicConfig_13844_BattleDesc = {
    Text = "Ao causar <WeaknessIconKeywords:fraqueza>, ganha [Arg1] pontos de escudo; ao causar <VulnerabilityIconKeywords:vulnerável>, ganha [Arg2] pontos de <PowerIconKeywords:força> temporária. Se esses dois efeitos forem ativados dentro de 1 turno, você ganhará um adicional de [Arg1] pontos de escudo e [Arg2] pontos de <PowerIconKeywords:força> temporária."
  },
  RelicConfig_13844_Desc = {
    Text = "Ao causar <WeaknessIconKeywords:fraqueza>, você ganha [Arg1] pontos de escudo; ao causar <VulnerabilityIconKeywords:vulnerável>, você ganha [Arg2] pontos de <PowerIconKeywords:força> temporária. Se esses dois efeitos forem ativados dentro de 1 turno, você ganhará um adicional de [Arg1] pontos de escudo e [Arg2] pontos de <PowerIconKeywords:força> temporária."
  },
  RelicConfig_13844_Name = {
    Text = "<OrangeQuality:Moldura Pesada>"
  },
  RelicConfig_13844_StoryDesc = {
    Text = "A última obra de um artista insano, dizem que se pode ver seu rosto aterrorizado nela"
  },
  RelicConfig_13845_BattleDesc = {
    Text = "Ao esgotar o último ponto de poder, ganha 2 de poder. Pode ser acionado até 2 vezes por rodada"
  },
  RelicConfig_13845_Desc = {
    Text = "Ao esgotar o último ponto de poder, ganha 2 de poder. Pode ser acionado até 2 vezes por rodada"
  },
  RelicConfig_13845_Name = {
    Text = "<OrangeQuality:☆Máquina Diferencial Prateada☆>"
  },
  RelicConfig_13845_StoryDesc = {
    Text = "\"Mudou a história.\""
  },
  RelicConfig_13846_BattleDesc = {
    Text = "Sempre que perder vida, ganha [Arg1] pontos de <PowerIconKeywords:força>, máximo de 10 camadas por batalha. Ao atingir o máximo, recupera 25% da vida perdida"
  },
  RelicConfig_13846_Desc = {
    Text = "Sempre que perder vida, ganha [Arg1] pontos de <PowerIconKeywords:força>, máximo de 10 camadas por batalha. Ao atingir o máximo, recupera 25% da vida perdida"
  },
  RelicConfig_13846_Name = {
    Text = "<OrangeQuality:Suprema Honra>"
  },
  RelicConfig_13846_StoryDesc = {
    Text = "Um gato preto elegante e misterioso, dizem ser a encarnação de um deus em um distante deserto. Mas o nome desse deus agora é desconhecido.\nAdorado, venerado, esquecido, talvez seja o destino dos deuses"
  },
  RelicConfig_13847_BattleDesc = {
    Text = "Dano aumentado em 20% contra inimigos com status negativo, ao matar um inimigo, o assassino ganha 20 de loucura"
  },
  RelicConfig_13847_Desc = {
    Text = "Dano aumentado em 20% contra inimigos com status negativo, ao matar um inimigo, o assassino ganha 20 de loucura"
  },
  RelicConfig_13847_Name = {
    Text = "<OrangeQuality:Cetro do Sacerdote>"
  },
  RelicConfig_13847_StoryDesc = {
    Text = "Devoção não permitida"
  },
  RelicConfig_13848_BattleDesc = {
    Text = "Ao pegar, a maestria do domínio da equipe aumenta para 150% do valor original. Após jogar a 5ª carta de comando em cada turno, todos os despertos ganham 20 de loucura"
  },
  RelicConfig_13848_Desc = {
    Text = "Ao pegar, a maestria do domínio da equipe aumenta para 150% do valor original. Após jogar a 5ª carta de comando em cada turno, todos os despertos ganham 20 de loucura"
  },
  RelicConfig_13848_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Impuro\">"
  },
  RelicConfig_13849_BattleDesc = {
    Text = "Ao causar o 3º dano, ganhe [Arg1] de escudo. Ao 6º dano, ganhe [Arg2] de <PowerIconKeywords:força>"
  },
  RelicConfig_13849_Desc = {
    Text = "Ao causar o 3º dano, ganhe [Arg1] de escudo. Ao 6º dano, ganhe [Arg2] de <PowerIconKeywords:força>"
  },
  RelicConfig_13849_Name = {
    Text = "<WhiteQuality:Saída de Emergência>"
  },
  RelicConfig_13849_StoryDesc = {
    Text = "Parece que ele também não conseguiu escapar"
  },
  RelicConfig_13851_BattleDesc = {
    Text = "A cada <DevouredIconKeywords:devoração>, rouba [Arg1] de <PowerIconKeywords:força> temporária de todos os inimigos"
  },
  RelicConfig_13851_Desc = {
    Text = "A cada <DevouredIconKeywords:devoração>, rouba [Arg1] de <PowerIconKeywords:força> temporária de todos os inimigos"
  },
  RelicConfig_13851_Name = {
    Text = "<OrangeQuality:Mãos Leves>"
  },
  RelicConfig_13851_StoryDesc = {
    Text = "Ferramenta perfeita para matar e roubar"
  },
  RelicConfig_13852_BattleDesc = {
    Text = "Ao coletar, escolha um despertador para despertá-lo, sua carta de despertar terá o custo de poder reduzido permanentemente em 1"
  },
  RelicConfig_13852_Desc = {
    Text = "Ao coletar, escolha um despertador para despertá-lo, sua carta de despertar terá o custo de poder reduzido permanentemente em 1"
  },
  RelicConfig_13852_Name = {
    Text = "<WhiteQuality:Hora do Ovo de Páscoa>"
  },
  RelicConfig_13852_StoryDesc = {
    Text = "Aproveite, mas não coma"
  },
  RelicConfig_13853_BattleDesc = {
    Text = "Sempre que causar dano, ganhe [Arg1] pontos Temporários de <RetaliateIconKeywords:Contrataque>, podendo ativar no máximo 5 vezes por turno. Na 5ª ativação, coloque uma <DerivativeCardKeywords_4:\"Discernimento\"> no Mazo de robo"
  },
  RelicConfig_13853_Desc = {
    Text = "Sempre que causar dano, ganhe [Arg1] pontos Temporários de <RetaliateIconKeywords:Contrataque>, podendo ativar no máximo 5 vezes por turno. Na 5ª ativação, coloque uma <DerivativeCardKeywords_4:\"Discernimento\"> no Mazo de robo"
  },
  RelicConfig_13853_Name = {
    Text = "<WhiteQuality:Faca Cerimonial Perdida>"
  },
  RelicConfig_13853_StoryDesc = {
    Text = "Uma adaga de lâmina curva, usada em rituais"
  },
  RelicConfig_13854_BattleDesc = {
    Text = "Ao iniciar a rodada, compre 2 cartas e ganhe 2 pontos de aritmética. Sempre que você comprar uma carta de comando ou despertar de gnose, altere aleatoriamente seu custo de aritmética (0-4)"
  },
  RelicConfig_13854_Desc = {
    Text = "Ao iniciar a rodada, compre 2 cartas e ganhe 2 pontos de aritmética. Sempre que você comprar uma carta de comando ou despertar de gnose, altere aleatoriamente seu custo de aritmética (0-4)"
  },
  RelicConfig_13854_Name = {
    Text = "<RedQuality:chapéu mágico>"
  },
  RelicConfig_13854_StoryDesc = {
    Text = "Bem-vindo ao Circo Maravilhoso da Senhorita Casiah! Tenha cuidado, não toque nos itens mágicos à toa. Se você acidentalmente for mordido, isso pode ser um grande problema. \n Afinal, a última vez que ele provou o gosto do sangue, as consequências foram muito aterradoras. \n\n O chapéu piscou, como se estivesse prestes a sair de seu casulo."
  },
  RelicConfig_13855_BattleDesc = {
    Text = "No início do turno e sempre que a Vida é recuperada, ganha [Arg1] de <RetaliateIconKeywords:Contador>. Pode ocorrer até 3 vezes por turno. Quando o limite é atingido, aciona 100% de <RetaliateIconKeywords:Contador> contra todos os inimigos."
  },
  RelicConfig_13855_Desc = {
    Text = "No início do turno e sempre que a Vida é recuperada, ganha [Arg1] de <RetaliateIconKeywords:Contador>. Pode ocorrer até 3 vezes por turno. Quando o limite é atingido, aciona 100% de <RetaliateIconKeywords:Contador> contra todos os inimigos."
  },
  RelicConfig_13855_Name = {
    Text = "<OrangeQuality:Caixinha de Música>"
  },
  RelicConfig_13855_StoryDesc = {
    Text = "A mansão de Dexter tem muitas coleções. Antes de ser quebrada, a caixinha de música era o brinquedo favorito da pequena Senhorita Dexter.\nCom o tempo, quando a Senhorita Dexter a encontrou novamente, os mecanismos estavam frouxos e a música desafinada, mas ainda girava"
  },
  RelicConfig_13856_BattleDesc = {
    Text = "Dano crítico aumentado em 15%. A taxa crítica de \"golpe\" aumenta em 40%"
  },
  RelicConfig_13856_Desc = {
    Text = "Dano crítico aumentado em 15%. A taxa crítica de \"golpe\" aumenta em 40%"
  },
  RelicConfig_13856_Name = {
    Text = "<WhiteQuality:Bico de Corvo Branco>"
  },
  RelicConfig_13856_StoryDesc = {
    Text = "Não há segredos diante dele"
  },
  RelicConfig_13857_BattleDesc = {
    Text = "Após liberar a exaltação, ganhe [Arg1] pontos de <RetaliateIconKeywords:balcão>. Se for a sexta vez que isso ocorre neste combate, dobre seu <RetaliateIconKeywords:balcão>"
  },
  RelicConfig_13857_Desc = {
    Text = "Após liberar a exaltação, ganhe [Arg1] pontos de <RetaliateIconKeywords:balcão>. Se for a sexta vez que isso ocorre neste combate, dobre seu <RetaliateIconKeywords:balcão>"
  },
  RelicConfig_13857_Name = {
    Text = "<OrangeQuality:☆Sextante☆>"
  },
  RelicConfig_13857_StoryDesc = {
    Text = "O que você guia é apenas um caminho errado"
  },
  RelicConfig_13858_BattleDesc = {
    Text = "A cada turno, puxa 1 carta a mais e ganha 1 ponto de aritmética"
  },
  RelicConfig_13858_Desc = {
    Text = "A cada turno, puxa 1 carta a mais e ganha 1 ponto de aritmética"
  },
  RelicConfig_13858_Name = {
    Text = "<OrangeQuality:☆Boas Memórias☆>"
  },
  RelicConfig_13858_StoryDesc = {
    Text = "Alguém ficou para sempre naquele verão"
  },
  RelicConfig_13859_BattleDesc = {
    Text = "Compre 1 carta no início do turno. No início da batalha, embaralhe 1 <DerivativeCardKeywords_4:\"Inspiração\"> no seu baralho. Cada batalha vencida aumenta o número de <DerivativeCardKeywords_4:\"Inspiração\"> embaralhadas em 1, até um máximo de 3"
  },
  RelicConfig_13859_Desc = {
    Text = "Compre 1 carta no início do turno. No início da batalha, embaralhe 1 <DerivativeCardKeywords_4:\"Inspiração\"> no seu baralho. Cada batalha vencida aumenta o número de <DerivativeCardKeywords_4:\"Inspiração\"> embaralhadas em 1, até um máximo de 3"
  },
  RelicConfig_13859_Name = {
    Text = "<OrangeQuality:Espelho de Prasno>"
  },
  RelicConfig_13859_StoryDesc = {
    Text = "Truques de Luz e Sombra"
  },
  RelicConfig_13860_BattleDesc = {
    Text = "Sempre que jogar cartas do mesmo Despertado consecutivamente, esse Despertado ganha 8 de Loucura"
  },
  RelicConfig_13860_Desc = {
    Text = "Sempre que jogar cartas do mesmo Despertado consecutivamente, esse Despertado ganha 8 de Loucura"
  },
  RelicConfig_13860_Name = {
    Text = "<WhiteQuality:Cronômetro Preciso>"
  },
  RelicConfig_13860_StoryDesc = {
    Text = "Uma das invenções mais malignas da humanidade"
  },
  RelicConfig_13861_BattleDesc = {
    Text = "Ao coletar, escolha uma carta de despertador e reduza seu custo de poder em 1, tratando-a como \"golpe\""
  },
  RelicConfig_13861_Desc = {
    Text = "Ao coletar, escolha uma carta de despertador e reduza seu custo de poder em 1, tratando-a como \"golpe\""
  },
  RelicConfig_13861_Name = {
    Text = "<OrangeQuality:Erro do Acaso>"
  },
  RelicConfig_13861_StoryDesc = {
    Text = "Ria à vontade!"
  },
  RelicConfig_13862_BattleDesc = {
    Text = "Após pegar, perde permanentemente [Arg1] de <PowerIconKeywords:força>. Cada vez que causa dano, recupera [Arg2] de vida, até 6 vezes por turno"
  },
  RelicConfig_13862_Desc = {
    Text = "Após pegar, perde permanentemente [Arg1] de <PowerIconKeywords:força>. Cada vez que causa dano, recupera [Arg2] de vida, até 6 vezes por turno"
  },
  RelicConfig_13862_Name = {
    Text = "<RedQuality:Beijo da Lampreia>"
  },
  RelicConfig_13862_StoryDesc = {
    Text = "Quer um beijo profundo? Daqueles que tiram a vida"
  },
  RelicConfig_13863_BattleDesc = {
    Text = "No primeiro turno de cada batalha, ganha 3 pontos de aritmética"
  },
  RelicConfig_13863_Desc = {
    Text = "No primeiro turno de cada batalha, ganha 3 pontos de aritmética"
  },
  RelicConfig_13863_Name = {
    Text = "<WhiteQuality:espelho de relógio de bolso>"
  },
  RelicConfig_13863_StoryDesc = {
    Text = "Memórias congeladas no tempo passado, enterradas no fundo negro"
  },
  RelicConfig_13864_BattleDesc = {
    Text = "Após jogar a primeira carta de comando em cada rodada, coloque 1 \"Golpe\" de cada despertador na mão, concedendo-lhe <NothingnessIconKeywords:ilusão> e <DepleteIconKeywords:exausto>"
  },
  RelicConfig_13864_Desc = {
    Text = "Após jogar a primeira carta de comando em cada rodada, coloque 1 \"Golpe\" de cada despertador na mão, concedendo-lhe <NothingnessIconKeywords:ilusão> e <DepleteIconKeywords:exausto>"
  },
  RelicConfig_13864_Name = {
    Text = "<WhiteQuality:Eixo Moderno>"
  },
  RelicConfig_13864_StoryDesc = {
    Text = "Da vila à cidade, do desastre à recuperação"
  },
  RelicConfig_13865_BattleDesc = {
    Text = "Após jogar a primeira carta de comando em cada rodada, coloque 1 \"Defesa\" de cada despertador na mão e adicione <NothingnessIconKeywords:ilusão> e <DepleteIconKeywords:exausto>"
  },
  RelicConfig_13865_Desc = {
    Text = "Após jogar a primeira carta de comando em cada rodada, coloque 1 \"Defesa\" de cada despertador na mão e adicione <NothingnessIconKeywords:ilusão> e <DepleteIconKeywords:exausto>"
  },
  RelicConfig_13865_Name = {
    Text = "<WhiteQuality:Prelúdio Silencioso>"
  },
  RelicConfig_13865_StoryDesc = {
    Text = "O violino do famoso violinista Eric Eckstein.\nAgora, não pode mais ser tocado"
  },
  RelicConfig_13866_BattleDesc = {
    Text = "A cada 3 turnos, adiciona 1 camada <VulnerabilityIconKeywords:vulnerável> a todos os inimigos. Após causar dano a inimigos <VulnerabilityIconKeywords:vulnerável>, eles perdem [Arg1] pontos de <PowerIconKeywords:força> temporários, até 3 vezes por turno"
  },
  RelicConfig_13866_Desc = {
    Text = "A cada 3 turnos, adiciona 1 camada <VulnerabilityIconKeywords:vulnerável> a todos os inimigos. Após causar dano a inimigos <VulnerabilityIconKeywords:vulnerável>, eles perdem [Arg1] pontos de <PowerIconKeywords:força> temporários, até 3 vezes por turno"
  },
  RelicConfig_13866_Name = {
    Text = "<WhiteQuality:Ritual da Primavera>"
  },
  RelicConfig_13866_StoryDesc = {
    Text = "No riso da noite, a silhueta da canoa desliza suavemente sobre o lago"
  },
  RelicConfig_13867_BattleDesc = {
    Text = "Limite de cartas na mão aumenta em 3, mas o número de cartas puxadas por turno diminui em 1. No final do turno, descarte todas as cartas de sintoma e estado na mão, mantendo as outras cartas"
  },
  RelicConfig_13867_Desc = {
    Text = "Limite de cartas na mão aumenta em 3, mas o número de cartas puxadas por turno diminui em 1. No final do turno, descarte todas as cartas de sintoma e estado na mão, mantendo as outras cartas"
  },
  RelicConfig_13867_Name = {
    Text = "<RedQuality:Marca da Consciência>"
  },
  RelicConfig_13867_StoryDesc = {
    Text = "A antiga tribo acreditava que esculpir símbolos especiais na cabeça dos mortos deixaria suas almas para sempre, proporcionando companhia eterna"
  },
  RelicConfig_13868_BattleDesc = {
    Text = "Após liberar 4 explosões de loucura, o custo de aritmética de todas as cartas é reduzido em 1"
  },
  RelicConfig_13868_Desc = {
    Text = "Após liberar 4 explosões de loucura, o custo de aritmética de todas as cartas é reduzido em 1"
  },
  RelicConfig_13868_Name = {
    Text = "<WhiteQuality:☆Plano de Fuga☆>"
  },
  RelicConfig_13868_StoryDesc = {
    Text = "\"Após embarcar, por favor, localize primeiro a saída de emergência mais próxima de sua cabine.\""
  },
  RelicConfig_13869_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Maestria em Domínios> aumenta 100. Cada dano ativo causado, dano temporário de tentáculo + [Arg1], cada dano de tentáculo causado, ganha [Arg2] de escudo. Máximo 6 vezes por turno"
  },
  RelicConfig_13869_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maestria em Domínios> aumenta 100. Cada dano ativo causado, dano temporário de tentáculo + [Arg1], cada dano de tentáculo causado, ganha [Arg2] de escudo. Máximo 6 vezes por turno"
  },
  RelicConfig_13869_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Pesadelo\">"
  },
  RelicConfig_13870_BattleDesc = {
    Text = "A cada vez que consumir 1 ponto de poder, o correspondente despertador ganha 2 pontos de aliemus"
  },
  RelicConfig_13870_Desc = {
    Text = "A cada vez que consumir 1 ponto de poder, o correspondente despertador ganha 2 pontos de aliemus"
  },
  RelicConfig_13870_Name = {
    Text = "<WhiteQuality:Fita de Cetim com Fivela Prateada>"
  },
  RelicConfig_13870_StoryDesc = {
    Text = "A fita que apareceu na cena do crime foi rasgada em dois pedaços por uma força externa.\nUm dos pedaços flutuou do alto e caiu na palma da mão da garota"
  },
  RelicConfig_13871_BattleDesc = {
    Text = "No início de cada rodada, todos os despertadores ganham 10 loucura. Ao coletar, a saúde máxima diminui em 30%"
  },
  RelicConfig_13871_Desc = {
    Text = "No início de cada rodada, todos os despertadores ganham 10 loucura. Ao coletar, a saúde máxima diminui em 30%"
  },
  RelicConfig_13871_Name = {
    Text = "<RedQuality:Visão do Pesadelo>"
  },
  RelicConfig_13871_StoryDesc = {
    Text = "Cuidado, o sono profundo pode engolir tudo sem que você perceba"
  },
  RelicConfig_13873_BattleDesc = {
    Text = "Após jogar \"<ExaltIconKeywords:Despertar>\", remova todos os escudos dos inimigos."
  },
  RelicConfig_13873_Desc = {
    Text = "Após jogar \"<ExaltIconKeywords:Despertar>\", remova todos os escudos dos inimigos."
  },
  RelicConfig_13873_Name = {
    Text = "Espelho negro"
  },
  RelicConfig_13874_BattleDesc = {
    Text = "Nos turnos ímpares, quando o número de cartas restante é 0, puxe 2 cartas; nos turnos pares, quando a aritmética restante é 0, ganhe 2 de aritmética"
  },
  RelicConfig_13874_Desc = {
    Text = "Nos turnos ímpares, quando o número de cartas restante é 0, puxe 2 cartas; nos turnos pares, quando a aritmética restante é 0, ganhe 2 de aritmética"
  },
  RelicConfig_13874_Name = {
    Text = "Guia Dourado Alienado"
  },
  RelicConfig_13875_BattleDesc = {
    Text = "Após jogar \"Ataque\" e \"Defesa\", o corpo correspondente ganha 35 de aliemus. No entanto, o consumo de aritmética deles aumenta em 1"
  },
  RelicConfig_13875_Desc = {
    Text = "Após jogar \"Ataque\" e \"Defesa\", o corpo correspondente ganha 35 de aliemus. No entanto, o consumo de aritmética deles aumenta em 1"
  },
  RelicConfig_13875_Name = {
    Text = "<RedQuality:Rosto Incompleto>"
  },
  RelicConfig_13875_StoryDesc = {
    Text = "De quem é o rosto, cheio de terror, congelado no tempo"
  },
  RelicConfig_13877_BattleDesc = {
    Text = "Após ganhar o 2º Escudo do personagem a cada turno, ganha [Arg1] <plural value=\"[Arg1]\" singular=\"capa\" plural=\"capas\"> de <RetaliateIconKeywords:Contador>. Após ganhar o 4º Escudo do personagem a cada turno, aciona 100% de <RetaliateIconKeywords:Contador> contra todos os inimigos."
  },
  RelicConfig_13877_Desc = {
    Text = "Após ganhar o 2º Escudo do personagem a cada turno, ganha [Arg1] <plural value=\"[Arg1]\" singular=\"capa\" plural=\"capas\"> de <RetaliateIconKeywords:Contador>. Após ganhar o 4º Escudo do personagem a cada turno, aciona 100% de <RetaliateIconKeywords:Contador> contra todos os inimigos."
  },
  RelicConfig_13877_Name = {
    Text = "<WhiteQuality:Franqueza>"
  },
  RelicConfig_13877_StoryDesc = {
    Text = "Ele transmitiu inúmeros segredos, ativos ou passivos"
  },
  RelicConfig_13878_BattleDesc = {
    Text = "A cada 6ª carta de comando jogada, ela retorna da pilha de descarte para a mão"
  },
  RelicConfig_13878_Desc = {
    Text = "A cada 6ª carta de comando jogada, ela retorna da pilha de descarte para a mão"
  },
  RelicConfig_13878_Name = {
    Text = "<OrangeQuality:No Crepúsculo>"
  },
  RelicConfig_13878_StoryDesc = {
    Text = "Vamos tirar uma foto juntos! Sinta a dor real"
  },
  RelicConfig_13879_BattleDesc = {
    Text = "Após liberar 5 explosões de loucura, o despertador que liberou a explosão de loucura ganha 100 de loucura"
  },
  RelicConfig_13879_Desc = {
    Text = "Após liberar 5 explosões de loucura, o despertador que liberou a explosão de loucura ganha 100 de loucura"
  },
  RelicConfig_13879_Name = {
    Text = "<OrangeQuality:Pequeno Envolto>"
  },
  RelicConfig_13879_StoryDesc = {
    Text = "Carregando esperança, bênçãos e amor"
  },
  RelicConfig_13880_BattleDesc = {
    Text = "Ao causar dano ativo, ganha [Arg1] de escudo. Ao curar, ganha [Arg2] de <PowerIconKeywords:força> temporária"
  },
  RelicConfig_13880_Desc = {
    Text = "Ao causar dano ativo, ganha [Arg1] de escudo. Ao curar, ganha [Arg2] de <PowerIconKeywords:força> temporária"
  },
  RelicConfig_13880_Name = {
    Text = "<OrangeQuality:Nossa Casa>"
  },
  RelicConfig_13880_StoryDesc = {
    Text = "Eles estavam juntos antes e estarão juntos para sempre. Eles são uma família amorosa"
  },
  RelicConfig_13881_BattleDesc = {
    Text = "No início dos turnos ímpares, ganha [Arg1] pontos temporários de <PowerIconKeywords:força>. No início dos turnos pares, ganha [Arg2] pontos temporários de <AlertIconKeywords:alerta>"
  },
  RelicConfig_13881_Desc = {
    Text = "No início dos turnos ímpares, ganha [Arg1] pontos temporários de <PowerIconKeywords:força>. No início dos turnos pares, ganha [Arg2] pontos temporários de <AlertIconKeywords:alerta>"
  },
  RelicConfig_13881_Name = {
    Text = "<WhiteQuality:Boneca Gêmea>"
  },
  RelicConfig_13881_StoryDesc = {
    Text = "Gêmeos são um presente do velho mundo, uma parábola para o futuro"
  },
  RelicConfig_13882_BattleDesc = {
    Text = "No final do turno, o Despertado que jogou a primeira carta de comando ganha 20 de Loucura. Se possuir a criação \"Espírito de Devoção\", outros Despertados ganham 5 de Loucura"
  },
  RelicConfig_13882_Desc = {
    Text = "No final do turno, o Despertado que jogou a primeira carta de comando ganha 20 de Loucura. Se possuir a criação \"Espírito de Devoção\", outros Despertados ganham 5 de Loucura"
  },
  RelicConfig_13882_Name = {
    Text = "<WhiteQuality:Estátua da Mãe>"
  },
  RelicConfig_13882_StoryDesc = {
    Text = "\"Eu te darei qualquer coisa, o que você quiser, por favor, deixe-o ir.\""
  },
  RelicConfig_13883_BattleDesc = {
    Text = "Sempre que um Despertado realiza 1 <DevouredIconKeywords:devorar>, outros Despertados ganham 10 loucura"
  },
  RelicConfig_13883_Desc = {
    Text = "Sempre que um Despertado realiza 1 <DevouredIconKeywords:devorar>, outros Despertados ganham 10 loucura"
  },
  RelicConfig_13883_Name = {
    Text = "<OrangeQuality:Sonho Dourado>"
  },
  RelicConfig_13883_StoryDesc = {
    Text = "O dia da metamorfose será o seu fim"
  },
  RelicConfig_13884_BattleDesc = {
    Text = "\"Strike\" aplica [Arg1] pilhas de <IntoxicationIconKeywords:Veneno> a todos os inimigos."
  },
  RelicConfig_13884_Desc = {
    Text = "\"Strike\" aplica [Arg1] pilhas de <IntoxicationIconKeywords:Veneno> a todos os inimigos."
  },
  RelicConfig_13884_Name = {
    Text = "<WhiteQuality:Neurotoxina>"
  },
  RelicConfig_13884_StoryDesc = {
    Text = "Extrair, destilar"
  },
  RelicConfig_13885_BattleDesc = {
    Text = "No início da batalha, adicione 1 carta de <DerivativeCardKeywords_1:\"Eco da Sombra\"> à sua mão. Se for uma batalha contra chefe, ganhe 1 carta adicional de <DerivativeCardKeywords_1:\"Eco da Sombra\">"
  },
  RelicConfig_13885_Desc = {
    Text = "No início da batalha, adicione 1 carta de <DerivativeCardKeywords_1:\"Eco da Sombra\"> à sua mão. Se for uma batalha contra chefe, ganhe 1 carta adicional de <DerivativeCardKeywords_1:\"Eco da Sombra\">"
  },
  RelicConfig_13885_Name = {
    Text = "<WhiteQuality:Equipamento de Comunicação>"
  },
  RelicConfig_13885_StoryDesc = {
    Text = "Esperando ou temendo o momento em que o sino tocar"
  },
  RelicConfig_13886_BattleDesc = {
    Text = "Cada vez que você reinicia o baralho, adicione 2 <DerivativeCardKeywords_6:\"Tridente\"> e 1 <DerivativeCardKeywords_5:\"Parasol\"> à sua mão."
  },
  RelicConfig_13886_Desc = {
    Text = "Cada vez que você reinicia o baralho, adicione 2 <DerivativeCardKeywords_6:\"Tridente\"> e 1 <DerivativeCardKeywords_5:\"Parasol\"> à sua mão."
  },
  RelicConfig_13886_Name = {
    Text = "<WhiteQuality:☆Bolsa de Dama☆>"
  },
  RelicConfig_13886_StoryDesc = {
    Text = "Deveria carregar delicadeza, não morte"
  },
  RelicConfig_13887_BattleDesc = {
    Text = "No início do turno, adicione 1 <DerivativeCardKeywords_5:\"Tridente\"> à mão. Após liberar exaltar, aumente <PowerIconKeywords:STR> de todos os \"Tridentes\" na mão em [Arg2]"
  },
  RelicConfig_13887_Desc = {
    Text = "No início do turno, adicione 1 <DerivativeCardKeywords_5:\"Tridente\"> à mão. Após liberar exaltar, aumente <PowerIconKeywords:STR> de todos os \"Tridentes\" na mão em [Arg2]"
  },
  RelicConfig_13887_Name = {
    Text = "<WhiteQuality:tridente>"
  },
  RelicConfig_13887_StoryDesc = {
    Text = "Parece comum de qualquer forma"
  },
  RelicConfig_13888_BattleDesc = {
    Text = "No início da batalha, ganhe [Arg1] de escudo. Após usar \"Defesa\" 7 vezes nesta batalha, ganhe imediatamente [Arg2] de escudo. Após usar \"Defesa\" 21 vezes nesta batalha, ganhe 1 camada de barreira temporária"
  },
  RelicConfig_13888_Desc = {
    Text = "No início da batalha, ganhe [Arg1] de escudo. Após usar \"Defesa\" 7 vezes nesta batalha, ganhe imediatamente [Arg2] de escudo. Após usar \"Defesa\" 21 vezes nesta batalha, ganhe 1 camada de barreira temporária"
  },
  RelicConfig_13888_Name = {
    Text = "<WhiteQuality:Jornal da Manhã de Putney>"
  },
  RelicConfig_13888_StoryDesc = {
    Text = "Seu companheiro de banheiro mais fiel"
  },
  RelicConfig_13889_BattleDesc = {
    Text = "Ao entrar na rodada ultra, ganhe 3 pontos de aritmética"
  },
  RelicConfig_13889_Desc = {
    Text = "Ao entrar na rodada ultra, ganhe 3 pontos de aritmética"
  },
  RelicConfig_13889_Name = {
    Text = "<WhiteQuality:ampulheta brilhante>"
  },
  RelicConfig_13889_StoryDesc = {
    Text = "Uma quantidade mensurável de tempo"
  },
  RelicConfig_13890_BattleDesc = {
    Text = "Ao início da batalha, aplique 1 turno de <WeaknessIconKeywords:fraqueza> e <VulnerabilityIconKeywords:vulnerável> a todos os inimigos. Se for uma batalha de chefe, aplique 2 turnos adicionais de <WeaknessIconKeywords:fraqueza> e <VulnerabilityIconKeywords:vulnerável>"
  },
  RelicConfig_13890_Desc = {
    Text = "Ao início da batalha, aplique 1 turno de <WeaknessIconKeywords:fraqueza> e <VulnerabilityIconKeywords:vulnerável> a todos os inimigos. Se for uma batalha de chefe, aplique 2 turnos adicionais de <WeaknessIconKeywords:fraqueza> e <VulnerabilityIconKeywords:vulnerável>"
  },
  RelicConfig_13890_Name = {
    Text = "<WhiteQuality:Camisa de Força>"
  },
  RelicConfig_13890_StoryDesc = {
    Text = "Não só o tempo descolore o tecido, o medo e a dor também"
  },
  RelicConfig_13891_BattleDesc = {
    Text = "Se a primeira carta de comando jogada em uma rodada ativa o efeito de salto, sorteie 1 carta, caso contrário, ganhe 1 ponto de aritmética. Se for uma rodada ultra, ambas os efeitos acima"
  },
  RelicConfig_13891_Desc = {
    Text = "Se a primeira carta de comando jogada em uma rodada ativa o efeito de salto, sorteie 1 carta, caso contrário, ganhe 1 ponto de aritmética. Se for uma rodada ultra, ambas os efeitos acima"
  },
  RelicConfig_13891_Name = {
    Text = "<OrangeQuality:Dispositivo de Salto>"
  },
  RelicConfig_13891_StoryDesc = {
    Text = "Refletiu uma sombra distorcida"
  },
  RelicConfig_13892_BattleDesc = {
    Text = "Ganhe uma missão. Complete a missão para receber recompensas. [Event Placeholder]"
  },
  RelicConfig_13892_Desc = {
    Text = "Ganhe uma missão. Complete a missão para receber recompensas. [Event Placeholder]"
  },
  RelicConfig_13892_Name = {
    Text = "<WhiteQuality:Diário Velho>"
  },
  RelicConfig_13892_StoryDesc = {
    Text = "Um diário velho, cujas páginas internas estão cheias de folhas soltas, contendo pelo menos o mapa de Elworth, registros de experimentos e cartas manchadas com marcas de erosão em triângulo.\nO início das anotações é claro e organizado, mas, conforme avança, torna-se cada vez mais desleixado e confuso."
  },
  RelicConfig_13893_BattleDesc = {
    Text = "A cada 4ª vez que ganhar escudo, recupera 50% do valor do escudo em vida"
  },
  RelicConfig_13893_Desc = {
    Text = "A cada 4ª vez que ganhar escudo, recupera 50% do valor do escudo em vida"
  },
  RelicConfig_13893_Name = {
    Text = "<WhiteQuality:Apito de Marinheiro>"
  },
  RelicConfig_13893_StoryDesc = {
    Text = "Além das sereias, o apito pode chamar furacões, botas fedorentas e marinheiros que não tomam banho há cem dias"
  },
  RelicConfig_13894_BattleDesc = {
    Text = "Se o número de cartas jogadas na rodada anterior for menor ou igual a 4, a primeira carta jogada nesta rodada terá efeito 2 vezes"
  },
  RelicConfig_13894_Desc = {
    Text = "Se o número de cartas jogadas na rodada anterior for menor ou igual a 4, a primeira carta jogada nesta rodada terá efeito 2 vezes"
  },
  RelicConfig_13894_Name = {
    Text = "<OrangeQuality:☆Lanterna do Pesadelo☆>"
  },
  RelicConfig_13894_StoryDesc = {
    Text = "Introduza o Sonho Ilusório"
  },
  RelicConfig_13895_BattleDesc = {
    Text = "Sempre que perder vida, o Despertado com menos loucura ganha 10 loucura. A cada 5 perdas de vida, recupera 20% da vida perdida"
  },
  RelicConfig_13895_Desc = {
    Text = "Sempre que perder vida, o Despertado com menos loucura ganha 10 loucura. A cada 5 perdas de vida, recupera 20% da vida perdida"
  },
  RelicConfig_13895_Name = {
    Text = "<OrangeQuality:Pêndulo Crono\"Análise\">"
  },
  RelicConfig_13896_BattleDesc = {
    Text = "A saúde máxima aumenta em 2. A cada vez que o baralho for resetado, adicione 1 <DerivativeCardKeywords_9:\"Tropeço\"> ao baralho de puxar"
  },
  RelicConfig_13896_Desc = {
    Text = "A saúde máxima aumenta em 2. A cada vez que o baralho for resetado, adicione 1 <DerivativeCardKeywords_9:\"Tropeço\"> ao baralho de puxar"
  },
  RelicConfig_13896_Name = {
    Text = "<RedQuality:Vela Negra>"
  },
  RelicConfig_13896_StoryDesc = {
    Text = "Queime a lucidez, caia na ilusão"
  },
  RelicConfig_13897_BattleDesc = {
    Text = "\"<ExaltIconKeywords:Rouse>\" persiste no final da curva."
  },
  RelicConfig_13897_Desc = {
    Text = "\"<ExaltIconKeywords:Rouse>\" persiste no final da curva."
  },
  RelicConfig_13897_Name = {
    Text = "Espelho branco"
  },
  RelicConfig_13898_BattleDesc = {
    Text = "A cada 1 despertador que já foi ativado, aumenta <ProficientInRealmsIconKeywords:mestre de reinos> em 35. Ao jogar \"<ExaltIconKeywords:despertar>\", receberá aleatoriamente 2 cartas de comando desse despertador e adicionará \"exausto\""
  },
  RelicConfig_13898_Desc = {
    Text = "A cada 1 despertador que já foi ativado, aumenta <ProficientInRealmsIconKeywords:mestre de reinos> em 35. Ao jogar \"<ExaltIconKeywords:despertar>\", receberá aleatoriamente 2 cartas de comando desse despertador e adicionará \"exausto\""
  },
  RelicConfig_13898_Name = {
    Text = "<OrangeQuality:Oráculo Dele>"
  },
  RelicConfig_13898_StoryDesc = {
    Text = "Ele disse, não tenha medo"
  },
  RelicConfig_13899_BattleDesc = {
    Text = "No início do turno, <ProficientInRealmsIconKeywords:Maestria em Domínios> aumenta em 50. Quando não estiver em estado negativo, <ProficientInRealmsIconKeywords:Maestria em Domínios> aumenta para 150"
  },
  RelicConfig_13899_Desc = {
    Text = "No início do turno, <ProficientInRealmsIconKeywords:Maestria em Domínios> aumenta em 50. Quando não estiver em estado negativo, <ProficientInRealmsIconKeywords:Maestria em Domínios> aumenta para 150"
  },
  RelicConfig_13899_Name = {
    Text = "<WhiteQuality:☆\"Pela Liberdade\"☆>"
  },
  RelicConfig_13899_StoryDesc = {
    Text = "Um punhado de prata nostálgica"
  },
  RelicConfig_13900_BattleDesc = {
    Text = "Após usar \"exaltar\", o custo de poder de todas as cartas na mão é reduzido em -1"
  },
  RelicConfig_13900_Desc = {
    Text = "Após usar \"exaltar\", o custo de poder de todas as cartas na mão é reduzido em -1"
  },
  RelicConfig_13900_Name = {
    Text = "Luz da Civilização Mutante"
  },
  RelicConfig_13901_BattleDesc = {
    Text = "Cada vez que uma carta de comando é disparada, ganha [Arg2]% de <DeathResistanceIconKeywords:resistência à morte> (a resistência à morte ganha é reduzida pela metade a cada ativação nesta fase). Se a sua <DeathResistanceIconKeywords:resistência à morte> for igual ou superior a 100%, passa a ganhar [Arg1] pontos de <PowerIconKeywords:força> temporária."
  },
  RelicConfig_13901_Desc = {
    Text = "Cada vez que uma carta de comando é disparada, ganha [Arg2]% de <DeathResistanceIconKeywords:resistência à morte> (a resistência à morte ganha é reduzida pela metade a cada ativação nesta fase). Se a sua <DeathResistanceIconKeywords:resistência à morte> for igual ou superior a 100%, em vez disso, ganha [Arg1] pontos de <PowerIconKeywords:força> temporários."
  },
  RelicConfig_13901_Name = {
    Text = "<OrangeQuality:Pele de Serpente>"
  },
  RelicConfig_13901_StoryDesc = {
    Text = "Renascido da casca mutilada"
  },
  RelicConfig_13902_BattleDesc = {
    Text = "No início do turno, ganha [Arg2] de Escudo do personagem. No final do turno, causa <FixedDamage:Dano Puro> igual a [Arg1]% do seu Escudo do personagem atual a um inimigo aleatório. O efeito de Dano é dobrado em Batalhas do Líder."
  },
  RelicConfig_13902_Desc = {
    Text = "No início do turno, ganha [Arg2] de Escudo do personagem. No final do turno, causa <FixedDamage:Dano Puro> igual a [Arg1]% do seu Escudo do personagem atual a um inimigo aleatório. O efeito de Dano é dobrado em Batalhas do Líder."
  },
  RelicConfig_13902_Name = {
    Text = "<WhiteQuality:Guia Dourado>"
  },
  RelicConfig_13902_StoryDesc = {
    Text = "Abra quando estiver perdido, mas cuidado - sua coroa não deve ver a luz do sol"
  },
  RelicConfig_13904_BattleDesc = {
    Text = "Intenção oculta do monstro. A cada turno, ganha-se 1 ponto de aritmética e compra-se 1 cartão"
  },
  RelicConfig_13904_Desc = {
    Text = "Intenção oculta do monstro. A cada turno, ganha-se 1 ponto de aritmética e compra-se 1 cartão"
  },
  RelicConfig_13904_Name = {
    Text = "<RedQuality:Sino do Encanto>"
  },
  RelicConfig_13904_StoryDesc = {
    Text = "Ding ling ling, ding ling ling"
  },
  RelicConfig_13905_BattleDesc = {
    Text = "Após o início da batalha, ganhe [Arg2] camadas de <RetaliateIconKeywords: contra-ataque>, e jogue \"defesa\" para ganhar [Arg1] camadas de <RetaliateIconKeywords: contra-ataque>"
  },
  RelicConfig_13905_Desc = {
    Text = "Após o início da batalha, ganhe [Arg2] camadas de <RetaliateIconKeywords: contra-ataque>, e jogue \"defesa\" para ganhar [Arg1] camadas de <RetaliateIconKeywords: contra-ataque>"
  },
  RelicConfig_13905_Name = {
    Text = "<WhiteQuality:Colete de Urtiga>"
  },
  RelicConfig_13905_StoryDesc = {
    Text = "Não pode identificar o líquido contaminado"
  },
  RelicConfig_13906_BattleDesc = {
    Text = "É um item de missão semanal sem efeito 4"
  },
  RelicConfig_13906_Desc = {
    Text = "É um item de missão semanal sem efeito 4"
  },
  RelicConfig_13906_Name = {
    Text = "Desafio Diário Substituto 4"
  },
  RelicConfig_13907_BattleDesc = {
    Text = "Ao iniciar a rodada, se o número de cartas jogadas no último turno exceder 3, compre 2 cartas"
  },
  RelicConfig_13907_Desc = {
    Text = "Ao iniciar a rodada, se o número de cartas jogadas no último turno exceder 3, compre 2 cartas"
  },
  RelicConfig_13907_Name = {
    Text = "<WhiteQuality:Carteira Nova>"
  },
  RelicConfig_13907_StoryDesc = {
    Text = "Uma carteira de couro com o emblema da universidade de Mythag.\nEstá agora completamente vazia, sem nada dentro"
  },
  RelicConfig_13908_BattleDesc = {
    Text = "Após usar \"exaltar\", os despertadores ganham [Arg1] pontos de loucura"
  },
  RelicConfig_13908_Desc = {
    Text = "Após usar \"exaltar\", os despertadores ganham [Arg1] pontos de loucura"
  },
  RelicConfig_13908_Name = {
    Text = "Véu do Deus Desconhecido Mutante"
  },
  RelicConfig_13909_BattleDesc = {
    Text = "Após liberar a exaltação, perca 8% da vida atual, roube [Arg1] pontos de <PowerIconKeywords:poder> temporários de todos os inimigos; se houver apenas 1 inimigo, roube [Arg2] pontos adicionais de <PowerIconKeywords:poder> temporários"
  },
  RelicConfig_13909_Desc = {
    Text = "Após liberar a exaltação, perca 8% da vida atual, roube [Arg1] pontos de <PowerIconKeywords:poder> temporários de todos os inimigos; se houver apenas 1 inimigo, roube [Arg2] pontos adicionais de <PowerIconKeywords:poder> temporários"
  },
  RelicConfig_13909_Name = {
    Text = "<RedQuality:Pássaro do Ritual do Destino>"
  },
  RelicConfig_13909_StoryDesc = {
    Text = "O corpo seco emitiu um grito"
  },
  RelicConfig_13910_BattleDesc = {
    Text = "Após liberar a exaltação, o despertador correspondente ganha 10 de aliemus e [Arg1] pontos de escudo"
  },
  RelicConfig_13910_Desc = {
    Text = "Após liberar a exaltação, o despertador correspondente ganha 10 de aliemus e [Arg1] pontos de escudo"
  },
  RelicConfig_13910_Name = {
    Text = "<OrangeQuality:Véu do Deus Anônimo>"
  },
  RelicConfig_13910_StoryDesc = {
    Text = "Não olhe diretamente para o deus"
  },
  RelicConfig_13911_BattleDesc = {
    Text = "No final do turno, o Despertado que jogou a última carta de comando ganha 20 de Loucura. Se possuir a criação \"Estátua da Mãe\", outros Despertados ganham 5 de Loucura"
  },
  RelicConfig_13911_Desc = {
    Text = "No final do turno, o Despertado que jogou a última carta de comando ganha 20 de Loucura. Se possuir a criação \"Estátua da Mãe\", outros Despertados ganham 5 de Loucura"
  },
  RelicConfig_13911_Name = {
    Text = "<WhiteQuality:Devoção>"
  },
  RelicConfig_13911_StoryDesc = {
    Text = "\"Eu te darei qualquer coisa, qualquer coisa mesmo. Por favor, tenha piedade de mim.\""
  },
  RelicConfig_13912_BattleDesc = {
    Text = "Ao final da rodada, a cada 1 carta na mão, ganhe 1 ponto de poder ao iniciar a próxima rodada"
  },
  RelicConfig_13912_Desc = {
    Text = "Ao final da rodada, a cada 1 carta na mão, ganhe 1 ponto de poder ao iniciar a próxima rodada"
  },
  RelicConfig_13912_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Desempenho\">"
  },
  RelicConfig_13913_BattleDesc = {
    Text = "Ao iniciar a rodada, se a vida for maior que [Arg1], perca [Arg1] de vida, ganhando [Arg2] pontos de <PowerIconKeywords:poder> e [Arg3] pontos de <AlertIconKeywords:alerta> durante a rodada"
  },
  RelicConfig_13913_Desc = {
    Text = "Ao iniciar a rodada, se a vida for maior que [Arg1], perca [Arg1] de vida, ganhando [Arg2] pontos de <PowerIconKeywords:poder> e [Arg3] pontos de <AlertIconKeywords:alerta> durante a rodada"
  },
  RelicConfig_13913_Name = {
    Text = "<RedQuality:Membro da Salvação>"
  },
  RelicConfig_13913_StoryDesc = {
    Text = [[
Uma parte sagrada.
Mesmo separada do corpo, ainda se sente o calor]]
  },
  RelicConfig_13914_BattleDesc = {
    Text = "\"Ataque\" ganha 2 Aritmética e descarta 1 cartão aleatório; \"Defesa\" compra 2 cartões e perde 1 Aritmética. Pode ser ativado até 3 vezes por turno."
  },
  RelicConfig_13914_Desc = {
    Text = "\"Ataque\" ganha 2 Aritmética e descarta 1 cartão aleatório; \"Defesa\" compra 2 cartões e perde 1 Aritmética. Pode ser ativado até 3 vezes por turno."
  },
  RelicConfig_13914_Name = {
    Text = "<RedQuality:Disco da Felicidade>"
  },
  RelicConfig_13914_StoryDesc = {
    Text = "Gravou o disco da última apresentação do famoso violinista.\nDesde então, ele pode trazer fogo"
  },
  RelicConfig_13915_BattleDesc = {
    Text = "Efeito de bônus da recomendação de domínio aumentado para 50%, no início da fase sua <ProficientInRealmsIconKeywords:Maestria em Domínios> é dobrada"
  },
  RelicConfig_13915_Desc = {
    Text = "Efeito de bônus da recomendação de domínio aumentado para 50%, no início da fase sua <ProficientInRealmsIconKeywords:Maestria em Domínios> é dobrada"
  },
  RelicConfig_13915_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Entrando no Sonho\">"
  },
  RelicConfig_13916_BattleDesc = {
    Text = "Após liberar a Fúria Explosiva, o próximo cartão de comando jogado tem efeito 2 vezes"
  },
  RelicConfig_13916_Desc = {
    Text = "Após liberar a Fúria Explosiva, o próximo cartão de comando jogado tem efeito 2 vezes"
  },
  RelicConfig_13916_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Mergulhando\">"
  },
  RelicConfig_13917_BattleDesc = {
    Text = "Se a intenção do inimigo for ataque, causar dano fará com que seu <PowerIconKeywords: poder> diminua temporariamente [Arg1] pontos, caso contrário, adicionará sangramento equivalente a 25% do dano <BleedingIconKeywords: sangramento>, podendo ser ativado no máximo 6 vezes por rodada"
  },
  RelicConfig_13917_Desc = {
    Text = "Se a intenção do inimigo for ataque, causar dano fará com que seu <PowerIconKeywords: poder> diminua temporariamente [Arg1] pontos, caso contrário, adicionará sangramento equivalente a 25% do dano <BleedingIconKeywords: sangramento>, podendo ser ativado no máximo 6 vezes por rodada"
  },
  RelicConfig_13917_Name = {
    Text = "<WhiteQuality:Coração Alienígena>"
  },
  RelicConfig_13917_StoryDesc = {
    Text = "Dois \"corações\" juntos"
  },
  RelicConfig_13918_BattleDesc = {
    Text = "Cada vez que causa dano, ganha [Arg1] pontos de <PowerIconKeywords:força> temporária, até 3 vezes. Ao atingir o máximo, o efeito dobra"
  },
  RelicConfig_13918_Desc = {
    Text = "Cada vez que causa dano, ganha [Arg1] pontos de <PowerIconKeywords:força> temporária, até 3 vezes. Ao atingir o máximo, o efeito dobra"
  },
  RelicConfig_13918_Name = {
    Text = "<WhiteQuality:Ágata Enrolada>"
  },
  RelicConfig_13918_StoryDesc = {
    Text = "Provavelmente é apenas um padrão comum de ágata. Acho"
  },
  RelicConfig_13919_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Maestria em Domínios> aumenta 50. Ao pegar, escolha uma criação e troque por uma aleatória"
  },
  RelicConfig_13919_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maestria em Domínios> aumenta 50. Ao pegar, escolha uma criação e troque por uma aleatória"
  },
  RelicConfig_13919_Name = {
    Text = "<WhiteQuality:Calidoscópio>"
  },
  RelicConfig_13919_StoryDesc = {
    Text = "Tudo que vejo e penso é ilusão"
  },
  RelicConfig_13920_BattleDesc = {
    Text = "Efeito de fraqueza aumentado em 5%. Ao aplicar <WeaknessIconKeywords:fraqueza>, rouba temporariamente [Arg1] pontos de <PowerIconKeywords:força> do alvo"
  },
  RelicConfig_13920_Desc = {
    Text = "Efeito de Sintoma: Enfraquecer aumentado em 5%. Ao aplicar <WeaknessIconKeywords:Sintoma: Enfraquecer>, rouba temporariamente [Arg1] pontos de <PowerIconKeywords:FOR> do alvo"
  },
  RelicConfig_13920_Name = {
    Text = "<WhiteQuality:Foto Desbotada>"
  },
  RelicConfig_13920_StoryDesc = {
    Text = "Fotos borradas carregam memórias vagas, ou talvez seja a falha da memória que desbota as fotos."
  },
  RelicConfig_13921_BattleDesc = {
    Text = "Ao coletar, escolha 2 cartas de comando para remover e ganhe [Arg1] <PowerIconKeywords:poder>"
  },
  RelicConfig_13921_Desc = {
    Text = "Ao coletar, escolha 2 cartas de comando para remover e ganhe [Arg1] <PowerIconKeywords:poder>"
  },
  RelicConfig_13921_Name = {
    Text = "<RedQuality:Cinzas da Estrela Negra>"
  },
  RelicConfig_13921_StoryDesc = {
    Text = "Fogo não extinto"
  },
  RelicConfig_13922_BattleDesc = {
    Text = "Após liberar a explosão de loucura 2 vezes em cada turno, todos os despertadores ganham 8 de loucura. Após 3 liberações, todos os despertadores ganham mais 8 de loucura"
  },
  RelicConfig_13922_Desc = {
    Text = "Após liberar a explosão de loucura 2 vezes em cada turno, todos os despertadores ganham 8 de loucura. Após 3 liberações, todos os despertadores ganham mais 8 de loucura"
  },
  RelicConfig_13922_Name = {
    Text = "<OrangeQuality:Sangue dos Esquecidos>"
  },
  RelicConfig_13922_StoryDesc = {Text = "Derretendo"},
  RelicConfig_13923_BattleDesc = {
    Text = "Para cada dano causado, ganhe [Arg1] de escudo. A cada 3 escudos restantes no início do turno, ganhe 1 de <PowerIconKeywords:força> temporária e dano de tentáculo"
  },
  RelicConfig_13923_Desc = {
    Text = "Para cada dano causado, ganhe [Arg1] de escudo. A cada 3 escudos restantes no início do turno, ganhe 1 de <PowerIconKeywords:força> temporária e dano de tentáculo"
  },
  RelicConfig_13923_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Segredo\">"
  },
  RelicConfig_13924_BattleDesc = {
    Text = "Sempre que o efeito <TransitionIconKeywords: salto> é ativado, roube [Arg1] pontos temporários de <PowerIconKeywords: poder> de todos os inimigos; se houver apenas 1 inimigo, roube [Arg2] pontos temporários de <PowerIconKeywords: poder> adicionais"
  },
  RelicConfig_13924_Desc = {
    Text = "Sempre que o efeito <TransitionIconKeywords: salto> é ativado, roube [Arg1] pontos temporários de <PowerIconKeywords: poder> de todos os inimigos; se houver apenas 1 inimigo, roube [Arg2] pontos temporários de <PowerIconKeywords: poder> adicionais"
  },
  RelicConfig_13924_Name = {
    Text = "<OrangeQuality:Defletor Espacial>"
  },
  RelicConfig_13924_StoryDesc = {
    Text = "Salto no Vazio"
  },
  RelicConfig_13925_BattleDesc = {
    Text = "Ao iniciar a rodada, compre 1 carta. Ao jogar 2 cartas consecutivas com o mesmo custo de aritmética da última carta, compre 1 carta extra, com um máximo de 3 vezes por rodada"
  },
  RelicConfig_13925_Desc = {
    Text = "Ao iniciar a rodada, compre 1 carta. Ao jogar 2 cartas consecutivas com o mesmo custo de aritmética da última carta, compre 1 carta extra, com um máximo de 3 vezes por rodada"
  },
  RelicConfig_13925_Name = {
    Text = "<OrangeQuality:Ritual do Conhecimento Universal>"
  },
  RelicConfig_13925_StoryDesc = {
    Text = "Onisciente e onipotente"
  },
  RelicConfig_13926_BattleDesc = {
    Text = "Ao início da batalha, para cada selo em seu baralho, ganhe [Arg1] pontos <PowerIconKeywords:poder>, e para cada relíquia, recupere [Arg2] pontos de vida"
  },
  RelicConfig_13926_Desc = {
    Text = "Ao início da batalha, para cada selo em seu baralho, ganhe [Arg1] pontos <PowerIconKeywords:poder>, e para cada relíquia, recupere [Arg2] pontos de vida"
  },
  RelicConfig_13926_Name = {
    Text = "<OrangeQuality:☆Medalha da Guilda☆>"
  },
  RelicConfig_13926_StoryDesc = {
    Text = "\"Vista isso, e você será um membro da Câmara de Comércio de Londinium.\""
  },
  RelicConfig_13927_BattleDesc = {
    Text = "Ao pegar, remova 1 cartão sintoma. Atualize 1 marca aleatória para uma marca avançada"
  },
  RelicConfig_13927_Desc = {
    Text = "Ao pegar, remova 1 cartão sintoma. Atualize 1 marca aleatória para uma marca avançada"
  },
  RelicConfig_13927_Name = {
    Text = "<WhiteQuality:Pé de Coelho da Sorte>"
  },
  RelicConfig_13927_StoryDesc = {
    Text = "Para o coelho, não foi tão sortudo"
  },
  RelicConfig_13928_BattleDesc = {
    Text = "Taxa crítica aumenta em 15%. Para cada carta jogada, a taxa crítica temporária aumenta em 5%"
  },
  RelicConfig_13928_Desc = {
    Text = "Taxa crítica aumenta em 15%. Para cada carta jogada, a taxa crítica temporária aumenta em 5%"
  },
  RelicConfig_13928_Name = {
    Text = "<OrangeQuality:Espelho Ritual de Mênfis>"
  },
  RelicConfig_13928_StoryDesc = {
    Text = "\"O que você viu dentro?\""
  },
  RelicConfig_13929_BattleDesc = {
    Text = "Cada vez que você perde Vida, ganha [Arg1] <plural value=\"[Arg1]\" singular=\"capa\" plural=\"capas\"> de <RetaliateIconKeywords:Contador>. Se este for o 3º acionamento em um único turno, aciona 100% de <RetaliateIconKeywords:Contador> contra todos os inimigos."
  },
  RelicConfig_13929_Desc = {
    Text = "Cada vez que você perde Vida, ganha [Arg1] <plural value=\"[Arg1]\" singular=\"capa\" plural=\"capas\"> de <RetaliateIconKeywords:Contador>. Se este for o 3º acionamento em um único turno, aciona 100% de <RetaliateIconKeywords:Contador> contra todos os inimigos."
  },
  RelicConfig_13929_Name = {
    Text = "<WhiteQuality:Relógio de Bolso do Amigo>"
  },
  RelicConfig_13929_StoryDesc = {
    Text = "Com saudade e tristeza, avance para o desconhecido"
  },
  RelicConfig_13930_BattleDesc = {
    Text = "No final do turno, se tiver 1 carta na mão, aplique [Arg1] camadas de <IntoxicationIconKeywords:veneno> em todos os inimigos"
  },
  RelicConfig_13930_Desc = {
    Text = "No final do turno, se tiver 1 carta na mão, aplique [Arg1] camadas de <IntoxicationIconKeywords:veneno> em todos os inimigos"
  },
  RelicConfig_13930_Name = {
    Text = "<WhiteQuality:Pomada Suspeita>"
  },
  RelicConfig_13930_StoryDesc = {
    Text = "Um ungüento caseiro para feridas, não use sem orientação médica"
  },
  RelicConfig_13931_BattleDesc = {
    Text = "Ganhe [Arg1] <PowerIconKeywords:STR> ao ser coletado. Ganhe [Arg2] Temporário <PowerIconKeywords:STR> sempre que um <DerivativeCardKeywords_2:\"Embrião\"> for fundido"
  },
  RelicConfig_13931_Desc = {
    Text = "Ganhe [Arg1] <PowerIconKeywords:STR> ao ser coletado. Ganhe [Arg2] Temporário <PowerIconKeywords:STR> sempre que um <DerivativeCardKeywords_2:\"Embrião\"> for fundido"
  },
  RelicConfig_13931_Name = {
    Text = "<WhiteQuality:Seixo Ensanguentado>"
  },
  RelicConfig_13931_StoryDesc = {
    Text = "Um, dois, três, quatro, cinco"
  },
  RelicConfig_13932_BattleDesc = {
    Text = "A cada terceira vez que \"Defesa\" é jogado, ganhe [Arg1] pontos de Escudo. O respectivo Despertador ganha 15 Aliemus."
  },
  RelicConfig_13932_Desc = {
    Text = "A cada terceira vez que \"Defesa\" é jogado, ganhe [Arg1] pontos de Escudo. O respectivo Despertador ganha 15 Aliemus."
  },
  RelicConfig_13932_Name = {
    Text = "<WhiteQuality:Luvas Silenciosas>"
  },
  RelicConfig_13932_StoryDesc = {
    Text = "Elas foram manchadas por sangue, lágrimas e mofo"
  },
  RelicConfig_13933_BattleDesc = {
    Text = "É um item de missão semanal sem efeito 6"
  },
  RelicConfig_13933_Desc = {
    Text = "É um item de missão semanal sem efeito 6"
  },
  RelicConfig_13933_Name = {
    Text = "Desafio Diário Substituto 6"
  },
  RelicConfig_13934_BattleDesc = {
    Text = "É um item de missão semanal sem efeito 5"
  },
  RelicConfig_13934_Desc = {
    Text = "É um item de missão semanal sem efeito 5"
  },
  RelicConfig_13934_Name = {
    Text = "Desafio Diário Substituto 5"
  },
  RelicConfig_13935_BattleDesc = {
    Text = "Taxa crítica aumenta em 10%. Após o primeiro crítico de cada rodada, aumenta a taxa crítica em mais 20%; após o terceiro crítico causado na rodada, aumenta o dano crítico em mais 50%"
  },
  RelicConfig_13935_Desc = {
    Text = "Taxa crítica aumenta em 10%. Após o primeiro crítico de cada rodada, aumenta a taxa crítica em mais 20%; após o terceiro crítico causado na rodada, aumenta o dano crítico em mais 50%"
  },
  RelicConfig_13935_Name = {
    Text = "<WhiteQuality:Bênção Festiva>"
  },
  RelicConfig_13935_StoryDesc = {
    Text = "Deveria trazer bênçãos aos amantes"
  },
  RelicConfig_13936_BattleDesc = {
    Text = "É um item de missão semanal sem efeito 3"
  },
  RelicConfig_13936_Desc = {
    Text = "É um item de missão semanal sem efeito 3"
  },
  RelicConfig_13936_Name = {
    Text = "Desafio Diário Substituto 3"
  },
  RelicConfig_13937_BattleDesc = {
    Text = "É um item de missão semanal sem efeito 2"
  },
  RelicConfig_13937_Desc = {
    Text = "É um item de missão semanal sem efeito 2"
  },
  RelicConfig_13937_Name = {
    Text = "Desafio Diário Substituto 2"
  },
  RelicConfig_13938_BattleDesc = {
    Text = "É um item de missão semanal sem efeito 1"
  },
  RelicConfig_13938_Desc = {
    Text = "É um item de missão semanal sem efeito 1"
  },
  RelicConfig_13938_Name = {
    Text = "Desafio Diário Substituto 1"
  },
  RelicConfig_13939_BattleDesc = {
    Text = "No início da rodada 3, aumente a taxa crítica nesta batalha em 15%, e adicione 1 <DerivativeCardKeywords_39:\"Ecos do Passado\"> à sua mão."
  },
  RelicConfig_13939_Desc = {
    Text = "No início da rodada 3, aumente a taxa crítica nesta batalha em 15%, e adicione 1 <DerivativeCardKeywords_39:\"Ecos do Passado\"> à sua mão."
  },
  RelicConfig_13939_Name = {
    Text = "<OrangeQuality:Tributo do Passado>"
  },
  RelicConfig_13939_StoryDesc = {
    Text = "Uma vez oferecido em sacrifício"
  },
  RelicConfig_13940_BattleDesc = {
    Text = "Quando você tem escudo, esta criação fornece [Arg1] pontos de <PowerIconKeywords:força> temporária. Se o escudo for maior que a vida atual, fornece [Arg2] pontos extras de <PowerIconKeywords:força> temporária"
  },
  RelicConfig_13940_Desc = {
    Text = "Quando você tem escudo, esta criação fornece [Arg1] pontos de <PowerIconKeywords:força> temporária. Se o escudo for maior que a vida atual, fornece [Arg2] pontos extras de <PowerIconKeywords:força> temporária"
  },
  RelicConfig_13940_Name = {
    Text = "<WhiteQuality:Leque de Penas de Pomba>"
  },
  RelicConfig_13940_StoryDesc = {
    Text = "Elegante e caro, mas não muito prático"
  },
  RelicConfig_13941_BattleDesc = {
    Text = "\"Strike\" restaura [Arg1] Vida e reduz [Arg1] pilhas de <IntoxicationIconKeywords:Veneno>."
  },
  RelicConfig_13941_Desc = {
    Text = "\"Strike\" restaura [Arg1] Vida e reduz [Arg1] pilhas de <IntoxicationIconKeywords:Veneno>."
  },
  RelicConfig_13941_Name = {
    Text = "<WhiteQuality:Pinça Hemostática>"
  },
  RelicConfig_13941_StoryDesc = {
    Text = "\"Apressa-te, apressa-te! Dá-me isso!\""
  },
  RelicConfig_13942_BattleDesc = {
    Text = "Para cada tentáculo, receberá [Arg1] pontos de escudo ao final do turno; se o tentáculo estiver em postura de mar calmo, esse efeito obterá um adicional de 50% de escudo"
  },
  RelicConfig_13942_Desc = {
    Text = "Para cada tentáculo, receberá [Arg1] pontos de escudo ao final do turno; se o tentáculo estiver em postura de mar calmo, esse efeito obterá um adicional de 50% de escudo"
  },
  RelicConfig_13942_Name = {
    Text = "<WhiteQuality:Apêndice Sem Nome>"
  },
  RelicConfig_13942_StoryDesc = {
    Text = "Cuidado com as mãos"
  },
  RelicConfig_139929_BattleDesc = {
    Text = "No início do turno, Saya ganha [Arg1] de Fúria. Para cada 100 de Fúria consumida pela Fúria Explosiva de Saya, uma \"Habilidade\" gerada aleatoriamente entra em efeito 1 vez adicional."
  },
  RelicConfig_139929_Desc = {
    Text = "No início do turno, Saya ganha [Arg1] de Fúria. Para cada 100 de Fúria consumida pela Fúria Explosiva de Saya, uma \"Habilidade\" gerada aleatoriamente entra em efeito 1 vez adicional."
  },
  RelicConfig_139929_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Saya>"
  },
  RelicConfig_140276_BattleDesc = {
    Text = "<OrangeQuality:Desespero>: No início do turno, para cada 1% de vida máxima perdida, o dano final temporário é aumentado em 5%. Se a resistência à morte foi ativada no turno anterior, esse efeito é dobrado.\n<RedQuality:Supremo>: A vida máxima de todos os inimigos é aumentada em 300%."
  },
  RelicConfig_140276_Desc = {
    Text = "<OrangeQuality:Desespero>: No início do turno, para cada 1% de vida máxima perdida, o dano final temporário é aumentado em 5%. Se a resistência à morte foi ativada no turno anterior, esse efeito é dobrado.\n<RedQuality:Supremo>: A vida máxima de todos os inimigos é aumentada em 300%."
  },
  RelicConfig_140276_Name = {
    Text = "<RedQuality:Pêndulo Dimensional–Duelo>"
  },
  RelicConfig_140277_BattleDesc = {
    Text = "<OrangeQuality:Proliferação>: A cada turno, quando cada Despertado jogar uma \"Habilidade\" pela primeira vez, gera 2 cópias originais temporárias dela. Ao jogar cartas de comando com custo de processamento de 0 ou 1, todos os Despertados obtêm 5 pontos de Fúria.\n<RedQuality:Fortaleza>: Ao jogar cartas com custo de processamento original igual ou superior a 3, todos os inimigos obtêm um escudo equivalente a 20% da vida máxima."
  },
  RelicConfig_140277_Desc = {
    Text = "<OrangeQuality:Proliferação>: A cada turno, quando cada Despertado jogar uma \"Habilidade\" pela primeira vez, gera 2 cópias originais temporárias dela. Ao jogar cartas de comando com custo de processamento de 0 ou 1, todos os Despertados obtêm 5 pontos de Fúria.\n<RedQuality:Fortaleza>: Ao jogar cartas com custo de processamento original igual ou superior a 3, todos os inimigos obtêm um escudo equivalente a 20% da vida máxima."
  },
  RelicConfig_140277_Name = {
    Text = "<RedQuality:Pêndulo Dimensional–Alerta>"
  },
  RelicConfig_140278_BattleDesc = {
    Text = "<OrangeQuality:Regeneração>: Escudo e efeitos de recuperação obtidos são aumentados em 25%. Ao recuperar vida ou obter escudo, a cada 1% de vida máxima em recuperação ou escudo causado, obtém 10% de intensificação de dano temporária.\n<RedQuality:Sussurro>: A cada turno, obtém uma redução de força equivalente a 10% da vida máxima."
  },
  RelicConfig_140278_Desc = {
    Text = "<OrangeQuality:Regeneração>: Escudo e efeitos de recuperação obtidos são aumentados em 25%. Ao recuperar vida ou obter escudo, a cada 1% de vida máxima em recuperação ou escudo causado, obtém 10% de intensificação de dano temporária.\n<RedQuality:Sussurro>: A cada turno, obtém uma redução de força equivalente a 10% da vida máxima."
  },
  RelicConfig_140278_Name = {
    Text = "<RedQuality:Pêndulo Dimensional–Susto>"
  },
  RelicConfig_140279_BattleDesc = {
    Text = "<OrangeQuality:Aurora>: A Fúria base de todos os Despertados é reduzida em 30 pontos. O dano final da primeira Explosão de Fúria de cada turno é aumentado em 200%, e a recuperação de escudo e vida é aumentada em 100%. Após liberar 5 Explosões de Fúria, escolha 1 Despertado para despertar e redefina os efeitos de amplificação da Explosão de Fúria.\n<RedQuality:Exaustão>: A energia base da Chave de Prata é aumentada em 200%."
  },
  RelicConfig_140279_Desc = {
    Text = "<OrangeQuality:Aurora>: A Fúria base de todos os Despertados é reduzida em 30 pontos. O dano final da primeira Explosão de Fúria de cada turno é aumentado em 200%, e a recuperação de escudo e vida é aumentada em 100%. Após liberar 5 Explosões de Fúria, escolha 1 Despertado para despertar e redefina os efeitos de amplificação da Explosão de Fúria.\n<RedQuality:Exaustão>: A energia base da Chave de Prata é aumentada em 200%."
  },
  RelicConfig_140279_Name = {
    Text = "<RedQuality:Pêndulo Dimensional–Vudu>"
  },
  RelicConfig_140280_BattleDesc = {
    Text = "<OrangeQuality:Despertar>: Após a primeira Explosão de Fúria de cada turno, redefine o tempo de recarga da Explosão de Fúria desse Despertado, concede 50 de Fúria e gera cópias temporárias de todas as \"Habilidades\" com custo de processamento 0.\n<RedQuality:Selo>: Após a primeira Explosão de Fúria de cada turno, sela os outros Despertados."
  },
  RelicConfig_140280_Desc = {
    Text = "<OrangeQuality:Despertar>: Após a primeira Explosão de Fúria de cada turno, redefine o tempo de recarga da Explosão de Fúria desse Despertado, concede 50 de Fúria e gera cópias temporárias de todas as \"Habilidades\" com custo de processamento 0.\n<RedQuality:Selo>: Após a primeira Explosão de Fúria de cada turno, sela os outros Despertados."
  },
  RelicConfig_140280_Name = {
    Text = "<RedQuality:Pêndulo Dimensional–Duelo>"
  },
  RelicConfig_140281_BattleDesc = {
    Text = "<OrangeQuality:Eco>: No início do turno, compra as 3 cartas de comando com maior custo de processamento do deck de compra. A primeira carta de comando jogada a cada turno tem efeito aplicado 2 vezes.\n<RedQuality:Atordoamento>: Após jogar uma carta de comando, descarta todas as outras cartas de comando com custo de processamento igual ou superior ao dela."
  },
  RelicConfig_140281_Desc = {
    Text = "<OrangeQuality:Eco>: No início do turno, compra as 3 cartas de comando com maior custo de processamento do deck de compra. A primeira carta de comando jogada a cada turno tem efeito aplicado 2 vezes.\n<RedQuality:Atordoamento>: Após jogar uma carta de comando, descarta todas as outras cartas de comando com custo de processamento igual ou superior ao dela."
  },
  RelicConfig_140281_Name = {
    Text = "<RedQuality:Pêndulo Dimensional–Confusão>"
  },
  RelicConfig_140282_BattleDesc = {
    Text = "<OrangeQuality:Grande Poder>: A <PowerIconKeywords:Força> causada por todos os Despertados é aumentada em 50%. A cada 1 instância de dano causado, obtém [Arg2] pontos de <PowerIconKeywords:Força> temporária.\n<RedQuality:Intangível>: No início do combate, todos os inimigos obtêm 50 camadas de <ParcloseIconKeywords:Barreira>."
  },
  RelicConfig_140282_Desc = {
    Text = "<OrangeQuality:Grande Poder>: A <PowerIconKeywords:Força> causada por todos os Despertados é aumentada em 50%. A cada 1 instância de dano causado, obtém [Arg2] pontos de <PowerIconKeywords:Força> temporária.\n<RedQuality:Intangível>: No início do combate, todos os inimigos obtêm 50 camadas de <ParcloseIconKeywords:Barreira>."
  },
  RelicConfig_140282_Name = {
    Text = "<RedQuality:Pêndulo Dimensional–Espreita>"
  },
  RelicConfig_140840_BattleDesc = {
    Text = "Limite de cartas na mão +1. No início da batalha, gera 1 carta \"<DerivativeCardKeywords_148:驭魇>\" e coloca na mão. Ao Disparar o \"Golpe Básico\" do Corpo Desperto, o Poder de cálculo de \"<DerivativeCardKeywords_148:驭魇>\" -1 e causa [Arg1] pontos de Corrosão a todos os inimigos. Ao Disparar a \"Defesa Básica\" do Corpo Desperto, obtém [Arg2] pontos de Força e o Efeito de Dano Final e a Força da próxima vez que Disparar \"<DerivativeCardKeywords_148:驭魇>\" aumentam em [Arg3]%."
  },
  RelicConfig_140840_Desc = {
    Text = "Limite de cartas na mão +1. No início da batalha, gera 1 carta \"<DerivativeCardKeywords_148:驭魇>\" e coloca na mão. Ao Disparar o \"Golpe Básico\" do Corpo Desperto, o Poder de cálculo de \"<DerivativeCardKeywords_148:驭魇>\" -1 e causa [Arg1] pontos de Corrosão a todos os inimigos. Ao Disparar a \"Defesa Básica\" do Corpo Desperto, obtém [Arg2] pontos de Força e o Efeito de Dano Final e a Força da próxima vez que Disparar \"<DerivativeCardKeywords_148:驭魇>\" aumentam em [Arg3]%."
  },
  RelicConfig_140840_Name = {
    Text = "O Esforço Inútil"
  },
  RelicConfig_140840_StoryDesc = {
    Text = "O ser inútil teme a mudança, teme que as coisas fujam ao seu controle e, em seu nível mais profundo, teme a perda em histeria.\n Ele sopra O Assobio repetidamente, querendo controlar tudo através dele, mas não consegue reter coisa alguma."
  },
  RelicConfig_143665_BattleDesc = {
    Text = "Pontos ganha [Arg1] Fúria no início do turno. Quando coletado, gera 3 cartas \"Gaunt\" Persistentes no início da próxima batalha. Pontos ganha 3 Fúria após Disparar um \"Gaunt\"."
  },
  RelicConfig_143665_Desc = {
    Text = "Pontos ganha [Arg1] Fúria no início do turno. Quando coletado, gera 3 cartas \"Gaunt\" Persistentes no início da próxima batalha. Pontos ganha 3 Fúria após Disparar um \"Gaunt\"."
  },
  RelicConfig_143665_Name = {
    Text = "<OrangeQuality:Imagem Dimensional: Pontos>"
  },
  RelicConfig_145438_BattleDesc = {
    Text = "No início do turno, ganha [Arg1] Fúria. Depois de usar \"Separação de Mundus\", realiza a Caçada: \"Lâmina Abissal\" no início do próximo turno: Causa Dano igual a 400% da Força de ataque de Lotan: Cetarchon a todos os inimigos. Esta Caçada se beneficia do Aumento de dano que \"Separação de Mundus\" obtém por meio de \"Lâmina afiada: Queda da Baleia\" e é contada como um \"golpear\"."
  },
  RelicConfig_145438_Desc = {
    Text = "No início do turno, ganha [Arg1] Fúria. Depois de usar \"Separação de Mundus\", realiza a Caçada: \"Lâmina Abissal\" no início do próximo turno: Causa Dano igual a 400% da Força de ataque de Lotan: Cetarchon a todos os inimigos. Esta Caçada se beneficia do Aumento de dano que \"Separação de Mundus\" obtém por meio de \"Lâmina afiada: Queda da Baleia\" e é contada como um \"golpear\"."
  },
  RelicConfig_145438_Name = {
    Text = "<OrangeQuality:Imagem Dimensional: Lotan: Cetarchon>"
  },
  RelicConfig_146128_BattleDesc = {
    Text = "Limite de cartas na mão +1. No início do combate ou após Disparar \"<DerivativeCardKeywords_157:Osso da Espada>\", coloque 1 carta \"<DerivativeCardKeywords_155:Osso da Loucura>\" na mão e Embaralhe 1 carta \"<DerivativeCardKeywords_156:Osso da Ferida>\" no Mazo de robo. Se \"<DerivativeCardKeywords_155:Osso da Loucura>\" e \"<DerivativeCardKeywords_156:Osso da Ferida>\" forem Disparadas no mesmo turno, funda essas duas cartas em \"<DerivativeCardKeywords_157:Osso da Espada>\" e coloque-a na mão."
  },
  RelicConfig_146128_Desc = {
    Text = "Limite de cartas na mão +1. No início do combate ou após Disparar \"<DerivativeCardKeywords_157:Osso da Espada>\", coloque 1 carta \"<DerivativeCardKeywords_155:Osso da Loucura>\" na mão e Embaralhe 1 carta \"<DerivativeCardKeywords_156:Osso da Ferida>\" no Mazo de robo. Se \"<DerivativeCardKeywords_155:Osso da Loucura>\" e \"<DerivativeCardKeywords_156:Osso da Ferida>\" forem Disparadas no mesmo turno, funda essas duas cartas em \"<DerivativeCardKeywords_157:Osso da Espada>\" e coloque-a na mão."
  },
  RelicConfig_146128_Name = {
    Text = "Armadura de Osso de Baleia"
  },
  RelicConfig_146128_StoryDesc = {
    Text = "Os ossos do Leviatã protegem os Seus escolhidos, tornando-os invencíveis e imortais."
  },
  RelicConfig_147547_BattleDesc = {
    Text = "Ao iniciar a rodada, Casiah ganha [Arg1] pontos de loucura. Para cada carta comprada, Casiah ganha [Arg2] pontos de loucura. Quando Casiah libera a exaltação, todos os inimigos perdem [Arg3] pontos de poder."
  },
  RelicConfig_147547_Desc = {
    Text = "Ao iniciar a rodada, Casiah ganha [Arg1] pontos de loucura. Para cada carta comprada, Casiah ganha [Arg2] pontos de loucura. Quando Casiah libera a exaltação, todos os inimigos perdem [Arg3] pontos de poder."
  },
  RelicConfig_147547_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Cassia>"
  },
  RelicConfig_147665_BattleDesc = {
    Text = "Limite de capacidade de cálculo e número de cartas compradas por turno +1. No início do turno, <FaxianKeywords:descobre> 3 \"<Caroboo_Tips:Pistoles de Marie>\" e escolhe uma. Apenas 1 delas é verdadeira: se escolher a verdadeira, obtém seu efeito positivo e dispersa 1 Estado negativo aleatório próprio; se escolher a falsa, sofre seu efeito negativo e faz com que na próxima <FaxianKeywords:descoberta> as opções verdadeiras sejam +1 e os efeitos dobrados, sendo redefinido após escolher a verdadeira."
  },
  RelicConfig_147665_Desc = {
    Text = "Limite de capacidade de cálculo e número de cartas compradas por turno +1. No início do turno, <FaxianKeywords:descobre> 3 \"<Caroboo_Tips:Pistoles de Marie>\" e escolhe uma. Apenas 1 delas é verdadeira: se escolher a verdadeira, obtém seu efeito positivo e dispersa 1 Estado negativo aleatório próprio; se escolher a falsa, sofre seu efeito negativo e faz com que na próxima <FaxianKeywords:descoberta> as opções verdadeiras sejam +1 e os efeitos dobrados, sendo redefinido após escolher a verdadeira."
  },
  RelicConfig_147665_Name = {
    Text = "Pistoles de Marie"
  },
  RelicConfig_147665_StoryDesc = {
    Text = "Doce e precioso... ou será que não?"
  },
  RelicConfig_148525_BattleDesc = {
    Text = "No início do turno, Ogier Ligado pelo Juramento ganha [Arg1] de Fúria, e \"Surge Sombrio\" não reduz mais o número de compras de carta."
  },
  RelicConfig_148525_Desc = {
    Text = "No início do turno, Ogier Ligado pelo Juramento ganha [Arg1] de Fúria, e \"Surge Sombrio\" não reduz mais o número de compras de carta."
  },
  RelicConfig_148525_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Juramento Negativo·Ogier>"
  },
  RelicConfig_149665_BattleDesc = {
    Text = "O terreno atual conta como \"Campo de Gelo.\"\nNa Hiperbórea: Após a Fase de Comprar carta, aplique 1 capa de <SlowIconKeywords:Stase> e <RetainIconKeywords:Preservar> às 2 Cartas de comando não congeladas com o maior Consumo de potência de cálculo na mão. Quando qualquer Carta de comando tiver pelo menos 3 capas de <SlowIconKeywords:Stase>, remova sua <SlowIconKeywords:Stase> e <RetainIconKeywords:Preservar> (obtidas nesta batalha), Congele-a e aplique 25 capas de <TempPowerKeywords2:Reforço>."
  },
  RelicConfig_149665_Desc = {
    Text = "O terreno atual conta como \"Campo de Gelo.\"\nNa Hiperbórea: Após a Fase de Comprar carta, aplique 1 capa de <SlowIconKeywords:Stase> e <RetainIconKeywords:Preservar> às 2 Cartas de comando não congeladas com o maior Consumo de potência de cálculo na mão. Quando qualquer Carta de comando tiver pelo menos 3 capas de <SlowIconKeywords:Stase>, remova sua <SlowIconKeywords:Stase> e <RetainIconKeywords:Preservar> (obtidas nesta batalha), Congele-a e aplique 25 capas de <TempPowerKeywords2:Reforço>."
  },
  RelicConfig_149665_Name = {
    Text = "<OrangeQuality:Globo de Cristal>"
  },
  RelicConfig_149665_StoryDesc = {
    Text = "Não traz o frio.\nApenas lembra à terra que o inverno nunca foi embora."
  },
  RelicConfig_20164_BattleDesc = {
    Text = "A cada dano, ganha [Arg1] de <PowerIconKeywords:força> temporária, até 5 camadas. Ao atingir o máximo, ganha [Arg1] de força"
  },
  RelicConfig_20164_Desc = {
    Text = "A cada dano, ganha [Arg1] de <PowerIconKeywords:força> temporária, até 5 camadas. Ao atingir o máximo, ganha [Arg1] de força"
  },
  RelicConfig_20164_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Agitação\">"
  },
  RelicConfig_20165_BattleDesc = {
    Text = "Ao coletar, desperte todos os despertadores. Após jogar <ExaltIconKeywords:despertar>, receba aleatoriamente 2 cartas de comando desse despertador e adicione \"exausto\" e \"ilusão\""
  },
  RelicConfig_20165_Desc = {
    Text = "Ao coletar, desperte todos os despertadores. Após jogar <ExaltIconKeywords:despertar>, receba aleatoriamente 2 cartas de comando desse despertador e adicione \"exausto\" e \"ilusão\""
  },
  RelicConfig_20165_Name = {
    Text = "<OrangeQuality:Seu Oráculo+>"
  },
  RelicConfig_20165_StoryDesc = {
    Text = "Ele disse, não tenha medo"
  },
  RelicConfig_20166_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Maestria em Domínios> aumenta 100. Recoloca a primeira carta jogada a cada turno na sua mão. No início do turno extradimensional, limite de cartas +5 e duplica sua mão"
  },
  RelicConfig_20166_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maestria em Domínios> aumenta 100. Recoloca a primeira carta jogada a cada turno do monte de descarte na sua mão. No início do turno ultra, quando o limite de cartas na mão +5 e duplica sua mão, as cartas copiadas recebem <NothingnessIconKeywords:Nada> e <DepleteIconKeywords:Consumo>."
  },
  RelicConfig_20166_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Roubo de Sonho\">"
  },
  RelicConfig_20167_BattleDesc = {
    Text = "No final do turno, se houver aritmética restante, na próxima rodada, compre 2 cartas extras; se houver cartas restantes, na próxima rodada, ganhe 2 pontos extras de aritmética"
  },
  RelicConfig_20167_Desc = {
    Text = "No final do turno, se houver aritmética restante, na próxima rodada, compre 2 cartas extras; se houver cartas restantes, na próxima rodada, ganhe 2 pontos extras de aritmética"
  },
  RelicConfig_20167_Name = {
    Text = "<OrangeQuality:Roda do Sol e Lua+>"
  },
  RelicConfig_20167_StoryDesc = {
    Text = "Adivinhe, é preto ou branco?"
  },
  RelicConfig_20168_BattleDesc = {
    Text = "Limite de tentáculo +2. Após liberar a explosão da loucura, o dano de tentáculo aumenta em [Arg1]. Se você soltar 3 explosões de loucura em uma rodada, todos os tentáculos serão ativados uma vez"
  },
  RelicConfig_20168_Desc = {
    Text = "Limite de tentáculo +2. Após liberar a explosão da loucura, o dano de tentáculo aumenta em [Arg1]. Se você soltar 3 explosões de loucura em uma rodada, todos os tentáculos serão ativados uma vez"
  },
  RelicConfig_20168_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Soneca Leve\">"
  },
  RelicConfig_20169_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Domínio de área> +100. Cada carta Disparada, <EmbryoFusionIconKeywords:Fusão de embriões> +10; quando a Vida estiver abaixo de 25%, o aumento se torna 20%. Este efeito pode ser acionado no máximo 10 vezes por turno."
  },
  RelicConfig_20169_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Domínio de área> +100. Cada carta Disparada, <EmbryoFusionIconKeywords:Fusão de embriões> +10; quando a Vida estiver abaixo de 25%, o aumento se torna 20%. Este efeito pode ser acionado no máximo 10 vezes por turno."
  },
  RelicConfig_20169_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Impulso\">"
  },
  RelicConfig_20170_BattleDesc = {
    Text = "No início da batalha, todos os Despertadores ganham 50 pontos de Aliemus. Puxe 2 <DerivativeCardKeywords_1:\"Eco Eclipsado\"> para sua mão."
  },
  RelicConfig_20170_Desc = {
    Text = "No início da batalha, todos os Despertadores ganham 50 pontos de Aliemus. Puxe 2 <DerivativeCardKeywords_1:\"Eco Eclipsado\"> para sua mão."
  },
  RelicConfig_20170_Name = {
    Text = "<OrangeQuality:Equipamento de Comunicação+>"
  },
  RelicConfig_20170_StoryDesc = {
    Text = "Esperando ou temendo o momento em que o sino tocar"
  },
  RelicConfig_20171_BattleDesc = {
    Text = "Ao coletar, receba aleatoriamente 1 relíquia de prata, 1 relíquia de ouro e 1 relíquia amaldiçoada"
  },
  RelicConfig_20171_Desc = {
    Text = "Ao coletar, receba aleatoriamente 1 relíquia de prata, 1 relíquia de ouro e 1 relíquia amaldiçoada"
  },
  RelicConfig_20171_Name = {
    Text = "<OrangeQuality:Visão Reversa+>"
  },
  RelicConfig_20171_StoryDesc = {
    Text = "Na era estranha, as flores eram os primeiros espectadores da humanidade.\nNão se mova, elas preferem exposições silenciosas"
  },
  RelicConfig_20172_BattleDesc = {
    Text = "Após jogar 3 cartas de comando em uma rodada, ganha 1 <DerivativeCardKeywords_4:\"inspiração\">, ao atingir 6 cartas, ganhe mais 1 <DerivativeCardKeywords_4:\"inspiração\">, e ao atingir 10, no início da próxima rodada, pode escolher 2 cartas do baralho para adicionar à mão"
  },
  RelicConfig_20172_Desc = {
    Text = "Após jogar 3 cartas de comando em uma rodada, ganha 1 <DerivativeCardKeywords_4:\"inspiração\">, ao atingir 6 cartas, ganhe mais 1 <DerivativeCardKeywords_4:\"inspiração\">, e ao atingir 10, no início da próxima rodada, pode escolher 2 cartas do baralho para adicionar à mão"
  },
  RelicConfig_20172_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Eco\">"
  },
  RelicConfig_20173_BattleDesc = {
    Text = "Dano aumentado em 50% contra inimigos em estado negativo, e o executor ganha 100 de loucura ao matar um inimigo"
  },
  RelicConfig_20173_Desc = {
    Text = "Dano aumentado em 50% contra inimigos em estado negativo, e o executor ganha 100 de loucura ao matar um inimigo"
  },
  RelicConfig_20173_Name = {
    Text = "<OrangeQuality:Cetro do Sacerdote+>"
  },
  RelicConfig_20173_StoryDesc = {
    Text = "Devoção não permitida"
  },
  RelicConfig_20174_BattleDesc = {
    Text = "Ao coletar, Dano potencializado da equipe x150%. No início do turno, causa [Arg1] de <FixedDamage:Dano Puro> a um inimigo aleatório. Para cada Ordem de chave usada nesta batalha, aumenta o Dano causado em [Arg2]. Este bônus de Dano usufrui do bônus de Dano potencializado da equipe."
  },
  RelicConfig_20174_Desc = {
    Text = "Ao coletar, Dano potencializado da equipe x150%. No início do turno, causa [Arg1] de <FixedDamage:Dano Puro> a um inimigo aleatório. Para cada Ordem de chave usada nesta batalha, aumenta o Dano causado em [Arg2]. Este bônus de Dano usufrui do bônus de Dano potencializado da equipe."
  },
  RelicConfig_20174_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Perdido\">"
  },
  RelicConfig_20175_BattleDesc = {
    Text = "O efeito de <WeaknessIconKeywords:fraqueza> causado aumenta em 8%, o efeito de <VulnerabilityIconKeywords:vulnerável> aumenta em 25%. Ao aplicar <WeaknessIconKeywords:fraqueza> ou <VulnerabilityIconKeywords:vulnerável>, roube temporariamente [Arg1] de <PowerIconKeywords:poder> do alvo"
  },
  RelicConfig_20175_Desc = {
    Text = "O efeito de <WeaknessIconKeywords:fraqueza> causado aumenta em 8%, o efeito de <VulnerabilityIconKeywords:vulnerável> aumenta em 25%. Ao aplicar <WeaknessIconKeywords:fraqueza> ou <VulnerabilityIconKeywords:vulnerável>, roube temporariamente [Arg1] de <PowerIconKeywords:poder> do alvo"
  },
  RelicConfig_20175_Name = {
    Text = "<OrangeQuality:Foto Desbotada+>"
  },
  RelicConfig_20175_StoryDesc = {
    Text = "Fotos borradas carregam memórias vagas, ou talvez seja a falha da memória que desbota as fotos."
  },
  RelicConfig_20176_BattleDesc = {
    Text = "Ao iniciar a rodada, ganhe 2 aritmética para cada inimigo presente. Ao matar um inimigo com dano ativo, cause <BleedingIconKeywords:sangrando> equivalente ao dobro do excesso de dano a outros inimigos"
  },
  RelicConfig_20176_Desc = {
    Text = "Ao iniciar a rodada, ganhe 2 aritmética para cada inimigo presente. Ao matar um inimigo com dano ativo, cause <BleedingIconKeywords:sangrando> equivalente ao dobro do excesso de dano a outros inimigos"
  },
  RelicConfig_20176_Name = {
    Text = "<OrangeQuality:Canto do Povo+>"
  },
  RelicConfig_20176_StoryDesc = {
    Text = "Feito para torturar seus ouvidos"
  },
  RelicConfig_20177_BattleDesc = {
    Text = "Ao ser coletado, a resistência à morte se dobra. Após causar dano, também aplicará um <BleedingIconKeywords:sangrando> equivalente a 50% do dano ao alvo. Cada vez que a resistência à morte é ativada, o sangramento de todos os inimigos será ativado imediatamente uma vez"
  },
  RelicConfig_20177_Desc = {
    Text = "Ao ser coletado, a resistência à morte se dobra. Após causar dano, também aplicará um <BleedingIconKeywords:sangrando> equivalente a 50% do dano ao alvo. Cada vez que a resistência à morte é ativada, o sangramento de todos os inimigos será ativado imediatamente uma vez"
  },
  RelicConfig_20177_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Revival\">"
  },
  RelicConfig_20178_BattleDesc = {
    Text = "A cada dano ativo, ganha 3 de loucura e aplica [Arg1] camadas de <IntoxicationIconKeywords:veneno> no alvo. Após 25 ativações na batalha, aplica veneno em todos os inimigos"
  },
  RelicConfig_20178_Desc = {
    Text = "A cada dano ativo, ganha 3 de loucura e aplica [Arg1] camadas de <IntoxicationIconKeywords:veneno> no alvo. Após 25 ativações na batalha, aplica veneno em todos os inimigos"
  },
  RelicConfig_20178_Name = {
    Text = "<OrangeQuality:Máquina de Costura empoeirada+>"
  },
  RelicConfig_20178_StoryDesc = {
    Text = "Uma mãe carinhosa, remendando as feridas do coração"
  },
  RelicConfig_21906_BattleDesc = {
    Text = "\"Ataque\" ganha 3 Aritméticas e descarta 1 carta aleatória; \"Defesa\" compra 3 cartas e perde 1 Aritmética."
  },
  RelicConfig_21906_Desc = {
    Text = "\"Ataque\" ganha 3 Aritméticas e descarta 1 carta aleatória; \"Defesa\" compra 3 cartas e perde 1 Aritmética."
  },
  RelicConfig_21906_Name = {
    Text = "<RedQuality:Disco da Felicidade+>"
  },
  RelicConfig_21906_StoryDesc = {
    Text = "Gravou o disco da última apresentação do famoso violinista.\nDesde então, ele pode trazer fogo"
  },
  RelicConfig_23688_BattleDesc = {
    Text = "A cada vez que ativar a devorar, ganhe 30 <EmbryoFusionIconKeywords: fusão de embrião> e [Arg1] pontos <PowerIconKeywords:poder>. Se ativar pela 2ª vez em um turno, ganhe 1 ponto de poder e compre 1 carta; se ativar pela 3ª vez em um turno, ganhe 2 pontos de poder e compre 2 cartas"
  },
  RelicConfig_23688_Desc = {
    Text = "A cada vez que ativar a devorar, ganhe 30 <EmbryoFusionIconKeywords: fusão de embrião> e [Arg1] pontos <PowerIconKeywords:poder>. Se ativar pela 2ª vez em um turno, ganhe 1 ponto de poder e compre 1 carta; se ativar pela 3ª vez em um turno, ganhe 2 pontos de poder e compre 2 cartas"
  },
  RelicConfig_23688_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Reverberação\">"
  },
  RelicConfig_23689_BattleDesc = {
    Text = "Após a coleta, todos os corpos despertos ganham 30 pontos de loucura. A cada liberação de Fúria Explosiva, aumenta 1 ponto de contagem. Após liberar a ordem de chave, ganhe [Arg1] pontos de precaução temporária, [Arg2] pontos de <PowerIconKeywords:força> temporária e todos os corpos despertos ganham 6 pontos de loucura, consumindo toda a contagem, cada ponto de contagem toma efeito 1 vez adicional."
  },
  RelicConfig_23689_Desc = {
    Text = "Após coletar, todos os corpos despertos ganham 30 pontos de fúria. A cada liberação de explosão de fúria, aumenta 1 ponto de contagem. Após liberar a ordem de chave, ganhe [Arg1] pontos de precaução temporária, [Arg2] pontos de <PowerIconKeywords:força> temporários e todos os corpos despertos ganham 6 pontos de fúria, consumindo toda a contagem, cada ponto de contagem tem efeito adicional 1 vez."
  },
  RelicConfig_23689_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Carga\">"
  },
  RelicConfig_23690_BattleDesc = {
    Text = "Para cada 1 ponto de poder de cálculo adicional ou carta adicional comprada, roube [Arg1] pontos de <PowerIconKeywords:força> de todos os inimigos, ganhe 4% de Taxa de Crítico Temporária, e os efeitos em batalhas de Elite ou Líder são dobrados. Após o início do Turno Ultra, ganhe [Arg2] pontos de <PowerIconKeywords:força>, e o Dano Crítico aumenta em 15%."
  },
  RelicConfig_23690_Desc = {
    Text = "Para cada 1 ponto de poder ou 1 carta extra que você ganha, roube [Arg1] pontos de <PowerIconKeywords:força> de todos os inimigos, ganhando 4% de Taxa de Crítico Temporária, e os efeitos de Elite ou Batalha do Líder são dobrados. Após o início do Turno Ultra, ganhe [Arg2] pontos de <PowerIconKeywords:força> e Dano Crítico +15%."
  },
  RelicConfig_23690_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Fissura\">"
  },
  RelicConfig_23691_BattleDesc = {
    Text = "Para cada 5 danos causados, recupere [Arg1] de vida. Para cada vida perdida, dano de tentáculo +[Arg2], se perder mais de [Arg3] de vida, ative todos os tentáculos 1 vez"
  },
  RelicConfig_23691_Desc = {
    Text = "A cada 5 pontos de dano causados, restaure [Arg1] pontos de vida. A cada 1 ponto de vida perdido, o dano de tentáculo aumenta em +[Arg2]; se perder mais de 10% da saúde máxima, todos os tentáculos ativam uma vez"
  },
  RelicConfig_23691_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Surge da Maré\">"
  },
  RelicConfig_35135_BattleDesc = {
    Text = "Para cada dano causado, ganhe [Arg1] de <PowerIconKeywords:força> temporária e [Arg2] de dano temporário de tentáculo, até 12 ativações por turno. Se causar 4 danos em 1 turno, aplique 1 camada de vulnerável a todos os inimigos e ganhe [Arg3] de escudo; se causar 8 danos, aplique 1 camada de fraqueza a todos os inimigos e recupere [Arg3] de vida."
  },
  RelicConfig_35135_Desc = {
    Text = "Para cada dano causado, ganhe [Arg1] de <PowerIconKeywords:força> temporária e [Arg2] de dano temporário de tentáculo, até 12 ativações por turno. Se causar 4 danos em um turno, aplique 1 camada de vulnerável a todos os inimigos e ganhe [Arg3] de escudo; se causar 8 danos, aplique 1 camada de fraqueza a todos os inimigos e recupere [Arg3] de vida."
  },
  RelicConfig_35135_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Fascínio\">"
  },
  RelicConfig_35136_BattleDesc = {
    Text = "\"Dano de Ataque\" e \"escudo de Defesa\" aumentam em 30%. Se você jogar 4 ou mais cartas de \"Ataque\" e \"Defesa\" em um turno, compre 2 cartas e ganhe 1 Aritmética no início do próximo turno."
  },
  RelicConfig_35136_Desc = {
    Text = "\"Dano de Ataque\" e \"escudo de Defesa\" aumentam em 30%. Se você jogar 4 ou mais cartas de \"Ataque\" e \"Defesa\" em um turno, compre 2 cartas e ganhe 1 Aritmética no início do próximo turno."
  },
  RelicConfig_35136_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Obstinação\">"
  },
  RelicConfig_35137_BattleDesc = {
    Text = "Sempre que jogar 1 carta, ganhe [Arg1] pontos temporários de <PowerIconKeywords: poder> e recupere [Arg2] pontos de vida; após causar dano ativo, remova [Arg2] pontos de <PowerIconKeywords: poder> adquiridos dessa criação. O despertador ganha 30 pontos de loucura ao eliminar um inimigo"
  },
  RelicConfig_35137_Desc = {
    Text = "Sempre que jogar 1 carta, ganhe [Arg1] pontos temporários de <PowerIconKeywords: poder> e recupere [Arg2] pontos de vida; após causar dano ativo, remova [Arg2] pontos de <PowerIconKeywords: poder> adquiridos dessa criação. O despertador ganha 30 pontos de loucura ao eliminar um inimigo"
  },
  RelicConfig_35137_Name = {
    Text = "<OrangeQuality:Pêndulo Crono\"Acumulação\">"
  },
  RelicConfig_35138_BattleDesc = {
    Text = "Após liberar a exaltação, aplique [Arg1] pontos de veneno a um inimigo aleatório. Para cada carta de comando jogada, ganhe [Arg2] pontos de ataque temporário. A cada 4 turnos, cause dano equivalente ao total das camadas de veneno dos inimigos e camadas de ataque"
  },
  RelicConfig_35138_Desc = {
    Text = "Após liberar a exaltação, aplique [Arg1] pontos de veneno a um inimigo aleatório. Para cada carta de comando jogada, ganhe [Arg2] pontos de ataque temporário. A cada 4 turnos, cause dano equivalente ao total das camadas de veneno dos inimigos e camadas de ataque"
  },
  RelicConfig_35138_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Espalhar\">"
  },
  RelicConfig_35139_BattleDesc = {
    Text = "Ao pegar, a força de dano da equipe aumenta em 30%. O quarto ataque causará um crítico e os danos críticos aumentam em 50%, se esse dano resultar em um abate, ganhe 5 pontos de sigilo negro"
  },
  RelicConfig_35139_Desc = {
    Text = "Ao pegar, a força de dano da equipe aumenta em 30%. O quarto ataque causará um crítico e os danos críticos aumentam em 50%, se esse dano resultar em um abate, ganhe 5 pontos de sigilo negro"
  },
  RelicConfig_35139_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Término\">"
  },
  RelicConfig_36823_BattleDesc = {
    Text = "Após liberar a exaltação, compre 1 cartão. Para cada cartão descartado, todos os despertadores ganham 3 de aliemus, limitado a 15 por turno"
  },
  RelicConfig_36823_Desc = {
    Text = "Após liberar a exaltação, compre 1 cartão. Para cada cartão descartado, todos os despertadores ganham 3 de aliemus, limitado a 15 por turno"
  },
  RelicConfig_36823_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Vindo e Indo\">"
  },
  RelicConfig_36824_BattleDesc = {
    Text = "Cada vez que consumir aritmética, compre 1 carta, ativa no máximo 5 vezes por turno. Cada vez que o baralho for resetado, receba 2 pontos de aritmética"
  },
  RelicConfig_36824_Desc = {
    Text = "Cada vez que consumir aritmética, compre 1 carta, ativa no máximo 5 vezes por turno. Cada vez que o baralho for resetado, receba 2 pontos de aritmética"
  },
  RelicConfig_36824_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Insônia\">"
  },
  RelicConfig_39302_BattleDesc = {
    Text = "Embaralhe 1 <DerivativeCardKeywords_4:\"Inspiração\"> na pilha de compra a cada 4 acertos, até 3 vezes por turno. Após um Exaltar, jogue e exaure todas as <DerivativeCardKeywords_4:\"Inspiração\"> na pilha de compra."
  },
  RelicConfig_39302_Desc = {
    Text = "Embaralhe 1 <DerivativeCardKeywords_4:\"Inspiração\"> na pilha de compra a cada 4 acertos, até 3 vezes por turno. Após um Exaltar, jogue e exaure todas as <DerivativeCardKeywords_4:\"Inspiração\"> na pilha de compra."
  },
  RelicConfig_39302_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Sonho Perdido\">"
  },
  RelicConfig_39303_BattleDesc = {
    Text = "Quando o poder de cálculo atual for ímpar, considera-se que você possui [Arg2] pontos de precaução temporária adicionais. Quando o poder de cálculo atual for par, considera-se que você possui [Arg1] pontos de <PowerIconKeywords:força> temporária adicionais e [Arg3] pontos de dano de tentáculo temporário. Para cada criação de ouro que você possui, o efeito dessa criação aumenta em 50%, e para cada criatura amaldiçoada que você possui, aumenta em 80%."
  },
  RelicConfig_39303_Desc = {
    Text = "Quando o poder de cálculo atual for ímpar, considera-se que você possui [Arg2] pontos de precaução temporária adicionais. Quando o poder de cálculo atual for par, considera-se que você possui [Arg1] pontos temporários de <PowerIconKeywords:força> e [Arg3] pontos temporários de dano de tentáculo. Para cada criação de ouro que você possui, o efeito dessa criação aumenta em 50%, e para cada criatura amaldiçoada que você possui, aumenta em 80%."
  },
  RelicConfig_39303_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Despertar do Sonho\">"
  },
  RelicConfig_44192_BattleDesc = {
    Text = "No início de cada rodada, todos os despertadores ganham 20 loucura. Ao coletar, a saúde máxima diminui em 50%"
  },
  RelicConfig_44192_Desc = {
    Text = "No início de cada rodada, todos os despertadores ganham 20 loucura. Ao coletar, a saúde máxima diminui em 50%"
  },
  RelicConfig_44192_Name = {
    Text = "<RedQuality:Culpa: Visão do Pesadelo>"
  },
  RelicConfig_44192_StoryDesc = {
    Text = "Sono profundo é desejo, que devora tudo sem você perceber"
  },
  RelicConfig_44300_BattleDesc = {
    Text = "No início de cada rodada, todos os despertadores ganham 25 loucura. Ao coletar, a saúde máxima se torna 3 vezes"
  },
  RelicConfig_44300_Desc = {
    Text = "No início de cada rodada, todos os despertadores ganham 25 loucura. Ao coletar, a saúde máxima se torna 3 vezes"
  },
  RelicConfig_44300_Name = {
    Text = "<OrangeQuality:Abençoado: Aparência do Pesadelo>"
  },
  RelicConfig_44300_StoryDesc = {
    Text = "Sem medo, sem hesitação. Isso é apenas um sonho passageiro, a luz do Pai ainda brilha sobre você"
  },
  RelicConfig_44592_BattleDesc = {
    Text = "Ao final da batalha, ganha 100 selos negros e 2 cartas de sintoma"
  },
  RelicConfig_44592_Desc = {
    Text = "Ao final da batalha, ganha 100 selos negros e 2 cartas de sintoma"
  },
  RelicConfig_44592_Name = {
    Text = "<RedQuality:Culpa: Impressão de Jade>"
  },
  RelicConfig_44592_StoryDesc = {
    Text = "Os pecados antigos estão gravados aqui"
  },
  RelicConfig_44593_BattleDesc = {
    Text = "Ao pegar, transforme-se em 1 relicário de culpa aleatório, diferente de si mesma, ganhando 75 de sigilo negro"
  },
  RelicConfig_44593_Desc = {
    Text = "Ao pegar, transforme-se em 1 relicário de culpa aleatório, diferente de si mesma, ganhando 75 de sigilo negro"
  },
  RelicConfig_44593_Name = {
    Text = "<RedQuality:Culpa: Estela Amaldiçoada>"
  },
  RelicConfig_44593_StoryDesc = {
    Text = "Ouça, alguém está chamando lá dentro"
  },
  RelicConfig_44594_BattleDesc = {
    Text = "A cada 2 turnos, dobra o Dano Ativo e de tentáculo que todos os inimigos recebem naquele turno. Porém, após liberar Fúria Explosiva nesse turno, sela todos os Corpos Despertos por 1 turno e torna você Vulnerável."
  },
  RelicConfig_44594_Desc = {
    Text = "A cada 2 turnos, dobra o Dano Ativo e de tentáculo que todos os inimigos recebem naquele turno. Porém, após liberar Fúria Explosiva nesse turno, sela todos os Corpos Despertos por 1 turno e torna você Vulnerável."
  },
  RelicConfig_44594_Name = {
    Text = "<RedQuality:Culpa: Cadáver do Caminho>"
  },
  RelicConfig_44594_StoryDesc = {
    Text = [[
Uma parte sagrada.
Separada do corpo, foi corrompida pelo pecado]]
  },
  RelicConfig_44597_BattleDesc = {
    Text = "A cada vez que causar dano ativo, aplique [Arg1] camadas de <BleedingIconKeywords:sangrando> a si mesmo e [Arg2] camadas de <BleedingIconKeywords:sangrando> ao alvo do dano"
  },
  RelicConfig_44597_Desc = {
    Text = "A cada vez que causar dano ativo, aplique [Arg1] camadas de <BleedingIconKeywords:sangrando> a si mesmo e [Arg2] camadas de <BleedingIconKeywords:sangrando> ao alvo do dano"
  },
  RelicConfig_44597_Name = {
    Text = "<RedQuality:Culpa: Consciência do Enxame>"
  },
  RelicConfig_44597_StoryDesc = {
    Text = "Entrelaçar, simbiose, aglomeração; medo, desconhecido, controle"
  },
  RelicConfig_44598_BattleDesc = {
    Text = "Após liberar a exaltação, perca 12% da vida atual, roube [Arg1] pontos de <PowerIconKeywords:poder> temporários de todos os inimigos; se houver apenas 1 inimigo, roube [Arg2] pontos adicionais de <PowerIconKeywords:poder> temporários"
  },
  RelicConfig_44598_Desc = {
    Text = "Após liberar a exaltação, perca 12% da vida atual, roube [Arg1] pontos de <PowerIconKeywords:poder> temporários de todos os inimigos; se houver apenas 1 inimigo, roube [Arg2] pontos adicionais de <PowerIconKeywords:poder> temporários"
  },
  RelicConfig_44598_Name = {
    Text = "<RedQuality:Culpa: Pássaro do Ritual do Destino>"
  },
  RelicConfig_44598_StoryDesc = {
    Text = "Criaturas miseráveis mortas pela ganância, emitindo gritos estridentes de seus peitos murchos"
  },
  RelicConfig_44603_BattleDesc = {
    Text = "Limite de cartas na mão aumenta em 5, puxe 6 cartas no início da batalha. No final do turno, descarte todas as cartas de sintoma e estado na mão, mantendo as outras cartas, mas o número de cartas puxadas por turno diminui em 2"
  },
  RelicConfig_44603_Desc = {
    Text = "Limite de cartas na mão aumenta em 5, puxe 6 cartas no início da batalha. No final do turno, descarte todas as cartas de sintoma e estado na mão, mantendo as outras cartas, mas o número de cartas puxadas por turno diminui em 2"
  },
  RelicConfig_44603_Name = {
    Text = "<RedQuality:Culpa: Marca da Consciência>"
  },
  RelicConfig_44603_StoryDesc = {
    Text = "O ganancioso vê os outros como objetos, tirando prazer do sofrimento alheio"
  },
  RelicConfig_44608_BattleDesc = {
    Text = "Após pegar, perde permanentemente [Arg1] de <PowerIconKeywords:força>. Cada vez que causa dano, recupera [Arg2] de vida, até 6 vezes por turno"
  },
  RelicConfig_44608_Desc = {
    Text = "Após pegar, perde permanentemente [Arg1] de <PowerIconKeywords:força>. Cada vez que causa dano, recupera [Arg2] de vida, até 6 vezes por turno"
  },
  RelicConfig_44608_Name = {
    Text = "<RedQuality:Culpa: Beijo da Lampreia>"
  },
  RelicConfig_44608_StoryDesc = {
    Text = "Seu beijo te fará sucumbir — claro, pode ser você mesmo que sucumba"
  },
  RelicConfig_44609_BattleDesc = {
    Text = "A saúde máxima aumenta em 3. A cada vez que o baralho for resetado, adicione 2 <DerivativeCardKeywords_9:\"Tropeço\"> ao baralho de puxar"
  },
  RelicConfig_44609_Desc = {
    Text = "A saúde máxima aumenta em 3. A cada vez que o baralho for resetado, adicione 2 <DerivativeCardKeywords_9:\"Tropeço\"> ao baralho de puxar"
  },
  RelicConfig_44609_Name = {
    Text = "<RedQuality:Culpa: Vela Negra>"
  },
  RelicConfig_44609_StoryDesc = {
    Text = "Queime a razão, caia na loucura"
  },
  RelicConfig_44610_BattleDesc = {
    Text = "Taxa crítica e dano crítico aumentam em 50%, e ao início de cada rodada, <FragileIconKeywords:frágil> aplica-se a si mesmo por 1 rodada"
  },
  RelicConfig_44610_Desc = {
    Text = "Taxa crítica e dano crítico aumentam em 50%, e ao início de cada rodada, <FragileIconKeywords:frágil> aplica-se a si mesmo por 1 rodada"
  },
  RelicConfig_44610_Name = {
    Text = "<RedQuality:Culpa: Garra Estranha>"
  },
  RelicConfig_44610_StoryDesc = {
    Text = "Garras distorcidas pelo desejo"
  },
  RelicConfig_44654_BattleDesc = {
    Text = "A saúde máxima aumenta em 4. A cada vez que o baralho for resetado, adicione 4 <DerivativeCardKeywords_4:\"Inspiração\"> ao baralho de puxar"
  },
  RelicConfig_44654_Desc = {
    Text = "A saúde máxima aumenta em 4. A cada vez que o baralho for resetado, adicione 4 <DerivativeCardKeywords_4:\"Inspiração\"> ao baralho de puxar"
  },
  RelicConfig_44654_Name = {
    Text = "<OrangeQuality:Abençoado: Vela Negra>"
  },
  RelicConfig_44654_StoryDesc = {
    Text = "Queime o desejo, obtenha redenção"
  },
  RelicConfig_44656_BattleDesc = {
    Text = "Limite de relíquias +[Arg1], +1 nas renovações em \"marca d\". Após o término da batalha, obtém 125 o sigilo negro, e ao coletar, pode escolher até 6 cartas de sintoma para remover"
  },
  RelicConfig_44656_Desc = {
    Text = "Limite de relíquias +[Arg1], +1 nas renovações em \"marca d\". Após o término da batalha, obtém 125 o sigilo negro, e ao coletar, pode escolher até 6 cartas de sintoma para remover"
  },
  RelicConfig_44656_Name = {
    Text = "<OrangeQuality:Abençoado: Impressão de Jade>"
  },
  RelicConfig_44656_StoryDesc = {
    Text = "A redenção do Pai Deus apagou a dor"
  },
  RelicConfig_44658_BattleDesc = {
    Text = "Após liberar a exaltação, ganhe [Arg1] pontos de poder temporários e roube [Arg1] pontos de <PowerIconKeywords:poder> temporários de todos os inimigos; se houver apenas 1 inimigo, roube [Arg2] pontos adicionais de <PowerIconKeywords:poder> temporários"
  },
  RelicConfig_44658_Desc = {
    Text = "Após liberar a exaltação, ganhe [Arg1] pontos de poder temporários e roube [Arg1] pontos de <PowerIconKeywords:poder> temporários de todos os inimigos; se houver apenas 1 inimigo, roube [Arg2] pontos adicionais de <PowerIconKeywords:poder> temporários"
  },
  RelicConfig_44658_Name = {
    Text = "<OrangeQuality:Abençoado: Ritual do Azar>"
  },
  RelicConfig_44658_StoryDesc = {
    Text = "A luz do perdão envolveu os restos gananciosos, o pássaro morto cantou sua última canção"
  },
  RelicConfig_44659_BattleDesc = {
    Text = "A cada vez que causar dano ativo, recupere [Arg1] vida e aplique [Arg2] camadas de <BleedingIconKeywords:sangrando> ao alvo do dano"
  },
  RelicConfig_44659_Desc = {
    Text = "A cada vez que causar dano ativo, recupere [Arg1] vida e aplique [Arg2] camadas de <BleedingIconKeywords:sangrando> ao alvo do dano"
  },
  RelicConfig_44659_Name = {
    Text = "<OrangeQuality:Abençoado: Consciência do Enxame>"
  },
  RelicConfig_44659_StoryDesc = {
    Text = "Entrelaçar, simbiose, aglomeração; união, coexistência, abrigo"
  },
  RelicConfig_44660_BattleDesc = {
    Text = "Limite de cartas na mão aumenta em 5, preencha a mão até o limite no início da batalha. No início do turno, puxe 1 carta extra, e no final do turno, descarte todas as cartas de sintoma e estado na mão, mantendo as outras cartas"
  },
  RelicConfig_44660_Desc = {
    Text = "Limite de cartas na mão aumenta em 5, preencha a mão até o limite no início da batalha. No início do turno, puxe 1 carta extra, e no final do turno, descarte todas as cartas de sintoma e estado na mão, mantendo as outras cartas"
  },
  RelicConfig_44660_Name = {
    Text = "<OrangeQuality:Abençoado: Inscrição da Consciência>"
  },
  RelicConfig_44660_StoryDesc = {
    Text = "O ganancioso grava seus erros no coração e busca redenção por seu passado"
  },
  RelicConfig_44662_BattleDesc = {
    Text = "A cada 2 turnos, dobra o Dano Ativo e de tentáculo que todos os inimigos recebem naquele turno. Para cada Fúria Explosiva usada nesse turno, dissipa aleatoriamente 1 efeito negativo."
  },
  RelicConfig_44662_Desc = {
    Text = "A cada 2 turnos, dobra o Dano Ativo e de tentáculo que todos os inimigos recebem naquele turno. Para cada Fúria Explosiva usada nesse turno, dissipa aleatoriamente 1 efeito negativo."
  },
  RelicConfig_44662_Name = {
    Text = "<OrangeQuality:Abençoado: Ossos do Caminho>"
  },
  RelicConfig_44662_StoryDesc = {
    Text = [[
Uma parte sagrada.
Mesmo separada do corpo, suas pegadas se espalharam pelos mares]]
  },
  RelicConfig_44663_BattleDesc = {
    Text = "Taxa crítica aumenta em 50%, e o dano crítico aumenta em 100%"
  },
  RelicConfig_44663_Desc = {
    Text = "Taxa crítica aumenta em 50%, e o dano crítico aumenta em 100%"
  },
  RelicConfig_44663_Name = {
    Text = "<OrangeQuality:Abençoado: Garra Estranha>"
  },
  RelicConfig_44663_StoryDesc = {
    Text = "Todos os desejos foram abandonados"
  },
  RelicConfig_44664_BattleDesc = {
    Text = "Após pegar, ganha permanentemente [Arg1] de <PowerIconKeywords:força>. Cada vez que causa dano, recupera [Arg2] de vida, até 6 vezes por turno"
  },
  RelicConfig_44664_Desc = {
    Text = "Após pegar, ganha permanentemente [Arg1] de <PowerIconKeywords:força>. Cada vez que causa dano, recupera [Arg2] de vida, até 6 vezes por turno"
  },
  RelicConfig_44664_Name = {
    Text = "<OrangeQuality:Abençoado: Beijo da Lampreia>"
  },
  RelicConfig_44664_StoryDesc = {
    Text = "Recuse este beijo de perdição, o abraço do Pai é mais quente que qualquer escuridão"
  },
  RelicConfig_47444_BattleDesc = {
    Text = "\"Ataque\" e \"Defesa\" ganham um adicional de 50 Keyflare. Cada vez que você jogar uma carta com um custo de Aritmética de 2 ou mais, compre uma carta com custo de Aritmética de 1 e reduza seu custo para 0, até 3 vezes por turno."
  },
  RelicConfig_47444_Desc = {
    Text = "\"Ataque\" e \"Defesa\" ganham um adicional de 50 Keyflare. Cada vez que você jogar uma carta com um custo de Aritmética de 2 ou mais, compre uma carta com custo de Aritmética de 1 e reduza seu custo para 0, até 3 vezes por turno."
  },
  RelicConfig_47444_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Almas Gêmeas\">"
  },
  RelicConfig_50338_BattleDesc = {
    Text = "No início da batalha, embaralhe todas as <ExaltIconKeywords: gnose> dos despertadores no baralho. Após o início do 6º turno, táias fornecerá suporte ao combate a cada turno"
  },
  RelicConfig_50338_Desc = {
    Text = "No início da batalha, embaralhe todas as <ExaltIconKeywords: gnose> dos despertadores no baralho. Após o início do 6º turno, táias fornecerá suporte ao combate a cada turno"
  },
  RelicConfig_50338_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Fascinação\">"
  },
  RelicConfig_50338_StoryDesc = {
    Text = "Ele disse, não tenha medo"
  },
  RelicConfig_50385_BattleDesc = {
    Text = "Ao pegar, escolha um cartão, transformando seu custo de aritmética permanentemente em 1"
  },
  RelicConfig_50385_Desc = {
    Text = "Ao pegar, escolha um cartão, transformando seu custo de aritmética permanentemente em 1"
  },
  RelicConfig_50385_Name = {
    Text = "<WhiteQuality:☆pupilos exauridos☆>"
  },
  RelicConfig_50385_StoryDesc = {
    Text = "Sem a água mais preciosa do deserto, seus olhos secaram"
  },
  RelicConfig_50487_BattleDesc = {
    Text = "No início do primeiro turno da batalha, adicione <DerivativeCardKeywords_46:\"Príons\"> à sua mão; no terceiro turno, adicione <DerivativeCardKeywords_49:\"Golpe Insaciável\"> à sua mão; após ativar a resistência à morte, adicione <DerivativeCardKeywords_52:\"Casulo de Ressurreição\"> à sua mão."
  },
  RelicConfig_50487_Desc = {
    Text = "No início do primeiro turno da batalha, adicione <DerivativeCardKeywords_46:\"Príons\"> à sua mão; no terceiro turno, adicione <DerivativeCardKeywords_49:\"Golpe Insaciável\"> à sua mão; após ativar a resistência à morte, adicione <DerivativeCardKeywords_52:\"Casulo de Ressurreição\"> à sua mão."
  },
  RelicConfig_50487_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Abençoar\">"
  },
  RelicConfig_50488_BattleDesc = {
    Text = "No final do turno: o desperto com menos loucura ganha 35 pontos de loucura. Se a vida restante for ≥50%, ganhe [Arg1] pontos de <PowerIconKeywords:força>. Se a vida restante for <50%, recupere [Arg2] pontos de vida"
  },
  RelicConfig_50488_Desc = {
    Text = "No final do turno: o desperto com menos loucura ganha 35 pontos de loucura. Se a vida atual for ≥50%, ganhe [Arg1] pontos de <PowerIconKeywords:força>. Se a vida atual for <50%, recupere [Arg2] pontos de vida"
  },
  RelicConfig_50488_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Equilibrar\">"
  },
  RelicConfig_50489_BattleDesc = {
    Text = "Taxa crítica e dano crítico aumentados em 100%. Cada vez que causar 1 dano, a taxa crítica e o dano crítico de todos os despertadores diminuem em 10%, até um máximo de 50%. Cada vez que causar 1 dano, o veneno e a retaliação causados neste turno aumentam em 10%, podendo aumentar até 50%"
  },
  RelicConfig_50489_Desc = {
    Text = "Taxa crítica e dano crítico aumentados em 100%. Cada vez que causar 1 dano/dano de tentáculo neste turno: a taxa crítica e dano crítico de todos os despertadores diminuem em 10%, até um máximo de 50%. O veneno e a retaliação causados aumentam em 10%, podendo aumentar até 50%"
  },
  RelicConfig_50489_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Surge de Fluxo\">"
  },
  RelicConfig_51686_BattleDesc = {
    Text = "Cada vez que uma carta de comando pertencente a um Despertador diferente da anterior for jogada, o Despertador correspondente ganha 3 pontos de Fúria e acumula 1 camada de \"Vitalidade\". Ao acumular 10 camadas, todas as \"Vitalidades\" são limpas, e uma carta de comando aleatória com custo de potência de cálculo reduzido em 1 e com \"Consumo\" é colocada na mão de cada Despertador, podendo ser ativada no máximo 1 vez por turno."
  },
  RelicConfig_51686_Desc = {
    Text = "Cada vez que uma carta de comando pertencente a um Despertar diferente da anterior for disparada, o Despertar correspondente ganha 3 pontos de Fúria e acumula 1 camada de \"Vitalidade\". Ao acumular 10 camadas, todas as \"Vitalidades\" são zeradas, e uma carta de comando aleatória com custo de potência de cálculo reduzido em 1 e a habilidade \"Consumo\" é colocada na mão de cada Despertar, podendo ser acionada no máximo 1 vez por turno."
  },
  RelicConfig_51686_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"evolução\">"
  },
  RelicConfig_51687_BattleDesc = {
    Text = "Após jogar uma carta de comando que não seja de \"ataque\" ou \"defesa\", se esta carta não for uma carta derivada, o despertador correspondente ganha 15 pontos de loucura, sendo possível acionar no máximo 5 vezes por turno. Na primeira ativação de cada turno, a carta jogada retorna à sua mão."
  },
  RelicConfig_51687_Desc = {
    Text = "Após Disparar uma Carta de comando que não seja \"golpear\" ou \"Defesa\", se a carta não for uma carta derivada, o Corpo Desperto correspondente ganha 15 de Fúria, sendo possível acionar no máximo 5 vezes por turno. Na primeira ativação de cada turno, a carta Disparada também retorna à sua mão."
  },
  RelicConfig_51687_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Projeção\">"
  },
  RelicConfig_51688_BattleDesc = {
    Text = "Ao coletar, adicione \"manter\" a todas as cartas de comando. No final do turno, se o número de cartas na mão for maior ou igual a 5, o custo de poder de 3 cartas na mão será reduzido em 1, caso contrário, compre 3 cartas"
  },
  RelicConfig_51688_Desc = {
    Text = "Ao coletar, adicione \"manter\" a todas as cartas de comando. No final do turno, se o número de cartas na mão for maior ou igual a 5, o custo de poder de 3 cartas na mão será reduzido em 1, caso contrário, compre 3 cartas"
  },
  RelicConfig_51688_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Cama Quente\">"
  },
  RelicConfig_51689_BattleDesc = {
    Text = "No início da batalha, coloque 3 cartas de sintomas aleatórias no deck. No início do turno, compre 1 carta. A cada vez que você disparar 1 carta de sintomas, ganhe 2 pontos de poder de cálculo. A cada vez que você descartar 1 carta de sintomas, todos os corpos despertos ganham 5 pontos de fúria, podendo ser acionado no máximo 5 vezes por turno."
  },
  RelicConfig_51689_Desc = {
    Text = "No início da batalha, coloque 3 cartas de sintomas aleatórias no baralho. No início da rodada, compre 1 carta. Para cada carta de sintomas jogada, ganhe 2 pontos de poder de cálculo. Para cada carta de sintomas descartada, todos os corpos despertos ganham 5 pontos de fúria, podendo ser acionado no máximo 5 vezes por turno."
  },
  RelicConfig_51689_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Praga\">"
  },
  RelicConfig_55847_BattleDesc = {
    Text = "Conjunto de 7 Itens Padrão"
  },
  RelicConfig_55847_Desc = {
    Text = "Conjunto de 7 Itens Padrão"
  },
  RelicConfig_55847_Name = {
    Text = "<RedQuality:☆Criação de Batalha Simulada☆>"
  },
  RelicConfig_55847_StoryDesc = {
    Text = "Na era estranha, as flores eram os primeiros espectadores da humanidade.\nNão se mova, elas preferem exposições silenciosas"
  },
  RelicConfig_55874_BattleDesc = {
    Text = "Ganhe [Arg1] camadas de \"Tinta\" após a batalha. Quando \"Tinta\" atinge 2 camadas, consuma-a para colocar aleatoriamente 1 cartão \"Imagem\" no baralho."
  },
  RelicConfig_55874_Desc = {
    Text = "Ganhe [Arg1] camadas de \"Tinta\" após a batalha. Quando \"Tinta\" atinge 2 camadas, consuma-a para colocar aleatoriamente 1 cartão \"Imagem\" no baralho."
  },
  RelicConfig_55874_Name = {
    Text = "<OrangeQuality: a pena e a tinta de Horla>"
  },
  RelicConfig_55874_StoryDesc = {
    Text = "Os pecados antigos estão gravados aqui"
  },
  RelicConfig_56355_BattleDesc = {
    Text = "Limite de cartas +2, no início do turno, compre 1 carta. Após a batalha, ganhe [Arg1] camada de \"Tinta\", ao atingir 2 camadas, consuma e escolha 1 \"Imagem\" para colocar no baralho"
  },
  RelicConfig_56355_Desc = {
    Text = "Limite de cartas +2, no início do turno, compre 1 carta. Após a batalha, ganhe [Arg1] camada de \"Tinta\", ao atingir 2 camadas, consuma e escolha 1 \"Imagem\" para colocar no baralho"
  },
  RelicConfig_56355_Name = {
    Text = "<OrangeQuality: a pena e a tinta de Horla>"
  },
  RelicConfig_56355_StoryDesc = {
    Text = "Os pecados antigos estão gravados aqui"
  },
  RelicConfig_56356_BattleDesc = {
    Text = "Ganhe [Arg1] camadas de \"Tinta\" após a batalha. Quando \"Tinta\" atinge 2 camadas, consuma-a para escolher 1 cartão \"Imagem\" para colocar no baralho."
  },
  RelicConfig_56356_Desc = {
    Text = "Ganhe [Arg1] camadas de \"Tinta\" após a batalha. Quando \"Tinta\" atinge 2 camadas, consuma-a para escolher 1 cartão \"Imagem\" para colocar no baralho."
  },
  RelicConfig_56356_Name = {
    Text = "<OrangeQuality: a pena e a tinta de Horla>"
  },
  RelicConfig_56356_StoryDesc = {
    Text = "Os pecados antigos estão gravados aqui"
  },
  RelicConfig_57667_BattleDesc = {
    Text = "Começa com 2 camadas de Poder da Mãe Divina; após o terceiro turno, no início de cada turno, pode escolher consumir o Poder da Mãe Divina para obter efeitos diferentes ou recuperar o Poder da Mãe Divina. Se receber dano letal, ressuscita e consome todas as camadas de Poder da Mãe Divina, restaurando 10% da vida por camada, podendo ser ativado apenas 1 vez."
  },
  RelicConfig_57667_Desc = {
    Text = "Começa com 2 camadas de Poder da Mãe Divina; após o terceiro turno, ao início de cada turno, pode escolher consumir o Poder da Mãe para obter efeitos diferentes ou recuperar o Poder da Mãe. Se receber dano letal, será ressuscitado e consumirá todas as camadas de Poder da Mãe, restaurando 10% da vida por camada, podendo ter efeito apenas 1 vez."
  },
  RelicConfig_57667_Name = {
    Text = "<OrangeQuality:Proteção da Mãe Divina>"
  },
  RelicConfig_57732_BattleDesc = {
    Text = "Todos os despertadores aumentam a taxa crítica em 15%. O resultado final dos efeitos aleatórios de Ryker e dados aumenta em 1"
  },
  RelicConfig_57732_Desc = {
    Text = "Todos os despertadores aumentam a taxa crítica em 15%. O resultado final dos efeitos aleatórios de Ryker e dados aumenta em 1"
  },
  RelicConfig_57732_Name = {
    Text = "<OrangeQuality:Capa da Sorte de Luxo>"
  },
  RelicConfig_57732_StoryDesc = {
    Text = "Os pecados antigos estão gravados aqui"
  },
  RelicConfig_57733_BattleDesc = {
    Text = "No início do turno e ao ativar o efeito aleatório de Ryker ou dos dados, ganhe 100 pontos de s-energia e 4% de dano crítico, com um máximo de 50% de dano crítico, removido ao fim da batalha"
  },
  RelicConfig_57733_Desc = {
    Text = "No início do turno e ao ativar o efeito aleatório de Ryker ou dos dados, ganhe 100 pontos de s-energia e 4% de dano crítico, com um máximo de 50% de dano crítico, removido ao fim da batalha"
  },
  RelicConfig_57733_Name = {
    Text = "<OrangeQuality:Botão Grande e Delicado>"
  },
  RelicConfig_57733_StoryDesc = {
    Text = "Os pecados antigos estão gravados aqui"
  },
  RelicConfig_57734_BattleDesc = {
    Text = "Sempre que liberar uma Chave, coloque uma \"Dado de Remédio Brilhante\" na mão"
  },
  RelicConfig_57734_Desc = {
    Text = "Sempre que liberar uma Chave, coloque uma \"Dado de Remédio Brilhante\" na mão"
  },
  RelicConfig_57734_Name = {
    Text = "<OrangeQuality:Dado Brilhante>"
  },
  RelicConfig_57734_StoryDesc = {
    Text = "Os pecados antigos estão gravados aqui"
  },
  RelicConfig_57735_BattleDesc = {
    Text = "No início do turno e ao ativar o efeito aleatório de Ryker ou dos dados, ganhe 50 pontos de s-energia e 2% de dano crítico, com um máximo de 30% de dano crítico, removido ao fim da batalha"
  },
  RelicConfig_57735_Desc = {
    Text = "No início do turno e ao ativar o efeito aleatório de Ryker ou dos dados, ganhe 50 pontos de s-energia e 2% de dano crítico, com um máximo de 30% de dano crítico, removido ao fim da batalha"
  },
  RelicConfig_57735_Name = {
    Text = "<OrangeQuality:Botão Grande>"
  },
  RelicConfig_57735_StoryDesc = {
    Text = "Os pecados antigos estão gravados aqui"
  },
  RelicConfig_57736_BattleDesc = {
    Text = "Sempre que liberar uma Chave, coloque uma \"Dado de Remédio\" na mão"
  },
  RelicConfig_57736_Desc = {
    Text = "Sempre que liberar uma Chave, coloque uma \"Dado de Remédio\" na mão"
  },
  RelicConfig_57736_Name = {
    Text = "<OrangeQuality:Dado da Sorte>"
  },
  RelicConfig_57736_StoryDesc = {
    Text = "Os pecados antigos estão gravados aqui"
  },
  RelicConfig_57737_BattleDesc = {
    Text = "Todos os despertadores aumentam a taxa crítica em 10%. Todos os efeitos aleatórios de Ryker e dados não terão um valor mínimo"
  },
  RelicConfig_57737_Desc = {
    Text = "Todos os despertadores aumentam a taxa crítica em 10%. Todos os efeitos aleatórios de Ryker e dados não terão um valor mínimo"
  },
  RelicConfig_57737_Name = {
    Text = "<OrangeQuality:Casaco da Sorte>"
  },
  RelicConfig_57737_StoryDesc = {
    Text = "Os pecados antigos estão gravados aqui"
  },
  RelicConfig_57791_BattleDesc = {
    Text = "Limite de relíquias +1. Nos primeiros cinco turnos após o início da batalha, ao início de cada turno, uma relíquia será obtida, selecionando entre \"broche de rubi, ágata retorcida, sinal de socorro, ritual de má sorte, pêndulo crono·fascínio\""
  },
  RelicConfig_57791_Desc = {
    Text = "Limite de relíquias +1. Nos primeiros cinco turnos após o início da batalha, ao início de cada turno, uma relíquia será obtida, selecionando entre \"broche de rubi, ágata retorcida, sinal de socorro, ritual de má sorte, pêndulo crono·fascínio\""
  },
  RelicConfig_57791_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Tesouro Afundado\">"
  },
  RelicConfig_57791_StoryDesc = {
    Text = "Diz a lenda que Lemúria afundou nesta região do mar. Quem consegue resistir à tentação de descobrir os segredos dos tesouros submersos?"
  },
  RelicConfig_57792_BattleDesc = {
    Text = "Limite de relíquias +1. Nos primeiros cinco turnos após o início da batalha, ao início de cada turno, uma relíquia será obtida, selecionando entre \"tridente, carimbo de terra, registros arcanos, marca de consciência, pêndulo crono·acúmulo\""
  },
  RelicConfig_57792_Desc = {
    Text = "Limite de relíquias +1. Nos primeiros cinco turnos após o início da batalha, ao início de cada turno, uma relíquia será obtida, selecionando entre \"tridente, carimbo de terra, registros arcanos, marca de consciência, pêndulo crono·acúmulo\""
  },
  RelicConfig_57792_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Tesouro Afundado\">"
  },
  RelicConfig_57792_StoryDesc = {
    Text = "Dizem que Lemúria caiu neste mar. Quem consegue resistir à tentação de explorar os segredos dos tesouros submersos?"
  },
  RelicConfig_57793_BattleDesc = {
    Text = "Limite de relíquias +1. Nos primeiros cinco turnos após o início da batalha, ao início de cada turno, uma relíquia será obtida, selecionando entre \"mandíbula a laser, pomada suspeita, máquina de costura empoeirada, língua de espécie alienígena, pêndulo crono·fluxo\""
  },
  RelicConfig_57793_Desc = {
    Text = "Limite de relíquias +1. Nos primeiros cinco turnos após o início da batalha, ao início de cada turno, uma relíquia será obtida, selecionando entre \"mandíbula a laser, pomada suspeita, máquina de costura empoeirada, língua de espécie alienígena, pêndulo crono·fluxo\""
  },
  RelicConfig_57793_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Tesouro Afundado\">"
  },
  RelicConfig_57793_StoryDesc = {
    Text = "Diz a lenda que Lemúria caiu nesta região do mar. Quem consegue resistir à tentação de explorar os segredos do tesouro submerso?"
  },
  RelicConfig_57794_BattleDesc = {
    Text = "Limite de relíquia +1. Nos primeiros cinco turnos após o início da batalha, ao começar cada turno, ganha uma relíquia, entre \"colete de urtiga, relógio do falecido, fragmento do antigo sábio, membro da caridade, pêndulo crono·espalhar\""
  },
  RelicConfig_57794_Desc = {
    Text = "Limite de relíquia +1. Nos primeiros cinco turnos após o início da batalha, ao começar cada turno, ganha uma relíquia, entre \"colete de urtiga, relógio do falecido, fragmento do antigo sábio, membro da caridade, pêndulo crono·espalhar\""
  },
  RelicConfig_57794_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Tesouro Afundado\">"
  },
  RelicConfig_57794_StoryDesc = {
    Text = "Diz a lenda que Lemúria afundou nesta área do mar. Quem pode resistir a explorar os segredos dos tesouros submersos?"
  },
  RelicConfig_57795_BattleDesc = {
    Text = "Limite de relíquias +1. Nos primeiros cinco turnos após o início da batalha, ao início de cada turno, uma relíquia será obtida, selecionando entre \"espada folheada, pinça hemostática, quebra-cabeça antigo, consciência de enxame, pêndulo crono·gêmeos\""
  },
  RelicConfig_57795_Desc = {
    Text = "Limite de relíquias +1. Nos primeiros cinco turnos após o início da batalha, ao início de cada turno, uma relíquia será obtida, selecionando entre \"espada folheada, pinça hemostática, quebra-cabeça antigo, consciência de enxame, pêndulo crono·gêmeos\""
  },
  RelicConfig_57795_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Tesouro Afundado\">"
  },
  RelicConfig_57795_StoryDesc = {
    Text = "Diz a lenda que Lemúria caiu nesta área do mar. Quem pode resistir à curiosidade de explorar os segredos dos tesouros submersos?"
  },
  RelicConfig_57796_BattleDesc = {
    Text = "Limite de relíquias +1. Nos primeiros cinco turnos após o início da batalha, ao início de cada turno, uma relíquia será obtida, selecionando entre \"cronômetro de precisão, abotoaduras de louro, véu do deus sem nome, aparição de pesadelo, pêndulo crono·equilíbrio\""
  },
  RelicConfig_57796_Desc = {
    Text = "Limite de relíquias +1. Nos primeiros cinco turnos após o início da batalha, ao início de cada turno, uma relíquia será obtida, selecionando entre \"cronômetro de precisão, abotoaduras de louro, véu do deus sem nome, aparição de pesadelo, pêndulo crono·equilíbrio\""
  },
  RelicConfig_57796_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Tesouro Afundado\">"
  },
  RelicConfig_57796_StoryDesc = {
    Text = "Diz a lenda que Lemúria afundou nesta região do mar. Quem consegue resistir a explorar os segredos do tesouro do navio afundado?"
  },
  RelicConfig_57797_BattleDesc = {
    Text = "Limite de relíquia +1. Nos primeiros cinco turnos após o início da batalha, ao começar cada turno, ganha uma relíquia, entre \"carteira nova, emblema de mythag, vinho das estrelas, beijo da lampreia, pêndulo crono·olho\""
  },
  RelicConfig_57797_Desc = {
    Text = "Limite de relíquia +1. Nos primeiros cinco turnos após o início da batalha, ao começar cada turno, ganha uma relíquia, entre \"carteira nova, emblema de mythag, vinho das estrelas, beijo da lampreia, pêndulo crono·olho\""
  },
  RelicConfig_57797_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Tesouro Afundado\">"
  },
  RelicConfig_57797_StoryDesc = {
    Text = "Diz a lenda que Lemúria afundou nesta região do mar. Quem consegue resistir à tentação de explorar os segredos do tesouro afundado?"
  },
  RelicConfig_58872_BattleDesc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. Nos próximos 5 turnos, ao início de cada turno, obtenha uma relíquia, incluindo \"faca de willows enferrujadas, novo eixo, nossa casa, gancho peculiar, pêndulo crono·cativante\""
  },
  RelicConfig_58872_Desc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. Nos próximos 5 turnos, ao início de cada turno, obtenha uma relíquia, incluindo \"faca de willows enferrujadas, novo eixo, nossa casa, gancho peculiar, pêndulo crono·cativante\""
  },
  RelicConfig_58872_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Tesouro Secreto α\">"
  },
  RelicConfig_58873_BattleDesc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. Nos próximos 5 turnos, ao início de cada turno, obtenha uma relíquia, incluindo \"tinta doce, gramofone mudo, vinho das estrelas, chapéu mágico, pêndulo crono·fluxo\""
  },
  RelicConfig_58873_Desc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. Nos próximos 5 turnos, ao início de cada turno, obtenha uma relíquia, incluindo \"tinta doce, gramofone mudo, vinho das estrelas, chapéu mágico, pêndulo crono·fluxo\""
  },
  RelicConfig_58873_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Tesouro Secreto β\">"
  },
  RelicConfig_59118_BattleDesc = {
    Text = "Após o início do turno, ganhe um \"Dado da Sorte de Ryker\". O número do dado jogado aumenta em 1. No início do turno e após cada lançamento de dado, todos os despertadores ganham 4% de dano crítico, com um máximo de 100%"
  },
  RelicConfig_59118_Desc = {
    Text = "Após o início do turno, ganhe um \"Dado da Sorte de Ryker\". O número do dado jogado aumenta em 1. No início do turno e após cada lançamento de dado, todos os despertadores ganham 4% de dano crítico, com um máximo de 100%"
  },
  RelicConfig_59118_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Presente do Caos\">"
  },
  RelicConfig_59118_StoryDesc = {
    Text = "Os pecados antigos estão gravados aqui"
  },
  RelicConfig_59687_BattleDesc = {
    Text = "Conjunto de 7 Itens Padrão"
  },
  RelicConfig_59687_Desc = {
    Text = "Conjunto de 7 Itens Padrão"
  },
  RelicConfig_59687_Name = {
    Text = "<RedQuality:☆Criação de Batalha Simulada☆>"
  },
  RelicConfig_59687_StoryDesc = {
    Text = "Na era estranha, as flores eram os primeiros espectadores da humanidade.\nNão se mova, elas preferem exposições silenciosas"
  },
  RelicConfig_60723_BattleDesc = {
    Text = "A potência de cálculo máxima aumenta em 1, no início da rodada puxe 1 carta extra, e você receberá 1 \"Sinfonia da Harmonia\". Se 3 cartas de comando forem jogadas com a mesma potência consecutivamente, todos os Corpos Despertos ganham 20 pontos de Fúria, e o contador é reiniciado no início da rodada e após a ativação."
  },
  RelicConfig_60723_Desc = {
    Text = "A potência de cálculo máxima aumenta em 1, no início da rodada, compre 1 carta extra, ganhando 1 \"Sinfonia da Harmonia\". Se 3 cartas de comando forem disparadas com a mesma potência de cálculo consecutivamente, todos os corpos despertos ganham 20 pontos de fúria, e o contador é redefinido no início da rodada e após a ativação."
  },
  RelicConfig_60723_Name = {
    Text = "<OrangeQuality:Batuta do Maestro>"
  },
  RelicConfig_60723_StoryDesc = {
    Text = "Uma fina batuta de maestro, mas possui força maior que uma barra de ferro.\n\n Regendo notas, regendo almas, regendo destinos."
  },
  RelicConfig_60724_BattleDesc = {
    Text = "No início da batalha, ganhe a Oração \"Vulnerável\" e a Oração \"Explosão\" e suas Orações Avançadas, escolha uma Oração em um Cartão."
  },
  RelicConfig_60724_Desc = {
    Text = "No início da batalha, ganhe a Oração \"Vulnerável\" e a Oração \"Explosão\" e suas Orações Avançadas, escolha uma Oração em um Cartão."
  },
  RelicConfig_60724_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Mensagem do Diretor\">"
  },
  RelicConfig_60724_StoryDesc = {
    Text = "As palavras do fundador de Mythag ecoam em seus ouvidos.\n\nQue a chave prateada ilumine seu caminho, guardião de Mythag."
  },
  RelicConfig_60725_BattleDesc = {
    Text = "No início da batalha, ganhe a Oração \"Aliemus\" e a Oração \"Catalisador\" junto com suas Orações Avançadas, e escolha uma Oração em uma carta."
  },
  RelicConfig_60725_Desc = {
    Text = "No início da batalha, ganhe a Oração \"Aliemus\" e a Oração \"Catalisador\" junto com suas Orações Avançadas, e escolha uma Oração em uma carta."
  },
  RelicConfig_60725_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Mensagem do Diretor\">"
  },
  RelicConfig_60725_StoryDesc = {
    Text = "As palavras do fundador de Mythag ecoam em seus ouvidos.\n\nQue a chave prateada ilumine seu caminho, guardião de Mythag."
  },
  RelicConfig_60726_BattleDesc = {
    Text = "No início da batalha, ganhe a Oração \"Fraqueza\" e a Oração \"Cálculo\" juntamente com suas Orações Avançadas, e escolha uma Oração em uma carta."
  },
  RelicConfig_60726_Desc = {
    Text = "No início da batalha, ganhe a Oração \"Fraqueza\" e a Oração \"Cálculo\" juntamente com suas Orações Avançadas, e escolha uma Oração em uma carta."
  },
  RelicConfig_60726_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Mensagem do Diretor\">"
  },
  RelicConfig_60726_StoryDesc = {
    Text = "As palavras do fundador de Mythag ecoam em seus ouvidos.\n\nQue a chave prateada ilumine seu caminho, guardião de Mythag."
  },
  RelicConfig_60727_BattleDesc = {
    Text = "No início da batalha, ganhe a Oração \"Muralha de Ferro\" e a Oração \"Hábil\" e suas Orações Avançadas, e escolha uma Oração em um Cartão."
  },
  RelicConfig_60727_Desc = {
    Text = "No início da batalha, ganhe a Oração \"Muralha de Ferro\" e a Oração \"Hábil\" e suas Orações Avançadas, e escolha uma Oração em um Cartão."
  },
  RelicConfig_60727_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Mensagem do Diretor\">"
  },
  RelicConfig_60727_StoryDesc = {
    Text = "As palavras do fundador de Mythag ecoam em seus ouvidos.\n\nQue a chave prateada ilumine seu caminho, guardião de Mythag."
  },
  RelicConfig_60728_BattleDesc = {
    Text = "No início da batalha, ganhe a Oração \"Nurture\" e a Oração \"Eco\" e suas Orações Avançadas, escolha uma Oração em um cartão."
  },
  RelicConfig_60728_Desc = {
    Text = "No início da batalha, ganhe a Oração \"Nurture\" e a Oração \"Eco\" e suas Orações Avançadas, escolha uma Oração em um cartão."
  },
  RelicConfig_60728_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Mensagem do Diretor\">"
  },
  RelicConfig_60728_StoryDesc = {
    Text = "As palavras do fundador de Mythag ecoam em seus ouvidos.\n\nQue a chave prateada ilumine seu caminho, guardião de Mythag."
  },
  RelicConfig_60729_BattleDesc = {
    Text = "No início da batalha, ganhe a Oração \"Habilidade\" e a Oração \"Inspiração\" junto com suas Orações Avançadas, e escolha uma Oração em um cartão."
  },
  RelicConfig_60729_Desc = {
    Text = "No início da batalha, ganhe a Oração \"Habilidade\" e a Oração \"Inspiração\" junto com suas Orações Avançadas, e escolha uma Oração em um cartão."
  },
  RelicConfig_60729_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Mensagem do Diretor\">"
  },
  RelicConfig_60729_StoryDesc = {
    Text = "As palavras do fundador de Mythag ecoam em seus ouvidos.\n\nQue a chave prateada ilumine seu caminho, guardião de Mythag."
  },
  RelicConfig_60730_BattleDesc = {
    Text = "No início da batalha, ganhe a Oração \"Força Bruta\" e a Oração \"Exaustão\" assim como suas Orações Avançadas, e escolha uma Oração em uma carta."
  },
  RelicConfig_60730_Desc = {
    Text = "No início da batalha, ganhe a Oração \"Força Bruta\" e a Oração \"Exaustão\" assim como suas Orações Avançadas, e escolha uma Oração em uma carta."
  },
  RelicConfig_60730_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Mensagem do Diretor\">"
  },
  RelicConfig_60730_StoryDesc = {
    Text = "As palavras do fundador de Mythag ecoam em seus ouvidos.\n\nQue a chave prateada ilumine seu caminho, guardião de Mythag."
  },
  RelicConfig_60731_BattleDesc = {
    Text = "No início da batalha, ganhe 2 Orações \"Conjunto\" e sua Oração Avançada, e escolha uma Oração em um cartão."
  },
  RelicConfig_60731_Desc = {
    Text = "No início da batalha, ganhe 2 Orações \"Conjunto\" e sua Oração Avançada, e escolha uma Oração em um cartão."
  },
  RelicConfig_60731_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Mensagem do Diretor\">"
  },
  RelicConfig_60731_StoryDesc = {
    Text = "As palavras do fundador de Mythag ecoam em seus ouvidos.\n\nQue a chave prateada ilumine seu caminho, guardião de Mythag."
  },
  RelicConfig_60732_BattleDesc = {
    Text = "No início da batalha, ganhe a Oração \"Cálculo\" e a Oração \"Espelho\" e suas Orações Avançadas, e escolha uma Oração em um cartão."
  },
  RelicConfig_60732_Desc = {
    Text = "No início da batalha, ganhe a Oração \"Cálculo\" e a Oração \"Espelho\" e suas Orações Avançadas, e escolha uma Oração em um cartão."
  },
  RelicConfig_60732_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Mensagem do Diretor\">"
  },
  RelicConfig_60732_StoryDesc = {
    Text = "As palavras do fundador de Mythag ecoam em seus ouvidos.\n\nQue a chave prateada ilumine seu caminho, guardião de Mythag."
  },
  RelicConfig_65376_BattleDesc = {
    Text = "Inicialmente possui [Arg1] membros da expedição. No início da batalha, coloque 5 cartas de <DerivativeCardKeywords_73:Suspeita> no baralho"
  },
  RelicConfig_65376_Desc = {
    Text = "Inicialmente possui [Arg1] membros da Equipe de Pesquisa. No início da batalha, embaralhe 5 <DerivativeCardKeywords_73:Desconfiado> no baralho."
  },
  RelicConfig_65376_Name = {
    Text = "<OrangeQuality:Expedição Científica>"
  },
  RelicConfig_65376_StoryDesc = {
    Text = "As palavras do fundador de Mythag ecoam em seus ouvidos.\n\nQue a chave prateada ilumine seu caminho, guardião de Mythag."
  },
  RelicConfig_65406_BattleDesc = {
    Text = "No início do turno, ganhe [Arg1] <DerivativeCardKeywords_71:\"Brilho Humano Brilhante\">.\n<D05EX_Relic:Todo o seu esforço valeu a pena. Você quase salvou toda a equipe de pesquisa, e os sobreviventes são sinceramente gratos a você.>"
  },
  RelicConfig_65406_Desc = {
    Text = "No início do turno, ganhe [Arg1] <DerivativeCardKeywords_71:\"Brilho Humano Brilhante\">.\n<D05EX_Relic:Todo o seu esforço valeu a pena. Você quase salvou toda a equipe de pesquisa, e os sobreviventes são sinceramente gratos a você.>"
  },
  RelicConfig_65406_Name = {
    Text = "<OrangeQuality:Medalha de Resgate: Platina>"
  },
  RelicConfig_65406_StoryDesc = {
    Text = "Todo o seu esforço valeu a pena, você quase salvou toda a equipe de pesquisa, e os sobreviventes são sinceramente gratos a você"
  },
  RelicConfig_65407_BattleDesc = {
    Text = "No início do turno, ganhe [Arg1] <DerivativeCardKeywords_72:\"Luz da humanidade Brilhante\">.\n<D05EX_Relic:Você criou um milagre incrível, todas as pessoas sobreviveram após a catástrofe. Você é o grande herói no coração das pessoas, e sua lenda pode estar prestes a se espalhar ao redor da montanha nevada.>"
  },
  RelicConfig_65407_Desc = {
    Text = "No início do turno, ganhe [Arg1] <DerivativeCardKeywords_72:\"Luz da humanidade brilhante\">.\n<D05EX_Relic:Você criou um milagre incrível, todos sobreviveram após a calamidade. Você é o grande herói no coração das pessoas, e suas lendas podem começar a circular ao redor da montanha nevada.>"
  },
  RelicConfig_65407_Name = {
    Text = "<OrangeQuality:Medalha de Resgate: Diamante>"
  },
  RelicConfig_65407_StoryDesc = {
    Text = "Você criou um milagre incrível, todos sobreviveram após a calamidade. Você é o grande herói na mente das pessoas, sua lenda pode começar a ser contada ao redor da montanha nevada"
  },
  RelicConfig_65408_BattleDesc = {
    Text = "No início do turno, ganhe [Arg1] <DerivativeCardKeywords_68:\"Brilho Humano Desbotado\">.\n<D05EX_Relic:Para sair da montanha nevada, você escolheu a estratégia de eficiência e viu as pessoas morrerem uma a uma. Os sobreviventes te olham com mais medo do que gratidão.>"
  },
  RelicConfig_65408_Desc = {
    Text = "No início do turno, ganhe [Arg1] <DerivativeCardKeywords_68:\"Brilho Humano Desbotado\">.\n<D05EX_Relic:Para sair da montanha nevada, você escolheu a estratégia de eficiência e viu as pessoas morrerem uma a uma. Os sobreviventes te olham com mais medo do que gratidão.>"
  },
  RelicConfig_65408_Name = {
    Text = "<OrangeQuality:Medalha de Resgate·Bronze>"
  },
  RelicConfig_65408_StoryDesc = {
    Text = "Para sair da montanha nevada, você escolheu uma estratégia de eficiência, vendo as pessoas morrerem uma a uma. Os sobreviventes olham para você com mais medo do que gratidão"
  },
  RelicConfig_65409_BattleDesc = {
    Text = "No início do turno, ganhe [Arg1] <DerivativeCardKeywords_69:\"Brilho Humano Fraco\">.\n<D05EX_Relic:Você pode ter se esforçado, embora metade das pessoas tenha morrido, você salvou a outra metade. Sacrifícios são inevitáveis.>"
  },
  RelicConfig_65409_Desc = {
    Text = "No início do turno, ganhe [Arg1] <DerivativeCardKeywords_69:\"Brilho Humano Fraco\">.\n<D05EX_Relic:Você pode ter se esforçado, embora metade das pessoas tenha morrido, você salvou a outra metade. Sacrifícios são inevitáveis.>"
  },
  RelicConfig_65409_Name = {
    Text = "<OrangeQuality:Medalha de Resgate: Prata>"
  },
  RelicConfig_65409_StoryDesc = {
    Text = "Talvez você tenha se esforçado, e embora metade tenha morrido, você salvou a outra metade. Sacrifícios são inevitáveis"
  },
  RelicConfig_65410_BattleDesc = {
    Text = "No início do turno, ganhe [Arg1] <DerivativeCardKeywords_70:\"Brilho Humano\">.\n<D05EX_Relic:Você salvou a maioria das pessoas, mudando seu destino trágico. Você fez o seu melhor, não fez?>"
  },
  RelicConfig_65410_Desc = {
    Text = "No início do turno, ganhe [Arg1] <DerivativeCardKeywords_70:\"Brilho Humano\">.\n<D05EX_Relic:Você salvou a maioria das pessoas, mudando seu destino trágico. Você fez o seu melhor, não fez?>"
  },
  RelicConfig_65410_Name = {
    Text = "<OrangeQuality:Medalha de Resgate·Ouro>"
  },
  RelicConfig_65410_StoryDesc = {
    Text = "Você salvou a maioria das pessoas, mudando seus destinos trágicos. Você já fez o seu melhor, não é?"
  },
  RelicConfig_65456_BattleDesc = {
    Text = "No início da batalha, embaralhe 3 cartas aleatórias de \"Sintoma\", jogue \"Sintoma\" para ganhar [Arg1] força.\n<D05EX_Relic:Com sua ajuda, nenhum membro da expedição sobreviveu. Você friamente garantiu o maior lucro para si mesmo, mas valeu a pena?>"
  },
  RelicConfig_65456_Desc = {
    Text = "No início da batalha, embaralhe 3 cartas aleatórias de \"Sintoma\", jogue \"Sintoma\" para ganhar [Arg1] força.\n<D05EX_Relic:Com sua ajuda, nenhum membro da expedição sobreviveu. Você friamente garantiu o maior lucro para si mesmo, mas valeu a pena?>"
  },
  RelicConfig_65456_Name = {
    Text = "<OrangeQuality:Insígnia do Solitário>"
  },
  RelicConfig_65456_StoryDesc = {
    Text = "Com sua ajuda, ninguém da equipe de pesquisa sobreviveu. Você obteve o maior benefício para si mesmo, mas valeu a pena?"
  },
  RelicConfig_65569_BattleDesc = {
    Text = "No início da batalha, o limite de capacidade de cálculo aumenta em 1, e todos os corpos despertos despertam. Nos próximos 5 turnos, ao início de cada turno, obtenha uma criação, incluindo \"equipamento de comunicação, o sacrifício da primavera, cajado de sacerdote, pássaro do ritual de azar, pêndulo temporal·projeção\"."
  },
  RelicConfig_65569_Desc = {
    Text = "No início da batalha, o limite de capacidade de cálculo aumenta em 1, e todos os corpos despertos despertam. Nos próximos 5 turnos, ao início de cada turno, obtenha uma criação, incluindo \"equipamento de comunicação, o sacrifício da primavera, cajado de sacerdote, pássaro do ritual de azar, pêndulo temporal·projétil\"."
  },
  RelicConfig_65569_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Tesouro Secreto δ\">"
  },
  RelicConfig_65570_BattleDesc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. Nos próximos 5 turnos, ao início de cada turno, obtenha uma relíquia, incluindo \"emblema de mythag, maleta do doutor, bateria protótipo, gravação de consciência, pêndulo crono·derivação\""
  },
  RelicConfig_65570_Desc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. Nos próximos 5 turnos, ao início de cada turno, obtenha uma relíquia, incluindo \"emblema de mythag, maleta do doutor, bateria protótipo, gravação de consciência, pêndulo crono·derivação\""
  },
  RelicConfig_65570_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Tesouro Secreto γ\">"
  },
  RelicConfig_66515_BattleDesc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. Nos próximos 5 turnos, ao início de cada turno, obtenha uma relíquia, incluindo \"notícias de Putney, princípios estéticos, canção da multidão, rosto incompleto, pêndulo crono·transações\""
  },
  RelicConfig_66515_Desc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. Nos próximos 5 turnos, ao início de cada turno, obtenha uma relíquia, incluindo \"notícias de Putney, princípios estéticos, canção da multidão, rosto incompleto, pêndulo crono·transações\""
  },
  RelicConfig_66515_Name = {
    Text = "<OrangeQuality:Chrono Pendulum\"Tesouro Secreto ε\">"
  },
  RelicConfig_66518_BattleDesc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. No início dos turnos ímpares, descubra um relíquia, totalizando até cinco descobertas"
  },
  RelicConfig_66518_Desc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. No início dos turnos ímpares, descubra um relíquia, totalizando até cinco descobertas"
  },
  RelicConfig_66518_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Desejo β\">"
  },
  RelicConfig_66519_BattleDesc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. No início dos turnos ímpares, descubra um relíquia, totalizando até cinco descobertas"
  },
  RelicConfig_66519_Desc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. No início dos turnos ímpares, descubra um relíquia, totalizando até cinco descobertas"
  },
  RelicConfig_66519_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Desejo α\">"
  },
  RelicConfig_67690_BattleDesc = {
    Text = "No início de cada rodada, todos os despertadores ganham 25 loucura. Ao coletar, a saúde máxima se torna 1,5 vezes"
  },
  RelicConfig_67690_Desc = {
    Text = "No início de cada rodada, todos os despertadores ganham 25 loucura. Ao coletar, a saúde máxima se torna 1,5 vezes"
  },
  RelicConfig_67690_Name = {
    Text = "<OrangeQuality: benção·aparência do pesadelo β>"
  },
  RelicConfig_67690_StoryDesc = {
    Text = "Sem medo, sem hesitação. Isso é apenas um sonho passageiro, a luz do Pai ainda brilha sobre você"
  },
  RelicConfig_67788_BattleDesc = {
    Text = "Ao coletar, ganhe 3 pontos de poder"
  },
  RelicConfig_67788_Desc = {
    Text = "Ao coletar, ganhe 3 pontos de poder"
  },
  RelicConfig_67788_Name = {
    Text = "<WhiteQuality:espelho de relógio de bolso>"
  },
  RelicConfig_67788_StoryDesc = {
    Text = "Memórias congeladas no tempo passado, enterradas no fundo negro"
  },
  RelicConfig_67789_BattleDesc = {
    Text = "Quando coletado, coloque 1 <DerivativeCardKeywords_1:\"Ethereal Echo\"> na sua mão."
  },
  RelicConfig_67789_Desc = {
    Text = "Quando coletado, coloque 1 <DerivativeCardKeywords_1:\"Ethereal Echo\"> na sua mão."
  },
  RelicConfig_67789_Name = {
    Text = "<WhiteQuality:Equipamento de Comunicação>"
  },
  RelicConfig_67789_StoryDesc = {
    Text = "Esperando ou temendo o momento em que o sino tocar"
  },
  RelicConfig_67790_BattleDesc = {
    Text = "Todo dano causado por \"golpes\" aumenta o dano crítico em 20%. Ao pegar, adicione 1 <DerivativeCardKeywords_40: \"Momento de Beleza\"> à mão"
  },
  RelicConfig_67790_Desc = {
    Text = "Todo dano causado por \"golpes\" aumenta o dano crítico em 20%. Ao pegar, adicione 1 <DerivativeCardKeywords_40: \"Momento de Beleza\"> à mão"
  },
  RelicConfig_67790_Name = {
    Text = "<WhiteQuality:Momento Belo>"
  },
  RelicConfig_67790_StoryDesc = {
    Text = "Preserve a beleza efêmera para sempre"
  },
  RelicConfig_67791_BattleDesc = {
    Text = "Ao coletar, aplique a todos os inimigos 1 turno de <WeaknessIconKeywords:ilusão> e <VulnerabilityIconKeywords:vulnerável>"
  },
  RelicConfig_67791_Desc = {
    Text = "Ao coletar, aplique a todos os inimigos 1 turno de <WeaknessIconKeywords:ilusão> e <VulnerabilityIconKeywords:vulnerável>"
  },
  RelicConfig_67791_Name = {
    Text = "<WhiteQuality:Camisa de Força>"
  },
  RelicConfig_67791_StoryDesc = {
    Text = "Não só o tempo descolore o tecido, o medo e a dor também"
  },
  RelicConfig_67793_BattleDesc = {
    Text = "No início da batalha, todos os Despertadores ganham 50 pontos de Aliemus. Puxe 2 <DerivativeCardKeywords_1:\"Eco Eclipsado\"> para sua mão."
  },
  RelicConfig_67793_Desc = {
    Text = "Quando pegado, todos os Despertadores ganham 50 pontos de Aliemus e coloque 2 <DerivativeCardKeywords_1:\"Ethereal Echo\"> na sua mão."
  },
  RelicConfig_67793_Name = {
    Text = "<OrangeQuality:dispositivo de comunicação+β>"
  },
  RelicConfig_67793_StoryDesc = {
    Text = "Esperando ou temendo o momento em que o sino tocar"
  },
  RelicConfig_67794_BattleDesc = {
    Text = "Limite de cartas na mão aumenta em 5, preencha a mão até o limite no início da batalha. No início do turno, puxe 1 carta extra, e no final do turno, descarte todas as cartas de sintoma e estado na mão, mantendo as outras cartas"
  },
  RelicConfig_67794_Desc = {
    Text = "Limite de cartas na mão aumenta em 5, preencha a mão até o limite no início da batalha. No início do turno, puxe 1 carta extra, e no final do turno, descarte todas as cartas de sintoma e estado na mão, mantendo as outras cartas"
  },
  RelicConfig_67794_Name = {
    Text = "<OrangeQuality: benção·inscrição da consciência β>"
  },
  RelicConfig_67794_StoryDesc = {
    Text = "O ganancioso grava seus erros no coração e busca redenção por seu passado"
  },
  RelicConfig_67818_BattleDesc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67818_Desc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67818_Name = {
    Text = "<OrangeQuality:\"Porta de Tudo ε\">"
  },
  RelicConfig_67819_BattleDesc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67819_Desc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67819_Name = {
    Text = "<OrangeQuality:\"Porta de Tudo ζ\">"
  },
  RelicConfig_67820_BattleDesc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67820_Desc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67820_Name = {
    Text = "<OrangeQuality:\"Porta de Todos θ\">"
  },
  RelicConfig_67821_BattleDesc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67821_Desc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67821_Name = {
    Text = "<OrangeQuality:\"Porta de Todos γ\">"
  },
  RelicConfig_67822_BattleDesc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67822_Desc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67822_Name = {
    Text = "<OrangeQuality:\"Porta de Todos α\">"
  },
  RelicConfig_67823_BattleDesc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67823_Desc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67823_Name = {
    Text = "<OrangeQuality:\"Porta de Todos η\">"
  },
  RelicConfig_67824_BattleDesc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67824_Desc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67824_Name = {
    Text = "<OrangeQuality:\"Porta de Todos δ\">"
  },
  RelicConfig_67825_BattleDesc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67825_Desc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67825_Name = {
    Text = "<OrangeQuality:\"Porta de Tudo β\">"
  },
  RelicConfig_67826_BattleDesc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67826_Desc = {
    Text = "No início da batalha, a Aritmética máxima +1, Desperte todos os Despertadores. No início do turno, descubra aleatoriamente uma \"Relíquia\" ou \"Suporte\", por um total de cinco descobertas."
  },
  RelicConfig_67826_Name = {
    Text = "<OrangeQuality:\"Porta de Todos ι\">"
  },
  RelicConfig_68651_BattleDesc = {
    Text = "No início da batalha, desperte todos os Corpos Despertos, coloque <DerivativeCardKeywords_84:\"Recordações do Brilho - Estátua de Cera Inacabada\"> na sua mão e copie todas as cartas do mazo de robo. Compre 5 cartas adicionais a cada turno e ganhe 5 pontos de poder de cálculo. Após disparar \"golpe\" ou \"defesa\", ganhe [Arg1] pontos de escudo."
  },
  RelicConfig_68651_Desc = {
    Text = "No início da batalha, desperte todos os corpos despertos, coloque <DerivativeCardKeywords_84:\"Recordações do Brilho - Estátua de Cera Inacabada\"> na sua mão, copie todas as cartas do monte de puxar. Compre 5 cartas adicionais a cada turno e ganhe 5 pontos de poder de cálculo. Após disparar \"golpear\" ou \"defesa\", ganhe [Arg1] pontos de escudo."
  },
  RelicConfig_68651_Name = {
    Text = "<OrangeQuality:\"Núcleo de Prata · Medo\">"
  },
  RelicConfig_68652_BattleDesc = {
    Text = "Ao início da batalha, desperte todos os Corpos Despertos e coloque <DerivativeCardKeywords_85:\"Recordações do Crepúsculo - Coração Distorcido\"> na sua mão. No início do turno, você pode escolher descartar qualquer número de cartas na mão e comprar o mesmo número de cartas. Em turnos ímpares, ganhe [Arg1] pontos de Força temporária e coloque <DerivativeCardKeywords_97:\"Vontade de Batalha Inesgotável β\"> na sua mão. Em turnos pares, ganhe [Arg2] pontos de Precaução temporária e coloque <DerivativeCardKeywords_98:\"Esconder β\"> na sua mão."
  },
  RelicConfig_68652_Desc = {
    Text = "Ao começar a batalha, desperte todos os Corpos Despertos e adicione <DerivativeCardKeywords_85:\"Recordações do Crepúsculo - Coração Distorcido\"> à sua mão. No início do turno, você pode escolher descartar qualquer carta da mão e comprar a mesma quantidade de cartas. Em turnos ímpares, ganhe [Arg1] pontos de Força temporária e adicione <DerivativeCardKeywords_97:\"Vontade de Batalha Inesgotável β\"> à sua mão. Em turnos pares, ganhe [Arg2] pontos de Precaução temporária e adicione <DerivativeCardKeywords_98:\"Esconder β\"> à sua mão."
  },
  RelicConfig_68652_Name = {
    Text = "<OrangeQuality:\"Núcleo de Prata Pura · Penetrante\">"
  },
  RelicConfig_68653_BattleDesc = {
    Text = "Ao início da batalha, desperte todos os corpos despertos e coloque <DerivativeCardKeywords_83:\"Recordações do Brilho - Resposta Inocente\"> na sua mão. Todos os corpos despertos podem liberar 1 vez a fúria explosiva a mais por turno, e ao liberar a fúria explosiva, reduza a força do inimigo em [Arg2] pontos. No início do turno, todos os corpos despertos ganham [Arg1] pontos de fúria."
  },
  RelicConfig_68653_Desc = {
    Text = "Ao início da batalha, desperte todos os corpos despertos e coloque <DerivativeCardKeywords_83:\"Recordações do Brilho - Resposta Inocente\"> na sua mão. Todos os corpos despertos podem liberar 1 vez a fúria explosiva a mais por turno, e ao liberar a fúria explosiva, reduza a força do inimigo em [Arg2] pontos. No início do turno, todos os corpos despertos ganham [Arg1] pontos de fúria."
  },
  RelicConfig_68653_Name = {
    Text = "<OrangeQuality:\"Núcleo de Prata Pura · Soluço\">"
  },
  RelicConfig_68654_BattleDesc = {
    Text = "Ao início da batalha, desperte todos os Corpos Despertos, coloque <DerivativeCardKeywords_88:\"Recordações do Brilho - Véu da Utopia\"> na sua mão, limite de cartas na mão da equipe +2, limite de armazenamento de Energia da Chave de Prata +100%. Após liberar a Ordem de chave, todos os Corpos Despertos ganham temporariamente Taxa de Crítico e Dano Crítico + [Arg1] %, ganhe um escudo de 20% da Vida máxima, compre cartas até que a mão atinja o limite."
  },
  RelicConfig_68654_Desc = {
    Text = "Ao início da batalha, desperte todos os Corpos Despertos, coloque <DerivativeCardKeywords_88:\"Recordações do Brilho - Véu da Utopia\"> na sua mão, limite de cartas na mão da equipe +2, limite de armazenamento de Energia da Chave de Prata +100%. Após liberar a Ordem de chave, todos os Corpos Despertos ganham temporariamente Taxa de Crítico e Dano Crítico + [Arg1] %, ganhe um escudo de 20% da Vida máxima, compre cartas até que a mão atinja o limite."
  },
  RelicConfig_68654_Name = {
    Text = "<OrangeQuality:\"Núcleo de Prata Pura · Loucura\">"
  },
  RelicConfig_68655_BattleDesc = {
    Text = "Ao começar a batalha, desperte todos os Corpos Despertos e coloque <DerivativeCardKeywords_89:\"Recordações do Crepúsculo - Núcleo de Abundância\"> na sua mão. Ao final do turno, preserve o poder de cálculo restante e não descarte mais cartas da mão. Para cada dano ativo causado, ganhe [Arg1] pontos de força temporária e [Arg2] pontos de escudo."
  },
  RelicConfig_68655_Desc = {
    Text = "Ao começar a batalha, desperte todos os Corpos Despertos e coloque <DerivativeCardKeywords_89:\"Recordações do Crepúsculo - Núcleo de Abundância\"> na sua mão. Ao final do turno, preserve o poder de cálculo restante e não descarte mais cartas da mão. Para cada dano ativo causado, ganhe [Arg1] pontos de força temporária e [Arg2] pontos de escudo."
  },
  RelicConfig_68655_Name = {
    Text = "<OrangeQuality:\"Prata Pura · Chegada\">"
  },
  RelicConfig_68656_BattleDesc = {
    Text = "Ao iniciar a batalha, desperte todos os Corpos Despertos, coloque <DerivativeCardKeywords_86:\"Recordações do Brilho - Vinho Doce de Mel\"> na sua mão, e o dano crítico de todos os Corpos Despertos se torna 1,5 vezes. No final do turno, os Corpos Despertos que não liberaram a Fúria Explosiva ganham [Arg1] pontos de Fúria. Se o número de cartas disparadas for menor que [Arg2], na próxima rodada compre 2 cartas e ganhe 2 pontos de Poder de cálculo."
  },
  RelicConfig_68656_Desc = {
    Text = "Ao iniciar a batalha, desperte todos os Corpos Despertos, coloque <DerivativeCardKeywords_86:\"Recordações do Brilho - Vinho Doce de Mel\"> na sua mão, e o dano crítico de todos os Corpos Despertos se torna 1,5 vezes. No final do turno, os Corpos Despertos que não liberaram a Fúria Explosiva ganham [Arg1] pontos de Fúria. Se o número de cartas disparadas for menor que [Arg2], na próxima rodada compre 2 cartas e ganhe 2 pontos de Poder de cálculo."
  },
  RelicConfig_68656_Name = {
    Text = "<OrangeQuality:\"Núcleo de Prata Pura · Labirinto\">"
  },
  RelicConfig_68657_BattleDesc = {
    Text = "No início da batalha, Desperta todos os Corpos Despertos, coloca <DerivativeCardKeywords_87:\"Recordações do Crepúsculo - O Julgamento do Intermediário\"> na mão e dobra o Dano potencializado da equipe. O efeito de Sintoma: Enfraquecer que você inflige aumenta de 25% para 50%. No final de cada turno, ganha Escudo do personagem igual a [Arg1]% da Vida máxima e causa <FixedDamage:Dano Puro> igual a [Arg2] x Escudo do personagem a todos os inimigos."
  },
  RelicConfig_68657_Desc = {
    Text = "No início da batalha, Desperta todos os Corpos Despertos, coloca <DerivativeCardKeywords_87:\"Recordações do Crepúsculo - O Julgamento do Intermediário\"> na mão e dobra o Dano potencializado da equipe. O efeito de Sintoma: Enfraquecer que você inflige aumenta de 25% para 50%. No final de cada turno, ganha Escudo do personagem igual a [Arg1]% da Vida máxima e causa <FixedDamage:Dano Puro> igual a [Arg2] x Escudo do personagem a todos os inimigos."
  },
  RelicConfig_68657_Name = {
    Text = "<OrangeQuality:\"Núcleo de Prata Pura · Superstição\">"
  },
  RelicConfig_68886_BattleDesc = {
    Text = "O dano, cura e escudo causados por Tawil aumentam em 50%. No início da batalha, Tawil ganha 120 pontos de loucura."
  },
  RelicConfig_68886_Desc = {
    Text = "O dano, escudo e recuperação de vida causados por Tawil aumentam em 50%. No início da batalha, Tawil ganha 120 pontos de loucura."
  },
  RelicConfig_68886_Name = {
    Text = "<OrangeQuality:«Olho Onisciente»>"
  },
  RelicConfig_68886_StoryDesc = {
    Text = "Saindo da porta, Ele segue o único caminho correto."
  },
  RelicConfig_69319_BattleDesc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. No início dos turnos ímpares, descubra um relíquia, totalizando até cinco descobertas"
  },
  RelicConfig_69319_Desc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. No início dos turnos ímpares, descubra um relíquia, totalizando até cinco descobertas"
  },
  RelicConfig_69319_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Desejo ε\">"
  },
  RelicConfig_69320_BattleDesc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. No início dos turnos ímpares, descubra um relíquia, totalizando até cinco descobertas"
  },
  RelicConfig_69320_Desc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. No início dos turnos ímpares, descubra um relíquia, totalizando até cinco descobertas"
  },
  RelicConfig_69320_Name = {
    Text = "<OrangeQuality:Pêndulo Crono \"Desejando γ\">"
  },
  RelicConfig_69321_BattleDesc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. No início dos turnos ímpares, descubra um relíquia, totalizando até cinco descobertas"
  },
  RelicConfig_69321_Desc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1, e todos os despertadores despertam. No início dos turnos ímpares, descubra um relíquia, totalizando até cinco descobertas"
  },
  RelicConfig_69321_Name = {
    Text = "<OrangeQuality:Pêndulo Chrono \"Desejando δ\">"
  },
  RelicConfig_70042_BattleDesc = {
    Text = "No início do turno, acumule 1 ponto de \"Fonte do Abismo\", escolha \"Sono\" ou \"Despertar\". Sono: acumule 1 ponto adicional de \"Fonte do Abismo\". Despertar: consuma 1/5/10 pontos de \"Fonte do Abismo\" para obter a ajuda de Tulu. Quanto mais pontos de \"Fonte do Abismo\" forem consumidos, mais forte será o efeito da ajuda de Tulu."
  },
  RelicConfig_70042_Desc = {
    Text = "No início do turno, acumule 1 ponto de \"Fonte do Abismo\", escolha \"Sono\" ou \"Despertar\". Sono: acumule 1 ponto adicional de \"Fonte do Abismo\". Despertar: consuma 1/5/10 pontos de \"Fonte do Abismo\" para obter a assistência de Tulu. Quanto mais \"Fonte do Abismo\" for consumida, mais forte será o efeito da assistência de Tulu."
  },
  RelicConfig_70042_Name = {
    Text = "<OrangeQuality:Poder do Rei Divino>"
  },
  RelicConfig_70084_BattleDesc = {
    Text = "No início da batalha, embaralhe todas as <ExaltIconKeywords: gnose> dos despertadores no baralho de compra."
  },
  RelicConfig_70084_Desc = {
    Text = "No início da batalha, embaralhe todas as <ExaltIconKeywords: gnose> dos despertadores no baralho de compra."
  },
  RelicConfig_70084_Name = {
    Text = "<OrangeQuality:Despertar>"
  },
  RelicConfig_70700_BattleDesc = {
    Text = "Todos os despertos têm um aumento de [Arg1]% no dano base causado."
  },
  RelicConfig_70700_Desc = {
    Text = "Todos os despertos têm um aumento de [Arg1]% no dano base causado."
  },
  RelicConfig_70700_Name = {
    Text = "<WhiteQuality:Cachimbo Chorão>"
  },
  RelicConfig_70700_StoryDesc = {
    Text = "Isso é fruto do ódio ou resultado da vingança?"
  },
  RelicConfig_70701_BattleDesc = {
    Text = "No início do turno, todos os Despertados ganham [Arg1] de Loucura."
  },
  RelicConfig_70701_Desc = {
    Text = "No início do turno, todos os Despertados ganham [Arg1] de Loucura."
  },
  RelicConfig_70701_Name = {
    Text = "<WhiteQuality:Bateria Prototípica>"
  },
  RelicConfig_70701_StoryDesc = {
    Text = "Esperança portátil"
  },
  RelicConfig_70702_BattleDesc = {
    Text = "Após liberar a \"exaltação\", ganhe [Arg1] pontos de <PowerIconKeywords:poder> temporários."
  },
  RelicConfig_70702_Desc = {
    Text = "Após liberar a \"exaltação\", ganhe [Arg1] pontos de <PowerIconKeywords:poder> temporários."
  },
  RelicConfig_70702_Name = {
    Text = "<OrangeQuality:Tranca Pesada+>"
  },
  RelicConfig_70702_StoryDesc = {
    Text = "Uma fechadura grossa e robusta, difícil de abrir sem chave.\nClaro, para um mestre ladrão, isso não é nada"
  },
  RelicConfig_70703_BattleDesc = {
    Text = "\"Golpe\" causa adicionalmente 1 instância de dano equivalente a [Arg1]% do ataque do despertado, limitado a 3 ativações por turno."
  },
  RelicConfig_70703_Desc = {
    Text = "\"Golpe\" causa adicionalmente 1 instância de dano equivalente a [Arg1]% do ataque do despertado, limitado a 3 ativações por turno."
  },
  RelicConfig_70703_Name = {
    Text = "<WhiteQuality:Faca de Salgueiro Enferrujada>"
  },
  RelicConfig_70703_StoryDesc = {
    Text = "Não é adequado para cortar tecido vivo"
  },
  RelicConfig_70704_BattleDesc = {
    Text = "Após usar o Despertar da Chave de Prata, aplique [Arg1] níveis de <IntoxicationIconKeywords:veneno> a todos os inimigos e ganhe [Arg2] pontos de energia de prata."
  },
  RelicConfig_70704_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, aplique [Arg1] níveis de <IntoxicationIconKeywords:veneno> a todos os inimigos e ganhe [Arg2] pontos de energia de prata."
  },
  RelicConfig_70704_Name = {
    Text = "<OrangeQuality:Unguento Suspeito+>"
  },
  RelicConfig_70704_StoryDesc = {
    Text = "Um ungüento caseiro para feridas, não use sem orientação médica"
  },
  RelicConfig_70705_BattleDesc = {
    Text = "\"Golpe\" aplica <IntoxicationIconKeywords:veneno> equivalente a [Arg1]% do dano causado, no máximo [Arg2] pontos por turno."
  },
  RelicConfig_70705_Desc = {
    Text = "\"Golpe\" aplica <IntoxicationIconKeywords:veneno> equivalente a [Arg1]% do dano causado, no máximo [Arg2] pontos por turno."
  },
  RelicConfig_70705_Name = {
    Text = "<OrangeQuality:Língua Estranha+>"
  },
  RelicConfig_70705_StoryDesc = {
    Text = "Ele não é um demônio, mas transmite sussurros de além do mundo"
  },
  RelicConfig_70706_BattleDesc = {
    Text = "A quantidade automática de <EmbryoFusionIconKeywords:Fusão de Embrião> aumenta em [Arg1]%."
  },
  RelicConfig_70706_Desc = {
    Text = "A quantidade automática de <EmbryoFusionIconKeywords:Fusão de Embrião> aumenta em [Arg1]%."
  },
  RelicConfig_70706_Name = {
    Text = "<WhiteQuality:Diagnóstico de Peste>"
  },
  RelicConfig_70706_StoryDesc = {
    Text = "Peste—uma manifestação acidental da inquietação inconsciente da natureza"
  },
  RelicConfig_70707_BattleDesc = {
    Text = "Após usar o Despertar da Chave de Prata, todos os Despertados ganham [Arg1] pontos de loucura e [Arg2] pontos de s-energia."
  },
  RelicConfig_70707_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, todos os Despertados ganham [Arg1] pontos de loucura e [Arg2] pontos de s-energia."
  },
  RelicConfig_70707_Name = {
    Text = "<OrangeQuality:Abotoadura de Louro+>"
  },
  RelicConfig_70707_StoryDesc = {
    Text = "Abotoaduras de prata com padrão de folhas de louro.\nElas são bem feitas, brilhantes, e uma vez simbolizaram a amizade de duas crianças"
  },
  RelicConfig_70708_BattleDesc = {
    Text = "Após o início da batalha, ganhe [Arg1] <ProficientInRealmsIconKeywords:Maestria em Domínios>. Todos os despertadores têm um aumento de [Arg2]% no <IntoxicationIconKeywords:veneno> causado e no <IntoxicationIconKeywords:veneno> causado pelas relíquias."
  },
  RelicConfig_70708_Desc = {
    Text = "Após o início da batalha, ganhe [Arg1] <ProficientInRealmsIconKeywords:Maestria em Domínios>. Todos os despertadores têm um aumento de [Arg2]% no <IntoxicationIconKeywords:veneno> causado e no <IntoxicationIconKeywords:veneno> causado pelas relíquias."
  },
  RelicConfig_70708_Name = {
    Text = "<OrangeQuality:Máquina de Costura empoeirada+>"
  },
  RelicConfig_70708_StoryDesc = {
    Text = "Uma mãe carinhosa, remendando as feridas do coração"
  },
  RelicConfig_70709_BattleDesc = {
    Text = "Após entrar em um turno ultra, a primeira carta de comando não derivada jogada terá um efeito adicional de [Arg1] vezes."
  },
  RelicConfig_70709_Desc = {
    Text = "Após entrar em um turno ultra, a primeira carta de comando não derivada jogada terá um efeito adicional de [Arg1] vezes."
  },
  RelicConfig_70709_Name = {
    Text = "<WhiteQuality:ampulheta brilhante>"
  },
  RelicConfig_70709_StoryDesc = {
    Text = "Uma quantidade mensurável de tempo"
  },
  RelicConfig_70711_BattleDesc = {
    Text = "Após usar o Despertar da chave de prata, obtenha [Arg1] pontos de <RetaliateIconKeywords:balcão> e [Arg2] pontos de energia de chave de prata."
  },
  RelicConfig_70711_Desc = {
    Text = "Após usar o Despertar da chave de prata, obtenha [Arg1] pontos de <RetaliateIconKeywords:balcão> e [Arg2] pontos de energia de chave de prata."
  },
  RelicConfig_70711_Name = {
    Text = "<OrangeQuality:Fragmento do Sábio+>"
  },
  RelicConfig_70711_StoryDesc = {
    Text = "\"Quão tolos são os humanos, acreditando cegamente simplesmente porque é antiquado.\""
  },
  RelicConfig_70712_BattleDesc = {
    Text = "Após usar o Despertar da Chave de Prata, obtenha [Arg1] <PowerIconKeywords:força> e [Arg2] pontos de s-energia."
  },
  RelicConfig_70712_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, obtenha [Arg1] <PowerIconKeywords:força> e [Arg2] pontos de s-energia."
  },
  RelicConfig_70712_Name = {
    Text = "<WhiteQuality:Nossa casa>"
  },
  RelicConfig_70712_StoryDesc = {
    Text = "Eles estavam juntos antes e estarão juntos para sempre. Eles são uma família amorosa"
  },
  RelicConfig_70713_BattleDesc = {
    Text = "Perder vida para obter [Arg1]% da quantidade de vida perdida na fornalha carmesim."
  },
  RelicConfig_70713_Desc = {
    Text = "Perder vida para obter [Arg1]% da quantidade de vida perdida na fornalha carmesim."
  },
  RelicConfig_70713_Name = {
    Text = "<WhiteQuality:Serra de Aço Enferrujada>"
  },
  RelicConfig_70713_StoryDesc = {
    Text = "O doutor da dissecação passou a vida sem ver uma bela mulher, apenas um saco cheio de ossos, nervos inflamados por doenças, músculos e tecidos"
  },
  RelicConfig_70714_BattleDesc = {
    Text = "Após o início da batalha, ganhe [Arg1] <ProficientInRealmsIconKeywords:Maestria em Domínios>. Todos os <RetaliateIconKeywords:balcão> causados pelos despertadores e pelas criações aumentam em [Arg2]%."
  },
  RelicConfig_70714_Desc = {
    Text = "Após o início da batalha, ganhe [Arg1] <ProficientInRealmsIconKeywords:Maestria em Domínios>. Todos os <RetaliateIconKeywords:balcão> causados pelos despertadores e pelas criações aumentam em [Arg2]%."
  },
  RelicConfig_70714_Name = {
    Text = "<WhiteQuality:Franqueza>"
  },
  RelicConfig_70714_StoryDesc = {
    Text = "Ele transmitiu inúmeros segredos, ativos ou passivos"
  },
  RelicConfig_70715_BattleDesc = {
    Text = "Após usar o Despertar da chave de prata, compre [Arg1] cartas e ganhe [Arg2] pontos de energia de chave de prata."
  },
  RelicConfig_70715_Desc = {
    Text = "Após usar o Despertar da chave de prata, compre [Arg1] cartas e ganhe [Arg2] pontos de energia de chave de prata."
  },
  RelicConfig_70715_Name = {
    Text = "<OrangeQuality:Carteira Nova+>"
  },
  RelicConfig_70715_StoryDesc = {
    Text = "Uma carteira de couro com o emblema da universidade de Mythag.\nEstá agora completamente vazia, sem nada dentro"
  },
  RelicConfig_70717_BattleDesc = {
    Text = "No início do turno, compre [Arg1] cartas"
  },
  RelicConfig_70717_Desc = {
    Text = "No início do turno, compre [Arg1] cartas"
  },
  RelicConfig_70717_Name = {
    Text = "<OrangeQuality:Bússola Direcional+>"
  },
  RelicConfig_70717_StoryDesc = {
    Text = "Não aponta direção, apenas campo magnético"
  },
  RelicConfig_70718_BattleDesc = {
    Text = "Após usar \"Fúria Explosiva,\" todos os inimigos recebem [Arg1] de <FixedDamage:Dano Puro> e acionam [Arg2]% de <IntoxicationIconKeywords:Envenenamento>."
  },
  RelicConfig_70718_Desc = {
    Text = "Após usar \"Fúria Explosiva,\" todos os inimigos recebem 1 instância de <FixedDamage:Dano Puro> igual a [Arg2]% da Vida máxima da equipe e acionam [Arg2]% de <IntoxicationIconKeywords:Envenenamento>."
  },
  RelicConfig_70718_Name = {
    Text = "<WhiteQuality:Mandíbula a Laser>"
  },
  RelicConfig_70718_StoryDesc = {
    Text = "Ossos exibidos na galeria privada de um colecionador.\nO colecionador era fascinado pelo brilho bonito, admirando-o dia e noite, até morrer e se tornar um deles"
  },
  RelicConfig_70719_BattleDesc = {
    Text = "No início do turno, todos os Despertados ganham [Arg1] de Loucura."
  },
  RelicConfig_70719_Desc = {
    Text = "No início do turno, todos os Despertados ganham [Arg1] de Loucura."
  },
  RelicConfig_70719_Name = {
    Text = "<OrangeQuality:Bateria Prototípica+>"
  },
  RelicConfig_70719_StoryDesc = {
    Text = "Esperança portátil"
  },
  RelicConfig_70720_BattleDesc = {
    Text = "No início do turno, se a vida estiver abaixo de 25%, ganhe [Arg1] de <PowerIconKeywords:força> temporária."
  },
  RelicConfig_70720_Desc = {
    Text = "No início do turno, se a vida estiver abaixo de 25%, ganhe [Arg1] de <PowerIconKeywords:força> temporária."
  },
  RelicConfig_70720_Name = {
    Text = "<WhiteQuality:Suprema Honra>"
  },
  RelicConfig_70720_StoryDesc = {
    Text = "Um gato preto elegante e misterioso, dizem ser a encarnação de um deus em um distante deserto. Mas o nome desse deus agora é desconhecido.\nAdorado, venerado, esquecido, talvez seja o destino dos deuses"
  },
  RelicConfig_70721_BattleDesc = {
    Text = "Após liberar 4 explosões de loucura em uma rodada, ganhe [Arg1] pontos de aritmética. Recarga em 3 turnos."
  },
  RelicConfig_70721_Desc = {
    Text = "Após liberar 4 explosões de loucura em uma rodada, ganhe [Arg1] pontos de aritmética. Recarga em 3 turnos."
  },
  RelicConfig_70721_Name = {
    Text = "<WhiteQuality:Máquina de Diferença Prateada>"
  },
  RelicConfig_70721_StoryDesc = {
    Text = "\"Mudou a história.\""
  },
  RelicConfig_70722_BattleDesc = {
    Text = "Após usar o Despertar da Chave de Prata, obtenha [Arg1] <PowerIconKeywords:força> e [Arg2] pontos de s-energia."
  },
  RelicConfig_70722_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, obtenha [Arg1] <PowerIconKeywords:força> e [Arg2] pontos de s-energia."
  },
  RelicConfig_70722_Name = {
    Text = "<OrangeQuality:Nossa Casa+>"
  },
  RelicConfig_70722_StoryDesc = {
    Text = "Eles estavam juntos antes e estarão juntos para sempre. Eles são uma família amorosa"
  },
  RelicConfig_70723_BattleDesc = {
    Text = "Ao ativar 2 cartas consecutivamente com um custo de aritmética maior do que a carta anterior, ganhe [Arg1] <RetaliateIconKeywords:contra-ataque>, podendo ser acionado no máximo 3 vezes por turno."
  },
  RelicConfig_70723_Desc = {
    Text = "Ao ativar 2 cartas consecutivamente com um custo de aritmética maior do que a carta anterior, ganhe [Arg1] <RetaliateIconKeywords:contra-ataque>, podendo ser acionado no máximo 3 vezes por turno."
  },
  RelicConfig_70723_Name = {
    Text = "<OrangeQuality:Registro Arcano+>"
  },
  RelicConfig_70723_StoryDesc = {
    Text = "Tendência do destino"
  },
  RelicConfig_70724_BattleDesc = {
    Text = "Batalha começa com [Arg1] <PowerIconKeywords:força>."
  },
  RelicConfig_70724_Desc = {
    Text = "Batalha começa com [Arg1] <PowerIconKeywords:força>."
  },
  RelicConfig_70724_Name = {
    Text = "<OrangeQuality:Broche de Rubi+>"
  },
  RelicConfig_70724_StoryDesc = {
    Text = "Vermelho escorrendo"
  },
  RelicConfig_70725_BattleDesc = {
    Text = "Após o início da batalha, aplique [Arg1] camadas de <WeaknessIconKeywords:fraqueza> a todos os inimigos. O efeito é dobrado em batalhas contra chefes. Todos os despertadores têm um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_70725_Desc = {
    Text = "Após o início da batalha, aplique [Arg1] camadas de <WeaknessIconKeywords:fraqueza> a todos os inimigos. O efeito é dobrado em batalhas contra chefes. Todos os despertadores têm um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_70725_Name = {
    Text = "<OrangeQuality:Menino Travesso+>"
  },
  RelicConfig_70725_StoryDesc = {
    Text = "Nascido do puro mal, mesmo que não fosse sua vontade"
  },
  RelicConfig_70726_BattleDesc = {
    Text = "Aniquilação: obtenha [Arg1] escudo, com recarga de 3 turnos."
  },
  RelicConfig_70726_Desc = {
    Text = "Aniquilação: obtenha [Arg1] escudo, com recarga de 3 turnos."
  },
  RelicConfig_70726_Name = {
    Text = "<WhiteQuality:Relógio de Bolso Supercorda>"
  },
  RelicConfig_70726_StoryDesc = {
    Text = "\"\"Oh não, o relógio de bolso parou.\""
  },
  RelicConfig_70727_BattleDesc = {
    Text = "No fim do turno, recupera [Heal:Arg1] de Vida."
  },
  RelicConfig_70727_Desc = {
    Text = "No fim do turno, recupera [Heal:Arg1] de Vida."
  },
  RelicConfig_70727_Name = {
    Text = "<OrangeQuality:Sangue Abençoado+>"
  },
  RelicConfig_70727_StoryDesc = {
    Text = "Doce e suave, com aroma de rosas"
  },
  RelicConfig_70728_BattleDesc = {
    Text = "Use a posição de mar tranquilo para fazer todos os inimigos perderem [Arg1] pontos de <ExhaustionIconKeywords: força> temporária, com um tempo de espera de 3 rodadas."
  },
  RelicConfig_70728_Desc = {
    Text = "Use a posição de mar tranquilo para fazer todos os inimigos perderem [Arg1] pontos de <ExhaustionIconKeywords: força> temporária, com um tempo de espera de 3 rodadas."
  },
  RelicConfig_70728_Name = {
    Text = "<OrangeQuality:Apêndice Sem Nome+>"
  },
  RelicConfig_70728_StoryDesc = {
    Text = "Cuidado com as mãos"
  },
  RelicConfig_70730_BattleDesc = {
    Text = "Batalha começa com [Arg1] <PowerIconKeywords:força>."
  },
  RelicConfig_70730_Desc = {
    Text = "Batalha começa com [Arg1] <PowerIconKeywords:força>."
  },
  RelicConfig_70730_Name = {
    Text = "<WhiteQuality:Broche de Rubi>"
  },
  RelicConfig_70730_StoryDesc = {
    Text = "Vermelho escorrendo"
  },
  RelicConfig_70731_BattleDesc = {
    Text = "Ao ser atacado por um inimigo, causa [Arg1] de Dano Fixo a ele. Este Dano usufrui de um bônus de [Arg2]% de <RetaliateIconKeywords:Contador>. Cada inimigo pode acionar este efeito até 1 vez por turno."
  },
  RelicConfig_70731_Desc = {
    Text = "Ao ser atacado por um inimigo, causa Dano Fixo igual a [Arg3]% da Vida máxima da equipe. Este Dano usufrui de um bônus de [Arg2]% de <RetaliateIconKeywords:Contador>. Cada inimigo pode acionar este efeito até 1 vez por turno."
  },
  RelicConfig_70731_Name = {
    Text = "<OrangeQuality:Adaga de Sacrifício Perdida+>"
  },
  RelicConfig_70731_StoryDesc = {
    Text = "Uma adaga de lâmina curva, usada em rituais"
  },
  RelicConfig_70732_BattleDesc = {
    Text = "Após entrar em um turno ultra, a primeira carta de comando não derivada jogada terá um efeito adicional de [Arg1] vezes."
  },
  RelicConfig_70732_Desc = {
    Text = "Após entrar em um turno ultra, a primeira carta de comando não derivada jogada terá um efeito adicional de [Arg1] vezes."
  },
  RelicConfig_70732_Name = {
    Text = "<OrangeQuality:Resplandor Ampulheta+>"
  },
  RelicConfig_70732_StoryDesc = {
    Text = "Uma quantidade mensurável de tempo"
  },
  RelicConfig_70733_BattleDesc = {
    Text = "A quantidade automática de <EmbryoFusionIconKeywords:Fusão de Embrião> aumenta em [Arg1]%."
  },
  RelicConfig_70733_Desc = {
    Text = "A quantidade automática de <EmbryoFusionIconKeywords:Fusão de Embrião> aumenta em [Arg1]%."
  },
  RelicConfig_70733_Name = {
    Text = "<OrangeQuality:Diagnóstico da Praga+>"
  },
  RelicConfig_70733_StoryDesc = {
    Text = "Peste—uma manifestação acidental da inquietação inconsciente da natureza"
  },
  RelicConfig_70734_BattleDesc = {
    Text = "Após usar o Despertar da Chave de Prata, aumente o dano base causado por todos os Despertados em [Arg1]% e obtenha [Arg2] pontos de s-energia."
  },
  RelicConfig_70734_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, aumente o dano base causado por todos os Despertados em [Arg1]% e obtenha [Arg2] pontos de s-energia."
  },
  RelicConfig_70734_Name = {
    Text = "<WhiteQuality:Astrolábio do Grimório>"
  },
  RelicConfig_70734_StoryDesc = {
    Text = "Mistérios do universo"
  },
  RelicConfig_70735_BattleDesc = {
    Text = "Ao ativar 2 cartas consecutivamente com um custo de aritmética menor do que a carta anterior, aplique [Arg1] camadas de <IntoxicationIconKeywords:veneno> a todos os inimigos, podendo ser acionado no máximo 3 vezes por turno."
  },
  RelicConfig_70735_Desc = {
    Text = "Ao ativar 2 cartas consecutivamente com um custo de aritmética menor do que a carta anterior, aplique [Arg1] camadas de <IntoxicationIconKeywords:veneno> a todos os inimigos, podendo ser acionado no máximo 3 vezes por turno."
  },
  RelicConfig_70735_Name = {
    Text = "<OrangeQuality:Artefato Arcano+>"
  },
  RelicConfig_70735_StoryDesc = {
    Text = "Fim do destino"
  },
  RelicConfig_70736_BattleDesc = {
    Text = "Use a posição de mar tranquilo para fazer todos os inimigos perderem [Arg1] pontos de <ExhaustionIconKeywords: força> temporária, com um tempo de espera de 3 rodadas."
  },
  RelicConfig_70736_Desc = {
    Text = "Use a posição de mar tranquilo para fazer todos os inimigos perderem [Arg1] pontos de <ExhaustionIconKeywords: força> temporária, com um tempo de espera de 3 rodadas."
  },
  RelicConfig_70736_Name = {
    Text = "<WhiteQuality:Apêndice Sem Nome>"
  },
  RelicConfig_70736_StoryDesc = {
    Text = "Cuidado com as mãos"
  },
  RelicConfig_70737_BattleDesc = {
    Text = "Após jogar uma carta, se o número de cartas na mão for menor ou igual a [Arg1], compre [Arg2] cartas. Máximo de [Arg3] ativações por turno."
  },
  RelicConfig_70737_Desc = {
    Text = "Após jogar uma carta, se o número de cartas na mão for menor ou igual a [Arg1], compre [Arg2] cartas. Máximo de [Arg3] ativações por turno."
  },
  RelicConfig_70737_Name = {
    Text = "<WhiteQuality:Luvas de Mágica>"
  },
  RelicConfig_70737_StoryDesc = {
    Text = "\"Não tenha medo, é apenas uma ilusão.\""
  },
  RelicConfig_70738_BattleDesc = {
    Text = "No fim do turno, recupera [Heal:Arg1] de Vida."
  },
  RelicConfig_70738_Desc = {
    Text = "No fim do turno, recupera [Heal:Arg1] de Vida."
  },
  RelicConfig_70738_Name = {
    Text = "<WhiteQuality:Sangue Abençoado>"
  },
  RelicConfig_70738_StoryDesc = {
    Text = "Doce e suave, com aroma de rosas"
  },
  RelicConfig_70739_BattleDesc = {
    Text = "Após usar o Despertar da chave de prata, obtenha [Arg1] pontos de escudo e [Arg2] pontos de s-energia."
  },
  RelicConfig_70739_Desc = {
    Text = "Após usar o Despertar da chave de prata, obtenha [Arg1] pontos de escudo e [Arg2] pontos de s-energia."
  },
  RelicConfig_70739_Name = {
    Text = "<WhiteQuality:especime de borboleta>"
  },
  RelicConfig_70739_StoryDesc = {
    Text = "Até hoje, ele é profundamente amado por alguém"
  },
  RelicConfig_70740_BattleDesc = {
    Text = "Após usar o Despertar da Chave de Prata, aumente o dano base causado por todos os Despertados em [Arg1]% e obtenha [Arg2] pontos de s-energia."
  },
  RelicConfig_70740_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, aumente o dano base causado por todos os Despertados em [Arg1]% e obtenha [Arg2] pontos de s-energia."
  },
  RelicConfig_70740_Name = {
    Text = "<OrangeQuality:Artefato Celestial+>"
  },
  RelicConfig_70740_StoryDesc = {
    Text = "Mistérios do universo"
  },
  RelicConfig_70741_BattleDesc = {
    Text = "A saúde máxima aritmética aumenta em [Arg1]."
  },
  RelicConfig_70741_Desc = {
    Text = "A saúde máxima aritmética aumenta em [Arg1]."
  },
  RelicConfig_70741_Name = {
    Text = "<OrangeQuality:Soro Ativo+>"
  },
  RelicConfig_70741_StoryDesc = {
    Text = "Espasmos também são uma forma de atividade"
  },
  RelicConfig_70742_BattleDesc = {
    Text = "No início da batalha, limite de tentáculos aumentado em [Arg1]. Ganhe [Arg2] tentáculos."
  },
  RelicConfig_70742_Desc = {
    Text = "No início da batalha, limite de tentáculos aumentado em [Arg1]. Ganhe [Arg2] tentáculos."
  },
  RelicConfig_70742_Name = {
    Text = "<WhiteQuality:Canção do Mar>"
  },
  RelicConfig_70742_StoryDesc = {
    Text = "Dizem que animais não comestíveis como o caramujo de tecido absorvem cerca de 80% dos nutrientes do oceano"
  },
  RelicConfig_70743_BattleDesc = {
    Text = "Na primeira vez que <DevouredIconKeywords:devorar> ocorrer em um turno, outros Despertados ganham [Arg1] Loucura."
  },
  RelicConfig_70743_Desc = {
    Text = "Na primeira vez que <DevouredIconKeywords:devorar> ocorrer em um turno, outros Despertados ganham [Arg1] Loucura."
  },
  RelicConfig_70743_Name = {
    Text = "<WhiteQuality:Sonho Dourado>"
  },
  RelicConfig_70743_StoryDesc = {
    Text = "O dia da metamorfose será o seu fim"
  },
  RelicConfig_70744_BattleDesc = {
    Text = "Após jogar uma carta de comando não derivada, embaralhe [Arg1] cópias temporárias dessa carta com custo de aritmética reduzido em 2 no baralho de compra, com tempo de recarga de 3 turnos."
  },
  RelicConfig_70744_Desc = {
    Text = "Após jogar uma carta de comando não derivada, embaralhe [Arg1] cópias temporárias dessa carta com custo de aritmética reduzido em 2 no baralho de compra, com tempo de recarga de 3 turnos."
  },
  RelicConfig_70744_Name = {
    Text = "<OrangeQuality:Gravador sem Voz+>"
  },
  RelicConfig_70744_StoryDesc = {
    Text = "Sua voz desapareceu no vento"
  },
  RelicConfig_70745_BattleDesc = {
    Text = "No início da batalha, ganhe [Arg1] <RetaliateIconKeywords:contra-ataque>, o efeito é dobrado em batalhas contra chefes."
  },
  RelicConfig_70745_Desc = {
    Text = "No início da batalha, ganhe [Arg1] <RetaliateIconKeywords:contra-ataque>, o efeito é dobrado em batalhas contra chefes."
  },
  RelicConfig_70745_Name = {
    Text = "<OrangeQuality:Camisa de Ortiga+>"
  },
  RelicConfig_70745_StoryDesc = {
    Text = "Não pode identificar o líquido contaminado"
  },
  RelicConfig_70746_BattleDesc = {
    Text = "No início do turno, se a vida estiver abaixo de 25%, ganhe [Arg1] de <PowerIconKeywords:força> temporária."
  },
  RelicConfig_70746_Desc = {
    Text = "No início do turno, se a vida estiver abaixo de 25%, ganhe [Arg1] de <PowerIconKeywords:força> temporária."
  },
  RelicConfig_70746_Name = {
    Text = "<OrangeQuality:Suprema Honra+>"
  },
  RelicConfig_70746_StoryDesc = {
    Text = "Um gato preto elegante e misterioso, dizem ser a encarnação de um deus em um distante deserto. Mas o nome desse deus agora é desconhecido.\nAdorado, venerado, esquecido, talvez seja o destino dos deuses"
  },
  RelicConfig_70747_BattleDesc = {
    Text = "Após jogar uma carta, se o número de cartas na mão for menor ou igual a [Arg1], compre [Arg2] cartas. Máximo de [Arg3] ativações por turno."
  },
  RelicConfig_70747_Desc = {
    Text = "Após jogar uma carta, se o número de cartas na mão for menor ou igual a [Arg1], compre [Arg2] cartas. Máximo de [Arg3] ativações por turno."
  },
  RelicConfig_70747_Name = {
    Text = "<OrangeQuality:Luvas de Mágica+>"
  },
  RelicConfig_70747_StoryDesc = {
    Text = "\"Não tenha medo, é apenas uma ilusão.\""
  },
  RelicConfig_70748_BattleDesc = {
    Text = "Após usar o Despertar da chave de prata, obtenha [Arg1] pontos de escudo e [Arg2] pontos de s-energia."
  },
  RelicConfig_70748_Desc = {
    Text = "Após usar o Despertar da chave de prata, obtenha [Arg1] pontos de escudo e [Arg2] pontos de s-energia."
  },
  RelicConfig_70748_Name = {
    Text = "<OrangeQuality:Espécime de Borboleta+>"
  },
  RelicConfig_70748_StoryDesc = {
    Text = "Até hoje, ele é profundamente amado por alguém"
  },
  RelicConfig_70749_BattleDesc = {
    Text = "Sempre que uma carta entra no espaço ultra-dimensional, se esta carta pertencer a um proprietário diferente de outras cartas ultra-dimensionais, coloque [Arg1] <DerivativeCardKeywords_4:\"Inspiração\"> cartas na mão."
  },
  RelicConfig_70749_Desc = {
    Text = "Sempre que uma carta entra no espaço ultra-dimensional, se esta carta pertencer a um proprietário diferente de outras cartas ultra-dimensionais, coloque [Arg1] <DerivativeCardKeywords_4:\"Inspiração\"> cartas na mão."
  },
  RelicConfig_70749_Name = {
    Text = "<OrangeQuality:Artefato de Afonso+>"
  },
  RelicConfig_70749_StoryDesc = {
    Text = "Diferente do destino incerto, as estrelas têm suas próprias leis"
  },
  RelicConfig_70750_BattleDesc = {
    Text = "Ao ativar 2 cartas consecutivamente com um custo de aritmética maior do que a carta anterior, ganhe [Arg1] <RetaliateIconKeywords:contra-ataque>, podendo ser acionado no máximo 3 vezes por turno."
  },
  RelicConfig_70750_Desc = {
    Text = "Ao ativar 2 cartas consecutivamente com um custo de aritmética maior do que a carta anterior, ganhe [Arg1] <RetaliateIconKeywords:contra-ataque>, podendo ser acionado no máximo 3 vezes por turno."
  },
  RelicConfig_70750_Name = {
    Text = "<WhiteQuality:Registro de Arcano>"
  },
  RelicConfig_70750_StoryDesc = {
    Text = "Tendência do destino"
  },
  RelicConfig_70751_BattleDesc = {
    Text = "Após usar o Despertar da chave de prata, obtenha [Arg1] aritmética e [Arg2] pontos de s-energia."
  },
  RelicConfig_70751_Desc = {
    Text = "Após usar o Despertar da chave de prata, obtenha [Arg1] aritmética e [Arg2] pontos de s-energia."
  },
  RelicConfig_70751_Name = {
    Text = "<WhiteQuality:emblema de mythag>"
  },
  RelicConfig_70751_StoryDesc = {
    Text = "O distintivo distribuído pela Universidade de Mythag aos investigadores. Ele não só simboliza a identidade do portador, mas também é uma ferramenta de comunicação remota"
  },
  RelicConfig_70752_BattleDesc = {
    Text = "Após usar o Despertar da chave de prata, obtenha [Arg1] pontos de <RetaliateIconKeywords:balcão> e [Arg2] pontos de energia de chave de prata."
  },
  RelicConfig_70752_Desc = {
    Text = "Após usar o Despertar da chave de prata, obtenha [Arg1] pontos de <RetaliateIconKeywords:balcão> e [Arg2] pontos de energia de chave de prata."
  },
  RelicConfig_70752_Name = {
    Text = "<WhiteQuality:Fragmento do Sábio>"
  },
  RelicConfig_70752_StoryDesc = {
    Text = "\"Quão tolos são os humanos, acreditando cegamente simplesmente porque é antiquado.\""
  },
  RelicConfig_70753_BattleDesc = {
    Text = "Após o início da batalha, aplique [Arg1] camadas de <VulnerabilityIconKeywords:vulnerável> a todos os inimigos. O efeito é dobrado em combates contra chefes. Todos os despertadores têm um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_70753_Desc = {
    Text = "Após o início da batalha, aplique [Arg1] camadas de <VulnerabilityIconKeywords:vulnerável> a todos os inimigos. O efeito é dobrado em combates contra chefes. Todos os despertadores têm um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_70753_Name = {
    Text = "<OrangeQuality:Ritual da Primavera+>"
  },
  RelicConfig_70753_StoryDesc = {
    Text = "No riso da noite, a silhueta da canoa desliza suavemente sobre o lago"
  },
  RelicConfig_70754_BattleDesc = {
    Text = "Após usar diretamente o \"embrião\" pela primeira vez em cada turno, o dano ativo causará <BleedingIconKeywords:sangramento> equivalente a [Arg1]% do dano neste turno."
  },
  RelicConfig_70754_Desc = {
    Text = "Após usar diretamente o \"embrião\" pela primeira vez em cada turno, o dano ativo causará <BleedingIconKeywords:sangramento> equivalente a [Arg1]% do dano neste turno."
  },
  RelicConfig_70754_Name = {
    Text = "<WhiteQuality:Seixo Ensanguentado>"
  },
  RelicConfig_70754_StoryDesc = {
    Text = "Um, dois, três, quatro, cinco"
  },
  RelicConfig_70755_BattleDesc = {
    Text = "Cada vez que causar dano, ganha [Arg1] de <PowerIconKeywords:força> temporária, até 15 ativações por turno."
  },
  RelicConfig_70755_Desc = {
    Text = "Cada vez que causar dano, ganha [Arg1] de <PowerIconKeywords:força> temporária, até 15 ativações por turno."
  },
  RelicConfig_70755_Name = {
    Text = "<OrangeQuality:Ágata Enrolada+>"
  },
  RelicConfig_70755_StoryDesc = {
    Text = "Provavelmente é apenas um padrão comum de ágata. Acho"
  },
  RelicConfig_70756_BattleDesc = {
    Text = "Após usar o Despertar da chave de prata, obtenha [Arg1] aritmética e [Arg2] pontos de s-energia."
  },
  RelicConfig_70756_Desc = {
    Text = "Após usar o Despertar da chave de prata, obtenha [Arg1] aritmética e [Arg2] pontos de s-energia."
  },
  RelicConfig_70756_Name = {
    Text = "<OrangeQuality:Medalha de Misago+>"
  },
  RelicConfig_70756_StoryDesc = {
    Text = "O distintivo distribuído pela Universidade de Mythag aos investigadores. Ele não só simboliza a identidade do portador, mas também é uma ferramenta de comunicação remota"
  },
  RelicConfig_70757_BattleDesc = {
    Text = "Use a postura Torrente de Raiva para imediatamente ativar todos os tentáculos para atacar o inimigo [Arg1] vezes, com 3 turnos de tempo de recarga."
  },
  RelicConfig_70757_Desc = {
    Text = "Use a postura Torrente de Raiva para imediatamente ativar todos os tentáculos para atacar o inimigo [Arg1] vezes, com 3 turnos de tempo de recarga."
  },
  RelicConfig_70757_Name = {
    Text = "<WhiteQuality:Prazer do vórtice>"
  },
  RelicConfig_70757_StoryDesc = {
    Text = "Senhor do Sono, aguarda-te no sonho"
  },
  RelicConfig_70758_BattleDesc = {
    Text = "Ao ativar 2 cartas consecutivamente com um custo de aritmética menor do que a carta anterior, aplique [Arg1] camadas de <IntoxicationIconKeywords:veneno> a todos os inimigos, podendo ser acionado no máximo 3 vezes por turno."
  },
  RelicConfig_70758_Desc = {
    Text = "Ao ativar 2 cartas consecutivamente com um custo de aritmética menor do que a carta anterior, aplique [Arg1] camadas de <IntoxicationIconKeywords:veneno> a todos os inimigos, podendo ser acionado no máximo 3 vezes por turno."
  },
  RelicConfig_70758_Name = {
    Text = "<WhiteQuality:Relíquia Arcana>"
  },
  RelicConfig_70758_StoryDesc = {
    Text = "Fim do destino"
  },
  RelicConfig_70759_BattleDesc = {
    Text = "Após o início da batalha, aplique [Arg1] camadas de <WeaknessIconKeywords:fraqueza> a todos os inimigos. O efeito é dobrado em batalhas contra chefes. Todos os despertadores têm um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_70759_Desc = {
    Text = "Após o início da batalha, aplique [Arg1] camadas de <WeaknessIconKeywords:fraqueza> a todos os inimigos. O efeito é dobrado em batalhas contra chefes. Todos os despertadores têm um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_70759_Name = {
    Text = "<WhiteQuality:Menino Travesso>"
  },
  RelicConfig_70759_StoryDesc = {
    Text = "Nascido do puro mal, mesmo que não fosse sua vontade"
  },
  RelicConfig_70760_BattleDesc = {
    Text = "No início da batalha, aplique [Arg1] camadas de <IntoxicationIconKeywords:veneno> a todos os inimigos. O efeito é dobrado em combates contra chefes."
  },
  RelicConfig_70760_Desc = {
    Text = "No início da batalha, aplique [Arg1] camadas de <IntoxicationIconKeywords:veneno> a todos os inimigos. O efeito é dobrado em combates contra chefes."
  },
  RelicConfig_70760_Name = {
    Text = "<WhiteQuality:Neurotoxina>"
  },
  RelicConfig_70760_StoryDesc = {
    Text = "Extrair, destilar"
  },
  RelicConfig_70761_BattleDesc = {
    Text = "Após o início da batalha, aplique [Arg1] camadas de <VulnerabilityIconKeywords:vulnerável> a todos os inimigos. O efeito é dobrado em combates contra chefes. Todos os despertadores têm um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_70761_Desc = {
    Text = "Após o início da batalha, aplique [Arg1] camadas de <VulnerabilityIconKeywords:vulnerável> a todos os inimigos. O efeito é dobrado em combates contra chefes. Todos os despertadores têm um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_70761_Name = {
    Text = "<WhiteQuality:Ritual da Primavera>"
  },
  RelicConfig_70761_StoryDesc = {
    Text = "No riso da noite, a silhueta da canoa desliza suavemente sobre o lago"
  },
  RelicConfig_70762_BattleDesc = {
    Text = "Após liberar 4 explosões de loucura em uma rodada, ganhe [Arg1] pontos de aritmética. Recarga em 3 turnos."
  },
  RelicConfig_70762_Desc = {
    Text = "Após liberar 4 explosões de loucura em uma rodada, ganhe [Arg1] pontos de aritmética. Recarga em 3 turnos."
  },
  RelicConfig_70762_Name = {
    Text = "<OrangeQuality:Diferencial Prateado+>"
  },
  RelicConfig_70762_StoryDesc = {
    Text = "\"Mudou a história.\""
  },
  RelicConfig_70763_BattleDesc = {
    Text = "Após liberar a \"exaltação\", ganhe [Arg1] pontos de <PowerIconKeywords:poder> temporários."
  },
  RelicConfig_70763_Desc = {
    Text = "Após liberar a \"exaltação\", ganhe [Arg1] pontos de <PowerIconKeywords:poder> temporários."
  },
  RelicConfig_70763_Name = {
    Text = "<WhiteQuality:Tranca Pesada>"
  },
  RelicConfig_70763_StoryDesc = {
    Text = "Uma fechadura grossa e robusta, difícil de abrir sem chave.\nClaro, para um mestre ladrão, isso não é nada"
  },
  RelicConfig_70764_BattleDesc = {
    Text = "Ao ser atacado por um inimigo, causa [Arg1] de Dano Fixo a ele. Este Dano usufrui de um bônus de [Arg2]% de <RetaliateIconKeywords:Contador>. Cada inimigo pode acionar este efeito até 1 vez por turno."
  },
  RelicConfig_70764_Desc = {
    Text = "Ao ser atacado por um inimigo, causa Dano Fixo igual a [Arg3]% da Vida máxima da equipe. Este Dano usufrui de um bônus de [Arg2]% de <RetaliateIconKeywords:Contador>. Cada inimigo pode acionar este efeito até 1 vez por turno."
  },
  RelicConfig_70764_Name = {
    Text = "<WhiteQuality:Faca Cerimonial Perdida>"
  },
  RelicConfig_70764_StoryDesc = {
    Text = "Uma adaga de lâmina curva, usada em rituais"
  },
  RelicConfig_70765_BattleDesc = {
    Text = "Cada vez que causar dano, ganha [Arg1] de <PowerIconKeywords:força> temporária, até 15 ativações por turno."
  },
  RelicConfig_70765_Desc = {
    Text = "Cada vez que causar dano, ganha [Arg1] de <PowerIconKeywords:força> temporária, até 15 ativações por turno."
  },
  RelicConfig_70765_Name = {
    Text = "<WhiteQuality:Ágata Enrolada>"
  },
  RelicConfig_70765_StoryDesc = {
    Text = "Provavelmente é apenas um padrão comum de ágata. Acho"
  },
  RelicConfig_70766_BattleDesc = {
    Text = "No início do turno, se a vida estiver abaixo de 25%, ganhe [Arg1] pontos de escudo."
  },
  RelicConfig_70766_Desc = {
    Text = "No início do turno, se a vida estiver abaixo de 25%, ganhe [Arg1] pontos de escudo."
  },
  RelicConfig_70766_Name = {
    Text = "<WhiteQuality:Mão Protetora>"
  },
  RelicConfig_70766_StoryDesc = {
    Text = "Mãos de bênção, punhos firmes"
  },
  RelicConfig_70767_BattleDesc = {
    Text = "Aniquilação faz o Despertado com menos loucura ganhar [Arg1] pontos de loucura, resfriamento de 3 turnos."
  },
  RelicConfig_70767_Desc = {
    Text = "Aniquilação faz o Despertado com menos loucura ganhar [Arg1] pontos de loucura, resfriamento de 3 turnos."
  },
  RelicConfig_70767_Name = {
    Text = "<WhiteQuality:Verme do Tempo>"
  },
  RelicConfig_70767_StoryDesc = {
    Text = "Um relógio de bolso que existe tanto na loja de relógios quanto no museu de insetos.\nApós o início da era Hongji, foi adicionado à coleção da universidade"
  },
  RelicConfig_70768_BattleDesc = {
    Text = "Após o início da batalha, ganhe [Arg1] <ProficientInRealmsIconKeywords:Maestria em Domínios>. Todos os <RetaliateIconKeywords:balcão> causados pelos despertadores e pelas criações aumentam em [Arg2]%."
  },
  RelicConfig_70768_Desc = {
    Text = "Após o início da batalha, ganhe [Arg1] <ProficientInRealmsIconKeywords:Maestria em Domínios>. Todos os <RetaliateIconKeywords:balcão> causados pelos despertadores e pelas criações aumentam em [Arg2]%."
  },
  RelicConfig_70768_Name = {
    Text = "<OrangeQuality:Franqueza+>"
  },
  RelicConfig_70768_StoryDesc = {
    Text = "Ele transmitiu inúmeros segredos, ativos ou passivos"
  },
  RelicConfig_70769_BattleDesc = {
    Text = "Após usar diretamente o \"embrião\" pela primeira vez em cada turno, o dano ativo causará <BleedingIconKeywords:sangramento> equivalente a [Arg1]% do dano neste turno."
  },
  RelicConfig_70769_Desc = {
    Text = "Após usar diretamente o \"embrião\" pela primeira vez em cada turno, o dano ativo causará <BleedingIconKeywords:sangramento> equivalente a [Arg1]% do dano neste turno."
  },
  RelicConfig_70769_Name = {
    Text = "<OrangeQuality:Seixo Ensanguentado+>"
  },
  RelicConfig_70769_StoryDesc = {
    Text = "Um, dois, três, quatro, cinco"
  },
  RelicConfig_70770_BattleDesc = {
    Text = "No início do turno, compre [Arg1] cartas"
  },
  RelicConfig_70770_Desc = {
    Text = "No início do turno, compre [Arg1] cartas"
  },
  RelicConfig_70770_Name = {
    Text = "<WhiteQuality:Bússola Direcional>"
  },
  RelicConfig_70770_StoryDesc = {
    Text = "Não aponta direção, apenas campo magnético"
  },
  RelicConfig_70771_BattleDesc = {
    Text = "\"Golpe\" causa adicionalmente 2 vezes dano equivalente a [Arg1]% do ataque do despertado, podendo ser ativado no máximo 3 vezes por rodada."
  },
  RelicConfig_70771_Desc = {
    Text = "\"Golpe\" causa adicionalmente 2 vezes dano equivalente a [Arg1]% do ataque do despertado, podendo ser ativado no máximo 3 vezes por rodada."
  },
  RelicConfig_70771_Name = {
    Text = "<OrangeQuality:Faca de Salgueiro Enferrujada+>"
  },
  RelicConfig_70771_StoryDesc = {
    Text = "Não é adequado para cortar tecido vivo"
  },
  RelicConfig_70772_BattleDesc = {
    Text = "Após usar o Despertar da chave de prata, compre [Arg1] cartas e ganhe [Arg2] pontos de energia de chave de prata."
  },
  RelicConfig_70772_Desc = {
    Text = "Após usar o Despertar da chave de prata, compre [Arg1] cartas e ganhe [Arg2] pontos de energia de chave de prata."
  },
  RelicConfig_70772_Name = {
    Text = "<WhiteQuality:Carteira Nova>"
  },
  RelicConfig_70772_StoryDesc = {
    Text = "Uma carteira de couro com o emblema da universidade de Mythag.\nEstá agora completamente vazia, sem nada dentro"
  },
  RelicConfig_70774_BattleDesc = {
    Text = "O dano causado nas cinco primeiras ocorrências de cada turno aumenta em [Arg1]%."
  },
  RelicConfig_70774_Desc = {
    Text = "O dano causado nas cinco primeiras ocorrências de cada turno aumenta em [Arg1]%."
  },
  RelicConfig_70774_Name = {
    Text = "<WhiteQuality:Corretor de Visão>"
  },
  RelicConfig_70774_StoryDesc = {
    Text = "Alguém uma vez encontrou a verdade através dele"
  },
  RelicConfig_70776_BattleDesc = {
    Text = "No início da batalha, ganhe [Arg1] <RetaliateIconKeywords:contra-ataque>, o efeito é dobrado em batalhas contra chefes."
  },
  RelicConfig_70776_Desc = {
    Text = "No início da batalha, ganhe [Arg1] <RetaliateIconKeywords:contra-ataque>, o efeito é dobrado em batalhas contra chefes."
  },
  RelicConfig_70776_Name = {
    Text = "<WhiteQuality:Colete de Urtiga>"
  },
  RelicConfig_70776_StoryDesc = {
    Text = "Não pode identificar o líquido contaminado"
  },
  RelicConfig_70777_BattleDesc = {
    Text = "Após jogar 4 Cartas de Comando pertencentes a Despertadores diferentes em um único turno, todos os Despertadores ganham [Arg1] de Aliemus, com um tempo de recarga de 3 turnos."
  },
  RelicConfig_70777_Desc = {
    Text = "Após jogar 4 Cartas de Comando pertencentes a Despertadores diferentes em um único turno, todos os Despertadores ganham [Arg1] de Aliemus, com um tempo de recarga de 3 turnos."
  },
  RelicConfig_70777_Name = {
    Text = "<WhiteQuality:Véu do Deus Sem Nome>"
  },
  RelicConfig_70777_StoryDesc = {
    Text = "Não olhe diretamente para o deus"
  },
  RelicConfig_70778_BattleDesc = {
    Text = "No início da batalha, aplique [Arg1] camadas de <IntoxicationIconKeywords:veneno> a todos os inimigos. O efeito é dobrado em combates contra chefes."
  },
  RelicConfig_70778_Desc = {
    Text = "No início da batalha, aplique [Arg1] camadas de <IntoxicationIconKeywords:veneno> a todos os inimigos. O efeito é dobrado em combates contra chefes."
  },
  RelicConfig_70778_Name = {
    Text = "<OrangeQuality:Neurotoxina+>"
  },
  RelicConfig_70778_StoryDesc = {
    Text = "Extrair, destilar"
  },
  RelicConfig_70779_BattleDesc = {
    Text = "Após usar o Despertar da Chave de Prata, aplique [Arg1] níveis de <IntoxicationIconKeywords:veneno> a todos os inimigos e ganhe [Arg2] pontos de energia de prata."
  },
  RelicConfig_70779_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, aplique [Arg1] níveis de <IntoxicationIconKeywords:veneno> a todos os inimigos e ganhe [Arg2] pontos de energia de prata."
  },
  RelicConfig_70779_Name = {
    Text = "<WhiteQuality:Pomada Suspeita>"
  },
  RelicConfig_70779_StoryDesc = {
    Text = "Um ungüento caseiro para feridas, não use sem orientação médica"
  },
  RelicConfig_70780_BattleDesc = {
    Text = "\"Golpe\" aplica <IntoxicationIconKeywords:veneno> equivalente a [Arg1]% do dano causado, no máximo [Arg2] pontos por turno."
  },
  RelicConfig_70780_Desc = {
    Text = "\"Golpe\" aplica <IntoxicationIconKeywords:veneno> equivalente a [Arg1]% do dano causado, no máximo [Arg2] pontos por turno."
  },
  RelicConfig_70780_Name = {
    Text = "<WhiteQuality:Língua Estranha>"
  },
  RelicConfig_70780_StoryDesc = {
    Text = "Ele não é um demônio, mas transmite sussurros de além do mundo"
  },
  RelicConfig_70781_BattleDesc = {
    Text = "No início do turno, se a vida estiver abaixo de 25%, ganhe [Arg1] pontos de escudo."
  },
  RelicConfig_70781_Desc = {
    Text = "No início do turno, se a vida estiver abaixo de 25%, ganhe [Arg1] pontos de escudo."
  },
  RelicConfig_70781_Name = {
    Text = "<OrangeQuality:Mão Protetora+>"
  },
  RelicConfig_70781_StoryDesc = {
    Text = "Mãos de bênção, punhos firmes"
  },
  RelicConfig_70782_BattleDesc = {
    Text = "Perder vida para obter [Arg1]% da quantidade de vida perdida na fornalha carmesim."
  },
  RelicConfig_70782_Desc = {
    Text = "Perder vida para obter [Arg1]% da quantidade de vida perdida na fornalha carmesim."
  },
  RelicConfig_70782_Name = {
    Text = "<OrangeQuality:Serra de Aço Enferrujada+>"
  },
  RelicConfig_70782_StoryDesc = {
    Text = "O doutor da dissecação passou a vida sem ver uma bela mulher, apenas um saco cheio de ossos, nervos inflamados por doenças, músculos e tecidos"
  },
  RelicConfig_70783_BattleDesc = {
    Text = "O dano causado nas cinco primeiras ocorrências de cada turno aumenta em [Arg1]%."
  },
  RelicConfig_70783_Desc = {
    Text = "O dano causado nas cinco primeiras ocorrências de cada turno aumenta em [Arg1]%."
  },
  RelicConfig_70783_Name = {
    Text = "<OrangeQuality:Corretor de Visão+>"
  },
  RelicConfig_70783_StoryDesc = {
    Text = "Alguém uma vez encontrou a verdade através dele"
  },
  RelicConfig_70784_BattleDesc = {
    Text = "Sempre que uma carta entra no espaço ultra-dimensional, se esta carta pertencer a um proprietário diferente de outras cartas ultra-dimensionais, coloque [Arg1] <DerivativeCardKeywords_4:\"Inspiração\"> cartas na mão."
  },
  RelicConfig_70784_Desc = {
    Text = "Sempre que uma carta entra no espaço ultra-dimensional, se esta carta pertencer a um proprietário diferente de outras cartas ultra-dimensionais, coloque [Arg1] <DerivativeCardKeywords_4:\"Inspiração\"> cartas na mão."
  },
  RelicConfig_70784_Name = {
    Text = "<WhiteQuality:Artefato de Afonso>"
  },
  RelicConfig_70784_StoryDesc = {
    Text = "Diferente do destino incerto, as estrelas têm suas próprias leis"
  },
  RelicConfig_70785_BattleDesc = {
    Text = "Após jogar 4 Cartas de Comando pertencentes a Despertadores diferentes em um único turno, todos os Despertadores ganham [Arg1] de Aliemus, com um tempo de recarga de 3 turnos."
  },
  RelicConfig_70785_Desc = {
    Text = "Após jogar 4 Cartas de Comando pertencentes a Despertadores diferentes em um único turno, todos os Despertadores ganham [Arg1] de Aliemus, com um tempo de recarga de 3 turnos."
  },
  RelicConfig_70785_Name = {
    Text = "<OrangeQuality:Véu do Deus Anônimo+>"
  },
  RelicConfig_70785_StoryDesc = {
    Text = "Não olhe diretamente para o deus"
  },
  RelicConfig_70786_BattleDesc = {
    Text = "No final do turno, se estiver na postura de maré alta, ganhe [Arg1] <TentacleInjurieIconKeywords:dano de tentáculo>, com 3 turnos de tempo de recarga."
  },
  RelicConfig_70786_Desc = {
    Text = "No final do turno, se estiver na postura de maré alta, ganhe [Arg1] <TentacleInjurieIconKeywords:dano de tentáculo>, com 3 turnos de tempo de recarga."
  },
  RelicConfig_70786_Name = {
    Text = "<WhiteQuality:Cisticerco>"
  },
  RelicConfig_70786_StoryDesc = {
    Text = "Só se nosso cérebro ainda for um mistério, não há nada de surpreendente em ter tentáculos crescendo nele"
  },
  RelicConfig_70787_BattleDesc = {
    Text = "Todos os despertos têm um aumento de [Arg1]% no dano base causado."
  },
  RelicConfig_70787_Desc = {
    Text = "Todos os despertos têm um aumento de [Arg1]% no dano base causado."
  },
  RelicConfig_70787_Name = {
    Text = "<OrangeQuality:Cachimbo Chorão+>"
  },
  RelicConfig_70787_StoryDesc = {
    Text = "Isso é fruto do ódio ou resultado da vingança?"
  },
  RelicConfig_70788_BattleDesc = {
    Text = "Após usar o Despertar da Chave de Prata, todos os Despertados ganham [Arg1] pontos de loucura e [Arg2] pontos de s-energia."
  },
  RelicConfig_70788_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, todos os Despertados ganham [Arg1] pontos de loucura e [Arg2] pontos de s-energia."
  },
  RelicConfig_70788_Name = {
    Text = "<WhiteQuality:Abotoadura de Louro>"
  },
  RelicConfig_70788_StoryDesc = {
    Text = "Abotoaduras de prata com padrão de folhas de louro.\nElas são bem feitas, brilhantes, e uma vez simbolizaram a amizade de duas crianças"
  },
  RelicConfig_70789_BattleDesc = {
    Text = "Após o início da batalha, ganhe [Arg1] <ProficientInRealmsIconKeywords:Maestria em Domínios>. Todos os despertadores têm um aumento de [Arg2]% no <IntoxicationIconKeywords:veneno> causado e no <IntoxicationIconKeywords:veneno> causado pelas relíquias."
  },
  RelicConfig_70789_Desc = {
    Text = "Após o início da batalha, ganhe [Arg1] <ProficientInRealmsIconKeywords:Maestria em Domínios>. Todos os despertadores têm um aumento de [Arg2]% no <IntoxicationIconKeywords:veneno> causado e no <IntoxicationIconKeywords:veneno> causado pelas relíquias."
  },
  RelicConfig_70789_Name = {
    Text = "<WhiteQuality:Máquina de Costura empoeirada>"
  },
  RelicConfig_70789_StoryDesc = {
    Text = "Uma mãe carinhosa, remendando as feridas do coração"
  },
  RelicConfig_70790_BattleDesc = {
    Text = "Aniquilação faz o Despertado com menos loucura ganhar [Arg1] pontos de loucura, resfriamento de 3 turnos."
  },
  RelicConfig_70790_Desc = {
    Text = "Aniquilação faz o Despertado com menos loucura ganhar [Arg1] pontos de loucura, resfriamento de 3 turnos."
  },
  RelicConfig_70790_Name = {
    Text = "<OrangeQuality:Verme do Tempo+>"
  },
  RelicConfig_70790_StoryDesc = {
    Text = "Um relógio de bolso que existe tanto na loja de relógios quanto no museu de insetos.\nApós o início da era Hongji, foi adicionado à coleção da universidade"
  },
  RelicConfig_70791_BattleDesc = {
    Text = "No início da batalha, limite de tentáculos aumentado em [Arg1]. Ganhe [Arg2] tentáculos."
  },
  RelicConfig_70791_Desc = {
    Text = "No início da batalha, limite de tentáculos aumentado em [Arg1]. Ganhe [Arg2] tentáculos."
  },
  RelicConfig_70791_Name = {
    Text = "<OrangeQuality:Canção do Mar+>"
  },
  RelicConfig_70791_StoryDesc = {
    Text = "Dizem que animais não comestíveis como o caramujo de tecido absorvem cerca de 80% dos nutrientes do oceano"
  },
  RelicConfig_70792_BattleDesc = {
    Text = "No final do turno, se estiver na postura de maré alta, ganhe [Arg1] <TentacleInjurieIconKeywords:dano de tentáculo>, com 3 turnos de tempo de recarga."
  },
  RelicConfig_70792_Desc = {
    Text = "No final do turno, se estiver na postura de maré alta, ganhe [Arg1] <TentacleInjurieIconKeywords:dano de tentáculo>, com 3 turnos de tempo de recarga."
  },
  RelicConfig_70792_Name = {
    Text = "<OrangeQuality:Cisticerco+>"
  },
  RelicConfig_70792_StoryDesc = {
    Text = "Só se nosso cérebro ainda for um mistério, não há nada de surpreendente em ter tentáculos crescendo nele"
  },
  RelicConfig_70793_BattleDesc = {
    Text = "Na primeira vez que <DevouredIconKeywords:devorar> ocorrer em um turno, outros Despertados ganham [Arg1] Loucura."
  },
  RelicConfig_70793_Desc = {
    Text = "Na primeira vez que <DevouredIconKeywords:devorar> ocorrer em um turno, outros Despertados ganham [Arg1] Loucura."
  },
  RelicConfig_70793_Name = {
    Text = "<OrangeQuality:Sonho Dourado+>"
  },
  RelicConfig_70793_StoryDesc = {
    Text = "O dia da metamorfose será o seu fim"
  },
  RelicConfig_70794_BattleDesc = {
    Text = "Aniquilação: obtenha [Arg1] escudo, com recarga de 3 turnos."
  },
  RelicConfig_70794_Desc = {
    Text = "Aniquilação: obtenha [Arg1] escudo, com recarga de 3 turnos."
  },
  RelicConfig_70794_Name = {
    Text = "<OrangeQuality:Relógio de Bolso Supercorda+>"
  },
  RelicConfig_70794_StoryDesc = {
    Text = "\"\"Oh não, o relógio de bolso parou.\""
  },
  RelicConfig_70795_BattleDesc = {
    Text = "Após jogar uma carta de comando não derivada, embaralhe [Arg1] cópias temporárias dessa carta com custo de aritmética reduzido em 2 no baralho de compra, com tempo de recarga de 3 turnos."
  },
  RelicConfig_70795_Desc = {
    Text = "Após jogar uma carta de comando não derivada, embaralhe [Arg1] cópias temporárias dessa carta com custo de aritmética reduzido em 2 no baralho de compra, com tempo de recarga de 3 turnos."
  },
  RelicConfig_70795_Name = {
    Text = "<WhiteQuality:Vitrola Muda>"
  },
  RelicConfig_70795_StoryDesc = {
    Text = "Sua voz desapareceu no vento"
  },
  RelicConfig_70796_BattleDesc = {
    Text = "Após usar \"Fúria Explosiva,\" todos os inimigos recebem [Arg1] de <FixedDamage:Dano Puro> e acionam [Arg2]% de <IntoxicationIconKeywords:Envenenamento>."
  },
  RelicConfig_70796_Desc = {
    Text = "Após usar \"Fúria Explosiva,\" todos os inimigos recebem 1 instância de <FixedDamage:Dano Puro> igual a [Arg2]% da Vida máxima da equipe e acionam [Arg2]% de <IntoxicationIconKeywords:Envenenamento>."
  },
  RelicConfig_70796_Name = {
    Text = "<OrangeQuality:Mandíbula a Laser+>"
  },
  RelicConfig_70796_StoryDesc = {
    Text = "Ossos exibidos na galeria privada de um colecionador.\nO colecionador era fascinado pelo brilho bonito, admirando-o dia e noite, até morrer e se tornar um deles"
  },
  RelicConfig_70797_BattleDesc = {
    Text = "A saúde máxima aritmética aumenta em [Arg1]."
  },
  RelicConfig_70797_Desc = {
    Text = "A saúde máxima aritmética aumenta em [Arg1]."
  },
  RelicConfig_70797_Name = {
    Text = "<WhiteQuality:injeção ativa>"
  },
  RelicConfig_70797_StoryDesc = {
    Text = "Espasmos também são uma forma de atividade"
  },
  RelicConfig_70798_BattleDesc = {
    Text = "Use a postura Torrente de Raiva para imediatamente ativar todos os tentáculos para atacar o inimigo [Arg1] vezes, com 3 turnos de tempo de recarga."
  },
  RelicConfig_70798_Desc = {
    Text = "Use a postura Torrente de Raiva para imediatamente ativar todos os tentáculos para atacar o inimigo [Arg1] vezes, com 3 turnos de tempo de recarga."
  },
  RelicConfig_70798_Name = {
    Text = "<OrangeQuality:Prazer da Espiral+>"
  },
  RelicConfig_70798_StoryDesc = {
    Text = "Senhor do Sono, aguarda-te no sonho"
  },
  RelicConfig_70799_BattleDesc = {
    Text = "Defesa ganha [Arg1] <RetaliateIconKeywords:contra-ataque> temporário, com um máximo de 3 ativações por turno."
  },
  RelicConfig_70799_Desc = {
    Text = "Defesa ganha [Arg1] <RetaliateIconKeywords:contra-ataque> temporário, com um máximo de 3 ativações por turno."
  },
  RelicConfig_70799_Name = {
    Text = "<OrangeQuality:Relógio de Bolso de um Velho Amigo+>"
  },
  RelicConfig_70799_StoryDesc = {
    Text = "Com saudade e tristeza, avance para o desconhecido"
  },
  RelicConfig_70800_BattleDesc = {
    Text = "Defesa ganha [Arg1] <RetaliateIconKeywords:contra-ataque> temporário, com um máximo de 3 ativações por turno."
  },
  RelicConfig_70800_Desc = {
    Text = "Defesa ganha [Arg1] <RetaliateIconKeywords:contra-ataque> temporário, com um máximo de 3 ativações por turno."
  },
  RelicConfig_70800_Name = {
    Text = "<WhiteQuality:Relógio de Bolso do Amigo>"
  },
  RelicConfig_70800_StoryDesc = {
    Text = "Com saudade e tristeza, avance para o desconhecido"
  },
  RelicConfig_70986_BattleDesc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1 e todos os despertadores despertam. No início dos turnos ímpares, escolha 1 entre 2 relíquias para obter, efeito que dura por 5 turnos ímpares."
  },
  RelicConfig_70986_Desc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1 e todos os despertadores despertam. No início dos turnos ímpares, escolha 1 entre 2 relíquias para obter, efeito que dura por 5 turnos ímpares."
  },
  RelicConfig_70986_Name = {
    Text = "<OrangeQuality:Pêndulo do Tempo \"Desejo η\">"
  },
  RelicConfig_70987_BattleDesc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1 e todos os despertadores despertam. No início dos turnos ímpares, escolha 1 entre 2 relíquias para obter, efeito que dura por 5 turnos ímpares."
  },
  RelicConfig_70987_Desc = {
    Text = "No início da batalha, o limite de aritmética aumenta em 1 e todos os despertadores despertam. No início dos turnos ímpares, escolha 1 entre 2 relíquias para obter, efeito que dura por 5 turnos ímpares."
  },
  RelicConfig_70987_Name = {
    Text = "<OrangeQuality:Pêndulo do Tempo \"Desejo ζ\">"
  },
  RelicConfig_71195_BattleDesc = {
    Text = "No início do turno, Ciclo·Ramona ganha [Arg1] pontos de insanidade. Na primeira ativação de \"Ciclo\" em cada turno, ganhe [Arg2] pontos de energia da Chave de Prata e [Arg3] camadas de \"neguentropia\"."
  },
  RelicConfig_71195_Desc = {
    Text = "No início do turno, Ciclo·Ramona ganha [Arg1] pontos de insanidade. Na primeira ativação de \"Ciclo\" em cada turno, ganhe [Arg2] pontos de energia da Chave de Prata e [Arg3] camadas de \"neguentropia\"."
  },
  RelicConfig_71195_Name = {
    Text = "<OrangeQuality:Imagem Dimensional - Circular - Ramona>"
  },
  RelicConfig_71196_BattleDesc = {
    Text = "No início do turno, Lotan ganha [Arg1] pontos de aliemus. Após jogar pela primeira vez a \"Defesa\" de Lotan em cada turno, coloque [Arg2] \"Lâminas Teimosas\" com custo adicional e vazio na mão."
  },
  RelicConfig_71196_Desc = {
    Text = "No início do turno, Lotan ganha [Arg1] pontos de aliemus. Após jogar pela primeira vez a \"Defesa\" de Lotan em cada turno, coloque [Arg2] \"Lâminas Teimosas\" com custo adicional e vazio na mão."
  },
  RelicConfig_71196_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Lutan>"
  },
  RelicConfig_71197_BattleDesc = {
    Text = "No início do turno, Ramona ganha [Arg1] pontos de loucura. A cada [Arg2]ª carta de comando jogada de Ramona, esta carta tem um efeito adicional uma vez e ganha [Arg3] pontos de energia da chave de prata."
  },
  RelicConfig_71197_Desc = {
    Text = "No início do turno, Ramona ganha [Arg1] pontos de loucura. A cada [Arg2]ª carta de comando jogada de Ramona, esta carta tem um efeito adicional uma vez e ganha [Arg3] pontos de energia da chave de prata."
  },
  RelicConfig_71197_Name = {
    Text = "<OrangeQuality:Imagem Dimensional · Lamona>"
  },
  RelicConfig_71230_BattleDesc = {
    Text = "No início do turno, Leigh obtém [Arg1] de Fúria. Sempre que perder Vida, obtém [Arg2] pontos de Força, podendo acumular no máximo [Arg3] vezes por batalha. Após acumular [Arg3] vezes, o consumo de potência de cálculo básico de \"Dor e Alegria\" é reduzido em 2 e o número de vezes de Dano aumenta em 1."
  },
  RelicConfig_71230_Desc = {
    Text = "No início do turno, Leigh obtém [Arg1] de Fúria. Sempre que perder Vida, obtém [Arg2] pontos de Força, podendo acumular no máximo [Arg3] vezes por batalha. Após acumular [Arg3] vezes, o consumo de potência de cálculo básico de \"Dor e Alegria\" é reduzido em 2 e o número de vezes de Dano aumenta em 1."
  },
  RelicConfig_71230_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Reia>"
  },
  RelicConfig_71231_BattleDesc = {
    Text = "No início do turno, Aurita ganha [Arg1] pontos de loucura. A quantidade de vezes que \"Divisão Glandular\" causa dano aumenta em [Arg2]. Após jogar a \"Defesa\" de Aurita, coloque 1 carta de \"Divisão Glandular\" na mão."
  },
  RelicConfig_71231_Desc = {
    Text = "No início do turno, Aurita ganha [Arg1] pontos de loucura. A quantidade de vezes que \"Divisão Glandular\" causa dano aumenta em [Arg2]. Após jogar a \"Defesa\" de Aurita, coloque 1 carta de \"Divisão Glandular\" na mão."
  },
  RelicConfig_71231_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Oureta>"
  },
  RelicConfig_71232_BattleDesc = {
    Text = "No início do turno, Tinta ganha [Arg1] pontos de loucura. Quando uma carta de comando de Tinta é ativada com salto, ela retorna para a mão e seu custo de aritmética é reduzido em 1 antes de ser jogada; este efeito pode ocorrer no máximo [Arg2] vezes por turno."
  },
  RelicConfig_71232_Desc = {
    Text = "No início do turno, Tinta ganha [Arg1] pontos de loucura. Quando uma carta de comando de Tinta é ativada com salto, ela retorna para a mão e seu custo de aritmética é reduzido em 1 antes de ser jogada; este efeito pode ocorrer no máximo [Arg2] vezes por turno."
  },
  RelicConfig_71232_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Tinkter>"
  },
  RelicConfig_71233_BattleDesc = {
    Text = "No início do turno, Nodira ganha [Arg1] pontos de loucura. Após liberar a \"exaltação da loucura\" de Nodira, obtenha uma quantidade de contra-ataque e escudo retardado equivalente a [Arg2]% do escudo atual, podendo ser acionado uma vez por turno."
  },
  RelicConfig_71233_Desc = {
    Text = "No início do turno, Nautila ganha [Arg1] pontos de Fúria. Após liberar a \"Fúria Explosiva\" de Nautila, obtenha Contrataque e Escudo de latência equivalentes a [Arg2]% do Escudo do personagem atual, podendo ser acionado no máximo uma vez por turno."
  },
  RelicConfig_71233_Name = {
    Text = "<OrangeQuality:Projeção Dimensional·Náutila>"
  },
  RelicConfig_71234_BattleDesc = {
    Text = "No início do turno, a Doll de Fusão ganha [Arg1] pontos de loucura. Após a Doll de Fusão liberar a explosão de loucura, para cada [Arg2] pontos de loucura consumidos, os outros despertadores ganham 1 ponto de loucura."
  },
  RelicConfig_71234_Desc = {
    Text = "No início do turno, Doll: Inferno ganha [Arg1] pontos de Fúria. Após Doll: Inferno liberar a Fúria Explosiva, para cada [Arg2] pontos de Fúria consumidos, os outros Corpos Despertos ganham 1 ponto de Fúria."
  },
  RelicConfig_71234_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Fusão·Dore>"
  },
  RelicConfig_71235_BattleDesc = {
    Text = "No início do turno, Hilota ganha [Arg1] de loucura. Sempre que uma carta é descartada, Hilota ganha [Arg2] de loucura."
  },
  RelicConfig_71235_Desc = {
    Text = "No início do turno, Hilota ganha [Arg1] de loucura. Sempre que uma carta é descartada, Hilota ganha [Arg2] de loucura."
  },
  RelicConfig_71235_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Hílò>"
  },
  RelicConfig_71236_BattleDesc = {
    Text = "No início do turno, Dafodil ganha [Arg1] pontos de loucura e 1 carta \"Inspiração\". O poder concedido por \"Maré Heterogênea\" é aumentado em [Arg2]%; cada vez que é jogada, aumenta permanentemente em [Arg3]% adicional durante a exploração atual, com um máximo de [Arg4]%."
  },
  RelicConfig_71236_Desc = {
    Text = "No início do turno, Dafodil ganha [Arg1] pontos de loucura e 1 carta \"Inspiração\". O poder concedido por \"Maré Heterogênea\" é aumentado em [Arg2]%; cada vez que é jogada, aumenta permanentemente em [Arg3]% adicional durante a exploração atual, com um máximo de [Arg4]%."
  },
  RelicConfig_71236_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Daphne>"
  },
  RelicConfig_71237_BattleDesc = {
    Text = "No início do turno, Wanda ganha [Arg1] de insanidade e [Arg2] níveis de \"Sonhador\". Se for o turno de hiperversão, adicione adicionalmente 1 carta temporária \"Corrente de Espinhos\" e \"Guardião Perdido\" à sua mão e faça com que o próximo card de comando de Wanda tenha efeito duplicado."
  },
  RelicConfig_71237_Desc = {
    Text = "No início do turno, Wanda ganha [Arg1] de insanidade e [Arg2] níveis de \"Sonhador\". Se for o turno de hiperversão, adicione adicionalmente 1 carta temporária \"Corrente de Espinhos\" e \"Guardião Perdido\" à sua mão e faça com que o próximo card de comando de Wanda tenha efeito duplicado."
  },
  RelicConfig_71237_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Vanda>"
  },
  RelicConfig_71238_BattleDesc = {
    Text = "Ao iniciar o turno, Agrippa ganha [Arg1] pontos de aliemus. \"A caridade impaciente\" também reduz o consumo de aritmética de Agrippa em [Arg2] durante este turno, e pode ser ativada apenas 1 vez por turno."
  },
  RelicConfig_71238_Desc = {
    Text = "Ao iniciar o turno, Agrippa ganha [Arg1] pontos de aliemus. \"A caridade impaciente\" também reduz o consumo de aritmética de Agrippa em [Arg2] durante este turno, e pode ser ativada apenas 1 vez por turno."
  },
  RelicConfig_71238_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Agripa>"
  },
  RelicConfig_71239_BattleDesc = {
    Text = "Ao início do turno, \"24\" ganha [Arg1] de exaltação. Ao início do turno, se \"24\" estiver na \"Personalidade Depressiva\", ganha [Arg2] de exaltação adicional; se estiver na \"Personalidade Maníaca\", aumenta temporariamente a taxa de crítico e o dano crítico de \"24\" em [Arg2]%."
  },
  RelicConfig_71239_Desc = {
    Text = "Ao início do turno, \"24\" ganha [Arg1] de exaltação. Ao início do turno, se \"24\" estiver na \"Personalidade Depressiva\", ganha [Arg2] de exaltação adicional; se estiver na \"Personalidade Maníaca\", aumenta temporariamente a taxa de crítico e o dano crítico de \"24\" em [Arg2]%."
  },
  RelicConfig_71239_Name = {
    Text = "<OrangeQuality:Imagem Dimensional · \"24\">"
  },
  RelicConfig_71240_BattleDesc = {
    Text = "Ao iniciar o turno, Liz ganha [Arg1] pontos de loucura. \"Dança para a destruição\" faz com que as cartas descartadas tenham 1 efeito adicional, com recarga de 3 turnos."
  },
  RelicConfig_71240_Desc = {
    Text = "Ao iniciar o turno, Liz ganha [Arg1] pontos de loucura. \"Dança para a destruição\" faz com que as cartas descartadas tenham 1 efeito adicional, com recarga de 3 turnos."
  },
  RelicConfig_71240_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Liz>"
  },
  RelicConfig_71241_BattleDesc = {
    Text = "Ao iniciar a rodada, Corrente de Sangue: Hilota ganha [Arg1] pontos de loucura. O dano ativo de Corrente de Sangue: Hilota aplica [Arg2]% de sangramento e, após matar um inimigo, causa sangramento aos outros inimigos equivalente ao dano excedente."
  },
  RelicConfig_71241_Desc = {
    Text = "No início do turno, Helot: Catena ganha [Arg1] de Fúria. O Dano ativo de Helot: Catena aplica [Arg2]% de Sangramento, e ao matar um inimigo, causa Sangramento aos outros inimigos equivalente ao Dano excedente."
  },
  RelicConfig_71241_Name = {
    Text = "<OrangeQuality:Imagem Dimensional - Corrente de Sangue - Shiro>"
  },
  RelicConfig_71242_BattleDesc = {
    Text = "No início do turno, Celeste ganha [Arg1] de Fúria. Antes do final do turno, para cada Carta de comando de Celeste na mão, 1 tentáculo ataca o inimigo e recupera [Heal:Arg2] de Vida."
  },
  RelicConfig_71242_Desc = {
    Text = "No início do turno, Celeste ganha [Arg1] de Fúria. Antes do final do turno, para cada Carta de comando de Celeste na mão, 1 tentáculo ataca o inimigo e recupera [Heal:Arg2] de Vida."
  },
  RelicConfig_71242_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Celeste>"
  },
  RelicConfig_71243_BattleDesc = {
    Text = "Ao iniciar a rodada, Casiah ganha [Arg1] pontos de loucura. Para cada carta comprada, Casiah ganha [Arg2] pontos de loucura. Quando Casiah libera a exaltação, todos os inimigos perdem [Arg3] pontos de poder."
  },
  RelicConfig_71243_Desc = {
    Text = "Ao iniciar a rodada, Casiah ganha [Arg1] pontos de loucura. Para cada carta comprada, Casiah ganha [Arg2] pontos de loucura. Quando Casiah libera a exaltação, todos os inimigos perdem [Arg3] pontos de poder."
  },
  RelicConfig_71243_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Cassia>"
  },
  RelicConfig_71244_BattleDesc = {
    Text = "No início do turno, Sorel ganha [Arg1] de Fúria. Cada vez que Sorel causar Dano, a Fusão de embriões aumenta em +[Arg2], com efeito máximo de [Arg3] <plural value=\"[Arg3]\" singular=\"vez\" plural=\"vezes\"> por turno. Após atingir 10 vezes, o Dano Final de Sorel nesta batalha aumenta em +[Arg4]%."
  },
  RelicConfig_71244_Desc = {
    Text = "No início do turno, Sorel ganha [Arg1] de Fúria. Cada vez que Sorel causar Dano, a Fusão de embriões aumenta em +[Arg2], com efeito máximo de [Arg3] <plural value=\"[Arg3]\" singular=\"vez\" plural=\"vezes\"> por turno. Após atingir 10 vezes, o Dano Final de Sorel nesta batalha aumenta em +[Arg4]%."
  },
  RelicConfig_71244_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Sorel>"
  },
  RelicConfig_71245_BattleDesc = {
    Text = "No início do turno, Ogier ganha [Arg1] pontos de loucura. Após jogar pela primeira vez \"Lança Perfurante\" ou \"Golpe\" de Ogier em cada turno, aumente em [Arg2]% os escudos e o poder causados por Ogier neste turno."
  },
  RelicConfig_71245_Desc = {
    Text = "No início do turno, Ogier ganha [Arg1] pontos de loucura. Após jogar pela primeira vez \"Lança Perfurante\" ou \"Golpe\" de Ogier em cada turno, aumente em [Arg2]% os escudos e o poder causados por Ogier neste turno."
  },
  RelicConfig_71245_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Ojir>"
  },
  RelicConfig_71246_BattleDesc = {
    Text = "No início do turno, Elva ganha [Arg1] pontos de loucura. Quando Elva joga a [Arg2]ª carta de \"Defesa\" em 1 turno, coloque 1 \"Lâmina de Precisão\" com custo na mão; ao jogar a [Arg3]ª carta de \"Golpe\", coloque 1 \"Postura de Combate\" com custo na mão."
  },
  RelicConfig_71246_Desc = {
    Text = "No início do turno, Elva ganha [Arg1] pontos de loucura. Quando Elva joga a [Arg2]ª carta de \"Defesa\" em 1 turno, coloque 1 \"Lâmina de Precisão\" com custo na mão; ao jogar a [Arg3]ª carta de \"Golpe\", coloque 1 \"Postura de Combate\" com custo na mão."
  },
  RelicConfig_71246_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Elva>"
  },
  RelicConfig_71247_BattleDesc = {
    Text = "No início do turno, Jenkins ganha [Arg1] pontos de insanidade, dano final +[Arg2]%. O dano base e o dano causado por \"Marrom, ataque!\" aumentam em [Arg3]%."
  },
  RelicConfig_71247_Desc = {
    Text = "No início do turno, Jenkins ganha [Arg1] pontos de insanidade, dano final +[Arg2]%. O dano base e o dano causado por \"Marrom, ataque!\" aumentam em [Arg3]%."
  },
  RelicConfig_71247_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Jenkin>"
  },
  RelicConfig_71248_BattleDesc = {
    Text = "Ao iniciar a rodada, Boneca ganha [Arg1] pontos de aliemus. Após o início da batalha, o custo de aritmética do \"Intercâmbio Equivalente\" de Boneca se torna 0, e após ser jogado, na próxima rodada ela comprará [Arg2] cartas adicionais."
  },
  RelicConfig_71248_Desc = {
    Text = "Ao iniciar a rodada, Boneca ganha [Arg1] pontos de aliemus. Após o início da batalha, o custo de aritmética do \"Intercâmbio Equivalente\" de Boneca se torna 0, e após ser jogado, na próxima rodada ela comprará [Arg2] cartas adicionais."
  },
  RelicConfig_71248_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Dor>"
  },
  RelicConfig_71249_BattleDesc = {
    Text = "No início do turno, Ryker ganha [Arg1] de Fúria. A primeira jogada de dados de cada turno sempre resulta no valor máximo."
  },
  RelicConfig_71249_Desc = {
    Text = "No início do turno, Ryker ganha [Arg1] de Fúria. A primeira jogada de dados de cada turno sempre resulta no valor máximo."
  },
  RelicConfig_71249_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Leke>"
  },
  RelicConfig_71250_BattleDesc = {
    Text = "No início do turno, Miryam ganha [Arg1] de loucura e adiciona 1 \"Sacrário\" à mão."
  },
  RelicConfig_71250_Desc = {
    Text = "No início do turno, Miryam ganha [Arg1] de loucura e adiciona 1 \"Sacrário\" à mão."
  },
  RelicConfig_71250_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Miriam>"
  },
  RelicConfig_71251_BattleDesc = {
    Text = "No início do turno, Wen Ke'er ganha [Arg1] pontos de Loucura. Sempre que outros Despertados usarem uma Exaltação, Wen Ke'er ganha [Arg2] pontos de Loucura e o custo de poder de \"Reconstrução Espiritual\" na mão é reduzido em [Arg3]."
  },
  RelicConfig_71251_Desc = {
    Text = "No início do turno, Wen Ke'er ganha [Arg1] pontos de Loucura. Sempre que outros Despertados usarem uma Exaltação, Wen Ke'er ganha [Arg2] pontos de Loucura e o custo de poder de \"Reconstrução Espiritual\" na mão é reduzido em [Arg3]."
  },
  RelicConfig_71251_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Winkel>"
  },
  RelicConfig_71252_BattleDesc = {
    Text = "No início do turno, Tulu ganha [Arg1] de Fúria. A Fúria Básica de Tulu –[Arg2], e após liberar a Fúria Explosiva, gera instantaneamente [Arg3] tentáculos Temporários."
  },
  RelicConfig_71252_Desc = {
    Text = "No início do turno, Tulu ganha [Arg1] de Fúria. A Fúria Básica de Tulu –[Arg2], e após liberar a Fúria Explosiva, gera instantaneamente [Arg3] tentáculos Temporários."
  },
  RelicConfig_71252_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Turu>"
  },
  RelicConfig_71253_BattleDesc = {
    Text = "No início do turno, Fynt ganha [Arg1] pontos de loucura. Os escudos, ataques retaliatórios e recuperação de vida causados por Fynt aumentam em [Arg2]%. Sempre que a resistência à morte for ativada, este efeito aumenta em [Arg3]% durante a exploração atual, com no máximo [Arg4] ativações."
  },
  RelicConfig_71253_Desc = {
    Text = "No início do turno, Fynt ganha [Arg1] pontos de loucura. Os escudos, ataques retaliatórios e recuperação de vida causados por Fynt aumentam em [Arg2]%. Sempre que a resistência à morte for ativada, este efeito aumenta em [Arg3]% durante a exploração atual, com no máximo [Arg4] ativações."
  },
  RelicConfig_71253_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Fient>"
  },
  RelicConfig_71254_BattleDesc = {
    Text = "No início do turno, Tawil ganha [Arg1] de Aliemus. Se [Arg2] das Cartas de Comando de Tawil forem jogadas em um único turno, adicione 1 <DerivativeCardKeywords_67:\"Chave Prateada do Amanhecer\"> à mão. Tempo de recarga: [Arg3] turnos."
  },
  RelicConfig_71254_Desc = {
    Text = "No início do turno, Tawil ganha [Arg1] de Aliemus. Se [Arg2] das Cartas de Comando de Tawil forem jogadas em um único turno, adicione 1 <DerivativeCardKeywords_67:\"Chave Prateada do Amanhecer\"> à mão. Tempo de recarga: [Arg3] turnos."
  },
  RelicConfig_71254_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Tavi>"
  },
  RelicConfig_71255_BattleDesc = {
    Text = "No início do turno, Hameln obtém [Arg1] de Fúria. O consumo de potência de cálculo básico do \"Pré-lúdio da Alma\" é reduzido em [Arg2] e o número de vezes de Dano básico aumenta em [Arg3]."
  },
  RelicConfig_71255_Desc = {
    Text = "No início do turno, Hameln obtém [Arg1] de Fúria. O consumo de potência de cálculo básico do \"Pré-lúdio da Alma\" é reduzido em [Arg2] e o número de vezes de Dano básico aumenta em [Arg3]."
  },
  RelicConfig_71255_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Hamlin>"
  },
  RelicConfig_71256_BattleDesc = {
    Text = "No início do turno, Horla ganha [Arg1] pontos de loucura. No início da batalha, obtenha [Arg2] camadas de metáfora para cada estado emocional. O efeito de \"metáfora\" aumenta em 50%."
  },
  RelicConfig_71256_Desc = {
    Text = "No início do turno, Horla ganha [Arg1] pontos de loucura. No início da batalha, obtenha [Arg2] camadas de metáfora para cada estado emocional. O efeito de \"metáfora\" aumenta em 50%."
  },
  RelicConfig_71256_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Horla>"
  },
  RelicConfig_71257_BattleDesc = {
    Text = "No início do turno, Murphy ganha [Arg1] pontos de aliemus. O \"golpe\" e a \"defesa\" de Murphy podem converter [Arg2]% do \"sacrifício\" em dano de tentáculo temporário, mas só podem ser ativados uma vez por turno."
  },
  RelicConfig_71257_Desc = {
    Text = "No início do turno, Murphy ganha [Arg1] pontos de aliemus. O \"golpe\" e a \"defesa\" de Murphy podem converter [Arg2]% do \"sacrifício\" em dano de tentáculo temporário, mas só podem ser ativados uma vez por turno."
  },
  RelicConfig_71257_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Murphy>"
  },
  RelicConfig_71258_BattleDesc = {
    Text = "No início do turno, Uvhash ganha [Arg1] de Fúria. A Fúria Básica de Uvhash –[Arg2], e é reduzida em mais –5 a cada vez que libera a Fúria Explosiva. Ele pode liberar a Fúria Explosiva [Arg3] <plural value=\"[Arg3]\" singular=\"vez\" plural=\"vezes\"> por turno."
  },
  RelicConfig_71258_Desc = {
    Text = "No início do turno, Uvhash ganha [Arg1] de Fúria. A Fúria Básica de Uvhash –[Arg2], e é reduzida em mais –5 a cada vez que libera a Fúria Explosiva. Ele pode liberar a Fúria Explosiva [Arg3] <plural value=\"[Arg3]\" singular=\"vez\" plural=\"vezes\"> por turno."
  },
  RelicConfig_71258_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Yuhhashi>"
  },
  RelicConfig_71259_BattleDesc = {
    Text = "Ao iniciar o turno, Aigis ganha [Arg1] pontos de loucura. Quando Aigis causa dano a um inimigo vulnerável, também rouba [Arg2] pontos de força temporária dele, podendo ser ativado no máximo [Arg3] vezes por turno."
  },
  RelicConfig_71259_Desc = {
    Text = "Ao iniciar o turno, Aigis ganha [Arg1] pontos de loucura. Quando Aigis causa dano a um inimigo vulnerável, também rouba [Arg2] pontos de força temporária dele, podendo ser ativado no máximo [Arg3] vezes por turno."
  },
  RelicConfig_71259_Name = {
    Text = "<OrangeQuality:Imagem Dimensional: Aigis>"
  },
  RelicConfig_71260_BattleDesc = {
    Text = "No início do turno, Tais ganha [Arg1] pontos de loucura. Após jogar [Arg2] cartas de comando em um único turno, Tais obtém uma carta \"Filho da Pureza\" e [Arg3] pontos de força temporária, com um tempo de recarga de [Arg4] turnos."
  },
  RelicConfig_71260_Desc = {
    Text = "No início do turno, Tais ganha [Arg1] pontos de loucura. Após jogar [Arg2] cartas de comando em um único turno, Tais obtém uma carta \"Filho da Pureza\" e [Arg3] pontos de força temporária, com um tempo de recarga de [Arg4] turnos."
  },
  RelicConfig_71260_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Pickman>"
  },
  RelicConfig_71261_BattleDesc = {
    Text = "No início do turno, Faróis ganha [Arg1] pontos de aliemus. Cada vez que causar 2 danos de tentáculo, aumenta em [Arg2]% o veneno e o escudo causados por Faróis nesta batalha, até o máximo de 50%."
  },
  RelicConfig_71261_Desc = {
    Text = "No início do turno, Faróis ganha [Arg1] pontos de aliemus. Cada vez que causar 2 danos de tentáculo, aumenta em [Arg2]% o veneno e o escudo causados por Faróis nesta batalha, até o máximo de 50%."
  },
  RelicConfig_71261_Name = {
    Text = "<OrangeQuality:Imagem Dimensional de Falos>"
  },
  RelicConfig_71262_BattleDesc = {
    Text = "Ao iniciar a rodada, Pandia ganha [Arg1] de aliemus. Após liberar a exaltação, ganhe contra-ataque permanente equivalente a [Arg2]% do contra-ataque temporário."
  },
  RelicConfig_71262_Desc = {
    Text = "Ao iniciar a rodada, Pandia ganha [Arg1] de aliemus. Após liberar a exaltação, ganhe contra-ataque permanente equivalente a [Arg2]% do contra-ataque temporário."
  },
  RelicConfig_71262_Name = {
    Text = "<OrangeQuality:Imagem Dimensional · Pandia>"
  },
  RelicConfig_71263_BattleDesc = {
    Text = "No início do turno, Lily ganha [Arg1] Aliemus. O limite de Suportar de Lily aumenta em 100%. Quando ela lança \"Flor sobre lodo\" ou \"Golpe para proteger,\" ela recupera 8% de Vida das pilhas de \"Suportar\"."
  },
  RelicConfig_71263_Desc = {
    Text = "No início do turno, Lily ganha [Arg1] Aliemus. O limite de Suportar de Lily aumenta em 100%. Quando ela lança \"Flor sobre lodo\" ou \"Golpe para proteger,\" ela recupera 8% de Vida das pilhas de \"Suportar\"."
  },
  RelicConfig_71263_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Lili>"
  },
  RelicConfig_71264_BattleDesc = {
    Text = "No início do turno, Karen ganha [Arg1] pontos de insanidade. Jogar \"Vigília Silenciosa\" devolve o dobro do poder consumido e recarrega em [Arg2] turnos."
  },
  RelicConfig_71264_Desc = {
    Text = "No início do turno, Karen ganha [Arg1] pontos de insanidade. Jogar \"Vigília Silenciosa\" devolve o dobro do poder consumido e recarrega em [Arg2] turnos."
  },
  RelicConfig_71264_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Jalen>"
  },
  RelicConfig_71265_BattleDesc = {
    Text = "No início do turno, Salvador ganha [Arg1] pontos de Loucura. Cada vez que acumula Fornalha Carmesim, também ganha [Arg2]% do poder acumulado. Os ataques \"Golpe\" e \"Sofrimento a Ser Esquecido\" de Salvador recebem um bônus adicional de [Arg3] vezes o poder."
  },
  RelicConfig_71265_Desc = {
    Text = "No início do turno, Salvador ganha [Arg1] pontos de Loucura. Cada vez que acumula Fornalha Carmesim, também ganha [Arg2]% do poder acumulado. Os ataques \"Golpe\" e \"Sofrimento a Ser Esquecido\" de Salvador recebem um bônus adicional de [Arg3] vezes o poder."
  },
  RelicConfig_71265_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Salvador>"
  },
  RelicConfig_71266_BattleDesc = {
    Text = "No início do turno, Caecus ganha [Arg1] pontos de loucura. Quando Caecus ganha um escudo, recupera vida equivalente a [Arg2]% do valor do escudo."
  },
  RelicConfig_71266_Desc = {
    Text = "No início do turno, Caecus ganha [Arg1] pontos de loucura. Quando Caecus ganha um escudo, recupera vida equivalente a [Arg2]% do valor do escudo."
  },
  RelicConfig_71266_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Kethys>"
  },
  RelicConfig_71267_BattleDesc = {
    Text = "No início do turno, Nínfea ganha [Arg1] pontos de loucura. Após jogar o \"ataque\" de Nínfea, aumenta em [Arg2]% o veneno causado por Nínfea nesta batalha; após jogar a \"defesa\" de Nínfea, ativa [Arg3]% de veneno em todos os inimigos. Cada um pode ser ativado no máximo uma vez por turno."
  },
  RelicConfig_71267_Desc = {
    Text = "No início do turno, Nínfea ganha [Arg1] pontos de loucura. Após jogar o \"ataque\" de Nínfea, aumenta em [Arg2]% o veneno causado por Nínfea nesta batalha; após jogar a \"defesa\" de Nínfea, ativa [Arg3]% de veneno em todos os inimigos. Cada um pode ser ativado no máximo uma vez por turno."
  },
  RelicConfig_71267_Name = {
    Text = "<OrangeQuality:Projeção Dimensional·Nínfea>"
  },
  RelicConfig_71268_BattleDesc = {
    Text = "No início do turno, Erika ganha [Arg1] pontos de loucura. Após Erika jogar [Arg2] cartas de comando dentro de 1 turno, ela ganha 2 pontos de aritmética e dobra o bônus de poder e prontidão concedido pela \"Explosão Eletromagnética\" nesta batalha."
  },
  RelicConfig_71268_Desc = {
    Text = "No início do turno, Erika ganha [Arg1] pontos de loucura. Após Erika jogar [Arg2] cartas de comando dentro de 1 turno, ela ganha 2 pontos de aritmética e dobra o bônus de poder e prontidão concedido pela \"Explosão Eletromagnética\" nesta batalha."
  },
  RelicConfig_71268_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Erica>"
  },
  RelicConfig_71269_BattleDesc = {
    Text = "No início do turno, Golias ganha [Arg1] pontos de loucura. Se Golias causar dano [Arg2] vezes em 1 turno, o dano causado por Golias recebe um bônus adicional de 1× o poder nesta batalha, com tempo de recarga de 3 turnos."
  },
  RelicConfig_71269_Desc = {
    Text = "No início do turno, Golias ganha [Arg1] pontos de loucura. Se Golias causar dano [Arg2] vezes em 1 turno, o dano causado por Golias recebe um bônus adicional de 1× o poder nesta batalha, com tempo de recarga de 3 turnos."
  },
  RelicConfig_71269_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Golias>"
  },
  RelicConfig_71270_BattleDesc = {
    Text = "No início do turno, Shan obtém [Arg1] pontos de loucura. No início da batalha, concede às cartas de comando de Shan as palavras-chave \"Reservado\" e \"Preparado 1\", e obtém [Arg2] pontos de escudo."
  },
  RelicConfig_71270_Desc = {
    Text = "No início do turno, Shan obtém [Arg1] pontos de loucura. No início da batalha, concede às cartas de comando de Shan as palavras-chave \"Reservado\" e \"Preparado 1\", e obtém [Arg2] pontos de escudo."
  },
  RelicConfig_71270_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Shan>"
  },
  RelicConfig_71662_BattleDesc = {
    Text = "No início de rodadas de número par, coloque 1 <DerivativeCardKeywords_105:\"Tesouro Prateado Sem Fim\"> na sua mão."
  },
  RelicConfig_71662_Desc = {
    Text = "No início de rodadas de número par, coloque 1 <DerivativeCardKeywords_105:\"Tesouro Prateado Sem Fim\"> na sua mão."
  },
  RelicConfig_71662_Name = {
    Text = "<OrangeQuality:O Tesouro do Gato>"
  },
  RelicConfig_72226_BattleDesc = {
    Text = "Limite de cartas na mão +1. No início do turno, se não houver pesquisa em andamento, escolha uma pesquisa não realizada, e ao completá-la, obtenha o resultado correspondente da pesquisa de Fusão: Doll. Ao completar 3 pesquisas, adicione \"Fim do Néant\" à sua mão, e essa criação se tornará inválida."
  },
  RelicConfig_72226_Desc = {
    Text = "Limite de cartas na mão +1. No início do turno, se a pesquisa atual não tiver sido realizada, escolha uma pesquisa que ainda não tenha sido feita; ao concluir a pesquisa, obtenha o resultado correspondente da Fusão·Doll. Ao completar 3 pesquisas, adicione \"Fim do Néant\" à sua mão, essa criação se tornará inválida."
  },
  RelicConfig_72226_Name = {
    Text = "Manuscrito de Pesquisa Terminal"
  },
  RelicConfig_74832_BattleDesc = {
    Text = "Limite de cartas na mão +1. No início do turno, ganhe uma \"Comércio Proibido\" personalizada; ao disparar \"Comércio Proibido\", poderá ativá-la novamente no próximo turno. Ao disparar diferentes tipos de \"Carta de comando\" enquanto mantiver \"Comércio Proibido\", os efeitos correspondentes serão melhorados."
  },
  RelicConfig_74832_Desc = {
    Text = "Limite de cartas na mão +1. No início do turno, ganhe uma \"Comércio Proibido\" personalizada, que pode ser disparada novamente na próxima rodada após ser disparada. Ao disparar cartas de comando de diferentes tipos enquanto mantém \"Comércio Proibido\", os efeitos correspondentes serão melhorados."
  },
  RelicConfig_74832_Name = {
    Text = "Convite de Mil Faces"
  },
  RelicConfig_74832_StoryDesc = {
    Text = "As palavras na carta mudam constantemente, transformando-se em um desejo que não pode ser recusado."
  },
  RelicConfig_78664_BattleDesc = {
    Text = "Após jogar 4 cartas de comando pertencentes a Despertados diferentes dentro de um único turno, aumente em [Arg1]% o dano final causado por todos os Despertados neste turno, e faça com que percam [Arg2] pontos de Loucura, sendo eficaz no máximo 1 vez por turno."
  },
  RelicConfig_78664_Desc = {
    Text = "Após jogar 4 cartas de comando pertencentes a Despertados diferentes dentro de um único turno, aumente em [Arg1]% o dano final causado por todos os Despertados neste turno, e faça com que percam [Arg2] pontos de Loucura, sendo eficaz no máximo 1 vez por turno."
  },
  RelicConfig_78664_Name = {
    Text = "<RedQuality:Garra Estranha>"
  },
  RelicConfig_78664_StoryDesc = {
    Text = "Espécie indiscernível"
  },
  RelicConfig_78665_BattleDesc = {
    Text = "Ao iniciar a rodada, compre [Arg1] carta(s) a menos. Ganhe 1 ponto de aritmética ao jogar cada carta com custo de aritmética real maior ou igual a [Arg2], com máximo de [Arg3] ativações por turno."
  },
  RelicConfig_78665_Desc = {
    Text = "Ao iniciar a rodada, compre [Arg1] carta(s) a menos. Ganhe 1 ponto de aritmética ao jogar cada carta com custo de aritmética real maior ou igual a [Arg2], com máximo de [Arg3] ativações por turno."
  },
  RelicConfig_78665_Name = {
    Text = "<RedQuality:Sino do Lamento>"
  },
  RelicConfig_78665_StoryDesc = {
    Text = "Ding ling, ding ling, a criança chora;\nDing ling, ding ling, a criança grita.\nDing ling, ding ling, a criança lamenta;\nDing ling, ding ling, está com fome, você sabe"
  },
  RelicConfig_78666_BattleDesc = {
    Text = "Ao iniciar o turno, ganhe [Arg1] pontos de contra-ataque. Após liberar a exaltação [Arg2] vezes em um único turno, remova [Arg3]% do seu contra-ataque permanente e ganhe um contra-ataque temporário equivalente a [Arg4]% da quantidade removida. Recarrega em [Arg5] turnos."
  },
  RelicConfig_78666_Desc = {
    Text = "Ao iniciar o turno, ganhe [Arg1] pontos de contra-ataque. Após liberar a exaltação [Arg2] vezes em um único turno, remova [Arg3]% do seu contra-ataque permanente e ganhe um contra-ataque temporário equivalente a [Arg4]% da quantidade removida. Recarrega em [Arg5] turnos."
  },
  RelicConfig_78666_Name = {
    Text = "<RedQuality:Cadáver do Caminho>"
  },
  RelicConfig_78666_StoryDesc = {
    Text = [[
Uma parte sagrada.
Mesmo separada do corpo, suas pegadas se espalharam pelos mares]]
  },
  RelicConfig_78667_BattleDesc = {
    Text = "Após a fase de compra de cartas, compre [Arg1] cartas adicionais e escolha [Arg2] cartas da sua mão para descartar."
  },
  RelicConfig_78667_Desc = {
    Text = "Após a fase de compra de cartas, compre [Arg1] cartas adicionais e escolha [Arg2] cartas da sua mão para descartar."
  },
  RelicConfig_78667_Name = {
    Text = "<RedQuality:chapéu mágico>"
  },
  RelicConfig_78667_StoryDesc = {
    Text = "Bem-vindo ao circo encantado da senhorita Casiah! Tenha cuidado, não toque nos itens mágicos à toa. Se você for mordido acidentalmente, isso pode ser um grande problema. \n Afinal, a última vez que ele provou o sabor do sangue, as consequências foram realmente aterrorizantes. \n\n O chapéu piscou, como se estivesse prestes a sair do casulo."
  },
  RelicConfig_78668_BattleDesc = {
    Text = "Depois de usar o Despertar da Chave de Prata, escolha [Arg1] Carta de comando não derivada correspondente a esse Corpo Desperto em sua mão. Esgote essa carta para colocar [Arg2] Cópia Base dela no Mazo de robo, na mão e no Monte de descarte, respectivamente."
  },
  RelicConfig_78668_Desc = {
    Text = "Depois de usar o Despertar da Chave de Prata, escolha [Arg1] Carta de comando não derivada correspondente a esse Corpo Desperto em sua mão. Esgote essa carta para colocar [Arg2] Cópia Base dela no Mazo de robo, na mão e no Monte de descarte, respectivamente."
  },
  RelicConfig_78668_Name = {
    Text = "<RedQuality:Impressão de Jade>"
  },
  RelicConfig_78668_StoryDesc = {
    Text = "Esta impressão é imortal por mil anos"
  },
  RelicConfig_78669_BattleDesc = {
    Text = "No início da batalha, ganhe [Arg1] pontos de força. A cada [Arg2] pontos de força permanente no início do turno, ganhe [Arg3] pontos de força temporária, até um máximo de [Arg4] pontos de força temporária, e ao final do turno, perca metade do escudo ganho por esta criação de força temporária."
  },
  RelicConfig_78669_Desc = {
    Text = "No início da batalha, ganhe [Arg1] pontos de força. A cada [Arg2] pontos de força permanente no início do turno, ganhe [Arg3] pontos de força temporária, até um máximo de [Arg4] pontos de força temporária, e ao final do turno, perca metade do escudo ganho por esta criação de força temporária."
  },
  RelicConfig_78669_Name = {
    Text = "<RedQuality:Pássaro do Ritual do Destino>"
  },
  RelicConfig_78669_StoryDesc = {
    Text = "O corpo seco emitiu um grito"
  },
  RelicConfig_78670_BattleDesc = {
    Text = "Todos os despertadores têm o dano base aumentado em [Arg1]%, recebendo um aumento adicional de [Arg2]% cada vez que o baralho é redefinido, mas colocando 1 carta \"Tropeço\" na mão, com um aumento máximo de [Arg3]%."
  },
  RelicConfig_78670_Desc = {
    Text = "Todos os despertadores têm o dano base aumentado em [Arg1]%, recebendo um aumento adicional de [Arg2]% cada vez que o baralho é redefinido, mas colocando 1 carta \"Tropeço\" na mão, com um aumento máximo de [Arg3]%."
  },
  RelicConfig_78670_Name = {
    Text = "<RedQuality:Vela Negra>"
  },
  RelicConfig_78670_StoryDesc = {
    Text = "Queime a lucidez, caia na ilusão"
  },
  RelicConfig_78671_BattleDesc = {
    Text = "No início do turno, a Fusão de embriões aumenta +[Arg1]. As cartas de \"embrião\" serão descartadas no final do turno."
  },
  RelicConfig_78671_Desc = {
    Text = "No início do turno, a Fusão de embriões aumenta +[Arg1]. As cartas de \"embrião\" serão descartadas no final do turno."
  },
  RelicConfig_78671_Name = {
    Text = "<RedQuality:Cordão Umbilical Contorcido>"
  },
  RelicConfig_78671_StoryDesc = {
    Text = "Entrelaçar em torno do pescoço"
  },
  RelicConfig_78672_BattleDesc = {
    Text = "No início do turno, sofre [Arg2] camadas de veneno e ganha [Arg1] pontos de poder para cada espaço vazio no espaço ultra."
  },
  RelicConfig_78672_Desc = {
    Text = "No início do turno, sofre [Arg2] camadas de veneno e ganha [Arg1] pontos de poder para cada espaço vazio no espaço ultra."
  },
  RelicConfig_78672_Name = {
    Text = "<RedQuality:Consciência do Enxame>"
  },
  RelicConfig_78672_StoryDesc = {
    Text = "Entrelaçar, simbiose, aglomeração; medo, desconhecido, controle"
  },
  RelicConfig_78673_BattleDesc = {
    Text = "Após o Despertar da Chave de Prata, consome adicionalmente [Arg1] pontos de energia da chave de prata, fazendo com que o custo de aritmética das cartas de Despertar da Gnosis obtidas se torne 0, e após jogá-las, o despertado correspondente ganha adicionalmente [Arg2] pontos de loucura."
  },
  RelicConfig_78673_Desc = {
    Text = "Após o Despertar da Chave de Prata, consome adicionalmente [Arg1] pontos de energia da chave de prata, fazendo com que o custo de aritmética das cartas de Despertar da Gnosis obtidas se torne 0, e após jogá-las, o despertado correspondente ganha adicionalmente [Arg2] pontos de loucura."
  },
  RelicConfig_78673_Name = {
    Text = "<RedQuality:Marca da Consciência>"
  },
  RelicConfig_78673_StoryDesc = {
    Text = "A antiga tribo acreditava que esculpir símbolos especiais na cabeça dos mortos deixaria suas almas para sempre, proporcionando companhia eterna"
  },
  RelicConfig_78674_BattleDesc = {
    Text = "Ao início da batalha, cause [Arg1] pontos de <IntoxicationIconKeywords:veneno> a todos os inimigos. No início do turno, remova [Arg2]% do <IntoxicationIconKeywords:veneno> dos inimigos e aplique <BleedingIconKeywords:sangramento> equivalente a [Arg3]% da quantidade removida."
  },
  RelicConfig_78674_Desc = {
    Text = "Ao início da batalha, cause [Arg1] pontos de <IntoxicationIconKeywords:veneno> a todos os inimigos. No início do turno, remova [Arg2]% do <IntoxicationIconKeywords:veneno> dos inimigos e aplique <BleedingIconKeywords:sangramento> equivalente a [Arg3]% da quantidade removida."
  },
  RelicConfig_78674_Name = {
    Text = "<RedQuality:Membro da Salvação>"
  },
  RelicConfig_78674_StoryDesc = {
    Text = [[
Uma parte sagrada.
Mesmo separada do corpo, ainda se sente o calor]]
  },
  RelicConfig_78675_BattleDesc = {
    Text = "No início do turno, se possuir mais de [Arg1] tentáculos permanentes, perca [Arg2] tentáculos e ganhe [Arg3] tentáculos temporários. Caso contrário, ganhe [Arg4] tentáculos permanentes."
  },
  RelicConfig_78675_Desc = {
    Text = "No início do turno, se possuir mais de [Arg1] tentáculos permanentes, perca [Arg2] tentáculos e ganhe [Arg3] tentáculos temporários. Caso contrário, ganhe [Arg4] tentáculos permanentes."
  },
  RelicConfig_78675_Name = {
    Text = "<RedQuality:Braço Sagrado da Dor>"
  },
  RelicConfig_78675_StoryDesc = {
    Text = "Desfrute da agonia"
  },
  RelicConfig_79408_BattleDesc = {
    Text = "Limite de cartas na mão + 2, Comprar carta + 2. \"Memórias Claras\" começa com 5 camadas; Disparar cartas marcadas fará com que \"Memórias Claras\" mude. Quando \"Memórias Claras\" estiver abaixo de 5, para cada ponto abaixo, o Dano Final aumenta em 10%, e o Escudo e a resposta de Vida diminuem em 5%; quando \"Memórias Claras\" estiver acima de 5, para cada ponto acima, o Escudo e a resposta de Vida aumentam em 5%, e o Dano Final diminui em 10%."
  },
  RelicConfig_79408_Desc = {
    Text = "Limite de cartas na mão + 2, número de cartas compradas + 2. \"Memórias Claras\" começa com 5 camadas, disparar cartas marcadas fará com que \"Memórias Claras\" mude. Quando \"Memórias Claras\" estiver abaixo de 5, para cada ponto abaixo, o dano final aumenta em 10%, e a recuperação de escudo e vida diminui em 5%; quando \"Memórias Claras\" estiver acima de 5, para cada ponto acima, a recuperação de escudo e vida aumenta em 5%, e o dano final diminui em 10%."
  },
  RelicConfig_79408_Name = {
    Text = "\"Memória\" e \"Sonho\""
  },
  RelicConfig_79408_StoryDesc = {
    Text = "\"Venha, ouça-me.\"\n\"Deixe-me transformar suas memórias e sonhos.\"\n\"Em sobremesas incrivelmente deliciosas.\""
  },
  RelicConfig_80340_BattleDesc = {
    Text = "No início do turno, Clementine ganha [Arg1] pontos de loucura. O número de vezes que o dano, escudo, recuperação de vida, ganho de loucura e ganho de energia da chave de prata das cartas de comando de Clementine são aumentados em 1."
  },
  RelicConfig_80340_Desc = {
    Text = "No início do turno, Clementine ganha [Arg1] pontos de loucura. O número de vezes que o dano, escudo, recuperação de vida, ganho de loucura e ganho de energia da chave de prata das cartas de comando de Clementine são aumentados em 1."
  },
  RelicConfig_80340_Name = {
    Text = "<OrangeQuality:Imagem Dimensional - Clementine>"
  },
  RelicConfig_83509_BattleDesc = {
    Text = "No início da exploração, aumente o limite de relíquias em +1, e o Despertador do Reino \"Aequor\" ganha sua \"Ilusão Dimensional\". Para cada Despertador do Reino \"Aequor\" na equipe, aumente o limite de relíquias em +1."
  },
  RelicConfig_83509_Desc = {
    Text = "No início da exploração, aumente o limite de relíquias em +1, e o Despertador do Reino \"Aequor\" ganha sua \"Ilusão Dimensional\". Para cada Despertador do Reino \"Aequor\" na equipe, aumente o limite de relíquias em +1."
  },
  RelicConfig_83509_Name = {
    Text = "<OrangeQuality:\"Anel do Mar Profundo\">"
  },
  RelicConfig_83509_StoryDesc = {
    Text = "Os sonhadores no oceano abissal começam a mostrar a autoridade esquecida ao mundo."
  },
  RelicConfig_83510_BattleDesc = {
    Text = "No início da exploração, aumente o limite de relíquias em +1, e o Despertador do Reino \"Caro\" ganha sua \"Ilusão Dimensional\". Para cada Despertador do Reino \"Caro\" na equipe, aumente o limite de relíquias em +1."
  },
  RelicConfig_83510_Desc = {
    Text = "No início da exploração, aumente o limite de relíquias em +1, e o Despertador do Reino \"Caro\" ganha sua \"Ilusão Dimensional\". Para cada Despertador do Reino \"Caro\" na equipe, aumente o limite de relíquias em +1."
  },
  RelicConfig_83510_Name = {
    Text = "<OrangeQuality:\"Anel de Carne e Osso\">"
  },
  RelicConfig_83510_StoryDesc = {
    Text = "Esperança portátil"
  },
  RelicConfig_83511_BattleDesc = {
    Text = "No início da exploração, aumente o limite de relíquias em +1, e o Despertador do Reino \"Ultra\" ganha sua \"Ilusão Dimensional\". Para cada Despertador do Reino \"Ultra\" na equipe, aumente o limite de relíquias em +1."
  },
  RelicConfig_83511_Desc = {
    Text = "No início da exploração, aumente o limite de relíquias em +1, e o Despertador do Reino \"Ultra\" ganha sua \"Ilusão Dimensional\". Para cada Despertador do Reino \"Ultra\" na equipe, aumente o limite de relíquias em +1."
  },
  RelicConfig_83511_Name = {
    Text = "<OrangeQuality:\"Anel Dimensional\">"
  },
  RelicConfig_83511_StoryDesc = {
    Text = "Dimensões infinitas se sobrepõem, neste momento \"Eu\" estou infinitamente completo."
  },
  RelicConfig_83512_BattleDesc = {
    Text = "No início da exploração, aumente o limite de relíquias em +1, e o Despertador do Reino \"Caos\" ganha sua \"Ilusão Dimensional\". Para cada Despertador do Reino \"Caos\" na equipe, aumente o limite de relíquias em +1."
  },
  RelicConfig_83512_Desc = {
    Text = "No início da exploração, aumente o limite de relíquias em +1, e o Despertador do Reino \"Caos\" ganha sua \"Ilusão Dimensional\". Para cada Despertador do Reino \"Caos\" na equipe, aumente o limite de relíquias em +1."
  },
  RelicConfig_83512_Name = {
    Text = "<OrangeQuality:\"Anel do Caos\">"
  },
  RelicConfig_83512_StoryDesc = {
    Text = "O que você guia é apenas um caminho errado"
  },
  RelicConfig_83606_BattleDesc = {
    Text = "Limite de cartas na mão +1. No início do turno, se você não tiver \"Decisão do Navegador\", coloque-a na mão. \n Sempre que o líder perder 10% da vida máxima inicial, ganhe 1 camada de \"Levantar velas\", com um limite de 10 camadas, \"Levantar velas\" pode melhorar o efeito de \"Rompendo as ondas, iniciando a viagem\". \n Sempre que você perder 10% da sua vida máxima inicial, ganhe 1 camada de \"Anclar\", com um limite de 10 camadas, \"Anclar\" pode melhorar o efeito de \"Descanso na margem\"."
  },
  RelicConfig_83606_Desc = {
    Text = "Limite de cartas na mão +1. No início do turno, se não tiver \"Decisão do Navegador\", coloque-a na mão. \n Sempre que o líder perder 10% da vida máxima inicial, ganhe 1 camada de \"Levantar velas\", com limite de 10 camadas, que pode melhorar o efeito de \"Rompendo as ondas, iniciando a viagem\". \n Sempre que você perder 10% da sua vida máxima inicial, ganhe 1 camada de \"Anclar\", com limite de 10 camadas, que pode melhorar o efeito de \"Descanso na margem\"."
  },
  RelicConfig_83606_Name = {
    Text = "Guia de Erasmo"
  },
  RelicConfig_83606_StoryDesc = {
    Text = "O parpadeio do relâmpago guiará a direção a seguir."
  },
  RelicConfig_84112_BattleDesc = {
    Text = "Ao iniciar o turno, Agrippa ganha [Arg1] pontos de aliemus. \"A caridade impaciente\" também reduz o consumo de aritmética de Agrippa em [Arg2] durante este turno, e pode ser ativada apenas 1 vez por turno."
  },
  RelicConfig_84112_Desc = {
    Text = "Ao iniciar o turno, Agrippa ganha [Arg1] pontos de aliemus. \"A caridade impaciente\" também reduz o consumo de aritmética de Agrippa em [Arg2] durante este turno, e pode ser ativada apenas 1 vez por turno."
  },
  RelicConfig_84112_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Agripa>"
  },
  RelicConfig_84113_BattleDesc = {
    Text = "No início do turno, Caraboo ganha [Arg1] Fúria. As cartas \"Bênção\" de Caraboo oferecem mais 1 opção ao serem <FaxianKeywords:descobertas>. A Fúria Explosiva de Caraboo inflige capas de Corrosão iguais à quantidade de dano causado."
  },
  RelicConfig_84113_Desc = {
    Text = "No início do turno, Caraboo ganha [Arg1] Fúria. As cartas \"Bênção\" de Caraboo oferecem mais 1 opção ao serem <FaxianKeywords:descobertas>. A Fúria Explosiva de Caraboo inflige capas de Corrosão iguais à quantidade de dano causado."
  },
  RelicConfig_84113_Name = {
    Text = "<OrangeQuality:Imagem Dimensional: Caraboo>"
  },
  RelicConfig_84114_BattleDesc = {
    Text = "No início do turno, Pikeman ganha [Arg1] Aliemus. Cada vez que uma pilha de \"Inspiração\" é ganha, reduza aleatoriamente o exaurir aritmético de 1 carta da mão por 1 neste turno. Quando Pikeman exaustar uma \"Inspiração\", todos os Despertadores ganham [Arg2] pontos de Aliemus."
  },
  RelicConfig_84114_Desc = {
    Text = "No início do turno, Pikeman ganha [Arg1] Aliemus. Cada vez que uma pilha de \"Inspiração\" é ganha, reduza aleatoriamente o exaurir aritmético de 1 carta da mão por 1 neste turno. Quando Pikeman exaustar uma \"Inspiração\", todos os Despertadores ganham [Arg2] pontos de Aliemus."
  },
  RelicConfig_84114_Name = {
    Text = "<OrangeQuality:Imagem da Dimensão·Pickman>"
  },
  RelicConfig_84116_BattleDesc = {
    Text = "No início do turno, Erika ganha [Arg1] pontos de loucura. Após Erika jogar [Arg2] cartas de comando dentro de 1 turno, ela ganha 2 pontos de aritmética e dobra o bônus de poder e prontidão concedido pela \"Explosão Eletromagnética\" nesta batalha."
  },
  RelicConfig_84116_Desc = {
    Text = "No início do turno, Erika ganha [Arg1] pontos de loucura. Após Erika jogar [Arg2] cartas de comando dentro de 1 turno, ela ganha 2 pontos de aritmética e dobra o bônus de poder e prontidão concedido pela \"Explosão Eletromagnética\" nesta batalha."
  },
  RelicConfig_84116_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Erica>"
  },
  RelicConfig_84117_BattleDesc = {
    Text = "No início da rodada, Murphy: fauxborn ganha [Arg1] loucura. \"Valsa Espiral\" ativa 3 vezes a cada 3 liberações."
  },
  RelicConfig_84117_Desc = {
    Text = "No início da rodada, Murphy: fauxborn ganha [Arg1] loucura. \"Valsa Espiral\" ativa 3 vezes a cada 3 liberações."
  },
  RelicConfig_84117_Name = {
    Text = "<OrangeQuality:imagem dimensional: murphy: fauxborn>"
  },
  RelicConfig_84118_BattleDesc = {
    Text = "Ao iniciar a rodada, Casiah ganha [Arg1] pontos de loucura. Para cada carta comprada, Casiah ganha [Arg2] pontos de loucura. Quando Casiah libera a exaltação, todos os inimigos perdem [Arg3] pontos de poder."
  },
  RelicConfig_84118_Desc = {
    Text = "Ao iniciar a rodada, Casiah ganha [Arg1] pontos de loucura. Para cada carta comprada, Casiah ganha [Arg2] pontos de loucura. Quando Casiah libera a exaltação, todos os inimigos perdem [Arg3] pontos de poder."
  },
  RelicConfig_84118_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Cassia>"
  },
  RelicConfig_84119_BattleDesc = {
    Text = "No início do turno, Murphy ganha [Arg1] pontos de aliemus. O \"golpe\" e a \"defesa\" de Murphy podem converter [Arg2]% do \"sacrifício\" em dano de tentáculo temporário, mas só podem ser ativados uma vez por turno."
  },
  RelicConfig_84119_Desc = {
    Text = "No início do turno, Murphy ganha [Arg1] pontos de aliemus. O \"golpe\" e a \"defesa\" de Murphy podem converter [Arg2]% do \"sacrifício\" em dano de tentáculo temporário, mas só podem ser ativados uma vez por turno."
  },
  RelicConfig_84119_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Murphy>"
  },
  RelicConfig_84121_BattleDesc = {
    Text = "Arachne ganha [Arg1] de Fúria no início do turno. \"Golpear\" e \"Defesa\" acionam imediatamente a Caçada: \"Fios infinitos\" uma vez, cada um com efeito no máximo uma vez por turno."
  },
  RelicConfig_84121_Desc = {
    Text = "Arachne ganha [Arg1] de Fúria no início do turno. \"Golpear\" e \"Defesa\" acionam imediatamente a Caçada: \"Fios infinitos\" uma vez, cada um com efeito no máximo uma vez por turno."
  },
  RelicConfig_84121_Name = {
    Text = "<OrangeQuality:Imagem Dimensional: Arachne>"
  },
  RelicConfig_84122_BattleDesc = {
    Text = "No início do turno, Tulu ganha [Arg1] pontos de loucura. O consumo de loucura de Tulu é reduzido em [Arg2] pontos e [Arg3] tentáculos temporários são gerados imediatamente após liberar a explosão da loucura."
  },
  RelicConfig_84122_Desc = {
    Text = "No início do turno, Tulu ganha [Arg1] pontos de loucura. O consumo de loucura de Tulu é reduzido em [Arg2] pontos e [Arg3] tentáculos temporários são gerados imediatamente após liberar a explosão da loucura."
  },
  RelicConfig_84122_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Turu>"
  },
  RelicConfig_84123_BattleDesc = {
    Text = "No início da rodada, Pollux ganha [Arg1] aliemus. No início da batalha, ganhe 1 \"Coração Sagrado\", o \"Coração Sagrado\" tornará todos os inimigos vulneráveis na 3ª jogada, causando 2 vezes o dano."
  },
  RelicConfig_84123_Desc = {
    Text = "No início da rodada, Pollux ganha [Arg1] aliemus. No início da batalha, ganhe 1 \"Coração Sagrado\", o \"Coração Sagrado\" tornará todos os inimigos vulneráveis na 3ª jogada, causando 2 vezes o dano."
  },
  RelicConfig_84123_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Pollux>"
  },
  RelicConfig_84124_BattleDesc = {
    Text = "No início da rodada, Hamlin ganha [Arg1] de sanidade. O custo de poder de \"Ária da Alma\" é reduzido em [Arg2] e o número básico de acertos é aumentado em [Arg3]."
  },
  RelicConfig_84124_Desc = {
    Text = "No início da rodada, Hamlin ganha [Arg1] de sanidade. O custo de poder de \"Ária da Alma\" é reduzido em [Arg2] e o número básico de acertos é aumentado em [Arg3]."
  },
  RelicConfig_84124_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Hamlin>"
  },
  RelicConfig_84125_BattleDesc = {
    Text = "No início do turno, Katie Gula ganha [Arg1] de Fúria. Após acumular 10 capas de \"Chama Viva\", compre imediatamente 1 Carta de comando de Katie Gula e conceda a ela 3 capas de \"Chama Viva\". Este efeito não acumulará capas pelo resto deste turno."
  },
  RelicConfig_84125_Desc = {
    Text = "No início do turno, Katie Gula ganha [Arg1] de Fúria. Após acumular 10 capas de \"Chama Viva\", compre imediatamente 1 Carta de comando de Katie Gula e conceda a ela 3 capas de \"Chama Viva\". Este efeito não acumulará capas pelo resto deste turno."
  },
  RelicConfig_84125_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Katie Gula>"
  },
  RelicConfig_84126_BattleDesc = {
    Text = "No início do turno, Castor ganha [Arg1] pontos de loucura. No início da batalha, coloque 2 cartas \"Pluma Negra\" na mão; após jogar uma carta \"Pluma Negra\" pela primeira vez em cada turno, ganhe [Arg2] pontos de força temporária."
  },
  RelicConfig_84126_Desc = {
    Text = "No início do turno, Castor ganha [Arg1] pontos de loucura. No início da batalha, coloque 2 cartas \"Pluma Negra\" na mão; após jogar uma carta \"Pluma Negra\" pela primeira vez em cada turno, ganhe [Arg2] pontos de força temporária."
  },
  RelicConfig_84126_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Castor>"
  },
  RelicConfig_84127_BattleDesc = {
    Text = "No início do turno, Kephasant ganha [Arg1] pontos de loucura e obtém 1 tentáculo temporário. Sempre que ativar a resistência à morte, Kephasant ganha [Arg2] pontos de loucura e coloca na mão 1 carta \"Fulgor Punitivo\" com custo de aritmética 0 e custo adicional."
  },
  RelicConfig_84127_Desc = {
    Text = "No início do turno, Kephasant ganha [Arg1] pontos de loucura e obtém 1 tentáculo temporário. Sempre que ativar a resistência à morte, Kephasant ganha [Arg2] pontos de loucura e coloca na mão 1 carta \"Fulgor Punitivo\" com custo de aritmética 0 e custo adicional."
  },
  RelicConfig_84127_Name = {
    Text = "<OrangeQuality:Imagem Dimensional·Kepersant>"
  },
  RelicConfig_89252_BattleDesc = {
    Text = "O limite de capacidade de cálculo aumenta em 1, o número de cartas compradas por turno aumenta em 1, e ao iniciar a batalha, ganha [Arg1] camadas de \"Cárcere do Destino\".\nCada camada de \"Cárcere do Destino\" reduz a Fúria gerada por todos os Corpos Despertos em [Arg2]%. Cada vez que liberar a Fúria Explosiva, remove 1 camada de \"Cárcere do Destino\". Após todas as camadas de \"Cárcere do Destino\" serem removidas, todos os Corpos Despertos ganham [Arg3] pontos de Fúria e recebem \"Coração Indomável\": a Fúria gerada por todos os Corpos Despertos aumenta em [Arg4]%, podendo liberar a Fúria Explosiva 2 vezes por turno."
  },
  RelicConfig_89252_Desc = {
    Text = "O limite de capacidade de cálculo aumenta em 1, o número de cartas compradas por turno aumenta em 1, e ao começar a batalha, ganha [Arg1] camadas de \"Cárcere do Destino\".\nCada camada de \"Cárcere do Destino\" reduz a Fúria gerada por todos os Corpos Despertos em [Arg2]%. Cada vez que libera a Fúria Explosiva, reduz 1 camada de \"Cárcere do Destino\". Após a remoção de todas as \"Cárceres do Destino\", todos os Corpos Despertos ganham [Arg3] pontos de Fúria e recebem \"Coração Indomável\": A Fúria gerada por todos os Corpos Despertos aumenta em [Arg4]%, podendo liberar a Fúria Explosiva 2 vezes por turno."
  },
  RelicConfig_89252_Name = {
    Text = "Penas Amaldiçoadas"
  },
  RelicConfig_89252_StoryDesc = {
    Text = "Agora, esta pena não pode mais voar no céu."
  },
  RelicConfig_89645_BattleDesc = {
    Text = "Limite de cartas na mão +2, ao liberar Fúria Explosiva, o Dano Final temporário aumenta em 10%.\nQuando uma carta entra no Espaço Hiperdimensional, 1 \"embrião\" na mão se transforma em \"Filho da santidade\".\nA cada geração de 1 \"embrião\", o consumo de poder de cálculo de uma carta aleatória no Espaço Hiperdimensional diminui em 1."
  },
  RelicConfig_89645_Desc = {
    Text = "Limite de cartas na mão +2, ao liberar Fúria Explosiva, o Dano Final aumenta temporariamente em 10%.\nApós a carta entrar no Espaço Hiperdimensional, 1 \"embrião\" na mão se transforma em \"Filho da Santidade\".\nA cada geração de 1 \"embrião\", o consumo de Poder de Cálculo de uma carta aleatória no Espaço Hiperdimensional diminui em 1."
  },
  RelicConfig_89645_Name = {
    Text = "Elixir de Sangue Corrompido da Supercorda"
  },
  RelicConfig_89646_BattleDesc = {
    Text = "Ganhe 250 Chave de Fogo no início do turno.\nApós usar o Despertar da Chave de Fogo, coloque 1 <DerivativeCardKeywords_129:\"Brilho da Chave de Prata\"> na sua mão.\nDescubra 1 carta de apoio de Despertador no início do turno."
  },
  RelicConfig_89646_Desc = {
    Text = "Ganhe 250 Chave de Fogo no início do turno.\nApós usar o Despertar da Chave de Fogo, coloque 1 <DerivativeCardKeywords_129:\"Brilho da Chave de Prata\"> na sua mão.\nDescubra 1 carta de apoio de Despertador no início do turno."
  },
  RelicConfig_89646_Name = {
    Text = "Poção de Diferenciação Integrada"
  },
  RelicConfig_89647_BattleDesc = {
    Text = "A primeira carta de comando em cada turno toma efeito 1 vez adicional. \n Ao aniquilar, gera 1 tentáculo. \n Após mudar o tentáculo para a postura \"Onda de Ira\", o efeito de salto da próxima carta de comando deste turno é garantido e coloca 2 cópias originais no Espaço Hiperdimensional, com 3 turnos de cooldown."
  },
  RelicConfig_89647_Desc = {
    Text = "A primeira carta de comando jogada em cada turno toma efeito 1 vez adicional. \n Ao aniquilar, gera 1 tentáculo. \n Depois de mudar o tentáculo para a postura \"Onda de Ira\", o efeito de salto da próxima carta de comando nesta rodada será ativado obrigatoriamente e suas 2 cópias originais serão colocadas no Espaço Hiperdimensional, com 3 turnos de cooldown."
  },
  RelicConfig_89647_Name = {
    Text = "Elixir da Supercorda do Abismo"
  },
  RelicConfig_89648_BattleDesc = {
    Text = "Maestria em Domínios aumenta em 200 pontos. \nAo consumir a fornalha carmesim, aumenta o dano dos tentáculos em 15% da quantidade consumida. \nA cada ataque de tentáculo, acumula [Arg3] pontos na fornalha carmesim."
  },
  RelicConfig_89648_Desc = {
    Text = "Maestria em Domínios aumenta em 200 pontos. \nAo consumir a fornalha carmesim, aumenta o dano dos tentáculos em 15% da quantidade consumida. \nA cada ataque de tentáculo, acumula [Arg3] pontos na fornalha carmesim."
  },
  RelicConfig_89648_Name = {
    Text = "Elixir de Sangue Corrompido da Supercorda"
  },
  RelicConfig_91096_BattleDesc = {
    Text = "No início do turno, ambas as partes ganham uma camada de <Kuangre:fervor>, cada camada de <Kuangre:fervor> faz com que o dano ativo e o dano de tentáculo causados incluam sangramento equivalente a 10% do dano. \n A cada 20% de dano causado à vida do líder, todos os Corpos Despertos ganham 10 de Fúria. \n No início da batalha, embaralhe <DerivativeCardKeywords_108:\"Inspiração da Prole\"> e <DerivativeCardKeywords_109:\"Proteção dos Filhos\"> no mazo de robo."
  },
  RelicConfig_91096_Desc = {
    Text = "No início do turno, ambas as partes ganham uma camada de <Kuangre:fervor>, cada camada de <Kuangre:fervor> faz com que o dano ativo e o dano de tentáculo causados incluam sangramento equivalente a 10% do dano. \n A cada 20% de dano causado à vida do líder, todos os Corpos Despertos ganham 10 de Fúria. \n No início da batalha, embaralhe <DerivativeCardKeywords_108:\"Inspiração da Prole\"> e <DerivativeCardKeywords_109:\"Proteção dos Filhos\"> no mazo de robo."
  },
  RelicConfig_91096_Name = {
    Text = "Ovo Pálido"
  },
  RelicConfig_91096_StoryDesc = {
    Text = "A incitação do Filho Pálido prestes a nascer. \n Cuidado, eles estão quase aqui."
  },
  RelicConfig_94695_BattleDesc = {
    Text = "Depois que um Despertador é morto, outros aliados ganham [Arg1] <StrongEffectKeywords: Efeito Forte>, esse efeito pode ser acionado apenas uma vez para cada Despertador."
  },
  RelicConfig_94695_Desc = {
    Text = "Depois que um Despertador é morto, outros aliados ganham [Arg1] <StrongEffectKeywords: Efeito Forte>, esse efeito pode ser acionado apenas uma vez para cada Despertador."
  },
  RelicConfig_94695_Name = {
    Text = "<OrangeQuality:Cinzas Ardentes da Estrela Negra>"
  },
  RelicConfig_94696_BattleDesc = {
    Text = "Após o início da batalha, coloque [Arg1] <PVPDerivativeCardKeywords_21:Abraço Gelado> na mão."
  },
  RelicConfig_94696_Desc = {
    Text = "Após o início da batalha, coloque [Arg1] <PVPDerivativeCardKeywords_21:Abraço Gelado> na mão."
  },
  RelicConfig_94696_Name = {
    Text = "<OrangeQuality:Injeção Ativa>"
  },
  RelicConfig_94697_BattleDesc = {
    Text = "No final do turno, descarte toda a mão e compre o número correspondente de cartas."
  },
  RelicConfig_94697_Desc = {
    Text = "No final do turno, descarte toda a mão e compre o número correspondente de cartas."
  },
  RelicConfig_94697_Name = {
    Text = "<OrangeQuality:Sinos Sedutores>"
  },
  RelicConfig_94698_BattleDesc = {
    Text = "Após o início da batalha, coloque [Arg1] <PVPDerivativeCardKeywords_22:Investida Última, Melhor Investida> e <PVPDerivativeCardKeywords_23:Vozes na Sua Cabeça> no baralho de puxar."
  },
  RelicConfig_94698_Desc = {
    Text = "Após o início da batalha, coloque [Arg1] <PVPDerivativeCardKeywords_22:Investida Última, Melhor Investida> e <PVPDerivativeCardKeywords_23:Vozes na Sua Cabeça> no baralho de puxar."
  },
  RelicConfig_94698_Name = {
    Text = "<OrangeQuality:Artefato de Afonso>"
  },
  RelicConfig_95975_BattleDesc = {
    Text = "Limite de mão +1.\nNo início do turno, se não houver <DerivativeCardKeywords_111:\"Devorar Alma\">, coloque-o na mão. Se a \"Satisfação\" atingir 10, transforme-o em <DerivativeCardKeywords_112:\"Ressonância da Memória\">."
  },
  RelicConfig_95975_Desc = {
    Text = "Limite de cartas +1. \nNo início do turno, se você não tiver \"Alma Devoradora\", coloque-a na mão. Se \"Saciado\" atingir 10, transforme em \"Resonância de Memória\"."
  },
  RelicConfig_95975_Name = {
    Text = "Cálice de Ossos"
  },
  RelicConfig_95975_StoryDesc = {
    Text = "\"A Lua Sanguinária se ergue, e os corpos devem levantar os copos e brindar.\""
  },
  RelicConfig_95976_BattleDesc = {
    Text = "Ao iniciar a rodada, Dullahan ganha [Arg1] pontos de loucura e [Arg2] pontos de poder. Quando Dullahan consome \"destroços\", ganha 20% de poder permanente como poder temporário."
  },
  RelicConfig_95976_Desc = {
    Text = "Ao iniciar a rodada, Dullahan ganha [Arg1] pontos de loucura e [Arg2] pontos de poder. Quando Dullahan consome \"destroços\", ganha 20% de poder permanente como poder temporário."
  },
  RelicConfig_95976_Name = {
    Text = "<OrangeQuality:Imagem Dimensional - Duresein>"
  },
  RelicConfig_96652_BattleDesc = {
    Text = "No início do turno, concede 1 Carta de comando na mão o efeito de \"<BurningKeywords2:Queimando>\" e acumula 1 camada de \"<Heat:Chama Sombria>\". Quando \"<Heat:Chama Sombria>\" atingir 3 camadas, coloque uma carta de \"<Overload:Chama Infinita>\" em sua mão."
  },
  RelicConfig_96652_Desc = {
    Text = "No início do turno, concede 1 Carta de comando na mão o efeito de \"<BurningKeywords2:Queimando>\" e acumula 1 camada de \"<Heat:Chama Sombria>\". Quando \"<Heat:Chama Sombria>\" atingir 3 camadas, coloque uma carta de \"<Overload:Chama Infinita>\" em sua mão."
  },
  RelicConfig_96652_Name = {
    Text = "Chama Sombria"
  },
  RelicConfig_96652_StoryDesc = {
    Text = "As chamas negras irão cumprir sua vontade, queimando tudo até a destruição total."
  },
  RelicConfig_97344_BattleDesc = {
    Text = "Quando perder a última carta da mão, compre 2 cartas e ganhe [Arg1] pontos de s-energia. Após cada redefinição do baralho, o dano de tentáculo aumenta em [Arg2] pontos."
  },
  RelicConfig_97344_Desc = {
    Text = "Quando perder a última carta da mão, compre 2 cartas e ganhe [Arg1] pontos de s-energia. Após cada redefinição do baralho, o dano de tentáculo aumenta em [Arg2] pontos."
  },
  RelicConfig_97344_Name = {
    Text = "Taça de Ouro de Mythag"
  },
  RelicConfig_97344_StoryDesc = {
    Text = "Hoje, vamos esquecer o medo, esquecer a dor, e apenas aproveitar a festa."
  },
  RelicConfig_97345_BattleDesc = {
    Text = "Para cada 3 cartas de comando jogadas, ganhe 1 ponto de aritmética e compre 1 carta. Para cada dano ativo causado, aumente em 2% o dano final temporário, até no máximo 50%."
  },
  RelicConfig_97345_Desc = {
    Text = "Para cada 3 cartas de comando jogadas, ganhe 1 ponto de aritmética e compre 1 carta. Para cada dano ativo causado, aumente em 2% o dano final temporário, até no máximo 50%."
  },
  RelicConfig_97345_Name = {
    Text = "Taça de Ouro do Campeonato de Mythag"
  },
  RelicConfig_97345_StoryDesc = {
    Text = "Hoje, esqueceremos o medo, esqueceremos a dor, e apenas desfrutaremos da festa."
  },
  RelicConfig_97346_BattleDesc = {
    Text = "A taxa crítica de todos os despertadores aumenta em 30%. No início de cada turno ímpar, todos os inimigos perdem 25% da vida atual. Quando a porcentagem de vida própria é inferior à do inimigo, o dano final causado aumenta em 50%; quando a porcentagem de vida própria é superior à do inimigo, após liberar a explosão de loucura, o despertador ganha 35 pontos de loucura."
  },
  RelicConfig_97346_Desc = {
    Text = "Todos os despertadores ganham 30% de aumento na taxa crítica. No início de turnos ímpares, todos os inimigos perdem 25% da vida atual. Quando a porcentagem de vida própria é inferior à do inimigo, o dano final causado aumenta em 50%. Quando a porcentagem de vida própria é superior à do inimigo, após liberar uma explosão de loucura, o personagem ganha 35 pontos de loucura."
  },
  RelicConfig_97346_Name = {
    Text = "Taça de Ouro de Mythag"
  },
  RelicConfig_97346_StoryDesc = {
    Text = "Hoje, vamos esquecer o medo, esquecer a dor, e apenas aproveitar a festa."
  },
  RelicConfig_97347_BattleDesc = {
    Text = "Aumenta o poder máximo em 2 pontos, o poder não consumido pode ser mantido para a próxima rodada. Se mantiver mais de 2 pontos de poder, todos os despertadores ganham 20 pontos de aliemus no início da próxima rodada; se mantiver mais de 4 pontos de poder, o dano base causado na próxima rodada aumenta em 100%."
  },
  RelicConfig_97347_Desc = {
    Text = "A saúde máxima aumenta em 2 pontos, a aritmética não consumida pode ser mantida para o próximo turno. Se mais de 2 pontos de aritmética forem mantidos, todos os despertadores ganham 20 pontos de aliemus no início do próximo turno; se mais de 4 pontos de aritmética forem mantidos, o dano base causado no próximo turno aumenta em 100%."
  },
  RelicConfig_97347_Name = {
    Text = "Taça de Ouro do Campeonato de Mythag"
  },
  RelicConfig_97347_StoryDesc = {
    Text = "Hoje, vamos esquecer o medo, esquecer a dor, e apenas desfrutar da festa."
  },
  RelicConfig_98274_BattleDesc = {
    Text = "Limite de cartas na mão +1, no início da batalha, ganhe 「<DerivativeCardKeywords_116:Paleta>」. \nNo início do turno, ganhe 1 「<PrimaryColor:Primária>」 e faça com que aleatoriamente 2 cartas de comando recebam 「<ColorInkKeywords:Tinta colorida>」. Após jogar uma carta com 「<ColorInkKeywords:Tinta colorida>」, ganhe 1 「<PrimaryColor:Primária>」 na sequência. \n「<PrimaryColor:Primária>」 jogada será registrada na 「<DerivativeCardKeywords_116:Paleta>」. Se houver 2 tipos diferentes de 「<PrimaryColor:Primária>」 na 「<DerivativeCardKeywords_116:Paleta>」, isso concederá um bônus contínuo. \nSe houver 3 tipos diferentes de 「<PrimaryColor:Primária>」 na 「<DerivativeCardKeywords_116:Paleta>」, todos os inimigos perdem 5% da vida máxima imediatamente e 「<DerivativeCardKeywords_116:Paleta>」 será esvaziada."
  },
  RelicConfig_98274_Desc = {
    Text = "Limite de cartas na mão +1, no início da batalha, ganhe 「<DerivativeCardKeywords_116:Paleta>」. \nNo início do turno, ganhe 1 「<PrimaryColor:Primária>」 e faça com que aleatoriamente 2 cartas de comando recebam 「<ColorInkKeywords:Tinta colorida>」. Após jogar uma carta com 「<ColorInkKeywords:Tinta colorida>」, ganhe 1 「<PrimaryColor:Primária>」 na sequência. \n「<PrimaryColor:Primária>」 jogada será registrada na 「<DerivativeCardKeywords_116:Paleta>」. Se houver 2 tipos diferentes de 「<PrimaryColor:Primária>」 na 「<DerivativeCardKeywords_116:Paleta>」, isso concederá um bônus contínuo. \nSe houver 3 tipos diferentes de 「<PrimaryColor:Primária>」 na 「<DerivativeCardKeywords_116:Paleta>」, todos os inimigos perdem 5% da vida máxima imediatamente e 「<DerivativeCardKeywords_116:Paleta>」 será esvaziada."
  },
  RelicConfig_98274_Name = {
    Text = "Paleta de Ilusões"
  },
  RelicConfig_98274_StoryDesc = {
    Text = "Na Anomalia, testemunharemos o nascimento da \"arte\"."
  },
  RelicConfig_98367_BattleDesc = {
    Text = "Todos os despertos têm um aumento de [Arg1]% no efeito base de recuperação de vida e escudo que causam."
  },
  RelicConfig_98367_Desc = {
    Text = "Todos os despertos têm um aumento de [Arg1]% no efeito base de recuperação de vida e escudo que causam."
  },
  RelicConfig_98367_Name = {
    Text = "<WhiteQuality:Pele de Serpente>"
  },
  RelicConfig_98367_StoryDesc = {
    Text = "Renascido da casca mutilada"
  },
  RelicConfig_98368_BattleDesc = {
    Text = "Ao início da batalha, ganha [Arg1]% de aumento de dano. Cada carta de comando jogada de um despertado diferente concede adicionalmente [Arg1]% de aumento de dano temporário."
  },
  RelicConfig_98368_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de dano forte. Cada carta de comando jogada de um despertador diferente concede adicionalmente [Arg1]% de dano forte temporário."
  },
  RelicConfig_98368_Name = {
    Text = "<OrangeQuality:Calidoscópio+>"
  },
  RelicConfig_98368_StoryDesc = {
    Text = "Tudo que vejo e penso é ilusão"
  },
  RelicConfig_98369_BattleDesc = {
    Text = "Após usar o Despertar da Chave de Prata, as [Arg1] cartas com a aritmética mais alta em sua mão ganham retenção e preparação antes de serem jogadas pela próxima vez, e você obtém [Arg2] pontos de energia da chave de prata."
  },
  RelicConfig_98369_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, as [Arg1] cartas com a aritmética mais alta em sua mão ganham Retenção e Preparação antes de serem jogadas pela próxima vez, e você obtém [Arg2] pontos de energia de chave de prata."
  },
  RelicConfig_98369_Name = {
    Text = "<WhiteQuality:Álbum de Selos Estrangeiros>"
  },
  RelicConfig_98369_StoryDesc = {
    Text = "Pensamentos quantificados"
  },
  RelicConfig_98370_BattleDesc = {
    Text = "Ao início da batalha, aplica [Arg1] camadas de fraqueza e vulnerabilidade a todos os inimigos. Este efeito também é ativado após a \"Aniquilação\", mas possui um tempo de recarga de 3 turnos."
  },
  RelicConfig_98370_Desc = {
    Text = "Ao início da batalha, aplica [Arg1] camadas de fraqueza e vulnerabilidade a todos os inimigos. Este efeito também é ativado após a \"Aniquilação\", mas possui um tempo de recarga de 3 turnos."
  },
  RelicConfig_98370_Name = {
    Text = "<WhiteQuality:Distorcedor de Espaço>"
  },
  RelicConfig_98370_StoryDesc = {
    Text = "Salto no Vazio"
  },
  RelicConfig_98371_BattleDesc = {
    Text = "Antes do fim do turno, o despertado proprietário de cada carta de comando na mão ganha [Arg1] de loucura."
  },
  RelicConfig_98371_Desc = {
    Text = "Antes do fim do turno, o Despertado proprietário de cada carta de comando na mão ganha [Arg1] de Loucura."
  },
  RelicConfig_98371_Name = {
    Text = "<WhiteQuality:Balança Desequilibrada>"
  },
  RelicConfig_98371_StoryDesc = {
    Text = "Não simboliza mais justiça"
  },
  RelicConfig_98372_BattleDesc = {
    Text = "No final do turno, se a Chama da Chave estiver cheia, consuma [Arg1] Chama da Chave para colocar uma <DerivativeCardKeywords_129:\"Brilho da Chave Prateada\"> em sua mão."
  },
  RelicConfig_98372_Desc = {
    Text = "No final do turno, se a Chama da Chave estiver cheia, consuma [Arg1] Chama da Chave para colocar uma <DerivativeCardKeywords_129:\"Brilho da Chave Prateada\"> em sua mão."
  },
  RelicConfig_98372_Name = {
    Text = "<WhiteQuality:Na Luz do Crepúsculo>"
  },
  RelicConfig_98372_StoryDesc = {
    Text = "Vamos tirar uma foto juntos! Sinta a dor real"
  },
  RelicConfig_98373_BattleDesc = {
    Text = "Libere a \"exaltação\" para ganhar [Arg1] pontos de s-energia, podendo ser ativado no máximo 3 vezes por turno."
  },
  RelicConfig_98373_Desc = {
    Text = "Libere a \"exaltação\" para ganhar [Arg1] pontos de s-energia, podendo ser ativado no máximo 3 vezes por turno."
  },
  RelicConfig_98373_Name = {
    Text = "<OrangeQuality:Momento de Beleza+>"
  },
  RelicConfig_98373_StoryDesc = {
    Text = "Preserve a beleza efêmera para sempre"
  },
  RelicConfig_98374_BattleDesc = {
    Text = "Após a primeira vez em cada turno que um \"mandato\" é usado, aplique [Arg1] camadas de veneno a todos os inimigos e ganhe [Arg2] camadas de contra-ataque."
  },
  RelicConfig_98374_Desc = {
    Text = "Após a primeira utilização de «Chave» em cada turno, aplique [Arg1] camadas de veneno a todos os inimigos e ganhe [Arg2] camadas de contra-ataque."
  },
  RelicConfig_98374_Name = {
    Text = "<OrangeQuality:Lâmpada dos Desejos do Profeta+>"
  },
  RelicConfig_98374_StoryDesc = {
    Text = "Atenda ao seu desejo"
  },
  RelicConfig_98375_BattleDesc = {
    Text = "No final do turno, se a Chave de Fogo estiver cheia, consuma [Arg1] pontos de Chave de Fogo para colocar uma <DerivativeCardKeywords_67:\"Aurora da Chave de Prata\"> na sua mão."
  },
  RelicConfig_98375_Desc = {
    Text = "No final do turno, se a Chave de Fogo estiver cheia, consuma [Arg1] pontos de Chave de Fogo para colocar uma <DerivativeCardKeywords_67:\"Aurora da Chave de Prata\"> na sua mão."
  },
  RelicConfig_98375_Name = {
    Text = "<OrangeQuality:No Crepúsculo+>"
  },
  RelicConfig_98375_StoryDesc = {
    Text = "Vamos tirar uma foto juntos! Sinta a dor real"
  },
  RelicConfig_98376_BattleDesc = {
    Text = "Todos os despertos têm um aumento de [Arg1]% no efeito base de recuperação de vida e escudo que causam."
  },
  RelicConfig_98376_Desc = {
    Text = "Todos os despertos têm um aumento de [Arg1]% no efeito base de recuperação de vida e escudo que causam."
  },
  RelicConfig_98376_Name = {
    Text = "<OrangeQuality:Pele de Serpente Estranha Residual+>"
  },
  RelicConfig_98376_StoryDesc = {
    Text = "Renascido da casca mutilada"
  },
  RelicConfig_98377_BattleDesc = {
    Text = "Sempre que uma carta entra no espaço ultra, compre [Arg1] cartas de comando do proprietário desta carta do monte de compra. Se não for possível comprar, receba uma quantidade equivalente de aritmética. Ativa no máximo 2 vezes por turno."
  },
  RelicConfig_98377_Desc = {
    Text = "Sempre que uma carta entra no espaço ultra, compre [Arg1] cartas de comando do proprietário desta carta do baralho. Se não for possível comprar, receba aritmética equivalente. Ativa no máximo 2 vezes por rodada."
  },
  RelicConfig_98377_Name = {
    Text = "<WhiteQuality:Prisma>"
  },
  RelicConfig_98377_StoryDesc = {
    Text = "\"A luz é composta de sete cores.\""
  },
  RelicConfig_98378_BattleDesc = {
    Text = "Ao início da batalha, ganhe [Arg1]% de eficácia aumentada de dano. Após receber dano, ganhe [Arg2] contra-ataques, com um máximo de 3 ativações por rodada."
  },
  RelicConfig_98378_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada de dano. Após receber dano, ganhe [Arg2] contra-ataques, com no máximo 3 ativações por rodada."
  },
  RelicConfig_98378_Name = {
    Text = "<OrangeQuality:Saída de Emergência+>"
  },
  RelicConfig_98378_StoryDesc = {
    Text = "Parece que ele também não conseguiu escapar"
  },
  RelicConfig_98379_BattleDesc = {
    Text = "Após causar dano ativo ou dano de tentáculo, aumente em [Arg1]% o dano de tentáculo recebido pelo alvo neste turno, com um máximo de 20 ativações por turno."
  },
  RelicConfig_98379_Desc = {
    Text = "Após causar dano ativo ou dano de tentáculo, aumente em [Arg1]% o dano de tentáculo recebido pelo alvo neste turno, com um máximo de 20 ativações por turno."
  },
  RelicConfig_98379_Name = {
    Text = "<WhiteQuality:Capacete de Mergulho>"
  },
  RelicConfig_98379_StoryDesc = {
    Text = "Sonhos são estrelas e oceanos!"
  },
  RelicConfig_98380_BattleDesc = {
    Text = "Ao início da batalha e após ativar a resistência à morte, ganhe [Arg1] pontos de s-energia."
  },
  RelicConfig_98380_Desc = {
    Text = "Ao início da batalha e após ativar a resistência à morte, ganhe [Arg1] pontos de s-energia."
  },
  RelicConfig_98380_Name = {
    Text = "<WhiteQuality:Tributo do Passado>"
  },
  RelicConfig_98380_StoryDesc = {
    Text = "Uma vez oferecido em sacrifício"
  },
  RelicConfig_98381_BattleDesc = {
    Text = "Após usar o Despertar da Chave de Prata, recupere [Heal:Arg1] pontos de Vida e ganhe [Arg2] pontos de Energia de chave."
  },
  RelicConfig_98381_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, recupere [Heal:Arg1] pontos de Vida e ganhe [Arg2] pontos de Energia de chave."
  },
  RelicConfig_98381_Name = {
    Text = "<WhiteQuality:Guarda-sol de Viagem>"
  },
  RelicConfig_98381_StoryDesc = {
    Text = "Floresce na terra sem luz"
  },
  RelicConfig_98382_BattleDesc = {
    Text = "Após o início da batalha, ganhe [Arg1] <ProficientInRealmsIconKeywords:domínio do reino>. No início dos turnos ímpares, compre [Arg2] cartas, no início dos turnos pares, ganhe [Arg2] pontos de aritmética."
  },
  RelicConfig_98382_Desc = {
    Text = "Após o início da batalha, ganhe [Arg1] <ProficientInRealmsIconKeywords:domínio do reino>. No início dos turnos ímpares, compre [Arg2] cartas, no início dos turnos pares, ganhe [Arg2] pontos de aritmética."
  },
  RelicConfig_98382_Name = {
    Text = "<OrangeQuality:Roda do Sol e Lua+>"
  },
  RelicConfig_98382_StoryDesc = {
    Text = "Adivinhe, é preto ou branco?"
  },
  RelicConfig_98383_BattleDesc = {
    Text = "Na primeira vez de cada turno em que um \"bando\" é usado, ativa todos os tentáculos para atacar [Arg1] vezes o inimigo, causando 50% de dano."
  },
  RelicConfig_98383_Desc = {
    Text = "A primeira vez de cada turno que um \"bando\" é usado, ativa todos os tentáculos para atacarem [Arg1] vezes o inimigo, causando 50% de dano."
  },
  RelicConfig_98383_Name = {
    Text = "<OrangeQuality:Caracol Amarelo+>"
  },
  RelicConfig_98383_StoryDesc = {
    Text = "Este pequeno caracol amarelo é de origem nobre, com uma linhagem perfeita e impecável"
  },
  RelicConfig_98384_BattleDesc = {
    Text = "Todos os Despertadores têm um aumento de [Arg1]% no dano base causado. Antes de liberar a Explosão de Loucura, o Despertador que liberar a Explosão de Loucura terá um aumento temporário de [Arg2]% no dano base causado."
  },
  RelicConfig_98384_Desc = {
    Text = "Todos os despertadores têm um aumento de [Arg1]% no dano base causado. Antes de liberar a explosão de loucura, o despertador que a liberar terá um aumento temporário de [Arg2]% no dano base causado."
  },
  RelicConfig_98384_Name = {
    Text = "<WhiteQuality:Sangue do Esquecido>"
  },
  RelicConfig_98384_StoryDesc = {Text = "Derretendo"},
  RelicConfig_98385_BattleDesc = {
    Text = "Após a primeira utilização de \"Chave\" em cada turno, aplique [Arg1] camadas de veneno a todos os inimigos e ganhe [Arg2] camadas de contra-ataque."
  },
  RelicConfig_98385_Desc = {
    Text = "Após a primeira utilização de \"Chave\" em cada turno, aplique [Arg1] camadas de veneno a todos os inimigos e ganhe [Arg2] camadas de contra-ataque."
  },
  RelicConfig_98385_Name = {
    Text = "<WhiteQuality:Lâmpada dos Desejos do Profeta>"
  },
  RelicConfig_98385_StoryDesc = {
    Text = "Atenda ao seu desejo"
  },
  RelicConfig_98386_BattleDesc = {
    Text = "No início do turno, se a vida estiver abaixo de 50%, aumenta temporariamente o dano forte em [Arg1]%. Se a vida estiver abaixo de 25%, compre [Arg2] cartas extras e ganhe [Arg2] Aritmética."
  },
  RelicConfig_98386_Desc = {
    Text = "No início do turno, se a vida estiver abaixo de 50%, aumenta temporariamente o dano forte em [Arg1]%. Se a vida estiver abaixo de 25%, compre [Arg2] cartas extras e ganhe [Arg2] Aritmética."
  },
  RelicConfig_98386_Name = {
    Text = "<WhiteQuality:maleta do doutor>"
  },
  RelicConfig_98386_StoryDesc = {
    Text = "A mala que simboliza a identidade de médico é muito pesada.\n\nAquele que a abre pode não ser um verdadeiro médico.\n"
  },
  RelicConfig_98387_BattleDesc = {
    Text = "Ao início da batalha, aplica [Arg1] camadas de fraqueza e vulnerabilidade a todos os inimigos. Este efeito também é ativado após a \"Aniquilação\", mas possui um tempo de recarga de 3 turnos."
  },
  RelicConfig_98387_Desc = {
    Text = "Ao início da batalha, aplica [Arg1] camadas de fraqueza e vulnerabilidade a todos os inimigos. Este efeito também é ativado após a \"Aniquilação\", mas possui um tempo de recarga de 3 turnos."
  },
  RelicConfig_98387_Name = {
    Text = "<OrangeQuality:Espaço Distorcido+>"
  },
  RelicConfig_98387_StoryDesc = {
    Text = "Salto no Vazio"
  },
  RelicConfig_98388_BattleDesc = {
    Text = "Ao início da batalha e após ativar a resistência à morte, ganhe [Arg1] pontos de s-energia."
  },
  RelicConfig_98388_Desc = {
    Text = "Ao início da batalha e após ativar a resistência à morte, ganhe [Arg1] pontos de s-energia."
  },
  RelicConfig_98388_Name = {
    Text = "<OrangeQuality:Oferta Antiga+>"
  },
  RelicConfig_98388_StoryDesc = {
    Text = "Uma vez oferecido em sacrifício"
  },
  RelicConfig_98389_BattleDesc = {
    Text = "Após o início da batalha, ganhe [Arg1] <ProficientInRealmsIconKeywords:domínio do reino>. No início dos turnos ímpares, compre [Arg2] cartas, no início dos turnos pares, ganhe [Arg2] pontos de aritmética."
  },
  RelicConfig_98389_Desc = {
    Text = "Após o início da batalha, ganhe [Arg1] <ProficientInRealmsIconKeywords:domínio do reino>. No início dos turnos ímpares, compre [Arg2] cartas, no início dos turnos pares, ganhe [Arg2] pontos de aritmética."
  },
  RelicConfig_98389_Name = {
    Text = "<WhiteQuality:Roda do Sol e da Lua>"
  },
  RelicConfig_98389_StoryDesc = {
    Text = "Adivinhe, é preto ou branco?"
  },
  RelicConfig_98390_BattleDesc = {
    Text = "Cada vez que comprar ou descartar uma carta, ganhe [Arg1] pontos de força temporária, com um máximo de 15 ativações por turno."
  },
  RelicConfig_98390_Desc = {
    Text = "Cada vez que comprar ou descartar uma carta, ganhe [Arg1] pontos de força temporária, com um máximo de 15 ativações por turno."
  },
  RelicConfig_98390_Name = {
    Text = "<WhiteQuality:Prelúdio Silencioso>"
  },
  RelicConfig_98390_StoryDesc = {
    Text = "O violino do famoso violinista Eric Eckstein.\nAgora, não pode mais ser tocado"
  },
  RelicConfig_98391_BattleDesc = {
    Text = "A primeira vez de cada turno que uma \"chave de ordem\" é usada, aumenta a força de dano temporária em +[Arg2]%, e o efeito é maior quanto menor for a vida."
  },
  RelicConfig_98391_Desc = {
    Text = "A primeira vez de cada turno que uma \"chave de ordem\" é usada, aumenta a força de dano temporária em +[Arg1]%, e o efeito é maior quanto menor for a vida."
  },
  RelicConfig_98391_Name = {
    Text = "<WhiteQuality:Elixir de Harford>"
  },
  RelicConfig_98391_StoryDesc = {
    Text = "Droga de composição desconhecida.\nDizem que o famoso violinista Eric a aprecia"
  },
  RelicConfig_98392_BattleDesc = {
    Text = "A primeira vez de cada turno que uma \"chave de ordem\" é usada, aumenta a força de dano temporária em +[Arg2]%, e o efeito é maior quanto menor for a vida."
  },
  RelicConfig_98392_Desc = {
    Text = "A primeira vez de cada turno que uma \"chave de ordem\" é usada, aumenta a força de dano temporária em +[Arg1]%, e o efeito é maior com menos vida."
  },
  RelicConfig_98392_Name = {
    Text = "<OrangeQuality:Elixir de Harford+>"
  },
  RelicConfig_98392_StoryDesc = {
    Text = "Droga de composição desconhecida.\nDizem que o famoso violinista Eric a aprecia"
  },
  RelicConfig_98393_BattleDesc = {
    Text = "Todos os despertados ganham [Arg1] pontos de s-energia ao usar uma \"carta de comando\" pela primeira vez em cada turno."
  },
  RelicConfig_98393_Desc = {
    Text = "Todos os despertos ganham [Arg1] pontos de s-energia ao usar uma \"carta de comando\" pela primeira vez em cada turno."
  },
  RelicConfig_98393_Name = {
    Text = "<WhiteQuality:Língua Afiada>"
  },
  RelicConfig_98393_StoryDesc = {
    Text = "Não só os comerciantes são eloquentes, mas também os devotos"
  },
  RelicConfig_98394_BattleDesc = {
    Text = "Na primeira vez de cada turno que um \"bando\" é usado, devolve [Arg1]% da s-energia consumida."
  },
  RelicConfig_98394_Desc = {
    Text = "Na primeira vez de cada turno que um \"bando\" é usado, devolve [Arg1]% da s-energia consumida."
  },
  RelicConfig_98394_Name = {
    Text = "<WhiteQuality:Pé de Coelho da Sorte>"
  },
  RelicConfig_98394_StoryDesc = {
    Text = "Para o coelho, não foi tão sortudo"
  },
  RelicConfig_98395_BattleDesc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada em dano. Após causar dano ativo, aplique [Arg2] camadas de veneno em todos os inimigos, podendo ser ativado no máximo 5 vezes por rodada."
  },
  RelicConfig_98395_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada em dano. Após causar dano ativo, aplique [Arg2] camadas de veneno a todos os inimigos, podendo ser ativado no máximo 5 vezes por rodada."
  },
  RelicConfig_98395_Name = {
    Text = "<OrangeQuality:Cetro do Sacerdote+>"
  },
  RelicConfig_98395_StoryDesc = {
    Text = "Devoção não permitida"
  },
  RelicConfig_98396_BattleDesc = {
    Text = "Ao início da batalha, ganha [Arg1]% de aumento de dano. Cada carta de comando de um despertado diferente jogada concede adicionalmente [Arg1]% de aumento de dano temporário."
  },
  RelicConfig_98396_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de aumento de dano. Cada carta de comando jogada de um despertado diferente concede adicionalmente [Arg1]% de aumento de dano temporário."
  },
  RelicConfig_98396_Name = {
    Text = "<WhiteQuality:Calidoscópio>"
  },
  RelicConfig_98396_StoryDesc = {
    Text = "Tudo que vejo e penso é ilusão"
  },
  RelicConfig_98397_BattleDesc = {
    Text = "Após liberar o segundo \"bando\" em cada turno, ganhe [Arg1] pontos de s-energia e todos os despertadores ganham [Arg2] pontos de aliemus."
  },
  RelicConfig_98397_Desc = {
    Text = "Após liberar o segundo \"bando\" em cada turno, ganhe [Arg1] pontos de s-energia e todos os despertos ganham [Arg2] pontos de loucura."
  },
  RelicConfig_98397_Name = {
    Text = "<OrangeQuality:Cronômetro Preciso+>"
  },
  RelicConfig_98397_StoryDesc = {
    Text = "Uma das invenções mais malignas da humanidade"
  },
  RelicConfig_98398_BattleDesc = {
    Text = "No início da batalha, faz todos os inimigos perderem temporariamente [Arg1] pontos de força. Usar a \"Fornalha Carmesim\" também ativa esse efeito, mas tem um tempo de recarga de 3 turnos."
  },
  RelicConfig_98398_Desc = {
    Text = "No início da batalha, faz todos os inimigos perderem temporariamente [Arg1] pontos de força. Usar a \"Fornalha Carmesim\" também ativa esse efeito, mas tem um tempo de recarga de 3 turnos."
  },
  RelicConfig_98398_Name = {
    Text = "<OrangeQuality:Mãos Leves+>"
  },
  RelicConfig_98398_StoryDesc = {
    Text = "Ferramenta perfeita para matar e roubar"
  },
  RelicConfig_98399_BattleDesc = {
    Text = "Após liberar o segundo \"bando\" em cada turno, ganhe [Arg1] pontos de s-energia e todos os despertos ganham [Arg2] pontos de loucura."
  },
  RelicConfig_98399_Desc = {
    Text = "Após liberar o segundo \"bando\" em cada turno, ganhe [Arg1] pontos de s-energia e todos os despertados ganham [Arg2] pontos de loucura."
  },
  RelicConfig_98399_Name = {
    Text = "<WhiteQuality:Cronômetro Preciso>"
  },
  RelicConfig_98399_StoryDesc = {
    Text = "Uma das invenções mais malignas da humanidade"
  },
  RelicConfig_98400_BattleDesc = {
    Text = "Cada vez que comprar ou descartar uma carta, ganhe [Arg1] pontos de força temporária, com máximo de 15 ativações por turno."
  },
  RelicConfig_98400_Desc = {
    Text = "Cada vez que comprar ou descartar uma carta, ganhe [Arg1] pontos de força temporária, com um máximo de 15 ativações por turno."
  },
  RelicConfig_98400_Name = {
    Text = "<OrangeQuality:Prelúdio Silencioso+>"
  },
  RelicConfig_98400_StoryDesc = {
    Text = "O violino do famoso violinista Eric Eckstein.\nAgora, não pode mais ser tocado"
  },
  RelicConfig_98401_BattleDesc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada de dano. Na primeira vez que receber um contra-ataque em cada turno, ganhe [Arg2] aritméticas."
  },
  RelicConfig_98401_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada de dano. Na primeira vez que receber um contra-ataque em cada turno, ganhe [Arg2] aritméticas."
  },
  RelicConfig_98401_Name = {
    Text = "<OrangeQuality:Jornal da Manhã de Putney+>"
  },
  RelicConfig_98401_StoryDesc = {
    Text = "Seu companheiro de banheiro mais fiel"
  },
  RelicConfig_98402_BattleDesc = {
    Text = "Após causar dano ativo ou dano de tentáculo, aumente em [Arg1]% o dano de tentáculo recebido pelo alvo neste turno, com um máximo de 20 ativações por turno."
  },
  RelicConfig_98402_Desc = {
    Text = "Após causar dano ativo ou dano de tentáculo, aumente em [Arg1]% o dano de tentáculo sofrido pelo alvo neste turno, com um máximo de 20 ativações por turno."
  },
  RelicConfig_98402_Name = {
    Text = "<OrangeQuality:Capacete de Mergulho+>"
  },
  RelicConfig_98402_StoryDesc = {
    Text = "Sonhos são estrelas e oceanos!"
  },
  RelicConfig_98403_BattleDesc = {
    Text = "Ao iniciar a batalha, obtenha [Arg1] pontos de <PowerIconKeywords:poder>. Cada vez que jogar uma carta com \"consumo\", ganhe [Arg2] pontos de <PowerIconKeywords:força> temporária, com um máximo de 10 ativações por turno."
  },
  RelicConfig_98403_Desc = {
    Text = "Ao iniciar a batalha, obtenha [Arg1] pontos de <PowerIconKeywords:poder>. Cada vez que jogar uma carta com \"consumo\", ganhe [Arg2] pontos de <PowerIconKeywords:força> temporária, com um máximo de 10 ativações por turno."
  },
  RelicConfig_98403_Name = {
    Text = "<OrangeQuality:Caixinha de Música+>"
  },
  RelicConfig_98403_StoryDesc = {
    Text = "A mansão de Dexter tem muitas coleções. Antes de ser quebrada, a caixinha de música era o brinquedo favorito da pequena Senhorita Dexter.\nCom o tempo, quando a Senhorita Dexter a encontrou novamente, os mecanismos estavam frouxos e a música desafinada, mas ainda girava"
  },
  RelicConfig_98404_BattleDesc = {
    Text = "Libere a \"exaltação\" para ganhar [Arg1] pontos de s-energia, podendo ser ativado no máximo 3 vezes por turno."
  },
  RelicConfig_98404_Desc = {
    Text = "Libere a \"exaltação\" para ganhar [Arg1] pontos de s-energia, podendo ser ativado no máximo 3 vezes por turno."
  },
  RelicConfig_98404_Name = {
    Text = "<WhiteQuality:Momento Belo>"
  },
  RelicConfig_98404_StoryDesc = {
    Text = "Preserve a beleza efêmera para sempre"
  },
  RelicConfig_98405_BattleDesc = {
    Text = "Todos os despertados ganham [Arg1] pontos de s-energia na primeira vez que uma \"carta de comando\" é usada em cada turno."
  },
  RelicConfig_98405_Desc = {
    Text = "Todos os despertados ganham [Arg1] pontos de s-energia na primeira vez que uma \"carta de comando\" é usada em cada turno."
  },
  RelicConfig_98405_Name = {
    Text = "<OrangeQuality:Língua Afiada+>"
  },
  RelicConfig_98405_StoryDesc = {
    Text = "Não só os comerciantes são eloquentes, mas também os devotos"
  },
  RelicConfig_98406_BattleDesc = {
    Text = "Ganhe [Arg1] Fornalha carmesim para cada \"embrião\" gerado, ativando até 3 vezes por turno."
  },
  RelicConfig_98406_Desc = {
    Text = "Ganhe [Arg1] Fornalha carmesim para cada \"embrião\" gerado, ativando até 3 vezes por turno."
  },
  RelicConfig_98406_Name = {
    Text = "<OrangeQuality:Querido tesouro+>"
  },
  RelicConfig_98406_StoryDesc = {
    Text = "O carpinteiro fez um boneco de madeira para sua esposa, que substituiria seu filho, dormindo em seu ventre"
  },
  RelicConfig_98407_BattleDesc = {
    Text = "Na primeira vez de cada turno que usar \"Chave\", devolve [Arg1]% da s-energia consumida."
  },
  RelicConfig_98407_Desc = {
    Text = "Na primeira vez de cada turno, a chave devolve [Arg1]% da s-energia consumida."
  },
  RelicConfig_98407_Name = {
    Text = "<OrangeQuality:Pé de Coelho da Sorte+>"
  },
  RelicConfig_98407_StoryDesc = {
    Text = "Para o coelho, não foi tão sortudo"
  },
  RelicConfig_98408_BattleDesc = {
    Text = "No início do turno, todos os despertos que não têm Loucura suficiente para liberar a Explosão de Loucura ganham [Arg1] pontos de Loucura."
  },
  RelicConfig_98408_Desc = {
    Text = "No início do turno, todos os despertos que não têm Loucura suficiente para liberar a Exaltação ganham [Arg1] pontos de Loucura."
  },
  RelicConfig_98408_Name = {
    Text = "<WhiteQuality:Hora do Ovo de Páscoa>"
  },
  RelicConfig_98408_StoryDesc = {
    Text = "Aproveite, mas não coma"
  },
  RelicConfig_98409_BattleDesc = {
    Text = "No início da batalha, faz todos os inimigos perderem temporariamente [Arg1] pontos de força. Usar a \"Fornalha Carmesim\" também ativa esse efeito, mas tem um tempo de recarga de 3 turnos."
  },
  RelicConfig_98409_Desc = {
    Text = "No início da batalha, faz todos os inimigos perderem temporariamente [Arg1] pontos de força. Usar a \"Fornalha Carmesim\" também ativa esse efeito, mas tem tempo de recarga de 3 turnos."
  },
  RelicConfig_98409_Name = {
    Text = "<WhiteQuality:Mãos Leves>"
  },
  RelicConfig_98409_StoryDesc = {
    Text = "Ferramenta perfeita para matar e roubar"
  },
  RelicConfig_98410_BattleDesc = {
    Text = "Ganhe [Arg1] Fornalha carmesim para cada \"embrião\" gerado, ativando até 3 vezes por turno."
  },
  RelicConfig_98410_Desc = {
    Text = "Ganhe [Arg1] Fornalha carmesim para cada \"embrião\" gerado, ativando até 3 vezes por turno."
  },
  RelicConfig_98410_Name = {
    Text = "<WhiteQuality:Querido Bebê>"
  },
  RelicConfig_98410_StoryDesc = {
    Text = "O carpinteiro fez um boneco de madeira para sua esposa, que substituiria seu filho, dormindo em seu ventre"
  },
  RelicConfig_98411_BattleDesc = {
    Text = "No início do turno, se a energia da chave de prata for maior que [Arg1], consuma [Arg1] pontos de energia da chave de prata para colocar 1 <DerivativeCardKeywords_115:\"Inspiração Avançada\"> em sua mão."
  },
  RelicConfig_98411_Desc = {
    Text = "No início do turno, se a energia da chave de prata for maior que [Arg1], consuma [Arg1] pontos de energia da chave de prata para colocar 1 <DerivativeCardKeywords_115:\"Inspiração Avançada\"> em sua mão."
  },
  RelicConfig_98411_Name = {
    Text = "<RedQuality:Visão do Pesadelo>"
  },
  RelicConfig_98411_StoryDesc = {
    Text = "Cuidado, o sono profundo pode engolir tudo sem que você perceba"
  },
  RelicConfig_98412_BattleDesc = {
    Text = "Após liberar 5 \"exaltações\", as próximas [Arg1] cartas de comando não derivadas terão efeito adicional 1 vez."
  },
  RelicConfig_98412_Desc = {
    Text = "Após liberar 5 vezes a \"exaltação\", as próximas [Arg1] cartas de comando não derivadas terão efeito adicional 1 vez."
  },
  RelicConfig_98412_Name = {
    Text = "<OrangeQuality:Vinho das Estrelas+>"
  },
  RelicConfig_98412_StoryDesc = {
    Text = "Vagando entre as estrelas"
  },
  RelicConfig_98413_BattleDesc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada de dano. Após receber dano, ganhe [Arg2] contra-ataques, com no máximo 3 ativações por rodada."
  },
  RelicConfig_98413_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada de dano. Após receber dano, ganhe [Arg2] contra-ataques, com um máximo de 3 ativações por rodada."
  },
  RelicConfig_98413_Name = {
    Text = "<WhiteQuality:Saída de Emergência>"
  },
  RelicConfig_98413_StoryDesc = {
    Text = "Parece que ele também não conseguiu escapar"
  },
  RelicConfig_98414_BattleDesc = {
    Text = "Todos os despertadores têm um aumento de [Arg1]% no dano base causado. Antes de liberar a explosão de loucura, o despertador que a liberar terá um aumento temporário de [Arg2]% no dano base causado."
  },
  RelicConfig_98414_Desc = {
    Text = "Todos os Despertadores têm um aumento de [Arg1]% no dano base causado. Antes de liberar a Explosão de Loucura, o Despertador que a liberar terá temporariamente um aumento de [Arg2]% no dano base causado."
  },
  RelicConfig_98414_Name = {
    Text = "<OrangeQuality:Sangue dos Esquecidos+>"
  },
  RelicConfig_98414_StoryDesc = {Text = "Derretendo"},
  RelicConfig_98415_BattleDesc = {
    Text = "Após usar o Despertar da Chave de Prata, recupere [Heal:Arg1] pontos de Vida e ganhe [Arg2] pontos de Energia de chave."
  },
  RelicConfig_98415_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, recupere [Heal:Arg1] pontos de Vida e ganhe [Arg2] pontos de Energia de chave."
  },
  RelicConfig_98415_Name = {
    Text = "<OrangeQuality:Guarda-sol de Viagem+>"
  },
  RelicConfig_98415_StoryDesc = {
    Text = "Floresce na terra sem luz"
  },
  RelicConfig_98416_BattleDesc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada em dano. Na primeira vez que receber um contra-ataque em cada turno, ganhe [Arg2] aritméticas."
  },
  RelicConfig_98416_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada em dano. Na primeira vez que receber um contra-ataque em cada turno, ganhe [Arg2] pontos de aritmética."
  },
  RelicConfig_98416_Name = {
    Text = "<WhiteQuality:Jornal da Manhã de Putney>"
  },
  RelicConfig_98416_StoryDesc = {
    Text = "Seu companheiro de banheiro mais fiel"
  },
  RelicConfig_98417_BattleDesc = {
    Text = "No início do turno, todos os despertos que não têm Loucura suficiente para liberar a Exaltação ganham [Arg1] pontos de Loucura."
  },
  RelicConfig_98417_Desc = {
    Text = "No início do turno, todos os Despertados que não têm Loucura suficiente para liberar a Explosão de Loucura ganham [Arg1] pontos de Loucura."
  },
  RelicConfig_98417_Name = {
    Text = "<OrangeQuality:Hora do Ovo de Páscoa+>"
  },
  RelicConfig_98417_StoryDesc = {
    Text = "Aproveite, mas não coma"
  },
  RelicConfig_98418_BattleDesc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada. Na primeira vez que aplicar veneno em cada turno, compre [Arg2] cartas."
  },
  RelicConfig_98418_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada de dano. Na primeira vez que aplicar veneno em cada turno, compre [Arg2] cartas."
  },
  RelicConfig_98418_Name = {
    Text = "<OrangeQuality:Papiro Rhind+>"
  },
  RelicConfig_98418_StoryDesc = {
    Text = "Agora, a pergunta: 10 monges dividem 6 pães, quanto cada um recebe?"
  },
  RelicConfig_98419_BattleDesc = {
    Text = "Após liberar 5 \"exaltações\", as próximas [Arg1] cartas de comando não derivadas terão efeito adicional 1 vez."
  },
  RelicConfig_98419_Desc = {
    Text = "Após liberar 5 \"exaltações\", as próximas [Arg1] cartas de comando não derivadas terão efeito adicional 1 vez."
  },
  RelicConfig_98419_Name = {
    Text = "<WhiteQuality:Vinho das Estrelas>"
  },
  RelicConfig_98419_StoryDesc = {
    Text = "Vagando entre as estrelas"
  },
  RelicConfig_98420_BattleDesc = {
    Text = "Sempre que uma carta entrar no espaço ultra, compre [Arg1] cartas de comando do proprietário desta carta do baralho. Se não for possível comprar, receba aritmética equivalente. Ativa no máximo 2 vezes por rodada."
  },
  RelicConfig_98420_Desc = {
    Text = "Sempre que uma carta entrar no espaço ultra, compre [Arg1] cartas de comando do proprietário desta carta do baralho. Se não for possível comprar, receba uma quantidade equivalente de aritmética. Ativa no máximo 2 vezes por turno."
  },
  RelicConfig_98420_Name = {
    Text = "<OrangeQuality:Prisma+>"
  },
  RelicConfig_98420_StoryDesc = {
    Text = "\"A luz é composta de sete cores.\""
  },
  RelicConfig_98421_BattleDesc = {
    Text = "Após usar o Despertar da Chave de Prata, as [Arg1] cartas com a aritmética mais alta em sua mão ganham retenção e preparação antes de serem jogadas pela próxima vez, e você obtém [Arg2] pontos de energia da chave de prata."
  },
  RelicConfig_98421_Desc = {
    Text = "Após usar o Despertar da Chave de Prata, as [Arg1] cartas com a maior aritmética em sua mão ganham retenção e preparação antes de serem jogadas pela próxima vez, e você obtém [Arg2] pontos de energia da chave de prata."
  },
  RelicConfig_98421_Name = {
    Text = "<OrangeQuality:Porta-selos Estranho+>"
  },
  RelicConfig_98421_StoryDesc = {
    Text = "Pensamentos quantificados"
  },
  RelicConfig_98422_BattleDesc = {
    Text = "Antes do fim do turno, cada Despertado proprietário de uma carta de comando na mão ganha [Arg1] de Loucura."
  },
  RelicConfig_98422_Desc = {
    Text = "Antes do fim do turno, cada Despertado que possua uma carta de comando na mão ganha [Arg1] pontos de loucura."
  },
  RelicConfig_98422_Name = {
    Text = "<OrangeQuality:Balança Desequilibrada+>"
  },
  RelicConfig_98422_StoryDesc = {
    Text = "Não simboliza mais justiça"
  },
  RelicConfig_98423_BattleDesc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada em dano. Após causar dano ativo, aplique [Arg2] camadas de veneno a todos os inimigos, podendo ser ativado no máximo 5 vezes por rodada."
  },
  RelicConfig_98423_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia de dano aumentada. Após causar dano ativo, aplique [Arg2] camadas de veneno a todos os inimigos. Pode ser ativado no máximo 5 vezes por rodada."
  },
  RelicConfig_98423_Name = {
    Text = "<WhiteQuality:Cajado do Sacerdote>"
  },
  RelicConfig_98423_StoryDesc = {
    Text = "Devoção não permitida"
  },
  RelicConfig_98424_BattleDesc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada em dano. Na primeira vez que aplicar veneno em cada turno, compre [Arg2] cartas."
  },
  RelicConfig_98424_Desc = {
    Text = "Ao início da batalha, ganha [Arg1]% de eficácia aumentada em dano. Na primeira vez que aplicar veneno em cada turno, compre [Arg2] cartas."
  },
  RelicConfig_98424_Name = {
    Text = "<WhiteQuality:Papiro de Reind>"
  },
  RelicConfig_98424_StoryDesc = {
    Text = "Agora, a pergunta: 10 monges dividem 6 pães, quanto cada um recebe?"
  },
  RelicConfig_98425_BattleDesc = {
    Text = "Ao iniciar a batalha, obtenha [Arg1] pontos de poder. Cada vez que jogar uma carta com \"consumo\", ganhe [Arg2] pontos de força temporária, com um máximo de 10 ativações por turno."
  },
  RelicConfig_98425_Desc = {
    Text = "Ao iniciar a batalha, obtenha [Arg1] pontos de poder. Cada vez que jogar uma carta com \"consumo\", ganhe [Arg2] pontos de força temporária, com um máximo de 10 ativações por turno."
  },
  RelicConfig_98425_Name = {
    Text = "<WhiteQuality:Caixinha de Música>"
  },
  RelicConfig_98425_StoryDesc = {
    Text = "A mansão de Dexter tem muitas coleções. Antes de ser quebrada, a caixinha de música era o brinquedo favorito da pequena Senhorita Dexter.\nCom o tempo, quando a Senhorita Dexter a encontrou novamente, os mecanismos estavam frouxos e a música desafinada, mas ainda girava"
  },
  RelicConfig_98426_BattleDesc = {
    Text = "A primeira vez de cada turno que um \"bando\" é usado, ativa todos os tentáculos para atacarem [Arg1] vezes o inimigo, causando 50% de dano."
  },
  RelicConfig_98426_Desc = {
    Text = "A primeira vez de cada turno que um \"bando\" é usado, ativa todos os tentáculos para atacarem [Arg1] vezes o inimigo, causando 50% de dano."
  },
  RelicConfig_98426_Name = {
    Text = "<WhiteQuality:Caracol Amarelo>"
  },
  RelicConfig_98426_StoryDesc = {
    Text = "Este pequeno caracol amarelo é de origem nobre, com uma linhagem perfeita e impecável"
  },
  RelicConfig_98427_BattleDesc = {
    Text = "No início do turno, se a vida estiver abaixo de 50%, aumenta temporariamente o dano forte em [Arg1]%. Se a vida estiver abaixo de 25%, compre [Arg2] cartas extras e ganhe [Arg2] Aritmética."
  },
  RelicConfig_98427_Desc = {
    Text = "No início do turno, se a vida estiver abaixo de 50%, aumenta temporariamente o dano forte em [Arg1]%. Se a vida estiver abaixo de 25%, compre [Arg2] cartas extras e ganhe [Arg2] Aritmética."
  },
  RelicConfig_98427_Name = {
    Text = "<OrangeQuality:Maleta de Médico+>"
  },
  RelicConfig_98427_StoryDesc = {
    Text = "A mala que simboliza a identidade de médico é muito pesada.\n\nAquele que a abre pode não ser um verdadeiro médico.\n"
  },
  RelicConfig_98891_BattleDesc = {
    Text = "Após o início da batalha, ganhe 5 camadas de \"<LostWay:Perdido>\", reduzindo 1 camada a cada 3 cartas de comando jogadas. \n Após remover todas as camadas de \"<LostWay:Perdido>\", todos os Corpos Despertos ganham 100 pontos de Fúria, recuperando [Arg1] pontos de Vida a cada 3 cartas de comando jogadas e aplicando <Corrosion:Corrosão> de 1% da Vida máxima do inimigo na linha da frente."
  },
  RelicConfig_98891_Desc = {
    Text = "Após o início da batalha, ganhe 5 camadas de \"<LostWay:Perdido>\", reduzindo 1 camada a cada 3 cartas de comando jogadas. \n Após remover todas as camadas de \"<LostWay:Perdido>\", todos os Corpos Despertos ganham 100 pontos de Fúria, recuperando [Arg1] pontos de Vida a cada 3 cartas de comando jogadas e aplicando <Corrosion:Corrosão> de 1% da Vida máxima do inimigo na linha da frente."
  },
  RelicConfig_98891_Name = {
    Text = "alma artificial"
  },
  RelicConfig_98891_StoryDesc = {
    Text = "Mesmo diante de experiências sombrias, a Lanterna da Salvação brilhará novamente na morte."
  }
})
return Text_RelicConfig
