__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Tutorial = readonly({
  Tutorial_120371_Desc_1 = {
    Text = "Puede regresar a turnos experimentados en la batalla, hasta cualquiera de los últimos 25 turnos de la batalla."
  },
  Tutorial_120371_Title_1 = {
    Text = "Inversión temporal"
  },
  Tutorial_124999_Desc_1 = {
    Text = "En el modo <TutorialHighlight:Fase de Duelo-Modo de selección de rueda>, haz clic en \"Comenzar coincidencia\" en la esquina inferior derecha de la interfaz para entrar en emparejamiento, sin necesidad de preformar un equipo."
  },
  Tutorial_124999_Desc_2 = {
    Text = "Antes de la batalla, el sistema seleccionará aleatoriamente una <TutorialHighlight:reliquia>, que tendrá efecto durante la batalla. Según el efecto de la reliquia en cada partida, se seleccionarán de manera alterna los Despertados, Rueda del destino y Posse necesarios de un conjunto de opciones limitadas que se presenten aleatoriamente, para construir su formación y enfrentarse al oponente."
  },
  Tutorial_124999_Desc_3 = {
    Text = "Ajusta la posición de tu equipo en la batalla haciendo clic en dos Despertados para intercambiar sus posiciones. Las posiciones se ordenan de adelante hacia atrás del 1 al 4."
  },
  Tutorial_124999_Title_1 = {
    Text = "Selección de rueda de formación"
  },
  Tutorial_126878_Desc_1 = {
    Text = "Cuando el desarrollo de la personalidad de algunos Despertados alcanza +12, obtienen automáticamente el efecto \"Principio Final\", el cual varía para cada Despertado."
  },
  Tutorial_126878_Desc_2 = {
    Text = "Después de desbloquear el \"Principio Final\" del Despertado, recibirás un mensaje exclusivo del comunicador correspondiente al Despertado. Recuerda, Guardián del Secreto, revisarlo."
  },
  Tutorial_126878_Title_1 = {
    Text = "Regla final"
  },
  Tutorial_126878_Title_2 = {
    Text = "Mensaje exclusivo"
  },
  Tutorial_148475_Desc_1 = {
    Text = "Cuando la Tasa de sincronización del Despertado alcance <TutorialHighlight:Lv20>, podrás obtener una <TutorialHighlight:Centella> exclusiva."
  },
  Tutorial_148475_Desc_2 = {
    Text = "La <TutorialHighlight:Centella> es la prueba de la Unión Sagrada entre tú y el Despertado."
  },
  Tutorial_148475_Desc_3 = {
    Text = "A partir de ahora, la Tarjeta de comando de este Despertado tendrá una presentación especial en combate y podrá mostrarse a otros Gardian del secreto en situaciones sociales."
  },
  Tutorial_148475_Title_1 = {
    Text = "Unión Sagrada"
  },
  Tutorial_17805_Desc_1 = {
    Text = "Haz clic en el enemigo para ver todos sus estados. <TutorialHighlight:Advertencia> Los estados de advertencia requieren más atención, representan mecánicas especiales del enemigo, y la mayoría de las veces, los guardianes fallan en la investigación por no prestar atención a estas mecánicas"
  },
  Tutorial_17805_Title_1 = {
    Text = "Estado del enemigo"
  },
  Tutorial_17806_Desc_1 = {
    Text = "Al vencer enemigos, puedes elegir <TutorialHighlight:inscripción>, también puedes gastar <TutorialHighlight:marca negra> en <TutorialHighlight:d-marca> para comprar. <TutorialHighlight:inscripción> puede otorgar diferentes efectos adicionales a las cartas designadas. Cada carta designada puede ser inscrita un máximo de <TutorialHighlight:1> vez. Prioriza la inscripción de las tarjetas de comando que se juegan con más frecuencia, lo que puede aumentar los beneficios de la inscripción."
  },
  Tutorial_17806_Title_1 = {
    Text = "Inscripción"
  },
  Tutorial_17807_Desc_1 = {
    Text = "Proporciona múltiples atributos al Cuerpo Despertado. Si se forma un <TutorialHighlight:conjunto>, también habrá efectos especiales. Hay 6 partes en total, y los <TutorialHighlight:atributos principales> son diferentes en cada parte; la Probabilidad de Crítico y el Daño Crítico aparecerán en las partes I, II y III; el Nivel de Recarga de Alienación y el Nivel de carga de la llave de plata aparecerán en las partes I, IV y V; la Maestría del Reino y la Recompensa de Sello Negro aparecerán en las partes II, IV y VI; la Amplificación de Daño y la Resistencia a la muerte aparecerán en las partes III, V y VI."
  },
  Tutorial_17807_Title_1 = {Text = "Pacto"},
  Tutorial_17808_Desc_1 = {
    Text = "<TutorialHighlight:Inmersión fantasmal> actualizará diariamente los mapas de niveles, enemigos y creaciones iniciales, permitiendo a los guardianes disfrutar de una nueva experiencia de desafío cada día. Cada semana habrá diferentes reliquias de péndulo temporal, de lunes a jueves habrá creaciones de plata iniciales, el viernes habrá creaciones malditas iniciales, y el sábado y domingo habrá creaciones de oro iniciales."
  },
  Tutorial_17808_Desc_2 = {
    Text = "La Inmersión fantasmal normalmente actualiza su temporada cada 28 días. Pasar la Inmersión fantasmal una vez durante una temporada te permite participar en la <TutorialHighlight:Clasificación de temporada>. Al final de la temporada, las clasificaciones se finalizarán y las recompensas de clasificación se enviarán por correo."
  },
  Tutorial_17808_Desc_3 = {
    Text = "El guardián puede usar <TutorialHighlight: certificado de agente>, para recibir directamente las recompensas del entrenamiento diario de inmersión fantasmal. <TutorialHighlight: certificado de agente> se puede obtener a través de los juicios semanales, con un máximo de 3 certificados almacenados"
  },
  Tutorial_17808_Title_1 = {
    Text = "Inmersión fantasmal"
  },
  Tutorial_17809_Desc_1 = {
    Text = "A través de eventos y d-marca, se puede obtener <TutorialHighlight:reliquia>, <TutorialHighlight:reliquia> puede fortalecer la capacidad de combate de nuestro equipo. Un buen guardián suele elegir <TutorialHighlight:reliquia> que se adecúe mejor a las necesidades del equipo"
  },
  Tutorial_17809_Title_1 = {Text = "Reliquia"},
  Tutorial_17810_Desc_1 = {
    Text = "Disipa la niebla, el alcance del mapa aumenta <TutorialHighlight:2> casillas, permitiendo una mejor planificación de la ruta"
  },
  Tutorial_17810_Title_1 = {Text = "proyector"},
  Tutorial_17811_Desc_1 = {
    Text = "El objetivo que está en estado de <TutorialHighlight:veneno> recibe daño equivalente al número de capas de <TutorialHighlight:veneno> al final del turno. El daño de <TutorialHighlight:veneno> <TutorialHighlight:no puede ser crítico>"
  },
  Tutorial_17811_Title_1 = {Text = "Veneno"},
  Tutorial_17812_Desc_1 = {
    Text = "Los objetivos en estado de <TutorialHighlight:Vulnerable> reciben un 50% más de daño y se elimina 1 capa de <TutorialHighlight:Vulnerable> al final del turno. Aprovecha este estado para infligir más daño"
  },
  Tutorial_17812_Title_1 = {Text = "Vulnerable"},
  Tutorial_17813_Desc_1 = {
    Text = "\"Ruinas de disolución\" y \"Tabú de compilación\" pueden ser reproducidas <TutorialHighlight:reproducción> después de alcanzar una calificación de tres estrellas en las etapas. A través de <TutorialHighlight:reproducción> se pueden obtener rápidamente recompensas de etapa"
  },
  Tutorial_17813_Title_1 = {Text = "Reproducir"},
  Tutorial_17814_Desc_1 = {
    Text = "<TutorialHighlight:Blindaje> puede reemplazar la vida para soportar daño, al final del turno <TutorialHighlight:se elimina automáticamente> todo el blindaje, el límite del blindaje es igual al <TutorialHighlight:límite de vida> del equipo. Intenta <TutorialHighlight:igualar el blindaje al daño total de todos los enemigos en este turno> para obtener la victoria en combate al menor costo posible."
  },
  Tutorial_17814_Title_1 = {Text = "Blindaje"},
  Tutorial_17815_Desc_1 = {
    Text = "Repetir la obtención del Despertado lo convertirá en <TutorialHighlight:Fragmento>. Consumir <TutorialHighlight:Fragmento> para elevar el Nivel Espiritual del Despertado, lo que permitirá que las habilidades del Despertado obtengan capacidades especiales adicionales. Cuando el Nivel Espiritual del Despertado esté completo, cualquier fragmento correspondiente que se obtenga se convertirá en <TutorialHighlight:Fragmento de Retroceso del Alma>."
  },
  Tutorial_17815_Title_1 = {Text = "Fragmento"},
  Tutorial_17816_Desc_1 = {
    Text = "La aritmética es <TutorialHighlight:compartida por todo el equipo>, jugar una carta requiere consumir <TutorialHighlight:aritmética>. La aritmética se <TutorialHighlight:restaura automáticamente al límite> al inicio del turno y se <TutorialHighlight:limpia automáticamente> al final del turno. Para mejorar la eficiencia del uso de la aritmética, intenta <TutorialHighlight:consumir toda la aritmética antes de finalizar el turno>."
  },
  Tutorial_17816_Title_1 = {
    Text = "Aritmética"
  },
  Tutorial_17817_Desc_1 = {
    Text = "Al vencer a los enemigos en <TutorialHighlight:Existencia trascendental>, puedes obtener materiales de <TutorialHighlight:mejora de habilidades> avanzados, que se pueden reclamar una vez por semana. También se pueden combinar y sustituir varios materiales en <TutorialHighlight:alquimia>"
  },
  Tutorial_17817_Title_1 = {
    Text = "Existencia trascendental"
  },
  Tutorial_17818_Desc_1 = {
    Text = "Obtén después para usar en<TutorialHighlight:inventario>, puede mejorar rápidamente el nivel del despertador y el nivel de habilidad según los valores preestablecidos"
  },
  Tutorial_17818_Title_1 = {
    Text = "Amplificador de Gnosis"
  },
  Tutorial_17819_Desc_1 = {
    Text = "Cuando el alíen del despertador alcance <TutorialHighlight:100>, se puede liberar <TutorialHighlight:explosión del alíen>. Los efectos de la explosión del alíen varían entre los diferentes despertadores, usarlos razonablemente puede <TutorialHighlight:ser más efectivo>"
  },
  Tutorial_17819_Title_1 = {Text = "Exaltar"},
  Tutorial_17820_Desc_1 = {
    Text = "Los objetivos en estado de <TutorialHighlight:Frágil> reciben un 25% menos de escudo y se elimina automáticamente 1 capa de <TutorialHighlight:Frágil> al final del turno. Si nuestro equipo está en estado de <TutorialHighlight:Frágil>, recuerda encontrar una manera de eliminar el estado de <TutorialHighlight:Frágil> antes de defender, o cambiar de estrategia y atacar con todas las fuerzas en este turno."
  },
  Tutorial_17820_Title_1 = {Text = "Frágil"},
  Tutorial_17821_Desc_1 = {
    Text = "Equipar <TutorialHighlight:rueda del destino> al cuerpo despierto mejora sus atributos y otorga habilidades especiales"
  },
  Tutorial_17821_Title_1 = {
    Text = "Rueda del destino"
  },
  Tutorial_17822_Desc_1 = {
    Text = "El objetivo que está en estado de <TutorialHighlight:sangrado> recibe daño equivalente al número de capas de <TutorialHighlight:sangrado> al final del turno y luego <TutorialHighlight:elimina el estado de sangrado>.\nAl <TutorialHighlight:recuperar PV>, elimina capas de sangrado equivalentes a <TutorialHighlight:doble de la cantidad recuperada>. El daño de sangrado <TutorialHighlight:no puede ser crítico>."
  },
  Tutorial_17822_Title_1 = {Text = "Sangrar"},
  Tutorial_17823_Desc_1 = {
    Text = "El despertador del caos puede <TutorialHighlight: romper las limitaciones del reino> y alinear con otros despertadores de reino, teniendo diferentes efectos simbióticos. Si hay un despertador del caos en cualquier equipo, se obtiene un 100% de resistencia a la muerte"
  },
  Tutorial_17823_Desc_2 = {
    Text = "En comparación con los equipos de otros reinos, los equipos del reino del Caos obtienen energía de llave de plata más rápidamente, y al liberar la segunda llave, pueden elegir entre todas las llaves, y la llave elegida se activará 2 veces. Por lo tanto, los equipos del reino del Caos dependen más de la colaboración entre las llaves, ¡elegir la llave adecuada puede mejorar enormemente la fuerza del equipo del reino del Caos!"
  },
  Tutorial_17823_Title_1 = {Text = "Caos"},
  Tutorial_17824_Desc_1 = {
    Text = "Por cada punto de <TutorialHighlight:alerta>, cada vez que obtenga escudo, recibirá 1 punto de escudo adicional"
  },
  Tutorial_17824_Title_1 = {Text = "Alerta"},
  Tutorial_17825_Desc_1 = {
    Text = "Tras completar la operación de investigación por primera vez, puedes obtener <TutorialHighlight: material de activación de resonancia>, que se puede usar para activar una poderosa <TutorialHighlight: resonancia>, que tendrá efecto en todos los niveles de este capítulo"
  },
  Tutorial_17825_Title_1 = {Text = "Resonancia"},
  Tutorial_17826_Desc_1 = {
    Text = "Cuando nuestro equipo está en estado de <TutorialHighlight:Sello de Aliemus>, no puede liberar la explosión de frenesí. Antes de que el enemigo vaya a causar el <TutorialHighlight:Sello de Aliemus>, puedes liberar la explosión de frenesí para evitar desperdiciar el frenesí."
  },
  Tutorial_17826_Title_1 = {
    Text = "Sello de Alienación"
  },
  Tutorial_17827_Desc_1 = {
    Text = "Consumir <TutorialHighlight:elixir de gnosis> puede elevar el nivel del cuerpo despierto, y al subir de nivel, sus atributos también mejorarán. Una vez alcanzado el límite de nivel, primero se deberá realizar un ascenso, el cual aumentará el límite de nivel del cuerpo despierto."
  },
  Tutorial_17827_Title_1 = {
    Text = "Elixir de Gnosis"
  },
  Tutorial_17828_Desc_1 = {
    Text = "<TutorialHighlight:Fuerza> Cada vez que se reduce en 1 punto, se reduce en 1 punto el daño de <TutorialHighlight:daño activo>"
  },
  Tutorial_17828_Title_1 = {Text = "STR▼"},
  Tutorial_17829_Desc_1 = {
    Text = "Antes de recibir daño, inmuniza el daño y elimina una capa de <TutorialHighlight:Barrera>. Cuanto mayor sea el daño, mayor será el beneficio de la <TutorialHighlight:Barrera>"
  },
  Tutorial_17829_Title_1 = {Text = "Barrera"},
  Tutorial_17830_Desc_1 = {
    Text = "Los objetivos en estado de <TutorialHighlight:debilidad> reciben un 25% menos de daño y se elimina automáticamente 1 capa de <TutorialHighlight:debilidad> al final del turno. Si nuestro equipo está en estado de <TutorialHighlight:debilidad>, recuerda encontrar una manera de eliminar el estado de <TutorialHighlight:debilidad> antes de atacar, o cambiar de estrategia y defenderse con todas las fuerzas en este turno."
  },
  Tutorial_17830_Title_1 = {Text = "Debilidad"},
  Tutorial_17831_Desc_1 = {
    Text = "Al vencer a los enemigos en <TutorialHighlight:Registro Prohibido>, puedes obtener un <TutorialHighlight:Pacto> que mejora las habilidades del Cuerpo Despertado. Al pasar cada capítulo de la historia principal se desbloquean nuevos niveles de <TutorialHighlight:Registro Prohibido>. El Pacto también se puede intercambiar en la tienda."
  },
  Tutorial_17831_Title_1 = {
    Text = "Registro Prohibido"
  },
  Tutorial_17832_Desc_1 = {
    Text = "El equipo ultra juega la <TutorialHighlight:primera> tarjeta de comando de cada turno, la copia temporal entrará en <TutorialHighlight:Espacio Hiperspacial> y activará un poderoso efecto de <Impulso>. Cuando el espacio hiperspacial alcance su límite, obtén 1 <TutorialHighlight:Turno Ultra> adicional, <TutorialHighlight:los Turnos Ultra pueden activar todos los efectos de Impulso>. El secreto básico para jugar bien el equipo ultra: planifica cuidadosamente la primera carta jugada cada turno."
  },
  Tutorial_17832_Title_1 = {Text = "Ultra"},
  Tutorial_17833_Desc_1 = {
    Text = "Cuando la vida de nuestro equipo se agote, se puede activar <TutorialHighlight:Cuerpo de Gnosis de Emergencia> para restaurar todos los estados. El Cuerpo de Gnosis de Emergencia se restaura automáticamente  <TutorialHighlight:1> vez al día, con un límite de <TutorialHighlight:5> veces. Aplícalo razonablemente en <TutorialHighlight:batallas difíciles>, no lo desperdicies sin pensar."
  },
  Tutorial_17833_Title_1 = {
    Text = "Cuerpo de Gnosis de Emergencia"
  },
  Tutorial_17834_Desc_1 = {
    Text = "Busca cuidadosamente los puntos ligeramente brillantes en el mapa, puede haber sorpresas si los investigas"
  },
  Tutorial_17834_Title_1 = {
    Text = "Punto de extracción"
  },
  Tutorial_17835_Desc_1 = {
    Text = "Representa el daño total de todos los enemigos en este turno. Un consejo práctico de los Guardianes del Secreto: <TutorialHighlight:Haz que el escudo sea igual al daño total del enemigo>"
  },
  Tutorial_17835_Title_1 = {
    Text = "Daño total del enemigo"
  },
  Tutorial_17837_Desc_1 = {
    Text = "Cuando la <TutorialHighlight:Fusión Embrionaria> del equipo de Carne y sangre alcance su límite, se obtendrá 1 <TutorialHighlight:\"Embrión\">. Liberar Exaltar consumirá el <TutorialHighlight:\"Embrión\"> para activar un poderoso efecto de <TutorialHighlight:Devorar>. Por lo tanto, es recomendable Liberar Exaltar cuando haya <TutorialHighlight:\"Embrión\"> en la Mano; de lo contrario, no se podrá aprovechar al máximo la fuerza del equipo de Carne y sangre."
  },
  Tutorial_17837_Desc_2 = {
    Text = "Al final de cada batalla, se acumulará un 5% de la recuperación de la vida máxima en el Horno Carmesí. Si hay <TutorialHighlight:\"Embrión\"> no utilizado, cada embrión también acumulará un 5% de la recuperación de la vida máxima en el horno. El Horno Carmesí se puede utilizar para recuperar la vida de nuestro equipo, y se puede convertir el horno en vida una vez por turno. El Guardián del secreto debe planificar adecuadamente el momento de uso del Horno Carmesí para lograr un efecto que cambie el rumbo de la batalla."
  },
  Tutorial_17837_Title_1 = {
    Text = "Carne y sangre"
  },
  Tutorial_17838_Desc_1 = {
    Text = "En el punto de intersección, puedes elegir restaurar el 50% de la vida perdida de nuestro equipo, o designar 1 despertador. Cuando la vida de nuestro equipo es baja, se recomienda elegir restaurar vida, de lo contrario, se recomienda elegir despertar al despertador"
  },
  Tutorial_17838_Title_1 = {
    Text = "Punto de contacto"
  },
  Tutorial_17839_Desc_1 = {
    Text = "Lugar para consumir marca negra y fortalecer a nuestro equipo, generalmente ofrece 1 espacio de inscripción, 1 espacio de creación de plata y 1 espacio de creación de oro. Si no hay artículos necesarios aquí, puedes hacer clic en la esquina superior derecha en <TutorialHighlight:refrescar>, d-mark proporcionará nuevos artículos."
  },
  Tutorial_17839_Title_1 = {Text = "D-mark"},
  Tutorial_17840_Desc_1 = {
    Text = "Pasar a la fuerza <TutorialHighlight:ilusión> causará \"síntomas\""
  },
  Tutorial_17840_Title_1 = {Text = "Ilusión"},
  Tutorial_17841_Desc_1 = {
    Text = "A través de la carta de comando, el despertador puede obtener <TutorialHighlight:aliemus>. Cuanto mayor sea el nivel de habilidad de la carta de comando, más aliemus se obtendrá"
  },
  Tutorial_17841_Title_1 = {
    Text = "Alienación"
  },
  Tutorial_17842_Desc_1 = {
    Text = "Al vencer enemigos e investigar eventos, puedes obtener <TutorialHighlight:el sigilo negro>, la propiedad de <TutorialHighlight:caída de el sigilo negro> de los despertadores puede aumentar la cantidad de el sigilo negro obtenido"
  },
  Tutorial_17842_Desc_2 = {
    Text = "En la d-marca, se puede consumir <TutorialHighlight:el sigilo negro> para comprar plegarias y reliquias, también se puede usar para despertar a los despertadores. Antes de la batalla final, intenta gastar todos los sellos negros para fortalecer a nuestro equipo"
  },
  Tutorial_17842_Title_1 = {
    Text = "Marca negra"
  },
  Tutorial_17843_Desc_1 = {
    Text = "Al recibir un ataque, inflige daño equivalente a la cantidad de <TutorialHighlight:mostrador> al atacante. El daño <TutorialHighlight:mostrador> <TutorialHighlight:no puede criticar>"
  },
  Tutorial_17843_Title_1 = {
    Text = "Contrataque"
  },
  Tutorial_17844_Desc_1 = {
    Text = "Por cada punto de <TutorialHighlight:Fuerza>, se añade 1 punto de daño adicional al causar daño activo"
  },
  Tutorial_17844_Title_1 = {Text = "Fuerza"},
  Tutorial_17845_Desc_1 = {
    Text = "El despertador de despacho completa la tarea de investigación y puede recibir recompensas correspondientes. Cuanto mayor sea el nivel total del despertador de despacho <TutorialHighlight:Nivel total>, mayores serán las recompensas, con un máximo calculado a partir de 240 niveles totales"
  },
  Tutorial_17845_Title_1 = {Text = "Envío"},
  Tutorial_17847_Desc_1 = {
    Text = "Al recibir daño fatal, hay <TutorialHighlight:probabilidad equivalente a la resistencia a la muerte> de inmunizar este daño y retener 1 punto de vida; <TutorialHighlight:tras un éxito, la resistencia a la muerte se reduce a la mitad>. La resistencia a la muerte del equipo es equivalente a la suma de la resistencia a la muerte de todos los Despertados, aumentar la resistencia a la muerte del equipo ayuda a mejorar la tasa de tolerancia al error en combate."
  },
  Tutorial_17847_Title_1 = {
    Text = "Resistencia a la muerte"
  },
  Tutorial_17848_Desc_1 = {
    Text = "Al comenzar la batalla con el equipo Aequor, se genera 1 <TutorialHighlight:Tentáculo>, que ataca a los enemigos en la primera fila al final del turno. Se puede entender el daño y la cantidad de ataques actuales del tentáculo a través de la fórmula debajo del icono del tentáculo. Algunos Despertados pueden aumentar el número de tentáculos y el daño de los tentáculos, causando un gran daño al final del turno."
  },
  Tutorial_17848_Title_1 = {Text = "Aequor"},
  Tutorial_17850_Desc_1 = {
    Text = "Jugar cartas en la mano requiere consumir aritmética, al final del turno todas las cartas en la mano irán al <TutorialHighlight:Mazo de Descarte>. Planificar razonablemente el <TutorialHighlight:orden de juego> será clave para la victoria en la batalla."
  },
  Tutorial_17850_Title_1 = {Text = "Mano"},
  Tutorial_17851_Desc_1 = {
    Text = "Representa la acción que el enemigo tomará en el próximo turno. Usar <TutorialHighlight:intención> para tomar decisiones en este turno es clave en la batalla"
  },
  Tutorial_17851_Title_1 = {
    Text = "Intención del enemigo"
  },
  Tutorial_17852_Desc_1 = {
    Text = "<TutorialHighlight:Mejora de habilidades> puede mejorar los atributos del cuerpo despierto y fortalecer el efecto de las cartas de comando. Haz clic en el siguiente nivel en la interfaz de habilidades del cuerpo despierto para previsualizar el efecto después de la mejora."
  },
  Tutorial_17852_Desc_2 = {
    Text = "Los Despertados de diferentes dominios requieren distintos <TutorialHighlight:materiales para mejorar habilidades>."
  },
  Tutorial_17852_Title_1 = {
    Text = "Fortalecer habilidades"
  },
  Tutorial_20768_Desc_1 = {
    Text = "Cuando un Despertado consume Aritmética, obtiene <TutorialHighlight:Llave Plateada>. El atributo de <TutorialHighlight:Regeneración de Llave Plateada> aumenta la cantidad de <TutorialHighlight:Llave Plateada> obtenida."
  },
  Tutorial_20768_Title_1 = {
    Text = "Llave Plateada"
  },
  Tutorial_20769_Desc_1 = {
    Text = "<TutorialHighlight: puerta oxidada> bloqueará rutas de investigación importantes, intenta buscar en el mapa un objeto llamado <TutorialHighlight: llave oxidada>, que puede ser utilizado para abrir <TutorialHighlight: puerta oxidada>"
  },
  Tutorial_20769_Title_1 = {
    Text = "Puerta oxidada"
  },
  Tutorial_20770_Desc_1 = {
    Text = "<TutorialHighlight: llave oxidada> puede abrir <TutorialHighlight: puerta oxidada> que bloquea tu camino"
  },
  Tutorial_20770_Title_1 = {
    Text = "Llave oxidada"
  },
  Tutorial_20771_Desc_1 = {
    Text = "<TutorialHighlight:Reino sin luz> incluye una serie de niveles de cuatro reinos, al completarlos se pueden obtener recompensas como Núcleos de plata y Elixir de Gnosis, ¡y al acumular estrellas hasta alcanzar los requisitos especificados se pueden obtener recompensas adicionales como Núcleos de plata y Núcleo Puro!"
  },
  Tutorial_20771_Desc_2 = {
    Text = "Las fisuras en diferentes reinos plantearán requisitos al reino de los despertadores en el equipo investigador, solo los equipos que <TutorialHighlight:satisfacen los requisitos> podrán investigar"
  },
  Tutorial_20771_Title_1 = {
    Text = "Reino sin luz"
  },
  Tutorial_20772_Desc_1 = {
    Text = "Cuando la energía de llave de plata alcanza <TutorialHighlight:1000>, se puede liberar la <TutorialHighlight:Posse> equipada. Cada turno se pueden liberar 2 veces la llave, pero en la segunda liberación, se selecciona 1 de 3 llaves aleatorias para liberar, y la llave seleccionada no puede ser elegida de nuevo durante esta exploración. Al formar el equipo, elige las llaves adecuadas para que el proceso de investigación sea más fluido."
  },
  Tutorial_20772_Title_1 = {Text = "Posse"},
  Tutorial_20773_Desc_1 = {
    Text = "Al consumir la misma <TutorialHighlight:Rueda del destino> para superponer, se pueden mejorar los atributos y habilidades especiales. Cuando se superpone de 1 a 3 veces, el efecto de la Rueda del destino se fortalece; al superponerse de 4 a 15 veces, los atributos de la Rueda del destino se mejoran. Puedes hacer clic en el botón \"Siguiente nivel\" en la interfaz de superposición para previsualizar los cambios después de la superposición."
  },
  Tutorial_20773_Title_1 = {
    Text = "Acumulación de la rueda del destino"
  },
  Tutorial_22247_Desc_1 = {
    Text = "<TutorialHighlight:Mejora del pacto> puede aumentar la intensidad de los atributos del pacto, hasta un máximo de nivel 12. La descomposición del pacto puede obtener el remanente correspondiente, y el intercambio de materiales en los recursos puede obtener <TutorialHighlight:Sello de mil caras>. La mejora del pacto requiere el consumo de <TutorialHighlight:Sello de mil caras>, y descomponer un pacto mejorado también devolverá el consumo de mejora de <TutorialHighlight:Sello de mil caras>."
  },
  Tutorial_22247_Title_1 = {
    Text = "Actualización del pacto"
  },
  Tutorial_22248_Desc_1 = {
    Text = "A través de la transcripción, el <TutorialHighlight:pacto> puede obtener atributos de diferentes tipos y potencias al azar. Los atributos de subatributos no están relacionados con las partes y pueden incluir 8 tipos: probabilidad de crítico, daño crítico, nivel de recarga de ira, nivel de carga de la llave de plata, maestría del reino, recompensa de sello negro, amplificación de daño y resistencia a la muerte. Durante la transcripción, si deseas retener un atributo específico, puedes seleccionar <TutorialHighlight:bloquear>, el atributo bloqueado no cambiará durante la transcripción."
  },
  Tutorial_22248_Title_1 = {
    Text = "Transcripción del pacto"
  },
  Tutorial_23466_Desc_1 = {
    Text = "A medida que aumenta el nivel del guardián, <TutorialHighlight:la fuerza de las reliquias y las inscripciones> también aumentará, y el <TutorialHighlight:impacto de cada punto de constitución del Despertado en la salud del equipo> también se incrementará. Se puede obtener una gran cantidad de experiencia del guardián a través de operaciones de investigación e interludios. Cada vez que se consuma 1 punto de energía, se obtendrá 1 punto de experiencia del guardián."
  },
  Tutorial_23466_Title_1 = {
    Text = "Nivel del Guardián del Secreto"
  },
  Tutorial_47538_Desc_1 = {
    Text = "La Zona de Desastre es un sistema de juego desafiante. Los Guardianes deben formar equipos de desafío flexibles para obtener más puntos de entrenamiento y recompensas. En alta alerta, los enemigos son más fuertes y hay varios efectos negativos"
  },
  Tutorial_47538_Desc_2 = {
    Text = "En la Zona Prohibida de Catástrofe de Fusión hay reglas de restricción únicas: el mismo Despertado y Posse, así como Ruedas del Destino con el mismo nombre, no pueden participar de nuevo. El Guardián del Secreto puede seleccionar de manera flexible el equipo para este desafío, basándose en las Reliquias iniciales, monstruos y niveles recomendados, utilizando la estrategia de la carrera de Tian Ji para obtener la mayor cantidad posible de Puntos de Entrenamiento. Los Despertados que entren en combate a través de la <TutorialHighlight:asistencia> no se ven afectados por esta restricción."
  },
  Tutorial_47538_Title_1 = {
    Text = "Zona Prohibida de Catástrofe de Fusión"
  },
  Tutorial_54390_Desc_1 = {
    Text = "En el modo <TutorialHighlight:traphase>, los <TutorialHighlight:estados> de los despertadores de ambas partes en la interfaz de batalla se mostrarán debajo de su vida y su locura, haciendo clic se podrá ver los efectos específicos"
  },
  Tutorial_54390_Desc_2 = {
    Text = "Los siguientes pertenecen a <TutorialHighlight:Estados positivos> (haz clic para ver los detalles): <TauntKeywords:Pulla>, <PVPPowerIconKeywords:Fuerza>, <EnergyStorageKeywords:Cargar>, <PVPProtectiveKeywords:Barrera>, <PVPRetaliateIconKeywords:Contrataque>, <ReinforceKeywords:Fortaleza>, <StrengthenKeywords:Refuerzo>."
  },
  Tutorial_54390_Desc_3 = {
    Text = "Pertenece a <TutorialHighlight:estado negativo> los siguientes (haga clic para ver detalles): <PVPEntanglementKeywords:entrelazados>, <PVPVulnerabilityIconKeywords:vulnerable>, <PVPSlowKeywords:estancamiento>, <ComaKeywords:petrificar>, <DisarmKeywords:parálisis>, <PVPMethysisKeywords:veneno>, <PVPEmptinessKeywords:vacío>, <PVPBleedingKeywords:sangrando>, <PVPSeriousInjuryKeywords:plaga>, <ComaKeywords:se desmayó>."
  },
  Tutorial_54390_Title_1 = {Text = "Estado"},
  Tutorial_54391_Desc_1 = {
    Text = "En el modo <TutorialHighlight:Fase de Duelo>, algunas cartas de los Despertados tendrán diferentes efectos de <TutorialHighlight:Atributo>, que se pueden consultar en el sistema de <TutorialHighlight:colecciones> o manteniendo presionada la carta durante la batalla. Los atributos incluyen (haga clic para ver detalles): <PVPPenetrateKeywords:Atravesar>, <PrepareKeywords:Preparar>, <PVPResurrectionKeywords:Renacimiento>, <PVPHoldingKeywords:En mano>, <PhantomKeywords:Fantasía>, <PVPRaidKeywords:Emboscada>."
  },
  Tutorial_54391_Title_1 = {Text = "Atributo"},
  Tutorial_54392_Desc_1 = {
    Text = "En el modo <TutorialHighlight:Fase de Duelo>, los puntos de coincidencia se reiniciarán con el final de cada temporada y el comienzo de una nueva. La información sobre el nombre de la temporada y su duración se puede ver en el lado derecho de la interfaz. Al reiniciar los puntos, los jugadores que superen los 1000 puntos en la temporada anterior verán reducida a la mitad la parte que exceda."
  },
  Tutorial_54392_Desc_2 = {
    Text = "Durante cada temporada, habrá <TutorialHighlight:Misiones de Temporada>. Completa las Misiones de Temporada para reclamar valiosas recompensas. Las Misiones de Temporada se reiniciarán cuando la temporada se actualice."
  },
  Tutorial_54392_Title_1 = {Text = "Temporada"},
  Tutorial_54393_Desc_1 = {
    Text = "En el modo <TutorialHighlight:Fase de Duelo>, tras la caída del Despertado, las cartas de ese Despertado en la mano se convierten en <TutorialHighlight:Ilusión>. Equipar la <TutorialHighlight:Rueda del destino> a un Despertado caído también otorga 1 Ilusión y recupera la aritmética consumida. Las ilusiones también pueden ser combinadas en <TutorialHighlight:Pequeño deseo> a través de los efectos de ciertas ruedas del destino."
  },
  Tutorial_54393_Title_1 = {Text = "Ilusión"},
  Tutorial_54394_Desc_1 = {
    Text = "En el modo <TutorialHighlight:Fase de Duelo>, en el primer turno ambos bandos tienen 3 puntos de <TutorialHighlight:Aritmética> y su límite, el que juega segundo recibirá una carta de <TutorialHighlight:Golpea al último, golpea mejor>. Después, al comienzo de cada turno, el límite de aritmética y la cantidad de recuperación aumentarán en 1 punto hasta llegar a 10 puntos. Además del aumento automático, hay otros medios para aumentar o reducir el límite de aritmética; una vez que el límite de aritmética alcanza 10, cualquier punto adicional se convertirá en robar 1 carta."
  },
  Tutorial_54394_Title_1 = {
    Text = "Aritmética"
  },
  Tutorial_54395_Desc_1 = {
    Text = "En el modo <TutorialHighlight:Fase de Duelo>, cada Despertado también tiene <TutorialHighlight:Alienación> y <TutorialHighlight:Exaltar>. Se puede obtener locura usando cartas de <TutorialHighlight:golpear> o cartas de <TutorialHighlight:habilidad> específicas, y también se ganará locura al perder vida por daño (se obtiene 1 punto de locura por cada 2% de vida perdida o su equivalente en blindaje). Cuando la locura alcanza 100, haz clic en el Despertado correspondiente para seleccionar liberar la Exaltación."
  },
  Tutorial_54395_Title_1 = {
    Text = "Alienación"
  },
  Tutorial_54396_Desc_1 = {
    Text = "En el modo <TutorialHighlight:Fase de Duelo>, al ganar en combates emparejados se obtienen ciertos puntos. Una vez que la puntuación histórica más alta cumple con los requisitos de gradiente, se puede reclamar la recompensa correspondiente a esa fase. Esta recompensa es única, no se restablece con la temporada y se puede consultar a través de la pestaña \"Registro de Duelo\" en el lado izquierdo de la interfaz."
  },
  Tutorial_54396_Title_1 = {
    Text = "Récord de ajedrez"
  },
  Tutorial_54397_Desc_1 = {
    Text = "En modo <TutorialHighlight:traphase>, en la pestaña \"colecciones\" a la izquierda de la interfaz puedes navegar toda la información sobre los despertadores, rueda del destino y llave"
  },
  Tutorial_54397_Title_1 = {Text = "Colección"},
  Tutorial_54398_Desc_1 = {
    Text = "En el modo <TutorialHighlight:traphase>, cada despertador tiene 2 cartas de <TutorialHighlight:golpe> y 3 cartas de <TutorialHighlight:habilidad>. Normalmente, diferentes cartas de habilidad tendrán diferentes costos de aritmética"
  },
  Tutorial_54398_Title_1 = {Text = "Habilidad"},
  Tutorial_54399_Desc_1 = {
    Text = "En el modo <TutorialHighlight:Fase de Duelo>, el número de cartas robadas automáticamente por turno también es 5, y el <TutorialHighlight:Tamaño Máximo de la Mano> predeterminado también es 10. Se puede ver el número actual de cartas en nuestra mano y el límite en la esquina inferior derecha de la interfaz de batalla, y la situación del oponente en la esquina superior derecha. Se pueden utilizar otros métodos para cambiar el número de cartas robadas por turno y el tamaño máximo de la mano."
  },
  Tutorial_54399_Title_1 = {Text = "Mano"},
  Tutorial_54400_Desc_1 = {
    Text = "En el modo <TutorialHighlight:Fase de Duelo>, diferentes Despertados tienen diferentes <TutorialHighlight:roles>, un total de 5. Estos son específicamente <TutorialHighlight:Guardián>, <TutorialHighlight:lucha>, <TutorialHighlight:Luminis>, <TutorialHighlight:Estrella Infausta> y <TutorialHighlight:Bendición>. Al realizar una <TutorialHighlight:Formación>, se deben seleccionar 4 Despertados de diferentes roles para formar el equipo."
  },
  Tutorial_54400_Title_1 = {
    Text = "Posicionamiento"
  },
  Tutorial_54401_Desc_1 = {
    Text = "En el modo <TutorialHighlight:traphase>, al hacer clic en \"Iniciar coincidencia\" en la esquina inferior derecha de la interfaz, se entrará en la interfaz de alineación"
  },
  Tutorial_54401_Desc_2 = {
    Text = "El soporte de pre-alianza permite guardar múltiples conjuntos, en la esquina superior izquierda se puede editar el nombre del equipo, y cada equipo está compuesto por 4 despertadores, 4 ruedas del destino y 2 pandillas"
  },
  Tutorial_54401_Title_1 = {
    Text = "Pre-alineación del grupo"
  },
  Tutorial_54705_Desc_1 = {
    Text = "En modo <TutorialHighlight:traphase>, haz clic en tu <TutorialHighlight:avatar>, selecciona la <TutorialHighlight:expresión de combate> que deseas enviar y expresa tus sentimientos a tu oponente"
  },
  Tutorial_54705_Title_1 = {Text = "expresión"},
  Tutorial_54706_Desc_1 = {
    Text = "<TutorialHighlight: traphase> es un juego de dos personas, donde ambas partes utilizan sus propios equipos preformados para <TutorialHighlight: emparejarse en combate>, siendo emparejadas con oponentes de igual nivel en la cercanía"
  },
  Tutorial_54706_Desc_2 = {
    Text = "Puedes obtener puntos de duelo a través de combates, desbloquea <TutorialHighlight:recompensas únicas> según tu <TutorialHighlight:puntuación más alta> alcanzada"
  },
  Tutorial_54706_Desc_3 = {
    Text = "Cada semana, según el ranking de puntos, se obtendrá un <TutorialHighlight:Título> y al día siguiente se recibirán <TutorialHighlight:Rosa Dorada>. \n Si se participa en la \"Fase de Duelo\" y en la \"Inmersión fantasmal\" al mismo tiempo, el cálculo de la Rosa Dorada se basará en la recompensa <TutorialHighlight:más alta> de estos dos modos de juego."
  },
  Tutorial_54706_Title_1 = {
    Text = "Introducción al duelo"
  },
  Tutorial_74798_Desc_1 = {
    Text = "En los diferentes niveles existen distintos <TutorialHighlight:capítulos de nivel> ambientales, que alteran drásticamente las reglas generales y los efectos de creación. Puedes consultar los detalles haciendo clic en las pestañas relevantes en las interfaces de cada nivel."
  },
  Tutorial_74798_Title_1 = {
    Text = "Capítulo del nivel"
  },
  Tutorial_81370_Desc_1 = {
    Text = "<TutorialHighlight:Retroceso del Despertado> puede devolver varios consumos de desarrollo del Despertado."
  },
  Tutorial_81370_Desc_2 = {
    Text = "<TutorialHighlight:Rastreo de crianza> restablecerá el nivel, ascenso, habilidades y estado de profundización de la gnosis del Despertado, y se devolverán por completo los materiales y bonos consumidos."
  },
  Tutorial_81370_Desc_3 = {
    Text = "<TutorialHighlight:Restitución del Espíritu> restablecerá el estado de iluminación del despertador y el límite de nivel superior otorgado por la iluminación, devolviendo todos los materiales consumidos."
  },
  Tutorial_81370_Desc_4 = {
    Text = "<TutorialHighlight:Devolver el Blackpool> incluirá el efecto de \"Regresión de crianza\" y además restablecerá al propio Despertado, devolviéndolo a su estado no desbloqueado."
  },
  Tutorial_81370_Title_1 = {
    Text = "Retroceso del Despertado"
  },
  Tutorial_81371_Desc_1 = {
    Text = "<TutorialHighlight:Mejora del despertado> es una de las formas más rápidas de mejorar los atributos del despertado. Consumir <TutorialHighlight:extracto de gnosis> puede elevar el nivel del despertado."
  },
  Tutorial_81371_Desc_2 = {
    Text = "Después de que el Despertado alcance el límite de nivel, es necesario mejorar dicho límite mediante <TutorialHighlight:Ascenso>. Los Despertados de diferentes dominios requieren distintos <TutorialHighlight:Materiales de Ascenso>."
  },
  Tutorial_81371_Title_1 = {
    Text = "Mejora del despertado"
  },
  Tutorial_81372_Desc_1 = {
    Text = "<TutorialHighlight:Activación Espiritual> puede mejorar enormemente el efecto de las cartas de comando del Despertado. El nivel espiritual 7 desbloquea <TutorialHighlight:Sobrecarga>, lo que otorga efectos adicionales al Despertado al exaltar. Los niveles espirituales 11 y 15 pueden aumentar el límite de nivel del Despertado en 5 niveles"
  },
  Tutorial_81372_Title_1 = {
    Text = "Iluminar activado"
  }
})
return Text_Tutorial
