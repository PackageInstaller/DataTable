__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_EnchantConfig = readonly({
  EnchantConfig_119927_Desc = {
    Text = "Ha effetto [Arg1] volte in più. <DepleteIconKeywords:Consumo>. <RippleKeywords:Onda d'Urto Residua>: Pesca 2 carte."
  },
  EnchantConfig_119927_Name = {
    Text = "<BlueQuality:Eco dell'Abisso>"
  },
  EnchantConfig_18169_Desc = {
    Text = "Quando giocata, recupera [Arg1] Arithmetica."
  },
  EnchantConfig_18169_Name = {
    Text = "<WhiteQuality:Calcolo>"
  },
  EnchantConfig_18170_Desc = {
    Text = "Quando giocata, ottieni [Arg1] <RetaliateIconKeywords:Contrattacco>, poi infliggi Danni Veri a tutti i nemici pari al [Arg2]% del tuo <RetaliateIconKeywords:Contrattacco>."
  },
  EnchantConfig_18170_Name = {
    Text = "<OrangeQuality:Av. Spina>"
  },
  EnchantConfig_18171_Desc = {
    Text = "La carta incisa ha <DepleteIconKeywords:Consumo> e <GuyouKeywords:Innato>. Quando giocata, ha effetto [Arg1] volte aggiuntive e ricevi [Arg2] Sigilli Neri."
  },
  EnchantConfig_18171_Name = {
    Text = "<OrangeQuality:Av. Eco>"
  },
  EnchantConfig_18172_Desc = {
    Text = "Dopo averla giocata, fa perdere a tutti i nemici [Arg1] punti di <PowerIconKeywords:Potere> Temporaneo."
  },
  EnchantConfig_18172_Name = {
    Text = "<WhiteQuality:Esaurimento>"
  },
  EnchantConfig_18173_Desc = {
    Text = "Quando giocata, <EmbryoFusionIconKeywords:Fusione Embrionale> +[Arg1]."
  },
  EnchantConfig_18173_Name = {
    Text = "<OrangeQuality:Av. Sete di Sangue>"
  },
  EnchantConfig_18174_Desc = {
    Text = "Quando giocata, infliggi [Arg1] turni di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici."
  },
  EnchantConfig_18174_Name = {
    Text = "<OrangeQuality:Av. Vulnerabile>"
  },
  EnchantConfig_18175_Desc = {
    Text = "Quando giocata, attiva [Arg1] Attacchi del tentacolo."
  },
  EnchantConfig_18175_Name = {
    Text = "<OrangeQuality:Dominio Avanzato>"
  },
  EnchantConfig_18176_Desc = {
    Text = "Quando giocata, attiva [Arg1] Attacchi del tentacolo."
  },
  EnchantConfig_18176_Name = {
    Text = "<WhiteQuality:Dominio>"
  },
  EnchantConfig_18177_Desc = {
    Text = "Pesca [Arg1] carte."
  },
  EnchantConfig_18177_Name = {
    Text = "<OrangeQuality:Av. Destrezza>"
  },
  EnchantConfig_18178_Desc = {
    Text = "All'inizio di ogni battaglia, mischia [Arg1] copie base della carta incisa nel Mazzo di Pesca. Sia la carta incisa che le copie da essa create hanno <RetainIconKeywords:Conservare>."
  },
  EnchantConfig_18178_Name = {
    Text = "<OrangeQuality:Specchio Avanzato>"
  },
  EnchantConfig_18179_Desc = {
    Text = "Quando giocata, ottieni [Arg1] <PowerIconKeywords:FOR> dopo la risoluzione dei suoi effetti."
  },
  EnchantConfig_18179_Name = {
    Text = "<OrangeQuality:Potenza Avanzata>"
  },
  EnchantConfig_18180_Desc = {
    Text = "Quando giocata, aumenta l'Aliemus del suo Risvegliato di <Energy:[Arg1]>."
  },
  EnchantConfig_18180_Name = {
    Text = "<OrangeQuality:Furia Avanzata>"
  },
  EnchantConfig_18181_Desc = {
    Text = "Quando giocata, infliggi [Arg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici, poi attiva il [Arg2]% del <IntoxicationIconKeywords:Veleno> di ciascun nemico."
  },
  EnchantConfig_18181_Name = {
    Text = "<OrangeQuality:Av. Tossina>"
  },
  EnchantConfig_18182_Desc = {
    Text = "Dopo averla giocata, Mischia [Arg1] carte <DerivativeCardKeywords_4:\"Ispirazione\"> nel Mazzo di Pesca. \"Ispirazione - Ottieni 1 Arithmetica. Pesca 1 carta, <RetainIconKeywords:Conservare>, <DepleteIconKeywords:Consumare>.\""
  },
  EnchantConfig_18182_Name = {
    Text = "<WhiteQuality:Intuizione>"
  },
  EnchantConfig_18183_Desc = {
    Text = "Quando giocata, infliggi [Arg1] turni di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici."
  },
  EnchantConfig_18183_Name = {
    Text = "<WhiteQuality:Vulnerabile>"
  },
  EnchantConfig_18184_Desc = {
    Text = "Quando giocata, ottieni <Block:[Arg1]> Scudo del Personaggio."
  },
  EnchantConfig_18184_Name = {
    Text = "<OrangeQuality:Bastione Avanzato>"
  },
  EnchantConfig_18185_Desc = {
    Text = "Quando giocata, infliggi [Arg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici, poi attiva il [Arg2]% del <IntoxicationIconKeywords:Veleno> di ciascun nemico."
  },
  EnchantConfig_18185_Name = {
    Text = "<WhiteQuality:Tossina>"
  },
  EnchantConfig_18186_Desc = {
    Text = "All'inizio di ogni battaglia, mischia [Arg1] copie base della carta incisa nel Mazzo di Pesca. Sia la carta incisa che le copie da essa create hanno <RetainIconKeywords:Conservare>."
  },
  EnchantConfig_18186_Name = {
    Text = "<WhiteQuality:Specchio>"
  },
  EnchantConfig_18187_Desc = {
    Text = "Quando giocata, ottieni prima [Arg1] <PowerIconKeywords:FOR> Temporanea, poi risolvi gli effetti della carta."
  },
  EnchantConfig_18187_Name = {
    Text = "<OrangeQuality:Esplosione Avanzata>"
  },
  EnchantConfig_18188_Desc = {
    Text = "Pesca [Arg1] carte."
  },
  EnchantConfig_18188_Name = {
    Text = "<WhiteQuality:Finezza>"
  },
  EnchantConfig_18189_Desc = {
    Text = "Dopo averla giocata, Mischia [Arg1] carte <DerivativeCardKeywords_4:\"Ispirazione\"> nel Mazzo di Pesca. \"Ispirazione - Ottieni 1 Arithmetica. Pesca 1 carta, <RetainIconKeywords:Conservare>, <DepleteIconKeywords:Consumare>.\""
  },
  EnchantConfig_18189_Name = {
    Text = "<OrangeQuality:Av. Intuizione>"
  },
  EnchantConfig_18190_Desc = {
    Text = "Quando giocata, infliggi [Arg1] turni di <WeaknessIconKeywords:Debolezza> a tutti i nemici."
  },
  EnchantConfig_18190_Name = {
    Text = "<OrangeQuality:Debolezza Avanzata>"
  },
  EnchantConfig_18191_Desc = {
    Text = "Quando giocata, <EmbryoFusionIconKeywords:Fusione Embrionale> +[Arg1]."
  },
  EnchantConfig_18191_Name = {
    Text = "<WhiteQuality:Sete di Sangue>"
  },
  EnchantConfig_18192_Desc = {
    Text = "Quando giocata, infliggi [Arg1] turni di <WeaknessIconKeywords:Debolezza> a tutti i nemici."
  },
  EnchantConfig_18192_Name = {
    Text = "<WhiteQuality:Debolezza>"
  },
  EnchantConfig_18193_Desc = {
    Text = "Dopo averla giocata, fa perdere a tutti i nemici [Arg1] punti di <PowerIconKeywords:Potere> Temporaneo."
  },
  EnchantConfig_18193_Name = {
    Text = "<OrangeQuality:Esaurimento Avanzato>"
  },
  EnchantConfig_18194_Desc = {
    Text = "Quando giocata, aggiungi [Arg1] copie di essa negli slot Temporanei di <DimensionalSpaceIconKeywords:Spazio Ultra>."
  },
  EnchantConfig_18194_Name = {
    Text = "<OrangeQuality:Av. Distorsione>"
  },
  EnchantConfig_18195_Desc = {
    Text = "Quando giocata, ottieni [Arg1] <PowerIconKeywords:FOR> dopo la risoluzione dei suoi effetti."
  },
  EnchantConfig_18195_Name = {
    Text = "<WhiteQuality:Potenza>"
  },
  EnchantConfig_18196_Desc = {
    Text = "Quando giocata, ottieni <Block:[Arg1]> Scudo del Personaggio."
  },
  EnchantConfig_18196_Name = {
    Text = "<WhiteQuality:Bastion>"
  },
  EnchantConfig_18197_Desc = {
    Text = "Quando giocata, recupera [Arg1] Arithmetica."
  },
  EnchantConfig_18197_Name = {
    Text = "<OrangeQuality:Calcolo Avanzato>"
  },
  EnchantConfig_18198_Desc = {
    Text = "Quando giocata, aumenta l'Aliemus di tutti gli altri Risvegliati di <Energy:[Arg1]>."
  },
  EnchantConfig_18198_Name = {
    Text = "<OrangeQuality:Av. Catalisi>"
  },
  EnchantConfig_18199_Desc = {
    Text = "Quando giocata, ottieni [Arg1] <RetaliateIconKeywords:Contrattacco>, poi infliggi Danni Veri a tutti i nemici pari al [Arg2]% del tuo <RetaliateIconKeywords:Contrattacco>."
  },
  EnchantConfig_18199_Name = {
    Text = "<WhiteQuality:Spina>"
  },
  EnchantConfig_18200_Desc = {
    Text = "La carta incisa ha <DepleteIconKeywords:Consumo> e <GuyouKeywords:Innato>. Quando giocata, ha effetto [Arg1] volte aggiuntive e ricevi [Arg2] Sigilli Neri."
  },
  EnchantConfig_18200_Name = {
    Text = "<WhiteQuality:Eco>"
  },
  EnchantConfig_18201_Desc = {
    Text = "Quando giocata, aumenta l'Aliemus del suo Risvegliato di <Energy:[Arg1]>."
  },
  EnchantConfig_18201_Name = {
    Text = "<WhiteQuality:Berserk>"
  },
  EnchantConfig_18202_Desc = {
    Text = "Quando giocata, ottieni prima [Arg1] <PowerIconKeywords:FOR> Temporanea, poi risolvi gli effetti della carta."
  },
  EnchantConfig_18202_Name = {
    Text = "<WhiteQuality:Esplosione>"
  },
  EnchantConfig_18203_Desc = {
    Text = "Quando giocata, aumenta l'Aliemus di tutti gli altri Risvegliati di <Energy:[Arg1]>."
  },
  EnchantConfig_18203_Name = {
    Text = "<WhiteQuality:Catalizzatore>"
  },
  EnchantConfig_18204_Desc = {
    Text = "Quando giocata, aggiungi [Arg1] copie di essa negli slot Temporanei di <DimensionalSpaceIconKeywords:Spazio Ultra>."
  },
  EnchantConfig_18204_Name = {
    Text = "<WhiteQuality:Distorsione>"
  },
  EnchantConfig_48006_Desc = {
    Text = "Si attiva 2 volte quando viene giocata per la prima volta in ogni turno."
  },
  EnchantConfig_48006_Name = {
    Text = "<WhiteQuality:Ensemble>"
  },
  EnchantConfig_48007_Desc = {
    Text = "Il primo colpo di ogni turno ha effetto 3 volte."
  },
  EnchantConfig_48007_Name = {
    Text = "<WhiteQuality:Av. Ensemble>"
  },
  EnchantConfig_49108_Desc = {
    Text = "Carta ottenuta <RetainIconKeywords:Conservare>, se In Mano a fine turno, ottieni una Copia Base con <RetainIconKeywords:Conservare> e <DepleteIconKeywords:Consumo>."
  },
  EnchantConfig_49108_Name = {
    Text = "<WhiteQuality:Nascita>"
  },
  EnchantConfig_59530_Desc = {
    Text = "All'utilizzo, scarta tutte le carte In Mano che non appartengono a questo Risvegliatore. Ottieni 5 carte non di comando. Ha effetto una volta per battaglia."
  },
  EnchantConfig_59530_Name = {
    Text = "<OrangeQuality:Lex Volis>"
  },
  EnchantConfig_59531_Desc = {
    Text = "Gioca per pescare 2 carte, il loro Costo di Arithmetica riduce il consumo effettivo delle carte Orazione, efficace solo una volta per battaglia."
  },
  EnchantConfig_59531_Name = {
    Text = "<OrangeQuality:Lex Nous>"
  },
  EnchantConfig_59532_Desc = {
    Text = "Dopo averla giocata, ottieni 3 Copie Base con <RetainIconKeywords:Conservare> e <DepleteIconKeywords:Consumo> applicati. Ha effetto una volta per battaglia."
  },
  EnchantConfig_59532_Name = {
    Text = "<OrangeQuality:Lex Genis>"
  },
  EnchantConfig_67415_Desc = {
    Text = "All'utilizzo, scarta tutte le carte In Mano che non appartengono a questo Risvegliatore. Ottieni 5 carte non di comando. Ha effetto una volta per battaglia."
  },
  EnchantConfig_67415_Name = {
    Text = "<RedQuality:Av. Lex Volis>"
  },
  EnchantConfig_67416_Desc = {
    Text = "Gioca per pescare 4 carte; il loro Costo di Arithmetica si riduce del Costo di questa carta, efficace solo una volta per battaglia."
  },
  EnchantConfig_67416_Name = {
    Text = "<RedQuality:Av. Lex Nous>"
  },
  EnchantConfig_67417_Desc = {
    Text = "Gioca per ottenere 3 Costo di Arithmetica -1 e aggiungere <RetainIconKeywords:Conserva> e <DepleteIconKeywords:Consumo> come Copie Base, efficace solo una volta per battaglia."
  },
  EnchantConfig_67417_Name = {
    Text = "<RedQuality:Lex Genis Avanzata>"
  }
})
return Text_EnchantConfig
