__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = "O nível de conhecimento proibido é igual ao nível do guardião e determina os efeitos das seguintes 3 profundidades de pesquisa. Se a média do nível dos corpos despertos na formação for maior ou igual ao nível do guardião, o nível de conhecimento proibido será a média entre o nível médio dos corpos despertos na formação e o nível do guardião. \n Profundidade de Pesquisa em Organismos Vivos: <Blue:{s1}> \n · Determina a intensidade do efeito em que cada 100 pontos de atributo de constituição do despertador se convertem em saúde da equipe. \n Profundidade de Pesquisa de Objetos: <Blue:{s2}> \n · Determina a intensidade dos efeitos de força, dano de tentáculo, escudo, recuperação de vida e redução de força causados por criações, gravuras e ordens de chave. \n Profundidade da Pesquisa da Consciência: <Blue:{s3}> \n · Determina a intensidade dos efeitos de envenenamento fixo, contra-ataque fixo, dano fixo e sangramento fixo causados por criações, gravuras e ordens de chave. \n"
  },
  ActorAttrType_121209_Text = {
    Text = "Nível de conhecimento proibido"
  },
  ActorAttrType_18103_Text = {
    Text = "Escudo do personagem"
  },
  ActorAttrType_18104_Text = {
    Text = "Correção do Percentual de Dano da Carta de Golpe"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "Dano Crítico +{s1}"
  },
  ActorAttrType_18105_Text = {
    Text = "Dano crítico"
  },
  ActorAttrType_18106_Text = {
    Text = "Escudo melhorado"
  },
  ActorAttrType_18107_AttributeUpText = {
    Text = "Ataque+{s1}"
  },
  ActorAttrType_18107_Text = {Text = "Ataque"},
  ActorAttrType_18108_Text = {
    Text = "Constituição"
  },
  ActorAttrType_18109_Text = {
    Text = "Ajuste da Porcentagem de Dano da Carta"
  },
  ActorAttrType_18110_Text = {
    Text = "Ajuste de Porcentagem Frágil"
  },
  ActorAttrType_18111_Text = {
    Text = "Ajuste da Porcentagem de Escudo Recebido"
  },
  ActorAttrType_18112_AttributeUpText = {
    Text = "Defesa + {s1}"
  },
  ActorAttrType_18112_Text = {
    Text = "Defesa aumentada"
  },
  ActorAttrType_18113_AttributeDesc = {
    Text = "Eficiência de carga de loucura do desperto"
  },
  ActorAttrType_18113_Text = {
    Text = "Fúria Inicial"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = "Quanto maior a constituição, maior será a saúde máxima do despertador.\nQuanto maior o nível de investigação do guardião, maior será a influência da constituição na saúde máxima do despertador"
  },
  ActorAttrType_18114_AttributeUpText = {
    Text = "Constituição+{s1}"
  },
  ActorAttrType_18114_Text = {
    Text = "Constituição"
  },
  ActorAttrType_18115_AttributeDesc = {
    Text = "Após o despertador liberar a chegada do gênesis, retorna-se o valor de loucura"
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "Redução de consumo de loucura +{s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "Redução do Consumo de Fúria"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = "Quanto maior a constituição, maior será a saúde máxima do despertador.\nQuanto maior o nível de investigação do guardião, maior será a influência da constituição na saúde máxima do despertador"
  },
  ActorAttrType_18116_AttributeUpText = {
    Text = "Constituição+{s1}"
  },
  ActorAttrType_18116_Text = {
    Text = "Aumento de Constituição"
  },
  ActorAttrType_18117_Text = {
    Text = "Dano de tentáculo"
  },
  ActorAttrType_18118_Text = {
    Text = "Número de Slots de Cartas Ultra"
  },
  ActorAttrType_18119_Text = {
    Text = "Correção do Percentual de Dano Recebido"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "O Limite de fúria máximo e o Consumo de Fúria da Fúria Explosiva do Corpo Desperto são ambos iguais ao seu Aliemus Base."
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "Limite de loucura +{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "Aliemus Base"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "Nível da Habilidade 2"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "Nível da Habilidade 2 +{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "Nível da Habilidade 2"
  },
  ActorAttrType_18122_AttributeDesc = {
    Text = "Nível de defesa"
  },
  ActorAttrType_18122_AttributeUpText = {
    Text = "Nível de Defesa+{s1}"
  },
  ActorAttrType_18122_Text = {
    Text = "Nível de defesa"
  },
  ActorAttrType_18123_Text = {
    Text = "Ajuste do valor fixo da contagem de dano"
  },
  ActorAttrType_18124_Text = {
    Text = "Causa modificação de valor fixo do escudo"
  },
  ActorAttrType_18125_Text = {
    Text = "Correção do Valor Fixo do Escudo"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = "A Maestria de Reino da equipe é igual à soma da Maestria de Reino de todos os Despertadores na equipe. A Maestria de Reino pode melhorar os efeitos do Legado de Reino da equipe. Se a equipe atual for \"Mar Tranquilo Puro/Caro Puro/Ultra Puro,\" o efeito da Maestria de Reino é dobrado.\n· Para equipes de Reino <Blue:Chaos>, a cada 1 ponto de Maestria de Reino, após liberar o Bando, todos os Despertadores ganham <Blue:0.05> pontos adicionais de Aliemus.\n· Para equipes de Reino <Blue:Aequor>, a cada 1 ponto de Maestria de Reino, há uma chance de <Blue:0.25%> de ganhar um stack adicional de Coleta de Tentáculos ao liberar Exaltar (chances acima de 100% podem conceder múltiplos stacks). Ao mudar para \"Mar Tranquilo,\" as quantidades de Escudo adquiridas aumentam em <Blue:0.01%> da Vida Máxima, e o dano de tentáculo causado por dano ativo em \"Ondas Furiosas\" aumenta em <Blue:0.02%> de Dano de Tentáculo.\n· Para equipes de Reino <Blue:Caro>, a cada 1 ponto de Maestria de Reino, o primeiro Devorar acionado a cada turno concede um Escudo adicional igual a <Blue:0.01%> da Vida Máxima e Força Temporária de <Blue:0.005%> (aumenta com base na Vida Perdida, até um máximo de 100%).\n· Para equipes de Reino <Blue:Ultra>, a cada 1 ponto de Maestria de Reino, no início do turno, há uma chance de <Blue:0.125%> de ganhar 1 \"Perspicácia\" (chances acima de 100% podem conceder cópias múltiplas)."
  },
  ActorAttrType_18126_AttributeUpText = {
    Text = "Maestria em Domínios +{s1}"
  },
  ActorAttrType_18126_Text = {
    Text = "Domínio de área"
  },
  ActorAttrType_18127_Text = {Text = "Vida"},
  ActorAttrType_18128_AttributeUpText = {
    Text = "Ataque+{s1}"
  },
  ActorAttrType_18128_Text = {
    Text = "Ataque aumentado"
  },
  ActorAttrType_18129_AttributeDesc = {
    Text = "Quanto maior o bônus de dano base, maior o dano causado pelo Despertado"
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "Dano base +{s1}"
  },
  ActorAttrType_18129_Text = {
    Text = "Dano básico"
  },
  ActorAttrType_18130_Text = {Text = "Nível"},
  ActorAttrType_18131_AttributeDesc = {
    Text = "No final do turno, a recuperação automática de Loucura dos Despertos (no modo de missão, a Loucura recuperada após cada ação dos Despertos)"
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "Recuperação automática de loucura +{s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "Resposta Automática de Fúria"
  },
  ActorAttrType_18132_Text = {
    Text = "Nível de Inspiração"
  },
  ActorAttrType_18133_Text = {
    Text = "Ajuste da Porcentagem de Fúria Recebida"
  },
  ActorAttrType_18134_Text = {
    Text = "Limite de Fusão de Embriões"
  },
  ActorAttrType_18135_Text = {
    Text = "Personagem com Fúria Atual"
  },
  ActorAttrType_18136_Text = {
    Text = "Ajuste do Valor Fixo de Dano Recebido"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "Ao aplicar escudo e efeitos de cura, aumente a proporção dos valores de escudo e cura"
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "Escudo e cura forte + {s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "Escudo e Cura Eficaz"
  },
  ActorAttrType_18138_Text = {
    Text = "Curação aumentada"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "Ao Disparar uma Carta de comando ou realizar um Despertar do Conhecimento Espiritual, obtém {s1} ponto(s) de Energia da Chave de Prata por cada 1 Poder de cálculo consumido. À medida que este atributo aumenta, o bônus adicional de Energia da Chave de Prata diminui gradualmente."
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "Recarga de chave de prata + {s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "Nível de Carga da Chave de Prata"
  },
  ActorAttrType_18140_Text = {
    Text = "Número de Resistências à Morte"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "Nível de golpe"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "Nível de ataque +{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "Nível de golpe"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "Aumente percentualmente o \"dano base\" causado por todos os despertos, o número de camadas de \"veneno de valor fixo\" e \"retaliação de valor fixo\" aplicadas, e o dano inicial dos tentáculos no Domínio do Mar Profundo."
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "Dano forte +{s1}"
  },
  ActorAttrType_18142_Text = {
    Text = "Dano potencializado"
  },
  ActorAttrType_18143_Text = {
    Text = "Ajuste do percentual de dano da Fúria Explosiva"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "Quando o corpo desperto causa dano ativo, a chance de resistir a um crítico"
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "Resistência a Crítico +{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "Resistência a golpes críticos"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "Gênesis Chegada Nível"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "Gênesis Chegada Nível +{s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "Gênesis Chegada Nível"
  },
  ActorAttrType_18146_Text = {
    Text = "Correção do Valor Fixo de Cura"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "Taxa de impressão afortunada +{s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "Taxa de Gravura da Sorte"
  },
  ActorAttrType_18148_Text = {
    Text = "Causa ajuste de valor de cura fixo"
  },
  ActorAttrType_18149_Text = {
    Text = "Aumento de Constituição"
  },
  ActorAttrType_18150_Text = {
    Text = "Ajuste de Porcentagem de Fraqueza"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = "A resistência à morte da equipe é igual à soma da resistência à morte dos Corpos Despertos na equipe. \n Quando receber dano fatal durante a batalha, há uma chance de preservar 1 ponto de vida; após a ativação, ganha 2 pontos de Poder de cálculo e compra 2 cartas na próxima rodada. A resistência à morte adquirida atualmente e posteriormente é reduzida pela metade, durando até o final da investigação."
  },
  ActorAttrType_18151_AttributeUpText = {
    Text = "Resistência à Morte +{s1}"
  },
  ActorAttrType_18151_Text = {
    Text = "Resistência à Morte"
  },
  ActorAttrType_18152_Text = {
    Text = "Causa Ajuste de Percentual de Fúria"
  },
  ActorAttrType_18154_Text = {
    Text = "Limite de tentáculos"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = "Aumenta em percentual a quantidade de sigilo negro que cai após vitória em batalhas"
  },
  ActorAttrType_18155_AttributeUpText = {
    Text = "Sigilo Negro Caiu+{s1}"
  },
  ActorAttrType_18155_Text = {
    Text = "Queda de marca negra"
  },
  ActorAttrType_18156_Text = {
    Text = "Receber Ajuste de Valor Fixo de Fúria"
  },
  ActorAttrType_18157_Text = {
    Text = "Ocultar a intenção"
  },
  ActorAttrType_18158_Text = {
    Text = "Ajuste do valor fixo de dano"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "Taxa crítica +{s1}"
  },
  ActorAttrType_18159_Text = {
    Text = "Taxa de Crítico"
  },
  ActorAttrType_18160_AttributeDesc = {
    Text = "Nível da Habilidade 1"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "Nível da Habilidade 1 +{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "Nível da Habilidade 1"
  },
  ActorAttrType_18161_Text = {Text = "Nível"},
  ActorAttrType_18162_Text = {
    Text = "Dano aumentado"
  },
  ActorAttrType_18163_Text = {
    Text = "Número de tentáculos"
  },
  ActorAttrType_18164_Text = {
    Text = "Modificador de Porcentagem de Cura Recebida"
  },
  ActorAttrType_18165_Text = {
    Text = "Potência de cálculo máxima"
  },
  ActorAttrType_18166_Text = {
    Text = "Ajuste do Percentual de Vulnerável"
  },
  ActorAttrType_18167_AttributeUpText = {
    Text = "Defesa + {s1}"
  },
  ActorAttrType_18167_Text = {Text = "Defesa"},
  ActorAttrType_18168_AttributeDesc = {
    Text = "Nível de Despertar da Gnosis"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "Nível de Despertar Espiritual +{s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "Nível de Despertar da Gnosis"
  },
  ActorAttrType_21322_Text = {
    Text = "Recarregar Chave de Prata"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "A cada vez que liberar uma explosão de loucura, receba {s1} pontos de loucura. À medida que esse atributo aumenta, o efeito adicional gradualmente diminuirá"
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "Nível de recarga de loucura +{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "Nível de Recarga de Fúria"
  },
  ActorAttrType_22214_Text = {
    Text = "Recarga de raiva"
  }
})
return Text_ActorAttrType
