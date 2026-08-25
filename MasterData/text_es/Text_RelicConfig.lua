__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_RelicConfig = readonly({
  RelicConfig_100300_BattleDesc = {
    Text = "Después de que comience la batalla, obtén 3 capas de \"<MindWall:muro mental>\" y 1 capa de \"<TrueConfess:confesión>\". Después de activar 3 veces \"<MindWall:muro mental>\", obtén 1 capa de \"<BarrierCrash:desintegración de la barrera>\". Tras liberar la explosión de locura, cambia \"<TrueConfess:confesión>\" por \"<ShadowSelf:sombra de la personalidad>\"."
  },
  RelicConfig_100300_Desc = {
    Text = "Después de que comience la batalla, obtén 3 capas de \"<MindWall:pared mental>\" y 1 capa de \"<TrueConfess:confesión>\". Tras activar 3 veces \"<MindWall:pared mental>\", obtén 1 capa de \"<BarrierCrash:desintegración de la barrera>\". Después de liberar la exaltación, cambia \"<TrueConfess:confesión>\" a \"<ShadowSelf:sombra de la personalidad>\"."
  },
  RelicConfig_100300_Name = {
    Text = "Análisis del alma"
  },
  RelicConfig_100300_StoryDesc = {
    Text = "Mira bien tu corazón, no tomes una decisión equivocada."
  },
  RelicConfig_100399_BattleDesc = {
    Text = "Tras activar el efecto <DevouredIconKeywords:devoración>, los demás Despertados obtienen [Arg1] puntos de locura, y solo puede tener efecto una vez por turno."
  },
  RelicConfig_100399_Desc = {
    Text = "Tras activar el efecto <DevouredIconKeywords:devoración>, los demás Despertados obtienen [Arg1] puntos de locura, y solo puede activarse una vez por ronda."
  },
  RelicConfig_100399_Name = {
    Text = "<OrangeQuality:Tierra de Sueños Dorados pintada+>"
  },
  RelicConfig_100399_StoryDesc = {
    Text = "El día de tu transformación será tu fin"
  },
  RelicConfig_100400_BattleDesc = {
    Text = "Al final del turno, recupera [Heal:Arg1] vida."
  },
  RelicConfig_100400_Desc = {
    Text = "Al final del turno, recupera [Heal:Arg1] vida."
  },
  RelicConfig_100400_Name = {
    Text = "<OrangeQuality:Sangre de Gracia pintada+>"
  },
  RelicConfig_100400_StoryDesc = {
    Text = "Es dulce y suave, con aroma a rosas"
  },
  RelicConfig_100401_BattleDesc = {
    Text = "Obtén Horno Carmesí equivalente al [Arg1]% de la cantidad de vida perdida al perder vida."
  },
  RelicConfig_100401_Desc = {
    Text = "Obtén Horno Carmesí equivalente al [Arg1]% de la cantidad de vida perdida al perder vida."
  },
  RelicConfig_100401_Name = {
    Text = "<OrangeQuality:Sierra de acero oxidado pintada+>"
  },
  RelicConfig_100401_StoryDesc = {
    Text = "El doctor de anatomía nunca ve a mujeres hermosas, solo un costal de huesos, nervios inflamados por enfermedades, músculos y tejidos"
  },
  RelicConfig_100402_BattleDesc = {
    Text = "Al recoger, aplica [Arg1] capas de <VulnerabilityIconKeywords:vulnerable> a todos los enemigos. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_100402_Desc = {
    Text = "Al recoger, aplica [Arg1] capas de <VulnerabilityIconKeywords:vulnerable> a todos los enemigos. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_100402_Name = {
    Text = "<WhiteQuality:Consagración de la primavera pintada>"
  },
  RelicConfig_100402_StoryDesc = {
    Text = "En las risas nocturnas, la silueta de la canoa se desliza libremente sobre el lago"
  },
  RelicConfig_100404_BattleDesc = {
    Text = "Liberar la \"Exaltar\" después, obtienes [Arg1] puntos temporales de <PowerIconKeywords:Fuerza>."
  },
  RelicConfig_100404_Desc = {
    Text = "Liberar\"Exaltar\" después, obtienes [Arg1] puntos temporales de <PowerIconKeywords:Fuerza>."
  },
  RelicConfig_100404_Name = {
    Text = "<WhiteQuality:Cerradura de hierro pintada>"
  },
  RelicConfig_100404_StoryDesc = {
    Text = "Un candado grueso y sólido, difícil de abrir sin llave.\nClaro, para un ladrón maestro no es nada"
  },
  RelicConfig_100405_BattleDesc = {
    Text = "Al recoger, aplica [Arg1] capas de <WeaknessIconKeywords:debilidad> a todos los enemigos. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_100405_Desc = {
    Text = "Al recoger, aplica [Arg1] capas de <WeaknessIconKeywords:debilidad> a todos los enemigos. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_100405_Name = {
    Text = "<WhiteQuality:Niño maligno pintado>"
  },
  RelicConfig_100405_StoryDesc = {
    Text = "Nacido del mal puro, aunque no sea su deseo"
  },
  RelicConfig_100406_BattleDesc = {
    Text = "Tras activar el efecto <DevouredIconKeywords:devorar>, los demás Despertados obtienen [Arg1] puntos de locura, y solo puede tener efecto una vez por ronda."
  },
  RelicConfig_100406_Desc = {
    Text = "Después de activar el efecto <DevouredIconKeywords:devorar>, los demás Despertados obtienen [Arg1] puntos de locura, y solo puede tener efecto una vez por turno."
  },
  RelicConfig_100406_Name = {
    Text = "<WhiteQuality:Tierra de Sueños Dorados pintada>"
  },
  RelicConfig_100406_StoryDesc = {
    Text = "El día de tu transformación será tu fin"
  },
  RelicConfig_100407_BattleDesc = {
    Text = "Cada vez que causas daño, obtienes [Arg1] <PowerIconKeywords:fuerza> temporal, con un máximo de 15 activaciones por turno."
  },
  RelicConfig_100407_Desc = {
    Text = "Cada vez que causas daño, obtienes [Arg1] <PowerIconKeywords:fuerza> temporal, activándose un máximo de 15 veces por turno."
  },
  RelicConfig_100407_Name = {
    Text = "<WhiteQuality:Ágata de filigrana pintada>"
  },
  RelicConfig_100407_StoryDesc = {
    Text = "Debería ser solo un patrón de ágata común. Probablemente"
  },
  RelicConfig_100408_BattleDesc = {
    Text = "Liberar la\"Exaltar\", obtienes [Arg1] puntos temporales de <PowerIconKeywords:Fuerza>."
  },
  RelicConfig_100408_Desc = {
    Text = "Después de liberar\"Exaltar\",obtienes [Arg1] puntos temporales de <PowerIconKeywords:Fuerza>."
  },
  RelicConfig_100408_Name = {
    Text = "<OrangeQuality:Cerradura de hierro pintada+>"
  },
  RelicConfig_100408_StoryDesc = {
    Text = "Un candado grueso y sólido, difícil de abrir sin llave.\nClaro, para un ladrón maestro no es nada"
  },
  RelicConfig_100409_BattleDesc = {
    Text = "Al recoger, aplica [Arg1] capas de <WeaknessIconKeywords:debilidad> a todos los enemigos. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_100409_Desc = {
    Text = "Al recoger, aplica [Arg1] capas de <WeaknessIconKeywords:debilidad> a todos los enemigos. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_100409_Name = {
    Text = "<OrangeQuality:Niño maligno pintado+>"
  },
  RelicConfig_100409_StoryDesc = {
    Text = "Nacido del mal puro, aunque no sea su deseo"
  },
  RelicConfig_100410_BattleDesc = {
    Text = "Cada vez que causas daño, obtienes [Arg1] de fuerza temporal, con un máximo de 15 activaciones por turno."
  },
  RelicConfig_100410_Desc = {
    Text = "Cada vez que causas daño, obtienes [Arg1] de <PowerIconKeywords:fuerza> temporal, activándose un máximo de 15 veces por turno."
  },
  RelicConfig_100410_Name = {
    Text = "<OrangeQuality:Ágata de filigrana pintada+>"
  },
  RelicConfig_100410_StoryDesc = {
    Text = "Debería ser solo un patrón de ágata común. Probablemente"
  },
  RelicConfig_100411_BattleDesc = {
    Text = "Al recoger, aplica [Arg1] capas de <VulnerabilityIconKeywords:vulnerable> a todos los enemigos. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_100411_Desc = {
    Text = "Al recoger, aplica [Arg1] capas de <VulnerabilityIconKeywords:vulnerable> a todos los enemigos. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_100411_Name = {
    Text = "<OrangeQuality:Consagración de la primavera pintada+>"
  },
  RelicConfig_100411_StoryDesc = {
    Text = "En las risas nocturnas, la silueta de la canoa se desliza libremente sobre el lago"
  },
  RelicConfig_100412_BattleDesc = {
    Text = "Al final del turno, recupera [Heal:Arg1] vida."
  },
  RelicConfig_100412_Desc = {
    Text = "Al final del turno, recupera [Heal:Arg1] vida."
  },
  RelicConfig_100412_Name = {
    Text = "<WhiteQuality:Sangre de Gracia pintada>"
  },
  RelicConfig_100412_StoryDesc = {
    Text = "Es dulce y suave, con aroma a rosas"
  },
  RelicConfig_100413_BattleDesc = {
    Text = "Obtén un Horno Carmesí equivalente al [Arg1]% de la cantidad de vida perdida al perder vida."
  },
  RelicConfig_100413_Desc = {
    Text = "Obtiene un Horno Carmesí del [Arg1]% de la cantidad de vida perdida al perder vida."
  },
  RelicConfig_100413_Name = {
    Text = "<WhiteQuality:Sierra de acero oxidado pintada>"
  },
  RelicConfig_100413_StoryDesc = {
    Text = "El doctor de anatomía nunca ve a mujeres hermosas, solo un costal de huesos, nervios inflamados por enfermedades, músculos y tejidos"
  },
  RelicConfig_100539_BattleDesc = {
    Text = "Cada vez que se usa directamente \"Embrión\" por primera vez en cada turno, el daño activo de este turno causará <BleedingIconKeywords:sangrando> equivalente al [Arg1]% del daño."
  },
  RelicConfig_100539_Desc = {
    Text = "Cada vez que se utiliza directamente \"Embrión\" por primera vez en cada turno, el daño activo en este turno infligirá <BleedingIconKeywords:sangrando> equivalente al [Arg1]% del daño."
  },
  RelicConfig_100539_Name = {
    Text = "<WhiteQuality:Piedra de adoquín manchada de sangre pintada>"
  },
  RelicConfig_100539_StoryDesc = {
    Text = "Uno, dos, tres, cuatro, cinco"
  },
  RelicConfig_100540_BattleDesc = {
    Text = "Después de usar por primera vez \"Embrión\" en cada turno, el daño activo en este turno infligirá <BleedingIconKeywords:sangrando> equivalente al [Arg1]% del daño."
  },
  RelicConfig_100540_Desc = {
    Text = "Después de usar por primera vez \"Embrión\" en cada turno, el daño activo infligirá <BleedingIconKeywords:sangrando> equivalente al [Arg1]% del daño causado en este turno."
  },
  RelicConfig_100540_Name = {
    Text = "<OrangeQuality:Piedra de adoquín manchada de sangre pintada+>"
  },
  RelicConfig_100540_StoryDesc = {
    Text = "Uno, dos, tres, cuatro, cinco"
  },
  RelicConfig_116382_BattleDesc = {
    Text = "Un manojo de llaves oxidadas. Puede usarse para abrir cerraduras"
  },
  RelicConfig_116382_Desc = {
    Text = "Un manojo de llaves oxidadas. Puede usarse para abrir cerraduras"
  },
  RelicConfig_116382_Name = {
    Text = "Llave oxidada"
  },
  RelicConfig_116383_BattleDesc = {
    Text = "Un manojo de llaves oxidadas. Puede usarse para abrir cerraduras"
  },
  RelicConfig_116383_Desc = {
    Text = "Un manojo de llaves oxidadas. Puede usarse para abrir cerraduras"
  },
  RelicConfig_116383_Name = {
    Text = "Llave oxidada"
  },
  RelicConfig_116384_BattleDesc = {
    Text = "Un manojo de llaves oxidadas. Puede usarse para abrir cerraduras"
  },
  RelicConfig_116384_Desc = {
    Text = "Un manojo de llaves oxidadas. Puede usarse para abrir cerraduras"
  },
  RelicConfig_116384_Name = {
    Text = "Llave oxidada"
  },
  RelicConfig_119371_BattleDesc = {
    Text = "Tamaño Máximo de la Mano +1. \n Al comienzo del turno, si no se han completado todos los rituales, obtienes un <SacrificeKeyWord:Ritual de sacrificio> del 10% de PV Max. Añade 1 carta de\"<DerivativeCardKeywords_119:Ofrecer a los dioses>\"a tu mano, con un máximo de 1 carta en mano."
  },
  RelicConfig_119371_Desc = {
    Text = "Tamaño Máximo de la Mano +1. \n Al comienzo del turno, si no se han completado todos los rituales, obtén un <SacrificeKeyWord:Ritual de sacrificio> del 10% de PV Max. Coloca 1 carta de\"<DerivativeCardKeywords_119:Ofrecer a los dioses>\"en la mano, con un máximo de 1 carta en mano."
  },
  RelicConfig_119371_Name = {
    Text = "Incensario de latón"
  },
  RelicConfig_119371_StoryDesc = {
    Text = "\"Este incensario está hecho imitando la artesanía de Lemuria, que te ayude a dormir pacíficamente cada noche. Miryam se fue.\""
  },
  RelicConfig_120372_BattleDesc = {
    Text = "Tamaño Máximo de la Mano +[Arg1]. Al comienzo del turno, coloca [Arg2] cartas de\"<PVPDerivativeCardKeywords_11:Intercambio desigual>\"en la mano."
  },
  RelicConfig_120372_Desc = {
    Text = "Tamaño Máximo de la Mano +[Arg1]. Al comienzo del turno, coloca [Arg2] cartas de\"<PVPDerivativeCardKeywords_11:Intercambio desigual>\"en la mano."
  },
  RelicConfig_120372_Name = {
    Text = "<OrangeQuality:Caleidoscopio>"
  },
  RelicConfig_120373_BattleDesc = {
    Text = "Jugar las primeras [Arg1] \"rueda del destino\" con coste de aritmética -5/-3/-1/+1, roba 1 carta."
  },
  RelicConfig_120373_Desc = {
    Text = "Jugar las primeras [Arg1] cartas de \"<PVPWeaponKeywords:Rueda del destino>\" con coste de aritmética -5/-3/-1/+1, roba 1 carta."
  },
  RelicConfig_120373_Name = {
    Text = "<OrangeQuality:Insignia de Mythag>"
  },
  RelicConfig_121214_BattleDesc = {
    Text = "Inmunidad al daño"
  },
  RelicConfig_121214_Desc = {
    Text = "Inmunidad al daño"
  },
  RelicConfig_121214_Name = {
    Text = "Ninguno Prueba de creación"
  },
  RelicConfig_121689_BattleDesc = {
    Text = "El daño final causado aumenta en un 250%, cada vez que se causa daño se reduce en un 50%, y se aumenta el escudo causado en un 10%, con un máximo de 5 activaciones, se reinicia al comienzo de cada turno."
  },
  RelicConfig_121689_Desc = {
    Text = "El daño final causado aumenta un 250%, cada vez que se causa daño se reduce en un 50%, y se incrementa el escudo generado en un 10%, con un máximo de 5 activaciones, se reinicia al comienzo de cada turno."
  },
  RelicConfig_121689_Name = {
    Text = "<OrangeQuality:\"El regreso de la plata pura·Nacimiento\">"
  },
  RelicConfig_121690_BattleDesc = {
    Text = "Al comenzar el combate, elige 3 cartas para que obtengan \"<RippleKeywords:Réplica>: roba 1 carta, obtiene [Arg3] de <PowerIconKeywords:fuerza> temporal\". Al inicio del turno, roba 2 cartas que tengan <RippleKeywords:Réplica>, y todos los efectos de <RippleKeywords:Réplica> se activarán una vez adicional. Después de activar <RippleKeywords:Réplica> 10 veces, coloca 1 carta de <DerivativeCardKeywords_1:Ecos de sombras perdidas> en tu mano."
  },
  RelicConfig_121690_Desc = {
    Text = "Al comenzar la batalla, elige 3 cartas para que obtengan \"<RippleKeywords:Réplica>: roba 1 carta, obtén [Arg3] de <PowerIconKeywords:fuerza> temporal\".Al inicio del turno, roba 2 cartas con <RippleKeywords:Réplica>, todos los efectos de <RippleKeywords:Réplica> se activan una vez adicional, y después de activar <RippleKeywords:Réplica> 10 veces, coloca 1 carta de <DerivativeCardKeywords_1:Ecos de sombras perdidas> en tu mano."
  },
  RelicConfig_121690_Name = {
    Text = "<OrangeQuality:\"El regreso de la plata pura · Locura\">"
  },
  RelicConfig_121691_BattleDesc = {
    Text = "El Daño Final de Exaltar de todos los Cuerpos Despertados aumenta en un 100%. Cada vez que un Cuerpo Despertado usa Exaltar, se obtiene Keyflare equivalente al 500% del Aliemus Base de dicho Cuerpo Despertado, y el Aliemus Base de todos los Cuerpos Despertados se reduce en 20 puntos, hasta un máximo de 5 veces."
  },
  RelicConfig_121691_Desc = {
    Text = "El Daño Final de Exaltar de todos los Cuerpos Despertados aumenta en un 100%. Cada vez que un Cuerpo Despertado usa Exaltar, se obtiene Keyflare equivalente al 500% del Aliemus Base de dicho Cuerpo Despertado, y el Aliemus Base de todos los Cuerpos Despertados se reduce en 20 puntos, hasta un máximo de 5 veces."
  },
  RelicConfig_121691_Name = {
    Text = "<OrangeQuality:\"El regreso de la plata pura · miedo\">"
  },
  RelicConfig_121692_BattleDesc = {
    Text = "Todos los Despertados causan un aumento del 50% en <RetaliateIconKeywords:contrataque>, <IntoxicationIconKeywords:veneno>, blindaje y recuperación de PV. Al final del turno, obtén un <RetaliateIconKeywords:contrataque> temporal del 500% del blindaje actual."
  },
  RelicConfig_121692_Desc = {
    Text = "Todos los Despertados obtienen un aumento del 50% en el <RetaliateIconKeywords:contrataque>, <IntoxicationIconKeywords:veneno>, blindaje y curación. Al final del turno, obtiene un <RetaliateIconKeywords:contrataque> temporal del 500% del blindaje actual."
  },
  RelicConfig_121692_Name = {
    Text = "<OrangeQuality:\"El regreso de la plata pura · Herejía\">"
  },
  RelicConfig_121693_BattleDesc = {
    Text = "Tamaño Máximo de la Mano +5. Al comenzar el turno, roba 2 cartas y obtiene 2 puntos de aritmética. Cada vez que se reinicie la biblioteca, obtienes [Arg3] puntos de <PowerIconKeywords:Fuerza> y [Arg4] puntos temporales de <AlertIconKeywords:Alerta>, genera 1 carta de cada Tarjeta de Comando Innata del despertador con la máxima locura y añádelas al mazo de robo, reduciendo su coste de aritmética en 1 punto."
  },
  RelicConfig_121693_Desc = {
    Text = "Tamaño Máximo de la Mano +5. Al comienzo del turno, roba 2 cartas y obtén 2 puntos de Aritmética. Cada vez que se reinicie el mazo, obtén [Arg3] puntos de <PowerIconKeywords:Fuerza> y [Arg4] puntos de <AlertIconKeywords:Alerta>, genera 1 carta de cada Tarjeta de Comando Innata del despertador con la mayor locura y colócala en el mazo de robo, reduciendo su Coste de Aritmética en 1 punto."
  },
  RelicConfig_121693_Name = {
    Text = "<OrangeQuality:\"El regreso de la plata pura · Scathe\">"
  },
  RelicConfig_121694_BattleDesc = {
    Text = "Cada Despertado obtiene 25 puntos de alienación por la primera \"tarjeta de comando\" de cada turno y coloca una <DerivativeCardKeywords_4:conocimiento> en su mano. Después de liberar 4 veces \"exaltar\", se eliminan los estados de <Seal:sellado> de todos los Despertados y todos ellos obtienen 50 puntos de alienación."
  },
  RelicConfig_121694_Desc = {
    Text = "Todos los Despertados obtienen 25 puntos de locura por la primera \"Tarjeta de comando\" de cada turno y colocan una <DerivativeCardKeywords_4:Conocimiento> en la mano. Después de liberar \"Exaltar\" 4 veces, se eliminan todos los estados de <Seal:Sellado> de los Despertados y todos los Despertados obtienen 50 puntos de locura."
  },
  RelicConfig_121694_Name = {
    Text = "<OrangeQuality:\"El regreso de la plata pura · Deceit\">"
  },
  RelicConfig_121695_BattleDesc = {
    Text = "Al comenzar la batalla, obtienes [Arg4] puntos de <PowerIconKeywords:Fuerza>, el límite de almacenamiento de energía llave plateada aumenta en un 100%. La energía llave plateada obtenida por cada punto de coste de aritmética aumenta en un 100%. Después de usar el Despertar de la llave plateada o liberar la Posse, obtienes un <PowerIconKeywords:Fuerza> temporal equivalente al 20% de la actual <PowerIconKeywords:Fuerza> y todos los Despertados obtienen 20 puntos de alienación."
  },
  RelicConfig_121695_Desc = {
    Text = "Al comenzar la batalla, obtén [Arg4] puntos de <PowerIconKeywords:Fuerza>, el límite de almacenamiento de energía llave plateada aumenta en un 100%. La energía llave plateada obtenida por cada punto de capacidad aritmética consumido aumenta en un 100%, y después de usar el Despertar de la llave plateada o liberar la Posse, obtén un <PowerIconKeywords:Fuerza> temporal equivalente al 20% de la actual y todos los Despertados obtienen 20 puntos de alienación."
  },
  RelicConfig_121695_Name = {
    Text = "<OrangeQuality:\"El regreso de la plata pura · Lamento\">"
  },
  RelicConfig_122625_BattleDesc = {
    Text = "Después de que comience la batalla, coloca [Arg1] cartas de\"<PVPDerivativeCardKeywords_25:Té rojo de Silvia>\"en tu mano."
  },
  RelicConfig_122625_Desc = {
    Text = "Después de que comience la batalla, coloca [Arg1] cartas de\"<PVPDerivativeCardKeywords_25:Té rojo de Silvia>\"en la mano."
  },
  RelicConfig_122625_Name = {
    Text = "<OrangeQuality:té negro de Ceilán>"
  },
  RelicConfig_122626_BattleDesc = {
    Text = "Inserta [Arg1] cartas de\"<PVPDerivativeCardKeywords_14:Imitación de la realidad>\" en el mazo de robo cada turno, siendo el propietario un Despertado aleatorio."
  },
  RelicConfig_122626_Desc = {
    Text = "Inserta [Arg1] cartas de\"<PVPDerivativeCardKeywords_14:Imitación de la realidad>\" en el mazo de robo cada turno, siendo el propietario un Despertado aleatorio."
  },
  RelicConfig_122626_Name = {
    Text = "<OrangeQuality:Guantes mágicos>"
  },
  RelicConfig_122627_BattleDesc = {
    Text = "El daño, la curación y el escudo del primer \"skill\" jugado en cada turno aumentan en [Arg1]%."
  },
  RelicConfig_122627_Desc = {
    Text = "El daño, la curación y el escudo del primer \"habilidad\" jugado en cada turno aumentan en [Arg1]%."
  },
  RelicConfig_122627_Name = {
    Text = "<OrangeQuality:Broche de Rubí>"
  },
  RelicConfig_122628_BattleDesc = {
    Text = "Después de terminar el turno, obtén <Energy:[Arg1]> alienación adicional."
  },
  RelicConfig_122628_Desc = {
    Text = "Al final del turno, obtén <Energy:[Arg1]> puntos de alienación adicionales."
  },
  RelicConfig_122628_Name = {
    Text = "<OrangeQuality:Manifestación de Pesadilla>"
  },
  RelicConfig_122629_BattleDesc = {
    Text = "Habrá el doble de cartas de Despertado en el mazo de robo. Después de jugar una carta, cuando el número de cartas en la mano sea menor que [Arg1] por primera vez en este turno, roba [Arg2] cartas."
  },
  RelicConfig_122629_Desc = {
    Text = "Habrá el doble de cartas de Despertado en el mazo de robo. Después de jugar una carta, si el número de cartas en la mano es menor que [Arg1] por primera vez en este turno, roba [Arg2] cartas."
  },
  RelicConfig_122629_Name = {
    Text = "<OrangeQuality:Disco alegre>"
  },
  RelicConfig_122630_BattleDesc = {
    Text = "Tamaño Máximo de la Mano +[Arg1]. En cada ronda, coloca [Arg2] cartas de\"<PVPDerivativeCardKeywords_13:Funus Aeternum>\"en el mazo de robo."
  },
  RelicConfig_122630_Desc = {
    Text = "Tamaño Máximo de la Mano +[Arg1]. En cada ronda, coloca [Arg2] cartas de\"<PVPDerivativeCardKeywords_13:Funus Aeternum>\"en el mazo de robo."
  },
  RelicConfig_122630_Name = {
    Text = "<OrangeQuality:Cuchillo ritual perdido>"
  },
  RelicConfig_122768_BattleDesc = {
    Text = "Al comenzar el turno, roba [Arg1] \"golpes\" con un coste de aritmética -1. Después de liberar la exaltación, genera [Arg2] \"golpes\" del despertador correspondiente que tienen <DepleteIconKeywords:agotamiento>, <PrepareKeypvewords:Preparar1> y <RetainIconKeywords:Retener>.\n Por cada [Arg3] \"golpes\" jugados en 1 turno, obtén [Arg4] puntos de <PowerIconKeywords:fuerza> temporal; después de jugar [Arg5] \"golpes\", roba [Arg6] cartas y obtén [Arg7] puntos de aritmética; después de jugar [Arg8] \"golpes\", todos los despertadores obtienen [Arg9] puntos de alienación."
  },
  RelicConfig_122768_Desc = {
    Text = "Al comenzar el turno, roba [Arg1] \"golpe\" con coste de aritmética -1. Tras liberar la explosión de locura, genera [Arg2] \"golpe\" del despertador correspondiente que tiene <DepleteIconKeywords:Consumo>, <PrepareKeypvewords:Preparar 1> y <RetainIconKeywords:Retener>.\nPor cada [Arg3] \"golpe\" jugado en 1 turno, obtén [Arg4] puntos de <PowerIconKeywords:Fuerza> temporal; tras jugar [Arg5] \"golpe\", roba [Arg6] cartas y obtén [Arg7] puntos de aritmética; tras jugar [Arg8] \"golpe\", todos los despertadores obtienen [Arg9] puntos de alienación."
  },
  RelicConfig_122768_Name = {
    Text = "Eco del otro lado"
  },
  RelicConfig_122768_StoryDesc = {
    Text = "Ecos que se entrelazan en la niebla de otro mundo, llevando a la distorsión, la locura y la realidad innegable."
  },
  RelicConfig_123724_BattleDesc = {
    Text = "Al comienzo del turno, Mouchette obtiene [Arg1] puntos de alienación y genera 1 \"golpe\" temporal de coste de aritmética 0 de Mouchette. Cada vez que se activa \"Encuentro dramático\", el efecto de aumento del daño base y del daño de golpe de \"Tornado☆Resplandeciente\" en esta batalla se incrementa en [Arg2]％."
  },
  RelicConfig_123724_Desc = {
    Text = "Al comienzo del turno, Mouchette obtiene [Arg1] puntos de alienación y genera 1 \"golpear\" temporal con coste de aritmética 0 de Mouchette. Cada vez que se activa \"Encuentro dramático\", el efecto de aumento del daño básico y del daño de \"Tornado☆Resplandeciente\" en esta batalla se incrementa en [Arg2]％."
  },
  RelicConfig_123724_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Mouchette>"
  },
  RelicConfig_125488_BattleDesc = {
    Text = "Cada Despertado obtiene [Arg1] puntos de alienación la primera vez que juega una carta de comando en cada turno. Después de jugar 4 cartas de comando que pertenecen a diferentes Despertados en un turno, se aplica a todos los enemigos [Arg2]% de la salud máxima de nuestro <IntoxicationIconKeywords:veneno>."
  },
  RelicConfig_125488_Desc = {
    Text = "Todos los Despertados obtienen [Arg1] puntos de Alienación la primera vez que juegan una tarjeta de comando en cada turno. Después de jugar 4 cartas de comando que pertenecen a diferentes Despertados en un turno, se aplica a todos los enemigos [Arg2]% de la PV Max como <IntoxicationIconKeywords:veneno>."
  },
  RelicConfig_125488_Name = {
    Text = "El estilo de la tía"
  },
  RelicConfig_125489_BattleDesc = {
    Text = "Al comenzar el turno, Xu obtiene [Arg1] puntos de alienación y aplica 1 capa de <WitherKeywords:Ebrio> a todos los enemigos. La primera carta de comando de Xu jugada en cada turno activará necesariamente el efecto de \"Resonancia\"."
  },
  RelicConfig_125489_Desc = {
    Text = "Al comenzar el turno, Xu obtiene [Arg1] puntos de alienación y aplica 1 capa de <WitherKeywords:Ebrio> a todos los enemigos. La primera carta de comando de Xu jugada en cada turno activará obligatoriamente el efecto de \"Resonancia\"."
  },
  RelicConfig_125489_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Xu>"
  },
  RelicConfig_126673_BattleDesc = {
    Text = "Tamaño Máximo de la Mano +3. Registra las primeras 3 Tarjetas de Comando no derivadas jugadas cada turno, y al inicio del turno 3 turnos después, reduce su Coste de Aritmética en -1 y añade copias con <DepleteIconKeywords:Consumo> a tu mano."
  },
  RelicConfig_126673_Desc = {
    Text = "Tamaño Máximo de la Mano +3. Registra las primeras 3 cartas de comando no derivadas jugadas cada turno, y al inicio del turno 3 turnos después, reduce su coste de aritmética en -1 y añade copias con <DepleteIconKeywords:Consumo> a tu mano."
  },
  RelicConfig_126673_Name = {
    Text = "Rueda del destino"
  },
  RelicConfig_126673_StoryDesc = {
    Text = "La rueda gira eternamente."
  },
  RelicConfig_129304_BattleDesc = {
    Text = "<OrangeQuality:Armonía Dorada>: \"Armonía Aritmética\" ahora solo aumenta el Coste de Aritmética en 1. Cada 1% de Amplificación de Daño aumenta la Profundidad de la Investigación de la Conciencia en un 1%.\n<OrangeQuality:Regalo Dimensional>: Al comenzar la exploración, obtén aleatoriamente 1 Reliquia de Imagen Dimensional. Límite de Mano +2.\n<OrangeQuality:Ritual de Bendición>: Las recompensas por vencer al Líder de la primera y segunda fase se cambian por una Reliquia Bendecida aleatoria de 3 opciones.\n<RedQuality:Cansancio de Tránsito>: En combate, todos los efectos de recuperación de PV se reducen en un 50%. Cuando se selecciona \"Entierro\" en \"Huesos desvanecidos\", el efecto cambia a restaurar el 25% de PV Max.\n<RedQuality:Síntoma de aturdimiento>: Al iniciar la batalla, la Alienación actual y la Keyflare de todos los Cuerpos Despertados se reducen en un 50%.\n<RedQuality:Pasillo de la Noche Eterna>: Al inicio de la exploración, el Aliemus Base y el límite de Keyflare de todos los Cuerpos Despertados aumentan en un 50%."
  },
  RelicConfig_129304_Desc = {
    Text = "<OrangeQuality:Armonía Dorada>: \"Armonía Aritmética\" ahora solo aumenta el Coste de Aritmética en 1. Cada 1% de Amplificación de Daño aumenta la Profundidad de la Investigación de la Conciencia en un 1%.\n<OrangeQuality:Regalo Dimensional>: Al comenzar la exploración, obtén aleatoriamente 1 Reliquia de Imagen Dimensional. Límite de Mano +2.\n<OrangeQuality:Ritual de Bendición>: Las recompensas por vencer al Líder de la primera y segunda fase se cambian por una Reliquia Bendecida aleatoria de 3 opciones.\n<RedQuality:Cansancio de Tránsito>: En combate, todos los efectos de recuperación de PV se reducen en un 50%. Cuando se selecciona \"Entierro\" en \"Huesos desvanecidos\", el efecto cambia a restaurar el 25% de PV Max.\n<RedQuality:Síntoma de aturdimiento>: Al iniciar la batalla, la Alienación actual y la Keyflare de todos los Cuerpos Despertados se reducen en un 50%.\n<RedQuality:Pasillo de la Noche Eterna>: Al inicio de la exploración, el Aliemus Base y el límite de Keyflare de todos los Cuerpos Despertados aumentan en un 50%."
  },
  RelicConfig_129304_Name = {
    Text = "<OrangeQuality:Cámara Caótica de pequeño\"N\">"
  },
  RelicConfig_129304_StoryDesc = {
    Text = "¡Estamos en problemas! ¡La cámara está completamente rota! ¿Eh? ¿Cómo puede seguir funcionando? ¡Espera! ¿Qué son estas restricciones?!"
  },
  RelicConfig_129305_BattleDesc = {
    Text = "<OrangeQuality:Armonía Dorada>: \"Armonía Aritmética\" ahora solo aumenta el Coste de Aritmética en 1. Cada 1% de Amplificación de Daño aumenta la Profundidad de la Investigación de la Conciencia en un 1%.\n<RedQuality:Cansancio de Tránsito>: En combate, todos los efectos de recuperación de PV se reducen en un 50%. Cuando se selecciona \"Entierro\" en \"Huesos desvanecidos\", el efecto cambia a restaurar el 25% de PV Max."
  },
  RelicConfig_129305_Desc = {
    Text = "<OrangeQuality:Armonía Dorada>: \"Armonía Aritmética\" ahora solo aumenta el Coste de Aritmética en 1. Cada 1% de Amplificación de Daño aumenta la Profundidad de la Investigación de la Conciencia en un 1%.\n<RedQuality:Cansancio de Tránsito>: En combate, todos los efectos de recuperación de PV se reducen en un 50%. Cuando se selecciona \"Entierro\" en \"Huesos desvanecidos\", el efecto cambia a restaurar el 25% de PV Max."
  },
  RelicConfig_129305_Name = {
    Text = "<OrangeQuality:Cámara completa de pequeño\"N\">"
  },
  RelicConfig_129305_StoryDesc = {
    Text = "¡No mires más, esta es la cámara! Nueva de fábrica, sin engaños."
  },
  RelicConfig_129306_BattleDesc = {
    Text = "<OrangeQuality:Armonía Dorada>: \"Armonía Aritmética\" ahora solo aumenta el Coste de Aritmética en 1. Cada 1% de Amplificación de Daño aumenta la Profundidad de la Investigación de la Conciencia en un 1%.\n<OrangeQuality:Regalo Dimensional>: Al comenzar la exploración, obtén aleatoriamente 1 Reliquia de Imagen Dimensional. Límite de Mano +1.\n<RedQuality:Cansancio de Tránsito>: En combate, todos los efectos de recuperación de PV se reducen en un 50%. Cuando se selecciona \"Entierro\" en \"Huesos desvanecidos\", el efecto cambia a restaurar el 25% de PV Max.\n<RedQuality:Síntoma de aturdimiento>: Al iniciar la batalla, la Alienación actual y la Keyflare de todos los Cuerpos Despertados se reducen en un 50%."
  },
  RelicConfig_129306_Desc = {
    Text = "<OrangeQuality:Armonía Dorada>: \"Armonía Aritmética\" ahora solo aumenta el Coste de Aritmética en 1. Cada 1% de Amplificación de Daño aumenta la Profundidad de la Investigación de la Conciencia en un 1%.\n<OrangeQuality:Regalo Dimensional>: Al comenzar la exploración, obtén aleatoriamente 1 Reliquia de Imagen Dimensional. Límite de Mano +1.\n<RedQuality:Cansancio de Tránsito>: En combate, todos los efectos de recuperación de PV se reducen en un 50%. Cuando se selecciona \"Entierro\" en \"Huesos desvanecidos\", el efecto cambia a restaurar el 25% de PV Max.\n<RedQuality:Síntoma de aturdimiento>: Al iniciar la batalla, la Alienación actual y la Keyflare de todos los Cuerpos Despertados se reducen en un 50%."
  },
  RelicConfig_129306_Name = {
    Text = "<OrangeQuality:Pequeña\"N\"cámara vieja>"
  },
  RelicConfig_129306_StoryDesc = {
    Text = "¡Oh no! ¡La cámara se rompió! Déjame arreglarla... ¡Está encendida! Pero, ¿por qué se siente raro...?"
  },
  RelicConfig_131079_BattleDesc = {
    Text = "Al comenzar el turno, Mosk obtiene [Arg1] puntos de alienación. Cada vez que se juegue por primera vez\"¡Cargar!\"o\"¡Cargar!\"en el turno, tendrá efecto 2 veces."
  },
  RelicConfig_131079_Desc = {
    Text = "Al comenzar el turno, Mosk obtiene [Arg1] puntos de alienación. Cada vez que se juegue por primera vez\"¡Cargar!\"o\"¡Cargar!\"en el turno, tendrá efecto 2 veces."
  },
  RelicConfig_131079_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Mosk>"
  },
  RelicConfig_131080_BattleDesc = {
    Text = "Al comienzo de los primeros 3 turnos, se activa 1 vez \"El Dilema de la Nutria\" por turno. Al inicio del quinto turno, se eliminan todos los efectos negativos de \"El Dilema de la Nutria\" y se obtiene \"<DerivativeCardKeywords_135:¡Impacto de la Segunda Generación!>\"."
  },
  RelicConfig_131080_Desc = {
    Text = "Al comienzo de los primeros 3 turnos, se activa 1 vez \"El Dilema de la Nutria\" por turno. Al inicio del quinto turno, se eliminan todos los efectos negativos de \"El Dilema de la Nutria\" y se obtiene \"<DerivativeCardKeywords_135:¡Impacto de la Segunda Generación!>\"."
  },
  RelicConfig_131080_Name = {
    Text = "Bola de carbón, ¡segunda generación"
  },
  RelicConfig_131080_StoryDesc = {
    Text = "La señora Mosk dijo con firmeza que eso es una reliquia. \n\"¡Malvado, muérdele!\""
  },
  RelicConfig_131178_BattleDesc = {
    Text = "Al Comenzar la batalla, Barajar una \"<DerivativeCardKeywords_134:Verdad Prohibida>\" en el mazo. Robar +[Arg1] cada turno. Tras Jugar una Tarjeta de comando, otorgar aleatoriamente <ErosionColorInkKeywords:Distorsión de Percepción> a [Arg2] Tarjetas de comando en la mano del oponente."
  },
  RelicConfig_131178_Desc = {
    Text = "Al Comenzar la batalla, Barajar una \"<DerivativeCardKeywords_134:Verdad Prohibida>\" en el mazo. Robar +[Arg1] cada turno. Tras Jugar una Tarjeta de comando, otorgar aleatoriamente <ErosionColorInkKeywords:Distorsión de Percepción> a [Arg2] Tarjetas de comando en la mano del oponente."
  },
  RelicConfig_131178_Name = {
    Text = "Notas de Aoya"
  },
  RelicConfig_131178_StoryDesc = {
    Text = "El contenido registrado incluye setenta números primos de Mason."
  },
  RelicConfig_132540_BattleDesc = {
    Text = "Inmunidad al daño"
  },
  RelicConfig_132540_Name = {
    Text = "Creación de prueba de conjunto"
  },
  RelicConfig_13740_BattleDesc = {
    Text = "La tasa crítica aumenta un 15%. Si la vida está por debajo del 25% al inicio del turno ([Arg1]), la tasa crítica aumentará en un 30% adicional durante ese turno"
  },
  RelicConfig_13740_Desc = {
    Text = "La tasa crítica aumenta un 15%. Si la vida está por debajo del 25%, la tasa crítica aumentará en un 30% adicional durante ese turno"
  },
  RelicConfig_13740_Name = {
    Text = "<OrangeQuality:Astrolabio del Grimorio>"
  },
  RelicConfig_13740_StoryDesc = {
    Text = "Los misterios del universo"
  },
  RelicConfig_13741_BattleDesc = {
    Text = "Daño crítico +15%. Daño a enemigos con escudo siempre será crítico"
  },
  RelicConfig_13741_Desc = {
    Text = "Daño crítico +15%. Daño a enemigos con escudo siempre será crítico"
  },
  RelicConfig_13741_Name = {
    Text = "<WhiteQuality:Estética>"
  },
  RelicConfig_13741_StoryDesc = {
    Text = "Escultor de cera: Ayudante del doctor, cliente de los funerarios, proveedor de los gusanos de tumba"
  },
  RelicConfig_13742_BattleDesc = {
    Text = "Daño crítico +50%. Cada tercer ataque será un crítico seguro"
  },
  RelicConfig_13742_Desc = {
    Text = "Daño crítico +50%. Cada tercer ataque será un crítico seguro"
  },
  RelicConfig_13742_Name = {
    Text = "<OrangeQuality: Péndulo crono\"Meditación\">"
  },
  RelicConfig_13743_BattleDesc = {
    Text = "Al comienzo del turno, el despertador con menor aliemus obtiene 15 aliemus. Si juegas 2 cartas consecutivas con menor coste de aritmética que la anterior, el despertador con menor aliemus obtiene 15 aliemus"
  },
  RelicConfig_13743_Desc = {
    Text = "Al comienzo del turno, el despertador con menor aliemus obtiene 15 aliemus. Si juegas 2 cartas consecutivas con menor coste de aritmética que la anterior, el despertador con menor aliemus obtiene 15 aliemus"
  },
  RelicConfig_13743_Name = {
    Text = "<OrangeQuality:Reliquia Arcana>"
  },
  RelicConfig_13743_StoryDesc = {
    Text = "El fin del destino"
  },
  RelicConfig_13744_BattleDesc = {
    Text = "Después de que comience el turno, el cuerpo despertado con menos locura obtiene 15 de locura"
  },
  RelicConfig_13744_Desc = {
    Text = "Después de que comience el turno, el cuerpo despertado con menos locura obtiene 15 de locura"
  },
  RelicConfig_13744_Name = {
    Text = "<WhiteQuality:Gemelos de laurel>"
  },
  RelicConfig_13744_StoryDesc = {
    Text = "Gemelos de plata con diseño de laureles.\nEstá bien hecho y brillante, simbolizando una antigua amistad de dos niños"
  },
  RelicConfig_13745_BattleDesc = {
    Text = "El efecto de aumento recomendado del reino se incrementa al 50%, al inicio del nivel tu tasa de sellado de suerte se duplica"
  },
  RelicConfig_13745_Desc = {
    Text = "El efecto de aumento recomendado del reino se incrementa al 50%, al inicio del nivel tu tasa de sellado de suerte se duplica"
  },
  RelicConfig_13745_Name = {
    Text = "<OrangeQuality:péndulo crono\"Sueño profundo»>"
  },
  RelicConfig_13747_BattleDesc = {
    Text = "Inmunidad a 1 muerte, recupera 10% de vida al activarse, se desactiva permanentemente tras 3 activaciones"
  },
  RelicConfig_13747_Desc = {
    Text = "Inmunidad a 1 muerte, recupera 10% de vida al activarse, se desactiva permanentemente tras 3 activaciones"
  },
  RelicConfig_13747_Name = {
    Text = "<WhiteQuality:☆Comida de Emergencia☆>"
  },
  RelicConfig_13747_StoryDesc = {
    Text = "No lo comas a menos que sea necesario"
  },
  RelicConfig_13748_BattleDesc = {
    Text = "Al comienzo de la batalla, todas las cartas con coste de aritmética de 1 tendrán su daño incrementado en [Arg1] y su escudo aumentado en [Arg2] durante esta batalla"
  },
  RelicConfig_13748_Desc = {
    Text = "Al comienzo de la batalla, todas las cartas con coste de aritmética de 1 tendrán su daño incrementado en [Arg1] y su escudo aumentado en [Arg2] durante esta batalla"
  },
  RelicConfig_13748_Name = {
    Text = "<OrangeQuality:María Inocente>"
  },
  RelicConfig_13748_StoryDesc = {
    Text = "La lógica es como un cóctel, demasiado y pierde su beneficio"
  },
  RelicConfig_13749_BattleDesc = {
    Text = "Cada 4 turnos, duplica el Daño activo y de Daño de tentáculos que todos los enemigos reciben en ese turno. Sin embargo, al liberar Exaltar en ese turno, sellará todos los Cuerpo Despertados por 1 turno."
  },
  RelicConfig_13749_Desc = {
    Text = "Cada 4 turnos, duplica el Daño activo y de Daño de tentáculos que todos los enemigos reciben en ese turno. Sin embargo, al liberar Exaltar en ese turno, sellará todos los Cuerpo Despertados por 1 turno."
  },
  RelicConfig_13749_Name = {
    Text = "<RedQuality:Cadáver del camino>"
  },
  RelicConfig_13749_StoryDesc = {
    Text = [[
Una parte sagrada.
Aunque separada del torso, sus huellas se han extendido por los mares]]
  },
  RelicConfig_13750_BattleDesc = {
    Text = "Al final del turno, si no tienes escudo, gana 1 capa de <ParcloseIconKeywords:barrera> que bloquea un daño. Solo se activa una vez por batalla"
  },
  RelicConfig_13750_Desc = {
    Text = "Al final del turno, si no tienes escudo, gana 1 capa de <ParcloseIconKeywords:barrera> que bloquea un daño. Solo se activa una vez por batalla"
  },
  RelicConfig_13750_Name = {
    Text = "<WhiteQuality:☆Analgésicos☆>"
  },
  RelicConfig_13750_StoryDesc = {
    Text = "El efecto no es tan permanente"
  },
  RelicConfig_13751_BattleDesc = {
    Text = "La tasa crítica aumenta un 25%, el daño del primer daño causado en cada turno se duplica"
  },
  RelicConfig_13751_Desc = {
    Text = "La tasa crítica aumenta un 25%, el daño del primer daño causado en cada turno se duplica"
  },
  RelicConfig_13751_Name = {
    Text = "<OrangeQuality:péndulo crono\"Profundización\">"
  },
  RelicConfig_13752_BattleDesc = {
    Text = "Al inicio del turno, recupera [Arg1] vida. Si la vida es menor al 50%, recupera [Arg2]"
  },
  RelicConfig_13752_Desc = {
    Text = "Al inicio del turno, recupera [Arg1] vida. Si la vida es menor al 50%, recupera [Arg2]"
  },
  RelicConfig_13752_Name = {
    Text = "<WhiteQuality:Sangre bendita>"
  },
  RelicConfig_13752_StoryDesc = {
    Text = "Es dulce y suave, con aroma a rosas"
  },
  RelicConfig_13753_BattleDesc = {
    Text = "Es un objeto de misión sin efecto"
  },
  RelicConfig_13753_Desc = {
    Text = "Es un objeto de misión sin efecto"
  },
  RelicConfig_13753_Name = {
    Text = "Prueba de creación de misión"
  },
  RelicConfig_13753_StoryDesc = {
    Text = "Requiere contenido adicional para la creación"
  },
  RelicConfig_13754_BattleDesc = {
    Text = "El quinto daño que causes será un golpe crítico"
  },
  RelicConfig_13754_Desc = {
    Text = "El quinto daño que causes será un golpe crítico"
  },
  RelicConfig_13754_Name = {
    Text = "<WhiteQuality:Corrector de visión>"
  },
  RelicConfig_13754_StoryDesc = {
    Text = "Alguien una vez encontró la verdad a través de él"
  },
  RelicConfig_13755_BattleDesc = {
    Text = "Al inicio del turno, por cada carta en el <DimensionalSpaceIconKeywords:espacio dimensional>, obtén [Arg1] de <PowerIconKeywords:fuerza> temporal. Si es un turno dimensional, obtén [Arg2] de <PowerIconKeywords:fuerza> temporal"
  },
  RelicConfig_13755_Desc = {
    Text = "Al inicio del turno, por cada carta en el <DimensionalSpaceIconKeywords:espacio dimensional>, obtén [Arg1] de <PowerIconKeywords:fuerza> temporal. Si es un turno dimensional, obtén [Arg2] de <PowerIconKeywords:fuerza> temporal"
  },
  RelicConfig_13755_Name = {
    Text = "<WhiteQuality:Prisma>"
  },
  RelicConfig_13755_StoryDesc = {
    Text = "\"La luz se compone de siete colores.\""
  },
  RelicConfig_13756_BattleDesc = {
    Text = "Al recoger, se pierden todas las otras reliquias y se obtienen aleatoriamente 2 reliquias de oro"
  },
  RelicConfig_13756_Desc = {
    Text = "Al recoger, se pierden todas las otras reliquias y se obtienen aleatoriamente 2 reliquias de oro"
  },
  RelicConfig_13756_Name = {
    Text = "<RedQuality:☆Observación inversa☆>"
  },
  RelicConfig_13756_StoryDesc = {
    Text = "En la era extraña, las flores eran los primeros espectadores de la humanidad.\nNo te muevas, prefieren las exhibiciones tranquilas"
  },
  RelicConfig_13757_BattleDesc = {
    Text = "La octava carta de comando que juegues tendrá un efecto adicional"
  },
  RelicConfig_13757_Desc = {
    Text = "La octava carta de comando que juegues tendrá un efecto adicional"
  },
  RelicConfig_13757_Name = {
    Text = "<OrangeQuality:Vino de las Estrellas>"
  },
  RelicConfig_13757_StoryDesc = {
    Text = "Viajando entre las estrellas"
  },
  RelicConfig_13758_BattleDesc = {
    Text = "Al recoger, aumenta la salud máxima en [Arg1] puntos, y cuando reciba daño, la locura ganada aumenta en 2 puntos"
  },
  RelicConfig_13758_Desc = {
    Text = "Al recoger, aumenta la salud máxima en [Arg1] puntos, y cuando reciba daño, la locura ganada aumenta en 2 puntos"
  },
  RelicConfig_13758_Name = {
    Text = "<WhiteQuality:Tinta dulce>"
  },
  RelicConfig_13758_StoryDesc = {
    Text = "Alguien dice que es sangre de demonio, pero, ¡hey, pruébala!"
  },
  RelicConfig_13759_BattleDesc = {
    Text = "Al liberar la exhalación de aliemus, cada vez que un enemigo va a infligir 1 punto de daño, se le aplica [Arg1] capas de <IntoxicationIconKeywords:veneno>"
  },
  RelicConfig_13759_Desc = {
    Text = "Al liberar la exhalación de aliemus, cada vez que un enemigo va a infligir 1 punto de daño, se le aplica [Arg1] capas de <IntoxicationIconKeywords:veneno>"
  },
  RelicConfig_13759_Name = {
    Text = "<WhiteQuality:☆Mandíbula Láser☆>"
  },
  RelicConfig_13759_StoryDesc = {
    Text = "Huesos exhibidos en la galería privada de un coleccionista.\nEl coleccionista estaba fascinado por su hermoso brillo, lo admiraba día y noche, hasta que murió y se convirtió en uno de ellos"
  },
  RelicConfig_13760_BattleDesc = {
    Text = "Aumenta el límite de aritmética máxima en 1. Al jugar dos veces seguidas una carta con un consumo de aritmética superior que la anterior, se obtiene 1 punto de aritmética"
  },
  RelicConfig_13760_Desc = {
    Text = "Aumenta el límite de aritmética máxima en 1. Al jugar dos veces seguidas una carta con un consumo de aritmética superior que la anterior, se obtiene 1 punto de aritmética"
  },
  RelicConfig_13760_Name = {
    Text = "<OrangeQuality:Registro Arcano>"
  },
  RelicConfig_13760_StoryDesc = {
    Text = "Tendencia del destino"
  },
  RelicConfig_13761_BattleDesc = {
    Text = "Al comienzo del turno, si el número de cartas en mano del turno anterior es mayor a 3, obtén 2 de aritmética"
  },
  RelicConfig_13761_Desc = {
    Text = "Al comienzo del turno, si el número de cartas en mano del turno anterior es mayor a 3, obtén 2 de aritmética"
  },
  RelicConfig_13761_Name = {
    Text = "<WhiteQuality: emblema de mitag>"
  },
  RelicConfig_13761_StoryDesc = {
    Text = "Insignia distribuida a los investigadores de la Universidad de Mitag. No solo simboliza la identidad del portador, sino que también es una herramienta para la comunicación remota"
  },
  RelicConfig_13762_BattleDesc = {
    Text = "Al jugar \"DEF\", se obtienen [Arg1] puntos <RetaliateIconKeywords:respuesta>"
  },
  RelicConfig_13762_Desc = {
    Text = "Al jugar \"DEF\", se obtienen [Arg1] puntos <RetaliateIconKeywords:respuesta>"
  },
  RelicConfig_13762_Name = {
    Text = "Chaleco de ortiga mutado"
  },
  RelicConfig_13762_StoryDesc = {
    Text = "No se puede identificar el líquido contaminado"
  },
  RelicConfig_13763_BattleDesc = {
    Text = "Al comenzar la batalla, recibes [Arg1] puntos de escudo. Al inicio del turno, si tienes escudo, ese turno tu escudo y la efectividad de curación aumentan un 50%"
  },
  RelicConfig_13763_Desc = {
    Text = "Al comenzar la batalla, recibes [Arg1] puntos de escudo. Al inicio del turno, si tienes escudo, ese turno tu escudo y la efectividad de curación aumentan un 50%"
  },
  RelicConfig_13763_Name = {
    Text = "Protector del jardín de alienación"
  },
  RelicConfig_13764_BattleDesc = {
    Text = "Al recoger, obtienes permanentemente [Arg1] puntos de <PowerIconKeywords:Fuerza>"
  },
  RelicConfig_13764_Desc = {
    Text = "Al recoger, obtienes permanentemente [Arg1] puntos de <PowerIconKeywords:Fuerza>"
  },
  RelicConfig_13764_Name = {
    Text = "<WhiteQuality:Broche de rubí>"
  },
  RelicConfig_13764_StoryDesc = {
    Text = "Se filtra un rojo tenue"
  },
  RelicConfig_13766_BattleDesc = {
    Text = "Al recoger, se elige una carta y se le otorgan dos efectos de refuerzo de tres opciones (Nota: similar a mil espejismos)"
  },
  RelicConfig_13766_Desc = {
    Text = "Al recoger, se elige una carta y se le otorgan dos efectos de refuerzo de tres opciones (Nota: similar a mil espejismos)"
  },
  RelicConfig_13766_Name = {
    Text = "<OrangeQuality:☆Máquina de escribir de autor☆>"
  },
  RelicConfig_13766_StoryDesc = {
    Text = "Dicen que las verdaderas obras maestras las escribe la máquina de escribir"
  },
  RelicConfig_13767_BattleDesc = {
    Text = "Al recoger, se obtiene una elección aleatoria de un alto plegaria avanzada entre 3, que se le otorga a la carta correspondiente"
  },
  RelicConfig_13767_Desc = {
    Text = "Al recoger, se obtiene una elección aleatoria de un alto plegaria avanzada entre 3, que se le otorga a la carta correspondiente"
  },
  RelicConfig_13767_Name = {
    Text = "<WhiteQuality:Papiro de Reind>"
  },
  RelicConfig_13767_StoryDesc = {
    Text = "A continuación, la pregunta: 10 monjes y 6 panes, ¿cuánto recibe cada uno?"
  },
  RelicConfig_13768_BattleDesc = {
    Text = "Aumenta el límite de aritmética en 2. Después de jugar \"golpear\" o \"defensa\", el despertador correspondiente obtiene 5 de alienación. Después de liberar la explosión de alienación, obtienes 1 \"golpear\" con consumo de oblivion del despertador correspondiente, y tras liberar la posse, obtienes aleatoriamente 1 \"defensa\" con consumo de oblivion."
  },
  RelicConfig_13768_Desc = {
    Text = "Aumenta el límite de aritmética en 2. Después de jugar \"golpear\" o \"defensa\", el despertador correspondiente obtiene 5 de alienación. Después de liberar la explosión de alienación, obtienes 1 \"golpear\" con consumo de Oblivion del despertador correspondiente, y después de liberar la Posse, obtienes aleatoriamente 1 \"defensa\" con consumo de Oblivion."
  },
  RelicConfig_13768_Name = {
    Text = "<OrangeQuality:péndulo crono\"Alas»>"
  },
  RelicConfig_13769_BattleDesc = {
    Text = "Al comienzo del turno, <EmbryoFusionIconKeywords:Fusión Embrionaria> +30. Todos tus efectos de <DevouredIconKeywords:Devorar> se convierten en <UnlimitedDevouredIconKeywords:Devoración Infinita>"
  },
  RelicConfig_13769_Desc = {
    Text = "Al comienzo del turno, <EmbryoFusionIconKeywords:Fusión Embrionaria> +30. Todos tus efectos de <DevouredIconKeywords:Devorar> se convierten en <UnlimitedDevouredIconKeywords:Devoración Infinita>"
  },
  RelicConfig_13769_Name = {
    Text = "<RedQuality:Cordón umbilical que se retuerce>"
  },
  RelicConfig_13769_StoryDesc = {
    Text = "Enredado en el cuello"
  },
  RelicConfig_13770_BattleDesc = {
    Text = "Al inicio del turno, obtén [Arg1] de escudo y aumenta este valor en [Arg2] cada turno"
  },
  RelicConfig_13770_Desc = {
    Text = "Al inicio del turno, obtén [Arg1] de escudo y aumenta este valor en [Arg2] cada turno"
  },
  RelicConfig_13770_Name = {
    Text = "<WhiteQuality:Mano protectora>"
  },
  RelicConfig_13770_StoryDesc = {
    Text = "Manos de bendición, puños firmes"
  },
  RelicConfig_13771_BattleDesc = {
    Text = "La recarga de llave de plata de todos los despertadores aumenta en 30. Después de liberar la llave, baraja 3 cartas <DerivativeCardKeywords_4:\"inspiración\"> en tu mazo"
  },
  RelicConfig_13771_Desc = {
    Text = "La recarga de llave de plata de todos los despertadores aumenta en 30. Después de liberar la llave, baraja 3 cartas <DerivativeCardKeywords_4:\"inspiración\"> en tu mazo"
  },
  RelicConfig_13771_Name = {
    Text = "<OrangeQuality:péndulo crono\"Sueño ligero\">"
  },
  RelicConfig_13772_BattleDesc = {
    Text = "Al finalizar la batalla, obtienes 75 el sigilo negro adicional y 1 carta de síntoma"
  },
  RelicConfig_13772_Desc = {
    Text = "Al finalizar la batalla, obtienes 75 el sigilo negro adicional y 1 carta de síntoma"
  },
  RelicConfig_13772_Name = {
    Text = "<RedQuality:Impresión de jade>"
  },
  RelicConfig_13772_StoryDesc = {
    Text = "Esta impresión es inmortal"
  },
  RelicConfig_13773_BattleDesc = {
    Text = "Cada vez que se causa 1 daño activo, se aplica a uno mismo [Arg1] capas <BleedingIconKeywords:sangrando> y se aplica a la meta [Arg2] capas <BleedingIconKeywords:sangrando>. Cada vez que se mata a un enemigo, se disipa el estado <BleedingIconKeywords:sangrando>"
  },
  RelicConfig_13773_Desc = {
    Text = "Cada vez que se causa 1 daño activo, se aplica a uno mismo [Arg1] capas <BleedingIconKeywords:sangrando> y se aplica a la meta [Arg2] capas <BleedingIconKeywords:sangrando>. Cada vez que se mata a un enemigo, se disipa el estado <BleedingIconKeywords:sangrando>"
  },
  RelicConfig_13773_Name = {
    Text = "<RedQuality:Conciencia del enjambre>"
  },
  RelicConfig_13773_StoryDesc = {
    Text = "Entretejer, simbiosis, agrupación; miedo, lo desconocido, control"
  },
  RelicConfig_13774_BattleDesc = {
    Text = "Al jugar una carta con un consumo de aritmética de 3, roba 1 carta y obtén 2 de aritmética; al jugar una carta con un consumo de aritmética de 4 o más, el consumo de aritmética de otras cartas en mano disminuye en 1"
  },
  RelicConfig_13774_Desc = {
    Text = "Al jugar una carta con un consumo de aritmética de 3, roba 1 carta y obtén 2 de aritmética; al jugar una carta con un consumo de aritmética de 4 o más, el consumo de aritmética de otras cartas en mano disminuye en 1"
  },
  RelicConfig_13774_Name = {
    Text = "<OrangeQuality:péndulo crono\"Ojo»>"
  },
  RelicConfig_13775_BattleDesc = {
    Text = "Al recoger, elige una carta de comando y aplícale \"Inherente\", \"Retener\" y \"Después de jugar, roba 1 carta\""
  },
  RelicConfig_13775_Desc = {
    Text = "Al recoger, elige una carta de comando y aplícale \"Inherente\", \"Retener\" y \"Después de jugar, roba 1 carta\""
  },
  RelicConfig_13775_Name = {
    Text = "<WhiteQuality:Carpeta>"
  },
  RelicConfig_13775_StoryDesc = {
    Text = "Shh, este es un trato secreto solo entre tú y yo"
  },
  RelicConfig_13776_BattleDesc = {
    Text = "Después de que comience la batalla, se obtiene 1 tentáculo"
  },
  RelicConfig_13776_Desc = {
    Text = "Después de que comience la batalla, se obtiene 1 tentáculo"
  },
  RelicConfig_13776_Name = {
    Text = "<WhiteQuality:Caracol amarillo>"
  },
  RelicConfig_13776_StoryDesc = {
    Text = "Este pequeño caracol amarillo tiene un origen noble, perfecto e impecable"
  },
  RelicConfig_13777_BattleDesc = {
    Text = "Al final de la ronda impar, si hay aritmética restante, roba 2 cartas en la siguiente ronda; al final de la ronda par, si hay cartas restantes, obtén 2 aritméticas en la siguiente ronda"
  },
  RelicConfig_13777_Desc = {
    Text = "Al final de la ronda impar, si hay aritmética restante, roba 2 cartas en la siguiente ronda; al final de la ronda par, si hay cartas restantes, obtén 2 aritméticas en la siguiente ronda"
  },
  RelicConfig_13777_Name = {
    Text = "<OrangeQuality:Rueda del Sol y la Luna>"
  },
  RelicConfig_13777_StoryDesc = {
    Text = "Adivina, ¿negro o blanco?"
  },
  RelicConfig_13778_BattleDesc = {
    Text = "Límite de tentáculos +1. Si la vida es inferior al 50%, <TentacleInjurieIconKeywords:daño de tentáculos> +[Arg1]"
  },
  RelicConfig_13778_Desc = {
    Text = "Límite de tentáculos +1. Si la vida es inferior al 50%, <TentacleInjurieIconKeywords:daño de tentáculos> +[Arg1]"
  },
  RelicConfig_13778_Name = {
    Text = "<OrangeQuality:Canción del Mar>"
  },
  RelicConfig_13778_StoryDesc = {
    Text = "Se dice que animales no comestibles como el caracol de tejido absorben alrededor del 80% de los nutrientes del océano"
  },
  RelicConfig_13779_BattleDesc = {
    Text = "Al inicio del turno, roba 1 carta. Al final del turno, puedes conservar 1 carta en la mano"
  },
  RelicConfig_13779_Desc = {
    Text = "Al inicio del turno, roba 1 carta. Al final del turno, puedes conservar 1 carta en la mano"
  },
  RelicConfig_13779_Name = {
    Text = "<OrangeQuality:Lámpara de deseos del profeta>"
  },
  RelicConfig_13779_StoryDesc = {
    Text = "Responde a tu deseo"
  },
  RelicConfig_13780_BattleDesc = {
    Text = "Cada vez que liberes Exaltar, obtienes 1 carta <DerivativeCardKeywords_7:\"Infusión tóxica\">; si tienes 3 cartas <DerivativeCardKeywords_7:\"Infusión tóxica\"> en la mano, combina para crear una <DerivativeCardKeywords_8:\"Brote tóxico\"> que activa <IntoxicationIconKeywords:veneno>."
  },
  RelicConfig_13780_Desc = {
    Text = "Cada vez que liberes Exaltar, obtendrás 1 carta <DerivativeCardKeywords_7:\"Infusión tóxica\">; si tienes 3 cartas <DerivativeCardKeywords_7:\"Infusión tóxica\"> en la mano, combina para crear una <DerivativeCardKeywords_8:\"Brote tóxico\"> que activa <IntoxicationIconKeywords:veneno>."
  },
  RelicConfig_13780_Name = {
    Text = "<OrangeQuality:Lengua extraña>"
  },
  RelicConfig_13780_StoryDesc = {
    Text = "No es un demonio, pero sí transmite susurros de más allá del mundo"
  },
  RelicConfig_13781_BattleDesc = {
    Text = "Por cada sello negro que se consuma, todos los despertadores obtienen 1 punto de locura"
  },
  RelicConfig_13781_Desc = {
    Text = "Por cada sello negro que se consuma, todos los despertadores obtienen 1 punto de locura"
  },
  RelicConfig_13781_Name = {
    Text = "Flor inversa"
  },
  RelicConfig_13782_BattleDesc = {
    Text = "Inmunidad al daño"
  },
  RelicConfig_13782_Desc = {
    Text = "Inmunidad al daño"
  },
  RelicConfig_13782_Name = {
    Text = "Creación de prueba"
  },
  RelicConfig_13783_BattleDesc = {
    Text = "Al jugar la tercera carta de cada turno, coloca 1 carta <DerivativeCardKeywords_4:\"inspiración\"> en el montón de descarte. Al jugar la sexta carta de cada turno, coloca 1 carta <DerivativeCardKeywords_4:\"inspiración\"> desde el montón de descarte a la mano"
  },
  RelicConfig_13783_Desc = {
    Text = "Al jugar la tercera carta de cada turno, coloca 1 carta <DerivativeCardKeywords_4:\"inspiración\"> en el montón de descarte. Al jugar la sexta carta de cada turno, coloca 1 carta <DerivativeCardKeywords_4:\"inspiración\"> desde el montón de descarte a la mano"
  },
  RelicConfig_13783_Name = {
    Text = "<WhiteQuality:Luz de civilización>"
  },
  RelicConfig_13783_StoryDesc = {
    Text = "Un meteoro rasgando la noche"
  },
  RelicConfig_13784_BattleDesc = {
    Text = "Al comienzo del turno, por cada enemigo obtienes 1 aritmética. Cuando matas un enemigo con daño activo, infliges <BleedingIconKeywords:sangrando> equivalente al daño sobrante a los otros enemigos"
  },
  RelicConfig_13784_Desc = {
    Text = "Al comienzo del turno, por cada enemigo obtienes 1 aritmética. Cuando matas un enemigo con daño activo, infliges <BleedingIconKeywords:sangrando> equivalente al daño sobrante a los otros enemigos"
  },
  RelicConfig_13784_Name = {
    Text = "<OrangeQuality:Canción de la Multitud>"
  },
  RelicConfig_13784_StoryDesc = {
    Text = "Nacido para torturar tus oídos"
  },
  RelicConfig_13785_BattleDesc = {
    Text = "Al final del turno, <EmbryoFusionIconKeywords:Fusión Embrionaria> +15, si hay <DerivativeCardKeywords_2:\"Embrión\"> en la mano, recupera [Arg1] de PV"
  },
  RelicConfig_13785_Desc = {
    Text = "Al final del turno, <EmbryoFusionIconKeywords:Fusión Embrionaria> +15, si hay <DerivativeCardKeywords_2:\"Embrión\"> en la mano, recupera [Arg1] de PV"
  },
  RelicConfig_13785_Name = {
    Text = "<WhiteQuality:Diagnóstico de plaga>"
  },
  RelicConfig_13785_StoryDesc = {
    Text = "Peste: una manifestación accidental de la inquietud inconsciente de la naturaleza"
  },
  RelicConfig_13786_BattleDesc = {
    Text = "Tras liberar la exhalación de aliemus, obtienes [Arg1] puntos temporales de <PowerIconKeywords:poder>"
  },
  RelicConfig_13786_Desc = {
    Text = "Tras liberar la exhalación de aliemus, obtienes [Arg1] puntos temporales de <PowerIconKeywords:poder>"
  },
  RelicConfig_13786_Name = {
    Text = "<WhiteQuality:Candado pesado>"
  },
  RelicConfig_13786_StoryDesc = {
    Text = "Un candado grueso y sólido, difícil de abrir sin llave.\nClaro, para un ladrón maestro no es nada"
  },
  RelicConfig_13787_BattleDesc = {
    Text = "Al inicio del turno, inflige [Arg1] de <FixedDamage:DMG Puro> a un enemigo aleatorio. Tras jugar \"golpear\" 7 veces en esta batalla, el DMG infligido cambiará a [Arg2]. Tras jugar \"golpear\" 21 veces, inflige instantáneamente [Arg3] de <FixedDamage:DMG Puro> a todos los enemigos."
  },
  RelicConfig_13787_Desc = {
    Text = "Al inicio del turno, inflige [Arg1] de <FixedDamage:DMG Puro> a un enemigo aleatorio. Tras jugar \"golpear\" 7 veces en esta batalla, el DMG infligido cambiará a [Arg2]. Tras jugar \"golpear\" 21 veces, inflige instantáneamente [Arg3] de <FixedDamage:DMG Puro> a todos los enemigos."
  },
  RelicConfig_13787_Name = {
    Text = "<OrangeQuality:Rompecabezas Viejo>"
  },
  RelicConfig_13787_StoryDesc = {
    Text = "La obra de arte enmarcada pesadamente siempre ha tenido una pieza faltante desde el día de su exhibición"
  },
  RelicConfig_13788_BattleDesc = {
    Text = "Límite de tentáculos -2. Al final del turno, todos los tentáculos atacan una vez más"
  },
  RelicConfig_13788_Desc = {
    Text = "Límite de tentáculos -2. Al final del turno, todos los tentáculos atacan una vez más"
  },
  RelicConfig_13788_Name = {
    Text = "<RedQuality:Brazo sagrado del dolor>"
  },
  RelicConfig_13788_StoryDesc = {
    Text = "Disfruta el sufrimiento"
  },
  RelicConfig_13789_BattleDesc = {
    Text = "Cada vez que se reinicia el mazo, obtienes [Arg1] <PowerIconKeywords:fuerza>"
  },
  RelicConfig_13789_Desc = {
    Text = "Cada vez que se reinicia el mazo, obtienes [Arg1] <PowerIconKeywords:fuerza>"
  },
  RelicConfig_13789_Name = {
    Text = "<WhiteQuality:Pipa llorona>"
  },
  RelicConfig_13789_StoryDesc = {
    Text = "¿Es esto el fruto del odio o el resultado de la venganza?"
  },
  RelicConfig_13790_BattleDesc = {
    Text = "Cada vez que se mueve en el mapa, obtendrá 10 el sigilo negro, pero el estrés mental causado por el movimiento en el mapa aumentará en 10 puntos"
  },
  RelicConfig_13790_Desc = {
    Text = "Cada vez que se mueve en el mapa, obtendrá 10 el sigilo negro, pero el estrés mental causado por el movimiento en el mapa aumentará en 10 puntos"
  },
  RelicConfig_13790_Name = {
    Text = "Bolsa sin fondo"
  },
  RelicConfig_13791_BattleDesc = {
    Text = "Al recoger esta creación, elige una carta de comando y añade una copia de ella a tu mazo"
  },
  RelicConfig_13791_Desc = {
    Text = "Al recoger esta creación, elige una carta de comando y añade una copia de ella a tu mazo"
  },
  RelicConfig_13791_Name = {
    Text = "<WhiteQuality:Fuego efímero>"
  },
  RelicConfig_13791_StoryDesc = {
    Text = "Luz oscilante, esperanza débil"
  },
  RelicConfig_13792_BattleDesc = {
    Text = "Cada vez que pierdas PV, <EmbryoFusionIconKeywords:Fusión Embrionaria>+10. Si los PV están por debajo del 50%, el efecto se duplica"
  },
  RelicConfig_13792_Desc = {
    Text = "Cada vez que pierdas PV, <EmbryoFusionIconKeywords:Fusión Embrionaria>+10. Si los PV están por debajo del 50%, el efecto se duplica"
  },
  RelicConfig_13792_Name = {
    Text = "<WhiteQuality:Sierra oxidada>"
  },
  RelicConfig_13792_StoryDesc = {
    Text = "El doctor de anatomía nunca ve a mujeres hermosas, solo un costal de huesos, nervios inflamados por enfermedades, músculos y tejidos"
  },
  RelicConfig_13793_BattleDesc = {
    Text = "Al recoger, el sigilo negro del equipo aumenta a un 150% del valor original. Tras recuperar vida, todos los despertadores obtienen 3 puntos de aliemus; al perder vida, obtienes [Arg1] puntos <PowerIconKeywords:poder> y daño de tentáculo, acumulándose un máximo de 5 veces por turno"
  },
  RelicConfig_13793_Desc = {
    Text = "Al recoger, el sigilo negro del equipo aumenta a un 150% del valor original. Tras recuperar vida, todos los despertadores obtienen 3 puntos de aliemus; al perder vida, obtienes [Arg1] puntos <PowerIconKeywords:poder> y daño de tentáculo, acumulándose un máximo de 5 veces por turno"
  },
  RelicConfig_13793_Name = {
    Text = "<OrangeQuality:péndulo temporal\"Luna\">"
  },
  RelicConfig_13794_BattleDesc = {
    Text = "Después de terminar el turno, todos los despertadores obtienen 5 de aliemus. Por cada 1 de aritmética restante, todos los despertadores obtendrán 3 de aliemus adicionales"
  },
  RelicConfig_13794_Desc = {
    Text = "Después de terminar el turno, todos los despertadores obtienen 5 de aliemus. Por cada 1 de aritmética restante, todos los despertadores obtendrán 3 de aliemus adicionales"
  },
  RelicConfig_13794_Name = {
    Text = "<OrangeQuality:Batería prototipo>"
  },
  RelicConfig_13794_StoryDesc = {
    Text = "Esperanza portátil"
  },
  RelicConfig_13795_BattleDesc = {
    Text = "Aumenta el límite de aritmética máxima en 1"
  },
  RelicConfig_13795_Desc = {
    Text = "Aumenta el límite de aritmética máxima en 1"
  },
  RelicConfig_13795_Name = {
    Text = "<WhiteQuality: inyector activo>"
  },
  RelicConfig_13795_StoryDesc = {
    Text = "Los espasmos también son una forma de actividad"
  },
  RelicConfig_13796_BattleDesc = {
    Text = "Al finalizar la batalla, si te queda menos del 50% de salud, asciende a una reliquia de plata"
  },
  RelicConfig_13796_Desc = {
    Text = "Al finalizar la batalla, si te queda menos del 50% de PV, asciende a una Creación de plata"
  },
  RelicConfig_13796_Name = {
    Text = "Cuaderno viejo 2"
  },
  RelicConfig_13796_StoryDesc = {
    Text = "Un viejo diario, cuyas páginas están llenas de insertos, que a simple vista contiene al menos un mapa de elworth, registros de experimentos y cartas llenas de d-marcas.\nEl contenido de las primeras notas está muy bien escrito, mientras que el resto se vuelve cada vez más desordenado"
  },
  RelicConfig_13797_BattleDesc = {
    Text = "Después de jugar 3 cartas de golpe, evoluciona a una reliquia de oro"
  },
  RelicConfig_13797_Desc = {
    Text = "Después de jugar 3 cartas de golpear, evoluciona a una Creación de oro"
  },
  RelicConfig_13797_Name = {
    Text = "Cuaderno viejo 1"
  },
  RelicConfig_13797_StoryDesc = {
    Text = "Un viejo diario, cuyas páginas están llenas de insertos, que a simple vista contiene al menos un mapa de elworth, registros de experimentos y cartas llenas de d-marcas.\nEl contenido de las primeras notas está muy bien escrito, mientras que el resto se vuelve cada vez más desordenado"
  },
  RelicConfig_13798_BattleDesc = {
    Text = "Al comienzo de la batalla, todas tus cartas de síntomas obtienen <NothingnessIconKeywords:ilusión>, y por cada carta de síntomas en el mazo, se obtienen [Arg1] <PowerIconKeywords:poder>"
  },
  RelicConfig_13798_Desc = {
    Text = "Al comienzo de la batalla, todas tus cartas de síntomas obtienen <NothingnessIconKeywords:ilusión>, y por cada carta de síntomas en el mazo, se obtienen [Arg1] <PowerIconKeywords:poder>"
  },
  RelicConfig_13798_Name = {
    Text = "<WhiteQuality:Elixir de Harford>"
  },
  RelicConfig_13798_StoryDesc = {
    Text = "Medicamento de composición desconocida.\nSe dice que el famoso violinista Eric lo prefiere"
  },
  RelicConfig_13799_BattleDesc = {
    Text = "Al inicio del primer turno de batalla, añade <DerivativeCardKeywords_1:\"Eco de Sombra\"> a tu mano; en el segundo turno, añade <DerivativeCardKeywords_41:\"Resonancia de Llave de Plata\"> a tu mano; en el tercer turno, añade <DerivativeCardKeywords_39:\"Eco del Pasado\"> a tu mano"
  },
  RelicConfig_13799_Desc = {
    Text = "Al inicio del primer turno de batalla, añade <DerivativeCardKeywords_1:\"Eco de Sombra\"> a tu mano; en el segundo turno, añade <DerivativeCardKeywords_41:\"Resonancia de Llave de Plata\"> a tu mano; en el tercer turno, añade <DerivativeCardKeywords_39:\"Eco del Pasado\"> a tu mano"
  },
  RelicConfig_13799_Name = {
    Text = "<OrangeQuality:péndulo crono\"Estrellas»>"
  },
  RelicConfig_13800_BattleDesc = {
    Text = "Al inicio del turno, añade 1 <DerivativeCardKeywords_6:\"Paraguas\"> a tu mano. Después de jugar 6 cartas, aumenta el <AlertIconKeywords:alerta> de todos los <DerivativeCardKeywords_6:\"Paraguas\"> en tu mano en [Arg2]"
  },
  RelicConfig_13800_Desc = {
    Text = "Al inicio del turno, añade 1 <DerivativeCardKeywords_6:\"Paraguas\"> a tu mano. Después de jugar 6 cartas, aumenta el <AlertIconKeywords:alerta> de todos los <DerivativeCardKeywords_6:\"Paraguas\"> en tu mano en [Arg2]"
  },
  RelicConfig_13800_Name = {
    Text = "<WhiteQuality:Paraguas de viaje>"
  },
  RelicConfig_13800_StoryDesc = {
    Text = "Florece en la tierra sin luz"
  },
  RelicConfig_13801_BattleDesc = {
    Text = "La vida de todos los enemigos en combate regular se incrementa en un 30%, obteniendo 25 el sigilo negro adicionales al ganar"
  },
  RelicConfig_13801_Desc = {
    Text = "La vida de todos los enemigos en combate regular se incrementa en un 30%, obteniendo 25 el sigilo negro adicionales al ganar"
  },
  RelicConfig_13801_Name = {
    Text = "Bandera de batalla rota"
  },
  RelicConfig_13802_BattleDesc = {
    Text = "Al recoger, se aumenta la salud máxima en [Arg1] puntos. Si la vida al recoger está por debajo del 25%, el aumento de la salud máxima se convierte en [Arg2] puntos"
  },
  RelicConfig_13802_Desc = {
    Text = "Al recoger, se aumenta la salud máxima en [Arg1] puntos. Si la vida al recoger está por debajo del 25%, el aumento de la salud máxima se convierte en [Arg2] puntos"
  },
  RelicConfig_13802_Name = {
    Text = "<WhiteQuality:Té de Ceilán>"
  },
  RelicConfig_13802_StoryDesc = {
    Text = "Dieta saludable, empieza contigo y conmigo"
  },
  RelicConfig_13803_BattleDesc = {
    Text = "Cada 3 turnos, obtén 3 tentáculos temporales"
  },
  RelicConfig_13803_Desc = {
    Text = "Cada 3 turnos, obtén 3 tentáculos temporales"
  },
  RelicConfig_13803_Name = {
    Text = "<WhiteQuality:Casco de buceo>"
  },
  RelicConfig_13803_StoryDesc = {
    Text = "¡Los sueños son estrellas y océanos!"
  },
  RelicConfig_13804_BattleDesc = {
    Text = "Al final del turno, obtén [Arg1] puntos de escudo. Si tu escudo es 0 o múltiplo de 3, obtén [Arg2] puntos de <PowerIconKeywords:Fuerza>"
  },
  RelicConfig_13804_Desc = {
    Text = "Al final del turno, obtén [Arg1] puntos de escudo. Si tu escudo es 0 o múltiplo de 3, obtén [Arg2] puntos de <PowerIconKeywords:Fuerza>"
  },
  RelicConfig_13804_Name = {
    Text = "<OrangeQuality:Señal de Socorro>"
  },
  RelicConfig_13804_StoryDesc = {
    Text = "No esperó el rescate"
  },
  RelicConfig_13806_BattleDesc = {
    Text = "Al obtener una carta de síntoma, ganas [Arg1] puntos temporales <PowerIconKeywords:poder>. Por cada reliquia maldita que poseas, aumentarás tu tasa crítica y daño crítico en un 10%"
  },
  RelicConfig_13806_Desc = {
    Text = "Al obtener una carta de síntoma, ganas [Arg1] puntos temporales <PowerIconKeywords:poder>. Por cada reliquia maldita que poseas, aumentarás tu tasa crítica y daño crítico en un 10%"
  },
  RelicConfig_13806_Name = {
    Text = "<OrangeQuality:Comunicación del Abismo>"
  },
  RelicConfig_13806_StoryDesc = {
    Text = "En las afueras desiertas, suena el teléfono en una cabina solitaria.\n\"Oscuridad... sss... infinita... sss... negra...\""
  },
  RelicConfig_13807_BattleDesc = {
    Text = "Al comenzar la batalla, <EmbryoFusionIconKeywords:Fusión Embrionaria>+50. Por cada Cuerpo Despertado con al menos 50 de Aliemus, se activa una vez adicional"
  },
  RelicConfig_13807_Desc = {
    Text = "Al comenzar la batalla, <EmbryoFusionIconKeywords:Fusión Embrionaria>+50. Por cada Cuerpo Despertado con al menos 50 de Aliemus, se activa una vez adicional"
  },
  RelicConfig_13807_Name = {
    Text = "<WhiteQuality:Querido Bebé>"
  },
  RelicConfig_13807_StoryDesc = {
    Text = "El carpintero hizo una marioneta vívida para su esposa, que reemplazaría a su hijo, durmiendo en su vientre"
  },
  RelicConfig_13808_BattleDesc = {
    Text = "Tras liberar la exhalación de aliemus, coloca una carta aleatoria correspondiente al despertador en tu mano, esa carta obtiene <DepleteIconKeywords:agotamiento> y <NothingnessIconKeywords:ilusión>. Al final del combate, recupera [Arg1] puntos de vida"
  },
  RelicConfig_13808_Desc = {
    Text = "Tras liberar la exhalación de aliemus, coloca una carta aleatoria correspondiente al despertador en tu mano, esa carta obtiene <DepleteIconKeywords:agotamiento> y <NothingnessIconKeywords:ilusión>. Al final del combate, recupera [Arg1] puntos de vida"
  },
  RelicConfig_13808_Name = {
    Text = "<WhiteQuality:Maletín de doctor>"
  },
  RelicConfig_13808_StoryDesc = {
    Text = "El maletín que simboliza la identidad de médico es muy pesado. \n\nNo siempre quien lo abre es un verdadero médico.\n"
  },
  RelicConfig_13809_BattleDesc = {
    Text = "El precio de todas las creaciones se reduce en 20"
  },
  RelicConfig_13809_Desc = {
    Text = "El precio de todas las creaciones se reduce en 20"
  },
  RelicConfig_13809_Name = {
    Text = "<WhiteQuality:Elocuencia>"
  },
  RelicConfig_13809_StoryDesc = {
    Text = "No solo los comerciantes son elocuentes, también los devotos"
  },
  RelicConfig_13811_BattleDesc = {
    Text = "Cada 3ª vez que se juega \"golpear\", inflige [Arg1] de <FixedDamage:DMG Puro> a todos los enemigos. El Despertado correspondiente obtiene 15 de Alienación."
  },
  RelicConfig_13811_Desc = {
    Text = "Cada 3ª vez que se juega \"golpear\", inflige [Arg1] de <FixedDamage:DMG Puro> a todos los enemigos. El Despertado correspondiente obtiene 15 de Alienación."
  },
  RelicConfig_13811_Name = {
    Text = "<WhiteQuality:Bisturí oxidado>"
  },
  RelicConfig_13811_StoryDesc = {
    Text = "No es adecuado para cortar tejido vivo"
  },
  RelicConfig_13812_BattleDesc = {
    Text = "Al recoger, se aumenta la salud máxima en un 100%, y al inicio del turno, se pierde [Arg1] puntos de vida"
  },
  RelicConfig_13812_Desc = {
    Text = "Al recoger, se aumenta la salud máxima en un 100%, y al inicio del turno, se pierde [Arg1] puntos de vida"
  },
  RelicConfig_13812_Name = {
    Text = "<RedQuality:☆Carne del inmortal☆>"
  },
  RelicConfig_13812_StoryDesc = {
    Text = "\"Las criaturas marinas suelen sacrificar extremidades para sobrevivir.\""
  },
  RelicConfig_13813_BattleDesc = {
    Text = "Después de que comience la batalla, la vida actual de los enemigos élites y jefes se reduce en un 20%"
  },
  RelicConfig_13813_Desc = {
    Text = "Después de que comience la batalla, la vida actual de los enemigos élites y jefes se reduce en un 20%"
  },
  RelicConfig_13813_Name = {
    Text = "<WhiteQuality:☆Ancla Vieja☆>"
  },
  RelicConfig_13813_StoryDesc = {
    Text = "Vuelve a casa, viejo marinero"
  },
  RelicConfig_13814_BattleDesc = {
    Text = "Al final del turno, por cada carta no jugada en tu mano, todos los Despertados ganan 2 Locura"
  },
  RelicConfig_13814_Desc = {
    Text = "Al final del turno, por cada carta no jugada en tu mano, todos los Despertados ganan 2 Locura"
  },
  RelicConfig_13814_Name = {
    Text = "<WhiteQuality:Balanza desequilibrada>"
  },
  RelicConfig_13814_StoryDesc = {
    Text = "Ya no simboliza justicia"
  },
  RelicConfig_13815_BattleDesc = {
    Text = "Al recoger, elige una carta, su costo de aritmética se volverá permanente 1"
  },
  RelicConfig_13815_Desc = {
    Text = "Al recoger, elige una carta, su costo de aritmética se volverá permanente 1"
  },
  RelicConfig_13815_Name = {
    Text = "<WhiteQuality:☆Ojo Artificial Refinado☆>"
  },
  RelicConfig_13815_StoryDesc = {
    Text = "Un ojo que ya no es puro"
  },
  RelicConfig_13816_BattleDesc = {
    Text = "Al comenzar la batalla, todos los enemigos reciben [Arg1] puntos <RetaliateIconKeywords:contraataque>. Cada vez que se inflige daño, el despertador con menos locura recibe 6 puntos de locura"
  },
  RelicConfig_13816_Desc = {
    Text = "Al comenzar la batalla, todos los enemigos reciben [Arg1] puntos <RetaliateIconKeywords:contraataque>. Cada vez que se inflige daño, el despertador con menos locura recibe 6 puntos de locura"
  },
  RelicConfig_13816_Name = {
    Text = "<RedQuality:☆Campana de lamento☆>"
  },
  RelicConfig_13816_StoryDesc = {
    Text = "Ding ling, ding ling, el niño llora;\nDing ling, ding ling, el niño grita.\nDing ling, ding ling, el niño gime;\nDing ling, ding ling, tiene hambre, lo sabes"
  },
  RelicConfig_13817_BattleDesc = {
    Text = "Después de jugar 6 cartas de comando, <TentacleInjurieIconKeywords:daño de tentáculo> +[Arg1]"
  },
  RelicConfig_13817_Desc = {
    Text = "Después de jugar 6 cartas de comando, <TentacleInjurieIconKeywords:daño de tentáculo> +[Arg1]"
  },
  RelicConfig_13817_Name = {
    Text = "<WhiteQuality:Parásito>"
  },
  RelicConfig_13817_StoryDesc = {
    Text = "Mientras nuestro cerebro siga siendo un misterio, no hay nada sorprendente en que esté lleno de tentáculos"
  },
  RelicConfig_13818_BattleDesc = {
    Text = "La tasa crítica aumenta un 50%, pero al comienzo de la batalla <FragileIconKeywords:frágil> por 3 turnos"
  },
  RelicConfig_13818_Desc = {
    Text = "La tasa crítica aumenta un 50%, pero al comienzo de la batalla <FragileIconKeywords:frágil> por 3 turnos"
  },
  RelicConfig_13818_Name = {
    Text = "<RedQuality:Garra extraña>"
  },
  RelicConfig_13818_StoryDesc = {
    Text = "Especie irreconocible"
  },
  RelicConfig_13819_BattleDesc = {
    Text = "Al jugar una carta con un consumo de aritmética de 3 o más, roba 1 carta y obtén 1 punto de aritmética"
  },
  RelicConfig_13819_Desc = {
    Text = "Al jugar una carta con un consumo de aritmética de 3 o más, roba 1 carta y obtén 1 punto de aritmética"
  },
  RelicConfig_13819_Name = {
    Text = "<OrangeQuality:☆Belleza perdida☆>"
  },
  RelicConfig_13819_StoryDesc = {
    Text = "Nadie recuerda su belleza"
  },
  RelicConfig_13820_BattleDesc = {
    Text = "Cada vez que obtenga una carta de síntoma, aumentará su salud máxima en [Arg1] puntos"
  },
  RelicConfig_13820_Desc = {
    Text = "Cada vez que obtenga una carta de síntoma, aumentará su salud máxima en [Arg1] puntos"
  },
  RelicConfig_13820_Name = {
    Text = "<WhiteQuality:☆Preparado de Incienso☆>"
  },
  RelicConfig_13820_StoryDesc = {
    Text = "\"Aroma dulce y tentador.\""
  },
  RelicConfig_13821_BattleDesc = {
    Text = "Tras liberar la exhalación de aliemus, roba 1 carta. Si la vida es inferior al 25%, roba 1 carta adicional"
  },
  RelicConfig_13821_Desc = {
    Text = "Tras liberar la exhalación de aliemus, roba 1 carta. Si la vida es inferior al 25%, roba 1 carta adicional"
  },
  RelicConfig_13821_Name = {
    Text = "<OrangeQuality:Rueda de Lectura del Conocimiento>"
  },
  RelicConfig_13821_StoryDesc = {
    Text = "Por favor, lee con precaución"
  },
  RelicConfig_13822_BattleDesc = {
    Text = "Al causar daño activo en cada turno, aumenta [Arg1] puntos de <TentacleInjurieIconKeywords:daño de tentáculo> temporalmente, acumulándose hasta 3 veces. Al alcanzar el máximo, genera 1 tentáculo temporal que ignora el límite de tentáculos"
  },
  RelicConfig_13822_Desc = {
    Text = "Al causar daño activo en cada turno, aumenta [Arg1] puntos de <TentacleInjurieIconKeywords:daño de tentáculo> temporalmente, acumulándose hasta 3 veces. Al alcanzar el máximo, genera 1 tentáculo temporal que ignora el límite de tentáculos"
  },
  RelicConfig_13822_Name = {
    Text = "<OrangeQuality:Placer de la Espiral>"
  },
  RelicConfig_13822_StoryDesc = {
    Text = "Señor del sueño eterno, espera tu entrada en el sueño"
  },
  RelicConfig_13823_BattleDesc = {
    Text = "La [Arg1] carta de comando que juegues tendrá un efecto adicional y volverá a tu mano"
  },
  RelicConfig_13823_Desc = {
    Text = "La [Arg1] carta de comando que juegues tendrá un efecto adicional y volverá a tu mano"
  },
  RelicConfig_13823_Name = {
    Text = "<OrangeQuality:Vino de las Estrellas+>"
  },
  RelicConfig_13823_StoryDesc = {
    Text = "Viajando entre las estrellas"
  },
  RelicConfig_13824_BattleDesc = {
    Text = "Al inicio de cada turno, <DeathResistanceIconKeywords:Resistencia a la Muerte> aumenta un 10% (en esta fase, cada vez que se activa la Resistencia a la Muerte, se reduce a la mitad). Cuando la <DeathResistanceIconKeywords:Resistencia a la Muerte> supera el 100%, <ProficientInRealmsIconKeywords:Maestría del Reino> aumenta 100."
  },
  RelicConfig_13824_Desc = {
    Text = "Al inicio de cada turno, <DeathResistanceIconKeywords:Resistencia a la muerte> aumenta un 10% (en esta fase, cada vez que se activa la Resistencia a la Muerte, se reduce a la mitad). Cuando la <DeathResistanceIconKeywords:Resistencia a la muerte> supera el 100%, <ProficientInRealmsIconKeywords:maestría en reinos> aumenta 100."
  },
  RelicConfig_13824_Name = {
    Text = "<WhiteQuality:Lágrima de sirena>"
  },
  RelicConfig_13824_StoryDesc = {
    Text = "No lo pongas en agua"
  },
  RelicConfig_13825_BattleDesc = {
    Text = "Cada vez que se consumen 10 sellos negros, se recuperan [Arg1] puntos de vida"
  },
  RelicConfig_13825_Desc = {
    Text = "Cada vez que se consumen 10 sellos negros, se recupera el 1% de vida"
  },
  RelicConfig_13825_Name = {
    Text = "Raíz inversa"
  },
  RelicConfig_13826_BattleDesc = {
    Text = "Cada vez que juegas una carta que no sea de Despertado, el Despertado con menos locura obtiene 10 locura"
  },
  RelicConfig_13826_Desc = {
    Text = "Cada vez que juegas una carta que no sea de Despertado, el Despertado con menos locura obtiene 10 locura"
  },
  RelicConfig_13826_Name = {
    Text = "<WhiteQuality:Álbum de sellos>"
  },
  RelicConfig_13826_StoryDesc = {
    Text = "Pensamientos cuantificados"
  },
  RelicConfig_13827_BattleDesc = {
    Text = "Al recoger, obtienes 75 sigilos negros. Elige 1 reliquia, transformándola en una reliquia maldita aleatoria"
  },
  RelicConfig_13827_Desc = {
    Text = "Al recoger, obtienes 75 sigilos negros. Elige 1 reliquia, transformándola en una reliquia maldita aleatoria"
  },
  RelicConfig_13827_Name = {
    Text = "<RedQuality:Lápida maldita>"
  },
  RelicConfig_13827_StoryDesc = {
    Text = "Al acariciar, escuchaste el llamado del mar profundo"
  },
  RelicConfig_13828_BattleDesc = {
    Text = "Después de que la primera carta de comando se juegue y vaya al montón de descarte en cada turno, se reduce temporalmente el costo de aritmética de esa carta en 1 y se baraja en el montón de robar"
  },
  RelicConfig_13828_Desc = {
    Text = "Después de que la primera carta de comando se juegue y vaya al montón de descarte en cada turno, se reduce temporalmente el costo de aritmética de esa carta en 1 y se baraja en el montón de robar"
  },
  RelicConfig_13828_Name = {
    Text = "<WhiteQuality:Gramófono mudo>"
  },
  RelicConfig_13828_StoryDesc = {
    Text = "Su voz se perdió en el viento"
  },
  RelicConfig_13829_BattleDesc = {
    Text = "Un manojo de llaves oxidadas. Puede usarse para abrir cerraduras"
  },
  RelicConfig_13829_Desc = {
    Text = "Un manojo de llaves oxidadas. Puede usarse para abrir cerraduras"
  },
  RelicConfig_13829_Name = {
    Text = "Llave oxidada"
  },
  RelicConfig_13830_BattleDesc = {
    Text = "Al curar vida, también obtén [Arg1] puntos de escudo. A partir del tercer turno, obtén [Arg2] puntos de <AlertIconKeywords:alerta>"
  },
  RelicConfig_13830_Desc = {
    Text = "Al curar vida, también obtén [Arg1] puntos de escudo. A partir del tercer turno, obtén [Arg2] puntos de <AlertIconKeywords:alerta>"
  },
  RelicConfig_13830_Name = {
    Text = "<WhiteQuality: especimen de mariposa>"
  },
  RelicConfig_13830_StoryDesc = {
    Text = "Hasta ahora, alguien lo ha amado profundamente"
  },
  RelicConfig_13831_BattleDesc = {
    Text = "Cada vez que una carta de comando entra en el <DimensionalSpaceIconKeywords:espacio dimensional>, el Despertado correspondiente obtiene 15 locura"
  },
  RelicConfig_13831_Desc = {
    Text = "Cada vez que una carta de comando entra en el <DimensionalSpaceIconKeywords:espacio dimensional>, el Despertado correspondiente obtiene 15 locura"
  },
  RelicConfig_13831_Name = {
    Text = "<WhiteQuality:Gusano del tiempo>"
  },
  RelicConfig_13831_StoryDesc = {
    Text = "Un reloj de bolsillo que existe simultáneamente en una tienda de relojes y en un museo de insectos.\nDespués del primer año de la era Holocénica, fue incluido en la colección universitaria"
  },
  RelicConfig_13832_BattleDesc = {
    Text = "Entrando en la ronda ultra, elimina el estado de <WeaknessIconKeywords:debilidad> y <FragileIconKeywords:frágil>, y <WeaknessIconKeywords:debilidad> y <VulnerabilityIconKeywords:vulnerable> a todos los enemigos por 3 rondas. El daño final de todos los despertadores en esta ronda aumenta un 15%"
  },
  RelicConfig_13832_Desc = {
    Text = "Entrando en la ronda ultra, elimina el estado de <WeaknessIconKeywords:debilidad> y <FragileIconKeywords:frágil>, y <WeaknessIconKeywords:debilidad> y <VulnerabilityIconKeywords:vulnerable> a todos los enemigos por 3 rondas. El daño final de todos los despertadores en esta ronda aumenta un 15%"
  },
  RelicConfig_13832_Name = {
    Text = "<WhiteQuality:Reloj hipercuerda>"
  },
  RelicConfig_13832_StoryDesc = {
    Text = "\"Vaya, el reloj se detuvo.\""
  },
  RelicConfig_13833_BattleDesc = {
    Text = "Cada vez que se causa 1 daño, se aplica a la meta [Arg1] capas <IntoxicationIconKeywords:veneno>. Si se alcanza un total acumulado de 25 activaciones dentro de esta batalla, se activa inmediatamente el <IntoxicationIconKeywords:veneno> en todos los enemigos"
  },
  RelicConfig_13833_Desc = {
    Text = "Cada vez que se causa 1 daño, se aplica a la meta [Arg1] capas <IntoxicationIconKeywords:veneno>. Si se alcanza un total acumulado de 25 activaciones dentro de esta batalla, se activa inmediatamente el <IntoxicationIconKeywords:veneno> en todos los enemigos"
  },
  RelicConfig_13833_Name = {
    Text = "<OrangeQuality:☆Máquina de coser polvorienta☆>"
  },
  RelicConfig_13833_StoryDesc = {
    Text = "Una madre cariñosa, remendando las heridas del corazón"
  },
  RelicConfig_13834_BattleDesc = {
    Text = "Cada quinta vez que se obtiene un escudo, se obtiene <RetaliateIconKeywords:contraataque>, cuyo valor de contraataque es igual al [Arg1]% del escudo obtenido"
  },
  RelicConfig_13834_Desc = {
    Text = "Cada quinta vez que se obtiene un escudo, se obtiene <RetaliateIconKeywords:contraataque>, cuyo valor de contraataque es igual al [Arg1]% del escudo obtenido"
  },
  RelicConfig_13834_Name = {
    Text = "<OrangeQuality:Fragmentos de sabiduría>"
  },
  RelicConfig_13834_StoryDesc = {
    Text = "\"Los humanos son tan tontos, creen ciegamente en lo obsoleto.\""
  },
  RelicConfig_13835_BattleDesc = {
    Text = "Al inicio del turno, roba 1 carta"
  },
  RelicConfig_13835_Desc = {
    Text = "Al inicio del turno, roba 1 carta"
  },
  RelicConfig_13835_Name = {
    Text = "<WhiteQuality:Brújula>"
  },
  RelicConfig_13835_StoryDesc = {
    Text = "No indica dirección, solo el campo magnético"
  },
  RelicConfig_13836_BattleDesc = {
    Text = "Al inicio de la batalla, coloca aleatoriamente <DerivativeCardKeywords_3:\"Convulsión\"> y <DerivativeCardKeywords_4:\"Conocimiento\"> en <DimensionalSpaceIconKeywords:Espacio Hiperspacial> hasta alcanzar el límite. Al entrar en el turno ultra, obtén [Arg1] puntos de <PowerIconKeywords:Fuerza>."
  },
  RelicConfig_13836_Desc = {
    Text = "Al inicio de la batalla, coloca aleatoriamente <DerivativeCardKeywords_3:\"Convulsión\"> y <DerivativeCardKeywords_4:\"Conocimiento\"> en el <DimensionalSpaceIconKeywords:Espacio Hiperspacial> hasta alcanzar el límite. Al entrar en el turno ultra, obtén [Arg1] puntos de <PowerIconKeywords:Fuerza>."
  },
  RelicConfig_13836_Name = {
    Text = "<RedQuality:Artefacto de Alfonso>"
  },
  RelicConfig_13836_StoryDesc = {
    Text = "A diferencia del destino cambiante, las estrellas tienen sus propias leyes"
  },
  RelicConfig_13837_BattleDesc = {
    Text = "Al recoger, obtienes un 100% de <DeathResistanceIconKeywords:Resistencia a la Muerte> (en esta fase, cada vez que se activa la Resistencia a la Muerte, se reduce a la mitad). Después de activar la Resistencia a la Muerte, al inicio de cada turno en esta batalla, recuperas [Arg1] puntos de vida"
  },
  RelicConfig_13837_Desc = {
    Text = "Al recoger, obtienes un 100% de <DeathResistanceIconKeywords:Resistencia a la Muerte> (en esta fase, cada vez que se activa la Resistencia a la Muerte, se reduce a la mitad). Después de activar la Resistencia a la Muerte, al inicio de cada turno en esta batalla, recuperas [Arg1] puntos de vida"
  },
  RelicConfig_13837_Name = {
    Text = "<WhiteQuality:Respiración Artificial>"
  },
  RelicConfig_13837_StoryDesc = {
    Text = "Un artículo esencial para los exploradores. Si dependes demasiado de él, se convertirá en parte de ti"
  },
  RelicConfig_13838_BattleDesc = {
    Text = "Es un objeto de misión sin efecto 2"
  },
  RelicConfig_13838_Desc = {
    Text = "Es un objeto de misión sin efecto 2"
  },
  RelicConfig_13838_Name = {
    Text = "Prueba de creación de misión 2"
  },
  RelicConfig_13838_StoryDesc = {
    Text = "Requiere contenido adicional para la creación"
  },
  RelicConfig_13839_BattleDesc = {
    Text = "Roba 2 cartas al jugar la última carta de tu mano. Máximo 2 veces por turno"
  },
  RelicConfig_13839_Desc = {
    Text = "Roba 2 cartas al jugar la última carta de tu mano. Máximo 2 veces por turno"
  },
  RelicConfig_13839_Name = {
    Text = "<WhiteQuality:☆Guantes de Magia☆>"
  },
  RelicConfig_13839_StoryDesc = {
    Text = "\"No temas, esto es solo magia.\""
  },
  RelicConfig_13840_BattleDesc = {
    Text = "Cada 3 turnos, se añade 1 nivel de <WeaknessIconKeywords:debilidad> a todos los enemigos. Al infligir daño a enemigos <WeaknessIconKeywords:debilidad>, se ganarán [Arg1] puntos de <PowerIconKeywords:poder> temporalmente, con un máximo de 3 activaciones por turno"
  },
  RelicConfig_13840_Desc = {
    Text = "Cada 3 turnos, se añade 1 nivel de <WeaknessIconKeywords:Síntoma: Debilidad> a todos los enemigos. Al infligir daño a enemigos con <WeaknessIconKeywords:Síntoma: Debilidad>, se ganarán [Arg1] puntos de <PowerIconKeywords:FUE> Temporal, con un máximo de 3 activaciones por turno"
  },
  RelicConfig_13840_Name = {
    Text = "<WhiteQuality:Niño travieso>"
  },
  RelicConfig_13840_StoryDesc = {
    Text = "Nacido del mal puro, aunque no sea su deseo"
  },
  RelicConfig_13841_BattleDesc = {
    Text = "Todo \"Golpe\" inflige un 20% más de daño crítico. Al comenzar la batalla, añade una <DerivativeCardKeywords_40:\"Hermoso Momento\"> a tu mano"
  },
  RelicConfig_13841_Desc = {
    Text = "Todo \"Golpe\" inflige un 20% más de daño crítico. Al comenzar la batalla, añade una <DerivativeCardKeywords_40:\"Hermoso Momento\"> a tu mano"
  },
  RelicConfig_13841_Name = {
    Text = "<WhiteQuality:Momento hermoso>"
  },
  RelicConfig_13841_StoryDesc = {
    Text = "Preserva la belleza efímera para siempre"
  },
  RelicConfig_13842_BattleDesc = {
    Text = "Inmunidad a un daño fatal que no activó resistencia a la muerte, recupera [Arg1] de vida y hace que esa reliquia quede permanentemente inactiva"
  },
  RelicConfig_13842_Desc = {
    Text = "Inmunidad a un daño fatal que no activó resistencia a la muerte, recupera [Arg1] de vida y hace que esa reliquia quede permanentemente inactiva"
  },
  RelicConfig_13842_Name = {
    Text = "<OrangeQuality:Muñeco Sustituto>"
  },
  RelicConfig_13842_StoryDesc = {
    Text = "Jejeje, jejeje. ¿Me debes, no?"
  },
  RelicConfig_13844_BattleDesc = {
    Text = "Cuando causas <WeaknessIconKeywords:debilidad>, obtienes [Arg1] puntos de escudo; cuando causas <VulnerabilityIconKeywords:vulnerable>, obtienes [Arg2] puntos de <PowerIconKeywords:fuerza> temporal. Si desencadenas estos dos efectos en un mismo turno, obtienes adicionalmente [Arg1] puntos de escudo y [Arg2] puntos de <PowerIconKeywords:fuerza> temporal."
  },
  RelicConfig_13844_Desc = {
    Text = "Cuando causes <WeaknessIconKeywords:debilidad>, obtendrás [Arg1] puntos de escudo; cuando causes <VulnerabilityIconKeywords:vulnerable>, obtendrás [Arg2] puntos de <PowerIconKeywords:fuerza> temporal. Si desencadenas estos dos efectos en un mismo turno, obtendrás adicionalmente [Arg1] puntos de escudo y [Arg2] puntos de <PowerIconKeywords:fuerza> temporal."
  },
  RelicConfig_13844_Name = {
    Text = "<OrangeQuality:Marco Pesado>"
  },
  RelicConfig_13844_StoryDesc = {
    Text = "La última obra de un artista demente, dicen que refleja su rostro aterrorizado"
  },
  RelicConfig_13845_BattleDesc = {
    Text = "Al agotar el último punto de aritmética, obtienes 2 aritméticas. Se puede activar un máximo de 2 veces por turno"
  },
  RelicConfig_13845_Desc = {
    Text = "Al agotar el último punto de aritmética, obtienes 2 aritméticas. Se puede activar un máximo de 2 veces por turno"
  },
  RelicConfig_13845_Name = {
    Text = "<OrangeQuality:☆Máquina diferencial plateada☆>"
  },
  RelicConfig_13845_StoryDesc = {
    Text = "\"Cambió la historia.\""
  },
  RelicConfig_13846_BattleDesc = {
    Text = "Cada vez que pierdes vida, obtienes [Arg1] puntos de <PowerIconKeywords:fuerza>, máximo 10 veces por batalla. Al alcanzar el máximo, recuperas 25% de la vida perdida"
  },
  RelicConfig_13846_Desc = {
    Text = "Cada vez que pierdes vida, obtienes [Arg1] puntos de <PowerIconKeywords:fuerza>, máximo 10 veces por batalla. Al alcanzar el máximo, recuperas 25% de la vida perdida"
  },
  RelicConfig_13846_Name = {
    Text = "<OrangeQuality:Supremo Honor>"
  },
  RelicConfig_13846_StoryDesc = {
    Text = "Un gato negro elegante y misterioso, considerado una deidad en tierras desérticas lejanas. Pero el nombre de esa deidad ya nadie lo recuerda.\nSer adorado, venerado y olvidado, tal vez sea el destino de los dioses"
  },
  RelicConfig_13847_BattleDesc = {
    Text = "Inflige un 20% más de daño a enemigos con estados negativos, y el asesino obtiene 20 de locura al matar"
  },
  RelicConfig_13847_Desc = {
    Text = "Inflige un 20% más de daño a enemigos con estados negativos, y el asesino obtiene 20 de locura al matar"
  },
  RelicConfig_13847_Name = {
    Text = "<OrangeQuality:Cetro del Sacerdote>"
  },
  RelicConfig_13847_StoryDesc = {
    Text = "Devoción no permitida"
  },
  RelicConfig_13848_BattleDesc = {
    Text = "Al recoger, la Maestría de Dominio del equipo aumenta al 150% del valor original. Después de jugar la quinta carta de comando en cada turno, todos los Despertados obtienen 20 puntos de Locura"
  },
  RelicConfig_13848_Desc = {
    Text = "Al recoger, la Maestría de Dominio del equipo aumenta al 150% del valor original. Después de jugar la quinta carta de comando en cada turno, todos los Despertados obtienen 20 puntos de Locura"
  },
  RelicConfig_13848_Name = {
    Text = "<OrangeQuality: Péndulo crono\"Impuro\">"
  },
  RelicConfig_13849_BattleDesc = {
    Text = "Cada turno, tras infligir el 3º daño, obtiene [Arg1] puntos de escudo. Tras infligir el 6º daño, obtiene [Arg2] puntos de <PowerIconKeywords:Fuerza>"
  },
  RelicConfig_13849_Desc = {
    Text = "Cada turno, tras infligir el 3º daño, obtiene [Arg1] puntos de escudo. Tras infligir el 6º daño, obtiene [Arg2] puntos de <PowerIconKeywords:Fuerza>"
  },
  RelicConfig_13849_Name = {
    Text = "<WhiteQuality:Salida de emergencia>"
  },
  RelicConfig_13849_StoryDesc = {
    Text = "Parece que él tampoco pudo escapar"
  },
  RelicConfig_13851_BattleDesc = {
    Text = "Cada activación de <DevouredIconKeywords:Devorar> roba [Arg1] de <PowerIconKeywords:Fuerza> temporal a todos los enemigos"
  },
  RelicConfig_13851_Desc = {
    Text = "Cada activación de <DevouredIconKeywords:Devorar> roba [Arg1] de <PowerIconKeywords:Fuerza> temporal a todos los enemigos"
  },
  RelicConfig_13851_Name = {
    Text = "<OrangeQuality:Manos hábiles>"
  },
  RelicConfig_13851_StoryDesc = {
    Text = "La herramienta perfecta para asesinar y robar"
  },
  RelicConfig_13852_BattleDesc = {
    Text = "Al recoger, se elige un despertador para despertar, y el consumo de aritmética de su carta de despertar se reduce permanentemente en 1"
  },
  RelicConfig_13852_Desc = {
    Text = "Al recoger, se elige un despertador para despertar, y el consumo de aritmética de su carta de despertar se reduce permanentemente en 1"
  },
  RelicConfig_13852_Name = {
    Text = "<WhiteQuality:Tiempo de huevos de Pascua>"
  },
  RelicConfig_13852_StoryDesc = {
    Text = "Disfruta, pero no comas"
  },
  RelicConfig_13853_BattleDesc = {
    Text = "Cada vez que cause Daño, obtendrá [Arg1] puntos Temporales de <RetaliateIconKeywords:Contador>, con un máximo de 5 activaciones por turno. La quinta activación colocará una <DerivativeCardKeywords_4:\"Inspiración\"> en el Mazo de robo."
  },
  RelicConfig_13853_Desc = {
    Text = "Cada vez que cause Daño, obtendrá [Arg1] puntos Temporales de <RetaliateIconKeywords:Contador>, con un máximo de 5 activaciones por turno. La quinta activación colocará una <DerivativeCardKeywords_4:\"Inspiración\"> en el Mazo de robo."
  },
  RelicConfig_13853_Name = {
    Text = "<WhiteQuality:Cuchillo ritual perdido>"
  },
  RelicConfig_13853_StoryDesc = {
    Text = "Daga de hoja curva, comúnmente usada en rituales"
  },
  RelicConfig_13854_BattleDesc = {
    Text = "Al comienzo del turno, roba 2 cartas y gana 2 puntos de aritmética. Cada vez que robas 1 carta de comando o un despertar de gnosis, cambia aleatoriamente su coste de aritmética. (0-4)"
  },
  RelicConfig_13854_Desc = {
    Text = "Al comienzo del turno, roba 2 cartas y gana 2 puntos de aritmética. Cada vez que robas 1 carta de comando o un despertar de gnosis, cambia aleatoriamente su coste de aritmética. (0-4)"
  },
  RelicConfig_13854_Name = {
    Text = "<RedQuality: sombrero mágico>"
  },
  RelicConfig_13854_StoryDesc = {
    Text = "¡Bienvenido al circo de la señorita Casiah! Ten cuidado, no toques los objetos mágicos al azar. Si accidentalmente te muerden, eso sería un desastre. \n Después de todo, la última vez que probó la sangre, las consecuencias fueron realmente terroríficas. \n\n El sombrero parpadeó, como si estuviera a punto de salir de su capullo."
  },
  RelicConfig_13855_BattleDesc = {
    Text = "Al inicio del turno y cada vez que se recuperan PV, gana [Arg1] de <RetaliateIconKeywords:Contador>. Puede ocurrir hasta 3 veces por turno. Al alcanzar el límite, activa un <RetaliateIconKeywords:Contador> del 100% contra todos los enemigos."
  },
  RelicConfig_13855_Desc = {
    Text = "Al inicio del turno y cada vez que se recuperan PV, gana [Arg1] de <RetaliateIconKeywords:Contador>. Puede ocurrir hasta 3 veces por turno. Al alcanzar el límite, activa un <RetaliateIconKeywords:Contador> del 100% contra todos los enemigos."
  },
  RelicConfig_13855_Name = {
    Text = "<OrangeQuality:Cajita de música>"
  },
  RelicConfig_13855_StoryDesc = {
    Text = "La mansión de Dexter tiene muchas colecciones. Antes de romperse, la pequeña caja de música era el juguete favorito de la pequeña señorita Dexter.\nCon el paso del tiempo, cuando la señorita Dexter la encontró de nuevo, sus engranajes estaban sueltos y la música desafinada, pero aún giraba"
  },
  RelicConfig_13856_BattleDesc = {
    Text = "Incremento del daño crítico del 15%. La tasa crítica de \"golpe\" aumenta un 40%"
  },
  RelicConfig_13856_Desc = {
    Text = "Incremento del daño crítico del 15%. La tasa crítica de \"golpe\" aumenta un 40%"
  },
  RelicConfig_13856_Name = {
    Text = "<WhiteQuality:Pico de cuervo blanco>"
  },
  RelicConfig_13856_StoryDesc = {
    Text = "No hay secretos ante él"
  },
  RelicConfig_13857_BattleDesc = {
    Text = "Tras liberar la exhalación de aliemus, obtienes [Arg1] puntos de <RetaliateIconKeywords:mostrador>. Si se activa por sexta vez en este combate, duplica tu <RetaliateIconKeywords:mostrador>"
  },
  RelicConfig_13857_Desc = {
    Text = "Tras liberar la exhalación de aliemus, obtienes [Arg1] puntos de <RetaliateIconKeywords:mostrador>. Si se activa por sexta vez en este combate, duplica tu <RetaliateIconKeywords:mostrador>"
  },
  RelicConfig_13857_Name = {
    Text = "<OrangeQuality:☆Sextante☆>"
  },
  RelicConfig_13857_StoryDesc = {
    Text = "Solo te guiará por el camino equivocado"
  },
  RelicConfig_13858_BattleDesc = {
    Text = "Cada turno roba 1 carta adicional, gana 1 punto de aritmética"
  },
  RelicConfig_13858_Desc = {
    Text = "Cada turno roba 1 carta adicional, gana 1 punto de aritmética"
  },
  RelicConfig_13858_Name = {
    Text = "<OrangeQuality:☆Recuerdos felices☆>"
  },
  RelicConfig_13858_StoryDesc = {
    Text = "Alguien se quedó para siempre en ese verano"
  },
  RelicConfig_13859_BattleDesc = {
    Text = "Al inicio del turno, roba 1 carta. Al inicio de la batalla, baraja 1 carta de <DerivativeCardKeywords_4:\"Inspiración\"> en tu mazo. Cada batalla completada aumenta la cantidad de <DerivativeCardKeywords_4:\"Inspiración\"> barajadas en 1, hasta 3 veces"
  },
  RelicConfig_13859_Desc = {
    Text = "Al inicio del turno, roba 1 carta. Al inicio de la batalla, baraja 1 carta de <DerivativeCardKeywords_4:\"Inspiración\"> en tu mazo. Cada batalla completada aumenta la cantidad de <DerivativeCardKeywords_4:\"Inspiración\"> barajadas en 1, hasta 3 veces"
  },
  RelicConfig_13859_Name = {
    Text = "<OrangeQuality:Espejo de Prasno>"
  },
  RelicConfig_13859_StoryDesc = {
    Text = "Truco de luz y sombra"
  },
  RelicConfig_13860_BattleDesc = {
    Text = "Cada vez que juegues consecutivamente cartas del mismo Despertado, ese Despertado obtiene 8 puntos de locura"
  },
  RelicConfig_13860_Desc = {
    Text = "Cada vez que juegues consecutivamente cartas del mismo Despertado, ese Despertado obtiene 8 puntos de locura"
  },
  RelicConfig_13860_Name = {
    Text = "<WhiteQuality:Cronómetro>"
  },
  RelicConfig_13860_StoryDesc = {
    Text = "Uno de los inventos más malvados de la humanidad"
  },
  RelicConfig_13861_BattleDesc = {
    Text = "Al recoger, se elige una carta de un despertador, se reduce su consumo de aritmética en 1, y se considera \"golpe\""
  },
  RelicConfig_13861_Desc = {
    Text = "Al recoger, se elige una carta de un despertador, se reduce su consumo de aritmética en 1, y se considera \"golpe\""
  },
  RelicConfig_13861_Name = {
    Text = "<OrangeQuality:Error fortuito>"
  },
  RelicConfig_13861_StoryDesc = {
    Text = "¡Ríe a carcajadas!"
  },
  RelicConfig_13862_BattleDesc = {
    Text = "Al recoger, pierdes permanentemente [Arg1] <PowerIconKeywords:Fuerza>. Cada vez que causas daño, recuperas [Arg2] puntos de vida, hasta 6 veces por turno"
  },
  RelicConfig_13862_Desc = {
    Text = "Al recoger, pierdes permanentemente [Arg1] <PowerIconKeywords:Fuerza>. Cada vez que causas daño, recuperas [Arg2] puntos de vida, hasta 6 veces por turno"
  },
  RelicConfig_13862_Name = {
    Text = "<RedQuality:Beso de la lamprea>"
  },
  RelicConfig_13862_StoryDesc = {
    Text = "¿Quieres un beso profundo? ¿De esos que matan?"
  },
  RelicConfig_13863_BattleDesc = {
    Text = "En el primer turno de cada batalla, obtienes 3 puntos de aritmética"
  },
  RelicConfig_13863_Desc = {
    Text = "En el primer turno de cada batalla, obtienes 3 puntos de aritmética"
  },
  RelicConfig_13863_Name = {
    Text = "<WhiteQuality: espejo del reloj de bolsillo>"
  },
  RelicConfig_13863_StoryDesc = {
    Text = "La memoria se congela en el tiempo pasado, enterrada en el fondo negro"
  },
  RelicConfig_13864_BattleDesc = {
    Text = "Después de jugar la primera carta de comando cada turno, coloca 1 \"golpe\" del despertador correspondiente en la mano, dotándola de <NothingnessIconKeywords:ilusión> y <DepleteIconKeywords:agotamiento>"
  },
  RelicConfig_13864_Desc = {
    Text = "Después de jugar la primera carta de comando cada turno, coloca 1 \"golpe\" del despertador correspondiente en la mano, dotándola de <NothingnessIconKeywords:ilusión> y <DepleteIconKeywords:agotamiento>"
  },
  RelicConfig_13864_Name = {
    Text = "<WhiteQuality:Eje nuevo>"
  },
  RelicConfig_13864_StoryDesc = {
    Text = "De la aldea a la ciudad, del desastre a la recuperación"
  },
  RelicConfig_13865_BattleDesc = {
    Text = "Después de jugar la primera carta de comando cada turno, coloca 1 \"defensa\" del despertador correspondiente en la mano y añade <NothingnessIconKeywords:ilusión> y <DepleteIconKeywords:agotamiento>"
  },
  RelicConfig_13865_Desc = {
    Text = "Después de jugar la primera carta de comando cada turno, coloca 1 \"defensa\" del despertador correspondiente en la mano y añade <NothingnessIconKeywords:ilusión> y <DepleteIconKeywords:agotamiento>"
  },
  RelicConfig_13865_Name = {
    Text = "<WhiteQuality:Preludio silencioso>"
  },
  RelicConfig_13865_StoryDesc = {
    Text = "El violín del famoso violinista Eric Eckstein.\nHoy en día, ya no puede tocarse"
  },
  RelicConfig_13866_BattleDesc = {
    Text = "Cada 3 turnos, se añade 1 nivel de <VulnerabilityIconKeywords:vulnerable> a todos los enemigos. Cuando se inflige daño a los enemigos <VulnerabilityIconKeywords:vulnerable>, perderán [Arg1] puntos de <PowerIconKeywords:poder> temporalmente, con un máximo de 3 activaciones por turno"
  },
  RelicConfig_13866_Desc = {
    Text = "Cada 3 turnos, se añade 1 nivel de <VulnerabilityIconKeywords:vulnerable> a todos los enemigos. Cuando se inflige daño a los enemigos <VulnerabilityIconKeywords:vulnerable>, perderán [Arg1] puntos de <PowerIconKeywords:poder> temporalmente, con un máximo de 3 activaciones por turno"
  },
  RelicConfig_13866_Name = {
    Text = "<WhiteQuality:Rito de primavera>"
  },
  RelicConfig_13866_StoryDesc = {
    Text = "En las risas nocturnas, la silueta de la canoa se desliza libremente sobre el lago"
  },
  RelicConfig_13867_BattleDesc = {
    Text = "Límite de cartas en mano aumentado en 3, pero el número de cartas robadas por turno disminuye en 1. Al final del turno, descarta todas las cartas de síntoma y de estado en mano, conserva otras cartas"
  },
  RelicConfig_13867_Desc = {
    Text = "Límite de cartas en mano aumentado en 3, pero el número de cartas robadas por turno disminuye en 1. Al final del turno, descarta todas las cartas de síntoma y de estado en mano, conserva otras cartas"
  },
  RelicConfig_13867_Name = {
    Text = "<RedQuality:Inscripción de conciencia>"
  },
  RelicConfig_13867_StoryDesc = {
    Text = "La antigua tribu creía que grabar símbolos especiales en la cabeza de los muertos podía retener su alma y obtener su compañía eterna"
  },
  RelicConfig_13868_BattleDesc = {
    Text = "Después de liberar 4 exaltaciones, el costo de aritmética de todas las cartas en mano se reduce en 1"
  },
  RelicConfig_13868_Desc = {
    Text = "Después de liberar 4 exaltaciones, el costo de aritmética de todas las cartas en mano se reduce en 1"
  },
  RelicConfig_13868_Name = {
    Text = "<WhiteQuality:☆Plano de Escape☆>"
  },
  RelicConfig_13868_StoryDesc = {
    Text = "\"Al abordar, primero encuentra la salida de emergencia más cercana a tu cabina.\""
  },
  RelicConfig_13869_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:reino dominado> Aumenta 100. Por cada daño activo infligido, daño de tentáculo temporal + [Arg1], por cada daño de tentáculo infligido, recibe [Arg2] escudo. Máximo 6 veces por turno"
  },
  RelicConfig_13869_Desc = {
    Text = "<ProficientInRealmsIconKeywords:reino dominado> Aumenta 100. Por cada daño activo infligido, daño de tentáculo temporal + [Arg1], por cada daño de tentáculo infligido, recibe [Arg2] escudo. Máximo 6 veces por turno"
  },
  RelicConfig_13869_Name = {
    Text = "<OrangeQuality:péndulo crono\"Pesadilla\">"
  },
  RelicConfig_13870_BattleDesc = {
    Text = "Por cada punto de aritmética consumido, el despertador correspondiente obtiene 2 puntos de locura"
  },
  RelicConfig_13870_Desc = {
    Text = "Por cada punto de aritmética consumido, el despertador correspondiente obtiene 2 puntos de locura"
  },
  RelicConfig_13870_Name = {
    Text = "<WhiteQuality:Cinta de hebilla plateada>"
  },
  RelicConfig_13870_StoryDesc = {
    Text = "Una vez, una cinta en la escena del crimen fue rasgada en dos.\nUna parte cayó desde lo alto en la palma de la niña"
  },
  RelicConfig_13871_BattleDesc = {
    Text = "Al inicio de cada turno, todos los despertadores obtienen 10 puntos de aliemus. Al recolectar, la salud máxima se reduce en 30%"
  },
  RelicConfig_13871_Desc = {
    Text = "Al inicio de cada turno, todos los despertadores obtienen 10 puntos de aliemus. Al recolectar, la salud máxima se reduce en 30%"
  },
  RelicConfig_13871_Name = {
    Text = "<RedQuality:Apariencia de pesadilla>"
  },
  RelicConfig_13871_StoryDesc = {
    Text = "Cuidado, el sueño profundo puede devorarlo todo sin que te des cuenta"
  },
  RelicConfig_13873_BattleDesc = {
    Text = "Después de jugar \"<ExaltIconKeywords:Despertar de la sabiduría>\", elimina todos los escudos de los enemigos"
  },
  RelicConfig_13873_Desc = {
    Text = "Después de jugar \"<ExaltIconKeywords:Despertar de la sabiduría>\", elimina todos los escudos de los enemigos"
  },
  RelicConfig_13873_Name = {
    Text = "Espejo negro"
  },
  RelicConfig_13874_BattleDesc = {
    Text = "En rondas impares, si la cantidad de cartas restantes es 0, roba 2 cartas; en rondas pares, si la aritmética restante es 0, obtén 2 puntos de aritmética"
  },
  RelicConfig_13874_Desc = {
    Text = "En rondas impares, si la cantidad de cartas restantes es 0, roba 2 cartas; en rondas pares, si la aritmética restante es 0, obtén 2 puntos de aritmética"
  },
  RelicConfig_13874_Name = {
    Text = "Guía Dorado Mutado"
  },
  RelicConfig_13875_BattleDesc = {
    Text = "Después de jugar \"Golpe\" y \"DEF\", el despertador correspondiente obtiene 35 aliemus. Sin embargo, su gasto de aritmética aumenta en +1"
  },
  RelicConfig_13875_Desc = {
    Text = "Después de jugar \"Golpe\" y \"DEF\", el despertador correspondiente obtiene 35 aliemus. Sin embargo, su gasto de aritmética aumenta en +1"
  },
  RelicConfig_13875_Name = {
    Text = "<RedQuality:Rostro incompleto>"
  },
  RelicConfig_13875_StoryDesc = {
    Text = "¿De quién es el rostro, lleno de terror, congelado en el tiempo?"
  },
  RelicConfig_13877_BattleDesc = {
    Text = "Tras obtener el 2º Escudo del personaje cada turno, gana [Arg1] <plural value=\"[Arg1]\" singular=\"Acumulación\" plural=\"Acumulaciones\"> de <RetaliateIconKeywords:Contador>. Tras obtener el 4º Escudo del personaje cada turno, activa un <RetaliateIconKeywords:Contador> del 100% contra todos los enemigos."
  },
  RelicConfig_13877_Desc = {
    Text = "Tras obtener el 2º Escudo del personaje cada turno, gana [Arg1] <plural value=\"[Arg1]\" singular=\"Acumulación\" plural=\"Acumulaciones\"> de <RetaliateIconKeywords:Contador>. Tras obtener el 4º Escudo del personaje cada turno, activa un <RetaliateIconKeywords:Contador> del 100% contra todos los enemigos."
  },
  RelicConfig_13877_Name = {
    Text = "<WhiteQuality:Franqueza>"
  },
  RelicConfig_13877_StoryDesc = {
    Text = "Ha transmitido innumerables secretos, ya sean voluntarios o forzados"
  },
  RelicConfig_13878_BattleDesc = {
    Text = "Cada sexta carta de comando jugada hará que retorne del montón de descarte a su mano"
  },
  RelicConfig_13878_Desc = {
    Text = "Cada sexta carta de comando jugada hará que retorne del montón de descarte a su mano"
  },
  RelicConfig_13878_Name = {
    Text = "<OrangeQuality:En el crepúsculo>"
  },
  RelicConfig_13878_StoryDesc = {
    Text = "¡Vamos a tomar una foto! Siente el dolor real"
  },
  RelicConfig_13879_BattleDesc = {
    Text = "Después de liberar 5 exaltaciones, el despertador que liberó la exaltación obtiene 100 puntos de aliemus"
  },
  RelicConfig_13879_Desc = {
    Text = "Después de liberar 5 exaltaciones, el despertador que liberó la exaltación obtiene 100 puntos de aliemus"
  },
  RelicConfig_13879_Name = {
    Text = "<OrangeQuality:Pequeño pañal>"
  },
  RelicConfig_13879_StoryDesc = {
    Text = "Cargado de esperanza, bendiciones y amor"
  },
  RelicConfig_13880_BattleDesc = {
    Text = "Al causar daño activo, obtén [Arg1] puntos de escudo. Al curar vida, obtén [Arg2] puntos de <PowerIconKeywords:fuerza> temporal"
  },
  RelicConfig_13880_Desc = {
    Text = "Al causar daño activo, obtén [Arg1] puntos de escudo. Al curar vida, obtén [Arg2] puntos de <PowerIconKeywords:fuerza> temporal"
  },
  RelicConfig_13880_Name = {
    Text = "<OrangeQuality:Nuestro hogar>"
  },
  RelicConfig_13880_StoryDesc = {
    Text = "Estuvieron juntos antes y estarán juntos para siempre. Son una familia amorosa"
  },
  RelicConfig_13881_BattleDesc = {
    Text = "Al empezar turno impar, gana [Arg1] puntos de <PowerIconKeywords:fuerza> temporal. Al empezar turno par, gana [Arg2] puntos de <AlertIconKeywords:alerta> temporal"
  },
  RelicConfig_13881_Desc = {
    Text = "Al empezar turno impar, gana [Arg1] puntos de <PowerIconKeywords:fuerza> temporal. Al empezar turno par, gana [Arg2] puntos de <AlertIconKeywords:alerta> temporal"
  },
  RelicConfig_13881_Name = {
    Text = "<WhiteQuality:Muñeca gemela>"
  },
  RelicConfig_13881_StoryDesc = {
    Text = "El gemelo es un regalo de la antigüedad, una fábula dejada para el futuro"
  },
  RelicConfig_13882_BattleDesc = {
    Text = "Al final del turno, el Despertado correspondiente a la primera carta de comando jugada obtiene 20 Locura. Si también tienes la creación \"Espíritu de Devoción\", los otros Despertados obtienen 5 Locura"
  },
  RelicConfig_13882_Desc = {
    Text = "Al final del turno, el Despertado correspondiente a la primera carta de comando jugada obtiene 20 Locura. Si también tienes la creación \"Espíritu de Devoción\", los otros Despertados obtienen 5 Locura"
  },
  RelicConfig_13882_Name = {
    Text = "<WhiteQuality:Estatua de madre>"
  },
  RelicConfig_13882_StoryDesc = {
    Text = "\"Toma, te doy lo que quieras, por favor, déjalo ir.\""
  },
  RelicConfig_13883_BattleDesc = {
    Text = "Cada vez que un Despertado realiza una <DevouredIconKeywords:devoración>, los demás Despertados obtienen 10 locura"
  },
  RelicConfig_13883_Desc = {
    Text = "Cada vez que un Despertado realiza una <DevouredIconKeywords:devoración>, los demás Despertados obtienen 10 locura"
  },
  RelicConfig_13883_Name = {
    Text = "<OrangeQuality:Ensueño Dorado>"
  },
  RelicConfig_13883_StoryDesc = {
    Text = "El día de tu transformación será tu fin"
  },
  RelicConfig_13884_BattleDesc = {
    Text = "\"'Golpe' aplica [Arg1] capas de <IntoxicationIconKeywords:veneno> a todos los enemigos.\""
  },
  RelicConfig_13884_Desc = {
    Text = "\"'Golpe' aplica [Arg1] capas de <IntoxicationIconKeywords:veneno> a todos los enemigos.\""
  },
  RelicConfig_13884_Name = {
    Text = "<WhiteQuality:Neurotoxina>"
  },
  RelicConfig_13884_StoryDesc = {
    Text = "Extraer, refinar"
  },
  RelicConfig_13885_BattleDesc = {
    Text = "Al inicio del combate, coloca 1 carta de <DerivativeCardKeywords_1:\"Eco de Sombra\"> en tu mano. Si es una batalla contra un jefe, obtén 1 carta adicional de <DerivativeCardKeywords_1:\"Eco de Sombra\">"
  },
  RelicConfig_13885_Desc = {
    Text = "Al inicio del combate, coloca 1 carta de <DerivativeCardKeywords_1:\"Eco de Sombra\"> en tu mano. Si es una batalla contra un jefe, obtén 1 carta adicional de <DerivativeCardKeywords_1:\"Eco de Sombra\">"
  },
  RelicConfig_13885_Name = {
    Text = "<WhiteQuality:Equipo de comunicación>"
  },
  RelicConfig_13885_StoryDesc = {
    Text = "Esperando o temiendo el momento en que suene la campana"
  },
  RelicConfig_13886_BattleDesc = {
    Text = "Cada vez que se reinicie la biblioteca, se añaden 2 cartas de <DerivativeCardKeywords_5:\"Tridente\"> y 1 carta de <DerivativeCardKeywords_6:\"Sombrilla\"> a la mano"
  },
  RelicConfig_13886_Desc = {
    Text = "Cada vez que se reinicie la biblioteca, se añaden 2 cartas de <DerivativeCardKeywords_5:\"Tridente\"> y 1 carta de <DerivativeCardKeywords_6:\"Sombrilla\"> a la mano"
  },
  RelicConfig_13886_Name = {
    Text = "<WhiteQuality:☆Bolso de Dama☆>"
  },
  RelicConfig_13886_StoryDesc = {
    Text = "Debería contener delicadeza, no muerte"
  },
  RelicConfig_13887_BattleDesc = {
    Text = "Al comienzo del turno, añade 1 carta <DerivativeCardKeywords_5: \"tridente\"> a tu mano. Después de liberar exaltar, aumenta el poder de todas las cartas <DerivativeCardKeywords_5: \"tridente\"><PowerIconKeywords:poder> en tu mano en [Arg2]"
  },
  RelicConfig_13887_Desc = {
    Text = "Al comienzo del turno, añade 1 carta <DerivativeCardKeywords_5: \"tridente\"> a tu mano. Después de liberar exaltar, aumenta el poder de todas las cartas <DerivativeCardKeywords_5: \"tridente\"><PowerIconKeywords:poder> en tu mano en [Arg2]"
  },
  RelicConfig_13887_Name = {
    Text = "<WhiteQuality: tridente>"
  },
  RelicConfig_13887_StoryDesc = {
    Text = "No importa cómo lo mires, parece normal"
  },
  RelicConfig_13888_BattleDesc = {
    Text = "Al inicio del combate, obtén [Arg1] de escudo. Después de jugar 7 veces \"DEF\" en esta batalla, obtén inmediatamente [Arg2] de escudo. Después de jugar 21 veces \"DEF\" en esta batalla, obtén 1 capa de barrera temporal"
  },
  RelicConfig_13888_Desc = {
    Text = "Al inicio del combate, obtén [Arg1] de escudo. Después de jugar 7 veces \"DEF\" en esta batalla, obtén inmediatamente [Arg2] de escudo. Después de jugar 21 veces \"DEF\" en esta batalla, obtén 1 capa de barrera temporal"
  },
  RelicConfig_13888_Name = {
    Text = "<WhiteQuality:Diario de Putney>"
  },
  RelicConfig_13888_StoryDesc = {
    Text = "Su compañero de baño más fiel"
  },
  RelicConfig_13889_BattleDesc = {
    Text = "Al entrar en el turno ultra, obtienes 3 puntos de aritmética"
  },
  RelicConfig_13889_Desc = {
    Text = "Al entrar en el turno ultra, obtienes 3 puntos de aritmética"
  },
  RelicConfig_13889_Name = {
    Text = "<WhiteQuality: reloj de arena resplandeciente>"
  },
  RelicConfig_13889_StoryDesc = {
    Text = "Un tiempo medible"
  },
  RelicConfig_13890_BattleDesc = {
    Text = "Al comienzo de la batalla, se aplican 1 turno de <WeaknessIconKeywords:debilidad> y <VulnerabilityIconKeywords:vulnerabilidad> a todos los enemigos; si es una batalla de jefe, se aplican 2 turnos adicionales de <WeaknessIconKeywords:debilidad> y <VulnerabilityIconKeywords:vulnerabilidad>"
  },
  RelicConfig_13890_Desc = {
    Text = "Al comienzo de la batalla, se aplican 1 turno de <WeaknessIconKeywords:debilidad> y <VulnerabilityIconKeywords:vulnerabilidad> a todos los enemigos; si es una batalla de jefe, se aplican 2 turnos adicionales de <WeaknessIconKeywords:debilidad> y <VulnerabilityIconKeywords:vulnerabilidad>"
  },
  RelicConfig_13890_Name = {
    Text = "<WhiteQuality:Camisa de fuerza>"
  },
  RelicConfig_13890_StoryDesc = {
    Text = "No solo el tiempo puede decolorar la tela, también el miedo y el dolor"
  },
  RelicConfig_13891_BattleDesc = {
    Text = "Si al jugar la primera carta de comando cada turno se activa el efecto salto, roba 1 carta; de lo contrario, obtén 1 punto de aritmética. Si es un turno ultra, tendrías ambos efectos"
  },
  RelicConfig_13891_Desc = {
    Text = "Si al jugar la primera carta de comando cada turno se activa el efecto salto, roba 1 carta; de lo contrario, obtén 1 punto de aritmética. Si es un turno ultra, tendrías ambos efectos"
  },
  RelicConfig_13891_Name = {
    Text = "<OrangeQuality:Dispositivo de Salto>"
  },
  RelicConfig_13891_StoryDesc = {
    Text = "Refleja una sombra distorsionada"
  },
  RelicConfig_13892_BattleDesc = {
    Text = "Obtener una misión. Al completarla, obtener recompensa. [Evento de misión de marcador]"
  },
  RelicConfig_13892_Desc = {
    Text = "Obtener una misión. Al completarla, obtener recompensa. [Evento de misión de marcador]"
  },
  RelicConfig_13892_Name = {
    Text = "<WhiteQuality:Diario viejo>"
  },
  RelicConfig_13892_StoryDesc = {
    Text = "Un viejo diario, cuyas páginas están llenas de insertos, que a simple vista contiene al menos un mapa de elworth, registros de experimentos y cartas llenas de d-marcas.\nEl contenido de las primeras notas está muy bien escrito, mientras que el resto se vuelve cada vez más desordenado"
  },
  RelicConfig_13893_BattleDesc = {
    Text = "Cada 4to escudo obtenido restaura 50% de la vida del valor del escudo"
  },
  RelicConfig_13893_Desc = {
    Text = "Cada 4to escudo obtenido restaura 50% de la vida del valor del escudo"
  },
  RelicConfig_13893_Name = {
    Text = "<WhiteQuality:Silbato de marinero>"
  },
  RelicConfig_13893_StoryDesc = {
    Text = "Aparte de sirenas, el silbido puede traer huracanes, botas apestosas y marineros que no se han bañado en cien días"
  },
  RelicConfig_13894_BattleDesc = {
    Text = "Si jugaste 4 o menos cartas en el último turno, la primera carta que juegues en este turno se activará dos veces"
  },
  RelicConfig_13894_Desc = {
    Text = "Si jugaste 4 o menos cartas en el último turno, la primera carta que juegues en este turno se activará dos veces"
  },
  RelicConfig_13894_Name = {
    Text = "<OrangeQuality:☆Lámpara de pesadilla☆>"
  },
  RelicConfig_13894_StoryDesc = {
    Text = "Introducir Sueño Ilusorio"
  },
  RelicConfig_13895_BattleDesc = {
    Text = "Cada vez que pierdes vida, el Despertado con menos locura obtiene 10 locura. Cada vez que pierdes vida 5 veces, recuperas 20% de la vida perdida"
  },
  RelicConfig_13895_Desc = {
    Text = "Cada vez que pierdes vida, el Despertado con menos locura obtiene 10 locura. Cada vez que pierdes vida 5 veces, recuperas 20% de la vida perdida"
  },
  RelicConfig_13895_Name = {
    Text = "<OrangeQuality:péndulo crono\"Análisis»>"
  },
  RelicConfig_13896_BattleDesc = {
    Text = "Aumenta el límite de aritmética máxima en 2. Cada vez que se reinicie el mazo se agregarán 1 <DerivativeCardKeywords_9:\"tambalearse\"> a la pila de robos"
  },
  RelicConfig_13896_Desc = {
    Text = "Aumenta el límite de aritmética máxima en 2. Cada vez que se reinicie el mazo se agregarán 1 <DerivativeCardKeywords_9:\"tambalearse\"> a la pila de robos"
  },
  RelicConfig_13896_Name = {
    Text = "<RedQuality:Vela negra>"
  },
  RelicConfig_13896_StoryDesc = {
    Text = "Quema la lucidez, cae en la ilusión"
  },
  RelicConfig_13897_BattleDesc = {
    Text = "\"<ExaltIconKeywords:Despertar de la sabiduría>\" se mantiene al final del turno"
  },
  RelicConfig_13897_Desc = {
    Text = "\"<ExaltIconKeywords:Despertar de la sabiduría>\" se mantiene al final del turno"
  },
  RelicConfig_13897_Name = {
    Text = "Espejo blanco"
  },
  RelicConfig_13898_BattleDesc = {
    Text = "Por cada despertador que haya despertado, <ProficientInRealmsIconKeywords:maestría en reinos> aumentará en 35. Tras jugar \"<ExaltIconKeywords:despertar de gnosis>\", obtendrá aleatoriamente 2 cartas de comando de ese despertador, y se les añadirá \"agotamiento\""
  },
  RelicConfig_13898_Desc = {
    Text = "Por cada despertador que haya despertado, <ProficientInRealmsIconKeywords:maestría en reinos> aumentará en 35. Tras jugar \"<ExaltIconKeywords:despertar de gnosis>\", obtendrá aleatoriamente 2 cartas de comando de ese despertador, y se les añadirá \"agotamiento\""
  },
  RelicConfig_13898_Name = {
    Text = "<OrangeQuality:Su Oráculo>"
  },
  RelicConfig_13898_StoryDesc = {
    Text = "Él dijo, no temas"
  },
  RelicConfig_13899_BattleDesc = {
    Text = "Al inicio del turno, <ProficientInRealmsIconKeywords:maestría en reinos> aumenta 50. Sin estados negativos, aumenta a 150"
  },
  RelicConfig_13899_Desc = {
    Text = "Al inicio del turno, <ProficientInRealmsIconKeywords:maestría en reinos> aumenta 50. Sin estados negativos, aumenta a 150"
  },
  RelicConfig_13899_Name = {
    Text = "<WhiteQuality:☆\"Por la Libertad\"☆>"
  },
  RelicConfig_13899_StoryDesc = {
    Text = "Un puñado de núcleos de plata que evocan nostalgia"
  },
  RelicConfig_13900_BattleDesc = {
    Text = "Después de usar \"exaltar\", todos los costes de aritmética de las cartas en la mano -1"
  },
  RelicConfig_13900_Desc = {
    Text = "Después de usar \"exaltar\", todos los costes de aritmética de las cartas en la mano -1"
  },
  RelicConfig_13900_Name = {
    Text = "Luz de la civilización mutada"
  },
  RelicConfig_13901_BattleDesc = {
    Text = "Cada vez que juegues 1 carta de comando, obtén [Arg2]% de <DeathResistanceIconKeywords:Resistencia a la muerte> (en esta fase, cada vez que se activa la Resistencia a la muerte, se reduce a la mitad). Si tu <DeathResistanceIconKeywords:Resistencia a la muerte> es mayor o igual al 100%, en su lugar obtendrás [Arg1] puntos de <PowerIconKeywords:fuerza> temporalmente."
  },
  RelicConfig_13901_Desc = {
    Text = "Cada vez que juegues 1 carta de comando, obtén [Arg2]% de <DeathResistanceIconKeywords:Resistencia a la muerte> (en esta fase, cada vez que se activa la Resistencia a la muerte, se reduce a la mitad). Si tu <DeathResistanceIconKeywords:Resistencia a la muerte> es igual o mayor al 100%, en su lugar, obtendrás [Arg1] puntos de <PowerIconKeywords:fuerza> temporalmente."
  },
  RelicConfig_13901_Name = {
    Text = "<OrangeQuality:Piel de serpiente>"
  },
  RelicConfig_13901_StoryDesc = {
    Text = "Renacer de la cáscara dañada"
  },
  RelicConfig_13902_BattleDesc = {
    Text = "Al inicio del turno, gana [Arg2] de Escudo del personaje. Al final del turno, inflige <FixedDamage:DMG Puro> igual al [Arg1]% de tu Escudo del personaje actual a un enemigo aleatorio. El efecto de DMG se duplica en Líder Batalla."
  },
  RelicConfig_13902_Desc = {
    Text = "Al inicio del turno, gana [Arg2] de Escudo del personaje. Al final del turno, inflige <FixedDamage:DMG Puro> igual al [Arg1]% de tu Escudo del personaje actual a un enemigo aleatorio. El efecto de DMG se duplica en Líder Batalla."
  },
  RelicConfig_13902_Name = {
    Text = "<WhiteQuality:Guía dorada>"
  },
  RelicConfig_13902_StoryDesc = {
    Text = "Ábrelo cuando estés perdido, pero ten cuidado: su corona no debe ver la luz del sol"
  },
  RelicConfig_13904_BattleDesc = {
    Text = "Ocultar la intención del monstruo. Obtén 1 punto de aritmética por cada turno, roba 1 carta"
  },
  RelicConfig_13904_Desc = {
    Text = "Ocultar la intención del monstruo. Obtén 1 punto de aritmética por cada turno, roba 1 carta"
  },
  RelicConfig_13904_Name = {
    Text = "<RedQuality:Campana de seducción>"
  },
  RelicConfig_13904_StoryDesc = {
    Text = "¡Ding ling ling, ding ling ling!"
  },
  RelicConfig_13905_BattleDesc = {
    Text = "Después de que comience la batalla, se obtienen [Arg2] capas de <RetaliateIconKeywords: contraataque>, al usar \"defensa\", se obtienen [Arg1] capas de <RetaliateIconKeywords: contraataque>"
  },
  RelicConfig_13905_Desc = {
    Text = "Después de que comience la batalla, se obtienen [Arg2] capas de <RetaliateIconKeywords: contraataque>, al usar \"defensa\", se obtienen [Arg1] capas de <RetaliateIconKeywords: contraataque>"
  },
  RelicConfig_13905_Name = {
    Text = "<WhiteQuality:Chaleco de ortiga>"
  },
  RelicConfig_13905_StoryDesc = {
    Text = "No se puede identificar el líquido contaminado"
  },
  RelicConfig_13906_BattleDesc = {
    Text = "Es un objeto de misión semanal sin efecto 4"
  },
  RelicConfig_13906_Desc = {
    Text = "Es un objeto de misión semanal sin efecto 4"
  },
  RelicConfig_13906_Name = {
    Text = "Desafío diario, creación semanal 4"
  },
  RelicConfig_13907_BattleDesc = {
    Text = "Al inicio del turno, si jugaste más de 3 cartas en el turno anterior, roba 2 cartas"
  },
  RelicConfig_13907_Desc = {
    Text = "Al inicio del turno, si jugaste más de 3 cartas en el turno anterior, roba 2 cartas"
  },
  RelicConfig_13907_Name = {
    Text = "<WhiteQuality:Cartera nueva>"
  },
  RelicConfig_13907_StoryDesc = {
    Text = "Una billetera de cuero marcada con el emblema de la Universidad de Mitag.  \nAhora está vacía, sin nada dentro"
  },
  RelicConfig_13908_BattleDesc = {
    Text = "Después de usar \"exaltar\", el despertador obtiene [Arg1] puntos de locura"
  },
  RelicConfig_13908_Desc = {
    Text = "Después de usar \"exaltar\", el despertador obtiene [Arg1] puntos de locura"
  },
  RelicConfig_13908_Name = {
    Text = "Velo del dios sin nombre mutado"
  },
  RelicConfig_13909_BattleDesc = {
    Text = "Después de liberar la exaltar, pierde el 8% de su vida actual, roba [Arg1] puntos temporales de <PowerIconKeywords:poder> de todos los enemigos, si solo hay 1 enemigo, roba además [Arg2] puntos temporales de <PowerIconKeywords:poder>"
  },
  RelicConfig_13909_Desc = {
    Text = "Después de liberar la exaltar, pierde el 8% de su vida actual, roba [Arg1] puntos temporales de <PowerIconKeywords:poder> de todos los enemigos, si solo hay 1 enemigo, roba además [Arg2] puntos temporales de <PowerIconKeywords:poder>"
  },
  RelicConfig_13909_Name = {
    Text = "<RedQuality:Pájaro del ritual de la fatalidad>"
  },
  RelicConfig_13909_StoryDesc = {
    Text = "Un cadáver seco emitió un chillido"
  },
  RelicConfig_13910_BattleDesc = {
    Text = "Al liberar la exaltación, el despertador correspondiente obtiene 10 locura y [Arg1] puntos de escudo"
  },
  RelicConfig_13910_Desc = {
    Text = "Al liberar la exaltación, el despertador correspondiente obtiene 10 locura y [Arg1] puntos de escudo"
  },
  RelicConfig_13910_Name = {
    Text = "<OrangeQuality:Velo del Dios Desconocido>"
  },
  RelicConfig_13910_StoryDesc = {
    Text = "No mirar directamente a Dios"
  },
  RelicConfig_13911_BattleDesc = {
    Text = "Al final del turno, el Despertado correspondiente a la última carta de comando jugada obtiene 20 Locura. Si también tienes la creación \"Estatua de la Madre\", los otros Despertados obtienen 5 Locura"
  },
  RelicConfig_13911_Desc = {
    Text = "Al final del turno, el Despertado correspondiente a la última carta de comando jugada obtiene 20 Locura. Si también tienes la creación \"Estatua de la Madre\", los otros Despertados obtienen 5 Locura"
  },
  RelicConfig_13911_Name = {
    Text = "<WhiteQuality:Devoción>"
  },
  RelicConfig_13911_StoryDesc = {
    Text = "\"Toma, te doy lo que quieras, por favor, perdóname.\""
  },
  RelicConfig_13912_BattleDesc = {
    Text = "Al final del turno, por cada carta restante en la mano, gana 1 punto de potencia al comienzo del próximo turno"
  },
  RelicConfig_13912_Desc = {
    Text = "Al final del turno, por cada carta restante en la mano, gana 1 punto de potencia al comienzo del próximo turno"
  },
  RelicConfig_13912_Name = {
    Text = "<OrangeQuality:péndulo temporal\"interpretar\">"
  },
  RelicConfig_13913_BattleDesc = {
    Text = "Al inicio del turno, si la vida es mayor que [Arg1], pierde [Arg1] de vida y obtiene [Arg2] de <PowerIconKeywords:fuerza> y [Arg3] de <AlertIconKeywords:alerta> durante el turno"
  },
  RelicConfig_13913_Desc = {
    Text = "Al inicio del turno, si la vida es mayor que [Arg1], pierde [Arg1] de vida y obtiene [Arg2] de <PowerIconKeywords:fuerza> y [Arg3] de <AlertIconKeywords:alerta> durante el turno"
  },
  RelicConfig_13913_Name = {
    Text = "<RedQuality:Extremidad de alivio>"
  },
  RelicConfig_13913_StoryDesc = {
    Text = "Una parte sagrada.\nAunque separada del torso, aún se siente su calidez"
  },
  RelicConfig_13914_BattleDesc = {
    Text = "\"El golpe\" obtiene 2 puntos de aritmética y descarta aleatoriamente 1 carta; \"DEF\" roba 2 cartas y pierde 1 punto de aritmética. Se activa un máximo de 3 veces por turno"
  },
  RelicConfig_13914_Desc = {
    Text = "\"El golpe\" obtiene 2 puntos de aritmética y descarta aleatoriamente 1 carta; \"DEF\" roba 2 cartas y pierde 1 punto de aritmética. Se activa un máximo de 3 veces por turno"
  },
  RelicConfig_13914_Name = {
    Text = "<RedQuality:Disco feliz>"
  },
  RelicConfig_13914_StoryDesc = {
    Text = "Grabación del último concierto del famoso violinista.\nDesde entonces, puede traer fuego"
  },
  RelicConfig_13915_BattleDesc = {
    Text = "El efecto de bonificación de la recomendación de dominio aumenta un 50%, al inicio del nivel tu <ProficientInRealmsIconKeywords:Maestría en dominios> se duplica"
  },
  RelicConfig_13915_Desc = {
    Text = "El efecto de bonificación de la recomendación de dominio aumenta un 50%, al inicio del nivel tu <ProficientInRealmsIconKeywords:Maestría en dominios> se duplica"
  },
  RelicConfig_13915_Name = {
    Text = "<OrangeQuality: Péndulo crono\"Entrando en Sueño\">"
  },
  RelicConfig_13916_BattleDesc = {
    Text = "Al liberar Exaltar, la siguiente Tarjeta de comando jugada tendrá efecto 2 veces."
  },
  RelicConfig_13916_Desc = {
    Text = "Al liberar Exaltar, la siguiente Tarjeta de comando jugada tendrá efecto 2 veces."
  },
  RelicConfig_13916_Name = {
    Text = "<OrangeQuality:péndulo crono\"Inmersión\">"
  },
  RelicConfig_13917_BattleDesc = {
    Text = "Si la intención del enemigo es atacar, después de causar daño, reduce temporalmente su <PowerIconKeywords:poder> en [Arg1] puntos, de lo contrario, añade <BleedingIconKeywords:sangrado> equivalente al 25% del daño, pudiendo activarse un máximo de 6 veces por turno"
  },
  RelicConfig_13917_Desc = {
    Text = "Si la intención del enemigo es atacar, después de causar daño, reduce temporalmente su <PowerIconKeywords:poder> en [Arg1] puntos, de lo contrario, añade <BleedingIconKeywords:sangrado> equivalente al 25% del daño, pudiendo activarse un máximo de 6 veces por turno"
  },
  RelicConfig_13917_Name = {
    Text = "<WhiteQuality:Corazón alienígena>"
  },
  RelicConfig_13917_StoryDesc = {
    Text = "Dos \"corazones\" juntos"
  },
  RelicConfig_13918_BattleDesc = {
    Text = "Cada vez que causas daño, obtienes [Arg1] puntos de <PowerIconKeywords:fuerza> temporal, se acumula hasta 3 veces. Al alcanzar el máximo, el efecto se duplica"
  },
  RelicConfig_13918_Desc = {
    Text = "Cada vez que causas daño, obtienes [Arg1] puntos de <PowerIconKeywords:fuerza> temporal, se acumula hasta 3 veces. Al alcanzar el máximo, el efecto se duplica"
  },
  RelicConfig_13918_Name = {
    Text = "<WhiteQuality:Ágata>"
  },
  RelicConfig_13918_StoryDesc = {
    Text = "Debería ser solo un patrón de ágata común. Probablemente"
  },
  RelicConfig_13919_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Maestría en Reinos> aumenta 50. Al recoger, elige una creación y cámbiala por una aleatoria"
  },
  RelicConfig_13919_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maestría en Reinos> aumenta 50. Al recoger, elige una creación y cámbiala por una aleatoria"
  },
  RelicConfig_13919_Name = {
    Text = "<WhiteQuality:Caleidoscopio>"
  },
  RelicConfig_13919_StoryDesc = {
    Text = "Todo lo que ves y piensas es una ilusión"
  },
  RelicConfig_13920_BattleDesc = {
    Text = "El efecto de debilidad aumenta en 5%. Al aplicar <WeaknessIconKeywords:debilidad>, roba temporalmente [Arg1] puntos de <PowerIconKeywords:fuerza> del objetivo"
  },
  RelicConfig_13920_Desc = {
    Text = "El efecto de Síntoma: Debilidad aumenta en 5%. Al aplicar <WeaknessIconKeywords:Síntoma: Debilidad>, roba temporalmente [Arg1] puntos de <PowerIconKeywords:FUE> del objetivo"
  },
  RelicConfig_13920_Name = {
    Text = "<WhiteQuality:Foto descolorida>"
  },
  RelicConfig_13920_StoryDesc = {
    Text = "Una foto borrosa lleva consigo recuerdos borrosos, o tal vez es la falta de memoria lo que ha provocado el desvanecimiento de la foto."
  },
  RelicConfig_13921_BattleDesc = {
    Text = "Al recoger, se eligen 2 cartas de comando para eliminar, se obtienen [Arg1] <PowerIconKeywords: poder>"
  },
  RelicConfig_13921_Desc = {
    Text = "Al recoger, se eligen 2 cartas de comando para eliminar, se obtienen [Arg1] <PowerIconKeywords: poder>"
  },
  RelicConfig_13921_Name = {
    Text = "<RedQuality:Cenizas de estrella negra>"
  },
  RelicConfig_13921_StoryDesc = {
    Text = "La llama no se ha extinguido"
  },
  RelicConfig_13922_BattleDesc = {
    Text = "Después de liberar 2 veces elaliemus, todos los despertadores obtienen 8 puntos de aliemus; tras liberarlo 3 veces, todos los despertadores obtienen otros 8 puntos de aliemus"
  },
  RelicConfig_13922_Desc = {
    Text = "Después de liberar 2 veces elaliemus, todos los despertadores obtienen 8 puntos de aliemus; tras liberarlo 3 veces, todos los despertadores obtienen otros 8 puntos de aliemus"
  },
  RelicConfig_13922_Name = {
    Text = "<OrangeQuality:Sangre del Olvidado>"
  },
  RelicConfig_13922_StoryDesc = {
    Text = "Desvaneciéndose"
  },
  RelicConfig_13923_BattleDesc = {
    Text = "Por cada daño causado, obtén [Arg1] puntos de escudo. Al inicio de cada turno, por cada 3 puntos de escudo restante, obtén 1 punto de <PowerIconKeywords:fuerza> temporal y daño de tentáculo"
  },
  RelicConfig_13923_Desc = {
    Text = "Por cada daño causado, obtén [Arg1] puntos de escudo. Al inicio de cada turno, por cada 3 puntos de escudo restante, obtén 1 punto de <PowerIconKeywords:fuerza> temporal y daño de tentáculo"
  },
  RelicConfig_13923_Name = {
    Text = "<OrangeQuality:péndulo crono\"Secretos»>"
  },
  RelicConfig_13924_BattleDesc = {
    Text = "Cada vez que se active el efecto <TransitionIconKeywords:salto>, robará [Arg1] puntos temporales de <PowerIconKeywords:poder> de todos los enemigos; si solo hay un enemigo, robará [Arg2] puntos temporales de <PowerIconKeywords:poder> adicionales"
  },
  RelicConfig_13924_Desc = {
    Text = "Cada vez que se active el efecto <TransitionIconKeywords:salto>, robará [Arg1] puntos temporales de <PowerIconKeywords:poder> de todos los enemigos; si solo hay un enemigo, robará [Arg2] puntos temporales de <PowerIconKeywords:poder> adicionales"
  },
  RelicConfig_13924_Name = {
    Text = "<OrangeQuality:Desviador Espacial>"
  },
  RelicConfig_13924_StoryDesc = {
    Text = "Salto al vacío"
  },
  RelicConfig_13925_BattleDesc = {
    Text = "Al comienzo del turno, roba 1 carta. Si juegas 2 veces seguidas una carta con el mismo coste de aritmética que la anterior, robas 1 carta adicional, con un máximo de 3 activaciones por turno"
  },
  RelicConfig_13925_Desc = {
    Text = "Al comienzo del turno, roba 1 carta. Si juegas 2 veces seguidas una carta con el mismo coste de aritmética que la anterior, robas 1 carta adicional, con un máximo de 3 activaciones por turno"
  },
  RelicConfig_13925_Name = {
    Text = "<OrangeQuality:Ritual de sabiduría universal>"
  },
  RelicConfig_13925_StoryDesc = {
    Text = "Omnisciente y omnipotente"
  },
  RelicConfig_13926_BattleDesc = {
    Text = "Al comienzo de la batalla, por cada sello en el mazo se obtienen [Arg1] puntos de <PowerIconKeywords:poder> y por cada reliquia, se recuperan [Arg2] puntos de vida"
  },
  RelicConfig_13926_Desc = {
    Text = "Al comienzo de la batalla, por cada sello en el mazo se obtienen [Arg1] puntos de <PowerIconKeywords:poder> y por cada reliquia, se recuperan [Arg2] puntos de vida"
  },
  RelicConfig_13926_Name = {
    Text = "<OrangeQuality:☆Medalla del gremio☆>"
  },
  RelicConfig_13926_StoryDesc = {
    Text = "\"Póntelo, y serás miembro de la Compañía Lentini.\""
  },
  RelicConfig_13927_BattleDesc = {
    Text = "Al recoger, elimina 1 carta de síntoma. Mejora 1 sigilo aleatorio a un sigilo avanzado"
  },
  RelicConfig_13927_Desc = {
    Text = "Al recoger, elimina 1 carta de síntoma. Mejora 1 sigilo aleatorio a un sigilo avanzado"
  },
  RelicConfig_13927_Name = {
    Text = "<WhiteQuality:Pata de conejo>"
  },
  RelicConfig_13927_StoryDesc = {
    Text = "Para el conejo, no fue tan afortunado"
  },
  RelicConfig_13928_BattleDesc = {
    Text = "La tasa crítica aumenta un 15%. Cada vez que juegues 1 carta, la tasa crítica temporal aumentará un 5%"
  },
  RelicConfig_13928_Desc = {
    Text = "La tasa crítica aumenta un 15%. Cada vez que juegues 1 carta, la tasa crítica temporal aumentará un 5%"
  },
  RelicConfig_13928_Name = {
    Text = "<OrangeQuality:Espejo ritual de Menfis>"
  },
  RelicConfig_13928_StoryDesc = {
    Text = "\"¿Qué viste en eso?\""
  },
  RelicConfig_13929_BattleDesc = {
    Text = "Cada vez que pierdes PV, ganas [Arg1] <plural value=\"[Arg1]\" singular=\"Acumulación\" plural=\"Acumulaciones\"> de <RetaliateIconKeywords:Contador>. Si este es el 3er activador en un solo turno, activa un <RetaliateIconKeywords:Contador> del 100% contra todos los enemigos."
  },
  RelicConfig_13929_Desc = {
    Text = "Cada vez que pierdes PV, ganas [Arg1] <plural value=\"[Arg1]\" singular=\"Acumulación\" plural=\"Acumulaciones\"> de <RetaliateIconKeywords:Contador>. Si este es el 3er activador en un solo turno, activa un <RetaliateIconKeywords:Contador> del 100% contra todos los enemigos."
  },
  RelicConfig_13929_Name = {
    Text = "<WhiteQuality:Reloj de bolsillo antiguo>"
  },
  RelicConfig_13929_StoryDesc = {
    Text = "Con nostalgia y tristeza, avanzamos hacia lo desconocido"
  },
  RelicConfig_13930_BattleDesc = {
    Text = "Al final del turno, aplica [Arg1] capas <IntoxicationIconKeywords:veneno> a todos los enemigos por cada carta en la mano"
  },
  RelicConfig_13930_Desc = {
    Text = "Al final del turno, aplica [Arg1] capas <IntoxicationIconKeywords:veneno> a todos los enemigos por cada carta en la mano"
  },
  RelicConfig_13930_Name = {
    Text = "<WhiteQuality:Ungüento sospechoso>"
  },
  RelicConfig_13930_StoryDesc = {
    Text = "Alguna especie de ungüento para heridas casero, por favor no lo uses sin la supervisión de un doctor"
  },
  RelicConfig_13931_BattleDesc = {
    Text = "Al recoger, obtienes [Arg1] <PowerIconKeywords:Fuerza>. Cada vez que se fusiona una <DerivativeCardKeywords_2:\"Embrion\">, obtienes [Arg2] puntos de <PowerIconKeywords:Fuerza> temporal"
  },
  RelicConfig_13931_Desc = {
    Text = "Al recoger, obtienes [Arg1] <PowerIconKeywords:Fuerza>. Cada vez que se fusiona una <DerivativeCardKeywords_2:\"Embrion\">, obtienes [Arg2] puntos de <PowerIconKeywords:Fuerza> temporal"
  },
  RelicConfig_13931_Name = {
    Text = "<WhiteQuality:Guijarro ensangrentado>"
  },
  RelicConfig_13931_StoryDesc = {
    Text = "Uno, dos, tres, cuatro, cinco"
  },
  RelicConfig_13932_BattleDesc = {
    Text = "Cada 3er uso de \"DEF\" otorga [Arg1] de escudo y 15 de locura al despertar correspondiente"
  },
  RelicConfig_13932_Desc = {
    Text = "Cada 3er uso de \"DEF\" otorga [Arg1] de escudo y 15 de locura al despertar correspondiente"
  },
  RelicConfig_13932_Name = {
    Text = "<WhiteQuality:Guantes de silencio>"
  },
  RelicConfig_13932_StoryDesc = {
    Text = "Han sido manchados con sangre, lágrimas y moho innumerables veces"
  },
  RelicConfig_13933_BattleDesc = {
    Text = "Es un objeto de misión semanal sin efecto 6"
  },
  RelicConfig_13933_Desc = {
    Text = "Es un objeto de misión semanal sin efecto 6"
  },
  RelicConfig_13933_Name = {
    Text = "Desafío diario, creación semanal 6"
  },
  RelicConfig_13934_BattleDesc = {
    Text = "Es un objeto de misión semanal sin efecto 5"
  },
  RelicConfig_13934_Desc = {
    Text = "Es un objeto de misión semanal sin efecto 5"
  },
  RelicConfig_13934_Name = {
    Text = "Desafío diario, creación semanal 5"
  },
  RelicConfig_13935_BattleDesc = {
    Text = "La tasa crítica aumenta un 10%. Después del primer crítico en cada turno, la tasa crítica aumenta un 20% adicional; después del tercer crítico en cada turno, el daño crítico aumenta un 50% adicional"
  },
  RelicConfig_13935_Desc = {
    Text = "La tasa crítica aumenta un 10%. Después del primer crítico en cada turno, la tasa crítica aumenta un 20% adicional; después del tercer crítico en cada turno, el daño crítico aumenta un 50% adicional"
  },
  RelicConfig_13935_Name = {
    Text = "<WhiteQuality:Bendición festiva>"
  },
  RelicConfig_13935_StoryDesc = {
    Text = "Debería traer bendiciones a los enamorados"
  },
  RelicConfig_13936_BattleDesc = {
    Text = "Es un objeto de misión semanal sin efecto 3"
  },
  RelicConfig_13936_Desc = {
    Text = "Es un objeto de misión semanal sin efecto 3"
  },
  RelicConfig_13936_Name = {
    Text = "Desafío diario, creación semanal 3"
  },
  RelicConfig_13937_BattleDesc = {
    Text = "Es un objeto de misión semanal sin efecto 2"
  },
  RelicConfig_13937_Desc = {
    Text = "Es un objeto de misión semanal sin efecto 2"
  },
  RelicConfig_13937_Name = {
    Text = "Desafío diario, creación semanal 2"
  },
  RelicConfig_13938_BattleDesc = {
    Text = "Es un objeto de misión semanal sin efecto 1"
  },
  RelicConfig_13938_Desc = {
    Text = "Es un objeto de misión semanal sin efecto 1"
  },
  RelicConfig_13938_Name = {
    Text = "Desafío diario, creación semanal 1"
  },
  RelicConfig_13939_BattleDesc = {
    Text = "Al comienzo de la tercera ronda, la tasa de crítico en esta batalla aumenta en un 15%, añadiendo 1 carta <DerivativeCardKeywords_39:\"eco del pasado\"> a tu mano"
  },
  RelicConfig_13939_Desc = {
    Text = "Al comienzo de la tercera ronda, la tasa de crítico en esta batalla aumenta en un 15%, añadiendo 1 carta <DerivativeCardKeywords_39:\"eco del pasado\"> a tu mano"
  },
  RelicConfig_13939_Name = {
    Text = "<OrangeQuality:Ofrenda del Pasado>"
  },
  RelicConfig_13939_StoryDesc = {
    Text = "Una vez fue una ofrenda"
  },
  RelicConfig_13940_BattleDesc = {
    Text = "Cuando tienes escudo, esta creación otorga [Arg1] puntos de <PowerIconKeywords:fuerza> temporal. Si tu escudo es mayor que tu vida actual, otorga [Arg2] puntos adicionales de <PowerIconKeywords:fuerza> temporal"
  },
  RelicConfig_13940_Desc = {
    Text = "Cuando tienes escudo, esta creación otorga [Arg1] puntos de <PowerIconKeywords:fuerza> temporal. Si tu escudo es mayor que tu vida actual, otorga [Arg2] puntos adicionales de <PowerIconKeywords:fuerza> temporal"
  },
  RelicConfig_13940_Name = {
    Text = "<WhiteQuality:Abanico de plumas de paloma>"
  },
  RelicConfig_13940_StoryDesc = {
    Text = "Elegante y caro, pero no muy práctico"
  },
  RelicConfig_13941_BattleDesc = {
    Text = "\"'Golpe' recupera [Arg1] puntos de vida, reduce [Arg1] capas de <IntoxicationIconKeywords:veneno>.\""
  },
  RelicConfig_13941_Desc = {
    Text = "\"'Golpe' recupera [Arg1] puntos de vida, reduce [Arg1] capas de <IntoxicationIconKeywords:veneno>.\""
  },
  RelicConfig_13941_Name = {
    Text = "<WhiteQuality:Pinza hemostática>"
  },
  RelicConfig_13941_StoryDesc = {
    Text = "\"¡Rápido, dámelo!\""
  },
  RelicConfig_13942_BattleDesc = {
    Text = "Por cada tentáculo, al final del turno obtendrá [Arg1] puntos de escudo; si el tentáculo está en estado de mar en calma, esta efecto ganará un 50% de escudo adicional"
  },
  RelicConfig_13942_Desc = {
    Text = "Por cada tentáculo, al final del turno obtendrá [Arg1] puntos de escudo; si el tentáculo está en estado de mar en calma, esta efecto ganará un 50% de escudo adicional"
  },
  RelicConfig_13942_Name = {
    Text = "<WhiteQuality:Extremidad anónima>"
  },
  RelicConfig_13942_StoryDesc = {
    Text = "Cuidado con las espinas"
  },
  RelicConfig_139929_BattleDesc = {
    Text = "Al comenzar el turno, Saya obtiene [Arg1] Aliemus. Por cada 100 Aliemus consumidos por el Exaltar de Saya, una \"Habilidad\" generada aleatoriamente surte efecto 1 vez adicional."
  },
  RelicConfig_139929_Desc = {
    Text = "Al comenzar el turno, Saya obtiene [Arg1] Aliemus. Por cada 100 Aliemus consumidos por el Exaltar de Saya, una \"Habilidad\" generada aleatoriamente surte efecto 1 vez adicional."
  },
  RelicConfig_139929_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Saya>"
  },
  RelicConfig_140276_BattleDesc = {
    Text = "<OrangeQuality:Desesperación>: Al inicio del turno, por cada 1% de vida máxima perdida, el daño final temporal aumenta un 5%. Si se activó la resistencia a la muerte en el turno anterior, este efecto se duplica.\n<RedQuality:Supremo>: La vida máxima de todos los enemigos aumenta un 300%."
  },
  RelicConfig_140276_Desc = {
    Text = "<OrangeQuality:Desesperación>: Al inicio del turno, por cada 1% de vida máxima perdida, el daño final temporal aumenta un 5%. Si se activó la resistencia a la muerte en el turno anterior, este efecto se duplica.\n<RedQuality:Supremo>: La vida máxima de todos los enemigos aumenta un 300%."
  },
  RelicConfig_140276_Name = {
    Text = "<RedQuality:Péndulo Dimensional–Duelo>"
  },
  RelicConfig_140277_BattleDesc = {
    Text = "<OrangeQuality:Proliferación>: Cada turno, la primera vez que cada Despertado juega una \"Habilidad\", genera 2 copias originales temporales de ella. Al jugar cartas de instrucción con coste de cómputo de 0 o 1, todos los Despertados obtienen 5 puntos de Furia.\n<RedQuality:Fortaleza>: Al jugar una carta con coste de cómputo original igual o mayor a 3, todos los enemigos obtienen un escudo equivalente al 20% de su vida máxima."
  },
  RelicConfig_140277_Desc = {
    Text = "<OrangeQuality:Proliferación>: Cada turno, la primera vez que cada Despertado juega una \"Habilidad\", genera 2 copias originales temporales de ella. Al jugar cartas de instrucción con coste de cómputo de 0 o 1, todos los Despertados obtienen 5 puntos de Furia.\n<RedQuality:Fortaleza>: Al jugar una carta con coste de cómputo original igual o mayor a 3, todos los enemigos obtienen un escudo equivalente al 20% de su vida máxima."
  },
  RelicConfig_140277_Name = {
    Text = "<RedQuality:Péndulo Dimensional–Alerta>"
  },
  RelicConfig_140278_BattleDesc = {
    Text = "<OrangeQuality:Regeneración>: Los efectos de escudo y recuperación obtenidos aumentan un 25%. Al recuperar vida u obtener escudo, por cada 1% de vida máxima en recuperación o escudo generado, se obtiene un 10% de bonificación temporal de daño.\n<RedQuality:Susurro>: Cada turno se obtiene una reducción de fuerza equivalente al 10% de la vida máxima."
  },
  RelicConfig_140278_Desc = {
    Text = "<OrangeQuality:Regeneración>: Los efectos de escudo y recuperación obtenidos aumentan un 25%. Al recuperar vida u obtener escudo, por cada 1% de vida máxima en recuperación o escudo generado, se obtiene un 10% de bonificación temporal de daño.\n<RedQuality:Susurro>: Cada turno se obtiene una reducción de fuerza equivalente al 10% de la vida máxima."
  },
  RelicConfig_140278_Name = {
    Text = "<RedQuality:Péndulo Dimensional–Espanto>"
  },
  RelicConfig_140279_BattleDesc = {
    Text = "<OrangeQuality:Aurora>: La Furia base de todos los Despertados se reduce en 30 puntos. El daño final de la primera Explosión de Furia de cada turno aumenta un 200%, y la recuperación de escudo y vida aumenta un 100%. Tras liberar 5 Explosiones de Furia, elige 1 Despertado para despertar y refresca el efecto de amplificación de Explosión de Furia.\n<RedQuality:Agotamiento>: La energía base de Llave de Plata aumenta un 200%."
  },
  RelicConfig_140279_Desc = {
    Text = "<OrangeQuality:Aurora>: La Furia base de todos los Despertados se reduce en 30 puntos. El daño final de la primera Explosión de Furia de cada turno aumenta un 200%, y la recuperación de escudo y vida aumenta un 100%. Tras liberar 5 Explosiones de Furia, elige 1 Despertado para despertar y refresca el efecto de amplificación de Explosión de Furia.\n<RedQuality:Agotamiento>: La energía base de Llave de Plata aumenta un 200%."
  },
  RelicConfig_140279_Name = {
    Text = "<RedQuality:Péndulo Dimensional–Vudú>"
  },
  RelicConfig_140280_BattleDesc = {
    Text = "<OrangeQuality:Despertar>: Tras la primera Explosión de Furia de cada turno, se reinicia el enfriamiento de la Explosión de Furia de ese Despertado y obtiene 50 de Furia. Genera copias temporales de todas sus \"Habilidades\" con coste de cómputo 0.\n<RedQuality:Sellado>: Tras la primera Explosión de Furia de cada turno, sella a los demás Despertados."
  },
  RelicConfig_140280_Desc = {
    Text = "<OrangeQuality:Despertar>: Tras la primera Explosión de Furia de cada turno, se reinicia el enfriamiento de la Explosión de Furia de ese Despertado y obtiene 50 de Furia. Genera copias temporales de todas sus \"Habilidades\" con coste de cómputo 0.\n<RedQuality:Sellado>: Tras la primera Explosión de Furia de cada turno, sella a los demás Despertados."
  },
  RelicConfig_140280_Name = {
    Text = "<RedQuality:Péndulo Dimensional–Duelo>"
  },
  RelicConfig_140281_BattleDesc = {
    Text = "<OrangeQuality:Eco>: Al inicio del turno, roba las 3 cartas de instrucción con mayor coste de cómputo del mazo de robo. La primera carta de instrucción jugada cada turno se activa 2 veces.\n<RedQuality:Aturdimiento>: Tras jugar una carta de instrucción, descarta todas las demás cartas de instrucción cuyo coste de cómputo sea igual o mayor al de la carta jugada."
  },
  RelicConfig_140281_Desc = {
    Text = "<OrangeQuality:Eco>: Al inicio del turno, roba las 3 cartas de instrucción con mayor coste de cómputo del mazo de robo. La primera carta de instrucción jugada cada turno se activa 2 veces.\n<RedQuality:Aturdimiento>: Tras jugar una carta de instrucción, descarta todas las demás cartas de instrucción cuyo coste de cómputo sea igual o mayor al de la carta jugada."
  },
  RelicConfig_140281_Name = {
    Text = "<RedQuality:Péndulo Dimensional–Confusión>"
  },
  RelicConfig_140282_BattleDesc = {
    Text = "<OrangeQuality:Gran Poder>: La <PowerIconKeywords:Fuerza> infligida por todos los Despertados aumenta un 50%. Por cada instancia de daño infligido, se obtienen [Arg2] puntos de <PowerIconKeywords:Fuerza> temporal.\n<RedQuality:Intangible>: Al inicio del combate, todos los enemigos obtienen 50 capas de <ParcloseIconKeywords:Barrera>."
  },
  RelicConfig_140282_Desc = {
    Text = "<OrangeQuality:Gran Poder>: La <PowerIconKeywords:Fuerza> infligida por todos los Despertados aumenta un 50%. Por cada instancia de daño infligido, se obtienen [Arg2] puntos de <PowerIconKeywords:Fuerza> temporal.\n<RedQuality:Intangible>: Al inicio del combate, todos los enemigos obtienen 50 capas de <ParcloseIconKeywords:Barrera>."
  },
  RelicConfig_140282_Name = {
    Text = "<RedQuality:Péndulo Dimensional–Acecho>"
  },
  RelicConfig_140840_BattleDesc = {
    Text = "Tamaño Máximo de la Mano +1. Al inicio del combate, genera 1 carta \"<DerivativeCardKeywords_148:驭魇>\" y la coloca en la Mano. Al Jugar el \"Golpe Básico\" del Cuerpo Despertado, el coste de Aritmética de \"<DerivativeCardKeywords_148:驭魇>\" -1 y causa [Arg1] puntos de Corrosión a todos los enemigos. Al Jugar la \"Defensa básica\" del Cuerpo Despertado, obtiene [Arg2] puntos de Fortaleza y el Efecto de Daño Final y la Fortaleza de la próxima vez que se juegue \"<DerivativeCardKeywords_148:驭魇>\" aumentan un [Arg3]%."
  },
  RelicConfig_140840_Desc = {
    Text = "Tamaño Máximo de la Mano +1. Al inicio del combate, genera 1 carta \"<DerivativeCardKeywords_148:驭魇>\" y la coloca en la Mano. Al Jugar el \"Golpe Básico\" del Cuerpo Despertado, el coste de Aritmética de \"<DerivativeCardKeywords_148:驭魇>\" -1 y causa [Arg1] puntos de Corrosión a todos los enemigos. Al Jugar la \"Defensa básica\" del Cuerpo Despertado, obtiene [Arg2] puntos de Fortaleza y el Efecto de Daño Final y la Fortaleza de la próxima vez que se juegue \"<DerivativeCardKeywords_148:驭魇>\" aumentan un [Arg3]%."
  },
  RelicConfig_140840_Name = {
    Text = "El Esfuerzo Inútil"
  },
  RelicConfig_140840_StoryDesc = {
    Text = "El inútil teme el cambio, teme que las cosas escapen a su control y, en lo más profundo de su ser, siente un miedo histérico a perder.\n Sopla El Silbato una y otra vez, queriendo controlarlo todo a través de su sonido, pero no logra retener nada."
  },
  RelicConfig_143665_BattleDesc = {
    Text = "Pontos obtiene [Arg1] Aliemus al inicio del turno. Al recogerlo, genera 3 cartas \"Gaunt\" Permanentes al inicio de la siguiente batalla. Pontos obtiene 3 Aliemus después de Jugar un \"Gaunt\"."
  },
  RelicConfig_143665_Desc = {
    Text = "Pontos obtiene [Arg1] Aliemus al inicio del turno. Al recogerlo, genera 3 cartas \"Gaunt\" Permanentes al inicio de la siguiente batalla. Pontos obtiene 3 Aliemus después de Jugar un \"Gaunt\"."
  },
  RelicConfig_143665_Name = {
    Text = "<OrangeQuality:Imagen Dimensional: Pontos>"
  },
  RelicConfig_145438_BattleDesc = {
    Text = "En el inicio del turno, gana [Arg1] Aliemus. Después de usar \"Separación de Mundus\", realiza Caza: \"Filo Abisal\" al inicio del siguiente turno: Inflige Daño equivalente al 400% del ATQ de Lotan: Cetarconte a todos los enemigos. Esta Caza se beneficia de la Bonificación de daño que \"Separación de Mundus\" obtiene a través de \"Gran Cuchilla: Caída de Ballena\" y se considera un \"golpear\"."
  },
  RelicConfig_145438_Desc = {
    Text = "En el inicio del turno, gana [Arg1] Aliemus. Después de usar \"Separación de Mundus\", realiza Caza: \"Filo Abisal\" al inicio del siguiente turno: Inflige Daño equivalente al 400% del ATQ de Lotan: Cetarconte a todos los enemigos. Esta Caza se beneficia de la Bonificación de daño que \"Separación de Mundus\" obtiene a través de \"Gran Cuchilla: Caída de Ballena\" y se considera un \"golpear\"."
  },
  RelicConfig_145438_Name = {
    Text = "<OrangeQuality:Imagen Dimensional: Lotan: Cetarconte>"
  },
  RelicConfig_146128_BattleDesc = {
    Text = "Tamaño Máximo de la Mano +1. En el Comienzo del combate o Después de jugar \"<DerivativeCardKeywords_157:Hueso de la Espada>\", coloca 1 \"<DerivativeCardKeywords_155:Hueso de la Locura>\" en tu Mano y Baraja 1 \"<DerivativeCardKeywords_156:Hueso de las Heridas>\" en tu Mazo de robo. Si \"<DerivativeCardKeywords_155:Hueso de la Locura>\" y \"<DerivativeCardKeywords_156:Hueso de las Heridas>\" se juegan ambos en el mismo turno, combina estas dos cartas en \"<DerivativeCardKeywords_157:Hueso de la Espada>\" y colócala en tu Mano."
  },
  RelicConfig_146128_Desc = {
    Text = "Tamaño Máximo de la Mano +1. En el Comienzo del combate o Después de jugar \"<DerivativeCardKeywords_157:Hueso de la Espada>\", coloca 1 \"<DerivativeCardKeywords_155:Hueso de la Locura>\" en tu Mano y Baraja 1 \"<DerivativeCardKeywords_156:Hueso de las Heridas>\" en tu Mazo de robo. Si \"<DerivativeCardKeywords_155:Hueso de la Locura>\" y \"<DerivativeCardKeywords_156:Hueso de las Heridas>\" se juegan ambos en el mismo turno, combina estas dos cartas en \"<DerivativeCardKeywords_157:Hueso de la Espada>\" y colócala en tu Mano."
  },
  RelicConfig_146128_Name = {
    Text = "Armadura de Hueso de Ballena"
  },
  RelicConfig_146128_StoryDesc = {
    Text = "Los huesos de Leviatán protegen a Sus elegidos, volviéndolos invencibles e inmortales."
  },
  RelicConfig_147547_BattleDesc = {
    Text = "Al inicio del turno, Casiah obtiene [Arg1] puntos de locura. Cada vez que roba una carta, Casiah obtiene [Arg2] puntos adicionales de locura. Cuando Casiah libera su exaltación, todos los enemigos pierden [Arg3] puntos de fuerza."
  },
  RelicConfig_147547_Desc = {
    Text = "Al inicio del turno, Casiah obtiene [Arg1] puntos de locura. Cada vez que roba una carta, Casiah obtiene [Arg2] puntos adicionales de locura. Cuando Casiah libera su exaltación, todos los enemigos pierden [Arg3] puntos de fuerza."
  },
  RelicConfig_147547_Name = {
    Text = "<OrangeQuality:Imagen Dimensional de Cassia>"
  },
  RelicConfig_147665_BattleDesc = {
    Text = "El Límite de Aritmética y el número de cartas robadas por turno +1. Al inicio del turno, <FaxianKeywords:descubre> 3 \"<Caroboo_Tips:Pistolas de Marie>\" y elige una. Solo 1 de ellas es real: si eliges la real, obtienes su Efecto positivo y disipas 1 Estado negativo aleatorio propio; si eliges la falsa, sufres su Efecto negativo y en el próximo <FaxianKeywords:descubrimiento> las opciones reales +1 y los efectos se duplican, lo cual se reinicia al elegir la real."
  },
  RelicConfig_147665_Desc = {
    Text = "El Límite de Aritmética y el número de cartas robadas por turno +1. Al inicio del turno, <FaxianKeywords:descubre> 3 \"<Caroboo_Tips:Pistolas de Marie>\" y elige una. Solo 1 de ellas es real: si eliges la real, obtienes su Efecto positivo y disipas 1 Estado negativo aleatorio propio; si eliges la falsa, sufres su Efecto negativo y en el próximo <FaxianKeywords:descubrimiento> las opciones reales +1 y los efectos se duplican, lo cual se reinicia al elegir la real."
  },
  RelicConfig_147665_Name = {
    Text = "Pistolas de Marie"
  },
  RelicConfig_147665_StoryDesc = {
    Text = "Dulce y precioso... ¿o no?"
  },
  RelicConfig_148525_BattleDesc = {
    Text = "Al inicio del turno, Ogier Vinculado por Juramento gana [Arg1] de Alienación, y \"Surge Oscuro\" ya no reduce el número de robos."
  },
  RelicConfig_148525_Desc = {
    Text = "Al inicio del turno, Ogier Vinculado por Juramento gana [Arg1] de Alienación, y \"Surge Oscuro\" ya no reduce el número de robos."
  },
  RelicConfig_148525_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Voto Oscuro·Ogier>"
  },
  RelicConfig_149665_BattleDesc = {
    Text = "El terreno actual cuenta como \"Campo de hielo.\"\nEn Hiperbórea: Tras la Fase de Robar, aplica 1 Acumulación de <SlowIconKeywords:Estancamiento> y <RetainIconKeywords:Retener> a las 2 Tarjetas de comando no congeladas con el mayor Coste de Aritmética en la mano. Cuando cualquier Tarjeta de comando tenga al menos 3 Acumulaciones de <SlowIconKeywords:Estancamiento>, elimina su <SlowIconKeywords:Estancamiento> y <RetainIconKeywords:Retener> (obtenidos en esta batalla), Congélala y aplica 25 Acumulaciones de <TempPowerKeywords2:Refuerzo>."
  },
  RelicConfig_149665_Desc = {
    Text = "El terreno actual cuenta como \"Campo de hielo.\"\nEn Hiperbórea: Tras la Fase de Robar, aplica 1 Acumulación de <SlowIconKeywords:Estancamiento> y <RetainIconKeywords:Retener> a las 2 Tarjetas de comando no congeladas con el mayor Coste de Aritmética en la mano. Cuando cualquier Tarjeta de comando tenga al menos 3 Acumulaciones de <SlowIconKeywords:Estancamiento>, elimina su <SlowIconKeywords:Estancamiento> y <RetainIconKeywords:Retener> (obtenidos en esta batalla), Congélala y aplica 25 Acumulaciones de <TempPowerKeywords2:Refuerzo>."
  },
  RelicConfig_149665_Name = {
    Text = "<OrangeQuality:Globo de Cristal>"
  },
  RelicConfig_149665_StoryDesc = {
    Text = "No trae el frío.\nSimplemente le recuerda a la tierra que el invierno nunca se fue."
  },
  RelicConfig_20164_BattleDesc = {
    Text = "Cada daño otorga [Arg1] de <PowerIconKeywords:Fuerza> temporal, hasta 5 capas. Al alcanzar el máximo, otorga [Arg1] de <PowerIconKeywords:Fuerza>"
  },
  RelicConfig_20164_Desc = {
    Text = "Cada daño otorga [Arg1] de <PowerIconKeywords:Fuerza> temporal, hasta 5 capas. Al alcanzar el máximo, otorga [Arg1] de <PowerIconKeywords:Fuerza>"
  },
  RelicConfig_20164_Name = {
    Text = "<OrangeQuality:péndulo crono\"Despertar\">"
  },
  RelicConfig_20165_BattleDesc = {
    Text = "Al recoger, se despiertan todos los despertadores. Después de usar <ExaltIconKeywords: despertar>, se obtienen aleatoriamente 2 cartas de comando de ese despertador y se añaden \"agotamiento\" y \"ilusión\""
  },
  RelicConfig_20165_Desc = {
    Text = "Al recoger, se despiertan todos los despertadores. Después de usar <ExaltIconKeywords: despertar>, se obtienen aleatoriamente 2 cartas de comando de ese despertador y se añaden \"agotamiento\" y \"ilusión\""
  },
  RelicConfig_20165_Name = {
    Text = "<OrangeQuality:Su Oráculo+>"
  },
  RelicConfig_20165_StoryDesc = {
    Text = "Él dijo, no temas"
  },
  RelicConfig_20166_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Maestría en Reinos> aumenta 100. Recoloca la primera carta jugada cada turno en tu mano. Al inicio del turno extradimensional, límite de cartas +5 y duplica tu mano"
  },
  RelicConfig_20166_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maestría en Reinos> aumenta 100. Recoloca la primera carta jugada cada turno en tu mano desde el mazo de descarte. Al inicio del turno ultra, límite de cartas en mano +5 y duplica tu mano, las cartas duplicadas añaden <NothingnessIconKeywords:Oblivion> y <DepleteIconKeywords:Consumo>."
  },
  RelicConfig_20166_Name = {
    Text = "<OrangeQuality:péndulo crono\"Sueño robado\">"
  },
  RelicConfig_20167_BattleDesc = {
    Text = "Al final del turno, si hay potencia restante, roba 2 cartas adicionales en el próximo turno; si hay cartas restantes, obtén 2 puntos adicionales de potencia en el próximo turno"
  },
  RelicConfig_20167_Desc = {
    Text = "Al final del turno, si hay potencia restante, roba 2 cartas adicionales en el próximo turno; si hay cartas restantes, obtén 2 puntos adicionales de potencia en el próximo turno"
  },
  RelicConfig_20167_Name = {
    Text = "<OrangeQuality:Rueda del Sol y la Luna+>"
  },
  RelicConfig_20167_StoryDesc = {
    Text = "Adivina, ¿negro o blanco?"
  },
  RelicConfig_20168_BattleDesc = {
    Text = "Límite de tentáculos +2. Al liberar la explosión de locura, daño de tentáculo +[Arg1]. Si se liberó 3 veces la explosión de locura en un turno, activa todos los tentáculos una vez"
  },
  RelicConfig_20168_Desc = {
    Text = "Límite de tentáculos +2. Al liberar la explosión de locura, daño de tentáculo +[Arg1]. Si se liberó 3 veces la explosión de locura en un turno, activa todos los tentáculos una vez"
  },
  RelicConfig_20168_Name = {
    Text = "<OrangeQuality:péndulo crono\"Sueño ligero\">"
  },
  RelicConfig_20169_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Maestría del Reino> +100. Cada vez que juegas una carta, <EmbryoFusionIconKeywords:Fusión Embrionaria> +10; cuando los PV son inferiores al 25%, aumenta a 20%. Este efecto se activa un máximo de 10 veces por turno."
  },
  RelicConfig_20169_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maestría del Reino> +100. Cada vez que juegas una carta, <EmbryoFusionIconKeywords:Fusión Embrionaria> +10; cuando los PV son inferiores al 25%, aumenta a 20%. Este efecto se activa un máximo de 10 veces por turno."
  },
  RelicConfig_20169_Name = {
    Text = "<OrangeQuality:péndulo crono\"Olas»>"
  },
  RelicConfig_20170_BattleDesc = {
    Text = "Al comenzar la batalla, todos los despertadores reciben 50 puntos de locura. Coloca 2 cartas <DerivativeCardKeywords_1:\"eco de sombra\"> en tu mano"
  },
  RelicConfig_20170_Desc = {
    Text = "Al comenzar la batalla, todos los despertadores reciben 50 puntos de locura. Coloca 2 cartas <DerivativeCardKeywords_1:\"eco de sombra\"> en tu mano"
  },
  RelicConfig_20170_Name = {
    Text = "<OrangeQuality:Equipo de Comunicación+>"
  },
  RelicConfig_20170_StoryDesc = {
    Text = "Esperando o temiendo el momento en que suene la campana"
  },
  RelicConfig_20171_BattleDesc = {
    Text = "Al recoger, obtienes aleatoriamente 1 reliquia de plata, 1 reliquia de oro y 1 reliquia maldita"
  },
  RelicConfig_20171_Desc = {
    Text = "Al recoger, obtienes aleatoriamente 1 reliquia de plata, 1 reliquia de oro y 1 reliquia maldita"
  },
  RelicConfig_20171_Name = {
    Text = "<OrangeQuality:Observación Inversa+>"
  },
  RelicConfig_20171_StoryDesc = {
    Text = "En la era extraña, las flores eran los primeros espectadores de la humanidad.\nNo te muevas, prefieren las exhibiciones tranquilas"
  },
  RelicConfig_20172_BattleDesc = {
    Text = "Al jugar la tercera carta de comando cada turno, obtienes 1 carta <DerivativeCardKeywords_4:\"inspiración\">, al alcanzar 6 cartas, obtienes otra <DerivativeCardKeywords_4:\"inspiración\">, y al llegar a 10 cartas, al inicio del siguiente turno puedes elegir 2 cartas del mazo para añadir a la mano"
  },
  RelicConfig_20172_Desc = {
    Text = "Al jugar la tercera carta de comando cada turno, obtienes 1 carta <DerivativeCardKeywords_4:\"inspiración\">, al alcanzar 6 cartas, obtienes otra <DerivativeCardKeywords_4:\"inspiración\">, y al llegar a 10 cartas, al inicio del siguiente turno puedes elegir 2 cartas del mazo para añadir a la mano"
  },
  RelicConfig_20172_Name = {
    Text = "<OrangeQuality: Péndulo crono\"Eco\">"
  },
  RelicConfig_20173_BattleDesc = {
    Text = "Aumenta el daño a enemigos en estado negativo en un 50%, y el asesino obtiene 100 de locura al matar"
  },
  RelicConfig_20173_Desc = {
    Text = "Aumenta el daño a enemigos en estado negativo en un 50%, y el asesino obtiene 100 de locura al matar"
  },
  RelicConfig_20173_Name = {
    Text = "<OrangeQuality:Cetro del Sacerdote+>"
  },
  RelicConfig_20173_StoryDesc = {
    Text = "Devoción no permitida"
  },
  RelicConfig_20174_BattleDesc = {
    Text = "Al recoger, la Amplificación de Daño del equipo x150%. Al inicio del turno, inflige [Arg1] de <FixedDamage:DMG Puro> a un enemigo aleatorio. Por cada Posse usada en esta batalla, aumenta el DMG infligido en [Arg2]. Este bono de DMG disfruta del bono de Amplificación de Daño del equipo."
  },
  RelicConfig_20174_Desc = {
    Text = "Al recoger, la Amplificación de Daño del equipo x150%. Al inicio del turno, inflige [Arg1] de <FixedDamage:DMG Puro> a un enemigo aleatorio. Por cada Posse usada en esta batalla, aumenta el DMG infligido en [Arg2]. Este bono de DMG disfruta del bono de Amplificación de Daño del equipo."
  },
  RelicConfig_20174_Name = {
    Text = "<OrangeQuality:péndulo crono\"Pérdida»>"
  },
  RelicConfig_20175_BattleDesc = {
    Text = "El efecto de <WeaknessIconKeywords:debilidad> causado aumenta un 8%, el efecto de <VulnerabilityIconKeywords:vulnerable> aumenta un 25%. Al aplicar <WeaknessIconKeywords:debilidad> o <VulnerabilityIconKeywords:vulnerable>, roba temporalmente [Arg1] puntos de <PowerIconKeywords:poder> del objetivo"
  },
  RelicConfig_20175_Desc = {
    Text = "El efecto de <WeaknessIconKeywords:debilidad> causado aumenta un 8%, el efecto de <VulnerabilityIconKeywords:vulnerable> aumenta un 25%. Al aplicar <WeaknessIconKeywords:debilidad> o <VulnerabilityIconKeywords:vulnerable>, roba temporalmente [Arg1] puntos de <PowerIconKeywords:poder> del objetivo"
  },
  RelicConfig_20175_Name = {
    Text = "<OrangeQuality:Foto desvanecida+>"
  },
  RelicConfig_20175_StoryDesc = {
    Text = "Una foto borrosa lleva consigo recuerdos borrosos, o tal vez es la falta de memoria lo que ha provocado el desvanecimiento de la foto."
  },
  RelicConfig_20176_BattleDesc = {
    Text = "Al comienzo del turno, por cada enemigo obtienes 2 aritmética. Cuando matas un enemigo con daño activo, infliges <BleedingIconKeywords:sangrando> equivalente al daño sobrante duplicado a los otros enemigos"
  },
  RelicConfig_20176_Desc = {
    Text = "Al comienzo del turno, por cada enemigo obtienes 2 aritmética. Cuando matas un enemigo con daño activo, infliges <BleedingIconKeywords:sangrando> equivalente al daño sobrante duplicado a los otros enemigos"
  },
  RelicConfig_20176_Name = {
    Text = "<OrangeQuality:Canción de la Multitud+>"
  },
  RelicConfig_20176_StoryDesc = {
    Text = "Nacido para torturar tus oídos"
  },
  RelicConfig_20177_BattleDesc = {
    Text = "Al recoger, la resistencia a la muerte se duplica. Después de infligir daño, también infliges <BleedingIconKeywords: sangrado> equivalente al 50% del daño. Cada vez que se activa la resistencia a la muerte, todos los enemigos sufren un sangrado inmediato 1 vez"
  },
  RelicConfig_20177_Desc = {
    Text = "Al recoger, la resistencia a la muerte se duplica. Después de infligir daño, también infliges <BleedingIconKeywords: sangrado> equivalente al 50% del daño. Cada vez que se activa la resistencia a la muerte, todos los enemigos sufren un sangrado inmediato 1 vez"
  },
  RelicConfig_20177_Name = {
    Text = "<OrangeQuality: Péndulo crono\"Resurrección\">"
  },
  RelicConfig_20178_BattleDesc = {
    Text = "Cada vez que se causa 1 daño activo, se obtienen 3 puntos de aliemus y se aplica a la meta [Arg1] capas <IntoxicationIconKeywords:veneno>. Si se alcanza un total acumulado de 25 activaciones dentro de esta batalla, se activa inmediatamente el <IntoxicationIconKeywords:veneno> en todos los enemigos"
  },
  RelicConfig_20178_Desc = {
    Text = "Cada vez que se causa 1 daño activo, se obtienen 3 puntos de aliemus y se aplica a la meta [Arg1] capas <IntoxicationIconKeywords:veneno>. Si se alcanza un total acumulado de 25 activaciones dentro de esta batalla, se activa inmediatamente el <IntoxicationIconKeywords:veneno> en todos los enemigos"
  },
  RelicConfig_20178_Name = {
    Text = "<OrangeQuality:Máquina de Coser Polvorienta+>"
  },
  RelicConfig_20178_StoryDesc = {
    Text = "Una madre cariñosa, remendando las heridas del corazón"
  },
  RelicConfig_21906_BattleDesc = {
    Text = "\"El golpe\" obtiene 3 puntos de aritmética y descarta aleatoriamente 1 carta; \"DEF\" roba 3 cartas y pierde 1 punto de aritmética"
  },
  RelicConfig_21906_Desc = {
    Text = "\"El golpe\" obtiene 3 puntos de aritmética y descarta aleatoriamente 1 carta; \"DEF\" roba 3 cartas y pierde 1 punto de aritmética"
  },
  RelicConfig_21906_Name = {
    Text = "<RedQuality:Disco feliz+>"
  },
  RelicConfig_21906_StoryDesc = {
    Text = "Grabación del último concierto del famoso violinista.\nDesde entonces, puede traer fuego"
  },
  RelicConfig_23688_BattleDesc = {
    Text = "Cada vez que se activa 1 vez el <EmbryoFusionIconKeywords:Fusión Embrionaria>, obtienes 30 puntos y [Arg1] puntos de <PowerIconKeywords:Fuerza>. Si es la segunda activación en un turno, obtienes 1 punto de aritmética y robas 1 carta. Si es la tercera activación en un turno, obtienes 2 puntos de aritmética y robas 2 cartas."
  },
  RelicConfig_23688_Desc = {
    Text = "Cada vez que se activa 1 vez el <EmbryoFusionIconKeywords:Fusión Embrionaria>, obtienes 30 puntos y [Arg1] puntos de <PowerIconKeywords:Fuerza>. Si es la segunda vez que se activa en un turno, obtienes 1 punto de aritmética y robas 1 carta; si es la tercera vez que se activa en un turno, obtienes 2 puntos de aritmética y robas 2 cartas."
  },
  RelicConfig_23688_Name = {
    Text = "<OrangeQuality: Péndulo crono\"Retroceso\">"
  },
  RelicConfig_23689_BattleDesc = {
    Text = "Al recoger, todos los Despertados obtienen 30 puntos de locura. Cada vez que liberas la exaltación, aumenta el conteo en 1. Al liberar la llave, obtienes [Arg1] puntos de precaución temporal, [Arg2] puntos de <PowerIconKeywords:fuerza> temporal y todos los Despertados obtienen 6 puntos de locura, consumiendo todo el conteo, cada punto de conteo tiene efecto 1 vez adicional."
  },
  RelicConfig_23689_Desc = {
    Text = "Al recoger, todos los Despertados obtienen 30 puntos de locura. Cada vez que liberes la explosión de locura, aumenta en 1 el conteo. Después de liberar la llave, obtienes [Arg1] puntos de precaución temporal, [Arg2] puntos de <PowerIconKeywords:fuerza> temporal y todos los Despertados obtienen 6 puntos de locura, consumiendo todo el conteo, cada punto de conteo tiene efecto 1 vez adicional."
  },
  RelicConfig_23689_Name = {
    Text = "<OrangeQuality:péndulo crono\"Cargar»>"
  },
  RelicConfig_23690_BattleDesc = {
    Text = "Por cada 1 punto de aritmética adicional que obtengas o por cada carta adicional que robes, roba [Arg1] puntos de <PowerIconKeywords:fuerza> a todos los enemigos, obtén un 4% de tasa de crítico temporal, y los efectos de Élite o Líder Batalla se duplican. Al inicio del turno ultra, obtén [Arg2] puntos de <PowerIconKeywords:fuerza>, el daño crítico +15%."
  },
  RelicConfig_23690_Desc = {
    Text = "Por cada 1 punto adicional de aritmética o por cada carta adicional robada, roba [Arg1] puntos de <PowerIconKeywords:fuerza> a todos los enemigos, obtén un 4% de tasa crítica temporal, y los efectos de élite o de líder de batalla se duplican. Al inicio del turno ultra, obtén [Arg2] puntos de <PowerIconKeywords:fuerza>, y el daño crítico aumenta un 15%."
  },
  RelicConfig_23690_Name = {
    Text = "<OrangeQuality:péndulo crono\"Fisura»>"
  },
  RelicConfig_23691_BattleDesc = {
    Text = "Por cada 5 daños causados, recupera [Arg1] puntos de vida. Por cada punto de vida perdido, daño de tentáculo +[Arg2], si pierdes más de [Arg3] puntos de vida, activa todos los tentáculos una vez"
  },
  RelicConfig_23691_Desc = {
    Text = "Cada vez que se causa 5 puntos de daño, se recuperan [Arg1] puntos de vida. Por cada punto de vida perdido, el daño de tentáculo aumenta +[Arg2]; si se pierde más del 10% de la vida máxima, todos los tentáculos se activan 1 vez"
  },
  RelicConfig_23691_Name = {
    Text = "<OrangeQuality:péndulo crono\"Marea»>"
  },
  RelicConfig_35135_BattleDesc = {
    Text = "Por cada daño causado, obtén [Arg1] puntos de <PowerIconKeywords:fuerza> temporal y [Arg2] puntos de daño temporal de tentáculos, con un máximo de 12 activaciones por turno. Si en un turno se causan 4 daños, aplica 1 nivel de Vulnerable a todos los enemigos y obtén [Arg3] puntos de blindaje; si se causan 8 daños, aplica 1 nivel de Debilidad a todos los enemigos y recupera [Arg3] puntos de PV."
  },
  RelicConfig_35135_Desc = {
    Text = "Por cada daño causado, obtén [Arg1] puntos de <PowerIconKeywords:fuerza> temporal y [Arg2] puntos de daño temporal de tentáculos, con un máximo de 12 activaciones por turno. Si se causan 4 daños en un turno, aplica 1 nivel de Vulnerable a todos los enemigos y obtén [Arg3] puntos de Blindaje; si se causan 8 daños, aplica 1 nivel de Debilidad a todos los enemigos y recupera [Arg3] puntos de PV."
  },
  RelicConfig_35135_Name = {
    Text = "<OrangeQuality: Péndulo crono\"Enamorado\">"
  },
  RelicConfig_35136_BattleDesc = {
    Text = "\"El daño\" del \"golpe\" y el escudo obtenido por \"DEF\" aumentan un 30%, si se jugaron 4 o más \"golpe\" y \"defensa\" en un turno, al inicio del siguiente turno roba 2 cartas y obtén 1 punto de aritmética"
  },
  RelicConfig_35136_Desc = {
    Text = "\"El daño\" del \"golpe\" y el escudo obtenido por \"DEF\" aumentan un 30%, si se jugaron 4 o más \"golpe\" y \"defensa\" en un turno, al inicio del siguiente turno roba 2 cartas y obtén 1 punto de aritmética"
  },
  RelicConfig_35136_Name = {
    Text = "<OrangeQuality: Péndulo crono\"Obstinación\">"
  },
  RelicConfig_35137_BattleDesc = {
    Text = "Cada vez que juegues una carta, obtén [Arg1] puntos de <PowerIconKeywords:fuerza> temporal y recupera [Arg2] puntos de vida. Al causar daño activo, elimina [Arg2] puntos de <PowerIconKeywords:fuerza> obtenidos por esta creación. El Despertado obtiene 30 puntos de locura por cada enemigo derrotado"
  },
  RelicConfig_35137_Desc = {
    Text = "Cada vez que juegues una carta, obtén [Arg1] puntos de <PowerIconKeywords:fuerza> temporal y recupera [Arg2] puntos de vida. Al causar daño activo, elimina [Arg2] puntos de <PowerIconKeywords:fuerza> obtenidos por esta creación. El Despertado obtiene 30 puntos de locura por cada enemigo derrotado"
  },
  RelicConfig_35137_Name = {
    Text = "<OrangeQuality:péndulo crono\"Acumulación\">"
  },
  RelicConfig_35138_BattleDesc = {
    Text = "Tras liberar la Exaltar, aplica [Arg1] puntos de veneno a un enemigo aleatorio. Cada vez que se juega una tarjeta de comando, obtienes [Arg2] puntos de contrataque temporal. Al final de cada 4 turnos, causa daño equivalente a la suma de los niveles de envenenamiento de los enemigos y tus niveles de contrataque."
  },
  RelicConfig_35138_Desc = {
    Text = "Tras liberar la Exaltar, aplica [Arg1] puntos de veneno a un enemigo aleatorio. Cada vez que juegues una carta de comando, obtienes [Arg2] puntos de contrataque temporal. Al final de cada 4 turnos, causa daño equivalente a la suma de los niveles de envenenamiento de los enemigos y las acumulaciones de tu contrataque a todos los enemigos."
  },
  RelicConfig_35138_Name = {
    Text = "<OrangeQuality:péndulo crono\"Extensión»>"
  },
  RelicConfig_35139_BattleDesc = {
    Text = "Al recoger, el daño de grupo aumenta en un 30%. Cada 4º daño infligido será un golpe crítico, y el daño crítico se incrementa en un 50%. Si ese daño resulta en una eliminación, obtiene 5 sigilos negros"
  },
  RelicConfig_35139_Desc = {
    Text = "Al recoger, el daño de grupo aumenta en un 30%. Cada 4º daño infligido será un golpe crítico, y el daño crítico se incrementa en un 50%. Si ese daño resulta en una eliminación, obtiene 5 sigilos negros"
  },
  RelicConfig_35139_Name = {
    Text = "<OrangeQuality:péndulo crono\"Final»>"
  },
  RelicConfig_36823_BattleDesc = {
    Text = "Al liberar la exaltación, roba 1 carta. Por cada carta descartada, todos los despertadores ganan 3 puntos de locura, hasta un máximo de 15 por turno"
  },
  RelicConfig_36823_Desc = {
    Text = "Al liberar la exaltación, roba 1 carta. Por cada carta descartada, todos los despertadores ganan 3 puntos de locura, hasta un máximo de 15 por turno"
  },
  RelicConfig_36823_Name = {
    Text = "<OrangeQuality: Péndulo crono\"Tráfico\">"
  },
  RelicConfig_36824_BattleDesc = {
    Text = "Cada vez que se gaste aritmética, roba 1 carta, siendo efectiva un máximo de 5 veces por turno. Cada vez que se reinicie la biblioteca, se obtienen 2 puntos de aritmética"
  },
  RelicConfig_36824_Desc = {
    Text = "Cada vez que se gaste aritmética, roba 1 carta, siendo efectiva un máximo de 5 veces por turno. Cada vez que se reinicie la biblioteca, se obtienen 2 puntos de aritmética"
  },
  RelicConfig_36824_Name = {
    Text = "<OrangeQuality: Péndulo crono\"Insomnio\">"
  },
  RelicConfig_39302_BattleDesc = {
    Text = "Cada vez que se causa 4 puntos de daño, se baraja 1 <DerivativeCardKeywords_4:\"inspiración\"> en la pila de robo, máximo 3 veces por turno. Después de liberar exaltación, se juegan y consumen todas las <DerivativeCardKeywords_4:\"inspiración\"> en la pila"
  },
  RelicConfig_39302_Desc = {
    Text = "Cada vez que se causa 4 puntos de daño, se baraja 1 <DerivativeCardKeywords_4:\"inspiración\"> en la pila de robo, máximo 3 veces por turno. Después de liberar exaltación, se juegan y consumen todas las <DerivativeCardKeywords_4:\"inspiración\"> en la pila"
  },
  RelicConfig_39302_Name = {
    Text = "<OrangeQuality:péndulo crono\"Sueño perdido»>"
  },
  RelicConfig_39303_BattleDesc = {
    Text = "Cuando la aritmética actual es impar, se considera que tienes [Arg2] puntos de <AlertIconKeywords:alerta> temporal adicionales. Cuando la aritmética actual es par, se considera que tienes [Arg1] puntos de <PowerIconKeywords:fuerza> temporal adicionales y [Arg3] puntos de daño de tentáculos temporal. Por cada creación de oro que poseas, el efecto de esta creación aumenta en un 50%, y por cada criatura maldita que poseas, aumenta en un 80%."
  },
  RelicConfig_39303_Desc = {
    Text = "Cuando la aritmética actual es impar, se considera que tienes [Arg2] puntos adicionales de <AlertIconKeywords:alerta> temporal. Cuando la aritmética actual es par, se considera que tienes [Arg1] puntos adicionales de <PowerIconKeywords:fuerza> temporal y [Arg3] puntos de daño temporal de tentáculos. Por cada creación de oro que poseas, el efecto de esta creación aumenta en un 50%, y por cada criatura maldita que poseas, aumenta en un 80%."
  },
  RelicConfig_39303_Name = {
    Text = "<OrangeQuality: Péndulo crono\"Sueño Impactante\">"
  },
  RelicConfig_44192_BattleDesc = {
    Text = "Al inicio de cada turno, todos los despertadores obtienen 20 puntos de aliemus. Al recolectar, la salud máxima se reduce en 50%"
  },
  RelicConfig_44192_Desc = {
    Text = "Al inicio de cada turno, todos los despertadores obtienen 20 puntos de aliemus. Al recolectar, la salud máxima se reduce en 50%"
  },
  RelicConfig_44192_Name = {
    Text = "<RedQuality:Culpable·Apariencia de pesadilla>"
  },
  RelicConfig_44192_StoryDesc = {
    Text = "El sueño profundo de la indulgencia es el deseo, que te devorará sin que te des cuenta"
  },
  RelicConfig_44300_BattleDesc = {
    Text = "Al inicio de cada turno, todos los despertadores obtienen 25 puntos de aliemus. Al recolectar, la salud máxima se convierte en 3 veces"
  },
  RelicConfig_44300_Desc = {
    Text = "Al inicio de cada turno, todos los despertadores obtienen 25 puntos de aliemus. Al recolectar, la salud máxima se convierte en 3 veces"
  },
  RelicConfig_44300_Name = {
    Text = "<OrangeQuality:Bendición: Apariencia de pesadilla>"
  },
  RelicConfig_44300_StoryDesc = {
    Text = "No temas, no dudes. Esto es solo un sueño fugaz, la luz del Padre aún brilla sobre ti"
  },
  RelicConfig_44592_BattleDesc = {
    Text = "Al finalizar la batalla, obtienes 100 el sigilo negro y 2 cartas de síntoma"
  },
  RelicConfig_44592_Desc = {
    Text = "Al finalizar la batalla, obtienes 100 el sigilo negro y 2 cartas de síntoma"
  },
  RelicConfig_44592_Name = {
    Text = "<RedQuality:Culpable·Impresión de jade>"
  },
  RelicConfig_44592_StoryDesc = {
    Text = "Los pecados antiguos están grabados aquí"
  },
  RelicConfig_44593_BattleDesc = {
    Text = "Al recoger, se transforma en 1 reliquia de pecado aleatoria que no sea el propio, y se obtienen 75 el sigilo negro"
  },
  RelicConfig_44593_Desc = {
    Text = "Al recoger, se transforma en 1 reliquia de pecado aleatoria que no sea el propio, y se obtienen 75 el sigilo negro"
  },
  RelicConfig_44593_Name = {
    Text = "<RedQuality:Culpable·Lápida maldita>"
  },
  RelicConfig_44593_StoryDesc = {
    Text = "Escucha, alguien está llamando desde dentro"
  },
  RelicConfig_44594_BattleDesc = {
    Text = "Cada 2 turnos, duplica el Daño activo y de Daño de tentáculos que todos los enemigos reciben en ese turno. Sin embargo, al liberar Exaltar en ese turno, sellará todos los Cuerpo Despertados por 1 turno, haciéndose a uno mismo Vulnerable."
  },
  RelicConfig_44594_Desc = {
    Text = "Cada 2 turnos, duplica el Daño activo y de Daño de tentáculos que todos los enemigos reciben en ese turno. Sin embargo, al liberar Exaltar en ese turno, sellará todos los Cuerpo Despertados por 1 turno, haciéndose a uno mismo Vulnerable."
  },
  RelicConfig_44594_Name = {
    Text = "<RedQuality:Culpable·Cadáver del camino>"
  },
  RelicConfig_44594_StoryDesc = {
    Text = "Una parte sagrada.\nDespués de separarse del torso, ha sido infiltrada por el pecado"
  },
  RelicConfig_44597_BattleDesc = {
    Text = "Cada vez que se causa 1 daño activo, se aplica a uno mismo [Arg1] capas <BleedingIconKeywords:sangrando> y se aplica a la meta [Arg2] capas <BleedingIconKeywords:sangrando>"
  },
  RelicConfig_44597_Desc = {
    Text = "Cada vez que se causa 1 daño activo, se aplica a uno mismo [Arg1] capas <BleedingIconKeywords:sangrando> y se aplica a la meta [Arg2] capas <BleedingIconKeywords:sangrando>"
  },
  RelicConfig_44597_Name = {
    Text = "<RedQuality:Culpable·Conciencia del enjambre>"
  },
  RelicConfig_44597_StoryDesc = {
    Text = "Entretejer, simbiosis, agrupación; miedo, lo desconocido, control"
  },
  RelicConfig_44598_BattleDesc = {
    Text = "Después de liberar la exaltar, pierde el 12% de su vida actual, roba [Arg1] puntos temporales de <PowerIconKeywords:poder> de todos los enemigos, si solo hay 1 enemigo, roba además [Arg2] puntos temporales de <PowerIconKeywords:poder>"
  },
  RelicConfig_44598_Desc = {
    Text = "Después de liberar la exaltar, pierde el 12% de su vida actual, roba [Arg1] puntos temporales de <PowerIconKeywords:poder> de todos los enemigos, si solo hay 1 enemigo, roba además [Arg2] puntos temporales de <PowerIconKeywords:poder>"
  },
  RelicConfig_44598_Name = {
    Text = "<RedQuality:Culpable·Pájaro del ritual de la fatalidad>"
  },
  RelicConfig_44598_StoryDesc = {
    Text = "Una pobre criatura muerta por la avaricia, emitiendo un chillido agudo desde su pecho marchito"
  },
  RelicConfig_44603_BattleDesc = {
    Text = "Límite de cartas en mano aumentado en 5, al comenzar la batalla roba 6 cartas. Al final del turno descarta todas las cartas de síntoma y de estado en mano, conserva otras cartas, pero el número de cartas robadas por turno disminuye en 2"
  },
  RelicConfig_44603_Desc = {
    Text = "Límite de cartas en mano aumentado en 5, al comenzar la batalla roba 6 cartas. Al final del turno descarta todas las cartas de síntoma y de estado en mano, conserva otras cartas, pero el número de cartas robadas por turno disminuye en 2"
  },
  RelicConfig_44603_Name = {
    Text = "<RedQuality:Culpable·Inscripción de conciencia>"
  },
  RelicConfig_44603_StoryDesc = {
    Text = "El avaro trata a los demás como objetos, obteniendo su placer del sufrimiento ajeno"
  },
  RelicConfig_44608_BattleDesc = {
    Text = "Al recoger, pierdes permanentemente [Arg1] <PowerIconKeywords:Fuerza>. Cada vez que causas daño, recuperas [Arg2] puntos de vida, hasta 6 veces por turno"
  },
  RelicConfig_44608_Desc = {
    Text = "Al recoger, pierdes permanentemente [Arg1] <PowerIconKeywords:Fuerza>. Cada vez que causas daño, recuperas [Arg2] puntos de vida, hasta 6 veces por turno"
  },
  RelicConfig_44608_Name = {
    Text = "<RedQuality:Culpable·Beso de la lamprea>"
  },
  RelicConfig_44608_StoryDesc = {
    Text = "Su beso te hará caer—claro, también podrías caer tú mismo"
  },
  RelicConfig_44609_BattleDesc = {
    Text = "Aumenta el límite de aritmética máxima en 3. Cada vez que se reinicie el mazo se agregarán 2 <DerivativeCardKeywords_9:\"tambalearse\"> a la pila de robos"
  },
  RelicConfig_44609_Desc = {
    Text = "Aumenta el límite de aritmética máxima en 3. Cada vez que se reinicie el mazo se agregarán 2 <DerivativeCardKeywords_9:\"tambalearse\"> a la pila de robos"
  },
  RelicConfig_44609_Name = {
    Text = "<RedQuality:Culpable·Vela negra>"
  },
  RelicConfig_44609_StoryDesc = {
    Text = "Quema la razón, cae en la locura"
  },
  RelicConfig_44610_BattleDesc = {
    Text = "La tasa crítica y el daño crítico aumentan un 50%, al inicio de cada turno, <FragileIconKeywords:frágil> por 1 turno"
  },
  RelicConfig_44610_Desc = {
    Text = "La tasa crítica y el daño crítico aumentan un 50%, al inicio de cada turno, <FragileIconKeywords:frágil> por 1 turno"
  },
  RelicConfig_44610_Name = {
    Text = "<RedQuality:Culpable·Garra extraña>"
  },
  RelicConfig_44610_StoryDesc = {
    Text = "Garras torcidas por el deseo"
  },
  RelicConfig_44654_BattleDesc = {
    Text = "Aumenta el límite de aritmética máxima en 4, cada vez que se reinicie el mazo se agregarán 4 <DerivativeCardKeywords_4:\"inspiración\"> a la pila de robos"
  },
  RelicConfig_44654_Desc = {
    Text = "Aumenta el límite de aritmética máxima en 4, cada vez que se reinicie el mazo se agregarán 4 <DerivativeCardKeywords_4:\"inspiración\"> a la pila de robos"
  },
  RelicConfig_44654_Name = {
    Text = "<OrangeQuality:Bendición: Vela negra>"
  },
  RelicConfig_44654_StoryDesc = {
    Text = "Quema el deseo, obtén redención"
  },
  RelicConfig_44656_BattleDesc = {
    Text = "Límite de creación +[Arg1], refrescos en \"d-marca\" +1. Después de la batalla, se obtienen 125 el sigilo negro, al recoger se puede elegir eliminar hasta 6 cartas de síntoma"
  },
  RelicConfig_44656_Desc = {
    Text = "Límite de creación +[Arg1], refrescos en \"d-marca\" +1. Después de la batalla, se obtienen 125 el sigilo negro, al recoger se puede elegir eliminar hasta 6 cartas de síntoma"
  },
  RelicConfig_44656_Name = {
    Text = "<OrangeQuality:Bendición: Impresión de jade>"
  },
  RelicConfig_44656_StoryDesc = {
    Text = "La redención del Padre Dios borró el dolor"
  },
  RelicConfig_44658_BattleDesc = {
    Text = "Tras liberar la exhalación de aliemus, obtienes [Arg1] puntos temporales de poder y robas [Arg1] puntos temporales de <PowerIconKeywords:poder> de todos los enemigos. Si solo hay un enemigo, roba [Arg2] puntos temporales adicionales de <PowerIconKeywords:poder>"
  },
  RelicConfig_44658_Desc = {
    Text = "Tras liberar la exhalación de aliemus, obtienes [Arg1] puntos temporales de poder y robas [Arg1] puntos temporales de <PowerIconKeywords:poder> de todos los enemigos. Si solo hay un enemigo, roba [Arg2] puntos temporales adicionales de <PowerIconKeywords:poder>"
  },
  RelicConfig_44658_Name = {
    Text = "<OrangeQuality:Bendición: Ritual de la fatalidad>"
  },
  RelicConfig_44658_StoryDesc = {
    Text = "La luz del perdón cubría los restos de la avaricia, el pájaro muerto cantó su última canción"
  },
  RelicConfig_44659_BattleDesc = {
    Text = "Cada vez que se causa 1 daño activo, se recupera [Arg1] vida y se aplica a la meta [Arg2] capas <BleedingIconKeywords:sangrando>"
  },
  RelicConfig_44659_Desc = {
    Text = "Cada vez que se causa 1 daño activo, se recupera [Arg1] vida y se aplica a la meta [Arg2] capas <BleedingIconKeywords:sangrando>"
  },
  RelicConfig_44659_Name = {
    Text = "<OrangeQuality:Bendición: Conciencia de enjambre>"
  },
  RelicConfig_44659_StoryDesc = {
    Text = "Entretejer, simbiosis, agrupación; unidad, coexistencia, refugio"
  },
  RelicConfig_44660_BattleDesc = {
    Text = "Límite de cartas en mano aumentado en 5, al iniciar la batalla llena la mano hasta el límite. Al comienzo del turno, roba 1 carta adicional, al final del turno descarta todas las cartas de síntoma y de estado en mano, conserva otras cartas"
  },
  RelicConfig_44660_Desc = {
    Text = "Límite de cartas en mano aumentado en 5, al iniciar la batalla llena la mano hasta el límite. Al comienzo del turno, roba 1 carta adicional, al final del turno descarta todas las cartas de síntoma y de estado en mano, conserva otras cartas"
  },
  RelicConfig_44660_Name = {
    Text = "<OrangeQuality:Bendición: Inscripción de conciencia>"
  },
  RelicConfig_44660_StoryDesc = {
    Text = "El avaro graba sus errores en su corazón y se dedica a redimir su pasado"
  },
  RelicConfig_44662_BattleDesc = {
    Text = "Cada 2 turnos, duplica el Daño activo y de Daño de tentáculos que todos los enemigos reciben en ese turno. Por cada Exaltar usado en ese turno, dispersa aleatoriamente 1 estado negativo."
  },
  RelicConfig_44662_Desc = {
    Text = "Cada 2 turnos, duplica el Daño activo y de Daño de tentáculos que todos los enemigos reciben en ese turno. Por cada Exaltar usado en ese turno, dispersa aleatoriamente 1 estado negativo."
  },
  RelicConfig_44662_Name = {
    Text = "<OrangeQuality:Bendición: Restos del camino>"
  },
  RelicConfig_44662_StoryDesc = {
    Text = [[
Una parte sagrada.
Aunque separada del torso, sus huellas se han extendido por los mares]]
  },
  RelicConfig_44663_BattleDesc = {
    Text = "La tasa crítica aumenta un 50%, el daño crítico aumenta un 100%"
  },
  RelicConfig_44663_Desc = {
    Text = "La tasa crítica aumenta un 50%, el daño crítico aumenta un 100%"
  },
  RelicConfig_44663_Name = {
    Text = "<OrangeQuality:Bendición: Garra extraña>"
  },
  RelicConfig_44663_StoryDesc = {
    Text = "Todo deseo ha sido dejado atrás"
  },
  RelicConfig_44664_BattleDesc = {
    Text = "Al recoger, obtienes permanentemente [Arg1] <PowerIconKeywords:Fuerza>. Cada vez que causas daño, recuperas [Arg2] puntos de vida, hasta 6 veces por turno"
  },
  RelicConfig_44664_Desc = {
    Text = "Al recoger, obtienes permanentemente [Arg1] <PowerIconKeywords:Fuerza>. Cada vez que causas daño, recuperas [Arg2] puntos de vida, hasta 6 veces por turno"
  },
  RelicConfig_44664_Name = {
    Text = "<OrangeQuality:Bendición: Beso de la lamprea>"
  },
  RelicConfig_44664_StoryDesc = {
    Text = "Rechaza este beso de perdición, el abrazo del Padre es más cálido que cualquier oscuridad"
  },
  RelicConfig_47444_BattleDesc = {
    Text = "\"El golpe\" y \"DEF\" obtienen 50 puntos de energía de llave de plata adicional. Cada vez que juegues una carta con un costo de aritmética de 2 o más, roba una carta con un costo de aritmética de 1 y haz que su costo disminuya a 0, con un máximo de 3 veces por turno"
  },
  RelicConfig_47444_Desc = {
    Text = "\"El golpe\" y \"DEF\" obtienen 50 puntos de energía de llave de plata adicional. Cada vez que juegues una carta con un costo de aritmética de 2 o más, roba una carta con un costo de aritmética de 1 y haz que su costo disminuya a 0, con un máximo de 3 veces por turno"
  },
  RelicConfig_47444_Name = {
    Text = "<OrangeQuality: Péndulo crono\"Gemelo\">"
  },
  RelicConfig_50338_BattleDesc = {
    Text = "Al comenzar la batalla, todas las cartas de <ExaltIconKeywords:despertar> de los despertadores se mezclarán en la pila de cartas. Después del inicio del sexto turno, thais proporcionará apoyo en combate cada turno"
  },
  RelicConfig_50338_Desc = {
    Text = "Al comenzar la batalla, todas las cartas de <ExaltIconKeywords:despertar> de los despertadores se mezclarán en la pila de cartas. Después del inicio del sexto turno, thais proporcionará apoyo en combate cada turno"
  },
  RelicConfig_50338_Name = {
    Text = "<OrangeQuality: Péndulo crono\"Enamorados\">"
  },
  RelicConfig_50338_StoryDesc = {
    Text = "Él dijo, no temas"
  },
  RelicConfig_50385_BattleDesc = {
    Text = "Al recoger, elige una carta, su costo de aritmética se volverá permanente 1"
  },
  RelicConfig_50385_Desc = {
    Text = "Al recoger, elige una carta, su costo de aritmética se volverá permanente 1"
  },
  RelicConfig_50385_Name = {
    Text = "<WhiteQuality:☆pupilo marchito☆>"
  },
  RelicConfig_50385_StoryDesc = {
    Text = "Perdió el agua más preciosa del desierto, y sus ojos ya estaban marchitos."
  },
  RelicConfig_50487_BattleDesc = {
    Text = "Al inicio del primer turno de batalla, añade <DerivativeCardKeywords_46:\"Virus priónico\"> a tu mano; en el tercer turno, añade <DerivativeCardKeywords_49:\"ATQ glotón\"> a tu mano; después de activar la resistencia a la muerte, añade <DerivativeCardKeywords_52:\"Capullo de Renacimiento\"> a tu mano."
  },
  RelicConfig_50487_Desc = {
    Text = "Al inicio del primer turno de batalla, añade <DerivativeCardKeywords_46:\"Virus priónico\"> a tu mano; en el tercer turno, añade <DerivativeCardKeywords_49:\"ATQ glotón\"> a tu mano; después de activar la resistencia a la muerte, añade <DerivativeCardKeywords_52:\"Capullo de Renacimiento\"> a tu mano."
  },
  RelicConfig_50487_Name = {
    Text = "<OrangeQuality:péndulo crono\"la bendición\">"
  },
  RelicConfig_50488_BattleDesc = {
    Text = "Al final del turno: el despertado con menos locura gana 35 puntos de locura. Si la vida restante es ≥50%, gana [Arg1] puntos de <PowerIconKeywords:fuerza>. Si la vida restante es <50%, recupera [Arg2] puntos de vida"
  },
  RelicConfig_50488_Desc = {
    Text = "Al final del turno: el despertado con menos locura gana 35 puntos de locura. Si la vida actual no es inferior al 50%, gana [Arg1] puntos de <PowerIconKeywords:fuerza>. Si la vida actual es inferior al 50%, recupera [Arg2] puntos de vida"
  },
  RelicConfig_50488_Name = {
    Text = "<OrangeQuality: Péndulo crono\"Equilibrio\">"
  },
  RelicConfig_50489_BattleDesc = {
    Text = "Tasa crítica y daño crítico aumentan un 100%. Por cada daño causado, la tasa crítica y el daño crítico de todos los despertadores disminuyen un 10%, hasta un máximo del 50%. Por cada daño causado, el envenenamiento y el contraataque en este turno aumentan un 10%, hasta un máximo del 50%"
  },
  RelicConfig_50489_Desc = {
    Text = "Tasa crítica y daño crítico aumentan un 100%. Por cada daño causado / daño de tentáculo, en este turno: la tasa crítica y el daño crítico de todos los despertadores disminuyen un 10%, hasta un máximo del 50%. El envenenamiento y el contraataque aumentan un 10%, hasta un máximo del 50%"
  },
  RelicConfig_50489_Name = {
    Text = "<OrangeQuality:péndulo crono\"Desplazamiento»>"
  },
  RelicConfig_51686_BattleDesc = {
    Text = "Cada vez que juegues una carta de comando que pertenezca a un Despertado diferente al anterior, el Despertado correspondiente obtiene 3 puntos de alienación y acumula 1 nivel de \"Vitalidad\". Al acumular 10 niveles, se vacían todos los \"Vitalidad\" y se coloca en la mano de cada Despertado una carta de comando aleatoria con un coste de aritmética reducido en 1 y con \"Consumo\". Este efecto solo se activa una vez por turno."
  },
  RelicConfig_51686_Desc = {
    Text = "Cada vez que juegues una carta de comando que pertenezca a un Despertado diferente al anterior, el Despertado correspondiente obtiene 3 puntos de alienación y acumula 1 nivel de \"Vitalidad\". Al acumular 10 niveles, se eliminan todos los niveles de \"Vitalidad\" y se coloca en la mano una carta de comando aleatoria que reduce en 1 el coste de aritmética de cada Despertado y tiene \"Consumo\". Este efecto solo se activa una vez por turno."
  },
  RelicConfig_51686_Name = {
    Text = "<OrangeQuality:péndulo temporal\"Evolución\">"
  },
  RelicConfig_51687_BattleDesc = {
    Text = "Las cartas de comando que no son \"golpe\" o \"defensa\" otorgarán 15 puntos de alienación al Despertado correspondiente después de jugarse, siempre que no sean cartas derivadas, activándose hasta 5 veces por turno. La primera vez que se active por turno, la carta jugada será devuelta a la mano."
  },
  RelicConfig_51687_Desc = {
    Text = "Las Tarjetas de comando que no son \"golpear\" o \"Defensa\", si la carta no es una carta Derivada, otorgarán 15 puntos de Aliemus al Cuerpo Despertado correspondiente después de Jugar, activándose hasta 5 veces por turno. La primera vez que se active por turno, la carta jugada será devuelta a la mano."
  },
  RelicConfig_51687_Name = {
    Text = "<OrangeQuality: Péndulo crono\"Proyección\">"
  },
  RelicConfig_51688_BattleDesc = {
    Text = "Al recoger, se añade \"conservar\" a todas las cartas de comando. Al final del turno, si tienes 5 o más cartas en la mano, el costo de aritmética de 3 cartas se reduce en 1, de lo contrario, roba 3 cartas"
  },
  RelicConfig_51688_Desc = {
    Text = "Al recoger, se añade \"conservar\" a todas las cartas de comando. Al final del turno, si tienes 5 o más cartas en la mano, el costo de aritmética de 3 cartas se reduce en 1, de lo contrario, roba 3 cartas"
  },
  RelicConfig_51688_Name = {
    Text = "<OrangeQuality:péndulo crono\"Cuna»>"
  },
  RelicConfig_51689_BattleDesc = {
    Text = "Al comenzar la batalla, coloca 3 cartas de síntomas aleatorias en el mazo. Al comienzo del turno, roba 1 carta. Cada vez que juegues 1 carta de síntomas, obtienes 2 puntos de aritmética. Por cada carta de síntomas descartada, todos los Despertados obtienen 5 puntos de alienación, activándose hasta un máximo de 5 veces por turno."
  },
  RelicConfig_51689_Desc = {
    Text = "Al comenzar la batalla, coloca 3 cartas de síntomas aleatorias en el mazo. Al comenzar el turno, roba 1 carta. Por cada carta de síntomas jugada, obtén 2 puntos de aritmética. Por cada carta de síntomas descartada, todos los Despertados obtienen 5 puntos de alienación, activándose hasta un máximo de 5 veces por turno."
  },
  RelicConfig_51689_Name = {
    Text = "<OrangeQuality:péndulo crono\"Plaga»>"
  },
  RelicConfig_55847_BattleDesc = {
    Text = "Set estándar de simulación 7 piezas"
  },
  RelicConfig_55847_Desc = {
    Text = "Set estándar de simulación 7 piezas"
  },
  RelicConfig_55847_Name = {
    Text = "<RedQuality:☆Creación de batalla simulada☆>"
  },
  RelicConfig_55847_StoryDesc = {
    Text = "En la era extraña, las flores eran los primeros espectadores de la humanidad.\nNo te muevas, prefieren las exhibiciones tranquilas"
  },
  RelicConfig_55874_BattleDesc = {
    Text = "Al finalizar la batalla, obtienes [Arg1] capas de \"tinta\", que se consumen al alcanzar 2 capas, colocando aleatoriamente 1 carta de \"imagen\" en la baraja"
  },
  RelicConfig_55874_Desc = {
    Text = "Al finalizar la batalla, obtienes [Arg1] capas de \"tinta\", que se consumen al alcanzar 2 capas, colocando aleatoriamente 1 carta de \"imagen\" en la baraja"
  },
  RelicConfig_55874_Name = {
    Text = "<OrangeQuality: La pluma y la tinta de horla>"
  },
  RelicConfig_55874_StoryDesc = {
    Text = "Los pecados antiguos están grabados aquí"
  },
  RelicConfig_56355_BattleDesc = {
    Text = "Límite de cartas en mano +2, al inicio del turno, roba 1 carta. Al final de la batalla, obtén [Arg1] capas de \"Tinta\". Al alcanzar 2 capas, consume para añadir 1 carta de \"Imagen\" a la baraja"
  },
  RelicConfig_56355_Desc = {
    Text = "Límite de cartas en mano +2, al inicio del turno, roba 1 carta. Al final de la batalla, obtén [Arg1] capas de \"Tinta\". Al alcanzar 2 capas, consume para añadir 1 carta de \"Imagen\" a la baraja"
  },
  RelicConfig_56355_Name = {
    Text = "<OrangeQuality: La pluma y la tinta de horla>"
  },
  RelicConfig_56355_StoryDesc = {
    Text = "Los pecados antiguos están grabados aquí"
  },
  RelicConfig_56356_BattleDesc = {
    Text = "Al finalizar la batalla, obtienes [Arg1] capas de \"tinta\", que se consumen al alcanzar 2 capas, eligiendo colocar 1 carta de \"imagen\" en la baraja"
  },
  RelicConfig_56356_Desc = {
    Text = "Al finalizar la batalla, obtienes [Arg1] capas de \"tinta\", que se consumen al alcanzar 2 capas, eligiendo colocar 1 carta de \"imagen\" en la baraja"
  },
  RelicConfig_56356_Name = {
    Text = "<OrangeQuality: La pluma y la tinta de horla>"
  },
  RelicConfig_56356_StoryDesc = {
    Text = "Los pecados antiguos están grabados aquí"
  },
  RelicConfig_57667_BattleDesc = {
    Text = "Comienzas con 2 capas de Poder de la Madre. Después del tercer turno, al inicio de cada turno, puedes elegir consumir Poder de la Madre para obtener diferentes efectos o recuperar Poder de la Madre. Si recibes daño letal, renacerás y consumirás todas las capas de Poder de la Madre, recuperando 10% de vida por cada capa, solo puede activarse 1 vez."
  },
  RelicConfig_57667_Desc = {
    Text = "Comienzas con 2 capas de Poder de la Madre Divina. Después del tercer turno, al inicio de cada turno, puedes elegir consumir Poder de la Madre para obtener diferentes efectos o recuperar Poder de la Madre. Si recibes daño letal, renacerás y consumirás todas las capas de poder, recuperando un 10% de vida por cada capa, solo puede activarse 1 vez."
  },
  RelicConfig_57667_Name = {
    Text = "<OrangeQuality:Protección de la Madre Divina>"
  },
  RelicConfig_57732_BattleDesc = {
    Text = "La tasa crítica de todos los despertadores aumenta un 15%. El resultado final de los efectos aleatorios de Ryker y los dados aumenta en 1"
  },
  RelicConfig_57732_Desc = {
    Text = "La tasa crítica de todos los despertadores aumenta un 15%. El resultado final de los efectos aleatorios de Ryker y los dados aumenta en 1"
  },
  RelicConfig_57732_Name = {
    Text = "<OrangeQuality:Gabardina de Suerte>"
  },
  RelicConfig_57732_StoryDesc = {
    Text = "Los pecados antiguos están grabados aquí"
  },
  RelicConfig_57733_BattleDesc = {
    Text = "Al comienzo del turno y al activar un efecto aleatorio de ryker o un dado, ganas 100 puntos de energía-s y 4% de daño crítico, con un máximo de 50% de daño crítico, se elimina al finalizar la batalla"
  },
  RelicConfig_57733_Desc = {
    Text = "Al comienzo del turno y al activar un efecto aleatorio de ryker o un dado, ganas 100 puntos de energía-s y 4% de daño crítico, con un máximo de 50% de daño crítico, se elimina al finalizar la batalla"
  },
  RelicConfig_57733_Name = {
    Text = "<OrangeQuality:Botón de Boca Fino>"
  },
  RelicConfig_57733_StoryDesc = {
    Text = "Los pecados antiguos están grabados aquí"
  },
  RelicConfig_57734_BattleDesc = {
    Text = "Cada vez que liberes una llave, coloca una carta \"Dado de Remedio Brillante\" en tu mano"
  },
  RelicConfig_57734_Desc = {
    Text = "Cada vez que liberes una llave, coloca una carta \"Dado de Remedio Brillante\" en tu mano"
  },
  RelicConfig_57734_Name = {
    Text = "<OrangeQuality:Dado Brillante>"
  },
  RelicConfig_57734_StoryDesc = {
    Text = "Los pecados antiguos están grabados aquí"
  },
  RelicConfig_57735_BattleDesc = {
    Text = "Al comienzo del turno y al activar un efecto aleatorio de ryker o un dado, ganas 50 puntos de energía-s y 2% de daño crítico, con un máximo de 30% de daño crítico, se elimina al finalizar la batalla"
  },
  RelicConfig_57735_Desc = {
    Text = "Al comienzo del turno y al activar un efecto aleatorio de ryker o un dado, ganas 50 puntos de energía-s y 2% de daño crítico, con un máximo de 30% de daño crítico, se elimina al finalizar la batalla"
  },
  RelicConfig_57735_Name = {
    Text = "<OrangeQuality:Botón de boca grande>"
  },
  RelicConfig_57735_StoryDesc = {
    Text = "Los pecados antiguos están grabados aquí"
  },
  RelicConfig_57736_BattleDesc = {
    Text = "Cada vez que liberes una llave, coloca una carta \"Dado de Remedio\" en tu mano"
  },
  RelicConfig_57736_Desc = {
    Text = "Cada vez que liberes una llave, coloca una carta \"Dado de Remedio\" en tu mano"
  },
  RelicConfig_57736_Name = {
    Text = "<OrangeQuality:Dado de remedio>"
  },
  RelicConfig_57736_StoryDesc = {
    Text = "Los pecados antiguos están grabados aquí"
  },
  RelicConfig_57737_BattleDesc = {
    Text = "La tasa crítica de todos los despertadores aumenta un 10%. Todos los efectos aleatorios de Ryker y los dados no llegan al valor mínimo"
  },
  RelicConfig_57737_Desc = {
    Text = "La tasa crítica de todos los despertadores aumenta un 10%. Todos los efectos aleatorios de Ryker y los dados no llegan al valor mínimo"
  },
  RelicConfig_57737_Name = {
    Text = "<OrangeQuality:Gabardina de la suerte>"
  },
  RelicConfig_57737_StoryDesc = {
    Text = "Los pecados antiguos están grabados aquí"
  },
  RelicConfig_57791_BattleDesc = {
    Text = "Límite de creación +1. En los primeros cinco turnos después del inicio de la batalla, al comienzo de cada turno se obtendrá un objeto, que incluye \"broche de rubí, ágata en espiral, señal de socorro, ave del ritual de infortunio, péndulo crono·fascinación\""
  },
  RelicConfig_57791_Desc = {
    Text = "Límite de creación +1. En los primeros cinco turnos después del inicio de la batalla, al comienzo de cada turno se obtendrá un objeto, que incluye \"broche de rubí, ágata en espiral, señal de socorro, ave del ritual de infortunio, péndulo crono·fascinación\""
  },
  RelicConfig_57791_Name = {
    Text = "<OrangeQuality:péndulo crono\"Tesoro hundido\">"
  },
  RelicConfig_57791_StoryDesc = {
    Text = "Se dice que Lemuria cayó en estas aguas. ¿Quién puede resistir la tentación de explorar los secretos de los tesoros de naufragios?"
  },
  RelicConfig_57792_BattleDesc = {
    Text = "Límite de creación +1. En los primeros cinco turnos después del inicio de la batalla, al comienzo de cada turno se obtendrá un objeto, que incluye \"tridente, carpeta de sellos de otro país, registro de arkanas, grabado de conciencia, péndulo crono·ahorro\""
  },
  RelicConfig_57792_Desc = {
    Text = "Límite de creación +1. En los primeros cinco turnos después del inicio de la batalla, al comienzo de cada turno se obtendrá un objeto, que incluye \"tridente, carpeta de sellos de otro país, registro de arkanas, grabado de conciencia, péndulo crono·ahorro\""
  },
  RelicConfig_57792_Name = {
    Text = "<OrangeQuality:péndulo crono\"Tesoro hundido\">"
  },
  RelicConfig_57792_StoryDesc = {
    Text = "Se dice que Lemuria cayó en estas aguas. ¿Quién puede resistir la tentación de explorar los secretos de los tesoros de naufragios?"
  },
  RelicConfig_57793_BattleDesc = {
    Text = "Límite de creación +1. En los primeros cinco turnos después del inicio de la batalla, al comienzo de cada turno se obtendrá un objeto, que incluye \"mandíbula láser, ungüento sospechoso, máquina de coser cubierta de polvo, lengua de especie diferente, péndulo crono·ola\""
  },
  RelicConfig_57793_Desc = {
    Text = "Límite de creación +1. En los primeros cinco turnos después del inicio de la batalla, al comienzo de cada turno se obtendrá un objeto, que incluye \"mandíbula láser, ungüento sospechoso, máquina de coser cubierta de polvo, lengua de especie diferente, péndulo crono·ola\""
  },
  RelicConfig_57793_Name = {
    Text = "<OrangeQuality:péndulo crono\"Tesoro hundido\">"
  },
  RelicConfig_57793_StoryDesc = {
    Text = "Se dice que Lemuria cayó en esta área del mar. ¿Quién puede resistir la tentación de explorar los secretos de los tesoros de naufragios?"
  },
  RelicConfig_57794_BattleDesc = {
    Text = "Límite de reliquias +1. En los primeros cinco turnos después del inicio de la batalla, se ganará una reliquia al comienzo de cada turno, que incluye \"Chaleco de ortiga espinosa, Reloj de bolsillo de lo que fue, Fragmento de los ancianos, Extremidad del alivio, Péndulo crono·extensión\""
  },
  RelicConfig_57794_Desc = {
    Text = "Límite de reliquias +1. En los primeros cinco turnos después del inicio de la batalla, se ganará una reliquia al comienzo de cada turno, que incluye \"Chaleco de ortiga espinosa, Reloj de bolsillo de lo que fue, Fragmento de los ancianos, Extremidad del alivio, Péndulo crono·extensión\""
  },
  RelicConfig_57794_Name = {
    Text = "<OrangeQuality:péndulo crono\"Tesoro hundido\">"
  },
  RelicConfig_57794_StoryDesc = {
    Text = "Se dice que Lemuria cayó en esta área marina. ¿Quién puede resistir la tentación de explorar los secretos de los tesoros de naufragios?"
  },
  RelicConfig_57795_BattleDesc = {
    Text = "Límite de creación +1. En los primeros cinco turnos después del inicio de la batalla, al comienzo de cada turno se obtendrá un objeto, que incluye \"cuchillo de hoja de sauce oxidado, pinzas hemostáticas, rompecabezas viejo, conciencia de plaga, péndulo crono·gemelos\""
  },
  RelicConfig_57795_Desc = {
    Text = "Límite de creación +1. En los primeros cinco turnos después del inicio de la batalla, al comienzo de cada turno se obtendrá un objeto, que incluye \"cuchillo de hoja de sauce oxidado, pinzas hemostáticas, rompecabezas viejo, conciencia de plaga, péndulo crono·gemelos\""
  },
  RelicConfig_57795_Name = {
    Text = "<OrangeQuality:péndulo crono\"Tesoro hundido\">"
  },
  RelicConfig_57795_StoryDesc = {
    Text = "Se dice que Lemuria cayó en estas aguas. ¿Quién puede resistir la tentación de explorar los secretos de los tesoros de naufragios?"
  },
  RelicConfig_57796_BattleDesc = {
    Text = "Límite de creación +1. En los primeros cinco turnos después del inicio de la batalla, al comienzo de cada turno se obtendrá un objeto, que incluye \"cronómetro preciso, gemelos de laurel, velo del dios sin nombre, manifestación del pesadumbre, péndulo crono·equilibrio\""
  },
  RelicConfig_57796_Desc = {
    Text = "Límite de creación +1. En los primeros cinco turnos después del inicio de la batalla, al comienzo de cada turno se obtendrá un objeto, que incluye \"cronómetro preciso, gemelos de laurel, velo del dios sin nombre, manifestación del pesadumbre, péndulo crono·equilibrio\""
  },
  RelicConfig_57796_Name = {
    Text = "<OrangeQuality:péndulo crono\"Tesoro hundido\">"
  },
  RelicConfig_57796_StoryDesc = {
    Text = "Se dice que Lemuria cayó en esta área marina. ¿Quién puede resistir la tentación de explorar los secretos de los tesoros de naufragios?"
  },
  RelicConfig_57797_BattleDesc = {
    Text = "Límite de creación +1. En los primeros cinco turnos después del inicio de la batalla, al comienzo de cada turno se obtendrá un objeto, que incluye \"un monedero nuevo, emblema de mitag, vino de las estrellas, beso de la lamprea, péndulo crono·ojo\""
  },
  RelicConfig_57797_Desc = {
    Text = "Límite de creación +1. En los primeros cinco turnos después del inicio de la batalla, al comienzo de cada turno se obtendrá un objeto, que incluye \"un monedero nuevo, emblema de mitag, vino de las estrellas, beso de la lamprea, péndulo crono·ojo\""
  },
  RelicConfig_57797_Name = {
    Text = "<OrangeQuality:péndulo crono\"Tesoro hundido\">"
  },
  RelicConfig_57797_StoryDesc = {
    Text = "Se dice que Lemuria cayó en estas aguas. ¿Quién puede resistir la tentación de explorar los secretos de los tesoros de naufragios?"
  },
  RelicConfig_58872_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. En los siguientes 5 turnos, al inicio de cada turno recibirás una reliquia, incluyendo \"hoja de sauce oxidada, rueda moderna, nuestro hogar, garra extraña, péndulo crono·fascinación\""
  },
  RelicConfig_58872_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. En los siguientes 5 turnos, al inicio de cada turno recibirás una reliquia, incluyendo \"hoja de sauce oxidada, rueda moderna, nuestro hogar, garra extraña, péndulo crono·fascinación\""
  },
  RelicConfig_58872_Name = {
    Text = "<OrangeQuality:péndulo crono\"Tesoro α\">"
  },
  RelicConfig_58873_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. En los siguientes 5 turnos, al inicio de cada turno recibirás una reliquia, incluyendo \"tinta dulce, gramófono mudo, vino de estrellas, sombrero mágico, péndulo crono·fluctuación\""
  },
  RelicConfig_58873_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. En los siguientes 5 turnos, al inicio de cada turno recibirás una reliquia, incluyendo \"tinta dulce, gramófono mudo, vino de estrellas, sombrero mágico, péndulo crono·fluctuación\""
  },
  RelicConfig_58873_Name = {
    Text = "<OrangeQuality:péndulo crono\"Tesoro β\">"
  },
  RelicConfig_59118_BattleDesc = {
    Text = "Al comienzo del turno, recibe 1 carta \"Dado de la suerte de ryker\", el número tirado en el dado aumenta en 1. Al comienzo del turno y cada vez que tires el dado, todos los despertadores ganan 4% de daño crítico, con un máximo de 100%"
  },
  RelicConfig_59118_Desc = {
    Text = "Al comienzo del turno, recibe 1 carta \"Dado de la suerte de ryker\", el número tirado en el dado aumenta en 1. Al comienzo del turno y cada vez que tires el dado, todos los despertadores ganan 4% de daño crítico, con un máximo de 100%"
  },
  RelicConfig_59118_Name = {
    Text = "<OrangeQuality:péndulo crono\"Regalo del caos\">"
  },
  RelicConfig_59118_StoryDesc = {
    Text = "Los pecados antiguos están grabados aquí"
  },
  RelicConfig_59687_BattleDesc = {
    Text = "Set estándar de simulación 7 piezas"
  },
  RelicConfig_59687_Desc = {
    Text = "Set estándar de simulación 7 piezas"
  },
  RelicConfig_59687_Name = {
    Text = "<RedQuality:☆Creación de batalla simulada☆>"
  },
  RelicConfig_59687_StoryDesc = {
    Text = "En la era extraña, las flores eran los primeros espectadores de la humanidad.\nNo te muevas, prefieren las exhibiciones tranquilas"
  },
  RelicConfig_60723_BattleDesc = {
    Text = "Aumenta el límite de aritmética en 1, al comienzo del turno roba 1 carta adicional, recibirás 1 carta de \"Sinfonía de armonía\".Si juegas 3 cartas de comando con un consumo de aritmética igual consecutivamente, todos los Despertados obtendrán 20 puntos de alienación, y se restablecerá el conteo al comienzo del turno y después de activarse."
  },
  RelicConfig_60723_Desc = {
    Text = "Aumenta el límite de aritmética en 1, al comenzar el turno, roba 1 carta adicional y obtendrás 1 carta de \"Sinfonía de armonía\". Si juegas 3 cartas de comando con el mismo costo de aritmética, todos los despertadores obtienen 20 puntos de alienación, y se reinician las activaciones al comienzo del turno y después de activarse."
  },
  RelicConfig_60723_Name = {
    Text = "<OrangeQuality:Batuta de la orquesta>"
  },
  RelicConfig_60723_StoryDesc = {
    Text = [[
Una delgada batuta de conductor, pero posee una fuerza mayor que una palanca.

 Conduciendo notas, conduciendo alma, conduciendo destino.]]
  },
  RelicConfig_60724_BattleDesc = {
    Text = "Al comienzo de la batalla, se obtienen los sellos \"vulnerabilidad\" y \"explosión\" y sus sellos avanzados, selecciona los sellos en las cartas"
  },
  RelicConfig_60724_Desc = {
    Text = "Al comienzo de la batalla, se obtienen los sellos \"vulnerabilidad\" y \"explosión\" y sus sellos avanzados, selecciona los sellos en las cartas"
  },
  RelicConfig_60724_Name = {
    Text = "<OrangeQuality:péndulo crono\"Mensaje del director\">"
  },
  RelicConfig_60724_StoryDesc = {
    Text = "Las palabras del fundador de Mythag resuenan en tus oídos.\n\nQue la llave plateada ilumine tu camino, guardián de Mythag."
  },
  RelicConfig_60725_BattleDesc = {
    Text = "Al comienzo de la batalla, se obtienen los sellos \"locura\" y \"catalizador\" y sus sellos avanzados, selecciona los sellos en las cartas"
  },
  RelicConfig_60725_Desc = {
    Text = "Al comienzo de la batalla, se obtienen los sellos \"locura\" y \"catalizador\" y sus sellos avanzados, selecciona los sellos en las cartas"
  },
  RelicConfig_60725_Name = {
    Text = "<OrangeQuality:péndulo crono\"Mensaje del director\">"
  },
  RelicConfig_60725_StoryDesc = {
    Text = "Las palabras del fundador de Mythag resuenan en tus oídos.\n\nQue la llave plateada ilumine tu camino, guardián de Mythag."
  },
  RelicConfig_60726_BattleDesc = {
    Text = "Al comenzar la batalla, recibirás el sello de \"debilidad\" y el sello de \"cálculo\" junto con su sello avanzado, elige los sellos para las cartas"
  },
  RelicConfig_60726_Desc = {
    Text = "Al comenzar la batalla, recibirás el sello de \"debilidad\" y el sello de \"cálculo\" junto con su sello avanzado, elige los sellos para las cartas"
  },
  RelicConfig_60726_Name = {
    Text = "<OrangeQuality:péndulo crono\"Mensaje del director\">"
  },
  RelicConfig_60726_StoryDesc = {
    Text = "Las palabras del fundador de Mythag resuenan en tus oídos.\n\nQue la llave plateada ilumine tu camino, guardián de Mythag."
  },
  RelicConfig_60727_BattleDesc = {
    Text = "Al comenzar la batalla, recibirás el sello de \"muralla de hierro\" y el sello de \"habilidad\" junto con su sello avanzado, elige los sellos para las cartas"
  },
  RelicConfig_60727_Desc = {
    Text = "Al comenzar la batalla, recibirás el sello de \"muralla de hierro\" y el sello de \"habilidad\" junto con su sello avanzado, elige los sellos para las cartas"
  },
  RelicConfig_60727_Name = {
    Text = "<OrangeQuality:péndulo crono\"Mensaje del director\">"
  },
  RelicConfig_60727_StoryDesc = {
    Text = "Las palabras del fundador de Mythag resuenan en tus oídos.\n\nQue la llave plateada ilumine tu camino, guardián de Mythag."
  },
  RelicConfig_60728_BattleDesc = {
    Text = "Al comienzo de la batalla, se obtienen los sellos \"gestación\" y \"eco\" y sus sellos avanzados, selecciona los sellos en las cartas"
  },
  RelicConfig_60728_Desc = {
    Text = "Al comienzo de la batalla, se obtienen los sellos \"gestación\" y \"eco\" y sus sellos avanzados, selecciona los sellos en las cartas"
  },
  RelicConfig_60728_Name = {
    Text = "<OrangeQuality:péndulo crono\"Mensaje del director\">"
  },
  RelicConfig_60728_StoryDesc = {
    Text = "Las palabras del fundador de Mythag resuenan en tus oídos.\n\nQue la llave plateada ilumine tu camino, guardián de Mythag."
  },
  RelicConfig_60729_BattleDesc = {
    Text = "Al comienzo de la batalla, se obtienen los sellos \"destreza\" e \"inspiración\" y sus sellos avanzados, selecciona los sellos en las cartas"
  },
  RelicConfig_60729_Desc = {
    Text = "Al comienzo de la batalla, se obtienen los sellos \"destreza\" e \"inspiración\" y sus sellos avanzados, selecciona los sellos en las cartas"
  },
  RelicConfig_60729_Name = {
    Text = "<OrangeQuality:péndulo crono\"Mensaje del director\">"
  },
  RelicConfig_60729_StoryDesc = {
    Text = "Las palabras del fundador de Mythag resuenan en tus oídos.\n\nQue la llave plateada ilumine tu camino, guardián de Mythag."
  },
  RelicConfig_60730_BattleDesc = {
    Text = "Al comenzar la batalla, recibirás el sello de \"brutalidad\" y el sello de \"agotamiento\" junto con su sello avanzado, elige los sellos para las cartas"
  },
  RelicConfig_60730_Desc = {
    Text = "Al comenzar la batalla, recibirás el sello de \"brutalidad\" y el sello de \"agotamiento\" junto con su sello avanzado, elige los sellos para las cartas"
  },
  RelicConfig_60730_Name = {
    Text = "<OrangeQuality:péndulo crono\"Mensaje del director\">"
  },
  RelicConfig_60730_StoryDesc = {
    Text = "Las palabras del fundador de Mythag resuenan en tus oídos.\n\nQue la llave plateada ilumine tu camino, guardián de Mythag."
  },
  RelicConfig_60731_BattleDesc = {
    Text = "Al comienzo de la batalla, se obtienen 2 sellos de \"conjunto\" y sus sellos avanzados, selecciona los sellos en las cartas"
  },
  RelicConfig_60731_Desc = {
    Text = "Al comienzo de la batalla, se obtienen 2 sellos de \"conjunto\" y sus sellos avanzados, selecciona los sellos en las cartas"
  },
  RelicConfig_60731_Name = {
    Text = "<OrangeQuality:péndulo crono\"Mensaje del director\">"
  },
  RelicConfig_60731_StoryDesc = {
    Text = "Las palabras del fundador de Mythag resuenan en tus oídos.\n\nQue la llave plateada ilumine tu camino, guardián de Mythag."
  },
  RelicConfig_60732_BattleDesc = {
    Text = "Al comienzo de la batalla, se obtienen los sellos \"planificación\" y \"espejo\" y sus sellos avanzados, selecciona los sellos en las cartas"
  },
  RelicConfig_60732_Desc = {
    Text = "Al comienzo de la batalla, se obtienen los sellos \"planificación\" y \"espejo\" y sus sellos avanzados, selecciona los sellos en las cartas"
  },
  RelicConfig_60732_Name = {
    Text = "<OrangeQuality:péndulo crono\"Mensaje del director\">"
  },
  RelicConfig_60732_StoryDesc = {
    Text = "Las palabras del fundador de Mythag resuenan en tus oídos.\n\nQue la llave plateada ilumine tu camino, guardián de Mythag."
  },
  RelicConfig_65376_BattleDesc = {
    Text = "Inicialmente, hay [Arg1] miembros del equipo de investigación. Al comenzar la batalla, coloca 5 cartas de <DerivativeCardKeywords_73:desconfianza> en la biblioteca"
  },
  RelicConfig_65376_Desc = {
    Text = "Inicialmente, hay [Arg1] miembros del Equipo de Investigación. Al comenzar la batalla, coloca 5 cartas de <DerivativeCardKeywords_73:Sospecha> en la biblioteca."
  },
  RelicConfig_65376_Name = {
    Text = "<OrangeQuality:Expedición Científica>"
  },
  RelicConfig_65376_StoryDesc = {
    Text = "Las palabras del fundador de Mythag resuenan en tus oídos.\n\nQue la llave plateada ilumine tu camino, guardián de Mythag."
  },
  RelicConfig_65406_BattleDesc = {
    Text = "Al inicio del turno, obtiene [Arg1] <DerivativeCardKeywords_71:\"Luz Humana Brillante\">.\n<D05EX_Relic:Todo tu esfuerzo valió la pena, casi salvaste al equipo de investigación. Los sobrevivientes te agradecen sinceramente.>"
  },
  RelicConfig_65406_Desc = {
    Text = "Al inicio del turno, obtiene [Arg1] <DerivativeCardKeywords_71:\"Luz Humana Brillante\">.\n<D05EX_Relic:Todo tu esfuerzo valió la pena, casi salvaste al equipo de investigación. Los sobrevivientes te agradecen sinceramente.>"
  },
  RelicConfig_65406_Name = {
    Text = "<OrangeQuality:Medalla de rescate: Platino>"
  },
  RelicConfig_65406_StoryDesc = {
    Text = "Todo tu esfuerzo ha valido la pena, casi salvaste al equipo de investigación, los sobrevivientes te agradecen sinceramente"
  },
  RelicConfig_65407_BattleDesc = {
    Text = "Al inicio del turno, obtiene [Arg1] <DerivativeCardKeywords_72:\"Luz Humana Resplandeciente\">.\n<D05EX_Relic:Creaste un milagro increíble, todos sobrevivieron al desastre. Eres un gran héroe en los corazones de la gente, y tu leyenda puede difundirse alrededor de la montaña nevada.>"
  },
  RelicConfig_65407_Desc = {
    Text = "Al inicio del turno, obtiene [Arg1] <DerivativeCardKeywords_72:\"Luz Humana Resplandeciente\">.\n<D05EX_Relic:Creaste un milagro increíble, todos sobrevivieron al desastre. Eres un gran héroe en los corazones de la gente, y tu leyenda puede difundirse alrededor de la montaña nevada.>"
  },
  RelicConfig_65407_Name = {
    Text = "<OrangeQuality:Medalla de rescate: Diamante>"
  },
  RelicConfig_65407_StoryDesc = {
    Text = "Has creado un milagro increíble, todos sobrevivieron después de la catástrofe, eres el gran héroe en el corazón de la gente, y tu leyenda tal vez comenzará a difundirse alrededor de la montaña nevada."
  },
  RelicConfig_65408_BattleDesc = {
    Text = "Al inicio del turno, obtiene [Arg1] <DerivativeCardKeywords_68:\"Luz Humana Desvanecida\">.\n<D05EX_Relic:Para salir de la montaña nevada, elegiste una estrategia de eficiencia y observaste cómo la gente moría uno a uno. Los sobrevivientes te miran con más miedo que gratitud.>"
  },
  RelicConfig_65408_Desc = {
    Text = "Al inicio del turno, obtiene [Arg1] <DerivativeCardKeywords_68:\"Luz Humana Desvanecida\">.\n<D05EX_Relic:Para salir de la montaña nevada, elegiste una estrategia de eficiencia y observaste cómo la gente moría uno a uno. Los sobrevivientes te miran con más miedo que gratitud.>"
  },
  RelicConfig_65408_Name = {
    Text = "<OrangeQuality:Medalla de Rescate·Bronce>"
  },
  RelicConfig_65408_StoryDesc = {
    Text = "Para salir de la montaña nevada, elegiste una estrategia de eficiencia y observaste cómo la gente moría uno por uno. Los sobrevivientes te miran con más miedo que gratitud"
  },
  RelicConfig_65409_BattleDesc = {
    Text = "Al inicio del turno, obtiene [Arg1] <DerivativeCardKeywords_69:\"Luz Humana Débil\">.\n<D05EX_Relic:Quizás lo intentaste, aunque la mitad de la gente murió, al menos salvaste a la otra mitad. Después de todo, los sacrificios son inevitables.>"
  },
  RelicConfig_65409_Desc = {
    Text = "Al inicio del turno, obtiene [Arg1] <DerivativeCardKeywords_69:\"Luz Humana Débil\">.\n<D05EX_Relic:Quizás lo intentaste, aunque la mitad de la gente murió, al menos salvaste a la otra mitad. Después de todo, los sacrificios son inevitables.>"
  },
  RelicConfig_65409_Name = {
    Text = "<OrangeQuality:Medalla de rescate: Plata>"
  },
  RelicConfig_65409_StoryDesc = {
    Text = "Quizás lo intentaste, aunque la mitad murió, al menos salvaste a la otra mitad. Después de todo, los sacrificios son inevitables"
  },
  RelicConfig_65410_BattleDesc = {
    Text = "Al inicio del turno, obtiene [Arg1] <DerivativeCardKeywords_70:\"Luz Humana\">.\n<D05EX_Relic:Salvaste a la mayoría de la gente, cambiando su destino trágico. Hiciste lo mejor que pudiste, ¿no es así?>"
  },
  RelicConfig_65410_Desc = {
    Text = "Al inicio del turno, obtiene [Arg1] <DerivativeCardKeywords_70:\"Luz Humana\">.\n<D05EX_Relic:Salvaste a la mayoría de la gente, cambiando su destino trágico. Hiciste lo mejor que pudiste, ¿no es así?>"
  },
  RelicConfig_65410_Name = {
    Text = "<OrangeQuality:Medalla de Rescate·Oro>"
  },
  RelicConfig_65410_StoryDesc = {
    Text = "Salvaste a la mayoría, cambiando sus destinos trágicos, ¿no es suficiente?"
  },
  RelicConfig_65456_BattleDesc = {
    Text = "Al comienzo de la batalla, se barajan 3 cartas de \"síntoma\" aleatorias, y al jugar un \"síntoma\" se obtienen [Arg1] puntos de poder.\n<D05EX_Relic:Con tu ayuda, la expedición no dejó sobrevivientes; fríamente lograste tu mayor beneficio, pero ¿vale realmente la pena?>"
  },
  RelicConfig_65456_Desc = {
    Text = "Al comienzo de la batalla, se barajan 3 cartas de \"síntoma\" aleatorias, y al jugar un \"síntoma\" se obtienen [Arg1] puntos de poder.\n<D05EX_Relic:Con tu ayuda, la expedición no dejó sobrevivientes; fríamente lograste tu mayor beneficio, pero ¿vale realmente la pena?>"
  },
  RelicConfig_65456_Name = {
    Text = "<OrangeQuality:Insignia del Solitario>"
  },
  RelicConfig_65456_StoryDesc = {
    Text = "Con tu ayuda, nadie del equipo de investigación sobrevivió, obtuviste el mayor beneficio para ti, pero ¿realmente valió la pena?"
  },
  RelicConfig_65569_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los Despertados. En los siguientes 5 turnos, al inicio de cada turno recibirás una reliquia, incluyendo \"Equipo de comunicación, Consagración de la primavera, Bastón del Hierofante, Pájaro ritual de presagio, Péndulo temporal·Proyección\"."
  },
  RelicConfig_65569_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los Despertados. En los siguientes 5 turnos, al inicio de cada turno recibirás una reliquia, incluyendo \"equipo de comunicación, consagración de la primavera, bastón del hierofante, pájaro ritual de presagio, péndulo temporal·proyección\"."
  },
  RelicConfig_65569_Name = {
    Text = "<OrangeQuality:péndulo crono\"Tesoro δ\">"
  },
  RelicConfig_65570_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. En los siguientes 5 turnos, al inicio de cada turno recibirás una reliquia, incluyendo \"emblema de mitag, maletín del doctor, batería prototipo, inscripción de conciencia, péndulo crono·variación\""
  },
  RelicConfig_65570_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. En los siguientes 5 turnos, al inicio de cada turno recibirás una reliquia, incluyendo \"emblema de mitag, maletín del doctor, batería prototipo, inscripción de conciencia, péndulo crono·variación\""
  },
  RelicConfig_65570_Name = {
    Text = "<OrangeQuality:péndulo temporal\"Tesoro γ\">"
  },
  RelicConfig_66515_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. En los siguientes 5 turnos, al inicio de cada turno recibirás una reliquia, incluyendo \"Periódico de Putney, principios estéticos, canción de plebeyos, rostro imperfecto, péndulo crono·interacción\""
  },
  RelicConfig_66515_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. En los siguientes 5 turnos, al inicio de cada turno recibirás una reliquia, incluyendo \"Periódico de Putney, principios estéticos, canción de plebeyos, rostro imperfecto, péndulo crono·interacción\""
  },
  RelicConfig_66515_Name = {
    Text = "<OrangeQuality:péndulo crono\"Tesoro ε\">"
  },
  RelicConfig_66518_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de turnos impares, descubre una reliquia, por un total de cinco veces"
  },
  RelicConfig_66518_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de turnos impares, descubre una reliquia, por un total de cinco veces"
  },
  RelicConfig_66518_Name = {
    Text = "<OrangeQuality:péndulo crono\"Deseo β\">"
  },
  RelicConfig_66519_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de turnos impares, descubre una reliquia, por un total de cinco veces"
  },
  RelicConfig_66519_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de turnos impares, descubre una reliquia, por un total de cinco veces"
  },
  RelicConfig_66519_Name = {
    Text = "<OrangeQuality:péndulo crono\"Deseo α\">"
  },
  RelicConfig_67690_BattleDesc = {
    Text = "Al inicio de cada turno, todos los despertadores obtienen 25 puntos de aliemus. Al recolectar, la salud máxima se convierte en 1.5 veces"
  },
  RelicConfig_67690_Desc = {
    Text = "Al inicio de cada turno, todos los despertadores obtienen 25 puntos de aliemus. Al recolectar, la salud máxima se convierte en 1.5 veces"
  },
  RelicConfig_67690_Name = {
    Text = "<OrangeQuality: Bendición·Representación de Pesadilla β>"
  },
  RelicConfig_67690_StoryDesc = {
    Text = "No temas, no dudes. Esto es solo un sueño fugaz, la luz del Padre aún brilla sobre ti"
  },
  RelicConfig_67788_BattleDesc = {
    Text = "Al recoger, obtienes 3 puntos de aritmética"
  },
  RelicConfig_67788_Desc = {
    Text = "Al recoger, obtienes 3 puntos de aritmética"
  },
  RelicConfig_67788_Name = {
    Text = "<WhiteQuality: espejo del reloj de bolsillo>"
  },
  RelicConfig_67788_StoryDesc = {
    Text = "La memoria se congela en el tiempo pasado, enterrada en el fondo negro"
  },
  RelicConfig_67789_BattleDesc = {
    Text = "Al recoger, coloca 1 carta <DerivativeCardKeywords_1:\"eco de sombra\"> en la mano"
  },
  RelicConfig_67789_Desc = {
    Text = "Al recoger, coloca 1 carta <DerivativeCardKeywords_1:\"eco de sombra\"> en la mano"
  },
  RelicConfig_67789_Name = {
    Text = "<WhiteQuality:Equipo de comunicación>"
  },
  RelicConfig_67789_StoryDesc = {
    Text = "Esperando o temiendo el momento en que suene la campana"
  },
  RelicConfig_67790_BattleDesc = {
    Text = "Todos los daños críticos causados por los \"golpes\" aumentan en un 20%. Al recoger, añade una carta <DerivativeCardKeywords_40: \"Momento Hermoso\"> a tu mano"
  },
  RelicConfig_67790_Desc = {
    Text = "Todos los daños críticos causados por los \"golpes\" aumentan en un 20%. Al recoger, añade una carta <DerivativeCardKeywords_40: \"Momento Hermoso\"> a tu mano"
  },
  RelicConfig_67790_Name = {
    Text = "<WhiteQuality:Momento hermoso>"
  },
  RelicConfig_67790_StoryDesc = {
    Text = "Preserva la belleza efímera para siempre"
  },
  RelicConfig_67791_BattleDesc = {
    Text = "Al recoger, aplicas 1 turno de <WeaknessIconKeywords:debilidad> y <VulnerabilityIconKeywords:vulnerable> a todos los enemigos"
  },
  RelicConfig_67791_Desc = {
    Text = "Al recoger, aplicas 1 turno de <WeaknessIconKeywords:debilidad> y <VulnerabilityIconKeywords:vulnerable> a todos los enemigos"
  },
  RelicConfig_67791_Name = {
    Text = "<WhiteQuality:Camisa de fuerza>"
  },
  RelicConfig_67791_StoryDesc = {
    Text = "No solo el tiempo puede decolorar la tela, también el miedo y el dolor"
  },
  RelicConfig_67793_BattleDesc = {
    Text = "Al comenzar la batalla, todos los despertadores reciben 50 puntos de locura. Coloca 2 cartas <DerivativeCardKeywords_1:\"eco de sombra\"> en tu mano"
  },
  RelicConfig_67793_Desc = {
    Text = "Al recoger, todos los despertadores obtienen 50 puntos de aliemus y se colocan 2 cartas <DerivativeCardKeywords_1:\"eco de sombra\"> en la mano"
  },
  RelicConfig_67793_Name = {
    Text = "<OrangeQuality:dispositivo de comunicación +β>"
  },
  RelicConfig_67793_StoryDesc = {
    Text = "Esperando o temiendo el momento en que suene la campana"
  },
  RelicConfig_67794_BattleDesc = {
    Text = "Límite de cartas en mano aumentado en 5, al iniciar la batalla llena la mano hasta el límite. Al comienzo del turno, roba 1 carta adicional, al final del turno descarta todas las cartas de síntoma y de estado en mano, conserva otras cartas"
  },
  RelicConfig_67794_Desc = {
    Text = "Límite de cartas en mano aumentado en 5, al iniciar la batalla llena la mano hasta el límite. Al comienzo del turno, roba 1 carta adicional, al final del turno descarta todas las cartas de síntoma y de estado en mano, conserva otras cartas"
  },
  RelicConfig_67794_Name = {
    Text = "<OrangeQuality: Bendición·Inscripción de Conciencia β>"
  },
  RelicConfig_67794_StoryDesc = {
    Text = "El avaro graba sus errores en su corazón y se dedica a redimir su pasado"
  },
  RelicConfig_67818_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67818_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67818_Name = {
    Text = "<OrangeQuality:\"Puerta del Infinito ε\">"
  },
  RelicConfig_67819_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67819_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67819_Name = {
    Text = "<OrangeQuality:\"Puerta del Infinito ζ\">"
  },
  RelicConfig_67820_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67820_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67820_Name = {
    Text = "<OrangeQuality:\"Puerta del Infinito θ\">"
  },
  RelicConfig_67821_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67821_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67821_Name = {
    Text = "<OrangeQuality:\"Puerta del Infinito γ\">"
  },
  RelicConfig_67822_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67822_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67822_Name = {
    Text = "<OrangeQuality:\"Puerta del Infinito α\">"
  },
  RelicConfig_67823_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67823_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67823_Name = {
    Text = "<OrangeQuality:\"Puerta del Infinito η\">"
  },
  RelicConfig_67824_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67824_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67824_Name = {
    Text = "<OrangeQuality:\"Puerta del Infinito δ\">"
  },
  RelicConfig_67825_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67825_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67825_Name = {
    Text = "<OrangeQuality:\"Puerta del Infinito β\">"
  },
  RelicConfig_67826_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67826_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de cada turno, descubre aleatoriamente una \"reliquia\" o \"apoyo\", por un total de cinco veces"
  },
  RelicConfig_67826_Name = {
    Text = "<OrangeQuality:\"Puerta del Infinito ι\">"
  },
  RelicConfig_68651_BattleDesc = {
    Text = "Al comenzar la batalla, despierta a todos los Despertados, coloca <DerivativeCardKeywords_84:\"Crepúsculo: Escultura de cera inacabada\"> en tu mano, y copia todas las cartas del mazo de robo. Roba 5 cartas adicionales cada turno, y gana 5 puntos de aritmética. Después de jugar \"golpear\" o \"defensa\", obtén [Arg1] puntos de blindaje."
  },
  RelicConfig_68651_Desc = {
    Text = "Al comenzar la batalla, despierta a todos los Despertados, coloca <DerivativeCardKeywords_84:\"Recuerdos: Escultura de cera inacabada\"> en tu mano, y copia todas las cartas del mazo de robo. Roba 5 cartas adicionales cada turno y gana 5 puntos de aritmética. Después de jugar \"golpear\" o \"defensa\", obtén [Arg1] puntos de blindaje."
  },
  RelicConfig_68651_Name = {
    Text = "<OrangeQuality:«Núcleo de plata pura·Miedo»>"
  },
  RelicConfig_68652_BattleDesc = {
    Text = "Al comenzar la batalla, despierta a todos los Despertados y coloca <DerivativeCardKeywords_85:\"Crepúsculo: Corazón distorsionado\"> en tu mano. Al inicio del turno, puedes elegir descartar cualquier carta en tu mano y robar la misma cantidad de cartas. En turnos impares, obtén [Arg1] puntos de STR temporal y coloca\"<DerivativeCardKeywords_97:Voluntad inquebrantable β\"> en tu mano. En turnos pares, obtén [Arg2] puntos de Precaución temporal y coloca <DerivativeCardKeywords_98:\"Hideβ\"> en tu mano."
  },
  RelicConfig_68652_Desc = {
    Text = "Al comenzar la batalla, despierta a todos los despertados y coloca <DerivativeCardKeywords_85:\"Crepúsculo: Corazón mutado\"> en tu mano. Al inicio de cada turno, puedes elegir descartar cualquier cantidad de cartas en la mano y robar la misma cantidad. En turnos impares, obtén [Arg1] puntos de STR temporal y añade <DerivativeCardKeywords_97:\"Voluntad inquebrantable β\"> a tu mano. En turnos pares, obtén [Arg2] puntos de Precaución temporal y añade <DerivativeCardKeywords_98:\"Hideβ\"> a tu mano."
  },
  RelicConfig_68652_Name = {
    Text = "<OrangeQuality:«Núcleo de plata pura·Penetrante»>"
  },
  RelicConfig_68653_BattleDesc = {
    Text = "Al comenzar la batalla, despierta a todos los Despertados y coloca <DerivativeCardKeywords_83:\"Crepúsculo: El regalo del retorno inocente\"> en tu mano. Todos los Despertados pueden liberar 1 vez adicional la Exaltar por turno; tras liberar la Exaltar, reduce en [Arg2] puntos la Fuerza del enemigo. Al inicio del turno, todos los Despertados obtienen [Arg1] puntos de Alienación."
  },
  RelicConfig_68653_Desc = {
    Text = "Al comenzar la batalla, despierta a todos los Despertados y coloca <DerivativeCardKeywords_83:\"Crepúsculo: El regalo del retorno inocente\"> en tu mano. Todos los Despertados pueden liberar 1 vez adicional la Exaltar por turno; tras liberar la Exaltar, reduce la Fuerza del enemigo en [Arg2] puntos. Al inicio del turno, todos los Despertados obtienen [Arg1] puntos de alienación."
  },
  RelicConfig_68653_Name = {
    Text = "<OrangeQuality:«Núcleo de plata pura·Llanto»>"
  },
  RelicConfig_68654_BattleDesc = {
    Text = "Al comenzar la batalla, despierta a todos los Despertados, coloca <DerivativeCardKeywords_88:\"Recuerdos: Velo utópico\"> en tu mano, aumenta el tamaño máximo de la mano del equipo en +2 y el límite de almacenamiento de energía de llave plateada en +100%. Después de liberar la llave, todos los Despertados obtienen una tasa de crítico temporal y un daño crítico + [Arg1] %, recibe un escudo equivalente al 20% de tu PV Max, roba cartas hasta alcanzar el límite de la mano."
  },
  RelicConfig_68654_Desc = {
    Text = "Al comenzar la batalla, despierta a todos los Despertados, coloca <DerivativeCardKeywords_88:\"Recuerdos: Velo utópico\"> en tu mano, aumenta el tamaño máximo de la mano del equipo en +2 y el límite de almacenamiento de energía-s de llave plateada en +100%. Después de liberar la llave, todos los Despertados reciben un aumento temporal del porcentaje de crítico y del daño crítico de + [Arg1] %, obtén un escudo equivalente al 20% de tu PV Max, roba cartas hasta alcanzar el límite de la mano."
  },
  RelicConfig_68654_Name = {
    Text = "<OrangeQuality:«Núcleo de plata pura·Locura»>"
  },
  RelicConfig_68655_BattleDesc = {
    Text = "Al comenzar la batalla, despierta a todos los Despertados y coloca <DerivativeCardKeywords_89:\"Crepúsculo: Semilla de la Abundancia\"> en tu mano. Al final del turno, retén la aritmética restante y no descartes cartas de tu mano. Por cada daño activo causado, obtén [Arg1] puntos de Fuerza temporal y [Arg2] puntos de Blindaje."
  },
  RelicConfig_68655_Desc = {
    Text = "Al comenzar la batalla, despierta a todos los Despertados y coloca <DerivativeCardKeywords_89:\"Recuerdos: Semilla de la Abundancia\"> en tu mano. Al final del turno, retén la aritmética restante y no descartes cartas de tu mano. Por cada daño activo causado, obtén [Arg1] puntos de fuerza temporal y [Arg2] puntos de blindaje."
  },
  RelicConfig_68655_Name = {
    Text = "<OrangeQuality:«Núcleo de plata pura·Nacimiento»>"
  },
  RelicConfig_68656_BattleDesc = {
    Text = "Al comenzar la batalla, despierta a todos los Despertados y coloca <DerivativeCardKeywords_86:\"Crepúsculo: Honey Mead\"> en tu mano. El daño crítico de todos los Despertados se convierte en 1.5 veces. Al final del turno, los Despertados que no hayan liberado la exaltación obtienen [Arg1] puntos de locura. Si el número de cartas jugadas es menor que [Arg2], roba 2 cartas en el próximo turno y obtén 2 puntos de aritmética."
  },
  RelicConfig_68656_Desc = {
    Text = "Al comenzar la batalla, despierta a todos los Despertados, coloca <DerivativeCardKeywords_86:\"Crepúsculo: Honey Mead\"> en tu mano, el daño crítico de todos los Despertados se convierte en 1.5 veces. Al final del turno, los Despertados que no hayan liberado la exaltación obtienen [Arg1] puntos de alienación. Si el número de cartas jugadas es menor que [Arg2], roba 2 cartas en el próximo turno y obtén 2 puntos de aritmética."
  },
  RelicConfig_68656_Name = {
    Text = "<OrangeQuality:«Núcleo de plata pura·Intriga»>"
  },
  RelicConfig_68657_BattleDesc = {
    Text = "Al inicio de la batalla, Activa a todos los Despertados, coloca <DerivativeCardKeywords_87:\"Crepúsculo: El veredicto del ejecutor\"> en la mano y duplica la Amplificación de Daño del equipo. El efecto de Síntoma: Debilidad que infliges aumenta del 25% al 50%. Al final de cada turno, gana Escudo del personaje igual al [Arg1]% del PV Max e inflige <FixedDamage:DMG Puro> igual a [Arg2] x Escudo del personaje a todos los enemigos."
  },
  RelicConfig_68657_Desc = {
    Text = "Al inicio de la batalla, Activa a todos los Despertados, coloca <DerivativeCardKeywords_87:\"Crepúsculo: El veredicto del ejecutor\"> en la mano y duplica la Amplificación de Daño del equipo. El efecto de Síntoma: Debilidad que infliges aumenta del 25% al 50%. Al final de cada turno, gana Escudo del personaje igual al [Arg1]% del PV Max e inflige <FixedDamage:DMG Puro> igual a [Arg2] x Escudo del personaje a todos los enemigos."
  },
  RelicConfig_68657_Name = {
    Text = "<OrangeQuality:«Núcleo de plata pura·Superstición»>"
  },
  RelicConfig_68886_BattleDesc = {
    Text = "El daño, la curación y el escudo causados por Tawil aumentan un 50%. Al comenzar la batalla, Tawil obtiene 120 puntos de locura."
  },
  RelicConfig_68886_Desc = {
    Text = "El daño, escudo y recuperación de vida causados por Tawil aumentan un 50%. Al iniciar la batalla, Tawil obtiene 120 puntos de locura."
  },
  RelicConfig_68886_Name = {
    Text = "<OrangeQuality:«Ojo de la Omnisciencia»>"
  },
  RelicConfig_68886_StoryDesc = {
    Text = "Desde la puerta, Él emprende el único camino correcto."
  },
  RelicConfig_69319_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de turnos impares, descubre una reliquia, por un total de cinco veces"
  },
  RelicConfig_69319_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de turnos impares, descubre una reliquia, por un total de cinco veces"
  },
  RelicConfig_69319_Name = {
    Text = "<OrangeQuality:péndulo crono\"Deseo ε\">"
  },
  RelicConfig_69320_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de turnos impares, descubre una reliquia, por un total de cinco veces"
  },
  RelicConfig_69320_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de turnos impares, descubre una reliquia, por un total de cinco veces"
  },
  RelicConfig_69320_Name = {
    Text = "<OrangeQuality:péndulo crono\"Deseo γ\">"
  },
  RelicConfig_69321_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de turnos impares, descubre una reliquia, por un total de cinco veces"
  },
  RelicConfig_69321_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los despertadores. Al inicio de turnos impares, descubre una reliquia, por un total de cinco veces"
  },
  RelicConfig_69321_Name = {
    Text = "<OrangeQuality:péndulo crono\"Deseo δ\">"
  },
  RelicConfig_70042_BattleDesc = {
    Text = "Al comienzo del turno, acumula 1 punto de \"Origen del Abismo\", elige entre \"Sueño\" o \"Despertar\". Sueño: acumula 1 punto adicional de \"Origen del Abismo\". Despertar: consume 1/5/10 puntos de \"Origen del Abismo\" y recibe la ayuda de Tulu. Cuanto más \"Origen del Abismo\" consumas, más fuerte será el efecto de la ayuda de Tulu."
  },
  RelicConfig_70042_Desc = {
    Text = "Al comienzo del turno, acumula 1 punto de \"Origen del Abismo\", elige entre \"Sueño\" o \"Despertar\".Sueño: acumula 1 punto adicional de \"Origen del Abismo\".Despertar: consume 1/5/10 puntos de \"Origen del Abismo\" para obtener la ayuda de Tulu. Cuanto más \"Origen del Abismo\" consumas, más fuerte será el efecto de la ayuda de Tulu."
  },
  RelicConfig_70042_Name = {
    Text = "<OrangeQuality:Poder del Rey Divino>"
  },
  RelicConfig_70084_BattleDesc = {
    Text = "Al comienzo de la batalla, baraja el \"despertar\" de todos los cuerpos de despertar en el mazo de robo."
  },
  RelicConfig_70084_Desc = {
    Text = "Al comienzo de la batalla, baraja el \"despertar\" de todos los cuerpos de despertar en el mazo de robo."
  },
  RelicConfig_70084_Name = {
    Text = "<OrangeQuality:Despertar>"
  },
  RelicConfig_70700_BattleDesc = {
    Text = "El daño base causado por todos los Despertados aumenta un [Arg1]%."
  },
  RelicConfig_70700_Desc = {
    Text = "El daño base causado por todos los Despertados aumenta un [Arg1]%."
  },
  RelicConfig_70700_Name = {
    Text = "<WhiteQuality:Pipa llorona>"
  },
  RelicConfig_70700_StoryDesc = {
    Text = "¿Es esto el fruto del odio o el resultado de la venganza?"
  },
  RelicConfig_70701_BattleDesc = {
    Text = "Al inicio del turno, todos los Despertados obtienen [Arg1] puntos de locura."
  },
  RelicConfig_70701_Desc = {
    Text = "Al inicio del turno, todos los Despertados obtienen [Arg1] puntos de locura."
  },
  RelicConfig_70701_Name = {
    Text = "<WhiteQuality:Batería prototipo>"
  },
  RelicConfig_70701_StoryDesc = {
    Text = "Esperanza portátil"
  },
  RelicConfig_70702_BattleDesc = {
    Text = "Tras liberar la exhalación de aliemus, obtienes [Arg1] puntos temporales de <PowerIconKeywords:poder>."
  },
  RelicConfig_70702_Desc = {
    Text = "Tras liberar la exhalación de aliemus, obtienes [Arg1] puntos temporales de <PowerIconKeywords:poder>."
  },
  RelicConfig_70702_Name = {
    Text = "<OrangeQuality:Candado pesado+>"
  },
  RelicConfig_70702_StoryDesc = {
    Text = "Un candado grueso y sólido, difícil de abrir sin llave.\nClaro, para un ladrón maestro no es nada"
  },
  RelicConfig_70703_BattleDesc = {
    Text = "\"Golpe\"causa un daño adicional equivalente al [Arg1]% del ataque del Despertado, pudiendo activarse hasta 3 veces por turno."
  },
  RelicConfig_70703_Desc = {
    Text = "\"Golpe\"causa un daño adicional equivalente al [Arg1]% del ataque del Despertado, pudiendo activarse hasta 3 veces por turno."
  },
  RelicConfig_70703_Name = {
    Text = "<WhiteQuality:Bisturí oxidado>"
  },
  RelicConfig_70703_StoryDesc = {
    Text = "No es adecuado para cortar tejido vivo"
  },
  RelicConfig_70704_BattleDesc = {
    Text = "Después de usar el Despertar de la llave de plata, aplica [Arg1] capas de <IntoxicationIconKeywords:veneno> a todos los enemigos y obtén [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70704_Desc = {
    Text = "Después de usar el Despertar de la llave de plata, aplica [Arg1] capas de <IntoxicationIconKeywords:veneno> a todos los enemigos y obtén [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70704_Name = {
    Text = "<OrangeQuality:Ungüento sospechoso+>"
  },
  RelicConfig_70704_StoryDesc = {
    Text = "Alguna especie de ungüento para heridas casero, por favor no lo uses sin la supervisión de un doctor"
  },
  RelicConfig_70705_BattleDesc = {
    Text = "\"Golpe\" aplica un <IntoxicationIconKeywords:veneno> equivalente al [Arg1]% del daño causado, con un máximo de [Arg2] puntos por turno."
  },
  RelicConfig_70705_Desc = {
    Text = "\"Golpe\" aplica un <IntoxicationIconKeywords:veneno> equivalente al [Arg1]% del daño causado, con un máximo de [Arg2] puntos por turno."
  },
  RelicConfig_70705_Name = {
    Text = "<OrangeQuality:Lengua extraña+>"
  },
  RelicConfig_70705_StoryDesc = {
    Text = "No es un demonio, pero sí transmite susurros de más allá del mundo"
  },
  RelicConfig_70706_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:Fusión Embrionaria> aumenta la cantidad automática obtenida en [Arg1]%."
  },
  RelicConfig_70706_Desc = {
    Text = "<EmbryoFusionIconKeywords:Fusión Embrionaria> aumenta la cantidad automática obtenida en [Arg1]%."
  },
  RelicConfig_70706_Name = {
    Text = "<WhiteQuality:Diagnóstico de plaga>"
  },
  RelicConfig_70706_StoryDesc = {
    Text = "Peste: una manifestación accidental de la inquietud inconsciente de la naturaleza"
  },
  RelicConfig_70707_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, todos los Despertados obtienen [Arg1] puntos de Locura y [Arg2] puntos de energía de llave de plata."
  },
  RelicConfig_70707_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, todos los Despertados obtienen [Arg1] puntos de Locura y [Arg2] puntos de energía de llave de plata."
  },
  RelicConfig_70707_Name = {
    Text = "<OrangeQuality:Gemelos de laurel+>"
  },
  RelicConfig_70707_StoryDesc = {
    Text = "Gemelos de plata con diseño de laureles.\nEstá bien hecho y brillante, simbolizando una antigua amistad de dos niños"
  },
  RelicConfig_70708_BattleDesc = {
    Text = "Tras el inicio de la batalla, obtén [Arg1] <ProficientInRealmsIconKeywords:maestría en reinos>. El <IntoxicationIconKeywords:veneno> causado por todos los Despertados y el <IntoxicationIconKeywords:veneno> causado por las creaciones aumenta un [Arg2]%."
  },
  RelicConfig_70708_Desc = {
    Text = "Tras el inicio de la batalla, obtén [Arg1] <ProficientInRealmsIconKeywords:maestría en reinos>. El <IntoxicationIconKeywords:veneno> causado por todos los Despertados y el <IntoxicationIconKeywords:veneno> causado por las creaciones aumenta un [Arg2]%."
  },
  RelicConfig_70708_Name = {
    Text = "<OrangeQuality:Máquina de Coser Polvorienta+>"
  },
  RelicConfig_70708_StoryDesc = {
    Text = "Una madre cariñosa, remendando las heridas del corazón"
  },
  RelicConfig_70709_BattleDesc = {
    Text = "Tras entrar en un turno ultra, la primera carta de comando no derivada jugada tendrá un efecto adicional [Arg1] veces."
  },
  RelicConfig_70709_Desc = {
    Text = "Tras entrar en un turno ultra, la primera carta de comando no derivada jugada tendrá un efecto adicional [Arg1] veces."
  },
  RelicConfig_70709_Name = {
    Text = "<WhiteQuality: reloj de arena resplandeciente>"
  },
  RelicConfig_70709_StoryDesc = {
    Text = "Un tiempo medible"
  },
  RelicConfig_70711_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] <RetaliateIconKeywords:contraataque> y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70711_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] <RetaliateIconKeywords:contraataque> y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70711_Name = {
    Text = "<OrangeQuality:Fragmentos de sabiduría+>"
  },
  RelicConfig_70711_StoryDesc = {
    Text = "\"Los humanos son tan tontos, creen ciegamente en lo obsoleto.\""
  },
  RelicConfig_70712_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] puntos de <PowerIconKeywords:fuerza> y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70712_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] puntos de <PowerIconKeywords:fuerza> y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70712_Name = {
    Text = "<WhiteQuality:Nuestro hogar>"
  },
  RelicConfig_70712_StoryDesc = {
    Text = "Estuvieron juntos antes y estarán juntos para siempre. Son una familia amorosa"
  },
  RelicConfig_70713_BattleDesc = {
    Text = "Cuando pierdes vida, obtienes un Horno Carmesí equivalente al [Arg1]% de la vida perdida."
  },
  RelicConfig_70713_Desc = {
    Text = "Cuando pierdes vida, obtienes un Horno Carmesí equivalente al [Arg1]% de la vida perdida."
  },
  RelicConfig_70713_Name = {
    Text = "<WhiteQuality:Sierra oxidada>"
  },
  RelicConfig_70713_StoryDesc = {
    Text = "El doctor de anatomía nunca ve a mujeres hermosas, solo un costal de huesos, nervios inflamados por enfermedades, músculos y tejidos"
  },
  RelicConfig_70714_BattleDesc = {
    Text = "Tras el inicio de la batalla, obtén [Arg1] <ProficientInRealmsIconKeywords:maestría en reinos>. El <RetaliateIconKeywords:contraataque> causado por todos los Despertados y el <RetaliateIconKeywords:contraataque> causado por las creaciones aumenta un [Arg2]%."
  },
  RelicConfig_70714_Desc = {
    Text = "Tras el inicio de la batalla, obtén [Arg1] <ProficientInRealmsIconKeywords:maestría en reinos>. El <RetaliateIconKeywords:contraataque> causado por todos los Despertados y el <RetaliateIconKeywords:contraataque> causado por las creaciones aumenta un [Arg2]%."
  },
  RelicConfig_70714_Name = {
    Text = "<WhiteQuality:Franqueza>"
  },
  RelicConfig_70714_StoryDesc = {
    Text = "Ha transmitido innumerables secretos, ya sean voluntarios o forzados"
  },
  RelicConfig_70715_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, roba [Arg1] cartas y obtén [Arg2] puntos de energía-s."
  },
  RelicConfig_70715_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, roba [Arg1] cartas y obtén [Arg2] puntos de energía-s."
  },
  RelicConfig_70715_Name = {
    Text = "<OrangeQuality:Cartera nueva+>"
  },
  RelicConfig_70715_StoryDesc = {
    Text = "Una billetera de cuero marcada con el emblema de la Universidad de Mitag.  \nAhora está vacía, sin nada dentro"
  },
  RelicConfig_70717_BattleDesc = {
    Text = "Al inicio del turno, roba [Arg1] cartas"
  },
  RelicConfig_70717_Desc = {
    Text = "Al inicio del turno, roba [Arg1] cartas"
  },
  RelicConfig_70717_Name = {
    Text = "<OrangeQuality:Brújula direccional+>"
  },
  RelicConfig_70717_StoryDesc = {
    Text = "No indica dirección, solo el campo magnético"
  },
  RelicConfig_70718_BattleDesc = {
    Text = "Tras usar \"Exaltar,\" todos los enemigos reciben [Arg1] de <FixedDamage:DMG Puro> y activan [Arg2]% de <IntoxicationIconKeywords:Veneno>."
  },
  RelicConfig_70718_Desc = {
    Text = "Tras usar \"Exaltar,\" todos los enemigos reciben 1 instancia de <FixedDamage:DMG Puro> igual al [Arg2]% del PV Max del equipo y activan [Arg2]% de <IntoxicationIconKeywords:Veneno>."
  },
  RelicConfig_70718_Name = {
    Text = "<WhiteQuality:Mandíbula láser>"
  },
  RelicConfig_70718_StoryDesc = {
    Text = "Huesos exhibidos en la galería privada de un coleccionista.\nEl coleccionista estaba fascinado por su hermoso brillo, lo admiraba día y noche, hasta que murió y se convirtió en uno de ellos"
  },
  RelicConfig_70719_BattleDesc = {
    Text = "Al inicio del turno, todos los Despertados obtienen [Arg1] puntos de locura."
  },
  RelicConfig_70719_Desc = {
    Text = "Al inicio del turno, todos los Despertados obtienen [Arg1] puntos de locura."
  },
  RelicConfig_70719_Name = {
    Text = "<OrangeQuality:Batería prototipo+>"
  },
  RelicConfig_70719_StoryDesc = {
    Text = "Esperanza portátil"
  },
  RelicConfig_70720_BattleDesc = {
    Text = "Al inicio del turno, si la vida es menor al 25%, obtén [Arg1] <PowerIconKeywords:fuerza> temporal."
  },
  RelicConfig_70720_Desc = {
    Text = "Al inicio del turno, si la vida es menor al 25%, obtén [Arg1] <PowerIconKeywords:fuerza> temporal."
  },
  RelicConfig_70720_Name = {
    Text = "<WhiteQuality:Máximo honor>"
  },
  RelicConfig_70720_StoryDesc = {
    Text = "Un gato negro elegante y misterioso, considerado una deidad en tierras desérticas lejanas. Pero el nombre de esa deidad ya nadie lo recuerda.\nSer adorado, venerado y olvidado, tal vez sea el destino de los dioses"
  },
  RelicConfig_70721_BattleDesc = {
    Text = "Después de liberar 4 veces la exaltación de aliemus en un turno, obtienes [Arg1] puntos de aritmética, con un enfriamiento de 3 turnos."
  },
  RelicConfig_70721_Desc = {
    Text = "Después de liberar 4 veces la exaltación de aliemus en un turno, obtienes [Arg1] puntos de aritmética, con un enfriamiento de 3 turnos."
  },
  RelicConfig_70721_Name = {
    Text = "<WhiteQuality:Máquina Diferencial Plateada>"
  },
  RelicConfig_70721_StoryDesc = {
    Text = "\"Cambió la historia.\""
  },
  RelicConfig_70722_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] puntos de <PowerIconKeywords:fuerza> y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70722_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] puntos de <PowerIconKeywords:fuerza> y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70722_Name = {
    Text = "<OrangeQuality:Nuestro Hogar+>"
  },
  RelicConfig_70722_StoryDesc = {
    Text = "Estuvieron juntos antes y estarán juntos para siempre. Son una familia amorosa"
  },
  RelicConfig_70723_BattleDesc = {
    Text = "Al jugar dos cartas consecutivas con un consumo de aritmética superior a la carta anterior, obtienes [Arg1] <RetaliateIconKeywords:contraataque>, con un máximo de 3 activaciones por turno."
  },
  RelicConfig_70723_Desc = {
    Text = "Al jugar dos cartas consecutivas con un consumo de aritmética superior a la carta anterior, obtienes [Arg1] <RetaliateIconKeywords:contraataque>, con un máximo de 3 activaciones por turno."
  },
  RelicConfig_70723_Name = {
    Text = "<OrangeQuality:Registro de Arcanas+>"
  },
  RelicConfig_70723_StoryDesc = {
    Text = "Tendencia del destino"
  },
  RelicConfig_70724_BattleDesc = {
    Text = "Al comenzar la batalla, obtén [Arg1] <PowerIconKeywords:fuerza>."
  },
  RelicConfig_70724_Desc = {
    Text = "Al comenzar la batalla, obtén [Arg1] <PowerIconKeywords:fuerza>."
  },
  RelicConfig_70724_Name = {
    Text = "<OrangeQuality:Broche de rubí+>"
  },
  RelicConfig_70724_StoryDesc = {
    Text = "Se filtra un rojo tenue"
  },
  RelicConfig_70725_BattleDesc = {
    Text = "Al comenzar la batalla, aplica [Arg1] capas de <WeaknessIconKeywords:debilidad> a todos los enemigos. En la batalla contra el jefe, el efecto se duplica. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_70725_Desc = {
    Text = "Al comenzar la batalla, aplica [Arg1] capas de <WeaknessIconKeywords:debilidad> a todos los enemigos. En la batalla contra el jefe, el efecto se duplica. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_70725_Name = {
    Text = "<OrangeQuality:Niño travieso+>"
  },
  RelicConfig_70725_StoryDesc = {
    Text = "Nacido del mal puro, aunque no sea su deseo"
  },
  RelicConfig_70726_BattleDesc = {
    Text = "Aniquilación: Obtener [Arg1] escudos, 3 turnos de enfriamiento."
  },
  RelicConfig_70726_Desc = {
    Text = "Aniquilación: Obtener [Arg1] escudos, 3 turnos de enfriamiento."
  },
  RelicConfig_70726_Name = {
    Text = "<WhiteQuality:Reloj hipercuerda>"
  },
  RelicConfig_70726_StoryDesc = {
    Text = "\"Vaya, el reloj se detuvo.\""
  },
  RelicConfig_70727_BattleDesc = {
    Text = "Al final del turno, recupera [Heal:Arg1] vida."
  },
  RelicConfig_70727_Desc = {
    Text = "Al final del turno, recupera [Heal:Arg1] vida."
  },
  RelicConfig_70727_Name = {
    Text = "<OrangeQuality:Sangre bendita+>"
  },
  RelicConfig_70727_StoryDesc = {
    Text = "Es dulce y suave, con aroma a rosas"
  },
  RelicConfig_70728_BattleDesc = {
    Text = "Usa postura de mar tranquilo para hacer que todos los enemigos pierdan [Arg1] puntos de <ExhaustionIconKeywords: fuerza> temporal, con un tiempo de reutilización de 3 rondas."
  },
  RelicConfig_70728_Desc = {
    Text = "Usa postura de mar tranquilo para hacer que todos los enemigos pierdan [Arg1] puntos de <ExhaustionIconKeywords: fuerza> temporal, con un tiempo de reutilización de 3 rondas."
  },
  RelicConfig_70728_Name = {
    Text = "<OrangeQuality:Extremidad anónima+>"
  },
  RelicConfig_70728_StoryDesc = {
    Text = "Cuidado con las espinas"
  },
  RelicConfig_70730_BattleDesc = {
    Text = "Al comenzar la batalla, obtén [Arg1] <PowerIconKeywords:fuerza>."
  },
  RelicConfig_70730_Desc = {
    Text = "Al comenzar la batalla, obtén [Arg1] <PowerIconKeywords:fuerza>."
  },
  RelicConfig_70730_Name = {
    Text = "<WhiteQuality:Broche de rubí>"
  },
  RelicConfig_70730_StoryDesc = {
    Text = "Se filtra un rojo tenue"
  },
  RelicConfig_70731_BattleDesc = {
    Text = "Cuando un enemigo te ataca, inflige [Arg1] de Daño Fijo. Este DMG disfruta de un bono de <RetaliateIconKeywords:Contador> del [Arg2]%. Cada enemigo puede activar este efecto hasta 1 vez por turno."
  },
  RelicConfig_70731_Desc = {
    Text = "Cuando un enemigo te ataca, inflige Daño Fijo igual al [Arg3]% del PV Max del equipo. Este DMG disfruta de un bono de <RetaliateIconKeywords:Contador> del [Arg2]%. Cada enemigo puede activar este efecto hasta 1 vez por turno."
  },
  RelicConfig_70731_Name = {
    Text = "<OrangeQuality:Cuchillo ritual perdido+>"
  },
  RelicConfig_70731_StoryDesc = {
    Text = "Daga de hoja curva, comúnmente usada en rituales"
  },
  RelicConfig_70732_BattleDesc = {
    Text = "Tras entrar en un turno ultra, la primera carta de comando no derivada jugada tendrá un efecto adicional [Arg1] veces."
  },
  RelicConfig_70732_Desc = {
    Text = "Tras entrar en un turno ultra, la primera carta de comando no derivada jugada tendrá un efecto adicional [Arg1] veces."
  },
  RelicConfig_70732_Name = {
    Text = "<OrangeQuality:Reloj de arena resplandeciente+>"
  },
  RelicConfig_70732_StoryDesc = {
    Text = "Un tiempo medible"
  },
  RelicConfig_70733_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:Fusión Embrionaria> aumenta la cantidad automática obtenida en [Arg1]%."
  },
  RelicConfig_70733_Desc = {
    Text = "<EmbryoFusionIconKeywords:Fusión Embrionaria> aumenta la cantidad automática obtenida en [Arg1]%."
  },
  RelicConfig_70733_Name = {
    Text = "<OrangeQuality:Diagnóstico de plaga+>"
  },
  RelicConfig_70733_StoryDesc = {
    Text = "Peste: una manifestación accidental de la inquietud inconsciente de la naturaleza"
  },
  RelicConfig_70734_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, el daño base causado por todos los Despertadores aumenta un [Arg1]% y obtienen [Arg2] energía-s de llave de plata."
  },
  RelicConfig_70734_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, el daño base causado por todos los Despertadores aumenta un [Arg1]% y obtienen [Arg2] energía-s de llave de plata."
  },
  RelicConfig_70734_Name = {
    Text = "<WhiteQuality:Astrolabio del Grimorio>"
  },
  RelicConfig_70734_StoryDesc = {
    Text = "Los misterios del universo"
  },
  RelicConfig_70735_BattleDesc = {
    Text = "Al jugar consecutivamente 2 cartas con un consumo de aritmética menor que la carta anterior, aplica [Arg1] capas de <IntoxicationIconKeywords:veneno> a todos los enemigos, activándose un máximo de 3 veces por turno."
  },
  RelicConfig_70735_Desc = {
    Text = "Al jugar consecutivamente 2 cartas con un consumo de aritmética menor que la carta anterior, aplica [Arg1] capas de <IntoxicationIconKeywords:veneno> a todos los enemigos, activándose un máximo de 3 veces por turno."
  },
  RelicConfig_70735_Name = {
    Text = "<OrangeQuality:Reliquia Arcana+>"
  },
  RelicConfig_70735_StoryDesc = {
    Text = "El fin del destino"
  },
  RelicConfig_70736_BattleDesc = {
    Text = "Usa postura de mar tranquilo para hacer que todos los enemigos pierdan [Arg1] puntos de <ExhaustionIconKeywords: fuerza> temporal, con un tiempo de reutilización de 3 rondas."
  },
  RelicConfig_70736_Desc = {
    Text = "Usa postura de mar tranquilo para hacer que todos los enemigos pierdan [Arg1] puntos de <ExhaustionIconKeywords: fuerza> temporal, con un tiempo de reutilización de 3 rondas."
  },
  RelicConfig_70736_Name = {
    Text = "<WhiteQuality:Extremidad anónima>"
  },
  RelicConfig_70736_StoryDesc = {
    Text = "Cuidado con las espinas"
  },
  RelicConfig_70737_BattleDesc = {
    Text = "Después de jugar una carta, si el número de cartas en tu mano es menor o igual a [Arg1], roba [Arg2] cartas. Máximo [Arg3] activaciones por turno."
  },
  RelicConfig_70737_Desc = {
    Text = "Después de jugar una carta, si el número de cartas en tu mano es menor o igual a [Arg1], roba [Arg2] cartas. Máximo [Arg3] activaciones por turno."
  },
  RelicConfig_70737_Name = {
    Text = "<WhiteQuality:Guantes mágicos>"
  },
  RelicConfig_70737_StoryDesc = {
    Text = "\"No temas, esto es solo magia.\""
  },
  RelicConfig_70738_BattleDesc = {
    Text = "Al final del turno, recupera [Heal:Arg1] vida."
  },
  RelicConfig_70738_Desc = {
    Text = "Al final del turno, recupera [Heal:Arg1] vida."
  },
  RelicConfig_70738_Name = {
    Text = "<WhiteQuality:Sangre bendita>"
  },
  RelicConfig_70738_StoryDesc = {
    Text = "Es dulce y suave, con aroma a rosas"
  },
  RelicConfig_70739_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] puntos de escudo y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70739_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] puntos de escudo y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70739_Name = {
    Text = "<WhiteQuality: especimen de mariposa>"
  },
  RelicConfig_70739_StoryDesc = {
    Text = "Hasta ahora, alguien lo ha amado profundamente"
  },
  RelicConfig_70740_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, el daño base causado por todos los Despertadores aumenta un [Arg1]% y obtienen [Arg2] energía-s de llave de plata."
  },
  RelicConfig_70740_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, el daño base causado por todos los Despertadores aumenta un [Arg1]% y obtienen [Arg2] energía-s de llave de plata."
  },
  RelicConfig_70740_Name = {
    Text = "<OrangeQuality:Astrolabio del Grimorio+>"
  },
  RelicConfig_70740_StoryDesc = {
    Text = "Los misterios del universo"
  },
  RelicConfig_70741_BattleDesc = {
    Text = "Aumenta el límite de aritmética máxima en [Arg1]"
  },
  RelicConfig_70741_Desc = {
    Text = "Aumenta el límite de aritmética máxima en [Arg1]"
  },
  RelicConfig_70741_Name = {
    Text = "<OrangeQuality:Inyector activo+>"
  },
  RelicConfig_70741_StoryDesc = {
    Text = "Los espasmos también son una forma de actividad"
  },
  RelicConfig_70742_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de tentáculos aumenta en [Arg1], obtén [Arg2] tentáculos."
  },
  RelicConfig_70742_Desc = {
    Text = "Al comenzar la batalla, el límite de tentáculos aumenta en [Arg1], obtén [Arg2] tentáculos."
  },
  RelicConfig_70742_Name = {
    Text = "<WhiteQuality:Canción del Mar Amado>"
  },
  RelicConfig_70742_StoryDesc = {
    Text = "Se dice que animales no comestibles como el caracol de tejido absorben alrededor del 80% de los nutrientes del océano"
  },
  RelicConfig_70743_BattleDesc = {
    Text = "Cada vez que se realiza una <DevouredIconKeywords:devoración> por primera vez en el turno, los demás Despertados obtienen [Arg1] puntos de locura."
  },
  RelicConfig_70743_Desc = {
    Text = "Cada vez que se realiza una <DevouredIconKeywords:devoración> por primera vez en el turno, los demás Despertados obtienen [Arg1] puntos de locura."
  },
  RelicConfig_70743_Name = {
    Text = "<WhiteQuality:Tierra de Sueños Dorados>"
  },
  RelicConfig_70743_StoryDesc = {
    Text = "El día de tu transformación será tu fin"
  },
  RelicConfig_70744_BattleDesc = {
    Text = "Después de jugar una carta de comando no derivada, baraja [Arg1] copias temporales de esa carta con un costo de aritmética reducido en 2 en el mazo de robar, con un enfriamiento de 3 turnos."
  },
  RelicConfig_70744_Desc = {
    Text = "Después de jugar una carta de comando no derivada, baraja [Arg1] copias temporales de esa carta con un costo de aritmética reducido en 2 en el mazo de robar, con un enfriamiento de 3 turnos."
  },
  RelicConfig_70744_Name = {
    Text = "<OrangeQuality:Gramófono mudo+>"
  },
  RelicConfig_70744_StoryDesc = {
    Text = "Su voz se perdió en el viento"
  },
  RelicConfig_70745_BattleDesc = {
    Text = "Al comenzar la batalla, obtén [Arg1] <RetaliateIconKeywords:contraataque>. En la batalla contra el jefe, el efecto se duplica."
  },
  RelicConfig_70745_Desc = {
    Text = "Al comenzar la batalla, obtén [Arg1] <RetaliateIconKeywords:contraataque>. En la batalla contra el jefe, el efecto se duplica."
  },
  RelicConfig_70745_Name = {
    Text = "<OrangeQuality:Chaleco de ortiga+>"
  },
  RelicConfig_70745_StoryDesc = {
    Text = "No se puede identificar el líquido contaminado"
  },
  RelicConfig_70746_BattleDesc = {
    Text = "Al inicio del turno, si la vida es menor al 25%, obtén [Arg1] <PowerIconKeywords:fuerza> temporal."
  },
  RelicConfig_70746_Desc = {
    Text = "Al inicio del turno, si la vida es menor al 25%, obtén [Arg1] <PowerIconKeywords:fuerza> temporal."
  },
  RelicConfig_70746_Name = {
    Text = "<OrangeQuality:Supremo Honor+>"
  },
  RelicConfig_70746_StoryDesc = {
    Text = "Un gato negro elegante y misterioso, considerado una deidad en tierras desérticas lejanas. Pero el nombre de esa deidad ya nadie lo recuerda.\nSer adorado, venerado y olvidado, tal vez sea el destino de los dioses"
  },
  RelicConfig_70747_BattleDesc = {
    Text = "Después de jugar una carta, si el número de cartas en tu mano es menor o igual a [Arg1], roba [Arg2] cartas. Máximo [Arg3] activaciones por turno."
  },
  RelicConfig_70747_Desc = {
    Text = "Después de jugar una carta, si el número de cartas en tu mano es menor o igual a [Arg1], roba [Arg2] cartas. Máximo [Arg3] activaciones por turno."
  },
  RelicConfig_70747_Name = {
    Text = "<OrangeQuality:Guantes mágicos+>"
  },
  RelicConfig_70747_StoryDesc = {
    Text = "\"No temas, esto es solo magia.\""
  },
  RelicConfig_70748_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] puntos de escudo y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70748_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] puntos de escudo y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70748_Name = {
    Text = "<OrangeQuality:Espécimen de Mariposa+>"
  },
  RelicConfig_70748_StoryDesc = {
    Text = "Hasta ahora, alguien lo ha amado profundamente"
  },
  RelicConfig_70749_BattleDesc = {
    Text = "Cada vez que una carta entra en el espacio dimensional, si esta carta pertenece a un propietario diferente de las demás cartas en dicho espacio, coloca [Arg1] cartas <DerivativeCardKeywords_4:\"inspiración\"> en la mano."
  },
  RelicConfig_70749_Desc = {
    Text = "Cada vez que una carta entra en el espacio dimensional, si esta carta pertenece a un propietario diferente de las demás cartas en dicho espacio, coloca [Arg1] cartas <DerivativeCardKeywords_4:\"inspiración\"> en la mano."
  },
  RelicConfig_70749_Name = {
    Text = "<OrangeQuality:Artefacto de Alfonso+>"
  },
  RelicConfig_70749_StoryDesc = {
    Text = "A diferencia del destino cambiante, las estrellas tienen sus propias leyes"
  },
  RelicConfig_70750_BattleDesc = {
    Text = "Al jugar dos cartas consecutivas con un consumo de aritmética superior a la carta anterior, obtienes [Arg1] <RetaliateIconKeywords:contraataque>, con un máximo de 3 activaciones por turno."
  },
  RelicConfig_70750_Desc = {
    Text = "Al jugar dos cartas consecutivas con un consumo de aritmética superior a la carta anterior, obtienes [Arg1] <RetaliateIconKeywords:contraataque>, con un máximo de 3 activaciones por turno."
  },
  RelicConfig_70750_Name = {
    Text = "<WhiteQuality:Registro de Arcanas>"
  },
  RelicConfig_70750_StoryDesc = {
    Text = "Tendencia del destino"
  },
  RelicConfig_70751_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] puntos de capacidad aritmética y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70751_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] puntos de capacidad aritmética y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70751_Name = {
    Text = "<WhiteQuality: emblema de mitag>"
  },
  RelicConfig_70751_StoryDesc = {
    Text = "Insignia distribuida a los investigadores de la Universidad de Mitag. No solo simboliza la identidad del portador, sino que también es una herramienta para la comunicación remota"
  },
  RelicConfig_70752_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] <RetaliateIconKeywords:contraataque> y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70752_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] <RetaliateIconKeywords:contraataque> y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70752_Name = {
    Text = "<WhiteQuality:Fragmento de sabiduría>"
  },
  RelicConfig_70752_StoryDesc = {
    Text = "\"Los humanos son tan tontos, creen ciegamente en lo obsoleto.\""
  },
  RelicConfig_70753_BattleDesc = {
    Text = "Al comenzar la batalla, aplica [Arg1] capas de <VulnerabilityIconKeywords:vulnerable> a todos los enemigos. En la batalla contra el jefe, el efecto se duplica. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_70753_Desc = {
    Text = "Al comenzar la batalla, aplica [Arg1] capas de <VulnerabilityIconKeywords:vulnerable> a todos los enemigos. En la batalla contra el jefe, el efecto se duplica. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_70753_Name = {
    Text = "<OrangeQuality:Rito de primavera+>"
  },
  RelicConfig_70753_StoryDesc = {
    Text = "En las risas nocturnas, la silueta de la canoa se desliza libremente sobre el lago"
  },
  RelicConfig_70754_BattleDesc = {
    Text = "Cada turno, después de usar por primera vez «embriones» directamente, el daño activo causará sangrado equivalente al [Arg1]% del daño infligido durante este turno."
  },
  RelicConfig_70754_Desc = {
    Text = "Cada turno, después de usar por primera vez «embriones» directamente, el daño activo causará sangrado equivalente al [Arg1]% del daño infligido durante este turno."
  },
  RelicConfig_70754_Name = {
    Text = "<WhiteQuality:Guijarro ensangrentado>"
  },
  RelicConfig_70754_StoryDesc = {
    Text = "Uno, dos, tres, cuatro, cinco"
  },
  RelicConfig_70755_BattleDesc = {
    Text = "Cada vez que causas daño, obtienes [Arg1] puntos de <PowerIconKeywords:fuerza> temporal, con un máximo de 15 activaciones por turno."
  },
  RelicConfig_70755_Desc = {
    Text = "Cada vez que causas daño, obtienes [Arg1] puntos de <PowerIconKeywords:fuerza> temporal, con un máximo de 15 activaciones por turno."
  },
  RelicConfig_70755_Name = {
    Text = "<OrangeQuality:Ágata enredada+>"
  },
  RelicConfig_70755_StoryDesc = {
    Text = "Debería ser solo un patrón de ágata común. Probablemente"
  },
  RelicConfig_70756_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] puntos de capacidad aritmética y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70756_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén [Arg1] puntos de capacidad aritmética y [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70756_Name = {
    Text = "<OrangeQuality:Emblema de Mitag+>"
  },
  RelicConfig_70756_StoryDesc = {
    Text = "Insignia distribuida a los investigadores de la Universidad de Mitag. No solo simboliza la identidad del portador, sino que también es una herramienta para la comunicación remota"
  },
  RelicConfig_70757_BattleDesc = {
    Text = "Usa la postura de Olas Furiosas para activar inmediatamente todos los tentáculos y atacar al enemigo [Arg1] veces. Tiene un enfriamiento de 3 turnos."
  },
  RelicConfig_70757_Desc = {
    Text = "Usa la postura de Olas Furiosas para activar inmediatamente todos los tentáculos y atacar al enemigo [Arg1] veces. Tiene un enfriamiento de 3 turnos."
  },
  RelicConfig_70757_Name = {
    Text = "<WhiteQuality:Placer de la Espiral>"
  },
  RelicConfig_70757_StoryDesc = {
    Text = "Señor del sueño eterno, espera tu entrada en el sueño"
  },
  RelicConfig_70758_BattleDesc = {
    Text = "Al jugar consecutivamente 2 cartas con un consumo de aritmética menor que la carta anterior, aplica [Arg1] capas de <IntoxicationIconKeywords:veneno> a todos los enemigos, activándose un máximo de 3 veces por turno."
  },
  RelicConfig_70758_Desc = {
    Text = "Al jugar consecutivamente 2 cartas con un consumo de aritmética menor que la carta anterior, aplica [Arg1] capas de <IntoxicationIconKeywords:veneno> a todos los enemigos, activándose un máximo de 3 veces por turno."
  },
  RelicConfig_70758_Name = {
    Text = "<WhiteQuality:Reliquia Arcana>"
  },
  RelicConfig_70758_StoryDesc = {
    Text = "El fin del destino"
  },
  RelicConfig_70759_BattleDesc = {
    Text = "Al comenzar la batalla, aplica [Arg1] capas de <WeaknessIconKeywords:debilidad> a todos los enemigos. En la batalla contra el jefe, el efecto se duplica. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_70759_Desc = {
    Text = "Al comenzar la batalla, aplica [Arg1] capas de <WeaknessIconKeywords:debilidad> a todos los enemigos. En la batalla contra el jefe, el efecto se duplica. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_70759_Name = {
    Text = "<WhiteQuality:Niño travieso>"
  },
  RelicConfig_70759_StoryDesc = {
    Text = "Nacido del mal puro, aunque no sea su deseo"
  },
  RelicConfig_70760_BattleDesc = {
    Text = "Al comenzar la batalla, aplica [Arg1] capas de <IntoxicationIconKeywords:veneno> a todos los enemigos. En la batalla contra el jefe, el efecto se duplica."
  },
  RelicConfig_70760_Desc = {
    Text = "Al comenzar la batalla, aplica [Arg1] capas de <IntoxicationIconKeywords:veneno> a todos los enemigos. En la batalla contra el jefe, el efecto se duplica."
  },
  RelicConfig_70760_Name = {
    Text = "<WhiteQuality:Neurotoxina>"
  },
  RelicConfig_70760_StoryDesc = {
    Text = "Extraer, refinar"
  },
  RelicConfig_70761_BattleDesc = {
    Text = "Al comenzar la batalla, aplica [Arg1] capas de <VulnerabilityIconKeywords:vulnerable> a todos los enemigos. En la batalla contra el jefe, el efecto se duplica. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_70761_Desc = {
    Text = "Al comenzar la batalla, aplica [Arg1] capas de <VulnerabilityIconKeywords:vulnerable> a todos los enemigos. En la batalla contra el jefe, el efecto se duplica. El daño base causado por todos los Despertados aumenta un [Arg2]%."
  },
  RelicConfig_70761_Name = {
    Text = "<WhiteQuality:Rito de primavera>"
  },
  RelicConfig_70761_StoryDesc = {
    Text = "En las risas nocturnas, la silueta de la canoa se desliza libremente sobre el lago"
  },
  RelicConfig_70762_BattleDesc = {
    Text = "Después de liberar 4 veces la exaltación de aliemus en un turno, obtienes [Arg1] puntos de aritmética, con un enfriamiento de 3 turnos."
  },
  RelicConfig_70762_Desc = {
    Text = "Después de liberar 4 veces la exaltación de aliemus en un turno, obtienes [Arg1] puntos de aritmética, con un enfriamiento de 3 turnos."
  },
  RelicConfig_70762_Name = {
    Text = "<OrangeQuality:Máquina Diferencial Plateada+>"
  },
  RelicConfig_70762_StoryDesc = {
    Text = "\"Cambió la historia.\""
  },
  RelicConfig_70763_BattleDesc = {
    Text = "Tras liberar la exhalación de aliemus, obtienes [Arg1] puntos temporales de <PowerIconKeywords:poder>."
  },
  RelicConfig_70763_Desc = {
    Text = "Tras liberar la exhalación de aliemus, obtienes [Arg1] puntos temporales de <PowerIconKeywords:poder>."
  },
  RelicConfig_70763_Name = {
    Text = "<WhiteQuality:Candado pesado>"
  },
  RelicConfig_70763_StoryDesc = {
    Text = "Un candado grueso y sólido, difícil de abrir sin llave.\nClaro, para un ladrón maestro no es nada"
  },
  RelicConfig_70764_BattleDesc = {
    Text = "Cuando un enemigo te ataca, inflige [Arg1] de Daño Fijo. Este DMG disfruta de un bono de <RetaliateIconKeywords:Contador> del [Arg2]%. Cada enemigo puede activar este efecto hasta 1 vez por turno."
  },
  RelicConfig_70764_Desc = {
    Text = "Cuando un enemigo te ataca, inflige Daño Fijo igual al [Arg3]% del PV Max del equipo. Este DMG disfruta de un bono de <RetaliateIconKeywords:Contador> del [Arg2]%. Cada enemigo puede activar este efecto hasta 1 vez por turno."
  },
  RelicConfig_70764_Name = {
    Text = "<WhiteQuality:Cuchillo ritual perdido>"
  },
  RelicConfig_70764_StoryDesc = {
    Text = "Daga de hoja curva, comúnmente usada en rituales"
  },
  RelicConfig_70765_BattleDesc = {
    Text = "Cada vez que causas daño, obtienes [Arg1] puntos de <PowerIconKeywords:fuerza> temporal, con un máximo de 15 activaciones por turno."
  },
  RelicConfig_70765_Desc = {
    Text = "Cada vez que causas daño, obtienes [Arg1] puntos de <PowerIconKeywords:fuerza> temporal, con un máximo de 15 activaciones por turno."
  },
  RelicConfig_70765_Name = {
    Text = "<WhiteQuality:Ágata>"
  },
  RelicConfig_70765_StoryDesc = {
    Text = "Debería ser solo un patrón de ágata común. Probablemente"
  },
  RelicConfig_70766_BattleDesc = {
    Text = "Al inicio del turno, si la vida es inferior al 25%, obtén [Arg1] puntos de escudo."
  },
  RelicConfig_70766_Desc = {
    Text = "Al inicio del turno, si la vida es inferior al 25%, obtén [Arg1] puntos de escudo."
  },
  RelicConfig_70766_Name = {
    Text = "<WhiteQuality:Mano protectora>"
  },
  RelicConfig_70766_StoryDesc = {
    Text = "Manos de bendición, puños firmes"
  },
  RelicConfig_70767_BattleDesc = {
    Text = "Aniquilación hace que el cuerpo despertado con menos locura obtenga [Arg1] puntos de locura, 3 turnos de enfriamiento."
  },
  RelicConfig_70767_Desc = {
    Text = "Aniquilación hace que el cuerpo despertado con menos locura obtenga [Arg1] puntos de locura, 3 turnos de enfriamiento."
  },
  RelicConfig_70767_Name = {
    Text = "<WhiteQuality:Gusano del tiempo>"
  },
  RelicConfig_70767_StoryDesc = {
    Text = "Un reloj de bolsillo que existe simultáneamente en una tienda de relojes y en un museo de insectos.\nDespués del primer año de la era Holocénica, fue incluido en la colección universitaria"
  },
  RelicConfig_70768_BattleDesc = {
    Text = "Tras el inicio de la batalla, obtén [Arg1] <ProficientInRealmsIconKeywords:maestría en reinos>. El <RetaliateIconKeywords:contraataque> causado por todos los Despertados y el <RetaliateIconKeywords:contraataque> causado por las creaciones aumenta un [Arg2]%."
  },
  RelicConfig_70768_Desc = {
    Text = "Tras el inicio de la batalla, obtén [Arg1] <ProficientInRealmsIconKeywords:maestría en reinos>. El <RetaliateIconKeywords:contraataque> causado por todos los Despertados y el <RetaliateIconKeywords:contraataque> causado por las creaciones aumenta un [Arg2]%."
  },
  RelicConfig_70768_Name = {
    Text = "<OrangeQuality:Franqueza+>"
  },
  RelicConfig_70768_StoryDesc = {
    Text = "Ha transmitido innumerables secretos, ya sean voluntarios o forzados"
  },
  RelicConfig_70769_BattleDesc = {
    Text = "Cada turno, después de usar por primera vez «embriones» directamente, el daño activo causará sangrado equivalente al [Arg1]% del daño infligido durante este turno."
  },
  RelicConfig_70769_Desc = {
    Text = "Cada turno, después de usar por primera vez «embriones» directamente, el daño activo causará sangrado equivalente al [Arg1]% del daño infligido durante este turno."
  },
  RelicConfig_70769_Name = {
    Text = "<OrangeQuality:Guijarro ensangrentado+>"
  },
  RelicConfig_70769_StoryDesc = {
    Text = "Uno, dos, tres, cuatro, cinco"
  },
  RelicConfig_70770_BattleDesc = {
    Text = "Al inicio del turno, roba [Arg1] cartas"
  },
  RelicConfig_70770_Desc = {
    Text = "Al inicio del turno, roba [Arg1] cartas"
  },
  RelicConfig_70770_Name = {
    Text = "<WhiteQuality:Brújula>"
  },
  RelicConfig_70770_StoryDesc = {
    Text = "No indica dirección, solo el campo magnético"
  },
  RelicConfig_70771_BattleDesc = {
    Text = "\"Golpe\" causa un daño adicional igual al [Arg1]% del ataque del Despertado, 2 veces, con un máximo de 3 activaciones por turno."
  },
  RelicConfig_70771_Desc = {
    Text = "\"Golpe\" causa un daño adicional igual al [Arg1]% del ataque del Despertado, 2 veces, con un máximo de 3 activaciones por turno."
  },
  RelicConfig_70771_Name = {
    Text = "<OrangeQuality:Bisturí oxidado+>"
  },
  RelicConfig_70771_StoryDesc = {
    Text = "No es adecuado para cortar tejido vivo"
  },
  RelicConfig_70772_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, roba [Arg1] cartas y obtén [Arg2] puntos de energía-s."
  },
  RelicConfig_70772_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, roba [Arg1] cartas y obtén [Arg2] puntos de energía-s."
  },
  RelicConfig_70772_Name = {
    Text = "<WhiteQuality:Cartera nueva>"
  },
  RelicConfig_70772_StoryDesc = {
    Text = "Una billetera de cuero marcada con el emblema de la Universidad de Mitag.  \nAhora está vacía, sin nada dentro"
  },
  RelicConfig_70774_BattleDesc = {
    Text = "Los primeros cinco daños causados en cada turno aumentan en [Arg1]%."
  },
  RelicConfig_70774_Desc = {
    Text = "Los primeros cinco daños causados en cada turno aumentan en [Arg1]%."
  },
  RelicConfig_70774_Name = {
    Text = "<WhiteQuality:Corrector de visión>"
  },
  RelicConfig_70774_StoryDesc = {
    Text = "Alguien una vez encontró la verdad a través de él"
  },
  RelicConfig_70776_BattleDesc = {
    Text = "Al comenzar la batalla, obtén [Arg1] <RetaliateIconKeywords:contraataque>. En la batalla contra el jefe, el efecto se duplica."
  },
  RelicConfig_70776_Desc = {
    Text = "Al comenzar la batalla, obtén [Arg1] <RetaliateIconKeywords:contraataque>. En la batalla contra el jefe, el efecto se duplica."
  },
  RelicConfig_70776_Name = {
    Text = "<WhiteQuality:Chaleco de ortiga>"
  },
  RelicConfig_70776_StoryDesc = {
    Text = "No se puede identificar el líquido contaminado"
  },
  RelicConfig_70777_BattleDesc = {
    Text = "Después de jugar 4 cartas de comando pertenecientes a Despertados diferentes en un mismo turno, todos los Despertados obtienen [Arg1] puntos de aliemus, con un enfriamiento de 3 turnos."
  },
  RelicConfig_70777_Desc = {
    Text = "Después de jugar 4 cartas de comando pertenecientes a Despertados diferentes en un mismo turno, todos los Despertados obtienen [Arg1] puntos de aliemus, con un enfriamiento de 3 turnos."
  },
  RelicConfig_70777_Name = {
    Text = "<WhiteQuality:Velo del dios sin nombre>"
  },
  RelicConfig_70777_StoryDesc = {
    Text = "No mirar directamente a Dios"
  },
  RelicConfig_70778_BattleDesc = {
    Text = "Al comenzar la batalla, aplica [Arg1] capas de <IntoxicationIconKeywords:veneno> a todos los enemigos. En la batalla contra el jefe, el efecto se duplica."
  },
  RelicConfig_70778_Desc = {
    Text = "Al comenzar la batalla, aplica [Arg1] capas de <IntoxicationIconKeywords:veneno> a todos los enemigos. En la batalla contra el jefe, el efecto se duplica."
  },
  RelicConfig_70778_Name = {
    Text = "<OrangeQuality:Neurotoxina+>"
  },
  RelicConfig_70778_StoryDesc = {
    Text = "Extraer, refinar"
  },
  RelicConfig_70779_BattleDesc = {
    Text = "Después de usar el Despertar de la llave de plata, aplica [Arg1] capas de <IntoxicationIconKeywords:veneno> a todos los enemigos y obtén [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70779_Desc = {
    Text = "Después de usar el Despertar de la llave de plata, aplica [Arg1] capas de <IntoxicationIconKeywords:veneno> a todos los enemigos y obtén [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_70779_Name = {
    Text = "<WhiteQuality:Ungüento sospechoso>"
  },
  RelicConfig_70779_StoryDesc = {
    Text = "Alguna especie de ungüento para heridas casero, por favor no lo uses sin la supervisión de un doctor"
  },
  RelicConfig_70780_BattleDesc = {
    Text = "\"Golpe\" aplica un <IntoxicationIconKeywords:veneno> equivalente al [Arg1]% del daño causado, con un máximo de [Arg2] puntos por turno."
  },
  RelicConfig_70780_Desc = {
    Text = "\"Golpe\" aplica un <IntoxicationIconKeywords:veneno> equivalente al [Arg1]% del daño causado, con un máximo de [Arg2] puntos por turno."
  },
  RelicConfig_70780_Name = {
    Text = "<WhiteQuality:Lengua Alienígena>"
  },
  RelicConfig_70780_StoryDesc = {
    Text = "No es un demonio, pero sí transmite susurros de más allá del mundo"
  },
  RelicConfig_70781_BattleDesc = {
    Text = "Al inicio del turno, si la vida es inferior al 25%, obtén [Arg1] puntos de escudo."
  },
  RelicConfig_70781_Desc = {
    Text = "Al inicio del turno, si la vida es inferior al 25%, obtén [Arg1] puntos de escudo."
  },
  RelicConfig_70781_Name = {
    Text = "<OrangeQuality:Mano protectora+>"
  },
  RelicConfig_70781_StoryDesc = {
    Text = "Manos de bendición, puños firmes"
  },
  RelicConfig_70782_BattleDesc = {
    Text = "Cuando pierdes vida, obtienes un Horno Carmesí equivalente al [Arg1]% de la vida perdida."
  },
  RelicConfig_70782_Desc = {
    Text = "Cuando pierdes vida, obtienes un Horno Carmesí equivalente al [Arg1]% de la vida perdida."
  },
  RelicConfig_70782_Name = {
    Text = "<OrangeQuality:Sierra de Acero Oxidada+>"
  },
  RelicConfig_70782_StoryDesc = {
    Text = "El doctor de anatomía nunca ve a mujeres hermosas, solo un costal de huesos, nervios inflamados por enfermedades, músculos y tejidos"
  },
  RelicConfig_70783_BattleDesc = {
    Text = "Los primeros cinco daños causados en cada turno aumentan en [Arg1]%."
  },
  RelicConfig_70783_Desc = {
    Text = "Los primeros cinco daños causados en cada turno aumentan en [Arg1]%."
  },
  RelicConfig_70783_Name = {
    Text = "<OrangeQuality:Corrector de visión+>"
  },
  RelicConfig_70783_StoryDesc = {
    Text = "Alguien una vez encontró la verdad a través de él"
  },
  RelicConfig_70784_BattleDesc = {
    Text = "Cada vez que una carta entra en el espacio dimensional, si esta carta pertenece a un propietario diferente de las demás cartas en dicho espacio, coloca [Arg1] cartas <DerivativeCardKeywords_4:\"inspiración\"> en la mano."
  },
  RelicConfig_70784_Desc = {
    Text = "Cada vez que una carta entra en el espacio dimensional, si esta carta pertenece a un propietario diferente de las demás cartas en dicho espacio, coloca [Arg1] cartas <DerivativeCardKeywords_4:\"inspiración\"> en la mano."
  },
  RelicConfig_70784_Name = {
    Text = "<WhiteQuality:Artefacto de Alfonso>"
  },
  RelicConfig_70784_StoryDesc = {
    Text = "A diferencia del destino cambiante, las estrellas tienen sus propias leyes"
  },
  RelicConfig_70785_BattleDesc = {
    Text = "Después de jugar 4 cartas de comando pertenecientes a Despertados diferentes en un mismo turno, todos los Despertados obtienen [Arg1] puntos de aliemus, con un enfriamiento de 3 turnos."
  },
  RelicConfig_70785_Desc = {
    Text = "Después de jugar 4 cartas de comando pertenecientes a Despertados diferentes en un mismo turno, todos los Despertados obtienen [Arg1] puntos de aliemus, con un enfriamiento de 3 turnos."
  },
  RelicConfig_70785_Name = {
    Text = "<OrangeQuality:Velo del Dios Desconocido+>"
  },
  RelicConfig_70785_StoryDesc = {
    Text = "No mirar directamente a Dios"
  },
  RelicConfig_70786_BattleDesc = {
    Text = "Al final del turno, si estás en la postura de marea creciente, obtén [Arg1] <TentacleInjurieIconKeywords:daño de tentáculo>. Tiene un tiempo de enfriamiento de 3 turnos."
  },
  RelicConfig_70786_Desc = {
    Text = "Al final del turno, si estás en la postura de marea creciente, obtén [Arg1] <TentacleInjurieIconKeywords:daño de tentáculo>. Tiene un tiempo de enfriamiento de 3 turnos."
  },
  RelicConfig_70786_Name = {
    Text = "<WhiteQuality:Parásito>"
  },
  RelicConfig_70786_StoryDesc = {
    Text = "Mientras nuestro cerebro siga siendo un misterio, no hay nada sorprendente en que esté lleno de tentáculos"
  },
  RelicConfig_70787_BattleDesc = {
    Text = "El daño base causado por todos los Despertados aumenta un [Arg1]%."
  },
  RelicConfig_70787_Desc = {
    Text = "El daño base causado por todos los Despertados aumenta un [Arg1]%."
  },
  RelicConfig_70787_Name = {
    Text = "<OrangeQuality:Pipa llorona+>"
  },
  RelicConfig_70787_StoryDesc = {
    Text = "¿Es esto el fruto del odio o el resultado de la venganza?"
  },
  RelicConfig_70788_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, todos los Despertados obtienen [Arg1] puntos de Locura y [Arg2] puntos de energía de llave de plata."
  },
  RelicConfig_70788_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, todos los Despertados obtienen [Arg1] puntos de Locura y [Arg2] puntos de energía de llave de plata."
  },
  RelicConfig_70788_Name = {
    Text = "<WhiteQuality:Gemelos de laurel>"
  },
  RelicConfig_70788_StoryDesc = {
    Text = "Gemelos de plata con diseño de laureles.\nEstá bien hecho y brillante, simbolizando una antigua amistad de dos niños"
  },
  RelicConfig_70789_BattleDesc = {
    Text = "Tras el inicio de la batalla, obtén [Arg1] <ProficientInRealmsIconKeywords:maestría en reinos>. El <IntoxicationIconKeywords:veneno> causado por todos los Despertados y el <IntoxicationIconKeywords:veneno> causado por las creaciones aumenta un [Arg2]%."
  },
  RelicConfig_70789_Desc = {
    Text = "Tras el inicio de la batalla, obtén [Arg1] <ProficientInRealmsIconKeywords:maestría en reinos>. El <IntoxicationIconKeywords:veneno> causado por todos los Despertados y el <IntoxicationIconKeywords:veneno> causado por las creaciones aumenta un [Arg2]%."
  },
  RelicConfig_70789_Name = {
    Text = "<WhiteQuality:Máquina de coser polvorienta>"
  },
  RelicConfig_70789_StoryDesc = {
    Text = "Una madre cariñosa, remendando las heridas del corazón"
  },
  RelicConfig_70790_BattleDesc = {
    Text = "Aniquilación hace que el cuerpo despertado con menos locura obtenga [Arg1] puntos de locura, 3 turnos de enfriamiento."
  },
  RelicConfig_70790_Desc = {
    Text = "Aniquilación hace que el cuerpo despertado con menos locura obtenga [Arg1] puntos de locura, 3 turnos de enfriamiento."
  },
  RelicConfig_70790_Name = {
    Text = "<OrangeQuality:Gusano del tiempo+>"
  },
  RelicConfig_70790_StoryDesc = {
    Text = "Un reloj de bolsillo que existe simultáneamente en una tienda de relojes y en un museo de insectos.\nDespués del primer año de la era Holocénica, fue incluido en la colección universitaria"
  },
  RelicConfig_70791_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de tentáculos aumenta en [Arg1], obtén [Arg2] tentáculos."
  },
  RelicConfig_70791_Desc = {
    Text = "Al comenzar la batalla, el límite de tentáculos aumenta en [Arg1], obtén [Arg2] tentáculos."
  },
  RelicConfig_70791_Name = {
    Text = "<OrangeQuality:Canción del Mar+>"
  },
  RelicConfig_70791_StoryDesc = {
    Text = "Se dice que animales no comestibles como el caracol de tejido absorben alrededor del 80% de los nutrientes del océano"
  },
  RelicConfig_70792_BattleDesc = {
    Text = "Al final del turno, si estás en la postura de marea creciente, obtén [Arg1] <TentacleInjurieIconKeywords:daño de tentáculo>. Tiene un tiempo de enfriamiento de 3 turnos."
  },
  RelicConfig_70792_Desc = {
    Text = "Al final del turno, si estás en la postura de marea creciente, obtén [Arg1] <TentacleInjurieIconKeywords:daño de tentáculo>. Tiene un tiempo de enfriamiento de 3 turnos."
  },
  RelicConfig_70792_Name = {
    Text = "<OrangeQuality:Parásito+>"
  },
  RelicConfig_70792_StoryDesc = {
    Text = "Mientras nuestro cerebro siga siendo un misterio, no hay nada sorprendente en que esté lleno de tentáculos"
  },
  RelicConfig_70793_BattleDesc = {
    Text = "Cada vez que se realiza una <DevouredIconKeywords:devoración> por primera vez en el turno, los demás Despertados obtienen [Arg1] puntos de locura."
  },
  RelicConfig_70793_Desc = {
    Text = "Cada vez que se realiza una <DevouredIconKeywords:devoración> por primera vez en el turno, los demás Despertados obtienen [Arg1] puntos de locura."
  },
  RelicConfig_70793_Name = {
    Text = "<OrangeQuality:Ensueño Dorado+>"
  },
  RelicConfig_70793_StoryDesc = {
    Text = "El día de tu transformación será tu fin"
  },
  RelicConfig_70794_BattleDesc = {
    Text = "Aniquilación: Obtener [Arg1] escudos, 3 turnos de enfriamiento."
  },
  RelicConfig_70794_Desc = {
    Text = "Aniquilación: Obtener [Arg1] escudos, 3 turnos de enfriamiento."
  },
  RelicConfig_70794_Name = {
    Text = "<OrangeQuality:Reloj hipercuerda+>"
  },
  RelicConfig_70794_StoryDesc = {
    Text = "\"Vaya, el reloj se detuvo.\""
  },
  RelicConfig_70795_BattleDesc = {
    Text = "Después de jugar una carta de comando no derivada, baraja [Arg1] copias temporales de esa carta con un costo de aritmética reducido en 2 en el mazo de robar, con un enfriamiento de 3 turnos."
  },
  RelicConfig_70795_Desc = {
    Text = "Después de jugar una carta de comando no derivada, baraja [Arg1] copias temporales de esa carta con un costo de aritmética reducido en 2 en el mazo de robar, con un enfriamiento de 3 turnos."
  },
  RelicConfig_70795_Name = {
    Text = "<WhiteQuality:Gramófono mudo>"
  },
  RelicConfig_70795_StoryDesc = {
    Text = "Su voz se perdió en el viento"
  },
  RelicConfig_70796_BattleDesc = {
    Text = "Tras usar \"Exaltar,\" todos los enemigos reciben [Arg1] de <FixedDamage:DMG Puro> y activan [Arg2]% de <IntoxicationIconKeywords:Veneno>."
  },
  RelicConfig_70796_Desc = {
    Text = "Tras usar \"Exaltar,\" todos los enemigos reciben 1 instancia de <FixedDamage:DMG Puro> igual al [Arg2]% del PV Max del equipo y activan [Arg2]% de <IntoxicationIconKeywords:Veneno>."
  },
  RelicConfig_70796_Name = {
    Text = "<OrangeQuality:Mandíbula Láser+>"
  },
  RelicConfig_70796_StoryDesc = {
    Text = "Huesos exhibidos en la galería privada de un coleccionista.\nEl coleccionista estaba fascinado por su hermoso brillo, lo admiraba día y noche, hasta que murió y se convirtió en uno de ellos"
  },
  RelicConfig_70797_BattleDesc = {
    Text = "Aumenta el límite de aritmética máxima en [Arg1]"
  },
  RelicConfig_70797_Desc = {
    Text = "Aumenta el límite de aritmética máxima en [Arg1]"
  },
  RelicConfig_70797_Name = {
    Text = "<WhiteQuality: inyector activo>"
  },
  RelicConfig_70797_StoryDesc = {
    Text = "Los espasmos también son una forma de actividad"
  },
  RelicConfig_70798_BattleDesc = {
    Text = "Usa la postura de Olas Furiosas para activar inmediatamente todos los tentáculos y atacar al enemigo [Arg1] veces. Tiene un enfriamiento de 3 turnos."
  },
  RelicConfig_70798_Desc = {
    Text = "Usa la postura de Olas Furiosas para activar inmediatamente todos los tentáculos y atacar al enemigo [Arg1] veces. Tiene un enfriamiento de 3 turnos."
  },
  RelicConfig_70798_Name = {
    Text = "<OrangeQuality:Placer de la Espiral+>"
  },
  RelicConfig_70798_StoryDesc = {
    Text = "Señor del sueño eterno, espera tu entrada en el sueño"
  },
  RelicConfig_70799_BattleDesc = {
    Text = "Al usar DEF, obtienes [Arg1] puntos de <RetaliateIconKeywords:contraataque> temporal, con un máximo de 3 activaciones por turno."
  },
  RelicConfig_70799_Desc = {
    Text = "Al usar DEF, obtienes [Arg1] puntos de <RetaliateIconKeywords:contraataque> temporal, con un máximo de 3 activaciones por turno."
  },
  RelicConfig_70799_Name = {
    Text = "<OrangeQuality:Reloj de bolsillo antiguo+>"
  },
  RelicConfig_70799_StoryDesc = {
    Text = "Con nostalgia y tristeza, avanzamos hacia lo desconocido"
  },
  RelicConfig_70800_BattleDesc = {
    Text = "Al usar DEF, obtienes [Arg1] puntos de <RetaliateIconKeywords:contraataque> temporal, con un máximo de 3 activaciones por turno."
  },
  RelicConfig_70800_Desc = {
    Text = "Al usar DEF, obtienes [Arg1] puntos de <RetaliateIconKeywords:contraataque> temporal, con un máximo de 3 activaciones por turno."
  },
  RelicConfig_70800_Name = {
    Text = "<WhiteQuality:Reloj de bolsillo antiguo>"
  },
  RelicConfig_70800_StoryDesc = {
    Text = "Con nostalgia y tristeza, avanzamos hacia lo desconocido"
  },
  RelicConfig_70986_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los Despertados. Al inicio de turnos impares, elige 1 de entre 2 reliquias para obtenerla, efecto continuo durante 5 turnos impares."
  },
  RelicConfig_70986_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los Despertados. Al inicio de turnos impares, elige 1 de entre 2 reliquias para obtenerla, efecto continuo durante 5 turnos impares."
  },
  RelicConfig_70986_Name = {
    Text = "<OrangeQuality:péndulo crono\"Deseo η\">"
  },
  RelicConfig_70987_BattleDesc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los Despertados. Al inicio de turnos impares, elige 1 de entre 2 reliquias para obtenerla, efecto continuo durante 5 turnos impares."
  },
  RelicConfig_70987_Desc = {
    Text = "Al comenzar la batalla, el límite de aritmética +1, despierta a todos los Despertados. Al inicio de turnos impares, elige 1 de entre 2 reliquias para obtenerla, efecto continuo durante 5 turnos impares."
  },
  RelicConfig_70987_Name = {
    Text = "<OrangeQuality:péndulo crono\"Deseo ζ\">"
  },
  RelicConfig_71195_BattleDesc = {
    Text = "Al comenzar el turno, Ronda Ramona obtiene [Arg1] puntos de locura. La primera vez que se activa \"recorrido\" en cada turno, obtiene [Arg2] puntos de energía de llave de plata y [Arg3] capas de negentropía."
  },
  RelicConfig_71195_Desc = {
    Text = "Al comenzar el turno, Ronda Ramona obtiene [Arg1] puntos de locura. La primera vez que se activa \"recorrido\" en cada turno, obtiene [Arg2] puntos de energía de llave de plata y [Arg3] capas de negentropía."
  },
  RelicConfig_71195_Name = {
    Text = "<OrangeQuality:Imagen Dimensional: Anillo · Lamona>"
  },
  RelicConfig_71196_BattleDesc = {
    Text = "Al comienzo del turno, Lotan obtiene [Arg1] puntos de \"aliemus\". La primera vez que se juega una \"DEF\" de Lotan en cada turno, se añaden [Arg2] cartas de \"Espada Desafiante\" con costo adicional y vacío al azar a la mano."
  },
  RelicConfig_71196_Desc = {
    Text = "Al comienzo del turno, Lotan obtiene [Arg1] puntos de \"aliemus\". La primera vez que se juega una \"DEF\" de Lotan en cada turno, se añaden [Arg2] cartas de \"Espada Desafiante\" con costo adicional y vacío al azar a la mano."
  },
  RelicConfig_71196_Name = {
    Text = "<OrangeQuality:Imagen Dimensional · Lutan>"
  },
  RelicConfig_71197_BattleDesc = {
    Text = "Al comenzar el turno, Ramona obtiene [Arg1] puntos de locura. Cada vez que se juega la [Arg2]ª carta de comando de Ramona, esta carta tiene un efecto adicional y obtiene [Arg3] puntos de energía de llave de plata."
  },
  RelicConfig_71197_Desc = {
    Text = "Al comenzar el turno, Ramona obtiene [Arg1] puntos de locura. Cada vez que se juega la [Arg2]ª carta de comando de Ramona, esta carta tiene un efecto adicional y obtiene [Arg3] puntos de energía de llave de plata."
  },
  RelicConfig_71197_Name = {
    Text = "<OrangeQuality:Imagen Dimensional: Ramona>"
  },
  RelicConfig_71230_BattleDesc = {
    Text = "Al inicio del turno, Leigh obtiene [Arg1] Aliemus. Cada vez que pierde PV, obtiene [Arg2] puntos de Fortaleza, con un máximo de [Arg3] acumulaciones por combate. Tras acumular [Arg3] veces, el coste de Aritmética básico de \"Dolor y placer\" se reduce en 2 y el número de instancias de Daño aumenta en 1."
  },
  RelicConfig_71230_Desc = {
    Text = "Al inicio del turno, Leigh obtiene [Arg1] Aliemus. Cada vez que pierde PV, obtiene [Arg2] puntos de Fortaleza, con un máximo de [Arg3] acumulaciones por combate. Tras acumular [Arg3] veces, el coste de Aritmética básico de \"Dolor y placer\" se reduce en 2 y el número de instancias de Daño aumenta en 1."
  },
  RelicConfig_71230_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Leia>"
  },
  RelicConfig_71231_BattleDesc = {
    Text = "Al comenzar el turno, Aurita obtiene [Arg1] puntos de locura. Aumenta en [Arg2] el daño de \"División de glándulas\", y tras jugar una \"DEF\" de Aurita, se añade 1 carta de \"División de glándulas\" a la mano."
  },
  RelicConfig_71231_Desc = {
    Text = "Al comenzar el turno, Aurita obtiene [Arg1] puntos de locura. Aumenta en [Arg2] el daño de \"División de glándulas\", y tras jugar una \"DEF\" de Aurita, se añade 1 carta de \"División de glándulas\" a la mano."
  },
  RelicConfig_71231_Name = {
    Text = "<OrangeQuality:Imagen Dimensional · Oreta>"
  },
  RelicConfig_71232_BattleDesc = {
    Text = "Al comienzo del turno, Tinctura obtiene [Arg1] puntos de aliemus. Cuando las cartas de comando de Tinctura activan un salto, serán devueltas a la mano y su costo de aritmética se reduce en 1 antes de jugarlas, con un máximo de [Arg2] activaciones por turno."
  },
  RelicConfig_71232_Desc = {
    Text = "Al comienzo del turno, Tinctura obtiene [Arg1] puntos de aliemus. Cuando las cartas de comando de Tinctura activan un salto, serán devueltas a la mano y su costo de aritmética se reduce en 1 antes de jugarlas, con un máximo de [Arg2] activaciones por turno."
  },
  RelicConfig_71232_Name = {
    Text = "<OrangeQuality:Imagen Dimensional: Tinkter>"
  },
  RelicConfig_71233_BattleDesc = {
    Text = "Al inicio del turno, Nautila obtiene [Arg1] puntos de aliemus. Tras liberar la exaltación de Nautila, obtén un contraataque y un escudo diferido equivalentes al [Arg2]% del escudo actual, activándose una vez por turno como máximo."
  },
  RelicConfig_71233_Desc = {
    Text = "Al inicio del turno, Nautila obtiene [Arg1] puntos de Aliemus. Tras usar \"Exaltar\" de Nautila, obtén un Contrataque y un Escudo de latencia equivalentes al [Arg2]% del Blindaje actual, activándose una vez por turno como máximo."
  },
  RelicConfig_71233_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Nodira>"
  },
  RelicConfig_71234_BattleDesc = {
    Text = "Al comenzar el turno, Muñeca derretida obtiene [Arg1] puntos de aliemus. Después de que Muñeca derretida libere la exaltación, por cada [Arg2] puntos de aliemus consumidos, otros despertadores obtienen 1 punto de aliemus."
  },
  RelicConfig_71234_Desc = {
    Text = "Al comenzar el turno, Doll: Infierno obtiene [Arg1] puntos de Aliemus. Después de que Doll: Infierno libere Exaltar, por cada [Arg2] puntos de Aliemus consumidos, otros Cuerpo Despertados obtienen 1 punto de Aliemus."
  },
  RelicConfig_71234_Name = {
    Text = "<OrangeQuality:Imagen Dimensional: Fusión · Dor>"
  },
  RelicConfig_71235_BattleDesc = {
    Text = "Al inicio del turno, Helot obtiene [Arg1] puntos de locura. Cada vez que se descarta una carta, Helot obtiene [Arg2] puntos de locura adicionales."
  },
  RelicConfig_71235_Desc = {
    Text = "Al inicio del turno, Helot obtiene [Arg1] puntos de locura. Cada vez que se descarta una carta, Helot obtiene [Arg2] puntos de locura adicionales."
  },
  RelicConfig_71235_Name = {
    Text = "<OrangeQuality:Imagen Dimensional de Silo>"
  },
  RelicConfig_71236_BattleDesc = {
    Text = "Al comienzo del turno, Dafodil obtiene [Arg1] puntos de locura y 1 carta \"inspiración\". El poder obtenido por \"marea heterogénea\" aumenta en un [Arg2]%, y cada vez que se juega, aumenta permanentemente un [Arg3]% adicional durante la exploración actual, hasta un máximo de [Arg4]%."
  },
  RelicConfig_71236_Desc = {
    Text = "Al comienzo del turno, Dafodil obtiene [Arg1] puntos de locura y 1 carta \"inspiración\". El poder obtenido por \"marea heterogénea\" aumenta en un [Arg2]%, y cada vez que se juega, aumenta permanentemente un [Arg3]% adicional durante la exploración actual, hasta un máximo de [Arg4]%."
  },
  RelicConfig_71236_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Daphdel>"
  },
  RelicConfig_71237_BattleDesc = {
    Text = "Al comenzar el turno, Wanda obtiene [Arg1] puntos de alienación y  [Arg2] capas de \"onirismo\". Si el turno actual es un turno ultra, añade adicionalmente 1 cadena de agujas para columna vertebral temporal y 1 guardián de lo perdido temporal a la mano, y hace que la siguiente tarjeta de comando de Wanda tenga un efecto adicional de 2 veces."
  },
  RelicConfig_71237_Desc = {
    Text = "Al comenzar el turno, Wanda obtiene [Arg1] puntos de alienación y  [Arg2] capas de \"onirismo\". Si el turno actual es un turno ultra, añade 1 cadena de agujas para columna vertebral temporal y 1 guardián de lo perdido temporal a la mano, y hace que la siguiente tarjeta de comando de Wanda tenga un efecto adicional 2 veces."
  },
  RelicConfig_71237_Name = {
    Text = "<OrangeQuality:Imagen Dimensional: Wanda>"
  },
  RelicConfig_71238_BattleDesc = {
    Text = "Al comienzo del turno, Agrippa obtiene [Arg1] puntos de aliemus. \"La caridad impaciente\" también reduce en [Arg2] el coste de aritmética de Agrippa durante este turno, y solo puede surtir efecto una vez por turno."
  },
  RelicConfig_71238_Desc = {
    Text = "Al comienzo del turno, Agrippa obtiene [Arg1] puntos de aliemus. \"La caridad impaciente\" también reduce en [Arg2] el coste de aritmética de Agrippa durante este turno, y solo puede surtir efecto una vez por turno."
  },
  RelicConfig_71238_Name = {
    Text = "<OrangeQuality:Imagen Dimensional de Agripa>"
  },
  RelicConfig_71239_BattleDesc = {
    Text = "Al comienzo del turno, \"24\" obtiene [Arg1] de alienación. Si \"24\" está en \"Personalidad deprimida\" al comienzo del turno, obtiene [Arg2] de alienación adicional; si está en \"Personalidad maníaca\", aumenta la tasa de crítico temporal y el daño crítico temporal de \"24\" en [Arg2]%."
  },
  RelicConfig_71239_Desc = {
    Text = "Al comenzar el turno, \"24\" obtiene [Arg1] de alienación. Al comenzar el turno, si \"24\" está en \"Personalidad deprimida\", obtiene [Arg2] de alienación adicional; si está en \"Personalidad maníaca\", aumenta la probabilidad de crítico temporal y el daño crítico temporal de \"24\" en [Arg2]%."
  },
  RelicConfig_71239_Name = {
    Text = "<OrangeQuality:Imagen Dimensional: «24»>"
  },
  RelicConfig_71240_BattleDesc = {
    Text = "Al inicio del turno, Liz obtiene [Arg1] puntos de locura. \"Danza de la destrucción\": las cartas descartadas tienen 1 efecto adicional. Tiene un enfriamiento de 3 turnos."
  },
  RelicConfig_71240_Desc = {
    Text = "Al inicio del turno, Liz obtiene [Arg1] puntos de locura. \"Danza de la destrucción\": las cartas descartadas tienen 1 efecto adicional. Tiene un enfriamiento de 3 turnos."
  },
  RelicConfig_71240_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Liz>"
  },
  RelicConfig_71241_BattleDesc = {
    Text = "Al comienzo del turno, Helot-catena obtiene [Arg1] puntos de aliemus. El daño activo de Helot-catena aplica [Arg2]% de <BleedingIconKeywords:sangrando>, e inflige sangrado equivalente al daño sobrante a los otros enemigos al matar a uno."
  },
  RelicConfig_71241_Desc = {
    Text = "Al comienzo del turno, Helot: Catena obtiene [Arg1] puntos de Aliemus. El Daño Activo de Helot: Catena aplica [Arg2]% de Sangrar, e inflige Sangrar equivalente al daño sobrante a los otros enemigos al matar a uno."
  },
  RelicConfig_71241_Name = {
    Text = "<OrangeQuality:Imagen Dimensional - Helot-catena>"
  },
  RelicConfig_71242_BattleDesc = {
    Text = "Al comienzo del turno, Celeste obtiene [Arg1] puntos de Aliemus. Antes de que termine el turno, por cada Tarjeta de comando de Celeste en la mano, 1 Tentáculo ataca al enemigo y se recuperan [Heal:Arg2] PV."
  },
  RelicConfig_71242_Desc = {
    Text = "Al comienzo del turno, Celeste obtiene [Arg1] puntos de Aliemus. Antes de que termine el turno, por cada Tarjeta de comando de Celeste en la mano, 1 Tentáculo ataca al enemigo y se recuperan [Heal:Arg2] PV."
  },
  RelicConfig_71242_Name = {
    Text = "<OrangeQuality:Imagen Dimensional · Celeste>"
  },
  RelicConfig_71243_BattleDesc = {
    Text = "Al inicio del turno, Casiah obtiene [Arg1] puntos de locura. Cada vez que roba una carta, Casiah obtiene [Arg2] puntos adicionales de locura. Cuando Casiah libera su exaltación, todos los enemigos pierden [Arg3] puntos de fuerza."
  },
  RelicConfig_71243_Desc = {
    Text = "Al inicio del turno, Casiah obtiene [Arg1] puntos de locura. Cada vez que roba una carta, Casiah obtiene [Arg2] puntos adicionales de locura. Cuando Casiah libera su exaltación, todos los enemigos pierden [Arg3] puntos de fuerza."
  },
  RelicConfig_71243_Name = {
    Text = "<OrangeQuality:Imagen Dimensional de Cassia>"
  },
  RelicConfig_71244_BattleDesc = {
    Text = "Al comienzo del turno, Sorel obtiene [Arg1] puntos de Aliemus. Cada vez que Sorel causa daño, la Fusión Embrionaria aumenta en +[Arg2], activándose hasta [Arg3] <plural value=\"[Arg3]\" singular=\"vez\" plural=\"veces\"> por turno. Tras activarse 10 veces, el Daño Final de Sorel en esta batalla aumenta en +[Arg4]%."
  },
  RelicConfig_71244_Desc = {
    Text = "Al comienzo del turno, Sorel obtiene [Arg1] puntos de Aliemus. Cada vez que Sorel causa daño, la Fusión Embrionaria aumenta en +[Arg2], activándose hasta [Arg3] <plural value=\"[Arg3]\" singular=\"vez\" plural=\"veces\"> por turno. Tras activarse 10 veces, el Daño Final de Sorel en esta batalla aumenta en +[Arg4]%."
  },
  RelicConfig_71244_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Sorel>"
  },
  RelicConfig_71245_BattleDesc = {
    Text = "Al comenzar el turno, Ogier obtiene [Arg1] puntos de locura. Cada vez que Ogier juegue por primera vez \"Lanza Perforante\" o \"Golpe\" en el turno, aumenta en un [Arg2]% el escudo y la fuerza que Ogier proporciona durante ese turno."
  },
  RelicConfig_71245_Desc = {
    Text = "Al comenzar el turno, Ogier obtiene [Arg1] puntos de locura. Cada vez que Ogier juegue por primera vez \"Lanza Perforante\" o \"Golpe\" en el turno, aumenta en un [Arg2]% el escudo y la fuerza que Ogier proporciona durante ese turno."
  },
  RelicConfig_71245_Name = {
    Text = "<OrangeQuality:Imagen Dimensional de Ogier>"
  },
  RelicConfig_71246_BattleDesc = {
    Text = "Al comienzo del turno, Alva obtiene [Arg1] puntos de locura. Cuando Alva juega la [Arg2]ª carta de \"DEF\" dentro de un turno, añade a su mano 1 carta \"Hoja del Ojo Interior\" con costo; al jugar la [Arg3]ª carta de \"Golpe\", añade a su mano 1 carta \"Postura Preparatoria\" con costo."
  },
  RelicConfig_71246_Desc = {
    Text = "Al comienzo del turno, Alva obtiene [Arg1] puntos de locura. Cuando Alva juega la [Arg2]ª carta de \"DEF\" dentro de un turno, añade a su mano 1 carta \"Hoja del Ojo Interior\" con costo; al jugar la [Arg3]ª carta de \"Golpe\", añade a su mano 1 carta \"Postura Preparatoria\" con costo."
  },
  RelicConfig_71246_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Elva>"
  },
  RelicConfig_71247_BattleDesc = {
    Text = "Al inicio del turno, Jenkins obtiene [Arg1] puntos de locura y el daño final aumenta en [Arg2]%. El daño base y el daño infligido por \"¡Marrón, ataca!\" aumentan en [Arg3]%."
  },
  RelicConfig_71247_Desc = {
    Text = "Al inicio del turno, Jenkins obtiene [Arg1] puntos de locura y el daño final aumenta en [Arg2]%. El daño base y el daño infligido por \"¡Marrón, ataca!\" aumentan en [Arg3]%."
  },
  RelicConfig_71247_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Jenkin>"
  },
  RelicConfig_71248_BattleDesc = {
    Text = "Al comienzo del turno, Doal obtiene [Arg1] puntos de aliemus. Tras el inicio de la batalla, el costo de aritmética de \"Intercambio equivalente\" de Doal se reduce a 0, y al jugarla, en el próximo turno se robarán [Arg2] cartas adicionales."
  },
  RelicConfig_71248_Desc = {
    Text = "Al comienzo del turno, Doal obtiene [Arg1] puntos de aliemus. Tras el inicio de la batalla, el costo de aritmética de \"Intercambio equivalente\" de Doal se reduce a 0, y al jugarla, en el próximo turno se robarán [Arg2] cartas adicionales."
  },
  RelicConfig_71248_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Dor>"
  },
  RelicConfig_71249_BattleDesc = {
    Text = "Al inicio del turno, Ryker obtiene [Arg1] puntos de Aliemus. La primera tirada de dados de cada turno siempre obtiene el resultado máximo."
  },
  RelicConfig_71249_Desc = {
    Text = "Al inicio del turno, Ryker obtiene [Arg1] puntos de Aliemus. La primera tirada de dados de cada turno siempre obtiene el resultado máximo."
  },
  RelicConfig_71249_Name = {
    Text = "<OrangeQuality:Imagen Dimensional · Lyke>"
  },
  RelicConfig_71250_BattleDesc = {
    Text = "Al inicio del turno, Miriam obtiene [Arg1] puntos de locura y pone 1 carta de \"Sagrado\" en la mano."
  },
  RelicConfig_71250_Desc = {
    Text = "Al inicio del turno, Miriam obtiene [Arg1] puntos de locura y pone 1 carta de \"Sagrado\" en la mano."
  },
  RelicConfig_71250_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Miliam>"
  },
  RelicConfig_71251_BattleDesc = {
    Text = "Al inicio del turno, Bígaro obtiene [Arg1] puntos de aliemus. Cada vez que otro Despertado libere una exaltación, Bígaro obtiene [Arg2] puntos de aliemus y el costo de aritmética de \"Reconstrucción Mental\" en su mano se reduce en [Arg3]."
  },
  RelicConfig_71251_Desc = {
    Text = "Al inicio del turno, Bígaro obtiene [Arg1] puntos de aliemus. Cada vez que otro Despertado libere una exaltación, Bígaro obtiene [Arg2] puntos de aliemus y el costo de aritmética de \"Reconstrucción Mental\" en su mano se reduce en [Arg3]."
  },
  RelicConfig_71251_Name = {
    Text = "<OrangeQuality:Imagen Dimensional · Winkell>"
  },
  RelicConfig_71252_BattleDesc = {
    Text = "Al comienzo del turno, Tulu obtiene [Arg1] puntos de Aliemus. El Aliemus Base de Tulu se reduce en [Arg2] y al liberar Exaltar se generan inmediatamente [Arg3] Tentáculos Temporales."
  },
  RelicConfig_71252_Desc = {
    Text = "Al comienzo del turno, Tulu obtiene [Arg1] puntos de Aliemus. El Aliemus Base de Tulu se reduce en [Arg2] y al liberar Exaltar se generan inmediatamente [Arg3] Tentáculos Temporales."
  },
  RelicConfig_71252_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Turú>"
  },
  RelicConfig_71253_BattleDesc = {
    Text = "Al inicio del turno, Faint obtiene [Arg1] puntos de alienación. El blindaje, el contrataque y la recuperación de vida causados por Faint aumentan en [Arg2]%, cada vez que se activa la resistencia a la muerte, este efecto se incrementa en [Arg3]% durante esta exploración, hasta un máximo de [Arg4] activaciones."
  },
  RelicConfig_71253_Desc = {
    Text = "Al inicio del turno, Faint obtiene [Arg1] puntos de alienación. El blindaje, el contrataque y la recuperación de vida causados por Faint aumentan en [Arg2]%, y cada vez que se activa la resistencia a la muerte, este efecto aumenta en [Arg3]% durante esta exploración, con un máximo de [Arg4] activaciones."
  },
  RelicConfig_71253_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Fient>"
  },
  RelicConfig_71254_BattleDesc = {
    Text = "Al comenzar el turno, Tawil obtiene [Arg1] puntos de aliemus. Si durante el mismo turno se juegan [Arg2] cartas de comando de Tawil, se añade 1 carta \"llave de plata de luz\" a la mano. Tiene un tiempo de enfriamiento de [Arg3] turnos."
  },
  RelicConfig_71254_Desc = {
    Text = "Al comenzar el turno, Tawil obtiene [Arg1] puntos de aliemus. Si durante el mismo turno se juegan [Arg2] cartas de comando de Tawil, se añade 1 carta \"llave de plata de luz\" a la mano. Tiene un tiempo de enfriamiento de [Arg3] turnos."
  },
  RelicConfig_71254_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Tavi>"
  },
  RelicConfig_71255_BattleDesc = {
    Text = "Al inicio del turno, Hameln obtiene [Arg1] Aliemus. El coste de Aritmética básico de \"Obertura del alma\" se reduce en [Arg2] y el número de instancias de Daño básico aumenta en [Arg3]."
  },
  RelicConfig_71255_Desc = {
    Text = "Al inicio del turno, Hameln obtiene [Arg1] Aliemus. El coste de Aritmética básico de \"Obertura del alma\" se reduce en [Arg2] y el número de instancias de Daño básico aumenta en [Arg3]."
  },
  RelicConfig_71255_Name = {
    Text = "<OrangeQuality:Imagen Dimensional de Hamlin>"
  },
  RelicConfig_71256_BattleDesc = {
    Text = "Al inicio del turno, Horla obtiene [Arg1] puntos de aliemus. Al comenzar la batalla, obtiene [Arg2] capas de metáfora de todas las emociones, y el efecto de \"metáfora\" aumenta un 50%."
  },
  RelicConfig_71256_Desc = {
    Text = "Al inicio del turno, Horla obtiene [Arg1] puntos de aliemus. Al comenzar la batalla, obtiene [Arg2] capas de metáfora de todas las emociones, y el efecto de \"metáfora\" aumenta un 50%."
  },
  RelicConfig_71256_Name = {
    Text = "<OrangeQuality:Imagen Dimensional de Horla>"
  },
  RelicConfig_71257_BattleDesc = {
    Text = "Al comienzo del turno, Murphy obtiene [Arg1] puntos de locura. El \"golpe\" y la \"defensa\" de Murphy pueden convertir el [Arg2]% del \"sacrificio\" en daño de tentáculo temporal, pero solo pueden activarse una vez por turno."
  },
  RelicConfig_71257_Desc = {
    Text = "Al comienzo del turno, Murphy obtiene [Arg1] puntos de locura. El \"golpe\" y la \"defensa\" de Murphy pueden convertir el [Arg2]% del \"sacrificio\" en daño de tentáculo temporal, pero solo pueden activarse una vez por turno."
  },
  RelicConfig_71257_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Murphy>"
  },
  RelicConfig_71258_BattleDesc = {
    Text = "Al inicio del turno, Uvhash obtiene [Arg1] puntos de Aliemus. El Aliemus Base de Uvhash se reduce en [Arg2], y se reduce adicionalmente en 5 cada vez que libera Exaltar, pudiendo liberar Exaltar [Arg3] <plural value=\"[Arg3]\" singular=\"vez\" plural=\"veces\"> por turno."
  },
  RelicConfig_71258_Desc = {
    Text = "Al inicio del turno, Uvhash obtiene [Arg1] puntos de Aliemus. El Aliemus Base de Uvhash se reduce en [Arg2], y se reduce adicionalmente en 5 cada vez que libera Exaltar, pudiendo liberar Exaltar [Arg3] <plural value=\"[Arg3]\" singular=\"vez\" plural=\"veces\"> por turno."
  },
  RelicConfig_71258_Name = {
    Text = "<OrangeQuality:Imagen Dimensional de Uwahasi>"
  },
  RelicConfig_71259_BattleDesc = {
    Text = "Al comienzo del turno, Eigis obtiene [Arg1] puntos de locura. Cuando Eigis causa daño a un enemigo con <VulnerabilityIconKeywords:vulnerable>, también le roba [Arg2] puntos de fuerza temporal, activándose como máximo [Arg3] veces por turno."
  },
  RelicConfig_71259_Desc = {
    Text = "Al comienzo del turno, Eigis obtiene [Arg1] puntos de locura. Cuando Eigis causa daño a un enemigo con <VulnerabilityIconKeywords:vulnerable>, también le roba [Arg2] puntos de fuerza temporal, activándose como máximo [Arg3] veces por turno."
  },
  RelicConfig_71259_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Aegis>"
  },
  RelicConfig_71260_BattleDesc = {
    Text = "Al comenzar el turno, Thais obtiene [Arg1] puntos de locura. Cuando Thais juegue [Arg2] cartas de comando en un mismo turno, obtiene 1 carta \"Hijo Sagrado\" y [Arg3] puntos de fuerza temporales. Tiene un tiempo de enfriamiento de [Arg4] turnos."
  },
  RelicConfig_71260_Desc = {
    Text = "Al comenzar el turno, Thais obtiene [Arg1] puntos de locura. Cuando Thais juegue [Arg2] cartas de comando en un mismo turno, obtiene 1 carta \"Hijo Sagrado\" y [Arg3] puntos de fuerza temporales. Tiene un tiempo de enfriamiento de [Arg4] turnos."
  },
  RelicConfig_71260_Name = {
    Text = "<OrangeQuality:Imagen Dimensional · Tais>"
  },
  RelicConfig_71261_BattleDesc = {
    Text = "Al inicio del turno, Faros obtiene [Arg1] puntos de aliemus. Por cada 2 daños de tentáculo causados, aumenta en [Arg2]% el envenenamiento y el escudo generados por Faros en esta batalla, hasta un máximo del 50%."
  },
  RelicConfig_71261_Desc = {
    Text = "Al inicio del turno, Faros obtiene [Arg1] puntos de aliemus. Por cada 2 daños de tentáculo causados, aumenta en [Arg2]% el envenenamiento y el escudo generados por Faros en esta batalla, hasta un máximo del 50%."
  },
  RelicConfig_71261_Name = {
    Text = "<OrangeQuality:Imagen Dimensional de Falos>"
  },
  RelicConfig_71262_BattleDesc = {
    Text = "Al comenzar el turno, Pandia obtiene [Arg1] puntos de aliemus. Tras liberar la exhalación de aliemus, obtiene un <RetaliateIconKeywords:contraataque> permanente equivalente al [Arg2]% del contraataque temporal."
  },
  RelicConfig_71262_Desc = {
    Text = "Al comenzar el turno, Pandia obtiene [Arg1] puntos de aliemus. Tras liberar la exhalación de aliemus, obtiene un <RetaliateIconKeywords:contraataque> permanente equivalente al [Arg2]% del contraataque temporal."
  },
  RelicConfig_71262_Name = {
    Text = "<OrangeQuality:Imagen Dimensional · Pandia>"
  },
  RelicConfig_71263_BattleDesc = {
    Text = "Al inicio del turno, Lily gana [Arg1] Aliemus. El límite de Resistir de Lily aumenta un 100%. Cuando libera \"Flor sobre limo\" o \"Golpe para proteger,\" recupera el 8% de Vida de las acumulaciones de \"Resistir.\""
  },
  RelicConfig_71263_Desc = {
    Text = "Al inicio del turno, Lily gana [Arg1] Aliemus. El límite de Resistir de Lily aumenta un 100%. Cuando libera \"Flor sobre limo\" o \"Golpe para proteger,\" recupera el 8% de Vida de las acumulaciones de \"Resistir.\""
  },
  RelicConfig_71263_Name = {
    Text = "<OrangeQuality:Imagen Dimensional - Lili>"
  },
  RelicConfig_71264_BattleDesc = {
    Text = "Al comienzo del turno, Karen obtiene [Arg1] puntos de aliemus. Jugar \"Vigilia Silenciosa\" devuelve el doble del coste de aritmética consumido, con un enfriamiento de [Arg2] turnos."
  },
  RelicConfig_71264_Desc = {
    Text = "Al comienzo del turno, Karen obtiene [Arg1] puntos de aliemus. Jugar \"Vigilia Silenciosa\" devuelve el doble del coste de aritmética consumido, con un enfriamiento de [Arg2] turnos."
  },
  RelicConfig_71264_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Jalen>"
  },
  RelicConfig_71265_BattleDesc = {
    Text = "Al inicio del turno, Salvador obtiene [Arg1] puntos de locura. Cada vez que acumules el Horno Carmesí, también obtendrás un [Arg2]% del poder acumulado. Los ataques \"Golpe\" y \"Dolor que debe ser eliminado\" de Salvador reciben un bono adicional de poder equivalente a [Arg3] veces."
  },
  RelicConfig_71265_Desc = {
    Text = "Al inicio del turno, Salvador obtiene [Arg1] puntos de locura. Cada vez que acumules el Horno Carmesí, también obtendrás un [Arg2]% del poder acumulado. Los ataques \"Golpe\" y \"Dolor que debe ser eliminado\" de Salvador reciben un bono adicional de poder equivalente a [Arg3] veces."
  },
  RelicConfig_71265_Name = {
    Text = "<OrangeQuality:Imagen Dimensional de Salvador>"
  },
  RelicConfig_71266_BattleDesc = {
    Text = "Al inicio del turno, Caecus obtiene [Arg1] puntos de aliemus. Cuando Caecus obtiene un escudo, recupera vida equivalente al [Arg2]% del valor del escudo."
  },
  RelicConfig_71266_Desc = {
    Text = "Al inicio del turno, Caecus obtiene [Arg1] puntos de aliemus. Cuando Caecus obtiene un escudo, recupera vida equivalente al [Arg2]% del valor del escudo."
  },
  RelicConfig_71266_Name = {
    Text = "<OrangeQuality:Imagen Dimensional: Caiques>"
  },
  RelicConfig_71267_BattleDesc = {
    Text = "Al inicio del turno, Nymphaea obtiene [Arg1] puntos de Alienación. Tras jugar el \"golpear\" de Nymphaea, aumenta en [Arg2]% el veneno causado por Nymphaea en esta batalla, y tras jugar la \"DEF\" de Nymphaea, activa un [Arg3]% de veneno a todos los enemigos. Este efecto puede activarse una vez por turno como máximo."
  },
  RelicConfig_71267_Desc = {
    Text = "Al inicio del turno, Nymphaea obtiene [Arg1] puntos de Alienación. Tras jugar el \"golpear\" de Nymphaea, aumenta en [Arg2]% el veneno causado por Nymphaea en esta batalla. Tras jugar la \"DEF\" de Nymphaea, se activa un veneno del [Arg3]% en todos los enemigos. Este efecto puede activarse una vez por turno como máximo."
  },
  RelicConfig_71267_Name = {
    Text = "<OrangeQuality:Imagen Dimensional · Ningfia>"
  },
  RelicConfig_71268_BattleDesc = {
    Text = "Al comenzar el turno, Erika obtiene [Arg1] puntos de locura. Cuando Erika juega [Arg2] cartas de comando en un mismo turno, obtiene 2 puntos de aritmética y aumenta en 1 el bono de poder y alerta aplicado a \"Explosión electromagnética\" en esta batalla."
  },
  RelicConfig_71268_Desc = {
    Text = "Al comenzar el turno, Erika obtiene [Arg1] puntos de locura. Cuando Erika juega [Arg2] cartas de comando en un mismo turno, obtiene 2 puntos de aritmética y aumenta en 1 el bono de poder y alerta aplicado a \"Explosión electromagnética\" en esta batalla."
  },
  RelicConfig_71268_Name = {
    Text = "<OrangeQuality:Imagen Dimensional: Erika>"
  },
  RelicConfig_71269_BattleDesc = {
    Text = "Al comenzar el turno, Goliat obtiene [Arg1] puntos de locura. Si Goliat inflige daño [Arg2] veces en un mismo turno, el daño que cause Goliat en esta batalla recibirá un bono adicional de fuerza equivalente al 100%, con un tiempo de enfriamiento de 3 turnos."
  },
  RelicConfig_71269_Desc = {
    Text = "Al comenzar el turno, Goliat obtiene [Arg1] puntos de locura. Si Goliat inflige daño [Arg2] veces en un mismo turno, el daño que cause Goliat en esta batalla recibirá un bono adicional de fuerza equivalente al 100%, con un tiempo de enfriamiento de 3 turnos."
  },
  RelicConfig_71269_Name = {
    Text = "<OrangeQuality:Imagen Dimensional: Goliath>"
  },
  RelicConfig_71270_BattleDesc = {
    Text = "Al comenzar el turno, Shan obtiene [Arg1] puntos de locura. Al iniciar la batalla, todas las cartas de comando de Shan reciben Retenido, Preparado 1 y obtienen [Arg2] puntos de escudo."
  },
  RelicConfig_71270_Desc = {
    Text = "Al comenzar el turno, Shan obtiene [Arg1] puntos de locura. Al iniciar la batalla, todas las cartas de comando de Shan reciben Retenido, Preparado 1 y obtienen [Arg2] puntos de escudo."
  },
  RelicConfig_71270_Name = {
    Text = "<OrangeQuality:Imagen Dimensional · Shan>"
  },
  RelicConfig_71662_BattleDesc = {
    Text = "En los turnos pares, al inicio del turno, coloca 1 carta <DerivativeCardKeywords_105:\"Tesoro infinito de núcleos de plata\"> en la mano."
  },
  RelicConfig_71662_Desc = {
    Text = "En los turnos pares, al inicio del turno, coloca 1 carta <DerivativeCardKeywords_105:\"Tesoro infinito de núcleos de plata\"> en la mano."
  },
  RelicConfig_71662_Name = {
    Text = "<OrangeQuality:El Tesoro del Gato>"
  },
  RelicConfig_72226_BattleDesc = {
    Text = "Tamaño Máximo de la Mano +1. Al comenzar el turno, si no se ha realizado ninguna investigación, elige una investigación que no se haya llevado a cabo, al completar la investigación, obtén el resultado correspondiente de la investigación de Fusión·Doll. Al completar 3 investigaciones, coloca \"El fin de la ilusión\" en tu mano, esa reliquia se desactivará."
  },
  RelicConfig_72226_Desc = {
    Text = "Tamaño Máximo de la Mano +1. Al comenzar el turno, si no has realizado ninguna investigación actualmente, elige una investigación que no hayas completado y, al finalizarla, obtén el resultado correspondiente de investigación de Fusión·Doll. Al completar 3 investigaciones, coloca 1 carta de \"El fin de la ilusión\" en tu mano, y esa reliquia dejará de funcionar."
  },
  RelicConfig_72226_Name = {
    Text = "Fin del manuscrito de investigación"
  },
  RelicConfig_74832_BattleDesc = {
    Text = "Tamaño Máximo de la Mano +1. Al comenzar el turno, obtienes una tarjeta personalizada de \"Comercio tabú\", al jugar \"Comercio tabú\" podrás volver a activarlo en el siguiente turno. Al jugar diferentes tipos de \"Tarjeta de comando\" mientras tengas \"Comercio tabú\" en mano, se mejora el efecto correspondiente."
  },
  RelicConfig_74832_Desc = {
    Text = "Tamaño Máximo de la Mano +1. Al comenzar el turno, obtén una tarjeta personalizada de \"Comercio tabú\", al jugar \"Comercio tabú\" se puede volver a activar en el siguiente turno. Al jugar diferentes tipos de \"Tarjeta de comando\" mientras poseas \"Comercio tabú\", se mejorará el efecto correspondiente."
  },
  RelicConfig_74832_Name = {
    Text = "Invitación de mil espejismos"
  },
  RelicConfig_74832_StoryDesc = {
    Text = "Las palabras en la carta cambiaban constantemente, siempre convirtiéndose en un deseo irresistible."
  },
  RelicConfig_78664_BattleDesc = {
    Text = "Después de jugar 4 cartas de comando pertenecientes a Despertados diferentes en un mismo turno, el daño final causado por todos los Despertados aumenta en [Arg1]%, pero pierden [Arg2] puntos de Locura. Este efecto solo se activa una vez por turno."
  },
  RelicConfig_78664_Desc = {
    Text = "Después de jugar 4 cartas de comando pertenecientes a Despertados diferentes en un mismo turno, el daño final causado por todos los Despertados aumenta en [Arg1]%, pero pierden [Arg2] puntos de Locura. Este efecto solo se activa una vez por turno."
  },
  RelicConfig_78664_Name = {
    Text = "<RedQuality:Garra extraña>"
  },
  RelicConfig_78664_StoryDesc = {
    Text = "Especie irreconocible"
  },
  RelicConfig_78665_BattleDesc = {
    Text = "Al comienzo del turno, roba [Arg1] carta(s) menos. Al jugar cada carta con un consumo de aritmética real mayor o igual a [Arg2], obtén 1 punto de aritmética, con un máximo de [Arg3] activaciones por turno."
  },
  RelicConfig_78665_Desc = {
    Text = "Al comienzo del turno, roba [Arg1] carta(s) menos. Al jugar cada carta con un consumo de aritmética real mayor o igual a [Arg2], obtén 1 punto de aritmética, con un máximo de [Arg3] activaciones por turno."
  },
  RelicConfig_78665_Name = {
    Text = "<RedQuality:Campana de lamento>"
  },
  RelicConfig_78665_StoryDesc = {
    Text = "Ding ling, ding ling, el niño llora;\nDing ling, ding ling, el niño grita.\nDing ling, ding ling, el niño gime;\nDing ling, ding ling, tiene hambre, lo sabes"
  },
  RelicConfig_78666_BattleDesc = {
    Text = "Al comenzar el turno, obtienes [Arg1] puntos de contrataque. Después de liberar [Arg2] veces la explosión de aliemus en un turno, retira [Arg3]% de tu contrataque permanente, obteniendo un contrataque temporal del [Arg4]% de la cantidad retirada, con un enfriamiento de [Arg5] turnos."
  },
  RelicConfig_78666_Desc = {
    Text = "Al comenzar el turno, obtienes [Arg1] puntos de contrataque. Después de liberar [Arg2] veces la explosión de aliemus en un turno, elimina [Arg3]% de tu contrataque permanente, obtienes un contrataque temporal del [Arg4]% de la cantidad eliminada, con un enfriamiento de [Arg5] turnos."
  },
  RelicConfig_78666_Name = {
    Text = "<RedQuality:Cadáver del camino>"
  },
  RelicConfig_78666_StoryDesc = {
    Text = [[
Una parte sagrada.
Aunque separada del torso, sus huellas se han extendido por los mares]]
  },
  RelicConfig_78667_BattleDesc = {
    Text = "Tras la fase de robo, roba [Arg1] cartas adicionales y elige [Arg2] cartas de tu mano para descartar."
  },
  RelicConfig_78667_Desc = {
    Text = "Tras la fase de robo, roba [Arg1] cartas adicionales y elige [Arg2] cartas de tu mano para descartar."
  },
  RelicConfig_78667_Name = {
    Text = "<RedQuality: sombrero mágico>"
  },
  RelicConfig_78667_StoryDesc = {
    Text = "¡Bienvenido al circo de la señorita Casiah! Ten cuidado, no toques los objetos mágicos sin pensar. Si accidentalmente te muerden, eso sería un desastre. \n Después de todo, la última vez que probó la sangre, las consecuencias fueron realmente terroríficas. \n\n El sombrero parpadeó, como si estuviera a punto de salir de su capullo."
  },
  RelicConfig_78668_BattleDesc = {
    Text = "Después de usar Keyflare Rouse, elige [Arg1] Tarjeta de Comando Innata correspondiente a ese Cuerpo Despertado en tu mano. Agota esa carta para colocar [Arg2] Copia Base de ella en el Mazo de robo, la mano y el Mazo de Descarte respectivamente."
  },
  RelicConfig_78668_Desc = {
    Text = "Después de usar Keyflare Rouse, elige [Arg1] Tarjeta de Comando Innata correspondiente a ese Cuerpo Despertado en tu mano. Agota esa carta para colocar [Arg2] Copia Base de ella en el Mazo de robo, la mano y el Mazo de Descarte respectivamente."
  },
  RelicConfig_78668_Name = {
    Text = "<RedQuality:Impresión de jade>"
  },
  RelicConfig_78668_StoryDesc = {
    Text = "Esta impresión es inmortal"
  },
  RelicConfig_78669_BattleDesc = {
    Text = "Al inicio de la batalla, obtén [Arg1] puntos de fuerza. Al inicio de cada turno, por cada [Arg2] puntos de fuerza permanente, obtén [Arg3] puntos de fuerza temporal, hasta un máximo de [Arg4] puntos de fuerza temporal, y al final del turno pierdes la mitad del escudo obtenido de esta creación."
  },
  RelicConfig_78669_Desc = {
    Text = "Al inicio de la batalla, obtén [Arg1] puntos de fuerza. Al inicio de cada turno, por cada [Arg2] puntos de fuerza permanente, obtén [Arg3] puntos de fuerza temporal, hasta un máximo de [Arg4] puntos de fuerza temporal, y al final del turno pierdes la mitad del escudo obtenido de esta creación."
  },
  RelicConfig_78669_Name = {
    Text = "<RedQuality:Pájaro del ritual de la fatalidad>"
  },
  RelicConfig_78669_StoryDesc = {
    Text = "Un cadáver seco emitió un chillido"
  },
  RelicConfig_78670_BattleDesc = {
    Text = "Todos los Despertados aumentan su daño base en [Arg1]%, y este aumento se incrementa adicionalmente en [Arg2]% cada vez que se reinicia el mazo, pero se agrega 1 carta \"tambalearse\" a la mano, con un límite máximo de aumento de [Arg3]%."
  },
  RelicConfig_78670_Desc = {
    Text = "Todos los Despertados aumentan su daño base en [Arg1]%, y este aumento se incrementa adicionalmente en [Arg2]% cada vez que se reinicia el mazo, pero se agrega 1 carta \"tambalearse\" a la mano, con un límite máximo de aumento de [Arg3]%."
  },
  RelicConfig_78670_Name = {
    Text = "<RedQuality:Vela negra>"
  },
  RelicConfig_78670_StoryDesc = {
    Text = "Quema la lucidez, cae en la ilusión"
  },
  RelicConfig_78671_BattleDesc = {
    Text = "Al inicio del turno, Fusión Embrionaria +[Arg1]. Las cartas de \"Embrión\" serán descartadas al final del turno."
  },
  RelicConfig_78671_Desc = {
    Text = "Al inicio del turno, Fusión Embrionaria +[Arg1]. Las cartas de \"Embrión\" serán descartadas al final del turno."
  },
  RelicConfig_78671_Name = {
    Text = "<RedQuality:Cordón umbilical que se retuerce>"
  },
  RelicConfig_78671_StoryDesc = {
    Text = "Enredado en el cuello"
  },
  RelicConfig_78672_BattleDesc = {
    Text = "Al inicio del turno, sufre [Arg2] capas de veneno, y por cada espacio vacío en el espacio dimensional, obtén [Arg1] puntos de fuerza."
  },
  RelicConfig_78672_Desc = {
    Text = "Al inicio del turno, sufre [Arg2] capas de veneno, y por cada espacio vacío en el espacio dimensional, obtén [Arg1] puntos de fuerza."
  },
  RelicConfig_78672_Name = {
    Text = "<RedQuality:Conciencia del enjambre>"
  },
  RelicConfig_78672_StoryDesc = {
    Text = "Entretejer, simbiosis, agrupación; miedo, lo desconocido, control"
  },
  RelicConfig_78673_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, consume [Arg1] puntos de energía-s de llave de plata adicionalmente, haciendo que el coste de aritmética de las cartas de despertar de gnosis obtenidas sea 0, y al jugarlas, otorga al Despertado correspondiente [Arg2] puntos de alienación adicionales."
  },
  RelicConfig_78673_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, consume [Arg1] puntos de energía-s de llave de plata adicional para que el coste de aritmética de las cartas de despertar de gnosis obtenidas sea 0, y al jugarlas, el Despertado correspondiente obtiene [Arg2] puntos de alienación adicionales."
  },
  RelicConfig_78673_Name = {
    Text = "<RedQuality:Inscripción de conciencia>"
  },
  RelicConfig_78673_StoryDesc = {
    Text = "La antigua tribu creía que grabar símbolos especiales en la cabeza de los muertos podía retener su alma y obtener su compañía eterna"
  },
  RelicConfig_78674_BattleDesc = {
    Text = "Al comenzar la batalla, inflige [Arg1] puntos de veneno a todos los enemigos. Al inicio del turno, elimina [Arg2]% del veneno de los enemigos y aplica un sangrado equivalente al [Arg3]% eliminado."
  },
  RelicConfig_78674_Desc = {
    Text = "Al comenzar la batalla, inflige [Arg1] puntos de veneno a todos los enemigos. Al inicio del turno, elimina [Arg2]% del veneno de los enemigos y aplica un sangrado equivalente al [Arg3]% eliminado."
  },
  RelicConfig_78674_Name = {
    Text = "<RedQuality:Extremidad de alivio>"
  },
  RelicConfig_78674_StoryDesc = {
    Text = "Una parte sagrada.\nAunque separada del torso, aún se siente su calidez"
  },
  RelicConfig_78675_BattleDesc = {
    Text = "Al inicio del turno, si tienes más de [Arg1] tentáculos permanentes, pierdes [Arg2] tentáculos y obtienes [Arg3] tentáculos temporales; de lo contrario, obtienes [Arg4] tentáculos permanentes."
  },
  RelicConfig_78675_Desc = {
    Text = "Al inicio del turno, si tienes más de [Arg1] tentáculos permanentes, pierdes [Arg2] tentáculos y obtienes [Arg3] tentáculos temporales; de lo contrario, obtienes [Arg4] tentáculos permanentes."
  },
  RelicConfig_78675_Name = {
    Text = "<RedQuality:Brazo sagrado del dolor>"
  },
  RelicConfig_78675_StoryDesc = {
    Text = "Disfruta el sufrimiento"
  },
  RelicConfig_79408_BattleDesc = {
    Text = "Tamaño Máximo de la Mano + 2, Robar +2. \"Recuerdos Claros\" comienza en 5 capas, jugar cartas con marcas hará que \"Recuerdos Claros\" cambie. Cuando \"Recuerdos Claros\" esté por debajo de 5, por cada punto que baje, el Daño Final aumentará un 10%, y el blindaje y la curación disminuirán un 5%; cuando \"Recuerdos Claros\" esté por encima de 5, por cada punto que suba, el blindaje y la curación aumentarán un 5%, y el Daño Final disminuirá un 10%."
  },
  RelicConfig_79408_Desc = {
    Text = "Tamaño Máximo de la Mano +2, Robar +2. \"Recuerdos Claros\" comienza con 5 capas, jugar cartas marcadas hará que \"Recuerdos Claros\" cambie. Cuando \"Recuerdos Claros\" esté por debajo de 5, por cada punto que baje, el Daño Final aumenta en un 10%, y el Blindaje y la recuperación de PV disminuyen en un 5%; cuando \"Recuerdos Claros\" esté por encima de 5, por cada punto que suba, el Blindaje y la recuperación de PV aumentan en un 5%, y el Daño Final disminuye en un 10%."
  },
  RelicConfig_79408_Name = {
    Text = "\"Memoria\" y \"sueño\""
  },
  RelicConfig_79408_StoryDesc = {
    Text = "\"Ven, escúchame.\"\n\"Déjame transformar tus recuerdos y sueños.\"\n\"En un postre increíblemente delicioso.\""
  },
  RelicConfig_80340_BattleDesc = {
    Text = "Al inicio del turno, Clementine obtiene [Arg1] puntos de aliemus. El número de efectos de daño, escudo, recuperación de vida, obtención de aliemus y obtención de energía de llave de plata de todas las cartas de comando de Clementine aumenta en 1."
  },
  RelicConfig_80340_Desc = {
    Text = "Al inicio del turno, Clementine obtiene [Arg1] puntos de aliemus. El número de efectos de daño, escudo, recuperación de vida, obtención de aliemus y obtención de energía de llave de plata de todas las cartas de comando de Clementine aumenta en 1."
  },
  RelicConfig_80340_Name = {
    Text = "<OrangeQuality:Imagen Dimensional · Clemantine>"
  },
  RelicConfig_83509_BattleDesc = {
    Text = "Al comenzar la exploración, el límite de reliquias +1, los Despertados del dominio «Mar Profundo» obtienen su «Imagen Dimensional». Por cada Despertado del dominio «Mar Profundo» en el grupo, el límite de reliquias aumenta en +1."
  },
  RelicConfig_83509_Desc = {
    Text = "Al comenzar la exploración, el límite de reliquias +1, los Despertados del dominio «Mar Profundo» obtienen su «Imagen Dimensional». Por cada Despertado del dominio «Mar Profundo» en el grupo, el límite de reliquias aumenta en +1."
  },
  RelicConfig_83509_Name = {
    Text = "<OrangeQuality:«Anillo del Mar Profundo»>"
  },
  RelicConfig_83509_StoryDesc = {
    Text = "\"Cambió la historia.\""
  },
  RelicConfig_83510_BattleDesc = {
    Text = "Al comenzar la exploración, el límite de reliquias +1, los Despertados del dominio \"Carne\" obtienen su \"Imagen Dimensional\". Por cada Despertado del dominio \"Carne\" en el grupo, el límite de reliquias +1."
  },
  RelicConfig_83510_Desc = {
    Text = "Al comenzar la exploración, el límite de reliquias +1, los Despertados del dominio \"Carne\" obtienen su \"Imagen Dimensional\". Por cada Despertado del dominio \"Carne\" en el grupo, el límite de reliquias +1."
  },
  RelicConfig_83510_Name = {
    Text = "<OrangeQuality:«Anillo de Carne y Hueso»>"
  },
  RelicConfig_83510_StoryDesc = {
    Text = "Nunca he sido débil, ya he ascendido."
  },
  RelicConfig_83511_BattleDesc = {
    Text = "Al comenzar la exploración, el límite de reliquias aumenta en +1 y los Despertados del dominio «Ultra» obtienen su «Imagen Dimensional». Por cada Despertado del dominio «Ultra» en el grupo, el límite de reliquias aumenta en +1."
  },
  RelicConfig_83511_Desc = {
    Text = "Al comenzar la exploración, el límite de reliquias aumenta en +1 y los Despertados del dominio «Ultra» obtienen su «Imagen Dimensional». Por cada Despertado del dominio «Ultra» en el grupo, el límite de reliquias aumenta en +1."
  },
  RelicConfig_83511_Name = {
    Text = "<OrangeQuality:«Aro Hipersimensional»>"
  },
  RelicConfig_83511_StoryDesc = {
    Text = "No esperó el rescate"
  },
  RelicConfig_83512_BattleDesc = {
    Text = "Al comenzar la exploración, el límite de reliquias +1, los Despertados del dominio \"Caos\" obtienen su \"Imagen Dimensional\". Por cada Despertado del dominio \"Caos\" en el grupo, el límite de reliquias +1."
  },
  RelicConfig_83512_Desc = {
    Text = "Al comenzar la exploración, el límite de reliquias +1, los Despertados del dominio \"Caos\" obtienen su \"Imagen Dimensional\". Por cada Despertado del dominio \"Caos\" en el grupo, el límite de reliquias +1."
  },
  RelicConfig_83512_Name = {
    Text = "<OrangeQuality:«Aro del Caos»>"
  },
  RelicConfig_83512_StoryDesc = {
    Text = "Solo te guiará por el camino equivocado"
  },
  RelicConfig_83606_BattleDesc = {
    Text = "Tamaño Máximo de la Mano +1. Al comenzar el turno, si no tienes \"Decisión del Navegante\", colócala en tu mano. \nCada vez que el líder pierda el 10% de su PV Max inicial, obtén 1 capa de \"Levantar velas\", con un límite de 10 capas, y \"Levantar velas\" puede mejorar el efecto de \"Archor Off\". \nCada vez que pierdas el 10% de tu PV Max inicial, obtén 1 capa de \"Anclar\", con un límite de 10 capas, y \"Anclar\" puede mejorar el efecto de \"Descanso albergado\"."
  },
  RelicConfig_83606_Desc = {
    Text = "Tamaño Máximo de la Mano +1. Al comenzar el turno, si no tienes \"Decisión del Navegante\", colócala en tu mano. \nCada vez que el Líder pierda el 10% de su PV Max inicial, obtén 1 capa de \"Levantar velas\", con un límite de 10 capas. \"Levantar velas\" puede mejorar el efecto de \"Archor Off\". \nCada vez que pierdas el 10% de tu PV Max inicial, obtén 1 capa de \"Echar el ancla\", con un límite de 10 capas. \"Echar el ancla\" puede mejorar el efecto de \"Descanso albergado\"."
  },
  RelicConfig_83606_Name = {
    Text = "Guía de Erasmo"
  },
  RelicConfig_83606_StoryDesc = {
    Text = "El relámpago parpadeante guiará la dirección a seguir."
  },
  RelicConfig_84112_BattleDesc = {
    Text = "Al comienzo del turno, Agrippa obtiene [Arg1] puntos de aliemus. \"La caridad impaciente\" también reduce en [Arg2] el coste de aritmética de Agrippa durante este turno, y solo puede surtir efecto una vez por turno."
  },
  RelicConfig_84112_Desc = {
    Text = "Al comienzo del turno, Agrippa obtiene [Arg1] puntos de aliemus. \"La caridad impaciente\" también reduce en [Arg2] el coste de aritmética de Agrippa durante este turno, y solo puede surtir efecto una vez por turno."
  },
  RelicConfig_84112_Name = {
    Text = "<OrangeQuality:Imagen Dimensional de Agripa>"
  },
  RelicConfig_84113_BattleDesc = {
    Text = "Al inicio del turno, Caraboo obtiene [Arg1] Alienación. Las cartas de \"Bendición\" de Caraboo ofrecen 1 opción más al ser <FaxianKeywords:descubiertas>. El Exaltar de Caraboo inflige Acumulaciones de Corrosión iguales a la cantidad de daño infligido."
  },
  RelicConfig_84113_Desc = {
    Text = "Al inicio del turno, Caraboo obtiene [Arg1] Alienación. Las cartas de \"Bendición\" de Caraboo ofrecen 1 opción más al ser <FaxianKeywords:descubiertas>. El Exaltar de Caraboo inflige Acumulaciones de Corrosión iguales a la cantidad de daño infligido."
  },
  RelicConfig_84113_Name = {
    Text = "<OrangeQuality:Imagen Dimensional: Caraboo>"
  },
  RelicConfig_84114_BattleDesc = {
    Text = "Al inicio del turno, Pikeman gana [Arg1] Aliemus. Cada vez que se gana una acumulación de \"Inspiración,\" reduce aleatoriamente el agotamiento aritmético de 1 carta de mano por 1 este turno. Cuando Pikeman agote una \"Inspiración,\" todos los Despertadores ganan [Arg2] puntos de Aliemus."
  },
  RelicConfig_84114_Desc = {
    Text = "Al inicio del turno, Pikeman gana [Arg1] Aliemus. Cada vez que se gana una acumulación de \"Inspiración,\" reduce aleatoriamente el agotamiento aritmético de 1 carta de mano por 1 este turno. Cuando Pikeman agote una \"Inspiración,\" todos los Despertadores ganan [Arg2] puntos de Aliemus."
  },
  RelicConfig_84114_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Pikeman>"
  },
  RelicConfig_84116_BattleDesc = {
    Text = "Al comenzar el turno, Erika obtiene [Arg1] puntos de locura. Cuando Erika juega [Arg2] cartas de comando en un mismo turno, obtiene 2 puntos de aritmética y aumenta en 1 el bono de poder y alerta aplicado a \"Explosión electromagnética\" en esta batalla."
  },
  RelicConfig_84116_Desc = {
    Text = "Al comenzar el turno, Erika obtiene [Arg1] puntos de locura. Cuando Erika juega [Arg2] cartas de comando en un mismo turno, obtiene 2 puntos de aritmética y aumenta en 1 el bono de poder y alerta aplicado a \"Explosión electromagnética\" en esta batalla."
  },
  RelicConfig_84116_Name = {
    Text = "<OrangeQuality:Imagen Dimensional: Erika>"
  },
  RelicConfig_84117_BattleDesc = {
    Text = "Al comienzo de la ronda, Murphy: fauxborn gana [Arg1] locura. \"Vals Espiral\" se activa 3 veces cada 3 liberaciones."
  },
  RelicConfig_84117_Desc = {
    Text = "Al comienzo de la ronda, Murphy: fauxborn gana [Arg1] locura. \"Vals Espiral\" se activa 3 veces cada 3 liberaciones."
  },
  RelicConfig_84117_Name = {
    Text = "<OrangeQuality:imagen dimensional: murphy: fauxborn>"
  },
  RelicConfig_84118_BattleDesc = {
    Text = "Al inicio del turno, Casiah obtiene [Arg1] puntos de locura. Cada vez que roba una carta, Casiah obtiene [Arg2] puntos adicionales de locura. Cuando Casiah libera su exaltación, todos los enemigos pierden [Arg3] puntos de fuerza."
  },
  RelicConfig_84118_Desc = {
    Text = "Al inicio del turno, Casiah obtiene [Arg1] puntos de locura. Cada vez que roba una carta, Casiah obtiene [Arg2] puntos adicionales de locura. Cuando Casiah libera su exaltación, todos los enemigos pierden [Arg3] puntos de fuerza."
  },
  RelicConfig_84118_Name = {
    Text = "<OrangeQuality:Imagen Dimensional de Cassia>"
  },
  RelicConfig_84119_BattleDesc = {
    Text = "Al comienzo del turno, Murphy obtiene [Arg1] puntos de locura. El \"golpe\" y la \"defensa\" de Murphy pueden convertir el [Arg2]% del \"sacrificio\" en daño de tentáculo temporal, pero solo pueden activarse una vez por turno."
  },
  RelicConfig_84119_Desc = {
    Text = "Al comienzo del turno, Murphy obtiene [Arg1] puntos de locura. El \"golpe\" y la \"defensa\" de Murphy pueden convertir el [Arg2]% del \"sacrificio\" en daño de tentáculo temporal, pero solo pueden activarse una vez por turno."
  },
  RelicConfig_84119_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Murphy>"
  },
  RelicConfig_84121_BattleDesc = {
    Text = "Aracne obtiene [Arg1] puntos de Aliemus al inicio del turno. \"golpear\" y \"defensa\" activan inmediatamente 1 vez Buscar: \"Hilos infinitos\", como máximo 1 vez por turno cada uno."
  },
  RelicConfig_84121_Desc = {
    Text = "Aracne obtiene [Arg1] puntos de Aliemus al inicio del turno. \"golpear\" y \"defensa\" activan inmediatamente 1 vez Buscar: \"Hilos infinitos\", como máximo 1 vez por turno cada uno."
  },
  RelicConfig_84121_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Arachne>"
  },
  RelicConfig_84122_BattleDesc = {
    Text = "Al comienzo del turno, Tulu obtiene [Arg1] puntos de aliemus. El costo de locura de Tulu se reduce en [Arg2] puntos y al liberar una explosión de locura se generan inmediatamente [Arg3] tentáculos temporales."
  },
  RelicConfig_84122_Desc = {
    Text = "Al comienzo del turno, Tulu obtiene [Arg1] puntos de aliemus. El costo de locura de Tulu se reduce en [Arg2] puntos y al liberar una explosión de locura se generan inmediatamente [Arg3] tentáculos temporales."
  },
  RelicConfig_84122_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Turú>"
  },
  RelicConfig_84123_BattleDesc = {
    Text = "Al comienzo de la ronda, Pollux gana [Arg1] aliemus. Al inicio de la batalla, gana 1 \"Corazón Sagrado\", el \"Corazón Sagrado\" hará que todos los enemigos sean vulnerables en la 3ª consumo, y causará 2 veces daño."
  },
  RelicConfig_84123_Desc = {
    Text = "Al comienzo de la ronda, Pollux gana [Arg1] aliemus. Al inicio de la batalla, gana 1 \"Corazón Sagrado\", el \"Corazón Sagrado\" hará que todos los enemigos sean vulnerables en la 3ª consumo, y causará 2 veces daño."
  },
  RelicConfig_84123_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Póllux>"
  },
  RelicConfig_84124_BattleDesc = {
    Text = "Al inicio del turno, Hameln obtiene [Arg1] puntos de aliemus. El costo de aritmética de \"Obertura del Alma\" se reduce en [Arg2], y el número básico de daño aumenta en [Arg3]."
  },
  RelicConfig_84124_Desc = {
    Text = "Al inicio del turno, Hameln obtiene [Arg1] puntos de aliemus. El costo de aritmética de \"Obertura del Alma\" se reduce en [Arg2], y el número básico de daño aumenta en [Arg3]."
  },
  RelicConfig_84124_Name = {
    Text = "<OrangeQuality:Imagen Dimensional de Hamlin>"
  },
  RelicConfig_84125_BattleDesc = {
    Text = "Al inicio del turno, Katie Gula obtiene [Arg1] puntos de Aliemus. Tras acumular 10 Acumulaciones de \"llama viva\", se roba inmediatamente 1 Tarjeta de comando de Katie Gula y se le otorgan 3 Acumulaciones de \"llama viva\". Este efecto no acumulará más durante el resto de este turno."
  },
  RelicConfig_84125_Desc = {
    Text = "Al inicio del turno, Katie Gula obtiene [Arg1] puntos de Aliemus. Tras acumular 10 Acumulaciones de \"llama viva\", se roba inmediatamente 1 Tarjeta de comando de Katie Gula y se le otorgan 3 Acumulaciones de \"llama viva\". Este efecto no acumulará más durante el resto de este turno."
  },
  RelicConfig_84125_Name = {
    Text = "<OrangeQuality:Imagen Dimensional·Katie Gula>"
  },
  RelicConfig_84126_BattleDesc = {
    Text = "Al comenzar el turno, Castor obtiene [Arg1] puntos de locura. Al iniciar la batalla, coloca 2 cartas \"pluma negra\" en tu mano y, tras jugar por primera vez una carta \"pluma negra\" en el turno, obtén [Arg2] puntos de fuerza temporales."
  },
  RelicConfig_84126_Desc = {
    Text = "Al comenzar el turno, Castor obtiene [Arg1] puntos de locura. Al iniciar la batalla, coloca 2 cartas \"pluma negra\" en tu mano y, tras jugar por primera vez una carta \"pluma negra\" en el turno, obtén [Arg2] puntos de fuerza temporales."
  },
  RelicConfig_84126_Name = {
    Text = "<OrangeQuality:Imagen Dimensional · Castor>"
  },
  RelicConfig_84127_BattleDesc = {
    Text = "Al comienzo del turno, Cephas obtiene [Arg1] puntos de locura y gana 1 tentáculo temporal. Cada vez que se activa la resistencia a la muerte, Cephas obtiene [Arg2] puntos de locura y se añade a la mano 1 carta \"Trueno Castigador\" con costo de aritmética 0 y costo adicional."
  },
  RelicConfig_84127_Desc = {
    Text = "Al comienzo del turno, Cephas obtiene [Arg1] puntos de locura y gana 1 tentáculo temporal. Cada vez que se activa la resistencia a la muerte, Cephas obtiene [Arg2] puntos de locura y se añade a la mano 1 carta \"Trueno Castigador\" con costo de aritmética 0 y costo adicional."
  },
  RelicConfig_84127_Name = {
    Text = "<OrangeQuality:Imagen Dimensional de Kepersant>"
  },
  RelicConfig_89252_BattleDesc = {
    Text = "El límite de aritmética aumenta en 1, el número de robos por turno aumenta en 1, y al comenzar la batalla se obtiene [Arg1] capas de \"Cárceles del Destino\".\nCada capa de \"Cárceles del Destino\" reduce la locura generada por todos los Despertados en [Arg2]%, y cada vez que se libera la exaltación, se reduce 1 capa de \"Cárceles del Destino\". Después de que se eliminen todas las \"Cárceles del Destino\", todos los Despertados obtienen [Arg3] puntos de alienación y obtienen \"Corazón Inquebrantable\": la locura generada por todos los Despertados aumenta en [Arg4]%, y se puede liberar exaltación 2 veces por turno."
  },
  RelicConfig_89252_Desc = {
    Text = "El límite de aritmética aumenta en 1, el número de cartas robadas por turno aumenta en 1, y al comenzar la batalla, obtienes [Arg1] capas de \"Cárcel del Destino\".\nCada capa de \"Cárcel del Destino\" reduce la locura generada por todos los Despertados en [Arg2]%, y cada vez que se libera la exaltación, se reduce en 1 capa \"Cárcel del Destino\". Después de que todas las \"Cárceles del Destino\" sean eliminadas, todos los Despertados obtienen [Arg3] puntos de locura y obtienen \"Corazón Inquebrantable\": la locura generada por todos los Despertados aumenta en [Arg4]%, y pueden liberar la exaltación 2 veces por turno."
  },
  RelicConfig_89252_Name = {
    Text = "Pluma maldita"
  },
  RelicConfig_89252_StoryDesc = {
    Text = "Hoy en día, esta pluma ya no puede volar en el cielo."
  },
  RelicConfig_89645_BattleDesc = {
    Text = "Tamaño Máximo de la Mano +2, tras liberar la Exaltar, el Daño Final temporalmente aumenta un 10%.\nCuando una carta entra en el Espacio Hiperspacial, 1 \"Embrión\" en la mano se convierte en \"Vástago de la Pureza\".\nPor cada \"Embrión\" generado, el coste de Aritmética de una carta aleatoria en el Espacio Hiperspacial se reduce en 1."
  },
  RelicConfig_89645_Desc = {
    Text = "Tamaño Máximo de la Mano +2, tras liberar la Exaltar, el Daño Final temporalmente aumenta un 10%.\nCuando una carta entra en el Espacio Hiperspacial, 1 \"Embrión\" en la mano se transforma en \"Vástago de la Pureza\".\nPor cada \"Embrión\" generado, el Coste de Aritmética de una carta aleatoria en el Espacio Hiperspacial se reduce en 1."
  },
  RelicConfig_89645_Name = {
    Text = "Solución de sangre corrupta con hipercuerda"
  },
  RelicConfig_89646_BattleDesc = {
    Text = "Al inicio del turno, obtén 250 puntos de energía-s de llave de plata. \n Después de usar el Despertar de la Llave de Plata, coloca 1 carta \"Destello de llave de plata\" en tu mano. \n Al inicio de cada turno, descubre el apoyo de 1 Despertado."
  },
  RelicConfig_89646_Desc = {
    Text = "Al inicio del turno, obtén 250 puntos de energía-s de llave de plata. \n Después de usar el Despertar de la Llave de Plata, coloca 1 carta \"Destello de llave de plata\" en tu mano. \n Al inicio de cada turno, descubre el apoyo de 1 Despertado."
  },
  RelicConfig_89646_Name = {
    Text = "Tratamiento de evolución integrada"
  },
  RelicConfig_89647_BattleDesc = {
    Text = "La primera carta de comando jugada en cada turno tiene efecto 1 vez adicional. \n Al aniquilar, genera 1 tentáculo. \n Al cambiar el tentáculo a la postura de \"Olas furiosas\", el efecto de impulso de la siguiente carta de comando de este turno se activa obligatoriamente y coloca 2 copias originales en el espacio hiperspacial, con un enfriamiento de 3 turnos."
  },
  RelicConfig_89647_Desc = {
    Text = "La primera carta de comando de cada turno tiene efecto 1 vez adicional. \n Al aniquilar, genera 1 tentáculo. \n Al cambiar el tentáculo a la postura de \"Olas Furiosas\", el efecto de impulso de la siguiente carta de comando de este turno se activa obligatoriamente y coloca 2 copias originales en el espacio hiperspacial, con un tiempo de enfriamiento de 3 turnos."
  },
  RelicConfig_89647_Name = {
    Text = "Elixir de supercuerda del abismo marino"
  },
  RelicConfig_89648_BattleDesc = {
    Text = "Maestría en dominios aumenta 200 puntos. \nAl consumir el Horno Carmesí, aumenta el daño de los tentáculos en un 15% del consumo. \nCada vez que los tentáculos atacan, acumula [Arg3] puntos de Horno Carmesí."
  },
  RelicConfig_89648_Desc = {
    Text = "Maestría en dominios aumenta 200 puntos. \nAl consumir el Horno Carmesí, aumenta el daño de los tentáculos en un 15% del consumo. \nCada vez que los tentáculos atacan, acumula [Arg3] puntos de Horno Carmesí."
  },
  RelicConfig_89648_Name = {
    Text = "Fórmula de sangre corrompida del abismo marino"
  },
  RelicConfig_91096_BattleDesc = {
    Text = "Al comienzo del turno, ambas partes obtienen una capa de <Kuangre:locura>, cada capa de <Kuangre:locura> hace que el daño activo y el daño de tentáculo causen un 10% adicional de daño equivalente en <BleedingIconKeywords:sangrando>. \n Cada vez que se causa daño equivalente al 20% de la vida del líder, todos los Despertados obtienen 10 de locura. \n Al comenzar la batalla, se barajan <DerivativeCardKeywords_108:\"Inspirar a los descendientes\"> y <DerivativeCardKeywords_109:\"Proteger a las crías\"> en el mazo de robo."
  },
  RelicConfig_91096_Desc = {
    Text = "Al comenzar el turno, ambas partes obtienen una capa de <Kuangre:locura>, y cada capa de <Kuangre:locura> hace que el daño activo y el daño de tentáculo causen un 10% adicional de daño equivalente en <BleedingIconKeywords:sangrando>. \n Cada vez que se causa un 20% de daño a la vida del líder, todos los Despertados obtienen 10 de locura. \n Al comenzar la batalla, baraja <DerivativeCardKeywords_108:\"Inspirar a los descendientes\"> y <DerivativeCardKeywords_109:\"Proteger a las crías\"> en el mazo de robo."
  },
  RelicConfig_91096_Name = {
    Text = "Huevo Pálido"
  },
  RelicConfig_91096_StoryDesc = {
    Text = "Incitación en el momento del nacimiento del Hijo Pálido.\nCuidado, están a punto de llegar."
  },
  RelicConfig_94695_BattleDesc = {
    Text = "Después de que un Despertador es asesinado, otros aliados ganan [Arg1] <StrongEffectKeywords: Efecto Fuerte>, este efecto solo puede ser activado una vez para cada Despertador."
  },
  RelicConfig_94695_Desc = {
    Text = "Después de que un Despertador es asesinado, otros aliados ganan [Arg1] <StrongEffectKeywords: Efecto Fuerte>, este efecto solo puede ser activado una vez para cada Despertador."
  },
  RelicConfig_94695_Name = {
    Text = "<OrangeQuality:Ceniza Ardiente de la Estrella Negra>"
  },
  RelicConfig_94696_BattleDesc = {
    Text = "Tras comenzar la batalla, el límite inicial de aritmética aumenta en +[Arg1]."
  },
  RelicConfig_94696_Desc = {
    Text = "Tras comenzar la batalla, el límite inicial de aritmética aumenta en +[Arg1]."
  },
  RelicConfig_94696_Name = {
    Text = "<OrangeQuality:Inyector activo>"
  },
  RelicConfig_94697_BattleDesc = {
    Text = "Al final del turno, descarta toda la mano y roba el número correspondiente de cartas."
  },
  RelicConfig_94697_Desc = {
    Text = "Al final del turno, descarta toda la mano y roba el número correspondiente de cartas."
  },
  RelicConfig_94697_Name = {
    Text = "<OrangeQuality:Campana de seducción>"
  },
  RelicConfig_94698_BattleDesc = {
    Text = "Después de que comience la batalla, coloca [Arg1] <PVPDerivativeCardKeywords_22:Golpea Último, Golpea Mejor> y <PVPDerivativeCardKeywords_23:Voces en Tu Cabeza> en el mazo de robo."
  },
  RelicConfig_94698_Desc = {
    Text = "Después de que comience la batalla, coloca [Arg1] <PVPDerivativeCardKeywords_22:Golpea Último, Golpea Mejor> y <PVPDerivativeCardKeywords_23:Voces en Tu Cabeza> en el mazo de robo."
  },
  RelicConfig_94698_Name = {
    Text = "<OrangeQuality:Artefacto de Alfonso>"
  },
  RelicConfig_95975_BattleDesc = {
    Text = "Límite de cartas en mano +1. \nAl comenzar el turno, si no tienes <DerivativeCardKeywords_111:\"alma devoradora\">, colócala en tu mano. Si \"saciedad\" alcanza 10, conviértela en <DerivativeCardKeywords_112:\"resonancia de memoria\">."
  },
  RelicConfig_95975_Desc = {
    Text = "Límite de cartas en mano +1. \nAl comenzar el turno, si no posees \"alma devoradora\", colócala en tu mano. Si alcanzas 10 de \"saciedad\", conviértela en \"resonancia de memoria\"."
  },
  RelicConfig_95975_Name = {
    Text = "Cáliz Óseo"
  },
  RelicConfig_95975_StoryDesc = {
    Text = "\"La Luna Sangrienta se eleva, los cadáveres deben levantar sus copas y beber juntos.\""
  },
  RelicConfig_95976_BattleDesc = {
    Text = "Al comienzo del turno, Dursain obtiene [Arg1] puntos de locura y [Arg2] puntos de poder. Cuando Dursain consume \"restos\", obtiene un 20% del poder permanente como poder temporal."
  },
  RelicConfig_95976_Desc = {
    Text = "Al comienzo del turno, Dursain obtiene [Arg1] puntos de locura y [Arg2] puntos de poder. Cuando Dursain consume \"restos\", obtiene un 20% del poder permanente como poder temporal."
  },
  RelicConfig_95976_Name = {
    Text = "<OrangeQuality:Imagen Dimensional de Dursain>"
  },
  RelicConfig_96652_BattleDesc = {
    Text = "Al comienzo del turno, otorga a 1 carta de comando en mano el efecto de \"<BurningKeywords2:Quemadura>\" y acumula 1 capa de \"<Heat:Llama Oscura>\". Una vez que \"<Heat:Llama Oscura>\" alcanza 3 capas, coloca una carta de \"<Overload:Llama Infinita>\" en tu mano."
  },
  RelicConfig_96652_Desc = {
    Text = "Al comienzo del turno, otorga a 1 carta de comando en mano el efecto de \"<BurningKeywords2:Quemadura>\" y acumula 1 capa de \"<Heat:Llama Oscura>\". Una vez que \"<Heat:Llama Oscura>\" alcanza 3 capas, coloca una carta de \"<Overload:Llama Infinita>\" en tu mano."
  },
  RelicConfig_96652_Name = {
    Text = "Llama Oscura"
  },
  RelicConfig_96652_StoryDesc = {
    Text = "Las llamas oscuras llevarán a cabo su voluntad, reduciendo todo a cenizas."
  },
  RelicConfig_97344_BattleDesc = {
    Text = "Cuando pierdas la última carta en la mano, roba 2 cartas y obtén [Arg1] puntos de energía de llave de plata. Cada vez que se barajea el mazo, el daño de tentáculo aumenta en [Arg2] puntos."
  },
  RelicConfig_97344_Desc = {
    Text = "Cuando pierdas la última carta en la mano, roba 2 cartas y obtén [Arg1] puntos de energía de llave de plata. Cada vez que se barajea el mazo, el daño de tentáculo aumenta en [Arg2] puntos."
  },
  RelicConfig_97344_Name = {
    Text = "Copa de Oro de Missaga"
  },
  RelicConfig_97344_StoryDesc = {
    Text = "Hoy, olvidaremos el miedo, olvidaremos el dolor, y solo disfrutaremos de la celebración."
  },
  RelicConfig_97345_BattleDesc = {
    Text = "Cada vez que juegues 3 cartas de comando, obtén 1 punto de aritmética y roba 1 carta. Cada daño activo infligido aumenta el daño final temporal en un 2%, hasta un máximo del 50%."
  },
  RelicConfig_97345_Desc = {
    Text = "Por cada 3 cartas de comando jugadas, obtén 1 punto de aritmética y roba 1 carta. Por cada daño activo infligido, aumenta el daño final temporal en un 2%, con un máximo del 50%."
  },
  RelicConfig_97345_Name = {
    Text = "Copa de Oro de Missaga"
  },
  RelicConfig_97345_StoryDesc = {
    Text = "Hoy, olvidaremos el miedo, olvidaremos el dolor, y solo disfrutaremos de la fiesta."
  },
  RelicConfig_97346_BattleDesc = {
    Text = "Todos los Despertados aumentan su tasa crítica en un 30%. Al inicio de los turnos impares, todos los enemigos pierden el 25% de su vida actual. Cuando la proporción de tu vida es inferior a la del enemigo, el daño final causado aumenta en un 50%; cuando la proporción de tu vida es superior a la del enemigo, obtienes 35 puntos de locura después de liberar una exaltación."
  },
  RelicConfig_97346_Desc = {
    Text = "Todos los Despertados aumentan su probabilidad de crítico en un 30%. Al inicio de los turnos impares, todos los enemigos pierden el 25% de su vida actual. Si la proporción de tu vida es inferior a la del enemigo, el daño final causado aumenta en un 50%; si la proporción de tu vida es superior a la del enemigo, obtienes 35 puntos de locura después de liberar una exaltación."
  },
  RelicConfig_97346_Name = {
    Text = "Copa de Oro de Missaga"
  },
  RelicConfig_97346_StoryDesc = {
    Text = "Hoy, olvidaremos el miedo, olvidaremos el dolor, solo disfrutaremos de la celebración."
  },
  RelicConfig_97347_BattleDesc = {
    Text = "Aumenta el límite de aritmética máxima en 2 puntos, la aritmética no consumida se puede conservar para el siguiente turno; si se conserva más de 2 puntos de aritmética, todos los despertadores obtendrán 20 puntos de locura al inicio del siguiente turno; si se conserva más de 4 puntos de aritmética, el daño base causado en el siguiente turno aumenta en un 100%."
  },
  RelicConfig_97347_Desc = {
    Text = "Aumenta el límite de aritmética en 2 puntos, la aritmética no consumida se puede conservar para el siguiente turno. Si se conservan más de 2 puntos de aritmética, todos los despertadores obtienen 20 puntos de locura al comienzo del siguiente turno; si se conservan más de 4 puntos de aritmética, el daño base causado en el siguiente turno aumenta en un 100%."
  },
  RelicConfig_97347_Name = {
    Text = "Copa de Oro de Missaga"
  },
  RelicConfig_97347_StoryDesc = {
    Text = "Hoy, olvidaremos el miedo, olvidaremos el dolor, y solo disfrutaremos de la fiesta."
  },
  RelicConfig_98274_BattleDesc = {
    Text = "Límite de cartas en mano +1, al comenzar la batalla obtén \"<DerivativeCardKeywords_116:Paleta>\". \nAl inicio del turno, obtén 1 \"<PrimaryColor:Primario>\" y haz que 2 Tarjetas de comando obtengan aleatoriamente \"<ColorInkKeywords:Pintar>\". Después de jugar una carta \"<ColorInkKeywords:Pintar>\", obtén 1 \"<PrimaryColor:Primario>\" en orden. \nLos \"<PrimaryColor:Primario>\" utilizados se registrarán en la \"<DerivativeCardKeywords_116:Paleta>\". Si hay 2 tipos diferentes de \"<PrimaryColor:Primario>\" en la \"<DerivativeCardKeywords_116:Paleta>\", se otorgará un efecto de bonificación continua. \nSi hay 3 tipos diferentes de \"<PrimaryColor:Primario>\" en la \"<DerivativeCardKeywords_116:Paleta>\", inmediatamente todos los enemigos pierden el 5% de su PV Max, y se vacía la \"<DerivativeCardKeywords_116:Paleta>\".\n\n."
  },
  RelicConfig_98274_Desc = {
    Text = "Límite de cartas en mano +1, al comenzar la batalla obtén \"<DerivativeCardKeywords_116:Paleta>\". \nAl inicio del turno, obtén 1 \"<PrimaryColor:Primario>\" y haz que 2 Tarjetas de comando obtengan aleatoriamente \"<ColorInkKeywords:Pintar>\". Después de jugar una carta \"<ColorInkKeywords:Pintar>\", obtén 1 \"<PrimaryColor:Primario>\" en orden. \nLos \"<PrimaryColor:Primario>\" utilizados se registrarán en la \"<DerivativeCardKeywords_116:Paleta>\". Si hay 2 tipos diferentes de \"<PrimaryColor:Primario>\" en la \"<DerivativeCardKeywords_116:Paleta>\", se otorgará un efecto de bonificación continua. \nSi hay 3 tipos diferentes de \"<PrimaryColor:Primario>\" en la \"<DerivativeCardKeywords_116:Paleta>\", inmediatamente todos los enemigos pierden el 5% de su PV Max, y se vacía la \"<DerivativeCardKeywords_116:Paleta>\".\n\n."
  },
  RelicConfig_98274_Name = {
    Text = "Paleta de Fenómenos Anómalos"
  },
  RelicConfig_98274_StoryDesc = {
    Text = "En la ilusión, seremos testigos del nacimiento del \"arte\"."
  },
  RelicConfig_98367_BattleDesc = {
    Text = "El efecto base de recuperación de vida y escudo causado por todos los Despertados aumenta un [Arg1]%."
  },
  RelicConfig_98367_Desc = {
    Text = "El efecto base de recuperación de vida y escudo causado por todos los Despertados aumenta un [Arg1]%."
  },
  RelicConfig_98367_Name = {
    Text = "<WhiteQuality:Piel de serpiente mutante>"
  },
  RelicConfig_98367_StoryDesc = {
    Text = "Renacer de la cáscara dañada"
  },
  RelicConfig_98368_BattleDesc = {
    Text = "Al comenzar la batalla, obtén [Arg1]% de daño potente. Por cada carta de comando jugada de un Despertado diferente, obtén adicionalmente [Arg1]% de daño potente temporal."
  },
  RelicConfig_98368_Desc = {
    Text = "Al comenzar la batalla, obtén [Arg1]% de efecto de daño potente. Por cada carta de comando jugada de un Despertado diferente, obtén adicionalmente [Arg1]% de efecto de daño potente temporal."
  },
  RelicConfig_98368_Name = {
    Text = "<OrangeQuality:Caleidoscopio+>"
  },
  RelicConfig_98368_StoryDesc = {
    Text = "Todo lo que ves y piensas es una ilusión"
  },
  RelicConfig_98369_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, las [Arg1] cartas con la aritmética más alta en tu mano obtienen Retención y Preparación antes de ser jugadas la próxima vez, y obtienes [Arg2] puntos de energía de llave de plata."
  },
  RelicConfig_98369_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, las [Arg1] cartas con la aritmética más alta en tu mano obtienen Retención y Preparación antes de ser jugadas la próxima vez, y obtienes [Arg2] puntos de energía-s."
  },
  RelicConfig_98369_Name = {
    Text = "<WhiteQuality:Álbum de sellos>"
  },
  RelicConfig_98369_StoryDesc = {
    Text = "Pensamientos cuantificados"
  },
  RelicConfig_98370_BattleDesc = {
    Text = "Al comenzar la batalla, causa [Arg1] capas de <WeaknessIconKeywords:debilidad> y <VulnerabilityIconKeywords:vulnerabilidad> a todos los enemigos. Este efecto también se activa después de \"Aniquilación\", pero tiene un enfriamiento de 3 turnos."
  },
  RelicConfig_98370_Desc = {
    Text = "Al comenzar la batalla, inflige [Arg1] capas de debilidad y vulnerabilidad a todos los enemigos. Este efecto también se activa tras \"Aniquilación\", pero tiene un tiempo de enfriamiento de 3 turnos."
  },
  RelicConfig_98370_Name = {
    Text = "<WhiteQuality:Desviador Espacial>"
  },
  RelicConfig_98370_StoryDesc = {
    Text = "Salto al vacío"
  },
  RelicConfig_98371_BattleDesc = {
    Text = "Antes de que termine el turno, el Despertado propietario de cada carta de comando en tu mano obtiene [Arg1] puntos de Locura."
  },
  RelicConfig_98371_Desc = {
    Text = "Antes de que termine el turno, por cada carta de comando en tu mano, su Despertado correspondiente obtiene [Arg1] puntos de Locura."
  },
  RelicConfig_98371_Name = {
    Text = "<WhiteQuality:Balanza desequilibrada>"
  },
  RelicConfig_98371_StoryDesc = {
    Text = "Ya no simboliza justicia"
  },
  RelicConfig_98372_BattleDesc = {
    Text = "Al final del turno, si la energía-llave de plata está llena, consume [Arg1] puntos de energía-llave de plata para añadir una carta \"llave de plata de brillo\" a la mano."
  },
  RelicConfig_98372_Desc = {
    Text = "Al final del turno, si la energía-llave de plata está completa, consume [Arg1] puntos de energía-llave de plata para añadir una carta \"llave de plata de brillo\" a la mano."
  },
  RelicConfig_98372_Name = {
    Text = "<WhiteQuality:En la luz del ocaso>"
  },
  RelicConfig_98372_StoryDesc = {
    Text = "¡Vamos a tomar una foto! Siente el dolor real"
  },
  RelicConfig_98373_BattleDesc = {
    Text = "Tras liberar la «exhalación de aliemus», obtén [Arg1] puntos de energía de llave de plata. Se puede activar un máximo de 3 veces por turno."
  },
  RelicConfig_98373_Desc = {
    Text = "Tras liberar la «exhalación de aliemus», obtiene [Arg1] puntos de energía de llave de plata. Se puede activar un máximo de 3 veces por turno."
  },
  RelicConfig_98373_Name = {
    Text = "<OrangeQuality:Momento hermoso+>"
  },
  RelicConfig_98373_StoryDesc = {
    Text = "Preserva la belleza efímera para siempre"
  },
  RelicConfig_98374_BattleDesc = {
    Text = "La primera vez que uses \"llave\" en cada turno, aplica [Arg1] capas de veneno a todos los enemigos y obtén [Arg2] capas de contraataque."
  },
  RelicConfig_98374_Desc = {
    Text = "La primera vez que uses \"llave\" en cada turno, aplica [Arg1] capas de veneno a todos los enemigos y obtén [Arg2] capas de contraataque."
  },
  RelicConfig_98374_Name = {
    Text = "<OrangeQuality:Lámpara de deseos del profeta+>"
  },
  RelicConfig_98374_StoryDesc = {
    Text = "Responde a tu deseo"
  },
  RelicConfig_98375_BattleDesc = {
    Text = "Al final del turno, si la energía de llave de plata está llena, consume [Arg1] puntos de energía de llave de plata para añadir una carta \"llave de plata de luz\" a tu mano."
  },
  RelicConfig_98375_Desc = {
    Text = "Al final del turno, si la energía de llave de plata está llena, consume [Arg1] puntos de energía de llave de plata para añadir una carta \"llave de plata de luz\" a la mano."
  },
  RelicConfig_98375_Name = {
    Text = "<OrangeQuality:En el crepúsculo+>"
  },
  RelicConfig_98375_StoryDesc = {
    Text = "¡Vamos a tomar una foto! Siente el dolor real"
  },
  RelicConfig_98376_BattleDesc = {
    Text = "El efecto base de recuperación de vida y escudo causado por todos los Despertados aumenta un [Arg1]%."
  },
  RelicConfig_98376_Desc = {
    Text = "El efecto base de recuperación de vida y escudo causado por todos los Despertados aumenta un [Arg1]%."
  },
  RelicConfig_98376_Name = {
    Text = "<OrangeQuality:Piel de serpiente monstruosa+>"
  },
  RelicConfig_98376_StoryDesc = {
    Text = "Renacer de la cáscara dañada"
  },
  RelicConfig_98377_BattleDesc = {
    Text = "Cada vez que una carta entra en el espacio dimensional, roba [Arg1] cartas de comando del propietario de esta carta del mazo de robo. Si no es posible robar, en su lugar obtén una cantidad equivalente de aritmética. Máximo 2 activaciones por turno."
  },
  RelicConfig_98377_Desc = {
    Text = "Cada vez que una carta entra en el espacio transdimensional, roba [Arg1] cartas de comando del propietario de esta carta del mazo de robo. Si no es posible robar, en su lugar obtén una cantidad equivalente de aritmética. Máximo 2 activaciones por turno."
  },
  RelicConfig_98377_Name = {
    Text = "<WhiteQuality:Prisma>"
  },
  RelicConfig_98377_StoryDesc = {
    Text = "\"La luz se compone de siete colores.\""
  },
  RelicConfig_98378_BattleDesc = {
    Text = "Al comenzar la batalla, obtén [Arg1]% de efecto de daño potente. Al recibir daño, obtén [Arg2] puntos de contraataque, con un máximo de 3 activaciones por turno."
  },
  RelicConfig_98378_Desc = {
    Text = "Al comenzar la batalla, obtén [Arg1]% de efecto de daño potente. Al recibir daño, obtén [Arg2] contraataques, con un máximo de 3 activaciones por turno."
  },
  RelicConfig_98378_Name = {
    Text = "<OrangeQuality:Salida de emergencia+>"
  },
  RelicConfig_98378_StoryDesc = {
    Text = "Parece que él tampoco pudo escapar"
  },
  RelicConfig_98379_BattleDesc = {
    Text = "Tras causar daño activo o daño de tentáculo, aumenta en [Arg1]% el daño de tentáculo recibido por el objetivo en ese turno, con un máximo de 20 activaciones por turno."
  },
  RelicConfig_98379_Desc = {
    Text = "Tras causar daño activo o daño de tentáculo, aumenta el daño de tentáculo recibido por el objetivo en [Arg1]% durante ese turno, con un máximo de 20 activaciones por turno."
  },
  RelicConfig_98379_Name = {
    Text = "<WhiteQuality:Casco de buceo>"
  },
  RelicConfig_98379_StoryDesc = {
    Text = "¡Los sueños son estrellas y océanos!"
  },
  RelicConfig_98380_BattleDesc = {
    Text = "Al comenzar la batalla y después de activar la resistencia a la muerte, obtén [Arg1] puntos de energía de llave de plata."
  },
  RelicConfig_98380_Desc = {
    Text = "Al comenzar la batalla y después de activar la resistencia a la muerte, obtén [Arg1] puntos de energía de llave de plata."
  },
  RelicConfig_98380_Name = {
    Text = "<WhiteQuality:Ofrenda del Pasado>"
  },
  RelicConfig_98380_StoryDesc = {
    Text = "Una vez fue una ofrenda"
  },
  RelicConfig_98381_BattleDesc = {
    Text = "Después de usar Keyflare Rouse, restablece [Heal:Arg1] PV y obtén [Arg2] Keyflare."
  },
  RelicConfig_98381_Desc = {
    Text = "Después de usar Keyflare Rouse, restablece [Heal:Arg1] PV y obtén [Arg2] Keyflare."
  },
  RelicConfig_98381_Name = {
    Text = "<WhiteQuality:Paraguas de viaje>"
  },
  RelicConfig_98381_StoryDesc = {
    Text = "Florece en la tierra sin luz"
  },
  RelicConfig_98382_BattleDesc = {
    Text = "Después de que comience la batalla, gana [Arg1] <ProficientInRealmsIconKeywords:maestría de reino>. Al inicio de turnos impares, roba [Arg2] cartas, al inicio de turnos pares, gana [Arg2] puntos de aritmética."
  },
  RelicConfig_98382_Desc = {
    Text = "Después de que comience la batalla, gana [Arg1] <ProficientInRealmsIconKeywords:maestría de reino>. Al inicio de turnos impares, roba [Arg2] cartas, al inicio de turnos pares, gana [Arg2] puntos de aritmética."
  },
  RelicConfig_98382_Name = {
    Text = "<OrangeQuality:Rueda del Sol y la Luna+>"
  },
  RelicConfig_98382_StoryDesc = {
    Text = "Adivina, ¿negro o blanco?"
  },
  RelicConfig_98383_BattleDesc = {
    Text = "La primera vez que se use \"llave\" en cada turno, activa a todos los tentáculos para atacar [Arg1] veces al enemigo, causando un 50% de daño."
  },
  RelicConfig_98383_Desc = {
    Text = "La primera vez que se use \"llave\" en cada turno, activa a todos los tentáculos para atacar [Arg1] veces al enemigo, causando un 50% de daño."
  },
  RelicConfig_98383_Name = {
    Text = "<OrangeQuality:Caracol amarillo+>"
  },
  RelicConfig_98383_StoryDesc = {
    Text = "Este pequeño caracol amarillo tiene un origen noble, perfecto e impecable"
  },
  RelicConfig_98384_BattleDesc = {
    Text = "El daño base causado por todos los Despertados aumenta un [Arg1]%. Antes de liberar la exaltación, el daño base del Despertado que la libera aumenta temporalmente un [Arg2]%."
  },
  RelicConfig_98384_Desc = {
    Text = "El daño base causado por todos los Despertados aumenta un [Arg1]%. Antes de liberar la exaltación, el daño base del Despertado que la libera aumenta temporalmente un [Arg2]%."
  },
  RelicConfig_98384_Name = {
    Text = "<WhiteQuality:Sangre de los olvidados>"
  },
  RelicConfig_98384_StoryDesc = {
    Text = "Desvaneciéndose"
  },
  RelicConfig_98385_BattleDesc = {
    Text = "La primera vez que uses \"llave\" en cada turno, aplica [Arg1] capas de veneno a todos los enemigos y obtén [Arg2] capas de contraataque."
  },
  RelicConfig_98385_Desc = {
    Text = "La primera vez que se use \"llave\" en cada turno, aplica [Arg1] capas de veneno a todos los enemigos y obtiene [Arg2] capas de contraataque."
  },
  RelicConfig_98385_Name = {
    Text = "<WhiteQuality:Lámpara de deseos del profeta>"
  },
  RelicConfig_98385_StoryDesc = {
    Text = "Responde a tu deseo"
  },
  RelicConfig_98386_BattleDesc = {
    Text = "Al comienzo del turno, si la vida es inferior al 50%, el daño temporal potente aumenta en +[Arg1]%. Si la vida es inferior al 25%, roba [Arg2] cartas adicionales y obtén [Arg2] aritmética."
  },
  RelicConfig_98386_Desc = {
    Text = "Al comienzo del turno, si la vida es inferior al 50%, el daño temporal aumenta en +[Arg1]%. Si la vida es inferior al 25%, roba [Arg2] cartas adicionales y obtén [Arg2] aritmética."
  },
  RelicConfig_98386_Name = {
    Text = "<WhiteQuality:Maletín de doctor>"
  },
  RelicConfig_98386_StoryDesc = {
    Text = "El maletín que simboliza la identidad de médico es muy pesado. \n\nNo siempre quien lo abre es un verdadero médico.\n"
  },
  RelicConfig_98387_BattleDesc = {
    Text = "Al comenzar la batalla, inflige [Arg1] capas de debilidad y vulnerabilidad a todos los enemigos. Este efecto también se activa tras \"Aniquilación\", pero tiene un tiempo de enfriamiento de 3 turnos."
  },
  RelicConfig_98387_Desc = {
    Text = "Al comenzar la batalla, inflige [Arg1] capas de debilidad y vulnerabilidad a todos los enemigos. Este efecto también se activa tras \"Aniquilación\", pero tiene un tiempo de enfriamiento de 3 turnos."
  },
  RelicConfig_98387_Name = {
    Text = "<OrangeQuality:Desviador Espacial+>"
  },
  RelicConfig_98387_StoryDesc = {
    Text = "Salto al vacío"
  },
  RelicConfig_98388_BattleDesc = {
    Text = "Al comenzar la batalla y después de activar la resistencia a la muerte, obtén [Arg1] puntos de energía-s de llave de plata."
  },
  RelicConfig_98388_Desc = {
    Text = "Al comenzar la batalla y después de activar la resistencia a la muerte, obtén [Arg1] puntos de energía-s de llave de plata."
  },
  RelicConfig_98388_Name = {
    Text = "<OrangeQuality:Ofrenda del Pasado+>"
  },
  RelicConfig_98388_StoryDesc = {
    Text = "Una vez fue una ofrenda"
  },
  RelicConfig_98389_BattleDesc = {
    Text = "Después de que comience la batalla, gana [Arg1] <ProficientInRealmsIconKeywords:maestría de reino>. Al inicio de turnos impares, roba [Arg2] cartas, al inicio de turnos pares, gana [Arg2] puntos de aritmética."
  },
  RelicConfig_98389_Desc = {
    Text = "Después de que comience la batalla, gana [Arg1] <ProficientInRealmsIconKeywords:maestría de reino>. Al inicio de turnos impares, roba [Arg2] cartas, al inicio de turnos pares, gana [Arg2] puntos de aritmética."
  },
  RelicConfig_98389_Name = {
    Text = "<WhiteQuality:Rueda del Sol y la Luna>"
  },
  RelicConfig_98389_StoryDesc = {
    Text = "Adivina, ¿negro o blanco?"
  },
  RelicConfig_98390_BattleDesc = {
    Text = "Cada vez que robas o descartas una carta, obtienes [Arg1] de fuerza temporal, con un máximo de 15 activaciones por turno."
  },
  RelicConfig_98390_Desc = {
    Text = "Cada vez que robas o descartas una carta, obtienes [Arg1] de fuerza temporal, con un máximo de 15 activaciones por turno."
  },
  RelicConfig_98390_Name = {
    Text = "<WhiteQuality:Preludio silencioso>"
  },
  RelicConfig_98390_StoryDesc = {
    Text = "El violín del famoso violinista Eric Eckstein.\nHoy en día, ya no puede tocarse"
  },
  RelicConfig_98391_BattleDesc = {
    Text = "La primera vez que se use \"llave\" en cada turno, aumenta temporalmente el daño en +[Arg2]%, siendo más efectivo cuanto menor sea la vida."
  },
  RelicConfig_98391_Desc = {
    Text = "La primera vez que se use \"llave\" en cada turno, aumenta el daño temporal en +[Arg1]%, siendo más efectivo cuanto menor sea la vida."
  },
  RelicConfig_98391_Name = {
    Text = "<WhiteQuality:Elixir de Harford>"
  },
  RelicConfig_98391_StoryDesc = {
    Text = "Medicamento de composición desconocida.\nSe dice que el famoso violinista Eric lo prefiere"
  },
  RelicConfig_98392_BattleDesc = {
    Text = "La primera vez que se use \"llave\" en cada turno, aumenta el daño temporal en +[Arg2]%, siendo más efectivo cuanto menor sea la vida."
  },
  RelicConfig_98392_Desc = {
    Text = "La primera vez que se use \"llave\" en cada turno, aumenta el daño temporal en +[Arg1]%, siendo el efecto más fuerte cuanto menor sea la vida."
  },
  RelicConfig_98392_Name = {
    Text = "<OrangeQuality:Elixir de Harford+>"
  },
  RelicConfig_98392_StoryDesc = {
    Text = "Medicamento de composición desconocida.\nSe dice que el famoso violinista Eric lo prefiere"
  },
  RelicConfig_98393_BattleDesc = {
    Text = "Todos los Despertados obtienen [Arg1] puntos de energía-s de llave de plata al usar una \"carta de comando\" por primera vez en cada turno."
  },
  RelicConfig_98393_Desc = {
    Text = "Todos los Despertados obtienen [Arg1] puntos de energía-s de llave de plata al usar una \"carta de comando\" por primera vez en cada turno."
  },
  RelicConfig_98393_Name = {
    Text = "<WhiteQuality:Elocuencia>"
  },
  RelicConfig_98393_StoryDesc = {
    Text = "No solo los comerciantes son elocuentes, también los devotos"
  },
  RelicConfig_98394_BattleDesc = {
    Text = "La primera vez que se use una \"llave\" en cada turno, se devolverá el [Arg1]% de la energía-s de llave de plata consumida."
  },
  RelicConfig_98394_Desc = {
    Text = "La primera vez que se use \"llave\" en cada turno, se devolverá el [Arg1]% de la energía-s de llave de plata consumida."
  },
  RelicConfig_98394_Name = {
    Text = "<WhiteQuality:Pata de conejo>"
  },
  RelicConfig_98394_StoryDesc = {
    Text = "Para el conejo, no fue tan afortunado"
  },
  RelicConfig_98395_BattleDesc = {
    Text = "Al comenzar la batalla, obtén un efecto de daño potente del [Arg1]%. Tras causar daño activo, inflige [Arg2] capas de veneno a todos los enemigos. Este efecto puede activarse un máximo de 5 veces por turno."
  },
  RelicConfig_98395_Desc = {
    Text = "Al comenzar la batalla, obtén un efecto de daño potente del [Arg1]%. Tras causar daño activo, inflige [Arg2] capas de veneno a todos los enemigos, con un máximo de 5 activaciones por turno."
  },
  RelicConfig_98395_Name = {
    Text = "<OrangeQuality:Cetro del Sacerdote+>"
  },
  RelicConfig_98395_StoryDesc = {
    Text = "Devoción no permitida"
  },
  RelicConfig_98396_BattleDesc = {
    Text = "Al comenzar la batalla, obtén [Arg1]% de efecto de daño potente. Por cada carta de comando de un Despertado diferente jugada, obtén adicionalmente [Arg1]% de efecto de daño potente temporal."
  },
  RelicConfig_98396_Desc = {
    Text = "Al comenzar la batalla, obtén [Arg1]% de efecto de daño potente. Por cada carta de comando jugada de un Despertado diferente, obtén adicionalmente [Arg1]% de efecto de daño potente temporal."
  },
  RelicConfig_98396_Name = {
    Text = "<WhiteQuality:Caleidoscopio>"
  },
  RelicConfig_98396_StoryDesc = {
    Text = "Todo lo que ves y piensas es una ilusión"
  },
  RelicConfig_98397_BattleDesc = {
    Text = "Después de liberar la segunda \"llave\" en cada turno, obtén [Arg1] puntos de energía de llave de plata y todos los Despertados obtienen [Arg2] puntos de locura."
  },
  RelicConfig_98397_Desc = {
    Text = "Después de liberar la segunda \"llave\" en cada turno, obtén [Arg1] puntos de energía de llave de plata y todos los Despertados obtienen [Arg2] puntos de locura."
  },
  RelicConfig_98397_Name = {
    Text = "<OrangeQuality:Cronómetro preciso+>"
  },
  RelicConfig_98397_StoryDesc = {
    Text = "Uno de los inventos más malvados de la humanidad"
  },
  RelicConfig_98398_BattleDesc = {
    Text = "Al comenzar la batalla, hacer que todos los enemigos pierdan temporalmente [Arg1] puntos de <PowerIconKeywords:fuerza>. Usar \"Horno Carmesí\" también activa este efecto, pero tiene un enfriamiento de 3 turnos."
  },
  RelicConfig_98398_Desc = {
    Text = "Al comenzar la batalla, hacer que todos los enemigos pierdan temporalmente [Arg1] puntos de fuerza. Usar \"Horno Carmesí\" también activa este efecto, pero tiene un tiempo de enfriamiento de 3 turnos."
  },
  RelicConfig_98398_Name = {
    Text = "<OrangeQuality:Manos hábiles+>"
  },
  RelicConfig_98398_StoryDesc = {
    Text = "La herramienta perfecta para asesinar y robar"
  },
  RelicConfig_98399_BattleDesc = {
    Text = "Después de liberar la segunda \"llave\" en cada turno, obtén [Arg1] puntos de energía-s de llave de plata y todos los Despertados obtienen [Arg2] puntos de locura."
  },
  RelicConfig_98399_Desc = {
    Text = "Después de liberar la segunda \"llave\" en cada turno, obtén [Arg1] puntos de energía-s de llave de plata y todos los Despertados obtienen [Arg2] puntos de aliemus."
  },
  RelicConfig_98399_Name = {
    Text = "<WhiteQuality:Cronómetro>"
  },
  RelicConfig_98399_StoryDesc = {
    Text = "Uno de los inventos más malvados de la humanidad"
  },
  RelicConfig_98400_BattleDesc = {
    Text = "Cada vez que robas o descartas una carta, obtienes [Arg1] de fuerza temporal, con un máximo de 15 activaciones por turno."
  },
  RelicConfig_98400_Desc = {
    Text = "Cada vez que robes o descartes una carta, obtén [Arg1] de fuerza temporal, con un máximo de 15 activaciones por turno."
  },
  RelicConfig_98400_Name = {
    Text = "<OrangeQuality:Preludio silencioso+>"
  },
  RelicConfig_98400_StoryDesc = {
    Text = "El violín del famoso violinista Eric Eckstein.\nHoy en día, ya no puede tocarse"
  },
  RelicConfig_98401_BattleDesc = {
    Text = "Al comenzar la batalla, obtén un [Arg1]% adicional de efecto de daño potente. Cada turno, al recibir una contraofensiva por primera vez, obtén [Arg2] aritmética."
  },
  RelicConfig_98401_Desc = {
    Text = "Al comenzar la batalla, obtén un [Arg1]% de efecto de daño potente. Al recibir una contraofensiva por primera vez en cada turno, obtén [Arg2] puntos de aritmética."
  },
  RelicConfig_98401_Name = {
    Text = "<OrangeQuality:Diario de Putney+>"
  },
  RelicConfig_98401_StoryDesc = {
    Text = "Su compañero de baño más fiel"
  },
  RelicConfig_98402_BattleDesc = {
    Text = "Tras causar daño activo o daño de tentáculo, aumenta en [Arg1]% el daño de tentáculo recibido por el objetivo en ese turno, con un máximo de 20 activaciones por turno."
  },
  RelicConfig_98402_Desc = {
    Text = "Tras causar daño activo o daño de tentáculo, aumenta en [Arg1]% el daño de tentáculo recibido por el objetivo durante ese turno, con un máximo de 20 activaciones por turno."
  },
  RelicConfig_98402_Name = {
    Text = "<OrangeQuality:Casco de buceo+>"
  },
  RelicConfig_98402_StoryDesc = {
    Text = "¡Los sueños son estrellas y océanos!"
  },
  RelicConfig_98403_BattleDesc = {
    Text = "Al inicio de la batalla, obtén [Arg1] puntos de fuerza. Por cada carta con \"gasto\" jugada, obtén [Arg2] puntos de fuerza temporal, con un máximo de 10 activaciones por turno."
  },
  RelicConfig_98403_Desc = {
    Text = "Al inicio de la batalla, obtén [Arg1] puntos de <PowerIconKeywords:fuerza>. Por cada carta con \"gasto\" jugada, obtén [Arg2] puntos de <PowerIconKeywords:fuerza> temporal, activándose un máximo de 10 veces por turno."
  },
  RelicConfig_98403_Name = {
    Text = "<OrangeQuality:Cajita de música+>"
  },
  RelicConfig_98403_StoryDesc = {
    Text = "La mansión de Dexter tiene muchas colecciones. Antes de romperse, la pequeña caja de música era el juguete favorito de la pequeña señorita Dexter.\nCon el paso del tiempo, cuando la señorita Dexter la encontró de nuevo, sus engranajes estaban sueltos y la música desafinada, pero aún giraba"
  },
  RelicConfig_98404_BattleDesc = {
    Text = "Liberar \"exhalación de aliemus\" para obtener [Arg1] puntos de energía de llave de plata. Se puede activar un máximo de 3 veces por turno."
  },
  RelicConfig_98404_Desc = {
    Text = "Liberar la «exhalación de aliemus» otorga [Arg1] puntos de energía de llave de plata. Se puede activar un máximo de 3 veces por turno."
  },
  RelicConfig_98404_Name = {
    Text = "<WhiteQuality:Momento hermoso>"
  },
  RelicConfig_98404_StoryDesc = {
    Text = "Preserva la belleza efímera para siempre"
  },
  RelicConfig_98405_BattleDesc = {
    Text = "Todos los Despertados obtienen [Arg1] puntos de energía-s de llave de plata la primera vez que se use una \"carta de comando\" en cada turno."
  },
  RelicConfig_98405_Desc = {
    Text = "Todos los Despertados obtienen [Arg1] puntos de energía-s de llave de plata la primera vez que se use una \"carta de comando\" en cada turno."
  },
  RelicConfig_98405_Name = {
    Text = "<OrangeQuality:Elocuencia+>"
  },
  RelicConfig_98405_StoryDesc = {
    Text = "No solo los comerciantes son elocuentes, también los devotos"
  },
  RelicConfig_98406_BattleDesc = {
    Text = "Cada vez que se genera un \"Embrion\", obtienes [Arg1] puntos de acumulación del Horno Carmesí, máximo 3 veces por turno."
  },
  RelicConfig_98406_Desc = {
    Text = "Cada vez que se genera 1 \"Embrion\", obtén [Arg1] puntos de acumulación del Horno Carmesí, máximo 3 veces por turno."
  },
  RelicConfig_98406_Name = {
    Text = "<OrangeQuality:Querido Tesoro+>"
  },
  RelicConfig_98406_StoryDesc = {
    Text = "El carpintero hizo una marioneta vívida para su esposa, que reemplazaría a su hijo, durmiendo en su vientre"
  },
  RelicConfig_98407_BattleDesc = {
    Text = "La primera vez que se use \"llave\" en cada turno, se devolverá el [Arg1]% de la energía-s de llave de plata consumida."
  },
  RelicConfig_98407_Desc = {
    Text = "La primera vez que se use una \"llave\" en cada turno, se devolverá el [Arg1]% de la energía-s de llave de plata consumida."
  },
  RelicConfig_98407_Name = {
    Text = "<OrangeQuality:Pata de conejo+>"
  },
  RelicConfig_98407_StoryDesc = {
    Text = "Para el conejo, no fue tan afortunado"
  },
  RelicConfig_98408_BattleDesc = {
    Text = "Al inicio del turno, todos los Despertados que no tengan suficiente Locura para liberar una Exaltación obtienen [Arg1] puntos de Locura."
  },
  RelicConfig_98408_Desc = {
    Text = "Al inicio del turno, todos los Despertados que no tengan suficiente locura para liberar una Exaltación obtienen [Arg1] puntos de locura."
  },
  RelicConfig_98408_Name = {
    Text = "<WhiteQuality:Tiempo de huevos de Pascua>"
  },
  RelicConfig_98408_StoryDesc = {
    Text = "Disfruta, pero no comas"
  },
  RelicConfig_98409_BattleDesc = {
    Text = "Al comenzar la batalla, hacer que todos los enemigos pierdan temporalmente [Arg1] puntos de fuerza. Usar \"Horno Carmesí\" también activa este efecto, pero tiene un tiempo de enfriamiento de 3 turnos."
  },
  RelicConfig_98409_Desc = {
    Text = "Al comenzar la batalla, hacer que todos los enemigos pierdan temporalmente [Arg1] puntos de <PowerIconKeywords:fuerza>. Usar \"Horno Carmesí\" también activa este efecto, pero tiene un enfriamiento de 3 turnos."
  },
  RelicConfig_98409_Name = {
    Text = "<WhiteQuality:Manos hábiles>"
  },
  RelicConfig_98409_StoryDesc = {
    Text = "La herramienta perfecta para asesinar y robar"
  },
  RelicConfig_98410_BattleDesc = {
    Text = "Cada vez que se genera un \"Embrion\", obtienes [Arg1] puntos de acumulación de Horno Carmesí, máximo 3 veces por turno."
  },
  RelicConfig_98410_Desc = {
    Text = "Cada vez que se genera 1 \"Embrion\", obtienes [Arg1] puntos de Horno Carmesí. Máximo 3 activaciones por turno."
  },
  RelicConfig_98410_Name = {
    Text = "<WhiteQuality:Querido Bebé>"
  },
  RelicConfig_98410_StoryDesc = {
    Text = "El carpintero hizo una marioneta vívida para su esposa, que reemplazaría a su hijo, durmiendo en su vientre"
  },
  RelicConfig_98411_BattleDesc = {
    Text = "Al inicio del turno, si la energía de llave de plata es mayor que [Arg1], consume [Arg1] puntos de energía de llave de plata para añadir 1 carta <DerivativeCardKeywords_115:\"inspiración avanzada\"> a tu mano."
  },
  RelicConfig_98411_Desc = {
    Text = "Al inicio del turno, si la energía de llave de plata es mayor que [Arg1], consume [Arg1] puntos de energía de llave de plata para añadir 1 carta <DerivativeCardKeywords_115:\"inspiración avanzada\"> a tu mano."
  },
  RelicConfig_98411_Name = {
    Text = "<RedQuality:Apariencia de pesadilla>"
  },
  RelicConfig_98411_StoryDesc = {
    Text = "Cuidado, el sueño profundo puede devorarlo todo sin que te des cuenta"
  },
  RelicConfig_98412_BattleDesc = {
    Text = "Después de liberar 5 veces la \"exaltación\", las próximas [Arg1] cartas de comando no derivadas tendrán efecto adicional 1 vez."
  },
  RelicConfig_98412_Desc = {
    Text = "Después de liberar 5 veces la \"exaltación de aliemus\", las próximas [Arg1] cartas de comando no derivadas tendrán un efecto adicional 1 vez."
  },
  RelicConfig_98412_Name = {
    Text = "<OrangeQuality:Vino de las Estrellas+>"
  },
  RelicConfig_98412_StoryDesc = {
    Text = "Viajando entre las estrellas"
  },
  RelicConfig_98413_BattleDesc = {
    Text = "Al comenzar la batalla, obtén [Arg1]% de efecto de daño potente. Después de recibir daño, obtén [Arg2] contraataques, con un máximo de 3 activaciones por turno."
  },
  RelicConfig_98413_Desc = {
    Text = "Al comenzar la batalla, obtén [Arg1]% de efecto de daño potente. Al recibir daño, obtén [Arg2] contraataques, con un máximo de 3 activaciones por turno."
  },
  RelicConfig_98413_Name = {
    Text = "<WhiteQuality:Salida de emergencia>"
  },
  RelicConfig_98413_StoryDesc = {
    Text = "Parece que él tampoco pudo escapar"
  },
  RelicConfig_98414_BattleDesc = {
    Text = "El daño base causado por todos los Despertados aumenta un [Arg1]%. Antes de liberar la exaltación, el daño base del Despertado que la libera aumenta temporalmente un [Arg2]%."
  },
  RelicConfig_98414_Desc = {
    Text = "El daño base causado por todos los Despertados aumenta un [Arg1]%. Antes de liberar la exaltación, el daño base del Despertado que la libera aumenta temporalmente un [Arg2]%."
  },
  RelicConfig_98414_Name = {
    Text = "<OrangeQuality:Sangre del Olvidado+>"
  },
  RelicConfig_98414_StoryDesc = {
    Text = "Desvaneciéndose"
  },
  RelicConfig_98415_BattleDesc = {
    Text = "Después de usar Keyflare Rouse, restablece [Heal:Arg1] PV y obtén [Arg2] Keyflare."
  },
  RelicConfig_98415_Desc = {
    Text = "Después de usar Keyflare Rouse, restablece [Heal:Arg1] PV y obtén [Arg2] Keyflare."
  },
  RelicConfig_98415_Name = {
    Text = "<OrangeQuality:Paraguas de viaje+>"
  },
  RelicConfig_98415_StoryDesc = {
    Text = "Florece en la tierra sin luz"
  },
  RelicConfig_98416_BattleDesc = {
    Text = "Al comenzar la batalla, obtén un [Arg1]% de efecto de daño potente. Al recibir una contraofensiva por primera vez en cada turno, obtén [Arg2] puntos de aritmética."
  },
  RelicConfig_98416_Desc = {
    Text = "Al comenzar la batalla, obtén un [Arg1]% adicional de daño potente. La primera vez que recibes una contraofensiva en cada turno, obtén [Arg2] aritmética."
  },
  RelicConfig_98416_Name = {
    Text = "<WhiteQuality:Diario de Putney>"
  },
  RelicConfig_98416_StoryDesc = {
    Text = "Su compañero de baño más fiel"
  },
  RelicConfig_98417_BattleDesc = {
    Text = "Al inicio del turno, todos los Despertados que no tengan suficiente Locura para liberar una Exaltación obtienen [Arg1] puntos de Locura."
  },
  RelicConfig_98417_Desc = {
    Text = "Al inicio del turno, todos los Despertados que no tengan suficiente locura para liberar la exaltación obtienen [Arg1] puntos de locura."
  },
  RelicConfig_98417_Name = {
    Text = "<OrangeQuality:Tiempo de Easter Egg+>"
  },
  RelicConfig_98417_StoryDesc = {
    Text = "Disfruta, pero no comas"
  },
  RelicConfig_98418_BattleDesc = {
    Text = "Al comenzar la batalla, obtén un efecto de daño potente del [Arg1]%. Al aplicar veneno por primera vez en cada turno, roba [Arg2] cartas."
  },
  RelicConfig_98418_Desc = {
    Text = "Al comenzar la batalla, obtén [Arg1]% de efecto de daño potente. Al aplicar veneno por primera vez en cada turno, roba [Arg2] cartas."
  },
  RelicConfig_98418_Name = {
    Text = "<OrangeQuality:Papiro de Reind+>"
  },
  RelicConfig_98418_StoryDesc = {
    Text = "A continuación, la pregunta: 10 monjes y 6 panes, ¿cuánto recibe cada uno?"
  },
  RelicConfig_98419_BattleDesc = {
    Text = "Tras liberar 5 veces la \"exaltación\", las próximas [Arg1] cartas de comando no derivadas tendrán un efecto adicional 1 vez."
  },
  RelicConfig_98419_Desc = {
    Text = "Cada vez que se lance \"Exaltar\" 5 veces, los siguientes [Arg1] cartas de comando innatas tendrán efecto 1 vez adicional."
  },
  RelicConfig_98419_Name = {
    Text = "<WhiteQuality:Vino de las Estrellas>"
  },
  RelicConfig_98419_StoryDesc = {
    Text = "Viajando entre las estrellas"
  },
  RelicConfig_98420_BattleDesc = {
    Text = "Cada vez que una carta entra en el espacio transdimensional, roba [Arg1] cartas de comando del propietario de esta carta del mazo de robo. Si no es posible robar, en su lugar obtén una cantidad equivalente de aritmética. Máximo 2 activaciones por turno."
  },
  RelicConfig_98420_Desc = {
    Text = "Cada vez que una carta entra en el espacio transdimensional, roba [Arg1] cartas de comando del propietario de esta carta del mazo de robo. Si no es posible robar, en su lugar obtén una cantidad equivalente de aritmética. Máximo 2 activaciones por turno."
  },
  RelicConfig_98420_Name = {
    Text = "<OrangeQuality:Prisma+>"
  },
  RelicConfig_98420_StoryDesc = {
    Text = "\"La luz se compone de siete colores.\""
  },
  RelicConfig_98421_BattleDesc = {
    Text = "Después de usar el Despertar de la llave plateada, las [Arg1] cartas con la aritmética más alta en tu mano obtienen Retención y Preparación antes de ser jugadas la próxima vez, y obtienes [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_98421_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, las [Arg1] cartas con el mayor costo de aritmética en tu mano obtienen Retención y Preparación antes de ser jugadas la próxima vez, y obtén [Arg2] puntos de energía-s de llave de plata."
  },
  RelicConfig_98421_Name = {
    Text = "<OrangeQuality:Carpeta de sellos de tierras lejanas+>"
  },
  RelicConfig_98421_StoryDesc = {
    Text = "Pensamientos cuantificados"
  },
  RelicConfig_98422_BattleDesc = {
    Text = "Antes de que termine el turno, el Despertado propietario de cada carta de comando en tu mano obtiene [Arg1] puntos de Locura."
  },
  RelicConfig_98422_Desc = {
    Text = "Antes de que termine el turno, el Despertado correspondiente a cada carta de comando en tu mano obtiene [Arg1] puntos de Locura."
  },
  RelicConfig_98422_Name = {
    Text = "<OrangeQuality:Balanza desequilibrada+>"
  },
  RelicConfig_98422_StoryDesc = {
    Text = "Ya no simboliza justicia"
  },
  RelicConfig_98423_BattleDesc = {
    Text = "Al comenzar la batalla, obtienes [Arg1]% de efecto de daño potente. Tras causar daño activo, inflige [Arg2] capas de veneno a todos los enemigos, con un máximo de 5 activaciones por turno."
  },
  RelicConfig_98423_Desc = {
    Text = "Al comenzar la batalla, obtén [Arg1]% de efecto de daño potente. Tras causar daño activo, inflige [Arg2] capas de veneno a todos los enemigos, con un máximo de 5 activaciones por turno."
  },
  RelicConfig_98423_Name = {
    Text = "<WhiteQuality:Bastón del sacerdote>"
  },
  RelicConfig_98423_StoryDesc = {
    Text = "Devoción no permitida"
  },
  RelicConfig_98424_BattleDesc = {
    Text = "Al comenzar la batalla, obtienes [Arg1]% de efecto de daño potente. Al aplicar veneno por primera vez en cada turno, robas [Arg2] cartas."
  },
  RelicConfig_98424_Desc = {
    Text = "Al comenzar la batalla, obtienes [Arg1]% de efecto de daño potente. Al aplicar veneno por primera vez en cada turno, robas [Arg2] cartas."
  },
  RelicConfig_98424_Name = {
    Text = "<WhiteQuality:Papiro de Reind>"
  },
  RelicConfig_98424_StoryDesc = {
    Text = "A continuación, la pregunta: 10 monjes y 6 panes, ¿cuánto recibe cada uno?"
  },
  RelicConfig_98425_BattleDesc = {
    Text = "Al inicio de la batalla, obtén [Arg1] puntos de fuerza. Por cada carta con \"gasto\" jugada, obtén [Arg2] puntos de fuerza temporal, con un máximo de 10 activaciones por turno."
  },
  RelicConfig_98425_Desc = {
    Text = "Al inicio de la batalla, obtén [Arg1] puntos de <PowerIconKeywords:fuerza>. Por cada carta con \"gasto\" jugada, obtén [Arg2] puntos de <PowerIconKeywords:fuerza> temporal, activándose un máximo de 10 veces por turno."
  },
  RelicConfig_98425_Name = {
    Text = "<WhiteQuality:Cajita de música>"
  },
  RelicConfig_98425_StoryDesc = {
    Text = "La mansión de Dexter tiene muchas colecciones. Antes de romperse, la pequeña caja de música era el juguete favorito de la pequeña señorita Dexter.\nCon el paso del tiempo, cuando la señorita Dexter la encontró de nuevo, sus engranajes estaban sueltos y la música desafinada, pero aún giraba"
  },
  RelicConfig_98426_BattleDesc = {
    Text = "La primera vez que se use \"llave\" en cada turno, activa a todos los tentáculos para atacar [Arg1] veces al enemigo, causando un 50% de daño."
  },
  RelicConfig_98426_Desc = {
    Text = "Cada turno, la primera vez que se use \"llave\", activa a todos los tentáculos para atacar [Arg1] veces al enemigo, causando un 50% de daño."
  },
  RelicConfig_98426_Name = {
    Text = "<WhiteQuality:Caracol amarillo>"
  },
  RelicConfig_98426_StoryDesc = {
    Text = "Este pequeño caracol amarillo tiene un origen noble, perfecto e impecable"
  },
  RelicConfig_98427_BattleDesc = {
    Text = "Al comienzo del turno, si la vida es inferior al 50%, el daño potente temporal aumenta en +[Arg1]%. Si la vida es inferior al 25%, roba [Arg2] cartas adicionales y obtén [Arg2] aritmética."
  },
  RelicConfig_98427_Desc = {
    Text = "Al comienzo del turno, si la vida es inferior al 50%, el daño temporal aumenta en +[Arg1]%. Si la vida es inferior al 25%, roba [Arg2] cartas adicionales y obtienes [Arg2] puntos de aritmética."
  },
  RelicConfig_98427_Name = {
    Text = "<OrangeQuality:Maletín del doctor+>"
  },
  RelicConfig_98427_StoryDesc = {
    Text = "El maletín que simboliza la identidad de médico es muy pesado. \n\nNo siempre quien lo abre es un verdadero médico.\n"
  },
  RelicConfig_98891_BattleDesc = {
    Text = "Al comenzar la batalla, obtén 5 capas de\"<LostWay:Perdido>\"y reduce 1 capa después de jugar 3 cartas de comando. \n Después de que todas las capas de\"<LostWay:Perdido>\"se eliminen, todos los Despertados obtienen 100 puntos de alienación, recuperando [Arg1] puntos de PV después de jugar 3 cartas de comando, y aplica <Corrosion:Corrosión> igual al 1% de la vida máxima del enemigo en la fila delantera."
  },
  RelicConfig_98891_Desc = {
    Text = "Al comenzar la batalla, obtén 5 capas de\"<LostWay:Perdido>\"y reduce 1 capa después de jugar 3 cartas de comando. \n Después de que todas las capas de\"<LostWay:Perdido>\"se eliminen, todos los Despertados obtienen 100 puntos de alienación, recuperando [Arg1] puntos de PV después de jugar 3 cartas de comando, y aplica <Corrosion:Corrosión> igual al 1% de la vida máxima del enemigo en la fila delantera."
  },
  RelicConfig_98891_Name = {
    Text = "alma artificial"
  },
  RelicConfig_98891_StoryDesc = {
    Text = "A pesar de las experiencias sombrías, la Linterna del Salvador brillará nuevamente en la muerte."
  }
})
return Text_RelicConfig
