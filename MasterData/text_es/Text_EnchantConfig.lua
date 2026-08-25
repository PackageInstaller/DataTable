__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_EnchantConfig = readonly({
  EnchantConfig_119927_Desc = {
    Text = "Al jugar, se activa adicionalmente [Arg1] veces, <DepleteIconKeywords:consumir>. <RippleKeywords:Réplica>: roba 2 cartas."
  },
  EnchantConfig_119927_Name = {
    Text = "<BlueQuality:Ecos del Abismo>"
  },
  EnchantConfig_18169_Desc = {
    Text = "Después de jugar, obtén [Arg1] puntos de aritmética"
  },
  EnchantConfig_18169_Name = {
    Text = "<WhiteQuality:Estrategia>"
  },
  EnchantConfig_18170_Desc = {
    Text = "Al jugar, gana [Arg1] <RetaliateIconKeywords:Contrataque>, luego inflige Daño Verdadero a todos los enemigos igual al [Arg2]% de tu <RetaliateIconKeywords:Contrataque>."
  },
  EnchantConfig_18170_Name = {
    Text = "<OrangeQuality:punta avanzada>"
  },
  EnchantConfig_18171_Desc = {
    Text = "Al jugarlo, se activa adicionalmente [Arg1] veces, se obtienen [Arg2] puntos del sigilo negro, <DepleteIconKeywords:agotamiento>, <GuyouKeywords:inherente>"
  },
  EnchantConfig_18171_Name = {
    Text = "<OrangeQuality:Eco Avanzado>"
  },
  EnchantConfig_18172_Desc = {
    Text = "Al jugar, todos los enemigos pierden [Arg1] de <PowerIconKeywords:Fuerza> temporal"
  },
  EnchantConfig_18172_Name = {
    Text = "<WhiteQuality:Agotamiento>"
  },
  EnchantConfig_18173_Desc = {
    Text = "Después de jugar, <EmbryoFusionIconKeywords:Fusión Embrionaria> +[Arg1]."
  },
  EnchantConfig_18173_Name = {
    Text = "<OrangeQuality:Seducción Avanzada>"
  },
  EnchantConfig_18174_Desc = {
    Text = "Después de jugar, <VulnerabilityIconKeywords:vulnerable> a todos los enemigos por [Arg1] turnos"
  },
  EnchantConfig_18174_Name = {
    Text = "<OrangeQuality:vulnerable avanzado>"
  },
  EnchantConfig_18175_Desc = {
    Text = "Al jugar, un tentáculo ataca [Arg1] veces"
  },
  EnchantConfig_18175_Name = {
    Text = "<OrangeQuality:Dominio Avanzado>"
  },
  EnchantConfig_18176_Desc = {
    Text = "Al jugar, un tentáculo ataca [Arg1] veces"
  },
  EnchantConfig_18176_Name = {
    Text = "<WhiteQuality:Dominio>"
  },
  EnchantConfig_18177_Desc = {
    Text = "Al jugar, roba [Arg1] cartas"
  },
  EnchantConfig_18177_Name = {
    Text = "<OrangeQuality:Manos Hábiles Avanzadas>"
  },
  EnchantConfig_18178_Desc = {
    Text = "Después de que comience la batalla, se barajarán [Arg1] copias temporales en la pila de robo, las cartas originales y copias espejo obtendrán <RetainIconKeywords:retener>"
  },
  EnchantConfig_18178_Name = {
    Text = "<OrangeQuality:Espejo Avanzado>"
  },
  EnchantConfig_18179_Desc = {
    Text = "Al jugar, obtén [Arg1] de <PowerIconKeywords:Fuerza>"
  },
  EnchantConfig_18179_Name = {
    Text = "<OrangeQuality:Fuerza Bruta Avanzada>"
  },
  EnchantConfig_18180_Desc = {
    Text = "Al jugar, el Despertado obtiene [Arg1] de locura"
  },
  EnchantConfig_18180_Name = {
    Text = "<OrangeQuality:Furia Avanzada>"
  },
  EnchantConfig_18181_Desc = {
    Text = "Al jugar, aplica [Arg1] <IntoxicationIconKeywords:Veneno> a todos los enemigos, luego activa el [Arg2]% del <IntoxicationIconKeywords:Veneno> de cada enemigo."
  },
  EnchantConfig_18181_Name = {
    Text = "<OrangeQuality:Toxina Avanzada>"
  },
  EnchantConfig_18182_Desc = {
    Text = "Después de jugar, se barajan [Arg1] cartas <DerivativeCardKeywords_4:\"inspiración\"> en el montón de robo. \"Inspiración - Obtén 1 aritmética. Roba 1 carta, <RetainIconKeywords:retener>, <DepleteIconKeywords:consumir>.\""
  },
  EnchantConfig_18182_Name = {
    Text = "<WhiteQuality:Inspiración>"
  },
  EnchantConfig_18183_Desc = {
    Text = "Después de jugar, <VulnerabilityIconKeywords:vulnerable> a todos los enemigos por [Arg1] turnos"
  },
  EnchantConfig_18183_Name = {
    Text = "<WhiteQuality: vulnerable>"
  },
  EnchantConfig_18184_Desc = {
    Text = "Obtén [Arg1] puntos de escudo al jugarla"
  },
  EnchantConfig_18184_Name = {
    Text = "<OrangeQuality:Muralla Avanzada>"
  },
  EnchantConfig_18185_Desc = {
    Text = "Al jugar, aplica [Arg1] <IntoxicationIconKeywords:Veneno> a todos los enemigos, luego activa el [Arg2]% del <IntoxicationIconKeywords:Veneno> de cada enemigo."
  },
  EnchantConfig_18185_Name = {
    Text = "<WhiteQuality:Toxina>"
  },
  EnchantConfig_18186_Desc = {
    Text = "Después de que comience la batalla, se barajarán [Arg1] copias temporales en la pila de robo, las cartas originales y copias espejo obtendrán <RetainIconKeywords:retener>"
  },
  EnchantConfig_18186_Name = {
    Text = "<WhiteQuality:Espejo>"
  },
  EnchantConfig_18187_Desc = {
    Text = "Después de jugar, obtén [Arg1] puntos temporales <PowerIconKeywords:poder>, las cartas plegarias también pueden beneficiarse de este <PowerIconKeywords:poder>"
  },
  EnchantConfig_18187_Name = {
    Text = "<OrangeQuality:Explosión Avanzada>"
  },
  EnchantConfig_18188_Desc = {
    Text = "Al jugar, roba [Arg1] cartas"
  },
  EnchantConfig_18188_Name = {
    Text = "<WhiteQuality:Manos hábiles>"
  },
  EnchantConfig_18189_Desc = {
    Text = "Después de jugar, se barajan [Arg1] cartas <DerivativeCardKeywords_4:\"inspiración\"> en el montón de robo. \"Inspiración - Obtén 1 aritmética. Roba 1 carta, <RetainIconKeywords:retener>, <DepleteIconKeywords:consumir>.\""
  },
  EnchantConfig_18189_Name = {
    Text = "<OrangeQuality:Inspiración Avanzada>"
  },
  EnchantConfig_18190_Desc = {
    Text = "Al jugar, <WeaknessIconKeywords:Debilidad> a todos los enemigos por [Arg1] turnos"
  },
  EnchantConfig_18190_Name = {
    Text = "<OrangeQuality:Debilidad Avanzada>"
  },
  EnchantConfig_18191_Desc = {
    Text = "Después de jugar, <EmbryoFusionIconKeywords:Fusión Embrionaria> +[Arg1]."
  },
  EnchantConfig_18191_Name = {
    Text = "<WhiteQuality:Sed de sangre>"
  },
  EnchantConfig_18192_Desc = {
    Text = "Al jugar, <WeaknessIconKeywords:Debilidad> a todos los enemigos por [Arg1] turnos"
  },
  EnchantConfig_18192_Name = {
    Text = "<WhiteQuality:Debilidad>"
  },
  EnchantConfig_18193_Desc = {
    Text = "Al jugar, todos los enemigos pierden [Arg1] de <PowerIconKeywords:Fuerza> temporal"
  },
  EnchantConfig_18193_Name = {
    Text = "<OrangeQuality:Agotamiento Avanzado>"
  },
  EnchantConfig_18194_Desc = {
    Text = "Al jugar, copia [Arg1] cartas en el <DimensionalSpaceIconKeywords:Espacio Dimensional> temporal"
  },
  EnchantConfig_18194_Name = {
    Text = "<OrangeQuality:Teletransporte Avanzado>"
  },
  EnchantConfig_18195_Desc = {
    Text = "Al jugar, obtén [Arg1] de <PowerIconKeywords:Fuerza>"
  },
  EnchantConfig_18195_Name = {
    Text = "<WhiteQuality:Fuerza bruta>"
  },
  EnchantConfig_18196_Desc = {
    Text = "Obtén [Arg1] puntos de escudo al jugarla"
  },
  EnchantConfig_18196_Name = {
    Text = "<WhiteQuality:Muro de hierro>"
  },
  EnchantConfig_18197_Desc = {
    Text = "Después de jugar, obtén [Arg1] puntos de aritmética"
  },
  EnchantConfig_18197_Name = {
    Text = "<OrangeQuality:Estrategia Avanzada>"
  },
  EnchantConfig_18198_Desc = {
    Text = "Al jugar, otros Despertados obtienen [Arg1] de locura"
  },
  EnchantConfig_18198_Name = {
    Text = "<OrangeQuality:Catalizador Avanzado>"
  },
  EnchantConfig_18199_Desc = {
    Text = "Al jugar, gana [Arg1] <RetaliateIconKeywords:Contrataque>, luego inflige Daño Verdadero a todos los enemigos igual al [Arg2]% de tu <RetaliateIconKeywords:Contrataque>."
  },
  EnchantConfig_18199_Name = {
    Text = "<WhiteQuality:punta>"
  },
  EnchantConfig_18200_Desc = {
    Text = "Al jugarlo, se activa adicionalmente [Arg1] veces, se obtienen [Arg2] puntos del sigilo negro, <DepleteIconKeywords:agotamiento>, <GuyouKeywords:inherente>"
  },
  EnchantConfig_18200_Name = {
    Text = "<WhiteQuality:Eco>"
  },
  EnchantConfig_18201_Desc = {
    Text = "Al jugar, el Despertado obtiene [Arg1] de locura"
  },
  EnchantConfig_18201_Name = {
    Text = "<WhiteQuality:Frenesí>"
  },
  EnchantConfig_18202_Desc = {
    Text = "Después de jugar, obtén [Arg1] puntos temporales <PowerIconKeywords:poder>, las cartas plegarias también pueden beneficiarse de este <PowerIconKeywords:poder>"
  },
  EnchantConfig_18202_Name = {
    Text = "<WhiteQuality:Explosión>"
  },
  EnchantConfig_18203_Desc = {
    Text = "Al jugar, otros Despertados obtienen [Arg1] de locura"
  },
  EnchantConfig_18203_Name = {
    Text = "<WhiteQuality:Catalizar>"
  },
  EnchantConfig_18204_Desc = {
    Text = "Al jugar, copia [Arg1] cartas en el <DimensionalSpaceIconKeywords:Espacio Dimensional> temporal"
  },
  EnchantConfig_18204_Name = {
    Text = "<WhiteQuality:Teletransporte>"
  },
  EnchantConfig_48006_Desc = {
    Text = "El primer efecto activado en cada turno se activa 2 veces"
  },
  EnchantConfig_48006_Name = {
    Text = "<WhiteQuality:Ensamble>"
  },
  EnchantConfig_48007_Desc = {
    Text = "El primer efecto activado en cada turno se activa 3 veces"
  },
  EnchantConfig_48007_Name = {
    Text = "<WhiteQuality:Concierto avanzado>"
  },
  EnchantConfig_49108_Desc = {
    Text = "La carta obtiene <RetainIconKeywords:retener>, y si está en la mano al final del turno, se obtiene una copia original con <RetainIconKeywords:retener> y <DepleteIconKeywords:consumir>"
  },
  EnchantConfig_49108_Name = {
    Text = "<WhiteQuality:Gestación>"
  },
  EnchantConfig_59530_Desc = {
    Text = "Juega esto y descarta todas las demás cartas excepto este despertador, ganando 5 cartas aleatorias que no son despertadores; esto solo tiene efecto una vez por batalla."
  },
  EnchantConfig_59530_Name = {
    Text = "<OrangeQuality:Principio del Placer>"
  },
  EnchantConfig_59531_Desc = {
    Text = "Juega esto y roba 2 cartas, su costo de aritmética reduce el costo real para las cartas de impresión; esto solo tiene efecto una vez por batalla."
  },
  EnchantConfig_59531_Name = {
    Text = "<OrangeQuality:Principio del Conocimiento>"
  },
  EnchantConfig_59532_Desc = {
    Text = "Al jugar, gana 3 copias básicas de <RetainIconKeywords:Retain> y <DepleteIconKeywords:Exhaust>, solo efectivo una vez por batalla."
  },
  EnchantConfig_59532_Name = {
    Text = "<OrangeQuality:Principio de Cría>"
  },
  EnchantConfig_67415_Desc = {
    Text = "Juega esto y descarta todas las demás cartas excepto este despertador, ganando 5 cartas aleatorias que no son despertadores; esto solo tiene efecto una vez por batalla."
  },
  EnchantConfig_67415_Name = {
    Text = "<RedQuality:: Teoría del placer avanzado>"
  },
  EnchantConfig_67416_Desc = {
    Text = "Juega esto y roba 4 cartas, su costo de aritmética reduce el costo real para las cartas de impresión; esto solo tiene efecto una vez por batalla."
  },
  EnchantConfig_67416_Name = {
    Text = "<RedQuality:: Teoría del conocimiento avanzado>"
  },
  EnchantConfig_67417_Desc = {
    Text = "Al jugar, gana 3 costos aritméticos -1 y añade <RetainIconKeywords:Retain> y <DepleteIconKeywords:Exhaust> copias básicas, solo efectivo una vez por batalla."
  },
  EnchantConfig_67417_Name = {
    Text = "<RedQuality: Teoría de la cría avanzada>"
  }
})
return Text_EnchantConfig
