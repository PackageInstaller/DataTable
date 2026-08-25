__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TrinketSuitEffect = readonly({
  TrinketSuitEffect_18335_Name = {
    Text = "Canto a abril"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_1 = {
    Text = "Dano Crítico +7,2%"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Team unique>: No início do turno, se o hp total dos inimigos estiver acima de 75%, a taxa de crítico temporária do portador e o dano crítico aumentam em +35%."
  },
  TrinketSuitEffect_18336_Name = {
    Text = "Poema Circular (Incompleto)"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_1 = {
    Text = "Resistência à Morte +16.8%"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_2 = {
    Text = "Após o início do turno par, reduza o custo de aritmética de uma carta aleatória em 1"
  },
  TrinketSuitEffect_18337_Name = {
    Text = "Linha de retorno ao mar"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_1 = {
    Text = "Maestria em Domínios +12"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Team unique>: No início da batalha, ganha força equivalente a 12% do ataque do portador. Se o reino atual for Aequor, o efeito muda para ter uma (50+0.25*domínio do reino da equipe)% de chance de ganhar 1 camada de coleta de tentáculos no início de cada turno; se exceder 100%, múltiplas camadas podem ser ganhas, e a chance é dobrada em batalhas contra chefes."
  },
  TrinketSuitEffect_18338_Name = {
    Text = "Coelho Amaldiçoado"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_1 = {
    Text = "Maestria em Domínios +12"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_2 = {
    Text = "O escudo e a recuperação de vida do portador aumentam em 12%"
  },
  TrinketSuitEffect_18339_Name = {Text = "Antinomia"},
  TrinketSuitEffect_18339_SuitEffectDesc_1 = {
    Text = "Nível de recarga de chave de prata +7.2"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Equipe Única>: O Aliemus Base do portador aumenta em +20. A Taxa de Crítico, Dano crítico, Escudo do personagem e Recuperar vida das Cartas de comando do portador aumentam em 20%."
  },
  TrinketSuitEffect_18340_Name = {
    Text = "Forma orgânica"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_1 = {
    Text = "Sigilo Negro Caiu +3.6%"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Equipe única>. No início da exploração, deduza até 100% de resistência à morte. Para cada 1% de resistência à morte deduzido, aumente o dano da loucura do portador em 0,15%."
  },
  TrinketSuitEffect_18341_Name = {
    Text = "Pulsação Escarlate"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_1 = {
    Text = "Dano Crítico +7,2%"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_2 = {
    Text = "Após liberar a chave, o portador ganha 30% de taxa crítica temporária"
  },
  TrinketSuitEffect_18342_Name = {
    Text = "Padrão Mystik SSR"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_1 = {
    Text = "Resistência à Morte +16.8%"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_2 = {
    Text = "O dano, cura e escudo causado pelo equipador aumentam em 15%"
  },
  TrinketSuitEffect_18343_Name = {
    Text = "Pacto padrão R"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_1 = {
    Text = "Resistência à Morte +16.8%"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_2 = {
    Text = "O dano, cura e escudo causado pelo equipador aumentam em 15%"
  },
  TrinketSuitEffect_18344_Name = {
    Text = "Descida Mecânica"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_1 = {
    Text = "Maestria em Domínios +12"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_2 = {
    Text = "No primeiro turno de cada batalha, ganha 1 ponto de aritmética; em batalhas contra chefes, ganha 1 ponto de aritmética a cada 4 turnos"
  },
  TrinketSuitEffect_18345_Name = {
    Text = "Cerimônia de Fotossíntese"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_1 = {
    Text = "Amplificação de Dano +7,2%"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Equipe Única>: Após a Carta de comando do portador entrar no Espaço Hiperdimensional, a Fusão de embriões aumenta em +25~50. Quanto menor a vida atual, maior será o aumento da Fusão de embriões."
  },
  TrinketSuitEffect_18346_Name = {
    Text = "Reevolução"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_1 = {
    Text = "Nível de recarga de loucura +2.4"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Equipe única>: No início da exploração, o portador ganha 35 aliemus. Depois que o portador usa exalt, ele ganha 2 aliemus ao final de cada turno nesta batalha, acumulando até 3 vezes."
  },
  TrinketSuitEffect_18347_Name = {
    Text = "Drenagem de Vitalidade"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_1 = {
    Text = "Nível de recarga de chave de prata +7.2"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Equipe Única>: Ao final do turno, ganha Energia de chave equivalente a 200% da Recarregar Chave de Prata do portador. Se o Domínio atual for \"Carne e sangue\", o Efeito muda para: para cada 5 pontos de Recarregar Chave de Prata, Fusão de embriões +1."
  },
  TrinketSuitEffect_18348_Name = {
    Text = "Sonho da medicina"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_1 = {
    Text = "Dano forte +4.8%"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Equipe única>. No final da batalha, ganhe -8 sigilos negros; no início da batalha, embaralhe uma cópia base dos cartões de comando de defesa não ofensivos do portador no monte de compra, no máximo 1 de cada."
  },
  TrinketSuitEffect_18349_Name = {Text = "Slime Doce"},
  TrinketSuitEffect_18349_SuitEffectDesc_1 = {
    Text = "Resistência à Morte +25,2%"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_2 = {
    Text = "Equipe Única. Se \"Aniquilação\" for desencadeada e a Postura de Tentáculo for alternada dentro de 1 turno, o Escudo do personagem, Recuperar e Dano Final do portador +25% neste turno, com um intervalo de 3 turnos."
  },
  TrinketSuitEffect_18350_Name = {
    Text = "Gato do teatro (incompleto)"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_1 = {
    Text = "Resistência à Morte +16.8%"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_2 = {
    Text = "Dano do portador em inimigos com mais de 75% de vida é sempre crítico"
  },
  TrinketSuitEffect_18351_Name = {
    Text = "Anel das 36 Salas"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_1 = {
    Text = "Nível de recarga de loucura +2.4"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Equipe única>. Aumente o limite de energia da chave prateada e o custo do brilho da chave em +200; aumente a taxa crítica de exalt do portador, dano crítico, escudo e recuperação de hp em 30%."
  },
  TrinketSuitEffect_18352_Name = {
    Text = "Gêmeos Distorcidos·Branco"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_1 = {
    Text = "Resistência à Morte +16.8%"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_2 = {
    Text = "Após o início do turno par, adicione a \"Defesa\" de um portador com <NothingnessIconKeywords:Nada> e <DepleteIconKeywords:Consumo> à mão."
  },
  TrinketSuitEffect_18353_Name = {
    Text = "Abraço Escarlate"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_1 = {
    Text = "Taxa crítica +4,8%"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_2 = {
    Text = "Ao causar dano, o equipador ganha 35 pontos de s-energia; se causar dano crítico, isso é alterado para 70 pontos de s-energia, podendo ser ativado no máximo 3 vezes por turno"
  },
  TrinketSuitEffect_18354_Name = {
    Text = "Pacto padrão SR"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_1 = {
    Text = "Resistência à Morte +16.8%"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_2 = {
    Text = "O dano, cura e escudo causado pelo equipador aumentam em 15%"
  },
  TrinketSuitEffect_18355_Name = {
    Text = "Apocalipse Imaculado"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_1 = {
    Text = "Nível de recarga de chave de prata +7.2"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Equipe única>: Após liberar uma turma, recupere hp equivalente a 12% do con do portador, com efeitos aumentando proporcionalmente ao hp perdido, até um máximo de 24% do con do portador."
  },
  TrinketSuitEffect_18356_Name = {
    Text = "Lobo das estepes"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_1 = {
    Text = "Dano forte +4.8%"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_2 = {
    Text = "O dano básico causado pelo portador aumenta em 20%, e o <IntoxicationIconKeywords:veneno> e <RetaliateIconKeywords:balcão> causados aumentam em 10%"
  },
  TrinketSuitEffect_18357_Name = {
    Text = "Festa Distante"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_1 = {
    Text = "Sigilo Negro Caiu +3.6%"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_2 = {
    Text = "No início da exploração, ganhe 10 Sigilos Negros. A \"Defesa\" do equipador aumenta o Escudo em 60%."
  },
  TrinketSuitEffect_18358_Name = {
    Text = "Gêmeos Distorcidos·preto"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_1 = {
    Text = "Taxa crítica +4,8%"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_2 = {
    Text = "No início dos turnos ímpares, adicione uma \"golpe\" do portador contendo <NothingnessIconKeywords:ilusão> e <DepleteIconKeywords:exausto> à mão"
  },
  TrinketSuitEffect_18359_Name = {
    Text = "Crisálida da jovem"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_1 = {
    Text = "Taxa Crítica +7,2%"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_2 = {
    Text = "Equipe Única. O portador ganha 8% de Dano Crítico Temporário para cada tentáculo após consumir um embrião pela primeira vez em cada turno, até 80%."
  },
  TrinketSuitEffect_18360_Name = {
    Text = "Sussurros do Cemitério"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_1 = {
    Text = "Resistência à Morte +16.8%"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_2 = {
    Text = "No início da fase, <DeathResistanceIconKeywords:resistência à morte> aumenta em 25%. Após ativar a resistência à morte, o portador ganha 50 pontos de loucura"
  },
  TrinketSuitEffect_99234_Name = {Text = "humus"},
  TrinketSuitEffect_99234_SuitEffectDesc_1 = {
    Text = "Texto temporário"
  },
  TrinketSuitEffect_99234_SuitEffectDesc_2 = {
    Text = "Texto temporário"
  },
  TrinketSuitEffect_99235_Name = {Text = "Ascensão"},
  TrinketSuitEffect_99235_SuitEffectDesc_1 = {
    Text = "Texto temporário"
  },
  TrinketSuitEffect_99235_SuitEffectDesc_2 = {
    Text = "Texto temporário"
  },
  TrinketSuitEffect_99236_Name = {Text = "Estige"},
  TrinketSuitEffect_99236_SuitEffectDesc_1 = {
    Text = "Texto temporário"
  },
  TrinketSuitEffect_99236_SuitEffectDesc_2 = {
    Text = "Texto temporário"
  }
})
return Text_TrinketSuitEffect
