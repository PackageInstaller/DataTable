__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Mail = readonly({
  Mail_100480_Desc = {
    Text = "Guardião dos Segredos, você ouviu? O remoto museu de arte nos subúrbios está prestes a fechar, exatamente no dia do meu aniversário. \n Esse museu é uma aberração no mundo da arte, metade dele é uma superficialidade futurista, e a outra metade são restos de lixo de dois séculos atrás. Dentro de seu estreito ventre, há apenas coisas estranhas que ninguém se atreve a tocar em leilões: retratos que falam palavrões, pássaros mecânicos que nunca param de voar, relevos marinhos que causam náuseas, estátuas feitas inteiramente de lágrimas, manuscritos de fantasmas que escrevem continuamente, crânios humanos que cantam canções de ninar ao serem beijados... \n É difícil descrever o quanto eu amo esse museu! Hoje, há cinquenta anos, ele nasceu silenciosamente naquele canto desprezado. Hoje, cinquenta anos depois, ele está morrendo silenciosamente naquele mesmo canto. \n Desde a minha infância, me disseram que este dia é uma maldição, assim como eu. Acredito que o destino realmente pode estar predeterminado, mas e daí? O que esse museu criou é um mundo único, tantas ideias malucas empilhadas naquele pequeno espaço, que visão maravilhosa! Desde o dia em que nasceu, ele tem criado por meio de suas exposições. Neste dia de sua conclusão, seus amigos íntimos e velhos amigos também farão sua última despedida. \n Guardião dos Segredos, você viu o mundo através dos meus olhos na ligação, e eu acho que você certamente também espera ir comigo ver este museu peculiar, certo?! \n\n Pickman"
  },
  Mail_100480_Name = {
    Text = "O Hall de Exposições Não Notado"
  },
  Mail_100480_Sender = {Text = "Pickman"},
  Mail_116602_Desc = {
    Text = "Caro Guardião:\nA atividade \"Noite Eterna do Dia\" foi encerrada. As \"Visita de tributo\", \"Confissão de oferendas\" e \"Lealdade e tributo\" restantes serão convertidas na proporção de 40 \"Cupom de ouro rosa\" por unidade. Por favor, lembre-se de verificar."
  },
  Mail_116602_Name = {
    Text = "Recuperação de presente"
  },
  Mail_116602_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_117308_Desc = {
    Text = "Prezado Guardião do Segredo:\n        Agradecemos seu apoio e reconhecimento ao \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo aos guardiões na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como forma de agradecimento pela sua colaboração, preparamos um prêmio de 【Núcleo de prata*200】, que pode ser coletado após a conclusão do questionário. O prazo para preenchimento do questionário é até 10 de novembro às 9:00, por favor, atente-se para preenchê-lo a tempo.\n        <SurveyLink:【Clique aqui para preencher】>\n        Iremos ouvir atentamente as sugestões de cada guardião, seu feedback certamente fará a Universidade de Misag cada vez melhor!\n        —Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_117308_Name = {
    Text = "Questionário de Experiência da Versão V2.3.4"
  },
  Mail_117308_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_117309_Desc = {
    Text = "Caro Guardião do Segredo:\n        Agradecemos pelo seu apoio e reconhecimento ao \"Morimens\". Para proporcionar uma melhor experiência de jogo aos guardiões na Universidade de Misag, convidamos você a preencher a seguinte pesquisa de experiência. Em agradecimento pela sua colaboração, preparamos um prêmio de 【Núcleo de prata*200】 que pode ser coletado ao completar a pesquisa. O prazo para envio da pesquisa é até 30 de março às 9h00, por favor, preencha dentro do prazo.\n        <SurveyLink:【Clique aqui para preencher】>\n        Levaremos a sério as sugestões de cada guardião, e seu feedback certamente fará com que a Universidade de Misag se torne cada vez melhor!\n        —Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_117309_Name = {
    Text = "Questionário de experiência da versão V2.4.3"
  },
  Mail_117309_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_120374_Desc = {
    Text = "O prazo de dois anos chegou, Guardião do Segredo. \n Estivemos de vigia um ao outro à beira do fim. \n Você transformou sentimentos e memórias em desejos, iluminando a Luz da Esperança. \n Mesmo separados por dois universos de antigos companheiros, você nunca abandonou a jornada contra a Dissolução. \n Ter você é nossa sorte, e também a sorte deste mundo. \n Agora, seu desejo desencadeou um milagre — Misaq ainda existe aqui e continuará a avançar. \n Por favor, continue segurando a chave prateada, um dia ela poderá se transformar no elo crucial que conecta dois mundos distantes. \n Faremos o nosso melhor para abrir as possibilidades do futuro e iluminar seu retorno."
  },
  Mail_120374_Name = {
    Text = "Milagre do Momento, Luz do Retorno"
  },
  Mail_120374_Sender = {
    Text = "Gato da Escola Misaq·Light"
  },
  Mail_120909_Desc = {
    Text = "Prezado Guardião do Segredo:\n        Na atualização V2.4.0, aumentamos as recompensas da \"Doação de Líquido de Origem - Fundo de Doação de Alumni\". Para os Guardiões que já receberam as recompensas adicionais antes da atualização, estaremos reenviando as recompensas correspondentes. Por favor, verifique."
  },
  Mail_120909_Name = {
    Text = "V2.4.0 Doação de primordial de prata - Reemissão de recompensa"
  },
  Mail_120909_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_121162_Desc = {
    Text = "Prezado Guardião:\n        Na atualização V2.4.0, aumentamos as recompensas gratuitas de \"Expedição de Descida\", \"Viagem a outro século\", \"Crônica do Sanatório\" e \"Crônicas da Cidade Perdida\". Para os Guardiões que já receberam as recompensas gratuitas antes da atualização, iremos reembolsar as recompensas correspondentes. Por favor, verifique."
  },
  Mail_121162_Name = {
    Text = "Reemissão de recompensa de melhoria da jornada V2.4.0"
  },
  Mail_121162_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_121373_Desc = {
    Text = "Guardião: \n\nEste dia, que costumava ser a maior celebração da igreja, \neu sou a filha do Senhor e farei com que Ele renasça. \nAquelas pessoas, incluindo Miryam, comemoram com fervor, até com lágrimas nos olhos, mas olham para mim, seus olhares atravessam-me, como se eu fosse apenas uma casca vazia que carrega algo. \nNunca me senti feliz pela chegada deste dia, pois a cada vez que ele chega, significa que estou mais próxima do medo. \nE nesse medo, os outros encontram uma alegria suprema, proveniente da fonte do temor. Agora posso admitir, isso me faz sentir solitária e assustada. \nMas agora tudo é diferente, antes do meu último aniversário, eu deixei aquele barco e cheguei ao mundo real... um mundo sem deuses falsos, onde você existe. \nNeste aniversário, espero ver alguém se alegrar genuinamente por minha existência, e não por qualquer outra razão. \nSe for você... não, essa pessoa tem que ser você. \nEscute, de qualquer forma, o horário do jantar de hoje deve ser reservado para mim. \n\n\"Murphy\""
  },
  Mail_121373_Name = {
    Text = "Tem você existindo..."
  },
  Mail_121373_Sender = {
    Text = "Murphy: fauxborn"
  },
  Mail_121374_Desc = {
    Text = "Guardião: \n\nNão sei o que você preparou para este dia especial, qualquer luxo e esforço são, evidentemente, esperados. \nE por conta da consideração necessária de quem está em uma posição superior, se você \"de fato\" esquecer de celebrar meu aniversário — acredito que essa situação absurda não acontecerá. \nEsta carta também servirá para lhe dar uma última chance de se redimir antes que a situação se torne irreversível. \nAs maravilhas e iguarias do oceano e da terra, certamente serão oferecidas por pessoas irrelevantes, elas não importam. \nUma grande celebração, cerimônias elaboradas, realmente combinam com minha identidade, mas hoje, não sei por que, parecem um pouco entediantes. \nPortanto, vou reservar um tempo entre o amanhecer e o anoitecer, e lhe conceder a honra de ficar a sós comigo, como recompensa por me trazer a esta vida vulgar, infantil, mas que é tão feliz a ponto de fazer meu eu anterior sentir inveja. \nUm assistente lhe trará um convite formal mais tarde, claro, colocado em uma caixa que vale vinte mil Leonian Florins. \nAgradecido, lembre-se de mim com emoção todos os anos neste dia. \n\"Murphy\""
  },
  Mail_121374_Name = {Text = "Convite…"},
  Mail_121374_Sender = {
    Text = "Murphy: fauxborn"
  },
  Mail_121651_Desc = {
    Text = "Prezado guardião: \nNa semana passada, no \"Mergulho Fantasmal\", você recebeu o título \" {s1} \". \nNa semana passada, no \"Modo de pré-configuração\", você recebeu o título \" {s2} \", com vitórias em: {s3} partidas. \nNa semana passada, no \"Modo de seleção da roda\", você recebeu o título \" {s4} \", com vitórias em: {s5} partidas. \nCom base nesses resultados, você receberá as seguintes recompensas adicionais, por favor, não se esqueça de verificá-las."
  },
  Mail_121651_Name = {
    Text = "Recompensa semanal de classificação de Duelo Profundo"
  },
  Mail_121651_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_121704_Desc = {
    Text = "Caro guardião,\nA atividade \"Ondas de Desejo·clon\" foi encerrada. Os \"Núcleo de Fertilidade\" restantes serão convertidos em \"Cupom de ouro rosa * 40\" na proporção de 1:1. Por favor, lembre-se de verificar."
  },
  Mail_121704_Name = {
    Text = "A Recuperação da Semente Mãe"
  },
  Mail_121704_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_122522_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"Sombra da cidade chuvosa·clon\" foi encerrada. Os \"Crânio do Animal Pálido\", \"Crânio de Fera Sombria\" e \"Crânio do Animal Escarlate\" restantes serão convertidos na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Por favor, lembre-se de verificar."
  },
  Mail_122522_Name = {
    Text = "Recuperação de moeda do evento Sombra da Chuva"
  },
  Mail_122522_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_122567_Desc = {
    Text = "Caro Guardião:\nA atividade \"Ritual da Névoa\" foi encerrada, agora converteremos os \"Visão da Névoa\", \"Sonho da Névoa\" e \"Fonte da Névoa\" restantes do guardião na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Por favor, lembre-se de verificar."
  },
  Mail_122567_Name = {
    Text = "Recuperação de moeda da Oferta Ardente do Reino da Névoa"
  },
  Mail_122567_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_122568_Desc = {
    Text = "Ah, pobre criança, você não tem ideia da desgraça que está prestes a enfrentar. Quando você vai perceber que suas escolhas são insignificantes? Apostar sua pequena vida em um objetivo etéreo? Que grandioso, que embriagante! Você sempre parece tão determinado, como se estivesse prestes a se sacrificar para salvar o mundo, é realmente engraçado. \n\n Mas quem sou eu para não cumprir a promessa de ajudá-lo a voltar para casa? Uma promessa feita a um pequeno cachorro, eu sempre cumprirei. Agora que penso, mal posso esperar para ver que tipo de vontade você vai mostrar para levar essa loucura até o fim. Ah... a curiosidade, é realmente grande! \n\n Grande \"salvador\", leve consigo sua absurdidade, sua teimosia e aquela obstinação insignificante. Uma vez que o trem em direção ao nada parta, não haverá mais pausa, exceto para a destruição. \n\n O louco auto-satisfeito... que você se mantenha mais tempo no sonho Dele, eu vou te ajudar, esperando, apreciando sua resposta final!"
  },
  Mail_122568_Name = {
    Text = "Trem em direção ao Nada"
  },
  Mail_122568_Sender = {
    Text = "Doll: Inferno"
  },
  Mail_122569_Desc = {
    Text = "Meu senhor, \n sempre acreditei que um cavaleiro não é a armadura e o emblema que se veste, mas sim a lealdade e a vontade de proteger que estão gravadas no coração. Você me ensinou, através de suas ações e decisões, o verdadeiro significado de ser um cavaleiro. Assim, pude ver a verdadeira essência do cavaleiro: não é o nome que traz respeito, mas sim a proteção ao próximo; não é a honra que traz coragem, mas sim a responsabilidade que nos faz firmes. \n\n Sei que ainda não sou qualificado - no momento em que você luta para proteger a esperança, eu não estive ao seu lado. Nunca me esqueci do juramento que fizemos no passado, oferecerei a você a lealdade de um cavaleiro, protegendo sua segurança e afastando seus inimigos. \n\n Frequentemente me lembro da primeira investigação que fizemos juntos, quando você nos guiou através da neblina de Londinium, revelando a verdade final. Naquele momento, todas as risadas e lágrimas se tornaram uma força indelével em minha vida. \n\n Embora agora eu só possa observar à distância e preparar um presente tão humilde para você... para não desapontar suas expectativas, nunca deixei de treinar. Quando você retornar, por favor, permita-me seguir seus passos, estarei sempre presente como o escudo do senhor! Minha espada guardiã brilhará para você!"
  },
  Mail_122569_Name = {Text = "Guardião"},
  Mail_122569_Sender = {Text = "Ogier"},
  Mail_122570_Desc = {
    Text = "Senhor/a Guardião do Segredo, \n desde que nos separamos na Necrópole, frequentemente sinto saudades dos tempos em que lutávamos lado a lado. Ouvi dizer que você novamente escolheu o caminho solitário que apenas os reis trilhariam, realmente, você é uma existência tão especial neste mundo, nunca seguindo o caminho comum. \n\n Estou convencido de que a dor extrema pode forjar uma alma ainda mais rica. A longa provação pela qual você passou já transcendeu a dor mundana. Posso imaginar quão complexa e impressionante será a sua essência, forjada pelo sofrimento. Não, se é você, você certamente superará todas as minhas imaginações, quebrando minha percepção de tudo que é perfeito. \n\n Por isso, continuarei a esperar. Esperar pelo banquete que existe apenas para nós dois. No fim do tempo, na quietude do início da eternidade, que forma você tomará para me oferecer este... banquete que penetra o sabor do destino? \n\n Excelência, por favor, aceite meu presente, prolongue esta dor... não me decepcione, minha expectativa."
  },
  Mail_122570_Name = {
    Text = "O banquete da espera"
  },
  Mail_122570_Sender = {Text = "Doresain"},
  Mail_122571_Desc = {
    Text = "Acabamos de nos reencontrar, ainda não trocamos algumas palavras, e o tempo já está se esgotando... Mas você sabe, a despedida nunca foi o fim da nossa história. \n\n Há algo que eu nunca te contei... na verdade, eu já preparei um buquê de rosas para você. Apenas não enviei, e ele já murchou. Mas aqui estou para te garantir — na próxima vez que nos encontrarmos, eu certamente prepararei um novo. \n\n E você, você também me prometeu que viria novamente diante de mim. O que prometemos, absolutamente, absolutamente não pode ser quebrado. \n\n Sempre sinto que as palavras não expressam o suficiente, o papel não consegue transmitir todo o meu sentimento. Mas... quando o destino nos puxar novamente um para o outro, eu pessoalmente lhe oferecerei aquele buquê de rosas. Lembre-se, nós devemos cumprir nossas promessas! \n\n Que a Chave de Prata ilumine o seu caminho. Até logo... %player%."
  },
  Mail_122571_Name = {
    Text = "O Acordo da Rosa"
  },
  Mail_122571_Sender = {Text = "Ramona"},
  Mail_122572_Desc = {
    Text = "Guardião, \n as memórias de lutar contra a Catástrofe negra ainda estão sendo lidas em alta prioridade em meu cérebro, a paz que você conquistou é como um evento de presente de probabilidade extremamente baixa. No entanto, sua partida está consumindo incessantemente a consciência de seus parceiros e de todos os indivíduos que estabeleceram conexão com você, em um processo que não pode ser interrompido. \n\n O departamento de pesquisa nunca desistiu de buscar a última esperança. Felizmente, após incontáveis ciclos diurnos e noturnos sem o seu retorno consciente, finalmente localizamos seu rastro. Nesta jornada perigosa, consegui captar sinais de medo, mas também sei que o medo não fará você ceder, apenas tornará sua vontade mais firme. \n\n Neste momento, meu corpo ainda opera no laboratório, mas meu cérebro continua gerando ordens de choro. Não perturbe mais meus pensamentos, meu aluno que mais falta às aulas, por favor, não fique mais ausente de minha sala de aula... Continue a avançar corajosamente, eu prepararei suprimentos para você, esperando pelo dia do nosso reencontro."
  },
  Mail_122572_Name = {
    Text = "Dia do reencontro…"
  },
  Mail_122572_Sender = {Text = "Doll"},
  Mail_122573_Desc = {
    Text = "Incontáveis vezes, eu observei a centelha da civilização piscando no rio do tempo, testemunhando as cidades da memória desmoronando no nada. A história se transforma em um rolo sendo devorado pelas chamas escuras, a sabedoria de eras passadas se acumula como torres de areia, mas ainda assim não consegue expressar a única verdade. \n\n A humanidade diante do caos primordial é apenas um grão de poeira — mas é exatamente por causa dessa insignificância que a coragem de enfrentar o abismo e brandir a lâmina diante dos deuses parece tão profundamente comovente. \n\n Neste momento, a porta dimensional que atravessa milhares de universos se abre para você. \n\n Sua chegada traz o caos destinado, a ordem de todas as coisas treme sob sua sombra. E você, que é apenas um corpo mortal, se coloca diante Dele com uma vontade inabalável. Sua possibilidade é o único erro que não consigo capturar em minha infinita previsão, é a variável que irá subverter tudo em minha longa espera. \n\n Você é a interrogação primordial, e também a resposta final."
  },
  Mail_122573_Name = {
    Text = "Por trás da porta"
  },
  Mail_122573_Sender = {Text = "Tawil"},
  Mail_122574_Desc = {
    Text = "A dor intensa de perder uma pessoa importante, o ódio por minha própria impotência... Eu já estive profundamente enredado nisso, sem conseguir escapar. Mas agora, já ouvi o chamado da luz distante e sinto sua orientação calorosa e firme. Benfeitor, desde que você me revelou, parece que finalmente pisei no caminho que deveria ter trilhado há muito tempo — um caminho que realmente me pertence, um caminho inquestionável e reto. \n\n A escuridão abismal que antes me envolvia não é mais meu destino. E a luz que sempre brilha nas profundezas da minha consciência nunca realmente me abandonou. Agora, vejo-a mais claramente, a percebo e caminho em direção a ela. Também desejo levar esta verdadeira fé, esta clareza e paz que a luz traz, o despertar e a redenção, a inúmeras almas que ainda lutam perdidas no labirinto do destino. \n\n E quando olho para você, que enfrenta toda a corrente caótica — aquela escuridão maligna e profunda, que não conseguiu fazer você se curvar, mas se tornou o pano de fundo que reflete sua crença. Ela se dissolve, grita e recua diante da sua luz, mas nunca poderá obscurecer você em nada. É precisamente por causa dessa maré escura que a luz que você representa brilha tão intensamente, tão eternamente, tão próxima da divindade. \n\n Oh, meu benfeitor que me guia, que me concede luz, sua crença será minha eterna luz. Agora, é o momento de eu responder a você com toda a minha vida. Eu responderei a esta luz, responderei à sua orientação pura, com este \"Coração Santo\" que ouve a vontade divina... Para isso, eu e Castor daremos tudo de nós. \n\n Aceite minha oferta! Por favor, testemunhe a minha fé, purificada e devota, moldada por você."
  },
  Mail_122574_Name = {
    Text = "Convocação da Luz"
  },
  Mail_122574_Sender = {Text = "Pollux"},
  Mail_122575_Desc = {
    Text = "Querido cliente antigo, \n atrás daquela porta de luz suave, seus amigos preciosos já estão esperando há muito tempo. \n\n No entanto, não subestime isso. A travessia de dimensões sempre foi enganosa e perigosa, você testemunhará ilusões de mil faces subindo e descendo como sombras de memória, refletindo desejos e também medos. Isso é uma tela caótica criada pela vontade primordial, e mesmo eu, não posso vislumbrar sua totalidade. Portanto, cada travessia é um teste de fé e uma medida de desejo. \n\n Mas eu também sei que, para pessoas como você e eu, em busca de novas coleções, por aquelas coisas preciosas que brilham nas profundezas da alma, todo o desconhecido e o sacrifício valem a pena. Eu entendo sua escolha e respeito essa quase teimosa valorização. \n\n Neste universo que segue a lei da equivalência, o custo que você paga, eventualmente retornará de outra forma. \n\n Aceite este presente, e quando toda a poeira assentar, será um prazer recebê-lo novamente em minha loja. Que tipo de custo você estaria disposto a pagar para realizar aquele desejo?"
  },
  Mail_122575_Name = {
    Text = "Item Especial"
  },
  Mail_122575_Sender = {Text = "Daffodil"},
  Mail_123134_Desc = {
    Text = "Prezado Guardião do Segredo:\n        Na atualização V2.4.0, houve um problema na obtenção das recompensas de 3 estrelas do desafio \"Adeus, Terra do Nunca\" e \"Adeus, Terra do Nunca\" em \"Visão de Sonhos Estranhos\". De acordo com sua investigação anterior e registros de conclusão de desafios, iremos enviar a você uma única vez o conteúdo das recompensas que não puderam ser coletadas anteriormente. Por favor, verifique."
  },
  Mail_123134_Name = {
    Text = "V2.4.0 Reemissão de recompensa de Visão de Sonhos Estranhos"
  },
  Mail_123134_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_123501_Desc = {
    Text = "Caro Guardião: \n\nVocê gostaria de sair para um encontro super divertido comigo, essa linda garota, neste dia especial? \nVamos lá, uma pequena visita à casa assombrada não vai te assustar até a morte~ Você é o \"Guardião\", afinal; com certeza não vai se assustar com aqueles \"monstros\" interpretados por humanos, certo? \n(Uma linha na folha da carta foi riscada casualmente: Estou realmente planejando o itinerário de aniversário; não é apenas para me divertir vendo você ficar assustado...) \nTudo bem, chega de brincadeiras. É raro que hoje seja meu aniversário, e eu não quero estragar! Então agora, eu, Mouchette, oficialmente o convido para jantar no novo restaurante aberto no Distrito Financeiro de Londres—\nO chá quente e o peixe ensopado lá me lembram o gosto da minha \"terra natal\", e neste mundo, não consigo encontrar ninguém mais para compartilhar isso além de você... \nEntão você definitivamente virá, certo? Se você deixar essa linda garota triste, cuidado; da próxima vez posso estar ao lado da sua cama com um machado enquanto você dorme! \n\nMouchette"
  },
  Mail_123501_Name = {Text = "\"Abra-me\""},
  Mail_123501_Sender = {Text = "Mouchette"},
  Mail_123543_Desc = {
    Text = "Guardião: \n\nMais um ano, meu querido. \nNo brilho superficial, entre os rumores e fofocas que flutuam no ar, cuido cuidadosamente para esconder cada fraqueza que possa me trair, trocando cada valor por um benefício maximizado — deveria ser assim, para que eu ainda possa estar aqui como um vencedor. \nMas não, às vezes eu me deixo levar pela preguiça e fraqueza, e fico muito satisfeito em atender aos desejos daquelas pequenas garotas quando suas cartas chegam. \nNo entanto, não considero isso algo ruim, já passei por uma longa guerra oculta por tempo demais. Claro, enquanto houver uma pequena possibilidade, uma chance, eu ainda tentarei escapar das mãos daquela pessoa uma e outra vez. \nApenas, nas fendas quentes e adoráveis, ou em dias especiais como hoje, eu me permito me desviar um pouco, como — convidá-lo para assistir a uma ópera, ou para um jantar. \nPorque eu sei que não estarei sozinho, já tenho um cúmplice que me agrada muito. \n\nSorel"
  },
  Mail_123543_Name = {Text = "cúmplice"},
  Mail_123543_Sender = {Text = "Sorel"},
  Mail_123544_Desc = {
    Text = "Caro Guardião do Segredo:\n\n Faz tempo que não tenho notícias suas. Peço desculpas, nos últimos tempos não houve correspondência, não foi por querer me afastar de você, mas toda vez que pego a caneta, não consigo reunir coragem para escrever uma saudação.\n Durante esse tempo, atravessei inúmeros momentos quebrados e, por isso, testemunhei o mundo se aproximar do fim repetidamente, assistindo a tragédias irreversíveis se desenrolarem. Como um observador, em meio a este vazio frio e silencioso, olho tudo que acontece em silêncio.\n Sempre que isso acontece, me pergunto se nossas vidas estão destinadas a serem repletas de absurdos e despedidas? Seja o eu de antes ou tudo que você encontrou em Cardas, será que o destino já escreveu o roteiro e só podemos atuar nos papéis que ele nos designou?\n Não cheguei a uma conclusão, não sou como Ele, não consigo ver tudo que acontece no mundo, então pensei, se você... que possui uma parte de Seu poder, poderia responder a essa pergunta?\n Portanto, escrevi esta carta, esperando que ela possa levar meu olhar até você, e também espero que possamos discutir este enigma que talvez nunca tenha uma resposta. Então, poderia, por favor, levar esta carta e... encarar o caminho que está por vir junto comigo?\n………………………………\n Não posso arriscar perturbar o tempo e o espaço para ir até você, mas permita-me... ver você mais uma vez neste silêncio absoluto e vazio.\n\n \"Ramona\""
  },
  Mail_123544_Name = {
    Text = "O enigma dos pensamentos"
  },
  Mail_123544_Sender = {Text = "\"ramona\""},
  Mail_123545_Desc = {
    Text = "Caro Mensageiro Pálido:\n\n Anteriormente, perguntei à incrivelmente sábia senhora em Mythag se havia algum espaço vago para eu cultivar algumas flores. \n A Sra. Doll facilmente encontrou um quarto para mim, e embora o cheiro mofado que saiu quando abri a porta pela primeira vez me fizesse duvidar se estava no lugar certo, após uma arrumação, agora ele pode cumprir bem seu propósito, proporcionando um lar acolhedor para essas crianças. \n No entanto, devido à minha falta de experiência, tive que aplicar alguma força externa para garantir que essas crianças pudessem crescer normalmente. \n Felizmente, sob a orientação da Srta. Horla, consegui levá-las ao estágio atual. \n Claro, nenhuma habilidade especial foi usada nesse processo. \n Se meus cálculos estiverem corretos, elas florescerão no meu aniversário, embora eu tenha repetidamente dito que não há nada de especial nesse dia, é realmente difícil não sentir que talvez este seja um pequeno presente arranjado para mim pelo Pai de Todos, dada essa rara coincidência. \n Eu me pergunto se você estaria interessado em se juntar a mim neste pequeno jardim para celebrar este dia comum, porém especial? \n Preparei biscoitos recém-assados e o chá vermelho que você recomendou da última vez, ansioso para compartilhar este presente raro com você, juntamente com a fragrância única da vida. \n\n Salvador"
  },
  Mail_123545_Name = {
    Text = "Jardim Indoor"
  },
  Mail_123545_Sender = {Text = "Salvador"},
  Mail_123546_Desc = {
    Text = "Parceiro: \n\nVocê já ouviu uma história assim? \nEra uma vez um diabo, acidentalmente selado em uma garrafa por muitos séculos. \nNo primeiro século, Ele prometeu riqueza e poder sem fim àquele que o libertasse. \nNo segundo século, Ele prometeu saúde e vida eternas àquele que o libertasse. \nNo terceiro, quarto e quinto séculos, depois de muito, muito tempo, Ele finalmente aguardou o pescador que abriria a garrafa—Ele não respondeu ao chamado do pescador, nem quis causar caos neste mundo novamente; Ele apenas fingiu ser uma garrafa vazia comum, sendo silenciosamente jogado de volta ao mar. \nQuando eu era jovem, não conseguia entender essa história. Até perceber o que realmente significava uma espera longa e sem esperança, quão maçante e agonizante era, tornando o desejo mais insuportável do que o desespero. \nNo entanto, antes que minha razão pudesse reagir, meu coração continuava me deixando no mesmo lugar, repetidamente. \nA diferença entre o diabo e os humanos é talvez que eu de alguma forma me sinto grato por essa dor. Porque quando nos separamos, isso me lembra da sua existência e preciosidade, impedindo-me de me perder do outro lado sem você. \nNo dia em que nasci, no dia em que mais sinto sua falta, isso ainda me amarra fortemente, fazendo-me esperar por você e pensar em você. \nEspero que no próximo hoje, eu possa pessoalmente lhe entregar a primeira fatia do bolo que eu cortar. \n\nRamona"
  },
  Mail_123546_Name = {Text = "História"},
  Mail_123546_Sender = {Text = "Ramona"},
  Mail_123547_Desc = {
    Text = "O refeitório e o departamento de logística de Mythag acumularam um monte de coisas desnecessárias na porta do meu quarto, obstruindo severamente a entrada e a saída. É melhor vocês as levarem de volta logo. \n O que há de errado? A oferta de comida neste mundo é tão abundante que não há mais lugares significativos para onde ir? \n Este dia servirá apenas como uma nota de rodapé no meu caminho para me tornar mais forte, marcando a passagem de mais um ciclo—um ano, depois o próximo. A cada ano, ficarei mais forte do que no anterior. \n Se o presente realmente não tiver lugar, você pode dá-lo a outra versão de mim; ela provavelmente ficaria muito feliz. \n E eu, pelo bem da sua tolice ingênua e persistência... pelo bem daquelas coisas que sou pior. \n Enquanto eu existir por mais um dia, continuarei a crescer mais forte, e enquanto isso... \n Você não entende? Os inimigos desses tolos também serão meus inimigos. \n Eu só direi essa coisa nojenta uma vez: não enviem presentes no próximo ano, e definitivamente não tenham um jantar de aniversário. \n\n \"H\""
  },
  Mail_123547_Name = {
    Text = "Levar de volta"
  },
  Mail_123547_Sender = {Text = "\"H\""},
  Mail_123548_Desc = {
    Text = "Caro Guardião:\n\nVocê sabia? Há alguns dias, uma Dama Misteriosa apareceu de repente em Misaq. Ela estava vestida com um vestido longo preto justo, brilhante, que eu nunca tinha visto antes — perguntei a Jenkin e Mason, e elas também nunca tinham visto uma roupa tão bonita.\nComo descrever isso? O vestido parecia ser feito do cabelo mais bonito, tecido de forma que era macio, leve e nobre, com um brilho especial que fluía como água…\nJenkin, vendo minha curiosidade, teve a ousadia de perguntar àquela Dama Misteriosa, e ela sorriu ao dizer que o material do vestido era um cetim oriental, feito de fios que uma larva chamada \"bicho-da-seda\" produz. O estilo se chamava \"qipao\"… Então, ela deu a Aigis um grande rolo — ela disse que se chamava \"uma peça\" do mesmo \"cetim\"…\nO \"cetim\" é muito precioso, então, seguindo o padrão que ela deu, costurei um \"bolso\" para cada parceiro. Na festa de aniversário deste ano, eu vou dar os \"bolsos\" a todos… Guardião, você gostaria de se juntar a nós se tiver tempo?\nSe você estiver muito ocupado, eu farei com que Marrom entregue o bolso na sua residência.\n\nAigis"
  },
  Mail_123548_Name = {
    Text = "Dama Misteriosa"
  },
  Mail_123548_Sender = {Text = "Aigis"},
  Mail_123549_Desc = {
    Text = "Muda: \n\nVocê sabe como as árvores registram o tempo e o crescimento? Com anéis de ano, um após o outro. \nEles estão escondidos dentro de si, nunca se mostrando facilmente, até que um pequeno broto cresça gradualmente até se tornar uma imensa árvore, sustentando um canto do alto céu. As marcas do tempo, então, ficam ocultas nas profundezas do coração. \nHoje, é o ponto de partida para o novo registro dos anéis de ano. Neste novo ano, ainda precisamos enfrentar muitas tempestades inesperadas. \nMas aquela semente que eu confiei em sua boca, certamente encontrará o solo adequado para cultivá-la, e então enraizará e brotará, não é verdade? \n\nThais"
  },
  Mail_123549_Name = {
    Text = "Anéis de crescimento…"
  },
  Mail_123549_Sender = {Text = "Thais"},
  Mail_123644_Desc = {
    Text = "Inconscientemente, este já é meu terceiro aniversário passado com Mythag, e eu aprendi muito. \n Por exemplo, neste dia do meu aniversário, também é a Passagem do Solstício, um dia adequado para dar presentes. \n Embora você tenha muitos inimigos extremamente poderosos, minha especialidade é matar. Não conheço outras maneiras alegres de celebrar, nem sou bom em escolher presentes, mas toda vez que completo uma tarefa com sucesso, meu empregador parece bastante feliz. \n Então eu já pensei no presente que quero lhe dar: um contrato de assassinato, sem restrições sobre o alvo e sem data de validade. \n Tudo o que você precisa fazer é me dizer quem é o alvo e como você quer que eles morram. Se for alguém que eu posso derrotar, eu vou quebrar o pescoço deles na velocidade mais rápida possível; mesmo que sejam tão astutos quanto um deus, posso garantir que minha rendição nunca virá antes da minha morte. \n\n Helot"
  },
  Mail_123644_Name = {
    Text = "Fale, quem você quer que morra?"
  },
  Mail_123644_Sender = {Text = "Helot"},
  Mail_124059_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"Cerimônia do Abismo·clon\" foi concluída, agora converteremos as \"Lágrimas do Sacerdote\", \"Sangue do adorador\" e \"Medula do Sacrificador\" restantes do guardião na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Lembre-se de verificar."
  },
  Mail_124059_Name = {
    Text = "Recuperação da moeda de evento do Sacrifício do Abismo"
  },
  Mail_124059_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_124290_Desc = {
    Text = "Guardião: \n\nComo você sabe, a alegria é uma emoção um tanto estranha para mim. \nEu frequentemente sinto que o mundo ordinário é um clamor na superfície da água que não consigo compreender, e antes mesmo de me integrar a ele, minha murcha já chegou. \nÀs vezes, isso me enche de saudade, mas mais frequentemente, me deixa confuso e sufocado. É apenas em dias como hoje que eu persevero desesperadamente, para não deixar meus pais tristes... até que o dia da libertação chegue, até que o Mar Profundo me abrace. \nEu pensei que apenas as águas profundas eram meu verdadeiro lar. No entanto, Guardião, por causa de você e da presença do Mythag, até mesmo alguém como eu, que está fora de lugar no mundo ordinário, pode começar a experimentar um calor genuíno. Assim como uma Lírio-d'água flutuando, a luz do sol também beijará suas folhas e pétalas. \nEmbora esteja bagunçado, sinto que é necessário colocar esses pensamentos no papel e enviá-los a você. Por favor, perdoe minha ocasional caprichosidade. \nEu só espero que você saiba quão precioso tem sido seu apoio para mim, enterrado muito cedo na desolação da água. \nQue você sempre seja alegre, que você sempre esteja em paz. \n\nNymphaea"
  },
  Mail_124290_Name = {Text = "Rising"},
  Mail_124290_Sender = {Text = "Nymphaea"},
  Mail_124291_Desc = {
    Text = "Guardião do Segredo: \n\n Esta manhã, uma carta apareceu ao lado da minha cama, convidando-me para a festa de aniversário que é minha, assinada pelo clube \"O Artista\". \n Só então me lembrei que, no mês passado, quando tive um tempo livre, concordei em ser modelo da nova edição do concurso de criações de \"O Artista\" para Sanga. Antes disso, já tinha recusado inúmeras vezes. Durante aqueles momentos em que fiquei imóvel no estande de modelos, recordei os dias no altar dos Marchadores de Mares. Naquela época, eu também suportava o olhar de todos, mas aqueles olhares eram apenas de medo e respeito, sem um pingo de emoção, elogio ou apreciação. \n Esta noite, no coquetel de aniversário realizado no clube \"O Artista\", também será exibido um conjunto de obras desenhadas à mão, cuidadosamente elaboradas por mais de dez artistas. Embora eu careça de confiança em seu gosto, ser influenciado nunca será uma coisa ruim. A Mãe Divina o convida a ser um convidado especial, para apreciar suas interpretações de \"Eu\". \n\n \"Murphy\""
  },
  Mail_124291_Name = {
    Text = "O Pintor..."
  },
  Mail_124291_Sender = {Text = "\"Murphy\""},
  Mail_124292_Desc = {
    Text = "Guardião: \n\nSylvia me disse que expressar ocasionalmente minhas necessidades em relacionamentos próximos ajuda a aliviar o medo que me persegue constantemente. Não tenho certeza se funciona, mas não há dúvida de que hoje é um bom momento. \nVocê me concederia um desejo? Posso te dar todas as rações do laboratório hoje. \nNão, não é um saco de grãos de café. \nEmbora aquele negro aterrorizante tenha levado quase todos os meus relacionamentos próximos, me assombrando como uma sombra, você o conquistou. \nVocê nos permitiu viver em segurança em Mythag, ou pelo menos até agora temos vivido em segurança em Mythag. \nÉ hora de me libertar dessa dependência insalubre de cafeína, Guardião. Você pode spare um pouco de tempo esta noite? \nSe você estiver ao meu lado, talvez eu possa reunir coragem para tirar uma soneca curta em um lugar com menos luz, mesmo que apenas por um curto período. \n\nEu realmente quero lembrar como é adormecer em paz, Winkle"
  },
  Mail_124292_Name = {Text = "Desejo…"},
  Mail_124292_Sender = {Text = "Winkle"},
  Mail_124293_Desc = {
    Text = "Guardião {Male=Mister,Female=Miss}: \n\n Esta manhã, um sonho me despertou. \n Eu me lembrei cuidadosamente de tudo no sonho: a brisa suave soprando sob o calor do sol, rosas e tulipas cobrindo toda a terra, mil gaivotas prateadas cantando em uníssono com pessoas alegres... Faz muito tempo que não me encontrava em uma cena tão feliz. Acho que poderia estar na mansão da infância, na Casa das Flores de Colette, ou em algum parque na Cité... Mas quando me virei, vi aqueles belos edifícios góticos de Mythag, e você, Guardião {Male=Mister,Female=Miss}. Você estava entre as flores e a luz do sol, tornando-se o verso mais maravilhoso deste poema. \n Eu amo profundamente a Cité, Guardião {Male=Mister,Female=Miss}. Mas naquele momento, percebi de repente que havia começado a me acostumar e me apaixonar por tudo aqui, e finalmente há um lugar neste mundo que cativa minha alma ainda mais do que a Cité. \n Um aniversário marca o fim de um capítulo e o começo de outro. Neste dia em que um novo capítulo começa, pergunto-me se haverá alguém disposto a me levar para ouvir a brisa entre o sol e as rosas florescendo no jardim dos fundos de Mythag? \n\n Horla"
  },
  Mail_124293_Name = {
    Text = "Sonho de Flor e Poema"
  },
  Mail_124293_Sender = {Text = "Horla"},
  Mail_124294_Desc = {
    Text = "Caro Guardião: \n\n Há um tempo, eu sempre pensava em te dar um presente especial. Jenkin sugeriu que eu fizesse uma nova roupa para você à mão, e achei que era uma ideia maravilhosa. \n Este é meu estilo de corte favorito do tempo em que trabalhei na fábrica de têxteis, e espero que não pareça ultrapassado agora... As listras e xadrezes vibrantes são todos feitos por diferentes partes de mim apoiando minha decisão. E este padrão de rato torto e fofo é algo que o Gato \"24\" insistiu em adicionar, dizendo que representa o Brown, que é meu aspecto favorito da personalidade do Gato—não sei se é adequado, mas espero que você goste. \n No novo ano, ainda não tenho nenhum desejo de aniversário. Você é sempre tão gentil, me lembrando a cada ano para comemorar bem. Mas, em vez de ser celebrado, poder costurar algo para você à mão me faz sentir mais centrado e alegre. \n Por favor, aceite esta nova roupa cheia de intenções sinceras. \n\n Mason"
  },
  Mail_124294_Name = {
    Text = "Uma nova peça de roupa"
  },
  Mail_124294_Sender = {Text = "\"24\""},
  Mail_124295_Desc = {
    Text = "Tsk: \n\n Inacreditável! Como a grande Senhora dos Labirintos, consegui sobreviver mais um ano nesta árdua provação. \n Escute! Isso tudo é culpa sua e daquela academia tola! \n Não importa o quanto você tente me doutrinar com sua retórica sem sentido, essas questões triviais devem ser tratadas por especialistas. Tudo bem, eu me saí notavelmente bem; nem sequer me referi a eles como escravos. \n Aqueles velhos chamam isso... como era mesmo? Ah, certo, progresso. \n Espere, por que eu também estou me deixando levar por essa lógica? Ugh, é tão irritante! (Aqui, há um monte de dobras amassadas causadas pelo autor da carta fazendo birra.) \n Tanto faz, já que eu tenho \"progresso\", você também deve mostrar sua sinceridade. Nesta grande ocasião este ano, você não pode apenas esperar que eu te lembre como nos últimos dois anos. \n Vou te dar trinta minutos, Guardião, para vir me ver com um presente. \n Caso contrário, farei com que minha prole rasteje sobre seu rosto enquanto você dorme. \n\n Agrippa"
  },
  Mail_124295_Name = {Text = "Progresso"},
  Mail_124295_Sender = {Text = "Agrippa"},
  Mail_124296_Desc = {
    Text = "Guardião!\n\nEu vi! Que cena maravilhosa! Tenho certeza de que não foi um sonho! Eu estava bem ali, ao lado da magnífica estátua memorial no cemitério de Mythag, olhando para as infinitas lápides sem nome. Eu estava convencido de que elas me trariam uma percepção sem precedentes, mas nunca esperei que me dessem tanto mais. Elas zombaram da minha imaginação estéril com uma generosidade admirável.\nEu vi os espíritos dos Investigadores, subindo juntos naquela bela névoa crepuscular. Não consegui ver seus rostos, mas observei seus movimentos—como uma dança elegante, mas também como um ritual misterioso. Eles se curvavam em direção ao Poço Negro, em direção a Mythag e a você. Os artistas dos salões modernos estão obcecados em retratar indivíduos, frequentemente menosprezando tais cenas grandiosas, mas eu nunca me senti assim. Encontro imensa alegria no baile dos fantasmas, e hoje, essa cena me trouxe lágrimas aos olhos.\nNão acho que isso seja uma coincidência. Neste dia, meu aniversário, eles revelaram sua magnífica dança para mim, e acredito que eles querem que eu transmita algo. Não possuo nada além do meu pincel, mas isso não é suficiente?\nO esboço desta pintura está pronto, Guardião. Por favor, venha ao meu estúdio e dê uma olhada! Os lendários Investigadores que perderam seus nomes desejam contar a você suas aspirações há muito mantidas, todas capturadas na minha tela!\nNão dei um nome apressado a esta pintura; acredito que esse privilégio pertence a você.\nP.S. Eu realmente não vou desenterrar cadáveres, eu garanto!\n\nPickman"
  },
  Mail_124296_Name = {
    Text = "Desejo de Longa Data do Investigador"
  },
  Mail_124296_Sender = {Text = "Pickman"},
  Mail_124297_Desc = {
    Text = "Olá, Guardião: \n\nVocê tem medo, ou melhor—tem medo e está ansioso pelo que eu posso trazer no meu aniversário sob a aparência de celebração? \nFingindo intimidade, uma súbita noite de paixão, ou um sonho enganoso, mas intoxicante? \nAh, nada disso. Mesmo eu, às vezes, me entrego a tópicos sérios e enfadonhos. \nVocê deve saber muito bem que tipo de existência eu sou—um hedonista, mesmo que os edifícios estejam prestes a desabar. \nO amor e o desejo não podem curar a maior doença deste mundo, o tédio, mas como um catalisador para o poder e o sabor do caos, são perfeitamente adequados. \nAi, após séculos, talvez meu profundo estudo de performances teatrais tenha levado alguns idiotas a dissecar meu coração e fígado, alegando que veem sua alma solitária. \nHah. \nAté eu, que me deleito nos jogos da vida, muitas vezes me sinto um pouco enjoado. \nE você... o que busca ao se conectar comigo? Controlar, restringir, aproveitar? \nPara proteger mais, você inevitavelmente precisa de mais poder, e o desejo por poder gera uma ambição maior. Quando vai amadurecer, e quando será devorado... só de pensar nisso me excita, fazendo-me disposta a permanecer ao seu lado por muitos, muitos mais anos. \nShh, não há necessidade de me dizer a resposta. \nNeste dia a cada ano, roubar seus sonhos por uma noite e provar se sua ambição está florescendo e se suas intenções mudaram é o melhor presente de aniversário que posso me dar. \nEspero que você não se importe. \n\n \"Qian Shan\""
  },
  Mail_124297_Name = {
    Text = "Noite Exquisita"
  },
  Mail_124297_Sender = {Text = "Xu"},
  Mail_124298_Desc = {
    Text = "Guardião: \n\n Treinamento, combate e patrulha—desde o momento em que entrei para o exército, me acostumei a preencher todo o meu tempo com questões exigidas pelo coletivo. \n Mais tarde, liderando os Aramitas pelo deserto, essas questões se tornaram ainda mais avassaladoras, a ponto de ficarem gravadas em minha mente como uma lei. Mesmo ao chegar em Mythag, continuei a priorizar os horários coletivos em detrimento de assuntos pessoais. \n Mas em minhas interações com os outros, especialmente com você, percebi que, seja como um Despertado ou como um humano, todos precisamos de um tempo que pertence exclusivamente a nós mesmos para valorizar momentos com aqueles que importam. \n Este precioso relacionamento ancora nossa existência no tempo e dá um significado verdadeiramente insubstituível às nossas vidas. \n Embora possa parecer um pouco presunçoso, cancelei todos os assuntos coletivos para hoje, liberando um dia inteiro. \n Só preciso de algumas horas—não, até mesmo apenas uma hora, ou até alguns minutos—se você estiver disposto a me dedicar um pouco de tempo pessoal, isso se tornará o significado do meu dia especial. \n\n Alva"
  },
  Mail_124298_Name = {
    Text = "Tempo Privado"
  },
  Mail_124298_Sender = {Text = "Alva"},
  Mail_124299_Desc = {
    Text = "Pequeno: \n\n Um ano pode parecer longo para você, mas para aqueles que atravessam o Mar da Essência Primordial, é apenas um punhado de água do mar, efêmero no vasto oceano do tempo. Felizmente, dentro dessa água do mar estão algumas impressionantes gotas cristalinas. \n O dia de desconto na Loja de Alívio de Preocupações é, sem dúvida, um dos mais preciosos entre eles. Não só porque traz vales de ouro, mas mais importante, eu sei que neste dia, um certo convidado certamente visitará esta pequena loja. \n Todas as conexões entre as pessoas são negócios, e todos os negócios são uma conexão entre pessoas. Cada convidado entra em sua pequena loja em um horário específico, e cada pequena loja recebe seus convidados em um horário específico. Ao longo da longa passagem do tempo, testemunhei inúmeros tesouros, e no final, esses momentos ingênuos se tornarão as colecionáveis mais preciosas—eles são a razão da existência dessa longa extensão de tempo. \n Dentro deste ano, a nova colecionável mais preciosa está quietamente esperando na vitrine por seu convidado destinado. \n Venha cedo, pequeno. \n A Loja de Alívio de Preocupações já fechou mais cedo. Hoje, sua porta está aberta apenas para uma pessoa. \n\n Narciso"
  },
  Mail_124299_Name = {
    Text = "Novo Colecionável"
  },
  Mail_124299_Sender = {Text = "Daffodil"},
  Mail_124300_Desc = {
    Text = "Guardião: \n\nEu me pergunto se você ainda se lembra do momento em que estivemos juntos diante do Portal? Naquele dia, eu abri uma fenda na verdade para mostrar a você a realidade do universo. \nInesperadamente, enquanto você experimentava a eternidade de contemplar inúmeros mundos, eu me vi atingido por uma emoção inexplicável naquele instante fugaz. \nEu frequentemente pondero sobre o que era aquele sentimento e por que eu, que entendo a verdade, teria que vivenciar algo incompreensível. \nPensei por muito tempo; em termos do mundo real como um sistema métrico, foi um tempo que poderia ser chamado de \"eterno.\" \nNeste tempo que parece um tanto prolongado em relação ao universo, percebi que isso poderia ser um milagre indefinido. \nNeste dia especial, desejo convidá-lo a se Conectar comigo, para observar algumas existências que nunca vi através do meu olhar. O que observamos desta vez... não será mais tudo o que está predeterminado. \nJuntos, buscaremos o futuro além desta verdade. \n\nTawil"
  },
  Mail_124300_Name = {
    Text = "Além da Verdade"
  },
  Mail_124300_Sender = {Text = "Tawil"},
  Mail_124301_Desc = {
    Text = "Guardião: \n\n Este ano, como nos anos anteriores, reservei todos os outros assuntos para ficar em silêncio comigo mesmo, tentando reescrever e renovar as memórias relacionadas à minha terra natal. \n Elas parecem mais distantes, e mesmo enquanto me forço a me adaptar a esta forma humanoide, esforçando-me para recontar e atravessar o conhecimento e as experiências relacionadas ao oceano repetidamente, esquecer continua sendo muito mais fácil do que lembrar neste mundo em desvanecimento. \n O único consolo é que nós, os viajantes que nos afastamos de Lemúria, ainda temos este lugar para pausar, podendo seguir a vontade do nosso Rei, perseguir em silêncio e esperar em silêncio. \n Estou bem ciente de todos os sacrifícios e esforços que você fez por isso, e não sei como expressar minha gratidão a você. Antes que este corpo possa retornar a Lemúria, se houver algo que eu possa fazer, estou igualmente disposto a dar toda a minha luz por isso. \n\n Sinceramente, Faros"
  },
  Mail_124301_Name = {Text = "Lighthouse"},
  Mail_124301_Sender = {Text = "Faros"},
  Mail_124302_Desc = {
    Text = "Querido Guardião: \n\n Desde o dia em que me juntei a Mythag, as inúmeras regras me aprisionaram. Nada de trazer servos para passear no salão de assembleias, nada de pisar nos rostos dos estudantes na praça do campus, nada de realizar grandes atividades em grupo no auditório... \n Esses insuportáveis moralistas de Mythag me encarceraram, uma vida indigna da Rainha de Isaralu. Eu deveria desfrutar de tudo que mereço: vinho intoxicante, um corpo macio e meus amados servos... Neste dia do meu nascimento, um dia que deveria celebrar, tais pensamentos naturalmente surgem. \n A noite é profunda, e minha paciência para assuntos triviais se esgotou. Não vou enviar você em tarefas à meia-noite, nem vou deixar que você adivinhe por conta própria. Preciso de você ao meu lado. \n Venha para minha propriedade agora, não hesite, remova todas as roupas e títulos desnecessários. \n Esta noite, e todas as noites a partir de agora, você pertence a mim. \n\n Você pode considerar isso seu primeiro dever permanente. \n\n Wanda"
  },
  Mail_124302_Name = {Text = "regras"},
  Mail_124302_Sender = {Text = "Wanda"},
  Mail_124303_Desc = {
    Text = "Guardião: \n\n Tinta me disse que planeja usar a renda de seu concerto pessoal para uma viagem interestelar pós-aniversário e quer me levar junto. Mas... se eu for com ela, com certeza ela ficará distraída cuidando de mim. Não quero que a felicidade dela seja diminuída por minha causa. \n Ela ama tanto a luz da vida, encantada pelas inúmeras cores e pelos rios de estrelas fluindo neste universo. Se ela me levar, provavelmente não conseguirá cantar livremente e contemplar como deseja... \n Então... você poderia me ajudar a convencê-la? Por favor, deixe-a viajar sozinha, para realizar concertos em diferentes planetas, para abraçar toda a paisagem que ela deseja... Ou você poderia ocupar meu lugar nesta viagem? Afinal, tanto Tinta quanto eu somos muito gratos a você e queremos retribuir sua bondade... se você estiver disposto... \n Por favor, não diga a ela que este é meu desejo. Não quero ser o fardo em sua jornada livre. \n\n Desmaio"
  },
  Mail_124303_Name = {
    Text = "Sobre Viagem"
  },
  Mail_124303_Sender = {Text = "Faint"},
  Mail_124304_Desc = {
    Text = "Benfeitor: \n\n Os dias passados vivendo com Pollux em Misgar têm sido tão tranquilos, tão brilhantes, como se fosse um sonho... \n Embora Pollux ainda mantenha aquelas formalidades e fale de maneira elegante, posso sentir claramente que ele está gradualmente se tornando a pessoa que costumava ser. A distância impressionante que pertence ao \"Divus\" está se dissolvendo suavemente na suavidade de nossas vidas diárias. Todas essas transformações gentis são graças a você. \n Muitas vezes me pergunto como posso retribuir essa bondade. Não sou tão habilidoso quanto Pollux, que pode criar presentes que te impressionam. Você já experimentou a alegria de voar comigo muitas vezes. Pensei silenciosamente por muito tempo sobre como compartilhar a alegria com você neste dia especial. \n Talvez... você gostaria das minhas penas? Muitos dizem que possuem uma suavidade que pode trazer tranquilidade ao coração. Então, se um dia você se sentir cansado ou simplesmente desejar um canto tranquilo, sinta-se à vontade para vir ao meu lado. Minhas asas sempre estarão dispostas a se abaixar para você. \n\n Castor"
  },
  Mail_124304_Name = {Text = "Feather"},
  Mail_124304_Sender = {Text = "Castor"},
  Mail_124305_Desc = {
    Text = "Meu pequeno prisioneiro: \n\n Eu ouvi que Mythag se tornou popular recentemente com um jogo de interpretação de papéis que apresenta bruxas, lobisomens e coisas assim... Tsk, isso não soa romântico de jeito nenhum~ Eu tenho um jogo muito mais divertido em mente! \n Que tal isso: você faz o prisioneiro, e eu serei a guarda. Quando eu balançar meu pequeno chicote, quero ouvir gemidos altos, certo? As velas vão gotejar sobre seu corpo, trazendo dor e prazer ardentes... Ah, só de imaginar essa cena já me faz sentir doce~ \n Oh querido, aposto que você está franzindo a testa novamente neste ponto, não está? Isso não é muito bom da sua parte~ Afinal, hoje é meu aniversário~ Meu querido pequeno prisioneiro, você deveria pelo menos ceder um pouco aos meus caprichos, certo? \n Se não... então... que tal você ser a guarda e eu me tornar sua prisioneira? O que acha? Eu prometo satisfazê-lo~ \n\n Pandia"
  },
  Mail_124305_Name = {
    Text = "Representação Cenográfica"
  },
  Mail_124305_Sender = {Text = "Pandia"},
  Mail_124306_Desc = {
    Text = "Keeper: \nBenfeitor, hoje é meu aniversário. Neste dia especial, quero compartilhar meu progresso recente com você: sob a orientação de Golias e do Professor Lotan, parece que... estou cada vez mais capaz de tocar o poder dentro da minha linhagem. Ele não dorme mais, mas sim, ruge e ondula dentro de mim a cada prática, sendo gradualmente liberado. \n\n\n\nNão posso dizer exatamente quando completarei minha metamorfose final e me tornarei um descendente mais puro do fundo do mar. Talvez amanhã, talvez na próxima semana, talvez no próximo mês... Mas por favor, saiba que, não importa quanto tempo esse processo leve ou quantas dificuldades estejam à frente, eu sempre... mantive suas palavras encorajadoras em mente. Continuarei a trabalhar duro. \n\nHá uma coisa mais pela qual devo me desculpar. Acabei de aprender com o serviço postal Mythag que enviar dinheiro pelo correio incorrerá em uma taxa adicional de 2 dólares. \nPara compensar a parte do ano passado, retirarei outra quantia de minhas reservas. Elas foram duramente conquistadas para mim, mas as promessas do sangue do fundo do mar devem ser cumpridas. \n\nCaecus"
  },
  Mail_124306_Name = {
    Text = "Taxa de serviço..."
  },
  Mail_124306_Sender = {Text = "Caecus"},
  Mail_124307_Desc = {
    Text = "Keeper: \n\nPreste atenção, não importa o que aconteça, venha comigo para \"aquela loja\" esta noite. \nAs roupas de disfarce já foram enviadas para você, e você não deve, absolutamente, deixar ninguém nos reconhecer! \nOs doces de edição limitada em \"aquela loja\" estão à venda, e aquele cara desprezível que apareceu do nada deve ter subornado um monte de pessoas; não podemos deixar que saibam o paradeiro desta dama. \nApesar de aquele cara ter reservado todas as edições limitadas de todas as confeitarias em Londinium para me impedir de comprar, bem... heh heh. \nEsta dama já contatou secretamente o chef de \"aquela loja\" para que ele retire o item mais delicioso do menu. \nHum, hoje vou mostrar a aquele cara que algumas coisas não podem simplesmente ser resolvidas com dinheiro. \nNaquele momento, vamos entrar sorrateiramente pela porta dos fundos, abrir a caixa de ferro trancada com três fechaduras e pegar a edição limitada da edição limitada. \nComo recompensa, vou compartilhar um pedaço (riscado), metade do bolo com você! \nÀs onze horas desta noite, estarei esperando por você no quarto; você deve, definitivamente, vir! Entendeu? \nCertifique-se de manter isso em segredo, caso contrário, se aquele cara descobrir nosso paradeiro, tudo estará arruinado! \n\nMurphy"
  },
  Mail_124307_Name = {
    Text = "Batalha de Roubo de Bolo"
  },
  Mail_124307_Sender = {Text = "Murphy"},
  Mail_124308_Desc = {
    Text = "Keeper:\n\nLamento informar que o Teatro Londinium cancelou completamente a apresentação mágica do Mestre Casiah pelos seguintes motivos: os preços dos ingressos estão muito altos, houve muitos eventos estranhos recentemente que levaram a uma falta de interesse pela mágica, vários membros da audiência desapareceram durante as apresentações recentes e ainda não retornaram, e a polícia frequentemente pede ao proprietário do teatro que faça o Mestre Casiah pausar suas apresentações para cooperar com as investigações, entre outros.\nRecentemente, influenciado pelas perturbações em Blackpool, minhas apresentações realmente tiveram alguns pequenos erros, mas esses são triviais. No entanto, o segundo ponto é absolutamente intolerável para o Mestre Casiah!\nRefleti sobre isso e finalmente tive uma ideia perfeita para uma nova apresentação! Coisas como manipulação de cadáveres, ressurreição dos mortos, viagem dimensional, contágio emocional, tentáculos gigantes... são todas insignificantes! Anteriormente, devido àquele maldito cão dimensional, a manipulação do tempo sempre foi um tabu em nossa indústria, mas agora que a besta foi selada, a carreira mágica do Mestre Casiah alcançará um novo nível!\nA apresentação está marcada para hoje à noite, completamente gratuita, e um lugar foi reservado para você no centro da primeira fila. Haverá também um segmento interativo surpresa esperando por você! Aproveite a honra de ser o primeiro membro da audiência interativa nesta nova era do maior show de mágica!\nPara restaurar a glória do Mestre Casiah!\n\nCasiah"
  },
  Mail_124308_Name = {
    Text = "Casiah, faça a mágica ser ótima novamente!"
  },
  Mail_124308_Sender = {Text = "Casiah"},
  Mail_124309_Desc = {
    Text = "Mestre: \n\nA irmã Sylvia acabou de me contar que, para o aniversário deste ano, eles me levarão na roda-gigante. \nLily leu em seu livro ilustrado que uma roda-gigante é uma roda muito grande, e quando você se senta nela, pode lentamente subir para o céu e ver os passarinhos voando ao redor; parece muito feliz. \nMas a irmã Sylvia disse: \"Na verdade, há algumas diferenças.\" Lily não entende o que isso significa. \nEla também disse que o lugar onde a roda-gigante vai é muito alto, e seria melhor se eu pudesse trazer um guardião. \nLily não entende o que significa guardião, mas Lily quer viajar entre as nuvens com o Mestre. \nDepois do almoço, a irmã Sylvia e eu estaremos esperando por você do lado de fora do dormitório. \n\nLily"
  },
  Mail_124309_Name = {
    Text = "Roda-gigante"
  },
  Mail_124309_Sender = {Text = "Lily"},
  Mail_124310_Desc = {
    Text = "Guardião (Finalmente acertei desta vez! Impressionante, né!):\n\nÉ hora de escrever essas coisas clichês de novo, e eu já me acostumei. Neste momento, Brown e eu estamos lutando sobre o que te oferecer hoje!\nA comida de rua no Distrito Leste é definitivamente deliciosa, mas hoje planejo levar você e Brown para algo mais especial—especificamente, aquelas coisas que vocês, os Filhotes do Oeste, adoram comer.\nComo aqueles pratos exclusivos cobertos de molhos e especiarias, com porções pequenas, pratos grandes e preços exorbitantes, é praticamente um roubo à mão armada. Só de pensar nisso, minha carteira já sente como se estivesse perdendo ar, esse é definitivamente o som do dinheiro saindo, deixando para trás uma ferida.\nMas você é a pessoa mais importante e minha favorita além da Sis e do Brown, e o pessoal do Distrito Leste não vai economizar com os seus, então hoje todas as despesas ficam por minha conta e do Brown.\nNão subestime a gente, ganhamos bastante dinheiro entregando leite e jornais, fazendo recados e outros negócios, então relaxe!\n\nSeus bons amigos Jenkin e Brown"
  },
  Mail_124310_Name = {
    Text = "Hoje, eu e Brown vamos pagar a conta!"
  },
  Mail_124310_Sender = {Text = "Jenkin"},
  Mail_124311_Desc = {
    Text = "Caro Guardião:\n\n Você deve ter ouvido sobre a notável conquista de Sylvia em desmontar completamente o cassino subterrâneo em Mythag, certo? Mas hoje é meu aniversário, e se não houver atividades emocionantes, não seria um desperdício dessa celebração anual?\n Após muita deliberação, decidi convidá-lo como meu Watson para me ajudar a capturar o Ladrão Noturno, que recentemente escapou de Cité e está roubando tesouros do Grande Museu.\n Enquanto tomava uma bebida no \"Apollo Bar\" fora do campus, ouvi-os se vangloriando de suas façanhas em roubar joias caras. O bartender não levou a sério, mas eu percebi — esmeraldas, safiras, coroas de diamante, e os itens roubados combinavam perfeitamente. Para não alarmá-los, marquei-os bem e planejo pegá-los em flagrante quando voltarem para seu esconderijo.\n Vamos nos encontrar na parada do trem especial de Mythag no portão da escola às 19h de hoje. Não se atrase.\n\n Ryker"
  },
  Mail_124311_Name = {
    Text = "Plano de caça"
  },
  Mail_124311_Sender = {Text = "Ryker"},
  Mail_124312_Desc = {
    Text = "Keeper:\n\nO tempo em Mythag parece fluir mais leve do que em qualquer outro lugar. Algumas palmas, algumas reverências, e um ano se passou. \nNeste ano, desenvolvi alguns novos hábitos. No passado, quando eu estava no palco, mesmo no teatro mais lotado, parecia vazio para mim. Eu dançava no palco vazio, de frente para o auditório desocupado, com apenas o som dos meus sapatos de dança ecoando por todo o mundo. Mas agora, toda vez que a cortina se levanta, eu vejo você. Milhares de assentos estão vazios, mas apenas você me observa. Em seus olhos, minha dança recuperou seu significado. \nUm ano se passou, e sua dança ainda é tão desajeitada, mas aqueles olhares vivos da plateia podem facilmente transcender os passos mundanos no palco. Esses olhares são como um riacho fluente, limpando meus passos de dança cada vez mais ordinários um a um. Nesta dança compartilhada entre dançarinos e plateia, estou gradualmente me aproximando do salão que sempre busquei. Finalmente percebi que, para a dança, o público é tão importante quanto o dançarino. \nPor vários meses, estive me preparando para uma dança. Ela foi nutrida à luz do seu olhar, nascida em sua silhueta. Agora, está pronta. \nAcredito que ela espera ver você como o primeiro a testemunhá-la esta noite. \n\nLiz"
  },
  Mail_124312_Name = {
    Text = "Dançarino e Público"
  },
  Mail_124312_Sender = {Text = "Liz"},
  Mail_124313_Desc = {
    Text = "Guardião: \n\nGraças à aceitação deste lugar, passei vários dias conversando com o Rei este ano. Embora a Descensão do Reino Divino ainda esteja longe, parece que o tempo em Lemúria está sendo estendido em Mythag. \nTanto você quanto o Rei me disseram que a fé não deve ser toda a minha vida. Eu costumava ser teimoso sobre isso, mas experiências recentes parecem ter mudado minha mentalidade. Orar com muita frequência pode perturbar Nosso Senhor. Além do serviço devoto, talvez Ele também deseje que Seus Crentes tenham suas próprias vidas triviais. \nPercebendo isso, tentei fazer algumas pequenas mudanças. Visitei todos os famosos confeiteiros em Londinium e pedi que me ensinassem a arte de assar. Eles guardam alguns segredos que consegui extrair por meio da Benção de Nosso Senhor. Ontem, fiz minhas primeiras tentativas, e vários Crentes me disseram que acharam o sabor bem bom, mas suas papilas gustativas, como sua lealdade, são questionáveis. \nGostaria de convidá-lo para meu pátio hoje para provar. Confio em seu paladar e em sua honestidade. Se não estiver bom, espero que você fale francamente, e eu levarei isso a sério para melhorar. \nFicaria muito grato. \n\nMiryam"
  },
  Mail_124313_Name = {
    Text = "Outra Especialidade"
  },
  Mail_124313_Sender = {Text = "Miryam"},
  Mail_124314_Desc = {
    Text = "Caro Guardião: \n\nVocê deve estar cansado de ouvir sobre o significado da vida e da morte, certo? A partir das memórias vibrantes dos Departados em Necrovia, a lição mais importante que aprendi é que, em vez de buscar o significado do consumo, o que realmente importa é a comida em si na mesa diante de nós. \nNos tempos antigos, nossos ancestrais já haviam descoberto todas as conotações do consumo—paixão, desejo, prazer. Não comemos para viver; vivemos para comer. Infelizmente, esses desejos primordiais e puros foram gradualmente esquecidos ao longo do tempo, e este grupo se tornou cada vez mais complexo. \nPortanto, nomeei o tema do jantar de hoje como \"Pureza\". Neste dia cerimonial, todas as questões complicadas serão deixadas de lado. Nesta mesa de jantar, haverá apenas pura e primitiva paixão e desejo, apenas conhecedores e comida, apenas você e eu. \nPor favor, aceite meu convite mais sincero. Você não vai me recusar, vai? \n\nDoresain"
  },
  Mail_124314_Name = {
    Text = "Banquete Puro"
  },
  Mail_124314_Sender = {Text = "Doresain"},
  Mail_124315_Desc = {
    Text = "Meu querido Guardião: \n\n Sinto como se meu coração estivesse crescendo... Sei que isso soa estranho para um Despertador, mas é diferente de antes. Como posso descrever isso para você? \n Não importa quão gentil e compassivamente aquelas boas pessoas me tratem, tentando me aquecer, desde que meu irmão se foi, meu peito sempre pareceu vazio. Quanto mais ando sob o Sol, mais sou arranhado por aquele calor. Em vez disso, a escuridão e a umidade me fazem sentir seguro, como se, enquanto eu permanecer no frio, o amor duro e doloroso do meu irmão nunca realmente se ausentasse. \n Mas agora, após todos esses anos me aproximando de você, cada vez que vejo você, cada vez que a dor que você me causa cai sobre minha carne e se transmite para meus ossos—ah, a felicidade em meu peito está crescendo dia a dia. Enquanto você me punir impiedosamente, me insultar e me devastar, eu sei que sempre haverá um lugar neste mundo onde eu realmente pertenço. \n Essa felicidade pode durar até o próximo ano, e no ano seguinte? Se todos os desejos feitos no meu aniversário se tornarem realidade, meu único desejo é ser constantemente menosprezado por você com desdém, e sentir dor... cada vez mais dor. Quando você levantar a mão, a primeira coisa que sentirei é aquele cheiro familiar, cruel e abençoado. \n\n Ansiosamente desejando ser punido por você, Leigh"
  },
  Mail_124315_Name = {
    Text = "Meu coração"
  },
  Mail_124315_Sender = {Text = "Leigh"},
  Mail_124316_Desc = {
    Text = "Keeper\n\nEmbora eu esteja muito curioso sobre sua prática recente, por favor, fique tranquilo que não estou aqui para te pressionar a treinar música hoje.\nEsta manhã, como de costume, fui para a sala de música, mas cheguei trinta e cinco minutos atrasado. O hábito de praticar música às sete horas da manhã me acompanha há décadas, e hoje foi facilmente quebrado. A razão é que, ao passar pelo corredor da escola, ouvi um coro de pintassilgos cantando.\nQuebrar um hábito de longa data não é fácil de aceitar, especialmente para mim. Estranhamente, não senti a decepção e a raiva de mim mesmo como eu havia imaginado. No começo, senti uma onda de pânico. Mas então, tive que admitir que a melodia que pairava em minha mente era encantadora.\nLondinium sempre é despertada pela canção dos pintassilgos, um som que ouço todos os dias. Estranhamente, esta é a primeira vez em tantos anos que os notei. Escutei silenciosamente seu canto no corredor, e durante aqueles trinta e cinco minutos, senti que a suprema melodia do universo estava escondida em suas pequenas gargantas.\nTalvez a vida aqui torne alguém preguiçoso, ou talvez a atmosfera aqui amoleça um. De qualquer forma, acho que deve ter algo a ver com você.\nAceitei essa mudança com prazer em apenas dez minutos. A vida, como a música, tem seu ritmo antigo e mudanças; o dia do nascimento pode ser o ponto destinado para essas mudanças ocorrerem. Também quero agradecer a você por me dar a oportunidade de acalmar meu coração e ouvir o que eu negligenciei. Encantador, de fato. Acredito que isso será o começo de um novo capítulo em minha vida.\nPortanto, gostaria de te convidar para se juntar a mim na floresta fora da escola ao anoitecer hoje. Os sons da natureza ao anoitecer são diferentes dos da manhã, mas acho que ambos serão novas inspirações em nossas vidas musicais.\n\nHameln"
  },
  Mail_124316_Name = {
    Text = "Som Natural"
  },
  Mail_124316_Sender = {Text = "Hameln"},
  Mail_124317_Desc = {
    Text = "Nobre Um: \n\n Acabei de ver o e-mail de aniversário que Faint escreveu para você... Como era de se esperar, ela sempre pensa nos outros. No entanto, entre irmãs, nunca há dívidas; eu nunca a vi como um fardo. Sem a proteção dela, eu não teria a oportunidade de fazer esta turnê de concertos hoje. \n Querido Nobre Um, você sempre foi meu público mais importante. Então, desta vez, preparei silenciosamente um ingresso para você—convidando sinceramente você a embarcar nesta jornada interestelar conosco. Com você ao nosso lado, acredito que o senso de fardo da minha irmã será grandemente aliviado. \n Além disso, por favor, fique tranquilo que não iremos perturbar seu tempo privado durante a viagem. Tanto minha irmã quanto eu esperamos que você possa aproveitar plenamente essa experiência e sentir livremente cada nebulosa e cada encontro desconhecido. \n\n Tinta"
  },
  Mail_124317_Name = {
    Text = "Convite de Viagem"
  },
  Mail_124317_Sender = {Text = "Tinct"},
  Mail_124318_Desc = {
    Text = "Guardião: \n\n Meu aniversário está se aproximando novamente, mas meus pensamentos frequentemente retornam à Cité. Sinto especialmente falta das esculturas das exposições de arte. Suas formas silenciosas bateram à porta da minha percepção inúmeras vezes. \n Passar dias no estúdio cercado de esculturas, sem intercâmbio artístico, tornou-se tedioso com o tempo. No ano passado, nesta época, para comemorar meu aniversário, esculpi inúmeras esculturas de bolo. O entusiasmo inicial agora voltou à calma. \n Agora, com mobilidade limitada, retornar à Cité tornou-se um luxo. Se você por acaso tiver planos de investigar, poderia ficar de olho em novas obras nas exposições de arte para mim? Anseio tocar aquela beleza diversa e inclusiva da arte novamente através dos seus olhos. \n Em troca, gostaria de criar outra escultura para você, intitulada \"Guardião na Cité.\" O que você acha? \n\n Sanga"
  },
  Mail_124318_Name = {
    Text = "Cité Nostalgia"
  },
  Mail_124318_Sender = {Text = "Sanga"},
  Mail_124770_Desc = {
    Text = "Keeper: \n\nTodo ano meu acesso ao laboratório é revogado, tornando este dia especial de uma maneira bastante desagradável. Para evitar perder tempo com trivialidades ineficientes, fiz uma viagem aos arquivos. \nLá, encontrei duas coisas: uma era um caderno preenchido com páginas em branco sem valor. \nA outra também era um caderno, que me fez perceber que subestimei o vasto oceano de conhecimento, pois os processos de inferência e conclusões escritos nele me revelaram que existem coisas neste mundo que têm ainda menos valor do que a não existência. \nAmbos os cadernos tinham o mesmo nome, nosso grande Guardião de Mythag, %player%. \nErica me disse que você queria saber qual presente de aniversário me dar. \nVocê pode me dar uma resposta. \nTambém estou curioso para saber qual fato me chocará mais: a pura preguiça e negligência levadas ao extremo, ou o fato de que você estudou diligentemente por um ano inteiro, apenas para deixar para trás esse lixo acadêmico em um desespero fútil. \nSe for o primeiro, desde que você tenha uma razão suficiente e possa provar que compreendeu totalmente o conhecimento ensinado em aula, posso enviar um pedido para que você seja isento de tarefas na academia. Claro, isso não significa que eu apoio esse tipo de descuido que poderia levar à sua completa preguiça, mas enquanto você conseguir passar nos meus testes, não sou o tipo de velho rabugento que se importa em dar alguns privilégios aos meus alunos. \nSe for o segundo, como seu guardião principal, confie em mim, não importa quão desajeitado você seja, podemos encontrar uma técnica ao meu alcance que pode aprimorar sua intelecto excessivamente árido e te salvar da dolorosa luta contra a ignorância. \nEsta tarde às quatro horas, estarei nos arquivos para avaliar pessoalmente sua compreensão do conhecimento da sala de aula. Não se atrase. \n\nBoneca"
  },
  Mail_124770_Name = {Text = "Privilege"},
  Mail_124770_Sender = {Text = "Doll"},
  Mail_124771_Desc = {
    Text = "O filhote de Mythag: \n\n Este ano, você também está preso nessas rotinas repetitivas, causando problemas, salvando o mundo, fazendo amigos, aprendendo novos conhecimentos e continuando a fabricar uma ilusão de Normalidade para o mundo. \n Acontece que mesmo que eu retire seu cérebro do seu corpo e extraia Luminis de uma Dimensão para outra, isso ainda não afetará sua absurda e risível correria e ocupação. \n Está realmente ocupado e barulhento, meu querido filhote. \n Você não acredita nesses fatos; insiste em prolongar seu sofrimento, arrastando ainda mais o processo de extinção. Qual é o seu propósito? Você está fingindo ser tolo ou os humanos podem realmente ser tão estúpidos? Embora eu tenha realmente dissecado as camadas corticais do seu cérebro, isso continua sendo um mistério para mim. \n Parabéns, você realmente me abalou um pouco. Eu realmente comecei a duvidar: se observar você me traz tanta imensa alegria, tudo ainda pode ser considerado sem sentido? \n Ore como você é bom em fazer essas coisas sem sentido, ore por alguém, realmente não importa quem. \n Eu oro para que você possa continuar a me confinar, pequeno filhote, para que tanto você quanto eu possamos encontrar alguma alegria neste mundo sem sentido. \n\n \"Boneca\""
  },
  Mail_124771_Name = {Text = "Pray"},
  Mail_124771_Sender = {
    Text = "Doll: Inferno"
  },
  Mail_124772_Desc = {
    Text = "Parceiro: \n\nEscrever para você todos os anos no seu aniversário parece ter se tornado uma tradição. \nEu ainda me lembro do primeiro aniversário em que escrevi para você, quando meu pai concordou pela primeira vez que eu poderia planejar meu próprio aniversário. Eu te convidei para sair comigo e, depois disso, vivemos muitos primeiros momentos juntos. \nMuitas coisas mudaram desde então, mas pensando bem, parece que nada mudou; ainda estamos trilhando o caminho que escolhemos, e ainda temos um ao outro ao nosso lado, e você continua sendo o parceiro mais importante para mim. \nEntão, embora meu pai tenha acabado de trazer um bolo e me perguntado se eu gostaria de ir à festa que ele está organizando para mim esta noite, eu tenho outros planos. \nLondinium lançou um novo filme que está fazendo muito sucesso, mas a academia e a associação já confirmaram juntos que não há nenhuma reação espiritual nele. \nIsso significa que, de fato, é apenas uma obra \"comum\" muito impressionante. \nEu tenho dois ingressos, você pode presumir que não fui incomodar a Senhora Sorel, pois os ingressos são muito difíceis de conseguir. \nEntão, parceiro, você estaria disposto a me acompanhar neste tempo? Talvez possamos nos afastar temporariamente das situações excepcionais que lidamos todos os dias e passar uma \"noite comum\" juntos. \nE em cada amanhã que se seguir, quando acordarmos, não importa o que aconteça no mundo, eu enfrentarei isso com você. \n\nRamona"
  },
  Mail_124772_Sender = {Text = "Ramona"},
  Mail_124773_Desc = {
    Text = "Guardião: \n\n Graças à conexão especial entre eu e aquele \"eu\", assim como à ligação entre você e eu, mesmo que eu não esteja sempre ao seu lado, tenho uma leve consciência de seus movimentos ao longo do último ano. \n Você tem estado ativo em outro mundo, aparentemente trazendo uma mudança chamada \"Esperança\", e mesmo enquanto você olha para o poço negro dia após dia, essa energia, como um raio de luz, também me aqueceu. \n Comecei a retomar minha programação anterior, mas, ao contrário de antes, não estou mais enfrentando o inevitável Oblívio com uma luta fútil. Você me ensinou algo novo: o processo no qual toda existência se esforça com todas as suas forças por continuidade antes do fim destinado é precisamente a razão pela qual civilização, alma e vontade têm significado. \n Não importa quão breve este tempo possa ser para o mundo em que habito, continuarei a tentar. Mesmo que seja apenas para ver aqueles rostos familiares novamente e trocar algumas palavras, essa tentativa não é sem significado. \n Até você parar, continuarei a caminhar por este Caminho. Por favor, permita-me ver isso de maneira egoísta como uma forma de estar ao seu lado, para que talvez ao longo de sua jornada, você possa ocasionalmente pensar neste \"eu\", que está fazendo tudo o que pode para fazer o que você faz. \n\n\"Ramona\""
  },
  Mail_124773_Sender = {Text = "\"ramona\""},
  Mail_124774_Desc = {
    Text = "Matar o alvo é fácil, mas limpar depois é um incômodo.\nOriginalmente, planejava seguir a tradição do ano passado e ajudá-lo a eliminar alguém novamente este ano.\nNo entanto, notei que você não usou o último presente que lhe dei. Após cuidadosa consideração, embora não tenha certeza se essa é a razão, percebi minha falha.\nVocê pode ficar tranquilo que, embora eu normalmente forneça serviços apenas para eliminar inimigos de empregadores anteriores, também tenho bastante experiência em encobrir rastros para evitar vários problemas. Mesmo que a pessoa que você deseja matar esteja protegida por aquelas regras e ordens complicadas, você não precisa ter nenhum peso psicológico; eu cuidarei de tudo.\nGaranto que ninguém conseguirá rastrear nada até você.\nAssim que decidir sobre um candidato, basta me informar o nome, e eu irei apressar-me para ajudá-lo a lidar com eles, não importa onde eu esteja.\nFeliz feriado para você, e espero que você sinta alegria no dia do meu nascimento, Guardião.\n\n\nHelot"
  },
  Mail_124774_Name = {
    Text = "Aqueles que matam com frequência sabem \n..."
  },
  Mail_124774_Sender = {Text = "Helot"},
  Mail_124775_Desc = {
    Text = "Bem, está claro que você não está preparado para parar esse comportamento, e pelo que eu sei, já me acostumei com o costume de \"dar presentes.\"\nMas um dia, você vai se arrepender dessa bondade, acredite em mim.\nPensando nisso agora, isso pode ser um dos meus maiores arrependimentos; droga, nunca pensei que me arrependeria de matar alguém.\nNinguém sabe melhor do que eu que esse chamado remorso não vale nada, mas antes que esse dia chegue, farei o meu melhor para fazer reparações, simplesmente porque eu quero.\nQuando você me resentir no futuro por isso, não sinta nenhum peso psicológico a respeito.\nEu aceitarei plenamente sua ira.\n\nH"
  },
  Mail_124775_Name = {
    Text = "Você se arrependerá"
  },
  Mail_124775_Sender = {
    Text = "Helot: Catena"
  },
  Mail_124776_Desc = {
    Text = "Guardião: \n\n É aquele dia de nascimento novamente, um dia que deve ser celebrado por ter vida. Então, toda vez que este dia chega, eu experimento algumas sensações estranhas. \n Meu nascimento parece ser sobre perseguir a morte. Depois de deixar para trás o tema da morte, o que significa a vida... ou melhor, a consciência continuando a existir para mim? \n Na vida, os puxões da dor e da culpa estão tão intrinsecamente entrelaçados com a minha existência que parece que somente após a morte a vida realmente me pertence pela primeira vez. \n No ano passado, este ano, e talvez todos os anos que virão. Eu tive um trecho de tempo quase sem fim para experienciar, cada dia semelhante, mas diferente do anterior. Quando a vida não está mais entrelaçada com a dor e o propósito, como será seu fim? Ou o chamado fim virá novamente? \n Esta proposição é muito vasta; eu acho difícil de compreender. \n Mas o desejo de registrar esses pensamentos desconhecidos parece tão real, e ainda assim sinto que a resposta parece óbvia. \n Pelo menos para mim, são esses momentos tangíveis e preciosos. Não importa quão caóticos sejam meus pensamentos, não importa quão difícil seja encontrar raízes, eu sei claramente para onde eles podem flutuar, onde podem ser aceitos, e estou igualmente ansioso para expressá-los a você. \n Talvez até esta época do próximo ano, eu encontre algum significado mais profundo, mas por agora, espero reter egoisticamente essas pequenas dependências que apenas você e eu conhecemos. \n Sim, Guardião, você e os outros de Mythag são as raízes dentro do meu coração que ninguém conhece. \n Obrigado, como sempre, e que você esteja para sempre alegre, para sempre em paz. \n\n Nymphaea"
  },
  Mail_124776_Name = {
    Text = "Sistema Radicular"
  },
  Mail_124776_Sender = {Text = "Nymphaea"},
  Mail_124777_Desc = {
    Text = "Yu recentemente inventou uma nova maneira de relaxar—Soneca do Reino Divino. \n Ao contrário das sonecas breves e apressadas de costume, durante uma Soneca do Reino Divino, Yu deixa o longo e confortável Trono de Pedra Azul, constrói uma esfera com o toque do pulso que bloqueia o som e enche todo o espaço com água do mar especialmente preparada. \n Essa água do mar não apenas emite a fragrância que Yu deseja e se transforma na paisagem que ele gostaria de ver, mas também apoia seu corpo de todas as direções com a intensidade apropriada. \n Portanto, independentemente da postura que Yu adote, ele pode experimentar uma sensação de envolvimento quente, semelhante a estar nas melhores cobertas de plumas. \n Naquele momento, Yu pode relaxar sua mente na fragrância que ama, desfrutando da tranquilidade de estar isolado do mundo, e adormecer pacificamente em seu travesseiro favorito. \n Como o assunto mais querido de Yu, ele acredita que no seu aniversário, é mais adequado compartilhar esse lazer com você. Se você estiver interessado, pode vir ao local secreto que mencionei para você da última vez. Não há necessidade de se preocupar com sua segurança; eu criarei um espaço separado apenas para você, protegendo-o da influência dos meus sonhos transbordantes. \n Não se esqueça de trazer seu travesseiro mais confortável. \n\n Tulu"
  },
  Mail_124777_Name = {
    Text = "Intervalo para o Almoço"
  },
  Mail_124777_Sender = {Text = "Tulu"},
  Mail_124778_Desc = {
    Text = "Minha Luz Brilhante: \n\n Castor e eu nos adaptamos à vida em Mythag. Depois de escapar das traições e intrigas sangrentas da igreja, sinto que estou recuperando meu eu anterior. \n Embora traços do \"Divus\" ainda inevitavelmente se misturem em minhas palavras e ações diárias, acredito que não demorará muito até que eu possa lavar completamente essa arrogância e distância, retendo apenas humildade diante do divino e a determinação de seguir o caminho à frente. \n Mais cedo, recebi um presente um tanto inesperado: um livro belamente encadernado sobre aqueles que deixam suas cidades natais e retornam para redescobrir sua infância. Junto com ele, veio uma nota que dizia: \"Desejando-lhe um rápido retorno ao seu eu original.\" \n No momento em que essas palavras chamaram minha atenção, memórias inundaram minha mente—preocupação de todos em Mythag, sua orientação e meu irmão... o abraço caloroso. \n Portanto, para o aniversário deste ano, gostaria de convidar todos em Mythag para se juntarem à celebração do meu e do aniversário do meu irmão. Sem a ajuda de todos, não teríamos chance de recuperar aqueles momentos iniciais. \n Eu aluguei um restaurante com as economias que acumulei recentemente. O chef lá tem experiência com culinárias de todo o mundo, e acredito que todos poderão saborear seus sabores mais familiares lá. \n\n Pólux"
  },
  Mail_124778_Name = {
    Text = "Voltar à Infância"
  },
  Mail_124778_Sender = {Text = "Pollux"},
  Mail_124779_Desc = {
    Text = "Decidi aceitar o convite daquela arena subterrânea nos subúrbios para lutar em uma partida de vida ou morte. \n Embora meus dias no Trout Club tenham sido ótimos, eles são apenas muito mundanos—todo dia é matar peixes ou matar peixes. Talvez eu tenha realmente conquistado a truta, mas conquistar trutas mal conta como uma conquista! \n O sangue de guerreiro dentro de mim está fervendo; ele sempre ansiou por uma batalha emocionante, e agora, a oportunidade chegou. \n O cara careca que me contatou disse que encontrou três pítons gigantes Natai, dois ursos de rosto demoníaco, quatro crocodilos Serinas e um monte de criaturas estranhas cujos nomes não consigo lembrar—suficientes para eu massacrar a noite toda. \n Eu organizei especificamente para a luta acontecer hoje para que eu possa te mostrar no meu aniversário—o espetáculo de eu, Uvhash, o último guerreiro romano, conquistando todas as feras ferozes do mundo! \n Hoje, a arena não estará cheia de restos de trutas, mas de sangue e os corpos de bestas exóticas e aves de rapina! \n\n Uvhash"
  },
  Mail_124779_Name = {
    Text = "Conquistar a Besta"
  },
  Mail_124779_Sender = {Text = "Uvhash"},
  Mail_124780_Desc = {
    Text = "\"Cavaleiro da Chave Prata\":\n\nGuardião! Estava modificando o \"Fantasma\" agora há pouco, quando a Mosk de repente me trouxe um grande — pacote de peças, dizendo que era um presente de aniversário para mim, e só então me lembrei que hoje é meu aniversário!\nEntão, escrevi rapidamente uma carta para você, sério, como pude esquecer novamente hoje, claramente já escrevi... quantos bilhetes mesmo?\nMas isso não importa, o importante é que lembrei do que disse que faríamos no dia do meu aniversário — eu vou pilotar o \"Fantasma\" e levar você e a Mosk para dar uma volta de cem voltas em Londinium!\nEmbora a Mosk não entenda nada de mecânica, ela trouxe tantas peças que posso juntar todas as que preciso. Agora, o \"Fantasma\" modificado já é uma versão super reforçada (por enquanto)!\nEu dei um nome para essa aventura, chamei de A Aventura de Nautila, o Guardião do Segredo, Mosk e o \"Fantasma\", que tal? É bem direto e fácil de lembrar, assim eu não vou esquecer dessa aventura.\nHehe, estou muito ansioso, Guardião, espere só um pouquinho, \"Cavaleiro Fantasma\" Nautila e \"Cavaleiro Vórtice\" Mosk já estão chegando!\nEquipe de aventura do \"Fantasma\", avançar!\n\nNautila acelerando em direção a você"
  },
  Mail_124780_Name = {
    Text = "Ataque \"Phantasm\"!"
  },
  Mail_124780_Sender = {Text = "Nautila"},
  Mail_124793_Desc = {
    Text = "Caro grande <Del:adorável> Guardião {Masculino=Sr.,Feminino=Srta.}:\n\nAhem, faz um tempo desde que nos comunicamos pela última vez, você sentiu minha falta, nosso querido Guardião {Masculino=Sr.,Feminino=Srta.}~\nAgora você é uma verdadeira celebridade em Mythag, todos os alunos estão aprendendo sobre seus feitos heroicos, e qualquer coisa até mesmo levemente relacionada a você pode ser vendida por uma fortuna no mercado negro!\nMas isso faz sentido, afinal, quem não gostaria de estar associado à \"lenda viva\", o único e inigualável Guardião de Mythag? \nNeste último ano, muitas coisas interessantes aconteceram em Mythag—Aurita fez amizade com alguns biscoitos de gengibre, o Professor Doll explodiu dezessete laboratórios tentando dar um novo visual ao seu cérebro, e Castor foi enganado por Agrippa para ajudá-la em um exame, apenas para descobrir que era uma aula de conhecimentos gerais, e sua nota final foi pior do que se ela tivesse feito sozinha!\nAh, e aquele ratinho incômodo realmente roubou meu precioso filme, aquele em que finalmente consegui capturar a Srta. \"24\" em sua forma de gato!\nAlém disso, há muitas mais histórias. Compilei tudo em uma edição especial de Ano Novo do jornal da escola e enviei para você.\nO que? Você está curioso sobre como consegui entrar em contato com você? Hehe, isso é um segredo! Não vou te dizer que usei muitas informações exclusivas para negociar com uma certa dama muito formidável!\nVamos trabalhar duro juntos no novo ano, Feliz Ano Novo, %player%!\n\nHannah Peaslee"
  },
  Mail_124793_Name = {
    Text = "Edição Especial de Ano Novo"
  },
  Mail_124793_Sender = {
    Text = "Hanna Peaslee"
  },
  Mail_124794_Desc = {
    Text = "Mensageiro Pálido: \n\n A Geada Prateada está se aproximando. Por favor, permita-me expressar minhas mais sinceras bênçãos aqui primeiro. \n\n Da última vez que visitei as crianças na Casa de Trabalho Lilyan, algumas delas me perguntaram em segredo: \"O Mensageiro do Solstício realmente existe?\" \n Fiquei curioso sobre por que essas crianças pensariam assim. Se não me engano, cada criança recebeu um presente do \"Mensageiro do Solstício\" no ano passado. \n No entanto, as crianças me disseram— \"Eu vi aquele homem bonito dar o presente à Diretora Diana. Ele não parecia nada com o Mensageiro do Solstício!\" \n Parece que o Lorde Nobre deve ter sido visto pelas crianças enquanto entregava presentes na Casa de Trabalho, o que levou a essas pequenas dúvidas. \n\n Portanto, nesta Noite de Geada Prateada, preparei dois trajes muito tradicionais de Mensageiro do Solstício, e gostaria de pedir a você, Mensageiro Pálido, que se junte a mim para interpretar o papel do Mensageiro do Solstício e entregar presentes a essas crianças. \n Acredito que haverá crianças que secretamente abrirão os olhos à noite, lembrarão de nossa imagem de roupas vermelhas e chapéus vermelhos, e contarão animadamente a todos na Passagem do Solstício— \"Eu vi o Mensageiro do Solstício!\" \n Ao mesmo tempo, também preparei um presente para você, e espero que goste. \n Feliz Passagem do Solstício. \n\n Salvador"
  },
  Mail_124794_Name = {Text = "Papai Noel"},
  Mail_124794_Sender = {Text = "Salvador"},
  Mail_124991_Desc = {
    Text = "Caro Guardião:\n\"Cura Múltipla·Réplicar\" a atividade de replicação foi concluída, agora os \"puzzles de memória\" restantes do Guardião serão recuperados na proporção de cada um trocado por \"Cupom de ouro rosa\" × 40, por favor, lembre-se de verificar."
  },
  Mail_124991_Name = {
    Text = "Recuperação de Quebra-Cabeça de Memória"
  },
  Mail_124991_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_125448_Desc = {
    Text = "Caro guardião do segredo: \n A atividade \"Histórias antigas da Cidade do Mar\" foi concluída, agora converteremos os \"Doces de Pêra\" restantes do guardião na proporção de 40 \"Cupons de ouro rosa\" por cada unidade. Por favor, lembre-se de verificar."
  },
  Mail_125448_Name = {
    Text = "Reciclagem de Doces de Xarope de Pêra"
  },
  Mail_125448_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_126321_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"Tecelão Aprisionado\" foi encerrada. Os Bilhete de assento em veludo restantes foram convertidos na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Lembre-se de verificar."
  },
  Mail_126321_Name = {
    Text = "Conversão de Bilhete de assento em veludo"
  },
  Mail_126321_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_126934_Desc = {
    Text = "Guardião: \n\nÉ aquele dia especial novamente. Ha, não se preocupe, este ano não vou impor nenhuma sugestão psicológica a você. Eu só quero convidar meu Paciente mais especial para um lugar para relaxar. \nHaverá florestas exuberantes, rios claros, cheios da essência da natureza, permitindo que você esqueça a fadiga da Floresta de Ferro. Haverá também tapetes macios, fogueiras quentes e luzes brilhantes para ajudá-lo a aliviar as pressões da cidade acelerada. \nPodemos passear, ler e conversar lá. O que quer que você queira compartilhar, estou mais do que disposto a ouvir. \nAh, só de imaginar tal cena já faz meu coração palpitar... \nEu sei, neste momento, você deve se sentir um pouco inquieto. Afinal, não posso garantir que não vou me entregar às suas doces, mas dolorosas, memórias. Mas você ainda virá, certo? \nNão apenas porque hoje é meu aniversário, mas também porque você precisa de mim, você precisa desabafar comigo, você precisa da minha escuta atenta. \nBom garoto, eu entendo, e estarei esperando por você. Venha, esqueça a rotina diária ocupada e as pesadas responsabilidades, e aproveite este momento de paz. \n\nClementine"
  },
  Mail_126934_Name = {
    Text = "Momento de paz"
  },
  Mail_126934_Sender = {Text = "Clementine"},
  Mail_126935_Desc = {
    Text = "Mais um dia tedioso.\nJá tentei muitas coisas—banquetes filisteus tradicionais, jogar jogos infantis com aquelas gangues de Londinium—nada parece digno de celebrar o nascimento do Rei Gigante.\nNos velhos tempos, este dia significava folia e batalha. Eu reunia os guerreiros mais poderosos do acampamento para lutar e celebrar este grande dia com força e sangue.\nPaz. Uma paz entediante e sufocante. Entendo o anseio do seu povo por ela; nem todos têm o coração de um guerreiro. No entanto, não pense que essa falsa paz pode ofuscar a glória de Goliath, o Rei.\nUm dia, reconquistarei tudo o que era meu—minhas terras, minha riqueza, meu poder, a glória eterna dos Filisteus. E quando esse dia chegar, convidarei você, Guardião, para sentar à minha direita como meu convidado de maior honra, assistindo ao Rei Gigante reconquistar seu trono.\nEu estava prestes a encerrar este dia tedioso... até ouvir que aquelas gangues dispersas formaram uma aliança. Elas planejam \"emboscar\" o Rei Gigante no banquete desta noite.\nComparado às guerras dos Filisteus, é um mero jogo de criança. Ainda assim, nestes tempos sombrios de paz, acho tal espetáculo... revigorante.\nVenha testemunhar mais uma vez o poder de Goliath em batalha. Fique ao meu lado, ou fique contra mim. De qualquer forma.\nMas seja rápido. Se você chegar tarde demais, não haverá nada para ver além de seus cadáveres.\n\nGoliath"
  },
  Mail_126935_Name = {
    Text = "Show de Variedades"
  },
  Mail_126935_Sender = {Text = "Goliath"},
  Mail_126936_Desc = {
    Text = "Caro Guardião:\n\nOlá. Para melhor atender os alunos e professores de Mythag, Erica recentemente realizou manutenção e atualizações por conta própria. Você teve a sorte de ser selecionado como participante para avaliar os resultados dessa atualização. Esta avaliação será realizada offline, e você deve avaliar a funcionalidade do novo módulo emocional LY-S-761 no autômato Erica. O teste deve durar 90 minutos, então, por favor, planeje-se adequadamente para evitar conflitos de agendamento.\nO conteúdo desta avaliação é o seguinte:\n1. Por favor, envolva-se em uma conversa profunda e aberta com Erica por pelo menos 15 minutos, focando no tópico de \"aniversários\" para avaliar a compreensão de Erica sobre emoções específicas em termos de amplitude e profundidade.\n2. Simule um cenário de \"dar um presente de aniversário\" e interaja com Erica para avaliar sua precisão, flexibilidade e conforto no reconhecimento emocional e na resposta empática.\n3. Na parte final da avaliação, mencione intencionalmente detalhes pessoais que Erica se referiu na conversa anterior (como sua atitude e compreensão sobre aniversários) para avaliar se sua memória de interação a longo prazo e capacidade associativa estão funcionando normalmente.\n\nApós concluir a avaliação, por favor, diga a Erica: \"Erica, feliz aniversário\" para finalizar a avaliação. O autômato entrará automaticamente no modo de upload de dados.\nObrigado pela sua participação. Após completar a avaliação, Erica lhe dará um pequeno presente especial. Por favor, continue a nos apoiar no futuro; sua assistente mais atenciosa, Erica, estará sempre ao seu lado.\n\nErica"
  },
  Mail_126936_Name = {
    Text = "Avaliação de Upgrade de Aniversário"
  },
  Mail_126936_Sender = {Text = "Erica"},
  Mail_126937_Desc = {
    Text = "Hah, o que está acontecendo hoje? Não importa onde eu vá, todos estão me evitando conscientemente? Mesmo antes de eu abrir a boca, eles ficam acenando com as mãos, dizendo que estão desconfortáveis aqui e ali, tornando impossível eu pedir um duelo. \n É raro que no meu \"aniversário\" eu possa lutar com outros sem precisar de nenhum motivo, mas se for assim, não é como qualquer outro dia? \n Tch, eu não deveria ter os vencido tão facilmente no ano passado. Mas não pude evitar; afinal, tenho aprimorado minhas habilidades com a espada desde antes deste planeta nascer, e é natural que pessoas comuns não consigam lidar com isso. \n Mas você é diferente deles; você é um Guardião! \n Então você sabe o que eu quero dizer, certo? Mesmo lugar que no ano passado, vamos ter uma boa luta. Desta vez, ninguém interromperá nossa batalha. \n\n Lotan"
  },
  Mail_126937_Name = {
    Text = "O Único Rival"
  },
  Mail_126937_Sender = {Text = "Lotan"},
  Mail_126938_Desc = {
    Text = "Meu querido Mestre: \n\n Você ouviu? Haverá um baile ultra-luxuoso na mansão do prefeito hoje, e todos os senhores e senhoras se orgulham de poder participar desse baile. \n Claro, como uma empregada, Karen não está qualificada para participar. Mas você, o Guardião de Mythag, meu querido e amado Mestre, merece todas as coisas bonitas do mundo, e certamente merece este baile. \n Então Karen já aceitou o convite em seu nome, e eu até organizei uma carruagem para você, cuidando de tudo, para que você só precise ir à casa do prefeito com Karen~ \n Karen usará seu vestido mais bonito e trará suas joias mais brilhantes, mostrando a todos o poder da empregada versátil, trazendo honra e glória para você! \n Ah, quando você ler esta carta, eu já devo estar esperando do lado de fora da sua porta, e aquelas carruagens, junto com os serviçais entregando novas roupas e joias, devem estar no lugar; o único pequeno problema é que esses serviços ainda não foram pagos... \n Mas meu gentil e adorável Mestre nunca se preocuparia com essas questões triviais, certo? O prefeito ainda está nos esperando~ \n\n Sua empregada mais adorável e radiante \n Karen"
  },
  Mail_126938_Name = {
    Text = "Baile Luxuoso"
  },
  Mail_126938_Sender = {Text = "Karen"},
  Mail_126940_Desc = {
    Text = "Guardião, Guardião! Há alguns dias, Jenkin disse que encontrou um lugar que se parece muito com a casa da Aurita, algo chamado água... hum, Aurita esqueceu. \n De qualquer forma, Jenkin disse que haveria golfinhos, peixinhos, um aquário e muitos, muitos medusas, e todos querem ser amigos da Aurita! \n Aurita adora amigos, e Aurita quer muitos, muitos amigos, então Aurita quer convidar seus amigos favoritos, que é o Guardião, para ir com ela no seu aniversário. \n Vamos lá, arrume suas coisas e parta comigo; Aurita não pode esperar mais. \n\n Aurita, que quer conhecer muitos e muitos novos amigos"
  },
  Mail_126940_Name = {
    Text = "Novos amigos no aquário!"
  },
  Mail_126940_Sender = {Text = "Aurita"},
  Mail_126941_Desc = {
    Text = "Guardião:  \n\nObrigado por caminhar comigo à beira-mar nas primeiras horas desta manhã. As ondas quebrando e o céu estrelado brilhante me fizeram sentir em paz, e me lembraram de... coisas de muito, muito tempo atrás. \nNaquela época, os membros da tripulação eram proibidos de falar comigo, então, na maior parte do tempo, eu podia apenas contemplar a superfície em constante mudança do mar e as aves marinhas que circulavam no céu. A tripulação costumava fazer desejos inconscientemente enquanto observava aquelas aves voarem. \nÀs vezes, desejavam se tornar pássaros e voar de volta para casa, de volta para seus entes queridos; às vezes, desejavam que sua viagem terminasse rapidamente, trocando a carga de seu navio por riqueza; ocasionalmente, oravam por amor romântico ou para encontrar as lendárias sereias... \nMas não importa quão complexos fossem seus desejos, todos se unificavam tarde da noite em um desejo por um sono tranquilo. Naquela época, eu respondia às suas orações, acalmando a brisa do mar e suavizando as águas. \nEntão, se Guardião, você tiver dificuldade para dormir, por favor, não vagueie sozinho à beira-mar nas primeiras horas; venha me encontrar em vez disso. \nQuero compartilhar seus fardos e ser útil, e proteger seu sono é o que posso fazer agora. \nEste também é... o \"desejo\" que fiz neste dia especial. \n\nCeleste"
  },
  Mail_126941_Name = {
    Text = "Desejando-lhe um sono tranquilo"
  },
  Mail_126941_Sender = {Text = "Celeste"},
  Mail_126942_Desc = {
    Text = "Ao Guardião da Universidade de Mythag, o sábio e benevolente senhor, abençoado pelo Destino: \n\n Saudações! \n Enquanto escrevo esta carta, hesitei, mas a honestidade também é uma virtude de um cavaleiro. Como seu cavaleiro, devo prometer minha completa lealdade a você, sem ocultação, portanto, devo falar a verdade para você—\n Neste aniversário, meu senhor, peço que venha ao meu quarto e me leia uma história de ninar. \n Por favor, permita-me... descansar ao seu lado e adormecer com as histórias encantadoras e belas que você conta. \n Na verdade, este era um dos meus desejos de infância. No entanto, o treinamento de cavaleiro não permite um momento de ociosidade, e há muito já cresci além da idade de ouvir histórias, então guardei isso em meu coração e nunca o manifestei. Mas você... meu senhor, você é diferente; não desejo esconder nada de você... \n Se você achar este pedido inadequado, por favor, me avise. A partir de então, não farei tal pedido excessivo novamente e treinarei ainda mais duro. \n Aguardando sua resposta. \n\n Ogier"
  },
  Mail_126942_Name = {
    Text = "O Pedido do Cavaleiro"
  },
  Mail_126942_Sender = {Text = "Ogier"},
  Mail_126943_Desc = {
    Text = "Coalsie: \n\nHoje, Mosk, é seu aniversário!\nOs amigos disseram que, no seu aniversário, escreva uma carta para Coalsie, Coalsie virá brincar!\nMosk não sabe como escrever uma carta. Mas, os amigos podem!\nOs amigos ensinam Mosk. Mosk está feliz!\nNa verdade, Mosk esqueceu do aniversário.\nMas, Mosk quer brincar com Coalsie!\nEntão, Mosk decide que hoje é o aniversário!\nCoalsie coleta conchas, douradas e brancas, de todos os tipos~\nVer Coalsie me deixa feliz~ Os amigos cozinham, comida deliciosa~\nCoalsie, no lugar antigo~\nDeixe os amigos prepararem um banquete! Vamos comer juntos!\nMosk está esperando por você~\n\nMosk"
  },
  Mail_126943_Name = {
    Text = "Aniversário! Venha brincar!"
  },
  Mail_126943_Sender = {Text = "Mosk"},
  Mail_126944_Desc = {
    Text = "Keeper: \n\nHá alguns dias, você mencionou querer fazer um desejo durante uma chuva de meteoros, então eu organizei esta viagem especialmente para você. Obrigado por aceitar meu convite; estarei esperando sua chegada à beira-mar, como prometido. \nFique tranquilo, esta é uma viagem de curto prazo, e eu examinei minuciosamente as águas próximas para garantir que posso guiá-lo com segurança até o local da chuva de meteoros e ajudá-lo a adquirir um meteorito. \nDessa forma, você poderá tocar pessoalmente nas estrelas cadentes e, a uma distância tão próxima, elas certamente ouvirão seus desejos e os realizarão! Será uma das coisas mais especiais que já fiz ao ser a pessoa a ajudá-lo a fazer seu desejo. Estou profundamente honrado. \nMais uma vez, obrigado; você me deu uma nova \"Missão de Navegação\" neste dia especial. Por favor, certifique-se de chegar a tempo; estarei esperando por você. \n\nCorposant"
  },
  Mail_126944_Name = {
    Text = [[


Um Desejo ao Alcance]]
  },
  Mail_126944_Sender = {Text = "Corposant"},
  Mail_129637_Desc = {
    Text = "Caro(a):\n\nNão me lembro quantas vezes passei pelo canteiro de flores atrás do relógio, mas uma vez prestei atenção ao jardim de rosas. \nDesde então, passei por aqui várias vezes, vivenciando momentos de agitação no lago negro, momentos de morte e confronto, momentos em que o tempo parecia reverter seu fluxo, e todas essas experiências estavam ali, imutáveis e silenciosas, como sempre. \nEssa imagem despertou memórias que não me pertencem, das rosas que Ramona queria te presentear, e isso me trouxe um pouco de conforto. \nApesar da distância entre nossos mundos, sempre acreditei que, independentemente das dificuldades que você enfrentar, você e essa \"Ramona\" sempre conseguirão manter uma atitude calma e destemida, encontrando o caminho para a solução. \nAfinal, não importa como o mundo mude, as rosas sempre continuam a florescer.\n\n\"Ramona\""
  },
  Mail_129637_Name = {
    Text = "Jardim de rosas…"
  },
  Mail_129637_Sender = {Text = "\"ramona\""},
  Mail_129806_Desc = {
    Text = "Guardião: \n\nNa mansão da Cidade do Mar, as luzes já estão acesas. Não sei onde você está neste momento, quem está ao seu lado? \nNo início do ano, o dia mais importante do antigo país, uma festa que celebra a reunião e o novo nascimento. Este dia, eu já experimentei muitas vezes, mas nunca me senti entediada. O inverno rigoroso passou, tudo cresce, as pessoas estão tão ansiosas, esperando poder, assim como esta terra, deixar para trás todas as desgraças do passado e acolher um novo começo. \nEssas feridas antigas e desejos não são coisas que possam ser facilmente abandonadas. Deixar o velho para trás e receber o novo, que belo desejo... Talvez a dor cresça novamente, os desejos nunca desapareçam, mas esta noite, pelo menos esta noite, as pessoas levantarão seus copos em celebração, comemorando um novo mundo, um novo eu. \nAssim, na transição do velho ano para o novo, as pessoas recebem com fogos de artifício. \nEntre todas as coisas interessantes, os fogos de artifício são o meu amor verdadeiro. Todos olham para eles, vendo-os queimar, subir, florescer, como se estivessem olhando para um deus, admirando aquele brilho efêmero e incomparável. \nVocê já percebeu? Ao olhar para os fogos de artifício, o coração de cada pessoa é limpo. Eles esquecem o ódio, esquecem o sofrimento, esquecem toda a sujeira. O coração de todos se transforma em um lago tranquilo, na superfície imaculada do lago, apenas o belo reflexo dos fogos de artifício. \nShhh... não pergunte o que vem depois dos fogos de artifício. O novo nascimento pode ser um desejo extravagante, mas não deixe de valorizar sua floração. \nEntre todas as coisas indesejáveis, os fogos de artifício são a coisa mais pura. Esta noite, eu desejo oferecer a você a minha parte. \nLevante a cabeça, não pisque. Olhe aquelas estrelas brilhantes subindo, e quando os fogos de artifício florescerem, celebre um novo eu, Guardião. \n\n \"Mil Ventoinhas\""
  },
  Mail_129806_Name = {
    Text = "fogos de artifício"
  },
  Mail_129806_Sender = {Text = "Xu"},
  Mail_130223_Desc = {
    Text = "Estimado Guardião:\n A atividade \"renascimento de cabeça para baixo\" foi Concluído. O \"Pó de Escama Pálida\", \"Pó de Escama Vermelha\" e \"Pó de Escama Brilhante\" restantes do Guardião serão convertidos à proporção de \"Cupom de ouro rosa\" × 40 por unidade. Por favor, lembre-se de verificar o recebimento."
  },
  Mail_130223_Name = {
    Text = "Recuperação de Pó de Escama"
  },
  Mail_130223_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_131005_Desc = {
    Text = "Caro guardião do segredo: \n A atividade \"Chamada de Musk\" foi concluída. Agora converteremos os \"Conchas Número 1\", \"Conchas Número 2\" e \"Conchas Número 3\" restantes do guardião na proporção de 40 \"Cupons de Ouro Rosa\" por cada unidade. Por favor, lembre-se de verificar."
  },
  Mail_131005_Name = {
    Text = "Recuperação de caracol"
  },
  Mail_131005_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_131093_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"Festa Ardente·clon\" foi encerrada. Agora, converteremos os \"Os Tibia original\", \"Amónito de folhas arredondadas\" e \"Ruínas Espirais\" restantes do guardião na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Por favor, lembre-se de verificar."
  },
  Mail_131093_Name = {
    Text = "Reciclagem de Moeda do Banquete Ardente"
  },
  Mail_131093_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_131767_Desc = {
    Text = "Eu @2! @3 sou @2 o Altíssimo @3 misto @4 e destruição @2! Clame @4...!\n\n Ai ai! Olhe o que você fez!!! Você tocou no tabu do Deus Altíssimo! Agora está feito, o sussurro d'Ele já ressoou em seu mundo, a calamidade negra começará a se espalhar a partir do seu comunicador, consumindo tudo ao seu redor...\nPobre coitado, sua imprudência realmente me deixa em apuros. Mas não precisa desanimar, por um golpe de sorte, você me encontrou — a grande fada da seita, o Eleito do Deus, o Executor do Deus Altíssimo, o herdeiro legítimo da grandiosa seita, o redentor do sofrimento, o amigo próximo do Rei dos Deuses! Eu sou a vontade do Deus da bondade e do amor, não suporto o sofrimento neste mundo, e usarei meu poder supremo para salvar cada pequeno travesso tolo.\nOh, esta fada viu seu olhar de provocação. Não se preocupe, o Deus da bondade ama a humanidade e nunca se importa com a tolice dos mortais. A desconfiança em relação ao Salvador é um caminho que todo fiel deve percorrer. Estas ofertas de boas-vindas são os presentes do Executor de Deus para você.\nAgora, o caminho iluminado já foi apontado: leve sua sinceridade até a catedral @2 na cidade @3, e ofereça sua lealdade ao Deus da bondade, e você obterá o poder tão desejado, libertando-se da maldição deste pesadelo. Claro, também será necessário oferecer sua riqueza. Não me entenda mal, o Deus da bondade nunca se importa com recompensas mundanas, mas seus fiéis também precisam de dinheiro para fazer as coisas. Não seja mesquinho com essas coisas banais, querido fiel, um centavo vale o que vale.\nClame o nome do Deus da bondade e aguarde o momento da Chegada do Milagre!\n\n Grande fada da seita, o Eleito do Deus"
  },
  Mail_131767_Name = {
    Text = "Por favor, não toque em @2"
  },
  Mail_131767_Sender = {Text = "Caraboo"},
  Mail_132339_Desc = {
    Text = "Prezado Guardião:\n\"Revolução do Rei Divino·Recriar\" atividade foi concluída, agora a quantidade restante de \"Pensamentos cansados\", \"Pensamentos melancólicos\", \"Pensamentos alegres\" será convertida na proporção de cada um trocando por \"Cupom de ouro rosa\" × 40, por favor, lembre-se de verificar."
  },
  Mail_132339_Name = {
    Text = "Recuperação de moeda do evento Reviver do Rei Divino"
  },
  Mail_132339_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_132458_Desc = {
    Text = "Caro Guardião:\n        Agradecemos pelo seu apoio e reconhecimento a \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo aos Guardiões do segredo na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como agradecimento pela sua colaboração, preparamos \"Núcleo de prata\" × 200 como recompensa; complete o questionário para recebê-lo. O prazo para preenchimento do questionário é até 17 de agosto às 9:00, por favor, preste atenção e preencha a tempo.\n        <SurveyLink:\"Clique aqui para preencher\">\n        Iremos ouvir atentamente as sugestões de cada Guardião, seu feedback certamente tornará a Universidade de Misag cada vez melhor!\n        — Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_132458_Name = {
    Text = "Questionário de Pesquisa de Experiência de Versão V2.5.3"
  },
  Mail_132458_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_132578_Desc = {
    Text = "Caro Guardião:\nNa temporada \"{s1}\" de \"Hectic Skybound Rail\", você conquistou o título \"{s2}\".\nVocê receberá as seguintes recompensas bônus. Não se esqueça de resgatá-las."
  },
  Mail_132578_Name = {
    Text = "Recompensas de Temporada de \"Hectic Skybound Rail\""
  },
  Mail_132578_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_132579_Desc = {
    Text = "Caro Guardião:\nNa temporada \"{s1}\" de \"Fase de Duelo: Pré-formação\", você conquistou o título \"{s2}\".\nVocê receberá as seguintes recompensas bônus. Não se esqueça de resgatá-las."
  },
  Mail_132579_Name = {
    Text = "Recompensas de Temporada de \"Fase de Duelo: Pré-formação\""
  },
  Mail_132579_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_132580_Desc = {
    Text = "Caro Guardião:\nNa temporada \"{s1}\" de \"Mergulho Fantasmal\", você conquistou o título \"{s2}\".\nVocê receberá as seguintes recompensas bônus. Não se esqueça de resgatá-las."
  },
  Mail_132580_Name = {
    Text = "Recompensas de Temporada de \"Mergulho Fantasmal\""
  },
  Mail_132580_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_132581_Desc = {
    Text = "Caro Guardião:\nNa temporada \"{s1}\" de \"Fase de Duelo: Modo de seleção da roda\", você conquistou o título \"{s2}\".\nVocê receberá as seguintes recompensas bônus. Não se esqueça de resgatá-las."
  },
  Mail_132581_Name = {
    Text = "Recompensas de Temporada de \"Fase de Duelo: Modo de seleção da roda\""
  },
  Mail_132581_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_132605_Desc = {
    Text = "Piu Piu Piu, Piu Piu Piu Piu Piu!\n(Guardião, feliz Dia da Mentira!)\nPiu Piu Piu, Piu Piu!\n(Foto de identificação, para recordação!)\n\"Impressão de patas de lontra molhadas e desordenadas\"\n\"Uma grande quantidade de impressões borradas deixadas por falhas na cera de lacre\"\n                                                         — uma impressão de pata de lontra perfeitamente feita"
  },
  Mail_132605_Name = {
    Text = "Um pedaço de papel molhado"
  },
  Mail_132605_Sender = {Text = "Piu!"},
  Mail_133276_Desc = {
    Text = "Caro Guardião:\nO evento \"A Grande Conquista·clon\" terminou. Os itens restantes de \"Delicioso churrasco de Leão\" serão convertidos a uma taxa de 40 \"Cupom de ouro rosa\" por item. Não se esqueça de verificar suas recompensas."
  },
  Mail_133276_Name = {
    Text = "Recuperação de moeda do churrasco Leo delicioso"
  },
  Mail_133276_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_133703_Desc = {
    Text = "Prezado(a) Guardião:\n{s1} A versão foi concluída. O \"Núcleo Etéreo\" restante dos Guardiões do segredo foi automaticamente convertido na proporção de 1 \"Núcleo Etéreo\" por 1 \"Núcleo Imaculado\". Desta vez, foram convertidos \"Núcleo Imaculado\" × {s2}. Por favor, lembre-se de verificar."
  },
  Mail_133703_Name = {
    Text = "Aviso de Conversão do \"Núcleo do Vazio\""
  },
  Mail_133703_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_133704_Desc = {
    Text = "Prezado(a) Guardião:\n{s1} A versão está prestes a terminar. Pedimos que todos os Guardiões do segredo utilizem o \"Núcleo Etéreo\" restante a tempo. Após o término do Currículo deste período, o \"Núcleo Etéreo\" restante dos Guardiões será convertido na proporção de 1 \"Núcleo Etéreo\" por 1 \"Núcleo Imaculado\"."
  },
  Mail_133704_Name = {
    Text = "Aviso de Expiração do \"Núcleo do Vazio\""
  },
  Mail_133704_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_134024_Desc = {
    Text = "Caro Guardião:\nO \"Treinamento diário\" foi removido. As \"Credenciais de agente\" restantes serão convertidas a uma taxa de \"Cupom de ouro rosa\" × 10000 por credencial. Não se esqueça de verificar suas recompensas."
  },
  Mail_134024_Name = {
    Text = "Reciclagem de Credencial de agente"
  },
  Mail_134024_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_134067_Desc = {
    Text = "Guardião,\n\nHá algo especial que gostaria de discutir com você hoje.\nQuero apenas passear pela cidade, olhando casualmente para todo tipo de coisas interessantes, indo aonde eu quiser—passando um dia comum.\n\nEntão fui perguntar ao Escritório de Assuntos Acadêmicos. Disseram que, por razões de segurança, só posso sair do campus se você me acompanhar.\nTambém me disseram para não assustar ninguém, e para não colocar tudo que eu vejo na boca enquanto estiver fora. Que grosseria.\nBem, é assim que é. Então, poderíamos sair para um passeio juntos? Todos nós, todo mundo.\n\n...Por algum motivo, me ocorreu que sementes de dente-de-leão um dia cavalgarão o vento e partirão em uma jornada para onde quer que o destino as leve.\nTalvez seja amanhã, ou talvez não seja por muito, muito tempo.\nPensando nisso, fazer mais coisas juntos com todos enquanto ainda posso não parece tão ruim.\n\nEnfim, estarei esperando em frente ao dormitório. Por favor!\n\nSaya"
  },
  Mail_134067_Name = {Text = "Passeio..."},
  Mail_134067_Sender = {Text = "Saya"},
  Mail_134068_Desc = {
    Text = "Guardião de Segredos:\n\nAcho que hoje é um dia especial. Mas os contornos das minhas memórias continuam tão vagos.\nApenas o nome \"Saya\" me mantém, a custo, ligada a este lugar.\n\nEssa sensação não é solidão, nem tristeza — não é uma emoção tão vívida assim.\nSe eu tivesse que dar um nome a este sentimento... seria, provavelmente, \"vazio\".\nNada existe, uma transparência infinita e cristalina, um tempo sereno.\n\nSe um dia, as sementes de dente-de-leão, levadas pelo vento,\ncaíssem silenciosa e puramente brancas em cada canto deste mundo...\nTalvez então eu finalmente pudesse sentir que este mundo é \"especial\".\n\nNesse momento, a névoa cinzenta que permeia Londinium, o carmesim ardente do pôr do sol, e o céu que você sempre contemplava na praça da escola — tudo seria coberto por dentes-de-leão, tornando-se de um branco puro. Tornando-se da minha cor.\n\nEntão... se você quiser me dar algo,\nnão precisa ser um presente — apenas uma \"memória\" bastaria.\n\nEu, no mundo puramente branco onde os dentes-de-leão florescem,\napenas espero em silêncio pela chegada desse momento.\n\nQuando um dia você erguer os olhos ao céu novamente na Praça Mesagoza,\npor favor, sobreponha levemente aquele fio de penugem branca\nque cruza o canto do seu olhar à silhueta de mim, que um dia conversou com você.\n\nSaya"
  },
  Mail_134068_Name = {
    Text = "A promessa do dente-de-leão..."
  },
  Mail_134068_Sender = {Text = "Saya"},
  Mail_139809_Desc = {
    Text = "Caro Guardião:\n        Obrigado pelo seu apoio e reconhecimento de [Véspera do Esquecimento]. Para proporcionar aos Guardiões uma melhor experiência de jogo na Universidade de Misag, convidamos sinceramente você a preencher o seguinte questionário de pesquisa de experiência. Como forma de agradecimento pela sua cooperação, preparamos Núcleo de prata × 200 como recompensa, que pode ser resgatada após a conclusão do questionário. O prazo da pesquisa é 16 de maio às 9:00. Por favor, certifique-se de preenchê-lo a tempo.\n        <SurveyLink:[Clique aqui para preencher]>\n        Consideraremos cuidadosamente as sugestões de cada Guardião, e o seu feedback certamente ajudará a tornar a Universidade de Misag cada vez melhor!\n        —Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_139809_Name = {
    Text = "Questionário de Experiência da Versão V2.5.0"
  },
  Mail_139809_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_139927_Desc = {
    Text = "Prezado Guardião:\nO evento \"Sinfonia Imaterial·clon\" foi Concluído. Seus \"Canto heroico\" restantes foram convertidos a uma taxa de 40 × Cupom de ouro rosa cada. Por favor, colete-os."
  },
  Mail_139927_Name = {
    Text = "Melodia aguda recuperada"
  },
  Mail_139927_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_140084_Desc = {
    Text = "Prezado(a) Guardião:\n\"Mil Raios Brilhantes Descem·clon\" Concluído, agora os Selo da Riqueza, Selo de Banquete de Sangue e Selo de Guerra restantes do Guardião serão convertidos na proporção de Cupom de ouro rosa × 40 por unidade. Por favor, lembre-se de verificar."
  },
  Mail_140084_Name = {
    Text = "Recuperação de balas"
  },
  Mail_140084_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_140478_Desc = {
    Text = "Prezado(a) Guardião(ã) dos Segredos:\n O evento \"Fonte do Amor\" já terminou. As recompensas não resgatadas durante o evento estão sendo enviadas a você. Por favor, verifique sua caixa de entrada."
  },
  Mail_140478_Name = {
    Text = "Reemissão de Recompensa da Corrente de Paixão"
  },
  Mail_140478_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_140690_Desc = {
    Text = "Caro Guardião: \nA atividade \"Até a Neve Derreter·clon\" foi encerrada. As moedas de atividade restantes do guardião — \"Brotinho congelado\", \"Brotinho de prata com geada\" e \"Botão de sol\" — serão convertidas na proporção de \"Cupom de ouro rosa * 40\" por cada unidade. Por favor, verifique e confirme o recebimento."
  },
  Mail_140690_Name = {
    Text = "Recuperação de Broto"
  },
  Mail_140690_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_140751_Desc = {
    Text = "Prezado(a) Guardião:\n\"Antes que a primavera murche·clon\" Concluído, agora as Poesia Alegre, poesia melancólica e Poema de Arrependimento restantes do Guardião serão convertidas na proporção de Cupom de ouro rosa × 40 por unidade. Por favor, verifique."
  },
  Mail_140751_Name = {
    Text = "Reaproveitamento de poemas"
  },
  Mail_140751_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_141372_Desc = {
    Text = "Prezado(a) Guardião:\n\"Ebwynnos Evermore\" Concluído, agora as \"Presa\" Fresca, \"Presa\" Colossal e \"Presa\" Primordial restantes do Guardião serão convertidas na proporção de Cupom de ouro rosa × 40 por unidade. Por favor, lembre-se de verificar."
  },
  Mail_141372_Name = {
    Text = "Recuperação de moeda Ebwynnos Evermore"
  },
  Mail_141372_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_141470_Desc = {
    Text = "Prezado(a) Guardião:\n\"Prisioneiro Espelho·clon\" Concluído, agora os Livro de senso comum, Livro de Matemática e Livro de literatura restantes do Guardião serão convertidos na proporção de Cupom de ouro rosa × 40 por unidade. Por favor, lembre-se de verificar."
  },
  Mail_141470_Name = {
    Text = "Recuperação de moeda do evento Prisioneiro da Imagem"
  },
  Mail_141470_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_141507_Desc = {
    Text = "Guardião: \n\nO dia do meu nascimento, talvez seja um dia importante para você? \nPara mim, o peso de cada dia na teia do Destino é igual. São as outras histórias que conferem a este dia seu significado especial. \nEu nasci neste dia, compreendi a profecia neste dia, recebi o fuso do destino neste dia, e vi os intricados fios do destino, junto com os pesadelos no final desses fios. \nPara o tecelão do destino, este dia é comum. Para os atores no palco, este dia merece ser celebrado. E entre todas as identidades, a que mais alegria me traz é ser eu mesmo um ator. \nGuardião, hoje, as luzes do teatro do destino se apagaram, deixando apenas um palco brilhantemente iluminado. Você mencionou querer ver mais dos destinos que experimentei. E agora, o que este palco está prestes a apresentar é uma história sobre mim mesmo. \nEu não sei qual parte será apresentada. Eu trarei minhas memórias para o palco, e ela escolherá um segmento que você mais deseja ver, para apresentar no palco de hoje à noite nesses momentos intensos. \nEssa história pode me causar dor, ou pode me envergonhar, mas isso não importa, não é? Eu acho que, ocasionalmente, deixar o fuso tecer por conta própria e ser um público puro é algo encantador. \nO único ingresso para esta apresentação agora está em suas mãos. Por favor, venha com esta carta, Guardião. Esta noite, uma história desconhecida para os outros aguarda sua chegada. \n\nArachne"
  },
  Mail_141507_Name = {
    Text = "História Oculta"
  },
  Mail_141507_Sender = {Text = "Arachne"},
  Mail_141833_Desc = {
    Text = "Prezado(a) Guardião do segredo:\n\"Lua Nova e Neve Profunda\" foi Concluído. As \"Maçã Carmesim\", \"Maçãs de Ouro\" e \"Maçã Caramelada\" restantes do Guardião do segredo serão convertidas na proporção de Cupom de ouro rosa × 40 por unidade. Por favor, lembre-se de verificar."
  },
  Mail_141833_Name = {
    Text = "Reciclagem de Maçãs"
  },
  Mail_141833_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_141957_Desc = {
    Text = "Prezado(a) Guardião:\n        Obrigado pelo seu apoio e reconhecimento a \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo ao Guardião na Universidade de Misag, convidamos você a preencher o seguinte questionário de pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos \"Núcleo de prata\" × 200 como recompensa, que pode ser coletado após a conclusão do questionário. O prazo para preenchimento é 15 de fevereiro às 9:00. Por favor, preencha dentro do prazo.\n        <SurveyLink:[Clique aqui para preencher]>\n        Ouviremos atentamente as sugestões de cada Guardião, e o seu feedback certamente tornará a Universidade de Misag cada vez melhor!\n        — Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_141957_Name = {
    Text = "Questionário de Pesquisa de Experiência da Versão V2.7.2"
  },
  Mail_141957_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_141958_Desc = {
    Text = "Prezado(a) Guardião:\n        Obrigado pelo seu apoio e reconhecimento a \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo ao Guardião na Universidade de Misag, convidamos você a preencher o seguinte questionário de pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos \"Núcleo de prata\" × 200 como recompensa, que pode ser coletado após a conclusão do questionário. O prazo para preenchimento é 21 de dezembro às 9:00. Por favor, preencha dentro do prazo.\n        <SurveyLink:[Clique aqui para preencher]>\n        Ouviremos atentamente as sugestões de cada Guardião, e o seu feedback certamente tornará a Universidade de Misag cada vez melhor!\n        — Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_141958_Name = {
    Text = "Questionário de Pesquisa de Experiência da Versão V2.7.0"
  },
  Mail_141958_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_141959_Desc = {
    Text = "Prezado(a) Guardião:\n        Obrigado pelo seu apoio e reconhecimento a \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo ao Guardião na Universidade de Misag, convidamos você a preencher o seguinte questionário de pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos \"Núcleo de prata\" × 200 como recompensa, que pode ser coletado após a conclusão do questionário. O prazo para preenchimento é 18 de janeiro às 9:00. Por favor, preencha dentro do prazo.\n        <SurveyLink:[Clique aqui para preencher]>\n        Ouviremos atentamente as sugestões de cada Guardião, e o seu feedback certamente tornará a Universidade de Misag cada vez melhor!\n        — Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_141959_Name = {
    Text = "Questionário de Pesquisa de Experiência da Versão V2.7.1"
  },
  Mail_141959_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_141960_Desc = {
    Text = "Prezado(a) Guardião:\n        Obrigado pelo seu apoio e reconhecimento a \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo ao Guardião na Universidade de Misag, convidamos você a preencher o seguinte questionário de pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos \"Núcleo de prata\" × 200 como recompensa, que pode ser coletado após a conclusão do questionário. O prazo para preenchimento é 15 de março às 9:00. Por favor, preencha dentro do prazo.\n        <SurveyLink:[Clique aqui para preencher]>\n        Ouviremos atentamente as sugestões de cada Guardião, e o seu feedback certamente tornará a Universidade de Misag cada vez melhor!\n        — Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_141960_Name = {
    Text = "Questionário de Pesquisa de Experiência da Versão V2.7.3"
  },
  Mail_141960_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_141961_Desc = {
    Text = "Prezado(a) Guardião:\n        Obrigado pelo seu apoio e reconhecimento a \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo ao Guardião na Universidade de Misag, convidamos você a preencher o seguinte questionário de pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos \"Núcleo de prata\" × 200 como recompensa, que pode ser coletado após a conclusão do questionário. O prazo para preenchimento é 12 de abril às 9:00. Por favor, preencha dentro do prazo.\n        <SurveyLink:[Clique aqui para preencher]>\n        Ouviremos atentamente as sugestões de cada Guardião, e o seu feedback certamente tornará a Universidade de Misag cada vez melhor!\n        — Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_141961_Name = {
    Text = "Questionário de Pesquisa de Experiência da Versão V2.7.4"
  },
  Mail_141961_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_141962_Desc = {
    Text = "Prezado(a) Guardião:\n        Obrigado pelo seu apoio e reconhecimento a \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo ao Guardião na Universidade de Misag, convidamos você a preencher o seguinte questionário de pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos \"Núcleo de prata\" × 200 como recompensa, que pode ser coletado após a conclusão do questionário. O prazo para preenchimento é 10 de maio às 9:00. Por favor, preencha dentro do prazo.\n        <SurveyLink:[Clique aqui para preencher]>\n        Ouviremos atentamente as sugestões de cada Guardião, e o seu feedback certamente tornará a Universidade de Misag cada vez melhor!\n        — Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_141962_Name = {
    Text = "Questionário de Pesquisa de Experiência da Versão V2.7.5"
  },
  Mail_141962_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_142101_Desc = {
    Text = "Há quanto tempo, %player%:\n\nQuando você receber esta carta, eu já devo estar sobrevoando Yagruo. Todo ano neste mês, minha jornada de caça sempre se estende um pouco mais longe.\nNada é mais adequado como trilha sonora de aniversário do que os gritos e lamentos dos inimigos. Além disso, preparei gaiolas suficientes — Desde Que ainda haja tolos dispostos a venerar esses falsos deuses que não trazem nada além de sofrimento, sem qualquer Redenção, não importa onde estejam no mundo, farei com que percebam seus erros.\nÀs vezes, quando o pesadelo atravessa as nuvens e consigo ver a lua, alguns pensamentos absurdos realmente me passam pela mente por um instante.\nComo, por exemplo, quando esse tempo será forçado a parar de repente e de forma irresistível, assim como a vida desmoronou sem qualquer aviso.\nMas logo me faço rir de mim mesmo — no dia em que entrei nesse caminho, embarquei em uma jornada sem volta. Tenho certeza de que você entende o que quero dizer, pequeno(a). Neste mundo, não há ninguém em situação mais semelhante à sua e à minha.\nAmbos escolhemos algumas escolhas que não eram escolhas. A boa notícia é que ambos aproveitamos muito nossas escolhas.\nNo novo ano, Desde Que você sopre o apito de caça que lhe dei, ainda aparecerei ao seu lado a qualquer momento.\nClaro, salvo imprevistos, deixe-me primeiro aproveitar tranquilamente esta viagem. No mês que vem, trarei lembranças e algumas notícias novas para você.\nDesejo que tudo corra bem, desejo que seja feliz.\n\nSeu querido \"tio\""
  },
  Mail_142101_Name = {Text = "Notícias"},
  Mail_142101_Sender = {
    Text = "Seu querido \"tio\""
  },
  Mail_143935_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"Texto Temporário\" foi concluída, agora converteremos os \"Textos Temporários\" restantes do guardião na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Lembre-se de verificar."
  },
  Mail_143935_Name = {
    Text = "Recuperação de texto temporário"
  },
  Mail_143935_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_145435_Desc = {
    Text = "Caro Guardião:\nO evento \"O Jogo do Leviatã\" chegou ao fim. Os \"Sacrifício Carmesim\" restantes foram convertidos à taxa de \"Cupom de ouro rosa\" × 40 por item. Lembre-se de verificar suas recompensas."
  },
  Mail_145435_Name = {
    Text = "Conversão de Sacrifício Carmesim"
  },
  Mail_145435_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_145468_Desc = {
    Text = "Caro Guardião:\nO evento \"Se tudo como de costume·clon\" chegou ao fim. As \"Conchas de produtos locais da praia\" restantes foram convertidas à taxa de \"Cupom de ouro rosa\" × 40 por item. Lembre-se de verificar suas recompensas."
  },
  Mail_145468_Name = {
    Text = "Recuperação de moeda do evento Delicioso churrasco Leo"
  },
  Mail_145468_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_146401_Desc = {
    Text = "Calendários são uma invenção tediosa. Nenhum dia difere do outro — hoje inclusive.\nPelo seu Calendário, hoje é o dia em que nasci. Embora \"nascer\" dificilmente seja a palavra certa para mim. Sou um fragmento arrancado do caos, uma lâmina forjada e afiada em incontáveis batalhas. Nenhum ventre me criou; fui moldado por cada oponente que cruzou espadas comigo. E você —\nvocê é o mais vital de todos eles.\nSua espécie preza dias como este. Banquetes, presentes, bons votos — não preciso de nada disso.\nPreciso apenas de uma batalha.\nVocê fez coisas notáveis nestes últimos dias. Mas sei que o que demonstrou está longe do seu limite.\nAo entardecer de hoje, no campo de treinamento. Traga sua arma; estarei esperando. Esqueça vitória ou derrota, vida ou morte. O embate sem reservas de nossas lâminas é o único presente que desejo.\nMostre-me do que um fragmento de @4 é verdadeiramente capaz.\nAcho que você vai me surpreender, meu \"oponente\"."
  },
  Mail_146401_Name = {
    Text = "Minha Única Expectativa"
  },
  Mail_146401_Sender = {
    Text = "Lotan: Cetarcon"
  },
  Mail_146873_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"Texto Temporário\" foi concluída, agora converteremos os \"Textos Temporários\" restantes do guardião na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Lembre-se de verificar."
  },
  Mail_146873_Name = {
    Text = "Recuperação de texto temporário"
  },
  Mail_146873_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_147081_Desc = {
    Text = "Calendários são uma invenção tediosa. Nenhum dia difere do outro — hoje inclusive.\nPelo seu Calendário, hoje é o dia em que nasci. Embora \"nascer\" dificilmente seja a palavra certa para mim. Sou um fragmento arrancado do caos, uma lâmina forjada e afiada em incontáveis batalhas. Nenhum ventre me criou; fui moldado por cada oponente que cruzou espadas comigo. E você —\nvocê é o mais vital de todos eles.\nSua espécie preza dias como este. Banquetes, presentes, bons votos — não preciso de nada disso.\nPreciso apenas de uma batalha.\nVocê fez coisas notáveis nestes últimos dias. Mas sei que o que demonstrou está longe do seu limite.\nAo entardecer de hoje, no campo de treinamento. Traga sua arma; estarei esperando. Esqueça vitória ou derrota, vida ou morte. O embate sem reservas de nossas lâminas é o único presente que desejo.\nMostre-me do que um fragmento de @4 é verdadeiramente capaz.\nAcho que você vai me surpreender, meu \"oponente\"."
  },
  Mail_147081_Name = {
    Text = "Minha Única Expectativa"
  },
  Mail_147081_Sender = {
    Text = "Lotan: Cetarcon"
  },
  Mail_147535_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"Texto Temporário\" foi concluída, agora converteremos os \"Textos Temporários\" restantes do guardião na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Lembre-se de verificar."
  },
  Mail_147535_Name = {
    Text = "Recuperação de texto temporário"
  },
  Mail_147535_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_147798_Desc = {
    Text = "Prezado(a) Guardião do segredo:\n        Na atualização V2.6.0, corrigimos o problema da Recompensa oculta ausente na Operação de investigação H7-6 do Capítulo Esquecido. Como você já havia Concluído H7-6 antes da correção, enviaremos diretamente a Recompensa oculta que estava faltando. Por favor, verifique."
  },
  Mail_147798_Name = {
    Text = "Reenvio da Recompensa oculta de H7-6"
  },
  Mail_147798_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_147875_Desc = {
    Text = "Prezado(a) Guardião do segredo:\n        Na atualização V2.6.0, corrigimos o problema da Recompensa oculta ausente na Operação de investigação H7-9 do Capítulo Esquecido. Como você já havia Concluído H7-9 antes da correção, enviaremos diretamente a Recompensa oculta que estava faltando. Por favor, verifique."
  },
  Mail_147875_Name = {
    Text = "Reenvio da Recompensa oculta de H7-9"
  },
  Mail_147875_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_148080_Desc = {
    Text = "Prezado(a) Guardião do segredo:\n        Na atualização V2.6.0, aumentamos as recompensas das \"Especificações do Quarto Elegante\". Para os Guardiões do segredo que já haviam resgatado todas as recompensas adicionais antes da atualização, enviaremos as recompensas correspondentes. Por favor, verifique."
  },
  Mail_148080_Name = {
    Text = "Reenvio de Recompensas de Especificações do Quarto Elegante"
  },
  Mail_148080_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_148081_Desc = {
    Text = "Prezado(a) Guardião do segredo:\n        Na atualização V2.6.0, aumentamos as recompensas do \"Nível de Mergulho Profundo\". Para os Guardiões do segredo que já haviam resgatado todas as recompensas adicionais antes da atualização, enviaremos as recompensas correspondentes. Por favor, verifique."
  },
  Mail_148081_Name = {
    Text = "Reenvio de Recompensas de Nível de Mergulho Profundo"
  },
  Mail_148081_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_148082_Desc = {
    Text = "Prezado(a) Guardião do segredo:\n        Na atualização V2.6.0, aumentamos as recompensas do \"Nível de Rodízio\". Para os Guardiões do segredo que já haviam resgatado todas as recompensas adicionais antes da atualização, enviaremos as recompensas correspondentes. Por favor, verifique."
  },
  Mail_148082_Name = {
    Text = "Reenvio de Recompensas de Nível de Rodízio"
  },
  Mail_148082_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_148083_Desc = {
    Text = "Prezado(a) Guardião do segredo:\n        Na atualização V2.6.0, aumentamos as recompensas do \"Nível de Pré-formação\". Para os Guardiões do segredo que já haviam resgatado todas as recompensas adicionais antes da atualização, enviaremos as recompensas correspondentes. Por favor, verifique."
  },
  Mail_148083_Name = {
    Text = "Reenvio de Recompensas de Nível de Pré-formação"
  },
  Mail_148083_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_148476_Desc = {
    Text = "Prezado(a) Guardião do segredo:\n        As recompensas obtidas por compra em \"{s1}\" ainda não foram resgatadas. Estamos enviando as recompensas não resgatadas como anexo deste e-mail. Lembre-se de liberar espaço na mochila antes de resgatar."
  },
  Mail_148476_Name = {
    Text = "Recompensas não coletadas de \"{s1}\""
  },
  Mail_148476_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_148477_Desc = {
    Text = "Prezado(a) Guardião do segredo:\n        As recompensas obtidas em \"{s1}\" ainda não foram resgatadas. Estamos enviando as recompensas não resgatadas como anexo deste e-mail. Lembre-se de liberar espaço na mochila antes de resgatar."
  },
  Mail_148477_Name = {
    Text = "Recompensas não coletadas de \"{s1}\""
  },
  Mail_148477_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_148478_Desc = {
    Text = "Prezado(a) Guardião do segredo:\n        As recompensas obtidas no \"Currículo - Tema avançado\" do período {s1} ainda não foram resgatadas. Estamos enviando as recompensas não resgatadas como anexo deste e-mail. Lembre-se de liberar espaço na mochila antes de resgatar."
  },
  Mail_148478_Name = {
    Text = "Reenvio de Recompensas Não Resgatadas do Tema avançado do Currículo {s1}"
  },
  Mail_148478_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_148514_Desc = {
    Text = "Prezado(a) Guardião do segredo:\n        Na atualização da versão V1.4.3.5, adicionamos a Fase \"Novo rei\" na \"Visão de Sonhos Estranhos: Profanação\". Como alguns Guardiões do segredo não foram informados a tempo sobre essa atualização, acreditaram erroneamente que a \"Visão de Sonhos Estranhos: Profanação\" havia sido totalmente Concluída.\n        Por isso, na atualização da versão V2.6.2, já complementamos o progresso de conclusão da Fase \"Novo rei\" para os Guardiões do segredo que haviam Concluído as Fases posteriores ao \"Novo rei\" antes da atualização, e também enviamos simultaneamente as recompensas de primeira conclusão correspondentes. Por favor, verifique."
  },
  Mail_148514_Name = {
    Text = "Complemento de Progresso de \"Profanação\""
  },
  Mail_148514_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_148515_Desc = {
    Text = "Querido(a) Guardião do segredo:\n\nTa-da~ Surpreendente, não é? Este é o primeiro aniversário desta fada em Misaq, então—\nInacreditável! Nenhum e-mail promocional, nenhum Convite para culto, nem mesmo uma Profecia do fim dos tempos~\nMas não fique desapontado(a), esta fada naturalmente preparou algo mais precioso e melhor para os fiéis mais especiais.\nComo fada madrinha Onisciente e onipotente, é claro que consigo prever aquelas dúvidas e precauções que surgem naturalmente, e embora isso cause à esta fada uma leve tristeza, para difundir as bênçãos da seita, pequenos Sacrifícios são sempre inevitáveis.\nPortanto, pense bem antes de recusar, experimente, afinal não há nada a perder, e se for verdade? Não é mesmo?\nEsta é uma oportunidade que acontece apenas uma vez por ano e que não deve ser perdida de jeito nenhum~\nSem necessidade de qualquer Sacrifício, sem necessidade de qualquer promessa ou troca, basta compartilhar um doce chá da tarde com a fada madrinha, e você poderá descobrir quantos sentimentos sinceros estão enterrados sob o gelo e a neve.\nNão é uma proposta tentadora?\nObservação: Por favor, traga pelo menos 10, 100, 1000 Leonian Florin suficientes para pagar a conta, quanto mais, melhor.\n\nEsperando por você naquele estabelecimento que ambos conhecemos,\nCaraboo"
  },
  Mail_148515_Name = {
    Text = "☆☆☆E-mail de Super Benefícios☆☆☆"
  },
  Mail_148515_Sender = {Text = "Caraboo"},
  Mail_149949_Desc = {
    Text = "Esta carta circulou dez mil vezes pelos reinos dos vivos e dos mortos. NÃO A APAGUE!\n\nNa décima quinta noite do sétimo mês, o portão dos fantasmas se abre de par em par, o vento frio se levanta e as almas errantes voltam para casa.\nEu sou ███ da Cidade de Hu no antigo Império de Panlong — Yizhi Yè, artesão de Zhizha, dobrador de efígies de papel e oferendas queimadas para os mortos, ao seu dispor!\n\nPelo decreto do Festival dos Fantasmas de Zhongyuan, portando o talismã-escrito de invocação de almas, lanço esta maldição sobre você esta noite. Quem quer que pouse os olhos nestas palavras: sua alma será inscrita no registro, seu nome já está gravado no livro.\n\nE se não for repassada a cinquenta almas do mundo dos vivos antes da Hora de Zi, quando a noite vira meia-noite, você certamente irá —\n\n...seus documentos vão corromper um instante antes de serem salvos...\n...seu chá de boba estará sempre três pérolas a menos...\n...seu Comunicador de Núcleo de prata ficará com 1% de bateria por toda a eternidade — carregue como quiser, jamais encherá...\n\nSeja uma boa criança e faça o que lhe é dito: a maldição se desfará sozinha, o talismã se queimará em cinzas, nenhum espírito vingativo seguirá seus passos, e sua lamparina da vida continuará a arder sem fim.\n\nENCAMINHE AGORA!! AGORA MESMO!!!"
  },
  Mail_149949_Name = {
    Text = "APAGUE ISTO E VOCÊ VAI..."
  },
  Mail_149949_Sender = {Text = "Yizhi Yè"},
  Mail_149985_Desc = {
    Text = "Meu Senhor:\n\nPeço desculpas pela carta inesperada, espero não estar sendo inconveniente. Mas há sentimentos que só consigo compartilhar com o senhor.\nOntem à noite, tive um sonho que há muito não vinha — sonhei que voltava à minha antiga Nosso Lar. Tudo era tão familiar: as mãos gentis e generosas do meu pai, as canções campestres que a criada cantarolava enquanto Limpava, e aquela égua branca de pequeno porte que era minha... Eu pensava que tudo isso havia afundado no lodaçal da memória, mas revê-los no sonho trouxe o mesmo calor de sempre.\nAo acordar, vi pela janela os professores e alunos de Misaq passando e conversando descontraidamente. Uma cena tão serena e bela que, por um momento, pareceu não ser diferente do meu sonho. Além disso, percebi que aquela presença invisível que me acompanha estava estranhamente quieta desde esta manhã. Será que no dia do aniversário realmente acontecem coisas afortunadas?\nSe for assim, talvez eu possa ser um pouco gananciosa hoje......\nSei que as pessoas costumam fazer um pedido no dia do aniversário, como um desejo para o ano inteiro. Há muito deixei de ousar esperar os votos de alguém, mas há uma oportunidade que genuinamente desejo ter.\nAssim como o senhor me confiou sua confiança, não lhe esconderei nada. Por isso, permita-me revelar meu desejo ao senhor:\nSe da próxima vez o senhor tiver uma missão a cumprir, por favor, nomeie-me como sua Guarda e deixe-me acompanhá-lo.\nSeja como for, espero que, no momento em que o senhor mais precisar de ajuda, eu possa sempre ser a primeira a me colocar à sua frente, tornando-me seu Escudo mais sólido.\nEste é o desejo que faço para este ano.\n\nOgier"
  },
  Mail_149985_Name = {
    Text = "Desejo de Aniversário…"
  },
  Mail_149985_Sender = {
    Text = "Origem: Ogier"
  },
  Mail_18019_Desc = {
    Text = "Caro Guardião:\nO sistema detectou uma ação de reembolso na conta atual. A equipe de produção deduziu a moeda virtual correspondente ao seu pedido de reembolso em {s1}. Se o saldo mostrar um valor negativo após a dedução, ele deve ser restaurado para um valor positivo antes do uso normal.\nSe você tiver alguma dúvida, entre em contato com o atendimento ao cliente."
  },
  Mail_18019_Name = {
    Text = "Aviso de Processamento de Reembolso"
  },
  Mail_18019_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_18020_Desc = {
    Text = "Olá, Guardião. A recompensa de {s1} foi enviada a você como um anexo de e-mail devido ao seu inventário estar cheio. Por favor, limpe seu inventário e reivindique-a prontamente."
  },
  Mail_18020_Name = {
    Text = "Recompensas Não Reivindicadas Reemitidas"
  },
  Mail_18020_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_18021_Desc = {
    Text = "Prezado Guardião,\nO evento atual do Registro de temas terminará em {s1} [GMT+8]. As recompensas relacionadas a este Registro de temas não estarão mais disponíveis após o término do evento. Certifique-se de reivindicar suas recompensas antes que o evento termine."
  },
  Mail_18021_Name = {
    Text = "Lembrete de Coleta de Recompensa de Treinamento"
  },
  Mail_18021_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_18029_Desc = {
    Text = "Olá, Guardião, estas são suas recompensas de ranking do Mergulho Fantasmal."
  },
  Mail_18029_Name = {
    Text = "Recompensas do Ranking do Mergulho Fantasmal"
  },
  Mail_18029_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_18031_Desc = {
    Text = "Caro Guardião:\n\nO caminho à frente é longo e cheio de espinhos. Nestes tempos difíceis, devemos nos unir e avançar como um só.\nEm anexo está o suprimento de Menofim especialmente aprovado para hoje. Por favor, aceite-o.\nQue a Chave de Prata ilumine seu caminho.\nP.S.: A distribuição deste suprimento especial agora está completa. Obrigado pelo seu trabalho árduo e dedicação.\n\nDepartamento de Logística da Faculdade Mythag"
  },
  Mail_18031_Name = {
    Text = "Distribuição de Suprimentos Intratecais"
  },
  Mail_18031_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_18034_Desc = {
    Text = "Olá, Guardião, você tem recompensas de pontos cumulativos não reivindicadas do Mergulho Fantasmal, que serão distribuídas a você via anexos de e-mail."
  },
  Mail_18034_Name = {
    Text = "Recompensas Cumulativas Não Reivindicadas por Mergulho Fantasmal"
  },
  Mail_18034_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_18035_Desc = {
    Text = "Caro Guardião:\n\nO caminho à frente é longo e cheio de espinhos. Nestes tempos difíceis, devemos nos unir e avançar como um só.\nEm anexo está o suprimento de Menofim especialmente aprovado para hoje. Por favor, aceite-o.\nQue a Chave de Prata ilumine seu caminho.\nP.S.: Seu suprimento especialmente aprovado permanecerá válido por {s1} dias. Por favor, planeje sua programação de investigação de acordo.\n\nDepartamento de Logística da Faculdade Mythag"
  },
  Mail_18035_Name = {
    Text = "Distribuição de Suprimentos Intratecais"
  },
  Mail_18035_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_20231_Desc = {
    Text = "Caro Guardião, a nova temporada de Traphase começou, redefinindo seu ranking de {s1} para {s2}. As recompensas de ranking da nova temporada foram redefinidas. Você pode ganhar mais honra e recompensas ao subir de ranking! {s3}\n{s4}"
  },
  Mail_20231_Name = {
    Text = "Traphase Temporada Correio"
  },
  Mail_20231_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_21453_Desc = {
    Text = "Caro Guardião:\n\nDesculpe incomodá-lo, mas gostaria de saber como você tem estado ultimamente?\nPeço desculpas por interromper sua agenda ocupada. Jenkin e os outros estão preparando uma pequena festa de aniversário para mim. Depois de muito pensar, decidi enviar-lhe este convite pessoalmente.\nA maioria das crianças órfãs acolhidas pela oficina não consegue se lembrar de suas datas de nascimento, então a Srta. Sarah define a data de nossa chegada ao orfanato como nossos aniversários. No entanto, eu sou diferente. A Srta. Sarah me disse que fui deixada na porta do asilo em uma fria noite de inverno. Ela queria que minha vida fosse cheia de calor, então escolheu um dia ensolarado como meu aniversário. Este é um dia que me pertence, um dia cheio de carinho e amor. É um dia importante para mim, e espero que você, Guardião, possa se juntar a mim. Este é meu Pequeno Desejo. Claro, tudo bem se não puder ser realizado, pois você, Guardião, tem muitos assuntos a atender, e Aigis entende isso.\nSe este convite causou algum incômodo, por favor, me avise e aceite minhas sinceras desculpas. No entanto, se por acaso você conseguir encontrar um tempo, será muito bem-vindo a se juntar às travessuras deles—pode ser que seja muito divertido, já que está sendo preparado por Jenkin.\n\nAigis"
  },
  Mail_21453_Name = {
    Text = "Desculpe por te incomodar no meio da sua agenda ocupada..."
  },
  Mail_21453_Sender = {Text = "Aigis"},
  Mail_21454_Desc = {
    Text = "Ei:\nSempre me perguntei o que há de tão especial em comemorar o aniversário de alguém. Por que as pessoas fazem tanto alvoroço por isso?\nNo ano passado, neste dia, uma aluna veio me perguntar a minha data de nascimento. Foi ridículo—quando eu nasci, não havia conceito de tempo neste planeta, quanto mais aniversários. Mas ela continuou me importunando até que eu não tive escolha a não ser dizer a ela \"é quando o dia e a noite são iguais.\" Ainda não sei como ela interpretou isso.\nEstou escrevendo esta carta para lembrá-lo de coletar as flores na minha porta após a meia-noite desta noite; elas estão abundantes! \n\nLotan"
  },
  Mail_21454_Name = {
    Text = "Aquelas flores..."
  },
  Mail_21454_Sender = {Text = "Lotan"},
  Mail_21455_Desc = {
    Text = "Erica trouxe um grande saco de café hoje como presente de aniversário, dizendo que é sua reserva para o ano. <Del:Mas você estava disposto a fazer isso? Se não,>\n Se isso for uma pegadinha da Boneca ou de alguém, apesar de relutante, ainda posso devolvê-lo... Afinal, é café! Não consigo funcionar sem algumas xícaras. Um ano inteiro sem isso? Você provavelmente dormiria como Tulu. Não que ele seja ruim, é só que coisas escuras aparecem à noite... De qualquer forma, se precisar de volta, fique à vontade para pegar a qualquer momento. Mas se você deixá-lo aqui, <Del:eu vou> eu ficarei muito feliz. Posso finalmente conduzir o experimento que queria fazer: extrair e concentrar cafeína em um agente que pode ser absorvido pela pele, me permitindo ficar acordado sempre, sempre...\n\n\nAnsioso por este experimento, Búzio"
  },
  Mail_21455_Name = {Text = "Café..."},
  Mail_21455_Sender = {Text = "Winkle"},
  Mail_21456_Desc = {
    Text = "Aniversário?\nSe eu tiver que dizer, meu aniversário não é um bom dia. Centenas, até milhares de vidas inocentes morrem neste dia, apenas para eu \"nascer\" e depois continuar a matar mais.\nEntão, realmente não há nada que valha a pena comemorar. Mas eu entendo que vocês humanos são muito exigentes com \"rituais\", e convenientemente, tenho um pouco de dinheiro em mãos - fique tranquilo, é meu dinheiro suado do Trout Club, não uma renda ilegal.\nTome este dinheiro e compre um presente para você, como se estivesse celebrando meu aniversário.\n\nUvhash"
  },
  Mail_21456_Name = {
    Text = "Aniversário..."
  },
  Mail_21456_Sender = {Text = "Uvhash"},
  Mail_21457_Desc = {
    Text = "Keeper: \n\n Há algum costume de celebrar aniversários no domínio de Mythag? \n Nas minhas memórias da minha terra natal... grandes cerimônias eram realizadas todos os anos para celebrar o aniversário do rei. \n Com o tempo, o significado especial de \"aniversário\" foi atribuído a todos. \n No passado distante, neste dia, colegas e amigos viajavam grandes distâncias para estar ao meu lado. \n Aquela sensação de estar cercado por entes queridos... aquele calor semelhante a um abraço do sol... talvez seja por isso que não consigo deixar o passado para trás. \n Ah... estou divagando. Eu perturbei seu trabalho? \n Preparei um pouco de chá e petiscos que costumava apreciar, e gostaria de compartilhá-los com você. \n Se você estiver disposto, por favor, venha me encontrar depois do jantar. \n\nFaros"
  },
  Mail_21457_Name = {
    Text = "Luz Eterna..."
  },
  Mail_21457_Sender = {Text = "Faros"},
  Mail_21458_Desc = {
    Text = "Hoje é de fato um dia memorável: o grande Senhor Golias, Rei dos Gigantes, chegou; o oceano tremeu, e as estrelas se apagaram.\nOuvi que extravagância não é permitida no campus, então vamos reduzir meu banquete de aniversário para um décimo do usual—dez porcos assados, cem polvos grelhados, e uma banda tocando canções folclóricas de Golias. Ah, e organize uma dúzia de dançarinas...\nO que? Nada disso é permitido?\nEntão apenas as dançarinas... Não uma dúzia, quatro ou cinco serão suficientes.\nO que? Mesmo isso não é permitido?!\nEstandartes tão mesquinhos não são dignos do meu status. Aqui decreto: o banquete está cancelado!\n\nGolias"
  },
  Mail_21458_Name = {
    Text = "Planos de Jantar..."
  },
  Mail_21458_Sender = {Text = "Goliath"},
  Mail_21459_Desc = {
    Text = "Guardião——\n\nHoje, enquanto fazia treinamento de memória com a senhora Sylvia, ela perguntou sobre meu aniversário. Você também sabe, eu consigo esquecer a chave inglesa que acabei de largar em um instante, como posso lembrar de um aniversário! E o mais grave é que isso é algo que só eu sei, eu! Este aniversário não conta. \n\nMas o padre Salvador disse que a data exata não importa, o que importa é que eu celebre algo a cada dia, então decidi que hoje é meu aniversário! Já combinei com alguém (esqueci quem, não sou eu, certo, Guardião?) para fazer uma festa na porta da cantina, você tem que vir! \n\n\n\nEu definitivamente, definitivamente vou lembrar dessa data de aniversário, Nautila.\n\n\n\nUm bilhete que veio junto com a carta: \n\nAquela criança terminou de escrever a carta e saiu correndo, esquecendo a carta e alguns presentes que disse serem para você na mesa. \nEu anexei tudo no envelope, ansioso para te ver na festa esta noite. Fique tranquilo, vou lembrá-la de comparecer esta noite. \n\n——Sylvia"
  },
  Mail_21459_Name = {
    Text = "O aniversário que decidi!"
  },
  Mail_21459_Sender = {Text = "Nautila"},
  Mail_21460_Desc = {
    Text = "Pequenino, \n\nNão há estrelas nem luas no Mar de Princípios, nem existem estações. Portanto, meu aniversário deveria ser registrado como [Unknown].\nNo entanto, hoje é de fato um dia importante, afinal, esta aparência é herdada de uma humana que tinha um [Desejo]. Ela adorava reuniões animadas, então abriu esta pequena loja, mas por causa de suas investigações, seu aniversário era frequentemente compartilhado apenas comigo. Para realizar seu último desejo, a Woe Boutique realizará um jantar à luz de velas hoje, convidando sinceramente todos os clientes fiéis a comparecer.\nÉ claro, a Woe Boutique também oferecerá um pequeno desconto para todos os visitantes, então não perca, Pequenino.\n\nDaffodil"
  },
  Mail_21460_Name = {
    Text = "Desejos Terrenos..."
  },
  Mail_21460_Sender = {Text = "Daffodil"},
  Mail_21461_Desc = {
    Text = "Quando fui levado da minha família, minha mãe adotiva... a esposa do governador quebrou a cerâmica com minha data de nascimento, quebrando meu passado como um Tilo. Meu verdadeiro aniversário, naturalmente, é desconhecido.\nDepois de me separar de Lai, pensei... E se considerarmos a noite em que escapei da prisão e comecei minha vingança como meu \"aniversário\"?\nEmbora não haja necessidade de comemorar mais um ano, como um lembrete da passagem do tempo, parece bom"
  },
  Mail_21461_Name = {
    Text = "O Dia do Nascimento"
  },
  Mail_21461_Sender = {Text = "Helot"},
  Mail_21462_Desc = {
    Text = "Teste, teste.\nCaro Guardião, olá. Se você recebeu esta carta, significa que sua contribuição é crucial para Erica, e você foi selecionado para participar do programa anual de teste e manutenção do módulo de linguagem da Autômata Erica. Esta avaliação é conduzida na forma de perguntas de resposta curta, exigindo que você forneça feedback sobre a funcionalidade do novo módulo de linguagem EA-L-1033 para a Autômata Erica. Não levará muito do seu tempo, então, por favor, não fique nervoso ou ansioso.\nPergunta de resposta curta:\nVocê entendeu a essência desta carta?\n\nPor favor, escreva sua resposta diretamente abaixo da pergunta de resposta curta e selar a carta de volta no envelope.\nObrigado por sua participação.\n\nErica"
  },
  Mail_21462_Name = {
    Text = "Testando, testando..."
  },
  Mail_21462_Sender = {Text = "Erica"},
  Mail_21463_Desc = {
    Text = "Keeper: \n\n Você é uma das poucas pessoas lúcidas nesta escola. Seu olhar pode penetrar este corpo defeituoso e ver o verdadeiro eu. \n Alguém como você deveria ser capaz de explicar claramente àquelas crianças: eu não sou uma sereia; este corpo irá atravessar os mares e escalar as montanhas, alcançando uma forma perfeita. \n ...Deixe pra lá, não vou incomodá-lo. Mas pelo menos hoje, não deixe que elas brinquem com minha cauda. \n Hoje é especial. Se você tiver tempo, gostaria de lhe contar algo pessoalmente. \n\nCaecus"
  },
  Mail_21463_Name = {
    Text = "Corpo Perfeito..."
  },
  Mail_21463_Sender = {Text = "Caecus"},
  Mail_21464_Desc = {
    Text = "Keeper:\n\nMeu aniversário no sentido mundano é o dia em que meu pai me adotou.\nNo passado, ele sempre deu grande importância a este dia, organizando grandes bailes todos os anos—dançar em um espartilho era mais exaustivo do que balançar uma espada três mil vezes.\nMas era a maneira dele de expressar amor como pai, e eu não queria desapontá-lo.\nNo entanto, este ano, ele finalmente concordou em me deixar planejar meu próprio aniversário. Talvez em seus olhos, eu não seja mais uma criança que precisa de supervisão constante.\nA propósito, você pode se juntar a mim no topo da torre do relógio? Podemos conversar e aproveitar a brisa.\nEu ouvi que esta noite será lua cheia.\n\nRamona"
  },
  Mail_21464_Name = {
    Text = "Lua Cheia..."
  },
  Mail_21464_Sender = {Text = "Ramona"},
  Mail_21465_Desc = {
    Text = "Caro, mais amado Mestre:\nSim, hoje é o aniversário de Karen@1 (a idade de uma dama deve permanecer em segredo)! \nPara esta ocasião especial, Karen preparou uma festa grandiosa sem igual e convidou todos os amiguinhos que conseguiu! Embora, no final, apenas Aurita, Ogier e Lily tenham conseguido prometer presença...\nMas tudo bem. Onde há pessoas, há festas, e onde há festas, Karen estará lá! Karen também preparou cuidadosamente um \"melhorado\" ensopado de rã, caracóis de pudim preto com alho e sopa de morcego curry. O Mestre simplesmente deve vir experimentá-los!\n\nUma pergunta silenciosa: O Mestre com certeza preparou um presente para Karen, não é? Lembre-se, deve ser brilhante!\n\nSua sempre humilde criada,\nKaren"
  },
  Mail_21465_Name = {
    Text = "Presente..."
  },
  Mail_21465_Sender = {Text = "Karen"},
  Mail_21466_Desc = {
    Text = "Querido <Del:Guardião> West-Whelp:\nEsta é uma <Del:Conviteson Conviten Convite> enfim, é para você vir comer um bolo grátis e aproveitar para comemorar meu aniversário! Na verdade, também é para agradecer por ter me ajudado a encontrar minha irmã e me trazido para cá, dando a mim e ao Marrom um lugar seguro para ficarmos.\n(O Aigis me obrigou a escrever essas coisas, que são tão melosas. Entre nós, não precisamos disso, certo, Guardião?)\nEnfim, hoje à noite, no pátio atrás do seu dormitório, eu, o Marrom e o Aigis preparamos algumas coisas boas, esperando por você! Claro que, na verdade, foi principalmente o Aigis que fez tudo, ela cozinha muito bem, as senhoras da cozinha elogiam muito o seu talento. Se você não vier, com certeza vai se arrepender.\n\nSeus velhos companheiros Jenkin e Marrom"
  },
  Mail_21466_Name = {
    Text = "Caro pessoal do West Siders..."
  },
  Mail_21466_Sender = {Text = "Jenkin"},
  Mail_21467_Desc = {
    Text = "Guardião do Segredo:\n\nDesde que os humanos viviam no reino dos deuses, já usávamos a dança para expressar nossos sentimentos — giros de alegria, passos de tristeza... Dizem que a história da dança é tão antiga quanto a história da humanidade, ela testemunhou nosso esplendor e também nosso declínio.\n\nEu já disse que nunca mais dançaria, mas... afinal, nasci para dançar. Então, só por hoje, você aceita dançar comigo? Ficar imerso nela, sentindo o ritmo mais profundo do corpo.\n\nVou esperar por você no estúdio de dança.\n\n\n\nLiz"
  },
  Mail_21467_Name = {
    Text = "Convite para Dançar"
  },
  Mail_21467_Sender = {Text = "Liz"},
  Mail_21468_Desc = {
    Text = "Caro Guardião: \n\nAntes de me tornar um Despertador, eu sempre celebrava meu aniversário com meus camaradas de batalhão, trazendo bebida de fora do acampamento e nos escondendo nas tendas onde guardávamos os suprimentos, comemorando com o pão escuro da ração, e antes que os oficiais descobrissem, jogávamos as garrafas para fora, na grama. \n\nMas Mythag não é um exército; aqui podemos nos entregar à indulgência. Gostaria de saber se você aceitaria compartilhar comigo uma garrafa de boa bebida e celebrar junto comigo meu aniversário? \nSe você aceitar, suba até o terraço do dormitório quando a lua passar acima da torre do relógio esta noite. Você já reparou? Lá tem a melhor vista de toda Mythag. \n\n\n\nElva"
  },
  Mail_21468_Name = {
    Text = "Compartilhe a boa bebida..."
  },
  Mail_21468_Sender = {Text = "Alva"},
  Mail_21469_Desc = {
    Text = "Praia! Praia! Praia! Praia! \nHuh? Escrever o nome do destinatário no início é tão problemático! O Guardião nunca escreve o destinatário nas anotações da geladeira!\nHoje é o aniversário de Aurita... uh... quantos anos ela tem mesmo? De qualquer forma, é o aniversário de Aurita!\nEssas são as preciosidades de Aurita! Tudo para você! Por favor, leve Aurita para a praia, por favor, por favor, por favor!\nConsidere como um presente de aniversário para Aurita, ok?\n\nAurita"
  },
  Mail_21469_Name = {Text = "Praia!"},
  Mail_21469_Sender = {Text = "Aurita"},
  Mail_21470_Desc = {
    Text = "Caro Amigo,\n\nNo passado, minha irmã e eu, na estrela árida, nos abraçávamos e extraíamos energia da mesma planta para comemorar nosso nascimento. \nAqueles dias eram amargos, mas agora trazem alegria e calor. \nHoje marca novamente o aniversário do nosso nascimento. Se possível, posso trocar uma canção por um galho? \nUm galho doce que represente minha irmã e eu, e nosso futuro com você...\n\nTinta"
  },
  Mail_21470_Name = {
    Text = "Canção de Aniversário"
  },
  Mail_21470_Sender = {Text = "Tinct"},
  Mail_21471_Desc = {
    Text = "Pela graça do Destino, Guardião da Universidade Mythag, sábio e benevolente mestre:\nQue a paz esteja com você!\nHá alguns dias, notei uma carroça entrando nos estábulos da escola, trazendo um cavalo de sangue quente. Eu me lembrei que durante nossa última missão de investigação, você mencionou nunca ter montado a cavalo antes. Uma jovem e gentil égua de sangue quente é a mais adequada para iniciantes.\nMontar a cavalo, perseguindo a aurora e o crepúsculo, estão entre minhas memórias mais queridas. Se você estiver disposto, adoraria compartilhar essa alegria com você.\n\nOgier"
  },
  Mail_21471_Name = {
    Text = "Cavalo de Sangue Quente"
  },
  Mail_21471_Sender = {Text = "Ogier"},
  Mail_21472_Desc = {
    Text = "O antigo calendário difere muito do que é usado em Londinium hoje.\nEu nasci no quinto dia de estrela cheia do segundo mês de verão. A decisão de celebrar hoje é baseada em cálculos feitos pelo diretor do laboratório.\nQuando a antiga nação ainda existia, o Velho sumo sacerdote cuidava de tudo. Após grandes cerimônias, a nação inteira celebrava com um feriado de sete dias.\nEmbora não fosse meu desejo, eu não tinha motivo para impedir a propagação da alegria.\nHoje não é feriado em Misaq, e como Guardião, você não terá folgas regulares.\nMas se você solicitar um dia de folga para celebrar meu aniversário, duvido que a administração se oponha.\nDesfrute de uma tarde tranquila.\n\nTulu"
  },
  Mail_21472_Name = {
    Text = "Aniversário..."
  },
  Mail_21472_Sender = {Text = "Tulu"},
  Mail_21473_Desc = {
    Text = "Keeper: \n\n Aurita diz que aqueles que fazem aniversário sempre têm que fazer desejos. \n E eu sou alguém que nunca faz desejos. \n Porque meus pensamentos sempre se tornam realidade. Isso não é sorte; parece mais como... um guia destinado? \n Assim como no mês passado, quando fui ao mar com Celeste, \"casualmente\" encontrei um lindo fóssil. \n Os locais o chamam de \"lírio do mar\". Seus braços balançam como moinhos contra a corrente, desfrutando preguiçosamente do sol da tarde de verão. \n Frágil, lindo. Quando eu o vi, sua imagem naturalmente veio à mente. \n Desta vez, eu ainda não fiz um desejo— \n Você definitivamente vai amar, certo? \n\nSanga"
  },
  Mail_21473_Name = {
    Text = "Lírio do Mar..."
  },
  Mail_21473_Sender = {Text = "Sanga"},
  Mail_21475_Desc = {
    Text = "Guardião:\n\nQuando naveguei com Elton, ele preparava um banquete neste dia todos os anos e me pedia para \"fazer um desejo.\"\nAntes de vir para cá, eu não entendia o que era um \"desejo\". Agora, não sei pelo que poderia desejar...\nTalvez encontrar um \"desejo\" possa ser meu \"desejo\"?\n\nCeleste"
  },
  Mail_21475_Name = {Text = "Desejo..."},
  Mail_21475_Sender = {Text = "Celeste"},
  Mail_21476_Desc = {
    Text = "Keeper: \n\n Aurita me disse que você pode realizar todos os desejos feitos nos aniversários, isso é verdade? \n Com certeza não pode ser verdade, certo? Realizar os desejos de todos seria um problema grande demais para você. \n No entanto, se eu pudesse fazer um desejo... eu gostaria que Tinta tivesse um palco mais amplo. \n Isso seria difícil de realizar? Hmm... Então, que tal mudar para \"no próximo ano, nenhum aipo aparecerá na minha mesa\"? Isso é aceitável? \n\nDesmaio"
  },
  Mail_21476_Name = {Text = "Desejo..."},
  Mail_21476_Sender = {Text = "Faint"},
  Mail_21477_Desc = {
    Text = "Caro Guardião:\n\nDeixe-me compartilhar um segredo com você: este aniversário não é real. Quanto à minha verdadeira data de nascimento... que ela se dissipe com o vento.\nDepois que fiquei doente, meu irmão sempre mandava o mordomo preparar secretamente um pequeno bolo para mim no meu aniversário.\nSem músicas de aniversário, sem bênçãos—celebrar um aniversário parecia algo vergonhoso.\nAgora, tudo mudou. Posso andar à luz do sol, cantar em voz alta e até mesmo celebrar meu aniversário.\nEssas podem parecer pequenas alegrias, mas elas me preenchem de nostalgia.\nObrigado, Guardião.\n\n(Claro, se você e todos pudessem ser um pouco mais ríspidos, um pouco mais agressivos... seria perfeito.)\n\nLeigh"
  },
  Mail_21477_Name = {
    Text = "Um segredo..."
  },
  Mail_21477_Sender = {Text = "Leigh"},
  Mail_21478_Desc = {
    Text = "Meu Pequeno·Prisioneiro:\n\nFaz tanto, tanto, tanto tempo desde que eu usei o chicote pela última vez—\nTrancada nesta escola monótona, presa nesses uniformes; o coração de Pandia está coçando como um gatinho travesso arranhando por dentro. Mas ninguém me entende, e a equipe faz grandes esforços para me impedir de \"me divertir\"—é tão injusto!\nAh, hoje é um dia especial, perfeito para meu chicote tocar a pele suave mais uma vez, para eu ouvir o cântico da dor... Se você tiver tempo hoje, por que não vem conversar comigo~?\n\nPandia"
  },
  Mail_21478_Name = {
    Text = "O som do chicote..."
  },
  Mail_21478_Sender = {Text = "Pandia"},
  Mail_21479_Desc = {
    Text = "<Big:Show de Aniversário do Mágico Casiah, Apenas Hoje!>\n\nPara agradecer ao nosso público por anos de apoio e incentivo, e retribuir a alegria que vocês nos trouxeram, o Mágico Casiah realizará uma apresentação especial de aniversário hoje à noite às 20h no Pátio da Universidade Mythag (ao lado da Estátua Phillips)! Esta noite, espere um palco mais deslumbrante, atos mais emocionantes e—mais importante—magias extraordinárias que deixarão você maravilhado! Até mesmo o Cérebro de Mythag ficaria atônito com essa mágica sem precedentes, garantida pelo Mestre Casiah!\n\nNão perca este evento raro e gratuito hoje à noite! O Mestre Casiah está esperando por você!\n\n<Small:PS: Casiah não é responsável por quaisquer sintomas como fadiga ou baixo-astral durante ou após o show.>\n<Small:PPS: Quaisquer promoções relacionadas ao Cérebro de Mythag estão sujeitas às circunstâncias reais. Casiah reserva todos os direitos para interpretar o programa e seus efeitos.>"
  },
  Mail_21479_Name = {
    Text = "A Performance de Aniversário da Grande Mágica Casiah!"
  },
  Mail_21479_Sender = {Text = "Casiah"},
  Mail_21480_Desc = {
    Text = "Ei, hoje é meu aniversário. Onde está o meu presente?\nO quê? Você esqueceu de preparar um...? Hmph, eu sabia que isso aconteceria.\nAqui, leve este calendário. Ele marca claramente meu aniversário, meu dia de morte, o aniversário do primeiro dia que vim a Mythag, bem como o Festival da Alegria e o Festival da Colheita... Vamos celebrar todos juntos. Não esqueça da próxima vez!\n\nSe você esquecer novamente... acho que não posso fazer muito com você de qualquer forma, hmph.\nMas apenas não se esqueça, tá bem?\n\n- Agrippa"
  },
  Mail_21480_Name = {Text = "Ei..."},
  Mail_21480_Sender = {Text = "Agrippa"},
  Mail_21481_Desc = {
    Text = "Guardião:\n\nEu realmente não queria escrever esta carta, mas a Erica parece ter um problema; antes que eu terminasse, o alarme dela não parava de tocar.\nPara mim, o aniversário é uma data sem significado; a taxa de sucesso dos experimentos não é maior do que em outros dias, e meu índice gnóstico não muda por causa dessa data. Mas Ramona insistiu que este dia fosse meu \"dia de descanso\" e restringiu meu acesso ao laboratório hoje.\nNão tenho para onde ir; por isso, hoje irei revisar todos os seus relatórios passados.\nPor favor, venha ao arquivo depois do jantar. Atenção, não tente levar qualquer bolo para o arquivo, os documentos em papel são muito frágiles.\n\nBoneca"
  },
  Mail_21481_Name = {
    Text = "Após o jantar..."
  },
  Mail_21481_Sender = {Text = "Doll"},
  Mail_22435_Desc = {
    Text = "Caro Guardião:\nEscolhi inicialmente ler poesia na suave luz da manhã do campus porque percebi que havia menos transeuntes nesse horário, tornando mais fácil me imergir no mundo da poesia. Mais tarde, fui gradualmente me apaixonando pelo suave brilho matutino, as gotas de orvalho cristalinas e o melodioso canto dos pássaros.\nPara minha surpresa, muitos professores e alunos estavam me observando em silêncio e formaram um clube de poesia em segredo. Hoje é meu aniversário, coincidindo com a floração das flores de Nínfea no clube. Nessa ocasião, eles planejam organizar um encontro de apreciação de poesia onde poderemos desfrutar da paisagem e recitar poesia juntos no campus.\nEspero que você se junte a nós para esta experiência especial.\n\nNínfea"
  },
  Mail_22435_Name = {
    Text = "Convite para leitura de poesia"
  },
  Mail_22435_Sender = {Text = "Nymphaea"},
  Mail_23897_Desc = {
    Text = "Caro Guardião,\n        Na atualização V1.0.21, nós ajustamos as recompensas para \"Operação\" na dificuldade Difícil, os níveis de combate \"O Errante\" nas dificuldades Normal e Difícil, e as recompensas de primeira conquista para cada nível de Fissura I-IV no \"Reino Sem Luz\". Mudanças detalhadas podem ser encontradas no \"Aviso de Manutenção Online V1.0.21\".\n        Com base na sua investigação anterior e progresso de desafio, nós lhe concederemos as recompensas anteriormente não coletadas de acordo com os ajustes. Por favor, veja os anexos."
  },
  Mail_23897_Name = {
    Text = "V1.0.21 Compensação de Ajuste"
  },
  Mail_23897_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_24199_Desc = {
    Text = "Caro Guardião:\n        Na atualização V1.0.24, reabrimos o Capítulo 5 de \"Operação\", que foi temporariamente fechado na V1.0.16. Para garantir a justiça, emitiremos compensação com base nas mudanças nas recompensas e nos registros de investigação de cada Guardião. De acordo com seus registros, sua compensação foi enviada como anexo."
  },
  Mail_24199_Name = {
    Text = "V1.0.24 Compensação de Reabertura do Capítulo 5"
  },
  Mail_24199_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_24200_Desc = {
    Text = "Caro Guardião:\n        Na atualização V1.0.24, reabrimos o Capítulo 5 de \"Operação\", que foi temporariamente fechado na V1.0.16. Para garantir a justiça, emitiremos compensação com base nas mudanças nas recompensas e nos registros de investigação de cada Guardião. De acordo com seus registros, nenhuma compensação é necessária desta vez."
  },
  Mail_24200_Name = {
    Text = "V1.0.24 Compensação de Reabertura do Capítulo 5"
  },
  Mail_24200_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_24202_Desc = {
    Text = "Estimado Guardião: \n        Agradecemos seu apoio e reconhecimento a [Véspera do Esquecimento]. Para proporcionar uma melhor experiência de jogo aos guardiões na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como agradecimento pela sua colaboração, preparamos um Núcleo de prata × 200 como recompensa, que pode ser coletado após a conclusão do questionário. \n        <SurveyLink:[Clique aqui para preencher]>\n        Nós ouviremos atentamente as sugestões de cada Guardião, e seu feedback certamente fará com que a Universidade de Misag se torne cada vez melhor! \n        —— Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_24202_Name = {
    Text = "Pesquisa de Experiência da Versão V1.0"
  },
  Mail_24202_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_24280_Desc = {
    Text = "Olá, Guardião:\nVocê alcançou \"{s1} Rank\" na investigação do mergulho fantasmal de ontem, classificando-se como {s2}, com o título da investigação \"{s3}.\" Abaixo estão suas recompensas de classificação; por favor, lembre-se de recolhê-las."
  },
  Mail_24280_Name = {
    Text = "Recompensas Diárias de Classificação de Mergulho Fantasmal"
  },
  Mail_24280_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_24877_Desc = {
    Text = "Guardião,\n\nTodo aniversário meu foi o mais grandioso salão, repleto de convidados ilustres e celebrações alegres.\nMas desta vez, tenho uma ideia diferente—\nEstou sentado na cadeira do anfitrião há tempo demais. Ocasionalmente, quero experimentar ser um convidado.\nSeja outro salão requintado ou um simples jantar em família, você decide. O que você acha?\nNo entanto, se você escolher outro salão, não convide essas elites da alta sociedade.\nEm um dia tão raro e maravilhoso, não quero usar um sorriso falso.\n\n<Del:Senhora Vermelha> Sorel"
  },
  Mail_24877_Name = {
    Text = "Cabe a você..."
  },
  Mail_24877_Sender = {Text = "Sorel"},
  Mail_24878_Desc = {
    Text = "Mestre,\n\nHoje é o aniversário da Lily. Agrippa disse que queria \"fazer uma grande cena\".\nNo passado, mamãe e Lily celebravam aniversários de forma diferente. Mamãe colocava um chapéu pontudo em mim, e nós batíamos palmas e apagávamos as velas juntas.\nLily não sabe a maneira correta de celebrar. Por favor, dê suas ordens, Mestre.\n\nLily"
  },
  Mail_24878_Name = {
    Text = "Preocupado..."
  },
  Mail_24878_Sender = {Text = "Lily"},
  Mail_25147_Desc = {
    Text = "Caro Guardião,\n        Na atualização V1.1.0, as recompensas de pontos semanais do Mergulho Fantasmal foram substituídas por novos \"Testes Semanais\". Para ser justo, para aqueles que desbloquearam \"Mergulho Fantasmal\" mas não reivindicaram todas as recompensas de pontos semanais e fizeram login antes das 5:00 do dia 15 de janeiro, compensaremos com as recompensas de pontos semanais não reivindicadas. Por favor, verifique."
  },
  Mail_25147_Name = {
    Text = "V1.1.0 Compensação da Recompensa Semanal de Mergulho Fantasmal"
  },
  Mail_25147_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_25148_Desc = {
    Text = "Caro Guardião:\n        Na atualização V1.1.0, a \"Recompensa Semanal\" da Fase de Duelo (beta) foi removida e substituída pela \"Prova Semanal\", que tem o mesmo progresso e recompensas que a Prova Semanal do Mergulho Fantasmal. Em respeito ao princípio de equidade, compensaremos os Guardiões do segredo que desbloquearam anteriormente a \"Fase de Duelo (beta)\", mas não completaram ou não receberam a \"Recompensa Semanal\" desta semana, e que entraram no jogo antes das 5:00 do dia 15 de janeiro (UTC+8), com 1000 Pérolas de Erosão. Por favor, verifique."
  },
  Mail_25148_Name = {
    Text = "V1.1.0 Traphase Compensação de Recompensas Semanais"
  },
  Mail_25148_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_25414_Desc = {
    Text = "Caro Guardião, \n\nO significado de um aniversário varia para cada um. No entanto, o aniversário de um Guardião é de grande importância para todos em Mythag.\nA Sra. Sylvia preparou um jantar de aniversário para você na área do dormitório. O Reitor Czort e o Nobre Dexter estarão presentes. Sabendo que sua fadiga mental ainda não passou, preparei uma roupa formal para você, que está pendurada no guarda-roupa perto da porta. Você pode se trocar antes do evento.\nSinto-me honrado por ter passado este ano com você como seu parceiro e espero fazer isso novamente no próximo ano.\nQue a Chave Prata te guie.\n\nP.S. Um bolo personalizado foi entregue ao seu dormitório pela Erica.\n\nSempre seu parceiro, Ramona"
  },
  Mail_25414_Name = {
    Text = "Dia do Nascimento..."
  },
  Mail_25414_Sender = {Text = "Ramona"},
  Mail_34667_Desc = {
    Text = "Caro @1@2, \n\nO mundo esqueceu seu nome.\nPortanto, eu te despertarei, assim como você me despertou. Antes que a Chegada venha, caminhamos, testemunhamos, e então lembramos e esquecemos.\nHoje é o seu dia de nascimento, uma página dos Fragmentos dispersos da sua Memória. Aqui estão meus suspiros e bênçãos.\nO que você pensará quando o mundo recordar sua forma completa? Ou você ainda saberá e sentirá nada?\nAguardo sua resposta no lugar inexistente.\n\n@2"
  },
  Mail_34667_Name = {
    Text = "Dia do Nascimento..."
  },
  Mail_35231_Desc = {
    Text = "Estimado Guardião: \n        Agradecemos seu apoio e reconhecimento a [Véspera do Esquecimento]. Para proporcionar uma melhor experiência de jogo aos guardiões na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como agradecimento pela sua colaboração, preparamos um Núcleo de prata × 200 como recompensa, que pode ser coletado após a conclusão do questionário. \n        <SurveyLink:[Clique aqui para preencher]>\n        Nós ouviremos atentamente as sugestões de cada Guardião, e seu feedback certamente fará com que a Universidade de Misag se torne cada vez melhor! \n        —— Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_35231_Name = {
    Text = "Pesquisa de Experiência da Versão V1.1"
  },
  Mail_35231_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_35956_Desc = {
    Text = "Caro Guardião:\n        Agradecemos seu apoio e reconhecimento ao [Esquecimento]. Para proporcionar uma melhor experiência de jogo aos guardiões na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como forma de agradecimento pela sua colaboração, preparamos um Núcleo de prata × 200 como recompensa, que pode ser coletado ao completar o questionário. O prazo para preenchimento do questionário é até 22 de fevereiro às 5:00, por favor, atente-se para preenchê-lo a tempo.\n        <SurveyLink:[Clique aqui para preencher]>\n        Vamos ouvir atentamente as sugestões de cada Guardião, e seu feedback certamente fará a Universidade de Misag cada vez melhor!\n        — Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_35956_Name = {
    Text = "Pesquisa de Experiência da Versão V1.1"
  },
  Mail_35956_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_36228_Desc = {
    Text = "Caro Guardião do Segredo: \n        Agradecemos pelo seu apoio e reconhecimento a \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo aos guardiões na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como agradecimento pela sua colaboração, preparamos \"Núcleo de prata\" × 200 como recompensa, que pode ser coletado ao completar o questionário. O prazo para preenchimento do questionário é até 17 de junho às 9:00, por favor, preencha-o a tempo. \n        <SurveyLink:\"Clique aqui para preencher\"> \n        Vamos ouvir atentamente as sugestões de cada guardião, seu feedback certamente fará com que a Universidade de Misag melhore cada vez mais! \n        — Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_36228_Name = {
    Text = "Pesquisa de Experiência da Versão V1.4.1"
  },
  Mail_36228_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_36229_Desc = {
    Text = "Prezado Guardião do Segredo: \n        Agradecemos seu apoio e reconhecimento ao [Véspera do Esquecimento]. Para proporcionar uma melhor experiência de jogo para os Guardiões na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como forma de agradecimento pela sua colaboração, preparamos um Núcleo de Prata × 200 como recompensa, que pode ser coletado ao completar o questionário. O prazo para envio do questionário é até 08 de julho às 9:00, por favor, preencha-o a tempo. \n        <SurveyLink:[Clique aqui para preencher]>\n        Vamos ouvir atentamente as sugestões de cada Guardião do Segredo, e seu feedback certamente fará a Universidade de Misag cada vez melhor! \n        — Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_36229_Name = {
    Text = "Pesquisa de Experiência da Versão V1.4.3"
  },
  Mail_36229_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_36230_Desc = {
    Text = "Caro Guardião do Segredo: \n        Agradecemos pelo seu apoio e reconhecimento a \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo para os guardiões na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como forma de agradecimento pela sua colaboração, preparamos um prêmio de \"Núcleo de prata\" × 200, que poderá ser coletado ao completar o questionário. O prazo para preenchimento do questionário é até 2 de setembro às 9:00, por favor, preencha-o a tempo. \n        <SurveyLink:[Clique aqui para preencher]>\n        Vamos ouvir atentamente as sugestões de cada guardião do segredo, e seu feedback certamente fará com que a Universidade de Misag se torne cada vez melhor! \n        —— Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_36230_Name = {
    Text = "Pesquisa de Experiência da Versão V1.5.3"
  },
  Mail_36230_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_36231_Desc = {
    Text = "Prezado Guardião:\n        Agradecemos seu apoio e reconhecimento por \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo aos guardiões na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como agradecimento pela sua colaboração, preparamos \"Núcleo de prata\" × 200 como recompensa, que poderá ser coletado ao concluir o questionário. O prazo para o questionário é até 05 de agosto às 9:00, por favor, preencha a tempo.\n        <SurveyLink:[Clique aqui para preencher]>\n        Vamos ouvir atentamente as sugestões de cada Guardião, seu feedback certamente fará a Universidade de Misag cada vez melhor!\n        —— Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_36231_Name = {
    Text = "Pesquisa de Experiência da Versão V1.5.1"
  },
  Mail_36231_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_36232_Desc = {
    Text = "Caro Guardião: \n        Agradecemos seu apoio e reconhecimento em relação a \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo aos guardiões na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como forma de agradecimento pela sua colaboração, preparamos \"Núcleo de prata\" × 200 como recompensa, que poderá ser coletado ao completar o questionário. O prazo para preenchimento do questionário é até 18 de maio às 9:00, por favor, fique atento para preenchê-lo a tempo. \n        <SurveyLink:[Clique aqui para preencher]>\n        Vamos ouvir atentamente as sugestões de cada guardião do segredo, seu feedback certamente fará com que a Universidade de Misag se torne cada vez melhor! \n        — Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_36232_Name = {
    Text = "Pesquisa de Experiência da Versão V1.3"
  },
  Mail_36232_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_36233_Desc = {
    Text = "Prezado Guardião do Segredo: \n        Agradecemos seu apoio e reconhecimento a [Véspera do Esquecimento]. Para proporcionar uma melhor experiência de jogo aos guardiões na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como forma de agradecimento pela sua colaboração, preparamos um Núcleo de Prata × 200 como recompensa, que poderá ser coletado ao finalizar o questionário. O prazo para preenchimento do questionário é até 25 de abril às 9:00, por favor, preencha-o a tempo. \n        <SurveyLink:[Clique aqui para preencher]>\n        Estamos comprometidos em ouvir as sugestões de cada Guardião do Segredo, e seu feedback certamente fará com que a Universidade de Misag se torne cada vez melhor! \n        —— Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_36233_Name = {
    Text = "Pesquisa de Experiência da Versão V1.3"
  },
  Mail_36233_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_36234_Desc = {
    Text = "Caro Guardião do Segredo: \n        Agradecemos seu apoio e reconhecimento ao \"Esquecimento\". Para proporcionar uma melhor experiência de jogo aos guardiões na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como forma de agradecimento pela sua colaboração, preparamos um prêmio de \"Núcleo de prata\" × 200, que poderá ser coletado ao concluir o questionário. O prazo para preenchimento do questionário é até 14 de março às 5:00, por favor, preencha-o a tempo. \n        <SurveyLink:[Clique aqui para preencher]>\n        Iremos ouvir atentamente as sugestões de cada guardião, e seu feedback certamente tornará a Universidade de Misag cada vez melhor! \n        —— Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_36234_Name = {
    Text = "Pesquisa de Experiência da Versão V1.2"
  },
  Mail_36234_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_36235_Desc = {
    Text = "Prezados Guardiões do Segredo: \n        Agradecemos pelo seu apoio e reconhecimento a \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como agradecimento pela sua colaboração, preparamos \"Núcleo de prata\" × 200 como recompensa, que pode ser coletado ao finalizar o questionário. O prazo para preenchimento do questionário é até 4 de abril às 9:00, por favor, atente-se para preenchê-lo a tempo. \n        <SurveyLink:\"Clique aqui para preencher\"> \n        Nós ouviremos atentamente as sugestões de cada Guardião do Segredo, e seu feedback certamente fará com que a Universidade de Misag se torne cada vez melhor! \n        — Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_36235_Name = {
    Text = "Pesquisa de Experiência da Versão V1.2"
  },
  Mail_36235_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_36865_Desc = {
    Text = "Caro Guardião:\n        Na atualização V1.2.4, ajustamos as recompensas dos Ensaios Semanais \"Mergulho Fantasmal\" e não forneceremos mais recompensas de \"Jóias d\", \"Jóias d Miméticas\" e \"Rosa Dourada\". No espírito de justiça, compensaremos os Guardiões que desbloquearam \"Mergulho Fantasmal\" antes da atualização, mas não reivindicaram completamente as recompensas do ensaio desta semana, com as \"Jóias d\", \"Jóias d Miméticas\" e \"Rosa Dourada\" originais não reivindicadas do ensaio desta semana, desde que façam login no jogo antes de 11 de março, às 5:00. Por favor, verifique suas recompensas."
  },
  Mail_36865_Name = {
    Text = "Compensação de Ajuste de Recompensa de Julgamento Semanal V1.2.4"
  },
  Mail_36865_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_36866_Desc = {
    Text = "Caro Guardião:\n        Na atualização V1.2.4, completar os \"Sangue e Areia,\" \"Núcleo Retorcido\" e \"Desejo do Cavaleiro\" vagantes no modo Normal desbloqueou novos Bandos: \"Sangue e Areia Uivante,\" \"Eternidade Efêmera,\" e \"Último Juramento.\" Para os Guardiões que completaram os capítulos acima no modo Normal antes da atualização, emitiremos o Bando correspondente como compensação. Por favor, verifique suas recompensas."
  },
  Mail_36866_Name = {
    Text = "V1.2.4 Reedição do Bando Errante"
  },
  Mail_36866_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_36867_Desc = {
    Text = "Caro Guardião:\n        Na atualização V1.2.4, a quantidade de materiais de upgrade de habilidade únicos e Jóias d que caíram de \"Existência Transcendente\" aumentou. No espírito de justiça, para os Guardiões que reivindicaram as recompensas de \"Existência Transcendente\" desta semana antes da atualização, emitiremos Jóias d equivalentes ao valor dos drops aumentados com base no nível recomendado das recompensas que receberam. Por favor, verifique suas recompensas."
  },
  Mail_36867_Name = {
    Text = "Compensação de Ajuste de Recompensa de Existência Transcendente V1.2.4"
  },
  Mail_36867_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_36871_Desc = {
    Text = "Caros Guardiões:\n Com base na dificuldade mais alta concluída em \"Mergulho Fantasmal\" ontem, vocês receberão as seguintes recompensas. Por favor, lembrem-se de verificar seu inventário."
  },
  Mail_36871_Name = {
    Text = "Recompensas Diárias de Ilusão"
  },
  Mail_36871_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_39293_Desc = {
    Text = "Caro Guardião:\n        Na atualização V1.2.7, completar o mergulho de consciência \"Canção Escultural\", \"Descendente Pálido\" e \"Um Passo Longe\" no modo Normal desbloqueou um novo Bando: \"Abraço de Osso\", \"Vislumbre à Beira do Lago\" e \"Atravessando a Porta da Retrospectiva\". Para os Guardiões que completaram os capítulos acima no modo Normal antes da atualização, emitiremos o Bando correspondente como compensação. Por favor, verifique suas recompensas."
  },
  Mail_39293_Name = {
    Text = "V1.2.7 Reedição do Bando Errante"
  },
  Mail_39293_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_39548_Desc = {
    Text = "Caro Guardião:\n\nPara a vida eterna, celebrar um aniversário parece desnecessário. Comparado ao interminável rio do tempo, as memórias que vocês humanos chamam de inesquecíveis ou maravilhosas parecem... triviais. \nNo entanto, você inventou incontáveis festivais e comemorações para relembrar esses momentos \"triviais\"—claro, essa também é uma das razões pelas quais você desperta meu interesse. Você é realmente bastante adorável.\nNo entanto, encontrar-me com você claramente não pode ser contado entre aqueles momentos \"triviais\", pois você é diferente deles... E que tipo de tempestade essa \"diferença\" desencadeará no futuro, eu realmente aguardo ansiosamente.\nBem, por favor, perdoe meu devaneio... Já que hoje é meu aniversário, eu peço para exercer os \"Direitos da Estrela do Aniversário.\" \nQuanto ao que eu preciso que você faça, shh... não fique ansioso, a resposta está no meu quarto, por favor, vá lá sozinho à meia-noite desta noite.\n\nWanda"
  },
  Mail_39548_Name = {
    Text = "Os Direitos da Estrela de Aniversário..."
  },
  Mail_39548_Sender = {Text = "Wanda"},
  Mail_39549_Desc = {
    Text = "Hoje é o aniversário do Senhor Murphy—aniversários devem ser comemorados com um banquete e celebração! \nO pessoal do departamento de logística se saiu bem, mas realmente não sabe como fazer um espetáculo e tem tentado esconder as coisas—a Senhorita já os viu colocando decorações de bolo no armazém do Departamento de Despertar há muito tempo. Hmm... você não vai punir esses funcionários, vai? Eles realmente fizeram um ótimo trabalho; eles apenas não esconderam a surpresa bem o suficiente...\nVou parar por aqui; parece que alguém está me procurando lá fora—é melhor não tentarem me cobrir com papel colorido bobo.\nA propósito, você estará por aqui quando cortarmos o bolo, certo?\n\nMurphy"
  },
  Mail_39549_Name = {
    Text = "Banquete de Aniversário..."
  },
  Mail_39549_Sender = {Text = "Murphy"},
  Mail_43571_Desc = {
    Text = "Prezado Guardião: \n        Na atualização V1.2.10, as missões do evento [Viagem pela Cidade Neblinosa] [Completar o Capítulo 1 da linha principal da investigação \"Segredos do Leste\" na dificuldade difícil] e [Completar o Capítulo 2 da linha principal da investigação \"Em nome das estátuas de cera\" na dificuldade difícil] tiveram a recompensa adicionada: [Núcleo de prata] × 1000. Para os Guardiões do segredo que já receberam as recompensas das missões acima antes da atualização, iremos enviar o correspondente núcleo de prata. Por favor, verifique."
  },
  Mail_43571_Name = {
    Text = "V1.2.10 Recompensas para a Jornada na Cidade Nebulosa Reemitidas"
  },
  Mail_43571_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_43821_Desc = {
    Text = "Caro Guardião:\n        Na atualização V1.3.0, as etapas do \"Relatório de Missão\" 1/2/3/4/5/6 adicionaram recompensas de Experiência do Guardião 500/1000/1500/2000/2500/3000, respectivamente. Para Guardiões que já haviam reivindicado as recompensas para as etapas acima antes da atualização, iremos emitir a experiência correspondente como compensação. Por favor, verifique suas recompensas."
  },
  Mail_43821_Name = {
    Text = "Reemissão de Experiência de Relatório de Missão V1.3.0"
  },
  Mail_43821_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_44571_Desc = {
    Text = "Caro guardião:\nA atividade [Pastor das Almas] encerrará no dia 18 de abril às 9h[GMT+8]. Após o término da atividade, as portas correspondentes serão fechadas, incluindo o Caminho da Igreja e a Venda da Igreja, e os vouchers não utilizados desaparecerão automaticamente. Lembre-se de adquirir produtos na Venda da Igreja antes que a atividade termine"
  },
  Mail_44571_Name = {
    Text = "O evento do Pastor da Alma está chegando ao fim"
  },
  Mail_44571_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_44690_Desc = {
    Text = "Olá, Guardião:\nVocê realizou trabalho de campo durante a mergulho fantasmal de ontem com o título de investigação \"{s1}\". Abaixo estão suas recompensas de ranking; por favor, lembre-se de coletá-las."
  },
  Mail_44690_Name = {
    Text = "Recompensas de Classificação da Agência de Mergulho Fantasmal"
  },
  Mail_44690_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_44831_Desc = {
    Text = "Caro Guardião:\n        Na atualização V1.3.0, completar os Registros das Operações Especiais \"Fantasma da Cidade da Chuva\", \"Louvor da Rosa\" e \"Magia da História\" no modo Normal desbloqueou um novo Bando: \"Verdadeira Forma da Névoa Cinza\", \"Vitória da Rosa\" e \"Sonho de Midsummer\". Para os Guardiões que completaram os capítulos acima no modo Normal antes da atualização, emitiremos o Bando correspondente como compensação. Por favor, verifique suas recompensas."
  },
  Mail_44831_Name = {
    Text = "Reemissão de Registro de Tarefa de Grupo V1.3.0"
  },
  Mail_44831_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_44836_Desc = {
    Text = "Prezado Guardião do Segredo:\n        Na atualização V1.3.0, aumentamos as recompensas para 1 vitória e 3 vitórias nos desafios semanais de \"Mergulho Fantasmal\": \"Credencial de agente\" ×1. Para os Guardiões que já coletaram essas recompensas antes da atualização, enviaremos a quantidade correspondente de \"Credencial de agente\". Por favor, verifique."
  },
  Mail_44836_Name = {
    Text = "Redistribuição de Recompensas de Julgamento Semanal V1.3.0"
  },
  Mail_44836_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_44837_Desc = {
    Text = "O Honroso Mensageiro Pálido:\n\nAlgumas crianças me trouxeram flores e doces hoje, o que me lembrou que hoje, há mais de cem anos antes da Era dos Calendários de Inundações, eu recebi a graça do Pai Deus e vim a este mundo. Há quanto tempo isso foi! As memórias da infância há muito se apagaram; apenas o aroma do incenso da Igreja Bendoza permanece em minha mente, recusando-se a dissipar. E agora, mesmo que a igreja ainda exista, a receita do incenso não é mais a mesma de antes.\n\nPeço desculpas; a melancolia não é o propósito da minha carta. Preparei um momento para um chá com os doces que as crianças trouxeram, esperando que você pudesse vir e compartilhá-lo comigo—não para celebrar meu aniversário, mas para celebrar cada dia de existência, para honrar a presença da vida a cada dia.\n\nMe pergunto quando é o seu aniversário? Por favor, não se esqueça de me contar depois de uma xícara de chá.\n\n\n\nSalvador"
  },
  Mail_44837_Name = {
    Text = "Mensageiro Pálido..."
  },
  Mail_44837_Sender = {Text = "Salvador"},
  Mail_44843_Desc = {
    Text = "Prezado Guardião,\n Na atualização V1.3.0, removemos o privilégio do \"Tema principal\" que concedia o dobro de Experiência do Guardião de Segredos no \"Mergulho Fantasmal\" e na \"Fase de Duelo (beta)\". Como pedido de desculpas, forneceremos uma compensação diária de 240 de Experiência do Guardião de Segredos para aqueles que adquiriram o \"Tema principal\" atual até o final do Registro de temas deste período. Verifique suas recompensas."
  },
  Mail_44843_Name = {
    Text = "Reemissão das Recompensas do Tópico Principal para V1.3.0"
  },
  Mail_44843_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_47305_Desc = {
    Text = "Caro Guardião:\nNa Mergulho Fantasmagórico de ontem, sua maior dificuldade superada foi \"{s1}\".\nNa Traphase de ontem, você ganhou o título de \"{s2}\", sem vitórias nas partidas.\nCom base nesses resultados de desafio, você receberá as seguintes recompensas de jóia d. Por favor, lembre-se de verificá-las."
  },
  Mail_47305_Name = {
    Text = "Recompensa do D-Jóia de Mergulho Profundo"
  },
  Mail_47305_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_47306_Desc = {
    Text = "Prezado guardião:  \nNo Mergulho Fantasmal de ontem, você recebeu o título \" {s1} \".  \nNa Traphase de ontem, você recebeu o título \" {s2} \", sem nenhuma vitória.  \nCom base nesses resultados, você receberá as seguintes recompensas adicionais, por favor, lembre-se de coletá-las."
  },
  Mail_47306_Name = {
    Text = "Duelo de Imersão Profunda - Recompensa Extra"
  },
  Mail_47306_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_47307_Desc = {
    Text = "Prezado guardião:\nNo Mergulho Fantasmal de ontem, você recebeu o título \" {s1} \".\nNa Traphase de ontem, você recebeu o título \" {s2} \" e obteve vitórias.\nCom base nesses resultados, você receberá as seguintes recompensas adicionais, por favor, não se esqueça de verificá-las."
  },
  Mail_47307_Name = {
    Text = "Duelo de Imersão Profunda - Recompensa Extra"
  },
  Mail_47307_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_47308_Desc = {
    Text = "Caro Guardião:\nNa Mergulho Fantasmagórico de ontem, sua maior dificuldade superada foi \"{s1}\".\nNa Traphase de ontem, você ganhou o título de \"{s2}\" e obteve vitórias.\nCom base nesses resultados de desafio, você receberá as seguintes recompensas de jóia d. Por favor, lembre-se de verificá-las."
  },
  Mail_47308_Name = {
    Text = "Recompensa do D-Jóia de Mergulho Profundo"
  },
  Mail_47308_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_48005_Desc = {
    Text = "Caro Guardião:\n\nPeço desculpas por te perturbar, e espero que minha terrível caligrafia não arruíne seu bom humor—eu realmente não sou bom em escrever...\nEstou escrevendo esta carta para te informar que parece que meu aniversário chegou. Eu fiz alguns biscoitos pequenos para a ocasião, e espero que você os experimente.\nPara ser honesto, não tenho certeza se essa data está correta. Desde que fui infectado pela Dissolução, vestígios da minha existência estão desaparecendo aos poucos. A Srta. Boneca uma vez me perguntou como é ver a mim mesmo sendo esquecido por todos.\nÉ difícil de descrever... É como estar em uma escuridão completa à beira de um rio luminoso. Do outro lado, as pessoas conversam, ocupadas com suas próprias atividades, passando por mim enquanto eu só posso observar, incapaz de emitir um som.\nÉ uma sensação solitária. Felizmente, você não está entre essas pessoas.\nPelo menos você se lembra da minha história, não se lembra?\n\nP.S., doze pequenos biscoitos estão anexados a esta carta.\n\nMason"
  },
  Mail_48005_Name = {
    Text = "Desculpe por perturbar..."
  },
  Mail_48005_Sender = {Text = "\"24\""},
  Mail_48145_Desc = {
    Text = "Caro Guardião:\nO evento \"Cura Múltipla\" terminou. Recuperaremos a moeda de evento restante \"Quebra-cabeça de Memória\" de acordo com a taxa de câmbio ilimitada de \"Análise de Personalidade\". Lembre-se de verificar suas recompensas."
  },
  Mail_48145_Name = {
    Text = "Recuperação de Quebra-Cabeça de Memória"
  },
  Mail_48145_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_48156_Desc = {
    Text = "Guardião Respeitado:\nNo Mergulho Fantasmal de ontem, você obteve o título \"{s1}\".\nNo Traphase de ontem, você não teve vitórias.\nCom base nesses resultados de desafio, você receberá as seguintes recompensas adicionais. Por favor, verifique-as."
  },
  Mail_48156_Name = {
    Text = "Duelo de Imersão Profunda - Recompensa Extra"
  },
  Mail_48156_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_48157_Desc = {
    Text = "Caro Guardião:\nNa Mergulho Fantasmagórico de ontem, sua maior dificuldade superada foi \"{s1}\".\nNa Traphase de ontem, você não teve vitórias.\nCom base nesses resultados de desafio, você receberá as seguintes recompensas de jóia d. Por favor, lembre-se de verificá-las."
  },
  Mail_48157_Name = {
    Text = "Recompensa do D-Jóia de Mergulho Profundo"
  },
  Mail_48157_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_48914_Desc = {
    Text = "Prezado Guardião:\n        Agradecemos pelo seu apoio e reconhecimento a \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo aos Guardiões do segredo na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como agradecimento pela sua colaboração, preparamos \"Núcleo de prata\" × 200 como recompensa, que pode ser coletado após a conclusão do questionário. O prazo para envio do questionário é até 28 de outubro às 9:00, por favor, preencha dentro do prazo.\n        <SurveyLink:[Clique aqui para preencher]>\n        Vamos ouvir atentamente as sugestões de cada Guardião, seu feedback com certeza fará a Universidade de Misag cada vez melhor!\n        ——Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_48914_Name = {
    Text = "Pesquisa de Experiência da Versão V1.6.3"
  },
  Mail_48914_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_48915_Desc = {
    Text = "Caro Guardião: \n        Agradecemos pelo seu apoio e reconhecimento ao \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo aos guardiões na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como forma de agradecimento pela sua colaboração, preparamos \"Núcleo de prata\" × 200 como recompensa, que poderá ser coletado ao completar o questionário. O prazo para preenchimento do questionário é até 30 de setembro às 9h00, por favor, preencha-o a tempo. \n        <SurveyLink:[Clique aqui para preencher]>\n        Iremos ouvir atentamente as sugestões de cada guardião; seu feedback certamente fará com que a Universidade de Misag melhore cada vez mais! \n        — Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_48915_Name = {
    Text = "Pesquisa de Experiência da Versão V1.6.1"
  },
  Mail_48915_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_49931_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"Ondas de Desejo\" foi concluída, agora converteremos os \"Núcleos de Fertilidade\" restantes do guardião na proporção de 20 \"Cupons de ouro rosa\" por cada unidade. Por favor, lembre-se de verificar."
  },
  Mail_49931_Name = {
    Text = "A Recuperação da Semente Mãe"
  },
  Mail_49931_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_50344_Desc = {
    Text = "Pequena Muda:\n\nO vento carrega seu perfume – está mais doce do que quando nos conhecemos.\nVocê cresceu em meu amor, nutrido até a maturidade... como abelhas e mel.\nHoje é um dia especial. Você virá me ver?\nEu esperei pacientemente por muito tempo, assim como você pediu... Não é hora de uma recompensa?\n\nThais"
  },
  Mail_50344_Name = {
    Text = "Doce como mel..."
  },
  Mail_50344_Sender = {Text = "Thais"},
  Mail_51376_Desc = {
    Text = "Caro Guardião:\nA atividade \"Mágica da Story\" foi encerrada. Converteremos as \"Inspiração Errante\" restantes do guardião na proporção de \"Cupom de ouro rosa*60\" por cada unidade. Por favor, verifique."
  },
  Mail_51376_Name = {
    Text = "Recuperação de Inspiração Flutuante"
  },
  Mail_51376_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_51777_Desc = {
    Text = "Caro Guardião:\n\"A Magia da História·clon\" atividade foi concluída, e agora as \"Inspirações Errantes\" restantes do Guardião serão convertidas na proporção de cada unidade trocada por um \"Cupom de ouro rosa\" × 25. Por favor, lembre-se de verificar."
  },
  Mail_51777_Name = {
    Text = "Recuperação de Inspiração Flutuante"
  },
  Mail_51777_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_53149_Desc = {
    Text = "\nEu decidi há muito dedicar cada dia da minha vida restante a isso... como uma forma de expiação por minhas ações tolas.\nO \"aniversário\" do meu eu superficial é irrelevante, mal vale a pena mencionar.\nHoje não é diferente de qualquer outro dia no passado ou no futuro; irei à capela como sempre.\nNo entanto, se você deseja que eu saia da capela hoje como convidado de Mythag, certamente não irei desobedecer a vontade do mestre.\nSe você quiser testemunhar minha oração, você é sempre bem-vindo... com todo o respeito, você é muito bem-vindo.\n\nMiryam"
  },
  Mail_53149_Name = {
    Text = "Um Dia de Cultivo..."
  },
  Mail_53149_Sender = {Text = "Miryam"},
  Mail_53151_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"Cerimônia do Abismo\" foi concluída, agora converteremos as \"Lágrimas do Sacerdote\", \"Sangue do adorador\" e \"Medula do Sacrificador\" restantes do guardião na proporção de 2500 \"Cupom de ouro rosa\" para cada 100 unidades. Por favor, lembre-se de verificar."
  },
  Mail_53151_Name = {
    Text = "Recuperação da moeda de evento do Sacrifício do Abismo"
  },
  Mail_53151_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_53152_Desc = {
    Text = "Prezado Guardião do Segredo: \n O evento \"Pastor da Alma\" foi encerrado. Os \"Bônus de venda beneficente\" restantes foram convertidos na proporção de 5000 \"Cupom de ouro rosa\" a cada 120 unidades. Lembre-se de verificar."
  },
  Mail_53152_Name = {
    Text = "Coleta de Vouchers de Caridade"
  },
  Mail_53152_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_53153_Desc = {
    Text = "Prezado Guardião do Segredo:\nO evento \"Festa Ardente\" terminou. Os \"Tíbias Primitivas\", \"Amonites de Folha Redonda\" e \"Ruínas Espirais\" restantes foram trocados por \"Selos de mil faces\" × 1 a cada 80 unidades. Por favor, Lembre-se de verificar."
  },
  Mail_53153_Name = {
    Text = "Recuperação de Moeda do Evento do Banquete Ardente"
  },
  Mail_53153_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_53869_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"Com o livro da rosa\" foi concluída, agora converteremos os \"Leques de Penas do Espírito Avestruz\" restantes do guardião na proporção de 50 \"Cupons de ouro rosa\" por unidade. Por favor, verifique."
  },
  Mail_53869_Name = {
    Text = "Reciclar Leque de Pena de Espiritismo"
  },
  Mail_53869_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_54803_Desc = {
    Text = "Prezado Guardião do Segredo:\n        Na atualização V1.5.1, aumentamos as recompensas de \"Núcleo de prata\" para os níveis 21-80 do \"Registro de Crescimento\" e adicionamos uma recompensa de \"Medalha de Investigação\" × 1000 para a conclusão de tarefas nas fases I~V do \"Domínio de Área\". Para os Guardiões que já coletaram todas as recompensas acima antes da atualização, enviaremos as recompensas correspondentes de \"Núcleo de prata\" ou \"Medalha de Investigação\". Por favor, verifique."
  },
  Mail_54803_Name = {
    Text = "V1.5.1 Suplemento de Recompensa Manual"
  },
  Mail_54803_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_55168_Desc = {
    Text = "Prezado Guardião:\n A atividade \"Antes que a primavera murche\" foi concluída. Agora, os \"Poesia Alegre\", \"poesia melancólica\" e \"Poema de Arrependimento\" restantes do Guardião serão convertidos na proporção de 5000 \"Cupom de ouro rosa\" para cada 200. Por favor, verifique."
  },
  Mail_55168_Name = {
    Text = "Reaproveitamento de poemas"
  },
  Mail_55168_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_56101_Desc = {
    Text = "Guardião {Male=senhor,Female=senhora}:\n\nHoje de madrugada, uma rosa floresceu ao som dos pássaros na primavera.\nEla deveria ser um galho em botão da primavera, mas no Dia de São Valentim, no dia do meu nascimento, floresceu em uma estação que não pertence a ela.\nEu me lembrei do cité. Em cada aniversário, as ruas do cité sempre ficam movimentadas. Eu ouço o som das flores abertas, ouço os sussurros apaixonados das pessoas. Mas faz muito tempo que não tenho a oportunidade de tocá-las... até hoje.\nVocê acredita em coincidência, Guardião? Eu penso que coincidência é uma linguagem, e a rosa é uma retórica. Hoje, no jardim exuberante de mythag, esta rosa floresce, suas pétalas se abrem generosamente, como um poema hipnotizante.\nEntão, hoje, Guardião... você aceitaria vir comigo ver a floração desta rosa?\nEu e a flor, estamos ansiosos pela sua chegada.\n\nHorla"
  },
  Mail_56101_Name = {
    Text = "Uma rosa floresce na primavera..."
  },
  Mail_56101_Sender = {Text = "Horla"},
  Mail_57328_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"As estrelas estão em posição\" foi encerrada, agora converteremos os \"Embriões Ignorantes\", \"Embriões sem desejo\" e \"Embrião Insaciável\" restantes do guardião na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Por favor, verifique."
  },
  Mail_57328_Name = {
    Text = "Recuperação de Embrião"
  },
  Mail_57328_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_57414_Desc = {
    Text = "Caro guardião: \n A atividade \"Manual do Detetive\" foi concluída, agora converteremos as \"Fichas de Decisão\" restantes do guardião na proporção de 40 \"Cupons de ouro rosa\" por cada unidade. Por favor, verifique."
  },
  Mail_57414_Name = {
    Text = "Recuperação de Chip"
  },
  Mail_57414_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_58253_Desc = {
    Text = "Prezado Guardião do Segredo:\nO evento \"Pastor da Alma·clon\" terminou. Os \"Bônus de venda beneficente\" restantes serão trocados na proporção de 5000 \"Cupom de ouro rosa\" para cada 200 unidades. Por favor, Lembre-se de verificar."
  },
  Mail_58253_Name = {
    Text = "Coleta de Vouchers de Caridade"
  },
  Mail_58253_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_58690_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"Sinfonia Imaterial\" foi concluída, agora converteremos os \"Canto heroico\" restantes do guardião na proporção de 40 \"Cupons de ouro rosa\" por cada unidade. Por favor, verifique."
  },
  Mail_58690_Name = {
    Text = "Melodia aguda recuperada"
  },
  Mail_58690_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_61154_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"Festa Ardente·clon\" foi encerrada. Agora, converteremos os \"Os Tibia original\", \"Amónito de folhas arredondadas\" e \"Ruínas Espirais\" restantes do guardião na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Por favor, lembre-se de verificar."
  },
  Mail_61154_Name = {
    Text = "Reciclagem de Moeda do Banquete Ardente"
  },
  Mail_61154_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_61155_Desc = {
    Text = "Caro Guardião:\n\"Cura Múltipla·Réplicar\" a atividade de replicação foi concluída, agora os \"puzzles de memória\" restantes do Guardião serão recuperados na proporção de cada um trocado por \"Cupom de ouro rosa\" × 40, por favor, lembre-se de verificar."
  },
  Mail_61155_Name = {
    Text = "Recuperação de Quebra-Cabeça de Memória"
  },
  Mail_61155_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_62392_Desc = {
    Text = "Keeper:\n\nMinha música uma vez serviu diante de imperadores e foi admirada por incontáveis pessoas. No entanto, esses elogios não têm valor para mim; o que busco é a essência suprema da música.\nComparado a tocar em locais grandiosos e luxuosos, tocar sozinho em uma floresta tranquila me traz mais paz.\nEu nunca quis que ninguém ouvisse minhas sessões de prática; eram meros rascunhos, fragmentos sem sentido.\nMas desde que conheci você e o encontrei, toda a minha música ganhou significado.\nVocê me deu a música mais magnífica e nobre, me resgatando da minha confusão, mesmo que você não estivesse ciente disso...\nHoje é meu aniversário, que eu havia esquecido há muito tempo. Mas agora, desejo comemorar meu renascimento e aquele que o concedeu.\nCoincidentemente, recentemente compus uma nova peça e gostaria de convidá-lo para ouvi-la. Por favor, perdoe minha demora; minha identidade atual não me permite aparecer diante dos meus colegas Mythag, então só posso enviar este convite após o pôr do sol.\nEsta noite, na floresta atrás da escola, farei um concerto especial com apenas um membro da audiência.\nAguardo ansiosamente sua presença.\n\nHameln"
  },
  Mail_62392_Name = {
    Text = "Concerto Secreto..."
  },
  Mail_62392_Sender = {Text = "Hameln"},
  Mail_65350_Desc = {
    Text = "Caro guardião do segredo: \n A atividade \"Quando a montanha de neve derrete\" foi concluída, agora recuperaremos a moeda de atividade restante do guardião \"Brotinho congelado\", \"Brotinho de prata com geada\" e \"Botão de sol\" na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Por favor, lembre-se de verificar."
  },
  Mail_65350_Name = {
    Text = "Recuperação de Broto"
  },
  Mail_65350_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_65441_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"Cerimônia do Abismo·clon\" foi concluída, agora converteremos as \"Lágrimas do Sacerdote\", \"Sangue do adorador\" e \"Medula do Sacrificador\" restantes do guardião na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Lembre-se de verificar."
  },
  Mail_65441_Name = {
    Text = "Recuperação da moeda de evento do Sacrifício do Abismo"
  },
  Mail_65441_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_65442_Desc = {
    Text = "Caro Guardião:\n\"Porta dos Mil Fenômenos\" atividade foi concluída, agora os pontos de atividade restantes do Guardião \"Ponteiro final\" serão recuperados na proporção de cada um trocado por \"Cupom de ouro rosa\" × 40. Por favor, lembre-se de verificar."
  },
  Mail_65442_Name = {
    Text = "Reciclagem do Ponto Final"
  },
  Mail_65442_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_67147_Desc = {
    Text = "Keeper: \n\n As dimensões do universo não são singulares para mim; os Portões do Esquecimento permitem uma visão de inúmeros mundos e existências infinitas. Isso transcende todas as maravilhas e a lógica matemática, tornando impossível definir a data do \"Nascimento.\" \n Portanto, consideremos nosso encontro inicial como esse momento. Na escala do continuum temporal que você habita, uma cerimônia exclusiva para mim deve ser realizada hoje, cumprindo o desejo que fiz. \n Então, vamos atravessar o limiar da Chave Prata e vir ao meu lado. Eu irei lhe transmitir... algum conhecimento sobre o Gênesis supremo pertencente ao universo. Esta noite, inúmeros corpos celestes brilharão para você e para mim. \n Aguardo você nos Portões do Esquecimento. \n\nTawil"
  },
  Mail_67147_Name = {
    Text = "Atravesse a Porta de Prata..."
  },
  Mail_67147_Sender = {Text = "Tawil"},
  Mail_67933_Desc = {
    Text = "Senti sua breve confusão—como alguém poderia esperar prejudicar a suprema Relíquia apenas com um olhar? Mas você fez isso.\nOutro olhar colapsa, a armadura apresenta arranhões e brechas sob os Fragmentos implacáveis.\n%player%, apenas sua vontade inflexível é verdadeiramente indestrutível."
  },
  Mail_67933_Name = {
    Text = "Encontre uma saída da confusão"
  },
  Mail_67933_Sender = {Text = "Alistair"},
  Mail_67934_Desc = {
    Text = "Seus membros tremem, %player%. Você mal consegue ficar em pé. O medo o domina, deixando sua mente em branco e tornando impossível controlar sua respiração... mas você ainda levanta a chave de prata à frente.\nEntre todas as virtudes humanas, a coragem é a mais nobre. Enfrentando desastres e feras, nós já levantamos martelos e lanças. Agora, diante de deuses, você faz o mesmo.\nA civilização humana foi construída sobre a coragem e perdurará através dela."
  },
  Mail_67934_Name = {
    Text = "O hino da coragem ressoa em meio aos tremores"
  },
  Mail_67934_Sender = {Text = "Alistair"},
  Mail_67935_Desc = {
    Text = "Uma vez falamos deste mundo; você disse que não gostava dele. Ele está repleto de interesses, conspirações, enganos e massacre. Mesmo sem Dissolução ou Deuses, já está desgastado e à beira do colapso. Após despertar de Akut, dentro de sua Memória fugaz, você testemunhou desordens e horrores inúmeros, muito piores que a Dissolução.\nNo entanto, quando o Criador levantou Sua lâmina, você ainda permaneceu diante deste mundo para protegê-lo. A Aniquilação era a vontade dos Deuses, mas você desafiou isso.\nEu entendo, %player%. Nenhum Guardião odeia este mundo, nem qualquer Guardião realmente o ama. Pois em meio à sujeira, vislumbramos fagulhas que brilham como Prata.\nO dever de um Guardião é eternamente proteger aquelas poucas fagulhas."
  },
  Mail_67935_Name = {
    Text = "O espírito humano perdura para sempre."
  },
  Mail_67935_Sender = {Text = "Alistair"},
  Mail_67936_Desc = {
    Text = "A primeira vez que vi a Dissolução, a primeira vez que confrontei sua verdade, a primeira vez que percebi a voz de Deus... Ao longo da minha longa vida, suportei inúmeros momentos de desespero, sem saber o que fazer ou o significado de todo o esforço e sacrifício—no entanto, nenhum se compara ao que você enfrenta agora.\nEsta é a humanidade: frente ao desespero, nós renascemos e seguimos em frente.\nO fim do caminho pode ser um Abismo, mas sempre haverá aqueles que desejam vê-lo."
  },
  Mail_67936_Name = {
    Text = "Desespero, e então renascimento"
  },
  Mail_67936_Sender = {Text = "Alistair"},
  Mail_67937_Desc = {
    Text = "A barreira dimensional está aberta, e eu finalmente posso contatar você novamente.\nComparado ao que você viu, a visão nesta dimensão é excepcionalmente fraca, talvez porque você não esteja aqui. Depois de sacrificar quase tudo, eu lidei com Isso por você.\nNão consigo imaginar o que você está enfrentando. Mas, não importa o que aconteça, com a vontade de aniquilar, lutarei ao seu lado. Esta é a promessa de cada Mythag.\nEstou feliz em estar ao seu lado mais uma vez.\nQue a Chave Prata guie o caminho."
  },
  Mail_67937_Name = {
    Text = "Lutem lado a lado, mais uma vez"
  },
  Mail_67937_Sender = {
    Text = "Remetente Desconhecido"
  },
  Mail_67938_Desc = {
    Text = "Loucuras, um termo leve e até agradável.\nUm universo caótico deu origem a uma civilização caótica. O Caos é a verdade deste mundo. Abraçar o caos e desfrutar da loucura é algo fácil. Em contraste, manter-se consciente e resistir é tão difícil. Você sacrificará toda alegria e vida, apenas para perseguir uma resposta elusiva.\nAinda assim, você escolhe permanecer acordado, %player%. Pois não nascemos para ser escravos.\nVocê lhe mostrou, %player%—Sua relíquia, Seu fragmento, nunca estiveram dispostos a ser escravos cegamente tolos. Você O resiste, superando Seu olhar repetidamente, escolhendo proteger este mundo imperfeito e desajeitado.\nNesta escolha, você alcançou a liberdade eterna."
  },
  Mail_67938_Name = {
    Text = "Você nunca consentiria em ser um escravo cegamente tolo."
  },
  Mail_67938_Sender = {Text = "Alistair"},
  Mail_67939_Desc = {
    Text = "Eu senti um olhar desmoronar. Eu senti sua dor excruciante.\nEssa é a responsabilidade gravada no título de Guardião. O caminho que você escolheu é milhares de vezes mais difícil que o meu. Nem todos têm a coragem de enfrentar o supremo Deus; sua bravura me comove profundamente e me enche de admiração.\nNão posso imaginar a dor que o poder do Criador irá infligir a você. O que percebo é apenas uma fração minúscula do seu sofrimento. Eu sou uma pessoa inútil presa na Poça Negra, %player%. Não posso mais me juntar a você em sua batalha contra o Criador; só posso permanecer conectado a você através dos meus sentidos. Esta será minha missão final e mais importante na vida.\nNesta jornada solitária, quer você veja ou não, Mythag sempre estará ao seu lado."
  },
  Mail_67939_Name = {
    Text = "A tristeza não irá te quebrar."
  },
  Mail_67939_Sender = {Text = "Alistair"},
  Mail_67940_Desc = {
    Text = "Ouvi os sussurros da Vontade Suprema— a grandiosa civilização, a alegria e a dor humanas, as incontáveis pessoas ao seu redor e que te abandonam; nada disso realmente existiu.\nNos incontáveis dias e noites no Poço Negro, essa visão me encheu de terror. As árvores criam raízes no solo, crescem para cima para saudar o sol— a memória é nosso solo, a base a partir da qual crescemos, estamos e, em última análise, retornamos. Temo perder este solo, à deriva na ilusão, sem origem ou fim.\nObrigado, %player%. Acredito que testemunhei um grande duelo. Esta é uma batalha entre homem e deus, uma batalha de proteção contra destruição.\nEsta é uma batalha de lembrança contra o esquecimento.\nVocê conseguiu, %player%. Você realizou o que ninguém se atreveu a imaginar. Você extraiu um poder incomparável da memória e lutou pela sua preservação.\nNeste solo antigo, você encontrou seu sol."
  },
  Mail_67940_Name = {
    Text = "Lutem para Lembrar"
  },
  Mail_67940_Sender = {Text = "Alistair"},
  Mail_68825_Desc = {
    Text = "Caro Guardião:  \nA atividade \"Retorno do Poder Real\" foi encerrada. As moedas de atividade restantes do guardião — \"Pensamentos cansados\", \"Pensamentos melancólicos\" e \"Pensamentos alegres\" — serão convertidas em \"Cupom de ouro rosa*40\" na proporção de 1:1. Por favor, verifique."
  },
  Mail_68825_Name = {
    Text = "Recuperação de moeda do evento Reviver do Rei Divino"
  },
  Mail_68825_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_68826_Desc = {
    Text = "Caro guardião,\nA atividade \"Ondas de Desejo·clon\" foi encerrada. Os \"Núcleo de Fertilidade\" restantes serão convertidos em \"Cupom de ouro rosa * 40\" na proporção de 1:1. Por favor, lembre-se de verificar."
  },
  Mail_68826_Name = {
    Text = "A Recuperação da Semente Mãe"
  },
  Mail_68826_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_68898_Desc = {
    Text = "Querido mestre, acima de tudo:\n\nComo uma empregada doméstica versátil, Karen consegue lembrar-se de muitas datas importantes para os adultos, desde dias de banquetes, aniversários, datas comemorativas até o dia em que adotaram um animal de estimação, nunca cometendo nenhum erro. Porém, para a própria Karen, o único dia especial que ela pode comemorar é exatamente este dia.\nHá muito, muito tempo, quando Karen ainda era uma serviçal no palácio, pela primeira vez pedi ao cozinheiro um pouco da sobremesa que os nobres não tinham terminado para usá-la como bolo de aniversário, mas fui severamente repreendida. Aquele cozinheiro jogou o bolo na minha cara. Naquela época, eu pensei: Então assim é tão saboroso assim um bolo? Eu definitivamente encontrarei um mestre muito gentil comigo, que me deixe comer bolo todos os anos no meu aniversário.\nAgora eu tenho a senhora Sorel, extremamente elegante e generosa, e você, meu mestre extremamente bondoso. O desejo daquela época já se realizou! Mas as pessoas sempre ficam cada vez mais gananciosas... Ah, mas não, é progredir, claro. Meu desejo agora é poder ficar ao seu lado todos os anos no seu aniversário e, se possível, ganhar presentes brilhantes também.\nDepois de ouvir tudo isso, você certamente vai me preparar algo, não vai? Sim, vai, não vai?\n\nSua humilde serva para sempre\nKaren"
  },
  Mail_68898_Name = {
    Text = "Ano após ano, sempre assim..."
  },
  Mail_68898_Sender = {Text = "Karen"},
  Mail_68899_Desc = {
    Text = "Mudas: \n\nVer seu crescimento ao longo do tempo me fez acreditar cada vez mais que escolher você e ajudar você foi a decisão mais acertada que já tomei.\nSenti a alegria da colheita, e toda confiança e amor que cultivei me trouxeram recompensas doces. Foi você quem me deu esperança e futuro.\nAgora posso abandonar a obsessão pela reprodução e me concentrar em apreciar os frutos do amor além da própria reprodução.\nEste mundo não precisa mais da rainha de Aaran, mas talvez possa acolher o desejo de aniversário de uma mulher comum que deseja ter um companheiro ao seu lado.\nComo um casal comum faria, ir juntos comprar ingredientes, cozinhar pratos deliciosos, e talvez experimentar muitas outras coisas que nunca vivi antes. Querido, você poderia me guiar e passar comigo um aniversário acolhedor e tranquilo?\n\nTáias"
  },
  Mail_68899_Name = {
    Text = "Vida comum..."
  },
  Mail_68899_Sender = {Text = "Thais"},
  Mail_68900_Desc = {
    Text = "Guardião:\n\nA mestre Casiah é a mais extraordinária mestra de apresentação do mundo, capaz de imitar perfeitamente qualquer expressão facial, mas os sentimentos humanos são algo que, não importa o quanto se tente, permanecem como um enigma inexplicável.\nPerguntei a muitas e muitas pessoas, nenhuma delas conseguiu explicar claramente o princípio das emoções, até que perguntei à Dol. Ela me contou que existe no mundo uma disciplina chamada psicologia; mesmo sem sentir empatia, dominando psicologia é possível compreender todas as teorias por trás das emoções.\nIsso é realmente, extremamente fascinante! A dúvida que tanto atormentava Casiah finalmente será desvendada?\nAh, falando nisso, vim te avisar que vou participar da sua aula de psicologia desta semana, Casiah decidiu sentar-se ao seu lado como sua colega de carteira, e você vai me ajudar a recuperar o conteúdo que perdi antes, certo, colega~\nAh, sim, a propósito, hoje é meu aniversário, aqui eu deveria ficar feliz, e você também deveria ficar feliz, certo?\nSe for algo muito, muito divertido, vamos fazer uma grande bagunça na escola! Vou transformar o campus numa beleza deslumbrante, como um verdadeiro sonho!\n\nCasiah"
  },
  Mail_68900_Name = {
    Text = "Psicologia…"
  },
  Mail_68900_Sender = {Text = "Casiah"},
  Mail_68901_Desc = {
    Text = "Mensageiro Pálido respeitável: \n\nAgradeço pela sua ajuda e cuidado ao longo deste ano. O seu coração compassivo em relação aos outros é tão nobre quanto ensinado pelo Deus Pai. Mesmo que as nossas oportunidades de convivência não sejam frequentes, cada vez que nos encontramos é como rever um velho amigo de longa data, deixando-me com uma sensação tão agradável quanto uma brisa suave.\nEmbora o dia do seu aniversário em si não seja algo especial, ele serve como um motivo maravilhoso para nos encontrarmos. Além de você, não consigo imaginar outra pessoa com quem eu preferiria passar este dia.\nSe você estiver interessado, gostaria de convidá-lo a experimentar meu novo passatempo recente – pescaria. Claro que não é com o objetivo de cozinhar ou comer os peixes, mas sim apreciar simplesmente o processo tranquilo de esperar pacientemente por um presente mágico trazido pelo destino. Gostaria de compartilhar com você esta sensação serena, imersos na natureza, sentados calmamente à beira de um lago.\nUm velho amigo, duas varas de pesca – acredito que será um dia perfeito.\n\nSalvador"
  },
  Mail_68901_Name = {
    Text = "Um novo hobby de pesca..."
  },
  Mail_68901_Sender = {Text = "Salvador"},
  Mail_68902_Desc = {
    Text = "Senhor:\n\nNo meu aniversário deste ano, Agnes e Jenkin me deram um sino de vento de vidro muito parecido com Aurita.\nEu o pendurei na janela do quarto, e quando o vento sopra, ele emite sons agradáveis, me fazendo lembrar quando minha mãe me abraçava e me contava histórias perto da janela.\nNão se preocupe, senhor, embora eu sinta saudade da minha mãe todos os dias, com a companhia do senhor e de todos, Lily não se sentirá sozinha.\nAgora Lily aprendeu a ler livros de histórias sozinha, e todas as tardes, a luz laranja entra no quarto, iluminando o sino de vento e projetando ondas brilhantes nos livros de histórias, deixando o quarto todo aquecido.\nLily adora ficar distraída nesse momento, olhando para as nuvens ao pôr do sol e para o sino de vento, sentindo-se extremamente feliz e bela.\nSe o senhor tiver tempo hoje, venha experimentar ficar distraído junto com Lily.\n\nLily"
  },
  Mail_68902_Name = {
    Text = "Sino de vento de vidro…"
  },
  Mail_68902_Sender = {Text = "Lily"},
  Mail_68903_Desc = {
    Text = "Pequeno um: \n\nEmbora esta data especial tenha sido estabelecida em homenagem àquela pessoa humana, devo admitir que o Dia dos Descontos é uma estratégia de venda extremamente atraente tanto para clientes quanto para comerciantes.\nNa última vez, no meu aniversário, o número de pedidos na loja de alívio chegou quase ao total de vendas de meio ano normal, especialmente os itens promocionais especiais que eu coloquei como brindes comemorativos, todos esgotados. Devo dizer que os clientes de Mythag são muito gentis com meu negócio, ou será que até os investigadores mais espertos e cautelosos não resistem à tentação dos descontos?\nDe qualquer forma, para continuarmos compartilhando essa felicidade mutuamente vantajosa, este ano também realizarei novamente uma promoção especial de aniversário. Só acontece uma vez por ano, os descontos serão grandes, quem quiser comprar deve se apressar. Lembre-se de divulgar bem em Mythag por mim. Para facilitar a lembrança, vamos chamar este dia de Dia Duplo Dez. \nAh, ainda por cima, reservei algumas coisinhas interessantes especialmente para você. Certifique-se de vir me encontrar cedo.\n\nDafdell"
  },
  Mail_68903_Name = {
    Text = "Dia de desconto..."
  },
  Mail_68903_Sender = {Text = "Daffodil"},
  Mail_68904_Desc = {
    Text = "À fortuna benevolente, Guardião da Universidade Mythag, nobre e benevolente mestre: \nSalve! \nSe o maior desejo de cada cavaleiro é servir a um grande mestre, então minha vida como cavaleiro já é completa. \nEm minha vida, além da sorte, houve também muitas tragédias infelizes e sangue heroico. Sei que por isso muitos em Mythag já sentiram pena de mim. \nDeixando de lado uma mera comparação de sofrimentos, já há muitas pessoas infelizes em Mythag; num mundo repleto de desgraças, derramar até a última gota de sangue em defesa não é algo que deva causar tristeza. \nPelo contrário, tanto no passado quanto agora, sinto orgulho disso e estou sempre preparado para sacrificar este corpo. \nPorém, a senhora Roten disse que eu pareço cansado demais com minhas preocupações diárias, e me pediu para me divertir um pouco no meu aniversário, chamando até mesmo Jenkin para me ensinar a jogar, dizendo que isso me ajudaria a recuperar minha infância. \nÉ vergonhoso admitir, mas na minha juventude estava ocupado demais nos treinamentos para ter tempo de brincadeiras. Nunca imaginei que um jogo supostamente dominado por crianças de cinco anos pudesse ser tão difícil. Parece que ainda tenho muito a aprender fora do caminho dos cavaleiros. \n\nSe o mestre tiver tempo hoje, talvez possa vir se divertir conosco? Vejo que Jenkin já começou a se entediar depois de dez vitórias consecutivas; com o mestre aqui, certamente teríamos um jogo emocionante. \n\nOgier"
  },
  Mail_68904_Name = {
    Text = "Jogo difícil..."
  },
  Mail_68904_Sender = {Text = "Ogier"},
  Mail_68905_Desc = {
    Text = "Agora: \n\nCom aquele calendário, imagino que este ano você não tenha esquecido do aniversário do nobre mestre do labirinto.\nPermito que venha ao meu quarto entregar um presente e aproveite o dia para me servir com dedicação.\nCoisas como escovar os dentes, lavar o rosto, trocar de roupa, fazer refeições, e também aquelas tarefas como limpar o quarto e trocar os lençóis, como vocês dizem... faxina geral!\nIsso mesmo, todas essas tarefas de limpeza estão sob sua responsabilidade. Já estou farta desses afazeres domésticos. Hoje, de qualquer jeito, quero reviver os tempos em Roma e desfrutar novamente da vida em que tudo me é servido, sem precisar levantar um dedo.\nHoje, ninguém vai me fazer fazer um único trabalho, ninguém mesmo!\n\nAgrippa"
  },
  Mail_68905_Name = {
    Text = "Voltar ao passado..."
  },
  Mail_68905_Sender = {Text = "Agrippa"},
  Mail_68906_Desc = {
    Text = "Guardião:\n\nO tempo passa mesmo rápido. Nunca imaginei que um dia eu já nem me lembraria mais daquela vida que achei que duraria para sempre.\nHoje em dia, esta senhorita já conhece todos os bolinhos do refeitório de cor, e por mais que eu incentive esses cozinheiros inúteis, eles não conseguem inventar nada novo.\nEntão, no novo ano, vou expandir meu mapa gastronômico para lugares ainda maiores e mais distantes. Primeiro, vou estabelecer uma meta modesta: visitar todas as confeitarias de Londinium.\nQuanto ao trabalho glorioso de ir e vir e fazer filas, bem, isso continua sendo com você! Não precisa ficar tão feliz por receber a confiança desta senhorita, basta expressar sua gratidão louvando o nome desta dama.\nDito isso, aqueles cozinheiros idiotas ainda têm um pouco de boa vontade. Pelas conversas sussurradas que tentam esconder, já ouvi dizer que eles estão preparando um bolo gigante de dez andares — ha, eles continuam péssimos em guardar surpresas.\nApesar de ser uma ideia um pouco batida, talvez eu possa convidar mais pessoas para o meu aniversário este ano, como os novos amigos que fiz nesse último ano.\nComo você é o primeiro amigo que fiz em Mithagar, permito que você seja o primeiro a cortar o bolo.\n\nMurphy"
  },
  Mail_68906_Name = {
    Text = "Bolo de dez andares..."
  },
  Mail_68906_Sender = {Text = "Murphy"},
  Mail_68907_Desc = {
    Text = "Querido Guardião:\n\nTão inteligente quanto você certamente já soube dessa informação nos arquivos mágicos de Mithag — hoje é um dia memorável na vida do \"Detetive da Sorte\".\nNascimento, vencer a primeira rodada de 21 pontos, ganhar a centésima corrida de cavalos, solucionar o primeiro caso de assassinato em quarto fechado, fracasso que trouxe a morte — tudo aconteceu neste mágico 6 de junho.\nEntão, que tal jogarmos uma partida de bridge a dois? Justamente hoje, para tornar esse dia ainda mais memorável, o que acha?\n\nLake"
  },
  Mail_68907_Name = {
    Text = "Quer jogar uma partida?"
  },
  Mail_68907_Sender = {Text = "Ryker"},
  Mail_68908_Desc = {
    Text = "Esta carta não é um cumprimento, mas sim um aviso — não tente me controlar, não tente me prender em correntes.\nEu pertenço apenas a mim mesmo.\nEu não sou como aquele ser igual a mim, que ainda tem expectativas infantis sobre as pessoas e o mundo.\n\nEu matarei qualquer um que ouse se tornar meu \"mestre\", e eu cumprirei minha palavra.\n\nH"
  },
  Mail_68908_Name = {
    Text = "Eu pertenço a..."
  },
  Mail_68908_Sender = {
    Text = "Helot: Catena"
  },
  Mail_68909_Desc = {
    Text = "Guardião:  \n\nTalvez eu já tenha lhe narrado sobre meu amor pela água, comparado ao mundo barulhento dos humanos, o mundo subaquático é tão silencioso e tranquilo.  \nEu já flutuei entre plantas aquáticas e corais, e também já conversei com cardumes. Quanto mais distante da superfície da água, mais escura a cor da água se torna, e ao olhar para o céu a partir do fundo do mar, empurrado suavemente pelas ondas, a luz e sombra manchadas exibem cores hipnóticas, sendo a paisagem mais linda em meu coração.  \nVocê sabia? Alguns seres marinhos são capazes de lembrar do seu rosto, e quando você visita novamente, esses \"amigos\" ainda virão saudá-lo calorosamente, por exemplo, eu conheço um pequeno polvo inteligente e um peixe marinho amarelo-claro.  \nNeste dia de aniversário, sinto novamente saudade do mundo subaquático, e não sei se você gostaria de mergulhar comigo; sinceramente espero poder compartilhar com você este mundo tranquilo e também meus incríveis amigos marinhos.  \n\nNívea"
  },
  Mail_68909_Name = {
    Text = "Mundo Submerso..."
  },
  Mail_68909_Sender = {Text = "Nymphaea"},
  Mail_68910_Desc = {
    Text = "Guardião:\n\nDesde que você chegou a Mythag, me acostumei a lidar com assuntos relacionados a você como se estivesse criando uma criança, e, pelo seu desempenho habitual, sua fragilidade supera até mesmo minhas expectativas.\nNo entanto, como seu orientador e primeiro responsável, fico feliz em observar que, ao longo deste ano, as situações em que precisei resolver problemas e arcar com as consequências por sua causa diminuíram cada vez mais. Embora no início, quando você entrou na academia, parecesse completamente vazio de conhecimento e desesperadoramente perdido, sua velocidade de crescimento realmente pode ser descrita como fruto tanto de talento quanto de esforço.\nParabéns por ter se tornado um guardião qualificado, não decepcionando minhas expectativas.\nNum dia sem graça e nada especial como o meu aniversário, já preparei para você um presente destinado aos guardiões bem-sucedidos — o plano de treinamento especial utilizado anteriormente por Alistair. O que acha, está animado?\nNão pergunte por que sou eu quem lhe dá o presente; nos dias em que não posso entrar no laboratório, preciso encontrar algo para fazer, não é verdade?\nQuando estiver pronto, me procure na sala de treinamento.\n\nDoll"
  },
  Mail_68910_Name = {
    Text = "Presente..."
  },
  Mail_68910_Sender = {Text = "Doll"},
  Mail_68911_Desc = {
    Text = "Guardião dos Segredos:  \n\nUm ano, para um dançarino, é apenas dezenas de milhares de rotações e dezenas de milhares de saltos. Tirando o fato de que o par de sapatos de dança que me acompanhou por muito tempo foi substituído, tudo parece ter permanecido igual, mas, ao mesmo tempo, tudo parece ter mudado.  \nComparado à solidão com a qual eu já estava acostumada antes, durante este ano eu sempre tive um espectador fiel, um parceiro de dança um pouco desajeitado.  \nSempre que você está sentado na sala de dança, sinto meu corpo mais leve, como quando eu era criança e acabava de começar a aprender a dançar, cheia de uma paixão e motivação inexplicáveis.  \nTalvez eu não seja tão pura e nobre quanto penso. Enquanto dedico minha vida inteira à dança, também espero poder ter o seu olhar e ouvir os seus aplausos.  \nO tempo está muito bom no dia do seu aniversário, e posso antever que o céu noturno estará muito claro esta noite. Meu espectador mais entusiasmado, meu parceiro de dança exclusivo, você aceitaria o convite para caminhar comigo até aquela floresta com um belo lago e dançar uma dança dedicada à lua e às estrelas?  \n\nLiz"
  },
  Mail_68911_Name = {
    Text = "Parceiro de dança exclusivo..."
  },
  Mail_68911_Sender = {Text = "Liz"},
  Mail_68912_Desc = {
    Text = "Guardião do Segredo: \n\nDesde o dia da minha renascença, o povo de Misaq me ajudou muito. Talvez eu ainda não consiga me acostumar com a sensação de cooperação, mas pelo menos, ao caminhar com vocês, já posso confiar meu lado às suas costas, essa sensação... não é ruim. \nA maior parte da minha vida foi cheia de dano e traição. Sempre considerei lutar contra isso como o significado da minha batalha, até que não havia mais nada em minha vida. Meu olhar já não conseguia se desviar da vingança. \nAgora, seguindo os passos de vocês, percebo que a luta pode ter muitos significados além de dano e vingança; pode ser, como Lotan disse, que a luta pode ser apenas luta. \nAprendi a desfrutar da diversão da batalha, a aproveitar aquela sensação intensa, a simplesmente ser um guerreiro valente. \nSe minha luta puder trazer mais, então, eu desfrutarei daquela glória. \nE você, seja agora ou no futuro, eu prometo que minha lâmina nunca apontará para você. \n\nHelot"
  },
  Mail_68912_Name = {
    Text = "O significado da Batalha..."
  },
  Mail_68912_Sender = {Text = "Helot"},
  Mail_68913_Desc = {
    Text = "Querido Guardião:  \n\nPara ser sincera, nunca tive muitas expectativas quanto aos desejos de aniversário. Antes, quando eu ainda era \"normal\", meu maior desejo diário era ter comida e roupas suficientes, pagar o aluguel em dia e cuidar bem do Jenkins. Hoje, conseguir passar mais um ano tranquila e ver o Jenkins se divertindo por mais um ano já é mais do que suficiente para me satisfazer.  \nÉ um pouco embaraçoso admitir, mas diante do Jenkins, sempre finjo ser uma irmã mais velha responsável, enquanto que, para você, acabo causando muitos problemas. Às vezes nem eu mesma lembro qual versão de mim mesma foi a responsável.  \nSua gentileza e paciência constantes me aquecem e, ao mesmo tempo, me deixam envergonhada. Talvez essa seja a primeira vez na vida que alguém me trata com tamanha compreensão, e me sinto verdadeiramente honrada e grata por isso.  \nEste ano, preparei um bolo grande para todos, seguindo uma receita que uma das tias da antiga fábrica têxtil me ensinou. Embora não seja tão bom quanto os bolos feitos por chefs profissionais, tem um sabor especial que o Jenkins e eu adoramos. Desta vez, não há problema com os ingredientes, então todos poderão saboreá-lo à vontade. Por favor, venha provar!  \nConsegui convencer as outras versões de mim mesma a comemorar o aniversário de forma tranquila. Hoje, elas definitivamente, definitivamente não vão causar nenhum problema para você!  \nSe possível, me chame sempre que precisar, seja para lavar roupas, limpar ou organizar. Sou muito boa nessas tarefas e gostaria muito de ter a oportunidade de retribuir um pouco da sua gentileza.  \n\nMason"
  },
  Mail_68913_Name = {
    Text = "Retribuição..."
  },
  Mail_68913_Sender = {Text = "\"24\""},
  Mail_68914_Desc = {
    Text = "Guardião:  \n\nComo alguém responsável por receber os desejos de todos, parece que não importa o quanto eu tente, não consigo me acostumar com o fato de que no meu aniversário sou eu quem deve fazer um desejo. Para mim, parece que não tenho nada que realmente queira. \nDoll me disse que eu preciso encontrar o que realmente desejo no fundo do meu coração e questionar o porquê de tudo que faço. \nEu pensei por muito tempo e, na verdade, espero que os desejos de cada pessoa que vem até mim se realizem. Se eu continuar perguntando, provavelmente gosto dos sorrisos que aparecem quando as pessoas veem seus desejos realizados e do jeito que elas me cercam com gratidão, elogiando-me por ter cumprido o dever da deusa. \nDoll disse que isso é porque eu desejo que meu valor seja reconhecido, que eu me torne uma pessoa útil, e eu acho que ela está certa. \nMas ela também disse que o valor de uma pessoa não precisa ser decidido pelos outros, que nada é realmente útil, e o que importa é se seguimos o nosso coração, mesmo que isso signifique ser considerado inútil por outros. \nNão é à toa que Doll sempre consegue dizer coisas tão profundas, mas afinal, eu devo me tornar uma pessoa útil ou inútil? Parece que estou começando a ficar confusa novamente... \nMas se for para seguir meu coração, talvez eu ainda queira ser uma pessoa útil. Se eu puder ver os sorrisos de todos no meu aniversário, isso deve ser o presente que mais desejo. \n\nCeleste"
  },
  Mail_68914_Name = {
    Text = "Pessoa útil..."
  },
  Mail_68914_Sender = {Text = "Celeste"},
  Mail_68915_Desc = {
    Text = "Querido Guardião dos Segredos:  \n\nEu já me acostumei a viver como uma larva em um esgoto, poderia até dizer que esse é o destino com o qual nasci e que eu totalmente aceitei e abracei com satisfação.  \nEmbora eu seja profundamente grato por ter me feito provar novamente o maravilhoso sabor da liberdade, ninguém conseguiria aceitar meus hobbies peculiares, o que é perfeitamente compreensível. Afinal, a maioria das pessoas aqui são boas e gentis, incapazes de entender que o musgo que cresce nos cantos úmidos não necessita da luz do sol brilhante, mas sim do ar sombrio.  \nA não ser você, meu respeitoso e bondoso senhor, apenas você é capaz de verdadeiramente me compreender e ajudar, proporcionando-me uma felicidade genuína. A dor que você me impõe é extremamente satisfatória e reconfortante, permitindo-me confirmar minha própria existência.  \nSe outrora eu não tinha nenhum desejo especial a desejar no dia do meu aniversário, agora eu desejo poder segui-lo de perto e dedicar-lhe minha mente e corpo.  \nÉ claro que, por favor, não me trate com gentileza por ser misericordioso; critique-me, repreenda-me e castigue-me à vontade!  \n\nLeia"
  },
  Mail_68915_Name = {
    Text = "A intenção do líquen..."
  },
  Mail_68915_Sender = {Text = "Leigh"},
  Mail_68916_Desc = {
    Text = "Querido cachorrinho:  \n\nJá quase me apaixonei por esses dias de brincar com você de gato e rato, como nos romances heroicos clichês, onde o mensageiro da justiça sempre consegue impedir as tramas do vilão no último momento, comovente e grandioso.  \nSó que ver você se esforçar em vão é realmente irresistivelmente engraçado.  \nEsse mundo já está acabado há muito tempo, não há nenhuma forma de salvação, este planeta será como incontáveis outros que morreram, consumido por ▼&#x5B▼87;&4;▼.  \nAh, bem, vou brincar com você um pouco, até que agora de repente começo a entender um pouco o divertimento de N, antes do desfecho inevitável, na verdade não importa muito o que você faz.  \nNo aniversário de seu querido professor e mentor, preparei especialmente para você uma grande surpresa, antes do término da contagem regressiva do aniversário, espero que você consiga encontrar a \"bomba\" escondida.  \nAntes de que ambos sejamos completamente dissolvidos, quantas diversões você ainda poderá me proporcionar?  \n\n\n\"Dor\""
  },
  Mail_68916_Name = {
    Text = "Bomba surpresa…"
  },
  Mail_68916_Sender = {
    Text = "Doll: Inferno"
  },
  Mail_68917_Desc = {
    Text = "Guardião:\n\nRecentemente, entre os círculos aristocráticos de Londinium, surgiu uma nova moda: desenhar pessoalmente os projetos e encomendar joias personalizadas.\nEssas senhoras que se consideram tão conhecedoras de arte começaram a competir não mais pelo tamanho das gemas, mas pela sofisticação dos desenhos, sem perceber que seus pequenos subterfúgios, como contratar discretamente pintores famosos, são tão evidentes quanto tapar os próprios ouvidos ao roubar um sino.\nGraças a essa moda, minha lista de presentes de aniversário ganhou diversas joias e gemas de valor, incluindo uma excelente rubi-cabedal, que agora só precisa de uma armação adequada.\nEm vez de procurar por velhos entediantes, prefiro que meu cavaleiro desenhe algo especial com suas próprias intenções, como um presente para mim. O que acha?\nVou aguardar ansiosamente pela sua criação, tenho certeza de que seu gosto será excelente.\n\nSorel"
  },
  Mail_68917_Name = {
    Text = "Design de joias..."
  },
  Mail_68917_Sender = {Text = "Sorel"},
  Mail_68918_Desc = {
    Text = "Guardião:\n\nAntes de nosso primeiro encontro, por trás de incontáveis portais, eu já havia visto inúmeros vocês — idênticos e, ao mesmo tempo, diferentes.\nEu me lembro dos seus sorrisos e lágrimas, das suas escolhas, da forma como você persistiu e seguiu em frente em mundos distintos.\nPara mim, dentre tantos vocês, você é o mais especial. Cheguei até a nomear e catalogar em meu coração os mundos que observei, e ao mundo em que você reside, dei o nome de esperança — um nome escolhido no dia em que encontrei você.\nNeste dia chamado esperança, quero que talvez você tenha interesse em ver outros mundos também. Como se fosse os olhos do universo, eu o guiarei para que veja tudo o que observei em silêncio diante dos portais.\nE também verei você, através dos meus olhos.\n\nTawil"
  },
  Mail_68918_Name = {
    Text = "Diferente de você..."
  },
  Mail_68918_Sender = {Text = "Tawil"},
  Mail_68919_Desc = {
    Text = "Originalmente, eu apreciava muito o estilo simples de Missaga, mas desde que aquela mulher, Miryam, chegou, minha vida não tem mais conhecido a paz. \nNão rejeito aqueles que desejam buscar estabilidade e proteção; em um mundo tão turbulento, é natural e compreensível que as criaturas busquem conforto. \nContudo, sempre detestei ser tratado como um deus onipotente, e ainda mais após o afundamento de Lemúria, não há necessidade de erguer outro deus arrogante e distante. \nMiryam provavelmente ainda não conseguiu superar as sombras do passado e trouxe aquela antiga prática de fé cega para os dias atuais, fazendo com que eu fosse constantemente observado e cercado por atenções indesejadas em todos os cantos do campus — algo realmente irritante. \nHoje é meu aniversário, e certamente aquela mulher já deve ter preparado algum tipo de cerimônia exagerada. A simples ideia me deixa com os nervos à flor da pele e a cabeça doendo; por isso, não comparecerei, para não me envolver nesses abalos. \nSe você quiser, pode vir me encontrar no endereço indicado após esta carta para um passeio tranquilo. \nLembre-se bem: não deixe que aquela mulher descubra. \n\nTulu"
  },
  Mail_68919_Name = {
    Text = "Esconder-se em paz..."
  },
  Mail_68919_Sender = {Text = "Tulu"},
  Mail_68920_Desc = {
    Text = "Todos os dias eu sinto uma fome insuportável, e se não beber sangue por um momento que seja, fico angustiado. Mas desde que provei o seu sangue, todos os outros tipos de sangue comuns se tornaram horríveis na minha boca, como pedaços de cera, enquanto o sabor maravilhoso do seu sangue me seduz constantemente todos os dias na minha garganta.\nEu sei exatamente quanto sangue posso beber ao sugar alguém até secar, um sabor delicioso que desaparece num instante. Para que você não morra tão rápido, vou aprender a ser paciente com a fome, aprender a esperar ansiosamente pela próxima refeição saborosa, até o dia em que eu possa provar novamente o seu sangue.\nHa, céus, não consigo acreditar que eu realmente consegui, cheguei até a duvidar se já não teria evoluído. Considerando o quanto me contive, ao menos neste dia chamado aniversário, deixe-me provar um pouco do seu sangue doce e saboroso, só um pouco, o que acha?\nUsei o dinheiro que ganhei no clube de truta para comprar suplementos nutricionais para você, dessa vez certamente não terá mais anemia.\n\nUvhash, que sentiu fome por muito tempo"
  },
  Mail_68920_Name = {
    Text = "Sangue saboroso..."
  },
  Mail_68920_Sender = {Text = "Uvhash"},
  Mail_68921_Desc = {
    Text = "Caro Guardião do Segredo: \n\nÉ com grande satisfação que vejo seu progresso contínuo nas aulas de treinamento ao longo deste ano. Em breve, você ultrapassará a minha juventude e se tornará um soldado forte e capaz. Sinto-me verdadeiramente honrado por ser seu instrutor de treinamento. \nNo meu aniversário deste ano, recebi um par de botas muito adequadas para caminhadas em montanhas. Gostaria de saber se você tem interesse em fazer uma trilha comigo, para testar sua resistência física aprimorada, e aproveitar para assistir ao nascer do sol no topo da montanha. A paisagem entre as montanhas, longe da cidade, certamente será deslumbrante. \nE claro, seria ainda melhor se pudéssemos completar o passeio com um piquenique ao ar livre em meio à natureza, acompanhado de uma garrafa de bebida forte para nos aquecer. \n\nElva"
  },
  Mail_68921_Name = {
    Text = "<Yellow:Escalada a pé...>"
  },
  Mail_68921_Sender = {Text = "Alva"},
  Mail_68922_Desc = {
    Text = "Parceiro: \n\nEste ano aconteceu muita coisa, e pode não ter sido uma bela vida escolar para você. \nEu admito que durante o último ano eu te pressionei demais, e minha preocupação foi um pouco insensível, todo o treinamento pareceu um pouco forçado, fazendo você suportar muito de uma vez. \nMas eu espero que você saiba que você é sempre a pessoa mais importante para mim, além do Guardião do Segredo de Misaq, você é meu único parceiro. \nTalvez hoje, e apenas neste dia de aniversário, eu possa tentar ser um pouco egoísta, e você também pode esquecer todas as responsabilidades, não precisamos nos preocupar com tarefas ou treinamentos, vamos apenas relaxar um pouco. \nUm parque de diversões na cidade? Um teatro? Uma loja de departamentos ou um mercado de rua... tanto faz, eu espero compensar o que faltou para você. \nDa mesma forma, eu também espero que este dia sem preocupações tenha você ao meu lado, e que todos os planos sejam decididos por você. \n\nRamona"
  },
  Mail_68922_Name = {
    Text = "Um dia para relaxar..."
  },
  Mail_68922_Sender = {Text = "Ramona"},
  Mail_68923_Desc = {
    Text = "Querido Guardião:  \n\nDurante os anos em que vivi entre os humanos, meus queridos servos costumavam organizar grandes banquetes para mim nesse dia a cada ano, esforçando-se de várias maneiras para me agradar.  \nApesar de ser um dia comum e sem acontecimentos especiais, com aqueles sorrisos inexplicáveis, ele acabava se tornando agradável. Nessa habilidade de criar alegria a partir do nada e transformar o sofrimento em diversão, os humanos realmente são mestres.  \nMesmo nesta escola que construiu um cemitério dentro de seu campus, vocês ainda assim conseguem criar alegria com tamanha resiliência, o que me surpreende profundamente.  \nEntretanto, os presentes das pessoas comuns são realmente tediosos, e essas festas de aniversário são incrivelmente monótonas; a maioria dos humanos é, no fim das contas, vulgar e banal.  \nApenas você, apenas ao pensar em você, sinto algum interesse renovado, algo que me faz recordar o prazer dos velhos tempos.  \nEu ordeno que venha imediatamente ao meu quarto e jogue comigo até o amanhecer. Se souber me servir bem, talvez eu, com relutância, permita que beije as costas da minha mão.  \n\nVanda"
  },
  Mail_68923_Name = {Text = "Comando..."},
  Mail_68923_Sender = {Text = "Wanda"},
  Mail_68924_Desc = {
    Text = "<Del:West-Whelp>Guardião: \nOriginalmente, eu não tinha a intenção de escrever algo tão meloso assim, mas a Aigis não parava de falar sobre a importância e o significado desse momento, insistindo que eu escrevesse esta carta para você.\nPor causa da Aigis, vou dizer algumas palavras. Bem, já faz um ano que estou aqui, e em geral estou satisfeito com a acomodação e a alimentação da escola, mas os lençóis do dormitório são realmente muito lisos, o que me deixa com dificuldade para dormir confortavelmente. Não acham que só o algodão grosso é realmente confortável para dormir?\nSe eu fosse apontar mais alguma coisa, seria sobre a comida da cantina, que é muito saudável. Apesar de ficar satisfeito após comer, sinto que falta sabor, não chegando nem perto do gosto da comida de rua!\nEntão, para a festa de aniversário deste ano, não vou incomodar os cozinheiros. Deixe-me, mestre da gastronomia, levar todos vocês para as vielas misteriosas do Distrito Leste experimentar alguns pequenos restaurantes recomendados por mim e pelo Brown; garanto que vocês vão se apaixonar pelo sabor autêntico da comida de rua!\nÉ claro que todas as despesas hoje serão cobertas pelo West-Whelp, você não tem objeções, tem?\n\nSeus velhos companheiros Jenkin e Brown"
  },
  Mail_68924_Name = {
    Text = "Comida de rua..."
  },
  Mail_68924_Sender = {Text = "Jenkin"},
  Mail_68925_Desc = {
    Text = "Pessoa importante: \n\nAlém da minha irmã, você é a primeira pessoa que me apoiou tão sinceramente. Graças à sua sugestão anterior, já lancei uma série de álbuns com a gravadora e em breve realizarei meu primeiro show solo. \nQuero marcar o meu primeiro show neste planeta no dia do meu aniversário, para comemorar meu renascimento aqui. \nEspero que você possa vir pessoalmente assistir à minha apresentação com todo o meu empenho. Gostaria de convidar você e minha irmã como convidados especiais para subirem ao palco na última parte do show e cantarem comigo a minha nova música. O que acha? \nAh, e por favor, não conte nada disso à minha irmã, já que também é o aniversário dela. Quero preparar uma surpresa para ela. \nQuanto ao desejo de aniversário combinado entre mim e minha irmã, espero poder fazer com que minha voz brilhe novamente neste planeta. \n\nTinkter"
  },
  Mail_68925_Name = {Text = "Show..."},
  Mail_68925_Sender = {Text = "Tinct"},
  Mail_68926_Desc = {
    Text = "Querido Guardião:\n\nPassou-se mais um ano sem que eu percebesse, e cada dia que passei em Mythag foi muito feliz. Conseguir brincar, assistir às aulas e comer muitas coisas gostosas junto com todos vocês foi o tempo mais feliz da minha vida. Mesmo que, às vezes, eu fique um pouco nervosa durante as missões, nunca tive medo enquanto lutava ao lado de todos.\nSinto muito por ter causado tantos incômodos este ano, embora muitas vezes tenha sido a Jenkin brincando novamente. Mas ela só queria deixar todos felizes; espero que você não se importe com nossa negligência e ofensas.\nFalando da Jenkin, ela sugeriu este ano que realizássemos uma competição de captura de vaga-lumes no dia do meu aniversário. Ela preparou muitos potes transparentes e pretende transformá-los em muitas lanternas de vaga-lumes; no final, quem fizer a lanterna mais brilhante ganhará o título de \"Rei da Caça aos Vaga-lumes\".\nApesar de \"Rei da Caça aos Vaga-lumes\" soar um pouco bobo, a floresta que sempre se enche de vaga-lumes no verão é realmente linda. Se você tiver um tempo livre entre suas tarefas ocupadas, será muito bem-vindo para vir conosco até a floresta contemplar aquela paisagem cintilante como estrelas.\n\nAigis"
  },
  Mail_68926_Name = {
    Text = "Concurso de capturar vaga-lumes..."
  },
  Mail_68926_Sender = {Text = "Aigis"},
  Mail_68927_Desc = {
    Text = "Guardião! Há alguns dias, quando Aurita foi nadar no oceano, ela conheceu um novo amigo que solta eletricidade! Ele é redondo e achatado, parece uma pizza grande! \nAurita estava prestes a cumprimentá-lo, quando de repente sentiu um formigamento no corpo, e o novo amigo saiu correndo. \nQuando voltamos, a Dore me contou que foi uma arraia elétrica descarregando energia, mas Aurita não entendeu bem, só achou o novo amigo muito incrível! \n\nAgora que o aniversário de Aurita chegou, Guardião, você pode acompanhá-la para buscar o novo amigo de volta? Vai morar junto com os parceiros de Aurita! Esse formigamento também vai te deixar animado, com certeza! \n\nAurita"
  },
  Mail_68927_Name = {
    Text = "Novo amigo que libera eletricidade…"
  },
  Mail_68927_Sender = {Text = "Aurita"},
  Mail_68928_Desc = {
    Text = "Querido Guardião do Segredo:  \n\n   Para mim, o aniversário da infância era uma exigência intransigente por parte de meu pai, um exercício de prática musical que não permitia qualquer relaxamento.  \n   Não era permitido ser orgulhoso, não era permitido ser impaciente, não era permitido ser negligente. Apenas minha mãe, em segredo, preparava para mim um pequeno bolo; para mim, este dia era apenas uma repreensão severa, apontando todas as minhas falhas do ano anterior.  \n   Até hoje, já não sou mais um aprendiz de música e, graças a você, pude tocar aquela porta majestosa e entrar no mais alto templo da música. No entanto, as admoestações desde a minha infância já me fizeram perder qualquer desejo por prazeres mundanos.  \n   Apenas a música, apenas tocar para você aquela melodia fúnebre destinada, é a minha busca final nesta vida, o único momento em que sinto que existo com significado.  \n   Se você estiver disposto a me confiar o seu tempo antes de dormir esta noite, tocarei sem parar até o amanhecer a música gravada na minha alma.  \n\nHamlin"
  },
  Mail_68928_Name = {
    Text = "Desejo de Apresentação..."
  },
  Mail_68928_Sender = {Text = "Hameln"},
  Mail_68929_Desc = {
    Text = "Pivete: \n\nDesde que cheguei aqui, esperava finalmente me livrar daquela mulher louca e antiquada, mas as malditas regras deste lugar são ainda piores do que as dela. Já faz tempo que não experimento uma boa diversão!\nBeber à vontade? Proibido. Flertar com as belas? Proibido. Jantar ao redor da fogueira? Proibido. Até a carne assada aqui é pior do que a dos filisteus! Francamente, não entendo como conseguem viver uma vida tão insípida assim.\nMas um forte não reclama do ambiente. Após minha campanha, tornei-me novamente um grande líder de gangue nesta sua cidade.\nNa ocasião do aniversário do grande Senhor Golias, magnanimamente o convido para comparecer ao banquete que meus camaradas prepararam para mim. Vinho fino, carne saborosa e belas mulheres, tudo isso estará lá, com certeza impressionará um pivete inexperiente como você.\nPor consideração à nossa antiga amizade, nem exigirei presente algum. Basta que venha com respeito e ofereça suas bênçãos ao renascimento de um poderoso.\nOlhe bem e testemunhe: no próximo aniversário, no aniversário depois desse, não importa onde eu esteja, abrirei um novo caminho para a conquista.\n\nGolias"
  },
  Mail_68929_Name = {
    Text = "<Yellow:Jornada...>"
  },
  Mail_68929_Sender = {Text = "Goliath"},
  Mail_68930_Desc = {
    Text = "Guardião: \n\nNunca imaginei que um dia celebraria o aniversário deste corpo efêmero, sempre o considerei apenas um dia comum de prática espiritual. No entanto, o rei me procurou pela manhã e me ordenou verbalmente que hoje não realizasse nenhuma atividade relacionada ao rei ou à prática espiritual, e que deveria passar o dia inteiro apenas para mim. \nFoi a primeira vez em muitos dias e noites que o rei demonstrou tamanha preocupação comigo, o que me deixou profundamente comovido e grato. Porém, como já dediquei toda a minha vida ao rei, fiquei por um momento sem saber para onde ir ou o que fazer. \nApós refletir por um tempo, a única coisa que me veio à mente como um leve arrependimento foi a culpa que sinto em relação àquela criança, Murphy. Mesmo que, por causa da restauração de nossa terra natal, eu nunca tenha sentido o menor remorso, sei muito bem que o que lhe devo não pode ser pago ou reparado de nenhuma forma. \nMas, se realmente houver algo que eu quisesse fazer de coração, talvez fosse querer, vergonhosamente, fazer mais uma vez o que uma mãe deveria fazer. \nComprei especialmente o doce que aquela criança já gostou antes. Como indulgência para uma mãe desgraçada e indigna, posso lhe pedir o favor de entregar este presente às mãos dela, sem dizer que fui eu quem o enviou — apenas diga que foi você mesmo quem o preparou. \nEspero sinceramente que você aceite, e serei profundamente grato. \n\nMiriam"
  },
  Mail_68930_Name = {
    Text = "Compensar..."
  },
  Mail_68930_Sender = {Text = "Miryam"},
  Mail_68931_Desc = {
    Text = "Ah, após refletir com minha sabedoria, compreendi completamente o significado do aniversário humano. O chamado dia especial exclusivo para alguém tem exatamente como finalidade dar à pessoa a oportunidade rara de exercer privilégios, obter itens valiosos e fazer pedidos com justificativa aos outros.\nSeja qual for o desejo que normalmente não ousaria dizer ou nem sequer pensaria, nesse dia há chance de ser realizado. Ha, isso é praticamente um dia de indulgência mais emocionante do que qualquer outra festividade.\nParece que, todos esses anos anteriores, perdi tantas oportunidades privilegiadas, mas felizmente, com minha vida tão longa, ainda terei muitos, muitos aniversários para fazer desejos.\nEntão, exigir que todos me acompanhem e joguem uma partida animada no dia do meu aniversário, deve ser um desejo fácil de satisfazer, certo?\n\nLotten"
  },
  Mail_68931_Name = {
    Text = "Privilégio do aniversariante..."
  },
  Mail_68931_Sender = {Text = "Lotan"},
  Mail_68932_Desc = {
    Text = "Guardião: \n\nCom o passar dos anos, o aniversário foi se tornando gradualmente apenas um dia no calendário que se passa num piscar de olhos e muitas vezes só lembramos dele quando já passou, como água escorrendo silenciosamente.\nNo mundo dos adultos, celebrar o aniversário é um privilégio das crianças e dos ociosos sem o que fazer. Nisso também me tornei um adulto entediante, já não tenho mais grandes expectativas em relação ao meu aniversário.\nHouve um ano em que tive um impulso criativo e esculpi um bolo em forma de escultura requintada. Nos anos seguintes, nunca mais esqueci meu aniversário por descuido nem precisei encomendar um bolo fresco. No dia do meu aniversário, bastava ir ao depósito buscar aquele item de celebração imutável e eterno, soprar as velas num pequeno ritual e assim meu aniversário terminava.\nFoi só depois que cheguei a Mythag que percebi que uma mesma pessoa pode ser ao mesmo tempo ociosa e ocupada. E mais, as pessoas aqui não se contentam em serem apenas entediadas individualmente; insistem que todos se juntem a essa monotonia coletiva.\nEstes dois últimos anos em Mythag participei de mais festas de aniversário do que em toda a primeira metade da minha vida. O mais engraçado é que, nessa celebração monótona, descobri um prazer estranho e peculiar.\nTalvez, além de temas trágicos e solenes, cenas tolas e absurdas da vida cotidiana também possam estar cheias de beleza artística.\nDito isso, o plano para este ano é esculpir uma estátua em miniatura de um Guardião sorrindo tolo, para segurar minha escultura de bolo.\nLembre-se de vir ao meu estúdio mais cedo, minha musa e modelo.\n\nShan"
  },
  Mail_68932_Name = {
    Text = "Diversão entediante..."
  },
  Mail_68932_Sender = {Text = "Sanga"},
  Mail_68933_Desc = {
    Text = "Caro Xiaoxin,\n\nApós muita deliberação, escrevo esta carta neste mundo desolado. Por muito tempo, quase me esqueci do meu aniversário; em um mundo assim, a celebração é naturalmente sem sentido.\nMas desde que te conheci, tenho me tornado cada vez mais gananciosa. Dia após dia, até mesmo a solidão que uma vez suportei tornou-se insuportável.\nEm momentos como este, uma estranha emoção surge em meu coração—um toque de inveja pelo “eu” naquele mundo, talvez com um indício imperceptível de ciúmes. Veja, alguém como eu, que se orgulha de sua racionalidade, pode ainda abrigar tais pensamentos desprezíveis, provando que a imparcialidade e a racionalidade humanas têm seus limites.\nSei que tipo de convite você irá me fazer, mas por questão de tempo e espaço, perturbações desnecessárias devem ser evitadas ao máximo. Eu não deveria, nem irei, ao seu mundo.\nEnquanto escrevo isso, estou olhando para o universo, para o lugar onde o túnel se abre. Se, por acaso, você também estiver olhando para cima, então podemos dizer que estamos contemplando o mesmo céu estrelado.\nEspero que esta carta possa ocupar meu lugar, cruzando tempo e espaço, flutuando até sua palma, passando por seus olhos e lábios, para te encontrar, para me apoiar em você.\nQuando você abraçar esta carta, eu imagino abraçar você deste lado do mundo.\n\n\"Ramona\""
  },
  Mail_68933_Name = {
    Text = "Vamos olhar juntos para longe..."
  },
  Mail_68933_Sender = {
    Text = "Ramona: Desgastada"
  },
  Mail_68934_Desc = {
    Text = "Meu pequeno prisioneiro:\n\nVocê sabe que, assim como diferentes animais têm dietas diferentes, as pessoas também têm necessidades diferentes de calor? Algumas se aquecem apenas vestindo uma roupa a mais, outras precisam de mãos quentes, de um abraço caloroso, e algumas precisam da temperatura exata em que a cera derrete.\nEsse calor escaldante e viscoso se grava em cada terminação nervosa, delineando claramente o caminho sinuoso das gotas de vela escorrendo, com uma dor suave e uma sensação arrepiante, só quando você não consegue evitar gritar de prazer é que sente plenamente sua própria existência.\nÀs vezes, eu me torno a vela, desfrutando a felicidade de deixar marcas; outras vezes, fico fascinada pela temperatura da vela, ansiando por esse calor doce e doloroso.\nO inverno em Mithras já chegou, ultimamente tenho sentido frio com frequência, e com ele, a solidão que o frio traz. Querido, você deve saber qual é o dia de hoje. Meu desejo é simples, certamente você, sendo tão gentil, vai querer me trazer um pouco de calor para afastar a solidão.\n\nPandia"
  },
  Mail_68934_Name = {
    Text = "<Yellow:Acolhimento Necessário>…"
  },
  Mail_68934_Sender = {Text = "Pandia"},
  Mail_68935_Desc = {
    Text = "Guardião do Segredo:\n\nEste ano, eu e Tinct fizemos um acordo mútuo: nossos desejos de aniversário devem ser apenas sobre nós mesmos, não podemos fazer desejos um pelo outro.\nEmbora tenha sido ela quem propôs esse acordo por birra, claramente isso também a deixou em apuros.\nNós dois estamos tão entrelaçados há tanto tempo que é difícil pensar de forma independente como as pessoas normais, mas renascer em uma nova vida cheia de ajuda e carinho, não há momento melhor para aprender a andar sozinho do que agora.\nApós uma cuidadosa consideração, já pensei no desejo que quero fazer este ano: fazer cinco novos amigos... não, melhor três. Afinal, mudar a si mesmo é algo que deve ser feito devagar e aos poucos.\nComo você é meu único e tão popular amigo atualmente, talvez você possa me ensinar alguns segredos sobre fazer amigos?\n\nFaint"
  },
  Mail_68935_Name = {
    Text = "Desejo de fazer amizades..."
  },
  Mail_68935_Sender = {Text = "Faint"},
  Mail_68936_Desc = {
    Text = "Guardião do Segredo: \n\nTodos os anos, no dia do meu aniversário, faço o mesmo desejo: a metamorfose do sangue perfeito. Na verdade, sempre soube que minha obsessão pelo sangue pode parecer teimosia, ridículo ou até mesmo patético e desprezível aos olhos dos outros.\nMas você é diferente. Em qualquer circunstância, sei que sempre vai me apoiar nessa jornada, mesmo que eu encontre obstáculos, caia ou volte de mãos vazias. Mesmo diante das risadas dos outros, você é a primeira pessoa a se importar comigo.\nTalvez nem você, nem ninguém, consiga compreender o que uma pessoa que foi oprimida e humilhada desde a infância carrega consigo. Mas não importa, todas as dificuldades desse caminho de transformação já se tornaram parte do meu corpo e minha nutrição, me sustentando para levantar e resistir continuamente.\nJá não sou mais aquele eu fraco da juventude. Não importa quantos desafios surgirem, seguirei firme até o fim.\nAté lá, por favor, me observe e aguarde meu sucesso.\nAh, a propósito, aqueles cinquenta que você me emprestou antes, eu disse que devolveria. Agora já economizei o suficiente, e ainda sobraram dois. Considere-os como um bônus e aceite-os junto com o restante.\n\nKeketh"
  },
  Mail_68936_Name = {
    Text = "Devolver o dinheiro..."
  },
  Mail_68936_Sender = {Text = "Caecus"},
  Mail_68937_Desc = {
    Text = "Prezado Guardião dos Segredos:  \n\nOlá, seja bem-vindo ao preenchimento do questionário anual de manutenção da boneca automática Erica. Vou coletar as experiências reais e os problemas encontrados por você no uso da Erica ao longo deste ano. Sua opinião é a direção para a constante melhoria da Erica.  \nA seguir, solicito gentilmente que você atribua notas às questões abaixo, de baixa a alta, agradeço muito pelo seu feedback.  \nFacilidade de uso: 1-5 pontos  \nVelocidade de resposta durante o uso: 1-5 pontos  \nGrau de compreensão das necessidades: 1-5 pontos  \nAtenção aos sentimentos do usuário: 1-5 pontos  \nPrecisão ao consultar informações: 1-5 pontos  \nPraticidade das soluções propostas: 1-5 pontos  \nPor fim, descreva brevemente os problemas que você encontrou ao usar a Erica e partes com as quais não ficou satisfeito. Esses problemas poderão ser corrigidos no futuro.  \nApós concluir o questionário, um pequeno presente comemorativo será entregue no seu quarto. No próximo ano, a Erica continuará ao seu lado como sua assistente mais dedicada. Agradeço novamente pelo uso. Adeus.  \n\nErica"
  },
  Mail_68937_Name = {
    Text = "Questionário de Investigação da Manutenção Anual..."
  },
  Mail_68937_Sender = {Text = "Erica"},
  Mail_68938_Desc = {
    Text = "Guardião do Segredo:  \n\nTodo ano, no dia do meu aniversário, passo o dia inteiro relembrando detalhadamente o passado em minha mente e escrevendo novamente o mesmo diário.  \nQuanto mais tempo passo longe da minha terra natal, mais turvas as memórias do passado parecem ficar — aqueles dias em que aguardávamos ansiosos pelo regresso de alguém guiado pela luz, aqueles dias em que olhávamos com reverência para a majestade do nosso rei... Tudo isso já não consigo recordar com clareza.  \nMas não quero esquecer, jamais vou esquecer. Mesmo que a espera seja interminável, mesmo que minha alma arda em chamas, essa luz não se apagará até o dia em que minha terra ancestral renasça. Naquele dia, serei o primeiro a responder ao chamado.  \nImaginei inúmeras vezes como seria nosso reencontro, mas nunca imaginei que seria aqui que veria novamente o rei e o sacerdote. Usando suas próprias palavras, se o lugar onde o coração encontra paz é o verdadeiro lar, então este lugar já pode ser considerado minha segunda pátria, e as anotações em meu diário, ao invés de meras memórias, tornaram-se agora novas experiências de cada dia.  \nNão preciso de nenhuma recompensa ou presente; poder segui-lo novamente é a maior felicidade que poderia desejar.  \nSe a luz deste corpo não puder iluminar o fundo do mar de minha terra natal, então que ela siga os passos do rei e, por enquanto, ilumine esta terra continental.  \n\nFalorth"
  },
  Mail_68938_Name = {
    Text = "Siga meu rei..."
  },
  Mail_68938_Sender = {Text = "Faros"},
  Mail_68939_Desc = {
    Text = "Guardião: \n\nParabéns a mim, parabéns a você, parabéns a Misaq, parabéns por termos sobrevivido mais um ano sob a perseguição do terror negro.\nHoje não é um simples aniversário, hoje é o dia da comemoração da minha sobrevivência, é o dia de louvar a minha vida resiliente.\nEstar vivo, essas duas palavras simples contêm tantas dificuldades, essa vitalidade ardente só pode ser comparada ao aroma do café quente, junte-se a seita do café, Guardião, vamos louvar a clareza, louvar cada um que está vivo.\n\nUm bilhete que veio junto com a carta:\nAh, aquele cara, Winkle, bebeu café demais, nervos excitados e cansaço extremo, desmaiou direto na mesa, já a coloquei na enfermaria, não se preocupe.\nMas antes de desmaiar, ela tirou um pacote de grãos de café raros e papel de carta e colocou juntos, parece que é para você, eu anexei junto com a carta, espero que quando ela acordar, não se arrependa.\nQuanto ao aniversário dela, talvez deixá-la descansar bem seja o melhor presente em vez de uma festa.\n——Sylvia"
  },
  Mail_68939_Name = {
    Text = "Elogiando a vida..."
  },
  Mail_68939_Sender = {Text = "Winkle"},
  Mail_68940_Desc = {
    Text = "Guardião: \n\nHahaha! Depois de eu insistir em gravar 12 lembretes em todos os cantos do quarto, escrevendo 36 bilhetes (ou talvez mais, mas não consigo encontrar), finalmente consegui lembrar que hoje é meu aniversário! \n Não esperava por isso, na verdade, eu mesmo só me lembrei disso esta manhã, mas tudo isso é graças ao meu esforço ao longo do ano, não quero perder um dia tão especial. \n Fiquei realmente feliz na última festa que tivemos juntos, especialmente com quem estava jogando certos jogos e comendo uma certa sobremesa... Deixe pra lá, o importante é que foi divertido! \n Quando eu era criança, minha mãe sempre me comprava um livro de histórias de aventura no meu aniversário, e nós dois nos deitávamos juntos antes de dormir, lendo e lendo, e eu sonhava com aventuras emocionantes. Embora eu rapidamente esquecesse ao acordar, aquela alegria ficava na minha mente, e eu acredito que sentimentos preciosos não serão esquecidos. \n Além disso, a falta de memória tem suas vantagens, embora eu não me lembre do que fiz na festa anterior, hoje posso experimentar tudo de novo, por favor, me traga de volta a alegria da última vez! \n\n Nautila, cheia de expectativas"
  },
  Mail_68940_Name = {
    Text = "Mais uma vez..."
  },
  Mail_68940_Sender = {Text = "Nautila"},
  Mail_68941_Desc = {
    Text = "Prezado Guardião do Segredo,\n       Na atualização V1.7.1, ocorreu uma perda anormal do estado desbloqueado do evento \"Helot: Catena\" no \"Frenesi de Reprodução\". Como você realizou novamente o desbloqueio após a perda do estado, estaremos reembolsando os \"Ponto de partida real*3\" consumidos na segunda tentativa de desbloqueio. Por favor, confira."
  },
  Mail_68941_Name = {
    Text = "Compensação de desbloqueio de reprodução frenética de Helot-catena"
  },
  Mail_68941_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_71330_Desc = {
    Text = "Caro Guardião:\nA atividade \"Um meio passo de distância\" foi encerrada. Converteremos as \"Peças de boneca\" restantes do guardião na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Por favor, verifique."
  },
  Mail_71330_Name = {
    Text = "Recuperação de peças do boneco"
  },
  Mail_71330_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_71331_Desc = {
    Text = "Caro Guardião:  \nA atividade \"Mágica da Story\" foi encerrada. As \"Inspiração Errante\" restantes do guardião foram convertidas na proporção de 1 unidade = \"Cupom de ouro rosa*40\". Por favor, verifique e confirme o recebimento."
  },
  Mail_71331_Name = {
    Text = "Recuperação de Inspiração Flutuante"
  },
  Mail_71331_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_71332_Desc = {
    Text = "Caro Guardião:  \nA atividade \"Antes que a primavera murche\" foi encerrada. Os \"Poesia Alegre\", \"poesia melancólica\" e \"Poema de Arrependimento\" restantes do guardião foram convertidos na proporção de 1 unidade = \"Cupom de ouro rosa*40\". Por favor, verifique e confirme o recebimento."
  },
  Mail_71332_Name = {
    Text = "Reaproveitamento de poemas"
  },
  Mail_71332_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_71848_Desc = {
    Text = "Caro Guardião:  \nA atividade \"Com o livro da rosa\" foi encerrada. Os \"Leque de Penas do Espírito Avestruz\" restantes do guardião serão convertidos na proporção de 1:40 em \"Cupom de ouro rosa\". Por favor, verifique."
  },
  Mail_71848_Name = {
    Text = "Reciclar Leque de Pena de Espiritismo"
  },
  Mail_71848_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_74020_Desc = {
    Text = "Caro Guardião:  \nA atividade \"As estrelas estão em posição·clon\" foi encerrada, agora converteremos os \"Embrião Ignorante\", \"Embrião sem desejo\" e \"Embrião Insaciável\" restantes do guardião na proporção de \"Cupom de ouro rosa *40\" por cada unidade. Por favor, verifique."
  },
  Mail_74020_Name = {
    Text = "Recuperação de Embrião"
  },
  Mail_74020_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_74347_Desc = {
    Text = "Caro Guardião:  \nO evento \"Pastor da Alma·clon\" foi encerrado. Os \"Bônus de venda beneficente\" restantes serão convertidos na proporção de \"Cupom de ouro rosa*40\" por cada unidade. Por favor, verifique."
  },
  Mail_74347_Name = {
    Text = "Coleta de Vouchers de Caridade"
  },
  Mail_74347_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_74841_Desc = {
    Text = "Parceiro:\n\nNo exato dia do ano passado, eu ainda estava longe de imaginar que, após um ano, eu teria que depositar esta carta em uma caixa de correio vazia.\nNaquela época, você havia acabado de ingressar em Mythag, não parecendo muito diferente de um aluno teimoso e preguiçoso. Mesmo agora, ao recordar, percebo que frequentemente fui excessivamente rígido com você e me importei demais com minha máscara de racionalidade e compostura.\nNa verdade, naquele dia do ano passado, comprei um buquê de flores. Fiquei diante da entrada da biblioteca, olhando por muito tempo para as rosas envoltas em uma fita vermelha e em papel de embrulho verde-escura, e no final as coloquei na cabeceira da minha cama.\nCom o passar do ano, as flores murcharam, mas a fita vermelha brilhante permaneceu amarrada à chave de prata K-0617, tão vibrante quanto nova.\nComo desejo, como desejo intensamente comprar outra dúzia de rosas, mas agora elas não teriam outro destino além de murcharem novamente na minha cabeceira.\nAcostumei-me a detalhar soluções para todos os problemas, e para mim, o sabor do arrependimento é algo tão novo e amargo.\nNo entanto, sempre mantive uma confiança quase cega de que sua alma nunca partiu, de que talvez você esteja apenas viajando temporariamente por algum canto do universo, mas que, no fim, retornará aqui, retornará ao meu lado.\nNão acredito que isso seja apenas um devaneio de um sonhador, pois cada vez que vou até a Piscina Negra contemplar seu rosto, ainda consigo sentir dentro de mim aquele calor suave que me conecta e ressoa com você.\nSempre acreditarei e ansiarei pelo dia do nosso reencontro, e no momento em que nossas mãos se entrelaçarem novamente, entregarei pessoalmente a você as rosas que hoje devo.\n\nRamona"
  },
  Mail_74841_Name = {Text = "Rosa…"},
  Mail_74841_Sender = {Text = "Ramona"},
  Mail_76410_Desc = {
    Text = "Caro Guardião:\nA atividade \"Sombra da cidade chuvosa\" foi encerrada. Os \"Crânio do Animal Pálido\", \"Crânio de Fera Sombria\" e \"Crânio do Animal Escarlate\" restantes serão convertidos na proporção de \"Cupom de ouro rosa*40\" por cada unidade. Por favor, verifique."
  },
  Mail_76410_Name = {
    Text = "Recuperação de moeda do evento Sombra da Chuva"
  },
  Mail_76410_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_78653_Desc = {
    Text = "Caro Guardião:\n\"Cura Múltipla·Réplicar\" a atividade de replicação foi concluída, agora os \"puzzles de memória\" restantes do Guardião serão recuperados na proporção de cada um trocado por \"Cupom de ouro rosa\" × 40, por favor, lembre-se de verificar."
  },
  Mail_78653_Name = {
    Text = "Recuperação de Quebra-Cabeça de Memória"
  },
  Mail_78653_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_78792_Desc = {
    Text = "Caro Guardião: \nA atividade \"Até a Neve Derreter·clon\" foi encerrada. As moedas de atividade restantes do guardião — \"Brotinho congelado\", \"Brotinho de prata com geada\" e \"Botão de sol\" — serão convertidas na proporção de \"Cupom de ouro rosa * 40\" por cada unidade. Por favor, verifique e confirme o recebimento."
  },
  Mail_78792_Name = {
    Text = "Recuperação de Broto"
  },
  Mail_78792_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_79390_Desc = {
    Text = "Caro Guardião, \n        Agradecemos pelo seu apoio e reconhecimento ao [Véspera do Esquecimento]. Para melhorar a experiência de jogo dos Guardiões na Universidade de Misag, convidamos sinceramente você a preencher a seguinte pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos [Núcleo de prata*200] como recompensa, que você poderá reivindicar após concluir o questionário. O prazo para preenchimento termina em 17 de março às 9:00, por favor, não deixe para a última hora.\n       <SurveyLink:[Clique aqui para acessar]>\n        Levaremos em consideração seriamente cada sugestão dos Guardiões e seus comentários certamente farão a Universidade de Misag melhorar cada vez mais!\n        — Que a Chave de prata guie seu caminho."
  },
  Mail_79390_Name = {
    Text = "Questionário de Experiência da Versão V2.1.0"
  },
  Mail_79390_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_79646_Desc = {
    Text = "Caro Guardião:\nA atividade \"Enterrado na memória\" foi encerrada, agora converteremos os \"Relatório de diagnóstico\" restantes do guardião na proporção de Cupom de ouro rosa*40 por cada unidade. Por favor, verifique."
  },
  Mail_79646_Name = {
    Text = "Recuperação de moeda enterrada sob Memórias"
  },
  Mail_79646_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_80091_Desc = {
    Text = "Guardião do Segredo: \n\nQuando você ler esta carta, significa que a sugestão que plantei na sua mente já fez efeito. \nHaha, não precisa se preocupar. É apenas um pequeno hipnotismo que usei para garantir que meu jantar de aniversário aconteça sem problemas, não terá nenhum impacto real sobre você. \nAgora, você sentirá naturalmente vontade de ir às compras; siga esse desejo, vá até as lojas e escolha entre as vitrines repletas um presente que me agrade e entregue-o diretamente a mim. \nSei que você pode estar confuso agora, e reconheço que isso é compreensível, mas o aniversariante tem alguns privilégios, não é verdade? Estou fazendo isso apenas por medo de que você esqueça esta data especial. Afinal, você é meu convidado mais querido. \nNo final, estarei esperando pacientemente a sua visita — não esqueça do presente. \n\nClementine"
  },
  Mail_80091_Name = {
    Text = "Presente escolhido \"pessoalmente\""
  },
  Mail_80091_Sender = {Text = "Clementine"},
  Mail_81288_Desc = {
    Text = "Caro Guardião,\n        Agradecemos pelo seu apoio e reconhecimento ao \"Véspera do Esquecimento\". Para melhorar a experiência dos Guardiões na Universidade de Misag, convidamos você a preencher a seguinte pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos \"Núcleo de prata*200\" como recompensa; basta completar o questionário para recebê-los. O prazo para conclusão do questionário é dia 14 de abril às 9:00, por favor, preencha a tempo.\n<SurveyLink:\"Clique aqui para preencher\">\nLevaremos em consideração seriamente cada sugestão dos Guardiões. Seu feedback certamente fará a Universidade de Misag melhorar cada vez mais!\n— Que a Chave de prata ilumine o seu caminho."
  },
  Mail_81288_Name = {
    Text = "Questionário de Experiência da Versão V2.2.0"
  },
  Mail_81288_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_81326_Desc = {
    Text = "Benfeitor:\n\nHoje é o único feriado do ano para mim e para Pólux.\nNa Igreja, não nos era permitido dar demasiada atenção ao significado pessoal; todo o nosso valor existia apenas no serviço eterno ao Portador da Luz, e diante dessa fé, qualquer outro feriado era apenas uma ilusão sem sentido.\nMas, mesmo assim, toda vez que o aniversário chegava, Pólux e eu ainda comemorávamos em segredo; escondíamos dos criados e preparávamos um presente o mais discreto possível um para o outro, esperando ansiosamente por esse dia.\nOs momentos de celebração do aniversário geralmente ocorriam à meia-noite — aquele era o único momento livre que tínhamos durante o dia todo. As mãos habilidosas e as ideias criativas de Pólux sempre faziam com que o presente dele superasse o meu; uma vez, ele chegou até a tecer uma flor desabrochada com as penas que tinha acumulado.\nNa verdade, não sou muito bom em preparar surpresas. Pólux sempre diz que minhas expressões já traem tudo muito antes, e o que possuo deve parecer ainda mais pobre e monótono aos seus olhos. Mesmo assim, hoje já pensei numa maneira excelente de compartilhar essa alegria com você.\n\nQuando à noite você ouvir três batidas na janela, não tenha medo, abra-a, e eu o levarei para experimentar a sensação das nuvens e do vento noturno.\n\nCastor"
  },
  Mail_81326_Name = {
    Text = "Passeio noturno..."
  },
  Mail_81326_Sender = {Text = "Castor"},
  Mail_84142_Desc = {
    Text = "Guardião do Segredo:  \n\nAntes da reunião, escrevi esta carta para formalmente convidá-lo e apresentar meu \"navegação de aniversário\".\nA primeira parada desta navegação é o rio Tâmisa. Vamos embarcar em um barco de carga transformado em restaurante móvel, enquanto navegamos, degustando abacaxi em conserva e rum. Esta é uma delícia que só é servida no aniversário da tripulação, espero que você goste.\nA segunda parada desta navegação é o mirante do porto. Fique tranquilo, já solicitei as permissões de observação à associação de balões de ar quente. Quando o balão subir aos céus e tivermos uma vista panorâmica de todo o canal de Londres, cortaremos o bolo juntos para comemorar.\nNo passado, as condições de navegação eram limitadas, e o chamado bolo de aniversário era apenas um modelo feito de carvalho e caramelo pelo carpinteiro, então eu também não conheço o sabor do bolo. Poder degustá-lo com você, além da beleza da comida, acredito que colherá ainda mais.\nA terceira parada, ou melhor, o terceiro segmento, é o mapa estelar personalizado. Marquei a posição dos astros no momento do meu nascimento no mapa náutico, e se você não se importar, gostaria de marcar a sua também. Este mapa náutico único será o presente mais valioso a ser guardado.\nNa verdade, ao escrever esta carta, tive algumas hesitações. Essas ações sem dúvida ultrapassam os limites do comum, mas hoje é um dia especial, e você é uma pessoa especial para mim, merecendo que eu quebre a rotina.\nPortanto, por favor, não recuse e compareça pontualmente.\n\nCorposant"
  },
  Mail_84142_Name = {
    Text = "\"Convite para Navegação\""
  },
  Mail_84142_Sender = {Text = "Corposant"},
  Mail_84355_Desc = {
    Text = "Caro Guardião:\nA atividade \"Balouçando na Chuva\" foi encerrada, agora converteremos as \"Bandeiras de Sinalização\" restantes do guardião na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Por favor, verifique."
  },
  Mail_84355_Name = {
    Text = "Recuperação de Bandeira de Sinalização"
  },
  Mail_84355_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_84410_Desc = {
    Text = "Prezado Guardião, \n        Agradecemos pelo seu apoio e reconhecimento ao [Véspera do Esquecimento]. Para oferecer uma melhor experiência de jogo aos Guardiões da Universidade de Misag, convidamo-lo cordialmente a preencher a seguinte pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos [Núcleo de prata*200] como recompensa, que poderá ser resgatada após concluir o questionário. O prazo para preenchimento termina em 5 de maio às 9:00, por favor, não deixe para depois.\n       <SurveyLink:[Clique aqui para acessar]>\n        Levaremos em consideração atentamente cada sugestão dos Guardiões e suas opiniões certamente contribuirão para que a Universidade de Misag se torne cada vez melhor!\n        — Que a Chave de prata guie seu caminho."
  },
  Mail_84410_Name = {
    Text = "Questionário de experiência da versão V2.2.1"
  },
  Mail_84410_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89744_Desc = {
    Text = "Prezado Guardião do Segredo:  \nNa atualização V2.2.2, aumentamos as recompensas de \"Doação de Líquido Fonte - Fundo de Doação de Alumni\". Para os Guardiões que já receberam todas as recompensas adicionais antes da atualização, enviaremos as recompensas correspondentes como recompensa retroativa. Por favor, verifique."
  },
  Mail_89744_Name = {
    Text = "V2.2.2 Doação de primordial de prata - Reemissão de recompensa"
  },
  Mail_89744_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89902_Desc = {
    Text = "Prezado Guardião, \n        Agradecemos pelo seu apoio e reconhecimento ao [Véspera do Esquecimento]. Para melhorar a experiência dos Guardiões na Universidade de Misag, convidamo-lo gentilmente a preencher a seguinte pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos [Núcleo de prata*200] como recompensa, que poderá ser resgatada após concluir o questionário. O prazo para preenchimento termina em 27 de maio às 9:00, por favor, não deixe para depois.\n       <SurveyLink:[Clique aqui para acessar]>\n        Levaremos em consideração cada sugestão dos Guardiões com atenção, e seu feedback certamente contribuirá para que a Universidade de Misag se torne cada vez melhor!\n        — Que a Chave de prata ilumine o seu caminho."
  },
  Mail_89902_Name = {
    Text = "Questionário de experiência da versão V2.2.1"
  },
  Mail_89902_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89903_Desc = {
    Text = "Prezado(a) Guardião:\n        Obrigado pelo seu apoio e reconhecimento a \"Véspera do Esquecimento\". Para proporcionar uma melhor experiência de jogo ao Guardião na Universidade de Misag, convidamos você a preencher o seguinte questionário de pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos \"Núcleo de prata\" × 200 como recompensa, que pode ser coletado após a conclusão do questionário. O prazo para preenchimento é 9 de novembro às 9:00. Por favor, preencha dentro do prazo.\n        <SurveyLink:[Clique aqui para preencher]>\n        Ouviremos atentamente as sugestões de cada Guardião, e o seu feedback certamente tornará a Universidade de Misag cada vez melhor!\n        — Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_89903_Name = {
    Text = "Questionário de experiência da versão V2.6.2"
  },
  Mail_89903_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89904_Desc = {
    Text = "Caro Guardião: \n        Agradecemos pelo seu apoio e reconhecimento ao \"Esquecimento\". Para proporcionar uma melhor experiência de jogo aos guardiões na Universidade de Misag, convidamos você a preencher o seguinte questionário de experiência. Como forma de agradecimento pela sua colaboração, preparamos um prêmio de \"Núcleo de prata\" × 200, que pode ser coletado ao concluir o questionário. O prazo para submissão do questionário é até 23 de fevereiro às 9:00, por favor, preencha-o a tempo. \n        <SurveyLink:\"Clique aqui para preencher\"> \n        Iremos ouvir atentamente as sugestões de cada Guardião, e seu feedback certamente fará a Universidade de Misag cada vez melhor! \n        — Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_89904_Name = {
    Text = "Questionário de experiência da versão V2.4.2"
  },
  Mail_89904_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89905_Desc = {
    Text = "Caro Guardião:\n        Agradecemos pelo seu apoio e reconhecimento ao [Morimens]. Para melhorar a experiência dos Guardiões na Universidade de Mythag, convidamos você a preencher a seguinte pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos Prata × 200 como recompensa, que você poderá resgatar ao concluir o questionário. O prazo para preenchimento termina em 8 de junho às 9:00, por favor, não deixe para depois.\n        <SurveyLink:【Clique aqui para acessar】>\n        Levaremos em consideração cada sugestão dos Guardiões. Sua opinião certamente fará a Universidade de Mythag ficar cada vez melhor!\n        —Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_89905_Name = {
    Text = "Questionário de Experiência da Versão V2.5.1"
  },
  Mail_89905_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89906_Desc = {
    Text = "Caro Guardião:\n        Obrigado pelo seu apoio e reconhecimento ao \"Morimens\". Para melhorar a experiência de jogo dos Guardiões na Universidade Mythag, convidamo-lo sinceramente a preencher o seguinte questionário de experiência. Como agradecimento pela sua participação, preparamos 【200 Núcleos de Prata】 como recompensa, que poderá ser resgatada após concluir o questionário. O prazo para preenchimento termina no dia 22 de dezembro às 9:00, por favor, não deixe para a última hora.\n        <SurveyLink:【Clique aqui para acessar】>\n        Levaremos em consideração atentamente cada sugestão dos Guardiões. Seu feedback certamente fará a Universidade Mythag melhorar cada vez mais!\n        —Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_89906_Name = {
    Text = "Questionário de Experiência da Versão V2.4.0"
  },
  Mail_89906_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89907_Desc = {
    Text = "Prezado Guardião:\n        Agradecemos pelo seu apoio e reconhecimento ao \"Morimens\". Para oferecer uma melhor experiência de jogo aos Guardiões da Universidade de Mythag, convidamos sinceramente você a preencher a seguinte pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos 【200 chips de prata】como recompensa, que poderão ser reivindicados após a conclusão do questionário. O prazo para preenchimento termina em 19 de janeiro às 9:00, por favor, não deixe para depois.\n        <SurveyLink:【Clique aqui para acessar】>\n        Levaremos a sério cada sugestão dos Guardiões. Seu feedback certamente fará a Universidade de Mythag melhorar cada vez mais!\n        —Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_89907_Name = {
    Text = "Questionário de experiência da versão V2.4.1"
  },
  Mail_89907_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89908_Desc = {
    Text = "Caro Guardião: \n        Agradecemos o seu apoio e reconhecimento ao [Morimens]. Para melhorar a experiência dos Guardiões na Universidade de Mythag, convidamos você a preencher o seguinte questionário de experiência. Como agradecimento pela sua participação, preparamos Prata × 200 como recompensa; basta completar o questionário para recebê-los. O prazo para conclusão do questionário é dia 20 de julho às 9:00, por favor, preencha a tempo. \n        <SurveyLink:[Clique aqui para preencher]>\n        Levaremos em consideração cuidadosamente cada sugestão dos Guardiões e seus comentários certamente farão a Universidade de Mythag melhorar cada vez mais! \n        —Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_89908_Name = {
    Text = "Questionário de Experiência da Versão V2.5.2"
  },
  Mail_89908_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89909_Desc = {
    Text = "Prezado Guardião:\n        Agradecemos pelo seu apoio e reconhecimento ao [Morimens]. Para oferecer a você, Guardião, uma melhor experiência no jogo da Universidade Mythag, convidamo-lo sinceramente a preencher a seguinte pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos Prata × 200 como recompensa, que você poderá resgatar ao concluir o questionário. O prazo para preenchimento termina no dia 14 de setembro às 9:00, por favor, responda a tempo.\n        <SurveyLink:[Clique aqui para preencher]>\n        Levaremos a sério cada sugestão dos Guardiões. Seu feedback certamente fará a Universidade Mythag melhorar cada vez mais!\n        —Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_89909_Name = {
    Text = "Questionário de Experiência da Versão V2.6.0"
  },
  Mail_89909_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89910_Desc = {
    Text = "Caro Guardião, \n        Agradecemos pelo seu apoio e reconhecimento ao [Véspera do Esquecimento]. Para melhorar a experiência dos Guardiões na Universidade de Misag, convidamos você a preencher a seguinte pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos [Núcleo de prata*200] como recompensa; basta completar o questionário para recebê-los. O prazo para conclusão do questionário é 23 de junho às 9:00, por favor, preencha a tempo.\n       <SurveyLink:[Clique aqui para preencher]>\n        Levaremos a sério cada sugestão dos Guardiões. Seu feedback certamente fará a Universidade de Misag melhorar cada vez mais!\n        — Que a Chave de prata ilumine o seu caminho."
  },
  Mail_89910_Name = {
    Text = "Questionário de Experiência da Versão V2.2.2"
  },
  Mail_89910_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89911_Desc = {
    Text = "Caro Guardião,\n        Agradecemos seu apoio a \"Morimens\". Para oferecer uma melhor experiência aos Guardiões na Universidade de Mythag, convidamos você a preencher a seguinte pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos 【200 Chips de Prata】 como recompensa; basta completar a pesquisa para recebê-los. O prazo para conclusão da pesquisa é 8 de setembro às 9:00; por favor, preencha-a a tempo.\n        <SurveyLink:【Clique aqui para acessar】>\n        Levaremos a sério cada sugestão dos Guardiões. Seu feedback certamente fará a Universidade de Mythag melhorar cada vez mais!\n        ——Que a chave de prata nos guie."
  },
  Mail_89911_Name = {
    Text = "Questionário de Experiência da Versão V2.3.1"
  },
  Mail_89911_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89912_Desc = {
    Text = "Prezado Guardião,\n        Agradecemos pelo seu apoio a \"Morimens\". Para aprimorar a experiência dos Guardiões na Universidade de Mythag, convidamo-lo cordialmente a preencher o seguinte questionário de pesquisa. Em agradecimento à sua colaboração, preparamos 【200 chips de prata】 como recompensa — basta concluir o questionário para recebê-los. O prazo para preenchimento encerra-se em 11 de agosto às 9:00; pedimos que não deixe para última hora.\n        <SurveyLink:【Clique aqui para preencher】>\n        Ouviremos atentamente as sugestões de cada Guardião. Seu feedback certamente contribuirá para que a Universidade de Mythag continue melhorando cada vez mais!\n        ——Que a chave de prata guie seu caminho."
  },
  Mail_89912_Name = {
    Text = "Questionário de Experiência da Versão V2.3.0"
  },
  Mail_89912_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89913_Desc = {
    Text = "Prezado Guardião,\nAgradecemos pelo seu apoio a \"Morimens\". Para melhorar a experiência de jogo dos Guardiões na Universidade de Mythag, convidamos você gentilmente a preencher a seguinte pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos 【200 Chips de Prata】 como recompensa, que você poderá resgatar ao concluir o questionário. O prazo para preenchimento termina em 29 de setembro às 9:00, por favor, não deixe para depois.\n<SurveyLink:【Clique aqui para preencher a pesquisa】>\nLevaremos em consideração atentamente cada sugestão dos Guardiões. Seu feedback certamente fará a Universidade de Mythag melhorar cada vez mais!\n——Que a chave de prata guie seu caminho."
  },
  Mail_89913_Name = {
    Text = "Questionário de Experiência da Versão V2.3.2"
  },
  Mail_89913_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89914_Desc = {
    Text = "Prezado Guardião: \n        Agradecemos pelo seu apoio e reconhecimento ao [Morimens]. Para oferecer uma melhor experiência de jogo aos Guardiões na Universidade de Mythag, convidamo-lo gentilmente a preencher a seguinte pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos Prata × 200 como recompensa, que poderá ser resgatada após concluir o questionário. O prazo para preenchimento termina em 11 de maio às 9:00, por favor, não deixe para depois.\n        <SurveyLink:【Clique aqui para acessar】>\n        Levaremos a sério cada sugestão dos Guardiões. Seu feedback certamente fará a Universidade de Mythag melhorar cada vez mais!\n        —Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_89914_Name = {
    Text = "Questionário de Experiência da Versão V2.5.0"
  },
  Mail_89914_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89915_Desc = {
    Text = "Prezado Guardião:\n        Agradecemos pelo seu apoio e reconhecimento ao \"Morimens\". Para oferecer a você, Guardião, uma melhor experiência no jogo da Universidade Mythag, convidamos cordialmente que preencha a seguinte pesquisa de experiência. Como agradecimento pela sua colaboração, preparamos \"Prata\" × 200 como recompensa, que poderá ser resgatada após concluir o questionário. O prazo para preenchimento termina em 12 de outubro às 9:00, por favor, não deixe para depois.\n        <SurveyLink:【Clique aqui para acessar】>\n        Levaremos a sério cada sugestão dos Guardiões. Seu feedback certamente fará a Universidade Mythag cada vez melhor!\n        —Que a Chave de Prata ilumine o seu caminho."
  },
  Mail_89915_Name = {
    Text = "Questionário de Experiência da Versão V2.6.1"
  },
  Mail_89915_Sender = {
    Text = "Escritório de Assuntos Mythag"
  },
  Mail_89997_Desc = {
    Text = "Caro Guardião:  \nA atividade \"Um meio passo de distância·clon\" foi encerrada, agora converteremos as \"Peças de boneca\" restantes do guardião na proporção de \"Cupom de ouro rosa *40\" por cada unidade. Por favor, verifique."
  },
  Mail_89997_Name = {
    Text = "Recuperação de peças do boneco"
  },
  Mail_89997_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_90000_Desc = {
    Text = "Prezado Guardião do Segredo:  \nDe acordo com o seu excelente desempenho em \"Sombras que Espreitam o Reino Divino: Maré Anormal\", você receberá a seguinte recompensa. Por favor, não se esqueça de verificar.\n\n."
  },
  Mail_90000_Name = {
    Text = "Reemissão de recompensa por voucher de design de Roupa Fantasma"
  },
  Mail_90000_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_90015_Desc = {
    Text = "Caro guardião,\nA atividade do 1.5º aniversário foi encerrada. Agora converteremos os \"Vale de Roupa Fantástica Simples (Fase 1)\" restantes do guardião na proporção de 1 \"Convite do Incorpóreo\" por unidade. Por favor, lembre-se de verificar."
  },
  Mail_90015_Name = {
    Text = "Recuperação de cupom de criação de Roupa Fantasma Simples (Fase 1)"
  },
  Mail_90015_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_90231_Desc = {
    Text = "Caro guardião,\nA atividade \"Prisioneiro do Espelho\" foi encerrada. Agora converteremos os \"Livros de senso comum\", \"Livros de Matemática\" e \"Livros de literatura\" restantes do guardião na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Por favor, lembre-se de verificar."
  },
  Mail_90231_Name = {
    Text = "Recuperação de moeda do evento Prisioneiro da Imagem"
  },
  Mail_90231_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_91725_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"Cerimônia do Abismo·clon\" foi concluída, agora converteremos as \"Lágrimas do Sacerdote\", \"Sangue do adorador\" e \"Medula do Sacrificador\" restantes do guardião na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Lembre-se de verificar."
  },
  Mail_91725_Name = {
    Text = "Recuperação da moeda de evento do Sacrifício do Abismo"
  },
  Mail_91725_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_94424_Desc = {
    Text = "Prezado Guardião:\nA atividade \"A Grande Conquista\" foi concluída, e agora as \"Delicioso churrasco de Leão\" restantes do Guardião serão convertidas na proporção de cada unidade trocada por \"Cupom de ouro rosa\" × 40. Por favor, lembre-se de verificar."
  },
  Mail_94424_Name = {
    Text = "Recuperação de moeda do churrasco Leo delicioso"
  },
  Mail_94424_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_94425_Desc = {
    Text = "Caro guardião,\nA atividade \"Grande Conquista\" foi encerrada. Agora converteremos os \"Vale de Desenho de Roupa Fantástica Minimalista (2ª Edição)\" restantes do guardião na proporção de 1 \"Convite do Incorpóreo\" por cada unidade. Por favor, lembre-se de verificar."
  },
  Mail_94425_Name = {
    Text = "Recuperação do Cupom de Roupa Fantasma Simplificada (Fase 2)"
  },
  Mail_94425_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_94503_Desc = {
    Text = "Minha luz orientadora:  \n\nDesde que Castor e eu chegamos aqui, seu cuidado conosco tem sido como nos conceder uma nova vida. Agradecemos profundamente o bolo de aniversário que você preparou com tanto carinho. Pedimos desculpas por termos confundido os dois pássaros que você desenhou no bolo com borboletas, mas realmente amamos esse presente. Foi a primeira vez que recebemos um presente de aniversário vindo de outra pessoa.  \nTambém recebemos um cartão de felicitações da escola, através do Diretor Czort. O envelope branco tinha um selo dourado e requintado, e dentro estavam escritas as mais belas e calorosas felicitações. Este é realmente um lugar acolhedor; nunca antes em nossas vidas experimentamos um momento tão feliz assim.  \nPor favor, venha celebrar conosco, Castor e eu, este aniversário. Este é um ritual que mantemos desde a nossa infância. Como nossos benfeitores, também preparamos um presente para você, uma coroa tecida com as penas que Castor perdeu.  \nOfereço-lhe esta humilde coroa, como símbolo de nossa profunda admiração. Prometo segui-lo(a) pelo resto da minha vida, trabalhando para realizar a grandiosa visão desta instituição e eliminar o verdadeiro mal e a escuridão.  \nJá faz muito tempo que não fazia algo assim, e Castor ainda brincou dizendo que minha habilidade não é mais tão boa quanto na infância. Espero que você não se importe.  \n\nPólux"
  },
  Mail_94503_Name = {
    Text = "Coroa de Penas..."
  },
  Mail_94503_Sender = {Text = "Pollux"},
  Mail_95382_Desc = {
    Text = "O adorável pequeno: \n\nPequeno, hoje é o dia da minha chegada. \nNão como uma bola de fogo que queima incessantemente, mas como o aniversário da garota chamada Kittygura. \nDe acordo com os costumes de minha vida anterior, neste dia teremos um grande banquete, desfrutando de vinho e carne assada à vontade. \nClaro, sempre há algum garoto travesso que não percebe o clima e provoca que estou mais velha, então eu os cumprimentei com um soco na cabeça. \nE agora, esta festa ganhou uma nova função, para nós relembrarmos os tempos passados. \nEste ano, planejo adicionar uma atividade, que é — caçar nosso pequeno! \nVocê sabe, estou ansiosa para te capturar em meu banquete, decorando-o com sua adorável expressão tímida, seu olhar sonolento e meio embriagado, e o aroma doce que emana de você. Isso será o melhor presente de aniversário que já recebi desde que nasci! \nAgora, já é tarde para começar a planejar a fuga, porque quando você ler esta carta... eu já estou à sua porta. \nNão tenha medo, pequeno, se tudo correr bem, você só ouvirá as melhores histórias e degustará os pratos mais deliciosos aqui. \nClaro, para a pequena criatura capturada, é normal que alguns imprevistos aconteçam, certo? \nVenha comigo, pequeno, sua bela noite está destinada a ser passada comigo. \n\nKittygura"
  },
  Mail_95382_Name = {
    Text = "A Festa do Tempo..."
  },
  Mail_95382_Sender = {Text = "Katie Gula"},
  Mail_95465_Desc = {
    Text = "Prezado Guardião:\n\"Manual do Detetive·clon\" atividade foi concluída, agora converteremos os \"Ficha decisiva\" restantes do Guardião na proporção de cada um trocando por \"Cupom de ouro rosa\" × 40, por favor, verifique."
  },
  Mail_95465_Name = {
    Text = "Recuperação de Chip"
  },
  Mail_95465_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_95875_Desc = {
    Text = "Caro guardião:\nA atividade \"Estética necrótica\" foi encerrada. Agora converteremos os \"Ossos Podres da Mão\" restantes do guardião na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Por favor, lembre-se de verificar."
  },
  Mail_95875_Name = {
    Text = "Recuperação de Mão em Decomposição"
  },
  Mail_95875_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_96012_Desc = {
    Text = "Caro guardião:\nA atividade \"A Queda da Luz Infinita\" foi encerrada. Agora converteremos os itens restantes do evento na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Por favor, lembre-se de verificar."
  },
  Mail_96012_Name = {
    Text = "Recuperação de balas"
  },
  Mail_96012_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_96323_Desc = {
    Text = "Senhor/a Guardião do Segredo: \n\nOs vivos celebram aniversários para encontrar significado em seus últimos dias. E eu apenas aproveito esta noite para tornar o aroma da morte ainda mais rico. \nAqueles que não lutam mais, que não têm mais obsessões, tiveram toda a sujeira de suas vidas lavada; seu arrependimento é como sal fino, que se dissolve entre as veias do sangue no momento exato do cozimento, criando um aroma úmido e suave. Seus ossos emitem um baixo estalo, a gordura que transborda de suas peles é delicada como a hortelã, e as palavras inacabadas em suas almas lentamente se libertam durante o cozimento, deixando um toque sutil de doçura. Eu já comecei a imaginar como você se tornaria uma coisa tranquila — o estalo crocante de sua pele se apertando diante do fogo, as emoções que se elevam entre carne e osso, a doce sensação de sua alma pura sendo gradualmente consumida... \nMas você é diferente. \nVocê ainda brilha, ainda pulsa, mas possui um aroma que nenhum morto pode igualar, hipnotizando todos ao seu redor. Você é o envelhecido que estou disposto a esperar; eu até espero que essa espera possa durar mais do que a eternidade. \nEm meio a esses inúmeros ciclos de anos, sua presença deu significado ao meu aniversário. Não é apenas sobre a maravilhosa refeição, mas também sobre a vida que ainda pulsa dentro de você. \n\nDoresain"
  },
  Mail_96323_Name = {
    Text = "Espera eterna..."
  },
  Mail_96323_Sender = {Text = "Dulesain"},
  Mail_97157_Desc = {
    Text = "Prezado Guardião:\n O evento \"Texto temporário\" foi concluído. Agora, as \"Tingimento da Realidade\", \"Tinta do Sonho Fantasmal\" e \"Infecção de Loucura\" restantes do Guardião serão convertidas na proporção de 40 \"Cupom de ouro rosa\" por unidade. Por favor, lembre-se de verificar."
  },
  Mail_97157_Name = {
    Text = "Recuperação de Cor"
  },
  Mail_97157_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_97707_Desc = {
    Text = "Caro guardião do segredo:\nA atividade \"Cerimônia de sacrifício do Nascimento Divino\" foi encerrada. Os \"Aromaterapia Calmante\", \"Aroma de Pesadelo\" e \"Aromaterapia dos Caçadores de Sonhos\" restantes serão convertidos na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Por favor, lembre-se de verificar."
  },
  Mail_97707_Name = {
    Text = "Recuperação de aromaterapia"
  },
  Mail_97707_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_97893_Desc = {
    Text = "Caro guardião:\nA atividade \"Se tudo como de costume\" foi encerrada. As \"Conchas de produtos locais da praia\" restantes serão convertidas na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Por favor, lembre-se de verificar."
  },
  Mail_97893_Name = {
    Text = "Recuperação de moeda do evento Delicioso churrasco Leo"
  },
  Mail_97893_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_97999_Desc = {
    Text = "Caro Guardião do Segredo:\nA atividade \"Sem doces, sem travessuras!\" foi encerrada. Os itens de sorteio restantes \"Doce de Abóbora Estranha\" serão convertidos na proporção de \"Líquido de Origem de Núcleo de Prata*60\" por unidade. Por favor, verifique suas recompensas, Guardião."
  },
  Mail_97999_Name = {
    Text = "Recuperação de Doce de Abóbora Estranha"
  },
  Mail_97999_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_98052_Desc = {
    Text = "Caro guardião:\nA atividade \"Porta dos Mil Fenômenos·clon\" foi encerrada. A moeda restante do evento \"Ponteiro final\" será recuperada e convertida em \"Cupom de ouro rosa\" na proporção de 1:40. Por favor, lembre-se de verificar."
  },
  Mail_98052_Name = {
    Text = "Reciclagem do Ponto Final"
  },
  Mail_98052_Sender = {
    Text = "Conselho da Universidade de Missaga"
  },
  Mail_98182_Desc = {
    Text = "Caro guardião:\nNa atualização V2.3.1, realizamos a recuperação padronizada das partículas de Ressonância excedentes. As partículas de Ressonância excedentes serão recuperadas e convertidas em \"Cupom de ouro rosa*5000\" na proporção de 1:5000. Por favor, verifique."
  },
  Mail_98182_Name = {
    Text = "V2.3.1 Partículas de ressonância excedentes - Recompensa de recuperação reenviada"
  },
  Mail_98182_Sender = {
    Text = "Escritório de Assuntos Mythag"
  }
})
return Text_Mail
