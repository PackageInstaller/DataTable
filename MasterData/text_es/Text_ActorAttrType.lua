__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = "El nivel de conocimiento prohibido es el mismo que el nivel del guardián y determina el efecto de las siguientes 3 profundidades de investigación. Si el nivel promedio del despertador en la formación es mayor o igual al nivel del guardián, el nivel de conocimiento prohibido tomará el promedio entre el nivel promedio del despertador en la formación y el nivel del guardián. \n Profundidad de investigación in vivo: <Blue:{s1}> \n · Determina la intensidad del efecto de conversión de cada 100 puntos de atributo de constitución del despertador en salud del equipo. \n Profundidad de investigación de objetos: <Blue:{s2}> \n · Determina la intensidad de los efectos de poder, daño de tentáculos, blindaje, recuperación de PV y reducción de fuerza causados por reliquias, inscripciones y poses. \n Profundidad de la Investigación de la Conciencia: <Blue:{s3}> \n · Determina la intensidad de los efectos de veneno fijo, contraataque fijo, daño fijo y sangrado fijo causados por reliquias, inscripciones y poses. \n"
  },
  ActorAttrType_121209_Text = {
    Text = "Nivel de conocimiento prohibido"
  },
  ActorAttrType_18103_Text = {
    Text = "Escudo del personaje"
  },
  ActorAttrType_18104_Text = {
    Text = "Corrección del porcentaje de daño de la carta de golpe"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "Daño crítico +{s1}"
  },
  ActorAttrType_18105_Text = {
    Text = "Daño Crítico"
  },
  ActorAttrType_18106_Text = {
    Text = "Escudo mejorado"
  },
  ActorAttrType_18107_AttributeUpText = {Text = "ATQ+{s1}"},
  ActorAttrType_18107_Text = {Text = "ATQ"},
  ActorAttrType_18108_Text = {Text = "CON"},
  ActorAttrType_18109_Text = {
    Text = "Ajuste del porcentaje de daño de la carta"
  },
  ActorAttrType_18110_Text = {
    Text = "Ajuste de Porcentaje Frágil"
  },
  ActorAttrType_18111_Text = {
    Text = "Ajuste del porcentaje de escudo recibido"
  },
  ActorAttrType_18112_AttributeUpText = {Text = "DEF + {s1}"},
  ActorAttrType_18112_Text = {
    Text = "DEF mejorada"
  },
  ActorAttrType_18113_AttributeDesc = {
    Text = "Eficiencia de carga de locura del despertado"
  },
  ActorAttrType_18113_Text = {
    Text = "Furia inicial"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = "Cuanto mayor sea la constitución, mayor será la salud máxima del despertador.\nA medida que aumenta el nivel de investigación del guardián, la influencia de la constitución sobre la salud máxima del despertador es más fuerte"
  },
  ActorAttrType_18114_AttributeUpText = {Text = "CON+{s1}"},
  ActorAttrType_18114_Text = {Text = "CON"},
  ActorAttrType_18115_AttributeDesc = {
    Text = "Después de que el despertador libera la llegada del génesis, se devuelve el valor de aliemus"
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "Reducción de consumo de locura +{s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "Reducción del Consumo de Alienación"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = "Cuanto mayor sea la constitución, mayor será la salud máxima del despertador.\nA medida que aumenta el nivel de investigación del guardián, la influencia de la constitución sobre la salud máxima del despertador es más fuerte"
  },
  ActorAttrType_18116_AttributeUpText = {Text = "CON+{s1}"},
  ActorAttrType_18116_Text = {
    Text = "Aumento de la CON"
  },
  ActorAttrType_18117_Text = {
    Text = "Daño de tentáculos"
  },
  ActorAttrType_18118_Text = {
    Text = "Ranuras Ultra"
  },
  ActorAttrType_18119_Text = {
    Text = "Corrección del porcentaje de daño recibido"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "El Límite de Alienación máximo del Cuerpo Despertado y el Consumo de Alienación de Exaltar son ambos iguales a su Aliemus Base."
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "Límite de locura +{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "Aliemus Base"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "Nivel de Habilidad 2"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "Nivel de habilidad 2 +{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "Nivel de Habilidad 2"
  },
  ActorAttrType_18122_AttributeDesc = {
    Text = "Nivel de defensa"
  },
  ActorAttrType_18122_AttributeUpText = {
    Text = "Nivel de defensa+{s1}"
  },
  ActorAttrType_18122_Text = {
    Text = "Nivel de defensa"
  },
  ActorAttrType_18123_Text = {
    Text = "Ajuste del valor fijo de la cantidad de daño"
  },
  ActorAttrType_18124_Text = {
    Text = "Causa modificación de valor fijo del escudo"
  },
  ActorAttrType_18125_Text = {
    Text = "Corrección del valor fijo del escudo"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = "La Maestría del Reino del equipo es igual a la suma de la Maestría del Reino de todos los Despertadores en el equipo. La Maestría del Reino puede mejorar los efectos del Legado del Reino del equipo. Si el equipo actual es \"Mar Puro Tranquilo/Caro Puro/Ultra Puro\", el efecto de la Maestría del Reino se duplica.\n· Para los equipos del Reino <Blue:Caos>, por cada 1 punto de Maestría del Reino, después de desatar Pandilla, todos los Despertadores ganan <Blue:0.05> puntos adicionales de Aliemus.\n· Para los equipos del Reino <Blue:Aequor>, por cada 1 punto de Maestría del Reino, hay una probabilidad <Blue:0.25%> de ganar una pila adicional de Recolección de Tentáculos al desatar Exaltar (las probabilidades superiores al 100% pueden otorgar múltiples pilas). Al cambiar a \"Mar Tranquilo\", los montos de Escudo adquiridos aumentan en <Blue:0.01%> de HP Máx, y el daño de tentáculo causado por daño activo en \"Olas Enfurecidas\" aumenta en <Blue:0.02%> de Daño de Tentáculo.\n· Para los equipos del Reino <Blue:Caro>, por cada 1 punto de Maestría del Reino, la primera Devorar desencadenada en cada turno otorga un Escudo adicional igual a <Blue:0.01%> de HP Máx y Fuerza Temporal de <Blue:0.005%> (aumenta basado en HP perdido, hasta un máximo de 100%).\n· Para los equipos del Reino <Blue:Ultra>, por cada 1 punto de Maestría del Reino, al inicio del turno, hay una probabilidad <Blue:0.125%> de obtener 1 \"Perspicacia\" (las probabilidades superiores al 100% pueden otorgar múltiples copias)."
  },
  ActorAttrType_18126_AttributeUpText = {
    Text = "Maestría en dominios +{s1}"
  },
  ActorAttrType_18126_Text = {
    Text = "Maestría del Reino"
  },
  ActorAttrType_18127_Text = {Text = "PV"},
  ActorAttrType_18128_AttributeUpText = {Text = "ATQ+{s1}"},
  ActorAttrType_18128_Text = {
    Text = "ATQ aumentado"
  },
  ActorAttrType_18129_AttributeDesc = {
    Text = "Cuanto mayor sea el daño base, mayor será el daño causado por el Despertado"
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "Daño base +{s1}"
  },
  ActorAttrType_18129_Text = {
    Text = "Daño básico"
  },
  ActorAttrType_18130_Text = {Text = "Nivel"},
  ActorAttrType_18131_AttributeDesc = {
    Text = "Al final del turno, la recuperación automática de Locura de los Despertados (en modo de tarea, la recuperación de Locura después de cada acción de los Despertados)"
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "Recuperación automática de locura +{s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "Respuesta Automática de Alienación"
  },
  ActorAttrType_18132_Text = {
    Text = "Nivel Espiritual"
  },
  ActorAttrType_18133_Text = {
    Text = "Ajuste del porcentaje de alienación recibida"
  },
  ActorAttrType_18134_Text = {
    Text = "Límite de fusión de embriones"
  },
  ActorAttrType_18135_Text = {
    Text = "Personaje con Alienación Actual"
  },
  ActorAttrType_18136_Text = {
    Text = "Ajuste del valor fijo de daño recibido"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "Al aplicar escudos y efectos de curación, el Despertado aumenta los valores de escudo y curación"
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "Escudo y curar fuerte + {s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "Escudo y Curar Fuerte"
  },
  ActorAttrType_18138_Text = {
    Text = "Curación aumentada"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "Al Jugar una Tarjeta de comando o Activar, por cada 1 punto de Aritmética consumido, obtén {s1} puntos de Llave Plateada. A medida que este atributo aumenta, la Llave Plateada adicional obtenida disminuirá gradualmente."
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "Recarga de llave de plata +{s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "Nivel de carga de la llave de plata"
  },
  ActorAttrType_18140_Text = {
    Text = "Número de resistencias a la muerte"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "Nivel de golpe"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "Nivel de ataque +{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "Nivel de golpe"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "Aumenta el porcentaje del \"daño base\" causado por todos los Despertados, el número de capas de \"veneno de valor fijo\" y \"contraataque de valor fijo\" aplicados, y el daño inicial de tentáculo del Dominio del Mar Profundo."
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "Fuerte daño +{s1}"
  },
  ActorAttrType_18142_Text = {
    Text = "Amplificación de Daño"
  },
  ActorAttrType_18143_Text = {
    Text = "Ajuste del porcentaje de daño de la Furia explosiva"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "Al causar daño activo, el Despertar reduce la probabilidad de recibir un golpe crítico"
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "Resistencia a críticos +{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "Res. Crítica"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "Nivel de llegada de la génesis"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "Nivel de llegada de la génesis +{s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "Nivel de llegada de la génesis"
  },
  ActorAttrType_18146_Text = {
    Text = "Corrección del Valor Fijo de Curación"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "Tasa de estampado de la suerte + {s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "Tasa de Grabado de Suerte"
  },
  ActorAttrType_18148_Text = {
    Text = "Causa ajuste de valor de cura fijo"
  },
  ActorAttrType_18149_Text = {
    Text = "Aumento de la CON"
  },
  ActorAttrType_18150_Text = {
    Text = "Ajuste de Porcentaje de Debilidad"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = "La resistencia a la muerte del equipo es igual a la suma de la resistencia a la muerte de los Despertados en el equipo. \nCuando recibes daño fatal en combate, hay una probabilidad de retener 1 punto de vida; al activarse, obtienes 2 puntos de aritmética adicionales y robas 2 cartas en el siguiente turno. La resistencia a la muerte obtenida actualmente y en el futuro se reduce a la mitad, y dura hasta el final de la investigación."
  },
  ActorAttrType_18151_AttributeUpText = {
    Text = "Resistencia a la muerte +{s1}"
  },
  ActorAttrType_18151_Text = {
    Text = "Resistencia a la muerte"
  },
  ActorAttrType_18152_Text = {
    Text = "Causa Ajuste de Porcentaje de Alienación"
  },
  ActorAttrType_18154_Text = {
    Text = "Límite de tentáculos"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = "Aumenta el porcentaje de los sellos negros que caen de los enemigos tras una victoria en combate"
  },
  ActorAttrType_18155_AttributeUpText = {
    Text = "Caída de el sigilo negro +{s1}"
  },
  ActorAttrType_18155_Text = {
    Text = "Recompensa de Sello Negro"
  },
  ActorAttrType_18156_Text = {
    Text = "Recibir ajuste de valor fijo de alienación"
  },
  ActorAttrType_18157_Text = {
    Text = "Intención Oculta"
  },
  ActorAttrType_18158_Text = {
    Text = "Ajuste del valor fijo de daño"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "Tasa crítica +{s1}"
  },
  ActorAttrType_18159_Text = {
    Text = "Probabilidad de Crítico"
  },
  ActorAttrType_18160_AttributeDesc = {
    Text = "Nivel de la Habilidad 1"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "Nivel de habilidad 1 +{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "Nivel de la Habilidad 1"
  },
  ActorAttrType_18161_Text = {Text = "Nivel"},
  ActorAttrType_18162_Text = {
    Text = "Daño aumentado"
  },
  ActorAttrType_18163_Text = {
    Text = "Número de Tentáculos"
  },
  ActorAttrType_18164_Text = {
    Text = "Modificador del Porcentaje de Curación Recibida"
  },
  ActorAttrType_18165_Text = {
    Text = "Max. Aritmética"
  },
  ActorAttrType_18166_Text = {
    Text = "Ajuste del porcentaje de vulnerabilidad"
  },
  ActorAttrType_18167_AttributeUpText = {Text = "DEF + {s1}"},
  ActorAttrType_18167_Text = {Text = "DEF"},
  ActorAttrType_18168_AttributeDesc = {
    Text = "Nivel de Despertar de la Gnosis"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "Nivel de Despertar de la Conciencia +{s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "Nivel de Despertar de la Gnosis"
  },
  ActorAttrType_21322_Text = {
    Text = "Regeneración de Llave Plateada"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "Cada vez que se libera una explosión de locura, se obtienen {s1} puntos de locura. A medida que aumenta esa estadística, los efectos adicionales disminuyen gradualmente"
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "Nivel de recarga de locura +{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "Nivel de Recarga de Alienación"
  },
  ActorAttrType_22214_Text = {
    Text = "Recarga de ira"
  }
})
return Text_ActorAttrType
