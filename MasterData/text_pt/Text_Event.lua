__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Event = readonly({
  Event_116371_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116371_Desc = {
    Text = "Você aceita o pedido de contato da escola, a voz familiar te acalma. Você se recompõe e segue em frente"
  },
  Event_116371_Name = {
    Text = "Ponto de contato"
  },
  Event_116372_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116372_Desc = {
    Text = "Você ativou um quarto desconhecido."
  },
  Event_116372_Name = {
    Text = "Desconhecido"
  },
  Event_116373_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116373_Desc = {
    Text = "Você encontrou o tesouro."
  },
  Event_116373_Name = {Text = "tesouro"},
  Event_116374_ChoiceDesc1 = {
    Text = "[Conectar]recuperar Arg2 de vida"
  },
  Event_116374_Desc = {
    Text = "Você explora na névoa, de repente, o emblema no seu peito emite um fraco brilho prateado. Quem está chamando você do outro lado do comunicador?"
  },
  Event_116374_Name = {
    Text = "Ponto de contato"
  },
  Event_116389_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116389_Desc = {
    Text = "Apertar o rosto ainda está dormindo...zzZZ"
  },
  Event_116389_Name = {
    Text = "Apertar o rosto"
  },
  Event_116429_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116429_Desc = {
    Text = "Você ativou um Evento aleatório3."
  },
  Event_116429_Name = {
    Text = "Evento aleatório3"
  },
  Event_116430_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116430_Desc = {
    Text = "Você ativou um Evento aleatório1."
  },
  Event_116430_Name = {
    Text = "Evento aleatório1"
  },
  Event_116431_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116431_Desc = {
    Text = "Você ativou um Evento aleatório2."
  },
  Event_116431_Name = {
    Text = "Evento aleatório2"
  },
  Event_117279_ChoiceDesc1 = {
    Text = "[Você já desejou inocência] Coloque 3 cartas de[(Skill.Arg1)] no baralho."
  },
  Event_117279_Desc = {
    Text = "\nA névoa branca e tênue se eleva sobre o nível do mar, envolvendo tudo em uma penumbra. \nAtravessando a fronteira entre a vida e a morte, a distância entre dentro e fora da porta, atravessando memórias longas e desbotadas, você vê a silhueta de uma dama sob um guarda-sol contra a luz. \nO tempo que passou com ela já se foi, assim como sua juventude, delicada mas vibrante em cores. \nEsperando que o falso sol se levante, a névoa se desfeita na invisibilidade, e sua sombra balança nos sonhos, transformando-se em bolhas etéreas e leves, despedindo-se de você em silêncio."
  },
  Event_117279_Name = {
    Text = "O Fantasma de Murphy"
  },
  Event_117280_ChoiceDesc1 = {
    Text = "[Você já desejou a inocência] escolha 2 cartas para conferir a gravura \"Eco do Mar Profundo\"."
  },
  Event_117280_Desc = {
    Text = "\nUma névoa branca e fina se eleva sobre o nível do mar, envolvendo tudo em uma penumbra. \nAtravessando os limites entre a vida e a morte, a distância dentro e fora da porta, e as memórias que desbotaram ao longo do tempo, você vê a silhueta de uma dama com guarda-sol contra a luz. \nO tempo que passou com ela já se foi, assim como sua juventude de cores finas, mas vibrantes. \nEsperando que o falso sol nasça, a névoa se despedaça no invisível, e sua sombra também balança nos sonhos, transformando-se em bolhas leves e ilusórias, fazendo uma despedida silenciosa a você."
  },
  Event_117280_Name = {
    Text = "O Fantasma de Murphy"
  },
  Event_118414_ChoiceDesc1 = {
    Text = "[Três Pontos]"
  },
  Event_118414_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_118414_ChoiceDesc3 = {
    Text = "[One Point]"
  },
  Event_118414_Desc = {
    Text = "Os dados rolam, emitindo um som borbulhante.\nQuando vai parar?\nVocê não sabe, mas deve dar uma resposta."
  },
  Event_118414_Name = {
    Text = "Aposta do destino"
  },
  Event_118415_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118415_Desc = {
    Text = "Sua resposta torna o \"Céu\" ainda mais gentil.  \nEle suavemente coloca um beijo em sua testa.  \nEntão, uma onda de flores floresce em sua testa."
  },
  Event_118415_Name = {
    Text = "Abraço do mar"
  },
  Event_118416_ChoiceDesc1 = {
    Text = "[Mergulhar na Fantasia] Escolha 1 de 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_118416_ChoiceDesc2 = {
    Text = "[Manter a Sanidade] para cada Corpo Desperto com valor de Fúria igual ou superior a 50, ganha 15 Marca Negra"
  },
  Event_118416_ChoiceDesc3 = {
    Text = "[Sair à Força] ganha 3 opções para escolha de oração"
  },
  Event_118416_Desc = {
    Text = "Talvez seja a longa batalha que o deixou desorientado, ou talvez seja apenas seu cérebro que traiu seu corpo.\n Uma sensação de falta de peso aparece em sua mente.\n Em um instante, sua mente se transforma repentinamente em um caleidoscópio, brilhantemente colorido, piscando em todas as tonalidades de luz.\n Incontáveis insights, reflexões e fantasias inundam seu cérebro, ocupando cada canto das frestas de sua mente.\n Se isso continuar, seu cérebro em breve irá explodir com esses pensamentos caóticos."
  },
  Event_118416_Name = {
    Text = "Caleidoscópio de pensamento"
  },
  Event_118417_ChoiceDesc1 = {
    Text = "[Apostar]Desenvolver「(Skill.Arg1)」, entrar no jogo"
  },
  Event_118417_ChoiceDesc2 = {
    Text = "[Esqueça] Ganhe 25 sigilos negros"
  },
  Event_118417_Desc = {
    Text = "Em estado de torpor, sua consciência vagou por camadas de névoa, dispersando-se no espaço desconhecido.\nDois dados foram lançados à sua frente, mas a existência desconhecida que o trouxe à força até aqui permaneceu invisível.\nVocê só conseguia ouvir as vozes caóticas vindas de todas as direções.\n\"Quer voltar? Então vamos jogar uma rodada.\"\n\"Com sua vida como aposta, que o jogo com o Destino comece.\""
  },
  Event_118417_Name = {
    Text = "Aposta do destino"
  },
  Event_118418_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118418_Desc = {
    Text = "As experiências transcendentais são sempre breves. Elas chegam silenciosamente e de repente desaparecem.  \nMas pelo menos sua cabeça ainda está aqui, não explodiu de verdade."
  },
  Event_118418_Name = {
    Text = "Caleidoscópio de pensamento"
  },
  Event_118419_ChoiceDesc1 = {
    Text = "[Sair] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_118419_Desc = {
    Text = "Você não perdeu, mas também não ganhou; o resultado não é bom nem ruim.  \n\"É um empate...\"  \nA existência desconhecida suspirou, mas não havia nenhum traço de arrependimento em sua voz.  \n\"Que belo passatempo.\""
  },
  Event_118419_Name = {
    Text = "Aposta do destino"
  },
  Event_118420_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118420_Desc = {
    Text = "Você é um mestre da música, mas também um simples desafinado.\nAs notas sob seu controle fluem, e a vida em movimento finalmente ressoa no domínio"
  },
  Event_118420_Name = {
    Text = "\"Hino perfeito\""
  },
  Event_118421_ChoiceDesc1 = {
    Text = "[Perceber o Cérebro]Escolhe uma entre 3 cartas de comando para ganhar Oração:「(EnchantConfig.Arg1)」"
  },
  Event_118421_ChoiceDesc2 = {
    Text = "[Perceber a Alma]Desenvolver「(Skill.Arg1)」，re-imprintar, no máximo 2 vezes"
  },
  Event_118421_Desc = {
    Text = "A primeira prisão do ser humano é seu próprio corpo. \n Dentro dessa prisão corporal, o cérebro é a última e mais importante cela. \n \"Querida, você acha que estar viva e respirando significa que está segura?\" \n Quando seu cérebro trai sua alma, você experimentará os mais dolorosos tormentos do mundo. \n E esse tormento te acompanhará por toda a vida."
  },
  Event_118421_Name = {
    Text = "Gaiola Mental"
  },
  Event_118422_ChoiceDesc1 = {
    Text = "[Tocar a Borboleta] Remova 2 cartas"
  },
  Event_118422_ChoiceDesc2 = {
    Text = "[Afugentar a Borboleta]Obtém Criatura amaldiçoada「(RelicConfig.Arg1)」，mas desenvolve「(Skill.Arg2)」"
  },
  Event_118422_ChoiceDesc3 = {
    Text = "[Leave] Ganhar Arg1 sigilos negros"
  },
  Event_118422_Desc = {
    Text = "No Mar Profundo não há borboletas. Elas são vidas imaginadas pela menina presa no quarto. \n Elas são tão lindas, dançando livremente no ar. \n \"Se... se eu também pudesse voar como elas e sair daqui...\" \n Uma borboleta soltou um soluço, mas esse som se perdeu entre os inúmeros batimentos de asas, encoberto pelo barulho das teclas, quase inaudível."
  },
  Event_118422_Name = {
    Text = "Capítulo Borboleta"
  },
  Event_118423_ChoiceDesc1 = {
    Text = "[Cortar a Corda]infecta「(Skill.Arg1)」, ganha Criatura amaldiçoada「(RelicConfig.Arg2)」"
  },
  Event_118423_ChoiceDesc2 = {
    Text = "[Desatá-lo]Infecte duas vezes「(Skill.Arg1)」, obtenha as Criações de prata「(RelicConfig.Arg2)」e「(RelicConfig.Arg3)」"
  },
  Event_118423_ChoiceDesc3 = {
    Text = "[Libertá-lo Para Sempre]ganha Criação de prata「(RelicConfig.Arg1)」"
  },
  Event_118423_Desc = {
    Text = "\"Alguns dizem que o desejo infinito é a força motriz do progresso.\nMas quando esse desejo se torna tão poderoso que não pode mais ser ignorado ou cortado... Eu o sinto se transformar por dentro em uma jaula.\"\nUma voz fraca emergiu da escuridão. Você não conseguia ver o rosto de quem falava, apenas um par de mãos amarradas.\n\"Esses desejos se alimentam do meu medo, da minha fraqueza, da minha esperança, da minha dor... e ao fazê-lo, só se tornam mais fortes.\"\nA voz fez um último e desesperado apelo.\n\"Estou disposto a sacrificar tudo! Alma bondosa, por favor... salve-me. Ou conceda-me a libertação.\""
  },
  Event_118423_Name = {
    Text = "Vínculo de desejos"
  },
  Event_118424_ChoiceDesc1 = {
    Text = "[Perceber o Cérebro]Escolhe uma entre 3 cartas de comando para ganhar Oração:「(EnchantConfig.Arg1)」"
  },
  Event_118424_Desc = {
    Text = "A canção distante se fragmenta em estrelas:\n\"Eu amaldiçoo a poça suja no beco noturno, flores podres adornam a base da parede em ruínas, correntes se prendem ao cérebro e afundam no lodo, antes que o nevoeiro apague minha existência, o crepúsculo afundará no mais profundo @4.\""
  },
  Event_118424_Name = {
    Text = "Gaiola Mental"
  },
  Event_118425_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118425_Desc = {
    Text = "Você nada com força para cima e finalmente emerge à superfície. \n O ar misturado com o cheiro do mar invade seus pulmões, lembrando-o de que você ainda não escapou do perigo. \n Mas você sabe que o verdadeiro céu está acima de sua cabeça. \n Assim como a verdade, nunca será obscurecida por mentiras gentis."
  },
  Event_118425_Name = {
    Text = "Abraço do mar"
  },
  Event_118426_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118426_Desc = {
    Text = "No momento em que você toca a corda do Desejo, uma dor aguda surge de dentro da sua Alma.\nSeu medo, fraqueza, esperança e dor também surgem de dentro de você, se transformando em uma corda ensanguentada que amarra suas mãos.\nNesse momento, você ouve as aplaudidas maliciosas daquela voz.\n\"Pessoa de bom coração, você será recompensada... claro, também há uma maldição.\""
  },
  Event_118426_Name = {
    Text = "Vínculo de desejos"
  },
  Event_118427_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118427_Desc = {
    Text = "Seu toque faz as borboletas tremularem.\nDesde o seu nascimento, elas nunca haviam sentido tal carinho.\nAs borboletas foram dominadas por emoções confusas, a ponto de esquecerem como voar.\nAssim, incontáveis borboletas caíram, revelando a máquina de escrever que havia sido coberta por inúmeras asas.\nAquela coisa triste, que já havia perdido a vida, disparou as palavras \"liberdade\" com suas últimas forças."
  },
  Event_118427_Name = {
    Text = "Capítulo Borboleta"
  },
  Event_118428_ChoiceDesc1 = {
    Text = "[Preparar para Combate] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_118428_ChoiceDesc2 = {
    Text = "[Tentar Desviar] Obtém 25 Marcas Negras"
  },
  Event_118428_Desc = {
    Text = "No Mar Profundo, onde a luz das estrelas cai, os Marchadores de Mares hibernaram por séculos. \n As águas infinitas testemunharam sua loucura, testemunharam sua paciência, e também testemunharam sua devoção mais sincera aos deuses. \n Ninguém pode impedir a grande chegada dos deuses. \n Qualquer que atrapalhe será reduzido a cinzas pela fúria dos Marchadores de Mares."
  },
  Event_118428_Name = {
    Text = "Esperando sob as Estrelas"
  },
  Event_118429_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118429_Desc = {
    Text = "Você instinctivamente cobriu os ouvidos.\nIncrível, os sons de dentro da sua alma desapareceram.\nClaro, foi apenas temporário."
  },
  Event_118429_Name = {
    Text = "Melodia profana"
  },
  Event_118430_ChoiceDesc1 = {
    Text = "[Revisitar o Passado] Obtém 1 de 3 Orações Avançadas"
  },
  Event_118430_ChoiceDesc2 = {
    Text = "[Olhar para o Futuro] Ganha Criação de ouro \"(RelicConfig.Arg1)\", mas desenvolve \"(Skill.Arg2)\""
  },
  Event_118430_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_118430_Desc = {
    Text = "Nada no mundo pode permanecer estático.\n Até mesmo o paraíso esculpido pela Deusa Mãe não é exceção.\n Em um momento fugaz, você vislumbra algo através das fendas do tempo e do espaço.\n O passado, o presente e o futuro entrelaçam-se naquela lacuna fissurada, mudando constantemente.\n Esperando pelo seu olhar curioso"
  },
  Event_118430_Name = {
    Text = "Fenda Espacial"
  },
  Event_118431_ChoiceDesc1 = {
    Text = "[Ganhe 100 sigilos negros]"
  },
  Event_118431_ChoiceDesc2 = {
    Text = "[2 Cartas de comando aleatórias obtêm Gravura: \"(EnchantConfig.Arg1)\"]"
  },
  Event_118431_Desc = {
    Text = "Feitas de sabedoria estável, talvez essas criações tragam uma melodia harmoniosa"
  },
  Event_118431_Name = {
    Text = "\"Hino perfeito\""
  },
  Event_118432_ChoiceDesc1 = {
    Text = "[Alimentar os Ratos] ganha Criação de prata[(RelicConfig.Arg1)], desenvolve 1 sintoma"
  },
  Event_118432_ChoiceDesc2 = {
    Text = "[Afugentar os Ratos] Escolha 1 entre 3 cartas e obtenha uma Gravura de Oração:\"(EnchantConfig.Arg1)\", mas desenvolve \"(Skill.Arg2)\""
  },
  Event_118432_ChoiceDesc3 = {
    Text = "[Ignorar os Ratos] ganhe 25 Marca Negra"
  },
  Event_118432_Desc = {
    Text = "Tudo neste navio está preso no ciclo temporal.\nAté mesmo aquelas criaturas peludas e nojentas lutando para sobreviver aqui não podem escapar de seu destino.\nCiclo após ciclo, eles devoram tudo à vista, mas sua fome nunca é saciada.\n\"Tanta... fome...\"\nHordas de ratos emitem guinchos agudos e doentios.\nOs ciclos intermináveis os deixaram famintos e enlouquecidos — eles precisam comer algo.\nAgora. Imediatamente."
  },
  Event_118432_Name = {
    Text = "Bando de ratos famintos"
  },
  Event_118433_ChoiceDesc1 = {
    Text = "[Evitar o Olhar Deles]Ganhe a Criação de ouro「(RelicConfig.Arg1)」，infecção「(Skill.Arg2)」"
  },
  Event_118433_ChoiceDesc2 = {
    Text = "[Encarar os Olhos]Despertar 2 Entidades Aleatórias, Infectar duas vezes「(Skill.Arg1)」"
  },
  Event_118433_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_118433_Desc = {
    Text = "Assim como as estrelas no céu, certamente há muitos olhos no fundo do mar.\nEsses olhos pertencem a peixes que vivem no fundo do oceano, às espécies de brânquias profanadas e ao próprio oceano.\nShh, não os incomode.\nNão, perturbe a loucura do fundo do mar."
  },
  Event_118433_Name = {
    Text = "Olho do Mar Profundo"
  },
  Event_118434_ChoiceDesc1 = {
    Text = "[Ignorar os Sussurros]"
  },
  Event_118434_ChoiceDesc2 = {
    Text = "[Ouvir os Sussurros]"
  },
  Event_118434_ChoiceDesc3 = {
    Text = "[Inventar Algo]"
  },
  Event_118434_Desc = {
    Text = "\"Você deseja o favor de Deus? Quer conhecer o seu próprio significado?\"\nUm suspiro soou ao seu ouvido, como o sussurro de uma pessoa mentalmente perturbada, ou o murmúrio íntimo de algo sem forma.\nSob razão e vigilância, você rejeita aquela voz, mas ela continua falando consigo mesma.\n\"Por favor, ouça pacientemente. O que você saberá é a verdade sobre o destino do mundo...\""
  },
  Event_118434_Name = {
    Text = "Pregação do intangível"
  },
  Event_118435_ChoiceDesc1 = {
    Text = "[Perceber o Cérebro]Escolhe uma entre 3 cartas de comando para ganhar Oração:「(EnchantConfig.Arg1)」"
  },
  Event_118435_ChoiceDesc2 = {
    Text = "[Perceber a Alma]Desenvolver「(Skill.Arg1)」，novamente uma oração aleatória"
  },
  Event_118435_Desc = {
    Text = "A canção distante se fragmenta em estrelas:\n\"Eu amaldiçoo a poça suja no beco noturno, flores podres adornam a base da parede em ruínas, correntes se prendem ao cérebro e afundam no lodo, antes que o nevoeiro apague minha existência, o crepúsculo afundará no mais profundo @3.\""
  },
  Event_118435_Name = {
    Text = "Gaiola Mental"
  },
  Event_118436_ChoiceDesc1 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_118436_Desc = {
    Text = "\"Boa resposta, mas infelizmente, não é a resposta correta.\"\n\"Qual é a resposta correta?\"\nA existência desconhecida não respondeu à sua pergunta, apenas soltando uma risada desdenhosa.\n\"Quem disse que o destino tem uma resposta correta?\""
  },
  Event_118436_Name = {
    Text = "Aposta do destino"
  },
  Event_118437_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118437_Desc = {
    Text = "\"Você acha que eu não tentei cortá-las? Não—resistir ao desejo só o torna mais forte!\"\nEnquanto as cordas do desejo se apertam, cortando a carne, a voz solta um uivo desesperado.\n\"Eu nunca poderei me livrar delas... nunca!\""
  },
  Event_118437_Name = {
    Text = "Vínculo de desejos"
  },
  Event_118438_ChoiceDesc1 = {
    Text = "[Aperte o Corvo]ganhe 25 o sigilo negro, contamine「(Skill.Arg2)」，continue a escolher"
  },
  Event_118438_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Saia"
  },
  Event_118438_Desc = {
    Text = "O corvo negro está chorando.\nO corvo negro está gritando.\nO corvo negro está uivando.\nNo entanto, para os humanos, isso soa apenas como canto.\n\"Ah, que canção despreocupada. Eu gostaria de ser um corvo, longe das preocupações do mundo.\""
  },
  Event_118438_Name = {
    Text = "Lamento não percebido"
  },
  Event_118439_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118439_Desc = {
    Text = "Mesmo que as palavras sejam apagadas, você ainda pode sentir claramente o valor da carta"
  },
  Event_118439_Name = {
    Text = "Capítulo Borboleta"
  },
  Event_118440_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118440_Desc = {
    Text = "Na imagem do passado, a garota vestindo um casaco de pelúcia acena para você. \n Você não consegue ouvir o que ela disse, mas viu o sorriso da garota."
  },
  Event_118440_Name = {
    Text = "Fenda Espacial"
  },
  Event_118441_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118441_Desc = {
    Text = "O Mar Profundo voltou a ser negro e silencioso.\nNesse negro e silêncio, você ouviu novamente o som do coração batendo.\nEsse som vem de dentro de você.\nAos olhos dos outros, você é apenas um coração pulsante que flutua nas profundezas escuras do mar."
  },
  Event_118441_Name = {
    Text = "A lei do mais forte"
  },
  Event_118442_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118442_Desc = {
    Text = "Sua aparição deixa as sombras perplexas, um feixe de luz estelar passa por seus pés e a multidão desaparece, deixando a sombra mais densa em sua mão"
  },
  Event_118442_Name = {
    Text = "Esperando sob as Estrelas"
  },
  Event_118443_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118443_Desc = {
    Text = "Apesar de ter a vantagem numérica, aqueles ratos imundos são mais corajosos do que seus próprios corpos.\nEles ficam intimidados pela sua atitude forte e se dispersam em pânico."
  },
  Event_118443_Name = {
    Text = "Bando de ratos famintos"
  },
  Event_118444_ChoiceDesc1 = {
    Text = "[Alcançar uma Mão Amiga] Despertar 1 Desperto aleatório, mas desenvolver [(Skill.Arg1)]"
  },
  Event_118444_ChoiceDesc2 = {
    Text = "[Observando em Silêncio] Obtenha 1 Oração de 3"
  },
  Event_118444_Desc = {
    Text = "Um coração pulsante flutua nas profundezas escuras do mar. \n Pode pertencer a um peixe nadador, ou a algum ser com brânquias. \n Você não consegue ver claramente. A única coisa que consegue ver é aquele coração que bate incessantemente, e atrás dele, uma enorme boca de sangue que se abre gradualmente. \n Caçar, ou ser caçado, é a lei da natureza. \n Seja em terra, seja no oceano."
  },
  Event_118444_Name = {
    Text = "A lei do mais forte"
  },
  Event_118445_ChoiceDesc1 = {
    Text = "[Acenar para Afastar] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_118445_ChoiceDesc2 = {
    Text = "[Let It Stay] Ganhe Relíquia de Prata \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_118445_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_118445_Desc = {
    Text = "Um leve som veio da escuridão. \n Era uma borboleta que perguntava educadamente. \n \"Posso pousar na sua palma?\" \n \"Estou apenas muito cansada, quero descansar um pouco...\" \n Assim perguntando, a borboleta atravessou a escuridão, girando diante de você. \n Um líquido negro gotejava de suas asas — era o presente da escuridão que a borboleta trazia ao atravessar a escuridão."
  },
  Event_118445_Name = {
    Text = "Pedido da borboleta"
  },
  Event_118446_ChoiceDesc1 = {
    Text = "[Sair] ganha relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_118446_Desc = {
    Text = "Após um momento de silêncio, algo foi jogado em seus braços.\n\"Pegue e vá embora.\"\n\"O Destino é sempre generoso com os afortunados.\""
  },
  Event_118446_Name = {
    Text = "Aposta do destino"
  },
  Event_118447_ChoiceDesc1 = {
    Text = "[Seguir a Orientação] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_118447_ChoiceDesc2 = {
    Text = "[Ignorar a Orientação] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_118447_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_118447_Desc = {
    Text = "O festival começou.\nSob as chamas do Espírito e as bênçãos do sangue, inúmeras Almas de crentes tornaram-se faróis—\nOs espíritos etéreos se dispersam ao seu redor como fadas guia, brilhando e esperando sua escolha."
  },
  Event_118447_Name = {
    Text = "Faro de alma"
  },
  Event_118448_ChoiceDesc1 = {
    Text = "[Sair] infecção de[(Skill.Arg1)], ganha 50 o sigilo negro"
  },
  Event_118448_Desc = {
    Text = "\"Humanos ignorantes!\"\nAquela voz emitiu uma queixa frustrada, mas não a ponto de raiva.\nPois ela sabe que os ignorantes sempre terão momentos de iluminação.\nEla só precisa esperar esse dia chegar.\nE antes que esse dia chegue, ela marcará você com o selo de Deus, confirmando a posse da sua Alma."
  },
  Event_118448_Name = {
    Text = "Pregação do intangível"
  },
  Event_118449_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118449_Desc = {
    Text = "[@2 de @3......]\nUma enxurrada de conhecimento, acompanhada daquela melodia blasfema, invade seu cérebro.\nMas sua forma mortal o limita, tornando a sabedoria cósmica além do seu alcance.\nQue pesar tão triste."
  },
  Event_118449_Name = {
    Text = "Melodia profana"
  },
  Event_118450_ChoiceDesc1 = {
    Text = "[Sair] infecção de[(Skill.Arg1)], ganha 50 o sigilo negro"
  },
  Event_118450_Desc = {
    Text = "\"Na verdade, eu também tenho uma verdade sobre o mundo que quero te contar...\"\n\"O mundo foi criado por um deus de macarrão voador composto por dois olhos sábios de almôndega e macarrão simbolizando habilidade infinita...\"\nVocê seriamente inventa uma história engraçada que ouviu, esperando a reação do outro lado.\nMas depois de muito tempo, o outro lado permanece em silêncio.\n\"Ah, parece que crentes fervorosos não entendem humor.\"\nSuspirando, você só pode ir embora."
  },
  Event_118450_Name = {
    Text = "Pregação do intangível"
  },
  Event_118451_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118451_Desc = {
    Text = "Com a afinação correta, os intervalos dissonantes suavizaram um pouco.\nMas talvez, você ainda possa fazer algo"
  },
  Event_118451_Name = {
    Text = "\"Hino perfeito\""
  },
  Event_118452_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118452_Desc = {
    Text = "Três figuras tremiam, chorando em silêncio.\nA fé delas foi duvidada por você, e essa foi a maior ofensa que um fanático não poderia tolerar."
  },
  Event_118452_Name = {
    Text = "O melhor sacrifício"
  },
  Event_118453_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118453_Desc = {
    Text = "Você ignorou friamente os sinos desesperados.\nMesmo que na próxima fração de segundo você seja explodido de volta ao mundo primitivo, mesmo que você e sua grande missão pereçam juntos.\nUm telefonema que não deve ser atendido, não deve ser atendido.\nVocê conhece bem essa verdade simples"
  },
  Event_118453_Name = {
    Text = "Fenda Espacial"
  },
  Event_118454_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118454_Desc = {
    Text = "Os sussurros barulhentos cessaram, sombras escuras se voltaram para você, encarando-o. Você percebe um toque de sarcasmo em seus rostos sem feições"
  },
  Event_118454_Name = {
    Text = "Esperando sob as Estrelas"
  },
  Event_118455_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118455_Desc = {
    Text = "A existência desconhecida não o impediu.\n\"Um dia, você voltará novamente.\"\n\"Ninguém pode recusar o destino.\""
  },
  Event_118455_Name = {
    Text = "Aposta do destino"
  },
  Event_118456_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118456_Desc = {
    Text = "Com um movimento rápido e decisivo, aquelas mãos caíram fracas.\nMas você não perdeu o último suspiro da outra pessoa.\nEle finalmente se libertou de seus desejos sem fim."
  },
  Event_118456_Name = {
    Text = "Vínculo de desejos"
  },
  Event_118457_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118457_Desc = {
    Text = "Corvos arrancavam suas próprias penas, como humanos devorando seus corpos.\nNeste mundo de medo, isso é comum, você não pode salvar todos"
  },
  Event_118457_Name = {
    Text = "Lamento não percebido"
  },
  Event_118458_ChoiceDesc1 = {
    Text = "[Aperte o Corvo]ganhe 35 o sigilo negro, contamine「(Skill.Arg2)」，continue a escolher"
  },
  Event_118458_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Saia"
  },
  Event_118458_Desc = {
    Text = "O corvo negro está chorando.\nO corvo negro está gritando.\nO corvo negro está uivando.\nNo entanto, para os humanos, isso soa apenas como canto.\n\"Ah, que canção despreocupada. Eu gostaria de ser um corvo, longe das preocupações do mundo.\""
  },
  Event_118458_Name = {
    Text = "Lamento não percebido"
  },
  Event_118459_ChoiceDesc1 = {
    Text = "[Listen Closely] Ganhe uma relíquia prata \"(RelicConfig.Arg1)\" e inflija \"(Skill.Arg2)\""
  },
  Event_118459_ChoiceDesc2 = {
    Text = "[Plug Ears] Obtenha uma Oração com 3 escolhas"
  },
  Event_118459_Desc = {
    Text = "Na frenesi sem forma, você parece ver um piano.\nUm par de mãos que deformam a forma dançam nas teclas sem forma, tocando melodias profanas.\nA música bizarra ecoou das profundezas de sua Alma, viajando através das veias, alcançando seu cérebro tremulante."
  },
  Event_118459_Name = {
    Text = "Melodia profana"
  },
  Event_118460_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118460_Desc = {
    Text = "Aquelas inspirações, pensamentos e fantasias entrelaçam-se, fundindo-se nas cores mais esplêndidas do mundo.\nVocê vê o espaço se dobras dentro do seu próprio corpo, o tempo girando à sua vontade.\nNeste momento, você percebe o tempo e o espaço, onipotente e onisciente.\nClaro, você também pagou um preço."
  },
  Event_118460_Name = {
    Text = "Caleidoscópio de pensamento"
  },
  Event_118461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118461_Desc = {
    Text = "A caótica Alma guia seu caminho com gritos agudos.\nEsse é um caminho seguro? Você não sabe.\nSua única escolha é continuar avançando."
  },
  Event_118461_Name = {
    Text = "Faro de alma"
  },
  Event_118462_ChoiceDesc1 = {
    Text = "[Aperte o Corvo]ganhe 40 o sigilo negro, contamine「(Skill.Arg2)」，continue a escolher"
  },
  Event_118462_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Ganhe 25 Sigilos Negros e saia."
  },
  Event_118462_Desc = {
    Text = "O corvo negro está chorando.\nO corvo negro está gritando.\nO corvo negro está uivando.\nNo entanto, para os humanos, isso soa apenas como canto.\n\"Ah, que canção despreocupada. Eu gostaria de ser um corvo, longe das preocupações do mundo.\""
  },
  Event_118462_Name = {
    Text = "Lamento não percebido"
  },
  Event_118463_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118463_Desc = {
    Text = "A caótica Alma solta um suspiro triste.\nEla gradualmente se esvai, mas aquele suspiro doloroso, se tivesse substância, cai sobre seu coração.\nThump thump, seu coração ressoa em sincronia com a melodia do ritual."
  },
  Event_118463_Name = {
    Text = "Faro de alma"
  },
  Event_118464_ChoiceDesc1 = {
    Text = "[Sair] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_118464_Desc = {
    Text = "\"Ah, ah, que cordeiro devoto este é!\"\nAquela voz suspira, repleta de louvor jubiloso.\n\"Quando meu senhor despertar, cordeiros como você certamente encontrarão um lugar para residir naquele Exaltado e grandioso Reino Divino...\""
  },
  Event_118464_Name = {
    Text = "Pregação do intangível"
  },
  Event_118465_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118465_Desc = {
    Text = "\"O Céu\" abraça sua rebeldia.\nUm dia, a criança perdida retornará ao abraço da mãe.\nPorque você não tem para onde fugir."
  },
  Event_118465_Name = {
    Text = "Abraço do mar"
  },
  Event_118466_ChoiceDesc1 = {
    Text = "[Aceitar o Abraço]Obtenha a Criação de prata「(RelicConfig.Arg1)」, infecte「(Skill.Arg2)」"
  },
  Event_118466_ChoiceDesc2 = {
    Text = "[Rejeitar o Abraço]Obtenha a Criação de prata「(RelicConfig.Arg1)」, infecte「(Skill.Arg2)」"
  },
  Event_118466_ChoiceDesc3 = {
    Text = "[Nadar para a Superfície] Obtenha 25 Marca Negra"
  },
  Event_118466_Desc = {
    Text = "O mundo está jorrando de seus olhos.\n Neste momento, o fundo do mar ao seu redor é o \"céu\".\n Na dor de quase se afogar, este \"céu\" azul profundo se aproxima gentilmente, pretendendo abraçar você.\n Ele não julgará, apenas dará"
  },
  Event_118466_Name = {
    Text = "Abraço do mar"
  },
  Event_118467_ChoiceDesc1 = {
    Text = "[Repreendê-los]Ganhe Criatura amaldiçoada「(RelicConfig.Arg1)」，infecta「(Skill.Arg2)」"
  },
  Event_118467_ChoiceDesc2 = {
    Text = "[Responder a Eles] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_118467_ChoiceDesc3 = {
    Text = "[Ignorar] Ganhe 50 Marca Negra"
  },
  Event_118467_Desc = {
    Text = "Três almas vagamente moldadas bloquearam seu caminho.\nUma figura se curvou solenemente para você, implorando que você concedesse sangue. Seu sangue fluente é o melhor sacrifício para os deuses.\nUma figura levantou friamente uma faca para você, pretendendo esculpir sua carne. Aquela carne humana não mutada certamente conquistaria o favor dos deuses.\nA última observou você em silêncio, esperando que você tirasse sua própria vida para provar a fé mais devota."
  },
  Event_118467_Name = {
    Text = "O melhor sacrifício"
  },
  Event_118468_ChoiceDesc1 = {
    Text = "[Aperte o Corvo]ganhe 30 o sigilo negro, contamine「(Skill.Arg2)」，continue a escolher"
  },
  Event_118468_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Saia"
  },
  Event_118468_Desc = {
    Text = "O corvo negro está chorando.\nO corvo negro está gritando.\nO corvo negro está uivando.\nNo entanto, para os humanos, isso soa apenas como canto.\n\"Ah, que canção despreocupada. Eu gostaria de ser um corvo, longe das preocupações do mundo.\""
  },
  Event_118468_Name = {
    Text = "Lamento não percebido"
  },
  Event_118469_ChoiceDesc1 = {
    Text = "[Sair] Infectar[(Skill.Arg1)]"
  },
  Event_118469_ChoiceDesc2 = {
    Text = "[Sair] Infectar[(Skill.Arg1)]"
  },
  Event_118469_ChoiceDesc3 = {
    Text = "[Sair] Infectar[(Skill.Arg1)]"
  },
  Event_118469_Desc = {
    Text = "\"Não! Nós recusamos isso! Desejamos algo mais... deleitável.\"\n\"Então será... seu sangue e carne!\"\nUm enxame de ratos guincha, avançando em sua direção.\nParece que um coração bondoso em excesso às vezes pode trazer mais problemas do que alívio."
  },
  Event_118469_Name = {
    Text = "Bando de ratos famintos"
  },
  Event_118470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118470_Desc = {
    Text = "Seu respeito conquista o favor desses olhos.  \nAntes que eles desapareçam, eles lhe presenteiam com um presente através do mar turbulento.  \nEssa é a evidência de que o Fundo do Mar está domando você."
  },
  Event_118470_Name = {
    Text = "Olho do Mar Profundo"
  },
  Event_118471_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118471_Desc = {
    Text = "Sob seu olhar destemido, o fundo do mar lentamente desperta.\nO mar se agita caoticamente ao seu redor, trazendo murmúrios indescritíveis.\nSinta a ira do fundo do mar, isso é tanto uma benção quanto uma maldição."
  },
  Event_118471_Name = {
    Text = "Olho do Mar Profundo"
  },
  Event_118472_ChoiceDesc1 = {
    Text = "[Aperte o Corvo]ganhe 20 o sigilo negro, contamine「(Skill.Arg2)」"
  },
  Event_118472_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Saia"
  },
  Event_118472_Desc = {
    Text = "O corvo negro está chorando.\nO corvo negro está gritando.\nO corvo negro está uivando.\nNo entanto, para os humanos, isso soa apenas como canto.\n\"Ah, que canção despreocupada. Eu gostaria de ser um corvo, longe das preocupações do mundo.\""
  },
  Event_118472_Name = {
    Text = "Lamento não percebido"
  },
  Event_118473_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118473_Desc = {
    Text = "Sangue, carne, vida.\nO sacrifício está pronto, agora tudo o que você precisa fazer é esperar silenciosamente pelo banquete divino."
  },
  Event_118473_Name = {
    Text = "O melhor sacrifício"
  },
  Event_118474_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118474_Desc = {
    Text = "Gotas de lama negra caem no seu rosto, causando uma coceira.\nVocê não aguenta e afasta a borboleta.\nA borboleta escapa e desaparece silenciosamente"
  },
  Event_118474_Name = {
    Text = "Pedido da borboleta"
  },
  Event_118475_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118475_Desc = {
    Text = "Mas são seres lutando para sobreviver, buscando um pedaço de madeira flutuante para descansar...\nVocê suspira, deixando o líquido negro da cauda da borboleta escorrer pelo rosto"
  },
  Event_118475_Name = {
    Text = "Pedido da borboleta"
  },
  Event_118477_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118477_Desc = {
    Text = "O corvo, com a voz rouca, finalmente fechou os olhos. \n Em um rancor que ninguém conhecia e que não era percebido, ele soltou seu último suspiro, transformando-se em uma poça de lama negra."
  },
  Event_118477_Name = {
    Text = "Lamento não percebido"
  },
  Event_118478_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118478_Desc = {
    Text = "\"Obrigado...\"\nO coração pulsante salta em direção ao horizonte.\nLogo, o som de carne sendo mastigada ecoou do Mar Profundo escuro como breu."
  },
  Event_118478_Name = {
    Text = "A lei do mais forte"
  },
  Event_118479_ChoiceDesc1 = {
    Text = "[Aceitar o Convite] Desenvolver \"(Skill.Arg1)\", obter Criatura amaldiçoada \"(RelicConfig.Arg2)\""
  },
  Event_118479_ChoiceDesc2 = {
    Text = "[Recusar o Convite] Escolha destruir uma Criação, obtenha uma recompensa"
  },
  Event_118479_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_118479_Desc = {
    Text = "\"Todo neste barco deve se tornar parte deste ciclo de paraíso, que está constantemente se desfazendo e reiniciando.\"\nUm som frenético ressoa em sua mente, uma inspiração da vontade invisível. \n\"Aqui não há choro, não há tristeza, apenas a música sagrada e a risada eterna.\"\n\"Você deseja se juntar ao paraíso e se tornar parte dessa perfeita melodia?\""
  },
  Event_118479_Name = {
    Text = "\"Hino perfeito\""
  },
  Event_118480_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118480_Desc = {
    Text = "No seu silêncio, as almas se dissipam silenciosamente.\nAqueles que não entendem os crentes não valem seu tempo."
  },
  Event_118480_Name = {
    Text = "O melhor sacrifício"
  },
  Event_123616_ChoiceDesc1 = {
    Text = "[Receive Relíquia Padrão]"
  },
  Event_123616_Desc = {
    Text = "Defina todos os Aliemus dos Despertadores para 100, Keyflare para 1000 e HP para 80%.\nRemova 2 cartas e adicione 3 Cartas de Sintoma.\nDefina a Forja Carmesim para 12,5%, escolha 4 cartas para entrar no Espaço Ultra.\nObtenha Pacote de Relíquias Padrão."
  },
  Event_123616_Name = {
    Text = "Pular com um clique pelo caminho"
  },
  Event_125696_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125696_Desc = {
    Text = "Uma raiva sem motivo te impulsiona. Você levanta a mão, golpeando para dispersá-los. Você ficou preso em enigmas por tempo demais; talvez anseie por uma batalha implacável, ou simplesmente por um fim...\nMas os corvos não fazem nada. Sob seu olhar, o abismo se dissolve.\nO enxame desaparece em direção ao fim do palco — o lugar para onde você deve ir."
  },
  Event_125696_Name = {
    Text = "Abismo dos Corvos"
  },
  Event_125697_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125697_Desc = {
    Text = "\"Covarde.\" Ela não faz esforço para esconder a zombaria em sua risada.\n\"Vá, então. Quanto mais longe, melhor.\""
  },
  Event_125697_Name = {
    Text = "Trava do destino"
  },
  Event_125698_ChoiceDesc1 = {
    Text = "[Afastar] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_125698_ChoiceDesc2 = {
    Text = "[Listen] Adquirir a Criação de prata \"(RelicConfig.Arg1)\", mas desenvolver \"(Skill.Arg2)\""
  },
  Event_125698_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_125698_Desc = {
    Text = "Um leve som veio da escuridão. Uma borboleta pousou na palma da sua mão. Você se lembra dela. \n\"Senhora Arachne... a senhora nunca nos abandonou, certo?\" \nOs belos padrões da borboleta olham para as pessoas ao seu redor."
  },
  Event_125698_Name = {
    Text = "O Crepúsculo da Borboleta"
  },
  Event_125699_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125699_Desc = {
    Text = "Os sons e scripts penetram em sua mente como um enxame agitado. Você prende a respiração, purgando o ruído inútil de sua consciência.\nIgnorar é muito mais árduo do que ler — ainda assim, você conseguiu."
  },
  Event_125699_Name = {
    Text = "Telegrama Dimensional"
  },
  Event_125700_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125700_Desc = {
    Text = "É uma ilusão conjurada pelo inimigo!\nVocê balança a cabeça, a clareza retorna, e aperta com firmeza a Chave de prata."
  },
  Event_125700_Name = {
    Text = "Reflexo no Espelho"
  },
  Event_125701_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125701_Desc = {
    Text = "Você fixa o olhar naquele olho, esforçando-se para observar, para ouvir. Você tenta entrar no coração do ator e sentir a agonia que ele suporta.\nVocê se aproxima, cada vez mais. Você atravessa sua forma e toca sua própria alma...\nVocê abre os olhos de repente e se encontra no centro do palco, com lágrimas escorrendo pelas pontas dos dedos.\nEssa é a confissão que você oferece ao público."
  },
  Event_125701_Name = {
    Text = "Confissão de um Ator"
  },
  Event_125702_ChoiceDesc1 = {
    Text = "[Discutir com Ela] Destruir uma Carta de comando, e receber Arg1 Marcas Negras"
  },
  Event_125702_ChoiceDesc2 = {
    Text = "[Permanecer em silêncio]"
  },
  Event_125702_Desc = {
    Text = "\"Um final feliz está bem, mas essa alegria vazia nunca pode tocar os corações do público...\"\nA dramaturga fecha os olhos em contemplação. Ela está insatisfeita com essa conclusão."
  },
  Event_125702_Name = {
    Text = "O Fim da Peça"
  },
  Event_125703_ChoiceDesc1 = {
    Text = "[Aperte o Corvo]ganhe 35 o sigilo negro, contamine「(Skill.Arg2)」，continue a escolher"
  },
  Event_125703_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Saia"
  },
  Event_125703_Desc = {
    Text = "\"Crujido — crujido — a Deusa do Destino gira sua roda de fiar.\nCrujido — crujido — os Fios do destino convergem em suas mãos.\""
  },
  Event_125703_Name = {
    Text = "A Profecia Final"
  },
  Event_125704_ChoiceDesc1 = {
    Text = "[Yourself] Duplicar 1 de 3 Cartas de comando aleatórias do deck"
  },
  Event_125704_ChoiceDesc2 = {
    Text = "[William] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_125704_ChoiceDesc3 = {
    Text = "[Ninguém] Obter 25 Marcas Negras"
  },
  Event_125704_Desc = {
    Text = "Você tem certeza de que não está bêbado, mas ao contemplar o álcool, se vê afundando em um lago tranquilo.\nUma figura elegante aparece no copo. Quem é?"
  },
  Event_125704_Name = {
    Text = "Reflexo no Espelho"
  },
  Event_125705_ChoiceDesc1 = {
    Text = "[Listen] Ganha Criação de prata[(RelicConfig.Arg1)]"
  },
  Event_125705_ChoiceDesc2 = {
    Text = "[Dispel] Ganha 75 Marca Negra, infecção de[(Skill.Arg2)]"
  },
  Event_125705_Desc = {
    Text = "Ao se aproximar do poder do plásmido interior, um bando de corvos surge em sua mente, circulando por seu turbulento reino espiritual.\n\nOs corvos giram ao seu redor, como um vórtice do abismo suspenso invertido acima.\nCem mil corvos gritam em uníssono, como uma profecia zombeteira."
  },
  Event_125705_Name = {
    Text = "Abismo dos Corvos"
  },
  Event_125706_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125706_Desc = {
    Text = "Você e Arachne tentam estabilizar o destino que se desfaz ao redor. Os esforços de vocês surtem pouco efeito, mas é suficiente. Aproveitando o tempo conquistado, vocês continuam a se aproximar de Nefraea. \nVocê veio aqui para trazer libertação a ela."
  },
  Event_125706_Name = {
    Text = "Rede do destino – Fim"
  },
  Event_125707_ChoiceDesc1 = {
    Text = "[Aperte o Corvo]ganhe 20 o sigilo negro, contamine「(Skill.Arg2)」"
  },
  Event_125707_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Saia"
  },
  Event_125707_Desc = {
    Text = "\"Elas morrem com a grande rede, silenciosamente.\""
  },
  Event_125707_Name = {
    Text = "A Profecia Final"
  },
  Event_125708_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125708_Desc = {
    Text = "É um telegrama endereçado ao Abismo Espiral.\n\"Não se preocupem, meus filhos. Os portões da prisão logo se abrirão de par em par; a libertação de vocês está próxima.\""
  },
  Event_125708_Name = {
    Text = "Telegrama Dimensional"
  },
  Event_125709_ChoiceDesc1 = {
    Text = "[Afastar] 1 Carta de comando aleatória obtém Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_125709_ChoiceDesc2 = {
    Text = "[Listen] Grave a Oração[(EnchantConfig.Arg1)] em 1 de 3 Cartas de comando"
  },
  Event_125709_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_125709_Desc = {
    Text = "Uma borboleta pousa suavemente em sua palma. Seus padrões requintados lembram olhos que não piscam, olhando para você em silêncio.\nTalvez ela queira lhe dizer algo?"
  },
  Event_125709_Name = {
    Text = "O Repouso da Borboleta"
  },
  Event_125710_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125710_Desc = {
    Text = "Vinte pares de olhos enlutados se fixam em você. O corvo cessa seu canto, partindo desta teia em ruínas com sua profecia final."
  },
  Event_125710_Name = {
    Text = "A Profecia Final"
  },
  Event_125711_ChoiceDesc1 = {
    Text = "[Lean Out] Infecção \"(Skill.Arg1)\", Ganhe Relíquia de Ouro \"(RelicConfig.Arg2)\""
  },
  Event_125711_ChoiceDesc2 = {
    Text = "[Desista de Conferir] Ganhe 50 Sigilos Negros"
  },
  Event_125711_Desc = {
    Text = "Ao passar pela esquina da rua, você avista uma modesta sala de exibição. Você não se lembra de tal lugar existir em Londinium."
  },
  Event_125711_Name = {
    Text = "Sala de Memórias"
  },
  Event_125712_ChoiceDesc1 = {
    Text = "[Aceitar o Destino]Gravar a Oração「(EnchantConfig.Arg1)」em 1 de 3 Cartas de comando. (Usos: 0/2)"
  },
  Event_125712_ChoiceDesc2 = {
    Text = "[Desafiar o Destino]Infectar 「(Skill.Arg1)」，re-imprintar, no máximo 2 vezes"
  },
  Event_125712_Desc = {
    Text = "\"Ah, nos encontramos novamente, minha querida.\"\nVocê começa a apreciar a voz daquela senhora ecoando em sua mente. É terna e sedutora, como uma teia para apanhar moscas.\n\"Venha, diga-me — você está disposta a abraçar seu destino?\""
  },
  Event_125712_Name = {
    Text = "A Gaiola do Destino"
  },
  Event_125713_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125713_Desc = {
    Text = "\"Humano tolo, nós nos conhecemos?\"\nO gato preto revira os olhos com desdém e se vira.\n\"Vá embora. E não faça mais nada tão estúpido assim.\""
  },
  Event_125713_Name = {
    Text = "Formas Mutáveis"
  },
  Event_125714_ChoiceDesc1 = {
    Text = "[Tirar Foto] Grave a Oração [(EnchantConfig.Arg1)] em 1 de 3 Cartas de comando.(Usos: 0/2)"
  },
  Event_125714_ChoiceDesc2 = {
    Text = "[Mudar Pose] Desenvolva o Sintoma [(Skill.Arg1)] e mude a Oração a gravar.(Usos: 2/2)"
  },
  Event_125714_Desc = {
    Text = "Uma câmera solitária está sobre o palco, sua lente negra como breu fixada em você como o olho composto e enigmático criado por uma divindade mecânica.\nEste teatro ficou vazio por tanto tempo... Bem-vindo! Bem-vindo! Venha, tire uma foto! É totalmente gratuito!\nA câmera grita de entusiasmo. Neste palco abandonado, ela é a única protagonista."
  },
  Event_125714_Name = {
    Text = "Registro na plateia"
  },
  Event_125715_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125715_Desc = {
    Text = "\"Como alguém que nada pede ao destino pode esperar uma resposta do destino?\""
  },
  Event_125715_Name = {
    Text = "Trava do destino"
  },
  Event_125716_ChoiceDesc1 = {
    Text = "[Pensar em uma Saída] Adquirir a Criação de prata \"(RelicConfig.Arg1)\", mas desenvolver \"(Skill.Arg2)\""
  },
  Event_125716_ChoiceDesc2 = {
    Text = "[Deixar Estar] Adquirir a Criação de ouro \"(RelicConfig.Arg1)\", mas desenvolver \"(Skill.Arg2)\" e \"(Skill.Arg3)\""
  },
  Event_125716_ChoiceDesc3 = {
    Text = "[Surface] Ganhar 25 Sigilos Negros"
  },
  Event_125716_Desc = {
    Text = "Uma nova fase. Duas vidas entrelaçadas... Enquanto foge dos oficiais, você organiza as verdades que Arachne compartilhou com você.\nEm meio aos pensamentos emaranhados, você mergulha em um mar profundo e tranquilo."
  },
  Event_125716_Name = {
    Text = "Tranquilidade"
  },
  Event_125717_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125717_Desc = {
    Text = "A borboleta pousa em seu ombro, aproximando-se de seu ouvido. Você ouve com atenção, mas escuta apenas o leve frêmito das asas — um som como um suspiro sem voz.\nEnquanto você ouve, as asas iridescentes começam a se dissolver, e a borboleta cai em um sono eterno sobre seu ombro.\nA mensagem que ela carregava está perdida para você para sempre."
  },
  Event_125717_Name = {
    Text = "O Crepúsculo da Borboleta"
  },
  Event_125718_ChoiceDesc1 = {
    Text = "[Morder] Despertar 1 Corpo Desperto aleatório, infectar[(Skill.Arg1)]"
  },
  Event_125718_ChoiceDesc2 = {
    Text = "[Refuse] Ganhe 1 entre 3 Oração"
  },
  Event_125718_Desc = {
    Text = "\"Com fome, meu caro convidado?\"\nUma voz viscosa surge de trás do bar. Você se vira, mas não vê nada.\n\"Os petiscos do Baile de Meia-Noite também são bastante renomados. Quer experimentar?\""
  },
  Event_125718_Name = {
    Text = "O Sabor do Destino"
  },
  Event_125719_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125719_Desc = {
    Text = "Você não ousa ler as palavras escritas nele, apenas examina cuidadosamente o envelope delicado. \nO lacre do envelope traz uma Gravura de um brasão indistinto, e sobre ele, em uma bela letra cursiva: \n\"À recém-nascida Senhora Arachne.\" \n\"Seu leal mordomo, Edgar.\""
  },
  Event_125719_Name = {
    Text = "Boa noite, Senhor Edgar"
  },
  Event_125720_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125720_Desc = {
    Text = "\"Entendo. Compreendo agora, irmã...\"\n\"Uma dramaturga nunca pode reescrever o fim de um personagem. Aquele destino miserável foi selado há muito tempo; nem mesmo você poderia mudá-lo...\"\nO soluço triste desvanece. A máquina de escrever da dramaturga se dissolve em borboletas, espalhando-se pelo Teatro do Destino vazio até não restar nenhum traço."
  },
  Event_125720_Name = {
    Text = "O Fim da Peça"
  },
  Event_125721_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125721_Desc = {
    Text = "Atores desconhecidos, passos perigosos... o que importa? Nada pode ser pior do que o próprio destino.\nVocê estende a mão e sobe ao palco. Os bonecos tomam sua mão, girando-o em uma dança alegre.\nVocê ouve os aplausos."
  },
  Event_125721_Name = {
    Text = "Dança de Três"
  },
  Event_125722_ChoiceDesc1 = {
    Text = "[Aperte o Corvo]ganhe 25 o sigilo negro, contamine「(Skill.Arg2)」，continue a escolher"
  },
  Event_125722_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Saia"
  },
  Event_125722_Desc = {
    Text = "\"Elas dançam. Elas cantam. Crujido—crujido—\""
  },
  Event_125722_Name = {
    Text = "A Profecia Final"
  },
  Event_125723_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125723_Desc = {
    Text = "O guia, o camarada — o único companheiro nesta dimensão solitária.\nVocê resolverá tudo aqui juntos e retornará a Cardas. Você nunca duvidou disso."
  },
  Event_125723_Name = {
    Text = "Reflexo no Espelho"
  },
  Event_125724_ChoiceDesc1 = {
    Text = "[Apostar] Infectar [(Skill.Arg1)], entrar no jogo"
  },
  Event_125724_ChoiceDesc2 = {
    Text = "[Esqueça] Ganhe 25 sigilos negros"
  },
  Event_125724_Desc = {
    Text = "Na esquina de um beco, um par de mãos sujas barra seu caminho.\nUm mendigo em farrapos se aproxima, seus olhos tão glutões quanto os de uma hiena farejando carniça.\n\"Venha! Uma rodada! Eu lhe direi tudo o que deseja saber... se apenas você vencer...\""
  },
  Event_125724_Name = {
    Text = "Aposta de Rua"
  },
  Event_125725_ChoiceDesc1 = {
    Text = "[Ignore] Destruir uma Carta de comando e receber 25 Marcas Negras"
  },
  Event_125725_ChoiceDesc2 = {
    Text = "[Read] Copie uma Carta do baralho, infecte[(Skill.Arg1)]"
  },
  Event_125725_Desc = {
    Text = "Tique, tique, tique... Tique, tique, tique...\nO canto do bar está deserto; o fax toca com uma cadência nítida e rítmica, como uma graciosa sonata para piano."
  },
  Event_125725_Name = {
    Text = "Telegrama Dimensional"
  },
  Event_125726_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125726_Desc = {
    Text = "\"Silêncio. Sou um gato. Não tenho interesse em suas histórias tediosas.\"\n\nO gato suspira e se vira.\n\n\"Vá embora. E não faça mais nada tão estúpido assim.\""
  },
  Event_125726_Name = {
    Text = "Formas Mutáveis"
  },
  Event_125727_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125727_Desc = {
    Text = "Talvez ela esteja certa. Esse é você — os pensamentos mais obscuros e sórdidos no fundo de sua alma.\nTodo homem é egoísta; você nunca foi tão nobre quanto os outros acreditavam.\nVocê saboreia aquela dor miserável. Você sabe que o passado se foi, e sua salvação está à frente."
  },
  Event_125727_Name = {
    Text = "Agonia Propagante"
  },
  Event_125728_ChoiceDesc1 = {
    Text = "[Discutir com Ela] Destruir uma Carta de comando, e receber Arg1 Marcas Negras"
  },
  Event_125728_ChoiceDesc2 = {
    Text = "[Permanecer em silêncio]"
  },
  Event_125728_Desc = {
    Text = "\"Um final trágico é verdadeiro, mas nossa realidade já é tão miserável. Não podemos conceder a ela um destino mais gentil mesmo dentro de uma história...?\"\nA dramaturga fecha os olhos em contemplação. Ela está insatisfeita com essa conclusão."
  },
  Event_125728_Name = {
    Text = "O Fim da Peça"
  },
  Event_125729_ChoiceDesc1 = {
    Text = "[Sair] ganha relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_125729_Desc = {
    Text = "Chacoalha-chacoalha. Os dados dançam freneticamente no copo, girando até a exaustão.\n\n\"Por que... por que ninguém jamais vence?!\""
  },
  Event_125729_Name = {
    Text = "Aposta de Rua"
  },
  Event_125730_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125730_Desc = {
    Text = "Você se inclina mais perto, esforçando-se para ouvir seu sussurro.\nA borboleta bate as asas e parte de sua palma.\nVocê não ouve absolutamente nada."
  },
  Event_125730_Name = {
    Text = "O Repouso da Borboleta"
  },
  Event_125731_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125731_Desc = {
    Text = "A borboleta não se move com seus gestos.\nEla persegue sua palma com uma quieta persistência — e somente quando você ergue o braço pela última vez ela escolhe partir.\nUm lampejo de arrependimento surge. Talvez... você devesse ter ouvido?"
  },
  Event_125731_Name = {
    Text = "O Repouso da Borboleta"
  },
  Event_125732_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125732_Desc = {
    Text = "A névoa negra treme desolada; os lamentos agonizantes do mendigo são dilacerantes.\nNum único piscar de olhos, os dados e o mendigo desaparecem. Dentro da cartola em farrapos, a recompensa do jogo permanece."
  },
  Event_125732_Name = {
    Text = "Aposta de Rua"
  },
  Event_125733_ChoiceDesc1 = {
    Text = "[Juntar-se à Celebração]Obter a Criatura amaldiçoada「(RelicConfig.Arg2)」, mas desenvolver「(Skill.Arg1)」"
  },
  Event_125733_ChoiceDesc2 = {
    Text = "[Parar a Música] Escolha destruir uma Criação, obtenha uma recompensa"
  },
  Event_125733_ChoiceDesc3 = {
    Text = "[Cobrir os Ouvidos] Receber 50 Marcas Negras"
  },
  Event_125733_Desc = {
    Text = "\"Ah! Música! Como pode existir uma grande apresentação sem música!!\"\nUma sinfonia dissonante surge dentro do teatro despedaçado, como uma orgia do caos. Atores do Abismo Espiral dançam e comemoram nessa ode desordenada, deleitando-se nas notas que os sustentam."
  },
  Event_125733_Name = {
    Text = "Cântico do Destino"
  },
  Event_125734_ChoiceDesc1 = {
    Text = "[Ganhe 100 sigilos negros]"
  },
  Event_125734_ChoiceDesc2 = {
    Text = "[2 Cartas de comando aleatórias obtêm Gravura: \"(EnchantConfig.Arg1)\"]"
  },
  Event_125734_Desc = {
    Text = "Fios invisíveis do destino dançam em meio às notas. Naquele ruído caótico, você começa a rastrear o fio da melodia cativante — de fato, esse é o verdadeiro som do destino.\nOs renegados do Abismo Espiral torcem por você, aglomerando-se ao seu redor, arrastando-o para sua orgia desordenada.\nParabéns, espectador afortunado! Agora, você se juntará aos atores na chamada final do destino."
  },
  Event_125734_Name = {
    Text = "Cântico do Destino"
  },
  Event_125735_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125735_Desc = {
    Text = "Você não consegue discernir o significado desse som, mas sabe que ele deve parar.\nA luz prateada corta como uma lâmina enlouquecida. Seu ritmo, de alguma forma, cai perfeitamente no compasso das notas.\nAntes que perceba, a música cessou. Você não ouve mais nada. Vê apenas a noite; ouve apenas o silêncio.\nCacofonia desordenada ou silêncio absoluto — qual é mais aterrorizante... Guardião?"
  },
  Event_125735_Name = {
    Text = "Cântico do Destino"
  },
  Event_125736_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125736_Desc = {
    Text = "Você estende a mão; uma borboleta pousa gentilmente sobre ela.\nDe fato. A morte, a dissolução, a passagem do tempo... A borboleta nasce do casulo; a agonia é o solo eterno da arte.\nComo um excelente espectador, esta é uma verdade que você deve compreender."
  },
  Event_125736_Name = {
    Text = "Florescer na dissipação"
  },
  Event_125737_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125737_Desc = {
    Text = "Isso talvez seja mais um truque de Nefraea. \nA borboleta entendeu suas palavras, e um suspiro silencioso ecoou na escuridão. As asas cobertas de lama negra escorregadia tremeram, e logo a silhueta pesada da borboleta se perdeu na escuridão sem fim. \nVocê jamais saberá o que ela queria lhe dizer."
  },
  Event_125737_Name = {
    Text = "O Crepúsculo da Borboleta"
  },
  Event_125738_ChoiceDesc1 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_125738_Desc = {
    Text = "Chacoalha-chacoalha. Os dados dançam freneticamente no copo, girando até a exaustão.\n\n\"Por que... por que ninguém jamais vence?!\""
  },
  Event_125738_Name = {
    Text = "Aposta de Rua"
  },
  Event_125739_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125739_Desc = {
    Text = "Deixar seus pensamentos vagarem sem controle agora é perigoso. Você balança a cabeça e emerge imediatamente."
  },
  Event_125739_Name = {
    Text = "Tranquilidade"
  },
  Event_125740_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125740_Desc = {
    Text = "Nem toda nota requer um ouvinte; nem todo destino requer uma resposta.\nVocê pressiona firmemente as mãos sobre os ouvidos e parte do palco barulhento.\nVocê ainda sente curiosidade sobre o significado daquela música dissonante, mas sabe que tomou a única decisão certa."
  },
  Event_125740_Name = {
    Text = "Cântico do Destino"
  },
  Event_125741_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125741_Desc = {
    Text = "A luz prateada atravessa a ilusão; os gatos pretos se dissolvem em poças de lodo negro.\nTransformar-se em forma felina para se esconder... o monstro não consegue escapar dos seus olhos."
  },
  Event_125741_Name = {
    Text = "Formas Mutáveis"
  },
  Event_125742_ChoiceDesc1 = {
    Text = "[Aceitar o Destino]Gravar a Oração「(EnchantConfig.Arg1)」em 1 de 3 Cartas de comando. (Usos: 0/2)"
  },
  Event_125742_Desc = {
    Text = "\"Ninguém pode verdadeiramente desafiar o destino, minha querida. Nunca possuímos o direito de escolher.\"\nA voz fica desanimada e distante. Você não tem certeza se ela fala com você, ou com algo completamente diferente."
  },
  Event_125742_Name = {
    Text = "A Gaiola do Destino"
  },
  Event_125743_ChoiceDesc1 = {
    Text = "[Aperte o Corvo]ganhe 30 o sigilo negro, contamine「(Skill.Arg2)」，continue a escolher"
  },
  Event_125743_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Saia"
  },
  Event_125743_Desc = {
    Text = "\"As marionetes fazem fila para sua entrada, adentrando a grande teia do destino.\""
  },
  Event_125743_Name = {
    Text = "A Profecia Final"
  },
  Event_125744_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125744_Desc = {
    Text = "Você ergue o olhar para o vórtice do abismo, esforçando-se para ouvir o oráculo dos corvos.\nMas eles não dizem nada. Sob seu olhar, o abismo se dissolve.\nO enxame desaparece em direção ao fim do palco — o lugar para onde você deve ir."
  },
  Event_125744_Name = {
    Text = "Abismo dos Corvos"
  },
  Event_125745_ChoiceDesc1 = {
    Text = "[Agree] Remova 2 Cartas"
  },
  Event_125745_ChoiceDesc2 = {
    Text = "[Disagree] Ganha a Criatura amaldiçoada \"(RelicConfig.Arg1)\", mas infecta \"(Skill.Arg2)\""
  },
  Event_125745_ChoiceDesc3 = {
    Text = "[Leave] Ganhar Arg1 sigilos negros"
  },
  Event_125745_Desc = {
    Text = "A cortina do palco tremula no vento. Em meio à lama negra vazando de um cadáver caído, você avista um grupo de borboletas.\n\"A verdadeira arte sempre floresce na dissolução... você não concorda, Guardião?\"\nO cadáver da dançarina sorri para você. Você ouve o bater de asas."
  },
  Event_125745_Name = {
    Text = "Florescer na dissipação"
  },
  Event_125746_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125746_Desc = {
    Text = "A sofistaria nunca poderá te desviar. Você sabe claramente o caminho que trilha e o destino que busca.\nOs espinhos se dissolvem dentro de você. Você segue em frente pelo caminho, como sempre fez."
  },
  Event_125746_Name = {
    Text = "Agonia Propagante"
  },
  Event_125747_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125747_Desc = {
    Text = "Você se vira, tentando esquecer os olhos atrás de você. Mas descobre que seu corpo não se move mais com a mesma liberdade de antes.\nVocê sabe — daqueles olhares fixos, jamais escapará."
  },
  Event_125747_Name = {Text = "Público"},
  Event_125748_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125748_Desc = {
    Text = "Seja por respeito ou por temor, você não deseja tocá-lo levianamente, e recoloca o envelope no lugar. Quando você se prepara para partir, uma Voz suave, porém turva, ecoa da escuridão atrás do envelope. \n\"Obrigado por ainda se lembrar de mim, Senhora Arachne...\""
  },
  Event_125748_Name = {
    Text = "Boa noite, Senhor Edgar"
  },
  Event_125749_ChoiceDesc1 = {
    Text = "[Poder para Proteger] Adquirir a Criação de prata [(RelicConfig.Arg1)]"
  },
  Event_125749_ChoiceDesc2 = {
    Text = "[Liberdade para Fugir] Gravar a Gravura [(EnchantConfig.Arg1)] em 1 Carta de comando aleatória"
  },
  Event_125749_ChoiceDesc3 = {
    Text = "[Recusar Responder] Receber 50 Marcas Negras"
  },
  Event_125749_Desc = {
    Text = "O licor da Máscara da Meia-Noite se infiltra em sua mente como correntes se enrolando firmemente. Ao longo dos elos frios de ferro, a voz de uma jovem mulher assombra sua consciência.\n\"Diga-me, querido. Que destino você realmente deseja?\""
  },
  Event_125749_Name = {
    Text = "Trava do destino"
  },
  Event_125750_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125750_Desc = {
    Text = "Mesmo os assuntos mais complicados devem ser resolvidos por suas mãos.\nO peso aumenta, mas com ele surge uma força nova e desconhecida."
  },
  Event_125750_Name = {
    Text = "Tranquilidade"
  },
  Event_125751_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125751_Desc = {
    Text = "Atores desconhecidos, passos perigosos. De fato, a fuga é o único porto seguro.\nVocê se vira e corre, rasgando as cortinas do teatro — apenas para se encontrar sobre o palco. Os bonecos tomam sua mão, girando-o em uma dança alegre.\nNo palco do destino, nunca há escolha."
  },
  Event_125751_Name = {
    Text = "Dança de Três"
  },
  Event_125752_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125752_Desc = {
    Text = "Agora não é hora para um filme."
  },
  Event_125752_Name = {
    Text = "Sala de Memórias"
  },
  Event_125753_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125753_Desc = {
    Text = "Os perigos do caminho não chegam nem a passar pela sua mente. Você atravessa o destino que se desfaz ao seu lado e continua a se aproximar de Nefraea. \nVocê veio aqui para trazer libertação a ela."
  },
  Event_125753_Name = {
    Text = "Rede do destino – Fim"
  },
  Event_125754_ChoiceDesc1 = {
    Text = "[Ler o Envelope] ganha Criação de ouro「(RelicConfig.Arg1)」, infecta「(Skill.Arg2)」"
  },
  Event_125754_ChoiceDesc2 = {
    Text = "[Ler a Carta] Gravar a Gravura [(EnchantConfig.Arg1)] em 1 de 3 Cartas de comando"
  },
  Event_125754_ChoiceDesc3 = {
    Text = "[Put it back] Ganhe 50 O sigilo negro"
  },
  Event_125754_Desc = {
    Text = [[
Seus movimentos rasgam as densas teias de aranha; uma carta antiga cai da seda.
Seu peso supera em muito o que um papel fino deveria carregar.]]
  },
  Event_125754_Name = {
    Text = "Boa noite, Senhor Edgar"
  },
  Event_125755_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125755_Desc = {
    Text = "Lágrimas caem dos olhos do corvo. Sangue escorre de seu bico. Com o último sopro de vida, o corvo canta sua profecia final para você."
  },
  Event_125755_Name = {
    Text = "A Profecia Final"
  },
  Event_125756_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125756_Desc = {
    Text = "\"Hehe... Hahahaha!\"\n\"Como foi, meu convidado? O sabor do destino... você vai se descobrir desejando-o, loucamente, sem fim...\""
  },
  Event_125756_Name = {
    Text = "O Sabor do Destino"
  },
  Event_125757_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125757_Desc = {
    Text = "\"Tedioso.\" Ela dá um bocejo preguiçoso.\n\"Pegue seu poder e vá brigar no clube.\""
  },
  Event_125757_Name = {
    Text = "Trava do destino"
  },
  Event_125758_ChoiceDesc1 = {
    Text = "[Estabilizar Rede do destino] Obter 1 de 3 Gravuras avançadas"
  },
  Event_125758_ChoiceDesc2 = {
    Text = "[Ignorar o Perigo]Obtenha a Criação de ouro \"(RelicConfig.Arg1)\", mas desenvolva \"(Skill.Arg2)\""
  },
  Event_125758_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_125758_Desc = {
    Text = "Ela é a querida dos afortunados. Ela é a criança abandonada pelo destino. Ela é a vingadora que rastejou para fora do abismo seguindo uma luz tênue. Ela veio aqui para trazer libertação a tudo. \nA Rede do destino desmorona ao redor de vocês. Você está no palco do teatro, separado de Nefraea por uma distância não tão grande."
  },
  Event_125758_Name = {
    Text = "Rede do destino – Fim"
  },
  Event_125759_ChoiceDesc1 = {
    Text = "[Indifferent] Obtenha a Criação de prata [(RelicConfig.Arg1)]"
  },
  Event_125759_ChoiceDesc2 = {
    Text = "[Empathetic] Obtenha a Criação de ouro \"(RelicConfig.Arg1)\", mas desenvolva \"(Skill.Arg2)\""
  },
  Event_125759_Desc = {
    Text = "Gritos agudos irrompem do palco enquanto o único holofote recai sobre uma figura solitária.\nEle lhe oferece sua performance mais sincera — abrindo o peito para apresentar suas vísceras a cada espectador.\nO que é que tanto atormenta esse personagem?"
  },
  Event_125759_Name = {
    Text = "Confissão de um Ator"
  },
  Event_125760_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125760_Desc = {
    Text = "Você estende a mão para a direita.\nAli está o seu futuro — seu anseio mais intenso, seu santuário definitivo e o destino que eventualmente alcançará.\nSua existência serve apenas para perseguir o sol à frente."
  },
  Event_125760_Name = {
    Text = "Passado, Futuro"
  },
  Event_125761_ChoiceDesc1 = {
    Text = "[Três Pontos]"
  },
  Event_125761_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_125761_ChoiceDesc3 = {
    Text = "[One Point]"
  },
  Event_125761_Desc = {
    Text = "Você poderia simplesmente partir, mas os dados exquisitos o cativam completamente.\nEsquecendo os perseguidores às suas costas, você os pega com reverência e os lança na cartola —"
  },
  Event_125761_Name = {
    Text = "Aposta de Rua"
  },
  Event_125762_ChoiceDesc1 = {
    Text = "[Sair] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_125762_Desc = {
    Text = "Chacoalha-chacoalha. Os dados dançam freneticamente no copo, girando até a exaustão.\n\n\"Por que... por que ninguém jamais vence?!\""
  },
  Event_125762_Name = {
    Text = "Aposta de Rua"
  },
  Event_125763_ChoiceDesc1 = {
    Text = "[Aceitar o Destino]Gravar a Oração「(EnchantConfig.Arg1)」em 1 de 3 Cartas de comando. (Usos: 0/2)"
  },
  Event_125763_ChoiceDesc2 = {
    Text = "[Desafiar o Destino]Desenvolver o Sintoma「(Skill.Arg1)」e mudar a Oração para gravação. (Usos: 1/2)"
  },
  Event_125763_Desc = {
    Text = "\"Ah, travessa. O Destino é sempre misericordioso... mas toda resistência cobra um preço. Agora, você está disposta a aceitá-lo?\""
  },
  Event_125763_Name = {
    Text = "A Gaiola do Destino"
  },
  Event_125764_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125764_Desc = {
    Text = "Você olha ao redor para aqueles olhares e ergue a mão em saudação.\nEm breve, você lhes concederá o crescendo da história."
  },
  Event_125764_Name = {Text = "Público"},
  Event_125765_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125765_Desc = {
    Text = "\"Querida Senhorita Arachne, hoje é o dia do seu nascimento. Sinto alegria pelo Senhor, pela Senhora e por você. Bem-vinda a este belo mundo. Ofereço-lhe esta suave canção de ninar, desejando-lhe uma vida livre de preocupações a partir de hoje...\""
  },
  Event_125765_Name = {
    Text = "Boa noite, Senhor Edgar"
  },
  Event_125766_ChoiceDesc1 = {
    Text = "[Tirar Foto] Grave a Oração [(EnchantConfig.Arg1)] em 1 de 3 Cartas de comando.(Usos: 0/2)"
  },
  Event_125766_ChoiceDesc2 = {
    Text = "[Mudar Novamente] Desenvolva o Sintoma [(Skill.Arg1)] e mude a Oração a gravar.(Usos: 1/2)"
  },
  Event_125766_Desc = {
    Text = "Você sente um lampejo de apreensão diante da lente. Talvez esta pose fosse melhor? Ou aquela?"
  },
  Event_125766_Name = {
    Text = "Registro na plateia"
  },
  Event_125767_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125767_Desc = {
    Text = "Você deseja ver o conteúdo, mas a tela está vazia. Apenas o som do filme girando ecoa no salão.\nTalvez demore muito até que você descubra o que há nos rolos."
  },
  Event_125767_Name = {
    Text = "Sala de Memórias"
  },
  Event_125768_ChoiceDesc1 = {
    Text = "[Evitar Olhar] Despertar aleatoriamente 1 Despertador"
  },
  Event_125768_ChoiceDesc2 = {
    Text = "[encarar o olhar] Escolha despertar 1 despertador, e reduza seu custo de aritmética de carta de despertar em 2 pontos. Infecção[(Skill.Arg1)]"
  },
  Event_125768_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_125768_Desc = {
    Text = "Ao subir ao palco, você ouve uma enxurrada de sussurros. Você se vira; dez mil pares de olhos flutuam ao redor do palco, olhando para você.\nVenha! dizem eles. Certamente o drama magnífico não termina aqui?\nDance! dizem eles. Traga-nos o clímax desta dança!"
  },
  Event_125768_Name = {Text = "Público"},
  Event_125769_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125769_Desc = {
    Text = "Você não entende sua dor, nem precisa entender.\nO teatro possui muitos palcos, e os palcos muitos fantoches; você é apenas um deles.\nVocê tem coisas mais importantes a fazer."
  },
  Event_125769_Name = {
    Text = "Confissão de um Ator"
  },
  Event_125770_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125770_Desc = {
    Text = "A morte, a dissolução, a passagem do tempo... A arte não existe para infligir dor. Se a beleza reside apenas no sofrimento, então tal beleza é melhor que não nasça.\nVocê golpeia para dispersá-las. As borboletas se dispersam, deixando para trás um cadáver melancólico."
  },
  Event_125770_Name = {
    Text = "Florescer na dissipação"
  },
  Event_125771_ChoiceDesc1 = {
    Text = "[Aperte o Corvo]ganhe 40 o sigilo negro, contamine「(Skill.Arg2)」，continue a escolher"
  },
  Event_125771_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Ganhe 25 Sigilos Negros e saia."
  },
  Event_125771_Desc = {
    Text = "Os corvos dispersos que cruzaram seu caminho convergem em um só. Ele pousa diante de você e canta, sua melodia desolada—como a profecia final."
  },
  Event_125771_Name = {
    Text = "A Profecia Final"
  },
  Event_125772_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125772_Desc = {
    Text = "Você estende a mão para a esquerda.\nAli está o seu passado — suas memórias mais preciosas, o caminho que um dia percorreu e o lugar ao qual eventualmente retornará.\nTudo o que foi forma tudo o que você é."
  },
  Event_125772_Name = {
    Text = "Passado, Futuro"
  },
  Event_125773_ChoiceDesc1 = {
    Text = "[Tirar Foto] Grave a Oração [(EnchantConfig.Arg1)] em 1 de 3 Cartas de comando.(Usos: 0/2)"
  },
  Event_125773_Desc = {
    Text = "Você sente um lampejo de apreensão diante da lente. Talvez esta pose seja melhor? Ou aquela?\nVocê ainda hesita, mas pode sentir o crescente aborrecimento da câmera."
  },
  Event_125773_Name = {
    Text = "Registro na plateia"
  },
  Event_125774_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125774_Desc = {
    Text = "Você assume uma pose diante da câmera — composto, curioso, imerso. Como um verdadeiro espectador.\nGorgolejo—\nO obturador clica. Lama negra irrompe do corpo da câmera, espirrando por todo o palco.\nNo centro oco do corpo da câmera, o filme permanece vazio."
  },
  Event_125774_Name = {
    Text = "Registro na plateia"
  },
  Event_125775_ChoiceDesc1 = {
    Text = "[Accept] Obtenha 1 de 3 Criações de prata"
  },
  Event_125775_ChoiceDesc2 = {
    Text = "[Flee] Obtenha as Criações de prata \"(RelicConfig.Arg1)\" e \"(RelicConfig.Arg2)\", mas desenvolva \"(Skill.Arg3)\" duas vezes"
  },
  Event_125775_Desc = {
    Text = "Tique-tique, tique-tique... Os saltos batem no assoalho com um estalo vivo e alegre.\nDois fantoches em uniformes escolares dançam sobre o palco. De repente, eles param seus passos — e se viram para estender as mãos em sua direção."
  },
  Event_125775_Name = {
    Text = "Dança de Três"
  },
  Event_125776_ChoiceDesc1 = {
    Text = "[Paciência com a Dor] Aumente Vida máxima em Arg1"
  },
  Event_125776_ChoiceDesc2 = {
    Text = "[Refutar a Dor] 1 Carta de comando aleatória obtém Gravura: \"(EnchantConfig.Arg1)\", infectar 1 \"(Skill.Arg2)\""
  },
  Event_125776_Desc = {
    Text = "\"Você nunca se importou com a morte de Liz. Você nunca se importou com ninguém.\"\n\"Você se importa apenas consigo mesmo... todos ao seu redor são meramente ferramentas para sua jornada em direção à liberdade e à paz.\"\n\"Não é assim... Guardião?\"\nO sussurro do Anunciador range em seu ouvido. Seu coração se contrai; uma agonia aguda se espalha por todo o seu ser com suas palavras..."
  },
  Event_125776_Name = {
    Text = "Agonia Propagante"
  },
  Event_125777_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125777_Desc = {
    Text = "Entregue-se à descida; o mar possui sua própria flutuabilidade, e o destino revelará o caminho para vocês dois."
  },
  Event_125777_Name = {
    Text = "Tranquilidade"
  },
  Event_125778_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125778_Desc = {
    Text = "É você mesmo. A fonte do poder, o portador do dever, o único objeto de lealdade.\nVocê trilha o caminho que pertence somente a você."
  },
  Event_125778_Name = {
    Text = "Reflexo no Espelho"
  },
  Event_125779_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125779_Desc = {
    Text = "\"Que pena, meu convidado. O Sabor do Destino... você nunca mais terá a chance de saboreá-lo...\""
  },
  Event_125779_Name = {
    Text = "O Sabor do Destino"
  },
  Event_125780_ChoiceDesc1 = {
    Text = "[Discutir com Ela] Destruir uma Carta de comando, e receber Arg1 Marcas Negras"
  },
  Event_125780_ChoiceDesc2 = {
    Text = "[Permanecer em silêncio]"
  },
  Event_125780_Desc = {
    Text = "\"Que peça triste... Aquela pobre menina foi abandonada por quem ela amava, irmã?\"\nNaquela voz familiar, você não ouve nenhum traço de loucura ou malícia. É clara e melancólica, como um suave riacho através de uma floresta.\n\"A cantora, uma folha murcha à deriva sem rumo, entregue às devastações do destino... Que alma digna de pena...\"\n\"Irmã, se eu fosse a autora... que final eu deveria escrever para ela?\""
  },
  Event_125780_Name = {
    Text = "O Fim da Peça"
  },
  Event_125781_ChoiceDesc1 = {
    Text = "[Acariciá-los] 50% de chance de ganhar 125 Marca Negra, 50% de chance de desenvolver[(Skill.Arg2)]"
  },
  Event_125781_ChoiceDesc2 = {
    Text = "[Explain] 75% de chance de ganhar 100 Marca Negra, 25% de chance de desenvolver[(Skill.Arg2)]"
  },
  Event_125781_ChoiceDesc3 = {
    Text = "[Ver Através] Ganhe 50 Marca Negra"
  },
  Event_125781_Desc = {
    Text = "Ao perseguir o monstro para o beco dos fundos do bar, sua silhueta desaparece. Um grupo de gatos pretos barra seu caminho.\n\"Ei, você.\" Um gato preto lambe sua pata, olhando em sua direção.\n\"O que você está fazendo em nosso território?\""
  },
  Event_125781_Name = {
    Text = "Formas Mutáveis"
  },
  Event_125782_ChoiceDesc1 = {
    Text = "[Abraçar o Passado] Obtenha a Criação de ouro \"(RelicConfig.Arg1)\", mas desenvolva \"(Skill.Arg2)\""
  },
  Event_125782_ChoiceDesc2 = {
    Text = "[Receber o Futuro] Obtenha 1 entre 3 Criações de ouro, mas desenvolva o Sintoma[(Skill.Arg1)]"
  },
  Event_125782_ChoiceDesc3 = {
    Text = "[Sair] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_125782_Desc = {
    Text = "O surgimento de Nefraea perturbou os fios. No destino em desordem, você vê dois Fantasmas indistintos. \nÉ o seu passado, é o seu futuro. Você caminha em direção a eles e estende a mão..."
  },
  Event_125782_Name = {
    Text = "Passado, Futuro"
  },
  Event_125855_ChoiceDesc1 = {
    Text = "[Perceive] Melhore 1 Criação para a Criação de ouro[(RelicConfig.Arg1)]"
  },
  Event_125855_ChoiceDesc2 = {
    Text = "[Stare] Obtenha a Relíquia de Prata \"(RelicConfig.Arg1)\" e torna-se infectado com \"(Skill.Arg2)\"."
  },
  Event_125855_ChoiceDesc3 = {
    Text = "[Ignorar] Ganhe 25 O Sigilo Negro"
  },
  Event_125855_Desc = {
    Text = "Nas ruas de Casalim, o brilho radiante de uma loja de cristais atrai você. Você para diante da vitrine e pega um cristal em forma de Núcleo de prata."
  },
  Event_125855_Name = {
    Text = "Segredo do Cristal"
  },
  Event_125856_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125856_Desc = {
    Text = "Você fecha os olhos, sentindo com cuidado.\nUm vislumbre de luz cintila em sua consciência, como se tentasse lhe dizer algo..."
  },
  Event_125856_Name = {
    Text = "Segredo do Cristal"
  },
  Event_125857_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125857_Desc = {
    Text = "Qualquer resistência ou investigação do destino é inútil. Você fecha os olhos em silêncio, permitindo que o destino o leve aonde você deve ir."
  },
  Event_125857_Name = {
    Text = "Rede de Amarração do Destino"
  },
  Event_125858_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125858_Desc = {
    Text = "\"Emoção é o significado da existência. Que você nunca se arrependa da sua escolha.\""
  },
  Event_125858_Name = {
    Text = "O preço da escolha"
  },
  Event_125859_ChoiceDesc1 = {
    Text = "[Emotion] Recupere Arg1 pontos de Vida"
  },
  Event_125859_ChoiceDesc2 = {
    Text = "[Reason] Grave a Oração [(EnchantConfig.Arg1)] em 1 Carta de comando aleatória"
  },
  Event_125859_ChoiceDesc3 = {
    Text = "[Recusar a escolha] Ganhar 25 Selos Negros"
  },
  Event_125859_Desc = {
    Text = "Uma balança aparece sobre o palco.\n\"Cérebro e coração, razão e emoção, cinza e vermelho... não podemos escapar da escolha; é o nosso destino.\"\n\"O fim do palco já está traçado. Agora, escolha o caminho que esta apresentação percorrerá.\""
  },
  Event_125859_Name = {
    Text = "O preço da escolha"
  },
  Event_125860_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125860_Desc = {
    Text = "\"Não olhe para cima. Deixe este lugar.\"\nVocê ouve a voz do destino. Embora anseie por contemplar o céu, você sabe que ela está certa."
  },
  Event_125860_Name = {
    Text = "Olhar para cima"
  },
  Event_125861_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125861_Desc = {
    Text = "Você nunca aceita o destino. Você nunca aceita o aprisionamento.\nVocê luta com todas as suas forças. Após sacrificar um membro da mariposa, finalmente consegue escapar..."
  },
  Event_125861_Name = {
    Text = "Rede de Amarração do Destino"
  },
  Event_125862_ChoiceDesc1 = {
    Text = "[Friendship] Receber 50 Marcas Negras"
  },
  Event_125862_ChoiceDesc2 = {
    Text = "[Help] Receber 75 Marcas Negras, mas desenvolver o Sintoma [(Skill.Arg2)]"
  },
  Event_125862_Desc = {
    Text = "No beco atrás do bar, você encontra aqueles gatos negros mais uma vez.\n\"Eu ouvi. Aqueles slimes negros tomaram nossa forma e causaram bastante problema para você.\"\n\"Como pedido de desculpas, me diga — o que você quer?\"\nOs gatos negros circulam suas pernas duas vezes, olhando para você."
  },
  Event_125862_Name = {
    Text = "Presente de Primeiro Encontro"
  },
  Event_125863_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125863_Desc = {
    Text = "A força bruta não pode desvendar o destino, mas talvez a sabedoria possa?\nVocê observa a teia de perto, buscando algum fio do desenho do destino dentro dela..."
  },
  Event_125863_Name = {
    Text = "Rede de Amarração do Destino"
  },
  Event_125864_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125864_Desc = {
    Text = "Você se inclina, olhando fixamente para ele.\nUm vislumbre de luz cintila em seus olhos, como se tentasse lhe dizer algo..."
  },
  Event_125864_Name = {
    Text = "Segredo do Cristal"
  },
  Event_125865_ChoiceDesc1 = {
    Text = "[Struggle] Destruir 1 de 3 Cartas de comando aleatórias, e receber 75 Marcas Negras"
  },
  Event_125865_ChoiceDesc2 = {
    Text = "[Rest] Duplicar 1 de 3 Cartas de comando, e receber 25 Marcas Negras"
  },
  Event_125865_ChoiceDesc3 = {
    Text = "[Rest] Receber 50 Marcas Negras"
  },
  Event_125865_Desc = {
    Text = "Uma sensação familiar te assalta. Mas desta vez, o toque viscoso e o instinto de impotência são mais intensos, mais letais.\nA mariposa cai na teia da aranha. E você já pisou no palco."
  },
  Event_125865_Name = {
    Text = "Rede de Amarração do Destino"
  },
  Event_125866_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125866_Desc = {
    Text = "\"Razão é o significado da existência. Que você nunca se arrependa da sua escolha.\""
  },
  Event_125866_Name = {
    Text = "O preço da escolha"
  },
  Event_125867_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125867_Desc = {
    Text = "A curiosidade é acesa. Você se mistura à multidão e ergue a cabeça como eles.\nNão há nada ali, mas por razões desconhecidas, você reluta em desviar o olhar. Você deseja observar assim — observar para sempre..."
  },
  Event_125867_Name = {
    Text = "Olhar para cima"
  },
  Event_125868_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125868_Desc = {
    Text = "\"Recusar a decisão é em si uma decisão—esta é a maldição do destino. Que você nunca se arrependa da escolha que fez.\""
  },
  Event_125868_Name = {
    Text = "O preço da escolha"
  },
  Event_125869_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125869_Desc = {
    Text = "\"Agora, é seu.\"\nOs gatos roçam em sua canela e logo desaparecem.\nOnde desapareceram, um presente aguarda."
  },
  Event_125869_Name = {
    Text = "Presente de Primeiro Encontro"
  },
  Event_125870_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125870_Desc = {
    Text = "\"Agora, é seu.\"\nOs gatos roçam em sua canela e logo desaparecem.\nOnde desapareceram, um presente aguarda."
  },
  Event_125870_Name = {
    Text = "Presente de Primeiro Encontro"
  },
  Event_125871_ChoiceDesc1 = {
    Text = "[Levantar a Cabeça] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_125871_ChoiceDesc2 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_125871_Desc = {
    Text = "A cacofonia desaparece por um instante fugaz. As multidões na rua caem em silêncio, erguendo suas cabeças em direção ao céu."
  },
  Event_125871_Name = {
    Text = "Olhar para cima"
  },
  Event_129176_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129176_Name = {
    Text = "Esquecimento Capítulo 1@"
  },
  Event_129177_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129177_Name = {
    Text = "Capítulo 1 das Estrelas@"
  },
  Event_129178_ChoiceDesc1 = {
    Text = "[Indicate Direction] Obtenha Relíquia de prata \"(RelicConfig.Arg1)\", e contrate \"(Skill.Arg2)\""
  },
  Event_129178_ChoiceDesc2 = {
    Text = "[Orar juntos] Gravar 1 de 3 Gravuras duas vezes"
  },
  Event_129178_Desc = {
    Text = "O som do piano e do órgão se entrelaçam no vento cinzento. Uma melodia mágica flutua pelas ruas desertas.  \nUma freira anônima reza com a música.  \n\"Uma oração simples não precisa de rituais solenes, o grande Pai nos enviará esperança, assim como ele nos deu os ensinamentos piedosos.\""
  },
  Event_129178_Name = {
    Text = "Oração do Órgano"
  },
  Event_129179_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129179_Name = {
    Text = "Capítulo 1 das Estrelas@"
  },
  Event_129180_ChoiceDesc1 = {
    Text = "[Face It] Obter a relíquia amaldiçoada \"(RelicConfig.Arg1)\" e ficar infectado com \"(Skill.Arg2)\"."
  },
  Event_129180_ChoiceDesc2 = {
    Text = "[Surrender] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129180_ChoiceDesc3 = {
    Text = "[Run Away] Ganhe 50 sigilos negros"
  },
  Event_129180_Desc = {
    Text = "Alguns blocos de escultura de cera obstruem seu caminho.\nEles são tortos e ásperos em aparência, não se assemelhando à habilidade que se esperaria de Rogers.\n\"Ordens... ordens do mestre...\""
  },
  Event_129180_Name = {Text = "Estudo"},
  Event_129181_ChoiceDesc1 = {
    Text = "[Quit Thinking] Obtenha a relíquia amaldiçoada \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_129181_ChoiceDesc2 = {
    Text = "[Seguir a Inspiração] 1 Carta de comando aleatória obtém Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129181_Desc = {
    Text = "Ataque ao porto, um misterioso navio de carga sem retorno e um novo \"amigo\" com nadadeiras... é uma armadilha bem planejada? Ou mais uma viagem cheia de imprevistos?\nA realidade e a razão se entrelaçam, e uma infinidade de inspirações e pensamentos jorra de minha mente"
  },
  Event_129181_Name = {
    Text = "Inspiração súbita"
  },
  Event_129182_ChoiceDesc1 = {
    Text = "[Join] Infecta \"(Skill.Arg1)\" duas vezes, 1 Carta de comando aleatória recebe Gravura: \"(EnchantConfig.Arg2)\" duas vezes"
  },
  Event_129182_ChoiceDesc2 = {
    Text = "[Dispel] Infecta \"(Skill.Arg1)\" duas vezes, 1 Carta de comando aleatória recebe Gravura: \"(EnchantConfig.Arg2)\" duas vezes"
  },
  Event_129182_ChoiceDesc3 = {
    Text = "[Disregard] Escolha 1 entre 3 Cartas de comando para receber Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129182_Desc = {
    Text = "Você ouve ao longe o som sutil de uma trombeta de ossos. \n A multidão de ratos emerge do lodo negro, roendo os corpos anônimos que jazem no leito do rio seco. \n Eles formam um círculo, com o centro sendo aquele cadáver já vazio, e a circunferência é um novo reino onde o esquecimento é a lei. \n E você está de pé na entrada desse reino."
  },
  Event_129182_Name = {
    Text = "Reino Exilado"
  },
  Event_129183_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129183_Name = {
    Text = "Esquecimento Capítulo cinco@"
  },
  Event_129184_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129184_Name = {
    Text = "Esquecimento Capítulo 8@"
  },
  Event_129185_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129185_Name = {
    Text = "Capítulo 1 do Esquecimento@"
  },
  Event_129186_ChoiceDesc1 = {
    Text = "[Resgatar o retrato] Escolha 1 entre 3 Cartas de comando para receber Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infecta \"(Skill.Arg2)\" duas vezes"
  },
  Event_129186_ChoiceDesc2 = {
    Text = "[Aceitar o vazio] Escolha 1 entre 3 Cartas de comando para receber Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infecta \"(Skill.Arg2)\" duas vezes"
  },
  Event_129186_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_129186_Desc = {
    Text = "Você está diante do presente de Pickman. \n É um retrato, pintado com sangue, e chamas negras queimam silenciosamente. \n Através das órbitas vazias do retratado, você vê— \n suas memórias fervilham e queimam, se alongando, distorcendo-se, brilhando, como se uma chama invisível estivesse lambendo os corredores de sua mente. Em um momento de confusão, você ouve uma voz. \n \"Está na hora de ir para a panela, o fogo está perfeito.\" \n Esta é a cena de memória que você mesmo pintou, lutando e se transformando nas chamas."
  },
  Event_129186_Name = {
    Text = "Retrato Ardente"
  },
  Event_129187_ChoiceDesc1 = {
    Text = "[Que Preço Você Está Disposto a Pagar?] Aumentar a qualidade da Oração de uma carta aleatória duas vezes."
  },
  Event_129187_ChoiceDesc2 = {
    Text = "[Sirva-lhes um Bloody Mary vencido] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infectar \"(Skill.Arg2)\" duas vezes"
  },
  Event_129187_Desc = {
    Text = "\"Bem-vindo, meu precioso convidado. Sinta-se à vontade para escolher, tudo isso está aqui à sua espera.\"\n\"Desculpe, posso perguntar se você é... a irmã gêmea da senhora Daffodil?\"\n\"Eu sou a própria Daffodil, por favor, o que traz o convidado aqui hoje...?\"\n\"Desculpe, desculpe, você está ainda mais encantadora do que antes, eu não consegui reconhecer. Você se lembra? Há vinte anos, você expulsou um estranho do meu bar... Ontem, o pesadelo recorrente voltou, ele tomou conta do bar, trazendo seus semelhantes, em grandes grupos...\""
  },
  Event_129187_Name = {
    Text = "Fragmento de Memória: Sonho Antigo"
  },
  Event_129188_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129188_Name = {
    Text = "Capítulo 3 das Estrelas@"
  },
  Event_129189_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129189_Name = {
    Text = "Esquecimento Capítulo 8@"
  },
  Event_129190_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129190_Name = {
    Text = "Capítulo 1 do Esquecimento@"
  },
  Event_129191_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129191_Name = {
    Text = "Esquecimento Capítulo 6@"
  },
  Event_129192_ChoiceDesc1 = {
    Text = "[Segurar Brasa] Aumente a saúde máxima em Arg1"
  },
  Event_129192_ChoiceDesc2 = {
    Text = "[Encarar o interior] 2 Cartas de comando aleatórias obtêm Gravura: \"(EnchantConfig.Arg1)\" duas vezes, mas desenvolver 2 \"(Skill.Arg2)\" duas vezes"
  },
  Event_129192_Desc = {
    Text = "Nesta grande caça, a perseguição de Goliath é como uma besta feroz na noite sombria, tentando devorar toda a luz da esperança. No entanto, essa perseguição implacável não te congelou, mas acendeu a chispa dentro de você, que se propagou e queimou em seu peito, tornando-se cada vez mais ardente."
  },
  Event_129192_Name = {
    Text = "Seguir a luz"
  },
  Event_129193_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129193_Name = {
    Text = "Esquecimento Capítulo 6@"
  },
  Event_129194_ChoiceDesc1 = {
    Text = "[Ler o Caminho dos Predecessores] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_129194_ChoiceDesc2 = {
    Text = "[Escreva seu próprio caminho] Obtenha a relíquia de prata \"(RelicConfig.Arg1)\" e inflinja \"(Skill.Arg2)\"."
  },
  Event_129194_ChoiceDesc3 = {
    Text = "[Stare into Darkness] Ganhe 25 sigilos negros"
  },
  Event_129194_Desc = {
    Text = "Se você estiver explorando sozinho no domínio, não se sentirá tão confiante sobre seu caminho como agora.  \nAs pegadas no domínio se dividiram em três, e cada marca deixada escreve um futuro invisível"
  },
  Event_129194_Name = {Text = "Saída"},
  Event_129195_ChoiceDesc1 = {
    Text = "[Apontar o Erro] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infectar \"(Skill.Arg2)\" duas vezes"
  },
  Event_129195_ChoiceDesc2 = {
    Text = "[Listen to the Performance] Ganhe 15 Sigilos Negros para cada Despertador com Aliemus de 50 ou mais."
  },
  Event_129195_ChoiceDesc3 = {
    Text = "[Leave] Obter 1 de 3 Orações"
  },
  Event_129195_Desc = {
    Text = "O garoto boneco de cera estava tocando piano.\nSeu professor - também um boneco de cera - ao lado, corrigia:\n133, 355, 244...\nErrado. Cada nota errada"
  },
  Event_129195_Name = {
    Text = "Aulas de piano"
  },
  Event_129196_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129196_Name = {
    Text = "Esquecimento Capítulo cinco@"
  },
  Event_129197_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129197_Name = {
    Text = "Capítulo 4 das Estrelas@"
  },
  Event_129198_ChoiceDesc1 = {
    Text = "[Ouvir o Choro de tristeza] Escolher 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\" duas vezes, mas desenvolver \"(Skill.Arg2)\" duas vezes"
  },
  Event_129198_ChoiceDesc2 = {
    Text = "[Hear Joy] Para cada Despertar com Aliemus 50 ou acima, ganhe 15 O sigilo negro."
  },
  Event_129198_ChoiceDesc3 = {
    Text = "[Leave] Escolha 1 entre 3 Gravuras duas vezes."
  },
  Event_129198_Desc = {
    Text = "Melódico, lírico, alegre, triste... A melodia ecoa no espaço do domínio, difícil de identificar sua origem.\nÉ uma sonata que flui do navio fantasma, ou uma rapsódia de meia-noite aprisionada no domínio?"
  },
  Event_129198_Name = {
    Text = "Som Anônimo"
  },
  Event_129199_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129199_Name = {
    Text = "Capítulo 1 das Estrelas@"
  },
  Event_129200_ChoiceDesc1 = {
    Text = "[Abrir o Envelope] Ganhar Relíquia de Ouro '(RelicConfig.Arg1)', infectar '(Skill.Arg2)'"
  },
  Event_129200_ChoiceDesc2 = {
    Text = "[Read] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129200_ChoiceDesc3 = {
    Text = "[Put it back] Ganhe 50 O sigilo negro"
  },
  Event_129200_Desc = {
    Text = "Num canto esquecido, uma carta foi deixada para trás.  \nMuitas palavras na carta já não são legíveis, mas há uma delas. Tão forte que parece rasgar o papel.  \nEssa palavra é \"mãe\".\n\n."
  },
  Event_129200_Name = {
    Text = "Saudade Desaparecida"
  },
  Event_129201_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129201_Name = {
    Text = "Estrelas Capítulo 4@"
  },
  Event_129202_ChoiceDesc1 = {
    Text = "[Ouvir com atenção] Escolher 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\" duas vezes, mas desenvolver \"(Skill.Arg2)\" duas vezes"
  },
  Event_129202_ChoiceDesc2 = {
    Text = "[Cover Ears] Para cada Despertador com Aliemus de 50 ou mais, ganhe 15 Sigilos Negros."
  },
  Event_129202_ChoiceDesc3 = {
    Text = "[Examine] Gravar 1 de 3 Gravuras duas vezes"
  },
  Event_129202_Desc = {
    Text = "Quando vocês entraram no andar onde estavam os restos, um lindo som de ding-dong ecoou repentinamente na fábrica abandonada, a sensação de um piano tocando era totalmente fora de lugar entre os destroços de ferro enferrujado"
  },
  Event_129202_Name = {
    Text = "Escala Sinistra"
  },
  Event_129203_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129203_Name = {
    Text = "Esquecimento Capítulo 3@"
  },
  Event_129204_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129204_Name = {
    Text = "Esquecimento Capítulo 6@"
  },
  Event_129205_ChoiceDesc1 = {
    Text = "[Poupe-a] Obtenha a relíquia amaldiçoada \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_129205_ChoiceDesc2 = {
    Text = "[Ajudá-la] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129205_ChoiceDesc3 = {
    Text = "[Vou Caminhar Meu Próprio Caminho] Ganhe 50 Sigilos Negros"
  },
  Event_129205_Desc = {
    Text = "Três figuras bloquearam seu caminho. \n \"Você pode poupá-la,\" disse a figura segurando um ursinho coberto de lama corrosiva, \"ela apenas é tímida, não maligna. Ela não quer machucar ninguém.\" \n \"Você pode ajudá-la,\" disse a figura segurando uma embalagem requintada de doces, \"você pode fazer o que ela não consegue, você pode acabar com tudo isso.\" \n \"Você não precisa nos ouvir,\" disse a figura com as mãos vazias, \"você tem seu próprio caminho.\""
  },
  Event_129205_Name = {
    Text = "Caminho bifurcado"
  },
  Event_129206_ChoiceDesc1 = {
    Text = "[Alimentar os Ratos] ganha Criação de prata[(RelicConfig.Arg1)], desenvolve 1 sintoma"
  },
  Event_129206_ChoiceDesc2 = {
    Text = "[Afastar os ratos] Escolha 1 entre 3 Cartas de comando para receber Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infecta \"(Skill.Arg2)\" duas vezes"
  },
  Event_129206_ChoiceDesc3 = {
    Text = "[Ignorar os Ratos] ganhe 25 Marca Negra"
  },
  Event_129206_Desc = {
    Text = "Tudo neste navio está preso no ciclo temporal.\nAté mesmo aquelas criaturas peludas e nojentas lutando para sobreviver aqui não podem escapar de seu destino.\nCiclo após ciclo, eles devoram tudo à vista, mas sua fome nunca é saciada.\n\"Tanta... fome...\"\nHordas de ratos emitem guinchos agudos e doentios.\nOs ciclos intermináveis os deixaram famintos e enlouquecidos — eles precisam comer algo.\nAgora. Imediatamente."
  },
  Event_129206_Name = {
    Text = "Bando de ratos famintos"
  },
  Event_129207_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129207_Name = {
    Text = "Esquecimento do Capítulo 8@"
  },
  Event_129208_ChoiceDesc1 = {
    Text = "[Tocar o cérebro] 1 Carta de comando aleatória recebe Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129208_ChoiceDesc2 = {
    Text = "[Tocar o Coração] Aumente Arg1 pontos de saúde máxima, infecte[(Skill.Arg2)]"
  },
  Event_129208_Desc = {
    Text = "Você entra na sala cinza, onde ninguém sussurra, e uma balança aparece vagamente na névoa negra. \n À esquerda, há um cérebro tranquilo como um lago, com ravinas prateadas brilhando suavemente; à direita, um coração vermelho ardente, exalando vapor quente. \n De repente, você sente um aroma, um desejo faminto crescendo incessantemente, enquanto a razão é comprimida pela infinita escuridão dele. \n Você estende a mão."
  },
  Event_129208_Name = {
    Text = "Jogo do Fome"
  },
  Event_129209_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129209_Name = {
    Text = "Esquecimento Capítulo quatro@"
  },
  Event_129210_ChoiceDesc1 = {
    Text = "[Abater as sombras] Escolher 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\" duas vezes, mas desenvolver \"(Skill.Arg2)\" duas vezes"
  },
  Event_129210_ChoiceDesc2 = {
    Text = "[Esmagar o embrião] Escolher 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\" duas vezes, mas desenvolver \"(Skill.Arg2)\" duas vezes"
  },
  Event_129210_ChoiceDesc3 = {
    Text = "[Close Your Eyes] Ganhar 25 sigilos negros"
  },
  Event_129210_Desc = {
    Text = "Em um transe, você vê pessoas que conheceu em Aran se aproximando.\nEles riem e te convidam para beber, dançar e aproveitar o banquete.\nEntão, suas carnes começam a se desprender em camadas, caindo no chão e se retorcendo em novos embriões.\nEles estendem a mão, te convidando para a celebração de carne e renascimento."
  },
  Event_129210_Name = {
    Text = "Sombras do Passado"
  },
  Event_129211_ChoiceDesc1 = {
    Text = "[Feed them] Ganhar Relíquia de Prata '(RelicConfig.Arg1)', escolher infectar 1 vez o sintoma"
  },
  Event_129211_ChoiceDesc2 = {
    Text = "[Não dar atenção] Escolher 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infectar \"(Skill.Arg2)\" duas vezes"
  },
  Event_129211_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_129211_Desc = {
    Text = "Os moradores vão e vêm, mas a multidão de ratos persiste por muito tempo. \n Comparados aos humanos, eles são os \"nativos\" deste castelo. \n Mas eles não têm objeções à presença humana. \n Porque aquelas coisas feias, macias e brancas, lhes oferecem igualmente coisas feias, macias e brancas. \n \"E você, coisa feia, pertence a qual tipo?\""
  },
  Event_129211_Name = {
    Text = "O segredo do antigo castelo"
  },
  Event_129212_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129212_Name = {
    Text = "Esquecimento Capítulo cinco@"
  },
  Event_129213_ChoiceDesc1 = {
    Text = "[Discernir a Voz do Homem] Desenhe aleatoriamente 3 cartas de comando do baralho e escolha 1 para duplicar."
  },
  Event_129213_ChoiceDesc2 = {
    Text = "[Distinguir a voz da mulher] Escolher 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\" duas vezes, mas desenvolver \"(Skill.Arg2)\" duas vezes"
  },
  Event_129213_ChoiceDesc3 = {
    Text = "[Discernir a Voz do Ancião] Receba 25 [O sigilo negro]"
  },
  Event_129213_Desc = {
    Text = "Você está sozinho em um pântano escuro.\nNa neblina, você ouve sussurros caóticos se sobreporem como ondas do mar, uns vindos de idosos, outros de crianças balbuciando, alguns de mulheres ansiosas, outros de homens tomados por um medo inexplicável…"
  },
  Event_129213_Name = {
    Text = "Últimas palavras incoerentes"
  },
  Event_129214_ChoiceDesc1 = {
    Text = "[Dar uma Olhada de Perto] Gravar 1 entre 3 Orações duas vezes."
  },
  Event_129214_ChoiceDesc2 = {
    Text = "[Arrancar o cartaz] 1 Carta de comando aleatória obtém Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infectar \"(Skill.Arg2)\" duas vezes"
  },
  Event_129214_Desc = {
    Text = "Um candelabro comum em um museu de cera.\nÀ luz laranja doentia, você vê um pôster desenhado à mão na parede"
  },
  Event_129214_Name = {
    Text = "Risada na Escuridão"
  },
  Event_129215_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129215_Name = {
    Text = "Esquecimento Capítulo quatro@"
  },
  Event_129216_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129216_Name = {
    Text = "Capítulo 7 do Esquecimento@"
  },
  Event_129217_ChoiceDesc1 = {
    Text = "[Stare] Obtenha a Relíquia de Prata \"(RelicConfig.Arg1)\" e torna-se infectado com \"(Skill.Arg2)\"."
  },
  Event_129217_ChoiceDesc2 = {
    Text = "[Ignore] Gravar 1 de 3 Gravuras duas vezes"
  },
  Event_129217_Desc = {
    Text = "Os Aram se agacham na tempestade de areia.\nA tempestade golpeia seus corpos, e a areia arrasta sua devoção.\nNo turbilhão de poeira, parece haver incontáveis olhos gigantes observando a terra distorcida"
  },
  Event_129217_Name = {
    Text = "Gigante de Areia e Poeira"
  },
  Event_129218_ChoiceDesc1 = {
    Text = "[Afastar as borboletas] 1 Carta de comando aleatória recebe Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infecta \"(Skill.Arg2)\" duas vezes"
  },
  Event_129218_ChoiceDesc2 = {
    Text = "[Ouvir o desejo] Escolha 1 entre 3 Cartas de comando para receber Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129218_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_129218_Desc = {
    Text = "A pequena borboleta também tem muitos sonhos.\nEsses sonhos estão espalhados no mar de flores, no quarto do hospital, e também no altar cheio de carne e sangue de @2.\nAgora, finalmente, ela espera pela pessoa que a prenderá, não sabe se você está disposto a ouvir seu pequeno, pequeno desejo."
  },
  Event_129218_Name = {
    Text = "Sonho da borboleta"
  },
  Event_129219_ChoiceDesc1 = {
    Text = "[Seguir a orientação] Escolha 1 entre 3 Cartas de comando para receber Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infecta \"(Skill.Arg2)\" duas vezes"
  },
  Event_129219_ChoiceDesc2 = {
    Text = "[Ignorar a orientação] Escolha 1 entre 3 Cartas de comando para receber Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infecta \"(Skill.Arg2)\" duas vezes"
  },
  Event_129219_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_129219_Desc = {
    Text = "O festival começou.\nSob as chamas do Espírito e as bênçãos do sangue, inúmeras Almas de crentes tornaram-se faróis—\nOs espíritos etéreos se dispersam ao seu redor como fadas guia, brilhando e esperando sua escolha."
  },
  Event_129219_Name = {
    Text = "Faro de alma"
  },
  Event_129220_ChoiceDesc1 = {
    Text = "[Ignorar o sino] Escolha 1 entre 3 Gravuras avançadas duas vezes."
  },
  Event_129220_ChoiceDesc2 = {
    Text = "[Pick Up the Receiver]adquirir a relíquia de ouro \"(RelicConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_129220_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_129220_Desc = {
    Text = "Não deveria tocar — aquele telefone, encolhido atrás da tela. \n O fio do fone está enrolado no grande corpo da máquina, como um cordão umbilical enferrujado, parecendo se estender a partir da sua mente. \n Você distingue cuidadosamente a frequência da vibração, o som estranho é como a arte surreal de Pickman."
  },
  Event_129220_Name = {
    Text = "Ligação perdida"
  },
  Event_129221_ChoiceDesc1 = {
    Text = "[Estamos Todos Seguros] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infectar \"(Skill.Arg2)\" duas vezes"
  },
  Event_129221_ChoiceDesc2 = {
    Text = "[Quem é Você?] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infectar \"(Skill.Arg2)\" duas vezes"
  },
  Event_129221_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_129221_Desc = {
    Text = "A máquina de escrever jorra tinta abruptamente, com tantos pontos de exclamação que ofuscam a vista. \n \"Doll, você está bem??? Por que o Guardião desapareceu e você também desapareceu!!! Por favor, se estiver bem, me mande uma mensagem!!! Se continuar assim, o cabelo do William vai cair todo!!!\""
  },
  Event_129221_Name = {
    Text = "Comunicação de emergência"
  },
  Event_129222_ChoiceDesc1 = {
    Text = "[Cut the Red Ribbon] Remover 1 Carta de Comando, Ganhar Arg1 O Sigilo Negro"
  },
  Event_129222_ChoiceDesc2 = {
    Text = "[Confronto] Copie 1 carta de comando, infecte [(Skill.Arg1)]"
  },
  Event_129222_ChoiceDesc3 = {
    Text = "[Chamar Ramona] Escolher 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129222_Desc = {
    Text = "Casiah lançou a seda vermelha, envolvendo instantaneamente sua mala"
  },
  Event_129222_Name = {
    Text = "Seda emaranhada"
  },
  Event_129223_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129223_Name = {
    Text = "Esquecimento Capítulo seis@"
  },
  Event_129224_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129224_Name = {
    Text = "Capítulo 3 das Estrelas@"
  },
  Event_129225_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129225_Name = {
    Text = "Esquecimento Capítulo 3@"
  },
  Event_129226_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129226_Name = {
    Text = "Esquecimento Capítulo quatro@"
  },
  Event_129227_ChoiceDesc1 = {
    Text = "[Afastar com a mão] Escolha 1 entre 3 Cartas de comando para receber Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infecta \"(Skill.Arg2)\" duas vezes"
  },
  Event_129227_ChoiceDesc2 = {
    Text = "[Let It Stay] Ganhe Relíquia de Prata \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_129227_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_129227_Desc = {
    Text = "Um leve som veio da escuridão. \n Era uma borboleta que perguntava educadamente. \n \"Posso pousar na sua palma?\" \n \"Estou apenas muito cansada, quero descansar um pouco...\" \n Assim perguntando, a borboleta atravessou a escuridão, girando diante de você. \n Um líquido negro gotejava de suas asas — era o presente da escuridão que a borboleta trazia ao atravessar a escuridão."
  },
  Event_129227_Name = {
    Text = "Pedido da borboleta"
  },
  Event_129228_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129228_Name = {
    Text = "Capítulo 7 do Esquecimento@"
  },
  Event_129229_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129229_Name = {
    Text = "Esquecimento Capítulo 7@"
  },
  Event_129230_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129230_Name = {
    Text = "Capítulo 1 de Esquecimento@"
  },
  Event_129231_ChoiceDesc1 = {
    Text = "[Recognize Lyrics] Obtenha uma Relíquia de Prata \"(RelicConfig.Arg1)\", e infecte \"(Skill.Arg2)\""
  },
  Event_129231_ChoiceDesc2 = {
    Text = "[Cantarolar suavemente] Gravar 1 de 3 Gravuras duas vezes"
  },
  Event_129231_Desc = {
    Text = "Uma antiga canção de barco ecoa no domínio.\nAs memórias presas no domínio cantam em uma linguagem que você nunca ouviu, sobre as ondas, o céu e o aguardente"
  },
  Event_129231_Name = {
    Text = "Canção do Mar"
  },
  Event_129232_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129232_Name = {
    Text = "Capítulo 8 do Esquecimento@"
  },
  Event_129233_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129233_Name = {
    Text = "Capítulo 1 das Estrelas@"
  },
  Event_129234_ChoiceDesc1 = {
    Text = "[Cortar a palma] Escolha 1 entre 3 Cartas de comando para receber Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infecta \"(Skill.Arg2)\" duas vezes"
  },
  Event_129234_ChoiceDesc2 = {
    Text = "[Aceitar Crescimento]adquirir a relíquia de prata \"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_129234_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_129234_Desc = {
    Text = "A borboleta não veio voando, mas cresceu lentamente de sua palma. \n No começo, você pensou que era apenas suor, mas entre os dedos viu um líquido negro sair silenciosamente, como um vaso sanguíneo, se solidificando em asas frias e pulsantes. \n A cada movimento, ondas se formavam em seu sangue."
  },
  Event_129234_Name = {
    Text = "Parasita da elite"
  },
  Event_129235_ChoiceDesc1 = {
    Text = "[Continuar Navegando] 1 Carta de comando aleatória obtém Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129235_ChoiceDesc2 = {
    Text = "[Sair] aumenta Arg1 pontos de saúde máxima, infecção de[(Skill.Arg2)]"
  },
  Event_129235_Desc = {
    Text = "Uma balança para pesar.\nAtrás dela, inúmeros órgãos estão mergulhados em formalina vermelha.\nEstão organizados em prateleiras de armazenamento.\nVocê pega casualmente um caderno próximo e folheia:\n\"Coração: 8 oz, Cérebro: 50 oz...\""
  },
  Event_129235_Name = {
    Text = "Registro de órgãos"
  },
  Event_129236_ChoiceDesc1 = {
    Text = "[Detour] Remova 1 carta de comando e ganhe Arg1 sigilos negros."
  },
  Event_129236_ChoiceDesc2 = {
    Text = "[Perguntar por que afundou] Copiar 1 carta de comando, infectar [(Skill.Arg1)]"
  },
  Event_129236_ChoiceDesc3 = {
    Text = "[Cumprimentar a tripulação] Escolher 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129236_Desc = {
    Text = "\nEnquanto você caminha em direção à sala de energia, você encontra algumas \"memórias\" fixadas no domínio novamente.\nElas não são fantasmas, mas meramente os pensamentos persistentes do Capitão Elton sobre a tripulação perdida."
  },
  Event_129236_Name = {
    Text = "Dono do Sonanir"
  },
  Event_129237_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129237_Name = {
    Text = "Esquecimento Capítulo 3@"
  },
  Event_129238_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129238_Name = {
    Text = "Capítulo 1 das Estrelas@"
  },
  Event_129239_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129239_Name = {
    Text = "Esquecimento Capítulo 6@"
  },
  Event_129240_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129240_Name = {
    Text = "Esquecimento Capítulo cinco@"
  },
  Event_129241_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129241_Name = {
    Text = "Capítulo 4 das Estrelas@"
  },
  Event_129242_ChoiceDesc1 = {
    Text = "[Tocar para ele] Escolha 1 entre 3 Cartas de comando para receber Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infecta \"(Skill.Arg2)\" duas vezes"
  },
  Event_129242_ChoiceDesc2 = {
    Text = "[Listening to the Strings] Para cada Despertador com um Aliemus de 50 ou mais, ganhe 15 Sigilos Negros."
  },
  Event_129242_ChoiceDesc3 = {
    Text = "[Leave] Escolha 1 entre 3 Gravuras duas vezes."
  },
  Event_129242_Desc = {
    Text = "\"Querido John:\n    Recentemente, percebi de repente que já se passaram vários anos desde a última vez que você tocou piano para nós.\n    Este ano tenho 81 anos, e quanto mais envelheço, mais percebo o valor das lembranças da juventude.\n    Se você receber esta carta, por favor, na próxima vez que passar por Londinium, pare em frente ao meu apartamento e venha tocar uma música.\""
  },
  Event_129242_Name = {
    Text = "Sonata de Arrependimento"
  },
  Event_129243_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129243_Name = {
    Text = "Capítulo 3 das Estrelas@"
  },
  Event_129244_ChoiceDesc1 = {
    Text = "[Dizer Que Não Tem Carteira] Gravar 1 entre 3 Orações duas vezes."
  },
  Event_129244_ChoiceDesc2 = {
    Text = "[Romper a Rede] 1 Carta de comando aleatória obtém Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infectar \"(Skill.Arg2)\" duas vezes"
  },
  Event_129244_Desc = {
    Text = "Uma teia amarelo-alaranjada flutua silenciosamente no ar, seus buracos esparsos muito menos intrincados do que os de seus parentes aranhas que fazem ninho na parede.\nVocê não consegue resistir em estender a mão; a frágil teia se dissolve instantaneamente, e risadas de crianças ecoam em seus ouvidos.\n\"Ouro, prata, amarelo, vermelho, todas as carteiras são nossas!\""
  },
  Event_129244_Name = {
    Text = "Rede errante"
  },
  Event_129245_ChoiceDesc1 = {
    Text = "[Choose emotion] Restaure Arg1 pontos de vida"
  },
  Event_129245_ChoiceDesc2 = {
    Text = "[Manter a razão] 1 Carta de comando aleatória obtém Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129245_ChoiceDesc3 = {
    Text = "[Recusar a escolha] Ganhar 25 Selos Negros"
  },
  Event_129245_Desc = {
    Text = "\"Escolha, escolha.\"\nNa escuridão veloz, inumeráveis sussurros ecoaram.\nA voz é suavemente hipnótica, aparentemente carregando uma magia infinita que induz uma espécie de delírio louco em você.\nSeu cérebro afunda na loucura, contorcendo-se longe do corpo, enquanto o coração parece ter desenvolvido uma certa consciência, gritando e chamando você.\n\"Escolha, escolha.\"\n\"Mantenha a racionalidade ou a emoção; você deve fazer uma escolha.\""
  },
  Event_129245_Name = {
    Text = "O preço da humanidade"
  },
  Event_129246_ChoiceDesc1 = {
    Text = "[Destruir Oferta] Obter relíquia amaldiçoada \"(RelicConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_129246_ChoiceDesc2 = {
    Text = "[Desatar as cordas] Escolher 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129246_ChoiceDesc3 = {
    Text = "[Keep Going] Ganhe 50 Sigilos Negros"
  },
  Event_129246_Desc = {
    Text = "Três Arameus estavam amarrados no altar.\nNeles surgiam padrões escuros semelhantes à casca de árvore que você havia visto em um bebê, murmurando palavras"
  },
  Event_129246_Name = {
    Text = "três oferendas"
  },
  Event_129247_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129247_Name = {
    Text = "Capítulo 3 das Estrelas@"
  },
  Event_129248_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129248_Name = {
    Text = "Esquecimento Capítulo 6@"
  },
  Event_129249_ChoiceDesc1 = {
    Text = "[Struggle Forward] Deletar 1 cartão de comando, ganhar Arg1 Sigilo Negro"
  },
  Event_129249_ChoiceDesc2 = {
    Text = "[Cortar o fio] Copiar 1 carta de comando, Infectar[(Skill.Arg1)]"
  },
  Event_129249_ChoiceDesc3 = {
    Text = "[Conter-se] Escolher 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129249_Desc = {
    Text = "Você é empurrado para frente ao longo do caminho, todas as suas escolhas são manipuladas por fios invisíveis.\nVocê se esforça para mover as mãos, tentando agarrar tudo o que lhe importa.\nO destino do mundo está pendurado na ponta dos seus dedos.\nIncontáveis fios se entrelaçam, restringindo todo o seu corpo."
  },
  Event_129249_Name = {
    Text = "Mãos Manipuladas"
  },
  Event_129250_ChoiceDesc1 = {
    Text = "[Pedir Direções] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infectar \"(Skill.Arg2)\" duas vezes"
  },
  Event_129250_ChoiceDesc2 = {
    Text = "[Afastar-se dele] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_129250_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_129250_Desc = {
    Text = "A sombra está embaixo de um poste de luz magro. \n \"Posso pegar um fogo emprestado, senhor?\" \n Você não tem o hábito de @2, mas não se importa em usar um pouco de \"magia\". \n Com sua ajuda, a sombra coloca a @2 acesa dentro do vórtice negro sem fundo. \n Não demora muito e você vê fumaça branca se elevando. \n \"Ah—\" \n A sombra solta um suspiro de prazer."
  },
  Event_129250_Name = {
    Text = "A sombra sob o poste de luz"
  },
  Event_129251_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129251_Name = {
    Text = "Esquecimento Capítulo 1@"
  },
  Event_129252_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129252_Name = {
    Text = "Esquecimento Capítulo 8@"
  },
  Event_129253_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129253_Name = {
    Text = "Esquecimento Capítulo 3@"
  },
  Event_129254_ChoiceDesc1 = {
    Text = "[Aceitar a Ilusão] 1 Carta de comando aleatória obtém Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infectar \"(Skill.Arg2)\" duas vezes"
  },
  Event_129254_ChoiceDesc2 = {
    Text = "[Negar a Ilusão] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129254_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_129254_Desc = {
    Text = "Sob a pesada escuridão da ponte de ferro, na silenciosa margem do rio coberta de juncos, de repente, uma borboleta brilhante voa. \n A borboleta pousa levemente na sua palma, o terrível grito cessa, sendo substituído pelo rugido do trem passando sobre a estrutura de aço enferrujada, o estalo do carvão queimando e o atrito metálico dos eixos girando..."
  },
  Event_129254_Name = {
    Text = "Ilusão Ferroviária"
  },
  Event_129255_ChoiceDesc1 = {
    Text = "[Choose to refuse] Delete 1 Carta de comando, ganhe Arg1 O sigilo negro"
  },
  Event_129255_ChoiceDesc2 = {
    Text = "[Choose to comply] Copie 1 Carta de Comando, infecte '(Skill.Arg1)'"
  },
  Event_129255_ChoiceDesc3 = {
    Text = "[Escolher abraçar] Escolha 1 entre 3 Cartas de comando para receber Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129255_Desc = {
    Text = "\"Eu sou um pássaro em uma jaula, preso em um pátio cheio de muitos quartos.\"\nSombras difusas vagueiam na escuridão, são as obsessões deixadas pelos que partiram.\n\"Dizem que é um manicômio, mas eu sei que é uma jaula especial da humanidade, que aprisiona os pássaros livres que não querem seguir as regras sociais.\"\n\"Mas se o pássaro não pode voar, ainda pode ser chamado de pássaro?\"\nAs obsessões se aproximam de você, suplicando por redenção.\n\"Por favor, quebre minhas asas, estou cansado de voar.\""
  },
  Event_129255_Name = {
    Text = "Homem vazio"
  },
  Event_129256_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129256_Name = {
    Text = "Esquecimento Capítulo dois@"
  },
  Event_129257_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129257_Name = {
    Text = "Estrelas Capítulo 2@"
  },
  Event_129258_ChoiceDesc1 = {
    Text = "[Soltar a borboleta] Escolher 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\" duas vezes, mas desenvolver \"(Skill.Arg2)\" duas vezes"
  },
  Event_129258_ChoiceDesc2 = {
    Text = "[Tornar-se uma Borboleta] Ganhar a relíquia de prata \"(RelicConfig.Arg1)\" e infectar \"(Skill.Arg2)\""
  },
  Event_129258_ChoiceDesc3 = {
    Text = "[Swallow Back] Ganhe 25 Sigilos Negros"
  },
  Event_129258_Desc = {
    Text = "Nesta noite, muitas coisas aconteceram. \n Ataque ao cais, navio fantasma, Marchador de mares, Tulu, Murphy, Ramona... tudo girava no vórtice, sendo misturado na aveia do restaurante Misaq às sete da manhã. \n Queria fazer uma pergunta ao Corpo Desperto à minha frente, mas não sabia como começar, como se um espinho estivesse preso na garganta — ou melhor, as borboletas no estômago."
  },
  Event_129258_Name = {
    Text = "Efeito borboleta"
  },
  Event_129259_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129259_Name = {
    Text = "Esquecimento Capítulo 8@"
  },
  Event_129260_ChoiceDesc1 = {
    Text = "[Deixar Permanecer] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infectar \"(Skill.Arg2)\" duas vezes"
  },
  Event_129260_ChoiceDesc2 = {
    Text = "[Waving Away] Obtenha a Relíquia Prata \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_129260_ChoiceDesc3 = {
    Text = "[Welcome the Butterflies] Ganhe 25 sigilos negros"
  },
  Event_129260_Desc = {
    Text = "Vocês vagam pelo sanatório frio, uma borboleta negra, fora de estação, voa até vocês.\nSuas asas estão cobertas de líquido negro, que se solidifica e se desfaz ao vento.\nEla pousa em seu dedo, exausta"
  },
  Event_129260_Name = {
    Text = "Algo que não deveria existir"
  },
  Event_129261_ChoiceDesc1 = {
    Text = "[Reviver o passado] Grave 1 entre 3 Gravuras avançadas duas vezes."
  },
  Event_129261_ChoiceDesc2 = {
    Text = "[Olhar para o Futuro] Ganha Criação de ouro \"(RelicConfig.Arg1)\", mas desenvolve \"(Skill.Arg2)\""
  },
  Event_129261_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_129261_Desc = {
    Text = "Nada no mundo pode permanecer estático.\n Até mesmo o paraíso esculpido pela Deusa Mãe não é exceção.\n Em um momento fugaz, você vislumbra algo através das fendas do tempo e do espaço.\n O passado, o presente e o futuro entrelaçam-se naquela lacuna fissurada, mudando constantemente.\n Esperando pelo seu olhar curioso"
  },
  Event_129261_Name = {
    Text = "Fenda Espacial"
  },
  Event_129262_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129262_Name = {
    Text = "Capítulo 7 do Esquecimento@"
  },
  Event_129263_ChoiceDesc1 = {
    Text = "[Ignorar] Escolha 1 entre 3 Gravuras duas vezes."
  },
  Event_129263_ChoiceDesc2 = {
    Text = "[Tocá-lo] 1 Carta de comando aleatória recebe Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infecta \"(Skill.Arg2)\" duas vezes"
  },
  Event_129263_Desc = {
    Text = "Algo estranho, semelhante a esporas, chama sua atenção.\nAssemelha-se a uma medusa delicada composta de carne, ou aos filamentos nervosos no interior do cérebro que armazenam sinais.\n\"Venha me tocar\", ela o seduz em silêncio, \"eu vou, revelar a você uma memória cruel.\""
  },
  Event_129263_Name = {
    Text = "Memória Profunda"
  },
  Event_129264_ChoiceDesc1 = {
    Text = "[Entregar-se às fantasias] Escolha 1 entre 3 Cartas de comando para receber Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infecta \"(Skill.Arg2)\" duas vezes"
  },
  Event_129264_ChoiceDesc2 = {
    Text = "[Manter a Sanidade] para cada Corpo Desperto com valor de Fúria igual ou superior a 50, ganha 15 Marca Negra"
  },
  Event_129264_ChoiceDesc3 = {
    Text = "[Partir à força] Grave 1 entre 3 Gravuras duas vezes."
  },
  Event_129264_Desc = {
    Text = "Talvez seja a longa batalha que o deixou desorientado, ou talvez seja apenas seu cérebro que traiu seu corpo.\n Uma sensação de falta de peso aparece em sua mente.\n Em um instante, sua mente se transforma repentinamente em um caleidoscópio, brilhantemente colorido, piscando em todas as tonalidades de luz.\n Incontáveis insights, reflexões e fantasias inundam seu cérebro, ocupando cada canto das frestas de sua mente.\n Se isso continuar, seu cérebro em breve irá explodir com esses pensamentos caóticos."
  },
  Event_129264_Name = {
    Text = "Caleidoscópio de pensamento"
  },
  Event_129265_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129265_Name = {
    Text = "Esquecimento Capítulo cinco@"
  },
  Event_129266_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129266_Name = {
    Text = "Esquecimento Capítulo 4@"
  },
  Event_129267_ChoiceDesc1 = {
    Text = "[Listen] Gravar 1 de 3 Gravuras avançadas duas vezes"
  },
  Event_129267_ChoiceDesc2 = {
    Text = "[Gritar] Obtenha a Relíquia de Ouro \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_129267_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_129267_Desc = {
    Text = "Desde que o acidente aconteceu, você não recebeu mais notícias do seu parceiro. \n Incontáveis tentativas de contato foram feitas, como se uma pedra tivesse caído no mar sem eco. \n Quando você já havia perdido as esperanças, o comunicador de repente emitiu um som. \n Você abriu a mala e aproximou o fone de ouvido do seu ouvido. \n \"Guardião do Segredo...\" \n Em um momento de confusão, você ouviu a voz que sempre sentiu falta, como se estivesse ecoando distante através de camadas de vazio."
  },
  Event_129267_Name = {
    Text = "Ecos de Saudade"
  },
  Event_129268_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129268_Name = {
    Text = "Capítulo 1 do Esquecimento@"
  },
  Event_129269_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129269_Name = {
    Text = "Capítulo 1 das Estrelas@"
  },
  Event_129270_ChoiceDesc1 = {
    Text = "[Encare a Fonte do Cão Infernal] Obtenha a Relíquia de Ouro \"(RelicConfig.Arg1)\" e infecte \"(Skill.Arg2)\""
  },
  Event_129270_ChoiceDesc2 = {
    Text = "[Focar no combate] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129270_Desc = {
    Text = "O contorno do cão infernal está mudando.\nSeu corpo se conecta às fendas da parede, revelando ilusões grotescas"
  },
  Event_129270_Name = {
    Text = "vindo do ângulo"
  },
  Event_129271_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129271_Name = {
    Text = "Esquecimento Capítulo 2@"
  },
  Event_129272_ChoiceDesc1 = {
    Text = "[Combine Pages] Obtenha Relíquia de Ouro \"(RelicConfig.Arg1)\", infectado com \"(Skill.Arg2)\""
  },
  Event_129272_ChoiceDesc2 = {
    Text = "[Read] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)] duas vezes"
  },
  Event_129272_ChoiceDesc3 = {
    Text = "[Descartar Isso] Ganhar 50 Sigilos Negros"
  },
  Event_129272_Desc = {
    Text = "Uma página amarelada caiu do capuz dos crentes que iluminam o templo.  \nA página estava repleta de textos estranhos e peculiares, alguns parecendo hieróglifos, outros estranhamente levantados, algumas letras se sobrepondo, apenas poucas legíveis.  \nO título era 《@2 O Nascimento do Filho》"
  },
  Event_129272_Name = {
    Text = "Ordem secreta · Parte inferior"
  },
  Event_129273_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129273_Name = {
    Text = "Esquecimento Capítulo 2@"
  },
  Event_129274_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129274_Name = {
    Text = "Capítulo 2 das Estrelas@"
  },
  Event_129275_ChoiceDesc1 = {
    Text = "[Preparar para a batalha] Escolha 1 entre 3 Cartas de comando para receber Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infecta \"(Skill.Arg2)\" duas vezes"
  },
  Event_129275_ChoiceDesc2 = {
    Text = "[Tentar Desviar] Obtém 25 Marcas Negras"
  },
  Event_129275_Desc = {
    Text = "No Mar Profundo, onde a luz das estrelas cai, os Marchadores de Mares hibernaram por séculos. \n As águas infinitas testemunharam sua loucura, testemunharam sua paciência, e também testemunharam sua devoção mais sincera aos deuses. \n Ninguém pode impedir a grande chegada dos deuses. \n Qualquer que atrapalhe será reduzido a cinzas pela fúria dos Marchadores de Mares."
  },
  Event_129275_Name = {
    Text = "Esperando sob as Estrelas"
  },
  Event_129276_ChoiceDesc1 = {
    Text = "[Play a Few Notes] Ganhe a relíquia de prata \"(RelicConfig.Arg1)\" e inflija \"(Skill.Arg2)\"."
  },
  Event_129276_ChoiceDesc2 = {
    Text = "[Fechar a Tampa] Gravar 1 entre 3 Orações duas vezes."
  },
  Event_129276_Desc = {
    Text = "O piano ao lado da parede está aberto. Tem teclas amareladas e bordas rachadas, mas cada tecla está muito limpa.\nÉ a fonte de alegria de muitas pessoas"
  },
  Event_129276_Name = {
    Text = "Melodia da Infância"
  },
  Event_129277_ChoiceDesc1 = {
    Text = "[Aceitar a Ilusão] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infectar \"(Skill.Arg2)\" duas vezes"
  },
  Event_129277_ChoiceDesc2 = {
    Text = "[Negar Fantasma] Obter uma relíquia de prata \"(RelicConfig.Arg1)\" e infectar \"(Skill.Arg2)\"."
  },
  Event_129277_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_129277_Desc = {
    Text = "Sob a pesada escuridão da ponte de ferro, na silenciosa margem do rio coberta de juncos, de repente, uma borboleta brilhante voa. \n A borboleta pousa levemente na sua palma, o terrível grito cessa, sendo substituído pelo canto organizado dos trabalhadores carregando vergalhões, o som do martelo de pregos e o tilintar metálico dos rebites..."
  },
  Event_129277_Name = {
    Text = "Ilusão da Ponte de Aço"
  },
  Event_129278_ChoiceDesc1 = {
    Text = "[Mostrar a Maldição] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\" duas vezes, infectar \"(Skill.Arg2)\" duas vezes"
  },
  Event_129278_ChoiceDesc2 = {
    Text = "[Recusar o corvo] Gravar 1 de 3 Gravuras duas vezes"
  },
  Event_129278_ChoiceDesc3 = {Text = "[Ignorar]"},
  Event_129278_Desc = {
    Text = "Uma ave de corvo multicefálica, negra e doentia, sai da túnica de um crente da Luz do Templo e pousa em seu ombro.\n\"Você vê minha cabeça? Enquanto eu provar a maldição, crescendo uma nova cabeça. Deixe-me ver, sua maldição!\""
  },
  Event_129278_Name = {
    Text = "Corvo Amaldiçoado"
  },
  Event_129279_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129279_Name = {
    Text = "Capítulo 7 do Esquecimento@"
  },
  Event_129280_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129280_Name = {
    Text = "Esquecimento Capítulo 3@"
  },
  Event_129281_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129281_Name = {
    Text = "Esquecimento Capítulo quatro@"
  },
  Event_129282_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129282_Name = {
    Text = "Esquecimento Capítulo 2@"
  },
  Event_129283_ChoiceDesc1 = {
    Text = "[Placeholder]Texto temporário."
  },
  Event_129283_Name = {
    Text = "Capítulo 2 das Estrelas@"
  },
  Event_129900_ChoiceDesc1 = {
    Text = "[Enterro] Restaure a Vida Arg2[ExDesc1], selecione e exclua 1 Carta de comando."
  },
  Event_129900_ChoiceDesc2 = {
    Text = "[Pray] Obtenha a Criação de ouro \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_129900_Desc = {
    Text = "Um pedaço de ossada pálida, metade submersa no lodo negro."
  },
  Event_129900_Name = {
    Text = "Ossos Desbotados"
  },
  Event_130337_ChoiceDesc1 = {
    Text = "[Tome Seu Assento] Embaralhar [marionete] em seu baralho."
  },
  Event_130337_Desc = {
    Text = "No momento em que você pisa nos degraus do teatro, seu olhar nunca mais poderá se desviar deste palco.\nOs fios do destino atraem incontáveis histórias para seu fluxo turbilhante aqui—a poeira do passado, a luz tremeluzente do presente e as brumas do futuro, tudo se agita incessantemente pelo palco.\nVocê esqueceu tanto sua origem quanto seu destino. Todo vestígio do \"Eu\" se dissolve nas sombras das pesadas cortinas. Nesta hora, você é o espectador silencioso na plateia e o ator ardente sobre as tábuas.\nA totalidade de sua existência se reduz a dois traços singulares: contemplar e atuar."
  },
  Event_130337_Name = {
    Text = "Palco do Destino"
  },
  Event_131264_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131264_Desc = {
    Text = "Você escolhe o poder. Você escolhe a convicção inabalável e a coragem de seguir sempre em frente.\nPorém, o preço... O próprio propósito de um preço é ser pago, não é?"
  },
  Event_131264_Name = {
    Text = "Olhando para o Passado"
  },
  Event_131265_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131265_Desc = {
    Text = "Suportando a agonia em sua mente, você agarra firmemente os fragmentos afiados à deriva. Através de sua perseverança sombria, as fendas começam a se reparar.\nVocê parte para lembrar, e luta para lembrar. Você não deixará nenhuma memória escapar."
  },
  Event_131265_Name = {
    Text = "Memórias Fragmentadas"
  },
  Event_131266_ChoiceDesc1 = {
    Text = "[Proteger a Memória] Gravar 1 de 3 Gravuras"
  },
  Event_131266_ChoiceDesc2 = {
    Text = "[Selar a Fenda] Gravar a Gravura \"(EnchantConfig.Arg1)\" em 1 de 3 Cartas de comando, mas desenvolver \"(Skill.Arg2)\""
  },
  Event_131266_Desc = {
    Text = "Você nunca duvidou de suas memórias. Elas eram calorosas, resilientes—seu porto mais seguro e seu tesouro mais precioso.\nMas agora, sob a interferência do Abismo Espiral, essas memórias começam a rachar e se estilhaçar."
  },
  Event_131266_Name = {
    Text = "Memórias Fragmentadas"
  },
  Event_131267_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131267_Desc = {
    Text = "Uma onda de energia espiritual inunda sua mente, costurando as terríveis fissuras. Com cada gota de vontade, você restaura as fraturas à integridade.\nVocê parte para lembrar, e luta para lembrar. Você não deixará nenhuma memória escapar."
  },
  Event_131267_Name = {
    Text = "Memórias Fragmentadas"
  },
  Event_131268_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131268_Desc = {
    Text = "\"Ooh... Hahahha!!\"\nNinguém entende sua pergunta. Respondem com choro e risadas estridentes."
  },
  Event_131268_Name = {
    Text = "Os Abandonados"
  },
  Event_131269_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131269_Desc = {
    Text = "Você olha de volta para elas. Fios se agitam; seu olhar gentil atrai as memórias para perto, envolvendo-as em um abraço.\nVocê observa a titereiro do destino em silêncio. Se tivesse outra chance, que escolha ela faria?"
  },
  Event_131269_Name = {
    Text = "Olhando para o Passado"
  },
  Event_131270_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131270_Desc = {
    Text = "\"Ooh... Hahahha!!\"\nOs gritos e risadas se dissipam, dissolvendo-se no ar. Nenhuma alma se levanta para feri-lo—há muito aprenderam a conviver com a invisibilidade."
  },
  Event_131270_Name = {
    Text = "Os Abandonados"
  },
  Event_131271_ChoiceDesc1 = {
    Text = "[Olhar para a Memória] Adquirir a Criação de ouro \"(RelicConfig.Arg1)\", mas desenvolver \"(Skill.Arg2)\""
  },
  Event_131271_ChoiceDesc2 = {
    Text = "[Abandonar a Memória] Despertar do Conhecimento Espiritual de 2 Corpos Despertos aleatórios, mas desenvolver [(Skill.Arg1)] duas vezes"
  },
  Event_131271_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_131271_Desc = {
    Text = "Dentro do receptáculo da garota, o som de porcelana se estilhaçando ecoa. Memórias se libertam de seus recipientes, flutuando em sua direção.\nCompanheiros de infância, presentes dos pais, o puro capricho das nuvens e dos pássaros, ideais tão puros quanto o céu aberto... Todas as memórias abrem seus olhos, fitando você em silêncio.\nElas questionam. Elas choram. Elas esperam."
  },
  Event_131271_Name = {
    Text = "Olhando para o Passado"
  },
  Event_131272_ChoiceDesc1 = {
    Text = "[Perguntar] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_131272_ChoiceDesc2 = {
    Text = "[Ignorar] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_131272_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_131272_Desc = {
    Text = "Lamentos penetrantes arranham seus ouvidos; diante de você, espíritos agonizantes rasgam seus próprios rostos e formas...\nQuem são eles? Prisioneiros do Abismo Espiral? Destinos descartados? Os ecos do passado, talvez?"
  },
  Event_131272_Name = {
    Text = "Os Abandonados"
  },
  Event_133380_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_133380_Desc = {
    Text = "Você se acomodou em seu assento de veludo, e as cortinas carmesim se abrem em um sussurro silencioso.\nCaro espectador, o palco se erguerá para atender a todas as suas expectativas.\nO protagonista desta peça já tomou sua posição."
  },
  Event_133380_Name = {
    Text = "Palco do Destino"
  },
  Event_141995_ChoiceDesc1 = {
    Text = "[Tentativa Simples] Remover até 5 Cartas quaisquer"
  },
  Event_141995_ChoiceDesc2 = {
    Text = "[Deixá-lo Pesquisar] Remover aleatoriamente 5 Cartas de comando e obter a Criação Bendita [(RelicConfig.Arg1)]."
  },
  Event_141995_ChoiceDesc3 = {
    Text = "[Pensamento Inverso?] Escolher até dois Corpos Despertos e gerar um conjunto completo de suas Cartas básicas para inserir no baralho"
  },
  Event_141995_Desc = {
    Text = "Você chega a uma praça movimentada, onde muitas pessoas passam apressadas — talvez haja algo interessante aqui.\nVocê bate à porta de um quarto iluminado por uma luz amarelada e fraca, e uma pessoa com aparência de pesquisador espia pela abertura. Você avista vários instrumentos científicos desconhecidos; ele o puxa para sentar e afirma ser um \"Evolucionista\". Com o rosto cheio de Fervor, ele recomenda insistentemente seus \"métodos científicos\".\n\"Somente ao eliminar o excesso entediante da humanidade é que se alcança o verdadeiro Caminho da evolução!\""
  },
  Event_141995_Name = {
    Text = "Evolucionista"
  },
  Event_141996_ChoiceDesc1 = {
    Text = "[Treinar com foco no ataque] Adiciona uma Gravura aleatória a todos os Golpes Básicos que não possuem Gravura"
  },
  Event_141996_ChoiceDesc2 = {
    Text = "[Treinar com foco na defesa] Adiciona uma Gravura aleatória a todas as Defesas Básicas que não possuem Gravura"
  },
  Event_141996_ChoiceDesc3 = {
    Text = "[Treinar sem limites] Adiciona uma Gravura aleatória a 15 Cartas de comando aleatórias e obtém 5 Cartões de sintomas aleatórios"
  },
  Event_141996_Desc = {
    Text = "Você chega a uma praça movimentada, onde muitas pessoas passam apressadas — talvez haja algo interessante aqui.\nO tilintar de metal ressoa pelo espaço aberto enquanto algumas pessoas se desafiam mutuamente, aprimorando suas habilidades marciais. Um jovem vestindo uma armadura antiga nota sua presença e lança uma espada em sua direção, convidando você a treinar junto com eles."
  },
  Event_141996_Name = {
    Text = "Hora do Treinamento Especial"
  },
  Event_141997_ChoiceDesc1 = {
    Text = "[Apostar no Grande] 50% de chance de obter uma Gravura aleatória e apostar novamente, 50% de chance de obter 75 Marca Negra"
  },
  Event_141997_ChoiceDesc2 = {
    Text = "[Apostar no Pequeno] 50% de chance de obter uma Gravura aleatória e apostar novamente, 50% de chance de obter 75 Marca Negra"
  },
  Event_141997_Desc = {
    Text = "O garçom mantém seu sorriso imutável, levanta o copo de dados, e um som cristalino ressoa enquanto os outros jogadores fazem suas escolhas. \"Apostas encerradas\", ele diz, \"por favor, aposte —\""
  },
  Event_141997_Name = {
    Text = "Cassino Barulhento"
  },
  Event_141998_ChoiceDesc1 = {
    Text = "[Apostar com Honestidade] Delete uma Carta de comando"
  },
  Event_141998_ChoiceDesc2 = {
    Text = "[Tentar Trapacear] Delete um Cartão de sintomas"
  },
  Event_141998_ChoiceDesc3 = {Text = "[Leave]"},
  Event_141998_Desc = {
    Text = "Você chega a um lugar extremamente animado, onde todos os rostos transbordam felicidade, e as luzes coloridas que piscam livremente empurram a noite para longe. Por toda parte, placas anunciam: \"Bem-vindo ao Carnaval! Aqui os Sonhos nunca têm Fim, aqui a Alegria jamais chega ao Fim!\"\nArrastado pela multidão comprimida, você é empurrado para dentro de um edifício suntuoso. O salão é dourado e resplandecente, repleto de vozes, e o ar está impregnado com o doce aroma do vinho. Um dado rola até seus pés, e um garçom com um sorriso lisonjeiro lhe diz que isso é um símbolo de boa sorte. Tomado pela curiosidade, você dá um passo à frente — talvez possa se destacar neste jogo."
  },
  Event_141998_Name = {
    Text = "Cassino Barulhento"
  },
  Event_141999_ChoiceDesc1 = {
    Text = "[Troca] Remover 1 Criação, 50% de Probabilidade de obter 1 entre 3 Criações de ouro, 50% de Probabilidade de obter 25 Marca Negra"
  },
  Event_141999_ChoiceDesc2 = {Text = "[Leave]"},
  Event_141999_Desc = {
    Text = "Você chega a um lugar extremamente animado, onde todos têm rostos radiantes de felicidade, e as luzes coloridas que piscam livremente empurram a noite para longe. Por toda parte, placas visíveis dizem: \"Bem-vindo ao Carnaval! Aqui os Sonhos nunca têm Fim, aqui a Alegria jamais chega ao Fim!\"\nNo meio da multidão, um Mercador com roupas esfarrapadas, mas carregando um fardo surpreendentemente grande, acena para você. Ele bate no pacote ao seu lado, se aproxima e baixa a voz, fazendo-lhe um Convite de Troca. A velha bolsa de pano balança suavemente enquanto ele fala, emitindo de vez em quando um barulho de crepitação."
  },
  Event_141999_Name = {
    Text = "Vendedor itinerante Esfarrapado"
  },
  Event_142000_ChoiceDesc1 = {
    Text = "[Fazer um desejo] Consome 50% da Vida atual, obtém 2 Criações de ouro aleatórias"
  },
  Event_142000_ChoiceDesc2 = {
    Text = "[Desejar com toda a alma] Consome 99% da Vida atual, obtém o Pêndulo Temporal [(RelicConfig.Arg2)]"
  },
  Event_142000_ChoiceDesc3 = {
    Text = "[Mergulhar a mão no fundo da fonte] Obtém a Criação de ouro [(RelicConfig.Arg1)]"
  },
  Event_142000_Desc = {
    Text = "O vento sopra pelos campos, e há um silêncio absoluto ao redor, com apenas o farfalhar das árvores.\nDe repente, você ouve o som de algo fluindo suavemente. Seguindo o som, um cheiro forte e adocicado de Sangue chega primeiro, e você finalmente consegue ver a origem do barulho — é uma fonte de desejos, repleta de vermelho, onde o Sangue de inúmeras pessoas Surge no interior da fonte, Como Se algo sob a superfície líquida estivesse prestes a emergir.\nUma voz ecoa no fundo do seu coração: \"Ofereça seu Sangue, e eu lhe concederei uma bênção.\""
  },
  Event_142000_Name = {
    Text = "Fonte de Sangue"
  },
  Event_142001_ChoiceDesc1 = {
    Text = "[Oferecer Manutenção simples] Escolha deletar 2 Criações, obter a Criação Culpada [(RelicConfig.Arg1)]"
  },
  Event_142001_ChoiceDesc2 = {
    Text = "[Oferecer Manutenção com Devoção] Escolha deletar 4 Criações, obter a Criação Bendita [(RelicConfig.Arg1)]"
  },
  Event_142001_ChoiceDesc3 = {
    Text = "[Pegar um pouco das oferendas, ninguém vai saber] Obter a Criação de ouro [(RelicConfig.Arg1)]"
  },
  Event_142001_Desc = {
    Text = "O vento sopra pelos campos, e há um silêncio absoluto ao redor, com apenas o farfalhar das árvores.\nSem perceber, você chega diante de um antigo altar, onde uma enorme estátua O contempla de cima, como se quisesse tomar algo de suas mãos. Você vê gravadas na base do altar palavras desgastadas — \"Ganho e perda em equilíbrio\"."
  },
  Event_142001_Name = {
    Text = "Altar do Ganho e da Perda"
  },
  Event_142002_ChoiceDesc1 = {
    Text = "[Experiência Gratuita] Melhoria aleatória de Arg2 Criação(ões) de prata"
  },
  Event_142002_ChoiceDesc2 = {
    Text = "[Serviço Comum] Gastar Arg1 Marca(s) Negra(s): Melhoria aleatória de Arg2 Criação(ões) de prata"
  },
  Event_142002_ChoiceDesc3 = {
    Text = "[Serviço Luxuoso] Gastar Arg1 Marca(s) Negra(s): Melhoria aleatória de Arg2 Criação(ões) de prata"
  },
  Event_142002_Desc = {
    Text = "Você chega a uma praça movimentada, onde muitas pessoas passam apressadas — talvez haja algo interessante aqui.\nUm pequeno edifício iluminado por uma luz aconchegante está erguido silenciosamente em um canto da praça. Parece ser um clube Avançado, mas a placa escura pendurada na parede diz claramente: \"Este estabelecimento serve apenas a existências que não sejam seres biológicos.\""
  },
  Event_142002_Name = {
    Text = "Clube Especial"
  },
  Event_142003_ChoiceDesc1 = {
    Text = "[Sortear uma vez] Obtenha um Cartão de sintomas"
  },
  Event_142003_ChoiceDesc2 = {
    Text = "[Sair] Obtenha 75 Marca Negra"
  },
  Event_142003_Desc = {
    Text = "Você chega a um lugar extremamente animado, onde todos os rostos transbordam felicidade, e as luzes coloridas que piscam livremente empurram a noite para longe. Por toda parte, placas anunciam: \"Bem-vindo ao Carnaval! Aqui os Sonhos nunca têm Fim, aqui a Alegria jamais chega ao Fim!\"\nVocê nota uma barraca de sorteio à beira do Caminho, cercada de pessoas. O Olhar de Todos está fixado no grande prêmio, completamente encoberto — o Vendedor ambulante exalta sua raridade com entusiasmo, e as pessoas disputam para participar."
  },
  Event_142003_Name = {
    Text = "Desafio de Sorteio"
  },
  Event_142004_ChoiceDesc1 = {
    Text = "[Usar por um momento]"
  },
  Event_142004_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142004_Desc = {
    Text = "O vento sopra pelos campos, e um silêncio absoluto paira ao redor, quebrado apenas pelo farfalhar das árvores.\nDe repente, você avista um galpão de palha em ruínas, com uma bigorna bem no centro e várias armas de metal enferrujadas ao lado — parece ser uma ferraria abandonada há muito tempo. Ao lado da bigorna há instruções detalhadas de uso, informando que você pode colocar Criações aqui para modificá-las."
  },
  Event_142004_Name = {Text = "Ferraria"},
  Event_142005_ChoiceDesc1 = {
    Text = "[Apostar com Honestidade] Delete uma Carta de comando"
  },
  Event_142005_ChoiceDesc2 = {
    Text = "[Tentar Trapacear] Delete um Cartão de sintomas"
  },
  Event_142005_ChoiceDesc3 = {Text = "[Leave]"},
  Event_142005_Desc = {
    Text = "Os Aplausos dos outros anunciam sua vitória. Em meio ao burburinho, você finalmente se junta a eles, embriagado por este Sonho extravagante onde tudo está em jogo. Você olha para as fichas em suas mãos, Como Se fossem os companheiros mais leais a lhe trazer glória. Um Sussurro emerge das profundezas da mesa de Aposta, carregando um pedido ambíguo: \"faça de novo, vença mais uma vez.\""
  },
  Event_142005_Name = {
    Text = "Cassino Barulhento"
  },
  Event_142013_ChoiceDesc1 = {
    Text = "[Apostar no Grande] 50% de chance de obter uma Criação de prata aleatória e apostar novamente, 50% de chance de obter 75 Marca Negra e entrar em combate Elite"
  },
  Event_142013_ChoiceDesc2 = {
    Text = "[Apostar no Pequeno] 50% de chance de obter uma Criação de prata aleatória e apostar novamente, 50% de chance de obter 75 Marca Negra e entrar em combate Elite"
  },
  Event_142013_Desc = {
    Text = "O garçom mantém seu sorriso imutável, levanta o copo de dados, e um som cristalino ressoa enquanto os outros jogadores fazem suas escolhas. \"Apostas encerradas\", ele diz, \"por favor, aposte —\""
  },
  Event_142013_Name = {
    Text = "Cassino Barulhento"
  },
  Event_142073_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142073_Desc = {
    Text = "O garçom levanta o copo de dados e, em poucos segundos, o ar parece entrar em Stase. No momento em que a resposta é revelada, você ouve gritos de alegria e lamentos misturados. A sorte não lhe concedeu sua Benção — os dados que repousam silenciosamente sobre a mesa deram uma resposta contrária à sua. Você faz uma última varredura com o olhar, observando aqueles apostadores em Loucura. É hora de ir."
  },
  Event_142073_Name = {
    Text = "Cassino Barulhento"
  },
  Event_142074_ChoiceDesc1 = {
    Text = "[Entrar na Batalha]"
  },
  Event_142074_Desc = {
    Text = "Enquanto você fitava a mesa de jogo com grande expectativa, sua mão foi subitamente agarrada com firmeza. Ao olhar para cima, o Chefe do cassino o encarava de cima, pronto para expulsar qualquer cliente que não seguisse as regras. Em um instante, todos os olhares se voltaram para você — surpresos, hostis, schadenfreude... Você percebeu que alguém pode trapacear muitas vezes, mas Desde Que seja descoberto uma única vez, a ruína total será inevitável."
  },
  Event_142074_Name = {
    Text = "Cassino Barulhento"
  },
  Event_142103_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142103_Desc = {
    Text = "Você conseguiu escapar do cassino por meios físicos, deixando o barulho da multidão para trás enquanto acelerava o passo — quanto à bagunça deixada, alguém certamente irá arrumá-la."
  },
  Event_142103_Name = {
    Text = "Cassino Barulhento"
  },
  Event_142105_ChoiceDesc1 = {
    Text = "[Sortear novamente] Obter um Cartão de sintomas"
  },
  Event_142105_ChoiceDesc2 = {
    Text = "[Sair] Obtenha 75 Marca Negra"
  },
  Event_142105_Desc = {
    Text = "Você tentou sortear uma vez — nada aconteceu. Mas no verso do cartão está escrito: \"Da próxima vez será mais fácil\"\n......Quer tentar de novo?"
  },
  Event_142105_Name = {
    Text = "Desafio de Sorteio"
  },
  Event_142106_ChoiceDesc1 = {
    Text = "[Sortear novamente] Obter um Cartão de sintomas"
  },
  Event_142106_ChoiceDesc2 = {
    Text = "[Sair] Obtenha 75 Marca Negra"
  },
  Event_142106_Desc = {
    Text = "Você tentou sortear uma vez — nada aconteceu. Mas no verso do cartão está escrito: \"Da próxima vez será mais fácil\"\n......Quer tentar de novo?"
  },
  Event_142106_Name = {
    Text = "Desafio de Sorteio"
  },
  Event_142107_ChoiceDesc1 = {
    Text = "[Sortear novamente] Obter um Cartão de sintomas"
  },
  Event_142107_Desc = {
    Text = "Você tentou sortear uma vez — nada aconteceu. Mas no verso do cartão está escrito: \"Da próxima vez será mais fácil\"\n......Quer tentar de novo?"
  },
  Event_142107_Name = {
    Text = "Desafio de Sorteio"
  },
  Event_142108_ChoiceDesc1 = {
    Text = "[Sortear novamente] Obter um Cartão de sintomas"
  },
  Event_142108_ChoiceDesc2 = {
    Text = "[Sair] Obtenha 75 Marca Negra"
  },
  Event_142108_Desc = {
    Text = "Você tentou sortear uma vez — nada aconteceu. Mas no verso do cartão está escrito: \"Da próxima vez será mais fácil\"\n......Quer tentar de novo?"
  },
  Event_142108_Name = {
    Text = "Desafio de Sorteio"
  },
  Event_142109_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142109_Desc = {
    Text = "Ouvindo o som do coração, você revelou o bilhete da sorte, e letras douradas deslumbrantes saltaram para seus Olhos. O Vendedor ambulante agitou o sino com Empolgação, e todos os transeuntes lançaram sobre você O Olhar de inveja.\n\"O grande prêmio foi sorteado!\""
  },
  Event_142109_Name = {
    Text = "Desafio de Sorteio"
  },
  Event_142110_ChoiceDesc1 = {
    Text = "[Sortear novamente] Obter um Cartão de sintomas"
  },
  Event_142110_ChoiceDesc2 = {
    Text = "[Sair] Obtenha 75 Marca Negra"
  },
  Event_142110_Desc = {
    Text = "Você tentou sortear uma vez — nada aconteceu. Mas no verso do cartão está escrito: \"Da próxima vez será mais fácil\"\n......Quer tentar de novo?"
  },
  Event_142110_Name = {
    Text = "Desafio de Sorteio"
  },
  Event_142118_ChoiceDesc1 = {
    Text = "[Troca] Remover 1 Criação, 25% de Probabilidade de obter 1 entre 3 Pêndulos Temporais, 50% de Probabilidade de obter 2 Criações de ouro aleatórias, 25% de Probabilidade de obter 25 Marca Negra"
  },
  Event_142118_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142118_Desc = {
    Text = "O Mercador pegou o item que você entregou e ficou examinando-o à luz da lua, de um lado para o outro, com os Olhos quase saltando das órbitas. Você esperou por um longo tempo até que ele finalmente abriu um sorriso e tirou da bolsa uma caixa de ferro enferrujada. \"Vamos abrir e ver, esta é a caixa surpresa mais popular da moda.\"\nVocê a abriu, mas descobriu que Dentro havia apenas algumas Marcas Negras nada satisfatórias. O Mercador esfregou as mãos, com um olhar cheio de desculpas, dizendo que você poderia tentar mais uma vez."
  },
  Event_142118_Name = {
    Text = "Vendedor itinerante Esfarrapado"
  },
  Event_142119_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142119_Desc = {
    Text = "O Mercador pegou o item que você entregou e ficou examinando-o à luz da lua, de um lado para o outro, com os Olhos quase saltando das órbitas. Você esperou por um longo tempo até que ele finalmente abriu um sorriso e tirou da bolsa uma caixa de ferro enferrujada. \"Vamos abrir e ver, esta é a caixa surpresa mais popular da moda.\"\nVocê a abriu, e dentro havia algo."
  },
  Event_142119_Name = {
    Text = "Vendedor itinerante Esfarrapado"
  },
  Event_142120_ChoiceDesc1 = {
    Text = "[Troca] Remover 1 Criação de ouro, 50% de Probabilidade de obter 1 entre 3 Pêndulos Temporais, 50% de Probabilidade de obter 1 entre 3 Criações Benditas"
  },
  Event_142120_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142120_Desc = {
    Text = "Você abre a caixa surpresa novamente, mas descobre que ainda não há o item que deseja. O Mercador apressa-se a sorrir desculpando-se, e tira mais uma caixa de ferro, segurando-a com ambas as mãos e estendendo-a a você.\n\"Não fique com raiva, cliente! Juro que desta vez haverá algo extraordinário...\" disse ele, enquanto discretamente estendia uma mão aberta em sua direção, \"Claro, um tesouro deve ser trocado por outro tesouro.\""
  },
  Event_142120_Name = {
    Text = "Vendedor itinerante Esfarrapado"
  },
  Event_142138_ChoiceDesc1 = {
    Text = "[Usar por um momento]"
  },
  Event_142138_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142138_Desc = {
    Text = "Você usou as ferramentas com sucesso. Embora tenham sofrido algum desgaste, ainda parecem utilizáveis."
  },
  Event_142138_Name = {Text = "Ferraria"},
  Event_142139_ChoiceDesc1 = {
    Text = "[Fragmentar e Fundir] Escolha 1 Criação de ouro para deletar, obtém 2 Criações de prata e 50 Marcas Negras"
  },
  Event_142139_ChoiceDesc2 = {
    Text = "[Temperar] Escolha 2 Criações para deletar, obtém a Criação de ouro [(RelicConfig.Arg1)]."
  },
  Event_142139_ChoiceDesc3 = {
    Text = "[Temperar Avançado] Escolha 2 Criações de ouro para deletar, obtém o Pêndulo Temporal [(RelicConfig.Arg1)]."
  },
  Event_142139_Desc = {
    Text = "Você pegou o martelo ao lado e planejou..."
  },
  Event_142139_Name = {Text = "Ferraria"},
  Event_142140_ChoiceDesc1 = {
    Text = "[Usar por um momento]"
  },
  Event_142140_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142140_Desc = {
    Text = "Você usou as ferramentas com sucesso. Embora tenham sofrido algum desgaste, ainda parecem utilizáveis."
  },
  Event_142140_Name = {Text = "Ferraria"},
  Event_142141_ChoiceDesc1 = {
    Text = "[Fragmentar e Fundir] Escolha 1 Criação de ouro para deletar, obtém 2 Criações de prata e 50 Marcas Negras"
  },
  Event_142141_ChoiceDesc2 = {
    Text = "[Temperar] Escolha 2 Criações para deletar, obtém a Criação de ouro [(RelicConfig.Arg1)]."
  },
  Event_142141_ChoiceDesc3 = {
    Text = "[Temperar Avançado] Escolha 2 Criações de ouro para deletar, obtém o Pêndulo Temporal [(RelicConfig.Arg1)]."
  },
  Event_142141_Desc = {
    Text = "Você pegou o martelo ao lado e planejou..."
  },
  Event_142141_Name = {Text = "Ferraria"},
  Event_142142_ChoiceDesc1 = {
    Text = "[Fragmentar e Fundir] Escolha 1 Criação de ouro para deletar, obtém 2 Criações de prata e 50 Marcas Negras"
  },
  Event_142142_ChoiceDesc2 = {
    Text = "[Temperar] Escolha 2 Criações para deletar, obtém a Criação de ouro [(RelicConfig.Arg1)]."
  },
  Event_142142_ChoiceDesc3 = {
    Text = "[Temperar Avançado] Escolha 2 Criações de ouro para deletar, obtém o Pêndulo Temporal [(RelicConfig.Arg1)]."
  },
  Event_142142_Desc = {
    Text = "Você pegou o martelo ao lado e planejou..."
  },
  Event_142142_Name = {Text = "Ferraria"},
  Event_142167_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142167_Desc = {
    Text = "Após três usos, a bigorna afundou completamente e o martelo está cheio de marcas de desgaste — parece que não podem mais ser usados."
  },
  Event_142167_Name = {Text = "Ferraria"},
  Event_142235_ChoiceDesc1 = {
    Text = "[Vou Seguir em Frente] Obtenha \"Imaculidade\"—todas as Cartas de Comando recebem 20 capas permanentes de Reforço."
  },
  Event_142235_ChoiceDesc2 = {
    Text = "[Não Vou Recuar] Obtenha \"Sublimação\"—a Energia de chave e o Limite de fúria diminuem permanentemente em 20%."
  },
  Event_142235_Desc = {
    Text = "Seus olhos de repente ficam cobertos por uma névoa, o mundo começa a ficar cada vez mais turvo, e em um estado de transe, uma voz ecoa no fundo do seu coração:\n\"Você ainda quer avançar?\""
  },
  Event_142235_Name = {
    Text = "A Estação Final se Aproxima"
  },
  Event_142925_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142925_Desc = {
    Text = "O funcionário do clube aceitou o pagamento e prestou o serviço básico para você. Ele levou os itens que você entregou para um compartimento escuro e, após uma breve espera, quando reapareceu, os itens já estavam de volta na bandeja — pareciam um pouco diferentes de antes."
  },
  Event_142925_Name = {
    Text = "Clube Especial"
  },
  Event_142926_ChoiceDesc1 = {
    Text = "[Remover uma Criação de ouro] (É necessário ter uma Criação de ouro)"
  },
  Event_142926_ChoiceDesc2 = {
    Text = "[Há Criações com Reforço (Forged) disponíveis para seleção]"
  },
  Event_142926_ChoiceDesc3 = {Text = "[Leave]"},
  Event_142926_Desc = {
    Text = "Teste \"Quantidade de Criações\" \"Lista de Seleção de Criações\""
  },
  Event_142927_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142927_Desc = {
    Text = "O funcionário do clube aceitou o pagamento e prestou o serviço luxuoso para você. Ele colocou seus itens solenemente em uma caixa e os levou para um compartimento escuro. Você esperou por um longo tempo, até que ele reapareceu, entregando os itens com as duas mãos, com a expressão tão serena quanto sempre."
  },
  Event_142927_Name = {
    Text = "Clube Especial"
  },
  Event_142928_ChoiceDesc1 = {
    Text = "[Selecionar no máximo 2 Corpos Despertos para encher de Fúria]"
  },
  Event_142928_ChoiceDesc2 = {
    Text = "[É necessário que 2 Corpos Despertos estejam cheios de Fúria]"
  },
  Event_142928_ChoiceDesc3 = {Text = "[Leave]"},
  Event_142928_Desc = {
    Text = "Teste \"Seleção Condicional de Corpo Desperto\""
  },
  Event_142929_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142929_Desc = {
    Text = "O pesquisador circulou ao seu redor várias vezes, observando-o atentamente por um longo tempo antes de começar a trabalhar — sem pedir sua opinião. Algum tempo depois, quando você se preparava para sair daquele estranho laboratório, sabia claramente que havia perdido muito, mas ele bateu palmas para lhe parabenizar: \"Este é o verdadeiro significado da evolução!\""
  },
  Event_142929_Name = {
    Text = "Evolucionista"
  },
  Event_142930_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142930_Desc = {
    Text = "Você estendeu a mão e mergulhou nas águas Carmesim da fonte, tocando algo útil."
  },
  Event_142930_Name = {
    Text = "Fonte de Sangue"
  },
  Event_142931_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142931_Desc = {
    Text = "A voz se afasta, seu coração se enche de determinação, e você sente a Força Emergir."
  },
  Event_142931_Name = {
    Text = "A Estação Final se Aproxima"
  },
  Event_142932_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142932_Desc = {
    Text = "A voz se afasta, seu coração se enche de determinação, e sua mente fica ainda mais clara."
  },
  Event_142932_Name = {
    Text = "A Estação Final se Aproxima"
  },
  Event_142933_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142933_Desc = {
    Text = "Você pegou um pouco da pilha de oferendas amontoadas como uma montanha e saiu rapidamente. Ao partir, os Olhos da estátua pareceram se mover por um instante."
  },
  Event_142933_Name = {
    Text = "Altar do Ganho e da Perda"
  },
  Event_142934_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142934_Desc = {
    Text = "Você treinou com foco na defesa e, diante dos assaltos do oponente, continuou bloqueando com sua arma, aprimorando sua capacidade de Defesa e seus reflexos."
  },
  Event_142934_Name = {
    Text = "Hora do Treinamento Especial"
  },
  Event_142935_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142935_Desc = {
    Text = "O pesquisador calçou luvas, pegou alguns instrumentos de formas estranhas do armário e gesticulou com eles na sua frente. Você não sabe ao certo o que ele fez, mas parece que de fato se sente um pouco mais leve."
  },
  Event_142935_Name = {
    Text = "Evolucionista"
  },
  Event_142936_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142936_Desc = {
    Text = "Você não escolheu uma direção específica, mas treinou com outros ignorando os limites do seu próprio corpo, até que Todos ficassem exaustos. Você sabe que melhorou bastante, mas, da mesma forma, pagou um preço por isso."
  },
  Event_142936_Name = {
    Text = "Hora do Treinamento Especial"
  },
  Event_142937_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142937_Desc = {
    Text = "Você pegou algumas coisas aleatórias da bolsa para oferecer, e recebeu uma recompensa equivalente."
  },
  Event_142937_Name = {
    Text = "Altar do Ganho e da Perda"
  },
  Event_142938_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142938_Desc = {
    Text = "Você ofereceu algumas oferendas preciosas e recebeu uma recompensa equivalente."
  },
  Event_142938_Name = {
    Text = "Altar do Ganho e da Perda"
  },
  Event_142939_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142939_Desc = {
    Text = "Você estava cheio de Dúvidas sobre os métodos de pesquisa dele e, após uma discussão acalorada, ele concordou em deixar você usar os instrumentos por conta própria para buscar a \"evolução\" à sua maneira.\nCom os mesmos instrumentos, você acabou, por acidente, fazendo com que as coisas que deveriam ser \"eliminadas\" se \"multiplicassem\" em grande quantidade. Ao sair, você ouviu o lamento do pesquisador."
  },
  Event_142939_Name = {
    Text = "Evolucionista"
  },
  Event_142940_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142940_Desc = {
    Text = "O funcionário do clube prestou o serviço gratuito para você. Ele levou os itens que você entregou para um compartimento escuro e, momentos depois, retornou, colocando-os de volta em suas mãos sem dizer uma palavra."
  },
  Event_142940_Name = {
    Text = "Clube Especial"
  },
  Event_142941_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142941_Desc = {
    Text = "Você ofereceu uma grande quantidade de Sangue à fonte dos desejos, e um presente precioso emergiu de suas águas."
  },
  Event_142941_Name = {
    Text = "Fonte de Sangue"
  },
  Event_142942_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142942_Desc = {
    Text = "Você treinou com foco no ataque e, nos choques de aço, suas habilidades de golpear e velocidade melhoraram."
  },
  Event_142942_Name = {
    Text = "Hora do Treinamento Especial"
  },
  Event_142943_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142943_Desc = {
    Text = "Você ofereceu um pouco de Sangue à fonte dos desejos, e um presente emergiu de suas águas."
  },
  Event_142943_Name = {
    Text = "Fonte de Sangue"
  },
  Event_142944_ChoiceDesc1 = {
    Text = "[Escolher Melhoria de Criação]"
  },
  Event_142944_ChoiceDesc2 = {
    Text = "[Melhoria de Criação Aleatória]"
  },
  Event_142944_ChoiceDesc3 = {
    Text = "[Sair (Teste)]"
  },
  Event_142944_Desc = {
    Text = "Teste \"Função de Melhoria de Criação\", a Criação se adiciona sozinha"
  },
  Event_146258_ChoiceDesc1 = {
    Text = "[Chamá-lo] Ganhar Criatura amaldiçoada \"(RelicConfig.Arg1)\", Infectar \"(Skill.Arg2)\""
  },
  Event_146258_ChoiceDesc2 = {
    Text = "[Responder a Eles] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_146258_ChoiceDesc3 = {
    Text = "[Ignorar] Ganhe 50 Marca Negra"
  },
  Event_146258_Desc = {
    Text = "Sobre o altar, as vestes brancas de Juliette são banhadas em fumaça densa, a cinza do incenso misturada a um aroma adocicado e cúpreo.\n\n\"A Portadora da Luz tem piedade dos filhos pecadores deste mundo...\" sua voz não é alta, mas corta claramente os murmúrios das orações no templo, \"...assim como uma mãe amorosa tem piedade do bebê em seus braços.\"\n\nÀ luz das velas, as oferendas no altar reluzem engorduradas. Fios de fumaça azul se retorcem para cima ao longo de seus contornos, desfocando os rostos da multidão abaixo.\n\nAtravés daquela névoa oscilante, você olha em direção a Pollux. Ele está entre os fiéis, olhos baixos, seu rosto exibindo uma piedade submissa perfeitamente ensaiada."
  },
  Event_146258_Name = {
    Text = "Um Sonho Antigo: III"
  },
  Event_146259_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146259_Desc = {
    Text = "Não ligue para isso. É apenas o uivo do vento nevado, o suspiro do lago congelado, ou o lamento dos picos.\n\nSão os galhos secos e mortos sussurrando ao se roçarem.\n\nEles murmuram em um luto eterno e melancólico por cada pioneiro que já morreu nas fendas geladas."
  },
  Event_146259_Name = {
    Text = "Ária do Lago Congelado"
  },
  Event_146260_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146260_Desc = {
    Text = "Se justiça significa paridade absoluta, Helot: Catena compartilha do seu direito de fazer um desejo?\n\nSe sim, você deveria simplesmente ignorar o fato de ela ter saído na sua frente e afastado a concorrência?\n\n\"Pare de sonhar acordado e continue subindo!\" A voz de Caraboo ecoa em seu ouvido."
  },
  Event_146260_Name = {
    Text = "Justiça Absurda"
  },
  Event_146261_ChoiceDesc1 = {
    Text = "[A Montanha Teme a Fome]"
  },
  Event_146261_ChoiceDesc2 = {
    Text = "[A Montanha Teme a Perda]"
  },
  Event_146261_ChoiceDesc3 = {
    Text = "[A Montanha Teme a Morte]"
  },
  Event_146261_Desc = {
    Text = "Você caminha sobre o corpo da montanha. Seus estremecimentos traem seus segredos. O que a montanha anseia define o que a montanha teme."
  },
  Event_146261_Name = {
    Text = "Segredo da Montanha"
  },
  Event_146262_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146262_Desc = {
    Text = "Você se perde na seda de sua pelagem, prisioneiro voluntário dos próprios desejos. Acariciar o gato é tão satisfatório. O que importa o que existe sob a pele? Isso realmente importa?"
  },
  Event_146262_Name = {
    Text = "O Gato Negro Rastejante"
  },
  Event_146263_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146263_Desc = {
    Text = "Você silenciosamente pega a ponta do fio e o amarra em seu pulso.\n\nPollux faz o mesmo. Logo, uma fina linha vermelha une os dois.\n\nIsso limita o quanto de terreno vocês podem cobrir, mas vocês sempre foram destinados a viver e morrer juntos, não foram?\n\nVocê deixará o destino cuidar do resto."
  },
  Event_146263_Name = {
    Text = "Um Sonho Antigo: I"
  },
  Event_146264_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146264_Desc = {
    Text = "\"Eu sei que é difícil, criança. Claro que sei. Mas o mundo nunca foi um lugar gentil para nenhum de nós.\"\n\n\"Um dia, a borboleta escapará de sua palma, e se irá para sempre.\""
  },
  Event_146264_Name = {
    Text = "Ilusão, Não Verdade"
  },
  Event_146265_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146265_Desc = {
    Text = "William ergue o olhar, seu olhar roçando por você antes de pousar nas cumeeiras cobertas de neve ao longe.\n\n\"Você não tem nada pelo que se desculpar,\" ele diz em voz baixa, mas com firmeza. \"Algumas questões pertencem somente a mim, e só eu posso respondê-las.\"\n\n\"Mas obrigado. Pelos seus olhos atentos."
  },
  Event_146265_Name = {
    Text = "Submersão Suave"
  },
  Event_146266_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146266_Desc = {
    Text = "Os olhos de William piscam.\n\nVocê abre a boca, mas opta por não dizer nada. O silêncio é a melhor escolha aqui. Ainda existe uma compreensão mútua rara e silenciosa entre os dois; não há necessidade de arruiná-la."
  },
  Event_146266_Name = {
    Text = "Submersão Suave"
  },
  Event_146267_ChoiceDesc1 = {
    Text = "[Sair] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_146267_Desc = {
    Text = "\"Devolva, devolva! Esse é o meu poder!\"\n\nA montanha chora; a montanha lamenta. Ela não suporta ser despojada de tudo que um dia possuiu."
  },
  Event_146267_Name = {
    Text = "Segredo da Montanha"
  },
  Event_146268_ChoiceDesc1 = {
    Text = "[Continuar Correndo] Grave a Gravura \"(EnchantConfig.Arg1)\" em 1 de 3 Cartas de comando, mas desenvolva \"(Skill.Arg2)\""
  },
  Event_146268_ChoiceDesc2 = {
    Text = "[Aguardar o Momento] Obtenha 1 de 3 Gravuras"
  },
  Event_146268_ChoiceDesc3 = {
    Text = "[Escapar Lentamente]"
  },
  Event_146268_Desc = {
    Text = "\"Cuidado, Castor. O corvo está observando.\"\n\nVocê avança apressado, com Pollux nas costas. Seus olhos em pânico varrem cada canto escuro, sem encontrar nada.\n\n\"Acima de nós!\"\n\nUm arrepio repentino percorre você. Você olha para cima.\n\nAgachado silenciosamente na sombra do beiral está um corvo. Olhos grotescos cobrem seu corpo, encarando em todas as direções, agora concentrando seu olhar inteiramente nos dois."
  },
  Event_146268_Name = {
    Text = "Um Sonho Antigo: II"
  },
  Event_146269_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146269_Desc = {
    Text = "Você se lembra dos avisos do treinamento: nunca dependa inteiramente da corda de segurança.\n\nEmpurrando-se da rocha íngreme, você desesperadamente consegue controlar a descida. Mas algo escorrega da sua mochila, tombando pelo penhasco até encolher a um minúsculo ponto invisível.\n\nNão importa. Pelo menos você está vivo."
  },
  Event_146269_Name = {
    Text = "Queda Silenciosa"
  },
  Event_146270_ChoiceDesc1 = {
    Text = "[Listen Closely] Ganhe uma relíquia prata \"(RelicConfig.Arg1)\" e inflija \"(Skill.Arg2)\""
  },
  Event_146270_ChoiceDesc2 = {
    Text = "[Plug Ears] Obtenha uma Oração com 3 escolhas"
  },
  Event_146270_Desc = {
    Text = "O vento e a neve se chocam contra a face da rocha, misturando-se ao tênue e espectral estalo vindo das profundezas do gelo, despedaçando-se em uma série de suspiros lamentosos.\n\nSozinho nas alturas silenciosas, você de repente ouve a melodia da montanha.\n\nÉ desolada e solene — um canto grave e profundo destinado apenas aos mortos."
  },
  Event_146270_Name = {
    Text = "Fantasia da Natureza"
  },
  Event_146271_ChoiceDesc1 = {
    Text = "[É o Sino] Desenvolva \"(Skill.Arg1),\" grave a Gravura \"(EnchantConfig.Arg2)\" em 1 Carta de Comando aleatória"
  },
  Event_146271_ChoiceDesc2 = {
    Text = "[É a Comida] Desenvolva \"(Skill.Arg1),\" grave a Gravura \"(EnchantConfig.Arg2)\" em 1 Carta de Comando aleatória"
  },
  Event_146271_ChoiceDesc3 = {
    Text = "[É a Antecipação do Cão] Grave a Gravura \"(EnchantConfig.Arg1)\" em 1 Carta de Comando aleatória"
  },
  Event_146271_Desc = {
    Text = "\"Pavlov toca o sino e depois alimenta o cão. Com o tempo, o simples toque do sino já faz o cão salivar.\"\n\n\"Então. O que é, verdadeiramente, que faz o cão salivar?\""
  },
  Event_146271_Name = {
    Text = "Reflexo Pavloviano"
  },
  Event_146272_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146272_Desc = {
    Text = "Não olhe para trás. William está bem ali, ao alcance do braço. Não deixe o luto engoli-lo. Você perdeu muito, mas ainda pode consertar isso."
  },
  Event_146272_Name = {
    Text = "Da Outra Margem"
  },
  Event_146273_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146273_Desc = {
    Text = "\"Feche a mão.\"\n\n\"O que antes era sublime se dissolverá em nada além de lama negra em seu aperto.\""
  },
  Event_146273_Name = {
    Text = "Ilusão, Não Verdade"
  },
  Event_146274_ChoiceDesc1 = {
    Text = "[Ei! Volte!] Ganhe 50 Marcas Negras"
  },
  Event_146274_ChoiceDesc2 = {
    Text = "[Acariciar o Gato] Ganhe 75 Marcas Negras, mas desenvolva \"(Skill.Arg2)\""
  },
  Event_146274_Desc = {
    Text = "<Italic:\"Miau.\"> Um gato preto de olhos verde-jade reluzentes esfrega a cabeça na sua canela com passos suaves e silenciosos.\n\nNaquele momento, você percebe que \"N\" desapareceu."
  },
  Event_146274_Name = {
    Text = "O Gato Negro Rastejante"
  },
  Event_146275_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146275_Desc = {
    Text = "Você não faz nenhum som. Simplesmente deixa seu olhar derivar pela névoa, pousando nos olhos de Pollux, recusando-se a desviar.\n\nEle também não desvia do seu olhar. Seu irmão sempre foi assim — teimoso até o âmago, recusando-se a ser o primeiro a baixar a cabeça.\n\nO cântico no salão, o cheiro de cinzas, o sermão de Juliette sobre misericórdia e sacrifício... de repente, tudo isso se distancia. É como se apenas vocês dois permanecessem, encarando-se através deste salão de piedade vazia, através da vasta extensão do tempo."
  },
  Event_146275_Name = {
    Text = "Um Sonho Antigo: III"
  },
  Event_146276_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146276_Desc = {
    Text = "Neste momento, você é o único guardião de suas longas e pálidas memórias.\n\nO Wendigo estende garras semelhantes a galhos, mirando diretamente em seu coração, mas você o repele com pura força de vontade.\n\nEle tropeça, recuando para a névoa devoradora, deixando apenas um sussurro rouco e seco:\n\n\"Mais cedo ou mais tarde, você as oferecerá a mim... e o fará de bom grado.\""
  },
  Event_146276_Name = {
    Text = "O Devorador"
  },
  Event_146277_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146277_Desc = {
    Text = "É um sonho distante. Um sonho da sua infância.\n\n\"Acorde,\" você se lembra. \"Não estamos mais lá.\"\n\nVocê volta à realidade, apenas para se encontrar parado na neve gelada, cercado por um círculo de cultistas, com a lâmina de Pollux apontada diretamente para o seu peito."
  },
  Event_146277_Name = {
    Text = "Um Sonho Antigo: I"
  },
  Event_146278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146278_Desc = {
    Text = "\"Aceito que a morte deve chegar.\"\n\n\"Ofereço voluntariamente meus ossos a esta árdua peregrinação.\"\n\n\"Sob o precipício, o céu e a terra forjarão meu monumento.\""
  },
  Event_146278_Name = {
    Text = "Presságio da Morte"
  },
  Event_146279_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146279_Desc = {
    Text = "Um reflexo não passa de um truque da luz. O que Tinct viu provavelmente era apenas a sua própria sombra.\n\nO planeta natal dela está a milhões de anos-luz de distância; o menor erro de navegação os teria espalhado por galáxias diferentes. Confortando-se com esses pensamentos, você para de se obcecar com o que está sob seus pés."
  },
  Event_146279_Name = {
    Text = "O Reflexo Submerso"
  },
  Event_146280_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146280_Desc = {
    Text = "Ela vem das estrelas. Do alvorecer profundo do tempo. De coisas que a humanidade ainda não conhece, e talvez nunca venha a conhecer.\n\nNão peça respostas a Eles.\n\nVocê não sabe o preço."
  },
  Event_146280_Name = {
    Text = "Ária do Lago Congelado"
  },
  Event_146281_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146281_Desc = {
    Text = "Você para, deixando aquela música sombria preencher seus ouvidos.\n\nO vento é um violino, a neve cortante uma batida de tambor, e o rugido distante do gelo se rachando uma harmonia grave e há muito suprimida.\n\nVocê não consegue decifrar seu tema, mas sabe que, seja no passado ou no futuro, ela continuará tocando para os incontáveis viajantes sepultados aqui."
  },
  Event_146281_Name = {
    Text = "Fantasia da Natureza"
  },
  Event_146283_ChoiceDesc1 = {
    Text = "[Olhos para os Céus] Todos os Corpos Despertos recuperam Arg1 de Fúria"
  },
  Event_146283_ChoiceDesc2 = {
    Text = "[Pisar no Pico Congelado] Escolha Despertar do Conhecimento Espiritual de 2 Corpos Despertos"
  },
  Event_146283_Desc = {
    Text = "O pico brilha em silêncio por trás de um véu de nuvens e névoa. Os abismos, as faces rochosas a pique, as tempestades uivantes — nada que habite aqui foi jamais destinado aos olhos mortais. Diante de tudo isso, você é terrivelmente frágil."
  },
  Event_146283_Name = {
    Text = "Tocando o Cume"
  },
  Event_146284_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146284_Desc = {
    Text = "\"Não, não é sua culpa. Você é apenas um brinquedo de corda, dado à corda pelo destino.\""
  },
  Event_146284_Name = {
    Text = "Rato Glutão"
  },
  Event_146285_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146285_Desc = {
    Text = "\"Entendo. Você é do tipo que depende da experiência objetiva. Mas não se esqueça: às vezes, sob superfícies idênticas, verdades completamente diferentes jazem enroladas.\"\n\nA risada do sino se perde ao longe."
  },
  Event_146285_Name = {
    Text = "Reflexo Pavloviano"
  },
  Event_146286_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146286_Desc = {
    Text = "Se justiça significa que o bem e o mal são recompensados à altura, então quem exerce o julgamento?\n\nAnúbis e sua balança? Se a gravidade do submundo obedece às leis da física, você não está particularmente confiante de que seu coração seja mais leve do que a pena dele."
  },
  Event_146286_Name = {
    Text = "Justiça Absurda"
  },
  Event_146287_ChoiceDesc1 = {
    Text = "[Pressionar por Respostas] Obter Criação de prata \"(RelicConfig.Arg1)\", desenvolver \"(Skill.Arg2)\""
  },
  Event_146287_ChoiceDesc2 = {
    Text = "[Ficar em Silêncio] Obter Criação de prata \"(RelicConfig.Arg1)\", desenvolver \"(Skill.Arg2)\""
  },
  Event_146287_ChoiceDesc3 = {
    Text = "[Pedir Desculpas] Ganhar 25 Marcas Negras"
  },
  Event_146287_Desc = {
    Text = "\"Senior William, quando o feitiço do Wendigo tomou conta de todos os outros, o senhor pareceu ser o primeiro a se libertar dele. Estamos prestes a enfrentá-los de frente. Algum conselho?\n\"\nOs olhos de William piscam. Neles, você capta um vislumbre fugaz de algo elusivo, melancólico e sereno — como um corpo à deriva em águas iluminadas pelo sol, afundando lentamente em direção ao fundo escuro do mar.\n\n\"Desculpe,\" ele diz. \"Temo que não posso ajudá-lo nisso.\""
  },
  Event_146287_Name = {
    Text = "Submersão Suave"
  },
  Event_146288_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146288_Desc = {
    Text = "\"Tão cego para a arte, tão terrivelmente cego\", murmura uma sombra escura, balançando a cabeça enquanto emerge da penumbra. \"A verdade pode ser veneno. Às vezes, uma ilusão bem guardada é a única coisa que preserva nossa frágil felicidade, não é verdade?\""
  },
  Event_146288_Name = {
    Text = "O Gato Negro Rastejante"
  },
  Event_146290_ChoiceDesc1 = {
    Text = "[Quem é o Assassino?] Desenvolva \"(Skill.Arg1),\" grave a Gravura \"(EnchantConfig.Arg2)\" em 1 carta aleatória"
  },
  Event_146290_ChoiceDesc2 = {
    Text = "[É Minha Culpa] Desenvolva \"(Skill.Arg1),\" grave a Gravura \"(EnchantConfig.Arg2)\" em 1 carta aleatória"
  },
  Event_146290_ChoiceDesc3 = {
    Text = "[É o Preço da Gula] Grave a Gravura \"(EnchantConfig.Arg1)\" em 1 de 3 Cartas de Comando"
  },
  Event_146290_Desc = {
    Text = "<Italic:\"Corre, corre, ratinho,\n\nPelos esgotos, escuros e compridos.\n\nFareje o ar e sinta o doce—\n\nUma bela casca de queijo para comer.\n\"\n\n\n\"Arraste para casa, corre, corre, corre,\n\nAgora o zumbido começou.\n\nZumbindo, zumbindo na sua cabeça,\n\nZumbindo, zumbindo, cheio de pavor.\n\"\n\n\n\"Empurre a porta, empurre a porta,\n\nNinguém mais sussurra.\n\"\n\n\"Irmãos, irmãs, enfileirados,\n\nVeja como todos ficam tão quietos.\n\nCada barriga tem um buraco,\n\nUm buraco vazio, um buraco vazio.\">"
  },
  Event_146290_Name = {
    Text = "Rato Glutão"
  },
  Event_146291_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146291_Desc = {
    Text = "Você se ajoelha e enxuga a umidade de sua bochecha. Você não pergunta se as lágrimas são reais.\n\"Não importa se são reais\", você diz. \"Você não precisa provar nada a ninguém.\"\nCaraboo abre a boca, mas a réplica esperta e desenvolta que havia preparado morre em sua garganta. Em vez disso, a represa se rompe. Suas lágrimas transbordam sem aviso, quentes e pesadas sobre o dorso de sua mão."
  },
  Event_146291_Name = {
    Text = "Lágrimas de Crocodilo"
  },
  Event_146292_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146292_Desc = {
    Text = "\"É melhor não perguntar. Há perguntas que não precisam de respostas.\""
  },
  Event_146292_Name = {
    Text = "Rato Glutão"
  },
  Event_146293_ChoiceDesc1 = {
    Text = "[Chamar] Obter Criação de prata \"(RelicConfig.Arg1)\", desenvolver \"(Skill.Arg2)\""
  },
  Event_146293_ChoiceDesc2 = {
    Text = "[Continuar Ouvindo] Todos os Corpos Despertos recuperam 50 de Fúria, desenvolver \"(Skill.Arg1)\""
  },
  Event_146293_ChoiceDesc3 = {
    Text = "[Ignorar] Obter 1 de 3 Gravuras"
  },
  Event_146293_Desc = {
    Text = "Onde Naraka caiu, só resta escuridão.\n\nUma melodia úmida deriva do pântano, fria e pálida como um par de mãos que acaricia suas bochechas com ternura persistente.\n\nEla sussurra em voz baixa: \"Venha até mim. Venha até mim no silêncio da noite.\""
  },
  Event_146293_Name = {
    Text = "Ecos Persistentes"
  },
  Event_146294_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146294_Desc = {
    Text = "Você baixa a cabeça, deixando a fumaça desfocar o contorno de Pollux, escondendo sua expressão na névoa cinza-branca.\n\nÉ mais seguro assim, você diz a si mesmo. Não há necessidade de olhar, nem de pensar.\n\nO sermão de Juliette continua a envolvê-lo. Você fita fixamente suas mãos entrelaçadas, em silêncio.\n\nSomente quando o sino ritual toca você ousa erguer os olhos novamente.\n\nPollux manteve sua postura piedosa durante todo o tempo.\n\nAtravés da vasta extensão de tempo e ilusão, você não consegue ter certeza se algo escapou naquele exato instante."
  },
  Event_146294_Name = {
    Text = "Um Sonho Antigo: III"
  },
  Event_146295_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146295_Desc = {
    Text = "\"Pollux!\"\nO nome mal deixa sua garganta antes de você o sufocar de volta. Ele se dissolve na fumaça do incenso como nada mais que um leve e ofegante suspiro.\n\nAo seu redor, o cântico dos fiéis não vacila, mas alguns olhares quietos e quase imperceptíveis se voltam para você.\n\nPollux se tensa instantaneamente, um lampejo de pânico cruzando seus olhos, embora seja rapidamente mascarado novamente por aquela expressão treinada e submissa.\n\nEle não responde. Apenas mantém os olhos baixos, mas seus dedos se cerram silenciosamente dentro da manga. Você sabe que ele ouviu."
  },
  Event_146295_Name = {
    Text = "Um Sonho Antigo: III"
  },
  Event_146297_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146297_Desc = {
    Text = "No mínimo, você não poderia ter ficado parado assistindo enquanto ela era expulsa sozinha naquela época. Deixe os problemas de hoje para o eu de hoje."
  },
  Event_146297_Name = {
    Text = "Rodas Dentro de Rodas"
  },
  Event_146298_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146298_Desc = {
    Text = "\"Pollux, devemos nos separar. Teremos mais chances de encontrar a borda da floresta assim.\n\"\n\"Mas como você vai me encontrar, irmão?\n\"\nAtravés da névoa das memórias, você vê seu rosto triste. Uma pontada aguda torce seu coração. Você respira fundo, devagar.\n\n\"Não se preocupe. Somos gêmeos; podemos ouvir os batimentos um do outro.\n\"\n\"Nunca estamos realmente separados.\""
  },
  Event_146298_Name = {
    Text = "Um Sonho Antigo: I"
  },
  Event_146299_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146299_Desc = {
    Text = "Ela julga. Ela interroga. Ela entregará um fim gelado e silencioso a todos aqueles que ousaram desafiá-la."
  },
  Event_146299_Name = {
    Text = "Veredicto da Linha de Neve"
  },
  Event_146300_ChoiceDesc1 = {
    Text = "[Recomeçar] Grave a Gravura \"(EnchantConfig.Arg1)\" em 1 de 3 Cartas de comando, mas desenvolva \"(Skill.Arg2)\""
  },
  Event_146300_ChoiceDesc2 = {
    Text = "[É Difícil] Ganhe a Criação de prata \"(RelicConfig.Arg1),\" mas desenvolva \"(Skill.Arg2)\""
  },
  Event_146300_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_146300_Desc = {
    Text = "O Verme lhe ensinou a arte da falsidade. Além disso, ela não aprendeu nada sobre sobrevivência.\n\nMas uma mentira continua sendo sempre uma mentira; chega o dia em que o andaime precisa desaparecer, e é preciso aprender a se sustentar sem seu apoio."
  },
  Event_146300_Name = {
    Text = "Ilusão, Não Verdade"
  },
  Event_146301_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146301_Desc = {
    Text = "\"De fato. Mas como poderia um rato tão pequeno conhecer o preço de sua fome?\""
  },
  Event_146301_Name = {
    Text = "Rato Glutão"
  },
  Event_146302_ChoiceDesc1 = {
    Text = "[Amarrar o Fio Vermelho] Delete 1 Carta de comando, ganhe Arg1 Marcas Negras"
  },
  Event_146302_ChoiceDesc2 = {
    Text = "[Recusar o Fio Vermelho] Copie 1 Carta de comando, mas desenvolva \"(Skill.Arg1)\""
  },
  Event_146302_ChoiceDesc3 = {
    Text = "[De Volta à Realidade] Grave a Gravura \"(EnchantConfig.Arg1)\" em 1 de 3 Cartas de Comando"
  },
  Event_146302_Desc = {
    Text = "O primeiro sonho. A floresta. Você e seu irmão, com pouco mais de dez anos, são abandonados nas profundezas da floresta escura pela Senhora Lanterna.\n\n<Italic:\"Quando a noite cair, as bestas adormecidas começarão a caçar. Escapem antes disso. Apenas os que conseguirem sair poderão ser meus filhos queridos.>\n\nSeu irmão agarra sua mão e puxa um fio vermelho.\n\n\"Castor, vamos amarrar nossas mãos juntas. Assim, não nos perderemos.\""
  },
  Event_146302_Name = {
    Text = "Um Sonho Antigo: I"
  },
  Event_146304_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146304_Desc = {
    Text = "Você ouve risos.\n\nBrincalhões, zombeteiros, repletos de diversão.\n\nA luta desesperada da humanidade para explorar o cosmos é, aos olhos deles, nada mais que o arrastar de formigas."
  },
  Event_146304_Name = {
    Text = "Aqueles Sob o Olhar"
  },
  Event_146306_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146306_Desc = {
    Text = "Ela purifica. Ela apaga. Ela reunirá em seu abraço silencioso todos aqueles que sobem e nunca retornam."
  },
  Event_146306_Name = {
    Text = "Veredicto da Linha de Neve"
  },
  Event_146307_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146307_Desc = {
    Text = "Você e o corvo se encaram.\n\nÉ óbvio que você não vai vencer esse impasse.\n\nMas então, contra Juliette, parece que você nunca vence mesmo."
  },
  Event_146307_Name = {
    Text = "Um Sonho Antigo: II"
  },
  Event_146308_ChoiceDesc1 = {
    Text = "[Quem Está Me Observando?] Despertar aleatoriamente 1 Corpo Desperto, desenvolver \"(Skill.Arg1)\""
  },
  Event_146308_ChoiceDesc2 = {
    Text = "[Focar no Presente] Escolher 1 de 3 Cartas de comando para Gravar: \"(EnchantConfig.Arg1)\""
  },
  Event_146308_Desc = {
    Text = "Um vento gelado e carregado de neve uiva por este alto santuário, intocado por passos humanos.\n\nVocê olha para cima. Mais alto ainda, há apenas o sol eterno e impassível.\n\nMas você sabe que em algum lugar ainda mais alto, mais distante, incontáveis olhos estão se abrindo e fechando.\n\nE alguns desses olhos estão silenciosamente fitando todo o mundo sob seus pés."
  },
  Event_146308_Name = {
    Text = "Aqueles Sob o Olhar"
  },
  Event_146309_ChoiceDesc1 = {
    Text = "[Ainda Não Consigo Soltar] Ganhe a Criatura amaldiçoada \"(RelicConfig.Arg1),\" mas desenvolva \"(Skill.Arg2)\""
  },
  Event_146309_ChoiceDesc2 = {
    Text = "[Já Esqueci] Grave a Gravura \"(EnchantConfig.Arg1)\" em 1 carta aleatória"
  },
  Event_146309_Desc = {
    Text = "Você tenta fechar as câmaras da memória. Dentro daquele cofre secreto estão todas as respostas que o definem — cada impulso vergonhoso, cada fantasia oculta. Mas o desejo é uma maldição subconsciente, uma obsessão doce demais para resistir."
  },
  Event_146309_Name = {
    Text = "Maldição Subconsciente"
  },
  Event_146310_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146310_Desc = {
    Text = "William desvia o olhar.\n\"A mente é nosso único escudo contra a ilusão. Mas uma mente é forjada por uma vida inteira de experiências. Ela não pode ser compartilhada, e não pode ser ensinada.\"\n\n\"A única coisa que posso lhe dizer é: não deixe sua própria fraqueza engoli-lo.\""
  },
  Event_146310_Name = {
    Text = "Submersão Suave"
  },
  Event_146311_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146311_Desc = {
    Text = "\"Entendo. Você é do tipo que deseja ser filósofo. Mas não se esqueça: a ausência de esperança não significa a ausência de dor.\"\nA risada do sino se perde ao longe."
  },
  Event_146311_Name = {
    Text = "Reflexo Pavloviano"
  },
  Event_146312_ChoiceDesc1 = {
    Text = "[Sair] infecção de[(Skill.Arg1)], ganha 50 o sigilo negro"
  },
  Event_146312_Desc = {
    Text = "\"Faminta, tão faminta.\"\n\n\nA montanha chora; a montanha lamenta. Ela não suporta o vasto e vazio abismo dentro de seu ventre."
  },
  Event_146312_Name = {
    Text = "Segredo da Montanha"
  },
  Event_146313_ChoiceDesc1 = {
    Text = "[Tentar Encontrar Apoio] Deletar 1 Carta de comando, recuperar Arg1 de Vida"
  },
  Event_146313_ChoiceDesc2 = {
    Text = "[Agarrar a Corda de Segurança] Obter Criação de ouro \"(RelicConfig.Arg1)\", desenvolver \"(Skill.Arg2)\""
  },
  Event_146313_Desc = {
    Text = "Um caleidoscópio de alucinações fervilha em sua mente.\n\nPrimeiro, pó solto. Depois, uma cornija desabando.\n\nVocê não consegue deter sua queda; a corda de segurança faísca cegamente contra o grampo ao escorregar. Mas diante das montanhas, ela é tão terrivelmente pequena, tão frágil."
  },
  Event_146313_Name = {
    Text = "Queda Silenciosa"
  },
  Event_146314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146314_Desc = {
    Text = "Venha até mim em seus sonhos. Deixe-me viver minha vida mais uma vez.\n\nO gramofone solta um suspiro lamentoso. Então, o som da respiração se dissolve na escuridão. Nada resta além do eco. Apenas o eco."
  },
  Event_146314_Name = {
    Text = "Ecos Persistentes"
  },
  Event_146315_ChoiceDesc1 = {
    Text = "[Lamentar a decisão] Obter Criação de prata \"(RelicConfig.Arg1)\""
  },
  Event_146315_ChoiceDesc2 = {
    Text = "[Deixar ao Destino] Obter Criação de ouro \"(RelicConfig.Arg1)\", desenvolver \"(Skill.Arg2)\""
  },
  Event_146315_Desc = {
    Text = "Você sempre soube que esta jornada não seria simples. A maioria dos alpinistas desta expedição está alimentando seus próprios planos sombrios.\n\nNo entanto, ao ver o sorriso maníaco e zombeteiro se espalhando pelo rosto de Caraboo, você ainda sente o estalo agudo e repentino de algo se despedaçando em seu peito.\n\nTalvez, quando Naraka quis expulsá-la do grupo, você devesse ter feito uma escolha diferente."
  },
  Event_146315_Name = {
    Text = "Rodas Dentro de Rodas"
  },
  Event_146316_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146316_Desc = {
    Text = "Quantos foram engolidos por este lugar?\n\nMãos negras emergem do lago espesso e viscoso, tentando arrastá-lo para o fundo de seu mundo. Mas você simplesmente continua caminhando. Elas não fazem nenhum movimento para detê-lo, deslizando silenciosamente de volta para as profundezas.\n\nO cume ainda espera por você à frente."
  },
  Event_146316_Name = {
    Text = "Ecos Persistentes"
  },
  Event_146317_ChoiceDesc1 = {
    Text = "[Desviar o Olhar] Ganhar 25 Marcas Negras"
  },
  Event_146317_ChoiceDesc2 = {
    Text = "[Olhar Mais de Perto] Obter Criação de prata \"(RelicConfig.Arg1)\", desenvolver \"(Skill.Arg2)\""
  },
  Event_146317_Desc = {
    Text = "Seguindo o olhar de Tinct, você não consegue evitar encarar as profundezas do lago.\n\nO que há lá embaixo que a mantém tão fascinada?\n\nVocê não consegue dizer. O gelo está turvo e escuro, refletindo apenas a sua própria sombra."
  },
  Event_146317_Name = {
    Text = "O Reflexo Submerso"
  },
  Event_146318_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146318_Desc = {
    Text = "A única maneira de deter a fome é soltar. Ninguém pode perder o que não possui. O Wendigo mostra os dentes, deixando escapar um rosnado frustrado, e se esgueira de volta para a névoa."
  },
  Event_146318_Name = {
    Text = "Maldição Subconsciente"
  },
  Event_146319_ChoiceDesc1 = {
    Text = "[A Neve Me Purificará] Melhorar aleatoriamente a qualidade da Gravura de 1 Carta"
  },
  Event_146319_ChoiceDesc2 = {
    Text = "[A Neve Me Julgará] Escolher 1 de 3 Cartas de comando para Gravar: \"(EnchantConfig.Arg1)\", desenvolver \"(Skill.Arg2)\""
  },
  Event_146319_Desc = {
    Text = "Diante de você está a ascensão final, onde a linha de neve fria e interminável se estende ao longe.\n\nA neve é de um branco ofuscante e brilhante. Aqui, até a morte parece limpa."
  },
  Event_146319_Name = {
    Text = "Veredicto da Linha de Neve"
  },
  Event_146320_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146320_Desc = {
    Text = "Não perca nenhum detalhe da visão. Grave-os em sua mente. Grave o vazio repentino, a dor oca e o luto agudo que se seguiu. Nunca, jamais os deixe ir."
  },
  Event_146320_Name = {
    Text = "Da Outra Margem"
  },
  Event_146321_ChoiceDesc1 = {
    Text = "[Lutar Juntos] Ganhe a Criação de prata \"(RelicConfig.Arg1)\""
  },
  Event_146321_ChoiceDesc2 = {
    Text = "[Confortá-la] Ganhe a Criação de ouro \"(RelicConfig.Arg1),\" mas desenvolva \"(Skill.Arg2)\""
  },
  Event_146321_Desc = {
    Text = "A montanha estremece, uma besta agonizante. Carne pálida e segmentada irrompe da pedra fraturada, enrolando-se e escalando, arremessando Caraboo ao chão.\n\nQuando ela se levanta, rastros úmidos marcam suas bochechas cobertas de poeira. São lágrimas de dor? Você não pode dizer.\n\nTantas mentiras já brotaram de seus lábios; quem pode confiar nas lágrimas de um crocodilo?"
  },
  Event_146321_Name = {
    Text = "Lágrimas de Crocodilo"
  },
  Event_146322_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146322_Desc = {
    Text = "Você não faz perguntas. Simplesmente ocupa seu lugar ao lado dela.\n\"Levante-se\", você diz. \"Você está apenas na metade do seu ato. Não desista agora.\"\nCaraboo hesita, então limpa o rosto com uma mão brusca e repentina. Ela se ergue com dificuldade, com os nós dos dedos brancos sobre sua arma, para encarar a goela carmesim escancarada ao seu lado.\nEla disse tantas mentiras que nem ela mesma consegue distinguir quais lágrimas são água e quais são sal. Mas por ora, ninguém está contando."
  },
  Event_146322_Name = {
    Text = "Lágrimas de Crocodilo"
  },
  Event_146323_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146323_Desc = {
    Text = "\"Entendo. Você é do tipo que se orgulha de enxergar através das ilusões. Mas não se esqueça: naquele breve momento de realidade, a comida existia apenas em sua memória e em seu desejo.\"\nA risada do sino se perde ao longe."
  },
  Event_146323_Name = {
    Text = "Reflexo Pavloviano"
  },
  Event_146324_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146324_Desc = {
    Text = "Você diminui o passo, suavizando suas pisadas.\n\nDevagar, com cuidado, sem fazer barulho...\n\nVocê desliza pela próxima esquina e desaparece.\n\nO corvo chegou a te seguir?\n\nVocê não se lembra mais."
  },
  Event_146324_Name = {
    Text = "Um Sonho Antigo: II"
  },
  Event_146325_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146325_Desc = {
    Text = "A melodia se interrompe.\n\nDo pântano negro, um par de olhos ávidos e úmidos se abre para olhar para você. Eles sussurram palavras que você não consegue distinguir, depois, lentamente, lentamente se fecham."
  },
  Event_146325_Name = {
    Text = "Ecos Persistentes"
  },
  Event_146326_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146326_Desc = {
    Text = "Você não demora. Deixando a melodia para trás, suas botas amassam a neve, produzindo um som mais apressado que o próprio vento.\n\nMas não importa quão rápido você caminhe, aquela toada desolada se agarra teimosamente aos seus calcanhares, sem nunca ficar para trás.\n\nVocê não pode escapar dela — é o próprio sopro da montanha. E você é apenas um minúsculo e passageiro ouvinte que por acaso a escutou."
  },
  Event_146326_Name = {
    Text = "Fantasia da Natureza"
  },
  Event_146327_ChoiceDesc1 = {
    Text = "[Ouvi-la] Escolha 1 de 3 Cartas de comando para Gravar: \"(EnchantConfig.Arg1)\", desenvolver \"(Skill.Arg2)\""
  },
  Event_146327_ChoiceDesc2 = {
    Text = "[Ignorá-la] Para cada Corpo Desperto com Fúria em 50 ou acima, ganhe 15 Marcas Negras"
  },
  Event_146327_ChoiceDesc3 = {
    Text = "[Sair à Força] ganha 3 opções para escolha de oração"
  },
  Event_146327_Desc = {
    Text = "Uma canção distante deriva no vento.\n\nParece vir de todas as direções, ou talvez das profundezas da terra.\n\nPara qualquer lado que você se vire para segui-la, ela ecoa em seus ouvidos com a mesma intensidade implacável."
  },
  Event_146327_Name = {
    Text = "Ária do Lago Congelado"
  },
  Event_146328_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146328_Desc = {
    Text = "\"Ó Estrela do Mau Augúrio, esta não é a hora do teu brilho.\"\n\n\"Minha peregrinação tem destinos que ainda não alcancei.\"\n\n\"Apaga-te, ainda que por ora, e deixa a paz retornar ao céu desta noite.\""
  },
  Event_146328_Name = {
    Text = "Presságio da Morte"
  },
  Event_146329_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146329_Desc = {
    Text = "Uma onda inútil de arrependimento o invade. Mas, afinal, somos sempre forçados a limpar a bagunça deixada por nossos eus do passado."
  },
  Event_146329_Name = {
    Text = "Rodas Dentro de Rodas"
  },
  Event_146330_ChoiceDesc1 = {
    Text = "[Morder] Despertar 1 Corpo Desperto aleatório, infectar[(Skill.Arg1)]"
  },
  Event_146330_ChoiceDesc2 = {
    Text = "[Refuse] Ganhe 1 entre 3 Oração"
  },
  Event_146330_Desc = {
    Text = "No fundo da névoa entupida de neve, agacha-se uma figura esquelética, a pele seca e rachada esticada sobre costelas salientes. Sobre sua cabeça, galhos retorcidos e murchos de chifres perfuram a neblina. Um rumor oco e faminto ecoa de seu ventre.\n\nQuando seus olhos se encontram, imagens fragmentadas redemoinham em suas órbitas fundas — suas memórias. Ele já captou o rastro; já as saboreou.\n\n\"Não é suficiente, nunca é suficiente...\" ele geme, um som rouco e seco. Estende uma mão murcha, sua postura quase... suplicante."
  },
  Event_146330_Name = {
    Text = "O Devorador"
  },
  Event_146332_ChoiceDesc1 = {
    Text = "[Realizar o Enterro Celestial] Ganhe a Criação de prata \"(RelicConfig.Arg1)\""
  },
  Event_146332_ChoiceDesc2 = {
    Text = "[Dispel] Ganha 75 Marca Negra, infecção de[(Skill.Arg2)]"
  },
  Event_146332_Desc = {
    Text = "Nas correntes térmicas ascendentes, abutres-barbudos circulam, patrulhando seu domínio. Entre aqueles que escalam, isso sempre foi um mau presságio.\n\n\"Eles estão forrageando. Um abutre fareja a aproximação da morte.\""
  },
  Event_146332_Name = {
    Text = "Presságio da Morte"
  },
  Event_146333_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146333_Desc = {
    Text = "Confie nas suas pernas. Você vai conquistar este pico."
  },
  Event_146333_Name = {
    Text = "Tocando o Cume"
  },
  Event_146334_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146334_Desc = {
    Text = "No momento em que o anseio irrompe, você sabe que não pode combatê-lo. Só pode observar enquanto ele viola os cofres há muito selados de sua mente. Presas pálidas e afiadas se cravam em suas têmporas, arrancando suas memórias, quadro a quadro, pela raiz."
  },
  Event_146334_Name = {
    Text = "Maldição Subconsciente"
  },
  Event_146335_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146335_Desc = {
    Text = "Ele se aproxima, o nariz quase tocando sua testa, inalando você com uma devoção extasiada e embriagada, como se você fosse o mel mais doce.\n\nSuas ansiedades inquietas e turbulentas são lambidas de sua mente.\n\nEle recua com um zumbido baixo e satisfeito, uma luz selvagem e sedutora cintilando em seus olhos ocos. Seu peito se sente vazio agora, uma peça faltando — ainda assim, estranhamente, você se sente mais leve."
  },
  Event_146335_Name = {
    Text = "O Devorador"
  },
  Event_146336_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146336_Desc = {
    Text = "\"Cuidado com seus passos. Certifique-se de que cada passo seja firme\", a voz de Naraka ecoa em seu ouvido. \"Não espere que outros o amparem quando você cair.\""
  },
  Event_146336_Name = {
    Text = "Aqueles Sob o Olhar"
  },
  Event_146337_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146337_Desc = {
    Text = "A humanidade pertence aos céus. Um propósito verdadeiro faz alguém esquecer o precipício abaixo. O céu está aberto, esperando logo acima."
  },
  Event_146337_Name = {
    Text = "Tocando o Cume"
  },
  Event_146338_ChoiceDesc1 = {
    Text = "[Deixar as Homenagens Irem] Ganhe a Criação de ouro \"(RelicConfig.Arg1),\" mas desenvolva \"(Skill.Arg2)\""
  },
  Event_146338_ChoiceDesc2 = {
    Text = "[Segurar a Pain] Obtenha 1 de 3 Criações de ouro, mas desenvolva \"(Skill.Arg1)\""
  },
  Event_146338_ChoiceDesc3 = {
    Text = "[Sair] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_146338_Desc = {
    Text = "A pessoa que outrora assassinou William está diante de você agora.\n\nNo ar estagnado e nauseante da tenda de Aram, as memórias surgem como fantasmas: a forma sem sangue e flutuante de William; seu rosto pálido voltado para cima; e sobre a mesa, a carcaça dissecada e vazia daquela pequena lanterna."
  },
  Event_146338_Name = {
    Text = "Da Outra Margem"
  },
  Event_146339_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146339_Desc = {
    Text = "A corda de segurança se rompe instantaneamente sob seu peso.\n\nVocê cai pesadamente em um banco de neve, cada órgão gritando em um protesto surdo e agonizante. Você força os olhos a se abrirem através da dor vertiginosa, apenas para se encontrar cara a cara com um esqueleto sem nome.\n\nNo fundo de suas órbitas vazias e ocas, algo cintila."
  },
  Event_146339_Name = {
    Text = "Queda Silenciosa"
  },
  Event_146340_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146340_Desc = {
    Text = "Não há saída. Você range os dentes e dispara, tentando desesperadamente escapar do seu observador. O corvo solta um grasno áspero, bate as asas e te rastreia sem esforço lá de cima, chegando até a dar voltas para te provocar. Um desespero gelado penetra sua pele sob seu olhar.\n\nVocê não pode fugir deles."
  },
  Event_146340_Name = {
    Text = "Um Sonho Antigo: II"
  },
  Event_146341_ChoiceDesc1 = {
    Text = "[Colhe Quem Semeia] Uma Carta de comando aleatória ganha Gravura: \"(EnchantConfig.Arg1)\""
  },
  Event_146341_ChoiceDesc2 = {
    Text = "[Paridade Absoluta] Aumentar a Vida máxima em Arg1, desenvolver \"(Skill.Arg2)\""
  },
  Event_146341_Desc = {
    Text = "Pendurado na face rochosa e íngreme, uma questão completamente sem relação de repente surge em sua mente: O que é justiça?"
  },
  Event_146341_Name = {
    Text = "Justiça Absurda"
  },
  Event_146342_ChoiceDesc1 = {
    Text = "[Sair] infecção de[(Skill.Arg1)], ganha 50 o sigilo negro"
  },
  Event_146342_Desc = {
    Text = "\"Não posso morrer! Ainda não!\"\nA montanha chora; a montanha lamenta. Em sua ganância insaciável, consumiu o próprio amanhã."
  },
  Event_146342_Name = {
    Text = "Segredo da Montanha"
  },
  Event_146343_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146343_Desc = {
    Text = "Você se inclina até sua bochecha tocar o gelo.\n\nUm frio profundo e cortante penetra pela sua pele até os ossos, fazendo você estremecer. Algo insondável e lento se move sob a superfície congelada. É uma corrente, ou algum ser vivo?\n\nSeja o que for, não tem nada a ver com sua jornada."
  },
  Event_146343_Name = {
    Text = "O Reflexo Submerso"
  },
  Event_148532_ChoiceDesc1 = {
    Text = "[Receber a Bênção] No início da batalha, adicione 1 \"Fruta Proteiforme\" aleatória ao seu baralho."
  },
  Event_148532_Desc = {
    Text = "A vasta planície de neve se estende sem fim, o vento frio não carrega nenhum som, e uma sombra de origem incerta surge silenciosamente, oferecendo um fruto morno.\nO aroma doce misturado com névoa invade as narinas entorpecidas pelo frio do viajante. \nEssa região coberta de neve há muito foi impregnada pela morte, e o ar carrega um cheiro nauseante de putrefação e gelo, mas apenas o fruto na palma da mão permanece suculento e pleno, como a promessa sedutora de uma jovem."
  },
  Event_148532_Name = {
    Text = "Miragem Celestial"
  },
  Event_20778_ChoiceDesc1 = {
    Text = "[Give It to Her] Todos os Despertadores recuperam Aliemus Arg1"
  },
  Event_20778_ChoiceDesc2 = {
    Text = "[Require Support] Escolha despertar 2 Despertadores"
  },
  Event_20778_Desc = {
    Text = "\"Esta é uma comunicação de Mythag. Flutuação anormal no índice gnóstico detectada no Despertar. Você precisa de apoio?\""
  },
  Event_20778_Name = {
    Text = "Comunicação de apoio"
  },
  Event_20779_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20779_Desc = {
    Text = "\"Ajuda de emergência foi fornecida. Por favor, toque no broche três vezes para confirmar após recebê-lo.\""
  },
  Event_20779_Name = {
    Text = "Comunicação de apoio"
  },
  Event_20780_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20780_Desc = {
    Text = "A aparição de um futuro distante, oculta nas montanhas de Elworth"
  },
  Event_20780_Name = {
    Text = "Fantasma vulcânico"
  },
  Event_20781_ChoiceDesc1 = {
    Text = "[Gaze at Phantasm] Todos os Despertadores recuperam Aliemus Arg1"
  },
  Event_20781_ChoiceDesc2 = {
    Text = "[Aproximar-se do Fantasma] Escolha Despertar 2 Despertadores"
  },
  Event_20781_Desc = {
    Text = "Lá ao longe, parece haver uma erupção vulcânica, e fumaça em forma humana se eleva sob o céu devastado pelo vento.\nEsta é Elworth, Elworth só tem montanhas nevadas e cavernas de rochas calcárias.\nFoi a anomalia contínua que deixou você em desequilíbrio?"
  },
  Event_20781_Name = {
    Text = "Fantasma vulcânico"
  },
  Event_20782_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20782_Desc = {
    Text = "O fantasma acenou para você e então desapareceu, deixando apenas o frio gelo e as imensas montanhas"
  },
  Event_20782_Name = {
    Text = "Fantasma vulcânico"
  },
  Event_20783_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20783_Desc = {
    Text = "\"Entendido. Vamos entregar os recursos básicos. Por favor, verifique.\""
  },
  Event_20783_Name = {
    Text = "Comunicação de apoio"
  },
  Event_21398_ChoiceDesc1 = {
    Text = "[Pegue a foto] escolha 1 de 3 cartas de comando e ganhe oração: [(EnchantConfig.Arg1)]"
  },
  Event_21398_Desc = {
    Text = "A máquina foi desmontada, a verdade revelada.\nA vida tumultuada desapareceu, deixando você com a satisfação da verdade"
  },
  Event_21398_Name = {
    Text = "Declaração de testemunha"
  },
  Event_21399_ChoiceDesc1 = {
    Text = "[Pegue a foto] escolha 1 de 3 cartas de comando e ganhe oração: [(EnchantConfig.Arg1)]"
  },
  Event_21399_ChoiceDesc2 = {
    Text = "[Check film] infecção[(Skill.Arg1)], trocando a oração obtida na opção 1, pode ser utilizada uma vez"
  },
  Event_21399_Desc = {
    Text = "A curiosidade impulsiona você a direcionar seu olhar para a Piscina das Sombras.\nAs imagens imersas em um líquido rubro, enquanto o pecador coberto de manchas negras possui um rosto que lembra o seu"
  },
  Event_21399_Name = {
    Text = "Declaração de testemunha"
  },
  Event_21400_ChoiceDesc1 = {Text = "[Leave]"},
  Event_21400_Desc = {
    Text = "A máquina foi desmontada, a verdade revelada.\nA vida tumultuada desapareceu, deixando você com a satisfação da verdade"
  },
  Event_21400_Name = {
    Text = "Declaração de testemunha"
  },
  Event_21811_ChoiceDesc1 = {Text = "[Leave]"},
  Event_21811_Desc = {
    Text = "\"Vinte e cinco anos... sim, ela me fez adormecer por vinte e cinco anos.\"\nA menina respondeu a você de forma sombria e desanimada.\nAo acordar de um longo sono, aqueles que a cuidavam desde pequena se tornaram, com o passar dos anos, verdadeiros Marchadores de mares.\nNinguém mais entende seu sofrimento, ninguém mais se importa com sua dor, deixando-a sozinha na seita.\nEla preferiria que o dia anterior ao seu sono fosse o \"momento do alinhamento das estrelas\"."
  },
  Event_21811_Name = {Text = "Vida Presa"},
  Event_22058_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22058_Desc = {
    Text = "\n\"Não, não estou com fome.\"\nVocê recusou educadamente o caloroso convite para o banquete.\nVocê nunca estaria disposto a hipotecar sua alma por isso"
  },
  Event_22058_Name = {
    Text = "Festim de carne"
  },
  Event_22059_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22059_Desc = {
    Text = "Você mordida faminta no scone sangrento, o aroma de um coração apimentado assado na massa preenchendo seus sentidos com um cheiro familiar.\n\"Conseguir poder vem com um custo.\"\nVocê bebe a última gota de sangue."
  },
  Event_22059_Name = {
    Text = "Festim de carne"
  },
  Event_22060_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22060_Desc = {
    Text = "Você engoliu a sopa branca e a carne picada, limpando os lábios com a manga.\nA carne era macia, a sopa saborosa, mas a quem pertencia?\nApenas a ponta do iceberg do que você perdeu"
  },
  Event_22060_Name = {
    Text = "Festim de carne"
  },
  Event_22061_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22061_Desc = {
    Text = "Você examina cuidadosamente os antigos selos entalhados no sinos.  \nEles estão distorcidos de uma maneira que a mente comum não pode imaginar, parecendo não ter intenção de ser compreendidos.  \nNão ser compreendido é não ser perturbado"
  },
  Event_22061_Name = {
    Text = "Sino de Vento Enferrujado"
  },
  Event_22062_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22062_Desc = {
    Text = "\"Não é ruim, você é muito cauteloso.\"\nDe repente, uma voz distante veio dos sinos de vento.\n\"A cautela trará uma pequena recompensa, mas só isso.\""
  },
  Event_22062_Name = {
    Text = "Sino de Vento Enferrujado"
  },
  Event_22063_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22063_Desc = {
    Text = "Você acariciou as antigas inscrições gravadas na sinfonia.\nElas se torciam de uma forma que os mortais não podiam imaginar, e parecia que não tinham intenção de serem compreendidas.\nSe não compreendidas, então não seriam incomodadas"
  },
  Event_22063_Name = {
    Text = "Sino de Vento Enferrujado"
  },
  Event_22064_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22064_Desc = {
    Text = "\"Ah, que pena... Suponho que continuarei minha performance solitária.\" Você não sabe quando o zither e as mãos desapareceram, mas a melodia, como água corrente, permanece em seu coração para sempre."
  },
  Event_22064_Name = {
    Text = "Fantasma ao lado do piano"
  },
  Event_22065_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22065_Desc = {
    Text = "\"Ah, que honra ter um amigo como este!\" Aqueles braços ficaram animados, e você não conseguiu acompanhar sua velocidade. Mesmo muito tempo depois que a apresentação terminou, aquele som emocionante ainda agitou seu coração."
  },
  Event_22065_Name = {
    Text = "Fantasma ao lado do piano"
  },
  Event_22175_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22175_Desc = {
    Text = "O tabuleiro de ouija se moveu confiante, e seus olhos seguiram. \nNo entanto, mal apontou duas letras antes de se transformar em um líquido negro viscoso com um grito horrível"
  },
  Event_22175_Name = {
    Text = "Tabuleiro Ouija"
  },
  Event_22176_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22176_Desc = {
    Text = "\n\"Matemática! Matemática!!\" \nA mulher cerrava os dentes, a tábua do oráculo deslizava rapidamente entre os números, produzindo um som áspero de fricção de madeira.\n\"Saia com essa matemática da minha vista!\""
  },
  Event_22176_Name = {
    Text = "Tabuleiro Ouija"
  },
  Event_22177_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22177_Desc = {
    Text = "\"Espere, espere!!\"\n\"Pergunte-me! Por que você não pergunta!\""
  },
  Event_22177_Name = {
    Text = "Tabuleiro Ouija"
  },
  Event_22178_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22178_Desc = {
    Text = "Nunca esteve tão vibrante, mas, ao mesmo tempo, o vazio em seu coração está se rasgando"
  },
  Event_22178_Name = {
    Text = "Sede Amaldiçoada"
  },
  Event_22179_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22179_Desc = {
    Text = "Alma e espírito enchem seus pulmões, você sobe em silêncio.\nOs sons do mundo surgem, tocando a sinfonia da vida"
  },
  Event_22179_Name = {
    Text = "Água do passado"
  },
  Event_22180_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22180_Desc = {
    Text = "Tudo acontece como de costume, a destruição chega como esperado, algo precioso enterrado nas cinzas não queimadas, brilhando nas sombras"
  },
  Event_22180_Name = {
    Text = "Fora da ponta da agulha"
  },
  Event_22181_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22181_Desc = {
    Text = "Encontro, partida, passagem"
  },
  Event_22181_Name = {
    Text = "Som das estrelas e da lua"
  },
  Event_22182_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22182_Desc = {
    Text = "O coração desacelera, mas talvez a \"consciência\" tenha sido um pouco aliviada"
  },
  Event_22182_Name = {
    Text = "Sede Amaldiçoada"
  },
  Event_22183_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22183_Desc = {
    Text = "Você fecha os olhos, aproveitando esse raro momento de ilusão e liberdade. Gradualmente, você sente o mundo chocando-se da quietude, a vida florescendo silenciosamente na paz"
  },
  Event_22183_Name = {
    Text = "Água do passado"
  },
  Event_22184_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22184_Desc = {
    Text = "Você interceptou o ponteiro; a lâmina prateada cintilou, cortando sua mão macia. A destruição ainda não havia chegado, mas a sombra sob seus pés foi devorada pela escuridão intensa da noite"
  },
  Event_22184_Name = {
    Text = "Fora da ponta da agulha"
  },
  Event_22185_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22185_Desc = {
    Text = "\n\"Você não pode escapar; ninguém pode resistir ao mal interior.\"\nPensamentos malignos destroem seus nervos, tentando arrastá-lo para o abismo. Mas a dor apenas faz sua mente sentir uma clareza sem precedentes.\nO mal não pode possuí-lo; você permanecerá você mesmo."
  },
  Event_22185_Name = {
    Text = "Pensamento Ilusório"
  },
  Event_22186_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22186_Desc = {
    Text = "\"Por que não?\"\nUma vez que você abrace esses pensamentos terríveis, todas as dificuldades serão facilmente resolvidas, e o mundo não terá mais um paradoxo chamado \"ética.\""
  },
  Event_22186_Name = {
    Text = "Pensamento Ilusório"
  },
  Event_22187_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22187_Desc = {
    Text = "Uma cortina prateada passa diante dos olhos, um vento surdo leva todos os sons"
  },
  Event_22187_Name = {
    Text = "Pensamento Ilusório"
  },
  Event_22188_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22188_Desc = {
    Text = "Volúvel, frio, distante"
  },
  Event_22188_Name = {
    Text = "Som das estrelas e da lua"
  },
  Event_22189_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22189_Desc = {
    Text = "Incha, contrai, pronto para explodir"
  },
  Event_22189_Name = {
    Text = "Som das estrelas e da lua"
  },
  Event_22190_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22190_Desc = {
    Text = "Embora pareça imprudente, por que não?\nQuebre todas as barreiras e corra para o fim.\nMesmo que cause ondas gigantes no lago da mente, mesmo que se torne Ícaro perseguindo o sol, pelo menos você alcançou seu objetivo, não é?"
  },
  Event_22190_Name = {
    Text = "Labirinto da Mente"
  },
  Event_22191_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22191_Desc = {
    Text = "Seu cérebro é um labirinto, e você é sua Ariadne.\nNeste universo, ninguém sabe melhor do que você como sair do labirinto.\nNinguém"
  },
  Event_22191_Name = {
    Text = "Labirinto da Mente"
  },
  Event_22192_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22192_Desc = {
    Text = "Com a afinação correta, os intervalos dissonantes suavizaram um pouco.\nMas talvez, você ainda possa fazer algo"
  },
  Event_22192_Name = {
    Text = "Disonância"
  },
  Event_22193_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22193_Desc = {
    Text = "Você é um mestre da música, mas também um simples desafinado.\nAs notas sob seu controle fluem, e a vida em movimento finalmente ressoa no domínio"
  },
  Event_22193_Name = {
    Text = "Disonância"
  },
  Event_22194_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22194_Desc = {
    Text = "Sua voz se perde no silêncio. O silêncio cresce, até se quebrar completamente, deixando destroços"
  },
  Event_22194_Name = {
    Text = "Água do passado"
  },
  Event_22195_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22195_Desc = {
    Text = "Você não se deixa enganar facilmente, vira-se decisivamente e sai"
  },
  Event_22195_Name = {
    Text = "Grieta reptante"
  },
  Event_22293_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22293_Desc = {
    Text = "No momento em que escrevi, a carta queimou no domínio, as cinzas caíram em minha mão, \nao voltar a mim, algo se dissipou junto com a carta"
  },
  Event_22293_Name = {
    Text = "Confissão unidirecional"
  },
  Event_22294_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22294_Desc = {
    Text = "No momento em que o papel de carta se dissipou no domínio, você ouviu uma preocupação suave e fraca. \n \"É uma honra para mim, como professor, que você se lembre de mim em tal situação. \n No entanto, a última vez que caminhei pelo domínio foi há muito, muito tempo. Hoje, só posso ajudar você com isso...\""
  },
  Event_22294_Name = {
    Text = "Confissão unidirecional"
  },
  Event_22295_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22295_Desc = {
    Text = "Quando a carta se desintegrou no Domínio, você ouviu uma exclamação urgente.\n\"Guardião, se houver algo desconfortável, por favor, certifique-se de me informar.\nComo seu parceiro, não pouparei esforços para ajudá-lo.\""
  },
  Event_22295_Name = {
    Text = "Confissão unidirecional"
  },
  Event_22296_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22296_Desc = {
    Text = "À medida que a carta se dissipa no Domínio, você ouve um suspiro frio.\n\"Se ao menos você estivesse tão ansioso para buscar ajuda quando falha nos exames.\""
  },
  Event_22296_Name = {
    Text = "Confissão unidirecional"
  },
  Event_22397_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22397_Desc = {
    Text = "Sua aparição deixa as sombras perplexas, um feixe de luz estelar passa por seus pés e a multidão desaparece, deixando a sombra mais densa em sua mão"
  },
  Event_22397_Name = {
    Text = "Pacto de Lua e Estrelas"
  },
  Event_22398_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22398_Desc = {
    Text = "Os sussurros barulhentos cessaram, sombras escuras se voltaram para você, encarando-o. Você percebe um toque de sarcasmo em seus rostos sem feições"
  },
  Event_22398_Name = {
    Text = "Pacto de Lua e Estrelas"
  },
  Event_22399_ChoiceDesc1 = {
    Text = "[Observar com Calma] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_22399_ChoiceDesc2 = {
    Text = "[Ask Aloud] Ganhe 25 Sigilos Negros"
  },
  Event_22399_Desc = {
    Text = "Na interseção entre estrelas e lua, sussurros incessantes ecoam. \n \"É essa a pessoa? @4?\" \n \"Um corpo humano, afinal, ainda é @3...\""
  },
  Event_22399_Name = {
    Text = "Pacto de Lua e Estrelas"
  },
  Event_22411_ChoiceDesc1 = {
    Text = "[Missão Cumprida]"
  },
  Event_22411_Desc = {
    Text = "Armadilhas baratas, mas eficazes!"
  },
  Event_22411_Name = {
    Text = "Fabricar uma armadilha"
  },
  Event_24254_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24254_Desc = {
    Text = "A tempestade de sabedoria espiritual envolveu Tulu, e você trocou um olhar com ele antes de entrar na escuridão"
  },
  Event_24254_Name = {
    Text = "Vindo do mar"
  },
  Event_24255_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24255_Desc = {
    Text = "A tempestade de sabedoria espiritual envolveu Tulu, e a tristeza e culpa persistentes se espalharam pelo espaço"
  },
  Event_24255_Name = {
    Text = "Enfrentar o abismo"
  },
  Event_24256_ChoiceDesc1 = {
    Text = "[Segurar o Tentáculo] Aceite a ajuda de Tulu"
  },
  Event_24256_Desc = {
    Text = "Sua majestade abalava o domínio à sua frente como um gigante caindo no mar.\nAquela força era ancestral, antiga, capaz de transcender os eons.\nFelizmente, você não será seu inimigo, pelo menos por agora"
  },
  Event_24256_Name = {
    Text = "Vindo do mar"
  },
  Event_24257_ChoiceDesc1 = {
    Text = "[Segurar o Tentáculo] Viaje com Tulu"
  },
  Event_24257_Desc = {
    Text = "Tulu respirou fundo e olhou para Miryam a distância.  \nComo se estivesse relembrando a história, as pessoas do passado, sua própria vida...  \nA expressão complexa em seu rosto durou apenas um breve momento antes de desviar o olhar de Miryam.  \n\"Vamos, saia dela.\""
  },
  Event_24257_Name = {
    Text = "Enfrentar o abismo"
  },
  Event_24277_ChoiceDesc1 = {
    Text = "[Close the Hatch]"
  },
  Event_24277_Desc = {
    Text = "Ramona segurou o estudante que entrou pela porta.\nA Guardiã do Segredo, corajosa e forte, parecia indistinta em seus olhos azuis por trás dos óculos, apesar de sua aparência desleixada.\nSó ao segurar a mão, Ramona confirmou: vocês se reencontraram"
  },
  Event_24277_Name = {
    Text = "Reencontro Alegre"
  },
  Event_24278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24278_Desc = {
    Text = "Ramona não te deu chance de explicar, puxou você para dentro da cabine escura e fechou a porta com cuidado"
  },
  Event_24278_Name = {
    Text = "Reencontro Alegre"
  },
  Event_24540_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24540_Desc = {
    Text = "\"Ela é seu escudo robusto, a espada em sua mão. \nEla é sua parceira, sua companheira, sua amiga de confiança—não importa como ela mude.\""
  },
  Event_24540_Name = {
    Text = "Uma presença estranha e familiar"
  },
  Event_24541_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24541_Desc = {
    Text = "\n\"É você... Não, não pode ser. Esta reencarnação de você já... E eu, também, já...\" \nA voz desapareceu junto com a figura, deixando apenas a tristeza pairando na névoa."
  },
  Event_24541_Name = {
    Text = "Figura familiar, mas estranha"
  },
  Event_24542_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24542_Desc = {
    Text = "\"Para o mundo, para a humanidade, para tudo o que valorizamos. \n Claro, e o mais importante—ela é por você.\""
  },
  Event_24542_Name = {
    Text = "Uma presença estranha e familiar"
  },
  Event_24543_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24543_Desc = {
    Text = "Você ainda não se aproximou da sombra e já a notou. Ela parou, como se estivesse chocada ou subitamente mergulhada em uma grande tristeza.\nAntes que você pudesse dizer algo, ela desapareceu junto com a névoa"
  },
  Event_24543_Name = {
    Text = "Figura familiar, mas estranha"
  },
  Event_24544_ChoiceDesc1 = {
    Text = "[Quem é ela?] Obtenha aleatoriamente 3 cartões de comando do baralho e escolha 1 para copiar."
  },
  Event_24544_ChoiceDesc2 = {
    Text = "[Por que Ela se tornou assim?] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_24544_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_24544_Desc = {
    Text = "Outra névoa, outra figura. Desta vez, você vê claramente.\nA mesma aparência, uniforme e rosto que o seu.\n\"Você sabe por que está aqui,\" diz a figura, \"assim como sabe por que ela se tornou assim.\""
  },
  Event_24544_Name = {
    Text = "Uma presença estranha e familiar"
  },
  Event_24545_ChoiceDesc1 = {
    Text = "[Console] Obter Relíquia de Prata \"(RelicConfig.Arg1)\", infectada com \"(Skill.Arg2)\""
  },
  Event_24545_ChoiceDesc2 = {
    Text = "\"[Tentando se aproximar] concede a relíquia de prata \"(RelicConfig.Arg1)\" e causa infecção \"(Skill.Arg2)\"\""
  },
  Event_24545_ChoiceDesc3 = {
    Text = "[Vire e Saia] Ganhe 25 sigilos negros"
  },
  Event_24545_Desc = {
    Text = "A névoa cobre seu caminho.\nUma figura aparece na luz difusa, você aperta os olhos, mas não consegue ver seu rosto, apenas ouve sussurros.\n\"Por que... por que não consegui salvar... o destino, realmente não pode ser mudado...\""
  },
  Event_24545_Name = {
    Text = "Figura familiar, mas estranha"
  },
  Event_35039_ChoiceDesc1 = {
    Text = "[Pedir Ajuda ao Parceiro] Obter Gravura avançada 3 para escolher 1"
  },
  Event_35039_ChoiceDesc2 = {
    Text = "[Realizar a Produção] ganha relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_35039_ChoiceDesc3 = {
    Text = "[Guiar a febre] Obter criação[(RelicConfig.Arg1)]"
  },
  Event_35039_Desc = {
    Text = "\"Na 'Guia do Set de Filmagem do Mestre Houdini', está claramente indicado que Casiah, ou seja, eu mesma, como produtora e diretora, tem o dever e o poder de ser responsável por todo o filme. Portanto, corajoso funcionário de Casiah, por favor, escolha sua próxima programação de ações!\"\n\"Programação? Espera, quando eu me tornei seu funcionário?!\"\n\"As oportunidades não devem ser perdidas, não hesite mais!\""
  },
  Event_35039_Name = {
    Text = "O Mito do Produtor"
  },
  Event_35103_ChoiceDesc1 = {
    Text = "[Connect] Restaurar Arg2 Vida [ExDesc1] [ExDesc2]."
  },
  Event_35103_ChoiceDesc2 = {
    Text = "[Meditate] Escolha despertar 1 Despertador."
  },
  Event_35103_ChoiceDesc3 = {
    Text = "[Expelir] Remova até 3 cartões de sintoma, e ganhe Sigilos Negros Arg2."
  },
  Event_35103_Desc = {
    Text = "Você explora na névoa, de repente, o emblema no seu peito emite um fraco brilho prateado. Quem está chamando você do outro lado do comunicador?"
  },
  Event_35103_Name = {
    Text = "Ponto de contato"
  },
  Event_35103_Tips3 = {
    Text = "Nenhuma carta de sintoma disponível"
  },
  Event_35165_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35165_Desc = {
    Text = "Enquanto hesitava, você fez um pedido de comunicação ao misterioso financiador. \n\"Dado que chegamos a este ponto, não há como voltar atrás. Por favor, Lorde, seja generoso...\" \n Do outro lado do comunicador de núcleo de prata, veio uma risada especialmente generosa, e a pessoa finalmente aceitou seu pedido. \n\"Ah, e mais uma coisa... por favor, mantenha isso em segredo de Ramona.\""
  },
  Event_35165_Name = {
    Text = "O Mito do Produtor"
  },
  Event_35236_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35236_Desc = {
    Text = "O que faz um régidor de rodagem? Você tirou um monte de documentos que Casiah havia colocado sem que você percebesse no transferidor de gnosis e começou a olhar atentamente. \n Então, você começou a ter dor de cabeça. \n As perdas causadas por Lotan durante a montagem do set, os lanches consumidos por Aurita e Marrom, os pedidos de reembolso para a compra das bolinhas mágicas de Casiah... cada um dos valores estava na sua frente, e você teve que se agachar no chão para fazer as contas com dor. \n A propósito, o que são as bolinhas mágicas de Casiah?"
  },
  Event_35236_Name = {
    Text = "O Mito do Produtor"
  },
  Event_35259_ChoiceDesc1 = {
    Text = "[Dissipar a Ilusão] Infectar sintoma [ExDesc1][ExDesc2]."
  },
  Event_35259_ChoiceDesc2 = {Text = "[Leave]"},
  Event_35259_Desc = {
    Text = "Rostos borrados aparecem de repente, gemendo desesperadamente ao seu redor"
  },
  Event_35259_Name = {Text = "Ilusão"},
  Event_35497_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35497_Desc = {
    Text = "Por trás do fenômeno frenético, é necessário um impulsionador, e ao mencionar \"impulsionador\", a imagem de uma menina de cabelo verde curto salta à mente. \n \"A primeira intermediária da Universidade de Misag, Hanna Peaslee, está à sua disposição!\" \n \"Se for a primeira solicitação de serviço do Guardião do Segredo, basta pagar o equivalente a três refeições de curry do refeitório!\""
  },
  Event_35497_Name = {
    Text = "O Mito do Produtor"
  },
  Event_35887_ChoiceDesc1 = {Text = "[Avançar]"},
  Event_35887_Desc = {
    Text = "Você levanta a vela, mas não há nada embaixo. Quando percebe, a vela também desapareceu.\nA vela branca e o rosto da garota se tornam uma mensagem, lembrando que você nunca está sozinho, não importa o caminho"
  },
  Event_35887_Name = {
    Text = "Vela Branca Pura"
  },
  Event_35888_ChoiceDesc1 = {
    Text = "[Levantar a Vela]"
  },
  Event_35888_Desc = {
    Text = "Aqui não há vento, mas há um barco de vela branco e imaculado, suas velas se erguem vigorosamente, eretas sobre a serena superfície azul do mar. \n Você vislumbra o rosto de uma menina, suas feições estão borradas, como se através de uma névoa fina ou de uma superfície aquosa em movimento. Sua presença parece isolada de tudo ao seu redor, mas é, sem dúvida, o cerne desta cena. \n Embora sua imagem oscile entre ficar clara ou turva, não há dúvida de que você sabe quem ela é."
  },
  Event_35888_Name = {
    Text = "Vela Branca Pura"
  },
  Event_35894_ChoiceDesc1 = {
    Text = "[Queda Livre] ganha 35 sigilos negros, infecta[(Skill.Arg2)], continua a escolha"
  },
  Event_35894_ChoiceDesc2 = {
    Text = "[Fique Longe]"
  },
  Event_35894_Desc = {
    Text = "A voz da garota se espalhou pelo ar, indistinta como uma bolha"
  },
  Event_35894_Name = {
    Text = "Na fronteira entre a vida e a morte"
  },
  Event_35895_ChoiceDesc1 = {
    Text = "[Ciclo sem fim] ganha 30 sigilos negros, infecta[(Skill.Arg2)], continua a escolha"
  },
  Event_35895_ChoiceDesc2 = {
    Text = "[Fique Longe]"
  },
  Event_35895_Desc = {
    Text = "Os membros pesados, o nevoeiro prende o corpo frágil"
  },
  Event_35895_Name = {
    Text = "Na fronteira entre a vida e a morte"
  },
  Event_35896_ChoiceDesc1 = {
    Text = "[Ler o Caminho dos Predecessores] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_35896_ChoiceDesc2 = {
    Text = "[Escreva seu próprio caminho] Obtenha a relíquia de prata \"(RelicConfig.Arg1)\" e inflinja \"(Skill.Arg2)\"."
  },
  Event_35896_ChoiceDesc3 = {
    Text = "[Stare into Darkness] Ganhe 25 sigilos negros"
  },
  Event_35896_Desc = {
    Text = "Se você estiver explorando sozinho no domínio, não se sentirá tão confiante sobre seu caminho como agora.  \nAs pegadas no domínio se dividiram em três, e cada marca deixada escreve um futuro invisível"
  },
  Event_35896_Name = {Text = "Saída"},
  Event_35897_ChoiceDesc1 = {
    Text = "[Support Her]"
  },
  Event_35897_ChoiceDesc2 = {
    Text = "[Looking at her]"
  },
  Event_35897_Desc = {
    Text = "Ela murmurou, girando até parar na sua frente.\nAlguém perturbou seu descanso, sua consciência foi presa à realidade, mas sua alma permaneceu no reino perdido"
  },
  Event_35897_Name = {
    Text = "Fantasma Perdido"
  },
  Event_35898_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35898_Desc = {
    Text = "Na escuridão caótica, uma série de pegadas borradas se estende, como rastros profundos deixados por um andarilho noturno no deserto invisível"
  },
  Event_35898_Name = {Text = "Saída"},
  Event_35899_ChoiceDesc1 = {
    Text = "[Partir] Escolha 1 de 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_35899_Desc = {
    Text = "Um farol distante se refletiu em seus olhos, erguendo-se solitário na borda da escuridão, emitindo uma luz fraca, mas firme, como um guia no mar noturno, chamando as almas perdidas em busca da paz na outra margem. \n Você não pôde resistir e começou a seguir, no entanto, o chão sob seus pés de repente não era mais firme. \n Você pisou em uma área submersa sob as sombras. A superfície da água era suave como seda, consumindo silenciosamente seus passos."
  },
  Event_35899_Name = {Text = "parpadeio"},
  Event_35900_ChoiceDesc1 = {
    Text = "[Listen to Her]"
  },
  Event_35900_ChoiceDesc2 = {
    Text = "[Ignorar Ela]"
  },
  Event_35900_Desc = {
    Text = "Você vê a fonte da luz, uma figura feminina.\nA luz flui de sua cabeça alienígena, abrindo um caminho para o desconhecido.\n\"Volte... para Li@2a...\""
  },
  Event_35900_Name = {Text = "Luz eterna"},
  Event_35901_ChoiceDesc1 = {
    Text = "[Approach Lighthouse]"
  },
  Event_35901_ChoiceDesc2 = {
    Text = "[Longe do Farol]"
  },
  Event_35901_Desc = {
    Text = "Ao virar a esquina onde a realidade e o sonho se entrelaçam, naquele instante efêmero, uma cena aterrorizante de tempestade se desenrolou diante de mim. \n Parecia ser levantada por uma mão invisível e colossal, o vento rugia como uma besta feroz, levantando poeira e esperanças, o céu estava pesado, opressivamente escuro. \n No coração da tempestade, aquele farol que não deveria existir se erguia, parecendo um produto da fantasia, e ao mesmo tempo como uma relíquia de antigas lendas. Ele emitia uma fraca luz, solitário e resistente, no palco devastado pelo vento."
  },
  Event_35901_Name = {
    Text = "Centro da tempestade"
  },
  Event_35902_ChoiceDesc1 = {
    Text = "[Leave] Ganhar 50 sigilos negros"
  },
  Event_35902_Desc = {
    Text = "\"No Domínio, luzes eternas, fantasmas com tentáculos...\"\nTulu fechou os olhos, ponderando por um momento, e então soltou um profundo suspiro.\n\"O Guardião da Lemúria... um dos meus servos. Ela afinal não conseguiu escapar dos laços de suas obsessões.\""
  },
  Event_35902_Name = {
    Text = "O Afundamento do Sonanir"
  },
  Event_35903_ChoiceDesc1 = {
    Text = "[Toque na Luz Prateada] Ganhe 25 sigilos negros"
  },
  Event_35903_ChoiceDesc2 = {
    Text = "[Talk to Silverlight] Obtenha uma relíquia de prata \"(RelicConfig.Arg1)\", e infecte \"(Skill.Arg2)\""
  },
  Event_35903_Desc = {
    Text = "O comunicador perfeitamente fechado foi forçado a abrir uma fenda, uma luz fraca escapa — provavelmente é a primeira vez que o núcleo de prata se comunica com o mundo exterior desde que foi selado no centro do comunicador"
  },
  Event_35903_Name = {
    Text = "Monumento de mithril"
  },
  Event_35904_ChoiceDesc1 = {
    Text = "[Sair] Obter Criação[(RelicConfig.Arg1)]"
  },
  Event_35904_Desc = {
    Text = "\"Uma mulher com a cabeça iluminada?\" Elton ficou surpreso, claramente, ele tinha ouvido falar das sombras que ocasionalmente apareciam no domínio do cargueiro, mas — \n \"Na noite em que o Sonanir afundou... que foi também a noite em que despertei Celeste, eu vi uma sombra assim na tempestade.\" \n \"Eu não me enganei.\""
  },
  Event_35904_Name = {
    Text = "O Afundamento do Sonanir"
  },
  Event_35905_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35905_Desc = {
    Text = "O caminho à frente no domínio está cheio de perigos e insondável.\nSeus olhos fixam-se no caos invisível, mas antes de ser engolido, Ramona, que lidou com os perseguidores, agarra você e o desvia para outra direção"
  },
  Event_35905_Name = {Text = "Saída"},
  Event_35906_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35906_Desc = {
    Text = "Era o fruto da sua alma misteriosa? Tudo o que está acontecendo é um confronto entre o eu e o superego?\nQuanto mais você pensa, mais alto e claro o ruído na sua mente. Sua visão entra em uma névoa, e antes de ver a pessoa na névoa, sua alma te rejeita"
  },
  Event_35906_Name = {
    Text = "Destino Invertido"
  },
  Event_35907_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35907_Desc = {
    Text = "Flui dentro de você, transformando-se em coragem, sustentando você para atravessar a névoa e rasgar o medo"
  },
  Event_35907_Name = {
    Text = "Seguir a luz"
  },
  Event_35908_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35908_Desc = {
    Text = "À medida que a consciência se concentra e a calma interior dissolve lentamente as ilusões caóticas, elas finalmente recuam como uma maré. \nNo final, o ruído na cabeça também desaparece sem deixar rastro — apenas, quanto você perderá? Não há como saber"
  },
  Event_35908_Name = {
    Text = "Aviso futuro"
  },
  Event_35909_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35909_Desc = {
    Text = "A alma está completamente perdida no zumbido, você se esforça para escapar, tentando decifrar essa dor, mas de qualquer forma, você apenas vagueia na borda da consciência..."
  },
  Event_35909_Name = {
    Text = "Na fronteira entre a vida e a morte"
  },
  Event_35910_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para relíquia de ouro, infecção de[(Skill.Arg1)]"
  },
  Event_35910_Desc = {
    Text = "Você pode sentir cada ponto de luz do farol, queimando e saltando na tempestade, como um chamado da alma, nunca desistindo de guiar o caminho mesmo no medo mais intenso"
  },
  Event_35910_Name = {
    Text = "Centro da tempestade"
  },
  Event_35911_ChoiceDesc1 = {
    Text = "[Leave] Obter 1 de 3 Oração Avançadas"
  },
  Event_35911_Desc = {
    Text = "É um símbolo de esperança, ou um presságio de destruição?\nVocê para de olhar, como se sua existência fosse um sonho bem elaborado"
  },
  Event_35911_Name = {
    Text = "Centro da tempestade"
  },
  Event_35912_ChoiceDesc1 = {
    Text = "[Sinking in confusion] ganha 20 sigilos negros, infecção[(Skill.Arg2)]"
  },
  Event_35912_ChoiceDesc2 = {
    Text = "[Fique Longe]"
  },
  Event_35912_Desc = {
    Text = "Então, uma névoa cinza cobriu seus olhos. Logo percebeu que era sua pálpebra translúcida"
  },
  Event_35912_Name = {
    Text = "Na fronteira entre a vida e a morte"
  },
  Event_35913_ChoiceDesc1 = {
    Text = "[deixar] Despertar 1 Desperto aleatório, infectar[(Skill.Arg1)]"
  },
  Event_35913_Desc = {
    Text = "Um sentimento inexplicável de ressonância surge em seu coração.\nMas a razão lhe diz: ignore-a"
  },
  Event_35913_Name = {Text = "Luz eterna"},
  Event_35914_ChoiceDesc1 = {
    Text = "[Partir] Escolha 1 de 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_35914_Desc = {
    Text = "A linguagem dela nunca foi gravada em nenhuma inscrição conhecida, mas se condensou no ar como o arrependimento e a chamada mais profunda. Assim como se flutuasse de outro lado do tempo, atravessando o sedimentar dos anos, carregando um profundo afeto por um lar distante"
  },
  Event_35914_Name = {Text = "Luz eterna"},
  Event_35915_ChoiceDesc1 = {
    Text = "[segurar a mão dela] transforma 1 relíquia de prata aleatória em relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_35915_ChoiceDesc2 = {
    Text = "[Express Concern] Obter a relíquia de prata \"(RelicConfig.Arg1)\" e ficar infectado com \"(Skill.Arg2)\"."
  },
  Event_35915_ChoiceDesc3 = {
    Text = "[Olhe para Ela] Ganhe 25 Sigilos Negros"
  },
  Event_35915_Desc = {
    Text = "Murphy ficou na última posição do grupo, caminhando ao lado de Celeste no final da fila.\nVocê não pode evitar olhar para ela repetidamente, mas Murphy sempre olhava para a ponta de seus próprios sapatos, escondendo sua expressão no desconhecido"
  },
  Event_35915_Name = {
    Text = "Gestão da dor"
  },
  Event_35915_Tips1 = {
    Text = "Ainda não possui relíquia de prata"
  },
  Event_35916_ChoiceDesc1 = {
    Text = "[Sem Saída] Ganhe 40 de sigilo negro, infecte[(Skill.Arg2)], continue a escolher"
  },
  Event_35916_ChoiceDesc2 = {
    Text = "[Abraço da Realidade] Ganhe 25 Sigilos Negros"
  },
  Event_35916_Desc = {
    Text = "@1@1Renascimento, alma atravessando a borda de @2, mas ainda não totalmente no corpo.\nAs palavras preocupadas de Murphy se afastam de sua consciência, como o lamento de um corvo, ecoando nos ouvidos, mas sempre bloqueadas pela barreira da mente"
  },
  Event_35916_Name = {
    Text = "Na fronteira entre a vida e a morte"
  },
  Event_35917_ChoiceDesc1 = {
    Text = "[deixar] Escolher copiar 1 carta de comando, infectar[(Skill.Arg1)]"
  },
  Event_35917_Desc = {
    Text = "Ela é apenas um fantasma no mundo real, um fragmento antigo que não pode ser tocado, mas também não pode ser esquecido"
  },
  Event_35917_Name = {
    Text = "Fantasma Perdido"
  },
  Event_35918_ChoiceDesc1 = {
    Text = "[Sair] escolha 1 carta dentre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_35918_Desc = {
    Text = "Naquele instante, você ouviu o sutil som de estilhaçamento vindo do fundo da alma. Como uma fumaça que se dispersa gradualmente, a imagem dela começou a se misturar, tornando-se cada vez mais irreal. \n Ela não existe aqui, isso é apenas uma projeção das memórias do Capitão Elton. \n Mas o que permanece em seu coração, a perda e a confusão que pertencem a ela, não é uma farsa."
  },
  Event_35918_Name = {
    Text = "Fantasma Perdido"
  },
  Event_35919_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35919_Desc = {
    Text = [[
No momento do toque, um sentimento complexo surgiu - quente e frio.
Almas esquecidas pelo mundo clamam por eternidade]]
  },
  Event_35919_Name = {
    Text = "Monumento de mithril"
  },
  Event_35920_ChoiceDesc1 = {
    Text = "[Segurar Brasa] Aumente a saúde máxima em Arg1"
  },
  Event_35920_ChoiceDesc2 = {
    Text = "[Encarar o Coração] 2 Cartas de comando aleatórias obtêm Gravura: \"(EnchantConfig.Arg1)\", infectar 2 \"(Skill.Arg2)\""
  },
  Event_35920_Desc = {
    Text = "Nesta grande caça, a perseguição de Goliath é como uma besta feroz na noite sombria, tentando devorar toda a luz da esperança. No entanto, essa perseguição implacável não te congelou, mas acendeu a chispa dentro de você, que se propagou e queimou em seu peito, tornando-se cada vez mais ardente."
  },
  Event_35920_Name = {
    Text = "Seguir a luz"
  },
  Event_35921_ChoiceDesc1 = {
    Text = "[Decipher It] Obtenha aleatoriamente 3 cartas de comando do baralho e escolha 1 para copiar."
  },
  Event_35921_ChoiceDesc2 = {
    Text = "[Tornar-se Isso] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_35921_ChoiceDesc3 = {
    Text = "[Desconsiderar Isso] Ganhar 25 Sigilos Negros"
  },
  Event_35921_Desc = {
    Text = "No instante em que você dá o primeiro passo, uma vibração invisível agarra sua consciência, forçando seus olhos a se fixarem nos limites do domínio de caos e ilusão"
  },
  Event_35921_Name = {
    Text = "Aviso futuro"
  },
  Event_35922_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35922_Desc = {
    Text = "Há cores excêntricas dançando diante de seus olhos, há sons sussurrando ao seu ouvido, ou talvez cenas passageiras e rostos borrados, todos entrelaçados, como se estivessem contando uma história desconhecida após a outra. Essas ilusões fazem você sentir que está gradualmente se separando da realidade, mergulhando em um sonho que é ao mesmo tempo familiar e estranho."
  },
  Event_35922_Name = {
    Text = "Aviso futuro"
  },
  Event_35923_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35923_Desc = {
    Text = "A tremulação não veio de ruídos externos ou vibrações táteis, mas de uma premonição indescritível, profunda no coração. Como um chamado do futuro, pulsando em sua percepção"
  },
  Event_35923_Name = {
    Text = "Aviso futuro"
  },
  Event_35924_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35924_Desc = {
    Text = "A mão dela se moveu involuntariamente em direção ao peito, tentando controlar aquela sensação asfixiante. \n Esse medo a fez morder os lábios, forçando-se a ignorar a dor aguda que devastava seu tórax. Cada pequena distorção no rosto de Murphy era rapidamente disfarçada, escondendo a dor com uma máscara mal feita. \n — Até que você segurou sua mão, e a surpresa se tornou a cor em seu rosto."
  },
  Event_35924_Name = {
    Text = "Gestão da dor"
  },
  Event_35925_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35925_Desc = {
    Text = "\n\"Murphy? Você está bem?\" \n— Ela não respondeu a você. \nA estranheza palpável corroía seu coração, tornando quase impossível para ela respirar."
  },
  Event_35925_Name = {
    Text = "Gestão da dor"
  },
  Event_35926_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35926_Desc = {
    Text = "Você não hesita mais, dá um passo na escuridão desconhecida. Onde você anda, desenha um mapa que se estende em direção à luz"
  },
  Event_35926_Name = {Text = "Saída"},
  Event_35927_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35927_Desc = {
    Text = "\nDiante de você há um fogo pulsante.\nEle é fervente, vivo, envolvendo uma chama fria e tremulante, brilhantemente dissipando aqueles sons discordantes.\nQuando você voltou a si, encontrou Murphy olhando para você com perplexidade —\n\"Você realmente está bem?\""
  },
  Event_35927_Name = {
    Text = "Na fronteira entre a vida e a morte"
  },
  Event_35928_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35928_Desc = {
    Text = "Você sente a consciência começando a se separar, lentamente sendo puxada do corpo.\nÉ como se visse sua alma dançando com a consciência remanescente da prata, e então caindo pesadamente em um abismo invisível...\nLá, existe o puro vazio"
  },
  Event_35928_Name = {
    Text = "Monumento de mithril"
  },
  Event_35929_ChoiceDesc1 = {
    Text = "[Leave] Ganhar 25 sigilos negros"
  },
  Event_35929_Desc = {
    Text = "Antes que você pudesse continuar a investigar a origem da luz, ela de repente tremulou e se despedaçou no ar. \nA luz ondulou em camadas no domínio, se espalhando ao redor. \nE então não deixou nada"
  },
  Event_35929_Name = {Text = "parpadeio"},
  Event_35930_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35930_Desc = {
    Text = "Como isso poderia ser você? \n Se fosse você, por que, quando a tristeza chegou, Ele não te salvou? \n Se fosse você, por que, quando passou por sofrimento, Ele não te ajudou? \n Portanto, tudo não passa de uma ilusão"
  },
  Event_35930_Name = {
    Text = "Destino Invertido"
  },
  Event_35931_ChoiceDesc1 = {
    Text = "[Ask the Captain]"
  },
  Event_35931_ChoiceDesc2 = {Text = "[Ask Tulu]"},
  Event_35931_Desc = {
    Text = "Mais uma vez, você vê a figura misteriosa entrar na parede do navio e desaparecer. O cabelo fluorescente se transforma em tentáculos que caem no chão.\nVocê sabe que, mesmo que ela não seja uma dos Marinheiros, ela tem uma conexão profunda com o Reino Perdido"
  },
  Event_35931_Name = {
    Text = "O Afundamento do Sonanir"
  },
  Event_35932_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35932_Desc = {
    Text = "Você está com medo, tudo é a adrenalina pregando peças.  \nVocê teme que suas decisões machuquem aquelas almas que compartilham a escuridão com você"
  },
  Event_35932_Name = {
    Text = "Seguir a luz"
  },
  Event_35933_ChoiceDesc1 = {
    Text = "[Sem Escapatória] Ganhe 25 de sigilo negro, infecte[(Skill.Arg2)], continue a escolher"
  },
  Event_35933_ChoiceDesc2 = {
    Text = "[Fique Longe]"
  },
  Event_35933_Desc = {
    Text = "Cada nervo clama por @2"
  },
  Event_35933_Name = {
    Text = "Na fronteira entre a vida e a morte"
  },
  Event_35934_ChoiceDesc1 = {Text = "[Chase]"},
  Event_35934_ChoiceDesc2 = {
    Text = "[Ignorar Isso]"
  },
  Event_35934_Desc = {
    Text = "Na distância do domínio secreto, uma luz suave e encantadora brilhou.\nEla cintilava como a luz do sol na água, como estrelas tremeluzentes, ou uma chama...\nQuando você tentou se aproximar, a luz desapareceu.\nEla parecia te atrair, como uma mariposa guiada pelo instinto"
  },
  Event_35934_Name = {Text = "parpadeio"},
  Event_35935_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35935_Desc = {
    Text = "De que adianta se preocupar com isso?\nVocê é uma folha flutuando no ar, o vento do destino te empurra, é só isso"
  },
  Event_35935_Name = {
    Text = "Destino Invertido"
  },
  Event_35936_ChoiceDesc1 = {
    Text = "[Auto-Denegação] Ganhe a relíquia de prata \"(RelicConfig.Arg1)\", infectada com \"(Skill.Arg2)\""
  },
  Event_35936_ChoiceDesc2 = {
    Text = "[Pursue] Obtenha a Relíquia de Ouro \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_35936_ChoiceDesc3 = {
    Text = "[Stop Thinking] Ganhar 25 Sigilos Negros"
  },
  Event_35936_Desc = {
    Text = "O vento da vida sopra a sua alma, fazendo você se agitar no redemoinho da realidade, grudado nas névoas do desconhecido.\nVocê não consegue se conter e pergunta à voz em sua mente: \"Sou eu?\""
  },
  Event_35936_Name = {
    Text = "Destino Invertido"
  },
  Event_36146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36146_Desc = {
    Text = "Murphy finalmente notou seu olhar, talvez estivesse realmente muito intenso.\nEla respirou profundamente algumas vezes, soltando um leve \"hm\" pelo nariz. Por fim, ela puxou Celeste e a seguiu de perto atrás de você"
  },
  Event_36146_Name = {
    Text = "Gestão da dor"
  },
  Event_36722_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36722_Desc = {
    Text = [[
No momento do toque, um sentimento complexo surgiu - quente e frio.
Almas esquecidas pelo mundo clamam por eternidade]]
  },
  Event_36722_Name = {
    Text = "Monumento de Gnosis"
  },
  Event_36723_ChoiceDesc1 = {
    Text = "[Toque isso] Desperte aleatoriamente 1 despertador, infecte[(Skill.Arg1)]"
  },
  Event_36723_ChoiceDesc2 = {
    Text = "[Juntar à Rodada] Ganhe uma Oração de 3 escolhas"
  },
  Event_36723_Desc = {
    Text = "No momento em que você deu um passo, uma fenda silenciosa se abriu no fundo da sua mente. Uma presença indescritível passou pela fenda, perturbando sua mente.\nVocê sente um planeta caótico prateado girando e crescendo dentro de você"
  },
  Event_36723_Name = {
    Text = "Monumento de Gnosis"
  },
  Event_36724_ChoiceDesc1 = {
    Text = "[Follow them] Obtenha a Relíquia de Prata \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_36724_ChoiceDesc2 = {
    Text = "[Acariciá-los] Ganhe Relíquia de Ouro \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_36724_ChoiceDesc3 = {
    Text = "[Não Perturbe] Ganhar 25 Sigilos Negros"
  },
  Event_36724_Desc = {
    Text = "Após virar uma esquina inesperada, uma cena estranha apareceu.\nVárias sombras felinas deslizam indistintamente ao longo do casco frio."
  },
  Event_36724_Name = {
    Text = "gato de barco"
  },
  Event_36725_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36725_Desc = {
    Text = "\"Memória\"não responde. Eles se agarram à parede da cabine, olhando para você até que você contorne a próxima esquina."
  },
  Event_36725_Name = {
    Text = "Dono do Sonanir"
  },
  Event_36726_ChoiceDesc1 = {
    Text = "[Detour] Remova 1 carta de comando e ganhe Arg1 sigilos negros."
  },
  Event_36726_ChoiceDesc2 = {
    Text = "[Perguntar por que afundou] Copiar 1 carta de comando, infectar [(Skill.Arg1)]"
  },
  Event_36726_ChoiceDesc3 = {
    Text = "[Cumprimente os tripulantes] escolhe 1 entre 3 cartas de comando para ganhar uma oração:[(EnchantConfig.Arg1)]"
  },
  Event_36726_Desc = {
    Text = "\nEnquanto você caminha em direção à sala de energia, você encontra algumas \"memórias\" fixadas no domínio novamente.\nElas não são fantasmas, mas meramente os pensamentos persistentes do Capitão Elton sobre a tripulação perdida."
  },
  Event_36726_Name = {
    Text = "Dono do Sonanir"
  },
  Event_36727_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36727_Desc = {
    Text = "\n\"A 'Memória' se desprendeu do fundo, distorcendo seu rosto enquanto soltava um lamento triste. \n—O farol. \n—O farol isolado os conduziu para a tempestade."
  },
  Event_36727_Name = {
    Text = "Dono do Sonanir"
  },
  Event_36728_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36728_Desc = {
    Text = "Você escolheu seguir, seguindo a trilha desenhada por aquelas almas gentis e livres, mesmo que à frente encontrem armadilhas deixadas pela escuridão"
  },
  Event_36728_Name = {
    Text = "gato de barco"
  },
  Event_36729_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36729_Desc = {
    Text = "Não perturbe os mortos, não mexa nas memórias adormecidas"
  },
  Event_36729_Name = {
    Text = "Dono do Sonanir"
  },
  Event_36730_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36730_Desc = {
    Text = "Você sente a consciência começando a se separar, lentamente sendo puxada do corpo.\nÉ como se visse sua alma dançando com o planeta, e então caindo pesadamente em um abismo invisível...\nLá, existe o puro vazio"
  },
  Event_36730_Name = {
    Text = "Monumento de Gnosis"
  },
  Event_36731_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36731_Desc = {
    Text = "Como um ser gentil, eles são um desejo que não é permitido neste domínio, são apenas fantasmas.\nEmbora você tenha consciência disso, ainda sentiu uma leve onda de calor em seu coração"
  },
  Event_36731_Name = {
    Text = "gato de barco"
  },
  Event_36732_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36732_Desc = {
    Text = "Suas silhuetas, borradas como uma pintura a óleo lavada pelas correntes do tempo e do espaço. Pontos negros profundos parecem nuvens flutuando no céu noturno, mas seus olhos se assemelham mais ao brilho de estrelas distantes, emitindo uma luz misteriosa e profunda. \nVocê não consegue resistir à sua sedução, estendendo a mão para tocar um vazio."
  },
  Event_36732_Name = {
    Text = "gato de barco"
  },
  Event_36733_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36733_Desc = {
    Text = "Você sabe que deve continuar, mesmo tropeçando, mesmo caindo"
  },
  Event_36733_Name = {
    Text = "Dor física"
  },
  Event_36734_ChoiceDesc1 = {
    Text = "[Tentar Chamá-lo] Aumenta a Vida Arg1"
  },
  Event_36734_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36734_Desc = {
    Text = "Este é um lugar cheio de desejos escondidos e medos não tocados, uma rica tapeçaria tecida por seus sonhos e memórias"
  },
  Event_36734_Name = {
    Text = "Metamorfose Evolutiva"
  },
  Event_36735_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36735_Desc = {
    Text = "\"Guardião, se você não consegue aguentar, por favor, não suporte a dor sozinho.\"\nVocê não evitará a dor, pois faz parte da vida efêmera.\nVocê não temerá as sombras da noite, pois não teme ser devorado por sua escuridão."
  },
  Event_36735_Name = {
    Text = "Dor física"
  },
  Event_36736_ChoiceDesc1 = {
    Text = "[continuar chamando] Aumentar Arg1 ponto de vida, infectar[(Skill.Arg2)]"
  },
  Event_36736_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36736_Desc = {
    Text = "Rabiscos inocentes formaram este mundo"
  },
  Event_36736_Name = {
    Text = "Metamorfose Evolutiva"
  },
  Event_36737_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36737_Desc = {
    Text = "As orações dos marinheiros ressoam em meus ouvidos, frenéticas e sufocantes.\nMas elas não afetarão sua vontade, de forma alguma"
  },
  Event_36737_Name = {Text = "do mar"},
  Event_36738_ChoiceDesc1 = {
    Text = "[Pegue a foto] escolha 1 de 3 cartas de comando e ganhe oração: [(EnchantConfig.Arg1)]"
  },
  Event_36738_Desc = {
    Text = "Esses olhares são profundos e claros, como luz no fundo do mar, brilhantes e quentes.\nEles não falam nem aparecem, mas você sente sua presença, como uma brisa suave numa noite de verão"
  },
  Event_36738_Name = {
    Text = "Bom espionagem"
  },
  Event_36739_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36739_Desc = {
    Text = "Você se forçou a focar na crise à sua frente, exigindo ignorar a dor"
  },
  Event_36739_Name = {
    Text = "Dor física"
  },
  Event_36740_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36740_Desc = {
    Text = "Isso é a marca da vida, é a prova da existência. Conta histórias, mas sob o furor dessa tempestade, gradualmente perde sua voz"
  },
  Event_36740_Name = {
    Text = "Adeus, Icarus"
  },
  Event_36741_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36741_Desc = {
    Text = "Esses olhares são profundos e claros, como luz no fundo do mar, brilhantes e quentes.\nEles não falam nem aparecem, mas você sente sua presença, como uma brisa suave numa noite de verão"
  },
  Event_36741_Name = {
    Text = "Bom espionagem"
  },
  Event_36742_ChoiceDesc1 = {
    Text = "[Última chamada para ele] Recuperar Arg1 de vida, Infectar[(Skill.Arg2)]"
  },
  Event_36742_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36742_Desc = {
    Text = "Fendas de dor compõem este mundo"
  },
  Event_36742_Name = {
    Text = "Metamorfose Evolutiva"
  },
  Event_36743_ChoiceDesc1 = {
    Text = "[Embrace Pain] Obtenha Relíquia de Prata \"(RelicConfig.Arg1)\", infectado com \"(Skill.Arg2)\""
  },
  Event_36743_ChoiceDesc2 = {
    Text = "[Refuse Pain] Ganhe uma Relíquia de Ouro \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\" e \"(Skill.Arg3)\""
  },
  Event_36743_ChoiceDesc3 = {
    Text = "[Ignorar Dor] Ganhe 25 Sigilos Negros"
  },
  Event_36743_Desc = {
    Text = "A dor é como uma pedra, enraizada na mente. O sofrimento que se espalha é como uma trepadeira, entrelaçando cada centímetro de nervo, distorcendo sua consciência"
  },
  Event_36743_Name = {
    Text = "Dor física"
  },
  Event_36744_ChoiceDesc1 = {
    Text = "[Chamar com Determinação] Aumentar Arg1 Vida, Infectar[(Skill.Arg2)]"
  },
  Event_36744_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36744_Desc = {
    Text = "O desejo de reconhecimento formou este mundo"
  },
  Event_36744_Name = {
    Text = "Metamorfose Evolutiva"
  },
  Event_36745_ChoiceDesc1 = {
    Text = "[Staring at them] escolhe 1 de 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_36745_ChoiceDesc2 = {
    Text = "[Peça ajuda a eles] infecta[(Skill.Arg1)], substitui a oração obtida na opção 1, pode ser usada duas vezes"
  },
  Event_36745_Desc = {
    Text = "Nos cores fluentes do domínio, você sentiu um olhar misterioso, são olhos invisíveis, escondidos nos mistérios das dobras deste domínio.  \nQuando eles olham para você, uma forte vontade se agita dentro de você"
  },
  Event_36745_Name = {
    Text = "Bom espionagem"
  },
  Event_36746_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36746_Desc = {
    Text = "Se você não entender, não sairá deste purgatório caótico.\nQuando as estrelas se refletem na água, os desejos e preces que pulsam sobem lentamente à superfície, mas são engolidos pela escuridão"
  },
  Event_36746_Name = {Text = "do mar"},
  Event_36747_ChoiceDesc1 = {
    Text = "[Chamado urgente] Aumentar Arg1 de vida, infectar[(Skill.Arg2)]"
  },
  Event_36747_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36747_Desc = {
    Text = "Palavras feias formam este mundo"
  },
  Event_36747_Name = {
    Text = "Metamorfose Evolutiva"
  },
  Event_36748_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36748_Desc = {
    Text = "Você está na frente dele, testemunhando sua alma sendo consumida por memórias estranhas"
  },
  Event_36748_Name = {
    Text = "Metamorfose Evolutiva"
  },
  Event_36749_ChoiceDesc1 = {
    Text = "[Tears of Sorrow] Remova 1 carta"
  },
  Event_36749_ChoiceDesc2 = {
    Text = "[That's Blood] Obtenha \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_36749_Desc = {
    Text = "Algumas gotas de líquido se espalharam pelo convés, infiltrando-se silenciosamente nas fendas.\nAs marcas suaves mas decididas, cada uma carregando um significado resoluto, teciam uma imagem de vida e morte, tranquilidade e tumulto, no meio do rugido do vento e dos gemidos do navio"
  },
  Event_36749_Name = {
    Text = "Adeus, Icarus"
  },
  Event_36750_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36750_Desc = {
    Text = "Você olhou fixamente para as manchas que se espalhavam lentamente, tentando identificar sua natureza, mas na fronteira entre o céu e a terra, a diferença entre chuva e sangue se tornou indistinta.\nEles são chuva? São lágrimas do oceano?\nVocê não sabe"
  },
  Event_36750_Name = {
    Text = "Adeus, Icarus"
  },
  Event_36751_ChoiceDesc1 = {
    Text = "[Reject Sync] Obtenha uma relíquia de prata com 3 escolhas"
  },
  Event_36751_ChoiceDesc2 = {
    Text = "[Join Frequency] Obter uma relíquia de prata \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\" e infectar duas vezes com \"(Skill.Arg3)\"."
  },
  Event_36751_Desc = {
    Text = "O murmúrio dos marinheiros se entrelaça com o batimento cardíaco do \"Santo Infante\", formando uma sinfonia secreta, a cada vibração, o vasto universo líquido provoca um uivo"
  },
  Event_36751_Name = {Text = "do mar"},
  Event_36752_ChoiceDesc1 = {
    Text = "[Pegue a foto] escolha 1 de 3 cartas de comando e ganhe oração: [(EnchantConfig.Arg1)]"
  },
  Event_36752_ChoiceDesc2 = {
    Text = "[Check film] infecção[(Skill.Arg1)], trocando a oração obtida na opção 1, pode ser utilizada uma vez"
  },
  Event_36752_Desc = {
    Text = "Eles não têm más intenções, essa sensação é como um instinto, enraizada em seu sangue e ossos. \n Assim, você abaixa a guarda e tenta pedir ajuda a esses vigilantes ocultos: confidencie suas confusões e desejos àquela presença tênue, como se falasse a um velho amigo, de forma genuína e sincera."
  },
  Event_36752_Name = {
    Text = "Bom espionagem"
  },
  Event_36874_ChoiceDesc1 = {
    Text = "[Conte histórias divertidas da escola] Obtenha a relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_36874_ChoiceDesc2 = {
    Text = "[Never been to school] ganha 75 sigilos negros, infecção[(Skill.Arg2)]"
  },
  Event_36874_Desc = {
    Text = "Ao passar por uma ruína, os olhos de Aurita brilharam de repente.\n\"Vovó disse que aqui costumava ser uma escola, mas há muito tempo foi abandonada porque não havia alunos!\"\n\"Aurita nunca foi à escola, e os amigos? Você já foi à escola?\""
  },
  Event_36874_Name = {
    Text = "Alegria Perdida"
  },
  Event_36875_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36875_Desc = {
    Text = "Recebendo uma resposta negativa de sua boca, Aurita balançou a cabeça com descontentamento.\n\"Então, no mundo exterior não há estudantes... Para que foi construída a escola em primeiro lugar?\""
  },
  Event_36875_Name = {
    Text = "Alegria Perdida"
  },
  Event_36876_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36876_Desc = {
    Text = "\"Casa de pobres, camundongo, estátua de cera... Que legal! Uma aventura, é uma aventura!\"\nAurita disse, com um ponto de interrogação invisível flutuando acima de sua cabeça.\n\"Mas, vovó disse que a escola é um lugar que fará Aurita ficar mais inteligente, mas...\"\nAntes que Aurita pudesse continuar pensando, você a empurrou ao redor de mais uma esquina."
  },
  Event_36876_Name = {
    Text = "Alegria Perdida"
  },
  Event_36877_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36877_Desc = {
    Text = "\"Por, por que?\"\nAurita ficou assustada com você, mantendo uma expressão séria ao continuar a te instruir.\n\"Esta é a casa de Aurita, Aurita sabe, a praça — está bem ali dentro!\""
  },
  Event_36877_Name = {
    Text = "Escuridão Invisível"
  },
  Event_36878_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36878_Desc = {
    Text = "\"Eu não quero seguir por este caminho. Aurita sabe de outra forma para a praça?\"\nAurita fez uma expressão de dúvida, mas eventualmente puxou sua capa e te guiou em uma direção diferente."
  },
  Event_36878_Name = {
    Text = "Escuridão Invisível"
  },
  Event_36879_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36879_Desc = {
    Text = "Este é um sonho, apenas um sonho.\nVocê se repete, ou melhor, se consola, enquanto leva Aurita para a escuridão invisível"
  },
  Event_36879_Name = {
    Text = "Escuridão Invisível"
  },
  Event_36880_ChoiceDesc1 = {
    Text = "[Listen to Her] Escolha 1 de 3 cartas de comando para ganhar uma oração: \"(EnchantConfig.Arg1)\", e infecte \"(Skill.Arg2)\""
  },
  Event_36880_ChoiceDesc2 = {
    Text = "[Oponha-se a ela] escolhe despertar 1 despertador, infecta[(Skill.Arg1)]"
  },
  Event_36880_ChoiceDesc3 = {
    Text = "[Negociar com Ela] Ganhe 25 Sigilos Negros"
  },
  Event_36880_Desc = {
    Text = "Aurita puxa sua capa, seguindo suas pegadas passo a passo. \n \"Hmm... está errado! A praça está naquela direção!\" \n Você se vira para olhar na direção que Aurita apontou, e os becos do domínio parecem estar imersos em escuridão. A Lama Corrosiva e os Mutantes se movem e se entrelaçam, arrastando o mundo real para o abismo da queda."
  },
  Event_36880_Name = {
    Text = "Escuridão Invisível"
  },
  Event_37983_ChoiceDesc1 = {
    Text = "[Obter Financiamento] ganha Arg1 o sigilo negro."
  },
  Event_37983_ChoiceDesc2 = {
    Text = "[Secure Funding] Ganhe Arg1 sigilos negros [ExDesc1]."
  },
  Event_37983_Desc = {
    Text = "\"Nenhum senhor deixará um convidado misterioso sem vigilância, quanto mais um monge.\"\nA rainha sentou-se alta em seu Trono, um lampejo de tirania em seus olhos.\n\"Prove sua utilidade, ou então...\"\nUtilidade? Você olha para a terra árida do lado de fora da janela, um pensamento surge de repente: talvez usar seu Conhecimento econômico para ajudar Wanda a administrar a propriedade?\nVocê se esforça para lembrar de seus estudos—em Mythag, economia era apenas uma matéria eletiva menor...\nA paciência se esgotando. A rainha boceja.\n\"Decepcionante. Execute—\"\nNo momento em que a guilhotina desce, os espíritos de Adam Smith, Malthus, David Ricardo e outros grandes predecessores descem à sua mente.\nDivisão do trabalho! Tributação! População, maldita população!\nVocê pode lembrar..."
  },
  Event_37983_Name = {
    Text = "Ordem secreta"
  },
  Event_37984_ChoiceDesc1 = {Text = "[Leave]"},
  Event_37984_Desc = {
    Text = "Você apresenta relutantemente o decreto.\nA rainha dá uma olhada rápida e sorri friamente:\n\"Se isso provar ser inútil, você sabe o que acontecerá.\""
  },
  Event_37984_Name = {
    Text = "Ordem secreta"
  },
  Event_37985_ChoiceDesc1 = {
    Text = "[apresentar o decreto] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_37985_ChoiceDesc2 = {
    Text = "[apresentar o decreto] ganha relíquia amaldiçoada[(RelicConfig.Arg1)]"
  },
  Event_37985_ChoiceDesc3 = {
    Text = "[apresentar o decreto] ganha relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_37985_Desc = {
    Text = "\n\"Depois de tomar meu dinheiro, você deve me servir.\" \nA rainha apoiou o queixo em uma mão, olhando casualmente para você.\nSe ela admite ou não, ela de fato está curiosa sobre isso.\n\"Agora, diga-me seu plano, grande reformador.\""
  },
  Event_37985_Name = {
    Text = "Ordem secreta"
  },
  Event_38700_ChoiceDesc1 = {
    Text = "[Ativar] Restaura Arg2 Vida [ExDesc1]."
  },
  Event_38700_ChoiceDesc2 = {
    Text = "[Meditate] Escolha despertar 1 Despertador."
  },
  Event_38700_ChoiceDesc3 = {
    Text = "[Expelir] Remova até 3 cartões de sintoma, e ganhe Sigilos Negros Arg2."
  },
  Event_38700_Desc = {
    Text = "Você explora na névoa, de repente, o emblema no seu peito emite um fraco brilho prateado. Quem está chamando você do outro lado do comunicador?"
  },
  Event_38700_Name = {
    Text = "Ponto de contato"
  },
  Event_38700_Tips3 = {
    Text = "Nenhuma carta de sintoma disponível"
  },
  Event_38707_ChoiceDesc1 = {
    Text = "[Dissipar a Ilusão] Sintoma infectado."
  },
  Event_38707_ChoiceDesc2 = {
    Text = "[Absorver Ilusão] Perde Arg1 Vida, Ganha Arg2 O Sigilo Negro"
  },
  Event_38707_ChoiceDesc3 = {Text = "[Leave]"},
  Event_38707_Desc = {
    Text = "Rostos borrados aparecem de repente, gemendo desesperadamente ao seu redor"
  },
  Event_38707_Name = {Text = "Ilusão"},
  Event_38715_ChoiceDesc1 = {
    Text = "[Propose Decree] Obtenha a Relíquia de Prata \"(RelicConfig.Arg1)\" e \"(RelicConfig.Arg2)\""
  },
  Event_38715_ChoiceDesc2 = {
    Text = "[apresentar o decreto] ganha relíquia amaldiçoada[(RelicConfig.Arg1)]"
  },
  Event_38715_ChoiceDesc3 = {
    Text = "[apresentar o decreto] ganha relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_38715_Desc = {
    Text = "\n\"Depois de tomar meu dinheiro, você deve me servir.\" \nA rainha apoiou o queixo em uma mão, olhando casualmente para você.\nSe ela admite ou não, ela de fato está curiosa sobre isso.\n\"Agora, diga-me seu plano, grande reformador.\""
  },
  Event_38715_Name = {
    Text = "Ordem secreta"
  },
  Event_40452_ChoiceDesc1 = {
    Text = "[Perguntar sobre a Identidade] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_40452_ChoiceDesc2 = {
    Text = "[Leave] Conceda aleatoriamente 3 Cartões de Comando uma Oração: \"(EnchantConfig.Arg1)\", e infecte-os com \"(Skill.Arg2)\"."
  },
  Event_40452_Desc = {
    Text = "Três fantasmas bloquearam o caminho.\nEles cercaram a mesa de apostas, seus olhos fixos nos dados.\n\"Glug, glug.\"\nOs dados foram lançados e caíram inúmeras vezes.\nEsta é uma aposta interminável."
  },
  Event_40452_Name = {
    Text = "Jogo de Apostas Sem Fim"
  },
  Event_40453_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40453_Desc = {
    Text = "\n\"Olá, nós somos os primeiros, segundos e terceiros maridos de Wanda.\" \n\"O quê? Você pergunta onde está o quarto marido? \nBem... para ser honesto, John não tem senso de humor, então a dama o transformou em um servo cego.\" \n\"Todos nós lamentamos a perda dele. Claro, só um pouquinho.\""
  },
  Event_40453_Name = {
    Text = "Jogo de Apostas Sem Fim"
  },
  Event_40454_ChoiceDesc1 = {
    Text = "[Apertar a Mão] Despertar aleatoriamente 1 Desperto, infectar [(Skill.Arg1)]"
  },
  Event_40454_ChoiceDesc2 = {
    Text = "[Leave] Obter 1 de 3 Orações"
  },
  Event_40454_Desc = {
    Text = "Ao passar por uma cela, uma mão se estendeu de dentro.\n\"Não me deixe, Rebecca...\"\nA voz era velha e seca, como um fole gasto"
  },
  Event_40454_Name = {
    Text = "Prisioneiro"
  },
  Event_40455_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40455_Desc = {
    Text = "A mão transmite uma sensação pegajosa - é lodo de dissolução.\nO proprietário da voz desapareceu sem que você percebesse, escondendo-se nas sombras densas do canto"
  },
  Event_40455_Name = {
    Text = "Prisioneiro"
  },
  Event_40456_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40456_Desc = {
    Text = "Você saiu sem se importar, perdendo a história dramática no verso da carta.\nMas o que importa?\nO vasto oceano, o amanhecer e o crepúsculo, o deserto equatorial...\nVocê encontrará mais e perderá mais"
  },
  Event_40456_Name = {
    Text = "Para minha amada esposa"
  },
  Event_40457_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40457_Desc = {
    Text = "De certo modo, você não é diferente deste prisioneiro.\nAinda não é hora de alertá-los.\nVocê ignora os apelos do prisioneiro e se afasta"
  },
  Event_40457_Name = {
    Text = "Prisioneiro"
  },
  Event_40458_ChoiceDesc1 = {
    Text = "[Rasgar a Carta] escolha uma relíquia para se transformar em relíquia amaldiçoada[(RelicConfig.Arg1)]"
  },
  Event_40458_ChoiceDesc2 = {
    Text = "[Ignore the Letter] Obtenha Relíquia de prata \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_40458_ChoiceDesc3 = {
    Text = "[Reply] Ganhe 25 Sigilos Negros"
  },
  Event_40458_Desc = {
    Text = "Ⅰ. Carta  John Cambrian para Wanda (2 anos antes do Aluvião)\n\nO marido tem o direito de dispor de sua esposa, pelo menos em Cambrian. \nMas eu claramente subestimei o grau da sua Loucura. Agora meus olhos estão quase cegos, e meus membros estão prestes a serem cortados. \nFilha do demônio. Filha do demônio... não, você é o próprio demônio. \nEu te maldiço @1 te maldiço @2 te maldiço te maldiço..."
  },
  Event_40458_Name = {
    Text = "Para minha amada esposa"
  },
  Event_40459_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40459_Desc = {
    Text = "Você usou o método mais simples para quebrar a maldição.\nNada aconteceu. O papel caiu no chão sem vida.\nVocê dá de ombros e sai, mas sente que algo está errado"
  },
  Event_40459_Name = {
    Text = "Para minha amada esposa"
  },
  Event_40460_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40460_Desc = {
    Text = "Você passa pela mesa de jogos sem pensar duas vezes.\nAo sair, os fantasmas falam em uníssono:\n\"Por favor, lembre-se de dar nossos cumprimentos à nossa ex-esposa em comum, Sra. Wanda.\""
  },
  Event_40460_Name = {
    Text = "Jogo de Apostas Sem Fim"
  },
  Event_40461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40461_Desc = {
    Text = "Você escreve cuidadosamente sua resposta no final da carta:\n\"Maldição recebida. Desejando a você tudo de melhor.\"\nQuando o último traço cai, chamas azuis de raiva se acendem no papel.\nVocê junta as cinzas."
  },
  Event_40461_Name = {
    Text = "Para minha amada esposa"
  },
  Event_44187_ChoiceDesc1 = {
    Text = "[Enfrentando a Escuridão][ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc2 = {
    Text = "[Enfrentando a Escuridão][ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc3 = {
    Text = "[Escapar da Escuridão] Ganhe uma Relíquia Dourada aleatória"
  },
  Event_44187_Desc = {
    Text = "A alma diante de você é sombria e suja - luz e escuridão coexistem nela. Elas lutam pela supremacia, e a alma se encontra em confusão. \n \"Eu sinto pena deles, daqueles pobres que perderam tudo, mas este mundo não é assim mesmo? \n \"Para alguém ganhar, alguém deve perder. \n \"Devo abrir mão da minha felicidade pela felicidade dos outros?\""
  },
  Event_44187_Name = {
    Text = "Escuridão Interior"
  },
  Event_44188_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44188_Desc = {
    Text = "\"Este é o meu pecado, meu fardo. Como posso salvá-lo, minha alma contraditória?\""
  },
  Event_44188_Name = {
    Text = "Escuridão Interior"
  },
  Event_44299_ChoiceDesc1 = {
    Text = "[Plea to the Bishop] Purifique uma Relíquia Amaldiçoada. Se não houver Relíquia Amaldiçoada, ganhe uma Relíquia de Ouro aleatória."
  },
  Event_44299_Desc = {
    Text = "\"Eu enganei e trapaceei, consegui a vida que queria - o dinheiro se tornou números, iguarias se tornaram comuns. Nos negócios, sou autoritário; na política, sou implacável. Mas por que, por que não consigo esquecer aquelas pessoas, aquelas a quem eu tirei tudo? Por que não consigo esquecer o desespero em seus rostos? \n \"O álcool só oferece uma fuga temporária, minha alma está se rasgando, a dor quase me afoga. \n \"O que eu devo fazer?\""
  },
  Event_44299_Name = {
    Text = "Culpa e Perdão"
  },
  Event_44301_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44301_Desc = {
    Text = "\"Você anda um caminho de sofrimento, afastando-se da glória do Pai.\n\"Retorno, ovelha perdida. Ouça os ensinamentos do Pai e encontre o caminho certo.\""
  },
  Event_44301_Name = {
    Text = "Culpa e Perdão"
  },
  Event_44395_ChoiceDesc1 = {
    Text = "[Seek External Object] O Bispo leva 1 de seus Sintomas. Você ganha Arg1 Sigilo Negro. Se você não tiver Sintomas, ganha o Sigilo Negro diretamente."
  },
  Event_44395_ChoiceDesc2 = {
    Text = "[Request blood] o bispo suporta 2 sintomas seus, você ganha oração[(EnchantConfig.Arg1)]"
  },
  Event_44395_ChoiceDesc3 = {
    Text = "[Ask for More] O Bispo assume mais Sintomas (pelo menos 4 cartões)"
  },
  Event_44395_Desc = {
    Text = "Uma alma ilusória forma um contorno nebuloso, ajoelhando-se diante do bispo para mostrar seu corpo quebrado e seu coração manchado de negro. \n \"Você me deu orientação, me deu perdão, me deu redenção, mas, oh bispo misericordioso, isso é muito pouco. \n \"Estou em extrema pobreza, doente crônico. Minha vida está por um fio, e você é minha única redenção. Salve-me, bispo, para que eu não sofra mais.\""
  },
  Event_44395_Name = {
    Text = "Bênção do Bispo"
  },
  Event_44396_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_44396_Desc = {
    Text = "O bispo tirou o anel e o broche. As pedras azuis que simbolizam o Pai foram colocadas uma a uma nas mãos da alma, o bispo se curvou e segurou as mãos da alma pobre.\n\"Leve meu ouro e prata, leve todos os meus bens - contanto que você precise. Tenho os ensinamentos do Pai para viver.\""
  },
  Event_44396_Name = {
    Text = "Bênção do Bispo"
  },
  Event_44400_ChoiceDesc1 = {
    Text = "[Afundar] infectar[(Skill.Arg1)], despertar entidade aleatória"
  },
  Event_44400_ChoiceDesc2 = {Text = "[Desista]"},
  Event_44400_Desc = {
    Text = "A alma perdida não quer liberar a escuridão.\nVocê sabe o que a espera. Uma vida absurda está prestes a se desenrolar, e você é o único espectador."
  },
  Event_44400_Name = {
    Text = "Escuridão Interior"
  },
  Event_44401_ChoiceDesc1 = {
    Text = "[Reflexos Rápidos] Ganhar Arg1 sigilos negros"
  },
  Event_44401_ChoiceDesc2 = {
    Text = "[Agarrar Descontroladamente] ganha 3 selecione 1 oração avançada, infecta[(Skill.Arg1)]"
  },
  Event_44401_Desc = {
    Text = "As marcas negras encontradas no domínio podem ser oferecidas como sacrifícios para as marcas de dissolução em troca de criações e outros projetos espirituais. Elas rapidamente se dissiparão em lodo negro após deixar a área atual"
  },
  Event_44401_Name = {
    Text = "Marca Negra"
  },
  Event_44407_ChoiceDesc1 = {
    Text = "[Dissipar a Ilusão] Sintoma infectado."
  },
  Event_44407_ChoiceDesc2 = {
    Text = "[Abraçar a Ilusão] Ganhar 2 sintomas aleatórios e Arg1 Sigilo Negro."
  },
  Event_44407_ChoiceDesc3 = {Text = "[Leave]"},
  Event_44407_Desc = {
    Text = "Rostos borrados aparecem de repente, gemendo desesperadamente ao seu redor"
  },
  Event_44407_Name = {Text = "Ilusão"},
  Event_44445_ChoiceDesc1 = {
    Text = "[Leave] Encontrar farol de busca"
  },
  Event_44445_ChoiceDesc2 = {
    Text = "[Break into Mist] Perder Arg2 Vida"
  },
  Event_44445_ChoiceDesc3 = {
    Text = "[Desprezar o Externo] deduz 5 o sigilo negro, ganha 1[inspiração]"
  },
  Event_44445_Desc = {
    Text = "À frente se encontra uma espessa névoa negra; entrar de forma imprudente trará Clades.\nTalvez você deva encontrar uma \"lanterna\" para dispersar a névoa."
  },
  Event_44445_Name = {
    Text = "desconhecido"
  },
  Event_44469_ChoiceDesc1 = {
    Text = "[Seek Flesh] O Bispo leva 4 Sintomas de você, e você escolhe 1 entre 3 Relíquias de Ouro+."
  },
  Event_44469_ChoiceDesc2 = {
    Text = "[Ask for Blessing] O Bispo leva seus 6 Sintomas, e você recebe um Pêndulo Crono de 3 escolhas."
  },
  Event_44469_ChoiceDesc3 = {Text = "[Return]"},
  Event_44469_Desc = {
    Text = "A alma ilusória forma um contorno difuso, ajoelhando-se diante do bispo, exibindo seu corpo quebrado e um coração negro remanescente. \n \"Você me deu orientação, me deu perdão, me deu redenção, mas, ó bispo misericordioso, isso é muito pouco. \n \"Estou na pobreza extrema, doente crônico. Minha vida está por um fio, e você é minha única salvação. Salve-me, bispo, para que eu não sofra mais.\""
  },
  Event_44469_Name = {
    Text = "Bênção do Bispo"
  },
  Event_44474_ChoiceDesc1 = {
    Text = "[Plea] Receba a Benção do Bispo"
  },
  Event_44474_ChoiceDesc2 = {
    Text = "[Plea] Receba a Benção do Bispo"
  },
  Event_44474_ChoiceDesc3 = {Text = "[Leave]"},
  Event_44474_Desc = {
    Text = "\"Este é o meu pecado, meu fardo. Como posso salvá-lo, minha alma contraditória?\""
  },
  Event_44474_Name = {
    Text = "Escuridão Interior"
  },
  Event_44911_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44911_Desc = {
    Text = "\n\"Tudo, tudo... Isso mesmo, quero tudo...!\" \nA alma estendeu sua mão, agarrando o ar futilemente.\nEla ganhou algo, mas perdeu tudo."
  },
  Event_44911_Name = {
    Text = "O que você obteve"
  },
  Event_44913_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44913_Desc = {
    Text = "\"\"Somente o mais importante... o mais crucial...\"\n A Alma agachou-se, desenterrou um desejo radiante do solo da Ilusão e o segurou em suas palmas."
  },
  Event_44913_Name = {
    Text = "O que você obteve"
  },
  Event_44916_ChoiceDesc1 = {
    Text = "[Agarrar Tudo] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_44916_ChoiceDesc2 = {
    Text = "[Learn to Let Go] Conceda aleatoriamente uma oração a 3 cartões de comando: \"(EnchantConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_44916_Desc = {
    Text = "A alma desvanecida está em agonia.\nEla vagueia, confusa com todas as escolhas e consequências possíveis.\n\"O que devo escolher?\" ela sussurra, \"O que devo fazer?\"\n\"Como posso ter tudo?\""
  },
  Event_44916_Name = {
    Text = "O que você obteve"
  },
  Event_44919_ChoiceDesc1 = {
    Text = "[Introspecção] desperta aleatoriamente 1 despertador, infecta[(Skill.Arg1)]"
  },
  Event_44919_ChoiceDesc2 = {
    Text = "[Look Around] Obtenha uma Oração com 3 escolhas"
  },
  Event_44919_Desc = {
    Text = "A alma flutuante está presa em um dilema.\nEla para, vacilando entre os desejos.\n\"O que eu devo escolher?\" murmura suavemente, \"O que eu devo fazer?\"\n\"Qual é o meu verdadeiro desejo?\""
  },
  Event_44919_Name = {
    Text = "O que você deseja"
  },
  Event_44920_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44920_Desc = {
    Text = "\n\"Você está certo, eu preciso ver, eu preciso ver...\"\nEle baixa a cabeça, as mãos sondando seu tórax, puxando para fora um coração fantasmagórico: uma metade tão negra quanto tinta, a outra metade tão brilhante quanto uma estrela."
  },
  Event_44920_Name = {
    Text = "O que você deseja"
  },
  Event_44921_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44921_Desc = {
    Text = "\n\"Sim, sim... As pessoas dizem que outros podem ser um espelho... Eu preciso ver...\"\nEle se inclinou mais perto, olhando para você com seu rosto sem feições.\n\"Por que você não está perturbado? Tão invejoso, tão invejoso...\""
  },
  Event_44921_Name = {
    Text = "O que você deseja"
  },
  Event_44998_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44998_Desc = {
    Text = "\"Dizem que o sofrimento atual é temporário, e após a morte, eternamente nos alegraremos no abraço do Pai.\n\"Eu não quero esperar até após a morte.\"\nAs Sombras devoram gananciosamente tudo; as almas se apagam, quase se fundindo com a escuridão ao redor.\nVocê quer agir, mas se sente impotente."
  },
  Event_44998_Name = {
    Text = "Escuridão Interior"
  },
  Event_45000_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_45000_Desc = {
    Text = "O bispo cortou sua palma com uma lâmina afiada, e o sangue que pingava na tábua se transformou em uma luz azul curativa, repondo o sangue ausente da alma.\n\"Leve meu sangue, preencha sua vida—se isso é o que você precisa. Isso é o que Deus Pai deseja que eu faça.\""
  },
  Event_45000_Name = {
    Text = "Bênção do Bispo"
  },
  Event_45001_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_45001_Desc = {
    Text = "O bispo retirou sua alma do fundo do peito. Pontos de luz suave se fundiram na placa, transformando-se em uma luz azul curativa, preenchendo todas as fendas da alma. \n \"Receba, este é o presente do Pai Deus, a prova de Seu amor. Que seu corpo esteja saudável, sua alma completa, e que você não sofra mais.\""
  },
  Event_45001_Name = {
    Text = "Bênção do Bispo"
  },
  Event_45002_ChoiceDesc1 = {Text = "[Leave]"},
  Event_45002_Desc = {
    Text = "Você caminhou em direção aos rostos, e quando abriu os olhos novamente, tudo estava escuro. Apenas risadas desconhecidas ecoavam ao redor"
  },
  Event_45002_Name = {Text = "Ilusão"},
  Event_45036_ChoiceDesc1 = {
    Text = "[Delete All Relics]"
  },
  Event_45036_Desc = {
    Text = "\"Este é o meu pecado, meu fardo. Como posso salvá-lo, minha alma contraditória?\""
  },
  Event_45036_Name = {
    Text = "Escuridão Interior"
  },
  Event_45196_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_45196_Desc = {
    Text = "O bispo usou uma lâmina afiada para cortar carne e osso, os ossos pálidos e a carne carmesim se fundiram na placa, transformando-se em uma luz azul curativa, completando os ossos quebrados da alma.\n\"Leve minha carne e meus ossos, preencha seu corpo faltante - contanto que seja o que você precisa. Isso é o que o Pai Deus deseja que eu faça.\""
  },
  Event_45196_Name = {
    Text = "Bênção do Bispo"
  },
  Event_46144_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para relíquia de prata, infecção de[(Skill.Arg1)]"
  },
  Event_46144_Desc = {
    Text = "A figura nebulosa gradualmente se torna clara, não é um Corpo de fusão, nem uma Catástrofe, mas sim Clementine, sem asas e com uma expressão normal. \n \"Que coincidência, você também veio apreciar a luz da lua?\" Ela disse sorrindo, enquanto você sentiu uma onda de tontura, \"Em uma noite de névoa densa, é melhor ter cuidado. \n \"Os pequenos aqui não são muito tranquilos.\""
  },
  Event_46144_Name = {
    Text = "Figura na névoa"
  },
  Event_46145_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para relíquia de ouro, infecção de[(Skill.Arg1)]"
  },
  Event_46145_Desc = {
    Text = "Você permanece impassível. Uma dama aparece de repente no palco.\nEla abre a boca do garoto com força e enfia um bastão de madeira. \n\"Fale, fale para mim.\" \nSangue negro flui da boca do garoto. Ele murmura algo de forma confusa.\n\"Uma canção para mãe...\""
  },
  Event_46145_Name = {
    Text = "Cerimônia Final III"
  },
  Event_47309_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47309_Desc = {
    Text = "Nesse dia, Deus deve punir os filisteus com sua poderosa e firme espada,\npelo crime de assassinato que \"cometeram\".\nO que, você diz que isso não é justo?\nNão, esse é o destino dos predadores"
  },
  Event_47309_Name = {
    Text = "Canção de marinheiro"
  },
  Event_47310_ChoiceDesc1 = {
    Text = "[Keep Listening] Obtenha uma Relíquia Maldita \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_47310_ChoiceDesc2 = {
    Text = "[Partir] 1 Carta de comando aleatória obtém Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_47310_Desc = {
    Text = "Deus disse: Que ele seja chamado de Filisteu. \nQue ele assuma a responsabilidade pelo assassinato, que ele carregue a maldição da ganância. \nQue o caminho que ele percorre brilhe, fazendo com que o abismo pareça como um cabelo branco. \nNo vasto oceano, não há nada mais majestoso do que este grande tubarão. \nQue ele seja temido e respeitado por todas as criaturas, \naté que chegue o momento do Julgamento."
  },
  Event_47310_Name = {
    Text = "Canção de marinheiro"
  },
  Event_47311_ChoiceDesc1 = {
    Text = "[Sair] Infectar[(Skill.Arg1)]"
  },
  Event_47311_ChoiceDesc2 = {
    Text = "[Sair] Infectar[(Skill.Arg1)]"
  },
  Event_47311_ChoiceDesc3 = {
    Text = "[Sair] Infectar[(Skill.Arg1)]"
  },
  Event_47311_Desc = {
    Text = "O menino é um escravo desprezível. \n O mestre o tratava como um filho, mas foi assassinado na cama. \n \"Eu amo você, pai. Eu só não quero ser mais um escravo.\" \n Mais tarde, o menino estava diante do túmulo do \"pai\", lembrando-se das palavras do sacerdote: \n <Small: Não deixe a terra que o gerou. \n Naquele momento, suas mãos estarão cobertas de sangue, e você morrerá sem dignidade. \n Os cães selvagens, abutres e peixes do mar o desprezarão.>\n O menino chamado Com Glen acabou saindo. \n Ele escreverá sua própria história infame."
  },
  Event_47311_Name = {
    Text = "Menino no barril"
  },
  Event_47312_ChoiceDesc1 = {
    Text = "[Vire a página para frente] Obtenha uma relíquia de prata[(RelicConfig.Arg1)] e escolha infectar 1 vez um sintoma"
  },
  Event_47312_ChoiceDesc2 = {
    Text = "[Turn Page Backward] Escolha 1 de 3 cartas de comando para ganhar Oração: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_47312_ChoiceDesc3 = {
    Text = "[Descartar] Ganhar 25 Sigilos Negros"
  },
  Event_47312_Desc = {
    Text = "Você encontrou um livro encadernado em papiro: \n…\n O menino se esconde em um barril, enquanto uma ilha filisteia flutua até ele. \n Ele é fraco, vil e ambicioso. \n Quando a glória do gigante imortal impressiona a todos, \n apenas o menino se esconde nas sombras, não permitindo que essa luz se aproxime dele. \n Mais tarde, ele foi encarregado de uma grande responsabilidade por Goliath. \n Quanto à razão—"
  },
  Event_47312_Name = {
    Text = "Menino no barril"
  },
  Event_47313_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47313_Desc = {
    Text = "O gigante então disse: \n\"Eu o mantenho ao meu lado porque ele é ao mesmo tempo melancólico e cômico.\nE ele nunca poderá me matar.\""
  },
  Event_47313_Name = {
    Text = "Menino no barril"
  },
  Event_47314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47314_Desc = {
    Text = "\nVocê não ouviu a parte final, mas sua letra lhe lembrou de outra canção: \n\"Esse raro tubarão gigante, em meio à tempestade e chuva,\nO oceano é seu lar,\nComo o poder é justiça, ele é o gigante do poder,\nO rei do oceano sem limites.\""
  },
  Event_47314_Name = {
    Text = "Canção de marinheiro"
  },
  Event_47315_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47315_Desc = {
    Text = "Agora não é um bom momento para ler.\nVocê joga o livro de lado, sem ver o final:\n...\nEle se esconde nas sombras, não por inveja.\nMas por puro medo.\nSe ficar na luz, sua alma vil será aniquilada.\nNem cinzas restarão"
  },
  Event_47315_Name = {
    Text = "Menino no barril"
  },
  Event_47463_ChoiceDesc1 = {
    Text = "[Enter Hypnosis] Selecione um Despertador para passar pela Divisão Espiritual, perdendo suas quatro cartas de Comando iniciais."
  },
  Event_47463_Desc = {
    Text = "O médico levanta a cabeça dos volumosos livros: \n \"Você é uma amostra rara, portanto não vou cobrar por você. \n Mas eu preciso de outra recompensa: uma hipnose. \n É um novo método de tratamento que traz uma consciência completamente nua e sem reservas. \n O que acha, está disposto a experimentar?\""
  },
  Event_47463_Name = {
    Text = "\"Cobra Hipnótica\""
  },
  Event_47464_ChoiceDesc1 = {
    Text = "[Memória Brilhante][ExDesc1][ExDesc2]"
  },
  Event_47464_ChoiceDesc2 = {
    Text = "[Memória Desvanecida] Melhore todas as Orações de Conjunto no baralho para Orações de Conjunto Avançadas."
  },
  Event_47464_Desc = {
    Text = "Ela vagueava na praia do mar da consciência.\nAs ondas lambendo seus pés, trazendo memórias dispersas à costa.\nAlgumas brilhantes, outras opacas, e algumas cheirando como a estação das chuvas de Londinium.\nQual memória você escolheria coletar? Ela vagueava na praia do mar da consciência"
  },
  Event_47464_Name = {
    Text = "\"Fusão Principal\""
  },
  Event_47465_ChoiceDesc1 = {
    Text = "[Recusar Tentar] 1 Carta de comando aleatória obtém Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_47465_ChoiceDesc2 = {
    Text = "[Smash Solvent] Purifique a Relíquia de Negentropia"
  },
  Event_47465_ChoiceDesc3 = {
    Text = "[aceitar o experimento] ganha 1 pêndulo crono[(RelicConfig.Arg1)]"
  },
  Event_47465_Desc = {
    Text = "O médico agitou o solvente esmeralda com entusiasmo e disse a ela:\n\"Beba um gole, e você entrará em um sonho lúcido.\nÉ a manifestação psíquica do inconsciente coletivo.\nAgora, você compartilhará o mesmo mar de consciência com incontáveis seres.\nGostaria de experimentar?\""
  },
  Event_47465_Name = {
    Text = "\"Sonho Lúcido\""
  },
  Event_47466_ChoiceDesc1 = {
    Text = "[Responder Voz] Obtenha 1 Cartão de Comando do Despertador Espírito Dividido."
  },
  Event_47466_Desc = {
    Text = "O corpo é uma prisão, encarcerando personalidades fragmentadas.\nA prisão chamada \"24\" está lotada.\n\"Não durma, não fique calmo.\"\nNa escuridão, uma voz sussurra"
  },
  Event_47466_Name = {
    Text = "\"Autoconhecimento\""
  },
  Event_47848_ChoiceDesc1 = {
    Text = "[Close Eyes] Obter 1 dos 3 Relíquias de Ouro"
  },
  Event_47848_ChoiceDesc2 = {
    Text = "[Espiando] Escolha Despertar 2 Despertadores e reduza seu custo de Aritmética em 1."
  },
  Event_47848_ChoiceDesc3 = {
    Text = "[Open Your Eyes] Ganhe as relíquias de prata \"(RelicConfig.Arg1)\", \"(RelicConfig.Arg2)\", e \"(RelicConfig.Arg3)\""
  },
  Event_47848_Desc = {
    Text = "Antes de entrar em hipnose, o médico disse: \n \"Não abra os olhos sem a minha permissão.\" \n Então, ela fechou bem os olhos, respirou... expirou... \n Entre o sono e a vigília, ela parecia ouvir um sussurro \"sssss\". \n Em seguida, ela estava sob um olhar frio— \n Algo estava a observando. \n Devo abrir os olhos e dar uma espiada?"
  },
  Event_47848_Name = {
    Text = "\"Cobra Hipnótica\""
  },
  Event_47876_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47876_Desc = {
    Text = "Ela se abaixou para pegar memórias brilhantes.\nUma, duas... inúmeras alegrias vieram,\nEla abriu os braços e girou ao redor delas"
  },
  Event_47876_Name = {
    Text = "\"Fusão Principal\""
  },
  Event_47877_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47877_Desc = {
    Text = "Ela se abaixou para recolher as memórias apagadas.\nUma, duas... inúmeras pequenas memórias surgiram,\nEla abriu os braços e as abraçou todas."
  },
  Event_47877_Name = {
    Text = "\"Fusão Principal\""
  },
  Event_47878_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47878_Desc = {
    Text = "Você se recusa a se tornar a vítima destes estranhos solventes.\nO doutor parecia desapontado, mas não insistiu.\n\"Eu perdoo a covardia e a visão curta da humanidade.\""
  },
  Event_47878_Name = {
    Text = "\"Sonho Lúcido\""
  },
  Event_47879_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47879_Desc = {
    Text = "Crash! Você quebra a garrafa.\nA solução verde corrói rapidamente o chão.\n\"Bem, isso foi uma ignorância imprudente. Mas espero que não haja uma próxima vez.\nCaso contrário, posso derramar lágrimas de tristeza.\""
  },
  Event_47879_Name = {
    Text = "\"Sonho Lúcido\""
  },
  Event_47880_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47880_Desc = {
    Text = "Você o engoliu.\nGulp, gulp... Bolhas explodiram em seu cérebro e garganta.\nComo pequenas fogos de artifício estourando.\n\"Eu o louvo, valente humano. Você terá a chance de tocar a infinidade.\nE eu serei a testemunha disso.\""
  },
  Event_47880_Name = {
    Text = "\"Sonho Lúcido\""
  },
  Event_47881_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47881_Desc = {
    Text = "Ela abriu os olhos e disse, \n\"Sim, tudo está errado.\nLágrimas devem ser derramadas, e resistência deve ser feita.\"\nNa escuridão, sons de agitação podiam ser ouvidos, sinalizando uma resposta gentil."
  },
  Event_47881_Name = {
    Text = "\"Autoconhecimento\""
  },
  Event_47900_ChoiceDesc1 = {
    Text = "[Ver a serpente] ganha relíquia de ouro +[(RelicConfig.Arg1)]"
  },
  Event_47900_ChoiceDesc2 = {
    Text = "[Veja você] Obter Criação de Culpa[(RelicConfig.Arg1)]"
  },
  Event_47900_Desc = {
    Text = "Pá.\nUm estalo suave a puxou de volta à realidade.\nO médico se aproximou sem que ela percebesse, e seus olhos amarelos cobaltinos estavam entusiasmados.\n\"Me diga, o que você viu agora?\""
  },
  Event_47900_Name = {
    Text = "\"Cobra Hipnótica\""
  },
  Event_47901_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47901_Desc = {
    Text = "Ela abriu os olhos. \n No meio da luz difusa, parecia ver uma enorme serpente branca e tranquila se enroscando e se movendo lentamente na escuridão. \n Ah, e seus olhos - \n eram de um dourado puro, sem um pingo de impureza. \n Sem tristeza, sem alegria, sem qualquer julgamento, \n suficiente para acordar o dorminhoco de um pesadelo de verão."
  },
  Event_47901_Name = {
    Text = "\"Cobra Hipnótica\""
  },
  Event_47909_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47909_Desc = {
    Text = "Ela abriu um olho devagar.\nViu uma luz branca e difusa, movendo-se lentamente na escuridão.\nUm brilho dourado passou rapidamente, como um aviso de sua infração.\nEla não ousou continuar olhando"
  },
  Event_47909_Name = {
    Text = "\"Cobra Hipnótica\""
  },
  Event_47910_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47910_Desc = {
    Text = "Ela seguiu as instruções do doutor e não abriu os olhos por um instante.\nUma brisa fria percorreu o ar ao seu redor, permanecendo em seu rosto por um longo tempo.\nNão se sabe quanto tempo passou, tudo voltou ao normal.\nComo se nada tivesse acontecido"
  },
  Event_47910_Name = {
    Text = "\"Cobra Hipnótica\""
  },
  Event_47911_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47911_Desc = {
    Text = "\"Eu vi... uma cobra muito bonita.\"\nO médico parou por um momento, segurando a caneta. \n\"Que tipo de cobra?\"\n\"Muito bonita! Com o corpo branco e com padrões dourados...\"\nO médico não disse mais nada, e o canto de sua boca se levantou levemente. \n\"Obrigado.\""
  },
  Event_47911_Name = {
    Text = "\"Cobra Hipnótica\""
  },
  Event_47912_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47912_Desc = {
    Text = "Ela olhou fixamente nos olhos amarelos cobaltinos do médico. \n \"Eu vi você se transformar em uma cobra.\" \n \"Oh. Por que você tem certeza de que sou eu?\" \n Porque é misterioso, imóvel, complexo. \n E... \n parece muito cansado, como se tivesse acabado de despertar de um sono profundo que durou mil anos."
  },
  Event_47912_Name = {
    Text = "\"Cobra Hipnótica\""
  },
  Event_47992_ChoiceDesc1 = {
    Text = "[Connect] Restaurar Arg2 Vida."
  },
  Event_47992_ChoiceDesc2 = {
    Text = "[Meditate] Escolha despertar 1 Despertador."
  },
  Event_47992_ChoiceDesc3 = {
    Text = "[Expelir] Remova até 3 cartões de sintoma, e ganhe Sigilos Negros Arg2."
  },
  Event_47992_Desc = {
    Text = "Você explora na névoa, de repente, o emblema no seu peito emite um fraco brilho prateado. Quem está chamando você do outro lado do comunicador?"
  },
  Event_47992_Name = {
    Text = "Ponto de contato"
  },
  Event_47992_Tips3 = {
    Text = "Nenhuma carta de sintoma disponível"
  },
  Event_47993_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47993_ChoiceDesc2 = {
    Text = "[Sair] aleatoriamente 1 carta de comando ganha oração:[(EnchantConfig.Arg1)] e copia 1 versão original dessa carta"
  },
  Event_47993_Desc = {
    Text = "Você aceita o pedido de contato da escola, a voz familiar te acalma. Você se recompõe e segue em frente"
  },
  Event_47993_Name = {
    Text = "Ponto de contato"
  },
  Event_48225_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48225_Desc = {
    Text = "O gatinho lambeu alegremente o dorso da sua mão.\n\"Obrigado, não fique triste por mim.\nAqui, as personalidades estão sempre morrendo e renascendo,\nEu voltarei!\nMiau, miau, miau!\""
  },
  Event_48225_Name = {
    Text = "Última vontade"
  },
  Event_48226_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48226_Desc = {
    Text = "O gatinho achou que você não entendeu, então esfregou sua mão de forma carinhosa.\n\"Se você concordar, eu darei todos os meus petiscos escondidos.\nEles estão bem guardados no bairro Cambrai @2...\""
  },
  Event_48226_Name = {
    Text = "Última vontade"
  },
  Event_48227_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48227_Desc = {
    Text = "Você pediu desculpas sinceras a George.\n\"Hum, pelo menos você tem boas maneiras.\nGeorge vai considerar reduzir a maldição em 10%,\nno máximo 15%—é o limite de George.\""
  },
  Event_48227_Name = {
    Text = "O Fantasma de Jorge"
  },
  Event_48228_ChoiceDesc1 = {
    Text = "[Agree] Obtenha relíquia de ouro \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_48228_ChoiceDesc2 = {
    Text = "[Recuse-a] ganhe 3 seleções de relíquia de ouro, infecção[(Skill.Arg1)]"
  },
  Event_48228_ChoiceDesc3 = {
    Text = "[Silenciar] obtem a relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_48228_Desc = {
    Text = "\"O gatinho 24\" sofreu ferimentos graves e, lutando para falar, lhe diz: \n\"Miau, minha vida está por um fio. \n Eu tenho um amigo, é um bacalhau. \n Se algum dia você o encontrar, diga que eu fui viajar. \n Vou ficar longe por muito, muito tempo. \n Vou trazer muitos fritos sem peixe. \n Certifique-se de contar isso para ele!\""
  },
  Event_48228_Name = {
    Text = "Última vontade"
  },
  Event_48229_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48229_Desc = {
    Text = "O gatinho ficou um pouco desapontado.\nMas ele sempre foi um gatinho obediente e nunca forçou ninguém.\nFinalmente, ele fechou os olhos com arrependimento"
  },
  Event_48229_Name = {
    Text = "Última vontade"
  },
  Event_48230_ChoiceDesc1 = {
    Text = "[Desculpe-se com Isso] Obtenha uma Relíquia de Prata \"(RelicConfig.Arg1)\", infectado com \"(Skill.Arg2)\""
  },
  Event_48230_ChoiceDesc2 = {
    Text = "[Taunt It] Ganhe a Relíquia de Prata \"(RelicConfig.Arg1)\", inflija \"(Skill.Arg2)\""
  },
  Event_48230_ChoiceDesc3 = {
    Text = "[Desconsiderar Isso] Ganhar 25 Sigilos Negros"
  },
  Event_48230_Desc = {
    Text = "Um fantasma, o fantasma de George, paira sobre você.\n\"George morreu sem dignidade.\nMas não importa. George sempre se lembrará dessa humilhação.\nGuardião, você está em grandes problemas, heh heh heh...\""
  },
  Event_48230_Name = {
    Text = "O Fantasma de Jorge"
  },
  Event_48231_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48231_Desc = {
    Text = "\"Hehe, como você ousa zombar do George.\nNão se preocupe, esteja você comendo, dormindo ou cantando...\nGeorge sempre flutuará ao seu redor, lembrando e atormentando você.\nPara que você sempre lembre de seus pecados.\nVocê nunca pegará um fantasma, la la la~\""
  },
  Event_48231_Name = {
    Text = "O Fantasma de Jorge"
  },
  Event_48232_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48232_Desc = {
    Text = "Você avança, deixando a maldição de George para trás.\nPor trás, um som de choro pode ser ouvido; George estava chorando alto.\n\"Uhul... como alguém tão adorável quanto eu poderia acabar sendo—\nRepugnante! Repugnante!\nGeorge prefere morrer sob o chicote da Pandia!\""
  },
  Event_48232_Name = {
    Text = "O Fantasma de Jorge"
  },
  Event_49055_ChoiceDesc1 = {
    Text = "[Chamar Despertador] Deduzir 100 Aliemus de todos os Despertadores e remover 1 Cartão de Sintoma."
  },
  Event_49055_ChoiceDesc2 = {
    Text = "[Luta Desesperada] Recupere Arg1 de vida, infecte 2 cartas [(Skill.Arg2)]"
  },
  Event_49055_ChoiceDesc3 = {
    Text = "[Inserir Chave Prata] Limpe todo o Keyflare"
  },
  Event_49055_Desc = {
    Text = "A piscina de sangue, obscurecida e indistinta, revelou sua verdadeira forma no instante em que você pisou. \n O sangue de cor vermelho-escuro estendeu inúmeros braços, agarrando-se aos seus tornozelos, puxando incessantemente para cima, com a intenção de arrastá-lo para um abismo incognoscível."
  },
  Event_49055_Name = {
    Text = "Bacia de sangue"
  },
  Event_49097_ChoiceDesc1 = {Text = "[Avançar]"},
  Event_49097_Desc = {
    Text = "Seu abdômen se revira, mas milagrosamente se acalma em segundos. Por algum motivo, você parece ouvir outro coração batendo dentro de você"
  },
  Event_49097_Name = {
    Text = "Mãe Nutridora"
  },
  Event_49098_ChoiceDesc1 = {
    Text = "[Beber de Uma Vez] Escolha [ExDesc3] [ExDesc4] Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)] [ExDesc1] [ExDesc2]"
  },
  Event_49098_Desc = {
    Text = "Um vaso de barro antigo observa você através das fendas na baixa parede rochosa.\nA água é o recurso mais precioso no deserto, e o álcool é o elixir do mundo da loucura e alucinação.\nNesse terreno árido, é difícil para uma pessoa ainda com sanidade recusar seu convite"
  },
  Event_49098_Name = {
    Text = "Mãe Nutridora"
  },
  Event_49312_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49312_Desc = {
    Text = "A Chave de Prata brilhou, os braços pareciam ser intimidados por alguma força, recuando para a água da piscina e desaparecendo"
  },
  Event_49312_Name = {
    Text = "Bacia de sangue"
  },
  Event_49313_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49313_Desc = {
    Text = "Você luta com todas as forças, mas afunda cada vez mais, ouvindo murmúrios amaldiçoados na mente.\nQuando volta a si, os tentáculos ensanguentados recuam satisfeitos. Você se sente revigorado, mas parece ter perdido algo"
  },
  Event_49313_Name = {
    Text = "Bacia de sangue"
  },
  Event_49314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49314_Desc = {
    Text = "A entidade despertadora que atendeu imediatamente não hesitou e puxou você da piscina de sangue, seu braço conectado foi rasgado, a água turva espirrou, e inúmeras criaturas indistintas se moviam na água, como se desejassem e devorassem algo"
  },
  Event_49314_Name = {
    Text = "Bacia de sangue"
  },
  Event_49867_ChoiceDesc1 = {
    Text = "Desperta aleatoriamente +50 de loucura"
  },
  Event_49867_Name = {Text = "Evento"},
  Event_49907_ChoiceDesc1 = {
    Text = "[Indagando Verdadeiro ou Falso]"
  },
  Event_49907_ChoiceDesc2 = {
    Text = "[Request a Pat]"
  },
  Event_49907_Desc = {
    Text = "\"Por que você sempre olha curiosamente para minhas hastes? Alguma pergunta?\"\nTáias de repente inclina-se perto do seu ombro, as contas coloridas de mel esfregando suavemente em sua bochecha."
  },
  Event_49907_Name = {
    Text = "Pessoa com chifres"
  },
  Event_49908_ChoiceDesc1 = {Text = "[Look Up]"},
  Event_49908_ChoiceDesc2 = {
    Text = "[Approach Thais]"
  },
  Event_49908_Desc = {
    Text = "A poeira se espalha pelas ruínas, e do lado de fora de uma janela quebrada, Thais aparece de repente. Ela se apoia casualmente no parapeito empoeirado, apontando misteriosamente para a viga acima."
  },
  Event_49908_Name = {
    Text = "Pessoa Furtiva"
  },
  Event_49909_ChoiceDesc1 = {
    Text = "[Sair] escolha 1 carta dentre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_49909_Desc = {
    Text = "Você levantou a cabeça, e tubos de cobre enferrujados se estendiam por todos os lados, como uma enorme teia de aranha cobrindo a cabeça. Uma sombra passou rapidamente, era um gato selvagem à caça ou um monstro escondido na sombra?\nAo olhar novamente, Taias também havia desaparecido"
  },
  Event_49909_Name = {
    Text = "Pessoa Furtiva"
  },
  Event_49910_ChoiceDesc1 = {
    Text = "[Olhe para ela]"
  },
  Event_49910_ChoiceDesc2 = {
    Text = "[Chamar Ela]"
  },
  Event_49910_Desc = {
    Text = "Você se depara novamente com aquele \"fantasma\".\nDesta vez, você já sabe seu nome.\ntáias está embaixo da árvore mãe, orando devotamente à árvore.\nSeu contorno é tênue, e se funde com o fantasma da árvore mãe"
  },
  Event_49910_Name = {
    Text = "Fazedor de desejos"
  },
  Event_49911_ChoiceDesc1 = {
    Text = "[Sair] escolha 1 carta dentre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_49911_Desc = {
    Text = "Você observa a figura de táias ao longe, seu contorno é como um pico sagrado e solene no meio da tempestade do apocalipse, mesmo com a fúria da areia, não diminui sua majestade.\nSuas passadas são lentas e firmes, sua postura é nobre e inviolável, hipnotizando você"
  },
  Event_49911_Name = {Text = "O imortal"},
  Event_49912_ChoiceDesc1 = {
    Text = "[Leave] Escolher copiar um Cartão de Comando"
  },
  Event_49912_Desc = {
    Text = "\n\"O que você acha?\"\nEla sussurra \"shh\", inclinando-se mais perto. Você sente a ponta de seu chifre tocar sua bochecha, deixando uma sensação fria e formigante..."
  },
  Event_49912_Name = {
    Text = "Pessoa com chifres"
  },
  Event_49913_ChoiceDesc1 = {
    Text = "[Partir] Escolha 1 de 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_49913_Desc = {
    Text = "\"Se você quer tocar, diga isso abertamente. Eu te recusaria?\" \n Ela riu suavemente enquanto pegava sua mão, o calor e a suavidade de suas pontas dos dedos fazendo você sentir-se quase enfeitiçado..."
  },
  Event_49913_Name = {
    Text = "Pessoa com chifres"
  },
  Event_49914_ChoiceDesc1 = {
    Text = "[deixar] Escolher despertar 1 Desperto, reduzir custo da carta de despertar em 1, infectar[(Skill.Arg1)]"
  },
  Event_49914_Desc = {
    Text = "Você se ajoelhou junto com os outros.\n\"Eu sabia, eu sabia! A Rainha, Sua Majestade sempre nos protegeu!\"\nO som das lágrimas alegres e longos gritos se misturaram com o vento uivante, ressoando e vibrando através do seu crânio.\nVagueando, um pensamento crucial passou, mas você não conseguiu agarrá-lo."
  },
  Event_49914_Name = {Text = "O imortal"},
  Event_49915_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para relíquia de prata, infecção de[(Skill.Arg1)]"
  },
  Event_49915_Desc = {
    Text = "Você acenou para ela.\n\"O que está fazendo?\" Ramona olhou para você, confusa.\n\"Lá...\"\nAntes que pudesse terminar, a mulher já havia sumido.\nFoi uma ilusão?"
  },
  Event_49915_Name = {
    Text = "Pessoa que joga água"
  },
  Event_49916_ChoiceDesc1 = {
    Text = "[Respond to Her]"
  },
  Event_49916_ChoiceDesc2 = {Text = "[Hesitar]"},
  Event_49916_Desc = {
    Text = "De longe, uma mulher está pegando água na margem do rio.\nParece que ela percebeu seu olhar e acena para você.\nVocê nota que há algo estranho na maneira como ela se vira"
  },
  Event_49916_Name = {
    Text = "Pessoa que joga água"
  },
  Event_49917_ChoiceDesc1 = {
    Text = "[Sair] escolha 1 carta dentre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_49917_Desc = {
    Text = "Enquanto você hesitava, a mulher se virou e saltou para o oásis, desaparecendo.\nVocê mal podia acreditar nos seus olhos... Ela parecia ter cascos de cabra?"
  },
  Event_49917_Name = {
    Text = "Pessoa que joga água"
  },
  Event_49918_ChoiceDesc1 = {
    Text = "[Sair] escolha 1 carta dentre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_49918_Desc = {
    Text = "\"Ó Árvore Mãe, por favor, ouça a oração de @1. Eu me banherei em seu leite e renascerei, tornando-me sua agente, caminhando por você nas areias, permitindo que suas raízes alcancem cada canto de Remouahe...\"\n\nAs orações inocentes alternadas ecoam por todo o espaço."
  },
  Event_49918_Name = {
    Text = "Fazedor de desejos"
  },
  Event_49919_ChoiceDesc1 = {
    Text = "[Leave] Desperte um Despertador aleatório"
  },
  Event_49919_Desc = {
    Text = "O olhar ambíguo e inexplicável de Táias atraiu sua atenção, uma certa força enganosa fez com que você ficasse atordoado, como se estivesse sendo puxado, incapaz de resistir e se aproximar dela. \n \"Na verdade, as coisas invisíveis ainda existem.\" \n Ela sussurrou suavemente em seu ouvido, e você pareceu entender, mas era como se estivesse envolto em um véu branco, sem clareza. \n É uma profecia? De repente, Táias já havia desaparecido."
  },
  Event_49919_Name = {
    Text = "Pessoa Furtiva"
  },
  Event_49920_ChoiceDesc1 = {Text = "[Olhe]"},
  Event_49920_ChoiceDesc2 = {Text = "[Kneel]"},
  Event_49920_Desc = {
    Text = "As patas negras da ovelha pisam na terra cheia de areia.\nNarciso recita uma oração desconhecida, e incontáveis Aram se prostram na direção de onde ela avança"
  },
  Event_49920_Name = {Text = "O imortal"},
  Event_49921_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para relíquia de ouro, infecção de[(Skill.Arg1)]"
  },
  Event_49921_Desc = {
    Text = "A árvore gigante estendeu milhares de galhos robustos, como tentáculos entrelaçados, amarrando firmemente os pulsos e tornozelos de táias, ignorando sua luta e resistência, e brutalmente puxando seu tronco para o interior do abdômen da árvore em expansão…\n\nApesar de ser apenas uma sombra distante, seu sofrimento ainda ressoava em seu coração com as ondas da água."
  },
  Event_49921_Name = {
    Text = "Fazedor de desejos"
  },
  Event_49922_ChoiceDesc1 = {
    Text = "[Sair] Obter Criação[(RelicConfig.Arg1)]"
  },
  Event_49922_Desc = {
    Text = "Os membros moles fluem com a seiva da árvore pelos galhos, ela luta com todas as suas forças, mas os membros se movem como vermes titubantes e distorcidos, desobedecendo. \n \"Os ossos já se dissolveram completamente,\" os olhos e as sobrancelhas de Thais estão manchados de tristeza, \"ela já é parte da árvore.\" \n \"Precisamos da força para reverter isso... a força que transcende o tempo.\""
  },
  Event_49922_Name = {
    Text = "Pessoa Corrosiva"
  },
  Event_49923_ChoiceDesc1 = {
    Text = "[Sair] escolha 1 carta dentre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_49923_Desc = {
    Text = "\"E aquela 'Olho Cego Invertido', por alguma razão, tem um forte poder de convocação originado do fundo do coração...\"\n\"Ah, você está falando sobre mim?\"\n\"MediNight elogia sua capacidade de contar histórias.\"\n\nNaquela noite tranquila ao redor da fogueira, ela já havia servido um copo de vinho para você."
  },
  Event_49923_Name = {
    Text = "Pessoa Corrosiva"
  },
  Event_49924_ChoiceDesc1 = {
    Text = "[Cut the Knurl]"
  },
  Event_49924_ChoiceDesc2 = {Text = "[Memória]"},
  Event_49924_Desc = {
    Text = "Um tumor de árvore.\nEle pulsa com um ritmo maligno e inchado, e através de sua pele frágil e transparente de cor vermelha-sangue, um rosto torcido e doloroso se revela, como se estivesse prestes a se libertar de seu casulo.\n\"Medinite.\" O rosto de Táias mostrou tristeza enquanto ela chamava gentilmente o nome daquele rosto"
  },
  Event_49924_Name = {
    Text = "Pessoa Corrosiva"
  },
  Event_49939_ChoiceDesc1 = {
    Text = "[Trust Ryker] Todos os Despertadores recuperam Arg1 Aliemus"
  },
  Event_49939_ChoiceDesc2 = {
    Text = "[Preocupe-se com Ryker] Despertar 2 Despertadores escolhidos"
  },
  Event_49939_Desc = {
    Text = "\"Confie na minha sorte.\""
  },
  Event_49939_Name = {
    Text = "Detetive da Sorte"
  },
  Event_49940_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49940_Desc = {
    Text = "Ryker só é habilidoso em três coisas: espionagem, escuta e lançamento de dados.\nEm outras palavras, não se destaca em batalha.\nSua preocupação interna é difícil de controlar, e a loucura cresce"
  },
  Event_49940_Name = {
    Text = "Detetive da Sorte"
  },
  Event_49941_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49941_Desc = {
    Text = "A fé é mágica, ele superará todos os obstáculos"
  },
  Event_49941_Name = {
    Text = "Detetive da Sorte"
  },
  Event_49943_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49943_Desc = {
    Text = "Você se sentiu envergonhado, mas ainda olhou para Ramona, que estava doente, com esperança.\n“Deixe comigo.”\nEla corou, tirou um novo frasco de coleta de sua bolsa infinita e rapidamente cobriu a aranha"
  },
  Event_49943_Name = {
    Text = "Aranha venenosa"
  },
  Event_49944_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49944_Desc = {
    Text = "Ryker estalou os dedos e então estendeu o dedo indicador peludo em direção à grande aranha que levantava suas patas dianteiras. \n Essas espécies de padrões coloridos geralmente são altamente venenosas, e você estava prestes a avisá-lo para ter cuidado, mas a aranha, que antes estava cheia de hostilidade, saltou suavemente para a articulação do dedo dele e se enroscou. \n Deixe pra lá, cada um tem seu destino."
  },
  Event_49944_Name = {
    Text = "Aranha venenosa"
  },
  Event_49945_ChoiceDesc1 = {
    Text = "[Look at Ramona] Obtenha 1 entre 3 Orações"
  },
  Event_49945_ChoiceDesc2 = {
    Text = "[Look at Ryker] Escolha 1 de 3 cartas de comando para ganhar uma Oração: \"(EnchantConfig.Arg1)\", e infecte \"(Skill.Arg2)\""
  },
  Event_49945_Desc = {
    Text = "Os olhos compostos se encaram com você. \n O dono dos olhos compostos recuou um passo, ameaçando você com garras e dentes. \n Com suas patas elevadas e apêndices que sustentam seu corpo, parece realmente ser uma criatura aracnídea rara. \n Antes de partir, Czort havia lhe advertido: \"Missão extra, por favor, colete amostras das espécies locais e mantenha-as na estação de pesquisa local.\" \n Você balança o frasco de coleta na mochila, que já está cheio de insetos após semanas de jornada."
  },
  Event_49945_Name = {
    Text = "Aranha venenosa"
  },
  Event_49946_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49946_Desc = {
    Text = "\"A ganância que desconsidera o timing é uma doença.\""
  },
  Event_49946_Name = {
    Text = "Sua resposta"
  },
  Event_49947_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49947_Desc = {
    Text = "\"Recitar o script não vai lhe garantir afeição, criança.\""
  },
  Event_49947_Name = {
    Text = "Sua resposta"
  },
  Event_49948_ChoiceDesc1 = {
    Text = "[Golden Key] Obtenha a Relíquia de Ouro \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_49948_ChoiceDesc2 = {
    Text = "[Chave de Ferro] ganha uma entre 3 relíquias de ouro, infecta[(Skill.Arg1)]"
  },
  Event_49948_ChoiceDesc3 = {
    Text = "[Chave Prata] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_49948_Desc = {
    Text = "Ao meio-dia, a névoa que emana do rio sagrado se condensa em duas sombras vazias. \nA voz etérea das sombras lhe pergunta: Esta é sua chave de ouro, chave de prata ou chave de ferro?"
  },
  Event_49948_Name = {
    Text = "Sua resposta"
  },
  Event_49949_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49949_Desc = {
    Text = "\"A honestidade muitas vezes leva a resultados mais seguros, mas, ao mesmo tempo, você pode perder algo.\""
  },
  Event_49949_Name = {
    Text = "Sua resposta"
  },
  Event_50013_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50013_Desc = {
    Text = "Você observa com atenção, mas o rosto da pessoa flutua nas ondas da água, tornando-se indistinto. \n\n Quanto mais você se concentra, mais sua respiração se torna lenta, e uma sensação de falta de oxigênio inebria seu cérebro, até que você ouve a voz de Ramona chamando por você, sendo puxado de volta à realidade. \n O sol ardente refletido na superfície da água é excepcionalmente ofuscante, mas parece haver algo brilhando sob a superfície."
  },
  Event_50013_Name = {
    Text = "Phantom da Morte"
  },
  Event_50014_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50014_Desc = {
    Text = "O fantasma se desfaz ao toque, sua mão está vazia, apenas uma dor aguda de repente irrompe em sua têmpora.\nO sol refletido na água é extremamente ofuscante, mas parece haver algo brilhando sob a superfície"
  },
  Event_50014_Name = {
    Text = "Phantom da Morte"
  },
  Event_50015_ChoiceDesc1 = {
    Text = "[Strive to Recognize] Obtenha uma Relíquia de Prata \"(RelicConfig.Arg1)\" e torne-se infectado com \"(Skill.Arg2)\""
  },
  Event_50015_ChoiceDesc2 = {
    Text = "[Reach Out and Touch] Ganhe a relíquia de prata \"(RelicConfig.Arg1)\", e contraia \"(Skill.Arg2)\"."
  },
  Event_50015_ChoiceDesc3 = {
    Text = "[Rub Eyes] Ganhe 25 Sigilos Negros"
  },
  Event_50015_Desc = {
    Text = "Núbia te empurra, e uma perna afunda no Rio Sagrado.\nVocê se esforça para se equilibrar, mas vê um reflexo que não deveria estar lá nas águas ondulantes.\nÉ um jovem alto vestindo o uniforme da Universidade de Missaga, seu corpo mole caindo na correnteza do Rio Sagrado"
  },
  Event_50015_Name = {
    Text = "Phantom da Morte"
  },
  Event_50016_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50016_Desc = {
    Text = "O pânico corrói sua mente, a dor torna a consciência turva, você se esforça para se soltar, mas as vinhas apertam cada vez mais, uma substância pegajosa de odor estranho infiltra-se em suas narinas, a cada respiração vem acompanhada de uma desesperança viscosa. \n Ramona desferiu um golpe, Núbia fugiu com uma perna quebrada, você arrancou o último tentáculo que estava grudado ao lado do seu rosto, e ele estava coberto por uma camada de carne e sangue turva."
  },
  Event_50016_Name = {
    Text = "Vento no rosto"
  },
  Event_50017_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50017_Desc = {
    Text = "A luz prateada perfura o corpo de núbia, a sensação de carne explodindo viaja pela chave de prata até suas pontas dos dedos e pulsos.\nOs membros distorcidos de núbia se erguem ao céu, emitindo um grito aterrorizante e lamentoso, transformando-se em uma substância viscosa e obscura"
  },
  Event_50017_Name = {
    Text = "Vento no rosto"
  },
  Event_50018_ChoiceDesc1 = {
    Text = "[Tear] Obtenha relíquia amaldiçoada \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_50018_ChoiceDesc2 = {
    Text = "[Perfurar] 1 Carta de comando aleatória obtém Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_50018_Desc = {
    Text = "Os tentáculos de Núbia se torcem e voam, atacando seu rosto, invadindo violentamente seu nariz e boca"
  },
  Event_50018_Name = {
    Text = "Vento no rosto"
  },
  Event_50019_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50019_Desc = {
    Text = "Na superfície da água, apenas reflexos cintilantes.\nVocê levantou a perna molhada, despejando a areia úmida do sapato.\nA imagem de antes ainda pairava em sua mente, impossível de esquecer"
  },
  Event_50019_Name = {
    Text = "Phantom da Morte"
  },
  Event_50029_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50029_Desc = {
    Text = "\"Ele retornará? Ou ele te abandonará para sempre neste deserto sem fim?\"\n\"Ele pode te encontrar? Ou os ventos e dunas em movimento farão com que ele perca suas coordenadas?\"\n\"A esperança que você deposita nos outros é realmente confiável?\""
  },
  Event_50029_Name = {
    Text = "Ilha Perdida"
  },
  Event_50030_ChoiceDesc1 = {
    Text = "[Buscar Ajuda] Desperte aleatoriamente 1 despertador, infecção[(Skill.Arg1)]"
  },
  Event_50030_ChoiceDesc2 = {
    Text = "[Avançar juntos] escolhe 1 entre 3 cartas de comando para obter a oração:[(EnchantConfig.Arg1)]"
  },
  Event_50030_Desc = {
    Text = "Uma voz antiga e distante se mistura ao som do fluxo da água e pergunta a você. \n \"Você está perdido na vasta areia amarela.\" \n \"Você tem duas opções à sua frente. Seu companheiro é mais rápido, deixe-o levar comida e água para buscar ajuda, enquanto vocês ficam no lugar com o mínimo de consumo.\" \n \"Ou vocês compartilham tudo e continuam em frente.\""
  },
  Event_50030_Name = {
    Text = "Ilha Perdida"
  },
  Event_50031_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50031_Desc = {
    Text = "\"Você pode não ser capaz de ir mais longe, mas seu espírito e carne estão fortemente entrelaçados, extraindo força um do outro.\"\n\"Esta é a sua escolha.\"\nEnquanto dizia isso, o sol escaldante no alto céu fechou os olhos."
  },
  Event_50031_Name = {
    Text = "Ilha Perdida"
  },
  Event_50064_ChoiceDesc1 = {
    Text = "[Cut the Red Ribbon] Remover 1 Carta de Comando, Ganhar Arg1 O Sigilo Negro"
  },
  Event_50064_ChoiceDesc2 = {
    Text = "[Confronto] Copie 1 carta de comando, infecte [(Skill.Arg1)]"
  },
  Event_50064_ChoiceDesc3 = {
    Text = "[Chame Ramona] escolhe 1 entre 3 cartas de comando para ganhar uma oração:[(EnchantConfig.Arg1)]"
  },
  Event_50064_Desc = {
    Text = "Casiah lançou a seda vermelha, envolvendo instantaneamente sua mala"
  },
  Event_50064_Name = {
    Text = "Seda emaranhada"
  },
  Event_50065_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50065_Desc = {
    Text = "O som intermitente de batidas nítidas ecoa entre os canos acima de vocês, como um fantasma dançando sozinho, movendo seus braços fracos neste espaço morto.\nEssa imaginação desperta um medo antigo e frio em seu coração"
  },
  Event_50065_Name = {
    Text = "Escala Sinistra"
  },
  Event_50066_ChoiceDesc1 = {
    Text = "[Explore a entrada] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_50066_ChoiceDesc2 = {
    Text = "[Profundamente na Caverna] Obter Relíquia de Ouro \"(RelicConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_50066_Desc = {
    Text = "\"Aqui há uma caverna.\"\nThais se vira para você e faz um convite.\n\"Quer entrar e dar uma olhada?\"\nA caverna estreita é sombria e profunda, como a enorme boca de um demônio, se estendendo para a escuridão infinita. Quem quer que pise neste lugar desolado não pode escapar da sensação ominosa que se eleva nas profundezas da medula. Parece que em cada canto desta caverna, antigos seres que não ousam olhar para a luz do sol estão à espreita, aguardando a chegada dos intrusos."
  },
  Event_50066_Name = {
    Text = "Caverna escura"
  },
  Event_50067_ChoiceDesc1 = {
    Text = "[Derrubar Um Por Um] um relíquia de prata aleatório é atualizado para relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_50067_ChoiceDesc2 = {
    Text = "[Surrounding Two] Ganhe uma relíquia de prata \"(RelicConfig.Arg1)\" e inflija \"(Skill.Arg2)\"."
  },
  Event_50067_ChoiceDesc3 = {
    Text = "[Escutar] Ganhar 25 Sigilos Negros"
  },
  Event_50067_Desc = {
    Text = "Dois guardas Aram estão vigiando o portão da fábrica.\nUm deles vagueia desinteressadamente, puxando conversa com o outro.\n\"Alguns dizem que Lady Juliette está contando as equipes que tentam romper a Muralha da Tempestade novamente.\"\n\"Eu realmente espero que não seja escolhido.\""
  },
  Event_50067_Name = {
    Text = "Porteiro Descontraído"
  },
  Event_50067_Tips1 = {
    Text = "Ainda não possui relíquia de prata"
  },
  Event_50068_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50068_Desc = {
    Text = "Não olhe, não ouça, não pense.\nNão se pergunte de onde vem aquele tom dissonante, você vai em direção aos restos da árvore mãe"
  },
  Event_50068_Name = {
    Text = "Escala Sinistra"
  },
  Event_50069_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50069_Desc = {
    Text = "Ramona investiu contra Casiah, que empunhava a seda vermelha, Casiah desviou rapidamente, e a seda vermelha ao seu redor se soltou instantaneamente"
  },
  Event_50069_Name = {
    Text = "Seda emaranhada"
  },
  Event_50070_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50070_Desc = {
    Text = "Vocês se dividiram em dois grupos; você e Ramona pela esquerda, Ryker pela direita, atacando pelos lados.\nVocê acenou com a mão, e Ramona e Ryker atacaram juntos; os dois guardas de Aralan caíram silenciosamente ao chão"
  },
  Event_50070_Name = {
    Text = "Porteiro Descontraído"
  },
  Event_50071_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50071_Desc = {
    Text = "Não é hora de se aprofundar na armadilha. Apenas ao ficar na entrada, você já pode sentir o mal pulsando nas rochas"
  },
  Event_50071_Name = {
    Text = "Caverna escura"
  },
  Event_50072_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50072_Desc = {
    Text = "Sob seu sinal, Ryker acertou o guarda de Aran que estava em silêncio com um dado, e então se aproximou furtivamente de outro que ainda estava tagarelando. \n \"Ei, irmão, e se aquela tal de Juliette for uma trapaceira, o que você faria?\" \n \"Eu também não sei o que fazer.\" \n Ryker mostrou os dentes com alegria, o guarda estremeceu, prestes a gritar, foi silenciado por Ryker que cobriu sua boca e nariz."
  },
  Event_50072_Name = {
    Text = "Porteiro Descontraído"
  },
  Event_50073_ChoiceDesc1 = {
    Text = "[Ouvir com Atenção] Escolha 1 de 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_50073_ChoiceDesc2 = {
    Text = "[Cover Ears] Para cada Despertador com Aliemus de 50 ou mais, ganhe 15 Sigilos Negros."
  },
  Event_50073_ChoiceDesc3 = {
    Text = "[Check] Obter Oração de 3 escolhas"
  },
  Event_50073_Desc = {
    Text = "Quando vocês entraram no andar onde estavam os restos, um lindo som de ding-dong ecoou repentinamente na fábrica abandonada, a sensação de um piano tocando era totalmente fora de lugar entre os destroços de ferro enferrujado"
  },
  Event_50073_Name = {
    Text = "Escala Sinistra"
  },
  Event_50074_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50074_Desc = {
    Text = "\"Ei, irmão, e se aquela tal de Lady Juliette for uma mentirosa, o que você faria?\"\n\"Não fale besteira, desde que a Juliette chegou, tudo ficou em ordem. Se ela é uma mentirosa, por que ajudaria tanto as pessoas de Aram?\"\nEnquanto eles conversavam, Ryker silenciosamente escolheu a posição de emboscada, e dois dados voaram, derrubando os dois no chão."
  },
  Event_50074_Name = {
    Text = "Porteiro Descontraído"
  },
  Event_50075_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50075_Desc = {
    Text = "Você reúne coragem e encara de volta. \nO olho gigante da cortina distorce e ri de forma cruel, sua resistência teimosa começa a desmoronar"
  },
  Event_50075_Name = {
    Text = "Olho Mágico"
  },
  Event_50076_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50076_Desc = {
    Text = "Você rasgou a cortina sem hesitar.\nO grande olho se transformou em um pedaço de tecido plano e quebrado em suas mãos"
  },
  Event_50076_Name = {
    Text = "Olho Mágico"
  },
  Event_50077_ChoiceDesc1 = {
    Text = "[Olhe de Volta] Ganhe a Relíquia de Ouro \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\""
  },
  Event_50077_ChoiceDesc2 = {
    Text = "[Rasgar a Cortina] escolha uma carta de comando entre 3 para obter oração:[(EnchantConfig.Arg1)]"
  },
  Event_50077_Desc = {
    Text = "A cortina se abre com inúmeros olhos distorcidos.\nUma massa gigante oculta atrás dos olhos revela uma fome insaciável, pronta para atacar"
  },
  Event_50077_Name = {
    Text = "Olho Mágico"
  },
  Event_50078_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50078_Desc = {
    Text = "Entendi, era uma peça longa e descartada que vocês balançaram, batendo no tubo de ferro"
  },
  Event_50078_Name = {
    Text = "Escala Sinistra"
  },
  Event_50079_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50079_Desc = {
    Text = "Thais entrou calmamente na caverna, e você a seguiu de perto, explorando. \n \"Cuidado!\" Você foi puxado de repente, caindo em um abraço macio. À sua frente, uma enorme criatura negra saiu da caverna com rapidez impressionante. \n \"Olhe aqui,\" Thais disse enquanto você ainda estava atordoado, seus olhos brilhando com uma fraca luz no escuro, \"provavelmente é o tesouro dele.\""
  },
  Event_50079_Name = {
    Text = "Caverna escura"
  },
  Event_50080_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50080_Desc = {
    Text = "Você se agarrou desesperadamente à alça da mala, lutando contra o cetim vermelho.\nMas aquele cetim era imensamente forte; sua mala escapuliu de suas mãos, e os itens se espalharam pelo chão"
  },
  Event_50080_Name = {
    Text = "Seda emaranhada"
  },
  Event_50081_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50081_Desc = {
    Text = "Você odeia a sensação de estar preso.\nVocê puxa o tecido vermelho e o rasga ao meio com um som de \"zla\".\nA metade restante desliza como uma cobra vermelha"
  },
  Event_50081_Name = {
    Text = "Seda emaranhada"
  },
  Event_50276_ChoiceDesc1 = {
    Text = "[Destruir Oferta] Obter relíquia amaldiçoada \"(RelicConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_50276_ChoiceDesc2 = {
    Text = "[Soltar as Cordas] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_50276_ChoiceDesc3 = {
    Text = "[Keep Going] Ganhe 50 Sigilos Negros"
  },
  Event_50276_Desc = {
    Text = "Três Arameus estavam amarrados no altar.\nNeles surgiam padrões escuros semelhantes à casca de árvore que você havia visto em um bebê, murmurando palavras"
  },
  Event_50276_Name = {
    Text = "três oferendas"
  },
  Event_50277_ChoiceDesc1 = {
    Text = "[Stare] Obtenha a Relíquia de Prata \"(RelicConfig.Arg1)\" e torna-se infectado com \"(Skill.Arg2)\"."
  },
  Event_50277_ChoiceDesc2 = {
    Text = "[Ignorar] Receba Oração com 3 escolhas"
  },
  Event_50277_Desc = {
    Text = "Os Aram se agacham na tempestade de areia.\nA tempestade golpeia seus corpos, e a areia arrasta sua devoção.\nNo turbilhão de poeira, parece haver incontáveis olhos gigantes observando a terra distorcida"
  },
  Event_50277_Name = {
    Text = "Gigante de Areia e Poeira"
  },
  Event_50278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50278_Desc = {
    Text = "As imagens que você não quer lembrar aparecem novamente.\nTentáculos balançando, cortes de vidro sangrando...\nVocê começa a vomitar"
  },
  Event_50278_Name = {
    Text = "Jornada Solitária II"
  },
  Event_50279_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50279_Desc = {
    Text = "Ela não está aqui, não está no meio do perigo.\nIsso já é suficiente para te tranquilizar"
  },
  Event_50279_Name = {
    Text = "Jornada Solitária I"
  },
  Event_50280_ChoiceDesc1 = {
    Text = "[Ataque Surpresa] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_50280_ChoiceDesc2 = {
    Text = "[Attack] 3 cartas de comando aleatórias ganham Oração:\"(EnchantConfig.Arg1)\", e são infectadas com \"(Skill.Arg2)\"."
  },
  Event_50280_Desc = {
    Text = [[
Um Nubian lutava na tempestade de areia.
Suas quatro patas estavam profundamente enterradas na areia, tentando evitar ser sugado pelo redemoinho]]
  },
  Event_50280_Name = {
    Text = "Tempestade de areia natural"
  },
  Event_50281_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50281_Desc = {
    Text = "Você entra resolutamente, rasgando as cordas sob os gritos dos Aram.\nUm guerreiro Aram se aproxima cautelosamente, e você arranca a lança das mãos dele, apontando para a multidão obscura"
  },
  Event_50281_Name = {
    Text = "três oferendas"
  },
  Event_50282_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50282_Desc = {
    Text = "A razão diz que ele não voltará.\nSim, quem esperaria que um jogador cumprisse uma promessa?\nVocê só tem a solidão. Você é a solidão"
  },
  Event_50282_Name = {
    Text = "Jornada Solitária III"
  },
  Event_50283_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50283_Desc = {
    Text = "Aquela febre anormal se intensificará com a ressurreição da árvore mãe? \n Ramona pode cuidar de si mesma fora da parede de tempestade? \n Não é hora de se distrair, mas você não consegue evitar se preocupar com seu parceiro"
  },
  Event_50283_Name = {
    Text = "Jornada Solitária I"
  },
  Event_50284_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50284_Desc = {
    Text = "Você decidiu enfrentar diretamente, enquanto Núbia parecia ter encontrado um raro ponto de apoio, saltando e agarrando sua cabeça. \n Você se viu preso em um duplo emaranhado de tempestade de areia e Núbia. \n \"Ser teimoso não é o caminho para a vitória\", as palavras frias de William soaram como uma bênção angelical para você, cujos ouvidos estavam entupidos, \"aprenda a aproveitar as oportunidades.\""
  },
  Event_50284_Name = {
    Text = "Tempestade de areia natural"
  },
  Event_50285_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50285_Desc = {
    Text = "Agora não é hora de ler jornal"
  },
  Event_50285_Name = {
    Text = "Seu lembrete"
  },
  Event_50286_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50286_Desc = {
    Text = "Você não pensa, você não se lembra.\nVocê não quer pensar, você não quer se lembrar.\nA lenda de Missaga pode acabar, mas a jornada de Missaga não vai parar.\nVocê deve continuar. Você deve continuar"
  },
  Event_50286_Name = {
    Text = "Jornada Solitária II"
  },
  Event_50287_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50287_Desc = {
    Text = "\"Prezado Guardião do Segredo: \n Espero que esta carta o encontre bem. \n Sinto muito por não poder estar ao seu lado durante esta viagem a Lemvahi, devido a não cuidar bem do meu corpo. \n Mas, em momentos críticos, acredite em seu único assistente. \n Estarei sempre aqui quando você precisar de mim.\" \n Devido ao tempo, você não pode continuar a ler. \n Mas a caligrafia familiar traz a você uma sensação de tranquilidade e estabilidade."
  },
  Event_50287_Name = {
    Text = "Seu lembrete"
  },
  Event_50288_ChoiceDesc1 = {
    Text = "[Ele voltará] obter relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_50288_ChoiceDesc2 = {
    Text = "[He Won't Come] Obtenha uma relíquia de ouro \"(RelicConfig.Arg1)\" e torne-se infectado com \"(Skill.Arg2)\""
  },
  Event_50288_Desc = {
    Text = "A última a sair foi Ryker.\nPara impedir Casiah, ele optou por ficar na tenda.\nEle lhe prometeu que, por fim, enfrentaria o ritual para queimar a mãe árvore, e o acompanharia sem falta.\nMas agora ele ainda não está ao seu lado.\nDeixando você sozinha"
  },
  Event_50288_Name = {
    Text = "Jornada Solitária III"
  },
  Event_50289_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50289_Desc = {
    Text = "Glub glub, três esferas redondas e aterrorizantes rolam no local do ritual.\nVocê sente que não é mais você mesmo, a atmosfera do ritual enfermamente fanática o envolve em uma ilusão indescritível"
  },
  Event_50289_Name = {
    Text = "três oferendas"
  },
  Event_50290_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50290_Desc = {
    Text = "A fé dos Arlanianos é tão devota que aceitam ser enterrados na areia repetidamente.\nMas quando você olha para cima, não há sol na tempestade"
  },
  Event_50290_Name = {
    Text = "Gigante de Areia e Poeira"
  },
  Event_50291_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50291_Desc = {
    Text = "Que o mar de areia responda à sua devoção"
  },
  Event_50291_Name = {
    Text = "Gigante de Areia e Poeira"
  },
  Event_50292_ChoiceDesc1 = {
    Text = "[Break Free from Memories] Atualize aleatoriamente a qualidade da oração de 1 cartão."
  },
  Event_50292_ChoiceDesc2 = {
    Text = "[Capturar Memórias] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_50292_Desc = {
    Text = "O segundo a partir foi William"
  },
  Event_50292_Name = {
    Text = "Jornada Solitária II"
  },
  Event_50293_ChoiceDesc1 = {
    Text = "[Calm] Ganhe 25 Sinais Negros"
  },
  Event_50293_ChoiceDesc2 = {
    Text = "[Preocupe-se] Ganhe a relíquia de prata \"(RelicConfig.Arg1)\" e fique infectado com \"(Skill.Arg2)\"."
  },
  Event_50293_Desc = {
    Text = "Você de repente se lembra do dia em que começou sua jornada. \n Ramona te lembrou de arrumar suas coisas, William preparou um manual com registros do caminho, e Ryker escondeu uma garrafa de whiskey na sua mochila. \n Agora eles já se foram. \n\n A primeira a sair foi Ramona, o poder de Tawil e a habilidade da parede de tempestade se repeliam, e ela sucumbiu à febre ao longo do caminho."
  },
  Event_50293_Name = {
    Text = "Jornada Solitária I"
  },
  Event_50294_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50294_Desc = {
    Text = "Você atacou o pé de Núbia, ela perdeu o equilíbrio, várias vinhas se agitaram desordenadamente no ar e foram sugadas pela tempestade de areia"
  },
  Event_50294_Name = {
    Text = "Tempestade de areia natural"
  },
  Event_50295_ChoiceDesc1 = {
    Text = "[Ler] Remover 1 Cartão"
  },
  Event_50295_ChoiceDesc2 = {
    Text = "[Put Away] Obtenha \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_50295_Desc = {
    Text = "Clack, clack.\nSob este altar frenético, o som pesado dos tambores vem com o vento do deserto. No meio dos cânticos incessantes, você ouve o leve som de uma máquina de escrever—é o chamado de Missaga, acalmando seu coração inquieto"
  },
  Event_50295_Name = {
    Text = "Seu lembrete"
  },
  Event_50296_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50296_Desc = {
    Text = "Ryker possui uma sorte extraordinária.\nEle cumprirá o que prometeu a você.\nCom certeza"
  },
  Event_50296_Name = {
    Text = "Jornada Solitária III"
  },
  Event_50297_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50297_Desc = {
    Text = "Não tem relação com você.\nO que você mais precisa agora é entrar em contato e destruir os restos da árvore mãe"
  },
  Event_50297_Name = {
    Text = "três oferendas"
  },
  Event_52373_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52373_Desc = {
    Text = "Você sobreviveu. Viu inúmeras montanhas de terra empilhadas, corpos queimados.\nParece que você também queimou algo, mas isso já não importa.\nVocê ouve, o sino do reino de Deus já soou"
  },
  Event_52373_Name = {
    Text = "Invasão da Praga"
  },
  Event_52374_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52374_Desc = {
    Text = "Você sobreviveu. Viu inúmeras montanhas de terra empilhadas, corpos queimados.\nVocê lutou para proteger o que valoriza, e por isso, pagou um preço doloroso. Mas isso já não importa.\nVocê ouve, o sino do reino de Deus já soou"
  },
  Event_52374_Name = {
    Text = "Invasão da Praga"
  },
  Event_52375_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52375_Desc = {
    Text = "A fúria do gigante diminuiu temporariamente. As nuvens se dissiparam, a chuva cessou, e o vento ficou calmo. O oceano, como uma eterna mãe carinhosa, acaricia suavemente as costas de Lemúria com suas marés gentis. Apenas restaram em Lemúria, corpos em estado de decomposição e ruínas. \n Você lutou para proteger o que valoriza, e por isso, pagou um preço doloroso. Mas isso já não importa. \n No oceano, você espiou o contorno do Reino Divino."
  },
  Event_52375_Name = {
    Text = "O Rugido do Oceano"
  },
  Event_52376_ChoiceDesc1 = {
    Text = "[sacrifício adicional] Remova 1 carta de comando e adicione 1 carta de cada um dos 3 tipos de[reino de Deus fantasma] ao baralho"
  },
  Event_52376_Desc = {
    Text = "De pé diante do trono desmoronado de Lemúria, você oferece seu último sacrifício. \nUm abismo sem fim se revela diante de você. Você se prostra, sorri, lágrimas escorrem. \n\"Veja, pai, Debora. Veja, meu supremo rei - o reino de Deus chegou diante de mim!\""
  },
  Event_52376_Name = {
    Text = "Bem-vindo, Reino Divino"
  },
  Event_52377_ChoiceDesc2 = {
    Text = "[Proteja o Que Você Aprecia] Perder Arg1 Vida, ganhar 1 carta de sintoma aleatória."
  },
  Event_52377_Desc = {
    Text = "Terra. A terra silenciosa, a terra estável. A terra que sustenta a humanidade, a terra eterna e imortal. Mas a terra está tremendo. Ela se fende com uma fenda sem fundo, tudo o que sustenta está instável. \n Você deposita todas as suas esperanças na terra, quando a terra começa a tremer, para onde você irá? \n Sacrifício, o povo de Lemúria clama a você. Sacrifique tudo o que tem, para que o reino divino sem desastres chegue."
  },
  Event_52377_Name = {
    Text = "Tremor da Terra"
  },
  Event_52378_ChoiceDesc2 = {
    Text = "[Proteja o Que Você Aprecia] Perder Arg1 Vida, ganhar 1 carta de sintoma aleatória."
  },
  Event_52378_Desc = {
    Text = "Oceano. O oceano é a mãe que gerou Lemúria, é a sua vida, a sua fé. E neste momento, o oceano se ergue como o gigantesco deus furioso das lendas. Ele grita, clama, transformando as suaves águas do mar em rochas duras e espinhos afiadas, golpeando tudo à sua frente. Ele observa friamente os trêmulos Lemurianos aos seus pés, olhando para aqueles que correm como insetos. Ele destruirá Lemúria, que não tem nada a ver com Lemúria. \n Sacrifique, o povo de Lemúria clama por você. Sacrifique tudo o que tem, para que o reino divino sem calamidade chegue."
  },
  Event_52378_Name = {
    Text = "O Rugido do Oceano"
  },
  Event_52379_ChoiceDesc2 = {
    Text = "[Proteja o Que Você Aprecia] Perder Arg1 Vida, ganhar 1 carta de sintoma aleatória."
  },
  Event_52379_Desc = {
    Text = "Praga. A praga está em toda parte. A praga é o mais vergonhoso dos servos, quando a punição dos deuses sobre a terra e o oceano passa, ela pronuncia a sentença da morte que não pode ser expressa em palavras. Enterrar os corpos dos entes queridos, queimar os corpos dos entes queridos, orar para que aqueles que morreram para proteger a si mesmos se afastem cada vez mais. A vida e a humanidade não resistem diante da praga. \n Sacrifique, povo de Lemuria, eles chamam por você. Sacrifique tudo o que você tem, para que o reino divino sem desastres chegue."
  },
  Event_52379_Name = {
    Text = "Invasão da Praga"
  },
  Event_52380_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52380_Desc = {
    Text = "A forte tremulação cessou. As ruas estavam manchadas com sangue carmesim, e inúmeras pessoas foram enterradas sob as casas desabadas. \n Você lutou para proteger o que valoriza, e por isso, pagou um preço doloroso. Mas isso já não importa. \n O único importante é que você está um passo mais perto do Reino Divino."
  },
  Event_52380_Name = {
    Text = "Tremor da Terra"
  },
  Event_52381_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52381_Desc = {
    Text = "De pé diante do trono desmoronado de Lemúria, você recita sua última oração. \nUm abismo sem fim se revela diante de você. Você se prostra, sorri, lágrimas escorrem. \n\"Veja, pai, Debora. Veja, meu supremo rei - o reino de Deus chegou diante de mim!\""
  },
  Event_52381_Name = {
    Text = "Bem-vindo, Reino Divino"
  },
  Event_52382_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52382_Desc = {
    Text = "A forte tremulação cessou. As ruas estavam manchadas com sangue carmesim, e inúmeras pessoas foram enterradas sob as casas desabadas. \n Algo seu também parece estar enterrado sob os escombros, mas isso já não importa. \n O único importante é que você está um passo mais perto do Reino Divino."
  },
  Event_52382_Name = {
    Text = "Tremor da Terra"
  },
  Event_52383_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52383_Desc = {
    Text = "A fúria do gigante se acalmou temporariamente. As nuvens se dissiparam e a chuva cessou, o vento está calmo e o mar tranquilo. O oceano, como uma mãe eterna, acaricia suavemente as costas de Lemúria com suas marés suaves. Apenas restam em Lemúria os corpos em decomposição e os destroços. \n Algo seu parece ter encontrado seu fim no mar, mas isso já não importa. \n No oceano, você espiou o contorno do Reino Divino."
  },
  Event_52383_Name = {
    Text = "O Rugido do Oceano"
  },
  Event_52384_ChoiceDesc1 = {
    Text = "[Devout Prayer] Transforme cada carta de sintoma comum no baralho em 1 \"Fantasma do Reino de Deus\" e ganhe 2 \"Fantasmas do Reino de Deus\" adicionais."
  },
  Event_52384_ChoiceDesc2 = {
    Text = "[Devout Prayer] Transforme cada carta de sintoma comum no baralho em 1 \"Fantasma do Reino de Deus\" e ganhe 2 \"Fantasmas do Reino de Deus\" adicionais."
  },
  Event_52384_Desc = {
    Text = "A Terra não treme mais, o oceano não ruge mais, a peste não ataca mais. O desastre destruiu Lemúria, deixando você. Você levanta a cabeça e observa ao seu redor, tudo está devastado. Você olha para suas mãos, estão vazias. \n Mas e daí, respeitável Grande Sacerdote? Pise sobre os destroços e os corpos de Lemúria, continue a rastejar para frente. \n Você está a um passo de distância do Reino Divino."
  },
  Event_52384_Name = {
    Text = "Bem-vindo, Reino Divino"
  },
  Event_53140_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53140_Desc = {
    Text = "Você aceita o pedido de contato da escola, a voz familiar te acalma. Você se recompõe e segue em frente"
  },
  Event_53140_Name = {
    Text = "Ponto de contato"
  },
  Event_53141_ChoiceDesc1 = {
    Text = "[Connect] Restaurar Arg2 Vida."
  },
  Event_53141_ChoiceDesc2 = {
    Text = "[Meditate] Escolha despertar 1 Despertador."
  },
  Event_53141_ChoiceDesc3 = {
    Text = "[Expelir] Remova até 3 cartões de sintoma, e ganhe Sigilos Negros Arg2."
  },
  Event_53141_ChoiceDesc4 = {
    Text = "[Fall into Madness] Despertar aleatoriamente 2 Despertadores e ganhar 1 Sintoma aleatório."
  },
  Event_53141_ChoiceDesc5 = {
    Text = "[Hesitação] Outros"
  },
  Event_53141_Desc = {
    Text = "Você explora na névoa, de repente, o emblema no seu peito emite um fraco brilho prateado. Quem está chamando você do outro lado do comunicador?"
  },
  Event_53141_Name = {
    Text = "Ponto de contato"
  },
  Event_53141_Tips3 = {
    Text = "Nenhuma carta de sintoma disponível"
  },
  Event_53142_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53142_Desc = {
    Text = "Você aceita o pedido de contato da escola, a voz familiar te acalma. Você se recompõe e segue em frente"
  },
  Event_53142_Name = {
    Text = "Ponto de contato"
  },
  Event_53143_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53143_Desc = {
    Text = "Você aceita o pedido de contato da escola, a voz familiar te acalma. Você se recompõe e segue em frente"
  },
  Event_53143_Name = {
    Text = "Ponto de contato"
  },
  Event_53147_ChoiceDesc1 = {
    Text = "[Expelir] Remova até 3 cartões de sintoma, e ganhe Sigilos Negros Arg2."
  },
  Event_53147_ChoiceDesc2 = {
    Text = "[Fall into Madness] Despertar aleatoriamente 2 Despertadores e ganhar 1 Sintoma aleatório."
  },
  Event_53147_Desc = {
    Text = "Você explora na névoa, de repente, o emblema no seu peito emite um fraco brilho prateado. Quem está chamando você do outro lado do comunicador?"
  },
  Event_53147_Name = {
    Text = "Ponto de contato"
  },
  Event_53147_Tips1 = {
    Text = "Nenhuma carta de sintoma disponível"
  },
  Event_53148_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53148_Desc = {
    Text = "Você estabeleceu comunicação. Do outro lado, uma voz louca e hipnotizante soou.\n\"Memorize isso. Esta é a bênção que o Reino de Deus lhe concede.\""
  },
  Event_53148_Name = {
    Text = "Ponto de contato"
  },
  Event_55782_ChoiceDesc1 = {
    Text = "[Corte os espinhos] Na próxima batalha, a vida do inimigo aumenta 30%, dano aumenta 15%, obter Arg1 Cartas de Imagem[(Skill.Arg2)]"
  },
  Event_55782_ChoiceDesc2 = {
    Text = "[Corte os espinhos] Na próxima batalha, a vida do inimigo aumenta 30%, dano aumenta 15%, obter Arg1 Cartas de Imagem[(Skill.Arg2)]"
  },
  Event_55782_ChoiceDesc3 = {
    Text = "[Separar os Espinhos] Infectar \"(Skill.Arg3)\", e colocar Arg1 \"Imagética\" \"(Skill.Arg2)\" no baralho."
  },
  Event_55782_ChoiceDesc4 = {
    Text = "[Separar os Espinhos] Infectar \"(Skill.Arg3)\", e colocar Arg1 \"Imagética\" \"(Skill.Arg2)\" no baralho."
  },
  Event_55782_ChoiceDesc5 = {
    Text = "[Leave the Thorns] \"Caneta e Tinta de Horla\" ganha Arg1 camada de \"Caneta e Tinta.\""
  },
  Event_55782_Desc = {
    Text = "Algo tocou seu coração. Você parou e olhou para o canto do jardim. Sob os espinhos, um ponto de luz estava se movendo, tentando se libertar.\nO que é isso? Borboleta? Pássaro? Você se aproxima"
  },
  Event_55782_Name = {
    Text = "Bênção de muzu"
  },
  Event_55782_Tips1 = {
    Text = "Na próxima batalha, os inimigos estarão fortalecidos, não pode ser escolhido novamente"
  },
  Event_55783_ChoiceDesc1 = {
    Text = "[Create Offering] Escolha 3 cartas \"Imagem\" e deixe Horla criar uma \"Oferta\" para você."
  },
  Event_55783_ChoiceDesc2 = {Text = "[Leave]"},
  Event_55783_Desc = {
    Text = "Você chegou à frente de uma bela estufa, e através da janela, você olhou para dentro, mas não conseguiu ver nada. \n Um vento soprou, e as pétalas e folhas dentro da estufa foram levadas pelo vento, dançando e se reunindo no ar. Entre as flores e as folhas, você viu a silhueta de uma menina. \n \"Ah! Um visitante no jardim de flores!\" A menina olhou para você com surpresa e nervosismo. \"Desculpe, Colette saiu... Não sei o preço dessas flores...\" \n A menina de repente parou, aproximou-se de você e olhou com atenção. \"Ah, este visitante, eu sinto a imagem da poesia em você... talvez, possamos criar um poema juntos?\""
  },
  Event_55783_Name = {
    Text = "Presente da Primavera"
  },
  Event_55783_Tips1 = {
    Text = "\"Inspirações Insuficientes\" Pelo menos 3 são necessárias para sintetizar."
  },
  Event_55799_ChoiceDesc1 = {Text = "[Leave]"},
  Event_55799_Desc = {
    Text = "Os espinhos revividos parecem agitados, mas esses custos são insignificantes - naquele ponto de luz, você ouviu o chamado da Musa"
  },
  Event_55799_Name = {
    Text = "Bênção de muzu"
  },
  Event_55819_ChoiceDesc1 = {
    Text = "[Seguir a Memória do Corpo] Pule a batalha e reivindique a vitória instantânea, mas perca pontos de Vida de Arg1."
  },
  Event_55819_ChoiceDesc2 = {
    Text = "[Leave] Entrar em Batalha"
  },
  Event_55819_Desc = {
    Text = "Diante de inimigos familiares, você já está ciente da batalha que se seguirá"
  },
  Event_55819_Name = {
    Text = "memória muscular"
  },
  Event_55997_ChoiceDesc1 = {Text = "[Leave]"},
  Event_55997_Desc = {
    Text = "Das imagens coletadas, você escolheu algumas e entregou à menina. \n \"Que imagens bonitas! Este convidado, por favor, espere... Aqui. Isso é um poema de ofrenda trazido pela primavera, exclusivamente para você!\" \n Um poema apareceu em suas mãos, como uma flor que desabrochou especialmente para você. \n Você queria agradecer à menina. Mas quando levantou a cabeça, a figura da menina já havia desaparecido. Na floricultura solitária, restaram apenas flores e folhas murchas no chão. \n — Isso é a cinza que sobra após a primavera se esgotar."
  },
  Event_55997_Name = {
    Text = "Presente da Primavera"
  },
  Event_55999_ChoiceDesc1 = {Text = "[Leave]"},
  Event_55999_Desc = {
    Text = "Um emaranhado de espinhos faz você hesitar. Você se afastou do ponto de luz, mas o breve olhar ainda enche seu coração com nova inspiração - naquele ponto de luz, você ouviu o chamado da musa"
  },
  Event_55999_Name = {
    Text = "Bênção de muzu"
  },
  Event_56000_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56000_Desc = {
    Text = "Você afasta os espinhos com a mão, sofrendo alguns ferimentos, mas o custo é insignificante - naquele ponto de luz, você ouve o chamado da musa"
  },
  Event_56000_Name = {
    Text = "Bênção de muzu"
  },
  Event_56024_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56024_Desc = {
    Text = "Ainda não é o suficiente... você continua se aproximando daquele ponto de luz. Os espinhos ficaram irritados, revelando suas pontas afiadas. Mas tudo vale a pena.\nAquele ponto de luz se espalha da palma da sua mão, e no véu de luz ao seu redor, você sente claramente a bênção de muzu"
  },
  Event_56024_Name = {
    Text = "Bênção de muzu"
  },
  Event_56025_ChoiceDesc1 = {
    Text = "[Aproxime-se da Luz] Na próxima batalha, a vida do inimigo aumenta em 30% e o dano em 15%, escolha 1 carta [Imagem] para melhorar"
  },
  Event_56025_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56025_Desc = {
    Text = "Você corta os espinhos com suas ferramentas portáteis. Os espinhos vivos parecem agitados, mas o custo é insignificante - naquele ponto de luz, você ouve o chamado da musa"
  },
  Event_56025_Name = {
    Text = "Bênção de muzu"
  },
  Event_56146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56146_Desc = {
    Text = "Ainda não é o suficiente... você continua se aproximando daquele ponto de luz. Os espinhos cortam suas mãos, fazendo o sangue jorrar. Mas tudo vale a pena.\nAquele ponto de luz se espalha da palma da sua mão, e no véu de luz ao seu redor, você sente claramente a bênção de muzu"
  },
  Event_56146_Name = {
    Text = "Bênção de muzu"
  },
  Event_56147_ChoiceDesc1 = {
    Text = "[Creative Impulse] Todos os Despertadores perdem todo o Aliemus. Escolha 3 cartões \"Imagem\" e deixe Horla criar uma \"Oferta\" para você."
  },
  Event_56147_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56147_Desc = {
    Text = "Você aceita o pedido de contato da escola, a voz familiar te acalma. Você se recompõe e segue em frente"
  },
  Event_56147_Name = {
    Text = "Ponto de contato"
  },
  Event_56147_Tips1 = {
    Text = "\"Inspirações Insuficientes\" Pelo menos 3 são necessárias para sintetizar."
  },
  Event_56148_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56148_Desc = {
    Text = "O brilho prateado no emblema da escola te deixou emocionado. Seguindo seu instinto, você jogou o que estava na mão nos espinhos. A luz sob os espinhos começou a brilhar - naquela luz, você teve uma nova inspiração"
  },
  Event_56148_Name = {
    Text = "Ponto de contato"
  },
  Event_56149_ChoiceDesc1 = {
    Text = "[Aproxime-se da Luz] Reduza 10% do limite de vida, escolha uma carta [Imagem] para melhorar"
  },
  Event_56149_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56149_Desc = {
    Text = "Você afasta os espinhos com a mão, sofrendo alguns ferimentos, mas o custo é insignificante - naquele ponto de luz, você ouve o chamado da musa"
  },
  Event_56149_Name = {
    Text = "Bênção de muzu"
  },
  Event_56149_Tips1 = {
    Text = "Sem \"Imagem\" para melhorar"
  },
  Event_56150_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56150_Desc = {
    Text = "O brilho prateado no emblema da escola te deixou emocionado. Você sentiu uma forte vontade de registrar os versos em sua mente"
  },
  Event_56150_Name = {
    Text = "Ponto de contato"
  },
  Event_56151_ChoiceDesc1 = {
    Text = "[Nova Inspiração] Remova 1 cartão \"Imagem\", e atualize aleatoriamente 1 \"Imagem\"."
  },
  Event_56151_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56151_Desc = {
    Text = "Você aceita o pedido de contato da escola, a voz familiar te acalma. Você se recompõe e segue em frente"
  },
  Event_56151_Name = {
    Text = "Ponto de contato"
  },
  Event_56151_Tips1 = {
    Text = "Nenhuma carta de \"Imagem\""
  },
  Event_57738_ChoiceDesc1 = {
    Text = "[Invada] Todos os Despertados ganham 30 de Loucura, mas 2 cartas[(Skill.Arg1)] são adicionadas ao baralho"
  },
  Event_57738_ChoiceDesc2 = {
    Text = "[Disarm] Inimigos na próxima batalha ganham 60% mais Vida e causam 30% mais Dano."
  },
  Event_57738_ChoiceDesc3 = {
    Text = "[Emboscada] Exausto todos os Aliemus do Despertador, ganhe 30 Sigilos Negros e remova a Ameaça da Guarda."
  },
  Event_57738_Desc = {
    Text = "Você espiou do ponto cego na esquina. Os agentes do comitê estavam monitorando outra direção e não notaram vocês.\nAs imagens de treinamento apareciam rapidamente em sua mente, e a maneira de lidar com o inimigo bloqueando o caminho se tornava clara rapidamente"
  },
  Event_57738_Name = {
    Text = "Agente do Comitê de Revisão"
  },
  Event_57738_Tips3 = {
    Text = "Nenhum Despertado com loucura"
  },
  Event_57739_ChoiceDesc1 = {Text = "[Leave]"},
  Event_57739_Desc = {
    Text = "Você observou atentamente. Os agentes do comitê estavam bloqueando seu caminho e monitorando a área à sua frente com seriedade.\nDiante de tantos inimigos, você não podia enfrentá-los.\nAvançar ou recuar?"
  },
  Event_57739_Name = {
    Text = "Ponto de detenção"
  },
  Event_57776_ChoiceDesc1 = {Text = "[Leave]"},
  Event_57776_ChoiceDesc2 = {
    Text = "[Fingir Rendição] Após explorar a área, teleporte-se para o ponto de detenção, ganhe 2 cartas de [Sintoma] aleatórias"
  },
  Event_57776_ChoiceDesc3 = {
    Text = "[Intrusão] Após explorar esta área, teletransporte-se para o ponto de detenção e perca Arg1 Vida."
  },
  Event_57776_Desc = {
    Text = "Você observou atentamente. Os agentes do comitê estavam bloqueando seu caminho e monitorando a área à sua frente com seriedade.\nDiante de tantos inimigos, você não podia enfrentá-los.\nAvançar ou recuar?"
  },
  Event_57776_Name = {
    Text = "Ponto de vigilância"
  },
  Event_57776_Tips3 = {
    Text = "Vida insuficiente"
  },
  Event_59193_ChoiceDesc1 = {
    Text = "[Bênção de Alistair] Adiciona uma carta [Luz da Noite] ao baralho"
  },
  Event_59193_Desc = {
    Text = "Este certificado de matrícula estava no fundo da sua mala. Você acaricia a borda delicada, cheira a tinta do papel, e o emblema de Missaga brilha como uma porta para o futuro, atraindo seu olhar desejoso—como naquele dia, como hoje"
  },
  Event_59193_Name = {
    Text = "Cerimônia de entrada"
  },
  Event_59527_ChoiceDesc1 = {
    Text = "Escolha uma carta para compreender a oração \"Lex Nous\". \"Lex Nous\": Ao jogar, compre 2 cartas; o custo aritmético delas é reduzido ao custo real da carta de oração, válido apenas uma vez por batalha."
  },
  Event_59527_Desc = {
    Text = "Um selo que simboliza conhecimento está gravado no seu documento.\nOs pensamentos de Tawil se fundem em sua mente. Entre essas possibilidades infinitas, você está seguindo o único caminho certo"
  },
  Event_59527_Name = {
    Text = "Cerimônia de entrada"
  },
  Event_59528_ChoiceDesc1 = {
    Text = "Escolha uma carta para compreender a oração \"Lex Volis\". \"Lex Volis\": Ao jogar, descarte todas as cartas, exceto aquelas deste despertador, ganhe 5 cartas não-despertadoras aleatórias, válido apenas uma vez por batalha."
  },
  Event_59528_Desc = {
    Text = "Um selo que simboliza alegria está gravado no seu documento.\nAtravés do selo, N está observando você. Ele espera que você traga um resultado nunca antes mencionado"
  },
  Event_59528_Name = {
    Text = "Cerimônia de entrada"
  },
  Event_59529_ChoiceDesc1 = {
    Text = "Escolha um cartão para compreender o orison \"Lex Genis\". \"Lex Genis\": Ao jogar, ganhe 3 cópias originais adicionais com \"Retém\" e \"Consome\", válido apenas uma vez por batalha."
  },
  Event_59529_Desc = {
    Text = "Um selo que simboliza reprodução está gravado no seu documento.\nTáias deposita suas esperanças em você; ele coexistirá com você em todos os mundos"
  },
  Event_59529_Name = {
    Text = "Cerimônia de entrada"
  },
  Event_59566_ChoiceDesc1 = {
    Text = "[Limpar Lágrimas de Sangue] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_59566_ChoiceDesc2 = {
    Text = "[Eyes Open] Ganhar aleatoriamente 3 cartas de comando com oração: \"(EnchantConfig.Arg1)\", infectado com \"(Skill.Arg2)\""
  },
  Event_59566_Desc = {
    Text = "Incontáveis desejos seus se fundem, vocês compartilham a mesma origem e agora o mesmo corpo.\nInúmeros olhos se abrem para encarar o grande olho.\nInúmeros olhos se quebram, derramando lágrimas de sangue seco"
  },
  Event_59566_Name = {
    Text = "Minha fusão"
  },
  Event_59567_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59567_Desc = {
    Text = "Você tenta debater com aquela voz louca, refutando a ideia do nada. \n\"Tudo caminha para a morte, a vida em si não é sem sentido?\" \nVocê argumenta com fervor, no entanto, aquela risada não diminui nem um pouco, como se zombasse da sua estupidez."
  },
  Event_59567_Name = {
    Text = "Cordeiro para o matadouro"
  },
  Event_59568_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59568_Desc = {
    Text = "Você observa aquela porta, não querendo mais suportar a dor da ignorância.\nVocê deseja ver a cena por trás da porta.\nA porta ilusória balança de forma hipnótica, e você vê as sombras de inúmeros mundos passando rapidamente.\nSem tempo para enxergar claramente, informações infinitas arrasam sua mente, e seu cérebro se enche de ruídos caóticos."
  },
  Event_59568_Name = {
    Text = "Por trás da porta"
  },
  Event_59569_ChoiceDesc1 = {
    Text = "[Comando Firme] Despertar 1 Desperto Aleatório, Infectar[(Skill.Arg1)]"
  },
  Event_59569_ChoiceDesc2 = {
    Text = "[Discutir juntos] escolhe 1 entre 3 cartas de comando para obter a oração:[(EnchantConfig.Arg1)]"
  },
  Event_59569_Desc = {
    Text = "Tudo aconteceu tão de repente, você sente que uma névoa confusa lhe envolve, você olha ao redor com dificuldades, mas não consegue ver nada.  \nOs despertadores esperam pelas suas ordens.  \nAgora você está isolado e sem ajuda, dependendo apenas de sua própria força"
  },
  Event_59569_Name = {
    Text = "Olho da Ignorância"
  },
  Event_59570_ChoiceDesc1 = {
    Text = "[Sacrifício] Ganhe uma relíquia amaldiçoada \"(RelicConfig.Arg1)\", infectada com \"(Skill.Arg2)\""
  },
  Event_59570_ChoiceDesc2 = {
    Text = "[Com Coragem] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_59570_ChoiceDesc3 = {
    Text = "[Stare Directly] Ganhe 50 Sigilos Negros"
  },
  Event_59570_Desc = {
    Text = "Inúmeros de você em inúmeros mundos, ombro a ombro, mão na mão, como irmãos e irmãs.\nAgora vocês estão sob a grande sombra, cabeça erguida, sem recuar.\nO que fazer?\nComo derrotar o você final?"
  },
  Event_59570_Name = {
    Text = "Minha resposta"
  },
  Event_59571_ChoiceDesc1 = {
    Text = "[Procurar Respostas] Ganhe Arg1 do sigilo negro, infecção[(Skill.Arg2)], continue a escolher"
  },
  Event_59571_ChoiceDesc2 = {
    Text = "[Desista] Ganhe 25 Sigilos Negros e saia."
  },
  Event_59571_Desc = {
    Text = "Através das ilusões da porta, inúmeras experiências que você viveu voltam à sua mente. \n Alguns morreram, outros enlouqueceram, alguns perseveraram, outros caíram. \n Incontáveis caminhos e escolhas se desenrolam diante de você, como se você tivesse vivido uma longa e interminável vida em um instante. \n Agora, inúmeras mentes e bocas operam simultaneamente. \n Você tenta transcender o tempo e o espaço para dialogar com os inúmeros eus, resgatando respostas da infinidade de memórias."
  },
  Event_59571_Name = {
    Text = "Minha autointerrogativa"
  },
  Event_59572_ChoiceDesc1 = {
    Text = "[Trocar poder] aleatoriamente 1 carta de comando para obter uma oração:[(EnchantConfig.Arg1)]"
  },
  Event_59572_ChoiceDesc2 = {
    Text = "[Trocar sorte] aumentar Arg1 pontos de saúde máxima, infecção[(Skill.Arg2)]"
  },
  Event_59572_Desc = {
    Text = "Toda escolha tem um preço.\nVida, mente, emoções, memórias…\nO que você quer trocar com o destino e o que colocará na balança?"
  },
  Event_59572_Name = {
    Text = "Escolha do Destino"
  },
  Event_59573_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59573_Desc = {
    Text = "Como alguém pode viver sem coração? \n Você procura freneticamente, sua respiração se acelera, o medo da morte envolve sua mente. \n \"Não consigo respirar... meu coração vai parar...\" \n Espere, parece que você não precisa mais de um coração. \n Você percebe isso e começa a rir alegremente."
  },
  Event_59573_Name = {
    Text = "Cavidade do peito"
  },
  Event_59574_ChoiceDesc1 = {
    Text = "[Parar] Obteve Relíquia de Ouro \"(RelicConfig.Arg1)\", Infectada com \"(Skill.Arg2)\""
  },
  Event_59574_ChoiceDesc2 = {
    Text = "[Escapar] randomicamente desperta 2 despertadores, infecta duas vezes[(Skill.Arg1)]"
  },
  Event_59574_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_59574_Desc = {
    Text = "Você sentiu uma presença no vazio observando você.\nOnde quer que fosse, aquele olhar o seguia.\nVocê se sentiu como uma presa pequena sendo caçada, suas costas começaram a doer como se fossem picadas"
  },
  Event_59574_Name = {Text = "Seu olhar"},
  Event_59575_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59575_Desc = {
    Text = "Você permanece imperturbável durante a performance frenética, mantendo seu próprio ritmo.\nOs ataques e tentações do oponente não afetam você, e o piano toca duas melodias ao mesmo tempo. Quem persistir até o fim controlará todas as notas"
  },
  Event_59575_Name = {
    Text = "Música da Festa do Apocalipse"
  },
  Event_59576_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59576_Desc = {
    Text = "Você reúne toda a sua coragem, não importa o que enfrente, você seguirá em frente com seus companheiros"
  },
  Event_59576_Name = {
    Text = "Futuro congelado"
  },
  Event_59577_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59577_Desc = {
    Text = "\"Onde você está agora?\"\n\"Quais são os planos dos professores?\"\n\"O que devo fazer a seguir?\"\nVocê pergunta ansiosamente, querendo depender daquela presença confiável como de costume.\nO comunicador parou de responder como se estivesse travado; você balança a máquina, e as palavras na resposta se distorcem, transformando-se em um bando de borboletas que batem as asas em seu rosto.\nVocê esfrega os olhos e percebe que tudo não passa de uma ilusão.\nO papel da resposta está vazio, sem uma palavra."
  },
  Event_59577_Name = {
    Text = "Eco Alucinante"
  },
  Event_59578_ChoiceDesc1 = {
    Text = "[Panic Search] Aumente a saúde máxima em Arg1"
  },
  Event_59578_ChoiceDesc2 = {
    Text = "[Tentar Preencher] Escolha 1 de 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_59578_Desc = {
    Text = "Você sentiu um vazio e leveza no peito, olhou para baixo e viu um buraco em forma de fechadura.\nSeu coração havia desaparecido"
  },
  Event_59578_Name = {
    Text = "Cavidade do peito"
  },
  Event_59579_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59579_Desc = {
    Text = "Você questiona em voz alta o propósito dele, mas apenas recebe um sorriso inalterado.  \nEle já se desviou do mundo, uma pessoa sem preocupações não precisa se responsabilizar por nada.  \nVocê só pode resistir em vão"
  },
  Event_59579_Name = {
    Text = "Cavalheiro Louco"
  },
  Event_59580_ChoiceDesc1 = {
    Text = "[Disrupt Rhythm] Ganhe uma relíquia de prata \"(RelicConfig.Arg1)\" e fique infectado com \"(Skill.Arg2)\"."
  },
  Event_59580_ChoiceDesc2 = {
    Text = "[Self-Preservation] Ganhar Oração de 3 escolhas"
  },
  Event_59580_Desc = {
    Text = "Você parece tocar com uma pessoa louca, ela te sequestra nas teclas, arrastando você para sua melodia insana.\nVocê toca arduamente em seu ritmo, cambaleando.\nVocê luta para competi-la, tentando dominar a melodia da canção"
  },
  Event_59580_Name = {
    Text = "Música da Festa do Apocalipse"
  },
  Event_59581_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59581_Desc = {
    Text = "Você deseja ter um poder inigualável, capaz de quebrar todas as correntes e obstáculos.\nNo entanto, o poder humano é limitado, e desafiar os deuses com um corpo pequeno acabará por consumir sua vida como um fósforo"
  },
  Event_59581_Name = {
    Text = "Escolha do Destino"
  },
  Event_59582_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59582_Desc = {
    Text = "\"Acabou... acabou...\"\nA sensação de vazio é desconfortável, você pegou o relógio de bolso, a maçã e o uniforme escolar, tentando preencher o buraco no peito.\nSeu peito voltou a ficar cheio, mas você tem a impressão de estar excessivamente cheio.\nTudo bem, as coisas nunca são perfeitas."
  },
  Event_59582_Name = {
    Text = "Cavidade do peito"
  },
  Event_59583_ChoiceDesc1 = {
    Text = "[Persuade] Ganhe 25 sigilos negros"
  },
  Event_59583_ChoiceDesc2 = {
    Text = "[Question] Obtenha a Relíquia de Prata \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_59583_Desc = {
    Text = "Os sapatos de N param à sua frente, um sorriso distorcido em seu rosto sombrio.\nEle sempre se veste impecavelmente, mas por trás dessa fachada cavalheiresca há pura loucura.\nEle não tem amigos, e poucos inimigos.\nPorque todos desaparecem da maneira mais teatral.\nInfelizmente, você é agora seu próximo protagonista.\nPronto para sua fala de abertura. Como você vai satisfazer esse público tão exigente?"
  },
  Event_59583_Name = {
    Text = "Cavalheiro Louco"
  },
  Event_59584_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59584_Desc = {
    Text = "Os despertos não sabem mais do que você, mas já são seus parceiros, aliados e suporte mais leais.\nVocê discute estratégias com eles, apesar da incerteza, vocês têm coragem de recomeçar"
  },
  Event_59584_Name = {
    Text = "Olho da Ignorância"
  },
  Event_59585_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59585_Desc = {
    Text = "Como se decidisse, você respondeu firmemente em voz alta.\nSua voz ecoou entre inúmeras bolhas, como se muitos de você estivessem jurando juntos.\nVocê está pronto para enfrentar tudo"
  },
  Event_59585_Name = {
    Text = "Seu interrogatório"
  },
  Event_59586_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59586_Desc = {
    Text = "Você não se moveu, apenas fixou os olhos na caligrafia da carta de resposta.\nSob seu olhar, aquelas palavras foram gradualmente se tornando borradas e distorcidas, até que se transformaram em um bando de borboletas que bateram as asas em sua cara.\nVocê balança as mãos para espantar as borboletas e, ao olhar de volta, o papel da carta de resposta já estava vazio.\nDe fato, todos os sonhos lindos demais são falsos."
  },
  Event_59586_Name = {
    Text = "Eco Alucinante"
  },
  Event_59587_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59587_Desc = {
    Text = "Você odiava esses fios desprezíveis.\nVocê os puxou com força, alguns se romperam, mas muitos outros se enrolaram novamente.\nVocê usou toda a sua força para lutar contra eles"
  },
  Event_59587_Name = {
    Text = "Mãos Manipuladas"
  },
  Event_59588_ChoiceDesc1 = {
    Text = "[Abater a sombra] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_59588_ChoiceDesc2 = {
    Text = "[Esmagar o embrião] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_59588_ChoiceDesc3 = {
    Text = "[Close Your Eyes] Ganhar 25 sigilos negros"
  },
  Event_59588_Desc = {
    Text = "Em um transe, você vê pessoas que conheceu em Aran se aproximando.\nEles riem e te convidam para beber, dançar e aproveitar o banquete.\nEntão, suas carnes começam a se desprender em camadas, caindo no chão e se retorcendo em novos embriões.\nEles estendem a mão, te convidando para a celebração de carne e renascimento."
  },
  Event_59588_Name = {
    Text = "Sombras do Passado"
  },
  Event_59589_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59589_Desc = {
    Text = "Antes de estender a mão, você lembrou que nunca teve um gato.\nVocê e o gato se olharam através do ar, e o gato piscou para você.\nO gato não se importava com sua frieza, ainda parecia te amar"
  },
  Event_59589_Name = {
    Text = "A tentação do gato"
  },
  Event_59590_ChoiceDesc1 = {
    Text = "[Incrustar] escolha uma relíquia para transformar em relíquia amaldiçoada[(RelicConfig.Arg1)]"
  },
  Event_59590_ChoiceDesc2 = {
    Text = "[Swallow] Ganhe uma relíquia de prata \"(RelicConfig.Arg1)\" e infecte \"(Skill.Arg2)\""
  },
  Event_59590_ChoiceDesc3 = {
    Text = "[Store] Ganhar 25 Sigilos Negros"
  },
  Event_59590_Desc = {
    Text = "As forças dos três plásmidos dentro de você estão se fundindo, e você luta para controlar esse imenso poder.\nO espaço mental continua a se expandir, uma galáxia nasce e se espalha aqui.\nDiante de inimigos que surgem incessantemente, você ora sinceramente para este céu estrelado, pedindo ajuda a esse poder.\nUma estrela cai da galáxia para a palma da sua mão, emitindo uma luz sedutora."
  },
  Event_59590_Name = {
    Text = "Estrela dos Desejos"
  },
  Event_59591_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59591_Desc = {
    Text = "Você também ficou em silêncio. Vocês não se comunicaram, o silêncio era a resposta para tudo.\nVocê estava pronto para enfrentar tudo"
  },
  Event_59591_Name = {
    Text = "Seu interrogatório"
  },
  Event_59592_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59592_Desc = {
    Text = "Aquele gato é um mentiroso?\nVocê começa a duvidar daqueles olhos azuis como piscinas, enquanto risadas ecoam em seus ouvidos.\n\"Mentiroso, mentiroso, você foi enganado!\"\nUma preocupação surge em seu coração"
  },
  Event_59592_Name = {
    Text = "sussurro secreto"
  },
  Event_59593_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59593_Desc = {
    Text = "Você se sente como um observador, assistindo silenciosamente emoções cada vez mais estranhas.\nVocê reprime todo desejo de apego, sentindo sua alma esfriar.\nEste é seu destino, seu caminho inevitável"
  },
  Event_59593_Name = {
    Text = "Cristal emocional"
  },
  Event_59594_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59594_Desc = {
    Text = "Aquele sorriso inabalável, você não pode tocá-lo com razão ou emoção.\nNada do que os humanos desejam importa para ele.\nSuas palavras podem ir além da imaginação humana?"
  },
  Event_59594_Name = {
    Text = "Cavalheiro Louco"
  },
  Event_59595_ChoiceDesc1 = {
    Text = "[Responder] Ganhe Relíquia de Ouro \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\""
  },
  Event_59595_ChoiceDesc2 = {
    Text = "[Silêncio] despertar aleatoriamente 2 entidades, infectar duas vezes[(Skill.Arg1)]"
  },
  Event_59595_Desc = {
    Text = "Incontáveis bolhas parecem incontáveis círculos de olhos; Ele observa você em silêncio, como se fizesse uma pergunta silenciosa.\nVocê está pronto?\nPronto para abrir mão de tudo?\nPronto para suportar tudo?"
  },
  Event_59595_Name = {
    Text = "Seu interrogatório"
  },
  Event_59596_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59596_Desc = {
    Text = "No momento do ataque do oponente, você imediatamente contra-atacou.\nVocê discerniu sabiamente sua verdadeira natureza, eram bestas mostrando suas presas.\nVocê venceu por sorte.\nAgora fuja, não deixe que te peguem"
  },
  Event_59596_Name = {
    Text = "Afundar-se no abismo"
  },
  Event_59597_ChoiceDesc1 = {
    Text = "[Procurar Respostas] Ganhe Arg1 do sigilo negro, infecção[(Skill.Arg2)], continue a escolher"
  },
  Event_59597_ChoiceDesc2 = {
    Text = "[Abandonar] Sair"
  },
  Event_59597_Desc = {
    Text = "O que você deve fazer?\nVocê olha para inúmeras versões de si mesmo, todas te observando, suas bocas se movendo.\nAgarrando-se a uma esperança, você busca e ouve, esperando uma resposta final"
  },
  Event_59597_Name = {
    Text = "Minha autointerrogativa"
  },
  Event_59598_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59598_Desc = {
    Text = "Ainda não é o momento, você precisa esperar pacientemente.\nVocê engole sua amargura e ódio, aguardando o momento de arriscar tudo"
  },
  Event_59598_Name = {
    Text = "Mãos Manipuladas"
  },
  Event_59599_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59599_Desc = {
    Text = "Você sentiu uma atração misteriosa, querendo ver a origem daqueles olhares.\nVocê olhou fixamente para o vazio, sentindo que viu algo.\nSua visão foi coberta por uma nevasca, o mundo parecia diferente.\nVocê esfregou os olhos e viu lágrimas de sangue escorrendo"
  },
  Event_59599_Name = {Text = "Seu olhar"},
  Event_59600_ChoiceDesc1 = {
    Text = "[Tentar recordar] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_59600_ChoiceDesc2 = {
    Text = "[Saborear a tristeza] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_59600_ChoiceDesc3 = {
    Text = "[Aceitar Silenciosamente] Ganha 25 sigilos negros"
  },
  Event_59600_Desc = {
    Text = "Como se tivesse passado por uma cirurgia cerebral extremamente precisa, você sente claramente que fragmentos de memórias preciosas estão se afastando de sua mente, seu cérebro se torna uma confusão, como se estivesse prestes a derreter.\nVocê treme de dor, segurando a mão que deseja impedir.\nLágrimas brilhantes escorrem de seus olhos, mas por que elas estão caindo?\nVocê parece ter dificuldade em lembrar.\nUma tristeza inexplicável invade você."
  },
  Event_59600_Name = {
    Text = "Dissociação da memória"
  },
  Event_59601_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59601_Desc = {
    Text = "Sua amizade com o gato é inquestionável. Você acenou e continuou sem olhar para trás.\n\"Idiota! Idiota!\"\nA voz ao seu lado estava furiosa"
  },
  Event_59601_Name = {
    Text = "sussurro secreto"
  },
  Event_59602_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59602_Desc = {
    Text = "Você está decidido, custe o que custar, irá lutar até o último momento, carregando as esperanças de todos"
  },
  Event_59602_Name = {
    Text = "Futuro congelado"
  },
  Event_59603_ChoiceDesc1 = {
    Text = "[Domínio] obtem a relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_59603_ChoiceDesc2 = {
    Text = "[Gaze] Obtenha a Relíquia de Ouro \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_59603_Desc = {
    Text = "Atrás da porta guardada por Tawil está um mundo sem fim e uma verdade infinita.\nVocê não sabe o que ela viu atrás da porta, mas você sabe que ela sabe tudo.\nAgora esta porta se abre diante de você, toda a verdade emite um convite silencioso por trás da porta."
  },
  Event_59603_Name = {
    Text = "Por trás da porta"
  },
  Event_59604_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59604_Desc = {
    Text = "Devemos ter respeito pela existência desconhecida, evitar seu brilho é uma escolha cautelosa. \n Você abaixa a cabeça, aperta a chave de prata em seu peito e sente um leve conforto. \n Pelo menos você ainda tem força, ainda tem os Corpos Despertos. \n Você se esforça para ignorar aqueles olhares, focando no caminho à sua frente. \n Mas aqueles olhares realmente desapareceram? Você sabe muito bem."
  },
  Event_59604_Name = {Text = "Seu olhar"},
  Event_59605_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59605_Desc = {
    Text = "Se todos os meios de enfrentar os deuses são inúteis, a única coisa que você pode manter é a coragem de não desistir.\nQuando a destruição infinita descer do céu, você será o primeiro a enfrentá-la"
  },
  Event_59605_Name = {
    Text = "Minha resposta"
  },
  Event_59606_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59606_Desc = {
    Text = "Você tocou as lágrimas que caíam, sentindo a tristeza inexplicável.\nParece que você perdeu algo muito precioso, mas não consegue lembrar o que era.\nQue pena.\nVocê limpou as lágrimas, esboçando um sorriso amargo"
  },
  Event_59606_Name = {
    Text = "Dissociação da memória"
  },
  Event_59607_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59607_Desc = {
    Text = "Você ignora as vozes deles.\nVocê não se importa se o gato é um mentiroso, você só confia em sua própria força.\nAs vozes ao seu redor suspiram"
  },
  Event_59607_Name = {
    Text = "sussurro secreto"
  },
  Event_59608_ChoiceDesc1 = {
    Text = "[Procurar Respostas] Ganhe Arg1 do sigilo negro, infecção[(Skill.Arg2)], continue a escolher"
  },
  Event_59608_ChoiceDesc2 = {
    Text = "[Abandonar] Sair"
  },
  Event_59608_Desc = {
    Text = "Alguém ri loucamente. \nAquele que considera que toda luta é inútil deve desistir o quanto antes. \nVocê franze a testa, aquele que de repente sorri e se vira, diz que é melhor acabar com a vida de todos do que permitir que as pessoas sofram. \nVocê afasta aquele som, reafirmando sua crença"
  },
  Event_59608_Name = {
    Text = "Minha autointerrogativa"
  },
  Event_59609_ChoiceDesc1 = {
    Text = "[Interrogar] Exclua 2 Cartas"
  },
  Event_59609_ChoiceDesc2 = {
    Text = "[Perfurar] Obteve Relíquia Amaldiçoada \"(RelicConfig.Arg1)\", Infectada com \"(Skill.Arg2)\""
  },
  Event_59609_ChoiceDesc3 = {
    Text = "[Leave] Ganhar Arg1 sigilos negros"
  },
  Event_59609_Desc = {
    Text = "Na longa espera, você abriu o comunicador mais uma vez. Talvez suas saudades e orações tenham surtido efeito, você viu as respostas familiares e carinhosas dela surgindo continuamente na folha da carta de retorno. \n Ela está muito segura agora, os professores já tinham planos, a operação do Misaq está indo tudo bem... \n Você olha as boas notícias que chegam como flocos de neve, seu coração não consegue evitar um movimento."
  },
  Event_59609_Name = {
    Text = "Eco Alucinante"
  },
  Event_59610_ChoiceDesc1 = {
    Text = "[capturar estrelas] transforma 1 relíquia de prata em relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_59610_ChoiceDesc2 = {
    Text = "[Esmagar as Estrelas] Ganhar Relíquia de Ouro \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\", e \"(Skill.Arg3)\""
  },
  Event_59610_ChoiceDesc3 = {
    Text = "[Silent Watch] Ganhe 25 Sigilos Negros"
  },
  Event_59610_Desc = {
    Text = "Suas emoções são despojadas junto com as memórias, e você sente que está se tornando algum tipo de existência colossal, como um monstro retornando ao seu antigo e acolhedor ninho. \n Incontáveis alegrias, tristezas, raivas e medos se condensam, transformando-se em estrelas brilhantes que caem como uma chuva luminosa em sua dimensão espiritual. \n As marcas da sua existência se tornam meteoros e desaparecem. \n Você observa em silêncio, pegando uma estrela à sua frente, de onde vem o som da sua risada alegre. \n Assim, você também sorri, doce como mel."
  },
  Event_59610_Name = {
    Text = "Cristal emocional"
  },
  Event_59611_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59611_Desc = {
    Text = "Você sabe que isso não passa de sombras do passado, enquanto você massacra impassivelmente aqueles que costumavam conversar com você. \n As risadas e lágrimas deles se despedaçam em suas mãos, e você não pode ter um momento de pausa. \n Se este é o teste necessário, você atuará como o mais impiedoso carrasco."
  },
  Event_59611_Name = {
    Text = "Sombras do Passado"
  },
  Event_59612_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59612_Desc = {
    Text = "Seu pelo macio e olhos claros naturalmente inspiram confiança.\nVocê se aproxima do gato, e o gato se aproxima de você.\nSem palavras, mas sua cauda está erguida"
  },
  Event_59612_Name = {
    Text = "A tentação do gato"
  },
  Event_59613_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59613_Desc = {
    Text = "Você conteve sua curiosidade, sabendo que essa porta não deveria ser aberta.\nMuita verdade às vezes é uma maldição.\nVocê apertou a chave de prata em seu peito, decidido a manter essa porta fechada para sempre"
  },
  Event_59613_Name = {
    Text = "Por trás da porta"
  },
  Event_59614_ChoiceDesc1 = {
    Text = "[Courage] Atualizar aleatoriamente os efeitos da oração de 2 cartas."
  },
  Event_59614_ChoiceDesc2 = {
    Text = "[Determinação] escolhe 1 entre 3 cartas de comando para obter a oração:[(EnchantConfig.Arg1)]"
  },
  Event_59614_Desc = {
    Text = "As palavras de Tawil ecoam em sua mente.\nEntre inúmeros desfechos, apenas um é o caminho certo.\nEm um estado de transe, você vê muitas sombras de mundos passando diante de seus olhos, como fragmentos de um filme, esperando o momento em que o botão será pressionado para congelar a cena.\nApós este segundo, que desfecho o mundo realmente encontrará?"
  },
  Event_59614_Name = {
    Text = "Futuro congelado"
  },
  Event_59615_ChoiceDesc1 = {
    Text = "[Ignorar Suspeita] Ganhe 50 Sigilos Negros"
  },
  Event_59615_ChoiceDesc2 = {
    Text = "[decisão unilateral] Ganhe 75 o sigilo negro, infecção[(Skill.Arg2)]"
  },
  Event_59615_Desc = {
    Text = "Com a zombaria de N, você começa a duvidar de todos que conheceu.\nQuem é ele e quem são seus verdadeiros amigos?\nSua sombra muda constantemente, revelando inúmeras faces sorrindo para você"
  },
  Event_59615_Name = {
    Text = "As Cem Faces da Sombra"
  },
  Event_59616_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59616_Desc = {
    Text = "Se todos têm a possibilidade de traição, então não confie em ninguém.\nNa escuridão, você só pode afirmar a única verdade.\nPelo menos você ainda tem a si mesmo—o seu eu mais leal em quem confiar"
  },
  Event_59616_Name = {
    Text = "As Cem Faces da Sombra"
  },
  Event_59617_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59617_Desc = {
    Text = "Você apertou com força, e os cristais brilhantes se despedaçaram em pó sob seus dedos. \n Você aspirou avidamente aquelas emoções do passado. \n Em um instante, uma intensa felicidade invadiu sua mente, e depois a ilusão começou a desaparecer lentamente. \n Seus lábios se curvaram para cima, e depois lentamente caíram. \n Seu rosto gradualmente se tornou calmo e sereno."
  },
  Event_59617_Name = {
    Text = "Cristal emocional"
  },
  Event_59618_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59618_Desc = {
    Text = "Você sabe que tudo tem um preço, se o preço da salvação é o sacrifício, então deixe que eu pague.\nVocê está pronto para dar tudo"
  },
  Event_59618_Name = {
    Text = "Minha resposta"
  },
  Event_59619_ChoiceDesc1 = {
    Text = "[Procurar Respostas] Ganhe Arg1 do sigilo negro, infecção[(Skill.Arg2)], continue a escolher"
  },
  Event_59619_ChoiceDesc2 = {
    Text = "[Abandonar] Sair"
  },
  Event_59619_Desc = {
    Text = "Alguém está gritando.\nEssa versão de você quer desesperadamente fugir e diz que resistir é fútil. \nSó uma fuga interminável pode atrasar a extinção final. \nVocê está cético"
  },
  Event_59619_Name = {
    Text = "Minha autointerrogativa"
  },
  Event_59620_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59620_Desc = {
    Text = "Você sabe do horror da velocidade de reprodução daqueles embriões, o novo nascido aqui é uma maldição como a de gafanhotos. \n Você os esmaga antes que os recém-nascidos emitam seus choros. \n As pessoas feitas de carne e sangue olham para você com rancor, questionando por que você profana a vida sagrada. \n Você responde com um massacre sem fim."
  },
  Event_59620_Name = {
    Text = "Sombras do Passado"
  },
  Event_59621_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59621_Desc = {
    Text = "Neste momento, você deseja ser a pessoa mais sortuda, alcançando o final perfeito.\nMas o preço da sorte pode ser cruel, sorte e azar andam juntos, ao receber algo, não se esqueça de verificar o que perdeu"
  },
  Event_59621_Name = {
    Text = "Escolha do Destino"
  },
  Event_59622_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59622_Desc = {
    Text = "Você parece estar lutando pelo volante do mesmo carro com alguém, suas mãos se movem freneticamente, tentando dominar o ritmo da música.\nNa difícil batalha, você de repente pressiona uma linha de teclas com força.\nA execução frenética é interrompida por você, e você sorri, mergulhando em uma luta entre a loucura e a loucura ainda maior."
  },
  Event_59622_Name = {
    Text = "Música da Festa do Apocalipse"
  },
  Event_59623_ChoiceDesc1 = {
    Text = "[Approach] Ganhe 25 Sigilos Negros"
  },
  Event_59623_ChoiceDesc2 = {
    Text = "[Olhe] 50% de chance de ganhar 50 Sigilos Negros, 50% de chance de não obter nada"
  },
  Event_59623_Desc = {
    Text = "Ao seu lado, há um gato com pelo limpo e patas brancas como neve. \nO gato sempre te acompanha, como um fiel servo. \nToda sua confusão, dor e insegurança são acalmadas"
  },
  Event_59623_Name = {
    Text = "A tentação do gato"
  },
  Event_59624_ChoiceDesc1 = {
    Text = "[Negação] Infectado com \"(Skill.Arg1)\", ganhar relíquia amaldiçoada \"(RelicConfig.Arg2)\""
  },
  Event_59624_ChoiceDesc2 = {
    Text = "[Retort] Infeccionado duas vezes com \"(Skill.Arg1)\", ganhe Relíquia de Prata \"(RelicConfig.Arg2)\" e \"(RelicConfig.Arg3)\""
  },
  Event_59624_ChoiceDesc3 = {
    Text = "[Silence] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_59624_Desc = {
    Text = "Você está preso em uma ilusão de nada. \n Você vê inúmeras pessoas em silêncio sob a sombra do apocalipse, pequenas como poeira. \n Elas estão paralisadas, cinzentas, sem esperança. \n Você ouve a risada aguda de alguém. \n \"Veja, este é o resultado da sua insistência.\" \n \"O mundo nunca teve um fim, tudo e qualquer coisa não tem significado.\""
  },
  Event_59624_Name = {
    Text = "Cordeiro para o matadouro"
  },
  Event_59625_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59625_Desc = {
    Text = "Não, isso não está certo, isso não é real.\nVocê continua negando aquela voz louca, enquanto a sombra sombria permanece impassível, como se confirmasse o desfecho da ilusão.\nAquela risada aumenta, zombando da sua impotência"
  },
  Event_59625_Name = {
    Text = "Cordeiro para o matadouro"
  },
  Event_59626_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59626_Desc = {
    Text = "Você sentiu um grande arrependimento e tristeza, tentando desesperadamente lembrar, buscando fragmentos do passado.\nAs imagens borradas recuavam rapidamente, você tentou agarrá-las, mas só viu as imagens escaparem pelos dedos.\nVocê percebeu que estava prestes a perder tudo"
  },
  Event_59626_Name = {
    Text = "Dissociação da memória"
  },
  Event_59627_ChoiceDesc1 = {
    Text = "[Approach] Ganhe 25 Sigilos Negros"
  },
  Event_59627_ChoiceDesc2 = {
    Text = "[Olhe] 50% de chance de ganhar 50 Sigilos Negros, 50% de chance de não obter nada"
  },
  Event_59627_Desc = {
    Text = "Ao seu lado, há um gato com pelo limpo e patas brancas como neve. \nO gato sempre te acompanha, como um fiel servo. \nToda sua confusão, dor e insegurança são acalmadas"
  },
  Event_59627_Name = {
    Text = "A tentação do gato"
  },
  Event_59628_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59628_Desc = {
    Text = "Você encontrou seu eu final aqui. A batalha para destruir o mundo inteiro foi apenas um olhar entre vocês.\nQuando Ele olhar para você, você deve encará-lo firmemente até que um dos olhares desapareça"
  },
  Event_59628_Name = {
    Text = "Minha resposta"
  },
  Event_59629_ChoiceDesc1 = {
    Text = "[Respirar] Obter uma Relíquia de Prata \"(RelicConfig.Arg1)\" e infectar \"(Skill.Arg2)\""
  },
  Event_59629_ChoiceDesc2 = {
    Text = "[Balcão] Obter uma relíquia de ouro \"(RelicConfig.Arg1)\" e infectar com \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_59629_ChoiceDesc3 = {
    Text = "[Struggle] Ganhar 25 Sigilos Negros"
  },
  Event_59629_Desc = {
    Text = "Passos apressados soam, agentes do comitê bloqueiam seu caminho.\n\"Por favor, colabore com nossa investigação.\"\nA voz fria contém malícia.\nCom um splash, a superfície calma da água é quebrada, e eles jogam você no poço profundo"
  },
  Event_59629_Name = {
    Text = "Afundar-se no abismo"
  },
  Event_59630_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59630_Desc = {
    Text = "Você luta desesperadamente.\nAvance, mais um pouco.\nNão importa o custo, você deve proteger tudo isso.\nVocê estende a mão, os fios cortam sua carne, mas você não sente"
  },
  Event_59630_Name = {
    Text = "Mãos Manipuladas"
  },
  Event_59631_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59631_Desc = {
    Text = "Você sacudiu a cabeça com força, tentando expulsar as memórias confusas.\nLogo, os sons caóticos desapareceram, e sua consciência recuperou a independência.\nVocê não podia obter ajuda do passado fracassado, apenas focar no presente poderia trazer esperança"
  },
  Event_59631_Name = {
    Text = "Minha autointerrogativa"
  },
  Event_59632_ChoiceDesc1 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_59632_Desc = {
    Text = "Antes de estender a mão, você lembrou que nunca teve um gato.\nVocê e o gato se olharam através do ar, e o gato piscou para você.\nO gato não se importava com sua frieza, ainda parecia te amar"
  },
  Event_59632_Name = {
    Text = "A tentação do gato"
  },
  Event_59633_ChoiceDesc1 = {
    Text = "[Procurar Respostas] Ganhe Arg1 do sigilo negro, infecção[(Skill.Arg2)]"
  },
  Event_59633_ChoiceDesc2 = {
    Text = "[Abandonar] Sair"
  },
  Event_59633_Desc = {
    Text = "Alguém está chorando.\nEssa versão de você, cheia de tristeza, quer abraçar a pessoa amada. \nO maior arrependimento foi não estar com aqueles que importam durante a destruição. \nSeu coração dói, não consegue evitar se entristecer junto"
  },
  Event_59633_Name = {
    Text = "Minha autointerrogativa"
  },
  Event_59634_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59634_Desc = {
    Text = "Você olha para as inúmeras sombras cinzentas, ignorando as risadas sarcásticas.\nComo salvar um mundo em colapso?\nVocê pensa incessantemente na extinção silenciosa"
  },
  Event_59634_Name = {
    Text = "Cordeiro para o matadouro"
  },
  Event_59635_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59635_Desc = {
    Text = "O ar nos alvéolos desaparece gradualmente, você tenta respirar debaixo d'água. \n Que ato tão tolo, mas você conseguiu. \n Seus alvéolos se enchem novamente, você pode expirar livremente. \n Mas o que exatamente você está inalando?"
  },
  Event_59635_Name = {
    Text = "Afundar-se no abismo"
  },
  Event_59636_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59636_Desc = {
    Text = "Você afundou no líquido viscoso.\nApesar de lutar, afundou mais.\nNão pode escapar sozinho"
  },
  Event_59636_Name = {
    Text = "Afundar-se no abismo"
  },
  Event_59637_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59637_Desc = {
    Text = "Você se forçou a esquecer essas dúvidas.\nSabe que duvidar agora é inútil, só pode acreditar.\nAntes de abrir a caixa selada, não saberá a verdade dentro dela.\nÀs vezes, ser um tolo ignorante traz mais paz"
  },
  Event_59637_Name = {
    Text = "As Cem Faces da Sombra"
  },
  Event_59638_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59638_Desc = {
    Text = "Todos os olhares estão voltados para você, você deve ser o líder de todos, não pode demonstrar fraqueza.\n“Vá para a piscina negra, tudo ficará bem.”\nVocê dá a ordem com calma, prometendo algo em que nem mesmo acredita"
  },
  Event_59638_Name = {
    Text = "Olho da Ignorância"
  },
  Event_59639_ChoiceDesc1 = {
    Text = "[Suspect] Infecte \"(Skill.Arg1)\", obtenha relíquia amaldiçoada \"(RelicConfig.Arg2)\""
  },
  Event_59639_ChoiceDesc2 = {
    Text = "[Disdain] Inflija \"(Skill.Arg1)\" duas vezes, ganhe Relíquia de Prata \"(RelicConfig.Arg2)\" e \"(RelicConfig.Arg3)\""
  },
  Event_59639_ChoiceDesc3 = {
    Text = "[Desconsiderar] Ganhe a relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_59639_Desc = {
    Text = "Três figuras hesitantes à frente, murmurando algo.\nVocê se aproxima para ouvir, as palavras e respirações ficam claras.\n\"Não confie naquele gato, ele é um mentiroso.\"\nVocê se vira rapidamente, mas não há ninguém ao seu lado"
  },
  Event_59639_Name = {
    Text = "sussurro secreto"
  },
  Event_59640_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59640_Desc = {
    Text = "As estrelas parecem tão apetitosas, você cobiça seu poder e as engole.\nGlup.\nVocê sente uma energia sem precedentes, uma luz brilha no canto do seu olho.\nOlhando para baixo, as estrelas ainda brilham em seu estômago"
  },
  Event_59640_Name = {
    Text = "Estrela dos Desejos"
  },
  Event_59641_ChoiceDesc1 = {
    Text = "[Struggle Forward] Deletar 1 cartão de comando, ganhar Arg1 Sigilo Negro"
  },
  Event_59641_ChoiceDesc2 = {
    Text = "[Cortar o fio] Copiar 1 carta de comando, Infectar[(Skill.Arg1)]"
  },
  Event_59641_ChoiceDesc3 = {
    Text = "[Retidos] Escolha 1 cartão de comando entre 3 e obtenha a oração: [(EnchantConfig.Arg1)]"
  },
  Event_59641_Desc = {
    Text = "Você é empurrado para frente ao longo do caminho, todas as suas escolhas são manipuladas por fios invisíveis.\nVocê se esforça para mover as mãos, tentando agarrar tudo o que lhe importa.\nO destino do mundo está pendurado na ponta dos seus dedos.\nIncontáveis fios se entrelaçam, restringindo todo o seu corpo."
  },
  Event_59641_Name = {
    Text = "Mãos Manipuladas"
  },
  Event_59642_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59642_Desc = {
    Text = "Você limpa o sangue e as lágrimas dos olhos, mas mais sangue continua a fluir.\nO vermelho enche sua visão, pressagiando um sacrifício sangrento.\nVocê continua limpando, tremendo de dor, mas sem medo"
  },
  Event_59642_Name = {
    Text = "Minha fusão"
  },
  Event_59643_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59643_Desc = {
    Text = "Você acaricia a pedra mágica e a encaixa na chave de prata.\nA luz das estrelas brilha sobre você.\nVocê está deslumbrado"
  },
  Event_59643_Name = {
    Text = "Estrela dos Desejos"
  },
  Event_59644_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59644_Desc = {
    Text = "Você não se importa, mantém os olhos abertos, sua determinação se transforma em um grito teimoso.\nMesmo que se quebre e desapareça, você não recuará"
  },
  Event_59644_Name = {
    Text = "Minha fusão"
  },
  Event_59645_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59645_Desc = {
    Text = "Alguém está em silêncio.\nOlhando para o rosto desesperado dessa versão de você, sabe que eles não chegaram ao fim. \nVocê é quem foi mais longe, sua resposta é a única esperança"
  },
  Event_59645_Name = {
    Text = "Minha autointerrogativa"
  },
  Event_59646_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59646_Desc = {
    Text = "Você estende a mão, tentando agarrar estrelas cadentes, cristais brilhantes deslizam pelos seus dedos.\nFelicidade, tristeza, raiva, medo…\nVocê avidamente captura cada emoção, mas as vê desaparecer.\nA luz brilhante ilumina seu rosto, seus olhos se tornam negros e profundos."
  },
  Event_59646_Name = {
    Text = "Cristal emocional"
  },
  Event_59657_ChoiceDesc1 = {
    Text = "[Chame] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_59657_ChoiceDesc2 = {
    Text = "[Touch] Obtenha Relíquia de Ouro \"(RelicConfig.Arg1)\", Infectar \"(Skill.Arg2)\""
  },
  Event_59657_Desc = {
    Text = "Você vê a boneca em colapso.\nEla era a mais racional e fiel assistente, guardando todas as informações.\nAgora, parece não lembrar de nada.\nVocê vê lágrimas caindo dos olhos da boneca"
  },
  Event_59657_Name = {
    Text = "Lágrimas da Boneca"
  },
  Event_59658_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59658_Desc = {
    Text = "Você não desiste e tenta contatar o núcleo de energia dela.\nSe for mecânico, reiniciar deve consertar, certo?\nInfelizmente, a boneca insensível não lhe dá a chance ingênua.\nSeu recuo não resulta em compaixão da boneca, e você tem que lutar com todas as suas forças"
  },
  Event_59658_Name = {
    Text = "Lágrimas da Boneca"
  },
  Event_59659_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59659_Desc = {
    Text = "Você não quer danificar seus antigos companheiros.\nVocê clama pelo nome dela e dá todas as ordens, mas é em vão.\nA boneca traiu vocês, retornando à frieza dos inorgânicos"
  },
  Event_59659_Name = {
    Text = "Lágrimas da Boneca"
  },
  Event_60944_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60944_Desc = {
    Text = "Seu tempo está acabando, você escolheu a abordagem mais direta e rompeu o bloqueio. Os Despertados ficaram motivados e animados.\nQuanto aos inimigos mais alertas, não são problema"
  },
  Event_60944_Name = {
    Text = "Agente do Comitê de Revisão"
  },
  Event_60945_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60945_Desc = {
    Text = "Antes que o agente percebesse, vocês o contornaram e confiscaram sua arma. Antes que os reforços chegassem, vocês conseguiram sair.\nInfelizmente, a notícia se espalhou, e os próximos inimigos estarão mais preparados, talvez mais difíceis de enfrentar. Prepare-se"
  },
  Event_60945_Name = {
    Text = "Agente do Comitê de Revisão"
  },
  Event_60946_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60946_Desc = {
    Text = "O agente foi atraído por um assobio e se aproximou do seu esconderijo. No momento em que ele se aproximou, os Despertos atacaram juntos.\nUma emboscada perfeita, a crise foi resolvida para sempre"
  },
  Event_60946_Name = {
    Text = "Agente do Comitê de Revisão"
  },
  Event_60947_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60947_Desc = {
    Text = "Diante de muitos inimigos, você não pode enfrentá-los. Você se expõe sem resistir.\nVocê sabe que será levado para um ponto de detenção, parte do plano.\nDe lá, você escapará e encontrará um novo caminho"
  },
  Event_60947_Name = {
    Text = "Ponto de vigilância"
  },
  Event_60948_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60948_Desc = {
    Text = "Diante de inimigos em grande número, você não pode enfrentá-los. Após uma breve luta, vocês desistiram da resistência.  \nVocê sabe que será enviado para um ponto de detenção, que faz parte do plano.  \nVocês escaparão de lá, em busca de um novo caminho"
  },
  Event_60948_Name = {
    Text = "Ponto de vigilância"
  },
  Event_60949_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60949_Desc = {
    Text = "Diante de muitos inimigos, você não pode enfrentá-los.\nVocê escolhe sair temporariamente e procurar um novo caminho"
  },
  Event_60949_Name = {
    Text = "Ponto de vigilância"
  },
  Event_61058_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61058_Desc = {
    Text = "Você olhou para suas próprias mãos, para todo o seu corpo, cheio de esperança e determinação.\nSe tudo isso é o destino, você está pronto para enfrentar tudo.\nNo momento final, se houver um portão para o paraíso ou o inferno, você abrirá a porta para o mundo com suas próprias mãos"
  },
  Event_61058_Name = {Text = "Espiar"},
  Event_61059_ChoiceDesc1 = {
    Text = "[Preparar para a batalha] escolhe 1 entre 3 cartas de comando para obter a oração:[(EnchantConfig.Arg1)]"
  },
  Event_61059_ChoiceDesc2 = {
    Text = "[Continuar Observando] infecta[(Skill.Arg1)], reimpressão, no máximo 1 vez"
  },
  Event_61059_Desc = {
    Text = "Você não se apressou para a batalha, tentando calmamente entender a situação. Este maestro que apareceu de repente parece ser um inimigo e um amigo, e você não tem certeza do que ele está planejando. De qualquer forma, você decide se preparar bem, enfrentar seu desafio primeiro e depois observar lentamente o que ele realmente quer fazer."
  },
  Event_61059_Name = {
    Text = "Conduutor do Diabo"
  },
  Event_61060_ChoiceDesc1 = {
    Text = "[Listen] Obtenha 1 entre 3 Orações Avançadas"
  },
  Event_61060_ChoiceDesc2 = {
    Text = "[Gritar] Obtenha a Relíquia de Ouro \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_61060_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_61060_Desc = {
    Text = "Desde que o acidente aconteceu, você não recebeu mais notícias do seu parceiro. \n Incontáveis tentativas de contato foram feitas, como se uma pedra tivesse caído no mar sem eco. \n Quando você já havia perdido as esperanças, o comunicador de repente emitiu um som. \n Você abriu a mala e aproximou o fone de ouvido do seu ouvido. \n \"Guardião do Segredo...\" \n Em um momento de confusão, você ouviu a voz que sempre sentiu falta, como se estivesse ecoando distante através de camadas de vazio."
  },
  Event_61060_Name = {
    Text = "Ecos de Saudade"
  },
  Event_61061_ChoiceDesc1 = {
    Text = "[Embrace Darkness] Obtenha Relíquia de Prata \"(RelicConfig.Arg1)\", Infectar \"(Skill.Arg2)\""
  },
  Event_61061_ChoiceDesc2 = {
    Text = "[Tentar Nadar] Obter Relíquia de Prata \"(RelicConfig.Arg1)\", Infectado por \"(Skill.Arg2)\""
  },
  Event_61061_ChoiceDesc3 = {
    Text = "[Call the Spirit] Ganhe 25 Sinais Negros"
  },
  Event_61061_Desc = {
    Text = "Você correu para frente, mas o chão virou um mar intransitável.\nVocê caiu no solo.\nComo fantasmas em um cemitério, inúmeras trevas viscosas te cercaram, invadindo sua boca e nariz"
  },
  Event_61061_Name = {
    Text = "Enlamecer-se no solo"
  },
  Event_61062_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61062_Desc = {
    Text = "Você arregala os olhos, tentando buscar todos os indícios. \n Cem olhos giram ao mesmo tempo, você vê as patas de um cão humano correndo à sua frente, você vê a trajetória da batuta de Hameln balançando atrás de você. \n Você observa tudo com ganância. \n De repente, você vê um globo ocular familiar rolando no chão. \n Parece que é o seu próprio olho."
  },
  Event_61062_Name = {
    Text = "Ganância por Conhecimento"
  },
  Event_61063_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61063_Desc = {
    Text = "Não, você não pode ver tantas coisas.\nVocê só tem... quantos olhos mesmo?\nVocê fecha os olhos rapidamente e toca o rosto.\nUm, dois...\nQuando abre os olhos novamente, sua visão se torna estreita e ignorante.\nAfinal, você só tem dois olhos, que pena, que pena."
  },
  Event_61063_Name = {
    Text = "Ganância por Conhecimento"
  },
  Event_61064_ChoiceDesc1 = {
    Text = "[Buscar] Obtenha a Relíquia Amaldiçoada \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_61064_ChoiceDesc2 = {
    Text = "[Fechar os Olhos] 1 Carta de comando aleatória obtém Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_61064_Desc = {
    Text = "Cada vez mais pistas se entrelaçam em um emaranhado confuso, você se sente ansioso, perdido e furioso, odiando a si mesmo por não saber nada. \n Uma pressão enorme faz sua mente ficar tensa como um fio fino. \n Com um estalo, você sente seu couro cabeludo relaxar de repente, e você consegue ver toda a cena ao seu redor, vendo as sombras balançando no vazio. \n Mais, você precisa ver mais..."
  },
  Event_61064_Name = {
    Text = "Ganância por Conhecimento"
  },
  Event_61065_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61065_Desc = {
    Text = "Você nada no solo, imaginando-se como o peixe mais ágil.\nPara se tornar um peixe, você deve abandonar suas pernas humanas.\nEsse é o preço da troca.\nLogo, você se sente incrivelmente leve e se torna a criatura mais livre do subsolo.\nVocê volta à superfície, mas já esqueceu como andar"
  },
  Event_61065_Name = {
    Text = "Enlamecer-se no solo"
  },
  Event_61066_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61066_Desc = {
    Text = "A ponta dos seus dedos toca a familiar textura da chave de prata, que é o núcleo de toda luz.\nÉ a essência da sua vida, a encarnação do seu destino.\nAs experiências passadas passam diante dos seus olhos em um desfile.\nSuas escolhas estão firmemente ligadas às escolhas deste mundo.\nSeu destino já está intimamente conectado a muitas pessoas."
  },
  Event_61066_Name = {Text = "Espiar"},
  Event_61067_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61067_Desc = {
    Text = "Você sentiu muitas presenças amigáveis ao seu redor.\nVocê tentou chamar esses fantasmas talvez inexistentes.\nUm milagre aconteceu, você voltou à superfície.\nInúmeras lápides permaneciam em silêncio"
  },
  Event_61067_Name = {
    Text = "Enlamecer-se no solo"
  },
  Event_61068_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61068_Desc = {
    Text = "Você não tem tempo para lamentar, só quer salvar tudo que está desmoronando o mais rápido possível.\nSe você se tornar uma estrela, então que você se transforme em um meteoro.\nContanto que possa iluminar o céu noturno, mesmo que eventualmente caia"
  },
  Event_61068_Name = {Text = "Espiar"},
  Event_61069_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61069_Desc = {
    Text = "Você pressiona os ouvidos ainda mais, capturando todos os sons fragmentados em sua mente. \n \"Eu...\" \n \"Você deve...\" \n Você só consegue ouvir frases incompletas, sem conseguir discernir qualquer significado. \n Mas você não se atreve a falar, com medo de perder qualquer palavra. \n No entanto, o destino não lhe deu mais compaixão. \n O pouco que restava de som também desapareceu, e tudo ao redor voltou ao silêncio."
  },
  Event_61069_Name = {
    Text = "Ecos de Saudade"
  },
  Event_61070_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61070_Desc = {
    Text = "Você não continuou pensando, mas comandou os despertos a se alinharem para enfrentar o desafio dele"
  },
  Event_61070_Name = {
    Text = "Conduutor do Diabo"
  },
  Event_61071_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61071_Desc = {
    Text = "Você continua chamando o nome dela, tentando transmitir qualquer sentimento.\nVocê não sabe se ela ouviu, você tenta distinguir a voz indistinta no microfone.\nParece ser a resposta dela, ou talvez fragmentos do passado se repetindo.\nRepetindo as alegrias e tristezas que vocês compartilharam"
  },
  Event_61071_Name = {
    Text = "Ecos de Saudade"
  },
  Event_61072_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61072_Desc = {
    Text = "Talvez esta escuridão seja o verdadeiro mundo, o que há de errado em se juntar a ela?\nVocê aceitou completamente a escuridão, e a escuridão também não o rejeita mais, você consegue respirar livremente.\nNo segundo seguinte, você voltou à superfície, talvez algo tenha permanecido para sempre debaixo da terra, mas isso já não é importante."
  },
  Event_61072_Name = {
    Text = "Enlamecer-se no solo"
  },
  Event_61073_ChoiceDesc1 = {
    Text = "[Gaze at Light] Escolha 1 de 3 Cartas de Comando para ganhar uma Oração: \"(EnchantConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_61073_ChoiceDesc2 = {
    Text = "[Tocar o Peito] Escolha 1 Despertado para despertar, Infectar[(Skill.Arg1)]"
  },
  Event_61073_ChoiceDesc3 = {
    Text = "[Keep Running] Ganhe 25 sigilos negros"
  },
  Event_61073_Desc = {
    Text = "Você está confuso, só consegue correr desesperadamente, sem tempo para pensar em muito. \n De repente, você sente um vazio no peito. \n Ao olhar para baixo, vê uma luz em forma de chave no lugar onde estava seu coração. \n A luz fica cada vez mais brilhante, gradualmente se espalhando por todo o seu corpo. \n Você vê a si mesmo se transformando em uma estrela. \n De repente, você entende que talvez essa seja a missão que você sempre teve."
  },
  Event_61073_Name = {Text = "Espiar"},
  Event_61074_ChoiceDesc1 = {
    Text = "[Preparar para a batalha] escolhe 1 entre 3 cartas de comando para obter a oração:[(EnchantConfig.Arg1)]"
  },
  Event_61074_ChoiceDesc2 = {
    Text = "[Observar atentamente] infecção[(Skill.Arg1)] 、reimprimir, no máximo 2 vezes"
  },
  Event_61074_Desc = {
    Text = "\"Ei... espere! O que está acontecendo...\"\n\"Repetição.\"\nO homem te observa sem expressão.\n\"Manter o enlace do Corpo Desperto com a música é uma nova tentativa. Garantir o nível da orquestra é essencial para garantir a perfeição da performance.\"\nEle ergue a batuta e a move com clareza, desenhando uma elegante marcação de início no ar.\n\"Toque, Guardião do Segredo. Deixe-me ver o que você pode fazer.\""
  },
  Event_61074_Name = {
    Text = "Conduutor do Diabo"
  },
  Event_61075_ChoiceDesc1 = {
    Text = "[Preparar para a batalha] escolhe 1 entre 3 cartas de comando para obter a oração:[(EnchantConfig.Arg1)]"
  },
  Event_61075_Desc = {
    Text = "Seja qual for o objetivo dele, pelo menos ele te salvou do ataque do comitê de censura. Se ele quisesse te prejudicar, não precisaria te ajudar. Você se acalma e se prepara para o pior"
  },
  Event_61075_Name = {
    Text = "Conduutor do Diabo"
  },
  Event_65400_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65400_Desc = {
    Text = "O contato transmitiu a promessa de resgate, e ao ouvir que a equipe de resgate está tentando entrar na montanha, todos recuperaram a esperança"
  },
  Event_65400_Name = {
    Text = "Ponto de contato"
  },
  Event_65401_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65401_Desc = {
    Text = "Nenhum membro da equipe de pesquisa saiu da montanha nevada. Diante do desastre, você sempre escolheu a si mesmo; a vida das pessoas comuns não tem valor para você. Você abandonou a humanidade e chegou ao final em segurança.\nOs socorristas olham para você com complexidade, mas você permanece impassível, voltando para a tempestade de neve. Talvez, ao voltar a sonhar à meia-noite, as almas daqueles que morreram por sua indiferença cercarão sua cama, observando você em silêncio."
  },
  Event_65401_Name = {
    Text = "Ponto de Extração Seguro"
  },
  Event_65402_ChoiceDesc1 = {
    Text = "[Crowd Evacuation] Remover a relíquia \"Equipe de Expedição\" e ganhar diferentes níveis de \"Medalha de Resgate\" com base no número de membros da equipe de expedição."
  },
  Event_65402_Desc = {
    Text = "Você trouxe a equipe de pesquisa em segurança para o ponto de evacuação, e a equipe de resgate assumiu tudo. As pessoas resgatadas caíram no chão, como se estivessem em um mundo diferente. \n No entanto, você sabe que a verdadeira crise está longe de ser resolvida, aquela besta gigante ainda está instalada nas montanhas, esperando faminta por vocês."
  },
  Event_65402_Name = {
    Text = "Ponto de Extração Seguro"
  },
  Event_65403_ChoiceDesc1 = {
    Text = "[Supply Trade] Ganhar 25 sigilos negros, +1 por membro da expedição (Arg1)."
  },
  Event_65403_ChoiceDesc2 = {
    Text = "[Rescue Promise] Escolha ganhar 1 oração. Adicione 2 membros da expedição."
  },
  Event_65403_ChoiceDesc3 = {
    Text = "[Lucro Primeiro] Perder 10 membros da expedição e escolher receber uma Relíquia de Ouro+."
  },
  Event_65403_Desc = {
    Text = "Vocês lutam contra a neve, seguindo a luz intermitente do posto de emergência.\n    ○ Finalmente, após inúmeras orações, vocês veem a cabana da esperança"
  },
  Event_65403_Name = {
    Text = "Ponto de contato"
  },
  Event_65403_Tips3 = {
    Text = "Equipe de pesquisa insuficiente"
  },
  Event_65404_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65404_Desc = {
    Text = "Vocês ouviram a senha do armazém do escritório de contatos e encontraram suprimentos suficientes para todos por dois dias; parabéns, pelo menos não morrerão de fome nas montanhas nevadas"
  },
  Event_65404_Name = {
    Text = "Ponto de contato"
  },
  Event_65415_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_65415_Desc = {
    Text = "A montanha nevada devorou rapidamente, duas pessoas desapareceram nas fendas profundas do gelo, e vocês não sabiam de nada"
  },
  Event_65415_Name = {Text = "Ilusão"},
  Event_65416_ChoiceDesc1 = {
    Text = "[Leave] Encontrar farol de busca"
  },
  Event_65416_ChoiceDesc2 = {
    Text = "[Snow Intrusion] Perder 2 membros da expedição."
  },
  Event_65416_Desc = {
    Text = "De repente, um vento forte soprou na montanha nevada, o som do vento parecia o grito de uma besta gigante, a névoa branca cegou seus olhos, algo parecia se mover na névoa infinita.\nVocês foram forçados a parar, cravando as pernas na neve para não rolar montanha abaixo"
  },
  Event_65416_Name = {
    Text = "desconhecido"
  },
  Event_65417_ChoiceDesc1 = {
    Text = "[Silent Evaporation] Perder 2 membros da expedição."
  },
  Event_65417_ChoiceDesc2 = {Text = "[Leave]"},
  Event_65417_Desc = {
    Text = "O rugido da montanha nevada vinha de suas entranhas, como o grito insatisfeito de uma besta faminta, a terra tremeu, o gelo sob a neve rachou, como se a montanha estivesse abrindo a boca.\nQuando o tremor finalmente parou, as pessoas olharam ao redor confusas, você verificou a equipe"
  },
  Event_65417_Name = {Text = "Ilusão"},
  Event_65468_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65468_Desc = {
    Text = "Para garantir a mobilidade da equipe, você abandonou a parte mais difícil do grupo, deixando-os nesta cabana isolada. Isso pode aumentar a taxa de sobrevivência dos remanescentes, mas ao olhar para aqueles olhos cheios de rancor e descontentamento, você não sente nenhuma emoção?"
  },
  Event_65468_Name = {
    Text = "Ponto de contato"
  },
  Event_65483_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65483_Desc = {
    Text = "Você salvou algumas pessoas, mas muitas mais ficaram para sempre na montanha nevada; de qualquer forma, você fez o seu melhor.\nOs socorristas disseram que sua contribuição seria homenageada posteriormente. Você acenou com a mão e voltou a entrar na tempestade de neve"
  },
  Event_65483_Name = {
    Text = "Ponto de Extração Seguro"
  },
  Event_65484_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65484_Desc = {
    Text = "Você não se importou com os outros e, para sair da montanha nevada, adotou a abordagem mais eficiente. Para os últimos sobreviventes, você pode parecer um demônio.\nOs socorristas disseram que sua contribuição seria homenageada posteriormente. Você acenou com a mão e voltou a entrar na tempestade de neve."
  },
  Event_65484_Name = {
    Text = "Ponto de Extração Seguro"
  },
  Event_65485_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65485_Desc = {
    Text = "Sob sua proteção incansável, toda a equipe de pesquisa sobreviveu sem ferimentos. Encontrar você foi a maior sorte em meio ao infortúnio; você é o verdadeiro salvador deles. \n Você criou um milagre em meio à calamidade, e as histórias sobre o herói da montanha nevada podem logo se espalhar por toda parte. Os socorristas afirmaram solenemente que sua contribuição excepcional seria reconhecida em breve. Você sorriu, acenou com a mão e voltou a entrar na tempestade de neve."
  },
  Event_65485_Name = {
    Text = "Ponto de Extração Seguro"
  },
  Event_65486_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65486_Desc = {
    Text = "Você realmente se importa com a vida das pessoas, a maioria foi salva por você. As pessoas choram de gratidão, agradecendo sua proteção.\nOs socorristas afirmam que sua contribuição será reconhecida, você sorri e acena, voltando para a tempestade de neve"
  },
  Event_65486_Name = {
    Text = "Ponto de Extração Seguro"
  },
  Event_65487_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65487_Desc = {
    Text = "Você enfrentou desastres imprevisíveis e resgatou pessoas das garras da morte. Graças aos seus esforços, o trágico destino foi ligeiramente alterado.\nOs socorristas reconheceram sua valiosa contribuição e prometeram homenageá-lo. Você sorriu, acenou e voltou para a tempestade de neve"
  },
  Event_65487_Name = {
    Text = "Ponto de Extração Seguro"
  },
  Event_6817_ChoiceDesc1 = {
    Text = "[Stop Here] Ganhe uma Oração de 3 escolhas"
  },
  Event_6817_ChoiceDesc2 = {
    Text = "[Continuar lendo] 1 Carta de comando aleatória obtém Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_6817_Desc = {
    Text = "No topo da estante de madeira, há um livro com uma capa dourada. Não é possível ver o nome do livro a partir do chão. \n Não sei por que, você sente um desejo de lê-lo... Esse desejo rapidamente se expande até se tornar incontrolável, e ignorando o risco de perturbar os outros, você sobe a escada de madeira ao lado da estante, pega o livro e começa a lê-lo ansiosamente... \n Impressões nebulosas surgem no mar da sua mente, e você se afunda no oceano da ilusão..."
  },
  Event_6817_Name = {
    Text = "Pergaminho amarelo"
  },
  Event_6818_ChoiceDesc1 = {
    Text = "[Ouvir] Escolha 1 de 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_6818_ChoiceDesc2 = {
    Text = "[Ensemble] Ganhe 15 Sigilos Negros para cada Despertador com um Aliemus de 50 ou mais."
  },
  Event_6818_ChoiceDesc3 = {
    Text = "[Leave] Obter 1 de 3 Orações"
  },
  Event_6818_Desc = {
    Text = "O som do piano chega de repente aos seus ouvidos. Dedos verdes dançam nas teclas, e a melodia elegante flui como um riacho.\n\"Querido amigo, quer tocar uma música comigo?\"\nAs mãos não falam, mas a música faz a pergunta"
  },
  Event_6818_Name = {
    Text = "Fantasma ao lado do piano"
  },
  Event_6819_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6819_Desc = {
    Text = "Ramona olhou para a origem do som, mas só conseguiu ver uma ilusão que se desfazia, parecendo uma vitrola fundida na parede"
  },
  Event_6819_Name = {
    Text = "O ouvido alheio"
  },
  Event_6820_ChoiceDesc1 = {
    Text = "[Clean the Typewriter] Deletar 1 Cartão de Comando, Ganhar 25 Sigilos Negros"
  },
  Event_6820_ChoiceDesc2 = {
    Text = "[Tente Identificar Texto] Copie uma carta do baralho, infecte [(Skill.Arg1)]"
  },
  Event_6820_Desc = {
    Text = "A máquina de escrever na mala de repente jorra tinta espessa, espalhando-se com o balanço do trem"
  },
  Event_6820_Name = {
    Text = "O Sussurro da Máquina de Escrever"
  },
  Event_6821_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6821_Desc = {
    Text = "No instante em que o punho dispersou o fantasma, as memórias invadiram sua mente, relembrando de momentos que colidiam com sua alma, causando uma dor surda"
  },
  Event_6821_Name = {Text = "Miragem"},
  Event_6822_ChoiceDesc1 = {
    Text = "[Descartar o Papel da Carta] Remover 1 Cartão"
  },
  Event_6822_ChoiceDesc2 = {
    Text = "[Keep Close] Obter \"(RelicConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_6822_Desc = {
    Text = "Você puxa algumas folhas da máquina de escrever, o cheiro de tinta fresca é forte. Ao ler o conteúdo, você franze a testa.\nA maior parte da carta foi apagada, e o que resta é ilegível"
  },
  Event_6822_Name = {
    Text = "Carta riscada"
  },
  Event_6823_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6823_Desc = {
    Text = "Você se esforça para decifrar a caligrafia borrada no papel. Elas se distorcem continuamente, depois revelam um conteúdo completamente diferente. \n \"Eu acho que você já viu a notícia no jornal. \n Sim, seu pai já o removeu da linha de herança... Nós também não queremos @2 \n o diabo, o diabo... \n Por favor, pare imediatamente de se relacionar com aquele senhor Herbert, caso contrário, eu irei interromper sua assistência financeira...\""
  },
  Event_6823_Name = {
    Text = "Como se estivéssemos frente a frente"
  },
  Event_6824_ChoiceDesc1 = {
    Text = "[Hold Silver Key] Escolha 1 de 3 cartões de comando para ganhar uma Oração: \"(EnchantConfig.Arg1)\", e infecta \"(Skill.Arg2)\"."
  },
  Event_6824_ChoiceDesc2 = {
    Text = "[Fechar os Olhos] Escolha 1 Entidade para despertar, Infecte[(Skill.Arg1)]"
  },
  Event_6824_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_6824_Desc = {
    Text = "Você é dilacerado por uma onda colossal de absurdidade, arrastando-se pelo chão com membros distorcidos, como se fosse manipulado por @2 de fora da dimensão. \n \"Não... não...\" \n Sua sanidade desmorona a cada instante, risadas e gritos delirantes se entrelaçam, como uma rede colossal que aprisiona sua consciência, e só há um lamento indistinto prestes a escapar de seus lábios."
  },
  Event_6824_Name = {
    Text = "Olho do olhar"
  },
  Event_6825_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6825_Desc = {
    Text = "Deixe-o para o Guardião do Segredo, não sabemos que tipo de ser ele pode despertar"
  },
  Event_6825_Name = {
    Text = "Núcleo de prata solitário"
  },
  Event_6826_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6826_Desc = {
    Text = "Uma melodia triste flui, enchendo a mente e a alma de dor. Quando percebe, os olhos de alguém já estão úmidos"
  },
  Event_6826_Name = {
    Text = "Som Anônimo"
  },
  Event_6827_ChoiceDesc1 = {
    Text = "[abrir a porta esquerda] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_6827_ChoiceDesc2 = {
    Text = "[Abrir a Porta Certa] Obter Relíquia de Ouro \"(RelicConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_6827_Desc = {
    Text = "Porta. Porta. Incontáveis portas. \n O número de portas parece ser muito maior do que quando você e Ramona fizeram a ronda. \n Vocês pararam no corredor, prontos para empurrar a próxima porta. \n Atrás da porta à esquerda, há um silêncio absoluto, esperando com sutileza e contenção pela sua chegada. \n Atrás da porta à direita, pode-se ouvir uma conversa confusa."
  },
  Event_6827_Name = {
    Text = "Porta Infinita"
  },
  Event_6828_ChoiceDesc1 = {
    Text = "[Listen Closely] Ganhe uma relíquia prata \"(RelicConfig.Arg1)\" e inflija \"(Skill.Arg2)\""
  },
  Event_6828_ChoiceDesc2 = {
    Text = "[Plug Ears] Obtenha uma Oração com 3 escolhas"
  },
  Event_6828_Desc = {
    Text = "Você só pode ouvir o som frenético das teclas do piano, que chega como uma tempestade, como o estrondo de um meteoro atingindo o chão, fazendo todo o piano tremer. \n Os martelos batendo nas cordas rangem, e os pedais saltitantes emitem um lamento profundo. \n Na música enganosa, a melodia familiar é arrastada, raspando em seu tímpano."
  },
  Event_6828_Name = {
    Text = "Som proibido"
  },
  Event_6829_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6829_Desc = {
    Text = "\"O Investigador William forneceu entrega de inventário de emergência; toque em seu broche três vezes após o recebimento para confirmação.\""
  },
  Event_6829_Name = {
    Text = "Comunicação de apoio"
  },
  Event_6830_ChoiceDesc1 = {
    Text = "[Empurrar a Porta da Esquerda] Obter Oração de 3 escolhas"
  },
  Event_6830_ChoiceDesc2 = {
    Text = "[Push the Right Door] Escolha 1 de 3 cartões de comando para obter uma oração: \"(EnchantConfig.Arg1)\", e infecte \"(Skill.Arg2)\""
  },
  Event_6830_Desc = {
    Text = "Porta. Porta. Incontáveis portas. \n O número de portas parece ser muito maior do que quando você e Ramona estavam patrulhando. \n Vocês pararam no corredor, prontos para empurrar a próxima porta. \n Atrás da porta à esquerda, há um silêncio profundo, esperando discretamente pela sua presença. \n Atrás da porta à direita, ouve-se uma conversa confusa."
  },
  Event_6830_Name = {
    Text = "Porta sem fim"
  },
  Event_6831_ChoiceDesc1 = {
    Text = "[Ler a Carta] Remover 1 cartão de comando, ganhar Arg1 sigilos negros"
  },
  Event_6831_ChoiceDesc2 = {
    Text = "[Close the Box]"
  },
  Event_6831_Desc = {
    Text = "A mala treme incessantemente, como se uma vida estivesse prestes a emergir.\nVocê abre a mala involuntariamente, papéis voam como borboletas"
  },
  Event_6831_Name = {
    Text = "Carta inesperada"
  },
  Event_6832_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6832_Desc = {
    Text = "O toque urgente do telefone te deixou ansioso, você pegou o fone e o colocou na mesa. O toque parou abruptamente, deixando um eco na sua mente"
  },
  Event_6832_Name = {
    Text = "Ligação do trem"
  },
  Event_6833_ChoiceDesc1 = {
    Text = "[Pegue a foto] escolha 1 de 3 cartas de comando e ganhe oração: [(EnchantConfig.Arg1)]"
  },
  Event_6833_ChoiceDesc2 = {
    Text = "[Check film] infecção[(Skill.Arg1)], trocando a oração obtida na opção 1, pode ser utilizada duas vezes"
  },
  Event_6833_Desc = {
    Text = "No canto do estúdio havia uma câmera antiga, alguns rolos de filme e fotos espalhadas. Elas registram fielmente o trabalho e a estética do escultor de cera"
  },
  Event_6833_Name = {
    Text = "registrar fielmente"
  },
  Event_6834_ChoiceDesc1 = {
    Text = "[Continue Questioning] Aumentar saúde máxima em Arg1"
  },
  Event_6834_ChoiceDesc2 = {
    Text = "[Agarrar a Sombra] Escolha 1 de 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_6834_Desc = {
    Text = "A sombra canta em poeira dourada:\n\"Quem conhece a verdade...\nCom a chave como seu cetro, guiará o caminho.\"\nUm ditado antigo.\nSua intuição diz que está perto da verdade que você busca.\nE sua intuição está sempre certa"
  },
  Event_6834_Name = {
    Text = "Usador de chave de prata"
  },
  Event_6835_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6835_Desc = {
    Text = "Você concordou com os delírios, quase sendo levado pela loucura"
  },
  Event_6835_Name = {
    Text = "Cerimônia Aquática"
  },
  Event_6836_ChoiceDesc1 = {
    Text = "[Chame os corvos] ganha 30 sigilos negros, infecta[(Skill.Arg2)], continua a escolha"
  },
  Event_6836_ChoiceDesc2 = {
    Text = "[Fique Longe]"
  },
  Event_6836_Desc = {
    Text = "Você não vai embora, e eles também não.\nCordas estranhas conectam suas mentes, parece que eles têm algo a dizer"
  },
  Event_6836_Name = {
    Text = "Corvo Solitário"
  },
  Event_6837_ChoiceDesc1 = {
    Text = "[Desista da Resistência] Delete 1 carta de comando, ganhe Arg1 Sigilo Negro"
  },
  Event_6837_ChoiceDesc2 = {
    Text = "[Puxe as Mãos para Trás]"
  },
  Event_6837_Desc = {
    Text = "Uma, duas, três... \nNo rosto, nos dedos, borboletas em grupo brilhavam como fogos de artifício no escuro.\nEsta máquina de escrever não tem utilidade prática, mas é excelente em criar beleza"
  },
  Event_6837_Name = {
    Text = "Inspiração súbita"
  },
  Event_6838_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6838_Desc = {
    Text = "Há coisas mais importantes na sua frente, você fechou a caixa decidido a ignorá-las, e a máquina de escrever ficou em silêncio"
  },
  Event_6838_Name = {
    Text = "Aviso Não Convidado"
  },
  Event_6839_ChoiceDesc1 = {
    Text = "[Ouvir a Lua] Infectar[(Skill.Arg1)]"
  },
  Event_6839_ChoiceDesc2 = {
    Text = "[Ouvir Estrela Anã] Infectar[(Skill.Arg1)]"
  },
  Event_6839_ChoiceDesc3 = {
    Text = "[Listen to the Meteor] Perda de 25 sigilos negros"
  },
  Event_6839_Desc = {
    Text = "Quente, brilhante, eterno"
  },
  Event_6839_Name = {
    Text = "Som das estrelas e da lua"
  },
  Event_6840_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6840_Desc = {
    Text = "No centro da luz há um núcleo prateado solidificado, mas a razão diz que ele não brilha.\nSeu olhar segue a fonte da luz, mas cai na armadilha da escuridão e do desconhecido"
  },
  Event_6840_Name = {
    Text = "Luz noturna"
  },
  Event_6841_ChoiceDesc1 = {
    Text = "[Sair] escolha 1 carta dentre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_6841_Desc = {
    Text = "Norte, saída norte!\nComo a decisão de Ramona, o norte deve ter uma saída"
  },
  Event_6841_Name = {
    Text = "Em direção ao norte"
  },
  Event_6842_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6842_Desc = {
    Text = "Oh... A prata impecável representa a piada da alma com você.\nQual será sua próxima escolha?"
  },
  Event_6842_Name = {
    Text = "A apresentação começa"
  },
  Event_6843_ChoiceDesc1 = {
    Text = "[Partir] Escolha 1 de 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_6843_Desc = {
    Text = "Você balança a cabeça, afastando o som.\nUm suspiro quase inaudível traz um pouco de ajuda"
  },
  Event_6843_Name = {
    Text = "Em direção ao norte"
  },
  Event_6844_ChoiceDesc1 = {
    Text = "[Explorar o corredor] infectar[(Skill.Arg1)], continuar avançando?"
  },
  Event_6844_ChoiceDesc2 = {
    Text = "[Vá Contra a Corrente] Ganhe 25 sigilos negros"
  },
  Event_6844_Desc = {
    Text = "A luz da lua desaparece, engolida pelo corredor, restando apenas uma porta sinistra à sua frente."
  },
  Event_6844_Name = {
    Text = "Galeria silenciosa"
  },
  Event_6845_ChoiceDesc1 = {
    Text = "[Deep into the corridor] vence 1 carta de comando aleatória para ganhar oração:[(EnchantConfig.Arg1)], quer continuar?"
  },
  Event_6845_ChoiceDesc2 = {
    Text = "[Vá Contra a Corrente] Ganhe 25 sigilos negros"
  },
  Event_6845_Desc = {
    Text = "Desconhecido, não deve ser explorado"
  },
  Event_6845_Name = {
    Text = "Galeria silenciosa"
  },
  Event_6846_ChoiceDesc1 = {
    Text = "[Explorar o corredor] infectar[(Skill.Arg1)], continuar avançando?"
  },
  Event_6846_ChoiceDesc2 = {
    Text = "[Vá Contra a Corrente] Ganhe 25 sigilos negros"
  },
  Event_6846_Desc = {
    Text = "A porta à esquerda soltou uma risada sinistra, tremendo levemente e espalhando malícia"
  },
  Event_6846_Name = {
    Text = "Galeria silenciosa"
  },
  Event_6847_ChoiceDesc1 = {
    Text = "[Deep into the corridor] ganha relíquia de prata[(RelicConfig.Arg1)], quer continuar?"
  },
  Event_6847_ChoiceDesc2 = {
    Text = "[Vá Contra a Corrente] Ganhe 25 sigilos negros"
  },
  Event_6847_Desc = {
    Text = "A porta à direita está aberta, sangue se espalha pelo chão em um caminho definido"
  },
  Event_6847_Name = {
    Text = "Galeria silenciosa"
  },
  Event_6848_ChoiceDesc1 = {
    Text = "[There's nothing left, and you back out.]"
  },
  Event_6848_Desc = {
    Text = "Quem disse que você precisa ser imprudente? Às vezes, recuar pode abrir novos horizontes"
  },
  Event_6848_Name = {
    Text = "Galeria silenciosa"
  },
  Event_6849_ChoiceDesc1 = {
    Text = "[Repair Wax Sculpture] Escolha um cartão e reduza seu custo de Aritmética em 1"
  },
  Event_6849_Desc = {
    Text = "O trabalho de restauração da estátua de cera está em andamento. \n Você não é um escultor de cera profissional e nunca recebeu uma educação estética sistemática. \n Mas você ainda começa a moldar, esculpir e pintar com habilidade... \n Como se você tivesse nascido segurando uma ferramenta de escultura. \n Como se ela tivesse nascido incompleta, apenas esperando a sua escultura."
  },
  Event_6849_Name = {
    Text = "Estátua de Cera Inacabada"
  },
  Event_6850_ChoiceDesc1 = {
    Text = "[Repair Wax Sculpture] Escolha um cartão e reduza seu custo de Aritmética em 1"
  },
  Event_6850_Desc = {
    Text = "Galatea, Galatea...\nSeguindo o chamado mais uma vez, você encontrou a escultura de cera inacabada.\nEla parecia perfeita, até inquietantemente perfeita.\n\"A feiura é uma lágrima na perfeição.\"\nNo momento final, você decide fazer algo."
  },
  Event_6850_Name = {
    Text = "Estátua de Cera Inacabada"
  },
  Event_6851_ChoiceDesc1 = {
    Text = "[Aceitar a Ilusão] 1 Carta de comando aleatória obtém Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_6851_ChoiceDesc2 = {
    Text = "[Negar ilusão] escolhe 1 entre 3 cartas de comando para ganhar uma oração:[(EnchantConfig.Arg1)]"
  },
  Event_6851_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_6851_Desc = {
    Text = "Sob a pesada escuridão da ponte de ferro, na silenciosa margem do rio coberta de juncos, de repente, uma borboleta brilhante voa. \n A borboleta pousa levemente na sua palma, o terrível grito cessa, sendo substituído pelo rugido do trem passando sobre a estrutura de aço enferrujada, o estalo do carvão queimando e o atrito metálico dos eixos girando..."
  },
  Event_6851_Name = {
    Text = "Ilusão Ferroviária"
  },
  Event_6852_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6852_Desc = {
    Text = "Sim, fuga, você está sendo perseguido por algum tipo de criatura, o instinto de sobrevivência faz você correr descontroladamente até não haver mais para onde ir. Não, deveria ser sem escapatória... não era o cão infernal?"
  },
  Event_6852_Name = {Text = "Correr"},
  Event_6853_ChoiceDesc1 = {
    Text = "\"[Isso não é real]\" Obtido a relíquia de prata \"(RelicConfig.Arg1)\""
  },
  Event_6853_ChoiceDesc2 = {
    Text = "[Falling, falling...] Obter uma relíquia de ouro \"(RelicConfig.Arg1)\" e ficar infectado com \"(Skill.Arg2)\"."
  },
  Event_6853_Desc = {
    Text = "O espelho caído no chão tem uma moldura requintada, dentro da moldura há outra moldura, e assim por diante...\nAlice salta e continua caindo no buraco do coelho sem fim, vendo espelhos e mentes presas, mas nunca a si mesma"
  },
  Event_6853_Name = {
    Text = "Espelho no espelho"
  },
  Event_6854_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6854_Desc = {
    Text = "Você observa as montanhas nevadas através da tela de vento e neve, várias formigas pretas perseguindo uma formiga preta...\nSeu pensamento é interrompido"
  },
  Event_6854_Name = {
    Text = "Memórias vulcânicas"
  },
  Event_6855_ChoiceDesc1 = {
    Text = "[Step Forward and Grip] Ganhe 25 Sigilos Negros"
  },
  Event_6855_ChoiceDesc2 = {
    Text = "[Resposta Amigável] 50% de chance de ganhar 50 Sigilos Negros, 50% de chance de nada."
  },
  Event_6855_Desc = {
    Text = "Um gato que não se sabe de onde vem está sentado entre os limos, seu corpo borrado indicando que deveria ser um residente da dimensão espiritual.  \nEssa projeção de rosto indefinido observa Ramona com um olhar sábio, levantando sua pata dianteira branca, como um gesto de convite"
  },
  Event_6855_Name = {
    Text = "Residentes Nômades"
  },
  Event_6856_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6856_Desc = {
    Text = "Uma imagem alegre de um grupo de pessoas.\nAs figuras de cera estavam vestidas elegantemente, sentadas em cadeiras com sorrisos exagerados.\nElas eram tão harmoniosas quanto qualquer cena em um asilo.\n\nAssinado: Hongji 305, @2 Rogers"
  },
  Event_6856_Name = {
    Text = "Galeria de Retratos"
  },
  Event_6857_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6857_Desc = {
    Text = "Você cuidadosamente retirou o fragmento e o inspecionou. Ele ficou imóvel novamente.\n\"Desajeitado, não se mexa,\" Dorle deu um leve tapinha na sua nuca, \"por um tempo, não consigo fazer outro para você.\""
  },
  Event_6857_Name = {
    Text = "Broche Inquieto"
  },
  Event_6858_ChoiceDesc1 = {Text = "[Use Key]"},
  Event_6858_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6858_Desc = {
    Text = "Uma porta bloqueia seu caminho. Você tentou de tudo, mas ela não se move"
  },
  Event_6858_Name = {
    Text = "Porta enferrujada"
  },
  Event_6858_Tips1 = {
    Text = "Chave Enferrujada necessária"
  },
  Event_6859_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6859_Desc = {
    Text = "Você se sente envergonhado pela sua precipitação. \n Um Guardião do Segredo qualificado deve ser rigoroso, você não deve fazer julgamentos apressados de que não são \"produtos de alta qualidade\". \n Então você decide observá-los com atenção. Cinco minutos se passaram, dez minutos se passaram... \n Bem, agora você pode fazer um julgamento - \n realmente são produtos de baixa qualidade."
  },
  Event_6859_Name = {Text = "Alma Presa"},
  Event_6860_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6860_Desc = {
    Text = "Você e seus companheiros largaram as armas.\nNão por bondade, mas porque sabiam que seus corpos frágeis não aguentariam muito.\nE você estava certo"
  },
  Event_6860_Name = {Text = "Estudo"},
  Event_6861_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6861_Desc = {
    Text = "\n\"Venha me perseguir!\"\n\"Anda logo, seu tolo!\"\n\"Se puder, nos pegue!\"\nAs vozes das crianças estavam cheias de orgulho.\n\"Droga! Pare aí!\"\nA voz do adulto estava ofegante."
  },
  Event_6861_Name = {
    Text = "Nossas Memórias"
  },
  Event_6862_ChoiceDesc1 = {
    Text = "[Entrar] Através da névoa, alcance o outro lado."
  },
  Event_6862_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6862_Desc = {
    Text = "Esta é a pessoa que você procurava, missão cumprida"
  },
  Event_6862_Name = {
    Text = "Caminho secreto de mão única 26"
  },
  Event_6863_ChoiceDesc1 = {
    Text = "[Sair] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_6863_Desc = {
    Text = "Ah! Quase! Espere, por que três dados deram dez pontos!\nOs dados estão quietos na sua frente, parecendo inocentes"
  },
  Event_6863_Name = {
    Text = "Jogo de Apostas Sem Fim"
  },
  Event_6864_ChoiceDesc1 = {
    Text = "[Sair] ganha relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_6864_Desc = {
    Text = "Maldito! Não são seis pontos, mas ainda ganhei algo.\nEntão, quantos pontos são?"
  },
  Event_6864_Name = {
    Text = "Jogo de Apostas Sem Fim"
  },
  Event_6865_ChoiceDesc1 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_6865_Desc = {
    Text = "Embora não tenha acertado, posso aceitar.\nEi, qual foi o resultado?"
  },
  Event_6865_Name = {
    Text = "Jogo de Apostas Sem Fim"
  },
  Event_6866_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6866_Desc = {
    Text = "Você abaixa a cabeça, juntando pedaços de gesso, reconstruindo-a. Parte do corpo dela toma forma em suas mãos"
  },
  Event_6866_Name = {
    Text = "Montar os restos"
  },
  Event_6867_ChoiceDesc1 = {
    Text = "[Pick Up Key]"
  },
  Event_6867_Desc = {
    Text = "Um molho de chaves enferrujadas. Pode ser usado para abrir fechaduras"
  },
  Event_6867_Name = {
    Text = "Chave enferrujada"
  },
  Event_6868_ChoiceDesc1 = {
    Text = "[Positive] 50% de chance de obter uma Relíquia de Ouro \"(RelicConfig.Arg2)\", 50% de chance de ser infectado com \"(Skill.Arg3)\""
  },
  Event_6868_ChoiceDesc2 = {
    Text = "[Contraposição] 50% de chance de ganhar 75 sigilos negros, 50% de chance de infectar[(Skill.Arg3)]"
  },
  Event_6868_ChoiceDesc3 = {
    Text = "[Let Them Choose] 50% de chance de obter uma Relíquia Amaldiçoada \"(RelicConfig.Arg2)\", 50% de chance de infectar \"(Skill.Arg3)\""
  },
  Event_6868_Desc = {
    Text = "Apenas uma aposta, você não vai perder.\nUma moeda gravada foi lançada ao ar, caindo rapidamente, aquecida pela sua palma"
  },
  Event_6868_Name = {
    Text = "Jogador de Azar Famoso"
  },
  Event_6869_ChoiceDesc1 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_6869_Desc = {
    Text = "\"Aqueles que confiam na favorabilidade do destino também serão derrubados por ele.\"\nVocê decide partir."
  },
  Event_6869_Name = {
    Text = "Jogador de Azar Famoso"
  },
  Event_6870_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6870_Desc = {
    Text = "\"Guardião.\"\nA voz de Ramona traz você de volta à realidade, mas a sensação de queda não desaparece."
  },
  Event_6870_Name = {
    Text = "Espelho no espelho"
  },
  Event_6871_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6871_Desc = {
    Text = "Dizem que a serenata é uma canção de amor.\nNa noite de verão, fora da janela do amante, as pessoas tocam uma melodia suave em pequenos grupos.\nEspontânea e superficial, não é do gosto de Rogers, mas ainda assim se tornou uma de suas músicas favoritas.\nTalvez só ele saiba o porquê"
  },
  Event_6871_Name = {Text = "gosto ruim"},
  Event_6872_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6872_Desc = {
    Text = "Você se recusa a ser seduzido pelo delírio deles. \n Você diz: \"Mentiras! Vocês estão presos na escuridão eterna, como podem atravessar o universo?\" \n Os olhos começaram a rir. Incontáveis risadas se juntaram em uma onda sonora enorme, e seu coração também tremia. \n Os olhos disseram: \"Através do roubo de outros olhos. Cada olho é um universo. Quando você tiver mil olhos, você embarcará na verdadeira jornada no tempo e no espaço.\""
  },
  Event_6872_Name = {Text = "olho"},
  Event_6873_ChoiceDesc1 = {
    Text = "[Receive] Escolha 1 entre 3 relíquias de ouro"
  },
  Event_6873_Desc = {
    Text = "Oh, sim, aquele reflexo odioso é você.\nA malícia jorra e se mistura com a lama negra aos seus pés, dançando distorcidamente. Se não se importar, ela quer subir em seu ombro"
  },
  Event_6873_Name = {
    Text = "Sob a superfície do espelho"
  },
  Event_6874_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6874_Desc = {
    Text = "Não demorou muito, as restrições se afrouxaram abruptamente, fazendo você tropeçar. \nVocê olhou para os fios silenciosos — \"Não perturbe a areia movediça\", essa frase talvez também se aplique no domínio"
  },
  Event_6874_Name = {Text = "Enredado"},
  Event_6875_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6875_Desc = {
    Text = "A chama da sabedoria espiritual acendeu, queimando todas as amarras—\nPelo menos, é o que você pensa"
  },
  Event_6875_Name = {Text = "Enredado"},
  Event_6876_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6876_Desc = {
    Text = "Libertar-se com força, fios cortam a roupa, deixando marcas de sangue na pele.\nEmbora a teia tenha cobrado um pedágio, a sensação de alívio é inegável—você está livre"
  },
  Event_6876_Name = {Text = "Enredado"},
  Event_6877_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6877_Desc = {
    Text = "A carta gerada pelas excrescências de corrosão, a maioria das informações nela é apagada.\nVocê não conseguiu obter informações valiosas da carta, então a rasgou e jogou fora"
  },
  Event_6877_Name = {
    Text = "Capítulo Borboleta"
  },
  Event_6878_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6878_Desc = {
    Text = "Mesmo que as palavras sejam apagadas, você ainda pode sentir claramente o valor da carta"
  },
  Event_6878_Name = {
    Text = "Capítulo Borboleta"
  },
  Event_6879_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6879_Desc = {
    Text = "Cuidado.\nRamona se abaixou, voltou ao corredor e entrou no próximo quarto"
  },
  Event_6879_Name = {
    Text = "Reflexo na janela"
  },
  Event_6880_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6880_Desc = {
    Text = "Você soltou um grito desesperado.\nOs corvos, atraídos pelo seu som, logo desapareceram, deixando marcas negras"
  },
  Event_6880_Name = {
    Text = "Canto dos Corvos"
  },
  Event_6881_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6881_Desc = {
    Text = "Você se encolheu, tentando se tornar um ponto negro.\nAssim, eles não te notariam, certo?\nDepois de um tempo, você abriu os olhos.\nVocê viu a luz"
  },
  Event_6881_Name = {
    Text = "Canto dos Corvos"
  },
  Event_6882_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6882_Desc = {
    Text = "A sombra escorreu entre os dedos, deixando um rastro de poeira dourada"
  },
  Event_6882_Name = {
    Text = "Usador de chave de prata"
  },
  Event_6883_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6883_Desc = {
    Text = "Você esfregou o cabelo desajeitadamente, imaginações e delírios explodindo na sua mente, um bloco coberto de muco negro escondido no fundo.\nDissecá-lo, que presente isso te daria?"
  },
  Event_6883_Name = {
    Text = "Agitar o cérebro"
  },
  Event_6884_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6884_Desc = {
    Text = "O óleo colorido gradualmente preenche sua visão, e suas emoções entram em uma festa caótica"
  },
  Event_6884_Name = {
    Text = "Agitar o cérebro"
  },
  Event_6885_ChoiceDesc1 = {Text = "[Pocketed]"},
  Event_6885_Desc = {
    Text = "Uma substância prateada, quase mercurial, extraída de uma mucosa de dissolução, contém grande poder espiritual, utilizada principalmente para vincular mais despertadores em rituais"
  },
  Event_6885_Name = {
    Text = "Núcleo de prata"
  },
  Event_6886_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6886_Desc = {
    Text = "Risos jorram da caixa, e depois que o calor radiante desaparece, você vê um cartão com três figuras de palitos: você, a Ruiva de cabelos prateados Ramona, e o Loiro de cabelos dourados Ogier. Ao lado, uma linha de texto diz:\n   \"Obrigado a todos!\""
  },
  Event_6886_Name = {
    Text = "Presente Gentil"
  },
  Event_6887_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6887_Desc = {
    Text = "Seu corpo escapou do enxame de borboletas, mas elas não perderam seu alvo, entrando em sua mala e sugando avidamente a tinta da máquina de escrever"
  },
  Event_6887_Name = {
    Text = "Efluxo de Delírios"
  },
  Event_6888_ChoiceDesc1 = {
    Text = "[Apontar o Erro] Escolha 1 Carta de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_6888_ChoiceDesc2 = {
    Text = "[Listen to the Performance] Ganhe 15 Sigilos Negros para cada Despertador com Aliemus de 50 ou mais."
  },
  Event_6888_ChoiceDesc3 = {
    Text = "[Leave] Obter 1 de 3 Orações"
  },
  Event_6888_Desc = {
    Text = "O garoto boneco de cera estava tocando piano.\nSeu professor - também um boneco de cera - ao lado, corrigia:\n133, 355, 244...\nErrado. Cada nota errada"
  },
  Event_6888_Name = {
    Text = "Aulas de piano"
  },
  Event_6889_ChoiceDesc1 = {
    Text = "[Desista da Resistência] Delete 1 carta de comando, ganhe Arg1 Sigilo Negro"
  },
  Event_6889_ChoiceDesc2 = {
    Text = "[Puxe as Mãos para Trás]"
  },
  Event_6889_Desc = {
    Text = "Você não consegue resistir ao impulso interior. \n Seus dedos, como crianças perdidas na floresta, vagueiam e brincam no teclado... \n Gradualmente, borboletas começam a sair da máquina de escrever. \n Uma, duas, três... \n No rosto, nos dedos, borboletas em grupo brilham como fogos de artifício no escuro, com um brilho semelhante a joias. \n Esta máquina de escrever não tem utilidade prática, mas é excelente em criar beleza."
  },
  Event_6889_Name = {
    Text = "Inspiração súbita"
  },
  Event_6890_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6890_Desc = {
    Text = "Você ergue o papel sob a luz vermelho-escura, temendo perder um detalhe. \n Este é um relatório de exame físico, e a pessoa examinada é Mason. \n \"Peso 40 kg, concentração de oxigênio no sangue normal, taxa de sincronização 30%, valor de ressonância...\" \n Você quer continuar a ler, mas a escrita começa a desaparecer. \n Limpo como se nada tivesse acontecido."
  },
  Event_6890_Name = {
    Text = "Máquina de escrever"
  },
  Event_6891_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6891_Desc = {
    Text = "Sim, você não está fugindo, você está perseguindo um objetivo definido — o \"cão infernal\" que se move pelas estreitas vielas cobertas de neve. Você não esquecerá isso, assim como não esquecerá o rosto da pessoa que te puxou dos escombros naquele dia em Tunguska. ... Quem era mesmo?"
  },
  Event_6891_Name = {Text = "Correr"},
  Event_6892_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6892_Desc = {
    Text = "Neste espaço fora do isolamento, você só pode contar consigo mesmo"
  },
  Event_6892_Name = {
    Text = "Andarilho de Pesadelos"
  },
  Event_6893_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6893_Desc = {
    Text = "Crise e risco coexistem. Ao tocar a fechadura de ferro, o líquido corrosivo queimou sua palma. Espero que a criação atrás da porta valha a pena"
  },
  Event_6893_Name = {
    Text = "Depois da porta de ferro"
  },
  Event_6894_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6894_Desc = {
    Text = "Aventure-se em um mundo desconhecido, sua mente vacilante ainda não perdeu a razão.\nVocê entende bem o terror do desconhecido"
  },
  Event_6894_Name = {
    Text = "Andarilho de Pesadelos"
  },
  Event_6895_ChoiceDesc1 = {
    Text = "[Loud Shout] Ganhe uma relíquia prata \"(RelicConfig.Arg1)\" e infecte \"(Skill.Arg2)\""
  },
  Event_6895_ChoiceDesc2 = {
    Text = "[Embrace Silence] Ganhe Relíquia de Ouro \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_6895_ChoiceDesc3 = {
    Text = "[Surface] Ganhar 25 Sigilos Negros"
  },
  Event_6895_Desc = {
    Text = "Você ouviu o silêncio.\nUm silêncio amplificado, como o som das ondas, preenchendo todo o espaço.\n\nVocê levantou a cabeça, como uma pequena figura olhando para o céu estrelado"
  },
  Event_6895_Name = {
    Text = "Água do passado"
  },
  Event_6896_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6896_Desc = {
    Text = "Você presta atenção, procurando a origem do som, tentando descobrir quem é o vilão que está causando a confusão. \n Mas como se fosse uma brincadeira intencional, sempre que você acha que conseguiu encurralar a pessoa, acaba esbarrando em um ciclo sem fim, voltando ao mesmo lugar. \n Desanimado, você dá um chute na parede de tijolos, mas uma pedra cai da parede, revelando um brilho escondido no buraco da parede."
  },
  Event_6896_Name = {
    Text = "Rastro Misterioso"
  },
  Event_6897_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6897_Desc = {
    Text = "Deve ser um problema de reprodução, deve ser isso.\nVocê teimosamente voltou a agulha, suportando a música ruim da primeira metade, mas o som esperado não veio.\nAtrás de você, uma pequena sombra negra no chão estava escapando silenciosamente"
  },
  Event_6897_Name = {
    Text = "Rastro Misterioso"
  },
  Event_6898_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6898_Desc = {
    Text = "Não há ninguém ao seu redor, o segredo dos batimentos deve estar escondido dentro dos mecanismos do fonógrafo. \n Confiante em seu julgamento, você desmontou o velho fonógrafo. \n Além das peças de metal corroídas e de uma grossa camada de poeira, você não encontrou nada. \n Apenas uma risada ecoou na névoa, tão leve que parecia um sonho."
  },
  Event_6898_Name = {
    Text = "Rastro Misterioso"
  },
  Event_6899_ChoiceDesc1 = {
    Text = "[A Substância Branca do Tolo] Restaura Arg1 Vida"
  },
  Event_6899_ChoiceDesc2 = {
    Text = "[Coração do Louco] Uma carta de comando aleatória recebe uma marca:[(EnchantConfig.Arg1)]"
  },
  Event_6899_ChoiceDesc3 = {
    Text = "[Refuse to Eat] Ganhe 25 Sigilos Negros"
  },
  Event_6899_Desc = {
    Text = "\"A carne do bobo é tão deliciosa quanto um caldo de peixe fervente, enquanto o coração do louco é assado até se tornar um scone quente e ensanguentado.\"\nA sombra ri de forma demoníaca, apresentando um prato com ingredientes desconhecidos à sua frente.\nVocê respirou fundo, o aroma intenso invadiu seu nariz, suas glândulas salivares, sem dignidade, se renderam primeiro, enquanto seu estômago e intestinos se contorciam em tristeza, emitindo gemidos de desejo."
  },
  Event_6899_Name = {
    Text = "Festim de carne"
  },
  Event_6900_ChoiceDesc1 = {
    Text = "[Touch Wind Chime] Infectar com \"(Skill.Arg1)\", conceder aleatoriamente 1 Carta de Comando uma Oração: \"(EnchantConfig.Arg2)\""
  },
  Event_6900_ChoiceDesc2 = {
    Text = "[Observe Wind Chime] Infecte com \"(Skill.Arg1)\", conceda aleatoriamente 1 Carta de Comando uma Oração: \"(EnchantConfig.Arg2)\""
  },
  Event_6900_ChoiceDesc3 = {
    Text = "[Não fazer nada] aleatoriamente 1 carta de comando para obter uma oração:[(EnchantConfig.Arg1)]"
  },
  Event_6900_Desc = {
    Text = "Ding ding, ding ding...\nÉ um sino enferrujado, emitindo uma melodia desajeitada"
  },
  Event_6900_Name = {
    Text = "Sino de Vento Enferrujado"
  },
  Event_6901_ChoiceDesc1 = {
    Text = "[Wait and See] Tente sobreviver"
  },
  Event_6901_ChoiceDesc2 = {
    Text = "[Swing Weapon] Tente Romper"
  },
  Event_6901_ChoiceDesc3 = {
    Text = "[Segurar uma Mão] Ganhe 25 Sigilos Negros"
  },
  Event_6901_Desc = {
    Text = "O chão sob seus pés de repente se transforma em um pântano negro, e inúmeras mãos emergem dele. \n Elas têm diferentes cores de pele, materiais e texturas, azul pavão, escamosas, com olhos, como se tivessem atravessado inúmeras dimensões e espaços, tentando puxar o próximo azarado para sua grande família. \n Você decide——"
  },
  Event_6901_Name = {
    Text = "Pântano Escuro"
  },
  Event_6902_ChoiceDesc1 = {
    Text = "[Segure-o] Desenhe aleatoriamente 3 cartões de comando do baralho e escolha 1 para copiar."
  },
  Event_6902_ChoiceDesc2 = {
    Text = "[Sacudir um Pouco] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_6902_ChoiceDesc3 = {
    Text = "[Não Fazer Nada] Ganhar 25 Sigilos Negros"
  },
  Event_6902_Desc = {
    Text = "Ding ding, ding ding...\nÉ um sino enferrujado, emitindo uma melodia desajeitada"
  },
  Event_6902_Name = {Text = "Sinozinho"},
  Event_6903_ChoiceDesc1 = {
    Text = "[Refute-os] ganha relíquia de prata[(RelicConfig.Arg1)] 、escolhe infectar 1 sintoma"
  },
  Event_6903_ChoiceDesc2 = {
    Text = "[Follow them] Escolha 1 de 3 cartas de comando para ganhar uma oração: \"(EnchantConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_6903_ChoiceDesc3 = {
    Text = "[Apresentar uma nova perspectiva] ganhe 25 Marca Negra"
  },
  Event_6903_Desc = {
    Text = "\"Por favor, mantenha distância de nós.\"\nUm grupo de ratos te cercou, mantendo pelo menos cinco pés de distância. \n\"Nós nos esforçamos para reproduzir, nós prosperamos, nós nunca somos exigentes - e assim trazemos doenças, ansiedade e sofrimento para os humanos.\"\n\"Não devemos nos aproximar demais dos humanos, este não é o seu lugar.\"\nPara fazer os ratos baixarem a guarda, você decide -"
  },
  Event_6903_Name = {Text = "Peste"},
  Event_6904_ChoiceDesc1 = {
    Text = "[continuar caindo] Infectar[(Skill.Arg1)], continuar caindo?"
  },
  Event_6904_ChoiceDesc2 = {
    Text = "[Puxe para Lado] Ganhar 25 Sigilos Negros"
  },
  Event_6904_Desc = {
    Text = "\"Tu\" está te convidando para ir mais fundo.\nNas profundezas da espiral, o \"tu\" do passado e do futuro te oferece \"presentes\" de diferentes dimensões."
  },
  Event_6904_Name = {
    Text = "Abismo Espiral"
  },
  Event_6905_ChoiceDesc1 = {
    Text = "[Aperte o Corvo] ganhe 40 o sigilo negro, contamine[(Skill.Arg2)], continue a escolher"
  },
  Event_6905_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Ganhe 25 Sigilos Negros e saia."
  },
  Event_6905_Desc = {
    Text = "O corvo solitário, com uma voz rouca, arranca suas penas negras uma a uma.\nEle treme de dor, gritando agudamente, mas não pode parar seu ritmo cada vez mais frenético.\n\"Caw—Caw—\"\nLágrimas azuis misturadas com uma gosma negra escorrem de seus olhos, testemunhadas apenas por você."
  },
  Event_6905_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_6906_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6906_Desc = {
    Text = "Vermelho, paixão, exuberância, beleza, conheço uma pessoa assim, vocês se encontrarão em breve.\nEntão, qual é a sua próxima escolha?"
  },
  Event_6906_Name = {
    Text = "A apresentação começa"
  },
  Event_6907_ChoiceDesc1 = {
    Text = "[Aplauso alto]"
  },
  Event_6907_ChoiceDesc2 = {
    Text = "[Sonolento]"
  },
  Event_6907_Desc = {
    Text = "Você teve um longo sonho.\nNo sonho, você estava na plateia, assistindo a um garoto cantar no palco.\n\"O velho Charlie tinha um querido gato tigrado.\nQuando ela desapareceu, ele procurou em todos os lugares.\"\n......\nA voz oca e seca se repetia mecanicamente, sem fim."
  },
  Event_6907_Name = {
    Text = "Cerimônia Final IV"
  },
  Event_6908_ChoiceDesc1 = {
    Text = "[Untangle the upper branches]"
  },
  Event_6908_ChoiceDesc2 = {
    Text = "[Untangle Lower Branch]"
  },
  Event_6908_Desc = {
    Text = "As conexões de gnose permanecentes entre os domínios se entrelaçam, formando um campo de força instável.\nTalvez você possa desvendar as almas entrelaçadas para traçar um caminho a seguir"
  },
  Event_6908_Name = {
    Text = "Caminho emaranhado"
  },
  Event_6909_ChoiceDesc1 = {
    Text = "[Leave] Escolha despertar 2 Despertadores"
  },
  Event_6909_Desc = {
    Text = "\nVocê se levantou e correu em direção à porta.\n\"Você levantou o pano de cobertura...\n Um segredo, você descobriu um segredo...\"\n O rugido convergiu em um oceano cacofônico, e o chão tremeu violentamente com uma ressonância terrível.\n Você não se atreveu a olhar para trás e fugiu da cena o mais rápido que pôde."
  },
  Event_6909_Name = {
    Text = "Cerimônia Final V"
  },
  Event_6910_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6910_Desc = {
    Text = "Você não resiste, claro, mas também não escolhe se afundar"
  },
  Event_6910_Name = {
    Text = "Crânio perfurado"
  },
  Event_6911_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6911_Desc = {
    Text = "Você não resiste mais, deixa a sujeira consumir seu corpo e mente, após o sono, a luz prateada cai em suas mãos entrelaçadas"
  },
  Event_6911_Name = {
    Text = "Crânio perfurado"
  },
  Event_6912_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6912_Desc = {
    Text = "Quanto mais você luta, mais a sujeira se aprofunda na mente, e no fundo do cérebro cheio de pecados, há um presente desconhecido"
  },
  Event_6912_Name = {
    Text = "Crânio perfurado"
  },
  Event_6913_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6913_Desc = {
    Text = "Com a quebra da rede, algo passou pela sua mente, talvez os rostos sorridentes de algumas crianças"
  },
  Event_6913_Name = {
    Text = "Rede errante"
  },
  Event_6914_ChoiceDesc1 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_6914_Desc = {
    Text = "O gato assentiu satisfeito e desapareceu como uma sombra, deixando alguns objetos redondos pretos"
  },
  Event_6914_Name = {
    Text = "Residentes Nômades"
  },
  Event_6915_ChoiceDesc1 = {
    Text = "[Ler a Carta] Remover 1 cartão de comando, ganhar Arg1 sigilos negros"
  },
  Event_6915_ChoiceDesc2 = {
    Text = "[Close the Box]"
  },
  Event_6915_Desc = {
    Text = "Cartas voadoras cobrem o céu, como um lembrete silencioso"
  },
  Event_6915_Name = {
    Text = "Carta inesperada"
  },
  Event_6916_ChoiceDesc1 = {
    Text = "[Entrar] Através da névoa, alcance o outro lado."
  },
  Event_6916_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6916_Desc = {
    Text = "Uma passagem secreta apareceu no caminho à frente, envolta em névoa negra, sem saber a que lugar leva"
  },
  Event_6916_Name = {Text = "túnel"},
  Event_6917_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6917_Desc = {
    Text = "Você decidiu acabar com seu sofrimento, então segurou seu corpo macio, apertando, apertando...\nEla lutou desesperadamente em sua mão, até explodir em uma massa de líquido quente"
  },
  Event_6917_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_6918_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6918_Desc = {
    Text = "Fique tranquilo, são apenas memórias fragmentadas de outras dimensões. Você tem uma sombra. Mas, a pessoa na sombra ainda é você?"
  },
  Event_6918_Name = {
    Text = "Fragmentos de Memória: Cerveja"
  },
  Event_6919_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6919_Desc = {
    Text = "Você forçou o bico afiado do corvo, que tentava morder suas penas, a se voltar, mas ele se contorceu sem parar, tão forte que até seus ossos tremeram. \n Seu rosto ficou vermelho, e com todas as suas forças, você conseguiu conter o corpo do corvo, interrompendo seu ato de automutilação frenético. \n Enquanto você soltava um suspiro de alívio, o pescoço quase careca do corvo se torceu rapidamente para trás, seu corpo desabou, transformando-se em uma poça de lama negra em suas mãos."
  },
  Event_6919_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_6920_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6920_Desc = {
    Text = "Você ignorou friamente os sinos desesperados.\nMesmo que na próxima fração de segundo você seja explodido de volta ao mundo primitivo, mesmo que você e sua grande missão pereçam juntos.\nUm telefonema que não deve ser atendido, não deve ser atendido.\nVocê conhece bem essa verdade simples"
  },
  Event_6920_Name = {
    Text = "Por favor, atenda o telefone"
  },
  Event_6921_ChoiceDesc1 = {
    Text = "[Lower Gaze] Ganhe 25 Sigilos Negros"
  },
  Event_6921_ChoiceDesc2 = {
    Text = "[I Must Find It] Obtenha Relíquia de prata \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\""
  },
  Event_6921_Desc = {
    Text = "Você perseguiu a sombra e de repente entrou em águas rasas. O líquido de cor indefinida molhou seus sapatos, trazendo um frio.\nUma voz na água disse: \"Você não vai querer encontrar.\""
  },
  Event_6921_Name = {
    Text = "Você não vai querer encontrar"
  },
  Event_6922_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6922_Desc = {
    Text = "Escolha Segura"
  },
  Event_6922_Name = {
    Text = "depois da pilha de feno"
  },
  Event_6923_ChoiceDesc1 = {
    Text = "[Afastar corvos] Obtenha Arg1 sigilo negro, infectar [(Skill.Arg2)], continue a escolher"
  },
  Event_6923_ChoiceDesc2 = {
    Text = "[Desconsiderar] Ganhar 25 Sigilos Negros e sair."
  },
  Event_6923_Desc = {
    Text = "Como pode haver corvos no quarto do sanatório? \n Mas você realmente ouviu o riso sinistro dos corvos, e nas sombras há uma força que ainda não subiu ao palco, espiando vocês através daqueles olhos vazios de pássaro. Aqueles seres negros torcem o pescoço, parados no lustre da esquina, olhando para você com um olhar malicioso. Aquela cabeça em sombra parece compartilhar o mesmo corpo imerso em lama corrosiva."
  },
  Event_6923_Name = {
    Text = "Lanterna Corvo Preto"
  },
  Event_6924_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6924_Desc = {
    Text = "Não tema a sujeira, você ganha mais do que perde"
  },
  Event_6924_Name = {
    Text = "depois da pilha de feno"
  },
  Event_6925_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6925_Desc = {
    Text = "A tempestade de sabedoria espiritual envolveu Tulu, e você trocou um olhar com ele antes de entrar na escuridão"
  },
  Event_6925_Name = {
    Text = "Promessa do Agente"
  },
  Event_6926_ChoiceDesc1 = {
    Text = "[Entrar] Através da névoa, alcance o outro lado."
  },
  Event_6926_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6926_Desc = {
    Text = "Você caiu em uma escuridão total.  \nNo fim da sua visão, havia apenas uma faixa de luz, que entrava por uma fenda pequena como uma chave.  \nA chave de prata emitia um brilho tênue, guiando você a entrar naquela passagem secreta"
  },
  Event_6926_Name = {
    Text = "Caminho secreto de mão única"
  },
  Event_6927_ChoiceDesc1 = {
    Text = "[Infectar\"(Skill.Arg1)\"，obter criação\"(RelicConfig.Arg2)\"]"
  },
  Event_6927_ChoiceDesc2 = {
    Text = "[Escolher 1 entre 3 cartas de comando para obter uma oração:\"(EnchantConfig.Arg1)\"]"
  },
  Event_6927_Desc = {
    Text = "Evento 203 (em desenvolvimento), não é o efeito final"
  },
  Event_6927_Name = {
    Text = "Evento 203 (em desenvolvimento)"
  },
  Event_6928_ChoiceDesc1 = {
    Text = "[Remendar] Excluir uma carta de comando, Obter Criação:[(RelicConfig.Arg1)]"
  },
  Event_6928_ChoiceDesc2 = {
    Text = "[Acaricie] remova 1 carta de ataque/defesa, ganhe oração: [(EnchantConfig.Arg1)]"
  },
  Event_6928_ChoiceDesc3 = {
    Text = "[Desgosto] Ganhar 25 Sigilos Negros"
  },
  Event_6928_Desc = {
    Text = "\"Você gosta dos meus restos? Se possível, poderia me ajudar a juntar meu corpo?\"\nOs lábios da estátua de gesso semiparto se moveram, e uma voz delicada, tão suave quanto seda, surgiu de seus lábios que deveriam ser duros e frios."
  },
  Event_6928_Name = {
    Text = "Montar os restos"
  },
  Event_6929_ChoiceDesc1 = {
    Text = "[Descartar envelope] escolher 1 entre 3 cartas de comando para obter uma oração:[(EnchantConfig.Arg1)]"
  },
  Event_6929_ChoiceDesc2 = {
    Text = "[Tucked in the Chest] Infecte \"(Skill.Arg1)\", ganhe Relíquia: \"(RelicConfig.Arg2)\""
  },
  Event_6929_Desc = {
    Text = "Esta é uma carta de socorro, o remetente se esforça para manter a calma, mas a caligrafia torta revela seu medo oculto. \n \"Tudo isso superou completamente minhas expectativas, se alguém disser que estou sob uma maldição, eu juro que acreditarei sem dúvida.\" \n \"Alguém disse que sou louco, ele só acertou metade; estou à beira da loucura.\" \n \"Mas eu realmente vi! Está se mutando e dissipando, uma substância negra e pegajosa está tentando escalar meu corpo!\" \n \"Eu escapei! Fugi rapidamente, mas o olhar nunca se desviou de mim, tenho a sensação de que ele definitivamente me encontrará! Aquela repugnante lama negra vai novamente invadir meu crânio, quem quer que receba esta carta, por favor, me salve —\""
  },
  Event_6929_Name = {
    Text = "Um pedido de socorro"
  },
  Event_6930_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6930_Desc = {
    Text = "\"Calma,\" Ramona bate na sua cabeça, \"apenas fragmentos do passado. Não sei quem os deixou neste passagem dimensional.\"\nDe fato, há um cheiro nostálgico."
  },
  Event_6930_Name = {
    Text = "Comunicação de emergência"
  },
  Event_6931_ChoiceDesc1 = {
    Text = "[Um cartão de comando aleatório obtém a oração: \"(EnchantConfig.Arg1)\"]"
  },
  Event_6931_ChoiceDesc2 = {
    Text = "[Um cartão de comando aleatório obtém a oração: \"(EnchantConfig.Arg1)\"]"
  },
  Event_6931_ChoiceDesc3 = {
    Text = "[Um cartão de comando aleatório obtém a oração: \"(EnchantConfig.Arg1)\"]"
  },
  Event_6931_Desc = {
    Text = "Evento 205 (em desenvolvimento), não é o efeito final"
  },
  Event_6931_Name = {
    Text = "Evento 205 (em desenvolvimento)"
  },
  Event_6932_ChoiceDesc1 = {
    Text = "[Obtenha Criação:[(RelicConfig.Arg1)]"
  },
  Event_6932_ChoiceDesc2 = {
    Text = "[Obtenha Criação:[(RelicConfig.Arg1)]"
  },
  Event_6932_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_6932_Desc = {
    Text = "Evento 204 (em desenvolvimento), não é o efeito final"
  },
  Event_6932_Name = {
    Text = "Evento 204 (em desenvolvimento)"
  },
  Event_6933_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6933_Desc = {
    Text = "A lua solitária paira no céu, mas você pode ouvir claramente suas orações, um tom peculiar, semelhante ao sussurro de coisas impuras. \n As orações param, e você está prestes a partir. Mas atrás de você, uma sombra branca brilha. \n \"Aquele que espia o destino e a profanação das orações, tanto a dádiva quanto o preço chegarão como prometido.\""
  },
  Event_6933_Name = {
    Text = "Fragmento de Lua de Prata"
  },
  Event_6934_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6934_Desc = {
    Text = "Um som de estilhaçamento vem de trás, você hesita por um momento e se vira para sair"
  },
  Event_6934_Name = {
    Text = "Fragmento de Lua de Prata"
  },
  Event_6935_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6935_Desc = {
    Text = "A luz da lua na palma da mão foi derramada sobre a lápide.\nAlguém foi enterrado sob a lama espessa, e os espectadores afirmaram que essa pessoa morreu naturalmente e descansará em paz.\nMas a lama começou a se mover, e em meio aos gritos, uma lua murcha rastejou para fora"
  },
  Event_6935_Name = {
    Text = "Fragmento de Lua de Prata"
  },
  Event_6936_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6936_Desc = {
    Text = "Mas são seres lutando para sobreviver, buscando um pedaço de madeira flutuante para descansar...\nVocê suspira, deixando o líquido negro da cauda da borboleta escorrer"
  },
  Event_6936_Name = {
    Text = "Algo que não deveria existir"
  },
  Event_6937_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6937_Desc = {
    Text = "É uma armadilha anunciada, e você sabe do perigo.\nComparado às joias, você mesmo é a gema mais preciosa"
  },
  Event_6937_Name = {
    Text = "Inverter as Garras do Mal"
  },
  Event_6938_ChoiceDesc1 = {
    Text = "[Inserir Chave de Prata]"
  },
  Event_6938_Desc = {
    Text = "Parece que o limos saturado contém certas substâncias... Observe-o com a chave de prata e transfira-o para sua própria força"
  },
  Event_6938_Name = {
    Text = "Ponto de extração"
  },
  Event_6939_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6939_Desc = {
    Text = "Você aceitou o pedido, mas encontrou um pequeno problema.\n\"O que aquela escultura de cera parece?\"\n\"É um busto meu, claro que se parece comigo.\"\n\"Mas...\"\n\"Seu rosto já se deteriorou completamente. Você não sabe?\""
  },
  Event_6939_Name = {Text = "Meu busto"},
  Event_6940_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6940_Desc = {
    Text = "Você aperta a mão do companheiro ao lado, Ramona olha para você com curiosidade, mas finalmente permite sua falta de educação"
  },
  Event_6940_Name = {
    Text = "Prece do Sonho"
  },
  Event_6941_ChoiceDesc1 = {
    Text = "[Ask Who It Is] Escolha 1 de 3 cartas de comando para ganhar Oração: \"(EnchantConfig.Arg1)\", e infecte com \"(Skill.Arg2)\""
  },
  Event_6941_ChoiceDesc2 = {
    Text = "[Encarar] Escolha despertar 1 Desperto, infectar [(Skill.Arg1)]"
  },
  Event_6941_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_6941_Desc = {
    Text = "A sensação intensa de estar sendo observado faz você parar. \n \"Quem é?\" Você olha na névoa densa, \"Jenkins, é você?\" \n A neblina é espessa, e de dentro do pátio vem o grito de um Corpo de fusão. Você não encontra nada e só consegue se virar, quase esbarrando em um olho que flutua no ar."
  },
  Event_6941_Name = {Text = "Olhar cego"},
  Event_6942_ChoiceDesc1 = {
    Text = "[Não Tocar na Moeda] Aleatoriamente 1 carta de comando ganha uma oração:[(EnchantConfig.Arg1)]"
  },
  Event_6942_ChoiceDesc2 = {
    Text = "[Toque a moeda] Aumente Arg1 pontos de saúde máxima, infecte[(Skill.Arg2)]"
  },
  Event_6942_Desc = {
    Text = "Você encontra uma moeda antiga presa na lama negra.\nUm lado tem veias esculpidas em azul e vermelho, o outro um retrato em relevo de uma duquesa imaculada, que sorri enquanto seus olhos pálidos se movem e giram descontroladamente"
  },
  Event_6942_Name = {
    Text = "Moeda antiga de duas faces"
  },
  Event_6943_ChoiceDesc1 = {
    Text = "[Vire-se] Ganhe 25 sigilos negros"
  },
  Event_6943_ChoiceDesc2 = {
    Text = "[Keep Going] Obtenha uma Relíquia de Prata \"(RelicConfig.Arg1)\" e infecte \"(Skill.Arg2)\""
  },
  Event_6943_Desc = {
    Text = "Lá vem ele de novo, aquele estranho som de passos. \n Ele segue bem atrás de você, do estúdio até a sala do curador, e da sala do curador até o porão. \n Você sabe que ele é um cara cauteloso. \n Ele mantém cuidadosamente a distância entre vocês, de modo que não fique muito longe, mas também não seja invasivo. \n Mas você ainda se sente profundamente incomodado."
  },
  Event_6943_Name = {Text = "passos"},
  Event_6944_ChoiceDesc1 = {
    Text = "[Observar Isso] Ganhe 25 sigilos negros"
  },
  Event_6944_ChoiceDesc2 = {
    Text = "[Pet It] 50% de chance de ganhar 50 Sigilos Negros, 50% de chance de não obter nada"
  },
  Event_6944_Desc = {
    Text = "De repente, um gato preto surgiu de um beco, esfregando-se afetuosamente em suas pernas, com seus olhos verticais de um verde fantasmagórico piscando com uma luz arrepiante, como se dissesse: \"Pare de me seguir e venha brincar comigo por um momento.\"\n \"Você já o viu, ele está ao seu lado, aquelas sombras poluídas pela loucura, fervorosas... não olhe diretamente para o contorno dele.\""
  },
  Event_6944_Name = {
    Text = "Elfo Noturno"
  },
  Event_6945_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6945_Desc = {
    Text = "Os despertos aguardam suas ordens, você está sem tempo"
  },
  Event_6945_Name = {
    Text = "vindo do ângulo"
  },
  Event_6946_ChoiceDesc1 = {
    Text = "[Check the Film] Infecte \"(Skill.Arg1)\", ganhe Relíquia de Ouro \"(RelicConfig.Arg2)\""
  },
  Event_6946_ChoiceDesc2 = {
    Text = "[Check Camera] Ganhe 50 Sigilos Negros"
  },
  Event_6946_Desc = {
    Text = "Como se estivesse puxando um pedaço de víscera, o filme dentro da câmera foi rasgado em pedaços, abandonado aqui, sem ninguém para se importar. \n Um brilho ofuscante passou, a câmera deixada no canto da rua estava inclinada, o obturador foi acionado do nada. \n \"Clique——\" \n Sua expressão de surpresa e confusão foi fielmente registrada no rolo de filme da câmera."
  },
  Event_6946_Name = {
    Text = "Registro de inocência"
  },
  Event_6947_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6947_Desc = {
    Text = "É só o som do vento balançando as correntes, nada para se preocupar, ignore"
  },
  Event_6947_Name = {
    Text = "Depois da porta de ferro"
  },
  Event_6948_ChoiceDesc1 = {
    Text = "[Escolher] Infecte[(Skill.Arg1)]"
  },
  Event_6948_ChoiceDesc2 = {
    Text = "[Escolher] Infecte[(Skill.Arg1)]"
  },
  Event_6948_ChoiceDesc3 = {
    Text = "[Escolher] Infecte[(Skill.Arg1)]"
  },
  Event_6948_Desc = {
    Text = "\"Eu\" sou único, insubstituível em milhões de universos."
  },
  Event_6948_Name = {
    Text = "Resonância de almas"
  },
  Event_6949_ChoiceDesc1 = {
    Text = "[Claim] Selecionar 1 Relíquia de Prata"
  },
  Event_6949_Desc = {
    Text = "Talvez seja \"eu\".\nAtravessando a sombra do tempo, atravessando a barreira dimensional, olhando para mim através de uma fenda"
  },
  Event_6949_Name = {
    Text = "Resonância de almas"
  },
  Event_6950_ChoiceDesc1 = {
    Text = "[Apontar o problema] escolha 1 de 3 cartas de comando e ganhe oração: [(EnchantConfig.Arg1)]"
  },
  Event_6950_ChoiceDesc2 = {
    Text = "[Engula a dúvida] infecta[(Skill.Arg1)], reimprime, pode fazer mais 1 vez"
  },
  Event_6950_Desc = {
    Text = "Isso é um segredo difícil de expressar para essas garotas.\nVocê engoliu suas dúvidas, mas ela contou sobre um sonho que durou vinte e cinco anos, sobre sua solidão após o despertar do sonho"
  },
  Event_6950_Name = {Text = "Vida Presa"},
  Event_6951_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6951_Desc = {
    Text = "Você jogou os papéis e lascas de madeira no fogo. As chamas os devoraram avidamente e soltaram um arroto satisfeito. Estavam prontas para destruir o mundo, mas não sem antes lhe dar uma bênção"
  },
  Event_6951_Name = {Text = "Fogo fraco"},
  Event_6952_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6952_Desc = {
    Text = "Você extingue impiedosamente a última fagulha de ódio, e o ressentimento ao redor parece diminuir"
  },
  Event_6952_Name = {Text = "Fogo fraco"},
  Event_6953_ChoiceDesc1 = {
    Text = "[Afastar corvos] Obtenha Arg1 sigilo negro, infectar [(Skill.Arg2)]"
  },
  Event_6953_ChoiceDesc2 = {
    Text = "[Ignorar] Saia"
  },
  Event_6953_Desc = {
    Text = "Você tenta pegar o corvo, mas ele apenas voa de um lado do quarto para o outro, emitindo sons estranhos. Onde ele passa, um líquido negro cai, formando marcas escuras"
  },
  Event_6953_Name = {
    Text = "Lanterna Corvo Preto"
  },
  Event_6954_ChoiceDesc1 = {
    Text = "[Leave] Obtenha Relíquia \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_6954_Desc = {
    Text = "\n\"Você tem um talento para capturar a essência,\" diz o homem com um sorriso radiante. \"Essa é a comida mais deliciosa do mundo, digna de uma preparação meticulosa e apreciação por cada glutão.\" \n\"É uma pena, mas não posso deixar você experimentá-la desta vez. Como compensação, eu tenho algumas outras iguarias comigo, que vou lhe dar.\" \nCom isso, o homem lança um pedaço de carne vermelha tenra. A carne macia pousa na ponte, suas apêndices pegajosos se contorcendo grotescamente. Quando você olha novamente, a figura do homem desapareceu atrás das intrincadas estruturas de aço, não deixando rastros."
  },
  Event_6954_Name = {
    Text = "Companheiro Estranho VI"
  },
  Event_6955_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6955_Desc = {
    Text = "Desvendar camadas, uma de cada vez, é sua especialidade.\nO lampejo de inspiração clareia sua mente, permitindo ver a realidade atual—\nNão importa quem está manipulando os fantoches, fuja e sobreviva"
  },
  Event_6955_Name = {
    Text = "Inspiração súbita"
  },
  Event_6956_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6956_Desc = {
    Text = "A borboleta se despedaça na sua mão, como um teto de vidro quebrado, caindo, caindo, caindo—"
  },
  Event_6956_Name = {
    Text = "Ilusão Ferroviária"
  },
  Event_6957_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6957_Desc = {
    Text = "Vendo que Ramona não queria se aproximar, o gato balançou a cabeça e desapareceu como uma sombra"
  },
  Event_6957_Name = {
    Text = "Residentes Nômades"
  },
  Event_6958_ChoiceDesc1 = {
    Text = "[Make a promise] Obtenha uma relíquia de prata \"(RelicConfig.Arg1)\" e infecte \"(Skill.Arg2)\""
  },
  Event_6958_ChoiceDesc2 = {
    Text = "[Refuse] Obtenha uma Relíquia de Prata \"(RelicConfig.Arg1)\" e torne-se infectado com \"(Skill.Arg2)\""
  },
  Event_6958_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_6958_Desc = {
    Text = "\"Essa foi uma lembrança inesquecível. \n Minha cabeça e membros foram pressionados com força no gesso. \n A asfixia e a ilusão de morte me envolveram profundamente, puxando-me com força e jogando-me na costa escura. \n Eu a observei, sentindo que uma parte de mim também havia sido levada. \n Aquela outra metade perdida da alma, desde então, habita naquela pequena, original estátua de cera. \n Então... você pode me ajudar a encontrar meu busto?\""
  },
  Event_6958_Name = {Text = "Meu busto"},
  Event_6959_ChoiceDesc1 = {
    Text = "[Leave] Obter 1 de 3 Oração Avançadas"
  },
  Event_6959_Desc = {
    Text = "Você é um espectador da memória, apenas podendo assistir enquanto a garota cai em direção ao mar sombrio.\nA água empurra os bordados da saia para cima, mas ela desce, parecendo uma flor ainda não aberta"
  },
  Event_6959_Name = {
    Text = "Afundar-se no mar"
  },
  Event_6960_ChoiceDesc1 = {
    Text = "[Inserir Chave de Prata]"
  },
  Event_6960_Desc = {
    Text = "Parece que o limos saturado contém certas substâncias... Observe-o com a chave de prata e transfira-o para sua própria força"
  },
  Event_6960_Name = {
    Text = "Ponto de extração"
  },
  Event_6961_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6961_Desc = {
    Text = "Não dê atenção às tentações do inimigo, pode ser uma armadilha"
  },
  Event_6961_Name = {
    Text = "Corvo Amaldiçoado"
  },
  Event_6962_ChoiceDesc1 = {Text = "[Ajude-o]"},
  Event_6962_ChoiceDesc2 = {
    Text = "[Observar Friamente]"
  },
  Event_6962_Desc = {
    Text = "O menino estava no palco, uma luz pálida brilhando em seu rosto.\n\"D-dedicado a...\"\nO rosto do menino ficou vermelho. Ele abriu a boca, mas não conseguiu emitir som algum.\nSua boca aberta se alargou cada vez mais..."
  },
  Event_6962_Name = {
    Text = "Cerimônia Final III"
  },
  Event_6963_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6963_Desc = {
    Text = "\"Droga, droga!\" Como se você tivesse acionado um botão, o gato preto de repente ficou feroz, mordendo seu braço. Felizmente, você desvia a tempo, perdendo apenas um pedaço da sua manga. O gato preto corre até a esquina e desaparece no esgoto."
  },
  Event_6963_Name = {
    Text = "Elfo Noturno"
  },
  Event_6964_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6964_Desc = {
    Text = "Envolto pelos pensamentos turbulentos em sua mente, você abriu a porta e entrou em um caminho sem volta.\nA luz branca ardente do lado de fora é redenção ou destruição?"
  },
  Event_6964_Name = {
    Text = "Além das portas duplas"
  },
  Event_6965_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6965_Desc = {
    Text = "Você corajosamente se aproxima para verificar, e o muco sobre a mesa se abre de repente, revelando o que estava por baixo"
  },
  Event_6965_Name = {
    Text = "Além das portas duplas"
  },
  Event_6966_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6966_Desc = {
    Text = "Engula a saliva, reprima as dúvidas, concentre-se no inimigo.\nDeixe a borboleta ficar no corpo, mesmo que suas asas rasguem seus órgãos"
  },
  Event_6966_Name = {
    Text = "Efeito borboleta"
  },
  Event_6967_ChoiceDesc1 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_6967_Desc = {
    Text = "O gato assentiu satisfeito e desapareceu como uma sombra, deixando alguns objetos redondos pretos"
  },
  Event_6967_Name = {
    Text = "Residentes Nômades"
  },
  Event_6968_ChoiceDesc1 = {
    Text = "[Inserir Chave de Prata]"
  },
  Event_6968_Desc = {
    Text = "Parece que o limos saturado contém certas substâncias... Observe-o com a chave de prata e transfira-o para sua própria força"
  },
  Event_6968_Name = {
    Text = "Ponto de extração"
  },
  Event_6969_ChoiceDesc1 = {
    Text = "[Sair] ganha 1 relíquia de ouro aleatória, infecção de[(Skill.Arg1)]"
  },
  Event_6969_Desc = {
    Text = "Vendo sua hesitação, Koom cavou rapidamente com as patas dianteiras e empurrou algo para você"
  },
  Event_6969_Name = {
    Text = "Objeto enterrado"
  },
  Event_6970_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6970_Desc = {
    Text = "No topo do papel está \"Mérimée\", nunca houve um Mason.\nDesconfiança não é um bom sinal, Guardião"
  },
  Event_6970_Name = {
    Text = "Máquina de escrever"
  },
  Event_6971_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para relíquia de ouro, infecção de[(Skill.Arg1)]"
  },
  Event_6971_Desc = {
    Text = "No montículo de terra estão enterrados os crimes inomináveis da associação dos escultores"
  },
  Event_6971_Name = {
    Text = "Objeto enterrado"
  },
  Event_6972_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6972_Desc = {
    Text = "As aves têm suas próprias regras, não seguem sua vontade, e você não tem o direito de interferir na natureza"
  },
  Event_6972_Name = {
    Text = "Corvo Solitário"
  },
  Event_6973_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para relíquia de ouro, infecção de[(Skill.Arg1)]"
  },
  Event_6973_Desc = {
    Text = "Por quê, por que afundou?\nNaquele dia não havia trovões, nem tempestades. O céu noturno estava limpo, sem estrelas, e a lua cheia pairava sobre o horizonte, como um sol frio"
  },
  Event_6973_Name = {
    Text = "Afundar-se no mar"
  },
  Event_6974_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6974_Desc = {
    Text = "\"Condutor! Sofremos um ataque terrorista! ... Zzz...\"\n Parece ser a chamada do motorista, você estava prestes a desligar. \n \"Repetindo, aqui é o quarto esquadrão de operações externas de Misaq, estamos a bordo do trem expresso noturno da linha norte, escortando os reféns em resgate quando encontramos... Ah!\"\n O tom do telefone se tornou um sussurro rouco, misturado com gritos agudos e aterradores. \n \"O Sacramento foi realizado. Ovelha perdida, que este banho sagrado purifique sua alma...\""
  },
  Event_6974_Name = {
    Text = "Ligação do trem"
  },
  Event_6975_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6975_Desc = {
    Text = "Coletar núcleos de prata também é uma das tarefas do Guardião do Segredo.\nAlmas à deriva no cristal puro retornarão ao mundo com uma nova aparência"
  },
  Event_6975_Name = {Text = "Alma Presa"},
  Event_6976_ChoiceDesc1 = {
    Text = "[Continuar Caindo] 1 carta de comando aleatória ganha oração:[(EnchantConfig.Arg1)], continuar a cair?"
  },
  Event_6976_ChoiceDesc2 = {
    Text = "[Puxe para Lado] Ganhar 25 Sigilos Negros"
  },
  Event_6976_Desc = {
    Text = "\"Tu\" está te convidando para ir mais fundo.\nNas profundezas da espiral, o \"tu\" do passado e do futuro te oferece \"presentes\" de diferentes dimensões."
  },
  Event_6976_Name = {
    Text = "Abismo Espiral"
  },
  Event_6977_ChoiceDesc1 = {
    Text = "[Lean Out] Infecção \"(Skill.Arg1)\", Ganhe Relíquia de Ouro \"(RelicConfig.Arg2)\""
  },
  Event_6977_ChoiceDesc2 = {
    Text = "[Desista de Conferir] Ganhe 50 Sigilos Negros"
  },
  Event_6977_Desc = {
    Text = "Parece haver um rolo de filme na base da mesa cirúrgica"
  },
  Event_6977_Name = {
    Text = "Lembranças luminosas"
  },
  Event_6978_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6978_Desc = {
    Text = "Recuse a interferência, concentre-se no presente.\nVocê tem coisas mais importantes a fazer"
  },
  Event_6978_Name = {Text = "Meu busto"},
  Event_6979_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6979_Desc = {
    Text = "Relíquia Sagrada Perdida, herança valiosa, instrumento de desejos...\nApenas tesouros são tão tentadores"
  },
  Event_6979_Name = {
    Text = "Método de Entrada Misterioso"
  },
  Event_6980_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6980_Desc = {
    Text = "『Você é a 'mãe' da Lily, mas apenas a utiliza como ferramenta de pesquisa e combate, 』 você responde, 『uma criança pode obedecer à mãe, mas você não deveria ser a 'mãe' da Lily.』"
  },
  Event_6980_Name = {
    Text = "Sua escolha"
  },
  Event_69813_ChoiceDesc1 = {Text = "[Leave]"},
  Event_69813_Desc = {
    Text = "A Chave de Prata brilhou, os braços pareciam ser intimidados por alguma força, recuando para a água da piscina e desaparecendo"
  },
  Event_69813_Name = {
    Text = "Bacia de sangue"
  },
  Event_69814_ChoiceDesc1 = {Text = "[Leave]"},
  Event_69814_Desc = {
    Text = "Você afunda cada vez mais, ouvindo os sussurros caóticos da Vontade Suprema em sua mente. Você fecha os olhos e invoca o poder que existe dentro de você. \n De repente, todos os sons e sensações anômalas desaparecem, você está atrás da porta, e os tentáculos ensanguentados ao seu redor não estão mais lá, como se nunca tivessem existido. \n Você se sente revigorado. Você entende o preço que pagou, mas isso é insignificante — você enfrentará aquela existência suprema em uma forma mais poderosa."
  },
  Event_69814_Name = {
    Text = "Bacia de sangue"
  },
  Event_69815_ChoiceDesc1 = {Text = "[Leave]"},
  Event_69815_Desc = {
    Text = "O Corpo Desperto que você moldou com suas memórias não hesitou por um instante e puxou você da Bacia de sangue, seu braço conectado foi rasgado, a água turva espirrou, e inúmeras criaturas indistintas se moviam na água, o Criador primitivo e o Destruidor, estavam desejando devorar."
  },
  Event_69815_Name = {
    Text = "Bacia de sangue"
  },
  Event_69816_ChoiceDesc1 = {
    Text = "[Chamar Despertador] Deduzir 100 Aliemus de todos os Despertadores e remover 1 Cartão de Sintoma."
  },
  Event_69816_ChoiceDesc2 = {
    Text = "[Absorver o Poço de Sangue] Aumente Arg1 pontos de saúde máxima, infecte 2 cartas [(Skill.Arg2)]"
  },
  Event_69816_ChoiceDesc3 = {
    Text = "[Inserir Chave Prata] Limpe todo o Keyflare"
  },
  Event_69816_Desc = {
    Text = "A autoridade da vida se apresenta na forma da morte nos olhos primordiais. Quando você pisa neste território nebuloso, a piscina de sangue fétido revela sua verdadeira forma instantaneamente. \n O sangue de cor vermelho-escuro estende braços incontáveis, agarrando-se ao seu tornozelo, puxando incessantemente para cima, com a intenção de arrastá-lo para um abismo incompreensível."
  },
  Event_69816_Name = {
    Text = "Bacia de sangue"
  },
  Event_6981_ChoiceDesc1 = {
    Text = "[Pick Up Key]"
  },
  Event_6981_Desc = {
    Text = "Um molho de chaves enferrujadas. Pode ser usado para abrir fechaduras"
  },
  Event_6981_Name = {
    Text = "Chave enferrujada"
  },
  Event_6982_ChoiceDesc1 = {
    Text = "[deixar] Escolher copiar 1 carta de comando, infectar[(Skill.Arg1)]"
  },
  Event_6982_Desc = {
    Text = "Sob a orientação da Canção do barco e de Celeste, você olhou para as profundezas escuras e sem luz do compartimento — será que a sua sobrevivência está naquela escuridão sem fim?"
  },
  Event_6982_Name = {
    Text = "Canção do barco"
  },
  Event_6983_ChoiceDesc1 = {
    Text = "[Sair Juntos] Adquirir relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_6983_ChoiceDesc2 = {
    Text = "[Recuse-se a sair] ganhe 75 o sigilo negro, infecção[(Skill.Arg2)]"
  },
  Event_6983_Desc = {
    Text = "É uma ilusão? Você vê os corvos rodopiando no céu, cantando uma canção familiar: \n\"Então vamos embora, eu e você\nAproveitando que a noite acaba de cair\nComo um bêbado à beira da morte caindo na rua.\""
  },
  Event_6983_Name = {
    Text = "Voz da matilha de corvos"
  },
  Event_6984_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6984_Desc = {
    Text = "O poder de retorno não pode mais encontrar uma junção por um curto período, mas pelo menos você obteve um consolo temporário"
  },
  Event_6984_Name = {
    Text = "Contato Anômalo"
  },
  Event_6985_ChoiceDesc1 = {
    Text = "[Cair na Espiral] Olhe para o fim da espiral"
  },
  Event_6985_ChoiceDesc2 = {
    Text = "[Puxe para Lado] Ganhar 25 Sigilos Negros"
  },
  Event_6985_Desc = {
    Text = "A superfície do mar desapareceu da escotilha.\nO vidro reflete seu rosto pálido, enquanto em sua pupila, \"você\" olha de volta para a escotilha.\nA realidade e o Domínio se sobrepõem e entrelaçam, distorcendo-se em uma espiral intricada."
  },
  Event_6985_Name = {
    Text = "Abismo Espiral"
  },
  Event_6986_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6986_Desc = {
    Text = "Você aceita o pedido de contato da escola, a voz familiar te acalma. Você se recompõe e segue em frente"
  },
  Event_6986_Name = {
    Text = "Ponto de contato"
  },
  Event_6987_ChoiceDesc1 = {
    Text = "[Afirmativo]"
  },
  Event_6987_ChoiceDesc2 = {
    Text = "[Indica Negação]"
  },
  Event_6987_ChoiceDesc3 = {Text = "[Indeciso]"},
  Event_6987_Desc = {
    Text = "\"Há quanto tempo, amigos.\" Vocês se afastaram da batalha com os Portadores de lanternas, ganhando um pequeno momento de respiro, e de repente perceberam que o homem de cabelo longo estava novamente ao lado da estrada, sorrindo e acenando para vocês, como se a luta anterior nunca tivesse acontecido. \n \"Comparado à última vez que nos encontramos, o cheiro de Cérbero em você se tornou muito mais forte. Nesse tempo, você deve ter ido a lugares bem distantes, não é?\" \n"
  },
  Event_6987_Name = {
    Text = "Companheiro Estranho V"
  },
  Event_6988_ChoiceDesc1 = {
    Text = "[Perguntar o Caminho a ele] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_6988_ChoiceDesc2 = {
    Text = "[Afastar-se dele] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_6988_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_6988_Desc = {
    Text = "A sombra está embaixo de um poste de luz magro. \n \"Posso pegar um fogo emprestado, senhor?\" \n Você não tem o hábito de @2, mas não se importa em usar um pouco de \"magia\". \n Com sua ajuda, a sombra coloca a @2 acesa dentro do vórtice negro sem fundo. \n Não demora muito e você vê fumaça branca se elevando. \n \"Ah—\" \n A sombra solta um suspiro de prazer."
  },
  Event_6988_Name = {
    Text = "A sombra sob o poste de luz"
  },
  Event_6989_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_6989_Desc = {
    Text = "No tabuleiro, o que você vê não é real\n\nO que bloqueia seu caminho pode não ser uma parede, mas sua curiosidade esgotada"
  },
  Event_6989_Name = {
    Text = "Espaço Fantasma"
  },
  Event_6990_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6990_Desc = {
    Text = "\"Estou com tanta dor... Irmã Sasha...\"\nVocê olha para Sarah, que está nervosamente protegendo duas crianças, aparentemente não ouvindo. \nA voz gradualmente vai se apagando."
  },
  Event_6990_Name = {
    Text = "\"Irmã Sasha\""
  },
  Event_6991_ChoiceDesc1 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_6991_Desc = {
    Text = "Você se levanta e aplaude o garoto. \nSentindo seu encorajamento, o garoto estufa o peito. \nSangue negro jorra de sua boca, mas a canção não para"
  },
  Event_6991_Name = {
    Text = "Cerimônia Final IV"
  },
  Event_6992_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6992_Desc = {
    Text = "Parte da tristeza está evaporando, mas as lágrimas ainda fluem incessantemente para o passado místico."
  },
  Event_6992_Name = {
    Text = "Lágrimas da Praia das Sombras"
  },
  Event_6993_ChoiceDesc1 = {
    Text = "[Choke the Singer] Infecção \"(Skill.Arg1)\", Ganhe Relíquia Maldita \"(RelicConfig.Arg2)\""
  },
  Event_6993_ChoiceDesc2 = {
    Text = "[Stumbling Dancer's Steps] Infecte duas vezes com \"(Skill.Arg1)\", receba Relíquia de Prata \"(RelicConfig.Arg2)\" e \"(RelicConfig.Arg3)\""
  },
  Event_6993_ChoiceDesc3 = {
    Text = "[Desvio do Caminho] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_6993_Desc = {
    Text = "Você é bloqueado por três figuras pegajosas. \n Uma figura canta uma música, com uma voz rouca e letras estranhas, você tapa os ouvidos e a evita. \n Uma figura dança, com movimentos rígidos e passos hesitantes, você fecha os olhos e a esquiva. \n Uma figura recita um poema, com rimas quebradas e frases desconexas, você não consegue mais suportar, então—"
  },
  Event_6993_Name = {
    Text = "Vilão no Caminho Estreito"
  },
  Event_6994_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6994_Desc = {
    Text = "Parte da raiva está fervendo, mas as lágrimas ainda fluem incessantemente para o passado desconhecido"
  },
  Event_6994_Name = {
    Text = "Lágrimas da Praia das Sombras"
  },
  Event_6995_ChoiceDesc1 = {
    Text = "[Ignorar] Infectar[(Skill.Arg1)]"
  },
  Event_6995_ChoiceDesc2 = {
    Text = "[Turn away] Despertar um Despertador aleatório"
  },
  Event_6995_Desc = {
    Text = "O destino cruel rasteja aos pés do viajante, o caminho é liso como um espelho, um leve som de estilhaçamento atrás. \nQuem quebrou o destino sob seus pés? É ilusão, armadilha, ou apenas delírio, mentira… \nDiante de você, uma rachadura rasteja lentamente. \n<Italic: como se estivesse prestes a afundar na gnose desperta.>"
  },
  Event_6995_Name = {
    Text = "Grieta reptante"
  },
  Event_6996_ChoiceDesc1 = {
    Text = "[Submeter ao Julgamento] infecta[(Skill.Arg1)], vitória concede 1 relíquia de ouro, falha concede 50 sigilo negro"
  },
  Event_6996_ChoiceDesc2 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_6996_Desc = {
    Text = "Você viu alguns segredos na poça de lodo negro refletindo como um espelho.\nSeu reflexo é borrado nas bordas, envolto em uma névoa negra persistente, você sente uma familiaridade inexplicável, mas não consegue identificar o que é"
  },
  Event_6996_Name = {
    Text = "Sob a superfície do espelho"
  },
  Event_6997_ChoiceDesc1 = {
    Text = "[Imitar um Gato] 50% de chance de ganhar 125 do sigilo negro, 50% de chance de infecção[(Skill.Arg2)]"
  },
  Event_6997_ChoiceDesc2 = {
    Text = "[Alimente] 75% de chance de ganhar 100 o sigilo negro, 25% de chance de infecção [(Skill.Arg2)]"
  },
  Event_6997_ChoiceDesc3 = {
    Text = "[Run Away] Ganhe 50 Sigilos Negros"
  },
  Event_6997_Desc = {
    Text = "Você entrou no território do gato preto.\nIncontáveis olhos se abriram repentinamente na escuridão, cheios de curiosidade, escrutínio e vigilância... mas não havia bondade.\nEsmeralda, âmbar, azul pava...\nVocê parece estar em um mar brilhante de pedras preciosas.\nPara escapar, você——"
  },
  Event_6997_Name = {
    Text = "Cidade dos Gatos"
  },
  Event_6998_ChoiceDesc1 = {
    Text = "[Sobre o Narciso] Obtenha aleatoriamente orações em 2 cartas de comando: \"(EnchantConfig.Arg1)\", \"(EnchantConfig.Arg2)\""
  },
  Event_6998_ChoiceDesc2 = {
    Text = "[Sobre o cão infernal] obtem a relíquia amaldiçoada[(RelicConfig.Arg1)]"
  },
  Event_6998_ChoiceDesc3 = {
    Text = "[Sobre Lily] Infecte com [(Skill.Arg1)]"
  },
  Event_6998_Desc = {
    Text = "\"É hora da dica de Narciso.\""
  },
  Event_6998_Name = {
    Text = "Tempo de dica"
  },
  Event_6999_ChoiceDesc1 = {
    Text = "[Let Pointer] Obtenha uma Relíquia de Ouro \"(RelicConfig.Arg1)\" e infecte \"(Skill.Arg2)\""
  },
  Event_6999_ChoiceDesc2 = {
    Text = "[Hold Pointer] Obtenha relíquia de ouro \"(RelicConfig.Arg1)\" e infecta \"(Skill.Arg2)\""
  },
  Event_6999_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_6999_Desc = {
    Text = "Crack, crack, crack—\nOs ponteiros do destino se movem lentamente, o som do mecanismo se desloca friamente, correndo para uma direção que você absolutamente não quer ver"
  },
  Event_6999_Name = {
    Text = "Fora da ponta da agulha"
  },
  Event_7000_ChoiceDesc1 = {
    Text = "[Vire as Costas] Obtenha 3 cartões de comando aleatórios do baralho, escolha 1 para remover e ganhe 75 sigilos negros."
  },
  Event_7000_ChoiceDesc2 = {
    Text = "[Carefully Inspect] Pegue 3 cartões de comando aleatórios do baralho, escolha 1 cartão original para adicionar ao baralho e ganhe 25 sigilos negros."
  },
  Event_7000_ChoiceDesc3 = {
    Text = "[Vire e Saia] Ganhe 50 sigilos negros"
  },
  Event_7000_Desc = {
    Text = "O destino cruel rasteja aos pés do viajante, o caminho é liso como um espelho, um leve som de estilhaçamento atrás.\nQuem quebrou o destino sob seus pés? É ilusão, armadilha, ou apenas murmúrio, mentira...\nDiante de você, uma rachadura rasteja lentamente"
  },
  Event_7000_Name = {
    Text = "Grieta reptante"
  },
  Event_7001_ChoiceDesc1 = {
    Text = "[Chame os corvos] ganha 25 sigilos negros, infecta[(Skill.Arg2)], continua a escolha"
  },
  Event_7001_ChoiceDesc2 = {
    Text = "[Fique Longe]"
  },
  Event_7001_Desc = {
    Text = "A garra rasgou a capa, penetrando profundamente no ombro"
  },
  Event_7001_Name = {
    Text = "Corvo Solitário"
  },
  Event_7002_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7002_Desc = {
    Text = "O medo às vezes não vem de entidades.\nOnde quer que passe o \"cão infernal\", gotas vermelhas permanecem, refletindo seu contorno"
  },
  Event_7002_Name = {
    Text = "Reflexo Imaterial"
  },
  Event_7003_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7003_Desc = {
    Text = "Acompanhada por uma leve corrente elétrica, você ouve o sussurro da mulher. \n Ela chora, contando incessantemente suas desventuras. \n Uma hora se passa, um dia se passa... até que você já esqueceu o motivo de sua tristeza. \n Finalmente, ela desliga o telefone alegremente e promete lhe enviar um grande presente. \n Você aceita o presente. De qualquer forma, presentes sempre são agradáveis."
  },
  Event_7003_Name = {
    Text = "Por favor, atenda o telefone"
  },
  Event_7004_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7004_Desc = {
    Text = "Sob os olhares confusos dos seus companheiros, você se ajoelha e coloca o punho na testa.\nÓtimo, assim você pode esconder seu rosto perfeitamente"
  },
  Event_7004_Name = {
    Text = "Falso por verdadeiro"
  },
  Event_7005_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7005_Desc = {
    Text = "\"Você já me vestiu com um véu.\"\nA estátua de cera sorri tranquilamente para você.\n\"Eu ofereço a verdade a você, como recompensa pelo seu trabalho árduo.\"\nO líquido negro escorre incessantemente de sua barriga, envolvendo você firmemente.\nO mundo está completamente escuro, mas incrivelmente quente.\nVocê se encolhe e boceja, entrando no Sonho pela @1 vez..."
  },
  Event_7005_Name = {
    Text = "Estátua de Cera Inacabada"
  },
  Event_7006_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7006_Desc = {
    Text = "Você não encontrou nada na névoa"
  },
  Event_7006_Name = {
    Text = "Névoa do Caos"
  },
  Event_7007_ChoiceDesc1 = {
    Text = "[Responder ao Telefone] Obtém uma oração avançada de 3 escolhas"
  },
  Event_7007_ChoiceDesc2 = {
    Text = "[Ignore Bell] Obtenha relíquia de ouro \"(RelicConfig.Arg1)\" e infecta \"(Skill.Arg2)\""
  },
  Event_7007_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7007_Desc = {
    Text = "\"Ding ding ding...\" \nUm chamado de telefone penetrante veio do canto, urgente e barulhento, cada toque mais alto que o anterior, quase lhe dando a ilusão de que se você não atendesse, ele enlouqueceria e explodiria, destruindo assim o mundo.\""
  },
  Event_7007_Name = {
    Text = "Por favor, atenda o telefone"
  },
  Event_7008_ChoiceDesc1 = {
    Text = "[Approach Phantasm] Obtenha 1 de 3 relíquias de prata"
  },
  Event_7008_ChoiceDesc2 = {
    Text = "[Quebrar Fantasma] Obter relíquia de prata \"(RelicConfig.Arg1)\" \"(RelicConfig.Arg2)\", infectar duas vezes \"(Skill.Arg3)\""
  },
  Event_7008_Desc = {
    Text = "É uma miragem no domínio? Ou mais uma memória que não pode ser deixada para trás? \n Você esfregou os olhos, e a ilusão à distância se aproximou - é um mercado cheio de vozes, é o museu de cera que desapareceu na dissolução, é o manicômio da pequena cidade sob a neve e vento, ou é Akutê, cujo cenário já está borrado?"
  },
  Event_7008_Name = {Text = "Miragem"},
  Event_7009_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7009_Desc = {
    Text = "Como se tivesse sido queimado por água fervente, você instintivamente cobriu os ouvidos, isolando a música maligna"
  },
  Event_7009_Name = {
    Text = "Som proibido"
  },
  Event_7010_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7010_Desc = {
    Text = "A melodia brilhante afastou a tensão e o medo, você está cheio de paixão, florescendo, alegre, caminhando rapidamente, deixando Ramona para trás - \"Guardião do Segredo?! Não vá tão rápido!\""
  },
  Event_7010_Name = {
    Text = "Som Anônimo"
  },
  Event_7011_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7011_Desc = {
    Text = "\n\"Pare aí!!! Até o monstro em decomposição que rasteja em sua barriga conhece seus próprios membros melhor do que você!\" \nDeixe o público ir... \nVocê reza isso em seu coração"
  },
  Event_7011_Name = {
    Text = "Vilão no Caminho Estreito"
  },
  Event_7012_ChoiceDesc1 = {Text = "[Retirar]"},
  Event_7012_Desc = {
    Text = "Isso é apenas um domínio.\nO que você quer proteger, o que deseja escapar, é uma realidade única"
  },
  Event_7012_Name = {
    Text = "Abismo Espiral"
  },
  Event_7013_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7013_Desc = {
    Text = "\n\"Você é o mais detestável.\" \nVocê rasga o manuscrito em fragmentos, espalhando-os ao vento, desintegrando-se em vários grupos de pétalas voadoras. \nO poeta olha para os caracteres que giram no vento, com um olhar de obsessão curvando-se nos cantos de sua boca. \n\"Bonito...\""
  },
  Event_7013_Name = {
    Text = "Vilão no Caminho Estreito"
  },
  Event_7014_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7014_Desc = {
    Text = "Você rasgou o pôster, revelando anotações descuidadas sobre as despesas do museu de cera. \n O autor da caligrafia claramente não tinha paciência ou talento para matemática, e essas contas jamais poderão ser equilibradas. \n Você deu uma olhada rápida e a maior despesa parece ser \"limpeza e manutenção das estátuas de cera\". \n As despesas com funcionários são risíveis, com a última compra sendo 12 chicotes de crina de cavalo, custando cerca de 20 Lavkas. \n Há também uma despesa especial - \"a comida deles\". \n Quem são \"eles\"?"
  },
  Event_7014_Name = {
    Text = "Risada na Escuridão"
  },
  Event_7015_ChoiceDesc1 = {
    Text = "[Leave] Obtenha uma Relíquia de Prata \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7015_Desc = {
    Text = "\"Astúcia... e uma resposta correta.\"\nA voz soou intrigada com a resposta, enquanto um objeto prateado emergia da água.\n\"Recorde-se, tudo tem um preço.\""
  },
  Event_7015_Name = {
    Text = "Voz fora do mundo"
  },
  Event_7016_ChoiceDesc1 = {
    Text = "[Catch the Second Butterfly] Delete 1 cartão de comando, ganhe Arg1 Sigilo Negro"
  },
  Event_7016_ChoiceDesc2 = {
    Text = "[Não Dura Mais]"
  },
  Event_7016_Desc = {
    Text = "Eles são habitantes da dimensão espiritual? Ou seres nascidos da corrosão?\nCom dúvidas, você entra em uma tempestade de borboletas"
  },
  Event_7016_Name = {
    Text = "Tempestade de Conhecimento"
  },
  Event_7017_ChoiceDesc1 = {
    Text = "[Observe the Third Butterfly] Remova 1 cartão de comando e ganhe Arg1 sigilos negros."
  },
  Event_7017_ChoiceDesc2 = {
    Text = "[Não Dura Mais]"
  },
  Event_7017_Desc = {
    Text = "Dor insuportável entre os dedos, você solta a mão de repente"
  },
  Event_7017_Name = {
    Text = "Tempestade de Conhecimento"
  },
  Event_7018_ChoiceDesc1 = {
    Text = "[Sair] ganha 25 o sigilo negro, infecção de[(Skill.Arg1)]"
  },
  Event_7018_Desc = {
    Text = "\"Vocês humanos não têm outras respostas?\"\nO dono da voz soltou um rosnado impaciente, sacudindo todo o espaço.\n\"Gananciosos e ignorantes... É por isso que estou cansado de vocês.\""
  },
  Event_7018_Name = {
    Text = "Voz fora do mundo"
  },
  Event_7019_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7019_Desc = {
    Text = "\"Não se preocupe, eu só dei um pequeno castigo ao convidado ganancioso. Não posso evitar—eu não gosto de cerveja~\""
  },
  Event_7019_Name = {
    Text = "Fragmentos de Memória: Cerveja"
  },
  Event_7020_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7020_Desc = {
    Text = "\"Pare de cantar—\"\nVocê avisa o cantor desafinado, recusando-se a deixar que eles torturem seus ouvidos mais."
  },
  Event_7020_Name = {
    Text = "Vilão no Caminho Estreito"
  },
  Event_7021_ChoiceDesc1 = {
    Text = "[Leave] Escolha despertar 2 Despertadores"
  },
  Event_7021_Desc = {
    Text = "Você se vira para sair, mas se perde no longo corredor. \nO corredor interminável quase esgota sua paciência, até que você encontra um pequeno palco velho. \nVocê pisca, e o palco desaparece"
  },
  Event_7021_Name = {
    Text = "Cerimônia Final II"
  },
  Event_7022_ChoiceDesc1 = {
    Text = "[Levantar o Cálice] Ganhar um cartão especial"
  },
  Event_7022_Desc = {
    Text = "Um copo de líquido dourado e claro, cintilando como as ondas douradas de trigo no outono tardio, exalando um aroma doce e tentador como o mel. Quais são os seus ingredientes? Quem o colocou aqui? Por que ninguém está cuidando dele?\nAntes que essas perguntas sejam respondidas, um pensamento misterioso invade sua mente: você deve beber isso agora, imediatamente.\nNeste momento, você se transforma em uma mariposa enfeitiçada pelas chamas, em um inseto capturado por uma planta carnívora, incapaz de se conter enquanto estende a mão para aquele copo de vinho doce—"
  },
  Event_7022_Name = {
    Text = "Vinho doce de mel"
  },
  Event_7023_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7023_Desc = {
    Text = "Você tenta examinar a porta, mas ela desaparece ao toque, e um som de algo se abrindo vem de longe"
  },
  Event_7023_Name = {
    Text = "Porta Estranha"
  },
  Event_7024_ChoiceDesc1 = {
    Text = "[Sem Ação]"
  },
  Event_7024_ChoiceDesc2 = {
    Text = "[Limpar Impressão da Palma]"
  },
  Event_7024_Desc = {
    Text = "O escritório de Francis é frio e arrumado, refletindo a meticulosidade do proprietário. \n Em uma caixa no canto, você encontrou uma impressão de poeira de 5 polegadas de lado. \n A forma da impressão é estranha - o contorno externo parece ser a pegada de uma besta, enquanto o centro está incrustado com a pequena impressão da mão de uma menina humana. Parece que primeiro a impressão humana foi deixada, e depois a enorme pata da besta a cobriu. \n Você certamente pode imaginar uma cena calorosa, como uma besta domesticada e submissa cobrindo a mão da menina com suas garras, oferecendo um toque suave. \n Mas você conhece a verdade - é a marca deixada por um monstro que foi cruelmente fundido em experimentos."
  },
  Event_7024_Name = {
    Text = "Pista de Besta Gigante"
  },
  Event_7025_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7025_Desc = {
    Text = "Os experimentos errantes já te cansaram, um breve descanso é como chuva no deserto"
  },
  Event_7025_Name = {
    Text = "Porta Infinita"
  },
  Event_7026_ChoiceDesc1 = {
    Text = "[Master] Obteve a relíquia amaldiçoada \"(RelicConfig.Arg1)\", infectada com \"(Skill.Arg2)\""
  },
  Event_7026_ChoiceDesc2 = {
    Text = "[Levá-lo] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_7026_ChoiceDesc3 = {
    Text = "[Disassemble It] Ganhe 50 Sigilos Negros"
  },
  Event_7026_Desc = {
    Text = "Você estava caminhando para frente e chutou algo no chão.\nEra uma bússola, o vidro já havia quebrado e o restante estava coberto de lodo de dissolução; você a virou cuidadosamente e viu vagamente o emblema da Universidade de Mythag gravado na parte de trás"
  },
  Event_7026_Name = {
    Text = "Sua escolha"
  },
  Event_7027_ChoiceDesc1 = {
    Text = "[Ler a Carta] Remover 1 cartão de comando, ganhar Arg1 sigilos negros"
  },
  Event_7027_ChoiceDesc2 = {
    Text = "[Close the Box]"
  },
  Event_7027_Desc = {
    Text = "Uma carta, outra carta, mais uma. \n O papel de carta está cheio do seu passado e retrata seu futuro. Seduzido por algo estranho, você não consegue parar de rasgar e engolir o papel. \n \"Ei? O que você está fazendo de novo? Bebendo ar?\" \n Murphy te chuta, acordando-te da ilusão; ao voltar a si, não há nada à sua frente."
  },
  Event_7027_Name = {
    Text = "Carta inesperada"
  },
  Event_7028_ChoiceDesc1 = {
    Text = "[Leave] Obter 1 de 3 Orações"
  },
  Event_7028_Desc = {
    Text = "Ao ouvir sua voz, a silhueta para; a voz de Clementine mal consegue atravessar a névoa densa.\n\"Ah—é você\", ela diz, indistinta e nebulosa, como luar se dissolvendo na água. \"Não se preocupe, você ficará bem\"— é um pensamento agradável, mas difícil de acreditar.\n\"Quando terminar aqui, nos encontraremos novamente.\""
  },
  Event_7028_Name = {
    Text = "Figura na névoa"
  },
  Event_7029_ChoiceDesc1 = {
    Text = "[Destinatário: Secretaria Acadêmica] ganhe relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_7029_ChoiceDesc2 = {
    Text = "[Destinatário: Parceiro] ganhe relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_7029_Desc = {
    Text = "Ao escrever o destinatário, a carta começou a fumegar. Uma mão invisível atravessou o vazio e arrancou a carta de sua mão—\ncom um som de mastigação, seu corpo ficou pesado.\nMas a criação em sua mão mostra que a viagem não foi em vão"
  },
  Event_7029_Name = {
    Text = "Confissão unidirecional"
  },
  Event_7030_ChoiceDesc1 = {
    Text = "[Inserir Chave de Prata]"
  },
  Event_7030_Desc = {
    Text = "Parece que o limos saturado contém certas substâncias... Observe-o com a chave de prata e transfira-o para sua própria força"
  },
  Event_7030_Name = {
    Text = "Ponto de extração"
  },
  Event_7031_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7031_Desc = {
    Text = "Espere até que eles apareçam das sombras"
  },
  Event_7031_Name = {
    Text = "Lanterna Corvo Preto"
  },
  Event_7032_ChoiceDesc1 = {
    Text = "[Chame os corvos] ganha 35 sigilos negros, infecta[(Skill.Arg2)], continua a escolha"
  },
  Event_7032_ChoiceDesc2 = {
    Text = "[Fique Longe]"
  },
  Event_7032_Desc = {
    Text = "Pássaros negros são convocados, seus corpos incham e vomitam algo em sua mão.\nEles voltam ao mastro, olhando fixamente para você"
  },
  Event_7032_Name = {
    Text = "Corvo Solitário"
  },
  Event_7033_ChoiceDesc1 = {
    Text = "[Entrar na Caverna]"
  },
  Event_7033_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7033_Desc = {
    Text = "\"Tosse, tosse, tosse...\"\nUma voz tão familiar... Eu me lembro dela, chiado!\nOs humanos fazem esse som quando estão doentes ou perto da morte!\nRápido, dê uma olhada, chiado!"
  },
  Event_7033_Name = {
    Text = "Profundezas da caverna"
  },
  Event_7034_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7034_Desc = {
    Text = "Você aprendeu tudo sobre os núcleos de prata, incluindo como identificar seus graus. \n Evidentemente, esses núcleos de prata não atendem aos requisitos básicos de refinamento. \n Você teve que abandoná-los, assim como as almas fragmentadas que podem estar presas neles. \n Aprender a abrir mão também é uma lição obrigatória para o Guardião do Segredo."
  },
  Event_7034_Name = {Text = "Alma Presa"},
  Event_7035_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7035_Desc = {
    Text = "Este é um corredor unidirecional, você não pode voltar pela entrada"
  },
  Event_7035_Name = {Text = "Passagem"},
  Event_7036_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7036_Desc = {
    Text = "Termine logo, para ficar tranquilo. Os investigadores de Missaga nunca temem o perigo"
  },
  Event_7036_Name = {
    Text = "Porta Infinita"
  },
  Event_7037_ChoiceDesc1 = {
    Text = "[Pedir licença, estou com pressa]"
  },
  Event_7037_ChoiceDesc2 = {
    Text = "[Gostaria de Ouvir Mais]"
  },
  Event_7037_Desc = {
    Text = "\"Com licença, por favor aguarde. Vejo que você parece sério e apressado; talvez você esteja preso em algum tipo de dilema.\nMas uma pessoa não deve perder a perspectiva geral ou a calma por causa da situação atual.\nPor exemplo, nos últimos dias, tenho considerado seriamente muitas inconsistências entre a lenda de Cérbero e a situação atual.\""
  },
  Event_7037_Name = {
    Text = "Companheiro Estranho II"
  },
  Event_7038_ChoiceDesc1 = {
    Text = "[Receive the Gift]"
  },
  Event_7038_ChoiceDesc2 = {
    Text = "[Decline Kindly]"
  },
  Event_7038_Desc = {
    Text = "O menino senta-se na janela, olhando para você. Ele tem esperado por você há muito tempo.\n\"Foi um sucesso, m-muito obrigado.\"\n\"Eu estarei partindo em breve... Este é um presente para você.\"\nO menino estende a mão para você.\nVocê vê uma caixa de presente lindamente embrulhada, com sangue escorrendo e manchando a mão do menino."
  },
  Event_7038_Name = {
    Text = "Cerimônia Final VI"
  },
  Event_7039_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7039_Desc = {
    Text = "Espero que você sempre tenha essa confiança"
  },
  Event_7039_Name = {
    Text = "Reflexo Imaterial"
  },
  Event_7040_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7040_Desc = {
    Text = "Você aceitou essa pequena e macia orelha. \n Ela está envolta em uma cera espessa, repousando tranquilamente no centro da sua palma. \n Uma forte sensação de responsabilidade surge em seu coração. \n Primeiro, o bar não deve ser visitado à toa, a música lá é muito caótica. \n Em segundo lugar, o Teatro Wellington também não pode ser visitado, a orquestra lá é antiquada. \n E então... \n Você e seus companheiros aceitam bem o fato de terem um novo bichinho de estimação."
  },
  Event_7040_Name = {
    Text = "Preste atenção"
  },
  Event_7041_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7041_Desc = {
    Text = "\"O professor Alistair é a pedra angular de Misaq, sem ele, todo o sistema de Misaq parará de funcionar.\"\n Você se lembra vagamente de uma aula entediante, onde Czort, com o rosto sério, disse essa frase enquanto batia no quadro negro.\n E se essa pedra angular desmoronar em pedaços, como você se comportaria? Um enorme medo te envolveu.\n \"Para onde você vai?\" O chamado de Ramona te trouxe de volta à realidade.\n Era passado ou futuro, real ou imaginação, ou um sonho de outro dimensão? Você também não sabia.\n Em suas mãos, apareceu um \"presente\"."
  },
  Event_7041_Name = {
    Text = "Grito do Caos"
  },
  Event_7042_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7042_Desc = {
    Text = "\"Esta cadeira de rodas é meu segundo par de pernas; provavelmente nunca estarei sem ela nesta vida,\" disse o Professor Alistair com um sorriso irônico, \"mas o infeliz é que isso me tornou muito mais baixo.\" \n\nEntão, esse não pode ser o verdadeiro Professor Alistair."
  },
  Event_7042_Name = {
    Text = "Grito do Caos"
  },
  Event_7043_ChoiceDesc1 = {
    Text = "[Quem está falando?] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7043_ChoiceDesc2 = {
    Text = "[Que Whiskey é esse, me deixa Experimentar também] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7043_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7043_Desc = {
    Text = "\"Você realmente não vai experimentar um gole? Este é um ótimo whiskey. Se não fosse o dono do bar que generosamente me deu uma garrafa inteira, eu não ia querer te dar nem uma gota.\"\n\"Então, você ajudou a afastar aquele cara magro e seco, com a pele esticada como borracha, que só bebia bloody mary, e isso é toda a recompensa do dono. Para aquela investigação, você gastou um mês, visitou trinta casas, levou onze portas na cara e consumiu dezessete balas de revólver. Uma garrafa de whiskey, você nem o seu investimento consegue recuperar.\"\n\"Tudo bem, tudo bem, não seja tão exigente. Pelo menos, agora temos esta garrafa de whiskey, não é?\""
  },
  Event_7043_Name = {
    Text = "Fragmento de Memória: Whisky"
  },
  Event_7044_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7044_Desc = {
    Text = "Você segura o tentáculo do Despertado, ele olha para você com um brilho indecifrável nos olhos.\nEle não diz nada, mas você entende suas palavras ocultas—\n\"Usurpação.\""
  },
  Event_7044_Name = {
    Text = "Efeito borboleta"
  },
  Event_7045_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7045_Desc = {
    Text = "O telégrafo está completamente danificado. Imagine o desespero do proprietário na tempestade... igual ao seu agora"
  },
  Event_7045_Name = {
    Text = "Relíquias dos antigos"
  },
  Event_7046_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7046_Desc = {
    Text = "Nome: Leigh\nIdade: 20\nComplicações: hemofilia com grave histeria\nCrescimento anômalo: tentáculos vermelhos profundos@2 bocais\nTransplante: órgãos e tecidos de parentes diretos@3\nMotivo da entrega: Sem motivo especial. Eu não gosto dela.\n（O resto foi riscados.）"
  },
  Event_7046_Name = {
    Text = "Registro de órgãos"
  },
  Event_7047_ChoiceDesc1 = {
    Text = "[Select \"Receive Blessing\"] Perder todos os sigilos negros. Ganhar 1 relíquia de ouro."
  },
  Event_7047_Desc = {
    Text = "Uma bola de lama negra aparece diante de você, tremulando enquanto entrega um documento. \n \"Atualmente não posso me apresentar... Mas você pode conhecer nossos serviços personalizados...\" \n Uma voz feminina flutua do interior do peito da lama, ligeiramente nervosa, como se estivesse evitando algo. \n \"A Bênção da Fada é válida de acordo com o nível de associação, garantindo que não haja engano.\" \n \"Assine, rápido, assine!\""
  },
  Event_7047_Name = {
    Text = "Bênção da Fada"
  },
  Event_7048_ChoiceDesc1 = {
    Text = "[Listening Closely] Ganhe a relíquia prata \"(RelicConfig.Arg1)\" e inflija \"(Skill.Arg2)\""
  },
  Event_7048_ChoiceDesc2 = {
    Text = "[Aproximar e Verificar] Todos os Despertos recuperam 50 de loucura, infectar [(Skill.Arg1)]"
  },
  Event_7048_ChoiceDesc3 = {
    Text = "[Leave Directly] Ganhe 1 de 3 Orações"
  },
  Event_7048_Desc = {
    Text = "\"Você sabia?\" Enquanto Ramona procurava pela figura misteriosa, uma voz sussurrou de repente, \"Você sabe sobre aquele assunto? Aquele grande assunto?\""
  },
  Event_7048_Name = {
    Text = "O ouvido alheio"
  },
  Event_7049_ChoiceDesc1 = {
    Text = "[Focar] Remova até 2 Cartões de Sintoma."
  },
  Event_7049_ChoiceDesc2 = {
    Text = "[Meditate] Escolha despertar 1 Despertador."
  },
  Event_7049_ChoiceDesc3 = {
    Text = "[Connect] Restaurar Arg2 Vida."
  },
  Event_7049_Desc = {
    Text = "Você explora na névoa, de repente, o emblema no seu peito emite um fraco brilho prateado. Quem está chamando você do outro lado do comunicador?"
  },
  Event_7049_Name = {
    Text = "Ponto de contato"
  },
  Event_7050_ChoiceDesc1 = {
    Text = "[Manuseie com Cuidado] Aumente a saúde máxima em Arg1"
  },
  Event_7050_ChoiceDesc2 = {
    Text = "[Avançar] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7050_Desc = {
    Text = "Uma sombra formada pelo domínio estende a mão para você, sua figura é vaga.\nVocê se lembra de um investigador de Missaga que subiu a bordo deste navio, será ele?\nOu é apenas mais uma memória presa pelo domínio"
  },
  Event_7050_Name = {
    Text = "Usador de chave de prata"
  },
  Event_7051_ChoiceDesc1 = {
    Text = "[Leave] Obtenha Relíquia de Ouro \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7051_Desc = {
    Text = "\"Olha, por causa de um comentário casual meu, eu ignorei a situação mais urgente, o que não é bom. \nSe atrasarmos mais, sua presa escapará para longe. \nComo um pedido de desculpas, estas coisas são para você.\"\n\nO homem divaga sobre algo mais, entregando um certo item a você."
  },
  Event_7051_Name = {
    Text = "Companheiro Estranho II"
  },
  Event_7052_ChoiceDesc1 = {
    Text = "[Sair] escolha 1 carta dentre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_7052_Desc = {
    Text = "\"Que você consiga o que deseja.\"\nO homem encolheu os ombros e se afastou, abrindo um caminho."
  },
  Event_7052_Name = {
    Text = "Companheiro Estranho II"
  },
  Event_7053_ChoiceDesc1 = {Text = "[Pocketed]"},
  Event_7053_Desc = {
    Text = "Uma substância prateada, quase mercurial, extraída de uma mucosa de dissolução, contém grande poder espiritual, utilizada principalmente para vincular mais despertadores em rituais"
  },
  Event_7053_Name = {
    Text = "Núcleo de prata"
  },
  Event_7054_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7054_Desc = {
    Text = "Você entrou em um novo caminho.\nO sol nasce, humanos morrem, e você se perde.\nNada é novo"
  },
  Event_7054_Name = {
    Text = "Labirinto dos Olhos"
  },
  Event_7055_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7055_Desc = {
    Text = "Parece uma sombra distorcida pela luz"
  },
  Event_7055_Name = {
    Text = "Objeto flutuante no balde"
  },
  Event_7056_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7056_Desc = {
    Text = "Você se virou e só viu um par solitário de sapatos de couro. \n \"Desculpe, não tive más intenções.\" \n \"Se você encontrar meu corpo, por favor, avise-o que seu mais fiel companheiro de caminhada está aguardando no expositor 45 da sala de exibição 1.\" \n \"— Lembre-se, é aquele par de couro bovino, não de couro de cabra.\""
  },
  Event_7056_Name = {Text = "Oxford"},
  Event_7057_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7057_Desc = {
    Text = "Deve ser um ex-aluno - você abriu os braços para ele, mas foi seguido por uma dor gelada.\nDepois que a dor passou, seus membros ficaram mais fortes do que nunca"
  },
  Event_7057_Name = {
    Text = "Usador de chave de prata"
  },
  Event_7058_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7058_Desc = {
    Text = "Você sentiu que a névoa à sua frente parecia diminuir\n\nVocê sentiu que sua visão ficou mais aguçada para as próximas ações"
  },
  Event_7058_Name = {
    Text = "Prova dos Asuras"
  },
  Event_7059_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7059_Desc = {
    Text = "O fantasma também se aproxima de você, a memória retorna de repente, e tudo à sua frente se torna claro"
  },
  Event_7059_Name = {Text = "Miragem"},
  Event_7060_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7060_Desc = {
    Text = "Seu inconsciente ainda muda algo no além"
  },
  Event_7060_Name = {Text = "Seu olhar"},
  Event_7061_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7061_Desc = {
    Text = "Em uma emergência, não é hora de coletar núcleos de prata"
  },
  Event_7061_Name = {
    Text = "Prova de Existência"
  },
  Event_7062_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para relíquia de prata, infecção de[(Skill.Arg1)]"
  },
  Event_7062_Desc = {
    Text = "A figura indistinta torna-se gradualmente clara, não é um Corpo de fusão, nem uma Catástrofe, mas sim a Clementine, sem asas e com uma expressão normal. \n \"Que coincidência, você também veio admirar a luz da lua?\" ela disse sorrindo, e você sentiu uma onda de tontura, \"Em uma noite de névoa densa, é melhor ter cuidado. \n \"Os pequenos aqui não são muito tranquilos.\""
  },
  Event_7062_Name = {
    Text = "Figura na névoa"
  },
  Event_7063_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7063_Desc = {
    Text = "Com o som de gesso quebrando no chão, seu corpo se despedaçou. Gritos de desespero encheram sua mente, mas felizmente, você recuou a tempo"
  },
  Event_7063_Name = {
    Text = "Completar o corpo danificado"
  },
  Event_7064_ChoiceDesc1 = {
    Text = "[Ouvir a Tristeza] Escolha 1 de 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7064_ChoiceDesc2 = {
    Text = "[Hear Joy] Para cada Despertar com Aliemus 50 ou acima, ganhe 15 O sigilo negro."
  },
  Event_7064_ChoiceDesc3 = {
    Text = "[Leave] Obter 1 de 3 Orações"
  },
  Event_7064_Desc = {
    Text = "Melódico, lírico, alegre, triste... A melodia ecoa no espaço do domínio, difícil de identificar sua origem.\nÉ uma sonata que flui do navio fantasma, ou uma rapsódia de meia-noite aprisionada no domínio?"
  },
  Event_7064_Name = {
    Text = "Som Anônimo"
  },
  Event_7065_ChoiceDesc1 = {
    Text = "[Eles estão procurando alguém] Remova 1 Cartão de Comando, Ganhe 25 Sigilos Negros."
  },
  Event_7065_ChoiceDesc2 = {
    Text = "[Eles estão procurando por algo] Copie uma carta do baralho, infecte com [(Skill.Arg1)]"
  },
  Event_7065_Desc = {
    Text = "Por que os Portadores de Lanternas apareceram de repente na Vila de Lai? Há muitos mistérios aqui. \n O Cão do Inferno Cérbero, o diretor do manicômio de Lai Francis, a Associação de Escultores, a Igreja da Lanterna... \n Certamente há alguma fonte que os reuniu nesta pequena vila que não é muito povoada. \n A máquina de escrever de repente começou a jorrar tinta automaticamente, como se estivesse te chamando para digitar algo."
  },
  Event_7065_Name = {
    Text = "Método de Entrada Misterioso"
  },
  Event_7066_ChoiceDesc1 = {
    Text = "[Feche Bem os Olhos]"
  },
  Event_7066_ChoiceDesc2 = {
    Text = "[Escapar da Cena]"
  },
  Event_7066_Desc = {
    Text = "A apresentação parou abruptamente. Você olha ao redor e vê a plateia cheia.\nTodos têm o mesmo rosto do garoto, olhando fixamente para você.\nAh——\nEles abrem suas bocas negras silenciosamente"
  },
  Event_7066_Name = {
    Text = "Cerimônia Final V"
  },
  Event_7067_ChoiceDesc1 = {
    Text = "[Pegue a foto] escolha 1 de 3 cartas de comando e ganhe oração: [(EnchantConfig.Arg1)]"
  },
  Event_7067_ChoiceDesc2 = {
    Text = "[Check film] infecção[(Skill.Arg1)], trocando a oração obtida na opção 1, pode ser utilizada uma vez"
  },
  Event_7067_Desc = {
    Text = "Você colocou o filme sob a luz avermelhada, a base semi-translúcida deixava entrever as imagens. \n Mãos, pés, globos oculares, vísceras... todos os órgãos humanos que você pode imaginar e até os que não pode, estavam fielmente registrados no filme. \n Eles foram cuidadosamente lavados e dispostos, organizados como seu primeiro poema metrificado."
  },
  Event_7067_Name = {
    Text = "registrar fielmente"
  },
  Event_7068_ChoiceDesc1 = {
    Text = "[Guarda da princesa] desperta aleatoriamente 1 despertador, infecta[(Skill.Arg1)]"
  },
  Event_7068_ChoiceDesc2 = {
    Text = "[Meditator] escolhe 1 de 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_7068_Desc = {
    Text = "\"Da, da, da...\"\nPassos se aproximaram de longe, e você viu alguém prestes a abrir a grande porta do estúdio.\nSem lugar para recuar, você só podia fingir ser uma escultura de cera na luz tênue, tentando evitar aquele olhar investigativo."
  },
  Event_7068_Name = {
    Text = "Falso por verdadeiro"
  },
  Event_7069_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7069_Desc = {
    Text = "\"Ótimo, ótimo!\" A voz transbordava de alegria. \"Você finalmente se tornou como eu, Irmã Sasha!\""
  },
  Event_7069_Name = {
    Text = "\"Irmã Sasha\""
  },
  Event_7070_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7070_Desc = {
    Text = "Talvez alguém os tenha levado até aqui.\nCom sua exploração, a identidade dessa pessoa será revelada"
  },
  Event_7070_Name = {
    Text = "Método de Entrada Misterioso"
  },
  Event_7071_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7071_Desc = {
    Text = "Termine logo, para ficar tranquilo. Os investigadores de Missaga nunca temem o perigo"
  },
  Event_7071_Name = {
    Text = "Porta sem fim"
  },
  Event_7072_ChoiceDesc1 = {
    Text = "[Choose Morality] Restaurar Arg1 pontos de vida"
  },
  Event_7072_ChoiceDesc2 = {
    Text = "[Escolher Vida] Recupere toda a vida, Infecte[(Skill.Arg2)]"
  },
  Event_7072_Desc = {
    Text = "Você talvez tenha tido um coração dourado. \n Ele pulsava dia e noite, dando o seu melhor pela sua vida e existência... caloroso, intenso e cheio de esperança. \n Mas não se sabe quando, sua frequência começou a diminuir. Como a vida e a moral, ele só pode suportar uma das duas..."
  },
  Event_7072_Name = {
    Text = "Sede Amaldiçoada"
  },
  Event_7073_ChoiceDesc1 = {
    Text = "[Pegue a foto] escolha 1 de 3 cartas de comando e ganhe oração: [(EnchantConfig.Arg1)]"
  },
  Event_7073_ChoiceDesc2 = {
    Text = "[Check film] infecção[(Skill.Arg1)], trocando a oração obtida na opção 1, pode ser utilizada duas vezes"
  },
  Event_7073_Desc = {
    Text = "\n\"Então, você registrou tudo de forma verdadeira.\" \n\"Sim, a verdade está no filme.\"\nA conversa parou abruptamente, e inúmeros olhos invisíveis se voltaram para você, aparentemente aguardando seu veredicto final."
  },
  Event_7073_Name = {
    Text = "Declaração de testemunha"
  },
  Event_7074_ChoiceDesc1 = {
    Text = "[Leave] Aumentar a vida em Arg1 e ganhar 25 sigilos negros."
  },
  Event_7074_Desc = {
    Text = "Seu chamado é engolido pelo sibilo do vento. \n \"Você não precisa me conhecer,\" a voz sibilante se torna cada vez mais clara entre as frases, \"Herbert, Herbert é a pessoa que vocês estão procurando. Deixem aquele cara cair, do falso sonho, para a dura e fria realidade.\" \n \"Eu os abençoarei, concedendo a vocês o mais delicioso deste mundo...\""
  },
  Event_7074_Name = {
    Text = "Companheiro Estranho VI"
  },
  Event_7075_ChoiceDesc1 = {
    Text = "[Leave] Obtenha Relíquia \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7075_Desc = {
    Text = "\"Sim, pobre perdido, que tem força mas não consegue se reconhecer. \n Você vai estender a mão para ajudar? Ou levantar a arma contra Ele?\" \n O homem saltou para as águas turbulentas, e no momento em que ele pulou, seus olhos se encontraram. Eram olhos verticais dourados como mel, pertencentes a uma serpente. \n E no lugar onde ele estava, havia uma pequena luz que emitia uma fumaça roxa."
  },
  Event_7075_Name = {
    Text = "Companheiro Estranho VI"
  },
  Event_7076_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7076_Desc = {
    Text = "\"A cautela é uma virtude, mas a cautela excessiva é inoportuna,\" uma voz monótona e inalterada continha descontentamento, \"o movimento das estrelas pode interferir na origem adormecida do Corpo Desperto, e o momento apropriado pode fazer com que Sua Fúria se expanda rapidamente como um balão. Em suma, ainda há tempo para agarrar a cauda do cometa, da próxima vez lembre-se de otimizar sua velocidade de reação que é comparável à de uma tartaruga.\""
  },
  Event_7076_Name = {
    Text = "Ângulo de elevação"
  },
  Event_7077_ChoiceDesc1 = {
    Text = "[Restore] Reduzia o estresse atual pela metade."
  },
  Event_7077_Desc = {
    Text = "Você acessou a câmara de pressão, podendo recuperar o valor atual de pressão"
  },
  Event_7077_Name = {
    Text = "Ponto de estabilização de pressão"
  },
  Event_7078_ChoiceDesc1 = {
    Text = "[Confortá-la] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_7078_ChoiceDesc2 = {
    Text = "[Culpe-a] Conceder aleatoriamente orações a 3 cartões de comando: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7078_Desc = {
    Text = "\"Eu sou a sombra do investigador morto, e o assassino é aquela chave de prata.\"\nA mulher se cobriu a cabeça com dor. Seu cabelo era denso, e havia inúmeros olhos brilhantes piscando, piscando...\n\"Eles sempre dizem: Não, Charlotte! Ai, Charlotte!\nEntão eu pensei, se eu conseguisse linkar muitos Corpos Despertos de uma vez, todos ficariam em silêncio.\"\n\"E então... eu não sei o que aconteceu, quando acordei, eu me tornei assim. Ai!\""
  },
  Event_7078_Name = {
    Text = "Sombra do Investigador"
  },
  Event_7079_ChoiceDesc1 = {
    Text = "[Climb the high wall] Obtenha relíquia maldita \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7079_ChoiceDesc2 = {
    Text = "[Entrar no Labirinto] 1 Carta aleatória obtém Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_7079_Desc = {
    Text = "Seu cérebro é um labirinto.\nMuitos pensamentos se entrelaçam dentro dele; a saída está ao alcance d'O Olhar, mas os altos muros do pensamento se erguem entre vocês."
  },
  Event_7079_Name = {
    Text = "Labirinto da Mente"
  },
  Event_7080_ChoiceDesc1 = {
    Text = "[Olhe para o Fantasma] Obtenha 1 de 3 Relíquias de Prata"
  },
  Event_7080_ChoiceDesc2 = {
    Text = "[Near Phantasm] Obtenha a relíquia de prata \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\", infecte duas vezes \"(Skill.Arg3)\""
  },
  Event_7080_Desc = {
    Text = "Lá ao longe, parece haver uma erupção vulcânica, e fumaça em forma humana se eleva sob o céu devastado pelo vento.\nEsta é Elworth, Elworth só tem montanhas nevadas e cavernas de rochas calcárias.\nFoi a anomalia contínua que deixou você em desequilíbrio?"
  },
  Event_7080_Name = {
    Text = "Fantasma vulcânico"
  },
  Event_7081_ChoiceDesc1 = {
    Text = "[Vi algo] Obtenha uma relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_7081_ChoiceDesc2 = {
    Text = "[I Saw Nothing] Ganhe Relíquia de Ouro \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\""
  },
  Event_7081_Desc = {
    Text = "Líquido escorre de seus olhos, a sensação pegajosa é assustadora.\nNo fundo, é causado pelo que você viu, mas você—realmente não viu nada?"
  },
  Event_7081_Name = {
    Text = "Não olhar diretamente"
  },
  Event_7082_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7082_Desc = {
    Text = "Você também se alegrará e se entristecerá, mas neste momento não é sua emoção que o domina. Você tapou os ouvidos, a chave de prata brilhou intensamente.\nFinalmente, você conseguiu respirar"
  },
  Event_7082_Name = {Text = "Vício"},
  Event_7083_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7083_Desc = {
    Text = "O portador da adaga emitiu um grito, como o canto de um pássaro de luto em um cemitério à meia-noite.\nA voz passou em um instante, junto com os outros dois marinheiros desaparecendo… na verdade, foi apenas uma ilusão refletida pelo domínio"
  },
  Event_7083_Name = {
    Text = "Perseguir incansavelmente"
  },
  Event_7084_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7084_Desc = {
    Text = "Fica suspenso no ar, imóvel, olhando fixamente, como se quisesse dizer algo.\nOs olhos podem abrigar a alma, mas sem palavras, você só sente urgência e tristeza.\nDesapareceu no ar"
  },
  Event_7084_Name = {Text = "Olhar cego"},
  Event_7085_ChoiceDesc1 = {
    Text = "[Agree] Obtenha relíquia de prata \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7085_ChoiceDesc2 = {
    Text = "[Gift] Obtenha a relíquia de prata \"(RelicConfig.Arg1)\", infectada com \"(Skill.Arg2)\"."
  },
  Event_7085_ChoiceDesc3 = {
    Text = "[Vire e Saia] Ganhe 25 sigilos negros"
  },
  Event_7085_Desc = {
    Text = "\n\"Se um dia eu tiver que cair, então espero cair na água. \nA água corrente que cobre minhas narinas parece um suave e velho sonho. \nO líquido em que afundo \nesse é o recipiente que @2 mais deseja.\""
  },
  Event_7085_Name = {
    Text = "Cerimônia Aquática"
  },
  Event_7086_ChoiceDesc1 = {
    Text = "[Resist Phantasm] Obtenha relíquia de ouro \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7086_ChoiceDesc2 = {
    Text = "[Absorver loucura] despertar aleatoriamente 2 entidades, infectar duas vezes[(Skill.Arg1)]"
  },
  Event_7086_Desc = {
    Text = "A dimensão incompleta começa a desmoronar, ilusões de outras dimensões invadem a sala doentia"
  },
  Event_7086_Name = {
    Text = "Ilusão Dimensional"
  },
  Event_7087_ChoiceDesc1 = {
    Text = "[Leave] Desperte um Despertador aleatório"
  },
  Event_7087_Desc = {
    Text = "A garota parou, alisando sua saia.\n\"O que posso fazer por você... é apenas isso.\""
  },
  Event_7087_Name = {
    Text = "menina de vestido branco"
  },
  Event_7088_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7088_Desc = {
    Text = "Quem está falando?\nVocê olha para baixo e vê um reflexo desfocado—ele usa as mesmas roupas que você, mas segura uma faca, sorrindo para você."
  },
  Event_7088_Name = {
    Text = "Você não vai querer encontrar"
  },
  Event_70892_ChoiceDesc1 = {
    Text = "[Seguir a Memória do Corpo] Pule a batalha e reivindique a vitória instantânea, mas perca pontos de Vida de Arg1."
  },
  Event_70892_ChoiceDesc2 = {
    Text = "[Leave] Entrar em Batalha"
  },
  Event_70892_Desc = {
    Text = "Apesar de os inimigos serem excepcionalmente poderosos, você já conhece bem as técnicas para derrotá-los."
  },
  Event_70892_Name = {
    Text = "memória muscular"
  },
  Event_7089_ChoiceDesc1 = {Text = "[Rake Kum]"},
  Event_7089_ChoiceDesc2 = {
    Text = "[Atacar o Sujeito de Teste]"
  },
  Event_7089_Desc = {
    Text = "Kum mordeu a nuca de um espécime, pronto para sacudir, mas o espécime de repente virou a cabeça 180° como uma coruja e bicou o rosto de Kum"
  },
  Event_7089_Name = {Text = "Coliseu"},
  Event_7090_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7090_Desc = {
    Text = "Você apertou a chave prateada, sentindo a chamada da origem nas ondas escuras da dimensão.\nPara combater os cães infernais do mal cuja identidade é desconhecida, você deve usar todos os poderes possíveis"
  },
  Event_7090_Name = {
    Text = "Ilusão Dimensional"
  },
  Event_7091_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7091_Desc = {
    Text = "\n\"Quanto a aquele investigador, o curador pretende interrogá-lo pessoalmente... \nDeixe um sobrevivente...\" \nA voz foi gradualmente se enfraquecendo, eventualmente desaparecendo na escuridão"
  },
  Event_7091_Name = {
    Text = "Os muros têm ouvidos"
  },
  Event_7092_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7092_Desc = {
    Text = "A sensação de falta de peso te acorda de repente, o chão é firme e confiável, e ao seu lado está um espelho quadrado e delicado"
  },
  Event_7092_Name = {
    Text = "Espelho no espelho"
  },
  Event_7093_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7093_Desc = {
    Text = "Você nunca debate com alguém que já sucumbiu à Loucura e não tem salvação, pois isso faria sua alma ser completamente Devorada pelas perguntas da meia-noite. Poupe-se!"
  },
  Event_7093_Name = {
    Text = "Cerimônia Aquática"
  },
  Event_7094_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7094_Desc = {
    Text = "Como deve ser o rosto da estátua de cera? \n Você fecha os olhos e milhões de rostos borrados surgem em sua mente. \n Eles são como velas arrastando chamas pálidas, emergindo e desaparecendo no rio escuro... \n Você caminha até o fim do rio, onde está a única e última estátua de cera. \n Ao se aproximar dela, você vê... @2."
  },
  Event_7094_Name = {
    Text = "Estátua de Cera Inacabada"
  },
  Event_7095_ChoiceDesc1 = {
    Text = "[Attack Dagger Holder] Infecte \"(Skill.Arg1)\", obtenha Relíquia Maldita \"(RelicConfig.Arg2)\""
  },
  Event_7095_ChoiceDesc2 = {
    Text = "[Emboscada Armada] Infecção x2 \"(Skill.Arg1)\", Ganhe Relíquia de Ouro \"(RelicConfig.Arg2)\" e \"(RelicConfig.Arg3)\""
  },
  Event_7095_ChoiceDesc3 = {
    Text = "[Derrubar o Portador da Lance] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_7095_Desc = {
    Text = "Três marinheiros agarram vocês com firmeza, seus olhares fervorosos e insanos quase incendiando sua capa.\nAo olhar para trás, você nota que os três são diferentes entre si—\no marinheiro com a grande faca grita de forma mais agressiva, mas age de maneira um tanto descuidada.\nO marinheiro com a lança avança cuidadosamente, como uma criança que está aprendendo a falar.\nO marinheiro com o punhal fica por último, e suas orações fervorosas revelam seu fanatismo."
  },
  Event_7095_Name = {
    Text = "Perseguir incansavelmente"
  },
  Event_7096_ChoiceDesc1 = {
    Text = "[Leave] Obtenha Relíquia \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7096_Desc = {
    Text = "Você pega o presente e o abre com cuidado.\nUm par de olhos repousa na caixa.\n\"Eu te dou meus olhos.\"\n\"Como ele fez comigo.\""
  },
  Event_7096_Name = {
    Text = "Cerimônia Final VI"
  },
  Event_7097_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7097_Desc = {
    Text = "Ao passar pelo centro da luz, você pegou um núcleo prateado solidificado. Esta preciosa portadora de memórias e alma era incrivelmente quente, refletindo uma cor estranha.\nAntes que distorcesse toda luz, a dor ardente fez você jogá-la de volta na escuridão"
  },
  Event_7097_Name = {
    Text = "Luz noturna"
  },
  Event_7098_ChoiceDesc1 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7098_Desc = {
    Text = "Você recusa o presente do garoto. \nO garoto olha para você com suas órbitas vazias. Ele suspira levemente.\n \"Então, adeus.\" \nO garoto faz uma reverência e cai pela janela. \nEle desaparece, como uma borboleta dançante, ou como uma brisa"
  },
  Event_7098_Name = {
    Text = "Cerimônia Final VI"
  },
  Event_7099_ChoiceDesc1 = {
    Text = "Escolha uma oração comum"
  },
  Event_7100_ChoiceDesc1 = {
    Text = "[Accept Ear] Obtenha uma relíquia de prata \"(RelicConfig.Arg1)\" e infecte \"(Skill.Arg2)\"."
  },
  Event_7100_ChoiceDesc2 = {
    Text = "[Reject Request] Obtenha uma Oração com 3 escolhas"
  },
  Event_7100_Desc = {
    Text = "Uma série de notas luxuosas flui das pontas dos dedos. \n O pianista de cera melancólico senta-se sozinho à janela. \n Desde que ganhou consciência, o Museu de Cera é todo o seu mundo. \n Ele esteve isolado por muito tempo e também quer ouvir algo diferente, especialmente... um tipo de música chamado jazz. \n Por fim, ele arranca uma de suas orelhas e pede que você a leve embora. \n \"Deixe-me ouvir a música do lado de fora... só precisa colocá-la no bolso.\""
  },
  Event_7100_Name = {
    Text = "Preste atenção"
  },
  Event_7101_ChoiceDesc1 = {
    Text = "[Connect] Restaurar Arg2 Vida. [ExDesc1]"
  },
  Event_7101_ChoiceDesc2 = {
    Text = "[Meditate] Desperte 1 Despertador. [ExDesc1]"
  },
  Event_7101_ChoiceDesc3 = {
    Text = "[Expelir] Remova até 3 cartões de sintoma, e ganhe Sigilos Negros Arg2."
  },
  Event_7101_Desc = {
    Text = "Você explora na névoa, de repente, o emblema no seu peito emite um fraco brilho prateado. Quem está chamando você do outro lado do comunicador?"
  },
  Event_7101_Name = {
    Text = "Ponto de contato"
  },
  Event_7101_Tips3 = {
    Text = "Nenhuma carta de sintoma disponível"
  },
  Event_7102_ChoiceDesc1 = {
    Text = "[Aceitar Desafio]"
  },
  Event_7102_ChoiceDesc2 = {
    Text = "[Socá-lo] Ganhar 25 sigilos negros"
  },
  Event_7102_Desc = {
    Text = "Uma figura magra emerge da sombra, bloqueando seu caminho. \n Uma memória eternamente restrita irrompe no domínio, uma sombra que se autodenomina \"N\" brinca com as fichas em suas mãos, fazendo um convite vago e confuso para você entrar em seu jogo. \n Fichas tricolores se espalham diante de você, se você não jogar uma \"partida\" com Ele, provavelmente não o deixará sair facilmente."
  },
  Event_7102_Name = {
    Text = "A apresentação começa"
  },
  Event_7103_ChoiceDesc1 = {
    Text = "[Inserir Chave de Prata]"
  },
  Event_7103_Desc = {
    Text = "Parece que o limos saturado contém certas substâncias... Observe-o com a chave de prata e transfira-o para sua própria força"
  },
  Event_7103_Name = {
    Text = "Ponto de extração"
  },
  Event_7104_ChoiceDesc1 = {
    Text = "[Struggle Awake] Aumentar a vida máxima em Arg1"
  },
  Event_7104_ChoiceDesc2 = {
    Text = "[Entregar-se ao Sono Profundo] 2 Cartas de comando aleatórias obtêm Gravura: \"(EnchantConfig.Arg1)\", infectar 2 \"(Skill.Arg2)\""
  },
  Event_7104_Desc = {
    Text = "Você segura um tesouro cintilante em seus braços. \n Ele se agarra ao seu corpo a partir do peito, aquela memória quente que emana um brilho de luz de vela, finalmente sendo injetada em sua mente. \n O estalo do carvão, a poltrona aconchegante perto da lareira, o chá quente e o gato enrolado em seus pés... \n Neste conforto sonolento, sua mente fica turva, e você cai em um mar macio."
  },
  Event_7104_Name = {
    Text = "Perdido no passado"
  },
  Event_7105_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7105_Desc = {
    Text = "Você puxou o resto do filme sem piedade. Ele estava escondido na câmera, e a imagem te deixou sem palavras.\nO filme não revelado mostrava você caído em uma poça de piche"
  },
  Event_7105_Name = {
    Text = "Registro de inocência"
  },
  Event_7106_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7106_Desc = {
    Text = "Você inspecionou a câmera cuidadosamente, o couro e o ouro negro embutidos no corpo refletiam um brilho oleoso.\nA lente estava apontada para você, como se estivesse observando, espiando"
  },
  Event_7106_Name = {
    Text = "Registro de inocência"
  },
  Event_7107_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7107_Desc = {
    Text = "A luz da lua na palma da mão foi derramada sobre a lápide.\nAlguém foi enterrado sob a lama espessa, e os espectadores afirmaram que essa pessoa morreu naturalmente e descansará em paz.\nMas a lama começou a se mover, e em meio aos gritos, uma lua murcha rastejou para fora"
  },
  Event_7107_Name = {
    Text = "Fragmento de Lua de Prata"
  },
  Event_7108_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7108_Desc = {
    Text = "Você toca suavemente as asas finas da borboleta, que bate as asas levemente e se transforma em gotas negras, caindo na sua palma"
  },
  Event_7108_Name = {
    Text = "Algo que não deveria existir"
  },
  Event_7109_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7109_Desc = {
    Text = "A lua solitária paira alta no céu, mas você consegue ouvir claramente suas orações, um tom estranho, como o sussurro de coisas imundas. \n A oração para, e você está prestes a ir embora. Mas atrás de você surge uma sombra branca. \n \"Aqueles que espreitam o destino e profanam as orações, tanto a dádiva quanto o preço chegarão como prometido.\""
  },
  Event_7109_Name = {
    Text = "Fragmento de Lua de Prata"
  },
  Event_7110_ChoiceDesc1 = {
    Text = "[Três Pontos]"
  },
  Event_7110_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_7110_ChoiceDesc3 = {
    Text = "[One Point]"
  },
  Event_7110_Desc = {
    Text = "Parece que você teve sorte hoje.\nOs dados tremem, emitindo um zumbido excitado.\nVocê decide adivinhar um número"
  },
  Event_7110_Name = {
    Text = "Jogo de Apostas Sem Fim"
  },
  Event_7111_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7111_Desc = {
    Text = "Este jogo é uma grande farsa!\nVocê se levanta de repente, mas sente uma tontura.\nOs dados zumbem, uma voz sedutora ecoa em sua mente:\n\"Apenas mais uma... a última...\""
  },
  Event_7111_Name = {
    Text = "Jogo de Apostas Sem Fim"
  },
  Event_7112_ChoiceDesc1 = {
    Text = "[Usar prata] atualizar 1 relíquia de prata para relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_7112_ChoiceDesc2 = {
    Text = "[Store Silver] Obtenha uma relíquia de ouro \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\" e \"(Skill.Arg3)\"."
  },
  Event_7112_ChoiceDesc3 = {
    Text = "[Colocar de Volta na Gaveta] Ganhar 25 Sigilos Negros"
  },
  Event_7112_Desc = {
    Text = "Na segunda gaveta à direita da mesa, há um núcleo de prata solitário. Ao tocá-lo, você ouve o uivo da tempestade, o som de neve esmagada e o lamento de uma flauta"
  },
  Event_7112_Name = {
    Text = "Núcleo de prata solitário"
  },
  Event_7113_ChoiceDesc1 = {
    Text = "[Listening Closely] Infecta \"(Skill.Arg1)\", ganha Relíquia Maldita - \"(RelicConfig.Arg2)\""
  },
  Event_7113_ChoiceDesc2 = {
    Text = "[Fazer uma Mudança] Escolha destruir 1 Relíquia e ganhar 1 recompensa."
  },
  Event_7113_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7113_Desc = {
    Text = "Nem toda música é tocante.\nUma cacofonia pura compõe um lamento"
  },
  Event_7113_Name = {
    Text = "Disonância"
  },
  Event_7114_ChoiceDesc1 = {
    Text = "[Pegue-o] Infectar \"(Skill.Arg1)\", ganhar Relíquia de Prata \"(RelicConfig.Arg2)\""
  },
  Event_7114_ChoiceDesc2 = {
    Text = "[Abandoná-la] Ganhe 25 Sigilos Negros."
  },
  Event_7114_Desc = {
    Text = "No canto de uma pilha de feno podre, dentro de uma rachadura de corrosão, algo está calmamente deitado"
  },
  Event_7114_Name = {
    Text = "depois da pilha de feno"
  },
  Event_7115_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7115_Desc = {
    Text = "Aquela figura não se aproximou, apenas te observou por um momento antes de se transformar em um punhado de areia prateada"
  },
  Event_7115_Name = {
    Text = "Usador de chave de prata"
  },
  Event_7116_ChoiceDesc1 = {
    Text = "[Segurar o Tentáculo] Aceite a ajuda de Tulu"
  },
  Event_7116_Desc = {
    Text = "Com um suspiro, Tulu alcançou.\nMembros pesados e gelados se agarraram a você, sufocando seu desejo de avançar nas fileiras inimigas.\n\"Eu serei sua ajuda, mas apenas por enquanto.\""
  },
  Event_7116_Name = {
    Text = "Promessa do Agente"
  },
  Event_7117_ChoiceDesc1 = {
    Text = "[Pegue a Chave]"
  },
  Event_7117_Desc = {
    Text = "1,2,3…\nA distância entre Jenkin e a mesa era de 10 pés. \nEra uma distância curta, mas longa como toda a sua vida. \nEla se lembrou da fita macia, do papel de bala dourado e das lágrimas de sua mãe. \nEla pensou em muitas, muitas coisas... \nSeu corpo frágil atravessou o rio negro, aproximando-se da mesa pouco a pouco. \nA chave estava na gaveta, e o preço a pagar para obtê-la era simples: coragem, habilidade e um pouquinho de sorte. \nAlém de sorte, Jenkin não faltava em nada."
  },
  Event_7117_Name = {
    Text = "Chave Final"
  },
  Event_7118_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7118_Desc = {
    Text = "Apenas uma aposta, você não vai perder.\nUma moeda gravada foi lançada ao ar, caindo rapidamente, aquecida pela sua palma"
  },
  Event_7118_Name = {
    Text = "Jogador de Azar Famoso"
  },
  Event_7119_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7119_Desc = {
    Text = "Apenas uma aposta, você não vai perder.\nUma moeda gravada foi lançada ao ar, caindo rapidamente, aquecida pela sua palma"
  },
  Event_7119_Name = {
    Text = "Jogador de Azar Famoso"
  },
  Event_7120_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7120_Desc = {
    Text = "Apenas uma aposta, você não vai perder.\nUma moeda gravada foi lançada ao ar, caindo rapidamente, aquecida pela sua palma"
  },
  Event_7120_Name = {
    Text = "Jogador de Azar Famoso"
  },
  Event_7121_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7121_Desc = {
    Text = "Você não tem a intenção de participar desta séria aula de piano. \n Sempre que terminam uma pequena frase musical, os alunos se esforçam para virar a cabeça, fazendo uma expressão de escuta. \n E seu professor também se inclina um pouco, os lábios se movendo, com os olhos redondos olhando para uma partitura que não existe. \n Eles claramente não sabem o que estão fazendo e nunca compreenderão por que os humanos gastam anos realizando esse exercício mecânico. \n Eles estão apenas imitando."
  },
  Event_7121_Name = {
    Text = "Aulas de piano"
  },
  Event_7122_ChoiceDesc1 = {
    Text = "[Inserir Chave de Prata]"
  },
  Event_7122_Desc = {
    Text = "Parece que o limos saturado contém certas substâncias... Observe-o com a chave de prata e transfira-o para sua própria força"
  },
  Event_7122_Name = {
    Text = "Ponto de extração"
  },
  Event_7123_ChoiceDesc1 = {
    Text = "[Recognize Lyrics] Obtenha uma Relíquia de Prata \"(RelicConfig.Arg1)\", e infecte \"(Skill.Arg2)\""
  },
  Event_7123_ChoiceDesc2 = {
    Text = "[Cantar Baixinho] Ganhe Oração com 3 opções"
  },
  Event_7123_Desc = {
    Text = "Uma antiga canção de barco ecoa no domínio.\nAs memórias presas no domínio cantam em uma linguagem que você nunca ouviu, sobre as ondas, o céu e o aguardente"
  },
  Event_7123_Name = {
    Text = "Canção do Mar"
  },
  Event_7124_ChoiceDesc1 = {
    Text = "[Chame os corvos] ganha 20 sigilos negros, infecta[(Skill.Arg2)]"
  },
  Event_7124_ChoiceDesc2 = {
    Text = "[Fique Longe]"
  },
  Event_7124_Desc = {
    Text = "Os pássaros negros olham fixamente para você, e algo cai de suas penas"
  },
  Event_7124_Name = {
    Text = "Corvo Solitário"
  },
  Event_7125_ChoiceDesc1 = {
    Text = "[Step Forward and Grip] Ganhe 25 Sigilos Negros"
  },
  Event_7125_ChoiceDesc2 = {
    Text = "[Resposta Amigável] 50% de chance de ganhar 50 Sigilos Negros, 50% de chance de nada."
  },
  Event_7125_Desc = {
    Text = "Um gato que não se sabe de onde vem está sentado entre os limos, seu corpo borrado indicando que deveria ser um residente da dimensão espiritual.  \nEssa projeção de rosto indefinido observa Ramona com um olhar sábio, levantando sua pata dianteira branca, como um gesto de convite"
  },
  Event_7125_Name = {
    Text = "Residentes Nômades"
  },
  Event_7126_ChoiceDesc1 = {
    Text = "[Running North]"
  },
  Event_7126_ChoiceDesc2 = {
    Text = "[Ignorar o Som]"
  },
  Event_7126_Desc = {
    Text = "Os ataques do inimigo choviam por trás, suas lâminas roçando a capa e assustando um bando de gaivotas no cais.\n\"Cabe para o norte... ou embarque no navio...\"\nAté a pessoa mais tola poderia sentir que alguma força invisível estava ajudando você."
  },
  Event_7126_Name = {
    Text = "Em direção ao norte"
  },
  Event_7127_ChoiceDesc1 = {
    Text = "[Ouvir o Sol] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_7127_ChoiceDesc2 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7127_Desc = {
    Text = "Entrelaçados entre realidade e ilusão, os corpos celestes giram eternamente em suas órbitas.\nIncontáveis encontros e desencontros, compondo sinfonias estranhas e misteriosas…"
  },
  Event_7127_Name = {
    Text = "Som das estrelas e da lua"
  },
  Event_7128_ChoiceDesc1 = {
    Text = "[Leave with Sorrow] Copie uma carta. Se uma carta de sintoma for copiada, ganhe 75 sigilos negros."
  },
  Event_7128_ChoiceDesc2 = {
    Text = "[Partir com raiva] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_7128_Desc = {
    Text = "Líquido irrompe dos pupilos, gelado e violento, levando embora parte da alma"
  },
  Event_7128_Name = {
    Text = "Lágrimas da Praia das Sombras"
  },
  Event_7129_ChoiceDesc1 = {
    Text = "[No Corredor]"
  },
  Event_7129_ChoiceDesc2 = {
    Text = "[Vá Contra a Corrente] Ganhe 25 sigilos negros"
  },
  Event_7129_Desc = {
    Text = "A luz da lua pálida ignorava o passar do tempo, derramando-se sobre o corredor silencioso.\nA porta brilhava estranhamente sob a luz da lua"
  },
  Event_7129_Name = {
    Text = "Galeria silenciosa"
  },
  Event_7130_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7130_Desc = {
    Text = "Você decide consertar esta escultura de cera.\nAlgumas ferramentas estão espalhadas perto da escultura, e você escolhe um corante chamado \"azul da Prússia\".\nÉ tão azul como uma doença"
  },
  Event_7130_Name = {
    Text = "Estátua de Cera Inacabada"
  },
  Event_7131_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7131_Desc = {
    Text = "A pústula emitiu um grito agudo e arrepiante, um sibilo de vento que não deveria existir, uma melodia de flauta ilusória e o som proibido do pus se movendo. \n A pústula se contorceu estranhamente por um momento, depois ficou rígida e caiu em um silêncio mortal. Ao testemunhar essa cena, o corpo desperto ao seu lado parecia ter sido chamado por alguma força."
  },
  Event_7131_Name = {
    Text = "Pústula estranha"
  },
  Event_7132_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7132_Desc = {
    Text = "Seus dedos tocam a estátua, mas a sensação é inesperadamente suave e afundada, você sempre achou que era uma ilusão"
  },
  Event_7132_Name = {
    Text = "Montar os restos"
  },
  Event_7133_ChoiceDesc1 = {
    Text = "[Tear For Her]"
  },
  Event_7133_ChoiceDesc2 = {
    Text = "[Orar para Ela]"
  },
  Event_7133_Desc = {
    Text = "No momento em que seu corpo tocou a borda do barco, memórias que não eram suas inundaram sua mente. \n As pessoas a vestiram com um vestido branco sagrado, adornando-a com joias requintadas e elegantes, e a ergueram em um alto altar, enquanto os moradores da pequena cidade se prostravam aos seus pés. \n Eram olhos cheios de esperança: os marinheiros esperavam que ela abençoasse suas viagens, os pescadores ansiavam por uma temporada de pesca tranquila e sem tempestades, e muitos outros moradores desejavam um ano de prosperidade. \n Entre a multidão de adoradores, estavam seus amigos de infância e seus pais e irmãos com quem conviveu diariamente. \n Ela não queria nada, não sabia o que desejava. \n Responder passivamente aos desejos parecia ser a única obrigação de sua vida."
  },
  Event_7133_Name = {
    Text = "Cerimônia Pré-Voo"
  },
  Event_7134_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7134_Desc = {
    Text = "Aquele corpo mutilado, com olhos pálidos, girou lentamente, observando você se afastar, com um sorriso sombrio"
  },
  Event_7134_Name = {
    Text = "Montar os restos"
  },
  Event_7135_ChoiceDesc1 = {
    Text = "[Face It] Obter a relíquia amaldiçoada \"(RelicConfig.Arg1)\" e ficar infectado com \"(Skill.Arg2)\"."
  },
  Event_7135_ChoiceDesc2 = {
    Text = "[Desistir da Resistência] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_7135_ChoiceDesc3 = {
    Text = "[Run Away] Ganhe 50 sigilos negros"
  },
  Event_7135_Desc = {
    Text = "Alguns blocos de escultura de cera obstruem seu caminho.\nEles são tortos e ásperos em aparência, não se assemelhando à habilidade que se esperaria de Rogers.\n\"Ordens... ordens do mestre...\""
  },
  Event_7135_Name = {Text = "Estudo"},
  Event_7136_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7136_Desc = {
    Text = "Você escolhe olhar nos olhos com coragem. \n Eles são estrelas brilhantes, cintilando na escuridão. \n Em seguida, eles riem e se transformam em inúmeras luas crescentes. \n \"Você não tem medo do olhar. Você também não deve ter medo... \n Há quanto tempo, @2.\" \n Antes de desaparecer, eles te dão um pequeno presente, como uma \"memória do reencontro\"."
  },
  Event_7136_Name = {Text = "olho"},
  Event_7137_ChoiceDesc1 = {
    Text = "[Switch On] Expanda a visão atual[ExDesc1]."
  },
  Event_7137_Desc = {
    Text = "Dispositivo de iluminação deixado pelos antecessores, pode dispersar a névoa negra ao redor.\nA névoa ao redor oscila regularmente, como se perturbada pela respiração"
  },
  Event_7137_Name = {
    Text = "projector de busca"
  },
  Event_7138_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7138_Desc = {
    Text = "Suas costas se abrem em asas transparentes, girando, girando, fluindo para o fundo do mar silencioso junto com os corvos"
  },
  Event_7138_Name = {
    Text = "Voz da matilha de corvos"
  },
  Event_7139_ChoiceDesc1 = {
    Text = "[Destruir isso] obter[Coração Deformado]"
  },
  Event_7139_Desc = {
    Text = "Um abscesso deformado abandonado na beira da estrada, brilhando com uma luz verde suja, se contorcendo inquieto.\nMais parecido com um sorvete derretendo ao sol do que com um monstro, logo se transformará em uma poça de água suja e desaparecerá no ar"
  },
  Event_7139_Name = {
    Text = "Pústula estranha"
  },
  Event_7140_ChoiceDesc1 = {
    Text = "[Largue as mãos que cobrem os ouvidos] Infectar[(Skill.Arg1)], escolha uma recompensa"
  },
  Event_7140_ChoiceDesc2 = {
    Text = "[Pegar um corvo] Obter[(Skill.Arg1)], Escolher uma recompensa"
  },
  Event_7140_ChoiceDesc3 = {
    Text = "[Close Your Eyes] Ganhar 50 sigilos negros"
  },
  Event_7140_Desc = {
    Text = "Grito agudo, um grito agudo sem fim — \n A Cantora Corvo veste um pelo negro e brilhante, com o bico afiado refletindo uma luz fria e dura, seu lamento estridente corta repetidamente seu tímpano. \n Liberte suas mãos que cobrem os ouvidos! \n O bando de corvos que canta à noite quer beber a tremulação não refinada que está dentro do seu corpo encolhido. \n"
  },
  Event_7140_Name = {
    Text = "Canto dos Corvos"
  },
  Event_7141_ChoiceDesc1 = {
    Text = "[Leave] Nada encontrado"
  },
  Event_7141_Desc = {
    Text = "Não é a pessoa que você procura"
  },
  Event_7141_Name = {
    Text = "2_6 Temporário"
  },
  Event_7142_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7142_Desc = {
    Text = "Você escolheu continuar.\nComparado aos danos físicos e mentais causados pela má arte em cera, essas pequenas preocupações não são nada.\nVocê tem uma obra maior a realizar"
  },
  Event_7142_Name = {Text = "passos"},
  Event_7143_ChoiceDesc1 = {
    Text = "[Apontar o problema] escolha 1 de 3 cartas de comando e ganhe oração: [(EnchantConfig.Arg1)]"
  },
  Event_7143_Desc = {
    Text = "\"O que há de errado! Você simplesmente ama cutucar as feridas dos outros assim?\"\n\"Sim! Eu de repente envelheci vinte e cinco anos sem motivo! Agora você tem que me chamar de Irmã Murphy!\""
  },
  Event_7143_Name = {Text = "Vida Presa"},
  Event_7144_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para relíquia de prata, infecção de[(Skill.Arg1)]"
  },
  Event_7144_Desc = {
    Text = "O rosto da garota estava sereno como a luz da lua naquela noite. Ela não respondeu, mas levantou a bússola tremendo, como se isso consumisse toda sua vida"
  },
  Event_7144_Name = {
    Text = "menina de vestido branco"
  },
  Event_7145_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7145_Desc = {
    Text = "\"Delicioso! Delicioso!\" O corvo grasnou, e o fedor de decomposição se espalhou até o seu nariz enquanto ele desenrolava suas asas."
  },
  Event_7145_Name = {
    Text = "Corvo Amaldiçoado"
  },
  Event_7146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7146_Desc = {
    Text = "Para mim, o ruído é definitivamente o modelo da nova geração. \n Eles marcham pelo mundo, pisando firmemente em um ritmo caótico e uma melodia que leva ao colapso. \n Sem compaixão, sem abalos e sem compromissos. \n Odiando a regularidade e rejeitando temas, o ruído nunca agrada os outros — \n claro, incluindo nosso escultor de cera."
  },
  Event_7146_Name = {Text = "gosto ruim"},
  Event_7147_ChoiceDesc1 = {Text = "[Guiar]"},
  Event_7147_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7147_Desc = {
    Text = "Alguém está puxando suavemente sua manga.\nÉ o garoto que você viu mais cedo. Ele está agachado no canto, olhando para você com uma expressão triste.\n\"Eu-quero participar da apresentação da academia.\nMas não consigo encontrar o caminho para o palco.\""
  },
  Event_7147_Name = {
    Text = "Cerimônia Final II"
  },
  Event_7148_ChoiceDesc1 = {
    Text = "[continuar procurando] Aumentar Arg1 ponto de vida, infectar[(Skill.Arg2)]"
  },
  Event_7148_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7148_Desc = {
    Text = "Seu nariz sentiu um cheiro familiar, caseiro e satisfatório. Quando você tentou cheirar novamente, o aroma desapareceu completamente"
  },
  Event_7148_Name = {
    Text = "Contato Anômalo"
  },
  Event_7149_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7149_Desc = {
    Text = "Eles são cores calorosas.\nVibrantes, gentis, amorosas.\nEles deram à garota um abraço nostálgico e desapareceram como o vento"
  },
  Event_7149_Name = {
    Text = "Cores Nostálgicas"
  },
  Event_7150_ChoiceDesc1 = {
    Text = "[Quem é você, realmente?]"
  },
  Event_7150_ChoiceDesc2 = {
    Text = "[Como Mudar Sua Mentalidade?]"
  },
  Event_7150_Desc = {
    Text = "O homem de cabelos longos bloqueou novamente o caminho de vocês. Com a experiência da última vez, Ramona parecia estar de mau humor. \n \"Calma, meu amigo.\" O homem começou a falar lentamente, sua voz era magnética e sedutora, como se o som estivesse passando por um canal estreito, misturado com um sussurro de fricção. \n \"Eu já estou observando há algum tempo, mudar de pensamento é a chave para se aproximar do objetivo.\""
  },
  Event_7150_Name = {
    Text = "Companheiro Estranho III"
  },
  Event_7151_ChoiceDesc1 = {
    Text = "[Estou Procurando] Aumente a saúde máxima em Arg1"
  },
  Event_7151_ChoiceDesc2 = {
    Text = "[Estou Esquivando] Escolha 1 de 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7151_Desc = {
    Text = "\"Eu vejo alguém procurando, buscando pelo inatingível, aquela coisa triste e relativa, aquilo que é chamado de verdade.\nEu vejo alguém evitando, esquivando do inevitável, aquela coisa cruel e oculta, aquilo que é chamado de verdade.\nQual deles você é?\""
  },
  Event_7151_Name = {
    Text = "Objeto de perseguição"
  },
  Event_7152_ChoiceDesc1 = {
    Text = "[Examinar cuidadosamente] atualizar 1 relíquia de prata para relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_7152_ChoiceDesc2 = {
    Text = "[Tentar Ouvir] Ganhar Relíquia de Ouro \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\", e \"(Skill.Arg3)\""
  },
  Event_7152_ChoiceDesc3 = {
    Text = "[Store Carefully] Ganhar 25 Sigilos Negros"
  },
  Event_7152_Desc = {
    Text = "À frente, a névoa é iluminada por algo pequeno, parecendo fragmentos de vidro ou cristal, com cores vibrantes e opacas"
  },
  Event_7152_Name = {
    Text = "Nossas Memórias"
  },
  Event_7153_ChoiceDesc1 = {
    Text = "[Aceitar Desafio] Vença para obter uma relíquia de prata, perca para ganhar um sintoma. O resultado não afeta investigações futuras."
  },
  Event_7153_ChoiceDesc2 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7153_Desc = {
    Text = "Quem é a pessoa no reflexo?\nEla respira e tem o mesmo ritmo cardíaco que você, compartilhando a mesma ideia estranha.\nÉ uma brincadeira do domínio ou uma sombra de outra dimensão?\nParece um desafio ilusório?"
  },
  Event_7153_Name = {
    Text = "Resonância de almas"
  },
  Event_7154_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7154_Desc = {
    Text = "A visão transcende a história e o tempo, talvez seja não linear, talvez esteja te observando desde o caos antes do nascimento do planeta.\nOu talvez, esteja te esperando em algum dia no futuro"
  },
  Event_7154_Name = {Text = "Espiar"},
  Event_7155_ChoiceDesc1 = {
    Text = "[Claim] Ganhar 50 sigilos negros"
  },
  Event_7155_Desc = {
    Text = "Ali não há nada, o líquido negro flui pelo chão, não refletindo nada.\nÉ uma ilusão sua? Você sente algo escapando pelos dedos"
  },
  Event_7155_Name = {
    Text = "Sob a superfície do espelho"
  },
  Event_7156_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7156_Desc = {
    Text = "\"Você é realmente uma boa pessoa generosa, desejo que você consiga tudo o que deseja hoje, amanhã e depois de amanhã.\"\n\"A propósito, aqui é um negócio único...\"\nA fada satisfeita estalou os lábios, despedindo-se de você com relutância."
  },
  Event_7156_Name = {
    Text = "Bênção da Fada"
  },
  Event_7157_ChoiceDesc1 = {
    Text = "[Devolva Minha Carteira!] Ganhe 1 de 3 Oração escolhidas"
  },
  Event_7157_ChoiceDesc2 = {
    Text = "[Hesitar] 1 Carta de comando aleatória obtém Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7157_Desc = {
    Text = "\n\"Anda logo, venha e recupere sua carteira!\" Uma criança distante acenou com a mão.\nVocê correu para frente e, ao estender a mão, um barulho súbito e caótico ecoou em sua mente.\n\"De onde veio esse garoto sujo?\"\n\"É um ratinho de rua! Como ele se atreve a tocar no vestido da Duquesa!\"\n\"Levem-no daqui!\"\n\"Você tem algumas moedas? Sem moedas, não pense que pode levar nem um pedaço de pão preto!\""
  },
  Event_7157_Name = {
    Text = "Livro do Nada"
  },
  Event_7158_ChoiceDesc1 = {
    Text = "[Seguir a Canção] escolhe uma entre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_7158_ChoiceDesc2 = {
    Text = "[Cante em harmonia] Infectar [(Skill.Arg1)], re-imprintar, no máximo 2 vezes"
  },
  Event_7158_Desc = {
    Text = "A canção distante se fragmenta em estrelas:\n\"Eu amaldiçoo a poça suja no beco noturno, flores podres adornam a base da parede em ruínas, correntes se prendem ao cérebro e afundam no lodo, antes que o nevoeiro apague minha existência, o crepúsculo afundará no mais profundo @2.\""
  },
  Event_7158_Name = {
    Text = "Maldição da Matéria Branca"
  },
  Event_7159_ChoiceDesc1 = {
    Text = "[Deixar a Manutenção] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7159_ChoiceDesc2 = {
    Text = "[Levá-lO embora] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7159_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7159_Desc = {
    Text = "Quando você se aproxima, almas caóticas e desordenadas emergem abruptamente do pântano.  \nOs membros negros se entrelaçam com força ao seu redor, chorando e suplicando—  \nofereça um sacrifício, ou leve-o embora"
  },
  Event_7159_Name = {
    Text = "Espírito do Caos"
  },
  Event_7160_ChoiceDesc1 = {
    Text = "[Leave an Offering] Melhore aleatoriamente a qualidade da Oração de 1 Cartão"
  },
  Event_7160_ChoiceDesc2 = {
    Text = "[Levá-lo Embora] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7160_Desc = {
    Text = "Quando você se aproxima, almas caóticas e desordenadas emergem abruptamente do pântano.  \nOs membros negros se entrelaçam com força ao seu redor, chorando e suplicando—  \nofereça um sacrifício, ou leve-o embora"
  },
  Event_7160_Name = {
    Text = "Espírito do Caos"
  },
  Event_7161_ChoiceDesc1 = {
    Text = "[Acenar para Afastar] 1 Carta de comando aleatória obtém Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7161_ChoiceDesc2 = {
    Text = "[Deixar passar] escolher 1 entre 3 cartas de comando para obter uma oração:[(EnchantConfig.Arg1)]"
  },
  Event_7161_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7161_Desc = {
    Text = "As asas da borboleta arrastam um líquido negro, voando instavelmente, o líquido se solidifica e se desfaz ao vento.\nCansada, ela pousa na ponta do seu nariz"
  },
  Event_7161_Name = {
    Text = "Borboleta de Líquido Preto"
  },
  Event_7162_ChoiceDesc1 = {
    Text = "[Acenar para Afastar] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7162_ChoiceDesc2 = {
    Text = "[Let It Stay] Ganhe Relíquia de Prata \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7162_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7162_Desc = {
    Text = "As asas da borboleta arrastam um líquido negro, voando instavelmente, o líquido se solidifica e se desfaz ao vento.\nCansada, ela pousa na ponta do seu nariz"
  },
  Event_7162_Name = {
    Text = "Borboleta de Líquido Preto"
  },
  Event_7163_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7163_Desc = {
    Text = "\"Eu vejo coragem, força de vontade e um espírito brilhando como as estrelas. Avance para aquela memória selada com cera, e seu desejo será realizado.\""
  },
  Event_7163_Name = {
    Text = "Objeto de perseguição"
  },
  Event_7164_ChoiceDesc1 = {
    Text = "[Deixar Ficar] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7164_ChoiceDesc2 = {
    Text = "[Waving Away] Obtenha a Relíquia Prata \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7164_ChoiceDesc3 = {
    Text = "[Welcome the Butterflies] Ganhe 25 sigilos negros"
  },
  Event_7164_Desc = {
    Text = "Vocês vagam pelo sanatório frio, uma borboleta negra, fora de estação, voa até vocês.\nSuas asas estão cobertas de líquido negro, que se solidifica e se desfaz ao vento.\nEla pousa em seu dedo, exausta"
  },
  Event_7164_Name = {
    Text = "Algo que não deveria existir"
  },
  Event_7165_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para relíquia de prata, infecção de[(Skill.Arg1)]"
  },
  Event_7165_Desc = {
    Text = "Você começa a se sentir cansado.\nSua consciência o leva, além do lago, além das montanhas,\nvoando além do sol, além dos anos-luz,\nvoando para o único... berço do universo"
  },
  Event_7165_Name = {
    Text = "Cerimônia Final IV"
  },
  Event_7166_ChoiceDesc1 = {
    Text = "[Look More]"
  },
  Event_7166_Desc = {
    Text = "Uma sombra maciça o envolve completamente, e a saliva de mau cheiro o molha como um rato afogado.\n\"Rato pequeno, venha aqui. Apenas por um momento...\"\n\"Juro, não tenho intenção de comer você...\"\n\"Eu nem olharei para sua barriga, gordinha e suculenta!\""
  },
  Event_7166_Name = {
    Text = "Material No. 12"
  },
  Event_7167_ChoiceDesc1 = {
    Text = "[Look More]"
  },
  Event_7167_Desc = {
    Text = "A escultura de cera murcha do filósofo fuma, envolto em uma névoa branca.\n\"A outra margem existe, mas é incognoscível, assim permanece desconhecida.\"\n\"Imagine este mundo como um jogo...\nO que você está procurando pode estar do outro lado do mapa.\""
  },
  Event_7167_Name = {
    Text = "Material No. 45"
  },
  Event_7168_ChoiceDesc1 = {
    Text = "[Look More]"
  },
  Event_7168_Desc = {
    Text = "\"Desculpe, não era minha intenção...\"\n\"Eu não gosto de ratos. O problema dos ratos é que eles nunca têm medo dos humanos...\"\nUm velho de barba desgrenhada está deitado no canto, seus olhos melancólicos fixos em você.\n\"Claro, vocês são muito ambiciosos.\nIsso é bom, mas ainda não é suficiente para ajudá-los a escapar da catástrofe...\""
  },
  Event_7168_Name = {Text = "Material 4"},
  Event_7169_ChoiceDesc1 = {
    Text = "[Mostrar a maldição] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7169_ChoiceDesc2 = {
    Text = "[Reject the Crow] Obtenha uma Oração com 3 escolhas"
  },
  Event_7169_ChoiceDesc3 = {Text = "[Ignorar]"},
  Event_7169_Desc = {
    Text = "Uma ave de corvo multicefálica, negra e doentia, sai da túnica de um crente da Luz do Templo e pousa em seu ombro.\n\"Você vê minha cabeça? Enquanto eu provar a maldição, crescendo uma nova cabeça. Deixe-me ver, sua maldição!\""
  },
  Event_7169_Name = {
    Text = "Corvo Amaldiçoado"
  },
  Event_7170_ChoiceDesc1 = {
    Text = "[Responder a Chamada] Remove 1 Carta de Comando e restaura Arg1 Vida"
  },
  Event_7170_ChoiceDesc2 = {
    Text = "[I'm Not Fleeing] Ganhe Relíquia de Ouro \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\""
  },
  Event_7170_Desc = {
    Text = "Você corre rapidamente por um beco. A adrenalina é estimulada, o ácido lático se forma, a glicose é consumida... O caos corrói seu cérebro, ocupando seu pensamento, enquanto a ilusão colorida o apressa a fugir em direção ao fim. \n Sim, fuga. Se você realmente não está fugindo, então o que espera por você é o caos e o nada, a falta de resultados e um desfecho sem sentido, não é?"
  },
  Event_7170_Name = {Text = "Correr"},
  Event_7171_ChoiceDesc1 = {
    Text = "[Rastrear Fonte de Som]"
  },
  Event_7171_ChoiceDesc2 = {
    Text = "[Summon Lily and Koum]"
  },
  Event_7171_Desc = {
    Text = "Do longe da passagem dimensional, chega um som rouco e profundo, misturado com medo, esperança e inquietação, como se estivesse chamando vocês. Em seguida, as vozes suaves de uma menina se tornaram indistintas, e logo ambos os sons diminuíram"
  },
  Event_7171_Name = {
    Text = "Voz do guia"
  },
  Event_7172_ChoiceDesc1 = {Text = "[Pocketed]"},
  Event_7172_Desc = {
    Text = "Uma substância prateada, quase mercurial, extraída de uma mucosa de dissolução, contém grande poder espiritual, utilizada principalmente para vincular mais despertadores em rituais"
  },
  Event_7172_Name = {
    Text = "Núcleo de prata"
  },
  Event_7173_ChoiceDesc1 = {
    Text = "[Ask to Clear the Path]"
  },
  Event_7173_ChoiceDesc2 = {
    Text = "[Ask for Identity]"
  },
  Event_7173_Desc = {
    Text = "Vocês entram em um vagão escuro, uma sensação estranha surge em seus corações.\nEste vagão está vazio, os passageiros já fugiram, e no chão estão espalhados restos do corpo de um monstro, que estão se dissipando gradualmente.\nNo centro do vagão, está aquele homem.\n\"Acredito que existe um destino no mundo, e é esse destino que nos fez pegar o mesmo metrô.\""
  },
  Event_7173_Name = {
    Text = "Companheiro Estranho IV"
  },
  Event_7174_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7174_Desc = {
    Text = "\"Seus olhos são tão bonitos, como estrelas.\"\nCharlotte riu suavemente, seus cabelos loucos caindo de maneira suave. \n\"Você deve ser muito popular na escola, eu também gosto de você.\"\nAntes de ir, ela deu um beijo na sua testa. \nVocê sente seu corpo aquecido, como se algo tivesse mudado."
  },
  Event_7174_Name = {
    Text = "Sombra do Investigador"
  },
  Event_7175_ChoiceDesc1 = {
    Text = "[Ler] escolhe uma entre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_7175_ChoiceDesc2 = {
    Text = "[Store in Suitcase] Infecte \"(Skill.Arg1)\", ganhe Relíquia: \"(RelicConfig.Arg2)\""
  },
  Event_7175_Desc = {
    Text = "Uma página amarelada caiu do capuz dos crentes que iluminam o templo.  \nA página estava repleta de textos esquisitos em formas peculiares, alguns parecendo hieróglifos, outros estranhamente levantados, algumas letras se sobrepondo, apenas poucas legíveis"
  },
  Event_7175_Name = {
    Text = "Ordem secreta · Parte superior"
  },
  Event_7176_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7176_Desc = {
    Text = "Você disse: \"Ah, Charlotte! Não!\"\nO cabelo de Charlotte se agitou freneticamente, ela ficou brava.\n\"Eu vou provar para você! Veja o que eu posso fazer!\""
  },
  Event_7176_Name = {
    Text = "Sombra do Investigador"
  },
  Event_7177_ChoiceDesc1 = {
    Text = "[Infect with \"(Skill.Arg1)\" and obtain the Silver Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7177_ChoiceDesc2 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7177_Desc = {
    Text = "Evento 302 (em desenvolvimento), não é o efeito final"
  },
  Event_7177_Name = {
    Text = "Evento 302 (em desenvolvimento)"
  },
  Event_7178_ChoiceDesc1 = {
    Text = "[Accept Request] Infeccione com \"(Skill.Arg1)\", obtenha Relíquia de Prata \"(RelicConfig.Arg2)\""
  },
  Event_7178_ChoiceDesc2 = {
    Text = "[Refuse Request] Ganhe 25 Sigilos Negros"
  },
  Event_7178_Desc = {
    Text = "A mandíbula estala, emitindo um som com um certo ritmo, e seu companheiro entende um pouco sobre criptografia. \n O texto decifrado é o seguinte: \n \"Olá, por favor, me chame de Dr. @2. Eu fui um colecionador, naturalista... \n (aqui há uma longa e tediosa introdução sobre carreira e títulos, omitida) \n Em resumo, você pode me ajudar a encontrar minha outra metade? É um pequeno osso maxilar. \n Assim que encontrá-lo, meu tesouro pessoal se abrirá para você.\""
  },
  Event_7178_Name = {Text = "Crujido"},
  Event_7179_ChoiceDesc1 = {
    Text = "[Invest 100 Fang] Infectar \"(Skill.Arg1)\", ganhar Relíquia de Prata \"(RelicConfig.Arg2)\""
  },
  Event_7179_ChoiceDesc2 = {
    Text = "[Investir Cinco Pensh] Ganhe 25 Sigilos Negros."
  },
  Event_7179_Desc = {
    Text = "A bolsa bordada se contorce e abre uma boca negra.\nDesde que deixou sua rica dona, está faminta há décadas.\nVocê olha dentro da bolsa, mas só vê escuridão"
  },
  Event_7179_Name = {
    Text = "Carteira gulosa"
  },
  Event_7180_ChoiceDesc1 = {
    Text = "[Steadfast Determination] Remova 1 cartão de comando e restaure Arg1 Vida"
  },
  Event_7180_ChoiceDesc2 = {
    Text = "[Desejo de Sucesso] Obter relíquia de ouro \"(RelicConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7180_Desc = {
    Text = "\"Dois caras teimosos, a Casa de pobres já está muito perigosa,\" a voz de Doll de repente veio do comunicador, \"qual é o seu próximo passo, vão ajudar a costurar a cabeça dela?\"\n\"Não é hora para piadas, Doll!\"\n\"Eu sei, eu consigo ouvir.\" Doll disse, \"calma, você sabe qual é a chave para o sucesso?\""
  },
  Event_7180_Name = {
    Text = "Regra de Logan"
  },
  Event_7181_ChoiceDesc1 = {
    Text = "[Infect with \"(Skill.Arg1)\" and obtain the Silver Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7181_ChoiceDesc2 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7181_Desc = {
    Text = "Evento 304 (em desenvolvimento), não é o efeito final"
  },
  Event_7181_Name = {
    Text = "Evento 304 (em desenvolvimento)"
  },
  Event_7182_ChoiceDesc1 = {
    Text = "[Infect with \"(Skill.Arg1)\" and obtain the Silver Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7182_ChoiceDesc2 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7182_Desc = {
    Text = "Evento 305 (em desenvolvimento), não é o efeito final"
  },
  Event_7182_Name = {
    Text = "Evento 305 (em desenvolvimento)"
  },
  Event_7183_ChoiceDesc1 = {
    Text = "[Desligar o Receptor] Obtenha uma Oração Avançada com 3 opções"
  },
  Event_7183_ChoiceDesc2 = {
    Text = "[Atender o Telefone] Obtenha Relíquia de Ouro \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7183_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7183_Desc = {
    Text = "Vocês passam pela sala de descanso do condutor, e o telefone toca estridentemente em um canto escondido"
  },
  Event_7183_Name = {
    Text = "Ligação do trem"
  },
  Event_7184_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7184_Desc = {
    Text = "A luz é opaca, mas realmente existe. \n Um núcleo de prata tão opaco é difícil de invocar um Corpo Desperto, mas é ótimo para reforço — é isso que se chama Tecnologia Silvercore."
  },
  Event_7184_Name = {
    Text = "Prova de Existência"
  },
  Event_7185_ChoiceDesc1 = {
    Text = "[Lady's Portrait] Melhore aleatoriamente a qualidade da oração de 1 carta."
  },
  Event_7185_ChoiceDesc2 = {
    Text = "[Foto de Família de estátuas de cera] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7185_Desc = {
    Text = "O museu de cera também exibe várias pinturas.\nRetratos, paisagens, naturezas-mortas, realistas, abstratas...\nElas decoram as paredes monótonas, tornando-as menos entediantes.\nUm deles chama sua atenção, é uma pintura de—"
  },
  Event_7185_Name = {
    Text = "Galeria de Retratos"
  },
  Event_7186_ChoiceDesc1 = {
    Text = "[Continuar Folheando] 1 carta de comando aleatória ganha oração:[(EnchantConfig.Arg1)]"
  },
  Event_7186_ChoiceDesc2 = {
    Text = "[Sair] aumenta Arg1 pontos de saúde máxima, infecção de[(Skill.Arg2)]"
  },
  Event_7186_Desc = {
    Text = "Uma balança para pesar.\nAtrás dela, inúmeros órgãos estão mergulhados em formalina vermelha.\nEstão organizados em prateleiras de armazenamento.\nVocê pega casualmente um caderno próximo e folheia:\n\"Coração: 8 oz, Cérebro: 50 oz...\""
  },
  Event_7186_Name = {
    Text = "Registro de órgãos"
  },
  Event_7187_ChoiceDesc1 = {
    Text = "[Open Gift] Receba um cartão especial"
  },
  Event_7187_Desc = {
    Text = "A imagem da criança passou rapidamente diante de você, e você não consegue distinguir se era uma verdadeira criança ou a projeção de algum espírito no domínio. Mas - você olha para a caixa deixada no chão, com \"presente\" escrito em letras infantis"
  },
  Event_7187_Name = {
    Text = "Presente Gentil"
  },
  Event_7188_ChoiceDesc1 = {
    Text = "[Chame os corvos] ganha 40 sigilos negros, infecta[(Skill.Arg2)], continua a escolha"
  },
  Event_7188_ChoiceDesc2 = {
    Text = "[Stay Far Away] Ganhe 25 sigilos negros"
  },
  Event_7188_Desc = {
    Text = "Uma gaivota branca pousou no mastro, coberto de geada.\nOs apitos ressoaram juntos, repelindo a presença negra e os pássaros que não pertencem ao mar"
  },
  Event_7188_Name = {
    Text = "Corvo Solitário"
  },
  Event_7189_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7189_Desc = {
    Text = "Você reconhece que aquela canção é uma adaptação de uma balada. \n No final daquela balada, o poeta diz: \n \"Até que a voz humana nos desperte, morreremos afogados.\" \n Não agora. Você pensa. \n Você ainda está esperando que a humanidade o desperte."
  },
  Event_7189_Name = {
    Text = "Voz da matilha de corvos"
  },
  Event_7190_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7190_Desc = {
    Text = "Um rolo de filme coberto de poeira. Mas não há projetor na sala, e não é hora de desfrutar da mansão, do filme e do chá da tarde.\nTalvez demore muito até que você tenha a chance de ver o conteúdo do filme"
  },
  Event_7190_Name = {
    Text = "Lembranças luminosas"
  },
  Event_7191_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para oração avançada, infecção de[(Skill.Arg1)]"
  },
  Event_7191_Desc = {
    Text = "Você segue o garoto a uma distância segura. \nToc. Toc. Toc... O garoto para na esquina. \nVocê vê uma luz vermelha tremeluzente atrás dele, e seu instinto diz que o museu de cera está próximo. \nO garoto se vira. Ele não tem olhos, apenas órbitas escuras. \nEle sorri para você"
  },
  Event_7191_Name = {
    Text = "Cerimônia Final I"
  },
  Event_7192_ChoiceDesc1 = {
    Text = "[Sair] ganha 50 o sigilo negro, infecção de[(Skill.Arg1)]"
  },
  Event_7192_Desc = {
    Text = "Você deu um tapinha em seu ombro. \n O garoto se virou, ele não tinha olhos, apenas órbitas escuras. \n \"Boa noite. Estou procurando o caminho para o museu de cera.\" \n O garoto apontou para a frente. Você viu uma luz vermelha instável atrás dele. \n Seu instinto dizia que o museu de cera estava ali. \n Quando você voltou a si, o garoto já havia partido, deixando apenas a sombra alongada do poste de luz."
  },
  Event_7192_Name = {
    Text = "Cerimônia Final I"
  },
  Event_7193_ChoiceDesc1 = {
    Text = "[Aperte o Corvo] ganhe 35 o sigilo negro, contamine[(Skill.Arg2)], continue a escolher"
  },
  Event_7193_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Saia"
  },
  Event_7193_Desc = {
    Text = "O corvo solitário, com uma voz rouca, arranca suas penas negras uma a uma.\nEle treme de dor, gritando agudamente, mas não pode parar seu ritmo cada vez mais frenético.\n\"Caw—Caw—\"\nLágrimas azuis misturadas com uma gosma negra escorrem de seus olhos, testemunhadas apenas por você."
  },
  Event_7193_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7194_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7194_Desc = {
    Text = "Conhecimento inestimável inundou sua mente, depois se transformou em névoa... Quando você acordou, o estranho livro de capa amarela havia desaparecido"
  },
  Event_7194_Name = {
    Text = "Pergaminho amarelo"
  },
  Event_7195_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7195_Desc = {
    Text = "Você derrubou facilmente essas estátuas de cera. Elas estão com a cabeça baixa, caídas na sua frente. \n A parte inferior das estátuas parece ter algumas linhas escritas. \n \"Aluvião @2 ano 11 \n Feito por Rogers na @2 Academia\" \n Você se lembra que Rogers estudou escultura em uma certa academia de artes, essas desajeitadas estátuas de cera devem ser seus estudos daquela época."
  },
  Event_7195_Name = {Text = "Estudo"},
  Event_7196_ChoiceDesc1 = {
    Text = "[Por quê?]"
  },
  Event_7196_ChoiceDesc2 = {
    Text = "[Descend into Aequor]"
  },
  Event_7196_Desc = {
    Text = "\"Impostora! Devolva meu filho!\"\n\"Você não é a santa do navio? Sua responsabilidade não é proteger os navios? Por que apenas um barco voltou, diga, diga!\"\n\"Afoguem-na! Ela deve sofrer como meu pai sofreu antes de morrer!\"\n\"Afoguem-na, afoguem-na!\"\n\"Afoguem essa impostora! Amarre-a a uma pedra!\"\nQuando a água do mar invadiu seu nariz e boca, e o ar foi espremido de cada canto de seus pulmões, ela também estava vestindo aquele vestido branco nobre e puro.\nQuase como o primeiro pensamento após se tornar santa, surgiu do canto mais escuro de sua mente, chegando tarde.\n\"Sim, por que aqueles barcos afundaram?\""
  },
  Event_7196_Name = {
    Text = "Afundar-se no mar"
  },
  Event_7197_ChoiceDesc1 = {
    Text = "[Aperte o Corvo] ganhe 30 o sigilo negro, contamine[(Skill.Arg2)], continue a escolher"
  },
  Event_7197_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Saia"
  },
  Event_7197_Desc = {
    Text = "O corvo solitário, com uma voz rouca, arranca suas penas negras uma a uma.\nEle treme de dor, gritando agudamente, mas não pode parar seu ritmo cada vez mais frenético.\n\"Caw—Caw—\"\nLágrimas azuis misturadas com uma gosma negra escorrem de seus olhos, testemunhadas apenas por você."
  },
  Event_7197_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7198_ChoiceDesc1 = {
    Text = "[continuar procurando] Aumentar Arg1 ponto de vida, infectar[(Skill.Arg2)]"
  },
  Event_7198_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7198_Desc = {
    Text = "Parece que uma mão firme e forte tocou seu ombro, mas quando você se virou para procurar, a sensação desapareceu"
  },
  Event_7198_Name = {
    Text = "Contato Anômalo"
  },
  Event_7199_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7199_Desc = {
    Text = "A ponte ferroviária Ryelway, os vasos e nervos de Londinium, conectando o coração e os membros da cidade. O Sanatório Rye está situado tranquilamente no extremo dos membros, esperando pela transmissão de sangue e sinais."
  },
  Event_7199_Name = {
    Text = "Ilusão Ferroviária"
  },
  Event_7200_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7200_Desc = {
    Text = "Você colocou a mala no chão e a pisou várias vezes, certificando-se de que não tremia mais antes de pegá-la novamente.\nVocê limpou a poeira enquanto Murphy olhava confusa, e vocês continuaram"
  },
  Event_7200_Name = {
    Text = "Carta inesperada"
  },
  Event_7201_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7201_Desc = {
    Text = "O perigo espreita por trás de uma porta de madeira, não é hora de perder tempo. Coloque-o na maleta"
  },
  Event_7201_Name = {
    Text = "Pergaminho amarelo"
  },
  Event_7202_ChoiceDesc1 = {
    Text = "[Afastar corvos] Obtenha Arg1 sigilo negro, infectar [(Skill.Arg2)], continue a escolher"
  },
  Event_7202_ChoiceDesc2 = {
    Text = "[Ignorar] Saia"
  },
  Event_7202_Desc = {
    Text = "Ele, ou eles, giram no quarto, batendo na lâmpada"
  },
  Event_7202_Name = {
    Text = "Lanterna Corvo Preto"
  },
  Event_7203_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7203_Desc = {
    Text = "Aqui é a dimensão espiritual, o mundo do conhecimento.\nEles só podem confundir sua mente"
  },
  Event_7203_Name = {
    Text = "Tempestade de Conhecimento"
  },
  Event_7204_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7204_Desc = {
    Text = "Crânio: Hank Tillinghast A.F.186-A.F.203 Ilha Creole\nEspinha: Andy Crawford A.F.177-A.F.203 Narragansett\n... Melhor não pensar muito"
  },
  Event_7204_Name = {Text = "Placa"},
  Event_7205_ChoiceDesc1 = {
    Text = "[Check Fragment] Desenhe aleatoriamente 3 cartões de comando do baralho, delete 1 cartão e ganhe 75 Sigilos Negros."
  },
  Event_7205_ChoiceDesc2 = {
    Text = "[Ask the Doll] Obtenha 3 cartões de comando aleatórios do baralho, escolha 1 cartão original para adicionar ao baralho e ganhe 25 sigilos negros."
  },
  Event_7205_ChoiceDesc3 = {
    Text = "[Desconsiderar] Ganhar 50 Sigilos Negros"
  },
  Event_7205_Desc = {
    Text = "Os fragmentos metálicos que boneca deu a você se agitavam inquietos em seu peito, como uma borboleta assustada"
  },
  Event_7205_Name = {
    Text = "Broche Inquieto"
  },
  Event_7206_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7206_Desc = {
    Text = "\"Ele espera quieto na linha de chegada, não importa onde você defina o ponto final—veja aquela jovem guardiã; sua evasão acaba levando à loucura.\""
  },
  Event_7206_Name = {
    Text = "Objeto de perseguição"
  },
  Event_7207_ChoiceDesc1 = {
    Text = "[Leave] Nada encontrado"
  },
  Event_7207_Desc = {
    Text = "Em desenvolvimento, evento especial"
  },
  Event_7207_Name = {
    Text = "2_16 Temporário"
  },
  Event_7208_ChoiceDesc1 = {
    Text = "[Comfort It] Aumentar a vida máxima em Arg1"
  },
  Event_7208_ChoiceDesc2 = {
    Text = "[Desconsiderá-lo] 2 Cartas de comando aleatórias obtêm Gravura: \"(EnchantConfig.Arg1)\", infectar 2 \"(Skill.Arg2)\""
  },
  Event_7208_Desc = {
    Text = "O link aquece o órgão ainda humano do coração.\nEle imita o ritmo da respiração do link, pulsando, como se assim não fosse deixado para trás, como se tivesse o direito de acompanhar o link para sempre"
  },
  Event_7208_Name = {
    Text = "Atrium esquerdo"
  },
  Event_7209_ChoiceDesc1 = {
    Text = "Impressão avançada aleatória"
  },
  Event_7210_ChoiceDesc1 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7210_Desc = {
    Text = "Sua frieza deixa o dono da voz desapontado, a água ondula levemente e depois se acalma"
  },
  Event_7210_Name = {
    Text = "Voz fora do mundo"
  },
  Event_7211_ChoiceDesc1 = {
    Text = "[Escolher uma Carta e Ganhar Oração：\"(EnchantConfig.Arg1)\"]teste de oração"
  },
  Event_7211_ChoiceDesc2 = {
    Text = "[Escolher uma Carta e Ganhar Oração：\"(EnchantConfig.Arg1)\"]teste de pacote de queda"
  },
  Event_7211_Desc = {
    Text = "Teste de marcação designada"
  },
  Event_7211_Name = {
    Text = "Teste de marca designada 1"
  },
  Event_7212_ChoiceDesc1 = {
    Text = "[Leave] Escolha despertar 1 Despertador"
  },
  Event_7212_Desc = {
    Text = "Você gentilmente acariciou a cabeça do menino, guiando-o a recitar junto com você.\n\"Uma Canção para Mamãe—\"\nAs vozes, como traças na noite, flutuavam lado a lado do palco vazio,\naterrissando suavemente na audiência completamente escura."
  },
  Event_7212_Name = {
    Text = "Cerimônia Final III"
  },
  Event_7213_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para relíquia de ouro, infecção de[(Skill.Arg1)]"
  },
  Event_7213_Desc = {
    Text = "Você permanece impassível. Uma dama aparece de repente no palco.\nEla abre a boca do garoto com força e enfia um bastão de madeira. \n\"Fale, fale para mim.\" \nSangue negro flui da boca do garoto. Ele murmura algo de forma confusa.\n\"Uma canção para mãe...\""
  },
  Event_7213_Name = {
    Text = "Cerimônia Final III"
  },
  Event_7215_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7215_Desc = {
    Text = "Isso não é uma janela, é um espelho. O reflexo mostra o rosto tenso de Ramona.\nPor que não há janelas neste quarto, apenas um grande espelho na parede?"
  },
  Event_7215_Name = {
    Text = "Reflexo na janela"
  },
  Event_7216_ChoiceDesc1 = {
    Text = "[Segurar Chave de Prata] Despertar 1 corpo adormecido aleatório, Infectar[(Skill.Arg1)]"
  },
  Event_7216_ChoiceDesc2 = {
    Text = "[Fechar os Olhos] escolhe uma entre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_7216_Desc = {
    Text = "Você é rasgado por uma onda colossal de absurdo, seus membros se contorcem enquanto rastejam pelo chão, como se fossem manipulados por @2 de além das dimensões. \n \"Não... não...\" \n Sua sanidade desmorona a cada momento, risos maníacos e gritos confusos se entrelaçam, como uma grande rede que aprisiona sua consciência, e o que transborda de seus lábios é apenas um lamento indistinto."
  },
  Event_7216_Name = {
    Text = "Olho do olhar"
  },
  Event_7217_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7217_Desc = {
    Text = "A cor da galáxia muda sob seus pés, desenhando padrões indescritíveis, belos como rubis, mas inchados como águas-vivas. A maleta brilha em vermelho"
  },
  Event_7217_Name = {
    Text = "Cruzamento Estelar"
  },
  Event_7218_ChoiceDesc1 = {
    Text = "[Dissipar a Ilusão] Estresse +10."
  },
  Event_7218_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7218_Desc = {
    Text = "Rostos borrados aparecem de repente, gemendo desesperadamente ao seu redor"
  },
  Event_7218_Name = {Text = "Ilusão"},
  Event_7221_ChoiceDesc1 = {
    Text = "[pegar] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_7221_ChoiceDesc2 = {
    Text = "[Olhar para baixo] obter 75 sigilos negros, infecção[(Skill.Arg2)]"
  },
  Event_7221_Desc = {
    Text = "Os corvos circulam no céu cortado em blocos pela viela, emitindo um chamado rouco que provoca inquietação. \n O bando de corvos de repente se agita, como se uma natureza doentia tivesse sido distorcida ou despertada, atacando-se e perseguindo-se de maneira impaciente e feroz, algo cai no meio da luta."
  },
  Event_7221_Name = {
    Text = "Enxame de corvos agitados"
  },
  Event_7222_ChoiceDesc1 = {
    Text = "[Seguir as Instruções] Aumente a Vida de Arg1"
  },
  Event_7222_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7222_Desc = {
    Text = "Você tentou usar o poder de retrocesso da chave de prata para encontrar o ponto de junção mais próximo, mas as informações que obteve estavam misturadas com anomalias difíceis de perceber, como se estivesse sendo interferido"
  },
  Event_7222_Name = {
    Text = "Contato Anômalo"
  },
  Event_7223_ChoiceDesc1 = {
    Text = "[Deixar com Doarl] aleatoriamente 1 carta de comando para obter uma oração:[(EnchantConfig.Arg1)]"
  },
  Event_7223_ChoiceDesc2 = {
    Text = "[Ler a Placa Comemorativa] aumenta Arg1 pontos de saúde máxima, infecta[(Skill.Arg2)]"
  },
  Event_7223_Desc = {
    Text = "Do corpo do experimento da Associação dos Escultores que você derrotou, caiu uma placa de metal. A chave de prata reagiu à placa, brilhando levemente"
  },
  Event_7223_Name = {Text = "Placa"},
  Event_7224_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7224_Desc = {
    Text = "O portador da lâmina emitiu um grito longo, como um som colossal capaz de cortar montanhas e mares.\nA voz passou em um instante, junto com os outros dois Marchadores de mares desaparecendo… na verdade, foi apenas uma ilusão refletida pelo Domínio."
  },
  Event_7224_Name = {
    Text = "Perseguir incansavelmente"
  },
  Event_7225_ChoiceDesc1 = {
    Text = "[Repair Wax Sculpture] Escolha um cartão e reduza seu custo de Aritmética em 1"
  },
  Event_7225_Desc = {
    Text = "Você segura uma vela, atravessa a névoa e chega diante dela.\nÉ uma estátua de cera inacabada.\nSeu rosto delicado está dividido ao meio, uma metade sorrindo, a outra @1.\nTorne-se seu deus.\nDê-lhe beleza, dê-lhe lágrimas.\nEsculpa-a ou destrua-a"
  },
  Event_7225_Name = {
    Text = "Estátua de Cera Inacabada"
  },
  Event_7226_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7226_Desc = {
    Text = "\"Claro, eu testemunhei a extinção com meus próprios olhos.\" Você respondeu.\nSim, foi meramente a morte violenta de um pequeno rato, a podridão de um coração, e um buquê de íris imerso no funeral da noite."
  },
  Event_7226_Name = {
    Text = "Reino Esquecido dos Deuses"
  },
  Event_7227_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7227_Desc = {
    Text = "\"Reino Divino... morte... assuntos ilusórios... não sei o que conta como morte.\"  \nAs duas figuras riem suavemente, cercadas por fragmentos de luz branca cintilante.  \n\"Então agora, você testemunhará a verdadeira morte.\""
  },
  Event_7227_Name = {
    Text = "Reino Esquecido dos Deuses"
  },
  Event_7228_ChoiceDesc1 = {
    Text = "[Combine Pages] Obtenha Relíquia de Ouro \"(RelicConfig.Arg1)\", infectado com \"(Skill.Arg2)\""
  },
  Event_7228_ChoiceDesc2 = {
    Text = "[Ler] escolhe uma entre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_7228_ChoiceDesc3 = {
    Text = "[Descartar Isso] Ganhar 50 Sigilos Negros"
  },
  Event_7228_Desc = {
    Text = "Uma página amarelada caiu do capuz dos crentes que iluminam o templo.  \nA página estava repleta de textos estranhos e peculiares, alguns parecendo hieróglifos, outros estranhamente levantados, algumas letras se sobrepondo, apenas poucas legíveis.  \nO título era 《@2 O Nascimento do Filho》"
  },
  Event_7228_Name = {
    Text = "Ordem secreta · Parte inferior"
  },
  Event_7229_ChoiceDesc1 = {
    Text = "[Struggle] Obtenha Relíquia de Prata \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7229_ChoiceDesc2 = {
    Text = "[Afunde] Obtenha a Relíquia de Prata \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7229_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7229_Desc = {
    Text = "\"Estou em tanta dor, tanta dor...\"\n\"Por que eu? Por que eu tenho que suportar isso?\"\n\"Pai misericordioso, o que eu fiz de errado?\"\nTristeza, dor, raiva, frustração... As emoções dos \"pacientes\" pesam pesadamente sobre você. Apertando seu peito, você não consegue respirar."
  },
  Event_7229_Name = {Text = "Vício"},
  Event_7230_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7230_Desc = {
    Text = "A visão penetra a carne, deixando uma marca na retina do predecessor.\nNinguém pode escapar, assim como ninguém"
  },
  Event_7230_Name = {Text = "Espiar"},
  Event_7231_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7231_Desc = {
    Text = "Concentre-se, identifique a letra e então sinta as palavras caóticas atingirem sua mente.\nNão são palavras que humanos possam entender"
  },
  Event_7231_Name = {
    Text = "Canção do Mar"
  },
  Event_7232_ChoiceDesc1 = {
    Text = "[Submeter ao Julgamento] infecta[(Skill.Arg1)], vitória concede relíquia de ouro, falha concede 50 sigilo negro"
  },
  Event_7232_ChoiceDesc2 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7232_Desc = {
    Text = "Você viu alguns segredos na poça de lodo negro refletindo como um espelho.\nSeu reflexo é borrado nas bordas, envolto em uma névoa negra persistente, você sente uma familiaridade inexplicável, mas não consegue identificar o que é"
  },
  Event_7232_Name = {
    Text = "Sob a superfície do espelho"
  },
  Event_7233_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7233_Desc = {
    Text = "Você desprezou as cartas anônimas misteriosas e as queimou, transformando-as em cinzas"
  },
  Event_7233_Name = {
    Text = "Outra carta de pedido de socorro"
  },
  Event_7234_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7234_Desc = {
    Text = "Você examinou a carta, o selo estava coberto de um líquido pegajoso, parecia uma mistura de sangue e piche, com alguns fios de cabelo grudados"
  },
  Event_7234_Name = {
    Text = "Outra carta de pedido de socorro"
  },
  Event_7235_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7235_Desc = {
    Text = "Seguindo a direção das cartas caídas, você avista algo brilhante na esquina"
  },
  Event_7235_Name = {
    Text = "Outra carta de pedido de socorro"
  },
  Event_7236_ChoiceDesc1 = {
    Text = "[continuar procurando] Aumentar Arg1 ponto de vida, infectar[(Skill.Arg2)]"
  },
  Event_7236_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7236_Desc = {
    Text = "Uma luz tênue apareceu à frente, brilhante e quente, mas desapareceu quando você tentou segui-la"
  },
  Event_7236_Name = {
    Text = "Contato Anômalo"
  },
  Event_7237_ChoiceDesc1 = {
    Text = "[Leave] Todos os Despertadores recuperam Arg1 Aliemus"
  },
  Event_7237_Desc = {
    Text = "Você fechou os olhos de medo.\n\"Você levantou o véu...\nSegredo, você descobriu o segredo...\" \nO som formou um mar de ruído, o chão tremia violentamente com a ressonância terrível.\nVocê não aguentou mais e abriu os olhos de repente, mas não havia nada ao seu redor"
  },
  Event_7237_Name = {
    Text = "Cerimônia Final V"
  },
  Event_7238_ChoiceDesc1 = {
    Text = "[continuar procurando] Aumentar Arg1 ponto de vida, infectar[(Skill.Arg2)]"
  },
  Event_7238_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7238_Desc = {
    Text = "Seu nariz sentiu um cheiro familiar, caseiro e satisfatório. Quando você tentou cheirar novamente, o aroma desapareceu completamente"
  },
  Event_7238_Name = {
    Text = "Contato Anômalo"
  },
  Event_7239_ChoiceDesc1 = {
    Text = "[continuar procurando] Aumentar Arg1 ponto de vida, infectar[(Skill.Arg2)]"
  },
  Event_7239_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7239_Desc = {
    Text = "Palavras familiares chegam aos seus ouvidos, reconfortantes e tranquilizadoras, mas quando você tenta seguir o som, ele cessa abruptamente"
  },
  Event_7239_Name = {
    Text = "Contato Anômalo"
  },
  Event_7240_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7240_Desc = {
    Text = "O poder de retorno não pode mais encontrar uma junção por um curto período, mas pelo menos você obteve um consolo temporário"
  },
  Event_7240_Name = {
    Text = "Contato Anômalo"
  },
  Event_7241_ChoiceDesc1 = {
    Text = "[continuar procurando] Aumentar Arg1 ponto de vida, infectar[(Skill.Arg2)]"
  },
  Event_7241_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7241_Desc = {
    Text = "Parece que uma mão firme e forte tocou seu ombro, mas quando você se virou para procurar, a sensação desapareceu"
  },
  Event_7241_Name = {
    Text = "Contato Anômalo"
  },
  Event_7242_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7242_Desc = {
    Text = "'A sombra de N foi dispersa pelo golpe do punho, partículas escuras se fundem com a névoa do domínio, difícil de rastrear.\n\"Lamentável, um sujeito interessante. Estou ansioso pela nossa real reunião...\"'"
  },
  Event_7242_Name = {
    Text = "A apresentação começa"
  },
  Event_7243_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7243_Desc = {
    Text = "\n\"Bom garoto. Mas ainda assim, tenho que te dar uma pequena punição.\"\nA leve risada de Daffodil se apagou na fenda dimensional."
  },
  Event_7243_Name = {
    Text = "Tempo de dica"
  },
  Event_7244_ChoiceDesc1 = {
    Text = "[Positive] 50% de chance de obter uma Relíquia de Ouro \"(RelicConfig.Arg2)\", 50% de chance de ser infectado com \"(Skill.Arg3)\""
  },
  Event_7244_ChoiceDesc2 = {
    Text = "[Contraposição] 50% de chance de ganhar 75 sigilos negros, 50% de chance de infectar[(Skill.Arg3)]"
  },
  Event_7244_ChoiceDesc3 = {
    Text = "[Chip Negro] 50% de chance de obter uma relíquia amaldiçoada \"(RelicConfig.Arg2)\", 50% de chance de infectar \"(Skill.Arg3)\""
  },
  Event_7244_Desc = {
    Text = [[
Muito bem... muito bem...
Agora, escolha sua aposta]]
  },
  Event_7244_Name = {
    Text = "A apresentação começa"
  },
  Event_7245_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7245_Desc = {
    Text = "\"Tudo bem, tudo bem. Aquele cara sempre teve uma predileção por criaturas interdimensionais. Levei bastante esforço para navegar livremente por essas fendas dimensionais. Ah, isso deve ter sido há 3.000 anos.\""
  },
  Event_7245_Name = {
    Text = "Tempo de dica"
  },
  Event_7246_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7246_Desc = {
    Text = "Acredite, o Diretor de Pesquisa não vai colocar uma bomba no seu peito"
  },
  Event_7246_Name = {
    Text = "Broche Inquieto"
  },
  Event_7247_ChoiceDesc1 = {
    Text = "[Leave] Remover 1 cartão de comando e ganhar 25 sigilos negros."
  },
  Event_7247_Desc = {
    Text = "\"Um estranho gentil, oferecendo orientação aos perdidos,\" ele sorriu, \"Viaje leve. Cérbero aguarda.\"\nO dispositivo em sua mão de repente vibrou."
  },
  Event_7247_Name = {
    Text = "Companheiro Estranho III"
  },
  Event_7248_ChoiceDesc1 = {
    Text = "[Movendo-se lentamente] Escolha 1 carta de comando entre 3 e obtenha um sigilo:[(EnchantConfig.Arg1)]"
  },
  Event_7248_ChoiceDesc2 = {
    Text = "[Deitar-se] escolhe 1 entre 3 cartas de comando para obter a oração:[(EnchantConfig.Arg1)]"
  },
  Event_7248_Desc = {
    Text = "\"Ao encontrar pântanos, nunca lute.\"\nVocê mantém essa regra de sobrevivência em mente, ficando tão parado quanto uma estátua da Ilha de Páscoa.\nCinco minutos, dez minutos, uma hora... a lama negra finalmente perdeu a paciência e desapareceu debaixo dos seus pés."
  },
  Event_7248_Name = {
    Text = "Pântano Escuro"
  },
  Event_7249_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7249_Desc = {
    Text = "Você nota uma mão notável. Ela é delicada e pálida, mantendo-se calma do começo ao fim.\nMais importante—você a reconheceu, é sua própria mão.\nVocê a segura suavemente.\nA mão também segura a sua. Você sente um frio cortante e a ilusão, e então o pântano desaparece"
  },
  Event_7249_Name = {
    Text = "Pântano Escuro"
  },
  Event_7250_ChoiceDesc1 = {
    Text = "[Cortar uma mão] Escolha 1 carta entre 3 cartas de comando para ganhar um selo:[(EnchantConfig.Arg1)]"
  },
  Event_7250_ChoiceDesc2 = {
    Text = "[Calmar Eles] Escolha 1 entre 3 cartas de comando e obtenha uma oração:[(EnchantConfig.Arg1)]"
  },
  Event_7250_Desc = {
    Text = "Você balança a lâmina, cortando-os um a um.\nSangue de várias cores espirra em você, mas você não percebe.\nIncontáveis mãos gritam de dor, e o pântano desaparece.\nUma semana depois, os gritos ainda ecoam em seus pesadelos"
  },
  Event_7250_Name = {
    Text = "Pântano Escuro"
  },
  Event_7251_ChoiceDesc1 = {
    Text = "[Pegue o núcleo de prata] atualize 1 relíquia de prata para relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_7251_ChoiceDesc2 = {
    Text = "[Attempt Awakening] Ganhe Relíquia de Ouro \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\" e \"(Skill.Arg3)\""
  },
  Event_7251_ChoiceDesc3 = {
    Text = "[Ignorar] Ganhe 25 sigilos negros"
  },
  Event_7251_Desc = {
    Text = "De baixo da tábua solta do convés, escorre uma lama negra suja.\nE no brilho da lama, você reconhece o \"Núcleo de Prata\""
  },
  Event_7251_Name = {
    Text = "Prova de Existência"
  },
  Event_7252_ChoiceDesc1 = {
    Text = "[Escolher o Rato] uma carta de comando aleatória ganha oração:[(EnchantConfig.Arg1)]"
  },
  Event_7252_ChoiceDesc2 = {
    Text = "[Escolher a Candeia] aumenta Arg1 pontos de saúde máxima, infecta[(Skill.Arg2)]"
  },
  Event_7252_Desc = {
    Text = "O corpo dissoluto se desvanece diante de você, as cinzas esfriadas se fundem à névoa, formando de repente uma balança estranha. De um lado está um rato adormecido, do outro, uma vela esculpida em forma de menino.\nVocê sabe, em seu íntimo, que deve fazer uma escolha"
  },
  Event_7252_Name = {
    Text = "Razão e Emoção"
  },
  Event_7253_ChoiceDesc1 = {
    Text = "[Sondar em Voz Alta]"
  },
  Event_7253_ChoiceDesc2 = {
    Text = "[Seguir Secretamente]"
  },
  Event_7253_Desc = {
    Text = "Ao virar uma esquina, tudo ao redor se tornava cada vez mais confuso, exceto pelos gritos aterrorizantes que ainda eram claros. \n Passos ecoaram, e ao se virar, você vislumbrou uma figura estranha: parecia ser uma pessoa, mas atrás dela havia sombras em pares, que à primeira vista pareciam uma enorme mariposa. \n \"Cuidado,\" Ramona sussurrou, \"dentro do domínio, o que você vê pode não ser real, se você seguir imprudentemente, pode haver perigo.\""
  },
  Event_7253_Name = {
    Text = "Figura na névoa"
  },
  Event_7254_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7254_Desc = {
    Text = "Você tira a chave de prata, segurando-a com reverência enquanto uma luz suave te envolve.\nNo silêncio, só resta um suspiro"
  },
  Event_7254_Name = {
    Text = "Olho do olhar"
  },
  Event_7255_ChoiceDesc1 = {
    Text = "[Escolher o Caminho das Estrelas] uma carta de comando aleatória ganha oração:[(EnchantConfig.Arg1)]"
  },
  Event_7255_ChoiceDesc2 = {
    Text = "[Escolher o Caminho Arco-Íris] aumenta Arg1 pontos de saúde máxima, infecta[(Skill.Arg2)]"
  },
  Event_7255_Desc = {
    Text = "Tum, tum, tum.\nO coração bate como um tambor, a boca seca, o olhar do alto perfura seu peito.\nDiante de você, um caminho bifurcado, um rio de estrelas e um arco-íris brilhante"
  },
  Event_7255_Name = {
    Text = "Cruzamento Estelar"
  },
  Event_7256_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7256_Desc = {
    Text = "Os olhares remanescentes ainda estão fixos em você, e as células de carne sob sua pele gritam e fogem freneticamente, enquanto os vasos sanguíneos se contorcem como vermes sob a pele.\nVocê sente um poder fluindo, explodindo nas anomalias estranhas de seus membros"
  },
  Event_7256_Name = {
    Text = "Olho do olhar"
  },
  Event_7257_ChoiceDesc1 = {
    Text = "[Sair] Infectar[(Skill.Arg1)]"
  },
  Event_7257_ChoiceDesc2 = {
    Text = "[Sair] Infectar[(Skill.Arg1)]"
  },
  Event_7257_ChoiceDesc3 = {
    Text = "[Sair] Infectar[(Skill.Arg1)]"
  },
  Event_7257_Desc = {
    Text = "\"Não, isso não é verdade. Em comparação com os baratas, vocês têm pelo menos corpos peludos. \n Ninguém pode recusar um corpo peludo.\" \n Os ratos cochicharam e, no final, concordaram relutantemente com sua opinião. \n \"Até que não é tão ruim... na verdade, não tem tanto pelo.\" \n Ser elogiado é sempre agradável. Antes de partir, os ratos lhe deram um pequeno presente."
  },
  Event_7257_Name = {Text = "Peste"},
  Event_7258_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7258_Desc = {
    Text = "\"Eu concordo! Humanos e ratos não podem coexistir!\"\nOs ratos pareciam um pouco irritados, mostrando suas presas brancas. \n\"Então por que você ainda está aqui? Pegue suas coisas e nunca mais volte.\""
  },
  Event_7258_Name = {Text = "Peste"},
  Event_7259_ChoiceDesc1 = {
    Text = "[Leave] Obtenha Relíquia \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7259_Desc = {
    Text = "Sons estranhos de asas ao seu redor, você vê Rogers segurando o boneco George na cama de tratamento, com as mãos cobertas de sangue.\nVocê abre os olhos e Clementine desapareceu.\nAo acordar, Clementine já se foi"
  },
  Event_7259_Name = {
    Text = "Terapia de hipnose"
  },
  Event_7260_ChoiceDesc1 = {
    Text = "[Unlock] Use a chave."
  },
  Event_7260_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7260_Desc = {
    Text = "Uma porta bloqueia seu caminho. Você tentou de tudo, mas ela não se move"
  },
  Event_7260_Name = {
    Text = "Porta enferrujada"
  },
  Event_7260_Tips1 = {
    Text = "Chave Enferrujada necessária"
  },
  Event_7261_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7261_Desc = {
    Text = "Você olha na direção que acredita ser a fonte do olhar. O teto da oficina de repente se torna alto e distante; sombras de enormes pupilos se sobrepõem, e mesmo que apenas uma parte esteja olhando para você, você ainda sente uma enorme pressão"
  },
  Event_7261_Name = {Text = "Quem olha"},
  Event_7262_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7262_Desc = {
    Text = "O gato preto se aproxima cautelosamente e vomita uma bola negra na sua mão"
  },
  Event_7262_Name = {
    Text = "Desgraça do Gato Noturno"
  },
  Event_7263_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7263_Desc = {
    Text = "\"Uma escolha inteligente. Ao enfrentar um inimigo formidável, conhecer a si mesmo e ao seu inimigo é essencial, certo? Mas cuidado—saber demais sobre os segredos das dimensões pode desestabilizar sua mente.\"\n\"Esse cara não consegue parar de se preocupar com seres interdimensionais. Eu levei uma eternidade para me mover livremente através dessas fendas dimensionais. Ah, isso foi há 3.000 anos.\""
  },
  Event_7263_Name = {
    Text = "Tempo de dica"
  },
  Event_7264_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7264_Desc = {
    Text = "\"Miau, miau miau, miau miau miau...\"\nVocê forçou sua voz, tentando parecer fraco e inofensivo.\n\"Miau! Miau miau! Miau miau miau!\"\nO grupo de gatos parecia aceitar sua boa vontade, respondendo com chamados alegres. Seus gritos ecoavam para frente e para trás, dia e noite sem pausa, até assustando a lua, que se escondia atrás das nuvens."
  },
  Event_7264_Name = {
    Text = "Cidade dos Gatos"
  },
  Event_7265_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7265_Desc = {
    Text = "Você forçou o bico afiado do corvo, que tentava morder suas penas, a se virar, mas ele se retorceu teimosamente, a força era tamanha que até seus ossos estalavam. \n Seu rosto ficou vermelho e você usou toda a sua força para controlar o corpo do corvo, interrompendo seu ato de automutilação frenética. \n Enquanto você soltava um suspiro de alívio, o pescoço já quase careca do corvo se torceu violentamente para trás, seu corpo se tornou mole, se transformando em uma poça de lama negra em suas mãos."
  },
  Event_7265_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7266_ChoiceDesc1 = {
    Text = "[Aperte o Corvo] ganhe 20 o sigilo negro, contamine[(Skill.Arg2)]"
  },
  Event_7266_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Saia"
  },
  Event_7266_Desc = {
    Text = "O corvo solitário, com uma voz rouca, arranca suas penas negras uma a uma.\nEle treme de dor, gritando agudamente, mas não pode parar seu ritmo cada vez mais frenético.\n\"Caw—Caw—\"\nLágrimas azuis misturadas com uma gosma negra escorrem de seus olhos, testemunhadas apenas por você."
  },
  Event_7266_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7267_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7267_Desc = {
    Text = "Corvos arrancavam suas próprias penas, como humanos devorando seus corpos.\nNeste mundo de medo, isso é comum, você não pode salvar todos"
  },
  Event_7267_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7268_ChoiceDesc1 = {
    Text = "[Leave] Obtenha Relíquia \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7268_Desc = {
    Text = "\"Eu voltarei com os alunos.\" A garota puxou a saia do Despertador, resoluta, \"Cuide-se... não caia no mar.\""
  },
  Event_7268_Name = {
    Text = "Bênção da Santa Navegadora"
  },
  Event_7269_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7269_Desc = {
    Text = "Haha, preto, meu favorito. Caos, desordem, dor... você já deveria saber, preto não é um bom presságio.\nEntão, qual é sua próxima escolha?"
  },
  Event_7269_Name = {
    Text = "A apresentação começa"
  },
  Event_7270_ChoiceDesc1 = {
    Text = "[Aperte o Corvo] ganhe 25 o sigilo negro, contamine[(Skill.Arg2)], continue a escolher"
  },
  Event_7270_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Saia"
  },
  Event_7270_Desc = {
    Text = "O corvo solitário, com uma voz rouca, arranca suas penas negras uma a uma.\nEle treme de dor, gritando agudamente, mas não pode parar seu ritmo cada vez mais frenético.\n\"Caw—Caw—\"\nLágrimas azuis misturadas com uma gosma negra escorrem de seus olhos, testemunhadas apenas por você."
  },
  Event_7270_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7271_ChoiceDesc1 = {
    Text = "[Sair] escolha 1 carta dentre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_7271_Desc = {
    Text = "Aquele é o interior de um porão velho, sem luz ou orientação.\nA garota partirá com a bênção da Santa do Navio, é a promessa delas"
  },
  Event_7271_Name = {
    Text = "Bênção da Santa Navegadora"
  },
  Event_7272_ChoiceDesc1 = {
    Text = "[Seguir a Canção] escolhe uma entre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_7272_ChoiceDesc2 = {
    Text = "[Cante em harmonia] Infectar [(Skill.Arg1)], novamente uma oração aleatória"
  },
  Event_7272_Desc = {
    Text = "A canção distante se fragmenta em estrelas:\n\"Eu amaldiçoo a poça suja no beco noturno, flores podres adornam a base da parede em ruínas, correntes se prendem ao cérebro e afundam no lodo, antes que o nevoeiro apague minha existência, o crepúsculo afundará no mais profundo @3.\""
  },
  Event_7272_Name = {
    Text = "Maldição da Matéria Branca"
  },
  Event_7273_ChoiceDesc1 = {
    Text = "[Seguir a Canção] escolhe uma entre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_7273_Desc = {
    Text = "A canção distante se fragmenta em estrelas:\n\"Eu amaldiçoo a poça suja no beco noturno, flores podres adornam a base da parede em ruínas, correntes se prendem ao cérebro e afundam no lodo, antes que o nevoeiro apague minha existência, o crepúsculo afundará no mais profundo @4.\""
  },
  Event_7273_Name = {
    Text = "Maldição da Matéria Branca"
  },
  Event_7274_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7274_Desc = {
    Text = "O Núcleo Prateado não responde ao seu despertar, mas emite uma sensação de calor"
  },
  Event_7274_Name = {
    Text = "Núcleo de prata solitário"
  },
  Event_7275_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7275_Desc = {
    Text = "A névoa negra subiu pela espinha, e você repetiu a mesma frase até cair no chão"
  },
  Event_7275_Name = {
    Text = "Não olhar diretamente"
  },
  Event_7276_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7276_Desc = {
    Text = "Sim, o humor que flui lentamente de seus pupilos é a prova de que você foi corroído por tabus.\nA honestidade, neste momento, se opõe à virtude"
  },
  Event_7276_Name = {
    Text = "Não olhar diretamente"
  },
  Event_7277_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7277_Desc = {
    Text = "A moeda antiga está pegajosa, como se fosse um resíduo vomitado por algo impuro, emitindo uma fumaça negra visível a olho nu"
  },
  Event_7277_Name = {
    Text = "Moeda antiga de duas faces"
  },
  Event_7278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7278_Desc = {
    Text = "Seus nervos afiados emitem um aviso mortal, você estremece e recua.\nEscapou de novo...\nMaldição? Ou um renascimento?"
  },
  Event_7278_Name = {
    Text = "Moeda antiga de duas faces"
  },
  Event_7279_ChoiceDesc1 = {
    Text = "[Liberar a borboleta] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7279_ChoiceDesc2 = {
    Text = "[Tornar-se uma Borboleta] Ganhar a relíquia de prata \"(RelicConfig.Arg1)\" e infectar \"(Skill.Arg2)\""
  },
  Event_7279_ChoiceDesc3 = {
    Text = "[Swallow Back] Ganhe 25 Sigilos Negros"
  },
  Event_7279_Desc = {
    Text = "Nesta noite, muitas coisas aconteceram. \n Ataque ao cais, navio fantasma, Marchador de mares, Tulu, Murphy, Ramona... tudo girava no vórtice, sendo misturado na aveia do restaurante Misaq às sete da manhã. \n Queria fazer uma pergunta ao Corpo Desperto à minha frente, mas não sabia como começar, como se um espinho estivesse preso na garganta — ou melhor, as borboletas no estômago."
  },
  Event_7279_Name = {
    Text = "Efeito borboleta"
  },
  Event_7280_ChoiceDesc1 = {
    Text = "[Dissipar a Ilusão] Perder (Arg3) Vida."
  },
  Event_7280_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7280_Desc = {
    Text = "Rostos borrados aparecem de repente, gemendo desesperadamente ao seu redor"
  },
  Event_7280_Name = {Text = "Ilusão"},
  Event_7281_ChoiceDesc1 = {
    Text = "[Join the Prayer] Obter uma Relíquia de Prata \"(RelicConfig.Arg1)\", infectada com \"(Skill.Arg2)\""
  },
  Event_7281_ChoiceDesc2 = {
    Text = "[Afunde no Oceano] Obtenha a relíquia de ouro \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_7281_ChoiceDesc3 = {
    Text = "[Surface] Ganhar 25 Sigilos Negros"
  },
  Event_7281_Desc = {
    Text = "\"Deus gentil, Deus Todo-Poderoso.\nPor favor, acalme a feroz tempestade e bloqueie as correntes furiosas.\nDeixe o oceano se tornar nosso lar profundo, envolvendo nosso reino em um véu eterno...\"\nOs sussurros dos devotos finalmente se formam em palavras que você pode entender, mas com eles vem uma suffocação inevitável."
  },
  Event_7281_Name = {
    Text = "Prece do Sonho"
  },
  Event_7282_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7282_Desc = {
    Text = "Você jogou os pedaços de carne restantes para os gatos.\nOs gatos avançaram como uma maré negra, rasgando a carne freneticamente e depois se dispersaram rapidamente.\nInfelizmente, era carne estragada. Encheu seus estômagos vazios, mas não foi satisfatório"
  },
  Event_7282_Name = {
    Text = "Cidade dos Gatos"
  },
  Event_7283_ChoiceDesc1 = {Text = "[Pocketed]"},
  Event_7283_Desc = {
    Text = "Uma substância prateada, quase mercurial, extraída de uma mucosa de dissolução, contém grande poder espiritual, utilizada principalmente para vincular mais despertadores em rituais"
  },
  Event_7283_Name = {
    Text = "Núcleo de prata"
  },
  Event_7284_ChoiceDesc1 = {
    Text = "[Sair] escolhe 1 despertador e reduz o custo de aritmética da carta despertada em 2 pontos. infecção de[(Skill.Arg1)]"
  },
  Event_7284_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7284_Desc = {
    Text = "Talvez não possa ser transmitido agora, mas eles ouvirão seu chamado eventualmente"
  },
  Event_7284_Name = {
    Text = "Voz do guia"
  },
  Event_7285_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7285_Desc = {
    Text = "Os experimentos errantes já te cansaram, um breve descanso é como chuva no deserto"
  },
  Event_7285_Name = {
    Text = "Porta sem fim"
  },
  Event_7286_ChoiceDesc1 = {
    Text = "[Leave] Desperte um Despertador aleatório"
  },
  Event_7286_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7286_Desc = {
    Text = "Aquela voz guiará vocês ao destino final, a resposta desta investigação"
  },
  Event_7286_Name = {
    Text = "Voz do guia"
  },
  Event_7287_ChoiceDesc1 = {
    Text = "[Observar Cuidadosamente]"
  },
  Event_7287_Desc = {
    Text = "Observe à distância com a bola de cristal"
  },
  Event_7287_Name = {
    Text = "Bola de cristal"
  },
  Event_7288_ChoiceDesc1 = {
    Text = "[Afastar corvos] Obtenha Arg1 sigilo negro, infectar [(Skill.Arg2)], continue a escolher"
  },
  Event_7288_ChoiceDesc2 = {
    Text = "[Ignorar] Saia"
  },
  Event_7288_Desc = {
    Text = "O corvo pousou no guarda-roupa, seu bico afiado gravando padrões estranhos na porta de madeira"
  },
  Event_7288_Name = {
    Text = "Lanterna Corvo Preto"
  },
  Event_7289_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7289_Desc = {
    Text = "Você aceita o pedido de contato da escola, a voz familiar te acalma. Você se recompõe e segue em frente"
  },
  Event_7289_Name = {
    Text = "Ponto de contato"
  },
  Event_7290_ChoiceDesc1 = {
    Text = "[Ficar aqui] obtem a relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_7290_ChoiceDesc2 = {
    Text = "[Find the Exit] Obtenha a Relíquia de Ouro \"(RelicConfig.Arg1)\" e infecte com \"(Skill.Arg2)\""
  },
  Event_7290_Desc = {
    Text = "Você entra em uma quietude pálida, as portas sobrepostas giram sem limites, sugando seu corpo como um vórtice. \n Você se debate tonto dentro das portas invertidas, reconhecendo vagamente a direção da fuga, mas inevitavelmente cai repetidamente em outra porta. \n Desta vez, você para novamente em frente a uma porta, o desconhecido que surge atrás dela emana uma atração mortal, mas sua razão se tensiona. \n Sim, realmente é mortal."
  },
  Event_7290_Name = {
    Text = "Além das portas duplas"
  },
  Event_7291_ChoiceDesc1 = {
    Text = "[Ecstasy] Excluir 1 carta de comando, e restaurar Arg1 Vida"
  },
  Event_7291_ChoiceDesc2 = {
    Text = "[Stop] Obtenha uma Relíquia de Ouro \"(RelicConfig.Arg1)\" e torne-se infectado com \"(Skill.Arg2)\""
  },
  Event_7291_Desc = {
    Text = "Como se o crânio tivesse sido facilmente aberto, uma náusea vertiginosa invade sua mente, uma mão invisível remexe seu cérebro, e a substância que já tende a ser fluida se despedaça em uma poça. \n Como se fosse uma massa viscosa não digerida, já se libertou da gravidade e flui para dentro do seu córtex cerebral vazio e carente. \n Ela amassa, mistura, agarra, polvilha com alegria picada, incorporando os vestígios do pôr do sol na carne."
  },
  Event_7291_Name = {
    Text = "Agitar o cérebro"
  },
  Event_7292_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7292_Desc = {
    Text = "Comparado ao súbito aparecimento do cão infernal, a neve comum não merece sua atenção. Você ignorou os flocos de neve caindo e correu para a noite"
  },
  Event_7292_Name = {Text = "Neve"},
  Event_7293_ChoiceDesc1 = {
    Text = "[Conectar]recuperar Arg2 de vida"
  },
  Event_7293_Desc = {
    Text = "Você explora na névoa, de repente, o emblema no seu peito emite um fraco brilho prateado. Quem está chamando você do outro lado do comunicador?"
  },
  Event_7293_Name = {
    Text = "Ponto de contato"
  },
  Event_7294_ChoiceDesc1 = {
    Text = "[Feel Fear] Ganhar Relíquia de Ouro \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\""
  },
  Event_7294_ChoiceDesc2 = {
    Text = "[Vontade Firme] Escolha 1 entre 3 cartas de comando e obtenha uma oração:[(EnchantConfig.Arg1)]"
  },
  Event_7294_Desc = {
    Text = "Um grito estranho ecoa incessantemente, mas tudo em Londinium permanece indiferente, como se estivesse morto ou adormecido. \n Você vagueia inconscientemente sob a ponte ferroviária, relembrando os conselhos de Alistair. \n Ele se levanta educadamente e se aproxima, parecendo lhe contar algo, mas suas palavras são confusas e pegajosas. \n Você levanta a cabeça, gotas de um líquido negro e espesso escorrem de sua boca, entupindo sua garganta e bloqueando suas frases —"
  },
  Event_7294_Name = {
    Text = "Grito do Caos"
  },
  Event_7295_ChoiceDesc1 = {
    Text = "[Leave] Obter 1 de 3 Orações"
  },
  Event_7295_Desc = {
    Text = "\"Claro, claro. Se você não se importar, posso lhe dar uma mão.\"\nEle lhe entrega um antigo espelho de mão.\n\"O cavaleiro já tomou a peça, e o rei não estará longe atrás. Você provavelmente encontrará ele em breve. Verdadeiramente emocionante, não é?\""
  },
  Event_7295_Name = {
    Text = "Companheiro Estranho IV"
  },
  Event_7296_ChoiceDesc1 = {
    Text = "[Shredded Letter] Remover 2 Cartões"
  },
  Event_7296_ChoiceDesc2 = {
    Text = "[Continuar Lendo] Obter relíquia amaldiçoada \"(RelicConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7296_ChoiceDesc3 = {
    Text = "[Leave] Ganhar Arg1 sigilos negros"
  },
  Event_7296_Desc = {
    Text = "À sua frente, uma nuvem de borboletas negras irrompe, transbordando, batendo suas asas e caindo continuamente sobre a mesa. \n O papel de carta em branco se espalha, coberto de manchas de tinta, enquanto as borboletas feridas se arrastam, exaustas, sobre a superfície do papel. \n O líquido negro que se agarra às suas asas forma palavras proibidas. \n Você puxa este papel da máquina de escrever."
  },
  Event_7296_Name = {
    Text = "Capítulo Borboleta"
  },
  Event_7297_ChoiceDesc1 = {
    Text = "[Vá até as Borboletas] Remova 1 carta de comando, ganhe Arg1 sigilos negros"
  },
  Event_7297_ChoiceDesc2 = {
    Text = "[Não Dura Mais]"
  },
  Event_7297_Desc = {
    Text = "Um ditado recente em Londinium diz: \"O bater de asas de uma borboleta em Akut pode causar uma tempestade no Reino de Leo.\"\nQuando você vê as borboletas surgirem, não consegue evitar lembrar deste ditado.\nEssas borboletas podem ser suficientes para provocar um desastre que poderia engolir o planeta."
  },
  Event_7297_Name = {
    Text = "Tempestade de Conhecimento"
  },
  Event_7298_ChoiceDesc1 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7298_Desc = {
    Text = "Você coloca um dedo nos lábios, sinalizando que se manterá em silêncio sobre isso.  \nA sombra do gato preto passou como um fantasma, deixando um presente brilhante ao seu lado"
  },
  Event_7298_Name = {
    Text = "Desgraça do Gato Noturno"
  },
  Event_7299_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7299_Desc = {
    Text = "Ele desliza para sua bolsa como um pedaço de seda, e com o leve aumento de peso, você ouve um leve agradecimento.\nDepois disso, não há mais som"
  },
  Event_7299_Name = {
    Text = "Espírito do Caos"
  },
  Event_7300_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7300_Desc = {
    Text = "O choro do Espírito do Caos ficou mais agudo, até se transformar em um grito estridente, ecoando ao redor.\nEle afundou novamente no pântano com sua oferenda e tristeza inescapável"
  },
  Event_7300_Name = {
    Text = "Espírito do Caos"
  },
  Event_7301_ChoiceDesc1 = {
    Text = "[Preencher como está]"
  },
  Event_7301_ChoiceDesc2 = {
    Text = "[Rabisco Aleatório]"
  },
  Event_7301_Desc = {
    Text = "As ruas do Distrito Leste são complicadas, e em pouco tempo você perdeu de vista as crianças. \n Enquanto você se sente perdido, uma mulher misteriosa se dirige a você. \n \"Eu sei para onde as crianças foram, mas antes de te contar, você poderia me ajudar com um pequeno favor?\" \n Ela tira um pedaço de papel e sorri amigavelmente para você. \n \"Meu nome é Clementine, sou médica e estou realizando uma pesquisa psicológica sobre os residentes de Londinium. Se você puder me ajudar a preencher este questionário. \n Se você preencher com sinceridade, ficarei feliz em oferecer alguma ajuda a você e seus colegas.\""
  },
  Event_7301_Name = {
    Text = "Avaliação psicológica"
  },
  Event_7302_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7302_Desc = {
    Text = "\"Essa também é a minha escolha.\" disse a sombra segurando doces, \"Mas ela se tornará uma moeda de troca para ele, você terá que escolher. \n Não existe um final perfeito no mundo.\" \n Uma profunda tristeza te afoga. A sombra se dissipa, você se apoia sobre o peito, sem saber se o que acabou de acontecer foi uma projeção ou uma ilusão gerada pela pressão mental."
  },
  Event_7302_Name = {
    Text = "Caminho bifurcado"
  },
  Event_7303_ChoiceDesc1 = {
    Text = "[Machado Dourado]"
  },
  Event_7303_ChoiceDesc2 = {
    Text = "[Silver Axe]"
  },
  Event_7303_ChoiceDesc3 = {
    Text = "[Não Deixei Nada Cair]"
  },
  Event_7303_Desc = {
    Text = "\"Ó Pioneiro da Dimensão Cruzando.\"\nUma voz antiga ecoa em seus ouvidos, como se viesse da pré-história, transcendendo as épocas.\nEm extrema tensão, você ouve a voz fazer uma pergunta um tanto familiar.\n\"É este o machado dourado que você deixou cair, ou é este aqui de prata?\""
  },
  Event_7303_Name = {
    Text = "Voz fora do mundo"
  },
  Event_7304_ChoiceDesc1 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7304_Desc = {
    Text = "\"Ah, isso...\" Ela recolheu o questionário, mostrando uma expressão um tanto resignada, \"Deixe pra lá, você está com pressa, afinal. As crianças foram para lá, não devem ter ido longe.\"\n Você se virou apressado, quase não conseguindo ouvir o sussurro atrás de você.\n \"De qualquer forma, nós nos encontraremos novamente.\""
  },
  Event_7304_Name = {
    Text = "Avaliação psicológica"
  },
  Event_7305_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7305_Desc = {
    Text = "\"Quem é você?\"\n\"Eu sou a sombra do Usador de Chave de Prata que foi cruelmente assassinado, e o assassino é uma serpente albina astuta.\"\n\"Serpente albina? O que é isso?\"\n\"Um erro. Uma profanação nascida da mistura entre humanos e serpentes...\"\nVocê ainda quer continuar perguntando, mas a sombra desaparece de repente, deixando para trás uma chuva de poeira dourada."
  },
  Event_7305_Name = {
    Text = "Usador de chave de prata"
  },
  Event_7306_ChoiceDesc1 = {
    Text = "[Infection\"(Skill.Arg1)\", Ganhar Relíquia de Ouro \"(RelicConfig.Arg2)\"]"
  },
  Event_7306_ChoiceDesc2 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7306_Desc = {
    Text = "Evento 355 (em desenvolvimento), não é o efeito final"
  },
  Event_7306_Name = {
    Text = "Evento 355 (em desenvolvimento)"
  },
  Event_7307_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7307_Desc = {
    Text = "Desça ao estômago, dance com as borboletas.\nOs pensamentos se misturam com as borboletas, caindo como neve branca no estômago.\nVocê entende tudo, na próxima oportunidade, você falará"
  },
  Event_7307_Name = {
    Text = "Efeito borboleta"
  },
  Event_7308_ChoiceDesc1 = {
    Text = "[Refute Them] Infecte \"(Skill.Arg1)\", conceda aleatoriamente 1 cartão uma Oração: \"(EnchantConfig.Arg2)\""
  },
  Event_7308_ChoiceDesc2 = {
    Text = "[Follow them] Infecte \"(Skill.Arg1)\", uma carta aleatória ganha Oração: \"(EnchantConfig.Arg2)\""
  },
  Event_7308_ChoiceDesc3 = {
    Text = "[apresentar nova perspectiva] escolhe 1 de 3 cartas de comando e ganha oração:[(EnchantConfig.Arg1)]"
  },
  Event_7308_Desc = {
    Text = "\"Por favor, mantenha distância de nós.\"\nUm grupo de ratos te cercou, mantendo pelo menos cinco pés de distância. \n \"Nós nos esforçamos para reproduzir, crescemos saudáveis e nunca somos exigentes — assim, trazemos doenças, ansiedade e sofrimento aos humanos.\"\n \"Não devemos nos aproximar demais dos humanos, este não é o seu lugar.\"\n Para fazer com que os ratos relaxem, você decide —"
  },
  Event_7308_Name = {Text = "Peste"},
  Event_7309_ChoiceDesc1 = {
    Text = "[Open Iron Door] Infecte com \"(Skill.Arg1)\" e obtenha a Relíquia de Ouro \"(RelicConfig.Arg2)\""
  },
  Event_7309_ChoiceDesc2 = {
    Text = "[Ignorar] Ganhe 50 Sigilos Negros"
  },
  Event_7309_Desc = {
    Text = "É uma ponte em arco típica, com escadas ao lado da ferrovia levando a um portão de ferro. Atrás do portão, há um som rítmico e estranho.\nVocê para para observar o portão e vê um cadeado pesado, mas não trancado"
  },
  Event_7309_Name = {
    Text = "Depois da porta de ferro"
  },
  Event_7310_ChoiceDesc1 = {
    Text = "[Sair] infecção de[(Skill.Arg1)], ganha 50 o sigilo negro"
  },
  Event_7310_Desc = {
    Text = "Resistindo à tentação, você permanece firme.\nA dona da voz parece desapontada, causando algumas ondulações na superfície da água, e então tudo se acalma novamente."
  },
  Event_7310_Name = {
    Text = "Voz fora do mundo"
  },
  Event_7311_ChoiceDesc1 = {
    Text = "[Infection\"(Skill.Arg1)\", Ganhar Relíquia de Ouro \"(RelicConfig.Arg2)\"]"
  },
  Event_7311_ChoiceDesc2 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7311_Desc = {
    Text = "Evento 353 (em desenvolvimento), não é o efeito final"
  },
  Event_7311_Name = {
    Text = "Evento 353 (em desenvolvimento)"
  },
  Event_7312_ChoiceDesc1 = {
    Text = "[Sair] infecção de[(Skill.Arg1)], ganha 50 o sigilo negro"
  },
  Event_7312_Desc = {
    Text = "\"Vocês humanos não têm outras respostas?\"\nO dono da voz soltou um rosnado impaciente, sacudindo todo o espaço.\n\"Gananciosos e ignorantes... É por isso que estou cansado de vocês.\""
  },
  Event_7312_Name = {
    Text = "Voz fora do mundo"
  },
  Event_7313_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7313_Desc = {
    Text = "Aceite o arranjo do domínio, ganhando na perda, desfrutando do abraço amaldiçoado"
  },
  Event_7313_Name = {
    Text = "Efluxo de Delírios"
  },
  Event_7314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7314_Desc = {
    Text = "Os olhos piscam lentamente, sem saber se entenderam sua pergunta. \n Uma lágrima de um vermelho dourado escorre do canto do olho, como uma pequena estrela, emitindo uma luz quente como a do sol. Ela cai, cai, trazendo tristeza, trazendo compaixão, e se despedaça em uma pequena poeira sobre os tijolos. \n Você se recupera de repente, e aquele olho já não está mais lá."
  },
  Event_7314_Name = {Text = "Olhar cego"},
  Event_7315_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7315_Desc = {
    Text = "Algumas crianças sujas e mal vestidas corriam pela rua, perseguidas por um adulto de uniforme policial. Uma delas usava um capuz marrom que parecia familiar"
  },
  Event_7315_Name = {
    Text = "Nossas Memórias"
  },
  Event_7316_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7316_Desc = {
    Text = "\"Pare de cantar—\"\nVocê avisa o cantor desafinado, recusando-se a deixar que eles torturem seus ouvidos mais."
  },
  Event_7316_Name = {
    Text = "Vilão no Caminho Estreito"
  },
  Event_7317_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7317_Desc = {
    Text = "\n\"Pare aí!!! Até o monstro em decomposição que rasteja em sua barriga conhece seus próprios membros melhor do que você!\" \nDeixe o público ir... \nVocê reza isso em seu coração"
  },
  Event_7317_Name = {
    Text = "Vilão no Caminho Estreito"
  },
  Event_7318_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7318_Desc = {
    Text = "Gotas de lama negra caem no seu rosto, causando uma coceira.\nVocê não aguenta e afasta a borboleta.\nA borboleta escapa e desaparece silenciosamente"
  },
  Event_7318_Name = {
    Text = "Algo que não deveria existir"
  },
  Event_7319_ChoiceDesc1 = {
    Text = "[Elogi-o] Escolha 1 carta de comando entre 3 para obter a oração:[(EnchantConfig.Arg1)]"
  },
  Event_7319_Desc = {
    Text = "Jenkins disse: Acorde, Johnny! Escrever poesia não vai pagar suas dívidas, nem resolver o problema da infiltração no chão da sua casa. \n Você disse: Infelizmente, suas células que buscam a verdade estão morrendo a uma taxa de 100 mil por dia, e logo você se tornará um verdadeiro tronco encefálico. \n O cérebro deu de ombros despreocupadamente — se é que ele tinha um. \n O cérebro disse: Penso, logo existo. Quando você conseguir alcançar a profundidade de pensamento que eu tenho, não se importará mais com o tronco encefálico."
  },
  Event_7319_Name = {
    Text = "Cérebro filosófico"
  },
  Event_7320_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7320_Desc = {
    Text = "O piano solta um suspiro suave, parecendo reconfortar e também nostálgico, como o sorriso de alguém ao final de uma música.\n“Contanto que as crianças... contanto que...”\nVocê não teve tempo para ouvir claramente, e a ilusão do piano se dispersou com o vento"
  },
  Event_7320_Name = {
    Text = "Melodia da Infância"
  },
  Event_7321_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para relíquia de prata, infecção de[(Skill.Arg1)]"
  },
  Event_7321_Desc = {
    Text = "Você pega o grosso prontuário e o abre, vendo as letras \"G·R\" na primeira página.\n\"Ah, não é seu prontuário?\" Clementine não parece se importar, \"Estudar a mente dos outros também ajuda a entender a si mesmo.\"\nAntes que você pergunte, ela desaparece"
  },
  Event_7321_Name = {
    Text = "prontuário médico"
  },
  Event_7322_ChoiceDesc1 = {
    Text = "[deixar] Escolher despertar 1 Desperto, infectar[(Skill.Arg1)]"
  },
  Event_7322_Desc = {
    Text = "Você pega o fino prontuário e o abre, encontrando apenas uma folha com uma frase.\n\"No caos eterno, o olho pálido sem visão observa para sempre.\"\nVocê quer perguntar a Clementine, mas ela já sumiu"
  },
  Event_7322_Name = {
    Text = "prontuário médico"
  },
  Event_7323_ChoiceDesc1 = {
    Text = "[Connect] Restaurar toda a Vida."
  },
  Event_7323_ChoiceDesc2 = {
    Text = "[Meditate] Escolha despertar 1 Despertador."
  },
  Event_7323_Desc = {
    Text = "Você explora na névoa, de repente, o emblema no seu peito emite um fraco brilho prateado. Quem está chamando você do outro lado do comunicador?"
  },
  Event_7323_Name = {
    Text = "Ponto de contato"
  },
  Event_7324_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7324_Desc = {
    Text = "Evidências importantes devem ser cuidadosamente preservadas e entregues ao departamento de história para análise"
  },
  Event_7324_Name = {
    Text = "Ordem secreta · Parte superior"
  },
  Event_7325_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7325_Desc = {
    Text = "O sol brilha do alto, perfurando a névoa e despertando almas cansadas"
  },
  Event_7325_Name = {
    Text = "Ângulo de elevação"
  },
  Event_7326_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7326_Desc = {
    Text = "Você se sente satisfeito, os olhares deles brilham no céu noturno acima de você, focando em você"
  },
  Event_7326_Name = {
    Text = "Olho do domo"
  },
  Event_7327_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7327_Desc = {
    Text = "Você não pode evitar o olhar incômodo, e claro, não pode resistir aos presentes dos deuses"
  },
  Event_7327_Name = {
    Text = "Olho do domo"
  },
  Event_7328_ChoiceDesc1 = {
    Text = "[Leave] Obtenha Relíquia \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7328_Desc = {
    Text = "\n\"O que exatamente você é?\" você pergunta horrorizado. \n\"Não há necessidade de se preocupar com isso. O inimigo do meu inimigo é um amigo, não é?\" O homem sorri. \n\"O presente foi deixado na cadeira. Desejo-lhe boa sorte.\""
  },
  Event_7328_Name = {
    Text = "Companheiro Estranho IV"
  },
  Event_7329_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7329_Desc = {
    Text = "Ramona se aproximou, esperando ouvir mais sobre o \"jaleco branco\". \"Alguém está ouvindo!\" A voz do gramofone aumentou de repente, \"Ouvindo, ouvindo, ouvindo!\""
  },
  Event_7329_Name = {
    Text = "O ouvido alheio"
  },
  Event_7330_ChoiceDesc1 = {
    Text = "[Leave] Todos os Despertadores recuperam Arg1 Aliemus"
  },
  Event_7330_Desc = {
    Text = "Você segura a mão suave do menino, passando por uma porta após outra, finalmente chegando a um pequeno palco desgastado.\nO menino aperta sua mão para expressar sua gratidão.\n\"Obrigado, adeus.\""
  },
  Event_7330_Name = {
    Text = "Cerimônia Final II"
  },
  Event_7331_ChoiceDesc1 = {
    Text = "[Continuar Caindo] ganha relíquia de prata[(RelicConfig.Arg1)], continuar a cair?"
  },
  Event_7331_ChoiceDesc2 = {
    Text = "[Puxe para Lado] Ganhar 25 Sigilos Negros"
  },
  Event_7331_Desc = {
    Text = "\"Você\" o convida.\nNas profundezas do espiral, o passado e o futuro \"você\" lhe enviam \"presentes\" de diferentes dimensões."
  },
  Event_7331_Name = {
    Text = "Abismo Espiral"
  },
  Event_7332_ChoiceDesc1 = {
    Text = "[Keep Silent] Ganhe 25 Sigilos Negros"
  },
  Event_7332_ChoiceDesc2 = {
    Text = "[Alcance e Toque] 50% de chance de ganhar 50 Sigilos Negros, 50% de chance de nada."
  },
  Event_7332_Desc = {
    Text = "\"Eu só tenho um ditado para dizer - ninguém pode matar um gato!\"\n\"Aquele maldito gato preto deveria ter sido eviscerado e deixado para apodrecer, mas ele cavou a sepultura da minha família, devorando a carne podre dos humanos remanescentes, enquanto os ossos e membros estavam espalhados em pedaços.\"\n\"Sob o olhar frio e escuro das pupilas verticais, um líquido purulento amarelo escuro subiu, exalando um fedor, e eu escapei de lá, rolando e rastejando, atormentado por um pesadelo que me deixou em estado de apatia.\"\n\"Espere... o que vocês vão fazer? Eu não estou louco! Eu não estou! Vocês devem estar tentando encobrir algo! Isso é verdade——\"\nE de fato era verdade, enquanto observava a sombra do homem enlouquecido desaparecer, você trocou um olhar com o gato preto que estava quieto ao seu lado."
  },
  Event_7332_Name = {
    Text = "Desgraça do Gato Noturno"
  },
  Event_7333_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7333_Desc = {
    Text = "Você perguntou a ele onde fica o museu de cera.\nEstranho, esta é a quinta vez que vocês se encontram esta noite. Você acendeu o fogo para ele cinco vezes e perguntou o caminho cinco vezes.\nMas ainda não lembra onde fica o museu, assim como vocês continuam se encontrando"
  },
  Event_7333_Name = {
    Text = "A sombra sob o poste de luz"
  },
  Event_7334_ChoiceDesc1 = {
    Text = "[Afastar corvos] Obtenha 25 sigilo negro, infectar [(Skill.Arg2)], continue a escolher"
  },
  Event_7334_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Sair"
  },
  Event_7334_Desc = {
    Text = "O terceiro corvo partiu, voando para onde os olhos não alcançam, para a escuridão eterna"
  },
  Event_7334_Name = {
    Text = "Olhar da Corvo Negro"
  },
  Event_7335_ChoiceDesc1 = {
    Text = "[Sair] ganha 75 o sigilo negro, infecção de[(Skill.Arg2)]"
  },
  Event_7335_Desc = {
    Text = "A pele nos tentáculos era macia e quente, ainda com o calor da vida de Kum.\nEra o último raio de sol antes do pôr do sol, o calor fugaz"
  },
  Event_7335_Name = {
    Text = "Resíduo de calor"
  },
  Event_7336_ChoiceDesc1 = {Text = "[Chase]"},
  Event_7336_Desc = {
    Text = "Você procurou na parede e finalmente encontrou uma entrada de esgoto escondida atrás da grama. Você passou pelo esgoto, mas o monstro já tinha fugido"
  },
  Event_7336_Name = {
    Text = "Beco sem saída"
  },
  Event_7337_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7337_Desc = {
    Text = "As aves têm suas próprias regras, não seguem sua vontade, e você não tem o direito de interferir na natureza"
  },
  Event_7337_Name = {
    Text = "Corvo Solitário"
  },
  Event_7338_ChoiceDesc1 = {
    Text = "[Overlook Reflection] Ganhe 25 Sigilos Negros"
  },
  Event_7338_ChoiceDesc2 = {
    Text = "[Are You Okay?] Obtenha uma Relíquia de Prata \"(RelicConfig.Arg1)\" e fique infectado com \"(Skill.Arg2)\"."
  },
  Event_7338_Desc = {
    Text = "\"Você sabe o que... aquela nova chefe ao lado nunca sai... Outro dia, comprei uma cerveja para ela, e depois que a espuma desapareceu completamente, percebi de repente... no copo, ela não tinha sombra!\""
  },
  Event_7338_Name = {
    Text = "Fragmentos de Memória: Cerveja"
  },
  Event_7339_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7339_Desc = {
    Text = "\"Eu realmente quero cantar com você novamente...\"\nO grito distorcido e enfurecido de Sarah de repente parou, seu rosto deformado mostrando um traço de confusão."
  },
  Event_7339_Name = {
    Text = "\"Irmã Sasha\""
  },
  Event_7340_ChoiceDesc1 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7340_Desc = {
    Text = "\"Tão feliz! Tão feliz!\" Uma voz alta, aguda e infantil ressoa em seus ouvidos, \"Para você, para você!\""
  },
  Event_7340_Name = {
    Text = "Elfo Noturno"
  },
  Event_7341_ChoiceDesc1 = {
    Text = "[Livro de Registro Médico Grosso]"
  },
  Event_7341_ChoiceDesc2 = {
    Text = "[Livro de Registro Médico Fino]"
  },
  Event_7341_Desc = {
    Text = "Uma voz bastante familiar te chamou, você apertou os olhos, mas não conseguiu ver sua figura. \n \"Eu sei que você está com pressa,\" disse a doutora Clementine com um tom alegre, \"Eu prometo que não vou te atrasar muito.\" \n Duas mãos atravessaram a névoa em sua mente, cada uma segurando um prontuário médico, um grosso e desgastado, o outro fino e novinho. \n \"Com base nos resultados do seu questionário, eu tomei a liberdade de fazer um prontuário para você. Mas, eu acabei esquecendo qual é o seu, que tal você escolher um?\" \n Não sei por quê, mas o prontuário fino emanava uma aura familiar, ressoando levemente com a conexão mental entre você e os Corpos Despertos."
  },
  Event_7341_Name = {
    Text = "prontuário médico"
  },
  Event_7342_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7342_Desc = {
    Text = "Uma parede comum, você não resistiu a bater nela, mas parecia não ser sólida"
  },
  Event_7342_Name = {
    Text = "Parede estranha"
  },
  Event_7343_ChoiceDesc1 = {
    Text = "[Não estou na superfície] Aprimore aleatoriamente 1 relíquia de prata para uma relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_7343_ChoiceDesc2 = {
    Text = "[Look Down] Obtenha uma Relíquia Prata \"(RelicConfig.Arg1)\" e torne-se infectado com \"(Skill.Arg2)\""
  },
  Event_7343_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7343_Desc = {
    Text = "\"Hehe, Guardião, você ainda se lembra do aviso do Búzio? Ouça, não olhe para seu reflexo ao meio-dia.\""
  },
  Event_7343_Name = {
    Text = "Reflexo Imaterial"
  },
  Event_7343_Tips1 = {
    Text = "Ainda não possui relíquia de prata"
  },
  Event_7344_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7344_Desc = {
    Text = "A aparição de um futuro distante, oculta nas montanhas de Elworth"
  },
  Event_7344_Name = {
    Text = "Fantasma vulcânico"
  },
  Event_7345_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7345_Desc = {
    Text = "A borboleta se despedaça na sua mão, como um teto de vidro quebrado, caindo, caindo, caindo—"
  },
  Event_7345_Name = {
    Text = "Ilusão da Ponte de Aço"
  },
  Event_7346_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7346_Desc = {
    Text = "Espere até que eles apareçam das sombras"
  },
  Event_7346_Name = {
    Text = "Lanterna Corvo Preto"
  },
  Event_7347_ChoiceDesc1 = {
    Text = "[Switch On] Expanda a visão atual."
  },
  Event_7347_Desc = {
    Text = "Dispositivo de iluminação deixado pelos antecessores, pode dispersar a névoa negra ao redor.\nA névoa ao redor oscila regularmente, como se perturbada pela respiração"
  },
  Event_7347_Name = {
    Text = "projector de busca"
  },
  Event_7348_ChoiceDesc1 = {
    Text = "[Apontar o problema] escolha 1 de 3 cartas de comando e ganhe oração: [(EnchantConfig.Arg1)]"
  },
  Event_7348_ChoiceDesc2 = {
    Text = "[Engula a dúvida] infecta[(Skill.Arg1)], reimprime, até 2 vezes"
  },
  Event_7348_Desc = {
    Text = "Até agora, você ainda está saboreando o passado que Murphy contou. \n As memórias fazem você sentir empatia, aprisionando e pressionando seu cérebro, nem mesmo as palavras de consolo de Goliath para Murphy conseguiram lhe trazer conforto. \n ... Espere, eles disseram que o próximo alinhamento estelar será em vinte e cinco anos... \n Mas a Murphy à sua frente é claramente apenas uma criança crescida..."
  },
  Event_7348_Name = {Text = "Vida Presa"},
  Event_7349_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para relíquia de prata, infecção de[(Skill.Arg1)]"
  },
  Event_7349_Desc = {
    Text = "Ela deveria chorar, ninguém tem mais direito de chorar do que ela.\nMas por que ela não chora? Por que ela se mantém distante, como se aqueles que se ajoelham não fossem por ela"
  },
  Event_7349_Name = {
    Text = "Cerimônia Pré-Voo"
  },
  Event_7350_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7350_Desc = {
    Text = "De qualquer forma, é falta de educação bisbilhotar a privacidade dos outros"
  },
  Event_7350_Name = {
    Text = "Como se estivéssemos frente a frente"
  },
  Event_7351_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7351_Desc = {
    Text = "Deve ser apenas uma ilusão"
  },
  Event_7351_Name = {
    Text = "Olhar da Corvo Negro"
  },
  Event_7352_ChoiceDesc1 = {
    Text = "[Leave] Obter 1 de 3 Orações"
  },
  Event_7352_Desc = {
    Text = "Todos em suas memórias rezavam e imploravam a ela. Você não pôde evitar murmurar em seu coração"
  },
  Event_7352_Name = {
    Text = "Cerimônia Pré-Voo"
  },
  Event_7353_ChoiceDesc1 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7353_Desc = {
    Text = "Debaixo do gato preto, um líquido negro escorre, formando um riacho que leva ao esgoto. Vendo que você não se aproxima, o gato preto pula no esgoto e desaparece"
  },
  Event_7353_Name = {
    Text = "Elfo Noturno"
  },
  Event_7354_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7354_Desc = {
    Text = "Você entrou em pânico e soltou um grito agudo.\nParecendo hesitar por um momento, a mão que estava inquieta parou.\nVocê aproveitou a oportunidade e fugiu imediatamente"
  },
  Event_7354_Name = {
    Text = "Pântano Escuro"
  },
  Event_7355_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7355_Desc = {
    Text = "Distorcer, contorcer, rastejar... você tentou de tudo para se livrar desses braços irritantes.\nNo final, você escapou, mas perdeu um uniforme novo, duas costelas e centenas de fios de cabelo"
  },
  Event_7355_Name = {
    Text = "Pântano Escuro"
  },
  Event_7356_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7356_Desc = {
    Text = "\n\"Um fenômeno normal. Não fique alarmado, como um novato,\" \nBoneca se inclinou mais perto, ajustando a posição do seu broche. \"Isso indica que há passagens de dimensões especiais nas proximidades. Parece estar na direção do asilo.\""
  },
  Event_7356_Name = {
    Text = "Broche Inquieto"
  },
  Event_7357_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7357_Desc = {
    Text = "Você não tem motivo para aceitar o pedido da crente que alimenta você.\nO corvo balança a horrenda cabeça empilhada, emitindo sons estranhos que só se ouvem à beira do túmulo, e grita ao voar"
  },
  Event_7357_Name = {
    Text = "Corvo Amaldiçoado"
  },
  Event_7358_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7358_Desc = {
    Text = "\"Essa também é a minha escolha.\" disse a sombra segurando um ursinho, \"Mas ela se tornará uma marionete para ele, e todos eles morrerão. \n Você será o cúmplice do mal.\" \n Uma intensa culpa te afoga. A sombra se dissipa, você se apoia sobre o peito, sem saber se o que acabou de acontecer foi uma projeção ou uma ilusão gerada pela pressão mental."
  },
  Event_7358_Name = {
    Text = "Caminho bifurcado"
  },
  Event_7359_ChoiceDesc1 = {
    Text = "[Keep Covering Ears] Ganhe um número de sigilos pretos igual ao maior valor de Aliemus de um Despertador (Arg1)"
  },
  Event_7359_ChoiceDesc2 = {
    Text = "[Keep Covering Ears] Restaure (Arg1) Vida, cura aumentada pelo número de sigilos negros possuídos."
  },
  Event_7359_Desc = {
    Text = "Você cedeu aos sussurros maliciosos em seu ouvido. Uma dor estridente, afiada como uma agulha, se entorta fundo em seu crânio.\n\n\"Para—por favor, para—fiz o que você pediu—faça parar—\"\n\nVocê aperta a cabeça em agonia, ouvindo apenas a risada distante e zombeteira dos corvos."
  },
  Event_7359_Name = {
    Text = "Canto dos Corvos"
  },
  Event_7360_ChoiceDesc1 = {
    Text = "[Catch a Crow] Ganhe 25 Sigilos Negros para cada Despertador Despertado."
  },
  Event_7360_ChoiceDesc2 = {
    Text = "[ Emitir Uivo ] Escolha 1 Despertador despertado e adicione os efeitos \"Inato\" e \"Manter\" ao seu card de Despertar."
  },
  Event_7360_Desc = {
    Text = "Você, de repente, sente vontade de brincar e agarra um corvo.\nEle luta desesperadamente em sua mão, até explodir em uma massa de água morna"
  },
  Event_7360_Name = {
    Text = "Canto dos Corvos"
  },
  Event_7361_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7361_Desc = {
    Text = "Você cobre os ouvidos e fecha os olhos.\nTum-tum, tum-tum... Seu coração bate em sincronia com os gritos, compondo uma caótica canção de morte.\nNesse momento, você sente uma paz inédita"
  },
  Event_7361_Name = {
    Text = "Canto dos Corvos"
  },
  Event_7362_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7362_Desc = {
    Text = "O domínio secreto está cheio de perigos, nem toda luz é um farol que guia o caminho.\nPode ser uma chama que atrai mariposas"
  },
  Event_7362_Name = {
    Text = "Luz noturna"
  },
  Event_7363_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7363_Desc = {
    Text = "\"Você já morreu há muito tempo e não pode voltar para Nosso Lar.\" Sua voz era fria Como Se fosse o vento com Sibilo no Campo de Neve de Ross. A expressão do viajante não mudou em nada, Como Se as coisas devessem ser assim. Ele agarrou sua mão novamente: \"Salve-me, por favor. Sou um soldado, com ordens de partir para o distante Oriente...\""
  },
  Event_7363_Name = {Text = "Devorador"},
  Event_7364_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7364_Desc = {
    Text = "O telégrafo está danificado. Imagine o desespero do proprietário na tempestade... igual ao seu agora"
  },
  Event_7364_Name = {
    Text = "Telegrama Silencioso"
  },
  Event_7365_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7365_Desc = {
    Text = "\"Vá em frente cinquenta jardas, vire à esquerda, depois vire à direita, e em seguida vire à esquerda...\nDepois continue até o fim, sua casa está lá.\"\nO viajante ficou muito feliz. Ele acenou para você e então se foi.\nVocê soltou um suspiro profundo e de repente sentiu alguém segurando sua mão. Ouvindo novamente aquela voz familiar:\n\"Por favor, me salve.\nSou um soldado, enviado para o distante Oriente...\""
  },
  Event_7365_Name = {Text = "Devorador"},
  Event_7366_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7366_Desc = {
    Text = "Você finalmente saiu deste labirinto. \nNaquele momento, você percebeu que o museu de cera era um ser vivo. \nToda a estranheza, beleza e crueldade estavam conectadas por um antigo ritual. \nE o olho do ritual era Rogers"
  },
  Event_7366_Name = {
    Text = "Labirinto dos Olhos"
  },
  Event_7367_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7367_Desc = {
    Text = "\"O papel é divertido, Guardião?\" Ramona puxa sua manga. \"A saída não está longe. Espero que você consiga manter esse humor na frente da Senhora Narciso.\""
  },
  Event_7367_Name = {
    Text = "Fragmento de Memória: Sonho Antigo"
  },
  Event_7368_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7368_Desc = {
    Text = "\"É difícil para um Despertar resistir à vontade do Conector,\" você respondeu, \"mas não vamos desistir.\""
  },
  Event_7368_Name = {
    Text = "Sua escolha"
  },
  Event_7369_ChoiceDesc1 = {
    Text = "[Entrar] Através da parede, mergulhe mais fundo."
  },
  Event_7369_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7369_Desc = {
    Text = "Você se aproxima da parede, que de repente se distorce, como se quisesse te engolir"
  },
  Event_7369_Name = {
    Text = "Espaço Distorcido"
  },
  Event_7370_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7370_Desc = {
    Text = "\"Não, isso não é verdade. Comparado com os baratas, vocês pelo menos têm corpos peludos. \n Ninguém pode recusar um corpo peludo.\" \n Os ratos cochicharam e finalmente concordaram relutantemente com seu ponto de vista. \n \"Bem, na verdade... não temos tanto pelo assim.\" \n Ser elogiado sempre é agradável. Antes de ir embora, os ratos lhe deram um pequeno presente."
  },
  Event_7370_Name = {Text = "Peste"},
  Event_7371_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7371_Desc = {
    Text = "\"Eu concordo! Humanos e ratos não podem coexistir!\"\nOs ratos pareciam um pouco irritados, mostrando suas presas brancas. \n\"Então por que você ainda está aqui? Pegue suas coisas e nunca mais volte.\""
  },
  Event_7371_Name = {Text = "Peste"},
  Event_7372_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7372_Desc = {
    Text = "Bem-vindo ao fundo do mar, onde cada passo traz uma pressão pesada.\n\nUma névoa caótica não translúcida esconde tudo, você conseguirá atravessar esse mar sombrio sob tamanha pressão?"
  },
  Event_7372_Name = {
    Text = "Sob a maré"
  },
  Event_7373_ChoiceDesc1 = {
    Text = "[Apenas dar uma Olhada] Remova 1 Carta"
  },
  Event_7373_ChoiceDesc2 = {
    Text = "[Take a closer look] Ganhe \"(RelicConfig.Arg1)\", inflija \"(Skill.Arg2)\""
  },
  Event_7373_Desc = {
    Text = "\"Clack…\"\nA máquina de escrever, como um velho bêbado que bebeu demais, hesitante, começa a expelir tinta negra.\nVocê captura rapidamente a palavra \"Mason\" e imediatamente puxa o papel da máquina."
  },
  Event_7373_Name = {
    Text = "Máquina de escrever"
  },
  Event_7374_ChoiceDesc1 = {
    Text = "[Eye Contact] Obter uma relíquia de ouro \"(RelicConfig.Arg1)\" e infectar \"(Skill.Arg2)\"."
  },
  Event_7374_ChoiceDesc2 = {
    Text = "[Fechar os Olhos] randomicamente desperta 2 despertadores, infecta duas vezes[(Skill.Arg1)]"
  },
  Event_7374_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7374_Desc = {
    Text = "Incontáveis olhos sussurram ao seu redor.\n\"Nós viajamos, paramos, avançamos por dezenas de milhares de anos ou mais.\nEnquanto o sol se apaga sob nosso olhar atento, enquanto a vida na Terra antiga é engolida por inundações.\nEstamos há muito tempo cativados pelos mistérios do universo.\""
  },
  Event_7374_Name = {Text = "olho"},
  Event_7375_ChoiceDesc1 = {
    Text = "[Seguir as Instruções] Aumente a Vida de Arg1"
  },
  Event_7375_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7375_Desc = {
    Text = "Você tentou usar o poder de retrocesso da chave de prata para encontrar o ponto de junção mais próximo, mas as informações que obteve estavam misturadas com anomalias difíceis de perceber, como se estivesse sendo interferido"
  },
  Event_7375_Name = {
    Text = "Contato Anômalo"
  },
  Event_7376_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7376_Desc = {
    Text = "Você gentilmente limpa a superfície da máquina de escrever com o lenço de linho padrão fornecido no traje de estudante mythag.\nA máquina de escrever voltou à calma. E quanto ao lenço sujo... que fique no domínio"
  },
  Event_7376_Name = {
    Text = "O Sussurro da Máquina de Escrever"
  },
  Event_7377_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7377_Desc = {
    Text = "Você olhou atentamente e viu um nome emergir das manchas de tinta sobrepostas, \"Fingal Johansen\".\nQuem é ele?"
  },
  Event_7377_Name = {
    Text = "O Sussurro da Máquina de Escrever"
  },
  Event_7378_ChoiceDesc1 = {
    Text = "[Look Up] Escolha 1 de 3 cartas de comando para ganhar Oração: \"(EnchantConfig.Arg1)\", e infecte com \"(Skill.Arg2)\""
  },
  Event_7378_ChoiceDesc2 = {
    Text = "[Ângulo do Sol?] Escolha despertar 1 despertador, infecção[(Skill.Arg1)]"
  },
  Event_7378_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7378_Desc = {
    Text = "'Agora, olhe imediatamente para o sudeste, o ângulo do sol está em sua posição.' A ordem de Do, transmitida pelo comunicador"
  },
  Event_7378_Name = {
    Text = "Ângulo de elevação"
  },
  Event_7379_ChoiceDesc1 = {
    Text = "[Infection\"(Skill.Arg1)\", Ganhar Relíquia de Ouro \"(RelicConfig.Arg2)\"]"
  },
  Event_7379_ChoiceDesc2 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7379_Desc = {
    Text = "Evento 354 (em desenvolvimento), não é o efeito final"
  },
  Event_7379_Name = {
    Text = "Evento 354 (em desenvolvimento)"
  },
  Event_7380_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7380_Desc = {
    Text = "As vozes das crianças fluem das teclas do piano. \n\"Velho Charlie tinha um gato malhado que amava...\" \nSob o canto das crianças, uma jovem mulher também canta suavemente. \nVocê ouviu errado?"
  },
  Event_7380_Name = {
    Text = "Melodia da Infância"
  },
  Event_7381_ChoiceDesc1 = {
    Text = "[Vire-se] Ganhe 25 sigilos negros"
  },
  Event_7381_ChoiceDesc2 = {
    Text = "[Keep Going] Obtenha uma Relíquia de Prata \"(RelicConfig.Arg1)\" e infecte \"(Skill.Arg2)\""
  },
  Event_7381_Desc = {
    Text = "Passos se aproximavam por trás.\nComo uma sombra, nem rápido nem devagar.\nSeus passos se entrelaçavam com os seus, ecoando na sala vazia"
  },
  Event_7381_Name = {Text = "Oxford"},
  Event_7382_ChoiceDesc1 = {
    Text = "[Dobrar a Carta] Remova 2 Cartões"
  },
  Event_7382_ChoiceDesc2 = {
    Text = "[Salvar Cartas] Obtenha uma relíquia amaldiçoada \"(RelicConfig.Arg1)\" e fique infectado com \"(Skill.Arg2)\"."
  },
  Event_7382_ChoiceDesc3 = {
    Text = "[Leave] Ganhar Arg1 sigilos negros"
  },
  Event_7382_Desc = {
    Text = "Uma nova máquina de escrever. \n Ela tem teclas únicas, tão elegantes e precisas quanto um microscópio. \n Você está absorto em sua perfeita estrutura mecânica, e a tinta negra aparece de repente. \n \"Prezado Senhor Rogers, \n É com grande pesar que informamos que você foi expulso da academia. \n Como é de conhecimento geral, a @2 academia sempre foi conhecida por sua rigorosa atitude acadêmica dentro do reino, e aqueles rumores chocantes @3 têm causado grande inquietação...\""
  },
  Event_7382_Name = {
    Text = "Como se estivéssemos frente a frente"
  },
  Event_7383_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7383_Desc = {
    Text = "O relógio parado à distância parece uma urgência, lembrando vocês de não se perderem na armadilha do tempo"
  },
  Event_7383_Name = {Text = "Seu olhar"},
  Event_7384_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7384_Desc = {
    Text = "Gotas de lama negra caem no seu rosto, causando uma coceira.\nVocê não aguenta e afasta a borboleta.\nA borboleta escapa e desaparece silenciosamente"
  },
  Event_7384_Name = {
    Text = "Borboleta de Líquido Preto"
  },
  Event_7385_ChoiceDesc1 = {
    Text = "[Observar Cuidadosamente]"
  },
  Event_7385_ChoiceDesc2 = {Text = "[Dig]"},
  Event_7385_Desc = {
    Text = "Kum carregava vocês três pelo sanatório procurando uma entrada.\nDe repente, ela parou bruscamente, quase derrubando vocês.\nEnquanto vocês questionavam, Kum abaixou a cabeça, farejando o solo macio, e indicou com a cabeça, como se algo estivesse enterrado abaixo"
  },
  Event_7385_Name = {
    Text = "Objeto enterrado"
  },
  Event_7386_ChoiceDesc1 = {
    Text = "[Receive] Escolha 1 entre 3 relíquias de ouro"
  },
  Event_7386_Desc = {
    Text = "Ali não há nada, o líquido negro flui pelo chão, não refletindo nada.\nÉ uma ilusão sua? Você sente algo escapando pelos dedos"
  },
  Event_7386_Name = {
    Text = "Sob a superfície do espelho"
  },
  Event_7387_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7387_Desc = {
    Text = "As asas negras caem no solo úmido da viela, transformando-se em lodo negro de dissolução"
  },
  Event_7387_Name = {
    Text = "Enxame de corvos agitados"
  },
  Event_7388_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7388_Desc = {
    Text = "\"A Srta. Narciso vai apreciar seu humor.\" Ramona acenou, e o fantasma se dissipou. \"Não deixe que você se torne o preço da viagem dimensional.\""
  },
  Event_7388_Name = {
    Text = "Fragmento de Memória: Sonho Antigo"
  },
  Event_7389_ChoiceDesc1 = {
    Text = "[Receive] Escolha 1 entre 3 relíquias de ouro"
  },
  Event_7389_Desc = {
    Text = "Oh, sim, aquele reflexo odioso é você.\nA malícia jorra e se mistura com a lama negra aos seus pés, dançando distorcidamente. Se não se importar, ela quer subir em seu ombro"
  },
  Event_7389_Name = {
    Text = "Sob a superfície do espelho"
  },
  Event_7390_ChoiceDesc1 = {
    Text = "[Stand Still] Ganhe 25 Os Sigilos Negros"
  },
  Event_7390_ChoiceDesc2 = {
    Text = "[Walk Casually] Obtenha uma Relíquia de Prata \"(RelicConfig.Arg1)\", e infectar \"(Skill.Arg2)\""
  },
  Event_7390_Desc = {
    Text = "Você esmaga sua sombra e cai em uma poça de escuridão.\nA sombra quebrada e dispersa é a única coisa que o conecta ao mundo perdido.\nVocê realmente quer caminhar no pesadelo escuro? Você ainda não encontrou seu caminho"
  },
  Event_7390_Name = {
    Text = "Andarilho de Pesadelos"
  },
  Event_7391_ChoiceDesc1 = {
    Text = "[Buscando a Fonte] Obtenha a relíquia de prata \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7391_ChoiceDesc2 = {
    Text = "[Reproduzir Disco] Todas as Entidades recuperam 50 de loucura, Infecte[(Skill.Arg1)]"
  },
  Event_7391_ChoiceDesc3 = {
    Text = "[Remove the Phonograph] Obtenha uma Oração com 3 escolhas"
  },
  Event_7391_Desc = {
    Text = "Você encontra um antigo fonógrafo empoeirado. \n Depois de dar corda, você coloca a agulha sobre o disco de vinil cheio de arranhões, a sinfonia distorcida soa como o rasgar de uma fita adesiva, os instrumentos de sopro e corda se agredindo mutuamente, sem que nenhuma parte consiga escapar ilesa dessa música. \n No final chiado da melodia, você ouve uma série de batidas rítmicas. \n \"Tum tum... tum tum tum... tum...\" \n Você franze a testa e afasta a agulha, mas o som das batidas continua inalterado."
  },
  Event_7391_Name = {
    Text = "Rastro Misterioso"
  },
  Event_7392_ChoiceDesc1 = {
    Text = "[Examinando o Brilho] transforma 1 relíquia em relíquia amaldiçoada[(RelicConfig.Arg1)]"
  },
  Event_7392_ChoiceDesc2 = {
    Text = "[Touch the Light] Obtenha Relíquia de Prata \"(RelicConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7392_ChoiceDesc3 = {
    Text = "[Vire e Saia] Ganhe 25 sigilos negros"
  },
  Event_7392_Desc = {
    Text = "Sob a visão do mergulho fantasmal, a névoa do domínio vê a realidade envolta em um manto escuro. Tudo ao seu redor é vago, quase inexistente.\nNo neblinoso, a luz de algo penetra a névoa. Como um farol para um barco, a fumaça para uma criança perdida, guiando em direção à segurança"
  },
  Event_7392_Name = {
    Text = "Luz noturna"
  },
  Event_7393_ChoiceDesc1 = {
    Text = "[Pause the music] eleva 1 relíquia de prata para relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_7393_ChoiceDesc2 = {
    Text = "[Talking with It] Obtenha uma relíquia de ouro \"(RelicConfig.Arg1)\" e fique infectado com \"(Skill.Arg2)\" e \"(Skill.Arg3)\"."
  },
  Event_7393_ChoiceDesc3 = {
    Text = "[Listen Quietly] Ganhar 25 sigilos negros"
  },
  Event_7393_Desc = {
    Text = "Você pegou algumas memórias fragmentadas de uma lama negra.\nCristais brilhantes com fios flutuantes dentro, fragmentos de memória como areia ao vento, flutuando no ar.\nImagens caóticas e bizarras surgem ao seu redor.\nVocê olha para—\n"
  },
  Event_7393_Name = {
    Text = "Fragmento de Lua de Prata"
  },
  Event_7394_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7394_Desc = {
    Text = "Você estendeu a mão para pegar alguns flocos de neve, e ao olhar de perto, percebeu que as gotas que se formaram não eram cristalinas, mas sim uma densa e escura goma de dissolução"
  },
  Event_7394_Name = {Text = "Neve"},
  Event_7395_ChoiceDesc1 = {
    Text = "[Não estou na superfície] Aprimore aleatoriamente 1 relíquia de prata para uma relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_7395_ChoiceDesc2 = {
    Text = "[Look Down] Obtenha uma Relíquia Prata \"(RelicConfig.Arg1)\" e torne-se infectado com \"(Skill.Arg2)\""
  },
  Event_7395_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7395_Desc = {
    Text = "A névoa se dissipa, e uma mão magra se estende em sua direção. \n Ela parece ter sido corroída de carne e sangue, a palma irregular coberta por uma pasta negra e viscosa, enquanto seu corpo está adornado com anéis e colares que brilham com luz dourada. \n Ela faz um gesto com a mão, como se estivesse te chamando para se aproximar. \n Somente sob a sombra da crise, os tesouros parecem brilhar ainda mais."
  },
  Event_7395_Name = {
    Text = "Inverter as Garras do Mal"
  },
  Event_7395_Tips1 = {
    Text = "Ainda não possui relíquia de prata"
  },
  Event_7396_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7396_Desc = {
    Text = "O fantasma acenou para você e então desapareceu, deixando apenas o frio gelo e as imensas montanhas"
  },
  Event_7396_Name = {
    Text = "Fantasma vulcânico"
  },
  Event_7397_ChoiceDesc1 = {
    Text = "[Funeral da Lua Prateada] escolha uma relíquia para transformar em relíquia amaldiçoada[(RelicConfig.Arg1)]"
  },
  Event_7397_ChoiceDesc2 = {
    Text = "[Oração da Lua Prateada] Obtenha uma relíquia de prata \"(RelicConfig.Arg1)\", e infecte \"(Skill.Arg2)\""
  },
  Event_7397_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7397_Desc = {
    Text = "Você pegou algumas memórias fragmentadas de uma lama negra.\nCristais brilhantes com fios flutuantes dentro, fragmentos de memória como areia ao vento, flutuando no ar.\nImagens caóticas e bizarras surgem ao seu redor.\nVocê olha para—"
  },
  Event_7397_Name = {
    Text = "Fragmento de Lua de Prata"
  },
  Event_7398_ChoiceDesc1 = {
    Text = "[Reabastecer] Obtenha Oração com 3 escolhas"
  },
  Event_7398_ChoiceDesc2 = {
    Text = "[Extinguish It] Escolher 1 de 3 cartas de comando para ganhar Oração: \"(EnchantConfig.Arg1)\", e infectar \"(Skill.Arg2)\""
  },
  Event_7398_Desc = {
    Text = "\"Eu sou a sombra da criada que foi assassinada, e o assassino é aquela chama verde enganadora.\"\nA chama levemente vermelha balançava, acusando você.\n\"Eu uma vez vivi à beira do lago que refletia a lua encorpada, gloriosa e radiante.\""
  },
  Event_7398_Name = {Text = "Fogo fraco"},
  Event_7399_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7399_Desc = {
    Text = "Você e a sombra estavam sob o poste de luz, sem dizer uma palavra.\nNão havia lua esta noite, todas as casas estavam silenciosas.\nVocê acenou para a sombra e se virou para ir embora"
  },
  Event_7399_Name = {
    Text = "A sombra sob o poste de luz"
  },
  Event_7400_ChoiceDesc1 = {
    Text = "[Afastar corvos] Obtenha Arg1 sigilo negro, infectar [(Skill.Arg2)], continue a escolher"
  },
  Event_7400_ChoiceDesc2 = {
    Text = "[Ignorar] Saia"
  },
  Event_7400_Desc = {
    Text = "O corvo pousou na cabeceira da cama, olhando para você com olhos vermelhos"
  },
  Event_7400_Name = {
    Text = "Lanterna Corvo Preto"
  },
  Event_7401_ChoiceDesc1 = {
    Text = "[Say No Wallet] Ganhe Oração de 3 escolhas"
  },
  Event_7401_ChoiceDesc2 = {
    Text = "[Romper a rede] 1 Carta de comando aleatória obtém Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7401_Desc = {
    Text = "Uma teia amarelo-alaranjada flutua silenciosamente no ar, seus buracos esparsos muito menos intrincados do que os de seus parentes aranhas que fazem ninho na parede.\nVocê não consegue resistir em estender a mão; a frágil teia se dissolve instantaneamente, e risadas de crianças ecoam em seus ouvidos.\n\"Ouro, prata, amarelo, vermelho, todas as carteiras são nossas!\""
  },
  Event_7401_Name = {
    Text = "Rede errante"
  },
  Event_7402_ChoiceDesc1 = {
    Text = "[Repair Telegraph] Infecte com \"(Skill.Arg1)\", conceda aleatoriamente 1 Cartão de Comando uma Oração: \"(EnchantConfig.Arg2)\""
  },
  Event_7402_ChoiceDesc2 = {
    Text = "[Enterrar o Telégrafo] Infectar \"(Skill.Arg1)\", conceder aleatoriamente uma oração a 1 cartão de comando: \"(EnchantConfig.Arg2)\""
  },
  Event_7402_ChoiceDesc3 = {
    Text = "[Desconsiderar] Escolha 1 carta entre 3 cartas de comando para ganhar um selo:[(EnchantConfig.Arg1)]"
  },
  Event_7402_Desc = {
    Text = "Você se esconde em uma fenda na caverna para evitar a tempestade. Mas sabe que não pode ficar muito tempo, se os homens de preto te encontrarem, não terá para onde fugir. \nNo canto da fenda, você encontra um telégrafo quebrado"
  },
  Event_7402_Name = {
    Text = "Relíquias dos antigos"
  },
  Event_7403_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7403_Desc = {
    Text = "Você viu retratos assim em muitos lugares do reino.\n\"A Rainha\" no centro, brilhando entre rosas negras.\nExceto por um detalhe—seu rosto foi cruelmente arrancado, deixando um buraco negro queimado.\nVocê ainda não viu o verdadeiro rosto da rainha"
  },
  Event_7403_Name = {
    Text = "Galeria de Retratos"
  },
  Event_7404_ChoiceDesc1 = {
    Text = "[Poupe-a] Obtenha a relíquia amaldiçoada \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7404_ChoiceDesc2 = {
    Text = "[Ajudá-la] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_7404_ChoiceDesc3 = {
    Text = "[Vou Caminhar Meu Próprio Caminho] Ganhe 50 Sigilos Negros"
  },
  Event_7404_Desc = {
    Text = "Três figuras bloquearam seu caminho. \n \"Você pode poupá-la,\" disse a figura segurando um ursinho coberto de lama corrosiva, \"ela apenas é tímida, não maligna. Ela não quer machucar ninguém.\" \n \"Você pode ajudá-la,\" disse a figura segurando uma embalagem requintada de doces, \"você pode fazer o que ela não consegue, você pode acabar com tudo isso.\" \n \"Você não precisa nos ouvir,\" disse a figura com as mãos vazias, \"você tem seu próprio caminho.\""
  },
  Event_7404_Name = {
    Text = "Caminho bifurcado"
  },
  Event_7405_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7405_Desc = {
    Text = "A voz de Daffodil pausou por um momento.\n\"Oh, você escolheu isso? Uma excelente escolha. Como recompensa, vou te dar um presente especial.\"\n\"Não estou familiarizada com aquela criança, mas tenho uma conjectura sobre Francis. Acredito que a emoção que a domina e lhe concede o poder de 'ver' é um intenso arrependimento. Pergunto-me que escolha ela fará em relação a esse arrependimento...\""
  },
  Event_7405_Name = {
    Text = "Tempo de dica"
  },
  Event_74068_ChoiceDesc1 = {
    Text = "<PowerIconKeywords:Incluir no cérebro> Coloque o \"Cérebro de reserva\" no baralho de puxar."
  },
  Event_74068_Desc = {
    Text = "Dentro do arco esculpido e complexo, nas telhas inclinadas da parede externa de tijolos vermelhos, diante da abertura na parede da casa, sombras alongadas dançam, ansiando por respostas. \nA mediocridade significa morte? \nEstar satisfeito com a situação significa que a chama se apagará?"
  },
  Event_74068_Name = {
    Text = "Consciência que ainda não se perdeu"
  },
  Event_74069_ChoiceDesc1 = {
    Text = "<PowerIconKeywords:Continuar容纳> Escolha até 2 cartas de instrução para remover do baralho e coloque-as no \"Cérebro de reserva\"."
  },
  Event_74069_Desc = {
    Text = "\"Eu os vi. Muitas pessoas, muitos murmúrios de sonhos, sábias, superficiais, racionais, loucas. Às vezes, até mesmo centelhas de esperança nascem das cinzas.\""
  },
  Event_74069_Name = {
    Text = "Consciência que ainda não se perdeu"
  },
  Event_7406_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7406_Desc = {
    Text = "Você cuidadosamente retira o rato da balança. Ele respira suavemente, e seu corpo peludo aquece sua palma"
  },
  Event_7406_Name = {
    Text = "Razão e Emoção"
  },
  Event_7407_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7407_Desc = {
    Text = "O núcleo de prata apagado brilhou intensamente por um momento, mas desapareceu em um instante, deixando apenas cinzas indistinguíveis do solo na mão.\nO núcleo de prata esgotou sua última Gnosis, a alma desconhecida não conseguiu reconstruir o corpo, mas antes de desaparecer completamente, deixou um vestígio de sua existência"
  },
  Event_7407_Name = {
    Text = "Prova de Existência"
  },
  Event_7408_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7408_Desc = {
    Text = "『Eu não conheço bem aquela criança, mas tenho uma teoria sobre Francis. Acho que a emoção que a domina e lhe dá o poder de 'ver' é um forte arrependimento. Não sei que escolha ela fará por causa desse arrependimento...』"
  },
  Event_7408_Name = {
    Text = "Tempo de dica"
  },
  Event_7409_ChoiceDesc1 = {
    Text = "[Puxe o papel] Remova 1 Cartão"
  },
  Event_7409_ChoiceDesc2 = {
    Text = "[Not the right time] Ganhe \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7409_Desc = {
    Text = "A máquina de escrever portátil dentro da mala de repente começou a digitar sozinha, produzindo meia página de texto torto.\n \"Você a viu. Ela está bem ao seu lado—essas sombras manchadas por loucura e zelo... Não olhe diretamente para sua silhueta.\""
  },
  Event_7409_Name = {
    Text = "Aviso Não Convidado"
  },
  Event_7410_ChoiceDesc1 = {
    Text = "[Go Left] Escolha 1 de 3 cartas de comando para ganhar uma oração: \"(EnchantConfig.Arg1)\", e infecte \"(Skill.Arg2)\""
  },
  Event_7410_ChoiceDesc2 = {
    Text = "[Ande para a direita] escolhe despertar 1 despertador, infecta[(Skill.Arg1)]"
  },
  Event_7410_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7410_Desc = {
    Text = "Você parece estar em um labirinto.\nEsquerda, direita, esquerda de novo... Você perde a paciência até olhar para cima e ver aquele olho.\nO olho te observa, calmo e majestoso, como se fosse o mestre aqui"
  },
  Event_7410_Name = {
    Text = "Labirinto dos Olhos"
  },
  Event_7411_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7411_Desc = {
    Text = "Você puxa as mãos com força e ouve claramente o som de ossos quebrando.\nEste é o preço da sua curiosidade"
  },
  Event_7411_Name = {
    Text = "Inspiração súbita"
  },
  Event_7412_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7412_Desc = {
    Text = "Você inspecionou a câmera cuidadosamente, o couro e o ouro negro embutidos no corpo refletiam um brilho oleoso.\nA lente estava apontada para você, como se estivesse observando, espiando"
  },
  Event_7412_Name = {
    Text = "Registro de inocência"
  },
  Event_7413_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7413_Desc = {
    Text = "Você puxou o resto do filme sem piedade. Ele estava escondido na câmera, e a imagem te deixou sem palavras.\nO filme não revelado mostrava você caído em uma poça de piche"
  },
  Event_7413_Name = {
    Text = "Registro de inocência"
  },
  Event_74145_ChoiceDesc1 = {
    Text = "[Ler] Remover 1 cartão de comando e ganhar 25 O Sigilo Negro."
  },
  Event_74145_ChoiceDesc2 = {
    Text = "[Continuar digitando] Copie uma carta do baralho, infecte [(Skill.Arg1)]"
  },
  Event_74145_Desc = {
    Text = "A impressora jorra tinta furiosamente.\nA tinta negra, como um fantasma, irrompe do bico e se espalha pelo ar, formando uma névoa intensa e opressiva.\nParece haver alguma insinuação escondida no teclado, à espera de que um dedo inocente a toque."
  },
  Event_74145_Name = {
    Text = "Tinta fantasma"
  },
  Event_74146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74146_Desc = {
    Text = "Você se vira e entra na viela escura, a névoa roendo as pontas de suas roupas, mas aquela sombra se divide em inúmeras pares de olhos atrás de você. O som do sino enferrujado envolve os presságios úmidos.\n\nVocê sabe que todos os caminhos tortuosos acabarão desmoronando em um casulo cíclico — antes do amanhecer podre, você e seu reflexo finalmente se reencontrarão."
  },
  Event_74146_Name = {
    Text = "Cinzas do tempo"
  },
  Event_74147_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74147_Desc = {
    Text = "Você desenha silenciosamente um contorno no peito, oferecendo uma oração muda pelo falecido. \nNeste mundo em ruínas, há muitas coisas que você não consegue salvar. \nOs ossos brilham, e um dos tesouros preciosos que seu antigo dono guardava aparece parcialmente."
  },
  Event_74147_Name = {
    Text = "Ossos Desbotados"
  },
  Event_74148_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74148_Desc = {
    Text = "\"O Pai Divino reconhece sua compaixão. O Pai nos protegerá e nos redimirá do fardo do sofrimento.\"\n\nA imagem dela foi desaparecendo gradualmente, e os sons sagrados se transformaram em ventos implacáveis que sopraram sem piedade."
  },
  Event_74148_Name = {
    Text = "Oração do Órgano"
  },
  Event_74149_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74149_Desc = {
    Text = "Você empurra suavemente os ossos expostos, que natural e lentamente afundam no líquido negro, desaparecendo sem deixar vestígios.\nQue a alma encontre descanso no nada.\n\n."
  },
  Event_74149_Name = {
    Text = "Ossos Desbotados"
  },
  Event_7414_ChoiceDesc1 = {
    Text = "[Leave] Você derrotou o oponente, e nada aconteceu."
  },
  Event_7414_Desc = {
    Text = "\"Parece que a pequena precisa aprender da maneira mais difícil que os segredos de uma mulher não são tão facilmente revelados.\" \nÀ medida que as palavras de Narciso se desvanecem, um enorme monstro aparece diante de você."
  },
  Event_7414_Name = {
    Text = "Tempo de dica"
  },
  Event_74150_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74150_Desc = {
    Text = "Não deveria haver brinquedos doentios na torre do sino onde o pequeno rato se esconde; esse som vem da sua mente, da sua memória. \n Você se lembra da sensação que teve quando era um Cérebro em um Tanque, da corrente elétrica transformada em ondas sonoras. \n O barulho anômalo gradualmente se torna normal e suave, transformando-se em uma melodia clássica fluida, que toca em sua mente em um ciclo."
  },
  Event_74150_Name = {
    Text = "Estranhos Sons da Torre do Relógio"
  },
  Event_74151_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74151_Desc = {
    Text = "Aquilo não é um gato... são os agitados Portadores de lanternas.\n Sob o véu negro transparece ódio e hostilidade, e sussurros arranham sua consciência, trazendo visões estranhas e inexplicáveis."
  },
  Event_74151_Name = {
    Text = "O sussurro do gato"
  },
  Event_74152_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74152_Desc = {
    Text = "Eles agarraram seus sapatos, seus tornozelos, são gananciosos, desejosos, querem arrastá-lo para o abismo em que estão. \nVocê se esforça para se livrar, mantém a postura, dá alguns passos para trás na tentativa de escapar. \nSem querer, algo caiu.\n\n."
  },
  Event_74152_Name = {
    Text = "Reflexo de Pesadelo"
  },
  Event_74153_ChoiceDesc1 = {
    Text = "[Desviar] Ganhar uma escolha de 3 Orações"
  },
  Event_74153_ChoiceDesc2 = {
    Text = "[Stop] Escolha 1 carta de 3 Cartas de Comando para ganhar uma Oração: \"(EnchantConfig.Arg1)\", e infecte com \"(Skill.Arg2)\"."
  },
  Event_74153_Desc = {
    Text = "Imagens que parecem familiares fazem seus nervos pularem, se contorcerem, cheios de medo. \n \"Mais uma vez...\" \n Um pesadelo desumano chega, uma imensa sensação de impotência envolve você. \n Você realmente não pode reescrever o destino dela? \n Não há mais tempo, na cabeça partida de Sara, uma enorme boca brilhante aguarda para te morder, devorar e mastigar."
  },
  Event_74153_Name = {
    Text = "Pesadelo Recorrente"
  },
  Event_74154_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74154_Desc = {
    Text = "Você ouve murmúrios perturbadores.  \n\n\"Viemos das montanhas e pântanos das estrelas distantes. Nossos corpos são o pavio e o combustível da lâmpada, acenderemos a fogueira que vem da terra, iluminando o caminho suave para um novo mundo.\""
  },
  Event_74154_Name = {
    Text = "O sussurro do gato"
  },
  Event_74155_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74155_Desc = {
    Text = "Pôr do sol, torre do relógio, pássaros voando…\nA garota retira a venda dos olhos e seu olhar com pupilas acinzentadas te paralisa no lugar.\nA ilusão se desvanece como uma miragem, mas a preocupação persiste, recusando-se a desaparecer."
  },
  Event_74155_Name = {
    Text = "Máscara branca"
  },
  Event_74156_ChoiceDesc1 = {
    Text = "[Pick Up] Receba 3 escolha 1 Relíquia de Prata"
  },
  Event_74156_ChoiceDesc2 = {
    Text = "[Recall] Obtenha relíquias de prata \"(RelicConfig.Arg1)\" \"(RelicConfig.Arg2)\", contraia duas vezes com \"(Skill.Arg3)\""
  },
  Event_74156_Desc = {
    Text = "No limo viscoso do corredor, jazia um pequeno tapa-olho branco. \nA memória agarrou seu coração."
  },
  Event_74156_Name = {
    Text = "Máscara branca"
  },
  Event_74157_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74157_Desc = {
    Text = "Uma palma transparente dança livremente nas teclas brancas e pretas, mas as ondas sonoras que surgem são fragmentadas, como uma caixa de música desafinada, cada nota emitindo um lamento dissonante, como um pedido de socorro em sofrimento. \nPor fim, a execução termina abruptamente em um acorde de desespero. \nO que não foi alcançado em vida, neste momento, deixa apenas um sentimento de nostalgia."
  },
  Event_74157_Name = {
    Text = "Sonata de Arrependimento"
  },
  Event_74158_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74158_Desc = {
    Text = "\"Prezada Senhora Sara:\nEu solicito a minha demissão do cargo de ajudante de enfermagem da Casa de pobres.\nEu já não concordo com suas ideias. Seu ensinamento está errado, as crianças do Distrito Leste não deveriam crescer sob sua proteção, não deveriam acreditar na pura bondade e na doação altruísta.\nUm dia, elas terão que sair de suas asas para aprender as regras de sobrevivência do Distrito Leste.\n\n……\"\n\nAs letras seguintes foram manchadas por um líquido preto, tornando-se ilegíveis."
  },
  Event_74158_Name = {
    Text = "Tinta fantasma"
  },
  Event_74159_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74159_Desc = {
    Text = "\"Eu só posso oferecer às crianças um telhado para se proteger da chuva e uma refeição que evite a morte por fome. Se não fosse pelo médico chamado pelo bondoso Sr. Rogers, elas não teriam nem mesmo um comprimido quando adoecem. \n Eu não li muitos livros, e tudo o que posso fazer é garantir que elas não congelem ou morram de fome nas ruas. \n Eu nunca interfiri no que as crianças deveriam se tornar, mas elas precisam sobreviver. \n…\""
  },
  Event_74159_Name = {
    Text = "Tinta fantasma"
  },
  Event_7415_ChoiceDesc1 = {
    Text = "[explorar a origem] ganha relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_7415_ChoiceDesc2 = {
    Text = "[Descartar carta] escolher 1 entre 3 cartas de comando para obter uma oração:[(EnchantConfig.Arg1)]"
  },
  Event_7415_ChoiceDesc3 = {
    Text = "[Check Letter] Ganhe 50 Sigilos Negros"
  },
  Event_7415_Desc = {
    Text = "Outra carta caiu na sua frente, o papel de carta rasgado fez seu coração afundar; você levantou o papel. \n \"Ele voltou! Aquilo que eu previ não eram palavras vazias! @4 aqui começa e aqui também termina.\" \n \"Eu quero fugir... me encolhi dentro do armário, minha mão tremia incontrolavelmente, mas o som do corpo pegajoso batendo no chão se aproximava... Eu ouvi um nome! É ele! @5!\""
  },
  Event_7415_Name = {
    Text = "Outra carta de pedido de socorro"
  },
  Event_74160_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74160_Desc = {
    Text = "\"Obrigado, o poder criador do Pai Deus finalmente moldará nossas formas, trazendo-nos luz e fogo eternos. \n\n Quando eu chegar ao fim, abençoarei você diante do Pai Deus.\"\n\n A imagem dela foi desaparecendo gradualmente, e os sons sagrados se transformaram em ventos implacáveis que sopraram sem piedade."
  },
  Event_74160_Name = {
    Text = "Oração do Órgano"
  },
  Event_74161_ChoiceDesc1 = {
    Text = "[Enterro] Restaure a Vida Arg2[ExDesc1], selecione e exclua 1 Carta de comando."
  },
  Event_74161_ChoiceDesc2 = {
    Text = "[Pray] Obtenha a Criação de ouro \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_74161_Desc = {
    Text = "Um pedaço de ossada pálida, metade submersa no lodo negro."
  },
  Event_74161_Name = {
    Text = "Ossos Desbotados"
  },
  Event_74162_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74162_Desc = {
    Text = "Você avança diretamente para a névoa, e as ilusões se enrolam em seu corpo como teias de aranha, a sensação fria penetra em sua medula. \n Seus sussurros se transformam em fragmentos de memória, perfurando seu peito. \n Ao atravessar, atrás de você só resta o nada, enquanto à frente, mais sombras vagas começam a emergir da névoa espessa, esperando para devorar."
  },
  Event_74162_Name = {
    Text = "Cinzas do tempo"
  },
  Event_74163_ChoiceDesc1 = {
    Text = "[Evitar Fantasma] Receber Relíquia de Ouro \"(RelicConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_74163_ChoiceDesc2 = {
    Text = "[Atravesse o Fantasma] ganhe 3 seleções de relíquia de ouro, infecção[(Skill.Arg1)]"
  },
  Event_74163_ChoiceDesc3 = {
    Text = "[Sair] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_74163_Desc = {
    Text = "A névoa é como um pesado manto, cobrindo as ruas, cada passo parece pisar nas cinzas do tempo.\nAo longe, duas sombras indistintas aparecem e desaparecem na neblina, como fantasmas do passado, sussurrando histórias que já foram esquecidas.\nA imaginação descontrolada novamente transforma-se em sombras aterradoras, elas se distorcem e se propagam, como presságios do futuro, dificultando sua respiração.\nVocê sabe que o caminho à frente só se tornará mais sombrio, mas seus passos não podem e não devem parar."
  },
  Event_74163_Name = {
    Text = "Cinzas do tempo"
  },
  Event_74164_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74164_Desc = {
    Text = "Você mal consegue desviar do primeiro ataque rápido de Sarah.\nAgora, talvez não tenha tanta sorte assim."
  },
  Event_74164_Name = {
    Text = "Pesadelo Recorrente"
  },
  Event_74165_ChoiceDesc1 = {
    Text = "[Indicate Direction] Obtenha Relíquia de prata \"(RelicConfig.Arg1)\", e contrate \"(Skill.Arg2)\""
  },
  Event_74165_ChoiceDesc2 = {
    Text = "[Pray Together] Receba 3 escolha 1 Oração"
  },
  Event_74165_Desc = {
    Text = "O som do piano e do órgão se entrelaçam no vento cinzento. Uma melodia mágica flutua pelas ruas desertas.  \nUma freira anônima reza com a música.  \n\"Uma oração simples não precisa de rituais solenes, o grande Pai nos enviará esperança, assim como ele nos deu os ensinamentos piedosos.\""
  },
  Event_74165_Name = {
    Text = "Oração do Órgano"
  },
  Event_74166_ChoiceDesc1 = {
    Text = "[Esquivar o monstro] selecione 1 relíquia para transformar em relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_74166_ChoiceDesc2 = {
    Text = "[Pegar Estrelas] Ganhe uma Relíquia de Prata \"(RelicConfig.Arg1)\" e fique infectado com \"(Skill.Arg2)\""
  },
  Event_74166_ChoiceDesc3 = {
    Text = "[Ignorar] Ganhe 25 O Sigilo Negro"
  },
  Event_74166_Desc = {
    Text = "A cortina de meteoros cai sobre a torre do relógio.  \nUma cristal translúcido cai exatamente ao seu lado, criando uma pequena cratera.  \nVocê ainda está cercado, os corpos dissolutos de formas variadas parecem sombras distorcidas, os rugidos e gritos não cessam.  \nVocê decide —"
  },
  Event_74166_Name = {
    Text = "Estrela caída"
  },
  Event_74167_ChoiceDesc1 = {
    Text = "[Rub Eyes] Receba 50 O sigilo negro"
  },
  Event_74167_ChoiceDesc2 = {
    Text = "[Fechar os Olhos] ganha 75 sigilos negros, infecção[(Skill.Arg2)]"
  },
  Event_74167_Desc = {
    Text = "Enxames de gatos negros de aparência repulsiva se aglomeram atrás de Yvette, murmurando em tons desconhecidos e emanando uma ameaça maliciosa e secreta."
  },
  Event_74167_Name = {
    Text = "O sussurro do gato"
  },
  Event_74168_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74168_Desc = {
    Text = "O tecido barato é um pouco áspero ao toque, mas foi cuidadosamente lavado e limpo.\nGuarde-o bem, esperando o dia em que possa ser devolvido ao seu dono."
  },
  Event_74168_Name = {
    Text = "Máscara branca"
  },
  Event_74169_ChoiceDesc1 = {
    Text = "[Maintain Distance] Ganhe 25 O Sigilo Negro"
  },
  Event_74169_ChoiceDesc2 = {
    Text = "[Mostrar Misericórdia] Ganhe uma Relíquia de Prata \"(RelicConfig.Arg1)\" e fique infectado com \"(Skill.Arg2)\""
  },
  Event_74169_Desc = {
    Text = "Eles surgem em multidão aos seus pés.\nEm seus rostos de dor indistintos, você vê o reflexo de sua própria sombra distorcida.\nVocê realmente tem o privilégio de julgá-los?\n\n?"
  },
  Event_74169_Name = {
    Text = "Reflexo de Pesadelo"
  },
  Event_7416_ChoiceDesc1 = {
    Text = "[Descarte os pedaços] Possui uma relíquia especial, infecte um sintoma com o sigilo:[(EnchantConfig.Arg1)] - sintomas: loucura por dissolução"
  },
  Event_7416_ChoiceDesc2 = {
    Text = "[Complete the Fragments] Sem Relíquia especial, infectado com \"(Skill.Arg1)\", ganhe infecção \"(Skill.Arg2)\""
  },
  Event_7416_Desc = {
    Text = "Os membros pálidos se contorcem lentamente diante de você, ela se inclina e estende o braço quebrado para você, seus olhos semicerrados de dor derramam lágrimas de gesso branco.\n\"Falta... só mais um pedaço, eu posso...\""
  },
  Event_7416_Name = {
    Text = "Completar o corpo danificado"
  },
  Event_74170_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74170_Desc = {
    Text = "Você deve tentar salvá-los.\nMas não deixe que o absorvam."
  },
  Event_74170_Name = {
    Text = "Reflexo de Pesadelo"
  },
  Event_74171_ChoiceDesc1 = {
    Text = "[Desviar o Olhar] Aumentar a Saúde Máxima em Arg1"
  },
  Event_74171_ChoiceDesc2 = {
    Text = "[Manter o Olhar] 1 Carta de comando aleatória obtém Gravura: \"(EnchantConfig.Arg1)\", infectar 1 \"(Skill.Arg2)\""
  },
  Event_74171_Desc = {
    Text = "\"A chegada do fim já ocorreu.\"\nSeu coração se aperta, contrai-se.\nA voz de Juliette, cheia de certeza, sem dúvida contém algum poder de hipnose e telepatia.\nQual é a diferença entre o propósito de Juliette nesta dimensão e o que você conhecia no passado?\nMuitos mistérios, muitos obstáculos.\nVocê levanta os olhos para observar Juliette, mas descobre que ela também está olhando para você."
  },
  Event_74171_Name = {
    Text = "Olhar do Fim"
  },
  Event_74172_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74172_Desc = {
    Text = "Você levanta a mão e toca hesitante nas teclas ilusórias. \n As teclas soam com um tilintar, cada nota parece uma gota de orvalho, clara e transparente, e a técnica de execução refinada não vem de seus dedos. \n De repente, você vê um par de mãos invisíveis e longas cobrindo suas costas da mão, subindo e descendo conforme a música avança. \n O tempo parece parar, até o último eco da melodia do piano. \n Você ouve um suspiro de satisfação."
  },
  Event_74172_Name = {
    Text = "Sonata de Arrependimento"
  },
  Event_74173_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74173_Desc = {
    Text = "A consciência transferida com frequência não é estável, você precisa eliminar interferências sem sentido. \nVocê foca sua atenção em Jenkins, que está à sua frente, e o som do gramofone gradualmente desvanece, dissipando-se na névoa."
  },
  Event_74173_Name = {
    Text = "Estranhos Sons da Torre do Relógio"
  },
  Event_74174_ChoiceDesc1 = {
    Text = "[Locate the Source] Ganhe Relíquia Prata \"(RelicConfig.Arg1)\", infectado com \"(Skill.Arg2)\""
  },
  Event_74174_ChoiceDesc2 = {
    Text = "[Recordar] Todos os Despertos recuperam 50 pontos de loucura, infectando [(Skill.Arg1)]"
  },
  Event_74174_ChoiceDesc3 = {
    Text = "[Ignorar Barulho] Ganhe uma escolha de 3 Oracões"
  },
  Event_74174_Desc = {
    Text = "Você ouve o som distorcido da agulha do vitrola. \n A agulha deformada percorre as ranhuras espiraladas danificadas, emitindo lentamente um som arrepiante.\n\n."
  },
  Event_74174_Name = {
    Text = "Estranhos Sons da Torre do Relógio"
  },
  Event_74175_ChoiceDesc1 = {
    Text = "[Tocar para Ele] Escolha 1 de 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_74175_ChoiceDesc2 = {
    Text = "[Listening to the Strings] Para cada Despertador com um Aliemus de 50 ou mais, ganhe 15 Sigilos Negros."
  },
  Event_74175_ChoiceDesc3 = {
    Text = "[Leave] Obter 1 de 3 Orações"
  },
  Event_74175_Desc = {
    Text = "\"Querido John:\n    Recentemente, percebi de repente que já se passaram vários anos desde a última vez que você tocou piano para nós.\n    Este ano tenho 81 anos, e quanto mais envelheço, mais percebo o valor das lembranças da juventude.\n    Se você receber esta carta, por favor, na próxima vez que passar por Londinium, pare em frente ao meu apartamento e venha tocar uma música.\""
  },
  Event_74175_Name = {
    Text = "Sonata de Arrependimento"
  },
  Event_74176_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74176_Desc = {
    Text = "O desejo de sobrevivência agita-se em seu peito, e você emite a ordem sem hesitar. \n Esperar que você rompa o cerco, ao se virar para olhar, aquela estrela já foi submersa pela lama corrosiva. \n No fluxo da lama corrosiva, ouve-se uma série de sons agudos e rítmicos. \n Você toca a superfície da lama corrosiva, uma estrela podre cai em sua palma."
  },
  Event_74176_Name = {
    Text = "Estrela caída"
  },
  Event_74177_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74177_Desc = {
    Text = "Você pegou aquela estrela, mas ela perdeu seu brilho em sua palma. \n Uma sensação de opressão repentinamente surgiu, e um frio maligno fez sua espinha arrepiar. \n Entre a vida e a morte, você se esquivou, escapando de um ataque feroz, mas ainda assim ficou uma marca de dois centímetros em seu braço."
  },
  Event_74177_Name = {
    Text = "Estrela caída"
  },
  Event_74178_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74178_Desc = {
    Text = "Os dentes afiados escondidos nas garras rasgaram a manga da sua camisa, e o sangue escorria como finos riachos vermelhos, deslizando dos seus ossos do pulso. \nVocê não consegue decifrar o olhar de Sarah, mas de sua cabeça partida ecoa um rugido trêmulo de dor."
  },
  Event_74178_Name = {
    Text = "Pesadelo Recorrente"
  },
  Event_74179_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74179_Desc = {
    Text = "Você olha ao redor, movendo-se de um lado para o outro, o som é como um rato brincando de esconde-esconde com você, ora à esquerda, ora à direita, ora distante, ora próximo. \n Você anda em círculos, mas o som se torna cada vez mais barulhento, o ruído metálico provoca uma inquietação ainda maior. \n De repente, uma ideia lhe ocorre, você toca seus bolsos, embora não encontre a fonte do som, acaba pegando um pequeno tesouro."
  },
  Event_74179_Name = {
    Text = "Estranhos Sons da Torre do Relógio"
  },
  Event_7417_ChoiceDesc1 = {
    Text = "[Sair] Você perdeu(Arg1) de vida, Infectar[(Skill.Arg2)]"
  },
  Event_7417_Desc = {
    Text = "\n\"Bom garoto. Mas ainda assim, tenho que te dar uma pequena punição.\"\nA leve risada de Daffodil se apagou na fenda dimensional."
  },
  Event_7417_Name = {
    Text = "Tempo de dica"
  },
  Event_74180_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74180_Desc = {
    Text = "Você desvia o olhar, evitando colidir com ela. \nNo entanto, alguma força ainda faz o seu coração bater acelerado e inquieto."
  },
  Event_74180_Name = {
    Text = "Olhar do Fim"
  },
  Event_74181_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74181_Desc = {
    Text = "Juliette fitou você diretamente nos olhos.\nNo segundo seguinte, ela exibiu um sorriso completamente desvairado, como se estivesse zombando de sua arrogância e ignorância.\nNo entanto, o sorriso desapareceu num instante, e ninguém mais reagiu ao fato... Parecia ter sido apenas uma ilusão."
  },
  Event_74181_Name = {
    Text = "Olhar do Fim"
  },
  Event_7418_ChoiceDesc1 = {
    Text = "[Having task relic 1，ganha relíquia de ouro\"(RelicConfig.Arg1)\"]"
  },
  Event_7418_ChoiceDesc2 = {
    Text = "[Task Relic 2, Obtenha Relíquia de Ouro \"(RelicConfig.Arg1)\"]"
  },
  Event_7418_ChoiceDesc3 = {
    Text = "[Um cartão de comando aleatório obtém a oração: \"(EnchantConfig.Arg1)\"]"
  },
  Event_7418_Desc = {
    Text = "Evento 254 (em desenvolvimento), não é o efeito final"
  },
  Event_7418_Name = {
    Text = "Evento 254 (em desenvolvimento)"
  },
  Event_7419_ChoiceDesc1 = {
    Text = "[submeter oração especial 1, 1 carta de comando aleatória ganha oração:\"(EnchantConfig.Arg1)\"]"
  },
  Event_7419_ChoiceDesc2 = {
    Text = "[submeter oração especial 2, 1 carta de comando aleatória ganha oração:\"(EnchantConfig.Arg1)\"]"
  },
  Event_7419_ChoiceDesc3 = {
    Text = "[Infecção \"(Skill.Arg1)\" e \"(Skill.Arg2)\", Ganhe Relíquia de Ouro \"(RelicConfig.Arg3)\"]"
  },
  Event_7419_Desc = {
    Text = "Evento 255 (em desenvolvimento), não é o efeito final"
  },
  Event_7419_Name = {
    Text = "Evento 255 (em desenvolvimento)"
  },
  Event_7420_ChoiceDesc1 = {
    Text = "[Desviar do Cartão Borboleta] Remover 2 Cartões"
  },
  Event_7420_ChoiceDesc2 = {
    Text = "[Embrace the Butterfly] Ganhe Relíquia Maldita \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\""
  },
  Event_7420_ChoiceDesc3 = {
    Text = "[Leave] Ganhar Arg1 sigilos negros"
  },
  Event_7420_Desc = {
    Text = "Uma esquina, mais uma esquina, a estrada para perseguir os cães infernais parece não ter fim.\nTormento nos tornozelos, inchaço cerebral; em meio ao caos você vê as borboletas novamente, você sabe que é a loucura do delírio, o murmúrio do domínio. Elas surgem rapidamente de todos os lados"
  },
  Event_7420_Name = {
    Text = "Efluxo de Delírios"
  },
  Event_7421_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7421_Desc = {
    Text = "Você pressiona suavemente o sino de vento. O sino toca suavemente algumas vezes e cai no silêncio. Ele já se retirou — só retornará nos pesadelos."
  },
  Event_7421_Name = {Text = "Sinozinho"},
  Event_7422_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7422_Desc = {
    Text = "O sino toca suavemente algumas vezes e cai no silêncio. Ele já se retirou - só retornará nos pesadelos"
  },
  Event_7422_Name = {Text = "Sinozinho"},
  Event_7423_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7423_Desc = {
    Text = "\"Não é ruim, você é muito cauteloso.\"\nDe repente, uma voz distante veio dos sinos de vento.\n\"A cautela trará uma pequena recompensa, mas só isso.\""
  },
  Event_7423_Name = {Text = "Sinozinho"},
  Event_74245_ChoiceDesc1 = {
    Text = "[Sair] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_74245_Desc = {
    Text = [[
Rattle rattle, the dice dance excitedly inside the cup, dancing until they are exhausted.

"You lost. However, as a reward for keeping me entertained, you can still receive a prize."]]
  },
  Event_74245_Name = {
    Text = "Mensagem de N"
  },
  Event_74246_ChoiceDesc1 = {
    Text = "[Fechar o Portão] Infectar \"(Skill.Arg1)\", conceder aleatoriamente 1 carta de comando com Oração: \"(EnchantConfig.Arg2)\""
  },
  Event_74246_ChoiceDesc2 = {
    Text = "[Frantic Departure] Contrato \"(Skill.Arg1)\", imprima aleatoriamente uma carta de Comando com Oração: \"(EnchantConfig.Arg2)\""
  },
  Event_74246_ChoiceDesc3 = {
    Text = "[Desconsiderar] Escolha 1 carta entre 3 cartas de comando para ganhar um selo:[(EnchantConfig.Arg1)]"
  },
  Event_74246_Desc = {
    Text = "Você está enredado neste labirinto construído de vapor e engrenagens, os tubos de latão se entrelaçam acima da sua cabeça como uma teia de aranha, e a cada respiração, a névoa espessa de óleo lubrificante é agitada. \n O mostrador mecânico fora de controle convulsiona na parede, e os ponteiros, ao rasgar a escala, espirram faíscas, como se fossem vagalumes à beira da morte em um laboratório vitoriano. As costuras de rebites exalam ferrugem, como as feridas em decomposição desta besta de aço, enquanto seu relógio de bolso já parou — o tempo aqui é apenas a oração do engrenamento das engrenagens."
  },
  Event_74246_Name = {
    Text = "Cidade de Vapor"
  },
  Event_74247_ChoiceDesc1 = {
    Text = "[Apostar] Infectar [(Skill.Arg1)], entrar no jogo"
  },
  Event_74247_ChoiceDesc2 = {
    Text = "[Esqueça] Ganhe 25 sigilos negros"
  },
  Event_74247_Desc = {
    Text = "No canto da rua, uma névoa negra e profunda exala uma sensação de asfixia. \n Na névoa, dois dados antigos e gelados aparecem silenciosamente, suas superfícies cobertas de símbolos indecifráveis e padrões estranhos. \n Eles repousam tranquilamente sobre o tablete escorregadio, como se estivessem esperando por uma invocação desconhecida. \n \"Você sabe quem eu sou. Vamos fazer uma aposta?\""
  },
  Event_74247_Name = {
    Text = "Mensagem de N"
  },
  Event_74248_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74248_Desc = {
    Text = "\"Eu sonhei com um cataclismo que varreu tudo, submergindo o brilho do passado. Sinto raiva da vida e, mais ainda, uma impotência diante da falta de esperança para o futuro. Minha alma está rasgada pelo medo, e desejo que, neste momento prestes a desmoronar, vocês possam ter vigilância e não deixem que este terrível destino chegue.\""
  },
  Event_74248_Name = {
    Text = "Últimas palavras incoerentes"
  },
  Event_74249_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74249_Desc = {
    Text = "A fumaça negra treme desolada.  \nEm seguida, os dados desaparecem num piscar de olhos.  \n\nA única pergunta que resta em sua mente é:  \nDe que os dados são realmente feitos?\n\n?"
  },
  Event_74249_Name = {
    Text = "Mensagem de N"
  },
  Event_7424_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7424_Desc = {
    Text = "Você se vira e vê um par de sapatos, além de uma sombra humana borrada. \n Parece ser um jovem cavalheiro. \n \"Desculpe incomodar, você viu um par de sapatos oxford pretos?\" \n \"Tem um par bem na sua frente.\" \n \"Não, não... este é de couro de cabra, não de couro bovino. \n Estou preso neste museu de cera há doze anos, deve ser por causa do sapato errado...\" \n A voz murmura, gradualmente se tornando mais fraca."
  },
  Event_7424_Name = {Text = "passos"},
  Event_74250_ChoiceDesc1 = {
    Text = "[Discernir a Voz do Homem] Desenhe aleatoriamente 3 cartas de comando do baralho e escolha 1 para duplicar."
  },
  Event_74250_ChoiceDesc2 = {
    Text = "[Distinguir a Voz da mulher] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_74250_ChoiceDesc3 = {
    Text = "[Discernir a Voz do Ancião] Receba 25 [O sigilo negro]"
  },
  Event_74250_Desc = {
    Text = "Você está sozinho em um pântano escuro.\nNa neblina, você ouve sussurros caóticos se sobreporem como ondas do mar, uns vindos de idosos, outros de crianças balbuciando, alguns de mulheres ansiosas, outros de homens tomados por um medo inexplicável…"
  },
  Event_74250_Name = {
    Text = "Últimas palavras incoerentes"
  },
  Event_74251_ChoiceDesc1 = {
    Text = "[Avançar] Sorteia aleatoriamente 3 cartas de comando do baralho, escolha 1 para excluir e recebe 75 O sigilo negro."
  },
  Event_74251_ChoiceDesc2 = {
    Text = "[Rest] Sorteie aleatoriamente 3 cartas de comando do baralho, escolha 1 cópia original de uma carta para entrar no baralho e receba 25 O sigilo negro."
  },
  Event_74251_ChoiceDesc3 = {
    Text = "[Olhar para trás] Ganhar 50 Selos Negros"
  },
  Event_74251_Desc = {
    Text = "Você caminha pelas ruas desertas, e seus passos deixam marcas profundas nas cinzas.  \n\nAs estradas da cidade se assemelham a uma teia de aranha, e você é a mariposa presa nela.\n\n."
  },
  Event_74251_Name = {
    Text = "Cidade das Névoas"
  },
  Event_74252_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74252_Desc = {
    Text = "No instante em que a comporta de vapor se fecha com estrondo, você ouve o som de sua própria sombra sendo esmagada centímetro a centímetro pelas engrenagens precisamente acopladas."
  },
  Event_74252_Name = {
    Text = "Cidade de Vapor"
  },
  Event_74253_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74253_Desc = {
    Text = "A mesma cena se repete e atualiza diante de você, e você não tem saída."
  },
  Event_74253_Name = {
    Text = "Cidade de Vapor"
  },
  Event_74254_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74254_Desc = {
    Text = "O tempo é uma coordenada inútil; a única coisa que você busca é a verdade."
  },
  Event_74254_Name = {
    Text = "Cidade de Vapor"
  },
  Event_74255_ChoiceDesc1 = {
    Text = "[Três Pontos]"
  },
  Event_74255_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_74255_ChoiceDesc3 = {
    Text = "[One Point]"
  },
  Event_74255_Desc = {
    Text = "Quem teria coragem de lançar os dados que simbolizam a desgraça e a loucura?  \nVocê, é claro.  \nVocê escolhe—"
  },
  Event_74255_Name = {
    Text = "Mensagem de N"
  },
  Event_74256_ChoiceDesc1 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_74256_Desc = {
    Text = [[
Rattle rattle, the dice dance excitedly inside the cup, dancing until they are exhausted.

"You lost. However, as a reward for keeping me entertained, you can still receive a prize."]]
  },
  Event_74256_Name = {
    Text = "Mensagem de N"
  },
  Event_74257_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74257_Desc = {
    Text = "O caminho de onde você veio é um infinito de escuridão e um mar imensurável de Caos. \nNão há mais tempo para considerar seu próprio destino. Você deve eliminar o medo e alcançar seu destino final antes que a sentença seja pronunciada."
  },
  Event_74257_Name = {
    Text = "Cidade das Névoas"
  },
  Event_74258_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74258_Desc = {
    Text = "\"Quando estou sentado à sombra do tempo, sinto a mão fria da morte se aproximando gradualmente. O mundo lá fora se torna cada vez mais obscuro, repleto de sussurros de desastres. Eu temo o julgamento que se aproxima, a liquidação de nossa ignorância. As ruas estão impregnadas de um presságio sinistro, temo que o dia do nosso julgamento esteja chegando. Nossa civilização está instável, como se estivesse prestes a ser devorada pela destruição, presa em nossa própria arrogância estúpida.\""
  },
  Event_74258_Name = {
    Text = "Últimas palavras incoerentes"
  },
  Event_74259_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74259_Desc = {
    Text = "Escapar da morte já é algo difícil o suficiente, você não deveria exigir mais do que isso.\nAs sombras dos escombros e ruínas ainda estão te chamando."
  },
  Event_74259_Name = {
    Text = "Cidade das Névoas"
  },
  Event_7425_ChoiceDesc1 = {
    Text = "[Leave] Obter 1 de 3 Orações"
  },
  Event_7425_Desc = {
    Text = "\"É mesmo... muito interessante.\"\nEla recolheu o questionário e apontou para a direção onde as crianças haviam ido. Você se apressou, quase perdendo o sussurro atrás de você.\n\"Ansioso pela nossa próxima reunião.\""
  },
  Event_7425_Name = {
    Text = "Avaliação psicológica"
  },
  Event_74260_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74260_Desc = {
    Text = "Você está sob o domínio de alguma força imensa ou de um destino poderoso. Um breve descanso não muda essa realidade, mas ao menos pode dar motivação às pernas cansadas para continuar avançando."
  },
  Event_74260_Name = {
    Text = "Cidade das Névoas"
  },
  Event_74261_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74261_Desc = {
    Text = "\"…A cidade não é mais um porto seguro e acolhedor, mas uma cova oculta, que gera terror e desespero. Aqueles sonhos que um dia foram vibrantes, agora restam apenas fragmentos de medo. Não posso mais fingir que não tenho medo, o mundo à minha frente é como um pesadelo do qual não posso acordar.\""
  },
  Event_74261_Name = {
    Text = "Últimas palavras incoerentes"
  },
  Event_74262_ChoiceDesc1 = {
    Text = "[Sair] ganha relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_74262_Desc = {
    Text = [[
Rattle rattle, the dice dance excitedly inside the cup, dancing until they are exhausted.

"You lost. However, as a reward for keeping me entertained, you can still receive a prize."]]
  },
  Event_74262_Name = {
    Text = "Mensagem de N"
  },
  Event_7426_ChoiceDesc1 = {
    Text = "[Leave] Conceder aleatoriamente 1 Cartão de Comando a Oração: Espelho"
  },
  Event_7426_Desc = {
    Text = "\"Está tudo bem, eu já vi a resposta em seus olhos. Tenho alguns assuntos para resolver, então me desculpo por agora. Você também tem suas questões, não tem? Olhe, alguém está vindo para você.\"\nVocê se vira, e uma figura da Igreja da Luz do Templo aparece no final da estrada."
  },
  Event_7426_Name = {
    Text = "Companheiro Estranho V"
  },
  Event_7427_ChoiceDesc1 = {
    Text = "[Leave] Conceder aleatoriamente 1 cartão de comando uma Oração: Cálculo"
  },
  Event_7427_Desc = {
    Text = "\"Você ainda não está disposto a se abrir para mim. Estou muito desapontado, mas tudo bem, ainda assim vou te dar a dica mais amigável: o que a Igreja da Lanterna está realmente procurando aqui?\"\n\"Ah, parece que alguém não quer que fiquemos conversando. Olhe ali, alguém veio te procurar.\"\nVocê se virou e a figura dos Portadores de lanternas apareceu no final do caminho."
  },
  Event_7427_Name = {
    Text = "Companheiro Estranho V"
  },
  Event_7428_ChoiceDesc1 = {
    Text = "[Leave] Conceder aleatoriamente 1 Cartão de Comando a Oração: Inspiração"
  },
  Event_7428_Desc = {
    Text = "\"Você é muito honesto, merece uma recompensa. Então, decidi te dar uma pequena dica: por que você foi alvo Dele logo que chegou à Vila de Lai?\"\n\"Ah, parece que alguém não quer que fiquemos conversando. Olhe ali, alguém veio te procurar.\"\nVocê se virou e a figura dos Portadores de Lanternas apareceu no final do caminho."
  },
  Event_7428_Name = {
    Text = "Companheiro Estranho V"
  },
  Event_7429_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7429_Desc = {
    Text = "Os sons caóticos foram diminuindo, suas mãos vazias, mas a emoção momentânea foi registrada pela Chave de Prata"
  },
  Event_7429_Name = {
    Text = "Livro do Nada"
  },
  Event_7430_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7430_Desc = {
    Text = "Você estende a mão no caos, agarrando algo com uma sensação estranha, que gradualmente toma forma"
  },
  Event_7430_Name = {
    Text = "Livro do Nada"
  },
  Event_7431_ChoiceDesc1 = {
    Text = "[Partir] Escolha 1 de 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7431_Desc = {
    Text = "\"Você já ouviu falar sobre a maneira como as cobras caçam? As cobras só podem rastejar no chão, se movendo em zigue-zague, portanto, não conseguem acelerar e perseguir como os guepardos, nem cercar a presa como os lobos. Em contrapartida, as cobras aprenderam a esperar em silêncio.\"\n\"Elas aguardam o momento em que a presa relaxa a vigilância, e então lançam um assalto, engolindo-a de uma só vez.\""
  },
  Event_7431_Name = {
    Text = "Companheiro Estranho III"
  },
  Event_7432_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7432_Desc = {
    Text = "Assustada, a pele brilhante do gato preto deixou uma leve dor em seus dedos antes de desaparecer na névoa"
  },
  Event_7432_Name = {
    Text = "Desgraça do Gato Noturno"
  },
  Event_7433_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7433_Desc = {
    Text = "Nada mais é do que o absurdo devaneio daqueles tolos crentes insensatos"
  },
  Event_7433_Name = {
    Text = "Ordem secreta · Parte inferior"
  },
  Event_7434_ChoiceDesc1 = {
    Text = "[Keep Eavesdropping] Ganhe 3 opções de Oração"
  },
  Event_7434_ChoiceDesc2 = {
    Text = "[Tosse Alta] Escolha 1 de 3 cartas de comando para ganhar uma oração: \"(EnchantConfig.Arg1)\", e infectar \"(Skill.Arg2)\""
  },
  Event_7434_Desc = {
    Text = "O canto da parede se abriu em várias fendas finas, serpenteando como veias. \n Acompanhado por um leve zumbido, você ouve a voz profunda de um homem do outro lado. \n \"Distrito de Quentin 5, Distrito de Wellington 10, Distrito de Norman 15... \n Todo o material deste mês já foi carregado, pronto para o transporte, número do lote I-0234... \n ... \n Além disso, graças àquela turma do Misaq, o Distrito de White Chapel está atualmente sob estado de cerco, perdemos nossa maior fonte de material.\""
  },
  Event_7434_Name = {
    Text = "Os muros têm ouvidos"
  },
  Event_7435_ChoiceDesc1 = {
    Text = "[Afastar corvos] Obtenha 20 sigilo negro, infectar [(Skill.Arg2)]"
  },
  Event_7435_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Sair"
  },
  Event_7435_Desc = {
    Text = "Sob sua intimidação, todos os corvos voaram para todos os lados, as asas negras que caíam se fundiram em uma substância pegajosa, pingando na forma do sigilo negro"
  },
  Event_7435_Name = {
    Text = "Olhar da Corvo Negro"
  },
  Event_7436_ChoiceDesc1 = {
    Text = "[Desista da Resistência] Delete 1 carta de comando, ganhe Arg1 Sigilo Negro"
  },
  Event_7436_ChoiceDesc2 = {
    Text = "[Puxe as Mãos para Trás]"
  },
  Event_7436_Desc = {
    Text = "Uma nova máquina de escrever.\nEla tem teclas únicas, tão elegantes e precisas quanto um microscópio.\nVocê curiosamente colocou as mãos nela, mas elas começaram a voar pelo teclado, cada vez mais rápido"
  },
  Event_7436_Name = {
    Text = "Inspiração súbita"
  },
  Event_7437_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7437_Desc = {
    Text = "Mas são seres lutando para sobreviver, buscando um pedaço de madeira flutuante para descansar...\nVocê suspira, deixando o líquido negro da cauda da borboleta escorrer pelo rosto"
  },
  Event_7437_Name = {
    Text = "Borboleta de Líquido Preto"
  },
  Event_7438_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7438_Desc = {
    Text = "Você aceita o pedido de contato da escola, a voz familiar te acalma. Você se recompõe e segue em frente"
  },
  Event_7438_Name = {
    Text = "Ponto de contato"
  },
  Event_7439_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7439_Desc = {
    Text = "Você aceita o pedido de contato da escola, a voz familiar te acalma. Você se recompõe e segue em frente"
  },
  Event_7439_Name = {
    Text = "Ponto de contato"
  },
  Event_7440_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7440_Desc = {
    Text = "Sua dúvida caiu no ar, sem resposta, a luz quente e amarela entra pela janela, aquecendo como uma lembrança"
  },
  Event_7440_Name = {
    Text = "Memórias vulcânicas"
  },
  Event_7441_ChoiceDesc1 = {
    Text = "[Pegar] Infecção \"(Skill.Arg1)\", Ganhar Relíquia de Prata \"(RelicConfig.Arg2)\""
  },
  Event_7441_ChoiceDesc2 = {
    Text = "[Hesitar] Ganhe 25 sigilos negros"
  },
  Event_7441_Desc = {
    Text = "No canto do beco, um barril flutua com um objeto de cor estranha. A aparição anômala parece avisar: \"Não toque\""
  },
  Event_7441_Name = {
    Text = "Objeto flutuante no balde"
  },
  Event_7442_ChoiceDesc1 = {
    Text = "[Dê para Ela] Obtenha 1 de 3 Relíquias de Prata"
  },
  Event_7442_ChoiceDesc2 = {
    Text = "[Interesting Situation] Obter Relíquia de Prata \"(RelicConfig.Arg1)\" e \"(RelicConfig.Arg2)\", infectar duas vezes \"(Skill.Arg3)\""
  },
  Event_7442_Desc = {
    Text = "\"Esta é uma comunicação de Mythag. Sou Erica. Flutuações anormais no índice gnóstico detectadas em Despertar Lotan. Você precisa de apoio?\""
  },
  Event_7442_Name = {
    Text = "Comunicação de apoio"
  },
  Event_7443_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7443_Desc = {
    Text = "Você cedeu aos sussurros maliciosos em seu ouvido. Uma dor estridente, afiada como uma agulha, se entorta fundo em seu crânio.\n\n\"Para—por favor, para—fiz o que você pediu—faça parar—\"\n\nVocê aperta a cabeça em agonia, ouvindo apenas a risada distante e zombeteira dos corvos."
  },
  Event_7443_Name = {
    Text = "Canto da Matilha de Corvos"
  },
  Event_7444_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7444_Desc = {
    Text = "Colocado nesta posição, há duas possibilidades: algo ignorado ou algo valorizado. Se for o último, deixe para o dono original"
  },
  Event_7444_Name = {
    Text = "Núcleo de prata solitário"
  },
  Event_7445_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7445_Desc = {
    Text = "A maior felicidade é a ignorância"
  },
  Event_7445_Name = {Text = "Espiar"},
  Event_7446_ChoiceDesc1 = {
    Text = "[Spawn Normal Monster]"
  },
  Event_7446_ChoiceDesc2 = {
    Text = "[Spawn Blank Tile]"
  },
  Event_7446_ChoiceDesc3 = {
    Text = "[Spawn Void]"
  },
  Event_7446_Desc = {
    Text = "Vamos ver o que podemos gerar"
  },
  Event_7446_Name = {
    Text = "[Para Ser Embalado]"
  },
  Event_7447_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7447_Desc = {
    Text = "\"Calma,\" Ramona bate na sua cabeça, \"apenas fragmentos do passado. Não sei quem os deixou neste passagem dimensional.\"\nDe fato, há um cheiro nostálgico."
  },
  Event_7447_Name = {
    Text = "Fragmento de Memória: Whisky"
  },
  Event_7448_ChoiceDesc1 = {
    Text = "[Colecionar] eleve uma relíquia de prata para relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_7448_ChoiceDesc2 = {
    Text = "[Throw Them Away] Ganhe Relíquia de Ouro \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\", e \"(Skill.Arg3)\""
  },
  Event_7448_ChoiceDesc3 = {
    Text = "[Observar Cuidadosamente] Ganhe 25 Sigilos Negros"
  },
  Event_7448_Desc = {
    Text = "Aqui há muitos núcleos de prata quebrados.\nOpacos, fragmentados... claramente não são de alta qualidade.\nTalvez sejam a razão dessas estátuas \"ganharem vida\".\nMesmo o núcleo de prata mais bruto pode criar milagres"
  },
  Event_7448_Name = {Text = "Alma Presa"},
  Event_7449_ChoiceDesc1 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7449_Desc = {
    Text = "Kum já deu tudo o que podia.\nAgora, é sua vez de fazer seu sacrifício valer a pena"
  },
  Event_7449_Name = {
    Text = "Resíduo de calor"
  },
  Event_7450_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7450_Desc = {
    Text = "Que a neve eterna lhes dê paz"
  },
  Event_7450_Name = {
    Text = "Relíquias dos antigos"
  },
  Event_7451_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7451_Desc = {
    Text = "Você ainda parece resistente, conseguindo seguir a si mesmo mesmo ao cantar. \n Você não acredita nos delírios ao seu redor, confiando apenas na razão humana. \n No entanto... o chão sólido que sustenta sua vida, no dia em que estiver coberto pela espessa lama negra, arrancar os olhos para espiar será sua única escolha nos momentos finais."
  },
  Event_7451_Name = {
    Text = "Canto da Matilha de Corvos"
  },
  Event_7452_ChoiceDesc1 = {
    Text = "[Sair] escolha 1 carta dentre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_7452_Desc = {
    Text = "Kum foi puxada por você, escapando por pouco de um golpe. Ela acenou em agradecimento e voltou a atacar o espécime"
  },
  Event_7452_Name = {Text = "Coliseu"},
  Event_7453_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7453_Desc = {
    Text = "Ding ding dang...\nMoedas caem na carteira, emitindo um som claro e agradável.\nA carteira mastiga satisfeita e solta um arroto.\nEla se rende à sua generosidade e agora está ao seu serviço"
  },
  Event_7453_Name = {
    Text = "Carteira gulosa"
  },
  Event_7454_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7454_Desc = {
    Text = "A moeda de bronze caiu no abismo sem som.\nVocê esperou cinco minutos. A carteira gemeu e cuspiu um líquido negro.\nUma silenciosa protesto"
  },
  Event_7454_Name = {
    Text = "Carteira gulosa"
  },
  Event_7455_ChoiceDesc1 = {
    Text = "[Look into the distance]"
  },
  Event_7455_ChoiceDesc2 = {
    Text = "[Listen Carefully]"
  },
  Event_7455_Desc = {
    Text = "Celeste agitou o compasso, não disse uma palavra, mas uma canção ecoou ao seu redor.\nA canção dos marinheiros transcendia o tempo, entrelaçando-se neste momento, uma melodia caótica, mas poderosa, guiava você, fazendo olhar para o outro lado do barco"
  },
  Event_7455_Name = {
    Text = "Canção do barco"
  },
  Event_7456_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7456_Desc = {
    Text = "Você interrompeu essa pequena aula prática. \n Desde os gestos ao tocar piano até a teoria musical básica, você não hesitou em fazer comentários. \n A música parou abruptamente, e o garoto e o professor olharam para você ao mesmo tempo, com um sorriso igualmente enigmático em seus rostos. \n 133, 355, 244... \n O som do piano recomeçou, ainda completamente errado. \n Na verdade, eles não ouviam nada."
  },
  Event_7456_Name = {
    Text = "Aulas de piano"
  },
  Event_7457_ChoiceDesc1 = {Text = "[Pocketed]"},
  Event_7457_Desc = {
    Text = "As marcas negras encontradas no domínio podem ser oferecidas como sacrifícios para as marcas de dissolução em troca de criações e outros projetos espirituais. Elas rapidamente se dissiparão em lodo negro após deixar a área atual"
  },
  Event_7457_Name = {
    Text = "Marca Negra"
  },
  Event_7458_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7458_Desc = {
    Text = "Agora é mais importante encontrar aquela pessoa misteriosa. Pensando nisso, Ramona saiu rapidamente"
  },
  Event_7458_Name = {
    Text = "O ouvido alheio"
  },
  Event_7459_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7459_Desc = {
    Text = "Entregue-se à consciência, afundando-se no Aequor seguindo o caminho das orações.\nVocê vê o sol dourado do país afundado no fundo, vê as esculturas de pedra imortais e, por fim, confronta os olhos tremeluzentes nas sombras...\n\"Aqueles que não derramaram sangue divino... saiam, saiam.\""
  },
  Event_7459_Name = {
    Text = "Prece do Sonho"
  },
  Event_7460_ChoiceDesc1 = {
    Text = "[Sair] escolhe 1 relíquia amaldiçoada, infecção de[(Skill.Arg1)]"
  },
  Event_7460_Desc = {
    Text = "Ramona atravessou a garganta do sujeito, Kum afastou o corpo inerte, indo em direção ao próximo alvo"
  },
  Event_7460_Name = {Text = "Coliseu"},
  Event_7461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7461_Desc = {
    Text = "Corvos arrancavam suas próprias penas, como humanos devorando seus corpos.\nNeste mundo de medo, isso é comum, você não pode salvar todos"
  },
  Event_7461_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7462_ChoiceDesc1 = {
    Text = "[Soothe Kum]"
  },
  Event_7462_ChoiceDesc2 = {
    Text = "[Ajude a Clamar por Kum]"
  },
  Event_7462_Desc = {
    Text = "A enorme besta rugiu para a pequena figura humana, tentando despertar antigos companheiros. Mas suas cordas vocais danificadas só produziram um som gutural"
  },
  Event_7462_Name = {
    Text = "Chamado da Amizade"
  },
  Event_7463_ChoiceDesc1 = {
    Text = "[Leave] Encontrar farol de busca"
  },
  Event_7463_ChoiceDesc2 = {
    Text = "[Break into Mist] Perder Arg2 Vida"
  },
  Event_7463_Desc = {
    Text = "À frente se encontra uma espessa névoa negra; entrar de forma imprudente trará Clades.\nTalvez você deva encontrar uma \"lanterna\" para dispersar a névoa."
  },
  Event_7463_Name = {
    Text = "desconhecido"
  },
  Event_7464_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7464_Desc = {
    Text = "\"Uma mandíbula que rangue como a sua? Eu nunca vi nada como isso na minha vida.\"\nVocê rejeitou o pedido rude do Sr. Jawbone. O Sr. Jawbone ficou extremamente desapontado, mas conseguiu manter a compostura.\nPara agradecer por sua paciência em ouvir, ele lhe deu um pequeno presente."
  },
  Event_7464_Name = {Text = "Crujido"},
  Event_7465_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7465_Desc = {
    Text = "Você atendeu a este pedido peculiar e levou o Sr. Mandíbula com você. \n Ele está deitado em seu bolso, estalando sem parar. De acordo com a tradução do companheiro, suas falas contêm, em grande parte, gratidão, nostalgia e arrependimento. \n Quanto ao porquê de ele ter se tornado assim? O Sr. Mandíbula não quis falar muito, apenas disse: \n \"Você sabe, quando você observa @2, @2 também te observa.\""
  },
  Event_7465_Name = {Text = "Crujido"},
  Event_7466_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7466_Desc = {
    Text = "Ele desliza para sua bolsa como um pedaço de seda, e com o leve aumento de peso, você ouve um leve agradecimento.\nDepois disso, não há mais som"
  },
  Event_7466_Name = {
    Text = "Espírito do Caos"
  },
  Event_7467_ChoiceDesc1 = {Text = "[Avançar]"},
  Event_7467_Desc = {
    Text = "Crack.\nVocê insere a chave na fechadura e abre a porta suavemente.\nTodo o processo de abrir a porta foi tranquilo, dando-lhe confiança para a investigação"
  },
  Event_7467_Name = {
    Text = "Porta enferrujada"
  },
  Event_7468_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7468_Desc = {
    Text = "A voz riu profundamente, e ondulações se formaram no líquido aos seus pés.\n\"Você logo perceberá que não há nada que você deva fazer exceto encarar a morte.\""
  },
  Event_7468_Name = {
    Text = "Você não vai querer encontrar"
  },
  Event_7469_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7469_Desc = {
    Text = "Você descartou essa memória, retirando sua consciência do consolo ilusório"
  },
  Event_7469_Name = {
    Text = "Perdido no passado"
  },
  Event_7470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7470_Desc = {
    Text = "Foi apenas um breve sono, sem consolo, como você passará esta longa noite"
  },
  Event_7470_Name = {
    Text = "Perdido no passado"
  },
  Event_7471_ChoiceDesc1 = {
    Text = "[Pegue a foto] escolha 1 de 3 cartas de comando e ganhe oração: [(EnchantConfig.Arg1)]"
  },
  Event_7471_Desc = {
    Text = "Esta é uma série de fotos de grupo. \n Pessoas apáticas estão agachadas atrás de uma grade de ferro, com rostos cheios de sofrimento. \n Uma das fotos chamou sua atenção. Deve ser uma jovem mulher esquelética, com o rosto em branco. \n Aquela criatura grotesca, está se enrolando ao redor de seu corpo. \n Você não consegue ver seu rosto, mas em sua imaginação, ela deve estar sem expressão."
  },
  Event_7471_Name = {
    Text = "registrar fielmente"
  },
  Event_7472_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7472_Desc = {
    Text = "Isso são restos de um pássaro"
  },
  Event_7472_Name = {
    Text = "Enxame de corvos agitados"
  },
  Event_7473_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7473_Desc = {
    Text = "Você recusou friamente o pedido do pianista.\nO pianista ficou extremamente desapontado. Ele arrancou a outra orelha e jogou-as pela janela.\n\"De qualquer forma, não preciso delas.\"\nO pianista melancólico tocou uma série de notas tristes"
  },
  Event_7473_Name = {
    Text = "Preste atenção"
  },
  Event_7474_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7474_Desc = {
    Text = "O choro do Espírito do Caos ficou mais agudo, até se transformar em um grito estridente, ecoando ao redor.\nEle afundou novamente no pântano com sua oferenda e tristeza inescapável"
  },
  Event_7474_Name = {
    Text = "Espírito do Caos"
  },
  Event_7475_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7475_Desc = {
    Text = "Este é um corredor unidirecional, você não pode voltar pela entrada"
  },
  Event_7475_Name = {Text = "Passagem"},
  Event_7476_ChoiceDesc1 = {
    Text = "[Leave] Obtenha Relíquia \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7476_Desc = {
    Text = "\"Bem, então, por favor, feche os olhos e sinta silenciosamente o som de seus passos se aproximando.\"\nSeguindo o conselho, você fechou os olhos. Em um instante, uma respiração bestial arrepiante rugiu em seus ouvidos.\nQuando você abriu os olhos em choque, o homem de antes já havia desaparecido."
  },
  Event_7476_Name = {
    Text = "Companheiro Estranho I"
  },
  Event_7477_ChoiceDesc1 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7477_Desc = {
    Text = "\"Isso é realmente lamentável.\"\nO homem ajustou os óculos, sua voz baixa.\n\"Entretanto, se você não ouviu sobre isso, por que veio aqui tão tarde da noite?\"\nSem esperar uma resposta, ele se afastou."
  },
  Event_7477_Name = {
    Text = "Companheiro Estranho I"
  },
  Event_7478_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7478_Desc = {
    Text = "Você caminha com passos firmes, continuando em frente.\nUm passo, dois passos, três passos...\nOs passos atrás de você desaparecem na escuridão.\nVocês se encontrarão novamente"
  },
  Event_7478_Name = {Text = "Oxford"},
  Event_7479_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7479_Desc = {
    Text = "Você faz uma meia-reverência, levantando a bandeja da mesa ao seu lado, transformando-se na guarda da princesa.\nQuanto a quem se tornou a princesa sortuda—era, é claro, seu parceiro mais leal.\n\"Se derrubar chá no meu rosto de novo, pode esquecer as anotações da próxima aula.\"\nEsse é o aviso da princesa para você."
  },
  Event_7479_Name = {
    Text = "Falso por verdadeiro"
  },
  Event_7480_ChoiceDesc1 = {
    Text = "[Listening Quietly] Melhore aleatoriamente a qualidade da Oração de 1 Cartão."
  },
  Event_7480_ChoiceDesc2 = {
    Text = "[Ela É] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7480_Desc = {
    Text = [[
Sarah's roar echoed in your mind, and a slightly familiar faint voice came from nowhere, softly whispering "Sasha sister," "Sasha sister."
"Sasha sister, where are you?"]]
  },
  Event_7480_Name = {
    Text = "\"Irmã Sasha\""
  },
  Event_7481_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7481_Desc = {
    Text = "\"...Não posso acreditar que há alguma verdade no que você está dizendo, mas o anseio sozinho não resolverá o Corpo Dissolvido. Vamos fazer algo prático.\""
  },
  Event_7481_Name = {
    Text = "Regra de Logan"
  },
  Event_7482_ChoiceDesc1 = {
    Text = "[Ganhe 100 sigilos negros]"
  },
  Event_7482_ChoiceDesc2 = {
    Text = "[2 Cartas de comando aleatórias obtêm Gravura: \"(EnchantConfig.Arg1)\"]"
  },
  Event_7482_Desc = {
    Text = "Feitas de sabedoria estável, talvez essas criações tragam uma melodia harmoniosa"
  },
  Event_7482_Name = {
    Text = "Disonância"
  },
  Event_7483_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7483_Desc = {
    Text = "\"É um fragmento de memória de alguém que entrou nesta dimensão,\" Ramona respondeu, \"É fácil encontrar isso ao atravessar dimensões. Cuidado para não confundir com suas próprias memórias.\""
  },
  Event_7483_Name = {
    Text = "Fragmento de Memória: Whisky"
  },
  Event_7484_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7484_Desc = {
    Text = "Siga o ritmo do coração, busque o brilho. Vocês não se separarão, assim como ninguém pode distinguir precisamente o dia da noite"
  },
  Event_7484_Name = {
    Text = "Atrium esquerdo"
  },
  Event_7485_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7485_Desc = {
    Text = "Você continua acariciando essas mãos inquietas, tentando acalmá-las.\nLogo, seu mundo está completamente tranquilo.\nO amor sempre é recompensado"
  },
  Event_7485_Name = {
    Text = "Pântano Escuro"
  },
  Event_7486_ChoiceDesc1 = {
    Text = "[Struggle] Infecte \"(Skill.Arg1)\", ganhe Relíquia de Prata \"(RelicConfig.Arg2)\""
  },
  Event_7486_ChoiceDesc2 = {
    Text = "[Give Up] Infecte \"(Skill.Arg1)\", obtenha uma relíquia de prata \"(RelicConfig.Arg2)\""
  },
  Event_7486_ChoiceDesc3 = {
    Text = "[Cuidado] Ganhar 25 sigilos negros"
  },
  Event_7486_Desc = {
    Text = "Sua mente é invadida por impurezas, a sensação de sujeira é muito clara.\nO líquido turvo e fétido se infiltra e ocupa todos os seus pensamentos, a dor cobre seu rosto cheio de medo, você cai em um ciclo interminável de pesadelos, difícil de escapar"
  },
  Event_7486_Name = {
    Text = "Crânio perfurado"
  },
  Event_7487_ChoiceDesc1 = {
    Text = "[É o Espelho do Ritual de Memphis]"
  },
  Event_7487_ChoiceDesc2 = {
    Text = "[É uma Bússola Direcional]"
  },
  Event_7487_ChoiceDesc3 = {
    Text = "[Não Deixei Nada Cair]"
  },
  Event_7487_Desc = {
    Text = "\"O Pioneiro da Travessia Dimensional.\"\n\nUma voz antiga ecoa em seus ouvidos, como se fosse da pré-história, transcendendo as eras.\n\nEm extrema tensão, você ouve a voz fazer uma pergunta um tanto familiar.\n\n\"O que é este objeto redondo que você deixou cair que permite que você compre cartas no início da rodada?\""
  },
  Event_7487_Name = {
    Text = "Voz fora do mundo"
  },
  Event_7488_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7488_Desc = {
    Text = "\"Isto não é um ferro-velho,\" a Boneca murmurou, aceitando, \"mas tudo bem, ainda posso extrair algo útil.\""
  },
  Event_7488_Name = {Text = "Placa"},
  Event_7489_ChoiceDesc1 = {
    Text = "Gravação comum aleatória"
  },
  Event_7490_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7490_Desc = {
    Text = "\nVocê lê o papel envelhecido e rasgado: \"Twinborn\", \"Soak\", \"Sacrifício\", \"Ineficaz\"...\nUma confusão de conceitos fragmentados e prosa enigmática, apenas um cérebro pulsante prova que você leu este pedaço de papel."
  },
  Event_7490_Name = {
    Text = "Ordem secreta · Parte inferior"
  },
  Event_7491_ChoiceDesc1 = {
    Text = "[What Price Are You Willing to Pay?] Melhore aleatoriamente a qualidade da oração de 1 cartão."
  },
  Event_7491_ChoiceDesc2 = {
    Text = "[Sirva-lhes um Bloody Mary vencido] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7491_Desc = {
    Text = "\"Bem-vindo, meu precioso convidado. Sinta-se à vontade para escolher, tudo isso está aqui à sua espera.\"\n\"Desculpe, posso perguntar se você é... a irmã gêmea da senhora Daffodil?\"\n\"Eu sou a própria Daffodil, por favor, o que traz o convidado aqui hoje...?\"\n\"Desculpe, desculpe, você está ainda mais encantadora do que antes, eu não consegui reconhecer. Você se lembra? Há vinte anos, você expulsou um estranho do meu bar... Ontem, o pesadelo recorrente voltou, ele tomou conta do bar, trazendo seus semelhantes, em grandes grupos...\""
  },
  Event_7491_Name = {
    Text = "Fragmento de Memória: Sonho Antigo"
  },
  Event_7492_ChoiceDesc1 = {
    Text = "[Afastar corvos] Obtenha 30 sigilo negro, infectar [(Skill.Arg2)], continue a escolher"
  },
  Event_7492_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Sair"
  },
  Event_7492_Desc = {
    Text = "O segundo corvo partiu, uma pena branca apareceu em sua cauda, parecendo um osso branco"
  },
  Event_7492_Name = {
    Text = "Olhar da Corvo Negro"
  },
  Event_7493_ChoiceDesc1 = {
    Text = "[Apostar] Infectar [(Skill.Arg1)], entrar no jogo"
  },
  Event_7493_ChoiceDesc2 = {
    Text = "[Esqueça] Ganhe 25 sigilos negros"
  },
  Event_7493_Desc = {
    Text = "\n\"Quer fazer uma aposta? Adivinhe nossos números! Por apenas um pequeno preço!\" \nOs dados descartados zumbiam barulhentos, como se estivessem falando com você. \n\"Role-me! Role-me!\" \n\"O único! O último!\" \nCerto, só um... \nVocê pegou uma ficha. Você decide..."
  },
  Event_7493_Name = {
    Text = "Jogo de Apostas Sem Fim"
  },
  Event_7494_ChoiceDesc1 = {
    Text = "[Resist Malice] Ganhe Relíquia de Prata \"(RelicConfig.Arg1)\", Infectado por \"(Skill.Arg2)\""
  },
  Event_7494_ChoiceDesc2 = {
    Text = "[Embrace Malice] Ganhe Relíquia de Prata \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\""
  },
  Event_7494_ChoiceDesc3 = {
    Text = "[Clear-Minded Departure] Ganhar 25 sigilos negros"
  },
  Event_7494_Desc = {
    Text = "O pensamento maligno se tornou uma lâmina, como dentes afiados.\nEles mordem a razão que se desvanece no domínio, devoram a vontade restante, assim como a crueldade que a realidade inflige a você"
  },
  Event_7494_Name = {
    Text = "Pensamento Ilusório"
  },
  Event_7495_ChoiceDesc1 = {
    Text = "[Struggle Fully] Remover 1 Cartão de Comando, ganhar Arg1 O Sigilo Negro"
  },
  Event_7495_ChoiceDesc2 = {
    Text = "[Queimar a teia] copiar 1 carta de comando, infectar[(Skill.Arg1)]"
  },
  Event_7495_ChoiceDesc3 = {
    Text = "[Esperar em Silêncio] Escolha 1 entre 3 cartas de comando e obtenha uma oração:[(EnchantConfig.Arg1)]"
  },
  Event_7495_Desc = {
    Text = "Fios finos se entrelaçam em você como uma teia de aranha; neste momento, você se tornou a presa do domínio"
  },
  Event_7495_Name = {Text = "Enredado"},
  Event_7496_ChoiceDesc1 = {
    Text = "[Destinatário: ∞] Infectar[(Skill.Arg1)]"
  },
  Event_7496_ChoiceDesc2 = {
    Text = "[Destinatário: Eu Mesmo]remova 1 cartão"
  },
  Event_7496_ChoiceDesc3 = {
    Text = "[Destinatário: Professor]ganhe 25 o sigilo negro"
  },
  Event_7496_Desc = {
    Text = "Ele deu ao viajante do domínio uma oportunidade: uma chance de conectar-se ao desconhecido.\nVários papéis deteriorados, uma máquina de escrever exalando tinta, e um destinatário desconhecido e de mão única.\nA vontade pode determinar para onde sua mensagem pode ser enviada"
  },
  Event_7496_Name = {
    Text = "Confissão unidirecional"
  },
  Event_7497_ChoiceDesc1 = {
    Text = "[Consinto Com Prazer]"
  },
  Event_7497_ChoiceDesc2 = {
    Text = "[Rejeição Firme]"
  },
  Event_7497_Desc = {
    Text = "Sussurros ecoam no espaço vazio.\n\"Oh, aquele tolo que continua murmurando 'vencer ou morrer', o infame jogador. É melhor você se manter longe dele.\"\nUma figura magra e curvada lhe lança algumas moedas, o tilintar metálico caindo em sua palma.\n\"Vamos jogar uma rodada.\""
  },
  Event_7497_Name = {
    Text = "Jogador de Azar Famoso"
  },
  Event_7498_ChoiceDesc1 = {
    Text = "[Estamos todos bem] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7498_ChoiceDesc2 = {
    Text = "[Quem é Você?] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7498_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7498_Desc = {
    Text = "A máquina de escrever jorra tinta abruptamente, com tantos pontos de exclamação que ofuscam a vista. \n \"Doll, você está bem??? Por que o Guardião desapareceu e você também desapareceu!!! Por favor, se estiver bem, me mande uma mensagem!!! Se continuar assim, o cabelo do William vai cair todo!!!\""
  },
  Event_7498_Name = {
    Text = "Comunicação de emergência"
  },
  Event_7499_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7499_Desc = {
    Text = "Você colocou o último pedaço de gesso, ela soltou uma risada estridente, uma nuvem negra a envolveu e sua forma flutuante desapareceu de sua vista"
  },
  Event_7499_Name = {
    Text = "Completar o corpo danificado"
  },
  Event_7500_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7500_Desc = {
    Text = "Você tira a chave de prata, segurando-a com reverência enquanto uma luz suave te envolve.\nNo silêncio, só resta um suspiro"
  },
  Event_7500_Name = {
    Text = "Olho do olhar"
  },
  Event_7501_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7501_Desc = {
    Text = "Os olhares remanescentes ainda estão fixos em você, e as células de carne sob sua pele gritam e fogem freneticamente, enquanto os vasos sanguíneos se contorcem como vermes sob a pele.\nVocê sente um poder fluindo, explodindo nas anomalias estranhas de seus membros"
  },
  Event_7501_Name = {
    Text = "Olho do olhar"
  },
  Event_7502_ChoiceDesc1 = {
    Text = "[Evitar Olhar] Despertar aleatoriamente 1 Despertador"
  },
  Event_7502_ChoiceDesc2 = {
    Text = "[encarar o olhar] Escolha despertar 1 despertador, e reduza seu custo de aritmética de carta de despertar em 2 pontos. Infecção[(Skill.Arg1)]"
  },
  Event_7502_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7502_Desc = {
    Text = "O túnel dimensional conecta universos infinitos; na passagem suprema, inúmeros olhos observam vocês que estão se esgueirando"
  },
  Event_7502_Name = {Text = "Seu olhar"},
  Event_7503_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7503_Desc = {
    Text = "Muito confuso, muito confuso.\nTodos os pensamentos foram levados pelo rio da mente, arrastados pela correnteza.\nNo vale do cérebro, restaram apenas confusão e dor"
  },
  Event_7503_Name = {
    Text = "Inspiração súbita"
  },
  Event_7504_ChoiceDesc1 = {Text = "[Pocketed]"},
  Event_7504_Desc = {
    Text = "Parece que o limos saturado contém certas substâncias... Observe-o com a chave de prata e transfira-o para sua própria força"
  },
  Event_7504_Name = {
    Text = "Ponto de extração"
  },
  Event_7505_ChoiceDesc1 = {
    Text = "[Afastar corvos] Obtenha 35 sigilo negro, infectar [(Skill.Arg2)], continue a escolher"
  },
  Event_7505_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Sair"
  },
  Event_7505_Desc = {
    Text = "Um corvo voou, uma pena negra caiu lentamente"
  },
  Event_7505_Name = {
    Text = "Olhar da Corvo Negro"
  },
  Event_7506_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7506_Desc = {
    Text = "Aqui é o campo de batalha do abismo, onde lutar requer coragem e sabedoria.\n\nAbra os olhos, observe seus inimigos, você não precisa derrotar todos, apenas o líder!"
  },
  Event_7506_Name = {
    Text = "Prova dos Asuras"
  },
  Event_7507_ChoiceDesc1 = {
    Text = "[Conectar]recuperar Arg2 de vida"
  },
  Event_7507_Desc = {
    Text = "Você explora na névoa, de repente, o emblema no seu peito emite um fraco brilho prateado. Quem está chamando você do outro lado do comunicador?"
  },
  Event_7507_Name = {
    Text = "Ponto de contato"
  },
  Event_7508_ChoiceDesc1 = {Text = "[Tail Him]"},
  Event_7508_ChoiceDesc2 = {
    Text = "[Saudações]"
  },
  Event_7508_Desc = {
    Text = "Tic. Tic. Tic.\nUma figura branca caminha lentamente na névoa, como um navio navegando na noite silenciosa.\nParece um garoto visto de costas.\nVocê ouve seus passos cansados e toma uma decisão"
  },
  Event_7508_Name = {
    Text = "Cerimônia Final I"
  },
  Event_7509_ChoiceDesc1 = {
    Text = "[Concordo Com Prazer]"
  },
  Event_7509_ChoiceDesc2 = {Text = "[Cuidado]"},
  Event_7509_Desc = {
    Text = "O corpo de fusão caiu gritando, e você se surpreendeu ao ver Clementine parada atrás dele. \n \"Estou aqui para me despedir,\" ela não respondeu a sua pergunta, \"Para expressar minha gratidão, posso lhe dar algumas pistas. Mas... isso exigirá sua confiança. \n Deixe-me hipnotizá-lo, e você saberá tudo o que eu sei.\" \n Você pode confiar nela? \n \"Cuidado,\" Ramona advertiu, \"ela não pode ter outros interesses.\""
  },
  Event_7509_Name = {
    Text = "Terapia de hipnose"
  },
  Event_7510_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7510_Desc = {
    Text = "Você se concentra, a ilusão se dissipa como tinta. Você continua, mas não consegue eliminar a sombra em seu coração"
  },
  Event_7510_Name = {Text = "Ilusão"},
  Event_7511_ChoiceDesc1 = {
    Text = "[Poor Creature?]"
  },
  Event_7511_ChoiceDesc2 = {
    Text = "[Humano Evoluído?]"
  },
  Event_7511_ChoiceDesc3 = {
    Text = "[Quem é você?]"
  },
  Event_7511_Desc = {
    Text = "O homem que vocês viram pela sexta vez está em uma altura de aço, olhando para a Terra. O vento forte levanta seu cabelo longo, revelando a verdadeira forma de uma serpente. \n Seu olhar se concentra em vocês, e, após um momento, é lançado para a escuridão distante. \n \"Ah, que criatura tão miserável. \n A sensação de traição deve ser tão doce quanto a de um humano que <Bold:evoluiu>.\""
  },
  Event_7511_Name = {
    Text = "Companheiro Estranho VI"
  },
  Event_7512_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7512_Desc = {
    Text = "Quem prestaria atenção a um rolo de filme sob o olhar de um cão infernal?"
  },
  Event_7512_Name = {
    Text = "Lembranças luminosas"
  },
  Event_7513_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7513_Desc = {
    Text = "Não olhe, não discuta, não ouça, nem pense—escolha dos sábios"
  },
  Event_7513_Name = {
    Text = "Runa de Frenesi"
  },
  Event_7514_ChoiceDesc1 = {
    Text = "[Leave] Deletar 2 Cartões"
  },
  Event_7514_Desc = {
    Text = "No meio do barulho ao seu redor, você ouviu vagamente um estranho batimento de asas. A Chave de Prata vibrou repentinamente em seu peito, e você foi impulsionado por uma força a olhar para cima, vendo um enorme buraco negro aparecer no céu. \n \"Uma pena, uma pena, mas não se preocupe. Nós nos encontraremos novamente, meu respeitável olho sem visão.\""
  },
  Event_7514_Name = {
    Text = "Terapia de hipnose"
  },
  Event_7515_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7515_Desc = {
    Text = "Você pode ignorar tudo ao redor, mas não o batimento do seu coração. Ele acelera, te apressa e te culpa"
  },
  Event_7515_Name = {
    Text = "Atrium esquerdo"
  },
  Event_7516_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7516_Desc = {
    Text = "\"Isso é ótimo!!! O cabelo do William-senpai está seguro!!!\"\nEmbora fosse apenas uma mensagem de texto, o conteúdo do telegrama fez você imaginar aquele rugido rouco."
  },
  Event_7516_Name = {
    Text = "Comunicação de emergência"
  },
  Event_7517_ChoiceDesc1 = {
    Text = "[Dizer a Verdade] Despertar 1 Desperto Aleatório, Infectar[(Skill.Arg1)]"
  },
  Event_7517_ChoiceDesc2 = {
    Text = "[Conceal the Truth] Ganhar 1 entre 3 Orações"
  },
  Event_7517_Desc = {
    Text = "\"Por favor, salve-me.\"\nO viajante melancólico agarra sua mão. Ele tem vagado aqui por centenas de anos.\n\"Sou um soldado, enviado para a distante leste para combater os hereges.\nAtravessei florestas densas e cruzei rios, mas perdi a direção, voltando repetidamente ao mesmo lugar.\nAlgo está me observando na escuridão. Eu não consigo ver, mas sei. Tem me observado o tempo todo.\nAgora eu só quero voltar para casa...\"\nVocê olha para as sombras flutuantes atrás dele. Elas são inicialmente borradas, depois tornam-se gradualmente nítidas—é uma boca aberta, ansiosa para devorar a alma perdida que foi conservada por cem anos."
  },
  Event_7517_Name = {Text = "Devorador"},
  Event_7518_ChoiceDesc1 = {
    Text = "[Na Escuridão]"
  },
  Event_7518_ChoiceDesc2 = {
    Text = "[Despedida]"
  },
  Event_7518_Desc = {
    Text = "\"Celeste, você vai me ajudar desta vez, certo?\"\nA menina andava de um lado para o outro, hesitante, olhando para o Corpo Desperto quieto. \nEla não respondeu à menina, e quando a expressão da menina se tornava cada vez mais ansiosa, uma brisa suave levantou o véu branco, empurrando delicadamente a menina em direção a um certo lugar. \n\"Eu vou protegê-la.\"\nEu vou protegê-la, mesmo que na questão de \"proteger\", eu tenha falhado uma vez. \nMas desta vez, eu não vou deixar você se perder na escuridão."
  },
  Event_7518_Name = {
    Text = "Bênção da Santa Navegadora"
  },
  Event_7519_ChoiceDesc1 = {
    Text = "[Sair] escolha 1 carta dentre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_7519_Desc = {
    Text = "As canções, algumas antigas, perdidas antes do dilúvio; outras novas, cantando sobre o último ano novo, as luvas novas da esposa... Após a confusão emocional, resta um vazio no coração"
  },
  Event_7519_Name = {
    Text = "Canção do barco"
  },
  Event_7520_ChoiceDesc1 = {
    Text = "[Expel Colors] Obter uma relíquia de ouro \"(RelicConfig.Arg1)\" e infectar \"(Skill.Arg2)\"."
  },
  Event_7520_ChoiceDesc2 = {
    Text = "[Abrace as cores] ganhe 3 seleções de relíquia de ouro, infecção[(Skill.Arg1)]"
  },
  Event_7520_ChoiceDesc3 = {
    Text = "[Vire-se e saia] Obtenha a relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_7520_Desc = {
    Text = "Murphy seguiu de perto, mas parou em um canto.\nCores fluindo giravam à frente, fazendo o ar suspirar.\n\"Murphy@1...\"\nSeria o espírito de um afogado preso no Sonaniel? Ou um ente querido falecido seguindo os vivos?"
  },
  Event_7520_Name = {
    Text = "Cores Nostálgicas"
  },
  Event_7521_ChoiceDesc1 = {
    Text = "[continuar procurando] Aumentar Arg1 ponto de vida, infectar[(Skill.Arg2)]"
  },
  Event_7521_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7521_Desc = {
    Text = "Palavras familiares chegam aos seus ouvidos, reconfortantes e tranquilizadoras, mas quando você tenta seguir o som, ele cessa abruptamente"
  },
  Event_7521_Name = {
    Text = "Contato Anômalo"
  },
  Event_7522_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7522_Desc = {
    Text = "\"Essa era uma melodia blasfema.\"\nVocê cobriu os ouvidos, sangue jorrando, e confirmou isso com certeza."
  },
  Event_7522_Name = {
    Text = "Som proibido"
  },
  Event_7523_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7523_Desc = {
    Text = "Aquelas cores vagamente se distorciam em duas formas humanas, mas elas apenas ficavam naquele canto, oferecendo suas bênçãos finais com o olhar"
  },
  Event_7523_Name = {
    Text = "Cores Nostálgicas"
  },
  Event_7524_ChoiceDesc1 = {
    Text = "[Listen] Obtenha 1 entre 3 Relíquias de Ouro"
  },
  Event_7524_Desc = {
    Text = "A voz de Daffodil pausou por um momento.\n\"Oh, você escolheu isso? Uma boa escolha. Como recompensa, vou te dar um presente especial.\""
  },
  Event_7524_Name = {
    Text = "Tempo de dica"
  },
  Event_7525_ChoiceDesc1 = {
    Text = "[Persistir na Pergunta] Infectar[(Skill.Arg1)]"
  },
  Event_7525_ChoiceDesc2 = {
    Text = "[Abandonar Inquérito] Escolha 1 carta para deletar"
  },
  Event_7525_Desc = {
    Text = "\"Hmm, uma escolha sábia. Enfrentando um inimigo tão formidável, certamente você gostaria de conhecer a si mesmo e ao seu oponente? No entanto, saber muitos segredos sobre dimensões pode perturbar sua mente, você sabe?\""
  },
  Event_7525_Name = {
    Text = "Tempo de dica"
  },
  Event_7526_ChoiceDesc1 = {
    Text = "[Persistent Inquiry] Enfureça Narciso e entre na batalha."
  },
  Event_7526_ChoiceDesc2 = {
    Text = "[Desista de Perguntar] Receba uma pequena penalidade"
  },
  Event_7526_Desc = {
    Text = "\"\"Oh? Ainda assim, você está pensando em me rastrear? Pequeno, ser tão ganancioso não é bom, sabia?\""
  },
  Event_7526_Name = {
    Text = "Tempo de dica"
  },
  Event_7527_ChoiceDesc1 = {
    Text = "[Focar] Aumente a Saúde Máxima de Arg1"
  },
  Event_7527_ChoiceDesc2 = {
    Text = "[Ignorar] 2 Cartas de comando aleatórias obtêm Gravura: \"(EnchantConfig.Arg1)\", infectar 2 \"(Skill.Arg2)\""
  },
  Event_7527_Desc = {
    Text = "Vocês perseguem o cão infernal pelas ruas da cidade.\nFlocos de neve começam a cair, suavemente tocando seus rostos e acalmando seus corações inquietos"
  },
  Event_7527_Name = {Text = "Neve"},
  Event_7528_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7528_Desc = {
    Text = "Você agita os braços, tentando afastar os corvos irritantes.\nEles riem, zombando de sua tolice e fraqueza.\nMesmo assim, sua coragem os impressiona, e você recebe sua recompensa"
  },
  Event_7528_Name = {
    Text = "Canto dos Corvos"
  },
  Event_7529_ChoiceDesc1 = {
    Text = "[Sobre a lily] obtem a relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_7529_ChoiceDesc2 = {
    Text = "[Sobre o Cão Infernal] Obtenha a relíquia de ouro \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7529_Desc = {
    Text = "\nAtravessando a porta sem fim, de um lugar distante e inalcançável, a voz do Narciso chega.\n\"Este é o tempo de dica do Narciso.\""
  },
  Event_7529_Name = {
    Text = "Tempo de dica"
  },
  Event_7530_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7530_Desc = {
    Text = "Você ainda parece teimoso, ainda consegue seguir a si mesmo enquanto canta. \n Você não acredita nas vozes delirantes ao seu ouvido, confiando apenas na razão humana. \n Mas... no dia em que o solo firme que sustenta sua vida for coberto por uma lama espessa e negra, arrancar seus olhos para usar como objeto de espreita será sua única escolha em seus últimos momentos."
  },
  Event_7530_Name = {
    Text = "Canto dos Corvos"
  },
  Event_7531_ChoiceDesc1 = {
    Text = "[Encare a Fonte do Cão Infernal] Obtenha a Relíquia de Ouro \"(RelicConfig.Arg1)\" e infecte \"(Skill.Arg2)\""
  },
  Event_7531_ChoiceDesc2 = {
    Text = "[Concentrar na batalha] escolher 1 entre 3 cartas de comando para obter uma oração:[(EnchantConfig.Arg1)]"
  },
  Event_7531_Desc = {
    Text = "O contorno do cão infernal está mudando.\nSeu corpo se conecta às fendas da parede, revelando ilusões grotescas"
  },
  Event_7531_Name = {
    Text = "vindo do ângulo"
  },
  Event_7532_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7532_Desc = {
    Text = "\"Miau, miau miau, miau miau miau...\"\nVocê forçou sua voz, tentando parecer fraco e inofensivo.\n\"Miau! Miau miau! Miau miau miau!\"\nO grupo de gatos parecia aceitar sua boa vontade, respondendo com chamados alegres. Seus gritos ecoavam para frente e para trás, dia e noite sem pausa, até assustando a lua, que se escondia atrás das nuvens."
  },
  Event_7532_Name = {
    Text = "Cidade dos Gatos"
  },
  Event_7533_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7533_Desc = {
    Text = "Mas são seres lutando para sobreviver, buscando um pedaço de madeira flutuante para descansar...\nVocê suspira, deixando o líquido negro da cauda da borboleta escorrer pelo rosto"
  },
  Event_7533_Name = {
    Text = "Borboleta de Líquido Preto"
  },
  Event_7534_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7534_Desc = {
    Text = "Você usou toda sua força até se afastar dos gatos.\nQuando olhou para trás, eles já estavam em seus lugares. Lambendo-se, cochilando, brigando...\nPara ser honesto, eles não se importam com humanos"
  },
  Event_7534_Name = {
    Text = "Cidade dos Gatos"
  },
  Event_7535_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7535_Desc = {
    Text = "Você jogou os pedaços de carne restantes para os gatos.\nOs gatos avançaram como uma maré negra, rasgando a carne freneticamente e depois se dispersaram rapidamente.\nInfelizmente, era carne estragada. Encheu seus estômagos vazios, mas não foi satisfatório"
  },
  Event_7535_Name = {
    Text = "Cidade dos Gatos"
  },
  Event_7536_ChoiceDesc1 = {
    Text = "[Eye Contact] Obter uma relíquia de ouro \"(RelicConfig.Arg1)\" e infectar \"(Skill.Arg2)\"."
  },
  Event_7536_ChoiceDesc2 = {
    Text = "[Desistir de resistir] Despertar 2 Entidades Aleatórias, Infectar duas vezes[(Skill.Arg1)]"
  },
  Event_7536_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7536_Desc = {
    Text = "Incontáveis olhos sussurram ao seu redor.\n\"Nós viajamos, paramos, avançamos por dezenas de milhares de anos ou mais.\nEnquanto o sol se apaga sob nosso olhar atento, enquanto a vida na Terra antiga é engolida por inundações.\nEstamos há muito tempo cativados pelos mistérios do universo.\""
  },
  Event_7536_Name = {Text = "olho"},
  Event_7537_ChoiceDesc1 = {
    Text = "[Feel Panic] Despertar aleatoriamente 1 Despertador"
  },
  Event_7537_ChoiceDesc2 = {
    Text = "[Sentindo satisfação] Escolha despertar 1 despertador e reduza o custo em 2 pontos de poder de cálculo de sua carta de despertar. Infecte[(Skill.Arg1)]"
  },
  Event_7537_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7537_Desc = {
    Text = "Você já viu um céu sem lua e estrelas, onde flutuam inúmeras pupilas ampliadas. \n Parece que, ao estender a mão, você poderia arrancá-las, espalhando carne e sangue por toda parte. \n Mas ao abrir os dedos, o que você toca é o vazio. \n Os olhos do destino o observam sem piscar, enquanto eles recolhem um grão de areia brilhante do caótico universo."
  },
  Event_7537_Name = {
    Text = "Olho do domo"
  },
  Event_7538_ChoiceDesc1 = {
    Text = "[Largar as Mãos que Tapavam os Ouvidos] ganhe relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_7538_ChoiceDesc2 = {
    Text = "[Continuar Tamponando os Ouvidos] ganha 75 o sigilo negro, infecta[(Skill.Arg2)]"
  },
  Event_7538_Desc = {
    Text = "Grito agudo, um grito agudo sem fim — \n A Cantora Corvo veste um pelo negro e brilhante, com o bico afiado refletindo uma luz fria e dura, seu lamento estridente corta repetidamente seu tímpano. \n Liberte suas mãos que cobrem os ouvidos! \n O bando de corvos que canta à noite quer beber a tremulação não refinada que está dentro do seu corpo encolhido."
  },
  Event_7538_Name = {
    Text = "Canto da Matilha de Corvos"
  },
  Event_7539_ChoiceDesc1 = {
    Text = "[Imitar o Chamado do Gato] Ganhe 50 Sigilos Negros"
  },
  Event_7539_ChoiceDesc2 = {
    Text = "[Alimente] ganhe 75 o sigilo negro, infecção [(Skill.Arg2)]"
  },
  Event_7539_Desc = {
    Text = "Você entrou no território do gato preto.\nIncontáveis olhos se abriram repentinamente na escuridão, cheios de curiosidade, escrutínio e vigilância... mas não havia bondade.\nEsmeralda, âmbar, azul pava...\nVocê parece estar em um mar brilhante de pedras preciosas.\nPara escapar, você——"
  },
  Event_7539_Name = {
    Text = "Cidade dos Gatos"
  },
  Event_7540_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7540_Desc = {
    Text = "Você notou uma mão diferente. Ela era delicada, pálida e sempre calma.\nMais importante, você reconheceu que era sua própria mão.\nVocê a torceu com força.\nGritos agudos encheram seus ouvidos, e o pântano finalmente desapareceu"
  },
  Event_7540_Name = {
    Text = "Pântano Escuro"
  },
  Event_7541_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7541_Desc = {
    Text = "\"Uma decisão sábia.\" disse a sombra de mãos vazias, \"As escolhas já verificadas têm um destino estabelecido, enquanto ações desconhecidas levam a um novo futuro.\"\nUma leve esperança te envolve suavemente. A sombra se dissipa, você se apoia sobre o peito, sem saber se o que acabou de acontecer foi uma projeção ou uma ilusão gerada pela pressão mental."
  },
  Event_7541_Name = {
    Text = "Caminho bifurcado"
  },
  Event_7542_ChoiceDesc1 = {
    Text = "[Elogi-o] Escolha 1 carta de comando entre 3 para obter a oração:[(EnchantConfig.Arg1)]"
  },
  Event_7542_ChoiceDesc2 = {
    Text = "[Provocar] infecta[(Skill.Arg1)], reimprime, até 2 vezes"
  },
  Event_7542_Desc = {
    Text = "O cérebro disse: as correntes aprisionaram meu córtex frontal, meu tronco encefálico, mas não conseguem restringir mais de 10 bilhões de pequenas células que buscam a verdade. \n Você perguntou: quem te prendeu aqui? E seu corpo? \n O cérebro respondeu: corpo? Não me faça rir. No passado, eles costumavam me chamar de \"velho Johnny, o vendedor de carne de porco\". \n Quando tinha corpo, eu mal conseguia fazer adição e subtração até dez. \n Mas agora que o curador removeu meu corpo supérfluo, veja como eu me tornei! Um físico, um filósofo e um poeta amador."
  },
  Event_7542_Name = {
    Text = "Cérebro filosófico"
  },
  Event_7543_ChoiceDesc1 = {
    Text = "[Prove a Conjectura de Goldbach] Obtenha a relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_7543_ChoiceDesc2 = {
    Text = "[Fim da Jornada] Uma carta aleatória ganha um selo:[(EnchantConfig.Arg1)]"
  },
  Event_7543_ChoiceDesc3 = {
    Text = "[Refuse to Ask] Ganhe 50 Sigilos Negros"
  },
  Event_7543_Desc = {
    Text = "Ao pegar a tábua de espiritismo, a voz de uma jovem mulher invadiu sua mente.\n\"Faça-me perguntas, eu sei de tudo.\"\n\"Das minhas respostas, você pode obter o presente do destino.\""
  },
  Event_7543_Name = {
    Text = "Tabuleiro Ouija"
  },
  Event_7544_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7544_Desc = {
    Text = "Você leu o papel rasgado e fragmentado, frases quebradas escapando de sua boca. Palavras como \"Ancestrais,\" \"Criança Sagrada,\" \"Morte Eterna,\" e \"Longa Memória\" inundam sua mente, agitando seus nervos já frágeis atormentados por pesadelos."
  },
  Event_7544_Name = {
    Text = "Ordem secreta · Parte superior"
  },
  Event_7545_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7545_Desc = {
    Text = "Gotas de lama negra caem no seu rosto, causando uma coceira.\nVocê não aguenta e afasta a borboleta.\nA borboleta escapa e desaparece silenciosamente"
  },
  Event_7545_Name = {
    Text = "Borboleta de Líquido Preto"
  },
  Event_7546_ChoiceDesc1 = {
    Text = "[Leave] Encontrar farol de busca"
  },
  Event_7546_ChoiceDesc2 = {
    Text = "[Break into Mist] Perder Arg2 Vida"
  },
  Event_7546_ChoiceDesc3 = {
    Text = "[Entrar Diretamente]"
  },
  Event_7546_Desc = {
    Text = "À frente se encontra uma espessa névoa negra; entrar de forma imprudente trará Clades.\nTalvez você deva encontrar uma \"lanterna\" para dispersar a névoa."
  },
  Event_7546_Name = {
    Text = "desconhecido"
  },
  Event_7547_ChoiceDesc1 = {
    Text = "[Aceitar a Ilusão] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7547_ChoiceDesc2 = {
    Text = "[Negar Fantasma] Obter uma relíquia de prata \"(RelicConfig.Arg1)\" e infectar \"(Skill.Arg2)\"."
  },
  Event_7547_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7547_Desc = {
    Text = "Sob a pesada escuridão da ponte de ferro, na silenciosa margem do rio coberta de juncos, de repente, uma borboleta brilhante voa. \n A borboleta pousa levemente na sua palma, o terrível grito cessa, sendo substituído pelo canto organizado dos trabalhadores carregando vergalhões, o som do martelo de pregos e o tilintar metálico dos rebites..."
  },
  Event_7547_Name = {
    Text = "Ilusão da Ponte de Aço"
  },
  Event_7548_ChoiceDesc1 = {
    Text = "[Afastar corvos] Obtenha 40 sigilo negro, infectar [(Skill.Arg2)], continue a escolher"
  },
  Event_7548_ChoiceDesc2 = {
    Text = "[Continuar Perseguindo a Criança] Ganhe 25 sigilos negros e saia."
  },
  Event_7548_Desc = {
    Text = "Um corvo está parado no lustre. \n Dois corvos estão parados no lustre. \n Três corvos estão parados no lustre. \n … \n Aqueles seres negros torcem o pescoço, parados no lustre da esquina, olhando para você com um olhar malicioso. Aquela cabeça em sombra parece compartilhar o mesmo corpo imerso em lama corrosiva."
  },
  Event_7548_Name = {
    Text = "Olhar da Corvo Negro"
  },
  Event_7549_ChoiceDesc1 = {
    Text = "[Sair] quando o número de despertadores é menor que 3, ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_7549_ChoiceDesc2 = {
    Text = "[Sair] quando o número de despertadores já acordados é pelo menos 3, ganha relíquia de ouro[(RelicConfig.Arg1)]"
  },
  Event_7549_Desc = {
    Text = "Você ignora a marca e avança.\n<Italic: a gnose desperta é tão pesada>, a marca se expande e serpenteia com seus passos, como se a qualquer momento uma mão pudesse surgir da fenda e arrastá-lo para as profundezas"
  },
  Event_7549_Name = {
    Text = "Grieta reptante"
  },
  Event_7550_ChoiceDesc1 = {
    Text = "[Return the Gaze] Ganhe Relíquia de Ouro \"(RelicConfig.Arg1)\", Infecção \"(Skill.Arg2)\""
  },
  Event_7550_ChoiceDesc2 = {
    Text = "[Evitar olhar] Despertar 2 corpos aleatórios, infectar duas vezes [(Skill.Arg1)]"
  },
  Event_7550_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7550_Desc = {
    Text = "Você pode sentir um olhar sobre você, uma perspectiva que transcende dimensões, um olhar muito acima do domínio, observando você e a menina à sua frente.  \nSua respiração começou a acelerar, e na profundidade da sua razão, um medo primal começou a gritar"
  },
  Event_7550_Name = {Text = "Quem olha"},
  Event_7551_ChoiceDesc1 = {
    Text = "[continuar procurando] Aumentar Arg1 ponto de vida, infectar[(Skill.Arg2)]"
  },
  Event_7551_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7551_Desc = {
    Text = "Uma luz tênue apareceu à frente, brilhante e quente, mas desapareceu quando você tentou segui-la"
  },
  Event_7551_Name = {
    Text = "Contato Anômalo"
  },
  Event_7552_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7552_Desc = {
    Text = "Acompanhando suavemente seus cânticos, a correnteza quente traz a bênção de retorno ao lar"
  },
  Event_7552_Name = {
    Text = "Canção do Mar"
  },
  Event_7553_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7553_Desc = {
    Text = "Você vê uma luz fraca à frente e finalmente sai da névoa sufocante"
  },
  Event_7553_Name = {
    Text = "Névoa do Caos"
  },
  Event_7554_ChoiceDesc1 = {
    Text = "[Untangle Lower Branch]"
  },
  Event_7554_Desc = {
    Text = "As conexões de gnose permanecentes entre os domínios se entrelaçam, formando um campo de força instável.\nTalvez você possa desvendar as almas entrelaçadas para traçar um caminho a seguir"
  },
  Event_7554_Name = {
    Text = "Caminho emaranhado"
  },
  Event_7555_ChoiceDesc1 = {
    Text = "[Untangle the upper branches]"
  },
  Event_7555_Desc = {
    Text = "As conexões de gnose permanecentes entre os domínios se entrelaçam, formando um campo de força instável.\nTalvez você possa desvendar as almas entrelaçadas para traçar um caminho a seguir"
  },
  Event_7555_Name = {
    Text = "Caminho emaranhado"
  },
  Event_7556_ChoiceDesc1 = {
    Text = "[Unravel the Left Branch]"
  },
  Event_7556_Desc = {
    Text = "As conexões de gnose permanecentes entre os domínios se entrelaçam, formando um campo de força instável.\nTalvez você possa desvendar as almas entrelaçadas para traçar um caminho a seguir"
  },
  Event_7556_Name = {
    Text = "Caminho emaranhado"
  },
  Event_7557_ChoiceDesc1 = {
    Text = "[Unravel the Left Branch]"
  },
  Event_7557_Desc = {
    Text = "As conexões de gnose permanecentes entre os domínios se entrelaçam, formando um campo de força instável.\nTalvez você possa desvendar as almas entrelaçadas para traçar um caminho a seguir"
  },
  Event_7557_Name = {
    Text = "Caminho emaranhado"
  },
  Event_7558_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7558_Desc = {
    Text = "Vocês ainda enfrentarão muitas batalhas, não é hora de investigar calmamente"
  },
  Event_7558_Name = {
    Text = "Registro de órgãos"
  },
  Event_7559_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7559_Desc = {
    Text = "Os caracteres no papel de repente se tornaram completos e vívidos, com palavras assustadoras suficientes para abalar a crença e a fundação de todos os que sofrem inconscientemente. Quanto mais você lê, mais confuso e aterrorizado fica, incapaz de parar de arranhar o couro cabeludo com as pontas dos dedos. \n De repente, aqueles símbolos cheios de maldição desapareceram. Ramona interrompeu sua leitura e forçou a página a entrar na mala."
  },
  Event_7559_Name = {
    Text = "Ordem secreta · Parte inferior"
  },
  Event_7560_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7560_Desc = {
    Text = "Alegria, tristeza, dor, angústia... são seus sentimentos.\nVocê, e muitos outros você em diferentes dimensões"
  },
  Event_7560_Name = {Text = "Vício"},
  Event_7561_ChoiceDesc1 = {
    Text = "[Ouvir em silêncio] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7561_ChoiceDesc2 = {
    Text = "[Ela está aqui] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7561_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7561_Desc = {
    Text = "O lamento do monstro ecoa na sua mente, na gosma negra informe, uma voz fraca murmura \"Irmã Sasha\", \"Irmã Sasha\".\n\"Irmã Sasha, onde você está?\""
  },
  Event_7561_Name = {
    Text = "\"Irmã Sasha\""
  },
  Event_7562_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7562_Desc = {
    Text = "\"Junte-se a Ele, junte-se a eles, junte-se a nós.\nTorne-se Seu Guardião, torne-se Seu proxy.\nDeixe Seu Sonho guiar seu caminho...\"\nAs orações caóticas agitam sua mente. Depois que as vozes desaparecem, você se encontra ensopado de suor."
  },
  Event_7562_Name = {
    Text = "Prece do Sonho"
  },
  Event_7563_ChoiceDesc1 = {
    Text = "[Nunca Ouvi Falar]"
  },
  Event_7563_ChoiceDesc2 = {
    Text = "[Ouvi Falar de]"
  },
  Event_7563_Desc = {
    Text = "『Caro aluno, pode me dar um momento?\nGostaria de tomar alguns minutos para contar uma lenda local.\nVocê já ouviu falar de uma criatura chamada 'Cérbero'?』"
  },
  Event_7563_Name = {
    Text = "Companheiro Estranho I"
  },
  Event_7564_ChoiceDesc1 = {
    Text = "[Quit Thinking] Obtenha a relíquia amaldiçoada \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7564_ChoiceDesc2 = {
    Text = "[Alcançar a Inspiração] 1 Carta de comando aleatória obtém Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_7564_Desc = {
    Text = "Ataque ao porto, um misterioso navio de carga sem retorno e um novo \"amigo\" com nadadeiras... é uma armadilha bem planejada? Ou mais uma viagem cheia de imprevistos?\nA realidade e a razão se entrelaçam, e uma infinidade de inspirações e pensamentos jorra de minha mente"
  },
  Event_7564_Name = {
    Text = "Inspiração súbita"
  },
  Event_7565_ChoiceDesc1 = {
    Text = "[Vulcão de Elworth?] Aumentar saúde máxima em Arg1"
  },
  Event_7565_ChoiceDesc2 = {
    Text = "[Esforçar-se para Lembrar] Escolha 1 de 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7565_Desc = {
    Text = "As bochechas de Lily derramam lágrimas negras. \"Nós já nos encontramos, mãe,\" ela sussurra, \"na montanha de Elworth...\""
  },
  Event_7565_Name = {
    Text = "Memórias vulcânicas"
  },
  Event_7566_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7566_Desc = {
    Text = "\"Submergir@1... no mar...\"\n Runa aparece diante de você, intermitente, e você não consegue evitar de estender a mão para o vazio, tentando agarrá-las — \n \"O que você está fazendo parado! Eles estão se aproximando!\"\n A Garota Misteriosa puxa você para correr em direção ao outro lado do convés, interrompendo sua conexão com as runas. \n Mas de fato, algo deixou marcas em suas pontas dos dedos."
  },
  Event_7566_Name = {
    Text = "Runa de Frenesi"
  },
  Event_7567_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7567_Desc = {
    Text = "Você não tem interesse nos murmúrios enigmáticos, muito menos quer arriscar a loucura entrando na escuridão"
  },
  Event_7567_Name = {
    Text = "Um pedido de socorro"
  },
  Event_7568_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7568_Desc = {
    Text = "De qualquer forma, o dever do Guardião cresce em seu peito, você não pode desistir de encontrar o remetente, mesmo que seja vago e obscuro"
  },
  Event_7568_Name = {
    Text = "Um pedido de socorro"
  },
  Event_7569_ChoiceDesc1 = {
    Text = "[Observar Isso] Ganhe 25 sigilos negros"
  },
  Event_7569_ChoiceDesc2 = {
    Text = "[Pet It] 50% de chance de ganhar 50 Sigilos Negros, 50% de chance de não obter nada"
  },
  Event_7569_Desc = {
    Text = "De repente, um gato preto saltou de um beco, esfregando-se afetuosamente em suas pernas, suas pupilas verticais verdes brilhando com uma luz arrepiante, como se dissesse: \"Pare de perseguir, venha brincar comigo por um tempo.\" \n \"Você já o viu, ele está ao seu lado, aquelas sombras contaminadas pela loucura e fanatismo... não olhe diretamente para o contorno dele.\""
  },
  Event_7569_Name = {
    Text = "Elfo Noturno"
  },
  Event_7570_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7570_Desc = {
    Text = "\"Impossível, eu não acredito nisso!\" A voz gritou, \"Esta mulher que me mandou para o diabo não é minha irmã Shasha!\""
  },
  Event_7570_Name = {
    Text = "\"Irmã Sasha\""
  },
  Event_7571_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7571_Desc = {
    Text = "\"Recebido. Vamos prosseguir com a entrega básica de inventário. Por favor, verifique e confirme.\""
  },
  Event_7571_Name = {
    Text = "Comunicação de apoio"
  },
  Event_7572_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7572_Desc = {
    Text = "Objeto inútil"
  },
  Event_7572_Name = {
    Text = "Relíquias dos antigos"
  },
  Event_7573_ChoiceDesc1 = {
    Text = "[Look Closely] Ganhe 1 entre 3 Orações"
  },
  Event_7573_ChoiceDesc2 = {
    Text = "[Arrancar o cartaz] 1 Carta de comando aleatória obtém Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7573_Desc = {
    Text = "Um candelabro comum em um museu de cera.\nÀ luz laranja doentia, você vê um pôster desenhado à mão na parede"
  },
  Event_7573_Name = {
    Text = "Risada na Escuridão"
  },
  Event_7574_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7574_Desc = {
    Text = "\"Lily tem seu próprio coração; ela não precisa ouvir ninguém.\" Você respondeu calmamente.\nFrancis resmungou, sem oferecer resposta."
  },
  Event_7574_Name = {
    Text = "Sua escolha"
  },
  Event_7575_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7575_Desc = {
    Text = "Esta é uma série de fotos de grupo. \n Pessoas apáticas estão agachadas atrás da grade de ferro, com rostos cheios de sofrimento. \n Uma das fotos chamou sua atenção. Deve ser uma jovem mulher magra, com o rosto em branco. \n Aquela criatura profana está se enrolando ao redor de seu corpo em círculos. \n Você não pode ver seu rosto, mas na sua imaginação, ela deve estar sem expressão."
  },
  Event_7575_Name = {
    Text = "registrar fielmente"
  },
  Event_7576_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7576_Desc = {
    Text = "Você contempla obcecadamente essas joias reluzentes e, sem perceber, já segura a mão negra e viscosa de dedos ossudos.\nEla apenas aperta levemente a mão, depois a solta.\nNada acontece, apenas um fio de névoa negra desliza pela ponta dos seus dedos e se esgueira pela manga."
  },
  Event_7576_Name = {
    Text = "Inverter as Garras do Mal"
  },
  Event_7577_ChoiceDesc1 = {
    Text = "[Play a Few Notes] Ganhe a relíquia de prata \"(RelicConfig.Arg1)\" e inflija \"(Skill.Arg2)\"."
  },
  Event_7577_ChoiceDesc2 = {
    Text = "[Colocar a Tampa] Obter uma Oração de 3 escolhas"
  },
  Event_7577_Desc = {
    Text = "O piano ao lado da parede está aberto. Tem teclas amareladas e bordas rachadas, mas cada tecla está muito limpa.\nÉ a fonte de alegria de muitas pessoas"
  },
  Event_7577_Name = {
    Text = "Melodia da Infância"
  },
  Event_7578_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7578_Desc = {
    Text = "O portador da lança soltou um gemido, como uma criança sendo maltratada.\nA voz passou em um instante, junto com os outros dois marinheiros desaparecendo… na verdade, foi apenas uma ilusão refletida pelo domínio"
  },
  Event_7578_Name = {
    Text = "Perseguir incansavelmente"
  },
  Event_7579_ChoiceDesc1 = {
    Text = "[Sair] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_7579_Desc = {
    Text = "\"Correto.\"\nA dona da voz estava muito satisfeita com a resposta, e um objeto brilhante foi jogado para fora da água.\n\"Lembre-se, tudo tem um preço.\""
  },
  Event_7579_Name = {
    Text = "Voz fora do mundo"
  },
  Event_7580_ChoiceDesc1 = {
    Text = "[Dissipar a Ilusão] Sintoma infectado."
  },
  Event_7580_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7580_Desc = {
    Text = "Rostos borrados aparecem de repente, gemendo desesperadamente ao seu redor"
  },
  Event_7580_Name = {Text = "Ilusão"},
  Event_7581_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7581_Desc = {
    Text = "Você ignorou a marca e seguiu em frente.\nMas parecia estar irritado, a marca se expandiu e se contorceu com seus passos, como se uma mão pudesse sair da fenda a qualquer momento e puxá-lo para dentro"
  },
  Event_7581_Name = {
    Text = "Grieta reptante"
  },
  Event_7582_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7582_Desc = {
    Text = "Você não se deixa enganar facilmente, vira-se decisivamente e sai"
  },
  Event_7582_Name = {
    Text = "Grieta reptante"
  },
  Event_7583_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7583_Desc = {
    Text = "Você percebe a estranheza da rachadura, se agacha para examinar, mas ela, que estava se espalhando, de repente para, como se tivesse morrido"
  },
  Event_7583_Name = {
    Text = "Grieta reptante"
  },
  Event_7584_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7584_Desc = {
    Text = "\"Não, é uma mente clara. Determinação não pode resolver corpos dissolutos, guardião, pense bem na estratégia.\""
  },
  Event_7584_Name = {
    Text = "Regra de Logan"
  },
  Event_7585_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7585_Desc = {
    Text = "Você não consegue resistir ao impulso interior. \n Seus dedos vagam e brincam pelo teclado como crianças perdidas na floresta... \n Gradualmente, borboletas começaram a voar da máquina de escrever. \n Uma, duas, três... \n No rosto, nos dedos, borboletas em grupo brilhavam como fogos de artifício no escuro, com um brilho semelhante a pedras preciosas. \n Esta máquina de escrever não tem utilidade prática, mas é excelente em criar beleza."
  },
  Event_7585_Name = {Text = "olho"},
  Event_7586_ChoiceDesc1 = {
    Text = "[Amarre a Galinha]"
  },
  Event_7586_Desc = {
    Text = "Produto local de Lai, galinhas vivas, uma tentação culinária"
  },
  Event_7586_Name = {
    Text = "Fabricar uma armadilha"
  },
  Event_7587_ChoiceDesc1 = {
    Text = "[Missão Cumprida]"
  },
  Event_7587_Desc = {
    Text = "Armadilhas baratas, mas eficazes!"
  },
  Event_7587_Name = {
    Text = "Fabricar uma armadilha"
  },
  Event_7588_ChoiceDesc1 = {
    Text = "[Set a Trap]"
  },
  Event_7588_Desc = {
    Text = "Armadilha de metal, a melhor amiga do caçador preguiçoso"
  },
  Event_7588_Name = {
    Text = "Fabricar uma armadilha"
  },
  Event_7589_ChoiceDesc1 = {
    Text = "[Check Teletype] Infecte \"(Skill.Arg1)\", obtenha Relíquia de Ouro \"(RelicConfig.Arg2)\""
  },
  Event_7589_ChoiceDesc2 = {
    Text = "[Desconsiderar] Ganhar 50 Sigilos Negros"
  },
  Event_7589_Desc = {
    Text = "Você se esconde em uma fenda na caverna para evitar a tempestade. Mas sabe que não pode ficar muito tempo, se os homens de preto te encontrarem, não terá para onde fugir. \nNo canto da fenda, você encontra um telégrafo"
  },
  Event_7589_Name = {
    Text = "Telegrama Silencioso"
  },
  Event_7590_ChoiceDesc1 = {
    Text = "[Check the Film] Melhorar os efeitos da oração de 2 cartas aleatórias"
  },
  Event_7590_ChoiceDesc2 = {
    Text = "[Check camera] escolha 1 de 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_7590_Desc = {
    Text = "Como se estivesse puxando um órgão, o filme dentro da câmera foi rasgado em pedaços, jogado aqui sem ninguém para se importar. \n Um clarão ofuscante passou, a câmera abandonada na esquina estava inclinada, com o obturador pressionado do nada. \n \"Clique——\" \n Sua expressão de surpresa e confusão foi fielmente registrada no filme da câmera."
  },
  Event_7590_Name = {
    Text = "Registro de inocência"
  },
  Event_7591_ChoiceDesc1 = {
    Text = "[Strangle the Singer] Ganhe relíquia amaldiçoada \"(RelicConfig.Arg1)\", e inflija \"(Skill.Arg2)\"."
  },
  Event_7591_ChoiceDesc2 = {
    Text = "[Fazer o Dançarino Tropeçar] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_7591_ChoiceDesc3 = {
    Text = "[Steal the Poet's Manuscript] Ganhe 50 Sigilos Negros"
  },
  Event_7591_Desc = {
    Text = "Você é bloqueado por três figuras pegajosas. \n Uma figura canta, sua voz rouca e as letras estranhas, você tapa os ouvidos e a evita. \n Uma figura dança, seus movimentos rígidos e passos hesitantes, você fecha os olhos e a desvia. \n Uma figura recita poesia, seu ritmo fragmentado e frases desconexas, você não pode mais suportar, então—"
  },
  Event_7591_Name = {
    Text = "Vilão no Caminho Estreito"
  },
  Event_7592_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7592_Desc = {
    Text = "\"Não! O progresso da humanidade não se baseia na história, nem na tecnologia, mas sim nos ratos.\"\n\"Foram os ratos que iniciaram aquela era sombria, e somente depois a humanidade encontrou a luz do renascimento.\"\n\"A humanidade precisa de vocês - embora nem todos compreendam isso.\"\nOs ratos ficaram um pouco confusos com seu longo discurso, mas ainda assim deixaram você ir."
  },
  Event_7592_Name = {Text = "Peste"},
  Event_7593_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7593_Desc = {
    Text = "Você resistiu à contração do nervo óptico, tentando reconhecer...\nParece haver um círculo mágico rasgado desenhado ali.\nDentro do círculo, inúmeras linhas curvas formam um padrão que parece estático e ao mesmo tempo fluido, hipnotizante"
  },
  Event_7593_Name = {
    Text = "vindo do ângulo"
  },
  Event_7594_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7594_Desc = {
    Text = "<Bold:Museu de Cera Rogers\nRua Southwark, 44, Cidade de Lentini@2Distrito\nHorário de visita: 21:00-6:00\nEntrada até 3:00 (fechado nos fins de semana)\n\n<Bold:Exposição Atual\nVladimir@2:\nA Filosofia do Sorriso"
  },
  Event_7594_Name = {
    Text = "Risada na Escuridão"
  },
  Event_7595_ChoiceDesc1 = {
    Text = "[Eye Contact] Escolher 1 de 3 cartas de comando para ganhar uma oração: \"(EnchantConfig.Arg1)\", e infectar \"(Skill.Arg2)\"."
  },
  Event_7595_ChoiceDesc2 = {
    Text = "[Fechar os Olhos] Escolha 1 Entidade para despertar, Infecte[(Skill.Arg1)]"
  },
  Event_7595_ChoiceDesc3 = {
    Text = "[Vire as Costas] Ganhe 25 sigilos negros"
  },
  Event_7595_Desc = {
    Text = "Não era para se ver o céu estrelado. \n No domínio do Sona-Nyl, o céu brilha com luzes deslumbrantes, e as estrelas e a lua estão ocultas. \n Na escuridão do porão, você também não deveria ver o céu estrelado. \n Aqui deveria haver apenas lâmpadas incandescentes esparsas e lanternas antigas — mas por que você ainda sente o olhar que paira no alto do céu?"
  },
  Event_7595_Name = {Text = "Espiar"},
  Event_7596_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7596_Desc = {
    Text = "Você escolhe olhar para os olhos com coragem.\nEles são estrelas brilhantes, cintilando na escuridão.\nEntão, eles começam a rir e se transformam em inúmeras luas crescentes.\nOs olhos dizem: \"Você não teme o olhar. Você também não deve temer... há muito não te vejo, @2\"\nAntes de desaparecer, eles te dão um pequeno presente, como uma \"lembrança do reencontro\"."
  },
  Event_7596_Name = {Text = "olho"},
  Event_7597_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7597_Desc = {
    Text = "A ponte ferroviária, os vasos e nervos de Londinium, conectam o coração e extremidades da cidade. Enquanto o sol não tiver caído aqui, o coração de Londinium pulsará vigorosamente."
  },
  Event_7597_Name = {
    Text = "Ilusão da Ponte de Aço"
  },
  Event_7598_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7598_Desc = {
    Text = "Uma fuga colossal e esplêndida, o autor é desconhecido.  \nInúmeras partes se entrelaçam com temas semelhantes, cada nota precisa como o bisturi de um cirurgião, fria e calculista.  \nPrecisão e esplendor — essa é a estética de Rogers.  \nFuga, voe!"
  },
  Event_7598_Name = {Text = "gosto ruim"},
  Event_7599_ChoiceDesc1 = {
    Text = "[Cumprimente em Voz Alta]"
  },
  Event_7599_ChoiceDesc2 = {
    Text = "[Seek Help]"
  },
  Event_7599_Desc = {
    Text = "No momento em que você se apoiou na borda do barco, viu uma menina de vestido branco. \n Nobre, pura, etérea... e um pouco familiar. \n Onde você a teria visto antes? Enquanto você lutava para escavar memórias confusas, ela de repente pareceu perceber sua presença, olhando para você através do vazio. \n Seus olhos eram calmos como o oceano na primavera, mas você estranhamente leu algo neles... \n Ela parecia estar esperando que você a cumprimentasse, mesmo que fosse apenas para falar sobre o tempo de hoje."
  },
  Event_7599_Name = {
    Text = "menina de vestido branco"
  },
  Event_7600_ChoiceDesc1 = {
    Text = "[Elogi-o] Escolha 1 carta de comando entre 3 para obter a oração:[(EnchantConfig.Arg1)]"
  },
  Event_7600_ChoiceDesc2 = {
    Text = "[Provocar] infecta[(Skill.Arg1)], reimprime de forma aleatória novamente"
  },
  Event_7600_Desc = {
    Text = "Jenkins disse: Johnny! Você realmente é... muito diferente do que antes, em todos os aspectos. \n Você disse: Você realmente é uma mente trabalhadora e ambiciosa. \n A mente se contorceu um pouco, claramente muito feliz. \n A mente disse: Vamos lá! Já que vocês reconhecem tanto minhas conquistas atuais, eu lhes concederei todo o meu conhecimento..."
  },
  Event_7600_Name = {
    Text = "Cérebro filosófico"
  },
  Event_7601_ChoiceDesc1 = {
    Text = "[Graceful Fugue] Obtenha a relíquia de prata \"(RelicConfig.Arg1)\" e torne-se infectado com \"(Skill.Arg2)\"."
  },
  Event_7601_ChoiceDesc2 = {
    Text = "[pequena serenata] Todos os Despertos recuperam 50 de Loucura, infectar[(Skill.Arg1)]"
  },
  Event_7601_ChoiceDesc3 = {
    Text = "[Ruído Sem Sentido] Obtenha uma Oração de 3 escolhas"
  },
  Event_7601_Desc = {
    Text = "\"Pessoalmente, não concordo muito com o gosto do curador em música, você sabe...\nÉ muito chamativa, e eu sou uma pessoa pé no chão.\"\nUma voz masculina cansada emanou do gramofone rangente, lamentando na solidão.\n\"Mas este é meu trabalho... Certo, vamos economizar tempo e escolher um.\""
  },
  Event_7601_Name = {Text = "gosto ruim"},
  Event_7602_ChoiceDesc1 = {
    Text = "[Having special relic，ganha relíquia de ouro\"(RelicConfig.Arg1)\"]"
  },
  Event_7602_ChoiceDesc2 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7602_Desc = {
    Text = "Evento 253 (em desenvolvimento), não é o efeito final"
  },
  Event_7602_Name = {
    Text = "Evento 253 (em desenvolvimento)"
  },
  Event_7603_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7603_Desc = {
    Text = "Você correu o mais rápido que pôde.\nAgora vocês enfrentam os monstros mais difíceis e nojentos de todos—essas estátuas de cera.\nComparado a elas, esses bonecos de barro são nada.\nPriorizar é uma das regras dos guardiões do segredo"
  },
  Event_7603_Name = {Text = "Estudo"},
  Event_7604_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7604_Desc = {
    Text = "A Chave de Prata piscou, e o brilho prateado preencheu o espaço, tingindo o fluido denso de cores com um prata puro. \n A luz desapareceu em um instante, restando apenas o vento com seu lamento triste."
  },
  Event_7604_Name = {
    Text = "Cores Nostálgicas"
  },
  Event_7605_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7605_Desc = {
    Text = "Aquele arco-íris te deixou deslumbrado, e sem perceber, você se perdeu nele"
  },
  Event_7605_Name = {
    Text = "Cruzamento Estelar"
  },
  Event_7606_ChoiceDesc1 = {
    Text = "[continuar caindo] Infectar[(Skill.Arg1)], continuar caindo?"
  },
  Event_7606_ChoiceDesc2 = {
    Text = "[Puxe para Lado] Ganhar 25 Sigilos Negros"
  },
  Event_7606_Desc = {
    Text = "\"Você\" o convida.\nNas profundezas do espiral, o passado e o futuro \"você\" lhe enviam \"presentes\" de diferentes dimensões."
  },
  Event_7606_Name = {
    Text = "Abismo Espiral"
  },
  Event_7607_ChoiceDesc1 = {
    Text = "[Understanding] Obtenha uma relíquia de ouro \"(RelicConfig.Arg1)\" e fique infectado com \"(Skill.Arg2)\"."
  },
  Event_7607_ChoiceDesc2 = {
    Text = "[Ignorância Total] Adquirir 3 entre 1 relíquia de ouro, infecção[(Skill.Arg1)]"
  },
  Event_7607_ChoiceDesc3 = {
    Text = "[Sair] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_7607_Desc = {
    Text = "Duas sombras brilhantes de prata aparecem diante de você, apresentando-se como um líquido denso, flutuando no ar. \n \"Aqui é o lugar onde eu realmente desapareci.\" Uma das sombras se agachou. \n \"No Reino Divino, livre de doenças e desastres, não existe tal coisa como desejo e perda, você realmente não sabe — o que significa desaparecer.\" \n A outra sombra suspirou, voltando o olhar para você."
  },
  Event_7607_Name = {
    Text = "Reino Esquecido dos Deuses"
  },
  Event_7608_ChoiceDesc1 = {
    Text = "[Leave] Encontrar farol de busca"
  },
  Event_7608_ChoiceDesc2 = {
    Text = "[Invadir Névoa] Infecte[(Skill.Arg2)]"
  },
  Event_7608_ChoiceDesc3 = {
    Text = "[Entrar Diretamente]"
  },
  Event_7608_Desc = {
    Text = "À frente se encontra uma espessa névoa negra; entrar de forma imprudente trará Clades.\nTalvez você deva encontrar uma \"lanterna\" para dispersar a névoa."
  },
  Event_7608_Name = {
    Text = "desconhecido"
  },
  Event_7609_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7609_Desc = {
    Text = "\"Essa é a projeção da memória,\" Ramona explicou a você, \"Pode pertencer a uma certa pessoa, ou pode ser uma memória compartilhada de várias pessoas.\"\nMemórias preciosas merecem uma cuidadosa vigilância."
  },
  Event_7609_Name = {
    Text = "Nossas Memórias"
  },
  Event_7610_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7610_Desc = {
    Text = "Mesmo sem entender agora, você não desistiu, dobrou a carta e guardou no bolso, esperando ler depois.\nMas, conforme a carta se enrugava misteriosamente, seu peito começou a doer"
  },
  Event_7610_Name = {
    Text = "Carta riscada"
  },
  Event_7611_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7611_Desc = {
    Text = "A vela acendeu automaticamente ao sair da balança, derramando lágrimas brancas que desapareceram entre seus dedos"
  },
  Event_7611_Name = {
    Text = "Razão e Emoção"
  },
  Event_7612_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7612_Desc = {
    Text = "Apressadamente, você puxa o papel da máquina de escrever—mas ela continua funcionando. Neste momento de pânico, uma Carta de comando cai dentro e fica inutilizável, manchada com a mais negra das tintas.\nVocê para um momento para descartá-la com cuidado, mas não consegue deixar de notar o texto ominoso e repetido agora escrito nela;\n<Bold:NÃO OLHE DIRETAMENTE>\n<Bold:NÃO OLHE DIRETAMENTE>\n<Bold:NÃO OLHE DIRETAMENTE>\n<Bold:NÃO OLHE DIRETAMENTE>\n<Bold:NÃO OLHE DIRETAMENTE>\n<Bold:NÃO OLHE DIRETAMENTE>\n<Bold:NÃO OLHE DIRETAMENTE>\n<Bold:NÃO OLHE DIRETAMENTE>"
  },
  Event_7612_Name = {
    Text = "Aviso Não Convidado"
  },
  Event_7613_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7613_Desc = {
    Text = "Ao tocar a borda gelada do copo, você estremece e acorda.\nDe qualquer forma, não deve ser deixado na estrada. Melhor guardá-lo na mala"
  },
  Event_7613_Name = {
    Text = "Vinho doce de mel"
  },
  Event_7614_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7614_Desc = {
    Text = "Você tosse fortemente.\nO som parece assustado e depois cai em silêncio.\nVocê sente que perdeu uma pista importante...\nMas a vida é cheia de perdas e arrependimentos, não é?"
  },
  Event_7614_Name = {
    Text = "Os muros têm ouvidos"
  },
  Event_7615_ChoiceDesc1 = {
    Text = "[Keep Silent] Ganhe 25 Sigilos Negros"
  },
  Event_7615_ChoiceDesc2 = {
    Text = "[Alcance e Toque] 50% de chance de ganhar 50 Sigilos Negros, 50% de chance de nada."
  },
  Event_7615_Desc = {
    Text = "\"Eu só tenho um ditado para dizer - ninguém pode matar um gato!\"\n\"Aquele maldito gato preto deveria ter sido eviscerado e deixado para apodrecer no deserto, mas ele cavou a sepultura da minha família, devorando a carne humana em decomposição, enquanto os ossos e membros se espalhavam em pedaços.\"\n\"Sob o olhar gélido e escuro das pupilas verticais, um líquido amarelo e espesso subiu com um fedor, e eu escapei rolando e rastejando, atormentado por pesadelos que deixaram minha mente abatida.\"\n\"Espere... o que vocês estão fazendo? Eu não estou louco! Eu não estou! Vocês devem estar tentando encobrir algo! Isso é verdade——\"\nE realmente é verdade, enquanto você observa a sombra do homem enlouquecido desaparecer, você e o gato preto que está quieto ao seu lado trocam um olhar."
  },
  Event_7615_Name = {
    Text = "Desgraça do Gato Noturno"
  },
  Event_7616_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7616_Desc = {
    Text = "Enquanto você hesitava, ele afundou e se fundiu com a marca de corrosão, desaparecendo rapidamente"
  },
  Event_7616_Name = {
    Text = "Objeto flutuante no balde"
  },
  Event_7617_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7617_Desc = {
    Text = "Você amassou a carta com irritação e a jogou no chão"
  },
  Event_7617_Name = {
    Text = "Carta riscada"
  },
  Event_7618_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7618_Desc = {
    Text = "Você se concentra, a ilusão se dissipa como tinta. Você continua, mas não consegue eliminar a sombra em seu coração"
  },
  Event_7618_Name = {Text = "Ilusão"},
  Event_7619_ChoiceDesc1 = {
    Text = "[Examine Carefully] Obtenha Relíquia de Prata \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_7619_ChoiceDesc2 = {
    Text = "[Evitar Sombras] Obter uma Relíquia de Prata \"(RelicConfig.Arg1)\" e infectar \"(Skill.Arg2)\""
  },
  Event_7619_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_7619_Desc = {
    Text = [[
Ramona estava tensa, movendo-se cuidadosamente pelo asilo.
Ela se escondeu em um quarto pequeno.
Uma sombra apareceu na janela]]
  },
  Event_7619_Name = {
    Text = "Reflexo na janela"
  },
  Event_7620_ChoiceDesc1 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_7620_Desc = {
    Text = "Agora, o mais importante é levar o culpado à justiça. Mas a semente da raiva ainda cresce em seu coração. Sem esperar resposta, o homem se afastou"
  },
  Event_7620_Name = {
    Text = "Pista de Besta Gigante"
  },
  Event_7621_ChoiceDesc1 = {
    Text = "[Sair] ganha 75 o sigilo negro, infecção de[(Skill.Arg2)]"
  },
  Event_7621_Desc = {
    Text = "A educação que você recebeu desde a infância em Mythag tornou impossível ignorar esta impressão. Você limpou as pegadas empoeiradas e, naquele momento, parecia ouvir uma resposta de uma dimensão distante: \"Obrigado\"."
  },
  Event_7621_Name = {
    Text = "Pista de Besta Gigante"
  },
  Event_7622_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7622_Desc = {
    Text = "Você aperta a chave de prata, a suave luz prateada e a leve vibração trazem-lhe uma sensação de paz. O olhar parece desaparecer, mas também não, de qualquer forma, deixou uma marca invisível em você"
  },
  Event_7622_Name = {Text = "Quem olha"},
  Event_7623_ChoiceDesc1 = {
    Text = "[Encontrar o Caminho Secreto]"
  },
  Event_7623_Desc = {
    Text = "Você, Ramona e Lotan se dividem em três direções e começam a perseguir o Cão do inferno.\n\nVocê corre rapidamente por algumas vielas, e um corpo enorme aparece à sua frente.\nAo ver você se aproximando, ele imediatamente vira na próxima esquina.\nVocê corre atrás, mas o que aparece à sua frente é um beco sem saída, com altas paredes cercando um céu quadrado e estreito."
  },
  Event_7623_Name = {
    Text = "Beco sem saída"
  },
  Event_7624_ChoiceDesc1 = {
    Text = "[Walk Past]"
  },
  Event_7624_ChoiceDesc2 = {Text = "[Pat]"},
  Event_7624_Desc = {
    Text = "Ao lado da mesa de cirurgia limpa e macia, está o corpo inerte de Kum. \nEla ainda é alta, como uma pequena montanha, como quando a viu pela primeira vez. \nNo entanto, comparada a um verdadeiro \"cão infernal\" nas alturas, ela parece tão pequena, tão infantil"
  },
  Event_7624_Name = {
    Text = "Resíduo de calor"
  },
  Event_7625_ChoiceDesc1 = {
    Text = "[Obtenha Prata]"
  },
  Event_7625_Desc = {
    Text = "Huh, há muitas coisas brilhantes à frente!\nCheire... Cheira bem.\nLamba... Geladinho!\nParece valioso, vamos entregar ao pequeno Jenkins, talvez troque por muito queijo!"
  },
  Event_7625_Name = {Text = "Brilhante"},
  Event_7626_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7626_Desc = {
    Text = "Uma decepção que não é sua se espalha em seu coração, a rede ilusória se dissipa lentamente, abrindo um caminho"
  },
  Event_7626_Name = {
    Text = "Rede errante"
  },
  Event_7627_ChoiceDesc1 = {
    Text = "[Compreender] Despertar aleatoriamente 1 despertador, infectar [(Skill.Arg1)]"
  },
  Event_7627_ChoiceDesc2 = {
    Text = "[Ignorar Isso] Receba Oração com 3 opções"
  },
  Event_7627_Desc = {
    Text = "Runas fluentes emergem do rugido da vida em forma de peixe, preenchendo seus ouvidos, nariz e garganta. Elas queimam seu corpo, e em dez segundos você entenderá o significado do rugido"
  },
  Event_7627_Name = {
    Text = "Runa de Frenesi"
  },
  Event_7628_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7628_Desc = {
    Text = "Você mordeu os lábios e tentou resistir à ilusão confusa. Ramona colocou um objeto frio em sua palma. \n“Esta relíquia que descobri pode ajudá-lo.”"
  },
  Event_7628_Name = {
    Text = "Ilusão Dimensional"
  },
  Event_7629_ChoiceDesc1 = {
    Text = "Escolha uma oração avançada"
  },
  Event_7630_ChoiceDesc1 = {
    Text = "[Segurar o Corvo] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7630_ChoiceDesc2 = {
    Text = "[Kill Crow] Ganhe 3 opções de Oração"
  },
  Event_7630_ChoiceDesc3 = {Text = "[Leave]"},
  Event_7630_Desc = {
    Text = "A corvo solitário grasna roucamente, arrancando suas penas pretas uma a uma.\nEle treme de dor, gritando incontrolavelmente à medida que seus movimentos frenéticos aumentam.\n\"Caw—Caw—\"\nLágrimas azuis misturadas com seiva preta jorram de seus olhos, presenciadas por ninguém além de você.\n"
  },
  Event_7630_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7631_ChoiceDesc1 = {
    Text = "[Leave] Aumentar saúde máxima em Arg1"
  },
  Event_7631_Desc = {
    Text = "\"Deixe comigo,\" você acariciou a espinha da besta, como se estivesse acalmando um gatinho irritado, \"ela certamente vai acordar, nós não vamos machucá-la.\""
  },
  Event_7631_Name = {
    Text = "Chamado da Amizade"
  },
  Event_7632_ChoiceDesc1 = {
    Text = "[Leave] Aumente a vida máxima em Arg1, infecte \"(Skill.Arg2)\" e \"(Skill.Arg3)\""
  },
  Event_7632_Desc = {
    Text = "\"Acorde, Lily. Kume também espera que você acorde logo—\""
  },
  Event_7632_Name = {
    Text = "Chamado da Amizade"
  },
  Event_7633_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7633_Desc = {
    Text = "Objeto inútil"
  },
  Event_7633_Name = {
    Text = "Telegrama Silencioso"
  },
  Event_79429_ChoiceDesc1 = {
    Text = "Escolha um despertador e transforme-o nos \"Insetos\" por meio do ritual de vida. O custo de aritmética das cartas de comando dos \"Insetos\" diminui em 1, mas serão consumidas após serem jogadas."
  },
  Event_79429_Desc = {
    Text = "\"Durante o processo de autoconhecimento, sempre há dor, assim como a metamorfose e o novo nascido.\"\nEla sorri suavemente, acariciando seu rosto com ternura.\n\"Não tenha medo, estou aqui com você, então abra sua alma e tudo, aceite-os.\"\n\"Bom menino, estou esperando pelo seu novo nascido, esperando que você... se torne um de nós.\""
  },
  Event_79429_Name = {
    Text = "Metamorfose da vida"
  },
  Event_80463_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para relíquia de prata, infecção de[(Skill.Arg1)]"
  },
  Event_80463_Desc = {
    Text = "Você escolheu o caminho e correu desesperadamente, puxando o pequeno William.\nFelizmente, sua escolha estava correta.\nAquela poluição espiritual, aquelas Clementines idênticas, finalmente foram deixadas para trás.\nClaro, você pagou um certo preço."
  },
  Event_80463_Name = {
    Text = "As \"Clementines\""
  },
  Event_80464_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80464_Desc = {
    Text = "Uma memória além da compreensão é injetada em seu cérebro, destruindo diretamente sua sanidade.\nNaquelas imagens aceleradas como avanço rápido, você só se lembra de uma cena: o Templo triangular\nEssa foi uma grande obra construída pela raça @2 para o @4 sublime e tolo."
  },
  Event_80464_Name = {
    Text = "Memória Profunda"
  },
  Event_80465_ChoiceDesc1 = {
    Text = "[deixar] Escolher despertar 1 Desperto, infectar[(Skill.Arg1)]"
  },
  Event_80465_Desc = {
    Text = "Você escolheu o caminho e correu desesperadamente, puxando o pequeno William.\nFelizmente, sua escolha estava correta.\nAquela poluição espiritual, aquelas Clementines idênticas, finalmente foram deixadas para trás.\nClaro, você pagou um certo preço."
  },
  Event_80465_Name = {
    Text = "As \"Clementines\""
  },
  Event_80466_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80466_Desc = {
    Text = "\"Clack. Clack. Clack\"\nO \"trabalho\" finalmente foi concluído. Mas além do próprio \"trabalho\", o que mais você obteve?"
  },
  Event_80466_Name = {
    Text = "Tortura eterna"
  },
  Event_80467_ChoiceDesc1 = {
    Text = "[Leave] Obter 1 de 3 Orações"
  },
  Event_80467_Desc = {
    Text = "\"É muito bom ouvir uma resposta sincera.\"\n\"Espero ansiosamente pelo nosso próximo encontro.\""
  },
  Event_80467_Name = {
    Text = "Chamado no sonho"
  },
  Event_80468_ChoiceDesc1 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_80468_Desc = {
    Text = "\"Ai, ai, que criança desonesta.\"\n\"Mas não tem problema, da próxima vez, eu vou fazer você dizer a verdade.\"\n\"Toda a verdade, vinda do coração e da alma, verdade.\""
  },
  Event_80468_Name = {
    Text = "Chamado no sonho"
  },
  Event_80469_ChoiceDesc1 = {
    Text = "[Start 'working']Delete 1 Carta de comando, ganhe Arg1 O sigilo negro"
  },
  Event_80469_ChoiceDesc2 = {Text = "[Recuar]"},
  Event_80469_Desc = {
    Text = "\"Clack.\"\nO som da máquina de escrever ecoa, e você é seu escravo até que o \"trabalho\" esteja concluído.\n\n."
  },
  Event_80469_Name = {
    Text = "Tortura eterna"
  },
  Event_80470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80470_Desc = {
    Text = "\"Que pena, sua cautela fez você perder a única chance de saber a verdade.\" \n Ele suspirou e se dissipou em silêncio.\n\n."
  },
  Event_80470_Name = {
    Text = "Memória Profunda"
  },
  Event_80471_ChoiceDesc1 = {
    Text = "[Ataque total]"
  },
  Event_80471_ChoiceDesc2 = {
    Text = "[Recuar enquanto luta]"
  },
  Event_80471_Desc = {
    Text = "Uma figura inesperada aparece diante de você, é Clementine.  \n\"Não há motivo para surpresa, apenas quero realizar um teste especial.\"  \n\"Quanto ao que será testado, é um segredo.\" Clementine sorri,  \n\"Para você, o único objetivo do teste —\"  \n  \n\"é sobreviver.\""
  },
  Event_80471_Name = {
    Text = "Teste especial"
  },
  Event_80472_ChoiceDesc1 = {
    Text = "[Recordar o passado]"
  },
  Event_80472_ChoiceDesc2 = {
    Text = "[Arrancar a escama do enxame]"
  },
  Event_80472_Desc = {
    Text = "\"Por favor, acredite em mim, eu não tenho más intenções, eu só quero ajudá-lo.\" \n Clementine corre atrás de você, gritando alto. \n Sua voz soa incrivelmente sincera, mas você já não consegue acreditar em nada. \n Sua moral foi atravessada pela \"teoria da cognição encarnada\", e a razão está prestes a desmoronar. \n Você deve, deve fazer algo para resistir ao crescimento das escamas de inseto na carne e resistir à loucura e ao desespero que gradualmente permeiam sua alma."
  },
  Event_80472_Name = {
    Text = "Alma lutadora"
  },
  Event_80473_ChoiceDesc1 = {
    Text = "[Leave] Deletar 2 Cartões"
  },
  Event_80473_Desc = {
    Text = "\"Quer guardar força para a batalha final?\"\n\"É uma escolha inteligente. Mas, ao ganhar algo, na verdade também se perde algo.\"\n\"Porque, neste mundo cruel em chamas, o próprio ato de sobreviver exige um preço.\""
  },
  Event_80473_Name = {
    Text = "Teste especial"
  },
  Event_80474_ChoiceDesc1 = {
    Text = "[Ignorar Isso] Receba Oração com 3 opções"
  },
  Event_80474_ChoiceDesc2 = {
    Text = "[Tocá-lo] 1 Carta de comando aleatória obtém Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_80474_Desc = {
    Text = "Algo estranho, semelhante a esporas, chama sua atenção.\nAssemelha-se a uma medusa delicada composta de carne, ou aos filamentos nervosos no interior do cérebro que armazenam sinais.\n\"Venha me tocar\", ela o seduz em silêncio, \"eu vou, revelar a você uma memória cruel.\""
  },
  Event_80474_Name = {
    Text = "Memória Profunda"
  },
  Event_80475_ChoiceDesc1 = {
    Text = "[Leave] Obter 1 de 3 Orações"
  },
  Event_80475_Desc = {
    Text = "\"Ramona, Doll, Lotan, Ogier...\"\nVocê repete nervosamente esses nomes em sussurros.\nSua razão em colapso já não consegue mais recordar suas aparências, mas a existência que esses nomes representam ainda consegue aquecer seu coração e sua alma.\nEles existiram, riram, eles... são a linha de base e o âncora que mantém sua humanidade neste momento."
  },
  Event_80475_Name = {
    Text = "Alma lutadora"
  },
  Event_80476_ChoiceDesc1 = {
    Text = "[Sair] ganha 3 opções para relíquia de prata, infecção de[(Skill.Arg1)]"
  },
  Event_80476_Desc = {
    Text = "\"Aaaaaaah!\"\nVocê abre a boca e grita alto; seu som, mais do que um grito, parece um uivo.\nAs escamas de inseto que foram arrancadas voltam a crescer, e a razão desmoronada jamais retorna."
  },
  Event_80476_Name = {
    Text = "Alma lutadora"
  },
  Event_80477_ChoiceDesc1 = {
    Text = "[Leave] Obtenha Relíquia \"(RelicConfig.Arg1)\", infecte \"(Skill.Arg2)\""
  },
  Event_80477_Desc = {
    Text = "Você não está escondendo nada e está dando o seu melhor. Essa atitude claramente agrada a Clementine. \n“Que bom menino.” \n“Então, vou te dar um pequeno presente. Claro, com um preço.” \n“Num mundo cruel e em chamas como este, sobreviver por si só já exige um custo.”"
  },
  Event_80477_Name = {
    Text = "Teste especial"
  },
  Event_80478_ChoiceDesc1 = {
    Text = "[Start 'working']Delete 1 Carta de comando, ganhe Arg1 O sigilo negro"
  },
  Event_80478_ChoiceDesc2 = {Text = "[Recuar]"},
  Event_80478_Desc = {
    Text = "\"Clack. Clack.\"\nO som da máquina de escrever ecoa, e você é apenas uma ferramenta para concluir o \"trabalho\" enquanto ele está em andamento."
  },
  Event_80478_Name = {
    Text = "Tortura eterna"
  },
  Event_80479_ChoiceDesc1 = {
    Text = "[Run to the Left]"
  },
  Event_80479_ChoiceDesc2 = {
    Text = "[Run to the Right]"
  },
  Event_80479_Desc = {
    Text = "Silhuetas familiares te seguem de perto, não são uma ou duas, mas dezenas, até centenas. \n O corredor estreito mal consegue suportar tamanha quantidade de \"Clementines\", e assim, algumas \"Clementines\" são empurradas ao chão, outras são pisoteadas até virar lama. \n Mas todas elas te chamam em uníssono, repetindo aquela frase que te mergulha em poluição mental. \n \"Por que fugir? Eu só queria oferecer uma sessão de aconselhamento psicológico para você.\" \n E você, corre desesperadamente pelo corredor do sanatório, enfrentando a decisão de um desvio."
  },
  Event_80479_Name = {
    Text = "As \"Clementines\""
  },
  Event_80480_ChoiceDesc1 = {
    Text = "[Start 'working']Delete 1 Carta de comando, ganhe Arg1 O sigilo negro"
  },
  Event_80480_ChoiceDesc2 = {Text = "[Recuar]"},
  Event_80480_Desc = {
    Text = "\"Modifique! Trabalho! Não pare!\"\nIncontáveis zumbidos ecoam em seus ouvidos, fazendo você se aproximar da máquina de escrever que apareceu de repente.\n\"O que fazer, o que fazer, estive batendo o dia todo, mas o trabalho nunca acaba.\"\n\"Modifique! Modifique! Modifique o plano, apresente a demanda, complete o trabalho!\"\n\"Trabalho! Trabalho!! Trabalho!!!\"\nA alma zumbindo colide com a máquina de escrever que não para de bater, finalmente, a máquina de escrever parou.\nNo entanto, após um momento, a máquina de escrever voltou a funcionar\n\"Modifique! Trabalho! Não pare!\"\nPorque o trabalho nunca tem fim."
  },
  Event_80480_Name = {
    Text = "Tortura eterna"
  },
  Event_80481_ChoiceDesc1 = {
    Text = "[Responder honestamente]"
  },
  Event_80481_ChoiceDesc2 = {
    Text = "[Refuse to answer]"
  },
  Event_80481_Desc = {
    Text = "Num instante, a paisagem à sua frente torna-se turva e ilusória. \n Você pensou que o quarto estava se distorcendo, mas depois percebeu que sua visão havia sido invadida. \n \"Nós nos encontramos novamente.\" \n Em meio à visão borrada, Clementine sorri suavemente. \n \"Embora tenhamos nos encontrado mais cedo do que imaginava, ainda estou muito feliz. Não sei se %player% você também sente o mesmo?\""
  },
  Event_80481_Name = {
    Text = "Chamado no sonho"
  },
  Event_80595_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80595_Desc = {
    Text = "\nDiante da sua tentativa de espantá-la, a borboleta permanece imóvel.\nEla teima em perseguir a sua mão, até que, em sua palma, perde a vida.\n\"Ah, como é quente...\"\nEsses são os seus últimos sentimentos."
  },
  Event_80595_Name = {
    Text = "Sonho da borboleta"
  },
  Event_80596_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80596_Desc = {
    Text = "\"Eu desejo que as flores permaneçam sempre florescendo, eu desejo que os sorrisos sejam eternos.\"\n\"Eu desejo que todos os que sofrem de Dissolução possam se recuperar e viver em paz, eu desejo que este mundo retorne ao que era, sem mais queimar.\"\n\"Eu desejo...\"\nA pequena borboleta agita suas asas, perdendo a vida na palma da sua mão.\nPelo menos, alguém já ouviu sua voz."
  },
  Event_80596_Name = {
    Text = "Sonho da borboleta"
  },
  Event_80597_ChoiceDesc1 = {
    Text = "[Afastar a borboleta] 1 Carta de comando aleatória obtém Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_80597_ChoiceDesc2 = {
    Text = "[Listen to the wish] Escolha 1 de 3 Cartas de Comando para obter Oração: '(EnchantConfig.Arg1)'"
  },
  Event_80597_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_80597_Desc = {
    Text = "A pequena borboleta também tem muitos sonhos.\nEsses sonhos estão espalhados no mar de flores, no quarto do hospital, e também no altar cheio de carne e sangue de @2.\nAgora, finalmente, ela espera pela pessoa que a prenderá, não sabe se você está disposto a ouvir seu pequeno, pequeno desejo."
  },
  Event_80597_Name = {
    Text = "Sonho da borboleta"
  },
  Event_80610_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80610_Desc = {
    Text = "\"Racional? Uma resposta interessante.\"\n\"Espero que você não se arrependa da sua escolha.\""
  },
  Event_80610_Name = {
    Text = "O preço da humanidade"
  },
  Event_80612_ChoiceDesc1 = {
    Text = "[Feed them] Ganhar Relíquia de Prata '(RelicConfig.Arg1)', escolher infectar 1 vez o sintoma"
  },
  Event_80612_ChoiceDesc2 = {
    Text = "[Do Not Mind] Escolha 1 carta entre 3 cartas de Comando para obter uma Oração: \"(EnchantConfig.Arg1)\", Infectar \"(Skill.Arg2)\""
  },
  Event_80612_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_80612_Desc = {
    Text = "Os moradores vão e vêm, mas a multidão de ratos persiste por muito tempo. \n Comparados aos humanos, eles são os \"nativos\" deste castelo. \n Mas eles não têm objeções à presença humana. \n Porque aquelas coisas feias, macias e brancas, lhes oferecem igualmente coisas feias, macias e brancas. \n \"E você, coisa feia, pertence a qual tipo?\""
  },
  Event_80612_Name = {
    Text = "O segredo do antigo castelo"
  },
  Event_80613_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80613_Desc = {
    Text = "\nUm riso suave surge das sombras.\n\"Estou à sua espera, venha me ver.\"\n\"Pequeno inseto destemido.\""
  },
  Event_80613_Name = {
    Text = "\"Ela\" espreita"
  },
  Event_80614_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80614_Desc = {
    Text = "\"Cale-se, cale-se, é insuportável.\"\nO gato preto humanizado cobre os ouvidos. \n\"Humano, sua linguagem felina é realmente péssima, você fala coisas sem sentido!\"\nEmbora diga isso, a expressão do gato preto se acalma. \n\"Em consideração ao fato de que você mia para me agradar, vou te dar um presente.\"\n\"Quanto ao conteúdo do presente, depende da sua sorte.\""
  },
  Event_80614_Name = {Text = "Nigelman"},
  Event_80615_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80615_Desc = {
    Text = "\n\"Mãe, após perder amigos, marido e filho, eu perdi para sempre Diana, minha pequena filha.\"\n\"Quando ela se transformou em cinzas diante de mim, meu cérebro ficou em branco...\" A caligrafia subsequente já não pode ser lida.\nVocê só pode passar para a próxima linha.\nEu tomei uma decisão. Se me encontrar novamente, por favor, não me culpe, eu só... sinto tanta falta de vocês."
  },
  Event_80615_Name = {
    Text = "Saudade Desaparecida"
  },
  Event_80616_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80616_Desc = {
    Text = "Sua expulsão teve efeito. Poucas figuras de aparência indistinta distorcem-se e fogem, enquanto a maior parte permanece no lugar. \n Eles não riem mais, não recitam mais, mas sim choram desesperadamente. \n O choro das crianças ecoa em seus ouvidos, repetindo apenas uma frase. \n \"Mate o monstro!\""
  },
  Event_80616_Name = {
    Text = "A infância de \"ele\""
  },
  Event_80617_ChoiceDesc1 = {
    Text = "[Sair] Infectar[(Skill.Arg1)]"
  },
  Event_80617_ChoiceDesc2 = {
    Text = "[Sair] Infectar[(Skill.Arg1)]"
  },
  Event_80617_ChoiceDesc3 = {
    Text = "[Sair] Infectar[(Skill.Arg1)]"
  },
  Event_80617_Desc = {
    Text = "Sua alimentação agradou a multidão de ratos.\nA vasta multidão de ratos se agitou e lhe presenteou com um presente embrulhado de forma grosseira.\nVocê não consegue reconhecer a forma do presente, apenas vê uma grande quantidade de sangue impregnado no embrulho."
  },
  Event_80617_Name = {
    Text = "O segredo do antigo castelo"
  },
  Event_80618_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80618_Desc = {
    Text = "\"......\"\n\"............\"\n\"..................\"\nA sombra permanece em silêncio, querendo chorar, mas perdeu a capacidade de fazê-lo.\nNo final, ele apenas suspirou profundamente.\n\"Amigo, que você guarde seus bens mais preciosos.\""
  },
  Event_80618_Name = {
    Text = "Homem vazio"
  },
  Event_80619_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80619_Desc = {
    Text = "Sua reprimenda não teve efeito algum, ao contrário, deixou-os ainda mais entusiasmados e alegres. \n As risadas e os cânticos tornaram-se cada vez mais altos, cantando outra canção infantil \n \"Williamzinho, mora no castelo alto,\nRatos comedores de homens correm pelas paredes.\nQuando chegar a hora da humanidade,\nTodos serão devorados, um por um.\""
  },
  Event_80619_Name = {
    Text = "A infância de \"ele\""
  },
  Event_80620_ChoiceDesc1 = {
    Text = "[Evitar Olhar] Despertar aleatoriamente 1 Despertador"
  },
  Event_80620_ChoiceDesc2 = {
    Text = "[encarar o olhar] Escolha despertar 1 despertador, e reduza seu custo de aritmética de carta de despertar em 2 pontos. Infecção[(Skill.Arg1)]"
  },
  Event_80620_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_80620_Desc = {
    Text = "Tudo no sanatório está sob seu controle e observação. Claro, você também. \n Mas ela está disposta a fazer exceções para você. \n Afinal, um jogo é mais divertido quando há interação."
  },
  Event_80620_Name = {
    Text = "\"Ela\" espreita"
  },
  Event_80621_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80621_Desc = {
    Text = "Você coloca o envelope de volta no lugar e se prepara para sair, mas de repente ouve um sussurro confuso. \n \"A pedido meu, a médica Clementine finalmente se abriu. \n Ela me descreveu aquele vasto universo, um universo misterioso, onde deve haver uma maneira de salvar vocês. \n Estou pronto para um 'novo nascido', não importa quantos anos-luz eu tenha que vagar, eu anseio por ver vocês novamente.\""
  },
  Event_80621_Name = {
    Text = "Saudade Desaparecida"
  },
  Event_80622_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80622_Desc = {
    Text = "A doutora Clementine me salvou. \n Ela é realmente uma pessoa muito, muito boa, disposta a ouvir minha voz. \n Eu realmente gostaria de dizer algumas coisas felizes, alegres, mas neste momento, além da dor e do desespero, não há mais nada. \n Receio que vou decepcionar as boas intenções da doutora. \n Após perder vocês, a vida para mim é apenas desolação."
  },
  Event_80622_Name = {
    Text = "Saudade Desaparecida"
  },
  Event_80623_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80623_Desc = {
    Text = "\"Você, você...\"\n\"Hmph, suas habilidades não são tão ruins assim. Desta vez, você passou. Na próxima, não será tão fácil!\"\nO gato preto deu um pulo e correu para longe com agilidade."
  },
  Event_80623_Name = {Text = "Nigelman"},
  Event_80624_ChoiceDesc1 = {
    Text = "[Attack the black cat] 50% de chance de ganhar 125 O sigilo negro, 50% de chance de infectar '(Skill.Arg2)'"
  },
  Event_80624_ChoiceDesc2 = {
    Text = "[Meow like a cat]75% de chance de ganhar 100 O sigilo negro, 25% de chance de infectar '(Skill.Arg2)'"
  },
  Event_80624_ChoiceDesc3 = {
    Text = "[Tentar afagar o gato] Ganhar 50 O sigilo negro"
  },
  Event_80624_Desc = {
    Text = "\"Ei! Você, está proibido de seguir em frente.\"\nOs gatos pretos de repente saltaram e bloquearam seu caminho. \nEles lambem suas patas com elegância, com uma expressão arrogante e orgulhosa. \n\"À frente está cheio de perigos, não é algo que humanos fracos como você podem explorar.\"\nVocê expressou sua determinação de seguir em frente, e então os olhos verticais do gato preto líder se moveram, revelando sua natureza cruel de brincar com a presa. \"Então mostre-nos sua determinação.\""
  },
  Event_80624_Name = {Text = "Nigelman"},
  Event_80625_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80625_Desc = {
    Text = "\nSeu desprezo enfureceu a multidão de ratos, que guincharam e avançaram em sua direção, mas você, muito antes da investida dos ratos, já havia fugido.\n\n"
  },
  Event_80625_Name = {
    Text = "O segredo do antigo castelo"
  },
  Event_80626_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80626_Desc = {
    Text = "\"Ah, é assim, quebre minhas asas.\"\n\"Tempo, saúde, dignidade, vida... Eles já tiraram tudo de mim.\"\n\"Esse último sonho, certamente também não me pertence.\"\n\"Porque eu sou apenas um pássaro preso, sem liberdade.\""
  },
  Event_80626_Name = {
    Text = "Homem vazio"
  },
  Event_80627_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80627_Desc = {
    Text = "\"Emocional? Uma resposta interessante.\"\n\"Espero que você não se arrependa da sua escolha.\""
  },
  Event_80627_Name = {
    Text = "O preço da humanidade"
  },
  Event_80628_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80628_Desc = {
    Text = "\"Eu aceito sua súplica.\" \nO zumbido se aproxima e entra suavemente pelo seu canal auditivo, penetrando no seu cérebro. \nSeu cérebro estremece, e nesse tremor, você escuta a \"voz\" do universo. \n\"Conecte-se comigo.\""
  },
  Event_80628_Name = {
    Text = "Redenção Sombria"
  },
  Event_80629_ChoiceDesc1 = {
    Text = "[Pray] Desperte aleatoriamente 1 Despertador, infecte '(Skill.Arg1)'"
  },
  Event_80629_ChoiceDesc2 = {
    Text = "[Refuse] Ganhe 1 entre 3 Oração"
  },
  Event_80629_Desc = {
    Text = "\"Não deveria ser assim, não deveria ser assim.\"\n\"Eu claramente, claramente deveria me libertar dessa vida inferior humana e evoluir para algo mais avançado...\"\nNo escuro, ouve-se um soluço doloroso.\nEsses soluços se reúnem, surgem, formando um zumbido imenso.\n\"Este mundo em chamas, como um buraco negro insaciável, devora cada pessoa, então—\"\n\"Ore para mim, o infinito universo lhe dará redenção.\""
  },
  Event_80629_Name = {
    Text = "Redenção Sombria"
  },
  Event_80630_ChoiceDesc1 = {
    Text = "[Abrir o Envelope] Ganhar Relíquia de Ouro '(RelicConfig.Arg1)', infectar '(Skill.Arg2)'"
  },
  Event_80630_ChoiceDesc2 = {
    Text = "[Ler] escolhe uma entre 3 cartas de comando para ganhar oração:[(EnchantConfig.Arg1)]"
  },
  Event_80630_ChoiceDesc3 = {
    Text = "[Put it back] Ganhe 50 O sigilo negro"
  },
  Event_80630_Desc = {
    Text = "Num canto esquecido, uma carta foi deixada para trás.  \nMuitas palavras na carta já não são legíveis, mas há uma delas. Tão forte que parece rasgar o papel.  \nEssa palavra é \"mãe\".\n\n."
  },
  Event_80630_Name = {
    Text = "Saudade Desaparecida"
  },
  Event_80631_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80631_Desc = {
    Text = "\"Hmph, humano fraco, você fez a escolha errada.\" \n Os gatos pretos olham para você com frieza e atacam repentinamente. \n \"Você deve pagar o preço — claro, também respeitamos os fortes.\""
  },
  Event_80631_Name = {Text = "Nigelman"},
  Event_80632_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80632_Desc = {
    Text = "\nUm riso suave vem das sombras.\n\"Estou à sua espera, venha me ver.\"\n\"Pequeno inseto encantador.\""
  },
  Event_80632_Name = {
    Text = "\"Ela\" espreita"
  },
  Event_80633_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80633_Desc = {
    Text = "Sob seu ataque, esse grupo de figuras distorcidas e estranhas finalmente fugiu. \n O ambiente está silencioso, apenas sua batida cardíaca chora em silêncio. \n Então, este é o \"seu\" passado.\n\n."
  },
  Event_80633_Name = {
    Text = "A infância de \"ele\""
  },
  Event_80635_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80635_Desc = {
    Text = "\"Ah, o pequeno jogo de palavras foi descoberto.\"\n\"Isto é uma recompensa. Porque...\"\n\"Nem todas as escolhas precisam ser feitas.\""
  },
  Event_80635_Name = {
    Text = "O preço da humanidade"
  },
  Event_80636_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80636_Desc = {
    Text = "\"@3 Rebelde\"\nO som zumbido gradualmente enfraquece até desaparecer, deixando apenas as palavras finais.\n\"Manter a humanidade não pode sobreviver neste mundo cruel.\""
  },
  Event_80636_Name = {
    Text = "Redenção Sombria"
  },
  Event_80637_ChoiceDesc1 = {
    Text = "[Choose to refuse] Delete 1 Carta de comando, ganhe Arg1 O sigilo negro"
  },
  Event_80637_ChoiceDesc2 = {
    Text = "[Choose to comply] Copie 1 Carta de Comando, infecte '(Skill.Arg1)'"
  },
  Event_80637_ChoiceDesc3 = {
    Text = "[Choose to embrace] Escolha 1 dentre 3 Cartas de comando para obter Oração: '(EnchantConfig.Arg1)'"
  },
  Event_80637_Desc = {
    Text = "\"Eu sou um pássaro em uma jaula, preso em um pátio cheio de muitos quartos.\"\nSombras difusas vagueiam na escuridão, são as obsessões deixadas pelos que partiram.\n\"Dizem que é um manicômio, mas eu sei que é uma jaula especial da humanidade, que aprisiona os pássaros livres que não querem seguir as regras sociais.\"\n\"Mas se o pássaro não pode voar, ainda pode ser chamado de pássaro?\"\nAs obsessões se aproximam de você, suplicando por redenção.\n\"Por favor, quebre minhas asas, estou cansado de voar.\""
  },
  Event_80637_Name = {
    Text = "Homem vazio"
  },
  Event_80638_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80638_Desc = {
    Text = "\"......\"\n\"............\"\n\"..................\"\nA sombra de repente treme e se derrete em seu corpo.\n\"Amigo, siga em frente, para proteger suas coisas mais preciosas.\"\n\"Embora já tenhamos falecido, ainda estamos dispostos a sonhar por você e oferecer nossa última bênção.\""
  },
  Event_80638_Name = {
    Text = "Homem vazio"
  },
  Event_80639_ChoiceDesc1 = {
    Text = "[Choose emotion] Restaure Arg1 pontos de vida"
  },
  Event_80639_ChoiceDesc2 = {
    Text = "[Maintain rationality] Ganhe aleatoriamente 1 carta de comando para obter Oração: '(EnchantConfig.Arg1)'"
  },
  Event_80639_ChoiceDesc3 = {
    Text = "[Recusar a escolha] Ganhar 25 Selos Negros"
  },
  Event_80639_Desc = {
    Text = "\"Escolha, escolha.\"\nNa escuridão que corre descontroladamente, uma infinidade de sussurros ecoa.\nEssa voz é suavemente hipnótica, parecendo carregar uma magia infinita, fazendo você experimentar uma espécie de ilusão louca.\nSeu cérebro mergulha em um delírio, se contorcendo para se desvincular do corpo, enquanto seu coração parece desenvolver uma consciência, gritando e chamando por você.\n\"Escolha, escolha.\"\n\"Manter a razão ou a emoção, você deve fazer uma escolha.\""
  },
  Event_80639_Name = {
    Text = "O preço da humanidade"
  },
  Event_80641_ChoiceDesc1 = {
    Text = "[Repreender 'eles'] Infecte '(Skill.Arg1)', obtenha a Relíquia Amaldiçoada '(RelicConfig.Arg2)'"
  },
  Event_80641_ChoiceDesc2 = {
    Text = "[Drive 'them' away] Infete duas vezes '(Skill.Arg1)', ganhe Relíquia de Prata '(RelicConfig.Arg2)' e '(RelicConfig.Arg3)'"
  },
  Event_80641_ChoiceDesc3 = {
    Text = "[Atacar 'eles'] Ganhe relíquia de prata '(RelicConfig.Arg1)'"
  },
  Event_80641_Desc = {
    Text = "\"Williaminho, é um monstro, dorme em um cemitério, ninguém o ama. Não tenha contato com ele, cuidado para não ser prejudicado por ele.\"\nUm corpo de forma indistinta se contorce, mas a voz é como a de uma criança.\nEles riem e entoam, olhando para você com um olhar desdenhoso e ansioso.\nCom malícia."
  },
  Event_80641_Name = {
    Text = "A infância de \"ele\""
  },
  Event_90571_ChoiceDesc1 = {
    Text = "[Aproveite] Adicione 1 carta [Receita Especial da Noite dos Espíritos] ao baralho."
  },
  Event_90571_Desc = {
    Text = "Uma mesa magnífica, uma pista de dança vibrante, utensílios requintados, o aroma intenso de corpos...\nOh, eu sei que você está ansioso, mas por favor, aguarde um pouco mais, querido convidado.\nEsta bebida, especialmente preparada pelo anfitrião da festa, é um presente reservado para os convidados de honra.\nSegure-a. Beba-a. Aproveite ao máximo esta alegria em seu retrogosto!"
  },
  Event_90571_Name = {
    Text = "Ritual pré-festivo"
  },
  Event_91460_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91460_Desc = {
    Text = "Você não consegue resistir, apenas deixa o som penetrar. \nO grito agudo rasga seu cérebro, alguns medos esquecidos fluem para fora, e você sente a fome dela. \nUma terrível criatura canibal..."
  },
  Event_91460_Name = {
    Text = "Confissão Silenciosa"
  },
  Event_91461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91461_Desc = {
    Text = "Você não se contém mais, deixando que o calor seja totalmente liberado, e todas as palavras não ditas continuam a surgir de sua mente. \nVocê sente uma inspiração maravilhosa, embriagado pelo talento de Pickman."
  },
  Event_91461_Name = {
    Text = "Volcão Adormecido"
  },
  Event_91462_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91462_Desc = {
    Text = "A língua de fogo se enrola na mancha de tinta, deixando um rastro de sangue. \n Naquele momento, você cai na borda entre o sonho e a realidade. Você se vê transformada em uma menina, segurando a mão de Doresain e dançando com ele. \n Quando você acorda e olha novamente para Doresain, uma profunda tristeza invade sua mente."
  },
  Event_91462_Name = {
    Text = "Revelação do Sonho"
  },
  Event_91463_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91463_Desc = {
    Text = "Você avança e as chamas desaparecem sob sua pele. Quanto à pintura, qualquer um que olhe não verá nada além de um retrato comum. \n Nos sonhos que seguem, você sempre verá a si mesmo queimando, assado perfeitamente, para um dia ser servido à sua própria mesa."
  },
  Event_91463_Name = {
    Text = "Retrato Ardente"
  },
  Event_91464_ChoiceDesc1 = {
    Text = "[Ouvir] ganha 30 sigilos negros, infecta[(Skill.Arg2)], continua a escolha"
  },
  Event_91464_ChoiceDesc2 = {
    Text = "[Ignorar] Saia"
  },
  Event_91464_Desc = {
    Text = "Na cacofonia silenciosa, você gradualmente compreende a linguagem dos corvos..."
  },
  Event_91464_Name = {
    Text = "Confissão Silenciosa"
  },
  Event_91465_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91465_Desc = {
    Text = "Você pega uma pedra e desperta as sombras de ratos que estavam concentradas em roer.\nElas encaram você com avidez.\nVocê sente o cheiro úmido e sujo delas, como se fosse um augúrio de algo."
  },
  Event_91465_Name = {
    Text = "Reino Exilado"
  },
  Event_91466_ChoiceDesc1 = {
    Text = "[Ouvir] ganha 25 sigilos negros, infecta[(Skill.Arg2)], continua a escolher"
  },
  Event_91466_ChoiceDesc2 = {
    Text = "[Ignorar] Saia"
  },
  Event_91466_Desc = {
    Text = "Ele está dando as boas-vindas. A quem?\nClaro que a você!\nTalvez ele esteja te considerando a refeição de amanhã."
  },
  Event_91466_Name = {
    Text = "Confissão Silenciosa"
  },
  Event_91467_ChoiceDesc1 = {
    Text = "[Cortar a Palma da Mão] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_91467_ChoiceDesc2 = {
    Text = "[Aceitar Crescimento]adquirir a relíquia de prata \"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_91467_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_91467_Desc = {
    Text = "A borboleta não veio voando, mas cresceu lentamente de sua palma. \n No começo, você pensou que era apenas suor, mas entre os dedos viu um líquido negro sair silenciosamente, como um vaso sanguíneo, se solidificando em asas frias e pulsantes. \n A cada movimento, ondas se formavam em seu sangue."
  },
  Event_91467_Name = {
    Text = "Parasita da elite"
  },
  Event_91468_ChoiceDesc1 = {
    Text = "[Resgatar o Retrato] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_91468_ChoiceDesc2 = {
    Text = "[Aceitar o Vazio] Escolha 1 entre 3 Cartas de comando para obter Gravura: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_91468_ChoiceDesc3 = {
    Text = "[Sair] ganha 25 o sigilo negro"
  },
  Event_91468_Desc = {
    Text = "Você está diante do presente de Pickman. \n É um retrato, pintado com sangue, e chamas negras queimam silenciosamente. \n Através das órbitas vazias do retratado, você vê— \n suas memórias fervilham e queimam, se alongando, distorcendo-se, brilhando, como se uma chama invisível estivesse lambendo os corredores de sua mente. Em um momento de confusão, você ouve uma voz. \n \"Está na hora de ir para a panela, o fogo está perfeito.\" \n Esta é a cena de memória que você mesmo pintou, lutando e se transformando nas chamas."
  },
  Event_91468_Name = {
    Text = "Retrato Ardente"
  },
  Event_91469_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91469_Desc = {
    Text = "Você recusa atender e fica observando em silêncio enquanto ele para de vibrar. \n Ao longo de tantos anos, você já aprendeu a lutar contra a loucura."
  },
  Event_91469_Name = {
    Text = "Ligação perdida"
  },
  Event_91470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91470_Desc = {
    Text = "Você dá um passo para trás e deixa a tela queimar nas chamas.\nVocê vê a si mesmo dourado e atraente sob o fogo, a gordura derretendo e estalando com um som crocante, como se pudesse sentir o aroma da carne através da tela.\nSerá este o tipo de tentação que Duresein sentiu?"
  },
  Event_91470_Name = {
    Text = "Retrato Ardente"
  },
  Event_91471_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91471_Desc = {
    Text = "Com uma curiosidade quase blasfema, ou talvez com a coragem desesperada de enfrentar o desconhecido, você busca iluminação nas sombras do passado. \nVocê vê uma menina dançando com um homem alto e de rosto indistinto ao seu lado, e uma alegria inexplicável enche seu coração."
  },
  Event_91471_Name = {
    Text = "Sombra do passado"
  },
  Event_91472_ChoiceDesc1 = {
    Text = "[Stop Recording]deletar 2 Cartões"
  },
  Event_91472_ChoiceDesc2 = {
    Text = "[Continuar Escrevendo]adquirir a relíquia amaldiçoada \"(RelicConfig.Arg1)\"，infectar \"(Skill.Arg2)\""
  },
  Event_91472_ChoiceDesc3 = {
    Text = "[Leave] Ganhar Arg1 sigilos negros"
  },
  Event_91472_Desc = {
    Text = "Você finalmente se libertou temporariamente do mercado dos ghouls, encontrando um canto tranquilo para começar a registrar como de costume. \n A máquina de escrever de repente vibra com fúria, as teclas se movem sozinhas, e uma secreção negra irrompe das fendas, molhando a razão nas pontas dos seus dedos. \n Você vê a sombra da borboleta emergir gradualmente no papel..."
  },
  Event_91472_Name = {
    Text = "Sombras de Borboletas"
  },
  Event_91473_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91473_Desc = {
    Text = "Estranhamente, embora seja uma língua que você nunca aprendeu, parece que você entende seu significado. \n O verso está repleto de saudade pelos entes queridos, uma saudade que transcende a vida e a morte, sendo transmitida em seus sonhos. \n Você reconhece vagamente a caligrafia no final do poema - \n é \"Selina\"."
  },
  Event_91473_Name = {
    Text = "Revelação do Sonho"
  },
  Event_91474_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91474_Desc = {
    Text = "Você corta a pele da palma da mão com dor, queimando a nova carne das asas com chamas. \n Líquido negro evapora, a borboleta se despedaça. \n Tudo fica limpo e sem marcas, mas você ainda sente um leve batimento de asas na palma, como um pensamento que não conseguiu ser totalmente incubado, ainda respirando lentamente em suas veias. \n Doresain não se pronuncia sobre isso, apenas se afasta do sangue que você deixou para trás."
  },
  Event_91474_Name = {
    Text = "Parasita da elite"
  },
  Event_91475_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91475_Desc = {
    Text = "Você sabe que a inspiração frenética sempre causa desastres, então selou tudo com razão."
  },
  Event_91475_Name = {
    Text = "Volcão Adormecido"
  },
  Event_91476_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91476_Desc = {
    Text = "Você encara o olho, tentando compreender a mensagem que ele transmite.  \nApesar de já ter passado por inúmeras batalhas, desta vez, diante Golias... o medo aperta seu coração.  \n\"Quase normal, é a forma mais silenciosa antes do desastre.\""
  },
  Event_91476_Name = {
    Text = "Quase normal"
  },
  Event_91477_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91477_Desc = {
    Text = "Você fecha os olhos e se vira, entrando na planície.\nVocê consegue perceber o desejo e o presságio ocultos, mas nunca poderá detê-los com suas próprias mãos.\nVocê olha para as lápides em branco ao seu redor, talvez este seja o seu fim."
  },
  Event_91477_Name = {
    Text = "Festa de Corvos"
  },
  Event_91478_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91478_Desc = {
    Text = "Você levanta lentamente a cabeça, e naquele momento, a luz perfura suas pupilas, o calor floresce em branco em sua mente. \n As estrelas da Necrópole não são diferentes das de outros lugares, e os gules que parecem possuir a eternidade também só podem existir sob as Estrelas, sem liberdade."
  },
  Event_91478_Name = {
    Text = "Noite das Estrelas"
  },
  Event_91479_ChoiceDesc1 = {
    Text = "[Jogar nas Chamas]deletar 1 Cartão"
  },
  Event_91479_ChoiceDesc2 = {
    Text = "[Tentar Interpretar]Obter \"(RelicConfig.Arg1)\", infligir \"(Skill.Arg2)\""
  },
  Event_91479_Desc = {
    Text = "Sua consciência flutua na névoa negra sem fim, navegando entre os muitos vivos e mortos nas paisagens espirituais. \n No sonho, uma mágica máquina de escrever solta um verso estranho. De quem é essa história? \n Está gravado em um papel de origem desconhecida, as letras distorcidas parecem ter sido escritas por um bêbado sóbrio. \n Você é impulsionado por um desejo indescritível no sonho, pegando aquele papel, a tinta salta entre as sombras da chama."
  },
  Event_91479_Name = {
    Text = "Revelação do Sonho"
  },
  Event_91480_ChoiceDesc1 = {
    Text = "[Join]Infligir \"(Skill.Arg1)\", obter aleatoriamente 1 cartão para conseguir uma Oração: \"(EnchantConfig.Arg2)\""
  },
  Event_91480_ChoiceDesc2 = {
    Text = "[Drive Away]infectar \"(Skill.Arg1)\", adquirir aleatoriamente 1 Cartão para obter Oração: \"(EnchantConfig.Arg2)\""
  },
  Event_91480_ChoiceDesc3 = {
    Text = "[Ignorar] Escolha 1 carta entre 3 cartas de comando para ganhar um selo:[(EnchantConfig.Arg1)]"
  },
  Event_91480_Desc = {
    Text = "Você ouve ao longe o som sutil de uma trombeta de ossos. \n A multidão de ratos emerge do lodo negro, roendo os corpos anônimos que jazem no leito do rio seco. \n Eles formam um círculo, com o centro sendo aquele cadáver já vazio, e a circunferência é um novo reino onde o esquecimento é a lei. \n E você está de pé na entrada desse reino."
  },
  Event_91480_Name = {
    Text = "Reino Exilado"
  },
  Event_91481_ChoiceDesc1 = {
    Text = "[Olhar para cima] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_91481_ChoiceDesc2 = {
    Text = "[Sair de cabeça baixa] ganha 75 Marca Negra, infecção de[(Skill.Arg2)]"
  },
  Event_91481_Desc = {
    Text = "Corvos circulam no céu, como uma serra hesitante, cortando repetidamente a espinha do céu.\nEles voam baixo ao seu redor, como se pressentissem sua morte, esperando pacientemente o início do banquete.\n\n."
  },
  Event_91481_Name = {
    Text = "Festa de Corvos"
  },
  Event_91482_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91482_Desc = {
    Text = "Você deixa que continue a escrever, com seu pulso, sua dor, seu passado e suas suposições. \n A borboleta rompe a restrição do papel, e sua alma se liberta. \n Você começa a imaginar a felicidade de estar em um parque de diversões. Você não contou a Doresain que, na verdade, você gosta muito de parques de diversões, mesmo que sejam parques de diversões de cadáveres... \n Não deve... ser muito bizarro, certo?"
  },
  Event_91482_Name = {
    Text = "Sombras de Borboletas"
  },
  Event_91483_ChoiceDesc1 = {
    Text = "[Reobservando] escolha 1 entre 3 cartas de comando para obter a gravura:[(EnchantConfig.Arg1)]"
  },
  Event_91483_Desc = {
    Text = "O jantar outrora claro transformou-se numa ceia sangrenta e confusa, você se lembra dos ingredientes na cozinha, o cheiro de podridão estimula suas narinas.\nO medo agarra seu coração, você precisa tomar uma decisão.\n\n."
  },
  Event_91483_Name = {
    Text = "Sombra do passado"
  },
  Event_91484_ChoiceDesc1 = {
    Text = "[Ignore the Bell]adquirir 1 de 3 Oração avançadas"
  },
  Event_91484_ChoiceDesc2 = {
    Text = "[Pick Up the Receiver]adquirir a relíquia de ouro \"(RelicConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_91484_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_91484_Desc = {
    Text = "Não deveria tocar — aquele telefone, encolhido atrás da tela. \n O fio do fone está enrolado no grande corpo da máquina, como um cordão umbilical enferrujado, parecendo se estender a partir da sua mente. \n Você distingue cuidadosamente a frequência da vibração, o som estranho é como a arte surreal de Pickman."
  },
  Event_91484_Name = {
    Text = "Ligação perdida"
  },
  Event_91485_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91485_Desc = {
    Text = "Você ergue aquele cérebro frio, e instantaneamente ele se transforma em um fluxo que escorrega silenciosamente entre seus dedos. \n A balança imediatamente perde o equilíbrio, o coração rapidamente desmorona e se funde, transformando-se em uma poça de água negra e silenciosa. \n Toda a fome desapareceu, você adquiriu calma, sem arrependimentos e uma breve clareza."
  },
  Event_91485_Name = {
    Text = "Jogo do Fome"
  },
  Event_91486_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91486_Desc = {
    Text = "Nenhum som, ninguém respondeu. Talvez tenha sido apenas uma brincadeira? \nQuando você já estava largando o fone, uma sensação pesada voltou a invadir seu corpo."
  },
  Event_91486_Name = {
    Text = "Ligação perdida"
  },
  Event_91487_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91487_Desc = {
    Text = "O corvo desapareceu.\nMas você vê a si mesmo diante de um espelho em outra noite, encarando este corvo.\nEle ainda emite um grasnado silencioso, como se esperasse sua resposta."
  },
  Event_91487_Name = {
    Text = "Confissão Silenciosa"
  },
  Event_91488_ChoiceDesc1 = {
    Text = "[Reobservando] escolha 1 entre 3 cartas de comando para obter a gravura:[(EnchantConfig.Arg1)]"
  },
  Event_91488_ChoiceDesc2 = {
    Text = "[Desistir da resistência] infecta[(Skill.Arg1)], substitui a oração obtida na opção 1, pode ser utilizada uma vez"
  },
  Event_91488_Desc = {
    Text = "Você desvia o olhar com determinação, mas aquelas imagens continuam a pairar diante dos seus olhos como sombras...  \nÉ uma dança dupla melancólica.\n\n."
  },
  Event_91488_Name = {
    Text = "Sombra do passado"
  },
  Event_91489_ChoiceDesc1 = {
    Text = "[Aproveitar] escolhe 1 entre 3 cartas de comando para obter a oração:[(EnchantConfig.Arg1)]"
  },
  Event_91489_ChoiceDesc2 = {
    Text = "[Recusar] infecta[(Skill.Arg1)], reimprime, até 2 vezes"
  },
  Event_91489_Desc = {
    Text = "Isso foi preparado cuidadosamente por Doresain, que se esforçou em sua investigação. \n Sem temperos, mas sem cheiro de podridão, como Doresain disse, são os melhores ingredientes. \n O banquete é feito para você, enquanto o cérebro permanece em silêncio no prato. \n \"Quer experimentar?\""
  },
  Event_91489_Name = {
    Text = "Degustando Pratos Fines"
  },
  Event_91490_ChoiceDesc1 = {
    Text = "[Ouvir] ganha 40 sigilos negros, infecta[(Skill.Arg2)], continua a escolha"
  },
  Event_91490_ChoiceDesc2 = {
    Text = "[Desconsiderar] Ganhar 25 Sigilos Negros e sair."
  },
  Event_91490_Desc = {
    Text = "É um corvo.\nEstá parado sobre a lâmpada de crânio, abre o bico, mas não emite nenhum som.\n\n."
  },
  Event_91490_Name = {
    Text = "Confissão Silenciosa"
  },
  Event_91491_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91491_Desc = {
    Text = "Você estende lentamente a mão em direção ao coração ainda quente, que pulsa e se contrai, até se transformar em uma fragrância quente que se dissipa. \n A balança treme violentamente, e seu cérebro cai em uma escuridão sem fim. \n A sensação de saciedade substitui a fome, e você compreende a paixão, a dor e a verdadeira memória."
  },
  Event_91491_Name = {
    Text = "Jogo do Fome"
  },
  Event_91492_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91492_Desc = {
    Text = "Você levanta a cabeça, recebendo aquela rotação silenciosa, como um peregrino de antigos rituais. \n Eles se deleitam alegremente com sua carne e sangue, você sente dor, mas também clareza. \n Você vê o eu perdido, aquelas partes que não conseguiram morrer, finalmente sendo levadas. \n Quando a consciência retorna, você descobre que está ileso."
  },
  Event_91492_Name = {
    Text = "Festa de Corvos"
  },
  Event_91493_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91493_Desc = {
    Text = "Você selou a fechadura com o cimento das memórias e emoções, e a verdade não pode mais te seduzir. \n Ao ver sua expressão de alerta, Doresain lambeu os lábios. \n \"Ainda quer experimentar? Isso é um mozarela de lobo cerebral feito especialmente para o Senhor Guardião do Segredo.\""
  },
  Event_91493_Name = {Text = "Apocalipse"},
  Event_91494_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91494_Desc = {
    Text = "Na verdade, você sempre teve curiosidade sobre a experiência dos ghouls.\n\"Então você entrou na massa de ratos, tornando-se um deles -\"\nvocê tem que admitir que a chegada do Marinheiro deixou sua mente um pouco confusa."
  },
  Event_91494_Name = {
    Text = "Reino Exilado"
  },
  Event_91495_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91495_Desc = {
    Text = "Você não quer se envolver com corrupção e confusão. \nVocê já se acostumou, toda decadência parece normal.\n\n."
  },
  Event_91495_Name = {
    Text = "Reino Exilado"
  },
  Event_91496_ChoiceDesc1 = {
    Text = "[Aproveitar] escolhe 1 entre 3 cartas de comando para obter a oração:[(EnchantConfig.Arg1)]"
  },
  Event_91496_ChoiceDesc2 = {
    Text = "[Recusar] infecta[(Skill.Arg1)], novamente uma oração aleatória"
  },
  Event_91496_Desc = {
    Text = "Dulesain gentilmente corta um pedaço de \"cérebro\" para você.\nEste sabor doce...\nEsta textura macia e delicada...\nVocê tem muita vontade de provar mais um pouco."
  },
  Event_91496_Name = {
    Text = "Degustando Pratos Fines"
  },
  Event_91497_ChoiceDesc1 = {
    Text = "[Estou sonhando] ganha relíquia de prata[(RelicConfig.Arg1)]"
  },
  Event_91497_ChoiceDesc2 = {
    Text = "[This Is Not Normal]adquirir a relíquia de ouro \"(RelicConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_91497_Desc = {
    Text = "A lápide lisa reflete um olho que está lentamente se distorcendo. \n Parece estar carregando uma imagem que o olho humano não pode descrever, um pedaço de memória que não pertence a você, mas que já está profundamente enraizado nas rugas de seus olhos. \n Você tenta piscar, esfregar com a ponta dos dedos, mas aquele olho não pertence mais a você, ele começa a refletir uma visão como um caleidoscópio."
  },
  Event_91497_Name = {
    Text = "Quase normal"
  },
  Event_91498_ChoiceDesc1 = {
    Text = "[Continuar observando] escolha 1 entre 3 cartas de comando para obter a oração:[(EnchantConfig.Arg1)]"
  },
  Event_91498_ChoiceDesc2 = {
    Text = "[Desviar o olhar] infecção[(Skill.Arg1)], substitui a oração obtida na opção 1, pode ser utilizada duas vezes"
  },
  Event_91498_Desc = {
    Text = "No canto úmido do castelo, você encontrou aquele rolo de filme. \n As imagens são como sombras afogadas no rio do tempo, congeladas em um lento quadro, às vezes se expandindo em uma forma indescritível, às vezes colapsando em pontos brilhantes e instáveis. \n Você se perde nisso, uma onda de tontura te lembra da passagem do tempo."
  },
  Event_91498_Name = {
    Text = "Sombra do passado"
  },
  Event_91499_ChoiceDesc1 = {
    Text = "[Gaze at the Stars]Obter Relíquia de ouro \"(RelicConfig.Arg1)\", infligir \"(Skill.Arg2)\""
  },
  Event_91499_ChoiceDesc2 = {
    Text = "[Fechar os Olhos] Despertar aleatoriamente 2 entidades, infectar duas vezes [(Skill.Arg1)]"
  },
  Event_91499_ChoiceDesc3 = {
    Text = "[Sair]ganha 50 o sigilo negro"
  },
  Event_91499_Desc = {
    Text = "Você está em um cemitério deserto, a presença das estrelas torna a noite tão clara quanto o dia. \n Aqueles orbes de luz flutuando no mar profundo do tempo nunca falam, mas na longa rotação como um sussurro do sonho, vão se concentrando lentamente. \n Eles observam a solitária estrela esquecida. \n Ele observa você, observando toda a morte e a eternidade."
  },
  Event_91499_Name = {
    Text = "Noite das Estrelas"
  },
  Event_91500_ChoiceDesc1 = {
    Text = "[Ouvir] ganha 20 o sigilo negro, infecção de[(Skill.Arg2)]"
  },
  Event_91500_ChoiceDesc2 = {
    Text = "[Ignorar] Saia"
  },
  Event_91500_Desc = {
    Text = "Você encara-o.\nNa escuridão total, você vê um fogo voraz."
  },
  Event_91500_Name = {
    Text = "Confissão Silenciosa"
  },
  Event_91501_ChoiceDesc1 = {
    Text = "[Desbloqueando a Fechadura]adquirir a Relíquia amaldiçoada\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_91501_ChoiceDesc2 = {
    Text = "[Selar a Fechadura] 1 Carta aleatória obtém Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_91501_Desc = {
    Text = "Diante do lobo cerebral que Doresain lhe ofereceu, você rejeitou várias vezes, mas acabou não resistindo à tentação da sabedoria. \n O conhecimento não chega lentamente, mas se derrama de repente. \n Seu cérebro começa a doer, o pensamento se expande como um pão fermentado. Quando você finalmente cai, a dor recua como uma maré, e sua consciência parece ter um vazio, deixando um buraco limpo e antigo. \n Então, essa é a forma do conhecimento! Você sente uma sabedoria sem precedentes. \n Talvez... você possa obter mais?"
  },
  Event_91501_Name = {Text = "Apocalipse"},
  Event_91502_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91502_Desc = {
    Text = "Você usa a lâmina remanescente de sua consciência para forçar aquela fechadura. \n Você não sabe o que é a chave, apenas tenta com a obsessão. Naquele momento, seu pensamento queima até se extinguir, deixando apenas uma certa lógica não humana sussurrando no vazio da fechadura. \n Será que isso é a revelação? Você compartilha empolgado com Doresain. \n \"Quer experimentar mais? Esta é uma mussarela de folhas cerebrais especial feita para o Senhor Guardião do Segredo.\""
  },
  Event_91502_Name = {Text = "Apocalipse"},
  Event_91503_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91503_Desc = {
    Text = "Você não o detona, nem o reprime.\nEm um estado místico de observação, você vê os pensamentos intensos como parte das mudanças climáticas, deixando-os fluírem por si só em direção a um desfecho desconhecido.\nNa pintura de sangue e carne, você compreende a arte eterna.\n\n."
  },
  Event_91503_Name = {
    Text = "Volcão Adormecido"
  },
  Event_91504_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91504_Desc = {
    Text = "O botão parou abruptamente, e a sombra da borboleta desapareceu num instante.\nFoi uma ilusão? Você sente um vazio.\nTalvez devesse ouvir Dursain e comprar algumas folhas cerebrais na loja de memórias enlatadas.\n\"Não, em que estou pensando?\""
  },
  Event_91504_Name = {
    Text = "Sombras de Borboletas"
  },
  Event_91505_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91505_Desc = {
    Text = "Você não luta mais, deixando que as asas e o líquido negro penetrem nas linhas da sua palma. \n Você se tornou o seu recipiente, enquanto ela, usando você como casca, continua a pensar. \n A borboleta cresce cada vez mais, e você finalmente não consegue suportar o peso. \n Ao ver isso, Doresain, entusiasmado, cortou a conexão entre você e a borboleta com uma faca de jantar. Seu olhar ansioso claramente indicava que ele queria... \n Você recusou o pedido dele."
  },
  Event_91505_Name = {
    Text = "Parasita da elite"
  },
  Event_91506_ChoiceDesc1 = {
    Text = "[Ouvir] ganha 35 sigilos negros, infecta[(Skill.Arg2)], continua a escolha"
  },
  Event_91506_ChoiceDesc2 = {
    Text = "[Ignorar] Saia"
  },
  Event_91506_Desc = {
    Text = "Você achava que estava silencioso, até que sua consciência de repente se inclinou, como se inúmeras cabeças de corvos estivessem gritando dentro da sua mente. \nVocê cai de joelhos, e o mundo gira diante dos seus olhos."
  },
  Event_91506_Name = {
    Text = "Confissão Silenciosa"
  },
  Event_91507_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91507_Desc = {
    Text = "Você fecha os olhos e entra naquela névoa macia e interminável, onde as nebulosas o abraçam, e você perde sua forma, uma existência mais sólida do que o corpo se deposita dentro de você. \n Naquela noite, as estrelas continuaram a girar, tão brilhantes como sempre. \n O que o céu estrelado significa para os imortais? Talvez você devesse perguntar a Doresain."
  },
  Event_91507_Name = {
    Text = "Noite das Estrelas"
  },
  Event_91508_ChoiceDesc1 = {
    Text = "[Aproveitar] escolhe 1 entre 3 cartas de comando para obter a oração:[(EnchantConfig.Arg1)]"
  },
  Event_91508_Desc = {
    Text = "Então é queijo. \nVocê sente alívio, mas também um pouco de arrependimento."
  },
  Event_91508_Name = {
    Text = "Degustando Pratos Fines"
  },
  Event_91509_ChoiceDesc1 = {
    Text = "[Ignite]infectar \"(Skill.Arg1)\", adquirir a relíquia de prata \"(RelicConfig.Arg2)\""
  },
  Event_91509_ChoiceDesc2 = {
    Text = "[Esperar]infectar\"(Skill.Arg1)\"，adquirir a Relíquia de prata\"(RelicConfig.Arg2)\""
  },
  Event_91509_ChoiceDesc3 = {
    Text = "[Seal]Obter 25 O Sigilo Negro"
  },
  Event_91509_Desc = {
    Text = "Você fita a pintura de Pickman, e o cheiro nauseabundo de decomposição faz você ficar tonto. \nPensamentos lentamente emergem da sua mente, primeiro apenas calor, depois névoa, e então —"
  },
  Event_91509_Name = {
    Text = "Volcão Adormecido"
  },
  Event_91510_ChoiceDesc1 = {
    Text = "[Tocar o Cérebro] uma carta de comando aleatória ganha oração:[(EnchantConfig.Arg1)]"
  },
  Event_91510_ChoiceDesc2 = {
    Text = "[Tocar o Coração] Aumente Arg1 pontos de saúde máxima, infecte[(Skill.Arg2)]"
  },
  Event_91510_Desc = {
    Text = "Você entra na sala cinza, onde ninguém sussurra, e uma balança aparece vagamente na névoa negra. \n À esquerda, há um cérebro tranquilo como um lago, com ravinas prateadas brilhando suavemente; à direita, um coração vermelho ardente, exalando vapor quente. \n De repente, você sente um aroma, um desejo faminto crescendo incessantemente, enquanto a razão é comprimida pela infinita escuridão dele. \n Você estende a mão."
  },
  Event_91510_Name = {
    Text = "Jogo do Fome"
  },
  Event_91511_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91511_Desc = {
    Text = "Isso deve ser um sonho. Você se convence repetidamente. \nSem perceber, você realmente adormeceu. \nTalvez por ter conversado demais recentemente, você sonhou com Dulsein — chegando até a oferecer sua própria carne para que Dulsein comesse? Que história horrível é essa?"
  },
  Event_91511_Name = {
    Text = "Quase normal"
  },
  Event_91660_ChoiceDesc1 = {
    Text = "[Encontrar Outro Caminho] Escolha 1 entre 3 Cartas de comando para obter Gravura: [(EnchantConfig.Arg1)]"
  },
  Event_91660_ChoiceDesc2 = {
    Text = "[Let It Exist]Escolher aleatoriamente 3 Cartas de Comando para obter uma Oração: \"(EnchantConfig.Arg1)\", infligir \"(Skill.Arg2)\""
  },
  Event_91660_Desc = {
    Text = "\"Para guiar as almas, você precisa levar os mortos até o fim.\"\nCom as palavras de Doresain, você teve uma epifania.\nNão é conhecimento, nem memória—aquilo é mais como um peso, entrando em suas órbitas, inundando seu cérebro como uma torrente.\nSuas emoções parecem não pertencer mais a este momento, elas se afastam, revelando uma fissura negligenciada do universo.\nTudo o que você pode perceber para ali, como se tivesse chegado ao final de um caminho."
  },
  Event_91660_Name = {
    Text = "Fim da Alma"
  },
  Event_91661_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91661_Desc = {
    Text = "Você deixa sua alma se afastar. \nNa fronteira do \"eu\", você parece ouvir sussurros dos mortos. \nMas quando escuta com atenção, tudo desaparece."
  },
  Event_91661_Name = {
    Text = "Fim da Alma"
  },
  Event_91662_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91662_Desc = {
    Text = "Você envolve sua consciência, isolando-a da tentação desconhecida.  \nVocê se perde no fim da sua alma, vendo apenas a si mesmo.  \nComo esperado, você, sendo um ser vivo, não pode possuir a habilidade de um gule."
  },
  Event_91662_Name = {
    Text = "Fim da Alma"
  }
})
return Text_Event
