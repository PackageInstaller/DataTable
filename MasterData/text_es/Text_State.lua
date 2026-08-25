__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_State = readonly({
  State_100291_Desc = {
    Text = "La Locura causada por todos los Despertados aumenta en 50%."
  },
  State_100291_Name = {Text = "Confesión"},
  State_100292_Name = {
    Text = "Inicio de Turno"
  },
  State_100293_Desc = {
    Text = "La Locura causada por los Despertados se reduce en 50%"
  },
  State_100293_Name = {
    Text = "sombra de personalidad"
  },
  State_100295_Name = {
    Text = "Escucha de daño"
  },
  State_100296_Desc = {
    Text = "Por cada capa, al inicio del turno, todos los despertados obtienen <Energy:3> puntos de locura."
  },
  State_100296_Name = {
    Text = "Lado oscuro del yo"
  },
  State_100297_Desc = {
    Text = "Al final del turno, obtén un escudo equivalente al 20% de tu salud máxima."
  },
  State_100297_Name = {
    Text = "Barrera del corazón"
  },
  State_100298_Desc = {
    Text = "Al inicio del turno, pierde el 10% de la vida actual y obtén [DescArg1] puntos de fuerza."
  },
  State_100298_Name = {
    Text = "Desintegración de la barrera"
  },
  State_100299_Desc = {
    Text = "Exaltar Cuenta"
  },
  State_100299_Name = {
    Text = "Exaltar Cuenta"
  },
  State_100302_Name = {
    Text = "Escuchar Exaltar"
  },
  State_100307_Desc = {
    Text = "Equipo único: Después de que el portador libera la exaltación, obtiene 1 nivel de \"Co-creación\". La próxima explosión de locura de otros Despertados en este turno podrá consumir \"Co-creación\", aumentando la tasa crítica de esa explosión de locura en <WeaponEffect_Num:[StateArg1]%>, y el Despertado que consuma \"Co-creación\" obtendrá aliemus equivalente al <WeaponEffect_Num:[StateArg1]%> de recarga de aliemus del portador."
  },
  State_100307_WeaponDesc = {
    Text = "Después de que el portador libera la exaltación, obtiene 1 nivel de \"Co-creación\". La próxima explosión de locura de otros Despertados en este turno podrá consumir \"Co-creación\", aumentando la tasa crítica de esa explosión de locura en <WeaponEffect_Num:[StateArg1]%>, y el Despertado que consuma \"Co-creación\" obtendrá <WeaponEffect_Num:[DescArg1]> puntos de locura."
  },
  State_100326_Desc = {
    Text = "Por cada capa, al inicio del turno, todos los Despertados obtienen <Energy:3> puntos de locura."
  },
  State_100326_Name = {
    Text = "<DarkEgo:Lado oscuro del yo>"
  },
  State_100327_Desc = {
    Text = "Al final del turno, obtén un escudo equivalente al 20% de tu salud máxima."
  },
  State_100327_Name = {
    Text = "<MindWall:Barrera del corazón>"
  },
  State_100328_Desc = {
    Text = "La Locura causada por todos los Despertados aumenta en 50%."
  },
  State_100328_Name = {
    Text = "<TrueConfess:confesión>"
  },
  State_100329_Desc = {
    Text = "La locura causada por los despertados se reduce en un 50%, y al final del turno, obtienen 1 capa de\"<DarkEgo:lado oscuro del yo>\": al inicio del turno, todos los despertados obtienen 3 de locura."
  },
  State_100329_Name = {
    Text = "<ShadowSelf:sombra de personalidad>"
  },
  State_100330_Desc = {
    Text = "Al inicio del turno, pierde el 10% de la vida actual y obtén [DescArg1] puntos de <PowerIconKeywords:fuerza>."
  },
  State_100330_Name = {
    Text = "<BarrierCrash:Desintegración de la barrera>"
  },
  State_100395_Name = {
    Text = "Sangre de Gracia Construida+"
  },
  State_100396_Name = {
    Text = "Sangre de Gracia Construida"
  },
  State_100527_Desc = {
    Text = "Cuando Pikman activa el efecto de\"descubrimiento\", se añade la opción de\"¡explosión de inspiración!\": consume 1 capa de\"delirio\", elige todos los efectos y obtiene 1 capa de\"creatividad\"."
  },
  State_100527_Name = {Text = "Fantasía"},
  State_100541_Desc = {
    Text = "Si actualmente tienes 10 capas de \"creatividad\", Pikman libera la explosión de locura y consume todas las capas de \"creatividad\", obteniendo 1 capa de \"delirio\" y haciendo que todos los despertadores obtengan 15 puntos de locura. El límite de creatividad es de 10 capas y se puede heredar a la siguiente batalla."
  },
  State_100541_Name = {
    Text = "<Chuangyi:creatividad>"
  },
  State_100542_Desc = {
    Text = "Cuando Pikman activa el efecto de\"descubrimiento\", se añade la opción de\"¡explosión de inspiración!\": consume 1 capa de\"delirio\", elige todos los efectos de\"descubrimiento\"y obtiene 1 capa de\"creatividad\"."
  },
  State_100542_Name = {
    Text = "<Kuangxiang:Fantasía>"
  },
  State_100544_Name = {
    Text = "Slime Dulce"
  },
  State_100544_WeaponDesc = {
    Text = "El portador aumenta el escudo y la curación en un 6%. Si la maestría del portador en el dominio es mayor a 50, el escudo y la curación aumentan un 6% adicional"
  },
  State_100545_Name = {
    Text = "Slime Dulce"
  },
  State_100545_WeaponDesc = {
    Text = "El portador aumenta el escudo y la curación en un 6%. Si la maestría del portador en el dominio es mayor a 50, el escudo y la curación aumentan un 6% adicional"
  },
  State_100558_Desc = {
    Text = "En esta ronda, la tasa crítica de la explosión de locura de los otros Despertados aumenta en [StateArg1]%, y al usarlo se obtienen [DescArg1] puntos de locura."
  },
  State_100558_Name = {
    Text = "co-creación"
  },
  State_100559_Desc = {
    Text = "Incluye las siguientes \"creaciones del capítulo de las estrellas\": niño malo, festival de primavera, cerradura pesada, ágata enredada, sangre de la gracia, sierra de acero oxidado, sueño dorado, guijarro ensangrentado."
  },
  State_100559_Name = {
    Text = "<Chuanggouzaowu:creación de la construcción>"
  },
  State_100562_Desc = {
    Text = "Has lanzado la siguiente carta de comando [Layer] con un costo de aritmética reducido en 2 este turno."
  },
  State_100562_Name = {
    Text = "Realidad, también es ilusión"
  },
  State_100564_Desc = {
    Text = "Incluye los siguientes \"sellos\": cálculo, destreza, locura, catalizador, brutalidad, muralla de hierro, agotamiento, inspiración."
  },
  State_100564_Name = {
    Text = "<Chuanggoukeyin:marca de creación>"
  },
  State_100566_WeaponDesc = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_100617_Desc = {
    Text = "Al final del turno, obtén 1 límite de tentáculos."
  },
  State_100617_Name = {
    Text = "Obsesión abisal"
  },
  State_100619_Desc = {
    Text = "Cuando se reduce la fuerza, solo se reduce el 50% de las capas de fuerza"
  },
  State_100619_Name = {
    Text = "Resistencia al agotamiento"
  },
  State_100621_Desc = {
    Text = "Cada capa reduce en un 25% el daño base causado por el jugador y puede guiar la dirección de la navegación posteriormente."
  },
  State_100621_Name = {
    Text = "Luz de vela tenue"
  },
  State_100623_Desc = {
    Text = "Cada capa reduce en un 50% el daño base causado por el jugador, y después de causar daño activo o daño de tentáculo, reduce en [DescArg1] el veneno propio."
  },
  State_100623_Name = {
    Text = "Luz Errante"
  },
  State_100639_Desc = {
    Text = "El daño de tentáculo infligido se reduce temporalmente en un 50%."
  },
  State_100639_Name = {
    Text = "Ciudad perdida de Lemuria"
  },
  State_100644_Desc = {
    Text = "Reduce permanentemente la fuerza del objetivo, ganando la misma cantidad de fuerza."
  },
  State_100644_Name = {
    Text = "<TouquKeywords: robo permanente>"
  },
  State_100647_Desc = {
    Text = "Inmunidad a todo daño."
  },
  State_100647_Name = {
    Text = "Inmunidad a todo daño."
  },
  State_100694_Desc = {
    Text = "Por cada capa, el daño básico causado por el jugador se reduce en un 30%, y después de causar daño activo o daño de tentáculo, se reduce el veneno propio."
  },
  State_100694_Name = {
    Text = "Luz Errante"
  },
  State_116342_Desc = {
    Text = "Al jugar una carta de <ErosionColorInkKeywords:Distorsión de Percepción>, El Pintor obtiene 1 acumulación de <DecayDye:Tinte del mundo ilusorio>."
  },
  State_116342_Name = {
    Text = "Paleta de Ilusiones"
  },
  State_116406_Name = {Text = "Avanzado"},
  State_116407_Name = {
    Text = "Estado vacío"
  },
  State_116858_Desc = {
    Text = "Este estado utiliza un área de multiplicador de vulnerable, fingiendo ser un área de multiplicador independiente.__\"Solo para uso en desarrollo\""
  },
  State_116858_Name = {
    Text = "Si posees cierto estado, el daño se duplicará __\"Solo para desarrollo\""
  },
  State_116859_Desc = {
    Text = "Al inicio del próximo turno, obtén defecto."
  },
  State_116859_Name = {
    Text = "Defecto de latencia"
  },
  State_116958_Desc = {
    Text = "Después de jugar la carta, recibe daño correspondiente a la cantidad de acumulaciones."
  },
  State_116958_Name = {
    Text = "<PVPCardLockColour:Bloqueo de cartas>"
  },
  State_117154_Desc = {
    Text = "Este efecto solo se activará una vez en todos los Despertados del equipo y no puede activarse repetidamente."
  },
  State_117154_Name = {
    Text = "<TeamUnique: Equipo Único>"
  },
  State_117212_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Antes de usar «Habilidad» y al final del turno, aplica <Damage:[Damage:StateArg1]> capas de <PVPCorrosionKeywords:marca del pecado> al enemigo con <HPAndShieldMax:mayor vida y escudo>."
  },
  State_117212_Name = {Text = "Pólux"},
  State_117213_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al final de la \"habilidad\" y del turno, causa [StateArg1] <PVPfengsuoKeywords:Bloqueo de Exaltación> al enemigo con más Alienación."
  },
  State_117213_Name = {
    Text = "Pólux SR (Texto temporal)"
  },
  State_117346_Desc = {
    Text = "El daño causado por Pollux aplica un [Layer]% de sangrado adicional."
  },
  State_117346_Name = {
    Text = "Sello del pecado"
  },
  State_117355_Desc = {
    Text = "La próxima tarjeta de comando que juegue Pollux tendrá efecto 2 veces."
  },
  State_117355_Name = {
    Text = "Nuevo Pacto Divino"
  },
  State_117357_Desc = {
    Text = "Equipo Único: Después de que \"D-mark\" y \"Ruinas Cenicientas\" se refresquen, el portador obtiene <WeaponEffect_Num:[StateArg1]> puntos de alienación."
  },
  State_117357_WeaponDesc = {
    Text = "Después de refrescar \"D-mark\" y \"Ruinas Cenicientas\", el portador obtiene <WeaponEffect_Num:[StateArg1]> puntos de alienación."
  },
  State_117358_Desc = {
    Text = "Cada capa hace que el daño de Pollux aplique un 1% adicional de sangrado."
  },
  State_117358_Name = {
    Text = "<ZuiyinKeywords:Sello del pecado>"
  },
  State_117744_Desc = {
    Text = "<MaxHPKeywords:PV Max> -[Layer]. Al activarse, recibe [Layer] puntos de Daño pasivo. Permanente. Al ser disipado, el PV Max del objetivo no se regenerará."
  },
  State_117744_Name = {
    Text = "Sello del pecado"
  },
  State_117745_Desc = {
    Text = "Cada acumulación reduce el <MaxHPKeywords:PV Max> del objetivo. Cuando se activa el Sello del pecado, el objetivo recibe Daño Pasivo igual al número de acumulaciones. Al ser disipado, el PV Max del objetivo no se regenerará."
  },
  State_117745_Name = {
    Text = "<PVPCorrosionKeywords:Sello del pecado>"
  },
  State_117755_Desc = {
    Text = "Antes de que termine el turno, no puedes realizar ninguna acción"
  },
  State_117755_Name = {
    Text = "Se desmayó"
  },
  State_117756_Desc = {
    Text = "Antes de que termine el turno, no puedes realizar ninguna acción"
  },
  State_117756_Name = {
    Text = "Se desmayó"
  },
  State_117776_Desc = {
    Text = "En este turno, el daño final y el blindaje de [Layer] cartas de comando aumentan en [StateArg1]％."
  },
  State_117776_Name = {
    Text = "Llama divina"
  },
  State_117777_Desc = {
    Text = "Equipo Único: El daño básico y el daño crítico de las cartas del portador aumentan en <WeaponEffect_Num:[StateArg1]%. Al comienzo del turno y después de que el portador libera la Exaltación, obtiene 1 capa de Fuego del corazón. Cuando el portador juega una tarjeta de comando en este turno, consume 1 capa de \"Fuego del corazón\", aumentando su Daño Final y Blindaje en <WeaponEffect_Num:[StateArg2]%. En un Turno Ultra, se obtiene \"Llama divina\" y el efecto se duplica."
  },
  State_117777_WeaponDesc = {
    Text = "El daño básico y el daño crítico causado por las cartas del portador aumentan en <WeaponEffect_Num:[StateArg1]%>. Al comienzo del turno y después de que el portador libera la exaltación, obtiene 1 capa de fuego del corazón; al jugar cartas de comando en este turno, el portador consume 1 capa de \"fuego del corazón\", aumentando su daño final y escudo en <WeaponEffect_Num:[StateArg2]%>. En el turno ultra, se obtiene \"llama divina\", y el efecto se duplica."
  },
  State_117778_Desc = {
    Text = "En este turno, el daño final y el blindaje de [Layer] cartas de comando aumentan en [StateArg1]%."
  },
  State_117778_Name = {
    Text = "Fuego del corazón"
  },
  State_117779_Desc = {
    Text = "Equipo Único: En turno Ultra, el portador gana 3 capas de \"Fuego del corazón\". Cuando el portador juega cartas de comando en este turno, consume 1 capa, aumentando su Daño Final y escudo en <WeaponEffect_Num:[StateArg1]%>."
  },
  State_117779_WeaponDesc = {
    Text = "En el turno Ultra, el portador obtiene 3 capas de \"Fuego del corazón\"; al jugar cartas de comando en este turno, consume 1 capa, aumentando su daño final y escudo en <WeaponEffect_Num:[StateArg1]%>."
  },
  State_117851_Desc = {
    Text = "Pollux disfruta de un 50% de efecto de \"Redención de Agonía\" adicional por cada tarjeta de comando, durante [Layer] turnos."
  },
  State_117851_Name = {
    Text = "Luz que ilumina la noche blanca"
  },
  State_117853_Desc = {
    Text = "Pollux, el daño de las siguientes [Layer] cartas de comando jugadas en este turno aumenta en [DescArg1], el escudo mejora en [DescArg2], y obtienes 10 puntos de alienación."
  },
  State_117853_Name = {
    Text = "Redención de Agonía"
  },
  State_117869_Desc = {
    Text = "Cada vez que se libera una explosión de locura, aumenta 1 capa de \"Llamar\"; cada capa de Llamar otorga [DescArg1] puntos de fuerza, con un límite de 5 capas."
  },
  State_117869_Name = {
    Text = "Sacerdotisa marinera"
  },
  State_117870_Desc = {
    Text = "Después de la muerte, el asesino restaura el 20% del hp perdido."
  },
  State_117870_Name = {
    Text = "sashimi delicioso"
  },
  State_117875_Desc = {
    Text = "Si hay espacios vacíos en la fila trasera, después de la acción, pierde 1 capa y convoca 1 \"Sushi Delicioso\" \"Fritura\""
  },
  State_117875_Name = {
    Text = "Contrato: enjambre"
  },
  State_117876_Desc = {
    Text = "Los efectos de <WeaknessIconKeywords:debilidad>, <FragileIconKeywords:frágil>, y <HeavyInjuryKeywords:aflicción> aumentan al 50%."
  },
  State_117876_Name = {
    Text = "Debilidad&Frágil&Herida Grave Agravada"
  },
  State_117880_Desc = {
    Text = "En esta batalla, el \"Salto de Cardumen\" se activará 1 vez adicionalmente."
  },
  State_117880_Name = {
    Text = "Activación extra del cardumen saltando"
  },
  State_117883_Desc = {
    Text = "Al alcanzar 5 capas, sella inmediatamente a todos los Despertados y cambia la intención a: \"¡Gloria de Lemuria!+\"."
  },
  State_117883_Name = {Text = "Llamar"},
  State_117885_Desc = {
    Text = "Al recibir el efecto de reducción de poder, también se aplicará un efecto de reducción de poder igual al que lo aplica."
  },
  State_117885_Name = {
    Text = "Ojo por ojo"
  },
  State_117889_Desc = {
    Text = "Al entrar, tu hp máximo aumenta un 10% y otorga a otros aliados un disparo extra de [DescArg1] <PowerIconKeywords:strength> para el <FishLeapWords:Power of Cohort> en esta batalla."
  },
  State_117889_Name = {
    Text = "Poder de enjambre"
  },
  State_118112_Desc = {
    Text = "El daño único recibido tiene un límite de [DescArg1] puntos, se elimina si la vida es inferior al 50%."
  },
  State_118112_Name = {
    Text = "Umbral de dolor I"
  },
  State_118113_Desc = {
    Text = "Al recibir daño activo y perder vida, obtén un escudo equivalente al 15% de la vida perdida y una <AlertIconKeywords:precaución temporal> equivalente al 5% de la vida perdida."
  },
  State_118113_Name = {
    Text = "Características de cuerpo blando I"
  },
  State_118114_Desc = {
    Text = "Al recibir daño activo y perder vida, obtén un escudo equivalente al 35% de la vida perdida y una <AlertIconKeywords:precaución temporal> equivalente al 10% de la vida perdida."
  },
  State_118114_Name = {
    Text = "Características de cuerpo blando III"
  },
  State_118115_Desc = {
    Text = "Si hay espacios vacíos en la fila delantera, después de la acción, pierde 1 capa y convoca 1 \"División del Mar Profundo\""
  },
  State_118115_Name = {
    Text = "Contrato de cooperación: Excrescencia abisal"
  },
  State_118116_Desc = {
    Text = "El daño único recibido tiene un límite de [DescArg1] puntos, se elimina si la vida es inferior al 50%."
  },
  State_118116_Name = {
    Text = "Umbral de dolor II"
  },
  State_118117_Desc = {
    Text = "El daño único recibido tiene un límite de [DescArg1] puntos, se elimina si la vida es inferior al 50%."
  },
  State_118117_Name = {
    Text = "Umbral de dolor III"
  },
  State_118118_Desc = {
    Text = "Obtén 1 Tentáculo con <TentacleInjurieIconKeywords:Daño de tentáculos> igual a [TentaclePower:DescArg1] y 5 de Límite de tentáculos. Al final del turno, obtén 1 Tentáculo. Los efectos de reducción de Fortaleza se reducen en un 50%."
  },
  State_118118_Name = {
    Text = "Asamblea de tentáculos"
  },
  State_118119_Desc = {
    Text = "Al recibir daño activo y perder vida, obtén un escudo equivalente al 25% de la vida perdida y una <AlertIconKeywords:precaución temporal> equivalente al 5% de la vida perdida."
  },
  State_118119_Name = {
    Text = "Características de cuerpo blando II"
  },
  State_118319_Desc = {
    Text = "El daño único recibido tiene un límite de [DescArg1] puntos, se elimina si la vida es inferior al 50%."
  },
  State_118319_Name = {
    Text = "Límite de daño del escudo del abismo"
  },
  State_118320_Name = {
    Text = "Contador temporal de contramedidas de agotamiento"
  },
  State_118321_Name = {
    Text = "Contador de contramedidas de agotamiento"
  },
  State_118322_Name = {
    Text = "Marca de preparación para invocación"
  },
  State_118323_Desc = {
    Text = "Activado el cardumen saltando"
  },
  State_118323_Name = {
    Text = "Marca de entrada del cardumen saltando"
  },
  State_118324_Desc = {
    Text = "Cada vez que se inflige daño, se genera un tentáculo temporal."
  },
  State_118324_Name = {
    Text = "Gracia Divina"
  },
  State_118325_Desc = {
    Text = "Al causar daño no bloqueado, baraja [DescArg1] cartas de asfixia en la parte superior del mazo de robo"
  },
  State_118325_Name = {
    Text = "Hombre serpiente del nuevo mundo tembloroso"
  },
  State_118656_Desc = {
    Text = "Al jugar una carta, recibe [StateArg1] puntos de daño y elimina 1 capa. Cuando las capas sean 0, eclosiona una \"Criatura del mar\" más débil. Si al final del turno aún existe el estado de parásito, eclosiona una \"Criatura del mar\" cuya vida aumenta con las capas"
  },
  State_118656_Name = {
    Text = "Parasitado múltiples veces"
  },
  State_118657_Desc = {
    Text = "Al jugar una carta, recibe [StateArg1] puntos de daño y elimina 1 capa. Cuando las capas sean 0, eclosiona una \"Criatura del mar\" más débil. Si al final del turno aún existe el estado de parásito, eclosiona una \"Criatura del mar\" cuya vida aumenta con las capas"
  },
  State_118657_Name = {
    Text = "Ser Parasitado Nuevamente"
  },
  State_118659_Desc = {
    Text = "Al jugar una carta, recibe [StateArg1] puntos de daño y elimina 1 capa. Cuando las capas sean 0, eclosiona una \"Criatura del mar\" más débil. Si al final del turno aún existe el estado de parásito, eclosiona una \"Criatura del mar\" cuya vida aumenta con las capas"
  },
  State_118659_Name = {Text = "Parasitado"},
  State_118663_Name = {
    Text = "Escucha de intención del Hombre serpiente del nuevo mundo"
  },
  State_118669_Name = {
    Text = "Inicialización del Hombre serpiente del nuevo mundo"
  },
  State_118670_Desc = {
    Text = "Detección de contramedidas de agotamiento"
  },
  State_118670_Name = {
    Text = "Detección de contramedidas de agotamiento"
  },
  State_118671_Desc = {
    Text = "Detección del comportamiento de agotamiento del jugador"
  },
  State_118671_Name = {
    Text = "Escucha de contramedidas de agotamiento"
  },
  State_118672_Name = {
    Text = "Escucha de intención del Hombre serpiente del nuevo mundo en enfriamiento"
  },
  State_118741_Name = {
    Text = "Eliminar tentáculos temporales"
  },
  State_118743_Name = {
    Text = "Preparar la posición previa para convocar requiere una marca de invocación"
  },
  State_118759_Name = {
    Text = "Número actual de tentáculos permanentes de monstruo"
  },
  State_118760_Name = {
    Text = "Límite de tentáculos permanentes de monstruo"
  },
  State_118762_Name = {
    Text = "Sugerencia de decaimiento inicial"
  },
  State_118763_Name = {
    Text = "Sugerencia de neurotoxina-sangre inicial"
  },
  State_118764_Name = {
    Text = "Sugerencia de Susurro de Maldición inicial"
  },
  State_118766_Name = {
    Text = "Escucha de intención del BOSS de pulpo de anillo azul"
  },
  State_118769_Name = {
    Text = "Sugerencia de linterna de núcleo de plata"
  },
  State_118771_Name = {
    Text = "Sugerencia de prueba inicial"
  },
  State_118772_Name = {
    Text = "Sugerencia de desgarradora de serpientes por primera vez"
  },
  State_118935_Name = {
    Text = "Escucha de intención del monstruo Murphy"
  },
  State_118938_Desc = {
    Text = "¡La Dama de las Profundidades ha Despertado, aumentando enormemente la cantidad de Blindaje creado!"
  },
  State_118938_Name = {
    Text = "Hecho en existencia"
  },
  State_118943_Desc = {
    Text = "El daño recibido durante el propio turno se duplica. Al perder vida, se pierden un número igual de capas. Cuando la cantidad de capas es 0, se reduce permanentemente el número de tentáculos en 1 y se reinician las capas, con un mínimo de 1 tentáculo."
  },
  State_118943_Name = {
    Text = "Sacrificio de Deipara"
  },
  State_118973_Name = {
    Text = "Gestión de la rebelión contenida"
  },
  State_119051_Desc = {
    Text = "Se activa al final del turno: recibe esta cantidad de Daño pasivo y se elimina la mitad de las acumulaciones, no se puede disipar."
  },
  State_119051_Name = {
    Text = "<PVPSacrificeKeyWords:Ritual de sacrificio>"
  },
  State_119052_Desc = {
    Text = "Después de recibir daño activo, obtiene [Layer]% de Ritual de sacrificio."
  },
  State_119052_Name = {
    Text = "Ritual de nacimiento"
  },
  State_119053_Desc = {
    Text = "Se activa al final del turno: inflige [Layer] puntos de daño pasivo y elimina la mitad de las acumulaciones, no se puede disipar."
  },
  State_119053_Name = {
    Text = "Ritual de sacrificio"
  },
  State_119058_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al final del turno, aplica [StateArg1] de <PVPSacrificeKeyWords:Ritual de sacrificio> al enemigo con menos Ritual de sacrificio, repitiendo [StateArg2] veces. Todos los aliados dejan de verse afectados por los efectos de reducción del <PVPCapKeywords:Límite de Aritmética>."
  },
  State_119058_Name = {
    Text = "Sueño en la Oscuridad"
  },
  State_119059_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Después de\"exaltar\", todos los enemigos que reciban daño activo en este turno obtienen un ritual de sacrificio del [StateArg1]% del daño."
  },
  State_119059_Name = {
    Text = "Toxina del anillo azul"
  },
  State_119060_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>:\"golpear\"aumenta el daño un [StateArg1]%, y después de que cualquier aliado juegue un \"golpe\"roba [StateArg3] cartas, se puede activar un máximo de [StateArg2] veces por turno (actualmente se ha activado [DescArg1] veces)."
  },
  State_119060_Name = {
    Text = "Matanza hasta el fin del mundo"
  },
  State_119061_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>:Aumenta el daño de \"golpear\" de todos los aliados en un [StateArg1]%."
  },
  State_119061_Name = {
    Text = "Luz de la razón"
  },
  State_119063_Desc = {
    Text = "Al alcanzar 5 capas, la intención cambia a: \"¡Gloria de Lemuria!\"."
  },
  State_119063_Name = {Text = "Llamar"},
  State_119075_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_119075_Name = {
    Text = "No Activado"
  },
  State_119076_Desc = {
    Text = "Si hay espacio disponible en la fila delantera, pierde 1 capa después de la acción e invoca aleatoriamente 1 \"Despertado de Lemuria\"."
  },
  State_119076_Name = {
    Text = "Contrato: Lemuria"
  },
  State_119077_Desc = {
    Text = "\"Llamar\" alcanza 5 capas y sella inmediatamente todos los Despertados."
  },
  State_119077_Name = {
    Text = "¡Miriam Despertar!"
  },
  State_119077_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_119080_Desc = {
    Text = "Al liberar \"Memoria del Caos\" o \"Crepúsculo Inolvidable\", la Posse seleccionada tendrá efecto 1 vez adicional."
  },
  State_119080_Name = {
    Text = "Venido del olvido"
  },
  State_119082_Desc = {
    Text = "Cada vez que un Despertado libera Exaltar, su Aliemus Base +10."
  },
  State_119082_Name = {
    Text = "Agotamiento de la locura"
  },
  State_119083_Desc = {
    Text = "Cuando la tarjeta de comando se toma del espacio hiperspacial, el coste de aritmética se reduce en -1."
  },
  State_119083_Name = {
    Text = "El final del otro mundo"
  },
  State_119084_Desc = {
    Text = "Cada vez que se libera la Posse, la Keyflare requerida +100."
  },
  State_119084_Name = {
    Text = "Oscilación de la llave de plata"
  },
  State_119085_Desc = {
    Text = "Después de usar el Horno Carmesí, transforma 1 Embrión en Vástago de la Pureza, con un tiempo de enfriamiento de 3 turnos."
  },
  State_119085_Name = {
    Text = "Carmesí de crianza"
  },
  State_119086_Desc = {
    Text = "La fuerza de cría está en enfriamiento, queda [Layer] turnos."
  },
  State_119086_Name = {
    Text = "Poder de Cría - Enfriando"
  },
  State_119104_Desc = {
    Text = "Al comienzo de la ronda, gana [DescArg1] capas de \"Contrato de Vida\""
  },
  State_119104_Name = {
    Text = "Ritual del mar"
  },
  State_119105_Desc = {
    Text = "Después de la muerte, pierde todos los \"contratos de vida\". Restaura el 1% del hp máximo por cada capa y aumenta el daño de tentáculos en un 1%."
  },
  State_119105_Name = {
    Text = "Umbral del destino"
  },
  State_119106_Name = {
    Text = "Escucha de intención del monstruo Danwang Murphy"
  },
  State_119107_Name = {
    Text = "Gestión del orden del Reino Divino"
  },
  State_119108_Desc = {
    Text = "Al perder hp, por cada 1 capa se gana el 1% de hp perdido como<SacrificeKeyWord:sacrificio>."
  },
  State_119108_Name = {
    Text = "Ritual de nacimiento"
  },
  State_119109_Desc = {
    Text = "Al recibir daño de fuentes distintas a <SacrificeKeyWord:Sacrificio>, pierde una cantidad equivalente de \"Orden del Reino Divino\" y obtiene un <SacrificeKeyWord:Sacrificio> equivalente al 50% del daño. Al llegar a 0 capas, obtiene 1 capa de \"Pacto del destino\" y reinicia las capas."
  },
  State_119109_Name = {
    Text = "Orden del Reino Divino"
  },
  State_119132_Desc = {
    Text = "La daño de \"golpear\" en esta ronda aumenta [Layer]%."
  },
  State_119132_Name = {
    Text = "Golpe & Fortalecer"
  },
  State_119134_Name = {
    Text = "Sugerencia de Pionero de la ilusión inicial"
  },
  State_119359_Name = {
    Text = "Cantidad de rituales de la llave de plata"
  },
  State_119362_Name = {
    Text = "Realizar el ritual"
  },
  State_119363_Name = {
    Text = "Poseer cartas"
  },
  State_119364_Name = {
    Text = "Contador de ritual de alienación"
  },
  State_119365_Desc = {
    Text = "Todos los Despertados obtienen un aumento del 40% en la recuperación de PV y el blindaje."
  },
  State_119365_Name = {
    Text = "Calma y serena"
  },
  State_119366_Desc = {
    Text = "Vuelve a tu mano al descartarla"
  },
  State_119366_Name = {
    Text = "Vuelve a tu mano al descartarla"
  },
  State_119367_Name = {
    Text = "Conteo del Rito de Vida"
  },
  State_119368_Desc = {
    Text = "Obtén 500 puntos de energía de llave plateada al comienzo de cada turno."
  },
  State_119368_Name = {
    Text = "Ver con claridad"
  },
  State_119369_Desc = {
    Text = "La Locura causada por todos los Despertados aumenta en 50%."
  },
  State_119369_Name = {
    Text = "Orden de gran peso"
  },
  State_119370_Name = {Text = "Reliquia"},
  State_119373_Name = {
    Text = "El enemigo impone sacrificio"
  },
  State_119567_Name = {
    Text = "Rito completado"
  },
  State_119568_Desc = {
    Text = "Aumenta el daño de golpe recibido en [Layer] puntos."
  },
  State_119568_Name = {
    Text = "golpear más profundo"
  },
  State_119583_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: Antes de \"golpear\", antes de \"habilidad\", antes de \"Exaltar\", <StrongEffectKeywords:amplificación> temporal +[StateArg1], cada efecto solo puede activarse una vez por turno."
  },
  State_119583_Name = {
    Text = "Tú y yo, al final nos reencontraremos"
  },
  State_119588_Name = {
    Text = "Carne y sangre cd"
  },
  State_119589_Name = {Text = "Ultra cd"},
  State_119590_Desc = {
    Text = "Equipo Único: Después de cambiar de Postura de tentáculo, usar el Horno Carmesí o desatar \"Aniquilación\", roba la Tarjeta de comando del Portador ×1; cada efecto tiene un tiempo de reutilización de 3 turnos. Tras la Exploración, todos los Despertados del equipo ganan +<WeaponEffect_Num:[StateArg1]%> de Tasa de sincronización."
  },
  State_119590_WeaponDesc = {
    Text = "Cambia activamente a la Postura de tentáculo (actualmente con un enfriamiento restante de [DescArg1] turnos), usa el Horno Carmesí (actualmente con un enfriamiento restante de [DescArg2] turnos), después de liberar \"Aniquilación\" (actualmente con un enfriamiento restante de [DescArg3] turnos), roba 1 carta de comando del portador, cada efecto tiene un enfriamiento de 3 turnos. Al completar la exploración, la tasa de sincronización obtenida por todos los Despertados aumenta en <WeaponEffect_Num:[StateArg1]%>."
  },
  State_119591_Name = {
    Text = "CD del mar profundo"
  },
  State_119741_Desc = {
    Text = "Todos los Despertados obtienen el efecto de Fuerza reducido en un 50%."
  },
  State_119741_Name = {
    Text = "Maldición de la estatua: Lamento de la decadencia"
  },
  State_119742_Desc = {
    Text = "Al comenzar cada turno, responde el 15% de la vida perdida."
  },
  State_119742_Name = {
    Text = "Bendición del ícono: Sueño eterno"
  },
  State_119743_Desc = {
    Text = "Todos los Despertados tienen su recuperación de PV reducida en un 50%."
  },
  State_119743_Name = {
    Text = "Maldición de la imagen sagrada: Odio de la destrucción"
  },
  State_119744_Desc = {
    Text = "\"Maldición de la imagen sagrada: Odio de la destrucción\" inactiva durante 1 turno."
  },
  State_119744_Name = {
    Text = "Inmunidad a la Maldición de la imagen sagrada: Odio de la destrucción"
  },
  State_119746_Name = {
    Text = "Cerradura dimensional de veces perdidas"
  },
  State_119747_Desc = {
    Text = "No recibirá daño, dura 1 turno."
  },
  State_119747_Name = {
    Text = "Llave de plata, guía del camino"
  },
  State_119748_Desc = {
    Text = "\"Maldición de la estatua: Lamento de la decadencia\"inactiva durante 1 turno."
  },
  State_119748_Name = {
    Text = "Inmunidad a la Maldición de la estatua: Lamento de la decadencia"
  },
  State_119749_Desc = {
    Text = "Al comienzo del turno del guardián, aplica 1 capa de <SlowIconKeywords:estancamiento> a las cartas en la mano equivalentes a las capas de \"<Abyssallock:Sueños encadenados>\"."
  },
  State_119749_Name = {
    Text = "Sueños encadenados"
  },
  State_119750_Name = {
    Text = "Escucha de intención del telón del cielo"
  },
  State_119751_Name = {
    Text = "Marca de liberación de la reproducción del telón"
  },
  State_119752_Desc = {
    Text = "Al comienzo de cada turno, obtiene un <PowerIconKeywords:fuerza> igual al 5% de la vida máxima, la tasa de crítico temporal +25%."
  },
  State_119752_Name = {
    Text = "Bendición de la imagen sagrada: Sueño de poder"
  },
  State_119753_Name = {
    Text = "Contador de la Marea del abismo tenue"
  },
  State_119754_Desc = {
    Text = "La Locura causada por los Despertados se reduce en 50%"
  },
  State_119754_Name = {
    Text = "Maldición del ícono: Susurro de necedad"
  },
  State_119755_Name = {
    Text = "Contador de muertes"
  },
  State_119756_Desc = {
    Text = "\"Maldición del ícono: Susurro de necedad\"inactiva 1 turno."
  },
  State_119756_Name = {
    Text = "Inmunidad a la Maldición del ícono: Susurro de necedad"
  },
  State_119757_Desc = {
    Text = "Al comienzo del turno del Guardián, aplica 1 capa de <SlowIconKeywords:Estancamiento> a las cartas en mano equivalentes a las capas de <Abyssallock:Sueños encadenados>. Cada vez que el \"Telón del Paraíso\" sea roto por Daño Activo, se reduce 1 capa y el Cuerpo Despertado atacante queda sellado completamente durante 1 turno."
  },
  State_119757_Name = {
    Text = "Sueños encadenados"
  },
  State_119758_Desc = {
    Text = "Al inicio de cada turno, todos los Despertados obtienen 10 puntos de Alienación."
  },
  State_119758_Name = {
    Text = "Bendición del Ícono: Sueño de Sabiduría"
  },
  State_119760_Name = {
    Text = "Escucha de muerte"
  },
  State_119789_Desc = {
    Text = "Al inicio del turno, recupera [Layer] de vida."
  },
  State_119789_Name = {
    Text = "Flor de lodo"
  },
  State_119837_Desc = {
    Text = "La próxima carta de comando que Ramona juegue en este turno tendrá efecto 2 veces."
  },
  State_119837_Name = {
    Text = "Tomarse de nuevo de la mano"
  },
  State_119847_Desc = {
    Text = "Cambia la aritmética de la carta antes de jugar.__\"Solo para desarrollo\""
  },
  State_119847_Name = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar__\"Solo para desarrollo\""
  },
  State_119928_Desc = {
    Text = "Efecto adicional [StateArg1] veces al jugarla, <DepleteIconKeywords:Consumo>. <RippleKeywords:Réplica>: Roba 2 cartas."
  },
  State_119928_Name = {
    Text = "<Rune_20:Eco de las Profundidades>"
  },
  State_119958_Desc = {
    Text = "Después de morir, convoca un \"Cardumen\" aleatorio y reduce 1 capa de su \"Migración de peces\"."
  },
  State_119958_Name = {
    Text = "Migración de peces"
  },
  State_119959_Desc = {
    Text = "Al morir, invoca inmediatamente a una \"Colmena embrionaria\" aleatoria, reduciendo 1 capa de \"Vida eterna\"."
  },
  State_119959_Name = {
    Text = "Vida eterna"
  },
  State_119960_Desc = {
    Text = "Daño Activo y Daño de tentáculos infligido –35%. Este estado se disipa cuando tu PV actual supera el 50%."
  },
  State_119960_Name = {
    Text = "<PurpleKeyWord:podredumbre>"
  },
  State_120215_Desc = {
    Text = "Al comienzo del turno del Guardián, aplica 1 capa de <SlowIconKeywords:Estancamiento> a las cartas en mano equivalentes a las capas de <Abyssallock:Sueños encadenados>. Cada vez que el \"Telón del Paraíso\" sea roto por Daño Activo, se reduce 1 capa y el Cuerpo Despertado atacante queda sellado completamente durante 1 turno."
  },
  State_120215_Name = {
    Text = "Cerradura dimensional"
  },
  State_120216_Desc = {
    Text = "Al comienzo del turno del <Guardián>, aplica 1 capa de <SlowIconKeywords:estancamiento> a la mano igual a las capas de \"<Abyssallock:Cerradura dimensional>\"."
  },
  State_120216_Name = {
    Text = "Cerradura dimensional"
  },
  State_120218_Name = {
    Text = "Fin del turno, elige apoyo de Murphy"
  },
  State_120222_Name = {
    Text = "Elige revertir la maldición al comienzo del turno"
  },
  State_120292_Name = {
    Text = "Dolor No Aceptado"
  },
  State_120293_Desc = {
    Text = "Al final del turno, recupera [Layer] de vida"
  },
  State_120293_Name = {
    Text = "Dolor No Aceptado"
  },
  State_120312_Desc = {
    Text = "Al morir, convoca inmediatamente a un \"Rey de los peces\" aleatorio, reduciendo 1 capa de su \"Migración de peces\"."
  },
  State_120312_Name = {
    Text = "Migración de peces"
  },
  State_120320_Desc = {
    Text = "Cada capa aumenta en un 20% el \"Ritual de nacimiento\" aplicado por la próxima \"Princesa ilusoria\", acumulándose hasta un máximo de 5 capas; al alcanzar 5 capas, el número de veces que inflige daño la próxima \"Princesa ilusoria\" se duplica."
  },
  State_120320_Name = {
    Text = "Pacto del destino"
  },
  State_120321_Desc = {
    Text = "Cada Acumulación inflige Acumulaciones de \"Sacrificio\" equivalentes al 1% del Daño Activo o de Tentáculos recibido. Se acumula hasta 75. Se elimina al final del turno."
  },
  State_120321_Name = {
    Text = "<DwmofeiKeywords:Ritual de nacimiento>"
  },
  State_120322_Desc = {
    Text = "Equipo Único: Tamaño Máximo de la Mano +2, no se puede apilar con el tamaño máximo de mano proporcionado por otras Ruedas del Destino. La Regeneración de Llave Plateada del portador, el Daño Final causado por la Exaltar y el Escudo mejorado aumentan <WeaponEffect_Num:[StateArg1]％>. Al cambiar a la postura de \"Mar tranquilo\", el portador obtiene <WeaponEffect_Num:[StateArg2]> puntos de Alienación, con un tiempo de recarga de 3 rondas. Al cambiar a la postura de \"Olas furiosas\", aplica <WeaponEffect_Num:[StateArg3]> capas de <DwmofeiKeywords:Ritual de nacimiento> a todos los enemigos, con un tiempo de recarga de 3 rondas."
  },
  State_120322_WeaponDesc = {
    Text = "Tamaño Máximo de la Mano +2, no se puede apilar con el tamaño de mano proporcionado por otras Ruedas del destino. El daño final causado por la regeneración de Llave Plateada del portador y la explosión de locura, así como el escudo mejorado, aumenta <WeaponEffect_Num:[StateArg1]>. Al cambiar a la postura de \"Mar tranquilo\", el portador gana <WeaponEffect_Num:[StateArg2]> puntos de alienación, con un enfriamiento de 3 turnos. Al cambiar a la postura de \"Olas furiosas\", aplica <WeaponEffect_Num:[StateArg3]> capas de <DwmofeiKeywords:Ritual de nacimiento> a todos los enemigos, con un enfriamiento de 3 turnos."
  },
  State_120324_Desc = {
    Text = "Cada acumulación inflige acumulaciones de \"Sacrificio\" iguales al [Layer]% del Daño Activo o Daño de tentáculos recibido. Se acumula hasta 75. Se elimina al final del turno."
  },
  State_120324_Name = {
    Text = "Ritual de nacimiento"
  },
  State_120351_Desc = {
    Text = "[Layer] puede volver a cambiar a\"Reino Divino·Mar tranquilo\" después de la ronda."
  },
  State_120351_Name = {
    Text = "Reino Divino·Mar tranquilo en enfriamiento"
  },
  State_120354_Desc = {
    Text = "[Layer] podrás volver a cambiar a\"Reino Divino·Olas furiosas\" después de la ronda."
  },
  State_120354_Name = {
    Text = "Reino Divino·Olas furiosas en enfriamiento"
  },
  State_120357_Name = {Text = "Tentáculo"},
  State_120362_Desc = {
    Text = "Al recibir daño que no sea de <SacrificeKeyWord:Sacrificio>, obtiene el 50% del daño como <SacrificeKeyWord:Sacrificio>"
  },
  State_120362_Name = {
    Text = "Gestión de sacrificios de monstruos genéricos"
  },
  State_120363_Desc = {
    Text = "Después de que termine el turno, recibe [Layer] de daño y reduce un 50% las capas de <SacrificeKeyWord:Ritual de sacrificio>."
  },
  State_120363_Name = {
    Text = "<BlueKeyWord:Sacrificio>"
  },
  State_120364_Desc = {
    Text = "Invocar \"Guardia del Marchador de Mares\" tras tu propia muerte."
  },
  State_120364_Name = {
    Text = "La fe perdura"
  },
  State_120401_Desc = {
    Text = "El consumo de aritmética de esta carta se reduce en -[StateArg5], después de jugar, roba [StateArg4] cartas."
  },
  State_120401_Name = {
    Text = "<OrangeQuality:Insignia de Mythag>"
  },
  State_120450_Name = {
    Text = "El pulpo de anillo azul registra la vida del jugador"
  },
  State_120462_Desc = {
    Text = "Permanece en el mazo después del combate, pero se elimina permanentemente al ser jugada o consumida."
  },
  State_120462_Name = {
    Text = "<DestructionKeywords:Destruir>"
  },
  State_120900_Name = {
    Text = "Preparar convocar\"Despertado de Lemuria\"contador"
  },
  State_120907_Desc = {
    Text = "Si el ataque de tentáculo es bloqueado, causa [DescArg1] capas de <IntoxicationIconKeywords:veneno>."
  },
  State_120907_Name = {
    Text = "corrientes profundas"
  },
  State_120908_Desc = {
    Text = "Si se bloquea el ataque de tentáculo, se causarán acumulaciones equivalentes de <IntoxicationIconKeywords:veneno>."
  },
  State_120908_Name = {
    Text = "corrientes profundas"
  },
  State_120910_Desc = {
    Text = "El consumo de aritmética de esta carta +[StateArg5], juega [StateArg4] cartas después de jugarla."
  },
  State_120910_Name = {
    Text = "<OrangeQuality:Insignia de Mythag>"
  },
  State_120924_Desc = {
    Text = "Al inicio de la siguiente ronda, obtienes fortaleza."
  },
  State_120924_Name = {
    Text = "Fortaleza de latencia"
  },
  State_120929_Desc = {
    Text = "La carta obtiene Retener, pero al jugarse eliminará la contaminación y convocará 1 \"Excrescencia abisal\". Si no hay espacio para convocar, ganará 1 capa de \"Preparar Convocatoria: Excrescencia abisal\"."
  },
  State_120929_Name = {
    Text = "<SeastriderCurse:La maldición de los marineros>"
  },
  State_120930_Desc = {
    Text = "Si hay un lugar vacío, después de la acción, pierde 1 capa e invoca 1 \"Excrescencia abisal\"."
  },
  State_120930_Name = {
    Text = "Contrato de cooperación: Excrescencia abisal"
  },
  State_120934_Desc = {
    Text = "Cada vez que recibes Daño Crítico, obtienes un 3% de <Baojidikang:Res. Crítica Temporal>. Al comienzo de cada turno, añade \"<SeastriderCurse:Maldición del Marchador de mares>\" a 2 cartas."
  },
  State_120934_Name = {
    Text = "Ritual de sacrificio del mar profundo"
  },
  State_120941_Desc = {
    Text = "Amplificará las habilidades del enemigo. Se pierde una capa cada vez que se recibe daño"
  },
  State_120941_Name = {
    Text = "Juramento de Sangre"
  },
  State_121006_Desc = {
    Text = "Equipo Único: La regeneración de Llave Plateada del portador, el daño final causado por la explosión de alienación y el blindaje mejorado aumentan en <WeaponEffect_Num:[StateArg1]%>."
  },
  State_121006_WeaponDesc = {
    Text = "Regeneración de Llave Plateada del portador, daño final causado por la explosión de alienación y escudo mejorado <WeaponEffect_Num:[StateArg1]%>."
  },
  State_121014_Name = {
    Text = "Protección del Feto Sagrado"
  },
  State_121015_Desc = {
    Text = "Al inicio del turno, el escudo no se eliminará. Al tener un escudo, obtienes 50 capas de <ReinforcePVEKeywords:fortaleza>; cuando el escudo se rompa, se elimina <ReinforcePVEKeywords:fortaleza>."
  },
  State_121015_Name = {
    Text = "Protección del Feto Sagrado"
  },
  State_121151_Desc = {
    Text = "La carta obtiene Retener, pero al jugarse eliminará la contaminación y convocará 1 \"Excrescencia abisal\". Si no hay espacio para convocar, ganará 1 capa de \"Preparar Convocatoria: Excrescencia abisal\"."
  },
  State_121151_Name = {
    Text = "<SeastriderCurse:La maldición de los marineros>"
  },
  State_121210_Name = {
    Text = "Otorgar a todos los enemigos un efecto negativo <PVPWonderfulEffectKeywords:efecto maravilloso>, tiene efecto 2 veces"
  },
  State_121211_Name = {
    Text = "Roba 2 cartas, obtén 2 puntos de aritmética"
  },
  State_121212_Name = {
    Text = "Otorgar a todos los aliados un efecto positivo <PVPWonderfulEffectKeywords:efecto maravilloso>, tiene efecto 2 veces"
  },
  State_121213_Desc = {
    Text = "Inmunidad a todo daño."
  },
  State_121213_Name = {
    Text = "Inmunidad a todo daño."
  },
  State_121231_Desc = {
    Text = "Cada capa aumenta en un 20% el \"Ritual de nacimiento\" aplicado por la próxima \"Princesa ilusoria\", acumulándose hasta un máximo de 5 capas; al alcanzar 5 capas, el número de veces que inflige daño la próxima \"Princesa ilusoria\" se duplica."
  },
  State_121231_Name = {
    Text = "<MingqiKeywords:Pacto del destino>"
  },
  State_121365_Desc = {
    Text = "Soporta un [Layer] % de daño de tentáculo adicional."
  },
  State_121377_Name = {
    Text = "<RetainIconKeywords:Retener>: Gana 500 puntos de Llave Plateada al comienzo de cada turno"
  },
  State_121378_Name = {
    Text = "<RetainIconKeywords:Retener>:Todos los Despertados obtienen un aumento del 40% en la recuperación de PV y el blindaje."
  },
  State_121380_Name = {
    Text = "<RetainIconKeywords:Retener>:La Locura causada por todos los Despertados aumenta en 50%"
  },
  State_121719_Name = {
    Text = "<RippleKeywords:réplica>: Roba 1 carta y gana [DescArg1] puntos de <PowerIconKeywords:fuerza> temporal"
  },
  State_121734_Desc = {
    Text = "Por cada carta de comando jugada, descarta 1 carta con el coste de aritmética más bajo de este Despertado."
  },
  State_121734_Name = {
    Text = "Flujo de Locura"
  },
  State_121735_Desc = {
    Text = "El coste de aritmética de todas las cartas de comando aumenta en 1. Cada 3 turnos, al finalizar el turno, coloca 1 carta de \"Petrificarse gradualmente\" en tu mano."
  },
  State_121735_Name = {
    Text = "Torrente de Lamentos"
  },
  State_121736_Desc = {
    Text = "Al final del turno, recupera el 10% de la vida perdida, elimina su propio estado negativo y los estados positivos del jugador."
  },
  State_121736_Name = {
    Text = "Corriente de la Aparición"
  },
  State_121737_Desc = {
    Text = "Al comenzar la batalla, obtén 15 capas de \"Barrera Temporal\". Al final del turno, obtén 15 capas de \"Barrera Temporal\" y aplica \"Disolución Temporal\" a 10 cartas aleatorias."
  },
  State_121737_Name = {
    Text = "Corriente Gélida"
  },
  State_121738_Desc = {
    Text = "El efecto de fuerza aplicado por los Despertados se reduce en un 75%. Cada vez que se pierde PV, se obtiene [DescArg1] puntos de blindaje y 1 capa de fortaleza temporal."
  },
  State_121738_Name = {
    Text = "Flujo de la Fe Perversa"
  },
  State_121739_Desc = {
    Text = "Todos los Despertados aumentan su Límite de locura en un 50%. Al final de cada turno, se les resta 10 puntos de Alienación a todos los Despertados y se recupera el 3% de PV Max."
  },
  State_121739_Name = {
    Text = "Flujo de Terror"
  },
  State_121740_Desc = {
    Text = "Al inicio del combate y al final de cada turno, obtiene 2 capas temporales de <ResentChainsKeywords:Cadena de Rancor>."
  },
  State_121740_Name = {
    Text = "Flujo Eerie"
  },
  State_121797_Desc = {
    Text = "Todo el Daño causado, la Cicatrización y los efectos de Escudo del personaje se reducen en un 10 %, con un límite de 2 capas, no se puede disipar. Cuando el último lanzador de Ebrio muere, todas las capas de Ebrio sobre el objetivo se eliminan."
  },
  State_121797_Name = {
    Text = "<PVPLostSoulKeyWords:Ebrio>"
  },
  State_121798_Desc = {
    Text = "El Daño infligido, la curación y el Efecto de Blindaje se reducen en [DescArg1]%, no puede ser disipado. Límite de 2 acumulaciones.\nSe elimina al Matar a <StatusApplier:>."
  },
  State_121798_Name = {Text = "Ebrio"},
  State_121799_Name = {
    Text = "Capítulo Cuatro: Carta de soporte de Lemuria"
  },
  State_121850_Desc = {
    Text = "Daño de tentáculo reducido en un 80%"
  },
  State_121850_Name = {
    Text = "Goliat: Apoyo"
  },
  State_121863_Name = {
    Text = "<RippleKeywords:Réplica>: Roba 2 cartas"
  },
  State_121878_Name = {
    Text = "Primera selección de la narrativa de la maldición inversa"
  },
  State_122428_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_122428_Name = {
    Text = "No Activado"
  },
  State_122431_Desc = {
    Text = "Cuando Mouchette inflige Daño no bloqueado, gana 2 acumulaciones de <Monster_Fervor:Fervor temporal>."
  },
  State_122431_Name = {
    Text = "Rastro de la niebla"
  },
  State_122441_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equipar, obtienes 3 capas de <PVPReciprocalKeywords:Momento de cuenta regresiva>."
  },
  State_122441_Name = {
    Text = "Momento de cuenta regresiva"
  },
  State_122442_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equipar, obtienes <Block:[Block:StateArg1]> blindaje y <Energy:[Energy:StateArg1]> locura. Al final del turno, esta rueda del destino se des equipa automáticamente, y el locura y el blindaje obtenidos al equipar\"Diversión en la caja\"se incrementan en [StateArg2]."
  },
  State_122442_Name = {
    Text = "Diversión en la caja"
  },
  State_122443_Desc = {
    Text = "Al comenzar el turno, reduce las acumulaciones en 1. Al agotar las acumulaciones, disipa su estado negativo y obtiene 100 de Alienación, luego recupera 3 acumulaciones de Momento de cuenta regresiva. Cambiar la Rueda del destino hará que pierda el estado de Momento de cuenta regresiva."
  },
  State_122443_Name = {
    Text = "<PVPFlowerKeywords:Momento de cuenta regresiva>"
  },
  State_122596_Desc = {
    Text = "No se puede jugar la carta, no se puede liberar el estallido de locura."
  },
  State_122596_Name = {
    Text = "<Seal1:Sellado>"
  },
  State_122636_Desc = {
    Text = "El daño, la curación y el escudo del primer \"habilidad\" jugado en cada turno aumentan en [StateArg1]%."
  },
  State_122636_Name = {
    Text = "Broche de Rubí"
  },
  State_122650_Desc = {
    Text = "Reliquia <OrangeQuality:Guantes Mágicos> añadió esta carta."
  },
  State_122650_Name = {
    Text = "Carta extraña"
  },
  State_122654_Name = {
    Text = "Al comienzo de cada turno y después de que terminen las acciones, intentará reiniciar el mazo vacío del jugador; si no está vacío, no se reiniciará.__\"Solo para uso en desarrollo\""
  },
  State_122706_Name = {
    Text = "<CardKeyWord:Deseo de reencuentro>"
  },
  State_122707_Desc = {
    Text = "Tratar esto como la última \"Habilidad\" jugada este turno. Coste de Aritmética -1."
  },
  State_122707_Name = {
    Text = "<CardKeyWord:Deseo de reencuentro>"
  },
  State_123109_Desc = {
    Text = "Equipo Único: La primera compra de una \"Inscripción\" en \"D-mark\", o la primera compra de artículos con descuento en \"Ruinas Cenicientas\" tiene un <WeaponEffect_Num:[StateArg1]%> de probabilidad de convertirse en 0. Esto puede activarse un máximo de 1 vez por exploración."
  },
  State_123109_WeaponDesc = {
    Text = "En \"D-mark\", la primera compra de \"Inscripción\", o la primera compra de artículos con descuento en \"Ruinas Cenicientas\" necesita un <WeaponEffect_Num:[StateArg1]%> de probabilidad de convertirse en 0. Esto puede activarse un máximo de 1 vez por exploración."
  },
  State_123177_Desc = {
    Text = "Limpia al comienzo del turno. Después de alcanzar 10 acumulaciones, la próxima vez que se juegue una carta, Mouchette actuará de inmediato, eliminando \"Fervor temporal\" y añadiendo la intención \"Explosión humana\"."
  },
  State_123177_Name = {
    Text = "Fervor temporal"
  },
  State_123178_Desc = {
    Text = "El efecto de recuperación de vida de <Guaiwusiwangdikang:Resistencia a la muerte> aumenta a 5 veces. Por cada carta que use el enemigo, obtén 1 capa de <Monster_Fervor:Fervor temporal>."
  },
  State_123178_Name = {
    Text = "mal humor al despertar"
  },
  State_123243_Desc = {
    Text = "Al matar a un enemigo, elimina todas las capas de este estado y obtén la misma cantidad de Aliemus por cada capa eliminada. Límite de 2 capas."
  },
  State_123243_Name = {Text = "remolino"},
  State_123246_Desc = {
    Text = "Al matar a un enemigo, se eliminan todas las Acumulaciones y se obtiene una cantidad igual de Aliemus. Límite de 2 capas."
  },
  State_123246_Name = {
    Text = "<PVPWaterPowerKeyWords:Remolino>"
  },
  State_123294_Desc = {
    Text = "Este turno se han robado [DescArg1] cartas a través de \"golpear\"."
  },
  State_123294_Name = {Text = "Masacre"},
  State_123507_Desc = {
    Text = "Equipo único: Al comenzar la exploración, añade 1 carta de \"Momento de cuenta regresiva: 5\" a la baraja: Después de jugar, roba 1 carta y baraja el siguiente \"Momento de cuenta regresiva\" en el mazo de descarte. \"<DestructionKeywords:Destruir>\". \"Momento de cuenta regresiva: 0\": roba 3 cartas, gana 3 puntos de aritmética y con <WeaponEffect_Num:[StateArg1]%> de probabilidad, baraja \"Momento de cuenta regresiva: 5\" en el mazo de descarte. Retener. \"<DestructionKeywords:Destruir>\"."
  },
  State_123507_WeaponDesc = {
    Text = "Al comenzar la exploración, añade 1 carta de \"Momento de cuenta regresiva: 5\" al mazo: después de jugar, roba 1 carta y baraja la siguiente \"Momento de cuenta regresiva\" en el mazo de descarte. \"<DestructionKeywords:Destruir>\". \"Momento de cuenta regresiva: 0\": roba 3 cartas, gana 3 puntos de aritmética y tienes una probabilidad de <WeaponEffect_Num:[StateArg1]%> de barajar \"Momento de cuenta regresiva: 5\" en el mazo de descarte. Retener. \"<DestructionKeywords:Destruir>\"."
  },
  State_123520_Desc = {
    Text = "Equipo único: Después de liberar la Posse por primera vez en cada turno, hay un <WeaponEffect_Num:[StateArg1]>% de probabilidad de robar 1 \"golpear\" del portador."
  },
  State_123520_WeaponDesc = {
    Text = "Después de liberar la Posse por primera vez en cada turno, hay un <WeaponEffect_Num:[StateArg1]>% de probabilidad de robar 1 \"golpear\" del portador."
  },
  State_123521_Desc = {
    Text = "Equipo Único: El daño base de exaltar y perseguir del portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Después de jugar \"golpear\" de cualquier Despertado en este turno, el daño de \"golpear\" del portador aumenta temporalmente en <WeaponEffect_Num:[StateArg2]%> de su ATQ, pudiendo activarse hasta 8 veces por turno."
  },
  State_123521_WeaponDesc = {
    Text = "El daño base de exaltar y perseguir del portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Después de jugar \"golpe\" de cualquier Despertado en este turno, el daño de \"golpe\" del portador aumenta temporalmente en <WeaponEffect_Num:[DescArg2]>, pudiendo activarse hasta 8 veces por turno."
  },
  State_123810_Desc = {
    Text = "Reemplace la intención actual del enemigo con\"Incapaz de actuar\"."
  },
  State_123810_Name = {
    Text = "<HunmiKeywords:Se desmayó>"
  },
  State_123812_Desc = {
    Text = "Al final del turno, el coste de aritmética se reduce."
  },
  State_123812_Name = {
    Text = "<PrepareKeywords:preparar>"
  },
  State_123994_Desc = {
    Text = "No se puede realizar ninguna acción."
  },
  State_123994_Name = {
    Text = "Sueño refinado"
  },
  State_124010_Desc = {
    Text = "Al inicio del próximo turno, obtén [Layer] aritmética."
  },
  State_124010_Name = {
    Text = "Latencia Aritmética"
  },
  State_124024_Desc = {
    Text = "Este turno se han jugado [Layer] cartas de golpe, activando \"Encuentro dramático\" [DescArg1] veces."
  },
  State_124024_Name = {
    Text = "Encuentro dramático"
  },
  State_124034_Desc = {
    Text = "El daño de \"Golpe\" de todos los Despertados aumenta [StateArg1], dura [Layer] turnos."
  },
  State_124034_Name = {
    Text = "Tornado☆Resplandeciente"
  },
  State_124037_Desc = {
    Text = "Mouchette +1 ataque, el daño de todos los Despertados \"golpear\" aumenta [StateArg1], dura [Layer] turnos."
  },
  State_124037_Name = {
    Text = "Tornado☆Resplandeciente"
  },
  State_124107_Desc = {
    Text = "Al morir el \"Brote Estelar\", se vuelve inmune a todo daño y despierta, duplicando su salud máxima y ganando salud máxima equivalente a la vida restante. Tras despertar, disipa todos los estados negativos."
  },
  State_124107_Name = {
    Text = "No Activado"
  },
  State_124108_Name = {
    Text = "Número de voces del más allá"
  },
  State_124109_Desc = {
    Text = "Obtienes un bono adicional del 5% de <PowerIconKeywords:fuerza> de tu <RetaliateIconKeywords:contraataque>. Después de perder [DescArg1] PV en un solo turno, intercambia posiciones con La Cantante"
  },
  State_124109_Name = {
    Text = "Cuna Secundaria"
  },
  State_124111_Desc = {
    Text = "La recuperación de vida de la Resistencia a la muerte se incrementa al 25%. Por cada tarjeta de comando que juegue el enemigo, <TouquKeywords:robar> temporalmente [DescArg1] puntos de <PowerIconKeywords:fuerza>."
  },
  State_124111_Name = {
    Text = "Luz estelar sin límites"
  },
  State_124112_Desc = {
    Text = "Al morir la \"Cantante\", se vuelve inmune a todo daño y despierta, duplicando su salud máxima y ganando salud máxima equivalente a la vida restante."
  },
  State_124112_Name = {
    Text = "No Activado"
  },
  State_124113_Desc = {
    Text = "El oponente no descartará su mano al final de su turno. Al final del turno, aplica en orden 2 capas de <FragileIconKeywords:frágil>, <WeaknessIconKeywords:debilidad>, <HeavyInjuryKeywords:plaga> y <VulnerabilityIconKeywords:vulnerable>."
  },
  State_124113_Name = {
    Text = "Voces del más allá"
  },
  State_124115_Desc = {
    Text = "Los efectos de <FragileIconKeywords:Frágil>, <HeavyInjuryKeywords:Plaga> y <WeaknessIconKeywords:Síntoma: Debilidad> aumentan al 50%. Tras jugar [DescArg1] tarjetas de <SlowIconKeywords:Estancamiento> más, intercambia posición con \"Brote Estelar\"."
  },
  State_124115_Name = {
    Text = "Viajero planetario"
  },
  State_124121_Name = {
    Text = "Número de viajeros planetarios"
  },
  State_124122_Name = {
    Text = "Escucha del jugador viajero planetario"
  },
  State_124190_Desc = {
    Text = "Obtienes un bono adicional del 5% de <PowerIconKeywords:fuerza> de tu <RetaliateIconKeywords:contraataque>."
  },
  State_124190_Name = {
    Text = "Cuna Secundaria"
  },
  State_124193_Name = {
    Text = "El efecto de recuperación de vida de la resistencia a la muerte aumenta al 25%."
  },
  State_124198_Desc = {
    Text = "Los efectos de <FragileIconKeywords:Frágil>, <HeavyInjuryKeywords:Plaga> y <WeaknessIconKeywords:Síntoma: Debilidad> infligidos aumentan al 50%."
  },
  State_124198_Name = {
    Text = "Viajero planetario"
  },
  State_124277_Desc = {
    Text = "Visualización de valores intermedios en el proceso de ejecución."
  },
  State_124277_Name = {
    Text = "Imprimir Valor 2"
  },
  State_124278_Desc = {
    Text = "Visualización de valores intermedios en el proceso de ejecución."
  },
  State_124278_Name = {
    Text = "Imprimir Valor 4"
  },
  State_124279_Desc = {
    Text = "Visualización de valores intermedios en el proceso de ejecución."
  },
  State_124279_Name = {
    Text = "Imprimir Valor 5"
  },
  State_124280_Desc = {
    Text = "Visualización de valores intermedios en el proceso de ejecución."
  },
  State_124280_Name = {
    Text = "Imprimir Valor 1"
  },
  State_124282_Desc = {
    Text = "Visualización de valores intermedios en el proceso de ejecución."
  },
  State_124282_Name = {
    Text = "Imprimir Valor 7"
  },
  State_124283_Desc = {
    Text = "Visualización de valores intermedios en el proceso de ejecución."
  },
  State_124283_Name = {
    Text = "Imprimir Valor 8"
  },
  State_124284_Desc = {
    Text = "Visualización de valores intermedios en el proceso de ejecución."
  },
  State_124284_Name = {
    Text = "Imprimir Valor 9"
  },
  State_124285_Desc = {
    Text = "Visualización de valores intermedios en el proceso de ejecución."
  },
  State_124285_Name = {
    Text = "Imprimir Valor 10"
  },
  State_124286_Desc = {
    Text = "Visualización de valores intermedios en el proceso de ejecución."
  },
  State_124286_Name = {
    Text = "Imprimir Valor 6"
  },
  State_124287_Desc = {
    Text = "Visualización de valores intermedios en el proceso de ejecución."
  },
  State_124287_Name = {
    Text = "Imprimir Valor 3"
  },
  State_124736_Desc = {
    Text = "Verifica si el parámetro 3 de la interfaz BEAttachPostAction filtra o activa correctamente el desencadenador correspondiente."
  },
  State_124736_Name = {
    Text = "Prueba de oyente 1"
  },
  State_124747_Desc = {
    Text = "Verifica si el parámetro 3 de la interfaz BEAttachPostAction filtra o activa correctamente el desencadenador correspondiente."
  },
  State_124747_Name = {
    Text = "Prueba de oyente 2"
  },
  State_124748_Desc = {
    Text = "Cuando el enemigo juega cartas <BurningKeywords:quemar>, otórgate 1 acumulación de <MonsterExFlameKeywords:Explosión ardiente>, pero reduce temporalmente [DescArg1] <PowerIconKeywords:Fuerza>."
  },
  State_124748_Name = {
    Text = "Llama inextinguible"
  },
  State_124752_Desc = {
    Text = "Verifica si el parámetro 3 de la interfaz BEAttachPostAction filtra o activa correctamente el desencadenador correspondiente."
  },
  State_124752_Name = {
    Text = "Prueba de oyente 3"
  },
  State_124753_Desc = {
    Text = "Verifica si el parámetro 3 de la interfaz BEAttachPostAction filtra o activa correctamente el desencadenador correspondiente."
  },
  State_124753_Name = {
    Text = "Prueba de oyente 4"
  },
  State_124754_Desc = {
    Text = "Verifica si el parámetro 3 de la interfaz BEAttachPostAction filtra o activa correctamente el desencadenador correspondiente."
  },
  State_124754_Name = {
    Text = "Prueba de oyente 5"
  },
  State_124765_Desc = {
    Text = "La tasa crítica aumenta [Layer] %"
  },
  State_124765_Name = {
    Text = "Probabilidad de Crítico"
  },
  State_124766_Desc = {
    Text = "En esta batalla, la tasa crítica aumenta en un [Layer] %"
  },
  State_124766_Name = {
    Text = "Probabilidad de Crítico"
  },
  State_124766_WeaponDesc = {
    Text = "En esta batalla, la tasa crítica aumenta en un [Layer] %"
  },
  State_124767_Desc = {
    Text = "Daño crítico +[Layer]%"
  },
  State_124767_Name = {
    Text = "Daño Crítico"
  },
  State_124811_Desc = {
    Text = "Verifica si el parámetro 3 de la interfaz BEAttachPostAction filtra o activa correctamente el desencadenador correspondiente."
  },
  State_124811_Name = {
    Text = "Prueba de oyente 8"
  },
  State_124812_Desc = {
    Text = "Verifica si el parámetro 3 de la interfaz BEAttachPostAction filtra o activa correctamente el desencadenador correspondiente."
  },
  State_124812_Name = {
    Text = "Prueba de oyente 7"
  },
  State_124813_Desc = {
    Text = "Verifica si el parámetro 3 de la interfaz BEAttachPostAction filtra o activa correctamente el desencadenador correspondiente."
  },
  State_124813_Name = {
    Text = "Prueba de oyente 6"
  },
  State_124826_Desc = {
    Text = "Verifica si el parámetro 3 de la interfaz BEAttachPostAction filtra o activa correctamente el desencadenador correspondiente."
  },
  State_124826_Name = {
    Text = "Prueba de oyente 9"
  },
  State_124843_Desc = {
    Text = "Verifica los oyentes de los disparadores BSTAfterAttachPostAction y BSTAfterDoActiveDamage.AttachPostAction"
  },
  State_124843_Name = {
    Text = "Prueba de oyente 9"
  },
  State_124886_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: Después de jugar una tarjeta de habilidad del portador, roba [StateArg1] cartas, priorizando las cartas de otros Despertados. El efecto se activa como máximo 1 vez por turno."
  },
  State_124886_Name = {
    Text = "Rueda del destino"
  },
  State_124887_Desc = {
    Text = "El número de golpes de daño de \"textil\" de este Despertado aumenta en [Layer]."
  },
  State_124887_Name = {Text = "textil"},
  State_124888_Desc = {
    Text = "Se transforma en una \"Habilidad\" enemiga aleatoria con coste -1 después de jugarla."
  },
  State_124888_Name = {
    Text = "<CardKeyWord:Profecía>"
  },
  State_124890_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>:\"Exaltar\" hace que las últimas [StateArg1] \"habilidades\" jugadas por ti se activen 2 veces."
  },
  State_124890_Name = {
    Text = "La Malla Eterna"
  },
  State_124892_Name = {
    Text = "<CardKeyWord:Profecía>"
  },
  State_124916_Desc = {
    Text = "Al final del turno, elimina todas las acumulaciones e inflige [DescArg1] puntos de daño pasivo. No se puede disipar."
  },
  State_124916_Name = {
    Text = "Augurio Predestinado"
  },
  State_124917_Desc = {
    Text = "Al final del turno, elimina todas las acumulaciones e inflige daño pasivo. No se puede disipar."
  },
  State_124917_Name = {
    Text = "<PVPDestinedDeathKeyWords:Augurio Predestinado>"
  },
  State_124992_Desc = {
    Text = "Las próximas [DescArg1] cartas de \"Habilidad\" surten efecto 1 vez adicional."
  },
  State_124992_Name = {Text = "Trascender"},
  State_124993_Desc = {
    Text = "El daño activo letal causado y recibido se convierte en aplicar una cantidad igual de <PVPDestinedDeathKeyWords:Augurio Predestinado>. No se puede disipar."
  },
  State_124993_Name = {
    Text = "El destino, así lo declara"
  },
  State_124997_Desc = {
    Text = "El Daño Activo letal infligido o recibido se convierte en aplicar la misma cantidad de <PVPDestinedDeathKeyWords:Augurio Predestinado>. No puede ser disipado."
  },
  State_124997_Name = {
    Text = "<PVPEternalDimensionKeyWords:El destino, así lo declara>"
  },
  State_125002_Name = {
    Text = "Estado@Escucha del valor de escudo después de la fase de descarte del jugador general"
  },
  State_125003_Name = {
    Text = "Valor de blindaje"
  },
  State_125004_Name = {
    Text = "Estado@Contador de escudos aplicados a los jugadores"
  },
  State_125472_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Tras «Explosión de locura», aplica [StateArg1] capas de <PVPLostSoulKeyWords:embriaguez> al enemigo con <HPAndShieldMax:mayor vida y escudo>."
  },
  State_125472_Name = {
    Text = "Cebo de magnolia"
  },
  State_125486_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Después de que otros aliados \"Exaltar\", reduce el Coste de Aritmética de todas las \"Habilidades\" del Portador en tu mano en [StateArg1]."
  },
  State_125486_Name = {
    Text = "Fruncir el ceño en vano"
  },
  State_125925_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_125925_Name = {
    Text = "No Activado"
  },
  State_125926_Name = {
    Text = "Estado@Monstruo Tawil Escucha de intención de cambio de jugador"
  },
  State_125927_Desc = {
    Text = "Después de jugar [DescArg1] cartas de comando, cambia la intención a\"Seis Alas\"."
  },
  State_125927_Name = {
    Text = "Cuatro alas"
  },
  State_125928_Desc = {
    Text = "Jugar la tarjeta de comando sella la explosión de locura del Despertado correspondiente y todas las cartas de comando durante 2 turnos."
  },
  State_125928_Name = {
    Text = "Piñones del Tiempo"
  },
  State_125929_Desc = {
    Text = "Después de recibir [DescArg1] puntos de daño en un solo turno, obtén 70 capas de <ReinforceColour:Fortaleza> temporal y 1 capa de <ResentChainsKeywords:Cadenas de Rancor>."
  },
  State_125929_Name = {
    Text = "Existencia inexistente"
  },
  State_125933_Desc = {
    Text = "Después de jugar [DescArg1] cartas de comando, cambia la intención a\"Cuatro alas\"."
  },
  State_125933_Name = {
    Text = "Alas gemelas"
  },
  State_125934_Desc = {
    Text = "Al consumir Aritmética, la Llave Plateada ganada se reduce en un 50%. Después de que Tawil inflija daño no bloqueado, coloca 1 \"<DerivativeCardKeywords_131:Paradoja del tiempo EX>\" en tu mano."
  },
  State_125934_Name = {
    Text = "La Puerta de la Llave de Plata"
  },
  State_125935_Name = {Text = "silencio"},
  State_125935_WeaponDesc = {
    Text = "Al robar, te debilitas durante 1 turno. Al usar, debilita a todos los enemigos durante 1 turno. No se puede vender"
  },
  State_125937_Desc = {
    Text = "Jugar una tarjeta de comando sella la explosión de aliemus del Despertado correspondiente y todas las cartas de comando durante 2 turnos."
  },
  State_125937_Name = {
    Text = "Piñones del Tiempo"
  },
  State_125964_Desc = {
    Text = "Al consumir Aritmética, la Llave Plateada obtenida se reduce en un 50%. Después de que Tawil inflija daño no bloqueado, coloca 1 \"<DerivativeCardKeywords_131:Paradoja del tiempo EX>\" en tu mano."
  },
  State_125964_Name = {
    Text = "La Puerta de la Llave de Plata"
  },
  State_126010_Desc = {
    Text = "Equipo único: el veneno fijo y el efecto de veneno infligidos por el portador aumentan en <WeaponEffect_Num:[StateArg1]%,> la <EmbryoFusionIconKeywords:Fusión Embrionaria> recuperada automáticamente en el reino de carne aumenta en <WeaponEffect_Num:[StateArg2]%.> Cada vez que el portador activa \"Resonancia\" por primera vez en cada turno, otros Despertados obtienen <WeaponEffect_Num:[StateArg3]> puntos de alienación."
  },
  State_126010_WeaponDesc = {
    Text = "El veneno fijo y el efecto de veneno infligidos por el portador aumentan en <WeaponEffect_Num:[StateArg1]%>, y la <EmbryoFusionIconKeywords:Fusión Embrionaria> recuperada automáticamente en el reino de carne aumenta en <WeaponEffect_Num:[StateArg2]%.> Cada vez que el portador activa \"Resonancia\" por primera vez en cada turno, otros Despertados obtienen <WeaponEffect_Num:[StateArg3]> puntos de alienación."
  },
  State_126463_Name = {
    Text = "Estado@monstruo Liz Escucha de daño por fuego que atrapa polillas"
  },
  State_126464_Desc = {
    Text = "Límite de 10 capas, cada capa aumenta el daño causado por Liz en [DescArg1] puntos."
  },
  State_126464_Name = {
    Text = "<GreenWord:Chispa Verde>"
  },
  State_126465_Name = {
    Text = "Escucha de intención del monstruo Liz"
  },
  State_126466_Desc = {
    Text = "El oponente no descartará cartas en mano al final de su turno. Cuando la intención cambie a Llamas Verdes, si tienes al menos 6 capas de <MonsterLizVerdantSpark:Chispa Esmeralda>, consume 6 capas para mejorar la intención a \"Llamas Mortales\" que inflige <Damage:[Damage:DescArg1]> de daño [AttackTimes:DescArg2] veces; si tienes al menos 3 capas, consume 3 capas para mejorar la intención a \"Llamas Corruptas\" que inflige <Damage:[Damage:DescArg3]> de daño [AttackTimes:DescArg4] veces."
  },
  State_126466_Name = {
    Text = "Llama verde inmortal"
  },
  State_126467_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, recuperará PV y comenzará a luchar en su verdadera forma, y le otorgará la capacidad de eliminar estados negativos a la \"Danza hasta la destrucción\"."
  },
  State_126467_Name = {
    Text = "No Activado"
  },
  State_126468_Name = {
    Text = "Estado@Gestión de reflejo esmeralda del monstruo Liz"
  },
  State_126469_Desc = {
    Text = "Por cada [DescArg1] puntos de vida perdidos, obtienes [DescArg2] capas de <MonsterLizVerdantSpark:Chispa Esmeralda>."
  },
  State_126469_Name = {
    Text = "Reflejo Esmeralda"
  },
  State_126470_Name = {
    Text = "Estado@Contador de Sugerencia del monstruo Liz"
  },
  State_126479_Desc = {
    Text = "Límite de 10 capas, aumenta el daño causado por Liz."
  },
  State_126479_Name = {
    Text = "<GreenWord:Chispa Verde>"
  },
  State_126540_Desc = {
    Text = "Cuando Xu activa \"Resonancia\" [Layer] veces, el efecto de \"Resonancia\" se duplica."
  },
  State_126540_Name = {
    Text = "Juramento en la Niebla Nocturna"
  },
  State_126568_Desc = {
    Text = "Cada vez que el Despertado causa daño activo, ordena a un tentáculo atacar al objetivo, causando un [Layer]% de daño de tentáculo."
  },
  State_126568_Name = {
    Text = "Mar embravecido"
  },
  State_126569_Desc = {
    Text = "Cada vez que el Despertado causa daño activo, ordena a 1 tentáculo atacar al objetivo, causando un 50% de daño de tentáculo."
  },
  State_126569_Name = {
    Text = "Mar embravecido"
  },
  State_126643_Desc = {
    Text = "Este estado MaxLayer=1. Despertador de origen: [DescArg1]"
  },
  State_126643_Name = {
    Text = "Límite de nivel 1"
  },
  State_126644_Desc = {
    Text = "Después de obtener, elimina y vuelve a agregar [Layer] capas del Estado de Demostración. \n El número máximo de capas para el Estado de Demostración es 1 capa."
  },
  State_126644_Name = {
    Text = "Romper el límite máximo de acumulaciones"
  },
  State_126645_Desc = {
    Text = "El daño básico causado por Ramona aumenta en [DescArg1]%"
  },
  State_126645_Name = {
    Text = "El refinamiento legendario"
  },
  State_126651_Desc = {
    Text = "El oyente después de liberar la Persecución ha estado satisfecho [Layer] veces."
  },
  State_126651_Name = {Text = "Contador"},
  State_126652_Desc = {
    Text = "Después de obtenerlo, obliga al enemigo de la primera fila a añadir una acción retrasada, jugando su intención actual."
  },
  State_126652_Name = {
    Text = "Haz que el monstruo persiga"
  },
  State_126653_Desc = {
    Text = "Después de obtenerlo, permite al Despertador en la posición 1 añadir una acción retrasada, jugando su carta de golpear."
  },
  State_126653_Name = {
    Text = "Haz que el despertado persiga"
  },
  State_126654_Desc = {
    Text = "Cuando se activa el Oyente Nombrado, imprime el contador 1 vez."
  },
  State_126654_Name = {
    Text = "Escucha Nombrada"
  },
  State_126655_Desc = {
    Text = "Después de obtenerlo, ordena al Guardián del Secreto que añada una acción retrasada y juega la habilidad @Protagonist Skill@Voces en tu cabeza."
  },
  State_126655_Name = {
    Text = "Ordenar al Guardián del Secreto que persiga"
  },
  State_126677_Desc = {
    Text = "Este turno, la \"Hoja de desafío\" activa [Layer] veces 2 veces."
  },
  State_126677_Name = {
    Text = "Canto eterno de ballena"
  },
  State_126678_WeaponDesc = {
    Text = "Todas las instancias de daño del Salto del Titán +1"
  },
  State_126714_Desc = {
    Text = "La \"Defensa\" de Aigis activa [Layer] veces 3 veces."
  },
  State_126714_Name = {
    Text = "lágrimas congeladas"
  },
  State_126714_WeaponDesc = {
    Text = "Todas las instancias de daño del Salto del Titán +1"
  },
  State_126715_WeaponDesc = {
    Text = "Todas las instancias de daño del Salto del Titán +1"
  },
  State_126776_Desc = {
    Text = "Por cada capa que poseas, el veneno fijo recibido aumenta en un 5%, el daño causado se reduce en [DescArg1]%, máximo [DescArg2] capas."
  },
  State_126776_Name = {
    Text = "<WitherKeywords:Ebrio>"
  },
  State_126783_Name = {
    Text = "Descartado temporalmente"
  },
  State_126784_Desc = {
    Text = "El veneno fijo recibido aumenta en [DescArg1]%, el daño causado se reduce en [DescArg2]%, máximo [DescArg3] capas."
  },
  State_126784_Name = {Text = "Ebrio"},
  State_126785_Desc = {
    Text = "Si otros Despertados han acumulado jugar X cartas de comando, activa los efectos posteriores después de jugar. Restablece tu cuenta de Resonancia después de jugar tus propias cartas de comando o al final de tu turno."
  },
  State_126785_Name = {
    Text = "<ResonanceKeywords:Resonancia X>"
  },
  State_126789_Desc = {
    Text = "Aplica 2 capas <WitherKeywords:Ebrio> a todos los enemigos."
  },
  State_126789_Name = {
    Text = "<WitherKeywords1:Promesa>"
  },
  State_126790_Desc = {
    Text = "Elimina todas las <WitherKeywords:Ebrio> de los enemigos. Cada capa eliminada causa un daño fijo del [DescArg1]% de la HP máxima del objetivo y activa un 40% de veneno."
  },
  State_126790_Name = {
    Text = "<WitherKeywords2:Usurpar el alma>"
  },
  State_126803_Desc = {
    Text = "Las próximas cartas de comando [DescArg1] jugadas se enviarán al futuro 3 turnos adelante."
  },
  State_126803_Name = {
    Text = "Rueda del destino"
  },
  State_126893_Name = {
    Text = "Estado@destino Ultra Puro Identificador"
  },
  State_126895_Desc = {
    Text = "El Daño Final, la ganancia fija de <PowerIconKeywords:STR> y <TentacleInjurieIconKeywords:Daño de tentáculos>, el <IntoxicationIconKeywords:Veneno> fijo y el <RetaliateIconKeywords:Contrataque> de esta carta aumentan cada uno en +[DescArg1]%; el Escudo Fijo Final, la Recuperación de PV Fija y el <ExhaustionIconKeywords:STR▼> de esta carta aumentan cada uno en +[DescArg2]%. Las cartas con \"Faro de Singularidad\" no pueden activar \"Lanzadera Dimensional\"."
  },
  State_126895_Name = {
    Text = "<SingularityKeywords:Faro de Singularidad [DescArg2]>"
  },
  State_126896_Name = {
    Text = "Estado@Carta Luz de Trascendencia reduce las acumulaciones de Armonía Aritmética"
  },
  State_126900_Name = {
    Text = "Estado@destino Ultra Inicialización de profesión 2"
  },
  State_126901_Name = {
    Text = "Estado@Inicialización de profesión transdimensional del destino 1"
  },
  State_126903_Name = {
    Text = "Estado@Espacio Hiperspacial Cuásar"
  },
  State_126927_Desc = {
    Text = "Equipo único: El veneno fijo y el efecto de veneno infligidos por el portador aumentan en <WeaponEffect_Num:[StateArg1]%.> Cada vez que el portador activa \"Resonancia\" por primera vez en cada turno, obtiene <WeaponEffect_Num:[StateArg2]> puntos de alienación."
  },
  State_126927_WeaponDesc = {
    Text = "El veneno fijo y el efecto de veneno infligidos por el portador aumentan en <WeaponEffect_Num:[StateArg1]%>. Cada vez que el portador activa \"Resonancia\" por primera vez en cada turno, obtiene <WeaponEffect_Num:[StateArg2]> puntos de alienación."
  },
  State_126990_Name = {
    Text = "<IntoxicationColour: Veneno>"
  },
  State_127108_Desc = {
    Text = "Aplica 5 capas <WitherKeywords:Ebrio> a todos los enemigos."
  },
  State_127108_Name = {
    Text = "<WitherKeywords3:Promesa>"
  },
  State_127109_Desc = {
    Text = "Elimina todas las <WitherKeywords:Ebrio> de los enemigos. Por cada acumulación eliminada, acumula Horno Carmesí equivalente al 20% de CON, causa [DescArg1]% de la HP máxima del objetivo como Daño Fijo y activa un 40% de Veneno."
  },
  State_127109_Name = {
    Text = "<WitherKeywords4:Usurpar el alma>"
  },
  State_127176_Desc = {
    Text = "Por cada capa que poseas, el veneno fijo recibido aumenta en un 5%, y el daño causado se reduce en [DescArg1]%, con un máximo de [DescArg2] capas."
  },
  State_127176_Name = {
    Text = "<WitherKeywords0:Ebrio>"
  },
  State_127264_Desc = {
    Text = "Al jugar esta carta, la \"La Iluminada\" gana 1 capa de <MonsterTimeBeacon:Bucle>. Si se descarta esta carta, la \"La Iluminada\" pierde 1 capa de <MonsterTimeBeacon:Bucle>."
  },
  State_127264_Name = {
    Text = "<MonsterSightUnbound:Vista sin límites>"
  },
  State_127266_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_127266_Name = {
    Text = "No Activado"
  },
  State_127267_Desc = {
    Text = "Al final del turno, obtén 1 capa de <MonsterTimeBeacon:Bucle>."
  },
  State_127267_Name = {
    Text = "Entropía deshecha"
  },
  State_127271_Desc = {
    Text = "Después de liberar la llave, obtén 1 capa de <MonsterTimeBeacon:Bucle> para ti mismo."
  },
  State_127271_Name = {
    Text = "Prisionero de Mobius"
  },
  State_127272_Desc = {
    Text = "Límite de 3 capas. Cuando la \"La Iluminada\" libera una intención con 3 capas de <MonsterTimeBeacon:Bucle>, activa el efecto de <MonsterTimeBeacon:Bucle>, elimina el <MonsterTimeBeacon:Bucle> y quita los estados negativos."
  },
  State_127272_Name = {
    Text = "<WhiteWord:Bucle>"
  },
  State_127275_Desc = {
    Text = "Cada capa que poseas aumenta en un 5% el veneno fijo recibido, reduce el daño en un [DescArg1]%, máximo [DescArg2] capas."
  },
  State_127275_Name = {
    Text = "<WitherKeywords:Ebrio>"
  },
  State_127276_Desc = {
    Text = "Al jugar esta carta, la \"La Iluminada\" gana 1 capa de <MonsterTimeBeacon:Bucle>. Si se descarta esta carta, la \"La Iluminada\" pierde 1 capa de <MonsterTimeBeacon:Bucle>."
  },
  State_127276_Name = {
    Text = "<MonsterSightUnbound:Vista sin límites>"
  },
  State_127312_Desc = {
    Text = "Cuando el desarrollo de la personalidad del Despertado alcanza +12, se activa el \"Principio Final\", otorgando algunos efectos únicos."
  },
  State_127312_Name = {
    Text = "<UltraPotencyKeywords:Regla final>"
  },
  State_127705_Desc = {
    Text = "¡La carta fue manipulada! Recibe [Layer] de daño al jugarse. Reduce las acumulaciones de <CardKeyWord:Sabotaje> a la mitad."
  },
  State_127705_Name = {
    Text = "<CardKeyWord:Destrucción en la Sombra>"
  },
  State_127705_WeaponDesc = {
    Text = "Al jugar la carta, recibe [StateArg1] puntos de daño"
  },
  State_127708_Desc = {
    Text = "Después de que el enemigo juegue una carta que no sea Tarjeta de comando, todos los aliados obtienen [DescArg1] acumulaciones de <PowerIconKeywords:Fortaleza>. Se desactiva después de que Ceniza ancestral sea rota."
  },
  State_127708_Name = {
    Text = "Hilos del Caos"
  },
  State_127709_Name = {
    Text = "Estado del jugador de hilo negro"
  },
  State_127710_Name = {
    Text = "Activación de hilos oscuros"
  },
  State_128026_Name = {
    Text = "Estado del jugador de Hilo Blanco"
  },
  State_128027_Desc = {
    Text = "Después de que el enemigo juega una Tarjeta de comando, todos los aliados obtienen [DescArg1] capas temporales de <ReinforcePVEKeywords:Fortaleza>. La Ceniza ancestral se desactiva después de ser rota."
  },
  State_128027_Name = {
    Text = "Hilos de la Ley"
  },
  State_128028_Desc = {
    Text = "¡La tarjeta fue manipulada! Al jugarla, recibe <FixedDamage:DMG Puro> y luego reduce las Acumulaciones de <BrokenCard:Sabotaje> a la mitad."
  },
  State_128028_Name = {
    Text = "<CardKeyWord:Destrucción Sigilosa>"
  },
  State_128028_WeaponDesc = {
    Text = "Al jugar la carta, recibe [StateArg1] puntos de daño"
  },
  State_128029_Name = {
    Text = "Toque de hilo blanco"
  },
  State_128067_Name = {
    Text = "Estado@Doncella de la Araña Fría Escucha de Ceniza"
  },
  State_128069_Name = {
    Text = "Estado@Sirvienta de la araña helada detección de impacto entrelazado"
  },
  State_128071_Name = {
    Text = "Estado@Se necesita un marcador de invocación en la posición anterior de la Sirvienta Araña Fría"
  },
  State_128073_Desc = {
    Text = "Al final de cada acción, obtendrás [DescArg1] capas de <ParcloseIconKeywords:barrera> y [DescArg2] capas de <Chapter5_Monster_Fervor1:Fervor>."
  },
  State_128073_Name = {
    Text = "Cuna de la Madre Tejedora"
  },
  State_128082_Desc = {
    Text = "Después de jugar, Hameln obtiene 3 puntos de aliemus"
  },
  State_128082_Name = {
    Text = "<XushiBKeywords:Sonido acumulado>"
  },
  State_128086_Desc = {
    Text = "Después de que el enemigo juega una Tarjeta de comando, obtienes [DescArg1] acumulaciones de <Chapter5_Monster_Fervor1:Fervor>, y cambias de posición con un aliado en la fila trasera después de que \"Ceniza ancestral\" se agote."
  },
  State_128086_Name = {
    Text = "Rueda del destino"
  },
  State_128087_Name = {
    Text = "Estado@fría araña sirvienta marca de activación del ciclo blanco"
  },
  State_128089_Name = {
    Text = "Desencadenamiento de la Rueda Blanca"
  },
  State_128216_Name = {
    Text = "Estado del jugador de la Rueda Blanca"
  },
  State_128245_Desc = {
    Text = "Limpia al comienzo del turno. Después de alcanzar 10 acumulaciones, la próxima vez que se juegue una carta, actúa de inmediato, elimina <Chapter5_Monster_Fervor2:Fervor> y cambia la intención a infligir <FragileIconKeywords:Frágil> y adjuntar aleatoriamente <BrokenCard:Sabotaje> \"Hilo del Colapso\"."
  },
  State_128245_Name = {
    Text = "Fervor temporal"
  },
  State_128246_Name = {
    Text = "Estado del jugador de la rueda negra"
  },
  State_128247_Desc = {
    Text = "Renacimiento tras la muerte, Inmunidad al daño y 100% de PV. Cambia la intención a \"Fervor del Destino\": Después de cada acción, obtén [DescArg1] <PowerIconKeywords:Fortaleza> y [DescArg2] <Chapter5_Monster_Fervor2:Fervor>."
  },
  State_128247_Name = {Text = "Emergencia"},
  State_128248_Desc = {
    Text = "Limpia al comienzo del turno. Después de alcanzar 10 acumulaciones, la próxima vez que se juegue una carta, actúa de inmediato, elimina <Chapter5_Monster_Fervor1:Fervor> y cambia la intención a \"Tela de Ataduras\", que inflige <WeaknessIconKeywords:Síntoma: Debilidad> y sella aleatoriamente Tarjetas de comando."
  },
  State_128248_Name = {
    Text = "Fervor temporal"
  },
  State_128250_Name = {
    Text = "Ciclo de la oscuridad activado"
  },
  State_128251_Desc = {
    Text = "Después de que el enemigo juega una carta que no es de comando, obtienes [DescArg1] <plural value=\"[DescArg1]\" singular=\"Acumulación\" plural=\"Acumulaciones\"> de <Chapter5_Monster_Fervor1:Fervor>, y cambia de posición con un aliado en la fila trasera después de que se agote \"Ceniza ancestral\"."
  },
  State_128251_Name = {
    Text = "Rueda del Abismo"
  },
  State_128253_Desc = {
    Text = "Renacimiento tras la muerte, Inmunidad al daño y con 100% de PV. Cambia la intención a \"Fervor del Destino\": Después de cada acción, obtén [DescArg1] acumulaciones de <ParcloseIconKeywords:Barrera> y [DescArg2] acumulaciones de <Chapter5_Monster_Fervor1:Fervor>."
  },
  State_128253_Name = {Text = "Emergencia"},
  State_128257_Desc = {
    Text = "Al final de cada acción, obtienes [DescArg1] puntos de <PowerIconKeywords:fuerza> y [DescArg2] capas de <Chapter5_Monster_Fervor2:Fervor>."
  },
  State_128257_Name = {
    Text = "Susurro de la Madre Tejedora"
  },
  State_128643_Name = {
    Text = "Estado@Contador de síntomas jugados por el jugador en este turno"
  },
  State_128644_Desc = {Text = "Fervor"},
  State_128644_Name = {
    Text = "Fervor temporal"
  },
  State_128645_Desc = {
    Text = "La intención se seleccionará de manera aleatoria entre cuatro intenciones, sin repeticiones. Después de liberar la explosión de locura, cambia inmediatamente la intención. Al jugar una tarjeta de comando, obtienes 1 capa de <Chapter5_Monster_Fervor3:Fervor>."
  },
  State_128645_Name = {
    Text = "Sinfonía de las Diez Mil Caras"
  },
  State_128646_Name = {
    Text = "Estado@destino erróneo Golpe fuerte detección de jugar cartas"
  },
  State_128648_Desc = {
    Text = "Hasta que comience el siguiente turno, cada vez que juegues una tarjeta de comando, obtén [DescArg1] de <PowerIconKeywords:fuerza> temporal."
  },
  State_128648_Name = {
    Text = "Capullo de Ira"
  },
  State_128692_Desc = {
    Text = "Después de recibir Daño Activo o Daño de tentáculos, se elimina una cantidad equivalente de \"Ceniza ancestral\" y se pierden un 300% de PV equivalente a la cantidad eliminada. Al recibir otro tipo de daño, se elimina la mitad. Las acumulaciones de \"Ceniza ancestral\" se reinician cada turno."
  },
  State_128692_Name = {
    Text = "<AshesPastKeyWord:Ceniza ancestral>"
  },
  State_128695_Name = {
    Text = "Estado@intención del destino caótico"
  },
  State_129297_Desc = {
    Text = "Al comenzar las siguientes [Layer] batallas, establece la salud de todos los enemigos en 1."
  },
  State_129297_Name = {
    Text = "Asistencia de Pequeño\"N\""
  },
  State_129569_Name = {
    Text = "Estado@Marca de activación del teatro de alegría del destino caótico"
  },
  State_129570_Name = {
    Text = "Estado@Marca de activación de Susurro del destino caótico"
  },
  State_129571_Name = {
    Text = "Estado@destino desordenado Oblivion infinito activación de marcador"
  },
  State_129612_Desc = {
    Text = "La intención se seleccionará al azar entre cuatro tipos de intención, pero no se repetirá. Después de liberar la explosión de alienación, cambia inmediatamente la intención. Al jugar una tarjeta de comando, obtienes 1 capa de <Chapter5_Monster_Fervor3:Fervor>."
  },
  State_129612_Name = {
    Text = "Sinfonía de las Leyes"
  },
  State_129625_Desc = {
    Text = "La intención se seleccionará al azar entre cuatro tipos, sin repeticiones. Después de liberar una Exaltación, cambia inmediatamente la intención. Al jugar una Tarjeta de comando, obtienes 1 Acumulación de <Chapter5_Monster_Fervor3:Fervor>. Cada vez que cambies de intención, obtienes 1 Acumulación de \"Destino Desentrañado\"."
  },
  State_129625_Name = {
    Text = "Sinfonía de las Leyes"
  },
  State_129643_Desc = {
    Text = "Cada vez que cambies de intención, obtén 1 Acumulación. Cuando tengas 10 Acumulaciones de \"Destino Desentrañado\", la intención cambiará a la inalterable \"Emergencia Frenética\", que inflige Daño masivo y aplica debuffs."
  },
  State_129643_Name = {
    Text = "Destino Torcido"
  },
  State_129644_Name = {
    Text = "Intención de bloqueo de fusión distorsionada"
  },
  State_129650_Desc = {
    Text = "Equipo Único: Si el Portador es la Despertada \"Ramona: Bucle\", la Tasa de sincronización obtenida por los demás Despertados al completar la etapa +<WeaponEffect_Num:[StateArg1]%>, pero el Portador no obtiene ninguna Tasa de sincronización."
  },
  State_129650_WeaponDesc = {
    Text = "Si el portador es el Cuerpo Despertado \"Ramona: Bucle\", al completar un nivel, los demás Cuerpos Despertados obtienen +<WeaponEffect_Num:[StateArg1]%> de Tasa de sincronización, pero el portador no obtiene Tasa de sincronización."
  },
  State_129761_Desc = {
    Text = "Modifica el valor de retorno de la interfaz de crecimiento de jugadores en la partida, aumentando un 1% por cada capa."
  },
  State_129761_Name = {
    Text = "Corrección de intensidad de crecimiento en la partida"
  },
  State_129845_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_129845_Name = {
    Text = "No Activado"
  },
  State_129846_Name = {
    Text = "Contador de Oscilación espacial"
  },
  State_129848_Desc = {
    Text = "Cada vez que [DescArg1] cartas salen de la fisura dimensional, se les otorgan [DescArg2] capas de <BrokenCard:destrucción oculta>."
  },
  State_129848_Name = {
    Text = "Inauguración del teatro de marionetas"
  },
  State_129849_Desc = {
    Text = "Genera una copia de la primera tarjeta de comando jugada por el enemigo en cada turno y colócala en la fisura dimensional. Cuando la carta entra en la fisura dimensional, se le otorga <DepleteIconKeywords:Consumo>. La primera vez que se libera un posse en cada turno, se extrae la carta más a la izquierda y se coloca en la parte superior del mazo de robo."
  },
  State_129849_Name = {
    Text = "Tejiendo el Destino"
  },
  State_129850_Desc = {
    Text = "Por cada tarjeta de comando en la fisura dimensional, el tamaño máximo de la mano del jugador se reduce en 1. Si está llena, la próxima vez que se juegue una carta, la \"Red de Dimensión Eterna\" actuará de inmediato, y después de la acción, se vaciará la fisura dimensional, ajustando la intención a \"Lamento de prevalecer sobre el destino\"."
  },
  State_129850_Name = {
    Text = "Oscilación espacial"
  },
  State_129854_Desc = {
    Text = "Por cada tarjeta de comando en la fisura dimensional, el tamaño máximo de la mano del jugador se reduce en 1. Si está lleno, la próxima vez que se juegue una carta, la \"Red de Dimensión Eterna\" actuará de inmediato; después de la acción, se vaciará la fisura dimensional y se ajustará la intención a \"El destino, así lo declara\"."
  },
  State_129854_Name = {
    Text = "Oscilación espacial"
  },
  State_129864_Desc = {
    Text = "Cada vez que se juega una carta, se elimina 1 capa de \"Somnolencia\". Al inicio del turno, se restauran 12 capas de \"Somnolencia\"."
  },
  State_129864_Name = {Text = "Ira"},
  State_129865_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_129865_Name = {
    Text = "No Activado"
  },
  State_129872_Desc = {
    Text = "Variable temporal."
  },
  State_129872_Name = {Text = "Contador 1"},
  State_129873_Desc = {
    Text = "Obtén [Layer] estado de contador _Contador de encapsulación 1_."
  },
  State_129873_Name = {
    Text = "Prueba de encapsulación 1"
  },
  State_129874_Desc = {
    Text = "Variable temporal."
  },
  State_129874_Name = {
    Text = "Amplificador 1"
  },
  State_130358_Desc = {
    Text = "La próxima carta de comando jugada tendrá un efecto adicional 2 veces."
  },
  State_130358_Name = {
    Text = "Marioneta de hilos"
  },
  State_130387_Desc = {
    Text = "Después de que se consuma el \"Muñeco de Títere\", la primera tarjeta de comando jugada en cada turno tendrá un efecto adicional de 2 veces. Si es una Líder Batalla, todos los Despertados obtienen 50 puntos de alienación y 1000 puntos de llave plateada."
  },
  State_130387_Name = {
    Text = "Funeral del destino"
  },
  State_130388_Name = {
    Text = "<RetainIconKeywords:Retener>: Obtén [DescArg1] puntos de energía de llave plateada"
  },
  State_130389_Desc = {
    Text = "Después de jugar, haz que todos los Despertados obtengan [DescArg1] puntos de alienación"
  },
  State_130389_Name = {
    Text = "Después de jugar, haz que todos los Despertados obtengan [DescArg1] puntos de alienación"
  },
  State_130390_Desc = {
    Text = "Aumenta el límite de aritmética y el tamaño máximo de la mano en 1."
  },
  State_130390_Name = {
    Text = "Perfiles redundantes"
  },
  State_130391_Desc = {
    Text = "Por cada carta de \"síntoma\" jugada, el coste de aritmética de \"marioneta\" disminuye en 1."
  },
  State_130391_Name = {
    Text = "Ecos de suciedad"
  },
  State_130490_Desc = {
    Text = "El daño, el blindaje, la curación, la fuerza, el absorber, el daño de tentáculos, el veneno fijo y el contrataque fijo causados por esta carta aumentan, se multiplican independientemente por 1+[Layer]%."
  },
  State_130490_Name = {
    Text = "Faro de Singularidad α"
  },
  State_130498_Desc = {
    Text = "La próxima carta de comando jugada tendrá un efecto adicional 2 veces."
  },
  State_130498_Name = {
    Text = "Funeral del destino"
  },
  State_130500_Desc = {
    Text = "En la batalla contra el líder, Resistencia a la muerte +100%. Después de activar \"Resistencia a la muerte\", en la siguiente ronda \"Marioneta\" ya no obligará a jugar una tarjeta de comando, sino que permitirá elegir una tarjeta de comando en la mano."
  },
  State_130500_Name = {
    Text = "Mirada del mártir"
  },
  State_130501_Desc = {
    Text = "La siguiente tarjeta de comando tiene un coste de aritmética reducido a 0."
  },
  State_130501_WeaponDesc = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_130512_Desc = {
    Text = "La siguiente carta de comando jugada tendrá un efecto adicional 2 veces y su coste de aritmética se reducirá en 2 puntos."
  },
  State_130512_Name = {
    Text = "Marioneta de hilos"
  },
  State_130517_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equipar y al inicio del turno, activa aleatoriamente uno de los siguientes efectos: obtiene <Energy:[Energy:StateArg1]> Alienación y aplica <PVPSlowKeywords:Estancamiento> a sí mismo; obtiene <Energy:[Energy:StateArg3]> Alienación; obtiene <Energy:[Energy:StateArg4]> y [StateArg5] cartas de <PVPDerivativeCardKeywords_17:\"Conocimiento\">."
  },
  State_130517_Name = {
    Text = "La sabiduría de la apuesta arriesgada"
  },
  State_131046_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Después de\"Exaltar\", te da <Block:[Block:StateArg1]> Blindaje y <DelayKeywords:Latencia>: <Energy:[Energy:StateArg2]> Alienación."
  },
  State_131046_Name = {
    Text = "Edén distante"
  },
  State_131047_Desc = {
    Text = "Este turno, los próximos [Layer] usos de Pandilla tendrán efecto dos veces."
  },
  State_131047_Name = {
    Text = "Orden Doble de Llave"
  },
  State_131048_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: La primera vez que se juega «Habilidad» en cada turno, inflige <Damage:[Damage:StateArg1]> de daño al enemigo con <HPAndShieldMin:menor vida y escudo>."
  },
  State_131048_Name = {
    Text = "Locura encarcelada"
  },
  State_131055_Desc = {
    Text = "Roba -1 carta en cada turno. Todos los Despertados obtienen un aumento del 20% en el blindaje y la recuperación de PV."
  },
  State_131055_Name = {
    Text = "Ajustar el cabello"
  },
  State_131056_Desc = {
    Text = "Al perder vida, convierte una cantidad igual de locura retardada en escudo."
  },
  State_131056_Name = {
    Text = "Escudo del torbellino"
  },
  State_131058_Desc = {
    Text = "Todos los Despertados aumentan su locura base en 10 puntos. Al liberar la exaltación, se obtiene 1 punto de Aritmética; cada Despertado solo puede activarlo 1 vez por turno."
  },
  State_131058_Name = {
    Text = "Frotar la mejilla"
  },
  State_131059_Name = {
    Text = "Marcador de mejora de habilidad de Mosk"
  },
  State_131061_Desc = {
    Text = "Límite de energía llave plateada y consumo de energía llave para la Posse +350. La primera vez que se use la Posse en cada turno, tendrá efecto 2 veces."
  },
  State_131061_Name = {
    Text = "Alimentar con bocadillos"
  },
  State_131064_Desc = {
    Text = "Liberar Exaltar otorga 1 punto de Aritmética, cada Despertado solo puede activarlo 1 vez por turno."
  },
  State_131064_Name = {
    Text = "Frotar la mejilla"
  },
  State_131069_Desc = {
    Text = "Todos los Despertados obtienen un aumento del 20% en el blindaje y la recuperación de PV."
  },
  State_131069_Name = {
    Text = "Ajustar el cabello"
  },
  State_131073_Desc = {
    Text = "Equipo Único: Al comenzar la batalla, se obtiene locura equivalente al <WeaponEffect_Num:[StateArg1]%> de locura base. El daño final de la explosión de locura del portador aumenta en un <WeaponEffect_Num:[StateArg2]%> de la locura base. Al cambiar a la postura de \"Olas furiosas\", se obtiene una maestría temporal de dominio equivalente al <WeaponEffect_Num:[StateArg3]%> de la maestría del reino actual, con un tiempo de recarga de 3 turnos."
  },
  State_131073_WeaponDesc = {
    Text = "Al comenzar la batalla, obtienes [DescArg1] puntos de alienación. El daño final de la explosión de alienación del portador aumenta en [DescArg2]%. Al cambiar a la postura \"Olas furiosas\", obtienes [DescArg3] puntos de maestría temporal de dominio, con un tiempo de reutilización de 3 turnos (restante [DescArg4] turnos)."
  },
  State_131078_Desc = {
    Text = "La primera vez que se use la Posse en cada turno, tendrá efecto 2 veces."
  },
  State_131078_Name = {
    Text = "Alimentar con bocadillos"
  },
  State_131118_Desc = {
    Text = "Cada vez que recibes Daño o pierdes PV, no puede superar el 5% de los PV Max."
  },
  State_131118_Name = {
    Text = "Coco del destino"
  },
  State_131123_Desc = {
    Text = "Limpia al comienzo del turno. Después de alcanzar 10 capas, la próxima vez que se juegue una carta, actuará de inmediato y cambiará a la siguiente intención, eliminando <Chapter5_Monster_Fervor4:Fervor>."
  },
  State_131123_Name = {
    Text = "Fervor temporal"
  },
  State_131127_Desc = {
    Text = "Postura atada por el destino. Cada vez que el enemigo juega 1 Tarjeta de comando, gana 1 Acumulación de \"Fervor temporal\"."
  },
  State_131127_Name = {
    Text = "Juramentador del destino"
  },
  State_131134_Desc = {
    Text = "Después de la muerte, Nefraea obtiene [DescArg1] <plural value=\"[DescArg1]\" singular=\"Acumulación\" plural=\"Acumulaciones\"> de Fervor temporal, pero pierde 3% de PV Max."
  },
  State_131134_Name = {Text = "Agitación"},
  State_131186_Desc = {
    Text = "Tiene efecto 1 vez adicional después de ser jugada, pero sufre [DescArg1] Daño."
  },
  State_131186_Name = {
    Text = "<ExclamationPointColour:Destinos fragmentados>"
  },
  State_131188_Desc = {
    Text = "Jugar la \"habilidad\" entra en la \"Fisura dimensional\" y añade \"Fragmento de destino\" a todas las habilidades del mismo nombre, que se eliminarán al salir de la Fisura dimensional. Cuando la Fisura dimensional esté llena, Nefraea \"Red de Traición\" limpiará la Fisura dimensional después de la acción y transformará la siguiente intención en una poderosa Exaltación."
  },
  State_131188_Name = {
    Text = "Fisura dimensional"
  },
  State_131191_Name = {
    Text = "Trastorno cognitivo"
  },
  State_131242_Desc = {
    Text = "El daño, el blindaje, la curación, la fuerza, el absorber, el daño de tentáculos, el veneno fijo y el contrataque fijo causados por esta carta aumentan, se multiplican independientemente por 1+[Layer]%."
  },
  State_131242_Name = {
    Text = "Faro de Singularidad β"
  },
  State_131258_Desc = {
    Text = "Gira los hilos del huso y perturba el destino equivocado. Tras liberar una Orden de llave o jugar una carta de \"Fragmento de Retroceso del Destino\", elimina 1 capa. Al eliminarlas todas, Arachne lanza el ataque \"Hilos en su Lugar\", causando un daño elevado. ¡Tras liberarse 3 veces, el \"Capullo del Destino\" del enemigo quedará completamente destruido!"
  },
  State_131258_Name = {
    Text = "Perturbación del destino"
  },
  State_131261_Name = {
    Text = "Teatro de Arachne"
  },
  State_131351_Desc = {
    Text = "Otros despertados liberan explosión de alienación y consumen 1 capa, Mosk libera\"vórtice! flujo! proyectil!\"para perseguir."
  },
  State_131351_Name = {
    Text = "Cargando remolino"
  },
  State_131439_Desc = {
    Text = "La siguiente carta de comando que juegues tendrá un efecto adicional 2 veces y el coste de aritmética se reducirá a 0."
  },
  State_131439_Name = {
    Text = "Marioneta de hilos"
  },
  State_131637_Desc = {
    Text = "Al morir, invoca un \"Enjambre de arañas abisales\" o un \"Enjambre de arañas frías\" aleatorio, reduciendo su \"Efecto de enjambre\" en 1 acumulación."
  },
  State_131637_Name = {
    Text = "Efecto de enjambre"
  },
  State_131638_Desc = {
    Text = "Al morir, invoca una \"Matriarca fracturada\" o una \"Matriarca espectral\" aleatoria, reduciendo su \"Efecto de enjambre\" en 1 acumulación."
  },
  State_131638_Name = {
    Text = "Efecto de enjambre"
  },
  State_131645_Desc = {
    Text = "Equipo Único: Al cambiar a la postura de \"Olas furiosas\", obtienes una Maestría temporal de dominio equivalente a <WeaponEffect_Num:[StateArg1]%> de la Maestría del Reino actual, con un enfriamiento de 3 turnos."
  },
  State_131645_WeaponDesc = {
    Text = "Al cambiar a la postura de\"Olas furiosas\", obtienes [DescArg2] puntos de maestría temporal de dominio, con un enfriamiento de 3 turnos (quedan [DescArg1] turnos)."
  },
  State_131657_Desc = {
    Text = "Otros despertados liberan explosión de alienación y consumen 1 capa, Mosk libera\"vórtice! flujo! proyectil!\"para perseguir."
  },
  State_131657_Name = {
    Text = "<WhirlpoolKeywords:remolino Cargando>"
  },
  State_131660_Desc = {
    Text = "Por cada capa, aumenta en 1 punto la necesidad de locura para liberar la exaltación."
  },
  State_131660_Name = {
    Text = "Corrección de valor fijo del Consumo de Alienación"
  },
  State_131675_Desc = {
    Text = "Esta carta tiene un [StateArg1]% de probabilidad de tener efecto 1 vez adicional al jugarla la próxima vez."
  },
  State_131675_Name = {
    Text = "<CardKeyWord:Apuesta arriesgada>"
  },
  State_131684_Desc = {
    Text = "Las próximas [Layer] veces que \"¡Vórtice! ¡Proyectil!\" tendrán efecto 2 veces."
  },
  State_131684_Name = {
    Text = "Mosk! ¡Gran! ¡Bomba"
  },
  State_131749_Desc = {
    Text = "Equipo Único: Después de comenzar la exploración, baraja 1 carta de \"La sabiduría de la apuesta arriesgada\" en el mazo de robo. \"La sabiduría de la apuesta arriesgada\": consume 1 aritmética. Baraja todas las tarjetas de comando en tu mano en el mazo de robo. Las tarjetas de comando barajadas tienen un <WeaponEffect_Num:[StateArg1]%> de probabilidad de tener efecto 1 vez adicional la próxima vez que se jueguen, y por cada tarjeta de comando barajada, todos los Despertados obtienen 2 puntos de Alienación. <RetainIconKeywords:retener>. <DepleteIconKeywords:consumir>. <GuyouKeywords:Innata>."
  },
  State_131749_WeaponDesc = {
    Text = "Después de comenzar la exploración, baraja 1 carta \"La sabiduría de la apuesta arriesgada\" en el mazo de robo. \"La sabiduría de la apuesta arriesgada\": consume 1 aritmética. Baraja todas las tarjetas de comando en tu mano al azar en el mazo de robo, las tarjetas de comando barajadas tienen una probabilidad de <WeaponEffect_Num:[StateArg1]%> de tener efecto 1 vez adicional la próxima vez que se jueguen, y por cada tarjeta de comando barajada, todos los Despertados ganan 2 puntos de Alienación. <RetainIconKeywords:retener>. <DepleteIconKeywords:consumir>. <GuyouKeywords:Innata>."
  },
  State_131769_Name = {
    Text = "Estado@Inicialización de profesión de carne y sangre Cría 1"
  },
  State_131779_Desc = {
    Text = "Después de usar [Layer] veces, entrará en el Mazo de Descarte y se restablecerá el número de usos, pero la\"Inscripción\"solo tendrá efecto la primera vez que se use."
  },
  State_131779_Name = {
    Text = "Se puede usar [Layer] veces"
  },
  State_131789_Desc = {
    Text = "Alternativa. Añade 1 carta con tid [Layer] a tu mano."
  },
  State_131789_Name = {
    Text = "Añadir carta específica"
  },
  State_131807_Name = {
    Text = "Estado@Cría Carne y Sangre Pura"
  },
  State_131824_Name = {
    Text = "Estado@Monstruo Tawil Escucha de intención de cambio de jugador"
  },
  State_131846_Desc = {
    Text = "Al morir, invoca un \"Enjambre de arañas abisales\" o un \"Enjambre de arañas frías\" aleatorio, reduciendo su \"Efecto de enjambre\" en 1 acumulación."
  },
  State_131846_Name = {
    Text = "Efecto de enjambre"
  },
  State_131908_Desc = {
    Text = "Comparte los PV, el Escudo del personaje y el Aliemus del objetivo, pero no genera estadísticas de combate."
  },
  State_131908_Name = {
    Text = "Salto de Fiesta de la decadencia"
  },
  State_131909_Desc = {
    Text = "Si tienes este estado, puedes usar Exaltar."
  },
  State_131909_Name = {
    Text = "Sellado permanente"
  },
  State_132366_Desc = {
    Text = "Realiza un contraataque después de que otro Despertado use una carta de golpe."
  },
  State_132366_Name = {Text = "Perseguir"},
  State_132465_Desc = {
    Text = "El daño, escudo, curación, fuerza, debilitamiento, daño de tentáculo, veneno fijo y contraataque fijo infligidos por este Despertado aumentan, con multiplicación independiente de 1+[Layer]%."
  },
  State_132465_Name = {
    Text = "Devoración Mejorada α"
  },
  State_132469_Desc = {
    Text = "El daño, escudo, curación, fuerza, debilitamiento, daño de tentáculo, veneno fijo y contraataque fijo infligidos por este Despertado aumentan, con multiplicación independiente de 1+[Layer]%."
  },
  State_132469_Name = {
    Text = "Devoración Mejorada β"
  },
  State_132539_Desc = {
    Text = "Creación de prueba de conjunto"
  },
  State_132539_Name = {
    Text = "Creación de prueba de conjunto"
  },
  State_132539_WeaponDesc = {Text = "Prueba"},
  State_132560_WeaponDesc = {
    Text = "Cada [Damage:StateArg2] veces que el Fuego Esmeralda causa daño, obtienes una carta de consumo [Llama Verde]"
  },
  State_132564_WeaponDesc = {
    Text = "Cada [Damage:StateArg2] veces que el Fuego Esmeralda causa daño, obtienes una carta de consumo [Llama Verde]"
  },
  State_132565_WeaponDesc = {
    Text = "Cada [Damage:StateArg2] veces que el Fuego Esmeralda causa daño, obtienes una carta de consumo [Llama Verde]"
  },
  State_132598_Desc = {
    Text = "Al infligir Daño de tentáculos este turno, inflige adicionalmente Veneno igual al [Layer]% del Daño infligido."
  },
  State_132598_Name = {
    Text = "Obsesión abisal"
  },
  State_132609_Desc = {
    Text = "Cuando el escultor aplica un escudo, incrementa el daño de tentáculo de [StateArg1]"
  },
  State_132609_Name = {
    Text = "Reino del Olvido"
  },
  State_132609_WeaponDesc = {
    Text = "Cuando el escultor aplica un escudo, incrementa el daño de tentáculo de [StateArg1]"
  },
  State_132669_Desc = {
    Text = "El daño, escudo, curación, fuerza, debilitamiento, daño de tentáculo, veneno fijo y contraataque fijo infligidos por las cartas de este Despertado aumentan, con multiplicación independiente de 1+[Layer]%."
  },
  State_132669_Name = {
    Text = "Hiperdimensión Predestinada α"
  },
  State_132840_Name = {
    Text = "La bonificación del efecto de personalidad de la Tarjeta de comando de \"24\" se duplica. Después de que \"\"24\"\" desate Exaltar, el efecto de bonificación de personalidad duplicado expira este turno"
  },
  State_132891_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equipar, obtén [StateArg1] <StrongEffectKeywords:Amplificación>. Cuando otro aliado Exalta, haz que obtenga <PVPOneMeetingKeywords:Ichigo Ichie>."
  },
  State_132891_Name = {
    Text = "Enigma bajo los cerezos"
  },
  State_132892_Desc = {
    Text = "·Al obtenerlo, elimina el estado \"Ichigo Ichie\" de otros aliados, y obtén el efecto de Amplificación equivalente al de los aliados que equipan \"El mito bajo los cerezos\", hasta un máximo de 3 capas.\n·Los personajes que equipan \"El mito bajo los cerezos\" no pueden obtener \"Ichigo Ichie\"."
  },
  State_132892_Name = {
    Text = "Ichigo Ichie"
  },
  State_133294_Name = {
    Text = "Invitación carmesí"
  },
  State_133353_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Tras equiparse, las descripciones de \"golpear\", \"Habilidad\" y \"Exaltar\" del Portador se vuelven no identificables, pero cada instancia de Daño, Escudo del personaje y Recuperación de PV se incrementa aleatoriamente en un [StateArg1]%～[StateArg2]%."
  },
  State_133353_Name = {
    Text = "Cuento de hadas en el barro"
  },
  State_133354_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Se Retiene después de que esta Rueda del destino muera. Cuando el Portador muere y al final de los siguientes [Layer] turnos en Estado de muerte, los demás aliados obtienen <Heal:[Heal:StateArg1]> <PVPFeatheredSeedsKeyWords:Gynoecium> y PV."
  },
  State_133354_Name = {
    Text = "Que el mundo se convierta en fragancia"
  },
  State_133369_Desc = {
    Text = "Las siguientes [DescArg1] Tarjetas de comando que no sean de Tawil jugadas surten efecto dos veces."
  },
  State_133369_Name = {
    Text = "La Puerta de la Llave de Plata"
  },
  State_133372_Desc = {
    Text = "Si actualmente se está en un Turno Ultra, activa el efecto \"Distorsión Espacial de Singularidad\". \"Aniquilación de Singularidad\" también garantiza la siguiente activación de \"Distorsión Espacial de Singularidad\" en este turno."
  },
  State_133372_Name = {
    Text = "<SingularityKeywords:Distorsión Espacial de Singularidad>"
  },
  State_133391_Desc = {
    Text = "Si los PV del objetivo son iguales o inferiores al número de Acumulaciones, elimina todos los Veredicto Final y lo mata instantáneamente."
  },
  State_133391_Name = {
    Text = "<CutKeywords:Veredicto Final>"
  },
  State_133395_Desc = {
    Text = "Las próximas [Layer] Tarjeta(s) de comando jugadas activarán \"Lanzadera Dimensional\"."
  },
  State_133395_Name = {
    Text = "Lanzadera Dimensional"
  },
  State_133717_Desc = {
    Text = "El propietario actual es [Layer], y todas sus cartas actuales y futuras obtendrán el atributo correspondiente (Actual: Sello de Carta)."
  },
  State_133717_Name = {
    Text = "Propagación de Atributos de Carta"
  },
  State_133774_Desc = {
    Text = "Cada acumulación aumenta el Daño Final de esta carta, la ganancia fija de <PowerIconKeywords:STR> y <TentacleInjurieIconKeywords:Daño de tentáculos>, el <IntoxicationIconKeywords:Veneno> fijo y el <RetaliateIconKeywords:Contrataque> en un 2%, y su Escudo Fijo Final, Recuperación de PV Fija y <ExhaustionIconKeywords:STR▼> en un 1%. Esta carta no puede activar <SingularityKeywords3:Lanzadera Dimensional>."
  },
  State_133774_Name = {
    Text = "<SingularityKeywords1:Faro de Singularidad>"
  },
  State_133775_Desc = {
    Text = "Cada acumulación aumenta el Daño Final de esta carta, la ganancia fija de <PowerIconKeywords:STR> y <TentacleInjurieIconKeywords:Daño de tentáculos>, el <IntoxicationIconKeywords:Veneno> fijo y el <RetaliateIconKeywords:Contrataque> en un 2%, y su Escudo Fijo Final, Recuperación de PV Fija y <ExhaustionIconKeywords:STR▼> en un 1%"
  },
  State_133775_Name = {
    Text = "<SingularityKeywords2:Prisma de Singularidad>"
  },
  State_133961_Desc = {
    Text = "Equipo Único: Al comenzar la exploración, mezcla 1 \"Mensaje Primaveral\" en el mazo: Coste de Aritmética 1, obtén <WeaponEffect_Num:[StateArg1]> Keyflare, se transforma permanentemente en \"Flores de Sakura\" tras jugarse: Coste de Aritmética 1, obtén <WeaponEffect_Num:[StateArg2]> Keyflare, tras jugarse se transforma permanentemente en \"Hanafubuki\": Coste de Aritmética 1, obtén <WeaponEffect_Num:[StateArg3]> Keyflare, se transforma permanentemente en \"Ichigo Ichie\" tras jugarse: Coste de Aritmética 1, elige 1 de 3 Posse desbloqueadas aleatorias para desencadenar de inmediato y activar 2 veces, se transforma permanentemente en \"Mensaje Primaveral\" tras jugarse. Todas estas cartas tienen \"Retener\"."
  },
  State_133961_WeaponDesc = {
    Text = "Tras el inicio de la exploración, baraja 1 \"Mensaje Primaveral\" en el mazo: Coste de Aritmética 1, obtén <WeaponEffect_Num:[StateArg1]> Keyflare, se transforma permanentemente en \"Flores de Sakura\" tras Jugarla: Coste de Aritmética 1, obtén <WeaponEffect_Num:[StateArg2]> Keyflare, tras Jugarla se transforma permanentemente en \"Hanafubuki\": Coste de Aritmética 1, obtén <WeaponEffect_Num:[StateArg3]> Keyflare, se transforma permanentemente en \"Ichigo Ichie\" tras Jugarla: Coste de Aritmética 1, elige 1 de 3 Posse desbloqueados aleatorios para desatar inmediatamente y activar 2 veces, se transforma permanentemente en \"Mensaje Primaveral\" tras Jugarla. Todas estas Cartas tienen \"Retener\"."
  },
  State_133994_Desc = {
    Text = "El Daño Final, la ganancia fija de <PowerIconKeywords:STR> y <TentacleInjurieIconKeywords:Daño de tentáculos>, el <IntoxicationIconKeywords:Veneno> fijo y el <RetaliateIconKeywords:Contrataque> de todos los Despertados aumentan cada uno en +[DescArg1]%; el Escudo Fijo Final, la Recuperación de PV Fija y el <ExhaustionIconKeywords:STR▼> de esta carta aumentan cada uno en +[DescArg2]%"
  },
  State_133994_Name = {
    Text = "Prisma de Singularidad"
  },
  State_133998_Desc = {
    Text = "El Daño, Blindaje y cambio de Fortaleza causados por esta Carta aumentan un [DescArg2]%, y el Efecto final del Daño de tentáculos, la Cicatrización de PV, el Veneno fijo y el Contrataque fijo aumentan un [DescArg1]%. Se elimina al final del turno o tras ser jugada."
  },
  State_133998_Name = {
    Text = "<TempPowerKeywords1:Mejorar Temporal [DescArg1]>"
  },
  State_133999_Desc = {
    Text = "Cada acumulación aumenta el Daño Final de esta carta, la ganancia fija de <PowerIconKeywords:STR> y <TentacleInjurieIconKeywords:Daño de tentáculos>, el <IntoxicationIconKeywords:Veneno> fijo y el <RetaliateIconKeywords:Contrataque> en un 2%, y su Escudo Fijo Final, Recuperación de PV Fija y <ExhaustionIconKeywords:STR▼> en un 1%. Se elimina al jugarse o al final del turno."
  },
  State_133999_Name = {
    Text = "<TempPowerKeywords:Mejorar Temporal>"
  },
  State_134100_Desc = {
    Text = "Al recibir daño letal en este combate, resucita, recupera [Layer] puntos de vida y otorga a todos los Despertados [StateArg1] puntos de furia y [DescArg1] puntos de daño de tentáculo temporal. No se puede disipar."
  },
  State_134100_Name = {
    Text = "Ave del paraíso inmortal"
  },
  State_134191_Desc = {
    Text = "Único en el equipo: Tras iniciar la exploración, se baraja 1 carta \"Descanso Privado\" en el mazo de robo.\"Descanso Privado\": Consume 1 punto de cálculo. Daño crítico temporal +<WeaponEffect_Num:[StateArg1] %>. <RetainIconKeywords:Retener>. <DepleteIconKeywords:Consumir>."
  },
  State_134191_WeaponDesc = {
    Text = "Tras iniciar la exploración, se baraja 1 carta \"Descanso Privado\" en el mazo de robo.\"Descanso Privado\": Consume 1 punto de cálculo. Daño crítico temporal +<WeaponEffect_Num:[StateArg1] %>. <RetainIconKeywords:Retener>. <DepleteIconKeywords:Consumir>."
  },
  State_134195_Desc = {
    Text = "Las capas de veneno fijo, contraataque fijo y veredicto del destino fijo infligidas por esta carta aumentan, con multiplicación independiente de 1+[Layer]%."
  },
  State_134195_Name = {
    Text = "Fuerza Trifásica α1"
  },
  State_134196_Desc = {
    Text = "Las capas de veneno fijo, contraataque fijo y veredicto del destino fijo infligidas por las cartas de comando de este Despertado aumentan, con multiplicación independiente de 1+[StateArg1]%."
  },
  State_134196_Name = {
    Text = "Fuerza Trifásica β3"
  },
  State_134197_Desc = {
    Text = "Las capas de veneno fijo, contraataque fijo y veredicto del destino fijo infligidas por esta carta aumentan, con multiplicación independiente de 1+[StateArg1]%."
  },
  State_134197_Name = {
    Text = "Fuerza Trifásica β1"
  },
  State_134198_Desc = {
    Text = "Las capas de veneno fijo, contraataque fijo y veredicto del destino fijo infligidas por las cartas de comando de este Despertado aumentan, con multiplicación independiente de 1+[Layer]%."
  },
  State_134198_Name = {
    Text = "Fuerza Trifásica α3"
  },
  State_134199_Desc = {
    Text = "Las capas de veneno fijo, contraataque fijo y veredicto del destino fijo infligidas por la explosión de furia de este Despertado aumentan, con multiplicación independiente de 1+[StateArg1]%."
  },
  State_134199_Name = {
    Text = "Fuerza Trifásica β2"
  },
  State_134200_Desc = {
    Text = "Las capas de veneno fijo, contraataque fijo y veredicto del destino fijo infligidas por la explosión de furia de este Despertado aumentan, con multiplicación independiente de 1+[Layer]%."
  },
  State_134200_Name = {
    Text = "Fuerza Trifásica α2"
  },
  State_134227_Desc = {
    Text = "La Tejedora del destino teje sus hilos. Máximo [DescArg1] acumulaciones, persisten entre batallas, y pueden ser consumidos por Exaltar para liberar Caza: \"Hilos infinitos\"."
  },
  State_134227_Name = {
    Text = "<SilkKeywords:tejer destino>"
  },
  State_134231_Desc = {
    Text = "Equipo Único: Escudo del personaje generado por el Portador +<WeaponEffect_Num:[StateArg1]%>, y cuando el Portador usa \"Buscar\", Amplificación Temporal +<WeaponEffect_Num:[StateArg2]%>, hasta 5 veces por turno. Cada vez que se activa \"Lanzadera Dimensional\", el Portador obtiene <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_134231_WeaponDesc = {
    Text = "Escudo del personaje generado por el Portador +<WeaponEffect_Num:[StateArg1]%>, y cuando el Portador usa \"Buscar\", Amplificación Temporal +<WeaponEffect_Num:[StateArg2]%>, hasta 5 veces por turno. Cada vez que se activa \"Lanzadera Dimensional\", el Portador obtiene <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_134237_Desc = {
    Text = "La Tejedora del destino teje sus hilos. Máximo [DescArg1] Acumulaciones, se heredan entre combates y pueden ser consumidos por la Exaltación para desatar Caza: \"<DerivativeCardKeywords_144:Hilos infinitos>."
  },
  State_134237_Name = {
    Text = "tejer destino"
  },
  State_134240_Desc = {
    Text = "A continuación, [Layer] veces \"Tejido eterno\" genera \"Tirar de los hilos del destino\" adicionales que se colocan en el mazo de robo y en el mazo de descarte."
  },
  State_134240_Name = {
    Text = "Red de ataduras de vida"
  },
  State_134261_Desc = {
    Text = "Las próximas [Layer] veces que se inflija daño, este se duplicará."
  },
  State_134261_Name = {
    Text = "Descanso privado del mediodía"
  },
  State_134262_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Tras \"Estallido de Locura\", el siguiente daño infligido por uno mismo se duplica."
  },
  State_134262_Name = {
    Text = "Descanso privado del mediodía"
  },
  State_134285_Desc = {
    Text = "Si los PV del objetivo son iguales o inferiores al número de Acumulaciones, elimina todos los Veredicto Final y lo mata instantáneamente."
  },
  State_134285_Name = {
    Text = "Veredicto del Destino"
  },
  State_134313_Desc = {
    Text = "Equipo Único: Escudo del personaje generado por el Portador +<WeaponEffect_Num:[StateArg1]%>, y cuando el Portador usa \"Buscar\", Amplificación Temporal +<WeaponEffect_Num:[StateArg2]%>, hasta 5 veces por turno."
  },
  State_134313_WeaponDesc = {
    Text = "Escudo del personaje generado por el Portador +<WeaponEffect_Num:[StateArg1]%>, y cuando el Portador usa \"Buscar\", Amplificación Temporal +<WeaponEffect_Num:[StateArg2]%>, hasta 5 veces por turno."
  },
  State_134384_Desc = {
    Text = "Las próximas [Layer] Tarjeta(s) de comando jugadas activarán \"Lanzadera Dimensional\"."
  },
  State_134384_Name = {
    Text = "Lanzadera Dimensional"
  },
  State_134389_Desc = {
    Text = "El Daño Final, la ganancia fija de <PowerIconKeywords:STR> y <TentacleInjurieIconKeywords:Daño de tentáculos>, el <IntoxicationIconKeywords:Veneno> fijo y el <RetaliateIconKeywords:Contrataque> de esta carta aumentan cada uno en +[DescArg1]%; el Escudo Fijo Final, la Recuperación de PV Fija y el <ExhaustionIconKeywords:STR▼> de esta carta aumentan cada uno en +[DescArg2]%. Las cartas con \"Faro de Singularidad\" no pueden activar \"Lanzadera Dimensional\"."
  },
  State_134389_Name = {
    Text = "<SingularityKeywords:Faro de Singularidad [DescArg2]>"
  },
  State_134391_Desc = {
    Text = "Cada turno, después de que se Juega la primera Tarjeta de comando, este Efecto se activa: la Copia Temporal de la Tarjeta de comando jugada se coloca en el Espacio Hiperspacial. Este Efecto no puede activarse durante los Turnos Ultra."
  },
  State_134391_Name = {
    Text = "<SingularityKeywords3:Lanzadera Dimensional>"
  },
  State_135232_Name = {
    Text = "<SingularityKeywords:Distorsión Espacial de Singularidad>: Durante el resto de este turno, cada vez que otro Cuerpo Despertado Juega una Tarjeta de comando, consume 1 <SilkKeywords:textil> para desatar Buscar: <DerivativeCardKeywords_137:\"Hilos Infinitos\">"
  },
  State_135233_Name = {
    Text = "<SingularityKeywords:Distorsión Espacial de Singularidad>: Durante el resto de este turno, cada vez que otro Cuerpo Despertado Juega una Tarjeta de comando, consume 1 <SilkKeywords:textil> para desatar Buscar: <DerivativeCardKeywords_137:\"Hilos Infinitos\">"
  },
  State_135919_Name = {
    Text = "<SingularityKeywords:Distorsión Espacial de Singularidad>: Durante el resto de este turno, cada vez que otro Cuerpo Despertado Juega una Tarjeta de comando, consume 1 <SilkKeywords:textil> para desatar Buscar: <DerivativeCardKeywords_137:\"Hilos Infinitos\">"
  },
  State_135920_Name = {
    Text = "<SingularityKeywords:Distorsión Espacial de Singularidad>: Durante el resto de este turno, cada vez que otro Cuerpo Despertado Juega una Tarjeta de comando, consume 1 <SilkKeywords:textil> para desatar Buscar: <DerivativeCardKeywords_137:\"Hilos Infinitos\">"
  },
  State_135921_Desc = {
    Text = "El daño del Despertar aumenta un 25%"
  },
  State_135921_Name = {
    Text = "<CardKeyWord:Castigar, para saldar una deuda de sangre>"
  },
  State_138824_Desc = {
    Text = "Una vida radiante que alaba la libertad y entona un canto de victoria, puede ser consumida por el Exaltar de Saya para mejorar su Efecto. Este Estado acumula hasta 4 capas y se conserva al finalizar el combate."
  },
  State_138824_Name = {
    Text = "<KaiHuajishu1:Gynoecium>"
  },
  State_139039_Desc = {
    Text = "El efecto final del próximo Exaltar de este Despertado en este turno aumenta en [Layer]%, incluyendo Daño, Blindaje fijo, Cicatrización fija de PV, Fortaleza fija, STR▼, Daño de tentáculos aumentado, Veneno fijo y Encimera fija."
  },
  State_139039_Name = {
    Text = "<BreedingKeywords2:Fiesta de Propagación>"
  },
  State_139687_Desc = {
    Text = "Una vida radiante que alaba la libertad y entona un canto de victoria, puede ser consumida por el Exaltar de Saya para mejorar su Efecto. Este Estado acumula hasta 4 capas y se conserva al finalizar el combate."
  },
  State_139687_Name = {
    Text = "<KaiHuajishu:Gynoecium>"
  },
  State_139688_Desc = {
    Text = "Equipo Único: Límite de Aritmética +1, los efectos del mismo tipo no se pueden acumular.\nPor cada 10 de Alienación básica que tenga el Portador, inflige +<WeaponEffect_Num:[StateArg1]%> Acumulaciones de <Corrosion:Corrosión> y causa +<WeaponEffect_Num:[Float:StateArg2]％> de Fusión Embrionaria."
  },
  State_139688_WeaponDesc = {
    Text = "Límite de Aritmética +1, los efectos del mismo tipo no se pueden acumular.\nPor cada 10 de Alienación básica que tenga el Portador, inflige +<WeaponEffect_Num:[StateArg1]%> Acumulaciones fijas de <Corrosion:Corrosión> y causa +<WeaponEffect_Num:[Float:StateArg2]%> de Fusión Embrionaria."
  },
  State_139689_Desc = {
    Text = "Equipo Único: Tras usar \"Horno Carmesí\", el Portador obtiene Alienación igual al <WeaponEffect_Num:[StateArg1]%> de la Alienación básica. Tiempo de reutilización: 3 turnos."
  },
  State_139689_WeaponDesc = {
    Text = "Tras usar \"Horno Carmesí\", el Portador obtiene un <WeaponEffect_Num:[StateArg1]%> de Aliemus Base como Alienación, con un enfriamiento de 3 turnos."
  },
  State_139977_Desc = {
    Text = "Este turno, si Juegas \"golpear\", \"golpear\" inflige +[DescArg1]% de Daño con Atravesar; de lo contrario, obtén +[Layer] de Barrera al final del turno."
  },
  State_139977_Name = {
    Text = "Bestia Estelar"
  },
  State_140063_Desc = {
    Text = "Este es un \"pagaré\" creado al tomar prestada Aritmética del próximo turno. Se deducirá [Layer] Aritmética al inicio del próximo turno. No se puede disipar."
  },
  State_140063_Name = {
    Text = "En Números Rojos"
  },
  State_140068_Desc = {
    Text = "Las próximas [DescArg1] Carta(s) de \"Habilidad\" cuestan – [StateArg1] Aritmética."
  },
  State_140068_Name = {Text = "Epifanía"},
  State_140135_Desc = {
    Text = "Por cada capa, el efecto final del próximo Exaltar de este Despertado en este turno aumenta en 1%, incluyendo Daño, Blindaje fijo, Cicatrización fija de PV, Fortaleza fija, STR▼, Daño de tentáculos aumentado, Veneno fijo y Encimera fija."
  },
  State_140135_Name = {
    Text = "<BreedingKeywords2:Fiesta de Propagación>"
  },
  State_140186_WeaponDesc = {
    Text = "Todas las instancias de daño del Salto del Titán +1"
  },
  State_140454_Desc = {
    Text = "Único en equipo: Por cada 1% de Sello Oscuro perdido por el portador, su Rueda del Destino o Pacto Secreto, se recupera <WeaponEffect_Num:[StateArg1] %> de Vida máx. al finalizar el combate. Al final de cada turno, este efecto de recuperación se reduce en un 30%, calculándose de forma independiente en cada caso. Tras usar \"Percepción\" en las \"Ruinas de Ceniza\", la actualización de las \"Ruinas de Ceniza\" en curso no consume Sellos Oscuros."
  },
  State_140454_WeaponDesc = {
    Text = "Por cada 1% de Recompensa de Sello Negro que tengan el Portador, sus Ruedas del destino y Pactos, recupera <WeaponEffect_Num:[DescArg2]%> de PV Max ([DescArg1]) al final de la batalla. Este efecto disminuye un 30% al final de cada turno y se calcula individualmente para cada batalla.\nTras elegir \"Inducción\" en \"Ruinas Cenicientas\", las actualizaciones serán gratuitas en estas \"Ruinas Cenicientas\"."
  },
  State_140456_WeaponDesc = {
    Text = "Al jugar, se elimina permanentemente"
  },
  State_140458_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Al equipar y tras la \"Explosión de Furia\" de cualquier Despertado, obtiene <Block:[Block:StateArg1]> de escudo."
  },
  State_140458_Name = {
    Text = "Ex Stellaris"
  },
  State_140489_Desc = {
    Text = "Obtiene una cantidad equivalente de Vida máx. Las acumulaciones no pueden superar la Vida máx. inicial del Cuerpo Despertado."
  },
  State_140489_Name = {Text = "Gynoecium"},
  State_140490_Desc = {
    Text = "Obtiene una cantidad equivalente de Vida máx. Las acumulaciones no pueden superar la Vida máx. inicial de dicho Cuerpo Despertado [DescArg1]."
  },
  State_140490_Name = {Text = "Gynoecium"},
  State_140495_Desc = {
    Text = "La Aritmética consumida por la siguiente \"habilidad\" - [Layer] ."
  },
  State_140495_Name = {Text = "Reescribir"},
  State_140517_Desc = {
    Text = "La próxima \"Habilidad\" consume Aritmética – [DescArg1]."
  },
  State_140517_Name = {Text = "Reescribir"},
  State_140547_Desc = {
    Text = "Este efecto puede aumentar la Fusión Embrionaria en un máximo de + 100, y no se ve beneficiado por efectos que aumenten la Fusión Embrionaria."
  },
  State_140547_Name = {
    Text = "Fusión Embrionaria Doble"
  },
  State_140645_Desc = {
    Text = "Efecto de espera"
  },
  State_140645_Name = {
    Text = "Efecto de espera"
  },
  State_140647_Name = {
    Text = "Monitoreo de juego de Disonancia Cognitiva"
  },
  State_140648_Name = {
    Text = "Contador de posesión de Disonancia Cognitiva del jugador"
  },
  State_140650_Desc = {
    Text = "Las primeras 3 veces en cada turno que juegas una Tarjeta de comando con \"Distorsión de Percepción\", Saya obtiene [Layer] de Aliemus."
  },
  State_140650_Name = {
    Text = "transformación cognitiva"
  },
  State_140651_Desc = {
    Text = "Efecto de espera"
  },
  State_140651_Name = {
    Text = "Efecto de espera"
  },
  State_140653_Desc = {
    Text = "El Coste de Aritmética de esta Carta tiene un 10% de probabilidad de -2, un 25% de -1, un 30% de no cambiar, un 25% de +1 y un 10% de +2. Elimina este Estado al Jugar o descartar la carta."
  },
  State_140653_Name = {
    Text = "<ExclamationPointColour:Pintar>"
  },
  State_140654_Desc = {
    Text = "Efecto de espera"
  },
  State_140654_Name = {
    Text = "Efecto de espera"
  },
  State_140655_Desc = {
    Text = "Esta Carta está cubierta por Disolución y no se puede leer su texto; el Coste de Aritmética tiene un 10% de probabilidad de -2, un 25% de -1, un 30% de no cambiar, un 25% de +1 y un 10% de +2. Elimina este Estado al Jugar o descartar la carta."
  },
  State_140655_Name = {
    Text = "<ErosionColorInkKeywords:Disolución Tinta colorida>"
  },
  State_140656_Desc = {
    Text = "El Coste de Aritmética de esta Carta tiene un 10% de probabilidad de -2, un 25% de -1, un 30% de no cambiar, un 25% de +1 y un 10% de +2. Elimina este Estado al Jugar o descartar la carta."
  },
  State_140656_Name = {
    Text = "<ColorInkKeywords:Pintar>"
  },
  State_140657_Desc = {
    Text = "Esta Carta está cubierta por Disolución y no se puede leer su texto; el Coste de Aritmética tiene un 10% de probabilidad de -2, un 25% de -1, un 30% de no cambiar, un 25% de +1 y un 10% de +2. Elimina este Estado al Jugar o descartar la carta."
  },
  State_140657_Name = {
    Text = "<ExclamationPointColour:Disolución Tinta colorida>"
  },
  State_140658_Name = {
    Text = "Monitoreo de posesión de Disonancia Cognitiva del jugador"
  },
  State_140659_Desc = {
    Text = "Efecto de espera"
  },
  State_140659_Name = {
    Text = "Efecto de espera"
  },
  State_140662_Desc = {
    Text = "Al inicio de cada turno, se aplica aleatoriamente \"Distorsión de Percepción\" a 2 Tarjetas de comando que no tengan \"Distorsión de Percepción\"."
  },
  State_140662_Name = {
    Text = "Reconstrucción de formas de vida"
  },
  State_140672_Desc = {
    Text = "Este Cuerpo Despertado cae en el caos, reduciendo el Daño infligido, la Recuperación de PV y el Blindaje en un 15%～35% aleatorio, y no puede ser disipado."
  },
  State_140672_Name = {
    Text = "<PVPCognitiveDissonanceKeyWords:Distorsión de Percepción>"
  },
  State_140673_Desc = {
    Text = "Este Cuerpo Despertado cae en el caos, reduciendo el Daño infligido, la Recuperación de PV y el Blindaje en un 15%～35% aleatorio, y no puede ser disipado."
  },
  State_140673_Name = {
    Text = "Distorsión de Percepción"
  },
  State_140683_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equipar, obtiene [StateArg1] <MaxHPKeywords:PV Max>. Al final del turno, recupera <Heal:[Heal:DescArg1]> PV. La Recuperación de PV aumenta a medida que los PV del Portador disminuyen, con un máximo de [StateArg3]%."
  },
  State_140683_Name = {
    Text = "Lily en el País de las Maravillas"
  },
  State_140724_Name = {
    Text = "Alimentación"
  },
  State_140726_Desc = {
    Text = "El Efecto final de Daño, Fortaleza, Daño de tentáculos, Veneno fijo, Contador fijo, Escudo del personaje, Cicatrización de PV y STR▼ infligido por esta Carta se reduce en [DescArg1]%."
  },
  State_140726_Name = {
    Text = "<AdaptKeywords1:Adaptación [DescArg1]>"
  },
  State_140727_Desc = {
    Text = "Cuando el hambre alcanza 5 capas, al final del turno consume todo el hambre, cambia la intención a Ataque poderoso y obtiene [DescArg1] puntos de Fortaleza."
  },
  State_140727_Name = {Text = "Hambre"},
  State_140728_Desc = {
    Text = "Al comienzo de cada turno obtiene 1 capa de Hambre; al causar Daño no bloqueado, obtiene Blindaje equivalente al 2% ([DescArg1]) del PV Max. El límite máximo de capas de Adaptación aumenta a 75."
  },
  State_140728_Name = {
    Text = "Guardar comida"
  },
  State_140730_Desc = {
    Text = "Al Jugar una Tarjeta de comando, aplica 10 capas de <AdaptKeywords:Adaptación> a las Cartas del Despertado al que pertenece en todos los lugares, y elimina 5 capas de <AdaptKeywords:Adaptación> de las Cartas de otros Despertados. Cada capa de <AdaptKeywords:Adaptación> reduce en un 1% el Efecto final del Daño, Fortaleza, Daño de tentáculos, Veneno fijo, Contrataque fijo, Blindaje, Cicatrización de PV y STR▼ causados por la Carta, hasta un máximo de [DescArg1] capas."
  },
  State_140730_Name = {Text = "Mimetismo"},
  State_140838_Desc = {
    Text = "El Daño infligido este turno se reduce un [Layer]%."
  },
  State_140838_Name = {
    Text = "Muro de Pesadilla que Eclipsa el Sol"
  },
  State_140839_Desc = {
    Text = "El Daño Final de todos los Cuerpos Despertados aumenta un [Layer]% este turno."
  },
  State_140839_Name = {
    Text = "Cacería Acompañante"
  },
  State_140856_Desc = {
    Text = "El Cuerpo Despertado no puede actuar. Al final del turno, se elimina 1 acumulación de Interferencia Mental. Después de eliminar todas las acumulaciones, la próxima vez que ese Cuerpo Despertado use Exaltar, se considerará como Sobreexaltar; si ya ha usado Sobreexaltar, se devuelve el 100% del Aliemus Base."
  },
  State_140856_Name = {
    Text = "<Yishiganshe:Interferencia de Consciencia>"
  },
  State_140860_Desc = {
    Text = "El Cuerpo Despertado no puede actuar. Al final del turno, se elimina 1 acumulación de Interferencia Mental. Después de eliminar todas las acumulaciones, la próxima vez que ese Cuerpo Despertado use Exaltar, se considerará como Sobreexaltar; si ya ha usado Sobreexaltar, se devuelve el 100% del Aliemus Base."
  },
  State_140860_Name = {
    Text = "<Yishiganshe:Interferencia de Consciencia>"
  },
  State_140861_Desc = {
    Text = "La próxima vez que use Exaltar, se considerará como Sobreexaltar; si ya ha usado Sobreexaltar, se devuelve el 100% del Aliemus Base."
  },
  State_140861_Name = {
    Text = "Lily en el País de las Maravillas"
  },
  State_140873_Desc = {
    Text = "Cada capa reduce en un 1% el Efecto final del Daño, Fortaleza, Daño de tentáculos, Veneno fijo, Contrataque fijo, Blindaje, Cicatrización de PV y STR▼ causados por esta Carta, hasta un máximo de [DescArg1] capas."
  },
  State_140873_Name = {
    Text = "<AdaptKeywords:Adaptación>"
  },
  State_140877_Name = {
    Text = "Activar [DescArg1] veces adicionales"
  },
  State_141468_Desc = {
    Text = "Al acumular 5 capas de Hambre, al final del turno se consume toda la Hambre, se cambia la intención a Ataque Poderoso y se obtiene Fuerza."
  },
  State_141468_Name = {
    Text = "<HungerKeywords:Hambre>"
  },
  State_141504_Desc = {
    Text = "Se acumulan hasta 3 unidades; al alcanzar el límite, la próxima \"Gala necrótica\" podrá consumirlas y mejorar su efecto. Los restos se heredarán a la siguiente batalla."
  },
  State_141504_Name = {Text = "escombros"},
  State_141950_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equipar y al final del turno, <PVPDiscoveryKeyWords:Descubre> [StateArg1] cartas de \"Habilidad\" con <PVPVoidKeywords:Oblivion> añadido y las coloca en la mano."
  },
  State_141950_Name = {
    Text = "Descenso Ascendente"
  },
  State_141988_Desc = {
    Text = "El Daño, Blindaje y curación causados por esta carta, así como la Fortaleza, Absorber, Daño de tentáculos, Veneno, Contrataque, Veredicto Final, Veneno fijo, Contrataque fijo y Veredicto Final fijo aplicados, aumentan su Efecto en [Layer]%."
  },
  State_141988_Name = {
    Text = "Iridiscencia de esta carta"
  },
  State_141989_Desc = {
    Text = "Crea Cartas aleatorias."
  },
  State_141989_Name = {
    Text = "<CardKeyWord:Descubrir>"
  },
  State_141991_Desc = {
    Text = "El Daño, Blindaje y curación causados por el Exaltar de este Cuerpo Despertado, así como la Fortaleza, Absorber, Daño de tentáculos, Veneno, Contrataque, Veredicto Final, Veneno fijo, Contrataque fijo y Veredicto Final fijo aplicados, aumentan su Efecto en [Layer]%."
  },
  State_141991_Name = {
    Text = "Iridiscencia del Exaltar"
  },
  State_141992_Desc = {
    Text = "El Daño, Blindaje y curación causados por las cartas de este Cuerpo Despertado, así como la Fortaleza, Absorber, Daño de tentáculos, Veneno, Contrataque, Veredicto Final, Veneno fijo, Contrataque fijo y Veredicto Final fijo aplicados, aumentan su Efecto en [Layer]%."
  },
  State_141992_Name = {
    Text = "Iridiscencia de esta carta"
  },
  State_141993_Desc = {
    Text = "El Daño, Blindaje y curación causados por las Tarjetas de comando de este Cuerpo Despertado, así como la Fortaleza, Absorber, Daño de tentáculos, Veneno, Contrataque, Veredicto Final, Veneno fijo, Contrataque fijo y Veredicto Final fijo aplicados, aumentan su Efecto en [Layer]%."
  },
  State_141993_Name = {
    Text = "Iridiscencia de Tarjeta de comando"
  },
  State_141994_Desc = {
    Text = "Al Jugar una Carta, después de Exaltar: Daño causado, Blindaje obtenido, curación, Fortaleza aplicada, Absorber, Daño de tentáculos, Veneno, Contrataque, Veredicto Final, Veneno fijo, Contrataque fijo, Veredicto Final fijo."
  },
  State_141994_Name = {
    Text = "Comando de Activación Multicolor"
  },
  State_142018_Desc = {
    Text = "Al inicio del turno, obtén 1 capa de <Guaiwucanhai:restos>"
  },
  State_142018_Name = {
    Text = "Invitación carmesí"
  },
  State_142057_Desc = {
    Text = "Después de usar una Posse, cambia la propia intención; al comenzar el combate, el Nivel de carga de la llave de plata de todos los Cuerpos Despertados aumenta un 25%."
  },
  State_142057_Name = {
    Text = "Epifanía de Causa y Efecto"
  },
  State_142058_Desc = {
    Text = "El Daño básico, Veneno y Contrataque infligidos se reducen un [DescArg1]%"
  },
  State_142058_Name = {
    Text = "Alas Impuras"
  },
  State_142060_Desc = {
    Text = "Cada vez que el enemigo usa una Tarjeta de comando, obtiene 1 capa de Fervor temporal. Al alcanzar 10 capas de Fervor temporal, después de jugar la siguiente Tarjeta de comando, actúa de inmediato y elimina todo el Fervor temporal."
  },
  State_142060_Name = {
    Text = "Eco del abismo"
  },
  State_142062_Desc = {
    Text = "El Efecto inicial de 0246 es aleatorio cada vez"
  },
  State_142062_Name = {
    Text = "Intención aleatoria"
  },
  State_142063_Desc = {
    Text = "Durante el propio turno, el Daño recibido se reduce un [DescArg1]%."
  },
  State_142063_Name = {
    Text = "Alas Sagradas"
  },
  State_142065_Desc = {
    Text = "Se elimina al Comenzar el turno. Al alcanzar 10 capas, después de jugar la siguiente Tarjeta de comando, actúa de inmediato y elimina todo el Fervor temporal."
  },
  State_142065_Name = {
    Text = "Fervor temporal"
  },
  State_142066_Desc = {
    Text = "Los efectos de <WeaknessIconKeywords:debilidad>, <FragileIconKeywords:frágil>, y <HeavyInjuryKeywords:aflicción> aumentan al 50%."
  },
  State_142066_Name = {
    Text = "Inspiración esencial"
  },
  State_142067_Desc = {
    Text = "El Daño de Fortaleza, Contrataque y tentáculos infligido se reduce un [DescArg1]%"
  },
  State_142067_Name = {
    Text = "Alas Malditas"
  },
  State_142072_Desc = {
    Text = "Cada vez que recibas daño o pierdas vida, no puede exceder el 5% de la salud máxima."
  },
  State_142072_Name = {
    Text = "Umbral de dolor soportado"
  },
  State_142091_Desc = {
    Text = "Contador de Duplicación de las seis alas"
  },
  State_142091_Name = {
    Text = "Contador de Duplicación de las seis alas"
  },
  State_142092_Desc = {
    Text = "El Nivel de carga de la llave de plata de todos los Cuerpos Despertados aumenta un 25%."
  },
  State_142092_Name = {
    Text = "Epifanía de Causa y Efecto"
  },
  State_142093_Desc = {
    Text = "Progreso de consumo de Duplicación de las seis alas: [DescArg1], valor de daño recibido requerido actualmente: [DescArg2]."
  },
  State_142093_Name = {
    Text = "Duplicación de las seis alas"
  },
  State_142095_Desc = {
    Text = "Marca de Duplicación de las seis alas"
  },
  State_142095_Name = {
    Text = "Marca de Duplicación de las seis alas"
  },
  State_142166_Desc = {
    Text = "Consulta la lógica de huelga general para efectos específicos. __ \"Solo para uso de desarrollo\""
  },
  State_142213_Name = {
    Text = "Reducir el límite de capacidad de cálculo"
  },
  State_142215_Desc = {
    Text = "Si sigue muerto al Comenzar el siguiente turno, renace y obtiene [StateArg1] de Blindaje. No puede ser disipado."
  },
  State_142215_Name = {
    Text = "Obsesión eterna"
  },
  State_142228_Desc = {
    Text = "Esta carta fue creada por la Rueda del destino \"Descenso Ascendente\"."
  },
  State_142228_Name = {
    Text = "Descenso Ascendente"
  },
  State_142229_Desc = {
    Text = "Equipo Único: Al comenzar la exploración, añade 1 carta de \"Lily en el País de las Maravillas\" al mazo. \"Lily en el País de las Maravillas\": Consume 2 puntos de Aritmética, el Portador obtiene <WeaponEffect_Num:[StateArg1]> puntos de Alienación y 3 acumulaciones de <Yishiganshe:\"Interferencia de Consciencia\">. <RetainIconKeywords:Retener>. <DepleteIconKeywords:Consumir>."
  },
  State_142229_Name = {
    Text = "Lily en el País de las Maravillas"
  },
  State_142229_WeaponDesc = {
    Text = "Al comenzar la exploración, añade 1 carta de \"Lily en el País de las Maravillas\" al mazo. \"Lily en el País de las Maravillas\": Consume 2 puntos de Aritmética, hace que el Portador obtenga <WeaponEffect_Num:[StateArg1]> puntos de Alienación y <Yishiganshe:\"Interferencia de Consciencia\">. <RetainIconKeywords:Retener>. <DepleteIconKeywords:Consumir>."
  },
  State_142452_Desc = {
    Text = "Los efectos de STR▼ recibidos se reducen un 50%."
  },
  State_142452_Name = {
    Text = "Existencia inmortal"
  },
  State_142663_Desc = {
    Text = "Al Comenzar el siguiente turno, obtiene <DelayKeywords:Latencia>: [Layer] de Alienación."
  },
  State_142663_Name = {
    Text = "Locura retardada con Latencia"
  },
  State_142688_Desc = {
    Text = "La Rueda del destino equipada por el objetivo queda anulada. No puede ser disipado."
  },
  State_142688_Name = {
    Text = "Super Entrelazados"
  },
  State_142692_Desc = {
    Text = "Están surgiendo nuevas ideas ingeniosas."
  },
  State_142692_Name = {
    Text = "Inspiración repentina"
  },
  State_142715_Desc = {
    Text = "El daño de esta \"habilidad\" aumenta un [DescArg1]%, y por cada punto de Aritmética que esta habilidad necesite consumir, aumenta un [StateArg1]%."
  },
  State_142715_Name = {
    Text = "Muerte ámbar"
  },
  State_142887_Desc = {
    Text = "Si este turno vuelve a recibir \"Parálisis\", todos sus \"golpear\" se convierten en \"Espejismo\", no puede ser disipado, y dura hasta el final del turno."
  },
  State_142887_Name = {
    Text = "Un poco entumecido"
  },
  State_142954_Desc = {
    Text = "El Límite de Aritmética tiene un mínimo de 0. Al Comenzar cada turno, si es menor que 10, aumenta en 1. Al alcanzar 10, cualquier Límite de Aritmética adicional obtenido se convierte en robar la misma cantidad de Cartas."
  },
  State_142954_Name = {
    Text = "Límite de Aritmética"
  },
  State_143002_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_143002_Name = {
    Text = "Sartogua SR(Texto temporal)"
  },
  State_143004_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_143004_Name = {
    Text = "Arma exclusiva de Satogua (texto temporal)"
  },
  State_143005_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_143005_Name = {
    Text = "Lantigos SR (Texto temporal)"
  },
  State_143006_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_143006_Name = {
    Text = "Arma exclusiva de Faraón negro (texto temporal)"
  },
  State_143007_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equiparse y al inicio del turno, aplica [StateArg1] <plural value=\"[StateArg1]\" singular=\"Acumulación\" plural=\"Acumulaciones\"> de <PVPCompassKeywords:La Brújula Errante> a un enemigo aleatorio."
  },
  State_143007_Name = {
    Text = "La Brújula Errante"
  },
  State_143008_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_143008_Name = {
    Text = "Arma exclusiva de Pájaro Shatak (texto temporal)"
  },
  State_143009_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_143009_Name = {
    Text = "Arma exclusiva de Aphogmon (texto temporal)"
  },
  State_143010_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Tamaño Máximo de la Mano+ [StateArg1]. Cuando el Portador o un aliado muere, sus cartas ya no se convierten en <PVPDerivativeCardKeywords_2:\"Espejismo\">, sino en <PVPDerivativeCardKeywords_30:\"Gaunt-Pillaje\">."
  },
  State_143010_Name = {
    Text = "Jaula Viviente"
  },
  State_143011_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_143011_Name = {
    Text = "Buitre SR (Texto temporal)"
  },
  State_143012_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_143012_Name = {
    Text = "Shatako SR (Texto temporal)"
  },
  State_143013_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_143013_Name = {
    Text = "Origen Ogier SR (Texto temporal)"
  },
  State_143014_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Antes de \"Exaltar\" pierde el 25% de PV actuales; después de \"Exaltar\" inflige [StateArg1] de Daño a todos los enemigos y Drena PV equivalentes."
  },
  State_143014_Name = {
    Text = "Engaño emmelado"
  },
  State_143016_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_143016_Name = {
    Text = "Faraón Negro SR (Texto temporal)"
  },
  State_143017_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_143017_Name = {
    Text = "Arma exclusiva de Lantigos (texto temporal)"
  },
  State_143018_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_143018_Name = {
    Text = "Bendito Turu SR (Texto temporal)"
  },
  State_143019_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Después de \"Exaltar\", aplica [StateArg1] capas de <PVPBless:Bendición> a todos los enemigos."
  },
  State_143019_Name = {
    Text = "La Dulce Verdad"
  },
  State_143020_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_143020_Name = {
    Text = "Arma exclusiva de Ogier Origen (texto temporal)"
  },
  State_143022_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_143022_Name = {
    Text = "Arma exclusiva de Buitre (texto temporal)"
  },
  State_143023_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_143023_Name = {
    Text = "Afogomon SR (Texto temporal)"
  },
  State_143326_Desc = {
    Text = "Regeneración de Llave Plateada aumentada en [DescArg1]."
  },
  State_143326_Name = {
    Text = "Epifanía de Causa y Efecto"
  },
  State_143331_Desc = {
    Text = "Antes de que termine el siguiente turno, absorbe la mitad del Daño de <StatusApplier:>. Este Estado es Equipo Único, se elimina cuando muere cualquiera de los dos vinculados y no puede ser disipado."
  },
  State_143331_Name = {
    Text = "Recepción de Daño"
  },
  State_143333_Desc = {
    Text = "Antes de que comience el siguiente turno, <StatusApplier:> absorbe la mitad del Daño por ti. Este Estado es Equipo Único, se elimina cuando muere cualquiera de los dos vinculados y no puede ser disipado."
  },
  State_143333_Name = {
    Text = "Desvío de Daño"
  },
  State_143336_Desc = {
    Text = "Al jugar \"Gaunt\", consume 1 capa para que tenga efecto 1 vez adicional. Límite de 9 capas, no se eliminan al finalizar el combate."
  },
  State_143336_Name = {
    Text = "<BattueKeywords:La Cacería>"
  },
  State_143340_Desc = {
    Text = "Al jugar \"Gaunt\", consume 1 capa para que tenga efecto 1 vez adicional. Límite de 9 capas, no se eliminan al finalizar el combate."
  },
  State_143340_Name = {
    Text = "<BattueKeywords:La Cacería>"
  },
  State_143386_Desc = {
    Text = "Absorbe la mitad del Daño de <StatusApplier:>, no puede ser disipado."
  },
  State_143386_Name = {
    Text = "Recepción de Daño"
  },
  State_143387_Desc = {
    Text = "<StatusApplier:> absorbe la mitad del Daño por ti, no puede ser disipado."
  },
  State_143387_Name = {
    Text = "Desvío de Daño"
  },
  State_143406_Name = {
    Text = "Esta Carta tiene efecto [DescArg1] veces adicionales"
  },
  State_143408_Desc = {
    Text = "Cuando es atacado por un enemigo, se convierte al Aliemus del atacante."
  },
  State_143408_Name = {
    Text = "La Brújula Errante"
  },
  State_143409_Desc = {
    Text = "Cuando es atacado por un enemigo, se convierte al Aliemus del atacante."
  },
  State_143409_Name = {
    Text = "<CardKeyWord:La Brújula Errante>"
  },
  State_143419_Desc = {
    Text = "Esta carta proviene de <PVPDerivativeCardKeywords_31:\"El tesoro de Aurita\">."
  },
  State_143419_Name = {
    Text = "El tesoro de Aurita"
  },
  State_143426_Desc = {
    Text = "Al comenzar el turno, deduce [Layer] de Aritmética, no puede ser disipado."
  },
  State_143426_Name = {
    Text = "Deducción de Aritmética con Latencia"
  },
  State_143441_Desc = {
    Text = "Cuerpo Despertado seleccionado en la ronda [StateArg1] de operaciones."
  },
  State_143441_Name = {
    Text = "Marca de prueba 1"
  },
  State_143442_Desc = {
    Text = "Cuerpo Despertado seleccionado en la ronda [StateArg1] de operaciones."
  },
  State_143442_Name = {
    Text = "Marca de prueba 2"
  },
  State_143444_Desc = {
    Text = "Cuerpo Despertado seleccionado en la ronda [StateArg1] de operaciones."
  },
  State_143444_Name = {
    Text = "Marca de prueba 4"
  },
  State_143445_Desc = {
    Text = "Cuerpo Despertado seleccionado en la ronda [StateArg1] de operaciones."
  },
  State_143445_Name = {
    Text = "Marca de prueba 3"
  },
  State_143499_Name = {
    Text = "Inmunidad al Daño Activo__\"Solo para desarrollo\""
  },
  State_143500_Name = {
    Text = "Inmunidad al Daño Puro__\"Solo para desarrollo\""
  },
  State_143541_Desc = {
    Text = "El Daño causado por todos los enemigos este turno se reduce en [DescArg1]%, y gana [DescArg2] puntos de Fortaleza."
  },
  State_143541_Name = {Text = "Escolta"},
  State_143542_Desc = {
    Text = "Daño Final Temporal +[DescArg1]%, y aplica Corrosión equivalente al [DescArg2]% de PV Max a todos los enemigos."
  },
  State_143542_Name = {Text = "Caza"},
  State_143548_Desc = {
    Text = "Aplica Blindaje y añade Estado, monstruo, rama 1."
  },
  State_143548_Name = {
    Text = "Conversión de Blindaje de Monstruo 1"
  },
  State_143549_Desc = {
    Text = "Aplica Blindaje y añade Estado, Cuerpo Despertado, rama 2."
  },
  State_143549_Name = {
    Text = "Conversión de Blindaje de Personaje 2"
  },
  State_143550_Desc = {
    Text = "Aplica Blindaje y añade Estado, Cuerpo Despertado, rama 1."
  },
  State_143550_Name = {
    Text = "Conversión de Blindaje de Personaje 1"
  },
  State_143551_Desc = {
    Text = "Causa Blindaje y añade Estado, monstruo, rama 2."
  },
  State_143551_Name = {
    Text = "Conversión de Blindaje de Monstruo 2"
  },
  State_143552_Desc = {
    Text = "Aplica Blindaje y añade Estado, jugador, rama 1."
  },
  State_143552_Name = {
    Text = "Conversión de Blindaje del Jugador 1"
  },
  State_143553_Desc = {
    Text = "Aplica Blindaje y añade Estado, jugador, rama 2."
  },
  State_143553_Name = {
    Text = "Conversión de Blindaje del Jugador 2"
  },
  State_143573_Desc = {
    Text = "Los Gaunt son cartas de mejora de Pontos que incluyen \"Gaunt-Asalto\", \"Gaunt-Tormento\" y \"Gaunt-Matanza\", con un total de 3 tipos. Al generar un \"Gaunt\" permanente, si los \"Gaunt\" superan las 6 cartas, se mejorará aleatoriamente un \"Gaunt\" permanente a \"Gaunts Conjuntos\" con Coste de Aritmética +1 pero que Tiene efecto 1 vez adicional; si todos los \"Gaunt\" ya han sido mejorados, se coloca en la mano 1 carta de \"Adv. Insight\" con <DestructionKeywords:Destruir>."
  },
  State_143573_Name = {Text = "Gaunt"},
  State_143578_Desc = {
    Text = "Durante este turno, cada vez que recibas Daño Activo, añade [Layer] carta(s) de <PVPDerivativeCardKeywords_30:\"Siervo-Gaunt\"> a la Mano."
  },
  State_143578_Name = {
    Text = "Ritual del Señor"
  },
  State_143595_Desc = {
    Text = "Se añadió <PrepareKeywords:Preparar> [StateArg1] a esta Carta."
  },
  State_143595_Name = {
    Text = "La danza del cisne negro"
  },
  State_143597_Desc = {
    Text = "Equipo Único: El efecto de STR▼ causado por el Portador aumenta un <WeaponEffect_Num:[StateArg1]%>. Al cambiar a la postura \"Olas furiosas\", el Daño crítico temporal aumenta en una cantidad igual al <WeaponEffect_Num:[StateArg1]%> del Daño Crítico base propio, con un enfriamiento de 3 turnos."
  },
  State_143597_WeaponDesc = {
    Text = "El efecto de STR▼ causado por el Portador aumenta un <WeaponEffect_Num:[StateArg1]%>. Al cambiar a la postura \"Olas furiosas\", el Daño crítico temporal aumenta un <WeaponEffect_Num:[DescArg1]%>, con un enfriamiento de 3 turnos."
  },
  State_143598_Desc = {
    Text = "Equipo Único: El efecto de STR▼ causado por el Portador aumenta un <WeaponEffect_Num:[StateArg1]%>; por cada enemigo eliminado, la Alienación de cicatrización fija al final del turno de exploración actual del Portador aumenta en 2 puntos, acumulable hasta <WeaponEffect_Num:[StateArg2]> veces. Al cambiar a la postura \"Olas furiosas\", el Daño crítico temporal aumenta en una cantidad igual al <WeaponEffect_Num:[StateArg1]%> del Daño Crítico base propio, con un enfriamiento de 3 turnos."
  },
  State_143598_WeaponDesc = {
    Text = "El efecto de STR▼ causado por el Portador aumenta un <WeaponEffect_Num:[StateArg1]%>; por cada enemigo eliminado, la Alienación de cicatrización fija al final del turno de exploración actual del Portador aumenta en 2 puntos, acumulable hasta <WeaponEffect_Num:[StateArg2]> veces. Al cambiar a la postura \"Olas furiosas\", el Daño crítico temporal aumenta un <WeaponEffect_Num:[DescArg1]%>, con un enfriamiento de 3 turnos."
  },
  State_143683_Desc = {
    Text = "La persecución de este Cuerpo Despertado está Sellada y no puede usarse, el Sellado se elimina después de [Layer] turnos."
  },
  State_143683_Name = {
    Text = "<Seal1:Perseguir Sellado>"
  },
  State_144381_Desc = {
    Text = "No puede realizar Acciones. Turnos Restantes: [DescArg1]."
  },
  State_144381_Name = {
    Text = "<Yishiganshe:Interferencia de Consciencia>"
  },
  State_144441_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Cuando un aliado muere, uno mismo obtiene <Energy:[Energy:StateArg1]> de Alienación. Cuando un aliado renace, este obtiene <Energy:[Energy:StateArg2]> de Alienación. El efecto de obtener Alienación solo se activa cuando la Alienación del objetivo no está llena; quedan [Layer] activaciones, tras agotarse se Destruye esta Rueda del destino."
  },
  State_144441_Name = {
    Text = "Sincronización de Almas"
  },
  State_144494_Desc = {
    Text = "Hay 7 tipos de efectos, entre ellos: robar 8 tarjetas, ganar 6 de Aritmética, ganar Keyflare, todos los Despertados ganan Alienación Fija, ganar FUE, reducir temporalmente la FUE de todos los enemigos, aumentar temporalmente la Amplificación de Daño."
  },
  State_144494_Name = {
    Text = "<Blessing:Bendición>"
  },
  State_144508_Desc = {
    Text = "El \"Precio\" viene en 3 tipos:\n\nOportunidad Perdida: Retrasa el efecto del \"Don\" asociado 2 turnos.\nPalabras Doradas: Reduce el efecto del \"Don\" asociado en un 50%.\nMalicia Velada: Inflige 1 efecto negativo aleatorio a tu equipo:\n<Italic:2 turnos de Síntoma: Debilidad; 2 turnos de Frágil, 2 turnos de Plaga; Acumulaciones de Veneno iguales al 1% del PV Max; 2 Acumulaciones de Vacío; 1 Acumulación de Estancamiento en 2 tarjetas aleatorias en mano; o genera 2 Tarjetas de síntomas Temporales (que no persisten entre batallas) y las coloca en la cima del Mazo de robo.>"
  },
  State_144508_Name = {
    Text = "<BlessingNegativeEffect:Precio>"
  },
  State_144519_Desc = {
    Text = "Variable de proceso de prueba, se refresca al comenzar el turno o al jugar una Carta. Actualmente posee [Layer] espíritus del Reino."
  },
  State_144519_Name = {
    Text = "Espíritu del nuevo Reino del Caos"
  },
  State_145228_Name = {
    Text = "<WormGrowth:Festín>"
  },
  State_145229_Desc = {
    Text = "¡Eres parte de la Bendición~! Puede ser consumida por el Exaltar de Caraboo para obtener un beneficio, se acumula hasta 5. Persiste entre batallas."
  },
  State_145229_Name = {
    Text = "<SacrificialMark:Sacrificio>"
  },
  State_145436_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: El Daño de \"golpear\" aumenta un [DescArg1]%, y tras cada \"golpear\" el Daño aumenta adicionalmente un [StateArg2]%, hasta un máximo de [StateArg3]%."
  },
  State_145436_Name = {
    Text = "Huesos del Hambre Inmortal"
  },
  State_145437_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equipar, obtiene [StateArg2] acumulaciones de <EnergyStorageKeywords:Cargar>, el Daño de \"golpear\" aumenta un [StateArg1]% y se convierte en <PVPPunctureDamagewords:Daño Penetrante>."
  },
  State_145437_Name = {
    Text = "Ruina Celestial"
  },
  State_145456_Desc = {
    Text = "Al seleccionar objetivos, ignora Pulla, sigilo y Bloqueo de Objetivo. Si varios objetivos cumplen la misma condición, se prioriza el Cuerpo Despertado que esté más adelante."
  },
  State_145456_Name = {
    Text = "PV y Blindaje mínimos"
  },
  State_145457_Desc = {
    Text = "Al seleccionar objetivos, ignora Pulla, sigilo y Bloqueo de Objetivo. Si varios objetivos cumplen la misma condición, se prioriza el Cuerpo Despertado que esté más adelante."
  },
  State_145457_Name = {
    Text = "PV y Blindaje máximos"
  },
  State_145495_Desc = {
    Text = "Esta Carta se juega con Doble disparo."
  },
  State_145495_Name = {
    Text = "<CardKeyWord:Doble disparo>"
  },
  State_145554_Desc = {
    Text = "Equipo Único：Después de Comenzar la exploración, añade 1 <Falltospace1[StateArg3]:\"Estancia Mortal\"> al mazo. \"Estancia Mortal\"：Consume 0 Aritmética. Inflige a todos los enemigos una <Corrosion:Corrosión> fija igual al <WeaponEffect_Num:[StateArg1]%> del ATQ del Portador y al <WeaponEffect_Num:[Float:StateArg4]%> de su PV Max, hace que las Tarjetas de comando de los demás Cuerpos Despertados en cada posición obtengan <ErosionColorInkKeywords:Distorsión de Percepción> y Baraja 1 <Falltospace2[StateArg3]:\"Descenso Ascendente\"> en el Mazo de robo. <RetainIconKeywords:Retener>. <DepleteIconKeywords:Consumo>."
  },
  State_145554_Name = {
    Text = "Descenso Ascendente"
  },
  State_145554_WeaponDesc = {
    Text = "Tras comenzar la exploración, añade 1 <Falltospace1[StateArg3]:\"Estancia Mortal\"> al mazo. \"Estancia Mortal\": Consume 0 de Aritmética. Inflige a todos los enemigos Corrosión fija equivalente al <WeaponEffect_Num:[StateArg1]%> del ATQ del Portador y al <WeaponEffect_Num:[Float:StateArg4]%> de sus PV Max, hace que las Tarjetas de comando de otros Cuerpos Despertados en cada lugar apliquen <Corrosion:Corrosión> y <ErosionColorInkKeywords:Distorsión de Percepción>, y baraja 1 <Falltospace2[StateArg3]:\"Descenso Ascendente\"> en el Mazo de robo. <RetainIconKeywords:Retener>. <DepleteIconKeywords:Consumo>"
  },
  State_145572_Desc = {
    Text = "Al comienzo de cada turno, todos los demás Cuerpos Despertados reciben <Damage:[Damage:Layer]> de Daño Penetrante."
  },
  State_145572_Name = {
    Text = "Tormenta Devoradora de Cetus"
  },
  State_145590_Desc = {
    Text = "Cuando se coloca en la mano una Carta idéntica con la misma pertenencia, se activa el Efecto de Fusión y se consume dicha Carta."
  },
  State_145590_Name = {
    Text = "<CardKeyWord:Fusión>"
  },
  State_145592_Desc = {
    Text = "Bloquea a un enemigo y lo establece como objetivo de ataque prioritario. Al seleccionar un objetivo individual, solo se puede seleccionar el objetivo bloqueado, ignorando Pulla y ocultamiento."
  },
  State_145592_Name = {
    Text = "<CardKeyWord:Bloqueo de Objetivo>"
  },
  State_145619_Name = {Text = "Plaga"},
  State_145620_Name = {Text = "Vacío"},
  State_145621_Desc = {
    Text = "El efecto \"Bendición\" se reduce en un 50%."
  },
  State_145621_Name = {
    Text = "<Bleesing_Exaggerate:Exageración>"
  },
  State_145622_Name = {
    Text = "Estancamiento"
  },
  State_145623_Desc = {
    Text = "Inflige 1 efecto negativo aleatorio a tu equipo:\n<Italic:2 turnos de Síntoma: Debilidad; 2 turnos de Frágil, 2 turnos de Plaga; Acumulaciones de Veneno iguales al 1% del PV Max; 2 Acumulaciones de Vacío; 1 Acumulación de Estancamiento en 2 tarjetas aleatorias en mano; o genera 2 Tarjetas de síntomas Temporales (que no persisten entre batallas) y las coloca en la cima del Mazo de robo.>"
  },
  State_145623_Name = {
    Text = "<Bleesing_Negative:Malicia Velada>"
  },
  State_145624_Name = {Text = "Debilidad"},
  State_145625_Name = {
    Text = "2 \"Tarjetas de síntomas\" temporales idénticas"
  },
  State_145626_Name = {Text = "Frágil"},
  State_145627_Name = {Text = "Veneno"},
  State_145628_Desc = {
    Text = "Obtén el efecto \"Bendición\" después de 2 turnos."
  },
  State_145628_Name = {
    Text = "<Bleesing_Delay:Oportunidad Perdida>"
  },
  State_145631_Desc = {
    Text = "El Daño de \"golpear\" aumenta un [StateArg1]% y se convierte en <PVPPunctureDamagewords:Daño Penetrante>."
  },
  State_145631_Name = {
    Text = "Ruina Celestial"
  },
  State_145632_Desc = {
    Text = "Esta carta proviene de la Rueda del destino \"Hora de la Fortuna\"."
  },
  State_145632_Name = {
    Text = "Hora de la Fortuna"
  },
  State_145638_Desc = {
    Text = "El Coste de Aritmética de esta Carta aumenta en [Layer]."
  },
  State_145638_Name = {
    Text = "Cruel homenaje"
  },
  State_145642_Desc = {
    Text = "Todos los Despertados obtienen [StateArg1] puntos de Alienación después de 2 turnos, [Layer] veces."
  },
  State_145642_Name = {
    Text = "Locura retardada"
  },
  State_145644_Desc = {
    Text = "Obtén <Posse:[StateArg1]> puntos de Llave Plateada después de 2 turnos, [Layer] veces."
  },
  State_145644_Name = {
    Text = "Llave Plateada con Latencia"
  },
  State_145645_Desc = {
    Text = "Reduce temporalmente [StateArg1] puntos de <ExhaustionIconKeywords:Fuerza> a todos los enemigos después de 2 turnos, [Layer] veces"
  },
  State_145645_Name = {
    Text = "Agotamiento retardado"
  },
  State_145646_Desc = {
    Text = "Obtén [StateArg1] puntos de Aritmética después de 2 turnos, [Layer] veces."
  },
  State_145646_Name = {
    Text = "Latencia Aritmética"
  },
  State_145647_Desc = {
    Text = "Obtén [StateArg1] puntos de <PowerIconKeywords:Fuerza> después de 2 turnos, [Layer] veces."
  },
  State_145647_Name = {
    Text = "Fortaleza con Latencia"
  },
  State_145648_Desc = {
    Text = "Roba [StateArg1] cartas después de 2 turnos, [Layer] veces."
  },
  State_145648_Name = {
    Text = "Tirada retrasada"
  },
  State_145649_Desc = {
    Text = "Amplificación de Daño Temporal de [StateArg1]% después de 2 turnos, [Layer] veces."
  },
  State_145649_Name = {
    Text = "Latencia de Amplificación de Daño Temporal"
  },
  State_145652_Desc = {
    Text = "El consumo de aritmética de esta carta se reduce en [Layer]."
  },
  State_145652_Name = {
    Text = "Libertad Insoportable"
  },
  State_145654_Desc = {
    Text = "Prueba. Después de jugarse, o al salir de la Mano, Destruir."
  },
  State_145654_Name = {
    Text = "Prueba. Efímero"
  },
  State_145660_Desc = {
    Text = [=[
Aliados
1.<AllyPosAwaker1Name:> [DescArg1]
2.<AllyPosAwaker2Name:> [DescArg2]
3.<AllyPosAwaker3Name:> [DescArg3]
4.<AllyPosAwaker4Name:> [DescArg4]
Enemigos
1.<EnemyPosAwaker1Name:> [DescArg5]
2.<EnemyPosAwaker2Name:> [DescArg6]
3.<EnemyPosAwaker3Name:> [DescArg7]
4.<EnemyPosAwaker4Name:> [DescArg8]]=]
  },
  State_145660_Name = {
    Text = "Cambio de PV tras Reiniciar"
  },
  State_145693_Desc = {
    Text = "Después de terminar el turno, el costo de aritmética disminuye en [Layer]; el efecto también se activa si se descarta"
  },
  State_145693_Name = {
    Text = "<PrepareKeypvewordscolour:preparar[Layer]>"
  },
  State_145693_WeaponDesc = {
    Text = "Las cartas no entran en la pila de descarte durante la fase de descarte, sino que se mantienen en la mano"
  },
  State_145694_Desc = {Text = "—"},
  State_145694_Name = {
    Text = "Empatía con el Pantano Negro"
  },
  State_145694_WeaponDesc = {Text = "—"},
  State_145698_Desc = {
    Text = "Prioriza atacar al <StatusApplier:> bloqueado, al seleccionar un objetivo individual solo puede seleccionar el objetivo bloqueado, ignorando Pulla y ocultamiento."
  },
  State_145698_Name = {
    Text = "Bloqueo de Objetivo"
  },
  State_145699_Desc = {
    Text = "·Ataca prioritariamente al <StatusApplier:> bloqueado. Al seleccionar un objetivo individual, solo se puede seleccionar el objetivo bloqueado, ignorando Pulla y ocultamiento.\n·Tras la propia muerte, <StatusApplier:> obtiene \"<PVPDerivativeCardKeywords_32:¡A luchar!>\"."
  },
  State_145699_Name = {
    Text = "Bloqueo de Objetivo"
  },
  State_145709_Desc = {
    Text = "Cada acumulación aumenta el PV Max en un 10% del CON de Caraboo (máx. 50 acumulaciones). Al alcanzar el máximo de acumulaciones, las acumulaciones excedentes curan en su lugar por 3× este valor de PV. Se pueden ganar hasta 10 acumulaciones de \"Saciedad\" por batalla que no sea contra un Jefe. La \"Saciedad\" persiste entre batallas."
  },
  State_145709_Name = {
    Text = "<WormGrowth:Festín>"
  },
  State_145710_Desc = {
    Text = "¡Eres parte de la Bendición~! Puede ser consumida por el Exaltar de Caraboo para obtener un beneficio, se acumula hasta 5. Persiste entre batallas."
  },
  State_145710_Name = {
    Text = "<SacrificialMark:Sacrificio>"
  },
  State_145901_Desc = {
    Text = [=[
Aliados
1.<AllyPosAwaker1Name:> [DescArg1]
2.<AllyPosAwaker2Name:> [DescArg2]
3.<AllyPosAwaker3Name:> [DescArg3]
4.<AllyPosAwaker4Name:> [DescArg4]]=]
  },
  State_145901_Name = {
    Text = "Cambio de PV tras Reiniciar"
  },
  State_146041_Desc = {
    Text = "Este Cuerpo Despertado siente que se ha alejado del bullicio mundano.\nNo puede realizar ninguna Acción hasta el final del turno, reduce el Daño recibido en un 99%; si el objetivo no tiene Resistencia, le otorga Resistencia.\nNo puede realizar ninguna Acción hasta el final del turno, reduce el Daño recibido en un 99%; si el objetivo no tiene Resistencia, le otorga Resistencia.\n·Al finalizar el Efecto, inflige <Damage:[Layer]> de Daño pasivo a todos los aliados.\n·Si al aplicarlo el objetivo ya tiene Resistencia, Engaño termina inmediatamente y el Daño al objetivo se duplica."
  },
  State_146041_Name = {Text = "Engañar"},
  State_146043_Desc = {
    Text = "Al inicio del siguiente turno, deduce [Layer] de Aliemus."
  },
  State_146043_Name = {
    Text = "Deducción de Aliemus con Latencia"
  },
  State_146058_Desc = {
    Text = "Variable de proceso de prueba, se refresca al comenzar el turno o al jugar una Carta. Actualmente debería tener [Layer]% de eficiencia de ATQ."
  },
  State_146058_Name = {
    Text = "Eficiencia de ATQ de Posse"
  },
  State_146059_Desc = {
    Text = "Variable de proceso de prueba, se refresca al comenzar el turno o al jugar una Carta. Actualmente debería tener [Layer]% de eficiencia de DEF."
  },
  State_146059_Name = {
    Text = "Eficiencia de DEF de Posse"
  },
  State_146079_Desc = {
    Text = "Esta Carta regresa a la mano después de ser jugada o descartada."
  },
  State_146079_Name = {
    Text = "<Recycle:Regresa a la mano al salir de ella>"
  },
  State_146085_Desc = {
    Text = "Cambiar la Aritmética de la Carta antes de jugarla este turno"
  },
  State_146085_Name = {
    Text = "Cambiar la Aritmética de la Carta antes de jugarla este turno"
  },
  State_146085_WeaponDesc = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_146086_Desc = {
    Text = "Cambiar la Aritmética de la Carta antes de jugarla este turno"
  },
  State_146086_Name = {
    Text = "Cambiar la Aritmética de la Carta antes de jugarla este turno"
  },
  State_146086_WeaponDesc = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_146117_Desc = {
    Text = "Puede ser consumido por \"<DerivativeCardKeywords_157:Hueso de Espada>\" para obtener un beneficio. Este estado puede acumularse hasta 15 capas."
  },
  State_146117_Name = {
    Text = "<Shimieluotanhuodong2:Intención de batalla>"
  },
  State_146129_Desc = {
    Text = "Daño Final de todos los Despertados +[Layer]%."
  },
  State_146129_Name = {
    Text = "Voluntad Asesina del Cielo Ballena"
  },
  State_146147_Desc = {
    Text = "Puede ser consumido por \"<DerivativeCardKeywords_157:Hueso de Espada>\" para obtener un beneficio. Este estado puede acumularse hasta 15 capas."
  },
  State_146147_Name = {
    Text = "<Shimieluotanhuodong1:Intención de batalla>"
  },
  State_146154_Desc = {
    Text = "Hace que el Cuerpo Despertado se sienta bien. Su \"Habilidad\" será transformada en \"Bendición?\", y tras la transformación se consumirán las Acumulaciones equivalentes."
  },
  State_146154_Name = {
    Text = "<PVPBlessColour:Bendición>"
  },
  State_146155_Desc = {
    Text = "Este Cuerpo Despertado se siente bien.\n·A continuación, [Layer] cartas de \"Habilidad\" serán transformadas en \"¿Bendición?\", y al transformarse consumirán acumulaciones equivalentes."
  },
  State_146155_Name = {Text = "Bendición"},
  State_146155_WeaponDesc = {Text = "No"},
  State_146202_Desc = {
    Text = "Hace que el Cuerpo Despertado sienta que se ha alejado del bullicio mundano.\nNo puede realizar ninguna Acción antes de que termine el turno, reduce el Daño recibido en un 99%. Si el objetivo no tiene Resistencia, le otorga Resistencia.\n·Al finalizar el Efecto, inflige Daño pasivo equivalente a las Acumulaciones a todos los aliados.\n·Si al aplicarlo el objetivo ya tiene Resistencia, Engaño termina de inmediato y el Daño al objetivo se duplica."
  },
  State_146202_Name = {
    Text = "<CardKeyWord:Embaucar>"
  },
  State_146352_Desc = {
    Text = "Por cada 1 Daño recibido, acumula [StateArg1] capas de <Shimieluotanhuodong1:Intención de batalla>"
  },
  State_146352_Name = {
    Text = "Curtido en Batalla"
  },
  State_146363_Desc = {
    Text = "Al comienzo del siguiente turno, elimina [Layer] PV. Al perder PV, reduce las Acumulaciones de este Estado en la misma cantidad."
  },
  State_146363_Name = {
    Text = "Lo Que No Es Mentira"
  },
  State_146383_Desc = {
    Text = "Después de añadir un Estado, después de Jugar una Carta, Refrescar e imprimir el Nivel de carga de la llave de plata de cada Despertado."
  },
  State_146383_Name = {
    Text = "Entrada de Eficiencia"
  },
  State_146384_Desc = {
    Text = "Valor P1 [StateArg1], Valor P2 [StateArg2], Valor P3 [StateArg3], Valor P4 [StateArg4]."
  },
  State_146384_Name = {
    Text = "Valor de Eficiencia"
  },
  State_146385_Desc = {
    Text = "Después de añadir un Estado, después de Jugar una Carta, Refrescar e imprimir el Nivel de carga de la llave de plata de cada Despertado."
  },
  State_146385_Name = {
    Text = "Entrada de Nivel"
  },
  State_146386_Desc = {
    Text = "Valor P1 [StateArg1], Valor P2 [StateArg2], Valor P3 [StateArg3], Valor P4 [StateArg4]."
  },
  State_146386_Name = {
    Text = "Valor de Nivel"
  },
  State_146446_Desc = {
    Text = "DEF del Cuerpo Despertado, P1: [StateArg1], P2: [StateArg2], P3: [StateArg3], P4: [StateArg4]."
  },
  State_146446_Name = {
    Text = "Lista de atributos de Defensa"
  },
  State_146448_Desc = {
    Text = "ATQ del Cuerpo Despertado, P1: Fuerza[StateArg1] Intensidad[StateArg2], P2: Fuerza[StateArg3] Intensidad[StateArg4], P3: Fuerza[StateArg5] Intensidad[StateArg6], P4: Fuerza[StateArg7] Intensidad[StateArg8]."
  },
  State_146448_Name = {
    Text = "Lista de atributos de Ataque"
  },
  State_146452_Desc = {
    Text = "Equipo Único: El Daño Crítico del \"golpear\" del Portador aumenta un <WeaponEffect_Num:[StateArg1]%>. Al final del turno, el Daño Crítico del próximo Exaltar del Portador aumenta en un porcentaje igual al <WeaponEffect_Num:[StateArg2]%> de su Alienación básica, acumulable hasta 5 veces."
  },
  State_146452_WeaponDesc = {
    Text = "El Daño Crítico de \"golpear\" del Portador aumenta un <WeaponEffect_Num:[StateArg1]%>. Al final del turno, el Daño Crítico del próximo Exaltar del Portador aumenta un <WeaponEffect_Num:[DescArg1]%>, acumulable hasta 5 veces (actualmente disfruta de [DescArg2]%)."
  },
  State_146456_Desc = {
    Text = "Equipo Único: El Daño Crítico del \"golpear\" del Portador aumenta un <WeaponEffect_Num:[StateArg1]%>."
  },
  State_146456_WeaponDesc = {
    Text = "El Daño Crítico de \"golpear\" del Portador aumenta un <WeaponEffect_Num:[StateArg1]%>."
  },
  State_146534_Desc = {
    Text = "Después de que comience el Nivel, añadir al Guardián los contenedores de cada mecanismo del Caos Primordial."
  },
  State_146534_Name = {
    Text = "Inicialización del Caos Primordial"
  },
  State_146535_Desc = {
    Text = "Contenedor de atributos."
  },
  State_146535_Name = {
    Text = "Identificador del Caos Primordial"
  },
  State_146536_Desc = {
    Text = "Contenedor de mecanismos."
  },
  State_146536_Name = {
    Text = "Mecanismo del Caos Primordial"
  },
  State_146644_Desc = {
    Text = "Activar obtiene Preparar 1, la primera vez que se Juega en cada turno se Libera automáticamente la Posse que lleva."
  },
  State_146644_Name = {
    Text = "Eco Primordial"
  },
  State_146645_Desc = {
    Text = "El nuevo Reino del Caos libera automáticamente la Posse al Activar Gnosis por primera vez en cada turno. Actualmente disponible."
  },
  State_146645_Name = {
    Text = "Identificador Disponible"
  },
  State_146646_Desc = {
    Text = "El límite máximo de Llave Plateada base cambia a 2000. La regla para obtener Llave Plateada se reemplaza por: la primera vez que el Cuerpo Despertado juegue una Tarjeta de comando en cada turno, obtiene Llave Plateada igual a 3 veces la Regeneración de Llave Plateada + 100."
  },
  State_146646_Name = {
    Text = "Nueva regla de Keyflare del Caos"
  },
  State_146651_Desc = {
    Text = "Aumenta el atributo ATQ de este Cuerpo Despertado en [Layer]%."
  },
  State_146651_Name = {
    Text = "Caos · Ataque"
  },
  State_146652_Desc = {
    Text = "Solo una vez al comenzar el combate, cambia la eficiencia de Regeneración de Llave Plateada de cada Cuerpo Despertado al valor promedio del Nivel de carga de la llave de plata."
  },
  State_146652_Name = {
    Text = "Equilibrio Primordial"
  },
  State_146653_Desc = {
    Text = "Aumenta el atributo DEF de este Cuerpo Despertado en [Layer]%."
  },
  State_146653_Name = {
    Text = "Caos · Defensa"
  },
  State_146663_Desc = {
    Text = "El \"golpear\" de las próximas [Layer] cartas de Lotan: Cetarconte tiene efecto 1 vez adicional."
  },
  State_146663_Name = {
    Text = "Tormenta Devoradora de Cetus"
  },
  State_147058_Name = {
    Text = "Anillo de la sala 36 de accesorios"
  },
  State_147079_Desc = {
    Text = "Esta carta no puede ser descartada ni transformada."
  },
  State_147079_Name = {
    Text = "<RetainIconKeywordsColour:Retener Forzado>"
  },
  State_147545_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: No configurado"
  },
  State_147545_Name = {
    Text = "Tinct: Vespera SR (Texto Temporal)"
  },
  State_147546_Name = {Text = "abandonado"},
  State_147546_WeaponDesc = {
    Text = "Voces del más allá"
  },
  State_147584_Desc = {
    Text = "El efecto de <Blessing:Gracia> de la siguiente <DerivativeCardKeywords_152:\"Gracia de Hada\"> jugada aumenta un 50%"
  },
  State_147737_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equipar, obtiene [StateArg1] de <MaxHPKeywords:PV Max>. Al inicio del turno, inflige <Damage:[Damage:StateArg2]> de daño de <PVPBleedingKeywords:Sangrar> a todos los enemigos,"
  },
  State_147737_Name = {
    Text = "De la oscuridad a la oscuridad"
  },
  State_147764_Name = {
    Text = "Estado@Conteo de selección incorrecta en actividad de Caraboo"
  },
  State_147765_Desc = {
    Text = "Al inicio del siguiente turno, pierde 2 puntos de Aritmética y roba 2 cartas menos."
  },
  State_147765_Name = {
    Text = "Pistolas de Marie"
  },
  State_147768_Desc = {
    Text = "Al inicio del siguiente turno, obtén [DescArg1] Adv. Insight."
  },
  State_147768_Name = {
    Text = "Monedas de Pistoles de Marie"
  },
  State_147769_Desc = {
    Text = "\"Festín\" ha acumulado actualmente [Layer] capas en esta batalla."
  },
  State_147769_Name = {
    Text = "Límite de Acumulación"
  },
  State_147772_Name = {
    Text = "Estado@Actividad de Caraboo añade límite temporal de Keyflare"
  },
  State_147773_Name = {
    Text = "Estado@Actividad de Caraboo añade límite temporal de Keyflare"
  },
  State_147774_Name = {
    Text = "Estado@Actividad de Caraboo añade límite temporal de Keyflare_Caos normal"
  },
  State_147797_Desc = {
    Text = "Puede ganar o perder Alienación, <PowerIconKeywords:fuerza>, PV, Llave Plateada y Aritmética y Robar."
  },
  State_147797_Name = {
    Text = "Pistolas de Marie"
  },
  State_147800_Desc = {
    Text = "Al inicio del siguiente turno, pierde 2 puntos de Aritmética y roba 2 cartas menos."
  },
  State_147800_Name = {
    Text = "Pistolas de Marie"
  },
  State_147869_Name = {
    Text = "Robar [Layer] cartas"
  },
  State_147870_Name = {
    Text = "Inflige [Layer] turnos de debilidad a todos los enemigos"
  },
  State_147871_Name = {
    Text = "Obtén [Energy:DescArg1] puntos de locura"
  },
  State_147872_Name = {
    Text = "Causa <Layer> turnos de vulnerabilidad a todos los enemigos"
  },
  State_147873_Name = {
    Text = "Obtén [Layer] puntos de aritmética"
  },
  State_147874_Name = {
    Text = "Obtén [Block:DescArg1] escudo"
  },
  State_147962_Desc = {
    Text = "Cuando el jugador juega \"<DerivativeCardKeywords_158:Expiación>\", solo disipa el 50% de las Acumulaciones de <MonsterSinMarkKeywords:Sello del pecado>, y por cada Tarjeta de comando jugada, \"Hijo Santo · Noche Blanca\" gana 1 Acumulación de <MonsterSinMarkKeywords:Sello del pecado>."
  },
  State_147962_Name = {
    Text = "Camino de la Pureza"
  },
  State_147967_Desc = {
    Text = "El daño infligido por \"Divus: La Noche Blanca\" aplica [DescArg1]% de <BleedingIconKeywords:Sangrar>."
  },
  State_147967_Name = {
    Text = "Sello del pecado"
  },
  State_147968_Desc = {
    Text = "Límite de 3 capas. Al cambiar a intención de ataque, aumenta el daño infligido por \"Divus: La Noche Blanca\" en un 25% y consume 1 capa."
  },
  State_147968_Name = {
    Text = "Redención de Agonía"
  },
  State_147969_Desc = {
    Text = "Cuando \"Divus: La Noche Blanca\" está en intención de \"Sagrado Corazón\", por cada Tarjeta de comando jugada acumula 2 capas de <MonsterPolluxFever:Fervor>."
  },
  State_147969_Name = {
    Text = "Nuevo Pacto Divino"
  },
  State_147971_Desc = {
    Text = "Este Despertado aún no ha Despertado... Cuando esté a punto de ser derrotado, se restaurará su PV y ganará 1 Acumulación de <InvincibleUntilRoused:Blindaje Impenetrable>. Tras Despertar, se elimina el <InvincibleUntilRoused:Blindaje Impenetrable> y comienza la batalla en su verdadera forma."
  },
  State_147971_Name = {
    Text = "No Activado"
  },
  State_147972_Desc = {
    Text = "Cada capa hace que el daño infligido por \"Divus: La Noche Blanca\" aplique 1% de <BleedingIconKeywords:Sangrar>."
  },
  State_147972_Name = {
    Text = "<MonsterSinMarkKeywords:Sello del pecado>"
  },
  State_147974_Desc = {
    Text = "Se elimina al inicio del turno. Al alcanzar 10 capas, tras jugar la siguiente carta actúa de inmediato, elimina el Fervor y cambia la intención a \"Sagrado Corazón\"."
  },
  State_147974_Name = {
    Text = "Fervor temporal"
  },
  State_147975_Desc = {
    Text = "Al inicio del combate, coloca una carta de \"<DerivativeCardKeywords_158:Expiación>\" en la Mano. Al final del turno, obtén 5 capas de <MonsterSinMarkKeywords:Sello del pecado>."
  },
  State_147975_Name = {
    Text = "Mensajero del Portador de la Lámpara"
  },
  State_147993_Desc = {
    Text = "Límite de 3 capas. Al cambiar a intención de ataque, aumenta el daño infligido por \"Divus: La Noche Blanca\" en un 25% y consume 1 capa."
  },
  State_147993_Name = {
    Text = "Redención de Agonía"
  },
  State_148020_Desc = {
    Text = "Inmunidad a todo daño y no puede perder PV; se elimina al Despertar."
  },
  State_148020_Name = {
    Text = "Solidificación del Núcleo de Plata"
  },
  State_148021_Name = {
    Text = "Estado@Identificador de eliminación de Inmunidad antes del Renacimiento y Despertar genérico de monstruo"
  },
  State_148073_Name = {
    Text = "Roba 1 carta"
  },
  State_148074_Desc = {
    Text = "Las cartas no entran en la pila de descarte durante la fase de descarte, sino que se mantienen en la mano"
  },
  State_148074_Name = {
    Text = "<RetainIconKeywords:Retener>"
  },
  State_148074_WeaponDesc = {
    Text = "Las cartas no entran en la pila de descarte durante la fase de descarte, sino que se mantienen en la mano"
  },
  State_148076_Name = {
    Text = "Escucha de juego de cartas del Camino de la Pureza"
  },
  State_148116_Desc = {
    Text = "Después de 1 turno, roba [StateArg1] carta(s) [Layer] veces."
  },
  State_148116_Name = {
    Text = "Tirada retrasada 1"
  },
  State_148381_Desc = {
    Text = "Hasta el final del turno, el daño propio infligido aplica un 100% adicional de <BleedingIconKeywords:Sangrar>."
  },
  State_148381_Name = {
    Text = "Rancor encadenado"
  },
  State_148383_Desc = {
    Text = "Máximo 3 Acumulaciones. Si se tienen 3 Acumulaciones de \"Matanza sin fin\", la próxima vez que la Intención cambie a \"Grilletes carmesí\", cambia la Intención a \"Mayal sediento de sangre\" y elimina \"Matanza sin fin\" en su lugar."
  },
  State_148383_Name = {
    Text = "\"Resentimiento\""
  },
  State_148385_Desc = {
    Text = "Cada vez que el enemigo juegue una Tarjeta de comando, obtén 2 capas de <MonsterB05EXFever:Fervor temporal>."
  },
  State_148385_Name = {
    Text = "Forma irregular"
  },
  State_148386_Desc = {
    Text = "No se puede obtener Blindaje hasta el final del turno."
  },
  State_148386_Name = {
    Text = "Grilletes sanguíneos"
  },
  State_148387_Desc = {
    Text = "Este Despertado aún no ha Despertado... Cuando esté a punto de ser derrotado, se restaurará su PV y ganará 1 Acumulación de <InvincibleUntilRoused:Blindaje Impenetrable>. Tras Despertar, se elimina el <InvincibleUntilRoused:Blindaje Impenetrable> y comienza la batalla en su verdadera forma."
  },
  State_148387_Name = {
    Text = "No Activado"
  },
  State_148391_Desc = {
    Text = "Hasta el final del turno, el daño propio infligido aplica un 100% adicional de <BleedingIconKeywords:Sangrar>."
  },
  State_148391_Name = {
    Text = "Grilletes sanguíneos"
  },
  State_148392_Desc = {
    Text = "Se elimina al inicio del turno. Al alcanzar 10 capas, tras jugar la siguiente carta actúa de inmediato, elimina el Fervor y cambia la intención a \"Grilletes carmesí\"."
  },
  State_148392_Name = {
    Text = "Fervor temporal"
  },
  State_148394_Desc = {
    Text = "Al inicio del turno, obtiene 1 acumulación de <ResentChainsKeywords:Cadena de Rancor>. Cuando la intención cambia a \"Mayal sediento de sangre\", obtiene inmunidad a todo daño y pérdida de PV hasta el final del turno enemigo."
  },
  State_148394_Name = {
    Text = "Declaración del Segador"
  },
  State_148395_Desc = {
    Text = "Inmunidad a todo daño (incluido el Daño Penetrante) e incapaz de perder PV. Se elimina al final del turno enemigo."
  },
  State_148395_Name = {
    Text = "Declaración del Segador – Mayal sediento de sangre"
  },
  State_148421_Desc = {
    Text = "Después de 1 turno, reduce temporalmente [StateArg1] puntos de <ExhaustionIconKeywords:Fuerza> a todos los enemigos [Layer] veces"
  },
  State_148421_Name = {
    Text = "Latencia de Absorber 1"
  },
  State_148422_Desc = {
    Text = "Después de 1 turno, Amplificación de Daño temporal [StateArg1]% [Layer] veces."
  },
  State_148422_Name = {
    Text = "Amplificación de Daño Temporal Retardada 1"
  },
  State_148423_Desc = {
    Text = "Obtén <Posse:[StateArg1]> puntos de Llave Plateada después de 1 turno, [Layer] veces."
  },
  State_148423_Name = {
    Text = "Latencia de Llave Plateada 1"
  },
  State_148426_Desc = {
    Text = "Obtén [StateArg1] puntos de Aritmética después de 1 turno, [Layer] veces."
  },
  State_148426_Name = {
    Text = "Latencia Aritmética 1"
  },
  State_148427_Desc = {
    Text = "Después de 1 turno, todos los Despertados obtienen [StateArg1] puntos de Alienación [Layer] veces."
  },
  State_148427_Name = {
    Text = "Locura retardada 1"
  },
  State_148428_Desc = {
    Text = "Obtén [StateArg1] puntos de <PowerIconKeywords:Fuerza> después de 1 turno, [Layer] veces."
  },
  State_148428_Name = {
    Text = "Latencia de Fuerza 1"
  },
  State_148511_Desc = {
    Text = "Equipo Único: Tras iniciar la exploración, añade 1 carta <Backupbody[StateArg3]:\"Sincronización de Almas\"> al mazo. \"Sincronización de Almas\": Coste de Aritmética 0, al Jugar obtiene 1 punto de Aritmética. <RetainIconKeywords:Retener>: Acumula en esta carta una cantidad fija de recuperación de PV igual al <WeaponEffect_Num:[StateArg1]%> del CON del Portador y <WeaponEffect_Num:[StateArg2]> puntos fijos de Alienación. Si esta carta no es Destruida, puede otorgar Inmunidad a una muerte y liberar toda la recuperación de PV y Alienación acumuladas; después <DestructionKeywords:Destruye> esta carta."
  },
  State_148511_Name = {
    Text = "Sincronización de Almas"
  },
  State_148511_WeaponDesc = {
    Text = "Tras iniciar la exploración, añade 1 carta <Backupbody[StateArg3]:\"Sincronización de Almas\"> al mazo. \"Sincronización de Almas\": Coste de Aritmética 0, al Jugar obtiene 1 punto de Aritmética. <RetainIconKeywords:Retener>: Acumula en esta carta una cantidad fija de recuperación de PV igual al <WeaponEffect_Num:[StateArg1]%> del CON del Portador y <WeaponEffect_Num:[StateArg2]> puntos fijos de Alienación. Si esta carta no es Destruida, puede otorgar Inmunidad a una muerte y liberar toda la recuperación de PV y Alienación acumuladas; después <DestructionKeywords:Destruye> esta carta."
  },
  State_148513_Desc = {
    Text = "El oponente no descartará su mano al final de su turno. Al final del turno, aplica en orden 2 capas de <FragileIconKeywords:frágil>, <WeaknessIconKeywords:debilidad>, <HeavyInjuryKeywords:plaga> y <VulnerabilityIconKeywords:vulnerable>."
  },
  State_148513_Name = {
    Text = "Voces del más allá"
  },
  State_148520_Desc = {
    Text = "No se puede obtener Blindaje hasta el final del turno."
  },
  State_148520_Name = {
    Text = "Rancor encadenado"
  },
  State_148522_Desc = {
    Text = "Equipo Único: El Blindaje y la fuerza causados por el \"Exaltar\" del Portador aumentan un <WeaponEffect_Num:[StateArg1]%>."
  },
  State_148524_Desc = {
    Text = "Equipo Único: El Blindaje y la fuerza causados por el \"Exaltar\" del Portador aumentan un <WeaponEffect_Num:[StateArg1]%>. El Aumento de Escudo causado por la \"Defensa\" del Portador aumenta un <WeaponEffect_Num:[StateArg2]%>. Tras Jugar \"Defensa\", el Portador obtiene fuerza equivalente al <WeaponEffect_Num:[StateArg3]%> de su ATQ."
  },
  State_148540_Desc = {
    Text = "Latencia[Layer]: El Coste de Aritmética de las [StateArg1] Tarjetas de comando con mayor Aritmética de <AwakerName:[DescArg1]> se reduce en [StateArg2]."
  },
  State_148540_Name = {
    Text = "Espejo de Presciencia – Latencia[Layer]"
  },
  State_148541_Name = {
    Text = "Elimina el efecto \"Estancamiento\" de la carta en mano del Despertado seleccionado"
  },
  State_148544_Desc = {
    Text = "Latencia[Layer] : La próxima vez que <AwakerName:[DescArg1]> Exalte, obtiene [StateArg1] puntos de Llave Plateada por cada punto de Alienación consumido."
  },
  State_148544_Name = {
    Text = "Llave de Goecia - Latencia[Layer]"
  },
  State_148547_Desc = {
    Text = "La próxima Exaltación de <AwakerName:[DescArg1]> se considera Sobreexaltación; si ya es una Sobreexaltación, devuelve el 100% de la Alienación básica."
  },
  State_148547_Name = {
    Text = "Corona de la Eternidad"
  },
  State_148548_Desc = {
    Text = "Retener: Todos los Despertados ganan 5 de Alienación."
  },
  State_148548_Name = {
    Text = "Absorto en la Reflexión"
  },
  State_148549_Name = {
    Text = "Activa todos los efectos \"Preparar\" de la mano"
  },
  State_148553_Desc = {
    Text = "Latencia[Layer]: Las siguientes [Layer] Tarjetas de comando jugadas por <AwakerName:[DescArg1]> obtienen Blindaje equivalente al [StateArg2]% de los PV perdidos."
  },
  State_148553_Name = {
    Text = "Fruto de la Tentación – Latencia[Layer]"
  },
  State_148554_Desc = {
    Text = "El daño causado por las Tarjetas de comando de <AwakerName:[DescArg1]> aplica [Layer]% de Sangrar."
  },
  State_148554_Name = {
    Text = "Ojo de la Ruina"
  },
  State_148556_Desc = {
    Text = "Mientras esté en mano, todos los Despertados infligen un 10% adicional de Sangrar al causar Daño Activo."
  },
  State_148556_Name = {
    Text = "Una Pesadilla Presagiada"
  },
  State_148557_Desc = {
    Text = "Las siguientes [Layer] Tarjetas de comando jugadas por <AwakerName:[DescArg1]> obtienen Blindaje equivalente al [StateArg1]% de los PV perdidos."
  },
  State_148557_Name = {
    Text = "Fruto de la Tentación"
  },
  State_148559_Desc = {
    Text = "La próxima vez que <AwakerName:[DescArg1]> Exalte, obtiene [Layer] puntos de Llave Plateada por cada punto de Alienación consumido."
  },
  State_148559_Name = {
    Text = "Llave de Goecia"
  },
  State_148561_Desc = {
    Text = "Al jugar esta carta, se activa aleatoriamente uno de los siguientes tres efectos negativos: Efecto reducido en un 50%/Latencia de 2 turnos para entrar en vigor/Obtener aleatoriamente 1 efecto negativo."
  },
  State_148561_Name = {
    Text = "<ExclamationPointColour:Deseo Retorcido>"
  },
  State_148562_Name = {
    Text = "El Despertado seleccionado obtiene 10 puntos de Alienación"
  },
  State_148563_Desc = {
    Text = "Latencia[Layer]: El Blindaje y la Curación de PV obtenidos en el próximo Exaltar de <AwakerName:[DescArg1]> aumentan un [StateArg1]%."
  },
  State_148563_Name = {
    Text = "Pluma de la Justicia – Latencia[Layer]"
  },
  State_148566_Desc = {
    Text = "El daño causado por la próxima Exaltación de <AwakerName:[DescArg1]> aplica [Layer]% de Veredicto Final."
  },
  State_148566_Name = {
    Text = "Hilo del Destino"
  },
  State_148569_Desc = {
    Text = "El Blindaje y la Curación de PV obtenidos en el próximo Exaltar de <AwakerName:[DescArg1]> aumentan un [Layer]%."
  },
  State_148569_Name = {
    Text = "Pluma de la Justicia"
  },
  State_148571_Desc = {
    Text = "Latencia[Layer] : El daño causado por las Tarjetas de comando de <AwakerName:[DescArg1]> aplica [StateArg1]% de Sangrar."
  },
  State_148571_Name = {
    Text = "Ojo de la Ruina - Latencia[Layer]"
  },
  State_148574_Desc = {
    Text = "Latencia[Layer] : El daño causado por la próxima Exaltación de <AwakerName:[DescArg1]> aplica [StateArg1]% de Veredicto Final."
  },
  State_148574_Name = {
    Text = "Hilo del Destino - Latencia[Layer]"
  },
  State_148575_Name = {
    Text = "El Despertado seleccionado obtiene 20 puntos de Alienación"
  },
  State_149089_Name = {
    Text = "Estado@Identificador de Alienación de pequeño devorador Sabueso de Linterna"
  },
  State_149092_Desc = {
    Text = "Ha devorado <Energy:[Energy:DescArg2]> puntos de Alienación de \"<AwakerName:[DescArg1]>\". Se devuelven al morir."
  },
  State_149092_Name = {Text = "Devorar"},
  State_149094_Desc = {
    Text = "Equipo Único: El Escudo Base generado por el Exaltar del Portador +<WeaponEffect_Num:[StateArg1]%>. Después de que el Portador juegue una Tarjeta de comando que inflige <WeaknessIconKeywords:Síntoma: Debilidad>, el Escudo Base generado por la siguiente Tarjeta de comando de equipo +<WeaponEffect_Num:[StateArg1]%>. No se puede acumular. Al usar \"Horno Carmesí\", roba la tarjeta de habilidad del Portador con el mayor Coste de Aritmética, <EmbryoFusionIconKeywords:Fusión Embrionaria> +<WeaponEffect_Num:[StateArg1]%>, tiempo de reutilización de 3 turnos."
  },
  State_149094_WeaponDesc = {
    Text = "El Escudo Base de Exaltar del Portador +<WeaponEffect_Num:[StateArg1]%>. Después de que el Portador juegue una Tarjeta de comando que inflige <WeaknessIconKeywords:Síntoma: Debilidad>, el Escudo Base de su Tarjeta de comando +<WeaponEffect_Num:[StateArg1]%>. Al usar \"Horno Carmesí\", Roba la Tarjeta de habilidad del Portador con el mayor Coste de Aritmética, <EmbryoFusionIconKeywords:Fusión Embrionaria> +<WeaponEffect_Num: [StateArg1]>, tiempo de reutilización de 3 turnos."
  },
  State_149122_Desc = {
    Text = "Al morir, invoca inmediatamente 1 \"Sabueso de Linterna\" aleatorio con su \"Efecto de enjambre\" reducido en 1 Acumulación."
  },
  State_149122_Name = {
    Text = "Efecto de enjambre"
  },
  State_149123_Desc = {
    Text = "El daño recibido por Exaltar se reduce un 50%."
  },
  State_149123_Name = {
    Text = "Mod. de Linterna Umbral"
  },
  State_149124_Desc = {
    Text = "El daño recibido de las Tarjetas de comando se reduce un 50%."
  },
  State_149124_Name = {
    Text = "Mod. de Linterna Glacial"
  },
  State_149125_Desc = {
    Text = "Ha congelado la Tarjeta de comando de \"<AwakerName:[DescArg1]>\". Al morir, elimina el Congelado de ese Despertado."
  },
  State_149125_Name = {Text = "Devorar"},
  State_149126_Desc = {
    Text = "Al morir, invoca inmediatamente 1 \"Sabueso de Linterna\" aleatorio con su \"Efecto de enjambre\" reducido en 1 Acumulación."
  },
  State_149126_Name = {
    Text = "Efecto de enjambre"
  },
  State_149128_Name = {
    Text = "Estado@Identificador de Tarjeta de comando congelada de pequeño Sabueso de Linterna de hielo y nieve"
  },
  State_149140_Desc = {
    Text = "Amplificará las habilidades del enemigo. Se pierde una capa cada vez que se recibe daño"
  },
  State_149140_Name = {
    Text = "Juramento de Sangre"
  },
  State_149143_Desc = {
    Text = "Al finalizar la fase de robo, por cada [DescArg1] Tarjeta<SlowIconKeywords:s> de comando con <SlowIconKeywords:Estancamiento> en la mano enemiga, obtiene [DescArg2] acumulaciones de <BloodOath_New:Juramento de Sangre>. Tras infligir daño no bloqueado, aplica [DescArg4] acumulaciones de <SlowIconKeywords:Estancamiento> a [DescArg3] Tarjetas de comando sin <SlowIconKeywords:Estancamiento> de la Mano o del Mazo de robo de forma aleatoria."
  },
  State_149143_Name = {
    Text = "Voto Helado"
  },
  State_149162_Desc = {
    Text = "Al infligir daño no bloqueado, elimina la Resistencia a la muerte."
  },
  State_149162_Name = {
    Text = "Hechicería del Lejano Oriente"
  },
  State_149163_Desc = {
    Text = "Reduce el PV Max en una cantidad igual a las acumulaciones. Se reduce a la mitad al finalizar el combate."
  },
  State_149163_Name = {
    Text = "<BoneHitKeywords:Scathe>"
  },
  State_149164_Desc = {
    Text = "Al infligir daño, aplica Scathe."
  },
  State_149164_Name = {
    Text = "Frío Penetrante"
  },
  State_149167_Desc = {
    Text = "PV Max reducido en [Layer], se reduce a la mitad al finalizar el combate."
  },
  State_149167_Name = {
    Text = "<BoneHitKeywords:Scathe>"
  },
  State_149169_Desc = {
    Text = "Cada acumulación aumenta el PV Max en un 10% del CON de Caraboo (máx. 50 acumulaciones). Al alcanzar el máximo de acumulaciones, las acumulaciones excedentes curan en su lugar por 3× este valor de PV. Se pueden ganar hasta 10 acumulaciones de \"Saciedad\" por batalla que no sea contra un Jefe. La \"Saciedad\" persiste entre batallas."
  },
  State_149169_Name = {
    Text = "<WormGrowth:Festín>"
  },
  State_149172_Desc = {
    Text = "Equipo Único: Después de que el Portador juega una Tarjeta de comando que inflige <WeaknessIconKeywords:Síntoma: Debilidad>, el Escudo Base generado por la siguiente Tarjeta de comando de equipamiento +<WeaponEffect_Num:[StateArg1]%>. No se puede acumular."
  },
  State_149172_WeaponDesc = {
    Text = "Después de que el Portador juega una Tarjeta de comando que inflige <WeaknessIconKeywords:Síntoma: Debilidad>, el Escudo Base de su siguiente Tarjeta de comando +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_149187_Desc = {
    Text = "Prueba | Escucha cuando se recibe Daño Fijo y cuando el Daño Fijo causa una muerte, e imprime el valor de activación y el asociado."
  },
  State_149187_Name = {
    Text = "Prueba de Daño Fijo"
  },
  State_149188_Desc = {
    Text = "Prueba｜Tras causar Matar con Daño Fijo, activa valor 1, daño real al Matar:[Layer]"
  },
  State_149188_Name = {
    Text = "Prueba valor de activación de muerte por daño fijo 2"
  },
  State_149189_Desc = {
    Text = "Prueba | Al causar una muerte por Daño Fijo, asociado 2, fuente que causó la muerte: [Layer]"
  },
  State_149189_Name = {
    Text = "Prueba asociado de muerte por daño fijo 2"
  },
  State_149190_Desc = {
    Text = "Prueba｜Tras causar Matar con Daño Fijo, activa valor 1, daño de desbordamiento al Matar:[Layer]"
  },
  State_149190_Name = {
    Text = "Prueba activación de valor 3 al Matar con Daño Fijo"
  },
  State_149191_Desc = {
    Text = "Prueba | Al recibir Daño Fijo, valor de activación 1, daño total: [Layer]"
  },
  State_149191_Name = {
    Text = "Prueba valor de activación de daño fijo 1"
  },
  State_149192_Desc = {
    Text = "Prueba | Al causar una muerte por Daño Fijo, asociado 1, objetivo eliminado: [Layer]"
  },
  State_149192_Name = {
    Text = "Prueba asociado de muerte por daño fijo 1"
  },
  State_149193_Desc = {
    Text = "Prueba | Al recibir Daño Fijo, asociado 2, objetivo golpeado: [Layer]"
  },
  State_149193_Name = {
    Text = "Prueba asociado de daño fijo 2"
  },
  State_149194_Desc = {
    Text = "Prueba | Al recibir Daño Fijo, valor de activación 1, daño total: [Layer]"
  },
  State_149194_Name = {
    Text = "Prueba valor de activación de daño fijo 2"
  },
  State_149195_Desc = {
    Text = "Prueba | Al causar una muerte por Daño Fijo, valor de activación 1, daño total de la muerte: [Layer]"
  },
  State_149195_Name = {
    Text = "Prueba valor de activación de muerte por daño fijo 1"
  },
  State_149196_Desc = {
    Text = "Prueba | Al recibir Daño Fijo, asociado 1, fuente del daño: [Layer]"
  },
  State_149196_Name = {
    Text = "Prueba asociado de daño fijo 1"
  },
  State_149227_Desc = {
    Text = "El Blindaje no desaparece al finalizar el turno. Mientras tenga Blindaje, el daño de Exaltar recibido aumenta un 50% y el daño de Tarjetas de comando recibido se reduce un 50%."
  },
  State_149227_Name = {
    Text = "Manto Glacial"
  },
  State_149228_Desc = {
    Text = "Al infligir daño, aplica Sangrar."
  },
  State_149228_Name = {
    Text = "Perforación Sanguínea"
  },
  State_149229_Desc = {
    Text = "Al entrar en combate, pierde el 25% de PV Max, convirtiéndolo en un \"Escudo de Escarcha\" equivalente al [DescArg1]% del valor perdido."
  },
  State_149229_Name = {
    Text = "Conversión de Escudo de Escarcha"
  },
  State_149230_Desc = {
    Text = "El daño de Tarjetas de comando recibido aumenta un 50% y el daño de Exaltar recibido se reduce un 50%."
  },
  State_149230_Name = {
    Text = "Estado@Aumento y reducción de daño del Manto Umbral"
  },
  State_149232_Desc = {
    Text = "El Blindaje no desaparece al finalizar el turno. Mientras tenga Blindaje, el daño de Tarjetas de comando recibido aumenta un 50% y el daño de Exaltar recibido se reduce un 50%."
  },
  State_149232_Name = {
    Text = "Manto Umbral"
  },
  State_149233_Desc = {
    Text = "El daño de Exaltar recibido aumenta un 50% y el daño de Tarjetas de comando recibido se reduce un 50%."
  },
  State_149233_Name = {
    Text = "Estado@Aumento y reducción de daño del Manto Glacial"
  },
  State_149234_Desc = {
    Text = "Al entrar en combate, pierde el 25% de PV Max, convirtiéndolo en una \"Guardia Maldita\" equivalente al [DescArg1]% del valor perdido."
  },
  State_149234_Name = {
    Text = "Conversión de Guardia Maldita"
  },
  State_149235_Desc = {
    Text = "Al infligir daño no bloqueado, elimina la Resistencia a la muerte."
  },
  State_149235_Name = {
    Text = "Hechicería de Linterna"
  },
  State_149250_Desc = {
    Text = "Daño de Tarjeta de comando recibido +50%"
  },
  State_149250_Name = {
    Text = "Daño de Tarjeta de comando recibido +50%"
  },
  State_149251_Desc = {
    Text = "Daño de Tarjeta de comando recibido -50%"
  },
  State_149251_Name = {
    Text = "Daño de Tarjeta de comando recibido -50%"
  },
  State_149252_Desc = {
    Text = "Daño de Exaltación recibido -50%"
  },
  State_149252_Name = {
    Text = "Daño de Exaltación recibido -50%"
  },
  State_149253_Desc = {
    Text = "Daño de Exaltación recibido +50%"
  },
  State_149253_Name = {
    Text = "Daño de Exaltación recibido +50%"
  },
  State_149265_Desc = {
    Text = "Tras morir, convoca inmediatamente a un \"Wendigo\" aleatorio y reduce su \"Efecto de enjambre\" en 1 capa."
  },
  State_149265_Name = {
    Text = "Efecto de enjambre"
  },
  State_149268_Desc = {
    Text = "Al perder todo el Blindaje, obtén 75 capas de Fortaleza Temporal y elimina 1 capa de \"Manto de Ventisca\", reemplaza la intención por un ataque poderoso que aplica <BoneHitKeywords:Scathe>."
  },
  State_149268_Name = {
    Text = "Manto de Ventisca"
  },
  State_149269_Desc = {
    Text = "Al perder todo el Blindaje, obtén 75 capas de Fortaleza Temporal y elimina 1 capa de \"Manto de Sombras\", reemplaza la intención por un ataque poderoso que arrebata Alienación."
  },
  State_149269_Name = {
    Text = "Manto de Sombras"
  },
  State_149270_Desc = {
    Text = "Tras morir, convoca inmediatamente a un \"Wendigo\" aleatorio y reduce su \"Efecto de enjambre\" en 1 capa."
  },
  State_149270_Name = {
    Text = "Efecto de enjambre"
  },
  State_149308_Name = {
    Text = "Estado@Registro de acumulaciones de Estancamiento del Orante de Linterna"
  },
  State_149391_Desc = {
    Text = "Este Despertado aún no ha Despertado... Cuando esté a punto de ser derrotado, se restaurará su PV y ganará 1 Acumulación de <InvincibleUntilRoused:Blindaje Impenetrable>. Tras Despertar, se elimina el <InvincibleUntilRoused:Blindaje Impenetrable> y comienza la batalla en su verdadera forma."
  },
  State_149391_Name = {
    Text = "No Activado"
  },
  State_149398_Desc = {
    Text = "Cuando la intención de \"Blancanieves el Hada\" cambia a \"Hechizo Nevado\", consume 1 capa y transforma la intención en \"Bendición Milagrosa\"."
  },
  State_149398_Name = {Text = "Festín"},
  State_149399_Desc = {
    Text = "Tras que \"Blancanieves el Hada\" use \"Cuento de Hadas Perfecto\", las siguientes [DescArg1] intenciones serán \"Hechizo Nevado\". Cada turno, baraja [DescArg2] cartas de <SlowIconKeywords:Estancamiento> aleatorias con [DescArg3] capas de <Blessing:Bendición> en el mazo."
  },
  State_149399_Name = {
    Text = "Fruta Melada Tentadora"
  },
  State_149418_Desc = {
    Text = "no puede ser Golpe crítico, no se considera Daño básico y no se ve afectado por bonificaciones como Daño Final."
  },
  State_149418_Name = {
    Text = "<RealDamage:Daño Fijo>"
  },
  State_149419_Name = {
    Text = "<Rune_6:Muralla>"
  },
  State_149420_Name = {
    Text = "<Rune_3:Destreza>"
  },
  State_149421_Name = {
    Text = "<Rune_15:Explosión>"
  },
  State_149422_Name = {
    Text = "<Rune_4:Estrategia>"
  },
  State_149423_Name = {
    Text = "<Rune_11:Dominio>"
  },
  State_149424_Name = {
    Text = "<Rune_12:Seducción>"
  },
  State_149425_Name = {
    Text = "<Rune_1: vulnerable>"
  },
  State_149426_Name = {
    Text = "<Rune_14:Fuerza bruta>"
  },
  State_149427_Name = {
    Text = "<Rune_2:Debilidad>"
  },
  State_149428_Name = {
    Text = "<Rune_9: punta>"
  },
  State_149429_Name = {
    Text = "<Rune_10:Toxina>"
  },
  State_149430_Name = {
    Text = "<Rune_18:Agotamiento>"
  },
  State_149576_Desc = {
    Text = "Cuando la intención de \"Blancanieves el Hada\" cambia a \"Hechizo Nevado\", consume 1 capa y transforma la intención en \"Bendición Milagrosa\"."
  },
  State_149576_Name = {Text = "Festín"},
  State_149618_Desc = {
    Text = "Después de 2 turnos, activa los siguientes efectos:\nObtén [DescArg1] puntos de Aritmética. \nObtén [DescArg2] puntos de Fuerza. \nObtén [DescArg3] puntos de Llave Plateada. \nObtén [DescArg5] puntos de Alienación. \nRoba [DescArg6] carta(s).\nObtén [DescArg7] puntos de Amplificación de Daño temporal.\nReduce temporalmente [DescArg4] puntos de Fuerza a todos los enemigos."
  },
  State_149618_Name = {
    Text = "Oportunidad Perdida 2"
  },
  State_149619_Desc = {
    Text = "Después de 1 turno, activa los siguientes efectos:\nObtén [DescArg1] puntos de Aritmética. \nObtén [DescArg2] puntos de Fuerza. \nObtén [DescArg3] puntos de Llave Plateada. \nObtén [DescArg5] puntos de Alienación. \nRoba [DescArg6] carta(s).\nObtén [DescArg7] puntos de Amplificación de Daño temporal.\nReduce temporalmente [DescArg4] puntos de Fuerza a todos los enemigos."
  },
  State_149619_Name = {
    Text = "Oportunidad Perdida 1"
  },
  State_149628_Desc = {
    Text = "Si antes de que termine el turno el enemigo tiene al menos 1000 puntos de Llave Plateada, Devorar 1000 de Llave Plateada."
  },
  State_149628_Name = {
    Text = "Sacrificio de Keyflare"
  },
  State_149629_Desc = {
    Text = "Si antes de que termine el turno el Despertado con mayor Alienación tiene al menos 100 puntos de Alienación, Devorar 50 puntos de Alienación."
  },
  State_149629_Name = {
    Text = "Sacrificio de Alienación"
  },
  State_149630_Desc = {
    Text = "Si antes de que termine el turno el enemigo tiene al menos 1000 puntos de Llave Plateada, Devorar 1000 de Llave Plateada."
  },
  State_149630_Name = {
    Text = "Sacrificio de Keyflare"
  },
  State_149631_Desc = {
    Text = "Si el enemigo posee al menos 3 puntos de Aritmética antes de que termine el turno, Devora 3 puntos de Aritmética."
  },
  State_149631_Name = {
    Text = "Sacrificio de Aritmética"
  },
  State_149632_Desc = {
    Text = "Si el enemigo posee al menos 3 puntos de Aritmética antes de que termine el turno, Devora 3 puntos de Aritmética."
  },
  State_149632_Name = {
    Text = "Sacrificio de Aritmética"
  },
  State_149633_Desc = {
    Text = "Si antes de la fase de descarte el enemigo tiene al menos 4 Tarjetas de comando en su Mano, Devorar 2 Tarjetas de comando aleatorias."
  },
  State_149633_Name = {
    Text = "Sacrificio de Cartas"
  },
  State_149634_Desc = {
    Text = "Si antes de la fase de descarte el enemigo tiene al menos 4 Tarjetas de comando en su Mano, Devorar 2 Tarjetas de comando aleatorias."
  },
  State_149634_Name = {
    Text = "Sacrificio de Cartas"
  },
  State_149635_Desc = {
    Text = "Si antes de que termine el turno el Despertado con mayor Alienación tiene al menos 100 puntos de Alienación, Devorar 50 puntos de Alienación."
  },
  State_149635_Name = {
    Text = "Sacrificio de Alienación"
  },
  State_149652_Desc = {
    Text = "No puede realizar Golpes críticos y no se considera como daño infligido por el Despertado correspondiente."
  },
  State_149652_Name = {
    Text = "<FixedDamage:DMG Puro>"
  },
  State_149660_Desc = {
    Text = "El daño, Blindaje y cambios de fuerza causados por esta Carta aumentan un [DescArg2]%, el Efecto final del Daño de tentáculos, recuperación de PV, Veneno fijo y Contrataque fijo aumentan un [DescArg1]%. Se elimina al Jugar."
  },
  State_149660_Name = {
    Text = "Refuerzo [DescArg1]"
  },
  State_149664_Desc = {
    Text = "Por cada capa, el daño causado por esta Carta, el Aumento de DAÑ de fuerza y tentáculos fijos, el Veneno fijo y el Efecto final del Contrataque fijo aumentan un 2%; el Efecto final del Blindaje fijo, la recuperación de PV fija y el STR▼ aumentan un 1%. Se elimina al Jugar."
  },
  State_149664_Name = {Text = "Refuerzo"},
  State_149719_Name = {
    Text = "Inmunidad a DMG Puro PVP__\"Solo para desarrollo\""
  },
  State_149736_Desc = {
    Text = "Las próximas [Layer] Tarjetas de comando de <AwakerName:[DescArg1]> tienen su Escudo Base aumentado en [StateArg1]%."
  },
  State_149736_Name = {
    Text = "Engaño emmelado"
  },
  State_149744_Desc = {
    Text = "La próxima Bendición jugada no activará el efecto negativo"
  },
  State_149744_Name = {
    Text = "Inmunidad a Debilitaciones"
  },
  State_149772_Desc = {
    Text = "Cada vez que se recibe Daño Activo, todos los Despertados pierden 3 de Alienación. Se activa como máximo 5 veces por turno. Elimina el Estado \"Guardia Maldita\" cuando el Escudo se rompe."
  },
  State_149772_Name = {
    Text = "Guardia Maldita"
  },
  State_149773_Desc = {
    Text = "Cada vez que se recibe Daño Activo, aplica 1 Acumulación de \"Estancamiento\" Temporal a 1 Carta aleatoria en mano. Se activa como máximo 5 veces por turno. Elimina el \"Escudo de Escarcha\" cuando el Escudo se rompe."
  },
  State_149773_Name = {
    Text = "Escudo de escarcha"
  },
  State_149782_Desc = {
    Text = "Agotar: Tras robar tarjetas en el siguiente turno, mezcla 1 \"Fruta Proteica\" en el Mazo de robo."
  },
  State_149782_Name = {
    Text = "Fruta Proteica"
  },
  State_149787_Desc = {
    Text = "Por cada capa, el Daño Final de las Tarjetas de comando de Ogier el Perjuro aumenta un [DescArg2]%, el número de cartas robadas al inicio del turno –1, el Daño Crítico aumenta un [DescArg3]%, límite de [DescArg1] capas, no se elimina al finalizar la batalla."
  },
  State_149787_Name = {
    Text = "<KuangNu:corrientes profundas>"
  },
  State_149788_Desc = {
    Text = "Al jugar la \"Habilidad\" de Rompe-Juramentos·Ogier, consume 1 Acumulación para Robar 1 tarjeta de \"Defensa\", que gana Retener antes del siguiente juego. Máximo [DescArg1] Acumulaciones. No se elimina al final de la batalla."
  },
  State_149788_Name = {
    Text = "<ShuZui:Autoculpa>"
  },
  State_149789_Desc = {
    Text = "Por cada capa, el Daño Final de las Tarjetas de comando de Ogier el Perjuro aumenta un 33%, el número de cartas robadas al inicio del turno –1, límite de [DescArg1] capas, no se elimina al finalizar la batalla."
  },
  State_149789_Name = {
    Text = "<KuangNu:corrientes profundas>"
  },
  State_149790_Desc = {
    Text = "Por cada capa, el Daño Final de las Tarjetas de comando de Ogier el Perjuro aumenta un [DescArg2]%, el número de cartas robadas al inicio del turno –1, límite de [DescArg1] capas, no se elimina al finalizar la batalla."
  },
  State_149790_Name = {
    Text = "<KuangNu:corrientes profundas>"
  },
  State_149791_Desc = {
    Text = "Al jugar la \"Habilidad\" de Rompe-Juramentos·Ogier, consume 1 Acumulación para Robar 1 tarjeta de \"Defensa\", que gana Retener antes del siguiente juego. Máximo [DescArg1] Acumulaciones. No se elimina al final de la batalla."
  },
  State_149791_Name = {
    Text = "<ShuZui:Autoculpa>"
  },
  State_149814_Desc = {
    Text = "Amplificación de Daño Temporal +[Layer]."
  },
  State_149814_Name = {
    Text = "Amplificación de Daño Temporal"
  },
  State_149819_Desc = {
    Text = "Inmunidad a todo daño"
  },
  State_149819_Name = {Text = "Inmunidad"},
  State_149892_Desc = {
    Text = "Las próximas [Layer] Tarjetas de comando de <AwakerName:[DescArg1]> tienen su Escudo Base aumentado en [StateArg1]%."
  },
  State_149892_Name = {
    Text = "Verdad dulce y apacible"
  },
  State_149913_Name = {
    Text = "Estado@Efecto de Tesoro del Gusano Macrófago_Tinct Dañado"
  },
  State_149914_Name = {
    Text = "Estado@Efecto del Tesoro del Gusano Macrófago_William Dañado"
  },
  State_149915_Name = {
    Text = "Estado@Efecto del Tesoro del Gusano Macrófago_William"
  },
  State_149916_Name = {
    Text = "Estado@Efecto del Tesoro del Gusano Macrófago_Castor Dañado"
  },
  State_149917_Name = {
    Text = "Estado@Efecto de Tesoro del Gusano Macrófago_Helot de Cadena de sangre Dañado"
  },
  State_149918_Name = {
    Text = "Estado@Prueba de Inicio de Turno del Gusano Macrófago"
  },
  State_149919_Name = {
    Text = "Estado@Efecto de Tesoro del Gusano Macrófago_Tinct"
  },
  State_149920_Name = {
    Text = "Estado@Efecto de Tesoro del Gusano Macrófago_Arachne"
  },
  State_149921_Name = {
    Text = "Estado@Efecto de Tesoro del Gusano Macrófago_Arachne Dañado"
  },
  State_149922_Name = {
    Text = "Estado@Efecto del Tesoro del Gusano Macrófago_Castor"
  },
  State_149923_Name = {
    Text = "Estado@Efecto de Tesoro del Gusano Macrófago_Helot de Cadena de sangre"
  },
  State_149930_Desc = {
    Text = "Por cada Acumulación, el Daño Final de las Tarjetas de comando de Rompe-Juramentos·Ogier aumenta en un 50%. Al inicio del turno, el número de Robos –1. Máximo [DescArg1] Acumulaciones. No se elimina al final de la batalla."
  },
  State_149930_Name = {
    Text = "<KuangNu2:corrientes profundas>"
  },
  State_149931_Desc = {
    Text = "Hay 7 tipos de efectos, entre ellos: ganar STR, acumular Responder del Horno Carmesí, todos los Despertados ganan Alienación, potenciación de Fusión Embrionaria, robar cartas, ganar Keyflare y potenciación temporal de Amplificación de Daño."
  },
  State_149931_Name = {
    Text = "<Blessing:Bendición>"
  },
  State_149933_Name = {
    Text = "Estado@Burbuja de Ofrenda del Monstruo Caraboo"
  },
  State_149934_Name = {
    Text = "Estado@Burbuja de Ofrenda del Monstruo Caraboo"
  },
  State_149939_Desc = {
    Text = "No se puede obtener Blindaje hasta el final del turno."
  },
  State_149939_Name = {
    Text = "Grilletes sanguíneos"
  },
  State_19507_Desc = {
    Text = "Antes del comienzo de la siguiente ronda, el daño de ataque activo y el número de capas de sangrado aumentan en un 25%, lo cual se anula al aplicarse con refuerzo."
  },
  State_19507_Name = {
    Text = "<PVPVulnerabilityIconColour:vulnerable>"
  },
  State_19508_Desc = {
    Text = "Al final del turno, descarta esta carta"
  },
  State_19508_Name = {
    Text = "<PVPVoidKeyColour:Oblivion>"
  },
  State_19509_Desc = {
    Text = "Cambiar temporalmente la carta Aritmética. __ \"Solo para uso en desarrollo\""
  },
  State_19509_Name = {
    Text = "Cambio permanente de la potencia de cálculo de las cartas"
  },
  State_19511_Desc = {
    Text = "Tras la muerte, sustituye las cartas de mano por cartas de ilusión"
  },
  State_19511_Name = {
    Text = "La muerte activa la sustitución de cartas de mano por Ilusión"
  },
  State_19513_Name = {
    Text = "Aplica combate a muerte __ \"Por desarrollo solamente\""
  },
  State_19516_Name = {
    Text = "Cambiar temporalmente la carta Aritmética __ \"Solo para uso en desarrollo\""
  },
  State_19517_Desc = {
    Text = "Por cada 2% de PV perdidos, obtén 1 punto de Aliemus"
  },
  State_19517_Name = {
    Text = "Recibir daño otorga Locura __ \"Para uso de desarrollo únicamente\""
  },
  State_19519_Desc = {
    Text = "Después de usar \"Golpe\", consume todas las capas; cada capa aumenta el daño causado por este \"Golpe\" en un 50%, apilándose hasta 5 capas. (Actualmente aumentado en [DescArg1]%)"
  },
  State_19519_Name = {Text = "Cargar"},
  State_19521_Desc = {
    Text = "Cada capa aumenta todo el daño infligido en esta batalla en 1 punto, no se puede dispelir."
  },
  State_19521_Name = {
    Text = "<PowerColourKeywords:Fuerza>"
  },
  State_19522_Name = {
    Text = "Cambiar temporalmente la carta Aritmética __ \"Solo para uso en desarrollo\""
  },
  State_19523_Name = {
    Text = "Cambio permanente de la potencia de cálculo de las cartas"
  },
  State_19524_Desc = {
    Text = "Antes del próximo turno, cada vez que seas atacado, inflige [Layer] de daño pasivo al atacante."
  },
  State_19524_Name = {
    Text = "Contrataque"
  },
  State_19525_Desc = {
    Text = "Retira el escudo del Despertador antes de que comience la ronda __ \"Solo para uso de desarrollo\""
  },
  State_19525_Name = {
    Text = "Retira el escudo del personaje antes de que comience la ronda __ \"Solo para uso de desarrollo\""
  },
  State_19527_Desc = {
    Text = "Cada acumulación aumenta el Coste de Aritmética de las \"habilidades\" en +1 este turno, hasta un máximo de 3 acumulaciones. Al jugarla, si las acumulaciones son mayores que 1, se reducen en 1."
  },
  State_19527_Name = {
    Text = "<SlowColour:Retraso>"
  },
  State_19528_Desc = {
    Text = "Posee cartas con efectos poderosos"
  },
  State_19528_Name = {
    Text = "<SilverKeyColour:Llave>"
  },
  State_19529_Desc = {
    Text = "Cada vez que juegas otra carta, reduce el Coste de Aritmética de esta carta en 1 para la siguiente jugada; después de jugar esta carta, devuélvela a tu mano y aumenta su Coste de Aritmética en 1, luego descártala al final del turno."
  },
  State_19529_Name = {
    Text = "<CardKeyWord:Fantasma>"
  },
  State_19530_Desc = {
    Text = "Los oponentes deben priorizar a esta unidad para ataques y habilidades de objetivo único.\nAl activarse: Propio: Elimina el sigilo actual. Aliados: Elimina su Pulla. Enemigos: Disipa todo el sigilo enemigo."
  },
  State_19530_Name = {
    Text = "<TauntColour:Provocación>"
  },
  State_19532_Desc = {
    Text = "El daño causado antes del final de esta ronda se reduce en [DescArg1] %, y se compensa con el fortalecimiento al aplicarse"
  },
  State_19532_Name = {Text = "Debilidad"},
  State_19533_Desc = {
    Text = "El daño causado antes del final de esta ronda se reduce en 50 %, y se compensa con el fortalecimiento al aplicarse"
  },
  State_19533_Name = {
    Text = "<WeaknessColour:Debilidad>"
  },
  State_19534_Desc = {
    Text = "Antes del comienzo de la siguiente ronda, el daño de ataque activo y el número de capas de sangrado aumentan en [DescArg1]%, lo cual se anula al aplicarse con refuerzo."
  },
  State_19534_Name = {Text = "Vulnerable"},
  State_19535_Desc = {
    Text = "Los oponentes deben priorizar a esta unidad para ataques y habilidades de objetivo único.\nAl activarse: Propio: Elimina el sigilo actual. Aliados: Elimina su Pulla. Enemigos: Disipa todo el sigilo enemigo."
  },
  State_19535_Name = {Text = "Pulla"},
  State_19536_Desc = {
    Text = "Gana 10 Locura al final de la ronda__ \"Uso solo para desarrollo\""
  },
  State_19536_Name = {
    Text = "Gana activación de locura al final de la ronda__ \"Uso solo para desarrollo\""
  },
  State_19537_Desc = {
    Text = "Daño aumentado en [DescArg1]% hasta el final del turno, se cancela con debilidad"
  },
  State_19537_Name = {Text = "Refuerzo"},
  State_19538_Desc = {
    Text = "·Al inicio del turno 8 y 9, obtén 1 capa\n·Cada capa de Duelo Mortal reduce la curación y el escudo en 50% y reduce las capas acumulables de barrera en 1\n·Duelo Mortal no se puede disipar y afecta a los Despertados muertos"
  },
  State_19538_Name = {
    Text = "Duelo a muerte"
  },
  State_19540_Name = {
    Text = "Límite de Aritmética"
  },
  State_19541_Desc = {
    Text = "Antes de que termine el turno, no puedes realizar ninguna acción"
  },
  State_19541_Name = {
    Text = "Se desmayó"
  },
  State_19544_Desc = {
    Text = "Después de usar \"Golpe\", consume todas las capas; cada capa consumida aumenta el daño causado por este \"Golpe\" en un 50%, apilándose hasta 5 capas."
  },
  State_19544_Name = {
    Text = "<EnergyStorageColour:cargar>"
  },
  State_19545_Name = {
    Text = "Esta carta se considera \"golpear\"."
  },
  State_19546_Desc = {
    Text = "Cambia la aritmética de la carta antes de jugar.__\"Solo para desarrollo\""
  },
  State_19546_Name = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar__\"Solo para desarrollo\""
  },
  State_19547_Desc = {
    Text = "Al final del turno, causa [Layer] puntos de daño pasivo. Permanente."
  },
  State_19547_Name = {Text = "Veneno"},
  State_19549_Desc = {
    Text = "El daño recibido por ataques activos antes del inicio de la siguiente ronda disminuye un 50 %, se anula al aplicar con \"vulnerable\""
  },
  State_19549_Name = {
    Text = "<ReinforceColour: reforzado>"
  },
  State_19552_Desc = {
    Text = "Actualmente posees [Layer] puntos de escudo, el escudo no superará la salud máxima, durará 1 turno"
  },
  State_19552_Name = {Text = "Blindaje"},
  State_19553_Desc = {
    Text = "Gana contraataque después de la fase de robo __ \"Solo para desarrollo\""
  },
  State_19553_Name = {
    Text = "Desencadenante retrasado __ \"Solo para uso de desarrollo\""
  },
  State_19554_Name = {
    Text = "Estado vacío"
  },
  State_19555_Desc = {
    Text = "·El Coste de Aritmética de las \"habilidades\" aumenta en +[Layer] este turno, hasta un máximo de 3 acumulaciones.\n·Al Jugar una \"habilidad\", si las acumulaciones son mayores que 1, se reducen en 1."
  },
  State_19555_Name = {
    Text = "Estancamiento"
  },
  State_19556_Desc = {
    Text = "Al final del turno, el coste de potencia de esta carta se reduce en -1"
  },
  State_19556_Name = {
    Text = "<CardKeyWord:Preparar>"
  },
  State_19557_Desc = {
    Text = "El daño recibido por ataques activos antes del inicio de la siguiente ronda disminuye [DescArg1] %, se anula al aplicar con \"vulnerable\""
  },
  State_19557_Name = {Text = "Fortaleza"},
  State_19558_Name = {
    Text = "Revive la biblioteca de cartas añadir activador de cartas __ \"Solo para uso de desarrollo\""
  },
  State_19560_Desc = {
    Text = "Antes de terminar el turno, no se puede usar exaltar"
  },
  State_19560_Name = {Text = "Sellado"},
  State_19561_Name = {
    Text = "Se puede usar 3 veces"
  },
  State_19990_Desc = {
    Text = "Al inicio del próximo turno, obtén [Layer] locura"
  },
  State_19990_Name = {
    Text = "Locura retardada"
  },
  State_19992_Desc = {
    Text = "Al desmayarse, el objetivo no puede realizar ninguna acción hasta que termine el turno. Al recibir daño de desmayo, se obtiene Resistencia. Si la Resistencia está activa, el daño de desmayo posterior se duplica pero el efecto de desmayo se anula."
  },
  State_19992_Name = {
    Text = "<ComaColour:desmayo>"
  },
  State_19995_Desc = {
    Text = "Al final del turno, causa daño pasivo igual al número de acumulaciones. Permanente."
  },
  State_19995_Name = {
    Text = "<IntoxicationColour: Veneno>"
  },
  State_19996_Desc = {
    Text = "Daño aumentado en 25% hasta el final del turno, se cancela con debilidad"
  },
  State_19996_Name = {
    Text = "<StrengthenColour:Fortalecer>"
  },
  State_19998_Desc = {
    Text = "Antes del próximo turno, cada vez que seas atacado, inflige al atacante un número igual de acumulaciones de daño pasivo."
  },
  State_19998_Name = {
    Text = "<RetaliateColour:Contrataque>"
  },
  State_20012_Desc = {
    Text = "Cada punto de capacidad aritmética restante permite robar 1 carta al inicio de tu próxima ronda; cada carta restante en la mano permite ganar 1 capacidad aritmética"
  },
  State_20012_Name = {
    Text = "Fragmento del sabio mutado"
  },
  State_20012_WeaponDesc = {
    Text = "Cada punto de capacidad aritmética restante permite robar 1 carta al inicio de tu próxima ronda; cada carta restante en la mano permite ganar 1 capacidad aritmética"
  },
  State_20013_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maestría en Reinos> aumenta 100. Recoloca la primera carta jugada cada turno en tu mano. Al inicio del turno extradimensional, límite de cartas +5 y duplica tu mano"
  },
  State_20013_Name = {
    Text = "Estado@péndulo crono espejo"
  },
  State_20014_Name = {
    Text = "Péndulo temporal \"Perdido\""
  },
  State_20016_Name = {
    Text = "Guantes Mágicos de la Creación"
  },
  State_20017_Desc = {
    Text = "El próximo efecto de salto se activará con certeza"
  },
  State_20017_Name = {Text = "Impulso"},
  State_20021_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maestría en Reinos> aumenta 100. Recoloca la primera carta jugada cada turno en tu mano. Al inicio del turno extradimensional, límite de cartas +5 y duplica tu mano"
  },
  State_20021_Name = {
    Text = "Estado@péndulo crono espejo"
  },
  State_20023_Desc = {
    Text = "Después de que comience la batalla, se añadirán dos cartas de locura en la baraja"
  },
  State_20023_Name = {
    Text = "Híbrido del Caos"
  },
  State_20023_WeaponDesc = {
    Text = "Después de que comience la batalla, se añadirán dos cartas de locura en la baraja"
  },
  State_20024_Desc = {
    Text = "Cada vez que liberes la Exaltar, obtendrás una Infusión tóxica que puede aplicar [Arg1] puntos de veneno. Al final del turno, si tienes 3 Infusiones tóxicas en la mano, podrás combinarlas para crear un Brote tóxico que activa veneno."
  },
  State_20024_Name = {
    Text = "Estado@Creación Alienígena Lengua"
  },
  State_20026_Desc = {
    Text = "Las cartas no entran en la pila de descarte durante la fase de descarte, sino que se mantienen en la mano y activan efectos posteriores."
  },
  State_20026_Name = {
    Text = "<RetainIconKeywords:Retener>"
  },
  State_20026_WeaponDesc = {
    Text = "Después de jugar, la carta no irá al montón de descarte, no podrá usarse nuevamente en esta batalla"
  },
  State_20028_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Maestría del Reino> aumenta en 100. Por cada carta jugada, Fusión Embrionaria +10. Cuando los PV son inferiores al 25%, aumenta a 20. Máximo 10 veces por turno."
  },
  State_20028_Name = {
    Text = "Estado@péndulo crono corrupción"
  },
  State_20029_Desc = {
    Text = "Cada vez que liberes Exaltar, obtienes una Infusión tóxica que puede aplicar [Arg1] puntos de Veneno. Al final del turno, si tienes 3 Infusiones tóxicas en la mano, puedes combinarlas para crear un Brote tóxico que activa el Veneno."
  },
  State_20029_Name = {
    Text = "Estado@Creación Alienígena Lengua"
  },
  State_20035_Name = {
    Text = "Estado@péndulo crono sin sueño"
  },
  State_20038_Name = {
    Text = "Cuerpo Simbiótico del Caos"
  },
  State_20038_WeaponDesc = {
    Text = "Cuando el equipo está compuesto por Caos y otras clases, al inicio del turno todos los Despertados ganan 20 de locura"
  },
  State_20039_Desc = {
    Text = "Si está en tu mano durante la fase de descarte, la carta se consumirá y no aparecerá más en esta batalla"
  },
  State_20039_Name = {
    Text = "<NothingnessIconKeywords: Ilusión>"
  },
  State_20039_WeaponDesc = {
    Text = "Después de jugar, la carta no irá al montón de descarte, no podrá usarse nuevamente en esta batalla"
  },
  State_20040_Name = {
    Text = "Estado@péndulo crono cuenta sin sueño"
  },
  State_20041_Desc = {
    Text = "Al inicio del turno, por cada enemigo, se obtiene 1 cálculo y se roba 1 carta. Al matar a un enemigo con daño activo, se inflige sangrado equivalente al doble del daño excesivo a otros enemigos"
  },
  State_20041_Name = {
    Text = "Canción de la Masa Mutada"
  },
  State_20042_Desc = {
    Text = "Inflige un 25% más de daño a enemigos con estados negativos, y el asesino obtiene 20 de locura al matar"
  },
  State_20044_Desc = {
    Text = "Aumenta el efecto de Síntoma: Debilidad en un 10%. Cada 3 turnos, añade 1 acumulación de Síntoma: Debilidad a todos los enemigos."
  },
  State_20045_Desc = {
    Text = "Al inicio del próximo turno, elige 3 cartas del mazo y añádelas a tu mano"
  },
  State_20045_Name = {
    Text = "Péndulo temporal vuela"
  },
  State_20306_Name = {
    Text = "Guantes Mágicos de la Creación"
  },
  State_20419_Desc = {
    Text = "Cada vez que se causa 1 daño, se aplica a la meta [Arg1] capas de veneno. Si se alcanza un total acumulado de 25 activaciones dentro de esta batalla, se activa inmediatamente el veneno en todos los enemigos"
  },
  State_20425_Desc = {
    Text = "Al inicio del turno, obtén [Layer] puntos de <PowerIconKeywords:fuerza> temporal y escudo"
  },
  State_20425_Name = {
    Text = "Devorador sediento de sangre"
  },
  State_20600_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Cada turno, las primeras [StateArg2] \"Habilidades\" consumen [StateArg1] menos Aritmética."
  },
  State_20600_Name = {Text = "Epifanía"},
  State_20601_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Strike\" daño incrementado en [StateArg1]%. Al ser atacado, gana [StateArg2] capas de <EnergyStorageKeywords:Charge>."
  },
  State_20601_Name = {Text = "Gula"},
  State_20602_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: \"Golpe\" permite seleccionar un objetivo y causa [StateArg1] capas de <PVPSlowKeywords:lentitud>, y el efecto se duplica cuando se activa por primera vez en un objetivo cada turno."
  },
  State_20602_Name = {
    Text = "Mano Olvidada"
  },
  State_20603_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: \"Exaltar\" te da <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_20603_Name = {
    Text = "Restitución de la forma alterada"
  },
  State_20604_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: \"Golpe\" cura <Heal:[Heal:StateArg1]> vida"
  },
  State_20604_Name = {Text = "Succión"},
  State_20605_Desc = {
    Text = "<PVPWeaponKeywords:wheel of destiny>: Cuando esté equipado, <ComaKeywords:desmayado> a sí mismo. Antes de \"exaltar\", disipa todos los estados negativos de los aliados."
  },
  State_20605_Name = {
    Text = "Bastón de Lord"
  },
  State_20606_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: \"Golpe\" te da <Energy:[Energy:StateArg1]> locura"
  },
  State_20606_Name = {Text = "Frenesí"},
  State_20607_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: «Golpe» ataca al enemigo con <HPAndShieldMax:mayor vida y escudo>, infligiendo adicionalmente <PVPBleedingKeywords:hemorragia> equivalente al [StateArg1]% del daño."
  },
  State_20607_Name = {
    Text = "Cortar y Herir"
  },
  State_20608_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>：\"Habilidad\" al final de la ronda, te da <Energy:[Energy:StateArg1]> Locura"
  },
  State_20608_Name = {Text = "Susurro"},
  State_20609_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: La Locura obtenida por perder vida se duplica"
  },
  State_20609_Name = {
    Text = "Sueño Marino"
  },
  State_20610_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: El Daño de \"golpear\" aumenta un [DescArg1]%. Después de \"Exaltar\", la propia <PVPPowerIconKeywords:Fortaleza> + [StateArg2] y el Daño de \"golpear\" aumenta adicionalmente un [StateArg3]%, con un máximo del 100%."
  },
  State_20610_Name = {
    Text = "Bestia Celestial"
  },
  State_20611_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>：\"Habilidad\" al final de la ronda, cura <Heal:[Heal:StateArg1]> a aliado más herido"
  },
  State_20611_Name = {Text = "Esperanza"},
  State_20612_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: Al final del turno, el aliado con menos locura obtiene <Energy:[Energy:StateArg1]> y el aliado con más vida perdida recupera <Heal:[Heal:StateArg2]> de vida"
  },
  State_20612_Name = {
    Text = "Amparo Misericordioso"
  },
  State_20613_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: Al final del turno, los demás aliados obtienen <Block:[Block:StateArg1]> de escudo"
  },
  State_20613_Name = {
    Text = "Tierra Inexistente"
  },
  State_20614_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: Al final del turno, obtén [StateArg1] <PVPRetaliateIconKeywords:mostrador> temporal"
  },
  State_20614_Name = {
    Text = "Fusión del Núcleo"
  },
  State_20615_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: \"Golpe\"causa [StateArg1] daño adicional y aplica una cantidad igual de <PVPMethysisKeywords:veneno>."
  },
  State_20615_Name = {
    Text = "Amarradura de maldición amarga"
  },
  State_20616_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Gana <Energy:[Energy:StateArg1]> Aliemus al final del turno."
  },
  State_20616_Name = {
    Text = "Primavera de Azathoth"
  },
  State_20617_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Al final del turno, gana <Block:[Block:StateArg1]> Escudo"
  },
  State_20617_Name = {Text = "Exilio"},
  State_20618_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: \"exaltar\" antes hace que ambos jugadores descarten todas las cartas en la mano y roben una cantidad igual."
  },
  State_20618_Name = {
    Text = "Espectáculo de Magia Feliz"
  },
  State_20619_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equipar, obtienes <Energy:[Energy:StateArg1]> Aliemus. Cuando un Cuerpo Despertado aliado libera \"Exaltar\", obtienes <DelayKeywords:Latencia>: <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_20619_Name = {
    Text = "Himno al Dios-Rey"
  },
  State_20620_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Límite de cartas en mano + [StateArg2]. Al final del turno, obtén [StateArg1] copias aleatorias de «habilidad» en tu mano."
  },
  State_20620_Name = {
    Text = "Momento de reunión"
  },
  State_20621_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Antes de \"Exaltar\", <StrengthenKeywords:Mejorar> y <ReinforceKeywords:Fortaleza> a sí mismo."
  },
  State_20621_Name = {
    Text = "Transgresión del Sufrimiento"
  },
  State_20622_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al final del turno, obtienes <Energy:[Energy:StateArg1]> Aliemus. Consume toda la Aritmética restante, obtienes [StateArg3] Aliemus adicional por cada 1 de Aritmética consumida."
  },
  State_20622_Name = {
    Text = "Nacimiento Secreto"
  },
  State_20623_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Después de \"Exaltar\", roba [StateArg1] <plural value=\"[StateArg1]\" singular=\"carta\" plural=\"cartas\">."
  },
  State_20623_Name = {Text = "Aparición"},
  State_20624_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al \"Exaltar\", roba [StateArg1] cartas y coloca [StateArg2] copias en tu mano."
  },
  State_20624_Name = {
    Text = "Hora de la Fortuna"
  },
  State_20625_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: \"Exaltar\" <DelayKeywords:Latencia>: Restaura <Heal:[Heal:StateArg1]> PV a todos los aliados."
  },
  State_20625_Name = {
    Text = "La Fábula del Glotón"
  },
  State_20626_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>:\"Golpe\" aumenta el daño en [StateArg1]%, y se otorga <ReinforceKeywords:Exaltar>."
  },
  State_20626_Name = {
    Text = "Voluntad Inquebrantable"
  },
  State_20627_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: Al final del turno, todos los aliados recuperan <Heal:[Heal:StateArg1]> de vida"
  },
  State_20627_Name = {Text = "Bendición"},
  State_20628_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Después de \"Exaltar\", otorga a otros aliados <Energy:[Energy:StateArg1]> Aliemus. Si esto otorga a un aliado más Aliemus del necesario para activar su Exaltar, el Portador obtiene la mitad del exceso."
  },
  State_20628_Name = {
    Text = "Deber cumplido"
  },
  State_20629_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: El daño, la curación y el efecto del escudo de \"Exaltar\" aumentan en [StateArg1]%."
  },
  State_20629_Name = {
    Text = "En Nombre de la Rosa"
  },
  State_20630_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Al final del turno, gana <Block:[Block:StateArg1]> Escudo y <Energy:[Energy:StateArg2]> Locura"
  },
  State_20630_Name = {
    Text = "Réquiem Invernal"
  },
  State_20631_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: \"Golpear\" hace que el objetivo reciba <PVPVulnerabilityIconKeywords:Vulnerable>. Obtén [StateArg1] <EnergyStorageKeywords:Cargar> al equipar y al final del turno."
  },
  State_20631_Name = {
    Text = "Punto crítico"
  },
  State_20632_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>：Límite de cartas en mano +[StateArg1]"
  },
  State_20632_Name = {
    Text = "Espiral de Recuerdos"
  },
  State_20633_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Cuando el Portador recibe un ataque activo por primera vez en cada turno, inflige [StateArg1] Daño al atacante, <PVPEntanglementKeywords:Entrelazados>."
  },
  State_20633_Name = {
    Text = "Descendiente Pálido"
  },
  State_20634_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: \"Golpe\", \"habilidad\" o \"exaltar\" aumentan el daño, la curación y el escudo en [DescArg1]%, <PVPGrowthKeywords:crecimiento> [StateArg2]%."
  },
  State_20634_Name = {
    Text = "Sol Poniente"
  },
  State_20635_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>：\"exaltar\" antes otorga a todos los aliados <StrengthenKeywords:fortalecer>"
  },
  State_20635_Name = {
    Text = "Poder del piadoso"
  },
  State_20636_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al final del turno, gana una <PVPDerivativeCardKeywords_2:\"Ilusión\">. Por cada dos <PVPDerivativeCardKeywords_2:\"Ilusión\"> en tu mano, combínalas en un <PVPDerivativeCardKeywords_12:\"Pequeño deseo\">."
  },
  State_20636_Name = {Text = "Madurado"},
  State_20637_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>：al final del turno, mezcla [StateArg1] cartas <PVPDerivativeCardKeywords_11:\"intercambio desigual\"> en el mazo de robo"
  },
  State_20637_Name = {
    Text = "La Información es Vida"
  },
  State_20639_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Al final del turno, el portador inflige [StateArg1] de daño al enemigo con <HPAndShieldMax:mayor vida y escudo>, aplicando <PVPMethysisKeywords:veneno>."
  },
  State_20639_Name = {
    Text = "Regalo Putrefacto"
  },
  State_20640_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>：Al equipar y al inicio del turno, causa <Damage:[Damage:StateArg1]> de daño <PVPBleedingKeywords:sangrando> a todos los enemigos. Por cada carta en la mano del objetivo, el daño <PVPBleedingKeywords:sangrando> se incrementa en [StateArg2]"
  },
  State_20640_Name = {
    Text = "Banquete Carmesí"
  },
  State_20641_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>：Al morir, otorga a los aliados [StateArg1] capas de <PVPProtectiveKeywords:barrera>"
  },
  State_20641_Name = {
    Text = "Análisis de la Muerte"
  },
  State_20642_Desc = {
    Text = "<PVPHoldingKeywords:En Mano>: Después de jugar una carta, esta carta se convierte en otro \"Rueda del Destino\" aleatorio, y reduce su costo aritmético por -1."
  },
  State_20642_Name = {
    Text = "Nacimiento de un alma"
  },
  State_20643_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Después de \"Exaltar\" obtén [StateArg1] Aritmética. <DelayKeywords:Latencia>: descuenta [StateArg2] Aritmética."
  },
  State_20643_Name = {
    Text = "Síndrome de amnesia"
  },
  State_20644_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equipar, se inflige [StateArg2] Daño a sí mismo, <PVPEntanglementKeywords:Entrelazados>. Por cada aliado caído, <StrongEffectKeywords:Amplificación> +[StateArg1]."
  },
  State_20644_Name = {
    Text = "Reliquia Preciada"
  },
  State_20645_Name = {
    Text = "Mochila del Aventurero"
  },
  State_20646_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: \"golpear\" aumenta el Daño un [StateArg1]%, y \"Exaltar\" cura <Heal:[Heal:StateArg2]> PV."
  },
  State_20646_Name = {
    Text = "Canción de Cuna"
  },
  State_20647_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: \"Exaltar\" coloca [StateArg1] <PVPDerivativeCardKeywords_11:\"Intercambio desigual\"> en tu mano."
  },
  State_20647_Name = {
    Text = "En el Corazón de la Tormenta"
  },
  State_20648_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: Al inicio del turno, obtiene un <PVPWonderfulEffectKeywords:efecto increíble>, cuando el enemigo usa su primer \"Llave\" cada turno, coloca [StateArg1] cartas de \"Escena Lujosa\" en su mano"
  },
  State_20648_Name = {
    Text = "Banquete Silencioso"
  },
  State_20649_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: \"Exaltar\" coloca en tu mano la última \"habilidad\" jugada en el turno anterior y reduce su coste de aritmética a 0; si se activan múltiples efectos de este tipo, se retrocede hacia atrás."
  },
  State_20649_Name = {
    Text = "Reloj Inverso"
  },
  State_20650_Desc = {
    Text = "<PVPWeaponKeywords:wheel of destiny>: Cuando esté equipado, <ComaKeywords:desmayado> a sí mismo. Antes de \"exaltar\", disipa todos los estados positivos de los enemigos."
  },
  State_20650_Name = {Text = "Delirio"},
  State_20651_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Al final del turno, roba [StateArg1] cartas"
  },
  State_20651_Name = {Text = "Avaricia"},
  State_20652_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>:\"Exaltar\" causa [StateArg1] daño a todos los enemigos, <DisarmKeywords:Parálisis>."
  },
  State_20652_Name = {Text = "Castigo"},
  State_20653_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: \"Golpe\" selecciona un objetivo y le quita <Energy:[Energy:StateArg1]> locura"
  },
  State_20653_Name = {
    Text = "Mareas del Deseo"
  },
  State_20654_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: al inicio del turno, <PVPSeriousInjuryKeywords:Plaga> a sí mismo y obtiene <Damage:[Damage:StateArg1]> capas de <PVPCorrosionKeywords:Sello del pecado>. Al final del turno, <ReinforceKeywords:Fortaleza> a sí mismo."
  },
  State_20654_Name = {
    Text = "Edicto de la Reina"
  },
  State_20655_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: \"Strike\" daño incrementado en [StateArg1]%, \"Strike\" puede apuntar a cualquier enemigo."
  },
  State_20655_Name = {Text = "Favor"},
  State_20656_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: \"habilidad\" aumenta el daño, el efecto de curación y el escudo en [StateArg1]%, si no tienes <PVPProtectiveKeywords:barrera> después de usar \"habilidad\", obtén 1 capa."
  },
  State_20656_Name = {
    Text = "El Último Verso"
  },
  State_20657_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: Cada turno que el oponente juegue la [StateArg1]ª \"habilidad\", coloca una copia de su consumo de aritmética - [StateArg2] en tu mano"
  },
  State_20657_Name = {
    Text = "Inspiración"
  },
  State_20658_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>：\"golpe\"gana [StateArg1] aritmética por cada objetivo atacado"
  },
  State_20658_Name = {
    Text = "Balada Encadenada"
  },
  State_20659_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>：Al morir, en el inicio del siguiente turno <PVPResurrectionKeywords:resucita> y obtén <Heal:[Heal:StateArg1]> de vida y <Block:[Block:StateArg2]> de escudo y destruye esta \"Rueda del destino\""
  },
  State_20659_Name = {Text = "Vitalidad"},
  State_20660_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Después de \"exaltar\", todos los aliados ganan escudo <Block:[Block:StateArg1]>."
  },
  State_20660_Name = {
    Text = "Barrera del corazón"
  },
  State_20661_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Después de \"Exaltar\", causa <Damage:[Damage:StateArg1]> Daño de <PVPBleedingKeywords:Sangrar> a todos los enemigos."
  },
  State_20661_Name = {
    Text = "Senda Perdida"
  },
  State_20662_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Al final del turno, por cada punto de <PVPCapKeywords:límite de capacidad de cómputo> inflige [StateArg1] de <PVPBleedingKeywords:hemorragia> al enemigo con <HPAndShieldMin:menor vida y escudo>, causando un total de <Damage:[Damage:DescArg1]> de daño por <PVPBleedingKeywords:hemorragia>."
  },
  State_20662_Name = {
    Text = "Agazapado en la noche"
  },
  State_20663_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Antes de \"Exaltar\", disipa sus estados negativos y obtiene [StateArg1] Acumulaciones de <EnergyStorageKeywords:Cargar>."
  },
  State_20663_Name = {
    Text = "Rompiendo Cadenas"
  },
  State_20664_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>:\"Habilidad\" se otorga <ReinforceKeywords:Exaltar>."
  },
  State_20664_Name = {
    Text = "Corazón de Caballero"
  },
  State_20665_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>:Si no hay estados negativos al disipar, recupera <Heal:[Heal:StateArg1]> vida. Al final del turno, <DelayKeywords:Retraso>: Disipa estados negativos"
  },
  State_20665_Name = {
    Text = "Vela de la Providencia"
  },
  State_20666_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Tras «Explosión de locura», el aliado con <HPAndShieldMin:menor vida y escudo> obtiene [StateArg1] capas de <PVPProtectiveKeywords:barrera>."
  },
  State_20666_Name = {
    Text = "A mi querido amigo"
  },
  State_20667_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: El Daño de la primera \"habilidad\" jugada por el Portador en cada turno aumenta en [StateArg1]%."
  },
  State_20667_Name = {
    Text = "Hoja del Gigante"
  },
  State_20668_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: Cuando un aliado despierto muere, inflige <Damage:[Damage:StateArg1]> daño <PVPBleedingKeywords:sangrando> a todos los enemigos. Cuando el portador muere, inflige un daño adicional de <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:sangrando>."
  },
  State_20668_Name = {
    Text = "La Dama Coral Caída"
  },
  State_20669_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equipar y al inicio de tu turno, si no hay <PVPProtectiveKeywords:barrera>, gana [StateArg1] capas de <PVPProtectiveKeywords:barrera>; de lo contrario, reduce el costo de aritmética de 1 \"habilidad\" en la mano con el costo de aritmética más alto en 1."
  },
  State_20669_Name = {
    Text = "Tablilla Sagrada"
  },
  State_20670_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>：\"Golpe\" causa <PVPSeriousInjuryKeywords:Herida grave>, daño aumenta [StateArg1]%  pero pierdes mitad de tu vida"
  },
  State_20670_Name = {
    Text = "Aleta del Dolor"
  },
  State_20671_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: \"Exaltar\" restaura <Heal:[Heal:StateArg1]> PV."
  },
  State_20671_Name = {
    Text = "Más Allá de la Muerte"
  },
  State_20672_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Al final del turno, reduce en -[StateArg1] el consumo de aritmética de la carta de tu mano con mayor consumo de aritmética. <PrepareKeywords:Listo>."
  },
  State_20672_Name = {
    Text = "Concentración mental"
  },
  State_20673_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: \"Exaltar\" te da <Block:[Block:StateArg1]> Escudo del personaje, y a otros aliados les otorga <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_20673_Name = {
    Text = "Factor Incalculable"
  },
  State_20696_Name = {
    Text = "Estado@TemorGigante"
  },
  State_20723_Desc = {
    Text = "El daño de la carta de golpe se incrementa en [Layer]. __ \"Solo para desarrollo\""
  },
  State_20723_Name = {
    Text = "Aumento fijo de daño para la carta de golpe __ \"Solo para Desarrollo\""
  },
  State_20724_Desc = {
    Text = "El daño de la carta de golpe se reduce en [Layer]. __ \"Solo para desarrollo\""
  },
  State_20724_Name = {
    Text = "Reducción fija de daño para la carta de golpe __ \"Solo para Desarrollo\""
  },
  State_20749_Desc = {
    Text = "Conteo de rastreo genérico. __ \"Solo para desarrollo\""
  },
  State_20758_Desc = {
    Text = "Al inicio del próximo turno, roba [Layer] cartas"
  },
  State_20758_Name = {
    Text = "Tirada retardada"
  },
  State_20766_Desc = {
    Text = "Consulta la lógica de huelga general para efectos específicos. __ \"Solo para uso de desarrollo\""
  },
  State_20802_Desc = {
    Text = "Esta carta no se puede Jugar"
  },
  State_20802_Name = {
    Text = "No se puede jugar __ \"Solo para desarrollo\""
  },
  State_20803_Desc = {
    Text = "Esta carta -1 en consumo de aritmética, después de usar otras cartas, esta carta se transformará en otra carta de rueda del destino aleatoria"
  },
  State_20803_Name = {
    Text = "<CardKeyWord:nacimiento de un alma>"
  },
  State_20805_Desc = {
    Text = "Las cartas no entran en la pila de descarte durante la fase de descarte, sino que se mantienen en la mano"
  },
  State_20805_Name = {
    Text = "<RetainIconKeywords:Retener>"
  },
  State_20806_Desc = {
    Text = "Después de jugar, no pasará al montón de descarte, sino que será removido del mazo"
  },
  State_20806_Name = {
    Text = "<DepleteIconKeywords:Consumo>"
  },
  State_20820_Desc = {
    Text = "Al inicio del próximo turno, revive y obtén [Layer] vida y [Layer] escudo"
  },
  State_20820_Name = {
    Text = "Resurrección retardada"
  },
  State_20851_Name = {
    Text = "Conceder Carta"
  },
  State_20981_Desc = {
    Text = "\"Carmesí\"ya ha despertado, el daño que causa se incrementará considerablemente"
  },
  State_20981_Name = {
    Text = "¡Yū Hashi despierta!"
  },
  State_20981_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_20982_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_20982_Name = {
    Text = "No Activado"
  },
  State_20988_Desc = {
    Text = "Locura inicial +80. Cada turno obtienes 20 puntos de locura"
  },
  State_20988_Name = {
    Text = "Davendale·Primer Encuentro"
  },
  State_20989_Desc = {
    Text = "Locura inicial +80. Obtén 2 puntos de aritmética por turno y 20 puntos de locura"
  },
  State_20989_Name = {
    Text = "Tulu · Primer Encuentro"
  },
  State_21306_Desc = {
    Text = "Reinicia el combo cada turno"
  },
  State_21306_Name = {
    Text = "Combo restablecido"
  },
  State_21307_Desc = {
    Text = "Cada capa añade 1 ataque, pierde 1 capa al recibir daño, mínimo 1 capa, pierde todas al final del turno"
  },
  State_21307_Name = {Text = "Combo"},
  State_21342_Desc = {
    Text = "Al inicio de la siguiente ronda, obtienes [Layer] de curación"
  },
  State_21342_Name = {
    Text = "Tratamiento diferido"
  },
  State_21345_Desc = {
    Text = "Antes de comenzar el Ritual de Descenso Divino, al morir resucitarás, eliminarás estados negativos, tendrás inmunidad al daño y recuperarás el 30% de la vida. Después de comenzar el Ritual de Descenso Divino, al morir resucitarás completamente, eliminarás estados negativos y la Obsesión ritual, y llamarás a dos miembros del clan."
  },
  State_21345_Name = {
    Text = "Obsesión ritual"
  },
  State_21358_Desc = {
    Text = "El jugador no tiene límite en su mano."
  },
  State_21381_Name = {
    Text = "Conteo de veces de uso del sellado"
  },
  State_21385_Desc = {
    Text = "Al perder 1 punto de vida, se reduce 1 capa. Cuando las capas bajan a 0, la intención se convierte en una explosión de aliemus con alto daño y desactiva el efecto de petrificación"
  },
  State_21385_Name = {
    Text = "Furia de sangre"
  },
  State_21450_Desc = {
    Text = "Al inicio del próximo turno, dispersa tus estados negativos."
  },
  State_21450_Name = {
    Text = "Purificación retardada"
  },
  State_21488_Desc = {
    Text = "Consulta la lógica de huelga general para efectos específicos. __ \"Solo para uso de desarrollo\""
  },
  State_21492_Desc = {
    Text = "El daño aumenta un 50% en golpes críticos"
  },
  State_21492_Name = {
    Text = "<CardKeyWord:Golpe Crítico>"
  },
  State_21546_Desc = {
    Text = "Al inicio del próximo turno, obtén [Layer] escudo"
  },
  State_21546_Name = {
    Text = "Escudo de latencia"
  },
  State_21547_Desc = {
    Text = "Al inicio del turno, conserva la mitad del escudo"
  },
  State_21547_Name = {Text = "Resilencia"},
  State_21548_Desc = {
    Text = "Al inicio de la siguiente ronda, obtienes \"fortalecer\""
  },
  State_21548_Name = {
    Text = "Fortalecimiento retrasado"
  },
  State_21580_Desc = {
    Text = "El Cazador de Cabezas está rastreando tus movimientos, por cada carta que saques, el Cazador obtiene [StateArg1] fuerza temporal"
  },
  State_21580_Name = {Text = "Pista"},
  State_21587_Name = {
    Text = "Este turno, se ha encontrado un nuevo despertado aleatorio"
  },
  State_21590_Name = {
    Text = "Intentar encontrar nuevo despertar"
  },
  State_21601_Name = {
    Text = "Se ha encontrado un nuevo Cuerpo Despierto"
  },
  State_21616_Desc = {
    Text = "Usar exaltar para sellar todos los despertadores durante un turno"
  },
  State_21616_Name = {
    Text = "Restos del caminante del camino"
  },
  State_21671_Name = {
    Text = "Deal daño de área __ \"Para Desarrollo Solo\""
  },
  State_21688_Name = {
    Text = "Se puede usar 1 vez"
  },
  State_21689_Name = {
    Text = "Se puede usar 2 veces"
  },
  State_21720_Desc = {
    Text = "Causa el mismo efecto al Despertado detrás del objetivo. Si no hay Despertado detrás de él, solo causa efecto al objetivo."
  },
  State_21720_Name = {
    Text = "<CardKeyWord:Perforar>"
  },
  State_21726_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>：Después de jugar la primera \"habilidad\" en cada turno, se baraja una copia de ella con -[StateArg1] de agotamiento aritmético en el mazo de robar"
  },
  State_21726_Name = {Text = "Gira, Gira"},
  State_21744_Name = {
    Text = "Intentar encontrar nuevo despertar"
  },
  State_21745_Name = {
    Text = "Se ha encontrado un nuevo Cuerpo Despierto"
  },
  State_21746_Name = {
    Text = "Este turno, se ha encontrado un nuevo despertado aleatorio"
  },
  State_21747_Desc = {
    Text = "Hay [Layer] Despertados siendo cazados. Cada vez que un Despertado cazado usa una carta, el \"Cazador Frenético\" gana 1 marca de caza"
  },
  State_21747_Name = {
    Text = "Ceremonia de caza"
  },
  State_21751_Desc = {
    Text = "Roba la mitad de las cartas según las capas de marca de caza ([DescArg1]), +1 capa de marca de caza para el \"Cazador Frenético\""
  },
  State_21751_Name = {
    Text = "<CardKeyWord:Cazado>"
  },
  State_21754_Desc = {
    Text = "Al morir, disipa toda la fuerza temporal de \"Cazador Frenético\" y reduce a la mitad las capas de su \"Marca de Caza\""
  },
  State_21754_Name = {
    Text = "Breve alivio"
  },
  State_21765_Desc = {
    Text = "·Se puede equipar una «Rueda del destino» a un aliado Despertado, permitiendo que active el efecto de la «Rueda del destino».\n·Al equipar una nueva «Rueda del destino» a un Despertado, se destruirá la antigua y se retendrá la nueva «Rueda del destino».\n·La «Rueda del destino» equipada se destruirá cuando el Despertado muera.\n·Si se equipa una «Rueda del destino» a un Despertado muerto, se destruirá esa «Rueda del destino» y se obtendrá una Ilusión y se devolverá la aritmética consumida."
  },
  State_21765_Name = {
    Text = "<PVPWeaponKeywords:Rueda del destino>"
  },
  State_21785_Name = {
    Text = "Grito de batalla"
  },
  State_21787_Name = {
    Text = "Añadir grito de batalla"
  },
  State_21826_Name = {
    Text = "Llamada de apertura del Rey de los niños"
  },
  State_21829_Name = {
    Text = "Último Aliento"
  },
  State_21838_Name = {
    Text = "Introducción inicial"
  },
  State_21843_Name = {
    Text = "Añadir estado al inicio"
  },
  State_21895_Name = {
    Text = "Llamada de apertura"
  },
  State_21905_Desc = {
    Text = "\"El golpe\" obtiene 2 puntos de aritmética y descarta aleatoriamente 1 carta; \"DEF\" roba 2 cartas y pierde 1 punto de aritmética"
  },
  State_21928_Name = {Text = "Sugerencia"},
  State_22054_Name = {
    Text = "Llamada de apertura"
  },
  State_22055_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_22055_Name = {
    Text = "No Activado"
  },
  State_22067_Desc = {
    Text = "Después de que termine el turno, un tentáculo ataca [Layer] veces"
  },
  State_22067_Name = {
    Text = "Asamblea de tentáculos"
  },
  State_22074_Desc = {
    Text = "Sobrevive hasta el séptimo turno, cambia la intención a mirar, en el octavo turno y más, cambia la intención a profanar"
  },
  State_22134_Desc = {
    Text = "Inflige Daño al Escudo del personaje, PV y Barrera del objetivo simultáneamente."
  },
  State_22134_Name = {
    Text = "<CardKeyWord:Daño perforante>"
  },
  State_22157_Desc = {
    Text = "Cuando la vida esté por debajo del 50% ([StateArg1]), se dividirá en \"Corriente\" y \"Marea\" con vida igual"
  },
  State_22157_Name = {Text = "Dividir"},
  State_22204_Desc = {
    Text = "Al comienzo del turno, recibe [Layer]% de tasa crítica temporal y daño crítico temporal"
  },
  State_22204_Name = {
    Text = "Melodía distante"
  },
  State_22204_WeaponDesc = {
    Text = "Si no pierdes vida hasta el inicio del siguiente turno, tu tasa crítica en ese turno aumenta en +[StateArg1]%"
  },
  State_22210_Desc = {
    Text = "Consumo de aritmética + 100, y no se puede usar impacto ni ganar locura"
  },
  State_22210_Name = {
    Text = "Super Lento"
  },
  State_22238_Name = {
    Text = "Jugadores en duelo a muerte"
  },
  State_22239_Name = {
    Text = "Aplica combate a muerte del jugador __ \"Por desarrollo solamente\""
  },
  State_22249_Desc = {
    Text = "Al inicio del próximo turno, roba [Layer] cartas menos"
  },
  State_22249_Name = {
    Text = "Intercambio desigual"
  },
  State_22300_Desc = {
    Text = "Esta carta de \"golpear\" no se puede jugar."
  },
  State_22300_Name = {
    Text = "La carta de golpe está deshabilitada y no se puede jugar __ \"Solo para desarrollo\""
  },
  State_22303_Desc = {
    Text = "Cada vez que reciba daño, otorgará a una carta aleatoria en su mano una capa temporal de \"retardo\", y al romper el escudo se eliminará el estado de \"escudo de escarcha\""
  },
  State_22303_Name = {
    Text = "Escudo de escarcha"
  },
  State_22324_Desc = {
    Text = "Por cada capa, aumenta un segmento de ataque en este turno"
  },
  State_22324_Name = {
    Text = "Eco de la marea furiosa"
  },
  State_22325_Desc = {
    Text = "Al recibir un ataque, obtén [StateArg1] puntos de fuerza temporal"
  },
  State_22325_Name = {
    Text = "Sangre de gigante"
  },
  State_22326_Desc = {
    Text = "¡Estás bloqueado! Después de lanzar, el marinero élite ganará 1 nivel de locura temporal, eliminando la marca de ola rugiente de aquella carta de comando"
  },
  State_22326_Name = {
    Text = "<CardKeyWord:marca rugiente>"
  },
  State_22328_Desc = {
    Text = "Cada vez que se usa una carta de comando con \"marca rugiente\", el número de ataques en este turno aumenta en 1"
  },
  State_22328_Name = {
    Text = "Eco de la marea furiosa"
  },
  State_22334_Desc = {
    Text = "Cada vez que juegue 1 carta de \"Golpe\", colocará [StateArg1] cartas de \"Herida\" en la parte superior del montón de robar"
  },
  State_22334_Name = {Text = "Trauma"},
  State_22404_Desc = {
    Text = "Escudos generados aumentados en [Layer] en esta batalla"
  },
  State_22404_Name = {Text = "Alerta"},
  State_22405_Desc = {
    Text = "Escudos generados aumentados en esta batalla"
  },
  State_22405_Name = {
    Text = "<PVPAlertKeywords:Alerta>"
  },
  State_22702_Desc = {
    Text = "La primera carta \"Carta\" jugada en cada turno activa un efecto adicional"
  },
  State_22702_Name = {
    Text = "<CardKeyWord:Asalto>"
  },
  State_22706_Name = {
    Text = "Marca de asalto"
  },
  State_22707_Desc = {
    Text = "Después de Jugar cartas en cada turno, aplica el Estado de Emboscada al jugador"
  },
  State_22707_Name = {
    Text = "Activador de Emboscada"
  },
  State_22721_Name = {
    Text = "Péndulo temporal \"Perdido\""
  },
  State_23405_Desc = {
    Text = "Este despertar aún no ha despertado... Cuando esté a punto de ser derribado, obtendrá un poder equivalente a su nivel actual de contraataque, recuperará vida y comenzará a luchar en su forma verdadera"
  },
  State_23405_Name = {
    Text = "No Activado"
  },
  State_23406_Desc = {
    Text = "\"El abismal\"gana [StateArg1] capas de contraataque al final de cada turno"
  },
  State_23406_Name = {
    Text = "¡Despertar de Caecus!"
  },
  State_23512_Name = {
    Text = "Concede la Ilusión de Mil Caras"
  },
  State_23514_Name = {
    Text = "Concede la Ilusión de Mil Caras"
  },
  State_23515_Name = {
    Text = "Concede la Ilusión de Mil Caras"
  },
  State_23516_Name = {
    Text = "Concede la Ilusión de Mil Caras"
  },
  State_23517_Name = {
    Text = "Otorgar BUFF al jugador"
  },
  State_23518_Desc = {
    Text = "Aplica 2 turnos de vulnerable / Aumenta 1 ataque / Aplica reducción de poder"
  },
  State_23518_Name = {
    Text = "<CardKeyWord:Selección de Intención>"
  },
  State_23519_Name = {
    Text = "Intención 2b"
  },
  State_23520_Name = {
    Text = "Intención 2c"
  },
  State_23521_Name = {
    Text = "Al descartarse, consúmela, reduce el Aliemus de todos los Despertados en [StateArg1], y Baraja 5 Cartas de \"Síntoma\" en el Mazo de robo"
  },
  State_23522_Name = {
    Text = "Al descartar, consúmela, reduce el Aliemus de todos los Despertados en [StateArg1]"
  },
  State_23524_Name = {
    Text = "Intención 3a"
  },
  State_23525_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_23525_Name = {
    Text = "No Activado"
  },
  State_23526_Name = {
    Text = "Intención 2a"
  },
  State_23527_Name = {
    Text = "Intención 3c"
  },
  State_23528_Name = {
    Text = "Intención 3b"
  },
  State_23529_Desc = {
    Text = "Aumenta fuerza / Inflige daño extra / Obtén escudo"
  },
  State_23529_Name = {
    Text = "<CardKeyWord:Selección de Intención>"
  },
  State_23530_Desc = {
    Text = "Al usar \"mil espejismos\", se requiere hacer dos elecciones de intención. Si se descartan, todos los despertadores pierden 20 locuras y barajan 5 cartas de \"síntoma\" en la pila de robo del jugador"
  },
  State_23530_Name = {
    Text = "¡Despertar de Davendale!"
  },
  State_23531_Name = {
    Text = "Concede la Ilusión de Mil Caras"
  },
  State_23532_Name = {
    Text = "Concede la Ilusión de Mil Caras"
  },
  State_23533_Desc = {
    Text = "Lavar la carta de síntoma / aplicar sangrando / reducir aliemus"
  },
  State_23533_Name = {
    Text = "<CardKeyWord:Selección de Intención>"
  },
  State_23534_Name = {
    Text = "Intención 1a"
  },
  State_23535_Name = {
    Text = "Intención 1c"
  },
  State_23536_Name = {
    Text = "Intención 1b"
  },
  State_23612_Desc = {
    Text = "Al perder 1 punto de vida, se reduce 1 capa. Cuando las capas bajan a 0, la intención se convierte en una explosión de aliemus con alto daño y desactiva el efecto de petrificación"
  },
  State_23612_Name = {
    Text = "Furia de sangre·Fin"
  },
  State_23687_Name = {
    Text = "Péndulo temporal \"mareas\""
  },
  State_23726_Desc = {
    Text = "Antes del próximo turno, evitará la muerte del Despertado una vez, máximo 1 capa"
  },
  State_23726_Name = {
    Text = "Resistencia a la muerte"
  },
  State_23732_Desc = {
    Text = "Hasta el inicio del siguiente turno, gana [Layer] <plural value=\"[Layer]\" singular=\"acumulación\" plural=\"acumulaciones\"> de <PainWord:Paciencia> por cada instancia de Daño Activo recibido."
  },
  State_23732_Name = {
    Text = "Pantano Prohibido"
  },
  State_23736_Name = {
    Text = "Número de cartas robadas en este turno"
  },
  State_23737_Name = {
    Text = "Registro de conteo de cartas"
  },
  State_23741_Name = {
    Text = "Aplicar registro de robo de carta"
  },
  State_23744_Desc = {
    Text = "Si no hay \"Muertos\" en el campo, invoca 1 \"Muerto\" al inicio del turno, aumentando su vida cada vez"
  },
  State_23744_Name = {
    Text = "Invocación de muertos"
  },
  State_23747_Name = {
    Text = "Fortalecer vida"
  },
  State_23748_Name = {
    Text = "Contador de invocación"
  },
  State_23769_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_23769_Name = {
    Text = "No Activado"
  },
  State_23771_Desc = {
    Text = "\"Ilusionista\"ya ha despertado, ten cuidado con ella usando \"fantasma\" para crear copias. Después de despertar, por cada carta que el oponente juegue, casiah gana 1 capa de \"fantasma\""
  },
  State_23771_Name = {
    Text = "¡Despertar, Kasía!"
  },
  State_23771_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_23782_Desc = {
    Text = "Obtén 10 capas de fantasma, vacía las capas de \"fantasma\" y invoca 1 clon frente a ti, pudiendo existir hasta 2 clones. El clon llevará 3 capas de <ParcloseIconKeywords:barrera> al ser invocado"
  },
  State_23782_Name = {Text = "Fantasma"},
  State_23786_Name = {
    Text = "Estado@despertador casiah telequinesis"
  },
  State_23787_Name = {
    Text = "Estado@despertador casiah@telequinesis@reducción de robar"
  },
  State_23788_Desc = {
    Text = "Al inicio del turno 3, añade una carta \"Eco del pasado: descarta todas las cartas, restaura vida y escudo al estado del final del turno anterior. Mantener, consumir.\""
  },
  State_23791_Name = {
    Text = "Mensaje de apertura"
  },
  State_23823_Name = {Text = "Bomba 1"},
  State_23825_Name = {
    Text = "Estado@Cuerpo Despertador Casiah@poof"
  },
  State_23827_Desc = {
    Text = "Al jugarlo, se pierde [DescArg1] puntos de salud máxima, y el gran mago obtiene 1 capa de \"orgulloso\" en este turno"
  },
  State_23827_Name = {
    Text = "<CardCheerKeywords:Ovación>"
  },
  State_23828_Desc = {
    Text = "El gran mago ahora disfruta mucho de su actuación, cada vez que acumula 1 capa de \"soberbia\", su efecto de habilidad se debilita y su poder se reduce [DescArg1], acumulando hasta un máximo de 5 capas"
  },
  State_23828_Name = {
    Text = "satisfecho consigo mismo"
  },
  State_23871_Desc = {
    Text = "Aumentar el hp máximo no incrementa simultáneamente el hp actual; disminuir el hp máximo eliminará el hp actual excedente, con el hp máximo mínimo siendo 1, sin reiniciarse después de la muerte."
  },
  State_23871_Name = {
    Text = "<MaxHPColour: Salud máxima>"
  },
  State_23934_Name = {
    Text = "Estado@Telequinesis Monitoreo de Mano"
  },
  State_23935_Name = {
    Text = "Estado@despertador casiah@telequinesis activa"
  },
  State_2393_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_2393_Name = {
    Text = "No Activado"
  },
  State_2394_Name = {
    Text = "Aumento de la iluminación del poder escarlata"
  },
  State_2395_Name = {
    Text = "Fiesta lejana de accesorios"
  },
  State_2395_WeaponDesc = {
    Text = "\"DEF\" causa un aumento del 30% en los escudos. Si la caída del sigilo negro del portador es mayor al 15%, \"DEF\" causará un aumento adicional del 30% en los escudos"
  },
  State_2396_Desc = {
    Text = "Daño crítico +20%. Daño a enemigos con escudo siempre será crítico"
  },
  State_2398_Desc = {
    Text = "Al recibir daño, obtiene [Layer] escudo, que aumenta con cada daño recibido y se restaura al final del turno"
  },
  State_2398_Name = {
    Text = "Barrera dimensional"
  },
  State_2398_WeaponDesc = {
    Text = "El daño activo recibido aumenta [Layer]. Cada vez que recibe daño, la herida corrosiva se expande, se restaura al inicio del turno"
  },
  State_2399_Desc = {
    Text = "Después de recuperar vida, todos los despertadores ganan 3 puntos de aliemus. Después de cada 5 veces de recuperar vida, el daño de aliemus explosivo aumenta en [Arg1] en esta batalla"
  },
  State_2400_Desc = {
    Text = "Límite de tentáculos +1. Si la vida es inferior al 50%, daño de tentáculos +[StateArg1]"
  },
  State_2400_Name = {
    Text = "Ofrenda del Pasado de la Creación"
  },
  State_2400_WeaponDesc = {
    Text = "Límite de tentáculos +1. Si la vida es inferior al 50%, daño de tentáculos +[StateArg1]"
  },
  State_2401_Desc = {
    Text = "Al comienzo del turno, añade la carta superior de tu montón de descarte a tu mano"
  },
  State_2402_Desc = {
    Text = "Al inicio del turno, por cada carta en el espacio dimensional, obtiene [Arg1] de fuerza temporal este turno"
  },
  State_2403_Desc = {
    Text = "Escudos aumentados en [Layer] en esta batalla"
  },
  State_2403_Name = {Text = "Alerta"},
  State_2403_WeaponDesc = {
    Text = "Escudos aumentados en [Layer] en esta batalla"
  },
  State_2404_Desc = {
    Text = "Al recoger, elimina 1 carta de síntomas. La tasa de grabado de suerte aumenta un 50%."
  },
  State_2405_Desc = {
    Text = "Cambiar temporalmente la potencia de cálculo de la carta"
  },
  State_2405_Name = {
    Text = "Cambiar temporalmente la potencia de cálculo de la carta"
  },
  State_2405_WeaponDesc = {
    Text = "Cambiar temporalmente la potencia de cálculo de la carta"
  },
  State_2406_Desc = {
    Text = "Al agotar el último punto de aritmética, obtienes 2 aritméticas. Se puede activar un máximo de 2 veces por turno"
  },
  State_2407_Name = {
    Text = "Valor observado"
  },
  State_2408_Name = {
    Text = "Silbato de Marinero"
  },
  State_2409_Desc = {
    Text = "En esta ronda, por cada carta de[golpe]jugada, el costo de aritmética se reduce en -1"
  },
  State_2409_Name = {
    Text = "Hoja de desafío"
  },
  State_2409_WeaponDesc = {
    Text = "En esta ronda, por cada carta de[golpe]jugada, el costo de aritmética se reduce en -1"
  },
  State_2410_Desc = {
    Text = "No se puede actuar durante 1 turno. Los enemigos que han sido petrificados no pueden ser sometidos nuevamente a efectos de petrificación"
  },
  State_2410_Name = {
    Text = "<PetrifactionIconKeywords:Petrificación>"
  },
  State_2410_WeaponDesc = {
    Text = "Hacer que el monstruo quede aturdido por un turno"
  },
  State_2411_Desc = {
    Text = "Al final del turno, aplica [Layer] capas de sangrado a nuestro equipo"
  },
  State_2411_Name = {
    Text = "Linterna de sangre"
  },
  State_2411_WeaponDesc = {
    Text = "Al final del turno, aplica [Layer] capas de sangrado a nuestro equipo"
  },
  State_2412_Desc = {
    Text = "El daño del próximo turno se duplicará"
  },
  State_2412_Name = {
    Text = "Sobreviviendo al impasse"
  },
  State_2412_WeaponDesc = {
    Text = "El daño del próximo turno se duplicará"
  },
  State_2413_Desc = {
    Text = "Locura obtenida por ataque y defensa reducida [Layer] %"
  },
  State_2413_Name = {Text = "Vacío"},
  State_2413_WeaponDesc = {
    Text = "La locura obtenida por golpear y defender es del [StateArg1]%."
  },
  State_2415_Desc = {
    Text = "Si recibiste daño en el último turno, obtén inmunidad por un turno al inicio del próximo"
  },
  State_2415_Name = {
    Text = "Adaptación"
  },
  State_2415_WeaponDesc = {
    Text = "Si recibiste daño en el último turno, obtén inmunidad por un turno al inicio del próximo"
  },
  State_2416_Desc = {
    Text = "La vida y el daño de sus monstruos invocados se duplican"
  },
  State_2416_Name = {
    Text = "\"Mundo de Cera\""
  },
  State_2416_WeaponDesc = {
    Text = "La vida y el daño de sus monstruos invocados se duplican"
  },
  State_24174_Desc = {
    Text = "Este despertar no bajará su vida por debajo de 1 debido a daño"
  },
  State_24174_Name = {
    Text = "Inmunidad a la muerte"
  },
  State_2418_Desc = {
    Text = "[exaltar] otorga a uno 30 locuras"
  },
  State_2418_Name = {
    Text = "Velo del dios de la mutación"
  },
  State_2418_WeaponDesc = {
    Text = "[exaltar] otorga a uno 30 locuras"
  },
  State_2419_Name = {
    Text = "Espejo blanco de creación"
  },
  State_2420_Desc = {
    Text = "En esta ronda, por cada carta de[defensa]jugada, el costo de aritmética se reduce en -1"
  },
  State_2420_Name = {
    Text = "Corte de precisión"
  },
  State_2420_WeaponDesc = {
    Text = "En esta ronda, por cada carta de[defensa]jugada, el costo de aritmética se reduce en -1"
  },
  State_24210_Desc = {
    Text = "Este turno, los tentáculos del Dios Rey atacan a todos los enemigos"
  },
  State_24210_Name = {
    Text = "Extremidad divina - Orden de llave"
  },
  State_24211_Desc = {
    Text = "·Al final del turno, inflige [DescArg4] veces [DescArg2] de daño a los enemigos frontales, si mata a un enemigo, el daño aumenta en [DescArg3], máx. 5 veces (actualmente [DescArg6] veces).\n·Cada vez que un Despertado usa Exaltar, realiza un ataque adicional en este turno.\n·Después de que el Guardián del secreto utiliza la Posse, el objetivo del ataque realizado en este turno se convierte en todos los enemigos, y si es en una batalla contra un jefe, el daño causado por \"Extremidad divina\" también aumentará en [DescArg5]."
  },
  State_24211_Name = {
    Text = "Extremidad divina"
  },
  State_24213_Name = {
    Text = "Si esta carta está en la mano, al final del turno se obtienen 150 puntos de energía-s"
  },
  State_24214_Desc = {
    Text = "·Al final del turno, inflige [DescArg2] de daño a los enemigos frontales"
  },
  State_24214_Name = {
    Text = "Extremidad divina"
  },
  State_24215_Desc = {
    Text = "·Al final del turno, inflige [DescArg2] de daño a los enemigos frontales, si mata a un enemigo, el daño aumenta en [DescArg3], máx. 5 veces (actual [DescArg4] veces)"
  },
  State_24215_Name = {
    Text = "Extremidad divina"
  },
  State_24217_Name = {
    Text = "Eliminar los estados <VulnerabilityIconKeywords:vulnerable>, <WeaknessIconKeywords:debilidad> y <FragileIconKeywords:frágil>"
  },
  State_24220_Name = {
    Text = "Obtén [DescArg1] puntos de escudo"
  },
  State_24222_Desc = {
    Text = "·Al final del turno, inflige [DescArg4] veces [DescArg2] puntos de daño a los enemigos frontales; si mata a un enemigo, el daño aumenta en [DescArg3], acumulándose hasta 5 veces (actualmente [DescArg5] veces).\n·Cada vez que un Despertado utiliza Exaltar, realiza un ataque adicional en este turno.\n·Cada vez que el Guardián utiliza Posse, cambia el objetivo del ataque realizado en este turno a todos los enemigos."
  },
  State_24222_Name = {
    Text = "Extremidad divina"
  },
  State_24223_Desc = {
    Text = "·Al final del turno, inflige [DescArg2] de daño a los enemigos frontales, si mata a un enemigo, el daño aumenta en [DescArg3], máx. 5 veces (actual [DescArg4] veces).\n·Cada vez que el guardián usa la llave, el objetivo del ataque realizado en este turno se convierte en todos los enemigos."
  },
  State_24223_Name = {
    Text = "Extremidad divina"
  },
  State_24224_Desc = {
    Text = "·Al final del turno, inflige [DescArg4] veces [DescArg2] puntos de daño a los enemigos frontales; si mata a un enemigo, el daño aumenta en [DescArg3], acumulándose hasta 5 veces (actual [DescArg5] veces).\n·Cada vez que un Despertado utiliza Exaltar, realiza 1 ataque adicional en este turno."
  },
  State_24224_Name = {
    Text = "Extremidad divina"
  },
  State_24226_Desc = {
    Text = "·Al final del turno, inflige [DescArg4] veces [DescArg2] de daño a los enemigos frontales, si mata a un enemigo, el daño aumenta en [DescArg3], máx. 5 veces (actual [DescArg6] veces).\n·Cada vez que un Despertado use una Explosión, este turno realiza 1 ataque adicional.\n·En la batalla contra el jefe, cada vez que el Guardián use la Posse, el daño de la \"Extremidad divina\" aumenta en [DescArg5]."
  },
  State_24226_Name = {
    Text = "Extremidad divina"
  },
  State_24227_Desc = {
    Text = "·Al final del turno, inflige [DescArg2] de daño a los enemigos frontales, si mata a un enemigo, el daño aumenta en [DescArg3], máx. 5 veces (actual [DescArg5] veces).\n·Después de que el guardián use la llave, el objetivo del ataque que se activa en este turno se convierte en todos los enemigos, y si es en una batalla contra un jefe, el daño causado por \"Extremidad divina\" también aumentará en [DescArg4]."
  },
  State_24227_Name = {
    Text = "Extremidad divina"
  },
  State_2422_Desc = {
    Text = "Obtén [StateArg1] puntos de escudo al jugarla"
  },
  State_2422_Name = {
    Text = "<Rune_6:Muralla>"
  },
  State_24245_Desc = {
    Text = "Al final del turno, revive a todos los familiares de \"Hydra\". Cada vez que muere un familiar, reduce 1 capa. Si las capas llegan a 0, \"Hydra\" cambiará de forma para la batalla final"
  },
  State_24245_Name = {
    Text = "Maestro de miles de serpientes"
  },
  State_24247_Desc = {
    Text = "El daño recibido se reduce en un 90%. Si al inicio del turno no hay capas de \"Control de Serpientes\", se elimina este estado"
  },
  State_24247_Name = {
    Text = "Barrera Serpentina"
  },
  State_2425_Desc = {
    Text = "Se consume al jugarla. Si es una carta de comando, su daño y defensa se duplican"
  },
  State_2425_Name = {
    Text = "<CardKeyWord:Disolver>"
  },
  State_2426_Desc = {
    Text = "La primera carta que juegues cada turno tiene un efecto adicional, pero solo puedes jugar 4 cartas por turno"
  },
  State_2427_Name = {
    Text = "Estado@LlavePlataSueños:ContarCorazónSangriento"
  },
  State_2428_Desc = {
    Text = "El número de <ParcloseIconKeywords:barreras> de la Flor del Mal aumenta en [Layer] capas"
  },
  State_2428_Name = {
    Text = "Barrera de resentimiento"
  },
  State_2428_WeaponDesc = {
    Text = "El número de barreras de la Flor del Mal aumenta en [Layer] capas"
  },
  State_24292_Name = {
    Text = "Movimiento de la fila trasera hacia adelante"
  },
  State_24293_Name = {
    Text = "Fila delantera hacia atrás"
  },
  State_2429_Desc = {
    Text = "Todo el daño infligido se reduce en [Layer] %"
  },
  State_2429_Name = {
    Text = "Reducción Temporal de Daño"
  },
  State_2429_WeaponDesc = {
    Text = "Todo el daño infligido se reduce en [Layer] %"
  },
  State_2430_Desc = {
    Text = "Al comienzo de la batalla, todos los aliados reciben 3 capas de [armadura cerosa]. Al final del turno, el equipo recibe [Arg1] capas de sangrado"
  },
  State_2430_Name = {
    Text = "\"Señor Cera\""
  },
  State_2430_WeaponDesc = {
    Text = "Al comienzo de la batalla, todos los aliados reciben 3 capas de [armadura cerosa]. Al final del turno, el equipo recibe [Arg1] capas de sangrado"
  },
  State_2431_Desc = {
    Text = "Equipo Único: El escudo y la recuperación de vida causados por el portador aumentan en <WeaponEffect_Num:[StateArg1]%> de su CON, el contrataque causado por el portador aumenta en <WeaponEffect_Num:[StateArg3]%, y al jugar \"DEF\", también obtendrá <RetaliateIconKeywords:contrataque> equivalente al <WeaponEffect_Num:[StateArg4]%> de la defensa del portador. Al comenzar la batalla, obtiene <PowerIconKeywords:Fuerza> equivalente al <WeaponEffect_Num:[StateArg2]%> de su CON. Si el reino actual es \"Aequor\", recibe daño de tentáculos adicional equivalente."
  },
  State_2431_WeaponDesc = {
    Text = "El escudo y la recuperación de vida causados por el portador aumentan en <WeaponEffect_Num:[DescArg1]> puntos, el contrataque causado por el portador aumenta en <WeaponEffect_Num:[StateArg3]%>, y al jugar \"DEF\", también obtiene <WeaponEffect_Num:[Counterattack:DescArg3]> capas de <RetaliateIconKeywords:contrataque>. Al comenzar la batalla, obtiene <WeaponEffect_Num:[Power:DescArg2]> puntos de <PowerIconKeywords:fuerza>. Si el reino actual es \"Aequor\", obtiene daño de tentáculos equivalente adicional."
  },
  State_2432_Desc = {
    Text = "El Daño Activo y de Tentáculos recibido +50%, elimina 1 Acumulación al final del turno."
  },
  State_2432_Name = {
    Text = "<VulnerabilityIconKeywords: vulnerable>"
  },
  State_2432_WeaponDesc = {
    Text = "Aumenta todo el daño recibido en un 50 %"
  },
  State_2433_Desc = {
    Text = "Al final de cada turno, obtén [Layer] puntos de fuerza"
  },
  State_2433_Name = {Text = "ira"},
  State_2434_Name = {
    Text = "Anillo de la sala 36 de accesorios"
  },
  State_2434_WeaponDesc = {
    Text = "Al obtener cartas del portador, su aritmética cambiará aleatoriamente entre 0-3"
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
    Text = "La fuerza y el escudo obtenidos se reducen en un 50%, dura [Layer] turnos"
  },
  State_2436_Name = {
    Text = "Maldición temporal"
  },
  State_2436_WeaponDesc = {
    Text = "Antes de que termine el turno, inmune a estados positivos"
  },
  State_2438_Desc = {
    Text = "Estado@Creación Contador de Máquina Diferencial Plateada"
  },
  State_2438_Name = {
    Text = "Estado@Creación Contador de Máquina Diferencial Plateada"
  },
  State_2438_WeaponDesc = {
    Text = "Estado@Creación Contador de Máquina Diferencial Plateada"
  },
  State_2440_Name = {
    Text = "Roba 1 carta"
  },
  State_2441_Name = {
    Text = "Obtén 1 punto de aritmética"
  },
  State_2442_Name = {
    Text = "Aplica 1 capa <VulnerabilityIconKeywords:vulnerable> a todos los enemigos"
  },
  State_2443_Name = {
    Text = "Aplica 1 capa de <WeaknessIconKeywords:debilidad> a todos los enemigos"
  },
  State_2444_Name = {
    Text = "Obtén <Energy:[DescArg1]> puntos de locura"
  },
  State_2445_Name = {
    Text = "Otros despertados obtienen <Energy:[DescArg1]> puntos de locura"
  },
  State_2446_Name = {
    Text = "Añade 1 <DerivativeCardKeywords_4:\"inspiración\"> a la pila de robo"
  },
  State_2447_Desc = {
    Text = "Equipo Único: La probabilidad de crítico y el daño crítico de las tarjetas de comando del portador, así como el blindaje, la recuperación de vida, la alienación y la fuerza aumentan en <WeaponEffect_Num:[StateArg1]%>. Si el reino actual es \"Ultra\", al liberar \"Aniquilación\" se obtienen <WeaponEffect_Num:[StateArg2]> puntos de Llave Plateada. Después de entrar en el Turno Ultra, el siguiente Posse en este turno se libera 2 veces."
  },
  State_2447_WeaponDesc = {
    Text = "La probabilidad de crítico y el daño crítico de las cartas de comando del portador, así como el blindaje, la recuperación de vida, la alienación y la fuerza causadas por las cartas de comando aumentan en <WeaponEffect_Num:[StateArg1]%>. Si el reino actual es \"Ultra\", al liberar \"Aniquilación\" se obtienen <WeaponEffect_Num:[StateArg2]> puntos de Llave Plateada. Después de entrar en el Turno Ultra, el siguiente Posse de este turno se libera 2 veces."
  },
  State_2448_Desc = {
    Text = "Las cartas no entran en la pila de descarte durante la fase de descarte, sino que se mantienen en la mano"
  },
  State_2448_Name = {
    Text = "<CardKeyWord:Retener>"
  },
  State_2449_Desc = {
    Text = "Al recibir daño real, obtiene [Layer] escudo"
  },
  State_2449_Name = {Text = "buffer"},
  State_2449_WeaponDesc = {
    Text = "Al recibir daño real, obtiene [Layer] escudo"
  },
  State_2450_Desc = {
    Text = "\"'Golpe' siempre es crítico. El daño crítico aumenta un 50%.\""
  },
  State_2451_Desc = {
    Text = "Al final del turno, otros aliados obtienen [Layer] puntos de Fuerza"
  },
  State_2451_Name = {
    Text = "\"Fuego de la Iluminación\""
  },
  State_2452_Desc = {
    Text = "Obtén [StateArg1] puntos de fuerza al jugarla"
  },
  State_2452_Name = {
    Text = "<Rune_14_High:Fuerza bruta avanzada>"
  },
  State_2453_Name = {
    Text = "Ritual fotosintético de accesorios"
  },
  State_2453_WeaponDesc = {
    Text = "Después de que comience la batalla, todas las cartas del portador obtienen retención"
  },
  State_2454_Desc = {
    Text = "Después de jugar, no pasará al montón de descarte, sino que será removido del mazo"
  },
  State_2454_Name = {
    Text = "<DepleteIconKeywords:Consumo>"
  },
  State_2454_WeaponDesc = {
    Text = "Después de jugar, la carta no irá al montón de descarte, no podrá usarse nuevamente en esta batalla"
  },
  State_24556_Name = {
    Text = "Estado@GranMagoHoudini@AñadirAplausoEspectadorAfortunado"
  },
  State_2455_Name = {
    Text = "Estado@Iluminar bailarín de llama azul 7"
  },
  State_24560_Desc = {
    Text = "Cada vez que uses una pandilla, Temporarily, la tasa crítica y el daño crítico de ramona aumentan en un 25%"
  },
  State_24560_Name = {
    Text = "Viajero de Klein"
  },
  State_24562_Desc = {
    Text = "Después de terminar el turno, obtén 1 capa de negentropía"
  },
  State_24562_Name = {
    Text = "Viajero de Penrose"
  },
  State_24564_Desc = {
    Text = "Cada vez que posea 3 capas de negentropía, jugar la carta de comando de Ronda Ramona consumirá toda la negentropía e desencadenará efectos adicionales de bucle, con un máximo de 3 capas de negentropía"
  },
  State_24564_Name = {
    Text = "Negentropía"
  },
  State_2456_Name = {
    Text = "Estado@Iluminar bailarín de llama azul 15"
  },
  State_2457_Name = {
    Text = "Roba 1 carta"
  },
  State_24584_Name = {
    Text = "Estado@NClon@Susurro1Cambio"
  },
  State_2458_Name = {
    Text = "Estado@Accesorio Contador de Efecto Abrazo Escarlata"
  },
  State_24593_Desc = {
    Text = "Cuando las capas son 0, cambia la intención a \"invocación negra\", al final del turno se reducirá en 1 capa, con un máximo de 4 capas"
  },
  State_24593_Name = {Text = "Caos"},
  State_24595_Desc = {
    Text = "Después de morir, reduce inmediatamente 1 capa de \"Caos\" de \"N\""
  },
  State_24595_Name = {Text = "Difusión"},
  State_24596_Desc = {
    Text = "Al invocar un clon de \"N\", invoca 1 clon por cada capa de \"Oscuridad\""
  },
  State_24596_Name = {Text = "oscuridad"},
  State_2460_Desc = {
    Text = "Equipo único: el daño base infligido por el portador, <IntoxicationIconKeywords:veneno> y <RetaliateIconKeywords:mostrador> aumenta <WeaponEffect_Num:[StateArg1]%>, la tasa crítica y el daño crítico aumentan <WeaponEffect_Num:[StateArg2]%>"
  },
  State_2460_WeaponDesc = {
    Text = "El daño base, <IntoxicationIconKeywords:veneno> y <RetaliateIconKeywords:contraataque> causados por el portador aumentan en <WeaponEffect_Num:[StateArg1] %>, mientras que la tasa crítica y el daño crítico aumentan en <WeaponEffect_Num:[StateArg2] %>"
  },
  State_2461_Desc = {
    Text = "Al recibir daño letal en esta batalla, resucita, recupera [Layer] puntos de vida y hace que todos los Despertados obtengan [StateArg1] puntos de locura. No se puede disipar."
  },
  State_2461_Name = {
    Text = "Ave del paraíso inmortal"
  },
  State_2463_Desc = {
    Text = "Al comienzo de la batalla, fusión embrionaria +20%. Por cada despertador que tenga su locura al máximo, la fusión embrionaria aumenta +20% adicional"
  },
  State_24640_Desc = {
    Text = "Al inicio del combate, Fusión Embrionaria +[Blood:DescArg1]. Cada vez que se activa Resistencia a la muerte, Fusión Embrionaria +[Blood:DescArg1]. Cada vez que Sorel inflige Daño, el Daño aumentado propio durante este turno se incrementa en un valor equivalente al 4% del ATQ."
  },
  State_24640_Name = {Text = "Perla"},
  State_2464_Desc = {
    Text = "Poder de cálculo de carta aumentado"
  },
  State_2464_Name = {
    Text = "Aumento permanente del poder de cálculo de la carta"
  },
  State_2464_WeaponDesc = {
    Text = "Poder de cálculo de carta aumentado"
  },
  State_24654_Desc = {
    Text = "Después de que Daffodil derrota a un enemigo de cualquier manera, la tasa de golpe crítico del equipo aumenta permanentemente en un 5% para este nivel, acumulándose hasta 5 veces. (Actualmente acumulado [DescArg1] veces)"
  },
  State_24654_Name = {
    Text = "Niebla Avide"
  },
  State_2466_Desc = {
    Text = "Hasta el inicio del siguiente turno, por cada instancia de daño recibido, el Tentáculo contraataca al atacante una vez. Daño temporal de tentáculos +[Layer]."
  },
  State_2466_Name = {
    Text = "Linaje de la Herejía"
  },
  State_24678_Name = {
    Text = "Estado@NClon@Susurro2Cambio"
  },
  State_24679_Name = {
    Text = "Estado@NClon3@Susurro6Cambio"
  },
  State_2467_Desc = {
    Text = "Estado@prologo análisis ofensivo"
  },
  State_2467_Name = {
    Text = "Estado@prologo análisis ofensivo"
  },
  State_2467_WeaponDesc = {
    Text = "Estado@prologo análisis ofensivo"
  },
  State_24680_Name = {
    Text = "Estado@NClon2@Susurro1Cambio"
  },
  State_24681_Name = {
    Text = "Estado@NClon@Susurro6Cambio"
  },
  State_24682_Name = {
    Text = "Estado@NClon3@Susurro3Cambio"
  },
  State_24683_Name = {
    Text = "Estado@NClon2@Susurro2Cambio"
  },
  State_24684_Name = {
    Text = "Estado@NClon@Susurro4Cambio"
  },
  State_24685_Name = {
    Text = "Estado@NClon@Susurro5Cambio"
  },
  State_24686_Name = {
    Text = "Estado@NClon3@Susurro5Cambio"
  },
  State_24687_Name = {
    Text = "Estado@NClon3@Susurro2Cambio"
  },
  State_24688_Name = {
    Text = "Estado@NClon2@Susurro6Cambio"
  },
  State_24689_Name = {
    Text = "Estado@NClon3@Susurro4Cambio"
  },
  State_24690_Name = {
    Text = "Estado@NClon3@Susurro1Cambio"
  },
  State_24691_Name = {
    Text = "Estado@NClon2@Susurro4Cambio"
  },
  State_24692_Name = {
    Text = "Estado@NClon2@Susurro3Cambio"
  },
  State_24693_Name = {
    Text = "Estado@NClon@Susurro3Cambio"
  },
  State_24694_Name = {
    Text = "Estado@NClon2@Susurro5Cambio"
  },
  State_2470_Desc = {
    Text = "Al recoger, se pierde permanentemente [Arg1] pts de alerta, y el daño activo infligido disfruta de un bono de poder 1x adicional"
  },
  State_24719_Desc = {
    Text = "\"@2\" ha aparecido en forma liberada, su vida se triplica"
  },
  State_24719_Name = {
    Text = "Resurrección del destino"
  },
  State_24719_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_2471_Desc = {
    Text = "Al inicio del turno, tu equipo pierde 1 de alerta"
  },
  State_2471_Name = {Text = "Corrosión"},
  State_2471_WeaponDesc = {
    Text = "Al inicio del turno, tu equipo pierde 1 de alerta"
  },
  State_24720_Desc = {
    Text = "La fuerza de la entidad desconocida aún yace bajo la charca negra, a punto de revivir completamente y recuperar la vida antes de ser derrotada, comenzando a luchar en su forma liberada"
  },
  State_24720_Name = {
    Text = "Inactividad"
  },
  State_2472_Desc = {
    Text = "Causa daño simultáneamente al escudo y a la vida, y no puede ser inmunizado"
  },
  State_2472_Name = {
    Text = "<PunctureDamagewords:Daño por Punción>"
  },
  State_2472_WeaponDesc = {
    Text = "El daño penetrante ignora el blindaje y la reducción de daño del objetivo, infligiendo daño directamente."
  },
  State_24730_Desc = {
    Text = "Aumenta temporalmente el espacio extradimensional, límite de 10. En el próximo turno extradimensional, las cartas en el espacio extradimensional temporal se colocarán en la mano y se eliminarán del espacio extradimensional temporal"
  },
  State_24730_Name = {
    Text = "<CardKeyWord:Espacio temporal>"
  },
  State_24737_Desc = {
    Text = "Al comienzo del turno, inflige sangrado al oponente, causando [StateArg1] de sangrado por cada 1 capa de destino"
  },
  State_24737_Name = {Text = "destino"},
  State_24738_Desc = {
    Text = "Cada 1 nivel de destino que esté activo causará [StateArg1] puntos de sangrado, y cada vez que se juegue 1 carta se reducirá 1 nivel de destino"
  },
  State_24738_Name = {Text = "destino"},
  State_24739_Name = {Text = "destino"},
  State_2473_Desc = {
    Text = "[DEF] Pierde 1 tentáculo, recupera [StateArg1] vida. [Golpe] Pierde [StateArg2] vida, genera 1 tentáculo"
  },
  State_2473_Name = {
    Text = "Carne del Inmortal de la Creación"
  },
  State_2473_WeaponDesc = {
    Text = "[DEF] Pierde 1 tentáculo, recupera [StateArg1] vida. [Golpe] Pierde [StateArg2] vida, genera 1 tentáculo"
  },
  State_2474_Desc = {
    Text = "Aumenta el ataque en [Layer]%"
  },
  State_2474_Name = {
    Text = "Aumento Porcentual de ATQ General"
  },
  State_2474_WeaponDesc = {
    Text = "Aumenta el ataque en [Layer]%"
  },
  State_2475_Desc = {
    Text = "Equipo Único: El daño activo infligido por el portador aumenta en <WeaponEffect_Num:[StateArg3]%.> Cada vez que se juega o se descarta una tarjeta de comando del portador, se inflige <WeaponEffect_Num:[StateArg1]%> de <IntoxicationIconKeywords:veneno> a un enemigo aleatorio. Al final del turno Ultra, hay un <WeaponEffect_Num:[StateArg2]%> de probabilidad de que todos los enemigos sean envenenados al 100%."
  },
  State_2475_WeaponDesc = {
    Text = "El daño activo infligido por el portador aumenta en <WeaponEffect_Num:[DescArg2]> puntos. Cada vez que se juega o se descarta 1 carta de comando del portador, se infligen <WeaponEffect_Num:[DescArg1]> capas de <IntoxicationIconKeywords:veneno> a un enemigo aleatorio. Al finalizar el turno Ultra, hay <WeaponEffect_Num:[StateArg2]%> de probabilidad de activar un veneno del [DescArg3]% en todos los enemigos."
  },
  State_2476_Name = {
    Text = "Estado@génesis sabio iluminar 1"
  },
  State_2478_Desc = {
    Text = "El escudo otorgado por el Nautilus se duplica"
  },
  State_2478_Name = {
    Text = "Experto en mantenimiento"
  },
  State_2478_WeaponDesc = {
    Text = "El escudo otorgado por el Nautilus se duplica"
  },
  State_2479_Desc = {
    Text = "Cada vez que el Fuego Esmeralda causa daño, aumenta en 1 capa"
  },
  State_2479_Name = {
    Text = "Conteo de reflejo esmeralda"
  },
  State_2479_WeaponDesc = {
    Text = "Cada vez que el Fuego Esmeralda causa daño, aumenta en 1 capa"
  },
  State_2480_Desc = {
    Text = "Al restablecer vida, obtienes [StateArg1] mostrador. Por cada carta que el abismo lanza, restableces 1 punto de vida"
  },
  State_2480_Name = {
    Text = "Cuerpo metamorfoseado"
  },
  State_2481_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_2_3_1"
  },
  State_2481_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_2_3_1"
  },
  State_2481_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_2_3_1"
  },
  State_2482_Desc = {
    Text = "Cuando la vida está por debajo del 50%, invocará un \"Triángulo de Corrosión\" con vida equivalente"
  },
  State_2482_Name = {Text = "Convocar"},
  State_2482_WeaponDesc = {
    Text = "Cuando la vida está por debajo del 50%, invocará un \"Triángulo de Corrosión\" con vida equivalente"
  },
  State_2486_Desc = {
    Text = "Al comienzo del turno, por cada enemigo obtienes 1 aritmética. Cuando matas un enemigo con daño activo, infliges daño equivalente al daño sobrante a los otros enemigos"
  },
  State_24879_Desc = {
    Text = "Mil años pasan, diez mil años pasan, esperan en las ruinas eternas. Al morir, reduce inmediatamente 1 nivel de \"Caos\" de \"N\" y otorga a \"N\" [DescArg1] puntos de escudo y [DescArg2] puntos de fuerza"
  },
  State_24879_Name = {
    Text = "Clon Ilusorio"
  },
  State_2488_Desc = {
    Text = "Cada vez que juegas una carta que no sea de Despertado, el Despertado con menos locura obtiene 10 locura"
  },
  State_2489_Desc = {
    Text = "La tasa crítica aumenta un 10%. Después del primer crítico en cada turno, la tasa crítica aumenta un 20% adicional; después del tercer crítico en cada turno, el daño crítico aumenta un 50% adicional"
  },
  State_2490_Desc = {
    Text = "Cada capa añade 1 ataque, pierde 1 capa al recibir daño, pierde todas al final del turno"
  },
  State_2490_Name = {Text = "Oración"},
  State_2491_Desc = {
    Text = "Al recuperar vida, obtiene un escudo equivalente"
  },
  State_2491_Name = {
    Text = "Endurecimiento temporal"
  },
  State_2492_Desc = {
    Text = "Inmunidad al primer daño activo cada turno"
  },
  State_2492_Name = {Text = "Firmemente"},
  State_2492_WeaponDesc = {
    Text = "Inmunidad al primer daño activo cada turno"
  },
  State_2493_Desc = {
    Text = "El daño activo causado disminuye en [Layer] puntos"
  },
  State_2493_Name = {Text = "STR▼"},
  State_2494_Desc = {
    Text = "Estado@PrólogoLocura0_1_4_1"
  },
  State_2494_Name = {
    Text = "Estado@PrólogoLocura0_1_4_1"
  },
  State_2494_WeaponDesc = {
    Text = "Estado@PrólogoLocura0_1_4_1"
  },
  State_2495_Desc = {
    Text = "Estado@PrólogoLocura0_1_4_2"
  },
  State_2495_Name = {
    Text = "Estado@PrólogoLocura0_1_4_2"
  },
  State_2495_WeaponDesc = {
    Text = "Estado@PrólogoLocura0_1_4_2"
  },
  State_24968_Desc = {
    Text = "Al inicio del combate, Fusión Embrionaria +[Blood:DescArg2]. Cada vez que se activa Resistencia a la muerte, Fusión Embrionaria +[Blood:DescArg2]. Cada vez que Sorel inflige Daño, el Daño aumentado propio durante este turno se incrementa en [DescArg1] puntos."
  },
  State_24968_Name = {Text = "Perla"},
  State_2496_Desc = {
    Text = "Al inicio del turno, recupera [Arg1] vida. Si la vida es menor al 50%, recupera [Arg2]"
  },
  State_2496_Name = {
    Text = "Sangre Bendecida"
  },
  State_24976_Desc = {
    Text = "\"La sirvienta del brillo lunar\" ha despertado, ¡ten cuidado con los peligros de los platos especiales!"
  },
  State_24976_Name = {
    Text = "¡Karen despierta!"
  },
  State_24976_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_24977_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_24977_Name = {
    Text = "No Activado"
  },
  State_2497_Desc = {
    Text = "Lily imitará la primera carta de comando jugada por el jugador cada turno. Si es una carta de ataque, Lily obtiene +1 ataques, si es una carta de defensa, Lily recibe un escudo del 10% de vida, si es otra carta de comando, Lily tampoco sabe qué sucedió y colocará una pústula aquí"
  },
  State_2497_Name = {
    Text = "¡Lili despierta!"
  },
  State_2497_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_2498_Name = {
    Text = "Conejo maldito de accesorios"
  },
  State_2498_WeaponDesc = {
    Text = "El portador aumenta el escudo y la curación en un 6%. Si la maestría del portador en el dominio es mayor a 50, el escudo y la curación aumentan un 6% adicional"
  },
  State_2499_Name = {
    Text = "Maldición estancada"
  },
  State_2500_Desc = {
    Text = "Cada vez que causa daño real, añade envenenamiento"
  },
  State_2500_Name = {Text = "Toxina"},
  State_2501_Desc = {
    Text = "Equipo Único: El límite de vida del equipo aumenta en 10%. La curación y el escudo infligidos por el portador aumentan en <WeaponEffect_Num:[StateArg3]%. Después de jugar el \"golpear\" del portador, recupera <WeaponEffect_Num:[StateArg1]%> de vida perdida. Tras jugar la \"defensa\" del portador, obtiene un escudo equivalente al <WeaponEffect_Num:[StateArg2]%> de la vida actual. Este efecto solo puede activarse una vez por turno cada uno."
  },
  State_2501_Name = {
    Text = "Nacimiento de un alma"
  },
  State_2501_WeaponDesc = {
    Text = "El límite de vida del equipo aumenta en un 10%. La curación y el escudo infligidos por el portador aumentan en <WeaponEffect_Num:[StateArg3]%. Tras jugar el \"golpear\" del portador, recupera [StateArg1]%(<WeaponEffect_Num:[Heal:DescArg1]>) de la vida perdida. Tras jugar la \"defensa\" del portador, obtiene [StateArg1]%(<WeaponEffect_Num:[Block:DescArg2]>) de escudo basado en la vida actual. Este efecto puede activarse un máximo de 1 vez por turno."
  },
  State_2502_Desc = {
    Text = "Todo el Daño Activo y Daño de tentáculos infligido -50%."
  },
  State_2502_Name = {
    Text = "Debilitación de extinción"
  },
  State_2502_WeaponDesc = {
    Text = "Todo el daño causado disminuye en 50 %"
  },
  State_2503_Desc = {
    Text = "Equipo Único: El daño base causado por las cartas del portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Al comenzar el turno, hay un <WeaponEffect_Num:[StateArg2]%> de probabilidad de generar una carta aleatoria del portador en la mano, con consumo adicional. Si el reino actual es \"Carne y sangre\", al usar \"Embrión\" sobre el portador, la tasa crítica del daño causado por la próxima carta de golpe del portador en este turno aumenta en <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_2503_WeaponDesc = {
    Text = "El daño base causado por las cartas del portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Al comienzo del turno, hay un <WeaponEffect_Num:[StateArg2]%> de probabilidad de generar una carta aleatoria del portador en la mano, con un costo adicional. Si el dominio actual es \"Carne y sangre\", al usar \"Embrión\" en el portador, la probabilidad de crítico del próximo daño causado por la carta de golpe del portador en este turno aumenta en <WeaponEffect_Num:+[StateArg3]%."
  },
  State_2504_Desc = {
    Text = "\"El golpe\" obtiene 2 puntos de aritmética y descarta aleatoriamente 1 carta; \"DEF\" roba 2 cartas y pierde 1 punto de aritmética"
  },
  State_25056_Desc = {
    Text = "Cada vez que se gaste aritmética, Karen obtendrá [Layer] puntos de poder temporal"
  },
  State_25056_Name = {
    Text = "Bien comido y bien bebido"
  },
  State_25057_Desc = {
    Text = "Cada vez que se gaste aritmética, Karen obtendrá [StateArg1] puntos de poder temporal, eliminando 1 capa al final del turno"
  },
  State_25057_Name = {
    Text = "Bien comido y bien bebido"
  },
  State_2505_Name = {
    Text = "Oda de abril de accesorios"
  },
  State_2505_WeaponDesc = {
    Text = "Después de que comience la batalla, si la clase del portador es ultra, el poder de ataque aumenta un 25%"
  },
  State_2507_Desc = {
    Text = "Al recoger, se aumenta la salud máxima en un 100%, y al inicio del turno, se pierde [Arg1] puntos de vida"
  },
  State_2509_Name = {
    Text = "Estado@Dominio de Dominio Genérico"
  },
  State_2511_Desc = {
    Text = "Estado@PrólogoEnseñanzaLlave"
  },
  State_2511_Name = {
    Text = "Estado@PrólogoEnseñanzaLlave"
  },
  State_2511_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_2"
  },
  State_2512_Desc = {
    Text = "Al jugar una carta con un consumo de aritmética de 3 o más, roba 1 carta y obtén 1 punto de aritmética"
  },
  State_2514_Desc = {
    Text = "Escudos reducidos en [Layer] en esta batalla"
  },
  State_2514_Name = {
    Text = "Vigilancia reducida"
  },
  State_2514_WeaponDesc = {
    Text = "Escudos reducidos en [Layer] en esta batalla"
  },
  State_2515_Desc = {
    Text = "[golpe] aplica [StateArg1] capas de veneno a todos los enemigos"
  },
  State_2515_Name = {
    Text = "Neurotoxina de creación"
  },
  State_25163_Desc = {
    Text = "Es tan difícil de atrapar como la niebla"
  },
  State_25163_Name = {
    Text = "Sombra del pasado"
  },
  State_25165_Desc = {
    Text = "Efecto adicional exclusivo de las cartas de comando de Ronda Ramona que se activa al poseer 3 capas de negentropía. El reciclaje se transfiere a la próxima batalla."
  },
  State_25165_Name = {
    Text = "<TimeBeacon:Bucle>"
  },
  State_25166_Desc = {
    Text = "Cada vez que posea 3 capas de negentropía, jugar la carta de comando de Ronda Ramona consumirá toda la negentropía e desencadenará efectos adicionales de bucle, con un máximo de 3 capas de negentropía"
  },
  State_25166_Name = {
    Text = "<TimeBeacon2:negentropía>"
  },
  State_2516_Desc = {
    Text = "No se puede jugar"
  },
  State_2516_Name = {
    Text = "No se puede ejecutar"
  },
  State_2516_WeaponDesc = {
    Text = "No se puede jugar la carta"
  },
  State_25179_Name = {
    Text = "Juicio de locura"
  },
  State_2517_Desc = {
    Text = "Después de que nuestro equipo libera el arrebato de locura, pierde poder en ese turno. Una vez por turno"
  },
  State_2517_Name = {
    Text = "Temor a la locura"
  },
  State_25181_Name = {
    Text = "Efecto de Preservación de Reencarnación"
  },
  State_2518_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_1_3"
  },
  State_2518_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_1_3"
  },
  State_2518_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_1_3"
  },
  State_25194_Desc = {
    Text = "Después de morir, aumenta el escudo de \"N\" en [DescArg1] puntos y la fuerza permanente en [DescArg2] puntos"
  },
  State_2519_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_1_3"
  },
  State_2519_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_1_3"
  },
  State_2519_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_1_3"
  },
  State_25204_Name = {
    Text = "Estado@NClon2@Intención"
  },
  State_25205_Name = {
    Text = "Estado@NClon3@Intención"
  },
  State_25206_Name = {
    Text = "Estado@N@AñadirClonN"
  },
  State_25207_Name = {
    Text = "Estado@NClon@Intención"
  },
  State_2520_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_1_2"
  },
  State_2520_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_1_2"
  },
  State_2520_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_1_2"
  },
  State_2522_Desc = {
    Text = "Helo ya ha despertado, su intensidad de ataque y deseo se incrementarán"
  },
  State_2522_Name = {
    Text = "Despertar de Shiro"
  },
  State_2523_Desc = {
    Text = "Al empezar turno impar, gana [Arg1] puntos de fuerza. Al empezar turno par, gana [Arg2] puntos de alerta"
  },
  State_2524_Desc = {
    Text = "Al comenzar la batalla, obtén 1 punto de poder"
  },
  State_2524_Name = {
    Text = "Renombre lejano"
  },
  State_2525_Desc = {
    Text = "ATQs -1, ganas [Layer] de fuerza"
  },
  State_2525_Name = {
    Text = "Dissipación"
  },
  State_2527_Name = {
    Text = "Bonificación de Fuerza Escarlata"
  },
  State_2528_Desc = {
    Text = "Al jugar una carta con un consumo de aritmética de 3, roba 1 carta y obtén 2 de aritmética"
  },
  State_2529_Desc = {
    Text = "Este turno, el daño crítico aumenta [Layer] %"
  },
  State_2529_Name = {
    Text = "Daño crítico temporal"
  },
  State_2529_WeaponDesc = {
    Text = "Este turno, el daño crítico aumenta [Layer] %"
  },
  State_2531_Desc = {
    Text = "Cada [Damage:StateArg2] veces que el Fuego Esmeralda causa daño, obtienes una carta de consumo [Llama Verde]"
  },
  State_2531_Name = {
    Text = "Reflejo Esmeralda"
  },
  State_2531_WeaponDesc = {
    Text = "Cada [Damage:StateArg2] veces que el Fuego Esmeralda causa daño, obtienes una carta de consumo [Llama Verde]"
  },
  State_2532_Name = {
    Text = "Palpitación escarlata de accesorios"
  },
  State_2534_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_3_3"
  },
  State_2534_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_3_3"
  },
  State_2534_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_3_3"
  },
  State_2535_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_3_2"
  },
  State_2535_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_3_2"
  },
  State_2535_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_3_2"
  },
  State_2536_Name = {
    Text = "Estado@tarjeta de golpe temporal aumento de daño crítico"
  },
  State_2537_Desc = {
    Text = "Al aplicar el escudo con la hoja de fantasía, obtienes [StateArg2] puntos de alerta temporal"
  },
  State_2537_Name = {
    Text = "Insight del campo de batalla"
  },
  State_2537_WeaponDesc = {
    Text = "Al aplicar el escudo con la hoja de fantasía, obtienes [StateArg2] puntos de alerta temporal"
  },
  State_2538_Desc = {
    Text = "Al jugar, obtén [StateArg1] de <RetaliateIconKeywords:Contrataque>, luego inflige Daño Verdadero a todos los enemigos igual al [StateArg2]% de tu <RetaliateIconKeywords:Contrataque>."
  },
  State_2538_Name = {
    Text = "<Rune_9_High: punta avanzada>"
  },
  State_25391_Desc = {
    Text = "Un Despertado ya ha sido elegido como \"Espectador Afortunado\", todas sus cartas tienen el efecto \"Aplauso\""
  },
  State_25391_Name = {
    Text = "Audiencia afortunada"
  },
  State_25392_Desc = {
    Text = "Al jugarlo, se pierde el 2% de la salud máxima, y el gran mago obtiene 1 capa de \"orgulloso\" en este turno"
  },
  State_25392_Name = {
    Text = "<CardCheerKeywords:Ovación>"
  },
  State_25401_Desc = {
    Text = "Esta carta en mano aumenta el límite de cartas en mano +1"
  },
  State_25401_Name = {
    Text = "Ignorar límite de cartas en mano"
  },
  State_25403_Desc = {
    Text = "Daño de tentáculos -50%, obtén [Layer] de escudo por cada daño de tentáculo causado"
  },
  State_25403_Name = {
    Text = "Mar tranquilo"
  },
  State_25405_Desc = {
    Text = "Esta carta siempre estará en la mano"
  },
  State_25405_Name = {
    Text = "Conservar permanentemente"
  },
  State_25406_Desc = {
    Text = "Este turno, no se puede cambiar la forma de los tentáculos"
  },
  State_25406_Name = {
    Text = "Locura del océano profundo·Limitada"
  },
  State_25407_Desc = {
    Text = "Daño de tentáculos +25%, cantidad de tentáculos -1 al final del turno"
  },
  State_25407_Name = {
    Text = "Locura del océano profundo"
  },
  State_25415_Desc = {
    Text = "Después de liberar la orden clave, obtén [Layer] puntos de energía clave"
  },
  State_25415_Name = {
    Text = "Energía temporal de caos desbordante"
  },
  State_25417_Name = {Text = "Bomba 3"},
  State_25418_Name = {Text = "Bomba 2"},
  State_2542_Name = {
    Text = "Contador de apéndice sin nombre de creación"
  },
  State_2543_Name = {
    Text = "Estado@Nivel2_14Batalla8Burbuja1"
  },
  State_2544_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo"
  },
  State_2544_Name = {
    Text = "Estado@PrólogoMonstruoPasivo"
  },
  State_2544_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo"
  },
  State_2545_Desc = {
    Text = "Al comienzo de la batalla, fusión embrionaria +20%. Por cada despertador que tenga su locura al máximo, la fusión embrionaria aumenta +20% adicional"
  },
  State_2547_Desc = {
    Text = "Al comienzo del turno, añade una \"tridente\" con [Arg1] de poder obtenida en este turno a tu mano. Después de liberar exaltar, aumenta el poder de todas las cartas \"tridente\" en tu mano en [Arg2]"
  },
  State_2548_Desc = {
    Text = "Inmunidad a una muerte, recupera 50 de vida al activarse y se desactiva permanentemente"
  },
  State_2548_Name = {
    Text = "Muñeco sustituto de creación"
  },
  State_2548_WeaponDesc = {
    Text = "Inmunidad a una muerte, recupera 50 de vida al activarse y se desactiva permanentemente"
  },
  State_2549_Desc = {
    Text = "Reduce el daño causado por habilidades activas y de tentáculo"
  },
  State_2549_Name = {
    Text = "<ExhaustionIconKeywords: fuerza reducida>"
  },
  State_2549_WeaponDesc = {
    Text = "Cada capa de agotamiento reduce el daño y el daño de tentáculos en 1 punto"
  },
  State_2550_Desc = {
    Text = "Al robar, te hace vulnerable por 1 turno. Al usar, debilita a todos los enemigos por 1 turno. No se puede vender"
  },
  State_2550_Name = {
    Text = "Estado Maldición Colapso"
  },
  State_2550_WeaponDesc = {
    Text = "Al robar, te hace vulnerable por 1 turno. Al usar, debilita a todos los enemigos por 1 turno. No se puede vender"
  },
  State_2552_Desc = {
    Text = "Las cartas no entran en la pila de descarte durante la fase de descarte, sino que se mantienen en la mano"
  },
  State_2552_Name = {
    Text = "<RetainIconKeywords:Retener>"
  },
  State_2552_WeaponDesc = {
    Text = "Las cartas no entran en la pila de descarte durante la fase de descarte, sino que se mantienen en la mano"
  },
  State_2553_Desc = {
    Text = "Al comienzo del turno, obtén 1 de aritmética"
  },
  State_2553_Name = {
    Text = "Aritmética de creación de arkanas"
  },
  State_2553_WeaponDesc = {
    Text = "Al comienzo del turno, obtén 1 de aritmética"
  },
  State_2554_Name = {
    Text = "Correo matutino de Putney"
  },
  State_2556_Desc = {
    Text = "Al reducirse la salud, obtén un escudo equivalente al [Layer]% del valor reducido"
  },
  State_2556_Name = {
    Text = "Escudo de sangre"
  },
  State_2556_WeaponDesc = {
    Text = "Al reducirse la salud, obtén un escudo equivalente al [Layer]% del valor reducido"
  },
  State_2557_Desc = {
    Text = "Al inicio del próximo turno, obtén [Layer] puntos de escudo"
  },
  State_2557_Name = {
    Text = "Escudo de dolor y placer"
  },
  State_2558_Desc = {
    Text = "Cuando la vida esté por debajo del 50% ([StateArg1]), se dividirá en 2 cuerpos disueltos con vida equivalente"
  },
  State_2558_Name = {Text = "Dividir"},
  State_2558_WeaponDesc = {
    Text = "Cuando la vida esté por debajo del 50% ([StateArg1]), se dividirá en 2 esculturas de cera de tipo II con vida equivalente"
  },
  State_2559_Desc = {
    Text = "Al recibir un ataque, pierde [Layer] puntos de fuerza temporal"
  },
  State_2559_Name = {
    Text = "El Precio del Impulso"
  },
  State_2560_Desc = {
    Text = "Al inicio del próximo turno, obtén [Layer] escudo"
  },
  State_2560_Name = {
    Text = "Opus de Aislamiento"
  },
  State_2560_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén [Layer] escudo"
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
    Text = "Estado@Capítulo Tres_Resonancia 1_Marca"
  },
  State_2563_Desc = {
    Text = "Cada vez que juegues la décima carta, aumenta el daño de tentáculo en 2 y hace que todos los tentáculos ataquen una vez"
  },
  State_2563_Name = {
    Text = "Tridente de creación"
  },
  State_2563_WeaponDesc = {
    Text = "Cada vez que juegues la décima carta, aumenta el daño de tentáculo en 2 y hace que todos los tentáculos ataquen una vez"
  },
  State_2564_Desc = {
    Text = "Todos los escudos obtenidos se reducen en un [DescArg1]%"
  },
  State_2564_Name = {
    Text = "<FragileColour:Frágil>"
  },
  State_2564_WeaponDesc = {
    Text = "Todos los escudos obtenidos se reducen en un 33%"
  },
  State_2565_Name = {
    Text = "Abrazo escarlata de accesorios"
  },
  State_2565_WeaponDesc = {
    Text = "Cuando el portador causa daño, obtiene 20 puntos de energía-llave. Si causa daño crítico, en su lugar obtiene 50 puntos de energía-llave, y se puede activar un máximo de 3 veces por turno"
  },
  State_2566_Desc = {
    Text = "Después de recibir 3 ataques en un turno, obtén 1 carga de Locura Temporal."
  },
  State_2566_Name = {
    Text = "\"Dulce Dolor\""
  },
  State_2567_Desc = {
    Text = "Ha recibido [Layer] de Daño; al alcanzar 3 veces, \"Malevolencia Dulce\" obtiene 1 carga de Locura para este turno."
  },
  State_2567_Name = {
    Text = "Número de \"Dulce Dolor\""
  },
  State_2567_WeaponDesc = {
    Text = "Has recibido daño [Layer] veces, al llegar a 3 veces, \"Demonio Dulce\" obtiene 1 capa de locura en este turno"
  },
  State_2569_Desc = {
    Text = "El efecto de bonificación de la recomendación de dominio aumenta un 50%, al inicio del nivel tu maestría en dominios aumenta en 100"
  },
  State_2569_Name = {
    Text = "Estado@LlavePlataSueños:SeparaciónAdaptativa"
  },
  State_2570_Desc = {
    Text = "Al jugar, roba [StateArg1] cartas"
  },
  State_2570_Name = {
    Text = "<Rune_3:Destreza>"
  },
  State_2571_Desc = {
    Text = "Por cada despertador de profesión [chaos] en el equipo, la salud máxima (incompleta), defensa y ataque del equipo aumentan un 50%"
  },
  State_2571_Name = {
    Text = "Bonificación de caos"
  },
  State_2571_WeaponDesc = {
    Text = "Por cada despertador de profesión [chaos] en el equipo, la salud máxima (incompleta), defensa y ataque del equipo aumentan un 50%"
  },
  State_2572_Desc = {
    Text = "Al jugar, <EmbryoFusionIconKeywords:Fusión Embrionaria> +[StateArg1]."
  },
  State_2572_Name = {
    Text = "<Rune_12:Seducción>"
  },
  State_2573_Desc = {
    Text = "Posee 5 capas de [Mecha]. Al jugar una carta, reduce una capa. Al llegar a 0, explota causando daño igual a 2.5 veces el ataque"
  },
  State_2573_Name = {
    Text = "Granada explosiva"
  },
  State_2573_WeaponDesc = {
    Text = "Posee 5 capas de [Mecha]. Al jugar una carta, reduce una capa. Al llegar a 0, explota causando daño igual a 2.5 veces el ataque"
  },
  State_2574_Desc = {
    Text = "Daño crítico +50%. Si no atacas en un turno, el siguiente será un crítico seguro"
  },
  State_2574_Name = {
    Text = "Estado@LlavePlataSueños:Danza"
  },
  State_2575_Desc = {
    Text = "Equipo Único: Al comenzar la batalla, por cada reliquia que posea, la probabilidad de crítico de las cartas de comando del portador aumenta en [StateArg1]%. Después de que el portador libere la explosión de locura, lanza un dado de 4 caras; el portador obtiene <WeaponEffect_Num:[StateArg2]> veces el valor del dado en locura y daño crítico temporal. Si obtiene un 4 o más, los otros Despertados también reciben la mitad."
  },
  State_2575_WeaponDesc = {
    Text = "Al comenzar la batalla, por cada reliquia que poseas, la tasa crítica de las cartas de comando del portador aumenta en [StateArg1]%. Después de que el portador libera la exaltación, lanza un dado de 4 caras; el portador obtiene <WeaponEffect_Num:[StateArg2]> veces el número obtenido en el dado en aliemus y daño crítico temporal. Si lanza un 4 o más, los otros Despertados también obtienen la mitad."
  },
  State_2576_Desc = {
    Text = "Cada vez que una carta entra en espacio ultra, reduce su consumo de aritmética en -1"
  },
  State_2579_Desc = {
    Text = "Aumenta las instancias de Daño Activo infligido en [Layer] durante este turno."
  },
  State_2579_Name = {
    Text = "Locura Temporal"
  },
  State_2580_Desc = {
    Text = "Cada vez que la carta de la Cazadora de Cráneos entre o salga del espacio ultra, ganar 1 de aritmética"
  },
  State_2580_Name = {
    Text = "Proyección dimensional"
  },
  State_2581_Desc = {
    Text = "La recarga de llave de plata de todos los despertadores aumenta en 30. Después de liberar la llave, baraja 3 cartas <DerivativeCardKeywords_4:\"inspiración\"> en tu mazo"
  },
  State_2581_Name = {
    Text = "Estado@péndulo crono introspectiva"
  },
  State_2582_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_2582_Name = {
    Text = "Estado@Prototipo de Cañón Láser Locura"
  },
  State_2583_Desc = {
    Text = "Al recibir daño activo, añade una capa de conteo al equipo"
  },
  State_2583_Name = {
    Text = "Estado@cuchilla de venganza cuenta de daño por decapitación"
  },
  State_2583_WeaponDesc = {
    Text = "Al recibir daño activo, añade una capa de conteo al equipo"
  },
  State_2584_Desc = {
    Text = "Cada vez que se reinicia el mazo, obtienes [Arg1] fuerza"
  },
  State_2586_Desc = {
    Text = "Todos los escudos obtenidos se reducen en un 25%, se elimina 1 capa al final del turno"
  },
  State_2586_Name = {
    Text = "<FragileIconKeywords: Frágil>"
  },
  State_2586_WeaponDesc = {
    Text = "Todos los escudos obtenidos se reducen en un 25%"
  },
  State_2587_Desc = {
    Text = "El daño de la herida se duplica. Cada vez que inflige daño real, obtiene [Layer] puntos de escudo"
  },
  State_2587_Name = {
    Text = "\"Diente del Devorador Celestial\""
  },
  State_2587_WeaponDesc = {
    Text = "El daño de la herida se duplica. Cada vez que inflige daño real, obtiene [Layer] puntos de escudo"
  },
  State_2588_Desc = {
    Text = "Recibe [Layer] <FixedDamage:DMG Puro> y elimina este Estado al final del turno. Al restaurar PV, elimina Acumulaciones de Sangrar iguales al doble de la cantidad restaurada."
  },
  State_2588_Name = {
    Text = "Perpetuo <BleedingColour: sangrando>"
  },
  State_2588_WeaponDesc = {
    Text = "Después de terminar el turno, recibe [Layer] de daño y elimina este estado; cada curación puede reducir las capas a la mitad"
  },
  State_2589_Name = {
    Text = "Gemelos distorsionados negros de accesorios"
  },
  State_2589_WeaponDesc = {
    Text = "Al iniciar la ronda impar, agrega una \"golpe\" de un equipador con ilusión y agotamiento a tu mano"
  },
  State_2590_Desc = {
    Text = "Obtener 10 sellos negros al moverse"
  },
  State_2590_Name = {
    Text = "Bolsa sin fondo de Creación"
  },
  State_2590_WeaponDesc = {
    Text = "Obtener 10 sellos negros al moverse"
  },
  State_2592_Desc = {
    Text = "Por cada punto de vida perdido, elimina 1 capa. Al llegar a 0 capas, obtiene un escudo de [DescArg1]"
  },
  State_2592_Name = {
    Text = "Barrera dimensional"
  },
  State_2593_Name = {
    Text = "Estado@Himno de Sangre Escarlata y Arena"
  },
  State_2594_Desc = {
    Text = "Al causar daño real, obtén escudo"
  },
  State_2594_Name = {
    Text = "\"Diente del Devorador Celestial\""
  },
  State_2594_WeaponDesc = {
    Text = "Al causar daño real, obtén escudo"
  },
  State_2595_Desc = {
    Text = "Cada daño otorga [StateArg2] de fuerza temporal"
  },
  State_2595_Name = {
    Text = "Espada de la Reina Sabia"
  },
  State_2597_Desc = {
    Text = "Después de que comience el turno, obtén [Layer] puntos de escudo"
  },
  State_2597_Name = {
    Text = "Escudo de latencia"
  },
  State_2597_WeaponDesc = {
    Text = "Después de que comience el turno, obtén [Layer] puntos de escudo"
  },
  State_2600_Desc = {
    Text = "Cada vez que pierdes vida, el Despertado con menos locura obtiene 10 locura. Cada vez que pierdes vida 5 veces, obtienes 1 capa de barrera"
  },
  State_2600_Name = {
    Text = "Péndulo Temporal \"Análisis\""
  },
  State_2601_Desc = {
    Text = "En turnos pares, daño recibido -50%, daño infligido +33%"
  },
  State_2601_Name = {Text = "Caprichoso"},
  State_2601_WeaponDesc = {
    Text = "En turnos pares, daño recibido -50%, daño infligido +33%"
  },
  State_2602_Desc = {
    Text = "¡Estás marcado! Al jugar, el Fanático Eterno obtiene [StateArg1] puntos de fuerza temporal, y se elimina la marca de inmersión de esta orden"
  },
  State_2602_Name = {
    Text = "<CardKeyWord:Marca de la Profundidad>"
  },
  State_2602_WeaponDesc = {
    Text = "Al jugar la carta, el élite de los Profundos recibe [StateArg1] puntos de fuerza temporal"
  },
  State_2603_Desc = {
    Text = "Si tienes \"Embrion\" en tu mano, gasta todos los \"Embrion\", cada uno activa el efecto posterior una vez"
  },
  State_2603_Name = {
    Text = "<UnlimitedDevouredIconKeywords:Devoración Infinita>"
  },
  State_2604_Desc = {
    Text = "La tasa crítica se incrementa en [Layer] % en esta ronda"
  },
  State_2604_Name = {
    Text = "Tasa de Crítico Temporal"
  },
  State_2604_WeaponDesc = {
    Text = "La tasa crítica se incrementa en [Layer] % en esta ronda"
  },
  State_2605_Desc = {
    Text = "Cuando la vida esté por debajo del 95% ([StateArg1]), se dividirá en 2 \"Obras experimentales\" con vida igual"
  },
  State_2605_Name = {Text = "Dividir"},
  State_2605_WeaponDesc = {
    Text = "Cuando la vida esté por debajo del 30% ([StateArg1]), se dividirá en 3 esculturas de cera de tipo II con vida equivalente"
  },
  State_2606_Desc = {
    Text = "Cuando la vida esté por debajo del 90% ([StateArg1]), se dividirá en 2 \"Obras experimentales\" con vida igual"
  },
  State_2606_Name = {Text = "Dividir"},
  State_2606_WeaponDesc = {
    Text = "Cuando la vida esté por debajo del 30% ([StateArg1]), se dividirá en 3 esculturas de cera de tipo II con vida equivalente"
  },
  State_2607_Desc = {
    Text = "Al terminar la batalla, recupera 5 de vida"
  },
  State_2607_Name = {
    Text = "Sirvienta lunar iluminar 3"
  },
  State_2607_WeaponDesc = {
    Text = "Al terminar la batalla, recupera 5 de vida"
  },
  State_2609_Desc = {
    Text = "Cuando la vida esté por debajo del 30% ([StateArg1]), se dividirá en 2 \"Obras experimentales\" con vida igual"
  },
  State_2609_Name = {Text = "Dividir"},
  State_2609_WeaponDesc = {
    Text = "Cuando la vida esté por debajo del 30% ([StateArg1]), se dividirá en 3 esculturas de cera de tipo II con vida equivalente"
  },
  State_2610_Desc = {
    Text = "Cuando la vida esté por debajo del 70% ([StateArg1]), se dividirá en 2 \"Obras experimentales\" con vida igual"
  },
  State_2610_Name = {Text = "Dividir"},
  State_2610_WeaponDesc = {
    Text = "Cuando la vida esté por debajo del 30% ([StateArg1]), se dividirá en 3 esculturas de cera de tipo II con vida equivalente"
  },
  State_2611_Desc = {
    Text = "Cuando la vida esté por debajo del 50% ([StateArg1]), se dividirá en 2 \"Obras experimentales\" con vida igual"
  },
  State_2611_Name = {Text = "Dividir"},
  State_2611_WeaponDesc = {
    Text = "Cuando la vida esté por debajo del 30% ([StateArg1]), se dividirá en 3 esculturas de cera de tipo II con vida equivalente"
  },
  State_2612_Desc = {
    Text = "Imitación del Antiguo"
  },
  State_2612_Name = {
    Text = "Imitación del Antiguo"
  },
  State_2612_WeaponDesc = {
    Text = "Imitación del Antiguo"
  },
  State_2614_Desc = {
    Text = "Equipo Único: Al jugar la tarjeta de comando del portador, hay un <WeaponEffect_Num:[StateArg1]%> de probabilidad de volver a agregarla a la mano desde el mazo de descarte. Este efecto solo se activa una vez por turno."
  },
  State_2614_WeaponDesc = {
    Text = "Al jugar la carta de comando del equipador, hay un <WeaponEffect_Num:[StateArg1]%> de probabilidad de volver a agregarla a la mano desde el montón de descarte. Este efecto sólo se activa una vez por turno"
  },
  State_2617_Desc = {
    Text = "Al inicio del próximo turno, roba cartas adicionales [DescArg1]."
  },
  State_2617_Name = {
    Text = "Síntoma: Excitación"
  },
  State_2619_Desc = {
    Text = "Daño activo reducido en [Layer] en esta batalla"
  },
  State_2619_Name = {Text = "STR▼"},
  State_2619_WeaponDesc = {
    Text = "Daño reducido en [Layer] en esta batalla"
  },
  State_2620_Desc = {
    Text = "Cuchilla Oxidada de la Creación"
  },
  State_2620_Name = {
    Text = "Lanceta oxidada"
  },
  State_2623_Desc = {
    Text = "Al comienzo del turno, obtén 1 aritmética"
  },
  State_2624_Desc = {
    Text = "Al jugar, todos los enemigos pierden [StateArg1] de fuerza temporal"
  },
  State_2624_Name = {
    Text = "<Rune_18:Agotamiento>"
  },
  State_2625_Desc = {
    Text = "Tu efecto de salto se activa dos veces. Al entrar en el turno extradimensional, todos los enemigos obtienen 5 puntos de fuerza temporal"
  },
  State_2625_Name = {
    Text = "Lámpara de pesadilla de creación"
  },
  State_2626_Desc = {
    Text = "Límite de tentáculos -1. Al final del turno, todos los tentáculos atacan una vez más"
  },
  State_2627_Name = {
    Text = "Obtener [StateArg1] puntos de energía de llave"
  },
  State_2627_WeaponDesc = {
    Text = "En el nodo \"Estatua Inacabada\", las cartas seleccionadas obtienen energía clave"
  },
  State_2628_Desc = {
    Text = "En la \"escultura de cera inacabada\", las cartas copiadas obtienen el efecto de plegaria"
  },
  State_2628_Name = {
    Text = "Estado@Capítulo Dos_Resonancia 3"
  },
  State_2628_WeaponDesc = {
    Text = "En el nodo de \"escultura de cera inacabada\", las cartas copiadas obtienen el efecto de plegaria"
  },
  State_2629_Desc = {
    Text = "En \"Estatua Inacabada\", aumenta el rango de cartas copiables"
  },
  State_2629_Name = {
    Text = "Estado@Capítulo Dos_Resonancia 2"
  },
  State_2629_WeaponDesc = {
    Text = "En el nodo \"Estatua Inacabada\", las cartas copiadas y sus originales obtienen el efecto \"Inherente\""
  },
  State_2630_Desc = {
    Text = "Las cartas copiadas en \"Estatua Inacabada\" y sus originales obtienen el efecto \"Retener\""
  },
  State_2630_Name = {
    Text = "Estado@Capítulo Dos_Resonancia 4"
  },
  State_2630_WeaponDesc = {
    Text = "En el nodo \"Estatua Inacabada\", las cartas copiadas y sus originales obtienen el efecto \"Retener\""
  },
  State_2631_Desc = {
    Text = "En \"Estatua Inacabada\", copia una carta adicional"
  },
  State_2631_Name = {
    Text = "Estado@Capítulo Dos_Resonancia 6"
  },
  State_2631_WeaponDesc = {
    Text = "En el nodo \"Estatua Inacabada\", copia una carta adicional"
  },
  State_2633_Desc = {
    Text = "Cada vez que se recibe Daño Activo, añade 1 [Llamas verdes] con Agotamiento a la mano durante [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_2633_Name = {
    Text = "Fuego que atrapa polillas"
  },
  State_2633_WeaponDesc = {
    Text = "Antes del próximo turno, cada vez que seas atacado, añade una carta de consumo de [Llama Verde] a tu mano"
  },
  State_2634_Desc = {
    Text = "Al jugar una carta, recibe [StateArg1] puntos de daño y elimina 1 capa. Cuando las capas sean 0, eclosiona una \"Criatura del mar\" más débil. Si al final del turno aún existe el estado de parásito, eclosiona una \"Criatura del mar\" cuya vida aumenta con las capas"
  },
  State_2634_Name = {Text = "Parasitado"},
  State_2635_Desc = {
    Text = "Estado@prologo análisis ofensivo identificación"
  },
  State_2635_Name = {
    Text = "Estado@prologo análisis ofensivo identificación"
  },
  State_2635_WeaponDesc = {
    Text = "Estado@prologo análisis ofensivo identificación"
  },
  State_2636_Name = {
    Text = "Estado@Capítulo Cuatro_Resonancia@Cartas Robadas en el Próximo Turno 1"
  },
  State_2637_Desc = {
    Text = "Al comienzo del turno, obtén [StateArg1] de aritmética"
  },
  State_2637_Name = {
    Text = "Inyector activo de creación"
  },
  State_2637_WeaponDesc = {
    Text = "Al comienzo del turno, obtén [StateArg1] de aritmética"
  },
  State_2639_Desc = {
    Text = "Cuando recibes daño fatal en combate, hay una probabilidad de retener 1 punto de vida. Al activarse, en esta investigación, la probabilidad se reduce a la mitad y la resistencia a la muerte obtenida se reduce a la mitad"
  },
  State_2639_Name = {
    Text = "<DeathResistanceIconKeywords:Resistencia a la muerte>"
  },
  State_2640_Name = {
    Text = "Efecto Repetido General 1 vez"
  },
  State_2645_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo1"
  },
  State_2645_Name = {
    Text = "Estado@PrólogoMonstruoPasivo1"
  },
  State_2645_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo1"
  },
  State_2646_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo2"
  },
  State_2646_Name = {
    Text = "Estado@PrólogoMonstruoPasivo2"
  },
  State_2646_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo2"
  },
  State_2647_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo3"
  },
  State_2647_Name = {
    Text = "Estado@PrólogoMonstruoPasivo3"
  },
  State_2647_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo3"
  },
  State_2648_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo4"
  },
  State_2648_Name = {
    Text = "Estado@PrólogoMonstruoPasivo4"
  },
  State_2648_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo4"
  },
  State_2649_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo5"
  },
  State_2649_Name = {
    Text = "Estado@PrólogoMonstruoPasivo5"
  },
  State_2649_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo5"
  },
  State_2650_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo6"
  },
  State_2650_Name = {
    Text = "Estado@PrólogoMonstruoPasivo6"
  },
  State_2650_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo6"
  },
  State_2651_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo7"
  },
  State_2651_Name = {
    Text = "Estado@PrólogoMonstruoPasivo7"
  },
  State_2651_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo7"
  },
  State_2652_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo8"
  },
  State_2652_Name = {
    Text = "Estado@PrólogoMonstruoPasivo8"
  },
  State_2652_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo8"
  },
  State_2653_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo9"
  },
  State_2653_Name = {
    Text = "Estado@PrólogoMonstruoPasivo9"
  },
  State_2653_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo9"
  },
  State_2655_Desc = {
    Text = "Al causar daño no bloqueado, recupera la misma cantidad de vida, se elimina al causar daño"
  },
  State_2655_Name = {Text = "Vampirismo"},
  State_2656_Desc = {
    Text = "¡Escapa al inicio del próximo turno!"
  },
  State_2656_Name = {Text = "Escapar"},
  State_2660_Desc = {
    Text = "Al comenzar la batalla, recibe fuerza, pero cada vez que recibas daño, aumenta en 5."
  },
  State_2660_Name = {
    Text = "Dos al agua"
  },
  State_2661_Desc = {
    Text = "Al comenzar la batalla, todos los enemigos pierden [Arg1] puntos de poder"
  },
  State_2662_Name = {
    Text = "Estado@Capítulo Tres_Estado de Prueba"
  },
  State_2663_Desc = {
    Text = "Al robar, te debilitas durante 1 turno. Al usar, debilita a todos los enemigos durante 1 turno. No se puede vender"
  },
  State_2663_Name = {
    Text = "Estado Maldición Debilidad"
  },
  State_2663_WeaponDesc = {
    Text = "Al robar, te debilitas durante 1 turno. Al usar, debilita a todos los enemigos durante 1 turno. No se puede vender"
  },
  State_2666_Name = {
    Text = "Tasa crítica del cuchillo del ciclo"
  },
  State_2667_Desc = {
    Text = "Daño de cartas de ataque aumentado [Layer] %"
  },
  State_2667_Name = {
    Text = "Daño de cartas de ataque aumentado"
  },
  State_2667_WeaponDesc = {
    Text = "Daño de cartas de ataque aumentado [Layer] %"
  },
  State_2668_Desc = {
    Text = "Aumenta el ataque en [Layer]%"
  },
  State_2668_Name = {
    Text = "Aumento Porcentual Permanente de ATQ General"
  },
  State_2668_WeaponDesc = {
    Text = "Aumenta el ataque en [Layer]%"
  },
  State_2669_Desc = {
    Text = "Daño crítico aumentado en [Layer]% en esta batalla"
  },
  State_2669_Name = {
    Text = "Daño Crítico"
  },
  State_2670_Desc = {
    Text = "Cuando causas debilidad, obtienes [Arg1] puntos de escudo; cuando causas vulnerabilidad, obtienes [Arg2] puntos de poder. Si desencadenas estos dos efectos en un mismo turno, obtienes adicionalmente [Arg1] puntos de escudo y [Arg2] puntos de poder"
  },
  State_2670_Name = {
    Text = "Marco dorado"
  },
  State_2671_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_2671_Name = {
    Text = "No Activado"
  },
  State_2672_Desc = {
    Text = "Al inicio de cada turno, aplica capas de [Encadenamiento] a tu equipo"
  },
  State_2672_Name = {Text = "Ataduras"},
  State_2672_WeaponDesc = {
    Text = "Al inicio de cada turno, aplica capas de [Encadenamiento] a tu equipo"
  },
  State_2674_Desc = {
    Text = "La tasa crítica se incrementa en [Layer] % en esta ronda"
  },
  State_2674_Name = {
    Text = "Tasa de Crítico Temporal"
  },
  State_2676_Name = {
    Text = "Palpitación escarlata de accesorios"
  },
  State_2676_WeaponDesc = {
    Text = "Al liberar la llave, el portador obtiene un 15% de tasa crítica temporal. Si el daño crítico actual del portador es superior al 80%, obtiene un 15% de tasa crítica temporal adicional"
  },
  State_2677_Desc = {
    Text = "El primer daño activo/tentáculo recibido en cada turno se reduce en un 75%"
  },
  State_2677_Name = {
    Text = "\"Restos Inmortales\""
  },
  State_2677_WeaponDesc = {
    Text = "El primer daño activo/tentáculo recibido en cada turno se reduce en un 75%"
  },
  State_2679_Name = {
    Text = "Estado@Capítulo Tres_Resonancia 7_Marca"
  },
  State_2680_Desc = {
    Text = "La tasa crítica aumenta un 20%. Si la vida está por debajo del 25% al inicio del turno, este turno será un golpe crítico"
  },
  State_2681_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_2681_Name = {
    Text = "No Activado"
  },
  State_2682_Desc = {
    Text = "El efecto del escudo y curar fuerte aumenta un 50%"
  },
  State_2682_Name = {
    Text = "Protector del jardín de alienación"
  },
  State_2682_WeaponDesc = {
    Text = "El efecto del escudo y curar fuerte aumenta un 50%"
  },
  State_2683_Desc = {
    Text = "Roba cartas según las capas de estado"
  },
  State_2683_Name = {Text = "Robar"},
  State_2684_Desc = {
    Text = "Equipo único: El \"ataque\" del portador tiene <WeaponEffect_Num:[StateArg1]%> de probabilidad de obtener 1 aritmética y provocar un veneno del 10% en todos los enemigos; si el reino actual es \"aequor\", al activar este efecto, un tentáculo ataca una vez. Este efecto solo se activa una vez por ronda"
  },
  State_2684_WeaponDesc = {
    Text = "El \"golpe\" del portador tiene un <WeaponEffect_Num:[StateArg1]%> de probabilidad de obtener 1 aritmética y activar [DescArg1]% de <IntoxicationIconKeywords:veneno> en todos los enemigos. Si el reino actual es \"Aequor\", este efecto provoca que 1 tentáculo ataque una vez al ser activado. Este efecto puede activarse un máximo de 1 vez por turno."
  },
  State_2685_Desc = {
    Text = "Inmunidad a debilidad, fragilidad y estado vulnerable, al final del turno se elimina 1 capa"
  },
  State_2685_Name = {
    Text = "<BlessingIconKeywords: Bendición>"
  },
  State_2685_WeaponDesc = {
    Text = "Este turno, inmune a estados negativos"
  },
  State_2686_Desc = {
    Text = "Cartas temporales otorgadas en batalla"
  },
  State_2686_Name = {
    Text = "<CardKeyWord:Carta de Estado>"
  },
  State_2687_Desc = {
    Text = "La tasa crítica se incrementa en un 100% en esta ronda"
  },
  State_2687_Name = {
    Text = "Temporalmente garantizado para explotar"
  },
  State_2687_WeaponDesc = {
    Text = "La tasa crítica se incrementa en un 100% en esta ronda"
  },
  State_2688_Desc = {
    Text = "Al jugar la tercera carta de cada turno, coloca 1 \"inspiración\" en el montón de descarte. Al jugar la sexta carta de cada turno, coloca 1 \"inspiración\" desde el montón de descarte a la mano"
  },
  State_2689_Desc = {
    Text = "Al inicio del turno, roba 2 cartas. Aumenta la capacidad de ranura dimensional en 2"
  },
  State_2689_Name = {
    Text = "Sombrero del Ilusionista de la Creación"
  },
  State_2689_WeaponDesc = {
    Text = "Al inicio del turno, roba 2 cartas. Aumenta la capacidad de ranura dimensional en 2"
  },
  State_2690_Desc = {
    Text = "Cuando el Caballero Virtuoso juega una carta, gana [StateArg1] puntos de fuerza"
  },
  State_2690_Name = {
    Text = "Celo del caballero"
  },
  State_2691_Desc = {
    Text = "Equipo Único: Después de que el portador libere la explosión de locura, obtiene <WeaponEffect_Num:[StateArg1]> puntos de locura y <WeaponEffect_Num:[StateArg2]> puntos de llave plateada, repitiéndose 1 vez por cada 4 cartas en mano. Si el reino actual es \"Ultra\", después de que las cartas del portador entren en el espacio hiperspacial, obtiene un poder temporal equivalente al <WeaponEffect_Num:[StateArg3]%> de su ATQ, activándose un máximo de 2 veces por turno."
  },
  State_2691_WeaponDesc = {
    Text = "Después de que el portador libere la Exaltar, obtiene <WeaponEffect_Num:[StateArg1]> puntos de alienación y <WeaponEffect_Num:[StateArg2]> puntos de Llave Plateada, repitiendo 1 vez por cada 4 cartas en la mano. Si el reino actual es \"Ultra\", después de que las cartas del portador entren en el Espacio Hiperspacial, obtendrá <WeaponEffect_Num:[Power:DescArg1]> puntos de STR temporal, activándose un máximo de 2 veces por turno."
  },
  State_2693_Desc = {
    Text = "Estado@PrólogoLocura0_1_2Efecto"
  },
  State_2693_Name = {
    Text = "Estado@PrólogoLocura0_1_2Efecto"
  },
  State_2693_WeaponDesc = {
    Text = "Estado@PrólogoLocura0_1_2Efecto"
  },
  State_2694_Desc = {
    Text = "Cada vez que se consume 1 sello negro, todos los despertadores obtienen 1 aliemus"
  },
  State_2694_Name = {
    Text = "Estado de la Flor Inversa de la Creación"
  },
  State_2694_WeaponDesc = {
    Text = "Cada vez que se consume 1 sello negro, todos los despertadores obtienen 1 aliemus"
  },
  State_2695_Desc = {
    Text = "Cada vez que una carta de Despertado entra en el espacio dimensional, el Despertado correspondiente obtiene 15 locura"
  },
  State_2696_Desc = {
    Text = "Estado@PrólogoLocura0_1_2Activa"
  },
  State_2696_Name = {
    Text = "Estado@PrólogoLocura0_1_2Activa"
  },
  State_2696_WeaponDesc = {
    Text = "Estado@PrólogoLocura0_1_2Activa"
  },
  State_2698_Name = {
    Text = "Gana +1 de Potencia de cálculo al inicio del siguiente Turno"
  },
  State_2699_Name = {
    Text = "Gana +2 de Potencia de cálculo al inicio del siguiente Turno"
  },
  State_2701_Desc = {
    Text = "Cuando la dama del mar profundo obtiene un escudo, aumenta [StateArg1] temporalmente el daño de tentáculo"
  },
  State_2701_Name = {
    Text = "Hecho en existencia"
  },
  State_2701_WeaponDesc = {
    Text = "Cuando la dama del mar profundo obtiene un escudo, aumenta [StateArg1] temporalmente el daño de tentáculo"
  },
  State_2702_Desc = {
    Text = "Al recoger, obtienes un 100% de Resistencia a la Muerte. Después de activar la Resistencia a la Muerte, al inicio de cada turno en esta batalla, recuperas [Arg1] puntos de vida"
  },
  State_2702_Name = {
    Text = "Respirador vital"
  },
  State_2703_Desc = {
    Text = "La primera copia temporal de la carta de Despertado jugada en cada turno entra en la Fisura Dimensional, ¡pueden usarse para protegerse en momentos de peligro!"
  },
  State_2703_Name = {
    Text = "Fisura dimensional"
  },
  State_2705_Name = {
    Text = "La venganza sobre ti"
  },
  State_2706_Desc = {
    Text = "Detección de petrificación gradual"
  },
  State_2706_Name = {
    Text = "Detección de petrificación gradual"
  },
  State_2706_WeaponDesc = {
    Text = "Detección de petrificación gradual"
  },
  State_2707_Desc = {
    Text = "Este turno, los tentáculos atacan a todos los enemigos"
  },
  State_2707_Name = {
    Text = "ATQ Total de Tentáculos"
  },
  State_2707_WeaponDesc = {
    Text = "Este turno, los tentáculos atacan a todos los enemigos"
  },
  State_2708_Desc = {
    Text = "Límite de tentáculos +1. Si la vida es inferior al 50%, daño de tentáculos +[StateArg1]"
  },
  State_2708_Name = {
    Text = "Ofrenda del Pasado Mutada"
  },
  State_2708_WeaponDesc = {
    Text = "Límite de tentáculos +1. Si la vida es inferior al 50%, daño de tentáculos +[StateArg1]"
  },
  State_2709_Desc = {
    Text = "Contador de Lanceta oxidada de la Creación"
  },
  State_2710_Desc = {Text = "Marca"},
  State_2710_Name = {Text = "Marca"},
  State_2710_WeaponDesc = {Text = "Marca"},
  State_2711_Desc = {
    Text = "Cambiar temporalmente la potencia de cálculo de la carta"
  },
  State_2711_Name = {
    Text = "Cambiar temporalmente la potencia de cálculo de la carta"
  },
  State_2711_WeaponDesc = {
    Text = "Cambiar temporalmente la potencia de cálculo de la carta"
  },
  State_2712_Desc = {
    Text = "Aumenta el escudo generado"
  },
  State_2712_Name = {
    Text = "<AlertIconKeywords:Alerta>"
  },
  State_2712_WeaponDesc = {
    Text = "Aumenta los escudos obtenidos"
  },
  State_2713_Desc = {
    Text = "La Gran Hoja de la Venganza gana fuerza cada turno"
  },
  State_2713_Name = {
    Text = "Despertar de la Hoja de Venganza"
  },
  State_2713_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_2715_Desc = {
    Text = "Escudo aumentado en [Layer] puntos en esta etapa"
  },
  State_2715_Name = {
    Text = "Vigilancia permanente"
  },
  State_2715_WeaponDesc = {
    Text = "Escudo aumentado en [Layer] puntos en esta etapa"
  },
  State_2718_Desc = {
    Text = "Único del equipo: al final del turno, el portador gana <WeaponEffect_Num:[StateArg1]> puntos de aliemus y energía de llave de plata equivalente a la recarga de llave del portador"
  },
  State_2718_WeaponDesc = {
    Text = "Al final del turno, el portador obtiene <WeaponEffect_Num:[StateArg1]> puntos de alivio extremo y recibe una cantidad de energía equivalente a la recarga de la llave de plata del portador"
  },
  State_2720_Desc = {
    Text = "Al causar daño real, reduce la locura del despertar con mayor locura en 10"
  },
  State_2720_Name = {Text = "Oblivion"},
  State_2720_WeaponDesc = {
    Text = "Al causar daño real, reduce la locura del despertar con mayor locura en 10"
  },
  State_2721_Name = {
    Text = "Estado@Nivel2_9Batalla5Burbuja1"
  },
  State_2722_Desc = {
    Text = "Después de jugar, se barajan [StateArg1] cartas \"Inspiración\" en el montón de robo. \"Inspiración\": obtén 1 aritmética, roba 1 carta, retener, consumir"
  },
  State_2722_Name = {
    Text = "<Rune_17_High:Inspiración avanzada>"
  },
  State_2723_Desc = {
    Text = "Después de jugar, todos los enemigos se vuelven vulnerables por [StateArg1] turnos"
  },
  State_2723_Name = {
    Text = "<Rune_1_High:Daño crítico aumentado>"
  },
  State_2724_Desc = {Text = "ATQs +1"},
  State_2724_Name = {
    Text = "Contraataque del núcleo de los sueños"
  },
  State_2726_Desc = {
    Text = "Al jugar, aplica [StateArg1] capas de veneno a todos los enemigos y activa [StateArg2]% de veneno"
  },
  State_2726_Name = {
    Text = "<Rune_10_High:Toxina avanzada>"
  },
  State_2727_Desc = {
    Text = "Al morir, recupera 1 vida y elimina este estado"
  },
  State_2727_Name = {Text = "Racine"},
  State_2727_WeaponDesc = {
    Text = "Al morir, recupera 1 vida y elimina este estado"
  },
  State_2728_Desc = {
    Text = "Al inicio del turno, obtén 1 capa de <ParcloseIconKeywords:barrera> por cada aliado"
  },
  State_2728_Name = {
    Text = "Línea de barrera"
  },
  State_2728_WeaponDesc = {
    Text = "Al comienzo del turno, por cada aliado, obtienes un escudo del porcentaje de vida máxima de [Layer]"
  },
  State_2729_Desc = {
    Text = "Roba una carta correspondiente al cuerpo de despertar al activar"
  },
  State_2729_Name = {
    Text = "Robo de cartas con desviador espacial mutado"
  },
  State_2729_WeaponDesc = {
    Text = "Roba una carta correspondiente al cuerpo de despertar al activar"
  },
  State_2730_Desc = {
    Text = "Al morir, Hydra reduce 1 capa de estado \"Control de Serpientes\""
  },
  State_2730_Name = {Text = "Familier"},
  State_2732_Desc = {
    Text = "Estado@PrólogoLocuraInicial0_2_3"
  },
  State_2732_Name = {
    Text = "Estado@PrólogoLocuraInicial0_2_3"
  },
  State_2732_WeaponDesc = {
    Text = "Estado@PrólogoLocuraInicial0_2_3"
  },
  State_2734_Name = {
    Text = "Al inicio del próximo turno, roba 1 carta más"
  },
  State_2735_Desc = {
    Text = "Si esta carta activa \"Lanzadera Dimensional\" después de ser jugada o se encuentra actualmente en un Turno Ultra, activa el efecto subsiguiente."
  },
  State_2735_Name = {
    Text = "<TransitionIconKeywords:salto>"
  },
  State_2735_WeaponDesc = {
    Text = "Si estás en un turno de ultradimensión, se activa el efecto de salto"
  },
  State_2737_Desc = {
    Text = "Al reiniciar el mazo de nuestro equipo, gana [Layer] puntos de fuerza"
  },
  State_2737_Name = {
    Text = "Siempre congelado"
  },
  State_2738_Name = {
    Text = "Efecto de Debilidad Aumentado"
  },
  State_2740_Desc = {
    Text = "En la \"escultura de cera inacabada\", el costo de aritmética de las cartas copiadas y su propia carta se reduce en 1, además se obtiene una carta de síntoma"
  },
  State_2740_Name = {
    Text = "Estado@Capítulo Dos_Resonancia 5_2"
  },
  State_2740_WeaponDesc = {
    Text = "En el nodo de \"escultura de cera inacabada\", las cartas copiadas y su propia carta tienen un costo de aritmética reducido en 1"
  },
  State_2741_Desc = {
    Text = "En la \"escultura de cera inacabada\", el costo de aritmética de las cartas copiadas y su propia carta se reduce en 1, además se obtiene una carta de síntoma"
  },
  State_2741_Name = {
    Text = "Estado@Capítulo Dos_Resonancia 5_1"
  },
  State_2741_WeaponDesc = {
    Text = "En el nodo de \"escultura de cera inacabada\", las cartas copiadas y su propia carta tienen un costo de aritmética reducido en 1"
  },
  State_2742_Desc = {
    Text = "Cada vez que el Tictac inflige 1 punto de daño, obtén [StateArg2] poder temporal; cada vez que obtienes 1 escudo, obtén [StateArg3] alerta temporal"
  },
  State_2742_Name = {
    Text = "Ajuste de parámetros"
  },
  State_2744_Desc = {
    Text = "Cada vez que una carta de Despertado entra en el espacio dimensional, obtiene 15 locura"
  },
  State_2744_Name = {
    Text = "Dispositivo de salto de creación"
  },
  State_2744_WeaponDesc = {
    Text = "Cada vez que una carta de Despertado entra en el espacio dimensional, obtiene 15 locura"
  },
  State_2746_Desc = {
    Text = "ATQs +1, pierdes [Layer] de fuerza"
  },
  State_2746_Name = {Text = "Impaciente"},
  State_2747_Desc = {
    Text = "Al jugar, otros Despertados obtienen [StateArg1] de locura"
  },
  State_2747_Name = {
    Text = "<Rune_16:Catalizar>"
  },
  State_2748_Desc = {
    Text = "Estado@RitualLinterna"
  },
  State_2748_Name = {
    Text = "Estado@RitualLinterna"
  },
  State_2748_WeaponDesc = {
    Text = "Estado@RitualLinterna"
  },
  State_2749_Desc = {
    Text = "En esta ronda, después de causar daño de tentáculo, se aplica [Layer] capas de veneno al objetivo"
  },
  State_2749_Name = {
    Text = "Corrientes profundas"
  },
  State_2750_Desc = {
    Text = "Sumérgete conmigo en el mar"
  },
  State_2750_Name = {
    Text = "Néfia Despertar"
  },
  State_2752_Desc = {
    Text = "Cuando el lirio de agua causa daño, obtiene [StateArg2] locura"
  },
  State_2752_Name = {
    Text = "Ahogándose en el dolor"
  },
  State_2752_WeaponDesc = {
    Text = "Cuando el lirio de agua causa daño, obtiene [StateArg2] locura"
  },
  State_2753_Desc = {
    Text = "Al inicio del turno, si la vida es mayor que [Arg1], pierde [Arg1] de vida y obtiene [Arg2] de fuerza y [Arg3] de alerta durante el turno"
  },
  State_2754_Name = {
    Text = "Estado@tarjeta de golpe temporal aumento de tasa crítica"
  },
  State_2757_Desc = {
    Text = "Al inicio de la siguiente ronda, obtienes [DescArg1] puntos adicionales de aritmética."
  },
  State_2757_Name = {
    Text = "Síntoma: Sospecha"
  },
  State_2758_Desc = {
    Text = "Todos tus efectos de recuperación de vida aumentan en [Arg1] puntos, el exceso de vida se convierte en un escudo equivalente"
  },
  State_2758_Name = {
    Text = "Especimen de mariposa"
  },
  State_2760_Desc = {
    Text = "Cada vez que un Despertado realiza una devoración, los demás Despertados obtienen 10 locura"
  },
  State_2762_Desc = {
    Text = "Al jugarlo, se activa adicionalmente [StateArg1] veces, se obtienen [StateArg2] puntos del sigilo negro, agotamiento, inherente"
  },
  State_2762_Name = {
    Text = "<Rune_7_High:Eco avanzado>"
  },
  State_2762_WeaponDesc = {
    Text = "Efecto adicional [StateArg1] veces al jugarla, consumir"
  },
  State_2763_Desc = {
    Text = "Cada vez que el Señor del sueño consume 1 de aritmética, aumenta el [StateArg1] daño de tentáculo"
  },
  State_2763_Name = {
    Text = "Majestad inmortal"
  },
  State_2763_WeaponDesc = {
    Text = "Cada vez que el Señor del sueño consume 1 de aritmética, aumenta el [StateArg1] daño de tentáculo"
  },
  State_2764_Desc = {
    Text = "Al causar daño no bloqueado, añade [StateArg1] capas de sangrado"
  },
  State_2764_Name = {
    Text = "Sangría maliciosa"
  },
  State_2765_Name = {
    Text = "Estado@George@CurarAlMorir"
  },
  State_2767_Name = {
    Text = "Estado@Eficiencia del sigilo negro y recarga de llave de plata"
  },
  State_2769_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_2769_Name = {
    Text = "No Activado"
  },
  State_2771_Desc = {
    Text = "Fuerza del monstruo"
  },
  State_2771_Name = {
    Text = "Fuerza del monstruo"
  },
  State_2772_Name = {
    Text = "Estado@Nivel2_5Batalla3Burbuja1"
  },
  State_2773_Desc = {
    Text = "Al comienzo de la batalla, se añade 1 carta de \"momento hermoso - cambiar todas las cartas de despertadores en la mano por \"golpe\" hasta el final del turno. Mantener, consumir.\" a la mano"
  },
  State_2775_Desc = {
    Text = "Recupera cartas"
  },
  State_2775_Name = {
    Text = "Restablecimiento del conteo de cartas"
  },
  State_2776_Name = {
    Text = "Ojo de piedra, mejora de maldición"
  },
  State_2777_Name = {
    Text = "Estado@Capítulo Tres_Estado Vacío"
  },
  State_2778_Desc = {
    Text = "Al inicio del combate, obtén [Arg1] de escudo. Después de jugar 7 veces \"DEF\" en esta batalla, obtén inmediatamente [Arg2] de escudo"
  },
  State_2778_Name = {
    Text = "Correo matutino de Putney"
  },
  State_2779_Desc = {
    Text = "Cuando la vida esté por debajo del 50% ([StateArg1]), se dividirá en 3 cuerpos disueltos con vida equivalente"
  },
  State_2779_Name = {Text = "Dividir"},
  State_2779_WeaponDesc = {
    Text = "Cuando la vida esté por debajo del 50% ([StateArg1]), se dividirá en 2 esculturas de cera de tipo II con vida equivalente"
  },
  State_2780_Desc = {
    Text = "Después de jugar, obtén [StateArg1] puntos de aritmética"
  },
  State_2780_Name = {
    Text = "<Rune_4:Estrategia>"
  },
  State_2781_Desc = {
    Text = "Cada vez que juegues [Layer] cartas, si no tienes barrera, añade una capa de <ParcloseIconKeywords:barrera>"
  },
  State_2781_Name = {
    Text = "Barrera de carga"
  },
  State_2781_WeaponDesc = {
    Text = "Nuestro equipo refresca una capa de barrera del monstruo por cada [Layer] cartas jugadas"
  },
  State_2784_Desc = {
    Text = "Incluso fuera del turno extradimensional, puedes activar el efecto de salto una vez por turno. La capacidad del espacio extradimensional aumenta en 2"
  },
  State_2785_Desc = {
    Text = "Equipo Único: Después de que el portador juegue una carta, el portador obtiene 1 punto de alienación. Al comenzar la batalla, obtiene <PowerIconKeywords:Fuerza> equivalente al <WeaponEffect_Num:[StateArg1]%> del ataque del portador; si el reino actual es \"Aequor\", obtiene adicionalmente <CardKeyWord:Daño de tentáculos> de <WeaponEffect_Num:[StateArg2]%>. Al comienzo de cada turno posterior, obtiene <PowerIconKeywords:Fuerza> equivalente al <WeaponEffect_Num:[StateArg3]%> del ataque del portador; si el reino actual es \"Aequor\", obtiene adicionalmente <CardKeyWord:Daño de tentáculos> de <WeaponEffect_Num:[StateArg4]%>."
  },
  State_2785_WeaponDesc = {
    Text = "Después de que el portador juega una carta, obtiene 1 punto de alienación. Al comenzar la batalla, obtiene <WeaponEffect_Num:[Power:DescArg1]> puntos de <PowerIconKeywords:Fuerza>. Si el reino actual es \"Aequor\", obtiene adicionalmente <WeaponEffect_Num:[DescArg2]> puntos de <CardKeyWord:Daño de tentáculos>; al comienzo de cada turno posterior, obtiene <WeaponEffect_Num:[Power:DescArg3]> puntos de <PowerIconKeywords:Fuerza>. Si el reino actual es \"Aequor\", obtiene adicionalmente <WeaponEffect_Num:[DescArg4]> puntos de <CardKeyWord:Daño de tentáculos>."
  },
  State_2786_Name = {
    Text = "Contador de guijarro ensangrentado de creación"
  },
  State_2787_Desc = {
    Text = "Al restablecer vida, baraja 1 carta de [ilusión] en el montón de descarte. Perpetuo, destruye"
  },
  State_2787_Name = {
    Text = "<CardKeyWord:Búsqueda de la Verdad>"
  },
  State_2787_WeaponDesc = {
    Text = "Al restablecer vida, baraja 1 carta de [ilusión] en el montón de descarte. Perpetuo, destruye"
  },
  State_2788_Desc = {
    Text = "Al inicio del turno, roba [StateArg1] cartas"
  },
  State_2788_Name = {
    Text = "Lámpara de los deseos del profeta de creación 1"
  },
  State_2788_WeaponDesc = {
    Text = "Al inicio del turno, roba [StateArg1] cartas"
  },
  State_2789_Desc = {
    Text = "¡La carta fue manipulada por Jenkin! Recibe [Layer] <FixedDamage:DMG Puro> al jugarla."
  },
  State_2789_Name = {
    Text = "<CardKeyWord:Recibir [Layer] de daño al jugar>"
  },
  State_2789_WeaponDesc = {
    Text = "Al jugar la carta, recibe [StateArg1] puntos de daño"
  },
  State_2790_Desc = {
    Text = "Al final del turno, puede elegir conservar [StateArg1] cartas en la mano"
  },
  State_2790_Name = {
    Text = "Lámpara de los deseos del profeta de creación 2"
  },
  State_2790_WeaponDesc = {
    Text = "Al final del turno, puede elegir conservar [StateArg1] cartas en la mano"
  },
  State_2792_Desc = {
    Text = "Al comienzo de la batalla, todos los aliados reciben 3 capas de [armadura cerosa]. Al inicio del turno, se baraja una carta de confusión en el mazo de robo de nuestro equipo"
  },
  State_2792_Name = {
    Text = "\"Dama de Cera\""
  },
  State_2792_WeaponDesc = {
    Text = "Al comienzo de la batalla, todos los aliados reciben 3 capas de [armadura cerosa]. Al inicio del turno, se baraja una carta de confusión en el mazo de robo de nuestro equipo"
  },
  State_2793_Desc = {
    Text = "Estado@Ojo de Piedra Agonía"
  },
  State_2793_Name = {
    Text = "Estado@Ojo de Piedra Agonía"
  },
  State_2793_WeaponDesc = {
    Text = "Estado@Ojo de Piedra Agonía"
  },
  State_2796_Desc = {
    Text = "Cada vez que pierdes vida, todos los enemigos reciben [Arg1] capas de veneno. Cada turno, el valor de veneno aumenta en [Arg2] puntos"
  },
  State_2797_Desc = {
    Text = "Al inicio del turno, añade un \"Paraguas\" que obtiene [Arg1] de alerta este turno a tu mano. Después de jugar 6 cartas, aumenta la alerta de todos los \"Paraguas\" en tu mano en [Arg2]"
  },
  State_2798_Desc = {
    Text = "El sumo sacerdote de la caridad aplica un escudo, lo que reduce el consumo de aritmética de una carta aleatoria en -1 hasta que se juegue"
  },
  State_2798_Name = {
    Text = "La misericordia del padre"
  },
  State_2798_WeaponDesc = {
    Text = "El sumo sacerdote de la caridad aplica un escudo, lo que reduce el consumo de aritmética de una carta aleatoria en -1 hasta que se juegue"
  },
  State_2799_Desc = {
    Text = "Cuando La Medusa Lunar inflige Daño Activo, activa [StateArg1] ataques de tentáculos sobre el objetivo."
  },
  State_2799_Name = {
    Text = "Autoproliferación"
  },
  State_2799_WeaponDesc = {
    Text = "Cuando la luna marina causa daño, hace que [StateArg1] tentáculos ataquen al objetivo"
  },
  State_2800_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_2800_Name = {
    Text = "Estado@Prototipo de Cuchillo Daño Crítico"
  },
  State_2801_Desc = {
    Text = "Recibir daño real aumenta las capas de corrosión profunda"
  },
  State_2801_Name = {
    Text = "Recibir daño aumenta las capas de corrosión profunda"
  },
  State_2801_WeaponDesc = {
    Text = "Recibir daño real aumenta las capas de corrosión profunda"
  },
  State_2802_Desc = {
    Text = "Al inicio del turno, aumenta fuerza temporal"
  },
  State_2802_Name = {
    Text = "Aumentar fuerza temporal"
  },
  State_2804_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_2804_Name = {
    Text = "Estado@Prototipo de Cañón Láser Daño Crítico"
  },
  State_2805_Desc = {
    Text = "Al final del turno, otros aliados obtienen Fuerza"
  },
  State_2805_Name = {
    Text = "\"Fuego de la Iluminación\""
  },
  State_2807_Desc = {
    Text = "Al inicio del turno, añade un \"Paraguas\" que obtiene [Arg1] de alerta este turno a tu mano. Después de jugar 6 cartas, aumenta la alerta de todos los \"Paraguas\" en tu mano en [Arg2]"
  },
  State_2808_Desc = {
    Text = "Al final del turno, genera 1 nivel de Fusión Embrionaria; si hay embriones en la mano, recupera 15 vidas"
  },
  State_2808_Name = {
    Text = "Hemostato Anómalo"
  },
  State_2808_WeaponDesc = {
    Text = "Al final del turno, genera 1 nivel de Fusión Embrionaria; si hay embriones en la mano, recupera 15 vidas"
  },
  State_2809_Desc = {
    Text = "Al recoger, pierdes permanentemente [Arg1] puntos de Fuerza. Cada vez que causas daño, recuperas [Arg2] puntos de vida, hasta 6 veces por turno"
  },
  State_2809_Name = {
    Text = "Beso de la Lamprea"
  },
  State_2810_Desc = {
    Text = "Al final del turno, recupera [Layer] % de la salud máxima"
  },
  State_2810_Name = {
    Text = "Regeneración"
  },
  State_2810_WeaponDesc = {
    Text = "Al final del turno del monstruo, recupera [Layer]% de su vida máxima"
  },
  State_2811_Desc = {
    Text = "Al obtener una carta de síntoma, ganas [Arg1] puntos de poder. Por cada reliquia maldita o reliquia que poseas, aumentarás tu tasa crítica y daño crítico en un 10%"
  },
  State_2812_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_2812_Name = {
    Text = "No Activado"
  },
  State_2813_Desc = {
    Text = "Al comienzo del turno, pierde aritmética"
  },
  State_2813_Name = {
    Text = "¡Mal cálculo!"
  },
  State_2814_Desc = {
    Text = "Los sellos obtenidos al ganar la batalla se convierten en poderosos y peligrosos sellos de maldición"
  },
  State_2817_Desc = {
    Text = "Cada capa reduce el daño recibido en [StateArg1], se reduce en 1 capa al recibir un golpe crítico"
  },
  State_2817_Name = {
    Text = "Armadura de cera"
  },
  State_2817_WeaponDesc = {
    Text = "Inmunidad a estados anormales, se elimina al recibir un golpe crítico"
  },
  State_2818_Desc = {
    Text = "Divide en Triángulo Corroído A y Triángulo Corroído B"
  },
  State_2818_Name = {Text = "Dividir"},
  State_2818_WeaponDesc = {
    Text = "Divide en Triángulo Corroído A y Triángulo Corroído B"
  },
  State_2820_Desc = {
    Text = "Después de jugar, obtén [StateArg1] puntos temporales de poder, y la carta plegaria también podrá disfrutar de este aumento de poder"
  },
  State_2820_Name = {
    Text = "<Rune_15:Explosión>"
  },
  State_2821_Name = {
    Text = "Inmunidad temporal a la vulnerabilidad"
  },
  State_2823_Desc = {
    Text = "Equipo Único: Al comenzar el combate, aplica 2 capas de <VulnerabilityIconKeywords:Vulnerable> a los enemigos de la fila delantera. Al comenzar el turno, los enemigos en estado Vulnerable pierden <PowerIconKeywords:Fortaleza> Temporal equivalente al <WeaponEffect_Num:[StateArg1]%> del ATQ del Portador. Si el Reino actual es \"Carne y sangre\", tras liberar \"Exaltar\" el Portador, Fusión Embrionaria +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2823_WeaponDesc = {
    Text = "Al comenzar el combate, aplica 2 capas de <VulnerabilityIconKeywords:Vulnerable> a los enemigos de la fila delantera. Al comenzar el turno, los enemigos en estado Vulnerable pierden <WeaponEffect_Num:[Power:DescArg1]> puntos de <PowerIconKeywords:Fortaleza> Temporal. Si el Reino actual es \"Carne y sangre\", tras liberar \"Exaltar\" el Portador, Fusión Embrionaria +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2825_Desc = {
    Text = "Límite de ranura de carta de monstruo ultra"
  },
  State_2825_Name = {
    Text = "Límite de ranura de carta de monstruo ultra"
  },
  State_2825_WeaponDesc = {
    Text = "Límite de ranura de carta de monstruo ultra"
  },
  State_2826_Desc = {
    Text = "Al jugar consecutivamente 2 cartas con un consumo de aritmética menor que la carta anterior, el despertador con el menor aliemus recibe 50 aliemus"
  },
  State_2826_Name = {
    Text = "Reliquia Arcana de la Creación"
  },
  State_2827_Desc = {
    Text = "Número de golpes y aumento de daño"
  },
  State_2827_Name = {
    Text = "<CardKeyWord:Mejorar>"
  },
  State_2829_Desc = {
    Text = "Al causar daño real, obtén [Layer] puntos de fuerza"
  },
  State_2829_Name = {
    Text = "\"Personalidad caótica\""
  },
  State_2830_Desc = {
    Text = "Por cada despertador de profesión [deep sea] en el equipo, la salud máxima (incompleta), defensa y ataque del equipo aumentan un 50%"
  },
  State_2830_Name = {
    Text = "Bonificación de las profundidades"
  },
  State_2830_WeaponDesc = {
    Text = "Por cada despertador de profesión [deep sea] en el equipo, la salud máxima (incompleta), defensa y ataque del equipo aumentan un 50%"
  },
  State_2832_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_2832_Name = {
    Text = "Estado@Prototipo de Cañón Láser Resistencia"
  },
  State_2833_Desc = {
    Text = "Al comienzo del turno, roba 1 carta. Cada vez que robas 1 carta, cambia aleatoriamente su coste de aritmética (0-4)"
  },
  State_2835_Desc = {
    Text = "Cada activación de devorar roba [Arg1] de fuerza temporal a todos los enemigos"
  },
  State_2836_Name = {
    Text = "Estado@Maldición Conformidad"
  },
  State_2837_Name = {
    Text = "Estado@Maldición Conformidad"
  },
  State_2838_Name = {
    Text = "Estado@Maldición Conformidad"
  },
  State_2840_Desc = {
    Text = "Recibe [Layer] <FixedDamage:DMG Puro> y elimina [DescArg1]% de las Acumulaciones al final del turno. Al restaurar PV, elimina el doble de Acumulaciones de Sangrar que la cantidad curada."
  },
  State_2840_Name = {
    Text = "<BleedingColour: sangrando>"
  },
  State_2840_WeaponDesc = {
    Text = "Después de terminar el turno, recibe [Layer] de daño y elimina este estado; cada curación puede reducir las capas a la mitad"
  },
  State_2842_Desc = {
    Text = "Al jugar, obtén [StateArg1] de <RetaliateIconKeywords:Contrataque>, luego inflige Daño Verdadero a todos los enemigos igual al [StateArg2]% de tu <RetaliateIconKeywords:Contrataque>."
  },
  State_2842_Name = {
    Text = "<Rune_9: punta>"
  },
  State_2843_Desc = {
    Text = "Nuestro equipo gana [StateArg1] capas de escudo por cada carta jugada. Dura 1 turno"
  },
  State_2843_Name = {
    Text = "Plumas volantes"
  },
  State_2843_WeaponDesc = {
    Text = "Nuestro equipo gana [StateArg1] capas de escudo por cada carta jugada. Dura 1 turno"
  },
  State_2844_Desc = {
    Text = "Al perder vida por primera vez en cada batalla, obtienes una capa de barrera que inmuniza un daño"
  },
  State_2845_Name = {
    Text = "Susurros de la tumba de accesorios"
  },
  State_2845_WeaponDesc = {
    Text = "Al iniciar el nivel, la resistencia a la muerte aumenta un 25%. Al activar la resistencia a la muerte, el portador obtiene 50 puntos de locura"
  },
  State_2846_Desc = {
    Text = "Inmunidad a una muerte, recupera [Arg1] vida al activarse y se desactiva permanentemente"
  },
  State_2846_Name = {
    Text = "Muñeca sustituta"
  },
  State_2847_Desc = {
    Text = "Cada vez que el Despertado cazado usa una carta, acumula 1 marca de caza y roba cartas igual a la mitad de las marcas"
  },
  State_2847_Name = {
    Text = "Ceremonia de caza"
  },
  State_2849_Desc = {
    Text = "Cada vez que pierdes vida, obtienes [Arg1] puntos de fuerza, máximo 10 veces. Al alcanzar el máximo, recuperas 25% de la vida perdida"
  },
  State_2849_Name = {
    Text = "El más alto honor"
  },
  State_2853_Desc = {
    Text = "Contador de la Silla de Descanso Eterno de la Creación"
  },
  State_2854_Desc = {
    Text = "Después de morir, no proporciona locura al despertar"
  },
  State_2854_Name = {Text = "egoísta"},
  State_2854_WeaponDesc = {
    Text = "Después de morir, no proporciona locura al despertar"
  },
  State_2855_Desc = {
    Text = "El daño de la carta de golpe aumenta en [StateArg1]%, dura [Layer] turnos."
  },
  State_2855_Name = {
    Text = "Sobrevivir en la adversidad·Golpear"
  },
  State_2855_WeaponDesc = {
    Text = "Este turno, el daño de tus cartas de golpe aumenta [Layer]%"
  },
  State_2856_Desc = {
    Text = "Equipo Único: El escudo causado por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>, y al causar escudo, todo el equipo obtiene <WeaponEffect_Num:[StateArg3]%> de Tasa de Crítico Temporal y <WeaponEffect_Num:[StateArg4]%> de Llave Plateada, con un máximo de 2 activaciones por turno. Si el reino actual es \"Aequor\", cada vez que un tentáculo ataque, el portador obtiene 1 punto de Alienación, con un máximo de <WeaponEffect_Num:[StateArg2]> puntos por turno."
  },
  State_2856_WeaponDesc = {
    Text = "El escudo causado por el portador aumenta en <WeaponEffect_Num:[StateArg1]％>, y al causar escudo, todos los aliados obtienen <WeaponEffect_Num:[StateArg3]％> de tasa de crítico temporal y <WeaponEffect_Num:[StateArg4]%> de energía de llave plateada por regeneración de llave del portador, activándose un máximo de 2 veces por turno. Si el reino actual es \"Aequor\", cada vez que un tentáculo ataque, el portador obtiene 1 punto de alienación, con un máximo de <WeaponEffect_Num:[StateArg2]> puntos por turno."
  },
  State_2857_Desc = {
    Text = "Al inicio de cada turno, todos los despertadores obtienen 10 puntos de aliemus. La salud máxima se reduce en 50%"
  },
  State_2858_Name = {
    Text = "Obtén dos capas adicionales de barrera al jugarla"
  },
  State_2859_Desc = {
    Text = "Después de que comience la batalla, esta carta quedará fijada en la mano"
  },
  State_2859_Name = {
    Text = "<CardKeyWord:Inherente>"
  },
  State_2860_Desc = {
    Text = "Al robar, reduce tu salud máxima en un 10%. Al usar, aumenta el daño crítico de todos los despertadores en un 100% este turno. No se puede vender"
  },
  State_2860_Name = {
    Text = "Estado Maldición Corrosión"
  },
  State_2860_WeaponDesc = {
    Text = "Al robar, reduce tu salud máxima en un 10%. Al usar, aumenta el daño crítico de todos los despertadores en un 100% este turno. No se puede vender"
  },
  State_2861_Name = {
    Text = "(Restante:[Layer])"
  },
  State_2862_Desc = {
    Text = "Al final del turno, recibe daño de veneno adicional una vez"
  },
  State_2862_Name = {
    Text = "Debilidad constitucional"
  },
  State_2863_Desc = {
    Text = "Número de niveles de evolución"
  },
  State_2863_Name = {
    Text = "Número de niveles de evolución"
  },
  State_2863_WeaponDesc = {
    Text = "Número de niveles de evolución"
  },
  State_2864_Desc = {
    Text = "\"24\" ha despertado, ¡usa el último \"¡Ayúdame!\" para encontrar una oportunidad!"
  },
  State_2864_Name = {
    Text = "\"24\"¡Despertar!"
  },
  State_2864_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_2866_Desc = {
    Text = "Equipo Único: Tamaño Máximo de la Mano +2, al final del turno, obtiene Keyflare equivalente al <WeaponEffect_Num:[StateArg1]%> de Regeneración de Llave Plateada del portador. Cada vez que se Libera una Posse, todos los Despertados obtienen <WeaponEffect_Num:[StateArg2]> puntos de Alienación. Si el Reino actual es \"Carne y sangre\", además se activa la Fusión Embrionaria <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_2866_WeaponDesc = {
    Text = "Tamaño Máximo de la Mano +2, al finalizar el turno obtiene <WeaponEffect_Num:[DescArg1]> puntos de Llave Plateada. Cada vez que se libera una Posse, todos los Cuerpos Despertados obtienen <WeaponEffect_Num:[StateArg2]> puntos de Alienación; si el Reino actual es \"Carne y sangre\", también aumenta la Fusión Embrionaria <WeaponEffect_Num:+[Blood:StateArg3]> ."
  },
  State_2868_Desc = {
    Text = "Al final del turno, por cada carta no jugada en tu mano, todos los Despertados ganan 2 Locura"
  },
  State_2871_Desc = {
    Text = "Cuando la vida está por debajo del 50%([StateArg1]), invocará un \"Triángulo de Corrosión\" con vida equivalente"
  },
  State_2871_Name = {Text = "Convocar"},
  State_2871_WeaponDesc = {
    Text = "Cuando la vida está por debajo del 50%([StateArg1]), invocará un \"Triángulo de Corrosión\" con vida equivalente"
  },
  State_2874_Desc = {
    Text = "El Despertado es observado por el Cazador de Cráneos, usar sus cartas permite robar 2 cartas adicionales"
  },
  State_2875_Desc = {
    Text = "Al jugar, <EmbryoFusionIconKeywords:Fusión Embrionaria> +[StateArg1]."
  },
  State_2875_Name = {
    Text = "<Rune_12_High:Seducción avanzada>"
  },
  State_2875_WeaponDesc = {
    Text = "Al jugar, Fusión Embrionaria+ [Blood:StateArg1]."
  },
  State_2876_Desc = {
    Text = "Al finalizar la batalla, obtienes 50 el sigilo negro adicional y 1 carta de síntoma"
  },
  State_2877_Desc = {
    Text = "Cada vez que la Dama Roja inflige daño, obtiene [StateArg2] puntos de fuerza temporal"
  },
  State_2877_Name = {
    Text = "Privilegio de la dama anfitriona"
  },
  State_2878_Desc = {
    Text = "Número de golpes +1, pero el daño se reduce en un 25%"
  },
  State_2878_Name = {Text = "Frenesí"},
  State_2878_WeaponDesc = {
    Text = "Número de golpes +1, pero el daño se reduce en un 25%"
  },
  State_2879_Name = {
    Text = "Slime Dulce"
  },
  State_2879_WeaponDesc = {
    Text = "Después de usar \"Aniquilación\", si estás en la postura de Mar tranquilo en este turno, el escudo y la curación del portador aumentan en un 30%."
  },
  State_2880_Name = {
    Text = "Estado@apóstol del mar iluminar 7"
  },
  State_2881_Desc = {
    Text = "Cada vez que se convierte 1 carta de \"Sagrado\" en \"Locura\", el daño básico que cause Miria en esta batalla aumenta un 15%"
  },
  State_2881_Name = {
    Text = "Ilusión desvanecida"
  },
  State_2883_Desc = {
    Text = "Equipo Único: Después de que el Portador inflige Daño Activo, hay un <WeaponEffect_Num:[StateArg1]%> de probabilidad de Robar 1 de sus Tarjetas de comando y reducir su Coste de Aritmética en 1. Este Efecto se activa solo una vez por turno."
  },
  State_2883_WeaponDesc = {
    Text = "Después de que el Portador inflige Daño Activo, hay un <WeaponEffect_Num:[StateArg1]%> de probabilidad de Robar 1 de sus Tarjetas de comando y reducir su Coste de Aritmética en 1. Este Efecto se activa solo una vez por turno."
  },
  State_2884_Name = {
    Text = "El daño causado es <PunctureDamagewords:daño penetrante>. Reduce el costo de aritmética de 1 carta en tu mano con el máximo costo de aritmética"
  },
  State_2885_Name = {
    Text = "Estado@InicioTurnoMás2Cartas"
  },
  State_2887_Desc = {
    Text = "Equipo Único: Después de que el portador libera la explosión de locura, su daño crítico para este turno aumenta <WeaponEffect_Num:[StateArg1]%>, y todas las cartas del portador tienen un <WeaponEffect_Num:[StateArg2]%> de probabilidad de reducir el coste de aritmética en 1 punto para este turno."
  },
  State_2887_WeaponDesc = {
    Text = "Después de que el equipador libera la exaltación, su daño crítico para este turno aumenta <WeaponEffect_Num:[StateArg1]%>, y todas las cartas del equipador tienen un <WeaponEffect_Num:[StateArg2]%> de probabilidad de reducir el consumo de aritmética en 1 punto para este turno"
  },
  State_2888_Desc = {
    Text = "Si tienes una \"Embrion\" en tu mano, gasta 1 y activa el efecto posterior"
  },
  State_2888_Name = {
    Text = "<DevouredIconKeywords:Devorar>"
  },
  State_2888_WeaponDesc = {
    Text = "Consume el embrión en la mano, provocando un poderoso efecto devorador"
  },
  State_2889_Name = {
    Text = "Elige un despertado para que obtenga <Energy:[DescArg1]> de locura"
  },
  State_2890_Desc = {
    Text = "Al comienzo de la batalla, se inflige 1 capa de debilidad a nuestro equipo"
  },
  State_2890_Name = {
    Text = "Penetración de armadura"
  },
  State_2890_WeaponDesc = {
    Text = "Al comienzo de la batalla, se inflige 1 capa de debilidad a nuestro equipo"
  },
  State_2891_Name = {
    Text = "Aumento de Responder de Apertura de Alienación"
  },
  State_2892_Desc = {
    Text = "Al final del turno, recupera [Layer] puntos de vida."
  },
  State_2892_Name = {
    Text = "Regeneración de Vida Retrasada"
  },
  State_2892_WeaponDesc = {
    Text = "Hasta el final del turno, cada vez que mates, recupera [Layer] puntos de vida"
  },
  State_2897_Desc = {
    Text = "Al liberar la llegada del génesis, reduce temporalmente el poder del enemigo"
  },
  State_2897_Name = {
    Text = "Temor a la locura"
  },
  State_2899_Desc = {
    Text = "Si el oponente tiene 4 o más cartas en mano, al recibir daño, obtén [StateArg1] de escudo"
  },
  State_2899_Name = {Text = "Serpiente"},
  State_2900_Desc = {
    Text = "Daño aumentado en [Layer] en esta batalla"
  },
  State_2900_Name = {Text = "Fuerza"},
  State_2900_WeaponDesc = {
    Text = "Daño aumentado en [Layer] en esta batalla"
  },
  State_2901_Desc = {
    Text = "[exaltar] otorga a uno 20 puntos de locura"
  },
  State_2901_Name = {
    Text = "Velo del dios sin nombre de creación"
  },
  State_2901_WeaponDesc = {
    Text = "[exaltar] otorga a uno 20 puntos de locura"
  },
  State_2902_Desc = {
    Text = "El cerebro en un frasco duplica la vida"
  },
  State_2902_Name = {
    Text = "Carne desprendida"
  },
  State_2902_WeaponDesc = {
    Text = "El cerebro en un frasco duplica la vida"
  },
  State_2903_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_2903_Name = {
    Text = "Estado@Prototipo de Cuchillo Crítico"
  },
  State_2904_Desc = {
    Text = "Al recibir daño real, obtén 10 puntos de escudo"
  },
  State_2904_Name = {Text = "buffer"},
  State_2904_WeaponDesc = {
    Text = "Al recibir daño real, obtén 10 puntos de escudo"
  },
  State_2905_Desc = {
    Text = "Equipo Único: El escudo proporcionado por la \"exaltar\" del portador aumenta en <WeaponEffect_Num:[StateArg2]%. Tras liberar \"exaltar\", el portador recibe <WeaponEffect_Num:[StateArg1]%> acumulaciones de <PowerIconKeywords:fuerza> temporal equivalente a su defensa. Si nuestro equipo está en estado <FragileIconKeywords:frágil>, el efecto se duplica."
  },
  State_2905_WeaponDesc = {
    Text = "El escudo proporcionado por la \"exaltar\" del portador aumenta <WeaponEffect_Num:[StateArg2]%>. Tras liberar \"exaltar\", el portador recibe [Power:DescArg1] puntos de <PowerIconKeywords:poder> temporal. Si nuestro equipo está en estado <FragileIconKeywords:frágil>, el efecto se duplica"
  },
  State_2906_Desc = {
    Text = "Al causar daño real, reduce temporalmente la fuerza de tu equipo en [Layer] puntos"
  },
  State_2906_Name = {
    Text = "Paralización eléctrica"
  },
  State_2909_Desc = {
    Text = "Posee [Layer] puntos de aliemus. Si los puntos de aliemus son mayores o iguales a 5, la intención se convierte en \"banquete de los muertos retorcidos\", se recupera tras la disminución de puntos de aliemus"
  },
  State_2909_Name = {
    Text = "Estado@monstruo 24 banquete de los muertos retorcidos cuenta"
  },
  State_2909_WeaponDesc = {
    Text = "Posee [Layer] puntos de aliemus. Si los puntos de aliemus son mayores o iguales a 5, la intención se convierte en \"banquete de los muertos retorcidos\", se recupera tras la disminución de puntos de aliemus"
  },
  State_2910_Desc = {
    Text = "Equipo Único: Al comenzar la exploración, se añade una carta de \"Conocimiento\" y \"Golpe\" del portador al mazo. El daño base de \"Golpe\" del portador aumenta en <WeaponEffect_Num:[StateArg1]%, y tras jugarlo, hay un <WeaponEffect_Num:[StateArg2]% de probabilidad de robar 1 carta. Este efecto solo se activa una vez por turno. Si el reino actual es \"Ultra\" y está en turno ultra, \"Golpe\" coloca 1 \"Conocimiento\" en la mano; este efecto solo se activa una vez por turno."
  },
  State_2910_WeaponDesc = {
    Text = "Al comenzar la exploración, añade una carta de \"Conocimiento\" y una carta de \"golpe\" del portador al mazo, el daño base de \"golpe\" del portador aumenta en <WeaponEffect_Num:[StateArg1]%, y tras jugarla, hay un <WeaponEffect_Num:[StateArg2]%> de probabilidad de robar 1 carta. Este efecto solo puede activarse una vez por turno. Si el reino actual es \"Ultra\" y está en un Turno Ultra, \"golpe\" coloca 1 \"Conocimiento\" en la mano, pudiendo activarse una vez por turno."
  },
  State_2911_Desc = {
    Text = "Estado@Mundo de Fantasía Pura Contador Modificado"
  },
  State_2911_Name = {
    Text = "Estado@Mundo de Fantasía Pura Contador"
  },
  State_2911_WeaponDesc = {
    Text = "Estado@Mundo de Fantasía Pura Contador Modificado"
  },
  State_2912_Desc = {
    Text = "¡Estás bloqueado! Después de lanzar, el marinero guardia ganará [StateArg1] puntos de poder temporal, eliminando la marca de profundo subidón de aquella orden"
  },
  State_2912_Name = {
    Text = "<CardKeyWord:Marca de la Profundidad>"
  },
  State_2912_WeaponDesc = {
    Text = "Al jugar la carta, el guardia de los Profundos recibe [StateArg1] puntos de fuerza temporal"
  },
  State_2913_Desc = {
    Text = "Al comienzo de la batalla, se debilita uno mismo durante 3 turnos"
  },
  State_2913_Name = {
    Text = "Garra extraña de creación 2"
  },
  State_2913_WeaponDesc = {
    Text = "Al comienzo de la batalla, se debilita uno mismo durante 3 turnos"
  },
  State_2914_Desc = {
    Text = "Cuando la vida está por debajo del 50%, cambiará su intención a invocar un \"Triángulo de Corrosión\" con vida equivalente"
  },
  State_2914_Name = {Text = "Fisión"},
  State_2914_WeaponDesc = {
    Text = "Cuando la vida está por debajo del 50%, cambiará su intención a invocar un \"Triángulo de Corrosión\" con vida equivalente"
  },
  State_2915_Desc = {
    Text = "Aumenta el número de daños de \"cadena de resentimiento\" en +[Layer] veces"
  },
  State_2915_Name = {Text = "Odio"},
  State_2915_WeaponDesc = {
    Text = "Aumenta el número de daños de \"cadena de resentimiento\" en +[Layer] veces"
  },
  State_2917_Desc = {
    Text = "Al final del turno, por cada carta restante en la mano, gana 1 punto de potencia al comienzo del próximo turno"
  },
  State_2917_Name = {
    Text = "Estado@LlavePlataSueños:Calcular"
  },
  State_2918_Desc = {
    Text = "El daño recibido se reduce en un 99%. Después de recibir daño activo, se elimina 1 capa, se restaura a 3 capas al inicio del turno"
  },
  State_2918_Name = {
    Text = "\"Restos Inmortales\""
  },
  State_2918_WeaponDesc = {
    Text = "El daño recibido se reduce en un 99%. Después de recibir daño activo, se elimina 1 capa, se restaura a 3 capas al inicio del turno"
  },
  State_2919_Desc = {
    Text = "Estado@Espejo de Esmeralda Avance"
  },
  State_2919_Name = {
    Text = "Estado@Espejo de Esmeralda Avance"
  },
  State_2919_WeaponDesc = {
    Text = "Estado@Espejo de Esmeralda Avance"
  },
  State_2922_Desc = {
    Text = "Por cada punto de aritmética consumido, el despertador correspondiente obtiene 2 puntos de locura"
  },
  State_2923_Desc = {
    Text = "Al final del turno, la Fuerza aumenta en [Layer]"
  },
  State_2923_Name = {
    Text = "Ritual de Descenso Divino"
  },
  State_2923_WeaponDesc = {
    Text = "Al final de cada turno, obtén [Layer] puntos de fuerza"
  },
  State_2925_Desc = {
    Text = "Cada vez que el Fuego Esmeralda causa daño, aumenta en 1 capa"
  },
  State_2925_Name = {
    Text = "Conteo de reflejo esmeralda"
  },
  State_2925_WeaponDesc = {
    Text = "Cada vez que el Fuego Esmeralda causa daño, aumenta en 1 capa"
  },
  State_2927_Name = {
    Text = "Estado@Maldición Delirio Cambio"
  },
  State_2929_Desc = {
    Text = "Equipo Único: Cada vez que el Portador inflige 1 instancia de Daño, hay un <WeaponEffect_Num:[StateArg3]%> de probabilidad de que el Portador obtenga 2% de Daño crítico temporal. Después de que el Portador use Exaltar, inflige 3 instancias de Daño Activo a enemigos aleatorios equivalente al <WeaponEffect_Num:[StateArg1]%> del ATQ del Portador. Si el Reino actual es \"Carne y sangre\", cada vez que el Portador Devora un Embrión, aumenta la Fusión Embrionaria +<WeaponEffect_Num:[Blood:StateArg2]> ."
  },
  State_2929_WeaponDesc = {
    Text = "Cada vez que el Portador inflige 1 instancia de Daño, hay un <WeaponEffect_Num:[StateArg3]%> de probabilidad de que el Portador obtenga 2% de Daño crítico temporal. Después de que el Portador use Exaltar, inflige 3 instancias de [DescArg1] puntos de Daño Activo a enemigos aleatorios. Si el Reino actual es \"Carne y sangre\", cada vez que el Portador Devora un Embrión, aumenta la Fusión Embrionaria +<WeaponEffect_Num:[Blood:StateArg2]> ."
  },
  State_2930_Name = {
    Text = "Estado@George@FuerzaAlMorir"
  },
  State_2931_Desc = {
    Text = "Cada activación de devorar roba 4 de fuerza temporal a todos los enemigos"
  },
  State_2931_Name = {
    Text = "Ágata de Seda Mutada"
  },
  State_2933_Name = {
    Text = "Gemelos distorsionados blancos de accesorios"
  },
  State_2933_WeaponDesc = {
    Text = "Después de que comience el turno par, añade una \"DEF\" de un equipador con ilusión y agotamiento a tu mano"
  },
  State_2934_Desc = {
    Text = "Todo el Daño Activo y Daño de tentáculos recibido +[DescArg1]%."
  },
  State_2934_Name = {
    Text = "<VulnerabilityColour: vulnerable>"
  },
  State_2934_WeaponDesc = {
    Text = "Aumenta todo el daño recibido en un 50 %"
  },
  State_2937_Desc = {
    Text = "Cada tercera vez que se obtiene un escudo, también se obtiene una cantidad igual de contraataque"
  },
  State_2938_Desc = {
    Text = "Al inicio del turno, roba 1 carta. Al final del turno, puedes conservar 1 carta en la mano"
  },
  State_2939_Name = {
    Text = "Inmunidad a la fragilidad"
  },
  State_2940_Desc = {
    Text = "Aumenta el efecto de regeneración."
  },
  State_2940_Name = {
    Text = "Sufrir el aumento de la sangre aberrante"
  },
  State_2941_Desc = {
    Text = "Al jugar, aplica [StateArg1] capas de veneno a todos los enemigos y activa [StateArg2]% de veneno"
  },
  State_2941_Name = {
    Text = "<Rune_10:Toxina>"
  },
  State_2942_Desc = {
    Text = "Al final del turno, restaura [Layer]% de vida a otros aliados y elimina el daño continuo"
  },
  State_2942_Name = {
    Text = "Socorro en el campo de batalla"
  },
  State_2946_Desc = {
    Text = "Golpes frenéticos otorgan una gran cantidad de escudo"
  },
  State_2946_Name = {
    Text = "\"Fortaleza inmóvil\""
  },
  State_2946_WeaponDesc = {
    Text = "Golpes frenéticos otorgan una gran cantidad de escudo"
  },
  State_2947_Name = {Text = "Disolver 2"},
  State_2948_Desc = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_2948_Name = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_2948_WeaponDesc = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_2949_Name = {
    Text = "Abandonar la plegaria de rueda del destino en batalla"
  },
  State_2951_Desc = {
    Text = "Silla de Descanso Eterno de la Creación"
  },
  State_2951_Name = {
    Text = "Guantes silenciados"
  },
  State_2952_Desc = {
    Text = "Después de que termine el turno, recupera [Layer] de vida. Por cada 5 de vida perdida, elimina 1 capa"
  },
  State_2952_Name = {
    Text = "Regeneración"
  },
  State_2954_Name = {
    Text = "Estado@2-8Monstruo24@Ayúdame"
  },
  State_2955_Desc = {
    Text = "Todos los enemigos pierden vida. Permanente, destruir"
  },
  State_2955_Name = {
    Text = "<CardKeyWord:fin de la ilusión>"
  },
  State_2955_WeaponDesc = {
    Text = "Todos los enemigos pierden vida. Permanente, destruir"
  },
  State_2956_Desc = {
    Text = "Cada vez que recibes daño, todos los despertados obtienen [StateArg1] puntos de locura"
  },
  State_2956_Name = {
    Text = "Rayo de fantasía"
  },
  State_2956_WeaponDesc = {
    Text = "Cada vez que recibes daño, todos los despertados obtienen [StateArg1] puntos de locura"
  },
  State_2957_Desc = {
    Text = "Al morir, invoca en el lugar un [Triángulo de Fusión] con 1/3 de su vida"
  },
  State_2957_Name = {
    Text = "Disolución"
  },
  State_2957_WeaponDesc = {
    Text = "Al morir, invoca en el lugar un [Triángulo de Fusión] con 1/3 de su vida"
  },
  State_2960_Desc = {
    Text = "En el turno par, cuando tu aritmética sea 0, obtén 2 aritméticas"
  },
  State_2960_Name = {
    Text = "Rompecabezas Antiguo Mutado"
  },
  State_2960_WeaponDesc = {
    Text = "En el turno par, cuando tu aritmética sea 0, obtén 2 aritméticas"
  },
  State_2961_Desc = {
    Text = "Equipo Único: El <IntoxicationIconKeywords:veneno> causado por el portador aumenta en <WeaponEffect_Num:[StateArg1]%. Antes de que el portador libere la exaltación, aplica veneno equivalente al <WeaponEffect_Num:[StateArg2]%> de su ATQ a todos los enemigos. Después de usar la Posse, el portador obtiene <WeaponEffect_Num:[StateArg3]> puntos de alienación."
  },
  State_2961_WeaponDesc = {
    Text = "El <IntoxicationIconKeywords:veneno> causado por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>, antes de que el portador libere la exaltación, aplica <WeaponEffect_Num:[Poison:DescArg1]> capas de veneno a todos los enemigos. Después de usar la llave, el portador obtiene <WeaponEffect_Num:[StateArg3]> puntos de locura."
  },
  State_2962_Desc = {
    Text = "Después de jugar, debilita a todos los enemigos por [StateArg1] turnos"
  },
  State_2962_Name = {
    Text = "<Rune_2:Debilidad>"
  },
  State_2965_Name = {
    Text = "Estado@sirvienta de luna creciente iluminar7"
  },
  State_2967_Desc = {
    Text = "Al usar Tarjetas de síntomas, el estado de Pandia alterna entre \"Inquieta\" y \"Dissipación\". Inquieta: instancias de Daño Activo +1, FUE reducida. Dissipación: instancias de Daño Activo -1, FUE aumentada."
  },
  State_2967_Name = {
    Text = "¡Pandia despierta!"
  },
  State_2967_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_2968_Name = {
    Text = "Estado@Nivel2_14Batalla8Burbuja4"
  },
  State_2969_Name = {
    Text = "Estado@Nivel2_14Batalla8Burbuja5"
  },
  State_2970_Desc = {
    Text = "Descendientes primordiales"
  },
  State_2970_Name = {
    Text = "Descendientes primordiales"
  },
  State_2970_WeaponDesc = {
    Text = "Descendientes primordiales"
  },
  State_2971_Desc = {
    Text = "Estado@PrólogoMitadVida"
  },
  State_2971_Name = {
    Text = "Estado@PrólogoMitadVida"
  },
  State_2971_WeaponDesc = {
    Text = "Estado@PrólogoMitadVida"
  },
  State_2972_Name = {
    Text = "Estado@Nivel2_14Batalla8Burbuja2"
  },
  State_2973_Name = {
    Text = "Estado@Nivel2_14Batalla8Burbuja3"
  },
  State_2975_Desc = {
    Text = "Durante las primeras 5 saltos de cada batalla, el efecto adicional se activa una vez más"
  },
  State_2976_Desc = {
    Text = "Al final del turno, si tu escudo es 0 o múltiplo de 10, gana [Arg1] puntos de escudo. Si tu vida es múltiplo de 10, gana [Arg2] puntos de fuerza"
  },
  State_2976_Name = {
    Text = "Señal de socorro"
  },
  State_2977_Desc = {
    Text = "Turno impar, cuando tienes 0 cartas, roba 2 cartas"
  },
  State_2977_Name = {
    Text = "Rompecabezas Antiguo Mutado"
  },
  State_2977_WeaponDesc = {
    Text = "Turno impar, cuando tienes 0 cartas, roba 2 cartas"
  },
  State_2978_Desc = {
    Text = "Cada vez que recibes 1 punto de daño, reduce 1 capa. Cuando las capas llegan a 0, cambia a modo defensa"
  },
  State_2978_Name = {
    Text = "Contador de cartas"
  },
  State_2978_WeaponDesc = {
    Text = "Cada vez que recibes 1 punto de daño, reduce 1 capa. Cuando las capas llegan a 0, cambia a modo defensa"
  },
  State_2979_Desc = {
    Text = "Equipo Único: El veneno y el blindaje causados por el portador aumentan en <WeaponEffect_Num:[StateArg3]%. La probabilidad de crítico y el daño crítico del \"golpear\" del portador aumentan en <WeaponEffect_Num:[StateArg1]%, y obtiene un escudo equivalente al <WeaponEffect_Num:[StateArg2]%> de su PV Max. El efecto del escudo se puede activar un máximo de 1 vez por turno."
  },
  State_2979_Name = {
    Text = "Transgresión del Sufrimiento"
  },
  State_2979_WeaponDesc = {
    Text = "El veneno y el escudo causados por el portador aumentan en <WeaponEffect_Num:[StateArg3]%>. La probabilidad de crítico y el daño crítico del \"golpe\" del portador aumentan en <WeaponEffect_Num:[StateArg1]>, y obtiene un escudo equivalente al [StateArg2]% de la salud máxima ([DescArg1]), el efecto del escudo puede activarse un máximo de 1 vez por turno."
  },
  State_2983_Desc = {
    Text = "Si está en tu mano durante la fase de descarte, la carta se consumirá y no aparecerá más en esta batalla"
  },
  State_2983_Name = {
    Text = "<NothingnessIconKeywords: Ilusión>"
  },
  State_2983_WeaponDesc = {
    Text = "Si está en tu mano durante la fase de descarte, no entra en el montón de descartes y no se puede usar nuevamente en esta batalla"
  },
  State_2985_Desc = {
    Text = "Hasta el final del turno, cada vez que inflijas daño, recupera [Layer] puntos de vida al final del turno"
  },
  State_2985_Name = {
    Text = "Diamante en bruto"
  },
  State_2985_WeaponDesc = {
    Text = "Hasta el final del turno, cada vez que inflijas daño, recupera [Layer] puntos de vida"
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
    Text = "Al devorar un embrión, regresa de la pila de descarte a la pila de cartas y la capacidad de cálculo se convierte en 0"
  },
  State_2988_Name = {
    Text = "Vástago Maldito"
  },
  State_2988_WeaponDesc = {
    Text = "Al devorar un embrión, regresa de la pila de descarte a la pila de cartas y la capacidad de cálculo se convierte en 0"
  },
  State_2989_Desc = {
    Text = "Después de jugar una carta de despertar, baraja una copia temporal de esa carta con costo reducido en 1 en el mazo"
  },
  State_2990_Desc = {
    Text = "Al jugar, todos los enemigos pierden [StateArg1] de fuerza temporal"
  },
  State_2990_Name = {
    Text = "<Rune_18_High:Agotamiento avanzado>"
  },
  State_2992_Desc = {
    Text = "Después de robar \"Vacío\", reduce la locura obtenida por todos los Despertados en un 50% durante este turno"
  },
  State_2992_Name = {Text = "Vacío"},
  State_2992_WeaponDesc = {
    Text = "Después de robar \"Vacío\", reduce la locura obtenida por todos los Despertados en un 50% durante este turno"
  },
  State_2993_Name = {
    Text = "Contador de piel de serpiente extraña de creación"
  },
  State_2994_Desc = {
    Text = "Daño de tentáculos +[StateArg1] cuando están al máximo"
  },
  State_2994_Name = {
    Text = "Poder de la bendición"
  },
  State_2994_WeaponDesc = {
    Text = "Daño de tentáculos +[StateArg1] cuando están al máximo"
  },
  State_2996_Desc = {
    Text = "Al jugar, un tentáculo ataca [StateArg1] veces"
  },
  State_2996_Name = {
    Text = "<Rune_11:Dominio>"
  },
  State_2997_Desc = {
    Text = "Cada turno, tras infligir el 3º daño, obtiene [Arg1] puntos de escudo. Tras infligir el 6º daño, obtiene [Arg2] puntos de fuerza"
  },
  State_2997_Name = {
    Text = "Paso seguro"
  },
  State_3001_Desc = {
    Text = "Al recibir un ataque, la locura obtenida aumenta en 2 puntos"
  },
  State_3002_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_3002_Name = {
    Text = "Estado@Prototipo de Cañón Láser Suerte"
  },
  State_3003_Desc = {
    Text = "Después de jugar, no pasará al montón de descarte, sino que será removido del mazo"
  },
  State_3003_Name = {
    Text = "<DepleteIconKeywords:Consumo>"
  },
  State_3003_WeaponDesc = {
    Text = "Después de jugar, la carta no irá al montón de descarte, no podrá usarse nuevamente en esta batalla"
  },
  State_3004_Desc = {
    Text = "[Capa] Inmunidad al estado de veneno aplicado durante el turno"
  },
  State_3004_Name = {
    Text = "Inmunidad a envenenamiento"
  },
  State_3008_Desc = {
    Text = "Al inicio de cada turno, añade 1 capa de lentitud a las cartas restantes en la mano. Para las cartas que consumen más de 5 puntos de aritmética, conviértelas en piedra"
  },
  State_3008_Name = {
    Text = "¡Aigis despierta!"
  },
  State_3008_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_3011_Desc = {
    Text = "Equipo Único: La probabilidad de crítico y el daño crítico de la \"exaltar\" del portador aumentan en <WeaponEffect_Num:[StateArg2]%. Después de que el portador libere \"exaltar\", obtiene <WeaponEffect_Num:[StateArg1]%> de <PowerIconKeywords:fuerza> equivalente a su CON. Si esta vez la exhalación de aliemus activa el efecto <CardKeyWord:Devorar>, obtiene 1 vez adicional <PowerIconKeywords:fuerza>."
  },
  State_3011_WeaponDesc = {
    Text = "La probabilidad de crítico y el daño crítico de la \"exaltar\" del portador aumentan en <WeaponEffect_Num:[StateArg2]%. Después de que el portador libere \"exaltar\", obtiene <WeaponEffect_Num:[Power:DescArg1]> puntos de fuerza. Si esta vez la exhalación de aliemus activa el efecto <CardKeyWord:Devorar>, obtiene 1 vez adicional <PowerIconKeywords:fuerza>."
  },
  State_3012_Desc = {
    Text = "Estado vacío inútil"
  },
  State_3012_Name = {
    Text = "Estado vacío inútil"
  },
  State_3012_WeaponDesc = {
    Text = "Estado vacío inútil"
  },
  State_3013_Desc = {
    Text = "Los pacientes sedientos de sangre obtienen [StateArg1] puntos de poder al aumentar la Fusión Embrionaria"
  },
  State_3013_Name = {
    Text = "Sanguívoro"
  },
  State_3014_Desc = {
    Text = "Si el oponente tiene 4 o más cartas en mano, al recibir daño, obtén [StateArg1] de escudo"
  },
  State_3014_Name = {Text = "Serpiente"},
  State_3015_Desc = {
    Text = "Estado@Armadura de Cera Equipo"
  },
  State_3015_Name = {
    Text = "Estado@Armadura de Cera Equipo"
  },
  State_3015_WeaponDesc = {
    Text = "Estado@Armadura de Cera Equipo"
  },
  State_3016_Desc = {
    Text = "La vida del monstruo invocado se duplica"
  },
  State_3016_Name = {
    Text = "\"Flujo transversal de vergüenza\""
  },
  State_3016_WeaponDesc = {
    Text = "La vida del monstruo invocado se duplica"
  },
  State_3017_Name = {
    Text = "Estado@Maldición Delirio"
  },
  State_3018_Desc = {
    Text = "\"El Perro Dimensional\" pierde 1 capa por cada punto de vida perdido. Al llegar a 0 capas, obtiene un escudo de [StateArg1] y recupera [StateArg2] capas de barrera dimensional"
  },
  State_3018_Name = {
    Text = "Barrera dimensional"
  },
  State_3019_Desc = {
    Text = "Cada vez que se consumen 10 sellos negros, se recupera el 1% de vida"
  },
  State_3019_Name = {
    Text = "Estado de la Raíz Inversa de la Creación"
  },
  State_3019_WeaponDesc = {
    Text = "Cada vez que se consumen 10 sellos negros, se recupera el 1% de vida"
  },
  State_3020_Desc = {
    Text = "Si recibiste daño en el último turno, obtén inmunidad por un turno al inicio del próximo"
  },
  State_3020_Name = {
    Text = "Adaptación"
  },
  State_3020_WeaponDesc = {
    Text = "Si recibiste daño en el último turno, obtén inmunidad por un turno al inicio del próximo"
  },
  State_3021_Desc = {
    Text = "Al comienzo del turno, obtén 1 aritmética"
  },
  State_3021_Name = {
    Text = "Estado@potencia máxima -2"
  },
  State_3023_Desc = {
    Text = "Cada vez que se recibe Daño Activo en este turno, inflige [Layer] de <FixedDamage:DMG Puro> a la fuente del daño."
  },
  State_3023_Name = {
    Text = "Contraataque temporal"
  },
  State_3023_WeaponDesc = {
    Text = "Cada vez que se recibe Daño Activo, inflige [Layer] de <FixedDamage:DMG Puro> al atacante."
  },
  State_3024_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_3024_Name = {
    Text = "Estado@Prototipo de Cuchillo Resistencia"
  },
  State_3025_Desc = {
    Text = "Cada vez que juegue 1 carta, aumentará su tasa crítica en el turno actual en un 10%"
  },
  State_3026_Desc = {
    Text = "Después de que comience la batalla, se barajarán [StateArg1] copias temporales en la pila de robo, las cartas originales y copias espejo obtendrán retener"
  },
  State_3026_Name = {
    Text = "<Rune_8_High:Espejo avanzado>"
  },
  State_3026_WeaponDesc = {
    Text = "Después de que comience la batalla, se barajarán [StateArg1] copias temporales en la pila de robo"
  },
  State_3027_Desc = {
    Text = "Al finalizar la batalla, obtienes 50 el sigilo negro adicional y 1 carta de síntoma"
  },
  State_3028_Name = {
    Text = "Estado@potencia aumentada en 2 tras el inicio del turno"
  },
  State_3029_Desc = {
    Text = "Cada vez que recibes 1 punto de daño, reduce 1 capa. Cuando las capas llegan a 0, cambia a modo defensa"
  },
  State_3029_Name = {
    Text = "Contador de cartas"
  },
  State_3029_WeaponDesc = {
    Text = "Cada vez que recibes 1 punto de daño, reduce 1 capa. Cuando las capas llegan a 0, cambia a modo defensa"
  },
  State_3033_Desc = {
    Text = "Cada vez que juegues 10 cartas, obtén una barrera que bloquea cualquier daño. Si ya tienes una barrera, recupera [Arg1] puntos de vida"
  },
  State_3034_Desc = {
    Text = "Equipo único: Al jugar 1 carta del portador, se obtienen <WeaponEffect_Num:[StateArg1]> energía-s de llave de plata. Este efecto se puede aplicar un máximo de 3 veces por turno"
  },
  State_3034_WeaponDesc = {
    Text = "Cada vez que juegue 1 carta de equipador, obtendrá <WeaponEffect_Num:[StateArg1]> energía-s de plata. Este efecto puede ocurrir un máximo de 3 veces por turno"
  },
  State_3035_Desc = {
    Text = "Al jugar, un tentáculo ataca [StateArg1] veces"
  },
  State_3035_Name = {
    Text = "<Rune_11_High:Dominio avanzado>"
  },
  State_3035_WeaponDesc = {
    Text = "Al jugar, un tentáculo ataca a todos los enemigos [StateArg1] veces"
  },
  State_30364_Desc = {
    Text = "Esta carta en mano aumenta el límite de cartas en mano +1"
  },
  State_30364_Name = {
    Text = "Ignorar límite de cartas en mano"
  },
  State_30369_Desc = {
    Text = "Este turno, el límite de cartas en mano +[Layer]"
  },
  State_30369_Name = {
    Text = "Tamaño Máximo de la Mano"
  },
  State_3036_Desc = {
    Text = "El efecto de debilidad y fragilidad aumenta del 33% al 50%"
  },
  State_3036_Name = {
    Text = "\"Onda de Extinción\""
  },
  State_3036_WeaponDesc = {
    Text = "El efecto de debilidad y fragilidad aumenta del 33% al 50%"
  },
  State_3038_Desc = {
    Text = "Único del equipo: Después de liberar la llave, el portador obtiene <WeaponEffect_Num:[StateArg1]> de locura"
  },
  State_3038_WeaponDesc = {
    Text = "Después de liberar la orden clave, el portador obtiene <WeaponEffect_Num:[StateArg1]> de locura"
  },
  State_3040_Desc = {
    Text = "Al inicio de cada turno, aplica [Layer] capas de [Encadenamiento] a tu equipo"
  },
  State_3040_Name = {Text = "Ataduras"},
  State_3040_WeaponDesc = {
    Text = "Al inicio de cada turno, aplica [Layer] capas de [Encadenamiento] a tu equipo"
  },
  State_3041_Desc = {
    Text = "Permanente en el mazo"
  },
  State_3041_Name = {
    Text = "<CardKeyWord:Carta de Síntomas>"
  },
  State_3042_Desc = {
    Text = "Cada vez que causas daño, obtienes [Arg1] fuerza temporal en este turno, se acumula hasta 3 veces. Al alcanzar el máximo, el efecto se duplica"
  },
  State_3043_Desc = {
    Text = "En turnos pares, daño recibido -50%, daño infligido +33%"
  },
  State_3043_Name = {Text = "Caprichoso"},
  State_3043_WeaponDesc = {
    Text = "En turnos pares, daño recibido -50%, daño infligido +33%"
  },
  State_3045_Desc = {
    Text = "Al liberar la exaltación, el despertador correspondiente obtiene 20 locura"
  },
  State_3045_Name = {
    Text = "Velo de la Deidad sin Nombre"
  },
  State_3046_Desc = {
    Text = "Equipo Único: Cada vez que un enemigo muere, obtienes [StateArg1] marcas negras. Después de que el portador mate a un enemigo, el daño crítico del portador en este nivel aumenta permanentemente en <WeaponEffect_Num:[StateArg2]%>, acumulándose hasta un máximo de 5 capas. Cada vez que el portador activa el efecto de impulso, el daño final causado por el portador en este turno aumenta en <WeaponEffect_Num:[StateArg3]%, acumulándose hasta un máximo de 3 capas."
  },
  State_3046_WeaponDesc = {
    Text = "Cada vez que un enemigo muere, obtiene [StateArg1] marcas negras. Al matar a un enemigo, el daño crítico del portador aumenta permanentemente en <WeaponEffect_Num:[StateArg2]%> en este nivel, acumulándose hasta un máximo de 5 capas. Cada vez que el portador activa el efecto de impulso, el daño final infligido por el portador en este turno aumenta en <WeaponEffect_Num:[StateArg3]%>, acumulándose hasta un máximo de 3 capas."
  },
  State_3047_Desc = {
    Text = "Al inicio del turno, obtén [Arg1] de escudo y aumenta este valor en [Arg2] cada turno"
  },
  State_3047_Name = {
    Text = "Mano del Guardián"
  },
  State_3048_Desc = {
    Text = "El espíritu de lucha de Lotan nunca se detiene. Al finalizar cada ronda, Lotan elimina 3 capas de debilidad y vulnerabilidad"
  },
  State_3048_Name = {
    Text = "Rothan se despierta"
  },
  State_3049_Desc = {
    Text = "Aumenta el daño de la próxima ataque de George en 1"
  },
  State_3049_Name = {Text = "Rancor"},
  State_3049_WeaponDesc = {
    Text = "Aumenta el daño de la próxima ataque de George en 1"
  },
  State_3050_Desc = {
    Text = "Al comienzo de la batalla, se baraja 1 carta de [confusión] en el mazo de robo"
  },
  State_3050_Name = {Text = "Miedo"},
  State_3050_WeaponDesc = {
    Text = "Al comienzo de la batalla, se baraja 1 carta de [confusión] en el mazo de robo"
  },
  State_3051_Desc = {
    Text = "Al causar daño no bloqueado, baraja una carta de llanto en la pila de robo"
  },
  State_3051_Name = {
    Text = "Deseo ardiente de cera"
  },
  State_3051_WeaponDesc = {
    Text = "Al causar daño real, baraja una carta de llanto en la pila de robo"
  },
  State_3054_Name = {
    Text = "Estado@Maldición Choque"
  },
  State_3055_Desc = {
    Text = "Al comienzo de la batalla, se inflige 1 capa de debilidad a nuestro equipo"
  },
  State_3055_Name = {
    Text = "Penetración"
  },
  State_3055_WeaponDesc = {
    Text = "Al comienzo de la batalla, se inflige 1 capa de debilidad a nuestro equipo"
  },
  State_3056_Desc = {
    Text = "Al final del turno, elimina 1 capa de debilidad y vulnerabilidad"
  },
  State_3056_Name = {
    Text = "Intimidación"
  },
  State_3058_Desc = {
    Text = "Por cada tentáculo, al final del turno obtén [Arg1] puntos de escudo"
  },
  State_3058_Name = {
    Text = "Apéndice sin nombre"
  },
  State_3060_Desc = {
    Text = "Al inicio del próximo turno, obtén [Layer] puntos de escudo"
  },
  State_3060_Name = {
    Text = "Psique reforjada"
  },
  State_3060_WeaponDesc = {
    Text = "Al inicio del próximo turno, roba [Layer] cartas"
  },
  State_3063_Desc = {
    Text = "Cada vez que causa daño real, añade [Layer] envenenamiento"
  },
  State_3063_Name = {Text = "Toxina"},
  State_3064_Desc = {
    Text = "Recibe daño igual al número de capas antes de jugar una carta. Se elimina al final del turno"
  },
  State_3064_Name = {Text = "Ataduras"},
  State_3064_WeaponDesc = {
    Text = "Recibe daño igual al número de capas antes de jugar una carta. Se elimina al final del turno"
  },
  State_3065_Name = {
    Text = "Estado@Creación Ofrenda del Pasado 2"
  },
  State_3068_Desc = {
    Text = "Al final del turno, recibe [Layer] de <FixedDamage:DMG Puro>."
  },
  State_3068_Name = {
    Text = "<IntoxicationColour: Veneno>"
  },
  State_3068_WeaponDesc = {
    Text = "Al final del turno, recibe [Layer] de <FixedDamage:DMG Puro>."
  },
  State_3069_Name = {
    Text = "Deus ex machina de accesorios"
  },
  State_3069_WeaponDesc = {
    Text = "En el primer turno de cada batalla, obtienes 1 punto adicional de aritmética"
  },
  State_3070_Desc = {
    Text = "Único del equipo: El \"Golpe\" del portador hace que el enemigo objetivo pierda <WeaponEffect_Num:[StateArg1]%> de <PowerIconKeywords:fuerza> temporal igual al ataque del portador. Este efecto se puede activar hasta 3 veces por turno"
  },
  State_3070_WeaponDesc = {
    Text = "El \"golpe\" del portador reduce temporalmente la <WeaponEffect_Num:[Power:DescArg1]> de <PowerIconKeywords:fuerza> del enemigo objetivo. Este efecto puede activarse hasta 3 veces por turno"
  },
  State_3071_Desc = {
    Text = "Único del equipo: Después de usar \"DEF\" del portador, gana <WeaponEffect_Num:[StateArg1]%> de <PowerIconKeywords:fuerza> temporal igual al ataque del portador"
  },
  State_3071_WeaponDesc = {
    Text = "Al jugar la carta de \"DEF\" del portador, obtiene <WeaponEffect_Num:[Power:DescArg1]> puntos temporales de <PowerIconKeywords:Fuerza>"
  },
  State_3072_Desc = {
    Text = "Único del equipo: Después de matar a un enemigo, el portador obtiene <WeaponEffect_Num:[StateArg1]> locura y 1% de daño crítico, efectivo durante toda la exploración"
  },
  State_3072_WeaponDesc = {
    Text = "Después de matar a un enemigo, el portador obtiene <WeaponEffect_Num:[StateArg1]> de locura y un 1% de daño crítico, válido durante toda la exploración"
  },
  State_3073_Desc = {
    Text = "El único de la escuadra: Después de que el portador libera la exaltación, la tasa crítica de todos los aliados en este turno aumenta <WeaponEffect_Num:[StateArg1]％>"
  },
  State_3073_WeaponDesc = {
    Text = "Después de que el equipador libera la exaltación, la tasa crítica de todos los aliados para este turno aumenta <WeaponEffect_Num:[StateArg1]%>"
  },
  State_3074_Desc = {
    Text = "Único del equipo: Tras jugar una carta de síntoma, el portador obtiene <WeaponEffect_Num:[StateArg1]> de locura. Este efecto se puede activar hasta 2 veces por turno. Tras jugar una carta de comando, obtiene 1 de locura"
  },
  State_3074_WeaponDesc = {
    Text = "Después de jugar una carta de síntomas, el portador obtiene <WeaponEffect_Num:[StateArg1]> puntos de locura. Este efecto se activa un máximo de 2 veces por turno. Después de jugar una carta de comando, el portador obtiene 1 punto de locura"
  },
  State_3075_Desc = {
    Text = "El único de la escuadra: Después de que el portador libera la exaltación, obtiene un escudo equivalente a <WeaponEffect_Num:[StateArg1]％> de su defensa"
  },
  State_3075_Name = {
    Text = "Barrera del corazón"
  },
  State_3075_WeaponDesc = {
    Text = "Después de que el equipador libera la exaltación, obtiene <WeaponEffect_Num:[Block:DescArg1]> puntos de escudo"
  },
  State_3076_Desc = {
    Text = "Equipo Único: Después de infligir Daño Activo, la Probabilidad de Crítico del Portador + <WeaponEffect_Num:[StateArg1]%>. Tras un golpe crítico, la Probabilidad de Crítico obtenida por este Efecto se reinicia."
  },
  State_3076_WeaponDesc = {
    Text = "Después de infligir Daño Activo, la Probabilidad de Crítico del Portador + <WeaponEffect_Num:[StateArg1]%>. Tras un golpe crítico, la Probabilidad de Crítico obtenida por este Efecto se reinicia."
  },
  State_3078_Desc = {
    Text = "Este turno, el daño infligido será siempre crítico"
  },
  State_3078_Name = {
    Text = "Temporalmente garantizado para explotar"
  },
  State_3078_WeaponDesc = {
    Text = "La tasa crítica se incrementa en un 100% en esta ronda"
  },
  State_3082_Desc = {
    Text = "Tras liberar la exhalación de aliemus, coloca una carta aleatoria correspondiente al despertador en tu mano, esa carta obtiene agotamiento y ilusión"
  },
  State_3082_Name = {
    Text = "Caso del médico"
  },
  State_3084_Desc = {
    Text = "Al jugar, copia [StateArg1] cartas en el <DimensionalSpaceIconKeywords:Espacio Dimensional> temporal"
  },
  State_3084_Name = {
    Text = "<Rune_13_High:Teletransporte avanzado>"
  },
  State_3084_WeaponDesc = {
    Text = "Al jugar, se consume, pero copia [StateArg1] cartas en el Espacio Dimensional temporal"
  },
  State_3087_Desc = {
    Text = "Daño de cartas de ataque aumentado [Layer] %"
  },
  State_3087_Name = {
    Text = "Daño de cartas de ataque temporalmente aumentado"
  },
  State_3087_WeaponDesc = {
    Text = "Daño de cartas de ataque aumentado [Layer] %"
  },
  State_3088_Desc = {
    Text = "El daño activo recibido aumenta [Layer]. Cada vez que recibe daño, la herida corrosiva se expande, se restaura al inicio del turno"
  },
  State_3088_Name = {
    Text = "Profunda Erosión"
  },
  State_3088_WeaponDesc = {
    Text = "El daño activo recibido aumenta [Layer]. Cada vez que recibe daño, la herida corrosiva se expande, se restaura al inicio del turno"
  },
  State_3092_Name = {
    Text = "Si es una batalla de jefes, todos los despertadores ganan 30 de locura y se eliminan los estados sellados"
  },
  State_3093_Name = {
    Text = "Estado@Contador de Imitación de la Ilusionista"
  },
  State_3094_Desc = {
    Text = "Al robar, te hace vulnerable por 1 turno. Al usar, debilita a todos los enemigos por 1 turno. No se puede vender"
  },
  State_3094_Name = {
    Text = "Estado Maldición Colapso"
  },
  State_3094_WeaponDesc = {
    Text = "Al robar, te hace vulnerable por 1 turno. Al usar, debilita a todos los enemigos por 1 turno. No se puede vender"
  },
  State_3095_Desc = {
    Text = "Daño aumentado en [Layer] puntos en esta etapa"
  },
  State_3095_Name = {
    Text = "FUE Permanente"
  },
  State_3095_WeaponDesc = {
    Text = "Daño aumentado en [Layer] puntos en esta etapa"
  },
  State_3096_Desc = {
    Text = "Convencer a Lotan todavía es un camino largo por recorrer"
  },
  State_3096_Name = {
    Text = "Rothan se despierta"
  },
  State_3098_Desc = {
    Text = "Al recoger, elige una carta, su costo de aritmética se volverá permanente 1"
  },
  State_3099_Desc = {
    Text = "Tras liberar la exhalación de aliemus, obtiene [Arg1] poder en esta ronda"
  },
  State_3100_Desc = {
    Text = "Al inicio de cada turno, la resistencia a la muerte aumenta un 10%. Cuando la resistencia a la muerte supera el 100%, obtén 30 puntos adicionales de maestría en reinos"
  },
  State_3104_Desc = {
    Text = "Este turno, cada vez que recibas daño activo, aumenta el número de ataques de \"Demonio Dulce\" en 1"
  },
  State_3104_Name = {
    Text = "Compartir dolor"
  },
  State_3104_WeaponDesc = {
    Text = "Este turno, cada vez que recibas daño activo, aumenta el número de ataques de \"Demonio Dulce\" en 1"
  },
  State_3106_Desc = {
    Text = "Cuando la vida esté por debajo del 50% ([StateArg1]), se dividirá en 2 \"Obras experimentales\" con vida igual"
  },
  State_3106_Name = {Text = "Dividir"},
  State_3106_WeaponDesc = {
    Text = "Cuando la vida esté por debajo del 50% ([StateArg1]), se dividirá en 3 esculturas de cera de tipo II con vida equivalente"
  },
  State_3108_Name = {
    Text = "Poema circular de accesorios"
  },
  State_3108_WeaponDesc = {
    Text = "Después de que comience el turno par, obtén 1 punto de aritmética"
  },
  State_3109_Name = {
    Text = "Estado@capítulo cuatro resonancia@reducción de potencia 1"
  },
  State_3109_WeaponDesc = {
    Text = "“el ingenuo regalo de vuelta” reduce el consumo de habilidad en 1"
  },
  State_3110_Name = {
    Text = "Estado@capítulo cuatro resonancia@reducción de potencia 1"
  },
  State_3110_WeaponDesc = {
    Text = "“el ingenuo regalo de vuelta” reduce el consumo de habilidad en 1"
  },
  State_3111_Desc = {
    Text = "Al inicio del próximo turno, convierte el escudo restante en el doble de vida"
  },
  State_3111_Name = {
    Text = "Flor eterna"
  },
  State_3112_Desc = {
    Text = "Equipo Único: El veneno causado por el portador aumenta en <WeaponEffect_Num:[StateArg3]%>. Después de que el portador libere la Exaltación, recupera vida equivalente al <WeaponEffect_Num:[StateArg1]%> de su CON, y por cada punto de Aritmética restante, recupera adicionalmente <WeaponEffect_Num:[StateArg2]%> de vida de su CON."
  },
  State_3112_Name = {
    Text = "Banquete Silencioso"
  },
  State_3112_WeaponDesc = {
    Text = "El envenenamiento causado por el portador aumenta en <WeaponEffect_Num:[StateArg3]%>. Después de que el portador libera la explosión de locura, recupera <WeaponEffect_Num:[Heal:DescArg1]> puntos de PV, y por cada punto de aritmética restante, recupera adicionalmente <WeaponEffect_Num:[Heal:DescArg2]> puntos de PV."
  },
  State_3113_Desc = {
    Text = "Estado@PrólogoLocura0_1_4"
  },
  State_3113_Name = {
    Text = "Estado@PrólogoLocura0_1_4"
  },
  State_3113_WeaponDesc = {
    Text = "Estado@PrólogoLocura0_1_4"
  },
  State_3114_Desc = {
    Text = "Estado@PrólogoLocura0_1_2"
  },
  State_3114_Name = {
    Text = "Estado@PrólogoLocura0_1_2"
  },
  State_3114_WeaponDesc = {
    Text = "Estado@PrólogoLocura0_1_2"
  },
  State_3115_Desc = {
    Text = "Estado@PrólogoLocura0_1_2"
  },
  State_3115_Name = {
    Text = "Estado@PrólogoLocura0_1_2"
  },
  State_3115_WeaponDesc = {
    Text = "Estado@PrólogoLocura0_1_2"
  },
  State_3116_Name = {
    Text = "Estado@PrólogoLocura0_1_1"
  },
  State_3117_Desc = {
    Text = "Equipo único: El daño base de \"golpe\" y \"exaltar\" del portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Después de jugar \"golpe\", el portador obtiene un 5% de tasa crítica temporal, aplicándose un máximo de 3 veces; tras alcanzar 3 veces, se obtiene un 15% de daño crítico temporal"
  },
  State_3117_WeaponDesc = {
    Text = "El daño básico de \"Golpe\" y \"Exaltar\" del portador se incrementa en <WeaponEffect_Num:[StateArg1]%>. Tras realizar \"Golpe\", el portador obtiene un 5% de tasa crítica temporal, hasta 3 veces por ronda; al alcanzar 3 veces, obtiene un 15% de daño crítico temporal"
  },
  State_3118_Desc = {
    Text = "Al inicio del turno, responde [Layer]% de vida perdida."
  },
  State_3118_Name = {
    Text = "Protección de la Vela del Piloto"
  },
  State_3120_Desc = {
    Text = "[defensa] obtiene [Arg1] capas de contraataque"
  },
  State_3121_Desc = {
    Text = "Si la intención del enemigo no es atacar, después de causar daño activo o de tentáculo, se añade sangrado equivalente a la mitad de las capas de daño"
  },
  State_3123_Desc = {
    Text = "Equipo Único: El contrataque causado por el portador aumenta en <WeaponEffect_Num:[StateArg3]%. Cada vez que recibe un ataque, obtiene <WeaponEffect_Num:[StateArg1]%> de <PowerIconKeywords:fuerza> temporal equivalente a su ATQ. Después de que el portador use Exaltar, obtiene un contrataque equivalente a <WeaponEffect_Num:[StateArg2]%> de su ATQ."
  },
  State_3123_WeaponDesc = {
    Text = "El contrataque causado por el portador aumenta en <WeaponEffect_Num:[StateArg3]%. Cada vez que recibe 1 ataque, obtiene <WeaponEffect_Num:[Power:DescArg1]> puntos de <PowerIconKeywords:fuerza> temporal. Después de que el portador use exaltar, obtiene <WeaponEffect_Num:[Counterattack:DescArg2]> puntos de contrataque."
  },
  State_3124_Desc = {
    Text = "Los sigilos negros obtenidos por el detective afortunado se duplican"
  },
  State_3124_Name = {
    Text = "Suerte excepcional"
  },
  State_3124_WeaponDesc = {
    Text = "Los sigilos negros obtenidos por el detective afortunado se duplican"
  },
  State_3127_Name = {
    Text = "Estado@Nivel2_10Batalla3Burbuja1"
  },
  State_3128_Desc = {
    Text = "El escudo y la curación aplicados por los Despertados aumentan en [StateArg1]%"
  },
  State_3128_Name = {Text = "cuna"},
  State_3129_Desc = {
    Text = "Antes del inicio del siguiente turno, cada instancia de Daño Activo recibido activa [Layer] contraataques adicionales y contraataques de Tentáculo, infligiendo el 50% del daño."
  },
  State_3129_Name = {
    Text = "Escamas protectoras"
  },
  State_3130_Desc = {
    Text = "Este turno, el daño infligido aumenta [Layer]"
  },
  State_3130_Name = {
    Text = "STR temporal"
  },
  State_3130_WeaponDesc = {
    Text = "Este turno, el daño infligido aumenta [Layer]"
  },
  State_3135_Desc = {
    Text = "Por cada capa que poseas, el número de daños activos causados aumenta en 1."
  },
  State_3135_Name = {
    Text = "<MadnessIconKeywords:locura>"
  },
  State_3136_Name = {
    Text = "Alienación"
  },
  State_3137_Desc = {
    Text = "Al comenzar la batalla, recibe 1 tentáculo, el daño de tentáculo aumenta permanentemente en [Arg1]"
  },
  State_3138_Name = {
    Text = "Paradoja de accesorios"
  },
  State_3138_WeaponDesc = {
    Text = "Después de que el portador use exaltar, la parte aliada obtiene un <RetaliateIconKeywords:contraataque> basado en el 100% de la defensa del portador. Además, su <RetaliateIconKeywords:contraataque> actual aumenta en un 10%"
  },
  State_3139_Desc = {
    Text = "Al entrar en el turno ultra, elimina el estado de debilidad y fragilidad de sí mismo y debilita y vulnera a todos los enemigos durante 2 turnos"
  },
  State_3140_Desc = {
    Text = "Al comienzo de la batalla, se coloca \"fantasma\" en el espacio ultra-dimensional, hasta que tu espacio ultrapdimensional alcance 4 cartas"
  },
  State_3143_Desc = {
    Text = "Al causar daño real, tu equipo pierde [Layer] puntos de fuerza temporal"
  },
  State_3143_Name = {Text = "Parálisis"},
  State_3144_Name = {
    Text = "Las capas de \"veneno\" y \"sangrando\" de nuestro equipo se reducen a la mitad"
  },
  State_3145_Desc = {
    Text = "No se pueden usar cartas durante [Layer] turnos"
  },
  State_3145_Name = {
    Text = "No se puede jugar la carta"
  },
  State_3146_Desc = {
    Text = "Cuando el Apóstol del mar juega 1 carta, genera [StateArg1] tentáculos temporales, que pueden ignorar el límite de tentáculos"
  },
  State_3146_Name = {
    Text = "Poder delegado"
  },
  State_3146_WeaponDesc = {
    Text = "Cuando el Apóstol del mar juega 1 carta, genera [StateArg1] tentáculos temporales, que pueden ignorar el límite de tentáculos"
  },
  State_3149_Desc = {
    Text = "Al inicio del siguiente turno, todo el Daño Activo y Daño de tentáculos recibido +50%."
  },
  State_3149_Name = {
    Text = "Retraso de vulnerabilidad"
  },
  State_3149_WeaponDesc = {
    Text = "Aumenta todo el daño recibido en un 50 %"
  },
  State_3150_Desc = {
    Text = "Después de recibir 3 ataques en un turno, obtén 1 carga de Locura Temporal."
  },
  State_3150_Name = {
    Text = "\"Dulce Dolor\""
  },
  State_3151_Desc = {
    Text = "Al recoger, obtienes permanentemente [Arg1] puntos de Fuerza"
  },
  State_3152_Name = {
    Text = "Estado@Accesorio Re-evolución"
  },
  State_3152_WeaponDesc = {
    Text = "Al final del turno, el portador obtiene 3 puntos de locura. Si la recarga de locura del portador es mayor a 10, obtiene 2 puntos de locura adicionales"
  },
  State_3153_Name = {
    Text = "Estado@Maldición Delirio Restauración"
  },
  State_3154_Name = {
    Text = "Probabilidad de Crítico"
  },
  State_3155_Desc = {
    Text = "Recupera el 10% de la vida perdida cada turno"
  },
  State_3155_Name = {Text = "Medicina"},
  State_3155_WeaponDesc = {
    Text = "Recupera el 10% de la vida perdida cada turno"
  },
  State_3156_Desc = {
    Text = "El primer daño recibido en cada turno se multiplica por 5"
  },
  State_3156_Name = {Text = "En pánico"},
  State_3160_Desc = {
    Text = "Al inicio del turno, añade un \"Paraguas\" que obtiene [Arg1] de alerta este turno a tu mano. Después de jugar 6 cartas, aumenta la alerta de todos los \"Paraguas\" en tu mano en [Arg2]"
  },
  State_3161_Desc = {
    Text = "La cantidad de cartas que roba el oponente se reduce en [Layer], pero todas las cartas se conservan"
  },
  State_3161_WeaponDesc = {
    Text = "Nuestro equipo reduce la cantidad de cartas robadas en [Layer], todas las cartas se conservan"
  },
  State_3163_Desc = {
    Text = "Después de activar resistencia a la muerte, recupera [Layer] puntos de vida"
  },
  State_3163_Name = {
    Text = "Cuna de las estrellas"
  },
  State_3163_WeaponDesc = {
    Text = "Después de activar resistencia a la muerte, recupera [Layer] puntos de vida"
  },
  State_3164_Name = {
    Text = "Cadena de resentimiento"
  },
  State_3165_Name = {
    Text = "La Escurridiza Despertar Espiritual 3"
  },
  State_3166_Name = {
    Text = "Esta batalla ha sido desencadenada"
  },
  State_3168_Desc = {
    Text = "Al inicio del turno, añade un contador de ataques a todos los monstruos"
  },
  State_3168_Name = {
    Text = "Estado@cuchilla de venganza daño por decapitación"
  },
  State_3168_WeaponDesc = {
    Text = "Al inicio del turno, añade un contador de ataques a todos los monstruos"
  },
  State_3170_Desc = {
    Text = "Aplica el costo de la impulsividad"
  },
  State_3170_Name = {
    Text = "Aplica el costo de la impulsividad"
  },
  State_3170_WeaponDesc = {
    Text = "Aplica el costo de la impulsividad"
  },
  State_3171_Name = {
    Text = "Estado@Nivel2_1Batalla3Burbuja1"
  },
  State_3172_Desc = {
    Text = "Cada vez que causas daño, obtienes [StateArg1] puntos de fuerza temporal, se acumula hasta [StateArg2] veces. Al alcanzar el máximo, el efecto se duplica"
  },
  State_3172_Name = {
    Text = "Guijarro ensangrentado de creación"
  },
  State_3174_Desc = {
    Text = "Límite de Vida reducido en 30%"
  },
  State_3174_Name = {
    Text = "Sextante de creación 2"
  },
  State_3174_WeaponDesc = {
    Text = "Límite de Vida reducido en 30%"
  },
  State_3175_Desc = {
    Text = "Al inicio de cada turno, todos los despertados obtienen 10 puntos de locura"
  },
  State_3175_Name = {
    Text = "Sextante de creación 1"
  },
  State_3175_WeaponDesc = {
    Text = "Al inicio de cada turno, todos los despertados obtienen 10 puntos de locura"
  },
  State_3176_Desc = {
    Text = "Reiniciar mazo del prólogo 0_1_1_1"
  },
  State_3176_Name = {
    Text = "Reiniciar mazo del prólogo 0_1_1_1_2"
  },
  State_3176_WeaponDesc = {
    Text = "Reiniciar mazo del prólogo 0_1_1_1"
  },
  State_3177_Desc = {
    Text = "\"Alerta\" retrocede al alcanzar 3 capas y convoca una \"Estatua de Cera\". Las capas se reinician al inicio del turno"
  },
  State_3177_Name = {Text = "Vigilancia"},
  State_3177_WeaponDesc = {
    Text = "\"Alerta\" retrocede al alcanzar 3 capas y convoca una \"Estatua de Cera\". Las capas se reinician al inicio del turno"
  },
  State_3178_Desc = {
    Text = "Aumenta el coste de aritmética de la carta"
  },
  State_3178_Name = {
    Text = "<SlowIconKeywords: Retraso>"
  },
  State_3178_WeaponDesc = {
    Text = "Cada capa de lentitud aumenta el consumo de aritmética de las cartas en 1"
  },
  State_3179_Desc = {
    Text = "Al comienzo de la batalla, se obtienen 20 escudos. Al comienzo de cada turno, si hay escudo, el escudo y la sanación de ese turno aumentan un 50%"
  },
  State_3179_Name = {
    Text = "Protector del jardín de alienación"
  },
  State_3179_WeaponDesc = {
    Text = "Al comienzo de la batalla, se obtienen 20 escudos. Al comienzo de cada turno, si hay escudo, el escudo y la sanación de ese turno aumentan un 50%"
  },
  State_3180_Desc = {
    Text = "La tasa crítica aumenta un 25%. Después de un retorno de vida, existe la posibilidad de causar 1 retorno de vida adicional, con probabilidad igual a la tasa crítica del que causa la recuperación"
  },
  State_3180_Name = {
    Text = "Estado@LlavePlataSueños:CurarCrítico"
  },
  State_3181_Name = {
    Text = "Probabilidad de Crítico"
  },
  State_3183_Desc = {
    Text = "Este turno, el daño crítico aumenta [Layer] %"
  },
  State_3183_Name = {
    Text = "Daño crítico temporal"
  },
  State_3185_Desc = {
    Text = "Aumentar la presión adicional al moverse"
  },
  State_3185_Name = {
    Text = "Bolsa sin fondo de creación 2"
  },
  State_3185_WeaponDesc = {
    Text = "Aumentar la presión adicional al moverse"
  },
  State_3189_Name = {
    Text = "Fuerza retardada del monstruo"
  },
  State_3190_Name = {
    Text = "Llave de la Creación"
  },
  State_3193_Desc = {
    Text = "Al inicio del próximo turno, obtén [Layer] escudo"
  },
  State_3193_Name = {
    Text = "El arte perdido"
  },
  State_3193_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén [Layer] escudo"
  },
  State_3196_Desc = {
    Text = "Después de jugar, obtén [StateArg1] puntos de aritmética"
  },
  State_3196_Name = {
    Text = "<Rune_4_High:Estrategia avanzada>"
  },
  State_3196_WeaponDesc = {
    Text = "Después de jugar, obtén [StateArg1] puntos de aritmética"
  },
  State_3197_Desc = {
    Text = "\"El golpe\" recupera [Arg1] puntos de vida y reduce a la mitad el número de capas de sangrado y veneno"
  },
  State_3197_Name = {
    Text = "Pinza hemostática"
  },
  State_3200_Desc = {
    Text = "Equipo Único: El daño básico y el escudo infligidos por el portador aumentan en <WeaponEffect_Num:[StateArg1]%. Al comenzar la exploración, se añade una carta de \"Golpe\" y \"DEF\" del portador al mazo. Tras jugar \"DEF\", la tasa de crítico y el daño crítico de la siguiente carta \"Golpe\" del portador aumentan en 15%; tras jugar \"Golpe\", el escudo de la siguiente carta \"DEF\" del portador aumenta en 15%, acumulándose hasta 3 veces."
  },
  State_3200_WeaponDesc = {
    Text = "El daño base y el escudo infligido por el portador aumentan en <WeaponEffect_Num:[StateArg1] %>. Al comenzar la exploración, se añade una carta de \"Golpe\" y \"DEF\" del portador al mazo. Tras jugar \"DEF\", la tasa de golpe crítico y el daño crítico de la siguiente carta \"Golpe\" del portador aumentan en un 15%. Tras jugar \"Golpe\", el escudo de la siguiente carta \"DEF\" del portador aumenta en un 15%, acumulándose hasta 3 veces."
  },
  State_3201_Name = {
    Text = "Cadena de resentimiento"
  },
  State_3203_Desc = {
    Text = "Equipo Único: El Escudo causado por el Portador aumenta un <WeaponEffect_Num:[StateArg3]%>. La \"Defensa\" del Portador aplica <IntoxicationIconKeywords:Veneno> equivalente al <WeaponEffect_Num:[StateArg1]%> de la DEF del Portador al enemigo con más PV. Si el Reino actual es \"Carne y sangre\", al aplicar <IntoxicationIconKeywords:Veneno>, <EmbryoFusionIconKeywords:Fusión Embrionaria> + <WeaponEffect_Num:[Blood:StateArg2]>; este efecto puede activarse un máximo de 3 veces por turno."
  },
  State_3203_WeaponDesc = {
    Text = "El Escudo causado por el Portador aumenta un <WeaponEffect_Num:[StateArg3]%>. La \"Defensa\" del Portador aplica <WeaponEffect_Num:[Poison:DescArg1]> capas de <IntoxicationIconKeywords:Veneno> al enemigo con más PV. Si el Reino actual es \"Carne y sangre\", al aplicar <IntoxicationIconKeywords:Veneno>, <EmbryoFusionIconKeywords:Fusión Embrionaria> +<WeaponEffect_Num:[Blood:StateArg2]>; este efecto puede activarse un máximo de 3 veces por turno."
  },
  State_3204_Desc = {
    Text = "Al causar daño real, baraja [StateArg1] cartas de \"herida\" en la pila de robo"
  },
  State_3204_Name = {
    Text = "Laceración"
  },
  State_3204_WeaponDesc = {
    Text = "Al robar, te debilitas durante 1 turno. Al usar, debilita a todos los enemigos durante 1 turno. No se puede vender"
  },
  State_3206_Desc = {
    Text = "Cada vez que juegue 1 carta, aumentará su tasa crítica en el turno actual en [StateArg1]%, con un máximo de [StateArg2] apilamientos. Cuando se alcance el máximo, el efecto se duplica"
  },
  State_3206_Name = {
    Text = "Espejo ritual de Menfis de creación"
  },
  State_3206_WeaponDesc = {
    Text = "Cada vez que juegue 1 carta, aumentará su tasa crítica en el turno actual en [StateArg1]%, con un máximo de [StateArg2] apilamientos. Cuando se alcance el máximo, el efecto se duplica"
  },
  State_3207_Desc = {
    Text = "Por cada punto de vida perdido, elimina 1 capa. Al llegar a 0 capas, obtiene un escudo de [DescArg1]"
  },
  State_3207_Name = {
    Text = "Barrera dimensional"
  },
  State_3208_Desc = {
    Text = "Petrificado, no puede moverse, se elimina al final del turno"
  },
  State_3208_Name = {
    Text = "<PetrifactionIconKeywords:Petrificación>"
  },
  State_3209_Name = {
    Text = "Extracción de vida de accesorios"
  },
  State_3209_WeaponDesc = {
    Text = "Después de que comience la batalla, si la clase del portador es de caro, el poder de ataque aumenta un 25%"
  },
  State_3210_Name = {
    Text = "Estado@cuchilla de venganza iluminar 1"
  },
  State_3211_Desc = {
    Text = "Límite de cartas en mano +2, al final del turno no descartes cartas en mano. Cada vez que pierdas vida, descarta 2 cartas al azar"
  },
  State_3212_Desc = {
    Text = "El Daño Activo y de Tentáculos infligido -25%, elimina 1 Acumulación al final del turno."
  },
  State_3212_Name = {
    Text = "<WeaknessIconKeywords: Debilidad>"
  },
  State_3212_WeaponDesc = {
    Text = "Todo el daño causado disminuye en 25 %"
  },
  State_3213_Desc = {
    Text = "El efecto del escudo y curar aumenta un [Layer] %"
  },
  State_3213_Name = {
    Text = "Escudo temporal y curación efectiva"
  },
  State_3213_WeaponDesc = {
    Text = "El efecto del escudo y curar aumenta un [Layer] %"
  },
  State_3215_Name = {
    Text = "Péndulo temporal \"Oculto\""
  },
  State_3216_Desc = {
    Text = "Al finalizar la batalla, obtienes 100 el sigilo negro adicional, pero solo recibes una carta de síntoma"
  },
  State_3216_Name = {
    Text = "Anillo de la suerte de creación"
  },
  State_3216_WeaponDesc = {
    Text = "Al finalizar la batalla, obtienes 100 el sigilo negro adicional, pero solo recibes una carta de síntoma"
  },
  State_3220_Desc = {
    Text = "Tras liberar la exhalación de aliemus, roba 1 carta. Si la vida es inferior al 25%, roba 1 carta adicional"
  },
  State_3223_Desc = {
    Text = "El efecto de debilidad aumenta en 10%. Cada 3 turnos, añade 1 capa de debilidad a todos los enemigos"
  },
  State_3224_Name = {
    Text = "Aritmética de registro de arkanas"
  },
  State_3225_Name = {
    Text = "Devastador de calaveras"
  },
  State_3226_Desc = {
    Text = "Después de jugar, la carta no irá al montón de descarte, no podrá usarse nuevamente en esta batalla"
  },
  State_3226_Name = {Text = "Consumo"},
  State_3226_WeaponDesc = {
    Text = "Después de jugar, la carta no irá al montón de descarte, no podrá usarse nuevamente en esta batalla"
  },
  State_3227_Desc = {
    Text = "El precio de todas las creaciones se reduce en un 50%"
  },
  State_3227_Name = {
    Text = "Medalla de Comercio de la Creación"
  },
  State_3227_WeaponDesc = {
    Text = "El precio de todas las creaciones se reduce en un 50%"
  },
  State_3228_Desc = {
    Text = "Al inicio del turno, el despertar con menos locura obtiene 25 de locura"
  },
  State_3228_Name = {
    Text = "Locura Arcana de la Creación"
  },
  State_3228_WeaponDesc = {
    Text = "Al inicio del turno, el despertar con menos locura obtiene 25 de locura"
  },
  State_3229_Desc = {
    Text = "Reiniciar mazo del prólogo 0_1_1_1"
  },
  State_3229_Name = {
    Text = "Reiniciar mazo del prólogo 0_1_1_1"
  },
  State_3229_WeaponDesc = {
    Text = "Reiniciar mazo del prólogo 0_1_1_1"
  },
  State_3230_Name = {
    Text = "Estado@retraso genérico potencia"
  },
  State_3232_Desc = {
    Text = "Estado@MonstruoRanuraDimensional"
  },
  State_3232_Name = {
    Text = "Estado@MonstruoRanuraDimensional"
  },
  State_3232_WeaponDesc = {
    Text = "Estado@MonstruoRanuraDimensional"
  },
  State_3234_Desc = {
    Text = "Al comenzar la batalla, recibe 3 puntos de poder, pero cada vez que recibas daño, aumenta en 5"
  },
  State_3234_Name = {
    Text = "Dos al agua"
  },
  State_3235_Desc = {
    Text = "Al comenzar la batalla, recibe [Layer] puntos de poder, pero cada vez que recibas daño, aumenta en 5"
  },
  State_3235_Name = {
    Text = "Dos al agua"
  },
  State_3236_Desc = {
    Text = "Al jugar, otros Despertados obtienen [StateArg1] de locura"
  },
  State_3236_Name = {
    Text = "<Rune_16_High:Catalizar avanzado>"
  },
  State_3237_Desc = {
    Text = "Cada 3 turnos, obtén 3 tentáculos que ignoran el límite de tentáculos y se eliminan al final del turno"
  },
  State_3238_Desc = {
    Text = "Al comienzo de la batalla, se otorga un estado que aumenta todos los daños recibidos por los enemigos"
  },
  State_3238_Name = {
    Text = "Al comienzo de la batalla, se otorga un estado que aumenta todos los daños recibidos por los enemigos"
  },
  State_3238_WeaponDesc = {
    Text = "Al comienzo de la batalla, se otorga un estado que aumenta todos los daños recibidos por los enemigos"
  },
  State_3239_Desc = {
    Text = "Aumenta el ataque en [Layer] puntos"
  },
  State_3239_Name = {
    Text = "Aumento de ATQ General"
  },
  State_3239_WeaponDesc = {
    Text = "Aumenta el ataque en [Layer] puntos"
  },
  State_3242_Name = {
    Text = "Coloca 2 cartas <DerivativeCardKeywords_4:\"inspiración\"> en el mazo de robar"
  },
  State_3243_Desc = {
    Text = "Poder de cálculo de carta aumentado"
  },
  State_3243_Name = {
    Text = "Poder de cálculo de carta aumentado"
  },
  State_3243_WeaponDesc = {
    Text = "Poder de cálculo de carta aumentado"
  },
  State_3244_Desc = {
    Text = "La vida del monstruo invocado se duplica"
  },
  State_3244_Name = {
    Text = "\"Flujo transversal de vergüenza\""
  },
  State_3244_WeaponDesc = {
    Text = "La vida del monstruo invocado se duplica"
  },
  State_3245_Desc = {
    Text = "Al comenzar la batalla, la tasa crítica de nuestro equipo disminuye un 30%, el daño crítico aumenta un 30%"
  },
  State_3245_Name = {Text = "Inhibir"},
  State_3245_WeaponDesc = {
    Text = "Al comenzar la batalla, la tasa crítica de nuestro equipo disminuye un 30%, el daño crítico aumenta un 30%"
  },
  State_3246_Desc = {
    Text = "Al comienzo de la batalla, la vida de los enemigos normales aumenta un 30%, y tras la victoria, se otorgan 25 sellos negros adicionales"
  },
  State_3246_Name = {
    Text = "Bandera de batalla rota de creación"
  },
  State_3246_WeaponDesc = {
    Text = "Al comienzo de la batalla, la vida de los enemigos normales aumenta un 30%, y tras la victoria, se otorgan 25 sellos negros adicionales"
  },
  State_3247_Desc = {
    Text = "[Exaltar]Reduce el costo de aritmética de todas las cartas en mano en -1"
  },
  State_3247_Name = {
    Text = "Luz de la civilización mutada"
  },
  State_3247_WeaponDesc = {
    Text = "[Exaltar]Reduce el costo de aritmética de todas las cartas en mano en -1"
  },
  State_3249_Desc = {
    Text = "Los demás aliados obtienen 1 carga de Locura, que se elimina al morir esta unidad."
  },
  State_3249_Name = {Text = "Agitación"},
  State_3249_WeaponDesc = {
    Text = "Otros aliados obtienen 1 nivel de locura, se elimina al morir"
  },
  State_3250_Desc = {
    Text = "Permanece en el mazo después del combate, pero se elimina permanentemente al ser jugada o consumida."
  },
  State_3250_Name = {
    Text = "<DestructionKeywords:Destruir>"
  },
  State_3250_WeaponDesc = {
    Text = "Al jugar, se elimina permanentemente"
  },
  State_3251_Desc = {
    Text = "Al recibir Daño Activo o Daño de tentáculos, inmune al daño y pierde 1 carga. Se elimina al inicio del turno."
  },
  State_3251_Name = {
    Text = "<ParcloseColour:Barrera temporal>"
  },
  State_3252_Desc = {
    Text = "Cuando la flor de lodo aplica el escudo, la salud máxima aumenta en [StateArg2]"
  },
  State_3252_Name = {
    Text = "Convergencia de limo"
  },
  State_3252_WeaponDesc = {
    Text = "Cuando la flor de lodo aplica el escudo, la salud máxima aumenta en [StateArg2]"
  },
  State_3253_Desc = {
    Text = "Obtén [StateArg1] puntos de alerta temporal"
  },
  State_3253_Name = {
    Text = "<CardKeyWord:Arma Mecánica - Escudo>"
  },
  State_3253_WeaponDesc = {
    Text = "Obtén [StateArg1] puntos de alerta temporal"
  },
  State_3255_Name = {
    Text = "Contrataque"
  },
  State_3256_Name = {
    Text = "Estado@Maldición Elación"
  },
  State_3259_Desc = {
    Text = "Aumenta las instancias de Daño Activo infligido en [Layer]."
  },
  State_3259_Name = {
    Text = "<MadnessColour:Locura>"
  },
  State_3260_Desc = {
    Text = "Cuando el espacio transdimensional alcanza su límite, obtén un turno extra, no se roban cartas, sino que las cartas del espacio transdimensional se añaden a la mano"
  },
  State_3260_Name = {
    Text = "<DimensionalSpaceIconKeywords:Espacio dimensional>"
  },
  State_3260_WeaponDesc = {
    Text = "Cuando el espacio transdimensional alcanza su límite, obtén un turno extra transdimensional, todas las cartas del espacio transdimensional se añaden a la mano"
  },
  State_3261_Desc = {
    Text = "El daño de sus monstruos invocados se duplica"
  },
  State_3261_Name = {
    Text = "\"Legión de Cera\""
  },
  State_3261_WeaponDesc = {
    Text = "El daño de sus monstruos invocados se duplica"
  },
  State_3262_Desc = {
    Text = "Estado@Revestimiento de Cera Equipo"
  },
  State_3262_Name = {
    Text = "Estado@Revestimiento de Cera Equipo"
  },
  State_3262_WeaponDesc = {
    Text = "Estado@Revestimiento de Cera Equipo"
  },
  State_3263_Name = {
    Text = "Estado@Nautilus Concha Contraataque"
  },
  State_3264_Name = {
    Text = "Garantizado"
  },
  State_3265_Name = {
    Text = "Descarte y elimínelo"
  },
  State_3266_Desc = {
    Text = "El salto de fortalecimiento de la Ciudad de los Sueños Muertos"
  },
  State_3266_Name = {
    Text = "Estado@ciudad del sueño muerte fortalecer salto"
  },
  State_3267_Desc = {
    Text = "Al comenzar la batalla, recibe 5 capas de [armadura de cera]"
  },
  State_3267_Name = {
    Text = "\"Señor Cera\""
  },
  State_3267_WeaponDesc = {
    Text = "Al comenzar la batalla, recibe 5 capas de [armadura de cera]"
  },
  State_3268_Desc = {
    Text = "Al comienzo del turno, roba 1 carta. Cada vez que robas 1 carta, cambia aleatoriamente su coste de aritmética (0-4)"
  },
  State_3268_Name = {
    Text = "Caleidoscopio de creación"
  },
  State_3268_WeaponDesc = {
    Text = "Al comienzo del turno, roba 1 carta. Cada vez que robas 1 carta, cambia aleatoriamente su coste de aritmética (0-4)"
  },
  State_3269_Desc = {
    Text = "Al obtener el segundo escudo en cada turno, obtienes [Arg1] capas de contraataque. Al obtener el cuarto escudo en cada turno, infliges 1 daño de contraataque a todos los enemigos"
  },
  State_3269_Name = {
    Text = "Verdad sin ataduras"
  },
  State_3270_Name = {
    Text = "Estado@Capítulo Dos_Resonancia Copia"
  },
  State_3271_Desc = {
    Text = "[golpe] aplica [Arg1] capas de veneno a todos los enemigos"
  },
  State_3272_Desc = {
    Text = "Al causar daño no bloqueado, recupera 3 veces el daño real como vida, se elimina al causar daño"
  },
  State_3272_Name = {Text = "Vampirismo"},
  State_3273_Desc = {
    Text = "Único del equipo: Tras jugar una carta del portador, obtiene un escudo igual al <WeaponEffect_Num:[StateArg1]%> de la defensa del portador. Por cada tentáculo, el escudo aumenta en <WeaponEffect_Num:[StateArg2]%> de la defensa del portador. Este efecto solo se activa una vez por turno"
  },
  State_3273_Name = {
    Text = "La Dama Coral Caída"
  },
  State_3273_WeaponDesc = {
    Text = "Obtén <WeaponEffect_Num:[Block:DescArg1]> puntos de escudo al jugar una carta del portador, por cada tentáculo aumenta el escudo en <WeaponEffect_Num:[DescArg2]>. Este efecto solo se activa una vez por turno"
  },
  State_3274_Desc = {
    Text = "Al recibir daño activo, añade una capa de conteo al equipo"
  },
  State_3274_Name = {
    Text = "Estado@cuchilla de venganza cuenta del equipo"
  },
  State_3274_WeaponDesc = {
    Text = "Al recibir daño activo, añade una capa de conteo al equipo"
  },
  State_3277_Desc = {
    Text = "Al jugar, el Despertado obtiene [StateArg1] de locura"
  },
  State_3277_Name = {
    Text = "<Rune_5:Frenesí>"
  },
  State_3280_Name = {
    Text = "Huelga predeterminada"
  },
  State_3281_Desc = {
    Text = "Aumenta el daño activo"
  },
  State_3281_Name = {
    Text = "<PowerIconKeywords:Fuerza>"
  },
  State_3281_WeaponDesc = {
    Text = "El daño causado aumenta"
  },
  State_3282_Desc = {
    Text = "Número de golpes y aumento de daño"
  },
  State_3282_Name = {
    Text = "<CardKeyWord:Mejorar>"
  },
  State_3282_WeaponDesc = {
    Text = "Aumenta un daño"
  },
  State_3283_Desc = {
    Text = "Al inicio de cada turno, recupera [StateArg1] de vida. Si la vida está por debajo del 50%, la recuperación aumenta a [StateArg2]"
  },
  State_3283_Name = {
    Text = "Preparado de incienso de creación"
  },
  State_3283_WeaponDesc = {
    Text = "Al inicio de cada turno, recupera [StateArg1] de vida. Si la vida está por debajo del 50%, la recuperación aumenta a [StateArg2]"
  },
  State_3287_Desc = {
    Text = "Al inicio del combate, baraja 2 cartas de \"Inspiración\" en tu mazo. Cada batalla completada mejora esta creación, hasta un máximo de 3 veces"
  },
  State_3288_Desc = {
    Text = "Estado@Estado Vacío"
  },
  State_3288_Name = {
    Text = "Estado@Estado Vacío"
  },
  State_3288_WeaponDesc = {
    Text = "Estado@Estado Vacío"
  },
  State_3289_Desc = {
    Text = "Cada vez que recibes 1 punto de daño, reduce 1 capa. Cuando las capas llegan a 0, reemplaza la intención con \"flor inmortal\" y usa un conjunto de habilidades defensivas"
  },
  State_3289_Name = {
    Text = "Flor eterna"
  },
  State_3289_WeaponDesc = {
    Text = "Cada vez que recibes 1 punto de daño, reduce 1 capa. Cuando las capas llegan a 0, cambia a modo defensa"
  },
  State_3290_Desc = {
    Text = "La criatura que una vez fue \"Miriam\" está en un estado de obsesión y desesperación extremas. Rompe su última ilusión y pon fin a milenios de locura"
  },
  State_3290_Name = {
    Text = "Obstinación"
  },
  State_3291_Desc = {
    Text = "Al causar daño real, tu equipo pierde 3 puntos de STR temporal."
  },
  State_3291_Name = {Text = "Parálisis"},
  State_3292_Desc = {
    Text = "Al liberar la exhalación de aliemus, cada vez que un enemigo va a infligir 1 punto de daño, se le aplica [Arg1] capas de veneno"
  },
  State_3293_Desc = {
    Text = "Daño reducido en [Layer] puntos en esta etapa"
  },
  State_3293_Name = {Text = "STR▼"},
  State_3293_WeaponDesc = {
    Text = "Daño y daño de tentáculos reducidos en [Layer] puntos en esta etapa"
  },
  State_3294_Name = {
    Text = "Estado@Maldición Paranoia"
  },
  State_3296_Desc = {
    Text = "Al descartar o jugar, remuévela"
  },
  State_3296_Name = {
    Text = "Al descartar o jugar, remuévela"
  },
  State_3296_WeaponDesc = {
    Text = "Al robar, te debilitas durante 1 turno. Al usar, debilita a todos los enemigos durante 1 turno. No se puede vender"
  },
  State_3297_Desc = {
    Text = "Estado@Reina de Espinas Despertar_Forma"
  },
  State_3297_Name = {
    Text = "Estado@Reina de Espinas Despertar_Forma"
  },
  State_3297_WeaponDesc = {
    Text = "Estado@Reina de Espinas Despertar_Forma"
  },
  State_3298_Desc = {
    Text = "Este turno, el próximo efecto de salto se activará seguro"
  },
  State_3298_Name = {
    Text = "Salto siempre se activará"
  },
  State_3298_WeaponDesc = {
    Text = "Este turno, el efecto de salto no requiere condiciones"
  },
  State_3301_Name = {
    Text = "Conteo del vino estelar"
  },
  State_3302_Desc = {
    Text = "Aplica congelación eterna"
  },
  State_3302_Name = {
    Text = "Aplica congelación eterna"
  },
  State_3302_WeaponDesc = {
    Text = "Aplica congelación eterna"
  },
  State_3304_Desc = {
    Text = "Al final del turno, el Despertado correspondiente a la última carta de comando jugada obtiene 15 Locura. Si también tienes la \"Estatua de la Madre\", los otros Despertados obtienen 5 Locura"
  },
  State_3305_Desc = {
    Text = "Después de jugar, se barajan [StateArg1] cartas \"Inspiración\" en el montón de robo. \"Inspiración\": obtén 1 aritmética, roba 1 carta, retener, consumir"
  },
  State_3305_Name = {
    Text = "<Rune_17:Inspiración>"
  },
  State_3307_Name = {
    Text = "(Restante:[Layer])"
  },
  State_3308_Desc = {
    Text = "Al comienzo del turno, si el número de cartas en mano del turno anterior es mayor a 2, obtén 2 de aritmética"
  },
  State_3309_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_3309_Name = {
    Text = "Estado@Prototipo de Espada Larga Resistencia"
  },
  State_3310_Desc = {
    Text = "Cuando el Migrante aplica un escudo, obtiene [Energy:StateArg2] locura"
  },
  State_3310_Name = {
    Text = "Autoencarcelamiento"
  },
  State_3310_WeaponDesc = {
    Text = "Cuando el Migrante aplica un escudo, obtiene [Energy:StateArg2] locura"
  },
  State_3312_Desc = {
    Text = "Cada vez que recuperes vida, obtienes [Arg1] puntos de contraataque; si tu vida es mayor al 75%, obtienes [Arg2] puntos de contraataque adicionales"
  },
  State_3313_Desc = {
    Text = "Al inicio del turno, obtén [Arg1] puntos de fuerza por este turno, pierde [Arg2] puntos de fuerza por cada carta jugada"
  },
  State_3314_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_3314_Name = {
    Text = "No Activado"
  },
  State_3315_Desc = {
    Text = "Después de jugar la primera carta en cada turno, convierte 2 cartas aleatorias en tu mano en sus versiones originales, restaurándolas al final del turno"
  },
  State_3315_Name = {
    Text = "Campana de viento de creación"
  },
  State_3316_Desc = {
    Text = "Al final del turno, el escudo se mantiene"
  },
  State_3316_Name = {
    Text = "DEF protectora"
  },
  State_3316_WeaponDesc = {
    Text = "Al final del turno, el escudo se mantiene"
  },
  State_3317_Desc = {
    Text = "Al final del turno, pierde todos los escudos"
  },
  State_3317_Name = {
    Text = "Grilletes: Padre biológico"
  },
  State_3318_Name = {
    Text = "Estado@Abrazo del Seductor Sediento de Sangre Marca de Devoración"
  },
  State_3323_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_3323_Name = {
    Text = "Estado@Prototipo de Espada Larga Locura"
  },
  State_3324_Desc = {
    Text = "Este turno, el daño crítico aumenta [Layer] %"
  },
  State_3324_Name = {
    Text = "Daño crítico temporal"
  },
  State_3324_WeaponDesc = {
    Text = "Este turno, el daño crítico aumenta [Layer] %"
  },
  State_3325_Desc = {
    Text = "Cada vez que se reinicie la biblioteca, se añaden 2 cartas de \"Tridente\" que obtuvieron [Arg1] puntos de poder en este turno y 1 carta de \"Sombrilla\" que obtuvo [Arg2] puntos de alerta en este turno a la mano"
  },
  State_3326_Desc = {
    Text = "Inmunidad al primer daño activo cada turno"
  },
  State_3326_Name = {Text = "Firmemente"},
  State_3326_WeaponDesc = {
    Text = "Inmunidad al primer daño activo cada turno"
  },
  State_3327_Desc = {
    Text = "Vida del monstruo antes de morir"
  },
  State_3327_Name = {
    Text = "HP del monstruo antes de morir"
  },
  State_3327_WeaponDesc = {
    Text = "Vida del monstruo antes de morir"
  },
  State_3328_Desc = {
    Text = "Al recibir daño letal en esta batalla, resucita una vez y recupera [Layer] puntos de vida. No se puede dispersar."
  },
  State_3328_Name = {
    Text = "Ave del paraíso inmortal"
  },
  State_3329_Desc = {
    Text = "Cada vez que juegue 5 cartas, obtendrá una copia de la carta más a la izquierda en su mano, pero con adición de ilusion y agotamiento"
  },
  State_3330_Desc = {
    Text = "El consumo de aritmética de la carta aumenta en [Layer] puntos. Después de jugar la carta, este efecto negativo será removido"
  },
  State_3330_Name = {
    Text = "<SlowColour:Retraso [Capa]>"
  },
  State_3330_WeaponDesc = {
    Text = "El consumo de aritmética de la carta aumenta en [Layer] puntos"
  },
  State_3332_Desc = {
    Text = "Al recibir Daño Activo o de Tentáculos, obtiene Inmunidad al daño y pierde 1 Acumulación."
  },
  State_3332_Name = {
    Text = "<ParcloseColour:Barrera>"
  },
  State_3335_Desc = {
    Text = "Al comienzo de la batalla, se aplica 1 capa de vulnerabilidad a todos los enemigos. \"Maldición de estasis\" aumenta adicionalmente el efecto de vulnerabilidad que reciben los enemigos en un 25%"
  },
  State_3335_Name = {
    Text = "Ojo de piedra, despertar 6"
  },
  State_3336_Name = {
    Text = "Estado@George@CurarAlMorir"
  },
  State_3337_Name = {
    Text = "Rito Bermellón"
  },
  State_3339_Desc = {
    Text = "Aumenta el ataque en [Layer] puntos"
  },
  State_3339_Name = {
    Text = "Aumento temporal del poder de ataque"
  },
  State_3339_WeaponDesc = {
    Text = "Aumenta el ataque en [Layer] puntos"
  },
  State_3340_Desc = {
    Text = "Tras liberar la exhalación de aliemus, el daño de la exhalación de aliemus en este combate aumenta [Arg1], acumulándose hasta 5 veces. Al alcanzar el máximo, el despertador de esta exhalación obtenida recibe 100 aliemus"
  },
  State_3341_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_1"
  },
  State_3341_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_1"
  },
  State_3341_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_1"
  },
  State_3342_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_2"
  },
  State_3342_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_2"
  },
  State_3342_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_2"
  },
  State_3343_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_3"
  },
  State_3343_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_3"
  },
  State_3343_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_3"
  },
  State_3344_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_4"
  },
  State_3344_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_4"
  },
  State_3344_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_4"
  },
  State_3345_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_5"
  },
  State_3345_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_5"
  },
  State_3345_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_5"
  },
  State_3346_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_5"
  },
  State_3346_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_5"
  },
  State_3346_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_6"
  },
  State_3347_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_5"
  },
  State_3347_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_5"
  },
  State_3347_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_2_7"
  },
  State_3348_Desc = {
    Text = "Al jugar, roba [StateArg1] cartas"
  },
  State_3348_Name = {
    Text = "<Rune_3_High:Destreza avanzada>"
  },
  State_3348_WeaponDesc = {
    Text = "Al jugar, roba [StateArg1] cartas"
  },
  State_3350_Desc = {
    Text = "Al liberar la exaltación, pierde el 10% de la vida actual y roba [Arg1] puntos de poder a todos los enemigos en este turno"
  },
  State_3351_Name = {
    Text = "Estado@AñadirAlMazo"
  },
  State_3352_Name = {
    Text = "Astrolabio de la constelación del libro secreto de creación 1"
  },
  State_3354_Name = {
    Text = "Astrolabio de la constelación del libro secreto de creación 2"
  },
  State_3356_Name = {
    Text = "Fin del turno: Envenenamiento por Asfixia"
  },
  State_3357_Desc = {
    Text = "Al inicio del próximo turno, daño de tentáculo +[Layer]"
  },
  State_3357_Name = {
    Text = "Daño de tentáculo retardado"
  },
  State_3358_Desc = {
    Text = "Al inicio del próximo turno, obtén [Layer] puntos de escudo"
  },
  State_3358_Name = {
    Text = "Arte perdido - Escudo"
  },
  State_3359_Desc = {
    Text = "La tercera carta que juegues tendrá un efecto adicional"
  },
  State_3359_Name = {
    Text = "Vino de las estrellas de creación"
  },
  State_3359_WeaponDesc = {
    Text = "La tercera carta que juegues tendrá un efecto adicional"
  },
  State_3360_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_4_1"
  },
  State_3360_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_4_1"
  },
  State_3360_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_4_1"
  },
  State_3362_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_4_1"
  },
  State_3362_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_4_1"
  },
  State_3362_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_4_1"
  },
  State_3364_Desc = {
    Text = "Al recoger, se elige una carta y se le otorgan dos efectos de refuerzo de tres opciones (Nota: similar a mil espejismos)"
  },
  State_3365_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_4_1"
  },
  State_3365_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_4_1"
  },
  State_3365_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_4_1"
  },
  State_3366_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_4_1"
  },
  State_3366_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_4_1"
  },
  State_3366_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_4_1"
  },
  State_3368_Desc = {
    Text = "Si el consumo de capacidad antes de la fase de descarte es mayor que 5, se convierte en piedra"
  },
  State_3368_Name = {Text = "Petrificar"},
  State_3368_WeaponDesc = {
    Text = "Antes de la fase de descarte, convierte las cartas en piedras"
  },
  State_3369_Desc = {
    Text = "Todos tus efectos devoradores se han convertido en devoración infinita"
  },
  State_3369_Name = {
    Text = "Devoración Infinita"
  },
  State_3369_WeaponDesc = {
    Text = "Todos tus efectos devoradores se han convertido en devoración infinita"
  },
  State_3370_Desc = {
    Text = "Escudo reducido en [Layer] puntos en esta etapa"
  },
  State_3370_Name = {
    Text = "Reducción Permanente de Alerta"
  },
  State_3370_WeaponDesc = {
    Text = "Escudo reducido en [Layer] puntos en esta etapa"
  },
  State_3372_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_3372_Name = {
    Text = "No Activado"
  },
  State_3373_Desc = {
    Text = "Al causar daño real, baraja [StateArg1] cartas de \"herida\" en la pila de robo"
  },
  State_3373_Name = {Text = "Asfixia"},
  State_3373_WeaponDesc = {
    Text = "Al robar, te debilitas durante 1 turno. Al usar, debilita a todos los enemigos durante 1 turno. No se puede vender"
  },
  State_3374_Desc = {
    Text = "Después de que termine el turno, obtiene capas equivalentes de fuerza"
  },
  State_3374_Name = {Text = "ira"},
  State_3376_Desc = {
    Text = "En esta batalla, el daño causado por la explosión de aliemus aumenta en [Layer] puntos"
  },
  State_3376_Name = {
    Text = "Daño de Furia Explosiva Aumentado"
  },
  State_3378_Desc = {
    Text = "Al liberar la exaltación, la siguiente carta jugada tendrá efecto 2 veces"
  },
  State_3378_Name = {
    Text = "Estado@LlavePlataSueños:Explosión"
  },
  State_3379_Desc = {
    Text = "Cuando la vida está por debajo del 50%, el Rompecadenas entrará en frenesí"
  },
  State_3379_Name = {
    Text = "Momento de la venganza"
  },
  State_3379_WeaponDesc = {
    Text = "Cuando la vida está por debajo del 50%, el Rompecadenas entrará en frenesí"
  },
  State_3380_Desc = {
    Text = "Al comienzo de la batalla, se baraja 1 carta de [desorientación] en el mazo de robo"
  },
  State_3380_Name = {Text = "Encanto"},
  State_3380_WeaponDesc = {
    Text = "Al comienzo de la batalla, se baraja 1 carta de [desorientación] en el mazo de robo"
  },
  State_3381_Name = {
    Text = "Inicialización de profesión transdimensional"
  },
  State_3382_Desc = {
    Text = "Obtener una misión. Al completarla, obtener recompensa. [Evento de misión de marcador]"
  },
  State_3383_Name = {
    Text = "Inicialización de profesión transdimensional"
  },
  State_3385_Desc = {
    Text = "El daño activo y de tentáculo recibido se reduce en un 33%"
  },
  State_3385_Name = {
    Text = "Escudo Espejo"
  },
  State_3385_WeaponDesc = {
    Text = "El daño activo y de tentáculo recibido se reduce en un 33%"
  },
  State_3386_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_3386_Name = {
    Text = "Estado@Prototipo de Espada Larga Crítico"
  },
  State_3387_Name = {
    Text = "Estado@Nivel2_3Batalla3Burbuja1"
  },
  State_3388_Desc = {
    Text = "Obtén [StateArg1] puntos de fuerza al jugarla"
  },
  State_3388_Name = {
    Text = "<Rune_14:Fuerza bruta>"
  },
  State_3389_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_3389_Name = {
    Text = "No Activado"
  },
  State_3390_Desc = {
    Text = "Al comenzar la batalla, debilidad y vulnerabilidad a todos los enemigos durante 1 turno"
  },
  State_3392_Desc = {
    Text = "Al recoger, obtienes [Arg1] puntos de Fuerza. Cada vez que se fusiona un \"Embrion\", obtienes [Arg2] puntos de Fuerza temporal en este turno"
  },
  State_3393_Desc = {
    Text = "Al comienzo del turno, fusión embrionaria +30%. Todos tus efectos de devorar se convierten en devorador ilimitado"
  },
  State_3394_Name = {
    Text = "Coloca 1 <DerivativeCardKeywords_4:\"inspiración\"> en la pila de robo"
  },
  State_3395_Desc = {
    Text = "Equipo único: El daño básico de \"Golpe\" del portador aumenta en 25%, y el escudo básico de \"DEF\" aumenta en 25%. Al jugar \"Golpe\" del portador, obtiene <WeaponEffect_Num:[StateArg1]%> de <PowerIconKeywords:fuerza> temporal igual al ataque del portador; al jugar \"DEF\" del portador, obtiene <WeaponEffect_Num:[StateArg2]%> de <AlertIconKeywords:alerta> temporal igual a la defensa del portador. Si el reino actual es \"Ultra\", al entrar en el turno Ultra, obtiene una vez <PowerIconKeywords:fuerza> y <AlertIconKeywords:alerta> temporales."
  },
  State_3395_WeaponDesc = {
    Text = "El daño básico de \"golpear\" del portador aumenta en un 25%, y el escudo básico de \"defensa\" aumenta en un 25%. Al jugar \"golpear\" del portador, obtiene <WeaponEffect_Num:[Power:DescArg1]> puntos temporales de <PowerIconKeywords:fuerza>, y al jugar \"defensa\" del portador, obtiene <WeaponEffect_Num:[DescArg2]> puntos temporales de <AlertIconKeywords:alerta>. Si el reino actual es \"Ultra\", al entrar en el turno Ultra, obtiene una vez <PowerIconKeywords:fuerza> y <AlertIconKeywords:alerta> temporales."
  },
  State_3397_Desc = {
    Text = "Al jugar la décima carta, aumenta el daño de tentáculo en [Arg1] y hace que todos los tentáculos ataquen una vez"
  },
  State_3400_Desc = {
    Text = "La vida máxima de enemigos élite y jefes se reduce en un 20%"
  },
  State_3401_Desc = {
    Text = "Al jugarlo, se activa adicionalmente [StateArg1] veces, se obtienen [StateArg2] puntos del sigilo negro, agotamiento, inherente"
  },
  State_3401_Name = {
    Text = "<Rune_7:Eco>"
  },
  State_3402_Desc = {
    Text = "\"pico de hierro\" Ruzen aumenta su daño de golpe en [Layer] %"
  },
  State_3402_Name = {
    Text = "Daño de Golpe Pesado Aumentado"
  },
  State_3402_WeaponDesc = {
    Text = "El daño de golpe crítico de pico de hierro aumenta [Layer] %"
  },
  State_3403_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_3403_Name = {
    Text = "No Activado"
  },
  State_3405_Name = {
    Text = "Todos los enemigos disminuyen temporalmente [Power:StateArg1] puntos de <PowerIconKeywords:fuerza>, y los escudos y <PowerIconKeywords:fuerza> obtenidos en 1 turno se reducen en un 50%"
  },
  State_3406_Name = {
    Text = "Obtener [StateArg1] puntos de <PowerIconKeywords:fuerza>"
  },
  State_3407_Name = {
    Text = "Elige 1 carta del mazo de robo para agregar a tu mano y reduce su consumo de aritmética en 1"
  },
  State_3408_Name = {
    Text = "Obtén <Posse:[DescArg1]> puntos de energía llave de plata. En esta batalla, el daño base de \"decapitación\" y \"mil espejismos\" aumenta un 10%"
  },
  State_3409_Name = {
    Text = "Elige un despertado para que obtenga <Energy:[DescArg1]> de locura"
  },
  State_3410_Name = {
    Text = "Esta carta aumenta la tasa crítica y el daño crítico en 50%, causando daño por perforación"
  },
  State_3411_Name = {
    Text = "Inmunidad propia a <FragileIconKeywords:frágil>, <WeaknessIconKeywords:debilidad>, <VulnerabilityIconKeywords:vulnerable> 1 turno. Obtiene <Block:[Block:StateArg1]> puntos de escudo"
  },
  State_3412_Desc = {
    Text = "Inmunidad a estados negativos, se reduce 1 capa al final del turno o al recibir un golpe crítico"
  },
  State_3412_Name = {
    Text = "capa de cera"
  },
  State_3412_WeaponDesc = {
    Text = "Cada capa reduce el daño recibido en un 10%, se reduce en 1 capa al recibir un golpe crítico"
  },
  State_3415_Desc = {
    Text = "Al recoger, elige 1 de 3 sigilos de corrupción para obtener 1. Los sigilos de corrupción son más poderosos que los sigilos normales, pero consumen cartas al jugarse"
  },
  State_3415_Name = {
    Text = "Impresión de jade de creación"
  },
  State_3415_WeaponDesc = {
    Text = "Al recoger, elige 1 de 3 sigilos de corrupción para obtener 1. Los sigilos de corrupción son más poderosos que los sigilos normales, pero consumen cartas al jugarse"
  },
  State_3416_Desc = {
    Text = "Equipo Único: Al comenzar el combate, obtén Contrataque equivalente al <WeaponEffect_Num:[StateArg1]%> de la DEF del Portador. Tras activar <DeathResistanceIconKeywords: Resistencia a la muerte>, obtén hasta un total de 2 capas de \"cuna\": el Blindaje y la recuperación de PV causados por todos los aliados aumenta un <WeaponEffect_Num:[StateArg2]%>; al final del turno se elimina 1 capa. Si el Reino actual es \"Carne y sangre\", tras activar <DeathResistanceIconKeywords: Resistencia a la muerte>, Fusión Embrionaria <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3416_WeaponDesc = {
    Text = "Al comenzar el combate, obtén <WeaponEffect_Num:[Counterattack:DescArg1]> capas de Contrataque. Tras activar <DeathResistanceIconKeywords: Resistencia a la muerte>, obtén hasta un total de 2 capas de \"cuna\": el Blindaje y la recuperación de PV causados por todos los aliados aumenta un <WeaponEffect_Num:[StateArg2]%>; al final del turno se elimina 1 capa. Si el Reino actual es \"Carne y sangre\", tras activar <DeathResistanceIconKeywords: Resistencia a la muerte>, Fusión Embrionaria <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3418_Desc = {
    Text = "Después de que termine el turno, pierde fuerza temporal"
  },
  State_3418_Name = {
    Text = "Agotamiento retardado"
  },
  State_3419_Desc = {
    Text = "Al recoger, se muestran 3 cartas con plegarias avanzadas o maldicencias, se elige una y se le otorga la plegaria correspondiente"
  },
  State_3420_Desc = {
    Text = "Cada vez que actúe, causa sangrado; la curación puede reducir a la mitad las capas de sangrado"
  },
  State_3420_Name = {
    Text = "Salpicadura de sangre"
  },
  State_3420_WeaponDesc = {
    Text = "Cada vez que actúe, causa sangrado; la curación puede reducir a la mitad las capas de sangrado"
  },
  State_3421_Desc = {
    Text = "Al comienzo del turno, añade una \"tridente\" con [Arg1] de poder obtenida en este turno a tu mano. Después de liberar exaltar, aumenta el poder de todas las cartas \"tridente\" en tu mano en [Arg2]"
  },
  State_3422_Name = {
    Text = "Estado@Accesorio Apocalipsis Puro"
  },
  State_3422_WeaponDesc = {
    Text = "Al liberar la llave, recupera [DescArg1] vida. Si el nivel de carga de la llave de plata del portador es superior a 20, recupera [DescArg1] vida adicional. Efectos similares no se acumulan"
  },
  State_3423_Desc = {
    Text = "Dominio de reino 100, haciendo daño y daño temporal de tentáculo"
  },
  State_3423_Name = {
    Text = "Péndulo Temporal \"Pesadilla\""
  },
  State_3424_Desc = {
    Text = "Al inicio del turno, si jugaste más de 3 cartas en el turno anterior, roba 2 cartas"
  },
  State_3425_Desc = {
    Text = "Cuando la vida está por debajo del 50% ([StateArg1]), transformar la intención en \"supervivencia en circunstancias críticas\": eliminar los estados de frágil, debilidad y veneno, infligir 99 capas de debilidad y fragilidad al grupo aliado"
  },
  State_3425_Name = {
    Text = "Momento de la venganza"
  },
  State_3425_WeaponDesc = {
    Text = "Cuando la vida está por debajo del 50% ([StateArg1]), transformar la intención en \"supervivencia en circunstancias críticas\": eliminar los estados de frágil, debilidad y veneno, infligir 99 capas de debilidad y fragilidad al grupo aliado"
  },
  State_3429_Desc = {
    Text = "Cada vez que actúe, añade sangrado; la curación puede eliminar el efecto de sangrado"
  },
  State_3429_Name = {
    Text = "Lesión grave"
  },
  State_3429_WeaponDesc = {
    Text = "Cada vez que actúe, añade sangrado; la curación puede eliminar el efecto de sangrado"
  },
  State_3430_Desc = {
    Text = "Tras liberar la exhalación de aliemus, obtienes [Arg1] puntos de mostrador. Si se activa por sexta vez en este combate, duplica tu mostrador"
  },
  State_3431_Name = {
    Text = "Inmunidad a envenenamiento"
  },
  State_3432_Desc = {
    Text = "Al descartar, consúmela"
  },
  State_3432_Name = {
    Text = "Costo de descarte"
  },
  State_3432_WeaponDesc = {
    Text = "Al robar, te debilitas durante 1 turno. Al usar, debilita a todos los enemigos durante 1 turno. No se puede vender"
  },
  State_3434_Name = {
    Text = "Estado@Corrección de vulnerabilidad general"
  },
  State_3436_Desc = {
    Text = "Hay [Layer] Despertados siendo cazados"
  },
  State_3436_Name = {Text = "Ser cazado"},
  State_3437_Desc = {
    Text = "Estado@monstruo salto de ballena fantasma planeta bestia del caos"
  },
  State_3437_Name = {
    Text = "Estado@monstruo salto de ballena fantasma planeta bestia del caos"
  },
  State_3437_WeaponDesc = {
    Text = "Estado@monstruo salto de ballena fantasma planeta bestia del caos"
  },
  State_3438_Desc = {
    Text = "Obtener [StateArg1] puntos de fuerza temporal"
  },
  State_3438_Name = {
    Text = "<CardKeyWord:Arma Mecánica - Espada>"
  },
  State_3439_Desc = {
    Text = "Al final del turno, Tulu obtiene 5 de locura"
  },
  State_3439_Name = {
    Text = "Las estrellas vuelven a su lugar"
  },
  State_3440_Name = {
    Text = "Guía dorada"
  },
  State_3441_Desc = {
    Text = "En la ronda impar, cuando tu mano es 0, roba 2 cartas; en la ronda par, cuando tu aritmética es 0, obtén 2 aritméticas"
  },
  State_3441_Name = {
    Text = "Rompecabezas Antiguo Mutado"
  },
  State_3441_WeaponDesc = {
    Text = "En la ronda impar, cuando tu mano es 0, roba 2 cartas; en la ronda par, cuando tu aritmética es 0, obtén 2 aritméticas"
  },
  State_3442_Desc = {
    Text = "Al recoger, pierdes permanentemente [Arg1] puntos de Fuerza. Cada vez que causas daño, recuperas [Arg2] puntos de vida, hasta 6 veces por turno"
  },
  State_3442_Name = {
    Text = "Beso de la Lamprea"
  },
  State_3444_Desc = {
    Text = "Al inicio del turno, roba 1 carta"
  },
  State_3445_Desc = {
    Text = "Aumenta la defensa en [Layer]%"
  },
  State_3445_Name = {
    Text = "Aumento Porcentual de DEF General"
  },
  State_3445_WeaponDesc = {
    Text = "Aumenta la defensa en [Layer]%"
  },
  State_3446_Desc = {
    Text = "Posee 5 capas de [Mecha]. Al jugar una carta, reduce una capa. Al llegar a 0, explota causando daño igual a 2.5 veces el ataque"
  },
  State_3446_Name = {
    Text = "Granada explosiva"
  },
  State_3446_WeaponDesc = {
    Text = "Posee 5 capas de [Mecha]. Al jugar una carta, reduce una capa. Al llegar a 0, explota causando daño igual a 2.5 veces el ataque"
  },
  State_3447_Desc = {
    Text = "Posee 5 capas de [Mecha]. Al jugar una carta, reduce una capa. Al llegar a 0, explota causando daño igual a 2.5 veces el ataque"
  },
  State_3447_Name = {
    Text = "Granada explosiva"
  },
  State_3447_WeaponDesc = {
    Text = "Posee 5 capas de [Mecha]. Al jugar una carta, reduce una capa. Al llegar a 0, explota causando daño igual a 2.5 veces el ataque"
  },
  State_3448_Desc = {
    Text = "Después de cada turno, activa todos los tentáculos"
  },
  State_3448_Name = {
    Text = "Activación Automática de Tentáculos"
  },
  State_3448_WeaponDesc = {
    Text = "Después de cada turno, activa todos los tentáculos"
  },
  State_3449_Desc = {
    Text = "Estado@PrólogoLocura0_1_1Activa"
  },
  State_3449_Name = {
    Text = "Estado@PrólogoLocura0_1_1Activa"
  },
  State_3449_WeaponDesc = {
    Text = "Estado@PrólogoLocura0_1_1Activa"
  },
  State_3450_Desc = {
    Text = "Al recibir Daño Activo o de Tentáculos, obtiene Inmunidad al daño y elimina 1 Acumulación."
  },
  State_3450_Name = {
    Text = "<ParcloseIconKeywords:Barrera>"
  },
  State_3450_WeaponDesc = {
    Text = "El daño recibido se reduce un 99%. Tras recibir daño, pierde 1 Acumulación."
  },
  State_3451_Desc = {
    Text = "Al morir, todos los despertados obtienen 10 de locura"
  },
  State_3451_Name = {
    Text = "Escamas de Plata Moribundas"
  },
  State_3451_WeaponDesc = {
    Text = "Al morir, todos los despertados obtienen 10 de locura"
  },
  State_3452_Desc = {
    Text = "Al jugar una carta, recibe [StateArg1] de daño y elimina una capa. Si aún existe al final del turno, eclosiona una \"Criatura del Mar\", aumentando un 10% por cada capa de vida"
  },
  State_3452_Name = {
    Text = "Invasión abisal"
  },
  State_3453_Name = {
    Text = "Estado@VenganzaGranHojaMultiplicadorFuerza"
  },
  State_3455_Desc = {
    Text = "Estado@PrólogoLocuraInicial0_2_3Efecto"
  },
  State_3455_Name = {
    Text = "Estado@PrólogoLocuraInicial0_2_3Efecto"
  },
  State_3455_WeaponDesc = {
    Text = "Estado@PrólogoLocuraInicial0_2_3Efecto"
  },
  State_3456_Desc = {
    Text = "[defensa] obtiene [StateArg1] capas de contraataque"
  },
  State_3456_Name = {
    Text = "Chaleco de ortiga de creación"
  },
  State_3457_Name = {
    Text = "Inmunidad a la vulnerabilidad"
  },
  State_3458_Desc = {
    Text = "Después de jugar [Golpe] y [DEF], el correspondiente despertador obtiene 35 de locura. Sin embargo, su consumo de aritmética aumenta en 1"
  },
  State_3459_Desc = {
    Text = "En esta batalla, el daño causado por la explosión de aliemus aumenta en [Layer] puntos"
  },
  State_3459_Name = {
    Text = "Daño de Furia Explosiva Aumentado"
  },
  State_3461_Desc = {
    Text = "El quinto daño que causes será un golpe crítico"
  },
  State_3462_Name = {
    Text = "Estado@VenganzaGranHojaMultiplicadorFuerza3"
  },
  State_3463_Name = {
    Text = "Estado@VenganzaGranHojaMultiplicadorFuerza2"
  },
  State_3464_Desc = {
    Text = "Límite de tentáculos +1. Si la vida es inferior al 50%, daño de tentáculos +[Arg1]"
  },
  State_3465_Desc = {
    Text = "Esta carta se llevará a la batalla, efectiva en la misión"
  },
  State_3465_Name = {
    Text = "<CardKeyWord:Perpetuo>"
  },
  State_3465_WeaponDesc = {
    Text = "Esta carta se puede llevar a la batalla, efectiva en la misión"
  },
  State_3466_Desc = {
    Text = "Al recoger, se elige un despertador para despertar, y el consumo de aritmética de su carta de despertar se reduce permanentemente en 1"
  },
  State_34671_Desc = {
    Text = "Vuelve a tu mano al jugarla"
  },
  State_34671_Name = {
    Text = "<CardKeyWord:Devolver>"
  },
  State_34685_Name = {
    Text = "Jugador de Bomba 2"
  },
  State_34689_Desc = {
    Text = "Por cada punto de vida perdido, obtén 1 capa de <PainWord:resistir>, con un límite del 100% de la salud máxima. La resistencia se transfiere a la próxima batalla."
  },
  State_34689_Name = {
    Text = "<CardKeyWord:Resistir>"
  },
  State_3468_Desc = {
    Text = "Estado@RencorDefectuoso"
  },
  State_3468_Name = {
    Text = "Estado@RencorDefectuoso"
  },
  State_3468_WeaponDesc = {
    Text = "Estado@RencorDefectuoso"
  },
  State_34691_Desc = {
    Text = "Por cada punto de vida perdido, obtén 1 capa de <PainWord:Paciencia>. Límite de [DescArg1] capas. La Paciencia se hereda a la siguiente batalla."
  },
  State_34691_Name = {
    Text = "<CardKeyWord:Resistir>"
  },
  State_34696_Desc = {
    Text = "Esta carta siempre estará en tu mano y aumenta el límite de cartas en mano +1"
  },
  State_34696_Name = {
    Text = "Conservar permanentemente e ignorar el límite de cartas en mano"
  },
  State_3469_Desc = {
    Text = "Todo el Daño Activo y Daño de tentáculos infligido -[DescArg1]%."
  },
  State_3469_Name = {
    Text = "<WeaknessColour:Debilidad>"
  },
  State_3469_WeaponDesc = {
    Text = "Todo el daño infligido se reduce en [DescArg1] %"
  },
  State_3470_Desc = {
    Text = "Aplica detección de petrificación gradual"
  },
  State_3470_Name = {
    Text = "Aplica detección de petrificación gradual"
  },
  State_3470_WeaponDesc = {
    Text = "Aplica detección de petrificación gradual"
  },
  State_3471_Desc = {
    Text = "La [StateArg1] carta que juegues tendrá un efecto adicional"
  },
  State_3471_Name = {
    Text = "Conteo del vino estelar"
  },
  State_3471_WeaponDesc = {
    Text = "La [StateArg1] carta que juegues tendrá un efecto adicional"
  },
  State_3473_Desc = {
    Text = "Cuando la vida está por debajo del 50%, el \"pastor de lamparitas\" pedirá una \"divina intervención\", volviéndose violento tras absorber a todos los fieles"
  },
  State_3473_Name = {
    Text = "Marca de la mecha"
  },
  State_3473_WeaponDesc = {
    Text = "Cuando la vida está por debajo del 50%, el \"pastor de lamparitas\" pedirá una \"divina intervención\", volviéndose violento tras absorber a todos los fieles"
  },
  State_3475_Desc = {
    Text = "[golpe] y [defensa] consumen +1 en aritmética"
  },
  State_3475_Name = {
    Text = "Piedra Maldita de la Creación"
  },
  State_3475_WeaponDesc = {
    Text = "[golpe] y [defensa] consumen +1 en aritmética"
  },
  State_3476_Desc = {
    Text = "Cada vez que pierdas vida, la fusión embrionaria +10%. Si la vida está por debajo del 50%, el efecto se duplica"
  },
  State_3477_Desc = {
    Text = "Recupera [Layer] PV al recibir un ataque; queda aturdido y se retira este estado si el Daño supera el 15% de los PV Max"
  },
  State_3477_Name = {
    Text = "Fauces de obsidiana"
  },
  State_3478_Name = {
    Text = "Estado@Accesorio Pacto Estándar"
  },
  State_3479_Desc = {
    Text = "Cada vez que se consume 1 sello negro, todos los despertadores obtienen 1 aliemus"
  },
  State_3479_Name = {
    Text = "Flor Inversa de la Creación"
  },
  State_3479_WeaponDesc = {
    Text = "Cada vez que se consume 1 sello negro, todos los despertadores obtienen 1 aliemus"
  },
  State_3480_Desc = {
    Text = "Hasta el final del turno, la vida no bajará a 0"
  },
  State_3480_Name = {
    Text = "El Huevo de Perla no muere"
  },
  State_3480_WeaponDesc = {
    Text = "Hasta el final del turno, la vida no bajará a 0"
  },
  State_3481_Desc = {
    Text = "Al comenzar el nivel, multiplica tu tasa de resistencia a la muerte y tu tasa de grabado de suerte por dos"
  },
  State_3481_Name = {
    Text = "Estado@LlavePlataSueños:DobleSuerte"
  },
  State_3482_Desc = {
    Text = "El efecto de vulnerabilidad causado aumenta en un 25%. Cada 3 turnos añade 1 capa de vulnerabilidad a todos los enemigos"
  },
  State_3483_Desc = {
    Text = "Cada vez que actúe, añade sangrado; la curación puede eliminar el efecto de sangrado"
  },
  State_3483_Name = {
    Text = "Lesión grave"
  },
  State_3483_WeaponDesc = {
    Text = "Cada vez que actúe, añade sangrado; la curación puede eliminar el efecto de sangrado"
  },
  State_3484_Desc = {
    Text = "Al causar daño real, obtén fuerza"
  },
  State_3484_Name = {
    Text = "\"Personalidad caótica\""
  },
  State_3485_Desc = {
    Text = "Estado@RitualLinternaActivo"
  },
  State_3485_Name = {
    Text = "Estado@RitualLinternaActivo"
  },
  State_3485_WeaponDesc = {
    Text = "Estado@RitualLinternaActivo"
  },
  State_3486_Name = {
    Text = "Huelga predeterminada"
  },
  State_3488_Desc = {
    Text = "Al jugar una carta, recibe [StateArg1] puntos de daño y elimina 1 capa. Cuando las capas sean 0, eclosiona una \"Criatura del mar\" más débil. Si al final del turno aún existe el estado de parásito, eclosiona una \"Criatura del mar\" cuya vida aumenta con las capas"
  },
  State_3488_Name = {
    Text = "Parasitado múltiples veces"
  },
  State_3489_Name = {
    Text = "Al final del turno, si está en tu mano o en el <DimensionalSpaceIconKeywords:Espacio Dimensional>, se convierte en \"Llama Verde Corrupta\""
  },
  State_3489_WeaponDesc = {
    Text = "Al final del turno, si está en la mano o en el espacio ultra, obtendrás un fortalecimiento"
  },
  State_3490_Desc = {
    Text = "Al jugar una carta, recibe [StateArg1] puntos de daño y elimina 1 capa. Cuando las capas sean 0, eclosiona una \"Criatura del mar\" más débil. Si al final del turno aún existe el estado de parásito, eclosiona una \"Criatura del mar\" cuya vida aumenta con las capas"
  },
  State_3490_Name = {
    Text = "Ser Parasitado Nuevamente"
  },
  State_3492_Desc = {
    Text = "Cada turno par reduce la fuerza de nuestro equipo en [Layer]"
  },
  State_3492_Name = {
    Text = "Desequilibrio"
  },
  State_3495_Desc = {
    Text = "Cada vez que actúe, añade [Layer] sangrado"
  },
  State_3495_Name = {
    Text = "Lesión grave"
  },
  State_3495_WeaponDesc = {
    Text = "Cada vez que actúe, añade [Layer] sangrado; la curación puede eliminar el efecto de sangrado"
  },
  State_34964_Desc = {
    Text = "Al comienzo del turno, obtén el <PainWord:resistir> equivalente al 10% de la salud máxima."
  },
  State_34964_Name = {
    Text = "Nunca olvidar"
  },
  State_3496_Name = {
    Text = "Al final del turno, si está en tu mano o en el <DimensionalSpaceIconKeywords:Espacio Dimensional>, se convierte en \"Llama Verde de Muerte\""
  },
  State_3496_WeaponDesc = {
    Text = "Al final del turno, si está en la mano o en el espacio ultra, obtendrás un fortalecimiento"
  },
  State_3497_Desc = {
    Text = "Cuando el equipo está compuesto por avatares de diferentes clases, la vida del equipo y el ataque y defensa de todos los avatares aumentan un 200%"
  },
  State_3497_Name = {
    Text = "Bonus mixto"
  },
  State_3497_WeaponDesc = {
    Text = "Cuando el equipo está compuesto por avatares de diferentes clases, la vida del equipo y el ataque y defensa de todos los avatares aumentan un 200%"
  },
  State_3499_Desc = {
    Text = "Equipo único: El aliemus generado por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Después de que el portador libere la exaltación, obtiene <WeaponEffect_Num:[StateArg2]> puntos de energía de llave de plata."
  },
  State_3499_WeaponDesc = {
    Text = "El aliemus generado por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Después de que el portador libere la exaltación, obtiene <WeaponEffect_Num:[StateArg2]> puntos de energía de llave de plata."
  },
  State_3502_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_3502_Name = {
    Text = "Estado@Prototipo de Cuchillo Locura"
  },
  State_3504_Desc = {
    Text = "Al inicio de cada turno, roba [StateArg1] cartas"
  },
  State_3504_Name = {
    Text = "Brújula direccional de creación"
  },
  State_3504_WeaponDesc = {
    Text = "Al inicio de cada turno, roba [StateArg1] cartas"
  },
  State_3507_Name = {
    Text = "Forma orgánica de accesorios"
  },
  State_3507_WeaponDesc = {
    Text = "Después de que el portador use exaltar, sus escudos y curas en este turno se duplican"
  },
  State_3508_Name = {
    Text = "Capullo de la doncella de accesorios"
  },
  State_3508_WeaponDesc = {
    Text = "Después de que comience la batalla, si el portador es de profesión caos, su ataque aumenta un 25%"
  },
  State_3510_Desc = {
    Text = "El escudo del Despertar aumenta en [Layer] puntos"
  },
  State_3510_Name = {
    Text = "<AlertColour:Alerta>"
  },
  State_3511_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_3511_Name = {
    Text = "Estado@Prototipo de Espada Larga Suerte"
  },
  State_35120_Desc = {
    Text = "Por cada instancia de Daño Activo recibido, aplica [StateArg1] <plural value=\"[Poison:StateArg1]\" singular=\"acumulación\" plural=\"acumulaciones\"> de Veneno al atacante, durante [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_35120_Name = {
    Text = "Flor inmortal sobre limo"
  },
  State_3512_Name = {
    Text = "Fragilidad de Inmunidad Temporal"
  },
  State_3514_Desc = {
    Text = "Al final del turno, recibe <FixedDamage:DMG Puro> igual al número de Acumulaciones y elimina este estado."
  },
  State_3514_Name = {
    Text = "<BleedingIconKeywords: sangrando>"
  },
  State_3514_WeaponDesc = {
    Text = "Al inicio del turno, recibe daño"
  },
  State_35158_Name = {
    Text = "Péndulo temporal \"Trance\""
  },
  State_3515_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_3515_Name = {
    Text = "No Activado"
  },
  State_35161_Name = {
    Text = "Péndulo temporal \"Reserva\""
  },
  State_3516_Name = {
    Text = "Estado@Maldición Desánimo"
  },
  State_3518_Desc = {
    Text = "El Ilusionista gana [StateArg2] de fuerza temporal cada vez que juega una carta"
  },
  State_3518_Name = {
    Text = "Acto de apertura"
  },
  State_3519_Desc = {
    Text = "Incluso fuera del turno extradimensional, puedes activar el efecto de salto una vez por turno"
  },
  State_3519_Name = {
    Text = "Doblador de espacio"
  },
  State_3519_WeaponDesc = {
    Text = "Incluso fuera del turno extradimensional, puedes activar el efecto de salto una vez por turno"
  },
  State_3520_Desc = {
    Text = "Al comenzar la batalla, elige un despertador y otórgale 50 aliemus"
  },
  State_35228_Name = {
    Text = "Péndulo temporal \"Reserva\""
  },
  State_3522_Name = {
    Text = "Contador de tridente de creación"
  },
  State_35238_Desc = {
    Text = "Equipo único: el escudo y el veneno causados por el portador aumentan en <WeaponEffect_Num:[StateArg1]%>. Cada vez que se activa la resistencia a la muerte, todos los despertados reciben <WeaponEffect_Num:[StateArg2]%> de tasa crítica y daño crítico temporal."
  },
  State_35238_WeaponDesc = {
    Text = "El escudo y el veneno causados por el equipador aumentan <WeaponEffect_Num:[StateArg1]%>. Cada vez que se activa la resistencia a la muerte, todos los despertadores reciben <WeaponEffect_Num:[StateArg2]%> de tasa crítica y daño crítico temporal"
  },
  State_3523_Desc = {
    Text = "Después de jugar, debilita a todos los enemigos por [StateArg1] turnos"
  },
  State_3523_Name = {
    Text = "<Rune_2_High:Debilidad Avanzada>"
  },
  State_3524_Desc = {
    Text = "Aumenta el daño recibido en [Layer] puntos"
  },
  State_3524_Name = {
    Text = "Boca de fusión"
  },
  State_3524_WeaponDesc = {
    Text = "Aumenta el daño recibido en [Layer] puntos"
  },
  State_3525_Desc = {
    Text = "Nuestro equipo aplica 2 capas de [Restricción] por cada carta jugada"
  },
  State_3525_Name = {
    Text = "\"Especial de la Zona Este\""
  },
  State_3525_WeaponDesc = {
    Text = "Nuestro equipo aplica 2 capas de [Restricción] por cada carta jugada"
  },
  State_35264_Desc = {
    Text = "En esta ronda, después de cada carta jugada, el \"mago\" obtiene 1 capa de fantasma"
  },
  State_35264_Name = {
    Text = "Registro de Desplazamiento de Sombra"
  },
  State_35277_Name = {
    Text = "La defensa mágica de Casiah"
  },
  State_3527_Desc = {
    Text = "Al final del turno, el Despertado correspondiente a la primera carta de comando jugada obtiene 15 Locura. Si también tienes \"Espíritu de Devoción\", los otros Despertados obtienen 5 Locura"
  },
  State_3528_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_3528_Name = {
    Text = "Estado@Prototipo de Cañón Láser Dominio"
  },
  State_3529_Desc = {
    Text = "Inmunidad a todo daño, se elimina al inicio del turno"
  },
  State_3529_Name = {
    Text = "Inmunidad al daño"
  },
  State_3530_Desc = {
    Text = "Estado@detective afortunado todo incluido identificación 8"
  },
  State_3530_Name = {
    Text = "Estado@detective afortunado todo incluido identificación 8"
  },
  State_3530_WeaponDesc = {
    Text = "Estado@detective afortunado todo incluido identificación 8"
  },
  State_3531_Desc = {
    Text = "Equipo Único: Al comenzar la batalla, el portador obtiene <WeaponEffect_Num:[StateArg1]> de alienación. Cada vez que otros Despertados liberan una explosión de locura, el portador obtiene <WeaponEffect_Num:[StateArg2]> de alienación. Si el reino actual es \"Aequor\", después de que el portador libera una explosión de locura, recibe un daño de tentáculo equivalente al <WeaponEffect_Num:[StateArg3]%> de su ATQ."
  },
  State_3531_WeaponDesc = {
    Text = "Al comenzar la batalla, el portador obtiene <WeaponEffect_Num:[StateArg1]> de alienación. Cada vez que otros despertadores liberan una explosión de locura, el portador obtiene <WeaponEffect_Num:[StateArg2]> de alienación. Si el reino actual es \"Aequor\", después de que el portador libera una explosión de locura, el daño de tentáculos es <WeaponEffect_Num:+[DescArg1]>."
  },
  State_3532_Desc = {
    Text = "Al comienzo del turno, obtén [StateArg1] de aritmética"
  },
  State_3532_Name = {
    Text = "Vela Negra de la Creación 1"
  },
  State_3533_Desc = {
    Text = "Aparece en la mano inicial"
  },
  State_3533_Name = {
    Text = "<GuyouKeywords:Inherente>"
  },
  State_3533_WeaponDesc = {
    Text = "Después de que comience la batalla, esta carta quedará fijada en la mano"
  },
  State_3535_Desc = {
    Text = "El consumo de aritmética de la carta aumenta en [Layer] puntos. Este efecto negativo se eliminará al finalizar el turno o después de jugar la carta."
  },
  State_3535_Name = {
    Text = "<SlowColour:Lento Temporal [Layer]>"
  },
  State_3535_WeaponDesc = {
    Text = "El consumo de aritmética de la carta aumenta en [Layer] puntos"
  },
  State_3536_Name = {
    Text = "En combate contra el jefe, se puede usar 3 veces"
  },
  State_3537_Desc = {
    Text = "Puedes realizar una plegaria al obtener \"el regalo ingenuo\""
  },
  State_3537_Name = {
    Text = "Estado@Capítulo Uno_Resonancia 4"
  },
  State_3537_WeaponDesc = {
    Text = "Puedes realizar una plegaria al obtener \"el regalo ingenuo\""
  },
  State_3538_Desc = {
    Text = "Usar \"Regalo inocente\" aumenta la recuperación de locura"
  },
  State_3538_Name = {
    Text = "Estado@Capítulo Uno_Resonancia 1"
  },
  State_3538_WeaponDesc = {
    Text = "Usar \"Regalo inocente\" aumenta la recuperación de locura"
  },
  State_3539_Desc = {
    Text = "“el ingenuo regalo de vuelta” reduce el consumo de habilidad en 1"
  },
  State_3539_Name = {
    Text = "Estado@Capítulo Uno_Resonancia 3"
  },
  State_3539_WeaponDesc = {
    Text = "“el ingenuo regalo de vuelta” reduce el consumo de habilidad en 1"
  },
  State_3540_Desc = {
    Text = "“Regalo inocente” puede seleccionar objetivo"
  },
  State_3540_Name = {
    Text = "Estado@Capítulo Uno_Resonancia 2"
  },
  State_3540_WeaponDesc = {
    Text = "“Regalo inocente” puede seleccionar objetivo"
  },
  State_3541_Desc = {
    Text = "Kum cayó en la trampa que habían preparado"
  },
  State_3541_Name = {
    Text = "Caer en la trampa"
  },
  State_3542_Desc = {
    Text = "Al comienzo de la batalla, por cada inscripción en el mazo se obtienen [Arg1] puntos de fuerza y por cada reliquia, se recuperan [Arg2] puntos de PV."
  },
  State_3542_Name = {
    Text = "☆Medalla de la guilda☆"
  },
  State_3545_Name = {
    Text = "Resistencia del Esplendor Estelar Sin Límites"
  },
  State_3545_WeaponDesc = {
    Text = "Cada vez que juegas una carta, obtén [StateArg1]% de resistencia a la muerte. Al obtener resistencia a la muerte, recupera [StateArg2] de vida"
  },
  State_3546_Desc = {
    Text = "Nuestro equipo aplica [Layer] capas de [Restricción] por cada carta jugada"
  },
  State_3546_Name = {
    Text = "\"Especial de la Zona Este\""
  },
  State_3546_WeaponDesc = {
    Text = "Nuestro equipo aplica [Layer] capas de [Restricción] por cada carta jugada"
  },
  State_3547_Desc = {
    Text = "Nuestro equipo aplica [Layer] capas de [Restricción] por cada carta jugada"
  },
  State_3547_Name = {
    Text = "\"Especial de la Zona Este\""
  },
  State_3547_WeaponDesc = {
    Text = "Nuestro equipo aplica [Layer] capas de [Restricción] por cada carta jugada"
  },
  State_3548_Desc = {
    Text = "Al robar, te debilitas durante 1 turno. Al usar, debilita a todos los enemigos durante 1 turno. No se puede vender"
  },
  State_3548_Name = {
    Text = "Estado Maldición Debilidad"
  },
  State_3548_WeaponDesc = {
    Text = "Al robar, te debilitas durante 1 turno. Al usar, debilita a todos los enemigos durante 1 turno. No se puede vender"
  },
  State_3549_Name = {
    Text = "Accesorio de estado: steppenwolf"
  },
  State_3549_WeaponDesc = {
    Text = "El daño básico causado por el portador aumenta en un 10%. Si la amplificación de daño del portador es mayor del 20%, el daño básico aumenta un 10% adicional."
  },
  State_35503_Name = {
    Text = "Péndulo temporal \"Propagación\""
  },
  State_3551_Desc = {
    Text = "Al comienzo del turno, si el número de cartas en mano del turno anterior es mayor a [StateArg1], obtén [StateArg2] de aritmética"
  },
  State_3551_Name = {
    Text = "Máquina Diferencial Plateada de la Creación"
  },
  State_3551_WeaponDesc = {
    Text = "Al comienzo del turno, si el número de cartas en mano del turno anterior es mayor a [StateArg1], obtén [StateArg2] de aritmética"
  },
  State_35539_Desc = {
    Text = "El daño recibido se duplica, dura [Layer] turnos"
  },
  State_35539_Name = {
    Text = "Restos del caminante del camino"
  },
  State_3553_Desc = {
    Text = "La tasa crítica aumenta un 25%. Después de un retorno de vida, existe la posibilidad de causar 1 retorno de vida adicional, con probabilidad igual a la tasa crítica del que causa la recuperación"
  },
  State_3553_Name = {
    Text = "Estado@LlavePlataSueños:CurarCrítico"
  },
  State_3554_Desc = {
    Text = "El efecto del escudo y curar aumenta un [Layer] %"
  },
  State_3554_Name = {
    Text = "Escudo y Curar Fuerte"
  },
  State_3554_WeaponDesc = {
    Text = "El efecto del escudo y curar aumenta un [Layer] %"
  },
  State_3555_Desc = {
    Text = "Al recoger, obtienes un 100% de Resistencia a la Muerte. Después de activar la Resistencia a la Muerte, al inicio de cada turno en esta batalla, recuperas [Arg1] puntos de vida"
  },
  State_3555_Name = {
    Text = "Respirador vital"
  },
  State_3556_Desc = {
    Text = "Al recoger esta creación, elige una carta y añade una copia de ella a tu mazo"
  },
  State_3558_Desc = {
    Text = "Al comienzo del turno, si el sigilo negro es mayor a 10, consume 10 sigilo negro, el daño causado en ese turno se duplica"
  },
  State_3559_Desc = {
    Text = "Al causar daño no bloqueado, aplica 1 capa de debilidad"
  },
  State_3559_Name = {Text = "Garras"},
  State_3559_WeaponDesc = {
    Text = "Al causar daño real, baraja [StateArg1] cartas de \"herida\" en la pila de robo"
  },
  State_3561_Name = {
    Text = "Estado@LlavePlataSueños:ContarDesgarrar"
  },
  State_3562_Desc = {
    Text = "Al morir, aumenta la fuerza de otros aliados en [Layer]"
  },
  State_3562_Name = {
    Text = "lengua muerta"
  },
  State_35635_Name = {
    Text = "Estado@despertador casiah telequinesis permite activar"
  },
  State_35636_Name = {
    Text = "Estado@despertador casiah añade telequinesis"
  },
  State_3563_Desc = {
    Text = "Al causar daño no bloqueado, baraja [StateArg1] cartas de \"herida\" en la pila de robo"
  },
  State_3563_Name = {Text = "Cuchilla"},
  State_3563_WeaponDesc = {
    Text = "Al causar daño real, baraja [StateArg1] cartas de \"herida\" en la pila de robo"
  },
  State_35645_Desc = {
    Text = "Este turno, el número de cartas robadas se reduce [Layer]"
  },
  State_35645_Name = {
    Text = "Tiraje reducido"
  },
  State_35646_Desc = {
    Text = "Este turno, el número de cartas robadas se reduce [Layer]"
  },
  State_35646_Name = {
    Text = "Tiraje reducido"
  },
  State_3564_Desc = {
    Text = "Después de jugar, obtén [StateArg1] puntos temporales de poder, y la carta plegaria también podrá disfrutar de este aumento de poder"
  },
  State_3564_Name = {
    Text = "<Rune_15_High:Explosión avanzada>"
  },
  State_3565_Desc = {
    Text = "Cuando el escultor aplica un escudo, incrementa el daño de tentáculo de [StateArg1]"
  },
  State_3565_Name = {
    Text = "Reino del Olvido"
  },
  State_3565_WeaponDesc = {
    Text = "Cuando el escultor aplica un escudo, incrementa el daño de tentáculo de [StateArg1]"
  },
  State_3566_Desc = {
    Text = "Al comienzo del turno, obtén 3 puntos de poder temporal, [exaltar] duplicará este poder temporal, apilándose como máximo 2 veces"
  },
  State_3566_Name = {
    Text = "Piel de serpiente extraña de creación"
  },
  State_3567_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_3567_Name = {
    Text = "Estado@Prototipo de Cañón Láser Crítico"
  },
  State_35684_Desc = {
    Text = "Después de que nuestro equipo libera el arrebato de locura, pierde poder en ese turno. Una vez por turno"
  },
  State_35684_Name = {
    Text = "Temor a la locura"
  },
  State_35685_Desc = {
    Text = "Al liberar la llegada del génesis, reduce temporalmente el poder del enemigo"
  },
  State_35685_Name = {
    Text = "Temor a la locura"
  },
  State_3568_Desc = {
    Text = "Cuando Ramona causa daño, obtiene [StateArg1] puntos de aritmética"
  },
  State_3568_Name = {
    Text = "Primera Doctrina"
  },
  State_3568_WeaponDesc = {
    Text = "Cuando Ramona causa daño, obtiene [StateArg1] puntos de aritmética"
  },
  State_3570_Name = {
    Text = "Al inicio del próximo turno, roba 2 cartas más"
  },
  State_3571_Name = {
    Text = "Inmunidad temporal a la debilidad"
  },
  State_3572_Desc = {
    Text = "El daño de sus monstruos invocados se duplica"
  },
  State_3572_Name = {Text = "Comandante"},
  State_3572_WeaponDesc = {
    Text = "El daño de sus monstruos invocados se duplica"
  },
  State_3573_Desc = {
    Text = "El primer daño recibido cada turno se multiplica por 5"
  },
  State_3573_Name = {Text = "Orgullo"},
  State_3573_WeaponDesc = {
    Text = "El primer daño recibido cada turno se duplica"
  },
  State_3574_Desc = {
    Text = "Cada vez que juegues consecutivamente cartas del mismo Despertado, ese Despertado obtiene 10 puntos de locura"
  },
  State_35768_Name = {
    Text = "Obtén 300 puntos de energía-s de llave de plata"
  },
  State_35769_Name = {
    Text = "Obtén 1 punto de aritmética"
  },
  State_35770_Name = {
    Text = "Disipa <IntoxicationIconKeywords:veneno>, sello y <SlowIconKeywords:lentitud>"
  },
  State_35771_Name = {
    Text = "Obtén un escudo de [DescArg1]%(<Block:[DescArg2]>) de salud máxima"
  },
  State_35772_Name = {
    Text = "En combate contra el jefe, se puede usar [StateArg1] veces más"
  },
  State_35774_Desc = {
    Text = "Antes de morir, llama una vez la ayuda de Celeste, restaurando toda la vida, locura y energía-llave"
  },
  State_35774_Name = {
    Text = "Velo utópico"
  },
  State_3577_Name = {
    Text = "Aumento de la recuperación automática de alienación"
  },
  State_35809_Desc = {
    Text = "El daño causado se reduce en [StateArg1]%, dura [Layer] turnos."
  },
  State_35809_Name = {
    Text = "El heredero del delirio"
  },
  State_35809_WeaponDesc = {
    Text = "Estado@Dama del Mar Profundo Té y Pastel"
  },
  State_3580_Desc = {
    Text = "[Layer] El daño de los tentáculos durante el turno es daño por punción"
  },
  State_3580_Name = {
    Text = "Tentáculo perforante"
  },
  State_35811_Desc = {
    Text = "Al recibir Daño Activo o de tentáculos, gana la mitad del daño como <SacrificeKeyWord:Sacrificio> durante [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_35811_Name = {
    Text = "El heredero del delirio"
  },
  State_35819_Desc = {
    Text = "Al final del turno, Murphy obtiene 5 de aliemus. Después de liberar pandilla, se elimina un 2% de la salud máxima como <SacrificeKeyWord:sacrificio>"
  },
  State_35819_Name = {
    Text = "Té rojo y pastel"
  },
  State_3581_Desc = {
    Text = "Estado@Dama Roja Contador de Danza de Poder"
  },
  State_3581_Name = {
    Text = "Estado@Dama Roja Contador de Danza de Poder"
  },
  State_3582_Desc = {
    Text = "Incluso fuera del turno extradimensional, puedes activar el efecto de salto una vez por turno. Al activarlo, roba una carta correspondiente al despertado"
  },
  State_3582_Name = {
    Text = "Desviador espacial mutado"
  },
  State_3582_WeaponDesc = {
    Text = "Incluso fuera del turno extradimensional, puedes activar el efecto de salto una vez por turno. Al activarlo, roba una carta correspondiente al despertado"
  },
  State_3584_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_3584_Name = {
    Text = "Estado@Prototipo de Cuchillo Dominio"
  },
  State_35858_Desc = {
    Text = "Al final del turno, Murphy obtiene 5 de locura. Tras liberar una orden de llave, obtiene daño de tentáculo equivalente al 3% del ataque de Murphy"
  },
  State_35858_Name = {
    Text = "Té rojo y pastel"
  },
  State_3585_Desc = {
    Text = "Cuando la vida está por debajo del 50% ([StateArg1]), el \"pastor de lamparitas\" pedirá una \"divina intervención\", volviéndose violento tras absorber a todos los fieles"
  },
  State_3585_Name = {
    Text = "Marca de la mecha"
  },
  State_3585_WeaponDesc = {
    Text = "Cuando la vida está por debajo del 50% ([StateArg1]), el \"pastor de lamparitas\" pedirá una \"divina intervención\", volviéndose violento tras absorber a todos los fieles"
  },
  State_3588_Name = {
    Text = "Aritmética de relicario de arkanas"
  },
  State_3589_Desc = {
    Text = "Al recibir Daño Activo o de Tentáculos, obtiene Inmunidad al daño y pierde 1 Acumulación."
  },
  State_3589_Name = {
    Text = "<ParcloseColour:Barrera>"
  },
  State_3591_Desc = {
    Text = "Equipo Único: El <RetaliateIconKeywords:Contador> del Portador +<WeaponEffect_Num:[StateArg1]%>. \"Defensa\" otorga un Contador Temporal igual a la DEF del Portador ×<WeaponEffect_Num:[StateArg2]%>. En Líder Batalla, esto se convierte en 3 veces el Contador Temporal. Después de que se active la Resistencia a la muerte, activa [StateArg3]% de <RetaliateIconKeywords:Contador> contra todos los enemigos."
  },
  State_3591_Name = {
    Text = "Agazapado en la noche"
  },
  State_3591_WeaponDesc = {
    Text = "El <RetaliateIconKeywords:Contador> del Portador +<WeaponEffect_Num:[StateArg1]%>. Después de jugar la \"Defensa\" del Portador, gana <WeaponEffect_Num:[Counterattack:DescArg1]> acumulaciones de Contador Temporal. En Líder Batalla, esto se convierte en 3 veces el Contador Temporal. Después de que se active la Resistencia a la muerte, activa [StateArg3]% de <RetaliateIconKeywords:Contador> contra todos los enemigos."
  },
  State_3592_Desc = {
    Text = "Aumenta el daño de los tentáculos"
  },
  State_3592_Name = {
    Text = "<TentacleInjurieIconKeywords:Daño de Tentáculo>"
  },
  State_3592_WeaponDesc = {
    Text = "Aumenta el daño causado por los tentáculos"
  },
  State_3593_Desc = {
    Text = "Equipo único: El daño causado por <IntoxicationIconKeywords:veneno> aumenta en <WeaponEffect_Num:[StateArg1]%. \"Golpe\" causa un veneno igual al poder de ataque del portador en <WeaponEffect_Num:[StateArg2]%> al enemigo objetivo. Este efecto se puede aplicar un máximo de 3 veces por turno"
  },
  State_3593_WeaponDesc = {
    Text = "El <IntoxicationIconKeywords:veneno> causado por el portador aumenta un <WeaponEffect_Num:[StateArg1]%>. El \"golpe\" causa <WeaponEffect_Num:[Poison:DescArg1]> capas de <IntoxicationIconKeywords:veneno> al enemigo objetivo. Este efecto puede activarse hasta 3 veces por turno"
  },
  State_3596_Name = {
    Text = "Núcleo de Plata Residual"
  },
  State_35970_Desc = {
    Text = "Después de la muerte, asigna a los jugadores 1 turno de <VulnerabilityIconKeywords: vulnerable>"
  },
  State_35970_Name = {
    Text = "Muerte prematura"
  },
  State_35971_Desc = {
    Text = "Al aparecer, recibe un escudo equivalente al 50% de su salud máxima"
  },
  State_35971_Name = {
    Text = "cáscara de huevo"
  },
  State_3597_Name = {
    Text = "Núcleo de Plata Residual"
  },
  State_3598_Name = {
    Text = "Núcleo de Plata Residual"
  },
  State_3599_Desc = {
    Text = "Al jugar una carta con un consumo de aritmética de 4 o más, el consumo de aritmética de otras cartas en mano disminuye en 1"
  },
  State_36006_Desc = {
    Text = "Después de morir, genera un \"Hijo del Sueño\" en el lugar"
  },
  State_36006_Name = {
    Text = "Recibir daño"
  },
  State_3600_Name = {
    Text = "Núcleo de Plata Residual"
  },
  State_36013_Desc = {
    Text = "Este estado también se considera <SacrificeKeyWord:sacrificio>, al inicio del próximo turno obtén [Layer] capas de <SacrificeKeyWord:sacrificio>"
  },
  State_36013_Name = {
    Text = "<BlueKeyWord:Sacrificio diferido>"
  },
  State_36014_Desc = {
    Text = "Al final del turno, recibe [Layer] de daño y reduce 50% de capas de <SacrificeKeyWord:Sacrificio>"
  },
  State_36014_Name = {
    Text = "<BlueKeyWord:Sacrificio>"
  },
  State_3601_Name = {
    Text = "Estado@LlavePlataSueños:ContarDanza"
  },
  State_36022_Desc = {
    Text = "Al recibir daño que no sea de <SacrificeKeyWord:Sacrificio>, obtiene el 50% del daño como <SacrificeKeyWord:Sacrificio>"
  },
  State_36022_Name = {Text = "Visitar"},
  State_36023_Desc = {
    Text = "Después de morir, si hay otros aliados, genera un \"Hijo del Agua\""
  },
  State_36023_Name = {
    Text = "Recibir daño"
  },
  State_36024_Desc = {
    Text = "Después de morir, si hay otros aliados, genera un \"Hijo del Sueño\""
  },
  State_36024_Name = {
    Text = "Recibir daño"
  },
  State_3603_Name = {
    Text = "En combate contra el jefe, se puede usar 2 veces y la primera vez vuelve a la mano"
  },
  State_3604_Desc = {
    Text = "Cuando el equipo está compuesto por avatares de diferentes clases, la vida del equipo y el ataque y defensa de todos los avatares aumentan un 200%"
  },
  State_3604_Name = {
    Text = "Estado@Mezcla de Bonificación"
  },
  State_3604_WeaponDesc = {
    Text = "Cuando el equipo está compuesto por avatares de diferentes clases, la vida del equipo y el ataque y defensa de todos los avatares aumentan un 200%"
  },
  State_3607_Desc = {
    Text = "Después de jugar, el despertador obtendrá un aumento especial en sus habilidades durante esta batalla. Repetir el despertar de la gnosis no se acumula"
  },
  State_3607_Name = {
    Text = "<ExaltIconKeywords:Despertar espiritual>"
  },
  State_3607_WeaponDesc = {
    Text = "Después de jugar el despertar de la gnosis, permite que el despertador obtenga un aumento especial de capacidad en esta batalla. Sin embargo, los despertares de gnosis repetidos no se acumulen"
  },
  State_3608_Name = {
    Text = "Todos los aliados obtienen [StateArg1] puntos de locura"
  },
  State_36092_Desc = {
    Text = "Después de morir, si hay otros aliados, genera un \"Hijo del Agua\" en el lugar"
  },
  State_36092_Name = {
    Text = "Recibir daño"
  },
  State_36093_Desc = {
    Text = "Por cada punto de vida perdido, reduce 1 capa. Al llegar a 0 capas, al final del turno del monstruo, invoca un \"Hijo del Agua\" y recupera [DescArg1] capas de \"Anfitrión del Agua\", hasta 4 \"Hijos del Agua\""
  },
  State_36093_Name = {
    Text = "Huésped del agua"
  },
  State_36094_Desc = {
    Text = "Por cada punto de vida perdido, reduce 1 capa. Al llegar a 0 capas, invoca un \"Hijo de la Percepción\" y recupera [DescArg1] capas de \"Anfitrión de Coral\", hasta 4 \"Hijos de la Percepción\""
  },
  State_36094_Name = {
    Text = "Huésped de la Conciencia Espiritual"
  },
  State_3609_Name = {
    Text = "En la batalla contra el jefe, se puede usar 2 veces y tras el primer uso, regresa a la mano, la carta robada en este turno reducirá el costo de aritmética en 1"
  },
  State_36111_Desc = {
    Text = "Al morir, añade 1 carta de \"Coral Parásito\" a la mano del jugador"
  },
  State_36111_Name = {
    Text = "Hiperplasia de coral"
  },
  State_3611_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo12"
  },
  State_3611_Name = {
    Text = "Estado@PrólogoMonstruoPasivo12"
  },
  State_3611_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo12"
  },
  State_36124_Desc = {
    Text = "Después de que termine el turno, recibe [Layer] de daño y reduce 50% de capas de \"Sacrificio\""
  },
  State_36124_Name = {
    Text = "<BlueKeyWord:Sacrificio>"
  },
  State_3612_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo13"
  },
  State_3612_Name = {
    Text = "Estado@PrólogoMonstruoPasivo13"
  },
  State_3612_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo13"
  },
  State_36136_Name = {
    Text = "Mientras esté en mano, recibe [StateArg1] <FixedDamage:DMG Puro> por cada otra carta jugada."
  },
  State_3613_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo10"
  },
  State_3613_Name = {
    Text = "Estado@PrólogoMonstruoPasivo10"
  },
  State_3613_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo10"
  },
  State_3614_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo11"
  },
  State_3614_Name = {
    Text = "Estado@PrólogoMonstruoPasivo11"
  },
  State_3614_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo11"
  },
  State_36152_Desc = {
    Text = "Al final del turno, recibe daño equivalente a las capas y luego se elimina 50% de las capas de <SacrificeKeyWord:Sacrificio>. El sacrificio se transfiere a la próxima batalla."
  },
  State_36152_Name = {
    Text = "<SacrificeKeyWord:Sacrificio>"
  },
  State_3615_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo16"
  },
  State_3615_Name = {
    Text = "Estado@PrólogoMonstruoPasivo16"
  },
  State_3615_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo16"
  },
  State_3616_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo14"
  },
  State_3616_Name = {
    Text = "Estado@PrólogoMonstruoPasivo14"
  },
  State_3616_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo14"
  },
  State_36173_Name = {
    Text = "En combate contra el jefe, se puede usar [DescArg1] veces"
  },
  State_36174_Name = {
    Text = "（Quedan [Layer] veces）"
  },
  State_3617_Desc = {
    Text = "Estado@PrólogoMonstruoPasivo15"
  },
  State_3617_Name = {
    Text = "Estado@PrólogoMonstruoPasivo15"
  },
  State_3617_WeaponDesc = {
    Text = "Estado@PrólogoMonstruoPasivo15"
  },
  State_36182_Name = {
    Text = "Obtén un escudo de [DescArg1]%(<Block:[DescArg2]>) de salud máxima y restaura la misma cantidad de vida, el escudo aumenta con la vida dañada"
  },
  State_3618_Desc = {
    Text = "Al recibir daño real, obtiene escudo"
  },
  State_3618_Name = {Text = "buffer"},
  State_3618_WeaponDesc = {
    Text = "Al recibir daño real, obtiene escudo"
  },
  State_36196_Desc = {
    Text = "El daño de \"golpe\" de Lotan aumenta un 30%"
  },
  State_36196_Name = {
    Text = "Viento de espada indomable"
  },
  State_3619_Desc = {
    Text = "Estado@Golpe en defensa del bailarín de llama azul"
  },
  State_3619_Name = {
    Text = "Estado@Golpe en defensa del bailarín de llama azul"
  },
  State_3619_WeaponDesc = {
    Text = "Estado@Golpe en defensa del bailarín de llama azul"
  },
  State_3620_Desc = {
    Text = "Cada vez que obtenga una carta de síntoma, aumentará su salud máxima en [Arg1] puntos"
  },
  State_3621_Desc = {
    Text = "Cada vez que un devoto primigenio juega una carta, roba [StateArg1] cartas y provoca un 5% de veneno en todos los enemigos"
  },
  State_3621_Name = {
    Text = "Obsesión abisal"
  },
  State_3621_WeaponDesc = {
    Text = "Cada vez que el Devoto Primordial juega una carta, roba [StateArg1] cartas"
  },
  State_3622_Desc = {
    Text = "Fortalecer el efecto de habilidad de \"máscara salvaje\" y \"muerto\", obteniendo [StateArg1] puntos de poder temporal al comienzo de cada turno. Cada capa de \"marca de caza\" aumenta en [StateArg1] puntos más"
  },
  State_3622_Name = {
    Text = "Marca de caza"
  },
  State_36242_Desc = {
    Text = "Después de que comience la batalla, se obtendrán [StateArg1] puntos de escudo. Al perder vida, el \"Santo Infante\" despertará de su letargo y comenzará a llorar"
  },
  State_36242_Name = {
    Text = "Sueño Profundo"
  },
  State_3624_Desc = {
    Text = "Estado@sabio análisis ofensivo reducción de poder"
  },
  State_3624_Name = {
    Text = "Estado@sabio análisis ofensivo reducción de poder"
  },
  State_3625_Desc = {
    Text = "Cuando tienes escudo, el daño infligido aumenta en [Arg1]. Si tu escudo es mayor que tu vida actual, el daño infligido aumenta en [Arg2] adicionalmente"
  },
  State_36263_Desc = {
    Text = "Sin más daño, preparando la liberación de la \"Semilla del Nacimiento\""
  },
  State_36263_Name = {Text = "Inmunidad"},
  State_3628_Name = {
    Text = "Estado@JugarRomperDEF"
  },
  State_3629_Name = {
    Text = "Roba 2 cartas"
  },
  State_3630_Name = {
    Text = "Aplica 2 capas <VulnerabilityIconKeywords:vulnerable> a todos los enemigos"
  },
  State_36315_Desc = {
    Text = "Al final del turno, obtén [Layer] puntos de Fuerza"
  },
  State_36315_Name = {Text = "Mont"},
  State_3631_Name = {
    Text = "Obtén 2 puntos de aritmética"
  },
  State_3632_Name = {
    Text = "Obtén <Energy:[DescArg1]> puntos de locura"
  },
  State_36332_Desc = {
    Text = "Al inicio de cada turno, elige obtener 1 capa de Poder de la Madre o consume Poder de la Madre para recibir una ayuda de Murphy"
  },
  State_36332_Name = {
    Text = "Poder de la Madre Divina"
  },
  State_36334_Desc = {
    Text = "Al final de cada turno, obtén 1 tentáculo"
  },
  State_36334_Name = {
    Text = "Llamada de la Espiral"
  },
  State_3633_Name = {
    Text = "Aplica 2 capas de <WeaknessIconKeywords:debilidad> a todos los enemigos"
  },
  State_36346_Desc = {
    Text = "Cuando la vida llegue a 0, se convertirá en 1 punto de vida, no recibirá más daño y se preparará para liberar \"Semilla de nacimiento\""
  },
  State_36346_Name = {
    Text = "Espora de nacimiento"
  },
  State_3634_Name = {
    Text = "Agrega 2 cartas <DerivativeCardKeywords_4:\"inspiración\"> al mazo de robar"
  },
  State_3635_Name = {
    Text = "Otros despertados obtienen <Energy:[DescArg1]> puntos de locura"
  },
  State_36360_Desc = {
    Text = "Después de que comience el turno, hay un [DescArg1]% de probabilidad de obtener 1 capa de tentáculos reunidos, si supera el 100%, se pueden obtener múltiples capas"
  },
  State_36360_Name = {
    Text = "Línea de retorno al mar"
  },
  State_36361_Desc = {
    Text = "Al entrar, otros aliados obtienen [Layer] puntos de fuerza"
  },
  State_36361_Name = {
    Text = "Desviación Divina"
  },
  State_3636_Desc = {
    Text = "Estado@Creación Encantamiento Campana Activa"
  },
  State_3636_Name = {
    Text = "Estado@Creación Encantamiento Campana Activa"
  },
  State_3637_Desc = {
    Text = "Cuando tu vida es inferior al 25% y no estás muerto, recuperas [Arg1] puntos de vida. Se desactiva permanentemente tras 3 activaciones"
  },
  State_3637_Name = {
    Text = "☆Alimentos de emergencia☆"
  },
  State_3638_Desc = {
    Text = "Al recibir Daño Activo o de Tentáculos, obtiene Inmunidad al daño y pierde 1 Acumulación."
  },
  State_3638_Name = {
    Text = "<ParcloseColour:Barrera>"
  },
  State_3638_WeaponDesc = {
    Text = "El daño recibido -99%. Cada vez que se recibe daño, pierde 1 Acumulación."
  },
  State_3639_Desc = {
    Text = "Cuando Ramona causa daño, obtiene [StateArg1] puntos de aritmética"
  },
  State_3639_Name = {
    Text = "Tercera filosofía"
  },
  State_3639_WeaponDesc = {
    Text = "Cuando Ramona causa daño, obtiene [StateArg1] puntos de aritmética"
  },
  State_3641_Desc = {
    Text = "En la \"escultura de cera inacabada\", elige una carta para reducir su aritmética en 1"
  },
  State_3641_Name = {
    Text = "Estado@Capítulo Dos_Resonancia_Efecto Básico"
  },
  State_3641_WeaponDesc = {
    Text = "En el nodo \"Estatua Inacabada\", las cartas copiadas aumentan su nivel en 1"
  },
  State_3642_Desc = {
    Text = "Cada vez que pierdas vida, obtendrás [Arg1] capas de contraataque. Si es la tercera vez en un solo turno, infligirás daño de contraataque a todos los enemigos"
  },
  State_3642_Name = {
    Text = "Crono del difunto"
  },
  State_3646_Desc = {
    Text = "Cuando la vida no puede bajar de 1, al recibir daño letal, la intención se cambiará a supervivencia en circunstancias críticas. [Supervivencia en circunstancias críticas]: Recuperar el 100% de la vida máxima, doblar el poder, y fortalecer habilidades posteriores"
  },
  State_3646_Name = {
    Text = "Sobreviviendo al impasse"
  },
  State_3647_Name = {
    Text = "Contador del Registro Arcano de la Creación"
  },
  State_3648_Desc = {
    Text = "Equipo único: El efecto de recuperación de vida del portador aumenta <WeaponEffect_Num:[StateArg2]%>. Al comienzo de la ronda, obtiene <WeaponEffect_Num:[StateArg1]%> de <PowerIconKeywords:poder> y escudo temporal equivalente a la vida perdida en la última ronda"
  },
  State_3648_WeaponDesc = {
    Text = "El efecto de curación del portador aumenta en <WeaponEffect_Num:[StateArg2]%>. Al inicio del turno, obtiene <PowerIconKeywords:Fuerza> y escudo temporal igual a la vida perdida en el turno anterior <WeaponEffect_Num:[StateArg1]>"
  },
  State_3649_Desc = {
    Text = "Por cada despertador de profesión [ultra] en el equipo, la salud máxima (incompleta), defensa y ataque del equipo aumentan un 50%"
  },
  State_3649_Name = {
    Text = "Bonificación Hiperdimensional"
  },
  State_3649_WeaponDesc = {
    Text = "Por cada despertador de profesión [ultra] en el equipo, la salud máxima (incompleta), defensa y ataque del equipo aumentan un 50%"
  },
  State_3651_Desc = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_3651_Name = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_3651_WeaponDesc = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_3652_Desc = {
    Text = "Al inicio del turno, si jugaste más de [StateArg1] cartas en el turno anterior, roba [StateArg2] cartas"
  },
  State_3652_Name = {
    Text = "Guantes Mágicos de la Creación"
  },
  State_3652_WeaponDesc = {
    Text = "Al inicio del turno, si jugaste más de [StateArg1] cartas en el turno anterior, roba [StateArg2] cartas"
  },
  State_3653_Name = {
    Text = "Bandera de batalla rota de creación 2"
  },
  State_3654_Desc = {
    Text = "Al comienzo del turno, recibe [Layer]% de tasa crítica temporal"
  },
  State_3654_Name = {
    Text = "Melodía distante"
  },
  State_3654_WeaponDesc = {
    Text = "Si no pierdes vida hasta el inicio del siguiente turno, tu tasa crítica en ese turno aumenta en +[StateArg1]%"
  },
  State_3656_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_3656_Name = {
    Text = "No Activado"
  },
  State_3658_Desc = {
    Text = "Roba 2 cartas al jugar la última carta de tu mano. Máximo 2 veces por turno"
  },
  State_3659_Name = {
    Text = "Estado@impacto carta tasa crítica daño crítico aumentado"
  },
  State_36613_Name = {
    Text = "Estado@Accesorio Contador de Dios Mecánico"
  },
  State_3661_Desc = {
    Text = "Recibir daño real aumenta las capas de corrosión profunda"
  },
  State_3661_Name = {
    Text = "Recibir daño aumenta las capas de corrosión profunda"
  },
  State_3661_WeaponDesc = {
    Text = "Recibir daño real aumenta las capas de corrosión profunda"
  },
  State_3662_Desc = {
    Text = "Daño crítico aumentado en [Layer]% en esta batalla"
  },
  State_3662_Name = {
    Text = "Daño Crítico"
  },
  State_3662_WeaponDesc = {
    Text = "Daño crítico aumentado en [Layer]% en esta batalla"
  },
  State_36631_Desc = {
    Text = "Cada vez que se libera una explosión de locura, aumenta 1 capa de \"Gestación\"; cada capa de gestación otorga [StateArg1] puntos de poder, con un límite de 5 capas"
  },
  State_36631_Name = {
    Text = "Falsa portadora"
  },
  State_36635_Desc = {
    Text = "Cada vez que se libera una explosión de locura, aumenta 1 capa de \"Gestación\"; cada capa de gestación otorga [StateArg1] puntos de poder, con un límite de 5 capas"
  },
  State_36635_Name = {
    Text = "La Descendencia Final de Lemuria"
  },
  State_36636_Desc = {
    Text = "Al alcanzar 5 capas, lanzará \"¡Gloria de Lemuria!\", causando gran daño y llamando a los familiares"
  },
  State_36636_Name = {Text = "Gestar"},
  State_36637_Desc = {
    Text = "Al alcanzar 5 capas, lanzará \"¡Por Lemuria!\", causando gran daño y llamando a los familiares"
  },
  State_36637_Name = {Text = "Gestar"},
  State_3663_Desc = {
    Text = "Después de jugar la primera carta en cada turno, agrega una carta \"Golpe\" del Despertado correspondiente a tu mano"
  },
  State_3664_Desc = {
    Text = "Obtén 5 puntos de locura al jugarla"
  },
  State_3664_Name = {Text = "Homenaje"},
  State_3664_WeaponDesc = {
    Text = "Obtén 5 puntos de locura al jugarla"
  },
  State_3665_Desc = {
    Text = "Cuando la Fusión Embrionaria alcance su límite, coloca un \"Embrión\" en tu mano."
  },
  State_3665_Name = {
    Text = "<EmbryoFusionIconKeywords:Fusión Embrionaria>"
  },
  State_3666_Desc = {
    Text = "La tasa crítica aumenta [Layer] %"
  },
  State_3666_Name = {
    Text = "Probabilidad de Crítico"
  },
  State_3666_WeaponDesc = {
    Text = "La tasa crítica aumenta [Layer] %"
  },
  State_36670_Name = {
    Text = "Estado@Accesorio Re-evolución Contador"
  },
  State_36670_WeaponDesc = {
    Text = "Al final del turno, el portador obtiene 3 puntos de locura. Si la recarga de locura del portador es mayor a 10, obtiene 2 puntos de locura adicionales"
  },
  State_3667_Desc = {
    Text = "Equipo Único: El <RetaliateIconKeywords:Contrataque> infligido por el portador aumenta en <WeaponEffect_Num:[StateArg4]%. Después de jugar una carta, el portador obtiene un <RetaliateIconKeywords:Contrataque> equivalente a <WeaponEffect_Num:[StateArg1]%> de su DEF, aplicándose un máximo de 2 veces por turno; si entra en el Espacio Hiperspacial, el portador también obtendrá <WeaponEffect_Num:[StateArg2]> puntos de Alienación. Después de liberar Exaltar, todos los enemigos pierden <WeaponEffect_Num:[StateArg3]%> de Fuerza temporal, equivalente a la DEF del portador."
  },
  State_3667_WeaponDesc = {
    Text = "El <RetaliateIconKeywords:contraataque> causado por el portador aumenta en <WeaponEffect_Num:[StateArg4]%. Después de jugar una carta, el portador obtiene <WeaponEffect_Num:[Counterattack:DescArg1]> puntos de <RetaliateIconKeywords:contraataque>, pudiendo activarse un máximo de 2 veces por turno; si entra en el Espacio Hiperspacial, el portador también obtiene <WeaponEffect_Num:[StateArg2]> puntos de alienación. Tras liberar la exhalación, todos los enemigos reducen temporalmente su <WeaponEffect_Num:[Power:DescArg2]> de fuerza."
  },
  State_3668_Desc = {
    Text = "Estado@guardián del jardín de la alteración identificación"
  },
  State_3668_Name = {
    Text = "Estado@guardián del jardín de la alteración identificación"
  },
  State_3668_WeaponDesc = {
    Text = "Estado@guardián del jardín de la alteración identificación"
  },
  State_3669_Desc = {
    Text = "Inmunidad a la debilidad, fragilidad y estado vulnerable, durante [Layer] turnos."
  },
  State_3669_Name = {
    Text = "<BlessingColour: Bendición>"
  },
  State_3669_WeaponDesc = {
    Text = "[Layer] Inmune a estados negativos durante el turno"
  },
  State_36710_Name = {
    Text = "Danza de la Luna Gibosa"
  },
  State_3673_Desc = {
    Text = "Al recoger, elige 2 cartas para eliminar y obtienes [StateArg1] puntos de Fuerza"
  },
  State_3673_Name = {
    Text = "Cenizas Ardientes de la Estrella Negra de la Creación"
  },
  State_3674_Desc = {
    Text = "Al final del turno, reduce la locura de todos los despertados en 10"
  },
  State_3674_Name = {
    Text = "Aniquilación"
  },
  State_3674_WeaponDesc = {
    Text = "Al final del turno, reduce la locura de todos los despertados en 10"
  },
  State_3675_Name = {
    Text = "Roba el número de cartas descartadas + 1 carta"
  },
  State_3676_Desc = {
    Text = "Durante el turno del oponente, el daño recibido se reduce en [Layer] %"
  },
  State_3676_Name = {Text = "Vigilante"},
  State_3676_WeaponDesc = {
    Text = "En el turno de nuestro equipo, los monstruos obtienen [Layer] % de reducción de daño"
  },
  State_3677_Desc = {
    Text = "Aumenta la defensa en [Layer]%"
  },
  State_3677_Name = {
    Text = "Porcentaje de defensa temporal aumentado"
  },
  State_3677_WeaponDesc = {
    Text = "Aumenta la defensa en [Layer]%"
  },
  State_36781_Desc = {
    Text = "Cuando se reduce la fuerza, solo se reduce el 50% de las capas de fuerza"
  },
  State_36781_Name = {
    Text = "Voluntad sedienta de recibir daño"
  },
  State_3678_Name = {
    Text = "Estado@EventoCreación1"
  },
  State_36797_Desc = {
    Text = "En esta ronda, el daño de tentáculo se reduce en [Layer] puntos"
  },
  State_36797_Name = {
    Text = "Daño de tentáculo reducido"
  },
  State_3679_Name = {
    Text = "Estado@EventoCreación2"
  },
  State_3680_Desc = {
    Text = "Cada vez que se causa 1 daño, se aplica a la meta [Arg1] capas de veneno. Si se alcanza un total acumulado de 25 activaciones dentro de esta batalla, se activa inmediatamente el veneno en todos los enemigos"
  },
  State_3681_Desc = {
    Text = "Al infligir daño sin bloquear, deja [DescArg1] acumulaciones de <BrokenCard:Sabotaje> en 2 \"Tarjetas de comando\" aleatorias."
  },
  State_3681_Name = {
    Text = "¡Jenkin despierta!"
  },
  State_3681_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_3682_Desc = {
    Text = "Por cada 10% de disminución de la vida, todos los despertadores obtienen 10 de locura, y al morir se aumenta el daño de los tentáculos"
  },
  State_3682_Name = {
    Text = "Núcleo de Plata Profundamente Enterrado"
  },
  State_3682_WeaponDesc = {
    Text = "Por cada 10% de disminución de la vida, todos los despertadores obtienen 10 de locura, y al morir se aumenta el daño de los tentáculos"
  },
  State_3683_Desc = {
    Text = "Equipo Único: La curación causada por las tarjetas de comando del portador aumenta en <WeaponEffect_Num:[StateArg2]%. Antes de que el portador libere \"exaltar\", otros Despertados obtienen <WeaponEffect_Num:[StateArg1]> puntos de alienación. Si nuestro equipo está en estado <VulnerabilityIconKeywords:vulnerable>, el efecto se duplica."
  },
  State_3683_WeaponDesc = {
    Text = "La curación causada por las tarjetas de comando del portador aumenta en <WeaponEffect_Num:[StateArg2]%. Antes de que el portador libere la exaltación, otros Despertados obtienen <WeaponEffect_Num:[StateArg1]> puntos de alienación. Si nuestro equipo está en estado <VulnerabilityIconKeywords:vulnerable>, el efecto se duplica."
  },
  State_3684_Desc = {
    Text = "Cada vez que recibes 1 punto de daño, reduce 1 capa. Cuando las capas llegan a 0, reemplaza la intención con \"flor inmortal\" y usa un conjunto de habilidades defensivas"
  },
  State_3684_Name = {
    Text = "Flor eterna"
  },
  State_3684_WeaponDesc = {
    Text = "Cada vez que recibes 1 punto de daño, reduce 1 capa. Cuando las capas llegan a 0, cambia a modo defensa"
  },
  State_3685_Desc = {
    Text = "Al robar, pierdes 1 aritmética y robas 1 carta"
  },
  State_3685_Name = {Text = "Confusión"},
  State_3685_WeaponDesc = {
    Text = "Al robar, pierdes 1 aritmética y robas 1 carta"
  },
  State_3686_Desc = {
    Text = "Al robar, pierdes 1 aritmética y robas 1 carta"
  },
  State_3686_Name = {
    Text = "Sello dimensional"
  },
  State_3686_WeaponDesc = {
    Text = "Al robar, pierdes 1 aritmética y robas 1 carta"
  },
  State_36884_Desc = {
    Text = "El último juramento en esta batalla ya no puede activar resistencia a la muerte para obtener escudos"
  },
  State_36884_Name = {
    Text = "El voto final"
  },
  State_3688_Desc = {
    Text = "Al jugar consecutivamente 2 cartas con un consumo de aritmética mayor que la carta anterior, ganas 2 aritmética"
  },
  State_3688_Name = {
    Text = "Registro Arcano de la Creación"
  },
  State_3688_WeaponDesc = {
    Text = "Al jugar consecutivamente 2 cartas con un consumo de aritmética mayor que la carta anterior, ganas 2 aritmética"
  },
  State_3689_Desc = {
    Text = "Al inicio del turno, aumenta la maestría de dominio en 30. Si no estás en estado negativo, la maestría de dominio aumenta a 100"
  },
  State_3692_Desc = {
    Text = "Posee cartas misteriosas con mil formas. ¡Elige la que más necesites!"
  },
  State_3692_Name = {
    Text = "<CardKeyWord:mil espejismos>"
  },
  State_3692_WeaponDesc = {
    Text = "Posee cartas misteriosas con mil formas. ¡Elige la que más necesites!"
  },
  State_3693_Desc = {
    Text = "La tasa crítica aumenta un 25%. Después de un retorno de vida, existe la posibilidad de causar 1 retorno de vida adicional, con probabilidad igual a la tasa crítica del que causa la recuperación"
  },
  State_3693_Name = {
    Text = "Estado@LlavePlataSueños:CurarCrítico"
  },
  State_3696_Desc = {
    Text = "Cada vez que se causa 1 daño, se obtiene [Arg1] puntos de alerta. Al inicio del turno, por cada 3 puntos de escudo restantes, se obtiene 1 punto de poder en ese turno"
  },
  State_3696_Name = {
    Text = "Péndulo temporal \"Oculto\""
  },
  State_3697_Desc = {
    Text = "Al comienzo del turno, roba 1 carta. Si juegas 2 veces seguidas una carta con el mismo coste de aritmética que la anterior, roba 1 carta adicional"
  },
  State_3698_Desc = {
    Text = "Al jugar, copia [StateArg1] cartas en el <DimensionalSpaceIconKeywords:Espacio Dimensional> temporal"
  },
  State_3698_Name = {
    Text = "<Rune_13:Teletransporte>"
  },
  State_3699_Name = {
    Text = "Núcleo de Plata Residual"
  },
  State_3700_Desc = {
    Text = "Aumenta el ataque en [Layer]%"
  },
  State_3700_Name = {
    Text = "Aumento temporal del porcentaje de poder de ataque"
  },
  State_3700_WeaponDesc = {
    Text = "Aumenta el ataque en [Layer]%"
  },
  State_3702_Desc = {
    Text = "Estado@cambio genérico de salud máxima"
  },
  State_3702_Name = {
    Text = "Estado@cambio genérico de salud máxima"
  },
  State_3702_WeaponDesc = {
    Text = "Estado@cambio genérico de salud máxima"
  },
  State_3703_Name = {
    Text = "Estado@Capítulo Cuatro_Resonancia@Cartas Robadas en el Próximo Turno 2"
  },
  State_3704_Desc = {
    Text = "Maestría en dominios aumenta en 30. Al recoger, elige una creación y cámbiala por una aleatoria"
  },
  State_3705_Name = {
    Text = "Iluminación de luna marina 3"
  },
  State_3707_Desc = {
    Text = "Después de que comience la batalla, se barajarán [StateArg1] copias temporales en la pila de robo, las cartas originales y copias espejo obtendrán retener"
  },
  State_3707_Name = {
    Text = "<Rune_8:Espejo>"
  },
  State_3708_Desc = {
    Text = "Al final del turno par, cada carta restante en la mano hace que comiences el siguiente turno con 1 aritmética"
  },
  State_3708_Name = {
    Text = "Fragmento de sabiduría del sabio de creación 2"
  },
  State_3708_WeaponDesc = {
    Text = "Al final del turno par, cada carta restante en la mano hace que comiences el siguiente turno con 1 aritmética"
  },
  State_3709_Desc = {
    Text = "Al final de la ronda impar, cada punto de aritmética restante te permite comenzar la siguiente ronda robando 1 carta"
  },
  State_3709_Name = {
    Text = "Fragmento de sabiduría del sabio de creación 1"
  },
  State_3709_WeaponDesc = {
    Text = "Al final de la ronda impar, cada punto de aritmética restante te permite comenzar la siguiente ronda robando 1 carta"
  },
  State_3711_Desc = {
    Text = "Cada vez que actúe, causa [Layer] sangrado"
  },
  State_3711_Name = {
    Text = "Salpicadura de sangre"
  },
  State_3711_WeaponDesc = {
    Text = "Cada vez que actúe, causa [Layer] sangrado; la curación puede reducir a la mitad las capas de sangrado"
  },
  State_3712_Desc = {
    Text = "Después de jugar la carta, se consume; la carta de comando inflige 3 veces el daño y la defensa, durando 1 turno"
  },
  State_3712_Name = {
    Text = "disolución"
  },
  State_3714_Desc = {
    Text = "Obtén [StateArg1] puntos de escudo al jugarla"
  },
  State_3714_Name = {
    Text = "<Rune_6:Muralla>"
  },
  State_3716_Desc = {
    Text = "En esta batalla, la tasa crítica aumenta en un [Layer] %"
  },
  State_3716_Name = {
    Text = "Probabilidad de Crítico"
  },
  State_3719_Desc = {
    Text = "Por cada instancia de Daño Activo recibido, el Tentáculo contraatacará a la Fuente de Daño una vez, durante [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_3719_Name = {
    Text = "Linaje de la Herejía"
  },
  State_3720_Desc = {
    Text = "Aumenta [Layer] puntos de defensa"
  },
  State_3720_Name = {
    Text = "Aumento de DEF General"
  },
  State_3720_WeaponDesc = {
    Text = "Aumenta [Layer] puntos de defensa"
  },
  State_3721_Desc = {
    Text = "Después de jugar, no pasará al montón de descarte, sino que será removido del mazo"
  },
  State_3721_Name = {Text = "Consumo"},
  State_3721_WeaponDesc = {
    Text = "Después de jugar, la carta no irá al montón de descarte, no podrá usarse nuevamente en esta batalla"
  },
  State_3722_Desc = {
    Text = "Cada vez que causas daño, aumenta temporalmente el daño de tentáculo en [StateArg1], se acumula hasta 5 veces. Al alcanzar el máximo, genera un tentáculo"
  },
  State_3722_Name = {
    Text = "Cetro del sacerdote de creación"
  },
  State_3722_WeaponDesc = {
    Text = "Cada vez que causas daño, aumenta temporalmente el daño de tentáculo en [StateArg1], se acumula hasta 5 veces. Al alcanzar el máximo, genera un tentáculo"
  },
  State_3723_Name = {
    Text = "Espejo Negro de la Creación"
  },
  State_3724_Desc = {
    Text = "Al recoger, se pierden todas las otras reliquias y se obtienen aleatoriamente 2 reliquias de oro"
  },
  State_3726_Name = {
    Text = "Revelación de carroña retorcida"
  },
  State_3728_Desc = {
    Text = "Al comenzar la batalla, recibe una carta [golpe]"
  },
  State_3728_Name = {
    Text = "Salto de Ballena Iluminar 1"
  },
  State_3728_WeaponDesc = {
    Text = "Al comenzar la batalla, recibe una carta [golpe]"
  },
  State_3730_Desc = {
    Text = "Estado@monstruo dulce demonio tragedia color miel"
  },
  State_3730_Name = {
    Text = "Estado@monstruo dulce demonio tragedia color miel"
  },
  State_3730_WeaponDesc = {
    Text = "Estado@monstruo dulce demonio tragedia color miel"
  },
  State_3731_Desc = {
    Text = "Cada vez que nuestro equipo compra en la tienda, en la siguiente batalla se roba una carta adicional por turno y se obtiene 1 punto de aritmética"
  },
  State_3732_Desc = {
    Text = "Cada 3 turnos, obtén 3 tentáculos temporales que ignoran el límite de tentáculos"
  },
  State_3732_Name = {
    Text = "Apéndice sin nombre de creación"
  },
  State_3732_WeaponDesc = {
    Text = "Cada 3 turnos, obtén 3 tentáculos temporales que ignoran el límite de tentáculos"
  },
  State_3733_Desc = {
    Text = "Al final de la ronda impar, la aritmética restante se convierte en robos adicionales para la siguiente ronda; al final de la ronda par, las cartas restantes se convierten en aritmética adicional para la siguiente ronda"
  },
  State_3735_Name = {
    Text = "Las capas de \"veneno\" de nuestro equipo se reducen a la mitad"
  },
  State_3738_Desc = {
    Text = "Al final del turno, Fusión Embrionaria +15%; si hay un \"embrión\" en la mano, recupera [Arg1] vidas"
  },
  State_3738_Name = {
    Text = "Registro de Peste"
  },
  State_3739_Name = {
    Text = "Efecto de forma orgánica de accesorios"
  },
  State_3739_WeaponDesc = {
    Text = "Después de que el portador use exaltar, sus escudos y curas en este turno se duplican"
  },
  State_3740_Name = {
    Text = "Estado@Demonio Dulce Contador de Críticos"
  },
  State_3741_Desc = {
    Text = "Al inicio del turno 3, añade una carta \"Eco del pasado: descarta todas las cartas, restaura vida y escudo al estado del final del turno anterior. Mantener, consumir.\""
  },
  State_3742_Desc = {
    Text = "Después de jugar, todos los enemigos se vuelven vulnerables por [StateArg1] turnos"
  },
  State_3742_Name = {
    Text = "<Rune_1: vulnerable>"
  },
  State_3743_Desc = {
    Text = "La sexta carta que juegues tendrá un efecto adicional"
  },
  State_3743_Name = {
    Text = "Vino de las estrellas de creación"
  },
  State_3744_Name = {
    Text = "Contador del espejo ritual de Menfis de creación"
  },
  State_3747_Name = {
    Text = "Elige 1 carta del mazo de robo para agregar a tu mano"
  },
  State_3748_Name = {
    Text = "La tasa crítica del daño causado aumenta en [DescArg1]%, el daño crítico aumenta en [DescArg2]%"
  },
  State_3750_Name = {
    Text = "Tasa crítica temporal +[DescArg1]%. En esta batalla, el daño base de \"decapitación\" y \"mil espejismos\" aumenta un 5%"
  },
  State_3751_Name = {
    Text = "Obtener [StateArg1] puntos de <PowerIconKeywords:fuerza>"
  },
  State_3752_Name = {
    Text = "Obtén <Posse:[DescArg1]> puntos de energía llave de plata. Obtén <Block:[Block:StateArg1]> puntos de escudo"
  },
  State_3753_Desc = {
    Text = "Las cartas no entran en la pila de descarte durante la fase de descarte, sino que se mantienen en la mano"
  },
  State_3753_Name = {
    Text = "<RetainIconKeywords:Retener>"
  },
  State_3753_WeaponDesc = {
    Text = "Las cartas no entran en la pila de descarte durante la fase de descarte, sino que se mantienen en la mano"
  },
  State_3754_Desc = {
    Text = "Al causar daño activo, aumenta el daño de tentáculo en [Arg1] este turno, hasta 3 veces. Al alcanzar el máximo, genera 1 tentáculo, se elimina al final del turno"
  },
  State_3755_Desc = {
    Text = "Equipo Único: El escudo causado por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>, y la recuperación de vida aumenta en <WeaponEffect_Num:[StateArg1]%. Al final de los turnos impares, la probabilidad de crítico del portador aumenta en <WeaponEffect_Num:[StateArg2]%> y obtiene <WeaponEffect_Num:[StateArg3]> puntos de alienación; al final de los turnos pares, el daño crítico del portador aumenta en <WeaponEffect_Num:[StateArg2]%> y obtiene <WeaponEffect_Num:[StateArg4]> energía de llave plateada. Si el dominio actual es \"Carne y sangre\", el límite de acumulación del Horno Carmesí aumenta en <WeaponEffect_Num:[StateArg5]%>."
  },
  State_3755_WeaponDesc = {
    Text = "El escudo infligido por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>, y la recuperación de vida aumenta en <WeaponEffect_Num:[StateArg1]>. Al final de los turnos impares, la probabilidad de crítico del portador aumenta en <WeaponEffect_Num:[StateArg2]>, y obtiene <WeaponEffect_Num:[StateArg3]> puntos de aliemus; al final de los turnos pares, el daño crítico del portador aumenta en <WeaponEffect_Num:[StateArg2]>, y obtiene <WeaponEffect_Num:[StateArg4]> puntos de energía de llave plateada. Si el dominio actual es \"Carne y sangre\", aumenta el límite de acumulación del Horno Carmesí en <WeaponEffect_Num:[StateArg5]>."
  },
  State_3757_Desc = {
    Text = "Nuestro equipo gana [StateArg1] capas de escudo por cada carta jugada. Dura 1 turno"
  },
  State_3757_Name = {
    Text = "Plumas volantes"
  },
  State_3757_WeaponDesc = {
    Text = "Nuestro equipo gana [StateArg1] capas de escudo por cada carta jugada. Dura 1 turno"
  },
  State_3759_Name = {
    Text = "Armadura mecánica 1"
  },
  State_3760_Desc = {
    Text = "Si tienes al menos [StateArg1] el sigilo negro, [exaltar] perderá [StateArg1] el sigilo negro, vulnerabilizando y debilitando a todos los enemigos durante 1 turno"
  },
  State_3760_Name = {
    Text = "Pájaro del ritual de la fatalidad de creación"
  },
  State_3760_WeaponDesc = {
    Text = "Si tienes al menos [StateArg1] el sigilo negro, [exaltar] perderá [StateArg1] el sigilo negro, vulnerabilizando y debilitando a todos los enemigos durante 1 turno"
  },
  State_3761_Desc = {
    Text = "Cada vez que el equipo robe 1 carta de tambaleo, obtiene [Layer] puntos de fuerza"
  },
  State_3761_Name = {
    Text = "Ceremonia de la linterna"
  },
  State_3761_WeaponDesc = {
    Text = "Cada vez que el equipo robe 1 carta de tambaleo, obtiene [Layer] puntos de fuerza"
  },
  State_3763_Desc = {
    Text = "Por cada golpe que cause el Corredor, el daño crítico aumenta en [StateArg3]% este turno"
  },
  State_3763_Name = {
    Text = "Pasillo plegable"
  },
  State_3763_WeaponDesc = {
    Text = "Por cada golpe que cause el Corredor, el daño crítico aumenta en [StateArg3]% este turno"
  },
  State_3764_Name = {
    Text = "Armadura mecánica 2"
  },
  State_3766_Name = {
    Text = "Añadir multiplicador de fuerza carmesí"
  },
  State_3767_Desc = {
    Text = "Al inicio del turno, inflige [Arg1] daño a un enemigo aleatorio. Después de jugar 7 veces \"Golpe\" en esta batalla, el daño se convierte en [Arg2]"
  },
  State_3767_Name = {
    Text = "Rompecabezas antiguo"
  },
  State_3768_Desc = {
    Text = "El daño activo recibido siempre es crítico, se elimina al final del turno"
  },
  State_3768_Name = {Text = "Defecto"},
  State_3768_WeaponDesc = {
    Text = "El daño activo recibido siempre es crítico, se elimina al final del turno"
  },
  State_3770_Name = {
    Text = "Contador de la Reliquia Arcana de la Creación"
  },
  State_3771_Desc = {
    Text = "Al comenzar la batalla, recibe 3 puntos de aritmética"
  },
  State_3772_Desc = {
    Text = "Cada vez que la hoja de venganza causa daño, aumenta temporalmente el poder equivalente al daño de tentáculo actual"
  },
  State_3772_Name = {
    Text = "Venganza preventiva"
  },
  State_3773_Desc = {
    Text = "Al final del turno, recibe <FixedDamage:DMG Puro> igual al número de Acumulaciones."
  },
  State_3773_Name = {
    Text = "<IntoxicationIconKeywords:Veneno>"
  },
  State_3773_WeaponDesc = {
    Text = "Al inicio del turno, recibe daño"
  },
  State_3774_Desc = {
    Text = "Cada vez que liberes la Exaltación, obtendrás una Infusión tóxica que puede aplicar [Arg1] puntos de Veneno. Al final del turno, si tienes 3 Infusiones tóxicas en la mano, puedes combinarlas para crear un Brote tóxico que activa el veneno."
  },
  State_3776_Desc = {
    Text = "Al recibir daño activo, añade una capa de \"Alerta\". Al llegar a 3 capas de \"Alerta\", retrocede"
  },
  State_3776_Name = {
    Text = "Muñeca tímida"
  },
  State_3776_WeaponDesc = {
    Text = "Al recibir daño activo, añade una capa de \"Alerta\". Al llegar a 3 capas de \"Alerta\", retrocede"
  },
  State_3777_Desc = {
    Text = "Al jugar, el Despertado obtiene [StateArg1] de locura"
  },
  State_3777_Name = {
    Text = "<Rune_5_High:Frenesí avanzado>"
  },
  State_3777_WeaponDesc = {
    Text = "Al jugar, el Despertado obtiene [StateArg1] de locura"
  },
  State_3778_Desc = {
    Text = "Inflige un 25% más de daño a enemigos con estados negativos, y el asesino obtiene 20 de locura al matar"
  },
  State_3779_Desc = {
    Text = "Límite de tentáculos -2. Al final del turno, todos los tentáculos atacan una vez más"
  },
  State_3779_Name = {
    Text = "Brazalete sagrado del dolor de creación"
  },
  State_3779_WeaponDesc = {
    Text = "Límite de tentáculos -2. Al final del turno, todos los tentáculos atacan una vez más"
  },
  State_3781_Desc = {
    Text = "Al inicio del turno, aplica \"Maldición de Estasis\" a las 2 cartas superiores del mazo"
  },
  State_3781_Name = {
    Text = "\"Ojo Maldito del Abismo\""
  },
  State_3781_WeaponDesc = {
    Text = "Al inicio del turno, aplica \"Maldición de Estasis\" a las 2 cartas superiores del mazo"
  },
  State_3782_Desc = {
    Text = "Único del equipo: Al comenzar la exploración, se añade una carta de \"DEF\" del portador al mazo. El escudo de \"DEF\" del portador aumenta en <WeaponEffect_Num:[StateArg1]%>"
  },
  State_3782_WeaponDesc = {
    Text = "Al comenzar la exploración, añade una carta \"DEF\" del portador al mazo, el escudo de \"DEF\" del portador aumenta en <WeaponEffect_Num:[StateArg1]%>"
  },
  State_3783_Desc = {
    Text = "Equipo Único: El daño básico de exaltar del portador aumenta en <WeaponEffect_Num:[StateArg1]%>, y el escudo y la recuperación de vida aumentan en <WeaponEffect_Num:[StateArg2]%>."
  },
  State_3783_WeaponDesc = {
    Text = "El daño base de exaltar del portador aumenta en <WeaponEffect_Num:[StateArg1]%>, y el escudo y la recuperación de vida aumentan en <WeaponEffect_Num:[StateArg2]%>"
  },
  State_3784_Desc = {
    Text = "Equipo único: El daño base de las cartas de comando del portador aumenta en <WeaponEffect_Num:[StateArg1]>%, y la recuperación del escudo y la vida aumenta en <WeaponEffect_Num:[StateArg2]>%"
  },
  State_3784_WeaponDesc = {
    Text = "El daño base de las cartas de comando del portador aumenta en <WeaponEffect_Num:[StateArg1]%>, y el escudo y la recuperación de vida aumentan en <WeaponEffect_Num:[StateArg2]%"
  },
  State_3786_Desc = {
    Text = "¡Estás marcado! Al jugar, todos los monstruos obtienen [StateArg1] puntos de fuerza temporal, y se elimina la marca de inmersión de esta orden"
  },
  State_3786_Name = {
    Text = "<CardKeyWord:Marca de la Profundidad>"
  },
  State_3786_WeaponDesc = {
    Text = "Al jugar la carta, los Profundos reciben [StateArg1] puntos de fuerza temporal"
  },
  State_3787_Desc = {
    Text = "El único de la escuadra: Después de que el portador libera la exaltación, todos los aliados reciben <WeaponEffect_Num:[StateArg1]> puntos de locura"
  },
  State_3787_WeaponDesc = {
    Text = "Después de que el equipador libera la exaltación, todos los aliados reciben <WeaponEffect_Num:[StateArg1]> de aliemus"
  },
  State_3788_Desc = {
    Text = "Único del equipo: Al comenzar la exploración, se añade una carta de \"Golpe\" del portador al mazo. El daño base de \"Golpe\" del portador aumenta en <WeaponEffect_Num:[StateArg1]%>"
  },
  State_3788_WeaponDesc = {
    Text = "Al comenzar la exploración, añade una carta \"Golpe\" del portador al mazo, el daño base de \"Golpe\" del portador aumenta en <WeaponEffect_Num:[StateArg1]%>"
  },
  State_3790_Desc = {
    Text = "Estado@ContadorSustanciaIndefinida"
  },
  State_3790_Name = {
    Text = "Estado@ContadorSustanciaIndefinida"
  },
  State_3790_WeaponDesc = {
    Text = "Estado@ContadorSustanciaIndefinida"
  },
  State_3791_Desc = {
    Text = "Cada vez que causes daño, obtén [Arg1] puntos de escudo, hasta 5 veces por turno. Al alcanzar el máximo, coloca una carta \"Inspiración\" en tu mano"
  },
  State_3792_Desc = {
    Text = "Sin más efecto de petrificación"
  },
  State_3792_Name = {
    Text = "Resistencia a la petrificación"
  },
  State_3792_WeaponDesc = {
    Text = "Sin más petrificación, recibe triple daño"
  },
  State_3793_Desc = {
    Text = "Daño crítico aumentado en [Layer] % en esta etapa"
  },
  State_3793_Name = {
    Text = "Daño crítico permanente"
  },
  State_3793_WeaponDesc = {
    Text = "Daño crítico aumentado en [Layer] % en esta etapa"
  },
  State_3794_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_3794_Name = {
    Text = "Estado@Prototipo de Espada Larga Daño Crítico"
  },
  State_3796_Desc = {
    Text = "Por cada 20% de disminución de la vida, todos los despertadores obtienen 10 de locura, y al morir se aumenta el daño de los tentáculos"
  },
  State_3796_Name = {
    Text = "Partículas de Plata Precipitadas"
  },
  State_3796_WeaponDesc = {
    Text = "Por cada 20% de disminución de la vida, todos los despertadores obtienen 10 de locura, y al morir se aumenta el daño de los tentáculos"
  },
  State_3797_Desc = {
    Text = "Al recibir daño, obtén [StateArg1] puntos de fuerza temporal, eliminados al inicio del turno"
  },
  State_3797_Name = {
    Text = "¡La ira de la plaga de ratas!"
  },
  State_37980_Desc = {
    Text = "Maestría de dominio aumentada en [Layer] en esta batalla"
  },
  State_37980_Name = {
    Text = "Maestría del Reino"
  },
  State_3798_Desc = {
    Text = "Al causar daño real, recupera vida"
  },
  State_3798_Name = {
    Text = "Hoja vampírica"
  },
  State_3798_WeaponDesc = {
    Text = "Al causar daño real, recupera vida"
  },
  State_3799_Desc = {
    Text = "Por cada despertador de profesión [flesh] en el equipo, la salud máxima (incompleta), defensa y ataque del equipo aumentan un 50%"
  },
  State_3799_Name = {
    Text = "Bonus de carne y sangre"
  },
  State_3799_WeaponDesc = {
    Text = "Por cada despertador de profesión [flesh] en el equipo, la salud máxima (incompleta), defensa y ataque del equipo aumentan un 50%"
  },
  State_3800_Desc = {
    Text = "Inflige daño a todos los enemigos. <CardKeyWord:Fuerza> tiene múltiples efectos en este daño"
  },
  State_3800_Name = {
    Text = "<CardKeyWord:poder de la gran espada>"
  },
  State_3801_Desc = {
    Text = "Al causar daño no bloqueado, añade [StateArg1] capas de sangrado"
  },
  State_3801_Name = {Text = "Sangrar"},
  State_3802_Desc = {
    Text = "Mientras esté en la mano, cada vez que uses 1 carta de comando se convierte en una copia con un coste aritmético de 0"
  },
  State_3802_Name = {
    Text = "<CardKeyWord:Hijo Sagrado>"
  },
  State_3802_WeaponDesc = {
    Text = "Mientras esté en la mano, cada vez que uses 1 carta se convierte en una copia con un coste aritmético de 0"
  },
  State_3803_Desc = {
    Text = "Al comienzo de la batalla, todas las cartas con coste de aritmética de 1 tendrán su daño, escudo y sanación aumentados en [Arg1] durante esta batalla"
  },
  State_3804_Desc = {
    Text = "Conteo de tridente de alienación"
  },
  State_3804_Name = {
    Text = "Conteo de tridente de alienación"
  },
  State_3804_WeaponDesc = {
    Text = "Conteo de tridente de alienación"
  },
  State_3807_Name = {
    Text = "Sueño medicinal de accesorios"
  },
  State_3807_WeaponDesc = {
    Text = "Después de que comience la batalla, se mezclarán cartas de equipo en la pila de robo"
  },
  State_3808_Desc = {
    Text = "Estado@Cambio de Vida Actual Genérico"
  },
  State_3808_Name = {
    Text = "Estado@Cambio de Vida Actual Genérico"
  },
  State_3808_WeaponDesc = {
    Text = "Estado@Cambio de Vida Actual Genérico"
  },
  State_3810_Desc = {
    Text = "Al morir, aumenta la fuerza de otros aliados"
  },
  State_3810_Name = {
    Text = "lengua muerta"
  },
  State_3811_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_4_1"
  },
  State_3811_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_4_1"
  },
  State_3811_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_4_1"
  },
  State_3813_Name = {
    Text = "Inmunidad a la debilidad"
  },
  State_3815_Desc = {
    Text = "Al final del turno, todos los despertadores pierden [Layer] puntos de aliemus."
  },
  State_3815_Name = {
    Text = "<EnergyColour:Vacío>"
  },
  State_3815_WeaponDesc = {
    Text = "Reducir locura en [Layer]%"
  },
  State_3817_Desc = {
    Text = "Al inicio del turno, causa [DescArg1] de agotamiento al oponente"
  },
  State_3817_Name = {
    Text = "Dispersión"
  },
  State_3817_WeaponDesc = {
    Text = "Al inicio del turno, tu equipo recibe [DescArg1*Layer*0.01] capas de agotamiento"
  },
  State_3818_Name = {
    Text = "Estado@sabio iluminar 1"
  },
  State_3819_Name = {
    Text = "Despertar del rompedores de cadenas 1"
  },
  State_3819_WeaponDesc = {
    Text = "Imitación del Antiguo"
  },
  State_3821_Desc = {
    Text = "Al inicio del turno, obtiene un escudo igual a la mitad de la vida perdida en el turno anterior"
  },
  State_3821_Name = {
    Text = "Dolor y placer"
  },
  State_3821_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_3824_Desc = {
    Text = "Equipo Único: El daño base de la explosión de locura del portador aumenta en [StateArg1]%. Al comenzar la exploración, el portador entra en estado de personalidad de erudito. Después de que el portador libera la explosión de locura, alterna entre la personalidad de erudito y la de bufón. \nPersonalidad de Erudito: Al final del turno, el portador obtiene <WeaponEffect_Num:[StateArg2]> puntos de locura. \nPersonalidad de Bufón: Al final del turno, la probabilidad de crítico y el daño crítico del portador aumentan en <WeaponEffect_Num:+[StateArg3]%."
  },
  State_3824_WeaponDesc = {
    Text = "El daño básico de la explosión de locura del portador aumenta en [StateArg1]%. Al comenzar la exploración, el portador entra en el estado de personalidad de erudito. Después de que el portador libera la explosión de locura, alterna entre la personalidad de erudito y la de bufón. \n Personalidad de erudito: Al final del turno, el portador obtiene <WeaponEffect_Num:[StateArg2]> puntos de locura. \n Personalidad de bufón: Al final del turno, la probabilidad de crítico y el daño crítico del portador aumentan en <WeaponEffect_Num:+[StateArg3] %>."
  },
  State_3825_Desc = {
    Text = "Al recibir Daño Activo, inflige <FixedDamage:DMG Puro> a la Fuente de Daño igual al número de Acumulaciones."
  },
  State_3825_Name = {
    Text = "<RetaliateIconKeywords: contraataque>"
  },
  State_3825_WeaponDesc = {
    Text = "Cada vez que se recibe Daño Activo, inflige <FixedDamage:DMG Puro> al atacante."
  },
  State_3826_Name = {
    Text = "Estado@LlavePlataSueños:ContarExplosión"
  },
  State_3827_Desc = {
    Text = "Equipo único: La recuperación de vida del portador aumenta <WeaponEffect_Num:[StateArg1]%>. Después de liberar exaltar, al comienzo de la siguiente ronda se recupera <WeaponEffect_Num:[StateArg2]%> de vida perdida"
  },
  State_3827_WeaponDesc = {
    Text = "Aumenta la recuperación de vida del portador en <WeaponEffect_Num:[StateArg1]%>. Tras liberar la locura, recupera <WeaponEffect_Num:[DescArg1]%> de vida perdida al comienzo del siguiente turno"
  },
  State_3830_Name = {
    Text = "Tiene efecto 1 vez adicional"
  },
  State_3831_Name = {
    Text = "Raíz Inversa de la Creación"
  },
  State_3834_Desc = {
    Text = "El veneno de la araña del laberinto se duplica"
  },
  State_3834_Name = {
    Text = "Camino de los Perdidos"
  },
  State_3835_Desc = {
    Text = "Este turno, el daño crítico aumenta [Layer] %"
  },
  State_3835_Name = {
    Text = "Daño crítico temporal"
  },
  State_3835_WeaponDesc = {
    Text = "Este turno, el daño crítico aumenta [Layer] %"
  },
  State_3836_Desc = {Text = "Prueba 123"},
  State_3836_Name = {Text = "Prueba 123"},
  State_3837_Desc = {
    Text = "Equipo Único: La Alienación generada por el Portador +<WeaponEffect_Num:[StateArg1]%>, y el Veneno infligido por el Portador +<IntoxicationIconKeywords:[StateArg2]%>.\nDespués de que el Portador cause Daño Activo, todos los Despertados obtienen Daño crítico temporal igual al <WeaponEffect_Num:[StateArg3]%> del Daño Crítico base del Portador.\nSi el Reino incluye Aequor, el Límite de tentáculos +1 y se invoca 1 Tentáculo al inicio del combate.<WeaponEffect_Num:>"
  },
  State_3837_WeaponDesc = {
    Text = "La Alienación generada por el Portador +<WeaponEffect_Num:[StateArg1]%>, y el Veneno infligido por el Portador +<IntoxicationIconKeywords:[StateArg2]%>.\nTras que el Portador cause Daño Activo, el Daño crítico temporal de todos los Despertados +<WeaponEffect_Num:[DescArg1]%>.\nSi el Reino incluye Aequor, el Límite de tentáculos +1 y aparece 1 Tentáculo al inicio de la batalla.<WeaponEffect_Num:>"
  },
  State_3839_Desc = {
    Text = "Al comienzo de la batalla, por cada carta de síntomas en el mazo se obtienen [Arg1] puntos de poder. Todas tus cartas de síntomas obtienen ilusión"
  },
  State_3840_Desc = {
    Text = "Cada vez que la vida disminuye, gana [StateArg1] de alerta"
  },
  State_3840_Name = {Text = "Vigilancia"},
  State_3842_Desc = {
    Text = "Todo el Daño Activo y Daño de tentáculos infligido -[DescArg1]%."
  },
  State_3842_Name = {Text = "Debilidad"},
  State_3842_WeaponDesc = {
    Text = "Todo el daño infligido se reduce en [DescArg1] %"
  },
  State_3843_Desc = {
    Text = "Cada vez que actúe, añade [Layer] sangrado"
  },
  State_3843_Name = {
    Text = "Lesión grave"
  },
  State_3843_WeaponDesc = {
    Text = "Cada vez que actúe, añade [Layer] sangrado; la curación puede eliminar el efecto de sangrado"
  },
  State_3844_Desc = {
    Text = "Todas las instancias de daño del Salto del Titán +1"
  },
  State_3844_Name = {
    Text = "Sed de batalla"
  },
  State_3844_WeaponDesc = {
    Text = "Todas las instancias de daño del Salto del Titán +1"
  },
  State_3845_Desc = {
    Text = "Poder de cálculo de las cartas reducido"
  },
  State_3845_Name = {
    Text = "Poder de cálculo de las cartas reducido"
  },
  State_3845_WeaponDesc = {
    Text = "Poder de cálculo de las cartas reducido"
  },
  State_3846_Name = {
    Text = "Impresión de jade de creación"
  },
  State_3848_Desc = {
    Text = "En esta batalla, una explosión de aliemus de un despertador al azar es sellada y no puede ser utilizada"
  },
  State_3848_Name = {Text = "Sellado"},
  State_3850_Desc = {
    Text = "Al jugar la carta número [StateArg1], aumenta el daño de tentáculo en [StateArg2] y hace que todos los tentáculos ataquen una vez"
  },
  State_3850_Name = {
    Text = "Forket de alienación"
  },
  State_3850_WeaponDesc = {
    Text = "Al jugar la carta número [StateArg1], aumenta el daño de tentáculo en [StateArg2] y hace que todos los tentáculos ataquen una vez"
  },
  State_3851_Name = {
    Text = "Gato del teatro de accesorios"
  },
  State_3851_WeaponDesc = {
    Text = "Todo el daño causado aumenta, el aumento es igual al 10% de la vida máxima del portador"
  },
  State_3852_Desc = {
    Text = "Aumenta el número de veces de daño por mordedura [Layer]"
  },
  State_3852_Name = {
    Text = "Mordedura creciente"
  },
  State_3852_WeaponDesc = {
    Text = "Aumenta el número de veces de daño por mordedura [Layer]"
  },
  State_3853_Desc = {
    Text = "Al comienzo del turno, transforma aleatoriamente en una copia de una carta de comando en la pila de robar, con un costo de aritmética fijo de 3, y vuelve al final del turno"
  },
  State_3853_Name = {
    Text = "<CardKeyWord:Delirio>"
  },
  State_3853_WeaponDesc = {
    Text = "Las cartas no entran en la pila de descarte durante la fase de descarte, sino que se mantienen en la mano"
  },
  State_3854_Desc = {
    Text = "Roba 2 cartas, ¡lo que atraerá la atención del Cazador de cráneos."
  },
  State_3854_Name = {
    Text = "<CardKeyWord:Cazado>"
  },
  State_3855_Desc = {
    Text = "Cierras los ojos ante su expresión de asombro."
  },
  State_3855_Name = {Text = "Fuerza"},
  State_3856_Desc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_3_1"
  },
  State_3856_Name = {
    Text = "Estado@PrólogoReiniciarMazo0_1_3_1"
  },
  State_3856_WeaponDesc = {
    Text = "Estado@PrólogoReiniciarMazo0_1_3_1"
  },
  State_3859_Desc = {
    Text = "La locura proporcionada por el Aliento de fertilidad se duplica"
  },
  State_3859_Name = {
    Text = "Ad Matrem Vocatus"
  },
  State_3859_WeaponDesc = {
    Text = "La locura proporcionada por el Aliento de fertilidad se duplica"
  },
  State_3860_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_3860_Name = {
    Text = "Estado@Prototipo de Cuchillo Suerte"
  },
  State_3862_Name = {
    Text = "Estado@Nivel2_15Batalla4Burbuja1"
  },
  State_3863_Desc = {
    Text = "Después de liberar 3 exaltaciones, el costo de aritmética de todas las cartas en mano se reduce en 1"
  },
  State_3866_Desc = {
    Text = "En este turno, el límite de cartas en mano aumenta en +[Layer]"
  },
  State_3866_Name = {
    Text = "Límite de cartas en mano aumentado"
  },
  State_3867_Name = {
    Text = "Contador de profesión transdimensional"
  },
  State_3868_Desc = {
    Text = "Este turno, el escudo generado aumenta [Layer]"
  },
  State_3868_Name = {
    Text = "Precaución temporal"
  },
  State_3868_WeaponDesc = {
    Text = "Este turno, el escudo generado aumenta [Layer]"
  },
  State_3872_Desc = {
    Text = "Recibir daño cancela la fuerza temporal"
  },
  State_3872_Name = {Text = "Defecto"},
  State_38730_Desc = {
    Text = "Después de que comience el turno, hay un [DescArg1]% de probabilidad de obtener 1 capa de tentáculos reunidos, si supera el 100%, se pueden obtener múltiples capas"
  },
  State_38730_Name = {
    Text = "Línea de retorno al mar"
  },
  State_38735_Desc = {
    Text = "Daño Activo infligido –[StateArg1]%, duplica el número de ataques, y dura [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_38735_Name = {Text = "Murmullos"},
  State_38738_Desc = {
    Text = "Límite de 10 capas, se puede heredar a la siguiente batalla"
  },
  State_38738_Name = {Text = "Onirismo"},
  State_3873_Desc = {
    Text = "Maestría de dominio aumentada en [Layer] en esta batalla"
  },
  State_3873_Name = {
    Text = "Maestría del Reino"
  },
  State_3874_Name = {
    Text = "Estado@Restauración de Cartas de Campana"
  },
  State_3876_Desc = {
    Text = "Cada turno par reduce la fuerza de nuestro equipo"
  },
  State_3876_Name = {
    Text = "\"Agujero del Sueño de la Muerte\""
  },
  State_3878_Desc = {
    Text = "Por cada 2 puntos de vida perdidos, obtén [Layer] puntos de escudo al inicio del próximo turno"
  },
  State_3878_Name = {
    Text = "Dolor y placer"
  },
  State_3878_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_3879_Desc = {
    Text = "Al recoger, se aumenta la salud máxima en [Arg1] puntos. Si la vida al recoger está por debajo del 25%, el aumento de la salud máxima se convierte en [Arg2] puntos"
  },
  State_3881_Desc = {
    Text = "Estado@MonstruoGeorgeComerEstatua"
  },
  State_3881_Name = {
    Text = "Estado@MonstruoGeorgeComerEstatua"
  },
  State_3881_WeaponDesc = {
    Text = "Estado@MonstruoGeorgeComerEstatua"
  },
  State_3882_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_3882_Name = {
    Text = "No Activado"
  },
  State_3883_Desc = {
    Text = "La tasa crítica en este nivel aumenta en [Layer] %"
  },
  State_3883_Name = {
    Text = "Tasa de golpe crítico permanente"
  },
  State_3883_WeaponDesc = {
    Text = "La tasa crítica en este nivel aumenta en [Layer] %"
  },
  State_3884_Desc = {
    Text = "Cada turno se genera 1 grado adicional de Fusión Embrionaria. Todos tus efectos devoradores se convierten en devoración infinita"
  },
  State_3884_Name = {
    Text = "Cordón umbilical palpitante de creación"
  },
  State_3884_WeaponDesc = {
    Text = "Cada turno se genera 1 grado adicional de Fusión Embrionaria. Todos tus efectos devoradores se convierten en devoración infinita"
  },
  State_3888_Desc = {
    Text = "No se puede liberar el estallido de locura, se elimina 1 capa al final del turno"
  },
  State_3888_Name = {
    Text = "<CardKeyWord:Sellar>"
  },
  State_3888_WeaponDesc = {
    Text = "La explosión de locura de todos los despertadores no puede ser utilizada"
  },
  State_3890_Name = {
    Text = "Roba [DescArg1] cartas adicionales del descarte"
  },
  State_3893_Desc = {
    Text = "Al causar daño, obtén [Arg1] puntos de escudo. Al curar vida, obtén [Arg2] puntos de fuerza temporal"
  },
  State_3893_Name = {
    Text = "Nuestro hogar"
  },
  State_3894_Desc = {
    Text = "Antes de la fase de descarte, convierte las cartas en piedras"
  },
  State_3894_Name = {Text = "Petrificar"},
  State_3894_WeaponDesc = {
    Text = "Antes de la fase de descarte, convierte las cartas en piedras"
  },
  State_3895_Desc = {
    Text = "La tasa crítica se incrementa en [Layer] % en esta ronda"
  },
  State_3895_Name = {
    Text = "Tasa de Crítico Temporal"
  },
  State_3895_WeaponDesc = {
    Text = "La tasa crítica se incrementa en [Layer] % en esta ronda"
  },
  State_3898_Desc = {
    Text = "Al inicio del próximo turno, obtén [Layer] puntos de escudo"
  },
  State_3898_Name = {
    Text = "Escudo de dolor y placer"
  },
  State_3900_Name = {
    Text = "La carta está sellada, no se puede jugar, se desbloquea al descartarla"
  },
  State_3901_Name = {
    Text = "Contador de cetro del sacerdote de creación"
  },
  State_3902_Desc = {
    Text = "Este turno, el daño activo infligido se reduce [Layer]"
  },
  State_3902_Name = {Text = "STR▼"},
  State_3902_WeaponDesc = {
    Text = "Este turno, el daño infligido se reduce [Layer]"
  },
  State_3904_Desc = {
    Text = "Por cada punto de vida perdido, elimina 1 capa. Al llegar a 0 capas, obtiene un escudo de [StateArg1] y recupera [StateArg2] capas de barrera de sangre"
  },
  State_3904_Name = {
    Text = "Despertar - Barrera de Sangre"
  },
  State_3905_Desc = {
    Text = "Cada vez que se recibe Daño Activo, inflige [Layer] de <FixedDamage:DMG Puro> a la fuente del daño."
  },
  State_3905_Name = {
    Text = "Contrataque"
  },
  State_3905_WeaponDesc = {
    Text = "Cada vez que se recibe Daño Activo, inflige [Layer] de <FixedDamage:DMG Puro> al atacante."
  },
  State_3906_Name = {
    Text = "Núcleo de Plata Residual"
  },
  State_3907_Name = {
    Text = "Núcleo de Plata Residual"
  },
  State_3908_Desc = {
    Text = "Cuando el cerebro en un frasco aplica la recuperación, roba [Arg2] cartas"
  },
  State_3908_Name = {
    Text = "Doble naturaleza de lo real y lo ilusorio"
  },
  State_3908_WeaponDesc = {
    Text = "Cuando el cerebro en un frasco aplica la recuperación, roba [Arg2] cartas"
  },
  State_3909_Name = {
    Text = "Núcleo de Plata Residual"
  },
  State_3910_Name = {
    Text = "Núcleo de Plata Residual"
  },
  State_3911_Name = {
    Text = "Núcleo de Plata Residual"
  },
  State_3912_Name = {
    Text = "Núcleo de Plata Residual"
  },
  State_3913_Desc = {
    Text = "Equipo único: el escudo infligido por el portador aumenta <WeaponEffect_Num:[StateArg1]%>. Al inicio del turno, se retiene <WeaponEffect_Num:[StateArg2]%> del escudo restante, con un máximo de <WeaponEffect_Num:[StateArg3]%> de escudo equivalente a la salud máxima"
  },
  State_3913_WeaponDesc = {
    Text = "El escudo causado por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Al comenzar el turno, se conserva el <WeaponEffect_Num:[StateArg2]%> del escudo restante, con un límite máximo equivalente al <WeaponEffect_Num:[StateArg3]%> de la salud máxima."
  },
  State_3914_Desc = {
    Text = "Al liberar la segunda vez elaliemus cada turno, todos los despertadores obtienen 10 puntos de aliemus. Al liberar la tercera vez elaliemus cada turno, todos los despertadores tienen su enfriamiento de aliemus restablecido y obtienen 10 puntos de aliemus"
  },
  State_3915_Name = {
    Text = "Núcleo de Plata Residual"
  },
  State_3916_Name = {
    Text = "Núcleo de Plata Residual"
  },
  State_3917_Desc = {
    Text = "Fuerza temporal en el próximo turno"
  },
  State_3917_Name = {Text = "Cargar"},
  State_3918_Desc = {
    Text = "Al inicio de cada turno, obtén el estado de daño doble en el primer golpe"
  },
  State_3918_Name = {Text = "Orgullo"},
  State_3918_WeaponDesc = {
    Text = "Al inicio de cada turno, obtén el estado de daño doble en el primer golpe"
  },
  State_3921_Desc = {
    Text = "Las cartas jugadas en esta ronda no entrarán en el montón de descarte durante la fase de descarte, sino que permanecerán en la mano"
  },
  State_3921_Name = {
    Text = "<RetainIconKeywords:Retener>"
  },
  State_3921_WeaponDesc = {
    Text = "Las cartas no entran en la pila de descarte durante la fase de descarte, sino que se mantienen en la mano"
  },
  State_3923_Desc = {
    Text = "Poder de cálculo de las cartas reducido"
  },
  State_3923_Name = {
    Text = "Reducción Permanente de la Potencia de Cálculo de las Cartas"
  },
  State_3923_WeaponDesc = {
    Text = "Poder de cálculo de las cartas reducido"
  },
  State_3925_Name = {
    Text = "Estado@capítulo cuatro resonancia@inicio del turno del equipo potencia 2"
  },
  State_3926_Desc = {
    Text = "\"'Banquete de cadáveres retorcidos' aumenta el daño en [Layer] puntos.\""
  },
  State_3926_Name = {
    Text = "Distorsión"
  },
  State_3926_WeaponDesc = {
    Text = "Aumenta el daño de \"Frenesí\""
  },
  State_3927_Desc = {
    Text = "Después de robar \"Vacío\", reduce la locura obtenida por todos los Despertados en un [Layer]% durante este turno"
  },
  State_3927_Name = {Text = "Vacío"},
  State_3927_WeaponDesc = {
    Text = "Después de robar \"Vacío\", reduce la locura obtenida por todos los Despertados en un [Layer]% durante este turno"
  },
  State_3928_Desc = {
    Text = "Cuando el dulce demonio inflige daño, obtiene [StateArg2] para contrarrestar"
  },
  State_3928_Name = {
    Text = "Tomar y sacar"
  },
  State_3929_Desc = {
    Text = "La fuerza y el escudo obtenidos se reducen en un 50%, se elimina 1 capa al final del turno"
  },
  State_3929_Name = {
    Text = "<CardKeyWord:Maldición>"
  },
  State_3929_WeaponDesc = {
    Text = "Este turno, inmune a estados positivos"
  },
  State_3930_Name = {
    Text = "Estado@capítulo cuatro resonancia@inicio del turno del equipo potencia 1"
  },
  State_3931_Name = {
    Text = "Estado@Himno de Sangre Escarlata y Arena"
  },
  State_3932_Desc = {
    Text = "Hacer que la carta se conserve, cada capa de maldición de estasis aumenta el coste de la carta en 1 punto, al jugarla elimina la maldición de estasis"
  },
  State_3932_Name = {
    Text = "Maldición estancada([Layer])"
  },
  State_3932_WeaponDesc = {
    Text = "Hacer que la carta se conserve, cada capa de maldición de estasis aumenta el coste de la carta en 1 punto, al jugarla elimina la maldición de estasis"
  },
  State_3933_Desc = {
    Text = "Aumenta [Layer] puntos de defensa"
  },
  State_3933_Name = {
    Text = "DEF temporal aumentada"
  },
  State_3933_WeaponDesc = {
    Text = "Aumenta [Layer] puntos de defensa"
  },
  State_3934_Desc = {
    Text = "Todos los escudos obtenidos se reducen en un 50%"
  },
  State_3934_Name = {
    Text = "Fragilidad de extinción"
  },
  State_3934_WeaponDesc = {
    Text = "Todos los escudos obtenidos se reducen en un 50%"
  },
  State_3935_Desc = {
    Text = "Nuestro equipo gana una capa de \"Observación\" por cada carta jugada, al llegar a diez capas, se aturde"
  },
  State_3935_Name = {
    Text = "Observación"
  },
  State_3936_Desc = {
    Text = "El portador causa daño, escudo y curación aumentan en [StateArg1]%. (Temporal)"
  },
  State_3936_Name = {
    Text = "Estado@Prototipo de Espada Larga Dominio"
  },
  State_3937_Desc = {
    Text = "La reina espinosa otorga un escudo que absorbe la mitad del contraataque"
  },
  State_3937_Name = {
    Text = "Muro de cadáveres"
  },
  State_3938_Name = {
    Text = "Generar una figura de cera"
  },
  State_3941_Desc = {
    Text = "Al devorar el embrión, regresa del montón de descarte al de mano"
  },
  State_3941_Name = {
    Text = "Espiral incolora"
  },
  State_3941_WeaponDesc = {
    Text = "Al devorar el embrión, regresa del montón de descarte al de mano"
  },
  State_3942_Name = {
    Text = "Línea de retorno de adornos"
  },
  State_3942_WeaponDesc = {
    Text = "Después de que comience la batalla, si el portador es del profundo, el poder de ataque aumenta en un 25%"
  },
  State_3943_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_3943_Name = {
    Text = "No Activado"
  },
  State_3944_Desc = {
    Text = "Después de terminar el turno, todos los despertadores obtienen 5 de aliemus. Por cada 1 de aritmética restante, todos los despertadores obtendrán 3 de aliemus adicionales"
  },
  State_3945_Desc = {
    Text = "El precio de todas las creaciones se reduce en un 50%"
  },
  State_39547_Desc = {
    Text = "Al finalizar la batalla, obtienes 5 marcas negras adicionales, este efecto se ve incrementado por la recompensa de sello negro. Después de que Wanda juegue una carta, obtiene 1 capa de onirismo, este efecto puede activarse un máximo de 2 veces por turno. Quedan [DescArg1] usos."
  },
  State_39547_Name = {
    Text = "Pieles y Venus"
  },
  State_40483_Name = {
    Text = "Alabarda destrozada"
  },
  State_40484_Desc = {
    Text = "Cuando el efecto de salto de la habilidad de Wanda se activa, si hay 5 capas, consume 5 capas y obtiene un efecto adicional. El límite máximo de <DreamGuide:sueño guía> es de 10 capas, que se heredarán a la siguiente batalla."
  },
  State_40484_Name = {
    Text = "<PurpleKeyWord:Guía de Sueños>"
  },
  State_41337_Desc = {
    Text = "Al final del turno, recupera [Layer] de vida"
  },
  State_41337_Name = {
    Text = "Victoria de la rosa-Recuperación"
  },
  State_41340_Desc = {
    Text = "Equipo único: el escudo y el mostrador infligidos por el portador aumentan <WeaponEffect_Num:[StateArg1]%>. Cada vez que se recibe un ataque, hay un <WeaponEffect_Num:[StateArg2]%> de probabilidad de que todos los despertadores obtengan 1 punto de aliemus"
  },
  State_41340_WeaponDesc = {
    Text = "El escudo y el contraataque causados por el portador aumentan en <WeaponEffect_Num:[StateArg1]%>. Cada vez que se recibe un ataque, hay un <WeaponEffect_Num:[StateArg2]%> de probabilidad de que todos los despertadores obtengan 1 punto de locura."
  },
  State_41342_Name = {
    Text = "Cambiar efecto __ \"Solo para uso en desarrollo\""
  },
  State_41344_Name = {
    Text = "Efecto de cambio"
  },
  State_41360_Desc = {
    Text = "Consume 5 niveles de <DreamGuide: guía de sueños>, wanda obtiene <Energy:[StateArg1]> puntos de aliemus, obtiene un <RetaliateIconKeywords: contraataque> temporal permanente equivalente a [StateArg2]%"
  },
  State_41360_Name = {
    Text = "Contador de sueño"
  },
  State_41361_Desc = {
    Text = "Agota 10 acumulaciones de <DreamGuide:Onirismo>, haciendo que todos los enemigos entren en el estado \"Murmullo\" durante 1 turno: Daño Activo infligido –[StateArg3]%, pero el número de ataques se duplica."
  },
  State_41361_Name = {
    Text = "Ecos de susurros"
  },
  State_43818_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_43818_Name = {
    Text = "No Activado"
  },
  State_44398_Desc = {
    Text = "Después de jugar la primera carta en cada turno, agrega una carta \"DEF\" del Despertado correspondiente a tu mano"
  },
  State_44484_Name = {
    Text = "Puede ser usado 3 veces en batallas de Líder"
  },
  State_44485_Name = {
    Text = "(Restante:[Layer])"
  },
  State_44491_Name = {
    Text = "Desactivar efecto __ \"Solo para uso de desarrollo\""
  },
  State_44562_Name = {
    Text = "Desactivar efecto"
  },
  State_44575_Desc = {
    Text = "Este turno, el escudo restante no se eliminará y se mantendrá hasta el próximo turno"
  },
  State_44575_Name = {
    Text = "Escudo mantenido"
  },
  State_44653_Desc = {
    Text = "Al inicio de cada turno, todos los despertadores obtienen 20 puntos de aliemus. Al recolectar, la salud máxima se reduce en 50%"
  },
  State_44665_Desc = {
    Text = "La tasa crítica de \"golpe\" en esta ronda se incrementa en [Layer] %"
  },
  State_44665_Name = {
    Text = "Tasa crítica de golpe"
  },
  State_44667_Desc = {
    Text = "\"El golpe\" obtiene [DescArg1] puntos de aritmética. Si la postura actual es \"Olas Furiosas\", no recibirás aritmética, sino que activarás 1 ataque de tentáculo [DescArg2] veces"
  },
  State_44667_Name = {
    Text = "El reinado del gigante"
  },
  State_44671_Desc = {
    Text = "Al inicio de cada turno, todos los despertadores obtienen 25 puntos de aliemus. Al recolectar, la salud máxima se convierte en 3 veces"
  },
  State_44672_Name = {
    Text = "Bendito: Mente de enjambre"
  },
  State_44711_Desc = {
    Text = "Límite de creación +5, refrescos en [d-marca] +1. Después de la batalla, se obtienen 125 el sigilo negro, al recoger se puede elegir eliminar hasta 6 cartas de síntoma"
  },
  State_44713_Desc = {
    Text = "Al finalizar la batalla, obtienes 100 el sigilo negro adicional y 2 cartas de síntoma"
  },
  State_44730_Desc = {
    Text = "Al inicio del turno, acumula <Heal:[Heal:StateArg1]> puntos de curación del Horno Carmesí"
  },
  State_44730_Name = {
    Text = "Ofrecer redención"
  },
  State_44731_Desc = {
    Text = "Con sufrimiento se disipa el sufrimiento. Consume toda la Cicatrización restante del Horno Carmesí, cada punto consumido aumenta el Daño en 3 (9 durante una Líder Batalla). Por cada 1% de PV Max del Horno Carmesí consumido, aumenta el Daño Final en [DescArg1]%."
  },
  State_44731_Name = {
    Text = "Liberación"
  },
  State_44732_Desc = {
    Text = "Con sangre se salva. Después de causar daño, pierde el 10% de la vida actual, acumulando una cantidad de curación del Horno Carmesí igual a la vida perdida"
  },
  State_44732_Name = {
    Text = "Dedicación"
  },
  State_44739_Desc = {
    Text = "Al recoger, pierdes permanentemente [Arg1] puntos de Fuerza. Cada vez que causas daño, recuperas [Arg2] puntos de vida, hasta 6 veces por turno"
  },
  State_44739_Name = {
    Text = "Pecado·Beso de la lamprea"
  },
  State_44740_Name = {
    Text = "Bendito: Beso de Lamprea"
  },
  State_44741_Desc = {
    Text = "Al recoger, pierdes permanentemente [Arg1] puntos de Fuerza. Cada vez que causas daño, recuperas [Arg2] puntos de vida, hasta 6 veces por turno"
  },
  State_44741_Name = {
    Text = "Pecado·Beso de la lamprea"
  },
  State_44742_Desc = {
    Text = "Al recoger, pierdes permanentemente [Arg1] puntos de Fuerza. Cada vez que causas daño, recuperas [Arg2] puntos de vida, hasta 6 veces por turno"
  },
  State_44742_Name = {
    Text = "Bendito: Beso de Lamprea"
  },
  State_44743_WeaponDesc = {
    Text = "Al comienzo de la batalla, se debilita uno mismo durante 3 turnos"
  },
  State_44744_WeaponDesc = {
    Text = "Al comienzo de la batalla, se debilita uno mismo durante 3 turnos"
  },
  State_44750_Desc = {
    Text = "Al comienzo del turno, obtén [StateArg1] de aritmética"
  },
  State_44750_Name = {
    Text = "Vela Negra de la Creación 1"
  },
  State_44751_Desc = {
    Text = "Al comienzo del turno, obtén [StateArg1] de aritmética"
  },
  State_44751_Name = {
    Text = "Vela Negra de la Creación 1"
  },
  State_44752_Desc = {
    Text = "Cada vez que \"Sofía\" pierde 1 punto de vida, baja 1 capa. Al llegar a 0 capas, cambia su intención a \"Ojo por ojo\" y obtiene [StateArg2] escudo. La primera vez que se activa, recupera todas las capas"
  },
  State_44752_Name = {
    Text = "Impulso Enterrado"
  },
  State_44762_Desc = {
    Text = "Al jugar \"DEF\", se baraja 1 carta de Herida en el montón de robo"
  },
  State_44762_Name = {Text = "Desgarrar"},
  State_44763_Desc = {
    Text = "El daño crítico de los Despertados se reduce a la mitad"
  },
  State_44763_Name = {
    Text = "<PurpleKeyWord: Cegar>"
  },
  State_44764_Desc = {
    Text = "Al jugar \"Golpe\", se baraja 1 carta de Herida en el montón de robo"
  },
  State_44764_Name = {Text = "Trauma"},
  State_44807_Desc = {
    Text = "Al estar a punto de ser derrotado por primera vez, recupera vida y cambia la intención a \"Juicio en el espejo\", reforzándose a sí mismo. Al estar a punto de ser derrotado por segunda vez, recupera vida y cambia la intención a \"Mordida de locura\", infligiendo un daño único extremadamente alto."
  },
  State_44807_Name = {
    Text = "Carnicinación Enterrada"
  },
  State_44819_Desc = {
    Text = "Si no hay <ParcloseIconKeywords:barrera>, se obtiene 1 capa de <ParcloseIconKeywords:barrera> temporal, de lo contrario, se obtienen un 10% de tasa crítica y daño crítico"
  },
  State_44819_Name = {
    Text = "<CardKeyWord:Protección del Padre>"
  },
  State_44828_Desc = {
    Text = "Equipo Único: Al final del turno, el Portador gana [StateArg1] Alienación. Al recibir Daño Activo y Daño de tentáculos, gana Blindaje igual al <WeaponEffect_Num:[StateArg2]%> del daño al inicio del siguiente turno. Si el Reino actual es Caro, gana Horno Carmesí igual al <WeaponEffect_Num:[StateArg2]%> del daño en su lugar."
  },
  State_44828_WeaponDesc = {
    Text = "Al final del turno, el Portador gana <WeaponEffect_Num:[StateArg1]> Alienación. Al recibir Daño Activo o Daño de tentáculos, gana Blindaje igual al <WeaponEffect_Num:[Float:StateArg2]%> del daño al inicio del siguiente turno. Si el Reino actual es Caro, gana Horno Carmesí igual al <WeaponEffect_Num:[Float:StateArg2]%> del daño en su lugar."
  },
  State_44889_Name = {
    Text = "Estado@PerroCaraHumanaJefe@EspejoFinal1"
  },
  State_44890_Name = {
    Text = "Estado@PerroCaraHumanaJefe@EspejoFinal2"
  },
  State_44891_Name = {
    Text = "Estado@PerroCaraHumanaJefe@EspejoFinal3"
  },
  State_44903_Desc = {
    Text = "Al recibir Daño Activo o Daño de tentáculos, el [StateArg1]% del daño se convertirá en cantidad de recuperación para el Horno Carmesí, durante [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_44903_Name = {
    Text = "Bendición del Creador"
  },
  State_44909_Name = {Text = "Consumible"},
  State_45018_Desc = {
    Text = "Antes de que termine el turno, no puedes usar \"Golpe\""
  },
  State_45018_Name = {Text = "Parálisis"},
  State_45025_Desc = {
    Text = "Consulta la lógica de huelga general para efectos específicos. __ \"Solo para uso de desarrollo\""
  },
  State_45029_Desc = {
    Text = "Consulta la lógica de huelga general para efectos específicos. __ \"Solo para uso de desarrollo\""
  },
  State_45032_Desc = {
    Text = "Al final del próximo turno, recibe [Layer] daño"
  },
  State_45032_Name = {Text = "Sangrar"},
  State_45039_Desc = {
    Text = "Hasta el inicio del siguiente turno, cada vez que se reciba Daño Activo o de Tentáculos, obtén un Escudo del personaje equivalente al [Layer]% del daño al inicio del siguiente turno."
  },
  State_45039_Name = {
    Text = "El amanecer del milagro"
  },
  State_45040_Desc = {
    Text = "Hasta el inicio del siguiente turno, cada vez que se reciba Daño Activo o de Tentáculos, acumula el [Layer]% del daño como curación para el Horno Carmesí."
  },
  State_45040_Name = {
    Text = "El amanecer del milagro"
  },
  State_45049_Desc = {
    Text = "Niega el Daño del próximo ataque activo (hasta 3 Acumulaciones). Cada Acumulación de Combate a muerte reduce las Acumulaciones máximas de Barrera en 1, pero no elimina las Barreras ya obtenidas."
  },
  State_45049_Name = {Text = "Barrera"},
  State_45050_Desc = {
    Text = "Niega el Daño del próximo ataque activo (hasta 3 Acumulaciones). Cada Acumulación de Combate a muerte reduce las Acumulaciones máximas de Barrera en 1, pero no elimina las Barreras ya obtenidas."
  },
  State_45050_Name = {
    Text = "<ReinforceColour:Barrera>"
  },
  State_45064_Name = {
    Text = "Contador de Banquete Silencioso__\"Dev Only\""
  },
  State_45069_Desc = {
    Text = "Consulta la lógica de huelga general para efectos específicos. __ \"Solo para uso de desarrollo\""
  },
  State_45072_Name = {
    Text = "Contador de santificación"
  },
  State_45073_Desc = {
    Text = "Poder de cálculo de las cartas reducido"
  },
  State_45076_Desc = {
    Text = "Al aplicar, disipa el escudo del objetivo y retrasa la curación, reduciendo en un 50% el efecto de curación y escudo antes del final del turno"
  },
  State_45076_Name = {Text = "Plaga"},
  State_45137_Desc = {
    Text = "Usar exaltar para sellar todos los despertadores durante un turno, y obtener un turno vulnerable"
  },
  State_45137_Name = {
    Text = "Pecado original: Cadáver del Camino"
  },
  State_45139_Desc = {
    Text = "Usar exaltar para dispersar aleatoriamente 1 estado negativo"
  },
  State_45139_Name = {
    Text = "Benditos: Restos del Caminante del Camino"
  },
  State_45148_Desc = {
    Text = "El daño crítico de los Despertados se reduce a la mitad"
  },
  State_45148_Name = {
    Text = "<PurpleKeyWord: Cegar>"
  },
  State_45166_Desc = {
    Text = "La rueda del destino equipada antes del final de la ronda se vuelve inválida."
  },
  State_45166_Name = {
    Text = "Entrelazados"
  },
  State_45206_Desc = {
    Text = "Con fe para la redención. Consuma toda la cantidad de recuperación restante del horno carmesí, obtendrá un escudo del 150% de la cantidad consumida, este escudo no se verá afectado por bonificaciones o penalizaciones de escudos, e ignora el límite de escudo"
  },
  State_45206_Name = {Text = "Redención"},
  State_45248_Name = {Text = "Contador"},
  State_45328_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Después de \"Exaltar\", te otorga <TauntKeywords:Pulla> y <Block:[Block:StateArg1]> Escudo del personaje."
  },
  State_45328_Name = {
    Text = "Magia de 35 mm"
  },
  State_45329_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: \"Golpe\" puede seleccionar un objetivo, y antes de realizar el \"Golpe\", <PVPRepelKeywords:repeler> todos los estados positivos que se puedan disipar del objetivo hacia los Despiertos que están detrás de él."
  },
  State_45329_Name = {
    Text = "El Llamado del Mar Profundo"
  },
  State_45331_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>:Al equipar y después de \"Golpear\", las \"Habilidades\" no derivadas en la mano del Portador se transforman secuencialmente en otras \"Habilidades\" del Portador [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_45331_Name = {
    Text = "Flores y poemas del pasado"
  },
  State_45332_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Cada vez que el portador recibe daño activo, otros aliados ganan <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_45332_Name = {
    Text = "La mirada de Isarau"
  },
  State_45333_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Tamaño Máximo de la Mano +[StateArg1], después de \"Exaltar\", obtén <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_45333_Name = {
    Text = "Despedida Ardiente con un Beso"
  },
  State_45334_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>：\"Habilidad\" convierte el próximo\"Golpe\"en objetivo aleatorio y ataca a [StateArg1] objetivos aleatorios más"
  },
  State_45334_Name = {
    Text = "El hombre en el espejo"
  },
  State_45345_Desc = {
    Text = "Para registrar el uso de habilidades de reproducción de fase 1"
  },
  State_45345_Name = {
    Text = "Identificador de fertilidad 1"
  },
  State_45346_Desc = {
    Text = "Para registrar el uso de habilidades de reproducción de fase 2"
  },
  State_45346_Name = {
    Text = "Identificador de fertilidad 2"
  },
  State_45354_Desc = {
    Text = "Esta carta no se puede Jugar"
  },
  State_45354_Name = {
    Text = "No se puede jugar __ \"Solo para desarrollo\""
  },
  State_45356_Desc = {
    Text = "Al final del turno, se convierte en la última carta de \"habilidad\" que jugaste, reduce su coste de potencia en -1, y al jugar, \"la verdadera forma de la niebla\" se baraja en la biblioteca"
  },
  State_45356_Name = {
    Text = "<CardKeyWord:Verdadera Forma de la Niebla Gris>"
  },
  State_45364_Desc = {
    Text = "Al inicio del próximo turno, este despertar obtiene [Layer] cartas de \"Golpe\""
  },
  State_45364_Name = {
    Text = "Golpe retardado"
  },
  State_45385_Desc = {
    Text = "El daño total causado en esta batalla se reduce en [Layer] puntos, no se puede disipar, de los cuales hay [DescArg1] capas de reducción temporal de poder que se eliminarán al final de la ronda"
  },
  State_45385_Name = {Text = "STR▼"},
  State_45387_Desc = {
    Text = "Daño total aumentado en [Layer] en esta batalla, no se puede disipar, [DescArg1] capas de fuerza temporal se eliminarán al final del turno"
  },
  State_45387_Name = {Text = "Fuerza"},
  State_45397_Desc = {
    Text = "Al inicio del turno, convierte 1 capa de <ParcloseIconKeywords:barrera> en <PowerIconKeywords:fuerza>."
  },
  State_45397_Name = {
    Text = "Victoria de las Rosas"
  },
  State_45403_Desc = {
    Text = "Al inicio de la siguiente ronda, obtienes [Layer] capas de carga"
  },
  State_45403_Name = {
    Text = "Carga retrasada"
  },
  State_45407_Desc = {
    Text = "Reducir Aliemus y Aliemus Retrasado en un 50%, y eliminar inmediatamente todo Aliemus Retrasado."
  },
  State_45407_Name = {Text = "Vacío"},
  State_45656_Desc = {
    Text = "Tercera resurrección del árbol madre, activa habilidad de procreación 2"
  },
  State_45658_Desc = {
    Text = "Primera resurrección del árbol madre, activa habilidad de procreación"
  },
  State_45661_Desc = {
    Text = "Cuando la vida llegue a 0, se convertirá en 1 punto de vida, no recibirá más daño y se preparará para liberar \"Fusión múltiple\""
  },
  State_45661_Name = {
    Text = "Multifusión"
  },
  State_45715_Desc = {
    Text = "Obtén poder temporal igual al [StateArg1]% de daño de tentáculo"
  },
  State_45715_Name = {Text = "Usurpar"},
  State_45716_Desc = {
    Text = "Obtén poder temporal igual al [StateArg1]% de daño de tentáculo. Goliath obtiene un 25% de tasa crítica temporal."
  },
  State_45716_Name = {Text = "Usurpar"},
  State_45717_Desc = {
    Text = "Aumenta el daño base de \"poder de la gran espada\" y \"daño por decapitación\" en un 25%. goliat obtiene <Energy:[Energy:StateArg2]> puntos de aliemus"
  },
  State_45717_Name = {
    Text = "Inactividad"
  },
  State_45718_Desc = {
    Text = "Aumenta el daño base de \"poder de la gran espada\" y \"daño por decapitación\" en un 25% durante esta batalla"
  },
  State_45718_Name = {
    Text = "Inactividad"
  },
  State_46057_Name = {
    Text = "Aritmética"
  },
  State_46079_Desc = {
    Text = "Este turno, cada vez que el objetivo reciba daño activo, el aliado con menos vida recupera [Layer] de vida"
  },
  State_46079_Name = {
    Text = "Guía de la Santa Sangre"
  },
  State_46119_Desc = {
    Text = "La próxima vez que seas atacado, aplica \"entretejer\" al atacante"
  },
  State_46119_Name = {
    Text = "Trampa del laberinto"
  },
  State_46124_Desc = {
    Text = "Antes de que termine el turno, no puedes realizar ninguna acción"
  },
  State_46124_Name = {Text = "Petrificar"},
  State_46138_Desc = {
    Text = "Se convierte en la última \"habilidad\" usada por el oponente y reduce su costo en 1"
  },
  State_46138_Name = {
    Text = "<CardKeyWord:Simulación Estelar>"
  },
  State_46139_Desc = {
    Text = "Cada vez que se es atacado activamente, gana [Layer] capas de carga e inflige [Layer] capas de estancamiento al atacante."
  },
  State_46139_Name = {
    Text = "Gravedad anómala"
  },
  State_46155_Desc = {
    Text = "Después de tu propia \"Habilidad,\" gana [StateArg1] capas de carga y reduce el conteo de capas en 1. Al final del turno, consume todas las capas, restaurando [StateArg2] salud por cada capa."
  },
  State_46155_Name = {
    Text = "Sangre aberrante"
  },
  State_46243_Name = {
    Text = "Contador de Inspiración__\"Dev Only\""
  },
  State_46255_Desc = {
    Text = "Consulta la lógica de huelga general para efectos específicos. __ \"Solo para uso de desarrollo\""
  },
  State_46256_Desc = {
    Text = "Consulta la lógica de huelga general para efectos específicos. __ \"Solo para uso de desarrollo\""
  },
  State_46322_Desc = {
    Text = "Al inicio del turno, obtén 30 de Fusión Embrionaria."
  },
  State_46322_Name = {
    Text = "Yū Hashi Demo"
  },
  State_46323_Desc = {
    Text = "Después de que comience la ronda transdimensional, obtén 100 puntos de locura y 7 puntos de fuerza"
  },
  State_46323_Name = {
    Text = "Prueba de Liz"
  },
  State_46324_Desc = {
    Text = "Obtén 1 carta \"Inspiración\" en cada turno"
  },
  State_46324_Name = {
    Text = "Jenkins prueba a jugar"
  },
  State_46329_Desc = {
    Text = "Después de que comience la batalla, se obtienen 600 puntos de energía-s de llave de plata, lotan obtiene 50 puntos de aliemus, y tras liberar exaltar, obtiene 44 puntos adicionales de aliemus"
  },
  State_46329_Name = {
    Text = "Bonificación de prueba"
  },
  State_46330_Desc = {
    Text = "Al comienzo del turno, obtén 30 de Fusión Embrionaria, 10 de Aliemus, [DescArg1] de Fortaleza, y añade 3 \"golpear\" al Mazo de robo."
  },
  State_46330_Name = {
    Text = "Prueba de Shiro"
  },
  State_46333_Name = {
    Text = "Prueba de Reya"
  },
  State_46334_Desc = {
    Text = "Después del turno 4, gana 100 de locura"
  },
  State_46334_Name = {Text = "Falos Demo"},
  State_46336_Desc = {
    Text = "Al inicio del turno, obtén 30 de Fusión Embrionaria y 10 de Aliemus."
  },
  State_46336_Name = {
    Text = "Agrippa Demo"
  },
  State_46337_Desc = {
    Text = "Al inicio del turno, obtén 10 de locura"
  },
  State_46337_Name = {
    Text = "Caecus Demo"
  },
  State_46338_Desc = {
    Text = "Al inicio del turno, obtén 30 de Fusión Embrionaria y 10 de Aliemus."
  },
  State_46338_Name = {Text = "Feint Demo"},
  State_46427_Desc = {
    Text = "Consulta la lógica de huelga general para efectos específicos. __ \"Solo para uso de desarrollo\""
  },
  State_46428_Desc = {
    Text = "Consulta la lógica de huelga general para efectos específicos. __ \"Solo para uso de desarrollo\""
  },
  State_46429_Desc = {
    Text = "Consulta la lógica de huelga general para efectos específicos. __ \"Solo para uso de desarrollo\""
  },
  State_46441_Desc = {
    Text = "Inmunidad a todo daño, se elimina al inicio del turno."
  },
  State_46441_Name = {
    Text = "Inmunidad al daño"
  },
  State_46442_Name = {
    Text = "Las cartas tienen prohibido modificar los tipos de objetivos de ataque __ \"Solo para uso en desarrollo\""
  },
  State_46500_Desc = {
    Text = "Consulta la lógica de huelga general para efectos específicos. __ \"Solo para uso de desarrollo\""
  },
  State_46505_Desc = {
    Text = "Durante este turno, cada vez que recibas Daño Activo, obtén [Layer] Aliemus."
  },
  State_46505_Name = {
    Text = "Conversión del dolor"
  },
  State_46508_Desc = {
    Text = "Al recibir Faint, el objetivo no puede actuar hasta que termine el turno. Recibir daño de Faint otorga Resistencia. Si la Resistencia está activa, el daño de Faint posterior se duplica pero el efecto de Faint se anula."
  },
  State_46508_Name = {
    Text = "Resistencia"
  },
  State_46511_Desc = {
    Text = "El daño de \"Superposición de rostros\" de este Despertado aumenta en [Layer]."
  },
  State_46511_Name = {
    Text = "Superposición de rostros"
  },
  State_46512_Desc = {
    Text = "Antes del final de la ronda, este despertador recibe daño de [Layer] después de jugar una carta."
  },
  State_46512_Name = {
    Text = "Bloqueo de Carta"
  },
  State_46513_Desc = {
    Text = "Amplía el próximo poema, otorgándole un efecto adicional, no se puede disipar."
  },
  State_46513_Name = {
    Text = "Tinta de duelo"
  },
  State_46536_Desc = {
    Text = "Si el parámetro de estado 1 es 0, roba cartas; en caso contrario, solo muestra texto flotante"
  },
  State_46536_Name = {Text = "Robar"},
  State_46538_Desc = {
    Text = "Al comenzar la exploración, obtén [StateArg1] puntos de locura"
  },
  State_46538_Name = {
    Text = "Presagio de Locura"
  },
  State_47072_Desc = {
    Text = "En esta ronda, la tasa crítica de las cartas de golpe aumenta en +[Layer] %"
  },
  State_47072_Name = {
    Text = "Golpe crítico"
  },
  State_47089_Name = {
    Text = "Efecto de prueba__\"Solo para desarrollo\""
  },
  State_47096_Desc = {
    Text = "Cada vez que juegues una carta de \"Inspiración\", Dafodil obtiene [StateArg1] puntos de locura y [StateArg2] puntos de fuerza, hasta 5 veces por turno. (Quedan [DescArg1] veces)"
  },
  State_47096_Name = {
    Text = "Precipitado de protoplasma"
  },
  State_47189_Name = {
    Text = "Cambiar a Personalidad maníaca. Carne y sangre·Depresión: <EmbryoFusionIconKeywords:Fusión Embrionaria> +[Blood:StateArg5], acumula [StateArg6] puntos de curación del Horno Carmesí"
  },
  State_47192_Name = {
    Text = "Personalidad deprimida: También hace que otros Despertados obtengan [DescArg1] veces de Alienación. Personalidad maníaca: Obtiene [DescArg2] veces adicionales de Alienación"
  },
  State_47199_Name = {
    Text = "Cambiar a la personalidad depresiva. Carne·Manía: el Daño disfruta de [DescArg1]x aumento de <PowerIconKeywords:FUE> y aplica <BleedingIconKeywords:Sangrar> equivalente al 200% del Daño causado al objetivo. Obtiene [StateArg7] puntos de <PowerIconKeywords:FUE>"
  },
  State_47204_Name = {
    Text = "Cambia a la personalidad maníaca. Caos·depresión: gana <Posse:[StateArg1]> puntos de energía-s de llave de plata; la próxima clave se activará 2 veces"
  },
  State_47206_Name = {
    Text = "Cambia a personalidad maníaca. Mar Profundo • Depresivo: <WeaknessIconKeywords:debilidad> y <VulnerabilityIconKeywords:vulnerable> al objetivo durante 2 turnos, genera 1 tentáculo, <TentacleInjurieIconKeywords:daño de tentáculo> + [TentaclePower:StateArg3]"
  },
  State_47209_Name = {
    Text = "Cambiar a Personalidad deprimida. Ultra: Síntoma: Locura: Obtén el 15% del daño infligido como <RetaliateIconKeywords:Contador>, luego inflige una cantidad igual de <FixedDamage:DMG Puro> a los demás enemigos. Por cada carta de \"Inspiración\" jugada este turno, aumenta este daño en [StateArg9] durante el resto del turno, hasta un máximo de [StateArg10]"
  },
  State_47211_Name = {
    Text = "Personalidad deprimida: Reduce en 1 punto el Coste de Aritmética de las [DescArg1] Cartas con mayor Aritmética en la Mano, y obtiene <RetainIconKeywords:Retener> Temporal. Personalidad maníaca: Causa [DescArg2] instancias adicionales de Daño"
  },
  State_47212_Name = {
    Text = "Hace que \"24\" cambie entre personalidades depresivas y maníacas, activando efectos adicionales según el dominio y la personalidad actuales"
  },
  State_47216_Name = {
    Text = "Cambia a personalidad depresiva. Mar profundo • Locura: este daño recibe un aumento del [StateArg4]% de <TentacleInjurieIconKeywords:daño de tentáculos> y causa 30% de <IntoxicationIconKeywords:veneno> a todos los enemigos"
  },
  State_47217_Name = {
    Text = "Cambiar a personalidad depresiva. Caos·Maníaco: Inflige 3 daños, aumentando en [StateArg2] todos los daños causados por \"24\""
  },
  State_47218_Name = {
    Text = "Cambia a personalidad de locura. Supradimensional • Depresivo: añade 2 cartas \"Inspiración\" a tu mano, reduce temporalmente el <PowerIconKeywords:poder> del objetivo en [Power:StateArg8] puntos"
  },
  State_47222_Name = {
    Text = "Personalidad deprimida: Reduce en 1 punto el Coste de Aritmética de las [DescArg1] Cartas con mayor Aritmética en la Mano, y obtiene <RetainIconKeywords:Retener> Temporal. <AwakerCard_24Lost:Personalidad maníaca: Causa [DescArg2] instancias adicionales de Daño>"
  },
  State_47224_Name = {
    Text = "Personalidad deprimida: También hace que otros Despertados obtengan [DescArg1] veces de Alienación. <AwakerCard_24Lost:Personalidad maníaca: Obtiene [DescArg2] veces adicionales de Alienación>"
  },
  State_47228_Name = {
    Text = "<AwakerCard_24Lost:Personalidad deprimida: También hace que otros Despertados obtengan [DescArg1] veces de Alienación.> Personalidad maníaca: Obtiene [DescArg2] veces adicionales de Alienación"
  },
  State_47229_Name = {
    Text = "<AwakerCard_24Lost:Personalidad deprimida: Reduce en 1 punto el Coste de Aritmética de las [DescArg1] Cartas con mayor Aritmética en la Mano, y obtiene Temporal <RetainIconKeywords:Retener>.> Personalidad maníaca: Causa [DescArg2] instancias adicionales de Daño"
  },
  State_47451_Name = {
    Text = "El Posse de Ryker deshabilita los efectos de la Rueda del destino"
  },
  State_47485_Name = {
    Text = "Personalidad deprimida: Reduce en 2 puntos el Coste de Aritmética de las [DescArg1] Cartas con mayor Aritmética en la Mano, y obtiene <RetainIconKeywords:Retener> Temporal. Personalidad maníaca: Causa [DescArg2] instancias adicionales de Daño"
  },
  State_47486_Name = {
    Text = "Personalidad deprimida: Reduce en 2 puntos el Coste de Aritmética de las [DescArg1] Cartas con mayor Aritmética en la Mano, y obtiene <RetainIconKeywords:Retener> Temporal. <AwakerCard_24Lost:Personalidad maníaca: Causa [DescArg2] instancias adicionales de Daño>"
  },
  State_47488_Name = {
    Text = "Personalidad deprimida: Obtiene <Energy: [DescArg1]> puntos adicionales de Alienación. Personalidad maníaca: Obtiene [DescArg2] instancias adicionales de Blindaje"
  },
  State_47489_Name = {
    Text = "<AwakerCard_24Lost:Personalidad deprimida: Reduce en 2 puntos el Coste de Aritmética de las [DescArg1] Cartas con mayor Aritmética en la Mano, y obtiene Temporal <RetainIconKeywords:Retener>.> Personalidad maníaca: Causa [DescArg2] instancias adicionales de Daño"
  },
  State_47492_Name = {
    Text = "Personalidad deprimida: Obtiene <Energy: [DescArg1]> puntos adicionales de Alienación. <AwakerCard_24Lost:Personalidad maníaca: Causa [DescArg2] instancias adicionales de Daño>"
  },
  State_47493_Name = {
    Text = "Personalidad deprimida: Obtiene <Energy: [DescArg1]> puntos adicionales de Alienación. Personalidad maníaca: Causa [DescArg2] instancias adicionales de Daño"
  },
  State_47494_Name = {
    Text = "Personalidad deprimida: También hace que otros Despertados obtengan [DescArg1] veces de Alienación, aplica <WeaknessIconKeywords:Debilidad> a todos los enemigos durante [DescArg3] turnos. Personalidad maníaca: Obtiene [DescArg2] veces adicionales de Alienación, aplica <VulnerabilityIconKeywords:Vulnerable> a todos los enemigos durante [DescArg3] turnos"
  },
  State_47495_Name = {
    Text = "Personalidad deprimida: También hace que otros Despertados obtengan [DescArg1] veces de Alienación, aplica <WeaknessIconKeywords:Debilidad> a todos los enemigos durante [DescArg3] turnos. <AwakerCard_24Lost:Personalidad maníaca: Obtiene [DescArg2] veces adicionales de Alienación, aplica Vulnerable a todos los enemigos durante [DescArg3] turnos>"
  },
  State_47496_Name = {
    Text = "<AwakerCard_24Lost:Personalidad deprimida: También hace que otros Despertados obtengan [DescArg1] veces de Alienación, aplica Debilidad a todos los enemigos durante [DescArg3] turnos.> Personalidad maníaca: Obtiene [DescArg2] veces adicionales de Alienación, aplica <VulnerabilityIconKeywords:Vulnerable> a todos los enemigos durante [DescArg3] turnos"
  },
  State_47498_Name = {
    Text = "<AwakerCard_24Lost:Personalidad deprimida: Obtiene [DescArg1] puntos adicionales de Alienación.> Personalidad maníaca: Causa [DescArg2] instancias adicionales de Daño"
  },
  State_47499_Name = {
    Text = "<AwakerCard_24Lost:Personalidad deprimida: obtén [DescArg1] puntos de Alienación adicionales.>Personalidad maníaca: obtén [DescArg2] Blindajes adicionales"
  },
  State_47500_Name = {
    Text = "Personalidad deprimida: obtén <Energy: [DescArg1] > puntos de Alienación adicionales. <AwakerCard_24Lost:Personalidad maníaca: obtén [DescArg2] Blindajes adicionales>"
  },
  State_47517_Desc = {
    Text = "<PVPWeaponKeywords:wheel of destiny>: Al final del turno, descarta [StateArg1] cartas de otros despertadores. Si el descarte es exitoso, roba [StateArg2] cartas."
  },
  State_47517_Name = {
    Text = "Determinación del Bacalao Plateado"
  },
  State_47518_Name = {
    Text = "Contador de Voluntad del Pez Plateado__\"Dev Only\""
  },
  State_47528_Desc = {
    Text = "Este turno, \"golpear\" inflige +[DescArg1]% de Daño. <PVPPenetrateKeywords:Atravesar>."
  },
  State_47528_Name = {Text = "Afterglow"},
  State_47530_Desc = {
    Text = "Se considera como la última \"habilidad\" usada en este turno"
  },
  State_47530_Name = {
    Text = "<CardKeyWord:Simulación>"
  },
  State_47557_Desc = {
    Text = "Equipo Único: El Portador cambia a la Persona Bacalao Plateado al inicio de la exploración. Alternará entre las Personas Bacalao Plateado y Gato tras usar Exaltar.\nBacalao Plateado: Gana <WeaponEffect_Num:[StateArg1]> Keyflare al infligir Daño Activo. Gato: Gana un aumento de Daño crítico temporal de <WeaponEffect_Num:+[StateArg2]%> al infligir Daño Activo. Estos efectos comparten un máximo de 5 activaciones por turno."
  },
  State_47557_WeaponDesc = {
    Text = "El Portador cambia a la Persona Bacalao Plateado al inicio de la exploración. Alternará entre las Personas Bacalao Plateado y Gato tras usar Exaltar.\nBacalao Plateado: Gana <WeaponEffect_Num:[StateArg1]> Keyflare al infligir Daño Activo. Gato: Gana un aumento de Daño crítico temporal de <WeaponEffect_Num:+[StateArg2]%> al infligir Daño Activo. Estos efectos comparten un máximo de 5 activaciones por turno."
  },
  State_47822_Desc = {
    Text = "Si el siguiente turno vuelve a recibir \"Parálisis\", todos sus \"golpear\" se convierten en \"Espejismo\", no puede ser disipado, y dura hasta el final del siguiente turno."
  },
  State_47822_Name = {
    Text = "Un poco entumecido"
  },
  State_47825_Desc = {
    Text = "Al inicio del turno, se activará el efecto correspondiente de la habilidad."
  },
  State_47825_Name = {
    Text = "<CardKeyWord:Retrasar>"
  },
  State_47826_Desc = {
    Text = "·El Daño se duplica cuando el objetivo está bajo \"Parálisis\", de lo contrario sus \"golpear\" no podrán usarse este turno.\n·Si permanece bajo \"Parálisis\" durante 2 turnos consecutivos, todos sus \"golpear\" se convierten en \"Espejismo\"."
  },
  State_47826_Name = {
    Text = "<WeaknessColour:Parálisis>"
  },
  State_47827_Desc = {
    Text = "Cada capa reduce todo el daño infligido en esta batalla en 1 punto, no se puede dispelir."
  },
  State_47827_Name = {
    Text = "<WeaknessColour: reducción de poder>"
  },
  State_47828_Desc = {
    Text = "Al infligir este estado a un enemigo, causa la misma cantidad de Daño. Si el objetivo ya está \"Entrelazados\", el Daño causado se duplica. \"Entrelazados\" desactiva la Rueda del destino equipada del objetivo hasta el final del turno."
  },
  State_47828_Name = {
    Text = "<WeaknessColour:Enredar>"
  },
  State_47830_Desc = {
    Text = "Al aplicar, disipa el escudo del objetivo y retrasa la curación, reduciendo en un 50% el efecto de curación y escudo antes del final del turno"
  },
  State_47830_Name = {
    Text = "<PVPVulnerabilityIconColour:Herida Grave>"
  },
  State_47831_Desc = {
    Text = "Al desmayarse, el objetivo no puede realizar ninguna acción hasta que termine el turno. Al recibir daño de desmayo, se obtiene Resistencia. Si la Resistencia está activa, el daño de desmayo posterior se duplica pero el efecto de desmayo se anula."
  },
  State_47831_Name = {
    Text = "<ComaColour:Petrificación>"
  },
  State_47832_Desc = {
    Text = "Incluye ratas infectadas, ratas eléctricas, ratas dementes"
  },
  State_47832_Name = {
    Text = "<CardKeyWord:Carta de Rata>"
  },
  State_47833_Desc = {
    Text = "Incluye un pañuelo de paloma blanca, una caja mágica de división inversa y un micrófono de telepatía"
  },
  State_47833_Name = {
    Text = "<CardKeyWord:Magia Asombrosa>"
  },
  State_47841_Desc = {
    Text = "En esta batalla, el uso de la llave [Layer] veces tendrá efecto 2 veces"
  },
  State_47841_Name = {
    Text = "Orden Doble de Llave"
  },
  State_47842_Desc = {
    Text = "Reducir Aliemus y Aliemus Retrasado en un 50%, y eliminar inmediatamente todo Aliemus Retrasado."
  },
  State_47842_Name = {
    Text = "<PVPEmptinessColour:Vacío>"
  },
  State_47843_Desc = {
    Text = "Haz que el despertador escape del estado de muerte y coloca toda su carta en la pila de robo"
  },
  State_47843_Name = {
    Text = "<PVPResurrectionColour:Resurrección>"
  },
  State_47844_Desc = {
    Text = "Genera un efecto desconcertante al azar"
  },
  State_47844_Name = {
    Text = "<PVPWonderfulEffectKeywords:Efecto maravilloso>"
  },
  State_47845_Desc = {
    Text = "Las cartas generan efectos mientras están en la mano"
  },
  State_47845_Name = {
    Text = "<CardKeyWord:Poseer>"
  },
  State_47873_Desc = {
    Text = "Al final del próximo turno, causa daño igual a las capas"
  },
  State_47873_Name = {
    Text = "<PVPVulnerabilityIconColour:sangrando>"
  },
  State_47887_Name = {
    Text = "Efectos variables según el dominio del equipo actual"
  },
  State_47888_Name = {
    Text = "Caro: Por cada punto de Aritmética que \"24\" consume, <EmbryoFusionIconKeywords:Fusión Embrionaria> +[Blood:DescArg1], obtiene [StateArg3] puntos de <PowerIconKeywords:Fortaleza>, y el Exaltar de \"24\" disfruta de un bono adicional de Fortaleza del 300%"
  },
  State_47889_Name = {
    Text = "Aequor: El daño causado por \"24\" disfruta de un bono del [StateArg2]% <TentacleInjurieIconKeywords:daño de tentáculo> y aplica un <IntoxicationIconKeywords:veneno> equivalente al 10% del daño. La explosión de aliemus de \"24\" puede activar un <IntoxicationIconKeywords:veneno> en los enemigos del [StateArg6]%."
  },
  State_47892_Name = {
    Text = "Caos: La Probabilidad de Crítico y el Daño Crítico de \"24\" +[StateArg4]%. Cada vez que se usa una Posse, el Daño Final de Exaltar de \"24\" aumenta un [StateArg1]%"
  },
  State_47894_Name = {
    Text = "Daño causado por «24» disfruta de [StateArg5]% de bonificación de daño <RetaliateIconKeywords: contraataque>, al final del turno se baraja 1 «inspiración» en el montón de descarte, límite de cartas en mano +2"
  },
  State_48009_Desc = {
    Text = "El primer efecto activado en cada turno se activa [StateArg1] veces adicionales"
  },
  State_48009_Name = {
    Text = "<Rune_19:Concierto>"
  },
  State_48010_Desc = {
    Text = "Marca de Ensamble"
  },
  State_48010_Name = {
    Text = "Marca de Ensamble"
  },
  State_48011_Desc = {
    Text = "El primer efecto activado en cada turno se activa [StateArg1] veces adicionales"
  },
  State_48011_Name = {
    Text = "<Rune_19_High:Concierto avanzado>"
  },
  State_48011_WeaponDesc = {
    Text = "Efecto adicional [StateArg1] veces al jugarla, consumir"
  },
  State_48012_Desc = {
    Text = "Hacer que las cartas marcadas tengan efecto 2 veces al jugarse por primera vez en cada turno"
  },
  State_48012_Name = {
    Text = "<CardKeyWord:plegaria: conjunto>"
  },
  State_48013_Desc = {
    Text = "Hacer que las cartas marcadas tengan efecto 3 veces al jugarse por primera vez en cada turno"
  },
  State_48013_Name = {
    Text = "<CardKeyWord:plegaria: conjunto avanzado>"
  },
  State_48019_Name = {
    Text = "<CardKeyWord:Simulación>"
  },
  State_48020_Name = {
    Text = "<CardKeyWord:nacimiento de un alma>"
  },
  State_48021_Name = {
    Text = "<CardKeyWord:Verdadera Forma de la Niebla Gris>"
  },
  State_48078_Name = {
    Text = "<CardKeyWord:Simulación Estelar>"
  },
  State_48099_Desc = {
    Text = "Al final del turno, \"24\" obtiene [DescArg1] de aliemus, y cada vez que \"24\" libera exaltar, el aliemus obtenido aumenta en 1"
  },
  State_48099_Name = {
    Text = "Investigación del comportamiento de Pavlov"
  },
  State_48099_WeaponDesc = {
    Text = "Al final del turno, el portador obtiene 3 puntos de locura. Si la recarga de locura del portador es mayor a 10, obtiene 2 puntos de locura adicionales"
  },
  State_48100_Name = {
    Text = "Estado@24PavlovContador"
  },
  State_48100_WeaponDesc = {
    Text = "Al final del turno, el portador obtiene 3 puntos de locura. Si la recarga de locura del portador es mayor a 10, obtiene 2 puntos de locura adicionales"
  },
  State_48107_Desc = {
    Text = "La primera \"Habilidad\" Jugada por el Portador en cada turno causa +[StateArg1]% Daño."
  },
  State_48107_Name = {
    Text = "Hoja del Gigante"
  },
  State_48108_Desc = {
    Text = "Después de que el portador juega \"habilidad\" por primera vez en cada turno, baraja una copia de su consumo de aritmética - [StateArg1] en el mazo de robos"
  },
  State_48108_Name = {Text = "Gira, Gira"},
  State_48110_Desc = {
    Text = "\"'Habilidad' hace que el próximo 'Golpe' de este turno sea a un objetivo aleatorio y ataque a [StateArg1] objetivos aleatorios adicionales.\""
  },
  State_48110_Name = {
    Text = "El hombre en el espejo"
  },
  State_48140_Desc = {
    Text = "Al comenzar la exploración, \"24\" entra en estado de Personalidad deprimida.\n<School_1:Caos: Depresión>: obtiene <Posse:[StateArg1]> Keyflare; la próxima Posse se activará 2 veces.\n<School_1:Caos: Maníaca>: inflige 3 daños, aumentando en [StateArg2] todos los daños causados por \"24\".\n<School_2:Aequor: Depresión>: inflige <WeaknessIconKeywords:Síntoma: Debilidad> y <VulnerabilityIconKeywords:Vulnerable> al objetivo durante 2 turnos, genera 1 Tentáculo con <TentacleInjurieIconKeywords:Daño de tentáculos> +[StateArg3].\n<School_2:Aequor: Maníaca>: este daño recibe un aumento del [StateArg4]% de <TentacleInjurieIconKeywords:Daño de tentáculos> y causa un 30% de <IntoxicationIconKeywords:Veneno> a todos los enemigos.\n<School_3:Caro: Depresión>: <EmbryoFusionIconKeywords:Fusión Embrionaria> +[Blood:StateArg5], acumula [StateArg6] puntos de recuperación del Horno Carmesí.\n<School_3:Caro: Maníaca>: el daño recibe un aumento de 6× <PowerIconKeywords:STR> y aplica <BleedingIconKeywords:Sangrar> que causa 200% de daño al objetivo, obteniendo [StateArg7] de <PowerIconKeywords:STR>.\n<School_4:Ultra: Depresión>: añade 2 cartas \"Inspiración\" a tu mano, reduce temporalmente el <PowerIconKeywords:STR> del objetivo en [StateArg8].\n<School_4:Ultra: Maníaca>: obtiene <RetaliateIconKeywords:Contador> igual al 15% del daño causado, luego inflige el mismo daño <RealDamage:Daño Fijo> a otros enemigos. Por cada carta \"Inspiración\" jugada en este turno, aumenta ese daño en [StateArg9], hasta un máximo de [StateArg10]."
  },
  State_48140_Name = {
    Text = "Dominio y Efecto de Personalidad"
  },
  State_48141_Desc = {
    Text = "<School_1:Caos>: La Probabilidad de Crítico y el Daño Crítico de \"24\" +[StateArg4]%. Cada vez que se use una Posse, el Daño Final de Exaltar de \"24\" +[StateArg1]%.\n<School_2:Aequor>: El daño causado por \"24\" disfruta de un [StateArg2]% de bonificación en <TentacleInjurieIconKeywords:Daño de tentáculos> y causa un <IntoxicationIconKeywords:Veneno> del 10% de daño. El Exaltar de \"24\" puede activar un <IntoxicationIconKeywords:Veneno> del 50% en los enemigos.\n<School_3:Carne y sangre>: Cada vez que \"24\" consume 1 punto de Aritmética, <EmbryoFusionIconKeywords:Fusión Embrionaria> +[Blood:5], obtiene [StateArg3] puntos de <PowerIconKeywords:fuerza>. Su Exaltar disfruta de una bonificación adicional del 300% de fuerza.\n<School_4:Ultra>: El daño causado por \"24\" disfruta de un [StateArg5]% de bonificación en <RetaliateIconKeywords:Contrataque>, al final del turno se baraja 1 \"Inspiración\" en el Mazo de Descarte, límite de cartas en mano +2."
  },
  State_48141_Name = {
    Text = "Efecto de dominio"
  },
  State_48149_Name = {
    Text = "No activar efectos especiales de la carta boca arriba __ \"Solo para uso de desarrollo\""
  },
  State_48176_Desc = {
    Text = "En esta demostración, obtienes 1 punto de aritmética cada ronda; cada vez que \"24\" consume 1 punto de aritmética, obtienes 30 puntos de energía-s"
  },
  State_48176_Name = {Text = "\"24\" Demo"},
  State_48198_Desc = {
    Text = "En esta prueba, obtén 1 carta de \"Inspiración\" cada turno"
  },
  State_48198_Name = {Text = "\"24\" Demo"},
  State_48199_Desc = {
    Text = "En esta demostración, obtienes 1 punto de aritmética cada ronda"
  },
  State_48199_Name = {Text = "\"24\" Demo"},
  State_48589_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma y el doble de fuerza"
  },
  State_48589_Name = {
    Text = "No Activado"
  },
  State_48607_Name = {
    Text = "Costo de Arithmetica de la carta genérica reducido __ \"Solo para desarrollo\""
  },
  State_48822_Desc = {
    Text = "Al iniciar la ronda del mecanismo del reino de carne, la fusión embrionaria obtenida aumenta en un 50%"
  },
  State_48822_Name = {
    Text = "Vida eterna"
  },
  State_48923_Desc = {
    Text = "¡La sombra “24” ha despertado! ¡Usa el último “sálvame” para encontrar la oportunidad!"
  },
  State_48923_Name = {
    Text = "Sombra \"24\"¡Despertar!"
  },
  State_48923_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_49063_Desc = {
    Text = "El daño de \"golpe\" de Lotan aumenta un 30%"
  },
  State_49063_Name = {
    Text = "Voluntad de lucha elevada"
  },
  State_49109_Desc = {
    Text = "La carta obtiene <RetainIconKeywords:retener>, y si está en la mano al final del turno, se obtiene 1 copia original de esta carta de comando con <DepleteIconKeywords:consumir>."
  },
  State_49109_Name = {
    Text = "<Rune_20_High:Gestación>"
  },
  State_49109_WeaponDesc = {
    Text = "Efecto adicional [StateArg1] veces al jugarla, consumir"
  },
  State_49148_Desc = {
    Text = "Después de morir, añade \"Mutación 1\" a una carta con coste de aritmética distinto de 0. Mutación: estado de la carta, se conserva incluso después de la batalla. Cada capa reduce el coste de aritmética en 1, pero al jugarla, cada capa añadirá 1 carta de mutación aleatoria a tu mano (ignorando el límite de cartas en mano) y elimina todas las mutaciones."
  },
  State_49148_Name = {
    Text = "Feto Deformado"
  },
  State_49149_Desc = {
    Text = "Cada capa reduce en 1 el consumo de aritmética de las cartas. Al jugar, por cada capa de distorsión, se añade una carta de distorsión aleatoria a tu mano y se elimina ese estado. Este estado se conservará al finalizar la batalla"
  },
  State_49149_Name = {
    Text = "<ExclamationPointColour:Distorsión [Layer]>"
  },
  State_49149_WeaponDesc = {
    Text = "Al jugar, se elimina permanentemente"
  },
  State_49207_Name = {
    Text = "Obtener 100 Energía de clave"
  },
  State_49225_Desc = {
    Text = "Después de que termine el turno, un tentáculo ataca [Layer] veces"
  },
  State_49225_Name = {
    Text = "<CardKeyWord:Tentáculos>"
  },
  State_49226_Desc = {
    Text = "Al final del turno, por cada carta en la mano, activa el 3% de <IntoxicationIconKeywords:veneno> en todos los enemigos y obtén 3 puntos de aliemus."
  },
  State_49226_Name = {
    Text = "Luz de vela tenue"
  },
  State_49260_Desc = {
    Text = "Al final del turno, recupera vida equivalente al 7.5% de la constitución"
  },
  State_49260_Name = {
    Text = "Dolor No Aceptado"
  },
  State_49270_Desc = {
    Text = "Daño de cartas de ataque aumentado [Layer] %"
  },
  State_49270_Name = {
    Text = "Daño de cartas de ataque aumentado"
  },
  State_49270_WeaponDesc = {
    Text = "Daño de cartas de ataque aumentado [Layer] %"
  },
  State_49278_Desc = {
    Text = "Al final del turno, recupera el 5% de la vida perdida. Si la vida está por debajo del 50% ([StateArg1]), también obtén [StateArg2] puntos de Fuerza"
  },
  State_49278_Name = {
    Text = "Altar Escarlata"
  },
  State_49430_Desc = {
    Text = "El daño recibido se reduce, cada capa reduce un 1%. Se elimina este estado al morir otros aliados"
  },
  State_49430_Name = {
    Text = "<AberrationColour:ocultar>"
  },
  State_49500_Desc = {
    Text = "Cada capa añade 1 ataque, pierde 1 capa al recibir daño, pierde todas al final del turno"
  },
  State_49500_Name = {Text = "Oración"},
  State_49524_Desc = {
    Text = "Al final del turno, recupera salud equivalente al 5% de la salud perdida. Cada vez que el jugador roba una carta de estado o síntoma, todos los \"nubios\" reciben [StateArg1] puntos de poder temporal"
  },
  State_49524_Name = {
    Text = "Evangelio Sangriento"
  },
  State_49526_Desc = {
    Text = "Después de morir, recupera inmediatamente hasta [StateArg2] puntos de vida y es inmune al daño por 1 turno, ajusta la intención a \"Dispersión de la Corrupción\""
  },
  State_49526_Name = {Text = "Sembrar"},
  State_49542_Desc = {
    Text = "Único del equipo: Al comenzar la batalla, obtiene fuerza igual al <WeaponEffect_Num:[StateArg1]%> del ataque del portador. Si el dominio actual es \"Océano Profundo\", también aumenta el daño de tentáculos en <WeaponEffect_Num:[StateArg2]%> del ataque del portador"
  },
  State_49542_WeaponDesc = {
    Text = "Al comenzar la batalla, obtén <WeaponEffect_Num:[Power:DescArg1]> puntos de fuerza. Si el reino actual es \"Mar Profundo\", también obtén <WeaponEffect_Num:[DescArg2]> puntos de daño de tentáculo."
  },
  State_49546_Desc = {
    Text = "Siempre aparece con 2 guardias élite. Mueren cuando él muere"
  },
  State_49546_Name = {Text = "Formación"},
  State_49547_Desc = {
    Text = "Después de la muerte, el Capitán de la Guardia Aralan obtiene [StateArg1] puntos de poder y un escudo del 50% de la salud máxima"
  },
  State_49547_Name = {Text = "lealtad"},
  State_49558_Desc = {
    Text = "La fuerza aumenta [StateArg1] puntos cada turno"
  },
  State_49558_Name = {
    Text = "Plegaria de arena"
  },
  State_49582_Desc = {
    Text = "En esta batalla, los escudos restantes al final de cada turno no se eliminarán"
  },
  State_49582_Name = {
    Text = "Escudo permanentemente mantenido"
  },
  State_49583_Desc = {
    Text = "Al final del turno, obtén [StateArg1] puntos de escudo, con bonificación de alerta"
  },
  State_49583_Name = {
    Text = "Escudo de Aran"
  },
  State_49595_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_49595_Name = {
    Text = "No Activado"
  },
  State_49596_Desc = {
    Text = "\"Hoja de ilusión\"ya ha despertado, recibirá más escudos y poder"
  },
  State_49596_Name = {
    Text = "¡Elva despierta!"
  },
  State_49596_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_49597_Name = {
    Text = "Este turno ya ha sido aturdido __ \"Para uso de desarrollo solamente\""
  },
  State_49600_Desc = {
    Text = "Debilita a todos los enemigos durante 2 turnos"
  },
  State_49600_Name = {
    Text = "Sangre del miedo"
  },
  State_49601_Desc = {
    Text = "Vulnerable a todos los enemigos por 2 turnos"
  },
  State_49601_Name = {
    Text = "Sangre de descomposición"
  },
  State_49602_Desc = {
    Text = "Vulnerable a todos los enemigos por 1 turno"
  },
  State_49602_Name = {
    Text = "Sangre de descomposición"
  },
  State_49603_Desc = {
    Text = "Fusión Embrionaria +[Blood:DescArg1]."
  },
  State_49603_Name = {
    Text = "Sangre de coito"
  },
  State_49604_Desc = {
    Text = "Fusión Embrionaria +[Blood:DescArg1]."
  },
  State_49604_Name = {
    Text = "Sangre de coito"
  },
  State_49605_Desc = {
    Text = "Debilita a todos los enemigos durante 1 turno"
  },
  State_49605_Name = {
    Text = "Sangre del miedo"
  },
  State_49623_Desc = {
    Text = "La recuperación de vida recibida se reduce en [DescArg1]%. Se elimina 1 capa al final del turno"
  },
  State_49623_Name = {
    Text = "<BaseDamageColour:Herida grave>"
  },
  State_49623_WeaponDesc = {
    Text = "Todo el daño infligido se reduce en [DescArg1] %"
  },
  State_49627_Desc = {
    Text = "Empiezas con 2 capas de <ParcloseIconKeywords:barrera>. Al morir, todos los \"Nubia\" ganan [StateArg1] puntos de fuerza"
  },
  State_49627_Name = {
    Text = "Sangre hirviendo"
  },
  State_49628_Desc = {
    Text = "Al morir, todos los \"Nubia\" obtienen [StateArg1] de fuerza"
  },
  State_49628_Name = {
    Text = "Lazo de sangre"
  },
  State_49638_Desc = {
    Text = "Identificar si es un monstruo de la serie Cabra Negra"
  },
  State_49833_Desc = {
    Text = "Al final del turno, aplica \"Ceguera\" a todos los enemigos por 1 turno. Si tu escudo es destruido, cancela \"Ceguera\""
  },
  State_49833_Name = {
    Text = "Pared de arena y polvo"
  },
  State_49844_Desc = {
    Text = "Equipo Único: Al finalizar el turno, obtén <WeaponEffect_Num:[StateArg1]> puntos de Llave Plateada. Después de activar la Resistencia a la muerte, obtén <WeaponEffect_Num:[StateArg2]> puntos de Llave Plateada. Tras usar el Cuerpo de Gnosis de Emergencia, el Límite de Aritmética aumenta en 3 y el número de cartas robadas por turno aumenta en 3."
  },
  State_49844_WeaponDesc = {
    Text = "Al final del turno, obtén <WeaponEffect_Num:[StateArg1]> puntos de Llave Plateada. Después de activar la Resistencia a la muerte, obtén <WeaponEffect_Num:[StateArg2]> puntos de Llave Plateada. Tras usar el Cuerpo de Gnosis de Emergencia, el Límite de Aritmética aumenta en 3 y el número de cartas robadas por turno aumenta en 3."
  },
  State_49877_Desc = {
    Text = "Disminuye el coste de aritmética de la carta. Al jugarla, por cada 1 capa de distorsión, añade una carta de distorsión aleatoria a la mano y elimina dicho estado. Este estado se mantendrá después de la batalla"
  },
  State_49877_Name = {
    Text = "<AberrationKeywords:Aberración>"
  },
  State_49877_WeaponDesc = {
    Text = "Cada capa de lentitud aumenta el consumo de aritmética de las cartas en 1"
  },
  State_49954_Desc = {
    Text = "El daño crítico de los Despertados se reduce a la mitad"
  },
  State_49954_Name = {
    Text = "<BlindingKeywords: Ceguera>"
  },
  State_49954_WeaponDesc = {
    Text = "Cada capa de lentitud aumenta el consumo de aritmética de las cartas en 1"
  },
  State_49957_Desc = {
    Text = "Al recibir Daño Activo, sella las Cartas de Exaltar y de Comando del Despertado atacante durante 1 turno y elimina 1 Acumulación de <ResentChainsKeywords:Cadena de Rancor>. Se elimina al final del turno."
  },
  State_49957_Name = {
    Text = "<ResentChainsKeywords:Cadenas de rencor>"
  },
  State_49957_WeaponDesc = {
    Text = "Cada capa de lentitud aumenta el consumo de aritmética de las cartas en 1"
  },
  State_49958_Desc = {
    Text = "Al recibir Daño Activo y Daño de tentáculos, sella el Exaltar y las Tarjetas de comando del Despertado atacante durante 1 turno, elimina 1 acumulación de <ResentChainsKeywords:Cadena de Rancor>."
  },
  State_49958_Name = {
    Text = "<ResentChainsKeywords1:Cadena de Rancor>"
  },
  State_49959_Desc = {
    Text = "Al inicio de cada turno, obtén 1 capa de <ResentChainsKeywords:cadenas de resentimiento>"
  },
  State_49959_Name = {
    Text = "Candado multidimensional"
  },
  State_50010_Desc = {
    Text = "La recuperación de vida recibida se reduce en un 25%. Se elimina 1 capa al final del turno"
  },
  State_50010_Name = {
    Text = "<HeavyInjuryKeywords:Herida grave>"
  },
  State_50021_Desc = {
    Text = "Equipo Único: Después de que el Portador use Exaltar, obtiene <WeaponEffect_Num:[StateArg1]%> del ATQ del Portador como <PowerIconKeywords:Fortaleza>. Si el Reino actual es \"Carne y sangre\", después de usar Exaltar, la Fusión Embrionaria <WeaponEffect_Num:+[Blood:StateArg2]> ."
  },
  State_50021_WeaponDesc = {
    Text = "Después de que el Portador use Exaltar, obtiene <WeaponEffect_Num:[Power:DescArg1]> puntos de <PowerIconKeywords:Fortaleza>. Si el Reino actual es \"Carne y sangre\", después de usar Exaltar, la Fusión Embrionaria <WeaponEffect_Num:+[Blood:StateArg2]> ."
  },
  State_50302_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Resiste una muerte y destruye esta \"Rueda del destino\", obtén [StateArg1] <plural value=\"[StateArg1]\" singular=\"capa\" plural=\"capas\"> de <PVPProtectiveKeywords:Barrera>. Si el Portador es el único aliado vivo cuando se activa, obtén [StateArg2] \"Posse\" aleatorias al inicio del siguiente turno."
  },
  State_50302_Name = {
    Text = "Anochecer y Amanecer"
  },
  State_50323_Desc = {
    Text = "Antes del próximo turno, obtén [Layer] comandos de llave aleatorios"
  },
  State_50323_Name = {
    Text = "Llave retardada"
  },
  State_50333_Desc = {
    Text = "Al final del turno, todos los despertadores pierden aliemus."
  },
  State_50333_Name = {
    Text = "<EmptinessKeywords: Vacío>"
  },
  State_50333_WeaponDesc = {
    Text = "Cada capa de lentitud aumenta el consumo de aritmética de las cartas en 1"
  },
  State_50352_Name = {
    Text = "Téïs Demo"
  },
  State_50353_Name = {
    Text = "Téïs Demo"
  },
  State_50358_Desc = {
    Text = "El daño recibido se reduce, cada capa reduce un 1%. Se elimina este estado al morir otros aliados"
  },
  State_50358_Name = {
    Text = "<ConcealmentKeywords:ocultar>"
  },
  State_50375_Desc = {
    Text = "Estos efectos incluyen: 10 puntos de locura para uno mismo, 5 puntos de locura para otros aliados, aplicar 1 capa de vulnerabilidad a todos los enemigos, aplicar 1 capa de debilidad a todos los enemigos, robar 1 carta, obtener 200 puntos de energía-s"
  },
  State_50375_Name = {
    Text = "<MysterybuffKeywords:Efecto positivo misterioso>"
  },
  State_50389_Desc = {
    Text = "Al comienzo del turno, añade un \"dado de la suerte de Ryker\" a tu mano"
  },
  State_50389_Name = {
    Text = "Soporte de Lek"
  },
  State_50390_Desc = {
    Text = "Al inicio del turno, obtiene [StateArg1] de fuerza"
  },
  State_50390_Name = {
    Text = "Veterano destacado"
  },
  State_50491_Name = {
    Text = "Péndulo temporal \"Equilibrio\""
  },
  State_50735_Desc = {
    Text = "Al estar a punto de ser derrotado por primera vez, recupera vida y cambia la intención a \"Lamento desgarrador\", infligiendo un daño único extremadamente alto."
  },
  State_50735_Name = {
    Text = "Resiliencia Inútil"
  },
  State_50854_Desc = {
    Text = "Al comenzar la batalla, recibe [StateArg1] puntos <RetaliateIconKeywords:contraataque>. Al final del turno, recibe [StateArg2] puntos de escudo, y cada turno este escudo aumenta [StateArg3]"
  },
  State_50854_Name = {
    Text = "Corteza resistente"
  },
  State_50861_Desc = {
    Text = "Sin más daño, preparando la liberación de la \"Madre de mil descendientes\"."
  },
  State_50861_Name = {Text = "Derivada"},
  State_50862_Desc = {
    Text = "Sin más daño, preparando la liberación de la \"Procreación\""
  },
  State_50862_Name = {
    Text = "Incubación"
  },
  State_50863_Desc = {
    Text = "Sin más daño, preparando la liberación de la \"Savia Salvaje\""
  },
  State_50863_Name = {Text = "Inmunidad"},
  State_50864_Desc = {
    Text = "Sin más daño, preparando la liberación de la \"Savia\""
  },
  State_50864_Name = {Text = "Inmunidad"},
  State_50891_Desc = {
    Text = "Sin más daño, preparando la liberación de la \"Fusión Múltiple\""
  },
  State_50891_Name = {Text = "Devorar"},
  State_51016_Desc = {
    Text = "El efecto de veneno recibido aumenta al 1000%"
  },
  State_51016_Name = {
    Text = "Madera marchita y podrida"
  },
  State_51017_Desc = {
    Text = "El efecto de veneno recibido aumenta al 500%"
  },
  State_51017_Name = {
    Text = "Madera marchita y podrida"
  },
  State_51607_Desc = {
    Text = "Inmunidad a todo daño, se elimina al inicio del turno"
  },
  State_51607_Name = {
    Text = "Inmunidad al daño"
  },
  State_51695_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_51695_Name = {
    Text = "No Activado"
  },
  State_51696_Desc = {
    Text = "\"El apóstol del mar\"ya ha despertado, ella tiene una defensa más fuerte contra el estallido de locura"
  },
  State_51696_Name = {
    Text = "¡Miriam Despertar!"
  },
  State_51696_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_51739_Desc = {
    Text = "Al final del turno, obtén al azar 1 carta de \"fantasma del Reino de Dios\", que no puede disiparse."
  },
  State_51739_Name = {
    Text = "El fin de la creencia"
  },
  State_51740_Desc = {
    Text = "Al comienzo de la batalla, se coloca 1 carta de \"delirio\" en la mano"
  },
  State_51740_Name = {
    Text = "Piedad Inextinguible"
  },
  State_51741_Desc = {
    Text = "Al inicio del turno, obtén [Layer] puntos de escudo que no se pueden disipar."
  },
  State_51741_Name = {
    Text = "Resolución de hierro"
  },
  State_51742_Desc = {
    Text = "Al inicio del turno, obtén [Layer] puntos de daño de tentáculo y de fuerza. No se puede disipar."
  },
  State_51742_Name = {
    Text = "Revelar la devoción"
  },
  State_51743_Desc = {
    Text = "En este turno, por cada ataque de tentáculo, obtén los siguientes efectos según la postura de tentáculo: Mareas crecientes: todos los despertados obtienen <Energy:[Energy:StateArg1]> puntos de alienación; Mar tranquilo: causa [StateArg2] puntos de <IntoxicationIconKeywords:veneno> a todos los enemigos; Olas furiosas: <TentacleInjurieIconKeywords:daño de tentáculo> temporal +[StateArg3]."
  },
  State_51743_Name = {
    Text = "Bendición de la Madre Diosa"
  },
  State_51745_Desc = {
    Text = "Cuando el Apóstol del mar juega 1 carta, genera [StateArg1] tentáculos temporales, que pueden ignorar el límite de tentáculos"
  },
  State_51745_Name = {
    Text = "Poder delegado"
  },
  State_51745_WeaponDesc = {
    Text = "Cuando el Apóstol del mar juega 1 carta, genera [StateArg1] tentáculos temporales, que pueden ignorar el límite de tentáculos"
  },
  State_51811_Name = {
    Text = "Efecto de Curación de la Vela Guía"
  },
  State_51813_Desc = {
    Text = "Después de terminar el turno, el costo de aritmética disminuye en [Layer]; el efecto también se activa si se descarta"
  },
  State_51813_Name = {
    Text = "<PrepareKeypvewordscolour:preparar[Layer]>"
  },
  State_51820_Desc = {
    Text = "\"Gestación\" obtiene efecto adicional: Al tener 5 capas, invoca inmediatamente a un \"Hijo del Agua\", con un máximo de 2 \"Hijos del Agua\""
  },
  State_51820_Name = {
    Text = "Miriam Despertar"
  },
  State_51822_Desc = {
    Text = "Cada vez que se libera una explosión de locura, aumenta 1 capa de \"Gestación\"; cada capa de gestación otorga [StateArg1] puntos de poder, con un límite de 5 capas"
  },
  State_51822_Name = {
    Text = "La Descendencia Final de Lemuria"
  },
  State_52068_Desc = {
    Text = "Convierte hasta 3 cartas de \"Rito Sagrado\" en \"Obstinación\" y obtén efectos adicionales según la cantidad convertida"
  },
  State_52068_Name = {
    Text = "<CardKeyWord:Ritual>"
  },
  State_52087_Desc = {
    Text = "\"Ave Fénix\" puede aplicar el estado de resurrección nuevamente después de [Layer] turnos"
  },
  State_52087_Name = {
    Text = "Tiempo de enfriamiento de resurrección"
  },
  State_52116_Desc = {
    Text = "Antes del final de la ronda, este despertador recibe daño de [Layer] después de usar exalt."
  },
  State_52116_Name = {
    Text = "Bloqueo de Exaltación"
  },
  State_52369_Desc = {
    Text = "Después de jugar [DescArg1] cartas de síntoma, obtén la carta de apoyo de Tulu \"Rey\": causa gran daño y aturde al objetivo durante 1 turno"
  },
  State_52369_Name = {
    Text = "El Reino Divino seguramente volverá"
  },
  State_53115_Desc = {
    Text = "Este turno, el próximo efecto de \"Ritual\" de Miriam aumenta un 50%"
  },
  State_53115_Name = {
    Text = "Orar al abismo"
  },
  State_53144_Desc = {
    Text = "Al inicio de cada turno, obtén <Block:[Block:StateArg1]> puntos de escudo"
  },
  State_53144_Name = {
    Text = "<CardKeyWord:Autocontrol>"
  },
  State_53145_Desc = {
    Text = "Cada turno, <PowerIconKeywords:fuerza> y <TentacleInjurieIconKeywords:daño de tentáculo> +[StateArg2]"
  },
  State_53145_Name = {
    Text = "<CardKeyWord:Revelar la devoción>"
  },
  State_53673_Desc = {
    Text = "La división glandular puede tener hasta 10 cartas"
  },
  State_53673_Name = {
    Text = "Límite de División de Glándulas"
  },
  State_53674_Desc = {
    Text = "Límite de cartas en mano +2. Al inicio del turno, Miriam obtiene 20 puntos de locura"
  },
  State_53674_Name = {
    Text = "Miriam Playtest"
  },
  State_53755_Desc = {
    Text = "El <PowerIconKeywords:poder>, <RetaliateIconKeywords:mostrador>, y <IntoxicationIconKeywords:veneno> aplicados por todos los despertadores aumentan en [DescArg1]%. Se incrementa el <PowerIconKeywords:poder> aplicado por \"Capítulo de Luces\""
  },
  State_53755_Name = {
    Text = "Poema misterioso: miedo"
  },
  State_53756_Desc = {
    Text = "La locura causada por todos los despertadores aumenta en [DescArg1]%, al final del turno, la aritmética y las cartas de comando pueden conservarse para el siguiente turno. La locura causada por \"Canto de Esplendor\" aumenta"
  },
  State_53756_Name = {
    Text = "Poema Fantasmal · Alegría"
  },
  State_53758_Desc = {
    Text = "El daño final causado por todos los despertadores aumenta en [DescArg1]%, la tasa crítica y el daño crítico aumentados por \"Canto de Esplendor\""
  },
  State_53758_Name = {
    Text = "Poema de Fantasía·Ira"
  },
  State_53759_Desc = {
    Text = "Todos los Despertados causan efectos de escudos y recuperación, y aplican <PowerIconKeywords:fuerza> reducidos en [DescArg1]%. El capítulo de Fragmentos aumenta la recuperación"
  },
  State_53759_Name = {
    Text = "Poema de luto: Lamento"
  },
  State_53772_Name = {
    Text = "Paradoja de accesorios"
  },
  State_53772_WeaponDesc = {
    Text = "Después de que el portador use exaltar, la parte aliada obtiene un <RetaliateIconKeywords:contraataque> basado en el 100% de la defensa del portador. Además, su <RetaliateIconKeywords:contraataque> actual aumenta en un 10%"
  },
  State_53870_Name = {
    Text = "Anillo de la sala 36 de accesorios"
  },
  State_53870_WeaponDesc = {
    Text = "Al obtener cartas del portador, su aritmética cambiará aleatoriamente entre 0-3"
  },
  State_53981_Name = {
    Text = "Corrección del sigilo negro en el sueño de los adornos"
  },
  State_53981_WeaponDesc = {
    Text = "Después de que comience la batalla, se mezclarán cartas de equipo en la pila de robo"
  },
  State_54002_Name = {
    Text = "Estado@Accesorio Sueño de Medicina Marca de Selección"
  },
  State_54002_WeaponDesc = {
    Text = "Después de que el portador use exaltar, la parte aliada obtiene un <RetaliateIconKeywords:contraataque> basado en el 100% de la defensa del portador. Además, su <RetaliateIconKeywords:contraataque> actual aumenta en un 10%"
  },
  State_54011_Name = {
    Text = "Estado@Accesorio Sueño de Medicina Copia 1 Disponible"
  },
  State_54011_WeaponDesc = {
    Text = "Después de que el portador use exaltar, la parte aliada obtiene un <RetaliateIconKeywords:contraataque> basado en el 100% de la defensa del portador. Además, su <RetaliateIconKeywords:contraataque> actual aumenta en un 10%"
  },
  State_54012_Name = {
    Text = "Estado@Accesorio Sueño de Medicina Copia 2 Disponible"
  },
  State_54012_WeaponDesc = {
    Text = "Después de que el portador use exaltar, la parte aliada obtiene un <RetaliateIconKeywords:contraataque> basado en el 100% de la defensa del portador. Además, su <RetaliateIconKeywords:contraataque> actual aumenta en un 10%"
  },
  State_54013_Desc = {
    Text = "Este turno, la maestría de dominio aumenta [Layer]"
  },
  State_54013_Name = {
    Text = "Maestría temporal de dominio"
  },
  State_54014_Desc = {
    Text = "Maestría en dominios aumenta en [Layer] puntos"
  },
  State_54014_Name = {
    Text = "Maestría del Reino"
  },
  State_54043_WeaponDesc = {
    Text = "Después de que el portador use exaltar, sus escudos y curas en este turno se duplican"
  },
  State_54044_Desc = {
    Text = "Inflige el doble de Daño y además gana un 600% de Keyflare igual a la Regeneración de Llave Plateada de Ramona: Bucle, pero <DepleteIconKeywords:se Agota> tras jugarla."
  },
  State_54044_Name = {
    Text = "Oda al mañana"
  },
  State_54045_Desc = {
    Text = "Obtén 3 puntos de aritmética"
  },
  State_54045_Name = {
    Text = "Tribunal del Renacimiento"
  },
  State_54046_Desc = {
    Text = "Al inicio del turno, recupera [StateArg1] de vida durante [Layer] turnos"
  },
  State_54046_Name = {
    Text = "Racionalidad, verdad y realidad"
  },
  State_54071_Desc = {
    Text = "El conteo de Daño Activo de Ogier +1, durante [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_54071_Name = {
    Text = "Siete Artes, Ocho Virtudes"
  },
  State_54121_Desc = {
    Text = "En esta Batalla, el Daño básico infligido por la 'Bestia del caos' se incrementa en un [Layer]%."
  },
  State_54121_Name = {
    Text = "Bestia del Caos"
  },
  State_54138_Desc = {
    Text = "Sorel activa la carta de comando jugada 2 veces en [Layer]"
  },
  State_54138_Name = {
    Text = "Carrusel de la ambición"
  },
  State_54384_Desc = {
    Text = "Aumenta el <IntoxicationIconKeywords:veneno> causado por Nymphaea en 50%, durando [Layer] turnos"
  },
  State_54384_Name = {
    Text = "El paso del ego"
  },
  State_54416_Desc = {
    Text = "Una vez desbloqueada la Furia explosiva sobrecargada, el indicador de Aliemus puede llenarse dos veces. Al alcanzar una segunda carga completa, se mejora la habilidad a Furia explosiva sobrecargada, añadiendo poderosos efectos adicionales. Si se libera un Exaltar normal, se consumirá un 50% del Aliemus sobrante."
  },
  State_54416_Name = {
    Text = "<OverLimitUtlSkillKeywords:sobreexaltación>"
  },
  State_54416_WeaponDesc = {
    Text = "Consume el embrión en la mano, provocando un poderoso efecto devorador"
  },
  State_54561_Desc = {
    Text = "El único del equipo: el aumento del daño causado por el portador se incrementa en <WeaponEffect_Num:[StateArg1]%> de su poder de ataque. Si el dominio actual es \"caro\", cada vez que activa el efecto devorador, el aumento del daño causado por el portador incrementa en un 3% de su poder de ataque"
  },
  State_54561_WeaponDesc = {
    Text = "El daño causado por el portador aumenta [DescArg1] puntos. Si el dominio actual es \"Carne\", cada vez que se activa el efecto Devorar, el daño causado por el portador aumenta [DescArg2] puntos adicionales."
  },
  State_54568_Name = {
    Text = "hasta el final del planeta"
  },
  State_54597_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Después de la muerte de un Cuerpo Despertado enemigo, obtén [StateArg1] <StrongEffectKeywords:Amplificación>, y coloca en tu mano la \"Habilidad\" con el mayor Coste de Aritmética con <PVPVoidKeywords:Oblivion>."
  },
  State_54597_Name = {
    Text = "La Mirada Favorecida por Millones"
  },
  State_54704_Desc = {
    Text = "La próxima carta de comando de \"24\" se activa 3 veces"
  },
  State_54704_Name = {
    Text = "Revelación de carroña retorcida"
  },
  State_54798_Desc = {
    Text = "Todos los efectos de escudo, sanación y reducción de fuerza de los alumnos se incrementan en [StateArg1]%, y los efectos de sanación de los capítulos resplandecientes se incrementan."
  },
  State_54798_Name = {Text = "\"Ai\""},
  State_54799_Desc = {
    Text = "Todos los efectos de contraataque, veneno y adquisición de fuerza de los alumnos se incrementan en [StateArg1]%. La fuerza de los capítulos resplandecientes se incrementa."
  },
  State_54799_Name = {Text = "Miedo"},
  State_54800_Desc = {
    Text = "El daño final causado por todos los Despertados aumenta en [StateArg1]%, la tasa crítica y el daño crítico del Capítulo resplandeciente aumentan."
  },
  State_54800_Name = {Text = "\"Ira\""},
  State_55108_Desc = {
    Text = "Al inicio del turno, mejora \"Llama Verde\" o \"Llama Verde Corrupta\" en tu mano a \"Llama Verde Mortal\" por [Layer] turnos"
  },
  State_55108_Name = {
    Text = "Señal de muerte aparece"
  },
  State_55108_WeaponDesc = {
    Text = "Al comienzo del turno, si está en la mano o en el espacio ultra, se obtiene un fortalecimiento"
  },
  State_55113_Desc = {
    Text = "Cada vez que Horla juega la primera página de un poema, obtiene 10 puntos de aliemus"
  },
  State_55113_Name = {
    Text = "Reencuentro de Flor y Poema"
  },
  State_55465_Name = {
    Text = "Consumir [Layer] capas de Metáfora \"Ira\", causar [DescArg1] daño adicional"
  },
  State_55466_Name = {
    Text = "Consumir [Layer] capas de Metáfora \"Tristeza\", recuperar <Heal:[Heal:DescArg1]> de vida"
  },
  State_55467_Name = {
    Text = "Consumir [Layer] capas de Metáfora \"Miedo\", obtener [Power:DescArg1] de <PowerIconKeywords:Fuerza> adicional"
  },
  State_55469_Name = {
    Text = "Consumir [Layer] capas de Metáfora \"Alegría\", obtener <Energy:[Energy:DescArg1]> de Locura adicional"
  },
  State_55470_Name = {
    Text = "Devastador de calaveras"
  },
  State_55485_Desc = {
    Text = "Las próximas [Layer] cartas que Casiah juegue obtienen FUE igual al 10% de su ATQ."
  },
  State_55485_Name = {
    Text = "Ríe a gusto"
  },
  State_55486_Name = {
    Text = "La explosión por encima del límite de la Ciudad de los Sueños Muertos anula el costo de sueño"
  },
  State_55487_Desc = {
    Text = "El \"Golpe\" de Erika causa 2 puntos de daño adicionales, la \"DEF\" obtiene 2 puntos de escudo adicionales, durando [Layer] rondas"
  },
  State_55487_Name = {
    Text = "Cálculo múltiple"
  },
  State_55489_Name = {
    Text = "Salto espacio-tiempo"
  },
  State_55806_Name = {
    Text = "<PoetryKeywords:Ofrenda a los dioses>: Da a todos los enemigos un <PVPWonderfulEffectKeywords:Efecto Maravilloso> negativo o da a todos los aliados un <PVPWonderfulEffectKeywords:Efecto Maravilloso> positivo o roba 1 carta y gana 1 Aritmética. La última Ofrenda a los dioses surte efecto 2 veces"
  },
  State_55807_Name = {
    Text = "Robar 1 carta, obtén 1 punto de aritmética"
  },
  State_55808_Name = {
    Text = "<PoetryKeywords:offering>: Concede a todos los aliados un <PVPWonderfulEffectKeywords:efecto maravilloso> positivo o roba 1 carta y gana 1 aritmética. La última ofrenda tiene efecto 2 veces"
  },
  State_55809_Name = {
    Text = "Otorgar a todos los enemigos efectos negativos <PVPWonderfulEffectKeywords:maravillosos>"
  },
  State_55811_Desc = {
    Text = "Elige una opción de las listadas para que surta efecto"
  },
  State_55811_Name = {
    Text = "<ComaColour:Decisión>"
  },
  State_55813_Name = {
    Text = "<PoetryKeywords:offering>: Concede a todos los enemigos un <PVPWonderfulEffectKeywords:efecto maravilloso> negativo o roba 1 carta y gana 1 aritmética. La última ofrenda tiene efecto 2 veces"
  },
  State_55814_Name = {
    Text = "<PoetryKeywords:offering>: Concede a todos los enemigos un <PVPWonderfulEffectKeywords:efecto maravilloso> negativo o concede a todos los aliados un <PVPWonderfulEffectKeywords:efecto maravilloso> positivo. La última ofrenda tiene efecto 2 veces"
  },
  State_55816_Name = {
    Text = "Otorgar a todos los aliados efectos positivos <PVPWonderfulEffectKeywords:maravillosos>"
  },
  State_55824_Desc = {
    Text = "Elige una opción de las listadas para que surta efecto, luego elimina la opción elegida. Si quedan opciones, coloca esta carta en la mano del oponente"
  },
  State_55824_Name = {
    Text = "<ComaColour:Ofrenda>"
  },
  State_55836_Desc = {
    Text = "Al final del turno, el coste de potencia de las cartas de mando de horla en la mano se reduce en -1"
  },
  State_55836_Name = {
    Text = "Tinta Poética"
  },
  State_55839_Desc = {
    Text = "Al recoger, se pierden todas las otras reliquias y se obtienen aleatoriamente 2 reliquias de oro"
  },
  State_55866_Desc = {
    Text = "Equipo único: Al inicio de la batalla, roba 1 carta de comando del portador y con <WeaponEffect_Num:[StateArg1]％> de probabilidad, reduce el agotamiento de su aritmética en 1. Cada vez que se activa la resistencia a la muerte, este efecto se activa nuevamente una vez"
  },
  State_55866_WeaponDesc = {
    Text = "Al comienzo de la batalla, roba 1 carta de comando del portador y con <WeaponEffect_Num:[StateArg1]%> de probabilidad, reduce el costo de aritmética en 1. Cada vez que se activa la resistencia a la muerte, este efecto se activa nuevamente una vez."
  },
  State_55992_Desc = {
    Text = "Cuando la aritmética es insuficiente, se aplican agotamiento y marcas a la carta"
  },
  State_55992_Name = {Text = "Ceniza"},
  State_55993_Name = {
    Text = "Marca de ceniza"
  },
  State_56018_Desc = {
    Text = "En esta batalla, la salud máxima aumenta en un [Layer] %"
  },
  State_56018_Name = {
    Text = "La bendición de la musa - Destino"
  },
  State_56020_Desc = {
    Text = "Daño aumentado en [Layer]% en esta batalla"
  },
  State_56020_Name = {
    Text = "La bendición de la musa - Fuerza"
  },
  State_56030_Desc = {
    Text = "En esta ronda, los escudos y curaciones causados por el despertador aumentan un [Layer] %"
  },
  State_56030_Name = {Text = "Nieve"},
  State_56031_Desc = {
    Text = "En esta ronda, después de causar 1 daño, la tasa crítica temporal aumenta en +[Layer] %"
  },
  State_56031_Name = {Text = "Mariposa"},
  State_56034_Desc = {
    Text = "Cada tipo de \"metáfora\" puede tener un máximo de 3 capas. Diferentes \"metáforas\" amplifican diferentes efectos de los poemas: \n<D06CardKeyWordnu:Salmo Gruñido>: Consume todas las metáforas \"Ira\", causando 2 veces más daño por cada capa de metáfora. \n<D06CardKeyWordai:Salmo elegía>: Consume todas las metáforas \"Ai\", recuperando vida adicional por cada capa de metáfora. \n<D06CardKeyWordxi:Salmo villancico>: Consume todas las metáforas \"Alegría\", obteniendo 10 puntos adicionales de alienación por cada capa de metáfora. \n<D06CardKeyWordju:Salmo fúnebre>: Consume todas las metáforas \"Miedo\", obteniendo <PowerIconKeywords:Fuerza> adicional por cada capa de metáfora."
  },
  State_56034_Name = {Text = "Metáfora"},
  State_56208_Desc = {
    Text = "El canto fúnebre de la lluvia: Recupera <Heal:[DescArg1]> PV.\nSalmo del viento: Obtén [DescArg2] de <PowerIconKeywords:Fortaleza>.\nHimno floral: Otorga a todos los Despertados <Energy:10> de Aliemus.\nHimno de la luna: Probabilidad de Crítico +30% este turno."
  },
  State_56208_Name = {
    Text = "Página de poema"
  },
  State_56330_Desc = {
    Text = "Obtén [DescArg1] puntos de escudo. Si has realizado 3 explosiones de aliemus en este turno, esta carta tiene efecto adicional 1 vez"
  },
  State_56330_Name = {
    Text = "Imágenes avanzadas"
  },
  State_56331_Desc = {
    Text = "Elige 1 carta de comando de la pila de robar y la pila de descarte para añadir a tu mano, y reduce su coste de aritmética en -2"
  },
  State_56331_Name = {
    Text = "Imágenes avanzadas"
  },
  State_56332_Desc = {
    Text = "Obtén [DescArg1] puntos temporales<PowerIconKeywords:poder>. Al jugar, cada vez que causes daño, la tasa crítica temporal aumenta en +3%"
  },
  State_56332_Name = {
    Text = "Imágenes avanzadas"
  },
  State_56333_Desc = {
    Text = "Recupera el 10% de la vida perdida. Si la vida actual es inferior al 25%, esta carta tiene efecto 1 vez adicional."
  },
  State_56333_Name = {
    Text = "Imágenes avanzadas"
  },
  State_56334_Desc = {
    Text = "El próximo comando de llave se activará 2 veces"
  },
  State_56334_Name = {
    Text = "Imágenes avanzadas"
  },
  State_56335_Desc = {
    Text = "Inflige <FixedDamage:DMG Puro> igual al 150% del PV Max, que disfruta de un bonus de <PowerIconKeywords:STR> de 10×."
  },
  State_56335_Name = {
    Text = "Imágenes avanzadas"
  },
  State_56336_Desc = {
    Text = "Roba 5 cartas"
  },
  State_56336_Name = {
    Text = "Imágenes avanzadas"
  },
  State_56337_Desc = {
    Text = "Obtén [DescArg1] puntos temporales de <AlertIconKeywords:alerta>. Al jugarla, aumenta el escudo y la curación de este turno en [DescArg2]%"
  },
  State_56337_Name = {
    Text = "Imágenes avanzadas"
  },
  State_56338_Desc = {
    Text = "Obtén 3 puntos de aritmética"
  },
  State_56338_Name = {
    Text = "Imágenes avanzadas"
  },
  State_56339_Desc = {
    Text = "Dispersar 1 estado negativo al azar. Esta carta se activa 3 veces más, consume"
  },
  State_56339_Name = {
    Text = "Imágenes avanzadas"
  },
  State_56340_Desc = {
    Text = "Aplica <VulnerabilityIconKeywords:vulnerable> por 3 turnos a todos los enemigos. Cada vez que muera un enemigo, coloca esta carta en tu mano desde el mazo"
  },
  State_56340_Name = {
    Text = "Imágenes avanzadas"
  },
  State_56341_Desc = {
    Text = "Maestría en dominios +25 puntos, maestría temporal en dominios +125 puntos"
  },
  State_56341_Name = {
    Text = "Imágenes avanzadas"
  },
  State_56342_Desc = {
    Text = "Todos los Despertados obtienen 15 puntos de Locura"
  },
  State_56342_Name = {
    Text = "Imágenes avanzadas"
  },
  State_56343_Desc = {
    Text = "Aplica <WeaknessIconKeywords:debilidad> por 3 turnos a todos los enemigos, coloca 1 copia de esta carta en el montón de descarte, y agrega <DepleteIconKeywords:agotamiento>, <NothingnessIconKeywords:ilusión>"
  },
  State_56343_Name = {
    Text = "Imágenes avanzadas"
  },
  State_56372_Desc = {
    Text = "Al morir, elimina el último estado negativo obtenido por el jugador"
  },
  State_56372_Name = {
    Text = "Flor y poema"
  },
  State_56400_Desc = {
    Text = "Después de \"Golpear\", las Habilidades de este Despertado en tu mano se transforman secuencialmente en otras Habilidades: [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_56400_Name = {
    Text = "Flores y poemas del pasado"
  },
  State_56402_Desc = {
    Text = "Poseer metáfora <D06CardKeyWordnu:\"Ira\"> [DescArg2] capas: cuando se activa el impulso del \"Salmo Gruñido\", causará daño adicional. \n Poseer metáfora <D06CardKeyWordai:\"Ai\"> [DescArg3] capas: cuando se activa el impulso del \"Salmo elegía\", recuperará vida adicional. \n Poseer metáfora <D06CardKeyWordxi:\"Alegría\"> [DescArg1] capas: cuando se activa el impulso del \"Salmo villancico\", otorgará locura adicional al Despertado. \n Poseer metáfora <D06CardKeyWordju:\"Miedo\"> [DescArg4] capas: cuando se activa el impulso del \"Salmo fúnebre\", obtendrá fuerza adicional."
  },
  State_56402_Name = {Text = "Metáfora"},
  State_57166_Desc = {
    Text = "El daño del Despertar aumenta un 25%"
  },
  State_57170_Desc = {
    Text = "Límite de cartas en mano +2, al final del turno seleccionas 1 carta en mano para conservar y reduces su consumo de aritmética en -1, durante 3 turnos"
  },
  State_57170_Name = {
    Text = "Luz Errante"
  },
  State_57316_Desc = {
    Text = "Al comienzo de cada turno, transforma 1 carta \"Embrión\" en \"Vástago de la Pureza\"; si no hay \"Embrión\", <EmbryoFusionIconKeywords:Fusión Embrionaria> +[Blood:DescArg1], sin verse afectado por el Efecto de mejora de Fusión Embrionaria. Sostenido [Layer] turnos."
  },
  State_57316_Name = {
    Text = "Legado de los restos sagrados eternos"
  },
  State_57317_Desc = {
    Text = "Cuando esta rueda del destino está en el mazo, podrás ver los cambios que se avecinan en las habilidades en tu mano."
  },
  State_57317_Name = {
    Text = "<PVPFlowerKeywords:Flores y poemas del pasado>"
  },
  State_57324_Desc = {
    Text = "Si este avatar activa \"Flores y Poemas del Pasado\", esta carta se transformará en <CardKeyWord:<SkillName1:>>"
  },
  State_57324_Name = {
    Text = "Flores y poemas del pasado"
  },
  State_57325_Desc = {
    Text = "Si este avatar activa \"Flores y Poemas del Pasado\", esta carta se transformará en <CardKeyWord:<SkillName2:>>"
  },
  State_57325_Name = {
    Text = "Flores y poemas del pasado"
  },
  State_57326_Desc = {
    Text = "Si este avatar activa \"Flores y Poemas del Pasado\", esta carta se transformará en <CardKeyWord:<SkillName3:>>"
  },
  State_57326_Name = {
    Text = "Flores y poemas del pasado"
  },
  State_57335_Name = {
    Text = "El daño de esta carta disfruta de un aumento de poder de [DescArg1] veces"
  },
  State_57356_Name = {
    Text = "Estado@hundidor contraataque cálculo"
  },
  State_57368_Name = {
    Text = "Estado@hundidor contraataque plataforma"
  },
  State_57413_Name = {
    Text = "Cada punto de escudo aumenta el daño de esta carta en [DescArg1] puntos"
  },
  State_57417_Desc = {
    Text = "Cada vez que se activa la resistencia a la muerte, causa un daño fijo de contraataque del 100%; en esta batalla, cada vez que se active la resistencia a la muerte, el daño fijo aumentará un 25%."
  },
  State_57417_Name = {
    Text = "Cuna de amor"
  },
  State_57566_Name = {
    Text = "Sobreviviendo al impasse"
  },
  State_57587_Desc = {
    Text = "Al jugar \"División de glándulas\", roba 1 carta, [Layer] veces restantes"
  },
  State_57587_Name = {
    Text = "¡Medusas, reuníos!"
  },
  State_57665_Name = {
    Text = "Protección de la madre divina"
  },
  State_57728_Desc = {
    Text = "El número de ataques de uvhash aumenta en 1"
  },
  State_57728_Name = {
    Text = "Regalo de la Blood Surge"
  },
  State_57751_Desc = {
    Text = "Equipo Único: El escudo infligido por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Tras liberar la llave, todos los Despertados obtienen <WeaponEffect_Num:[StateArg2]%> de Tasa de Crítico Temporal y Daño Crítico, pero se añade un Ritual de sacrificio del 3% de la PV Max. Si el reino actual es \"Aequor\", tras liberar la llave, el Daño de tentáculos también aumenta en <WeaponEffect_Num:[StateArg3]%> del ATQ del portador."
  },
  State_57751_WeaponDesc = {
    Text = "El escudo causado por el portador aumenta en <WeaponEffect_Num:[StateArg1]%.> Tras liberar la llave, todos los despertados obtienen <WeaponEffect_Num:[StateArg2]%> de tasa crítica temporal y daño crítico, pero se añade [DescArg1] puntos de ritual de sacrificio. Si el reino actual es \"Aequor\", tras liberar la llave, también aumentará el daño de tentáculos en [DescArg2] puntos."
  },
  State_57753_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Obtén [StateArg1] capas de <PVPSleepKeywords:Siesta de calidad> al equipar."
  },
  State_57753_Name = {
    Text = "Letargo Bajo el Glaciar"
  },
  State_57766_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Después del primer \"Exaltar\" en cada turno, gana <StrongEffectKeywords:Amplificación> temporal +[StateArg1]."
  },
  State_57766_Name = {
    Text = "Bastón del Pastor"
  },
  State_57767_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Al final del turno, resta <Energy:[Energy:StateArg1]> Locura para convertirla en <PVPDerivativeCardKeywords_12:\"Pequeño Deseo\">. Si la conversión falla, obtén <Energy:[Energy:StateArg2]> Locura."
  },
  State_57767_Name = {
    Text = "Presentación que nunca para"
  },
  State_57768_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>：al perder vida, obtén [StateArg1] de Locura; al infligir daño, obtén [StateArg2] de Locura"
  },
  State_57768_Name = {
    Text = "Hasta la fusión de la montaña de nieve"
  },
  State_57769_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: Después de jugar una tarjeta de habilidad del portador, roba 1 tarjeta de habilidad del portador. El efecto se activa como máximo 1 vez por turno."
  },
  State_57769_Name = {
    Text = "Puerta de la Verdad"
  },
  State_57770_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: El Daño, la curación y el Efecto de Blindaje causados por la \"habilidad\" aumentan un [StateArg1]~[StateArg2]% (actualmente [Layer] %), <PhantomKeywords:Fantasma>."
  },
  State_57770_Name = {
    Text = "Roulette del Destino"
  },
  State_57814_Name = {
    Text = "Cuando existe esta marca, significa que se está cambiando la Rueda del destino. Parte de la lógica necesitará identificar esta marca."
  },
  State_57817_Desc = {
    Text = "Dispersado por el enemigo o al final del turno, capas -1, al agotarse las capas <PVPPowerIconKeywords:Fuerza> +3, cambiar el ciclo de vida perderá el estado de sueño refinado"
  },
  State_57817_Name = {
    Text = "Sueño refinado"
  },
  State_57854_Desc = {
    Text = "Al inicio del turno, obtén [StateArg1] puntos de escudo y [StateArg2] puntos de daño de tentáculo. Genera 2 tentáculos temporales durante [Layer] turnos."
  },
  State_57854_Name = {Text = "Voto libre"},
  State_57854_WeaponDesc = {
    Text = "Estado@Dama del Mar Profundo Té y Pastel"
  },
  State_57864_Name = {
    Text = "Bonificación de poder de refresco __ \"Solo para uso de desarrollo\""
  },
  State_57942_Desc = {
    Text = "Grado de fusión actual [Layer]%. Al 100%, el enemigo entra en la siguiente fase y libera habilidades más fuertes"
  },
  State_57942_Name = {Text = "Fusión"},
  State_57952_Desc = {
    Text = "Cuando se reduce la fuerza, solo se reduce el 50% de las capas de fuerza"
  },
  State_57952_Name = {
    Text = "Inmersión profunda"
  },
  State_57953_Desc = {
    Text = "Al final del turno, genera 1 tentáculo. Al despertar, elimina este estado"
  },
  State_57953_Name = {Text = "Sueño"},
  State_57955_Desc = {
    Text = "El daño causado por Silo aumenta en [StateArg1] % y dura [Layer] turnos."
  },
  State_57955_Name = {
    Text = "Sobrevivir en la adversidad·Daño"
  },
  State_57968_Desc = {
    Text = "Influenciado por Juliette, cada vez que termina un turno, el grado de fusión de los gemelos aumenta en un 10% y se baraja 1 carta de \"distorsión\" en la pila de robo"
  },
  State_57968_Name = {
    Text = "\"Canto de Yuliette\""
  },
  State_57970_Name = {
    Text = "Protección de la madre divina"
  },
  State_57976_Desc = {
    Text = "\"Hijo de la Oscuridad\" realiza una Fusión forzada, infligiendo un Daño Fijo igual a 3 veces su PV actual a \"Inicio del olvido\"."
  },
  State_57976_Name = {Text = "Sacrificio"},
  State_58051_Desc = {
    Text = "Daño crítico +[Layer]%"
  },
  State_58051_Name = {
    Text = "Daño Crítico"
  },
  State_58052_Desc = {
    Text = "Al consumir 1 punto de el sigilo negro durante la exploración, se incrementa el daño base de \"todo incluido\" en un 0.5%. (aumentado [DescArg1]%)"
  },
  State_58052_Name = {
    Text = "Sin riesgo de pérdida"
  },
  State_58061_Name = {
    Text = "Integridad al encontrar dinero"
  },
  State_58063_Desc = {
    Text = "El daño causado por el Despertado aumenta un 25%, durando [Layer] turnos."
  },
  State_58063_Name = {
    Text = "Una mirada que supera los tiempos antiguos"
  },
  State_58144_Desc = {
    Text = "La tasa crítica en este nivel aumenta en [Layer] %"
  },
  State_58144_Name = {
    Text = "Tasa de golpe crítico permanente"
  },
  State_58144_WeaponDesc = {
    Text = "La tasa crítica en este nivel aumenta en [Layer] %"
  },
  State_58259_Desc = {
    Text = "Equipo Único: La probabilidad de crítico del portador aumenta en <WeaponEffect_Num:[StateArg1]%. Después de que el portador mate a un enemigo, obtiene <WeaponEffect_Num:[StateArg2]> marcas negras, activándose un máximo de 3 veces durante la exploración. Después de activarse 3 veces, la probabilidad de crítico del portador aumenta permanentemente en <WeaponEffect_Num:[StateArg3]%> durante esta exploración."
  },
  State_58259_WeaponDesc = {
    Text = "La tasa de crítico del portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Después de que el portador mate a un enemigo, gana <WeaponEffect_Num:[DescArg2]> puntos de Sigilo Negro, activándose como máximo 3 veces durante la exploración ([DescArg1]/3). Después de activar 3 veces, la tasa de crítico del portador aumentará permanentemente en <WeaponEffect_Num:[StateArg3]%> durante esta exploración."
  },
  State_58297_Desc = {
    Text = "Ryker obtiene [DescArg3] marcas negras al matar enemigos, con un máximo de 5 activaciones por exploración. ([DescArg1]/5)\n Al obtener 50/125/250 marcas negras a través de la batalla, el límite de creación aumenta en 1, y al final de la batalla, elige un \"Legado del Caos\" para agregar a la lista de reliquias. (Se han obtenido [DescArg2] puntos de marcas negras)"
  },
  State_58297_Name = {
    Text = "El ganador se lo lleva todo"
  },
  State_58447_Desc = {
    Text = "Incluye las siguientes tres reliquias: \n\"Abrigo Afortunado del Viento\": la probabilidad de crítico de todos los despertadores aumenta en un 10%. Todos los efectos aleatorios de Ryker y los dados no alcanzan el valor mínimo. \n<TentacleInjurieIconKeywords:Mejora>: la probabilidad de crítico aumenta a 15%, aumentando el valor máximo del resultado aleatorio en 1. \n\"Dados de octaedro\": cada vez que liberes una llave, coloca 1 carta de\"<C05_yansheng1:Dados de octaedro>\"en tu mano. \n<TentacleInjurieIconKeywords:Mejora>: cambia a colocar 1 carta de\"<C05_yansheng2:Troquel de octaedro brillante>\"en tu mano. \n\"Botón de Boca Grande\": al comienzo del turno y al activar un efecto aleatorio de Ryker o un dado, ganas 50 puntos de Llave Plateada y 2% de daño crítico, con un máximo de 30% de daño crítico. \n<TentacleInjurieIconKeywords:Mejora>: cambia a ganar 100 puntos de Llave Plateada y 4% de daño crítico, con un máximo de 50% de daño crítico."
  },
  State_58447_Name = {
    Text = "<CardKeyWord:Legado del Caos>"
  },
  State_58490_Desc = {
    Text = "Cuando se elimine toda la somnolencia, sellará a todos los Despertados y cartas, y cambiará la intención del \"Señor del Sueño\" a \"Autoridad Real\""
  },
  State_58490_Name = {
    Text = "Somnolencia"
  },
  State_58491_Desc = {
    Text = "Cada vez que se juega una carta, se elimina 1 capa de \"Somnolencia\". Al inicio del turno, se restauran 12 capas de \"Somnolencia\"."
  },
  State_58491_Name = {Text = "Ira"},
  State_58492_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_58492_Name = {
    Text = "No Activado"
  },
  State_58493_Desc = {
    Text = "Cada vez que se juega una carta, se elimina 1 capa de \"Somnolencia\". Al inicio del turno, se restauran 12 capas de \"Somnolencia\"."
  },
  State_58493_Name = {Text = "Ira"},
  State_58947_Desc = {
    Text = "La tasa crítica en este nivel aumenta en [Layer] %"
  },
  State_59078_Name = {
    Text = ", se puede usar 1 vez"
  },
  State_59079_Name = {
    Text = ", se puede usar 2 veces"
  },
  State_59080_Name = {
    Text = ", se puede usar 3 veces"
  },
  State_59117_Desc = {
    Text = "Daño crítico +[Layer]%"
  },
  State_59117_Name = {
    Text = "Daño Crítico"
  },
  State_59160_Desc = {
    Text = "Aumenta en un 10 % todo el Daño causado, la Cicatrización y los efectos de Escudo del personaje, no se puede disipar."
  },
  State_59160_Name = {
    Text = "<CardKeyWord:fuerte>"
  },
  State_59161_Desc = {
    Text = "Aumenta el Daño causado, la Cicatrización y los efectos de Escudo del personaje en [DescArg1]%. No puede ser disipado."
  },
  State_59161_Name = {
    Text = "Amplificación"
  },
  State_59169_Desc = {
    Text = "El coste de aritmética base de esta carta no será mayor que el límite de aritmética."
  },
  State_59169_Name = {
    Text = "Balance__ \"Uso exclusivo para el desarrollo\""
  },
  State_59173_Name = {
    Text = "Cuando esta marca está presente, indica que se está realizando un golpe múltiple y no se activará un golpe múltiple nuevamente."
  },
  State_59208_Desc = {
    Text = "Reduce en un 10 % todo el Daño causado, la Cicatrización y los efectos de Escudo del personaje, no se puede disipar."
  },
  State_59208_Name = {
    Text = "<WeaknessColour: reducción fuerte>"
  },
  State_59209_Desc = {
    Text = "Reduce el Daño causado, la Cicatrización y los efectos de Escudo del personaje en [DescArg1]%. No puede ser disipado."
  },
  State_59209_Name = {
    Text = "Amplificación▼"
  },
  State_59423_Desc = {
    Text = "Ryker obtiene 5 marcas negras al matar enemigos, cada 1% de recompensa de marca negra que obtiene aumenta la cantidad en un 1%, con un máximo de 5 activaciones por exploración.\n Al obtener 50/125/250 marcas negras a través de la batalla, el límite de creación aumenta en 1, y al final de la batalla, elige un \"Legado del Caos\" para agregar a la lista de reliquias."
  },
  State_59423_Name = {
    Text = "El ganador se lo lleva todo"
  },
  State_59424_Desc = {
    Text = "Al consumir 1 punto de el sigilo negro durante la exploración, se incrementa el daño base de \"todo incluido\" en un 0.5%"
  },
  State_59424_Name = {
    Text = "Sin riesgo de pérdida"
  },
  State_59439_Desc = {
    Text = "Este estado utiliza un área de multiplicador de vulnerable, fingiendo ser un área de multiplicador independiente.__\"Solo para uso en desarrollo\""
  },
  State_59439_Name = {
    Text = "Si posees cierto estado, el daño se duplicará __\"Solo para desarrollo\""
  },
  State_59519_Name = {
    Text = "Elige 1 carta de comando del mazo de robo o del montón de descarte para agregar a tu mano, su consumo de aritmética se convierte en 0"
  },
  State_59520_Desc = {
    Text = "Después de jugar, roba 2 cartas y reduce su coste de Aritmética por el coste real de la carta de Plegaria, teniendo efecto solo una vez por batalla."
  },
  State_59520_Name = {
    Text = "<WhiteQuality:Sabiduría>"
  },
  State_59521_Name = {
    Text = "Pierde 10% de la vida actual ([DescArg1])"
  },
  State_59522_Desc = {
    Text = "Juega esto y descarta todas las demás cartas excepto este despertador, ganando 5 cartas aleatorias que no son despertadores; esto solo tiene efecto una vez por batalla."
  },
  State_59522_Name = {
    Text = "<WhiteQuality:Alegría>"
  },
  State_59525_Name = {
    Text = "El Despertado correspondiente a la carta de comando obtiene 50 puntos de locura"
  },
  State_59526_Desc = {
    Text = "Al jugar, gana 3 copias básicas de <RetainIconKeywords:Retain> y <DepleteIconKeywords:Exhaust>, solo efectivo una vez por batalla."
  },
  State_59526_Name = {
    Text = "<WhiteQuality:Reproducción>"
  },
  State_59534_Name = {
    Text = "Cuando esta marca está presente, indica que esta carta prohíbe activar ilusiones."
  },
  State_59560_Name = {
    Text = "Elige una carta que haya conseguido las tres grandes plegarias y añádela a tu mano"
  },
  State_59671_Desc = {
    Text = "Este turno, el daño final de todos los despertados aumenta un 15%"
  },
  State_59671_Name = {
    Text = "Reloj de Cuerda Suprema"
  },
  State_59673_Name = {
    Text = "Pequeña caja de música"
  },
  State_59678_Desc = {
    Text = "Al recoger, se pierden todas las otras reliquias y se obtienen aleatoriamente 2 reliquias de oro"
  },
  State_59878_Desc = {
    Text = "Al final del turno, reduce 1 Acumulación adicional de \"Caos\" y obtén [StateArg1] <PowerIconKeywords:Fortaleza>. Los clones de \"N\" invocados posteriormente tienen sus PV aumentados en 200%, y al morir ya no reducen las Acumulaciones de \"Caos\" ni obtienen <PowerIconKeywords:Fortaleza>."
  },
  State_59878_Name = {
    Text = "Llegada del caos"
  },
  State_59991_Name = {
    Text = ", al jugar esta carta, se pueden consumir hasta 5 capas <EnergyStorageKeywords:cargar>"
  },
  State_59993_Name = {
    Text = "Recupera 10% de la vida perdida ([DescArg1])"
  },
  State_60000_Desc = {
    Text = "Gana 1 acumulación de <MadnessIconKeywords:Locura> Temporal al recibir Daño Activo."
  },
  State_60000_Name = {
    Text = "Acumulación de ira"
  },
  State_60028_Desc = {
    Text = "Al comienzo del turno del jugador, una de sus cartas en la mano tendrá el costo de aritmética cambiado a 3 en este turno. Después de la muerte, este efecto termina y reduce el costo de todas las cartas del que mató en este turno en 1"
  },
  State_60028_Name = {
    Text = "Delirio de la jaula"
  },
  State_60044_Name = {
    Text = "Consume después de [Layer] usos"
  },
  State_60083_Desc = {
    Text = "El daño recibido este turno -[Layer]%."
  },
  State_60083_Name = {
    Text = "<ReinforceColour: reforzado>"
  },
  State_60083_WeaponDesc = {
    Text = "Todo el daño infligido se reduce en [DescArg1] %"
  },
  State_60085_Desc = {
    Text = "Al comenzar la batalla y al inicio del turno, se otorgan refuerzos temporales, cuanto mayor sea la vida del jugador, más capas se obtienen, con un máximo de 50 capas"
  },
  State_60085_Name = {
    Text = "Pupación final"
  },
  State_60085_WeaponDesc = {
    Text = "Todo el daño infligido se reduce en [DescArg1] %"
  },
  State_60086_Desc = {
    Text = "Al comenzar la batalla y al inicio del turno, se otorgan refuerzos temporales, cuanto mayor sea la vida del jugador, más capas se obtienen, con un máximo de 25 capas"
  },
  State_60086_Name = {Text = "Pupación"},
  State_60086_WeaponDesc = {
    Text = "Todo el daño infligido se reduce en [DescArg1] %"
  },
  State_60087_Desc = {
    Text = "El efecto de herida se convierte en reducción de recuperación de vida en [Layer]%"
  },
  State_60087_Name = {
    Text = "<Rune_14_High:Herida profunda>"
  },
  State_60087_WeaponDesc = {
    Text = "Todo el daño infligido se reduce en [DescArg1] %"
  },
  State_60088_Desc = {
    Text = "Cada Acumulación reduce el daño recibido en un 1%."
  },
  State_60088_Name = {
    Text = "<ReinforcePVEKeywords: reforzado>"
  },
  State_60088_WeaponDesc = {
    Text = "Todos los escudos obtenidos se reducen en un 25%"
  },
  State_60089_Desc = {
    Text = "El daño recibido -[Layer]%."
  },
  State_60089_Name = {
    Text = "<ReinforceColour: reforzado>"
  },
  State_60089_WeaponDesc = {
    Text = "Todo el daño infligido se reduce en [DescArg1] %"
  },
  State_60106_Desc = {
    Text = "Al comienzo del turno, uno de tus cartas aleatorias cambia su coste de aritmética a 3 y se recupera al final del turno"
  },
  State_60106_Name = {
    Text = "Delirio de la jaula"
  },
  State_60112_Desc = {
    Text = "Este turno, cada carta de comando jugada otorga 1 de locura a todos los despertados"
  },
  State_60112_Name = {Text = "Concierto"},
  State_60115_Desc = {
    Text = "Después de lanzar una explosión de aliemus en esta ronda, se reduce la fusión de gemelos en un 3 %"
  },
  State_60115_Name = {Text = "Réquiem"},
  State_60118_Desc = {
    Text = "El daño, veneno y contraataque causados en esta ronda aumentan en [Layer] %"
  },
  State_60118_Name = {Text = "Rapsodia"},
  State_60128_Desc = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_60128_WeaponDesc = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_60129_Desc = {
    Text = "Has lanzado la carta de comando [Layer] no derivada con un costo de aritmética -2"
  },
  State_60129_Name = {
    Text = "Escala descendente"
  },
  State_60130_Desc = {
    Text = "Has lanzado la carta de comando [Layer] no derivada con un costo de aritmética +2, efectiva 2 veces"
  },
  State_60130_Name = {
    Text = "Escala ascendente"
  },
  State_60148_Desc = {
    Text = "Al final del turno, obtén diferentes efectos según el estado: Liberar - obten 1 capa temporal de <MadnessIconKeywords:locura>. Restringir - obten 50 capas temporales de <ReinforcePVEKeywords:reforzado>"
  },
  State_60148_Name = {
    Text = "Ajuste de parámetros"
  },
  State_60150_Desc = {
    Text = "Cada vez que detecta que el jugador usa una clave, cambia inmediatamente entre los modos de liberación y contención. Al cambiar a liberación, obtiene [StateArg1] puntos de fuerza temporal. Al cambiar a contención, obtiene [StateArg2] puntos de escudo"
  },
  State_60150_Name = {
    Text = "Sensibilidad funcional"
  },
  State_60151_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_60151_Name = {
    Text = "No Activado"
  },
  State_60154_Desc = {
    Text = "Actualmente en forma - Compresión. Los armamentos mecánicos ganarán un escudo y alerta, y la intención será priorizar la defensa"
  },
  State_60154_Name = {
    Text = "Retraer: Mecha"
  },
  State_60155_Desc = {
    Text = "Actualmente en forma - Expansión. Los armamentos mecánicos ganarán potencia, y la intención será priorizar el ataque"
  },
  State_60155_Name = {
    Text = "Desatar: Mecha"
  },
  State_60167_Desc = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_60167_WeaponDesc = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_60184_Desc = {
    Text = "Cada vez que juegues una carta, los \"Gemelos Contradictorios\" cambiarán de intención"
  },
  State_60184_Name = {
    Text = "contradicción"
  },
  State_60187_Desc = {
    Text = "El debilitamiento, vulnerabilidad y estado crítico que causa al jugador son todos del 50%"
  },
  State_60187_Name = {
    Text = "El fin es el comienzo"
  },
  State_60201_Name = {
    Text = "Fuerza retardada del monstruo"
  },
  State_60263_Desc = {
    Text = "El efecto de fragilidad se convierte en reducción de escudo en [Layer]%"
  },
  State_60263_Name = {
    Text = "<Rune_14_High:Fragilidad aumentada>"
  },
  State_60264_Desc = {
    Text = "El efecto de sangrado causado se eliminará automáticamente solo un 50% al final del turno"
  },
  State_60264_Name = {
    Text = "<Rune_14_High:Hemólisis>"
  },
  State_60265_Desc = {
    Text = "El efecto de sangrado solo eliminará un 50% al final del turno"
  },
  State_60265_Name = {
    Text = "<BleedingColour: Hemólisis>"
  },
  State_60279_Name = {
    Text = "Esta carta será consumida al final del Turno"
  },
  State_60284_Desc = {
    Text = "Al comenzar la batalla y al inicio del turno, se otorgan refuerzos temporales, cuanto menor sea la vida del jugador, más capas se obtienen, con un máximo de 50 capas"
  },
  State_60284_Name = {
    Text = "Formación de Espada Indestructible"
  },
  State_60284_WeaponDesc = {
    Text = "Todo el daño infligido se reduce en [DescArg1] %"
  },
  State_60297_Desc = {
    Text = "'@2 aparece en forma de liberación, convirtiendo la vida en 3 veces la original. Además, cada turno cuestiona al guardián y añade una carta de \"respuesta a Tawil\" a su mano.'"
  },
  State_60297_Name = {
    Text = "Investigación de la verdad"
  },
  State_60297_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_60298_Desc = {
    Text = "La fuerza de la entidad desconocida aún yace bajo la charca negra, a punto de revivir completamente y recuperar la vida antes de ser derrotada, comenzando a luchar en su forma liberada"
  },
  State_60298_Name = {
    Text = "Inactividad"
  },
  State_60312_Desc = {
    Text = "Al recibir daño equivalente al 10% de la vida acumulada en cada turno, obtienes [Layer] capas temporales de \"reforzado\""
  },
  State_60312_Name = {
    Text = "Escudo de Niebla Corrosiva"
  },
  State_60315_Desc = {
    Text = "Después de lanzar una explosión de aliemus en esta ronda, se recupera el 5 % de la vida perdida ([DescArg1])"
  },
  State_60315_Name = {Text = "Réquiem"},
  State_60336_Name = {
    Text = "Después de jugar, obtén 1 punto de aritmética y roba 1 carta, pero esta carta será consumida"
  },
  State_60339_Name = {
    Text = "Jugar esta carta otorga 1 Aritmética y roba 1 Carta, pero esta Carta será Agotada"
  },
  State_60367_Desc = {
    Text = "Al comienzo del turno del jugador, una de sus cartas en la mano tendrá el costo de aritmética cambiado a 3 en este turno. Después de la muerte, este efecto termina y reduce el costo de todas las cartas del que mató en este turno en 1"
  },
  State_60367_Name = {
    Text = "Delirio de la jaula"
  },
  State_60386_Desc = {
    Text = "Efectos incluyen: causar 150% de daño por sangrado, causar 75% de daño por veneno, aplicar 1 capa de debilidad, aplicar 1 capa de vulnerabilidad, reducir temporalmente [DescArg1] puntos de poder"
  },
  State_60386_Name = {
    Text = "<MysterydebuffKeywords:Efecto negativo misterioso>"
  },
  State_60404_Desc = {
    Text = "Al recibir 1 daño, obtén 2 capas de reforzado temporal"
  },
  State_60404_Name = {
    Text = "Metamorfosis final"
  },
  State_60408_Desc = {
    Text = "Cada vez que la vida baje al 33% (faltan [DescArg1] puntos), no recibirás daño este turno y liberarás \"Mordisco Fantasma\""
  },
  State_60408_Name = {
    Text = "Mordedura de máscara fantasma"
  },
  State_60409_Desc = {
    Text = "Cada vez que la vida baje al 66% (faltan [DescArg1] puntos), no recibirás daño este turno y liberarás \"Transformación Final\""
  },
  State_60409_Name = {
    Text = "Espejo del Fin"
  },
  State_60429_Name = {
    Text = "Estado@despertador hameln@melodía original"
  },
  State_60430_Desc = {
    Text = "Al jugar una carta que consuma el gasto real de aritmética y muestre intención, se consumirá y hará que todos los enemigos pierdan [DescArg1] puntos de poder temporal"
  },
  State_60430_Name = {
    Text = "Orden rítmico de notas"
  },
  State_60431_Name = {
    Text = "Estado@despertador hameln@sonido ascendente"
  },
  State_60432_Name = {
    Text = "Estado@despertador hameln@overture del alma"
  },
  State_60433_Name = {
    Text = "Estado@despertador hameln@escala descendente"
  },
  State_60434_Name = {
    Text = "Estado@despertador hameln@recuerdo de la canción"
  },
  State_60435_Name = {
    Text = "Estado@despertador hameln@contador de overture del alma"
  },
  State_60436_Desc = {
    Text = "Al causar daño no bloqueado, baraja [StateArg1] cartas de \"herida\" en la pila de robo"
  },
  State_60436_Name = {
    Text = "Obertura del alma"
  },
  State_60438_Name = {
    Text = "Estado@despertador hameln@escucha sonido ascendente"
  },
  State_60439_Name = {
    Text = "Estado@despertador hameln@escucha sonido descendente"
  },
  State_60440_Name = {
    Text = "Estado@despertador hameln@escucha obertura del alma"
  },
  State_60441_Name = {
    Text = "Estado@despertador hameln@escucha recuerdo de la canción"
  },
  State_60442_Name = {
    Text = "Estado@despertador hameln@escucha melodía original"
  },
  State_60486_Desc = {
    Text = "Al comenzar la batalla, todos los despertadores ven reducida su locura a la mitad"
  },
  State_60486_Name = {
    Text = "Absorción de la diosa madre"
  },
  State_60487_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, aumentará su salud máxima un 200%, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_60487_Name = {
    Text = "No Activado"
  },
  State_60490_Desc = {
    Text = "Después de morir, todos los despertares obtienen 30 puntos de locura"
  },
  State_60490_Name = {
    Text = "Deseo de vivir"
  },
  State_60491_Desc = {
    Text = "La Locura causada por los Despertados se reduce en 50%"
  },
  State_60491_Name = {
    Text = "Ritual del Árbol Madre"
  },
  State_60493_Desc = {
    Text = "Por cada [Layer] puntos acumulados de disminución de vida, se invocará un despertador imitado. Si ya hay 2 despertadores imitados en el campo, todos los despertadores imitados incrementan su vida máxima en un 50%"
  },
  State_60493_Name = {
    Text = "Madre nutricia"
  },
  State_60500_Desc = {
    Text = "Si existe un despertador de imitación, obtienes 50 capas de \"ocultar\""
  },
  State_60500_Name = {
    Text = "Oculto en el bosque"
  },
  State_60511_Desc = {
    Text = "Aparece en la mano inicial"
  },
  State_60511_Name = {
    Text = "<GuyouKeywords:Inherente>"
  },
  State_60511_WeaponDesc = {
    Text = "Después de jugar, la carta no irá al montón de descarte, no podrá usarse nuevamente en esta batalla"
  },
  State_60522_Desc = {
    Text = "El efecto de fragilidad y herida aumenta al 50%"
  },
  State_60522_Name = {
    Text = "Destrucción"
  },
  State_60523_Desc = {
    Text = "Cada capa añade 1 ataque, pierde 1 capa al recibir daño, pierde todas al final del turno"
  },
  State_60523_Name = {Text = "Oración"},
  State_60524_Desc = {
    Text = "Al comenzar la batalla y al inicio del turno, se otorgan [Layer] capas de refuerzo, con un máximo de 50 capas"
  },
  State_60524_Name = {
    Text = "Sanctificación"
  },
  State_60524_WeaponDesc = {
    Text = "Todo el daño infligido se reduce en [DescArg1] %"
  },
  State_60527_Desc = {
    Text = "Se consume al jugarla, pero reduce la fuerza temporal del enemigo"
  },
  State_60527_Name = {
    Text = "<CardKeyWord:Paraíso Melódico>"
  },
  State_60543_Desc = {
    Text = "Al final del turno, obtén 10 capas de \"Juramento de Sangre\", que se elimina 1 capa al recibir daño"
  },
  State_60543_Name = {
    Text = "Fuego del corazón de la luz"
  },
  State_60554_Name = {
    Text = "<HuihuanbKeywords:Eco musical>"
  },
  State_60558_Name = {
    Text = "<HuihuanbKeywords:Eco musical>"
  },
  State_60562_Desc = {
    Text = "Al jugar, se activa 2 veces, cambia a \"Sonido de carga\""
  },
  State_60562_Name = {
    Text = "<HuihuanaKeywords:Eco musical>"
  },
  State_60564_Desc = {
    Text = "Al estar a punto de ser derrotado por primera vez, recupera vida y cambia la intención a \"Evolución final\", obteniendo fuerza y fortaleza. Al estar a punto de ser derrotado por segunda vez, recupera vida y cambia la intención a \"Mordedura de máscara fantasma\", infligiendo un daño único extremadamente alto."
  },
  State_60564_Name = {
    Text = "Demonio Sombra"
  },
  State_60567_Desc = {
    Text = "Después de jugar, Hameln obtiene 3 puntos de aliemus"
  },
  State_60567_Name = {
    Text = "<XushiAKeywords:Sonido acumulado>"
  },
  State_60568_Name = {
    Text = "<XushiAKeywords:Sonido acumulado>"
  },
  State_60569_Name = {
    Text = "<XushiBKeywords:Sonido acumulado>"
  },
  State_60570_Desc = {
    Text = "Después de jugar, Hameln obtiene 3 puntos de aliemus"
  },
  State_60570_Name = {
    Text = "<XushiBKeywords:Sonido acumulado>"
  },
  State_60571_Name = {
    Text = "<HuihuanaKeywords:Eco musical>"
  },
  State_60576_Desc = {
    Text = "Al comienzo del turno del jugador, una de sus cartas en la mano tendrá el costo de aritmética cambiado a 3 en este turno. Después de la muerte, este efecto termina y reduce el costo de todas las cartas del que mató en este turno en 1"
  },
  State_60576_Name = {
    Text = "Delirio de la jaula"
  },
  State_60578_Desc = {
    Text = "Al recibir daño fatal, se recuperará un 50% de vida, inmune al daño durante 1 turno; la intención se convierte en \"Ruptura del Capullo\""
  },
  State_60578_Name = {
    Text = "Crisálida Break"
  },
  State_60592_Desc = {
    Text = "Al inicio de la exploración, añade 1 \"Amanecer de llave plateada\" con <DestructionKeywords:Destruir> al mazo.\nCada vez que se desata la Posse, el Daño crítico del Portador +<WeaponEffect_Num:[StateArg1]%>.\nCada vez que el Portador inflige Daño Activo, su Probabilidad de Crítico +<WeaponEffect_Num:[StateArg3]%> en este turno y ganas Keyflare igual al <WeaponEffect_Num:[StateArg2]%> de su Regeneración de Llave Plateada, hasta 5 veces por turno."
  },
  State_60592_WeaponDesc = {
    Text = "Al inicio de la exploración, añade 1 \"Amanecer de llave plateada\" con <DestructionKeywords:Destruir> al mazo.\nCada vez que se desata la Posse, el Daño crítico del Portador +<WeaponEffect_Num:[StateArg1]%>.\nCada vez que el Portador inflige Daño Activo, su Probabilidad de Crítico Temporal +<WeaponEffect_Num:[StateArg3]%> y ganas <WeaponEffect_Num:[DescArg1]> Keyflare, hasta 5 veces por turno."
  },
  State_60594_Desc = {
    Text = "Equipo único: Al finalizar el turno, el portador recibe 5 puntos de aliemus. Después de que el portador libere exaltar, la siguiente carta de comando que juegue en este turno obtiene <WeaponEffect_Num:[StateArg1]%> de tasa crítica, daño crítico, escudo y recuperación de vida."
  },
  State_60594_WeaponDesc = {
    Text = "Después de terminar el turno, el portador recibe 5 de aliemus. Después de que el portador libera exaltar, la siguiente carta de comando que juegue en este turno obtiene <WeaponEffect_Num:[StateArg1]%> de tasa crítica, daño crítico, escudo y recuperación de vida"
  },
  State_60898_Desc = {
    Text = "Al recibir Daño Activo y Daño de tentáculos, sella el Exaltar y las Tarjetas de comando del Despertado atacante durante 1 turno, elimina 1 acumulación de <ResentChainsKeywords:Cadena de Rancor>."
  },
  State_60898_Name = {
    Text = "<ResentChainsKeywords1:Cadena de Rancor>"
  },
  State_60925_Desc = {
    Text = "Al final del turno, recupera un 5% de la salud perdida. Cada vez que el jugador roba 1 carta de síntoma o estado, todos los aliados obtienen [Layer] puntos de poder"
  },
  State_60925_Name = {
    Text = "Lámpara de sangre"
  },
  State_60926_Desc = {
    Text = "Al final del turno, si tu vida está por debajo del 50%, obtén [Layer] puntos de Fuerza y [StateArg1] capas de Barrera"
  },
  State_60926_Name = {
    Text = "Altar de la Antorcha Sagrada"
  },
  State_60953_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: \"Exaltación de Locura\" causa [StateArg1] capas de <PVPSlowKeywords:Lento> a todos los objetivos enemigos antes de lanzar."
  },
  State_60953_Name = {
    Text = "Réquiem Eterno"
  },
  State_60962_Desc = {
    Text = "En esta batalla, la salud máxima aumenta en un [Layer] %"
  },
  State_60962_Name = {
    Text = "Aumento de vida"
  },
  State_60964_Desc = {
    Text = "Daño aumentado en [Layer]% en esta batalla"
  },
  State_60964_Name = {
    Text = "Daño aumentado"
  },
  State_61038_Name = {
    Text = "Hamelin Demo"
  },
  State_61050_Desc = {
    Text = "Al activar el efecto \"Melodía\" o Jugar \"Sinfonía de armonía\", Hameln obtiene un 1% de Probabilidad de Crítico y Daño Crítico (actualmente ha obtenido [DescArg1]%). Por cada 10 activaciones, el número de instancias de Daño de \"Obertura del alma\" y \"Acorde Primal\" +1 en esta batalla, hasta un máximo de 3 veces."
  },
  State_61050_Name = {
    Text = "Rêverie bajo la luna"
  },
  State_61051_Desc = {
    Text = "Al activar el efecto \"Melodía\" o Jugar \"Sinfonía de armonía\", Hameln obtiene un 1% de Probabilidad de Crítico y Daño Crítico. Por cada 10 activaciones, el número de instancias de Daño de \"Obertura del alma\" y \"Acorde Primal\" +1 en esta batalla, hasta un máximo de 3 veces."
  },
  State_61051_Name = {
    Text = "Rêverie bajo la luna"
  },
  State_61056_Desc = {
    Text = "En el primer turno, obtén 100 puntos de fuerza temporal"
  },
  State_61056_Name = {Text = "Furia"},
  State_61084_Desc = {
    Text = "La próxima [Layer] carta jugada en esta ronda: si el consumo de aritmética es mayor o igual a 3, obtén 2 puntos de aritmética; de lo contrario, roba 2 cartas."
  },
  State_61084_Name = {
    Text = "Cuarta sinfonía"
  },
  State_61085_Desc = {
    Text = "Consumo de aritmética - 2, efectivo 2 veces después de jugar, cambia a \"Música de acumulación\""
  },
  State_61085_Name = {
    Text = "<HuihuanbKeywords:Eco musical>"
  },
  State_61089_Desc = {
    Text = "La próxima carta de comando jugada se activa 2 veces"
  },
  State_61089_Name = {
    Text = "Baton de director de orquesta"
  },
  State_61145_Name = {
    Text = "<BleedingColour: sangrando>"
  },
  State_61174_Desc = {
    Text = "No se puede obtener escudo"
  },
  State_61174_Name = {
    Text = "Envío de los restos"
  },
  State_61180_Desc = {
    Text = "El daño base de Helot-catena aumenta en [DescArg1]% en esta batalla."
  },
  State_61180_Name = {
    Text = "Hoja de venganza"
  },
  State_61185_Desc = {
    Text = "Amplificará las habilidades del enemigo. Se pierde una capa cada vez que se recibe daño"
  },
  State_61185_Name = {
    Text = "Juramento de Sangre"
  },
  State_62213_Desc = {
    Text = "Cambia el efecto de Síntoma: Debilidad para reducir el Daño Activo y Daño de tentáculos infligido en un [Layer]%."
  },
  State_62213_Name = {
    Text = "<Rune_14_High:Debilidad aumentada>"
  },
  State_62309_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equipar, obtiene [StateArg1] <StrongEffectKeywords:Amplificación>. Cada vez que el Portador pierde PV, si los PV actuales están por debajo del [StateArg2]%, recibe <ReinforceKeywords:Fortaleza> y <StrengthenKeywords:Mejorar>."
  },
  State_62309_Name = {
    Text = "Sumergirse en Carmesí"
  },
  State_62317_Desc = {
    Text = "Inmunidad a todo daño, se elimina al inicio del turno"
  },
  State_62317_Name = {
    Text = "Inmunidad completa al daño"
  },
  State_62336_Desc = {
    Text = "Por cada 3 cartas jugadas (quedan [Layer] cartas), roba 1 carta y congela aleatoriamente 1 carta de comando en tu mano"
  },
  State_62336_Name = {
    Text = "El frío del invierno"
  },
  State_62337_Desc = {
    Text = "Por cada 3 cartas jugadas (quedan [Layer] cartas), roba 1 carta y congela aleatoriamente 1 carta de comando en tu mano"
  },
  State_62337_Name = {
    Text = "El frío del invierno"
  },
  State_62338_Desc = {
    Text = "Esta carta no puede ser jugada, no será descartada al final del turno y hace que el despertador asociado obtenga 5 puntos de locura; después de que el despertador libere un estallido de locura, se deshace del congelamiento"
  },
  State_62338_Name = {
    Text = "<CardKeyWord:Congelar>"
  },
  State_65332_Desc = {
    Text = "Después de morir, todos los despertares obtienen 30 puntos de locura"
  },
  State_65332_Name = {Text = "Fusión"},
  State_65342_Desc = {
    Text = "Tras ser derrotado, revivirás, aumentando un 100% de salud máxima y liberando \"Frío helado en los huesos\""
  },
  State_65342_Name = {Text = "Silencio"},
  State_65346_Desc = {
    Text = "Después de la muerte, congela 2 cartas de comando en la pila de cartas"
  },
  State_65346_Name = {
    Text = "Gelée blanche"
  },
  State_65358_Desc = {
    Text = "Equipo Único: El daño base infligido por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Antes de que el portador libere Exaltar, el tamaño máximo de la mano temporalmente aumenta en +1, y roba 1 carta de comando del portador. Si el dominio actual es \"Carne y sangre\", el daño crítico temporal aumenta en <WeaponEffect_Num:[StateArg1]%> al activar Devorar, aplicándose un máximo de 1 vez por turno."
  },
  State_65358_WeaponDesc = {
    Text = "El daño básico causado por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Antes de que el portador libere la explosión de locura, el tamaño máximo de la mano aumenta en 1, robando 1 carta de comando del portador. Si el dominio actual es \"Carne y sangre\", cuando el portador activa el efecto devorar, el daño crítico temporal aumenta en <WeaponEffect_Num:[StateArg1]>, aplicándose un máximo de 1 vez por turno."
  },
  State_65360_Desc = {
    Text = "Equipo Único: El daño base infligido por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Al comenzar la batalla, el portador obtiene 25 capas de \"Nieve\". Después de jugar una carta, el portador obtiene 2 puntos de alienación y elimina 1 capa. Tras eliminar todas las capas de \"Nieve\", el portador obtiene <WeaponEffect_Num:[StateArg2]%> de probabilidad de crítico."
  },
  State_65360_WeaponDesc = {
    Text = "El daño básico infligido por el portador aumenta en <WeaponEffect_Num:[StateArg1] %>. Al comenzar la batalla, el portador obtiene 25 capas de \"Nieve\". Después de jugar una carta, el portador obtiene 2 puntos de alienación y elimina 1 capa. Una vez que \"Nieve\" se haya eliminado por completo, el portador obtiene <WeaponEffect_Num:[StateArg2]%> de probabilidad de crítico (quedan [DescArg1] capas de nieve)."
  },
  State_65362_Desc = {
    Text = "Cada [StateArg1] daños recibidos (quedan [Layer]) congela una carta de comando al azar"
  },
  State_65362_Name = {
    Text = "Retorno de Escarcha"
  },
  State_65463_Name = {
    Text = "Obtén 5 puntos del sigilo negro"
  },
  State_65490_Desc = {
    Text = "Al final del turno, obtén [StateArg1] de Escudo de Escarcha y [StateArg2] de Fortaleza."
  },
  State_65490_Name = {
    Text = "Cero absoluto"
  },
  State_65497_Name = {
    Text = "Cadena de Sangre · Prueba de Shiro"
  },
  State_65553_Desc = {
    Text = "Al final del turno, gana fuerza según el número de cartas restantes en mano, [Layer] puntos por cada una"
  },
  State_65553_Name = {
    Text = "Lámina de hielo"
  },
  State_65557_Desc = {
    Text = "Al recibir daño letal, recupera toda la vida, cambia la intención a\"Mirada de Deepspace EX\", obtiene 80 capas de fortaleza temporal y elimina sus estados negativos y los estados positivos del jugador. Al final del turno, se eliminan 20 capas de fortaleza."
  },
  State_65557_Name = {
    Text = "Caos Antiguo"
  },
  State_65558_Desc = {
    Text = "Al recibir daño letal, cambia la intención a \"Mirada del espacio profundo\" y obtén 80 capas de fortaleza temporal, recuperando toda la vida. Puede activarse [DescArg1] veces. Una vez agotadas las activaciones, al recibir daño letal, retendrás 1 punto de vida y cambiarás la intención a \"Ojos de mundos infinitos\". Al final del turno, se eliminan 20 capas de fortaleza."
  },
  State_65558_Name = {
    Text = "Polvo de estrellas"
  },
  State_65559_Desc = {
    Text = "Tras la muerte de todos, Tohuwabohu aparecerá nuevamente."
  },
  State_65559_Name = {
    Text = "Esquirlas Antiguas"
  },
  State_65564_Name = {
    Text = "\n<D05EX_Relic: Las sospechas de los miembros del equipo de investigación sobre Helot aumentan constantemente, debe tomar una decisión antes de que el enemigo se acerque y calmar al caótico equipo>"
  },
  State_65565_Name = {
    Text = [[

<D05EX_Relic:ignorar las sospechas y seguir adelante>]]
  },
  State_65566_Name = {
    Text = "\n<D05EX_Relic:explicar a los miembros de la expedición>"
  },
  State_65567_Name = {
    Text = [[

<D05EX_Relic: Restringir a Helot para proteger mejor al equipo>]]
  },
  State_65568_Name = {
    Text = [[

<D05EX_Relic: Restringir a Helot y utilizar el poder del despertador para proteger completamente al equipo>]]
  },
  State_65585_Desc = {
    Text = "Después de Jugar esta carta, regresa a tu mano. La Oración se desactiva hasta el final del turno."
  },
  State_65585_Name = {
    Text = "<CardKeyWord:Eco>"
  },
  State_66305_Desc = {
    Text = "Al final del turno, obtiene 1 capa temporal de <ResentChainsKeywords:Cadena de Rancor>."
  },
  State_66305_Name = {
    Text = "La cerradura atemporal"
  },
  State_66306_Desc = {
    Text = "Al recibir Daño Activo y Daño de tentáculos, sella el Exaltar y las Tarjetas de comando del Despertado atacante durante 1 turno, elimina 1 acumulación de <ResentChainsKeywords:Cadena de Rancor>."
  },
  State_66306_Name = {
    Text = "<ResentChainsKeywords1:Cadena de Rancor>"
  },
  State_66308_Desc = {
    Text = "Después de recibir daño letal, la vida queda bloqueada en 1."
  },
  State_66308_Name = {
    Text = "Caos Antiguo"
  },
  State_66311_Desc = {
    Text = "Los recuerdos de los despertadores brotan desde el borde de tu mente, arraigándose y creciendo en tu cerebro. No importa cuántas veces los cortes, no importa cuántas veces la disolución los derribe, nunca se han ido"
  },
  State_66311_Name = {
    Text = "Recuerdos Rotos"
  },
  State_66313_Desc = {
    Text = "Cada vez que juegues 1 carta de comando, descarta 1 carta de este despertador con el consumo de aritmética más bajo."
  },
  State_66313_Name = {
    Text = "Intimidación de la Voluntad Suprema"
  },
  State_66314_Desc = {
    Text = "Inmunidad a todo daño."
  },
  State_66314_Name = {
    Text = "Inmunidad completa al daño"
  },
  State_66317_Desc = {
    Text = "Los recuerdos de los despertadores brotan desde el borde de tu mente, arraigándose y creciendo en tu cerebro. No importa cuántas veces los cortes, no importa cuántas veces la disolución los derribe, nunca se han ido. Al comienzo de cada turno, restaura 1 punto del límite de aritmética y 2 del tamaño máximo de la mano."
  },
  State_66317_Name = {
    Text = "Fragmento de memoria"
  },
  State_66325_Desc = {
    Text = "Los recuerdos de los despertados brotan desde el borde de tu mente, arraigándose y creciendo en tu cerebro. No importa cuántas veces los cortes, no importa cuántas veces la disolución los derribe, nunca se han ido. Al comienzo de cada turno, restaura 1 punto del límite de aritmética y 2 del tamaño máximo de la mano."
  },
  State_66325_Name = {
    Text = "Fragmento de memoria"
  },
  State_66358_Desc = {
    Text = "Al activar la resistencia a la muerte por primera vez durante la exploración, coloca una carta de \"<DerivativeCardKeywords_39:Ecos del Pasado>\" en tu mano"
  },
  State_66358_Name = {
    Text = "Existencia inexistente"
  },
  State_66359_Desc = {
    Text = "Aleatorio genera varias opciones para elegir."
  },
  State_66359_Name = {
    Text = "<FaxianKeywords:descubrimiento>"
  },
  State_66360_Desc = {
    Text = "En esta batalla, la tasa crítica aumenta en un [Layer] %"
  },
  State_66360_Name = {
    Text = "Probabilidad de Crítico"
  },
  State_66362_Desc = {
    Text = "Daño crítico aumentado en [Layer]% en esta batalla"
  },
  State_66362_Name = {
    Text = "Daño Crítico"
  },
  State_66409_Name = {
    Text = "Veredicto del albacea"
  },
  State_66410_Desc = {
    Text = "\"Las próximas Cartas de Comando [DescArg1] jugadas por Tawil tienen efecto dos veces.\""
  },
  State_66410_Name = {
    Text = "Convergencia Omnifex"
  },
  State_66414_Desc = {
    Text = "Mientras esté en la mano, si la carta de la parte superior del mazo es una carta de comando, se convierte en su copia"
  },
  State_66414_Name = {
    Text = "Verdad omnisciente"
  },
  State_66454_Desc = {
    Text = "La carta de habilidad reduce el costo de aritmética para las capas de \"ocultar\", apilable hasta 5 capas, se elimina 1 capa al recibir daño o usar una habilidad"
  },
  State_66454_Name = {Text = "Ocultar"},
  State_66456_Desc = {
    Text = "La carta de habilidad reduce el costo de aritmética para las capas de \"ocultar\", apilable hasta 5 capas, se elimina 1 capa al recibir daño o usar una habilidad"
  },
  State_66456_Name = {
    Text = "<YinniColour: Ocultar>"
  },
  State_66465_Desc = {
    Text = "Después de usar aliemus, recibe daño correspondiente a la cantidad de capas"
  },
  State_66465_Name = {
    Text = "<PVPfengsuoColour:Bloqueo Explosivo>"
  },
  State_66522_Desc = {
    Text = "Cada octava carta que juegues se activará dos veces"
  },
  State_66522_Name = {
    Text = "Cerveza estelar"
  },
  State_66553_Desc = {
    Text = "Después de jugar \"Golpe\" y \"DEF\", el despertador correspondiente obtiene 35 aliemus. Sin embargo, su gasto de aritmética aumenta en +1"
  },
  State_66553_Name = {
    Text = "Rostro roto"
  },
  State_66554_Desc = {
    Text = "Al recoger, coloca 1 carta <DerivativeCardKeywords_1:\"eco de sombra\"> en la mano"
  },
  State_66554_Name = {
    Text = "Equipo de comunicación"
  },
  State_66555_Desc = {
    Text = "Aumenta el límite de aritmética máxima en 1"
  },
  State_66555_Name = {
    Text = "Inyección de vitalidad"
  },
  State_66556_Desc = {
    Text = "Cada vez que juegues consecutivamente cartas del mismo Despertado, ese Despertado obtiene 8 puntos de locura"
  },
  State_66556_Name = {
    Text = "Dispositivo cronométrico"
  },
  State_66557_Desc = {
    Text = "Cada vez que pierdas vida, obtendrás [DescArg1] puntos de <PowerIconKeywords: poder>, acumulando un máximo de 10 veces por batalla. Cuando se llene el número de capas, recuperarás el 25% de la vida perdida"
  },
  State_66557_Name = {
    Text = "El más alto honor"
  },
  State_66558_Desc = {
    Text = "Cada 3 turnos, se añade 1 nivel de <WeaknessIconKeywords:debilidad> a todos los enemigos. Al infligir daño a enemigos <WeaknessIconKeywords:debilidad>, se ganarán [DescArg1] puntos de <PowerIconKeywords:poder> temporalmente, con un máximo de 3 activaciones por turno"
  },
  State_66558_Name = {
    Text = "Niño maligno"
  },
  State_66559_Desc = {
    Text = "Al jugar una carta con un consumo de aritmética de 3 o más, roba 1 carta y obtén 1 punto de aritmética"
  },
  State_66559_Name = {
    Text = "La belleza en la pérdida"
  },
  State_66560_Desc = {
    Text = "\"El golpe\" obtiene 2 puntos de aritmética y descarta aleatoriamente 1 carta; \"DEF\" roba 2 cartas y pierde 1 punto de aritmética. Se activa un máximo de 3 veces por turno"
  },
  State_66560_Name = {
    Text = "Disco alegre"
  },
  State_66561_Desc = {
    Text = "Cada 3 turnos, se añade 1 nivel de <VulnerabilityIconKeywords:vulnerable> a todos los enemigos. Cuando se inflige daño a los enemigos <VulnerabilityIconKeywords:vulnerable>, perderán [DescArg1] puntos de <PowerIconKeywords:poder> temporalmente, con un máximo de 3 activaciones por turno"
  },
  State_66561_Name = {
    Text = "Consagración de la primavera"
  },
  State_66562_Desc = {
    Text = "Cada 4 turnos, duplica el daño que todos los enemigos recibirán en ese turno, pero al liberar el estallido de locura en ese turno, sellará todos los despertadores por 1 turno"
  },
  State_66562_Name = {
    Text = "Restos del caminante del camino"
  },
  State_66563_Desc = {
    Text = "Al inicio del turno, si jugaste más de 3 cartas en el turno anterior, roba 2 cartas"
  },
  State_66563_Name = {
    Text = "Cartera nueva"
  },
  State_66564_Desc = {
    Text = "Al recoger, obtienes 3 puntos de aritmética"
  },
  State_66564_Name = {
    Text = "Espejo de reloj de bolsillo"
  },
  State_66565_Desc = {
    Text = "Al recoger, aplicas 1 turno de <WeaknessIconKeywords:debilidad> y <VulnerabilityIconKeywords:vulnerable> a todos los enemigos"
  },
  State_66565_Name = {
    Text = "Traje de Restricción con Cambio de Color"
  },
  State_66566_Desc = {
    Text = "Al inicio de cada turno, <DeathResistanceIconKeywords:Resistencia a la Muerte> aumenta un 10% (en esta fase, cada vez que se activa la Resistencia a la Muerte, se reduce a la mitad). Cuando la <DeathResistanceIconKeywords:Resistencia a la Muerte> supera el 100%, <ProficientInRealmsIconKeywords:maestría en reinos> aumenta en 100."
  },
  State_66566_Name = {
    Text = "Lágrima de sirena"
  },
  State_66703_Desc = {
    Text = "Equipo único: El límite de carga de la Llave de Plata aumenta en un 100%. Tamaño máximo de mano +2, no se puede apilar con otros límites de cartas de la Rueda del Destino. La regeneración de luz de llave del portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Después de jugar una carta, la tasa de crítico, daño crítico, escudo, aliemus y efectos de ganancia de STR de la carta de comando del portador aumentan en <WeaponEffect_Num:[StateArg2]%>, apilándose hasta 5 capas."
  },
  State_66703_WeaponDesc = {
    Text = "El límite de acumulación de energía de llave de plata aumenta en un 100%. Tamaño máximo de la mano +2, no se puede apilar con el tamaño máximo de la mano proporcionado por otras ruedas del destino. La regeneración de llave de plata del portador aumenta en <WeaponEffect_Num:[DescArg2]>. Después de que el portador juegue una carta, la probabilidad de crítico y el daño crítico de las cartas de comando del portador en este turno, así como el blindaje, la alienación y la fuerza, aumentan en <WeaponEffect_Num:[StateArg2]%>, apilándose hasta un máximo de 5 capas (actualmente [DescArg1] capas)."
  },
  State_66722_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equipar y al inicio del turno, si no hay <PVPProtectiveKeywords:barrera>, obtén [StateArg1] capas de <PVPProtectiveKeywords:barrera>; de lo contrario, gana <StrengthenKeywords:mejorar>."
  },
  State_66722_Name = {
    Text = "Rueda Oculta"
  },
  State_66872_Desc = {
    Text = "El daño, escudo y recuperación de vida causados por Tawil aumentan en [StateArg1]% temporalmente, durando [Layer] turnos."
  },
  State_66872_Name = {
    Text = "Brillo Infinito de Billones"
  },
  State_66884_Desc = {
    Text = "Al final del turno, se reduce el coste de potencia, y al ser descartado, también activará este efecto"
  },
  State_66884_Name = {
    Text = "<PrepareKeypvewords:preparar 1>"
  },
  State_66888_Desc = {
    Text = "Equipo Único: Después de liberar la llave, obtiene <WeaponEffect_Num:[StateArg1]%> de <PowerIconKeywords:Fuerza> y un escudo equivalente a <WeaponEffect_Num:[StateArg2]%> de la defensa del portador. Tras usar el Cuerpo de Gnosis de Emergencia, al final del turno todos los Despertados reciben <WeaponEffect_Num:[StateArg3]> puntos de Alienación."
  },
  State_66888_Name = {
    Text = "Corazón de Plata Pura"
  },
  State_66888_WeaponDesc = {
    Text = "Después de liberar la orden clave, obtén <WeaponEffect_Num:[Power:DescArg1]> puntos de <PowerIconKeywords:fuerza> y <WeaponEffect_Num:[Block:DescArg2]> puntos de blindaje. Al usar el Cuerpo de Gnosis de Emergencia, al final del turno, todos los Despertados obtienen <WeaponEffect_Num:[StateArg3]> puntos de alienación."
  },
  State_66893_Desc = {
    Text = "Equipo único: Después de que comience la batalla, obtén energía de llave de plata equivalente al <WeaponEffect_Num:[StateArg1]%> de recarga de llave del portador. Después de liberar la llave por primera vez en cada batalla, repite este efecto."
  },
  State_66893_WeaponDesc = {
    Text = "Después de que comience la batalla, se obtienen <WeaponEffect_Num:[DescArg1]> puntos de energía-s de llave de plata. Al liberar la llave de suela por primera vez en cada batalla, se repite este efecto"
  },
  State_66896_WeaponDesc = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_66900_Desc = {
    Text = "El daño, la curación y el escudo causados por esta carta aumentan en [StateArg1]%"
  },
  State_66900_Name = {
    Text = "Corazón de Plata Pura"
  },
  State_66901_Desc = {
    Text = "El Daño causado, la Cicatrización y los efectos de Escudo del personaje aumentan en [DescArg1]%, durando 1 turno"
  },
  State_66901_Name = {
    Text = "Efecto temporal fuerte"
  },
  State_66902_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Después de que un aliado Cuerpo Despertado muera, obtén <Block:[Block:StateArg1]> Escudo del personaje, coloca en tu mano su carta de \"Habilidad\" con menor coste."
  },
  State_66902_Name = {
    Text = "Corazón de Plata Pura"
  },
  State_66971_Desc = {
    Text = "Cuando la vida baje a 0, se fijará en 1 punto y no recibirá más daño"
  },
  State_66971_Name = {
    Text = "Mundo cortado"
  },
  State_67234_Desc = {
    Text = "Al final del turno, invoca un \"Cerebro en un frasco clonado\", que dura [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_67234_Name = {
    Text = "Separación"
  },
  State_67235_Desc = {
    Text = "Al morir, restaura toda la vida, aumenta el límite de vida en un 100%, y libera \"Plaga del Alma\""
  },
  State_67235_Name = {
    Text = "No Activado"
  },
  State_67237_Desc = {
    Text = "Al alcanzar el nivel 10, la intención cambia a \"final de ilusión\": reduce el límite de vida del oponente a 1"
  },
  State_67237_Name = {Text = "Fin"},
  State_67238_Desc = {
    Text = "Al final del turno, obten 1 capa de \"Apocalipsis\". Si se recibe daño letal, elimina este estado e inmuniza daños por 1 turno, recupera 15% de vida y obtén 10 capas de \"Apocalipsis\""
  },
  State_67238_Name = {
    Text = "Plaga del alma"
  },
  State_67240_Desc = {
    Text = "\"El Conocedor\" obtiene 25 niveles temporales de <ReinforcePVEKeywords: Reforzado> y [Power:StateArg1] puntos temporales de <PowerIconKeywords: Poder>, eliminando este estado"
  },
  State_67240_Name = {
    Text = "<TuiyanColour:Proyección>"
  },
  State_67241_Desc = {
    Text = "Al morir, restaura toda la vida, aumenta el límite de vida en un 100%, y libera \"Pasión del Caballero\""
  },
  State_67241_Name = {
    Text = "No Activado"
  },
  State_67242_Desc = {
    Text = "Al morir, restaura toda la vida, aumenta el límite de vida en un 100%, y libera \"Espíritu y Cuerpo @1 minuto\""
  },
  State_67242_Name = {
    Text = "No Activado"
  },
  State_67243_Desc = {
    Text = "Al final del turno, invoca un \"cerebro en un frasco\". Cuando el cerebro en un frasco activa \"separación de conciencia\", roba un 5% adicional del poder del jugador"
  },
  State_67243_Name = {
    Text = "Carne desnatada en 1 capa"
  },
  State_67245_Desc = {
    Text = "Al final del turno, obtén [StateArg1] puntos de <PowerIconKeywords:poder>"
  },
  State_67245_Name = {
    Text = "Celo del caballero"
  },
  State_67246_Desc = {
    Text = "Cada vez que se rompa el escudo por primera vez en cada turno, pierdes el 25% de tu PV Max y obtienes [Power:DescArg1] puntos de <PowerIconKeywords:STR temporal> y [Layer] capas de Fortaleza temporal. Al inicio del siguiente turno, recuperas <Block:[Block:DescArg2]> capas de escudo, y por cada activación de \"Credo del Caballero\" obtienes 1 escudo adicional."
  },
  State_67246_Name = {
    Text = "Credo del Caballero"
  },
  State_67247_Desc = {
    Text = "Al final de cada turno se repondrá a los enemigos, existiendo un máximo de 2 enemigos simultáneamente. Tras la muerte de un enemigo, \"cerebro en putrefacción\" pierde el 5% de la salud máxima"
  },
  State_67247_Name = {
    Text = "Puerta de los Abismos"
  },
  State_67252_Desc = {
    Text = "Al recibir daño fatal, se trasladará a la fila trasera y mantendrá 1 punto de vida, después no podrá recibir más daño; <PowerIconKeywords:poder> aumentará [DescArg1]. La autoinmolación no activará este efecto"
  },
  State_67252_Name = {
    Text = "Separación de esencia"
  },
  State_67253_Desc = {
    Text = "Después de jugar [Layer] cartas, genera un \"Cerebro en un frasco\" en la parte delantera, con un máximo de 3 copias existentes al mismo tiempo"
  },
  State_67253_Name = {
    Text = "Cerebro en un Frasco"
  },
  State_67255_Desc = {
    Text = "Al morir, restaura toda la vida, aumenta el límite de vida en un 100%, y libera \"Primera Filosofía\""
  },
  State_67255_Name = {
    Text = "No Activado"
  },
  State_67256_Desc = {
    Text = "Después de la fase de robos, muestra aleatoriamente tres cartas de comando de tu mano, elige una para otorgar la plegaria \"Eco\" y descarta las otras cartas"
  },
  State_67256_Name = {
    Text = "Primera Doctrina"
  },
  State_67257_Desc = {
    Text = "Después de liberar la llave por primera vez en cada turno, todos los despertadores obtienen 10 aliemus, pero el costo de liberar la llave aumenta permanentemente en un 10%"
  },
  State_67257_Name = {
    Text = "Enlace que se rompe gradualmente"
  },
  State_67258_Desc = {
    Text = "Al comenzar la batalla, recibe <Block:[Block:DescArg1]> capas de escudo. Al final del turno, el escudo no desaparecerá"
  },
  State_67258_Name = {
    Text = "Resolución del Caballero"
  },
  State_67347_Desc = {
    Text = "Mientras esté en la mano, si la carta de la parte superior del mazo es una carta de comando, se convierte en una copia con un coste aritmético de -1"
  },
  State_67347_Name = {
    Text = "Verdad omnisciente"
  },
  State_67353_Desc = {
    Text = "Después de la muerte, \"Cerebro en Descomposición\" pierde el 5% de la salud máxima"
  },
  State_67353_Name = {Text = "Fusión"},
  State_67358_Desc = {
    Text = "Cada vez que el jugador consuma 1 punto de aritmética, obtendrá instantáneamente <Block:[Block:StateArg1]> puntos de escudo y 3 capas de refuerzo temporal"
  },
  State_67358_Name = {
    Text = "Barrera inestable"
  },
  State_67414_Desc = {
    Text = "Ojos que no pueden ser mirados. Un aliento que no puede ser desobedecido. Los fragmentos que logran hacer todo son solo fragmentos. Ahora, enfrentemos el destino de la destrucción inminente"
  },
  State_67414_Name = {
    Text = "Enfrenta miles de Orígenes"
  },
  State_67418_Desc = {
    Text = "Juega esto y descarta todas las demás cartas excepto este despertador, ganando 5 cartas aleatorias que no son despertadores; esto solo tiene efecto una vez por batalla."
  },
  State_67418_Name = {
    Text = "<WhiteQuality: principio de placer avanzado>"
  },
  State_67419_Desc = {
    Text = "Después de jugar, obtén 3 copias base con <RetainIconKeywords:retain> y <DepleteIconKeywords:exhaust> y reduce su coste de Aritmética en 1, teniendo efecto solo una vez por batalla."
  },
  State_67419_Name = {
    Text = "<WhiteQuality: principio de cría avanzada>"
  },
  State_67420_Desc = {
    Text = "Después de jugar, roba 4 cartas y reduce su coste de Aritmética por el coste real de la carta de Plegaria, teniendo efecto solo una vez por batalla."
  },
  State_67420_Name = {
    Text = "<WhiteQuality:Adv. Lex Nous>"
  },
  State_67598_Desc = {
    Text = "Tras liberar la exhalación de aliemus, coloca una carta aleatoria correspondiente al despertador en tu mano, esa carta obtiene <DepleteIconKeywords:agotamiento> y <NothingnessIconKeywords:ilusión>. Al final del combate, recupera [DescArg1] puntos de vida"
  },
  State_67598_Name = {
    Text = "Caso del médico"
  },
  State_67599_Desc = {
    Text = "Después de Jugar una Tarjeta de comando que no sea \"golpear\" o \"defensa\", el Cuerpo Despertado correspondiente obtiene 15 puntos de Aliemus, activándose hasta 5 veces por turno. La primera vez que se active por turno, la carta jugada será devuelta a la mano."
  },
  State_67599_Name = {
    Text = "Péndulo Temporal·Proyectil"
  },
  State_67600_Desc = {
    Text = "Aumenta el límite de aritmética máxima en 4, cada vez que se reinicie el mazo se agregarán 4 <DerivativeCardKeywords_4:\"inspiración\"> a la pila de robos"
  },
  State_67600_Name = {
    Text = "Bendito·Vela negra"
  },
  State_67602_Name = {Text = "abandonado"},
  State_67603_Desc = {
    Text = "Inflige un 20% más de daño a enemigos con estados negativos, y el asesino obtiene 20 de locura al matar"
  },
  State_67603_Name = {
    Text = "Bastón del Hierofante"
  },
  State_67604_Desc = {
    Text = "Cada vez que juegues una carta de comando perteneciente a un Despertado diferente de la anterior, el Despertado correspondiente obtiene 3 puntos de alienación y acumula 1 nivel de \"Vitalidad\". Al acumular 10 niveles, se eliminan todos los niveles de \"Vitalidad\" y se coloca en la mano una carta de comando aleatoria que reduzca el coste de aritmética en 1 para cada Despertado que tenga \"Consumo\", activándose hasta un máximo de 1 vez por turno."
  },
  State_67604_Name = {
    Text = "Péndulo Temporal·Evolución"
  },
  State_67605_Desc = {
    Text = "Cuando tengas un escudo, esa reliquia proporcionará [DescArg1] puntos de <PowerIconKeywords:potencia> temporal. Si tu escudo es mayor que la vida actual, proporcionará [DescArg2] puntos adicionales de <PowerIconKeywords:potencia> temporal"
  },
  State_67605_Name = {
    Text = "Abanico de plumas de paloma"
  },
  State_67606_Desc = {
    Text = "Al comienzo del turno, por cada enemigo obtienes 1 aritmética. Cuando matas un enemigo con daño activo, infliges <BleedingIconKeywords:sangrando> equivalente al daño sobrante a los otros enemigos"
  },
  State_67606_Name = {
    Text = "Canción de la mafia"
  },
  State_67607_Desc = {
    Text = "Después de liberar 5 exaltaciones, el despertador que liberó la exaltación obtiene 100 puntos de aliemus"
  },
  State_67607_Name = {
    Text = "Pequeña cuna"
  },
  State_67608_Name = {Text = "abandonado"},
  State_67609_Desc = {
    Text = "Después de liberar la exaltación, pierde el 8% de su vida actual, roba [DescArg1] puntos temporales de <PowerIconKeywords:fuerza> de todos los enemigos, si solo hay 1 enemigo, roba además [DescArg2] puntos temporales de <PowerIconKeywords:fuerza>."
  },
  State_67609_Name = {
    Text = "Pájaro ritual de presagio"
  },
  State_67611_Desc = {
    Text = "Cada 2 turnos duplica el daño recibido por todos los enemigos; en este turno, cada vez que se libera un estallido de locura, dispersa aleatoriamente 1 estado negativo"
  },
  State_67611_Name = {
    Text = "Benditos: Restos del Caminante del Camino"
  },
  State_67612_Desc = {
    Text = "Todos los daños críticos causados por los \"golpes\" aumentan en un 20%. Al recoger, añade una carta <DerivativeCardKeywords_40: \"Momento Hermoso\"> a tu mano"
  },
  State_67612_Name = {
    Text = "Momentos hermosos β"
  },
  State_67614_Desc = {
    Text = "Al inicio de cada turno, todos los despertadores obtienen 25 puntos de aliemus. Al recolectar, la salud máxima se convierte en 1.5 veces"
  },
  State_67614_Name = {
    Text = "Bendito: Pesadilla Manifiesta β"
  },
  State_67615_Desc = {
    Text = "Cada sexta carta de comando jugada hará que retorne del montón de descarte a su mano"
  },
  State_67615_Name = {
    Text = "En el crepúsculo"
  },
  State_67616_Name = {Text = "abandonado"},
  State_67618_Desc = {
    Text = "Al inicio de cada turno, todos los despertadores obtienen 25 puntos de aliemus. Al recolectar, la salud máxima se convierte en 1.5 veces"
  },
  State_67619_Desc = {
    Text = "Límite de cartas en mano aumentado en 5. Al recoger, llena la mano hasta el límite. Al comienzo del turno, roba 1 carta adicional, y al final del turno, descarta todas las cartas de síntoma y de estado en mano, conserva otras cartas"
  },
  State_67619_Name = {
    Text = "Bendito: Grabado Mental β"
  },
  State_67620_Desc = {
    Text = "Al jugar la tercera carta de cada turno, coloca 1 carta <DerivativeCardKeywords_4:\"inspiración\"> en el montón de descarte. Al jugar la sexta carta de cada turno, coloca 1 carta <DerivativeCardKeywords_4:\"inspiración\"> desde el montón de descarte a la mano"
  },
  State_67620_Name = {
    Text = "Luz de la Civilización"
  },
  State_67621_Desc = {
    Text = "Tras liberar la exhalación de aliemus, obtienes [DescArg1] puntos temporales de poder y robas [DescArg1] puntos temporales de <PowerIconKeywords:poder> de todos los enemigos. Si solo hay un enemigo, roba [DescArg2] puntos temporales adicionales de <PowerIconKeywords:poder>"
  },
  State_67621_Name = {
    Text = "Bendito: Pájaro ritual de presagio"
  },
  State_67622_Desc = {
    Text = "Al agotar el último punto de aritmética, obtienes 2 aritméticas. Se puede activar un máximo de 2 veces por turno"
  },
  State_67622_Name = {
    Text = "Motor diferencial"
  },
  State_67623_Desc = {
    Text = "Al recoger, obtienes permanentemente [DescArg1] <PowerIconKeywords:Fuerza>. Cada vez que causas daño, recuperas [DescArg2] puntos de PV, hasta 6 veces por turno."
  },
  State_67623_Name = {
    Text = "Bendito: Beso de Lamprea"
  },
  State_67624_Name = {Text = "abandonado"},
  State_67625_Desc = {
    Text = "Después de que la primera carta de comando se juegue y vaya al montón de descarte en cada turno, se reduce temporalmente el costo de aritmética de esa carta en 1 y se baraja en el montón de robar"
  },
  State_67625_Name = {
    Text = "Silenciar Jukebox"
  },
  State_67626_Desc = {
    Text = "Aumenta el límite de aritmética máxima en 1. Al jugar dos veces seguidas una carta con un consumo de aritmética superior que la anterior, se obtiene 1 punto de aritmética"
  },
  State_67626_Name = {
    Text = "Archivo Arcano"
  },
  State_67628_Name = {Text = "abandonado"},
  State_67630_Name = {Text = "abandonado"},
  State_67631_Desc = {
    Text = "Aumenta el límite de aritmética máxima en 2. Cada vez que se reinicie el mazo se agregarán 1 <DerivativeCardKeywords_9:\"tambalearse\"> a la pila de robos"
  },
  State_67631_Name = {Text = "Vela negra"},
  State_67632_Name = {Text = "abandonado"},
  State_67634_Desc = {
    Text = "Al final del turno, por cada carta no jugada en tu mano, todos los Despertados ganan 2 Locura"
  },
  State_67634_Name = {
    Text = "Escalas inclinadas"
  },
  State_67635_Desc = {
    Text = "Al recoger, todos los despertadores obtienen 50 puntos de aliemus y se barajan 2 cartas <DerivativeCardKeywords_1:\"eco de sombra\"> en la pila de robo"
  },
  State_67635_Name = {
    Text = "Equipo de comunicación +β"
  },
  State_67636_Desc = {
    Text = "Daño crítico +15%. Daño a enemigos con escudo siempre será crítico"
  },
  State_67636_Name = {
    Text = "Principios de la estética"
  },
  State_67637_Desc = {
    Text = "Al comienzo del turno, roba 2 cartas y gana 2 puntos de aritmética. Cada vez que robas 1 carta de comando o un despertar de gnosis, cambia aleatoriamente su coste de aritmética. (0-4)"
  },
  State_67637_Name = {
    Text = "Sombrero del embaucador"
  },
  State_67638_Desc = {
    Text = "Aumenta el daño a enemigos en estado negativo en un 50%, y el asesino obtiene 100 de locura al matar"
  },
  State_67638_Name = {
    Text = "Báculo de sacerdote+"
  },
  State_67639_Desc = {
    Text = "La tasa crítica aumenta un 50%, el daño crítico aumenta un 100%"
  },
  State_67639_Name = {
    Text = "Bendito: Eerie Hook"
  },
  State_67640_Desc = {
    Text = "Tasa crítica y daño crítico aumentan un 100%. Por cada daño causado / daño de tentáculo, en este turno: la tasa crítica y el daño crítico de todos los despertadores disminuyen un 10%, hasta un máximo del 50%. El envenenamiento y el contraataque aumentan un 10%, hasta un máximo del 50%"
  },
  State_67640_Name = {
    Text = "Péndulo temporal·Shift Surge"
  },
  State_67641_Desc = {
    Text = "Tras liberar la exhalación de aliemus, obtienes [DescArg1] puntos temporales de <PowerIconKeywords:poder>"
  },
  State_67641_Name = {
    Text = "Cerradura de hierro"
  },
  State_67643_Desc = {
    Text = "Causa daño activo, gana [DescArg1] puntos de escudo. Al recuperar vida, gana [DescArg2] puntos temporales <PowerIconKeywords:poder>"
  },
  State_67643_Name = {
    Text = "Nuestro hogar"
  },
  State_67645_Desc = {
    Text = "La tasa crítica aumenta un 10%. Después del primer crítico en cada turno, la tasa crítica aumenta un 20% adicional; después del tercer crítico en cada turno, el daño crítico aumenta un 50% adicional"
  },
  State_67645_Name = {
    Text = "Bendición festiva"
  },
  State_67646_Desc = {
    Text = "Al final de la ronda impar, si hay aritmética restante, roba 2 cartas en la siguiente ronda; al final de la ronda par, si hay cartas restantes, obtén 2 aritméticas en la siguiente ronda"
  },
  State_67646_Name = {
    Text = "Disco solar"
  },
  State_67647_Desc = {
    Text = "Cada quinta carta de comando que juegues tendrá efecto dos veces y volverá a tu mano"
  },
  State_67647_Name = {
    Text = "Vino de las Estrellas+"
  },
  State_67649_Desc = {
    Text = "Ocultar la intención del monstruo. Obtén 1 punto de aritmética por cada turno, roba 1 carta"
  },
  State_67649_Name = {
    Text = "Campanilla fascinante"
  },
  State_67650_Desc = {
    Text = "\"El golpe\" y \"DEF\" obtienen 50 puntos de energía de llave de plata adicional. Cada vez que juegues una carta con un costo de aritmética de 2 o más, roba una carta con un costo de aritmética de 1 y haz que su costo disminuya a 0, con un máximo de 3 veces por turno"
  },
  State_67650_Name = {
    Text = "Péndulo temporal·Gemelos"
  },
  State_67651_Desc = {
    Text = "Al recoger, la Maestría de Dominio del equipo aumenta al 150% del valor original. Después de jugar la quinta carta de comando en cada turno, todos los Despertados obtienen 20 puntos de Locura"
  },
  State_67651_Name = {
    Text = "Péndulo Temporal·Impuro"
  },
  State_67653_Desc = {
    Text = "Después de liberar 2 veces elaliemus, todos los despertadores obtienen 8 puntos de aliemus; tras liberarlo 3 veces, todos los despertadores obtienen otros 8 puntos de aliemus"
  },
  State_67653_Name = {
    Text = "Sangre abandonada"
  },
  State_67654_Name = {
    Text = "Activar [DescArg1] veces adicionales"
  },
  State_67656_Desc = {
    Text = "La tasa crítica aumenta un 50%, <FragileIconKeywords:frágil> por 3 turnos"
  },
  State_67656_Name = {
    Text = "Gancho espeluznante"
  },
  State_67657_Desc = {
    Text = "Al comienzo del turno, roba 1 carta. Si juegas 2 veces seguidas una carta con el mismo coste de aritmética que la anterior, robas 1 carta adicional, con un máximo de 3 activaciones por turno"
  },
  State_67657_Name = {
    Text = "Dispositivo de Gnosis"
  },
  State_67658_Desc = {
    Text = "Al jugar una carta con un consumo de aritmética de 3, roba 1 carta y obtén 2 de aritmética; al jugar una carta con un consumo de aritmética de 4 o más, el consumo de aritmética de otras cartas en mano disminuye en 1"
  },
  State_67658_Name = {
    Text = "Péndulo temporal·Ojo"
  },
  State_67659_Desc = {
    Text = "Al comienzo del turno, por cada enemigo obtienes 2 aritmética. Cuando matas un enemigo con daño activo, infliges <BleedingIconKeywords:sangrando> equivalente al daño sobrante duplicado a los otros enemigos"
  },
  State_67659_Name = {
    Text = "Canción de la multitud+"
  },
  State_67660_Desc = {
    Text = "Cada tercera vez que se lanza\"golpe\", causa [DescArg1] puntos de daño a todos los enemigos, y los despertadores correspondientes obtienen 15 aliemus"
  },
  State_67660_Name = {
    Text = "Lanceta oxidada"
  },
  State_67661_Desc = {
    Text = "Cada vez que se gaste aritmética, roba 1 carta, siendo efectiva un máximo de 5 veces por turno. Cada vez que se reinicie la biblioteca, se obtienen 2 puntos de aritmética"
  },
  State_67661_Name = {
    Text = "Péndulo temporal·Insomnio"
  },
  State_67662_Desc = {
    Text = "Cada vez que juegas una carta que no sea de Despertado, el Despertado con menos locura obtiene 10 locura"
  },
  State_67662_Name = {
    Text = "Álbum de sellos extranjeros"
  },
  State_67665_Desc = {
    Text = "Aumenta el límite de aritmética en 2. Después de jugar \"golpear\" o \"DEF\", el despertador correspondiente obtiene 5 puntos de alienación. Tras liberar Exaltar, obtén 1 \"golpear\" con consumo de Oblivion del despertador correspondiente, y tras liberar Posse, obtén aleatoriamente 1 \"DEF\" con consumo de Oblivion."
  },
  State_67665_Name = {
    Text = "Péndulo temporal·Ala"
  },
  State_67666_Desc = {
    Text = "Cada vez que causa daño, obtiene [DescArg1] puntos de <PowerIconKeywords:poder> temporal, se puede apilar hasta 3 veces. Cuando las capas están llenas, el efecto se duplica"
  },
  State_67666_Name = {
    Text = "Ágata de filigrana"
  },
  State_67667_Desc = {
    Text = "Después de terminar el turno, todos los despertadores obtienen 5 de aliemus. Por cada 1 de aritmética restante, todos los despertadores obtendrán 3 de aliemus adicionales"
  },
  State_67667_Name = {
    Text = "Batería Proto"
  },
  State_67668_Desc = {
    Text = "Incremento del daño crítico del 15%. La tasa crítica de \"golpe\" aumenta un 40%"
  },
  State_67668_Name = {
    Text = "Pico de cuervo marfil"
  },
  State_67669_Name = {Text = "abandonado"},
  State_67670_Desc = {
    Text = "Tras liberar la exhalación de aliemus, roba 1 carta. Si la vida es inferior al 25%, roba 1 carta adicional"
  },
  State_67670_Name = {
    Text = "Rueda del conocimiento"
  },
  State_67671_Desc = {
    Text = "Cada vez que se causa 1 daño activo, se recupera [DescArg1] PV y se aplica a la meta [DescArg2] capas <BleedingIconKeywords:sangrando>."
  },
  State_67671_Name = {
    Text = "Bendito: Mente de enjambre"
  },
  State_67672_Desc = {
    Text = "El efecto de <WeaknessIconKeywords:debilidad> causado aumenta un 8%, el efecto de <VulnerabilityIconKeywords:vulnerable> aumenta un 25%. Al aplicar <WeaknessIconKeywords:debilidad> o <VulnerabilityIconKeywords:vulnerable>, roba temporalmente [DescArg1] puntos de <PowerIconKeywords:fuerza>."
  },
  State_67672_Name = {
    Text = "Foto desvanecida+"
  },
  State_67673_Desc = {
    Text = "Al inicio del turno, roba 1 carta"
  },
  State_67673_Name = {
    Text = "Brújula del norte verdadero"
  },
  State_67674_Desc = {
    Text = "Cada vez que juegues 1 tarjeta de comando, obtendrás [DescArg2]% de <DeathResistanceIconKeywords:Resistencia a la muerte> (en esta fase, cada vez que se activa la Resistencia a la muerte, se reduce a la mitad). Si tu <DeathResistanceIconKeywords:Resistencia a la muerte> es mayor o igual al 100%, obtendrás [DescArg1] puntos de <PowerIconKeywords:fuerza> temporalmente."
  },
  State_67674_Name = {
    Text = "Cáscara de serpiente"
  },
  State_67675_Desc = {
    Text = "Al final del turno, si hay potencia restante, roba 2 cartas adicionales en el próximo turno; si hay cartas restantes, obtén 2 puntos adicionales de potencia en el próximo turno"
  },
  State_67675_Name = {
    Text = "Rueda del Sol y la Luna+"
  },
  State_67677_Desc = {
    Text = "Cuando causas <WeaknessIconKeywords:debilidad>, obtienes [DescArg1] puntos de escudo; cuando causas <VulnerabilityIconKeywords:vulnerable>, obtienes [DescArg2] puntos de <PowerIconKeywords:fuerza> temporal. Si desencadenas estos dos efectos en un mismo turno, obtienes adicionalmente [DescArg1] puntos de escudo y [DescArg2] puntos de <PowerIconKeywords:fuerza> temporal."
  },
  State_67677_Name = {
    Text = "Marco dorado"
  },
  State_67703_Desc = {
    Text = "Al comienzo del turno, si el número de cartas en mano del turno anterior es mayor a 3, obtén 2 de aritmética"
  },
  State_67703_Name = {
    Text = "Insignia de Mythag"
  },
  State_67704_Desc = {
    Text = "Al liberar la exaltación, el despertador correspondiente obtiene 10 locura y [DescArg1] puntos de escudo"
  },
  State_67704_Name = {
    Text = "Velo de la Deidad sin Nombre"
  },
  State_67796_Name = {
    Text = "<TongxiaoKeywords:Conocimiento de todos los principios>：Después de jugar, restaurar y obtener <Energy:[StateArg1]> puntos de aliemus"
  },
  State_67841_WeaponDesc = {
    Text = "Cambia el gasto de aritmética de la carta antes de jugar"
  },
  State_67844_Desc = {
    Text = "Reestablecer toda la vida después de recibir daño fatal, puede activarse @1 vez, actualmente ha sido activado [DescArg1] veces"
  },
  State_67844_Name = {
    Text = "Caos Antiguo"
  },
  State_67866_Name = {
    Text = "<BleedingColour: sangrando>"
  },
  State_68298_Desc = {
    Text = "Al recibir daño letal, cambia la intención a \"Mirada del Vacío\" y obtén 80 capas de reforzado temporal, recuperando toda la vida. Puede activarse [DescArg1] veces. Al final del turno, se eliminan 20 capas de reforzado."
  },
  State_68298_Name = {
    Text = "Polvo de estrellas"
  },
  State_68554_Desc = {
    Text = "Reestablecer toda la vida después de recibir daño fatal y eliminar este estado cuando todos los demás enemigos mueran. Puede activarse @1 vez, actualmente ha sido activado [DescArg1] veces."
  },
  State_68554_Name = {
    Text = "Fragmentos de Caos Antiguo"
  },
  State_68621_Desc = {
    Text = "Al inicio del combate y al final de cada turno, obtiene 2 capas temporales de <ResentChainsKeywords:Cadena de Rancor>."
  },
  State_68621_Name = {
    Text = "Flujo Eerie"
  },
  State_68622_Desc = {
    Text = "El efecto de <PowerIconKeywords:fuerza> aplicado a los Despertados se reduce en un 75%. Cada vez que pierdes vida, obtienes [DescArg1] puntos de escudo y 1 capa de fortificación temporal."
  },
  State_68622_Name = {
    Text = "Flujo de la Fe Perversa"
  },
  State_68623_Desc = {
    Text = "Cada vez que juegues 1 carta de comando, descarta 1 carta de este despertador con el consumo de aritmética más bajo."
  },
  State_68623_Name = {
    Text = "Flujo de Locura"
  },
  State_68624_Desc = {
    Text = "Al final del turno, restaura el 10% de los puntos de vida perdidos, elimina los estados negativos propios y los estados positivos del jugador."
  },
  State_68624_Name = {
    Text = "Corriente de la Aparición"
  },
  State_68626_Desc = {
    Text = "Todos los Cuerpos Despertados aumentan su Aliemus Base en un 50%. Al final de cada turno, todos los Cuerpos Despertados pierden 10 puntos de Aliemus y recuperan el 3% de sus PV Max."
  },
  State_68626_Name = {
    Text = "Flujo de Terror"
  },
  State_68627_Desc = {
    Text = "Al comenzar la batalla, obtén 15 capas de \"barrera temporal\". Al final del turno, obtén 15 capas de \"barrera temporal\" y aplica \"disolución temporal\" a 10 cartas aleatorias."
  },
  State_68627_Name = {
    Text = "Corriente Gélida"
  },
  State_68632_Desc = {
    Text = "El consumo de aritmética de todas las cartas de comando aumenta en 1. Cada 3 turnos, al finalizar el turno, coloca 1 carta de \"Petrificación gradual\" en tu mano."
  },
  State_68632_Name = {
    Text = "Torrente de Lamentos"
  },
  State_68635_Name = {
    Text = "Núcleo de Plata Pura· miedo"
  },
  State_68637_Desc = {
    Text = "Cuando se pierde vida, se reduce la cantidad de capas correspondientes. Al llegar a 0 capas, el jugador obtiene 2 capas de barrera temporal, el personaje obtiene [DescArg1] capas de escudo y [DescArg2] capas de refuerzo temporal, y recupera [DescArg3] capas de barrera dimensional."
  },
  State_68637_Name = {
    Text = "Barrera dimensional"
  },
  State_68638_Name = {
    Text = "Núcleo de Plata Pura· Herejía"
  },
  State_68646_Desc = {
    Text = "El daño base y el valor de escudo aumentan en un 200%, pero la carta se consume al jugarla."
  },
  State_68646_Name = {
    Text = "<RedQuality1:Disolución Temporal>"
  },
  State_68647_Name = {
    Text = "\"Núcleo de tono puro · Locura\""
  },
  State_68680_Desc = {
    Text = "Eliminar Esquirlas Antiguas"
  },
  State_68680_Name = {
    Text = "Eliminar Esquirlas Antiguas"
  },
  State_68704_Desc = {
    Text = "Quedan [DescArg1] rondas para que Tohuwabohu descienda realmente..."
  },
  State_68704_Name = {Text = "Llegada"},
  State_68829_Desc = {
    Text = "Al recibir Daño Activo o Daño de tentáculos, inmune al daño y pierde 1 carga. Se elimina al inicio del turno."
  },
  State_68829_Name = {
    Text = "<ParcloseColour:Barrera temporal>"
  },
  State_68829_WeaponDesc = {
    Text = "El daño recibido -99%. Cada vez que se recibe daño, pierde 1 Acumulación."
  },
  State_70026_Desc = {
    Text = "Esta carta posee \"Mantén\". Después de jugarla, aumenta temporalmente la tasa crítica de todos los Despertados en [StateArg1]% y elimina \"Dominio Inmortal\". Si el reino actual es \"Mar Profundo\", tras eliminar \"Dominio Inmortal\" obtén 1 punto de aritmética."
  },
  State_70026_Name = {
    Text = "<OrangeQuality:Dominio Inmortal>"
  },
  State_70031_Desc = {
    Text = "Equipo único: Al comenzar la batalla, otorga a todas las cartas de comando del portador en el mazo de robo con un coste de aritmética mayor o igual a 3 el efecto de \"Dominio Inmortal\": esta carta posee \"Retener\". Después de jugarla, aumenta temporalmente la tasa de crítico de todos los Despertados en <WeaponEffect_Num:[StateArg1]%> y elimina \"Dominio Inmortal\". Si el reino actual es Aequor, tras eliminar \"Dominio Inmortal\", obtén 1 punto de aritmética."
  },
  State_70031_WeaponDesc = {
    Text = "Al comenzar la batalla, otorga a todas las cartas de comando del portador en el mazo de robo con un coste de aritmética mayor o igual a 3 el efecto de \"Dominio Inmortal\": esta carta posee \"Retener\", al jugarla, la tasa de crítico temporal de todos los Despertados aumenta en <WeaponEffect_Num:[StateArg1]%> y se elimina \"Dominio Inmortal\". Si el reino actual es Aequor, tras eliminar \"Dominio Inmortal\", obtén 1 punto de aritmética."
  },
  State_70182_Desc = {
    Text = "Todos los escudos obtenidos se reducen en un [DescArg1]%"
  },
  State_70182_Name = {
    Text = "<FragileColour:Frágil>"
  },
  State_70182_WeaponDesc = {
    Text = "Todos los escudos obtenidos se reducen en un 33%"
  },
  State_70277_Desc = {
    Text = "Al recibir Daño Activo o Daño de tentáculos, el [StateArg1]% del daño se convertirá en cantidad de recuperación para el Horno Carmesí, durante [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_70277_Name = {
    Text = "Rito de Creación"
  },
  State_70287_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al final del turno, aumenta el Daño, la Cicatrización y el Escudo del personaje de las cartas de \"Habilidad\" del Portador en tu mano en un [StateArg1]%."
  },
  State_70287_Name = {
    Text = "Trono de piedra azul"
  },
  State_70288_Desc = {
    Text = "El daño, la curación y el escudo causados por esta carta aumentan en [DescArg1]%."
  },
  State_70288_Name = {
    Text = "Trono de piedra azul"
  },
  State_70313_Desc = {
    Text = "Durante la batalla contra el jefe, al inicio del turno y después de que \"Dor derretida\" libere su exhalación de aliemus, obtén 1 capa de \"<Zhongmowuqiling:Fin>\". \"Fin\" puede tener un máximo de 10 capas; al alcanzar las 10 capas, coloca 1 carta \"Fin de la Nulidad\" en tu mano."
  },
  State_70313_Name = {
    Text = "Camino de la Aniquilación"
  },
  State_70318_Desc = {
    Text = "Inflige [StateArg1] <plural value=\"[StateArg1]\" singular=\"turno\" plural=\"turnos\"> de <VulnerabilityIconKeywords:Vulnerable> a todos los enemigos, obtén 1 turno del estado \"Elación\": Amplificación de Daño del equipo +[StateArg2]%."
  },
  State_70318_Name = {Text = "Elación"},
  State_70322_Desc = {
    Text = "Al tener 10 capas de \"Apocalipsis\", coloca 1 carta \"Fin de la nulidad\" en tu mano."
  },
  State_70322_Name = {Text = "Fin"},
  State_70330_Desc = {
    Text = "Obtén 1 turno del estado \"Elación\": la Amplificación de Daño del equipo aumenta en [Arg2] %."
  },
  State_70330_Name = {Text = "Elación"},
  State_70346_Desc = {
    Text = "Aplica [StateArg1] turnos de <WeaknessIconKeywords:debilidad> a todos los enemigos y haz que reduzcan [Exhaustion:StateArg3] puntos de <PowerIconKeywords:fuerza> en este turno."
  },
  State_70346_Name = {Text = "Maldición"},
  State_70347_Desc = {
    Text = "Hacer que todos los enemigos reduzcan [Exhaustion:StateArg3] puntos de <PowerIconKeywords:fuerza> en este turno."
  },
  State_70347_Name = {Text = "Maldición"},
  State_70374_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Las primeras [StateArg1] veces por turno que el Portador recibe un ATQ, causa <PVPEmptinessKeywords:Vacío> al atacante."
  },
  State_70374_Name = {
    Text = "Títere del Vacío"
  },
  State_70379_Desc = {
    Text = "Inflige <PVPEmptinessKeywords:Vacío> al atacante. Elimina este Estado tras recibir un Ataque."
  },
  State_70379_Name = {
    Text = "Contrataque de Vacío"
  },
  State_70443_Desc = {
    Text = "Al tener 10 capas de \"Apocalipsis\", coloca 1 carta \"Fin de la nulidad\" en tu mano."
  },
  State_70443_Name = {Text = "Fin"},
  State_70539_Name = {
    Text = "Plaga del alma"
  },
  State_70589_Desc = {
    Text = "Al jugar consecutivamente 2 cartas con un consumo de aritmética menor que la carta anterior, aplica 40/80 capas de veneno a todos los enemigos, con un máximo de 5 activaciones por turno."
  },
  State_70590_Desc = {
    Text = "Cada turno, al usar embriones directamente por primera vez, el daño activo causará sangrado equivalente al 15/30% del daño infligido en este turno."
  },
  State_70593_Desc = {
    Text = "Después de jugar una carta de comando no derivada, baraja 1/2 copias temporales de esa carta con un costo de aritmética reducido en 2 en el mazo de robar, con un enfriamiento de 3 turnos."
  },
  State_70594_Desc = {
    Text = "Al final del turno, si estás en la postura \"marea creciente\", obtén 32/64 puntos de daño de tentáculo. Tiene un tiempo de enfriamiento de 3 turnos."
  },
  State_70595_Desc = {
    Text = "Al comenzar la batalla, aplica 1280 capas de veneno a todos los enemigos. En la batalla contra el jefe, el efecto se duplica."
  },
  State_70598_Desc = {
    Text = "Cada vez que una carta entra en el espacio dimensional, si esta carta pertenece a un propietario diferente de las demás cartas en dicho espacio, coloca 1/2 carta de inspiración en la mano."
  },
  State_70600_Desc = {
    Text = "Al final del turno, recupera 32 puntos de vida."
  },
  State_70600_Name = {
    Text = "Sangre Bendecida"
  },
  State_70602_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, roba 4 cartas."
  },
  State_70603_Desc = {
    Text = "Después de usar el Despertar con la llave plateada, todos los Despertados obtienen 10 puntos de Locura."
  },
  State_70605_Desc = {
    Text = "Tras utilizar el Despertar de la llave plateada, obtén 32 puntos de fuerza."
  },
  State_70607_Desc = {
    Text = "Al jugar consecutivamente 2 cartas con un consumo de aritmética mayor que la carta anterior, obtienes 24/48 puntos de contraataque, con un máximo de 5 activaciones por turno."
  },
  State_70609_Desc = {
    Text = "Tras usar el Despertar de la llave plateada, obtén 96 puntos de escudo."
  },
  State_70609_Name = {
    Text = "Especimen de mariposa"
  },
  State_70611_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, el daño base causado por todos los Despertados aumenta un 25%/50%."
  },
  State_70614_Name = {
    Text = "Mandíbula láser+"
  },
  State_70617_Desc = {
    Text = "Los primeros cinco daños causados en cada turno aumentan un 15%/30%."
  },
  State_70618_Desc = {
    Text = "Al inicio del turno, roba 1 carta"
  },
  State_70619_Desc = {
    Text = "\"Golpe\"causa un envenenamiento equivalente al 10%/20% del daño infligido, con un máximo de 320/640 puntos por turno."
  },
  State_70620_Desc = {
    Text = "Cuando recibes un ataque del enemigo, este sufre 1 vez de daño fijo equivalente al 25%/50% de tu vida máxima, este daño tiene un bono de contraataque del 100%/200%, pudiendo activarse un máximo de 1 vez por enemigo por turno."
  },
  State_70620_Name = {
    Text = "Cuchillo Ritual Perdido"
  },
  State_70621_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén 192 puntos de escudo."
  },
  State_70621_Name = {
    Text = "Ejemplar de mariposa+"
  },
  State_70623_Desc = {
    Text = "Al inicio de cada turno, todos los despertados obtienen 10 puntos de locura"
  },
  State_70624_Desc = {
    Text = "Después de usar el Despertar con la Llave Plateada, todos los Despertados obtienen 20 puntos de Locura."
  },
  State_70628_Desc = {
    Text = "Al inicio del turno, roba 2 cartas."
  },
  State_70629_Desc = {
    Text = "Cada vez que se realiza una devoración por primera vez en el turno, los demás Despertados obtienen 10/20 puntos de locura."
  },
  State_70635_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén 416 puntos de contraataque."
  },
  State_70636_Desc = {
    Text = "Cuando pierdes vida, obtén un 10%/20% de la vida perdida como recuperación en el Horno Carmesí."
  },
  State_70637_Desc = {
    Text = "Al comenzar la batalla, el límite de tentáculos aumenta en 1/2, obtén 1/2 tentáculo."
  },
  State_70641_Desc = {
    Text = "Aniquilación obtiene 160/320 escudos, 3 turnos de enfriamiento."
  },
  State_70641_Name = {
    Text = "Reloj de Cuerda Suprema"
  },
  State_70643_Desc = {
    Text = "Al comienzo del turno, obtén 1 aritmética"
  },
  State_70644_Desc = {
    Text = "Tras liberar la exhalación de aliemus, obtienes 16/32 puntos temporales de poder."
  },
  State_70645_Desc = {
    Text = "Al comienzo del turno, obtén 2 puntos de aritmética."
  },
  State_70646_Name = {
    Text = "Cuchillo Ritual Perdido+"
  },
  State_70647_Desc = {
    Text = "El daño base de todos los Despertados aumenta un 30%."
  },
  State_70648_Desc = {
    Text = "Al comenzar la batalla, aplica 640 capas de <IntoxicationIconKeywords:veneno> a todos los enemigos. En la batalla contra el jefe, el efecto se duplica."
  },
  State_70656_Desc = {
    Text = "\"Golpe\"causa un daño adicional equivalente a 1,5 veces el 60% del ataque del Despertar, con un máximo de 3 activaciones por turno."
  },
  State_70657_Desc = {
    Text = "Al comenzar la batalla, obtén 32 puntos de poder."
  },
  State_70660_Desc = {
    Text = "Al comenzar la batalla, obtén 64 puntos de poder."
  },
  State_70661_Desc = {
    Text = "Al final del turno, recupera 64 puntos de vida."
  },
  State_70661_Name = {
    Text = "Sangre de Gracia+"
  },
  State_70662_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén 2 puntos de aritmética."
  },
  State_70664_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén 16 puntos de fuerza."
  },
  State_70666_Desc = {
    Text = "Tras el inicio de la batalla, obtén 100/200 de maestría en dominios. El envenenamiento base causado por todos los Despertados y el envenenamiento causado por las creaciones aumenta un 10%/20%."
  },
  State_70667_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, obtén 4 puntos de aritmética."
  },
  State_70670_Desc = {
    Text = "Al comenzar la batalla, obtén 320 puntos de contraataque. En la batalla contra el jefe, el efecto se duplica."
  },
  State_70671_Desc = {
    Text = "Tras entrar en un turno ultra, la primera carta de comando no derivada que juegues tendrá un efecto adicional de 1/2 vez."
  },
  State_70678_Desc = {
    Text = "Al comenzar la batalla, obtén 640 puntos de contraataque. En la batalla contra el jefe, el efecto se duplica."
  },
  State_70681_Desc = {
    Text = "El daño base de todos los Despertados aumenta un 60%."
  },
  State_70682_Desc = {
    Text = "Cuando el número de cartas en la mano es menor o igual a 2, roba 1 carta o 2 cartas, con un máximo de 2 activaciones por turno."
  },
  State_70683_Desc = {
    Text = "Aniquilación hace que el cuerpo despertado con menos locura obtenga 50/100 puntos de locura. Tiene 3 turnos de enfriamiento."
  },
  State_70684_Desc = {
    Text = "Al comienzo del turno, si la vida está por debajo del 25%, obtén 72/144 puntos de fuerza temporal."
  },
  State_70685_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, aplica 416 capas de veneno a todos los enemigos."
  },
  State_70686_Desc = {
    Text = "Tras desatar Exaltar, todos los enemigos reciben <FixedDamage:DMG Puro> igual al 15%/30% de tu PV Max y son afectados con 10%/20% de Veneno."
  },
  State_70687_Name = {
    Text = "Reloj de Cuerda Suprema+"
  },
  State_70689_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, aplica 832 capas de veneno a todos los enemigos."
  },
  State_70690_Desc = {
    Text = "Tras el inicio de la batalla, obtén 100/200 de maestría en dominios. El contraataque base causado por todos los Despertados y el contraataque causado por las creaciones aumenta un 10%/20%."
  },
  State_70691_Desc = {
    Text = "Cada vez que causas daño, obtienes 4/8 puntos de fuerza temporal, con un máximo de 15 activaciones por turno."
  },
  State_70693_Desc = {
    Text = "La cantidad automática de Fusión Embrionaria obtenida aumenta en un 100%/200%."
  },
  State_70694_Desc = {
    Text = "Después de usar el Despertar de la llave de plata, roba 2 cartas."
  },
  State_70695_Desc = {
    Text = "Al inicio de cada turno, todos los Despertados obtienen 5 puntos de locura."
  },
  State_70696_Desc = {
    Text = "Tras usar el Despertar de la llave plateada, obtén 208 puntos de contraataque."
  },
  State_70698_Desc = {
    Text = "DEF obtiene 200/400 puntos de contraataque temporal, activándose un máximo de 3 veces por turno."
  },
  State_70804_Name = {
    Text = "Límite de vida o muerte"
  },
  State_70805_Desc = {
    Text = "Al comenzar la batalla, aplica 1/2 capa de debilidad a todos los enemigos; el efecto se duplica contra los jefes. El daño base causado por todos los Despertados aumenta un 15%/30%."
  },
  State_70806_Name = {
    Text = "Mano de la Guardia+"
  },
  State_70808_Desc = {
    Text = "Usa la postura de Mar en Calma para aplicar 64/128 de agotamiento a todos los enemigos, enfriamiento de 3 turnos."
  },
  State_70809_Desc = {
    Text = "Al comienzo del turno, si la vida está por debajo del 25%, obtén 100/200 puntos de blindaje."
  },
  State_70809_Name = {
    Text = "Mano del Guardián"
  },
  State_70810_Desc = {
    Text = "Usa la postura de Olas Furiosas para activar inmediatamente todos los tentáculos y atacar al enemigo 1/2 veces. Tiene un tiempo de enfriamiento de 3 turnos."
  },
  State_70812_Desc = {
    Text = "Al comenzar la batalla, aplica 1/2 capa de vulnerabilidad a todos los enemigos, el efecto se duplica contra el jefe. El daño base causado por todos los Despertados aumenta un 15%/30%."
  },
  State_70832_Desc = {
    Text = "Equipo único: Al comenzar la batalla, el portador obtiene aliemus equivalente al <WeaponEffect_Num:[StateArg1]%> de su recarga de aliemus. Después de liberar exaltar por primera vez en cada batalla, este efecto se repite una vez."
  },
  State_70832_WeaponDesc = {
    Text = "Al comenzar la batalla, el portador obtiene aliemus equivalente al <WeaponEffect_Num:[StateArg1]%> de su recarga de aliemus (<WeaponEffect_Num:[DescArg1]>). Después de liberar exaltar por primera vez en cada batalla, este efecto se repite una vez."
  },
  State_70835_Desc = {
    Text = "Equipo único: El aliemus, el envenenamiento y la recuperación de vida causados por el portador aumentan en <WeaponEffect_Num:[StateArg1]%>. Después de que el portador libere la exaltación, obtiene aliemus equivalente al <WeaponEffect_Num:[StateArg2]%> del aliemus consumido en esta ocasión."
  },
  State_70835_WeaponDesc = {
    Text = "El aliemus, envenenamiento y recuperación de vida causados por el portador aumentan en <WeaponEffect_Num:[StateArg1]%>. Después de que el portador libere la exaltación, obtiene aliemus equivalente al <WeaponEffect_Num:[StateArg2]%> del aliemus consumido en esta ocasión."
  },
  State_70989_Desc = {
    Text = "Después de liberar 4 exaltaciones en un turno, obtén 3/6 puntos de aritmética, con un enfriamiento de 3 turnos."
  },
  State_71001_Desc = {
    Text = "Después de jugar 4 cartas de comando pertenecientes a Despertados diferentes en un mismo turno, todos los Despertados obtienen 20/40 puntos de aliemus. Tiene un tiempo de enfriamiento de 3 turnos."
  },
  State_71153_Desc = {
    Text = "Al inicio de cada turno, Caecus obtiene 15 puntos de aliemus. Cuando Caecus obtiene un escudo, recupera vida equivalente al 50% del valor del escudo."
  },
  State_71154_Desc = {
    Text = "Al comienzo del turno, Eigis obtiene 15 puntos de locura. Cuando Eigis inflige daño a un enemigo con <VulnerabilityIconKeywords:vulnerable>, también le roba 10 puntos de poder temporal, activándose como máximo 5 veces por turno."
  },
  State_71155_Desc = {
    Text = "Al comienzo del turno, Leigh obtiene 15 puntos de aliemus. Cada vez que pierde vida, obtiene 8 puntos de fuerza, acumulable hasta 10 veces por batalla. Al alcanzar las 10 acumulaciones, el costo de aritmética de \"Dolor y placer\" se reduce a 1 y el número de veces de daño aumenta en 1."
  },
  State_71156_Desc = {
    Text = "Al comienzo del turno, Agrippa obtiene 15 puntos de aliemus. \"La caridad impaciente\" también reduce en 1 el coste de aritmética de Agrippa durante este turno y solo puede activarse una vez por turno."
  },
  State_71157_Desc = {
    Text = "Al comenzar el turno, Shan obtiene 15 puntos de locura. Al iniciar la batalla, todas las cartas de comando de Shan reciben \"Retenido\", \"Preparado 1\" y obtienen 24 puntos de escudo."
  },
  State_71157_Name = {
    Text = "Imagen de Dimensión · Sanga"
  },
  State_71158_Desc = {
    Text = "Al comienzo del turno, Muñeca obtiene 15 puntos de aliemus. Después de iniciar la batalla, el costo de aritmética de \"Intercambio equivalente\" de Muñeca se reduce a 0, y al jugarla, en el próximo turno se robarán 2 cartas adicionales."
  },
  State_71159_Desc = {
    Text = "Al inicio del turno, Faros obtiene 15 puntos de aliemus. Por cada daño de tentáculo causado, el envenenamiento causado por Faros en esta batalla aumenta un 1%, hasta un máximo del 100%."
  },
  State_71160_Desc = {
    Text = "Al comienzo del turno, \"24\" obtiene 15 de alienación. Si \"24\" está en \"Personalidad deprimida\" al comienzo del turno, obtiene 25 de alienación adicionales; si está en \"Personalidad maníaca\", aumenta la probabilidad de golpe crítico temporal y el daño crítico temporal de \"24\" en un 35%."
  },
  State_71161_Desc = {
    Text = "Al inicio del turno, Fient obtiene 15 puntos de aliemus. Cada vez que se activa la resistencia a la muerte, el escudo, el contraataque y la recuperación de vida causados por Fient durante esta exploración aumentan un 20%, con un máximo de 5 activaciones."
  },
  State_71162_Desc = {
    Text = "Al comienzo del turno, Goliat obtiene 15 puntos de aliemus. Si Goliat causa daño 3 veces en un mismo turno, el daño que inflige en esta batalla recibirá un bono adicional de fuerza equivalente a 1 vez, con un enfriamiento de 3 turnos."
  },
  State_71163_Desc = {
    Text = "Al comienzo del turno, Helot-catena obtiene 15 puntos de locura. El daño activo de Helot-catena aplica un 20% de <BleedingIconKeywords:sangrado>, y al matar a un enemigo, inflige <BleedingIconKeywords:sangrado> equivalente al daño sobrante a los otros enemigos."
  },
  State_71164_Desc = {
    Text = "Al comenzar el turno, Aurita obtiene 15 puntos de locura. Aumenta en 1 el daño de \"División de glándulas\", y tras jugar una \"DEF\" de Aurita, se añade 1 carta de \"División de glándulas\" a la mano."
  },
  State_71166_Desc = {
    Text = "Al inicio del turno, Lily obtiene 15 puntos de aliemus. El límite de resistencia de Lily aumenta un 100%. Al liberar \"La flor inmortal sobre el lodo\" o \"Golpe para proteger\", recupera el 8% de la vida por cada capa de \"resistencia\"."
  },
  State_71167_Desc = {
    Text = "Al comienzo del turno, Lotan obtiene 15 puntos de aliemus. La primera vez que se juega una \"DEF\" de Lotan en cada turno, se añaden 2 cartas de \"Espada Desafiante\" con costo adicional y vacío al azar a la mano."
  },
  State_71168_Desc = {
    Text = "Al comienzo del turno, Pandia obtiene 15 puntos de locura. Al comenzar el turno, obtiene 64 puntos de contraataque. Por cada 4 puntos de contraataque no temporales, el daño causado por las cartas de comando de Pandia aumenta en 1."
  },
  State_71169_Desc = {
    Text = "Al comienzo del turno, Helot obtiene 15 de locura. Cada vez que se descarta una carta, «Helot» obtiene 5 puntos adicionales de locura."
  },
  State_71170_Desc = {
    Text = "Al comenzar el turno, Tawil obtiene 15 puntos de aliemus. Si se juegan 6 cartas de comando de Tawil en el mismo turno, se añade 1 carta \"llave de plata de luz\" a la mano, con un enfriamiento de 3 turnos."
  },
  State_71171_Desc = {
    Text = "Al inicio del turno, Miriam obtiene 15 puntos de locura y añade 1 carta de \"Sagrado\" a su mano."
  },
  State_71172_Desc = {
    Text = "Al comenzar el turno, Dor el Fusión obtiene 15 puntos de locura. Después de que Dor el Fusión libere la exaltación, por cada 20 puntos de locura consumidos, los otros despertadores obtienen 1 punto de locura."
  },
  State_71173_Desc = {
    Text = "Al inicio del turno, Salvador obtiene 15 puntos de locura. Cada vez que acumules el Horno Carmesí, también obtendrás un 5% del poder acumulado. Los ataques \"Golpe\" y \"Dolor que debe ser eliminado\" de Salvador reciben un bono adicional de poder equivalente a 100%."
  },
  State_71175_Desc = {
    Text = "Al inicio del turno, Nautila obtiene 15 puntos de aliemus. Tras liberar la exaltación de Nautila, obtén un contraataque equivalente al 50% del escudo actual, activándose una vez por turno como máximo."
  },
  State_71177_Desc = {
    Text = "Al comienzo del turno, Liz obtiene 15 puntos de locura. \"Danza de la destrucción\" permite que las cartas descartadas tengan 1 efecto adicional, con un enfriamiento de 3 turnos."
  },
  State_71178_Desc = {
    Text = "Al comenzar el turno, Ramona obtiene 15 puntos de locura. Cada tercera carta de comando que Ramona juega tendrá un efecto adicional una vez."
  },
  State_71179_Desc = {
    Text = "Al comienzo del turno, Uvhash obtiene 15 puntos de aliemus. El costo de locura de Uvhash se reduce en 10 puntos y se reduce en 5 puntos adicionales cada vez que libera una exaltación, pudiendo liberar 2 exaltaciones por turno."
  },
  State_71180_Desc = {
    Text = "Al comienzo del turno, Alva obtiene 15 puntos de locura. Si en el turno anterior Alva jugó 2 cartas \"DEF\", coloca en tu mano 1 carta \"Hoja cortante\" con costo; si jugó 2 cartas \"Golpe\", coloca en tu mano 1 carta \"Postura de combate\" con costo."
  },
  State_71181_Desc = {
    Text = "Al comienzo del turno, Sorel obtiene 15 puntos de Aliemus. Cada vez que Sorel causa daño, la Fusión Embrionaria +10, con un máximo de 10 activaciones por turno. Tras alcanzar las 10 activaciones, el Daño Crítico de Sorel en esta batalla aumenta un 20%."
  },
  State_71182_Desc = {
    Text = "Al inicio del turno, Hameln obtiene 15 puntos de aliemus. El costo de aritmética de \"Obertura del Alma\" se reduce en 1 y el número básico de daño aumenta en 1."
  },
  State_71183_Desc = {
    Text = "Al comenzar el turno, Thais obtiene 15 puntos de locura. Después de que Thais juegue 2 cartas de comando en un mismo turno, obtiene 1 carta <DerivativeCardKeywords_10:Hijo Sagrado> y 72 puntos de <PowerIconKeywords:fuerza> temporal, con un tiempo de enfriamiento de 3 turnos."
  },
  State_71187_Desc = {
    Text = "Al comienzo del turno, Celeste obtiene 15 puntos de locura. Antes de que termine el turno, por cada carta de comando de Celeste en la mano, 1 tentáculo ataca al enemigo y se recuperan 8 puntos de vida."
  },
  State_71188_Desc = {
    Text = "Al comienzo del turno, Murphy obtiene 15 puntos de aliemus. El \"golpe\" y la \"defensa\" de Murphy pueden convertir el 25% del \"sacrificio\" en daño de tentáculo temporal, pero solo pueden activarse una vez por turno."
  },
  State_71189_Desc = {
    Text = "Al comienzo del turno, Nymphaea obtiene 15 puntos de alienación. Tras jugar el \"golpear\" de Nymphaea, aumenta en un 20% el veneno causado por Nymphaea en esta batalla. Tras jugar la \"defensa\" de Nymphaea, activa un veneno del 50% en todos los enemigos. Cada uno puede activarse una vez por turno como máximo."
  },
  State_71190_Desc = {
    Text = "Al inicio del turno, Ogier obtiene 15 puntos de locura. Después de que Ogier juegue por primera vez \"Lanza Perforante\" o \"Golpe\" en el turno, el escudo y la fuerza que Ogier genere durante ese turno aumentan un 50%."
  },
  State_71191_Desc = {
    Text = "Al inicio del turno, Ryker obtiene 15 puntos de locura y 3% de tasa crítica. La primera tirada de dados de cada turno siempre muestra un 6."
  },
  State_71192_Desc = {
    Text = "Al comenzar el turno, Ronda Ramona obtiene 15 puntos de locura. La primera vez que se activa <TimeBeacon:recorrido> en cada turno, obtiene 500 puntos de energía de llave de plata y 1 capa de <TimeBeacon2:negentropía>."
  },
  State_71193_Desc = {
    Text = "Al comienzo del turno, Tulu obtiene 15 de locura. El costo de locura de Tulu se reduce en 10 puntos y, al liberar una explosión de locura, se generan inmediatamente 2 tentáculos temporales."
  },
  State_71194_Desc = {
    Text = "Al comienzo del turno, Karen obtiene 15 puntos de aliemus. Jugar \"Vigilia Silenciosa\" devuelve el doble del coste de aritmética consumido, con un enfriamiento de 3 turnos."
  },
  State_71271_Desc = {
    Text = "Al inicio del turno, Horla obtiene 15 puntos de aliemus. Al inicio de la batalla, obtiene 1 capa de metáfora de cada emoción. El efecto de \"metáfora\" se incrementa en un 50%."
  },
  State_71272_Desc = {
    Text = "Al inicio del turno, Jenkins obtiene 15 puntos de locura y el daño final aumenta un 5%. El daño base y el daño causado por \"¡Marrón, ataca!\" aumentan un 200%."
  },
  State_71273_Desc = {
    Text = "Al comienzo del turno, Dafodil obtiene 15 puntos de locura y 1 carta \"Inspiración\". Cada vez que se juega \"Marea heterogénea\", el poder obtenido aumenta permanentemente en un 25% durante la exploración actual, hasta un máximo del 300%."
  },
  State_71274_Desc = {
    Text = "Al comenzar el turno, Tinctura obtiene 15 puntos de aliemus. Cuando las cartas de comando de Tinctura activan un salto, estas serán devueltas a la mano, con un máximo de 3 activaciones por turno."
  },
  State_71275_Desc = {
    Text = "Al comenzar el turno, Wanda obtiene 15 puntos de locura y 1 capa de \"sueño guía\". Si el turno actual es un turno transdimensional, agrega adicionalmente 1 cadena de púa espina temporal y 1 guardián perdido temporal a la mano."
  },
  State_71276_Desc = {
    Text = "Al comienzo del turno, Erika obtiene 15 puntos de locura. Cuando Erika juega 3 cartas de comando en un mismo turno, obtiene 1 carta \"Inspiración\" y el bono de poder y alerta aplicado a \"Explosión electromagnética\" en esta batalla aumenta en 1."
  },
  State_71277_Desc = {
    Text = "Al comienzo del turno, Casiah obtiene 15 puntos de locura. Cada vez que roba una carta, Casiah obtiene 1 punto adicional de locura. Cuando Casiah libera su exaltación, todos los enemigos pierden 32 puntos de fuerza."
  },
  State_71278_Desc = {
    Text = "Al inicio del turno, Bígaro obtiene 15 puntos de aliemus. Cada vez que otro Despertado libere una exaltación, Bígaro obtiene 5 puntos de aliemus y el costo de aritmética de \"Reconstrucción Espiritual\" en su mano se reduce en 1."
  },
  State_71279_Desc = {
    Text = "La Amplificación de Daño del equipo aumenta en [StateArg1]%, con una duración de [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_71279_Name = {Text = "Elación"},
  State_71503_Name = {
    Text = "\"Forma Final\": roba 3 cartas adicionales, obtén 3 puntos de aritmética, activa el <IntoxicationIconKeywords:veneno> del [DescArg1]% en todos los enemigos, aumenta en 50 el límite máximo de locura de \"Fusión·Muñeca\", máximo 3 veces"
  },
  State_71581_Name = {
    Text = "Afinidad Espiritual"
  },
  State_71589_Name = {
    Text = "Activa 1 tentáculo para atacar al enemigo y restaura 8."
  },
  State_71605_Name = {
    Text = "Obtén [StateArg1] puntos de escudo"
  },
  State_71650_Desc = {
    Text = "Tras morir, revive y convoca una cantidad variable de clones, pero al revivir no obtiene ninguna fortificación ni inmunidad. Puede activarse [Layer] veces."
  },
  State_71650_Name = {
    Text = "Bestia de Myriad Dimensiones"
  },
  State_71651_Desc = {
    Text = "Cada vez que pierdas vida, pierdes [StateArg1] puntos de fuerza temporal. Puede activarse hasta [Layer] veces y se restablece al inicio del turno."
  },
  State_71651_Name = {
    Text = "Sombrero de gentleman"
  },
  State_71707_Desc = {
    Text = "Por cada instancia de Daño Activo recibido, recupera [StateArg1] PV, durante [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_71707_Name = {
    Text = "Caecus: Apoyo"
  },
  State_71708_Desc = {
    Text = "Al final del turno, por cada carta en tu mano, todos los Despertados obtienen [DescArg1] puntos de Locura."
  },
  State_71708_Name = {
    Text = "Kasía·Apoyo"
  },
  State_71709_Desc = {
    Text = "Al final del turno, obtén 35 puntos de locura, durando [Layer] turnos."
  },
  State_71709_Name = {
    Text = "Wenkel·Soporte"
  },
  State_71711_Desc = {
    Text = "El daño causado por el Despertado aumenta un 25%, durando [Layer] turnos."
  },
  State_71711_Name = {
    Text = "Jenkin: Soporte"
  },
  State_71712_Desc = {
    Text = "Al infligir Daño Activo, activa 1 ataque de tentáculos una vez, durante [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turnos\">."
  },
  State_71712_Name = {
    Text = "Aurita·Soporte"
  },
  State_71712_WeaponDesc = {
    Text = "Cuando la luna marina causa daño, hace que [StateArg1] tentáculos ataquen al objetivo"
  },
  State_71713_Desc = {
    Text = "Cada vez que realizas una \"absorción\", robas 2 cartas de \"golpe\" y se reduce su consumo de aritmética en 1, durante [Layer] turnos."
  },
  State_71713_Name = {
    Text = "Shiro·Soporte"
  },
  State_71740_Desc = {
    Text = "Al inicio del próximo turno, obtén [Layer] puntos de escudo"
  },
  State_71740_Name = {
    Text = "Reya Soporte Escudo"
  },
  State_71741_Desc = {
    Text = "Al inicio del próximo turno, obtén un escudo igual a la vida perdida en este turno. El efecto dura [Layer] turnos."
  },
  State_71741_Name = {
    Text = "Leigh: Apoyo"
  },
  State_71741_WeaponDesc = {
    Text = "Al inicio del próximo turno, obtén escudo igual a la vida perdida en el turno anterior"
  },
  State_71742_Desc = {
    Text = "El daño de la carta de golpe aumenta en [Layer]%"
  },
  State_71742_Name = {
    Text = "Shiro·Soporte"
  },
  State_71742_WeaponDesc = {
    Text = "Este turno, el daño de tus cartas de golpe aumenta [Layer]%"
  },
  State_71837_Desc = {
    Text = "Al inicio de la siguiente ronda, obtienes \"vulnerable\"."
  },
  State_71837_Name = {
    Text = "Retraso de vulnerabilidad"
  },
  State_71839_Desc = {
    Text = "Al usar \"despertar\", obtén [Layer] puntos de aritmética. Si el reino actual es \"Mar Profundo\", genera adicionalmente [Layer] tentáculos temporales."
  },
  State_71839_Name = {
    Text = "Protección estelar"
  },
  State_71856_Desc = {
    Text = "Cada vez que pierdas vida, pierdes [StateArg1] puntos de fuerza temporal. Puede activarse hasta [Layer] veces y se restablece al inicio del turno."
  },
  State_71856_Name = {
    Text = "Sombrero de gentleman"
  },
  State_72016_Name = {
    Text = "Maestría de Carne y sangre"
  },
  State_72018_WeaponDesc = {
    Text = "Cada vez que recibes daño, todos los despertados ganan 1 punto de locura"
  },
  State_72033_Name = {Text = "Tentáculo"},
  State_72036_Name = {
    Text = "Inicialización de profesión caótica"
  },
  State_72079_Name = {
    Text = "Olas furiosas"
  },
  State_72102_Desc = {
    Text = "Experiencia clásica de juego de \"Noche del olvido\"."
  },
  State_72102_Name = {
    Text = "Capítulo Olvidado"
  },
  State_72137_Name = {
    Text = "Potencia de cálculo llena"
  },
  State_72206_Name = {
    Text = "Progreso de investigación \"[DescArg1]/15\""
  },
  State_72208_Name = {
    Text = "Progreso de investigación \"[DescArg1]/2\""
  },
  State_72212_Name = {
    Text = "Progreso de investigación \"[DescArg1]/10\""
  },
  State_72213_Name = {
    Text = "Progreso de investigación \"[DescArg1]/30\""
  },
  State_72220_Name = {
    Text = "Progreso de investigación \"[DescArg1]/5\""
  },
  State_73518_Desc = {
    Text = "El daño causado aumenta un 100%. Al perder vida, este estado se elimina, pero se obtiene un escudo equivalente al 50% de la salud máxima."
  },
  State_73518_Name = {Text = "\"Asesino\""},
  State_73520_Desc = {
    Text = "Al morir, conserva 1 punto de vida e inmuniza contra todo daño, transforma la intención en \"Desvinculación\"."
  },
  State_73520_Name = {Text = "\"Conector\""},
  State_73533_Desc = {
    Text = "Al final del turno del jugador, ya no descartes las cartas en mano. Al comenzar la batalla, el límite de cartas en mano del jugador se establece en 8."
  },
  State_73533_Name = {
    Text = "Sentidos de la colmena"
  },
  State_73535_Desc = {
    Text = "Durante tu turno, el daño recibido se reduce en un 75%. Cuando se reduce la fuerza, solo se reduce el 50% de las capas de fuerza."
  },
  State_73535_Name = {
    Text = "Auto-protección"
  },
  State_73566_Desc = {
    Text = "Cada vez que juegues 1 carta que no sea de comando, obtén [Power:StateArg1] puntos de <PowerIconKeywords:fuerza> y <Block:[Block:StateArg2]> puntos de escudo."
  },
  State_73566_Name = {
    Text = "Comunicador"
  },
  State_73567_Desc = {
    Text = "Cada vez que juegues 1 carta que no sea de comando, obtén [Power:StateArg1] puntos de <PowerIconKeywords:fuerza> y <Block:[Block:StateArg2]> puntos de escudo."
  },
  State_73567_Name = {
    Text = "Comunicador"
  },
  State_73570_Desc = {
    Text = "Cada vez que juegues 1 carta que no sea de comando, obtén [Power:StateArg1] puntos de <PowerIconKeywords:fuerza> y <Block:[Block:StateArg2]> puntos de escudo."
  },
  State_73570_Name = {
    Text = "Comunicador"
  },
  State_73573_Desc = {
    Text = "Cada vez que juegues 1 carta que no sea de comando, obtén [Power:StateArg1] puntos de <PowerIconKeywords:fuerza> y <Block:[Block:StateArg2]> puntos de escudo."
  },
  State_73573_Name = {
    Text = "Comunicador"
  },
  State_73649_Desc = {
    Text = "Daño del equipo aumentado eficazmente en [Layer]%"
  },
  State_73649_Name = {
    Text = "Títere del Vacío"
  },
  State_73655_Name = {
    Text = "Forma orgánica del identificador"
  },
  State_73664_Name = {
    Text = "Efecto de forma orgánica de accesorios"
  },
  State_73664_WeaponDesc = {
    Text = "Después de que el portador use exaltar, sus escudos y curas en este turno se duplican"
  },
  State_74012_Desc = {
    Text = "Causa <RealDamage:daño fijo> equivalente al [StateArg1]% de la salud máxima de todos los enemigos (como mínimo [DescArg1]). Tras usar esta habilidad, la habilidad especial de \"Fusión · Dor\" cambia a \"Fin\"."
  },
  State_74012_Name = {
    Text = "El fin de la ilusión"
  },
  State_74013_Desc = {
    Text = "Causa <RealDamage:daño fijo> equivalente al [StateArg1]% de la salud máxima de todos los enemigos, sin que este daño sea menor al 500% de tu propia salud máxima. Tras usar esta habilidad, la habilidad específica \"Fusión · Dor\" cambia a \"Fin\"."
  },
  State_74013_Name = {
    Text = "El fin de la ilusión"
  },
  State_74014_Desc = {
    Text = "Causa <RealDamage:daño fijo> equivalente al [StateArg1]% de la salud máxima de todos los enemigos (este daño no será menor al 500% de tu propia salud máxima), recupera el 30% de la vida perdida, y tras su uso, la habilidad especial de \"Fusión · Dor\" cambia a \"Fin\"."
  },
  State_74014_Name = {
    Text = "El fin de la ilusión"
  },
  State_74015_Desc = {
    Text = "Causa <RealDamage:daño fijo> equivalente al [StateArg1]% de la vida máxima de todos los enemigos (mínimo [DescArg1]), recupera <Heal:[Heal:DescArg2]> puntos de vida y, tras usar esta habilidad, la habilidad especial de \"Fusión · Dor\" cambia a \"Fin\"."
  },
  State_74015_Name = {
    Text = "El fin de la ilusión"
  },
  State_74019_Desc = {
    Text = "Todos los Despertados aumentan el envenenamiento, el contraataque y el daño base causados en [Layer]％."
  },
  State_74019_Name = {
    Text = "Infección de locura"
  },
  State_74142_Desc = {
    Text = "Al comenzar la exploración, aumenta la constitución, el ataque y la defensa en [StateArg1]%"
  },
  State_74142_Name = {
    Text = "Afinidad Espiritual"
  },
  State_74219_Name = {
    Text = "Después de jugar, devuélvela a la mano"
  },
  State_74273_Desc = {
    Text = "Cuando Helot-catena causa daño activo, aplica [StateArg1]% de sangrado que dura [Layer] turnos."
  },
  State_74273_Name = {
    Text = "Grilletes sanguíneos"
  },
  State_74771_Desc = {
    Text = "Valor de locura necesario para liberar 1 exaltación."
  },
  State_74771_Name = {
    Text = "Límite de locura"
  },
  State_74788_Desc = {
    Text = "\n·Existe paradoja: Al comenzar la exploración, el 75% de la Resistencia a la muerte se convierte en un aumento de PV Max, hasta un máximo de 300% de Resistencia a la muerte, aumentando los PV Max en un 10%. Cada vez que se activa la Resistencia a la muerte, añade 1 carta de \"Brillo de llave plateada\" a tu mano. \n·Cicatriz abisal: En la Líder Batalla, la cantidad de vida recuperada de nuestro lado reduce el efecto de recuperación de vida recibido en un 25% cada vez que alcanza el 100% de los PV Max, pero aumenta la cantidad total de Resistencia a la muerte actual multiplicándola por 1,25 (un aumento del 25%), pudiendo activarse hasta 3 veces. \n·Lente prisma: Al comenzar el turno, si el Contador supera el 750% de los PV Max, la cantidad que exceda se reduce a la mitad, y el Contador Permanente puede apilarse hasta un 2250% de los PV Max; si los enemigos están envenenados en más del 1000% de los PV Max, la cantidad que exceda se reduce a la mitad, y el Veneno puede apilarse hasta un 3000% de los PV Max. El aumento de daño obtenido por el Cuerpo Despertado a través del Contador se reduce en un 70%, pero todo el Veneno y el Contador infligen un 10% más. Al comenzar el turno del enemigo, por cada Gnosis activado, se obtiene un Contador Temporal del 25% del Contador Permanente actual y se activa un 25% de Veneno en todos los enemigos. \n·Cono de luz del destino: El número de turnos en que los Monstruos normales liberan \"Mirada\" se convierte en 6 turnos. Todas las batallas tienen un límite de 15 turnos, pero al comenzar el 15º turno, añade 1 carta de \"Límite del cono de luz\" a tu mano: obtienes Llave Plateada hasta el límite de Llave Plateada, y todos los Cuerpos Despertados obtienen Aliemus hasta su Límite de locura."
  },
  State_74788_Name = {
    Text = "(Descartado temporalmente)"
  },
  State_74791_Desc = {
    Text = "\nArmonía Aritmética: Por cada Tarjeta de comando jugada después de la 10.ª en un turno, obtén 1 \"Armonía Aritmética\". Cada acumulación aumenta el coste de la carta en 1 de Aritmética, que luego se convierte en el 100% de la Regeneración de Llave Plateada del Despertado (acumulable). Las acumulaciones se reinician al entrar al Espacio Hiperspacial.\nPotencia de cálculo llena: Al jugar una carta, elimina su efecto de reducción de Coste de Aritmética en este turno. Cuando la Aritmética actual supera 12, cada punto en exceso se convierte en el 300% de la Regeneración de Llave Plateada promedio del equipo.\nArmonía Furiosa: El efecto del aumento de % de Alienación se reduce a la mitad. Cada Exaltar aumenta la Alienación básica en 10. Al final del turno, obtén el 200% de la Regeneración de Llave Plateada promedio del equipo por cada Despertado que no haya Exaltado."
  },
  State_74791_Name = {
    Text = "Energía de la clave equilibrada"
  },
  State_74809_Name = {
    Text = "\"Forma Final\": roba 3 cartas adicionales, obtén 3 puntos de aritmética, activa el <IntoxicationIconKeywords:veneno> del [DescArg1]% en todos los enemigos, aumenta en 50 el límite máximo de locura de \"Fusión·Muñeca\", máximo 3 veces"
  },
  State_74826_Name = {
    Text = "Inflige aleatoriamente [DescArg1] <FixedDamage:DMG Puro> [DescArg2] <plural value=\"[DescArg2]\" singular=\"vez\" plural=\"veces\"> (se beneficia de 1× <PowerIconKeywords:STR>)"
  },
  State_74827_Name = {
    Text = "Este turno, la tasa crítica y el daño crítico de todos los Despertados aumentan un [DescArg1]%"
  },
  State_74828_Name = {
    Text = "Inflige [DescArg1] puntos de daño de veneno a todos los enemigos"
  },
  State_74829_Name = {
    Text = "Inflige <FixedDamage:DMG Puro> a todos los enemigos igual al [DescArg1]% de su PV faltante"
  },
  State_74830_Name = {
    Text = "Obtén [DescArg1] puntos de fuerza"
  },
  State_74831_Name = {
    Text = "Todos los Despertados obtienen [DescArg1] puntos de locura"
  },
  State_74847_Desc = {
    Text = "Equipo único: El daño base de la primera carta de comando utilizada por el portador en cada turno aumenta en <WeaponEffect_Num:[StateArg1]%>. Si entra en el espacio dimensional, el portador obtiene <WeaponEffect_Num:[StateArg2]> puntos de locura."
  },
  State_74847_WeaponDesc = {
    Text = "El daño base de la primera carta de comando utilizada por el portador en cada turno aumenta en <WeaponEffect_Num:[StateArg1]%>. Si el portador entra en el espacio dimensional, obtiene <WeaponEffect_Num:[StateArg2]> puntos de locura."
  },
  State_74879_Name = {
    Text = "Obtén [DescArg1] puntos de aritmética"
  },
  State_74881_Name = {
    Text = "Elige un Despertado para que obtenga [DescArg1] puntos de locura"
  },
  State_74882_Name = {
    Text = "Obtén [DescArg1] puntos de Maestría en dominios"
  },
  State_74883_Name = {
    Text = "La próxima [DescArg1] carta jugada obtendrá [DescArg2] puntos adicionales de energía clave"
  },
  State_74884_Name = {
    Text = "El veneno, contraataque y sangrado causados en este turno aumentan en [DescArg1]%"
  },
  State_74885_Name = {
    Text = "Todos los Despertados obtienen [DescArg1] puntos de locura"
  },
  State_74887_Name = {
    Text = "Obtén [DescArg1] puntos de escudo"
  },
  State_74888_Name = {
    Text = "Obtén [DescArg1] puntos de resistencia a la muerte"
  },
  State_74889_Name = {
    Text = "Obtén [DescArg1] capas de contraataque"
  },
  State_74890_Name = {
    Text = "Roba [DescArg1] puntos de fuerza temporal a todos los enemigos"
  },
  State_74891_Name = {
    Text = "Inflige aleatoriamente [DescArg1] <FixedDamage:DMG Puro> [DescArg2] <plural value=\"[DescArg2]\" singular=\"vez\" plural=\"veces\"> (se beneficia de 1× <PowerIconKeywords:STR>)"
  },
  State_74910_Desc = {
    Text = "Equipo Único: Si el Portador es la Despertada \"Ramona\", la Tasa de sincronización obtenida al completar la etapa +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_74910_WeaponDesc = {
    Text = "Si el portador es el Despertado \"Ramona\", la afinidad obtenida al completar la fase aumenta en <WeaponEffect_Num:[StateArg1]%>."
  },
  State_74932_Desc = {
    Text = "Al jugar una carta de \"golpe\", \"defensa\" o \"habilidad\", se mejora el efecto correspondiente en \"Transacción Tabú\"."
  },
  State_74932_Name = {
    Text = "Comercio tabú"
  },
  State_74947_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Al inicio del turno, aplica [StateArg1] capas de bloqueo de acción al enemigo con <HPAndShieldMin:menor vida y escudo>. Tras eliminar a un enemigo, el portador activa este efecto de inmediato."
  },
  State_74947_Name = {
    Text = "Sombrero de Bruja de Ala Ancha"
  },
  State_74948_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Después de \"Exaltar\", hace que el enemigo con más exaltación pierda [StateArg1] puntos de exaltación y gane <PVPEmptinessKeywords:Void>."
  },
  State_74948_Name = {
    Text = "Péndulo Hipnótico"
  },
  State_76236_Desc = {
    Text = "\nKeyflare Rouse: Cuando la Keyflare esté llena, puedes elegir adicionalmente \"Keyflare Rouse\" para colocar la carta de Despertar del Cuerpo Despertado designado en la mano y otorgarle \"Retener\" durante esta batalla. \"Keyflare Rouse\" solo puede activarse una vez por turno y tiene un tiempo de reutilización independiente de \"Posse\".\nSobrecarga de Keyflare: Al usar \"Keyflare Rouse\", por cada Cuerpo Despertado activado, se deducen 1000 de Keyflare, lo que puede hacer que la Keyflare entre en valores negativos.\nMarcado de archivo: Por cada Posse que tenga el Guardián, la Profundidad de investigación de objetos y la Profundidad de la Investigación de la Conciencia aumentan un 1%, hasta un máximo del 50%. Todos los efectos de R Ruedas del Destino se cambian para aumentar la probabilidad de que aparezca la Reliquia de Imagen Dimensional del Portador en un 100%."
  },
  State_76236_Name = {
    Text = "Brillo plateado resplandeciente"
  },
  State_76277_Desc = {
    Text = "Equipo Único: Al comenzar la batalla del Líder, consume un máximo de 50 marcas negras, por cada 1 punto de marca negra consumido, obtienes <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords:resistencia a la muerte>. En el capítulo de las Estrellas, el efecto cambia a \"aumentar un 100% la probabilidad de que aparezca una creación con imagen dimensional del portador\"."
  },
  State_76277_WeaponDesc = {
    Text = "Tras comenzar la batalla del líder, consume hasta 50 marcas negras, y por cada 1 punto de marca negra consumido obtienes <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords:resistencia a la muerte>. En el capítulo de las Estrellas, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76278_Desc = {
    Text = "Equipo Único: Al avanzar a un nuevo casillero, recupera <WeaponEffect_Num:[StateArg1]%> de vida perdida. Después de usar el Cuerpo de Gnosis de Emergencia, la probabilidad de crítico y el daño crítico de todos los Despertados aumentan en un 100%. En el capítulo de las Estrellas, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una creación de Imagen Dimensional del portador\"."
  },
  State_76278_WeaponDesc = {
    Text = "Cada vez que se camina sobre un nuevo cuadrado, recupera [StateArg1]% de vida perdida ([DescArg1]). Tras usar el Cuerpo de Gnosis de Emergencia, la probabilidad de crítico y el daño crítico de todos los Despertados aumentan un 100%. En el Capítulo de las Estrellas, el efecto cambia a \"aumentar en un 100% la probabilidad de que aparezca una Reliquia de Imagen Dimensional del portador\"."
  },
  State_76279_Desc = {
    Text = "Equipo Único: El precio para despertar a los Despertados en D-mark disminuye en <WeaponEffect_Num:[StateArg1]> puntos de Marca negra. El Portador obtiene Gnosis Innata. En el Capítulo de las Estrellas, el efecto cambia a \"aumentar en un 100 % la probabilidad de que aparezca una creación de Imagen Dimensional del portador\"."
  },
  State_76279_WeaponDesc = {
    Text = "El precio para despertar a los despertados en d-marca disminuye en <WeaponEffect_Num:[StateArg1]> puntos de marca negra. El portador obtiene Gnosis Innata al activar. En el Capítulo de las Estrellas, el efecto cambia a \"aumentar en un 100 % la probabilidad de que aparezca una creación de Imagen Dimensional del portador\"."
  },
  State_76280_Desc = {
    Text = "Equipo Único: El aumento de recuperación en el Área de descanso es de <WeaponEffect_Num:[StateArg1]%>, tras elegir recuperar PV, añade 2 cartas de \"Conocimiento\" al mazo. En el capítulo de las Estrellas, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una Reliquia de Imagen Dimensional del portador\"."
  },
  State_76280_WeaponDesc = {
    Text = "El campamento aumenta la recuperación en <WeaponEffect_Num:[StateArg1]%>, tras elegir recuperar vida, añade 2 cartas \"Inspiración\" al mazo. En el capítulo Estelar, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una creación dimensional del portador\"."
  },
  State_76281_Desc = {
    Text = "Equipo único: Al finalizar la batalla, el despertado con menos locura obtiene <WeaponEffect_Num:[StateArg1]> puntos de locura. En el capítulo Estelar, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76281_WeaponDesc = {
    Text = "Tras finalizar la batalla, el despertado con menos locura obtiene <WeaponEffect_Num:[Energy:StateArg1]> puntos de locura. En el capítulo Estelar, el efecto cambia a \"aumentar en un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76282_Desc = {
    Text = "Equipo único: Refrescos en d-marca +1, precio de refresco disminuye <WeaponEffect_Num:[StateArg1]> puntos de sigilo negro. En el capítulo Estelar, el efecto cambia a \"aumentar en un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76282_WeaponDesc = {
    Text = "Refrescos en d-marca +1, el precio de refresco disminuye en <WeaponEffect_Num:[StateArg1]> puntos de sigilo negro. En el capítulo Estelar, el efecto cambia a \"aumentar en un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76283_Desc = {
    Text = "Equipo Único: La barra de creación de D-mark se convierte en 3, donde uno es una criatura maldita. Al comprar una criatura maldita, obtienes <WeaponEffect_Num:[StateArg1]> puntos de marca negra. En el capítulo de las Estrellas, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76283_WeaponDesc = {
    Text = "La Barra de Creación de D-mark se convierte en 3, de las cuales una es una Criatura maldita. Al comprar una Criatura maldita, se obtienen <WeaponEffect_Num:[StateArg1]> puntos de Marca negra. En el capítulo de las Estrellas, el efecto cambia a \"aumentar en un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76284_Desc = {
    Text = "Equipo Único: Al comenzar el nivel, todos los Despertados obtienen <WeaponEffect_Num:[StateArg1]> puntos de Alienación. Tras comenzar la Líder Batalla, roba 2 cartas. En el capítulo de las Estrellas, el efecto cambia a \"aumentar en un 100 % la probabilidad de que aparezca una creación de Imagen Dimensional del portador\"."
  },
  State_76284_WeaponDesc = {
    Text = "Tras comenzar el nivel, todos los despertados obtienen <WeaponEffect_Num:[Energy:StateArg1]> puntos de alienación. Al iniciar la batalla del líder, roba 2 cartas. En el capítulo de las Estrellas, el efecto cambia a \"aumentar en un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76285_Desc = {
    Text = "Equipo Único: Tras comenzar el nivel, obtén <WeaponEffect_Num:[StateArg1]> puntos de Llave Plateada. Después de que comience la Líder Batalla, obtén 2 puntos de Aritmética. En el capítulo Estelar, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una creación de Imagen Dimensional del portador\"."
  },
  State_76285_WeaponDesc = {
    Text = "Tras comenzar el nivel, obtén <WeaponEffect_Num:[StateArg1]> puntos de energía de llave plateada. Después de comenzar la batalla del líder, obtén 2 puntos de aritmética. En el capítulo de las Estrellas, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76286_Desc = {
    Text = "Equipo Único: El área de descanso ofrece una opción adicional: eliminar hasta 3 cartas de síntoma y obtener <WeaponEffect_Num:[StateArg1]> puntos de Marca negra. En el capítulo de las Estrellas, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una creación de Imagen Dimensional del portador\"."
  },
  State_76286_WeaponDesc = {
    Text = "El campamento ofrece una opción adicional: eliminar hasta 3 cartas de síntoma y obtén <WeaponEffect_Num:[StateArg1]> puntos de el sigilo negro. En el capítulo Estelar, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76287_Desc = {
    Text = "Equipo Único: El número de inscripciones disponibles para elegir al finalizar una batalla normal se convierte en 4, y hay un <WeaponEffect_Num:[StateArg1]%> de probabilidad de que las inscripciones de las cartas del portador se mejoren a inscripciones avanzadas. En el capítulo de las Estrellas, el efecto cambia a \"aumentar en un 100 % la probabilidad de que aparezca una Reliquia de Imagen Dimensional del portador\"."
  },
  State_76287_WeaponDesc = {
    Text = "El número de inscripciones seleccionables después de finalizar una batalla normal se convierte en 4, y las inscripciones de las cartas del portador tienen un <WeaponEffect_Num:[StateArg1]%> de probabilidad de mejorar a inscripciones avanzadas. En el capítulo de las Estrellas, el efecto cambia a \"aumentar en un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76288_Desc = {
    Text = "Equipo único: Al finalizar la batalla, obtén <WeaponEffect_Num:[StateArg1]> puntos de energía de llave de plata. En el capítulo Estelar, el efecto cambia a \"aumentar un 100% la probabilidad de que aparezca una creación con imagen dimensional del portador\"."
  },
  State_76288_WeaponDesc = {
    Text = "Tras finalizar la batalla, obtén <WeaponEffect_Num:[StateArg1]> puntos de energía de llave de plata. En el capítulo Estelar, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76289_Desc = {
    Text = "Equipo Único: En la exploración, campo de visión +1, al abrir completamente el mapa, obtén <WeaponEffect_Num:[StateArg1]> puntos de marca negra. Al comenzar la batalla contra el líder, <WeaknessIconKeywords:debilidad> y <VulnerabilityIconKeywords:vulnerable> a todos los enemigos por 1 turno. En el capítulo de las Estrellas, el efecto cambia a \"aumentar en un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76289_WeaponDesc = {
    Text = "Campo de visión en exploración +1, al abrir completamente el campo de visión del mapa obtén <WeaponEffect_Num:[StateArg1]> puntos de marca negra. Al comenzar la Líder Batalla, aplica <WeaknessIconKeywords:debilidad> y <VulnerabilityIconKeywords:vulnerable> a todos los enemigos por 1 turno. En el capítulo de las Estrellas, el efecto cambia a \"aumentar en un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76290_Desc = {
    Text = "Equipo Único: Tras finalizar una batalla normal, puedes optar por liberar una inscripción, aumentando el límite de PV en <WeaponEffect_Num:[StateArg1]%. Este efecto puede activarse un máximo de 2 veces. En el capítulo de las Estrellas, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76290_WeaponDesc = {
    Text = "Después de finalizar una batalla normal, puedes elegir liberar la inscripción, aumentando el límite de vida en <WeaponEffect_Num:[DescArg1]>. Este efecto puede activarse un máximo de 2 veces. En el capítulo de las Estrellas, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76291_Desc = {
    Text = "Único del equipo: Al comenzar el nivel, obtén <WeaponEffect_Num:[StateArg1]> puntos de sigilo negro. Límite de creación +2. En el capítulo Estelar, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76291_WeaponDesc = {
    Text = "Tras comenzar el nivel, obtén <WeaponEffect_Num:[StateArg1]> puntos de sigilo negro. Límite de creación +2. En el capítulo Estelar, el efecto cambia a \"aumentar en un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76292_Desc = {
    Text = "Equipo Único: En la d-marca puedes vender cartas de síntomas, al vender una carta de síntomas obtienes <WeaponEffect_Num:[StateArg1]> puntos de marca negra. En el capítulo de las Estrellas, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76292_WeaponDesc = {
    Text = "En la d-marca puedes vender cartas de síntoma, al vender una carta de síntoma obtienes <WeaponEffect_Num:[StateArg1]> puntos de sigilo negro. En el capítulo Estelar, el efecto cambia a \"aumentar un 100 % la probabilidad de que aparezca una creación de imagen dimensional del portador\"."
  },
  State_76321_Name = {
    Text = "Lente prisma"
  },
  State_76323_Name = {
    Text = "Armonía Furiosa"
  },
  State_76324_Name = {
    Text = "Armonía Aritmética"
  },
  State_76325_Desc = {
    Text = "Después de jugar [DescArg1] cartas de comando, entra en el estado \"armonización de aritmética\"."
  },
  State_76325_Name = {
    Text = "Armonía Aritmética"
  },
  State_76326_Name = {
    Text = "Existe paradoja"
  },
  State_76328_Name = {
    Text = "Cono de luz del destino"
  },
  State_76337_Name = {
    Text = "Cicatriz abisal"
  },
  State_76338_Desc = {
    Text = "La curación recibida se reduce en [Layer] %."
  },
  State_76338_Name = {
    Text = "Cicatriz abisal"
  },
  State_76430_Name = {
    Text = "Imagen de Dimensión · Lily"
  },
  State_76433_Name = {
    Text = "Armonía Aritmética"
  },
  State_76434_Desc = {
    Text = "Cada vez que juegues una carta de comando, si consumes aritmética adicional debido a la regulación de aritmética, obtén un 100% adicional de energía de recarga de llave de plata del Despertador. Esta bonificación es acumulable."
  },
  State_76434_Name = {
    Text = "Armonía Aritmética"
  },
  State_76435_Name = {
    Text = "Lente prisma"
  },
  State_76528_Name = {
    Text = "Esta carta se considera \"golpear\"."
  },
  State_76529_Desc = {
    Text = "Al recoger, se elige una carta de un despertador, se reduce su consumo de aritmética en 1, se juega y se roba 1 carta, y se considera \"golpe\""
  },
  State_76533_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equipar y al final del turno, aplica [StateArg2] capas de <PVPAcheKeywords:dolor oculto> a [StateArg1] cartas aleatorias en la mano del oponente."
  },
  State_76533_Name = {
    Text = "Angustia Velada"
  },
  State_76553_Desc = {
    Text = "El consumo de aritmética de esta carta se reduce en [StateArg1]."
  },
  State_76553_Name = {
    Text = "La Mirada Favorecida por Millones"
  },
  State_77686_Name = {
    Text = "Forma Semi-Mecánica"
  },
  State_77688_Desc = {
    Text = "Al inicio del quinto turno o al estar a punto de morir, obtiene inmunidad a la muerte y ajusta la intención a \"Ascensión Mecánica\"."
  },
  State_77688_Name = {
    Text = "Carne débil"
  },
  State_77690_Desc = {
    Text = "Tras cambiar a \"Forma semimecánica\", por cada capa de \"fin\" que poseas, obtienes un 10% adicional de vida máxima. Mientras estés en \"Forma semimecánica\", \"Fusión·Doll\" liberará habilidades más amenazantes a medida que aumenten las capas de \"fin\"."
  },
  State_77690_Name = {Text = "Fin"},
  State_77692_Desc = {
    Text = "Al final del turno, invoca 2 monstruos de disolución, con un máximo de 2 simultáneos. Cuando un monstruo de disolución invocado muere, \"Fusión·muñeca\" pierde el 5% de su salud máxima."
  },
  State_77692_Name = {
    Text = "Puerta de los Abismos"
  },
  State_77693_Desc = {
    Text = "Después de la muerte, \"Fusión·Muñeca\" pierde el 5 % de la salud máxima."
  },
  State_77693_Name = {Text = "Fusión"},
  State_78102_Desc = {
    Text = "El daño causado disminuye un 15 %, y el daño recibido aumenta un 30 %, efecto que dura hasta el final de la batalla."
  },
  State_78102_Name = {
    Text = "Parálisis de sobrecarga"
  },
  State_78694_Desc = {
    Text = "Al inicio de la batalla, obtén [Arg1] puntos de fuerza. Al inicio de cada turno, por cada [Arg2] puntos de fuerza permanente, obtén [Arg3] puntos de fuerza temporal, hasta un máximo de [Arg4] puntos de fuerza temporal, y al final del turno pierdes la mitad del escudo obtenido de esta creación."
  },
  State_78696_Desc = {
    Text = "Después de usar el Despertar con la Llave de Plata, selecciona [Arg1] «habilidades» del Despertado correspondiente, consúmelas y baraja [Arg2] copias adicionales en el mazo de robo."
  },
  State_78697_Desc = {
    Text = "Al inicio del turno, se te aplica [Arg2] capas de veneno y por cada espacio vacío en el espacio dimensional, obtienes [Arg1] puntos de fuerza."
  },
  State_78698_Desc = {
    Text = "Límite de aritmética -[Arg1]. Al jugar una carta con un consumo de aritmética mayor o igual a [Arg2], obtén 1 punto de aritmética, con un máximo de [Arg3] activaciones por turno."
  },
  State_78699_Desc = {
    Text = "Roba [Arg1] cartas adicionales después de robar, pero elige [Arg2] cartas de tu mano para descartar."
  },
  State_78700_Desc = {
    Text = "Todos los Despertados aumentan su daño base en [Arg1]%, y este aumento se incrementa adicionalmente en [Arg2]% cada vez que se reinicia el mazo, pero se agrega 1 carta \"tambalearse\" a la mano, con un límite máximo de aumento de [Arg3]%."
  },
  State_78701_Desc = {
    Text = "Al inicio del turno, si tienes más de [Arg1] tentáculos permanentes, pierdes [Arg2] tentáculos y obtienes [Arg3] tentáculos temporales; de lo contrario, obtienes [Arg4] tentáculos temporales."
  },
  State_78702_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, consume [Arg1] puntos de energía-s de llave de plata adicional, haciendo que el coste de aritmética de las cartas de despertar obtenidas sea 0. Al jugarlas, otorga a su Despertado correspondiente [Arg2] puntos de alienación adicionales."
  },
  State_78703_Desc = {
    Text = "Al comenzar la batalla, aplica [Arg1] capas de <IntoxicationIconKeywords:veneno> a todos los enemigos. Antes del inicio del turno, elimina [Arg2]% del veneno de los enemigos y aplica [Arg3]% de la cantidad eliminada como <BleedingIconKeywords:sangrado>."
  },
  State_78710_Desc = {
    Text = "Cada vez que se juega una carta de comando, el Despertado correspondiente aumenta el daño final causado en [Arg1]% durante ese turno, pero pierde [Arg2] puntos de locura, activándose hasta [Arg3] veces por turno."
  },
  State_78712_Desc = {
    Text = "Al inicio del turno, la Fusión Embrionaria +[Arg1]. Tus Embriones serán descartados al final del turno."
  },
  State_78713_Desc = {
    Text = "Al comenzar el turno, obtienes [Arg1] puntos de contrataque. Después de liberar [Arg2] veces la explosión de aliemus en un turno, elimina [Arg3]% de tu contrataque permanente y obtienes un contrataque temporal del [Arg4]% de la cantidad eliminada, con un enfriamiento de [Arg5] turnos."
  },
  State_78781_Desc = {
    Text = "Reducción temporal de la fuerza del objetivo, obteniendo fuerza temporal equivalente."
  },
  State_78781_Name = {
    Text = "<TouquKeywords: Robo>"
  },
  State_79405_Desc = {
    Text = "Después de jugar, aumenta en 1 \"memoria clara\". Cuando alcance 10, bloquéala durante 1 turno y obtén 3 \"inspiraciones\". Al inicio del siguiente turno, se restablece a 5."
  },
  State_79405_Name = {
    Text = "El pasado real"
  },
  State_79406_Desc = {
    Text = "Después de jugar, reduce en 1 \"memoria clara\". Cuando alcance 0, bloquéala durante 1 turno y otorga 30 puntos de locura a todos los Despertados. Al inicio del siguiente turno, se restablece a 5."
  },
  State_79406_Name = {
    Text = "Sueño Falso y Lujoso"
  },
  State_80052_Desc = {Text = "Prueba"},
  State_80052_Name = {Text = "Prueba 123"},
  State_80052_WeaponDesc = {Text = "Prueba"},
  State_80161_Desc = {
    Text = "Equipo Único: El daño básico causado por la explosión de locura del portador aumenta en <WeaponEffect_Num:[StateArg1]%>, y la regeneración de llave plateada aumenta en <WeaponEffect_Num:[StateArg2]%>. Después de entrar en el Turno Ultra, todos los Despertados obtienen <WeaponEffect_Num:[StateArg4]> puntos de alienación. Después de liberar\"Aniquilación\", el portador obtiene <WeaponEffect_Num:[StateArg3]> puntos de alienación."
  },
  State_80161_WeaponDesc = {
    Text = "El daño básico causado por la explosión de locura del portador aumenta en <WeaponEffect_Num:[StateArg1]%, la regeneración de llave plateada aumenta en <WeaponEffect_Num:[DescArg1]>. Al entrar en el turno ultra, todos los despertados obtienen <WeaponEffect_Num:[StateArg4]> puntos de locura. Después de liberar\"Aniquilación\", el portador obtiene <WeaponEffect_Num:[StateArg3]> puntos de locura."
  },
  State_80174_Desc = {
    Text = "Único del equipo: La recarga de llave de plata del portador aumenta <WeaponEffect_Num:[StateArg1]%>. Después de comenzar la primera batalla, aplica 1 capa de debilidad y vulnerabilidad a todos los enemigos."
  },
  State_80174_WeaponDesc = {
    Text = "El portador aumenta su carga de llave de plata en <WeaponEffect_Num:[DescArg1]>. Al comenzar la primera batalla, aplica 1 capa de <WeaknessIconKeywords:debilidad> y <VulnerabilityIconKeywords:vulnerabilidad> a todos los enemigos."
  },
  State_80207_Desc = {
    Text = "Si esta carta activa \"Lanzadera Dimensional\" después de ser jugada, activa el efecto subsiguiente. Coste de Aritmética –1 cuando se retira del Espacio Hiperspacial."
  },
  State_80207_Name = {
    Text = "<WormholeKeywords:Telequinesis>"
  },
  State_80328_Desc = {
    Text = "Su emoción, cognición y todo lo demás están eternamente vinculados con la voluntad del enjambre. Se puede acumular un máximo de 15 capas. \"Empatía\" puede ser convertida por la explosión de locura \"Reconstrucción y Curación de Vida\" de Clementine en efectos negativos."
  },
  State_80328_Name = {Text = "Empatía"},
  State_80331_Desc = {
    Text = "Bajo la erosión de la Colmena, tus debilidades quedan completamente expuestas. El Daño Activo y Daño de tentáculos recibido este turno aumenta en [DescArg1]%."
  },
  State_80331_Name = {
    Text = "<D13Colour:Herida psicológica>"
  },
  State_80332_Desc = {
    Text = "Su emoción, cognición y todo lo demás están eternamente vinculados a la voluntad del enjambre, acumulando hasta un máximo de 10 capas. \"Empatía\" puede ser convertida por la explosión de locura \"Reconstrucción y Curación de Vida\" de Clementine en efectos negativos."
  },
  State_80332_Name = {Text = "Empatía"},
  State_80335_Desc = {
    Text = "Bajo la erosión de la Colmena, tus debilidades quedan completamente expuestas. El Daño Activo y Daño de tentáculos recibido este turno aumenta en [DescArg1]%."
  },
  State_80335_Name = {
    Text = "<D13Colour:Herida psicológica>"
  },
  State_80336_Desc = {
    Text = "Bajo la erosión de la Colmena, tus miedos quedan al descubierto. El Daño Activo y Daño de tentáculos infligido este turno se reduce en [DescArg1]%."
  },
  State_80336_Name = {
    Text = "<D13Colour:Fijación fóbica>"
  },
  State_80338_Desc = {
    Text = "Bajo la erosión de la Colmena, tus miedos quedan al descubierto. El Daño Activo y Daño de tentáculos infligido este turno se reduce en [DescArg1]%."
  },
  State_80338_Name = {
    Text = "<D13Colour:Fijación fóbica>"
  },
  State_80575_Desc = {
    Text = "Tras recibir daño activo o daño de tentáculo, se elimina una cantidad equivalente de \"brasas del pasado\" y se pierde el 300% de vida equivalente a la cantidad eliminada. Al recibir otros tipos de daño, solo se elimina la mitad. Las capas de \"brasas del pasado\" se restablecen cada turno."
  },
  State_80575_Name = {
    Text = "Ceniza ancestral"
  },
  State_80644_Name = {
    Text = "Estado@Luz de Trascendencia"
  },
  State_80773_Desc = {
    Text = "El efecto STR ▼ sufrido –50%. Durante el turno propio, el daño no Activo y no de tentáculos recibido +100%."
  },
  State_80773_Name = {
    Text = "Anticuerpo extradimensional"
  },
  State_80774_Desc = {
    Text = "Tras recibir daño activo o daño de tentáculo, se elimina una cantidad equivalente de \"ceniza ancestral\" y se pierde el 300% de vida equivalente a la cantidad eliminada. Al recibir otros tipos de daño, solo se elimina la mitad. Las acumulaciones de \"ceniza ancestral\" se restablecen cada turno. Al eliminarse todas las \"ceniza ancestral\", se obtienen 50 capas de \"fortaleza\"."
  },
  State_80774_Name = {
    Text = "Ceniza ancestral"
  },
  State_80777_Desc = {
    Text = "Al comenzar la batalla, reduce un 10% la tasa crítica de todos los Despertados. Al morir, otros aliados obtienen [DescArg1] puntos de fuerza y [DescArg2] capas de \"brasas del pasado\"."
  },
  State_80777_Name = {
    Text = "Empatía de Colmena: Legado"
  },
  State_80778_Desc = {
    Text = "Al morir, los demás aliados obtienen 1 carga de \"Locura Temporal\"."
  },
  State_80778_Name = {
    Text = "Hive Empatía: Fusión"
  },
  State_80782_Desc = {
    Text = "En esta batalla, la probabilidad de crítico de todos los Despertados disminuye en un [Layer]%."
  },
  State_80782_Name = {
    Text = "Tasa de golpe crítico reducida"
  },
  State_80783_Desc = {
    Text = "En el fin de turno, gana 1 acumulación de \"Locura\"."
  },
  State_80783_Name = {
    Text = "Vínculo de Sangre"
  },
  State_80784_Desc = {
    Text = "Cuando la vida esté por debajo del 50 %, invoca a un \"Primero Mutado\" detrás. Solo se puede activar una vez por batalla."
  },
  State_80784_Name = {
    Text = "Empatía del Enjambre: Fisión"
  },
  State_80785_Desc = {
    Text = "La Fuerza reducida solo tiene un 50% de efecto sobre este enemigo. Cada vez que liberas un Exaltar, obtén 1 carga de \"Locura Temporal\"."
  },
  State_80785_Name = {
    Text = "Empatía de Colmena: Dimensión"
  },
  State_80788_Desc = {
    Text = "La Fuerza reducida solo tiene un 25% de efecto sobre este enemigo. Cada vez que liberas un Exaltar, obtén 1 carga de \"Locura Temporal\"."
  },
  State_80788_Name = {
    Text = "Empatía de Colmena: Dimensión"
  },
  State_80789_Desc = {
    Text = "Daño Activo y Daño de tentáculos recibido +100%, durante 1 turno."
  },
  State_80789_Name = {
    Text = "Inactividad"
  },
  State_80790_Desc = {
    Text = "Después de la transformación, cada capa de poder etéreo cósmico se perfeccionará..."
  },
  State_80790_Name = {
    Text = "Energía Cósmica"
  },
  State_80792_Desc = {
    Text = "Cada vez que liberas un Exaltar, obtén 1 carga de \"Locura Temporal\"."
  },
  State_80792_Name = {
    Text = "Empatía de Colmena: Dimensión"
  },
  State_80794_Desc = {
    Text = "La carta no se puede jugar y permanecerá en la mano al final del turno."
  },
  State_80794_Name = {
    Text = "<Boundkeywords:Atadura>"
  },
  State_80807_Desc = {
    Text = "Al inicio del quinto turno o al estar a punto de morir, elimina a todos los demás enemigos y cambia la intención a \"Momento de Transformación\"."
  },
  State_80807_Name = {
    Text = "Momento de metamorfosis"
  },
  State_80809_Desc = {
    Text = "Al final del turno, las cartas con ilusión en la mano serán descartadas."
  },
  State_80809_Name = {
    Text = "<PVPVoidKeyColour:Oblivion>"
  },
  State_80810_Desc = {
    Text = "Tras recibir daño activo o daño de tentáculo, se elimina una cantidad equivalente de \"brasas del pasado\" y se pierde el 300% de vida equivalente a la cantidad eliminada. Al recibir otros tipos de daño, solo se elimina la mitad. Las capas de \"brasas del pasado\" se restablecen cada turno."
  },
  State_80810_Name = {
    Text = "Ceniza ancestral"
  },
  State_80827_Desc = {
    Text = "Cada vez que acumules 15 cartas jugadas, reemplaza la intención actual con «Golpe Traumático» (quedan [Layer] cartas)."
  },
  State_80827_Name = {
    Text = "Castigo iracundo"
  },
  State_81022_WeaponDesc = {
    Text = "Cada vez que recibes daño, todos los despertados ganan 1 punto de locura"
  },
  State_81027_Desc = {
    Text = "Esta carta pertenece a \"Zerg\", su Coste de Aritmética se reduce en 1 y después de jugarla, será consumida."
  },
  State_81027_Name = {
    Text = "Rito de Vida"
  },
  State_81054_Desc = {
    Text = "Bajo la erosión de la Colmena, tus miedos quedan al descubierto. Por cada Acumulación, el Daño Activo y de Tentáculos infligido este turno -3%, acumulable hasta 15 veces."
  },
  State_81054_Name = {
    Text = "<D13AFKeyWordQ1:Fijación fóbica>"
  },
  State_81055_Desc = {
    Text = "Bajo la erosión de la Colmena, tus miedos quedan al descubierto. Por cada Acumulación, el Daño Activo y de Tentáculos recibido este turno +3%, acumulable hasta 10 veces."
  },
  State_81055_Name = {
    Text = "<D13AFKeyWord2:Trauma psicológico>"
  },
  State_81056_Desc = {
    Text = "Bajo la erosión de la Colmena, tus miedos quedan al descubierto. Por cada Acumulación, el Daño Activo y de Tentáculos recibido este turno +3%, acumulable hasta 15 veces."
  },
  State_81056_Name = {
    Text = "<D13AFKeyWordQ2:Trauma psicológico>"
  },
  State_81057_Desc = {
    Text = "Bajo la erosión de la Colmena, tus miedos quedan al descubierto. Por cada Acumulación, el Daño Activo y de Tentáculos infligido este turno -3%, acumulable hasta 10 veces."
  },
  State_81057_Name = {
    Text = "<D13AFKeyWord1:Fijación fóbica>"
  },
  State_81058_Desc = {
    Text = "Su emoción, cognición y todo lo demás están eternamente conectados con la voluntad del enjambre. \"Empatía\" puede ser transformada por la explosión de locura \"Reconstrucción y Curación de Vida\" de Clementine en efectos negativos, con un máximo de acumulación de 15 capas."
  },
  State_81058_Name = {
    Text = "<AnalysisKeywords3:Resonancia>"
  },
  State_81059_Desc = {
    Text = "Su emoción, cognición y todo lo demás están eternamente conectadas con la voluntad del enjambre. \"Empatía\" puede ser transformada por la explosión de locura \"Reconstrucción y Curación de Vida\" de Clementine en efectos negativos, acumulando un máximo de 10 capas."
  },
  State_81059_Name = {
    Text = "<AnalysisKeywords0:Resonancia>"
  },
  State_81073_Desc = {
    Text = "Al recibir daño letal, recupera inmediatamente toda la vida y obtén un 80 % de reforzado temporal. Invoca a un \"Primero Mutado\" detrás. Puede activarse 2 veces."
  },
  State_81073_Name = {
    Text = "Empatía del Enjambre: Fisión"
  },
  State_81278_Desc = {
    Text = "Después de liberar la llave por primera vez en cada turno, todos los despertadores obtienen 10 aliemus, pero el costo de liberar la llave aumenta permanentemente en un 10%"
  },
  State_81278_Name = {
    Text = "Inhibición de Llave de Plata"
  },
  State_81312_Desc = {
    Text = "Al recibir daño letal, recupera toda la vida y obtén 50 capas de reforzado temporal. También puede activarse [Layer] veces."
  },
  State_81312_Name = {
    Text = "Reencarnación Cósmica"
  },
  State_81331_Desc = {
    Text = "Al inicio del turno, elige 1 Despertado y sella todas sus cartas y su exaltación durante 3 turnos."
  },
  State_81331_Name = {
    Text = "Encarcelamiento mental"
  },
  State_81340_Desc = {
    Text = "Esta carta está sellada, no se puede jugar, y el sello se deshará después de [Layer] turnos."
  },
  State_81340_Name = {
    Text = "<Seal1:Sello de Carta>"
  },
  State_81341_Desc = {
    Text = "Este Despertado tiene su exaltación sellada y no puede ser utilizada. El sello se deshará después de [Layer] turnos."
  },
  State_81341_Name = {
    Text = "<Seal1:Sello de Alienación>"
  },
  State_81354_Desc = {
    Text = "Al jugar, recibe [DescArg1] de daño y se consume si no se juega antes de que termine el turno."
  },
  State_81354_Name = {
    Text = "<BurningKeywords:Quemar>"
  },
  State_81356_Desc = {
    Text = "Hace que la carta arda; al jugarla, recibe [DescArg1] puntos de daño y se consume si aún está en la mano al final del turno."
  },
  State_81356_Name = {
    Text = "<BurningKeywords:Quemar>"
  },
  State_81356_WeaponDesc = {
    Text = "Cada capa de lentitud aumenta el consumo de aritmética de las cartas en 1"
  },
  State_83587_Desc = {
    Text = "Mejora el efecto al seleccionar \"Navegar entre olas\", con un límite de 10 capas."
  },
  State_83587_Name = {
    Text = "\"Levantar velas\""
  },
  State_83589_Desc = {
    Text = "Mejora el efecto al seleccionar \"Descanso momentáneo en la orilla\", con un límite de 10 capas."
  },
  State_83589_Name = {
    Text = "\"Echar el ancla\""
  },
  State_83593_Desc = {
    Text = "Este turno, el daño final causado por todos los Despertados aumenta"
  },
  State_83593_Name = {
    Text = "Daño Final"
  },
  State_83596_Desc = {
    Text = "Tamaño Máximo de la Mano +1. Al comenzar el turno, si el mazo no tiene \"El dilema del navegante\", colócalo en tu mano. Cada vez que el líder pierde el 10% de su PV Max, obtienes 1 capa de \"Levantar velas\"; cada vez que tú pierdes el 10% de tu PV Max, obtienes 1 capa de \"Anclar\"."
  },
  State_83596_Name = {
    Text = "Guía de Erasmo - «Izar las velas»"
  },
  State_83607_Desc = {
    Text = "El jefe acumula una marca que representa el 10% de pérdida de vida"
  },
  State_83607_Name = {
    Text = "Estado@El jefe acumula una marca que representa el 10% de vida perdida"
  },
  State_83609_Desc = {
    Text = "El jugador acumula una marca que representa el 10% de vida perdida"
  },
  State_83609_Name = {
    Text = "Estado@El jugador acumula una marca de pérdida del 10% de vida"
  },
  State_83614_Desc = {
    Text = "Jugador con 10% de vida"
  },
  State_83614_Name = {
    Text = "Estado@Jugador con 10% de vida"
  },
  State_83615_Desc = {
    Text = "Pierde [Layer] puntos de vida para obtener 1 capa de \"Vela desplegada\"."
  },
  State_83615_Name = {
    Text = "Progreso de \"Levantar Anclas\""
  },
  State_83616_Desc = {
    Text = "Pierde [Layer] puntos de vida para obtener 1 capa de \"Ancla fondeada\"."
  },
  State_83616_Name = {
    Text = "Progreso de \"Anclado\""
  },
  State_83617_Desc = {
    Text = "10% del valor de la vida del jefe"
  },
  State_83617_Name = {
    Text = "Estado@Jefe con 10% de vida"
  },
  State_83618_Desc = {
    Text = "Durante la prueba, la vida actual es de [Layer] puntos."
  },
  State_83618_Name = {
    Text = "Vida actual del enemigo"
  },
  State_83619_Desc = {
    Text = "Durante la prueba, la salud máxima es de [Layer] puntos."
  },
  State_83619_Name = {
    Text = "Vida máxima del enemigo"
  },
  State_83620_Desc = {
    Text = "El valor actual del parámetro 4 multiplicado por 100 equivale a [Layer] puntos."
  },
  State_83620_Name = {
    Text = "Parámetro de impresión"
  },
  State_83621_Desc = {
    Text = "Valor intermedio del contador de pérdida del 10% de la vida del jefe"
  },
  State_83621_Name = {
    Text = "Estado@Valor intermedio del contador de pérdida del 10% de vida del jefe"
  },
  State_83622_Desc = {
    Text = "Valor intermedio del contador de pérdida del 10% de la vida del jugador"
  },
  State_83622_Name = {
    Text = "Estado@Valor intermedio del contador de pérdida del 10% de vida del jugador"
  },
  State_83627_Desc = {
    Text = "Pierde [DescArg1] puntos de vida para obtener 1 capa de \"Vela desplegada\""
  },
  State_83627_Name = {
    Text = "Progreso de \"Levantar Anclas\""
  },
  State_83805_Name = {Text = "Réplica"},
  State_83807_Name = {
    Text = "Hundimiento Distante"
  },
  State_83808_Desc = {
    Text = "Cuando esta carta sea descartada, activa el efecto de \"ondas residuales\"."
  },
  State_83808_Name = {
    Text = "<RippleKeywords:Réplica>"
  },
  State_83811_Desc = {
    Text = "Recibe un [Layer]% adicional de daño de tentáculo."
  },
  State_83812_Desc = {
    Text = "Recibe un [Layer]% adicional de daño de tentáculo."
  },
  State_83814_Desc = {
    Text = "10% del valor de la vida del jefe"
  },
  State_83814_Name = {
    Text = "Jefe con 10% de vida restante"
  },
  State_84140_Desc = {
    Text = "En esta batalla se han consumido [Layer] usos de «División de glándulas» a través de «Océano bullicioso»."
  },
  State_84140_Name = {
    Text = "Océano clamoroso"
  },
  State_84184_Name = {
    Text = "Esta habilidad recibe un bono adicional de [Layer]% en fuerza"
  },
  State_84255_Desc = {
    Text = "Equipo único: Al comenzar la batalla, obtiene un escudo equivalente a <WeaponEffect_Num:[StateArg1]%> de la defensa del portador. Tras activar la resistencia a la muerte, este efecto vuelve a activarse al inicio del siguiente turno."
  },
  State_84255_Name = {
    Text = "Navegante de los Mares"
  },
  State_84255_WeaponDesc = {
    Text = "Al comenzar la batalla, obtén <WeaponEffect_Num:[Block:DescArg1]> puntos de escudo. Después de activar la resistencia a la muerte, vuelve a activar este efecto al inicio del próximo turno."
  },
  State_84257_Desc = {
    Text = "Equipo único: El escudo proporcionado por la exaltar del portador aumenta <WeaponEffect_Num:[StateArg1]%>, y tras liberar la exaltación, el daño crítico temporal de todos los despertados aumenta <WeaponEffect_Num:[StateArg2]%>, incrementándose en un 1% por cada tentáculo. Cada vez que se activa la resistencia a la muerte por primera vez en la exploración, al inicio del siguiente turno se recupera <WeaponEffect_Num:[StateArg3]%> de la salud máxima."
  },
  State_84257_WeaponDesc = {
    Text = "El escudo proporcionado por la exaltar del portador aumenta en <WeaponEffect_Num:[StateArg1]%>, tras liberar la exaltación, el daño crítico temporal de todos los despertados aumenta en <WeaponEffect_Num:[StateArg2]%>, y por cada tentáculo adicional se incrementa en un 1%. Después de activar la resistencia a la muerte por primera vez en cada exploración, al comienzo de la siguiente ronda se recupera el <WeaponEffect_Num:[StateArg3]%> de la salud máxima."
  },
  State_84272_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Al final del turno, el aliado con mayor pérdida de vida recupera <Heal:[Heal:StateArg1]> de vida."
  },
  State_84272_Name = {
    Text = "Navegante de los Mares"
  },
  State_84273_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Al equipar y al inicio del turno, si no tienes <PVPProtectiveKeywords:barrera>, obtienes [StateArg1] capas de <PVPProtectiveKeywords:barrera>, de lo contrario obtienes <Energy:[Energy:StateArg2]> locura."
  },
  State_84273_Name = {
    Text = "Guía del Fuego Sagrado"
  },
  State_84364_Desc = {
    Text = "Daño crítico +[Layer]%"
  },
  State_84364_Name = {
    Text = "Daño Crítico"
  },
  State_84368_Desc = {
    Text = "Quedan [Layer] turnos de enfriamiento."
  },
  State_84368_Name = {
    Text = "Hundimiento Distante"
  },
  State_84375_Desc = {
    Text = "Al inicio del turno, obtén [Layer] puntos de escudo."
  },
  State_84375_Name = {
    Text = "Navegante de los Mares"
  },
  State_84376_Desc = {
    Text = "Al inicio del turno, obtén [Layer] puntos de curación."
  },
  State_84376_Name = {
    Text = "Guía del Fuego Sagrado"
  },
  State_84399_Desc = {
    Text = "Al final de cada turno, el daño recibido aumenta un 5 % y obtienes 2 capas de barrera."
  },
  State_84399_Name = {
    Text = "Hundimiento Distante"
  },
  State_84400_Desc = {
    Text = "Al inicio del próximo turno, convierte cada capa de <PVPProtectiveKeywords:barrera> en 1 capa <ReinforcePVEKeywords:reforzado>."
  },
  State_84400_Name = {
    Text = "\"Navegación\""
  },
  State_84402_Desc = {
    Text = "El daño recibido aumenta en [Layer]%."
  },
  State_84402_Name = {
    Text = "Fuerza de sobregiro"
  },
  State_89340_Desc = {
    Text = "Recibe un [Layer]% adicional de daño de tentáculo."
  },
  State_89340_Name = {
    Text = "Tentáculo vulnerable"
  },
  State_89422_Desc = {
    Text = "El aliemus generado por todos los Despertados aumenta en 100%, y pueden liberar 2 exaltaciones por turno."
  },
  State_89422_Name = {
    Text = "\"Corazón Inquebrantable\""
  },
  State_89447_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>:Tamaño Máximo de la Mano + [StateArg2].\"Exaltar\"tras obtener [StateArg1] Aritmética ."
  },
  State_89447_Name = {
    Text = "Libertad Insoportable"
  },
  State_89448_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Después de que otro aliado use \"Golpe\", si no tienes <EnergyStorageKeywords:cargar>, obtén 1 capa <EnergyStorageKeywords:cargar>, de lo contrario obtén [StateArg1] locura."
  },
  State_89448_Name = {
    Text = "Pluma Solitaria"
  },
  State_89554_Name = {
    Text = "Cono de luz del destino"
  },
  State_89555_Desc = {
    Text = "Equipo Único: Después de que el Portador libere Exaltar, Daño básico de Exaltar +<WeaponEffect_Num:[StateArg1]%>, Escudo del personaje y Recuperación de PV +<WeaponEffect_Num:[StateArg2]%>, acumulándose hasta 5 veces. Durante la exploración, la Tasa de sincronización obtenida por el Portador +<WeaponEffect_Num:[StateArg3]%>."
  },
  State_89555_WeaponDesc = {
    Text = "Después de que el portador libera la exhalación de aliemus, el daño básico de la exhalación aumenta en <WeaponEffect_Num:[StateArg1]%>, y el blindaje y la recuperación de PV aumentan en <WeaponEffect_Num:[StateArg2]%>, acumulándose hasta 5 veces. Al completar la exploración, la tasa de sincronización obtenida por el portador aumenta en <WeaponEffect_Num:[StateArg3]%>."
  },
  State_89557_Name = {
    Text = "Lente prisma"
  },
  State_89559_Desc = {
    Text = "\n·Paradoja existencial: Al inicio de la exploración, el 75% de la resistencia a la muerte se convierte en bonificación de vida máxima, convirtiendo hasta un 300% de resistencia a la muerte y aumentando hasta un 10% la vida máxima. Cada vez que se activa la resistencia a la muerte, se coloca 1 carta «Destello de Llave de Plata» en la mano.\n·Herida sin fondo: Durante el combate contra el jefe, cada vez que la cantidad de recuperación de vida recibida por nuestro equipo alcance el 100% del límite de vida, el efecto de recuperación de vida recibido posteriormente se reducirá un 25%, pero la cantidad total de resistencia a la muerte actual aumentará un 25%. Se puede activar un máximo de 3 veces.\n·Lente prismática: Al inicio del turno, si el contraataque supera el 2000% del límite de vida, las capas del exceso se reducen a la mitad, y el contraataque permanente puede acumularse hasta un máximo de 6000% del límite de vida; si el veneno del enemigo supera el 3000% del límite de vida, las capas del exceso se reducen a la mitad, y el veneno puede acumularse hasta un máximo de 9000% del límite de vida. La bonificación de daño que obtiene el Ser Despertado según el contraataque se reduce un 70%, pero todo el veneno y el contraataque infligidos aumentan un 10%. Por cada Ser Despertado que despierte: al final del turno se obtiene un contraataque temporal equivalente al 25% del contraataque permanente actual; al final del turno enemigo se activa adicionalmente un 25% de veneno en todos los enemigos.\n·Cono de destino: El número de turnos en que los monstruos comunes usan «Mirada Fija» cambia a 6 turnos. Al inicio del turno 15, se coloca 1 carta «Límite del Cono de Luz» en la mano: recarga la energía de la llave de plata y la locura de todos los Seres Despertados hasta el valor máximo."
  },
  State_89559_Name = {
    Text = "Distorsión espacio-temporal"
  },
  State_89567_Desc = {
    Text = "El consumo de aritmética de esta carta se reduce en [StateArg1]."
  },
  State_89567_Name = {
    Text = "Reencarnación en la Tierra Aniquilada"
  },
  State_89568_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: Tras la muerte del portador, baraja todas las \"Habilidad\" con -[StateArg1] de consumo de aritmética en el mazo de robo y cambia su propiedad al aliado con más vida restante."
  },
  State_89568_Name = {
    Text = "Reencarnación en la Tierra Aniquilada"
  },
  State_89571_Name = {
    Text = "\"Teatro en llamas\""
  },
  State_89572_Desc = {
    Text = "Al inicio del turno, aplica <BurningKeywords:quemar> a [DescArg1] cartas aleatorias en el mazo del oponente y obtén [DescArg2] puntos de <PowerIconKeywords:fuerza> temporal. Cada 2 turnos, aumenta en 1 la cantidad de cartas quemadas y en [DescArg3] puntos la fuerza temporal obtenida."
  },
  State_89572_Name = {
    Text = "\"Teatro en llamas\""
  },
  State_89626_Desc = {
    Text = "Después de usar el Despertar con la llave de plata, coloca 1 carta \"Destello de llave de plata\" en tu mano. Cuando todos los Despertados hayan completado su despertar, al inicio de cada turno, descubre aleatoriamente 1 carta de apoyo de un Despertado."
  },
  State_89631_Desc = {
    Text = "Extra [Layer] saltos"
  },
  State_89634_Desc = {
    Text = "Despertar IV"
  },
  State_89634_Name = {
    Text = "Despertar IV"
  },
  State_89637_Desc = {
    Text = "La primera tarjeta de comando de cada turno tiene un efecto adicional 1 vez. Al aniquilar, se genera 1 tentáculo. Después de cambiar el tentáculo a la postura de \"Olas furiosas\", los efectos de impulso de 2 tarjetas de comando en este turno se activarán obligatoriamente y entrarán en el Espacio Hiperspacial, con un enfriamiento de 3 turnos."
  },
  State_89640_Desc = {
    Text = "Maestría en dominios aumenta 200 puntos. Al consumir el Horno Carmesí, el daño de los tentáculos aumenta un 15% del consumo. Cada vez que los tentáculos atacan, acumula [Arg3] puntos de Horno Carmesí."
  },
  State_89642_Desc = {
    Text = "Tamaño Máximo de la Mano +2, tras liberar Alienación, el Daño Final temporalmente aumenta en un 10%. Cuando una carta entra en el Espacio Hiperspacial, 1 \"Embrión\" en la mano se transforma en \"Vástago de la Pureza\". Por cada \"Embrión\" generado, el Coste de Aritmética de una carta aleatoria en el Espacio Hiperspacial se reduce en 1."
  },
  State_89669_Desc = {
    Text = "Despertar de la llave plateada 4"
  },
  State_89669_Name = {
    Text = "Despertar de la llave plateada 4"
  },
  State_89759_Desc = {
    Text = "Al liberar la llave, Ramona obtiene un 50% de tasa crítica temporal."
  },
  State_89759_Name = {
    Text = "Vínculo Precioso"
  },
  State_90023_Name = {
    Text = "Estado utilizado en la configuración de la tabla de constantes, temporalmente descartado."
  },
  State_90059_Desc = {
    Text = "Este turno, al recibir Daño activo o Daño de tentáculos, elimina Corrosión en igual cantidad y pierde PV equivalentes al [DescArg1]% de la cantidad eliminada; al recibir otro tipo de Daño, elimina Corrosión equivalente al 50% del Daño recibido."
  },
  State_90059_Name = {Text = "Corrosión"},
  State_90094_Name = {
    Text = "Pluma negra"
  },
  State_90218_Desc = {
    Text = "Equipo Único: Tamaño Máximo de la Mano +2, los efectos similares no se apilan. El escudo y el daño básico causados por el portador aumentan en <WeaponEffect_Num:[StateArg1]％>, después de entrar en el Turno Ultra, obtiene <WeaponEffect_Num:[StateArg2]> puntos de Alienación. Después de liberar \"Aniquilación\", todos los Despertados reciben un aumento de Daño Crítico Temporal de <WeaponEffect_Num:[StateArg3]％>, con un enfriamiento de 3 rondas."
  },
  State_90218_WeaponDesc = {
    Text = "Tamaño Máximo de la Mano +2, los efectos similares no se apilan. El escudo y el daño básico causados por el portador aumentan en <WeaponEffect_Num:[StateArg1]%>, al entrar en el Turno Ultra obtiene <WeaponEffect_Num:[StateArg2]> puntos de alienación. Tras liberar \"Aniquilación\", todos los despertados obtienen un daño crítico temporal +<WeaponEffect_Num:[StateArg3]%>, 3 turnos de enfriamiento."
  },
  State_90221_Desc = {
    Text = "Equipo único: El escudo infligido por el portador aumenta <WeaponEffect_Num:[StateArg1]%>, y al final del turno obtiene un escudo equivalente al <WeaponEffect_Num:[StateArg2]%> de la defensa del portador, aumentando un <WeaponEffect_Num:2%> de la defensa cada turno."
  },
  State_90221_Name = {
    Text = "Pluma Solitaria"
  },
  State_90221_WeaponDesc = {
    Text = "El escudo infligido por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>, y al final del turno obtiene <WeaponEffect_Num:[Block:DescArg1]> puntos de escudo."
  },
  State_90294_Desc = {
    Text = "Este turno, al recibir Daño activo o Daño de tentáculos, elimina Corrosión en igual cantidad y pierde PV equivalentes al [DescArg1]% de la cantidad eliminada; al recibir otro tipo de Daño, elimina Corrosión equivalente al 50% del Daño recibido."
  },
  State_90294_Name = {
    Text = "<Corrosion:Corrosión>"
  },
  State_90591_Name = {
    Text = "Coloca [Layer] cartas de \"Inspiración\" en tu mano"
  },
  State_90594_Name = {
    Text = "y [Layer] puntos de alerta temporal"
  },
  State_90599_Name = {
    Text = "Hacer que todos los Despertados obtengan [Layer] puntos de locura"
  },
  State_90600_Name = {
    Text = "Obtén [Layer] puntos de energía-s de llave de plata"
  },
  State_90601_Name = {
    Text = "(Restante [DescArg1] veces <harmonyKeyWord:«Armonización»>)"
  },
  State_90603_Name = {
    Text = "Obtener [Layer] puntos de fuerza temporal"
  },
  State_90604_Name = {
    Text = "Recupera [Layer] puntos de vida, aumentado por la vida perdida."
  },
  State_90696_Desc = {
    Text = "Descubre 1 «condimento» antes de jugarlo, incorpóralo y activa su efecto. En combate contra el jefe, aumenta en 1 la cantidad de armonizaciones."
  },
  State_90696_Name = {
    Text = "<harmonyKeyWord:armonía>"
  },
  State_91106_Desc = {
    Text = "Cada capa de fervor hace que el daño activo y el daño de tentáculo causen un 10% adicional de daño equivalente en <BleedingIconKeywords:sangrando>."
  },
  State_91106_Name = {Text = "Fervor"},
  State_91165_Name = {
    Text = "Huevo Pálido"
  },
  State_91235_Desc = {
    Text = "Al perder PV, reduce un número igual de Acumulaciones. Cuando Herida llega a 0, todos los Despertados ganan 10 de Alienación y reinician las Acumulaciones de Herida."
  },
  State_91235_Name = {Text = "Lesión"},
  State_91236_Name = {
    Text = "Evento Roma aplica el contador de vida del jefe"
  },
  State_91329_Desc = {
    Text = "El consumo de aritmética de esta carta se reduce en [StateArg1]."
  },
  State_91329_Name = {
    Text = "Manjar Exquisito"
  },
  State_91521_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Al final del turno, baraja [StateArg1] <PVPDerivativeCardKeywords_17:\"Perspicacia\"> en la mano."
  },
  State_91521_Name = {
    Text = "Entrenamiento de compañeros"
  },
  State_91522_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Al equipar y al final del turno, el Portador inflige <Damage:[Damage:StateArg1]> Daño al enemigo en la retaguardia."
  },
  State_91522_Name = {
    Text = "Día de inicio del curso escolar"
  },
  State_91676_Desc = {
    Text = "Consulta la lógica de huelga general para efectos específicos. __ \"Solo para uso de desarrollo\""
  },
  State_91706_Desc = {
    Text = "Al inicio del próximo turno, obtén aritmética equivalente a las capas."
  },
  State_91706_Name = {
    Text = "<CardKeyWord:Retención de aritmética>"
  },
  State_91717_Desc = {
    Text = "Se acumulan hasta 3 unidades; al alcanzar el límite, la próxima \"Gala necrótica\" podrá consumirlas y mejorar su efecto. Los restos se heredarán a la siguiente batalla."
  },
  State_91717_Name = {Text = "escombros"},
  State_91759_Desc = {
    Text = "Pluma Negra puede fortalecer la habilidad de \"Santo Hijo·Pluma Negra\"."
  },
  State_91759_Name = {
    Text = "Pluma negra"
  },
  State_91761_Desc = {
    Text = "\"Hijo Divino·Pluma Negra\"El 50% del escudo no destruido se mantendrá hasta el próximo turno, y al final del turno obtendrás 1 capa de <Guaiwuheiyu:Pluma Negra>."
  },
  State_91761_Name = {
    Text = "Aspiraciones en alza"
  },
  State_91797_Desc = {
    Text = "Después de que esta carta sea jugada y descartada, aplica una cantidad igual de capas de escudo a los enemigos de la fila frontal."
  },
  State_91797_Name = {
    Text = "<PVPredKeyword:Dolor oculto>"
  },
  State_91799_Desc = {
    Text = "Esta carta, al ser jugada, otorga al enemigo de la primera fila [Layer] escudo."
  },
  State_91799_Name = {
    Text = "<PVPredKeyword:Dolor oculto [Layer]>"
  },
  State_91809_Desc = {
    Text = "El consumo de aritmética de esta carta se reduce en [Layer]."
  },
  State_91809_Name = {
    Text = "Concentración mental"
  },
  State_91819_Desc = {
    Text = "Obtiene la mejora correspondiente según el turno de batalla actual."
  },
  State_91819_Name = {
    Text = "<CardKeyWord:Crecimiento>"
  },
  State_91827_Desc = {
    Text = "\"Golpe\" puede seleccionar un objetivo. Antes de \"Golpe\", retrocede todos los estados positivos del objetivo a los despertadores detrás de él."
  },
  State_91827_Name = {
    Text = "<CardKeyWord:Llamada del Mar Profundo>"
  },
  State_94410_Name = {
    Text = "Al comienzo de cada turno y después de que terminen las acciones, intentará reiniciar el mazo vacío del jugador; si no está vacío, no se reiniciará.__\"Solo para uso en desarrollo\""
  },
  State_94411_Name = {
    Text = "Al comienzo de cada turno y después de que terminen las acciones, intentará reiniciar el mazo vacío del jugador; si no está vacío, no se reiniciará.__\"Solo para uso en desarrollo\""
  },
  State_94426_Name = {
    Text = "Blindaje pasivo"
  },
  State_94540_Desc = {
    Text = "Si no hay otros Despertados detrás del objetivo, dispersa el estado positivo del objetivo."
  },
  State_94540_Name = {
    Text = "<CardKeyWord:Rechazar estados positivos>"
  },
  State_94600_Desc = {
    Text = "Después de recibir daño fatal, elimina 1 capa y recupera el 5% de la vida máxima. Cada activación en este turno aumenta la cantidad recuperada en 1%."
  },
  State_94600_Name = {
    Text = "Resistencia a la muerte"
  },
  State_94603_Name = {
    Text = "Marca de No-muerto"
  },
  State_94608_Name = {
    Text = "Número de activaciones de resistencia a la muerte"
  },
  State_94623_Desc = {
    Text = "Cada capa de fervor hace que el daño activo y el daño de tentáculo causen un 10% adicional de daño equivalente en <BleedingIconKeywords:sangrando>."
  },
  State_94623_Name = {
    Text = "<Kuangre:Fervor>"
  },
  State_94657_Desc = {
    Text = "Al matar a un enemigo o activar su efecto de resurrección, se activa el efecto correspondiente"
  },
  State_94657_Name = {
    Text = "<KillKeywords:Derribar>"
  },
  State_94692_Desc = {
    Text = "Después de recibir daño fatal, elimina 1 capa y recupera el 5% de la vida máxima. Cada activación en este turno aumenta la cantidad recuperada en 1%."
  },
  State_94692_Name = {
    Text = "<Guaiwusiwangdikang: Resistencia>"
  },
  State_94693_Desc = {
    Text = "Al inicio del turno, si existen otros aliados, pierde [DescArg1] puntos de vida y añade 1 capa de <Guaiwusiwangdikang: resistencia a la muerte> y [DescArg2] puntos de <PowerIconKeywords: fuerza> al aliado con mayor vida."
  },
  State_94693_Name = {
    Text = "División de un cadáver en descomposición"
  },
  State_94708_Desc = {
    Text = "Al inicio del turno, si existen otros aliados, pierde [DescArg1] puntos de vida y añade 1 capa de <Guaiwusiwangdikang: resistencia a la muerte> y [DescArg2] puntos de <Duren: hoja envenenada> al aliado con mayor cantidad de vida."
  },
  State_94708_Name = {
    Text = "División del Mar Profundo"
  },
  State_94730_Desc = {
    Text = "Deal daño activo que no está bloqueado, aplicar [Layer] puntos de <IntoxicationIconKeywords:veneno>."
  },
  State_94730_Name = {
    Text = "Hoja envenenada"
  },
  State_94993_Desc = {
    Text = "Reinicia el número de veces de Marea furiosa cada turno."
  },
  State_94993_Name = {
    Text = "Reiniciar número de veces de la Marea furiosa épica"
  },
  State_94994_Desc = {
    Text = "Cada capa añade 1 ataque, pierde 1 capa al recibir daño crítico, mínimo 1 capa, pierde todas al final del turno."
  },
  State_94994_Name = {
    Text = "Veces de la marea furiosa épica"
  },
  State_94995_Desc = {
    Text = "Cada vez que recibes Daño Crítico, obtienes un 3% de <Baojidikang:Res. Crítica Temporal>. Cada vez que causas Daño, añades \"Marca de Inmersión Profunda\" a una carta aleatoria."
  },
  State_94995_Name = {
    Text = "Ritual de sacrificio del mar profundo"
  },
  State_94996_Desc = {
    Text = "Al recibir un ataque, obtén capas equivalentes de fuerza temporal."
  },
  State_94996_Name = {Text = "Furia"},
  State_94997_Desc = {
    Text = "Cada vez que recibes Daño Crítico, obtienes un 5% de <Baojidikang:Res. Crítica Temporal>. Cada vez que causas Daño, añades \"Marca de Inmersión Profunda\" a una carta aleatoria."
  },
  State_94997_Name = {
    Text = "Ritual de sacrificio del mar profundo"
  },
  State_94998_Desc = {
    Text = "Al activarse <Guaiwusiwangdikang: Resistencia a la muerte>, aplica <SlowIconKeywords:ralentización> a una carta aleatoria del mazo de robo o de la mano."
  },
  State_94998_Name = {
    Text = "Encarnación del Desespero"
  },
  State_94999_Desc = {
    Text = "Reinicia el número de usos de Marea Devora Cielos cada turno."
  },
  State_94999_Name = {
    Text = "Reiniciar número de veces de la Marea Devora Cielos"
  },
  State_95000_Desc = {
    Text = "Inmunidad a estados negativos."
  },
  State_95000_Name = {
    Text = "Inmunidad a estados negativos"
  },
  State_95001_Desc = {
    Text = "Cada capa añade 1 ataque, pierde 1 capa al recibir daño crítico, mínimo 1 capa, pierde todas al final del turno."
  },
  State_95001_Name = {
    Text = "Marea Devora Cielos - Número de veces"
  },
  State_95002_Desc = {
    Text = "Este turno, la probabilidad de recibir un golpe crítico se reduce en [Layer]%."
  },
  State_95002_Name = {
    Text = "Resistencia a críticos temporal"
  },
  State_95002_WeaponDesc = {
    Text = "Este turno, la probabilidad de recibir un golpe crítico se reduce en [Layer]%."
  },
  State_95035_Desc = {
    Text = "Al tratar daño activo que no esté bloqueado, aplica 1 punto de <IntoxicationIconKeywords: veneno> por cada capa."
  },
  State_95035_Name = {
    Text = "<Duren: Cuchilla Envenenada>"
  },
  State_95038_Desc = {
    Text = "Al recibir un ataque, obtén capas equivalentes de fuerza temporal."
  },
  State_95038_Name = {
    Text = "<Kuangbao: Rabia>"
  },
  State_95040_Desc = {
    Text = "Registra vida perdida"
  },
  State_95040_Name = {
    Text = "Registra vida perdida"
  },
  State_95932_Name = {
    Text = "Absorber de Ghoul Esperando"
  },
  State_95937_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Después de \"Exaltar\", roba [StateArg1] <plural value=\"[StateArg1]\" singular=\"carta\" plural=\"cartas\">, priorizando las cartas de \"Habilidad\" propias, y reduce su Coste de Aritmética en [StateArg2]."
  },
  State_95937_Name = {
    Text = "Manjar Exquisito"
  },
  State_95938_Desc = {
    Text = "Por cada carta eliminada, aumenta 1 capa de saciedad. Límite de 10 capas."
  },
  State_95938_Name = {Text = "Saciedad"},
  State_95943_Desc = {
    Text = "El daño infligido se reduce temporalmente en un 30%."
  },
  State_95943_Name = {
    Text = "Interferencia"
  },
  State_95944_Desc = {
    Text = "Equipo Único: El daño básico infligido por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>, y por cada enemigo que mate, la probabilidad de crítico del portador aumenta en un 2% durante esta exploración, además, el daño básico de la explosión de locura aumenta en <WeaponEffect_Num:[StateArg2]%>, acumulándose hasta 10 veces. Si el reino actual es \"Carne y sangre\", al usar \"Embrión\" directamente sobre el portador, se obtienen <WeaponEffect_Num:[StateArg4]> puntos de locura, con un enfriamiento de 3 turnos."
  },
  State_95944_WeaponDesc = {
    Text = "El daño básico causado por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>, y por cada enemigo que mate, la probabilidad de crítico del portador aumenta en un 2% durante esta exploración, además, el daño básico de la explosión de locura del portador aumenta en <WeaponEffect_Num:[StateArg2]%>, acumulándose hasta 10 veces. Si el reino actual es \"Carne y sangre\", al usar directamente el \"Embrión\" sobre el portador, se obtienen <WeaponEffect_Num:[StateArg4]> puntos de locura, con un tiempo de recarga de 3 turnos."
  },
  State_95948_Name = {
    Text = "Absorber de Ghoul"
  },
  State_95949_Desc = {
    Text = "Al jugar, hace que Dulse pierda la mitad de <Guaiwucanhai:escombros>."
  },
  State_95949_Name = {Text = "Emboscada"},
  State_95953_Desc = {
    Text = "El efecto de recuperación de vida de la resistencia a la muerte aumenta a 5 veces."
  },
  State_95953_Name = {
    Text = "Velo de Murmuros"
  },
  State_95954_Name = {
    Text = "Absorber de Ghoul - Versión de Despertar"
  },
  State_95960_Desc = {
    Text = "La cantidad de escombros aumenta el efecto de \"Recogida de escombros\"."
  },
  State_95960_Name = {Text = "escombros"},
  State_95962_Name = {
    Text = "Contador de muertes __ \"Solo para uso en desarrollo\""
  },
  State_95964_Desc = {
    Text = "Equipo único: El daño base causado por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Si el dominio actual es \"Carne\", cuando el portador derrota a un enemigo, acumula <WeaponEffect_Num:[StateArg2]%> del ataque del portador en el Horno Carmesí."
  },
  State_95964_WeaponDesc = {
    Text = "El daño base causado por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Si el dominio actual es \"Carne\", cuando el portador derrota a un enemigo, acumula <WeaponEffect_Num:[DescArg1]> puntos de recuperación del Horno Carmesí."
  },
  State_95966_Desc = {
    Text = "Al inicio del próximo turno, roba [Layer] cartas de este Despertado."
  },
  State_95966_Name = {
    Text = "Cruel homenaje"
  },
  State_95967_Desc = {
    Text = "La cantidad de escombros aumenta el efecto de \"Recogida de escombros\"."
  },
  State_95967_Name = {
    Text = "<Guaiwucanhai:Esqueleto>"
  },
  State_95968_Desc = {
    Text = "<PVPWeaponKeywords:rueda del destino>: Al equipar, obtiene [StateArg1] <StrongEffectKeywords:fuerte>. El daño excedente al derrotar a un enemigo se transfiere al objetivo siguiente."
  },
  State_95968_Name = {
    Text = "Beso del Descanso"
  },
  State_96167_Desc = {
    Text = "No se puede disipar. Después de que un Despertado sea asesinado, otros aliados reciben [StateArg1] <StrongEffectKeywords:Amplificación>."
  },
  State_96167_Name = {
    Text = "Ceniza Ardiente de la Estrella Negra"
  },
  State_96183_Desc = {
    Text = "Al final del turno, si no hay otros aliados en el campo, cambia la intención a autodestrucción"
  },
  State_96183_Name = {
    Text = "Auto-destrucción de ghoul"
  },
  State_96193_Name = {
    Text = "Etiqueta previa a la comida"
  },
  State_96330_Desc = {
    Text = "Por cada 1% de vida perdida, el daño base, escudo y locura generados por las cartas de comando de Dursain aumentan un 1%."
  },
  State_96330_Name = {
    Text = "Susurros Fantasmas"
  },
  State_96352_Name = {
    Text = "Contador del primer Ghoul"
  },
  State_96354_Name = {
    Text = "Salud máxima inicial"
  },
  State_96355_Desc = {
    Text = "La probabilidad de recibir un golpe crítico se reduce en [Layer]%."
  },
  State_96355_Name = {
    Text = "Res. Crítica"
  },
  State_96355_WeaponDesc = {
    Text = "En esta batalla, la probabilidad de recibir un golpe crítico disminuye en [Layer]%."
  },
  State_96356_Desc = {
    Text = "Por cada [DescArg1] puntos de vida perdidos, obtén [DescArg2] capas de <ReinforcePVEKeywords:reforzado>, con un límite de [DescArg3] capas. Después de activar \"<Guaiwusiwangdikang:resistencia a la muerte>\", tu vida máxima aumenta un [DescArg4]%."
  },
  State_96356_Name = {
    Text = "Protección de Elena"
  },
  State_96357_Desc = {
    Text = "Después de que termine el turno, obtiene capas equivalentes de fuerza"
  },
  State_96357_Name = {
    Text = "<Fennu: Ira>"
  },
  State_96358_Desc = {
    Text = "La probabilidad de recibir un golpe crítico se reduce en [Layer] %."
  },
  State_96358_Name = {
    Text = "<Baojidikang:Resistencia a críticos>"
  },
  State_96412_Name = {
    Text = "Voraz Monitoreo"
  },
  State_96416_Desc = {
    Text = "La probabilidad de recibir un golpe crítico se reduce en [Layer]%."
  },
  State_96416_Name = {
    Text = "Res. Crítica"
  },
  State_96603_Name = {
    Text = "Si no se juega este turno, al inicio del próximo turno se activa una vez el efecto \"armonización\""
  },
  State_96610_Name = {
    Text = "Primera resistencia a la muerte"
  },
  State_96613_Name = {
    Text = "Eco de la marea furiosa"
  },
  State_96650_Desc = {
    Text = "Cada capa aumenta la tasa crítica de todos los Despertadores en [DescArg1]%."
  },
  State_96650_Name = {
    Text = "<ExclamationPointColour:Llama Oscura Profunda>"
  },
  State_96719_Desc = {
    Text = "Cuando se juega una carta de <BurningKeywords:Burning> este turno, agota 1 capa de <Heat:Llama Oscura> para hacerla efectiva 2 veces, y borra <Heat:Llama Oscura> al final del turno."
  },
  State_96719_Name = {
    Text = "Llamas infinitas"
  },
  State_96731_Desc = {
    Text = "Cuando se juega una carta de <BurningKeywords:Burning> este turno, agota 1 capa de <Heat:Llama Oscura> para hacerla efectiva 2 veces, y borra <Heat:Llama Oscura> al final del turno."
  },
  State_96731_Name = {
    Text = "<Overload:Inflamación Infinita>"
  },
  State_96732_Desc = {
    Text = "Cada capa aumenta la tasa crítica de todos los Despertadores en [DescArg1]%."
  },
  State_96732_Name = {
    Text = "<Heat:Llama Profunda y Oscura>"
  },
  State_96740_Desc = {
    Text = "El daño de los ataques activos y el número de capas de sangrado se incrementan en un 50%, y el daño se elimina al comienzo de cada ronda."
  },
  State_96740_Name = {
    Text = "<CardKeyWord:Agujero>"
  },
  State_96741_Desc = {
    Text = "Si la Aritmética restante es mayor que [StateArg1] después de jugar, además consume [StateArg1] Aritmética para activar efectos posteriores. __ \"Solo para Desarrollo\""
  },
  State_96741_Name = {
    Text = "<CardKeyWord:Sobrecarga de aritmética>"
  },
  State_96742_Name = {
    Text = "Marcador de activación de sobrecarga aritmética"
  },
  State_96743_Desc = {
    Text = "Después de jugar, si la aritmética restante supera la necesaria para la sobrecarga, se consumirá aritmética adicional para activar el efecto secundario."
  },
  State_96743_Name = {
    Text = "<CardKeyWord:Sobrecarga Aritmética>"
  },
  State_96744_Desc = {
    Text = "El daño de los ataques activos y el número de capas de sangrado se incrementan en un 50%, y el daño se elimina al comienzo de cada ronda."
  },
  State_96744_Name = {Text = "Defecto"},
  State_96774_Desc = {
    Text = "Cada vez que recibes daño crítico, obtienes un 3% de resistencia crítica temporal."
  },
  State_96774_Name = {
    Text = "Espíritu Vengativo del Mar Profundo"
  },
  State_96780_Desc = {
    Text = "La carta conserva su uso, pero cuando se juega o se descarta, eliminará la contaminación e invocará 1 \"Aequor Spawn\", hasta 2. Si no hay espacio para invocar, otorgará inmediatamente a la marioneta de putrefacción [DescArg1] fuerza y [DescArg2] hp."
  },
  State_96780_Name = {
    Text = "<Kuangluan:Marinero frenético>"
  },
  State_96783_Desc = {
    Text = "Cada turno, añade \"<Kuangluan:Frenesí del Marchador de mares>\" a 2 cartas."
  },
  State_96783_Name = {
    Text = "Ritual del Marchador de mares"
  },
  State_96784_Desc = {
    Text = "Puede reducir la ofensiva del Muñeco de la Marea Corrupta, con un máximo de 5 capas."
  },
  State_96784_Name = {Text = "Caos"},
  State_96808_Desc = {
    Text = "Por cada [DescArg1] puntos de vida perdidos, obtén 15 capas de \"<ReinforcePVEKeywords:fortaleza>\", con un límite de 75 capas. Tras ser roto, se vaciarán y obtendrás 1 capa de \"<Chaos:caos>\". Si no has liberado \"Reconstrucción de la carne\", al recibir daño letal, cambia la intención a \"Reconstrucción de la carne\" e inmunízate de todo daño."
  },
  State_96808_Name = {
    Text = "«Muñeco de la quimera»"
  },
  State_96809_Name = {
    Text = "Contador del Juego de Marionetas Quimérico"
  },
  State_96810_Desc = {
    Text = "El daño infligido se reduce en un 25%."
  },
  State_96810_Name = {
    Text = "Velo de Murmuros"
  },
  State_96813_Name = {
    Text = "Reorganizar marcador"
  },
  State_97114_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: \"Golpe\" gana [StateArg1] aritmética, \"Habilidad\" DMG +[StateArg2]%."
  },
  State_97114_Name = {
    Text = "Sol Impending"
  },
  State_97118_Name = {
    Text = "Muñeco de la quimera rota"
  },
  State_97119_Desc = {
    Text = "La carta conserva su uso, pero cuando se juega o se descarta, eliminará la contaminación e invocará 1 \"Aequor Spawn\", hasta 2. Si no hay espacio para invocar, otorgará inmediatamente a la marioneta de putrefacción [DescArg1] fuerza y [DescArg2] hp."
  },
  State_97119_Name = {
    Text = "<Kuangluan:Marinero frenético>"
  },
  State_97120_Desc = {
    Text = "Protegido por el Círculo mágico, todo el daño causado por todos los enemigos se reduce en un 25%."
  },
  State_97120_Name = {
    Text = "Velo de Murmuros"
  },
  State_97131_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Por cada 1 de Aritmética que necesite consumir la \"habilidad\", el Daño aumenta un [StateArg1]%. Después de Matar, el Daño de \"Exaltar\" aumenta un [StateArg2]%, bonificación actual [DescArg1]%."
  },
  State_97131_Name = {
    Text = "Muerte ámbar"
  },
  State_97134_Desc = {
    Text = "El daño final causado aumenta un 50%."
  },
  State_97134_Name = {
    Text = "Cantar de Selene"
  },
  State_97135_Desc = {
    Text = "El daño final causado aumenta un 25%."
  },
  State_97135_Name = {
    Text = "Susurro de Selene"
  },
  State_97136_Desc = {
    Text = "El daño final causado aumenta un 100%."
  },
  State_97136_Name = {
    Text = "Canto elevado de Selene"
  },
  State_97137_Desc = {
    Text = "Vuelve a tu mano al descartarla."
  },
  State_97137_Name = {
    Text = "Vuelve a tu mano al descartarla"
  },
  State_97137_WeaponDesc = {
    Text = "Al robar, te debilitas durante 1 turno. Al usar, debilita a todos los enemigos durante 1 turno. No se puede vender"
  },
  State_97219_Desc = {
    Text = "Las siguientes <plural value=\"[Layer]\" singular=\"carta\" plural=\"cartas\"> que Wanda juegue surten efecto 1 vez adicional."
  },
  State_97219_Name = {
    Text = "Reina de Espinas"
  },
  State_97251_Desc = {
    Text = "No puede ser objetivo ni priorizado por ataques enemigos ni habilidades de objetivo único.\nEliminación automática: Si la unidad obtiene Pulla; si no quedan aliados; si algún enemigo obtiene Pulla.\nAl activarse: Elimina el sigilo actual y la Pulla de cualquier aliado."
  },
  State_97251_Name = {Text = "sigilo"},
  State_97252_Desc = {
    Text = "No puede ser objetivo ni priorizado por ataques enemigos ni habilidades de objetivo único.\nEliminación automática: Si la unidad obtiene Pulla; si no quedan aliados; si algún enemigo obtiene Pulla.\nAl activarse: Elimina el sigilo actual y la Pulla de cualquier aliado."
  },
  State_97252_Name = {
    Text = "<PVPSneakKeywords:Sigilo>"
  },
  State_97339_Name = {
    Text = "Copa de Oro de Missaga"
  },
  State_97742_Desc = {
    Text = "Cada vez que se recibe Daño Activo, inflige [Layer] de <FixedDamage:DMG Puro> a la fuente del daño."
  },
  State_97742_Name = {
    Text = "Contrataque"
  },
  State_97743_Desc = {
    Text = "El daño activo causado aumenta en [Layer] puntos"
  },
  State_97743_Name = {
    Text = "<PowerColourKeywords:Fuerza>"
  },
  State_97744_Desc = {
    Text = "El daño recibido -[Layer]%."
  },
  State_97744_Name = {
    Text = "<ReinforceColour: reforzado>"
  },
  State_97744_WeaponDesc = {
    Text = "Todo el daño infligido se reduce en [DescArg1] %"
  },
  State_97938_Desc = {
    Text = "Daño final aumentado en [DescArg1]%."
  },
  State_97938_Name = {
    Text = "Copa de Oro del Campeonato de Missaga"
  },
  State_97939_Desc = {
    Text = "El daño final causado aumenta un 50%."
  },
  State_97939_Name = {
    Text = "Copa de Oro del Campeonato de Missaga"
  },
  State_97941_Desc = {
    Text = "Daño base aumentado en un 100%."
  },
  State_97941_Name = {
    Text = "Copa de Oro de Missaga"
  },
  State_97942_Desc = {
    Text = "Al liberar la exaltación, obtén 35 puntos de locura."
  },
  State_97942_Name = {
    Text = "Copa de Oro de Missaga"
  },
  State_97943_Name = {
    Text = "Contador de retención de aritmética"
  },
  State_98055_Desc = {
    Text = "Al final del turno, genera 1 tentáculo. Al despertar, elimina este estado"
  },
  State_98055_Name = {Text = "Sueño"},
  State_98060_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, restaurará su vida y comenzará a luchar en su verdadera forma"
  },
  State_98060_Name = {
    Text = "No Activado"
  },
  State_98068_Desc = {
    Text = "Cuando tengas 10 capas de \"Llama explosiva\", obtén 2 puntos de aritmética y mejora todas las \"llamaradas gigantes\" a \"llamaradas termonucleares\"."
  },
  State_98068_Name = {
    Text = "<BaoyanKeywords:Explosión ardiente>"
  },
  State_98139_Desc = {
    Text = "Al inicio del turno del oponente, quema aleatoriamente 1 carta en la mano."
  },
  State_98139_Name = {
    Text = "Estado@Despertar del monstruo Ketigula"
  },
  State_98140_Desc = {
    Text = "Después de acumular 10 capas de <MonsterExFlameKeywords:Explosión ardiente>, cambia la intención a \"Billones de destellos\" de daño extremadamente alto!"
  },
  State_98140_Name = {
    Text = "<BurningColor:Explosión ardiente>"
  },
  State_98147_Desc = {
    Text = "Cuando el enemigo juega cartas <BurningKeywords:quemar>, otórgate 1 capa de <MonsterExFlameKeywords:Explosión ardiente>, pero reduce temporalmente [DescArg1] <PowerIconKeywords:Fuerza>."
  },
  State_98147_Name = {
    Text = "Estado@monstruo Ketigura escucha la quema"
  },
  State_98148_Desc = {
    Text = "Este despertador aún no ha despertado... despertará cuando esté a punto de ser derrotado, descartará todas las cartas en mano restantes y otorgará <BurningKeywords:Quemar>, recuperará PV y comenzará a luchar en su verdadera forma."
  },
  State_98148_Name = {
    Text = "No Activado"
  },
  State_98302_Desc = {
    Text = "Equipo único: El daño base infligido por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>, y el daño de poder infligido aumenta en <WeaponEffect_Num:[StateArg2]%>. Después de jugar una carta de comando del portador, obtiene poder temporal igual al <WeaponEffect_Num:[StateArg3]%> del ataque del portador. Este efecto puede activarse un máximo de 5 veces por turno."
  },
  State_98302_WeaponDesc = {
    Text = "El daño base infligido por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>, y el poder infligido aumenta en <WeaponEffect_Num:[StateArg2]%>. Después de jugar una carta de comando del portador, obtiene <WeaponEffect_Num:[Power:DescArg1]> puntos de fuerza temporal, activándose un máximo de 5 veces por turno (actualmente se ha activado [DescArg2]/5 veces)."
  },
  State_98323_Desc = {
    Text = "La carta volverá a tu mano después de ser descartada"
  },
  State_98323_Name = {
    Text = "Vuelve a tu mano al descartarla"
  },
  State_98341_Desc = {
    Text = "Puede mezclarse con otros colores primarios para convertirse en un nuevo color."
  },
  State_98341_Name = {
    Text = "<Yellow:Primario: Amarillo>"
  },
  State_98344_Desc = {
    Text = "Puede mezclarse con otros colores primarios para convertirse en un nuevo color."
  },
  State_98344_Name = {
    Text = "<Red:Color primario: Rojo>"
  },
  State_98345_Desc = {
    Text = "Puede mezclarse con otros colores primarios para convertirse en un nuevo color."
  },
  State_98345_Name = {
    Text = "<Blue:Primario·Azul>"
  },
  State_98366_Desc = {
    Text = "Al inicio del turno, si la energía de llave de plata es mayor que [Arg1], consume [Arg1] puntos de energía de llave de plata para añadir 1 <DerivativeCardKeywords_115:«inspiración avanzada»> a la mano."
  },
  State_98435_Desc = {
    Text = "Producido por la mezcla de rojo y azul, al causar 1 daño activo, obtén <Block: [DescArg1]> puntos de escudo."
  },
  State_98435_Name = {
    Text = "<PurpleKeyWord:Ilusión·Púrpura>"
  },
  State_98436_Desc = {
    Text = "Producido por la mezcla de rojo y amarillo, al liberar la exaltación, el despertador correspondiente obtiene <Energy:15> puntos de locura."
  },
  State_98436_Name = {
    Text = "<ExclamationPointColour:Visión·Naranja>"
  },
  State_98437_Desc = {
    Text = "El daño final causado aumenta un 10%."
  },
  State_98437_Name = {
    Text = "<Red:Color primario: Rojo>"
  },
  State_98438_Desc = {
    Text = "Proveniente de la mezcla de amarillo y azul, al jugar \"Defensa\", recupera <Heal:[DescArg1]> puntos de vida."
  },
  State_98438_Name = {
    Text = "<GreenWord:Visión·Verde>"
  },
  State_98439_Desc = {
    Text = "Producido por la mezcla de tonos amarillos y azules, al jugar \"Defensa\", recupera <Heal:[DescArg1]> puntos de vida."
  },
  State_98439_Name = {
    Text = "<GreenWord:Visión·Verde>"
  },
  State_98440_Desc = {
    Text = "Proviene de la mezcla de rojo y azul, al causar 1 daño activo, obtén <Block: [DescArg1]> puntos de escudo."
  },
  State_98440_Name = {
    Text = "<PurpleKeyWord:Ilusión·púrpura>"
  },
  State_98441_Desc = {
    Text = "Derivado de la mezcla de rojo y amarillo, al liberar la exaltación, el despertador correspondiente obtiene <Energy:15> puntos de locura."
  },
  State_98441_Name = {
    Text = "<ExclamationPointColour:Visión·Naranja>"
  },
  State_98444_Desc = {
    Text = "Equipo único: El daño base infligido por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Después de jugar 5 cartas de comando del portador, el portador obtiene <WeaponEffect_Num:[StateArg2]%> de tasa crítica. Este efecto solo puede activarse una vez por turno."
  },
  State_98444_WeaponDesc = {
    Text = "El daño base infligido por el portador aumenta en <WeaponEffect_Num:[StateArg1]%>. Después de jugar 5 cartas de comando del portador, este obtiene <WeaponEffect_Num:[StateArg2]%> de tasa crítica; este efecto solo puede activarse una vez por turno (actualmente se han jugado [DescArg1]/5 cartas)."
  },
  State_98466_Name = {
    Text = "<HuoyanKeywords1:Llama viva 1>"
  },
  State_98468_Name = {
    Text = "<HuoyanKeywords3:Llama viva 3>"
  },
  State_98470_Name = {
    Text = "<HuoyanKeywords2:Llama viva 2>"
  },
  State_98474_Desc = {
    Text = "Son los colores primarios que pueden mezclarse para obtener otros colores, compuestos por rojo, amarillo y azul."
  },
  State_98474_Name = {Text = "Primario"},
  State_98484_Name = {
    Text = "Ahogándose en el dolor"
  },
  State_98485_Desc = {
    Text = "El Daño Final y la Fortaleza otorgados por esta carta +[DescArg1]%; Escudo del personaje y Aliemus +[DescArg2]%. Obtiene \"Retener\". Al jugarla, se consumen todas las acumulaciones de \"llama viva\" y se transfiere 1 acumulación de \"llama viva\" a otra Tarjeta de comando de Katie Gula en tu mano."
  },
  State_98485_Name = {
    Text = "<HuoyanKeywords2:Llama viva 2>"
  },
  State_98486_Desc = {
    Text = "El Daño Final y la Fortaleza otorgados por esta carta +[DescArg1]%; Escudo del personaje y Aliemus +[DescArg2]%. Obtiene \"Retener\". Al jugarla, se consumen todas las acumulaciones de \"llama viva\" y se transfiere 1 acumulación de \"llama viva\" a otra Tarjeta de comando de Katie Gula en tu mano."
  },
  State_98486_Name = {
    Text = "<HuoyanKeywords3:Llama viva 3>"
  },
  State_98487_Desc = {
    Text = "El Daño Final y la Fortaleza otorgados por esta carta +[DescArg1]%; Escudo del personaje y Aliemus +[DescArg2]%. Obtiene \"Retener\". Al jugarla, se consumen todas las acumulaciones de \"llama viva\" y se transfiere 1 acumulación de \"llama viva\" a otra Tarjeta de comando de Katie Gula en tu mano."
  },
  State_98487_Name = {
    Text = "<HuoyanKeywords1:Llama viva 1>"
  },
  State_98488_Desc = {
    Text = "Cada capa de \"llama viva\" aumenta en un 30% el daño final, el escudo, la locura y el poder que genera la carta, acumulándose hasta 3 capas. Las cartas que poseen \"llama viva\" obtienen \"Retener\", y al jugarlas consumen todas las capas de \"llama viva\" y transfieren 1 capa de \"llama viva\" a otra carta de comando aleatoria de Katigura en tu mano."
  },
  State_98488_Name = {
    Text = "<HuoyanKeywords:Llama viva>"
  },
  State_98492_Desc = {
    Text = "Al comenzar la exploración, aumentan la Constitución, el Ataque y la Defensa en [StateArg1]%"
  },
  State_98492_Name = {
    Text = "Afinidad Espiritual"
  },
  State_98495_Desc = {
    Text = "Al comenzar la exploración, aumentan la Constitución, el Ataque y la Defensa en [StateArg1]%"
  },
  State_98495_Name = {
    Text = "Afinidad Espiritual"
  },
  State_98507_Desc = {
    Text = "Al comenzar la exploración, aumenta la constitución, el ataque y la defensa en [StateArg1]%"
  },
  State_98507_Name = {
    Text = "Afinidad Espiritual"
  },
  State_98511_Name = {
    Text = "Obtener carta derivada"
  },
  State_98551_Desc = {
    Text = "Al inicio de la batalla, aumenta la maestría de dominio en +[Arg1]. Al inicio de los turnos impares, roba 1 carta; al inicio de los turnos pares, obtén 1 punto de aritmética."
  },
  State_98553_Desc = {
    Text = "Cada vez que se genera un \"Embrion\", obtienes [Arg1] puntos de acumulación del Horno Carmesí, con un máximo de 3 activaciones por turno."
  },
  State_98555_Desc = {
    Text = "Al comenzar la batalla, obtienes [Arg1]% de efectividad. Al aplicar veneno por primera vez en cada turno, robas [Arg2] cartas."
  },
  State_98556_Desc = {
    Text = "El efecto base de recuperación de vida y escudo causado por todos los Despertados aumenta un [Arg1]%."
  },
  State_98557_Desc = {
    Text = "Cada vez que se genera un \"Embrion\", obtienes [Arg1] puntos de Horno Carmesí. Máximo 3 activaciones por turno."
  },
  State_98559_Desc = {
    Text = "Cada vez que robas o descartas una carta, obtienes [Arg1] de fuerza temporal, con un máximo acumulado de [Arg2] de fuerza temporal."
  },
  State_98560_Desc = {
    Text = "El daño base causado por todos los Despertados aumenta un [Arg1]%. Antes de liberar la exaltación, el daño base del Despertado que la libera aumenta temporalmente un [Arg2]%."
  },
  State_98561_Desc = {
    Text = "Al inicio del turno, si la vida es menor al 50%, el daño temporal aumenta en +[Arg1]%. Si la vida es menor al 25%, roba [Arg2] cartas adicionales y obtén [Arg2] aritmética."
  },
  State_98562_Desc = {
    Text = "Tras causar daño activo o daño de tentáculo, aumenta en [Arg1]% el daño de tentáculo recibido por el objetivo durante ese turno, con un máximo de 20 activaciones por turno."
  },
  State_98563_Desc = {
    Text = "Al inicio de la batalla, obtén [Arg1] puntos de <PowerIconKeywords:fuerza>. Por cada carta \"gasto\" jugada, obtén [Arg2] puntos de <PowerIconKeywords:fuerza> temporal, con un máximo de [Arg3] activaciones."
  },
  State_98564_Desc = {
    Text = "\"Exaltación\"obtener [Arg1] energía de llave de plata, se puede activar un máximo de 3 veces por turno."
  },
  State_98565_Desc = {
    Text = "Cada vez que una carta entra en el espacio transdimensional, roba [Arg1] cartas de comando del propietario de esta carta del mazo de robo. Si no es posible robar, en su lugar obtén una cantidad equivalente de aritmética. Máximo 2 activaciones por turno."
  },
  State_98567_Desc = {
    Text = "Antes de que termine el turno, el Despertado propietario de cada carta de comando en tu mano obtiene [Arg1] puntos de Locura."
  },
  State_98568_Desc = {
    Text = "Al comenzar la batalla, obtén un efecto de daño potente +[Arg1]%. Tras causar daño activo, inflige [Arg2] capas de veneno a todos los enemigos, con un máximo de 5 activaciones adicionales por turno."
  },
  State_98569_Desc = {
    Text = "La primera vez que uses \"llave\" en cada turno, aplica [Arg1] capas de veneno a todos los enemigos y obtén [Arg2] capas de contraataque."
  },
  State_98571_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, restablece [Arg1] puntos de vida y obtén [Arg2] puntos de energía-s de llave de plata."
  },
  State_98571_Name = {
    Text = "parasol de viaje"
  },
  State_98572_Desc = {
    Text = "Después de liberar la segunda \"llave\" en cada turno, obtén [Arg1] puntos de energía de llave de plata y todos los Despertados obtienen [Arg2] puntos de locura."
  },
  State_98575_Desc = {
    Text = "Al comenzar la batalla, obtén un efecto de daño potente +[Arg1]%. Tras causar daño activo, inflige [Arg2] capas de veneno a todos los enemigos, con un máximo de 5 activaciones adicionales por turno."
  },
  State_98576_Desc = {
    Text = "Al comenzar la batalla, inflige [Arg1] capas de debilidad y vulnerabilidad a todos los enemigos. Este efecto también se activa tras \"Aniquilación\", pero tiene un tiempo de reutilización de 3 turnos."
  },
  State_98577_Desc = {
    Text = "El daño base causado por todos los Despertados aumenta un [Arg1]%. Antes de liberar la exaltación, el daño base del Despertado que la libera aumenta temporalmente un [Arg2]%."
  },
  State_98579_Desc = {
    Text = "Al inicio del turno, si la vida está por debajo del 50%, la potencia de daño temporal aumenta en +[Arg1]%. Si la vida es inferior al 25%, roba [Arg2] cartas adicionales y obtén [Arg2] aritmética."
  },
  State_98581_Desc = {
    Text = "Todos los Despertados obtienen [Arg1] puntos de energía de llave de plata al usar una \"carta de comando\" por primera vez en cada turno."
  },
  State_98582_Desc = {
    Text = "Después de liberar 5 veces la \"exaltación\", las próximas [Arg1] cartas de comando no derivadas tendrán un efecto adicional una vez."
  },
  State_98583_Desc = {
    Text = "Todos los Despertados obtienen [Arg1] puntos de energía-s de llave de plata al usar una \"carta de comando\" por primera vez en cada turno."
  },
  State_98586_Desc = {
    Text = "Al inicio del turno, todos los Despertados que no tienen suficiente Locura para liberar una Exaltación obtienen [Arg1] puntos de Locura."
  },
  State_98587_Desc = {
    Text = "Cada vez que robas o descartas una carta, obtienes [Arg1] de fuerza temporal, con un máximo acumulable de [Arg2] de fuerza temporal."
  },
  State_98588_Desc = {
    Text = "Antes de que termine el turno, el Despertado propietario de cada carta de comando en tu mano obtiene [Arg1] puntos de Locura."
  },
  State_98589_Desc = {
    Text = "Al comenzar la batalla, todos los enemigos pierden temporalmente [Arg1] puntos de <PowerIconKeywords:fuerza>. Usar \"Horno Carmesí\" también activa este efecto, pero tiene un tiempo de enfriamiento de 3 turnos."
  },
  State_98590_Desc = {
    Text = "Al comenzar la batalla, obtienes [Arg1]% de efectividad. Al aplicar veneno por primera vez en cada turno, roba [Arg2] cartas."
  },
  State_98591_Desc = {
    Text = "La primera vez que se use \"llave\" en cada turno, aplica [Arg1] capas de veneno a todos los enemigos y obtiene [Arg2] capas de contraataque."
  },
  State_98596_Desc = {
    Text = "La primera vez que uses la \"llave\" en cada turno, se devolverá el [Arg1]% de la energía-s de llave de plata consumida."
  },
  State_98597_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, restablece [Arg1] puntos de vida y obtén [Arg2] puntos de energía-s de llave de plata."
  },
  State_98597_Name = {
    Text = "parasol de viaje+"
  },
  State_98598_Desc = {
    Text = "Al inicio de la batalla, obtén [Arg1] puntos de fuerza. Por cada carta de «gasto» jugada, obtén [Arg2] puntos de fuerza temporal, con un máximo de [Arg3] activaciones."
  },
  State_98600_Desc = {
    Text = "Al comenzar la batalla, todos los enemigos pierden temporalmente [Arg1] puntos de <PowerIconKeywords:fuerza>. Usar \"Horno Carmesí\" también activa este efecto, pero tiene un tiempo de enfriamiento de 3 turnos."
  },
  State_98602_Desc = {
    Text = "Al comenzar la batalla, obtén un [Arg1]% de efecto de daño potente. Al recibir una contraofensiva por primera vez en cada turno, obtén 1/2 aritmética."
  },
  State_98603_Desc = {
    Text = "Al inicio de la batalla, gana Amplificación de Daño +[Arg1]%. Tras recibir Daño Activo o Daño de tentáculos, gana [Arg2] Contrataque, hasta 3 veces por turno."
  },
  State_98604_Desc = {
    Text = "Al inicio de la batalla, gana Amplificación de Daño +[Arg1]%. Tras recibir Daño Activo o Daño de tentáculos, gana [Arg2] Contrataque, hasta 3 veces por turno."
  },
  State_98606_Desc = {
    Text = "Cada vez que una carta entra en el espacio transdimensional, roba [Arg1] cartas de comando del propietario de esta carta del mazo de robo. Si no es posible robar, en su lugar obtén una cantidad equivalente de aritmética. Máximo 2 activaciones por turno."
  },
  State_98607_Desc = {
    Text = "La primera vez que se use \"llave\" en cada turno, activa a todos los tentáculos para atacar [Arg1] veces al enemigo, causando un 50% de daño."
  },
  State_98608_Desc = {
    Text = "Al comenzar la batalla, obtén [Arg1]% de efecto de daño potente. Por cada carta de comando de un Despertado diferente jugada, obtén adicionalmente un 15/30% de efecto de daño potente temporal."
  },
  State_98610_Desc = {
    Text = "Después de usar el Despertar de la llave plateada, las 2/4 cartas con la aritmética más alta en tu mano obtienen Retención y Preparación antes de ser jugadas la próxima vez, y obtén 100/200 puntos de energía-s."
  },
  State_98611_Desc = {
    Text = "Al inicio de la batalla, aumenta la maestría de dominio en +[Arg1]. Al inicio del turno impar, roba 1 carta; al inicio del turno par, obtén 1 punto de aritmética."
  },
  State_98612_Desc = {
    Text = "La primera vez que se use \"llave\" en cada turno, aumenta el daño fuerte temporal en +[Arg1]%, siendo mayor el efecto cuanto menor sea la vida."
  },
  State_98613_Desc = {
    Text = "Al comenzar la batalla, obtén [Arg1]% de efecto de daño potente. Por cada carta de comando de un Despertado diferente jugada, obtén adicionalmente un 15/30% de efecto de daño potente temporal."
  },
  State_98614_Desc = {
    Text = "Después de liberar 5 veces la \"exaltación\", las próximas [Arg1] cartas de comando no derivadas tendrán un efecto adicional una vez."
  },
  State_98615_Desc = {
    Text = "La primera vez que uses la \"llave\" en cada turno, se devolverá el [Arg1]% de la energía-s de llave de plata consumida."
  },
  State_98616_Desc = {
    Text = "El efecto base de recuperación de vida y escudo causado por todos los Despertados aumenta un [Arg1]%."
  },
  State_98617_Desc = {
    Text = "Tras causar daño activo o daño de tentáculo, aumenta en [Arg1]% el daño de tentáculo recibido por el objetivo este turno, con un máximo de 20 activaciones por turno."
  },
  State_98619_Desc = {
    Text = "Al final del turno, si la energía-s de llave de plata está llena, consume [Arg1] puntos de energía-s de llave de plata para añadir una carta \"llave de plata de brillo\" a la mano."
  },
  State_98621_Desc = {
    Text = "Al final del turno, si la energía de llave de plata está llena, consume [Arg1] puntos de energía de llave de plata para añadir una carta \"llave de plata de luz\" a tu mano."
  },
  State_98623_Desc = {
    Text = "Al inicio del turno, todos los Despertados que no tengan suficiente Locura para liberar una Exaltación obtienen [Arg1] puntos de Locura."
  },
  State_98624_Desc = {
    Text = "Al comenzar la batalla y después de activar la resistencia a la muerte, obtén [Arg1] puntos de energía-s de llave de plata."
  },
  State_98625_Desc = {
    Text = "Al comenzar la batalla, aplica [Arg1] capas de <WeaknessIconKeywords:debilidad> y <VulnerabilityIconKeywords:vulnerabilidad> a todos los enemigos. Este efecto también se activa después de \"Aniquilación\", pero tiene un enfriamiento de 3 turnos."
  },
  State_98626_Desc = {
    Text = "La primera vez que se use \"llave\" en cada turno, aumenta el daño temporal en un [Arg1]%, siendo más efectivo cuanto menor sea la vida."
  },
  State_98627_Desc = {
    Text = "\"Exaltación\"obtener [Arg1] energía de llave de plata, máximo 3 veces por turno."
  },
  State_98628_Desc = {
    Text = "La primera vez que se use \"llave\" en cada turno, activa a todos los tentáculos para atacar [Arg1] veces al enemigo, causando un 50% de daño."
  },
  State_98629_Desc = {
    Text = "Después de liberar la segunda \"llave\" en cada turno, obtén [Arg1] puntos de energía-s de llave de plata, y todos los Despertados obtienen [Arg2] puntos de locura."
  },
  State_98630_Desc = {
    Text = "Al comenzar la batalla y después de activar la resistencia a la muerte, obtén [Arg1] puntos de energía-s de llave de plata."
  },
  State_98632_Desc = {
    Text = "Al comenzar la batalla, obtienes [Arg1]% de efecto de daño potente. Al recibir una contraofensiva por primera vez en cada turno, obtienes 1/2 aritmética."
  },
  State_98686_Desc = {
    Text = "La carta de comando [Layer] no derivada tendrá un efecto adicional 1 vez."
  },
  State_98686_Name = {
    Text = "Comando no derivado disparado dos veces"
  },
  State_98739_Desc = {
    Text = "Cuando la intención cambia a Giro Pálido, aumenta la cantidad de daño equivalente al número de capas del estado y limpia inmediatamente dicho estado al finalizar el turno. Al alcanzar 3 capas, cambia inmediatamente la intención a Giro Pálido."
  },
  State_98739_Name = {
    Text = "Beso de la Mujer Araña"
  },
  State_98742_Desc = {
    Text = "El veneno aplicado aumenta un 100%, y al final de cada turno obtienes <Block:[Block:DescArg1]> puntos de escudo."
  },
  State_98742_Name = {
    Text = "Camino de los Perdidos"
  },
  State_98743_Desc = {
    Text = "Después de recibir [DescArg1] puntos de daño dentro del turno, obtén 75 capas de <ReinforcePVEKeywords:reforzado> temporal, convierte la intención en \"la dádiva impaciente\" y se eliminará el efecto de petrificación, además obtén 1 capa de \"beso de araña\"."
  },
  State_98743_Name = {
    Text = "Transgresor"
  },
  State_98752_Desc = {
    Text = "Hace que la carta arda; al jugarla, recibe un 5% del daño de vida máxima. Si aún está en la mano al final del turno, se consume."
  },
  State_98752_Name = {
    Text = "<BurningKeywords2:Quemar>"
  },
  State_98752_WeaponDesc = {
    Text = "Cada capa de lentitud aumenta el consumo de aritmética de las cartas en 1"
  },
  State_98887_Name = {
    Text = "alma artificial"
  },
  State_98889_Desc = {
    Text = "Cada vez que juegues por primera vez una carta de comando derivada o una carta de mejora con <DepleteIconKeywords:agotamiento> en cada turno, colócala en el montón de descarte."
  },
  State_98889_Name = {
    Text = "alma artificial"
  },
  State_98912_Desc = {
    Text = "Cada capa reduce en un 20% el daño final causado por todos los Despertados."
  },
  State_98912_Name = {
    Text = "<LostWay:Perdido>"
  },
  State_98913_Desc = {
    Text = "Cada capa reduce en un 20% el daño final causado por todos los Despertados."
  },
  State_98913_Name = {Text = "perdido"},
  State_99007_Desc = {
    Text = "Después de jugar, no pasará al montón de descarte, sino que será removido del mazo"
  },
  State_99007_Name = {
    Text = "<DepleteIconKeywords:Consumo>"
  },
  State_99007_WeaponDesc = {
    Text = "Después de jugar, la carta no irá al montón de descarte, no podrá usarse nuevamente en esta batalla"
  },
  State_99053_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del Destino>: Después de que otros aliados \"exaltar\", roba [StateArg1] cartas."
  },
  State_99053_Name = {
    Text = "Pincel ansioso"
  },
  State_99055_Desc = {
    Text = "<PVPWeaponKeywords:Rueda del destino>: Después de \"Exaltar\", coloca aleatoriamente [StateArg1] \"Habilidades\" del Portador en tu mano y reduce su Coste de Aritmética a 0."
  },
  State_99055_Name = {
    Text = "Paradoja del realismo"
  },
  State_99056_Desc = {
    Text = "Equipo único: Después de liberar la llave, la tasa crítica del portador aumenta temporalmente en <WeaponEffect_Num:[StateArg1]%>."
  },
  State_99056_WeaponDesc = {
    Text = "Después de liberar la llave, la tasa crítica del portador aumenta temporalmente en <WeaponEffect_Num:[StateArg1]%>."
  },
  State_99134_Desc = {
    Text = "La tinta que utiliza el \"artista\" para pintar, puede mejorar los efectos de las habilidades. Al jugar cartas de \"<ColorInkKeywords:tinta a color>\" o \"<ErosionColorInkKeywords:disolución>\", se obtiene 1 capa, con un límite de 10 capas."
  },
  State_99134_Name = {
    Text = "Tinte del mundo ilusorio"
  },
  State_99237_Name = {
    Text = "Estado de accesorio Ascensión"
  },
  State_99237_WeaponDesc = {
    Text = "El daño base causado por el portador aumenta en un 10%. Si la amplificación de daño del portador es superior al 20%, el daño base aumenta un 10% adicional."
  },
  State_99238_Name = {
    Text = "Estado de accesorio humus"
  },
  State_99238_WeaponDesc = {
    Text = "El daño básico causado por el portador aumenta en un 10%. Si la amplificación de daño del portador es superior al 20%, el daño básico aumenta un 10% adicional."
  },
  State_99239_Name = {
    Text = "Estado de accesorio Estigia"
  },
  State_99239_WeaponDesc = {
    Text = "El daño básico causado por el portador aumenta en un 10%. Si la amplificación de daño del portador es mayor del 20%, el daño básico aumenta un 10% adicional."
  },
  State_99258_Desc = {
    Text = "Único en el equipo: Después de liberar la segunda llave en cada turno, hay un <WeaponEffect_Num:[StateArg1]%> de probabilidad de robar 1 carta de comando del portador. Después de jugar la tercera carta de comando del portador en cada turno, obtén <WeaponEffect_Num:[StateArg2]> puntos de energía de llave de plata."
  },
  State_99258_WeaponDesc = {
    Text = "Después de liberar la segunda llave en cada turno, hay un <WeaponEffect_Num:[StateArg1]%> de probabilidad de robar 1 carta de comando del portador. Después de jugar la tercera carta de comando del portador en cada turno, obtén <WeaponEffect_Num:[StateArg2]> puntos de energía de llave de plata."
  },
  State_99294_Desc = {
    Text = "La locura causada por todos los Despertados aumenta en [DescArg1]%, al final del turno, la Aritmética y las Tarjetas de comando pueden retenerse para el siguiente turno. La locura del Capítulos resplandecientes aumenta."
  },
  State_99294_Name = {Text = "\"Alegría\""},
  State_99295_Desc = {
    Text = "El Aliemus generado por todos los Despertadores aumenta en [StateArg1]%, y las Cartas de Aritmética y Comando pueden llevarse a la siguiente ronda. El Aliemus del Capítulo Espléndido también aumenta."
  },
  State_99295_Name = {Text = "\"Alegría\""},
  State_99336_Desc = {
    Text = "La tinta utilizada por el \"pintor\" para crear, que puede mejorar el efecto de habilidades. Al jugar una carta de \"<ColorInkKeywords:tinta a color>\" o \"<ErosionColorInkKeywords:disolución>\", se le otorga 1 capa, con un límite de 10 capas."
  },
  State_99336_Name = {
    Text = "<DecayDye:Tinte del mundo ilusorio>"
  },
  State_99533_Name = {
    Text = "Capullo de la doncella de accesorios"
  },
  State_99533_WeaponDesc = {
    Text = "Después de que comience la batalla, si el portador es de profesión caos, su ataque aumenta un 25%"
  },
  State_99534_Name = {
    Text = "Slime Dulce"
  },
  State_99534_WeaponDesc = {
    Text = "El portador aumenta el escudo y la curación en un 6%. Si la maestría del portador en el dominio es mayor a 50, el escudo y la curación aumentan un 6% adicional"
  },
  State_99640_Desc = {
    Text = "Si actualmente tienes 10 capas de creatividad, Pikman libera la explosión de locura y consume todas las capas de creatividad, haciendo que todos los despertadores obtengan 15 puntos de locura y ganen 1 capa de \"delirio\". El límite de creatividad es de 10 capas y se puede heredar a la siguiente batalla."
  },
  State_99640_Name = {
    Text = "Creatividad"
  },
  State_99723_Desc = {
    Text = "Equipo único: El aliemus y la fuerza causados por el portador aumentan en <WeaponEffect_Num:[StateArg1]%>. Después de liberar la exaltación, el daño final de la exaltación de otros despertadores, el escudo y la recuperación de vida en este turno aumentan en <WeaponEffect_Num:[StateArg2]%>. Si esta exaltación activa \"devorar\", el portador gana <WeaponEffect_Num:[StateArg3]> puntos de aliemus."
  },
  State_99723_WeaponDesc = {
    Text = "El aliemus y la fuerza causados por el portador aumentan en <WeaponEffect_Num:[StateArg1]%. Después de liberar la exaltación, el daño final, el escudo y la recuperación de vida de la próxima explosión de locura de otros Despertados en este turno aumentan en <WeaponEffect_Num:[StateArg2]%>. Si esta explosión de locura activa \"Devorar\", el portador obtiene <WeaponEffect_Num:[StateArg3]> puntos de locura."
  }
})
return Text_State
