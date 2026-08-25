__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TrinketSuitEffect = readonly({
  TrinketSuitEffect_18335_Name = {
    Text = "Canto a abril"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_1 = {
    Text = "Daño crítico +7.2%"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Team unique>: Al inicio del turno, si los hp totales de los enemigos están por encima del 75%, la tasa de crítico temporal del portador y el daño crítico +35%."
  },
  TrinketSuitEffect_18336_Name = {
    Text = "Poema circular (Incompleto)"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_1 = {
    Text = "Resistencia a la muerte +16.8%"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_2 = {
    Text = "Después de que comience el turno par, haz que el costo de aritmética de una carta de mano aleatoria disminuya en 1"
  },
  TrinketSuitEffect_18337_Name = {
    Text = "Línea de retorno al mar"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_1 = {
    Text = "Maestría en dominios +12"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Team unique>: Al inicio de la batalla, gana fuerza equivalente al 12% del ataque del portador. Si el reino actual es Aequor, el efecto cambia para tener un (50+0.25*maestría del reino del equipo)% de probabilidad de ganar 1 capa de recolección de tentáculos al inicio de cada turno; si se supera el 100%, se pueden ganar múltiples capas, y la probabilidad se duplica en las batallas contra jefes."
  },
  TrinketSuitEffect_18338_Name = {
    Text = "Conejo maldito"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_1 = {
    Text = "Maestría en dominios +12"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_2 = {
    Text = "El portador aumenta el escudo y la curación en un 12%"
  },
  TrinketSuitEffect_18339_Name = {Text = "Antinomia"},
  TrinketSuitEffect_18339_SuitEffectDesc_1 = {
    Text = "Nivel de recarga de llave de plata +7.2"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Equipo Único>: Aumenta el Aliemus Base del portador en 20. La Probabilidad de Crítico, Daño Crítico, Escudo del personaje y Recuperación de PV de las Tarjetas de comando del portador aumentan un 20%."
  },
  TrinketSuitEffect_18340_Name = {
    Text = "Forma orgánica"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_1 = {
    Text = "Caída de el sigilo negro +3.6%"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Equipo único>. Al inicio de la exploración, deduce hasta un 100% de resistencia a la muerte. Por cada 1% de resistencia a la muerte deducida, aumenta el daño de la locura del portador en un 0.15%."
  },
  TrinketSuitEffect_18341_Name = {
    Text = "Latido Escarlata"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_1 = {
    Text = "Daño crítico +7.2%"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_2 = {
    Text = "Al liberar la llave, el portador obtiene un 30% de tasa crítica temporal"
  },
  TrinketSuitEffect_18342_Name = {
    Text = "Estándar Mystik SSR"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_1 = {
    Text = "Resistencia a la muerte +16.8%"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_2 = {
    Text = "El daño, curación y escudo causados por el portador aumentan en un 15%"
  },
  TrinketSuitEffect_18343_Name = {
    Text = "Pacto estándar R"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_1 = {
    Text = "Resistencia a la muerte +16.8%"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_2 = {
    Text = "El daño, curación y escudo causados por el portador aumentan en un 15%"
  },
  TrinketSuitEffect_18344_Name = {
    Text = "Bajada mecánica de la divinidad"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_1 = {
    Text = "Maestría en dominios +12"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_2 = {
    Text = "En el primer turno de cada batalla, obtienes 1 punto de aritmética y en la batalla contra el jefe, obtienes 1 punto adicional de aritmética cada 4 turnos"
  },
  TrinketSuitEffect_18345_Name = {
    Text = "Ceremonia de Fotossíntesis"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_1 = {
    Text = "Amplificación de Daño +7.2%"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Equipo Único>: Cuando las Tarjetas de comando del portador entran en el Espacio Hiperspacial, la Fusión Embrionaria aumenta en +25~50. Cuanto más baja sea la vida actual, mayor será la Fusión Embrionaria obtenida."
  },
  TrinketSuitEffect_18346_Name = {
    Text = "Reevolución"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_1 = {
    Text = "Nivel de recarga de locura +2.4"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Equipo único>: Al inicio de la exploración, el portador gana 35 aliemus. Después de que el portador use exaltación, gana 2 aliemus al final de cada turno en esta batalla, acumulándose hasta un máximo de 3 veces."
  },
  TrinketSuitEffect_18347_Name = {
    Text = "Drenaje de Vitalidad"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_1 = {
    Text = "Nivel de recarga de llave de plata +7.2"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Equipo Único>: Al final del turno, obtiene Keyflare equivalente al 200% de la Regeneración de Llave Plateada del portador. Si el Reino actual es \"Carne y sangre\", el Efecto cambia a: por cada 5 puntos de Regeneración de Llave Plateada, la Fusión Embrionaria +1."
  },
  TrinketSuitEffect_18348_Name = {
    Text = "Sueño de la medicina"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_1 = {
    Text = "Fuerte daño +4.8%"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Equipo único>. Al final de la batalla, gana -8 sigilos negros; al inicio de la batalla, mezcla una copia base de las cartas de defensa de no ataque del portador en la pila de robos, como máximo 1 de cada una."
  },
  TrinketSuitEffect_18349_Name = {
    Text = "Slime Dulce"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_1 = {
    Text = "Resistencia a la Muerte +25.2%"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_2 = {
    Text = "Equipo Único. Si se desata \"Aniquilación\" y se cambia la Postura de tentáculo en 1 turno, el Escudo del personaje, Cicatrización y Daño Final del portador +25% en este turno, con un enfriamiento de 3 turnos."
  },
  TrinketSuitEffect_18350_Name = {
    Text = "Gato del teatro (incompleto)"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_1 = {
    Text = "Resistencia a la muerte +16.8%"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_2 = {
    Text = "El daño del portador a enemigos con más del 75% de vida siempre será crítico"
  },
  TrinketSuitEffect_18351_Name = {
    Text = "Anillo de las 36 Salas"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_1 = {
    Text = "Nivel de recarga de locura +2.4"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Equipo único>. Aumenta el límite de energía de la llave de plata y el costo de la llave de fogata en +200; aumenta la tasa de crit. del portador, daño crit., escudo y recuperación de hp en un 30%."
  },
  TrinketSuitEffect_18352_Name = {
    Text = "Géminis Distorsionados·Blanco"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_1 = {
    Text = "Resistencia a la muerte +16.8%"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_2 = {
    Text = "Después de que comience el turno par, añade una \"DEF\" de un equipador con <NothingnessIconKeywords: ilusión> y <DepleteIconKeywords: agotamiento> a tu mano"
  },
  TrinketSuitEffect_18353_Name = {
    Text = "Abrazo Escarlata"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_1 = {
    Text = "Tasa crítica +4.8%"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_2 = {
    Text = "Cuando el portador causa daño, obtiene 35 puntos de energía-llave. Si causa daño crítico, en su lugar obtiene 70 puntos de energía-llave, y se puede activar un máximo de 3 veces por turno"
  },
  TrinketSuitEffect_18354_Name = {
    Text = "Pacto estándar SR"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_1 = {
    Text = "Resistencia a la muerte +16.8%"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_2 = {
    Text = "El daño, curación y escudo causados por el portador aumentan en un 15%"
  },
  TrinketSuitEffect_18355_Name = {
    Text = "Apocalipsis Imaculado"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_1 = {
    Text = "Nivel de recarga de llave de plata +7.2"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Equipo único>: Después de desatar un grupo, recupera hp equivalente al 12% de la constitución del portador, con efectos que aumentan proporcionalmente a la hp perdida, hasta un aumento máximo del 24% de la constitución del portador."
  },
  TrinketSuitEffect_18356_Name = {
    Text = "Lobo de las estepas"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_1 = {
    Text = "Fuerte daño +4.8%"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_2 = {
    Text = "El daño base causado por el equipador aumenta un 20%, con un aumento del <IntoxicationIconKeywords:veneno> y <RetaliateIconKeywords:mostrador> del 10%"
  },
  TrinketSuitEffect_18357_Name = {
    Text = "Fiesta Lejana"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_1 = {
    Text = "Caída de el sigilo negro +3.6%"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_2 = {
    Text = "Exploración comienza y se obtienen 10 el sigilo negro. El portador aumenta el escudo en un 60% al usar \"defensa\""
  },
  TrinketSuitEffect_18358_Name = {
    Text = "Géminis Distorsionados·negro"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_1 = {
    Text = "Tasa crítica +4.8%"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_2 = {
    Text = "Al iniciar la ronda impar, agrega una \"golpe\" de un equipador con añadidos <NothingnessIconKeywords:ilusión> y <DepleteIconKeywords:agotamiento> a tu mano"
  },
  TrinketSuitEffect_18359_Name = {
    Text = "Crisálida de la joven"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_1 = {
    Text = "Tasa de Crítico +7.2%"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_2 = {
    Text = "Equipo Único. Después de que el portador consuma un Embrión por primera vez en cada turno, por cada Tentáculo que posea, obtiene un 8% de Daño crítico temporal, hasta un máximo del 80%."
  },
  TrinketSuitEffect_18360_Name = {
    Text = "Susurros del Lugar de Entierro"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_1 = {
    Text = "Resistencia a la muerte +16.8%"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_2 = {
    Text = "Al iniciar el nivel, <DeathResistanceIconKeywords:resistencia a la muerte> aumenta un 25%. Al activar la resistencia a la muerte, el portador obtiene 50 puntos de locura"
  },
  TrinketSuitEffect_99234_Name = {Text = "humus"},
  TrinketSuitEffect_99234_SuitEffectDesc_1 = {
    Text = "Texto temporal"
  },
  TrinketSuitEffect_99234_SuitEffectDesc_2 = {
    Text = "Texto temporal"
  },
  TrinketSuitEffect_99235_Name = {Text = "Ascensión"},
  TrinketSuitEffect_99235_SuitEffectDesc_1 = {
    Text = "Texto temporal"
  },
  TrinketSuitEffect_99235_SuitEffectDesc_2 = {
    Text = "Texto temporal"
  },
  TrinketSuitEffect_99236_Name = {Text = "Estigia"},
  TrinketSuitEffect_99236_SuitEffectDesc_1 = {
    Text = "Texto temporal"
  },
  TrinketSuitEffect_99236_SuitEffectDesc_2 = {
    Text = "Texto temporal"
  }
})
return Text_TrinketSuitEffect
