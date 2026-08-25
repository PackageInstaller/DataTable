__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Event = readonly({
  Event_116371_ChoiceDesc1 = {Text = "[Salir]"},
  Event_116371_Desc = {
    Text = "Aceptas la llamada de la escuela, la voz familiar te tranquiliza. Te animas y sigues adelante"
  },
  Event_116371_Name = {
    Text = "Punto de contacto"
  },
  Event_116372_ChoiceDesc1 = {Text = "[Salir]"},
  Event_116372_Desc = {
    Text = "Has activado una habitación desconocida."
  },
  Event_116372_Name = {
    Text = "Desconocido"
  },
  Event_116373_ChoiceDesc1 = {Text = "[Salir]"},
  Event_116373_Desc = {
    Text = "Encontraste el tesoro."
  },
  Event_116373_Name = {Text = "tesoro"},
  Event_116374_ChoiceDesc1 = {
    Text = "[Conectar] recuperar Arg2 puntos de vida"
  },
  Event_116374_Desc = {
    Text = "Exploras en la niebla, de repente, el emblema en tu pecho emite un débil resplandor plateado. ¿Quién te llama desde el comunicador?"
  },
  Event_116374_Name = {
    Text = "Punto de contacto"
  },
  Event_116389_ChoiceDesc1 = {Text = "[Salir]"},
  Event_116389_Desc = {
    Text = "Moldear todavía está durmiendo...zzZZ"
  },
  Event_116389_Name = {Text = "Moldear"},
  Event_116429_ChoiceDesc1 = {Text = "[Salir]"},
  Event_116429_Desc = {
    Text = "Has activado un evento aleatorio 3."
  },
  Event_116429_Name = {
    Text = "Evento aleatorio 3"
  },
  Event_116430_ChoiceDesc1 = {Text = "[Salir]"},
  Event_116430_Desc = {
    Text = "Has activado un evento aleatorio 1."
  },
  Event_116430_Name = {
    Text = "Evento aleatorio 1"
  },
  Event_116431_ChoiceDesc1 = {Text = "[Salir]"},
  Event_116431_Desc = {
    Text = "Has activado un evento aleatorio 2."
  },
  Event_116431_Name = {
    Text = "Evento aleatorio 2"
  },
  Event_117279_ChoiceDesc1 = {
    Text = "[Has deseado la ingenuidad]Pon 3 cartas de \"(Skill.Arg1)\"en el mazo."
  },
  Event_117279_Desc = {
    Text = "\nUna delgada niebla blanca se eleva sobre el nivel del mar, envolviendo todo en una bruma difusa. \nCruzando la frontera entre la vida y la muerte, cruzando la distancia dentro y fuera de la puerta, cruzando los recuerdos desvanecidos de tanto tiempo, ves la figura de una dama sosteniendo una sombrilla, iluminada por detrás. \nEl tiempo que pasaste con ella ya ha pasado, al igual que su juventud, delgada pero vibrante en colores brillantes. \nEsperando que el falso sol se levante, la niebla se rompe en lo intangible, y su silueta también se tambalea en el sueño, convirtiéndose en burbujas de ilusión que flotan, despidiéndose en silencio de ti."
  },
  Event_117279_Name = {
    Text = "El Fantasma de Murphy"
  },
  Event_117280_ChoiceDesc1 = {
    Text = "[Tu alguna vez anhelaste la inocencia] Elige 2 cartas para otorgar la inscripción \"Eco de las Profundidades\"."
  },
  Event_117280_Desc = {
    Text = "\nUna niebla blanca y tenue se eleva sobre el nivel del mar, envolviendo todo en una bruma borrosa. \nCruzando la frontera entre la vida y la muerte, cruzando la distancia entre dentro y fuera de la puerta, cruzando los recuerdos desvanecidos por el tiempo, ves la figura de una dama sosteniendo una sombrilla, iluminada por el contraluz. \nEl tiempo que pasaste con ella ya ha pasado, como su juventud delgada pero vibrante. \nEsperando que el falso sol se eleve, la niebla se quiebra en lo inmaterial, y su silueta también se tambalea en el sueño, convirtiéndose en burbujas etéreas que te despiden en silencio."
  },
  Event_117280_Name = {
    Text = "El Fantasma de Murphy"
  },
  Event_118414_ChoiceDesc1 = {
    Text = "[Tres puntos]"
  },
  Event_118414_ChoiceDesc2 = {
    Text = "[Seis en punto]"
  },
  Event_118414_ChoiceDesc3 = {Text = "[Un punto]"},
  Event_118414_Desc = {
    Text = "Los dados ruedan, emitiendo un sonido burbujeante.\n¿Cuando se detendrá?\nNo lo sabes, pero debes dar una respuesta."
  },
  Event_118414_Name = {
    Text = "Apuesta del destino"
  },
  Event_118415_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118415_Desc = {
    Text = "Tu respuesta hace que el \"Cielo\" sea aún más suave.\nÉl coloca suavemente un beso en tu frente.\nLuego, una ola de flores florece en tu frente."
  },
  Event_118415_Name = {
    Text = "Abrazo del mar"
  },
  Event_118416_ChoiceDesc1 = {
    Text = "[Perderse en la fantasía] Elige 1 Tarjeta de comando entre 3 para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_118416_ChoiceDesc2 = {
    Text = "[Mantener la cordura] Por cada Cuerpo Despertado con un nivel de Aliemus de 50 o más, obtiene 15 marcas negras"
  },
  Event_118416_ChoiceDesc3 = {
    Text = "[Salir por la fuerza] Obtiene elección de 3 para 1 oración"
  },
  Event_118416_Desc = {
    Text = "Quizás es la larga batalla que te ha hecho sentir desorientado, o quizás simplemente es que tu cerebro ha traicionado a tu cuerpo.\n Una sensación de ingravidez aparece en tu mente.\n En un instante, tu mente se transforma repentinamente en un caleidoscopio, brillantemente colorido, parpadeando con todos los matices de luz.\n Incontables ideas, reflexiones y fantasías inundan tu cerebro, ocupando cada rincón de las grietas de tu mente.\n Si esto continúa, tu cerebro pronto estallará debido a estos pensamientos caóticos."
  },
  Event_118416_Name = {
    Text = "Caleidoscopio de pensamiento"
  },
  Event_118417_ChoiceDesc1 = {
    Text = "[Unirse al juego] Infectar con [(Skill.Arg1)], entrar en el juego"
  },
  Event_118417_ChoiceDesc2 = {
    Text = "[mejor dejarlo]obtén 25 el sigilo negro"
  },
  Event_118417_Desc = {
    Text = "En un estado de aturdimiento, tu conciencia vagó a través de capas de niebla, dispersándose en el espacio desconocido.\nDos dados fueron lanzados frente a ti, pero la existencia desconocida que te trajo aquí a la fuerza permanecía invisible.\nSolo podías escuchar las voces caóticas desde todas las direcciones.\n\"¿Quieres volver? Entonces juguemos una ronda.\"\n\"Con tu vida como apuesta, que comience el juego del destino.\""
  },
  Event_118417_Name = {
    Text = "Apuesta del destino"
  },
  Event_118418_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118418_Desc = {
    Text = "Las experiencias trascendentes son siempre breves. Llegan en silencio y desaparecen de repente.  \nPero al menos tu cabeza sigue aquí, no ha explotado realmente."
  },
  Event_118418_Name = {
    Text = "Caleidoscopio de pensamiento"
  },
  Event_118419_ChoiceDesc1 = {
    Text = "[Salir]obtiene reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_118419_Desc = {
    Text = "No perdiste, pero tampoco ganaste; el resultado no es ni bueno ni malo.  \n\"Es un empate...\"  \nLa existencia desconocida suspiró, pero no había rastro de arrepentimiento en su voz.  \n\"Qué agradable pasatiempo.\""
  },
  Event_118419_Name = {
    Text = "Apuesta del destino"
  },
  Event_118420_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118420_Desc = {
    Text = "Poco a poco, esa música frenética se vuelve armoniosa y sagrada en tus oídos. \n Finalmente comprendes por qué se le llama \"canto sagrado perfecto\". \n Porque de hecho es \"perfecto e impecable\"."
  },
  Event_118420_Name = {
    Text = "El himno \"perfecto\""
  },
  Event_118421_ChoiceDesc1 = {
    Text = "[Percibir el cerebro] Elija 1 carta de comando de entre 3 para obtener Oración: [(EnchantConfig.Arg1)]"
  },
  Event_118421_ChoiceDesc2 = {
    Text = "[percepción del alma] infección\"(Skill.Arg1)\",re-imprimir, hasta 2 veces"
  },
  Event_118421_Desc = {
    Text = "La primera prisión del ser humano es su propio cuerpo.\nEn esta prisión del cuerpo, el cerebro es la última y más importante cárcel.\n\"Querida, ¿crees que estar vivo y respirar significa que estás a salvo?\"\nCuando tu cerebro traiciona a tu alma, experimentarás el tormento más doloroso del mundo.\nY este tormento te acompañará toda tu vida."
  },
  Event_118421_Name = {
    Text = "Prisión cerebral"
  },
  Event_118422_ChoiceDesc1 = {
    Text = "[Toque Mariposa] Elimina 2 cartas"
  },
  Event_118422_ChoiceDesc2 = {
    Text = "[ahuyentar mariposas] obtener criatura maldita\"(RelicConfig.Arg1)\",infectar\"(Skill.Arg2)\""
  },
  Event_118422_ChoiceDesc3 = {
    Text = "[Salir]obtiene Arg1 sigilo negro"
  },
  Event_118422_Desc = {
    Text = "En el Aequor no hay mariposas. Son las niñas atrapadas en la habitación las que han imaginado estas vidas. \n Son tan hermosas, volando libremente en el aire. \n \"Si... si pudiera ser como ellas y volar lejos de aquí...\" \n Una mariposa emitió un sollozo, pero este sonido se perdió entre los innumerables aleteos, ahogado por el ruido de la máquina de escribir, apenas audible."
  },
  Event_118422_Name = {
    Text = "El alma vuela como una mariposa"
  },
  Event_118423_ChoiceDesc1 = {
    Text = "[Cortar la cuerda] Infectar \"(Skill.Arg1)\", obtener Criatura maldita \"(RelicConfig.Arg2)\""
  },
  Event_118423_ChoiceDesc2 = {
    Text = "[Desatarlo] Infectar dos veces \"(Skill.Arg1)\", obtener Creaciones de plata \"(RelicConfig.Arg2)\" y \"(RelicConfig.Arg3)\""
  },
  Event_118423_ChoiceDesc3 = {
    Text = "[Liberarlo para siempre] Obtener Creación de plata [(RelicConfig.Arg1)]"
  },
  Event_118423_Desc = {
    Text = "\"Algunos dicen que el deseo interminable es la fuerza motriz del progreso.\nPero cuando ese deseo se vuelve tan poderoso que ya no puede ser ignorado ni cortado... siento que se transforma desde dentro en una jaula.\"\nUna voz débil emergió de la oscuridad. No podías ver el rostro del hablante, solo un par de manos atadas.\n\"Estos deseos se alimentan de mi miedo, mi debilidad, mi esperanza, mi dolor... y al hacerlo, solo se hacen más fuertes.\"\nLa voz emitió una última y desesperada súplica.\n\"¡Estoy dispuesto a sacrificarlo todo! Alma bondadosa, por favor... sálvame. O concédeme la liberación.\""
  },
  Event_118423_Name = {
    Text = "Deseos vinculantes"
  },
  Event_118424_ChoiceDesc1 = {
    Text = "[Percibir el cerebro] Elija 1 carta de comando de entre 3 para obtener Oración: [(EnchantConfig.Arg1)]"
  },
  Event_118424_Desc = {
    Text = "Sientes que tu médula cerebral se contrae. \n\"¿Tiene algún significado especial esto?\"\n Te preguntas, mientras tu cerebro permanece en silencio. \n No siempre obtienes respuestas a tus propias preguntas."
  },
  Event_118424_Name = {
    Text = "Prisión cerebral"
  },
  Event_118425_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118425_Desc = {
    Text = "Nadas con todas tus fuerzas y finalmente saltas fuera de la superficie del agua. \n El aire impregnado de sal marina entra en tus pulmones, recordándote que no has escapado realmente del peligro. \n Pero sabes que el verdadero cielo está justo sobre tu cabeza. \n Como la verdad, nunca será oscurecida por suaves mentiras."
  },
  Event_118425_Name = {
    Text = "Abrazo del mar"
  },
  Event_118426_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118426_Desc = {
    Text = "En el momento en que tocas la cuerda del Deseo, un dolor agudo surge desde lo más profundo de tu Alma.\nTu miedo, debilidad, esperanza y dolor surgen desde dentro de ti, transformándose en una cuerda ensangrentada que ata tus manos.\nEn ese momento, oyes los maliciosos vítores de esa voz.\n\"Persona de buen corazón, serás recompensado... por supuesto, también hay una maldición.\""
  },
  Event_118426_Name = {
    Text = "Deseos vinculantes"
  },
  Event_118427_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118427_Desc = {
    Text = "Tu toque hace temblar a las mariposas. \n Desde su nacimiento, nunca habían sentido un trato tan suave. \n Las mariposas están controladas por emociones abrumadoras, incluso olvidaron cómo volar. \n Así, innumerables mariposas cayeron, revelando la máquina de escribir que había estado oculta tras innumerables alas. \n Esa pobre cosa que ya había perdido la vida, con su último aliento, escribió las palabras \"libertad\"."
  },
  Event_118427_Name = {
    Text = "El alma vuela como una mariposa"
  },
  Event_118428_ChoiceDesc1 = {
    Text = "[Prepararse para el combate] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_118428_ChoiceDesc2 = {
    Text = "[Intentar tomar un camino alternativo] gana 25 marcas negras"
  },
  Event_118428_Desc = {
    Text = "En las profundidades del Aequor, donde la luz de las estrellas cae, los Marchadores de Mares han estado en inactividad durante siglos. \n Las aguas infinitas han testificado su locura, han testificado su paciencia, y también han testificado su más profunda piedad hacia los dioses. \n Nadie puede detener la gran llegada de los dioses. \n Cualquier obstáculo se convertirá en cenizas bajo la ira de los Marchadores de Mares."
  },
  Event_118428_Name = {
    Text = "La Vigilia bajo las Estrellas"
  },
  Event_118429_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118429_Desc = {
    Text = "Instintivamente cubriste tus oídos.\nIncreíblemente, los sonidos desde lo profundo de tu alma desaparecieron.\nPor supuesto, solo fue temporal."
  },
  Event_118429_Name = {
    Text = "Melodía profanadora"
  },
  Event_118430_ChoiceDesc1 = {
    Text = "[Reviviendo el pasado] gana 3 elige 1 gravura avanzada"
  },
  Event_118430_ChoiceDesc2 = {
    Text = "[Mirar furtivamente el futuro]obtiene la creación de oro\"(RelicConfig.Arg1)\",infección\"(Skill.Arg2)\""
  },
  Event_118430_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_118430_Desc = {
    Text = "Nada en el mundo puede permanecer estático.\n Incluso el paraíso esculpido por la Diosa Madre no es una excepción.\n En un momento fugaz, vislumbras algo a través de las grietas del tiempo y del espacio.\n El pasado, el presente y el futuro se entrelazan en esa grieta agrietada, cambiando constantemente.\n Esperando tu curiosa mirada"
  },
  Event_118430_Name = {
    Text = "Fisura espacio-temporal"
  },
  Event_118431_ChoiceDesc1 = {
    Text = "[Gana 100 el sigilo negro]"
  },
  Event_118431_ChoiceDesc2 = {
    Text = "[2 Tarjetas de comando aleatorias obtienen Inscripción: \"(EnchantConfig.Arg1)\"]"
  },
  Event_118431_Desc = {
    Text = "La voluntad intangible no acepta tu elección. Está dispuesta a darte otra oportunidad para que cambies—\n Ten cuidado, incluso si la música es intangible, puede segar vidas."
  },
  Event_118431_Name = {
    Text = "El himno \"perfecto\""
  },
  Event_118432_ChoiceDesc1 = {
    Text = "[Alimentar a las ratas] Obtén Creación de plata [(RelicConfig.Arg1)], desarrolla 1 síntoma"
  },
  Event_118432_ChoiceDesc2 = {
    Text = "[Ahuyentar a las ratas] Graba Oración en 1 carta de entre 3:\"(EnchantConfig.Arg1)\", pero desarrolla \"(Skill.Arg2)\""
  },
  Event_118432_ChoiceDesc3 = {
    Text = "[Ignorar a las ratas] Gana 25 marcas negras"
  },
  Event_118432_Desc = {
    Text = "Todo en este barco está atrapado en el bucle temporal.\nIncluso esas asquerosas y peludas criaturas que luchan por sobrevivir aquí no pueden escapar de su destino.\nCiclo tras ciclo, devoran todo lo que ven, pero su hambre nunca se sacia.\n\"Tanta... hambre...\"\nHordas de ratas emiten chillidos enfermizos y penetrantes.\nLos ciclos interminables las han dejado hambrientas y enloquecidas—necesitan comer algo.\nAhora. Inmediatamente."
  },
  Event_118432_Name = {
    Text = "Grupo de ratas hambrientas"
  },
  Event_118433_ChoiceDesc1 = {
    Text = "[Evitar su Mirada] Obtiene Creación de oro \"(RelicConfig.Arg1)\", pero infecta \"(Skill.Arg2)\""
  },
  Event_118433_ChoiceDesc2 = {
    Text = "[Mirar fijamente a los Ojos] Despertar aleatoriamente a 2 entidades, pero infectar dos veces [(Skill.Arg1)]"
  },
  Event_118433_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_118433_Desc = {
    Text = "Así como las estrellas en el cielo, ciertamente hay muchos ojos en el fondo del mar.\nEsos ojos pertenecen a los peces que viven en el fondo del océano, a las especies branquiales profanadas, y al océano mismo.\nShh, no los molestes.\nNo, no perturbe la locura del fondo del mar."
  },
  Event_118433_Name = {
    Text = "Ojo de la profundidad del mar"
  },
  Event_118434_ChoiceDesc1 = {
    Text = "[Ignorar los Susurros]"
  },
  Event_118434_ChoiceDesc2 = {
    Text = "[Escuchar los Susurros]"
  },
  Event_118434_ChoiceDesc3 = {
    Text = "[Inventar algo]"
  },
  Event_118434_Desc = {
    Text = "\"¿Deseas el favor de Dios? ¿Quieres conocer tu propia importancia?\"\nUn suspiro sonó en tu oído, como el susurro de una persona mentalmente perturbada, o el murmullo íntimo de algo sin forma.\nBajo la razón y la vigilancia, rechazas esa voz, pero ella sigue hablando consigo misma.\n\"Por favor, escucha con paciencia. Lo que conocerás es la verdad sobre el destino del mundo...\""
  },
  Event_118434_Name = {
    Text = "Predicación de lo intangible"
  },
  Event_118435_ChoiceDesc1 = {
    Text = "[Percibir el cerebro] Elija 1 carta de comando de entre 3 para obtener Oración: [(EnchantConfig.Arg1)]"
  },
  Event_118435_ChoiceDesc2 = {
    Text = "[Percepción del alma] infecta\"(Skill.Arg1)\",reimprimir aleatoriamente de nuevo"
  },
  Event_118435_Desc = {
    Text = "El cerebro, protegido de manera segura dentro del cráneo, te ha transmitido cierta información. \nNo sabes si esta información ha sufrido desgaste en la conversión de neurotransmisores y la transmisión de corrientes bioeléctricas. \nEl único hecho que puedes confirmar es que has recibido esta información y, en la existencia objetiva del cuerpo, has percibido tu propia supervivencia."
  },
  Event_118435_Name = {
    Text = "Prisión cerebral"
  },
  Event_118436_ChoiceDesc1 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_118436_Desc = {
    Text = "\"Buena respuesta, pero desafortunadamente, no es la respuesta correcta.\"\n\"¿Cuál es la respuesta correcta?\"\nLa existencia desconocida no respondió a tu pregunta, solo soltó una risa desdeñosa.\n\"¿Quién te dijo que el destino tiene una respuesta correcta?\""
  },
  Event_118436_Name = {
    Text = "Apuesta del destino"
  },
  Event_118437_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118437_Desc = {
    Text = "\"¿Crees que no he intentado cortarlos? No—¡resistir el deseo solo lo hace más fuerte!\"\nMientras las cuerdas del deseo se tensan, cortando la carne, la voz libera un aullido desesperado.\n\"Nunca podré liberarme de ellos... ¡nunca!\""
  },
  Event_118437_Name = {
    Text = "Deseos vinculantes"
  },
  Event_118438_ChoiceDesc1 = {
    Text = "[Escuchar canto] obtiene 25 la marca negra, infección\"(Skill.Arg2)\", continúa eligiendo"
  },
  Event_118438_ChoiceDesc2 = {
    Text = "[Dejarlo estar]Salir"
  },
  Event_118438_Desc = {
    Text = "El cuervo negro está llorando.\nEl cuervo negro está gritando.\nEl cuervo negro está aullando.\nSin embargo, para las personas, solo suena como canto.\n\"Ah, qué canción tan despreocupada. Ojalá fuera un cuervo, lejos de los problemas del mundo.\""
  },
  Event_118438_Name = {
    Text = "Lamento no percibido"
  },
  Event_118439_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118439_Desc = {
    Text = "La mariposa se disipa, y finalmente puedes ver la máquina de escribir debajo. \n Esa pobre cosa que ha perdido la vida, con su último aliento, escribió las palabras \"Irse\"."
  },
  Event_118439_Name = {
    Text = "El alma vuela como una mariposa"
  },
  Event_118440_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118440_Desc = {
    Text = "En la sombra del pasado, una niña con abrigo esponjoso te saluda. \nNo puedes oír lo que dice, pero ves la sonrisa de la niña."
  },
  Event_118440_Name = {
    Text = "Fisura espacio-temporal"
  },
  Event_118441_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118441_Desc = {
    Text = "Aequor ha vuelto una vez más a la oscuridad y el silencio.\nEn esta oscuridad y silencio, escuchas de nuevo el latido.\nEse sonido proviene de tu interior.\nA los ojos de los demás, eres solo un corazón palpitante que flota en el Aequor oscuro."
  },
  Event_118441_Name = {
    Text = "Ley del más fuerte"
  },
  Event_118442_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118442_Desc = {
    Text = "Esta vez, el que se convirtió en cenizas no es el obstáculo, sino el Marchador de mares. \nLas estrellas observan en silencio esta escena, tal como lo han hecho durante cientos de años, manteniendo el silencio."
  },
  Event_118442_Name = {
    Text = "La Vigilia bajo las Estrellas"
  },
  Event_118443_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118443_Desc = {
    Text = "A pesar de tener la ventaja numérica, esas ratas sucias son más valientes que sus propios cuerpos.\nSe sienten intimidadas por tu fuerte actitud y se dispersan en pánico."
  },
  Event_118443_Name = {
    Text = "Grupo de ratas hambrientas"
  },
  Event_118444_ChoiceDesc1 = {
    Text = "[Extender la mano] Despertar aleatoriamente 1 Despertado, infectar\"(Skill.Arg1)\""
  },
  Event_118444_ChoiceDesc2 = {
    Text = "[Observar en silencio] obtiene 3 a elegir inscripción"
  },
  Event_118444_Desc = {
    Text = "Un corazón palpitante nada en la oscura profundidad del Aequor.\nQuizás pertenece a un pez que nada, o tal vez a algún ser con branquias de pez.\nNo puedes verlo claramente. Lo único que puedes distinguir es ese corazón que late sin parar, y detrás de ese corazón, una gran boca que se abre gradualmente.\nCazar, o ser cazado, es la ley de la naturaleza.\nYa sea en la tierra o en el océano."
  },
  Event_118444_Name = {
    Text = "Ley del más fuerte"
  },
  Event_118445_ChoiceDesc1 = {
    Text = "[Agitar la mano para ahuyentar] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_118445_ChoiceDesc2 = {
    Text = "[dejar que permanezca]obtén reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_118445_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_118445_Desc = {
    Text = "Un sonido tenue emerge de la oscuridad.\nEs una mariposa, que pregunta cortésmente:\n\"¿Puedo descansar en tu palma?\"\n\"Estoy tan cansada... Deseo descansar un momento.\"\nMientras pregunta, la mariposa desciende en espiral hacia ti a través de la oscuridad.\nUn líquido negro y viscoso gotea de sus alas—un regalo de las sombras que atravesó."
  },
  Event_118445_Name = {
    Text = "Solicitud de la mariposa"
  },
  Event_118446_ChoiceDesc1 = {
    Text = "[Salir]obtiene reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_118446_Desc = {
    Text = "Tras un momento de silencio, algo fue arrojado a tus brazos.\n\"Tómalo y vete.\"\n\"El Destino siempre es generoso con los afortunados.\""
  },
  Event_118446_Name = {
    Text = "Apuesta del destino"
  },
  Event_118447_ChoiceDesc1 = {
    Text = "[Seguir la guía] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_118447_ChoiceDesc2 = {
    Text = "[Ignorar la guía] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_118447_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_118447_Desc = {
    Text = "El festival ha comenzado.\nBajo las llamas del Espíritu y las bendiciones de la sangre, innumerables Almas creyentes se han convertido en faros—\nLos espíritus etéreos se dispersan a tu alrededor como hadas guía, brillando y esperando tu elección."
  },
  Event_118447_Name = {
    Text = "Faro del alma"
  },
  Event_118448_ChoiceDesc1 = {
    Text = "[Salir]infecta\"(Skill.Arg1)\"，obtiene 50 sigilos negros"
  },
  Event_118448_Desc = {
    Text = "\"¡Humanos ignorantes!\"\nEsa voz emitió una queja frustrada, pero sin llegar a la ira.\nPorque sabe que los ignorantes siempre tendrán momentos de iluminación.\nSolo necesita esperar a que llegue ese día.\nY antes de que ese día llegue, te marcará con el sello de Dios, confirmando la pertenencia de tu Alma."
  },
  Event_118448_Name = {
    Text = "Predicación de lo intangible"
  },
  Event_118449_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118449_Desc = {
    Text = "[@2 de @3......]\nUna avalancha de conocimiento, acompañada de esa melodía blasfema, irrumpe en tu cerebro.\nPero tu forma mortal te limita, haciendo que la sabiduría cósmica esté fuera de tu alcance.\nQué pesar tan doloroso."
  },
  Event_118449_Name = {
    Text = "Melodía profanadora"
  },
  Event_118450_ChoiceDesc1 = {
    Text = "[Salir]infecta\"(Skill.Arg1)\"，obtiene 50 sigilos negros"
  },
  Event_118450_Desc = {
    Text = "\"En realidad, yo también tengo una verdad sobre el mundo que quiero contarte...\"\n\"El mundo fue creado por un dios de pasta voladora compuesto por dos sabios ojos de albóndiga y pasta que simboliza la capacidad infinita...\"\nCon seriedad inventas una historia graciosa que escuchaste, esperando la reacción del otro.\nPero tras un largo rato, el otro lado permanece en silencio.\n\"Ay, parece que los creyentes fervientes no entienden el humor.\"\nSuspirando, solo puedes marcharte."
  },
  Event_118450_Name = {
    Text = "Predicación de lo intangible"
  },
  Event_118451_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118451_Desc = {
    Text = "Tu afinación no logró armonizar estas sílabas desordenadas.\nPero al menos, la voluntad intangible vio tu intento.\nEs un buen comienzo."
  },
  Event_118451_Name = {
    Text = "El himno \"perfecto\""
  },
  Event_118452_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118452_Desc = {
    Text = "Tres figuras temblaron, llorando en silencio.\nSu fe fue dudada por ti, y esa fue la mayor ofensa que un fanático no podía tolerar."
  },
  Event_118452_Name = {
    Text = "El mejor sacrificio"
  },
  Event_118453_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118453_Desc = {
    Text = "En la imagen del futuro, la chica con tentáculos te miró con desdén y te reprendió.\n\"La verdadera forma de la Madre divina no puede ser profanada.\"\nLuego, la imagen desapareció, y la fisura espacio-temporal se cerró al instante, dejándote recordar la escena de hace un momento."
  },
  Event_118453_Name = {
    Text = "Fisura espacio-temporal"
  },
  Event_118454_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118454_Desc = {
    Text = "Te has librado con éxito del Marchador de mares y continúas avanzando. \nSobre tu cabeza, las Estrellas brillan silenciosamente, como lo han hecho durante cientos de años en el pasado."
  },
  Event_118454_Name = {
    Text = "La Vigilia bajo las Estrellas"
  },
  Event_118455_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118455_Desc = {
    Text = "La existencia desconocida no te obstruyó.\n\"Un día, volverás de nuevo.\"\n\"Nadie puede rechazar el destino.\""
  },
  Event_118455_Name = {
    Text = "Apuesta del destino"
  },
  Event_118456_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118456_Desc = {
    Text = "Con un movimiento rápido y decisivo, esas manos cayeron débilmente.\nPero no perdiste el último suspiro de la otra persona.\nFinalmente se liberó de sus deseos infinitos."
  },
  Event_118456_Name = {
    Text = "Deseos vinculantes"
  },
  Event_118457_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118457_Desc = {
    Text = [[
No ser percibido es el destino inevitable del mundo.
Nadie puede empatizar completamente con otra vida.]]
  },
  Event_118457_Name = {
    Text = "Lamento no percibido"
  },
  Event_118458_ChoiceDesc1 = {
    Text = "[Escuchar] obtiene 35 la marca negra, infecta\"(Skill.Arg2)», continúa eligiendo"
  },
  Event_118458_ChoiceDesc2 = {
    Text = "[Dejarlo estar]Salir"
  },
  Event_118458_Desc = {
    Text = "El cuervo negro está llorando.\nEl cuervo negro está gritando.\nEl cuervo negro está aullando.\nSin embargo, para las personas, solo suena como canto.\n\"Ah, qué canción tan despreocupada. Ojalá fuera un cuervo, lejos de los problemas del mundo.\""
  },
  Event_118458_Name = {
    Text = "Lamento no percibido"
  },
  Event_118459_ChoiceDesc1 = {
    Text = "[Escuchar con atención]obtener reliquia de plata\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_118459_ChoiceDesc2 = {
    Text = "[Taparse los oídos] obtiene el sello de elegir 3"
  },
  Event_118459_Desc = {
    Text = "En la locura informe, parece que ves un piano.\nUn par de manos que desdibujan la forma danzaban sobre las teclas informe, tocando melodías profanas.\nLa extraña música resonaba desde las profundidades de tu Alma, viajando a través de las líneas de los vasos sanguíneos, llegando a tu tembloroso cerebro."
  },
  Event_118459_Name = {
    Text = "Melodía profanadora"
  },
  Event_118460_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118460_Desc = {
    Text = "Esas inspiraciones, pensamientos y fantasías se entrelazan, fusionándose en los colores más espléndidos del mundo.\nVes el espacio plegándose dentro de tu propio cuerpo, el tiempo girando a tu voluntad.\nEn este momento, percibes el tiempo y el espacio, omnipotente y omnisciente.\nPor supuesto, también has pagado un precio."
  },
  Event_118460_Name = {
    Text = "Caleidoscopio de pensamiento"
  },
  Event_118461_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118461_Desc = {
    Text = "El caótico Alma guía tu camino con gritos agudos.\n¿Es ese un camino seguro? No lo sabes.\nTu única opción es seguir avanzando."
  },
  Event_118461_Name = {
    Text = "Faro del alma"
  },
  Event_118462_ChoiceDesc1 = {
    Text = "[Escuchar canto] obtiene 40 la marca negra, infecta\"(Skill.Arg2)\",continúa eligiendo"
  },
  Event_118462_ChoiceDesc2 = {
    Text = "[No preocuparse]obtener 25 el sigilo negro y salir"
  },
  Event_118462_Desc = {
    Text = "El cuervo negro está llorando.\nEl cuervo negro está gritando.\nEl cuervo negro está aullando.\nSin embargo, para las personas, solo suena como canto.\n\"Ah, qué canción tan despreocupada. Ojalá fuera un cuervo, lejos de los problemas del mundo.\""
  },
  Event_118462_Name = {
    Text = "Lamento no percibido"
  },
  Event_118463_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118463_Desc = {
    Text = "El caótico Alma emite un lamento doloroso.\nDesaparece gradualmente, pero ese suspiro doloroso, si tuviera sustancia, cae sobre tu corazón.\nThump thump, tu latido resuena en sincronía con la melodía del ritual."
  },
  Event_118463_Name = {
    Text = "Faro del alma"
  },
  Event_118464_ChoiceDesc1 = {
    Text = "[Salir]obtiene reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_118464_Desc = {
    Text = "\"¡Ah, ah, qué cordero tan devoto!\"\nEsa voz suspira, llena de alabanza jubilosa.\n\"Cuando mi señor despierte, corderos como tú seguramente encontrarán un lugar donde residir en ese Exaltado y grandioso Reino Divino...\""
  },
  Event_118464_Name = {
    Text = "Predicación de lo intangible"
  },
  Event_118465_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118465_Desc = {
    Text = "\"El Cielo\" abraza tu rebeldía.\nUn día, el niño perdido regresará al abrazo de la madre.\nPorque no tienes adónde huir."
  },
  Event_118465_Name = {
    Text = "Abrazo del mar"
  },
  Event_118466_ChoiceDesc1 = {
    Text = "[Aceptar el abrazo] Obtén la Creación de plata \"(RelicConfig.Arg1)\", pero desarrolla \"(Skill.Arg2)\""
  },
  Event_118466_ChoiceDesc2 = {
    Text = "[Rechazar el abrazo] Obtén la Creación de plata \"(RelicConfig.Arg1)\", pero desarrolla \"(Skill.Arg2)\""
  },
  Event_118466_ChoiceDesc3 = {
    Text = "[Nadar a la superficie] Obtén 25 Marcas negras"
  },
  Event_118466_Desc = {
    Text = "El mundo se desborda de tus ojos.\n En este momento, el mar profundo que te rodea es el \"cielo\".\n En el dolor de casi ahogarte, este \"cielo\" azul profundo se acerca suavemente, con la intención de abrazarte.\n No juzgará, solo dará"
  },
  Event_118466_Name = {
    Text = "Abrazo del mar"
  },
  Event_118467_ChoiceDesc1 = {
    Text = "[Reprenderlos] Recibe Criatura maldita \"(RelicConfig.Arg1)\", pero infecta \"(Skill.Arg2)\""
  },
  Event_118467_ChoiceDesc2 = {
    Text = "[Responderles] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_118467_ChoiceDesc3 = {
    Text = "[Ignorar] Obtiene 50 Marcas negras"
  },
  Event_118467_Desc = {
    Text = "Tres almas de forma vagamente definida bloquearon tu camino.\nUna figura se inclinó solemnemente ante ti, suplicando que le concedieras sangre. Tu sangre fluyente es el mejor sacrificio para los dioses.\nUna figura levantó fríamente un cuchillo hacia ti, con la intención de desgarrar tu carne. Esa carne humana no mutada seguramente ganaría el favor de los dioses.\nLa última observó en silencio, esperando que te quitaras la vida para demostrar la fe más devota."
  },
  Event_118467_Name = {
    Text = "El mejor sacrificio"
  },
  Event_118468_ChoiceDesc1 = {
    Text = "[Escuchar canto] obtiene 30 la marca negra, infecta\"(Skill.Arg2)», continúa eligiendo"
  },
  Event_118468_ChoiceDesc2 = {
    Text = "[Dejarlo estar]Salir"
  },
  Event_118468_Desc = {
    Text = "El cuervo negro está llorando.\nEl cuervo negro está gritando.\nEl cuervo negro está aullando.\nSin embargo, para las personas, solo suena como canto.\n\"Ah, qué canción tan despreocupada. Ojalá fuera un cuervo, lejos de los problemas del mundo.\""
  },
  Event_118468_Name = {
    Text = "Lamento no percibido"
  },
  Event_118469_ChoiceDesc1 = {
    Text = "[Salir]infectar\"(Skill.Arg1)\""
  },
  Event_118469_ChoiceDesc2 = {
    Text = "[Salir]infectar\"(Skill.Arg1)\""
  },
  Event_118469_ChoiceDesc3 = {
    Text = "[Salir]infectar\"(Skill.Arg1)\""
  },
  Event_118469_Desc = {
    Text = "\"¡No! ¡Nos negamos! Ansiamos algo más... delicioso.\"\n\"¡Entonces será... tu sangre y tu carne!\"\nUn enjambre de ratas chilla, abalanzándose hacia ti.\nParece que un corazón bondadoso en exceso a veces puede traer más problemas que alivio."
  },
  Event_118469_Name = {
    Text = "Grupo de ratas hambrientas"
  },
  Event_118470_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118470_Desc = {
    Text = "Tu respeto gana el favor de esos ojos.\nAntes de que desaparezcan, te otorgan un regalo a través del mar agitado.\nEsa es la evidencia de que el Profundo Mar te está domesticando."
  },
  Event_118470_Name = {
    Text = "Ojo de la profundidad del mar"
  },
  Event_118471_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118471_Desc = {
    Text = "Bajo tu mirada desenfadada, el mar profundo se despierta lentamente.\nLas aguas del mar surgen caóticamente a tu alrededor, trayendo murmullos indescriptibles.\nSiente la ira del mar profundo, esto es tanto una bendición como una maldición."
  },
  Event_118471_Name = {
    Text = "Ojo de la profundidad del mar"
  },
  Event_118472_ChoiceDesc1 = {
    Text = "[Escuchar el canto] obtiene 20 marcas negras, infecta\"(Skill.Arg2)\""
  },
  Event_118472_ChoiceDesc2 = {
    Text = "[Dejarlo estar]Salir"
  },
  Event_118472_Desc = {
    Text = "El cuervo negro está llorando.\nEl cuervo negro está gritando.\nEl cuervo negro está aullando.\nSin embargo, para las personas, solo suena como canto.\n\"Ah, qué canción tan despreocupada. Ojalá fuera un cuervo, lejos de los problemas del mundo.\""
  },
  Event_118472_Name = {
    Text = "Lamento no percibido"
  },
  Event_118473_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118473_Desc = {
    Text = "Sangre, carne, vida.\nEl sacrificio está listo, ahora solo tienes que esperar pacíficamente el festín divino."
  },
  Event_118473_Name = {
    Text = "El mejor sacrificio"
  },
  Event_118474_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118474_Desc = {
    Text = "La mariposa entendió tu rechazo.\nSus alas, cubiertas de sustancia viscosa negra, vibraron nuevamente, revoloteando inestablemente en la oscuridad.\nPronto, la oscuridad devoró a la mariposa una vez más. Esta vez, ya no tenía fuerzas para luchar."
  },
  Event_118474_Name = {
    Text = "Solicitud de la mariposa"
  },
  Event_118475_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118475_Desc = {
    Text = "La mariposa cayó en tu palma, junto con un líquido negro y pegajoso que había en sus alas coloridas. \n En tu suspiro, las alas coloridas se desvanecen, fusionándose con el líquido negro en una forma caótica y desconocida. \n Esta mariposa ya no tiene que experimentar la oscuridad. \n Descansa en tu palma."
  },
  Event_118475_Name = {
    Text = "Solicitud de la mariposa"
  },
  Event_118477_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118477_Desc = {
    Text = "El cuervo ronco finalmente cerró los ojos.\nEn el rencor no reconocido y no percibido, exhaló su último aliento, convirtiéndose en un charco de lodo negro."
  },
  Event_118477_Name = {
    Text = "Lamento no percibido"
  },
  Event_118478_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118478_Desc = {
    Text = "\"Gracias...\"\nEl corazón palpitante salta hacia lo lejos. \nPronto, se escuchó el sonido de carne masticándose en el Aequor pitch-black."
  },
  Event_118478_Name = {
    Text = "Ley del más fuerte"
  },
  Event_118479_ChoiceDesc1 = {
    Text = "[Aceptar invitación] infectar\"(Skill.Arg1)\",obtener criatura maldita-\"(RelicConfig.Arg2)\""
  },
  Event_118479_ChoiceDesc2 = {
    Text = "[Rechazar Invitación] Elige destruir 1 Reliquia y obtener 1 recompensa"
  },
  Event_118479_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_118479_Desc = {
    Text = "\"Todo en este barco debe ser parte de este paraíso cíclico que se descompone y reinicia constantemente.\"\nLa música frenética resuena en tu mente, es la inspiración de una voluntad intangible. \n\"Aquí no hay llanto, ni tristeza, solo música sagrada y risas eternas.\"\n\"¿Estás dispuesto a unirte al paraíso y ser parte de esta perfecta melodía?\""
  },
  Event_118479_Name = {
    Text = "El himno \"perfecto\""
  },
  Event_118480_ChoiceDesc1 = {Text = "[Salir]"},
  Event_118480_Desc = {
    Text = [[
En tu silencio, las almas se disipan silenciosamente.
Aquellos que no comprenden a los creyentes no merecen su tiempo.]]
  },
  Event_118480_Name = {
    Text = "El mejor sacrificio"
  },
  Event_123616_ChoiceDesc1 = {
    Text = "[Recibir creación estándar]"
  },
  Event_123616_Desc = {
    Text = "Establece la alienación de todos los Despertados en 100, la llave de plata en 1000 y los PV en 80％.\nElimina 2 cartas y añade 3 cartas de síntomas.\nEstablece el Horno Carmesí en 12.5％, elige 4 cartas para entrar en el Espacio Hiperspacial.\nObtén el Paquete de Reliquias Estándar."
  },
  Event_123616_Name = {
    Text = "Saltar con un clic en el camino"
  },
  Event_125696_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125696_Desc = {
    Text = "Una rabia sin motivo te impulsa. Alzas la mano y golpeas para dispersarlos. Has permanecido demasiado tiempo entre enigmas; quizás anhelas una batalla implacable, o simplemente un final...\nPero los cuervos no hacen nada. Bajo tu mirada, el abismo se disuelve.\nEl enjambre desaparece hacia el final del escenario—el lugar al que debes ir."
  },
  Event_125696_Name = {
    Text = "Abyss de los Cuervos"
  },
  Event_125697_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125697_Desc = {
    Text = "\"Cobarde.\" No se molesta en ocultar la burla en su risa.\n\"Vete, entonces. Cuanto más lejos, mejor.\""
  },
  Event_125697_Name = {
    Text = "Cerradura del destino"
  },
  Event_125698_ChoiceDesc1 = {
    Text = "[Ahuyentar] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_125698_ChoiceDesc2 = {
    Text = "[Listen] Adquirir la Creación de plata \"(RelicConfig.Arg1)\", pero desarrollar \"(Skill.Arg2)\""
  },
  Event_125698_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_125698_Desc = {
    Text = "Un leve sonido se escuchó en la oscuridad. Una mariposa cayó en tu palma. La recuerdas. \n \"Señorita Arachne... nunca nos has abandonado, ¿verdad?\" \n El hermoso patrón de la mariposa, mirando a la persona a tu lado."
  },
  Event_125698_Name = {
    Text = "El resto de la mariposa"
  },
  Event_125699_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125699_Desc = {
    Text = "Los sonidos y los guiones se abren paso en tu mente como un enjambre. Contienes la respiración, purgando la estática inútil de tu conciencia.\nIgnorar es mucho más arduo que leer, y sin embargo, lo has logrado."
  },
  Event_125699_Name = {
    Text = "Telegrama dimensional"
  },
  Event_125700_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125700_Desc = {
    Text = "¡Es una ilusión conjurada por el enemigo!\nSacudes la cabeza, recuperas la claridad y aprietas con fuerza la Llave de plata."
  },
  Event_125700_Name = {
    Text = "Reflejo en el vino"
  },
  Event_125701_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125701_Desc = {
    Text = "Fijas la mirada en ese ojo, esforzándote por observar, por escuchar. Intentas adentrarte en el corazón del actor y sentir la agonía que soporta.\nTe acercas, cada vez más. Atraviesas su figura y tocas su propia alma...\nAbres los ojos de golpe y te encuentras de pie en el centro del escenario, con lágrimas resbalando por las yemas de tus dedos.\nEsa es la confesión que ofreces al público."
  },
  Event_125701_Name = {
    Text = "Confesión del actor"
  },
  Event_125702_ChoiceDesc1 = {
    Text = "[Discutir con Ella] Destruir una Tarjeta de comando y recibir Arg1 Marcas negras"
  },
  Event_125702_ChoiceDesc2 = {
    Text = "[Permanecer en silencio]"
  },
  Event_125702_Desc = {
    Text = "\"Un final feliz está bien, pero esa alegría hueca nunca podrá tocar los corazones del público...\"\nLa dramaturga cierra los ojos en contemplación. Está insatisfecha con esta conclusión."
  },
  Event_125702_Name = {
    Text = "El Final de la Obra"
  },
  Event_125703_ChoiceDesc1 = {
    Text = "[Escuchar] obtiene 35 la marca negra, infecta\"(Skill.Arg2)», continúa eligiendo"
  },
  Event_125703_ChoiceDesc2 = {
    Text = "[Dejarlo estar]Salir"
  },
  Event_125703_Desc = {
    Text = "\"Crujido—crujido—la Diosa del Destino gira su rueca.\nCrujido—crujido—los Hilos del destino convergen en sus manos.\""
  },
  Event_125703_Name = {
    Text = "La Profecía Final"
  },
  Event_125704_ChoiceDesc1 = {
    Text = "[Yourself] Duplica 1 de 3 tarjetas de comando aleatorias del mazo"
  },
  Event_125704_ChoiceDesc2 = {
    Text = "[William] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_125704_ChoiceDesc3 = {
    Text = "[Nadie] Obtiene 25 marcas negras"
  },
  Event_125704_Desc = {
    Text = "Estás seguro de no estar ebrio, pero al mirar el alcohol, te encuentras hundiéndote en un tranquilo lago.\nUna figura elegante aparece en el vaso. ¿Quién es?"
  },
  Event_125704_Name = {
    Text = "Reflejo en el vino"
  },
  Event_125705_ChoiceDesc1 = {
    Text = "[Listen] Obtiene la Creación de plata [(RelicConfig.Arg1)]"
  },
  Event_125705_ChoiceDesc2 = {
    Text = "[Dispel] Obtiene 75 marcas negras, pero desarrolla el síntoma [(Skill.Arg2)]"
  },
  Event_125705_Desc = {
    Text = "Al acercarte al poder del plásmido interior, una bandada de cuervos aparece en tu mente, circulando por tu turbulento reino espiritual.\n\nLos cuervos giran en espiral a tu alrededor, como un vórtice del abismo suspendido invertido sobre ti.\nCien mil cuervos gritan al unísono, como una profecía burlona."
  },
  Event_125705_Name = {
    Text = "Abyss de los Cuervos"
  },
  Event_125706_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125706_Desc = {
    Text = "Intentas estabilizar el destino destruido a tu lado junto a Arachne. Tus esfuerzos son en su mayoría infructuosos, pero eso ya es suficiente. Aprovechando el tiempo que han ganado, continúan acercándose a Nefruri. \n Has venido aquí para traerle la liberación."
  },
  Event_125706_Name = {
    Text = "Red del destino: El desenlace"
  },
  Event_125707_ChoiceDesc1 = {
    Text = "[Escuchar el canto] obtiene 20 marcas negras, infecta\"(Skill.Arg2)\""
  },
  Event_125707_ChoiceDesc2 = {
    Text = "[Dejarlo estar]Salir"
  },
  Event_125707_Desc = {
    Text = "\"Mueren con la gran red, en silencio.\""
  },
  Event_125707_Name = {
    Text = "La Profecía Final"
  },
  Event_125708_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125708_Desc = {
    Text = "Es un telegrama dirigido al Abismo espiral.\n\"No os preocupéis, hijos míos. Las puertas de la prisión pronto se abrirán de par en par; vuestra liberación está cerca.\""
  },
  Event_125708_Name = {
    Text = "Telegrama dimensional"
  },
  Event_125709_ChoiceDesc1 = {
    Text = "[Ahuyentar] 1 Tarjeta de comando aleatoria obtiene Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_125709_ChoiceDesc2 = {
    Text = "[Listen] Grabar la Oración[(EnchantConfig.Arg1)] en 1 de 3 Tarjetas de comando"
  },
  Event_125709_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_125709_Desc = {
    Text = "Una mariposa se posa suavemente sobre tu palma. Sus exquisitos patrones se asemejan a ojos que no parpadean, mirándote en silencio.\n¿Acaso intenta decirte algo?"
  },
  Event_125709_Name = {
    Text = "Siesta de la mariposa"
  },
  Event_125710_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125710_Desc = {
    Text = "Veinte pares de ojos afligidos se fijan en ti. El cuervo cesa su canto, abandonando esta red desmoronada con su profecía final."
  },
  Event_125710_Name = {
    Text = "La Profecía Final"
  },
  Event_125711_ChoiceDesc1 = {
    Text = "[inclinarse hacia delante]Infección\"(Skill.Arg1)\"，obtén una reliquia de oro\"(RelicConfig.Arg2)\""
  },
  Event_125711_ChoiceDesc2 = {
    Text = "[Dejar de observar]obtener 50 el sigilo negro"
  },
  Event_125711_Desc = {
    Text = "Al pasar por la esquina de la calle, divisas una modesta sala de proyección. No recuerdas que tal lugar existiera en Londinium."
  },
  Event_125711_Name = {
    Text = "Sala de Recuerdos"
  },
  Event_125712_ChoiceDesc1 = {
    Text = "[Aceptar el Destino] Graba la Oración [(EnchantConfig.Arg1)] en 1 de 3 Tarjetas de comando.(Usos: 0/2)"
  },
  Event_125712_ChoiceDesc2 = {
    Text = "[Desafiar el Destino] Desarrolla el síntoma [(Skill.Arg1)] y cambia la oración a grabar.(Usos: 2/2)"
  },
  Event_125712_Desc = {
    Text = "\"Ah, volvemos a encontrarnos, querida.\"\nComienzas a disfrutar de la voz de esa dama resonando en tu mente. Es tierna y seductora, como una red para atrapar moscas.\n\"Vamos, dime—¿estás dispuesta a abrazar tu destino?\""
  },
  Event_125712_Name = {
    Text = "La Jaula del Destino"
  },
  Event_125713_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125713_Desc = {
    Text = "\"Humano insignificante, ¿nos conocemos?\"\nEl gato negro te mira con desdén y se da la vuelta.\n\"Lárgate. Y no vuelvas a hacer algo tan estúpido.\""
  },
  Event_125713_Name = {
    Text = "Transformación"
  },
  Event_125714_ChoiceDesc1 = {
    Text = "[Tomar foto] Grabar la Oración [(EnchantConfig.Arg1)] en 1 de 3 Tarjetas de comando.(Usos: 0/2)"
  },
  Event_125714_ChoiceDesc2 = {
    Text = "[Cambiar pose] Desarrolla el síntoma [(Skill.Arg1)] y cambia la Oración a grabar.(Usos: 2/2)"
  },
  Event_125714_Desc = {
    Text = "Una solitaria cámara se alza sobre el escenario, su lente de un negro absoluto fija en ti como el críptico ojo compuesto forjado por una deidad mecánica.\n¡Este teatro ha estado vacío durante tanto tiempo... Bienvenido! ¡Bienvenido! ¡Ven, hazte una foto! ¡Es completamente gratis!\nLa cámara chilla de emoción. En este escenario abandonado, ella es la única protagonista."
  },
  Event_125714_Name = {
    Text = "Recuerdos del público"
  },
  Event_125715_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125715_Desc = {
    Text = "\"¿Cómo puede quien nada pide al destino esperar una respuesta del destino?\""
  },
  Event_125715_Name = {
    Text = "Cerradura del destino"
  },
  Event_125716_ChoiceDesc1 = {
    Text = "[Buscar una salida] Adquirir la Creación de plata \"(RelicConfig.Arg1)\", pero desarrollar \"(Skill.Arg2)\""
  },
  Event_125716_ChoiceDesc2 = {
    Text = "[Dejarlo estar] Adquirir la Creación de oro \"(RelicConfig.Arg1)\", pero desarrollar \"(Skill.Arg2)\" y \"(Skill.Arg3)\""
  },
  Event_125716_ChoiceDesc3 = {
    Text = "[Surgir a la superficie]gana 25 el sigilo negro"
  },
  Event_125716_Desc = {
    Text = "Un nuevo escenario, dos vidas entrelazadas... En el camino para evadir a la policía, organizas estas cosas que Arachne te contó. \n En medio de pensamientos complicados, caes en la tranquila Aequor."
  },
  Event_125716_Name = {
    Text = "Tranquilidad"
  },
  Event_125717_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125717_Desc = {
    Text = "La mariposa se posa en tu hombro, acercándose a tu oído. Escuchas con atención, pero solo percibes el leve zumbido de sus alas, un sonido como un suspiro sin voz.\nMientras escuchas, las iridiscentes alas comienzan a disolverse, y la mariposa cae en un sueño eterno sobre tu hombro.\nEl mensaje que portaba se pierde para ti para siempre."
  },
  Event_125717_Name = {
    Text = "El resto de la mariposa"
  },
  Event_125718_ChoiceDesc1 = {
    Text = "[Morder] Despertar aleatoriamente 1 Cuerpo Despertado, infectar[(Skill.Arg1)]"
  },
  Event_125718_ChoiceDesc2 = {
    Text = "[Rechazar]obtienes sello de 3 opciones"
  },
  Event_125718_Desc = {
    Text = "\"¿Hambriento, mi querido invitado?\"\nUna voz viscosa surge desde detrás de la barra. Te giras, pero no ves nada.\n\"Los aperitivos del Baile de Medianoche también son bastante renombrados. ¿Te apetece probarlos?\""
  },
  Event_125718_Name = {
    Text = "El Sabor del Destino"
  },
  Event_125719_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125719_Desc = {
    Text = "No te atreves a leer los textos de arriba, solo observas detenidamente el elegante sobre. \n En el sobre, la cera lacrada lleva un emblema familiar borroso, donde está escrito en una hermosa caligrafía: \n \"A la señorita Arachne, nueva nacida.\" \n \"Su leal mayordomo, Edgar.\""
  },
  Event_125719_Name = {
    Text = "Buenas noches, señor Edgar"
  },
  Event_125720_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125720_Desc = {
    Text = "\"Ya veo. Ahora lo entiendo, hermanita...\"\n\"Una dramaturga nunca puede reescribir el final de un personaje. Ese destino miserable fue sellado hace mucho tiempo; ni siquiera tú podrías cambiarlo...\"\nEl llanto desconsolado se desvanece. La máquina de escribir de la dramaturga se disuelve en mariposas, dispersándose por el vacío Teatro del destino hasta no dejar rastro alguno."
  },
  Event_125720_Name = {
    Text = "El Final de la Obra"
  },
  Event_125721_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125721_Desc = {
    Text = "Actores desconocidos, pasos peligrosos... ¿qué importa? Nada puede ser peor que el destino mismo.\nExtiendes la mano y subes al escenario. Los títeres toman tu mano, haciéndote girar en un alegre baile.\nEscuchas los aplausos."
  },
  Event_125721_Name = {
    Text = "Danza de tres"
  },
  Event_125722_ChoiceDesc1 = {
    Text = "[Escuchar canto] obtiene 25 la marca negra, infección\"(Skill.Arg2)\", continúa eligiendo"
  },
  Event_125722_ChoiceDesc2 = {
    Text = "[Dejarlo estar]Salir"
  },
  Event_125722_Desc = {
    Text = "\"Bailan. Cantan. Crujido—crujido—\""
  },
  Event_125722_Name = {
    Text = "La Profecía Final"
  },
  Event_125723_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125723_Desc = {
    Text = "El guía, el camarada: el único compañero en esta solitaria dimensión.\nResolverás todo aquí juntos y regresarás a Kadas. Nunca has dudado de esto."
  },
  Event_125723_Name = {
    Text = "Reflejo en el vino"
  },
  Event_125724_ChoiceDesc1 = {
    Text = "[Apostar]Infectar con \"(Skill.Arg1)\", entrar en el juego"
  },
  Event_125724_ChoiceDesc2 = {
    Text = "[mejor dejarlo]obtén 25 el sigilo negro"
  },
  Event_125724_Desc = {
    Text = "En la esquina de un callejón, un par de manos sucias te cierra el paso.\nUn mendigo harapiento se acerca, con ojos tan glotones como los de una hiena olfateando carroña.\n\"¡Vamos! ¡Una ronda! Te diré todo lo que deseas saber... si es que ganas...\""
  },
  Event_125724_Name = {
    Text = "Apuesta callejera"
  },
  Event_125725_ChoiceDesc1 = {
    Text = "[Ignore] Destruir una Tarjeta de comando, y obtener 25 Marcas negras"
  },
  Event_125725_ChoiceDesc2 = {
    Text = "[Read] Duplica 1 Carta del mazo, pero infecta con el síntoma[(Skill.Arg1)]"
  },
  Event_125725_Desc = {
    Text = "Tap, tap, tap... Tap, tap, tap...\nEl rincón del bar está desierto; el fax suena con una cadencia nítida y rítmica, como una elegante sonata de piano."
  },
  Event_125725_Name = {
    Text = "Telegrama dimensional"
  },
  Event_125726_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125726_Desc = {
    Text = "\"Silencio. Soy un gato. No me interesan tus tediosas historias.\"\n\nEl gato suspira y se da la vuelta.\n\n\"Lárgate. Y no vuelvas a hacer algo tan estúpido.\""
  },
  Event_125726_Name = {
    Text = "Transformación"
  },
  Event_125727_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125727_Desc = {
    Text = "Quizás ella tiene razón. Eso eres tú—los pensamientos más oscuros y viles en lo profundo de tu alma.\nTodo hombre es egoísta; nunca fuiste tan noble como los demás creían.\nSabores ese miserable dolor. Sabes que el pasado se ha ido, y tu salvación aguarda adelante."
  },
  Event_125727_Name = {
    Text = "Propagación de agonía"
  },
  Event_125728_ChoiceDesc1 = {
    Text = "[Discutir con Ella] Destruir una Tarjeta de comando y recibir Arg1 Marcas negras"
  },
  Event_125728_ChoiceDesc2 = {
    Text = "[Permanecer en silencio]"
  },
  Event_125728_Desc = {
    Text = "\"Un final trágico es veraz, pero nuestra realidad ya es tan miserable. ¿No podemos concederle un destino más gentil aunque sea dentro de una historia...?\"\nLa dramaturga cierra los ojos en contemplación. Está insatisfecha con esta conclusión."
  },
  Event_125728_Name = {
    Text = "El Final de la Obra"
  },
  Event_125729_ChoiceDesc1 = {
    Text = "[Salir]obtiene reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_125729_Desc = {
    Text = "Traqueteo. Los dados bailan frenéticamente en la copa, girando hasta quedar exhaustos.\n\n\"¿Por qué... por qué nadie gana jamás?!\""
  },
  Event_125729_Name = {
    Text = "Apuesta callejera"
  },
  Event_125730_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125730_Desc = {
    Text = "Te inclinas más, esforzándote por escuchar su susurro.\nLa mariposa agita sus alas y se aleja de tu palma.\nNo escuchas absolutamente nada."
  },
  Event_125730_Name = {
    Text = "Siesta de la mariposa"
  },
  Event_125731_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125731_Desc = {
    Text = "La mariposa no se inmuta ante tus gestos.\nSigue persiguiendo tu palma con una quieta persistencia, y solo cuando alzas el brazo por última vez decide marcharse.\nUn destello de arrepentimiento te invade. Quizás... ¿deberías haberla escuchado?"
  },
  Event_125731_Name = {
    Text = "Siesta de la mariposa"
  },
  Event_125732_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125732_Desc = {
    Text = "La niebla negra tiembla con desolación; los angustiados lamentos del mendigo son desgarradores.\nEn un abrir y cerrar de ojos, los dados y el mendigo desaparecen. Dentro del sombrero harapiento, permanece la recompensa del juego."
  },
  Event_125732_Name = {
    Text = "Apuesta callejera"
  },
  Event_125733_ChoiceDesc1 = {
    Text = "[Unirse al festín] Obtener la Criatura maldita \"(RelicConfig.Arg2)\", pero infectar \"(Skill.Arg1)\""
  },
  Event_125733_ChoiceDesc2 = {
    Text = "[Detener la música] Destruir 1 Reliquia y obtener 1 recompensa"
  },
  Event_125733_ChoiceDesc3 = {
    Text = "[Taparse los oídos] Recibir 50 Marcas Negras"
  },
  Event_125733_Desc = {
    Text = "\"¡Ah! ¡Música! ¡Cómo puede existir una gran actuación sin música!!\"\nUna sinfonía discordante surge en el teatro destrozado, como una orgía de caos. Los actores del Abismo espiral bailan y celebran en esta oda desordenada, deleitándose en las notas que los sustentan."
  },
  Event_125733_Name = {
    Text = "Canto del destino"
  },
  Event_125734_ChoiceDesc1 = {
    Text = "[Gana 100 el sigilo negro]"
  },
  Event_125734_ChoiceDesc2 = {
    Text = "[2 Tarjetas de comando aleatorias obtienen Inscripción: \"(EnchantConfig.Arg1)\"]"
  },
  Event_125734_Desc = {
    Text = "Hilos invisibles del destino danzan entre las notas. En ese ruido caótico, comienzas a rastrear el hilo de la melodía cautivadora—en efecto, ese es el verdadero sonido del destino.\nLos abandonados del Abismo espiral te vitorean, agolpándose a tu alrededor, arrastrándote hacia su desordenada celebración.\n¡Felicidades, afortunado espectador! Ahora, te unirás a los actores en el llamado final del telón del destino."
  },
  Event_125734_Name = {
    Text = "Canto del destino"
  },
  Event_125735_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125735_Desc = {
    Text = "No puedes discernir el significado de este sonido, pero sabes que debe detenerse.\nLa luz plateada corta como una hoja enloquecida. Su ritmo, de algún modo, encaja perfectamente con las notas.\nAntes de que te des cuenta, la música ha cesado. No escuchas nada más. Solo ves la noche; solo escuchas el silencio.\nCacofonía desordenada o silencio absoluto—¿cuál es más aterrador... Guardián?"
  },
  Event_125735_Name = {
    Text = "Canto del destino"
  },
  Event_125736_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125736_Desc = {
    Text = "Extiendes la mano; una mariposa se posa suavemente sobre ella.\nEn efecto. La muerte, la disolución, el paso del tiempo... La mariposa nace del capullo; la agonía es el suelo eterno del arte.\nComo excelente espectador, esta es una verdad que debes llegar a comprender."
  },
  Event_125736_Name = {
    Text = "Florecer en la desaparición"
  },
  Event_125737_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125737_Desc = {
    Text = "Quizás esto sea otro truco de Nefruri.\nLa mariposa entendió tus palabras, y en la oscuridad se escuchó su suspiro silencioso. Las alas que goteaban una oscura sustancia viscosa temblaron, y pronto, la pesada figura de la mariposa se hundió en la inmensa oscuridad.\nYa no podrás saber las palabras que quería decirte."
  },
  Event_125737_Name = {
    Text = "El resto de la mariposa"
  },
  Event_125738_ChoiceDesc1 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_125738_Desc = {
    Text = "Traqueteo. Los dados bailan frenéticamente en la copa, girando hasta quedar exhaustos.\n\n\"¿Por qué... por qué nadie gana jamás?!\""
  },
  Event_125738_Name = {
    Text = "Apuesta callejera"
  },
  Event_125739_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125739_Desc = {
    Text = "Dejar que tus pensamientos divaguen sin control ahora es peligroso. Sacudes la cabeza y sales a la superficie de inmediato."
  },
  Event_125739_Name = {
    Text = "Tranquilidad"
  },
  Event_125740_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125740_Desc = {
    Text = "No toda nota requiere un oyente; no todo destino requiere una respuesta.\nAprietas las manos fuertemente sobre tus oídos y abandonas el ruidoso escenario.\nSigues sintiendo curiosidad por el significado de esa música discordante, pero sabes que has tomado la única decisión correcta."
  },
  Event_125740_Name = {
    Text = "Canto del destino"
  },
  Event_125741_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125741_Desc = {
    Text = "La luz plateada atraviesa la ilusión; los gatos negros se disuelven en charcos de lodo negro.\nTransformarse en forma felina para ocultarse... el monstruo no puede escapar de tus ojos."
  },
  Event_125741_Name = {
    Text = "Transformación"
  },
  Event_125742_ChoiceDesc1 = {
    Text = "[Aceptar el Destino] Graba la Oración [(EnchantConfig.Arg1)] en 1 de 3 Tarjetas de comando.(Usos: 0/2)"
  },
  Event_125742_Desc = {
    Text = "\"Nadie puede verdaderamente desafiar al destino, querida. Nunca tuvimos el derecho de elegir.\"\nLa voz se vuelve melancólica y distante. No estás segura de si te habla a ti, o a algo completamente diferente."
  },
  Event_125742_Name = {
    Text = "La Jaula del Destino"
  },
  Event_125743_ChoiceDesc1 = {
    Text = "[Escuchar canto] obtiene 30 la marca negra, infecta\"(Skill.Arg2)», continúa eligiendo"
  },
  Event_125743_ChoiceDesc2 = {
    Text = "[Dejarlo estar]Salir"
  },
  Event_125743_Desc = {
    Text = "\"Las marionetas hacen fila para su entrada, adentrándose en la gran red del destino.\""
  },
  Event_125743_Name = {
    Text = "La Profecía Final"
  },
  Event_125744_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125744_Desc = {
    Text = "Levantas la vista hacia el vórtice del abismo, esforzándote por escuchar el oráculo de los cuervos.\nPero no dicen nada. Bajo tu mirada, el abismo se disuelve.\nEl enjambre desaparece hacia el final del escenario—el lugar al que debes ir."
  },
  Event_125744_Name = {
    Text = "Abyss de los Cuervos"
  },
  Event_125745_ChoiceDesc1 = {
    Text = "[Agree] Elimina 2 cartas"
  },
  Event_125745_ChoiceDesc2 = {
    Text = "[Disagree] Obtener criatura maldita \"(RelicConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_125745_ChoiceDesc3 = {
    Text = "[Salir]obtiene Arg1 sigilo negro"
  },
  Event_125745_Desc = {
    Text = "El telón del escenario ondea con el viento. Entre el lodo negro que emana de un cadáver caído, distingues un grupo de mariposas.\n\"El verdadero arte siempre florece en la disolución... ¿no es así, Guardián?\"\nEl cadáver de la bailarina te sonríe. Escuchas el aleteo de las alas."
  },
  Event_125745_Name = {
    Text = "Florecer en la desaparición"
  },
  Event_125746_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125746_Desc = {
    Text = "La sofistería nunca podrá doblegarte. Sabes con claridad el camino que recorres y el destino que buscas.\nLas espinas se disuelven en tu interior. Pones el pie en el camino, como siempre has hecho."
  },
  Event_125746_Name = {
    Text = "Propagación de agonía"
  },
  Event_125747_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125747_Desc = {
    Text = "Te das la vuelta, intentando olvidar los ojos que tienes detrás. Pero descubres que tu cuerpo ya no se mueve con la misma libertad de antes.\nLo sabes: de esas miradas fijas, jamás podrás escapar."
  },
  Event_125747_Name = {Text = "Público"},
  Event_125748_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125748_Desc = {
    Text = "Ya sea por respeto o por miedo, no te atreves a tocarlo fácilmente y pones el sobre de vuelta en su lugar. Justo cuando te preparas para irte, una voz turbia pero suave suena desde la oscuridad detrás del sobre. \n \"Gracias por recordarme, Señorita Arachne...\""
  },
  Event_125748_Name = {
    Text = "Buenas noches, señor Edgar"
  },
  Event_125749_ChoiceDesc1 = {
    Text = "[Poder para proteger] Adquirir la Creación de plata [(RelicConfig.Arg1)]"
  },
  Event_125749_ChoiceDesc2 = {
    Text = "[Libertad para huir] Grabar la Oración [(EnchantConfig.Arg1)] en 1 Tarjeta de comando aleatoria"
  },
  Event_125749_ChoiceDesc3 = {
    Text = "[Negarse a responder] Recibir 50 Marcas Negras"
  },
  Event_125749_Desc = {
    Text = "El licor de Máscara de medianoche se infiltra en tu mente como cadenas que se enroscan con fuerza. A lo largo de los fríos eslabones de hierro, la voz de una joven mujer acecha tu consciencia.\n\"Dime, querido. ¿Qué destino deseas realmente?\""
  },
  Event_125749_Name = {
    Text = "Cerradura del destino"
  },
  Event_125750_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125750_Desc = {
    Text = "Incluso los asuntos más complicados deben ser resueltos por tu mano.\nEl peso se hace más grande, pero con él surge una fuerza nueva y desconocida."
  },
  Event_125750_Name = {
    Text = "Tranquilidad"
  },
  Event_125751_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125751_Desc = {
    Text = "Actores desconocidos, pasos peligrosos. En verdad, la huida es el único refugio seguro.\nDas media vuelta y corres, rasgando las cortinas del teatro, solo para encontrarte de pie sobre el escenario. Los títeres toman tu mano, haciéndote girar en un alegre baile.\nEn el escenario del destino, nunca hay elección."
  },
  Event_125751_Name = {
    Text = "Danza de tres"
  },
  Event_125752_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125752_Desc = {
    Text = "Ahora no es momento para una película."
  },
  Event_125752_Name = {
    Text = "Sala de Recuerdos"
  },
  Event_125753_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125753_Desc = {
    Text = "El peligro en el camino no ha entrado en tu mente en absoluto. Pasas junto al destino destruido y continúas acercándote a Nefruri. \n Has venido aquí para traerle la liberación."
  },
  Event_125753_Name = {
    Text = "Red del destino: El desenlace"
  },
  Event_125754_ChoiceDesc1 = {
    Text = "[Leer el sobre] Obtén la Creación de oro \"(RelicConfig.Arg1)\", pero desarrolla \"(Skill.Arg2)\""
  },
  Event_125754_ChoiceDesc2 = {
    Text = "[Leer la carta] Grabar la Oración [(EnchantConfig.Arg1)] en 1 de 3 Tarjetas de comando"
  },
  Event_125754_ChoiceDesc3 = {
    Text = "[Liberar]Obtén 50 marcas negras"
  },
  Event_125754_Desc = {
    Text = "Tus movimientos desgarran las densas telarañas; una vieja carta cae de la seda.\nSu peso supera con creces lo que debería cargar un papel tan fino."
  },
  Event_125754_Name = {
    Text = "Buenas noches, señor Edgar"
  },
  Event_125755_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125755_Desc = {
    Text = "Lágrimas caen de los ojos del cuervo. Sangre fluye de su pico. Con lo último de su vida, el cuervo canta su profecía final para ti."
  },
  Event_125755_Name = {
    Text = "La Profecía Final"
  },
  Event_125756_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125756_Desc = {
    Text = "\"¡Je, je... Ja, ja, ja!\"\n\"¿Qué tal, mi invitado? El sabor del destino... te encontrarás ansiándolo, locamente, sin fin...\""
  },
  Event_125756_Name = {
    Text = "El Sabor del Destino"
  },
  Event_125757_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125757_Desc = {
    Text = "\"Aburrido.\" Suelta un bostezo lánguido.\n\"Toma tu poder y ve a pelear al club.\""
  },
  Event_125757_Name = {
    Text = "Cerradura del destino"
  },
  Event_125758_ChoiceDesc1 = {
    Text = "[Estabilizar la Red del destino] Obtener 1 Gravura avanzada de entre 3 opciones"
  },
  Event_125758_ChoiceDesc2 = {
    Text = "[Ignorar el peligro] obtiene la creación de oro \"(RelicConfig.Arg1)\", pero desarrolla \"(Skill.Arg2)\""
  },
  Event_125758_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_125758_Desc = {
    Text = "Ella es la hermosa hija. Ella es la niña abandonada por el destino. Ella es la vengadora que emerge del Abismo siguiendo un tenue rayo de luz. Ella ha venido aquí para traer liberación a todo. \n La Red del destino se desmorona a su alrededor. Usted está de pie en el escenario del teatro, a no mucha distancia de Nefruri."
  },
  Event_125758_Name = {
    Text = "Red del destino: El desenlace"
  },
  Event_125759_ChoiceDesc1 = {
    Text = "[Indifferent] Obtiene la creación de plata [(RelicConfig.Arg1)]"
  },
  Event_125759_ChoiceDesc2 = {
    Text = "[Empathetic] Obtiene la creación de oro \"(RelicConfig.Arg1)\", pero desarrolla \"(Skill.Arg2)\""
  },
  Event_125759_Desc = {
    Text = "Desgarradores lamentos estallan desde el escenario cuando el único foco de luz cae sobre una figura solitaria.\nTe ofrece su actuación más sincera, dejando al descubierto su pecho para presentar sus vísceras a cada espectador.\n¿Qué es lo que tanto atormenta a este personaje?"
  },
  Event_125759_Name = {
    Text = "Confesión del actor"
  },
  Event_125760_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125760_Desc = {
    Text = "Extiendes la mano hacia la derecha.\nAllí yace tu futuro: tu anhelo más intenso, tu santuario definitivo y el destino al que eventualmente llegarás.\nTu existencia sirve únicamente para perseguir el sol que tienes delante."
  },
  Event_125760_Name = {
    Text = "Pasado, futuro"
  },
  Event_125761_ChoiceDesc1 = {
    Text = "[Tres puntos]"
  },
  Event_125761_ChoiceDesc2 = {
    Text = "[Seis en punto]"
  },
  Event_125761_ChoiceDesc3 = {Text = "[Un punto]"},
  Event_125761_Desc = {
    Text = "Podrías simplemente marcharte, pero los exquisitos dados te cautivan por completo.\nOlvidando a los perseguidores que tienes a tu espalda, los tomas con reverencia y los lanzas al sombrero de copa—"
  },
  Event_125761_Name = {
    Text = "Apuesta callejera"
  },
  Event_125762_ChoiceDesc1 = {
    Text = "[Salir]obtiene reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_125762_Desc = {
    Text = "Traqueteo. Los dados bailan frenéticamente en la copa, girando hasta quedar exhaustos.\n\n\"¿Por qué... por qué nadie gana jamás?!\""
  },
  Event_125762_Name = {
    Text = "Apuesta callejera"
  },
  Event_125763_ChoiceDesc1 = {
    Text = "[Aceptar el Destino] Graba la Oración [(EnchantConfig.Arg1)] en 1 de 3 Tarjetas de comando.(Usos: 0/2)"
  },
  Event_125763_ChoiceDesc2 = {
    Text = "[Desafiar al Destino] Desarrolla el síntoma [(Skill.Arg1)] y cambia la Oración a grabar.(Usos: 1/2)"
  },
  Event_125763_Desc = {
    Text = "\"Ah, travieso. El Destino es siempre misericordioso... pero toda resistencia tiene un precio. Ahora, ¿estás dispuesto a aceptarlo?\""
  },
  Event_125763_Name = {
    Text = "La Jaula del Destino"
  },
  Event_125764_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125764_Desc = {
    Text = "Miras a tu alrededor esas miradas y alzas una mano en señal de saludo.\nPronto, les concederás el crescendo de la historia."
  },
  Event_125764_Name = {Text = "Público"},
  Event_125765_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125765_Desc = {
    Text = "\"Querida señorita Arachne, hoy es el día de su nacimiento, me alegra por el señor y la señora, y también por usted. Bienvenida a este hermoso mundo. Le dedico esta suave canción de cuna, que desde el día de su nacimiento, tenga una vida sin preocupaciones...\""
  },
  Event_125765_Name = {
    Text = "Buenas noches, señor Edgar"
  },
  Event_125766_ChoiceDesc1 = {
    Text = "[Tomar foto] Grabar la Oración [(EnchantConfig.Arg1)] en 1 de 3 Tarjetas de comando.(Usos: 0/2)"
  },
  Event_125766_ChoiceDesc2 = {
    Text = "[Cambiar de nuevo] Desarrolla el síntoma [(Skill.Arg1)] y cambia la Oración a grabar.(Usos: 1/2)"
  },
  Event_125766_Desc = {
    Text = "Sientes un destello de inquietud ante el lente. ¿Quizás esta pose sería mejor? ¿O aquella?"
  },
  Event_125766_Name = {
    Text = "Recuerdos del público"
  },
  Event_125767_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125767_Desc = {
    Text = "Deseas ver el contenido, pero la pantalla está vacía. Solo el sonido de la película girando resuena en la sala.\nQuizás pasará mucho tiempo antes de que descubras lo que contienen los rollos."
  },
  Event_125767_Name = {
    Text = "Sala de Recuerdos"
  },
  Event_125768_ChoiceDesc1 = {
    Text = "[Evitar mirada]Despertar aleatoriamente 1 entidad despierta"
  },
  Event_125768_ChoiceDesc2 = {
    Text = "[Mirada intensa]selecciona 1 despertador, y reduce su coste de consumo de carta de despertar en 2 puntos. Infección\"(Skill.Arg1)\""
  },
  Event_125768_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_125768_Desc = {
    Text = "Al subir al escenario, escuchas un torrente de susurros. Te giras; diez mil pares de ojos flotan alrededor del escenario, mirándote.\n¡Ven!, dicen. ¿Acaso el exquisito drama no termina aquí?\n¡Danza!, dicen. ¡Tráenos el clímax de esta danza!"
  },
  Event_125768_Name = {Text = "Público"},
  Event_125769_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125769_Desc = {
    Text = "No comprendes su dolor, ni tampoco tienes la necesidad de hacerlo.\nEl teatro alberga muchos escenarios, y los escenarios muchos títeres; tú no eres más que uno de ellos.\nTienes cosas más importantes que hacer."
  },
  Event_125769_Name = {
    Text = "Confesión del actor"
  },
  Event_125770_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125770_Desc = {
    Text = "La muerte, la disolución, el paso del tiempo... El arte no existe para infligir dolor. Si la belleza reside únicamente en el sufrimiento, entonces es mejor que tal belleza no nazca.\nGolpeas para dispersarlas. Las mariposas se dispersan, dejando atrás un cadáver melancólico."
  },
  Event_125770_Name = {
    Text = "Florecer en la desaparición"
  },
  Event_125771_ChoiceDesc1 = {
    Text = "[Escuchar canto] obtiene 40 la marca negra, infecta\"(Skill.Arg2)\",continúa eligiendo"
  },
  Event_125771_ChoiceDesc2 = {
    Text = "[No preocuparse]obtener 25 el sigilo negro y salir"
  },
  Event_125771_Desc = {
    Text = "Los cuervos dispersos que han cruzado tu camino convergen en uno solo. Se posa ante ti y canta, su melodía desolada—como la profecía final."
  },
  Event_125771_Name = {
    Text = "La Profecía Final"
  },
  Event_125772_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125772_Desc = {
    Text = "Extiendes la mano hacia la izquierda.\nAllí yace tu pasado: tus recuerdos más preciados, el camino que una vez recorriste y el lugar al que eventualmente regresarás.\nTodo lo que ha sido forma todo lo que eres."
  },
  Event_125772_Name = {
    Text = "Pasado, futuro"
  },
  Event_125773_ChoiceDesc1 = {
    Text = "[Tomar foto] Grabar la Oración [(EnchantConfig.Arg1)] en 1 de 3 Tarjetas de comando.(Usos: 0/2)"
  },
  Event_125773_Desc = {
    Text = "Sientes un destello de aprensión ante el objetivo. ¿Quizás esta pose sería mejor? ¿O aquella?\nSigues dudando, pero puedes percibir el creciente fastidio de la cámara."
  },
  Event_125773_Name = {
    Text = "Recuerdos del público"
  },
  Event_125774_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125774_Desc = {
    Text = "Adoptas una pose ante la cámara—sereno, curioso, inmerso. Como un verdadero espectador.\n¡Gluglú—\nEl obturador hace clic. Un lodo negro erupciona del cuerpo de la cámara, salpicando todo el escenario.\nEn el hueco centro del cuerpo de la cámara, el carrete permanece vacío."
  },
  Event_125774_Name = {
    Text = "Recuerdos del público"
  },
  Event_125775_ChoiceDesc1 = {
    Text = "[Accept] Obtén 1 de 3 creaciones de plata"
  },
  Event_125775_ChoiceDesc2 = {
    Text = "[Flee] Obtén las creaciones de plata \"(RelicConfig.Arg1)\" & \"(RelicConfig.Arg2)\", pero desarrolla \"(Skill.Arg3)\" dos veces"
  },
  Event_125775_Desc = {
    Text = "Tap-tap, tap-tap... Los tacones golpean las tablas del suelo con un sonido vivo y alegre.\nDos títeres con uniformes escolares danzan sobre el escenario. De repente, detienen sus pasos y se giran para tenderte las manos."
  },
  Event_125775_Name = {
    Text = "Danza de tres"
  },
  Event_125776_ChoiceDesc1 = {
    Text = "[Paciencia ante la Agonía] Aumenta PV Max en Arg1"
  },
  Event_125776_ChoiceDesc2 = {
    Text = "[Refutar el dolor] 1 Tarjeta de comando aleatoria obtiene Inscripción: \"(EnchantConfig.Arg1)\", infectar 1 \"(Skill.Arg2)\""
  },
  Event_125776_Desc = {
    Text = "\"Nunca te importó la muerte de Liz. Nunca te importó nadie.\"\n\"Solo te importas tú misma... todos los que te rodean son meros instrumentos para tu viaje hacia la libertad y la paz.\"\n\"¿No es así... Guardián?\"\nEl susurro del Anunciador roza tu oído. Tu corazón se contrae; un agudo dolor se extiende por todo tu ser con sus palabras..."
  },
  Event_125776_Name = {
    Text = "Propagación de agonía"
  },
  Event_125777_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125777_Desc = {
    Text = "Entrégate al descenso; el mar posee su propia flotabilidad, y el destino revelará el camino para ambos."
  },
  Event_125777_Name = {
    Text = "Tranquilidad"
  },
  Event_125778_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125778_Desc = {
    Text = "Eres tú mismo. La fuente del poder, el portador del deber, el único objeto de lealtad.\nRecorres el camino que solo a ti te pertenece."
  },
  Event_125778_Name = {
    Text = "Reflejo en el vino"
  },
  Event_125779_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125779_Desc = {
    Text = "\"Qué lástima, mi invitado. El Sabor del Destino... nunca tendrás la oportunidad de saborearlo de nuevo...\""
  },
  Event_125779_Name = {
    Text = "El Sabor del Destino"
  },
  Event_125780_ChoiceDesc1 = {
    Text = "[Discutir con Ella] Destruir una Tarjeta de comando y recibir Arg1 Marcas negras"
  },
  Event_125780_ChoiceDesc2 = {
    Text = "[Permanecer en silencio]"
  },
  Event_125780_Desc = {
    Text = "\"¡Qué obra tan triste... Esa pobre chica fue abandonada por quien ella quería, hermanita?\"\nEn esa voz familiar, no percibes rastro de locura ni malicia. Es clara y melancólica, como un suave arroyo entre un bosque.\n\"La cantante, una hoja marchita que deriva indefensa, abandonada a los estragos del destino... ¡Qué alma tan lastimosa...\"\n\"Hermanita, si yo fuera la autora... ¿qué final debería escribirle?\""
  },
  Event_125780_Name = {
    Text = "El Final de la Obra"
  },
  Event_125781_ChoiceDesc1 = {
    Text = "[Acariciarlos] 50% de probabilidad de obtener 125 marcas negras, 50% de probabilidad de desarrollar [(Skill.Arg2)]"
  },
  Event_125781_ChoiceDesc2 = {
    Text = "[Explain] 75% de probabilidad de obtener 100 marcas negras, 25% de probabilidad de desarrollar [(Skill.Arg2)]"
  },
  Event_125781_ChoiceDesc3 = {
    Text = "[Ver a través] Obtén 50 marcas negras"
  },
  Event_125781_Desc = {
    Text = "Al perseguir al monstruo hacia el callejón trasero del bar, su silueta desaparece. Un grupo de gatos negros te cierra el paso.\n\"Eh, tú.\" Un gato negro lame su pata, mirándote.\n\"¿Qué haces en nuestro territorio?\""
  },
  Event_125781_Name = {
    Text = "Transformación"
  },
  Event_125782_ChoiceDesc1 = {
    Text = "[Abrazar el Pasado] Obtén la Creación de oro \"(RelicConfig.Arg1)\", pero desarrolla \"(Skill.Arg2)\""
  },
  Event_125782_ChoiceDesc2 = {
    Text = "[Dar la bienvenida al Futuro] Obtén 1 de 3 Creaciones de oro, pero desarrolla el síntoma [(Skill.Arg1)]"
  },
  Event_125782_ChoiceDesc3 = {
    Text = "[Salir]obtiene reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_125782_Desc = {
    Text = "La aparición de Nefruri interfirió con el hilo. En el destino caótico, ves dos fantasmas borrosos. \n Esa es tu pasado, esa es tu futuro. Te acercas a ellos, extends tu mano..."
  },
  Event_125782_Name = {
    Text = "Pasado, futuro"
  },
  Event_125855_ChoiceDesc1 = {
    Text = "[Perceive] Mejora 1 Reliquia transformándola en la Creación de oro [(RelicConfig.Arg1)]"
  },
  Event_125855_ChoiceDesc2 = {
    Text = "[Mirar fijamente]obtener reliquia de plata\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_125855_ChoiceDesc3 = {
    Text = "[Ignorar] obtiene 25 marcas negras"
  },
  Event_125855_Desc = {
    Text = "En las calles de Casalim, el brillante resplandor de una tienda de cristales te atrae. Te detienes frente al escaparate y recoges un cristal con forma de Núcleo de plata."
  },
  Event_125855_Name = {
    Text = "El secreto del cristal"
  },
  Event_125856_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125856_Desc = {
    Text = [[
Cierras los ojos y lo percibes con cuidado.
Un destello de luz parpadea en tu conciencia, como si quisiera decirte algo...]]
  },
  Event_125856_Name = {
    Text = "El secreto del cristal"
  },
  Event_125857_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125857_Desc = {
    Text = "Cualquier resistencia o intento de escudriñar el destino es inútil. Cierras los ojos en silencio, permitiendo que el destino te lleve adonde debes ir."
  },
  Event_125857_Name = {
    Text = "Red de ataduras de vida"
  },
  Event_125858_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125858_Desc = {
    Text = "\"La emoción es el significado de la existencia. Que nunca te arrepientas de tu elección.\""
  },
  Event_125858_Name = {
    Text = "El precio de la elección"
  },
  Event_125859_ChoiceDesc1 = {
    Text = "[Emotion] Recupera Arg1 PV"
  },
  Event_125859_ChoiceDesc2 = {
    Text = "[Reason] Graba la Oración [(EnchantConfig.Arg1)] en 1 tarjeta de comando aleatoria"
  },
  Event_125859_ChoiceDesc3 = {
    Text = "[Rechazar la elección] obtienes 25 marcas negras"
  },
  Event_125859_Desc = {
    Text = "Una balanza aparece sobre el escenario.\n\"Cerebro y corazón, razón y emoción, gris y rojo... no podemos evadir la elección; es nuestro destino.\"\n\"El final del escenario ya está trazado. Ahora, elige el camino que seguirá esta actuación.\""
  },
  Event_125859_Name = {
    Text = "El precio de la elección"
  },
  Event_125860_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125860_Desc = {
    Text = "\"No mires hacia arriba. Abandona este lugar.\"\nEscuchas la voz del destino. Aunque anhelas contemplar el cielo, sabes que ella tiene razón."
  },
  Event_125860_Name = {
    Text = "Mirar hacia arriba"
  },
  Event_125861_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125861_Desc = {
    Text = [[
Nunca aceptas el destino. Nunca aceptas el encarcelamiento.
Luchas con todas tus fuerzas. Tras sacrificar un miembro de la polilla, finalmente logras escapar...]]
  },
  Event_125861_Name = {
    Text = "Red de ataduras de vida"
  },
  Event_125862_ChoiceDesc1 = {
    Text = "[Friendship] Obtiene 50 Marcas negras"
  },
  Event_125862_ChoiceDesc2 = {
    Text = "[Help] Obtiene 75 Marcas negras, infecta [(Skill.Arg2)]"
  },
  Event_125862_Desc = {
    Text = "En el callejón trasero del bar, te encuentras de nuevo con esos gatos negros.\n\"He oído. Esas babosas negras tomaron nuestra forma y te causaron bastantes problemas.\"\n\"Como disculpa, dime, ¿qué deseas?\"\nLos gatos negros rodean tus piernas dos veces, mirándote."
  },
  Event_125862_Name = {
    Text = "Regalo de primer encuentro"
  },
  Event_125863_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125863_Desc = {
    Text = "La fuerza bruta no puede desenredar el destino, ¿pero quizás la sabiduría sí?\nObservas la telaraña de cerca, buscando algún hilo del diseño del destino en su interior..."
  },
  Event_125863_Name = {
    Text = "Red de ataduras de vida"
  },
  Event_125864_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125864_Desc = {
    Text = [[
Te inclinas y lo observas fijamente.
Un destello de luz parpadea en tus ojos, como si quisiera decirte algo...]]
  },
  Event_125864_Name = {
    Text = "El secreto del cristal"
  },
  Event_125865_ChoiceDesc1 = {
    Text = "[Struggle] Destruir 1 de 3 tarjetas de comando aleatorias y obtener 75 marcas negras"
  },
  Event_125865_ChoiceDesc2 = {
    Text = "[Rest] Duplicar 1 de 3 tarjetas de comando y obtener 25 marcas negras"
  },
  Event_125865_ChoiceDesc3 = {
    Text = "[Rest] Obtén 50 marcas negras"
  },
  Event_125865_Desc = {
    Text = "Una sensación familiar te asalta. Sin embargo, esta vez, el tacto viscoso y el instinto de impotencia son más intensos, más letales.\nLa polilla cae en la telaraña. Y tú ya has pisado el escenario."
  },
  Event_125865_Name = {
    Text = "Red de ataduras de vida"
  },
  Event_125866_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125866_Desc = {
    Text = "\"La razón es el significado de la existencia. Que nunca te arrepientas de tu elección.\""
  },
  Event_125866_Name = {
    Text = "El precio de la elección"
  },
  Event_125867_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125867_Desc = {
    Text = "La curiosidad se enciende. Te mezclas entre la multitud y alzas la cabeza como ellos.\nNo hay nada allí, pero por razones desconocidas, te resistes a apartar la mirada. Deseas observar así, observar para siempre..."
  },
  Event_125867_Name = {
    Text = "Mirar hacia arriba"
  },
  Event_125868_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125868_Desc = {
    Text = "\"Rechazar la elección es en sí una elección—esta es la maldición del destino. Que nunca te arrepientas de la elección que has tomado.\""
  },
  Event_125868_Name = {
    Text = "El precio de la elección"
  },
  Event_125869_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125869_Desc = {
    Text = [[
"Ahora, es tuyo."
Los gatos rozan tu espinilla y pronto desaparecen.
Donde desaparecieron, te aguarda un regalo.]]
  },
  Event_125869_Name = {
    Text = "Regalo de primer encuentro"
  },
  Event_125870_ChoiceDesc1 = {Text = "[Salir]"},
  Event_125870_Desc = {
    Text = [[
"Ahora, es tuyo."
Los gatos rozan tu espinilla y pronto desaparecen.
Donde desaparecieron, te aguarda un regalo.]]
  },
  Event_125870_Name = {
    Text = "Regalo de primer encuentro"
  },
  Event_125871_ChoiceDesc1 = {
    Text = "[Levantar la cabeza] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_125871_ChoiceDesc2 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_125871_Desc = {
    Text = "La cacofonía se desvanece por un instante fugaz. Las multitudes en la calle caen en silencio, levantando sus cabezas hacia el cielo."
  },
  Event_125871_Name = {
    Text = "Mirar hacia arriba"
  },
  Event_129176_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129176_Name = {
    Text = "Olvido Capítulo 1@"
  },
  Event_129177_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129177_Name = {
    Text = "Capítulo 1 de las Estrellas@"
  },
  Event_129178_ChoiceDesc1 = {
    Text = "[Indicar dirección]obtiene la reliquia de plata «(RelicConfig.Arg1)», infección «(Skill.Arg2)»"
  },
  Event_129178_ChoiceDesc2 = {
    Text = "[Rezar juntos] Grabar 1 de 3 Inscripciones dos veces"
  },
  Event_129178_Desc = {
    Text = "El sonido del piano y del órgano se entrelaza en el viento gris. Una melodía mágica parece flotar en las calles desiertas. \n Una monja anónima reza entre las notas del piano. \n \"Una oración simple no necesita ceremonias elaboradas, el gran Padre Dios sembrará esperanza para nosotros, así como nos otorgó enseñanzas de piedad.\""
  },
  Event_129178_Name = {
    Text = "Oración del órgano"
  },
  Event_129179_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129179_Name = {
    Text = "Capítulo 1 de las Estrellas@"
  },
  Event_129180_ChoiceDesc1 = {
    Text = "[enfrentarlo proactivamente]obtén reliquia maldita\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_129180_ChoiceDesc2 = {
    Text = "[Surrender] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129180_ChoiceDesc3 = {
    Text = "[salir corriendo]obtén 50 el sigilo negro"
  },
  Event_129180_Desc = {
    Text = "Unos cuantos esculturas de cera bloquean tu camino.\nSon torcidas, con características rústicas, no parecen tener la calidad que debería tener Rogers.\n\"Orden... la orden del maestro...\""
  },
  Event_129180_Name = {Text = "Borrador"},
  Event_129181_ChoiceDesc1 = {
    Text = "[Dejar de pensar]obtener reliquia maldita\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_129181_ChoiceDesc2 = {
    Text = "[Seguir el Conocimiento] 1 Tarjeta de comando aleatoria obtiene Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129181_Desc = {
    Text = "El puerto fue atacado, un misterioso carguero sin retorno y un \"nuevo amigo\" con aletas... ¿Es esta una trampa cuidadosamente preparada? ¿O es otro viaje lleno de imprevistos? \n La realidad y la razón se entrelazan y se tiran mutuamente, innumerables inspiraciones y pensamientos brotan de tu mente."
  },
  Event_129181_Name = {
    Text = "Chispa de inspiración"
  },
  Event_129182_ChoiceDesc1 = {
    Text = "[Join] Infecta \"(Skill.Arg1)\" dos veces, 1 Tarjeta de comando aleatoria obtiene la Inscripción: \"(EnchantConfig.Arg2)\" dos veces"
  },
  Event_129182_ChoiceDesc2 = {
    Text = "[Dispel] Infecta \"(Skill.Arg1)\" dos veces, 1 Tarjeta de comando aleatoria obtiene la Inscripción: \"(EnchantConfig.Arg2)\" dos veces"
  },
  Event_129182_ChoiceDesc3 = {
    Text = "[Disregard] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129182_Desc = {
    Text = "Escuchas el sonido distante y tenue de un cuerno de hueso. \n La multitud de ratas surge del barro negro, devorando los cuerpos anónimos que yacen en el lecho seco del río. \n Forman un círculo, con el centro siendo el cadáver ya vacío, y la circunferencia es un nuevo reino donde el olvido es la ley. \n Y tú, estás de pie en la entrada de este reino."
  },
  Event_129182_Name = {
    Text = "Reino Exiliado"
  },
  Event_129183_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129183_Name = {
    Text = "Olvido Capítulo 5@"
  },
  Event_129184_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129184_Name = {
    Text = "Olvido Capítulo 8@"
  },
  Event_129185_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129185_Name = {
    Text = "Capítulo 1 del Olvido@"
  },
  Event_129186_ChoiceDesc1 = {
    Text = "[Rescatar el retrato] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infecta \"(Skill.Arg2)\" dos veces"
  },
  Event_129186_ChoiceDesc2 = {
    Text = "[Aceptar el vacío] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infecta \"(Skill.Arg2)\" dos veces"
  },
  Event_129186_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_129186_Desc = {
    Text = "Te encuentras frente al regalo de Pickman. \n Es un retrato, pintado con sangre, con llamas negras que arden silenciosamente. \n A través de los vacíos ojos del retratado, ves— \n tus recuerdos arden y se agitan, se alargan, se distorsionan, brillan, como si un fuego invisible estuviera lamiendo los pasillos de tu mente. En un momento de confusión, oyes una voz. \n\"Es hora de ponerlo en la olla, el fuego está justo bien.\"\n Esta es la escena de recuerdos que tú mismo has pintado, luchando y deformándote en las llamas."
  },
  Event_129186_Name = {
    Text = "Retrato Ardiente"
  },
  Event_129187_ChoiceDesc1 = {
    Text = "[¿Qué precio estás dispuesto a pagar?] Mejorar la calidad de Oración de una carta aleatoria dos veces."
  },
  Event_129187_ChoiceDesc2 = {
    Text = "[Invítalos a un Bloody Mary caducado] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infectar \"(Skill.Arg2)\" dos veces"
  },
  Event_129187_Desc = {
    Text = "\"Bienvenido, mi valioso invitado. Siéntase libre de elegir, toda esta variedad está aquí esperando por usted.\"\n\"Eh, disculpe, ¿es usted... la hermana gemela de la señora Dafdell?\"\n\"Soy la misma Dafdell, ¿puede decirme, querido invitado, qué le trae por aquí hoy...?\"\n\"Lo siento, lo siento, usted se ve aún más encantadora que antes, no la reconocí. ¿Recuerda? Hace veinte años, usted ahuyentó a un extraño de mi bar... Ayer, la pesadilla recurrente regresó, ocupó el bar, trayendo a sus congéneres, en grandes cantidades...\""
  },
  Event_129187_Name = {
    Text = "Fragmento de recuerdo: Sueños del pasado"
  },
  Event_129188_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129188_Name = {
    Text = "Capítulo 3 de las Estrellas@"
  },
  Event_129189_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129189_Name = {
    Text = "Olvido capítulo 8@"
  },
  Event_129190_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129190_Name = {
    Text = "Olvido Capítulo 1@"
  },
  Event_129191_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129191_Name = {
    Text = "Olvido Capítulo 6@"
  },
  Event_129192_ChoiceDesc1 = {
    Text = "[Apretar la chispa]aumentar Arg1 salud máxima"
  },
  Event_129192_ChoiceDesc2 = {
    Text = "[Enfrentar el interior] 2 Tarjetas de comando aleatorias obtienen Inscripción: \"(EnchantConfig.Arg1)\" dos veces, desarrollar 2 \"(Skill.Arg2)\" dos veces"
  },
  Event_129192_Desc = {
    Text = "En esta caza monumental, la persecución de Goliath es como una bestia nocturna, intentando devorar toda esperanza. Sin embargo, esta persecución despiadada no te congeló, sino que encendió una chispa en tu interior, que se extendió y ardió cada vez más"
  },
  Event_129192_Name = {
    Text = "Seguir la luz"
  },
  Event_129193_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129193_Name = {
    Text = "Olvido Capítulo 6@"
  },
  Event_129194_ChoiceDesc1 = {
    Text = "[Leer el Camino de los predecesores] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_129194_ChoiceDesc2 = {
    Text = "[escribir mi propio camino]obtén reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_129194_ChoiceDesc3 = {
    Text = "[Mirar a la oscuridad]Obtén 25 el sigilo negro"
  },
  Event_129194_Desc = {
    Text = "Si exploras en el dominio por tu cuenta, no podrías estar tan seguro de tu camino como estás ahora.  \nLas huellas en el dominio se dividen en tres, cada pisada inscrita, escribe un futuro invisible"
  },
  Event_129194_Name = {Text = "Salida"},
  Event_129195_ChoiceDesc1 = {
    Text = "[Señalar el error] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infectar \"(Skill.Arg2)\" dos veces"
  },
  Event_129195_ChoiceDesc2 = {
    Text = "[escuchar la interpretación] por cada despertador con nivel de locura de 50 o más, obtiene 15 el sigilo negro"
  },
  Event_129195_ChoiceDesc3 = {
    Text = "[Salir]obtiene elección de 3 para 1 de oración"
  },
  Event_129195_Desc = {
    Text = "El chico de cera toca una pieza en el piano.\nSu maestro, también de cera, lo guía al lado.\n133, 355, 244...\nMal, cada nota está mal"
  },
  Event_129195_Name = {
    Text = "Clases de piano"
  },
  Event_129196_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129196_Name = {
    Text = "Olvido Capítulo 5@"
  },
  Event_129197_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129197_Name = {
    Text = "Capítulo 4 de las Estrellas@"
  },
  Event_129198_ChoiceDesc1 = {
    Text = "[Escuchar el Lamento] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\" dos veces, pero desarrollar \"(Skill.Arg2)\" dos veces"
  },
  Event_129198_ChoiceDesc2 = {
    Text = "[Escuchar alegría]por cada despertador con un valor de locura de 50 o más, gana 15 el sigilo negro"
  },
  Event_129198_ChoiceDesc3 = {
    Text = "[Leave] Elige 1 de 3 Inscripciones para grabar dos veces"
  },
  Event_129198_Desc = {
    Text = "Melodías suaves, líricas, alegres, tristes... La melodía resuena en el espacio del dominio, difícil de discernir su origen.\n¿Es la sonata que fluyó del barco fantasma, o un capricho atrapado en el dominio, a medianoche?"
  },
  Event_129198_Name = {
    Text = "Son Anónimo"
  },
  Event_129199_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129199_Name = {
    Text = "Capítulo 1 de las Estrellas@"
  },
  Event_129200_ChoiceDesc1 = {
    Text = "[Abre el sobre] Obtén Reliquia de oro '(RelicConfig.Arg1)', infecta '(Skill.Arg2)'"
  },
  Event_129200_ChoiceDesc2 = {
    Text = "[Read] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129200_ChoiceDesc3 = {
    Text = "[Put it back] Gana 50 El sigilo negro"
  },
  Event_129200_Desc = {
    Text = "En un rincón descuidado, ha quedado una carta.\nMuchas palabras en la carta se han vuelto irreconocibles, pero una palabra permanece. Perfora el papel.\nEsa palabra es \"Madre\"."
  },
  Event_129200_Name = {
    Text = "Anhelo Desvanecido"
  },
  Event_129201_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129201_Name = {
    Text = "Capítulo 4 de las Estrellas@"
  },
  Event_129202_ChoiceDesc1 = {
    Text = "[Escuchar con atención] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\" dos veces, pero desarrollar \"(Skill.Arg2)\" dos veces"
  },
  Event_129202_ChoiceDesc2 = {
    Text = "[Taparse los oídos]Por cada despertar con un valor de aliemus de 50 o más, gana 15 el sigilo negro"
  },
  Event_129202_ChoiceDesc3 = {
    Text = "[Examine] Grabar 1 de 3 Inscripciones dos veces"
  },
  Event_129202_Desc = {
    Text = "Al entrar en el piso donde están los esqueletos, un hermoso tintineo suena abruptamente en la desolada fábrica abandonada, la melodía del piano resuena en contradicción con las ruinas de acero oxidado"
  },
  Event_129202_Name = {
    Text = "Escalera inquietante"
  },
  Event_129203_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129203_Name = {
    Text = "Olvido Capítulo 3@"
  },
  Event_129204_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129204_Name = {
    Text = "Olvido Capítulo 6@"
  },
  Event_129205_ChoiceDesc1 = {
    Text = "[Dejarla ir]obtener reliquia maldita\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_129205_ChoiceDesc2 = {
    Text = "[Ayudarla] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129205_ChoiceDesc3 = {
    Text = "[voy a seguir mi propio camino]Obtén 50 el sigilo negro"
  },
  Event_129205_Desc = {
    Text = "Tres figuras bloquean tu camino. \n\"Puedes liberarla,\"dice la figura que abraza un osito de peluche cubierto de D-Slime,\"ella solo tiene miedo, no es malvada. No quiere hacerle daño a nadie.\"\n\"Puedes ayudarla,\"dice la figura que sostiene un paquete de dulces finamente envuelto,\"tú puedes hacer lo que ella no puede, tú puedes acabar con todo esto.\"\n\"No necesitas escucharnos,\"dice la figura que tiene las manos vacías,\"tienes tu propio camino.\""
  },
  Event_129205_Name = {
    Text = "Sendero bifurcado"
  },
  Event_129206_ChoiceDesc1 = {
    Text = "[Alimentar a las ratas] Obtén Creación de plata [(RelicConfig.Arg1)], desarrolla 1 síntoma"
  },
  Event_129206_ChoiceDesc2 = {
    Text = "[Ahuyentar a los ratones] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infecta \"(Skill.Arg2)\" dos veces"
  },
  Event_129206_ChoiceDesc3 = {
    Text = "[Ignorar a las ratas] Gana 25 marcas negras"
  },
  Event_129206_Desc = {
    Text = "Todo en este barco está atrapado en el bucle temporal.\nIncluso esas asquerosas y peludas criaturas que luchan por sobrevivir aquí no pueden escapar de su destino.\nCiclo tras ciclo, devoran todo lo que ven, pero su hambre nunca se sacia.\n\"Tanta... hambre...\"\nHordas de ratas emiten chillidos enfermizos y penetrantes.\nLos ciclos interminables las han dejado hambrientas y enloquecidas—necesitan comer algo.\nAhora. Inmediatamente."
  },
  Event_129206_Name = {
    Text = "Grupo de ratas hambrientas"
  },
  Event_129207_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129207_Name = {
    Text = "Olvido Capítulo 8@"
  },
  Event_129208_ChoiceDesc1 = {
    Text = "[Tocar el cerebro] 1 Tarjeta de comando aleatoria obtiene la Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129208_ChoiceDesc2 = {
    Text = "[Tocar el corazón]aumenta Arg1 puntos de salud máxima, infecta\"(Skill.Arg2)\""
  },
  Event_129208_Desc = {
    Text = "Entras en la sala gris donde nadie susurra, una balanza aparece vagamente en la niebla negra. \n A la izquierda, hay un cerebro tranquilo como un lago, con surcos plateados que brillan débilmente; a la derecha, un corazón de color rojo ardiente que emana vapor caliente. \n De repente, sientes un aroma, un deseo voraz se expande constantemente, y la razón es comprimida por su oscuridad infinita. \n Extiendes la mano."
  },
  Event_129208_Name = {
    Text = "Juego del Hambre"
  },
  Event_129209_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129209_Name = {
    Text = "Olvido Capítulo 4@"
  },
  Event_129210_ChoiceDesc1 = {
    Text = "[Matar sombras] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\" dos veces, pero desarrollar \"(Skill.Arg2)\" dos veces"
  },
  Event_129210_ChoiceDesc2 = {
    Text = "[Aplastar el Embrión] Elegir 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\" dos veces, desarrollar \"(Skill.Arg2)\" dos veces"
  },
  Event_129210_ChoiceDesc3 = {
    Text = "[Cerrar los ojos]obtiene 25 el sigilo negro"
  },
  Event_129210_Desc = {
    Text = "En un estado de trance, ves a las personas que conociste en Aram acercándose a ti. \n Ellos ríen y te invitan a beber, bailar y degustar manjares. \n Luego, su carne se desprende en capas, cayendo al suelo y retorciéndose en nuevos Embriones. \n Te extienden la mano, invitándote a unirte a la celebración de la carne y el renacimiento."
  },
  Event_129210_Name = {
    Text = "Sombras del Pasado"
  },
  Event_129211_ChoiceDesc1 = {
    Text = "[Alimentarlos]obtiene reliquia de plata\"(RelicConfig.Arg1)\", selecciona 1 para infectar síntoma"
  },
  Event_129211_ChoiceDesc2 = {
    Text = "[No hacer caso] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infecta \"(Skill.Arg2)\" dos veces"
  },
  Event_129211_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_129211_Desc = {
    Text = "Los residentes van y vienen, pero la multitud de ratas persiste. \n En comparación con los humanos, ellos son los \"nativos\" de este castillo. \n Sin embargo, no tienen objeciones a la llegada de los humanos. \n Porque esas cosas feas, suaves y blancas, les alimentan con cosas igualmente suaves y blancas. \n \"¿Y tú, cosa fea, a cuál de ellas perteneces?\""
  },
  Event_129211_Name = {
    Text = "El secreto del castillo"
  },
  Event_129212_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129212_Name = {
    Text = "Olvido Capítulo 5@"
  },
  Event_129213_ChoiceDesc1 = {
    Text = "[Distinguir la voz del hombre] Robe aleatoriamente 3 cartas de comando del mazo y elija 1 para duplicar."
  },
  Event_129213_ChoiceDesc2 = {
    Text = "[Distinguir la voz de la mujer] Elegir 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\" dos veces, desarrollar \"(Skill.Arg2)\" dos veces"
  },
  Event_129213_ChoiceDesc3 = {
    Text = "[Distinguir la voz del anciano] Reciba 25 [El sigilo negro]"
  },
  Event_129213_Desc = {
    Text = "Estás de pie solo en un pantano oscuro.\nA través de la neblina, escuchas murmullos caóticos superpuestos como mareas—algunos de ancianos, algunos de niños balbuceantes, algunos de mujeres ansiosas, y algunos de hombres ominosamente temerosos..."
  },
  Event_129213_Name = {
    Text = "Últimas palabras incoherentes"
  },
  Event_129214_ChoiceDesc1 = {
    Text = "[Echar un vistazo] Grabar 1 de 3 Oraciones dos veces."
  },
  Event_129214_ChoiceDesc2 = {
    Text = "[Arrancar el cartel] 1 Tarjeta de comando aleatoria obtiene Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infectar \"(Skill.Arg2)\" dos veces"
  },
  Event_129214_Desc = {
    Text = "Un candelabro común en el museo de cera.\nA la luz enfermiza de la vela, ves un cartel dibujado a mano en la pared"
  },
  Event_129214_Name = {
    Text = "Risas en la oscuridad"
  },
  Event_129215_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129215_Name = {
    Text = "Olvido Capítulo 4@"
  },
  Event_129216_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129216_Name = {
    Text = "Olvido Capítulo 7@"
  },
  Event_129217_ChoiceDesc1 = {
    Text = "[Mirar fijamente]obtener reliquia de plata\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_129217_ChoiceDesc2 = {
    Text = "[Ignore] Grabar 1 de 3 Inscripciones dos veces"
  },
  Event_129217_Desc = {
    Text = [[
Los aram se arrodillan en la tormenta de arena.
La tormenta golpea sus cuerpos, y los granos de arena barren sus corazones piadosos.
En el torbellino de arena, parece que innumerables ojos gigantes observan la tierra torcida]]
  },
  Event_129217_Name = {
    Text = "Gigante de arena y polvo"
  },
  Event_129218_ChoiceDesc1 = {
    Text = "[Ahuyentar las mariposas] 1 Tarjeta de comando aleatoria obtiene la Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infecta \"(Skill.Arg2)\" dos veces"
  },
  Event_129218_ChoiceDesc2 = {
    Text = "[Escuchar el deseo] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129218_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_129218_Desc = {
    Text = "La pequeña mariposa también tiene muchos sueños.\nEstos sueños se esparcen en el mar de flores, en la sala de enfermos, y en el altar lleno de carne y sangre de @2.\nFinalmente, ha esperado a la persona que la ata, no sabe si estás dispuesto a escuchar su pequeño, pequeño deseo."
  },
  Event_129218_Name = {
    Text = "Sueño de la mariposa"
  },
  Event_129219_ChoiceDesc1 = {
    Text = "[Seguir la guía] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infecta \"(Skill.Arg2)\" dos veces"
  },
  Event_129219_ChoiceDesc2 = {
    Text = "[Ignorar la guía] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infecta \"(Skill.Arg2)\" dos veces"
  },
  Event_129219_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_129219_Desc = {
    Text = "El festival ha comenzado.\nBajo las llamas del Espíritu y las bendiciones de la sangre, innumerables Almas creyentes se han convertido en faros—\nLos espíritus etéreos se dispersan a tu alrededor como hadas guía, brillando y esperando tu elección."
  },
  Event_129219_Name = {
    Text = "Faro del alma"
  },
  Event_129220_ChoiceDesc1 = {
    Text = "[Ignorar la campana] Elige 1 de 3 Inscripciones avanzadas para grabar dos veces"
  },
  Event_129220_ChoiceDesc2 = {
    Text = "[Levantar el auricular]Obtén una reliquia de oro\"(RelicConfig.Arg1)\", infección\"(Skill.Arg2)\""
  },
  Event_129220_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_129220_Desc = {
    Text = "No debería haber sonado—el teléfono, acurrucado detrás del lienzo. \n El cable del auricular está enrollado alrededor del gran cuerpo de la máquina, como un cordón umbilical oxidado, que parece extenderse desde tu mente. \n Intentas discernir la frecuencia de la vibración, el extraño sonido es como el arte surrealista de Pickman."
  },
  Event_129220_Name = {
    Text = "Llamada perdida"
  },
  Event_129221_ChoiceDesc1 = {
    Text = "[Todos estamos a salvo] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infectar \"(Skill.Arg2)\" dos veces"
  },
  Event_129221_ChoiceDesc2 = {
    Text = "[¿Quién eres Tú?] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infectar \"(Skill.Arg2)\" dos veces"
  },
  Event_129221_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_129221_Desc = {
    Text = "La máquina de escribir escupe tinta de manera abrupta, con tantos signos de exclamación que resultan deslumbrantes. \n\"¿Doll, estás bien??? ¿Por qué el Guardián del secreto desapareció y tú también? ¡Por favor, envía un mensaje si estás a salvo! ¡Si seguimos esperando, el cabello de William se va a caer por completo!\""
  },
  Event_129221_Name = {
    Text = "Comunicación de emergencia"
  },
  Event_129222_ChoiceDesc1 = {
    Text = "[Cortar la cinta roja]eliminar 1 carta de comando, obtener Arg1 el sigilo negro"
  },
  Event_129222_ChoiceDesc2 = {
    Text = "[Confrontar]Copia 1 carta de comando, infecta con \"(Skill.Arg1)\""
  },
  Event_129222_ChoiceDesc3 = {
    Text = "[Llamar a Ramona] Elegir 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129222_Desc = {
    Text = "Casiah lanzó una cinta roja, que instantáneamente se enredó en tu maleta"
  },
  Event_129222_Name = {
    Text = "Seda entrelazada"
  },
  Event_129223_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129223_Name = {
    Text = "Olvido Capítulo 6@"
  },
  Event_129224_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129224_Name = {
    Text = "Capítulo 3 de las Estrellas@"
  },
  Event_129225_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129225_Name = {
    Text = "Olvido Capítulo 3@"
  },
  Event_129226_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129226_Name = {
    Text = "Olvido Capítulo 4@"
  },
  Event_129227_ChoiceDesc1 = {
    Text = "[Alejar con la mano] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infecta \"(Skill.Arg2)\" dos veces"
  },
  Event_129227_ChoiceDesc2 = {
    Text = "[dejar que permanezca]obtén reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_129227_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_129227_Desc = {
    Text = "Un sonido tenue emerge de la oscuridad.\nEs una mariposa, que pregunta cortésmente:\n\"¿Puedo descansar en tu palma?\"\n\"Estoy tan cansada... Deseo descansar un momento.\"\nMientras pregunta, la mariposa desciende en espiral hacia ti a través de la oscuridad.\nUn líquido negro y viscoso gotea de sus alas—un regalo de las sombras que atravesó."
  },
  Event_129227_Name = {
    Text = "Solicitud de la mariposa"
  },
  Event_129228_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129228_Name = {
    Text = "Olvido Capítulo 7@"
  },
  Event_129229_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129229_Name = {
    Text = "Olvido Capítulo 7@"
  },
  Event_129230_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129230_Name = {
    Text = "Olvido Capítulo 1@"
  },
  Event_129231_ChoiceDesc1 = {
    Text = "[identificar la letra]obtén la reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_129231_ChoiceDesc2 = {
    Text = "[Tararear suavemente] Grabar 1 de 3 Inscripciones dos veces"
  },
  Event_129231_Desc = {
    Text = "Un antiguo canto de barco resuena en el dominio.\nLos recuerdos atrapados en el dominio cantan en un idioma que nunca has oído, sobre las olas, el cielo y el licor"
  },
  Event_129231_Name = {
    Text = "Canción del mar"
  },
  Event_129232_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129232_Name = {
    Text = "Olvido Capítulo 8@"
  },
  Event_129233_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129233_Name = {
    Text = "Capítulo 1 de las Estrellas@"
  },
  Event_129234_ChoiceDesc1 = {
    Text = "[Cortar la palma] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infecta \"(Skill.Arg2)\" dos veces"
  },
  Event_129234_ChoiceDesc2 = {
    Text = "[Aceptar el crecimiento]obtén la reliquia de plata\"(RelicConfig.Arg1)\", infecta\"(Skill.Arg2)\""
  },
  Event_129234_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_129234_Desc = {
    Text = "La mariposa no vino volando, sino que creció lentamente desde tu palma. \n Al principio pensaste que era solo sudor, pero entre los dedos viste un líquido negro que brotaba silenciosamente como si fuera un vaso sanguíneo, solidificándose en alas frías y pulsantes. \n Cada aleteo provoca ondas en tu sangre."
  },
  Event_129234_Name = {
    Text = "Parásito de la alta sociedad"
  },
  Event_129235_ChoiceDesc1 = {
    Text = "[Seguir navegando] 1 Tarjeta de comando aleatoria obtiene Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129235_ChoiceDesc2 = {
    Text = "[Salir]aumenta Arg1 puntos de salud máxima, infecta\"(Skill.Arg2)\""
  },
  Event_129235_Desc = {
    Text = "Una balanza para pesar.\nDetrás de ella, numerosos órganos sumergidos en formalina roja.\nApilados ordenadamente en estantes.\nTomas un cuaderno cercano y lees:\n\"Corazón: 8 onzas, cerebro: 50 onzas...\""
  },
  Event_129235_Name = {
    Text = "Registro de órganos"
  },
  Event_129236_ChoiceDesc1 = {
    Text = "[Tomar un camino diferente]elimina 1 carta de comando, gana Arg1 el sigilo negro"
  },
  Event_129236_ChoiceDesc2 = {
    Text = "[Preguntar por qué se hundió]Copiar 1 carta de comando, infectar con \"(Skill.Arg1)\""
  },
  Event_129236_ChoiceDesc3 = {
    Text = "[Saludar a la tripulación] Elegir 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129236_Desc = {
    Text = "Mientras caminabas hacia la sala de poder, encontraste nuevamente algunos\"recuerdos\"fijados en el dominio.\nNo son fantasmas, solo son la preocupación del capitán Elton por sus difuntos tripulantes"
  },
  Event_129236_Name = {
    Text = "Dueño del Sonanir"
  },
  Event_129237_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129237_Name = {
    Text = "Olvido Capítulo 3@"
  },
  Event_129238_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129238_Name = {
    Text = "Capítulo 1 de las Estrellas@"
  },
  Event_129239_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129239_Name = {
    Text = "Olvido Capítulo 6@"
  },
  Event_129240_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129240_Name = {
    Text = "Olvido Capítulo 5@"
  },
  Event_129241_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129241_Name = {
    Text = "Capítulo 4 de las Estrellas@"
  },
  Event_129242_ChoiceDesc1 = {
    Text = "[Actuar para él] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infecta \"(Skill.Arg2)\" dos veces"
  },
  Event_129242_ChoiceDesc2 = {
    Text = "[Escuchar la melodía]Por cada Despertado con un valor de locura de 50 o más, obtén 15 sellos negros"
  },
  Event_129242_ChoiceDesc3 = {
    Text = "[Leave] Elige 1 de 3 Inscripciones para grabar dos veces"
  },
  Event_129242_Desc = {
    Text = "\"Querido John: \n    Recientemente me di cuenta de que han pasado varios años desde la última vez que nos deleitaste con tu interpretación al piano. \n    Este año tengo 81 años, y a medida que envejezco, más me doy cuenta del valor de los recuerdos de la juventud. \n    Si recibes esta carta, por favor, la próxima vez que pases por Londinium, detente frente a mi apartamento y ven a tocar una melodía.\""
  },
  Event_129242_Name = {
    Text = "Sonata de Lamento"
  },
  Event_129243_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129243_Name = {
    Text = "Capítulo 3 de las Estrellas@"
  },
  Event_129244_ChoiceDesc1 = {
    Text = "[Di que no tienes cartera] Grabar 1 de 3 Oraciones dos veces."
  },
  Event_129244_ChoiceDesc2 = {
    Text = "[Romper la red] 1 Tarjeta de comando aleatoria obtiene Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infectar \"(Skill.Arg2)\" dos veces"
  },
  Event_129244_Desc = {
    Text = "La red de color naranja brilla en el aire, fluyendo silenciosamente, con agujeros dispersos, lejos de ser tan delicada como la pariente lejana que habita en la esquina de la pared. \n No puedes evitar extender la mano para tocarla, la frágil red se disuelve instantáneamente, las risas de los niños resuenan en tus oídos. \n \"¡Los de oro, los de plata, los de amarillo y los de rojo, todos los billeteras son nuestras!\""
  },
  Event_129244_Name = {
    Text = "Red errante"
  },
  Event_129245_ChoiceDesc1 = {
    Text = "[Choose emotion] Restaura Arg1 puntos de vida"
  },
  Event_129245_ChoiceDesc2 = {
    Text = "[Mantener la razón] 1 Tarjeta de comando aleatoria obtiene la Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129245_ChoiceDesc3 = {
    Text = "[Refuse to choose] Obtén 25 El sigilo negro"
  },
  Event_129245_Desc = {
    Text = "\"Elige, elige.\"\nEn la oscuridad acelerada, innumerables susurros resonaron.\nLa voz es suavemente hipnótica, aparentemente llevando una magia infinita que induce un tipo de fantasma loco en ti.\nTu cerebro se hunde en la locura, retorciéndose lejos del cuerpo, mientras que el corazón parece haber desarrollado cierta conciencia, gritando y llamándote.\n\"Elige, elige.\"\n\"Mantén la racionalidad o la emoción; debes tomar una decisión.\""
  },
  Event_129245_Name = {
    Text = "El precio de la humanidad"
  },
  Event_129246_ChoiceDesc1 = {
    Text = "[Eliminar ofrenda]gana reliquia maldita\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_129246_ChoiceDesc2 = {
    Text = "[Desatar las cuerdas] Elegir 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129246_ChoiceDesc3 = {
    Text = "[Continuar avanzando]gana 50 el sigilo negro"
  },
  Event_129246_Desc = {
    Text = "Tres aram están atados en la plataforma.\nEn sus cuerpos aparecen patrones oscuros similares a la corteza que viste en bebés, murmuran rezos"
  },
  Event_129246_Name = {
    Text = "tres ofrendas"
  },
  Event_129247_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129247_Name = {
    Text = "Capítulo 3 de las Estrellas@"
  },
  Event_129248_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129248_Name = {
    Text = "Olvido Capítulo 6@"
  },
  Event_129249_ChoiceDesc1 = {
    Text = "[Luchar hacia adelante]Elimina 1 carta de comando, gana Arg1 el sigilo negro"
  },
  Event_129249_ChoiceDesc2 = {
    Text = "[Romper el hilo]Copiar 1 carta de comando, Infectar con\"(Skill.Arg1)\""
  },
  Event_129249_ChoiceDesc3 = {
    Text = "[Contenerse] Elegir 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129249_Desc = {
    Text = [[
A lo largo del camino, te empujan hacia adelante, todas tus decisiones son manipuladas por hilos invisibles.
Luchas por mover tus manos, intentando aferrarte a todo lo que te importa.
El destino del mundo cuelga frente a la yema de tus dedos.
Incontables hilos se entrelazan, atando todo tu ser]]
  },
  Event_129249_Name = {
    Text = "Manos Manipuladas"
  },
  Event_129250_ChoiceDesc1 = {
    Text = "[Pedir indicaciones] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infectar \"(Skill.Arg2)\" dos veces"
  },
  Event_129250_ChoiceDesc2 = {
    Text = "[Alejarse de él] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_129250_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_129250_Desc = {
    Text = "La sombra está de pie bajo una delgada farola. \n\"¿Te importaría prestarme un fuego, señor?\"\nNo tienes la costumbre de @2, pero no te importa usar un poco de \"magia\". \nCon tu ayuda, la sombra encenderá el @2 y lo introducirá en el vórtice negro sin fondo. \nEn poco tiempo, ves que un humo blanco comienza a emerger. \n\"Ah——\"\nLa sombra emite un suspiro de placer."
  },
  Event_129250_Name = {
    Text = "La sombra bajo la farola"
  },
  Event_129251_ChoiceDesc1 = {
    Text = "[ocupación]Texto temporal."
  },
  Event_129251_Name = {
    Text = "Olvido Capítulo 1@"
  },
  Event_129252_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129252_Name = {
    Text = "Olvido Capítulo 8@"
  },
  Event_129253_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129253_Name = {
    Text = "Olvido capítulo 3@"
  },
  Event_129254_ChoiceDesc1 = {
    Text = "[Aceptar el Espejismo] 1 Tarjeta de comando aleatoria obtiene Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infectar \"(Skill.Arg2)\" dos veces"
  },
  Event_129254_ChoiceDesc2 = {
    Text = "[Negar el Espejismo] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129254_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_129254_Desc = {
    Text = "Bajo el oscuro y pesado puente de hierro, en la orilla silenciosa llena de juncos, de repente vuela una mariposa brillante.\nLa mariposa se posa en tu mano, los gritos cesan, reemplazados por el rugido del tren sobre el hierro oxidado, el crepitar del carbón, el chirrido de los ejes"
  },
  Event_129254_Name = {
    Text = "Ilusión Ferroviaria"
  },
  Event_129255_ChoiceDesc1 = {
    Text = "[Elegir rechazar]elimina 1 carta de comando, obtén Arg1 sigilo negro"
  },
  Event_129255_ChoiceDesc2 = {
    Text = "[Elegir obedecer]Copiar 1 carta de comando, infectar\"(Skill.Arg1)\""
  },
  Event_129255_ChoiceDesc3 = {
    Text = "[Elegir abrazar] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129255_Desc = {
    Text = "\"Soy un pájaro enjaulado, encerrado en un patio lleno de muchas habitaciones.\"\nEn la oscuridad, se mueven sombras borrosas, son las obsesiones dejadas por los que han partido. \n\"Dicen que es un manicomio, pero yo sé que es una prisión especial para humanos, que encierra a los pájaros libres que no quieren seguir las reglas de la sociedad.\"\n\"Pero, ¿puede un pájaro ser llamado pájaro si no puede volar?\"\nLas obsesiones se acercan a ti, suplicando redención. \n\"Por favor, rompe mis alas, estoy cansado de volar.\""
  },
  Event_129255_Name = {
    Text = "Hombre hueco"
  },
  Event_129256_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129256_Name = {
    Text = "Capítulo 2 de Olvido@"
  },
  Event_129257_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129257_Name = {
    Text = "Capítulo 2 de las Estrellas@"
  },
  Event_129258_ChoiceDesc1 = {
    Text = "[Liberar la mariposa] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\" dos veces, pero desarrollar \"(Skill.Arg2)\" dos veces"
  },
  Event_129258_ChoiceDesc2 = {
    Text = "[convertirse en mariposa]Obtén una reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_129258_ChoiceDesc3 = {
    Text = "[tragarse] obtiene 25 el sigilo negro"
  },
  Event_129258_Desc = {
    Text = "Esta noche han sucedido demasiadas cosas. \n ATQ al muelle, barco fantasma, Marchador de mares, Tulu, Murphy, Ramona... Todo gira en un vórtice, mezclándose como la avena de las siete de la mañana en el restaurante Misaq. \n Quiero hacerle una pregunta al Despertado frente a mí, pero no sé cómo comenzar, como un nudo en la garganta—o mejor dicho, las mariposas en el estómago."
  },
  Event_129258_Name = {
    Text = "Efecto mariposa"
  },
  Event_129259_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129259_Name = {
    Text = "Olvido Capítulo 8@"
  },
  Event_129260_ChoiceDesc1 = {
    Text = "[Dejar que persista] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infectar \"(Skill.Arg2)\" dos veces"
  },
  Event_129260_ChoiceDesc2 = {
    Text = "[Aclarar]Recibe reliquia de plata\"(RelicConfig.Arg1)\"、infectar\"(Skill.Arg2)\""
  },
  Event_129260_ChoiceDesc3 = {
    Text = "[recibir a la mariposa]obtén 25 el sigilo negro"
  },
  Event_129260_Desc = {
    Text = "Ustedes deambulan por el sanatorio azotado por el frío, cuando una mariposa negra que no debería existir en esta temporada llega revoloteando. \nLas alas de la mariposa arrastran un líquido negro, volando de un lado a otro, el líquido se solidifica y se desmorona con el viento. \nCansada, se posa en la punta de tus dedos."
  },
  Event_129260_Name = {
    Text = "Algo que no debería existir"
  },
  Event_129261_ChoiceDesc1 = {
    Text = "[Revivir el pasado] Graba 1 de 3 Gravuras avanzadas dos veces."
  },
  Event_129261_ChoiceDesc2 = {
    Text = "[Mirar furtivamente el futuro]obtiene la creación de oro\"(RelicConfig.Arg1)\",infección\"(Skill.Arg2)\""
  },
  Event_129261_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_129261_Desc = {
    Text = "Nada en el mundo puede permanecer estático.\n Incluso el paraíso esculpido por la Diosa Madre no es una excepción.\n En un momento fugaz, vislumbras algo a través de las grietas del tiempo y del espacio.\n El pasado, el presente y el futuro se entrelazan en esa grieta agrietada, cambiando constantemente.\n Esperando tu curiosa mirada"
  },
  Event_129261_Name = {
    Text = "Fisura espacio-temporal"
  },
  Event_129262_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129262_Name = {
    Text = "Olvido Capítulo 7@"
  },
  Event_129263_ChoiceDesc1 = {
    Text = "[Ignorarlo] Elige 1 de 3 Inscripciones para grabar dos veces"
  },
  Event_129263_ChoiceDesc2 = {
    Text = "[Tocarlo] 1 Tarjeta de comando aleatoria obtiene la Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infecta \"(Skill.Arg2)\" dos veces"
  },
  Event_129263_Desc = {
    Text = "Cosas extrañas similares a esporas llaman tu atención.\nParecen delicadas medusas hechas de carne, o fibras nerviosas que albergan señales en lo profundo del cerebro.\n«Tócame», te tienta en silencio, «te mostraré una memoria cruel»."
  },
  Event_129263_Name = {
    Text = "Memoria Profunda"
  },
  Event_129264_ChoiceDesc1 = {
    Text = "[Entregarse a las fantasías] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infecta \"(Skill.Arg2)\" dos veces"
  },
  Event_129264_ChoiceDesc2 = {
    Text = "[Mantener la cordura] Por cada Cuerpo Despertado con un nivel de Aliemus de 50 o más, obtiene 15 marcas negras"
  },
  Event_129264_ChoiceDesc3 = {
    Text = "[Marcharse a la fuerza] Graba 1 de 3 Inscripciones dos veces."
  },
  Event_129264_Desc = {
    Text = "Quizás es la larga batalla que te ha hecho sentir desorientado, o quizás simplemente es que tu cerebro ha traicionado a tu cuerpo.\n Una sensación de ingravidez aparece en tu mente.\n En un instante, tu mente se transforma repentinamente en un caleidoscopio, brillantemente colorido, parpadeando con todos los matices de luz.\n Incontables ideas, reflexiones y fantasías inundan tu cerebro, ocupando cada rincón de las grietas de tu mente.\n Si esto continúa, tu cerebro pronto estallará debido a estos pensamientos caóticos."
  },
  Event_129264_Name = {
    Text = "Caleidoscopio de pensamiento"
  },
  Event_129265_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129265_Name = {
    Text = "Olvido Capítulo 5@"
  },
  Event_129266_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129266_Name = {
    Text = "Olvido Capítulo 4@"
  },
  Event_129267_ChoiceDesc1 = {
    Text = "[Listen] Grabar 1 de 3 Inscripciones avanzadas dos veces"
  },
  Event_129267_ChoiceDesc2 = {
    Text = "[gritar] obtiene reliquia de oro\"(RelicConfig.Arg1)\"， infección\"(Skill.Arg2)\""
  },
  Event_129267_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_129267_Desc = {
    Text = "Desde el accidente, no has recibido noticias de tu compañero. \n Incontables intentos de contacto se han perdido como piedras en el océano, sin ningún eco. \n En el momento en que ya habías perdido la esperanza, el comunicador de repente emitió un sonido. \n Abres la maleta y acercas el auricular a tu oído. \n \"Guardián del Secreto...\" \n En un estado de confusión, escuchas esa voz que has añorado, resonando a través de capas de vacío, distante."
  },
  Event_129267_Name = {
    Text = "Ecos de Pensamiento"
  },
  Event_129268_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129268_Name = {
    Text = "Olvido Capítulo 1@"
  },
  Event_129269_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129269_Name = {
    Text = "Capítulo 1 de las Estrellas@"
  },
  Event_129270_ChoiceDesc1 = {
    Text = "[Fuente del sabueso infernal]obtiene reliquia de oro\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_129270_ChoiceDesc2 = {
    Text = "[Concentrarse en el combate] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129270_Desc = {
    Text = "La silueta del sabueso infernal cambia.\nSu cuerpo conecta con las grietas de la pared, revelando una ilusión extraña"
  },
  Event_129270_Name = {
    Text = "desde el ángulo"
  },
  Event_129271_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129271_Name = {
    Text = "Olvido Capítulo 2@"
  },
  Event_129272_ChoiceDesc1 = {
    Text = "[Pegar el papel]obtienes reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_129272_ChoiceDesc2 = {
    Text = "[Read] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: [(EnchantConfig.Arg1)] dos veces"
  },
  Event_129272_ChoiceDesc3 = {
    Text = "[desecharlo]obtén 50 el sigilo negro"
  },
  Event_129272_Desc = {
    Text = "Una hoja de papel amarillento cae del manto de los Portadores de linternas. \n El papel está repleto de textos extraños, algunos parecen jeroglíficos, otros se levantan de manera extraña, algunos están superpuestos, solo unas pocas palabras son apenas legibles. \n El título es «@2 El nacimiento del Hijo Santo»"
  },
  Event_129272_Name = {
    Text = "Orden secreta · Parte inferior"
  },
  Event_129273_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129273_Name = {
    Text = "Olvido Capítulo 2@"
  },
  Event_129274_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129274_Name = {
    Text = "Capítulo 2 de las Estrellas@"
  },
  Event_129275_ChoiceDesc1 = {
    Text = "[Prepararse para la batalla] Elige 1 de 3 Tarjetas de comando para obtener la Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infecta \"(Skill.Arg2)\" dos veces"
  },
  Event_129275_ChoiceDesc2 = {
    Text = "[Intentar tomar un camino alternativo] gana 25 marcas negras"
  },
  Event_129275_Desc = {
    Text = "En las profundidades del Aequor, donde la luz de las estrellas cae, los Marchadores de Mares han estado en inactividad durante siglos. \n Las aguas infinitas han testificado su locura, han testificado su paciencia, y también han testificado su más profunda piedad hacia los dioses. \n Nadie puede detener la gran llegada de los dioses. \n Cualquier obstáculo se convertirá en cenizas bajo la ira de los Marchadores de Mares."
  },
  Event_129275_Name = {
    Text = "La Vigilia bajo las Estrellas"
  },
  Event_129276_ChoiceDesc1 = {
    Text = "[tocar algunas notas]Obtén una reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_129276_ChoiceDesc2 = {
    Text = "[Cerrar la tapa] Grabar 1 de 3 Oraciones dos veces"
  },
  Event_129276_Desc = {
    Text = "El piano junto a la pared tiene la tapa abierta. Tiene teclas amarillentas y bordes agrietados que muestran la madera, pero cada tecla está muy limpia.\nEs la fuente de alegría de muchas personas"
  },
  Event_129276_Name = {
    Text = "Melodía de la infancia"
  },
  Event_129277_ChoiceDesc1 = {
    Text = "[Aceptar el Espejismo] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infectar \"(Skill.Arg2)\" dos veces"
  },
  Event_129277_ChoiceDesc2 = {
    Text = "[negar ilusión] obtiene reliquia de plata\"(RelicConfig.Arg1)\"， infección\"(Skill.Arg2)\""
  },
  Event_129277_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_129277_Desc = {
    Text = "Bajo el oscuro y pesado puente de hierro, en la orilla silenciosa llena de juncos, de repente vuela una mariposa brillante.\nLa mariposa se posa en tu mano, los gritos cesan, reemplazados por el canto de los trabajadores moviendo vigas, el golpeteo de martillos, el sonido metálico de los remaches"
  },
  Event_129277_Name = {
    Text = "Ilusión del Puente de Acero"
  },
  Event_129278_ChoiceDesc1 = {
    Text = "[Mostrar la Maldición] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\" dos veces, infectar \"(Skill.Arg2)\" dos veces"
  },
  Event_129278_ChoiceDesc2 = {
    Text = "[Rechazar al cuervo] Grabar 1 de 3 Inscripciones dos veces"
  },
  Event_129278_ChoiceDesc3 = {Text = "[Ignorar]"},
  Event_129278_Desc = {
    Text = "Un cuervo negro y mórbido de múltiples cabezas salió volando de la capa negra de un creyente de la luz del templo y se posó en tu hombro. \n\"¿Ves mi cabeza? Si tan solo saboreas la maldición, haré crecer una nueva cabeza. ¡Déjame ver tu maldición!\""
  },
  Event_129278_Name = {
    Text = "Cuervo Maldito"
  },
  Event_129279_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129279_Name = {
    Text = "Olvido Capítulo 7@"
  },
  Event_129280_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129280_Name = {
    Text = "Olvido capítulo 3@"
  },
  Event_129281_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129281_Name = {
    Text = "Olvido Capítulo 4@"
  },
  Event_129282_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129282_Name = {
    Text = "Capítulo 2 del Olvido@"
  },
  Event_129283_ChoiceDesc1 = {
    Text = "[Ocupación]Texto temporal."
  },
  Event_129283_Name = {
    Text = "Capítulo 2 de las Estrellas@"
  },
  Event_129900_ChoiceDesc1 = {
    Text = "[Enterrar]Recuperar Arg2 puntos de vida [ExDesc1]. Elige 1 carta de comando para eliminar."
  },
  Event_129900_ChoiceDesc2 = {
    Text = "[Pray] Obtén la Creación de oro \"(RelicConfig.Arg1)\", pero desarrolla \"(Skill.Arg2)\"."
  },
  Event_129900_Desc = {
    Text = "Un fragmento de hueso pálido, la mitad sumergido en la disolución negra."
  },
  Event_129900_Name = {
    Text = "Huesos descoloridos"
  },
  Event_130337_ChoiceDesc1 = {
    Text = "[Tomar asiento] Mezclar [marioneta] en tu mazo."
  },
  Event_130337_Desc = {
    Text = "En el momento en que pones un pie en las escaleras del teatro, tu mirada ya nunca podrá apartarse de este escenario.\nLos hilos del destino arrastran incontables historias hacia su flujo vertiginoso aquí—el polvo del pasado, la luz parpadeante del presente y las brumas del futuro se agitan sin cesar sobre el escenario.\nHas olvidado tanto tu origen como tu destino. Todo vestigio del \"Yo\" se disuelve entre las sombras de los pesados telones. En esta hora, eres el espectador silencioso en la platea y el actor ardiente sobre las tablas.\nLa totalidad de tu existencia se reduce a dos únicos rastros: contemplar y actuar."
  },
  Event_130337_Name = {
    Text = "El Nivel del Destino"
  },
  Event_131264_ChoiceDesc1 = {Text = "[Salir]"},
  Event_131264_Desc = {
    Text = "Eliges el poder. Eliges la convicción inquebrantable y el coraje de seguir siempre adelante.\nPero el precio... El propósito mismo de un precio es ser pagado, ¿no es así?"
  },
  Event_131264_Name = {
    Text = "Mirada al pasado"
  },
  Event_131265_ChoiceDesc1 = {Text = "[Salir]"},
  Event_131265_Desc = {
    Text = "Soportando la agonía en tu mente, te aferras con fuerza a los fragmentos dentados que flotan a la deriva. Gracias a tu sombría perseverancia, las grietas comienzan a sanar.\nTe vas para recordar, y luchas para recordar. No dejarás que ningún recuerdo se escape."
  },
  Event_131265_Name = {
    Text = "Recuerdos Rotos"
  },
  Event_131266_ChoiceDesc1 = {
    Text = "[Proteger el recuerdo] Grabar 1 de 3 Oraciones"
  },
  Event_131266_ChoiceDesc2 = {
    Text = "[Sellar la grieta] Grabar la Oración \"(EnchantConfig.Arg1)\" en 1 de 3 Tarjetas de comando, pero desarrollar \"(Skill.Arg2)\""
  },
  Event_131266_Desc = {
    Text = "Nunca dudaste de tus recuerdos. Eran cálidos, resilientes—tu refugio más seguro y tu tesoro más preciado.\nPero ahora, bajo la interferencia del Abismo espiral, esos recuerdos comienzan a agrietarse y astillarse."
  },
  Event_131266_Name = {
    Text = "Recuerdos Rotos"
  },
  Event_131267_ChoiceDesc1 = {Text = "[Salir]"},
  Event_131267_Desc = {
    Text = "Una oleada de energía espiritual inunda tu mente, cosiendo los horribles desgarros. Con cada gramo de voluntad, restauras las fracturas hasta la integridad.\nTe vas para recordar, y luchas para recordar. No dejarás que ningún recuerdo se escape."
  },
  Event_131267_Name = {
    Text = "Recuerdos Rotos"
  },
  Event_131268_ChoiceDesc1 = {Text = "[Salir]"},
  Event_131268_Desc = {
    Text = [[
"Ooh... Jahahha!!"
Nadie entiende tu pregunta. Responden con llanto y risas estridentes.]]
  },
  Event_131268_Name = {
    Text = "Los Abandonados"
  },
  Event_131269_ChoiceDesc1 = {Text = "[Salir]"},
  Event_131269_Desc = {
    Text = "Les devuelves la mirada. Los hilos se agitan; tu mirada gentil atrae los recuerdos, envolviéndolos en un abrazo.\nObservas en silencio a la titiritera del destino. Si tuviera otra oportunidad, ¿qué elección haría?"
  },
  Event_131269_Name = {
    Text = "Mirada al pasado"
  },
  Event_131270_ChoiceDesc1 = {Text = "[Salir]"},
  Event_131270_Desc = {
    Text = "\"Ooh... Jahahha!!\"\nLos llantos y las risas se desvanecen, disolviéndose en el aire. Ningún alma se alza para hacerte daño—hace mucho que aprendieron a vivir sin ser vistos."
  },
  Event_131270_Name = {
    Text = "Los Abandonados"
  },
  Event_131271_ChoiceDesc1 = {
    Text = "[Mirada al recuerdo] Adquirir la Creación de oro \"(RelicConfig.Arg1)\", pero desarrollar \"(Skill.Arg2)\""
  },
  Event_131271_ChoiceDesc2 = {
    Text = "[Abandonar el recuerdo] Activar 2 Cuerpos Despertados aleatorios, pero desarrollar [(Skill.Arg1)] dos veces"
  },
  Event_131271_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_131271_Desc = {
    Text = "Dentro del recipiente de la chica, resuena el sonido de porcelana rompiéndose. Los recuerdos se liberan de sus contenedores, flotando hacia tu lado.\nCompañeros de juegos de la infancia, regalos de los padres, el capricho puro de las nubes y los pájaros, ideales tan prístinos como el cielo abierto... Todos los recuerdos abren los ojos, mirándote en silencio.\nPreguntan. Lloran. Esperan."
  },
  Event_131271_Name = {
    Text = "Mirada al pasado"
  },
  Event_131272_ChoiceDesc1 = {
    Text = "[Preguntar] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_131272_ChoiceDesc2 = {
    Text = "[Ignorar] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_131272_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_131272_Desc = {
    Text = "Lamentos penetrantes chirrían en tus oídos; ante ti, espíritus agonizantes se desgarran sus propios rostros y formas...\n¿Quiénes son? ¿Prisioneros del Abismo espiral? ¿Destinos desechados? ¿Ecos del pasado, quizás?"
  },
  Event_131272_Name = {
    Text = "Los Abandonados"
  },
  Event_133380_ChoiceDesc1 = {
    Text = "[Confirmar]"
  },
  Event_133380_Desc = {
    Text = "Te has acomodado en tu asiento de terciopelo, y las cortinas carmesí se abren con un susurro quedo.\nQuerido espectador, el escenario se alzará para cumplir cada una de tus expectativas.\nEl protagonista de esta obra ya ha tomado su posición."
  },
  Event_133380_Name = {
    Text = "El Nivel del Destino"
  },
  Event_141995_ChoiceDesc1 = {
    Text = "[Prueba sencilla] Elimina hasta 5 Cartas cualesquiera"
  },
  Event_141995_ChoiceDesc2 = {
    Text = "[Que él investigue] Elimina aleatoriamente 5 Tarjetas de comando y obtén la Reliquia Bendecida [(RelicConfig.Arg1)]."
  },
  Event_141995_ChoiceDesc3 = {
    Text = "[¿Pensamiento inverso?] Elige hasta dos Cuerpos Despertados y genera un mazo completo de sus Cartas básicas para añadirlo al mazo"
  },
  Event_141995_Desc = {
    Text = "Llegas a una plaza donde mucha gente pasa apresurada; quizás puedas encontrar algo interesante aquí.\nLlamas a la puerta de una habitación iluminada con una luz amarillenta y tenue, y una persona vestida como investigador asoma la cabeza. Ves numerosos instrumentos científicos desconocidos; él te toma del brazo, te hace sentar y afirma ser un \"evolucionista\". Con el rostro lleno de Fervor, te recomienda con insistencia sus \"métodos científicos\".\n\"¡Solo eliminando los redundantes e inútiles aspectos de la humanidad se alcanza la verdadera evolución!\""
  },
  Event_141995_Name = {
    Text = "El Evolucionista"
  },
  Event_141996_ChoiceDesc1 = {
    Text = "[Entrenamiento especial en ataque] Añade una Inscripción aleatoria a todos los Golpes Básicos que no tengan Inscripción"
  },
  Event_141996_ChoiceDesc2 = {
    Text = "[Entrenamiento especial en defensa] Añade una Inscripción aleatoria a todas las Defensas básicas que no tengan Inscripción"
  },
  Event_141996_ChoiceDesc3 = {
    Text = "[Entrenamiento especial sin límites] Añade una Inscripción aleatoria a 15 Tarjetas de comando aleatorias, obtén 5 Tarjetas de síntomas aleatorias"
  },
  Event_141996_Desc = {
    Text = "Llegas a una plaza donde mucha gente va y viene apresurada; quizás puedas encontrar algo interesante aquí.\nEl tintineo metálico resuena en el espacio abierto; varias personas se están desafiando mutuamente para mejorar sus habilidades marciales. Un joven vestido con una armadura antigua te nota y te lanza una espada, invitándote a entrenar junto a ellos."
  },
  Event_141996_Name = {
    Text = "Hora de entrenamiento especial"
  },
  Event_141997_ChoiceDesc1 = {
    Text = "[Apostar alto] 50% de probabilidad de obtener una Inscripción aleatoria y volver a apostar, 50% de probabilidad de obtener 75 Marca negra"
  },
  Event_141997_ChoiceDesc2 = {
    Text = "[Apostar bajo] 50% de probabilidad de obtener una Inscripción aleatoria y volver a apostar, 50% de probabilidad de obtener 75 Marca negra"
  },
  Event_141997_Desc = {
    Text = "El camarero mantiene su sonrisa invariable, levanta el cubilete de dados y un sonido nítido resuena en el Eco. Los demás jugadores hacen sus elecciones. \"Las Apuestas están cerradas\", dice, \"por favor, apuesten—\""
  },
  Event_141997_Name = {
    Text = "Casino bullicioso"
  },
  Event_141998_ChoiceDesc1 = {
    Text = "[Apostar honestamente] Elimina una Tarjeta de comando"
  },
  Event_141998_ChoiceDesc2 = {
    Text = "[Intentar hacer trampa] Elimina una Tarjeta de síntomas"
  },
  Event_141998_ChoiceDesc3 = {Text = "[Salir]"},
  Event_141998_Desc = {
    Text = "Llegas a un lugar extremadamente animado, donde todos lucen felicidad en el rostro y las luces de colores parpadean libremente, dejando sin espacio a la oscuridad de la noche. Por todas partes, los carteles anuncian: \"¡Bienvenido al carnaval! ¡Aquí los Sueños nunca tienen Fin, aquí la Alegría nunca cae el telón!\"\nArrastrado por la multitud, te ves empujado al interior de un lujoso edificio. El salón resplandece en oro, repleto de voces y del dulce aroma del vino que flota en el aire. Un dado rueda hasta tus pies, y un camarero con una sonrisa aduladora te dice que es señal de buena suerte. Movido por la curiosidad, das un paso adelante — quizás puedas lucirte en este juego."
  },
  Event_141998_Name = {
    Text = "Casino bullicioso"
  },
  Event_141999_ChoiceDesc1 = {
    Text = "[Permuta] Eliminar 1 Reliquia, 50% de Probabilidad de obtener 1 Creación de oro a elegir entre 3, 50% de Probabilidad de obtener 25 Marca negra"
  },
  Event_141999_ChoiceDesc2 = {Text = "[Salir]"},
  Event_141999_Desc = {
    Text = "Llegas a un lugar sumamente animado donde todos lucen felicidad en el rostro, y las luces de colores que parpadean sin cesar empujan a la noche hasta no dejarle espacio. Por todas partes, los carteles rezan: \"¡Bienvenido al carnaval! ¡Aquí los Sueños nunca tienen Fin, aquí la Alegría nunca cae el telón!\"\nEntre la multitud, un Mercader de ropa andrajosa pero con un paquete asombrosamente grande te hace señas. Da una palmada al bulto que lleva a su lado, se acerca y baja la voz para hacerte una Invitación de Permuta. La vieja bolsa de tela se mece suavemente al ritmo de sus palabras y de vez en cuando emite un crujido."
  },
  Event_141999_Name = {
    Text = "Mercader harapiento"
  },
  Event_142000_ChoiceDesc1 = {
    Text = "[Pedir un deseo] Consume el 50% de los PV actuales, obtén 2 Creaciones de oro aleatorias"
  },
  Event_142000_ChoiceDesc2 = {
    Text = "[Pedir un deseo con toda el alma] Consume el 99% de los PV actuales, obtén el Péndulo temporal [(RelicConfig.Arg2)]"
  },
  Event_142000_ChoiceDesc3 = {
    Text = "[Meter la mano al fondo del estanque] Obtén la Creación de oro [(RelicConfig.Arg1)]"
  },
  Event_142000_Desc = {
    Text = "El Viento sopla por el campo, todo está en silencio, Solo se escucha el susurro de los árboles.\nDe repente, escuchas el burbujeo de algo que fluye. Sigues el sonido y un intenso olor dulzón a Sangre te alcanza antes que nada. Por fin distingues el origen de ese sonido: es un estanque de los deseos, repleto de rojo, donde la Sangre de innumerables personas Surge en su Interior, Como Si algo bajo la superficie estuviera a punto de saltar.\nUna voz resuena en lo más profundo de tu corazón: \"Ofrece tu Sangre y yo te concederé mi favor.\""
  },
  Event_142000_Name = {
    Text = "Manantial de Sangre"
  },
  Event_142001_ChoiceDesc1 = {
    Text = "[Ofrenda sencilla] Elige eliminar 2 Reliquias, obtener la Creación Culpa [(RelicConfig.Arg1)]"
  },
  Event_142001_ChoiceDesc2 = {
    Text = "[Ofrenda devota] Elige eliminar 4 Reliquias, obtener la Reliquia Bendecida [(RelicConfig.Arg1)]"
  },
  Event_142001_ChoiceDesc3 = {
    Text = "[Tomar algo de la ofrenda sin que nadie lo sepa] Obtener la Creación de oro [(RelicConfig.Arg1)]"
  },
  Event_142001_Desc = {
    Text = "El Viento sopla por el campo, todo está en silencio, Solo se escucha el susurro de los árboles.\nSin darte cuenta, llegas ante un antiguo altar. Una enorme estatua te observa con La Mirada desde lo alto, Como Si quisiera arrebatarte algo de las manos. Ves que en la base del altar hay unas palabras borrosas grabadas: \"Lo ganado y lo perdido se equilibran\"."
  },
  Event_142001_Name = {
    Text = "Altar de ganancias y pérdidas"
  },
  Event_142002_ChoiceDesc1 = {
    Text = "[Experiencia gratuita] Mejora aleatoria de Arg2 Creación(es) de plata"
  },
  Event_142002_ChoiceDesc2 = {
    Text = "[Servicio estándar] Consume Arg1 Marca(s) negra: Mejora aleatoria de Arg2 Creación(es) de plata"
  },
  Event_142002_ChoiceDesc3 = {
    Text = "[Servicio de lujo] Consume Arg1 Marca(s) negra: Mejora aleatoria de Arg2 Creación(es) de plata"
  },
  Event_142002_Desc = {
    Text = "Llegas a una plaza donde mucha gente pasa apresurada; quizás puedas encontrar algo interesante aquí.\nUn pequeño edificio iluminado con una cálida luz se alza en silencio en un rincón de la plaza. Parece un club de lujo, pero el oscuro letrero colgado en la pared dice claramente: \"Este establecimiento solo sirve a existencias que no son seres biológicos.\""
  },
  Event_142002_Name = {
    Text = "Club Especial"
  },
  Event_142003_ChoiceDesc1 = {
    Text = "[Participar una vez] Obtén una Tarjeta de síntomas"
  },
  Event_142003_ChoiceDesc2 = {
    Text = "[Marcharse] Obtén 75 Marca negra"
  },
  Event_142003_Desc = {
    Text = "Llegas a un lugar extremadamente animado, donde todos lucen felicidad en el rostro y las luces de colores parpadean libremente, dejando sin espacio a la oscuridad de la noche. Por todas partes, los carteles anuncian: \"¡Bienvenido al carnaval! ¡Aquí los Sueños nunca tienen Fin, aquí la Alegría nunca cae el telón!\"\nNotas que al borde del Camino hay un puesto de sorteo rodeado de gente. La Mirada de Todos se concentra en el gran premio, completamente cubierto — el Vendedor ambulante proclama a voz en cuello su rareza, y la gente se apresura a participar."
  },
  Event_142003_Name = {
    Text = "Desafío de sorteo"
  },
  Event_142004_ChoiceDesc1 = {
    Text = "[Usarlo un momento]"
  },
  Event_142004_ChoiceDesc2 = {Text = "[Salir]"},
  Event_142004_Desc = {
    Text = "El viento sopla por el campo, todo está en silencio, solo se escucha el susurro de los árboles.\nDe repente, ves una vieja choza desvencijada; en el centro hay un yunque, y a su lado hay muchas armas de metal oxidadas. Parece ser una herrería abandonada hace mucho tiempo. Junto al yunque hay instrucciones detalladas de uso que te indican que puedes colocar Reliquias aquí para modificarlas."
  },
  Event_142004_Name = {Text = "Herrería"},
  Event_142005_ChoiceDesc1 = {
    Text = "[Apostar honestamente] Elimina una Tarjeta de comando"
  },
  Event_142005_ChoiceDesc2 = {
    Text = "[Intentar hacer trampa] Elimina una Tarjeta de síntomas"
  },
  Event_142005_ChoiceDesc3 = {Text = "[Salir]"},
  Event_142005_Desc = {
    Text = "Los Aplausos de los demás proclaman tu victoria. Entre el bullicio de las voces, finalmente tú también, como ellos, quedas embriagado en este extravagante Sueño donde todo está en juego. Miras las fichas en tu mano, Como Si fueran los compañeros más leales que te han traído gloria. Un Susurro emerge desde las profundidades de la mesa de juego, envuelto en una petición ambigua: \"hazlo de nuevo, gana una vez más.\""
  },
  Event_142005_Name = {
    Text = "Casino bullicioso"
  },
  Event_142013_ChoiceDesc1 = {
    Text = "[Apostar alto] 50% de probabilidad de obtener una Creación de plata aleatoria y volver a apostar, 50% de probabilidad de obtener 75 Marca negra y entrar en combate Élite"
  },
  Event_142013_ChoiceDesc2 = {
    Text = "[Apostar bajo] 50% de probabilidad de obtener una Creación de plata aleatoria y volver a apostar, 50% de probabilidad de obtener 75 Marca negra y entrar en combate Élite"
  },
  Event_142013_Desc = {
    Text = "El camarero mantiene su sonrisa invariable, levanta el cubilete de dados y un sonido nítido resuena en el Eco. Los demás jugadores hacen sus elecciones. \"Las Apuestas están cerradas\", dice, \"por favor, apuesten—\""
  },
  Event_142013_Name = {
    Text = "Casino bullicioso"
  },
  Event_142073_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142073_Desc = {
    Text = "El camarero levanta el cubilete de dados. En apenas unos segundos, el aire parece Estancarse. En el instante en que se revela la respuesta, escuchas gritos de alegría mezclados con lamentos. La suerte no te ha dado su Bendición; los dados que yacen en silencio sobre la mesa muestran el resultado contrario al tuyo. Echas un último vistazo alrededor, observas a esos apostadores enloquecidos por la Locura. Es hora de irse."
  },
  Event_142073_Name = {
    Text = "Casino bullicioso"
  },
  Event_142074_ChoiceDesc1 = {
    Text = "[Entrar en Batalla]"
  },
  Event_142074_Desc = {
    Text = "Mientras observas la mesa de juego con expectación, de repente sientes que alguien te sujeta el brazo con fuerza. Al alzar la vista, el Jefe del casino te mira desde arriba, dispuesto a expulsar a cualquier cliente que no respete las reglas. En un instante, todas las miradas se concentran en ti: asombradas, hostiles, regodeándose en tu desgracia... Te das cuenta de que quizás alguien puede hacer trampa muchas veces, pero Siempre Que sea descubierto una sola vez, la ruina total será inevitable."
  },
  Event_142074_Name = {
    Text = "Casino bullicioso"
  },
  Event_142103_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142103_Desc = {
    Text = "Logras escapar del casino por medios físicos, dejando atrás el estruendo de la multitud mientras aceleras el paso para alejarte — en cuanto al caos que has dejado, ya habrá alguien que se encargue de recogerlo."
  },
  Event_142103_Name = {
    Text = "Casino bullicioso"
  },
  Event_142105_ChoiceDesc1 = {
    Text = "[Volver a sacar] Obtener una Tarjeta de síntomas"
  },
  Event_142105_ChoiceDesc2 = {
    Text = "[Marcharse] Obtén 75 Marca negra"
  },
  Event_142105_Desc = {
    Text = "Lo intentas una vez, pero no pasa nada. Sin embargo, en el reverso de la tarjeta está escrito: \"La próxima vez será más fácil\"\n...¿Lo intentas de nuevo?"
  },
  Event_142105_Name = {
    Text = "Desafío de sorteo"
  },
  Event_142106_ChoiceDesc1 = {
    Text = "[Volver a sacar] Obtener una Tarjeta de síntomas"
  },
  Event_142106_ChoiceDesc2 = {
    Text = "[Marcharse] Obtén 75 Marca negra"
  },
  Event_142106_Desc = {
    Text = "Lo intentas una vez, pero no pasa nada. Sin embargo, en el reverso de la tarjeta está escrito: \"La próxima vez será más fácil\"\n...¿Lo intentas de nuevo?"
  },
  Event_142106_Name = {
    Text = "Desafío de sorteo"
  },
  Event_142107_ChoiceDesc1 = {
    Text = "[Volver a sacar] Obtener una Tarjeta de síntomas"
  },
  Event_142107_Desc = {
    Text = "Lo intentas una vez, pero no pasa nada. Sin embargo, en el reverso de la tarjeta está escrito: \"La próxima vez será más fácil\"\n...¿Lo intentas de nuevo?"
  },
  Event_142107_Name = {
    Text = "Desafío de sorteo"
  },
  Event_142108_ChoiceDesc1 = {
    Text = "[Volver a sacar] Obtener una Tarjeta de síntomas"
  },
  Event_142108_ChoiceDesc2 = {
    Text = "[Marcharse] Obtén 75 Marca negra"
  },
  Event_142108_Desc = {
    Text = "Lo intentas una vez, pero no pasa nada. Sin embargo, en el reverso de la tarjeta está escrito: \"La próxima vez será más fácil\"\n...¿Lo intentas de nuevo?"
  },
  Event_142108_Name = {
    Text = "Desafío de sorteo"
  },
  Event_142109_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142109_Desc = {
    Text = "Escuchando el latido de tu corazón, destapas el boleto de la rifa y unas deslumbrantes letras doradas saltan ante tus ojos. El Vendedor ambulante agita emocionado su campana y todos los transeúntes te lanzan miradas de envidia.\n\"¡El gran premio ha sido entregado!\""
  },
  Event_142109_Name = {
    Text = "Desafío de sorteo"
  },
  Event_142110_ChoiceDesc1 = {
    Text = "[Volver a sacar] Obtener una Tarjeta de síntomas"
  },
  Event_142110_ChoiceDesc2 = {
    Text = "[Marcharse] Obtén 75 Marca negra"
  },
  Event_142110_Desc = {
    Text = "Lo intentas una vez, pero no pasa nada. Sin embargo, en el reverso de la tarjeta está escrito: \"La próxima vez será más fácil\"\n...¿Lo intentas de nuevo?"
  },
  Event_142110_Name = {
    Text = "Desafío de sorteo"
  },
  Event_142118_ChoiceDesc1 = {
    Text = "[Permuta] Eliminar 1 Reliquia, 25% de Probabilidad de obtener 1 Péndulo temporal a elegir entre 3, 50% de Probabilidad de obtener 2 Creaciones de oro aleatorias, 25% de Probabilidad de obtener 25 Marca negra"
  },
  Event_142118_ChoiceDesc2 = {Text = "[Salir]"},
  Event_142118_Desc = {
    Text = "El Mercader toma el objeto que le entregas y lo examina una y otra vez a la luz de la luna, con los Ojos a punto de salírsele de las órbitas. Tras una larga espera, finalmente esboza una sonrisa y saca de su bolsa una caja de hierro oxidada. \"Vamos, ábrela, es la caja sorpresa más de moda ahora mismo.\"\nLa abres, pero descubres que en su Interior Solo hay unas cuantas Marcas Negras decepcionantes. El Mercader se frota las manos y, con ojos llenos de disculpa, te dice que puedes intentarlo una vez más."
  },
  Event_142118_Name = {
    Text = "Mercader harapiento"
  },
  Event_142119_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142119_Desc = {
    Text = "El Mercader toma el objeto que le entregas y lo examina una y otra vez a la luz de la luna, con los Ojos a punto de salírsele de las órbitas. Tras una larga espera, finalmente esboza una sonrisa y saca de su bolsa una caja de hierro oxidada. \"Vamos, ábrela, es la caja sorpresa más de moda ahora mismo.\"\nLa abres y en su Interior descansas algo."
  },
  Event_142119_Name = {
    Text = "Mercader harapiento"
  },
  Event_142120_ChoiceDesc1 = {
    Text = "[Permuta] Eliminar 1 Creación de oro, 50% de Probabilidad de obtener 1 Péndulo temporal a elegir entre 3, 50% de Probabilidad de obtener 1 Reliquia Bendecida a elegir entre 3"
  },
  Event_142120_ChoiceDesc2 = {Text = "[Salir]"},
  Event_142120_Desc = {
    Text = "Abres la caja sorpresa de nuevo, pero descubres que sigue sin haber lo que buscas. El Mercader se apresura a sonreír con disculpa y saca otra caja de hierro, que te ofrece con ambas manos.\n\"¡No te enfades, cliente! Te juro que esta vez habrá algo extraordinario...\" — dice con la boca, aunque a escondidas retira una mano y la extiende hacia ti — \"Por supuesto, un tesoro debe cambiarse por otro tesoro.\""
  },
  Event_142120_Name = {
    Text = "Mercader harapiento"
  },
  Event_142138_ChoiceDesc1 = {
    Text = "[Usarlo un momento]"
  },
  Event_142138_ChoiceDesc2 = {Text = "[Salir]"},
  Event_142138_Desc = {
    Text = "Lograste usar estas herramientas con éxito; aunque sufrieron algunos daños, parece que aún se pueden usar."
  },
  Event_142138_Name = {Text = "Herrería"},
  Event_142139_ChoiceDesc1 = {
    Text = "[Fragmentar y fundir] Elige 1 Creación de oro para eliminar, obtén 2 Creaciones de plata y 50 Marcas negras"
  },
  Event_142139_ChoiceDesc2 = {
    Text = "[Templar] Elige 2 Reliquias para eliminar, obtén la Creación de oro [(RelicConfig.Arg1)]."
  },
  Event_142139_ChoiceDesc3 = {
    Text = "[Templado avanzado] Elige 2 Creaciones de oro para eliminar, obtén el Péndulo temporal [(RelicConfig.Arg1)]."
  },
  Event_142139_Desc = {
    Text = "Tomaste el martillo que estaba a un lado y te dispusiste a..."
  },
  Event_142139_Name = {Text = "Herrería"},
  Event_142140_ChoiceDesc1 = {
    Text = "[Usarlo un momento]"
  },
  Event_142140_ChoiceDesc2 = {Text = "[Salir]"},
  Event_142140_Desc = {
    Text = "Lograste usar estas herramientas con éxito; aunque sufrieron algunos daños, parece que aún se pueden usar."
  },
  Event_142140_Name = {Text = "Herrería"},
  Event_142141_ChoiceDesc1 = {
    Text = "[Fragmentar y fundir] Elige 1 Creación de oro para eliminar, obtén 2 Creaciones de plata y 50 Marcas negras"
  },
  Event_142141_ChoiceDesc2 = {
    Text = "[Templar] Elige 2 Reliquias para eliminar, obtén la Creación de oro [(RelicConfig.Arg1)]."
  },
  Event_142141_ChoiceDesc3 = {
    Text = "[Templado avanzado] Elige 2 Creaciones de oro para eliminar, obtén el Péndulo temporal [(RelicConfig.Arg1)]."
  },
  Event_142141_Desc = {
    Text = "Tomaste el martillo que estaba a un lado y te dispusiste a..."
  },
  Event_142141_Name = {Text = "Herrería"},
  Event_142142_ChoiceDesc1 = {
    Text = "[Fragmentar y fundir] Elige 1 Creación de oro para eliminar, obtén 2 Creaciones de plata y 50 Marcas negras"
  },
  Event_142142_ChoiceDesc2 = {
    Text = "[Templar] Elige 2 Reliquias para eliminar, obtén la Creación de oro [(RelicConfig.Arg1)]."
  },
  Event_142142_ChoiceDesc3 = {
    Text = "[Templado avanzado] Elige 2 Creaciones de oro para eliminar, obtén el Péndulo temporal [(RelicConfig.Arg1)]."
  },
  Event_142142_Desc = {
    Text = "Tomaste el martillo que estaba a un lado y te dispusiste a..."
  },
  Event_142142_Name = {Text = "Herrería"},
  Event_142167_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142167_Desc = {
    Text = "Tras tres usos, el yunque quedó completamente hundido y el martillo lleno de desgaste; parece que ya no se pueden usar más."
  },
  Event_142167_Name = {Text = "Herrería"},
  Event_142235_ChoiceDesc1 = {
    Text = "[Seguiré Adelante] Obtén \"Inmaculidad\"—todas las Tarjetas de comando reciben 20 Acumulaciones permanentes de Refuerzo."
  },
  Event_142235_ChoiceDesc2 = {
    Text = "[No Daré Marcha Atrás] Obtén \"Sublimación\"—la Keyflare y el Límite de locura disminuyen permanentemente un 20%."
  },
  Event_142235_Desc = {
    Text = "De repente, una niebla cubre tu visión, el mundo comienza a volverse borroso y, en un estado de ensoñación, una voz resuena en el fondo de tu corazón:\n\"¿Seguirás avanzando?\""
  },
  Event_142235_Name = {
    Text = "La Estación Final se Acerca"
  },
  Event_142925_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142925_Desc = {
    Text = "El personal del club acepta el pago y te brinda el servicio básico. Llevan los objetos que les entregaste a un compartimento oscuro; la espera no es larga, y cuando reaparece, los objetos ya están de vuelta en la bandeja, aunque parecen algo distintos a como eran antes."
  },
  Event_142925_Name = {
    Text = "Club Especial"
  },
  Event_142926_ChoiceDesc1 = {
    Text = "[Eliminar una Creación de oro] (Se requiere tener una Creación de oro)"
  },
  Event_142926_ChoiceDesc2 = {
    Text = "[Hay Reliquias con Mejorar (Forged) disponibles para elegir]"
  },
  Event_142926_ChoiceDesc3 = {Text = "[Salir]"},
  Event_142926_Desc = {
    Text = "Prueba de \"cantidad de Reliquias\" \"lista de selección de Reliquias\""
  },
  Event_142927_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142927_Desc = {
    Text = "El personal del club acepta el pago y te brinda el servicio de lujo. Con solemnidad, colocan tus objetos en una caja y la llevan a un compartimento oscuro. Esperas largo tiempo, hasta que él vuelve a aparecer y te entrega los objetos con ambas manos, con su expresión habitualmente tranquila."
  },
  Event_142927_Name = {
    Text = "Club Especial"
  },
  Event_142928_ChoiceDesc1 = {
    Text = "[Seleccionar hasta 2 Despertados para llenar su Alienación]"
  },
  Event_142928_ChoiceDesc2 = {
    Text = "[Se deben seleccionar 2 Cuerpos Despertados llenos de Alienación]"
  },
  Event_142928_ChoiceDesc3 = {Text = "[Salir]"},
  Event_142928_Desc = {
    Text = "Prueba de \"selección condicional de Despertado\""
  },
  Event_142929_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142929_Desc = {
    Text = "El investigador da vueltas y más vueltas a tu alrededor, observándote detenidamente durante un buen rato antes de ponerse a trabajar —sin consultarte en ningún momento. Pasado un tiempo, cuando te preparas para abandonar ese extraño laboratorio, sabes claramente que has perdido mucho, pero él aplaude y te felicita: \"¡Este es el verdadero significado de la evolución!\""
  },
  Event_142929_Name = {
    Text = "El Evolucionista"
  },
  Event_142930_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142930_Desc = {
    Text = "Extendiste la mano y la introdujiste en las aguas carmesí del estanque, palpando algo útil en el fondo."
  },
  Event_142930_Name = {
    Text = "Manantial de Sangre"
  },
  Event_142931_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142931_Desc = {
    Text = "La voz se aleja, tu corazón se llena de determinación y sientes que la Fortaleza hace Aparición."
  },
  Event_142931_Name = {
    Text = "La Estación Final se Acerca"
  },
  Event_142932_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142932_Desc = {
    Text = "La voz se aleja, tu corazón se llena de determinación y tu mente se vuelve más lúcida."
  },
  Event_142932_Name = {
    Text = "La Estación Final se Acerca"
  },
  Event_142933_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142933_Desc = {
    Text = "Tomas un poco de entre el montón de ofrendas apiladas Como Si fuera una montaña y te escabulles rápidamente. Al alejarte, los ojos de la estatua parecen haberse movido."
  },
  Event_142933_Name = {
    Text = "Altar de ganancias y pérdidas"
  },
  Event_142934_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142934_Desc = {
    Text = "Has entrenado enfocándote en la Defensa, y ante la Emboscada de tu oponente, has bloqueado repetidamente con tu arma, mejorando tu capacidad defensiva y tus reflejos."
  },
  Event_142934_Name = {
    Text = "Hora de entrenamiento especial"
  },
  Event_142935_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142935_Desc = {
    Text = "El investigador se pone guantes, toma algunos instrumentos de formas extrañas del armario y los agita frente a ti. No sabes exactamente qué hizo, pero parece que en efecto te sientes algo más aliviado."
  },
  Event_142935_Name = {
    Text = "El Evolucionista"
  },
  Event_142936_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142936_Desc = {
    Text = "No elegiste una dirección específica, sino que practicaste con otros sin importar los límites de tu cuerpo, hasta que Todos quedaron agotados. Sabes que has mejorado considerablemente, pero igualmente, has pagado un precio por ello."
  },
  Event_142936_Name = {
    Text = "Hora de entrenamiento especial"
  },
  Event_142937_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142937_Desc = {
    Text = "Tomas algunas cosas al azar de tu bolsa para ofrendar y recibes una recompensa equivalente."
  },
  Event_142937_Name = {
    Text = "Altar de ganancias y pérdidas"
  },
  Event_142938_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142938_Desc = {
    Text = "Presentas algunas ofrendas preciosas y recibes una recompensa equivalente."
  },
  Event_142938_Name = {
    Text = "Altar de ganancias y pérdidas"
  },
  Event_142939_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142939_Desc = {
    Text = "Estás lleno de dudas sobre sus métodos de investigación, y tras un largo debate, él acepta dejarte usar los instrumentos por tu cuenta para buscar la \"evolución\" a tu manera.\nCon las mismas herramientas, sin embargo, por pura casualidad logras que aquello que debía ser \"eliminado\" se \"multiplique\" en gran cantidad, y antes de irte, escuchas los lamentos del investigador."
  },
  Event_142939_Name = {
    Text = "El Evolucionista"
  },
  Event_142940_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142940_Desc = {
    Text = "El trabajador del club te ofrece el servicio gratuito. Lleva los objetos que le entregaste a un compartimento oscuro y, momentos después, regresa, te los devuelve en la mano y no dice ni una palabra."
  },
  Event_142940_Name = {
    Text = "Club Especial"
  },
  Event_142941_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142941_Desc = {
    Text = "Ofreciste una gran cantidad de sangre al estanque de los deseos, y un preciado regalo emergió desde sus profundidades."
  },
  Event_142941_Name = {
    Text = "Manantial de Sangre"
  },
  Event_142942_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142942_Desc = {
    Text = "Has entrenado enfocándote en el ataque, y en el choque del acero, tus habilidades de golpear y tu velocidad han mejorado."
  },
  Event_142942_Name = {
    Text = "Hora de entrenamiento especial"
  },
  Event_142943_ChoiceDesc1 = {Text = "[Salir]"},
  Event_142943_Desc = {
    Text = "Ofreciste un poco de sangre al estanque de los deseos, y un regalo emergió desde sus profundidades."
  },
  Event_142943_Name = {
    Text = "Manantial de Sangre"
  },
  Event_142944_ChoiceDesc1 = {
    Text = "[Elegir Reliquia para Mejorar]"
  },
  Event_142944_ChoiceDesc2 = {
    Text = "[Mejorar Reliquia aleatoriamente]"
  },
  Event_142944_ChoiceDesc3 = {
    Text = "[Salir (prueba)]"
  },
  Event_142944_Desc = {
    Text = "Prueba de \"función de Mejora de Reliquia\", la Reliquia se añade sola"
  },
  Event_146258_ChoiceDesc1 = {
    Text = "[Llamarle] Ganar Criatura maldita \"(RelicConfig.Arg1)\", Infectar \"(Skill.Arg2)\""
  },
  Event_146258_ChoiceDesc2 = {
    Text = "[Responderles] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_146258_ChoiceDesc3 = {
    Text = "[Ignorar] Obtiene 50 Marcas negras"
  },
  Event_146258_Desc = {
    Text = "Sobre el altar, las vestiduras blancas de Juliette están bañadas en un humo espeso, la ceniza del incienso mezclada con un aroma dulce y cobrizo.\n\n\"La Portadora de Luz compadece a los hijos pecadores de este mundo...\" su voz no es alta, pero corta con claridad el murmullo de las oraciones del templo, \"...como una madre amorosa compadece al infante en sus brazos.\"\n\nBajo la luz de las velas, las ofrendas sobre el altar brillan grasientas. Volutas de humo azul se retuercen hacia arriba siguiendo sus contornos, difuminando los rostros de la multitud abajo.\n\nA través de esa neblina oscilante, diriges la mirada hacia Pollux. Está entre la congregación, con los ojos bajos, su rostro portando una piedad ensayada y obediente a la perfección."
  },
  Event_146258_Name = {
    Text = "Un Viejo Sueño: III"
  },
  Event_146259_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146259_Desc = {
    Text = "No le prestes atención. Es solo el aullido del viento nevado, el suspiro del lago helado, o el lamento de las cumbres.\n\nSon las ramas secas y muertas susurrando al rozarse entre sí.\n\nMurmuran en un duelo eterno y melancólico por cada pionero que alguna vez murió en las grietas heladas."
  },
  Event_146259_Name = {
    Text = "Aria del Lago Helado"
  },
  Event_146260_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146260_Desc = {
    Text = "Si la justicia significa paridad absoluta, ¿comparte Helot: Catena tu derecho a pedir un deseo?\n\nDe ser así, ¿deberías simplemente encogerte de hombros ante el hecho de que te haya adelantado y eliminado a la competencia?\n\n\"¡Deja de soñar despierto y sigue escalando!\" La voz de Caraboo retumba en tu oído."
  },
  Event_146260_Name = {
    Text = "Equidad Absurda"
  },
  Event_146261_ChoiceDesc1 = {
    Text = "[La Montaña Teme el Hambre]"
  },
  Event_146261_ChoiceDesc2 = {
    Text = "[La Montaña Teme la Pérdida]"
  },
  Event_146261_ChoiceDesc3 = {
    Text = "[La Montaña Teme la Muerte]"
  },
  Event_146261_Desc = {
    Text = "Caminas sobre el cuerpo de la montaña. Sus estremecimientos traicionan sus secretos. Lo que la montaña anhela define lo que la montaña teme."
  },
  Event_146261_Name = {
    Text = "Secreto de la Montaña"
  },
  Event_146262_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146262_Desc = {
    Text = "Te pierdes en la seda de su pelaje, cautivo voluntario de tus propios deseos. Acariciar al gato resulta tan satisfactorio. ¿Qué importa lo que haya bajo la piel? ¿Acaso importa de verdad?"
  },
  Event_146262_Name = {
    Text = "El Gato Negro Reptante"
  },
  Event_146263_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146263_Desc = {
    Text = "Tomas en silencio el extremo del hilo y lo atas alrededor de tu muñeca.\n\nPollux hace lo mismo. Pronto, una fina línea roja une a los dos.\n\nLimita cuánto terreno podéis cubrir, pero siempre estuvisteis destinados a vivir y morir juntos, ¿verdad?\n\nDejarás que el destino se encargue del resto."
  },
  Event_146263_Name = {
    Text = "Un Viejo Sueño: I"
  },
  Event_146264_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146264_Desc = {
    Text = "\"Sé que es difícil, pequeño. Por supuesto que lo sé. Pero el mundo nunca ha sido un lugar amable para ninguno de nosotros.\"\n\n\"Un día, la mariposa escapará de tu palma, y se habrá ido para siempre.\""
  },
  Event_146264_Name = {
    Text = "Ilusión, No Verdad"
  },
  Event_146265_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146265_Desc = {
    Text = "William levanta la vista, su mirada te roza antes de posarse en las crestas cargadas de nieve a lo lejos.\n\n\"No tienes nada de qué disculparte,\" dice en voz baja, pero con firmeza. \"Algunas preguntas me pertenecen solo a mí, y solo yo puedo responderlas.\"\n\n\"Pero gracias. Por tu aguda mirada."
  },
  Event_146265_Name = {
    Text = "Inmersión Suave"
  },
  Event_146266_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146266_Desc = {
    Text = "Los ojos de William parpadean.\n\nAbres la boca, pero decides no decir nada. El silencio es la mejor opción aquí. Todavía existe una comprensión mutua, rara y silenciosa entre los dos; no hay necesidad de arruinarla."
  },
  Event_146266_Name = {
    Text = "Inmersión Suave"
  },
  Event_146267_ChoiceDesc1 = {
    Text = "[Salir]obtiene reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_146267_Desc = {
    Text = "\"¡Devuélvelo, devuélvelo! ¡Ese es mi poder!\"\n\nLa montaña llora; la montaña se lamenta. No puede soportar que le arrebaten todo lo que alguna vez poseyó."
  },
  Event_146267_Name = {
    Text = "Secreto de la Montaña"
  },
  Event_146268_ChoiceDesc1 = {
    Text = "[Seguir corriendo] Graba la Inscripción \"(EnchantConfig.Arg1)\" en 1 de 3 Tarjetas de comando, pero desarrolla \"(Skill.Arg2)\""
  },
  Event_146268_ChoiceDesc2 = {
    Text = "[Esperar el momento] Obtén 1 de 3 Inscripciones"
  },
  Event_146268_ChoiceDesc3 = {
    Text = "[Escabullirse lentamente]"
  },
  Event_146268_Desc = {
    Text = "\"Cuidado, Castor. El cuervo está mirando.\"\n\nAvanzas a toda prisa, con Pollux a tu espalda. Sus ojos en pánico recorren cada rincón oscuro, sin encontrar nada.\n\n\"¡Arriba!\"\n\nUn escalofrío repentino te recorre. Alzas la vista.\n\nAgazapado en silencio a la sombra del alero hay un cuervo. Grotescos ojos cubren su cuerpo, mirando en todas direcciones, concentrando ahora su mirada por completo en los dos."
  },
  Event_146268_Name = {
    Text = "Un Viejo Sueño: II"
  },
  Event_146269_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146269_Desc = {
    Text = "Recuerdas las advertencias de tu entrenamiento: nunca confíes del todo en la cuerda de seguridad.\n\nImpulsándote contra la roca escarpada, logras desesperadamente controlar tu descenso. Pero algo se escapa de tu mochila y cae rodando por el precipicio hasta convertirse en un punto diminuto e invisible.\n\nNo importa. Al menos estás vivo."
  },
  Event_146269_Name = {
    Text = "Caída Silenciosa"
  },
  Event_146270_ChoiceDesc1 = {
    Text = "[Escuchar con atención]obtener reliquia de plata\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_146270_ChoiceDesc2 = {
    Text = "[Taparse los oídos] obtiene el sello de elegir 3"
  },
  Event_146270_Desc = {
    Text = "El viento y la nieve azotan la pared rocosa, mezclándose con el tenue y espectral crujido que surge desde las profundidades del hielo, fragmentándose en una serie de suspiros llorosos.\n\nSolo en las silenciosas alturas, de repente escuchas la melodía de la montaña.\n\nEs desolada y solemne—un canto grave y profundo destinado únicamente a los muertos."
  },
  Event_146270_Name = {
    Text = "Fantasía de la Naturaleza"
  },
  Event_146271_ChoiceDesc1 = {
    Text = "[Es la Campana] Desarrolla \"(Skill.Arg1),\" graba la Inscripción \"(EnchantConfig.Arg2)\" en 1 Tarjeta de comando aleatoria"
  },
  Event_146271_ChoiceDesc2 = {
    Text = "[Es la Comida] Desarrolla \"(Skill.Arg1),\" graba la Inscripción \"(EnchantConfig.Arg2)\" en 1 Tarjeta de comando aleatoria"
  },
  Event_146271_ChoiceDesc3 = {
    Text = "[Es la Anticipación del Perro] Graba la Inscripción \"(EnchantConfig.Arg1)\" en 1 Tarjeta de comando aleatoria"
  },
  Event_146271_Desc = {
    Text = "\"Pavlov toca la campana y luego alimenta al perro. Con el tiempo, el mero tañido de la campana provoca la salivación del perro.\"\n\n\"Entonces. ¿Qué es lo que realmente hace salivar al perro?\""
  },
  Event_146271_Name = {
    Text = "Reflejo Pavloviano"
  },
  Event_146272_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146272_Desc = {
    Text = "No mires atrás. William está justo ahí, al alcance de la mano. No dejes que el dolor te consuma. Te has perdido mucho, pero aún puedes enmendar esto."
  },
  Event_146272_Name = {
    Text = "Desde la Otra Orilla"
  },
  Event_146273_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146273_Desc = {
    Text = "\"Cierra la mano.\"\n\n\"Lo que una vez fue exquisito se disolverá en nada más que cieno negro entre tus dedos.\""
  },
  Event_146273_Name = {
    Text = "Ilusión, No Verdad"
  },
  Event_146274_ChoiceDesc1 = {
    Text = "[¡Oye! ¡Da la vuelta!] Obtén 50 Marcas negras"
  },
  Event_146274_ChoiceDesc2 = {
    Text = "[Acariciar al gato] Obtén 75 Marcas negras, pero desarrolla \"(Skill.Arg2)\""
  },
  Event_146274_Desc = {
    Text = [[
<Italic:"Miau."> Un gato negro de brillantes ojos jade frota su cabeza contra tu espinilla con pasos suaves y silenciosos.

En ese momento, te das cuenta de que "N" ha desaparecido.]]
  },
  Event_146274_Name = {
    Text = "El Gato Negro Reptante"
  },
  Event_146275_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146275_Desc = {
    Text = "No emites ningún sonido. Simplemente dejas que tu mirada se deslice a través de la neblina y se pose en los ojos de Pollux, negándote a apartar la vista.\n\nÉl tampoco esquiva tu mirada. Tu hermano siempre fue así—terco hasta la médula, negándose a ser el primero en inclinar la cabeza.\n\nEl canto en el salón, el olor a ceniza, el sermón de Juliette sobre la misericordia y el sacrificio... de repente, todo se desvanece a lo lejos. Es como si solo quedaran los dos, mirándose el uno al otro a través de este salón de compasión vacía, a través del vasto transcurso del tiempo."
  },
  Event_146275_Name = {
    Text = "Un Viejo Sueño: III"
  },
  Event_146276_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146276_Desc = {
    Text = "En este momento, eres el único guardián de tus largos y pálidos recuerdos.\n\nEl Wendigo extiende sus garras como ramas, apuntando directo a tu corazón, pero lo rechazas con pura fuerza de voluntad.\n\nTropiezan, retrocediendo hacia la niebla devoradora, dejando solo un susurro seco y rasposo:\n\n\"Tarde o temprano, me los ofrecerás... y lo harás de buen grado.\""
  },
  Event_146276_Name = {
    Text = "El Devorador"
  },
  Event_146277_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146277_Desc = {
    Text = "Es un sueño lejano. Un sueño de tu infancia.\n\n\"Despierta\", te recuerdas a ti mismo. \"Ya no estamos ahí.\"\n\nVuelves a la realidad, solo para encontrarte de pie en la nieve helada, rodeado por un círculo de cultistas, con la hoja de Pollux apuntando directamente a tu pecho."
  },
  Event_146277_Name = {
    Text = "Un Viejo Sueño: I"
  },
  Event_146278_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146278_Desc = {
    Text = "\"Acepto que la muerte ha de llegar.\"\n\n\"Ofrezco voluntariamente mis huesos a esta ardua peregrinación.\"\n\n\"Bajo el precipicio, el cielo y la tierra forjarán mi monumento.\""
  },
  Event_146278_Name = {
    Text = "Presagio de Muerte"
  },
  Event_146279_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146279_Desc = {
    Text = "Un reflejo no es más que un juego de la luz. Lo que Tinct vio probablemente era solo su propia sombra.\n\nSu planeta natal está a millones de años luz de distancia; el más mínimo error de navegación los habría dispersado por distintas galaxias. Consolándote con estos pensamientos, dejas de obsesionarte con lo que yace bajo tus pies."
  },
  Event_146279_Name = {
    Text = "El Reflejo Sumergido"
  },
  Event_146280_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146280_Desc = {
    Text = "Proviene de las estrellas. Del profundo amanecer de los tiempos. De cosas que la humanidad aún no conoce, y quizás nunca conocerá.\n\nNo les pidas respuestas a Ellos.\n\nNo conoces el precio."
  },
  Event_146280_Name = {
    Text = "Aria del Lago Helado"
  },
  Event_146281_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146281_Desc = {
    Text = "Te detienes, dejando que esa música lúgubre llene tus oídos.\n\nEl viento es un violín, la nieve cortante un redoble de tambor, y el rugido lejano del hielo al quebrarse una armonía grave y largamente reprimida.\n\nNo puedes descifrar su tema, pero sabes que, ya sea en el pasado o en el futuro, seguirá sonando sin cesar para los innumerables viajeros enterrados aquí."
  },
  Event_146281_Name = {
    Text = "Fantasía de la Naturaleza"
  },
  Event_146283_ChoiceDesc1 = {
    Text = "[Ojos al Cielo] Todos los Despertados recuperan Arg1 de Alienación"
  },
  Event_146283_ChoiceDesc2 = {
    Text = "[Camina por la Cima Helada] Elige Activar a 2 Despertados"
  },
  Event_146283_Desc = {
    Text = "La cima reluce en silencio tras un velo de nubes y niebla. Los abismos, las escarpadas paredes de roca, las tormentas aullantes... nada de lo que mora aquí fue concebido jamás para ojos mortales. Ante todo ello, eres terriblemente frágil."
  },
  Event_146283_Name = {
    Text = "Tocando la Cima"
  },
  Event_146284_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146284_Desc = {
    Text = "\"No, no es tu culpa. No eres más que un juguete de cuerda, dado cuerda por el destino.\""
  },
  Event_146284_Name = {
    Text = "Rata Glotona"
  },
  Event_146285_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146285_Desc = {
    Text = "\"Ya veo. Eres de los que se apoyan en la experiencia objetiva. Pero no olvides: a veces, bajo superficies idénticas, yacen enroscadas verdades completamente distintas.\"\n\nLa risa de la campana se desvanece en la distancia."
  },
  Event_146285_Name = {
    Text = "Reflejo Pavloviano"
  },
  Event_146286_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146286_Desc = {
    Text = "Si la justicia significa que el bien y el mal reciben su merecido, ¿quién ejerce de juez?\n\n¿Anubis y su balanza? Si la gravedad del inframundo obedece las leyes de la física, no estás especialmente seguro de que tu corazón sea más ligero que su pluma."
  },
  Event_146286_Name = {
    Text = "Equidad Absurda"
  },
  Event_146287_ChoiceDesc1 = {
    Text = "[Exigir respuestas] Obtener Creación de plata \"(RelicConfig.Arg1)\", desarrollar \"(Skill.Arg2)\""
  },
  Event_146287_ChoiceDesc2 = {
    Text = "[Guardar silencio] Obtener Creación de plata \"(RelicConfig.Arg1)\", desarrollar \"(Skill.Arg2)\""
  },
  Event_146287_ChoiceDesc3 = {
    Text = "[Disculparse] Ganar 25 Marcas negras"
  },
  Event_146287_Desc = {
    Text = "\"Senior William, cuando el hechizo del Wendigo se apoderó de todos los demás, usted pareció ser el primero en salir de él. Estamos a punto de enfrentarlos directamente. ¿Algún consejo?\n\"\nLos ojos de William parpadean. En ellos, atrapas un fugaz destello de algo esquivo, melancólico y sereno, como un cuerpo a la deriva en aguas iluminadas por el sol, hundiéndose lentamente hacia el oscuro fondo del mar.\n\n\"Lo siento,\" dice. \"Me temo que no puedo ayudarte en eso.\""
  },
  Event_146287_Name = {
    Text = "Inmersión Suave"
  },
  Event_146288_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146288_Desc = {
    Text = "\"Tan ciego al arte, tan terriblemente ciego\", murmura una sombra oscura, sacudiendo la cabeza mientras emerge de la penumbra. \"La verdad podría ser veneno. A veces, una ilusión bien guardada es lo único que preserva nuestra frágil felicidad, ¿no es así?\""
  },
  Event_146288_Name = {
    Text = "El Gato Negro Reptante"
  },
  Event_146290_ChoiceDesc1 = {
    Text = "[¿Quién es el Asesino?] Desarrolla \"(Skill.Arg1),\" graba la Inscripción \"(EnchantConfig.Arg2)\" en 1 carta aleatoria"
  },
  Event_146290_ChoiceDesc2 = {
    Text = "[Es Culpa Mía] Desarrolla \"(Skill.Arg1),\" graba la Inscripción \"(EnchantConfig.Arg2)\" en 1 carta aleatoria"
  },
  Event_146290_ChoiceDesc3 = {
    Text = "[Es el Precio de la Gula] Graba la Inscripción \"(EnchantConfig.Arg1)\" en 1 de 3 Tarjetas de comando"
  },
  Event_146290_Desc = {
    Text = "<Italic:\"Corre, corre, ratoncillo,\n\nPor las cloacas, largas y oscuras.\n\nOlfatea el aire y huele lo dulce—\n\nUna hermosa corteza de queso para comer.\n\"\n\n\n\"Arrástrala a casa, corre, corre, corre,\n\nAhora el zumbido ha comenzado.\n\nZumbido, zumbido en tu cabeza,\n\nZumbido, zumbido, lleno de terror.\n\"\n\n\n\"Empuja la puerta, empuja la puerta,\n\nNadie susurra ya más.\n\"\n\n\"Hermanos, hermanas, en fila,\n\nMira qué quietos pueden quedarse.\n\nEn cada vientre hay un agujero,\n\nUn hueco vacío, un hueco vacío.\">"
  },
  Event_146290_Name = {
    Text = "Rata Glotona"
  },
  Event_146291_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146291_Desc = {
    Text = "Te arrodillas y limpias la humedad de su mejilla. No preguntas si las lágrimas son reales.\n\"No importa si son reales\", dices. \"No tienes que demostrarle nada a nadie.\"\nCaraboo abre la boca, pero la réplica ingeniosa y fácil que había preparado muere en su garganta. En cambio, el dique se rompe. Sus lágrimas brotan sin aviso, calientes y pesadas sobre el dorso de tu mano."
  },
  Event_146291_Name = {
    Text = "Lágrimas de Cocodrilo"
  },
  Event_146292_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146292_Desc = {
    Text = "\"Es mejor no preguntar. Hay preguntas que no necesitan respuesta.\""
  },
  Event_146292_Name = {
    Text = "Rata Glotona"
  },
  Event_146293_ChoiceDesc1 = {
    Text = "[Llamar] Obtener Creación de plata \"(RelicConfig.Arg1)\", desarrollar \"(Skill.Arg2)\""
  },
  Event_146293_ChoiceDesc2 = {
    Text = "[Seguir escuchando] Todos los Despertados recuperan 50 de Alienación, desarrollar \"(Skill.Arg1)\""
  },
  Event_146293_ChoiceDesc3 = {
    Text = "[Ignorar] Obtener 1 de 3 Inscripciones"
  },
  Event_146293_Desc = {
    Text = "Donde cayó Naraka, solo queda oscuridad.\n\nUna melodía húmeda se eleva desde el pantano, fría y pálida como un par de manos que acarician tus mejillas con ternura persistente.\n\nCanta en un susurro bajo: \"Ven a mí. Ven a mí en el silencio de la noche.\""
  },
  Event_146293_Name = {
    Text = "Ecos Persistentes"
  },
  Event_146294_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146294_Desc = {
    Text = "Bajas la cabeza, dejando que el humo difumine el contorno de Pollux, ocultando su expresión en la niebla gris y blanca.\n\nEsto es lo más seguro, te dices. No hay necesidad de mirar, no hay necesidad de pensar.\n\nEl sermón de Juliette sigue envolviéndote. Fijas la mirada en tus manos entrelazadas, en silencio.\n\nSolo cuando suena la campana ritual te atreves a levantar los ojos de nuevo.\n\nPollux ha mantenido su postura piadosa durante todo el tiempo.\n\nA través del vasto espacio del tiempo y la ilusión, no puedes estar seguro de si algo se escapó en ese preciso instante."
  },
  Event_146294_Name = {
    Text = "Un Viejo Sueño: III"
  },
  Event_146295_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146295_Desc = {
    Text = "\"¡Pollux!\"\nEl nombre apenas abandona tu garganta antes de que lo sofoques de nuevo. Se disuelve en el humo del incienso como nada más que un suspiro tenue y entrecortado.\n\nA tu alrededor, el canto de los fieles no vacila, pero algunas miradas silenciosas y apenas perceptibles se vuelven hacia ti.\n\nPollux se tensa al instante, un destello de pánico cruza sus ojos, aunque rápidamente queda enmascarado de nuevo por esa expresión entrenada y sumisa.\n\nNo responde. Solo mantiene los ojos bajos, pero sus dedos se aprietan en silencio dentro de su manga. Sabes que te oyó."
  },
  Event_146295_Name = {
    Text = "Un Viejo Sueño: III"
  },
  Event_146297_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146297_Desc = {
    Text = "Al menos, no podrías haberte quedado mirando cómo la expulsaban sola en aquel momento. Deja los problemas de hoy para el yo de hoy."
  },
  Event_146297_Name = {
    Text = "Ruedas dentro de Ruedas"
  },
  Event_146298_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146298_Desc = {
    Text = "\"Pollux, deberíamos separarnos. Así tendremos más posibilidades de encontrar el límite del bosque.\n\"\n\"Pero ¿cómo te encontraré, hermano?\n\"\nA través de la neblina de los recuerdos, ves su rostro afligido. Un agudo dolor te retuerce el corazón. Respiras lenta y profundamente.\n\n\"No te preocupes. Somos gemelos; podemos escuchar los latidos del corazón del otro.\n\"\n\"Nunca estamos realmente separados.\""
  },
  Event_146298_Name = {
    Text = "Un Viejo Sueño: I"
  },
  Event_146299_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146299_Desc = {
    Text = "Juzga. Interroga. Entregará un fin helado y silencioso a todos aquellos que se atrevieron a desafiarla."
  },
  Event_146299_Name = {
    Text = "Veredicto de la Línea de Nieve"
  },
  Event_146300_ChoiceDesc1 = {
    Text = "[Empezar de nuevo] Graba la Inscripción \"(EnchantConfig.Arg1)\" en 1 de 3 Tarjetas de comando, pero desarrolla \"(Skill.Arg2)\""
  },
  Event_146300_ChoiceDesc2 = {
    Text = "[Es difícil] Obtén la Creación de plata \"(RelicConfig.Arg1),\" pero desarrolla \"(Skill.Arg2)\""
  },
  Event_146300_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_146300_Desc = {
    Text = "El Gusano le enseñó el arte de la mentira. Más allá de esto, no aprendió nada sobre la supervivencia.\n\nSin embargo, una mentira siempre sigue siendo una mentira; llega el día en que el andamiaje debe desvanecerse, y uno debe aprender a sostenerse sin su apoyo."
  },
  Event_146300_Name = {
    Text = "Ilusión, No Verdad"
  },
  Event_146301_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146301_Desc = {
    Text = "\"En efecto. Pero ¿cómo podría una rata tan pequeña conocer el precio de su hambre?\""
  },
  Event_146301_Name = {
    Text = "Rata Glotona"
  },
  Event_146302_ChoiceDesc1 = {
    Text = "[Atar el Hilo rojo] Elimina 1 Tarjeta de comando, obtén Arg1 Marcas negras"
  },
  Event_146302_ChoiceDesc2 = {
    Text = "[Rechazar el Hilo rojo] Copia 1 Tarjeta de comando, pero desarrolla \"(Skill.Arg1)\""
  },
  Event_146302_ChoiceDesc3 = {
    Text = "[Regreso a la Realidad] Graba la Inscripción \"(EnchantConfig.Arg1)\" en 1 de 3 Tarjetas de comando"
  },
  Event_146302_Desc = {
    Text = "El primer sueño. El bosque. Tú y tu hermano, con apenas diez años, son abandonados en lo profundo del oscuro bosque por la Señora Linterna.\n\n<Italic:\"Cuando caiga la noche, las bestias dormidas comenzarán a cazar. Escapad antes de entonces. Solo los que logren salir podrán ser mis buenos hijos.>\n\nTu hermano toma tu mano y saca un trozo de hilo rojo.\n\n\"Castor, atemos nuestras manos. Así no nos perderemos el uno al otro.\""
  },
  Event_146302_Name = {
    Text = "Un Viejo Sueño: I"
  },
  Event_146304_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146304_Desc = {
    Text = "Escuchas risas.\n\nJuguetona, burlona, llena de regocijo.\n\nLa desesperada lucha de la humanidad por explorar el cosmos es, a sus ojos, nada más que el arrastrarse de las hormigas."
  },
  Event_146304_Name = {
    Text = "Los que Están Bajo la Mirada"
  },
  Event_146306_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146306_Desc = {
    Text = "Purifica. Borra. Reunirá en su silencioso abrazo a todos aquellos que escalen y nunca regresen."
  },
  Event_146306_Name = {
    Text = "Veredicto de la Línea de Nieve"
  },
  Event_146307_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146307_Desc = {
    Text = "Tú y el cuervo se miden mutuamente con la mirada.\n\nEs obvio que no ganarás este enfrentamiento.\n\nPero entonces, frente a Juliette, parece que nunca lo haces."
  },
  Event_146307_Name = {
    Text = "Un Viejo Sueño: II"
  },
  Event_146308_ChoiceDesc1 = {
    Text = "[¿Quién me observa?] Activar aleatoriamente a 1 Despertado, desarrollar \"(Skill.Arg1)\""
  },
  Event_146308_ChoiceDesc2 = {
    Text = "[Centrarse en el presente] Elegir 1 de 3 Tarjetas de comando para Grabar: \"(EnchantConfig.Arg1)\""
  },
  Event_146308_Desc = {
    Text = "Un viento helado y cargado de nieve aúlla a través de este elevado santuario, intocado por pisadas humanas.\n\nLevantas la vista. Más arriba aún, solo existe el sol eterno e imperturbable.\n\nSin embargo, sabes que en algún lugar más alto, más lejos todavía, innumerables ojos se abren y se cierran.\n\nY algunos de esos ojos observan en silencio todo el mundo que se extiende bajo tus pies."
  },
  Event_146308_Name = {
    Text = "Los que Están Bajo la Mirada"
  },
  Event_146309_ChoiceDesc1 = {
    Text = "[Aún no puedo soltarlo] Obtén la Criatura maldita \"(RelicConfig.Arg1),\" pero desarrolla \"(Skill.Arg2)\""
  },
  Event_146309_ChoiceDesc2 = {
    Text = "[Lo he olvidado] Graba la Inscripción \"(EnchantConfig.Arg1)\" en 1 carta aleatoria"
  },
  Event_146309_Desc = {
    Text = "Intentas cerrar las cámaras de la memoria. Dentro de ese cofre secreto yacen todas las respuestas que te definen: cada impulso vergonzoso, cada fantasía oculta. Pero el deseo es una maldición subconsciente, una obsesión demasiado dulce para resistir."
  },
  Event_146309_Name = {
    Text = "Maldición Subconsciente"
  },
  Event_146310_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146310_Desc = {
    Text = "William evita tu mirada.\n\"La mente es nuestro único escudo contra el engaño. Pero una mente se forja a lo largo de toda una vida de experiencias. No puede compartirse, ni puede enseñarse.\"\n\n\"Lo único que puedo decirte es esto: no dejes que tu propia debilidad te consuma.\""
  },
  Event_146310_Name = {
    Text = "Inmersión Suave"
  },
  Event_146311_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146311_Desc = {
    Text = "\"Ya veo. Eres de los que desean ser filósofo. Pero no olvides: la ausencia de esperanza no significa la ausencia de dolor.\"\nLa risa de la campana se desvanece en la distancia."
  },
  Event_146311_Name = {
    Text = "Reflejo Pavloviano"
  },
  Event_146312_ChoiceDesc1 = {
    Text = "[Salir]infecta\"(Skill.Arg1)\"，obtiene 50 sigilos negros"
  },
  Event_146312_Desc = {
    Text = "\"Hambre, tanta hambre.\"\n\n\nLa montaña llora; la montaña se lamenta. No puede soportar el vasto y hueco vacío en su interior."
  },
  Event_146312_Name = {
    Text = "Secreto de la Montaña"
  },
  Event_146313_ChoiceDesc1 = {
    Text = "[Intentar encontrar apoyo] Eliminar 1 Tarjeta de comando, recuperar Arg1 PV"
  },
  Event_146313_ChoiceDesc2 = {
    Text = "[Agarrar la cuerda de seguridad] Obtener Creación de oro \"(RelicConfig.Arg1)\", desarrollar \"(Skill.Arg2)\""
  },
  Event_146313_Desc = {
    Text = "Un caleidoscopio de alucinaciones bulle en tu mente.\n\nPrimero, nieve suelta. Luego, una cornisa que se derrumba.\n\nNo puedes detener tu caída; la cuerda de seguridad chisporrotea cegadoramente contra su gancho al deslizarse. Pero ante las montañas, es tan terriblemente pequeña, tan frágil."
  },
  Event_146313_Name = {
    Text = "Caída Silenciosa"
  },
  Event_146314_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146314_Desc = {
    Text = "Ven a mí en tus sueños. Déjame vivir mi vida una vez más.\n\nEl gramófono emite un gemido lastimero. Luego, el sonido de la respiración se desvanece en la oscuridad. No queda nada salvo el eco. Solo el eco."
  },
  Event_146314_Name = {
    Text = "Ecos Persistentes"
  },
  Event_146315_ChoiceDesc1 = {
    Text = "[Lamentar la Elección] Obtener Creación de plata \"(RelicConfig.Arg1)\""
  },
  Event_146315_ChoiceDesc2 = {
    Text = "[Dejarlo en manos del Destino] Obtener Creación de oro \"(RelicConfig.Arg1)\", desarrollar \"(Skill.Arg2)\""
  },
  Event_146315_Desc = {
    Text = "Siempre supiste que este viaje no sería sencillo. La mayoría de los escaladores de esta expedición albergan sus propios oscuros designios.\n\nSin embargo, al ver la sonrisa maniaca y burlona que se extiende por el rostro de Caraboo, aún sientes el crujido agudo y repentino de algo que se rompe en tu pecho.\n\nQuizás, cuando Naraka quiso expulsarla del grupo, deberías haber tomado una decisión diferente."
  },
  Event_146315_Name = {
    Text = "Ruedas dentro de Ruedas"
  },
  Event_146316_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146316_Desc = {
    Text = "¿Cuántos han sido devorados por este lugar?\n\nManos negras emergen del espeso y viscoso estanque, intentando arrastrarte hacia su mundo. Pero tú simplemente sigues caminando. No hacen ningún movimiento para detenerte y regresan silenciosamente a las profundidades.\n\nLa cima aún te espera más adelante."
  },
  Event_146316_Name = {
    Text = "Ecos Persistentes"
  },
  Event_146317_ChoiceDesc1 = {
    Text = "[Apartar la mirada] Ganar 25 Marcas negras"
  },
  Event_146317_ChoiceDesc2 = {
    Text = "[Mirar más de cerca] Obtener Creación de plata \"(RelicConfig.Arg1)\", desarrollar \"(Skill.Arg2)\""
  },
  Event_146317_Desc = {
    Text = "Siguiendo la mirada de Tinct, no puedes evitar clavar los ojos en las profundidades del lago.\n\n¿Qué hay allá abajo que la tiene tan hechizada?\n\nNo puedes saberlo. El hielo está turbio y oscuro, y no refleja nada más que tu propia sombra."
  },
  Event_146317_Name = {
    Text = "El Reflejo Sumergido"
  },
  Event_146318_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146318_Desc = {
    Text = "La única manera de detener el hambre es soltar. Nadie puede perder lo que no posee. El Wendigo muestra los dientes, dejando escapar un gruñido frustrado, y se escabulle de regreso hacia la niebla."
  },
  Event_146318_Name = {
    Text = "Maldición Subconsciente"
  },
  Event_146319_ChoiceDesc1 = {
    Text = "[La nieve me Purificará] Mejorar aleatoriamente la calidad de Inscripción de 1 Carta"
  },
  Event_146319_ChoiceDesc2 = {
    Text = "[La nieve me juzgará] Elegir 1 de 3 Tarjetas de comando para Grabar: \"(EnchantConfig.Arg1)\", desarrollar \"(Skill.Arg2)\""
  },
  Event_146319_Desc = {
    Text = "Ante ti se extiende el ascenso final, donde la fría e interminable línea de nieve se pierde en la distancia.\n\nLa nieve es de un blanco deslumbrante y brillante. Aquí, incluso la muerte parece limpia."
  },
  Event_146319_Name = {
    Text = "Veredicto de la Línea de Nieve"
  },
  Event_146320_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146320_Desc = {
    Text = "No pierdas ningún detalle de la visión. Grábalos en tu mente. Graba el vacío repentino, el dolor hueco y el agudo pesar que siguió. Nunca, jamás los dejes ir."
  },
  Event_146320_Name = {
    Text = "Desde la Otra Orilla"
  },
  Event_146321_ChoiceDesc1 = {
    Text = "[Luchar juntos] Obtén la Creación de plata \"(RelicConfig.Arg1)\""
  },
  Event_146321_ChoiceDesc2 = {
    Text = "[Consolarla] Obtén la Creación de oro \"(RelicConfig.Arg1),\" pero desarrolla \"(Skill.Arg2)\""
  },
  Event_146321_Desc = {
    Text = "La montaña se estremece como una bestia agonizante. Una carne pálida y segmentada surge de la piedra fracturada, enroscándose y trepando, arrojando a Caraboo al suelo.\n\nCuando se levanta, surcos húmedos marcan sus mejillas cubiertas de polvo. ¿Son lágrimas de dolor? No puedes saberlo.\n\nTantas mentiras han brotado de sus labios; ¿quién puede confiar en las lágrimas de un cocodrilo?"
  },
  Event_146321_Name = {
    Text = "Lágrimas de Cocodrilo"
  },
  Event_146322_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146322_Desc = {
    Text = "No haces preguntas. Simplemente tomas tu lugar a su lado.\n\"Levántate\", dices. \"Solo estás a mitad de tu actuación. No me falles ahora.\"\nCaraboo duda, luego se limpia la cara con un gesto brusco y repentino. Se incorpora con dificultad, con los nudillos blancos sobre su arma, para enfrentarse a las fauces carmesíes y abiertas junto a ti.\nHa dicho tantas mentiras que ni ella misma puede distinguir qué lágrimas son agua y cuáles son sal. Pero por ahora, nadie lleva la cuenta."
  },
  Event_146322_Name = {
    Text = "Lágrimas de Cocodrilo"
  },
  Event_146323_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146323_Desc = {
    Text = "\"Ya veo. Eres de los que se enorgullecen de ver a través de las ilusiones. Pero no olvides: en ese breve instante de realidad, la comida existía solo en tu memoria y en tu deseo.\"\nLa risa de la campana se desvanece en la distancia."
  },
  Event_146323_Name = {
    Text = "Reflejo Pavloviano"
  },
  Event_146324_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146324_Desc = {
    Text = "Reduces el paso, suavizando tus pisadas.\n\nSuave, lentamente, sin hacer ruido...\n\nTe deslizas por la siguiente esquina y desapareces.\n\n¿Acaso el cuervo te siguió alguna vez?\n\nYa no lo recuerdas."
  },
  Event_146324_Name = {
    Text = "Un Viejo Sueño: II"
  },
  Event_146325_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146325_Desc = {
    Text = "La melodía se interrumpe.\n\nDel negro pantano, un par de ojos ansiosos y húmedos se abren para mirarte. Susurran palabras que no puedes descifrar y luego, lentamente, lentamente, se cierran."
  },
  Event_146325_Name = {
    Text = "Ecos Persistentes"
  },
  Event_146326_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146326_Desc = {
    Text = "No te demoras. Dejando la melodía atrás, tus botas aplastan la nieve con un sonido más apresurado que el propio viento.\n\nSin embargo, por más rápido que camines, esa melodía desolada se aferra obstinadamente a tus talones, sin quedarse nunca atrás.\n\nNo puedes escapar de ella—es el aliento de la propia montaña. Y tú no eres más que un oyente diminuto y pasajero que tuvo la casualidad de escucharla."
  },
  Event_146326_Name = {
    Text = "Fantasía de la Naturaleza"
  },
  Event_146327_ChoiceDesc1 = {
    Text = "[Escucharla] Elige 1 de 3 Tarjetas de comando para Grabar: \"(EnchantConfig.Arg1)\", desarrolla \"(Skill.Arg2)\""
  },
  Event_146327_ChoiceDesc2 = {
    Text = "[No hacerle caso] Por cada Despertado con Alienación en 50 o más, obtén 15 Marcas negras"
  },
  Event_146327_ChoiceDesc3 = {
    Text = "[Salir por la fuerza] Obtiene elección de 3 para 1 oración"
  },
  Event_146327_Desc = {
    Text = "Una canción lejana flota en el viento.\n\nParece provenir de todas direcciones, o quizás de las profundidades de la tierra.\n\nHacia donde quiera que te gires para seguirla, resuena en tus oídos con la misma intensidad implacable."
  },
  Event_146327_Name = {
    Text = "Aria del Lago Helado"
  },
  Event_146328_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146328_Desc = {
    Text = "\"Oh, estrella de mal agüero, esta no es la hora de tu resplandor.\"\n\n\"Mi peregrinaje tiene metas que aún no ha alcanzado.\"\n\n\"Apágate, aunque sea por ahora, y deja que la paz regrese al cielo de esta noche.\""
  },
  Event_146328_Name = {
    Text = "Presagio de Muerte"
  },
  Event_146329_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146329_Desc = {
    Text = "Una inútil oleada de arrepentimiento te invade. Pero siempre estamos obligados a limpiar los desastres que nos dejaron nuestros yo del pasado."
  },
  Event_146329_Name = {
    Text = "Ruedas dentro de Ruedas"
  },
  Event_146330_ChoiceDesc1 = {
    Text = "[Morder] Despertar aleatoriamente 1 Cuerpo Despertado, infectar[(Skill.Arg1)]"
  },
  Event_146330_ChoiceDesc2 = {
    Text = "[Rechazar]obtienes sello de 3 opciones"
  },
  Event_146330_Desc = {
    Text = "En lo más profundo de la niebla cargada de nieve se agacha una figura esquelética, con la piel seca y agrietada tensada sobre costillas prominentes. Sobre su cabeza, retorcidas y marchitas astas perforan la bruma. Un rugido hueco y hambriento resuena desde su vientre.\n\nCuando vuestras miradas se encuentran, imágenes fragmentadas giran en sus cuencas hundidas: tus recuerdos. Ya ha captado el rastro; ya los ha saboreado.\n\n\"No es suficiente, nunca es suficiente...\", gime con un sonido seco y rasposo. Extiende una mano marchita, con una postura que casi parece... suplicante."
  },
  Event_146330_Name = {
    Text = "El Devorador"
  },
  Event_146332_ChoiceDesc1 = {
    Text = "[Realizar el entierro celestial] Obtén la Creación de plata \"(RelicConfig.Arg1)\""
  },
  Event_146332_ChoiceDesc2 = {
    Text = "[Dispel] Obtiene 75 marcas negras, pero desarrolla el síntoma [(Skill.Arg2)]"
  },
  Event_146332_Desc = {
    Text = "En las altas corrientes térmicas, los quebrantahuesos circulan patrullando su dominio. Entre quienes escalan, esto ha sido siempre un mal presagio.\n\n\"Están forrajeando. Un buitre huele la proximidad de la muerte.\""
  },
  Event_146332_Name = {
    Text = "Presagio de Muerte"
  },
  Event_146333_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146333_Desc = {
    Text = "Confía en tus piernas. Vas a conquistar esta cima."
  },
  Event_146333_Name = {
    Text = "Tocando la Cima"
  },
  Event_146334_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146334_Desc = {
    Text = "En el momento en que el anhelo se enciende, sabes que no puedes combatirlo. Solo puedes observar cómo irrumpe en las bóvedas largo tiempo selladas de tu mente. Colmillos pálidos y afilados se hunden en tus sienes, arrancando tus recuerdos, fotograma a fotograma, desde sus mismas raíces."
  },
  Event_146334_Name = {
    Text = "Maldición Subconsciente"
  },
  Event_146335_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146335_Desc = {
    Text = "Se inclina cerca, con la nariz casi rozando tu frente, respirándote con una devoción arrebatada y ebria, como si fueras la miel más dulce.\n\nTus inquietas y turbulentas ansiedades son lamidas y borradas de tu mente.\n\nSe retira con un suave zumbido satisfecho, una luz salvaje y seductora parpadeando en sus ojos huecos. Tu pecho se siente vacío ahora, con una pieza que falta, y sin embargo, extrañamente, te sientes más ligero."
  },
  Event_146335_Name = {
    Text = "El Devorador"
  },
  Event_146336_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146336_Desc = {
    Text = "\"Vigila dónde pisas. Asegúrate de que cada paso sea firme\", la voz de Naraka resuena en tu oído. \"No esperes que otros te atrapen cuando caigas.\""
  },
  Event_146336_Name = {
    Text = "Los que Están Bajo la Mirada"
  },
  Event_146337_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146337_Desc = {
    Text = "La humanidad pertenece a los cielos. Un propósito verdadero hace olvidar el precipicio que se abre bajo los pies. El cielo está abierto, esperando justo arriba."
  },
  Event_146337_Name = {
    Text = "Tocando la Cima"
  },
  Event_146338_ChoiceDesc1 = {
    Text = "[Dejar ir los Homenajes] Obtén la Creación de oro \"(RelicConfig.Arg1),\" pero desarrolla \"(Skill.Arg2)\""
  },
  Event_146338_ChoiceDesc2 = {
    Text = "[Aferrarse al Pain] Obtén 1 de 3 Creaciones de oro, pero desarrolla \"(Skill.Arg1)\""
  },
  Event_146338_ChoiceDesc3 = {
    Text = "[Salir]obtiene reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_146338_Desc = {
    Text = "La persona que una vez asesinó a William está ahora frente a ti.\n\nEn el aire estancado y nauseabundo de la tienda de Aram, los recuerdos surgen como fantasmas: la figura exangüe y flotante de William; su rostro pálido vuelto hacia arriba; y sobre la mesa, la carcasa disecada y vacía de aquella pequeña linterna."
  },
  Event_146338_Name = {
    Text = "Desde la Otra Orilla"
  },
  Event_146339_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146339_Desc = {
    Text = "La cuerda de seguridad se rompe al instante bajo tu peso.\n\nCaes pesadamente sobre un ventisquero, con cada órgano gritando en una protesta sorda y agonizante. Fuerzas tus ojos a abrirse entre el dolor vertiginoso, solo para encontrarte cara a cara con un esqueleto sin nombre.\n\nEn lo más profundo de sus cuencas vacías y huecas, algo brilla."
  },
  Event_146339_Name = {
    Text = "Caída Silenciosa"
  },
  Event_146340_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146340_Desc = {
    Text = "No hay salida. Aprietas los dientes y corres, intentando desesperadamente escapar de tu vigilante. El cuervo lanza un graznido áspero, agita sus alas y te sigue sin esfuerzo desde las alturas, incluso dando vueltas para burlarse de ti. Una fría desesperación se filtra bajo tu piel bajo su mirada.\n\nNo puedes huir de ellos."
  },
  Event_146340_Name = {
    Text = "Un Viejo Sueño: II"
  },
  Event_146341_ChoiceDesc1 = {
    Text = "[Siembras lo que cosechas] Una Tarjeta de comando aleatoria gana Inscripción: \"(EnchantConfig.Arg1)\""
  },
  Event_146341_ChoiceDesc2 = {
    Text = "[Paridad absoluta] Aumentar PV Max en Arg1, desarrollar \"(Skill.Arg2)\""
  },
  Event_146341_Desc = {
    Text = "Colgado de la escarpada pared rocosa, una pregunta completamente ajena de repente cruza tu mente: ¿Qué es la justicia?"
  },
  Event_146341_Name = {
    Text = "Equidad Absurda"
  },
  Event_146342_ChoiceDesc1 = {
    Text = "[Salir]infecta\"(Skill.Arg1)\"，obtiene 50 sigilos negros"
  },
  Event_146342_Desc = {
    Text = "\"¡No puedo morir! ¡Todavía no!\"\nLa montaña llora; la montaña se lamenta. En su codicia insaciable, ha devorado su propio mañana."
  },
  Event_146342_Name = {
    Text = "Secreto de la Montaña"
  },
  Event_146343_ChoiceDesc1 = {Text = "[Salir]"},
  Event_146343_Desc = {
    Text = "Te inclinas hasta que tu mejilla toca el hielo.\n\nUn frío profundo y penetrante se filtra a través de tu piel hasta los huesos, haciéndote estremecer. Algo insondable y lento se mueve bajo la superficie helada. ¿Es una corriente o algún ser vivo?\n\nSea lo que sea, no tiene nada que ver con tu travesía."
  },
  Event_146343_Name = {
    Text = "El Reflejo Sumergido"
  },
  Event_148532_ChoiceDesc1 = {
    Text = "[Recibir la Bendición] Al inicio de la batalla, añade 1 \"Fruta Proteica\" aleatoria a tu mazo."
  },
  Event_148532_Desc = {
    Text = "La vasta llanura nevada se extiende sin fin; el viento helado no arrastra ni el más leve sonido. Una sombra de origen incierto emerge en silencio y tiende una fruta tibia al viajero.\nSu dulce fragancia, mezclada con la neblina, penetra en la nariz entumecida del caminante.\nEsta tierra de Los Atrapados en la Nieve lleva mucho tiempo empapada de muerte; en el aire flotan olores nauseabundos de putrefacción y hielo. Solo la fruta que descansa en la palma de la mano luce jugosa y plena, como la tentadora promesa de una joven doncella."
  },
  Event_148532_Name = {
    Text = "Espejismo Celestial"
  },
  Event_20778_ChoiceDesc1 = {
    Text = "[Déjaselo a ella]Todos los despertados recuperan Arg1 de locura"
  },
  Event_20778_ChoiceDesc2 = {
    Text = "[Necesitar apoyo]Selecciona 2 despertadores"
  },
  Event_20778_Desc = {
    Text = "\"Aquí está la comunicación de Mitag, se han detectado fluctuaciones anormales en el índice gnóstico del despertador, ¿necesitas apoyo?\""
  },
  Event_20778_Name = {
    Text = "Comunicación de apoyo"
  },
  Event_20779_ChoiceDesc1 = {Text = "[Salir]"},
  Event_20779_Desc = {
    Text = "\"Se ha proporcionado asistencia de emergencia, confirme golpeando tres veces el broche después de recibirla.\""
  },
  Event_20779_Name = {
    Text = "Comunicación de apoyo"
  },
  Event_20780_ChoiceDesc1 = {Text = "[Salir]"},
  Event_20780_Desc = {
    Text = "Una sombra del futuro lejano, oculta en los desfiladeros de Elworth"
  },
  Event_20780_Name = {
    Text = "Fantasma volcánico"
  },
  Event_20781_ChoiceDesc1 = {
    Text = "[Mirar al fantasma]todos los despertadores recuperan Arg1 aliemus"
  },
  Event_20781_ChoiceDesc2 = {
    Text = "[Acercarse al fantasma]Selecciona 2 despertadores"
  },
  Event_20781_Desc = {
    Text = "A lo lejos parece que un cono volcánico está en erupción, y en el cielo azotado por el viento se eleva un humo con forma humana. \n Este es Elworth, donde solo hay montañas nevadas y cuevas de piedra caliza que se extienden sin fin. \n ¿Es el extraño fenómeno de estos días lo que te ha llevado a la locura?"
  },
  Event_20781_Name = {
    Text = "Fantasma volcánico"
  },
  Event_20782_ChoiceDesc1 = {Text = "[Salir]"},
  Event_20782_Desc = {
    Text = "La ilusión te saludó y luego desapareció, dejándote solo con el frío hielo y las majestuosas montañas"
  },
  Event_20782_Name = {
    Text = "Fantasma volcánico"
  },
  Event_20783_ChoiceDesc1 = {Text = "[Salir]"},
  Event_20783_Desc = {
    Text = "\"Recibido, procederemos con el envío de recursos básicos.\""
  },
  Event_20783_Name = {
    Text = "Comunicación de apoyo"
  },
  Event_21398_ChoiceDesc1 = {
    Text = "[Recoger la foto]elige 1 de 3 cartas de comando y obtienes sello:\"(EnchantConfig.Arg1)\""
  },
  Event_21398_Desc = {
    Text = "El robot fue desmontado, y la verdad revelada.\nLa vida bulliciosa desaparece, dejándote la satisfacción de la verdad"
  },
  Event_21398_Name = {
    Text = "Declaración de testigo"
  },
  Event_21399_ChoiceDesc1 = {
    Text = "[Recoger la foto]elige 1 de 3 cartas de comando y obtienes sello:\"(EnchantConfig.Arg1)\""
  },
  Event_21399_ChoiceDesc2 = {
    Text = "[Revisar película]infección\"(Skill.Arg1)\"，cambia la plegaria obtenida en la opción 1, que se puede usar una vez más"
  },
  Event_21399_Desc = {
    Text = "La curiosidad te empuja a mirar dentro de la Piscina de Sombras.  \nEsas imágenes están empapadas en un rojo vívido, y el pecador cubierto de manchas oscuras, tiene sorprendentemente el mismo rostro que tú"
  },
  Event_21399_Name = {
    Text = "Declaración de testigo"
  },
  Event_21400_ChoiceDesc1 = {Text = "[Salir]"},
  Event_21400_Desc = {
    Text = "El robot fue desmontado, y la verdad revelada.\nLa vida bulliciosa desaparece, dejándote la satisfacción de la verdad"
  },
  Event_21400_Name = {
    Text = "Declaración de testigo"
  },
  Event_21811_ChoiceDesc1 = {Text = "[Salir]"},
  Event_21811_Desc = {
    Text = "\"Veinticinco años... sí, ella me hizo dormir durante veinticinco años.\"\nLa niña respondió con tono sombrío y abatido. \nSolo al despertar, esos sirvientes que la cuidaron desde pequeña, se convirtieron en auténticos Marchadores de mares a medida que pasaron los años. \nYa no hay nadie que entienda su angustia, ya no hay nadie que se preocupe por su dolor, dejándola sola en el culto. \nPreferiría que el día antes de dormir fuera el \"momento de la alineación de las estrellas\"."
  },
  Event_21811_Name = {
    Text = "Vida Encadenada"
  },
  Event_22058_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22058_Desc = {
    Text = "\"No, no tengo hambre.\"\nRechazas cortésmente la invitación al banquete.\nNunca estarías dispuesto a pagar el precio de capturar almas"
  },
  Event_22058_Name = {
    Text = "Festín de carne"
  },
  Event_22059_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22059_Desc = {
    Text = "Muerdes desordenadamente el scone sangrante, mezclando el aroma del corazón marinado en pimienta con la masa horneada, y hueles un aroma familiar.\n\"Obtener poder requiere un precio.\"\nBebes el último sorbo de sangre"
  },
  Event_22059_Name = {
    Text = "Festín de carne"
  },
  Event_22060_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22060_Desc = {
    Text = "Tragaste la sopa y la carne, limpiándote los labios con la manga.\nLa carne era tierna y la sopa sabrosa, ¿a quién pertenecía?\nSolo es la punta del iceberg de lo que has perdido"
  },
  Event_22060_Name = {
    Text = "Festín de carne"
  },
  Event_22061_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22061_Desc = {
    Text = "Examinaste detenidamente los antiguos sellos grabados en el viento.  \nSe retorcían de una manera inimaginable para los mortales, como si no tuvieran intención de ser comprendidos.  \nNo ser comprendido, significa no ser perturbado"
  },
  Event_22061_Name = {
    Text = "Viento oxidado"
  },
  Event_22062_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22062_Desc = {
    Text = "\"Bien, eres cauteloso.\"\nUna voz distante sonó desde la campanilla.\n\"La cautela te dará una pequeña recompensa, pero solo eso.\""
  },
  Event_22062_Name = {
    Text = "Viento oxidado"
  },
  Event_22063_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22063_Desc = {
    Text = "Acariciaste los antiguos grabados en el viento de la campana. \nSe distorsionan de maneras que solo los mortales pueden imaginar, como si no tuvieran intención de ser entendidos.\nNo ser comprendidos significa no ser molestados"
  },
  Event_22063_Name = {
    Text = "Viento oxidado"
  },
  Event_22064_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22064_Desc = {
    Text = "\"Ah, qué pena... seguiré con mi solo solitario.\" No sabes cuándo desaparecieron el arpa y las manos, pero la melodía siempre quedó en tu corazón"
  },
  Event_22064_Name = {
    Text = "Fantasma junto al piano"
  },
  Event_22065_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22065_Desc = {
    Text = "\"Ah, tener un amigo así es un honor!\" Las manos se emocionaron, no podías seguir su ritmo. Incluso después de que la actuación terminó, la inspiradora melodía seguía resonando en tu corazón"
  },
  Event_22065_Name = {
    Text = "Fantasma junto al piano"
  },
  Event_22175_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22175_Desc = {
    Text = "La tabla ouija se movía con confianza, y tu mirada la seguía.\nSin embargo, apenas señaló dos letras cuando se convirtió en un líquido negro viscoso con un grito desgarrador"
  },
  Event_22175_Name = {
    Text = "Tablero espiritual"
  },
  Event_22176_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22176_Desc = {
    Text = "\"¡Matemáticas! ¡Matemáticas!!\"\nUna voz femenina rechinaba los dientes mientras el tablero se deslizaba rápidamente entre los números, produciendo un chirrido de madera.\n\"¡Llévate tus matemáticas fuera de mi vista!\""
  },
  Event_22176_Name = {
    Text = "Tablero espiritual"
  },
  Event_22177_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22177_Desc = {
    Text = "\"¡Espera, espera!!\"\n\"¡Pregúntame! ¿Por qué no preguntas?\""
  },
  Event_22177_Name = {
    Text = "Tablero espiritual"
  },
  Event_22178_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22178_Desc = {
    Text = "Nunca ha latido tan intensamente como ahora, pero al mismo tiempo, el agujero en su corazón se está desgarrando"
  },
  Event_22178_Name = {
    Text = "Sed de maldición"
  },
  Event_22179_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22179_Desc = {
    Text = "El alma y el espíritu llenan tus pulmones, en el silencio, sigues flotando.\nLos sonidos del mundo resuenan uno por uno, tocando la sinfonía de la vida"
  },
  Event_22179_Name = {
    Text = "Agua del pasado"
  },
  Event_22180_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22180_Desc = {
    Text = "Todo sigue igual, la destrucción llega como se esperaba, en las cenizas no quemadas yace algo valioso, brillando en la sombra"
  },
  Event_22180_Name = {
    Text = "Fuera de la punta de la aguja"
  },
  Event_22181_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22181_Desc = {
    Text = "Encuentro, despedida, cruce de caminos"
  },
  Event_22181_Name = {
    Text = "Sonido de las estrellas y la luna"
  },
  Event_22182_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22182_Desc = {
    Text = "El corazón late más lento, pero tal vez la \"conciencia\" ha encontrado algo de consuelo"
  },
  Event_22182_Name = {
    Text = "Sed de maldición"
  },
  Event_22183_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22183_Desc = {
    Text = "Cierras los ojos, disfrutando de este raro momento de vacío y libertad. Poco a poco, sientes que el mundo emerge del silencio, la vida florece en silencio"
  },
  Event_22183_Name = {
    Text = "Agua del pasado"
  },
  Event_22184_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22184_Desc = {
    Text = "Detuviste la aguja, y el metal brillante cortó la suave palma de tu mano; aunque la destrucción aún no había llegado, tu sombra estaba siendo tragada por la noche oscura como tinta"
  },
  Event_22184_Name = {
    Text = "Fuera de la punta de la aguja"
  },
  Event_22185_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22185_Desc = {
    Text = "\"No puedes escapar, nadie puede resistir el mal interior\"\nEl mal lucha por arrastrarte al abismo, pero el dolor sólo hace que tu mente sea más clara.\nEl mal no te posee, sólo eres tú mismo"
  },
  Event_22185_Name = {
    Text = "Pensamiento Ilusorio"
  },
  Event_22186_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22186_Desc = {
    Text = "\"¿Por qué no？\"\nAbrazando esos pensamientos aterradores, todos los problemas se resolverán, y ya no existirá la paradoja llamada \"ética\""
  },
  Event_22186_Name = {
    Text = "Pensamiento Ilusorio"
  },
  Event_22187_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22187_Desc = {
    Text = "Un destello de luz plateada pasa frente a tus ojos, un viento sordo se lleva todos los sonidos"
  },
  Event_22187_Name = {
    Text = "Pensamiento Ilusorio"
  },
  Event_22188_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22188_Desc = {
    Text = "Cambiante, frío, distante"
  },
  Event_22188_Name = {
    Text = "Sonido de las estrellas y la luna"
  },
  Event_22189_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22189_Desc = {
    Text = "Hinchazón, contracción, a punto de estallar"
  },
  Event_22189_Name = {
    Text = "Sonido de las estrellas y la luna"
  },
  Event_22190_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22190_Desc = {
    Text = "Aunque sea un poco imprudente, ¿por qué no?\nRomper todas las barreras, correr hacia la meta.\nAunque agites un mar de pensamientos o te conviertas en un Ícaro contemporáneo, al menos lograste tu objetivo, ¿verdad?"
  },
  Event_22190_Name = {
    Text = "Laberinto de la mente"
  },
  Event_22191_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22191_Desc = {
    Text = "Tu cerebro es un laberinto y tú eres su Ariadna.\nEn este universo, nadie sabe mejor que tú cómo salir del laberinto.\nNadie"
  },
  Event_22191_Name = {
    Text = "Laberinto de la mente"
  },
  Event_22192_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22192_Desc = {
    Text = "Con la afinación correcta, los intervalos disonantes se suavizan un poco.\nPero tal vez, aún puedes hacer algo más"
  },
  Event_22192_Name = {Text = "Disonancia"},
  Event_22193_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22193_Desc = {
    Text = "Eres un maestro de música y también un común torpe.\nLas notas, bajo tu control mental, cumplen sus funciones mientras la vida fluyente finalmente se entona en el dominio"
  },
  Event_22193_Name = {Text = "Disonancia"},
  Event_22194_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22194_Desc = {
    Text = "Tu voz se pierde en el silencio. El sonido del silencio se hace más fuerte, hasta que se rompe por completo, dejando solo escombros"
  },
  Event_22194_Name = {
    Text = "Agua del pasado"
  },
  Event_22195_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22195_Desc = {
    Text = "No te dejas engañar fácilmente, te das la vuelta y te vas"
  },
  Event_22195_Name = {
    Text = "Grieta reptante"
  },
  Event_22293_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22293_Desc = {
    Text = "Al tomar el bolígrafo, el papel de carta se incendia en el dominio, las cenizas caen en tu mano,\nAl volver en sí, algo se dispersó junto con el papel"
  },
  Event_22293_Name = {
    Text = "Confesión unilateral"
  },
  Event_22294_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22294_Desc = {
    Text = "El papel de carta se desvaneció en el dominio y escuchaste una preocupación suave y débil. \n\"En esta situación, recordarme es un honor para mí como maestro. \nSin embargo, la última vez que caminé por el dominio fue hace mucho, mucho tiempo. Ahora, solo puedo ayudarte con esto...\""
  },
  Event_22294_Name = {
    Text = "Confesión unilateral"
  },
  Event_22295_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22295_Desc = {
    Text = "El papel de carta se desvaneció en el dominio secreto y escuchaste un grito urgente.\n\"Guardián del Secreto, si te sientes mal, por favor házmelo saber.\nComo tu compañero, haré todo lo posible para ayudarte.\""
  },
  Event_22295_Name = {
    Text = "Confesión unilateral"
  },
  Event_22296_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22296_Desc = {
    Text = "El papel de carta se desvaneció en el dominio secreto y escuchaste un suspiro frío.\n\"Ojalá hubieras buscado ayuda así de activamente cuando fallaste el examen.\""
  },
  Event_22296_Name = {
    Text = "Confesión unilateral"
  },
  Event_22397_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22397_Desc = {
    Text = "Tu aparición hace que las sombras se miren entre sí, un rayo de luz estelar roza tus zapatos y la multitud desaparece, dejando solo la sombra más densa en tu mano"
  },
  Event_22397_Name = {
    Text = "Pacto de la Luna y las Estrellas"
  },
  Event_22398_ChoiceDesc1 = {Text = "[Salir]"},
  Event_22398_Desc = {
    Text = "Los susurros cesan abruptamente, y las sombras negras como la tinta se vuelven hacia ti, mirándote. En esos rostros sin rasgos, lees un toque de burla"
  },
  Event_22398_Name = {
    Text = "Pacto de la Luna y las Estrellas"
  },
  Event_22399_ChoiceDesc1 = {
    Text = "[Observar con calma] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_22399_ChoiceDesc2 = {
    Text = "[Preguntar en voz alta] obtén 25 Marca negra"
  },
  Event_22399_Desc = {
    Text = "En la intersección de las estrellas y la luna, susurros incesantes resuenan. \n \"¿Es esta la persona? @4... \" \n \"En forma humana, al final sigue siendo @3...\""
  },
  Event_22399_Name = {
    Text = "Pacto de la Luna y las Estrellas"
  },
  Event_22411_ChoiceDesc1 = {
    Text = "[Trabajo hecho]"
  },
  Event_22411_Desc = {
    Text = "¡Trampas baratas pero efectivas!"
  },
  Event_22411_Name = {
    Text = "Fabricar una trampa"
  },
  Event_24254_ChoiceDesc1 = {Text = "[Salir]"},
  Event_24254_Desc = {
    Text = "La tormenta de sabiduría rodea a Tulu, intercambian una mirada y se adentran en la oscuridad"
  },
  Event_24254_Name = {Text = "del mar"},
  Event_24255_ChoiceDesc1 = {Text = "[Salir]"},
  Event_24255_Desc = {
    Text = "La tormenta de sabiduría rodea a Tulu, y la tristeza y culpa persistentes se extienden en el espacio"
  },
  Event_24255_Name = {
    Text = "Enfrentarse al abismo"
  },
  Event_24256_ChoiceDesc1 = {
    Text = "[Tomar tentáculo]Aceptar ayuda de Tulu"
  },
  Event_24256_Desc = {
    Text = "Su presencia es como una enorme criatura que cae al mar, agitando el dominio que tiene delante.\nEse poder es antiguo, primigenio, suficiente para trascender cualquier cosa.\nEs un alivio que no estés en su contra, al menos no por ahora"
  },
  Event_24256_Name = {Text = "del mar"},
  Event_24257_ChoiceDesc1 = {
    Text = "[Tomar tentáculo]Acompañar a Tulu"
  },
  Event_24257_Desc = {
    Text = "Tulu respiró hondo, mirando a Miriam desde lejos.\nParecía recordar la historia, a viejos amigos, a su propia vida...\nLa compleja expresión en su rostro duró solo un momento, luego apartó la mirada de Miriam.\n\"Vamos, déjala.\""
  },
  Event_24257_Name = {
    Text = "Enfrentarse al abismo"
  },
  Event_24277_ChoiceDesc1 = {
    Text = "[Cerrar la escotilla]"
  },
  Event_24277_Desc = {
    Text = "Ramona agarró al estudiante que irrumpió desde afuera.\nEl Guardián del Secreto, aunque desaliñado, no mostraba signos de daño. En sus ojos azules detrás de las gafas, la figura de Ramona parecía borrosa.\nSolo al agarrar su mano, Ramona confirmó: se han reunido"
  },
  Event_24277_Name = {
    Text = "Reencuentro Alegre"
  },
  Event_24278_ChoiceDesc1 = {Text = "[Salir]"},
  Event_24278_Desc = {
    Text = "Ramona no te dio oportunidad de explicarte, te arrastró a la oscura cabina y cerró la puerta con cuidado"
  },
  Event_24278_Name = {
    Text = "Reencuentro Alegre"
  },
  Event_24540_ChoiceDesc1 = {Text = "[Salir]"},
  Event_24540_Desc = {
    Text = "\"Ella es tu sólido blindaje, es la espada en tu mano. \n Ella es tu compañera, tu socia, tu amiga de confianza—— sin importar cómo se convierta.\""
  },
  Event_24540_Name = {
    Text = "Una presencia extraña y familiar"
  },
  Event_24541_ChoiceDesc1 = {Text = "[Salir]"},
  Event_24541_Desc = {
    Text = "\"Eres tú... No, no puede ser, en este ciclo ya... y yo también...\"\nLa voz se desvanece con la figura, solo la tristeza permanece en la niebla"
  },
  Event_24541_Name = {
    Text = "Figura familiar pero extraña"
  },
  Event_24542_ChoiceDesc1 = {Text = "[Salir]"},
  Event_24542_Desc = {
    Text = "\"Por el mundo, por la humanidad, por todo lo que valoramos.\nY lo más importante— por ti.\""
  },
  Event_24542_Name = {
    Text = "Una presencia extraña y familiar"
  },
  Event_24543_ChoiceDesc1 = {Text = "[Salir]"},
  Event_24543_Desc = {
    Text = "Notaste la figura antes de acercarte. Se detuvo, como si estuviera sorprendido o sumido en una gran tristeza.\nAntes de que pudieras decir algo, se desvaneció junto con la niebla"
  },
  Event_24543_Name = {
    Text = "Figura familiar pero extraña"
  },
  Event_24544_ChoiceDesc1 = {
    Text = "[¿Quién es ella?] obtiene aleatoriamente 3 cartas de comando y elige 1 para copiar"
  },
  Event_24544_ChoiceDesc2 = {
    Text = "[¿Por qué Ella se volvió así?] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_24544_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_24544_Desc = {
    Text = "Otra niebla, otra figura. Esta vez, la ves claramente.\nUna figura idéntica a ti, con el mismo uniforme y rostro.\n\"Sabes por qué estás aquí,\" dice, \"como sabes por qué ella se convirtió en eso.\""
  },
  Event_24544_Name = {
    Text = "Una presencia extraña y familiar"
  },
  Event_24545_ChoiceDesc1 = {
    Text = "[Expresar consuelo]obtener reliquia de plata\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_24545_ChoiceDesc2 = {
    Text = "[intentar acercarse]obtén la reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_24545_ChoiceDesc3 = {
    Text = "[dar la vuelta y salir]obtén 25 el sigilo negro"
  },
  Event_24545_Desc = {
    Text = "La niebla cubre tu camino.\nUna figura aparece en la luz difusa, entrecierras los ojos pero no puedes ver su rostro, solo escuchas susurros entrecortados.\n\"¿Por qué... por qué no pude salvar... el destino, realmente no puede cambiarse...?\""
  },
  Event_24545_Name = {
    Text = "Figura familiar pero extraña"
  },
  Event_35039_ChoiceDesc1 = {
    Text = "[Pedir ayuda al socio] Obtener Gravura avanzada con selección de 3"
  },
  Event_35039_ChoiceDesc2 = {
    Text = "[Realizar la coordinación del set]obtiene la reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_35039_ChoiceDesc3 = {
    Text = "[Guía de la Frenesí]Obtén creación de artefacto\"(RelicConfig.Arg1)\""
  },
  Event_35039_Desc = {
    Text = "\"En la 'Guía del Set del Maestro Houdini' se establece claramente que Casiah, es decir, yo misma, como productora y directora, tengo la obligación y el poder de ser responsable de toda la película. Así que, valiente empleado de Casiah, ¡por favor elige tu próximo cronograma de acciones!\"\n\"¿C-cronograma? ¡Espera, ¿cuándo me convertí en tu empleado?!\"\n\"Las oportunidades no esperan, ¡no dudes más!\""
  },
  Event_35039_Name = {
    Text = "El mito del productor"
  },
  Event_35103_ChoiceDesc1 = {
    Text = "[Conectar] recuperar Arg2 puntos de vida [ExDesc1][ExDesc2]"
  },
  Event_35103_ChoiceDesc2 = {
    Text = "[Meditación]Elige despertar a un Despertado"
  },
  Event_35103_ChoiceDesc3 = {
    Text = "[Expulsar]Elimina hasta 3 cartas de síntoma y obtén Arg2 sigilos negros"
  },
  Event_35103_Desc = {
    Text = "Exploras en la niebla, de repente, el emblema en tu pecho emite un débil resplandor plateado. ¿Quién te llama desde el comunicador?"
  },
  Event_35103_Name = {
    Text = "Punto de contacto"
  },
  Event_35103_Tips3 = {
    Text = "Actualmente no posees una carta de síntomas"
  },
  Event_35165_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35165_Desc = {
    Text = "Dudando, enviaste activamente una solicitud de comunicación al misterioso benefactor. \n\"Dado que hemos llegado a este punto, no hay vuelta atrás. Por favor, noble, sea generoso...\" \n Al otro lado del comunicador de Núcleo de plata, llegó una risa especialmente exuberante, y finalmente la otra parte aceptó tu solicitud con una sonrisa. \n\"Por cierto, además... por favor, mantenga esto en secreto de Ramona.\""
  },
  Event_35165_Name = {
    Text = "El mito del productor"
  },
  Event_35236_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35236_Desc = {
    Text = "¿Qué hace un régidor de rodaje? Sacaste un montón de documentos que Casiah había metido en el transcriptor de Gnosis en algún momento, y comenzaste a revisarlos detenidamente. \n Luego, te empezó a doler la cabeza. \n Los gastos causados por Lotan durante la preparación del set, los bocadillos que se comieron Aurita y marrón, las solicitudes de reembolso para la compra de las bolas mágicas de Casiah... Las cuentas se presentaban ante ti una por una, y te viste obligado a agacharte en el suelo para hacer los cálculos con dolor. \n Hablando de eso, ¿qué son exactamente las bolas mágicas de Casiah?"
  },
  Event_35236_Name = {
    Text = "El mito del productor"
  },
  Event_35259_ChoiceDesc1 = {
    Text = "[Dispersar la ilusión]Contagia el síntoma [ExDesc1][ExDesc2]"
  },
  Event_35259_ChoiceDesc2 = {Text = "[Salir]"},
  Event_35259_Desc = {
    Text = "Rostros borrosos aparecen de repente, rodeándote y gimiendo desesperadamente con cuerdas vocales inexistentes"
  },
  Event_35259_Name = {Text = "Ilusión"},
  Event_35497_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35497_Desc = {
    Text = "Detrás del fenómeno frenético se necesita un promotor, y cuando se menciona \"promotor\", la imagen de una niña de pelo verde salta a la mente. \n \"¡La primera intermediaria de la Universidad de Misag, Hanna Peaslee, está a su servicio!\" \n \"Si es la primera vez que un guardián del secreto solicita un servicio, solo necesita pagar con tres comidas de curry del comedor.\""
  },
  Event_35497_Name = {
    Text = "El mito del productor"
  },
  Event_35887_ChoiceDesc1 = {Text = "[Avanzar]"},
  Event_35887_Desc = {
    Text = "Levantas la vela del barco, pero no hay nada debajo. Cuando te das cuenta, la vela también ha desaparecido.\nLa vela blanca y el rostro de la chica se convierten en un mensaje: no estás solo en tu camino"
  },
  Event_35887_Name = {
    Text = "Vela blanca pura"
  },
  Event_35888_ChoiceDesc1 = {
    Text = "[Izar vela]"
  },
  Event_35888_Desc = {
    Text = "Aquí no hay viento, pero hay un velero blanco y puro, con su vela levantándose vigorosamente, erguido sobre la tranquila superficie del mar azul. \n Vislumbras el rostro de una niña, con sus rasgos borrosos, como si estuviera a través de una fina niebla o una superficie de agua en movimiento. Su existencia parece estar aislada de todo lo que la rodea, pero es el núcleo de esta escena. \n A pesar de que su imagen fluctúa entre la claridad y la borrosidad, no hay duda de que sabes quién es."
  },
  Event_35888_Name = {
    Text = "Vela blanca pura"
  },
  Event_35894_ChoiceDesc1 = {
    Text = "[caer hacia abajo] obtiene 35 el sigilo negro， infección\"(Skill.Arg2)\"， continúa eligiendo"
  },
  Event_35894_ChoiceDesc2 = {
    Text = "[Alejarse mucho]"
  },
  Event_35894_Desc = {
    Text = "La voz de la niña se dispersaba en el aire, difusa y distante como una ilusión transitoria."
  },
  Event_35894_Name = {
    Text = "Al borde entre la vida y la muerte"
  },
  Event_35895_ChoiceDesc1 = {
    Text = "[ciclo eterno] obtiene 30 el sigilo negro， infección\"(Skill.Arg2)\"， continúa eligiendo"
  },
  Event_35895_ChoiceDesc2 = {
    Text = "[Alejarse mucho]"
  },
  Event_35895_Desc = {
    Text = "El cuerpo se siente pesado, la niebla envuelve el cuerpo débil"
  },
  Event_35895_Name = {
    Text = "Al borde entre la vida y la muerte"
  },
  Event_35896_ChoiceDesc1 = {
    Text = "[Leer el Camino de los predecesores] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_35896_ChoiceDesc2 = {
    Text = "[escribir mi propio camino]obtén reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_35896_ChoiceDesc3 = {
    Text = "[Mirar a la oscuridad]Obtén 25 el sigilo negro"
  },
  Event_35896_Desc = {
    Text = "Si exploras en el dominio por tu cuenta, no podrías estar tan seguro de tu camino como estás ahora.  \nLas huellas en el dominio se dividen en tres, cada pisada inscrita, escribe un futuro invisible"
  },
  Event_35896_Name = {Text = "Salida"},
  Event_35897_ChoiceDesc1 = {Text = "[Ayudarla]"},
  Event_35897_ChoiceDesc2 = {Text = "[Mirarla]"},
  Event_35897_Desc = {
    Text = "Ella murmuró, girando y deteniéndose frente a ti.\nAlguien perturbó su descanso, su conciencia estaba atrapada en la realidad, pero su alma permanecía en un reino perdido"
  },
  Event_35897_Name = {
    Text = "Fantasma Perdido"
  },
  Event_35898_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35898_Desc = {
    Text = "En esta oscuridad caótica, una serie de huellas borrosas se extienden, como las profundas huellas de un caminante nocturno en un desierto invisible"
  },
  Event_35898_Name = {Text = "Salida"},
  Event_35899_ChoiceDesc1 = {
    Text = "[Marcharse] Elige 1 Tarjeta de comando entre 3 para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_35899_Desc = {
    Text = "En tus ojos se refleja un faro lejano, que se erige solo en el borde de la oscuridad, emitiendo una luz tenue pero firme, como un guía en el mar nocturno, convocando a las almas perdidas a anhelar la tranquilidad de la otra orilla. \n No puedes evitar seguirlo, sin embargo, el suelo de repente deja de ser firme bajo tus pies. \n Pisaste una zona de agua oculta bajo las sombras. La superficie del agua es suave como la seda, devorando silenciosamente tus pasos."
  },
  Event_35899_Name = {Text = "parpadeo"},
  Event_35900_ChoiceDesc1 = {
    Text = "[Escucharla]"
  },
  Event_35900_ChoiceDesc2 = {
    Text = "[Ignorarla]"
  },
  Event_35900_Desc = {
    Text = "Ves la fuente de la luz, es una figura femenina.\nLa luz fluye desde su cabeza alienígena, creando un camino hacia lo desconocido.\n\"Regresa... a Li@2ya...\""
  },
  Event_35900_Name = {Text = "Luz eterna"},
  Event_35901_ChoiceDesc1 = {
    Text = "[Acércate al Faro]"
  },
  Event_35901_ChoiceDesc2 = {
    Text = "[Alejarse del faro]"
  },
  Event_35901_Desc = {
    Text = "Al girar en la esquina donde se entrelazan la realidad y el sueño, en ese instante fugaz, se despliega ante ti una aterradora imagen de tormenta. \nComo si una enorme mano invisible la levantara, el viento ruge como una bestia, levantando polvo y esperanza, el cielo es sombrío, opresivo al extremo. \nEn el corazón de la tormenta, el faro que no debería existir se erige, como un producto de la fantasía, o quizás como un vestigio de antiguas leyendas. En el escenario azotado por el viento, emite una tenue luz, solitaria y tenaz."
  },
  Event_35901_Name = {
    Text = "Centro de la tormenta"
  },
  Event_35902_ChoiceDesc1 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_35902_Desc = {
    Text = "\"En el dominio, las luces siempre brillan, y hay fantasmas con tentáculos...\"\nTulu cerró los ojos y reflexionó, y tras un momento, suspiró profundamente.\n\"El guardián de Lemuria... uno de los sirvientes de ella. Al final, ella tampoco pudo escapar de las cadenas de la obsesión.\""
  },
  Event_35902_Name = {
    Text = "El hundimiento del Sonanir"
  },
  Event_35903_ChoiceDesc1 = {
    Text = "[tocar la luz plateada]obtén 25 el sigilo negro"
  },
  Event_35903_ChoiceDesc2 = {
    Text = "[hablar con la luz plateada]obtén reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_35903_Desc = {
    Text = "Un comunicador herméticamente cerrado ha sido forzado, dejando escapar una tenue luz—probablemente la primera vez que el núcleo de plata se comunica con el mundo exterior"
  },
  Event_35903_Name = {
    Text = "Monumento de mithril"
  },
  Event_35904_ChoiceDesc1 = {
    Text = "[Salir]obtener creación\"(RelicConfig.Arg1)\""
  },
  Event_35904_Desc = {
    Text = "\"¿La mujer con la cabeza iluminada?\" Elton mostró sorpresa, evidentemente, había oído hablar de las sombras que aparecían ocasionalmente en el dominio del carguero, solo que——\n\"La noche en que se hundió el Sonanir... es decir, la noche en que desperté a Celeste, vi una sombra así en la tormenta.\"\n\"No me equivoqué en absoluto.\""
  },
  Event_35904_Name = {
    Text = "El hundimiento del Sonanir"
  },
  Event_35905_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35905_Desc = {
    Text = "El camino en el dominio está lleno de peligros y es insondable.\nTus ojos están fijos en el caos invisible, pero antes de que te consuma, Ramona, que había resuelto a los perseguidores, te agarra y te lleva en otra dirección"
  },
  Event_35905_Name = {Text = "Salida"},
  Event_35906_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35906_Desc = {
    Text = "¿Era el fruto de tu alma misteriosa? ¿Todo lo que estás experimentando es un choque entre el yo y el superyó?\nCuanto más piensas, más fuerte y claro es el ruido en tu cabeza. Tu visión se adentra en una niebla, y justo antes de ver a la persona en la niebla, tu alma te rechaza"
  },
  Event_35906_Name = {
    Text = "Destino Invertido"
  },
  Event_35907_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35907_Desc = {
    Text = "Fluye dentro de ti, convirtiéndose en una fuerza intrépida, apoyándote para atravesar la niebla y desgarrar el miedo"
  },
  Event_35907_Name = {
    Text = "Seguir la luz"
  },
  Event_35908_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35908_Desc = {
    Text = "Con la concentración de la conciencia y la calma interna, las caóticas ilusiones comienzan a disolverse lentamente, finalmente retrocediendo como las olas. \n Al final, el ruido en tu cerebro también desaparece sin dejar rastro—solo, ¿cuánto echarás de menos? No puedes saberlo."
  },
  Event_35908_Name = {
    Text = "Advertencia futura"
  },
  Event_35909_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35909_Desc = {
    Text = "El alma se pierde completamente en el zumbido, intentas liberarte y entender el dolor, pero solo rondas en el borde de la conciencia"
  },
  Event_35909_Name = {
    Text = "Al borde entre la vida y la muerte"
  },
  Event_35910_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de reliquia de oro, infecta\"(Skill.Arg1)\""
  },
  Event_35910_Desc = {
    Text = "Puedes sentir cada punto de luz del faro, ardiendo y saltando en la tormenta, como un llamado desde lo más profundo del alma, guiando el camino incluso en el miedo más intenso"
  },
  Event_35910_Name = {
    Text = "Centro de la tormenta"
  },
  Event_35911_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de oración avanzada"
  },
  Event_35911_Desc = {
    Text = "¿Es un símbolo de esperanza o un presagio de destrucción?\nDejas de mirarlo, como si su existencia fuera solo un sueño cuidadosamente orquestado"
  },
  Event_35911_Name = {
    Text = "Centro de la tormenta"
  },
  Event_35912_ChoiceDesc1 = {
    Text = "[Hundimiento nebuloso]gana 20 el sigilo negro，infección\"(Skill.Arg2)\""
  },
  Event_35912_ChoiceDesc2 = {
    Text = "[Alejarse mucho]"
  },
  Event_35912_Desc = {
    Text = "Luego, una capa de niebla gris cubrió tus ojos. Pronto te diste cuenta de que era tu párpado superior translúcido"
  },
  Event_35912_Name = {
    Text = "Al borde entre la vida y la muerte"
  },
  Event_35913_ChoiceDesc1 = {
    Text = "[Salir]Despertar 1 Despertado al azar, infectar\"(Skill.Arg1)\""
  },
  Event_35913_Desc = {
    Text = "Sientes una resonancia inexplicable en tu corazón.\nPero la razón te dice: ignórala"
  },
  Event_35913_Name = {Text = "Luz eterna"},
  Event_35914_ChoiceDesc1 = {
    Text = "[Marcharse] Elige 1 Tarjeta de comando entre 3 para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_35914_Desc = {
    Text = "Su lengua nunca ha sido grabada en ninguna inscripción conocida, pero ha cristalizado en el aire como el arrepentimiento y la llamada más profundos. Como si flotara desde el otro lado del tiempo, atravesando la sedimentación de los años, cargando con un profundo anhelo por un hogar distante"
  },
  Event_35914_Name = {Text = "Luz eterna"},
  Event_35915_ChoiceDesc1 = {
    Text = "[Sostener su mano]Gana aleatoriamente 1 reliquia de plata y mejora a reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_35915_ChoiceDesc2 = {
    Text = "[Expresar preocupación]obtener reliquia de plata\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_35915_ChoiceDesc3 = {
    Text = "[Fijarse en ella]gana 25 el sigilo negro"
  },
  Event_35915_Desc = {
    Text = "Murphy quedó al final del grupo, caminando junto a Celeste en la retaguardia.\nNo pudiste evitar mirar hacia atrás frecuentemente, pero Murphy siempre mantuvo la mirada baja, observando las puntas de sus zapatos, escondiendo su expresión en lo desconocido."
  },
  Event_35915_Name = {
    Text = "Gestión del dolor"
  },
  Event_35915_Tips1 = {
    Text = "No poseo todavía la reliquia de plata"
  },
  Event_35916_ChoiceDesc1 = {
    Text = "[Sin poder moverse]obtener 40 el sigilo negro，infectar\"(Skill.Arg2)\"，continuar eligiendo"
  },
  Event_35916_ChoiceDesc2 = {
    Text = "[Abrazar la realidad]obtienes 25 el sigilo negro"
  },
  Event_35916_Desc = {
    Text = "@1@1Renacer, el alma cruza el borde de @2, pero aún no ha abrazado completamente el cuerpo.\nLas palabras preocupadas de Murphy se alejan de tu conciencia, como el lamento de un cuervo, resonando en tus oídos, pero siempre bloqueadas por las barreras de tu mente"
  },
  Event_35916_Name = {
    Text = "Al borde entre la vida y la muerte"
  },
  Event_35917_ChoiceDesc1 = {
    Text = "[Salir]Copiar 1 carta de comando, infectar\"(Skill.Arg1)\""
  },
  Event_35917_Desc = {
    Text = "Ella solo es un fantasma en el mundo real, un fragmento antiguo que no se puede tocar ni olvidar"
  },
  Event_35917_Name = {
    Text = "Fantasma Perdido"
  },
  Event_35918_ChoiceDesc1 = {
    Text = "[Salir]de 3 cartas de comando selecciona 1 para obtener oración:\"(EnchantConfig.Arg1)\""
  },
  Event_35918_Desc = {
    Text = "En ese instante, escuchaste el sutil sonido de la ruptura en lo profundo del alma. Como un humo que se disipa gradualmente, su imagen comenzó a difuminarse, volviéndose cada vez más irreal. \nElla no existe aquí, esto es solo una proyección de los recuerdos del capitán Elton. \nPero lo que permanece en el corazón, su pérdida y confusión, no parece ser falso."
  },
  Event_35918_Name = {
    Text = "Fantasma Perdido"
  },
  Event_35919_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35919_Desc = {
    Text = "En el momento en que tus dedos tocan, una sensación compleja surge repentinamente—es tanto ardiente como helada.\nLas almas olvidadas por el mundo claman por la eternidad"
  },
  Event_35919_Name = {
    Text = "Monumento de mithril"
  },
  Event_35920_ChoiceDesc1 = {
    Text = "[Apretar la chispa]aumentar Arg1 salud máxima"
  },
  Event_35920_ChoiceDesc2 = {
    Text = "[Enfrentar el interior] 2 Tarjetas de comando aleatorias obtienen Inscripción: \"(EnchantConfig.Arg1)\", infectar 2 \"(Skill.Arg2)\""
  },
  Event_35920_Desc = {
    Text = "En esta caza monumental, la persecución de Goliath es como una bestia nocturna, intentando devorar toda esperanza. Sin embargo, esta persecución despiadada no te congeló, sino que encendió una chispa en tu interior, que se extendió y ardió cada vez más"
  },
  Event_35920_Name = {
    Text = "Seguir la luz"
  },
  Event_35921_ChoiceDesc1 = {
    Text = "[interpretarlo]roba aleatoriamente 3 cartas de comando del mazo y selecciona 1 para copiar"
  },
  Event_35921_ChoiceDesc2 = {
    Text = "[Convertirse en ello] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_35921_ChoiceDesc3 = {
    Text = "[Ignorar esto]gana 25 el sigilo negro"
  },
  Event_35921_Desc = {
    Text = "En el instante en que das un paso, una vibración invisible agarra tu consciencia, obligándote a mirar hacia el límite del dominio del caos ilusorio"
  },
  Event_35921_Name = {
    Text = "Advertencia futura"
  },
  Event_35922_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35922_Desc = {
    Text = "Hay colores extraños y fascinantes danzando ante tus ojos, hay susurros de sonidos a tu alrededor, o escenas fugaces y rostros borrosos que se entrelazan, como si contaran una y otra historia desconocida. Estas ilusiones te hacen sentir que te separas gradualmente de la realidad, cayendo en un sueño que es tanto familiar como extraño."
  },
  Event_35922_Name = {
    Text = "Advertencia futura"
  },
  Event_35923_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35923_Desc = {
    Text = "El temblor no proviene del ruido externo o de una vibración táctil, sino de una indescriptible premonición en lo profundo de tu corazón. Como un llamado del futuro, pulsando en tu percepción"
  },
  Event_35923_Name = {
    Text = "Advertencia futura"
  },
  Event_35924_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35924_Desc = {
    Text = "Ella, sin darse cuenta, llevó la mano al pecho, tratando de controlar esa sensación asfixiante.\nEse miedo la hizo apretar los dientes, forzándose a ignorar el dolor que asolaba su pecho. Cada pequeño gesto de distorsión en la cara de Murphy fue rápidamente disfrazado, ocultando su sufrimiento con una burda farsa.\n—Hasta que tomaste su mano, la sorpresa se convirtió en el color de su rostro."
  },
  Event_35924_Name = {
    Text = "Gestión del dolor"
  },
  Event_35925_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35925_Desc = {
    Text = "\"¿Murphy? ¿Estás bien?\"\n—No te responde.\nAlgo extraño y tangible corroe su corazón, casi impidiéndole respirar"
  },
  Event_35925_Name = {
    Text = "Gestión del dolor"
  },
  Event_35926_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35926_Desc = {
    Text = "Dejas de dudar y das un paso en la oscuridad desconocida. Donde caminas, trazas un mapa que se extiende hacia la luz tenue"
  },
  Event_35926_Name = {Text = "Salida"},
  Event_35927_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35927_Desc = {
    Text = "Hay una llama danzante ante ti.\nEs ardiente y viva, envolviendo una fría llama que disipa los sonidos discordantes.\nVuelves en ti y ves a Murphy mirándote con curiosidad.\n\"¿Estás realmente bien?\""
  },
  Event_35927_Name = {
    Text = "Al borde entre la vida y la muerte"
  },
  Event_35928_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35928_Desc = {
    Text = "Sientes que tu conciencia comienza a separarse, lentamente siendo arrancada de tu cuerpo.\nComo si vieras tu alma danzar con la conciencia restante de plata, y luego caer pesadamente en un abismo invisible...\nAllí hay pura nada"
  },
  Event_35928_Name = {
    Text = "Monumento de mithril"
  },
  Event_35929_ChoiceDesc1 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_35929_Desc = {
    Text = "Sin que tuvieras oportunidad de profundizar en el origen de la luz, esta vibró súbitamente y se desmoronó en el aire.\nLa luz en el dominio comenzó a generar ondas, expandiéndose en todas direcciones.\nY luego no quedó nada"
  },
  Event_35929_Name = {Text = "parpadeo"},
  Event_35930_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35930_Desc = {
    Text = "¿Cómo podría ser tú?  \nSi eso eres tú, ¿por qué Él no te salva cuando la tristeza llega?  \nSi eso eres tú, ¿por qué Él no te ayuda en el sufrimiento?  \nAsí que, todo es una ilusión"
  },
  Event_35930_Name = {
    Text = "Destino Invertido"
  },
  Event_35931_ChoiceDesc1 = {
    Text = "[Preguntar al capitán]"
  },
  Event_35931_ChoiceDesc2 = {
    Text = "[Preguntar a Tulu]"
  },
  Event_35931_Desc = {
    Text = "Una vez más, viste esa figura misteriosa entrar en la pared del camarote, desapareciendo sin dejar rastro. Su largo cabello fluorescente comenzó en algún lugar, convirtiéndose en varios tentáculos que caían al suelo. \n Sabes muy bien que, aunque no sea parte de los Marchadores de mares, su identidad debe estar profundamente relacionada con el reino perdido."
  },
  Event_35931_Name = {
    Text = "El hundimiento del Sonanir"
  },
  Event_35932_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35932_Desc = {
    Text = "Tienes miedo, todo es la adrenalina jugando trucos. \n Temes que tus decisiones dañen a aquellos que comparten la oscuridad contigo"
  },
  Event_35932_Name = {
    Text = "Seguir la luz"
  },
  Event_35933_ChoiceDesc1 = {
    Text = "[Sin escapatoria]obtener 25 el sigilo negro，infectar\"(Skill.Arg2)\"，continuar eligiendo"
  },
  Event_35933_ChoiceDesc2 = {
    Text = "[Alejarse mucho]"
  },
  Event_35933_Desc = {
    Text = "Cada nervio anhela a @2"
  },
  Event_35933_Name = {
    Text = "Al borde entre la vida y la muerte"
  },
  Event_35934_ChoiceDesc1 = {
    Text = "[Perseguir]"
  },
  Event_35934_ChoiceDesc2 = {
    Text = "[Ignorarlo]"
  },
  Event_35934_Desc = {
    Text = "En la distancia del dominio, brilla una luz tenue y encantadora. \n Brilla como el reflejo del sol en la superficie del agua, como una luz estrellada que titila, o como una pequeña llama de una vela... \n Justo cuando intentas acercarte, la luz desaparece de repente. \n Parece que te está seduciendo, como si atrajera a una polilla que vive guiándose por la intuición."
  },
  Event_35934_Name = {Text = "parpadeo"},
  Event_35935_ChoiceDesc1 = {Text = "[Salir]"},
  Event_35935_Desc = {
    Text = "¿De qué sirve preocuparse por eso?\nEres como una hoja suspendida en el aire, arrastrada por el viento del destino. Eso es todo"
  },
  Event_35935_Name = {
    Text = "Destino Invertido"
  },
  Event_35936_ChoiceDesc1 = {
    Text = "[Autoironía]gana reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_35936_ChoiceDesc2 = {
    Text = "[Interrogar hasta el final]obtiene la reliquia de oro\"(RelicConfig.Arg1)\"，contagiar\"(Skill.Arg2)\"，\"(Skill.Arg3)\""
  },
  Event_35936_ChoiceDesc3 = {
    Text = "[no pensar más]obtén 25 el sigilo negro"
  },
  Event_35936_Desc = {
    Text = "El viento de la vida acaricia tu alma, arrojándote en la vorágine de la realidad, sumido en la densa niebla del desconocido.\nNo puedes evitar preguntarte a la voz en tu cabeza: \"¿Soy yo?\""
  },
  Event_35936_Name = {
    Text = "Destino Invertido"
  },
  Event_36146_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36146_Desc = {
    Text = "Finalmente, Murphy notó tu mirada, quizás era demasiado ardiente.\nElla respiró hondo unas cuantas veces, emitiendo un suave \"hm\" desde su nariz. Al final, se unió a Celeste y te siguió de cerca"
  },
  Event_36146_Name = {
    Text = "Gestión del dolor"
  },
  Event_36722_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36722_Desc = {
    Text = "En el momento en que tus dedos tocan, una sensación compleja surge repentinamente—es tanto ardiente como helada.\nLas almas olvidadas por el mundo claman por la eternidad"
  },
  Event_36722_Name = {
    Text = "Monumento de Gnosis"
  },
  Event_36723_ChoiceDesc1 = {
    Text = "[tocar eso]despierta aleatoriamente 1 despertador, infecta\"(Skill.Arg1)\""
  },
  Event_36723_ChoiceDesc2 = {
    Text = "[Unirse a la rotación]obtener 3 de 1 oración"
  },
  Event_36723_Desc = {
    Text = "Al dar el primer paso, una grieta silenciosa se abrió en lo más profundo de tu mente. Una presencia indescriptible se filtró a través de la grieta, perturbando tu mente.\nSientes un planeta caótico plateado girando y creciendo en tu interior"
  },
  Event_36723_Name = {
    Text = "Monumento de Gnosis"
  },
  Event_36724_ChoiceDesc1 = {
    Text = "[seguirlos]obtén la reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_36724_ChoiceDesc2 = {
    Text = "[Acariciarles]obtienes reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\",\"(Skill.Arg3)\""
  },
  Event_36724_ChoiceDesc3 = {
    Text = "[no causar disturbios]obtén 25 el sigilo negro"
  },
  Event_36724_Desc = {
    Text = "Al girar una esquina inesperada, una escena extraña apareció ante ti.\nVarias sombras de gatos, apenas visibles, se deslizaban junto a las frías paredes del casco."
  },
  Event_36724_Name = {
    Text = "gato de barco"
  },
  Event_36725_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36725_Desc = {
    Text = "\"Memoria\" no responde, se queda pegada al mamparo, mirándote fijamente hasta que doblas la esquina"
  },
  Event_36725_Name = {
    Text = "Dueño del Sonanir"
  },
  Event_36726_ChoiceDesc1 = {
    Text = "[Tomar un camino diferente]elimina 1 carta de comando, gana Arg1 el sigilo negro"
  },
  Event_36726_ChoiceDesc2 = {
    Text = "[Preguntar por qué se hundió]Copiar 1 carta de comando, infectar con \"(Skill.Arg1)\""
  },
  Event_36726_ChoiceDesc3 = {
    Text = "[saludar a la tripulación] selecciona 1 de 3 cartas de comando para obtener la oración：\"(EnchantConfig.Arg1)\""
  },
  Event_36726_Desc = {
    Text = "Mientras caminabas hacia la sala de poder, encontraste nuevamente algunos\"recuerdos\"fijados en el dominio.\nNo son fantasmas, solo son la preocupación del capitán Elton por sus difuntos tripulantes"
  },
  Event_36726_Name = {
    Text = "Dueño del Sonanir"
  },
  Event_36727_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36727_Desc = {
    Text = "\"La memoria\" se despegó de la pared del compartimiento, su rostro distorsionado emitió un grito de pena.\n——El faro.\n——El faro aislado, los guió hacia la tormenta"
  },
  Event_36727_Name = {
    Text = "Dueño del Sonanir"
  },
  Event_36728_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36728_Desc = {
    Text = "Tú eliges seguir, seguir el rastro dibujado por aquellas almas suaves y libres, incluso si el camino adelante es una trampa dejada por la oscuridad"
  },
  Event_36728_Name = {
    Text = "gato de barco"
  },
  Event_36729_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36729_Desc = {
    Text = "No molestes a los muertos, no revuelvas recuerdos dormidos"
  },
  Event_36729_Name = {
    Text = "Dueño del Sonanir"
  },
  Event_36730_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36730_Desc = {
    Text = "Sientes que tu conciencia comienza a separarse, lentamente siendo arrancada de tu cuerpo.\nComo si vieras tu alma danzar con el planeta, y luego caer pesadamente en un abismo invisible...\nAllí hay pura nada"
  },
  Event_36730_Name = {
    Text = "Monumento de Gnosis"
  },
  Event_36731_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36731_Desc = {
    Text = "Como seres delicados, son lujos que este dominio no permite, son meros fantasmas.\nAunque lo entiendes, aún sientes un ligero calor en el fondo de tu corazón"
  },
  Event_36731_Name = {
    Text = "gato de barco"
  },
  Event_36732_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36732_Desc = {
    Text = "Sus sombras son borrosas como una pintura al óleo arrastrada por el torrente del tiempo y el espacio. Las manchas negras profundas son como nubes flotando en el cielo nocturno, pero sus ojos son más como el destello de estrellas distantes, emitiendo una luz misteriosa y profunda. \n No puedes resistir su tentación y extiendes la mano hacia un vacío."
  },
  Event_36732_Name = {
    Text = "gato de barco"
  },
  Event_36733_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36733_Desc = {
    Text = "Sabes que debes seguir adelante, aunque tropieces y caigas"
  },
  Event_36733_Name = {
    Text = "Dolor físico"
  },
  Event_36734_ChoiceDesc1 = {
    Text = "[Intentar llamarlo]Aumenta Arg1 de vida"
  },
  Event_36734_ChoiceDesc2 = {Text = "[Salir]"},
  Event_36734_Desc = {
    Text = "Este es un lugar lleno de deseos ocultos y temores inalcanzados, un rico lienzo tejido de sus sueños y recuerdos"
  },
  Event_36734_Name = {
    Text = "Metamorfosis Evolutiva"
  },
  Event_36735_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36735_Desc = {
    Text = "\"Guardián, si no puedes soportarlo, no sufras solo.\"\nNo evitas el dolor, es parte de la vida efímera.\nNo evitas las sombras de la noche, porque no temes ser devorado por la oscuridad"
  },
  Event_36735_Name = {
    Text = "Dolor físico"
  },
  Event_36736_ChoiceDesc1 = {
    Text = "[Seguir Llamándolo]Aumentar Arg1 de vida, infectar\"(Skill.Arg2)\""
  },
  Event_36736_ChoiceDesc2 = {Text = "[Salir]"},
  Event_36736_Desc = {
    Text = "El mundo está hecho de garabatos ingenuos"
  },
  Event_36736_Name = {
    Text = "Metamorfosis Evolutiva"
  },
  Event_36737_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36737_Desc = {
    Text = "Las oraciones de los marineros resuenan a mi alrededor, locas y sofocantes.\nPero no afectarán tu voluntad, absolutamente no"
  },
  Event_36737_Name = {Text = "del mar"},
  Event_36738_ChoiceDesc1 = {
    Text = "[Recoger la foto]elige 1 de 3 cartas de comando y obtienes sello:\"(EnchantConfig.Arg1)\""
  },
  Event_36738_Desc = {
    Text = "Estas miradas son profundas y claras, como la luz en el fondo del mar, brillantes y cálidas.\nNo hablan ni se muestran, pero puedes sentir su presencia, como una brisa suave en una noche de verano"
  },
  Event_36738_Name = {
    Text = "Buen espionaje"
  },
  Event_36739_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36739_Desc = {
    Text = "Te obligaste a concentrarte en la crisis frente a ti, exigiéndote ignorar el dolor"
  },
  Event_36739_Name = {
    Text = "Dolor físico"
  },
  Event_36740_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36740_Desc = {
    Text = "Eso es la marca de la vida, la prueba de la existencia. Narra una historia, pero bajo la furia de esta tormenta, poco a poco pierde su voz"
  },
  Event_36740_Name = {
    Text = "Adiós, Icarus"
  },
  Event_36741_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36741_Desc = {
    Text = "Estas miradas son profundas y claras, como la luz en el fondo del mar, brillantes y cálidas.\nNo hablan ni se muestran, pero puedes sentir su presencia, como una brisa suave en una noche de verano"
  },
  Event_36741_Name = {
    Text = "Buen espionaje"
  },
  Event_36742_ChoiceDesc1 = {
    Text = "[Última llamada]Recuperar Arg1 vida, infectar\"(Skill.Arg2)\""
  },
  Event_36742_ChoiceDesc2 = {Text = "[Salir]"},
  Event_36742_Desc = {
    Text = "Las grietas del dolor forman este mundo"
  },
  Event_36742_Name = {
    Text = "Metamorfosis Evolutiva"
  },
  Event_36743_ChoiceDesc1 = {
    Text = "[Abrazar el dolor]obtienes reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_36743_ChoiceDesc2 = {
    Text = "[Rechazar el dolor]obtienes reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\"y\"(Skill.Arg3)\""
  },
  Event_36743_ChoiceDesc3 = {
    Text = "[Ignorar dolor]gana 25 el sigilo negro"
  },
  Event_36743_Desc = {
    Text = "El dolor es como una roca, enraizado en la mente. La angustia que se extiende se asemeja a una enredadera, entrelazándose con cada pulgada de nervio, distorsionando tu conciencia"
  },
  Event_36743_Name = {
    Text = "Dolor físico"
  },
  Event_36744_ChoiceDesc1 = {
    Text = "[Llamarlo firmemente]Aumentar Arg1 vida, infectar\"(Skill.Arg2)\""
  },
  Event_36744_ChoiceDesc2 = {Text = "[Salir]"},
  Event_36744_Desc = {
    Text = "El anhelo de reconocimiento forma este mundo"
  },
  Event_36744_Name = {
    Text = "Metamorfosis Evolutiva"
  },
  Event_36745_ChoiceDesc1 = {
    Text = "[Fijarse en ellos]de 3 cartas de comando selecciona 1 para ganar plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_36745_ChoiceDesc2 = {
    Text = "[pedir ayuda] infección\"(Skill.Arg1)\"， reemplaza el efecto de la oración obtenida en la opción 1, puede usarse dos veces"
  },
  Event_36745_Desc = {
    Text = "En los colores en movimiento del dominio, sentiste una mirada misteriosa, son ojos invisibles escondidos en los misteriosos pliegues de este dominio.\nEn el momento en que te miraban, una intensa deseo surgió en tu interior"
  },
  Event_36745_Name = {
    Text = "Buen espionaje"
  },
  Event_36746_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36746_Desc = {
    Text = "Si no los entiendes, no podrás salir de este caos infernal.\nCuando las estrellas se reflejan en el agua, esos deseos y súplicas que laten, esas oraciones se elevan como burbujas hacia la superficie del mar, solo para ser devoradas por la oscuridad"
  },
  Event_36746_Name = {Text = "del mar"},
  Event_36747_ChoiceDesc1 = {
    Text = "[Llamarlo urgentemente]Aumenta Arg1 de vida, infecta con\"(Skill.Arg2)\""
  },
  Event_36747_ChoiceDesc2 = {Text = "[Salir]"},
  Event_36747_Desc = {
    Text = "Palabras feas forman este mundo"
  },
  Event_36747_Name = {
    Text = "Metamorfosis Evolutiva"
  },
  Event_36748_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36748_Desc = {
    Text = "Estás frente a él, viendo cómo su alma es devorada por extraños recuerdos"
  },
  Event_36748_Name = {
    Text = "Metamorfosis Evolutiva"
  },
  Event_36749_ChoiceDesc1 = {
    Text = "[Eso es lágrimas]Elimina 1 carta"
  },
  Event_36749_ChoiceDesc2 = {
    Text = "[Eso es sangre]Obtén\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_36749_Desc = {
    Text = "Unas gotas de líquido se esparcieron por la cubierta, extendiéndose silenciosamente por las grietas.\nLas marcas suaves pero firmes, cada una con un significado decisivo, tejían una imagen de vida y muerte, calma y caos, en medio del rugido del viento y el gemido del barco"
  },
  Event_36749_Name = {
    Text = "Adiós, Icarus"
  },
  Event_36750_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36750_Desc = {
    Text = "Miras fijamente las manchas que se expanden lentamente, tratando de identificar su naturaleza, pero en el borde donde se encuentran el cielo y la tierra, la diferencia entre la lluvia y la sangre se vuelve borrosa.\n¿Son lluvia? ¿Son lágrimas del océano?\nNo lo sabes"
  },
  Event_36750_Name = {
    Text = "Adiós, Icarus"
  },
  Event_36751_ChoiceDesc1 = {
    Text = "[Rechazar la misma frecuencia]obtienes reliquia de plata de 3 opciones"
  },
  Event_36751_ChoiceDesc2 = {
    Text = "[Unirse a la misma frecuencia]obtener reliquia de plata\"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\"，infectar dos veces\"(Skill.Arg3)\""
  },
  Event_36751_Desc = {
    Text = "El susurro del marinero se entrelaza con el latido del \"Niño Santo\", creando una sinfonía oculta; cada vibración provoca un rugido en el ilimitado universo líquido"
  },
  Event_36751_Name = {Text = "del mar"},
  Event_36752_ChoiceDesc1 = {
    Text = "[Recoger la foto]elige 1 de 3 cartas de comando y obtienes sello:\"(EnchantConfig.Arg1)\""
  },
  Event_36752_ChoiceDesc2 = {
    Text = "[Revisar película]infección\"(Skill.Arg1)\"，cambia la plegaria obtenida en la opción 1, que se puede usar una vez más"
  },
  Event_36752_Desc = {
    Text = "No tienen mala intención, esta sensación es como una intuición, arraigada en tu sangre y huesos. \nAsí que dejas de lado la alerta y tratas de pedir ayuda a estos vigilantes ocultos: confías tus confusiones y deseos a esa presencia tenue, como si le contaras a un viejo amigo tus preocupaciones, de manera muy sincera."
  },
  Event_36752_Name = {
    Text = "Buen espionaje"
  },
  Event_36874_ChoiceDesc1 = {
    Text = "[narrar anécdotas de la escuela]obtén la reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_36874_ChoiceDesc2 = {
    Text = "[Nunca fui a la escuela]gana 75 el sigilo negro，infección\"(Skill.Arg2)\""
  },
  Event_36874_Desc = {
    Text = "Al pasar por unas ruinas, los ojos de aurita brillaron de repente.\n\"Abuela dijo que antes era una escuela, pero ya está en ruinas porque no había estudiantes!\"\n\"aurita nunca ha ido a la escuela, ¿y los amigos? ¿Has ido a la escuela?\""
  },
  Event_36874_Name = {
    Text = "Alegría Perdida"
  },
  Event_36875_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36875_Desc = {
    Text = "Recibiendo una respuesta negativa de tu boca, aurita movió la cabeza con desánimo.\n\"Así que, ¿no hay estudiantes en el mundo exterior...? ¿Para qué se construyeron las escuelas al principio?\""
  },
  Event_36875_Name = {
    Text = "Alegría Perdida"
  },
  Event_36876_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36876_Desc = {
    Text = "\"Casa de pobres, ratón, estatua de cera... ¡Hurra! ¡Una aventura, es una aventura!\"\nAurita dijo, mientras un signo de interrogación invisible flotaba sobre su cabeza. \n\"Sin embargo, la abuela dijo que la escuela es un lugar que hará a Aurita más inteligente, pero...\"\nAntes de que Aurita continuara reflexionando, la empujaste a dar otra vuelta."
  },
  Event_36876_Name = {
    Text = "Alegría Perdida"
  },
  Event_36877_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36877_Desc = {
    Text = "\"¿Para, por qué?\"\nAurita se asustó por ti, manteniendo una expresión seria mientras te dirigía. \n\"Aquí es la casa de Aurita, Aurita sabe que la plaza está justo adentro de eso.\""
  },
  Event_36877_Name = {
    Text = "Oscuridad invisible"
  },
  Event_36878_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36878_Desc = {
    Text = "\"No quiero tomar este camino, ¿Aurita sabe otros métodos para llegar a la plaza?\"\nAurita frunció el ceño, sintiéndose algo confundida, pero al final tiró de tu capa y se dirigió hacia otra dirección"
  },
  Event_36878_Name = {
    Text = "Oscuridad invisible"
  },
  Event_36879_ChoiceDesc1 = {Text = "[Salir]"},
  Event_36879_Desc = {
    Text = "Esto es un sueño, esto es solo un sueño.  \nTe adviertes repetidamente, o digamos, te consuelas a ti mismo, llevando a Aurita a adentrarse en una oscuridad invisible"
  },
  Event_36879_Name = {
    Text = "Oscuridad invisible"
  },
  Event_36880_ChoiceDesc1 = {
    Text = "[obedecerla] selecciona 1 de 3 cartas de comando para obtener la oración：\"(EnchantConfig.Arg1)\"， infección\"(Skill.Arg2)\""
  },
  Event_36880_ChoiceDesc2 = {
    Text = "[Oponerse a Ella]Elige despertar a un Despertado, infecta\"(Skill.Arg1)\""
  },
  Event_36880_ChoiceDesc3 = {
    Text = "[consultarle] obtiene 25 el sigilo negro"
  },
  Event_36880_Desc = {
    Text = "Aurita te toma de la capa, avanzando paso a paso sobre tus huellas. \n\"¡Eh... no es así! ¡La plaza está en esa dirección!\" \n Te giras hacia la dirección que Aurita señala, y el callejón en el dominio parece completamente oscuro. D-Slime y los Mutantes se retuercen y entrelazan, arrastrando también al mundo real hacia el abismo de la caída."
  },
  Event_36880_Name = {
    Text = "Oscuridad invisible"
  },
  Event_37983_ChoiceDesc1 = {
    Text = "[Obtener fondos]gana Arg1 el sigilo negro"
  },
  Event_37983_ChoiceDesc2 = {
    Text = "[Obtener fondos]gana Arg1 el sigilo negro[ExDesc1]"
  },
  Event_37983_Desc = {
    Text = "\"Ningún señor permitiría que un extraño sin antecedentes se quedara, y mucho menos un monje.\"\nLa reina se sienta en su alto trono, y en sus ojos brilla un destello de crueldad. \n\"Demuestra que eres útil de alguna otra manera, o de lo contrario...\"\n¿Otra manera? Miras hacia los campos desolados fuera de la ventana, y de repente surge una idea: ¿quizás podrías usar tus conocimientos de economía para ayudar a Wanda a gestionar la finca? \nTe esfuerzas por raspar en tu cerebro estéril y liso—debemos recordar que en Misaq, la economía es solo una asignatura optativa poco destacada...\nLa paciencia se agota. La reina bosteza. \n\"Decepcionante. Suéltalo—\"\nJusto en el momento en que la guillotina cae, los espíritus de grandes precursores como Adam Smith, Malthus, y David Ricardo aparecen en tu mente. \n¡División del trabajo! ¡Impuestos! ¡Población, maldita sea la población! \nTal vez, quizás, lo recordaste."
  },
  Event_37983_Name = {
    Text = "Orden secreto"
  },
  Event_37984_ChoiceDesc1 = {Text = "[Salir]"},
  Event_37984_Desc = {
    Text = "Propones la orden con valentía.\nLa reina la revisa brevemente y sonríe fríamente:\n\"Si no funciona, sabes lo que pasará.\""
  },
  Event_37984_Name = {
    Text = "Orden secreto"
  },
  Event_37985_ChoiceDesc1 = {
    Text = "[Proponer el decreto]Recibe reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_37985_ChoiceDesc2 = {
    Text = "[Proponer el decreto]Recibe reliquia maldita\"(RelicConfig.Arg1)\""
  },
  Event_37985_ChoiceDesc3 = {
    Text = "[Proponer el decreto]Recibe reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_37985_Desc = {
    Text = "\"Aceptaste mi dinero, así que trabaja para mí.\"\nLa reina, apoyada en una mano, te observa con indiferencia.\nAdmitido o no, siente curiosidad.\n\"Entonces, dime tu plan, gran reformador.\""
  },
  Event_37985_Name = {
    Text = "Orden secreto"
  },
  Event_38700_ChoiceDesc1 = {
    Text = "[Conectar] recuperar Arg2 puntos de vida [ExDesc1]"
  },
  Event_38700_ChoiceDesc2 = {
    Text = "[Meditación]Elige despertar a un Despertado"
  },
  Event_38700_ChoiceDesc3 = {
    Text = "[Expulsar]Elimina hasta 3 cartas de síntoma y obtén Arg2 sigilos negros"
  },
  Event_38700_Desc = {
    Text = "Exploras en la niebla, de repente, el emblema en tu pecho emite un débil resplandor plateado. ¿Quién te llama desde el comunicador?"
  },
  Event_38700_Name = {
    Text = "Punto de contacto"
  },
  Event_38700_Tips3 = {
    Text = "Actualmente no posees una carta de síntomas"
  },
  Event_38707_ChoiceDesc1 = {
    Text = "[Dispersar la ilusión]Contagia el síntoma"
  },
  Event_38707_ChoiceDesc2 = {
    Text = "[absorber ilusión] pierde Arg1 vida， obtiene Arg2 el sigilo negro"
  },
  Event_38707_ChoiceDesc3 = {Text = "[Salir]"},
  Event_38707_Desc = {
    Text = "Rostros borrosos aparecen de repente, rodeándote y gimiendo desesperadamente con cuerdas vocales inexistentes"
  },
  Event_38707_Name = {Text = "Ilusión"},
  Event_38715_ChoiceDesc1 = {
    Text = "[Proponer el decreto]Recibe reliquia de plata\"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\""
  },
  Event_38715_ChoiceDesc2 = {
    Text = "[Proponer el decreto]Recibe reliquia maldita\"(RelicConfig.Arg1)\""
  },
  Event_38715_ChoiceDesc3 = {
    Text = "[Proponer el decreto]Recibe reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_38715_Desc = {
    Text = "\"Aceptaste mi dinero, así que trabaja para mí.\"\nLa reina, apoyada en una mano, te observa con indiferencia.\nAdmitido o no, siente curiosidad.\n\"Entonces, dime tu plan, gran reformador.\""
  },
  Event_38715_Name = {
    Text = "Orden secreto"
  },
  Event_40452_ChoiceDesc1 = {
    Text = "[Preguntar por la Identidad] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_40452_ChoiceDesc2 = {
    Text = "[Salir]gana aleatoriamente 3 cartas de comando y recibe plegaria:\"(EnchantConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_40452_Desc = {
    Text = [[
Tres fantasmas detienen tu avance.
Rodean una mesa de apuestas, observando los dados atentamente.
"Glub, glub."
Los dados caen una y otra vez.
Un juego eterno sin fin]]
  },
  Event_40452_Name = {
    Text = "Juego sin fin"
  },
  Event_40453_ChoiceDesc1 = {Text = "[Salir]"},
  Event_40453_Desc = {
    Text = "\"Hola, somos el primer, segundo y tercer esposo de Wanda.\"\n\"¿Qué? ¿Preguntas por el cuarto esposo?\nBueno... para ser honesto, John carecía de sentido del humor, así que la señora lo convirtió en un sirviente ciego.\"\n\"Lamentamos su pérdida. Claro, solo un poco.\""
  },
  Event_40453_Name = {
    Text = "Juego sin fin"
  },
  Event_40454_ChoiceDesc1 = {
    Text = "[darle la mano]despierta aleatoriamente 1 despertador, infecta\"(Skill.Arg1)\""
  },
  Event_40454_ChoiceDesc2 = {
    Text = "[Salir]obtiene elección de 3 para 1 de oración"
  },
  Event_40454_Desc = {
    Text = "Al pasar por una celda, una mano se extiende desde dentro.\n“No me dejes, Rebecca...”\nLa voz es vieja y seca, como un fuelle roto"
  },
  Event_40454_Name = {Text = "Prisionero"},
  Event_40455_ChoiceDesc1 = {Text = "[Salir]"},
  Event_40455_Desc = {
    Text = "Una sensación pegajosa llega a tu palma — es d-baba.\nEl dueño de la voz ha desaparecido, oculto en la oscura sombra del rincón"
  },
  Event_40455_Name = {Text = "Prisionero"},
  Event_40456_ChoiceDesc1 = {Text = "[Salir]"},
  Event_40456_Desc = {
    Text = "Te fuiste sin preocuparte, perdiéndote la dramática historia detrás de la carta.\nPero, ¿qué importa?\nEl vasto océano, el amanecer y el atardecer, el desierto ecuatorial...\nEncontrarás más y perderás más"
  },
  Event_40456_Name = {
    Text = "A mi querida esposa"
  },
  Event_40457_ChoiceDesc1 = {Text = "[Salir]"},
  Event_40457_Desc = {
    Text = "En cierto sentido, no eres diferente de este prisionero.\nAún no es el momento de alertar a nadie.\nIgnoras las súplicas del prisionero y te alejas"
  },
  Event_40457_Name = {Text = "Prisionero"},
  Event_40458_ChoiceDesc1 = {
    Text = "[Desgarrar la carta]elegir 1 reliquia para convertirse en reliquia maldita\"(RelicConfig.Arg1)\""
  },
  Event_40458_ChoiceDesc2 = {
    Text = "[Ignorar carta]gana reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_40458_ChoiceDesc3 = {
    Text = "[Respuesta] recibe 25 el sigilo negro"
  },
  Event_40458_Desc = {
    Text = "Ⅰ. Carta  John Cámbrico a Wanda (hace @2 años antes del desbordamiento)\n\nUn esposo tiene derecho a disponer de su esposa, al menos en Cámbrico. \nPero claramente subestimé tu locura. Ahora mis ojos están casi ciegos, y mis extremidades están a punto de ser cortadas. \nHija del demonio. Hija del demonio... no, tú eres el demonio mismo. \nTe maldigo @1, te maldigo @2, te maldigo, te maldigo..."
  },
  Event_40458_Name = {
    Text = "A mi querida esposa"
  },
  Event_40459_ChoiceDesc1 = {Text = "[Salir]"},
  Event_40459_Desc = {
    Text = "Usaste el método más simple para romper la maldición.\nNada sucedió. El papel cayó al suelo sin vida.\nTe encoges de hombros y te vas, pero sientes que algo no está bien"
  },
  Event_40459_Name = {
    Text = "A mi querida esposa"
  },
  Event_40460_ChoiceDesc1 = {Text = "[Salir]"},
  Event_40460_Desc = {
    Text = "Pasaste por la mesa de juego sin distracciones.\nAntes de irte, los fantasmas hablaron al unísono:\n\"Por favor, saluda a nuestra ex esposa común, la señora Wanda.\""
  },
  Event_40460_Name = {
    Text = "Juego sin fin"
  },
  Event_40461_ChoiceDesc1 = {Text = "[Salir]"},
  Event_40461_Desc = {
    Text = "Escribes cuidadosamente al final de la carta:\n\"La maldición ha sido recibida, que todo esté bien.\"\nAl terminar, la carta se enciende en llamas azules de ira.\nObtienes cenizas"
  },
  Event_40461_Name = {
    Text = "A mi querida esposa"
  },
  Event_44187_ChoiceDesc1 = {
    Text = "[Enfrenta la Oscuridad][ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc2 = {
    Text = "[Enfrenta la Oscuridad][ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc3 = {
    Text = "[Evitar la oscuridad]obtiene aleatoriamente una reliquia de oro"
  },
  Event_44187_Desc = {
    Text = "El alma frente a ti está oscura y sucia—la luz y la oscuridad coexisten en ella. Ambas luchan por dominar, mientras el alma se encuentra en la confusión. \n\"Siento compasión por ellos, por esos pobres que lo han perdido todo, pero ¿no es así este mundo? \n\"Si alguien gana, alguien pierde. \n\"¿Acaso para la felicidad de los demás debo renunciar a mi propia felicidad?\""
  },
  Event_44187_Name = {
    Text = "Oscuridad interior"
  },
  Event_44188_ChoiceDesc1 = {Text = "[Salir]"},
  Event_44188_Desc = {
    Text = "\"Este es mi pecado, mi carga. ¿Cómo puedo salvarte, alma contradictoria?\""
  },
  Event_44188_Name = {
    Text = "Oscuridad interior"
  },
  Event_44299_ChoiceDesc1 = {
    Text = "[orar al obispo] purifica la reliquia de culpa, si no hay reliquia de culpa, obtiene una reliquia de oro aleatoria"
  },
  Event_44299_Desc = {
    Text = "\"He engañado, estafado y obtenido la vida que deseaba—el dinero se ha convertido en números, los manjares en comida casera, en los negocios soy firme y en la política tengo un carácter fuerte. Pero, ¿por qué, por qué no puedo olvidar a esas personas, a aquellos a quienes les he robado todo? ¿Por qué no puedo olvidar la desesperación en sus caras? \n\"El alcohol solo ofrece una escapatoria temporal, mi alma se desgarra, el dolor casi me ahoga. \n\"¿Qué debo hacer realmente?\""
  },
  Event_44299_Name = {
    Text = "Culpa y Perdón"
  },
  Event_44301_ChoiceDesc1 = {Text = "[Salir]"},
  Event_44301_Desc = {
    Text = "\"Caminas por el camino del sufrimiento, te has desviado de la gloria del Padre Dios. \n\"Vuelve, cordero extraviado, escucha la enseñanza del Padre Dios y camina por el camino recto.\""
  },
  Event_44301_Name = {
    Text = "Culpa y Perdón"
  },
  Event_44395_ChoiceDesc1 = {
    Text = "[Buscar objeto externo]el obispo asume tu 1 síntoma, ganas Arg1 el sigilo negro. Si no hay síntomas, ganas directamente el sigilo negro"
  },
  Event_44395_ChoiceDesc2 = {
    Text = "[Buscar sangre]el obispo asume tus 2 síntomas, ganas plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_44395_ChoiceDesc3 = {
    Text = "[Buscar más]el obispo asume más síntomas (al menos 4 cartas)"
  },
  Event_44395_Desc = {
    Text = "El alma ilusoria forma un contorno borroso, arrodillándose ante el alfil para mostrar su cuerpo destrozado y su corazón negro. \n\"Me has dado guía, me has dado perdón, me has dado redención, pero, oh bondadoso alfil, esto no es suficiente. \n\"Estoy en la ruina, afligido por la enfermedad. Mi vida pende de un hilo, y tú eres mi única salvación. ¡Ayúdame, alfil, para que no sufra más!\""
  },
  Event_44395_Name = {
    Text = "Bendición del Obispo"
  },
  Event_44396_ChoiceDesc1 = {
    Text = "[Saludar y salir]"
  },
  Event_44396_Desc = {
    Text = "El alfil se quita el anillo y desabrocha el broche. Las gemas azules que simbolizan al Padre Dios son colocadas una a una en las manos del alma pobre, el alfil se inclina y toma las manos de la desafortunada alma. \n\"Toma el oro y la plata que tengo, lleva todas mis posesiones—si eso es lo que necesitas. La enseñanza del Padre Dios es suficiente para vivir.\""
  },
  Event_44396_Name = {
    Text = "Bendición del Obispo"
  },
  Event_44400_ChoiceDesc1 = {
    Text = "[Sumergirse]infectar con \"(Skill.Arg1)\", despertar cuerpo al azar"
  },
  Event_44400_ChoiceDesc2 = {Text = "[Rendirse]"},
  Event_44400_Desc = {
    Text = "Las almas perdidas no quieren abandonar la oscuridad.\nSabes lo que les espera. Una vida absurda está por comenzar, y tú eres el único espectador"
  },
  Event_44400_Name = {
    Text = "Oscuridad interior"
  },
  Event_44401_ChoiceDesc1 = {
    Text = "[Rápido y ágil]obtiene Arg1 el sigilo negro"
  },
  Event_44401_ChoiceDesc2 = {
    Text = "[Arrebatar con desenfreno]gana 3 elige 1 oración avanzada, infección\"(Skill.Arg1)\""
  },
  Event_44401_Desc = {
    Text = "Las marcas negras encontradas en el dominio pueden ser sacrificadas a d-marca a cambio de proyecciones espirituales como reliquias. Se desvanecerán rápidamente a lodo negro después de salir de la zona actual"
  },
  Event_44401_Name = {
    Text = "Marca negra"
  },
  Event_44407_ChoiceDesc1 = {
    Text = "[Dispersar la ilusión]Contagia el síntoma"
  },
  Event_44407_ChoiceDesc2 = {
    Text = "[Abrazar la ilusión]obtienes 2 síntomas aleatorios, obtienes el sigilo negro Arg1"
  },
  Event_44407_ChoiceDesc3 = {Text = "[Salir]"},
  Event_44407_Desc = {
    Text = "Rostros borrosos aparecen de repente, rodeándote y gimiendo desesperadamente con cuerdas vocales inexistentes"
  },
  Event_44407_Name = {Text = "Ilusión"},
  Event_44445_ChoiceDesc1 = {
    Text = "[Salir]buscar el reflector"
  },
  Event_44445_ChoiceDesc2 = {
    Text = "[Entrar en la niebla]Pierde Arg2 de vida"
  },
  Event_44445_ChoiceDesc3 = {
    Text = "[Desprenderse de lo externo]deduce 5 el sigilo negro, gana 1 carta de\"inspiración\""
  },
  Event_44445_Desc = {
    Text = "Delante hay una densa niebla negra, entrar imprudentemente traerá desastres.\nQuizás deberías encontrar un \"faro\" para disipar la niebla"
  },
  Event_44445_Name = {
    Text = "desconocido"
  },
  Event_44469_ChoiceDesc1 = {
    Text = "[Buscar carne]el obispo asume tus 4 síntomas, ganas 3 a elegir reliquia de oro+"
  },
  Event_44469_ChoiceDesc2 = {
    Text = "[Buscar bendición]el obispo asume tus 6 síntomas, ganas 3 a elegir péndulo crono"
  },
  Event_44469_ChoiceDesc3 = {Text = "[Regresar]"},
  Event_44469_Desc = {
    Text = "El alma ilusoria forma un contorno difuso, arrodillándose ante el alfil para mostrar su cuerpo destrozado y su corazón negro residual. \n\"Me has dado guía, me has dado perdón, me has dado redención, pero, oh, bondadoso alfil, esto no es suficiente. \n\"Estoy en la ruina, afligido por la enfermedad. Mi vida pende de un hilo, y tú eres mi única redención. ¡Ayúdame, alfil, para que ya no sufra!\""
  },
  Event_44469_Name = {
    Text = "Bendición del Obispo"
  },
  Event_44474_ChoiceDesc1 = {
    Text = "[Pedir]Obtener bendición del Obispo"
  },
  Event_44474_ChoiceDesc2 = {
    Text = "[Pedir]Obtener bendición del Obispo"
  },
  Event_44474_ChoiceDesc3 = {Text = "[Salir]"},
  Event_44474_Desc = {
    Text = "\"Este es mi pecado, mi carga. ¿Cómo puedo salvarte, alma contradictoria?\""
  },
  Event_44474_Name = {
    Text = "Oscuridad interior"
  },
  Event_44911_ChoiceDesc1 = {Text = "[Salir]"},
  Event_44911_Desc = {
    Text = "\"Todo, todo... sí, quiero todo...\"\nEl alma extendió la mano, tratando en vano de agarrar el aire.\nObtuvo algo, pero no obtuvo nada"
  },
  Event_44911_Name = {
    Text = "¿Qué conseguiste"
  },
  Event_44913_ChoiceDesc1 = {Text = "[Salir]"},
  Event_44913_Desc = {
    Text = "\"Entonces solo necesito el más importante, el más importante...\"\nEl alma se agachó, desenterrando un brillante deseo de la tierra de la ilusión y sosteniéndolo en sus manos"
  },
  Event_44913_Name = {
    Text = "¿Qué conseguiste"
  },
  Event_44916_ChoiceDesc1 = {
    Text = "[Atrapar todo] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_44916_ChoiceDesc2 = {
    Text = "[Aprender a soltar] aleatoriamente 3 cartas de comando obtiene el sello: «(EnchantConfig.Arg1)», infecta «(Skill.Arg2)»"
  },
  Event_44916_Desc = {
    Text = "El alma tenue está en agonía.\nDeambula, confundida por todas las posibles elecciones y consecuencias.\n\"¿Qué debo elegir?\" susurra, \"¿Qué debo hacer?\"\n\"¿Cómo puedo tenerlo todo?\""
  },
  Event_44916_Name = {
    Text = "¿Qué conseguiste"
  },
  Event_44919_ChoiceDesc1 = {
    Text = "[Introspectar]despertar aleatoriamente 1 despertador, infectar\"(Skill.Arg1)\""
  },
  Event_44919_ChoiceDesc2 = {
    Text = "[Mirar a los demás] obtiene el sello de elegir 3"
  },
  Event_44919_Desc = {
    Text = "El alma flotante se encuentra en un dilema.\nSe detiene, vacilando entre deseos.\n\"¿Qué debo elegir?\" murmura suavemente, \"¿Qué debo hacer?\"\n\"¿Cuál es mi verdadero deseo?\""
  },
  Event_44919_Name = {
    Text = "¿Qué es lo que deseas"
  },
  Event_44920_ChoiceDesc1 = {Text = "[Salir]"},
  Event_44920_Desc = {
    Text = "\"Tienes razón, debo ver, debo ver...\"\nBaja la cabeza, mete las manos en su pecho y saca un corazón ilusorio: mitad negro como la tinta, mitad brillante como una estrella"
  },
  Event_44920_Name = {
    Text = "¿Qué es lo que deseas"
  },
  Event_44921_ChoiceDesc1 = {Text = "[Salir]"},
  Event_44921_Desc = {
    Text = "\"Sí, sí... la gente dice que otros pueden ser un espejo... tengo que ver...\"\nSe acerca a ti, mirándote con su rostro sin rasgos.\n\"¿Por qué no te sientes incómodo? Qué envidia, qué envidia...\""
  },
  Event_44921_Name = {
    Text = "¿Qué es lo que deseas"
  },
  Event_44998_ChoiceDesc1 = {Text = "[Salir]"},
  Event_44998_Desc = {
    Text = "\"Dicen que el sufrimiento actual es temporal, y que después de la muerte estaremos en los brazos del Padre Dios disfrutando de la alegría eterna. \n\"No quiero esperar hasta después de la muerte.\"\nLa sombra devora todo con avaricia, el alma se oscurece, casi fusionándose con la oscuridad que la rodea. \nQuieres hacer algo, pero te sientes impotente."
  },
  Event_44998_Name = {
    Text = "Oscuridad interior"
  },
  Event_45000_ChoiceDesc1 = {
    Text = "[Saludar y salir]"
  },
  Event_45000_Desc = {
    Text = "El obispo corta la palma con una hoja afilada, la sangre que gotea sobre la tableta se convierte en una luz azul sanadora que completa la sangre perdida del alma.\n\"Toma mi sangre, rellena tu vida—si eso es lo que necesitas. Esto es lo que el Dios Padre desea que haga.\""
  },
  Event_45000_Name = {
    Text = "Bendición del Obispo"
  },
  Event_45001_ChoiceDesc1 = {
    Text = "[Saludar y salir]"
  },
  Event_45001_Desc = {
    Text = "El alfil saca su alma de lo más profundo de su pecho. Los suaves puntos de luz se fusionan en la pizarra, convirtiéndose en una luz azul sanadora que llena todas las grietas del alma. \n\"Recibe, este es el regalo del Padre Dios, es la prueba de Su amor. Que tu cuerpo esté sano y tu alma completa, y que no sufras más.\""
  },
  Event_45001_Name = {
    Text = "Bendición del Obispo"
  },
  Event_45002_ChoiceDesc1 = {Text = "[Salir]"},
  Event_45002_Desc = {
    Text = "Te dirigiste hacia esos rostros, y al abrir los ojos de nuevo, todo estaba oscuro. Solo risas de origen desconocido resonaban a tu alrededor"
  },
  Event_45002_Name = {Text = "Ilusión"},
  Event_45036_ChoiceDesc1 = {
    Text = "[Eliminar Todas las Creaciones]"
  },
  Event_45036_Desc = {
    Text = "\"Este es mi pecado, mi carga. ¿Cómo puedo salvarte, alma contradictoria?\""
  },
  Event_45036_Name = {
    Text = "Oscuridad interior"
  },
  Event_45196_ChoiceDesc1 = {
    Text = "[Saludar y salir]"
  },
  Event_45196_Desc = {
    Text = "El alfil corta carne y hueso con una cuchilla, los huesos pálidos y la carne carmesí se fusionan en la pizarra, convirtiéndose en una luz azul sanadora que completa los huesos quebrantados del alma. \n\"Toma mi carne y hueso, rellena tu cuerpo faltante—si eso es lo que necesitas. Esto es lo que el Padre Dios desea que haga.\""
  },
  Event_45196_Name = {
    Text = "Bendición del Obispo"
  },
  Event_46144_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de reliquia de plata, infecta\"(Skill.Arg1)\""
  },
  Event_46144_Desc = {
    Text = "La figura borrosa se volvió gradualmente más clara; no era el Cuerpo de fusión, ni una Catástrofe, sino una Clementine sin alas, con su expresión habitual. \n\"Qué coincidencia, ¿también has venido a admirar la luz de la luna?\" dijo ella sonriendo, pero tú sientes un mareo, \"En una noche de niebla espesa, hay que tener mucho cuidado. \n\"Los pequeños aquí no son muy tranquilos.\""
  },
  Event_46144_Name = {
    Text = "Figura en la niebla"
  },
  Event_46145_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de reliquia de oro, infecta\"(Skill.Arg1)\""
  },
  Event_46145_Desc = {
    Text = "No muestras ninguna emoción. Una dama de repente sube al escenario. \nAbre la boca del niño con locura y empuja un palo dentro. \n\"Habla, háblame.\" \nSangre negra fluye de la boca del niño. Murmura confusamente. \n\"Una canción para mamá...\""
  },
  Event_46145_Name = {
    Text = "Ceremonia final III"
  },
  Event_47309_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47309_Desc = {
    Text = "En aquel día, Dios castigará a los perishtite con su fuerte y afilada espada, \npor el asesinato que ellos han \"cometido\".\n¿Qué? ¿Dices que esto no es justo?\nNo, este es el destino del cazador"
  },
  Event_47309_Name = {
    Text = "Canción de marinero"
  },
  Event_47310_ChoiceDesc1 = {
    Text = "[Continuar escuchando]gana reliquia maldita\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_47310_ChoiceDesc2 = {
    Text = "[Marcharse] 1 Tarjeta de comando aleatoria obtiene Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_47310_Desc = {
    Text = "Dios dijo: Que se le llame Filisteo. \nQue lleve la responsabilidad de la muerte, que cargue con la maldición de la avaricia. \nQue su camino brille, haciendo que el abismo parezca una cabellera blanca. \nEn el vasto océano, no hay tiburón más majestuoso que este. \nQue todos los seres vivos le teman y le respeten, \nhasta el momento en que llegue el juicio."
  },
  Event_47310_Name = {
    Text = "Canción de marinero"
  },
  Event_47311_ChoiceDesc1 = {
    Text = "[Salir]infectar\"(Skill.Arg1)\""
  },
  Event_47311_ChoiceDesc2 = {
    Text = "[Salir]infectar\"(Skill.Arg1)\""
  },
  Event_47311_ChoiceDesc3 = {
    Text = "[Salir]infectar\"(Skill.Arg1)\""
  },
  Event_47311_Desc = {
    Text = "El niño es un esclavo vil. \n Su amo lo trataba como a un hijo, pero fue apuñalado en la cama. \n \"Te amo, padre. Solo no quiero ser un esclavo más.\" \n Más tarde, el niño se encontró frente a la tumba de su \"padre\", recordando las palabras del sacerdote: \n <Small: No dejes la tierra que te dio vida. \n En ese momento, tus manos estarán manchadas de sangre, y morirás sin dignidad. \n Los perros salvajes, los buitres y los peces del mar te despreciarán. > \n El niño llamado Con Glen finalmente se fue. \n Escribirá su propia historia infame."
  },
  Event_47311_Name = {
    Text = "Chico en el barril"
  },
  Event_47312_ChoiceDesc1 = {
    Text = "[pasar página hacia adelante]Obtén una reliquia de plata\"(RelicConfig.Arg1)\"，elige infectar 1 vez un síntoma"
  },
  Event_47312_ChoiceDesc2 = {
    Text = "[pasar página hacia atrás]Elige 1 de 3 cartas de comando para obtener un sello:\"(EnchantConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_47312_ChoiceDesc3 = {
    Text = "[desechar]obtén 25 el sigilo negro"
  },
  Event_47312_Desc = {
    Text = "Has encontrado un libro encuadernado en papiro: \n...\nEl niño se escondía en un barril, mientras una isla de filisteos flotaba. \nEra débil, vil y ambicioso. \nCuando la gloria del gigante inmortal hacía que todos se rindieran, \nsolo el niño se escondía en las sombras, evitando que esa luz se acercara a él. \nMás tarde, fue encargado de una gran responsabilidad por Goliath. \nEn cuanto a la razón..."
  },
  Event_47312_Name = {
    Text = "Chico en el barril"
  },
  Event_47313_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47313_Desc = {
    Text = "El gigante continuó: \n\"Lo mantengo cerca porque es melancólico y divertido.\nY nunca podrá matarme.\""
  },
  Event_47313_Name = {
    Text = "Chico en el barril"
  },
  Event_47314_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47314_Desc = {
    Text = "No pudiste escuchar lo que vino después, pero la letra te recordó a otra canción:\n\"Este raro tiburón gigante, atrapado en tormentas,\nEl océano es su hogar,\nDado que la autoridad es la ley, es el gigante de la autoridad,\nEl rey del vasto océano.\""
  },
  Event_47314_Name = {
    Text = "Canción de marinero"
  },
  Event_47315_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47315_Desc = {
    Text = "No es buen momento para leer.\nDejas el libro apresuradamente, sin ver el final:\n...\nNo se esconde en las sombras por envidia.\nEs puro miedo.\nSi se expone a la luz, su alma vil será aniquilada.\nNo quedará ni ceniza"
  },
  Event_47315_Name = {
    Text = "Chico en el barril"
  },
  Event_47463_ChoiceDesc1 = {
    Text = "[entrar en hipnosis]designa a 1 despertador para que sufra una escisión espiritual, perdiendo las 4 cartas de comando iniciales"
  },
  Event_47463_Desc = {
    Text = "El doctor levantó la cabeza de sus voluminosos libros:\n\"Eres un espécimen raro, así que no te cobraré.\nPero necesito otra forma de compensación: una hipnosis.\nEs un nuevo método de tratamiento que trae conciencia completamente desnuda y sin reservas.\n¿Estás dispuesta a intentarlo?\""
  },
  Event_47463_Name = {
    Text = "\"Serpiente hipnótica\""
  },
  Event_47464_ChoiceDesc1 = {
    Text = "[Memoria brillante][ExDesc1][ExDesc2]"
  },
  Event_47464_ChoiceDesc2 = {
    Text = "[Recuerdos tenues]mejora todas las plegarias de conjunto en la baraja a plegarias avanzadas"
  },
  Event_47464_Desc = {
    Text = "Ella deambula por la playa del mar de la conciencia. \n El dobladillo de las olas lame sus pies, trayendo recuerdos dispersos a la orilla. \n Algunos brillan, otros son apagados, y algunos huelen a la temporada de lluvias en Londinium. \n ¿Cuál de esos recuerdos eliges recoger? Ella deambula por la playa del mar de la conciencia."
  },
  Event_47464_Name = {
    Text = "\"Fusión Principal\""
  },
  Event_47465_ChoiceDesc1 = {
    Text = "[Rechazar el intento] 1 Tarjeta de comando aleatoria obtiene Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_47465_ChoiceDesc2 = {
    Text = "[Romper el solvente]purificar creación de culpa"
  },
  Event_47465_ChoiceDesc3 = {
    Text = "[Aceptar el experimento]Recibe 1 péndulo crono\"(RelicConfig.Arg1)\""
  },
  Event_47465_Desc = {
    Text = "El doctor agitó el solvente verde y le dijo emocionado:\n\"Bebe un sorbo y entrarás en un sueño lúcido.\nEs una manifestación de la energía del inconsciente colectivo.\nAhora compartirás un mar de conciencia con miles de seres vivos.\n¿Quieres probarlo?\""
  },
  Event_47465_Name = {
    Text = "\"Sueño Lúcido\""
  },
  Event_47466_ChoiceDesc1 = {
    Text = "[Responder sonido] recibe 1 carta de comando del despertador de escisión espiritual"
  },
  Event_47466_Desc = {
    Text = "El cuerpo es una prisión, encarcelando personalidades fragmentadas.\nLa prisión llamada \"24\" está llena.\n\"No duermas, no estés en paz.\"\nEn la oscuridad, una voz susurra"
  },
  Event_47466_Name = {
    Text = "\"Autoconciencia\""
  },
  Event_47848_ChoiceDesc1 = {
    Text = "[Cerrar los ojos]obtiene 3 selecciona 1 reliquia de oro"
  },
  Event_47848_ChoiceDesc2 = {
    Text = "[Echar un vistazo]elegir 2 despertadores al azar y reducir el consumo de aritmética de sus cartas de despertar en 1"
  },
  Event_47848_ChoiceDesc3 = {
    Text = "[Abre los ojos]obtiene reliquia de plata\"(RelicConfig.Arg1)\"，\"(RelicConfig.Arg2)\"，\"(RelicConfig.Arg3)\""
  },
  Event_47848_Desc = {
    Text = "Antes de entrar en la hipnosis, el médico dijo: \n\"Sin mi permiso, no abras los ojos.\"\nAsí que ella cerró los ojos con fuerza, inhaló... exhaló... \nEntre el sueño y la vigilia, parecía escuchar un susurro de \"siseo\".\nLuego, se sintió bañada en una fría mirada——\nAlgo la estaba observando. \n¿Debería abrir los ojos y echar un vistazo?"
  },
  Event_47848_Name = {
    Text = "\"Serpiente hipnótica\""
  },
  Event_47876_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47876_Desc = {
    Text = "Se inclinó y recogió recuerdos brillantes.\nUno, dos... innumerables alegrías llegaron,\nAbrió los brazos y giró alrededor de ellos"
  },
  Event_47876_Name = {
    Text = "\"Fusión Principal\""
  },
  Event_47877_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47877_Desc = {
    Text = "Se agachó para recoger los tenues recuerdos.\nUno, dos... incontables pequeñeces irrumpieron,\nAbrió los brazos y los abrazó a todos."
  },
  Event_47877_Name = {
    Text = "\"Fusión Principal\""
  },
  Event_47878_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47878_Desc = {
    Text = "Rechazas ser víctima de esos extraños solventes.\nEl doctor se siente un poco decepcionado, pero no te obliga.\n\"Perdono la cobardía y la miopía de los humanos.\""
  },
  Event_47878_Name = {
    Text = "\"Sueño Lúcido\""
  },
  Event_47879_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47879_Desc = {
    Text = "¡Splash! Rompes la botella.\nEl líquido verde corroe rápidamente el suelo.\n\"Bien, un impulso ignorante. Pero espero que no vuelva a suceder.\nDe lo contrario, me pondré muy triste.\""
  },
  Event_47879_Name = {
    Text = "\"Sueño Lúcido\""
  },
  Event_47880_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47880_Desc = {
    Text = "Te lo bebes de un trago.\nGlup glup... tu cerebro y garganta burbujean.\nComo pequeños fuegos artificiales chisporroteando.\n\"Te alabo, valiente humano. Tendrás la oportunidad de tocar lo infinito.\nY yo, seré testigo de lo infinito.\""
  },
  Event_47880_Name = {
    Text = "\"Sueño Lúcido\""
  },
  Event_47881_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47881_Desc = {
    Text = "Abrió los ojos y dijo:\n\"Sí, todo esto está mal.\nDeberíamos llorar, deberíamos resistir.\"\nEn la oscuridad se escucharon susurros, recibió una respuesta amable"
  },
  Event_47881_Name = {
    Text = "\"Autoconciencia\""
  },
  Event_47900_ChoiceDesc1 = {
    Text = "[Ver la serpiente]obtiene reliquia de oro +\"(RelicConfig.Arg1)\""
  },
  Event_47900_ChoiceDesc2 = {
    Text = "[Verte]obtener creación de culpa\"(RelicConfig.Arg1)\""
  },
  Event_47900_Desc = {
    Text = "Pah.\nUn chasquido suave la trajo de vuelta a la realidad.\nEl doctor, sin que ella se diera cuenta, se acercó con ojos de color cobalto llenos de emoción.\n\"Dime, ¿qué viste?\""
  },
  Event_47900_Name = {
    Text = "\"Serpiente hipnótica\""
  },
  Event_47901_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47901_Desc = {
    Text = "Ella abrió los ojos. \n En medio de la confusión de luces y sombras, parecía ver una tranquila serpiente gigante blanca enroscada y moviéndose lentamente en la oscuridad. \n Oh, y sus ojos— \n eran de un dorado tan puro que no contenía ni una pizca de impureza. \n Sin tristeza ni alegría, sin ningún juicio, \n era suficiente para despertar a la dormilona de su pesadilla veraniega."
  },
  Event_47901_Name = {
    Text = "\"Serpiente hipnótica\""
  },
  Event_47909_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47909_Desc = {
    Text = "Ella abrió un ojo en silencio.\nLo que vio fue una luz blanca borrosa, moviéndose lentamente en la oscuridad.\nUn destello dorado pasó rápidamente, como advirtiéndole de su infracción.\nNo se atrevió a seguir mirando"
  },
  Event_47909_Name = {
    Text = "\"Serpiente hipnótica\""
  },
  Event_47910_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47910_Desc = {
    Text = "Ella sigue las instrucciones del doctor, sin abrir los ojos ni un momento.  \nEl aire frío roza a su alrededor, y permanece en su cara durante mucho tiempo.  \nNo se sabe cuánto tiempo pasó, todo volvió a la normalidad.  \nComo si nada hubiera sucedido"
  },
  Event_47910_Name = {
    Text = "\"Serpiente hipnótica\""
  },
  Event_47911_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47911_Desc = {
    Text = "\"Veo... una serpiente muy bonita.\"\nEl doctor detuvo su mano con la pluma por un momento.\n\"¿Qué tipo de serpiente?\"\n\"¡Muy bonita! De color blanco con patrones dorados...\"\nEl doctor no dijo más, apenas esbozó una sonrisa.\n\"Gracias.\""
  },
  Event_47911_Name = {
    Text = "\"Serpiente hipnótica\""
  },
  Event_47912_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47912_Desc = {
    Text = "Miró fijamente los ojos amarillos del doctor.\n\"Te vi convertirte en una serpiente.\"\n\"¿Oh? ¿Por qué estás seguro que esa era yo?\"\nPorque era misteriosa, inmóvil y compleja.\nY...\nParecía cansada, como si acabara de despertar de un sueño de mil años"
  },
  Event_47912_Name = {
    Text = "\"Serpiente hipnótica\""
  },
  Event_47992_ChoiceDesc1 = {
    Text = "[Conectar] recuperar Arg2 puntos de vida"
  },
  Event_47992_ChoiceDesc2 = {
    Text = "[Meditación]Elige despertar a un Despertado"
  },
  Event_47992_ChoiceDesc3 = {
    Text = "[Expulsar]Elimina hasta 3 cartas de síntoma y obtén Arg2 sigilos negros"
  },
  Event_47992_Desc = {
    Text = "Exploras en la niebla, de repente, el emblema en tu pecho emite un débil resplandor plateado. ¿Quién te llama desde el comunicador?"
  },
  Event_47992_Name = {
    Text = "Punto de contacto"
  },
  Event_47992_Tips3 = {
    Text = "Actualmente no posees una carta de síntomas"
  },
  Event_47993_ChoiceDesc1 = {Text = "[Salir]"},
  Event_47993_ChoiceDesc2 = {
    Text = "[Salir]aleatoriza 1 carta de comando para obtener oración:\"(EnchantConfig.Arg1)\"y copia 1 versión original de esa carta"
  },
  Event_47993_Desc = {
    Text = "Aceptas la llamada de la escuela, la voz familiar te tranquiliza. Te animas y sigues adelante"
  },
  Event_47993_Name = {
    Text = "Punto de contacto"
  },
  Event_48225_ChoiceDesc1 = {Text = "[Salir]"},
  Event_48225_Desc = {
    Text = "El gatito lamió felizmente el dorso de tu mano.\n\"Gracias, no te preocupes por mí.\nAquí las personalidades mueren y renacen constantemente,\n¡Seguramente volveré!\n¡Miau, miau, miau!\""
  },
  Event_48225_Name = {
    Text = "Últimas voluntades"
  },
  Event_48226_ChoiceDesc1 = {Text = "[Salir]"},
  Event_48226_Desc = {
    Text = "El gatito cree que no has entendido su significado, así que frotó tu dorso de la mano de manera cariñosa. \n \"Mientras tú aceptes, miau, miau te ofrecerá todos los bocadillos que tiene en secreto. \n Están bien guardados en el número 2 de la calle Cambray...\""
  },
  Event_48226_Name = {
    Text = "Últimas voluntades"
  },
  Event_48227_ChoiceDesc1 = {Text = "[Salir]"},
  Event_48227_Desc = {
    Text = "Le expresaste tus sinceras disculpas a George.\n\"Hmph, al menos tienes modales.\nGeorge considerará reducir la maldición en un 10%,\n15% como máximo—ese es el límite de George.\""
  },
  Event_48227_Name = {
    Text = "El fantasma de Jorge"
  },
  Event_48228_ChoiceDesc1 = {
    Text = "[Prometer]gana reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_48228_ChoiceDesc2 = {
    Text = "[Rechazarlo]obtienes reliquia de oro de 3 opciones，infección\"(Skill.Arg1)\""
  },
  Event_48228_ChoiceDesc3 = {
    Text = "[Mantener el silencio]obtener reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_48228_Desc = {
    Text = "\"Gato 24\"está gravemente herido, y se esfuerza por decirte: \n\"Buaaa, mi tiempo se acaba, miau. \n Tengo un amigo, es un bacalao, miau. \n Si algún día lo ves, dile que he salido de viaje, miau. \n Estaré ausente por mucho, mucho tiempo, miau. \n Le traeré muchas papas fritas sin pescado frito, miau. \n ¡Asegúrate de decírselo!\""
  },
  Event_48228_Name = {
    Text = "Últimas voluntades"
  },
  Event_48229_ChoiceDesc1 = {Text = "[Salir]"},
  Event_48229_Desc = {
    Text = "El gatito se sintió un poco decepcionado.\nPero siempre ha sido un gatito obediente y nunca fuerza a nadie.\nFinalmente cerró los ojos con tristeza"
  },
  Event_48229_Name = {
    Text = "Últimas voluntades"
  },
  Event_48230_ChoiceDesc1 = {
    Text = "[disculparse] obtiene reliquia de plata\"(RelicConfig.Arg1)\"， infección\"(Skill.Arg2)\""
  },
  Event_48230_ChoiceDesc2 = {
    Text = "[Sátiralo] obtiene reliquia de plata «(RelicConfig.Arg1)», infecta «(Skill.Arg2)»"
  },
  Event_48230_ChoiceDesc3 = {
    Text = "[Ignorar esto]gana 25 el sigilo negro"
  },
  Event_48230_Desc = {
    Text = "Un fantasma, el fantasma de George, gira sobre ustedes.\n\"George murió sin dignidad.\nPero no importa, George siempre recordará esta humillación.\nGuardia del Secreto, estás en problemas, jejeje...\""
  },
  Event_48230_Name = {
    Text = "El fantasma de Jorge"
  },
  Event_48231_ChoiceDesc1 = {Text = "[Salir]"},
  Event_48231_Desc = {
    Text = "\"Jeje, te atreviste a burlarte de George.\nNo te preocupes, mientras comes, duermes o cantas...\nGeorge estará cerca, recordándote y atormentándote.\nPara que nunca olvides tu pecado.\nNunca atraparás a un fantasma, lalala~\""
  },
  Event_48231_Name = {
    Text = "El fantasma de Jorge"
  },
  Event_48232_ChoiceDesc1 = {Text = "[Salir]"},
  Event_48232_Desc = {
    Text = "Avanzas con determinación, dejando atrás la maldición de George.\nDetrás de ti, escuchas sollozos; George empieza a llorar.\n\"Bua... ¡Yo, tan adorable, y tu trasero...!\n¡Asqueroso! ¡Asqueroso!\n¡George preferiría morir bajo el látigo de Pandia!\""
  },
  Event_48232_Name = {
    Text = "El fantasma de Jorge"
  },
  Event_49055_ChoiceDesc1 = {
    Text = "[Llamar entidades]Reducir 100 locura de todas las entidades despiertas, eliminar 1 carta de síntoma"
  },
  Event_49055_ChoiceDesc2 = {
    Text = "[Lucha intensa]Recupera Arg1 vida, infecta con 2 cartas \"(Skill.Arg2)\""
  },
  Event_49055_ChoiceDesc3 = {
    Text = "[Insertar llave de plata]Vacía toda la energía-s de llave de plata"
  },
  Event_49055_Desc = {
    Text = "El charco de sangre, vago y nebuloso, reveló su verdadera forma en el momento en que pisaste. \nSangre de color rojo oscuro extendió incontables brazos, aferrándose a tus tobillos, tirando hacia arriba, intentando arrastrarte hacia el abismo indescriptible"
  },
  Event_49055_Name = {
    Text = "Bacin de sangre"
  },
  Event_49097_ChoiceDesc1 = {Text = "[Avanzar]"},
  Event_49097_Desc = {
    Text = "Tu abdomen se revuelve, pero milagrosamente se calma en unos segundos. Por alguna razón, parece que escuchas otro latido dentro de ti"
  },
  Event_49097_Name = {
    Text = "Madre nutricia"
  },
  Event_49098_ChoiceDesc1 = {
    Text = "[Beber de un trago] Elige [ExDesc3] [ExDesc4] Tarjetas de comando para que obtengan Inscripción: [(EnchantConfig.Arg1)] [ExDesc1] [ExDesc2]"
  },
  Event_49098_Desc = {
    Text = "La vieja jarra de barro te observa desde la hendidura en la baja pared rocosa. \nLa fuente de agua es el recurso más precioso en el desierto, y el alcohol es la sustancia que induce locura y sueños. \nEn esta árida área, es difícil que una persona con razón rechace su invitación"
  },
  Event_49098_Name = {
    Text = "Madre nutricia"
  },
  Event_49312_ChoiceDesc1 = {Text = "[Salir]"},
  Event_49312_Desc = {
    Text = "La luz de la llave de plata parpadea, los brazos parecen estar atemorizados por algún poder, desvaneciéndose en el agua de la charca, y luego desaparecen"
  },
  Event_49312_Name = {
    Text = "Bacin de sangre"
  },
  Event_49313_ChoiceDesc1 = {Text = "[Salir]"},
  Event_49313_Desc = {
    Text = "Luchas con todas tus fuerzas, pero te hundes más y más, mientras en tu mente resuenan susurros malditos.\nCuando vuelves en ti, los tentáculos ensangrentados se retiran satisfechos. Te sientes extrañamente aliviado, pero parece que has perdido algo"
  },
  Event_49313_Name = {
    Text = "Bacin de sangre"
  },
  Event_49314_ChoiceDesc1 = {Text = "[Salir]"},
  Event_49314_Desc = {
    Text = "El despertador que llegó en respuesta no dudó un momento en sacarte del charco de sangre, tu brazo conectado fue desgarrado, el agua turbia salpicó, y en el agua, innumerables criaturas eran difíciles de discernir, pareciendo anhelar y devorar algo"
  },
  Event_49314_Name = {
    Text = "Bacin de sangre"
  },
  Event_49867_ChoiceDesc1 = {
    Text = "Despierta aleatoriamente y gana 50 de locura"
  },
  Event_49867_Name = {Text = "Evento"},
  Event_49907_ChoiceDesc1 = {
    Text = "[Preguntar si es real]"
  },
  Event_49907_ChoiceDesc2 = {
    Text = "[Pedir caricias]"
  },
  Event_49907_Desc = {
    Text = "\"Siempre miras con curiosidad mis cuernos, ¿hay algún problema?\"\nThais se acercó de repente a tu hombro, y el colgante de color miel osciló suavemente contra tu mejilla"
  },
  Event_49907_Name = {
    Text = "Persona con cuernos"
  },
  Event_49908_ChoiceDesc1 = {
    Text = "[Mirar hacia arriba]"
  },
  Event_49908_ChoiceDesc2 = {
    Text = "[caminar hacia thais]"
  },
  Event_49908_Desc = {
    Text = "El polvo se dispersa entre las ruinas, y fuera de una ventana rota, Thais aparece de repente. Se apoya con despreocupación en el alféizar polvoriento, señalando misteriosamente hacia la viga de arriba."
  },
  Event_49908_Name = {
    Text = "Persona furtiva"
  },
  Event_49909_ChoiceDesc1 = {
    Text = "[Salir]de 3 cartas de comando selecciona 1 para obtener oración:\"(EnchantConfig.Arg1)\""
  },
  Event_49909_Desc = {
    Text = "Levantaste la cabeza, y los tubos de cobre oxidados se extendían como una gigantesca telaraña sobre tu cabeza. Una sombra pasó volando, ¿era un gato salvaje o un monstruo escondido en las sombras?\nAl mirar de nuevo, Thais también había desaparecido"
  },
  Event_49909_Name = {
    Text = "Persona furtiva"
  },
  Event_49910_ChoiceDesc1 = {
    Text = "[Observarla]"
  },
  Event_49910_ChoiceDesc2 = {Text = "[Llamarla]"},
  Event_49910_Desc = {
    Text = "Una vez más viste \"el fantasma\". \nEsta vez, ya sabías su nombre. \nThais está de pie bajo el lejano árbol madre, orando devotamente al árbol. \nSu contorno es borroso, y su sombra parece fusionarse con la del árbol madre"
  },
  Event_49910_Name = {
    Text = "Hacedor de deseos"
  },
  Event_49911_ChoiceDesc1 = {
    Text = "[Salir]de 3 cartas de comando selecciona 1 para obtener oración:\"(EnchantConfig.Arg1)\""
  },
  Event_49911_Desc = {
    Text = "Observas a Thais a lo lejos, su figura en la tormenta apocalíptica es como una montaña sagrada, imponente e inquebrantable.\nCamina lentamente pero con firmeza, su porte es noble e inviolable, y te deja fascinado"
  },
  Event_49911_Name = {
    Text = "El inmortal"
  },
  Event_49912_ChoiceDesc1 = {
    Text = "[Salir]Copiar 1 carta de comando"
  },
  Event_49912_Desc = {
    Text = "\"¿Adivinas?\"\nElla hace un \"shh\" y se inclina más cerca, sientes la punta de su cuerno rozar tu mejilla, una sensación fría y cosquilleante"
  },
  Event_49912_Name = {
    Text = "Persona con cuernos"
  },
  Event_49913_ChoiceDesc1 = {
    Text = "[Marcharse] Elige 1 Tarjeta de comando entre 3 para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_49913_Desc = {
    Text = "\"Si quieres tocar, solo dilo, ¿crees que te rechazaría?\"\nElla se ríe suavemente mientras toma tu mano, la sensación de sus dedos es cálida y resbaladiza, casi te hace querer hundirte en ella"
  },
  Event_49913_Name = {
    Text = "Persona con cuernos"
  },
  Event_49914_ChoiceDesc1 = {
    Text = "[Salir]Despertar 1 Despertado, reducir costo de carta de despertar en 1, infectar\"(Skill.Arg1)\""
  },
  Event_49914_Desc = {
    Text = "Te arrodillas junto a los demás.\n\"Lo sabía, lo sabía, ¡la reina siempre nos ha protegido!\"\nGritos de alegría, llamados prolongados mezclados con el viento, resuenan en tu cabeza.\nAlgo crucial pasa por tu mente, pero no puedes capturarlo"
  },
  Event_49914_Name = {
    Text = "El inmortal"
  },
  Event_49915_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de reliquia de plata, infecta\"(Skill.Arg1)\""
  },
  Event_49915_Desc = {
    Text = "Le hiciste un gesto con la mano.\n\"¿Qué estás haciendo?\" Ramona te miró confundida.\n\"Allí...\"\nAntes de que pudieras terminar, la mujer ya había desaparecido.\n¿Fue una ilusión?"
  },
  Event_49915_Name = {
    Text = "Persona que arroja agua"
  },
  Event_49916_ChoiceDesc1 = {
    Text = "[Responderle]"
  },
  Event_49916_ChoiceDesc2 = {Text = "[Duda]"},
  Event_49916_Desc = {
    Text = "A lo lejos, una mujer está recogiendo agua en la orilla del río.\nParece que ha notado tu mirada y te saluda.\nNotas que su forma de girarse es algo extraña"
  },
  Event_49916_Name = {
    Text = "Persona que arroja agua"
  },
  Event_49917_ChoiceDesc1 = {
    Text = "[Salir]de 3 cartas de comando selecciona 1 para obtener oración\"(EnchantConfig.Arg1)\""
  },
  Event_49917_Desc = {
    Text = "Mientras dudabas, la mujer se giró y saltó al oasis, desapareciendo.\nNo podías creer lo que veías... ¿Tenía pezuñas de cabra?"
  },
  Event_49917_Name = {
    Text = "Persona que arroja agua"
  },
  Event_49918_ChoiceDesc1 = {
    Text = "[Salir]de 3 cartas de comando selecciona 1 para obtener oración\"(EnchantConfig.Arg1)\""
  },
  Event_49918_Desc = {
    Text = "\"Oh, Árbol Madre, escucha la oración de @1. Me bañaré en tu leche y renaceré, convirtiéndome en tu agente, caminando por ti en las arenas, permitiendo que tus raíces alcancen cada rincón de Remouahe...\"\n\nLas alternantes y cándidas oraciones resuenan por todo el espacio."
  },
  Event_49918_Name = {
    Text = "Hacedor de deseos"
  },
  Event_49919_ChoiceDesc1 = {
    Text = "[Salir]Despertar 1 Despertado al azar"
  },
  Event_49919_Desc = {
    Text = "La mirada ambigua y enigmática de Thais captó tu atención, una especie de poder engañoso te dejó aturdido, como si fueras atraído, no pudiste evitar acercarte a ella. \n\"En realidad, las cosas invisibles también existen.\"\nElla te susurró suavemente al oído, y pareces entender, pero es como si estuvieras envuelto en una capa de gasa blanca, sin poder ver con claridad. \n¿Es esta alguna profecía? De repente, Thais ya había desaparecido."
  },
  Event_49919_Name = {
    Text = "Persona furtiva"
  },
  Event_49920_ChoiceDesc1 = {
    Text = "[Mirar a lo lejos]"
  },
  Event_49920_ChoiceDesc2 = {
    Text = "[Arrodillarse]"
  },
  Event_49920_Desc = {
    Text = "Los pezuñas negras de la oveja pisan la tierra cubierta de arena.\nThais recita una oración desconocida, y un número infinito de aram se arrodillan en dirección hacia ella"
  },
  Event_49920_Name = {
    Text = "El inmortal"
  },
  Event_49921_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de reliquia de oro, infecta\"(Skill.Arg1)\""
  },
  Event_49921_Desc = {
    Text = "El gigantesco árbol extiende miles de ramas robustas, como tentáculos entrelazados, que atan firmemente las muñecas y tobillos de Thais, ignorando su lucha y resistencia, y de manera violenta la introduce en el abdomen expandido del tronco del árbol...\n\nA pesar de ser solo una sombra lejana, su dolor aún resuena en tu corazón con las ondas del agua."
  },
  Event_49921_Name = {
    Text = "Hacedor de deseos"
  },
  Event_49922_ChoiceDesc1 = {
    Text = "[Salir]obtener creación\"(RelicConfig.Arg1)\""
  },
  Event_49922_Desc = {
    Text = "Las extremidades inertes fluyen con la savia del árbol a lo largo del tronco, ella lucha con todas sus fuerzas, pero sus miembros son como gusanos retorcidos que no le obedecen. \n \"Los huesos ya se han disuelto por completo,\" los ojos y cejas de Thais están manchados de tristeza, \"ella ya es parte del árbol.\" \n \"Necesitamos el poder de revertir... el poder que trasciende el tiempo.\""
  },
  Event_49922_Name = {
    Text = "Persona corrosiva"
  },
  Event_49923_ChoiceDesc1 = {
    Text = "[Salir]de 3 cartas de comando selecciona 1 para obtener oración:\"(EnchantConfig.Arg1)\""
  },
  Event_49923_Desc = {
    Text = "\"Y, esa “ojo ciego colgado”, tiene una extraña e intensa llamada desde lo más profundo de su ser...\"\n\"¿Eh? ¿Están hablando de mí?\"\n\"MediNight elogia tu habilidad para contar historias.\"\n\nEsa noche junto al fuego, ella te sirvió una copa de vino"
  },
  Event_49923_Name = {
    Text = "Persona corrosiva"
  },
  Event_49924_ChoiceDesc1 = {
    Text = "[Abrir el Nudo del Árbol]"
  },
  Event_49924_ChoiceDesc2 = {Text = "[Recordar]"},
  Event_49924_Desc = {
    Text = "Una tumoración.\nLate de forma maligna e inflada, su frágil y transparente piel roja deja entrever un rostro retorcido y doloroso, como si estuviera a punto de romperse.\n\"Medinaet.\" thais mostró tristeza, llamando suavemente el nombre de aquel rostro"
  },
  Event_49924_Name = {
    Text = "Persona corrosiva"
  },
  Event_49939_ChoiceDesc1 = {
    Text = "[Confía en Ryker]todos los despertadores restauran Arg1 aliemus"
  },
  Event_49939_ChoiceDesc2 = {
    Text = "[Preocuparse por Ryker]elige despertar 2 cuerpos despertadores"
  },
  Event_49939_Desc = {
    Text = "\"Confía en mi buena suerte.\""
  },
  Event_49939_Name = {
    Text = "Detective de la suerte"
  },
  Event_49940_ChoiceDesc1 = {Text = "[Salir]"},
  Event_49940_Desc = {
    Text = "Ryker solo es hábil en tres cosas: exploración, escucha y lanzar dados.\nEn otras palabras, no es un experto en combate.\nTu preocupación interna es difícil de suprimir, creciendo con locura"
  },
  Event_49940_Name = {
    Text = "Detective de la suerte"
  },
  Event_49941_ChoiceDesc1 = {Text = "[Salir]"},
  Event_49941_Desc = {
    Text = "La fe es magia, él superará todos los obstáculos"
  },
  Event_49941_Name = {
    Text = "Detective de la suerte"
  },
  Event_49943_ChoiceDesc1 = {Text = "[Salir]"},
  Event_49943_Desc = {
    Text = "Te sientes avergonzado, pero miras esperanzado a Ramona, quien aún está enferma. \n\"Déjame hacerlo\". \nElla, con el rostro rojo, saca un frasco de colección nuevo de su bolso y cubre la araña rápidamente"
  },
  Event_49943_Name = {
    Text = "Araña venenosa"
  },
  Event_49944_ChoiceDesc1 = {Text = "[Salir]"},
  Event_49944_Desc = {
    Text = "Ryker hizo un chasquido con los dedos y luego extendió su dedo índice peludo hacia la gran araña que levantaba su pata delantera. \n Este tipo de especies con patrones coloridos suelen ser altamente venenosas, ibas a advertirle que tuviera cuidado, pero la araña, que hace un momento era hostil, saltó ágilmente a su nudillo y se acurrucó. \n Bueno, cada uno tiene su destino."
  },
  Event_49944_Name = {
    Text = "Araña venenosa"
  },
  Event_49945_ChoiceDesc1 = {
    Text = "[Mirar a Ramona] obtiene 3 a elegir inscripción"
  },
  Event_49945_ChoiceDesc2 = {
    Text = "[Mirar a Ryker] elige 1 de 3 cartas de comando para obtener una inscripción:\"(EnchantConfig.Arg1)\",infección\"(Skill.Arg2)\""
  },
  Event_49945_Desc = {
    Text = "Los ojos compuestos te miran fijamente. \n El dueño de los ojos compuestos retrocede un paso, mostrando sus garras y amenazándote. \n Por las patas elevadas y los apéndices que sostienen su cuerpo, parece ser realmente una rara criatura de la clase Arachnida. \n Antes de partir, las advertencias de Hellet aún resuenan: \"Tarea adicional, por favor recolecta muestras de especies locales y guárdalas en la estación de investigación local.\" \n Agitas el frasco de recolección en tu mochila, que ha estado lleno de insectos después de semanas de travesía."
  },
  Event_49945_Name = {
    Text = "Araña venenosa"
  },
  Event_49946_ChoiceDesc1 = {Text = "[Salir]"},
  Event_49946_Desc = {
    Text = "\"La codicia sin control es una enfermedad.\""
  },
  Event_49946_Name = {
    Text = "Tu respuesta"
  },
  Event_49947_ChoiceDesc1 = {Text = "[Salir]"},
  Event_49947_Desc = {
    Text = "\"Seguir el libro no te ganará el favor, niño.\""
  },
  Event_49947_Name = {
    Text = "Tu respuesta"
  },
  Event_49948_ChoiceDesc1 = {
    Text = "[Llave de oro]obtiene la reliquia de oro\"(RelicConfig.Arg1)\"，contagiar\"(Skill.Arg2)\""
  },
  Event_49948_ChoiceDesc2 = {
    Text = "[Llave de hierro]obtiene 3 selecciona 1 reliquia de oro，contagiar\"(Skill.Arg1)\""
  },
  Event_49948_ChoiceDesc3 = {
    Text = "[Llave de plata]obtiene la reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_49948_Desc = {
    Text = "Al mediodía, el vapor del río sagrado se condensa en dos fantasmas vacíos.\nLas voces difusas de las sombras te preguntan: ¿es esta la llave de oro, la llave de plata o la llave de hierro que perdiste?"
  },
  Event_49948_Name = {
    Text = "Tu respuesta"
  },
  Event_49949_ChoiceDesc1 = {Text = "[Salir]"},
  Event_49949_Desc = {
    Text = "\"La honestidad a menudo trae resultados más seguros, pero también podrías perder algo en el proceso.\""
  },
  Event_49949_Name = {
    Text = "Tu respuesta"
  },
  Event_50013_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50013_Desc = {
    Text = "Miras con atención, pero el rostro de esa persona se distorsiona con las ondas del agua, volviéndose borroso. \n\n Cuanto más fijas la vista, más se ralentiza tu respiración, y tu cerebro comienza a sentir una sensación de deslumbramiento por falta de oxígeno, hasta que escuchas la voz de Ramona llamándote, lo que te devuelve a la realidad. \n La brillante luz del sol reflejada en la superficie del agua es deslumbrante, pero parece que hay algo brillante debajo de la superficie."
  },
  Event_50013_Name = {
    Text = "Phantom de la muerte"
  },
  Event_50014_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50014_Desc = {
    Text = "La ilusión se desmorona al tocarla, tu mano queda vacía, solo el intenso dolor punzante estalla en tu sien.\nEl sol reflejado en la superficie del agua es excepcionalmente deslumbrante, pero parece que hay algo brillando bajo el agua"
  },
  Event_50014_Name = {
    Text = "Phantom de la muerte"
  },
  Event_50015_ChoiceDesc1 = {
    Text = "[esfuerzo por distinguir] obtiene reliquia de plata\"(RelicConfig.Arg1)\"， infección\"(Skill.Arg2)\""
  },
  Event_50015_ChoiceDesc2 = {
    Text = "[Extender la mano]obtener reliquia de plata\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_50015_ChoiceDesc3 = {
    Text = "[Frotar los ojos]Gana 25 el sigilo negro"
  },
  Event_50015_Desc = {
    Text = "Nubia te empuja, y una pierna se hunde en el río sagrado.\nTe esfuerzas por mantener el equilibrio, pero en las ondulaciones del agua ves un reflejo que no debería estar ahí.\nEs un joven alto con uniforme de Missaga, su cuerpo flácido sumergido en el río sagrado"
  },
  Event_50015_Name = {
    Text = "Phantom de la muerte"
  },
  Event_50016_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50016_Desc = {
    Text = "El pánico corroe tu mente, el dolor vuelve tu conciencia borrosa, te esfuerzas por desgarrarte, pero las vides se aprietan más y más, un líquido viscoso de olor extraño se filtra en tus fosas nasales, cada respiración trae consigo una desesperación pegajosa.\nRamona apuñala, Nubia escapa con una pierna rota, arrancas el último tentáculo que se adhería a tu cara, el cual tiene una capa de carne y sangre borrosa."
  },
  Event_50016_Name = {
    Text = "Le viento en la cara"
  },
  Event_50017_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50017_Desc = {
    Text = "La luz plateada se clava en el cuerpo de Nubia, la sensación de carne y sangre estallando se transmite a través de la llave de plata hasta tus dedos y muñecas.\nLos miembros retorcidos de Nubia se levantan hacia el cielo, emitiendo un grito aterrador y lamento, convirtiéndose en un líquido espeso e indeterminado."
  },
  Event_50017_Name = {
    Text = "Le viento en la cara"
  },
  Event_50018_ChoiceDesc1 = {
    Text = "[Desgarrar]obtener reliquia maldita\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_50018_ChoiceDesc2 = {
    Text = "[Atravesar] 1 Tarjeta de comando aleatoria obtiene Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_50018_Desc = {
    Text = "Los tentáculos enredados de Nubia se retuercen y vuelan, se lanzan a tu cara, invadiendo violentamente tu boca y nariz"
  },
  Event_50018_Name = {
    Text = "Le viento en la cara"
  },
  Event_50019_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50019_Desc = {
    Text = "En la superficie del agua solo hay destellos.\nLevantaste tus piernas mojadas y sacaste la arena húmeda de tus zapatos.\nLa imagen de antes sigue rondando en tu mente, sin desaparecer"
  },
  Event_50019_Name = {
    Text = "Phantom de la muerte"
  },
  Event_50029_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50029_Desc = {
    Text = "\"¿Volverá? ¿O te dejará para siempre en este vasto mar de arena?\"\n\"¿Podrá encontrarte? ¿O se perderá debido a los cambios en el viento y las dunas?\"\n\"¿Es realmente confiable la esperanza que depositas en los demás?\""
  },
  Event_50029_Name = {
    Text = "Isla Perdida"
  },
  Event_50030_ChoiceDesc1 = {
    Text = "[Buscar ayuda] aleatoriamente despierta 1 despertador, infecta «(Skill.Arg1)»"
  },
  Event_50030_ChoiceDesc2 = {
    Text = "[Avanzar juntos]elegir 1 de 3 cartas de comando y obtener oración：\"(EnchantConfig.Arg1)\""
  },
  Event_50030_Desc = {
    Text = "Una voz antigua y lejana se mezcla con el suave murmullo del agua y te pregunta. \n\"Te has perdido en la vasta arena amarilla.\"\n\"Tienes dos opciones ante ti. Tu compañero se mueve más rápido, déjale llevar la comida y el agua para buscar ayuda, y ustedes se quedarán en el lugar con el mínimo consumo.\"\n\"O pueden compartirlo todo y continuar avanzando.\""
  },
  Event_50030_Name = {
    Text = "Isla Perdida"
  },
  Event_50031_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50031_Desc = {
    Text = "\"Puede que no lleguen más lejos, pero sus espíritus y cuerpos están estrechamente unidos, obteniendo fuerza mutua.\"\n\"Esa es tu elección.\"\nDicho esto, el sol abrasador en lo alto cerró los ojos"
  },
  Event_50031_Name = {
    Text = "Isla Perdida"
  },
  Event_50064_ChoiceDesc1 = {
    Text = "[Cortar la cinta roja]eliminar 1 carta de comando, obtener Arg1 el sigilo negro"
  },
  Event_50064_ChoiceDesc2 = {
    Text = "[Confrontar]Copia 1 carta de comando, infecta con \"(Skill.Arg1)\""
  },
  Event_50064_ChoiceDesc3 = {
    Text = "[llamar a Ramona] selecciona 1 de 3 cartas de comando para obtener la oración：\"(EnchantConfig.Arg1)\""
  },
  Event_50064_Desc = {
    Text = "Casiah lanzó una cinta roja, que instantáneamente se enredó en tu maleta"
  },
  Event_50064_Name = {
    Text = "Seda entrelazada"
  },
  Event_50065_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50065_Desc = {
    Text = "El sonido intermitente de golpes claros resuena entre las tuberías sobre sus cabezas, como un fantasma bailando solo, moviendo sus brazos débiles en este espacio muerto.\nEsta imaginación despierta un antiguo miedo en tu corazón"
  },
  Event_50065_Name = {
    Text = "Escalera inquietante"
  },
  Event_50066_ChoiceDesc1 = {
    Text = "[Explorar la entrada] obtiene reliquia de plata «(RelicConfig.Arg1)»"
  },
  Event_50066_ChoiceDesc2 = {
    Text = "[Adentrarse en la cueva]gana reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_50066_Desc = {
    Text = "\"Hay una cueva aquí.\"\nThais te hace una invitación de lado. \n\"¿Quieres entrar a echar un vistazo?\"\nLa estrecha cueva es oscura y profunda, como la enorme boca de un demonio, extendiéndose hacia la oscuridad infinita. Quienquiera que pise esta tierra desolada no podrá escapar de la ominosa sensación que se eleva desde lo más profundo de su médula espinal. Parece que en cada rincón de esta cueva acechan antiguas criaturas que no se atreven a mirar la luz del sol, esperando la llegada de los intrusos."
  },
  Event_50066_Name = {
    Text = "Cueva oscura"
  },
  Event_50067_ChoiceDesc1 = {
    Text = "[Romper uno a uno]mejora aleatoriamente 1 reliquia de plata a una reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_50067_ChoiceDesc2 = {
    Text = "[rodear a dos] obtiene reliquia de plata\"(RelicConfig.Arg1)\"， infección\"(Skill.Arg2)\""
  },
  Event_50067_ChoiceDesc3 = {
    Text = "[Escuchar a escondidas]obtener 25 el sigilo negro"
  },
  Event_50067_Desc = {
    Text = "Dos aram vigilan la entrada de la fábrica.\nUno de ellos pasea desocupadamente e intenta hablar con el otro.\n\"Alguien dice que la señora Juliette está nuevamente contando los grupos que intentan atravesar el muro de tormenta.\"\n\"Espero no ser seleccionado.\""
  },
  Event_50067_Name = {
    Text = "Conserje ocioso"
  },
  Event_50067_Tips1 = {
    Text = "No poseo todavía la reliquia de plata"
  },
  Event_50068_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50068_Desc = {
    Text = "No mires, no escuches, no pienses. \n No te pongas a imaginar de dónde viene ese tono inoportuno, dirígete directamente al lugar de los restos del árbol madre"
  },
  Event_50068_Name = {
    Text = "Escalera inquietante"
  },
  Event_50069_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50069_Desc = {
    Text = "Ramona apuñala a Casiah, que agita la seda roja; Casiah se apresura a esquivar, y la seda roja que te envolvía se suelta al instante"
  },
  Event_50069_Name = {
    Text = "Seda entrelazada"
  },
  Event_50070_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50070_Desc = {
    Text = "Se dividieron en dos grupos, tú y ramona a la izquierda, ryker a la derecha, atacando desde los flancos.\nLevantas la mano como señal, y ramona y ryker atacan juntos, dos guardias aram caen sin emitir sonido"
  },
  Event_50070_Name = {
    Text = "Conserje ocioso"
  },
  Event_50071_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50071_Desc = {
    Text = "No es el momento de adentrarse en la trampa. Solo al borde de la cueva, ya sientes el mal latir en las rocas"
  },
  Event_50071_Name = {
    Text = "Cueva oscura"
  },
  Event_50072_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50072_Desc = {
    Text = "A tu señal, Ryker golpeó la cabeza del guardia aram silencioso con un dado, y luego se acercó sigilosamente a otro que seguía parloteando. \n\"Oye, hermano, si esa tal señora Juliette es una estafadora, ¿qué harías?\"\n\"No sé qué hacer.\"\n Ryker sonrió con alegría, el guardia tembló, a punto de gritar, pero Ryker le cubrió la boca y la nariz."
  },
  Event_50072_Name = {
    Text = "Conserje ocioso"
  },
  Event_50073_ChoiceDesc1 = {
    Text = "[Escuchar atentamente] Elige 1 Tarjeta de comando entre 3 para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_50073_ChoiceDesc2 = {
    Text = "[Taparse los oídos]Por cada despertar con un valor de aliemus de 50 o más, gana 15 el sigilo negro"
  },
  Event_50073_ChoiceDesc3 = {
    Text = "[Ver]gana 3 a elegir plegaria"
  },
  Event_50073_Desc = {
    Text = "Al entrar en el piso donde están los esqueletos, un hermoso tintineo suena abruptamente en la desolada fábrica abandonada, la melodía del piano resuena en contradicción con las ruinas de acero oxidado"
  },
  Event_50073_Name = {
    Text = "Escalera inquietante"
  },
  Event_50074_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50074_Desc = {
    Text = "\"Oye, hermano, si esa tal señora Juliette es una estafadora, ¿qué harías?\"\n\"No digas tonterías, desde que llegó Juliette, todo ha estado en orden. Si es una estafadora, ¿por qué ayudaría tanto a los aram?\"\nMientras charlaban, Ryker silenciosamente eligió la posición de emboscada, y dos dados volaron, derribando a los dos hombres al suelo."
  },
  Event_50074_Name = {
    Text = "Conserje ocioso"
  },
  Event_50075_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50075_Desc = {
    Text = "Reúnes valor y lo miras fijamente.\nEl ojo gigante de la cortina se retuerce en una sonrisa siniestra, tu resistencia obstinada tambalea y se derrumba"
  },
  Event_50075_Name = {
    Text = "Ojo mágico"
  },
  Event_50076_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50076_Desc = {
    Text = "Rasgaste la cortina sin distracciones.\nEl gran ojo se convirtió en un trozo de tela rota sin profundidad bajo tus manos"
  },
  Event_50076_Name = {
    Text = "Ojo mágico"
  },
  Event_50077_ChoiceDesc1 = {
    Text = "[Devuelve la mirada] obtiene reliquia de oro «(RelicConfig.Arg1)», infecta «(Skill.Arg2)»"
  },
  Event_50077_ChoiceDesc2 = {
    Text = "[Desgarrar el telón]elegir 1 de 3 cartas de comando y obtener plegaria：\"(EnchantConfig.Arg1)\""
  },
  Event_50077_Desc = {
    Text = "El telón se abrió con innumerables ojos retorcidos.\nUna enorme criatura detrás de los ojos mostró un hambre insaciable, lista para atacar"
  },
  Event_50077_Name = {
    Text = "Ojo mágico"
  },
  Event_50078_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50078_Desc = {
    Text = "Ya veo, un pedazo de chatarra se movió y golpeó el tubo de hierro"
  },
  Event_50078_Name = {
    Text = "Escalera inquietante"
  },
  Event_50079_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50079_Desc = {
    Text = "Thais entra con calma en la cueva, mientras tú la sigues explorando de cerca. \n \"¡Cuidado!\" De repente, te tiran hacia un lado y caes en un abrazo suave. Delante de ustedes, una bestia gigante y negra sale de la cueva con una rapidez imparable. \n \"Mira aquí,\" dice Thais, aún con el corazón agitado, sus ojos brillan con una tenue luz en la oscuridad, \"es probable que sea su tesoro.\""
  },
  Event_50079_Name = {
    Text = "Cueva oscura"
  },
  Event_50080_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50080_Desc = {
    Text = "Te aferraste desesperadamente al asa de la maleta, luchando contra la tela roja. \nPero esa tela roja era extremadamente poderosa, y la maleta se te escapó, esparciendo su contenido por todo el suelo"
  },
  Event_50080_Name = {
    Text = "Seda entrelazada"
  },
  Event_50081_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50081_Desc = {
    Text = [[
Odias sentirte atado.
Agarras la seda roja y la rasgas en dos con un sonido seco.
La mitad restante se desliza como una serpiente roja]]
  },
  Event_50081_Name = {
    Text = "Seda entrelazada"
  },
  Event_50276_ChoiceDesc1 = {
    Text = "[Eliminar ofrenda]gana reliquia maldita\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_50276_ChoiceDesc2 = {
    Text = "[Desatar las cuerdas] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_50276_ChoiceDesc3 = {
    Text = "[Continuar avanzando]gana 50 el sigilo negro"
  },
  Event_50276_Desc = {
    Text = "Tres aram están atados en la plataforma.\nEn sus cuerpos aparecen patrones oscuros similares a la corteza que viste en bebés, murmuran rezos"
  },
  Event_50276_Name = {
    Text = "tres ofrendas"
  },
  Event_50277_ChoiceDesc1 = {
    Text = "[Mirar fijamente]obtener reliquia de plata\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_50277_ChoiceDesc2 = {
    Text = "[Ignorar]obtener 3 opciones de plegaria"
  },
  Event_50277_Desc = {
    Text = [[
Los aram se arrodillan en la tormenta de arena.
La tormenta golpea sus cuerpos, y los granos de arena barren sus corazones piadosos.
En el torbellino de arena, parece que innumerables ojos gigantes observan la tierra torcida]]
  },
  Event_50277_Name = {
    Text = "Gigante de arena y polvo"
  },
  Event_50278_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50278_Desc = {
    Text = "Las imágenes que no quieres recordar vuelven a aparecer ante tus ojos.\nTentáculos tambaleantes, cortes de fragmentos de vidrio... \nTe sientes nauseabundo"
  },
  Event_50278_Name = {
    Text = "Viaje solitario II"
  },
  Event_50279_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50279_Desc = {
    Text = "No está aquí, no está en el peligroso clímax.\nEso es suficiente para tranquilizarte"
  },
  Event_50279_Name = {
    Text = "Viaje solitario I"
  },
  Event_50280_ChoiceDesc1 = {
    Text = "[Ataque sorpresa] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_50280_ChoiceDesc2 = {
    Text = "[ATQ]al azar 3 cartas de comando y obtener plegaria：\"(EnchantConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_50280_Desc = {
    Text = "Un Nubia luchaba en la tormenta de arena.\nSus cuatro patas se hundían en la arena, tratando de evitar ser arrastrado por el remolino"
  },
  Event_50280_Name = {
    Text = "Tormenta de arena natural"
  },
  Event_50281_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50281_Desc = {
    Text = "Entraste resueltamente, desgarrando las cuerdas entre los gritos de sorpresa de los aram. \n Un guerrero de Aran se acercó con cautela, y le arrebataste la lanza de las manos, apuntando hacia la multitud oscura."
  },
  Event_50281_Name = {
    Text = "tres ofrendas"
  },
  Event_50282_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50282_Desc = {
    Text = "La razón te dice que no volverá.\nSí, ¿quién confiaría en la promesa de un jugador?\nSolo te queda la soledad. Solo tienes soledad"
  },
  Event_50282_Name = {
    Text = "Viaje solitario III"
  },
  Event_50283_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50283_Desc = {
    Text = "¿La fiebre anómala aumentará con el renacer del árbol madre?  \n¿Podrá Ramona cuidarse sola fuera del muro de tormenta?  \nNo es momento de distraerse, pero no puedo evitar preocuparme por mi compañero"
  },
  Event_50283_Name = {
    Text = "Viaje solitario I"
  },
  Event_50284_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50284_Desc = {
    Text = "Decides enfrentarte de frente, y Nubia parece haber encontrado un raro punto de apoyo, saltando y aferrándose a tu cabeza. \n Te encuentras atrapado en un doble enredo entre la tormenta de arena y Nubia. \n \"La simple bravura no es el camino hacia la victoria,\" las frías palabras de William suenan como el mensaje de un ángel en tus oídos tapados, \"aprende a aprovechar las oportunidades.\""
  },
  Event_50284_Name = {
    Text = "Tormenta de arena natural"
  },
  Event_50285_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50285_Desc = {
    Text = "No es momento de leer el periódico"
  },
  Event_50285_Name = {
    Text = "Su recordatorio"
  },
  Event_50286_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50286_Desc = {
    Text = "No piensas, no recuerdas.\nNo quieres pensar, no quieres recordar.\nLa leyenda de Missaga terminará, pero su historia no se detendrá.\nDebes seguir adelante. Debes seguir adelante"
  },
  Event_50286_Name = {
    Text = "Viaje solitario II"
  },
  Event_50287_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50287_Desc = {
    Text = "\"Querido Guardián del Secreto: \n Espero que estés bien. \n Lamento no poder estar a tu lado durante este viaje de Lemvahi porque no he cuidado bien de mi cuerpo. \n Pero en los momentos críticos, confía en tu único asistente. \n Siempre estaré aquí cuando me necesites.\"\n Debido al tiempo, no puedes leer más. \n Pero la escritura familiar te brinda una sensación de calma y estabilidad."
  },
  Event_50287_Name = {
    Text = "Su recordatorio"
  },
  Event_50288_ChoiceDesc1 = {
    Text = "[él vendrá de nuevo]obtén reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_50288_ChoiceDesc2 = {
    Text = "[él no vendrá]obtén reliquia de oro\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_50288_Desc = {
    Text = "La última persona en irse es Ryker.\nPara detener a Casiah, eligió quedarse en la tienda.\nTe prometió que al final irrumpiría en el lugar de la ceremonia para quemar el árbol madre, y él definitivamente lo hará.\nPero ahora no ha llegado a tu lado.\nSolo te deja solo"
  },
  Event_50288_Name = {
    Text = "Viaje solitario III"
  },
  Event_50289_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50289_Desc = {
    Text = "Guruguru, tres redondas y terroríficas cosas rodando en el ritual. \nSientes que ya no eres tú mismo, la atmósfera de locura patológica del ritual te arrastra a una incertidumbre indescriptible"
  },
  Event_50289_Name = {
    Text = "tres ofrendas"
  },
  Event_50290_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50290_Desc = {
    Text = "La fe de Arlan es tan devota que están dispuestos a ser enterrados por la arena una y otra vez.\nPero al mirar hacia arriba, no hay sol en la tormenta"
  },
  Event_50290_Name = {
    Text = "Gigante de arena y polvo"
  },
  Event_50291_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50291_Desc = {
    Text = "Que el mar de arena responda a su devoción"
  },
  Event_50291_Name = {
    Text = "Gigante de arena y polvo"
  },
  Event_50292_ChoiceDesc1 = {
    Text = "[Escapar recuerdos]Aumenta aleatoriamente la calidad de plegaria de 1 carta"
  },
  Event_50292_ChoiceDesc2 = {
    Text = "[Capturar los recuerdos] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_50292_Desc = {
    Text = "El segundo en irse fue William"
  },
  Event_50292_Name = {
    Text = "Viaje solitario II"
  },
  Event_50293_ChoiceDesc1 = {
    Text = "[Estar tranquilo] obtiene 25 el sigilo negro"
  },
  Event_50293_ChoiceDesc2 = {
    Text = "[Preocuparse]obtienes reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_50293_Desc = {
    Text = "De repente, recuerdas el día en que comenzaste tu viaje. \n Ramona te recordó que preparases tu equipaje, William te preparó un manual con los registros del camino, y Ryker metió a escondidas una botella de whiskey en tu mochila. \n Ahora ya se han ido. \n\n La primera en irse fue Ramona, la fuerza de Tawil y el poder del muro de tormenta se repelieron entre sí, y ella sucumbió a la fiebre alta del camino."
  },
  Event_50293_Name = {
    Text = "Viaje solitario I"
  },
  Event_50294_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50294_Desc = {
    Text = "Atacas por sorpresa el pie de Nubia, pierde el equilibrio, varias extremidades en forma de enredadera se agitan frenéticamente en el aire, finalmente son arrastradas por la tormenta de polvo"
  },
  Event_50294_Name = {
    Text = "Tormenta de arena natural"
  },
  Event_50295_ChoiceDesc1 = {
    Text = "[Leer]Elimina 1 carta"
  },
  Event_50295_ChoiceDesc2 = {
    Text = "[Guardar]Obtener\"(RelicConfig.Arg1)\"，Infectar\"(Skill.Arg2)\""
  },
  Event_50295_Desc = {
    Text = "Ka-da, ka-da. \nBajo este altar frenético, el pesado sonido de los tambores se mezcla con el viento arenoso. En medio de los cánticos interminables, escuchas el débil sonido de una máquina de escribir—es el llamado de Missaga, calmando tu alma inquieta"
  },
  Event_50295_Name = {
    Text = "Su recordatorio"
  },
  Event_50296_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50296_Desc = {
    Text = "Ryker tiene una suerte más allá de lo mundano.\nLo que te prometió lo cumplirá, sin falta.\nSin falta"
  },
  Event_50296_Name = {
    Text = "Viaje solitario III"
  },
  Event_50297_ChoiceDesc1 = {Text = "[Salir]"},
  Event_50297_Desc = {
    Text = "No te concierne.\nLo que más necesitas ahora es contactarte y destruir los restos del árbol madre"
  },
  Event_50297_Name = {
    Text = "tres ofrendas"
  },
  Event_52373_ChoiceDesc1 = {Text = "[Salir]"},
  Event_52373_Desc = {
    Text = "Has sobrevivido. Viste inmensas montañas de tierra apiladas, cuerpos quemados.\nParece que también quemaste algo, pero eso ya no importa.\nEscuchaste, la campana del reino de Dios ya ha sonado"
  },
  Event_52373_Name = {
    Text = "Invasión de la Peste"
  },
  Event_52374_ChoiceDesc1 = {Text = "[Salir]"},
  Event_52374_Desc = {
    Text = [[
Has sobrevivido. Has visto innumerables montones de tierra apilados y cuerpos quemados.
Has luchado para proteger lo que valoras, y has pagado un alto precio por ello. Pero eso ya no importa.
Escuchas que las campanas del reino de dios ya han sonado]]
  },
  Event_52374_Name = {
    Text = "Invasión de la Peste"
  },
  Event_52375_ChoiceDesc1 = {Text = "[Salir]"},
  Event_52375_Desc = {
    Text = "La ira del gigante se ha calmado temporalmente. Las nubes se disipan, la lluvia cesa, y el viento se aquieta. El océano, como una madre eterna, acaricia suavemente la espalda de Lemuria con sus suaves mareas. Solo quedan sobre Lemuria, cuerpos destrozados y ruinas. \n Has luchado para proteger lo que valoras, y has pagado un alto precio por ello. Pero eso ya no importa. \n En el océano, has vislumbrado el contorno del Reino Divino."
  },
  Event_52375_Name = {
    Text = "El rugido del océano"
  },
  Event_52376_ChoiceDesc1 = {
    Text = "[Ofrecer sacrificios adicionales]Elimina 1 carta de comando y agrega 1 carta de cada 3 tipos de\"reino de dios fantasma\"al mazo"
  },
  Event_52376_Desc = {
    Text = "De pie ante el trono colapsado de Lemuria, ofreces el último sacrificio. \nEl abismo infinito se despliega ante ti. Te arrodillas, sonríes, las lágrimas caen por tu rostro. \n“Mira, padre, Debora. ¡Mira, mi rey supremo—el reino de Dios, ha descendido ante mí!”"
  },
  Event_52376_Name = {
    Text = "Bienvenido, Reino Divino"
  },
  Event_52377_ChoiceDesc2 = {
    Text = "[Proteger lo valioso]Pierde Arg1 vida, obtén 1 carta de síntoma aleatoria"
  },
  Event_52377_Desc = {
    Text = "Tierra. Tierra silenciosa, tierra estable. Tierra que sostiene a la humanidad, tierra eterna e inmortal. Pero la tierra tiembla. Se abre una hendidura sin fondo, y todo lo que sostiene está inestable. \n Depositas toda esperanza en la tierra, cuando la tierra comienza a temblar, ¿a dónde irás? \n Sacrifica, los ciudadanos de Lemuria te llaman. Sacrifica todo lo que tienes, para que el Reino Divino sin calamidades descienda."
  },
  Event_52377_Name = {
    Text = "Temblor de la Tierra"
  },
  Event_52378_ChoiceDesc2 = {
    Text = "[Proteger lo valioso]Pierde Arg1 vida, obtén 1 carta de síntoma aleatoria"
  },
  Event_52378_Desc = {
    Text = "Océano. El océano es la madre que gestó a Lemuria, es tu vida, tu fe. Y en este momento, el océano se levanta como el colosal dios furioso de la leyenda. Él grita, clama, transformando las suaves aguas marinas en enormes rocas duras y espinas, arrojándolas hacia todo lo que tiene delante. Él observa con indiferencia a Lemuria, que tiembla a sus pies, mirando a esos lemurianos que huyen como insectos. Él destruirá Lemuria, lo que no tiene nada que ver con Lemuria. \n Ofreced, los ciudadanos de Lemuria te llaman. Sacrificad todo lo que tenéis, para que el Reino Divino sin calamidades descienda."
  },
  Event_52378_Name = {
    Text = "El rugido del océano"
  },
  Event_52379_ChoiceDesc2 = {
    Text = "[Proteger lo valioso]Pierde Arg1 vida, obtén 1 carta de síntoma aleatoria"
  },
  Event_52379_Desc = {
    Text = "La plaga. La plaga está en todas partes. La plaga es el sirviente más sinvergüenza; cuando la ira de los dioses de la tierra y el océano ha pasado, ella sentencia aquellas muertes que no pueden ser pronunciadas. Entierra los cuerpos de tus seres queridos, quema los cuerpos de tus seres queridos, reza por aquellos que murieron para protegerse a sí mismos, que se alejen de ti tanto como sea posible. La vida y la humanidad son vulnerables ante la plaga. \nRitual de sacrificio, los ciudadanos de Lemuria te llaman. Ofrece todo lo que tienes para que el Reino Divino sin calamidades llegue."
  },
  Event_52379_Name = {
    Text = "Invasión de la Peste"
  },
  Event_52380_ChoiceDesc1 = {Text = "[Salir]"},
  Event_52380_Desc = {
    Text = "La intensa vibración se ha calmado. Las calles están manchadas con sangre roja, y bajo las casas derrumbadas, innumerables personas están enterradas. \n Has luchado para proteger lo que valoras, y has pagado un alto precio por ello. Pero eso ya no importa. \n Lo único que importa es que estás un paso más cerca del Reino Divino."
  },
  Event_52380_Name = {
    Text = "Temblor de la Tierra"
  },
  Event_52381_ChoiceDesc1 = {Text = "[Salir]"},
  Event_52381_Desc = {
    Text = "De pie ante el trono colapsado de Lemuria, recitas la última oración. \nEl abismo infinito se despliega ante ti. Te arrodillas, sonríes, las lágrimas caen por tu rostro. \n“Mira, padre, Debora. ¡Mira, mi rey supremo—el reino de Dios, ha descendido ante mí!”"
  },
  Event_52381_Name = {
    Text = "Bienvenido, Reino Divino"
  },
  Event_52382_ChoiceDesc1 = {Text = "[Salir]"},
  Event_52382_Desc = {
    Text = "La intensa vibración se ha calmado. Las calles están manchadas con sangre roja, y bajo las casas derrumbadas, innumerables personas están enterradas. \nAlgo tuyo parece haber sido también enterrado entre los escombros, pero eso ya no importa. \nLo único que importa es que estás un paso más cerca del Reino Divino."
  },
  Event_52382_Name = {
    Text = "Temblor de la Tierra"
  },
  Event_52383_ChoiceDesc1 = {Text = "[Salir]"},
  Event_52383_Desc = {
    Text = "La ira del gigante se ha calmado temporalmente. Las nubes se disipan y la lluvia cesa, el viento se aquieta. El océano, como una madre eterna, acaricia suavemente la espalda de Lemuria con sus suaves mareas. Solo quedan sobre Lemuria, cuerpos descompuestos y ruinas. \nAlgo tuyo parece haber encontrado su tumba en el mar, pero eso ya no importa. \nEn el océano, vislumbras la silueta del Reino Divino."
  },
  Event_52383_Name = {
    Text = "El rugido del océano"
  },
  Event_52384_ChoiceDesc1 = {
    Text = "[Oración devota]transforma cada carta de síntoma normal en 1 \"fantasma del reino de dios\" y gana 2 \"fantasmas del reino de dios\""
  },
  Event_52384_ChoiceDesc2 = {
    Text = "[Oración devota]transforma cada carta de síntoma normal en 1 \"fantasma del reino de dios\" y gana 2 \"fantasmas del reino de dios\""
  },
  Event_52384_Desc = {
    Text = "La tierra ya no tiembla, el océano ya no retumba, la plaga ya no ataca. El desastre ha destruido Lemuria, dejándote a ti. Levantas la vista y miras a tu alrededor, todo está en ruinas. Miras hacia tus manos, vacías. \n Pero, ¿y qué importa, respetado Gran Sacerdote? Pisar las ruinas y los cuerpos de Lemuria, sigue arrastrándote hacia adelante. \n Estás a un paso de distancia del Reino Divino."
  },
  Event_52384_Name = {
    Text = "Bienvenido, Reino Divino"
  },
  Event_53140_ChoiceDesc1 = {Text = "[Salir]"},
  Event_53140_Desc = {
    Text = "Aceptas la llamada de la escuela, la voz familiar te tranquiliza. Te animas y sigues adelante"
  },
  Event_53140_Name = {
    Text = "Punto de contacto"
  },
  Event_53141_ChoiceDesc1 = {
    Text = "[Conectar] recuperar Arg2 puntos de vida"
  },
  Event_53141_ChoiceDesc2 = {
    Text = "[Meditación]Elige despertar a un Despertado"
  },
  Event_53141_ChoiceDesc3 = {
    Text = "[Expulsar]Elimina hasta 3 cartas de síntoma y obtén Arg2 sigilos negros"
  },
  Event_53141_ChoiceDesc4 = {
    Text = "[Caer en locura]Despertar aleatoriamente 2 entidades despiertas, obtener 1 carta de síntoma aleatoria"
  },
  Event_53141_ChoiceDesc5 = {
    Text = "[Dudar]Otros"
  },
  Event_53141_Desc = {
    Text = "Exploras en la niebla, de repente, el emblema en tu pecho emite un débil resplandor plateado. ¿Quién te llama desde el comunicador?"
  },
  Event_53141_Name = {
    Text = "Punto de contacto"
  },
  Event_53141_Tips3 = {
    Text = "Actualmente no posees una carta de síntomas"
  },
  Event_53142_ChoiceDesc1 = {Text = "[Salir]"},
  Event_53142_Desc = {
    Text = "Aceptas la llamada de la escuela, la voz familiar te tranquiliza. Te animas y sigues adelante"
  },
  Event_53142_Name = {
    Text = "Punto de contacto"
  },
  Event_53143_ChoiceDesc1 = {Text = "[Salir]"},
  Event_53143_Desc = {
    Text = "Aceptas la llamada de la escuela, la voz familiar te tranquiliza. Te animas y sigues adelante"
  },
  Event_53143_Name = {
    Text = "Punto de contacto"
  },
  Event_53147_ChoiceDesc1 = {
    Text = "[Expulsar]Elimina hasta 3 cartas de síntoma y obtén Arg2 sigilos negros"
  },
  Event_53147_ChoiceDesc2 = {
    Text = "[Caer en locura]Despertar aleatoriamente 2 entidades despiertas, obtener 1 carta de síntoma aleatoria"
  },
  Event_53147_Desc = {
    Text = "Exploras en la niebla, de repente, el emblema en tu pecho emite un débil resplandor plateado. ¿Quién te llama desde el comunicador?"
  },
  Event_53147_Name = {
    Text = "Punto de contacto"
  },
  Event_53147_Tips1 = {
    Text = "Actualmente no posees una carta de síntomas"
  },
  Event_53148_ChoiceDesc1 = {Text = "[Salir]"},
  Event_53148_Desc = {
    Text = "Conectaste la comunicación. Al otro lado del comunicador, sonó una voz loca y embriagadora que te cautivó. \n\"Recuerda esto. Es el don que el reino de Dios te ha otorgado.\""
  },
  Event_53148_Name = {
    Text = "Punto de contacto"
  },
  Event_55782_ChoiceDesc1 = {
    Text = "[Cortar espinas]En la próxima batalla, la vida del enemigo aumenta 30%, el daño aumenta 15%, obtener Arg1 imágenes\"(Skill.Arg2)\""
  },
  Event_55782_ChoiceDesc2 = {
    Text = "[Cortar espinas]En la próxima batalla, la vida del enemigo aumenta 30%, el daño aumenta 15%, obtener Arg1 imágenes\"(Skill.Arg2)\""
  },
  Event_55782_ChoiceDesc3 = {
    Text = "[Apartar las espinas]Infectar con\"(Skill.Arg3)\"，Poner Arg1 cartas de imagen\"(Skill.Arg2)\"en el mazo"
  },
  Event_55782_ChoiceDesc4 = {
    Text = "[Apartar las espinas]Infectar con\"(Skill.Arg3)\"，Poner Arg1 cartas de imagen\"(Skill.Arg2)\"en el mazo"
  },
  Event_55782_ChoiceDesc5 = {
    Text = "[Dejara espinas]\"Pluma y tinta de horla\" obtiene Arg1 capas \"tinta\""
  },
  Event_55782_Desc = {
    Text = "Algo tocó tu corazón. Te detuviste y miraste hacia la esquina del jardín. Bajo las espinas, un punto de luz se movía, tratando de liberarse.\n¿Qué es eso? ¿Una mariposa? ¿Un pájaro? Te acercas"
  },
  Event_55782_Name = {
    Text = "Bendición de Muzus"
  },
  Event_55782_Tips1 = {
    Text = "En la próxima batalla, los enemigos estarán fortalecidos, no se puede elegir de nuevo"
  },
  Event_55783_ChoiceDesc1 = {
    Text = "[Crear ofrenda]elegir 3 cartas de\"imágenes\"y dejar que horla cree una\"ofrenda\"para ti"
  },
  Event_55783_ChoiceDesc2 = {Text = "[Salir]"},
  Event_55783_Desc = {
    Text = "Llegaste frente a un hermoso invernadero, y a través de la ventana, miraste hacia adentro, pero no podías ver nada. \n Una ráfaga de viento sopló, y los pétalos y hojas del invernadero fueron arrastrados por el viento, danzando y agrupándose en el aire. Entre las flores y las hojas, viste la figura de una niña. \n \"¡Ah! ¡Un visitante ha llegado al jardín!\" La niña te miró con sorpresa y nerviosismo. \"Lo siento, Colette salió... no estoy muy segura de los precios de estas flores...\" \n La niña de repente se detuvo, se acercó y te observó detenidamente. \"Ah, este visitante, siento la imagen de la poesía en ti... quizás, podríamos crear un poema juntos?\""
  },
  Event_55783_Name = {
    Text = "Regalo de la primavera"
  },
  Event_55783_Tips1 = {
    Text = "\"'Imágenes' menos de 3 cartas, no se puede combinar.\""
  },
  Event_55799_ChoiceDesc1 = {Text = "[Salir]"},
  Event_55799_Desc = {
    Text = "Las espinas revividas parecen inquietas, pero estos costos son insignificantes. En ese punto de luz, escuchas el llamado de la Musa"
  },
  Event_55799_Name = {
    Text = "Bendición de Muzus"
  },
  Event_55819_ChoiceDesc1 = {
    Text = "[Cumplir con la memoria del cuerpo]Salta la batalla y gana de inmediato, pero pierdes Arg1 puntos de vida"
  },
  Event_55819_ChoiceDesc2 = {
    Text = "[Salir]entra en batalla"
  },
  Event_55819_Desc = {
    Text = "Frente a enemigos conocidos, ya sabes cómo será la próxima batalla"
  },
  Event_55819_Name = {
    Text = "memoria muscular"
  },
  Event_55997_ChoiceDesc1 = {Text = "[Salir]"},
  Event_55997_Desc = {
    Text = "De las imágenes recopiladas, seleccionaste algunas y se las entregaste a la niña. \n \"¡Qué hermosas imágenes! Este invitado, por favor, espera... aquí. ¡Esto es una ofrenda que trae la Primavera, solo para ti!\" \n Un poema apareció en tus manos, como una flor que se abre especialmente para ti. \n Quisieras agradecer a la niña. Pero cuando levantas la vista, la figura de la niña ya ha desaparecido. En la solitaria sala de flores, solo quedan flores y hojas marchitas por doquier. \n — Eso es lo que queda de la Primavera, las cenizas que dejó tras consumirse."
  },
  Event_55997_Name = {
    Text = "Regalo de la primavera"
  },
  Event_55999_ChoiceDesc1 = {Text = "[Salir]"},
  Event_55999_Desc = {
    Text = "Las espinas te detienen. Te alejas del punto de luz, pero esa breve mirada te llena de nueva inspiración—en ese punto, escuchaste el llamado de la musa"
  },
  Event_55999_Name = {
    Text = "Bendición de Muzus"
  },
  Event_56000_ChoiceDesc1 = {Text = "[Salir]"},
  Event_56000_Desc = {
    Text = "Apartas las espinas con la mano, sufriendo algunas heridas, pero el costo es insignificante—en ese punto de luz, escuchas el llamado de la musa"
  },
  Event_56000_Name = {
    Text = "Bendición de Muzus"
  },
  Event_56024_ChoiceDesc1 = {Text = "[Salir]"},
  Event_56024_Desc = {
    Text = "No es suficiente... sigue acercándote a ese punto de luz. Las espinas se han irritado y te muestran sus afiladas púas. Pero todo vale la pena.\nEse punto de luz se irradió desde la palma de tu mano, en medio de la brillante luz, sentiste claramente la bendición de Muzus"
  },
  Event_56024_Name = {
    Text = "Bendición de Muzus"
  },
  Event_56025_ChoiceDesc1 = {
    Text = "[Acércate a la Luz]En la próxima batalla, la vida del enemigo aumenta un 30% y el daño un 15%, puedes elegir 1 carta \"Imagen\" para mejorar"
  },
  Event_56025_ChoiceDesc2 = {Text = "[Salir]"},
  Event_56025_Desc = {
    Text = "Cortas las espinas con tus herramientas, las espinas vivas parecen inquietas, pero el costo es insignificante—en ese punto de luz, escuchas el llamado de la musa"
  },
  Event_56025_Name = {
    Text = "Bendición de Muzus"
  },
  Event_56146_ChoiceDesc1 = {Text = "[Salir]"},
  Event_56146_Desc = {
    Text = "No es suficiente... sigue acercándote a ese punto de luz. Las espinas afiladas te cortan las manos, dejando que tu sangre fluya sin parar. Pero todo vale la pena.\nEse punto de luz se irradió desde la palma de tu mano, en medio de la brillante luz, sentiste claramente la bendición de Muzus"
  },
  Event_56146_Name = {
    Text = "Bendición de Muzus"
  },
  Event_56147_ChoiceDesc1 = {
    Text = "[Impulso creativo]todos los despertadores pierden toda la locura, elige 3 cartas de\"imágenes\"y deja que horla cree una\"ofrenda\"para ti"
  },
  Event_56147_ChoiceDesc2 = {Text = "[Salir]"},
  Event_56147_Desc = {
    Text = "Aceptas la llamada de la escuela, la voz familiar te tranquiliza. Te animas y sigues adelante"
  },
  Event_56147_Name = {
    Text = "Punto de contacto"
  },
  Event_56147_Tips1 = {
    Text = "\"'Imágenes' menos de 3 cartas, no se puede combinar.\""
  },
  Event_56148_ChoiceDesc1 = {Text = "[Salir]"},
  Event_56148_Desc = {
    Text = "El brillo plateado del emblema te emocionó. Siguiendo tu instinto, arrojaste lo que tenías en las zarzas. La luz debajo comenzó a brillar, y en esa luz, encontraste nueva inspiración"
  },
  Event_56148_Name = {
    Text = "Punto de contacto"
  },
  Event_56149_ChoiceDesc1 = {
    Text = "[Acércate a la Luz]Reduce el límite de vida en un 10%, puedes elegir una carta \"Imagen\" para mejorar"
  },
  Event_56149_ChoiceDesc2 = {Text = "[Salir]"},
  Event_56149_Desc = {
    Text = "Apartas las espinas con la mano, sufriendo algunas heridas, pero el costo es insignificante—en ese punto de luz, escuchas el llamado de la musa"
  },
  Event_56149_Name = {
    Text = "Bendición de Muzus"
  },
  Event_56149_Tips1 = {
    Text = "Sin \"imágenes\" mejorables"
  },
  Event_56150_ChoiceDesc1 = {Text = "[Salir]"},
  Event_56150_Desc = {
    Text = "El brillo plateado del emblema te emocionó. Sentiste una fuerte necesidad de escribir los versos en tu mente"
  },
  Event_56150_Name = {
    Text = "Punto de contacto"
  },
  Event_56151_ChoiceDesc1 = {
    Text = "[Nueva inspiración]Elegir 1 imagen para eliminar, mejorar aleatoriamente 1 imagen"
  },
  Event_56151_ChoiceDesc2 = {Text = "[Salir]"},
  Event_56151_Desc = {
    Text = "Aceptas la llamada de la escuela, la voz familiar te tranquiliza. Te animas y sigues adelante"
  },
  Event_56151_Name = {
    Text = "Punto de contacto"
  },
  Event_56151_Tips1 = {
    Text = "No hay cartas de \"Imágenes\""
  },
  Event_57738_ChoiceDesc1 = {
    Text = "[Forzar la entrada]todos los cuerpos obtienen 30 puntos de locura, pero se añaden dos cartas\"(Skill.Arg1)\"al mazo"
  },
  Event_57738_ChoiceDesc2 = {
    Text = "[Rendir las armas]en la próxima batalla, la salud del enemigo aumentará un 60% y el daño aumentará un 30%"
  },
  Event_57738_ChoiceDesc3 = {
    Text = "[emboscada]consume toda la locura del despertador, obtén 30 el sigilo negro y elimina la amenaza del guardia"
  },
  Event_57738_Desc = {
    Text = "Espías desde un punto ciego en la esquina. Los agentes del comité de vigilancia miran en otra dirección y no te ven.\nRecuerdas tu entrenamiento y rápidamente piensas en cómo lidiar con este obstáculo"
  },
  Event_57738_Name = {
    Text = "Agente del Comité de Revisión"
  },
  Event_57738_Tips3 = {
    Text = "Ningún despertado tiene locura"
  },
  Event_57739_ChoiceDesc1 = {Text = "[Salir]"},
  Event_57739_Desc = {
    Text = "Observas con atención. Los agentes del comité de vigilancia bloquean tu camino y vigilan la zona.\nNo puedes enfrentarte a tantos enemigos.\n¿Avanzas o retrocedes?"
  },
  Event_57739_Name = {
    Text = "Punto de detención"
  },
  Event_57776_ChoiceDesc1 = {Text = "[Salir]"},
  Event_57776_ChoiceDesc2 = {
    Text = "[Fingir rendición]Después de explorar la zona, teletranspórtate al punto de detención y obtén 2 cartas de \"Síntoma\" aleatorias"
  },
  Event_57776_ChoiceDesc3 = {
    Text = "[Entrar]Después de explorar esta área, teletranspórtate al punto de detención, pierde Arg1 de vida"
  },
  Event_57776_Desc = {
    Text = "Observas con atención. Los agentes del comité de vigilancia bloquean tu camino y vigilan la zona.\nNo puedes enfrentarte a tantos enemigos.\n¿Avanzas o retrocedes?"
  },
  Event_57776_Name = {
    Text = "Punto de vigilancia"
  },
  Event_57776_Tips3 = {
    Text = "Vida insuficiente"
  },
  Event_59193_ChoiceDesc1 = {
    Text = "[Bendición de Alistair]Añade una carta \"Luz de la Noche Eterna\" al mazo"
  },
  Event_59193_Desc = {
    Text = "Este certificado de admisión siempre estuvo en el fondo de tu maleta. Acaricias el marco decorado, inhalas el aroma de la tinta. El emblema de Missaga brilla como una puerta al futuro, atrayendo tu mirada ansiosa, como aquel día, como hoy"
  },
  Event_59193_Name = {
    Text = "Ceremonia de ingreso"
  },
  Event_59527_ChoiceDesc1 = {
    Text = "Elige una carta para comprender la oración \"Lex Nous\". \"Lex Nous\": Al jugar, roba 2 cartas; su costo aritmético se reduce al costo real de la carta de oración, válido solo una vez por batalla."
  },
  Event_59527_Desc = {
    Text = "La marca que simboliza el conocimiento está grabada en tu documento.\nLos pensamientos de tawil fluyen en tu mente. En esa infinitud de posibilidades, te diriges hacia el único camino correcto"
  },
  Event_59527_Name = {
    Text = "Ceremonia de ingreso"
  },
  Event_59528_ChoiceDesc1 = {
    Text = "Elige una carta para comprender la oración \"Lex Volis\". \"Lex Volis\": Al jugar, descarta todas las cartas excepto las de este despertador, gana 5 cartas aleatorias que no son de despertador, válido solo una vez por batalla."
  },
  Event_59528_Desc = {
    Text = "La marca que simboliza el placer está grabada en tu documento.\nA través de la marca, N te observa. Él espera que le traigas un resultado que nunca se ha enunciado"
  },
  Event_59528_Name = {
    Text = "Ceremonia de ingreso"
  },
  Event_59529_ChoiceDesc1 = {
    Text = "Elige una carta para comprender el orison \"Lex Genis\". \"Lex Genis\": Al jugar, gana 3 copias originales adicionales con \"Retener\" y \"Consume,\" válido solo una vez por batalla."
  },
  Event_59529_Desc = {
    Text = "La marca que simboliza la procreación está grabada en tu documento.\nThais deposita sus esperanzas en ti, coexistirá contigo en todos los mundos"
  },
  Event_59529_Name = {
    Text = "Ceremonia de ingreso"
  },
  Event_59566_ChoiceDesc1 = {
    Text = "[Limpiar lágrimas de Sangre] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_59566_ChoiceDesc2 = {
    Text = "[Sigue con los ojos abiertos] aleatoriamente 3 cartas de comando obtienes el sello: «(EnchantConfig.Arg1)», infecta «(Skill.Arg2)»"
  },
  Event_59566_Desc = {
    Text = "Tus deseos se fusionan en uno solo, todos compartieron un origen y ahora comparten un cuerpo.\nIncontables ojos se abren para enfrentar el gran ojo.\nIncontables ojos se rompen, derramando lágrimas de sangre seca y dolor"
  },
  Event_59566_Name = {Text = "Mi fusión"},
  Event_59567_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59567_Desc = {
    Text = "Tú intentas debatir con esa voz loca, refutando esa idea de vacío.\n“Todo se dirige a la muerte, ¿es posible que la vida misma no tenga sentido?”\nDiscutiste con razones, pero aquella risa no disminuyó en lo más mínimo, como si se burlara de tu necedad"
  },
  Event_59567_Name = {
    Text = "Cordero para el matadero"
  },
  Event_59568_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59568_Desc = {
    Text = "Miras esa puerta, sin querer soportar más el dolor de la ignorancia.\nQuieres ver lo que hay detrás de la puerta.\nLa puerta ilusoria se agita de manera hipnótica, y ves sombras de innumerables mundos pasar fugazmente.\nSin tiempo para distinguir, una infinita cantidad de información arrasa tu mente, y tu cerebro se llena de ruido caótico."
  },
  Event_59568_Name = {
    Text = "Tras la puerta"
  },
  Event_59569_ChoiceDesc1 = {
    Text = "[Comando firme]Despertar aleatoriamente 1 entidad despierta, infectar\"(Skill.Arg1)\""
  },
  Event_59569_ChoiceDesc2 = {
    Text = "[Negociar juntos]elegir 1 de 3 cartas de comando y obtener oración：\"(EnchantConfig.Arg1)\""
  },
  Event_59569_Desc = {
    Text = "Todo ocurrió tan repentinamente, sientes que estás rodeado por una niebla difusa, intentas mirar a tu alrededor, pero no puedes ver nada.\nLos despertadores esperan tus órdenes.\nAhora estás aislado y sin ayuda, solo puedes depender de tu propia fuerza"
  },
  Event_59569_Name = {
    Text = "Ojo de la ignorancia"
  },
  Event_59570_ChoiceDesc1 = {
    Text = "[con sacrificio]obtén reliquia maldita\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_59570_ChoiceDesc2 = {
    Text = "[Con valentía] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_59570_ChoiceDesc3 = {
    Text = "[mirar fijamente]obtén 50 el sigilo negro"
  },
  Event_59570_Desc = {
    Text = "Incontables tú en incontables mundos, hombro con hombro, mano a mano, como hermanos y hermanas.\nAhora están bajo esa gran sombra, levantando la cabeza, sin retroceder.\n¿Qué hacer?\n¿Cómo derrotar a tu yo final?"
  },
  Event_59570_Name = {
    Text = "Mi respuesta"
  },
  Event_59571_ChoiceDesc1 = {
    Text = "[Buscar respuestas] obtiene Arg1 el sigilo negro, infecta «(Skill.Arg2)», sigue eligiendo"
  },
  Event_59571_ChoiceDesc2 = {
    Text = "[Rendir]obtener 25 el sigilo negro，salir"
  },
  Event_59571_Desc = {
    Text = "A través de la ilusión de la puerta, innumerables experiencias de ti mismo resuenan en tu mente. \n Algunos mueren, otros enloquecen, algunos persisten, otros caen. \n Incontables caminos, innumerables elecciones resplandecen ante ti, como si hubieras vivido una larga y eterna vida en un instante. \n Ahora, innumerables mentes, innumerables bocas operan al mismo tiempo. \n Intentas cruzar el tiempo y el espacio para dialogar con los innumerables tú, rescatando respuestas de los recuerdos infinitos."
  },
  Event_59571_Name = {
    Text = "Mi autointerrogación"
  },
  Event_59572_ChoiceDesc1 = {
    Text = "[intercambiar poder]elige aleatoriamente 1 carta de comando, obtén plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_59572_ChoiceDesc2 = {
    Text = "[intercambiar suerte]mejora Arg1 puntos de salud máxima, infecta\"(Skill.Arg2)\""
  },
  Event_59572_Desc = {
    Text = "Cada elección tiene un precio.\nVida, espíritu, emociones, recuerdos...\n¿Qué deseas intercambiar con el destino y qué eliges poner en la balanza?"
  },
  Event_59572_Name = {
    Text = "Elección del destino"
  },
  Event_59573_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59573_Desc = {
    Text = "¿Cómo puede una persona estar sin corazón? \n Buscas desesperadamente a tu alrededor, tu respiración se vuelve cada vez más rápida, el miedo a la muerte envuelve tu mente. \n \"No puedo respirar... mi corazón va a detenerse...\" \n Espera, parece que ya no necesitas latir. \n Te das cuenta de ello y empiezas a reír con alegría."
  },
  Event_59573_Name = {
    Text = "Cavidad del pecho"
  },
  Event_59574_ChoiceDesc1 = {
    Text = "[Mirada fija]Obtén una reliquia de oro\"(RelicConfig.Arg1)\"、infección\"(Skill.Arg2)\""
  },
  Event_59574_ChoiceDesc2 = {
    Text = "[Evadir]despertar aleatoriamente 2 despertadores, contagiar dos veces\"(Skill.Arg1)\""
  },
  Event_59574_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_59574_Desc = {
    Text = "Sientes que hay alguna presencia en el vacío que te observa. \n Dondequiera que vayas, esa mirada te sigue como una sombra. \n Te sientes como una pequeña presa marcada, y un dolor punzante comienza a surgir en tu espalda."
  },
  Event_59574_Name = {Text = "Su mirada"},
  Event_59575_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59575_Desc = {
    Text = "No te dejas llevar por la frenética interpretación, mantienes tu ritmo.\nLos ataques y tentaciones del otro no te afectan, el piano toca dos melodías a la vez, quien persista hasta el final dominará todas las notas"
  },
  Event_59575_Name = {
    Text = "Canción de la Fiesta del Apocalipsis"
  },
  Event_59576_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59576_Desc = {
    Text = "Reúnes todo tu valor, sin importar lo que enfrentes, seguirás adelante con tus compañeros"
  },
  Event_59576_Name = {
    Text = "Futuro congelado"
  },
  Event_59577_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59577_Desc = {
    Text = "«¿Dónde estás ahora?» \n «¿Qué planes tienen los profesores?» \n «¿Qué debo hacer a continuación?» \n Preguntaste con urgencia, queriendo depender de esa presencia confiable como de costumbre. \n El comunicador perdió respuesta como si se hubiera congelado, sacudiste la máquina y, en el movimiento, las palabras de la carta se distorsionaron y se convirtieron en un grupo de mariposas, que aleteaban en tu cara. \n Frotaste tus ojos y te diste cuenta de que todo era solo una ilusión. \n La hoja de la carta estaba completamente en blanco."
  },
  Event_59577_Name = {
    Text = "Eco Alucinante"
  },
  Event_59578_ChoiceDesc1 = {
    Text = "[buscar con pánico]Aumenta en Arg1 puntos la salud máxima"
  },
  Event_59578_ChoiceDesc2 = {
    Text = "[Intentar rellenar] Elige 1 Tarjeta de comando entre 3 para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_59578_Desc = {
    Text = "Tu pecho se sintió vacío y liviano, miraste abajo y viste un agujero en forma de cerradura.\nTu corazón había desaparecido"
  },
  Event_59578_Name = {
    Text = "Cavidad del pecho"
  },
  Event_59579_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59579_Desc = {
    Text = "Le gritas preguntando por sus intenciones, pero solo obtienes una sonrisa inmutable.\n\nÉl ya ha abandonado el mundo, sin ataduras, no tiene que rendir cuentas a nadie.\nSolo puedes resistirte en vano"
  },
  Event_59579_Name = {
    Text = "Caballero Loco"
  },
  Event_59580_ChoiceDesc1 = {
    Text = "[Ritmo alterado]obtienes reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_59580_ChoiceDesc2 = {
    Text = "[Mantenerse a sí mismo]obtener 3 de 1 oración"
  },
  Event_59580_Desc = {
    Text = "Pareciera que tocabas junto a una persona loca, ella te secuestró en las teclas, te envolvió en su locura. \nLuchabas por tocar a su ritmo, tambalearte. \nCon esfuerzo te enfrentabas a ella, tratando de controlar la melodía"
  },
  Event_59580_Name = {
    Text = "Canción de la Fiesta del Apocalipsis"
  },
  Event_59581_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59581_Desc = {
    Text = "Deseas tener un poder invencible, capaz de romper todas las cadenas y obstáculos.\nPero el poder humano es limitado, desafiar a los dioses con un cuerpo pequeño, finalmente quemará tu vida como una cerilla"
  },
  Event_59581_Name = {
    Text = "Elección del destino"
  },
  Event_59582_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59582_Desc = {
    Text = "\"Se ha ido... se ha ido...\"\nLa sensación de vacío no es agradable, tomaste el reloj de bolsillo, la manzana y la chaqueta del uniforme, intentando llenar el hueco en tu pecho.\nTu pecho volvió a estar lleno, solo que tienes la ilusión de estar demasiado lleno.\nNo importa, las cosas nunca son perfectas."
  },
  Event_59582_Name = {
    Text = "Cavidad del pecho"
  },
  Event_59583_ChoiceDesc1 = {
    Text = "[persuadir]obtén 25 el sigilo negro"
  },
  Event_59583_ChoiceDesc2 = {
    Text = "[cuestionar]obtén la reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_59583_Desc = {
    Text = "Los zapatos de N se detienen frente a ti, una sonrisa distorsionada en su oscuro rostro.\nSiempre viste de manera impecable, pero bajo esa fachada de caballero se esconde pura locura.\nNo tiene amigos, y pocos enemigos.\nPorque todos desaparecen de la manera más teatral.\nDesafortunadamente, ahora eres su próximo protagonista.\nPrepara tu frase de apertura. ¿Cómo satisfarás a este público tan exigente?"
  },
  Event_59583_Name = {
    Text = "Caballero Loco"
  },
  Event_59584_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59584_Desc = {
    Text = "Los despertados no saben más que tú, pero ya son tus compañeros más leales, camaradas y apoyo.\nDiscutiste estrategias con los despertados, aunque todavía están inseguros, tienen el coraje de empezar de nuevo"
  },
  Event_59584_Name = {
    Text = "Ojo de la ignorancia"
  },
  Event_59585_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59585_Desc = {
    Text = "Como si te hubieras decidido, respondiste con firmeza.\nTu voz resonó entre las burbujas, como si muchos de ti juraran juntos.\nEstás listo para enfrentar todo"
  },
  Event_59585_Name = {
    Text = "Su interrogatorio"
  },
  Event_59586_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59586_Desc = {
    Text = "No te moviste, solo miraste fijamente las palabras en la carta de respuesta. \n Bajo tu mirada, esas frases se volvieron gradualmente borrosas y distorsionadas, y finalmente se convirtieron en un grupo de mariposas que aletearon ruidosamente hacia tu cara. \n Agitaste las manos para ahuyentar a las mariposas, y cuando te giraste para mirar de nuevo, la hoja de la carta ya estaba vacía. \n Efectivamente, los sueños demasiado hermosos son todos falsos."
  },
  Event_59586_Name = {
    Text = "Eco Alucinante"
  },
  Event_59587_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59587_Desc = {
    Text = "Odias estos hilos despreciables.\nLos tiras con fuerza, algunos se rompen, pero muchos más se enredan de nuevo.\nLuchas con todas tus fuerzas contra ellos"
  },
  Event_59587_Name = {
    Text = "Manos Manipuladas"
  },
  Event_59588_ChoiceDesc1 = {
    Text = "[Abatir la sombra] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_59588_ChoiceDesc2 = {
    Text = "[Triturar el Embrión] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_59588_ChoiceDesc3 = {
    Text = "[Cerrar los ojos]obtiene 25 el sigilo negro"
  },
  Event_59588_Desc = {
    Text = "En un estado de trance, ves a las personas que conociste en Aram acercándose a ti. \n Ellos ríen y te invitan a beber, bailar y degustar manjares. \n Luego, su carne se desprende en capas, cayendo al suelo y retorciéndose en nuevos Embriones. \n Te extienden la mano, invitándote a unirte a la celebración de la carne y el renacimiento."
  },
  Event_59588_Name = {
    Text = "Sombras del Pasado"
  },
  Event_59589_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59589_Desc = {
    Text = "Antes de extender la mano, recordaste que nunca tuviste un gato así.\nTú y el gato se miraron a través del aire, y el gato te guiñó un ojo.\nEl gato no se preocupaba por tu frialdad, parecía amarte igual"
  },
  Event_59589_Name = {
    Text = "La tentación del gato"
  },
  Event_59590_ChoiceDesc1 = {
    Text = "[Incrustar]elija 1 reliquia para transformarse en reliquia maldita\"(RelicConfig.Arg1)\""
  },
  Event_59590_ChoiceDesc2 = {
    Text = "[tragar] obtiene reliquia de plata\"(RelicConfig.Arg1)\"， infección\"(Skill.Arg2)\""
  },
  Event_59590_ChoiceDesc3 = {
    Text = "[Guardar]obtener 25 el sigilo negro"
  },
  Event_59590_Desc = {
    Text = "El poder de los tres grandes plásmidos en tu interior se está fusionando, y te esfuerzas por controlar esta inmensa fuerza.\nTu espacio mental se expande constantemente, naciendo y difundiendo una galaxia.\nFrente a los enemigos que llegan sin cesar, oras sinceramente a este cielo estrellado, pidiendo la ayuda de esta fuerza.\nUna estrella cae del galaxia en la palma de tu mano, emitiendo una luz tentadora."
  },
  Event_59590_Name = {
    Text = "Estrella de los Deseos"
  },
  Event_59591_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59591_Desc = {
    Text = "También guardaste silencio. No hubo comunicación, el silencio lo dijo todo.\nEstás listo para enfrentar todo"
  },
  Event_59591_Name = {
    Text = "Su interrogatorio"
  },
  Event_59592_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59592_Desc = {
    Text = "¿Ese gato es un mentiroso?\nEmpiezas a dudar de esos ojos azules como el agua, y la risa resuena en tus oídos.\n\"¡Mentiroso, mentiroso, te han engañado!\"\nUna preocupación surge en tu interior"
  },
  Event_59592_Name = {
    Text = "susurro secreto"
  },
  Event_59593_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59593_Desc = {
    Text = "Te sientes como un espectador, observando en silencio emociones cada vez más extrañas.\nReprimes todo deseo de apego, sintiendo cómo tu alma se enfría gradualmente.\nEste es tu destino, tu camino inevitable"
  },
  Event_59593_Name = {
    Text = "Cristal emocional"
  },
  Event_59594_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59594_Desc = {
    Text = "Esa sonrisa indiferente no se conmueve, no puedes tocarlo con palabras racionales o emocionales.\nNada de los deseos humanos le importa.\n¿Tus palabras pueden superar la imaginación humana?"
  },
  Event_59594_Name = {
    Text = "Caballero Loco"
  },
  Event_59595_ChoiceDesc1 = {
    Text = "[respuesta]Obtén una reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_59595_ChoiceDesc2 = {
    Text = "[Silencio]despertar al azar 2 cuerpos, infectar dos veces con \"(Skill.Arg1)\""
  },
  Event_59595_Desc = {
    Text = "Incontables burbujas parecían ojos redondos, te miraban en silencio, como si te preguntaran sin palabras.\n¿Estás listo?\n¿Listo para renunciar a todo?\n¿Listo para asumirlo todo?"
  },
  Event_59595_Name = {
    Text = "Su interrogatorio"
  },
  Event_59596_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59596_Desc = {
    Text = "En el instante en que el oponente atacó, contraatacaste de inmediato.\nReconociste sabiamente su verdadera naturaleza, eran bestias mostrando sus colmillos.\nGanaste con suerte.\nAhora corre, no dejes que te atrapen"
  },
  Event_59596_Name = {
    Text = "Sumérgete en el abismo"
  },
  Event_59597_ChoiceDesc1 = {
    Text = "[Buscar respuestas] obtiene Arg1 el sigilo negro, infecta «(Skill.Arg2)», sigue eligiendo"
  },
  Event_59597_ChoiceDesc2 = {
    Text = "[Rendirse]Salir"
  },
  Event_59597_Desc = {
    Text = "¿Qué deberías hacer?\nMiras a innumerables versiones de ti mismo, todas te observan, sus bocas se mueven.\nComo si agarraras un clavo ardiendo, buscas y escuchas, esperando una respuesta final"
  },
  Event_59597_Name = {
    Text = "Mi autointerrogación"
  },
  Event_59598_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59598_Desc = {
    Text = [[
El momento no ha llegado, debes esperar con paciencia.
Tragas tu rencor y odio, esperando el momento de arriesgarlo todo]]
  },
  Event_59598_Name = {
    Text = "Manos Manipuladas"
  },
  Event_59599_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59599_Desc = {
    Text = "Sientes una atracción hacia el vacío, queriendo ver la fuente de esas miradas. \nMiras al vacío, sintiendo que ves algo. Tu visión se cubre de nieve y el mundo parece cambiar. \nTe frotas los ojos y ves líneas de sangre fluyendo"
  },
  Event_59599_Name = {Text = "Su mirada"},
  Event_59600_ChoiceDesc1 = {
    Text = "[Esforzarse por recordar] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_59600_ChoiceDesc2 = {
    Text = "[Saborear la tristeza] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_59600_ChoiceDesc3 = {
    Text = "[Aceptar en silencio]Obtén 25 sigilos negros"
  },
  Event_59600_Desc = {
    Text = "Como si hubieras pasado por la más precisa de las cirugías cerebrales, sientes claramente cómo fragmentos de recuerdos atesorados se están desprendiendo de tu mente, tu cerebro se vuelve borroso, como si estuviera a punto de derretirse.\nTiembla de dolor, tratando de detener la mano que deseas contener.\nLágrimas brillantes fluyen de tus ojos, pero, ¿por qué están fluyendo?\nParece que no puedes recordarlo.\nTe sientes inexplicablemente triste."
  },
  Event_59600_Name = {
    Text = "Dissociación de la memoria"
  },
  Event_59601_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59601_Desc = {
    Text = "Tu amistad con el gato es indudable. Sin mirar atrás, seguiste adelante.\n\"¡Idiota! ¡Idiota!\"\nLa voz en tus oídos estaba furiosa"
  },
  Event_59601_Name = {
    Text = "susurro secreto"
  },
  Event_59602_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59602_Desc = {
    Text = "Has tomado la determinación de luchar hasta el último momento con la esperanza de todos, sin importar el costo"
  },
  Event_59602_Name = {
    Text = "Futuro congelado"
  },
  Event_59603_ChoiceDesc1 = {
    Text = "[Contener]obtener reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_59603_ChoiceDesc2 = {
    Text = "[Fijarse]gana reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_59603_Desc = {
    Text = "Detrás de la puerta custodiada por Tawil hay un mundo infinito y una verdad infinita.\nNo sabes qué vio detrás de la puerta, pero sabes que ella lo sabe todo.\nAhora esta puerta se abre ante ti, toda la verdad emite una invitación silenciosa detrás de la puerta"
  },
  Event_59603_Name = {
    Text = "Tras la puerta"
  },
  Event_59604_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59604_Desc = {
    Text = "Debes tener respeto hacia lo desconocido, evitar su fulgor es la elección más prudente. \nBajas la cabeza, aprietas la llave de plata en tu pecho y sientes un leve consuelo. \nAl menos aún tienes fuerza, y tienes a los Despertados. \nTe esfuerzas por ignorar esas miradas, concentrándote en el camino que tienes delante. \n¿Pero realmente han desaparecido esas miradas? Lo sabes muy bien."
  },
  Event_59604_Name = {Text = "Su mirada"},
  Event_59605_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59605_Desc = {
    Text = "Si todos los medios para desafiar a los dioses son inútiles, lo único que puedes mantener es el coraje de no rendirte.\nCuando la destrucción infinita se cierne sobre ti, serás el primero en enfrentarlo"
  },
  Event_59605_Name = {
    Text = "Mi respuesta"
  },
  Event_59606_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59606_Desc = {
    Text = "Tocaste las lágrimas que fluían sin cesar, saboreando esa tristeza desconocida.\nParecía que habías perdido algo muy valioso, pero no podías recordar qué era.\nQué lástima.\nTe secaste las lágrimas con impotencia y esbozaste una sonrisa amarga"
  },
  Event_59606_Name = {
    Text = "Dissociación de la memoria"
  },
  Event_59607_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59607_Desc = {
    Text = "Ignoras sus voces.\nNo te importa si el gato es un mentiroso, solo confías en tu propia fuerza.\nLas voces a tu alrededor suspiran"
  },
  Event_59607_Name = {
    Text = "susurro secreto"
  },
  Event_59608_ChoiceDesc1 = {
    Text = "[Buscar respuestas] obtiene Arg1 el sigilo negro, infecta «(Skill.Arg2)», sigue eligiendo"
  },
  Event_59608_ChoiceDesc2 = {
    Text = "[Rendirse]Salir"
  },
  Event_59608_Desc = {
    Text = "Alguien ríe locamente.\nEse yo que considera que toda lucha es inútil, mejor rendirse pronto.\nFrunces el ceño, ese yo de repente sonríe y se da la vuelta, dice que es mejor terminar con la vida de todos con tus propias manos que hacer que la gente sufra.\nAprehendes esa voz con la mano, manteniendo firme tu fe."
  },
  Event_59608_Name = {
    Text = "Mi autointerrogación"
  },
  Event_59609_ChoiceDesc1 = {
    Text = "[Interrogar]Elimina 2 cartas"
  },
  Event_59609_ChoiceDesc2 = {
    Text = "[perforar]Obtén una reliquia maldita\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_59609_ChoiceDesc3 = {
    Text = "[Salir]obtiene Arg1 sigilo negro"
  },
  Event_59609_Desc = {
    Text = "En la larga espera, volviste a abrir el comunicador. Tal vez tus pensamientos y oraciones hayan tenido efecto, viste cómo en el papel de respuesta brotaba constantemente su familiar y cariñosa contestación. \n Ella está muy segura ahora, los maestros ya han hecho los arreglos, el funcionamiento de Misaq va todo bien... \n Mirando las buenas noticias que llegaban como copos de nieve, no pudiste evitar sentir una emoción en tu corazón."
  },
  Event_59609_Name = {
    Text = "Eco Alucinante"
  },
  Event_59610_ChoiceDesc1 = {
    Text = "[Capturar estrellas]Mejora 1 reliquia de plata a reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_59610_ChoiceDesc2 = {
    Text = "[Romper estrellas]Recibe reliquia de oro\"(RelicConfig.Arg1)\"、infectar\"(Skill.Arg2)\"y\"(Skill.Arg3)\""
  },
  Event_59610_ChoiceDesc3 = {
    Text = "[Observar en silencio]gana 25 el sigilo negro"
  },
  Event_59610_Desc = {
    Text = "Tus emociones son despojadas junto con los recuerdos, sientes que te estás convirtiendo en algún tipo de existencia colosal, como si un monstruo regresara a su antiguo y cálido nido. \nIncontables alegrías, tristezas y enfados se condensan, transformándose en estrellas brillantes que caen como una lluvia luminosa en tu dimensión espiritual. \nLas huellas de tu existencia se desvanecen como meteoros. \nObservas en silencio y recoges una estrella frente a ti, de la cual proviene tu risa alegre. \nEntonces también te ríes, dulce como la miel."
  },
  Event_59610_Name = {
    Text = "Cristal emocional"
  },
  Event_59611_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59611_Desc = {
    Text = "Sabes que estos son solo ecos del pasado, matas sin expresión a aquellos con quienes solías hablar.\nSus risas y lágrimas se rompen en tus manos, no puedes detenerte.\nSi esta es una prueba necesaria, serás el verdugo más despiadado"
  },
  Event_59611_Name = {
    Text = "Sombras del Pasado"
  },
  Event_59612_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59612_Desc = {
    Text = [[
Su pelaje suave y sus ojos claros te inspiran confianza.
Te acercas al gato, y el gato se acerca a ti.
No hay palabras entre ustedes, pero su cola se levanta alta]]
  },
  Event_59612_Name = {
    Text = "La tentación del gato"
  },
  Event_59613_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59613_Desc = {
    Text = "Contienes tu curiosidad, sabes que esta puerta no debe abrirse.\nDemasiada verdad a veces es una maldición.\nApretas la llave de plata en tu pecho, decidido a cerrar esta puerta para siempre"
  },
  Event_59613_Name = {
    Text = "Tras la puerta"
  },
  Event_59614_ChoiceDesc1 = {
    Text = "[valentía] mejora aleatoriamente los efectos de 2 cartas"
  },
  Event_59614_ChoiceDesc2 = {
    Text = "[Determinación]elegir 1 de 3 cartas de comando y obtener oración：\"(EnchantConfig.Arg1)\""
  },
  Event_59614_Desc = {
    Text = "Las palabras de Tawil resuenan en tu mente.\nEntre innumerables finales, solo hay un camino correcto.\nEn un estado de ensueño, ves muchas sombras de mundos pasar ante tus ojos como fragmentos de una película, esperando el momento en que presionarás el botón para congelar la imagen.\n¿Qué final traerá el mundo después de este segundo?"
  },
  Event_59614_Name = {
    Text = "Futuro congelado"
  },
  Event_59615_ChoiceDesc1 = {
    Text = "[ignorar la duda]Obtén 50 el sigilo negro"
  },
  Event_59615_ChoiceDesc2 = {
    Text = "[Arbitrariedad]Obtén 75 el sigilo negro, infección\"(Skill.Arg2)\""
  },
  Event_59615_Desc = {
    Text = "Con las burlas de N, empiezas a dudar de todos. \n¿Quiénes son sus avatares y quiénes tus verdaderos amigos? \nSu sombra cambia constantemente, mostrando muchas caras que te sonríen"
  },
  Event_59615_Name = {
    Text = "Las cien caras de la sombra"
  },
  Event_59616_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59616_Desc = {
    Text = "Si todos pueden traicionar, entonces no debes depender de nadie.\nEn la oscuridad, solo puedes confirmar la única realidad.\nAl menos aún tienes a ti mismo: el más leal de ti mismo en quien confiar"
  },
  Event_59616_Name = {
    Text = "Las cien caras de la sombra"
  },
  Event_59617_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59617_Desc = {
    Text = "Apreitas con fuerza, las piedras brillantes se rompen en polvo entre tus dedos. \n Aspiras codiciosamente esas emociones del pasado. \n En un instante, una intensa felicidad inunda tu cerebro, y luego se disipa lentamente como una ilusión. \n Las comisuras de tus labios se levantan, pero luego caen lentamente. \n Tu rostro se vuelve gradualmente sereno y sin emociones."
  },
  Event_59617_Name = {
    Text = "Cristal emocional"
  },
  Event_59618_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59618_Desc = {
    Text = "Sabes que todo tiene un precio, y si el precio de salvar es el sacrificio, entonces estás dispuesto a pagarlo todo tú mismo.\nEstás listo para darlo todo en cualquier momento"
  },
  Event_59618_Name = {
    Text = "Mi respuesta"
  },
  Event_59619_ChoiceDesc1 = {
    Text = "[Buscar respuestas] obtiene Arg1 el sigilo negro, infecta «(Skill.Arg2)», sigue eligiendo"
  },
  Event_59619_ChoiceDesc2 = {
    Text = "[Rendirse]Salir"
  },
  Event_59619_Desc = {
    Text = "Alguien grita.\nEse yo quiere huir desesperadamente, dice que resistir es inútil.\nSolo una huida interminable puede retrasar la aniquilación.\nDudas"
  },
  Event_59619_Name = {
    Text = "Mi autointerrogación"
  },
  Event_59620_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59620_Desc = {
    Text = "Sabes lo aterrador de la velocidad de reproducción de esos embriones, el nuevo nacido aquí es una maldición como la de las langostas. \n Los aplastas antes de que esos recién nacidos emitan sus gemidos. \n Las personas de carne y sangre te miran con rencor, cuestionándote por qué profanas la vida sagrada. \n Respondes con un asesinato interminable."
  },
  Event_59620_Name = {
    Text = "Sombras del Pasado"
  },
  Event_59621_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59621_Desc = {
    Text = "En este momento deseas ser el más afortunado, con el mejor final.\nPero la suerte tiene un precio cruel, la fortuna y la desgracia van de la mano. Cuando obtengas algo, no olvides revisar lo que perdiste"
  },
  Event_59621_Name = {
    Text = "Elección del destino"
  },
  Event_59622_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59622_Desc = {
    Text = "Pareciera que luchabas por el volante de un automóvil con otra persona, tus manos se movían con todas sus fuerzas, intentando controlar el ritmo de la melodía.\nEn la difícil resistencia, de repente presionaste con fuerza una fila de teclas.\nTu frenético toque fue interrumpido, y sonreíste, sumido en una lucha entre la locura y una locura aún mayor."
  },
  Event_59622_Name = {
    Text = "Canción de la Fiesta del Apocalipsis"
  },
  Event_59623_ChoiceDesc1 = {
    Text = "[acercarse]obtén 25 el sigilo negro"
  },
  Event_59623_ChoiceDesc2 = {
    Text = "[Fijarse]50% de probabilidad de ganar 50 el sigilo negro，50% de probabilidad de no obtener nada"
  },
  Event_59623_Desc = {
    Text = "A tu lado hay un gato, su pelaje es suave y limpio, sus patas delanteras son blancas como la nieve.\nEl gato siempre te acompaña, paso a paso, como tu sirviente más leal.\nToda tu confusión, dolor e inseguridad se disipan"
  },
  Event_59623_Name = {
    Text = "La tentación del gato"
  },
  Event_59624_ChoiceDesc1 = {
    Text = "[negación] infección\"(Skill.Arg1)\"， obtiene reliquia maldita\"(RelicConfig.Arg2)\""
  },
  Event_59624_ChoiceDesc2 = {
    Text = "[refutar]infecta dos veces\"(Skill.Arg1)\"，obtén la reliquia de plata\"(RelicConfig.Arg2)\"y\"(RelicConfig.Arg3)\""
  },
  Event_59624_ChoiceDesc3 = {
    Text = "[Silencio]gana reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_59624_Desc = {
    Text = "Te encuentras atrapado en una especie de ilusión de vacío. \nVes a innumerables personas en silencio bajo la sombra del apocalipsis, tan pequeñas como el polvo. \nEstán aturdidos, grises, sin esperanza. \nOyes la risa aguda de alguien. \n\"Mira, este es el resultado de su persistencia.\" \n\"El mundo nunca ha tenido un final, todo carece de sentido.\""
  },
  Event_59624_Name = {
    Text = "Cordero para el matadero"
  },
  Event_59625_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59625_Desc = {
    Text = "No, esto no es correcto; esto no es real. \nNiega la voz de la locura una y otra vez, mientras la sombra gris permanece indiferente, como confirmando el resultado de la ilusión. \nLa risa se vuelve más fuerte, burlándose de tu impotencia"
  },
  Event_59625_Name = {
    Text = "Cordero para el matadero"
  },
  Event_59626_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59626_Desc = {
    Text = "Sentiste una gran tristeza y nostalgia, intentaste recordar desesperadamente, buscando sombras del pasado en los fragmentos de memoria.\nEsas sombras se desvanecieron rápidamente, trataste de atraparlas, pero solo las viste escapar entre tus dedos.\nTe diste cuenta de que tendrás nada"
  },
  Event_59626_Name = {
    Text = "Dissociación de la memoria"
  },
  Event_59627_ChoiceDesc1 = {
    Text = "[acercarse]obtén 25 el sigilo negro"
  },
  Event_59627_ChoiceDesc2 = {
    Text = "[Fijarse]50% de probabilidad de ganar 50 el sigilo negro，50% de probabilidad de no obtener nada"
  },
  Event_59627_Desc = {
    Text = "A tu lado hay un gato, su pelaje es suave y limpio, sus patas delanteras son blancas como la nieve.\nEl gato siempre te acompaña, paso a paso, como tu sirviente más leal.\nToda tu confusión, dolor e inseguridad se disipan"
  },
  Event_59627_Name = {
    Text = "La tentación del gato"
  },
  Event_59628_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59628_Desc = {
    Text = "Te encontraste con tu yo final, y la batalla para destruir el mundo fue solo un cruce de miradas.\nCuando Él te mira, debes mantener la mirada firme hasta que una de las miradas desaparezca"
  },
  Event_59628_Name = {
    Text = "Mi respuesta"
  },
  Event_59629_ChoiceDesc1 = {
    Text = "[respirar] obtiene reliquia de plata\"(RelicConfig.Arg1)\"， infección\"(Skill.Arg2)\""
  },
  Event_59629_ChoiceDesc2 = {
    Text = "[contraataque] obtiene reliquia de oro\"(RelicConfig.Arg1)\"， infección\"(Skill.Arg2)\"，\"(Skill.Arg3)\""
  },
  Event_59629_ChoiceDesc3 = {
    Text = "[Luchar]Gana 25 el sigilo negro"
  },
  Event_59629_Desc = {
    Text = "Un grupo de agentes del comité te bloquea el camino con pasos apresurados.\n\"Por favor, coopera con nuestra investigación.\"\nUna voz fría y maliciosa.\nCon un chapoteo, rompen la superficie tranquila del agua y te arrojan a un estanque profundo"
  },
  Event_59629_Name = {
    Text = "Sumérgete en el abismo"
  },
  Event_59630_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59630_Desc = {
    Text = "Luchas desesperadamente.\nAdelante, un poco más.\nNo importa el costo, debes proteger todo esto.\nExtiendes la mano, los hilos cortan tu piel, pero no lo sientes"
  },
  Event_59630_Name = {
    Text = "Manos Manipuladas"
  },
  Event_59631_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59631_Desc = {
    Text = "Sacudes la cabeza con fuerza, expulsando los recuerdos confusos.\nPronto, los ruidos desaparecen y tu conciencia se recupera.\nNo puedes obtener ayuda del pasado fallido, solo enfocándote en el presente encontrarás esperanza"
  },
  Event_59631_Name = {
    Text = "Mi autointerrogación"
  },
  Event_59632_ChoiceDesc1 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_59632_Desc = {
    Text = "Antes de extender la mano, recordaste que nunca tuviste un gato así.\nTú y el gato se miraron a través del aire, y el gato te guiñó un ojo.\nEl gato no se preocupaba por tu frialdad, parecía amarte igual"
  },
  Event_59632_Name = {
    Text = "La tentación del gato"
  },
  Event_59633_ChoiceDesc1 = {
    Text = "[Buscar respuestas] obtiene Arg1 el sigilo negro, infecta «(Skill.Arg2)»"
  },
  Event_59633_ChoiceDesc2 = {
    Text = "[Rendirse]Salir"
  },
  Event_59633_Desc = {
    Text = "Alguien llora.\nEse yo quiere abrazar a su ser querido.\nNo estar con ellos en el momento de la destrucción es su mayor pesar.\nTe duele el corazón y te sientes triste"
  },
  Event_59633_Name = {
    Text = "Mi autointerrogación"
  },
  Event_59634_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59634_Desc = {
    Text = "Miras las innumerables figuras grises, ignorando sus risas burlonas.\n¿Cómo salvar un mundo colapsado?\nPiensas en silencio mientras todo se desmorona"
  },
  Event_59634_Name = {
    Text = "Cordero para el matadero"
  },
  Event_59635_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59635_Desc = {
    Text = "El aire en los alvéolos desaparece gradualmente, intentas respirar bajo el agua.\nQué acto tan tonto, pero lo lograste.\nTus alvéolos se llenan de nuevo, puedes respirar libremente.\nPero, ¿qué estás inhalando?"
  },
  Event_59635_Name = {
    Text = "Sumérgete en el abismo"
  },
  Event_59636_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59636_Desc = {
    Text = "Te hundes en el líquido viscoso.\nLuchas, pero solo te hundes más.\nNo puedes escapar solo de este pantano"
  },
  Event_59636_Name = {
    Text = "Sumérgete en el abismo"
  },
  Event_59637_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59637_Desc = {
    Text = "Te obligaste a olvidar esas dudas.\nSabes que dudar ahora es inútil, solo puedes intentar creer.\nAntes de abrir la caja sellada, no sabrás la verdad dentro.\nA veces, es más fácil encontrar paz siendo un tonto"
  },
  Event_59637_Name = {
    Text = "Las cien caras de la sombra"
  },
  Event_59638_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59638_Desc = {
    Text = "Las miradas de todos se centran en ti, debes actuar como el líder de todos, sin mostrar debilidad.  \n“Vayamos a charca negra, todo estará bien.”  \nDas la orden con calma, prometiendo algo en lo que ni siquiera tú crees"
  },
  Event_59638_Name = {
    Text = "Ojo de la ignorancia"
  },
  Event_59639_ChoiceDesc1 = {
    Text = "[duda]Infección\"(Skill.Arg1)\"，obtén una reliquia maldita\"(RelicConfig.Arg2)\""
  },
  Event_59639_ChoiceDesc2 = {
    Text = "[desdeñoso]infecta dos veces\"(Skill.Arg1)\"，obtén reliquia de plata\"(RelicConfig.Arg2)\"y\"(RelicConfig.Arg3)\""
  },
  Event_59639_ChoiceDesc3 = {
    Text = "[Ignorar]obtener reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_59639_Desc = {
    Text = "Frente a ti hay tres figuras vacilantes, murmurando algo.\nAcercas tu oído para escuchar, las palabras y el aliento se vuelven claros.\n\"No confíes en ese gato, es un mentiroso.\"\nTe das la vuelta bruscamente, pero no hay nadie a tu lado"
  },
  Event_59639_Name = {
    Text = "susurro secreto"
  },
  Event_59640_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59640_Desc = {
    Text = "Las estrellas parecen tan apetitosas, codicias su poder y te las tragas.\nGlup.\nSientes una energía sin precedentes, una luz brilla en tu visión periférica.\nMiras hacia abajo, las estrellas aún brillan en tu estómago"
  },
  Event_59640_Name = {
    Text = "Estrella de los Deseos"
  },
  Event_59641_ChoiceDesc1 = {
    Text = "[Luchar hacia adelante]Elimina 1 carta de comando, gana Arg1 el sigilo negro"
  },
  Event_59641_ChoiceDesc2 = {
    Text = "[Romper el hilo]Copiar 1 carta de comando, Infectar con\"(Skill.Arg1)\""
  },
  Event_59641_ChoiceDesc3 = {
    Text = "[Contener la ira]Selecciona 1 carta de comando de entre 3 para obtener un sigilo:\"(EnchantConfig.Arg1)\""
  },
  Event_59641_Desc = {
    Text = [[
A lo largo del camino, te empujan hacia adelante, todas tus decisiones son manipuladas por hilos invisibles.
Luchas por mover tus manos, intentando aferrarte a todo lo que te importa.
El destino del mundo cuelga frente a la yema de tus dedos.
Incontables hilos se entrelazan, atando todo tu ser]]
  },
  Event_59641_Name = {
    Text = "Manos Manipuladas"
  },
  Event_59642_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59642_Desc = {
    Text = "Te limpias la sangre y las lágrimas de los ojos, pero siguen fluyendo.\nEl rojo llena tu visión, presagiando un sacrificio sangriento.\nSigues limpiando, el dolor te hace temblar, pero no te da miedo"
  },
  Event_59642_Name = {Text = "Mi fusión"},
  Event_59643_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59643_Desc = {
    Text = "Acaricias la piedra mágica y la incrustas en la llave de plata.\nLa luz de las estrellas te ilumina.\nTe sientes deslumbrado"
  },
  Event_59643_Name = {
    Text = "Estrella de los Deseos"
  },
  Event_59644_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59644_Desc = {
    Text = "No te importa, mantienes los ojos abiertos, tu determinación se convierte en un grito de desafío.\nAunque te rompas y desaparezcas, no retrocederás"
  },
  Event_59644_Name = {Text = "Mi fusión"},
  Event_59645_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59645_Desc = {
    Text = "Alguien guarda silencio.\nVes la cara desesperada de ese yo y sabes que no llegaron al final.\nEres el que ha llegado más lejos, tu respuesta es la última esperanza"
  },
  Event_59645_Name = {
    Text = "Mi autointerrogación"
  },
  Event_59646_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59646_Desc = {
    Text = "Extiendes la mano, agarrando continuamente entre innumerables meteoros, las piedras brillantes pasan por tus dedos. \n Felicidad, tristeza, ira, miedo... \n Aspiras codiciosamente cada emoción, solo para ver cómo se desvanecen de tus manos. \n Un resplandor deslumbrante ilumina tu cara, y tus ojos se vuelven gradualmente oscuros y profundos."
  },
  Event_59646_Name = {
    Text = "Cristal emocional"
  },
  Event_59657_ChoiceDesc1 = {
    Text = "[llamar] obtiene reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_59657_ChoiceDesc2 = {
    Text = "[tocar]obtén la reliquia de oro\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_59657_Desc = {
    Text = "Ves a la muñeca colapsar.\nElla solía ser la más racional y la asistente más leal, cuidando diligentemente toda la información que obtenían.\nAhora parece no recordar nada de su tiempo juntos.\nVes lágrimas cristalinas caer de sus ojos"
  },
  Event_59657_Name = {
    Text = "Lágrimas de la muñeca"
  },
  Event_59658_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59658_Desc = {
    Text = "No te diste por vencido y trataste de tocar su núcleo de energía.\nSiempre que sea mecánico, reiniciarlo debería arreglarlo.\nPero la fría muñeca no te dio la oportunidad ingenua.\nTus intentos por contenerte no despertaron piedad, así que tuviste que luchar con todas tus fuerzas"
  },
  Event_59658_Name = {
    Text = "Lágrimas de la muñeca"
  },
  Event_59659_ChoiceDesc1 = {Text = "[Salir]"},
  Event_59659_Desc = {
    Text = "No quieres destruir a tu antigua compañera.\nGritas su nombre, das todas las órdenes, pero es inútil.\nLa muñeca te traicionó, regresó a la fría inorganidad"
  },
  Event_59659_Name = {
    Text = "Lágrimas de la muñeca"
  },
  Event_60944_ChoiceDesc1 = {Text = "[Salir]"},
  Event_60944_Desc = {
    Text = "No te queda mucho tiempo, elegiste la forma más directa de proceder y rompiste el bloqueo. Las entidades despiertas se sintieron motivadas y se emocionaron.\nEn cuanto a los enemigos más alertas, no son un problema"
  },
  Event_60944_Name = {
    Text = "Agente del Comité de Revisión"
  },
  Event_60945_ChoiceDesc1 = {Text = "[Salir]"},
  Event_60945_Desc = {
    Text = "Antes de que el agente reaccionara, ustedes se acercaron por detrás y le quitaron su arma. Antes de que llegaran los refuerzos, lograron salir de allí. \n Lamentablemente, la noticia ya se ha difundido, los enemigos que vienen preparados pueden volverse más difíciles de manejar. Prepárense."
  },
  Event_60945_Name = {
    Text = "Agente del Comité de Revisión"
  },
  Event_60946_ChoiceDesc1 = {Text = "[Salir]"},
  Event_60946_Desc = {
    Text = "El agente, atraído por un silbido, se acerca a su escondite. En el momento en que se acerca, los Despertados atacan juntos.\nUna emboscada perfecta, la crisis aquí ha sido resuelta para siempre"
  },
  Event_60946_Name = {
    Text = "Agente del Comité de Revisión"
  },
  Event_60947_ChoiceDesc1 = {Text = "[Salir]"},
  Event_60947_Desc = {
    Text = "Ante tantos enemigos, no puedes enfrentarlos. Te adentras en su vista sin resistir.\nSabes que serás llevado a un punto de detención, parte del plan.\nEscaparás de allí y buscarás otro camino"
  },
  Event_60947_Name = {
    Text = "Punto de vigilancia"
  },
  Event_60948_ChoiceDesc1 = {Text = "[Salir]"},
  Event_60948_Desc = {
    Text = "Frente a una multitud de enemigos, no puedes enfrentarte a ellos. Tras una breve batalla, abandonan la resistencia.\nSabes que serás enviado a un punto de detención, que es parte del plan.\nDesde allí, escaparás y buscarás un nuevo camino"
  },
  Event_60948_Name = {
    Text = "Punto de vigilancia"
  },
  Event_60949_ChoiceDesc1 = {Text = "[Salir]"},
  Event_60949_Desc = {
    Text = [[
Ante tantos enemigos, no puedes enfrentarlos.
Decides irte temporalmente y buscar otro camino]]
  },
  Event_60949_Name = {
    Text = "Punto de vigilancia"
  },
  Event_61058_ChoiceDesc1 = {Text = "[Salir]"},
  Event_61058_Desc = {
    Text = "Miras tus manos, tu cuerpo, lleno de esperanza y determinación.\nSi todo esto es obra del destino, estás listo para enfrentarlo.\nSi al final hay una puerta al cielo o al infierno, serás tú quien la abra para el mundo"
  },
  Event_61058_Name = {
    Text = "Mirar furtivamente"
  },
  Event_61059_ChoiceDesc1 = {
    Text = "[Prepararse para la batalla]elegir 1 de 3 cartas de comando y obtener oración：\"(EnchantConfig.Arg1)\""
  },
  Event_61059_ChoiceDesc2 = {
    Text = "[Continuar observando]infección\"(Skill.Arg1)\"，dual de plegaria, como máximo realizar 1 vez"
  },
  Event_61059_Desc = {
    Text = "No te apresuras a entrar en combate, intentas calmarte y aclarar la situación. Este director de orquesta que ha aparecido repentinamente parece ser tanto un enemigo como un aliado, no estás seguro de lo que planea hacer. De todos modos, decides estar bien preparado, primero para enfrentar su desafío y luego observar lentamente qué es lo que realmente quiere."
  },
  Event_61059_Name = {
    Text = "Conductor del Diablo"
  },
  Event_61060_ChoiceDesc1 = {
    Text = "[Escuchar]gana 3 elige 1 oración avanzada"
  },
  Event_61060_ChoiceDesc2 = {
    Text = "[gritar] obtiene reliquia de oro\"(RelicConfig.Arg1)\"， infección\"(Skill.Arg2)\""
  },
  Event_61060_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_61060_Desc = {
    Text = "Desde el accidente, no has recibido noticias de tu compañero. \n Incontables intentos de contacto se han perdido como piedras en el océano, sin ningún eco. \n En el momento en que ya habías perdido la esperanza, el comunicador de repente emitió un sonido. \n Abres la maleta y acercas el auricular a tu oído. \n \"Guardián del Secreto...\" \n En un estado de confusión, escuchas esa voz que has añorado, resonando a través de capas de vacío, distante."
  },
  Event_61060_Name = {
    Text = "Ecos de Pensamiento"
  },
  Event_61061_ChoiceDesc1 = {
    Text = "[Aceptar la oscuridad]Recibe reliquia de plata\"(RelicConfig.Arg1)\"、infectar\"(Skill.Arg2)\""
  },
  Event_61061_ChoiceDesc2 = {
    Text = "[intentar nadar]Obtén una reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_61061_ChoiceDesc3 = {
    Text = "[gritar fantasma] obtiene 25 el sigilo negro"
  },
  Event_61061_Desc = {
    Text = "Corriste hacia adelante, pero el suelo se convirtió en un océano intransitable.\nCaíste en la tierra.\nComo fantasmas en un cementerio, innumerables oscuridades viscosas te rodearon, invadiendo tu boca y nariz"
  },
  Event_61061_Name = {
    Text = "Enlizamiento"
  },
  Event_61062_ChoiceDesc1 = {Text = "[Salir]"},
  Event_61062_Desc = {
    Text = "Abres los ojos de par en par, esforzándote por buscar todas las pistas. \n Cien ojos giran al mismo tiempo, ves las garras de un perro con cara de hombre corriendo delante de ti, ves la trayectoria del bastón del director de Hameln agitando detrás de ti. \n Observas todo con avaricia. \n De repente, ves que un ojo familiar cae al suelo. \n Parece ser tu propio ojo."
  },
  Event_61062_Name = {
    Text = "Avaricia por el Conocimiento"
  },
  Event_61063_ChoiceDesc1 = {Text = "[Salir]"},
  Event_61063_Desc = {
    Text = "No, no puedes ver tantas cosas. \n Claramente solo tienes... ¿solo unos pocos ojos? \n Rápidamente cierras los ojos y extiendes la mano para tocar tu cara. \n Uno, dos... \n Al abrir los ojos de nuevo, tu campo de visión se vuelve estrecho e ignorante. \n Resulta que solo tienes dos ojos, qué lástima, qué lástima."
  },
  Event_61063_Name = {
    Text = "Avaricia por el Conocimiento"
  },
  Event_61064_ChoiceDesc1 = {
    Text = "[Buscar]obtener reliquia maldita\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_61064_ChoiceDesc2 = {
    Text = "[Cerrar los ojos] 1 Tarjeta de comando aleatoria obtiene Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_61064_Desc = {
    Text = "Cada vez más pistas se enredan en un caos de hilos, te sientes ansioso, confundido y lleno de rabia, te odias por no saber nada. \n Una enorme presión tensa tu mente como un hilo delgado. \n De repente, sientes que tu cuero cabelludo se relaja, y puedes ver todo lo que te rodea, vislumbrando las sombras que se agitan en el vacío. \n Más, necesitas ver más..."
  },
  Event_61064_Name = {
    Text = "Avaricia por el Conocimiento"
  },
  Event_61065_ChoiceDesc1 = {Text = "[Salir]"},
  Event_61065_Desc = {
    Text = "Nadas en la tierra, imaginando ser el pez más ágil.\nPara ser pez, debes renunciar a tus piernas humanas.\nEs el precio del trato.\nPronto, te sientes increíblemente ligero, te conviertes en el ser más libre bajo tierra.\nRegresas a la superficie, pero has olvidado cómo caminar"
  },
  Event_61065_Name = {
    Text = "Enlizamiento"
  },
  Event_61066_ChoiceDesc1 = {Text = "[Salir]"},
  Event_61066_Desc = {
    Text = "Tus dedos tocan la familiar llave de plata, el núcleo de toda luz.\nEs la esencia de tu vida, el símbolo de tu destino.\nRecuerdos pasan ante tus ojos.\nTus elecciones están firmemente ligadas a las del mundo.\nTu destino está entrelazado con el de muchos otros"
  },
  Event_61066_Name = {
    Text = "Mirar furtivamente"
  },
  Event_61067_ChoiceDesc1 = {Text = "[Salir]"},
  Event_61067_Desc = {
    Text = "Sientes muchas presencias amistosas a tu alrededor. \nIntentas llamar a esos fantasmas posiblemente inexistentes. \nUn milagro sucede y regresas a la superficie. \nLas innumerables lápidas siguen en silencio"
  },
  Event_61067_Name = {
    Text = "Enlizamiento"
  },
  Event_61068_ChoiceDesc1 = {Text = "[Salir]"},
  Event_61068_Desc = {
    Text = "No tienes tiempo para lamentarte, solo quieres salvar todo lo que se está desmoronando.\nSi te conviertes en una estrella, que seas un meteoro.\nMientras puedas iluminar el cielo nocturno, aunque caigas al final"
  },
  Event_61068_Name = {
    Text = "Mirar furtivamente"
  },
  Event_61069_ChoiceDesc1 = {Text = "[Salir]"},
  Event_61069_Desc = {
    Text = "Ajustas tus oídos más cerca, recopilando todos los sonidos fragmentados en tu mente. \n\"Yo...\" \n\"Debes...\" \n Solo puedes oír frases incompletas, incapaz de discernir cualquier significado. \n Pero no te atreves a hacer ruido, temiendo perderte alguna palabra. \n Sin embargo, el destino no te brinda más compasión. \n El último vestigio de sonido también desaparece, y todo vuelve a caer en el silencio."
  },
  Event_61069_Name = {
    Text = "Ecos de Pensamiento"
  },
  Event_61070_ChoiceDesc1 = {Text = "[Salir]"},
  Event_61070_Desc = {
    Text = "Sin pensar más, ordenas a los despertados que se alineen para enfrentar su desafío"
  },
  Event_61070_Name = {
    Text = "Conductor del Diablo"
  },
  Event_61071_ChoiceDesc1 = {Text = "[Salir]"},
  Event_61071_Desc = {
    Text = "Llamas su nombre una y otra vez, tratando de transmitir aunque sea un atisbo de sentimiento. \n No sabes si ella lo escuchó, te esfuerzas por distinguir la voz ahogada en el micrófono. \n Parece ser su respuesta, pero también podría ser innumerables fragmentos del pasado reproduciéndose en un bucle. \n Reproduciendo las alegrías y tristezas que han compartido y los encuentros que han vivido."
  },
  Event_61071_Name = {
    Text = "Ecos de Pensamiento"
  },
  Event_61072_ChoiceDesc1 = {Text = "[Salir]"},
  Event_61072_Desc = {
    Text = "Quizás esta oscuridad es el mundo real, ¿qué tiene de malo unirse?\nAceptaste completamente la oscuridad, y ella no te rechaza, puedes respirar libremente.\nEn el siguiente segundo, estás de vuelta en la superficie, quizás algo quedó para siempre en el subsuelo, pero ya no importa"
  },
  Event_61072_Name = {
    Text = "Enlizamiento"
  },
  Event_61073_ChoiceDesc1 = {
    Text = "[Fijarse en la luz]de 3 cartas de comando selecciona 1 para ganar plegaria:\"(EnchantConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_61073_ChoiceDesc2 = {
    Text = "[tocar el pecho]elige despertar 1 despertador, infecta\"(Skill.Arg1)\""
  },
  Event_61073_ChoiceDesc3 = {
    Text = "[Continuar corriendo]gana 25 el sigilo negro"
  },
  Event_61073_Desc = {
    Text = "Te sientes perdido, solo puedes correr desesperadamente, sin tiempo para pensar en mucho. \n De repente, sientes un vacío en tu pecho. \n Mirando hacia abajo, ves que en el lugar donde estaba tu corazón hay una luz en forma de llave. \n Esa luz se vuelve cada vez más brillante, extendiéndose gradualmente por todo tu cuerpo. \n Te ves transformado en una estrella. \n De repente comprendes que quizás esa ha sido tu misión todo este tiempo."
  },
  Event_61073_Name = {
    Text = "Mirar furtivamente"
  },
  Event_61074_ChoiceDesc1 = {
    Text = "[Prepararse para la batalla]elegir 1 de 3 cartas de comando y obtener oración：\"(EnchantConfig.Arg1)\""
  },
  Event_61074_ChoiceDesc2 = {
    Text = "[observar detenidamente]infecta\"(Skill.Arg1)\"，re-imprimir, hasta 2 veces"
  },
  Event_61074_Desc = {
    Text = "\"¡Eh... espera! ¿Qué está pasando...?\"\n\"Repetición.\"\nEl hombre te mira sin expresión. \n\"Mantener el enlace del Cuerpo Despierto con música es un nuevo intento. Asegurar el nivel de la orquesta es fundamental para garantizar la perfección de la actuación.\"\nLevanta su batuta y la mueve con claridad, trazando un elegante símbolo de inicio en el aire. \n\"Toca, Guardián del Secreto. Déjame ver de qué eres capaz.\""
  },
  Event_61074_Name = {
    Text = "Conductor del Diablo"
  },
  Event_61075_ChoiceDesc1 = {
    Text = "[Prepararse para la batalla]elegir 1 de 3 cartas de comando y obtener oración：\"(EnchantConfig.Arg1)\""
  },
  Event_61075_Desc = {
    Text = "No importa cuáles sean sus intenciones, al menos te salvó del ataque del Comité de Revisión. Si quisiera hacerte daño, no habría necesidad de ayudarte. Te calmas y te preparas para lo peor"
  },
  Event_61075_Name = {
    Text = "Conductor del Diablo"
  },
  Event_65400_ChoiceDesc1 = {Text = "[Salir]"},
  Event_65400_Desc = {
    Text = "El contacto transmitió la promesa de rescate del exterior. Al escuchar que el equipo de rescate ya está buscando una forma de entrar a la montaña, todos recuperaron la esperanza"
  },
  Event_65400_Name = {
    Text = "Punto de contacto"
  },
  Event_65401_ChoiceDesc1 = {Text = "[Salir]"},
  Event_65401_Desc = {
    Text = "Ninguno de los miembros del equipo de investigación salió de la montaña nevada. Ante la catástrofe, siempre eliges solo por ti mismo; la vida de las personas comunes no tiene valor para ti. Has abandonado tu humanidad y has llegado a salvo al final. \n Los rescatistas te miran con una expresión compleja, pero tú permaneces impasible y te adentras en la tormenta de nieve. Quizás en la medianoche, aquellos espíritus que murieron por tu indiferencia te rodearán en tu cama, mirándote en silencio."
  },
  Event_65401_Name = {
    Text = "Punto de Extracción Seguro"
  },
  Event_65402_ChoiceDesc1 = {
    Text = "[Evacuación de la gente]eliminar creación \"Equipo de investigación\", obtener diferentes niveles de \"Medalla de rescate\"según el número de miembros del equipo"
  },
  Event_65402_Desc = {
    Text = "Llevaste al equipo de investigación al punto de evacuación. El equipo de rescate se hizo cargo y los rescatados se desplomaron, como si hubieran vuelto de otro mundo.\nPero sabes que la verdadera crisis no ha terminado, la bestia sigue acechando en las montañas, hambrienta y esperando"
  },
  Event_65402_Name = {
    Text = "Punto de Extracción Seguro"
  },
  Event_65403_ChoiceDesc1 = {
    Text = "[intercambio de suministros]obtén 25 el sigilo negro, por cada miembro del equipo de exploración adicional obtendrás 1 el sigilo negro (Arg1)"
  },
  Event_65403_ChoiceDesc2 = {
    Text = "[Compromiso de rescate]elegir obtener 1 plegaria. Reforzar 2 miembros del grupo de exploración"
  },
  Event_65403_ChoiceDesc3 = {
    Text = "[Maximizar beneficios]Perder 10 miembros del equipo, elegir una creación de oro+"
  },
  Event_65403_Desc = {
    Text = "Luchan contra la tormenta de nieve, siguiendo las luces intermitentes del puesto de emergencia.\n    ○ Finalmente, después de innumerables oraciones, ven la cabaña que alberga esperanza"
  },
  Event_65403_Name = {
    Text = "Punto de contacto"
  },
  Event_65403_Tips3 = {
    Text = "Faltan miembros en la expedición científica"
  },
  Event_65404_ChoiceDesc1 = {Text = "[Salir]"},
  Event_65404_Desc = {
    Text = "Ustedes obtuvieron la contraseña del almacén de la oficina de enlace de labios de un contacto, y encontraron suficiente material para todos para dos días, ¡felicitaciones, al menos no morirán de hambre en la montaña nevada!"
  },
  Event_65404_Name = {
    Text = "Punto de contacto"
  },
  Event_65415_ChoiceDesc1 = {
    Text = "[Confirmar]"
  },
  Event_65415_Desc = {
    Text = "La montaña nevada devoró en un instante, dos personas desaparecieron para siempre en una grieta profunda, y ustedes no saben nada al respecto"
  },
  Event_65415_Name = {Text = "Ilusión"},
  Event_65416_ChoiceDesc1 = {
    Text = "[Salir]buscar el reflector"
  },
  Event_65416_ChoiceDesc2 = {
    Text = "[Entrar en la nieve]Pierde 2 miembros del equipo de investigación"
  },
  Event_65416_Desc = {
    Text = "De repente, se desató un viento feroz en la montaña nevada, el silbido del viento en tus oídos parecía el grito agudo de una bestia gigante, la blanca y espesa neblina de nieve te deslumbró en un instante, como si algo estuviera atravesando la interminable bruma blanca. \n Se vieron obligados a detenerse, esforzándose por hundir las piernas profundamente en la nieve acumulada para evitar rodar por la ladera."
  },
  Event_65416_Name = {
    Text = "desconocido"
  },
  Event_65417_ChoiceDesc1 = {
    Text = "[Desaparecer en silencio]Perder 2 miembros del equipo"
  },
  Event_65417_ChoiceDesc2 = {Text = "[Salir]"},
  Event_65417_Desc = {
    Text = "El abdomen de la montaña nevada emitió un rugido retumbante, como el gruñido descontento de una bestia hambrienta, la tierra tembló, y el hielo bajo la nieve se agrietó silenciosamente, como si la montaña nevada abriera la boca. \n Cuando finalmente cesó el temblor de la tierra, la gente miró a su alrededor con confusión, y tú te diste la vuelta para revisar al grupo."
  },
  Event_65417_Name = {Text = "Ilusión"},
  Event_65468_ChoiceDesc1 = {Text = "[Salir]"},
  Event_65468_Desc = {
    Text = "Para garantizar la movilidad del grupo, dejaste a la parte más débil en esta aislada cabaña. Esto podría incrementar la tasa de supervivencia del personal restante, pero al ver esas miradas de rencor, ¿no sientes nada en tu interior?"
  },
  Event_65468_Name = {
    Text = "Punto de contacto"
  },
  Event_65483_ChoiceDesc1 = {Text = "[Salir]"},
  Event_65483_Desc = {
    Text = "Salvaste a algunas personas, pero muchas más quedaron en la montaña nevada. Al menos hiciste tu mejor esfuerzo.\nEl personal de rescate dice que tu contribución será reconocida, pero tú solo saludas y te adentras en la tormenta de nieve"
  },
  Event_65483_Name = {
    Text = "Punto de Extracción Seguro"
  },
  Event_65484_ChoiceDesc1 = {Text = "[Salir]"},
  Event_65484_Desc = {
    Text = "No tienes tiempo para nada más, y para salir de la montaña nevada, tomas el camino más eficiente. A los ojos del último sobreviviente, quizás parezcas un demonio.\nLos rescatistas dicen que tu contribución será reconocida, pero tú solo agitas la mano y te adentras en la tormenta de nieve"
  },
  Event_65484_Name = {
    Text = "Punto de Extracción Seguro"
  },
  Event_65485_ChoiceDesc1 = {Text = "[Salir]"},
  Event_65485_Desc = {
    Text = "Bajo tu incansable protección, el equipo de investigación no sufrió ninguna baja, encontrarte fue su mayor suerte en medio de la desgracia, eres su verdadero salvador.\n Has creado un milagro en la catástrofe, los rumores sobre el héroe de la montaña nevada tal vez pronto se difundirán por todas partes. El personal de rescate anuncia solemnemente que tu contribución excepcional será reconocida. Sonríes y agitas la mano, volviendo a adentrarte en la tormenta de nieve."
  },
  Event_65485_Name = {
    Text = "Punto de Extracción Seguro"
  },
  Event_65486_ChoiceDesc1 = {Text = "[Salir]"},
  Event_65486_Desc = {
    Text = "Te preocupas genuinamente por la vida de las personas, la mayoría de ellas fueron salvadas por ti. La gente llora y te agradece por tu protección.\nEl personal de rescate anuncia solemnemente que tu destacada contribución será reconocida. Sonríes y te adentras en la tormenta de nieve"
  },
  Event_65486_Name = {
    Text = "Punto de Extracción Seguro"
  },
  Event_65487_ChoiceDesc1 = {Text = "[Salir]"},
  Event_65487_Desc = {
    Text = "Te enfrentas a la inconstante catástrofe y rescatas a las personas de las garras de la muerte. Gracias a tu esfuerzo, el trágico final ha cambiado un poco. \n El personal de rescate anuncia solemnemente que tu valiosa contribución será reconocida. Sonríes y agitas la mano, volviendo a adentrarte en la tormenta de nieve."
  },
  Event_65487_Name = {
    Text = "Punto de Extracción Seguro"
  },
  Event_6817_ChoiceDesc1 = {
    Text = "[Saber cuándo detenerse]obtiene 3 selecciona 1 plegaria"
  },
  Event_6817_ChoiceDesc2 = {
    Text = "[Seguir leyendo] 1 Tarjeta de comando aleatoria obtiene Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_6817_Desc = {
    Text = "En la parte más alta de la estantería de madera, hay un libro con una cubierta de color dorado. Desde la perspectiva del suelo, no se puede ver el título del libro. \n Por alguna razón, sientes un deseo de leerlo... Este deseo se expande en un instante hasta volverse incontrolable. Sin preocuparte por el riesgo de molestar a los demás, subes por la escalera de madera junto a la estantería, tomas ese libro y comienzas a leer con impaciencia... \n Impresiones difusas surgen en el mar de tu pensamiento, te sumerges en el océano de ilusiones..."
  },
  Event_6817_Name = {
    Text = "Pergamino amarillo"
  },
  Event_6818_ChoiceDesc1 = {
    Text = "[Escuchar] Elige 1 Tarjeta de comando entre 3 para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_6818_ChoiceDesc2 = {
    Text = "[concierto] por cada despertador con un nivel de locura de 50 o más, obtiene 15 el sigilo negro"
  },
  Event_6818_ChoiceDesc3 = {
    Text = "[Salir]obtiene elección de 3 para 1 de oración"
  },
  Event_6818_Desc = {
    Text = "El sonido del piano llega de repente. Dedos verdes saltan sobre las teclas, y la melodía fluye como un arroyo.\n\"Querido amigo, ¿tocamos juntos?\"\nLas manos no hablan, te preguntan con la música"
  },
  Event_6818_Name = {
    Text = "Fantasma junto al piano"
  },
  Event_6819_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6819_Desc = {
    Text = "Ramona miró hacia la fuente de la voz, pero solo tuvo tiempo de ver una ilusión que se desvanecía, pareciendo un gramófono fusionado con la pared"
  },
  Event_6819_Name = {
    Text = "El oído del otro"
  },
  Event_6820_ChoiceDesc1 = {
    Text = "[Limpiar máquina de escribir]eliminar 1 carta de comando，gana 25 el sigilo negro"
  },
  Event_6820_ChoiceDesc2 = {
    Text = "[Intentar leer]Copia una carta del mazo, infecta con \"(Skill.Arg1)\""
  },
  Event_6820_Desc = {
    Text = "La máquina de escribir en el maletín de repente expulsa una espesa tinta, salpicando en una cascada lineal mientras el tren se tambalea"
  },
  Event_6820_Name = {
    Text = "El susurro de la máquina de escribir"
  },
  Event_6821_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6821_Desc = {
    Text = "En el instante en que el puño dispersó el fantasma, la memoria irrumpió de repente en tu cerebro, evocando una serie de recuerdos que golpean el alma, causando un dolor reprimido"
  },
  Event_6821_Name = {Text = "Espejismo"},
  Event_6822_ChoiceDesc1 = {
    Text = "[Tirar la carta]Eliminar 1 carta"
  },
  Event_6822_ChoiceDesc2 = {
    Text = "[Guardar bien]Obtener \"(RelicConfig.Arg1)\", infectar con \"(Skill.Arg2)\""
  },
  Event_6822_Desc = {
    Text = "Sacaste algunas hojas de la máquina de escribir, el olor a tinta era fuerte. Al leer el contenido, frunciste el ceño.\nLa mayoría del texto estaba tachado, lo que quedaba era ilegible"
  },
  Event_6822_Name = {
    Text = "Carta tachada"
  },
  Event_6823_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6823_Desc = {
    Text = "Te esfuerzas por distinguir la escritura borrosa en el papel. Se distorsiona constantemente y luego revela un contenido completamente diferente. \n\"@2Supongo que ya has visto la noticia en el periódico. \nSí, tu padre te ha eliminado de la línea de sucesión... No queremos @2 \nel diablo, el diablo... \nPor favor, detén inmediatamente tu relación con el señor Herbert, de lo contrario, dejaré de brindarte ayuda económica...\""
  },
  Event_6823_Name = {
    Text = "Como si nos viéramos en persona"
  },
  Event_6824_ChoiceDesc1 = {
    Text = "[Sostener la llave de plata]Elige 1 de 3 cartas de comando y gana plegaria:\"(EnchantConfig.Arg1)\"、infectar\"(Skill.Arg2)\""
  },
  Event_6824_ChoiceDesc2 = {
    Text = "[Cerrar los ojos]Elige despertar 1 cuerpo, infecta\"(Skill.Arg1)\""
  },
  Event_6824_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_6824_Desc = {
    Text = "Eres desgarrado por una gran absurdidad, arrastrándote torpemente por el suelo, como si fueras manipulado por un @2 de fuera de la dimensión. \n\"No... No...\"\nTu cordura se desmorona poco a poco, risas y gritos incoherentes se entrelazan, como una gran red que atrapa tu conciencia, solo emergiendo de tus labios un lamento confuso."
  },
  Event_6824_Name = {
    Text = "Ojo de contemplación"
  },
  Event_6825_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6825_Desc = {
    Text = "Déjalo al Guardián del Secreto, no sabemos qué despertará"
  },
  Event_6825_Name = {
    Text = "Núcleo de plata solitario"
  },
  Event_6826_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6826_Desc = {
    Text = "Una melodía triste fluye en mis oídos, la angustia y el dolor inundan mi cerebro y mi alma. Cuando me doy cuenta, los ojos de alguien ya están húmedos."
  },
  Event_6826_Name = {
    Text = "Son Anónimo"
  },
  Event_6827_ChoiceDesc1 = {
    Text = "[Abrir la puerta izquierda]Recibe reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_6827_ChoiceDesc2 = {
    Text = "[Abrir la puerta derecha]Recibe reliquia de oro\"(RelicConfig.Arg1)\"、infectar\"(Skill.Arg2)\""
  },
  Event_6827_Desc = {
    Text = "Puertas. Puertas. Incontables puertas.\nParecen ser más de las que viste con Ramona.\nSe detienen en el pasillo, listos para abrir la siguiente puerta.\nDetrás de la puerta izquierda, silencio absoluto, esperando su visita.\nDetrás de la puerta derecha, murmullos indistintos"
  },
  Event_6827_Name = {
    Text = "Puerta infinita"
  },
  Event_6828_ChoiceDesc1 = {
    Text = "[Escuchar con atención]obtener reliquia de plata\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_6828_ChoiceDesc2 = {
    Text = "[Taparse los oídos] obtiene el sello de elegir 3"
  },
  Event_6828_Desc = {
    Text = "Solo puedes oír el frenético golpeteo de las teclas, que llega como una tormenta violenta, como el estruendo de un meteorito al impactar en la tierra, haciendo que todo el piano tiemble. \n Los martillos de las cuerdas chirrían, y los pedales saltarines emiten un lamento doloroso. \n En medio de la música engañosa, la melodía familiar es arrastrada, rozando tu tímpano."
  },
  Event_6828_Name = {
    Text = "Sonido prohibido"
  },
  Event_6829_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6829_Desc = {
    Text = "\"El investigador William ha proporcionado el suministro de emergencia, por favor, golpee tres veces el broche para confirmar después de recibirlo.\""
  },
  Event_6829_Name = {
    Text = "Comunicación de apoyo"
  },
  Event_6830_ChoiceDesc1 = {
    Text = "[Abrir la puerta izquierda]Gana 1 de 3 plegarias"
  },
  Event_6830_ChoiceDesc2 = {
    Text = "[Abrir la puerta derecha]Elige 1 de 3 cartas de comando y gana plegaria:\"(EnchantConfig.Arg1)\"、infectar\"(Skill.Arg2)\""
  },
  Event_6830_Desc = {
    Text = "Puertas. Puertas. Incontables puertas.\nParecen ser más de las que viste con Ramona.\nSe detienen en el pasillo, listos para abrir la siguiente puerta.\nDetrás de la puerta izquierda, silencio absoluto, esperando su visita.\nDetrás de la puerta derecha, murmullos indistintos"
  },
  Event_6830_Name = {
    Text = "Puerta sin fin"
  },
  Event_6831_ChoiceDesc1 = {
    Text = "[Leer la carta]elimina 1 carta de comando, obtiene Arg1 el sigilo negro"
  },
  Event_6831_ChoiceDesc2 = {
    Text = "[Cerrar la caja]"
  },
  Event_6831_Desc = {
    Text = "El maletín tiembla sin parar, como si una vida estuviera rompiendo su cascarón, a punto de emerger.\nInvoluntariamente lo abres, y las cartas chapotean como mariposas sueltas"
  },
  Event_6831_Name = {
    Text = "Carta inesperada"
  },
  Event_6832_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6832_Desc = {
    Text = "El sonido urgente del timbre te pone nervioso, levantas el auricular y lo dejas sobre la mesa. El timbre se corta abruptamente, dejando un eco en tu mente"
  },
  Event_6832_Name = {
    Text = "Llamada del tren"
  },
  Event_6833_ChoiceDesc1 = {
    Text = "[Recoger la foto]elige 1 de 3 cartas de comando y obtienes sello:\"(EnchantConfig.Arg1)\""
  },
  Event_6833_ChoiceDesc2 = {
    Text = "[Revisar película]infección\"(Skill.Arg1)\"，cambia la plegaria obtenida en la opción 1, que se puede usar dos veces"
  },
  Event_6833_Desc = {
    Text = "En la esquina del estudio había una vieja cámara, unos rollos de película y algunas fotos esparcidas. Ellas registran fielmente el trabajo y la estética del escultor de cera"
  },
  Event_6833_Name = {
    Text = "registrar fielmente"
  },
  Event_6834_ChoiceDesc1 = {
    Text = "[Continuar interrogando]aumenta Arg1 puntos de salud máxima"
  },
  Event_6834_ChoiceDesc2 = {
    Text = "[Atrapar la sombra] Elige 1 Tarjeta de comando entre 3 para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_6834_Desc = {
    Text = "La sombra recitó en el polvo dorado:\n\"Aquellos que conocen la verdad...\nCon la llave como autoridad, guiarán a la humanidad.\"\nEs un antiguo adagio.\nTu intuición te dice que está cerca de la verdad que buscas.\nY tu intuición siempre es precisa"
  },
  Event_6834_Name = {
    Text = "Usador de llave de plata"
  },
  Event_6835_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6835_Desc = {
    Text = "No ocultas tu identificación con los delirios de locura, casi fuiste atado a la mesa de ese ser bajo la locura tentadora del otro"
  },
  Event_6835_Name = {
    Text = "Ceremonia acuática"
  },
  Event_6836_ChoiceDesc1 = {
    Text = "[llamar cuervos] obtiene 30 el sigilo negro， infección\"(Skill.Arg2)\"， continúa eligiendo"
  },
  Event_6836_ChoiceDesc2 = {
    Text = "[Alejarse mucho]"
  },
  Event_6836_Desc = {
    Text = "No te vas, y ellos tampoco.\nCuerdas extrañas conectan sus espíritus, parece que quieren decirte algo"
  },
  Event_6836_Name = {
    Text = "Cornejo Solitario"
  },
  Event_6837_ChoiceDesc1 = {
    Text = "[Dejar de resistir]eliminar 1 carta de comando，obtener Arg1 el sigilo negro"
  },
  Event_6837_ChoiceDesc2 = {
    Text = "[Retirar las manos]"
  },
  Event_6837_Desc = {
    Text = "Una, dos, tres... \nEn la cara, en los dedos, mariposas como fuegos artificiales brillaban en la oscuridad.\nEsta máquina de escribir no tiene uso práctico, pero es experta en crear belleza"
  },
  Event_6837_Name = {
    Text = "Chispa de inspiración"
  },
  Event_6838_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6838_Desc = {
    Text = "Tienes cosas más importantes frente a ti, cerraste la caja decidido a ignorarlas, y la máquina de escribir se quedó en silencio"
  },
  Event_6838_Name = {
    Text = "Advertencia no invitada"
  },
  Event_6839_ChoiceDesc1 = {
    Text = "[Escuchar luna]Infectar\"(Skill.Arg1)\""
  },
  Event_6839_ChoiceDesc2 = {
    Text = "[Escuchar estrella enana]Infectar\"(Skill.Arg1)\""
  },
  Event_6839_ChoiceDesc3 = {
    Text = "[Escuchar una estrella fugaz]pierde 25 el sigilo negro"
  },
  Event_6839_Desc = {
    Text = "Calor, luz, nunca se apaga"
  },
  Event_6839_Name = {
    Text = "Sonido de las estrellas y la luna"
  },
  Event_6840_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6840_Desc = {
    Text = "En el centro del brillo hay un núcleo de plata solidificado, pero tu razón te dice que no brilla.\nSigues la fuente de la luz con la mirada, solo para encontrarte con una trampa de oscuridad y desconocido"
  },
  Event_6840_Name = {
    Text = "Luz nocturna"
  },
  Event_6841_ChoiceDesc1 = {
    Text = "[Salir]de 3 cartas de comando selecciona 1 para obtener oración:\"(EnchantConfig.Arg1)\""
  },
  Event_6841_Desc = {
    Text = "¡Al norte, salida norte!\nComo decidió Ramona, el norte debe tener una salida"
  },
  Event_6841_Name = {
    Text = "Hacia el norte"
  },
  Event_6842_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6842_Desc = {
    Text = "Oh... La plata pura representa la broma que el alma te juega.\nEntonces, ¿cuál es tu próxima elección?"
  },
  Event_6842_Name = {
    Text = "El espectáculo comienza"
  },
  Event_6843_ChoiceDesc1 = {
    Text = "[Marcharse] Elige 1 Tarjeta de comando entre 3 para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_6843_Desc = {
    Text = [[
Sacudes la cabeza, alejando los sonidos.
Un suspiro apenas audible te trae algo de ayuda]]
  },
  Event_6843_Name = {
    Text = "Hacia el norte"
  },
  Event_6844_ChoiceDesc1 = {
    Text = "[Adentrarse en el pasillo]infectar con \"(Skill.Arg1)\", ¿seguir avanzando?"
  },
  Event_6844_ChoiceDesc2 = {
    Text = "[Ir en dirección opuesta]gana 25 el sigilo negro"
  },
  Event_6844_Desc = {
    Text = "La luz de la luna desaparece, devorada por el corredor, solo queda una puerta ominosa a la vista."
  },
  Event_6844_Name = {
    Text = "Galería silenciosa"
  },
  Event_6845_ChoiceDesc1 = {
    Text = "[Adentrarse en el corredor]gana aleatoriamente 1 carta de comando para obtener plegaria:\"(EnchantConfig.Arg1)\"，¿deseas continuar avanzando?"
  },
  Event_6845_ChoiceDesc2 = {
    Text = "[Ir en dirección opuesta]gana 25 el sigilo negro"
  },
  Event_6845_Desc = {
    Text = "Desconociendo el panorama completo, no se debe profundizar"
  },
  Event_6845_Name = {
    Text = "Galería silenciosa"
  },
  Event_6846_ChoiceDesc1 = {
    Text = "[Adentrarse en el pasillo]infectar con \"(Skill.Arg1)\", ¿seguir avanzando?"
  },
  Event_6846_ChoiceDesc2 = {
    Text = "[Ir en dirección opuesta]gana 25 el sigilo negro"
  },
  Event_6846_Desc = {
    Text = "La puerta a la izquierda emitió una risa siniestra, temblando ligeramente y soltando un rastro de malicia"
  },
  Event_6846_Name = {
    Text = "Galería silenciosa"
  },
  Event_6847_ChoiceDesc1 = {
    Text = "[Adentrarse en el corredor]gana reliquia de plata\"(RelicConfig.Arg1)\"，¿deseas continuar avanzando?"
  },
  Event_6847_ChoiceDesc2 = {
    Text = "[Ir en dirección opuesta]gana 25 el sigilo negro"
  },
  Event_6847_Desc = {
    Text = "La puerta a la derecha está abierta, la sangre se extiende en el suelo siguiendo un camino predeterminado"
  },
  Event_6847_Name = {
    Text = "Galería silenciosa"
  },
  Event_6848_ChoiceDesc1 = {
    Text = "[Ya no hay nada, te retiras]"
  },
  Event_6848_Desc = {
    Text = "¿Quién dijo que siempre hay que ser agresivo? Retroceder un paso, tal vez realmente haya un cielo más amplio"
  },
  Event_6848_Name = {
    Text = "Galería silenciosa"
  },
  Event_6849_ChoiceDesc1 = {
    Text = "[Reparar escultura de cera]elegir una carta y reducir su consumo de aritmética en 1"
  },
  Event_6849_Desc = {
    Text = "La restauración de la estatua de cera sigue en marcha. \n No eres un escultor de cera profesional ni has recibido una educación estética sistemática. \n Pero aún así comienzas hábilmente a hacer moldes, dar forma y pintar... \n como si hubieras nacido con un cincel en la mano. \n como si ella hubiera nacido incompleta, solo esperando tu esculpido."
  },
  Event_6849_Name = {
    Text = "Estatua de cera inacabada"
  },
  Event_6850_ChoiceDesc1 = {
    Text = "[Reparar escultura de cera]elegir una carta y reducir su consumo de aritmética en 1"
  },
  Event_6850_Desc = {
    Text = "Galatea, Galatea...\nSiguiendo la voz, encuentras la estatua de cera inacabada nuevamente.\nSe ve perfecta, incluso inquietante.\n\"La fealdad es una grieta en la perfección.\"\nEn el último momento, decides hacer algo"
  },
  Event_6850_Name = {
    Text = "Estatua de cera inacabada"
  },
  Event_6851_ChoiceDesc1 = {
    Text = "[Aceptar el Fantasma] 1 Tarjeta de comando aleatoria obtiene Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_6851_ChoiceDesc2 = {
    Text = "[negar ilusión] selecciona 1 de 3 cartas de comando para obtener la oración：\"(EnchantConfig.Arg1)\""
  },
  Event_6851_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_6851_Desc = {
    Text = "Bajo el oscuro y pesado puente de hierro, en la orilla silenciosa llena de juncos, de repente vuela una mariposa brillante.\nLa mariposa se posa en tu mano, los gritos cesan, reemplazados por el rugido del tren sobre el hierro oxidado, el crepitar del carbón, el chirrido de los ejes"
  },
  Event_6851_Name = {
    Text = "Ilusión Ferroviaria"
  },
  Event_6852_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6852_Desc = {
    Text = "Sí, huyes, estás siendo perseguido por alguna criatura, el instinto de supervivencia te hace correr hasta que no hay salida. No, debería ser... ¿no es el sabueso infernal el que no tiene salida?"
  },
  Event_6852_Name = {Text = "Correr"},
  Event_6853_ChoiceDesc1 = {
    Text = "[esto no es real]obtén la reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_6853_ChoiceDesc2 = {
    Text = "[caer, caer...]obtén reliquia de oro\"(RelicConfig.Arg1)», infecta\"(Skill.Arg2)\""
  },
  Event_6853_Desc = {
    Text = "El espejo caído en el suelo tiene un marco elegante, dentro del marco hay otro marco, y dentro de ese marco hay otro marco...\nAlicia salta y cae sin cesar en el interminable agujero del conejo, ve espejo tras espejo, mentes atrapadas aquí, pero no puede verse a sí misma"
  },
  Event_6853_Name = {
    Text = "Espejo en el espejo"
  },
  Event_6854_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6854_Desc = {
    Text = "A través de la cortina de viento y nieve, miras la montaña nevada, muchas hormigas negras persiguiendo a una hormiga negra...\nTu línea de pensamiento se interrumpe"
  },
  Event_6854_Name = {
    Text = "Recuerdos volcánicos"
  },
  Event_6855_ChoiceDesc1 = {
    Text = "[acércate y agarra]obtén 25 el sigilo negro"
  },
  Event_6855_ChoiceDesc2 = {
    Text = "[respuesta amistosa] 50% de probabilidad de obtener 50 el sigilo negro, 50% de no obtener nada"
  },
  Event_6855_Desc = {
    Text = "Un gato, cuya procedencia es desconocida, se sienta entre las d-babas; su figura borrosa indica que debería ser un habitante de la dimensión espiritual.\nEsta proyección, cuyo rostro es incierto, observa a Ramona con una mirada sabia, levantando su pata blanca como si le hiciera señas"
  },
  Event_6855_Name = {
    Text = "Residentes Nómadas"
  },
  Event_6856_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6856_Desc = {
    Text = "Un retrato alegre de grupo.\nLas figuras de cera están elegantemente vestidas, sentadas en sillas con sonrisas exageradas.\nSon tan armoniosas como las que podrías ver en cualquier manicomio.\n\nFecha: Año 305 de la Era Holocénica, @2 Rogers"
  },
  Event_6856_Name = {
    Text = "Galería de retratos"
  },
  Event_6857_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6857_Desc = {
    Text = "Con cuidado, sacaste los fragmentos y los inspeccionaste. Se quedó inmóvil nuevamente.\n \"Torpe, no te muevas\", dijo muñeca mientras te daba un suave golpe en la parte de atrás de la cabeza, \"en poco tiempo no podré traerte otro\""
  },
  Event_6857_Name = {
    Text = "Broche Inquieto"
  },
  Event_6858_ChoiceDesc1 = {
    Text = "[Usar llave]"
  },
  Event_6858_ChoiceDesc2 = {Text = "[Salir]"},
  Event_6858_Desc = {
    Text = "Una puerta bloquea tu camino. Intentas de todo, pero no se mueve"
  },
  Event_6858_Name = {
    Text = "Puerta oxidada"
  },
  Event_6858_Tips1 = {
    Text = "Requiere obtener la \"Llave oxidada\""
  },
  Event_6859_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6859_Desc = {
    Text = "Te sientes avergonzado por tu autoritarismo. \n Un guardián del secreto calificado debe ser riguroso, no deberías hacer juicios apresurados sobre si no son \"productos de alta gama\". \n Así que decides observarlos detenidamente. Han pasado cinco minutos, han pasado diez minutos... \n Bien, ahora puedes emitir un juicio: en efecto, son productos de mala calidad."
  },
  Event_6859_Name = {Text = "Alma Presa"},
  Event_6860_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6860_Desc = {
    Text = "Tú y tus compañeros bajaron las armas.\nNo fue por compasión, sino porque sabías que sus cuerpos tambaleantes no durarían mucho.\nTu juicio resultó correcto"
  },
  Event_6860_Name = {Text = "Borrador"},
  Event_6861_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6861_Desc = {
    Text = "\"¡Ven a perseguirme!\"\n\"¡Vamos, idiota!\"\n\"¡Atrévete a atraparnos!\"\nLas voces de los niños son triunfantes.\n\"¡Malditos! ¡Deténganse!\"\nLa voz de un adulto suena jadeante"
  },
  Event_6861_Name = {
    Text = "Nuestros Recuerdos"
  },
  Event_6862_ChoiceDesc1 = {
    Text = "[Entrar]Atravesar la niebla, llegar al otro lado"
  },
  Event_6862_ChoiceDesc2 = {Text = "[Salir]"},
  Event_6862_Desc = {
    Text = "Esta es la persona que buscas, has completado la misión"
  },
  Event_6862_Name = {
    Text = "Pasillo secreto 26"
  },
  Event_6863_ChoiceDesc1 = {
    Text = "[Salir]obtiene reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_6863_Desc = {
    Text = "¡Ah! ¡Casi lo logro! Espera, ¿por qué los tres dados sumaron diez? \nLos dados yacen tranquilos frente a ti, luciendo inocentes"
  },
  Event_6863_Name = {
    Text = "Juego sin fin"
  },
  Event_6864_ChoiceDesc1 = {
    Text = "[Salir]obtiene reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_6864_Desc = {
    Text = "¡Maldita sea! No son las seis, pero aún hay algo de beneficio.\nEntonces, ¿qué hora es realmente?"
  },
  Event_6864_Name = {
    Text = "Juego sin fin"
  },
  Event_6865_ChoiceDesc1 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_6865_Desc = {
    Text = "Aunque no acertaste, podemos aceptarlo.\n¿Cuáles fueron los puntos que lanzaron?"
  },
  Event_6865_Name = {
    Text = "Juego sin fin"
  },
  Event_6866_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6866_Desc = {
    Text = "Bajas la cabeza, recogiendo fragmentos de yeso, reconstruyéndola poco a poco, su cuerpo toma forma bajo tus manos"
  },
  Event_6866_Name = {
    Text = "ensamblar restos"
  },
  Event_6867_ChoiceDesc1 = {
    Text = "[Recoger la llave]"
  },
  Event_6867_Desc = {
    Text = "Un manojo de llaves oxidadas. Puede usarse para abrir cerraduras"
  },
  Event_6867_Name = {
    Text = "Llave oxidada"
  },
  Event_6868_ChoiceDesc1 = {
    Text = "[Frente]50% de probabilidad de ganar reliquia de oro\"(RelicConfig.Arg2)\"，50% de probabilidad de infección\"(Skill.Arg3)\""
  },
  Event_6868_ChoiceDesc2 = {
    Text = "[opuesto] 50% de probabilidad de obtener 75 el sigilo negro, 50% de probabilidad de infección\"(Skill.Arg3)\""
  },
  Event_6868_ChoiceDesc3 = {
    Text = "[pedir al oponente que elija primero]50% de probabilidad de obtener la reliquia maldita\"(RelicConfig.Arg2)\"，50% de probabilidad de infectar\"(Skill.Arg3)\""
  },
  Event_6868_Desc = {
    Text = "Solo una apuesta, no perderás.\nUna moneda grabada fue lanzada al aire y cayó rápidamente, calentándose en tu palma"
  },
  Event_6868_Name = {
    Text = "Jugador famoso"
  },
  Event_6869_ChoiceDesc1 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_6869_Desc = {
    Text = "\"Quien confía en el destino, también será derribado por él.\"\nDecides irte"
  },
  Event_6869_Name = {
    Text = "Jugador famoso"
  },
  Event_6870_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6870_Desc = {
    Text = "\"Guardián.\"\nLa voz de Ramona te despierta, pero la sensación de caída no desaparece"
  },
  Event_6870_Name = {
    Text = "Espejo en el espejo"
  },
  Event_6871_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6871_Desc = {
    Text = "Se dice que la serenata es una canción de amor.\nEn las noches de verano, fuera de la ventana de un amante, la gente se reúne para tocar melodías románticas.\nEspontánea y superficial, no es del gusto de Rogers, pero sigue siendo parte de su repertorio.\nSolo él sabe la razón"
  },
  Event_6871_Name = {Text = "mal gusto"},
  Event_6872_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6872_Desc = {
    Text = "Rechazas dejarte seducir por sus murmullos. \n Dices: \"¡Son puras mentiras! Están atrapados en una eterna oscuridad, ¿cómo pueden viajar por el universo?\" \n Los ojos se ríen. Incontables risas se fusionan en una gran ola de sonido, y tu corazón tiembla con ello. \n Los ojos dicen: \"A través de la depredación de otros ojos. Cada ojo es un universo. Cuando tengas mil ojos, comenzarás un verdadero viaje a través del tiempo y el espacio.\""
  },
  Event_6872_Name = {Text = "ojo"},
  Event_6873_ChoiceDesc1 = {
    Text = "[Reclamar]Obtén 1 de 3 reliquias de oro"
  },
  Event_6873_Desc = {
    Text = "Oh, sí, ese reflejo odioso eres tú.\nLa malicia brota y se mezcla con el lodo negro a tus pies, bailando torcidamente. Si no te importa, también quiere subirse a tu hombro"
  },
  Event_6873_Name = {
    Text = "Bajo la superficie del espejo"
  },
  Event_6874_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6874_Desc = {
    Text = "No pasó mucho tiempo antes de que las ataduras se soltaran de repente, haciéndote tambalear.\nTe giras hacia el hilo silencioso—\"No perturbar las arenas movedizas\", quizás esa frase también aplique en el dominio"
  },
  Event_6874_Name = {Text = "Enredado"},
  Event_6875_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6875_Desc = {
    Text = "La llama de la sabiduría se encendió, quemando todas las ataduras—\nAl menos, eso crees"
  },
  Event_6875_Name = {Text = "Enredado"},
  Event_6876_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6876_Desc = {
    Text = "Te liberas con fuerza, los hilos rasgan tu ropa y dejan marcas de sangre en tu piel.\nAunque la telaraña se llevó algo como peaje, te sientes aliviado: eres libre"
  },
  Event_6876_Name = {Text = "Enredado"},
  Event_6877_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6877_Desc = {
    Text = "Las cartas generadas por los organismos adicionales de disolución también suelen ser borradas. \nNo pudiste obtener información valiosa del papel de carta, así que lo rasgaste y lo dejaste caer."
  },
  Event_6877_Name = {
    Text = "Capítulo Mariposa"
  },
  Event_6878_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6878_Desc = {
    Text = "Aunque las palabras se borren intencionalmente, aún puedes percibir claramente el valor de la carta"
  },
  Event_6878_Name = {
    Text = "Capítulo Mariposa"
  },
  Event_6879_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6879_Desc = {
    Text = "Precaución.\nRamona se agachó, volvió al pasillo y se deslizó al siguiente cuarto"
  },
  Event_6879_Name = {
    Text = "Reflejo en la ventana"
  },
  Event_6880_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6880_Desc = {
    Text = "Lanzaste un grito desesperado.\nLos cuervos, atraídos por tu voz, desaparecieron rápidamente, dejando marcas negras"
  },
  Event_6880_Name = {
    Text = "Canto de los Cuervos"
  },
  Event_6881_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6881_Desc = {
    Text = "Te encoges, tratando de convertirte en un punto negro.\nAsí no te notarán, ¿verdad?\nNo sabes cuánto tiempo pasa, abres los ojos.\nVes luz"
  },
  Event_6881_Name = {
    Text = "Canto de los Cuervos"
  },
  Event_6882_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6882_Desc = {
    Text = "Las sombras se deslizaron entre sus dedos, dejando polvo dorado en el suelo"
  },
  Event_6882_Name = {
    Text = "Usador de llave de plata"
  },
  Event_6883_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6883_Desc = {
    Text = "Te revuelves el cabello desordenadamente, mientras la imaginación y la locura estallan en tu mente, con un bulto cubierto de moco negro escondido en lo profundo.\n¿Qué te dará si lo abres?"
  },
  Event_6883_Name = {
    Text = "Agitar el cerebro"
  },
  Event_6884_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6884_Desc = {
    Text = "Las manchas de aceite de colores llenan poco a poco tu campo de visión, y tus emociones caen en una celebración caótica."
  },
  Event_6884_Name = {
    Text = "Agitar el cerebro"
  },
  Event_6885_ChoiceDesc1 = {Text = "[Guardar]"},
  Event_6885_Desc = {
    Text = "Una sustancia plateada, similar al mercurio, extraída de la disolución, contiene un poderoso poder espiritual, utilizada principalmente para enlazar más despertadores en rituales"
  },
  Event_6885_Name = {
    Text = "Núcleo de plata"
  },
  Event_6886_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6886_Desc = {
    Text = "Risas alegres salen de la caja, y tras la desaparición del resplandor cálido, ves una tarjeta con tres figuras de palitos: tú, Ramona de cabello plateado y Ogier de cabello dorado. Al lado hay una línea de texto.\n   \"¡Gracias a ustedes!\""
  },
  Event_6886_Name = {
    Text = "Regalo Amable"
  },
  Event_6887_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6887_Desc = {
    Text = "Tu cuerpo evitó el enjambre de mariposas, pero no perdieron su objetivo, se metieron en tu maletín, chupando la tinta de la máquina de escribir"
  },
  Event_6887_Name = {
    Text = "Délire éruptif"
  },
  Event_6888_ChoiceDesc1 = {
    Text = "[Señalar el error] Elige 1 Tarjeta de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_6888_ChoiceDesc2 = {
    Text = "[escuchar la interpretación] por cada despertador con nivel de locura de 50 o más, obtiene 15 el sigilo negro"
  },
  Event_6888_ChoiceDesc3 = {
    Text = "[Salir]obtiene elección de 3 para 1 de oración"
  },
  Event_6888_Desc = {
    Text = "El chico de cera toca una pieza en el piano.\nSu maestro, también de cera, lo guía al lado.\n133, 355, 244...\nMal, cada nota está mal"
  },
  Event_6888_Name = {
    Text = "Clases de piano"
  },
  Event_6889_ChoiceDesc1 = {
    Text = "[Dejar de resistir]eliminar 1 carta de comando，obtener Arg1 el sigilo negro"
  },
  Event_6889_ChoiceDesc2 = {
    Text = "[Retirar las manos]"
  },
  Event_6889_Desc = {
    Text = "No puedes resistir la impulsividad de tu corazón. \nLos dedos vagan y juegan sobre el teclado, como niños perdidos en el bosque... \nPoco a poco, mariposas comenzaron a salir de la máquina de escribir. \nUna, dos, tres... \nEn la cara, en los dedos, mariposas como fuegos artificiales brillaban en la oscuridad. \nEsta máquina de escribir no tiene uso práctico, pero es experta en crear belleza."
  },
  Event_6889_Name = {
    Text = "Chispa de inspiración"
  },
  Event_6890_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6890_Desc = {
    Text = "Levantas el papel bajo la luz rojiza, temiendo perderte un detalle. \n Es un informe médico, y la persona examinada es Mason. \n \"Peso 40 kg, concentración de oxígeno en sangre normal, tasa de sincronización 30%, valor de resonancia...\" \n Quieres seguir leyendo, pero la escritura comienza a desvanecerse. \n Tan limpio como si nada hubiera ocurrido."
  },
  Event_6890_Name = {
    Text = "Máquina de escribir"
  },
  Event_6891_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6891_Desc = {
    Text = "Sí, no estás huyendo, estás persiguiendo un objetivo definido — el \"sabueso infernal\" que se abre camino por los angostos callejones cubiertos de nieve. No olvidarás esto, así como no olvidarás el rostro de quien te sacó de los escombros aquel día en Tunguska... ¿quién era?"
  },
  Event_6891_Name = {Text = "Correr"},
  Event_6892_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6892_Desc = {
    Text = "En este espacio fuera del aislamiento, solo puedes confiar en ti mismo"
  },
  Event_6892_Name = {
    Text = "Marchador de pesadillas"
  },
  Event_6893_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6893_Desc = {
    Text = "Crisis y riesgo van de la mano. Al tocar la cerradura de hierro, el líquido corrosivo quemó tu palma. Esperemos que lo que hay detrás de la puerta valga la pena"
  },
  Event_6893_Name = {
    Text = "Tras la puerta de hierro"
  },
  Event_6894_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6894_Desc = {
    Text = "En un mundo desconocido, tu mente tambaleante no ha degenerado hasta perder la razón.\nComprendes profundamente el terror de lo desconocido"
  },
  Event_6894_Name = {
    Text = "Marchador de pesadillas"
  },
  Event_6895_ChoiceDesc1 = {
    Text = "[Gritar fuerte] obtiene reliquia de plata «(RelicConfig.Arg1)», infecta «(Skill.Arg2)»"
  },
  Event_6895_ChoiceDesc2 = {
    Text = "[sentir silencio]Obtén una reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\"，\"(Skill.Arg3)\""
  },
  Event_6895_ChoiceDesc3 = {
    Text = "[Surgir a la superficie]gana 25 el sigilo negro"
  },
  Event_6895_Desc = {
    Text = [[
Escuchaste el silencio.
Un silencio amplificado, como el sonido de las olas, llenando todo el espacio.

Levantaste la cabeza, como un punto mirando las estrellas]]
  },
  Event_6895_Name = {
    Text = "Agua del pasado"
  },
  Event_6896_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6896_Desc = {
    Text = "Pones atención, buscando el origen del sonido, intentando atrapar a este malhechor que causa disturbios. \n Pero como si fuera una burla intencionada, cuando crees haber acorralado a la persona, siempre te encuentras atrapado en un ciclo sin salida, siendo devuelto al mismo lugar. \n Desalentado, pateas la pared de ladrillos, pero un bloque cae de la pared, revelando un destello oculto en el hueco de la pared."
  },
  Event_6896_Name = {
    Text = "Rastro Misterioso"
  },
  Event_6897_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6897_Desc = {
    Text = "Debe ser un problema de reproducción, seguro que es eso.\nRebobinaste la aguja del tocadiscos, soportando la música desagradable de la primera mitad, pero el sonido de los golpes que recordabas no apareció.\nDetrás de ti, una pequeña sombra negra en el suelo se escabullía silenciosamente"
  },
  Event_6897_Name = {
    Text = "Rastro Misterioso"
  },
  Event_6898_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6898_Desc = {
    Text = "No hay nadie a tu alrededor, el secreto de los golpes debe estar escondido en los mecanismos internos del fonógrafo. \n Debido a tu confianza en tu propio juicio, desarmaste el viejo fonógrafo. \n Aparte de los componentes metálicos corroídos y una gruesa capa de polvo, no encontraste nada. \n Solo una risa tenue se dispersa en la neblina, tan ligera que parece que estás en un sueño."
  },
  Event_6898_Name = {
    Text = "Rastro Misterioso"
  },
  Event_6899_ChoiceDesc1 = {
    Text = "[Materia blanca del tonto]Recupera Arg1 de vida"
  },
  Event_6899_ChoiceDesc2 = {
    Text = "[Corazón del loco]Obtén de manera aleatoria una carta de comando y recibe un sello:\"(EnchantConfig.Arg1)\""
  },
  Event_6899_ChoiceDesc3 = {
    Text = "[Rechazar el consumo]obtienes 25 el sigilo negro"
  },
  Event_6899_Desc = {
    Text = "\"La carne del loco es tan deliciosa como una sopa de pescado hirviendo, y el corazón del maniaco se ha asado hasta convertirse en un scone caliente y sanguinolento.\"\nLa sombra sonríe siniestramente, presentándote un plato con ingredientes desconocidos. \nInhalas profundamente, el aroma penetrante se introduce a la fuerza en tus fosas nasales, tus glándulas salivales, sin dignidad, se rinden primero, mientras tu estómago gime de pena, contrayéndose en una súplica de deseo."
  },
  Event_6899_Name = {
    Text = "Festín de carne"
  },
  Event_6900_ChoiceDesc1 = {
    Text = "[tocar el carillón]infecta\"(Skill.Arg1)\"，aleatoriamente 1 carta de comando obtiene un sigilo:\"(EnchantConfig.Arg2)\""
  },
  Event_6900_ChoiceDesc2 = {
    Text = "[observar el carillón]infecta\"(Skill.Arg1)\"，aleatoriamente 1 carta de comando obtiene un sigilo:\"(EnchantConfig.Arg2)\""
  },
  Event_6900_ChoiceDesc3 = {
    Text = "[no hacer nada]elige aleatoriamente 1 carta de comando, obtén plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_6900_Desc = {
    Text = "Ding ding, ding ding...\nEs una campana oxidada, su música torpe se filtra por las grietas"
  },
  Event_6900_Name = {
    Text = "Viento oxidado"
  },
  Event_6901_ChoiceDesc1 = {
    Text = "[Observa y Espera]Intenta sobrevivir"
  },
  Event_6901_ChoiceDesc2 = {
    Text = "[Blandir arma] intentar escapar"
  },
  Event_6901_ChoiceDesc3 = {
    Text = "[Apretar una mano]Gana 25 el sigilo negro"
  },
  Event_6901_Desc = {
    Text = "De repente, el suelo bajo tus pies se transformó en un pantano negro, de donde emergieron innumerables manos. \n Tenían una variedad de tonos de piel, materiales y texturas; azul pavo real, escamosas, con ojos, como si hubieran atravesado innumerables dimensiones y espacios, intentando arrastrar al siguiente desafortunado a su gran familia. \n Decidiste——"
  },
  Event_6901_Name = {
    Text = "Marisma Oscura"
  },
  Event_6902_ChoiceDesc1 = {
    Text = "[Mantenerlo]Selecciona 1 carta de comando aleatoria de tu mazo"
  },
  Event_6902_ChoiceDesc2 = {
    Text = "[Sacudir un poco] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_6902_ChoiceDesc3 = {
    Text = "[no hacer nada]obtén 25 el sigilo negro"
  },
  Event_6902_Desc = {
    Text = "Ding ding, ding ding...\nEs una campana oxidada, su música torpe se filtra por las grietas"
  },
  Event_6902_Name = {
    Text = "Campanilla del viento"
  },
  Event_6903_ChoiceDesc1 = {
    Text = "[refutarles] obtiene reliquia de plata\"(RelicConfig.Arg1)\"， selecciona 1 para infectar síntomas"
  },
  Event_6903_ChoiceDesc2 = {
    Text = "[Sigue su ejemplo]elija 1 carta de comando de entre 3 para obtener plegaria:\"(EnchantConfig.Arg1)\"，contagiar\"(Skill.Arg2)\""
  },
  Event_6903_ChoiceDesc3 = {
    Text = "[Proponer una nueva perspectiva]Gana 25 el sigilo negro"
  },
  Event_6903_Desc = {
    Text = "\"Por favor, mantente alejado de nosotros.\"\nUn grupo de ratas te rodea, manteniendo al menos cinco pies de distancia. \n\"Nos esforzamos por reproducirnos, crecemos fuertes, nunca somos exigentes—y así traemos enfermedades, ansiedad y sufrimiento a los humanos.\"\n\"No deberíamos acercarnos demasiado a los humanos, este no es un lugar para ti.\"\nPara relajar la vigilancia de las ratas, decides—"
  },
  Event_6903_Name = {Text = "Peste"},
  Event_6904_ChoiceDesc1 = {
    Text = "[Seguir Cayendo]Infectar\"(Skill.Arg1)\", ¿continuar cayendo?"
  },
  Event_6904_ChoiceDesc2 = {
    Text = "[Retirarse]obtienes 25 el sigilo negro"
  },
  Event_6904_Desc = {
    Text = "\"Tú\" te invita a adentrarte más.\nEn las profundidades de la espiral, el \"Tú\" del pasado y del futuro te envía 'regalos' de diferentes dimensiones."
  },
  Event_6904_Name = {
    Text = "Abismo espiral"
  },
  Event_6905_ChoiceDesc1 = {
    Text = "[Sujetar al cuervo]obtener 40 el sigilo negro，infectar\"(Skill.Arg2)\"，continuar eligiendo"
  },
  Event_6905_ChoiceDesc2 = {
    Text = "[No preocuparse]obtener 25 el sigilo negro y salir"
  },
  Event_6905_Desc = {
    Text = "El cuervo solitario arrancaba sus plumas negras una por una con su voz ronca.\nTemblaba de dolor, gritaba agudamente, pero no podía detener sus movimientos cada vez más rápidos.\n\"¡Caw—Caw—\"\nLágrimas azules mezcladas con tinta negra fluían de sus ojos, y nadie más que tú lo veía"
  },
  Event_6905_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_6906_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6906_Desc = {
    Text = "Rojo, apasionado, exuberante, brillante, conozco a una belleza así, con el tiempo la conocerás.\nEntonces, ¿cuál es tu próxima elección?"
  },
  Event_6906_Name = {
    Text = "El espectáculo comienza"
  },
  Event_6907_ChoiceDesc1 = {Text = "[Aplausos]"},
  Event_6907_ChoiceDesc2 = {
    Text = "[Somnoliento]"
  },
  Event_6907_Desc = {
    Text = "Tuviste un sueño muy largo. \n En el sueño, estabas sentado en la audiencia, mirando al niño que cantaba en el escenario. \n \"El viejo Charlie tenía un gato atigrado que amaba mucho \n cuando ella desapareció sin razón, él la buscó por todas partes.\" \n ... \n Una voz vacía y seca repetía mecánicamente, sin fin..."
  },
  Event_6907_Name = {
    Text = "Ceremonia final IV"
  },
  Event_6908_ChoiceDesc1 = {
    Text = "[Desatar rama superior]"
  },
  Event_6908_ChoiceDesc2 = {
    Text = "[Desatar rama inferior]"
  },
  Event_6908_Desc = {
    Text = "Las conexiones de la gnosis que quedan del dominio se entrelazan, formando un campo de fuerza inestable.\nQuizás puedas liberar el espíritu entrelazado y aclarar el camino hacia adelante para ti"
  },
  Event_6908_Name = {
    Text = "Camino enredado"
  },
  Event_6909_ChoiceDesc1 = {
    Text = "[Salir]Despertar 2 Despertados"
  },
  Event_6909_Desc = {
    Text = "Te levantas y corres hacia la puerta.\n\"Levantas la tela... \nEl secreto, has descubierto el secreto...\"\nEl ruido se convierte en un mar de estruendos, el suelo tiembla violentamente con una resonancia aterradora.\nNo te atreves a mirar atrás y huyes lo más rápido posible"
  },
  Event_6909_Name = {
    Text = "Ceremonia final V"
  },
  Event_6910_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6910_Desc = {
    Text = "No te resistes, claro, tampoco eliges sumergirte"
  },
  Event_6910_Name = {
    Text = "Cráneo perforado"
  },
  Event_6911_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6911_Desc = {
    Text = "Dejas de resistirte, permitiendo que la corrupción consuma tu cuerpo y mente. Después de un largo sueño, la luz plateada cae en tus manos entrelazadas"
  },
  Event_6911_Name = {
    Text = "Cráneo perforado"
  },
  Event_6912_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6912_Desc = {
    Text = "Cuanto más luchas, más se hunde la suciedad en tu mente, y en lo más profundo de tu cerebro lleno de pecado, hay un regalo desconocido"
  },
  Event_6912_Name = {
    Text = "Cráneo perforado"
  },
  Event_6913_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6913_Desc = {
    Text = "Con la ruptura de la red, algo pasó fugazmente por tu mente, como las sonrisas de unos niños"
  },
  Event_6913_Name = {
    Text = "Red errante"
  },
  Event_6914_ChoiceDesc1 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_6914_Desc = {
    Text = "El gato asintió satisfecho y se desvaneció en una sombra, dejando algunos objetos negros y redondos"
  },
  Event_6914_Name = {
    Text = "Residentes Nómadas"
  },
  Event_6915_ChoiceDesc1 = {
    Text = "[Leer la carta]elimina 1 carta de comando, obtiene Arg1 el sigilo negro"
  },
  Event_6915_ChoiceDesc2 = {
    Text = "[Cerrar la caja]"
  },
  Event_6915_Desc = {
    Text = "Las cartas voladoras llenaban el cielo, como una silenciosa urgencia"
  },
  Event_6915_Name = {
    Text = "Carta inesperada"
  },
  Event_6916_ChoiceDesc1 = {
    Text = "[Entrar]Atravesar la niebla, llegar al otro lado"
  },
  Event_6916_ChoiceDesc2 = {Text = "[Salir]"},
  Event_6916_Desc = {
    Text = "Apareció un túnel oculto en el camino frente a mí, lleno de niebla negra, sin saber a dónde conduce"
  },
  Event_6916_Name = {Text = "túnel"},
  Event_6917_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6917_Desc = {
    Text = "Decides poner fin a su sufrimiento, así que agarras su cuerpo suave, apretando, apretando más...\nLucha desesperadamente en tu mano, finalmente explota en una cálida masa de agua"
  },
  Event_6917_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_6918_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6918_Desc = {
    Text = "Tranquilo, esto es solo un recuerdo fragmentado de otra persona en la dimensión. Tienes una sombra. Pero, ¿la persona en la sombra sigue siendo realmente tú?"
  },
  Event_6918_Name = {
    Text = "Fragmentos de memoria: Cerveza"
  },
  Event_6919_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6919_Desc = {
    Text = "Con fuerza, retuviste el pico afilado del cuervo que intentaba morder sus plumas, pero él se retorció obstinadamente, con tanta fuerza que incluso hizo crujir tus huesos. \n Te sonrojaste, esforzándote al máximo para dominar el cuerpo del cuervo y detener su autolesionismo frenético. \n Justo cuando suspirabas aliviado, el cuello ya medio calvo del cuervo se retorció bruscamente hacia atrás y su cuerpo se volvió blando, convirtiéndose en un charco de una espesa sustancia negra en tus manos."
  },
  Event_6919_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_6920_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6920_Desc = {
    Text = "Ignoras fríamente las campanas desesperadas.\nIncluso si en el próximo segundo serás devuelto al mundo primitivo, incluso si tú y tu gran misión serán enterrados juntos.\nUna llamada que no debe ser contestada, no debe ser contestada.\nConoces bien esta sencilla verdad"
  },
  Event_6920_Name = {
    Text = "Por favor, contesta el teléfono"
  },
  Event_6921_ChoiceDesc1 = {
    Text = "[Mirar hacia abajo]obtener 25 el sigilo negro"
  },
  Event_6921_ChoiceDesc2 = {
    Text = "[tengo que encontrar]Obtén una reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_6921_Desc = {
    Text = "Perseguiste la sombra y de repente entraste en aguas poco profundas. El líquido sin color visible empapó tus zapatos, transmitiendo un frío.\nUna voz en el agua dijo: \"No querrás encontrarlo.\""
  },
  Event_6921_Name = {
    Text = "No querrás encontrar"
  },
  Event_6922_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6922_Desc = {
    Text = "Opción segura"
  },
  Event_6922_Name = {
    Text = "detrás del montón de heno"
  },
  Event_6923_ChoiceDesc1 = {
    Text = "[Ahuyentar cuervos]Obtén Arg1 sigilos negros, contagia\"(Skill.Arg2)\"，continúa eligiendo"
  },
  Event_6923_ChoiceDesc2 = {
    Text = "[Ignorar]obtener 25 el sigilo negro，salir"
  },
  Event_6923_Desc = {
    Text = "¿cómo puede haber cuervos en la habitación del sanatorio? \n Pero realmente escuchaste la risa siniestra de los cuervos, en las sombras hay una fuerza que aún no ha subido al escenario, espiándolos a través de esos ojos de pájaro vacíos. Esas criaturas negras retuercen sus cuellos, de pie sobre la lámpara en la esquina del callejón, mirándote con una mirada llena de malicia. Esas cabezas en sombra parecen compartir un mismo cuerpo sumergido en D-Slime."
  },
  Event_6923_Name = {
    Text = "Lanterne Corbeau"
  },
  Event_6924_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6924_Desc = {
    Text = "No temas la suciedad, obtendrás más de lo que pierdes"
  },
  Event_6924_Name = {
    Text = "detrás del montón de heno"
  },
  Event_6925_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6925_Desc = {
    Text = "La tormenta de sabiduría rodea a Tulu, intercambian una mirada y se adentran en la oscuridad"
  },
  Event_6925_Name = {
    Text = "La Promesa del Agente"
  },
  Event_6926_ChoiceDesc1 = {
    Text = "[Entrar]Atravesar la niebla, llegar al otro lado"
  },
  Event_6926_ChoiceDesc2 = {Text = "[Salir]"},
  Event_6926_Desc = {
    Text = "Cayeron en una oscuridad total.\nAl final de la vista, solo había un rayo de luz, que se filtraba a través de una abertura tan pequeña como una llave.\nLa llave de plata emitía un tenue brillo, guiándote a entrar en ese pasadizo"
  },
  Event_6926_Name = {
    Text = "Pasillo secreto"
  },
  Event_6927_ChoiceDesc1 = {
    Text = "[Infectar\"(Skill.Arg1)\", obtener creación:\"(RelicConfig.Arg2)\"]"
  },
  Event_6927_ChoiceDesc2 = {
    Text = "[elige 1 de 3 cartas de comando, obtén plegaria:\"(EnchantConfig.Arg1)\"]"
  },
  Event_6927_Desc = {
    Text = "Evento 203 (en desarrollo), no es el efecto final"
  },
  Event_6927_Name = {
    Text = "Evento 203 (en desarrollo)"
  },
  Event_6928_ChoiceDesc1 = {
    Text = "[Remendar]Eliminar una carta de comando, Obtener creación:\"(RelicConfig.Arg1)\""
  },
  Event_6928_ChoiceDesc2 = {
    Text = "[Acariciar]elimina 1 carta de ataque/defensa, obtienes sello:\"(EnchantConfig.Arg1)\""
  },
  Event_6928_ChoiceDesc3 = {
    Text = "[desprecio] obtiene 25 el sigilo negro"
  },
  Event_6928_Desc = {
    Text = "\"¿Te gusta mi cuerpo mutilado? Si puedes, ¿podrías ayudarme a juntar mi cuerpo?\"\nLa estatua de yeso, con solo la mitad de su cuerpo, movió los labios, y una voz suave como un velo cayó en tus oídos, saliendo de sus labios fríos y duros"
  },
  Event_6928_Name = {
    Text = "ensamblar restos"
  },
  Event_6929_ChoiceDesc1 = {
    Text = "[desechar el sobre]elige 1 de 3 cartas de comando, obtén plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_6929_ChoiceDesc2 = {
    Text = "[Guardar en el pecho]Infectar\"(Skill.Arg1)\"，Obtener creación：\"(RelicConfig.Arg2)\""
  },
  Event_6929_Desc = {
    Text = "Esta es una carta de auxilio, el remitente se esfuerza por mantener la calma, pero su escritura inclinada revela sin reservas el miedo que oculta. \n\"Todo esto ha superado por completo mis expectativas, si alguien dijera que estoy bajo una maldición, juro que lo creería sin dudar.\" \n\"Alguien dice que estoy loco, y solo tiene razón a medias, estoy al borde de la locura, inestable.\" \n\"¡Pero realmente lo vi! Está mutando y desvaneciéndose, una masa negra y pegajosa intenta trepar por todo mi cuerpo.\" \n\"¡He huido! Huí rápidamente, pero la mirada que me observa nunca se apartó de mí, tengo el presentimiento de que definitivamente me encontrará. ¡Esa repugnante sustancia negra volverá a inundar mi cráneo, quien sea que reciba esta carta, por favor, sálvame—\""
  },
  Event_6929_Name = {
    Text = "Una carta de socorro"
  },
  Event_6930_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6930_Desc = {
    Text = "\"Tranquila,» Ramona te golpeó la cabeza, «solo son fragmentos del pasado. No sé quién los dejó en este pasaje dimensional.»\nDe hecho, hay un aire de nostalgia"
  },
  Event_6930_Name = {
    Text = "Comunicación de emergencia"
  },
  Event_6931_ChoiceDesc1 = {
    Text = "[Seleccionar 1 carta de comando aleatoria para obtener un sigilo:\"(EnchantConfig.Arg1)\"]"
  },
  Event_6931_ChoiceDesc2 = {
    Text = "[Seleccionar 1 carta de comando aleatoria para obtener un sigilo:\"(EnchantConfig.Arg1)\"]"
  },
  Event_6931_ChoiceDesc3 = {
    Text = "[Seleccionar 1 carta de comando aleatoria para obtener un sigilo:\"(EnchantConfig.Arg1)\"]"
  },
  Event_6931_Desc = {
    Text = "Evento 205 (en desarrollo), no es el efecto final"
  },
  Event_6931_Name = {
    Text = "Evento 205 (en desarrollo)"
  },
  Event_6932_ChoiceDesc1 = {
    Text = "[Obtén creación:\"(RelicConfig.Arg1)\""
  },
  Event_6932_ChoiceDesc2 = {
    Text = "[Obtén creación:\"(RelicConfig.Arg1)\""
  },
  Event_6932_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_6932_Desc = {
    Text = "Evento 204 (en desarrollo), no es el efecto final"
  },
  Event_6932_Name = {
    Text = "Evento 204 (en desarrollo)"
  },
  Event_6933_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6933_Desc = {
    Text = "La luna solitaria se eleva en el cielo, y puedes escuchar claramente sus oraciones, con un tono extraño, como el susurro de cosas impuras. \n La oración se detiene, estás a punto de irte. Detrás de ti, aparece una sombra blanca. \n \"Los que espían el destino y profanan las oraciones, tanto el don como el precio llegarán puntualmente.\""
  },
  Event_6933_Name = {
    Text = "Fragmento de Luna de Plata"
  },
  Event_6934_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6934_Desc = {
    Text = "Un sonido de ruptura detrás de ti, reflexionas un momento y te vas"
  },
  Event_6934_Name = {
    Text = "Fragmento de Luna de Plata"
  },
  Event_6935_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6935_Desc = {
    Text = "Un puñado de luz de luna recogido en la palma de la mano se derrama sobre la lápida. \n Alguien ha sido enterrado bajo el espeso lodo, y la multitud de espectadores afirma que esta persona ha llegado a la muerte natural y dormirá en la tierra. \n Pero el lodo enterrado surge, y entre los gritos, emerge un grupo de luna caída."
  },
  Event_6935_Name = {
    Text = "Fragmento de Luna de Plata"
  },
  Event_6936_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6936_Desc = {
    Text = "Solo son seres luchando por sobrevivir, buscando un trozo de madera flotante para descansar...\nSuspiras, dejando que el líquido negro fluya desde la cola de la mariposa"
  },
  Event_6936_Name = {
    Text = "Algo que no debería existir"
  },
  Event_6937_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6937_Desc = {
    Text = "Es una trampa anunciada, y tú conoces bien su peligro.\nComparado con las joyas, tú mismo eres la gema más valiosa"
  },
  Event_6937_Name = {
    Text = "Invertir las garras del mal"
  },
  Event_6938_ChoiceDesc1 = {
    Text = "[Insertar llave de plata]"
  },
  Event_6938_Desc = {
    Text = "En la d-baba sobresaturada parece haber ciertas sustancias... observa con la llave de plata, transfórmalo en tu propia fuerza"
  },
  Event_6938_Name = {
    Text = "Punto de extracción"
  },
  Event_6939_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6939_Desc = {
    Text = "Aceptaste la petición, pero encontraste un pequeño problema.\n\"Esa estatua de cera... ¿cómo es?\"\n\"Es mi busto, obviamente se parece a mí.\"\n\"Pero...\"\n\"Tu cara ya está completamente podrida. ¿No lo sabías?\""
  },
  Event_6939_Name = {
    Text = "Mi mitad del cuerpo"
  },
  Event_6940_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6940_Desc = {
    Text = "Apretas la mano de tu compañero al lado, Ramona te mira con curiosidad, pero finalmente acepta tu gesto"
  },
  Event_6940_Name = {
    Text = "Plegaria del Sueño"
  },
  Event_6941_ChoiceDesc1 = {
    Text = "[Preguntar quién es]elija 1 carta de comando de entre 3 para obtener plegaria:\"(EnchantConfig.Arg1)\"，contagiar\"(Skill.Arg2)\""
  },
  Event_6941_ChoiceDesc2 = {
    Text = "[Mirar fijamente]Elige despertar a un despertado, infecta con \"(Skill.Arg1)\""
  },
  Event_6941_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_6941_Desc = {
    Text = "La intensa sensación de ser observado te hace detenerte. \n \"¿Quién es?\" Miraste en la niebla, \"¿Jenkins, eres tú?\" \n La niebla es espesa, y desde lo profundo del patio llegan ecos de gritos del Cuerpo de fusión. No encuentras nada, solo puedes darte la vuelta, pero casi chocas con un ojo que flota en el aire."
  },
  Event_6941_Name = {
    Text = "Mirada ciega"
  },
  Event_6942_ChoiceDesc1 = {
    Text = "[no tocar monedas]elige aleatoriamente 1 carta de comando, obtiene plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_6942_ChoiceDesc2 = {
    Text = "[tocar la moneda]aumenta Arg1 puntos de salud máxima, infecta\"(Skill.Arg2)\""
  },
  Event_6942_Desc = {
    Text = "Encuentras una moneda antigua en el barro negro.\nUn lado tiene venas rojas y verdes, el otro un retrato en relieve de una duquesa pura y sonriente.\nSus ojos pálidos parpadean y comienzan a moverse erráticamente"
  },
  Event_6942_Name = {
    Text = "Moneda antigua de doble cara"
  },
  Event_6943_ChoiceDesc1 = {
    Text = "[dar la vuelta]obtén 25 el sigilo negro"
  },
  Event_6943_ChoiceDesc2 = {
    Text = "[Continuar avanzando]gana reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_6943_Desc = {
    Text = "Ahí viene de nuevo, ese extraño sonido de pasos. \n Te sigue de cerca, desde el estudio hasta la oficina del director, y de la oficina del director hasta el sótano. \n Sabes que es un tipo cauteloso. \n Mantiene con cuidado la distancia entre ustedes, lo suficiente para no estar demasiado lejos, pero tampoco para resultar incómodo. \n Sin embargo, todavía te sientes profundamente perturbado."
  },
  Event_6943_Name = {Text = "pasos"},
  Event_6944_ChoiceDesc1 = {
    Text = "[observarlo]puedes obtener 25 el sigilo negro"
  },
  Event_6944_ChoiceDesc2 = {
    Text = "[Acarícialo]50% de oportunidad de obtener 50 el sigilo negro, 50% de oportunidad de no obtener nada"
  },
  Event_6944_Desc = {
    Text = "De repente, un gato negro salta de un callejón, rodea tus piernas con un inusual afecto, mientras sus ojos verdes y rasgados brillan con un fulgor escalofriante, como si dijera: \"No lo sigas, juega conmigo un rato, ¿vale?\".  \n\"Ya lo has visto, está a tu lado, esas sombras contaminadas por la locura, fervientes y enloquecedoras... No mires directamente su contorno\"."
  },
  Event_6944_Name = {
    Text = "Elfo de la noche"
  },
  Event_6945_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6945_Desc = {
    Text = "Los despertados esperan tus órdenes, no tienes tiempo para nada más"
  },
  Event_6945_Name = {
    Text = "desde el ángulo"
  },
  Event_6946_ChoiceDesc1 = {
    Text = "[Revisar diapositiva]infección\"(Skill.Arg1)\"，gana reliquia de oro\"(RelicConfig.Arg2)\""
  },
  Event_6946_ChoiceDesc2 = {
    Text = "[Revisar cámara]gana 50 el sigilo negro"
  },
  Event_6946_Desc = {
    Text = "Como si sacaras unas entrañas, la película en el vientre de la cámara fue desgarrada, desechada aquí como un cuerpo abierto, sin que nadie se preocupara. \n Un destello de luz blanca deslumbrante pasó, la cámara abandonada en la esquina se inclinaba, el obturador fue presionado sin razón. \n \"Ka-chac——\" \n Tu expresión de asombro y confusión fue fielmente registrada en el rollo de película de la cámara."
  },
  Event_6946_Name = {
    Text = "Registro de inocencia"
  },
  Event_6947_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6947_Desc = {
    Text = "Solo es el sonido del viento moviendo las cadenas, no hay nada de qué preocuparse, ignóralo"
  },
  Event_6947_Name = {
    Text = "Tras la puerta de hierro"
  },
  Event_6948_ChoiceDesc1 = {
    Text = "[Elegir]Infecta\"(Skill.Arg1)\""
  },
  Event_6948_ChoiceDesc2 = {
    Text = "[Elegir]Infecta\"(Skill.Arg1)\""
  },
  Event_6948_ChoiceDesc3 = {
    Text = "[Elegir]Infecta\"(Skill.Arg1)\""
  },
  Event_6948_Desc = {
    Text = "\"'Yo' soy único, entre millones de universos, sin igual.\""
  },
  Event_6948_Name = {
    Text = "Resonancia de almas"
  },
  Event_6949_ChoiceDesc1 = {
    Text = "[Reclamar]Selecciona 1 reliquia de plata"
  },
  Event_6949_Desc = {
    Text = "Quizás sea \"yo\".\nA través de las sombras del tiempo, a través de las barreras dimensionales, mirándome a través de una grieta \"yo\""
  },
  Event_6949_Name = {
    Text = "Resonancia de almas"
  },
  Event_6950_ChoiceDesc1 = {
    Text = "[Señalar el problema]elige 1 de 3 cartas de comando y obtienes sello:\"(EnchantConfig.Arg1)\""
  },
  Event_6950_ChoiceDesc2 = {
    Text = "[tragarse dudas] infección\"(Skill.Arg1)\"， reimprimir, puede hacer 1 vez más"
  },
  Event_6950_Desc = {
    Text = "Esto también es un secreto inconfesable para las jóvenes. \n Has tragado la pregunta, pero ella acaricia su pecho y relata un largo sueño de veinticinco años, hablando de su aislamiento después de despertar"
  },
  Event_6950_Name = {
    Text = "Vida Encadenada"
  },
  Event_6951_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6951_Desc = {
    Text = "Arrojaste los papeles y astillas de madera al fuego. Las llamas los devoraron y eructaron satisfechas. Estaban listas para destruir el mundo, pero no sin darte una bendición antes"
  },
  Event_6951_Name = {
    Text = "Fuego tenue"
  },
  Event_6952_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6952_Desc = {
    Text = "Apagas sin piedad la última chispa de odio, y el rencor y la insatisfacción que te rodean parecen disminuir"
  },
  Event_6952_Name = {
    Text = "Fuego tenue"
  },
  Event_6953_ChoiceDesc1 = {
    Text = "[Ahuyentar cuervos]Obtén Arg1 sigilos negros, contagia\"(Skill.Arg2)\""
  },
  Event_6953_ChoiceDesc2 = {
    Text = "[Ignorar]Salir"
  },
  Event_6953_Desc = {
    Text = "Intentaste atrapar al cuervo, pero solo voló de un lado del dormitorio al otro y siguió emitiendo chillidos extraños. Las gotas de líquido negro que caían de donde voló se convirtieron en marcas negras"
  },
  Event_6953_Name = {
    Text = "Lanterne Corbeau"
  },
  Event_6954_ChoiceDesc1 = {
    Text = "[Salir]obtener creación\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_6954_Desc = {
    Text = "\"Eres muy bueno capturando lo esencial,\"dijo el hombre con una sonrisa radiante,\"esa es la comida más deliciosa del mundo, digna de que cada Bestia Glotona la prepare con cuidado y la saboree con atención.\"\n\"Lamentablemente, esta vez no puedo invitarte a probarla. Como compensación, tengo algunas otras delicias conmigo, así que te las regalaré.\"\nDicho esto, el hombre arrojó un trozo de carne blanda y roja. La carne cayó sobre el pavimento del puente, las extremidades pegajosas se retorcían y se movían. Cuando volviste a mirar, la figura del hombre ya se había desvanecido entre las intrincadas estructuras de acero, sin dejar rastro."
  },
  Event_6954_Name = {
    Text = "Compañero extraño VI"
  },
  Event_6955_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6955_Desc = {
    Text = "Desentrañar capas es tu especialidad.\nLa chispa de inspiración aclara tu mente, permitiéndote ver la realidad actual—\nNo importa quién maneje los títeres, escapa y sobrevive"
  },
  Event_6955_Name = {
    Text = "Chispa de inspiración"
  },
  Event_6956_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6956_Desc = {
    Text = "La mariposa se rompe en tu palma, como un techo de vidrio que se hace añicos, los fragmentos caen, caen, caen"
  },
  Event_6956_Name = {
    Text = "Ilusión Ferroviaria"
  },
  Event_6957_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6957_Desc = {
    Text = "Al ver que Ramona no quería acercarse, el gato sacudió la cabeza y se desvaneció en una sombra"
  },
  Event_6957_Name = {
    Text = "Residentes Nómadas"
  },
  Event_6958_ChoiceDesc1 = {
    Text = "[hacer una promesa]obtén la reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_6958_ChoiceDesc2 = {
    Text = "[Rechazar]obtienes reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_6958_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_6958_Desc = {
    Text = "\"Esa fue una memoria inolvidable. \nMi cabeza y extremidades fueron empujadas con fuerza dentro del yeso. \nLa asfixia y la ilusión de muerte me envolvieron profundamente, y me levantaron con fuerza, arrojándome en la costa oscura. \nLo miré y sentí que una parte de mí también había sido arrebatada. \nEsa otra mitad perdida de mi alma, desde entonces reside en esa pequeña, inicial estatua de cera. \nAsí que... ¿puedes ayudarme a encontrar mi mitad del cuerpo?\""
  },
  Event_6958_Name = {
    Text = "Mi mitad del cuerpo"
  },
  Event_6959_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de oración avanzada"
  },
  Event_6959_Desc = {
    Text = "Eres un observador de la memoria, solo puedes ver cómo la chica cae al mar oscuro.\nEl agua empuja su falda hacia arriba, pero ella se hunde, como una flor sin abrir"
  },
  Event_6959_Name = {
    Text = "Hundirse en el mar"
  },
  Event_6960_ChoiceDesc1 = {
    Text = "[Insertar llave de plata]"
  },
  Event_6960_Desc = {
    Text = "En la d-baba sobresaturada parece haber ciertas sustancias... observa con la llave de plata, transfórmalo en tu propia fuerza"
  },
  Event_6960_Name = {
    Text = "Punto de extracción"
  },
  Event_6961_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6961_Desc = {
    Text = "No prestes atención a las tentaciones del enemigo, podría ser una trampa"
  },
  Event_6961_Name = {
    Text = "Cuervo Maldito"
  },
  Event_6962_ChoiceDesc1 = {Text = "[Ayudarlo]"},
  Event_6962_ChoiceDesc2 = {
    Text = "[Observación Fría]"
  },
  Event_6962_Desc = {
    Text = "El chico está en el escenario, la luz blanca ilumina su rostro.\n\"Para, para...\"\nEl chico se sonroja. Abre la boca, pero no emite ningún sonido.\nSu boca negra se abre más y más"
  },
  Event_6962_Name = {
    Text = "Ceremonia final III"
  },
  Event_6963_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6963_Desc = {
    Text = "\"¡Qué odioso, qué odioso!\" Como si hubieras tocado un interruptor, el gato negro de repente mostró su verdadera naturaleza y abrió la boca para morder tu brazo. Afortunadamente, esquivaste a tiempo, y solo mordió un pedazo de la esquina de tu ropa. El gato negro saltó hacia la esquina de la calle y desapareció en la alcantarilla del callejón."
  },
  Event_6963_Name = {
    Text = "Elfo de la noche"
  },
  Event_6964_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6964_Desc = {
    Text = "Arrastrado por el torrente en tu mente, abres la puerta y te adentras en un camino sin retorno.\n¿La luz blanca y ardiente afuera es redención o destrucción?"
  },
  Event_6964_Name = {
    Text = "Más allá de las puertas dobles"
  },
  Event_6965_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6965_Desc = {
    Text = "Te acercas con valentía para inspeccionar, y el moco sobre la mesa se abre de repente, revelando lo que hay debajo"
  },
  Event_6965_Name = {
    Text = "Más allá de las puertas dobles"
  },
  Event_6966_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6966_Desc = {
    Text = "Traga saliva, reprime tus dudas y concéntrate en el enemigo.\nDeja que las mariposas se queden en tu cuerpo, aunque sus alas desgarren tus órganos"
  },
  Event_6966_Name = {
    Text = "Efecto mariposa"
  },
  Event_6967_ChoiceDesc1 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_6967_Desc = {
    Text = "El gato asintió satisfecho y se desvaneció en una sombra, dejando algunos objetos negros y redondos"
  },
  Event_6967_Name = {
    Text = "Residentes Nómadas"
  },
  Event_6968_ChoiceDesc1 = {
    Text = "[Insertar llave de plata]"
  },
  Event_6968_Desc = {
    Text = "En la d-baba sobresaturada parece haber ciertas sustancias... observa con la llave de plata, transfórmalo en tu propia fuerza"
  },
  Event_6968_Name = {
    Text = "Punto de extracción"
  },
  Event_6969_ChoiceDesc1 = {
    Text = "[Salir]obtiene 1 reliquia de oro aleatoria, infecta\"(Skill.Arg1)\""
  },
  Event_6969_Desc = {
    Text = "Al ver que aún dudas, Koom se lanzó hacia el montón de tierra y rápidamente desenterró algo con sus patas delanteras, empujándolo hacia ti"
  },
  Event_6969_Name = {
    Text = "Objeto enterrado"
  },
  Event_6970_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6970_Desc = {
    Text = "En el papel está impreso \"Mérimée\", nunca hubo un Mason.\nLa paranoia no es buena señal, Guardián"
  },
  Event_6970_Name = {
    Text = "Máquina de escribir"
  },
  Event_6971_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de reliquia de oro, infecta\"(Skill.Arg1)\""
  },
  Event_6971_Desc = {
    Text = "Los montículos esconden los crímenes indescriptibles de los escultores"
  },
  Event_6971_Name = {
    Text = "Objeto enterrado"
  },
  Event_6972_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6972_Desc = {
    Text = "Las aves tienen sus propias reglas, no actúan según tu voluntad y no tienes derecho a interferir con la naturaleza"
  },
  Event_6972_Name = {
    Text = "Cornejo Solitario"
  },
  Event_6973_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de reliquia de oro, infecta\"(Skill.Arg1)\""
  },
  Event_6973_Desc = {
    Text = "¿Por qué? ¿Por qué se hundió?\nEse día no hubo tormenta ni relámpagos. El cielo nocturno estaba claro, sin estrellas, y la luna llena colgaba baja sobre el horizonte, como un sol frío"
  },
  Event_6973_Name = {
    Text = "Hundirse en el mar"
  },
  Event_6974_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6974_Desc = {
    Text = "\"¡Conductor! ¡Hemos sufrido un ataque terrorista! ... ¡Zzzz!\"\n Parece ser la llamada de aviso del conductor, pensabas en colgar. \n\"Repita, este es el equipo de trabajo externo Misaq, estamos en el tren expreso nocturno de la línea norte escortando a los rehenes de rescate y hemos encontrado... ¡Ahh!\"\n El tono en el teléfono se volvió un susurro ronco, mezclado con gritos agudos y escalofriantes. \n\"El Sacramento se ha consumado. Cordero extraviado, que este baño sagrado purifique tu alma...\""
  },
  Event_6974_Name = {
    Text = "Llamada del tren"
  },
  Event_6975_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6975_Desc = {
    Text = "Recolectar núcleos de plata también es tarea del Guardián del Secreto.\nLas almas que flotan en los cristales puros volverán al mundo con una nueva apariencia"
  },
  Event_6975_Name = {Text = "Alma Presa"},
  Event_6976_ChoiceDesc1 = {
    Text = "[Continuar cayendo]gana aleatoriamente 1 carta de comando y recibe plegaria:\"(EnchantConfig.Arg1)\"，¿continuar cayendo?"
  },
  Event_6976_ChoiceDesc2 = {
    Text = "[Retirarse]obtienes 25 el sigilo negro"
  },
  Event_6976_Desc = {
    Text = "\"Tú\" te invita a adentrarte más.\nEn las profundidades de la espiral, el \"Tú\" del pasado y del futuro te envía 'regalos' de diferentes dimensiones."
  },
  Event_6976_Name = {
    Text = "Abismo espiral"
  },
  Event_6977_ChoiceDesc1 = {
    Text = "[inclinarse hacia delante]Infección\"(Skill.Arg1)\"，obtén una reliquia de oro\"(RelicConfig.Arg2)\""
  },
  Event_6977_ChoiceDesc2 = {
    Text = "[Dejar de observar]obtener 50 el sigilo negro"
  },
  Event_6977_Desc = {
    Text = "Parece que hay un rollo de película debajo de la mesa de operaciones"
  },
  Event_6977_Name = {
    Text = "Recuerdos luminosos"
  },
  Event_6978_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6978_Desc = {
    Text = "Rechaza las distracciones, concéntrate.\nTienes cosas más importantes que hacer"
  },
  Event_6978_Name = {
    Text = "Mi mitad del cuerpo"
  },
  Event_6979_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6979_Desc = {
    Text = [[
Reliquia Sagrada Perdida, herencia invaluable, instrumento para cumplir deseos...
Tal vez solo los tesoros sean tan tentadores]]
  },
  Event_6979_Name = {
    Text = "Método de Entrada Misterioso"
  },
  Event_6980_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6980_Desc = {
    Text = "\"Eres la 'madre' de Lily, pero solo la utilizas como una herramienta para la investigación y la batalla,\" respondiste, \"un niño pequeño puede obedecer a su madre, pero tú no deberías ser la 'madre' de Lily.\""
  },
  Event_6980_Name = {
    Text = "Su elección"
  },
  Event_69813_ChoiceDesc1 = {Text = "[Salir]"},
  Event_69813_Desc = {
    Text = "La luz de la llave de plata parpadea, los brazos parecen estar atemorizados por algún poder, desvaneciéndose en el agua de la charca, y luego desaparecen"
  },
  Event_69813_Name = {
    Text = "Bacin de sangre"
  },
  Event_69814_ChoiceDesc1 = {Text = "[Salir]"},
  Event_69814_Desc = {
    Text = "Te hundes más y más, mientras en tu mente resuenan los susurros caóticos de la Voluntad Suprema. Cierras los ojos y convocas el poder dentro de ti. \n De repente, todos los sonidos y sensaciones extrañas desaparecen, te encuentras tras la puerta, y los tentáculos ensangrentados a tu alrededor han desaparecido, como si nunca hubieran existido. \n Te sientes extrañamente aliviado. Comprendes el precio que has pagado, pero es insignificante: enfrentarás a esa existencia suprema en una forma más fuerte."
  },
  Event_69814_Name = {
    Text = "Bacin de sangre"
  },
  Event_69815_ChoiceDesc1 = {Text = "[Salir]"},
  Event_69815_Desc = {
    Text = "El despertador que tú forjaste con tu memoria no dudó un instante en arrancarte del charco de sangre, tu brazo conectado fue desgarrado, el agua turbia salpicó, y en el agua, innumerables criaturas apenas discernibles se retorcían, el dios primordial creador y destructor anhelaba y devoraba."
  },
  Event_69815_Name = {
    Text = "Bacin de sangre"
  },
  Event_69816_ChoiceDesc1 = {
    Text = "[Llamar entidades]Reducir 100 locura de todas las entidades despiertas, eliminar 1 carta de síntoma"
  },
  Event_69816_ChoiceDesc2 = {
    Text = "[Absorber la piscina de sangre]aumenta Arg1 puntos de salud máxima, infecta 2 cartas \"(Skill.Arg2)\""
  },
  Event_69816_ChoiceDesc3 = {
    Text = "[Insertar llave de plata]Vacía toda la energía-s de llave de plata"
  },
  Event_69816_Desc = {
    Text = "El poder de la vida se presenta en la forma de la muerte ante el ojo primordial. Cuando pisas este lugar vago y nebuloso, el charco de sangre hediondo revela instantáneamente su verdadera forma. \nLa sangre de color rojo oscuro extiende incontables brazos, aferrándose a tus tobillos, tirando hacia arriba, intentando arrastrarte hacia el abismo indescriptible."
  },
  Event_69816_Name = {
    Text = "Bacin de sangre"
  },
  Event_6981_ChoiceDesc1 = {
    Text = "[Recoger la llave]"
  },
  Event_6981_Desc = {
    Text = "Un manojo de llaves oxidadas. Puede usarse para abrir cerraduras"
  },
  Event_6981_Name = {
    Text = "Llave oxidada"
  },
  Event_6982_ChoiceDesc1 = {
    Text = "[Salir]Copiar 1 carta de comando, infectar\"(Skill.Arg1)\""
  },
  Event_6982_Desc = {
    Text = "Bajo la guía de la canción del barco y Celeste, miraste hacia el profundo y oscuro fondo de la cabina: ¿tu sobrevivencia está en esa infinitud de oscuridad?"
  },
  Event_6982_Name = {
    Text = "Canción del barco"
  },
  Event_6983_ChoiceDesc1 = {
    Text = "[sal después]obtén reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_6983_ChoiceDesc2 = {
    Text = "[Rechazar salir]obtienes 75 el sigilo negro，infección\"(Skill.Arg2)\""
  },
  Event_6983_Desc = {
    Text = "¿Es una alucinación? Viste un cuervo girar en el cielo, tarareando una canción familiar:\n\"Entonces, vayamos juntos, tú y yo\nAprovechando que la noche acaba de caer\nComo un borracho moribundo tirado en la calle.\""
  },
  Event_6983_Name = {
    Text = "Voz del enjambre de cuervos"
  },
  Event_6984_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6984_Desc = {
    Text = "El poder de la retrospección no podrá buscar un enlace para ti nuevamente en breve, pero al menos has obtenido un consuelo temporal"
  },
  Event_6984_Name = {
    Text = "Contacto Anómalo"
  },
  Event_6985_ChoiceDesc1 = {
    Text = "[Caer en espiral]Mirar hacia el final de la espiral"
  },
  Event_6985_ChoiceDesc2 = {
    Text = "[Retirarse]obtienes 25 el sigilo negro"
  },
  Event_6985_Desc = {
    Text = "Fuera de la ventana ya no se ve la superficie del mar.\nEl vidrio refleja tu rostro pálido, y en tus pupilas, \"tú\" también miras hacia la ventana.\nLa realidad y el dominio se entrelazan y se distorsionan hasta convertirse en una espiral múltiple"
  },
  Event_6985_Name = {
    Text = "Abismo espiral"
  },
  Event_6986_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6986_Desc = {
    Text = "Aceptas la llamada de la escuela, la voz familiar te tranquiliza. Te animas y sigues adelante"
  },
  Event_6986_Name = {
    Text = "Punto de contacto"
  },
  Event_6987_ChoiceDesc1 = {Text = "[Afirmar]"},
  Event_6987_ChoiceDesc2 = {Text = "[Negar]"},
  Event_6987_ChoiceDesc3 = {
    Text = "[Indiferencia]"
  },
  Event_6987_Desc = {
    Text = "\"Cuánto tiempo sin vernos, amigos.\" Ustedes se han escapado de la batalla con los Portadores de linternas y han obtenido un breve respiro, cuando de repente ven al hombre de cabello largo apareciendo nuevamente al lado del camino, sonriendo y saludándolos, como si la batalla de hace un momento nunca hubiera sucedido. \n\"Comparado con la última vez que nos vimos, el olor a Cerbero en ti se ha vuelto mucho más fuerte. En este tiempo, seguramente has estado en un lugar muy lejano, ¿verdad?\"\n"
  },
  Event_6987_Name = {
    Text = "Compañero extraño V"
  },
  Event_6988_ChoiceDesc1 = {
    Text = "[Preguntarle el Camino] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_6988_ChoiceDesc2 = {
    Text = "[Alejarse de él] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_6988_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_6988_Desc = {
    Text = "La sombra está de pie bajo una delgada farola. \n\"¿Te importaría prestarme un fuego, señor?\"\nNo tienes la costumbre de @2, pero no te importa usar un poco de \"magia\". \nCon tu ayuda, la sombra encenderá el @2 y lo introducirá en el vórtice negro sin fondo. \nEn poco tiempo, ves que un humo blanco comienza a emerger. \n\"Ah——\"\nLa sombra emite un suspiro de placer."
  },
  Event_6988_Name = {
    Text = "La sombra bajo la farola"
  },
  Event_6989_ChoiceDesc1 = {
    Text = "[Confirmar]"
  },
  Event_6989_Desc = {
    Text = [[
En el tablero, lo que ves no es real

Lo que te detiene puede no ser una pared, sino tu falta de curiosidad]]
  },
  Event_6989_Name = {
    Text = "Espacio Fantasma"
  },
  Event_6990_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6990_Desc = {
    Text = "\"Me duele mucho, me duele... hermana Sasa...\"\nMiraste a Sarah, ella protegía nerviosamente a los dos niños, como si no hubiera escuchado. \nLa voz fue desvaneciéndose"
  },
  Event_6990_Name = {
    Text = "\"Hermana Sasha\""
  },
  Event_6991_ChoiceDesc1 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_6991_Desc = {
    Text = "Te levantas y aplaudes al niño. \nParece que siente tu apoyo, el niño saca pecho. \nLa sangre negra brota de su boca, pero no puede detener su canto"
  },
  Event_6991_Name = {
    Text = "Ceremonia final IV"
  },
  Event_6992_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6992_Desc = {
    Text = "Parte de la tristeza se evapora, pero las lágrimas siguen fluyendo sin cesar hacia el pasado místico."
  },
  Event_6992_Name = {
    Text = "Lágrimas del Pantano de las Almas"
  },
  Event_6993_ChoiceDesc1 = {
    Text = "[Apretar la garganta del cantante]Infectar\"(Skill.Arg1)\"、recibir reliquia maldita\"(RelicConfig.Arg2)\""
  },
  Event_6993_ChoiceDesc2 = {
    Text = "[Tropezar con el paso del bailarín]infección dos veces\"(Skill.Arg1)\"，gana reliquia de plata\"(RelicConfig.Arg2)\"y\"(RelicConfig.Arg3)\""
  },
  Event_6993_ChoiceDesc3 = {
    Text = "[Tomar un desvío para salir]gana reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_6993_Desc = {
    Text = "Te bloquean el camino tres figuras viscosas. \n Una figura canta, su voz es ronca y la letra es extraña; te tapas los oídos y la evitas. \n Una figura baila, sus movimientos son rígidos y sus pasos inciertos; cierras los ojos y la esquivas. \n Una figura recita un poema, su ritmo es fragmentado y las frases son incoherentes; no puedes soportarlo más, así que—"
  },
  Event_6993_Name = {
    Text = "Malhechor en el Camino Estrecho"
  },
  Event_6994_ChoiceDesc1 = {Text = "[Salir]"},
  Event_6994_Desc = {
    Text = "Parte de la ira está hirviendo, pero las lágrimas siguen fluyendo hacia un pasado desconocido"
  },
  Event_6994_Name = {
    Text = "Lágrimas del Pantano de las Almas"
  },
  Event_6995_ChoiceDesc1 = {
    Text = "[Ignorar]Infectar\"(Skill.Arg1)\""
  },
  Event_6995_ChoiceDesc2 = {
    Text = "[Darse la vuelta y marcharse]Despertar 1 cuerpo al azar"
  },
  Event_6995_Desc = {
    Text = "El destino cruel yace a los pies del caminante, el camino es claro como un espejo, detrás se oye un leve crujido. \n¿Quién rompió el destino bajo sus pies? ¿Es una ilusión, una trampa, o solo un murmullo, una mentira...? \nAnte ti, una grieta se abre lentamente. \n<Italic: como si fuera a hundirse en el despertar de la Gnosis.>"
  },
  Event_6995_Name = {
    Text = "Grieta reptante"
  },
  Event_6996_ChoiceDesc1 = {
    Text = "[Realizar la prueba]contagiar\"(Skill.Arg1)\"，victoria obtiene 1 reliquia de oro, derrota obtiene 50 el sigilo negro"
  },
  Event_6996_ChoiceDesc2 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_6996_Desc = {
    Text = "Has visto algunos secretos en ese charco de lodo negro reflectante.\nSu reflejo es borroso, rodeado de una niebla negra persistente, te resulta extrañamente familiar, pero no puedes identificarlo"
  },
  Event_6996_Name = {
    Text = "Bajo la superficie del espejo"
  },
  Event_6997_ChoiceDesc1 = {
    Text = "[Imitar maullidos] 50% de probabilidad de obtener 125 el sigilo negro, 50% de probabilidad de infectar «(Skill.Arg2)»"
  },
  Event_6997_ChoiceDesc2 = {
    Text = "[Dar de comer]75% de probabilidad de obtener 100 el sigilo negro, 25% de probabilidad de infección\"(Skill.Arg2)\""
  },
  Event_6997_ChoiceDesc3 = {
    Text = "[Echar a correr]obtienes 50 el sigilo negro"
  },
  Event_6997_Desc = {
    Text = "Te has adentrado en el territorio del gato negro.\nIncontables ojos se abren súbitamente en la oscuridad, llenos de curiosidad, examen, alerta... pero ninguno con benevolencia.\nEsmeralda, ámbar, azul pavo real...\nTe sientes como si estuvieras en un mar brillante de joyas.\nPara escapar, tú—"
  },
  Event_6997_Name = {
    Text = "Ciudad de los gatos"
  },
  Event_6998_ChoiceDesc1 = {
    Text = "[Sobre narciso]elegir aleatoriamente 2 cartas de comando para obtener oración respectivamente：\"(EnchantConfig.Arg1)\"，\"(EnchantConfig.Arg2)\""
  },
  Event_6998_ChoiceDesc2 = {
    Text = "[Sobre el sabueso infernal]obtener reliquia maldita\"(RelicConfig.Arg1)\""
  },
  Event_6998_ChoiceDesc3 = {
    Text = "[Sobre Lily]Infecta con\"(Skill.Arg1)\""
  },
  Event_6998_Desc = {
    Text = "\"Es la hora de las pistas de Dafdel.\""
  },
  Event_6998_Name = {
    Text = "Tiempo de pista"
  },
  Event_6999_ChoiceDesc1 = {
    Text = "[Dejar el indicador]obtener reliquia de oro\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_6999_ChoiceDesc2 = {
    Text = "[Sujetar la aguja]obtener reliquia de oro\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_6999_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_6999_Desc = {
    Text = "Ka-chac, ka-chac, ka— \nLas manecillas del destino se mueven lentamente, el sonido del mecanismo se desplaza fríamente, corriendo hacia una dirección que no deseas ver"
  },
  Event_6999_Name = {
    Text = "Fuera de la punta de la aguja"
  },
  Event_7000_ChoiceDesc1 = {
    Text = "[Hacer como si no escuchara]gana aleatoriamente 3 cartas de comando del mazo, elige 1 carta para eliminar y gana 75 el sigilo negro"
  },
  Event_7000_ChoiceDesc2 = {
    Text = "[revisar con cautela]roba aleatoriamente 3 cartas de comando del mazo, selecciona 1 carta para copiar a su forma original y obtén 25 el sigilo negro"
  },
  Event_7000_ChoiceDesc3 = {
    Text = "[dar la vuelta y salir]obtén 50 el sigilo negro"
  },
  Event_7000_Desc = {
    Text = "El destino cruel yace a los pies del caminante, el camino es claro como un espejo, detrás se oye un leve crujido.\n¿Quién rompió el destino bajo sus pies? ¿Es una ilusión, una trampa, o solo un murmullo, una mentira...?\nAnte ti, una grieta se abre lentamente"
  },
  Event_7000_Name = {
    Text = "Grieta reptante"
  },
  Event_7001_ChoiceDesc1 = {
    Text = "[llamar cuervos] obtiene 25 el sigilo negro， infección\"(Skill.Arg2)\"， continúa eligiendo"
  },
  Event_7001_ChoiceDesc2 = {
    Text = "[Alejarse mucho]"
  },
  Event_7001_Desc = {
    Text = "La garra rasga la capa y se hunde profundamente en tu hombro"
  },
  Event_7001_Name = {
    Text = "Cornejo Solitario"
  },
  Event_7002_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7002_Desc = {
    Text = "El miedo a veces no proviene de lo físico.\nDonde pasa el \"sabueso infernal\", quedan gotas rojas, reflejando tu contorno"
  },
  Event_7002_Name = {
    Text = "Reflejo intangible"
  },
  Event_7003_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7003_Desc = {
    Text = "Acompañada de una ligera corriente, escuchas el susurro de una mujer. \n Ella llora, narrando sin parar sus vivencias. \n Pasó una hora, pasó un día... hasta que ya has olvidado por qué estaba triste. \n Al final, ella cuelga alegremente y promete darte un gran regalo. \n Aceptaste el regalo. De todos modos, un regalo siempre es placentero."
  },
  Event_7003_Name = {
    Text = "Por favor, contesta el teléfono"
  },
  Event_7004_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7004_Desc = {
    Text = "Bajo las miradas confusas de tus compañeros, te arrodillas y pones el puño en tu frente.\nPerfecto, así puedes ocultar tu cara"
  },
  Event_7004_Name = {
    Text = "Falso por verdadero"
  },
  Event_7005_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7005_Desc = {
    Text = "\"Me has cubierto con un velo.\"\nLa estatua de cera te sonríe serenamente. \n\"Te ofrezco la verdad como recompensa por tu arduo trabajo.\"\nDe su abdomen brota un limo negro que te envuelve con fuerza. \nEl mundo es completamente oscuro, pero increíblemente cálido. \nTe acurrucas y bostezas, entrando en el sueño por primera vez..."
  },
  Event_7005_Name = {
    Text = "Estatua de cera inacabada"
  },
  Event_7006_ChoiceDesc1 = {
    Text = "[Confirmar]"
  },
  Event_7006_Desc = {
    Text = "No encuentras nada en la niebla"
  },
  Event_7006_Name = {
    Text = "Niebla del Caos"
  },
  Event_7007_ChoiceDesc1 = {
    Text = "[Atender la llamada]Gana 1 de 3 oraciones avanzadas"
  },
  Event_7007_ChoiceDesc2 = {
    Text = "[Ignorar campana]gana reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_7007_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7007_Desc = {
    Text = "\"ding ding ding...\"\nUn agudo sonido de timbre de teléfono proviene de la esquina, apresurado y ruidoso, cada timbre más alto que el anterior, casi te da la ilusión de que si no contestas, estallará locamente y destruirá el mundo."
  },
  Event_7007_Name = {
    Text = "Por favor, contesta el teléfono"
  },
  Event_7008_ChoiceDesc1 = {
    Text = "[Acercarse al fantasma]Obtén 1 de 3 reliquias de plata"
  },
  Event_7008_ChoiceDesc2 = {
    Text = "[Dispersar el fantasma]obtienes reliquia de plata\"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\"，infección dos veces\"(Skill.Arg3)\""
  },
  Event_7008_Desc = {
    Text = "¿Es un espejismo en el dominio? ¿O es otro recuerdo que no se puede dejar atrás? \n Te frotas los ojos, la sombra en la distancia se acerca a ti—es un mercado bullicioso, es un museo de cera que desapareció en la disolución, es un manicomio en un pequeño pueblo azotado por el viento y la nieve, o es Akut, cuyo paisaje ya se ha vuelto borroso?"
  },
  Event_7008_Name = {Text = "Espejismo"},
  Event_7009_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7009_Desc = {
    Text = "Como si te hubieran quemado con agua hirviendo, instintivamente te tapaste los oídos para bloquear la música maligna"
  },
  Event_7009_Name = {
    Text = "Sonido prohibido"
  },
  Event_7010_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7010_Desc = {
    Text = "El tono brillante disipó la tensión y el miedo, te llenaste de pasión, floreciste, te alegraste y dejaste a Ramona muy atrás—\"¡Guardián del secreto?! ¡No vayas tan rápido!\""
  },
  Event_7010_Name = {
    Text = "Son Anónimo"
  },
  Event_7011_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7011_Desc = {
    Text = "\"¡Detén el paso! ¡Hasta una criatura de corrosión se conoce mejor!\"\nRuegas en tu corazón que libere a la audiencia"
  },
  Event_7011_Name = {
    Text = "Malhechor en el Camino Estrecho"
  },
  Event_7012_ChoiceDesc1 = {
    Text = "[Retirarse]"
  },
  Event_7012_Desc = {
    Text = "Esto es solo un dominio. \n Lo que deseas proteger, lo que deseas escapar, es la realidad única"
  },
  Event_7012_Name = {
    Text = "Abismo espiral"
  },
  Event_7013_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7013_Desc = {
    Text = "\"Eres el más despreciable.\"\nRasgaste el papel en pedazos y lo dejaste volar en el viento, convirtiéndose en pequeños trozos que danzaban. \nEl poeta alzó la vista y observó los caracteres volar con el viento, la comisura de sus labios se curvó con locura. \n\"Qué hermoso...\""
  },
  Event_7013_Name = {
    Text = "Malhechor en el Camino Estrecho"
  },
  Event_7014_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7014_Desc = {
    Text = "Desgarraste el cartel por completo y descubriste que en la parte de atrás se registraban de manera desordenada los gastos del museo de cera. \n El dueño de la escritura evidentemente no tenía paciencia ni talento para las matemáticas, estos registros no se pueden equilibrar de ninguna manera. \n Echaste un vistazo rápido y el mayor gasto parece ser \"mantenimiento y limpieza de las figuras de cera\". \n Los gastos de personal son ridículamente bajos, el último gasto fue de 12 látigos de crin de caballo, con un precio de aproximadamente 20 Lavka. \n También hay un gasto especial: \"su comida\". \n ¿A quién se refiere \"ellos\"?"
  },
  Event_7014_Name = {
    Text = "Risas en la oscuridad"
  },
  Event_7015_ChoiceDesc1 = {
    Text = "[Salir]obtiene reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_7015_Desc = {
    Text = "\"Astuto... y correcta respuesta.\"\nEl dueño de la voz se mostró interesado en la respuesta, un objeto plateado fue arrojado al agua.\n\"Recuerda, todo tiene un precio.\""
  },
  Event_7015_Name = {
    Text = "Voces del más allá"
  },
  Event_7016_ChoiceDesc1 = {
    Text = "[Atrapa la segunda mariposa]elimina 1 carta de comando, obtienes el sigilo negro Arg1"
  },
  Event_7016_ChoiceDesc2 = {
    Text = "[No quedarse más]"
  },
  Event_7016_Desc = {
    Text = "¿Son ellos habitantes de la dimensión espiritual? ¿O vidas nacidas de la disolución?\nCon dudas, entras en una tormenta de mariposas"
  },
  Event_7016_Name = {
    Text = "Tormenta de Conocimiento"
  },
  Event_7017_ChoiceDesc1 = {
    Text = "[observar la tercera mariposa]descarta 1 carta de comando, obtén Arg1 el sigilo negro"
  },
  Event_7017_ChoiceDesc2 = {
    Text = "[No quedarse más]"
  },
  Event_7017_Desc = {
    Text = "Un dolor insoportable en los dedos, sueltas la mano de golpe"
  },
  Event_7017_Name = {
    Text = "Tormenta de Conocimiento"
  },
  Event_7018_ChoiceDesc1 = {
    Text = "[Salir]obtiene 25 sigilos negros, infecta\"(Skill.Arg1)\""
  },
  Event_7018_Desc = {
    Text = "\"¿No tienen otra respuesta, humanos?\"\nEl dueño de la voz gruñó con impaciencia, haciendo temblar todo el espacio.\n\"Codiciosos e ignorantes... por eso me cansan.\""
  },
  Event_7018_Name = {
    Text = "Voces del más allá"
  },
  Event_7019_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7019_Desc = {
    Text = "\"No te preocupes, solo le di un pequeño castigo a un cliente codicioso. No puedo evitarlo, no me gusta la cerveza~\""
  },
  Event_7019_Name = {
    Text = "Fragmentos de memoria: Cerveza"
  },
  Event_7020_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7020_Desc = {
    Text = "\"Deja de cantar—\"\nLe adviertes al desafinado cantante que no vuelva a torturar tus oídos"
  },
  Event_7020_Name = {
    Text = "Malhechor en el Camino Estrecho"
  },
  Event_7021_ChoiceDesc1 = {
    Text = "[Salir]Despertar 2 Despertados"
  },
  Event_7021_Desc = {
    Text = "Te das la vuelta y te pierdes en el largo pasillo. \nEl interminable corredor casi agota tu paciencia, hasta que encuentras un pequeño escenario destartalado.\nParpadeas y el escenario desaparece"
  },
  Event_7021_Name = {
    Text = "Ceremonia final II"
  },
  Event_7022_ChoiceDesc1 = {
    Text = "[Recoger copa] obtener carta especial"
  },
  Event_7022_Desc = {
    Text = "Una copa de líquido dorado y claro, reluciente como las olas doradas del trigo en el otoño tardío, emana un aroma dulce, similar a la miel. ¿Cuáles son sus ingredientes? ¿Quién lo ha puesto aquí? ¿Por qué no hay nadie que lo cuide?\nAntes de que estas preguntas sean respondidas, un pensamiento misterioso asciende a tu mente: debes beberlo ahora, de inmediato.\nEn este momento, te transformas repentinamente en una polilla hechizada por las llamas, en un insecto atrapado por una planta carnívora, incapaz de resistir la tentación de alcanzar esa copa de vino dulce—"
  },
  Event_7022_Name = {
    Text = "Vino dulce de miel"
  },
  Event_7023_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7023_Desc = {
    Text = "Intentas examinar esta puerta, pero desaparece al tocarla, y oyes algo abrirse a lo lejos"
  },
  Event_7023_Name = {
    Text = "Puerta Extraña"
  },
  Event_7024_ChoiceDesc1 = {
    Text = "[No hacer nada]"
  },
  Event_7024_ChoiceDesc2 = {
    Text = "[Limpiar la huella]"
  },
  Event_7024_Desc = {
    Text = "La oficina de Francis es fría y ordenada, reflejando el esmero de su dueño. \n En la caja del rincón, descubriste una impresión de polvo de 5 pulgadas de lado. \n La forma de la huella es extraña: el contorno exterior parece la huella de una bestia, mientras que en el centro está incrustada la pequeña huella de la mano de una niña humana. Parece que primero se dejó la huella humana, y luego la enorme mano de la bestia la cubrió. \n Por supuesto, puedes imaginar una escena cálida, como si una bestia dócil y sumisa cubriera con sus garras el dorso de la mano de la niña, ofreciéndole un suave consuelo. \n Pero conoces la verdad: es la marca dejada por un monstruo que ha sido fusionado en crueles experimentos."
  },
  Event_7024_Name = {
    Text = "Huella de bestia gigante"
  },
  Event_7025_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7025_Desc = {
    Text = "Los experimentos errantes te han agotado, un breve respiro es como lluvia en un desierto seco"
  },
  Event_7025_Name = {
    Text = "Puerta infinita"
  },
  Event_7026_ChoiceDesc1 = {
    Text = "[maestro]obtén reliquia maldita\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_7026_ChoiceDesc2 = {
    Text = "[Llevárselo] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_7026_ChoiceDesc3 = {
    Text = "[Desmontarlo]obtienes 50 el sigilo negro"
  },
  Event_7026_Desc = {
    Text = "Estabas avanzando, y golpeaste algo con los pies.\nEra una brújula, el vidrio roto, y la parte restante estaba cubierta de d-baba, la giraste con cuidado y vislumbraste el escudo de la universidad de mitag grabado en la parte posterior"
  },
  Event_7026_Name = {
    Text = "Su elección"
  },
  Event_7027_ChoiceDesc1 = {
    Text = "[Leer la carta]elimina 1 carta de comando, obtiene Arg1 el sigilo negro"
  },
  Event_7027_ChoiceDesc2 = {
    Text = "[Cerrar la caja]"
  },
  Event_7027_Desc = {
    Text = "Una carta, otra carta, otra más. \n El papel de carta está lleno de tu pasado y también dibuja tu futuro. Atraído por una extraña seducción, no puedes evitar rasgar y devorar el papel. \n \"¿Eh? ¿Qué locura estás haciendo? ¿Tomando aire?\" \n Murphy te da una patada para sacarte de la ilusión, y al volver en ti, no hay nada frente a ti."
  },
  Event_7027_Name = {
    Text = "Carta inesperada"
  },
  Event_7028_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de oración"
  },
  Event_7028_Desc = {
    Text = "Al escuchar tu voz, la silueta se detiene; la voz de Clementine apenas logra atravesar la densa niebla.\n\"Oh—eres tú\", dice, indistinta y difusa, como la luz de la luna disolviéndose en el agua. \"No te preocupes, estarás bien\"— es un pensamiento agradable, pero difícil de creer.\n\"Cuando termines aquí, nos volveremos a encontrar.\""
  },
  Event_7028_Name = {
    Text = "Figura en la niebla"
  },
  Event_7029_ChoiceDesc1 = {
    Text = "[Destinatario: departamento académico]obtener reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_7029_ChoiceDesc2 = {
    Text = "[Destinatario: compañero]obtener reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_7029_Desc = {
    Text = "Al escribir el destinatario, el papel comenzó a humear. Una mano invisible atravesó el vacío y te arrebató el papel—\ncon un sonido similar a la masticación, tu cuerpo se sintió pesado de repente.\nPero la creación en tu mano te dice que no fue en vano"
  },
  Event_7029_Name = {
    Text = "Confesión unilateral"
  },
  Event_7030_ChoiceDesc1 = {
    Text = "[Insertar llave de plata]"
  },
  Event_7030_Desc = {
    Text = "En la d-baba sobresaturada parece haber ciertas sustancias... observa con la llave de plata, transfórmalo en tu propia fuerza"
  },
  Event_7030_Name = {
    Text = "Punto de extracción"
  },
  Event_7031_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7031_Desc = {
    Text = "Esperemos a que salgan de las sombras"
  },
  Event_7031_Name = {
    Text = "Lanterne Corbeau"
  },
  Event_7032_ChoiceDesc1 = {
    Text = "[llamar cuervos] obtiene 35 el sigilo negro， infección\"(Skill.Arg2)\"， continúa eligiendo"
  },
  Event_7032_ChoiceDesc2 = {
    Text = "[Alejarse mucho]"
  },
  Event_7032_Desc = {
    Text = "Las aves negras, convocadas, se hinchan y vomitan algo en tu mano.\nVuelven a los mástiles, mirándote intensamente"
  },
  Event_7032_Name = {
    Text = "Cornejo Solitario"
  },
  Event_7033_ChoiceDesc1 = {
    Text = "[Entrar en la cueva]"
  },
  Event_7033_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7033_Desc = {
    Text = "\"Cof, cof...\"\nQué sonido tan familiar... ¡Lo recuerdo!\nLos humanos hacen este sonido cuando están enfermos o a punto de morir.\n¡Vamos a ver!"
  },
  Event_7033_Name = {
    Text = "Profundidades de la cueva"
  },
  Event_7034_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7034_Desc = {
    Text = "Has estudiado todo sobre los núcleos de plata, incluyendo cómo identificar su grado. \n Evidentemente, estos núcleos de plata no cumplen con los requisitos básicos de refinamiento. \n Te ves obligado a liberarlos, así como a las almas rotas que podrían estar atrapadas en ellos. \n Aprender a desprenderse también es una lección obligatoria para el Guardián del Secreto."
  },
  Event_7034_Name = {Text = "Alma Presa"},
  Event_7035_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7035_Desc = {
    Text = "Este es un pasaje unidireccional, no puedes volver a la entrada por él"
  },
  Event_7035_Name = {Text = "Pasaje"},
  Event_7036_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7036_Desc = {
    Text = "Cuanto antes termine, antes estaré tranquilo. Los investigadores de Missaga nunca temen al peligro"
  },
  Event_7036_Name = {
    Text = "Puerta infinita"
  },
  Event_7037_ChoiceDesc1 = {
    Text = "[Pedir que se mueva, tengo prisa]"
  },
  Event_7037_ChoiceDesc2 = {
    Text = "[Quiero saber más]"
  },
  Event_7037_Desc = {
    Text = "\"Disculpa, por favor detente. Pareces preocupado y con prisa, tal vez en algún problema.\nPero no deberías perder la perspectiva y la calma por una crisis.\nPor ejemplo, he estado pensando en las inconsistencias en la leyenda de Cerbero.\""
  },
  Event_7037_Name = {
    Text = "Compañero extraño II"
  },
  Event_7038_ChoiceDesc1 = {
    Text = "[Recibir el regalo]"
  },
  Event_7038_ChoiceDesc2 = {
    Text = "[Rechazo cortés]"
  },
  Event_7038_Desc = {
    Text = "El niño está sentado en el alféizar de la ventana mirándote. Ha estado esperándote durante mucho tiempo. \n \"La actuación fue un éxito, gra, gracias.\" \n \"Estoy a punto de irme... este es un regalo para ti.\" \n El niño te muestra las manos. \n Ves una caja de regalo bellamente envuelta, de la que fluye sangre, tiñendo las manos del niño."
  },
  Event_7038_Name = {
    Text = "Ceremonia final VI"
  },
  Event_7039_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7039_Desc = {
    Text = "Ojalá siempre tengas esa confianza"
  },
  Event_7039_Name = {
    Text = "Reflejo intangible"
  },
  Event_7040_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7040_Desc = {
    Text = "Has aceptado esta pequeña y suave oreja. \n Envuelta en una densa cera, reposa tranquilamente en el centro de tu palma. \n En tu interior surge un fuerte sentido de responsabilidad. \n Primero, no se puede ir a la barra sin más, la música allí es demasiado caótica. \n En segundo lugar, tampoco se puede ir al Teatro Wellington, la orquesta allí está pasada de moda. \n Luego... \n tú y tus compañeros aceptan bien el hecho de tener una pequeña mascota más."
  },
  Event_7040_Name = {
    Text = "Presta atención"
  },
  Event_7041_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7041_Desc = {
    Text = "\"El profesor Alistair es la piedra angular de Misaq; sin él, todo el sistema de Misaq dejará de funcionar.\"\n Recuerdas vagamente que en una clase aburrida, Czort, con el rostro serio, dijo esta frase mientras golpeaba la pizarra. \n Si esta piedra angular se desmorona en fragmentos, ¿cómo te enfrentarás a ello? Un gran miedo te envolvió. \n\"¿A dónde vas?\" La voz de Ramona te devolvió a la realidad. \n ¿Era el pasado o el futuro, era real o imaginario, o era un sueño de otro dimensión? No lo sabías. \n En tu mano, apareció un \"regalo\"."
  },
  Event_7041_Name = {
    Text = "Grito del caos"
  },
  Event_7042_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7042_Desc = {
    Text = "\"Esta silla de ruedas es como mis segundas piernas, probablemente nunca me separe de ella,\"el profesor Alistair sonríe con tristeza, \"Lástima que me hace ver más bajo.\"\n\nPor lo tanto, este no puede ser el verdadero profesor Alistair"
  },
  Event_7042_Name = {
    Text = "Grito del caos"
  },
  Event_7043_ChoiceDesc1 = {
    Text = "[¿Quién habla?] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7043_ChoiceDesc2 = {
    Text = "[¿Qué Whiskey? Déjame Probar también] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7043_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7043_Desc = {
    Text = "\"¿De verdad no quieres probar un sorbo? Este es un buen whiskey. Si no fuera porque el dueño de esa taberna fue generoso y me regaló toda una botella, no te daría ni una gota.\"\n\"Entonces, ayudaste a echar a ese tipo flaco y arrugado, con la piel tan tensa como el caucho, que solo bebía Bloody Mary, y eso es todo lo que el dueño te dio como recompensa. Pasaste un mes en esa investigación, visitando treinta casas, recibiendo once negativas, y gastaste diecisiete balas de revólver. Una botella de whiskey, ni siquiera recuperas lo que invertiste.\"\n\"Está bien, está bien, no seas tan quisquilloso. Al menos, ahora tenemos esta botella de whiskey, ¿no?\""
  },
  Event_7043_Name = {
    Text = "Fragmento de recuerdo: Whisky"
  },
  Event_7044_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7044_Desc = {
    Text = "Agarra el tentáculo del Despertado, él te mira con una luz oscura en sus ojos.\nNo dice nada, pero entiendes su mensaje oculto—\n\"Usurpación.\""
  },
  Event_7044_Name = {
    Text = "Efecto mariposa"
  },
  Event_7045_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7045_Desc = {
    Text = "El telégrafo está completamente roto. Puedes imaginar la desesperación de su dueño en la tormenta... porque ahora tú también la sientes"
  },
  Event_7045_Name = {
    Text = "Reliquias de los antiguos"
  },
  Event_7046_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7046_Desc = {
    Text = "Nombre: Leigh\nEdad: 20\nComplicaciones: Hiperemia acompañada de severa histeria\nAnomalía: Tentáculos rojos @2 bocas\nImplantes: Tejido de órganos de parentesco directo @3\nRazón de entrega: No hay razón especial. No me gusta.\n(Los contenidos posteriores han sido tachados)"
  },
  Event_7046_Name = {
    Text = "Registro de órganos"
  },
  Event_7047_ChoiceDesc1 = {
    Text = "[Elegir 'Aceptar el don']pierde todos los el sigilo negro. Obtiene 1 reliquia de oro"
  },
  Event_7047_Desc = {
    Text = "Una bola de barro negro apareció frente a ti, temblando al entregarte un documento. \n\"No puedo presentarme en este momento... Pero puede informarse sobre nuestros servicios personalizados...\"\n Una voz femenina salió del pecho del barro negro, ligeramente nerviosa, como si estuviera esquivando algo. \n\"La Bendición de la Hada entra en vigor según el nivel de membresía, garantizando que no haya engaños.\"\n\"¡Firma, rápido, firma!\""
  },
  Event_7047_Name = {
    Text = "Bendición de la Hada"
  },
  Event_7048_ChoiceDesc1 = {
    Text = "[Escuchar atentamente]obtener reliquia de plata\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7048_ChoiceDesc2 = {
    Text = "[Acercarse y revisar]Todos los despertados recuperan 50 de locura, infecta con \"(Skill.Arg1)\""
  },
  Event_7048_ChoiceDesc3 = {
    Text = "[Sal de inmediato]Obtén 1 de 3 sellos"
  },
  Event_7048_Desc = {
    Text = "\"¿Lo sabías?\" Mientras Ramona busca al misterioso hombre, una voz surge repentinamente, como si alguien susurrara, \"¿Sabías sobre ese asunto? El gran asunto.\""
  },
  Event_7048_Name = {
    Text = "El oído del otro"
  },
  Event_7049_ChoiceDesc1 = {
    Text = "[enfocarse]elimina hasta 2 cartas de síntoma"
  },
  Event_7049_ChoiceDesc2 = {
    Text = "[Meditación]Elige despertar a un Despertado"
  },
  Event_7049_ChoiceDesc3 = {
    Text = "[Conectar] recuperar Arg2 puntos de vida"
  },
  Event_7049_Desc = {
    Text = "Exploras en la niebla, de repente, el emblema en tu pecho emite un débil resplandor plateado. ¿Quién te llama desde el comunicador?"
  },
  Event_7049_Name = {
    Text = "Punto de contacto"
  },
  Event_7050_ChoiceDesc1 = {
    Text = "[Actuar con cautela] aumenta Arg1 puntos de PV Max"
  },
  Event_7050_ChoiceDesc2 = {
    Text = "[Avanzar al encuentro] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7050_Desc = {
    Text = "Una sombra creada por el dominio te extendió la mano, su figura era borrosa.\nRecuerdas que un investigador de Missaga subió a este barco, ¿será él?\n¿O es solo otro triste recuerdo atrapado en el dominio?"
  },
  Event_7050_Name = {
    Text = "Usador de llave de plata"
  },
  Event_7051_ChoiceDesc1 = {
    Text = "[Salir]obtiene reliquia de oro\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_7051_Desc = {
    Text = "\"Mira, por un comentario mío ignoré la emergencia más urgente, eso no está bien.\nSi seguimos perdiendo tiempo, su presa se escapará.\nPara disculparme, aquí tienen estas cosas.\"\n\nEl hombre cambia de tema abruptamente y les entrega un objeto"
  },
  Event_7051_Name = {
    Text = "Compañero extraño II"
  },
  Event_7052_ChoiceDesc1 = {
    Text = "[Salir]de 3 cartas de comando selecciona 1 para obtener oración:\"(EnchantConfig.Arg1)\""
  },
  Event_7052_Desc = {
    Text = [[
"Que tus deseos se hagan realidad."
El hombre se aparta, dejando un camino libre]]
  },
  Event_7052_Name = {
    Text = "Compañero extraño II"
  },
  Event_7053_ChoiceDesc1 = {Text = "[Guardar]"},
  Event_7053_Desc = {
    Text = "Una sustancia plateada, similar al mercurio, extraída de la disolución, contiene un poderoso poder espiritual, utilizada principalmente para enlazar más despertadores en rituales"
  },
  Event_7053_Name = {
    Text = "Núcleo de plata"
  },
  Event_7054_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7054_Desc = {
    Text = "Tomaste otro desvío.\nEl sol sigue saliendo, los humanos siguen muriendo, y tú sigues perdido.\nNada es nuevo"
  },
  Event_7054_Name = {
    Text = "Laberinto de los Ojos"
  },
  Event_7055_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7055_Desc = {
    Text = "Parece una sombra distorsionada por la luz"
  },
  Event_7055_Name = {
    Text = "Objeto flotante en el cubo"
  },
  Event_7056_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7056_Desc = {
    Text = "Te das la vuelta y solo ves un par de zapatos solitarios.\n\"Lo siento, no tengo malas intenciones.\"\n\"Si ves mi cuerpo, por favor dile que su compañero más fiel lo espera en la vitrina 45 de la sala 1.\"\n\"——Recuerda, son de cuero de vaca, no de cabra.\""
  },
  Event_7056_Name = {Text = "Oxford"},
  Event_7057_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7057_Desc = {
    Text = "Debe ser un exalumno—abriste los brazos hacia él, pero lo que siguió fue un dolor helado.\nDespués de que el dolor desapareció, tus extremidades se sintieron increíblemente fuertes, como nunca antes"
  },
  Event_7057_Name = {
    Text = "Usador de llave de plata"
  },
  Event_7058_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7058_Desc = {
    Text = "Sientes que la niebla frente a ti se disipa\n\nSientes que tu visión se agudiza para las próximas acciones"
  },
  Event_7058_Name = {
    Text = "Prueba de los Asuras"
  },
  Event_7059_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7059_Desc = {
    Text = "La ilusión también se acerca a ti, los recuerdos regresan de repente, el panorama se aclara"
  },
  Event_7059_Name = {Text = "Espejismo"},
  Event_7060_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7060_Desc = {
    Text = "Su inconsciencia aún cambia algo en el vacío"
  },
  Event_7060_Name = {Text = "Su mirada"},
  Event_7061_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7061_Desc = {
    Text = "En una emergencia, no es momento de recolectar núcleos de plata"
  },
  Event_7061_Name = {
    Text = "Prueba de existencia"
  },
  Event_7062_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de reliquia de plata, infecta\"(Skill.Arg1)\""
  },
  Event_7062_Desc = {
    Text = "La figura borrosa se fue volviendo más clara, no era un Cuerpo de fusión, ni una Catástrofe, sino Clementine, sin alas y con una expresión normal. \n \"Qué coincidencia, ¿también has venido a admirar la luz de la luna?\" dijo sonriendo, pero tú sientes un mareo, \"En una noche de niebla densa, hay que tener mucho cuidado. \n \"Los pequeños de aquí no son muy tranquilos.\""
  },
  Event_7062_Name = {
    Text = "Figura en la niebla"
  },
  Event_7063_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7063_Desc = {
    Text = "Con el sonido de la escayola rompiéndose contra el suelo, su cuerpo se hizo añicos. Los gritos de desesperación llenaron tu mente, pero por suerte, te detuviste a tiempo"
  },
  Event_7063_Name = {
    Text = "Completar el cuerpo dañado"
  },
  Event_7064_ChoiceDesc1 = {
    Text = "[Escuchar la tristeza] Elige 1 Tarjeta de comando entre 3 para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7064_ChoiceDesc2 = {
    Text = "[Escuchar alegría]por cada despertador con un valor de locura de 50 o más, gana 15 el sigilo negro"
  },
  Event_7064_ChoiceDesc3 = {
    Text = "[Salir]obtiene elección de 3 para 1 de oración"
  },
  Event_7064_Desc = {
    Text = "Melodías suaves, líricas, alegres, tristes... La melodía resuena en el espacio del dominio, difícil de discernir su origen.\n¿Es la sonata que fluyó del barco fantasma, o un capricho atrapado en el dominio, a medianoche?"
  },
  Event_7064_Name = {
    Text = "Son Anónimo"
  },
  Event_7065_ChoiceDesc1 = {
    Text = "[están buscando a alguien]elimina 1 carta de comando, obtén 25 el sigilo negro"
  },
  Event_7065_ChoiceDesc2 = {
    Text = "[Están buscando algo]Copia una carta del mazo, infecta con\"(Skill.Arg1)\""
  },
  Event_7065_Desc = {
    Text = "¿Por qué los Portadores de linternas aparecieron repentinamente en la Villa de Lai? Hay demasiados misterios aquí. \n El Perro del infierno Cerbero, el director del manicomio de Rai, Francis, la Asociación de escultores, la Iglesia de la Linterna... \n Debe haber alguna fuente que los reúne en este pequeño pueblo que no es muy próspero. \n La máquina de escribir comenzó a escupir tinta automáticamente, como si te invitara a escribir algo."
  },
  Event_7065_Name = {
    Text = "Método de Entrada Misterioso"
  },
  Event_7066_ChoiceDesc1 = {
    Text = "[Cerrar los Ojos]"
  },
  Event_7066_ChoiceDesc2 = {
    Text = "[Huir de la escena]"
  },
  Event_7066_Desc = {
    Text = "La actuación se detuvo abruptamente. Miras a tu alrededor y ves que el público está lleno.\nTodos tienen la misma cara que el niño, mirándote fijamente.\nAh——\nAbren sus bocas negras en silencio"
  },
  Event_7066_Name = {
    Text = "Ceremonia final V"
  },
  Event_7067_ChoiceDesc1 = {
    Text = "[Recoger la foto]elige 1 de 3 cartas de comando y obtienes sello:\"(EnchantConfig.Arg1)\""
  },
  Event_7067_ChoiceDesc2 = {
    Text = "[Revisar película]infección\"(Skill.Arg1)\"，cambia la plegaria obtenida en la opción 1, que se puede usar una vez más"
  },
  Event_7067_Desc = {
    Text = "Colocaste el rollo de película bajo la luz roja tenue, la base semitransparente revela vagamente las imágenes. \n Manos, pies, globos oculares, vísceras... Todos los órganos humanos que puedes imaginar, e incluso los que no, están fielmente registrados en la película. \n Han sido cuidadosamente lavados y dispuestos, ordenados como tu primer poema con métrica."
  },
  Event_7067_Name = {
    Text = "registrar fielmente"
  },
  Event_7068_ChoiceDesc1 = {
    Text = "[Guardia de la princesa]despertar aleatoriamente 1 despertador, infectar\"(Skill.Arg1)\""
  },
  Event_7068_ChoiceDesc2 = {
    Text = "[Meditador]de 3 cartas de comando selecciona 1 para ganar plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7068_Desc = {
    Text = "\"Toc, toc, toc...»\nLos pasos se acercan, parece que alguien va a abrir la puerta del estudio.\nUstedes no tienen adónde retroceder, así que solo pueden hacerse pasar por esculturas de cera en la penumbra, intentando evadir esa mirada escrutadora"
  },
  Event_7068_Name = {
    Text = "Falso por verdadero"
  },
  Event_7069_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7069_Desc = {
    Text = "\"¡Qué bien, qué bien!\" La voz estaba llena de alegría, \"¡Finalmente te has vuelto como yo, hermana Sasa!\""
  },
  Event_7069_Name = {
    Text = "\"Hermana Sasha\""
  },
  Event_7070_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7070_Desc = {
    Text = "Quizás alguien los llevó aquí.\nCon tu exploración, la identidad de esa persona saldrá a la luz"
  },
  Event_7070_Name = {
    Text = "Método de Entrada Misterioso"
  },
  Event_7071_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7071_Desc = {
    Text = "Cuanto antes termine, antes estaré tranquilo. Los investigadores de Missaga nunca temen al peligro"
  },
  Event_7071_Name = {
    Text = "Puerta sin fin"
  },
  Event_7072_ChoiceDesc1 = {
    Text = "[Elegir moral]Recupera Arg1 de vida"
  },
  Event_7072_ChoiceDesc2 = {
    Text = "[Elegir vida]Recupera toda la salud, infecta\"(Skill.Arg2)\""
  },
  Event_7072_Desc = {
    Text = "Quizás alguna vez tuviste un corazón de oro.\nLatía día y noche, esforzándose por tu vida y tu existencia... cálido, apasionado y lleno de esperanza.\nPero en algún momento, comenzó a latir más lento. Como si solo pudiera soportar la vida o la moral"
  },
  Event_7072_Name = {
    Text = "Sed de maldición"
  },
  Event_7073_ChoiceDesc1 = {
    Text = "[Recoger la foto]elige 1 de 3 cartas de comando y obtienes sello:\"(EnchantConfig.Arg1)\""
  },
  Event_7073_ChoiceDesc2 = {
    Text = "[Revisar película]infección\"(Skill.Arg1)\"，cambia la plegaria obtenida en la opción 1, que se puede usar dos veces"
  },
  Event_7073_Desc = {
    Text = "\"Entonces, registraste todo fielmente.\"\n\"Sí, la verdad está en el rollo de película.\"\nLa conversación se detuvo abruptamente, innumerables ojos invisibles se volvieron hacia ti, esperando tu juicio final"
  },
  Event_7073_Name = {
    Text = "Declaración de testigo"
  },
  Event_7074_ChoiceDesc1 = {
    Text = "[Salir]aumenta Arg1 puntos de vida y obtiene 25 sigilos negros"
  },
  Event_7074_Desc = {
    Text = "Tu voz es tragada por el aullido del viento. \n\"No necesitas conocerme,\"el susurro que se mezcla en la frase se vuelve más claro,\"Herbert, Herbert es la persona que están buscando. Deja que ese tipo caiga, de un falso sueño a la dura y fría realidad.\"\n\"Los bendeciré, les daré lo más delicioso de este mundo...\""
  },
  Event_7074_Name = {
    Text = "Compañero extraño VI"
  },
  Event_7075_ChoiceDesc1 = {
    Text = "[Salir]obtener creación\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7075_Desc = {
    Text = "\"Sí, pobre perdido, que tiene poder pero no puede reconocerse a sí mismo. \n ¿Vas a extender tu mano para ayudar? ¿O levantarás un arma contra Él?\"\n El hombre saltó al torrente, y en el instante en que se lanzó, tus miradas se cruzaron. Eran unos ojos en forma de hendidura, dorados como miel, pertenecientes a una serpiente. \n Y en el lugar donde estaba de pie, había una pequeña lámpara que emanaba humo púrpura."
  },
  Event_7075_Name = {
    Text = "Compañero extraño VI"
  },
  Event_7076_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7076_Desc = {
    Text = "\"La cautela es una virtud, pero la precaución excesiva es inoportuna,\"una voz monótona y constante contenía descontento,\"el movimiento de las estrellas interferirá con el sueño del origen del Despertado, y el momento adecuado permitirá que su alienación se expanda y se llene rápidamente como un globo. En resumen, aún hay tiempo para atrapar la cola del cometa, la próxima vez recuerda optimizar tu velocidad de reacción que es comparable a la de una tortuga.\""
  },
  Event_7076_Name = {
    Text = "Ángulo de elevación"
  },
  Event_7077_ChoiceDesc1 = {
    Text = "[Recuperar]Reducir la mitad del estrés actual"
  },
  Event_7077_Desc = {
    Text = "Tocaste la cápsula de presión, que podía restablecer el valor actual de presión"
  },
  Event_7077_Name = {
    Text = "Punto de estabilización de presión"
  },
  Event_7078_ChoiceDesc1 = {
    Text = "[Consolarla] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_7078_ChoiceDesc2 = {
    Text = "[Acusar a ella]Gana aleatoriamente 3 cartas de comando y recibe plegaria:\"(EnchantConfig.Arg1)\"、infectar\"(Skill.Arg2)\""
  },
  Event_7078_Desc = {
    Text = "\"Soy la sombra del investigador muerto, el asesino es la llave de plata.\"\nLa mujer se cubre la cabeza con dolor. Su cabello es denso, con innumerables ojos brillantes parpadeando, parpadeando...\n\"Siempre dicen: ¡No, Charlotte! ¡Ay, Charlotte!\nAsí que pensé, si pudiera enlazar a muchos Despertados de una vez, todos se callarían.\"\n\"Y luego... no sé qué pasó, al despertar me encontré así. ¡Ay!\""
  },
  Event_7078_Name = {
    Text = "Sombra del Investigador"
  },
  Event_7079_ChoiceDesc1 = {
    Text = "[Saltar la pared alta]gana reliquia maldita\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_7079_ChoiceDesc2 = {
    Text = "[Entrar al laberinto] 1 Carta aleatoria obtiene Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_7079_Desc = {
    Text = "Tu mente es un laberinto.\nDemasiados pensamientos se enredan en él, la salida está al alcance de La Mirada, pero los altos muros del pensamiento se erigen entre vosotros."
  },
  Event_7079_Name = {
    Text = "Laberinto de la mente"
  },
  Event_7080_ChoiceDesc1 = {
    Text = "[Mirar al fantasma]obtiene 3 selecciona 1 reliquia de plata"
  },
  Event_7080_ChoiceDesc2 = {
    Text = "[Acercarse al fantasma]obtener reliquia de plata\"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\"，infectar dos veces\"(Skill.Arg3)\""
  },
  Event_7080_Desc = {
    Text = "En la distancia parece haber un volcán en erupción, y en el cielo azotado por el viento se eleva una nube en forma humana. \n Este es Elworth, donde solo hay montañas nevadas y cavernas de roca caliza que se extienden sin fin. \n ¿Es el extraño fenómeno de estos días lo que te ha vuelto loco?"
  },
  Event_7080_Name = {
    Text = "Fantasma volcánico"
  },
  Event_7081_ChoiceDesc1 = {
    Text = "[he visto algo]Obtén una reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_7081_ChoiceDesc2 = {
    Text = "[no he visto nada]Obtén una reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_7081_Desc = {
    Text = "Un líquido se filtra de tus ojos, la sensación pegajosa es aterradora.\nEn el fondo, es por lo que has visto, pero ¿realmente no viste nada?"
  },
  Event_7081_Name = {
    Text = "No mirar directamente"
  },
  Event_7082_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7082_Desc = {
    Text = "Te sentirás alegre y también triste, pero lo que te ahoga en este momento no son tus emociones. Te cubres los oídos, la llave de plata brilla con luz deslumbrante.\nFinalmente, puedes respirar"
  },
  Event_7082_Name = {Text = "Adicción"},
  Event_7083_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7083_Desc = {
    Text = "El portador de la daga emite un grito, como si fuera un pájaro de luto en un cementerio de medianoche.\nEl sonido se desvanece en un instante, junto con otros dos marineros que desaparecen... Resulta ser solo una ilusión reflejada en el dominio"
  },
  Event_7083_Name = {
    Text = "Perseguir incansablemente"
  },
  Event_7084_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7084_Desc = {
    Text = "Flota en el aire en silencio, sin parpadear, mirándote con urgencia, como si quisiera decirte algo.\nLos ojos pueden albergar el alma, pero sin palabras, solo sientes un poco de urgencia y tristeza.\nDesapareció en el aire"
  },
  Event_7084_Name = {
    Text = "Mirada ciega"
  },
  Event_7085_ChoiceDesc1 = {
    Text = "[expresar acuerdo]obtén la reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_7085_ChoiceDesc2 = {
    Text = "[Ofrecer un regalo]obtiene la reliquia de plata\"(RelicConfig.Arg1)\"，contagiar\"(Skill.Arg2)\""
  },
  Event_7085_ChoiceDesc3 = {
    Text = "[dar la vuelta y salir]obtén 25 el sigilo negro"
  },
  Event_7085_Desc = {
    Text = "\"Si algún día tengo que caer, espero caer en el agua. \n El flujo de agua que pasa por mi nariz es como un suave sueño viejo, \n el líquido en el que me hundo, \n es el cuenco que más desea @2.\""
  },
  Event_7085_Name = {
    Text = "Ceremonia acuática"
  },
  Event_7086_ChoiceDesc1 = {
    Text = "[Resistir el fantasma]obtienes reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_7086_ChoiceDesc2 = {
    Text = "[Absorber locura]despertar al azar 2 cuerpos, infectar dos veces con \"(Skill.Arg1)\""
  },
  Event_7086_Desc = {
    Text = "La dimensión rota se está derrumbando gradualmente, ilusiones de otras dimensiones fluyen en la habitación enferma"
  },
  Event_7086_Name = {
    Text = "Ilusión dimensional"
  },
  Event_7087_ChoiceDesc1 = {
    Text = "[Salir]Despertar 1 Despertado al azar"
  },
  Event_7087_Desc = {
    Text = "La joven se sorprendió y pasó la mano por el borde de su falda.\n\"Lo único que puedo hacer por ti... es esto.\""
  },
  Event_7087_Name = {
    Text = "niña de vestido blanco"
  },
  Event_7088_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7088_Desc = {
    Text = "¿Quién habla?\nBajas la vista y ves un reflejo borroso—lleva la misma ropa que tú, pero sostiene un cuchillo y te sonríe."
  },
  Event_7088_Name = {
    Text = "No querrás encontrar"
  },
  Event_70892_ChoiceDesc1 = {
    Text = "[Cumplir con la memoria del cuerpo]Salta la batalla y gana de inmediato, pero pierdes Arg1 puntos de vida"
  },
  Event_70892_ChoiceDesc2 = {
    Text = "[Salir]entra en batalla"
  },
  Event_70892_Desc = {
    Text = "A pesar de que los enemigos son excepcionalmente fuertes, ya conoces las técnicas para vencerlos."
  },
  Event_70892_Name = {
    Text = "memoria muscular"
  },
  Event_7089_ChoiceDesc1 = {
    Text = "[Abrir el cofre]"
  },
  Event_7089_ChoiceDesc2 = {
    Text = "[Atacar sujeto de prueba]"
  },
  Event_7089_Desc = {
    Text = "Kum mordió la nuca de un sujeto de prueba, listo para sacudirlo, pero el sujeto giró su cabeza 180° como un búho y picoteó la cara de Kum"
  },
  Event_7089_Name = {Text = "Coliseo"},
  Event_7090_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7090_Desc = {
    Text = "Apretaste la llave de plata con fuerza, sintiendo el llamado a la génesis en las oscuras corrientes de la dimensión.\nPara enfrentar al maloso perro infernal de identidad desconocida, debías aprovechar todo el poder posible"
  },
  Event_7090_Name = {
    Text = "Ilusión dimensional"
  },
  Event_7091_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7091_Desc = {
    Text = "\"En cuanto al investigador, el director planea interrogarlo personalmente...\"\nDéjalo vivo...\"\nLa voz se desvanece en la oscuridad"
  },
  Event_7091_Name = {
    Text = "Los muros tienen oídos"
  },
  Event_7092_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7092_Desc = {
    Text = "La sensación de ingravidez te despierta de golpe, el suelo bajo tus pies es firme y confiable, y a tu lado yace un espejo cuadrado y delicado"
  },
  Event_7092_Name = {
    Text = "Espejo en el espejo"
  },
  Event_7093_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7093_Desc = {
    Text = "Tú nunca debates con quienes han caído en la Locura sin remedio, pues eso haría que tu alma fuera completamente Devorada por los interrogantes de la medianoche. ¡Déjalo estar!"
  },
  Event_7093_Name = {
    Text = "Ceremonia acuática"
  },
  Event_7094_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7094_Desc = {
    Text = "¿Cómo debería ser el rostro de la figura de cera?\nCierras los ojos y millones de caras borrosas aparecen en tu mente.\nSe asemejan a velas que arrastran llamas pálidas, surgiendo y desapareciendo en el río de la oscuridad...\nSigues el río hasta el final, donde se encuentra la única y última figura de cera.\nAl acercarte a ella, ves... @2."
  },
  Event_7094_Name = {
    Text = "Estatua de cera inacabada"
  },
  Event_7095_ChoiceDesc1 = {
    Text = "[ataque al que lleva un cuchillo]infecta\"(Skill.Arg1)\"，obtén la reliquia maldita\"(RelicConfig.Arg2)\""
  },
  Event_7095_ChoiceDesc2 = {
    Text = "[Emboscar a portador de cuchillo] infecta dos veces «(Skill.Arg1)», obtiene reliquia de plata «(RelicConfig.Arg2)» y «(RelicConfig.Arg3)»"
  },
  Event_7095_ChoiceDesc3 = {
    Text = "[Tropezar con el portador de la lanza]gana reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_7095_Desc = {
    Text = "Tres marineros te muerden sin soltar, sus miradas locas y ardientes casi encienden tu capa. \n Al mirar hacia atrás, notas que los tres son diferentes entre sí: \n el marinero que sostiene la gran cuchilla grita con más rabia, pero actúa con cierta desidia. \n El marinero que lleva la lanza sigue tus pasos como un niño que balbucea. \n El marinero que empuña la daga queda atrás, sus oraciones murmuradas demuestran su fanaticismo."
  },
  Event_7095_Name = {
    Text = "Perseguir incansablemente"
  },
  Event_7096_ChoiceDesc1 = {
    Text = "[Salir]obtener creación\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7096_Desc = {
    Text = "Aceptaste el regalo, desarmándolo con cuidado.\nUna pareja de ojos yacía en la caja regalo. \n\"Te regalo mis ojos.\" \n\"Como él me hizo a mí.\""
  },
  Event_7096_Name = {
    Text = "Ceremonia final VI"
  },
  Event_7097_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7097_Desc = {
    Text = "Extiendes la mano a través del centro del resplandor y recoges una gota de núcleo plateado solidificado. Este valioso portador de recuerdos y almas está ardiente, reflejando colores extraños.\nAntes de que distorsione y mezcle toda la luz, el dolor ardiente te obliga a devolverlo a la oscuridad"
  },
  Event_7097_Name = {
    Text = "Luz nocturna"
  },
  Event_7098_ChoiceDesc1 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7098_Desc = {
    Text = "Rechazaste el regalo del niño. \nEl niño te miró con sus cuencas vacías. Suspiró suavemente. \n\"Entonces, adiós.\" \nDijo el niño, haciendo un gesto de despedida hacia ti antes de inclinarse hacia la ventana. \nDesapareció, como una mariposa danzante, o como una ráfaga de viento"
  },
  Event_7098_Name = {
    Text = "Ceremonia final VI"
  },
  Event_7099_ChoiceDesc1 = {
    Text = "Elige una plegaria común"
  },
  Event_7100_ChoiceDesc1 = {
    Text = "[Aceptar la oreja]obtener reliquia de plata\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7100_ChoiceDesc2 = {
    Text = "[Rechazar la petición]obtienes sello de 3 opciones"
  },
  Event_7100_Desc = {
    Text = "Una serie de notas brillantes brotan de la yema de sus dedos. \n El melancólico pianista de cera se sienta solo frente a la ventana. \n Desde que adquirió conciencia, el museo de cera ha sido todo su mundo. \n Ha estado aislado durante mucho tiempo y desea escuchar algo diferente, especialmente... una música llamada jazz. \n Finalmente, se arranca una de sus orejas y te pide que la lleves. \n\"Déjame escuchar la música del exterior... solo necesito que la guardes en tu bolsillo.\""
  },
  Event_7100_Name = {
    Text = "Presta atención"
  },
  Event_7101_ChoiceDesc1 = {
    Text = "[Conectar] recuperar Arg2 puntos de vida. [ExDesc1]"
  },
  Event_7101_ChoiceDesc2 = {
    Text = "[Meditación]Elige despertar a un Despertado.[ExDesc1]"
  },
  Event_7101_ChoiceDesc3 = {
    Text = "[Expulsar]Elimina hasta 3 cartas de síntoma y obtén Arg2 sigilos negros"
  },
  Event_7101_Desc = {
    Text = "Exploras en la niebla, de repente, el emblema en tu pecho emite un débil resplandor plateado. ¿Quién te llama desde el comunicador?"
  },
  Event_7101_Name = {
    Text = "Punto de contacto"
  },
  Event_7101_Tips3 = {
    Text = "Actualmente no posees una carta de síntomas"
  },
  Event_7102_ChoiceDesc1 = {
    Text = "[Aceptar desafío]"
  },
  Event_7102_ChoiceDesc2 = {
    Text = "[Dale un puñetazo]gana 25 el sigilo negro"
  },
  Event_7102_Desc = {
    Text = "Una figura delgada emerge de las sombras, bloqueando tu camino. \n Un recuerdo que siempre ha estado atado irrumpe en el Dominio, una sombra que se hace llamar \"N\" juega con las fichas en su mano, invitándote a unirte a su juego con un llanto confuso. \n Fichas de tres colores se despliegan ante ti; si no juegas una \"partida\" con él, probablemente no te dejará ir fácilmente."
  },
  Event_7102_Name = {
    Text = "El espectáculo comienza"
  },
  Event_7103_ChoiceDesc1 = {
    Text = "[Insertar llave de plata]"
  },
  Event_7103_Desc = {
    Text = "En la d-baba sobresaturada parece haber ciertas sustancias... observa con la llave de plata, transfórmalo en tu propia fuerza"
  },
  Event_7103_Name = {
    Text = "Punto de extracción"
  },
  Event_7104_ChoiceDesc1 = {
    Text = "[Despertar con esfuerzo]Aumenta Arg1 puntos de salud máxima"
  },
  Event_7104_ChoiceDesc2 = {
    Text = "[Dejarse caer en el Sueño] 2 Tarjetas de comando aleatorias obtienen Inscripción: \"(EnchantConfig.Arg1)\", infectar 2 \"(Skill.Arg2)\""
  },
  Event_7104_Desc = {
    Text = "Sostienes en tus brazos un brillante tesoro. \n Se adhiere a tu pecho y se extiende por todo tu cuerpo, ese cálido recuerdo que irradia la luz de una vela, finalmente se vierte en tu mente. \n El crepitar del carbón, el sillón junto a la estufa cubierto con una manta, el té caliente y el vientre del gato acurrucado a tus pies... \n En esta cómoda somnolencia, tu mente se nubla y caes en un suave abismo."
  },
  Event_7104_Name = {
    Text = "Sumergirse en el pasado"
  },
  Event_7105_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7105_Desc = {
    Text = "Arrancaste sin piedad el resto de la película, oculta en la cámara, y lo que viste te dejó sin palabras.\nLa película sin revelar mostraba tu cuerpo en un charco de brea"
  },
  Event_7105_Name = {
    Text = "Registro de inocencia"
  },
  Event_7106_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7106_Desc = {
    Text = "Revisaste cuidadosamente la cámara, con cuero y oro negro incrustados en el cuerpo, reflejando un brillo aceitoso.\nSu lente te apuntaba, como si te mirara, te espiara"
  },
  Event_7106_Name = {
    Text = "Registro de inocencia"
  },
  Event_7107_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7107_Desc = {
    Text = "Un puñado de luz de luna recogido en la palma de la mano se derrama sobre la lápida. \n Alguien ha sido enterrado bajo el denso lodo, y la multitud de observadores afirma que esta persona ha encontrado la muerte natural y descansará bajo tierra. \n Pero el lodo enterrado surge, y de entre los gritos, emerge un grupo de luna caída."
  },
  Event_7107_Name = {
    Text = "Fragmento de Luna de Plata"
  },
  Event_7108_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7108_Desc = {
    Text = "Tocas suavemente las alas negras de la mariposa, que aletea suavemente y luego se convierte en gotas negras que caen en tu palma"
  },
  Event_7108_Name = {
    Text = "Algo que no debería existir"
  },
  Event_7109_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7109_Desc = {
    Text = "La luna solitaria cuelga en el cielo, pero puedes oír claramente su canto de oración, un tono extraño, similar al susurro de lo impuro. \n La oración se detiene, estás a punto de irte. Sin embargo, detrás de ti aparece una sombra blanca. \n \"Los que espían el destino y profanan las oraciones, tanto la gracia como el precio llegarán como se prometió.\""
  },
  Event_7109_Name = {
    Text = "Fragmento de Luna de Plata"
  },
  Event_7110_ChoiceDesc1 = {
    Text = "[Tres puntos]"
  },
  Event_7110_ChoiceDesc2 = {
    Text = "[Seis en punto]"
  },
  Event_7110_ChoiceDesc3 = {Text = "[Un punto]"},
  Event_7110_Desc = {
    Text = "Parece que hoy tienes suerte.\nLos dados vibran emocionados.\nDecides adivinar un número"
  },
  Event_7110_Name = {
    Text = "Juego sin fin"
  },
  Event_7111_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7111_Desc = {
    Text = "¡Esta apuesta es una gran estafa!\nTe levantas de golpe, pero sientes un mareo.\nLos dados emiten un zumbido tentador, y una voz seductora resuena en tu mente:\n\"Solo una más... la última...\""
  },
  Event_7111_Name = {
    Text = "Juego sin fin"
  },
  Event_7112_ChoiceDesc1 = {
    Text = "[Usar plata]mejorar 1 reliquia de plata a reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_7112_ChoiceDesc2 = {
    Text = "[Guardar el núcleo de plata]obtener reliquia de oro\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\"y\"(Skill.Arg3)\""
  },
  Event_7112_ChoiceDesc3 = {
    Text = "[Dejar en el cajón]obtener 25 el sigilo negro"
  },
  Event_7112_Desc = {
    Text = "En el segundo cajón a la derecha del escritorio, había un núcleo de plata solitario. Al tocarlo suavemente, escuchaste el rugido de la tormenta, el crujido de la nieve y el lamento de una flauta"
  },
  Event_7112_Name = {
    Text = "Núcleo de plata solitario"
  },
  Event_7113_ChoiceDesc1 = {
    Text = "[Escuchar atentamente]infectar\"(Skill.Arg1)\"，obtener reliquia maldita-\"(RelicConfig.Arg2)\""
  },
  Event_7113_ChoiceDesc2 = {
    Text = "[Hacer un cambio]Elige destruir una creación, obtén una recompensa"
  },
  Event_7113_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7113_Desc = {
    Text = "No todas las melodías son hermosas.\nUna cacofonía pura compone un lamento"
  },
  Event_7113_Name = {Text = "Disonancia"},
  Event_7114_ChoiceDesc1 = {
    Text = "[Recogerlo]infección\"(Skill.Arg1)\"，obtienes reliquia de plata\"(RelicConfig.Arg2)\""
  },
  Event_7114_ChoiceDesc2 = {
    Text = "[Dejarlo]obtener 25 el sigilo negro"
  },
  Event_7114_Desc = {
    Text = "En la esquina de un montón de heno en descomposición, entre las grietas de una d-marca, yacía silenciosamente algún objeto"
  },
  Event_7114_Name = {
    Text = "detrás del montón de heno"
  },
  Event_7115_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7115_Desc = {
    Text = "Esa figura no se acercó más, después de mirarte por un momento, se convirtió en un puñado de arena plateada"
  },
  Event_7115_Name = {
    Text = "Usador de llave de plata"
  },
  Event_7116_ChoiceDesc1 = {
    Text = "[Tomar tentáculo]Aceptar ayuda de Tulu"
  },
  Event_7116_Desc = {
    Text = "Después de un suspiro, Tulu te alcanzó.\nSus tentáculos pesados y fríos te atraparon, apagando tu temeraria idea de atacar solo al enemigo.\n\"Seré tu apoyo, solo por ahora.\""
  },
  Event_7116_Name = {
    Text = "La Promesa del Agente"
  },
  Event_7117_ChoiceDesc1 = {
    Text = "[Obtén llave]"
  },
  Event_7117_Desc = {
    Text = "1,2,3...\nLa distancia entre Jenkins y el escritorio es de 10 pies.\nEs una distancia muy corta, pero también larga como su vida.\nElla recuerda la suave cinta, recuerda el papel de caramelo dorado, y también las lágrimas de su madre.\nPensó en muchas, muchas cosas...\nSu frágil cuerpo atravesó el río negro, acercándose poco a poco al escritorio.\nLa llave está en el cajón, y el precio para obtenerla es muy simple: coraje, destreza, y un poco de suerte.\nAparte de suerte, Jenkins no le falta nada."
  },
  Event_7117_Name = {
    Text = "Llave Final"
  },
  Event_7118_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7118_Desc = {
    Text = "Solo una apuesta, no perderás.\nUna moneda grabada fue lanzada al aire y cayó rápidamente, calentándose en tu palma"
  },
  Event_7118_Name = {
    Text = "Jugador famoso"
  },
  Event_7119_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7119_Desc = {
    Text = "Solo una apuesta, no perderás.\nUna moneda grabada fue lanzada al aire y cayó rápidamente, calentándose en tu palma"
  },
  Event_7119_Name = {
    Text = "Jugador famoso"
  },
  Event_7120_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7120_Desc = {
    Text = "Solo una apuesta, no perderás.\nUna moneda grabada fue lanzada al aire y cayó rápidamente, calentándose en tu palma"
  },
  Event_7120_Name = {
    Text = "Jugador famoso"
  },
  Event_7121_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7121_Desc = {
    Text = "No tienes intención de unirte a esta seria clase de piano. \n Cada vez que terminan un compás, los estudiantes giran la cabeza con esfuerzo, haciendo un gesto de escucha. \n Y su maestro también se inclina un poco, sus labios se mueven, y sus ojos redondos miran una partitura que no existe. \n Ellos claramente no saben lo que están haciendo, y nunca comprenderán por qué los humanos pasan años haciendo este ejercicio mecánico. \n Simplemente están imitando."
  },
  Event_7121_Name = {
    Text = "Clases de piano"
  },
  Event_7122_ChoiceDesc1 = {
    Text = "[Insertar llave de plata]"
  },
  Event_7122_Desc = {
    Text = "En la d-baba sobresaturada parece haber ciertas sustancias... observa con la llave de plata, transfórmalo en tu propia fuerza"
  },
  Event_7122_Name = {
    Text = "Punto de extracción"
  },
  Event_7123_ChoiceDesc1 = {
    Text = "[identificar la letra]obtén la reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_7123_ChoiceDesc2 = {
    Text = "[tararear suavemente]obtén 1 de 3 sigilos"
  },
  Event_7123_Desc = {
    Text = "Un antiguo canto de barco resuena en el dominio.\nLos recuerdos atrapados en el dominio cantan en un idioma que nunca has oído, sobre las olas, el cielo y el licor"
  },
  Event_7123_Name = {
    Text = "Canción del mar"
  },
  Event_7124_ChoiceDesc1 = {
    Text = "[llamar cuervos] obtiene 20 el sigilo negro， infección\"(Skill.Arg2)\""
  },
  Event_7124_ChoiceDesc2 = {
    Text = "[Alejarse mucho]"
  },
  Event_7124_Desc = {
    Text = "Las aves negras te miran fijamente, y después de un rato, algo cae de sus plumas"
  },
  Event_7124_Name = {
    Text = "Cornejo Solitario"
  },
  Event_7125_ChoiceDesc1 = {
    Text = "[acércate y agarra]obtén 25 el sigilo negro"
  },
  Event_7125_ChoiceDesc2 = {
    Text = "[respuesta amistosa] 50% de probabilidad de obtener 50 el sigilo negro, 50% de no obtener nada"
  },
  Event_7125_Desc = {
    Text = "Un gato, cuya procedencia es desconocida, se sienta entre las d-babas; su figura borrosa indica que debería ser un habitante de la dimensión espiritual.\nEsta proyección, cuyo rostro es incierto, observa a Ramona con una mirada sabia, levantando su pata blanca como si le hiciera señas"
  },
  Event_7125_Name = {
    Text = "Residentes Nómadas"
  },
  Event_7126_ChoiceDesc1 = {
    Text = "[Correr al Norte]"
  },
  Event_7126_ChoiceDesc2 = {
    Text = "[Ignorar sonido]"
  },
  Event_7126_Desc = {
    Text = "Los ataques del enemigo caían como lluvia, las cuchillas rozaban tu capa, asustando a las gaviotas en el muelle.\n\"Hacia el norte... o al barco...\"\nIncluso el más tonto se daría cuenta de que alguna fuerza te estaba ayudando en secreto"
  },
  Event_7126_Name = {
    Text = "Hacia el norte"
  },
  Event_7127_ChoiceDesc1 = {
    Text = "[Escuchar el sol]gana reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_7127_ChoiceDesc2 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7127_Desc = {
    Text = "En la intersección de lo real y lo ilusorio, los cuerpos celestes giran eternamente en sus órbitas predeterminadas. \n Incontables encuentros fugaces han compuesto una y otra vez extrañas y engañosas melodías..."
  },
  Event_7127_Name = {
    Text = "Sonido de las estrellas y la luna"
  },
  Event_7128_ChoiceDesc1 = {
    Text = "[Dejar ir con tristeza]duplicar la carta, si se copia una carta de síntoma, obtiene 75 el sigilo negro"
  },
  Event_7128_ChoiceDesc2 = {
    Text = "[Partir con ira] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_7128_Desc = {
    Text = "Un líquido brota de la pupila, helado y arrollador, llevándose parte del alma"
  },
  Event_7128_Name = {
    Text = "Lágrimas del Pantano de las Almas"
  },
  Event_7129_ChoiceDesc1 = {
    Text = "[Adentrarse en el pasillo]"
  },
  Event_7129_ChoiceDesc2 = {
    Text = "[Ir en dirección opuesta]gana 25 el sigilo negro"
  },
  Event_7129_Desc = {
    Text = "La pálida luna ignoraba el paso del tiempo, vertiéndose sobre el silencioso pasillo. \nLa puerta brillaba extrañamente bajo su luz"
  },
  Event_7129_Name = {
    Text = "Galería silenciosa"
  },
  Event_7130_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7130_Desc = {
    Text = [[
Decidiste arreglar esta escultura de cera. 
Alrededor de la escultura hay algunas herramientas esparcidas, y eliges un tinte llamado "azul de Prusia". 
Es tan azul como una enfermedad]]
  },
  Event_7130_Name = {
    Text = "Estatua de cera inacabada"
  },
  Event_7131_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7131_Desc = {
    Text = "La pústula emitió un grito agudo y escalofriante, seguido de un silbido de viento que no debería existir, un sonido de flauta ilusoria y el sonido prohibido del pus surgiendo. \n La pústula se retorció extrañamente por un momento, luego se quedó rígida y en un silencio mortal. Al presenciar esta escena, el Despertado a tu lado parecía haber sido llamado por alguna fuerza."
  },
  Event_7131_Name = {
    Text = "Pústula extraña"
  },
  Event_7132_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7132_Desc = {
    Text = "Tus dedos tocan la estatua, sintiendo una inesperada suavidad en las hendiduras, siempre pensaste que era una ilusión"
  },
  Event_7132_Name = {
    Text = "ensamblar restos"
  },
  Event_7133_ChoiceDesc1 = {
    Text = "[Llorar por ella]"
  },
  Event_7133_ChoiceDesc2 = {
    Text = "[Rezar a Ella]"
  },
  Event_7133_Desc = {
    Text = "En el momento en que su cuerpo tocó el borde del barco, recuerdos que no le pertenecían inundaron su mente. \n La gente le puso un vestido blanco sagrado, adornándola con joyas delicadas y elegantes, y la colocaron en un alto altar, mientras los residentes del pueblo se arrodillaban y se postraban a sus pies. \n Eran ojos llenos de esperanza: los marineros deseaban que ella pudiera proteger su navegación, los pescadores esperaban una temporada de pesca sin viento ni olas, y muchos más residentes del pueblo deseaban un año de prosperidad. \n Entre la multitud de adoradores, estaban sus amigos de la infancia, así como sus padres y hermanos con quienes convivía a diario. \n Ella no quería nada, no sabía lo que deseaba. \n Responder pasivamente a los deseos parecía ser su única responsabilidad en la vida."
  },
  Event_7133_Name = {
    Text = "Ceremonia prevuelo"
  },
  Event_7134_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7134_Desc = {
    Text = "Ese cuerpo mutilado, con sus ojos pálidos, giró lentamente para mirarte mientras te alejabas, mostrando una sonrisa desolada"
  },
  Event_7134_Name = {
    Text = "ensamblar restos"
  },
  Event_7135_ChoiceDesc1 = {
    Text = "[enfrentarlo proactivamente]obtén reliquia maldita\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_7135_ChoiceDesc2 = {
    Text = "[Abandonar la resistencia] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_7135_ChoiceDesc3 = {
    Text = "[salir corriendo]obtén 50 el sigilo negro"
  },
  Event_7135_Desc = {
    Text = "Unos cuantos esculturas de cera bloquean tu camino.\nSon torcidas, con características rústicas, no parecen tener la calidad que debería tener Rogers.\n\"Orden... la orden del maestro...\""
  },
  Event_7135_Name = {Text = "Borrador"},
  Event_7136_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7136_Desc = {
    Text = "Eliges mirar valientemente a los ojos. \n Son estrellas brillantes que brillan en la oscuridad. \n Luego se ríen y se convierten en innumerables lunas en forma de arco. \n \"No temes las miradas. Tampoco deberías temer... \n Hace mucho que no te veo, @2\" \n Antes de desaparecer, te ofrecen un pequeño regalo como \"recuerdo del reencuentro\"."
  },
  Event_7136_Name = {Text = "ojo"},
  Event_7137_ChoiceDesc1 = {
    Text = "[Abrir el interruptor]Ampliar la vista actual[ExDesc1]"
  },
  Event_7137_Desc = {
    Text = "Dispositivo de iluminación dejado por los antepasados, puede dispersar la niebla negra alrededor.\nLa niebla a su alrededor fluctúa rítmicamente, como si su respiración la perturbara"
  },
  Event_7137_Name = {Text = "proyector"},
  Event_7138_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7138_Desc = {
    Text = "Tus alas transparentes se despliegan en tu espalda, girando y girando, sumergiéndose en el fondo del mar junto con los cuervos"
  },
  Event_7138_Name = {
    Text = "Voz del enjambre de cuervos"
  },
  Event_7139_ChoiceDesc1 = {
    Text = "[Destruirlo]obtener \"Corazón deformado\""
  },
  Event_7139_Desc = {
    Text = "Un bulto deformado y purulento abandonado al costado del camino, brillando con un resplandor verde sucio, se retorcía inquieto.\nMás que un monstruo, parecía un helado derritiéndose bajo el sol, pronto se convertiría en un charco de agua sucia y desaparecería en el aire"
  },
  Event_7139_Name = {
    Text = "Pústula extraña"
  },
  Event_7140_ChoiceDesc1 = {
    Text = "[Baja las manos de tus oídos]Infectar\"(Skill.Arg1)\"，elige una recompensa"
  },
  Event_7140_ChoiceDesc2 = {
    Text = "[Atrapar un cuervo]Obtener\"(Skill.Arg1)\"，Elegir una recompensa"
  },
  Event_7140_ChoiceDesc3 = {
    Text = "[Cerrar los ojos]obtiene 50 el sigilo negro"
  },
  Event_7140_Desc = {
    Text = "Grito, un grito interminable——\nLa Cantante cuervo, con su pelaje negro brillante, un brillo frío y duro en su pico afilado, su lamento resonante perfora una y otra vez tu tímpano. \n¡Deja tus manos en tus oídos!\nLa bandada de cuervos que canta a placer en la noche desea beber de tu cuerpo encogido, ese estremecimiento no refinado. \n"
  },
  Event_7140_Name = {
    Text = "Canto de los Cuervos"
  },
  Event_7141_ChoiceDesc1 = {
    Text = "[Salir]no hay descubrimientos"
  },
  Event_7141_Desc = {
    Text = "No soy la persona que buscas"
  },
  Event_7141_Name = {
    Text = "2_6 temporal"
  },
  Event_7142_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7142_Desc = {
    Text = "Tú eliges seguir adelante.\nComparado con el daño mental y físico causado por ese horrible arte de cera, estas pequeñas molestias no son nada.\nTienes una misión más grande que cumplir"
  },
  Event_7142_Name = {Text = "pasos"},
  Event_7143_ChoiceDesc1 = {
    Text = "[Señalar el problema]elige 1 de 3 cartas de comando y obtienes sello:\"(EnchantConfig.Arg1)\""
  },
  Event_7143_Desc = {
    Text = "\"¡¿Qué?! ¿Te gusta tanto hurgar en las heridas de los demás?\"\n\"¡Sí! ¡Ahora tengo 25 años más de repente! ¡Ahora debes llamarme hermana Murphy!\""
  },
  Event_7143_Name = {
    Text = "Vida Encadenada"
  },
  Event_7144_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de reliquia de plata, infecta\"(Skill.Arg1)\""
  },
  Event_7144_Desc = {
    Text = "El rostro de la chica es tan sereno como la luz de la luna, no te responde, pero levanta su brújula con manos temblorosas, como si le costara la vida"
  },
  Event_7144_Name = {
    Text = "niña de vestido blanco"
  },
  Event_7145_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7145_Desc = {
    Text = "\"¡Delicioso! ¡Delicioso!\" el cuervo se ríe, el hedor a podredumbre se esparce por tu nariz con el batir de sus alas"
  },
  Event_7145_Name = {
    Text = "Cuervo Maldito"
  },
  Event_7146_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7146_Desc = {
    Text = "A mi parecer, el ruido es sin duda el modelo de la nueva generación. \n Avanzan por el mundo con pasos firmes al ritmo caótico y las melodías desgarradoras. \n Sin compasión, sin dudar, y sin compromisos. \n Desprecian el orden, desestiman los temas, el ruido nunca complace a los demás— \n por supuesto, esto incluye a nuestro escultor de cera."
  },
  Event_7146_Name = {Text = "mal gusto"},
  Event_7147_ChoiceDesc1 = {Text = "[Guía]"},
  Event_7147_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7147_Desc = {
    Text = "Alguien tira suavemente de tu ropa.\nEs el chico que viste antes. Está en un rincón, mirándote con tristeza.\n\"Quiero participar en la obra de la academia.\nPero no encuentro el camino al escenario.\""
  },
  Event_7147_Name = {
    Text = "Ceremonia final II"
  },
  Event_7148_ChoiceDesc1 = {
    Text = "[Seguir Buscando]Aumentar Arg1 de vida, infectar\"(Skill.Arg2)\""
  },
  Event_7148_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7148_Desc = {
    Text = "Hueles un aroma familiar, hogareño y satisfactorio. Cuando intentas oler más el aroma del comedor, desaparece por completo"
  },
  Event_7148_Name = {
    Text = "Contacto Anómalo"
  },
  Event_7149_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7149_Desc = {
    Text = "Son colores cálidos.\nIntensos, suaves, amorosos.\nLe dieron a la niña un abrazo nostálgico y desaparecieron como el viento"
  },
  Event_7149_Name = {
    Text = "Colores nostálgicos"
  },
  Event_7150_ChoiceDesc1 = {
    Text = "[¿Quién eres realmente?]"
  },
  Event_7150_ChoiceDesc2 = {
    Text = "[¿Cómo cambiar de enfoque?]"
  },
  Event_7150_Desc = {
    Text = "El hombre de cabello largo se interpuso nuevamente en su camino. Tras la experiencia anterior, Ramona lucía molesta. \n\"Tranquilo, amigo mío.\"El hombre comenzó a hablar lentamente, su voz era magnética y seductora, como si el aire fluyera a través de una estrecha vía respiratoria, mezclándose con un sonido de fricción sibilante. \n\"He estado observando durante un tiempo, cambiar de mentalidad es lo que te acercará a tu objetivo.\""
  },
  Event_7150_Name = {
    Text = "Compañero extraño III"
  },
  Event_7151_ChoiceDesc1 = {
    Text = "[estoy buscando]Aumenta en Arg1 puntos la salud máxima"
  },
  Event_7151_ChoiceDesc2 = {
    Text = "[Estoy evadiendo] Elige 1 Tarjeta de comando entre 3 para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7151_Desc = {
    Text = "\"Veo a alguien buscando, buscando lo inalcanzable, lo triste y opuesto, lo que llaman verdad.\nVeo a alguien evitando, evitando lo inevitable, lo oculto y cruel, lo que llaman verdad.\n¿Quién eres tú?\""
  },
  Event_7151_Name = {
    Text = "Objeto de persecución"
  },
  Event_7152_ChoiceDesc1 = {
    Text = "[examinar detenidamente]actualiza 1 reliquia de plata a reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_7152_ChoiceDesc2 = {
    Text = "[intentar escuchar]Obtén una reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\"y\"(Skill.Arg3)\""
  },
  Event_7152_ChoiceDesc3 = {
    Text = "[Cuidado con cuidarlo] obtiene 25 el sigilo negro"
  },
  Event_7152_Desc = {
    Text = "La niebla adelante se ilumina con algo pequeño, parece un fragmento de vidrio o cristal, con colores brillantes y apagados fluyendo dentro"
  },
  Event_7152_Name = {
    Text = "Nuestros Recuerdos"
  },
  Event_7153_ChoiceDesc1 = {
    Text = "[Aceptar el desafío]Gana reliquia de plata si ganas, y gana síntomas si pierdes. Sin importar el resultado, no afecta la investigación posterior"
  },
  Event_7153_ChoiceDesc2 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7153_Desc = {
    Text = "¿Quién es la persona en el reflejo?\nRespira al mismo ritmo que tú, comparte el mismo latido, y tiene las mismas ideas extrañas.\n¿Es una broma del dominio secreto o una sombra de otra dimensión?\n¿Es una invitación a un desafío ilusorio?"
  },
  Event_7153_Name = {
    Text = "Resonancia de almas"
  },
  Event_7154_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7154_Desc = {
    Text = "La vista trascendió la historia y el tiempo, tal vez no sea lineal, tal vez te observe desde el caos antes del nacimiento del planeta.\nO tal vez, te espere en algún día futuro"
  },
  Event_7154_Name = {
    Text = "Mirar furtivamente"
  },
  Event_7155_ChoiceDesc1 = {
    Text = "[Reclamar]Obtén 50 sigilos negros"
  },
  Event_7155_Desc = {
    Text = "Allí no hay nada, el líquido negro fluye por el suelo, sin reflejar nada.\n¿Es tu imaginación? Sientes que algo se desliza entre tus dedos"
  },
  Event_7155_Name = {
    Text = "Bajo la superficie del espejo"
  },
  Event_7156_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7156_Desc = {
    Text = "\"Eres una persona generosa, te deseo lo mejor hoy, mañana y siempre.\"\n\"Por cierto, esto es una venta única...\"\nEl hada chasquea los labios con satisfacción y se despide de ti con nostalgia"
  },
  Event_7156_Name = {
    Text = "Bendición de la Hada"
  },
  Event_7157_ChoiceDesc1 = {
    Text = "[¡Devuélveme la billetera!]obtienes sello de 3 opciones"
  },
  Event_7157_ChoiceDesc2 = {
    Text = "[Dudar] 1 Tarjeta de comando aleatoria obtiene Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7157_Desc = {
    Text = "\"¡Vamos, ven a recuperar tu billetera!\" Un niño a lo lejos agita su mano. \n Corres hacia adelante, y en el momento en que extiendes la mano, un gran y caótico ruido resuena en tu mente. \n \"¿De dónde salió este niño sucio?\" \n \"¡Es un ratón de la calle, cómo se atreve a tocar la falda de la duquesa!\" \n \"¡Sáquenlo de aquí!\" \n \"¿Trajiste monedas? ¡Sin monedas, ni siquiera podrás llevarte un pan negro!\""
  },
  Event_7157_Name = {
    Text = "Libro del Nada"
  },
  Event_7158_ChoiceDesc1 = {
    Text = "[Buscar la canción]elija 1 carta de comando de entre 3 para obtener plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7158_ChoiceDesc2 = {
    Text = "[Cantar junto]contagiar\"(Skill.Arg1)\"，re-imprimir, máximo 2 veces"
  },
  Event_7158_Desc = {
    Text = "La lejana canción se descompone en polvo de estrellas: \n\"Maldigo el charco de agua sucia en el callejón nocturno, donde flores marchitas adornan la base de las paredes en ruinas, las cadenas se aferran a mi mente y caen en el lodazal, antes de que la densa niebla borre mi existencia, el crepúsculo se hundirá en el más profundo @2.\""
  },
  Event_7158_Name = {
    Text = "Maldición de la materia blanca"
  },
  Event_7159_ChoiceDesc1 = {
    Text = "[Dejar el Mantenimiento] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7159_ChoiceDesc2 = {
    Text = "[Llevárselo] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7159_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7159_Desc = {
    Text = "Cuando te acercaste, almas caóticas aparecieron súbitamente del pantano.\nLos brazos negros te rodearon fuertemente, llorando y suplicando——\nofréceme ofrendas, o llévame contigo"
  },
  Event_7159_Name = {
    Text = "Espíritu del Caos"
  },
  Event_7160_ChoiceDesc1 = {
    Text = "[Dejar ofrendas]Aumenta aleatoriamente la calidad del sello de 1 carta"
  },
  Event_7160_ChoiceDesc2 = {
    Text = "[Llevárselo] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7160_Desc = {
    Text = "Cuando te acercaste, almas caóticas aparecieron súbitamente del pantano.\nLos brazos negros te rodearon fuertemente, llorando y suplicando——\nofréceme ofrendas, o llévame contigo"
  },
  Event_7160_Name = {
    Text = "Espíritu del Caos"
  },
  Event_7161_ChoiceDesc1 = {
    Text = "[Agitar la mano para ahuyentar] 1 Tarjeta de comando aleatoria obtiene Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7161_ChoiceDesc2 = {
    Text = "[dejar que permanezca]elige 1 de 3 cartas de comando, obtén plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7161_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7161_Desc = {
    Text = "Las alas de la mariposa arrastran un líquido negro, volando de un lado a otro, el líquido se solidifica y se desmorona con el viento.\nCansada, se posa en tu nariz"
  },
  Event_7161_Name = {
    Text = "Mariposa de Líquido Negro"
  },
  Event_7162_ChoiceDesc1 = {
    Text = "[Agitar la mano para ahuyentar] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7162_ChoiceDesc2 = {
    Text = "[dejar que permanezca]obtén reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_7162_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7162_Desc = {
    Text = "Las alas de la mariposa arrastran un líquido negro, volando de un lado a otro, el líquido se solidifica y se desmorona con el viento.\nCansada, se posa en tu nariz"
  },
  Event_7162_Name = {
    Text = "Mariposa de Líquido Negro"
  },
  Event_7163_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7163_Desc = {
    Text = "\"Veo coraje, voluntad, un espíritu brillante como las estrellas. Avanza hacia esa memoria sellada con cera, y lograrás tu objetivo.\""
  },
  Event_7163_Name = {
    Text = "Objeto de persecución"
  },
  Event_7164_ChoiceDesc1 = {
    Text = "[Dejar que se quede] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7164_ChoiceDesc2 = {
    Text = "[Aclarar]Recibe reliquia de plata\"(RelicConfig.Arg1)\"、infectar\"(Skill.Arg2)\""
  },
  Event_7164_ChoiceDesc3 = {
    Text = "[recibir a la mariposa]obtén 25 el sigilo negro"
  },
  Event_7164_Desc = {
    Text = "Ustedes deambulan por el sanatorio azotado por el frío, cuando una mariposa negra que no debería existir en esta temporada llega revoloteando. \nLas alas de la mariposa arrastran un líquido negro, volando de un lado a otro, el líquido se solidifica y se desmorona con el viento. \nCansada, se posa en la punta de tus dedos."
  },
  Event_7164_Name = {
    Text = "Algo que no debería existir"
  },
  Event_7165_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de reliquia de plata, infecta\"(Skill.Arg1)\""
  },
  Event_7165_Desc = {
    Text = "Empiezas a sentirte cansado.\nTu conciencia te lleva, más allá del estanque, más allá de las montañas,\nvolando más allá del sol, más allá de los años luz,\nhacia esa única... cuna del universo"
  },
  Event_7165_Name = {
    Text = "Ceremonia final IV"
  },
  Event_7166_ChoiceDesc1 = {
    Text = "[Buscar de nuevo]"
  },
  Event_7166_Desc = {
    Text = "Una enorme sombra te cubrió por completo, y la saliva fétida te empapó.\n\"Ratita, ven aquí. Solo un momento...\"\n\"Te juro que no quiero comerte...\"\n\"No miraré tu jugoso vientre ni un segundo más!\""
  },
  Event_7166_Name = {
    Text = "Materiales No. 12"
  },
  Event_7167_ChoiceDesc1 = {
    Text = "[Buscar de nuevo]"
  },
  Event_7167_Desc = {
    Text = "El filósofo de cera marchito fumaba, envuelto en una nube blanca.\n\"El otro lado existe pero es incognoscible, por lo tanto, no se puede conocer.\"\n\"Imagina este mundo como un juego...\nLo que buscas podría estar al otro lado del mapa.\""
  },
  Event_7167_Name = {
    Text = "Materiales No. 45"
  },
  Event_7168_ChoiceDesc1 = {
    Text = "[Buscar de nuevo]"
  },
  Event_7168_Desc = {
    Text = "\"Lo siento, no era mi intención...\"\n\"No me gustan las ratas. El problema de las ratas es que nunca temen a los humanos...\"\nUn anciano desaliñado yace en la esquina, con ojos melancólicos fijos en ti. \n\"Por supuesto, ustedes son muy ambiciosos. \nEso está bien, pero no es suficiente para ayudarles a escapar de la catástrofe...\""
  },
  Event_7168_Name = {Text = "Material 4"},
  Event_7169_ChoiceDesc1 = {
    Text = "[Mostrar la Maldición] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7169_ChoiceDesc2 = {
    Text = "[Rechazar al cuervo]obtienes sello de 3 opciones"
  },
  Event_7169_ChoiceDesc3 = {Text = "[Ignorar]"},
  Event_7169_Desc = {
    Text = "Un cuervo negro y mórbido de múltiples cabezas salió volando de la capa negra de un creyente de la luz del templo y se posó en tu hombro. \n\"¿Ves mi cabeza? Si tan solo saboreas la maldición, haré crecer una nueva cabeza. ¡Déjame ver tu maldición!\""
  },
  Event_7169_Name = {
    Text = "Cuervo Maldito"
  },
  Event_7170_ChoiceDesc1 = {
    Text = "[Responder llamada]Eliminar 1 carta de comando y recuperar Arg1 vida"
  },
  Event_7170_ChoiceDesc2 = {
    Text = "[no estoy huyendo]Obtén una reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_7170_Desc = {
    Text = "Corres rápidamente por el callejón. La adrenalina se dispara, se genera ácido láctico, se consume glucosa... el caos corroe tu cerebro, ocupa tu mente, y en la colorida ilusión te apresura a huir hacia la meta. \n Sí, huyes. Si realmente no estás huyendo, entonces ¿por qué lo que te espera es el caos y el olvido, la nada y el final sin resultados?"
  },
  Event_7170_Name = {Text = "Correr"},
  Event_7171_ChoiceDesc1 = {
    Text = "[Rastrear el sonido]"
  },
  Event_7171_ChoiceDesc2 = {
    Text = "[Llamar a Lily y Kum]"
  },
  Event_7171_Desc = {
    Text = "En la lejanía del pasaje dimensional, se escucha un grave y áspero croar, mezclado con miedo, anhelo e inquietud, como si estuviera llamándolos. Luego, las voces de las chicas se desvanecen lentamente"
  },
  Event_7171_Name = {
    Text = "Voz de la guía"
  },
  Event_7172_ChoiceDesc1 = {Text = "[Guardar]"},
  Event_7172_Desc = {
    Text = "Una sustancia plateada, similar al mercurio, extraída de la disolución, contiene un poderoso poder espiritual, utilizada principalmente para enlazar más despertadores en rituales"
  },
  Event_7172_Name = {
    Text = "Núcleo de plata"
  },
  Event_7173_ChoiceDesc1 = {
    Text = "[Pedir que se quite del camino]"
  },
  Event_7173_ChoiceDesc2 = {
    Text = "[Preguntar identidad]"
  },
  Event_7173_Desc = {
    Text = "Ustedes entran en un vagón oscuro, una sensación extraña surge en su corazón.\nEste vagón está vacío, los pasajeros ya han huido, y en el suelo yacen los restos del cuerpo de un monstruo, que se están desvaneciendo gradualmente.\nEn el centro del vagón, está ese hombre.\n\"Creo que en el mundo existe el destino, y es el destino el que nos ha hecho tomar el mismo metro.\""
  },
  Event_7173_Name = {
    Text = "Compañero extraño IV"
  },
  Event_7174_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7174_Desc = {
    Text = "\"Tus ojos son preciosos, como estrellas.\"\nCharlotte rió con alegría, su cabello desordenado caía suave. \n\"Debes ser muy popular en la escuela, también me gustas.\"\nAntes de irse, te dio un beso en la frente. \nSentiste un calor en tu cuerpo, como si algo se volviera diferente"
  },
  Event_7174_Name = {
    Text = "Sombra del Investigador"
  },
  Event_7175_ChoiceDesc1 = {
    Text = "[Leer]elija 1 carta de comando de entre 3 para obtener plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7175_ChoiceDesc2 = {
    Text = "[Guardar en maletín]Infectar\"(Skill.Arg1)\"，Obtener creación：\"(RelicConfig.Arg2)\""
  },
  Event_7175_Desc = {
    Text = "Una hoja de papel amarillento cae del manto de los creyentes de la luz del templo.\nEl papel está repleto de textos extraños con formas inusuales, algunos parecen jeroglíficos, otros se levantan de manera extraña, algunos están superpuestos, solo unas pocas palabras son apenas legibles"
  },
  Event_7175_Name = {
    Text = "Orden secreta · Parte superior"
  },
  Event_7176_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7176_Desc = {
    Text = "Tú dijiste: “¡Ay, Charlotte! ¡No!”\nEl cabello de Charlotte se retorcía furiosamente, estaba enojada.\n“¡Te lo demostraré! ¡Mira lo que puedo hacer!”"
  },
  Event_7176_Name = {
    Text = "Sombra del Investigador"
  },
  Event_7177_ChoiceDesc1 = {
    Text = "[infección\"(Skill.Arg1)\"，obtén una reliquia de plata\"(RelicConfig.Arg2)\"]"
  },
  Event_7177_ChoiceDesc2 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7177_Desc = {
    Text = "Evento 302 (en desarrollo), no es el efecto final"
  },
  Event_7177_Name = {
    Text = "Evento 302 (en desarrollo)"
  },
  Event_7178_ChoiceDesc1 = {
    Text = "[Recibir solicitud]Infectar\"(Skill.Arg1)\"、recibir reliquia de plata\"(RelicConfig.Arg2)\""
  },
  Event_7178_ChoiceDesc2 = {
    Text = "[Rechazar la petición]obtienes 25 el sigilo negro"
  },
  Event_7178_Desc = {
    Text = "La mandíbula cruje con un sonido que lleva un ritmo regular, y tu compañero entiende algo de criptografía. \n El texto descifrado es el siguiente: \n \"Hola, llámame Dr. @2. Yo solía ser un coleccionista, un naturalista... \n (Aquí hay una larga y tediosa introducción sobre mi carrera y títulos, se omite) \n En resumen, ¿puedes ayudarme a encontrar mi otra mitad? Es un pequeño maxilar superior. \n Si logras encontrarlo, mi tesoro personal se abrirá para ti.\""
  },
  Event_7178_Name = {Text = "Crujido"},
  Event_7179_ChoiceDesc1 = {
    Text = "[Invertir en cien colmillos]infección\"(Skill.Arg1)\"，obtienes reliquia de plata\"(RelicConfig.Arg2)\""
  },
  Event_7179_ChoiceDesc2 = {
    Text = "[Invertir en cinco pensh]obtienes 25 el sigilo negro"
  },
  Event_7179_Desc = {
    Text = "El monedero bordado se retuerce y abre una boca negra hacia ti.\nDesde que dejó a su rica dueña, ha estado hambriento durante décadas, ansioso por llenarse.\nMiras dentro del monedero, está vacío, solo hay una oscuridad profunda"
  },
  Event_7179_Name = {
    Text = "Billetera glotona"
  },
  Event_7180_ChoiceDesc1 = {
    Text = "[Decisión firme]Eliminar 1 carta de comando, recuperar Arg1 vida"
  },
  Event_7180_ChoiceDesc2 = {
    Text = "[Es el deseo de éxito]gana reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_7180_Desc = {
    Text = "\"Dos tipos obstinados, la Casa de pobres ya es muy peligrosa,\"de repente se oyó la voz de Doll a través del comunicador,\"¿cuál es su próximo paso, ayudarla a coser la cabeza?\"\n\"¡No es momento de hacer comentarios sarcásticos, Doll!\"\n\"Lo sé, lo puedo oír.\"dijo Doll,\"mantén la calma, ¿sabes cuál es la clave del éxito?\""
  },
  Event_7180_Name = {
    Text = "Regla de Logan"
  },
  Event_7181_ChoiceDesc1 = {
    Text = "[infección\"(Skill.Arg1)\"，obtén una reliquia de plata\"(RelicConfig.Arg2)\"]"
  },
  Event_7181_ChoiceDesc2 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7181_Desc = {
    Text = "Evento 304 (en desarrollo), no es el efecto final"
  },
  Event_7181_Name = {
    Text = "Evento 304 (en desarrollo)"
  },
  Event_7182_ChoiceDesc1 = {
    Text = "[infección\"(Skill.Arg1)\"，obtén una reliquia de plata\"(RelicConfig.Arg2)\"]"
  },
  Event_7182_ChoiceDesc2 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7182_Desc = {
    Text = "Evento 305 (en desarrollo), no es el efecto final"
  },
  Event_7182_Name = {
    Text = "Evento 305 (en desarrollo)"
  },
  Event_7183_ChoiceDesc1 = {
    Text = "[Dejar el auricular]obtener 3 opciones de oración avanzada"
  },
  Event_7183_ChoiceDesc2 = {
    Text = "[Atender la llamada]Recibe reliquia de oro\"(RelicConfig.Arg1)\"、infectar\"(Skill.Arg2)\""
  },
  Event_7183_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7183_Desc = {
    Text = "Ustedes pasan por la sala de descanso del conductor del tren, y en un rincón oculto, suena el teléfono con un timbre agudo"
  },
  Event_7183_Name = {
    Text = "Llamada del tren"
  },
  Event_7184_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7184_Desc = {
    Text = "La luz brilla tenue, pero existe realmente.  \nTan tenue que la tecnología de ficha de plata es difícil de invocar, pero es excelente para fortalecer: eso es la tecnología de ficha de plata"
  },
  Event_7184_Name = {
    Text = "Prueba de existencia"
  },
  Event_7185_ChoiceDesc1 = {
    Text = "[Retrato de dama] mejora aleatoriamente la calidad del sello de 1 carta"
  },
  Event_7185_ChoiceDesc2 = {
    Text = "[Foto familiar de estatuas de cera] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7185_Desc = {
    Text = "El museo de cera también alberga muchas pinturas.\nRetratos, paisajes, naturalezas muertas, realistas, abstractas...\nAdornan las paredes, evitando que se vean aburridas.\nUna de ellas capta tu atención, es un"
  },
  Event_7185_Name = {
    Text = "Galería de retratos"
  },
  Event_7186_ChoiceDesc1 = {
    Text = "[Continuar hojeando]gana aleatoriamente 1 carta de comando y recibe plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7186_ChoiceDesc2 = {
    Text = "[Salir]aumenta Arg1 puntos de salud máxima, infecta\"(Skill.Arg2)\""
  },
  Event_7186_Desc = {
    Text = "Una balanza para pesar.\nDetrás de ella, numerosos órganos sumergidos en formalina roja.\nApilados ordenadamente en estantes.\nTomas un cuaderno cercano y lees:\n\"Corazón: 8 onzas, cerebro: 50 onzas...\""
  },
  Event_7186_Name = {
    Text = "Registro de órganos"
  },
  Event_7187_ChoiceDesc1 = {
    Text = "[Abrir el regalo]obtienes carta especial"
  },
  Event_7187_Desc = {
    Text = "La sombra del niño pasó volando ante ti; no puedes distinguir si realmente es un niño o la proyección de algún espíritu en el dominio. Pero—mirando la caja que quedó en el suelo, está escrita \"regalo\" en un frágil trazado de letras"
  },
  Event_7187_Name = {
    Text = "Regalo Amable"
  },
  Event_7188_ChoiceDesc1 = {
    Text = "[llamar cuervos] obtiene 40 el sigilo negro， infección\"(Skill.Arg2)\"， continúa eligiendo"
  },
  Event_7188_ChoiceDesc2 = {
    Text = "[Alejarse]obtiene 25 el sigilo negro"
  },
  Event_7188_Desc = {
    Text = "Una gaviota blanca se posa en el mástil, cubierto de escarcha.\nLas bocinas resuenan juntas, rechazando la presencia negra, y también al pájaro negro que no pertenece al océano"
  },
  Event_7188_Name = {
    Text = "Cornejo Solitario"
  },
  Event_7189_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7189_Desc = {
    Text = "Reconociste que la canción era una versión de una balada de amor.\nAl final de esa balada, el poeta dice:\n\"Hasta que la voz humana nos despierte, nos ahogaremos.\"\nNo ahora, piensas.\nAún esperas que la humanidad te despierte"
  },
  Event_7189_Name = {
    Text = "Voz del enjambre de cuervos"
  },
  Event_7190_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7190_Desc = {
    Text = "Un rollo de película cubierto de polvo. Pero no hay proyector en esta habitación, y no es momento de disfrutar de la mansión, la película y el té de la tarde.\nQuizás mucho después, puedas saber lo que contiene la película"
  },
  Event_7190_Name = {
    Text = "Recuerdos luminosos"
  },
  Event_7191_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de oración avanzada, infecta\"(Skill.Arg1)\""
  },
  Event_7191_Desc = {
    Text = "Sigues al niño, ni muy cerca ni muy lejos. \nToc. Toc. Toc... El niño se detiene en la esquina.\nVes una tenue luz roja detrás de él, tu intuición te dice que el museo de cera está cerca. \nEl niño se da la vuelta. No tiene ojos, solo cuencas negras. \nTe sonríe"
  },
  Event_7191_Name = {
    Text = "Ceremonia final I"
  },
  Event_7192_ChoiceDesc1 = {
    Text = "[Salir]obtiene 50 sigilos negros, infecta\"(Skill.Arg1)\""
  },
  Event_7192_Desc = {
    Text = "Le diste una palmada en el hombro. \n El niño se dio la vuelta, no tenía ojos, solo cuencas negras. \n \"Buenas noches. Estoy buscando el camino al museo de cera.\" \n El niño señaló hacia adelante. Viste una tenue luz roja e inestable detrás de él. \n Tu intuición te dice que el museo de cera está allí. \n Al volver en ti, el niño ya se había ido, dejando solo la sombra alargada de la farola."
  },
  Event_7192_Name = {
    Text = "Ceremonia final I"
  },
  Event_7193_ChoiceDesc1 = {
    Text = "[Sujetar al cuervo]obtener 35 el sigilo negro，infectar\"(Skill.Arg2)\"，continuar eligiendo"
  },
  Event_7193_ChoiceDesc2 = {
    Text = "[Dejarlo estar]Salir"
  },
  Event_7193_Desc = {
    Text = "El cuervo solitario arrancaba sus plumas negras una por una con su voz ronca.\nTemblaba de dolor, gritaba agudamente, pero no podía detener sus movimientos cada vez más rápidos.\n\"¡Caw—Caw—\"\nLágrimas azules mezcladas con tinta negra fluían de sus ojos, y nadie más que tú lo veía"
  },
  Event_7193_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7194_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7194_Desc = {
    Text = "Conocimiento invaluable inunda tu mente, luego se convierte en niebla... Cuando recuperas la conciencia, el extraño libro de cubierta amarilla ha desaparecido"
  },
  Event_7194_Name = {
    Text = "Pergamino amarillo"
  },
  Event_7195_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7195_Desc = {
    Text = "Derrotaste fácilmente a estas estatuas de cera. Están inclinadas hacia adelante, caídas a tus pies. \nParece que la base de las estatuas de cera tiene unas líneas escritas. \n\"Desbordamiento año @2, mes 11 \nHecho por Rogers en @2 Academia\" \nRecuerdas que Rogers estudió escultura en una cierta academia de arte, así que estas torpes estatuas de cera deben ser sus borradores de aquel entonces."
  },
  Event_7195_Name = {Text = "Borrador"},
  Event_7196_ChoiceDesc1 = {
    Text = "[¿Por qué?]"
  },
  Event_7196_ChoiceDesc2 = {
    Text = "[Caer al Abismo]"
  },
  Event_7196_Desc = {
    Text = "\"¡Falsificación! ¡Devuélveme a mi hijo!\"\n\"¿No eres la Santa de la Nave? ¿No es tu deber proteger los barcos? ¿Por qué solo ha regresado un barco? ¡Dímelo, dímelo!\"\n\"¡Ahóguenla! ¡Ella debe sufrir el mismo dolor que mi padre antes de morir!\"\n\"¡Ahóguenla, ahóguenla!\"\n\"¡Ahóguen a esta falsificación! ¡Átenla a la piedra!\"\nEl agua del mar inundaba su nariz y boca, el aire era expulsado de cada rincón de sus pulmones mientras ella llevaba ese hermoso vestido blanco. \nCasi como el primer pensamiento que tuvo tras convertirse en Santa, surgió desde el rincón más oscuro de su mente, llegando tarde. \n\"Sí, ¿por qué esos barcos se hundieron?\""
  },
  Event_7196_Name = {
    Text = "Hundirse en el mar"
  },
  Event_7197_ChoiceDesc1 = {
    Text = "[Sujetar al cuervo]obtener 30 el sigilo negro，infectar\"(Skill.Arg2)\"，continuar eligiendo"
  },
  Event_7197_ChoiceDesc2 = {
    Text = "[Dejarlo estar]Salir"
  },
  Event_7197_Desc = {
    Text = "El cuervo solitario arrancaba sus plumas negras una por una con su voz ronca.\nTemblaba de dolor, gritaba agudamente, pero no podía detener sus movimientos cada vez más rápidos.\n\"¡Caw—Caw—\"\nLágrimas azules mezcladas con tinta negra fluían de sus ojos, y nadie más que tú lo veía"
  },
  Event_7197_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7198_ChoiceDesc1 = {
    Text = "[Seguir Buscando]Aumentar Arg1 de vida, infectar\"(Skill.Arg2)\""
  },
  Event_7198_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7198_Desc = {
    Text = "Parece que unas manos se posaron en tus hombros, firmes y seguras, pero cuando te giraste para buscar, esa sensación se desvaneció"
  },
  Event_7198_Name = {
    Text = "Contacto Anómalo"
  },
  Event_7199_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7199_Desc = {
    Text = "El puente ferroviario de Rai, las venas y nervios de Londinium, conecta el corazón y extremidades de la ciudad. El Sanatorio Rai se encuentra en la punta de las extremidades, esperando en silencio la llegada de sangre y señales."
  },
  Event_7199_Name = {
    Text = "Ilusión Ferroviaria"
  },
  Event_7200_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7200_Desc = {
    Text = "Pones la maleta en el suelo y la pisas con fuerza, asegurándote de que no vibre antes de recogerla de nuevo.\nSacudes el polvo y, bajo la mirada confusa de Murphy, continúan avanzando"
  },
  Event_7200_Name = {
    Text = "Carta inesperada"
  },
  Event_7201_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7201_Desc = {
    Text = "El peligro te acecha tras una puerta de madera, no es momento de perder tiempo. Guárdalo en tu maletín"
  },
  Event_7201_Name = {
    Text = "Pergamino amarillo"
  },
  Event_7202_ChoiceDesc1 = {
    Text = "[Ahuyentar cuervos]Obtén Arg1 sigilos negros, contagia\"(Skill.Arg2)\"，continúa eligiendo"
  },
  Event_7202_ChoiceDesc2 = {
    Text = "[Ignorar]Salir"
  },
  Event_7202_Desc = {
    Text = "Ello, o ellos, giran en el dormitorio, golpeando la pantalla de la lámpara"
  },
  Event_7202_Name = {
    Text = "Lanterne Corbeau"
  },
  Event_7203_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7203_Desc = {
    Text = "Este es el plano espiritual, el mundo del conocimiento.\nAparte de confundir tu mente, no pueden hacer nada más"
  },
  Event_7203_Name = {
    Text = "Tormenta de Conocimiento"
  },
  Event_7204_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7204_Desc = {
    Text = "Cráneo: Hank Tillinghast A.F.186-A.F.203 Isla Creole\nColumna vertebral: Andy Crawford A.F.177-A.F.203 Narragansett\n...mejor no pensar demasiado"
  },
  Event_7204_Name = {Text = "Placa"},
  Event_7205_ChoiceDesc1 = {
    Text = "[Revisar fragmentos]gana aleatoriamente 3 cartas de comando de la baraja, elige 1 carta para eliminar, gana 75 el sigilo negro"
  },
  Event_7205_ChoiceDesc2 = {
    Text = "[preguntar a la muñeca]roba aleatoriamente 3 cartas de comando del mazo, selecciona 1 carta para copiar a su forma original y obtén 25 el sigilo negro"
  },
  Event_7205_ChoiceDesc3 = {
    Text = "[Ignorar]obtener 50 el sigilo negro"
  },
  Event_7205_Desc = {
    Text = "El fragmento metálico que te dio Doal se mueve inquieto sobre tu pecho, como una mariposa asustada"
  },
  Event_7205_Name = {
    Text = "Broche Inquieto"
  },
  Event_7206_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7206_Desc = {
    Text = "\"Él espera en el final, sin importar dónde lo pongas—mira a esa joven administradora, su evasión finalmente llevó a la locura.\""
  },
  Event_7206_Name = {
    Text = "Objeto de persecución"
  },
  Event_7207_ChoiceDesc1 = {
    Text = "[Salir]no hay descubrimientos"
  },
  Event_7207_Desc = {
    Text = "En desarrollo, evento especial"
  },
  Event_7207_Name = {
    Text = "2_16 temporal"
  },
  Event_7208_ChoiceDesc1 = {
    Text = "[Consolarlo] aumenta Arg1 puntos de vida máxima"
  },
  Event_7208_ChoiceDesc2 = {
    Text = "[Ignorarlo] 2 Tarjetas de comando aleatorias obtienen Inscripción: \"(EnchantConfig.Arg1)\", infectar 2 \"(Skill.Arg2)\""
  },
  Event_7208_Desc = {
    Text = "El enlace calienta el órgano aún humano de su corazón.\nImita el ritmo de respiración del enlace, latiendo como si así no fuera a ser dejado atrás, como si tuviera el derecho de caminar eternamente junto al enlace"
  },
  Event_7208_Name = {
    Text = "Atrio izquierdo"
  },
  Event_7209_ChoiceDesc1 = {
    Text = "Impresión avanzada aleatoria"
  },
  Event_7210_ChoiceDesc1 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7210_Desc = {
    Text = "Tu frialdad decepciona al dueño de la voz, el agua se ondula levemente y luego se calma"
  },
  Event_7210_Name = {
    Text = "Voces del más allá"
  },
  Event_7211_ChoiceDesc1 = {
    Text = "[Seleccionar 1 carta para obtener plegaria:\"(EnchantConfig.Arg1)\"]prueba de plegaria"
  },
  Event_7211_ChoiceDesc2 = {
    Text = "[Seleccionar 1 carta para obtener plegaria:\"(EnchantConfig.Arg1)\"]prueba de paquete de caídas"
  },
  Event_7211_Desc = {
    Text = "Prueba de la marca designada"
  },
  Event_7211_Name = {
    Text = "Prueba de la marca designada 1"
  },
  Event_7212_ChoiceDesc1 = {
    Text = "[Salir]Despertar 1 Despertado"
  },
  Event_7212_Desc = {
    Text = "Acaricias la cabeza del niño, guiándolo a recitar contigo.\n\"Canción para mamá—\"\nLa voz flota como una polilla en la noche, saliendo del escenario vacío,\nCayendo suavemente en la audiencia oscura"
  },
  Event_7212_Name = {
    Text = "Ceremonia final III"
  },
  Event_7213_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de reliquia de oro, infecta\"(Skill.Arg1)\""
  },
  Event_7213_Desc = {
    Text = "No muestras ninguna emoción. Una dama de repente sube al escenario. \nAbre la boca del niño con locura y empuja un palo dentro. \n\"Habla, háblame.\" \nSangre negra fluye de la boca del niño. Murmura confusamente. \n\"Una canción para mamá...\""
  },
  Event_7213_Name = {
    Text = "Ceremonia final III"
  },
  Event_7215_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7215_Desc = {
    Text = "Eso no es una ventana, es un espejo. Refleja la cara tensa de Ramona.\n¿Por qué no hay ventanas en esta habitación, solo un gran espejo en la pared?"
  },
  Event_7215_Name = {
    Text = "Reflejo en la ventana"
  },
  Event_7216_ChoiceDesc1 = {
    Text = "[Tomar llave de plata]Despertar aleatoriamente a 1 entidad, Infectar\"(Skill.Arg1)\""
  },
  Event_7216_ChoiceDesc2 = {
    Text = "[Cerrar los ojos]elija 1 carta de comando de entre 3 para obtener plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7216_Desc = {
    Text = "Te ves desgarrado por una absurda y enorme fuerza, tus extremidades se retuercen mientras te arrastras por el suelo, como si estuvieras siendo manipulado por @2 de más allá de la dimensión. \n\"No... no...\"\nTu cordura se desmorona poco a poco, risas maníacas y gritos confusos se entrelazan, como una gran red que atrapa tu conciencia, y solo brotan de tus labios gemidos ininteligibles."
  },
  Event_7216_Name = {
    Text = "Ojo de contemplación"
  },
  Event_7217_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7217_Desc = {
    Text = "El color del río estelar cambia, dibujando patrones indescriptibles bajo tus pies, hermosos como rubíes, pero hinchados como medusas. La maleta emite un resplandor rojo"
  },
  Event_7217_Name = {
    Text = "Cruce de Estrellas"
  },
  Event_7218_ChoiceDesc1 = {
    Text = "[Dispersar la ilusión]Estrés +10"
  },
  Event_7218_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7218_Desc = {
    Text = "Rostros borrosos aparecen de repente, rodeándote y gimiendo desesperadamente con cuerdas vocales inexistentes"
  },
  Event_7218_Name = {Text = "Ilusión"},
  Event_7221_ChoiceDesc1 = {
    Text = "[Atrapar]Recibe reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_7221_ChoiceDesc2 = {
    Text = "[Mirar hacia abajo]obtener 75 el sigilo negro，infectar\"(Skill.Arg2)\""
  },
  Event_7221_Desc = {
    Text = "Los cuervos giran en el cielo cortado en bloques por el callejón, emitiendo un sonido sordo que inquieta el ánimo. \n La bandada de cuervos de repente se alborota, como si alguna naturaleza patológica hubiera sido distorsionada o despertada, atacándose y persiguiéndose mutuamente de manera impaciente y feroz, algo cae en medio de la pelea."
  },
  Event_7221_Name = {
    Text = "Enjambre de cuervos enardecidos"
  },
  Event_7222_ChoiceDesc1 = {
    Text = "[Seguir instrucciones]Aumenta Arg1 de vida"
  },
  Event_7222_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7222_Desc = {
    Text = "Intentaste usar el poder de retroceso de la llave de plata para buscar el punto de enlace más cercano, pero la información que recibiste contenía anormalidades difíciles de detectar, parecía estar interferida"
  },
  Event_7222_Name = {
    Text = "Contacto Anómalo"
  },
  Event_7223_ChoiceDesc1 = {
    Text = "[dejarlo a muñeca]elige aleatoriamente 1 carta de comando, obtén plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7223_ChoiceDesc2 = {
    Text = "[Leer la placa]aumenta Arg1 puntos de salud máxima, contagiar\"(Skill.Arg2)\""
  },
  Event_7223_Desc = {
    Text = "De la entidad experimental del los escultores que derrotaste, cayó una placa de metal con un marco. La llave de plata detecta la placa y brilla suavemente"
  },
  Event_7223_Name = {Text = "Placa"},
  Event_7224_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7224_Desc = {
    Text = "El portador de la espada emite un aullido, como si fuera un estruendo capaz de cortar montañas y mares.\nEl sonido se desvanece en un instante, junto con otros dos marineros que desaparecen... Resulta ser solo una ilusión reflejada en el dominio"
  },
  Event_7224_Name = {
    Text = "Perseguir incansablemente"
  },
  Event_7225_ChoiceDesc1 = {
    Text = "[Reparar escultura de cera]elegir una carta y reducir su consumo de aritmética en 1"
  },
  Event_7225_Desc = {
    Text = "Con una vela en la mano, atraviesas la niebla y te acercas a ella.\nEs una estatua de cera inacabada.\nSu rostro hermoso está dividido en dos, una mitad sonríe, la otra @1.\nConviértete en su dios.\nDale belleza, dale lágrimas.\nEscúlpela o destrúyela"
  },
  Event_7225_Name = {
    Text = "Estatua de cera inacabada"
  },
  Event_7226_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7226_Desc = {
    Text = "\"Claro, he presenciado la muerte con mis propios ojos.\"respondiste.\nSí, fue solo la muerte violenta de un ratón, la putrefacción de un corazón, y el funeral de un lirio sumergido en la noche"
  },
  Event_7226_Name = {
    Text = "Reino Olvidado de los Dioses"
  },
  Event_7227_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7227_Desc = {
    Text = "\"Reino de dios... desaparición... el tema etéreo de la nada... no sé, qué significa realmente la desaparición.\"\nDos figuras se ríen suavemente, esparciendo fragmentos de luz blanca a su alrededor. \n\"En este momento, serás testigo de una verdadera desaparición.\""
  },
  Event_7227_Name = {
    Text = "Reino Olvidado de los Dioses"
  },
  Event_7228_ChoiceDesc1 = {
    Text = "[Pegar el papel]obtienes reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_7228_ChoiceDesc2 = {
    Text = "[Leer]elija 1 carta de comando de entre 3 para obtener plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7228_ChoiceDesc3 = {
    Text = "[desecharlo]obtén 50 el sigilo negro"
  },
  Event_7228_Desc = {
    Text = "Una hoja de papel amarillento cae del manto de los Portadores de linternas. \n El papel está repleto de textos extraños, algunos parecen jeroglíficos, otros se levantan de manera extraña, algunos están superpuestos, solo unas pocas palabras son apenas legibles. \n El título es «@2 El nacimiento del Hijo Santo»"
  },
  Event_7228_Name = {
    Text = "Orden secreta · Parte inferior"
  },
  Event_7229_ChoiceDesc1 = {
    Text = "[Luchar]Recibe reliquia de plata\"(RelicConfig.Arg1)\"、infectar\"(Skill.Arg2)\""
  },
  Event_7229_ChoiceDesc2 = {
    Text = "[Hundirse]gana reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_7229_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7229_Desc = {
    Text = "\"Estoy sufriendo, sufriendo tanto...»\n«¿Por qué yo, por qué tengo que pasar por esto?»\n«Padre misericordioso, ¿qué hice mal?»\nTristeza, dolor, ira, resentimiento... las emociones de los 'pacientes' pesaban sobre ti, te agarrabas el pecho, incapaz de respirar"
  },
  Event_7229_Name = {Text = "Adicción"},
  Event_7230_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7230_Desc = {
    Text = "La vista atravesó la carne, dejando una marca en la retina del pionero.\nNadie puede escapar, al igual que nadie @2"
  },
  Event_7230_Name = {
    Text = "Mirar furtivamente"
  },
  Event_7231_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7231_Desc = {
    Text = "Concéntrate, reconoce la letra, y luego siente el impacto de las palabras desordenadas en tu mente.\nNo son palabras que los humanos puedan entender"
  },
  Event_7231_Name = {
    Text = "Canción del mar"
  },
  Event_7232_ChoiceDesc1 = {
    Text = "[Realizar la prueba]contagiar\"(Skill.Arg1)\"，victoria obtiene reliquia de oro, derrota obtiene 50 el sigilo negro"
  },
  Event_7232_ChoiceDesc2 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7232_Desc = {
    Text = "Has visto algunos secretos en ese charco de lodo negro reflectante.\nSu reflejo es borroso, rodeado de una niebla negra persistente, te resulta extrañamente familiar, pero no puedes identificarlo"
  },
  Event_7232_Name = {
    Text = "Bajo la superficie del espejo"
  },
  Event_7233_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7233_Desc = {
    Text = "Despreciaste las cartas anónimas y las quemaste. Las cenizas volaron"
  },
  Event_7233_Name = {
    Text = "Otra carta de solicitud de ayuda"
  },
  Event_7234_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7234_Desc = {
    Text = "Revisas la carta, el sello está cubierto de un líquido pegajoso, parece una mezcla de sangre y brea, con algunos cabellos pegados"
  },
  Event_7234_Name = {
    Text = "Otra carta de solicitud de ayuda"
  },
  Event_7235_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7235_Desc = {
    Text = "Siguiendo la dirección de la carta caída, viste algo brillante en la esquina"
  },
  Event_7235_Name = {
    Text = "Otra carta de solicitud de ayuda"
  },
  Event_7236_ChoiceDesc1 = {
    Text = "[Seguir Buscando]Aumentar Arg1 de vida, infectar\"(Skill.Arg2)\""
  },
  Event_7236_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7236_Desc = {
    Text = "Una luz tenue aparece ante tus ojos, brillante y cálida, pero desaparece cuando intentas seguirla"
  },
  Event_7236_Name = {
    Text = "Contacto Anómalo"
  },
  Event_7237_ChoiceDesc1 = {
    Text = "[Salir]todos los cuerpos recuperan Arg1 locura"
  },
  Event_7237_Desc = {
    Text = "Cerraste los ojos con miedo.\n\"Levantaste la tela...\nEl secreto, descubriste el secreto...\"\nEl ruido se convirtió en un mar de estruendos, el suelo temblaba violentamente.\nNo pudiste soportarlo más y abriste los ojos de golpe, pero no había nada"
  },
  Event_7237_Name = {
    Text = "Ceremonia final V"
  },
  Event_7238_ChoiceDesc1 = {
    Text = "[Seguir Buscando]Aumentar Arg1 de vida, infectar\"(Skill.Arg2)\""
  },
  Event_7238_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7238_Desc = {
    Text = "Hueles un aroma familiar, hogareño y satisfactorio. Cuando intentas oler más el aroma del comedor, desaparece por completo"
  },
  Event_7238_Name = {
    Text = "Contacto Anómalo"
  },
  Event_7239_ChoiceDesc1 = {
    Text = "[Seguir Buscando]Aumentar Arg1 de vida, infectar\"(Skill.Arg2)\""
  },
  Event_7239_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7239_Desc = {
    Text = "Una voz familiar y reconfortante llegó a mis oídos, pero cuando intenté seguirla, se detuvo abruptamente"
  },
  Event_7239_Name = {
    Text = "Contacto Anómalo"
  },
  Event_7240_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7240_Desc = {
    Text = "El poder de la retrospección no podrá buscar un enlace para ti nuevamente en breve, pero al menos has obtenido un consuelo temporal"
  },
  Event_7240_Name = {
    Text = "Contacto Anómalo"
  },
  Event_7241_ChoiceDesc1 = {
    Text = "[Seguir Buscando]Aumentar Arg1 de vida, infectar\"(Skill.Arg2)\""
  },
  Event_7241_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7241_Desc = {
    Text = "Parece que unas manos se posaron en tus hombros, firmes y seguras, pero cuando te giraste para buscar, esa sensación se desvaneció"
  },
  Event_7241_Name = {
    Text = "Contacto Anómalo"
  },
  Event_7242_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7242_Desc = {
    Text = "'La sombra de \"N\" se dispersa por el viento del puño, las partículas negras se fusionan con la niebla del dominio, difícil de rastrear.\n\"No tiene sentido, un tipo interesante. Estoy ansioso por nuestro verdadero encuentro...\"'"
  },
  Event_7242_Name = {
    Text = "El espectáculo comienza"
  },
  Event_7243_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7243_Desc = {
    Text = "\"Buen chico. Pero aún necesitas un pequeño castigo.\"\nLa risa suave de Daffodil se desvanece en la grieta dimensional"
  },
  Event_7243_Name = {
    Text = "Tiempo de pista"
  },
  Event_7244_ChoiceDesc1 = {
    Text = "[Frente]50% de probabilidad de ganar reliquia de oro\"(RelicConfig.Arg2)\"，50% de probabilidad de infección\"(Skill.Arg3)\""
  },
  Event_7244_ChoiceDesc2 = {
    Text = "[opuesto] 50% de probabilidad de obtener 75 el sigilo negro, 50% de probabilidad de infección\"(Skill.Arg3)\""
  },
  Event_7244_ChoiceDesc3 = {
    Text = "[Fichas negras]50% de probabilidad de obtener una reliquia maldita\"(RelicConfig.Arg2)\"，50% de probabilidad de contagiar\"(Skill.Arg3)\""
  },
  Event_7244_Desc = {
    Text = [[
Muy bien... muy bien...
Entonces, elige tu ficha]]
  },
  Event_7244_Name = {
    Text = "El espectáculo comienza"
  },
  Event_7245_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7245_Desc = {
    Text = "\"Está bien, está bien. Ese tipo siempre se obsesiona con las criaturas que cruzan dimensiones, me costó mucho poder moverme libremente entre los agujeros de estas dimensiones. Ah, eso fue hace tres mil años.\""
  },
  Event_7245_Name = {
    Text = "Tiempo de pista"
  },
  Event_7246_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7246_Desc = {
    Text = "Confío en que el jefe de investigación no pondrá una bomba en tu pecho"
  },
  Event_7246_Name = {
    Text = "Broche Inquieto"
  },
  Event_7247_ChoiceDesc1 = {
    Text = "[Salir]elimina 1 carta de comando, obtiene 25 sigilos negros"
  },
  Event_7247_Desc = {
    Text = [[
"Es un buen samaritano, guiando a los perdidos," su sonrisa es maliciosa, "Viaja ligero, Cerbero te espera."
El dispositivo de mando en su mano vibra de repente]]
  },
  Event_7247_Name = {
    Text = "Compañero extraño III"
  },
  Event_7248_ChoiceDesc1 = {
    Text = "[moverse lentamente]Elige 1 de 3 cartas de comando para obtener un sello:\"(EnchantConfig.Arg1)\""
  },
  Event_7248_ChoiceDesc2 = {
    Text = "[Acostarse]elegir 1 de 3 cartas de comando y obtener oración：\"(EnchantConfig.Arg1)\""
  },
  Event_7248_Desc = {
    Text = "\"Cuando te encuentres con un pantano, no luches en absoluto.\"\nRecuerdas esta regla de supervivencia y te mantienes inmóvil como una estatua de Isla de Pascua. \nCinco minutos, diez minutos, una hora... finalmente, el lodo negro perdió la paciencia y desapareció de tus pies."
  },
  Event_7248_Name = {
    Text = "Marisma Oscura"
  },
  Event_7249_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7249_Desc = {
    Text = "Notaste una mano que se distinguía de las demás. Era delicada, pálida, y siempre se mostró tranquila.\nMás importante aún—lo reconociste, era tu propia mano.\nLa tomaste suavemente.\nEsa mano también tomó la tuya. Sentiste un frío punzante y vacío, y luego el pantano desapareció"
  },
  Event_7249_Name = {
    Text = "Marisma Oscura"
  },
  Event_7250_ChoiceDesc1 = {
    Text = "[Cortar una mano]elegir 1 de 3 cartas de comando y obtener plegaria：\"(EnchantConfig.Arg1)\""
  },
  Event_7250_ChoiceDesc2 = {
    Text = "[Consolarlos] elige 1 de 3 cartas de comando y obtiene el sello: «(EnchantConfig.Arg1)»"
  },
  Event_7250_Desc = {
    Text = "Agitas la espada, cortándolos uno a uno.\nLa sangre salpica tu cuerpo, pero no lo notas.\nLas manos gritan de dolor y el pantano desaparece.\nUna semana después, los gritos en tus pesadillas cesan"
  },
  Event_7250_Name = {
    Text = "Marisma Oscura"
  },
  Event_7251_ChoiceDesc1 = {
    Text = "[Recoger el núcleo de plata]actualizas 1 reliquia de plata a reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_7251_ChoiceDesc2 = {
    Text = "[Intentar despertar] obtiene reliquia de oro «(RelicConfig.Arg1)», infecta «(Skill.Arg2)» y «(Skill.Arg3)»"
  },
  Event_7251_ChoiceDesc3 = {
    Text = "[Ignorar]gana 25 el sigilo negro"
  },
  Event_7251_Desc = {
    Text = "Debajo de la tabla suelta del suelo, se filtra un lodo negro sucio.\nY en el lodo negro, el brillo es el \"núcleo de plata\" que conoces tan bien"
  },
  Event_7251_Name = {
    Text = "Prueba de existencia"
  },
  Event_7252_ChoiceDesc1 = {
    Text = "[Elegir el ratón]carta de comando aleatoria 1 obtiene plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7252_ChoiceDesc2 = {
    Text = "[Elegir vela]aumenta Arg1 puntos de salud máxima, contagiar\"(Skill.Arg2)\""
  },
  Event_7252_Desc = {
    Text = "El cuerpo disuelto se desvanece frente a ti, las cenizas frías y oscuras se fusionan con la niebla, formando una balanza extraña en el aire. Un lado de la balanza tiene un ratón dormido, y el otro una vela esculpida en forma de niño.\nEn el fondo, sabes que debes tomar una decisión"
  },
  Event_7252_Name = {
    Text = "Razón y Emoción"
  },
  Event_7253_ChoiceDesc1 = {
    Text = "[Sondeo Expresado]"
  },
  Event_7253_ChoiceDesc2 = {
    Text = "[Seguir en secreto]"
  },
  Event_7253_Desc = {
    Text = "Al girar una esquina, todo a tu alrededor se vuelve cada vez más borroso, solo los aterradores gritos siguen siendo claros. \n Se oyen pasos, te das la vuelta y vislumbras una figura extraña: parece una persona, pero detrás tiene sombras en pares, que a primera vista se asemejan a una enorme polilla. \n \"Cuidado,\" advierte Ramona en voz baja, \"en el Dominio, lo que ves no siempre es la verdad; si te sigues sin pensar, podría haber peligro.\""
  },
  Event_7253_Name = {
    Text = "Figura en la niebla"
  },
  Event_7254_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7254_Desc = {
    Text = "Sacas la llave de plata y la sostienes con devoción. Una luz tenue te envuelve.\nEn el silencio, solo queda un suspiro"
  },
  Event_7254_Name = {
    Text = "Ojo de contemplación"
  },
  Event_7255_ChoiceDesc1 = {
    Text = "[Elegir el río de plata]carta de comando aleatoria 1 obtiene plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7255_ChoiceDesc2 = {
    Text = "[Elegir el camino de arcoíris]aumenta Arg1 puntos de salud máxima, contagiar\"(Skill.Arg2)\""
  },
  Event_7255_Desc = {
    Text = "¡Pum! ¡Pum! ¡Pum!\nEl corazón late como un tambor, la boca seca y la lengua áspera, una mirada en el aire atraviesa tu pecho desde la columna vertebral.\nAnte ti aparece un camino bifurcado, uno con un río de estrellas fluyendo y otro brillando con iridiscencia."
  },
  Event_7255_Name = {
    Text = "Cruce de Estrellas"
  },
  Event_7256_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7256_Desc = {
    Text = "Las miradas que quedan aún te observan, las células de la carne bajo tu piel gritan locamente y huyen, los vasos sanguíneos se retuercen bajo la piel como insectos.\nSientes una corriente de poder fluyendo, estallando en las extrañas deformidades de tus extremidades"
  },
  Event_7256_Name = {
    Text = "Ojo de contemplación"
  },
  Event_7257_ChoiceDesc1 = {
    Text = "[Salir]infectar\"(Skill.Arg1)\""
  },
  Event_7257_ChoiceDesc2 = {
    Text = "[Salir]infectar\"(Skill.Arg1)\""
  },
  Event_7257_ChoiceDesc3 = {
    Text = "[Salir]infectar\"(Skill.Arg1)\""
  },
  Event_7257_Desc = {
    Text = "\"No, esto no es cierto. En comparación con las cucarachas, al menos ustedes tienen cuerpos peludos. \n Nadie puede rechazar un cuerpo peludo.\"\n Los ratones susurran entre ellos y finalmente acceden a tu punto de vista a regañadientes. \n\"No está tan mal... en realidad no tienen tanto pelo.\"\n Siempre es agradable recibir cumplidos. Antes de irse, los ratones te regalaron un pequeño obsequio."
  },
  Event_7257_Name = {Text = "Peste"},
  Event_7258_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7258_Desc = {
    Text = "\"¡Estoy de acuerdo! ¡Humanos y ratas no pueden coexistir!»\nLas ratas se enfurecieron, mostrando sus colmillos blancos.\n«¿Entonces qué haces aquí? Toma tus cosas y no vuelvas nunca.»"
  },
  Event_7258_Name = {Text = "Peste"},
  Event_7259_ChoiceDesc1 = {
    Text = "[Salir]obtener creación\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7259_Desc = {
    Text = "Un zumbido extraño de alas te rodea, por un instante ves a Rogers abrazando al juguete George en la camilla, con las manos llenas de sangre.\nAbres los ojos y encuentras a Clementine desaparecida.\nDespiertas para darte cuenta que Clementine ya se ha ido"
  },
  Event_7259_Name = {
    Text = "Terapia de hipnosis"
  },
  Event_7260_ChoiceDesc1 = {
    Text = "[Abrir]Usa la llave"
  },
  Event_7260_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7260_Desc = {
    Text = "Una puerta bloquea tu camino. Intentas de todo, pero no se mueve"
  },
  Event_7260_Name = {
    Text = "Puerta oxidada"
  },
  Event_7260_Tips1 = {
    Text = "Requiere obtener la \"Llave oxidada\""
  },
  Event_7261_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7261_Desc = {
    Text = "Miraste hacia la dirección que crees que es la fuente de la mirada. El techo del taller se hace repentinamente alto, y las imágenes de gigantescas pupilas se superponen, aunque solo una parte de ellas se encuentra contigo, aún sientes una gran presión"
  },
  Event_7261_Name = {
    Text = "Quién mira"
  },
  Event_7262_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7262_Desc = {
    Text = "El gato negro se acercó cautelosamente y vomitó una masa negra en tu mano"
  },
  Event_7262_Name = {
    Text = "Desgracia del gato nocturno"
  },
  Event_7263_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7263_Desc = {
    Text = "\"Sí, una elección inteligente. Ante un gran enemigo, querrás conocerlo bien, ¿verdad? Pero saber demasiado sobre los secretos de las dimensiones puede afectar tu mente.\"\n\"Ese tipo siempre se obsesiona con las criaturas que cruzan dimensiones, me costó mucho poder moverme libremente entre los agujeros de estas dimensiones. Ah, eso fue hace tres mil años.\""
  },
  Event_7263_Name = {
    Text = "Tiempo de pista"
  },
  Event_7264_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7264_Desc = {
    Text = "\"Miau, miau, miau miau...\"\nTe esfuerzas por sonar débil e inofensivo.\n\"¡Miau! ¡Miau miau! ¡Miau miau miau!\"\nEl grupo de gatos parece aceptar tu buena intención y responde con fuertes maullidos. Sus voces resuenan día y noche, asustando a la luna que se esconde tras las nubes"
  },
  Event_7264_Name = {
    Text = "Ciudad de los gatos"
  },
  Event_7265_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7265_Desc = {
    Text = "Con fuerza, retuviste el pico afilado del cuervo que intentaba picotear sus plumas, pero este insistió en torcerse, con tanta fuerza que incluso hizo crujir tus huesos. \n Te sonrojaste intensamente, usando todas tus fuerzas para controlar el cuerpo del cuervo y detener su furiosa autolesión. \n Justo cuando suspiraste aliviado, el cuello ya medio pelado del cuervo se retorció bruscamente hacia atrás, su cuerpo se aflojó y se convirtió en un charco de una espesa sustancia negra en tus manos."
  },
  Event_7265_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7266_ChoiceDesc1 = {
    Text = "[Sujetar al cuervo]obtener 20 el sigilo negro，infectar\"(Skill.Arg2)\""
  },
  Event_7266_ChoiceDesc2 = {
    Text = "[Dejarlo estar]Salir"
  },
  Event_7266_Desc = {
    Text = "El cuervo solitario arrancaba sus plumas negras una por una con su voz ronca.\nTemblaba de dolor, gritaba agudamente, pero no podía detener sus movimientos cada vez más rápidos.\n\"¡Caw—Caw—\"\nLágrimas azules mezcladas con tinta negra fluían de sus ojos, y nadie más que tú lo veía"
  },
  Event_7266_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7267_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7267_Desc = {
    Text = "Los cuervos se arrancaban las plumas, como los humanos se devoran a sí mismos.\nEn este mundo de miedo, esto es común. No puedes salvar a todos"
  },
  Event_7267_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7268_ChoiceDesc1 = {
    Text = "[Salir]obtener creación\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7268_Desc = {
    Text = "\"Volveré con los estudiantes.» dijo la chica, agarrando la falda del Despertado, «Cuídate... no te caigas al mar.»"
  },
  Event_7268_Name = {
    Text = "Bendición de la Santa Navegante"
  },
  Event_7269_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7269_Desc = {
    Text = "Ja, ja, negro, mi color favorito. Caos, desorden, dolor... ya deberías saberlo, el negro no es un buen augurio.\nEntonces, ¿cuál es tu próxima elección?"
  },
  Event_7269_Name = {
    Text = "El espectáculo comienza"
  },
  Event_7270_ChoiceDesc1 = {
    Text = "[Sujetar al cuervo]obtener 25 el sigilo negro，infectar\"(Skill.Arg2)\"，continuar eligiendo"
  },
  Event_7270_ChoiceDesc2 = {
    Text = "[Dejarlo estar]Salir"
  },
  Event_7270_Desc = {
    Text = "El cuervo solitario arrancaba sus plumas negras una por una con su voz ronca.\nTemblaba de dolor, gritaba agudamente, pero no podía detener sus movimientos cada vez más rápidos.\n\"¡Caw—Caw—\"\nLágrimas azules mezcladas con tinta negra fluían de sus ojos, y nadie más que tú lo veía"
  },
  Event_7270_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7271_ChoiceDesc1 = {
    Text = "[Salir]de 3 cartas de comando selecciona 1 para obtener oración:\"(EnchantConfig.Arg1)\""
  },
  Event_7271_Desc = {
    Text = "Es el interior de un camarote viejo, sin luz ni guía.\nLa chica partirá con la bendición de la Santa de la Nave, es su promesa"
  },
  Event_7271_Name = {
    Text = "Bendición de la Santa Navegante"
  },
  Event_7272_ChoiceDesc1 = {
    Text = "[Buscar la canción]elija 1 carta de comando de entre 3 para obtener plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7272_ChoiceDesc2 = {
    Text = "[Cantar junto]contagiar\"(Skill.Arg1)\"，imprimir aleatoriamente de nuevo"
  },
  Event_7272_Desc = {
    Text = "La lejana canción se descompone en polvo de estrellas: \n\"Maldigo el charco de agua sucia en el callejón nocturno, donde flores marchitas adornan la base de las paredes en ruinas, las cadenas se aferran a mi mente y caen en el lodazal, antes de que la densa niebla borre mi existencia, el crepúsculo se hundirá en el más profundo @3.\""
  },
  Event_7272_Name = {
    Text = "Maldición de la materia blanca"
  },
  Event_7273_ChoiceDesc1 = {
    Text = "[Buscar la canción]elija 1 carta de comando de entre 3 para obtener plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7273_Desc = {
    Text = "La lejana canción se descompone en polvo de estrellas: \n\"Maldigo el charco de agua sucia en el callejón nocturno, donde flores marchitas adornan la base de las paredes en ruinas, las cadenas se aferran a mi mente y caen en el lodazal, antes de que la densa niebla borre mi existencia, el crepúsculo se hundirá en el más profundo @4.\""
  },
  Event_7273_Name = {
    Text = "Maldición de la materia blanca"
  },
  Event_7274_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7274_Desc = {
    Text = "El núcleo de plata no responde a tu despertar, pero emite una cálida sensación"
  },
  Event_7274_Name = {
    Text = "Núcleo de plata solitario"
  },
  Event_7275_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7275_Desc = {
    Text = "La niebla negra envolvente subió por tu columna vertebral, y repetiste la misma frase hasta caer al suelo"
  },
  Event_7275_Name = {
    Text = "No mirar directamente"
  },
  Event_7276_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7276_Desc = {
    Text = "Sí, el líquido vítreo que fluye lentamente de tu pupilo es una prueba de que has sido corrompido por el tabú. \nLa honestidad, en este momento, va en contra de la virtud"
  },
  Event_7276_Name = {
    Text = "No mirar directamente"
  },
  Event_7277_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7277_Desc = {
    Text = "La moneda antigua está pegajosa, como si fuera el residuo vomitado por la suciedad, emitiendo un humo negro visible"
  },
  Event_7277_Name = {
    Text = "Moneda antigua de doble cara"
  },
  Event_7278_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7278_Desc = {
    Text = "Las terminaciones nerviosas te advierten de un peligro mortal, te estremeces y te detienes de golpe.\nOtra vez te has escapado... ¿Maldición? ¿O un renacimiento?"
  },
  Event_7278_Name = {
    Text = "Moneda antigua de doble cara"
  },
  Event_7279_ChoiceDesc1 = {
    Text = "[Liberar la Mariposa] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7279_ChoiceDesc2 = {
    Text = "[convertirse en mariposa]Obtén una reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_7279_ChoiceDesc3 = {
    Text = "[tragarse] obtiene 25 el sigilo negro"
  },
  Event_7279_Desc = {
    Text = "Esta noche han sucedido demasiadas cosas. \n ATQ al muelle, barco fantasma, Marchador de mares, Tulu, Murphy, Ramona... Todo gira en un vórtice, mezclándose como la avena de las siete de la mañana en el restaurante Misaq. \n Quiero hacerle una pregunta al Despertado frente a mí, pero no sé cómo comenzar, como un nudo en la garganta—o mejor dicho, las mariposas en el estómago."
  },
  Event_7279_Name = {
    Text = "Efecto mariposa"
  },
  Event_7280_ChoiceDesc1 = {
    Text = "[Dispersar la ilusión]Pierde (Arg3) puntos de vida"
  },
  Event_7280_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7280_Desc = {
    Text = "Rostros borrosos aparecen de repente, rodeándote y gimiendo desesperadamente con cuerdas vocales inexistentes"
  },
  Event_7280_Name = {Text = "Ilusión"},
  Event_7281_ChoiceDesc1 = {
    Text = "[unirse a la oración] obtiene reliquia de plata\"(RelicConfig.Arg1)\"， infección\"(Skill.Arg2)\""
  },
  Event_7281_ChoiceDesc2 = {
    Text = "[Sumergirse en el mar]gana reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\"，\"(Skill.Arg3)\""
  },
  Event_7281_ChoiceDesc3 = {
    Text = "[Surgir a la superficie]gana 25 el sigilo negro"
  },
  Event_7281_Desc = {
    Text = "\"Dios suave, Dios supremo. \n Por favor, calma la tempestad feroz, por favor, detén las aguas turbulentas. \n Haz que el océano se convierta en nuestro profundo hogar, que lo cubra un velo eterno para nuestra nación...\"\n El susurro del creyente finalmente se convirtió en palabras que puedes entender, pero lo que vino después fue una asfixia ineludible."
  },
  Event_7281_Name = {
    Text = "Plegaria del Sueño"
  },
  Event_7282_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7282_Desc = {
    Text = "Arrojaste los restos de carne a la multitud de gatos.\nLos gatos se abalanzaron como una marea negra, devorando la carne y dispersándose rápidamente.\nDesafortunadamente, era carne caducada. Llena el estómago, pero no es satisfactoria"
  },
  Event_7282_Name = {
    Text = "Ciudad de los gatos"
  },
  Event_7283_ChoiceDesc1 = {Text = "[Guardar]"},
  Event_7283_Desc = {
    Text = "Una sustancia plateada, similar al mercurio, extraída de la disolución, contiene un poderoso poder espiritual, utilizada principalmente para enlazar más despertadores en rituales"
  },
  Event_7283_Name = {
    Text = "Núcleo de plata"
  },
  Event_7284_ChoiceDesc1 = {
    Text = "[Salir]selecciona 1 despertador, y reduce su coste de consumo de carta de despertar en 2 puntos. Infección\"(Skill.Arg1)\""
  },
  Event_7284_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7284_Desc = {
    Text = "Quizás no puedan entenderlo ahora, pero eventualmente escucharán tu llamado"
  },
  Event_7284_Name = {
    Text = "Voz de la guía"
  },
  Event_7285_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7285_Desc = {
    Text = "Los experimentos errantes te han agotado, un breve respiro es como lluvia en un desierto seco"
  },
  Event_7285_Name = {
    Text = "Puerta sin fin"
  },
  Event_7286_ChoiceDesc1 = {
    Text = "[Salir]Despertar 1 Despertado al azar"
  },
  Event_7286_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7286_Desc = {
    Text = "Esa voz guiará su destino, la respuesta a esta investigación"
  },
  Event_7286_Name = {
    Text = "Voz de la guía"
  },
  Event_7287_ChoiceDesc1 = {
    Text = "[Observar cuidadosamente]"
  },
  Event_7287_Desc = {
    Text = "Puedes observar a distancia con la bola de cristal"
  },
  Event_7287_Name = {
    Text = "Bola de cristal"
  },
  Event_7288_ChoiceDesc1 = {
    Text = "[Ahuyentar cuervos]Obtén Arg1 sigilos negros, contagia\"(Skill.Arg2)\"，continúa eligiendo"
  },
  Event_7288_ChoiceDesc2 = {
    Text = "[Ignorar]Salir"
  },
  Event_7288_Desc = {
    Text = "Un cuervo se posó en el armario, su pico afilado tallando extraños patrones en la puerta de madera"
  },
  Event_7288_Name = {
    Text = "Lanterne Corbeau"
  },
  Event_7289_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7289_Desc = {
    Text = "Aceptas la llamada de la escuela, la voz familiar te tranquiliza. Te animas y sigues adelante"
  },
  Event_7289_Name = {
    Text = "Punto de contacto"
  },
  Event_7290_ChoiceDesc1 = {
    Text = "[Quedarse aquí]obtener reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_7290_ChoiceDesc2 = {
    Text = "[Buscar salida] obtiene reliquia de oro «(RelicConfig.Arg1)», infecta «(Skill.Arg2)»"
  },
  Event_7290_Desc = {
    Text = "Cruzas a un silencio pálido, las puertas superpuestas giran sin cesar, arrastrando tu cuerpo en un vórtice. \n Te esfuerzas por salir de las puertas invertidas, mareado, reconociendo vagamente la dirección de la fuga, pero inevitablemente caes una y otra vez en otra puerta. \n Esta vez, te detienes nuevamente frente a una puerta, lo desconocido que surge detrás de ella emana una atracción mortal, pero tu razón está al límite. \n Sí, ciertamente es mortal."
  },
  Event_7290_Name = {
    Text = "Más allá de las puertas dobles"
  },
  Event_7291_ChoiceDesc1 = {
    Text = "[Éxtasis]Elimina una carta de comando y recupera Arg1 puntos de vida"
  },
  Event_7291_ChoiceDesc2 = {
    Text = "[Detenerse]obtener reliquia de oro\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7291_Desc = {
    Text = "Como si te hubieran abierto el cráneo con facilidad, una náusea vertiginosa invade tu mente, una mano invisible revuelve y agita tu cerebro, convirtiendo la materia ya líquida en un charco. \n Es como si la materia intestinal en forma de papilla, aún no digerida, hubiera escapado de la gravedad y se hubiera vertido en tu corteza cerebral vacía y pobre. \n Se amasa, se mezcla, se manipula, se espolvorea con alegría triturada, y se incorpora en la carne los restos del ocaso."
  },
  Event_7291_Name = {
    Text = "Agitar el cerebro"
  },
  Event_7292_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7292_Desc = {
    Text = "Comparado con el súbito surgimiento del sabueso infernal, la nieve común no merece tu atención. Ignoras los copos de nieve que caen y te lanzas a la noche oscura"
  },
  Event_7292_Name = {Text = "Nieve"},
  Event_7293_ChoiceDesc1 = {
    Text = "[Conectar] recuperar Arg2 puntos de vida"
  },
  Event_7293_Desc = {
    Text = "Exploras en la niebla, de repente, el emblema en tu pecho emite un débil resplandor plateado. ¿Quién te llama desde el comunicador?"
  },
  Event_7293_Name = {
    Text = "Punto de contacto"
  },
  Event_7294_ChoiceDesc1 = {
    Text = "[sentir miedo]Obtén una reliquia de oro\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_7294_ChoiceDesc2 = {
    Text = "[Voluntad firme] elige 1 de 3 cartas de comando para obtener el sello: «(EnchantConfig.Arg1)»"
  },
  Event_7294_Desc = {
    Text = "Un lamento extraño resuena sin cesar, pero todo en Londinium permanece indiferente, como si ya hubiera muerto o estuviera dormido. \n De manera inconsciente, vagabundeas bajo el puente ferroviario, recordando las advertencias de Alistair. \n Él se levanta cortésmente y se acerca, parece que te está diciendo algo, pero sus palabras son confusas y pegajosas. \n Levantas la vista y gotas de un líquido negro y espeso brotan de su boca, bloqueando su garganta y obstruyendo sus frases——"
  },
  Event_7294_Name = {
    Text = "Grito del caos"
  },
  Event_7295_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de oración"
  },
  Event_7295_Desc = {
    Text = "\"Claro, por supuesto. Si no te importa, también te echaré una mano.\"\nTe entrega un espejo de mano antiguo.\n\"El caballero ya está en el tablero, y el rey no esperará mucho en el final. Probablemente lo verán pronto. Qué emocionante.\""
  },
  Event_7295_Name = {
    Text = "Compañero extraño IV"
  },
  Event_7296_ChoiceDesc1 = {
    Text = "[Destruir carta]Eliminar 2 cartas"
  },
  Event_7296_ChoiceDesc2 = {
    Text = "[Continuar leyendo]gana reliquia maldita\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_7296_ChoiceDesc3 = {
    Text = "[Salir]obtiene Arg1 sigilo negro"
  },
  Event_7296_Desc = {
    Text = "Delante de ti, un enjambre de mariposas negras brota, desbordándose, batiendo sus alas y cayendo continuamente sobre el escritorio. \n El papel de carta en blanco se salpica de tinta, las mariposas heridas yacen, exhaustas, sobre su superficie. \n La sustancia negra y viscosa que cubre sus alas se entrelaza, formando palabras prohibidas. \n Sacas este papel de la máquina de escribir."
  },
  Event_7296_Name = {
    Text = "Capítulo Mariposa"
  },
  Event_7297_ChoiceDesc1 = {
    Text = "[acoger a la mariposa]descarta 1 carta de comando, obtén Arg1 el sigilo negro"
  },
  Event_7297_ChoiceDesc2 = {
    Text = "[No quedarse más]"
  },
  Event_7297_Desc = {
    Text = "Últimamente, en Lentinién se dice: \"El aleteo de una mariposa en el Bosque de Akut puede causar una tormenta en el Reino de Leo.\"\nAl ver las mariposas brotar, recuerdas esta frase.\nEstas mariposas podrían desatar un desastre que inunde el planeta"
  },
  Event_7297_Name = {
    Text = "Tormenta de Conocimiento"
  },
  Event_7298_ChoiceDesc1 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7298_Desc = {
    Text = "Pusiste un dedo en la esquina de tus labios, señalando que guardarías silencio sobre este asunto.\nUna sombra de gato negro pasó velozmente, dejando un brillante regalo a tus pies"
  },
  Event_7298_Name = {
    Text = "Desgracia del gato nocturno"
  },
  Event_7299_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7299_Desc = {
    Text = "Se deslizó en tu bolso como una seda, y con el ligero aumento de peso, pareció que escuchaste un leve agradecimiento.\nDespués, no hubo más sonido"
  },
  Event_7299_Name = {
    Text = "Espíritu del Caos"
  },
  Event_7300_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7300_Desc = {
    Text = "El llanto del espíritu del Caos se vuelve más agudo, hasta convertirse en un grito ensordecedor que resuena a tu alrededor.\nCon tu ofrenda y su tristeza inescapable, se hunde de nuevo en el lodo"
  },
  Event_7300_Name = {
    Text = "Espíritu del Caos"
  },
  Event_7301_ChoiceDesc1 = {
    Text = "[Rellena con sinceridad]"
  },
  Event_7301_ChoiceDesc2 = {
    Text = "[Escribir sin sentido]"
  },
  Event_7301_Desc = {
    Text = "Las calles del Distrito Este son complicadas, y en poco tiempo has perdido de vista a los niños. \n Cuando te sientes perdido, una mujer misteriosa se acerca a ti. \n \"Sé a dónde fueron los niños, pero antes de decírtelo, ¿podrías ayudarme con un pequeño favor?\" \n Ella saca un papel y te sonríe amablemente. \n \"Me llamo Clementine, soy médica y estoy realizando una investigación psicológica sobre los residentes de Londinium. Si puedes ayudarme a llenar este cuestionario. \n Si lo completas con sinceridad, estaré encantada de ofrecerte y a tus compañeros algo de ayuda.\""
  },
  Event_7301_Name = {
    Text = "Evaluación psicológica"
  },
  Event_7302_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7302_Desc = {
    Text = "\"Esta también es mi elección.\"dijo la figura que sostenía los dulces,\"pero ella se convertirá en su ficha, y tendrás que elegir. \nNo existe un final perfecto en este mundo.\"\nUna profunda tristeza te sumerge. La figura se disipa, te sostienes el pecho, sin saber si lo que ocurrió hace un momento fue una proyección o una ilusión generada bajo la presión mental."
  },
  Event_7302_Name = {
    Text = "Sendero bifurcado"
  },
  Event_7303_ChoiceDesc1 = {
    Text = "[Hacha dorada]"
  },
  Event_7303_ChoiceDesc2 = {
    Text = "[Hacha plateada]"
  },
  Event_7303_ChoiceDesc3 = {
    Text = "[No he perdido nada]"
  },
  Event_7303_Desc = {
    Text = "\"Pionero que atraviesa dimensiones.\"\nUna voz anciana susurra en tu oído, como si viniera de tiempos prehistóricos, atravesando eras.\nEn medio de la tensión extrema, escuchas una pregunta familiar.\n\"¿Perdiste este hacha de oro o esta hacha de plata?\""
  },
  Event_7303_Name = {
    Text = "Voces del más allá"
  },
  Event_7304_ChoiceDesc1 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7304_Desc = {
    Text = "\"Vaya, esto...\" Ella guardó el cuestionario, con una expresión de resignación, \"Bueno, tienes prisa. Los niños fueron por allí, no deben estar lejos.\"\nTe diste la vuelta rápidamente, casi sin escuchar el susurro detrás de ti.\n\"De todos modos, nos volveremos a ver.\""
  },
  Event_7304_Name = {
    Text = "Evaluación psicológica"
  },
  Event_7305_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7305_Desc = {
    Text = "\"¿Quién eres?\"\n\"Soy la sombra del Usador de llave de plata asesinado, el asesino es una astuta serpiente albina.\"\n\"¿Serpiente albina? ¿Qué es eso?\"\n\"Un error. Un ser profano nacido de la mezcla entre humanos y serpientes...\"\n Quisiste seguir preguntando, pero la sombra se desvaneció de repente, dejando un rastro de polvo dorado."
  },
  Event_7305_Name = {
    Text = "Usador de llave de plata"
  },
  Event_7306_ChoiceDesc1 = {
    Text = "[infección\"(Skill.Arg1)\"，obtén una reliquia de oro\"(RelicConfig.Arg2)\"]"
  },
  Event_7306_ChoiceDesc2 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7306_Desc = {
    Text = "Evento 355 (en desarrollo), no es el efecto final"
  },
  Event_7306_Name = {
    Text = "Evento 355 (en desarrollo)"
  },
  Event_7307_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7307_Desc = {
    Text = "Baja al estómago, baila con las mariposas.\nEl polvo de pensamientos y las mariposas se entrelazan, nevando en el estómago.\nTodo se aclara, y cuando llegue la próxima oportunidad, hablarás"
  },
  Event_7307_Name = {
    Text = "Efecto mariposa"
  },
  Event_7308_ChoiceDesc1 = {
    Text = "[refutarles] infección\"(Skill.Arg1)\"， aleatoriamente 1 carta obtiene un efecto：\"(EnchantConfig.Arg2)\""
  },
  Event_7308_ChoiceDesc2 = {
    Text = "[Sigue su ejemplo]contagiar\"(Skill.Arg1)\"，carta aleatoria 1 obtiene plegaria:\"(EnchantConfig.Arg2)\""
  },
  Event_7308_ChoiceDesc3 = {
    Text = "[Proponer una nueva perspectiva]Elige 1 de 3 cartas de comando y gana plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7308_Desc = {
    Text = "\"Por favor, mantente alejado de nosotros.\"\nUn grupo de ratas te rodea en el centro, manteniendo al menos cinco pies de distancia de ti. \n\"Nos esforzamos por reproducirnos, crecemos fuertes, nunca somos exigentes — así que traemos enfermedades, ansiedad y sufrimiento a los humanos.\"\n\"No deberíamos estar demasiado cerca de los humanos, este no es un lugar para ti.\"\nPara hacer que las ratas bajen la guardia, decides —"
  },
  Event_7308_Name = {Text = "Peste"},
  Event_7309_ChoiceDesc1 = {
    Text = "[Abrir la puerta de hierro]infección\"(Skill.Arg1)\"，obtienes reliquia de oro\"(RelicConfig.Arg2)\""
  },
  Event_7309_ChoiceDesc2 = {
    Text = "[ignorar]obtén 50 el sigilo negro"
  },
  Event_7309_Desc = {
    Text = "Es un puente de arco inferior típico, las escaleras junto a la vía férrea conducen vagamente a una puerta de hierro. Detrás de la puerta se escucha un sonido rítmico y extraño.\nTe detienes a observar la puerta, ves un candado pesado, pero no está cerrado"
  },
  Event_7309_Name = {
    Text = "Tras la puerta de hierro"
  },
  Event_7310_ChoiceDesc1 = {
    Text = "[Salir]infecta\"(Skill.Arg1)\"，obtiene 50 sigilos negros"
  },
  Event_7310_Desc = {
    Text = "Resistiendo la tentación, permaneces inmóvil.\nEl dueño de la voz parece decepcionado, provocando unas pocas ondas en la superficie del agua, y luego todo se calma."
  },
  Event_7310_Name = {
    Text = "Voces del más allá"
  },
  Event_7311_ChoiceDesc1 = {
    Text = "[infección\"(Skill.Arg1)\"，obtén una reliquia de oro\"(RelicConfig.Arg2)\"]"
  },
  Event_7311_ChoiceDesc2 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7311_Desc = {
    Text = "Evento 353 (en desarrollo), no es el efecto final"
  },
  Event_7311_Name = {
    Text = "Evento 353 (en desarrollo)"
  },
  Event_7312_ChoiceDesc1 = {
    Text = "[Salir]infecta\"(Skill.Arg1)\"，obtiene 50 sigilos negros"
  },
  Event_7312_Desc = {
    Text = "\"¿No tienen otra respuesta, humanos?\"\nEl dueño de la voz gruñó con impaciencia, haciendo temblar todo el espacio.\n\"Codiciosos e ignorantes... por eso me cansan.\""
  },
  Event_7312_Name = {
    Text = "Voces del más allá"
  },
  Event_7313_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7313_Desc = {
    Text = "Acepta la disposición del dominio, pierde ganando, disfruta del abrazo maldito"
  },
  Event_7313_Name = {
    Text = "Délire éruptif"
  },
  Event_7314_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7314_Desc = {
    Text = "Los ojos parpadearon lentamente, sin saber si entendieron tu pregunta.\nUna lágrima de color dorado y rojo cayó del rincón de su ojo, como una pequeña estrella, emitiendo una luz cálida como la del sol. Cayó, cayó, llevando tristeza, llevando compasión, y se rompió en un pequeño trozo de polvo sobre la piedra.\nDe repente volviste en ti, y esos ojos ya no estaban."
  },
  Event_7314_Name = {
    Text = "Mirada ciega"
  },
  Event_7315_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7315_Desc = {
    Text = "Unos niños con ropa sencilla y sucia corrían por la calle, perseguidos por un adulto con uniforme de policía. Uno de los niños llevaba una capucha marrón que te resultaba familiar"
  },
  Event_7315_Name = {
    Text = "Nuestros Recuerdos"
  },
  Event_7316_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7316_Desc = {
    Text = "\"Deja de cantar—\"\nLe adviertes al desafinado cantante que no vuelva a torturar tus oídos"
  },
  Event_7316_Name = {
    Text = "Malhechor en el Camino Estrecho"
  },
  Event_7317_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7317_Desc = {
    Text = "\"¡Detén el paso! ¡Hasta una criatura de corrosión se conoce mejor!\"\nRuegas en tu corazón que libere a la audiencia"
  },
  Event_7317_Name = {
    Text = "Malhechor en el Camino Estrecho"
  },
  Event_7318_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7318_Desc = {
    Text = "El lodo negro goteó en tu cara, causando una sensación de picazón.\nNo pudiste soportarlo y apartaste la mariposa con la mano.\nLa mariposa esquivó tu movimiento y desapareció silenciosamente en la distancia"
  },
  Event_7318_Name = {
    Text = "Algo que no debería existir"
  },
  Event_7319_ChoiceDesc1 = {
    Text = "[elogiarlo]selecciona 1 de las 3 cartas de comando para obtener un sigilo:\"(EnchantConfig.Arg1)\""
  },
  Event_7319_Desc = {
    Text = "Jenkin dijo: ¡Despierta, Johnny! Escribir poesía no pagará tus deudas ni resolverá el problema de la filtración en el suelo de tu casa. \n Tú dijiste: Desafortunadamente, tus células que buscan la verdad se marchitarán a una velocidad de 100,000 al día, y pronto te convertirás en un verdadero tallo cerebral. \n El cerebro se encogió de hombros sin importarle —si es que tuviera. \n El cerebro dijo: Pienso, luego existo. Cuando logres alcanzar la profundidad de pensamiento que tengo, ya no te importará el tallo cerebral."
  },
  Event_7319_Name = {
    Text = "Cerebro filosófico"
  },
  Event_7320_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7320_Desc = {
    Text = "El piano emite suavemente un suspiro, como un consuelo, o tal vez con nostalgia, parecido a la sonrisa de alguien al final de una melodía.\n\"Mientras los niños... solo...\"\nNo tuviste tiempo para escuchar claramente, la ilusión del piano se disipa con el viento"
  },
  Event_7320_Name = {
    Text = "Melodía de la infancia"
  },
  Event_7321_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de reliquia de plata, infecta\"(Skill.Arg1)\""
  },
  Event_7321_Desc = {
    Text = "Tomas el grueso historial médico y lo abres, viendo las letras \"G·R\" en la primera página.\n\"¡Oh, no es tu historial?\" dice Clementine sin preocuparse, \"Estudiar la mente de otros también mejora el autoconocimiento.\"\nAntes de que puedas preguntar, ella desaparece"
  },
  Event_7321_Name = {
    Text = "libreta de historial clínico"
  },
  Event_7322_ChoiceDesc1 = {
    Text = "[Salir]Despertar 1 Despertado, infectar\"(Skill.Arg1)\""
  },
  Event_7322_Desc = {
    Text = "Tomas el delgado historial médico y lo abres, encontrando solo una hoja con una frase.\n\"En el caos eterno, el ojo pálido sin pupilas observa eternamente.\"\nQuieres preguntar a Clementine, pero ya no está"
  },
  Event_7322_Name = {
    Text = "libreta de historial clínico"
  },
  Event_7323_ChoiceDesc1 = {
    Text = "[Conectar] recuperar toda la vida"
  },
  Event_7323_ChoiceDesc2 = {
    Text = "[Meditación]Elige despertar a un Despertado"
  },
  Event_7323_Desc = {
    Text = "Exploras en la niebla, de repente, el emblema en tu pecho emite un débil resplandor plateado. ¿Quién te llama desde el comunicador?"
  },
  Event_7323_Name = {
    Text = "Punto de contacto"
  },
  Event_7324_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7324_Desc = {
    Text = "Pruebas importantes, mejor conservarlas y entregarlas al departamento de historia para su análisis"
  },
  Event_7324_Name = {
    Text = "Orden secreta · Parte superior"
  },
  Event_7325_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7325_Desc = {
    Text = "El sol brillante despierta a las almas cansadas"
  },
  Event_7325_Name = {
    Text = "Ángulo de elevación"
  },
  Event_7326_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7326_Desc = {
    Text = "Te sientes lleno, bajo la mirada de los dioses en el cielo nocturno, fijándote en ellos"
  },
  Event_7326_Name = {
    Text = "Ojo del domo"
  },
  Event_7327_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7327_Desc = {
    Text = "No puedes escapar de la mirada incómoda, y por supuesto, no puedes resistir los dones de los dioses"
  },
  Event_7327_Name = {
    Text = "Ojo del domo"
  },
  Event_7328_ChoiceDesc1 = {
    Text = "[Salir]obtener creación\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7328_Desc = {
    Text = "\"¿Quién eres realmente?\" preguntaste con horror. \n\"No hay necesidad de preocuparse por eso. El enemigo de mi enemigo es mi amigo, ¿no?\", sonrió el hombre. \n\"El regalo se quedó en la silla, les deseo buena suerte.\""
  },
  Event_7328_Name = {
    Text = "Compañero extraño IV"
  },
  Event_7329_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7329_Desc = {
    Text = "Ramona se acercó, esperando escuchar más sobre la \"bata blanca\". \"¡Alguien está escuchando!\" La voz del gramófono se hizo más fuerte, \"¡Escuchando, escuchando, escuchando!\""
  },
  Event_7329_Name = {
    Text = "El oído del otro"
  },
  Event_7330_ChoiceDesc1 = {
    Text = "[Salir]todos los cuerpos recuperan Arg1 locura"
  },
  Event_7330_Desc = {
    Text = "Tomas la mano suave del niño, atravesando puertas hasta llegar a un pequeño escenario destartalado.\nEl niño aprieta tu mano en señal de agradecimiento.\n\"Gracias, adiós.\""
  },
  Event_7330_Name = {
    Text = "Ceremonia final II"
  },
  Event_7331_ChoiceDesc1 = {
    Text = "[Continuar cayendo]gana reliquia de plata\"(RelicConfig.Arg1)\"，¿continuar cayendo?"
  },
  Event_7331_ChoiceDesc2 = {
    Text = "[Retirarse]obtienes 25 el sigilo negro"
  },
  Event_7331_Desc = {
    Text = "\"'Tú' te invita.\nEn las profundidades de la espiral, el 'Tú' del pasado y del futuro te ofrece 'regalos' de diferentes dimensiones.\""
  },
  Event_7331_Name = {
    Text = "Abismo espiral"
  },
  Event_7332_ChoiceDesc1 = {
    Text = "[Cerrarse a hablar] obtiene 25 el sigilo negro"
  },
  Event_7332_ChoiceDesc2 = {
    Text = "[Extender la mano]50% de probabilidad de obtener 50 el sigilo negro, 50% de probabilidad de no obtener nada"
  },
  Event_7332_Desc = {
    Text = "\"Solo tengo un proverbio que decir: ¡Nadie puede matar a un gato!\"\n\"Esa maldita gata negra debería haber sido desollada y dejada a la intemperie, pero excavó en la tumba de mi familia, devorando la carne humana en descomposición, mientras los huesos y miembros se esparcían por todas partes.\"\n\"Bajo la mirada fría y oscura de las pupilas verticales, un líquido amarillento y pútrido flotaba con un hedor insoportable, y escapé a rastras de allí, atormentado por pesadillas hasta perder la cordura.\"\n\"Espera... ¿qué van a hacer? ¡No estoy loco! ¡No lo estoy! ¡Ustedes deben estar encubriendo algo! ¡Esto es cierto!—\"\nEsto es realmente cierto. Al ver desaparecer la sombra del loco, intercambiaste una mirada con el gato negro que estaba sentado tranquilo a tus pies."
  },
  Event_7332_Name = {
    Text = "Desgracia del gato nocturno"
  },
  Event_7333_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7333_Desc = {
    Text = "Le preguntaste por la ubicación del museo de cera.\nQué extraño, esta es la quinta vez que se encuentran esta noche. Le has encendido cinco veces y preguntado cinco veces por el camino.\nPero aún no recuerdas la ubicación del museo, al igual que seguirás encontrándote con él"
  },
  Event_7333_Name = {
    Text = "La sombra bajo la farola"
  },
  Event_7334_ChoiceDesc1 = {
    Text = "[Ahuyentar cuervos]Obtén 25 sigilos negros, contagia\"(Skill.Arg2)\"，continúa eligiendo"
  },
  Event_7334_ChoiceDesc2 = {
    Text = "[Seguir Persiguiendo al Niño]Salir"
  },
  Event_7334_Desc = {
    Text = "El tercer cuervo se fue, volando hacia la oscuridad eterna"
  },
  Event_7334_Name = {
    Text = "Mirada de Cuervo Negro"
  },
  Event_7335_ChoiceDesc1 = {
    Text = "[Salir]obtiene 75 sigilos negros, infecta\"(Skill.Arg2)\""
  },
  Event_7335_Desc = {
    Text = "El pelaje en los tentáculos era suave y delicado, aún conservaba el calor de la vida de Kum.\nEra el último rayo de sol antes del atardecer, el calor residual que desaparece en un instante"
  },
  Event_7335_Name = {
    Text = "Residuo de calor"
  },
  Event_7336_ChoiceDesc1 = {
    Text = "[Perseguir]"
  },
  Event_7336_Desc = {
    Text = "Buscas en la pared y encuentras una entrada de alcantarilla oculta tras unos arbustos. Pasas por la alcantarilla, pero el monstruo ya se ha ido"
  },
  Event_7336_Name = {
    Text = "Calle sin salida"
  },
  Event_7337_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7337_Desc = {
    Text = "Las aves tienen sus propias reglas, no actúan según tu voluntad y no tienes derecho a interferir con la naturaleza"
  },
  Event_7337_Name = {
    Text = "Cornejo Solitario"
  },
  Event_7338_ChoiceDesc1 = {
    Text = "[Observar el reflejo]obtener 25 el sigilo negro"
  },
  Event_7338_ChoiceDesc2 = {
    Text = "[¿Estás bien?]obtener reliquia de plata\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7338_Desc = {
    Text = "\"¿Sabes...? La nueva dueña de al lado siempre está encerrada... El otro día la invité a una cerveza, y cuando la espuma desapareció, de repente me di cuenta... ¡Ella no tenía sombra en el vaso!\""
  },
  Event_7338_Name = {
    Text = "Fragmentos de memoria: Cerveza"
  },
  Event_7339_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7339_Desc = {
    Text = "\"Quiero cantar contigo otra vez...\"\nEl grito distorsionado de locura de Sarah se detuvo de repente, su rostro deformado revelando una pizca de confusión"
  },
  Event_7339_Name = {
    Text = "\"Hermana Sasha\""
  },
  Event_7340_ChoiceDesc1 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7340_Desc = {
    Text = "\"¡Qué feliz, qué feliz!\" Una voz ruidosa y aguda llena de inocencia suena en tu oído, \"¡Para ti, para ti!\""
  },
  Event_7340_Name = {
    Text = "Elfo de la noche"
  },
  Event_7341_ChoiceDesc1 = {
    Text = "[Historial Médico Voluminoso]"
  },
  Event_7341_ChoiceDesc2 = {
    Text = "[Historial médico delgado]"
  },
  Event_7341_Desc = {
    Text = "Una voz bastante familiar te detuvo, entrecerraste los ojos, pero no pudiste distinguir su figura. \n \"Sé que tienes prisa\", dijo la doctora Clementine con un tono alegre, \"te prometo que no te tomaré mucho tiempo.\" \n Dos manos emergieron a través de la niebla en tu mente, cada una sosteniendo un historial clínico, uno grueso y desgastado, y otro delgado y nuevo. \n \"Según los resultados de tu cuestionario, me tomé la libertad de hacerte un historial médico. Sin embargo, olvidé cuál es el tuyo, ¿por qué no eliges uno?\" \n No sabes por qué, pero el historial delgado emitía una sensación familiar, resonando débilmente con el vínculo espiritual entre tú y el Despertado."
  },
  Event_7341_Name = {
    Text = "libreta de historial clínico"
  },
  Event_7342_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7342_Desc = {
    Text = "Una pared común. Al golpearla, notas que no es sólida"
  },
  Event_7342_Name = {
    Text = "Pared extraña"
  },
  Event_7343_ChoiceDesc1 = {
    Text = "[no estoy en la superficie del agua]Mejora aleatoria 1 reliquia de plata a reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_7343_ChoiceDesc2 = {
    Text = "[Mirar hacia abajo]obtener reliquia de plata\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7343_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7343_Desc = {
    Text = "\"Jejeje, guardián, ¿recuerdas lo que dijo bígaro? Escucha, no debes mirar tu reflejo al mediodía.»"
  },
  Event_7343_Name = {
    Text = "Reflejo intangible"
  },
  Event_7343_Tips1 = {
    Text = "No poseo todavía la reliquia de plata"
  },
  Event_7344_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7344_Desc = {
    Text = "Una sombra del futuro lejano, oculta en los desfiladeros de Elworth"
  },
  Event_7344_Name = {
    Text = "Fantasma volcánico"
  },
  Event_7345_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7345_Desc = {
    Text = "La mariposa se rompe en tu palma, como un techo de vidrio que se hace añicos, los fragmentos caen, caen, caen"
  },
  Event_7345_Name = {
    Text = "Ilusión del Puente de Acero"
  },
  Event_7346_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7346_Desc = {
    Text = "Esperemos a que salgan de las sombras"
  },
  Event_7346_Name = {
    Text = "Lanterne Corbeau"
  },
  Event_7347_ChoiceDesc1 = {
    Text = "[Abrir el interruptor]Ampliar la vista actual"
  },
  Event_7347_Desc = {
    Text = "Dispositivo de iluminación dejado por los antepasados, puede dispersar la niebla negra alrededor.\nLa niebla a su alrededor fluctúa rítmicamente, como si su respiración la perturbara"
  },
  Event_7347_Name = {Text = "proyector"},
  Event_7348_ChoiceDesc1 = {
    Text = "[Señalar el problema]elige 1 de 3 cartas de comando y obtienes sello:\"(EnchantConfig.Arg1)\""
  },
  Event_7348_ChoiceDesc2 = {
    Text = "[tragarse dudas] infección\"(Skill.Arg1)\"， reimprimir, puede hacer hasta 2 veces"
  },
  Event_7348_Desc = {
    Text = "Hasta ahora, aún estás saboreando el pasado que Murphy relató. \nLos recuerdos te hacen sentir empatía, aprisionando y presionando tu cerebro, ni siquiera las palabras de consuelo de Goliath hacia Murphy pudieron brindarte alivio. \n... Espera, dijeron que el momento de alineación de las estrellas será en veinticinco años... \nPero la Murphy que tienes delante, claramente es solo una niña en plena adolescencia..."
  },
  Event_7348_Name = {
    Text = "Vida Encadenada"
  },
  Event_7349_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de reliquia de plata, infecta\"(Skill.Arg1)\""
  },
  Event_7349_Desc = {
    Text = "Debería llorar, nadie tiene más derecho a llorar que ella.\nPero, ¿por qué no lo hace? ¿Por qué se mantiene al margen, como si no fueran a ella a quien adoran...?"
  },
  Event_7349_Name = {
    Text = "Ceremonia prevuelo"
  },
  Event_7350_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7350_Desc = {
    Text = "No importa qué, es de mala educación husmear en la privacidad de los demás"
  },
  Event_7350_Name = {
    Text = "Como si nos viéramos en persona"
  },
  Event_7351_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7351_Desc = {
    Text = "Debe ser solo una ilusión"
  },
  Event_7351_Name = {
    Text = "Mirada de Cuervo Negro"
  },
  Event_7352_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de oración"
  },
  Event_7352_Desc = {
    Text = "Todos en la memoria rezan y suplican por ella. No puedes evitar murmurar en tu corazón"
  },
  Event_7352_Name = {
    Text = "Ceremonia prevuelo"
  },
  Event_7353_ChoiceDesc1 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7353_Desc = {
    Text = "Debajo del gato negro se acumulaba un charco de líquido negro, que fluía hacia la alcantarilla en la esquina del callejón. Al ver que no te acercabas, el gato negro se dio la vuelta y saltó a la alcantarilla, desapareciendo de la vista"
  },
  Event_7353_Name = {
    Text = "Elfo de la noche"
  },
  Event_7354_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7354_Desc = {
    Text = "Entraste en pánico y gritaste agudamente.\nTu voz pareció confundir a la mano inquieta, que dudó un momento.\nAprovechaste la oportunidad y escapaste"
  },
  Event_7354_Name = {
    Text = "Marisma Oscura"
  },
  Event_7355_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7355_Desc = {
    Text = "Distorsionado, retorcido, arrastrándose... haces todo lo posible para deshacerte de esos molestos brazos.\nFinalmente escapas, a costa de un uniforme nuevo, dos costillas y cientos de cabellos"
  },
  Event_7355_Name = {
    Text = "Marisma Oscura"
  },
  Event_7356_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7356_Desc = {
    Text = "\"Fenómeno normal, no te asustes, no actúes como un novato\"\nLa muñeca se acerca y ajusta la posición de tu broche,\"lo que indica que hay un pasaje especial en la dimensión cercana. Parece estar en dirección al manicomio.\""
  },
  Event_7356_Name = {
    Text = "Broche Inquieto"
  },
  Event_7357_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7357_Desc = {
    Text = "No tienes razones para aceptar la demanda de los creyentes de la luz del templo de alimentarles.\nEl cuervo sacudió su horroroso y sucio apilamiento de cabezas y emitió un sonido repugnante que solo se oiría en la frontera de la tumba, gritando mientras se marchaba"
  },
  Event_7357_Name = {
    Text = "Cuervo Maldito"
  },
  Event_7358_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7358_Desc = {
    Text = "\"Esta también es mi elección.\"dijo la figura que abrazaba el osito,\"pero ella se convertirá en su marioneta, y todos ellos morirán. \nTú serás el cómplice de ese mal.\"\nUna intensa culpa te sumerge. La figura se disipa, te sostienes el pecho, sin saber si lo que ocurrió hace un momento fue una proyección o una ilusión generada bajo la presión mental."
  },
  Event_7358_Name = {
    Text = "Sendero bifurcado"
  },
  Event_7359_ChoiceDesc1 = {
    Text = "[Continuar tapándose los oídos]gana el mismo número de el sigilo negro correspondiente al valor de locura más alto del despertador (Arg1)"
  },
  Event_7359_ChoiceDesc2 = {
    Text = "[Continuar tapándose los oídos]recupera (Arg1) puntos de vida, el sigilo negro que posees aumentará la cantidad recuperada"
  },
  Event_7359_Desc = {
    Text = "Cediste a los maliciosos susurros en tu oído. Un dolor agudo, afilado como una aguja, se retuerce en lo profundo de tu cráneo.\n\n\"Para—por favor para—hice lo que pediste—hazlo parar—\"\n\nTe aferras la cabeza en agonía, escuchando solo la lejana y burlona risa de los cuervos."
  },
  Event_7359_Name = {
    Text = "Canto de los Cuervos"
  },
  Event_7360_ChoiceDesc1 = {
    Text = "[Atrapa un cuervo]por cada despertar que poseas, obtienes 25 el sigilo negro"
  },
  Event_7360_ChoiceDesc2 = {
    Text = "[Emitir un Grito]Elige despertar a un Despertado y añade los efectos \"Inherente\" y \"Retener\" a su carta de despertar"
  },
  Event_7360_Desc = {
    Text = "Te dio un ataque de diversión y agarraste un cuervo. \n Lucha desesperadamente en tu mano, finalmente explota en una cálida masa de agua."
  },
  Event_7360_Name = {
    Text = "Canto de los Cuervos"
  },
  Event_7361_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7361_Desc = {
    Text = "Te tapas los oídos y cierras los ojos.\nTum, tum... tu corazón y los gritos se mezclan en una caótica canción de muerte.\nEn ese momento, sientes una paz sin precedentes"
  },
  Event_7361_Name = {
    Text = "Canto de los Cuervos"
  },
  Event_7362_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7362_Desc = {
    Text = "El dominio está lleno de crisis, no toda luz es un faro que guía el camino.  \nPodría ser también una llama que atrae a las polillas"
  },
  Event_7362_Name = {
    Text = "Luz nocturna"
  },
  Event_7363_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7363_Desc = {
    Text = "\"Ya llevas mucho tiempo muerto y no puedes volver a Nuestro Hogar.\" Tu voz es tan fría como el Viento que Aulla en el Campo de Nieve de Ross. La expresión del viajero no cambia en absoluto, Como Si las cosas debieran ser así. Te toma la mano de nuevo: \"¡Ayúdame. Soy un soldado enviado a las lejanas tierras del este...\""
  },
  Event_7363_Name = {Text = "Devorador"},
  Event_7364_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7364_Desc = {
    Text = "El telégrafo está roto. Puedes imaginar la desesperación de su dueño en la tormenta... porque ahora tú también la sientes"
  },
  Event_7364_Name = {
    Text = "Telegrama Silencioso"
  },
  Event_7365_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7365_Desc = {
    Text = "\"Avanza cincuenta yardas, gira a la izquierda, luego a la derecha, y después a la izquierda...\nLuego sigue hasta el final, tu casa está allí.\"\nEl viajero está muy contento. Te saluda con la mano y luego se va. \nSuspiras aliviado, de repente sientes que alguien te agarra de la mano. Ese voz familiar resuena de nuevo en tu oído: \n\"¡Ayúdame!\nSoy un soldado, enviado al lejano oriente...\""
  },
  Event_7365_Name = {Text = "Devorador"},
  Event_7366_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7366_Desc = {
    Text = "Finalmente saliste del laberinto.\nEn ese momento, te das cuenta de que el museo de cera está vivo.\nTodo lo extraño, bello y cruel está conectado por un antiguo ritual.\nY el ojo del ritual es Rogers"
  },
  Event_7366_Name = {
    Text = "Laberinto de los Ojos"
  },
  Event_7367_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7367_Desc = {
    Text = "\"¿Es divertido el juego de roles, guardián?\" Ramona tiró de tu manga, \"La salida no está lejos, espero que puedas mantener el mismo ingenio ante la señora narciso.\""
  },
  Event_7367_Name = {
    Text = "Fragmento de recuerdo: Sueños del pasado"
  },
  Event_7368_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7368_Desc = {
    Text = "\"El despertador tiene dificultades para resistir la voluntad del enlazador,» respondes, «pero no nos rendiremos.»"
  },
  Event_7368_Name = {
    Text = "Su elección"
  },
  Event_7369_ChoiceDesc1 = {
    Text = "[Entrar]Atravesar la pared, investigar"
  },
  Event_7369_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7369_Desc = {
    Text = "Te acercas a la pared, que de repente se distorsiona, como si quisiera absorberte"
  },
  Event_7369_Name = {
    Text = "Espacio Distorsionado"
  },
  Event_7370_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7370_Desc = {
    Text = "\"No, esto no es cierto. Al menos tienen cuerpos peludos en comparación con las cucarachas. \n Nadie puede rechazar un cuerpo peludo.\"\n Las ratas susurran entre ellas y finalmente aceptan a regañadientes tu punto de vista. \n \"Bueno... en realidad no tienen tanto pelo.\"\n Siempre es agradable recibir elogios. Antes de irse, las ratas te ofrecen un pequeño regalo."
  },
  Event_7370_Name = {Text = "Peste"},
  Event_7371_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7371_Desc = {
    Text = "\"¡Estoy de acuerdo! ¡Humanos y ratas no pueden coexistir!»\nLas ratas se enfurecieron, mostrando sus colmillos blancos.\n«¿Entonces qué haces aquí? Toma tus cosas y no vuelvas nunca.»"
  },
  Event_7371_Name = {Text = "Peste"},
  Event_7372_ChoiceDesc1 = {
    Text = "[Confirmar]"
  },
  Event_7372_Desc = {
    Text = "¡Bienvenido a las profundidades del océano, aquí cada paso trae una presión inmensa!  \n La niebla de caos, que no deja pasar la luz, oculta todo en ella, ¿puedes cruzar este mar oscuro bajo tanta presión?"
  },
  Event_7372_Name = {
    Text = "Bajo la marea"
  },
  Event_7373_ChoiceDesc1 = {
    Text = "[Echa un Vistazo]Elimina una carta"
  },
  Event_7373_ChoiceDesc2 = {
    Text = "[Mirar detenidamente]Obtén \"(RelicConfig.Arg1)\"，infecta con \"(Skill.Arg2)\""
  },
  Event_7373_Desc = {
    Text = "\"Tic tac...\"\nLa máquina de escribir, como un borracho de whisky, escupe tinta negra lentamente.\nCaptas la palabra \"Mason\" y sacas la hoja de inmediato"
  },
  Event_7373_Name = {
    Text = "Máquina de escribir"
  },
  Event_7374_ChoiceDesc1 = {
    Text = "[Mirada penetrante]obtiene reliquia de oro\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_7374_ChoiceDesc2 = {
    Text = "[Cerrar los ojos]despertar aleatoriamente 2 despertadores, contagiar dos veces\"(Skill.Arg1)\""
  },
  Event_7374_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7374_Desc = {
    Text = "Innumerables ojos susurran a tu alrededor. \n\"Viajamos, nos detenemos, caminamos a grandes pasos por decenas de miles de años e incluso más. \nCuando el sol se oscurece gradualmente bajo la mirada, cuando la vida de la antigua Tierra es anegada por las inundaciones. \nYa hemos sido profundamente atraídos por los misterios del universo.\""
  },
  Event_7374_Name = {Text = "ojo"},
  Event_7375_ChoiceDesc1 = {
    Text = "[Seguir instrucciones]Aumenta Arg1 de vida"
  },
  Event_7375_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7375_Desc = {
    Text = "Intentaste usar el poder de retroceso de la llave de plata para buscar el punto de enlace más cercano, pero la información que recibiste contenía anormalidades difíciles de detectar, parecía estar interferida"
  },
  Event_7375_Name = {
    Text = "Contacto Anómalo"
  },
  Event_7376_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7376_Desc = {
    Text = "Has limpiado suavemente la superficie de la máquina de escribir con un pañuelo estándar de lino proporcionado en el conjunto de estudiante de mitag.\nLa máquina de escribir ha recuperado su calma. En cuanto al pañuelo sucio... dejémoslo en el dominio"
  },
  Event_7376_Name = {
    Text = "El susurro de la máquina de escribir"
  },
  Event_7377_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7377_Desc = {
    Text = "Miraste de cerca y entre las manchas de tinta apareció un nombre, \"Fingal Johansen\".\n¿Quién es?"
  },
  Event_7377_Name = {
    Text = "El susurro de la máquina de escribir"
  },
  Event_7378_ChoiceDesc1 = {
    Text = "[mirar hacia arriba]elige 1 de 3 cartas de comando, obtén plegaria:\"(EnchantConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_7378_ChoiceDesc2 = {
    Text = "[¿Ángulo de elevación del sol?] elige despertar 1 despertador, infecta «(Skill.Arg1)»"
  },
  Event_7378_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7378_Desc = {
    Text = "\"Ahora, mira hacia el sureste, el ángulo del sol está en su posición.\" La instrucción de Helot llega a través del comunicador"
  },
  Event_7378_Name = {
    Text = "Ángulo de elevación"
  },
  Event_7379_ChoiceDesc1 = {
    Text = "[infección\"(Skill.Arg1)\"，obtén una reliquia de oro\"(RelicConfig.Arg2)\"]"
  },
  Event_7379_ChoiceDesc2 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7379_Desc = {
    Text = "Evento 354 (en desarrollo), no es el efecto final"
  },
  Event_7379_Name = {
    Text = "Evento 354 (en desarrollo)"
  },
  Event_7380_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7380_Desc = {
    Text = "Las voces de los niños fluyen desde las teclas del piano. \n\"El viejo Charlie tenía un gato atigrado que amaba...\" \nBajo el canto de los niños, una voz femenina joven también canta suavemente. \n¿Te lo imaginaste?"
  },
  Event_7380_Name = {
    Text = "Melodía de la infancia"
  },
  Event_7381_ChoiceDesc1 = {
    Text = "[dar la vuelta]obtén 25 el sigilo negro"
  },
  Event_7381_ChoiceDesc2 = {
    Text = "[Continuar avanzando]gana reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_7381_Desc = {
    Text = "Escuchaste pasos detrás de ti.\nLentos y constantes, como una sombra.\nSe entrelazaban con tus propios pasos, resonando en la sala vacía"
  },
  Event_7381_Name = {Text = "Oxford"},
  Event_7382_ChoiceDesc1 = {
    Text = "[Guardar carta]Eliminar 2 cartas"
  },
  Event_7382_ChoiceDesc2 = {
    Text = "[Conservar la carta]obtener reliquia maldita\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7382_ChoiceDesc3 = {
    Text = "[Salir]obtiene Arg1 sigilo negro"
  },
  Event_7382_Desc = {
    Text = "Una nueva máquina de escribir. \n Tiene teclas únicas, tan elegantes y precisas como un microscopio. \n Estás absorto en su perfecta estructura mecánica, cuando de repente aparecen las letras negras. \n \"Estimado señor Rogers, \n Nos entristece informarle que ha sido expulsado de la academia. \n Como es bien sabido, la @2 academia siempre ha sido famosa en el reino por su riguroso enfoque académico, esos rumores sorprendentes @3 le han causado una profunda preocupación...\""
  },
  Event_7382_Name = {
    Text = "Como si nos viéramos en persona"
  },
  Event_7383_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7383_Desc = {
    Text = "El reloj de bolsillo detenido en la distancia parece una advertencia, recordándote que no te pierdas en la trampa del tiempo"
  },
  Event_7383_Name = {Text = "Su mirada"},
  Event_7384_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7384_Desc = {
    Text = "El lodo negro goteó en tu cara, causando una sensación de picazón.\nNo pudiste soportarlo y apartaste la mariposa con la mano.\nLa mariposa esquivó tu movimiento y desapareció silenciosamente en la distancia"
  },
  Event_7384_Name = {
    Text = "Mariposa de Líquido Negro"
  },
  Event_7385_ChoiceDesc1 = {
    Text = "[Observar cuidadosamente]"
  },
  Event_7385_ChoiceDesc2 = {Text = "[Excavar]"},
  Event_7385_Desc = {
    Text = "Kum los llevó a los tres por el manicomio buscando una entrada.\nDe repente, frenó bruscamente, casi tirándolos de su espalda.\nAnte sus preguntas, Kum bajó la cabeza, olfateando el suelo blando, y les indicó que algo estaba enterrado debajo"
  },
  Event_7385_Name = {
    Text = "Objeto enterrado"
  },
  Event_7386_ChoiceDesc1 = {
    Text = "[Reclamar]Obtén 1 de 3 reliquias de oro"
  },
  Event_7386_Desc = {
    Text = "Allí no hay nada, el líquido negro fluye por el suelo, sin reflejar nada.\n¿Es tu imaginación? Sientes que algo se desliza entre tus dedos"
  },
  Event_7386_Name = {
    Text = "Bajo la superficie del espejo"
  },
  Event_7387_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7387_Desc = {
    Text = "Las alas negras caen sobre la húmeda tierra del callejón, convirtiéndose en baba de disolución negra"
  },
  Event_7387_Name = {
    Text = "Enjambre de cuervos enardecidos"
  },
  Event_7388_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7388_Desc = {
    Text = "\"A la señora Narciso le gustará tu humor.\" Ramona agitó su mano, y la niebla fantasma se dispersó a su alrededor, \"no dejes que te conviertas en el costo del viaje dimensional。\""
  },
  Event_7388_Name = {
    Text = "Fragmento de recuerdo: Sueños del pasado"
  },
  Event_7389_ChoiceDesc1 = {
    Text = "[Reclamar]Obtén 1 de 3 reliquias de oro"
  },
  Event_7389_Desc = {
    Text = "Oh, sí, ese reflejo odioso eres tú.\nLa malicia brota y se mezcla con el lodo negro a tus pies, bailando torcidamente. Si no te importa, también quiere subirse a tu hombro"
  },
  Event_7389_Name = {
    Text = "Bajo la superficie del espejo"
  },
  Event_7390_ChoiceDesc1 = {
    Text = "[permanecer inmóvil] obtiene 25 el sigilo negro"
  },
  Event_7390_ChoiceDesc2 = {
    Text = "[Caminar libremente]obtiene la reliquia de plata\"(RelicConfig.Arg1)\"，contagiar\"(Skill.Arg2)\""
  },
  Event_7390_Desc = {
    Text = "Aplastas tu sombra y caes en un charco de oscuridad.\nEsa sombra rota y dispersa es lo único que te conecta con el mundo perdido.\n¿Realmente quieres caminar en la pesadilla oscura? Aún no has encontrado tu dirección"
  },
  Event_7390_Name = {
    Text = "Marchador de pesadillas"
  },
  Event_7391_ChoiceDesc1 = {
    Text = "[Buscar el origen] obtiene reliquia de plata «(RelicConfig.Arg1)», infecta «(Skill.Arg2)»"
  },
  Event_7391_ChoiceDesc2 = {
    Text = "[Reproducir disco]Todos los cuerpos despiertos recuperan 50 de locura, infecta\"(Skill.Arg1)\""
  },
  Event_7391_ChoiceDesc3 = {
    Text = "[Desmontar el gramófono]obtienes sello de 3 opciones"
  },
  Event_7391_Desc = {
    Text = "Te encuentras con un viejo fonógrafo. \n Al darle cuerda, colocas la aguja sobre el disco de vinilo lleno de rasguños, la sinfonía suena distorsionada como el tirón de una cinta adhesiva al despegarse, los instrumentos de viento y cuerdas se golpean entre sí, y ninguna sección puede escapar ilesa de esta pieza. \n Al final de la melodía, que suena como un zumbido, escuchas una serie de golpes rítmicos. \n \"¡Dong dong... dong dong dong... dong...\" \n Frunces el ceño, levantas la aguja, pero el sonido de los golpes persiste."
  },
  Event_7391_Name = {
    Text = "Rastro Misterioso"
  },
  Event_7392_ChoiceDesc1 = {
    Text = "[Contemplar resplandores]transforma 1 reliquia en reliquia maldita\"(RelicConfig.Arg1)\""
  },
  Event_7392_ChoiceDesc2 = {
    Text = "[tocar el brillo]obtén la reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_7392_ChoiceDesc3 = {
    Text = "[dar la vuelta y salir]obtén 25 el sigilo negro"
  },
  Event_7392_Desc = {
    Text = "Bajo la visión del sueño, la niebla del dominio cubre la realidad con un velo negro. Todo lo que ves es difuso, como si estuviera presente y ausente al mismo tiempo. \n En la penumbra, la luz de algo atraviesa la niebla. Como un faro para un barco, o el humo de una hoguera para un niño perdido, guiando hacia un camino seguro."
  },
  Event_7392_Name = {
    Text = "Luz nocturna"
  },
  Event_7393_ChoiceDesc1 = {
    Text = "[Pausar música]mejora 1 reliquia de plata a reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_7393_ChoiceDesc2 = {
    Text = "[hablar con ella]obtén reliquia de oro\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\"y\"(Skill.Arg3)\""
  },
  Event_7393_ChoiceDesc3 = {
    Text = "[Escuchar con calma]Obtén 25 sigilos negros"
  },
  Event_7393_Desc = {
    Text = "Recoges algunos fragmentos de memoria de una masa negra sucia.\nLos cristales brillan, unos hilos se mueven dentro, los restos de memoria flotan como arena en el aire.\nImágenes caóticas y extrañas se elevan a tu alrededor.\nMiras hacia—\n"
  },
  Event_7393_Name = {
    Text = "Fragmento de Luna de Plata"
  },
  Event_7394_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7394_Desc = {
    Text = "Extendiste la mano para atrapar algunos copos de nieve que caían, fijando la vista. Esos copos de nieve no se derretían en brillantes gotas de agua, sino en una espesa y oscura baba de disolución"
  },
  Event_7394_Name = {Text = "Nieve"},
  Event_7395_ChoiceDesc1 = {
    Text = "[no estoy en la superficie del agua]Mejora aleatoria 1 reliquia de plata a reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_7395_ChoiceDesc2 = {
    Text = "[Mirar hacia abajo]obtener reliquia de plata\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7395_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7395_Desc = {
    Text = "La niebla se disipa y una mano delgada y marchita se extiende hacia ti. \n Parece haber sido corroída hasta los huesos, con la palma rugosa cubierta de una viscosa sustancia negra, mientras que sobre ella cuelgan anillos y collares que brillan con luz dorada. \n Te hace un gesto con la mano, como si te estuviera invitando a acercarte. \n Solo bajo la sombra de la crisis, los tesoros parecen brillar con más intensidad."
  },
  Event_7395_Name = {
    Text = "Invertir las garras del mal"
  },
  Event_7395_Tips1 = {
    Text = "No poseo todavía la reliquia de plata"
  },
  Event_7396_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7396_Desc = {
    Text = "La ilusión te saludó y luego desapareció, dejándote solo con el frío hielo y las majestuosas montañas"
  },
  Event_7396_Name = {
    Text = "Fantasma volcánico"
  },
  Event_7397_ChoiceDesc1 = {
    Text = "[Funeral de la luna de plata]elija 1 reliquia para transformarse en reliquia maldita\"(RelicConfig.Arg1)\""
  },
  Event_7397_ChoiceDesc2 = {
    Text = "[Oración a la luna de plata]obtiene la reliquia de plata\"(RelicConfig.Arg1)\"，contagiar\"(Skill.Arg2)\""
  },
  Event_7397_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7397_Desc = {
    Text = "Recoges algunos fragmentos de memoria de una masa negra sucia.\nLos cristales brillan, unos hilos se mueven dentro, los restos de memoria flotan como arena en el aire.\nImágenes caóticas y extrañas se elevan a tu alrededor.\nMiras hacia—"
  },
  Event_7397_Name = {
    Text = "Fragmento de Luna de Plata"
  },
  Event_7398_ChoiceDesc1 = {
    Text = "[agregar combustible] obtiene 3 opciones de oración"
  },
  Event_7398_ChoiceDesc2 = {
    Text = "[Apágalo]Selecciona una carta de comando entre 3 y obtén un sello:\"(EnchantConfig.Arg1)\"、infección\"(Skill.Arg2)\""
  },
  Event_7398_Desc = {
    Text = "\"Soy la sombra de la doncella asesinada, el asesino es esa falsa llama verde.\"\nLa tenue llama rojiza se balancea, acusándote.\n\"Viví junto al lago reflejado por la luna convexa, brillante y resplandeciente.\""
  },
  Event_7398_Name = {
    Text = "Fuego tenue"
  },
  Event_7399_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7399_Desc = {
    Text = "Tú y la sombra estaban bajo la farola, sin decir nada.\nNo había luna esta noche, todas las casas estaban en silencio.\nLe hiciste un gesto a la sombra y te diste la vuelta para irte"
  },
  Event_7399_Name = {
    Text = "La sombra bajo la farola"
  },
  Event_7400_ChoiceDesc1 = {
    Text = "[Ahuyentar cuervos]Obtén Arg1 sigilos negros, contagia\"(Skill.Arg2)\"，continúa eligiendo"
  },
  Event_7400_ChoiceDesc2 = {
    Text = "[Ignorar]Salir"
  },
  Event_7400_Desc = {
    Text = "Un cuervo se posó en la cabecera de la cama, mirándote con ojos rojos"
  },
  Event_7400_Name = {
    Text = "Lanterne Corbeau"
  },
  Event_7401_ChoiceDesc1 = {
    Text = "[decir que no tengo cartera]obtén 1 de 3 sigilos"
  },
  Event_7401_ChoiceDesc2 = {
    Text = "[Romper la red] 1 Tarjeta de comando aleatoria obtiene Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7401_Desc = {
    Text = "La red de color naranja brilla en el aire, fluyendo silenciosamente, con agujeros dispersos, lejos de ser tan delicada como la pariente lejana que habita en la esquina de la pared. \n No puedes evitar extender la mano para tocarla, la frágil red se disuelve instantáneamente, las risas de los niños resuenan en tus oídos. \n \"¡Los de oro, los de plata, los de amarillo y los de rojo, todos los billeteras son nuestras!\""
  },
  Event_7401_Name = {
    Text = "Red errante"
  },
  Event_7402_ChoiceDesc1 = {
    Text = "[Reparar la máquina telegráfica]infección\"(Skill.Arg1)\"，gana aleatoriamente 1 carta de comando y recibe plegaria:\"(EnchantConfig.Arg2)\""
  },
  Event_7402_ChoiceDesc2 = {
    Text = "[Enterrar la máquina de telégrafo]Infectar\"(Skill.Arg1)\"、gana aleatoriamente 1 carta de comando con plegaria:\"(EnchantConfig.Arg2)\""
  },
  Event_7402_ChoiceDesc3 = {
    Text = "[Ignorar]elegir 1 de 3 cartas de comando y obtener plegaria：\"(EnchantConfig.Arg1)\""
  },
  Event_7402_Desc = {
    Text = "Te escondes en una grieta de la cueva para evitar la tormenta. Pero sabes que no puedes quedarte mucho tiempo, si esos hombres de negro te encuentran, no tendrás escapatoria.\nEn un rincón de la grieta, encuentras un telégrafo roto"
  },
  Event_7402_Name = {
    Text = "Reliquias de los antiguos"
  },
  Event_7403_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7403_Desc = {
    Text = "Viste retratos como este en muchos lugares del reino.\n\"La Reina\" está en el centro, brillando entre rosas negras.\nExcepto por una cosa: su rostro ha sido cruelmente arrancado, dejando un agujero negro quemado.\nAún no puedes ver el verdadero rostro de la reina"
  },
  Event_7403_Name = {
    Text = "Galería de retratos"
  },
  Event_7404_ChoiceDesc1 = {
    Text = "[Dejarla ir]obtener reliquia maldita\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7404_ChoiceDesc2 = {
    Text = "[Ayudarla] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_7404_ChoiceDesc3 = {
    Text = "[voy a seguir mi propio camino]Obtén 50 el sigilo negro"
  },
  Event_7404_Desc = {
    Text = "Tres figuras bloquean tu camino. \n\"Puedes liberarla,\"dice la figura que abraza un osito de peluche cubierto de D-Slime,\"ella solo tiene miedo, no es malvada. No quiere hacerle daño a nadie.\"\n\"Puedes ayudarla,\"dice la figura que sostiene un paquete de dulces finamente envuelto,\"tú puedes hacer lo que ella no puede, tú puedes acabar con todo esto.\"\n\"No necesitas escucharnos,\"dice la figura que tiene las manos vacías,\"tienes tu propio camino.\""
  },
  Event_7404_Name = {
    Text = "Sendero bifurcado"
  },
  Event_7405_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7405_Desc = {
    Text = "La voz de Daffodil se detuvo por un momento.\n \"Oh, ¿has elegido esto? Buena elección, como recompensa, te haré un regalo especial.\"\n \"No conozco bien a esa niña, pero tengo una teoría sobre Francis. Creo que la emoción que la domina y le da el poder de 'ver' es un profundo remordimiento. No sé qué decisiones tomará debido a ese remordimiento...\""
  },
  Event_7405_Name = {
    Text = "Tiempo de pista"
  },
  Event_74068_ChoiceDesc1 = {
    Text = "[Incorporar al cerebro en un frasco] Baraja el \"Cerebro de repuesto\" en el mazo de robo."
  },
  Event_74068_Desc = {
    Text = "Dentro del arco tallado y complejo, sobre el tejado inclinado de ladrillos rojos y frente a las casas con huecos en las paredes, las sombras alargadas se mueven, anhelando respuestas a las preguntas. \n¿La mediocridad significa muerte? \n¿Estar satisfecho con el estado actual significa que se extinguirá el fuego?"
  },
  Event_74068_Name = {
    Text = "Conciencia que aún no se ha perdido"
  },
  Event_74069_ChoiceDesc1 = {
    Text = "[Continuar alojando] Elige hasta 2 cartas de comando para eliminar del mazo y colócalas en el \"Cerebro de repuesto\"."
  },
  Event_74069_Desc = {
    Text = "«Vi a muchos, muchas voces susurrantes, sabios, superficiales, racionales, locos. A veces, también nace una chispa de esperanza entre las cenizas.»"
  },
  Event_74069_Name = {
    Text = "Conciencia que aún no se ha perdido"
  },
  Event_7406_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7406_Desc = {
    Text = "Retiras con cuidado al ratón de la balanza, respira suavemente, su cuerpo peludo calienta tu palma"
  },
  Event_7406_Name = {
    Text = "Razón y Emoción"
  },
  Event_7407_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7407_Desc = {
    Text = "El núcleo de plata tenue estalla en un resplandor deslumbrante, que desaparece en un instante, dejando en la mano solo cenizas indistinguibles de la tierra.\nEl núcleo de plata, agotada su última Gnosis, no logró reconstruir un cuerpo para el alma desconocida, pero dejó un rastro de su existencia antes de desaparecer por completo."
  },
  Event_7407_Name = {
    Text = "Prueba de existencia"
  },
  Event_7408_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7408_Desc = {
    Text = "\"No conozco bien a esa niña, pero tengo una teoría sobre Francis. Creo que la emoción que la domina y le da el poder de 'ver' es un profundo remordimiento. No sé qué decisiones tomará debido a ese remordimiento...\""
  },
  Event_7408_Name = {
    Text = "Tiempo de pista"
  },
  Event_7409_ChoiceDesc1 = {
    Text = "[Sacar el papel]Eliminar 1 carta"
  },
  Event_7409_ChoiceDesc2 = {
    Text = "[No es el momento]Obtén\"(RelicConfig.Arg1)\", infecta\"(Skill.Arg2)\""
  },
  Event_7409_Desc = {
    Text = "La máquina de escribir portátil en el maletín comienza a escribir sola, saliendo media hoja de texto torcido.\n\"Ya lo has visto, Él está a tu lado, esas sombras contaminadas por la locura... No mires directamente su contorno.\""
  },
  Event_7409_Name = {
    Text = "Advertencia no invitada"
  },
  Event_7410_ChoiceDesc1 = {
    Text = "[caminar a la izquierda] selecciona 1 de 3 cartas de comando para obtener la oración：\"(EnchantConfig.Arg1)\"， infección\"(Skill.Arg2)\""
  },
  Event_7410_ChoiceDesc2 = {
    Text = "[Ir a la Derecha]Elige despertar a un Despertado, infecta\"(Skill.Arg1)\""
  },
  Event_7410_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7410_Desc = {
    Text = "Parece que entraste en un laberinto.\nIzquierda, derecha, otra vez izquierda... pierdes la paciencia hasta que levantas la cabeza y ves ese ojo.\nEl ojo te observa, sereno y majestuoso, como si fuera el dueño de este lugar"
  },
  Event_7410_Name = {
    Text = "Laberinto de los Ojos"
  },
  Event_7411_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7411_Desc = {
    Text = "Retiras tus manos con fuerza y escuchas claramente el sonido de huesos rompiéndose.\nEste es el precio de tu curiosidad"
  },
  Event_7411_Name = {
    Text = "Chispa de inspiración"
  },
  Event_7412_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7412_Desc = {
    Text = "Revisaste cuidadosamente la cámara, con cuero y oro negro incrustados en el cuerpo, reflejando un brillo aceitoso.\nSu lente te apuntaba, como si te mirara, te espiara"
  },
  Event_7412_Name = {
    Text = "Registro de inocencia"
  },
  Event_7413_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7413_Desc = {
    Text = "Arrancaste sin piedad el resto de la película, oculta en la cámara, y lo que viste te dejó sin palabras.\nLa película sin revelar mostraba tu cuerpo en un charco de brea"
  },
  Event_7413_Name = {
    Text = "Registro de inocencia"
  },
  Event_74145_ChoiceDesc1 = {
    Text = "[Leer]elimina 1 carta de comando, obtiene 25 sigilos negros"
  },
  Event_74145_ChoiceDesc2 = {
    Text = "[Continuar escribiendo]Copia una carta del mazo, infecta con \"(Skill.Arg1)\""
  },
  Event_74145_Desc = {
    Text = "La impresora escupe tinta furiosamente.  \nLa tinta negra, como un fantasma, surge del cabezal de impresión y se esparce en el aire, formando una densa y opresiva niebla negra.  \nEl teclado parece ocultar alguna insinuación, esperando que un dedo inocente lo toque."
  },
  Event_74145_Name = {
    Text = "Tinta fantasma"
  },
  Event_74146_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74146_Desc = {
    Text = "Te giras y entras en el callejón oscuro, la niebla roe los bordes de tu ropa, pero esa sombra se ha dividido detrás de ti en innumerables ojos. El sonido oxidado de las campanas arrastra presagios de humedad.\n\nSabes que todos los caminos tortuosos eventualmente colapsarán en un capullo cíclico—antes del amanecer en descomposición, tú y tu reflejo finalmente se reencontrarán."
  },
  Event_74146_Name = {
    Text = "Cenizas del tiempo"
  },
  Event_74147_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74147_Desc = {
    Text = "Dibujas silenciosamente un contorno en tu pecho, ofreciendo una oración muda por los fallecidos. \n En este mundo de aniquilación, hay demasiadas cosas que no puedes salvar. \n Los huesos brillan, y se vislumbra un rincón del tesoro que su dueño atesoró en vida."
  },
  Event_74147_Name = {
    Text = "Huesos descoloridos"
  },
  Event_74148_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74148_Desc = {
    Text = "«El Padre Dios reconoce tu compasión. El Padre Dios nos cuidará y nos redimirá de la pesada carga del sufrimiento.»\n\nSu ilusión se desvaneció gradualmente, y el sonido de la música sagrada también se convirtió en un viento implacable que rugía sin piedad."
  },
  Event_74148_Name = {
    Text = "Oración del órgano"
  },
  Event_74149_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74149_Desc = {
    Text = "Empujas suavemente los huesos expuestos, y estos se hunden natural y lentamente en el líquido negro, desapareciendo sin dejar rastro.\nQue el alma descanse en la nada."
  },
  Event_74149_Name = {
    Text = "Huesos descoloridos"
  },
  Event_7414_ChoiceDesc1 = {
    Text = "[Salir]venciste al oponente, no pasa nada"
  },
  Event_7414_Desc = {
    Text = "\"Parece que el pequeño necesita aprender que los secretos de una mujer no se investigan fácilmente.\"\nCon las palabras de Dafne, un monstruo enorme aparece ante ti"
  },
  Event_7414_Name = {
    Text = "Tiempo de pista"
  },
  Event_74150_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74150_Desc = {
    Text = "No debería haber juguetes enfermizos en el campanario donde se esconde el pequeño ratón; ese sonido proviene de tu mente, de tus recuerdos. \nRecuerdas la sensación que tuviste siendo un cerebro en un frasco, cuando la corriente se transformaba en ondas sonoras. \nEse sonido extraño se vuelve gradualmente normal y suave, convirtiéndose en una melodía clásica fluida que se reproduce en tu mente."
  },
  Event_74150_Name = {
    Text = "Sonidos extraños en la torre del reloj"
  },
  Event_74151_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74151_Desc = {
    Text = "No es un gato... son los Portadores de linternas que se mueven. \n Bajo el velo negro se filtran el desprecio y la hostilidad, susurros raspan tu conciencia, trayendo una Fantasma extraña e incomprensible."
  },
  Event_74151_Name = {
    Text = "El susurro del gato"
  },
  Event_74152_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74152_Desc = {
    Text = "Ellos agarran tus zapatos, agarran tus tobillos. Son codiciosos, ansían, quieren arrastrarte al abismo donde ellos están. \nLuchas con fuerza para mantenerte en pie, retrocedes unos pasos intentando escapar. \nSin darte cuenta, algo cae."
  },
  Event_74152_Name = {
    Text = "Reflejo de Pesadilla"
  },
  Event_74153_ChoiceDesc1 = {
    Text = "[Esquivar]obtén 3 opciones de plegaria"
  },
  Event_74153_ChoiceDesc2 = {
    Text = "[Detener]Elige 1 de 3 cartas de comando para obtener un sello: «(EnchantConfig.Arg1)», infectar «(Skill.Arg2)»"
  },
  Event_74153_Desc = {
    Text = "Imágenes que parecen familiares hacen que tus nervios salten, se agiten y sientan miedo. \n \"Una vez más...\" \n Una pesadilla inhumana llega, una inmensa sensación de impotencia te envuelve. \n ¿Realmente no puedes reescribir su destino? \n Es demasiado tarde, en el cráneo roto de Sara, una enorme boca brillante espera para morderte y devorarte."
  },
  Event_74153_Name = {
    Text = "Pesadilla recurrente"
  },
  Event_74154_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74154_Desc = {
    Text = "Escuchas susurros inquietantes.\n\n«Venimos de las montañas y los pantanos de estrellas distantes. Nuestro cuerpo es la mecha y el combustible de la lámpara; encenderemos el fuego proveniente de la tierra, iluminando el camino hacia un nuevo mundo.»"
  },
  Event_74154_Name = {
    Text = "El susurro del gato"
  },
  Event_74155_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74155_Desc = {
    Text = "El atardecer, la torre del reloj, los pájaros volando...\nLa niña se quita el antifaz, su mirada de pupilas grises te deja paralizado.\nLa ilusión se desvaneció como un espejismo, pero los pensamientos preocupantes no se van."
  },
  Event_74155_Name = {
    Text = "Máscara blanca"
  },
  Event_74156_ChoiceDesc1 = {
    Text = "[Recoger]Obtén 1 de 3 reliquias de plata"
  },
  Event_74156_ChoiceDesc2 = {
    Text = "[Recordar]obtén la reliquia de plata\"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\", infecta dos veces\"(Skill.Arg3)\""
  },
  Event_74156_Desc = {
    Text = "En la esquina, dentro de la babosa corrosión, yace una pequeña venda blanca. \n Los recuerdos atrapan tu corazón."
  },
  Event_74156_Name = {
    Text = "Máscara blanca"
  },
  Event_74157_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74157_Desc = {
    Text = "Las manos transparentes se mueven con soltura sobre las teclas en blanco y negro, pero las ondas sonoras que emiten son fragmentadas, como un carrillón desafinado, cada nota emitiendo un lamento disonante, como un grito de auxilio en lucha. \nAl final, la interpretación se detiene abruptamente en un acorde resignado. \nLo que no se pudo obtener en vida, solo deja un sentimiento de nostalgia en este momento."
  },
  Event_74157_Name = {
    Text = "Sonata de Lamento"
  },
  Event_74158_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74158_Desc = {
    Text = "\"Estimado señora Sara: \n Solicito renunciar a mi puesto de enfermero en la Casa de pobres. \n Ya no reconozco su filosofía. Su enseñanza es errónea, los niños del Distrito Este no deben crecer bajo su protección, no deben confiar en la pura bondad y el desinteresado otorgamiento. \n Algún día tendrán que salir de sus alas y aprender las reglas de supervivencia del Distrito Este. \n\n...\" \n\n La escritura posterior está empapada por un líquido negro, todo es borroso."
  },
  Event_74158_Name = {
    Text = "Tinta fantasma"
  },
  Event_74159_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74159_Desc = {
    Text = "\"Lo que puedo ofrecer a los niños es solo un alero para protegerse de la lluvia y un poco de comida que apenas evita que mueran de hambre. Si no fuera por el médico que el Sr. Rogers, de buen corazón, llamó, ellas no podrían obtener ni una pastilla cuando están enfermas. \nNo he leído muchos libros, todo lo que puedo hacer es evitar que mueran de frío y hambre en las calles. \nNunca he interferido en lo que los niños quieren llegar a ser, pero necesitan sobrevivir. \n......\""
  },
  Event_74159_Name = {
    Text = "Tinta fantasma"
  },
  Event_7415_ChoiceDesc1 = {
    Text = "[Investigar el origen]Recibe reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_7415_ChoiceDesc2 = {
    Text = "[desechar la carta]elige 1 de 3 cartas de comando, obtén plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7415_ChoiceDesc3 = {
    Text = "[Revisar carta]gana 50 el sigilo negro"
  },
  Event_7415_Desc = {
    Text = "Otra carta cae frente a ti, el papel rasgado te hace sentir un nudo en el estómago, y levantas el papel. \n \"¡Ha vuelto, lo que prediqué no eran palabras vacías! @4 Aquí comienza, y aquí también terminará.\" \n \"Quiero huir... me metí en el armario, mis manos tiemblan incontrolablemente, pero el sonido de los cuerpos pegajosos golpeando el suelo se acerca cada vez más... ¡Escuché un nombre! ¡Es él! @5!\""
  },
  Event_7415_Name = {
    Text = "Otra carta de solicitud de ayuda"
  },
  Event_74160_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74160_Desc = {
    Text = "\"Gracias, el poder de creación del Padre Dios finalmente moldeará nuestros cuerpos, trayéndonos luz y fuego eternos. \n\nCuando llegue al final, bendeciré tu nombre ante el Padre Dios.\"\n\nSu ilusión se desvaneció gradualmente, y el sonido de la música sagrada también se convirtió en un viento implacable que aullaba."
  },
  Event_74160_Name = {
    Text = "Oración del órgano"
  },
  Event_74161_ChoiceDesc1 = {
    Text = "[Enterrar]Recuperar Arg2 puntos de vida [ExDesc1]. Elige 1 carta de comando para eliminar."
  },
  Event_74161_ChoiceDesc2 = {
    Text = "[Pray] Obtén la Creación de oro \"(RelicConfig.Arg1)\", pero desarrolla \"(Skill.Arg2)\"."
  },
  Event_74161_Desc = {
    Text = "Un fragmento de hueso pálido, la mitad sumergido en la disolución negra."
  },
  Event_74161_Name = {
    Text = "Huesos descoloridos"
  },
  Event_74162_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74162_Desc = {
    Text = "Entraste de lleno en la niebla, las sombras se enredaron en tu cuerpo como una telaraña, y la sensación fría se filtró en tu médula. \n Sus susurros se convirtieron en fragmentos de memoria, atravesando tu pecho. \n Al cruzar, solo quedó un vacío detrás de ti, mientras que adelante, en la densa niebla, emergen más sombras borrosas, esperando devorar."
  },
  Event_74162_Name = {
    Text = "Cenizas del tiempo"
  },
  Event_74163_ChoiceDesc1 = {
    Text = "[Esquivar el fantasma]obtienes una reliquia de oro\"(RelicConfig.Arg1)\", infección\"(Skill.Arg2)\""
  },
  Event_74163_ChoiceDesc2 = {
    Text = "[Atravesar el espejismo]obtiene elección de 3 para 1 de reliquia de oro, infecta\"(Skill.Arg1)\""
  },
  Event_74163_ChoiceDesc3 = {
    Text = "[Salir]obtiene reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_74163_Desc = {
    Text = "La niebla densa se cierne sobre las calles como un pesado telón, cada paso se siente como si pisaras las cenizas del tiempo.\nA lo lejos, dos sombras difusas aparecen y desaparecen en la bruma, como fantasmas del pasado, susurrando aquellas historias que ya han sido olvidadas.\nLa imaginación descontrolada vuelve a dar forma a sombras aterradoras, se distorsionan y se propagan, como presagios del futuro, aplastándote hasta casi asfixiarte.\nSabes que el camino adelante solo se volverá más oscuro, pero tus pasos no pueden ni deben detenerse."
  },
  Event_74163_Name = {
    Text = "Cenizas del tiempo"
  },
  Event_74164_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74164_Desc = {
    Text = "Esquivaste por poco el primer ataque rápido de Sarah.\nA continuación, quizás no tengas tanta suerte."
  },
  Event_74164_Name = {
    Text = "Pesadilla recurrente"
  },
  Event_74165_ChoiceDesc1 = {
    Text = "[Indicar dirección]obtiene la reliquia de plata «(RelicConfig.Arg1)», infección «(Skill.Arg2)»"
  },
  Event_74165_ChoiceDesc2 = {
    Text = "[Orar juntos]obtén 3 opciones de sello"
  },
  Event_74165_Desc = {
    Text = "El sonido del piano y del órgano se entrelaza en el viento gris. Una melodía mágica parece flotar en las calles desiertas. \n Una monja anónima reza entre las notas del piano. \n \"Una oración simple no necesita ceremonias elaboradas, el gran Padre Dios sembrará esperanza para nosotros, así como nos otorgó enseñanzas de piedad.\""
  },
  Event_74165_Name = {
    Text = "Oración del órgano"
  },
  Event_74166_ChoiceDesc1 = {
    Text = "[Esquivar al monstruo]elige 1 objeto para transformarlo en una reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_74166_ChoiceDesc2 = {
    Text = "[Recoger la estrella]obtén la reliquia de plata\"(RelicConfig.Arg1)\", infecta\"(Skill.Arg2)\""
  },
  Event_74166_ChoiceDesc3 = {
    Text = "[Ignorar]obtener 25 sigilos negros"
  },
  Event_74166_Desc = {
    Text = "La lluvia de meteoros cae sobre la torre del reloj.\nUn cristal transparente cae justo al lado de tus pies, creando un pequeño cráter.\nTodavía estás rodeado por cuerpos corrosivos de todas las formas, como sombras retorcidas, rugiendo y gritando sin cesar.\nTú decides—"
  },
  Event_74166_Name = {
    Text = "Estrella caída"
  },
  Event_74167_ChoiceDesc1 = {
    Text = "[Frotar los ojos]obtiene 50 sigilos negros"
  },
  Event_74167_ChoiceDesc2 = {
    Text = "[Cerrar los ojos]obtiene 75 sigilos negros, infecta\"(Skill.Arg2)\""
  },
  Event_74167_Desc = {
    Text = "Una multitud de gatos negros y repulsivos se agolpa detrás de Yoliette, murmurando tonos desconocidos y emitiendo una amenaza maliciosa y secreta."
  },
  Event_74167_Name = {
    Text = "El susurro del gato"
  },
  Event_74168_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74168_Desc = {
    Text = "El tejido de baja calidad es algo áspero al tacto, pero ha sido cuidadosamente lavado y limpiado.  \nGuárdalo bien y espera el día en que pueda ser devuelto a su dueño.\n\n."
  },
  Event_74168_Name = {
    Text = "Máscara blanca"
  },
  Event_74169_ChoiceDesc1 = {
    Text = "[Mantener distancia]obtiene 25 sigilos negros"
  },
  Event_74169_ChoiceDesc2 = {
    Text = "[Mostrar compasión]obtén la reliquia de plata\"(RelicConfig.Arg1)\", infecta\"(Skill.Arg2)\""
  },
  Event_74169_Desc = {
    Text = "Se agolpan desde tus pies. \nEntre sus rostros borrosos y doloridos, ves tu sombra desgarrada. \n¿Realmente tienes el privilegio de juzgarlos?"
  },
  Event_74169_Name = {
    Text = "Reflejo de Pesadilla"
  },
  Event_7416_ChoiceDesc1 = {
    Text = "[Tira los fragmentos]tienes reliquia especial, infección con el síntoma llevado del sello:\"(EnchantConfig.Arg1)\"-síntoma: locura por disolución"
  },
  Event_7416_ChoiceDesc2 = {
    Text = "[Reparar fragmentos]Sin creación especial, infectar\"(Skill.Arg1)\", obtén infección\"(Skill.Arg2)\""
  },
  Event_7416_Desc = {
    Text = "El miembro pálido se movía lentamente ante ti. Se inclinó y acercó su brazo roto, y sus ojos entrecerrados por el dolor derramaban lágrimas blancas y yesosas.\n\"Solo falta... solo una pieza más, y podré...\""
  },
  Event_7416_Name = {
    Text = "Completar el cuerpo dañado"
  },
  Event_74170_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74170_Desc = {
    Text = [[
Tienes que intentar salvarlos. 
Pero no dejes que te conviertan.]]
  },
  Event_74170_Name = {
    Text = "Reflejo de Pesadilla"
  },
  Event_74171_ChoiceDesc1 = {
    Text = "[Desviar la mirada]aumenta Arg1 puntos de salud máxima"
  },
  Event_74171_ChoiceDesc2 = {
    Text = "[Mantener la mirada] 1 Tarjeta de comando aleatoria obtiene Inscripción: \"(EnchantConfig.Arg1)\", infectar 1 \"(Skill.Arg2)\""
  },
  Event_74171_Desc = {
    Text = "\"La llegada final ya ha ocurrido.\"\nTu corazón se aprieta y se contrae. \nEl tono seguro de Juliette sin duda contiene algún tipo de hipnosis y poder telepático. \n¿Cuál es la diferencia entre el propósito de Juliette en esta dimensión y la Juliette que conocías en el pasado? \nHay demasiados misterios y obstáculos. \nLevantas la vista para observar a Juliette, pero descubres que ella también te está mirando."
  },
  Event_74171_Name = {
    Text = "Mirada del Fin"
  },
  Event_74172_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74172_Desc = {
    Text = "Levantas la mano y golpeas torpemente las teclas ilusorias. \n Las teclas suenan en un tintineo entrelazado, cada nota es como una gota de rocío, clara y transparente, la técnica de interpretación no proviene de tus dedos. \n En un instante, ves unas manos invisibles y alargadas cubriendo el dorso de tu mano, subiendo y bajando con el avance de la interpretación. \n El tiempo parece detenerse, hasta el último eco de la melodía. \n Oyes un suspiro de satisfacción."
  },
  Event_74172_Name = {
    Text = "Sonata de Lamento"
  },
  Event_74173_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74173_Desc = {
    Text = "La conciencia que se transfiere con frecuencia no es estable, necesitas eliminar distracciones innecesarias. \nCentras tu atención en Jenkins que está frente a ti, y el sonido del gramófono se va atenuando gradualmente, disipándose en la niebla.\n"
  },
  Event_74173_Name = {
    Text = "Sonidos extraños en la torre del reloj"
  },
  Event_74174_ChoiceDesc1 = {
    Text = "[Buscar la fuente del sonido]obtiene la reliquia de plata «(RelicConfig.Arg1)», infecta «(Skill.Arg2)»"
  },
  Event_74174_ChoiceDesc2 = {
    Text = "[Recordar]Todos los Despertados recuperan 50 puntos de Locura, e infectan \"(Skill.Arg1)\""
  },
  Event_74174_ChoiceDesc3 = {
    Text = "[Ignorar el ruido]obtén 3 opciones de plegaria"
  },
  Event_74174_Desc = {
    Text = "Escuchaste el sonido distorsionado de la aguja del gramófono. \nLa aguja retorcida raspa lentamente sobre las ranuras espirales dañadas, emitiendo un escalofriante temblor."
  },
  Event_74174_Name = {
    Text = "Sonidos extraños en la torre del reloj"
  },
  Event_74175_ChoiceDesc1 = {
    Text = "[Tocar para él] Elige 1 Tarjeta de comando entre 3 para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_74175_ChoiceDesc2 = {
    Text = "[Escuchar la melodía]Por cada Despertado con un valor de locura de 50 o más, obtén 15 sellos negros"
  },
  Event_74175_ChoiceDesc3 = {
    Text = "[Salir]obtiene elección de 3 para 1 de oración"
  },
  Event_74175_Desc = {
    Text = "\"Querido John: \n    Recientemente me di cuenta de que han pasado varios años desde la última vez que nos deleitaste con tu interpretación al piano. \n    Este año tengo 81 años, y a medida que envejezco, más me doy cuenta del valor de los recuerdos de la juventud. \n    Si recibes esta carta, por favor, la próxima vez que pases por Londinium, detente frente a mi apartamento y ven a tocar una melodía.\""
  },
  Event_74175_Name = {
    Text = "Sonata de Lamento"
  },
  Event_74176_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74176_Desc = {
    Text = "El deseo de sobrevivir agita tu pecho, y no dudas en emitir la orden. \n Al esperar que rompas el cerco, al volverte a mirar, esa estrella ya ha sido sumergida en D-Slime. \n En medio del D-Slime que surge, se escucha una serie de sonidos agudos y rítmicos. \n Al tocar la superficie del D-Slime, una estrella en descomposición cae en tu palma."
  },
  Event_74176_Name = {
    Text = "Estrella caída"
  },
  Event_74177_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74177_Desc = {
    Text = "Recoges esa estrella, pero ha perdido su brillo en la palma de tu mano. \n De repente, una sensación de opresión te invade, un escalofrío recorre tu espalda. \n En un instante de vida o muerte, te giras para esquivar, logrando evitar un ataque feroz, pero aún así, una marca de dos pulgadas queda en tu brazo."
  },
  Event_74177_Name = {
    Text = "Estrella caída"
  },
  Event_74178_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74178_Desc = {
    Text = "Los dientes ocultos en los tentáculos rasgaron tu manga, y el líquido sanguíneo cayó en delgados hilos carmesí, deslizándose por el hueso de tu muñeca. \nNo puedes distinguir la mirada de Sarah, pero de su cráneo fracturado parecía surgir un rugido tembloroso de dolor."
  },
  Event_74178_Name = {
    Text = "Pesadilla recurrente"
  },
  Event_74179_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74179_Desc = {
    Text = "Miras a tu alrededor, moviéndote de un lado a otro, el sonido es como un ratón que juega al escondite contigo, a veces a la izquierda, a veces a la derecha, a veces lejos, a veces cerca.\nDas vueltas y más vueltas, pero el ruido se vuelve cada vez más ensordecedor, los extraños chirridos metálicos te sumergen en una creciente inquietud.\nDe repente, se te ocurre una idea, tocas tus bolsillos, aunque no encuentras la fuente del sonido, recoges un pequeño tesoro."
  },
  Event_74179_Name = {
    Text = "Sonidos extraños en la torre del reloj"
  },
  Event_7417_ChoiceDesc1 = {
    Text = "[Salir]perdiste (Arg1) puntos de vida, infectar\"(Skill.Arg2)\""
  },
  Event_7417_Desc = {
    Text = "\"Buen chico. Pero aún necesitas un pequeño castigo.\"\nLa risa suave de Daffodil se desvanece en la grieta dimensional"
  },
  Event_7417_Name = {
    Text = "Tiempo de pista"
  },
  Event_74180_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74180_Desc = {
    Text = "Desvías la mirada, evitando el contacto visual con ella. \nSin embargo, alguna fuerza hace que tu corazón lata con inquietud."
  },
  Event_74180_Name = {
    Text = "Mirada del Fin"
  },
  Event_74181_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74181_Desc = {
    Text = "Juliette se encontró contigo en una mirada.\n En el siguiente segundo, mostró una sonrisa completamente loca, como si se burlara de tu arrogancia e ignorancia.\n Sin embargo, esa sonrisa desapareció en un instante, y los demás no hicieron ningún comentario al respecto... parecía ser solo tu fantasma."
  },
  Event_74181_Name = {
    Text = "Mirada del Fin"
  },
  Event_7418_ChoiceDesc1 = {
    Text = "[Hay un objeto de misión 1, gana reliquia de oro\"(RelicConfig.Arg1)\"]"
  },
  Event_7418_ChoiceDesc2 = {
    Text = "[Hay un objeto de misión 2, gana reliquia de oro\"(RelicConfig.Arg1)\"]"
  },
  Event_7418_ChoiceDesc3 = {
    Text = "[Seleccionar 1 carta de comando aleatoria para obtener un sigilo:\"(EnchantConfig.Arg1)\"]"
  },
  Event_7418_Desc = {
    Text = "Evento 254 (en desarrollo), no es el efecto final"
  },
  Event_7418_Name = {
    Text = "Evento 254 (en desarrollo)"
  },
  Event_7419_ChoiceDesc1 = {
    Text = "[Enviar plegaria especial 1, gana aleatoriamente 1 carta de comando con plegaria:\"(EnchantConfig.Arg1)\"]"
  },
  Event_7419_ChoiceDesc2 = {
    Text = "[Enviar plegaria especial 2, gana aleatoriamente 1 carta de comando con plegaria:\"(EnchantConfig.Arg1)\"]"
  },
  Event_7419_ChoiceDesc3 = {
    Text = "[infección\"(Skill.Arg1)\"y\"(Skill.Arg2)\"，obtén una reliquia de oro\"(RelicConfig.Arg3)\"]"
  },
  Event_7419_Desc = {
    Text = "Evento 255 (en desarrollo), no es el efecto final"
  },
  Event_7419_Name = {
    Text = "Evento 255 (en desarrollo)"
  },
  Event_7420_ChoiceDesc1 = {
    Text = "[Esquivar la carta de mariposa] Elimina 2 cartas"
  },
  Event_7420_ChoiceDesc2 = {
    Text = "[Abrazar mariposa]obtén reliquia maldita\"(RelicConfig.Arg1)\",infección\"(Skill.Arg2)\""
  },
  Event_7420_ChoiceDesc3 = {
    Text = "[Salir]obtiene Arg1 sigilo negro"
  },
  Event_7420_Desc = {
    Text = "Una esquina, otra esquina; el camino tras los sabuesos infernales parece interminable.\nCon los tobillos adoloridos, la cabeza hinchada, en medio de la confusión vuelves a ver mariposas, sabes que son pensamientos delirantes, los murmullos del dominio. Ellas vuelan desde todas direcciones"
  },
  Event_7420_Name = {
    Text = "Délire éruptif"
  },
  Event_7421_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7421_Desc = {
    Text = "Presionas suavemente la campana. Suena unas pocas veces antes de caer en silencio. Se ha retirado—solo regresará en las pesadillas"
  },
  Event_7421_Name = {
    Text = "Campanilla del viento"
  },
  Event_7422_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7422_Desc = {
    Text = "El timbre suena suavemente y luego se silencia. Se ha retirado—solo regresará en pesadillas"
  },
  Event_7422_Name = {
    Text = "Campanilla del viento"
  },
  Event_7423_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7423_Desc = {
    Text = "\"Bien, eres cauteloso.\"\nUna voz distante sonó desde la campanilla.\n\"La cautela te dará una pequeña recompensa, pero solo eso.\""
  },
  Event_7423_Name = {
    Text = "Campanilla del viento"
  },
  Event_74245_ChoiceDesc1 = {
    Text = "[Salir]obtiene reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_74245_Desc = {
    Text = "rodando rodando, los dados bailan emocionados dentro del cubilete, hasta quedar exhaustos.\n\n\"Perdiste. Sin embargo, como recompensa por haberme divertido, aún puedes recibir un premio.\""
  },
  Event_74245_Name = {
    Text = "Mensaje de N"
  },
  Event_74246_ChoiceDesc1 = {
    Text = "[Cerrar la compuerta]Infecta «(Skill.Arg1)», aleatoriamente 1 carta de comando obtiene un sigilo: «(EnchantConfig.Arg2)»"
  },
  Event_74246_ChoiceDesc2 = {
    Text = "[Huir apresurado]infecta «(Skill.Arg1)», aleatoriamente 1 carta de comando obtiene un sello: «(EnchantConfig.Arg2)»"
  },
  Event_74246_ChoiceDesc3 = {
    Text = "[Ignorar]elegir 1 de 3 cartas de comando y obtener plegaria：\"(EnchantConfig.Arg1)\""
  },
  Event_74246_Desc = {
    Text = "Estás profundamente enredado en este laberinto de vapor y engranajes, con tuberías de bronce entrelazadas en la parte superior como una telaraña, y cada respiración agita una densa niebla de aceite.\nEl descontrolado dial mecánico se retuerce en la pared, y las agujas salpican chispas al atravesar la escala, como luciérnagas moribundas en un laboratorio victoriano. Las juntas remachadas filtran óxido de cobre, como la herida en descomposición de esta bestia de acero, mientras que tu reloj de bolsillo ya ha dejado de funcionar—el tiempo aquí no es más que una oración de engranajes entrelazados."
  },
  Event_74246_Name = {
    Text = "Ciudad de vapor"
  },
  Event_74247_ChoiceDesc1 = {
    Text = "[Apostar]Infectar con \"(Skill.Arg1)\", entrar en el juego"
  },
  Event_74247_ChoiceDesc2 = {
    Text = "[mejor dejarlo]obtén 25 el sigilo negro"
  },
  Event_74247_Desc = {
    Text = "En la profunda niebla negra de la esquina, una atmósfera asfixiante se extiende. \n En la niebla, dos antiguos y fríos dados aparecen silenciosamente, su superficie cubierta de símbolos indescifrables y patrones extraños. \n Yacen quietos sobre la pizarra húmeda, como si esperaran algún llamado desconocido. \n\"Sabes quién soy. ¿Quieres apostar?\""
  },
  Event_74247_Name = {
    Text = "Mensaje de N"
  },
  Event_74248_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74248_Desc = {
    Text = "\"Soñé con un cataclismo que lo arrasaba todo, ahogando el brillo del pasado. Me siento lleno de ira por la vida, y más aún por la desesperanza del futuro. Mi alma está desgarrada por el miedo, ojalá en este momento que está a punto de colapsar, ustedes puedan tener vigilancia y no permitan que esta terrible llegada caiga.\""
  },
  Event_74248_Name = {
    Text = "Últimas palabras incoherentes"
  },
  Event_74249_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74249_Desc = {
    Text = "El humo negro tiembla con desolación.\nActo seguido, los dados desaparecen en un abrir y cerrar de ojos.\n\nSolo queda una pregunta en tu mente:\n¿de qué están hechos estos dados?\n\n?"
  },
  Event_74249_Name = {
    Text = "Mensaje de N"
  },
  Event_7424_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7424_Desc = {
    Text = "Te das la vuelta y ves un par de zapatos, junto con una sombra borrosa de una figura humana. \n Parece ser un joven caballero. \n\"Disculpa la molestia, ¿has visto un par de zapatos Oxford negros?\"\n\"Tienes un par justo frente a ti.\"\n\"No, no... son de cuero de cabra, no de vaca. \n He estado atrapado en este museo de cera durante doce años, debe ser por los zapatos equivocados...\"\n La voz murmura, poco a poco se debilita."
  },
  Event_7424_Name = {Text = "pasos"},
  Event_74250_ChoiceDesc1 = {
    Text = "[Discernir la voz masculina]obtén aleatoriamente 3 cartas de comando y selecciona 1 para copiar"
  },
  Event_74250_ChoiceDesc2 = {
    Text = "[Distinguir la voz de la mujer] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_74250_ChoiceDesc3 = {
    Text = "[distinguir la voz del anciano]obtén 25 sigilos negros"
  },
  Event_74250_Desc = {
    Text = "Te encuentras de pie en un pantano oscuro. \n En la penumbra, oyes murmullos caóticos que llegan como una marea, algunos provienen de ancianos de edad avanzada, otros de niños que apenas hablan, algunos de mujeres ansiosas, y otros de hombres llenos de miedo inexplicable..."
  },
  Event_74250_Name = {
    Text = "Últimas palabras incoherentes"
  },
  Event_74251_ChoiceDesc1 = {
    Text = "[Avanzar]roba aleatoriamente 3 cartas de comando del mazo, elige 1 carta para eliminar y gana 75 el sigilo negro"
  },
  Event_74251_ChoiceDesc2 = {
    Text = "[Descansar]roba aleatoriamente 3 cartas de comando del mazo, selecciona 1 carta para copiar en su versión original y agrega la copia al mazo, obtén 25 sigilos negros"
  },
  Event_74251_ChoiceDesc3 = {
    Text = "[Mirar atrás]obtén 50 sigilos negros"
  },
  Event_74251_Desc = {
    Text = "Camina por las calles desiertas, tus pasos dejan profundas huellas en la ceniza.\n\nLas calles de la ciudad son como una telaraña, y tú eres la polilla atrapada."
  },
  Event_74251_Name = {
    Text = "Ciudad de las Nieblas"
  },
  Event_74252_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74252_Desc = {
    Text = "En el momento en que la compuerta de vapor se cierra con un estruendo, escuchas cómo tu sombra es triturada pulgada a pulgada por las roscas precisamente engranadas."
  },
  Event_74252_Name = {
    Text = "Ciudad de vapor"
  },
  Event_74253_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74253_Desc = {
    Text = "La escena repetida se actualiza continuamente frente a ti, no tienes escapatoria."
  },
  Event_74253_Name = {
    Text = "Ciudad de vapor"
  },
  Event_74254_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74254_Desc = {
    Text = "El tiempo es una coordenada inútil, la única cosa que esperas es la verdad."
  },
  Event_74254_Name = {
    Text = "Ciudad de vapor"
  },
  Event_74255_ChoiceDesc1 = {
    Text = "[Tres puntos]"
  },
  Event_74255_ChoiceDesc2 = {
    Text = "[Seis en punto]"
  },
  Event_74255_ChoiceDesc3 = {Text = "[Un punto]"},
  Event_74255_Desc = {
    Text = "¿Quién se atrevería a lanzar los dados que simbolizan desgracia y locura? \nTú, por supuesto. \nEliges—"
  },
  Event_74255_Name = {
    Text = "Mensaje de N"
  },
  Event_74256_ChoiceDesc1 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_74256_Desc = {
    Text = "rodando rodando, los dados bailan emocionados dentro del cubilete, hasta quedar exhaustos.\n\n\"Perdiste. Sin embargo, como recompensa por haberme divertido, aún puedes recibir un premio.\""
  },
  Event_74256_Name = {
    Text = "Mensaje de N"
  },
  Event_74257_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74257_Desc = {
    Text = [[
El camino por el que viniste es una oscuridad infinita y un caos inmenso. 
Ya no tienes tiempo para considerar tu destino; debes vencer el miedo y llegar a tu final antes de que caiga la sentencia.]]
  },
  Event_74257_Name = {
    Text = "Ciudad de las Nieblas"
  },
  Event_74258_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74258_Desc = {
    Text = "\"Cuando estoy sentado en la sombra del tiempo, siento la fría mano de la muerte acercándose poco a poco. El mundo fuera de la ventana se vuelve cada vez más oscuro, lleno de susurros de desastre. Temo el juicio que se avecina, la liquidación de nuestra ignorancia. Las calles están llenas de un aire siniestro, me preocupa que nuestro día de juicio esté por llegar. Nuestra civilización es inestable, como si estuviera a punto de ser devorada por la destrucción, atrapada en nuestra propia arrogancia estúpida.\""
  },
  Event_74258_Name = {
    Text = "Últimas palabras incoherentes"
  },
  Event_74259_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74259_Desc = {
    Text = "Salvarte de la muerte ya es un logro difícil, no deberías exigir más. \nLas sombras de los escombros y ruinas aún te llaman."
  },
  Event_74259_Name = {
    Text = "Ciudad de las Nieblas"
  },
  Event_7425_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de oración"
  },
  Event_7425_Desc = {
    Text = "\"¿Así es...? Muy interesante.\"\nElla guarda el cuestionario y te señala la dirección en la que se fueron los niños. Te vas apresuradamente, casi sin escuchar el susurro detrás de ti.\n\"Espero nuestra próxima reunión.\""
  },
  Event_7425_Name = {
    Text = "Evaluación psicológica"
  },
  Event_74260_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74260_Desc = {
    Text = "Estás bajo el dominio de una fuerza inmensa o un destino poderoso. Un breve descanso no puede cambiar esta situación, pero al menos puede dar fuerza a tus piernas cansadas para seguir adelante."
  },
  Event_74260_Name = {
    Text = "Ciudad de las Nieblas"
  },
  Event_74261_ChoiceDesc1 = {Text = "[Salir]"},
  Event_74261_Desc = {
    Text = "\"...la ciudad ya no es un refugio cálido, sino una tumba oculta que alberga terror y desesperación. Los sueños que alguna vez fueron vivos, ahora solo dejan fragmentos de miedo. No puedo seguir fingiendo ser valiente, el mundo ante mis ojos es como una pesadilla de la que no puedo despertar.\""
  },
  Event_74261_Name = {
    Text = "Últimas palabras incoherentes"
  },
  Event_74262_ChoiceDesc1 = {
    Text = "[Salir]obtiene reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_74262_Desc = {
    Text = "rodando rodando, los dados bailan emocionados dentro del cubilete, hasta quedar exhaustos.\n\n\"Perdiste. Sin embargo, como recompensa por haberme divertido, aún puedes recibir un premio.\""
  },
  Event_74262_Name = {
    Text = "Mensaje de N"
  },
  Event_7426_ChoiceDesc1 = {
    Text = "[Salir]aleatoriza 1 carta de comando para obtener oración: espejo"
  },
  Event_7426_Desc = {
    Text = "\"No te preocupes, ya he visto la respuesta en tus ojos. Tengo algunos asuntos que atender, así que me voy por ahora. Tú también tienes algo que resolver, ¿verdad? Mira, alguien viene a buscarte.\"\nTe das la vuelta, la figura de la iglesia de la luz del templo aparece al final del camino"
  },
  Event_7426_Name = {
    Text = "Compañero extraño V"
  },
  Event_7427_ChoiceDesc1 = {
    Text = "[Salir]aleatoriza 1 carta de comando para obtener oración: cálculo"
  },
  Event_7427_Desc = {
    Text = "\"Parece que aún no quieres abrirte a mí. Estoy decepcionado, pero no importa, todavía te ofreceré la sugerencia más amable: ¿qué es lo que realmente busca la Iglesia de la Linterna aquí?\"\n\"Vaya, parece que a alguien no le gusta que charlemos. Mira, alguien viene a buscarte.\"\nTe das la vuelta, la figura de los Portadores de linternas aparece al final del camino."
  },
  Event_7427_Name = {
    Text = "Compañero extraño V"
  },
  Event_7428_ChoiceDesc1 = {
    Text = "[Salir]aleatoriza 1 carta de comando para obtener oración: inspiración"
  },
  Event_7428_Desc = {
    Text = "\"Eres muy honesto, mereces un premio. Así que he decidido darte una pequeña sugerencia: ¿por qué, al llegar a la Villa de Lai, ya fuiste marcado por Él?\"\n\"Vaya, parece que a alguien no le gusta que charlemos. Mira, alguien viene a buscarte.\"\nTe das la vuelta, la figura de los Portadores de linternas aparece al final del camino."
  },
  Event_7428_Name = {
    Text = "Compañero extraño V"
  },
  Event_7429_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7429_Desc = {
    Text = "El ruido se desvanece, tus manos vacías, pero el momento ha sido capturado por la Llave de Plata"
  },
  Event_7429_Name = {
    Text = "Libro del Nada"
  },
  Event_7430_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7430_Desc = {
    Text = "En el caos, extiendes la mano y agarras algo con una textura extraña, que gradualmente toma forma"
  },
  Event_7430_Name = {
    Text = "Libro del Nada"
  },
  Event_7431_ChoiceDesc1 = {
    Text = "[Marcharse] Elige 1 Tarjeta de comando entre 3 para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7431_Desc = {
    Text = "\"¿Has oído hablar de la forma en que cazan las serpientes? Las serpientes solo pueden arrastrarse por el suelo, moviéndose en serpentina, por lo que no pueden acelerar y perseguir como un guepardo, ni pueden rodear a su presa como lo hace una manada de lobos. En contraste, las serpientes han aprendido a esperar en silencio.\"\n\"Esperan el momento en que la presa baje la guardia, y luego lanzan una emboscada, tragándola de un solo golpe.\""
  },
  Event_7431_Name = {
    Text = "Compañero extraño III"
  },
  Event_7432_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7432_Desc = {
    Text = "Parece haber sido perturbado, el pelaje brillante del gato negro deja solo un leve ardor en la punta de tus dedos, y luego desaparece en las profundidades de la niebla."
  },
  Event_7432_Name = {
    Text = "Desgracia del gato nocturno"
  },
  Event_7433_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7433_Desc = {
    Text = "Es solo el absurdo del grupo de fanáticos locos e irracionales"
  },
  Event_7433_Name = {
    Text = "Orden secreta · Parte inferior"
  },
  Event_7434_ChoiceDesc1 = {
    Text = "[Continuar escuchando]gana 3 elige 1 plegaria"
  },
  Event_7434_ChoiceDesc2 = {
    Text = "[Toser fuerte] elige 1 de 3 cartas de comando para obtener el sello: «(EnchantConfig.Arg1)», infecta «(Skill.Arg2)»"
  },
  Event_7434_Desc = {
    Text = "Las esquinas de la pared se han agrietado con muchas fisuras, serpenteando como venas. \n Junto a un leve zumbido, escuchas la voz profunda de un hombre que viene del otro lado. \n \"Distrito de Quentin 5, Distrito de Wellington 10, Distrito de Norman 15... \n Todo el material de este mes ha sido cargado y está listo para salir, número de carga I-0234... \n ... \n Además, gracias a esa gente de Misaq, el Distrito de White Chapel está actualmente bajo estado de sitio, hemos perdido nuestra mayor fuente de material.\""
  },
  Event_7434_Name = {
    Text = "Los muros tienen oídos"
  },
  Event_7435_ChoiceDesc1 = {
    Text = "[Ahuyentar cuervos]Obtén 20 sigilos negros, contagia\"(Skill.Arg2)\""
  },
  Event_7435_ChoiceDesc2 = {
    Text = "[Seguir Persiguiendo al Niño]Salir"
  },
  Event_7435_Desc = {
    Text = "Bajo tu intimidación, todos los cuervos volaron en todas direcciones, las alas negras que caían se convirtieron en una sustancia viscosa, goteando como el sigilo negro"
  },
  Event_7435_Name = {
    Text = "Mirada de Cuervo Negro"
  },
  Event_7436_ChoiceDesc1 = {
    Text = "[Dejar de resistir]eliminar 1 carta de comando，obtener Arg1 el sigilo negro"
  },
  Event_7436_ChoiceDesc2 = {
    Text = "[Retirar las manos]"
  },
  Event_7436_Desc = {
    Text = "Una nueva máquina de escribir.\nTiene teclas únicas, tan elegantes y precisas como un microscopio.\nCurioso, pusiste tus manos sobre ella, pero comenzaron a volar sobre el teclado, cada vez más rápido"
  },
  Event_7436_Name = {
    Text = "Chispa de inspiración"
  },
  Event_7437_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7437_Desc = {
    Text = "Solo son seres luchando por sobrevivir, buscando un trozo de madera flotante para descansar...\nSuspiras, dejando que el líquido negro de la cola de la mariposa fluya por tu mejilla"
  },
  Event_7437_Name = {
    Text = "Mariposa de Líquido Negro"
  },
  Event_7438_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7438_Desc = {
    Text = "Aceptas la llamada de la escuela, la voz familiar te tranquiliza. Te animas y sigues adelante"
  },
  Event_7438_Name = {
    Text = "Punto de contacto"
  },
  Event_7439_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7439_Desc = {
    Text = "Aceptas la llamada de la escuela, la voz familiar te tranquiliza. Te animas y sigues adelante"
  },
  Event_7439_Name = {
    Text = "Punto de contacto"
  },
  Event_7440_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7440_Desc = {
    Text = "Tu duda se pierde en el aire, sin respuesta, la luz cálida entra por la ventana, como un recuerdo"
  },
  Event_7440_Name = {
    Text = "Recuerdos volcánicos"
  },
  Event_7441_ChoiceDesc1 = {
    Text = "[Recoger]infección\"(Skill.Arg1)\"，obtienes reliquia de plata\"(RelicConfig.Arg2)\""
  },
  Event_7441_ChoiceDesc2 = {
    Text = "[Indecisión]Obtén 25 el sigilo negro"
  },
  Event_7441_Desc = {
    Text = "En un barril en la esquina del callejón, flota un objeto de colores extraños. Su aparición anómala parece advertirte, \"No lo toques.\""
  },
  Event_7441_Name = {
    Text = "Objeto flotante en el cubo"
  },
  Event_7442_ChoiceDesc1 = {
    Text = "[dejarlo a ella]obtén 3 de 1 reliquia de plata"
  },
  Event_7442_ChoiceDesc2 = {
    Text = "[Hay un pequeño problema]gana reliquia de plata\"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\"，infección dos veces\"(Skill.Arg3)\""
  },
  Event_7442_Desc = {
    Text = "\"Aquí está la comunicación de Mitag, soy Erica. Se han detectado fluctuaciones anormales en el índice gnóstico del despertador Lotan, ¿necesitas apoyo?\""
  },
  Event_7442_Name = {
    Text = "Comunicación de apoyo"
  },
  Event_7443_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7443_Desc = {
    Text = "Cediste a los maliciosos susurros en tu oído. Un dolor agudo, afilado como una aguja, se retuerce en lo profundo de tu cráneo.\n\n\"Para—por favor para—hice lo que pediste—hazlo parar—\"\n\nTe aferras la cabeza en agonía, escuchando solo la lejana y burlona risa de los cuervos."
  },
  Event_7443_Name = {
    Text = "Canto de la Manada de Cuervos"
  },
  Event_7444_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7444_Desc = {
    Text = "Colocado en esta posición, hay dos posibilidades: algo ignorado o algo preciado. Si es lo segundo, déjalo al dueño original"
  },
  Event_7444_Name = {
    Text = "Núcleo de plata solitario"
  },
  Event_7445_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7445_Desc = {
    Text = "La mayor felicidad es la ignorancia"
  },
  Event_7445_Name = {
    Text = "Mirar furtivamente"
  },
  Event_7446_ChoiceDesc1 = {
    Text = "[Generar monstruo común]"
  },
  Event_7446_ChoiceDesc2 = {
    Text = "[Generar terreno vacío]"
  },
  Event_7446_ChoiceDesc3 = {
    Text = "[Generar vacío]"
  },
  Event_7446_Desc = {
    Text = "Veamos qué se puede generar"
  },
  Event_7446_Name = {Text = "[Empacado]"},
  Event_7447_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7447_Desc = {
    Text = "\"Tranquila,» Ramona te golpeó la cabeza, «solo son fragmentos del pasado. No sé quién los dejó en este pasaje dimensional.»\nDe hecho, hay un aire de nostalgia"
  },
  Event_7447_Name = {
    Text = "Fragmento de recuerdo: Whisky"
  },
  Event_7448_ChoiceDesc1 = {
    Text = "[Recoger] mejora 1 reliquia de plata a una reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_7448_ChoiceDesc2 = {
    Text = "[Desecharlos]obtén una creación de oro\"(RelicConfig.Arg1)\",infección\"(Skill.Arg2)\"y\"(Skill.Arg3)\""
  },
  Event_7448_ChoiceDesc3 = {
    Text = "[Observar detenidamente] obtiene 25 marcas negras"
  },
  Event_7448_Desc = {
    Text = "Aquí hay muchos núcleos de plata rotos.\nOpacos, rotos... claramente no son de alta calidad.\nQuizás son una de las razones por las que estas figuras de cera pueden \"cobrar vida\".\nIncluso el núcleo de plata más tosco puede crear milagros"
  },
  Event_7448_Name = {Text = "Alma Presa"},
  Event_7449_ChoiceDesc1 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7449_Desc = {
    Text = "Kum ya ha dado todo lo que podía.\nAhora, te toca a ti hacer que su sacrificio no sea en vano"
  },
  Event_7449_Name = {
    Text = "Residuo de calor"
  },
  Event_7450_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7450_Desc = {
    Text = "Que la nieve y el viento les den paz eterna"
  },
  Event_7450_Name = {
    Text = "Reliquias de los antiguos"
  },
  Event_7451_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7451_Desc = {
    Text = "Aún pareces tenaz, y en tu canto sigues a ti mismo.\nNo crees en los murmullos a tu alrededor, solo confías en la razón humana.\nSin embargo... el día en que el sólido suelo que te sustenta esté cubierto por una espesa masa negra, sacar tus ojos como objeto de observación será tu única opción en el ocaso de tu vida."
  },
  Event_7451_Name = {
    Text = "Canto de la Manada de Cuervos"
  },
  Event_7452_ChoiceDesc1 = {
    Text = "[Salir]de 3 cartas de comando selecciona 1 para obtener oración:\"(EnchantConfig.Arg1)\""
  },
  Event_7452_Desc = {
    Text = "Tiraste de Kum bruscamente, esquivando por poco un golpe. Ella te asintió en agradecimiento y volvió a cargar contra el sujeto de prueba"
  },
  Event_7452_Name = {Text = "Coliseo"},
  Event_7453_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7453_Desc = {
    Text = "Ding ding dang...\nLas monedas caen en la cartera, resonando melodiosamente.\nLa cartera mastica satisfecha y eructa.\nSe rinde a tu generosidad y baja la guardia.\nAhora, está a tu servicio"
  },
  Event_7453_Name = {
    Text = "Billetera glotona"
  },
  Event_7454_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7454_Desc = {
    Text = "La moneda de bronce cayó en un abismo sin fondo, sin hacer ruido.\nEsperaste pacientemente cinco minutos. La billetera gimió y finalmente escupió un charco de líquido negro.\nEs su protesta silenciosa"
  },
  Event_7454_Name = {
    Text = "Billetera glotona"
  },
  Event_7455_ChoiceDesc1 = {
    Text = "[Mirar a lo lejos]"
  },
  Event_7455_ChoiceDesc2 = {
    Text = "[Escuchar Atentamente]"
  },
  Event_7455_Desc = {
    Text = "Celeste movió el compás en su mano, no dijo nada, pero se escuchó suavemente una canción.\nLa canción de los marineros cruzó el tiempo entrelazándose aquí, una tumultuosa pero poderosa canción del barco te guía, llevándote a mirar hacia el otro extremo del barco"
  },
  Event_7455_Name = {
    Text = "Canción del barco"
  },
  Event_7456_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7456_Desc = {
    Text = "Interrumpiste esta pequeña lección. \n Desde los gestos al tocar el piano hasta la teoría musical básica, no tuviste piedad al comentar uno por uno. \n La música se detuvo de repente, el chico y el maestro te miraron al unísono, con la misma sonrisa engañosa en sus rostros. \n 133, 355, 244... \n La música volvió a sonar, igualmente errónea. \n Resulta que no podían oír nada."
  },
  Event_7456_Name = {
    Text = "Clases de piano"
  },
  Event_7457_ChoiceDesc1 = {Text = "[Guardar]"},
  Event_7457_Desc = {
    Text = "Las marcas negras encontradas en el dominio pueden ser sacrificadas a d-marca a cambio de proyecciones espirituales como reliquias. Se desvanecerán rápidamente a lodo negro después de salir de la zona actual"
  },
  Event_7457_Name = {
    Text = "Marca negra"
  },
  Event_7458_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7458_Desc = {
    Text = "Por ahora, encontrar a esa persona misteriosa es más importante. Pensando esto, Ramona se fue rápidamente"
  },
  Event_7458_Name = {
    Text = "El oído del otro"
  },
  Event_7459_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7459_Desc = {
    Text = "Deja que tu conciencia se libere, sigue el camino de la oración hacia las profundidades del mar.\nViste la ciudad dorada sumergida, las esculturas inmortales, y finalmente, te encontraste con los ojos brillantes en la oscuridad...\n\"Los que no tienen sangre divina... márchense, márchense.\""
  },
  Event_7459_Name = {
    Text = "Plegaria del Sueño"
  },
  Event_7460_ChoiceDesc1 = {
    Text = "[Salir]selecciona 1 reliquia maldita, infecta\"(Skill.Arg1)\""
  },
  Event_7460_Desc = {
    Text = "Ramona atravesó la garganta del sujeto de prueba con su espada, Kum arrojó el cuerpo sin vida y corrió hacia el siguiente objetivo"
  },
  Event_7460_Name = {Text = "Coliseo"},
  Event_7461_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7461_Desc = {
    Text = "Los cuervos se arrancaban las plumas, como los humanos se devoran a sí mismos.\nEn este mundo de miedo, esto es común. No puedes salvar a todos"
  },
  Event_7461_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7462_ChoiceDesc1 = {
    Text = "[Calmar a Kum]"
  },
  Event_7462_ChoiceDesc2 = {
    Text = "[Llamar a Kum]"
  },
  Event_7462_Desc = {
    Text = "El enorme monstruo rugía con todas sus fuerzas hacia la pequeña figura humana, intentando despertar a sus antiguos compañeros. Pero sus cuerdas vocales dañadas solo producían un sonido gutural y extraño"
  },
  Event_7462_Name = {
    Text = "Llamada de la amistad"
  },
  Event_7463_ChoiceDesc1 = {
    Text = "[Salir]buscar el reflector"
  },
  Event_7463_ChoiceDesc2 = {
    Text = "[Entrar en la niebla]Pierde Arg2 de vida"
  },
  Event_7463_Desc = {
    Text = "Delante hay una densa niebla negra, entrar imprudentemente traerá desastres.\nQuizás deberías encontrar un \"faro\" para disipar la niebla"
  },
  Event_7463_Name = {
    Text = "desconocido"
  },
  Event_7464_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7464_Desc = {
    Text = "\"¿Una mandíbula que cruje como la tuya? Nunca la había visto en mi vida.\"\nRechazaste la grosera petición del señor Mandíbula. Estaba decepcionado, pero aún mantenía su compostura. \nPara agradecerte por escuchar pacientemente, te dio un pequeño regalo"
  },
  Event_7464_Name = {Text = "Crujido"},
  Event_7465_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7465_Desc = {
    Text = "Aceptaste esta extraña petición y llevaste contigo al señor Mandíbula. \n Él yace en tu bolsillo, crujendo sin parar. Según la traducción de tu compañero, sus palabras contienen gratitud, nostalgia y arrepentimiento. \n En cuanto a por qué se ha convertido en esta forma, el señor Mandíbula no quiere hablar más, solo dice: \n\"Sabes, cuando miras a @2, @2 también te mira.\""
  },
  Event_7465_Name = {Text = "Crujido"},
  Event_7466_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7466_Desc = {
    Text = "Se deslizó en tu bolso como una seda, y con el ligero aumento de peso, pareció que escuchaste un leve agradecimiento.\nDespués, no hubo más sonido"
  },
  Event_7466_Name = {
    Text = "Espíritu del Caos"
  },
  Event_7467_ChoiceDesc1 = {
    Text = "[Proseguir]"
  },
  Event_7467_Desc = {
    Text = "Ka-chac. \nInsertas la llave en la cerradura y empujas suavemente la puerta. \nTodo el proceso de abrir la puerta es muy fluido, lo que te da confianza para la investigación que sigue"
  },
  Event_7467_Name = {
    Text = "Puerta oxidada"
  },
  Event_7468_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7468_Desc = {
    Text = "Esa voz rió profundamente, el líquido bajo tus pies formó ondas. \n\"Pronto entenderás que, aparte de la muerte, no hay nada que debas hacer.\""
  },
  Event_7468_Name = {
    Text = "No querrás encontrar"
  },
  Event_7469_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7469_Desc = {
    Text = "Dejaste ir ese recuerdo, sacando tu conciencia del consuelo ilusorio"
  },
  Event_7469_Name = {
    Text = "Sumergirse en el pasado"
  },
  Event_7470_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7470_Desc = {
    Text = "Solo un breve sueño, sin consuelo, ¿cómo pasarás la larga noche?"
  },
  Event_7470_Name = {
    Text = "Sumergirse en el pasado"
  },
  Event_7471_ChoiceDesc1 = {
    Text = "[Recoger la foto]elige 1 de 3 cartas de comando y obtienes sello:\"(EnchantConfig.Arg1)\""
  },
  Event_7471_Desc = {
    Text = "Esta es una serie de fotos grupales.\nLas personas desanimadas están agachadas detrás de la reja de hierro, con rostros llenos de sufrimiento.\nUna de las fotos llamó tu atención. Debe ser una joven delgada, con el rostro en blanco.\nEse ser grotesco y profano se enrosca alrededor de su cuerpo en círculos.\nNo puedes ver su cara, pero en tu imaginación, debería estar sin expresión."
  },
  Event_7471_Name = {
    Text = "registrar fielmente"
  },
  Event_7472_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7472_Desc = {
    Text = "Eso es el cadáver de un pájaro"
  },
  Event_7472_Name = {
    Text = "Enjambre de cuervos enardecidos"
  },
  Event_7473_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7473_Desc = {
    Text = "Rechazas fríamente la petición del pianista.\nEl pianista está muy decepcionado. Se arranca la otra oreja y las arroja por la ventana.\n\"De todos modos, no las necesito.\"\nEl pianista melancólico toca una serie de notas tristes"
  },
  Event_7473_Name = {
    Text = "Presta atención"
  },
  Event_7474_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7474_Desc = {
    Text = "El llanto del espíritu del Caos se vuelve más agudo, hasta convertirse en un grito ensordecedor que resuena a tu alrededor.\nCon tu ofrenda y su tristeza inescapable, se hunde de nuevo en el lodo"
  },
  Event_7474_Name = {
    Text = "Espíritu del Caos"
  },
  Event_7475_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7475_Desc = {
    Text = "Este es un pasaje unidireccional, no puedes volver a la entrada por él"
  },
  Event_7475_Name = {Text = "Pasaje"},
  Event_7476_ChoiceDesc1 = {
    Text = "[Salir]obtener creación\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7476_Desc = {
    Text = "\"Entonces, cierra los ojos y siente sus pasos acercándose.\"\nCierras los ojos, y de repente, el sonido de una bestia extraña resuena en tus oídos.\nAbres los ojos asustado, y el hombre ya no está"
  },
  Event_7476_Name = {
    Text = "Compañero extraño I"
  },
  Event_7477_ChoiceDesc1 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7477_Desc = {
    Text = "\"Qué lástima.\"\nEl hombre, con voz baja, ajustó sus gafas.\n\"Pero, si no han oído hablar de él, ¿por qué vienen aquí a medianoche?\"\nSin esperar respuesta, el hombre se alejó"
  },
  Event_7477_Name = {
    Text = "Compañero extraño I"
  },
  Event_7478_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7478_Desc = {
    Text = "Caminas con paso firme, avanzando.\nUn paso, dos pasos, tres pasos...\nLos pasos detrás de ti se desvanecen en la oscuridad.\nVolverás a encontrarlos"
  },
  Event_7478_Name = {Text = "Oxford"},
  Event_7479_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7479_Desc = {
    Text = "Te inclinaste y levantaste la bandeja de la mesa, convirtiéndote en el guardia de la princesa.\n¿Quién es la princesa afortunada? Tu compañero más fiel.\n\"Si me tiras el té en la cara, olvídate de mis notas de clase el próximo mes.\"\nEsa es la advertencia de la princesa"
  },
  Event_7479_Name = {
    Text = "Falso por verdadero"
  },
  Event_7480_ChoiceDesc1 = {
    Text = "[Escuchar en silencio]Aumenta aleatoriamente la calidad del sigilo de 1 carta"
  },
  Event_7480_ChoiceDesc2 = {
    Text = "[Ella es] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7480_Desc = {
    Text = "El grito de Sara resonó en tu mente, una voz sutil y algo familiar surgió de la nada, susurrando débilmente \"hermana Sasa\", \"hermana Sasa\".\n\"¿Dónde estás, hermana Sasa?\""
  },
  Event_7480_Name = {
    Text = "\"Hermana Sasha\""
  },
  Event_7481_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7481_Desc = {
    Text = "'... De hecho, encuentro cierto sentido en lo que dices, pero el deseo no puede ayudarte a resolver el cuerpo disuelto. Mejor hagamos algo práctico.'"
  },
  Event_7481_Name = {
    Text = "Regla de Logan"
  },
  Event_7482_ChoiceDesc1 = {
    Text = "[Gana 100 el sigilo negro]"
  },
  Event_7482_ChoiceDesc2 = {
    Text = "[2 Tarjetas de comando aleatorias obtienen Inscripción: \"(EnchantConfig.Arg1)\"]"
  },
  Event_7482_Desc = {
    Text = "Formada por conocimiento estable, tal vez puedan traer una melodía armoniosa"
  },
  Event_7482_Name = {Text = "Disonancia"},
  Event_7483_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7483_Desc = {
    Text = "\"Es un fragmento de memoria de alguien que ha estado en esta dimensión,\" respondió Ramona, \"Es fácil encontrarse con esto al viajar entre dimensiones. Ten cuidado de no confundirlo con tus propios recuerdos.\""
  },
  Event_7483_Name = {
    Text = "Fragmento de recuerdo: Whisky"
  },
  Event_7484_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7484_Desc = {
    Text = "Sigue el ritmo de tu corazón, persigue el brillo. No se separarán, como nadie puede distinguir el día de la noche"
  },
  Event_7484_Name = {
    Text = "Atrio izquierdo"
  },
  Event_7485_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7485_Desc = {
    Text = [[
Sigues acariciando esas manos inquietas, tratando de calmarlas.
En poco tiempo, tu mundo se vuelve completamente tranquilo.
El amor siempre es recompensado]]
  },
  Event_7485_Name = {
    Text = "Marisma Oscura"
  },
  Event_7486_ChoiceDesc1 = {
    Text = "[Luchar]Infectar\"(Skill.Arg1)\"、recibir reliquia de plata\"(RelicConfig.Arg2)\""
  },
  Event_7486_ChoiceDesc2 = {
    Text = "[Rendir]infectar\"(Skill.Arg1)\"，obtener reliquia de plata\"(RelicConfig.Arg2)\""
  },
  Event_7486_ChoiceDesc3 = {
    Text = "[estar alerta]obtén 25 el sigilo negro"
  },
  Event_7486_Desc = {
    Text = "Tu mente se llena de impurezas, una sensación de suciedad muy clara.\nEl líquido turbio y maloliente se filtra y ocupa todos tus pensamientos, el dolor cubre tu rostro lleno de miedo, te sumerges en un ciclo interminable de pesadillas del que no puedes escapar"
  },
  Event_7486_Name = {
    Text = "Cráneo perforado"
  },
  Event_7487_ChoiceDesc1 = {
    Text = "[Es el espejo ritual de Memphis]"
  },
  Event_7487_ChoiceDesc2 = {
    Text = "[Es la brújula direccional]"
  },
  Event_7487_ChoiceDesc3 = {
    Text = "[No he perdido nada]"
  },
  Event_7487_Desc = {
    Text = "\"Pionero que atraviesa dimensiones.\"\n\nUna voz anciana susurra en tu oído, como si viniera de tiempos prehistóricos, atravesando eras. \n\nEn medio de la tensión extrema, escuchas una pregunta familiar. \n\n\"¿Qué es eso redondo que te permite robar al comienzo de la ronda?\""
  },
  Event_7487_Name = {
    Text = "Voces del más allá"
  },
  Event_7488_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7488_Desc = {
    Text = "\"No estoy en un centro de reciclaje,\"murmuró Dorr mientras aceptaba,\"bueno, al menos puedo extraer algo útil.\""
  },
  Event_7488_Name = {Text = "Placa"},
  Event_7489_ChoiceDesc1 = {
    Text = "Obtiene un sello normal aleatorio"
  },
  Event_7490_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7490_Desc = {
    Text = "Lees las páginas manchadas y rotas, \"gemelos\", \"inmersión\", \"sacrificio\", \"ineficaz\"...\nConceptos fragmentados y textos difíciles de entender, solo tu cerebro hinchado prueba que alguna vez leíste esta página de basura"
  },
  Event_7490_Name = {
    Text = "Orden secreta · Parte inferior"
  },
  Event_7491_ChoiceDesc1 = {
    Text = "[¿Qué precio está dispuesto a pagar?]Mejora al azar la calidad de 1 carta"
  },
  Event_7491_ChoiceDesc2 = {
    Text = "[Invítalos a un Bloody Mary caducado] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7491_Desc = {
    Text = "\"Bienvenido, mi valioso invitado. Siéntase libre de elegir, toda esta variedad está aquí esperando por usted.\"\n\"Eh, disculpe, ¿es usted... la hermana gemela de la señora Dafdell?\"\n\"Soy la misma Dafdell, ¿puede decirme, querido invitado, qué le trae por aquí hoy...?\"\n\"Lo siento, lo siento, usted se ve aún más encantadora que antes, no la reconocí. ¿Recuerda? Hace veinte años, usted ahuyentó a un extraño de mi bar... Ayer, la pesadilla recurrente regresó, ocupó el bar, trayendo a sus congéneres, en grandes cantidades...\""
  },
  Event_7491_Name = {
    Text = "Fragmento de recuerdo: Sueños del pasado"
  },
  Event_7492_ChoiceDesc1 = {
    Text = "[Ahuyentar cuervos]Obtén 30 sigilos negros, contagia\"(Skill.Arg2)\"，continúa eligiendo"
  },
  Event_7492_ChoiceDesc2 = {
    Text = "[Seguir Persiguiendo al Niño]Salir"
  },
  Event_7492_Desc = {
    Text = "El segundo cuervo se fue, y su pluma de la cola mostró un destello blanco mientras batía, como si fuera un hueso blanco."
  },
  Event_7492_Name = {
    Text = "Mirada de Cuervo Negro"
  },
  Event_7493_ChoiceDesc1 = {
    Text = "[Apostar]Infectar con \"(Skill.Arg1)\", entrar en el juego"
  },
  Event_7493_ChoiceDesc2 = {
    Text = "[mejor dejarlo]obtén 25 el sigilo negro"
  },
  Event_7493_Desc = {
    Text = "\"¿Quieres apostar? ¡Adivina nuestros puntos! ¡Solo un pequeño precio!\"\nLos dados abandonados zumban ruidosamente, como si te hablaran.\n\"¡Lánzame! ¡Lánzame!\"\n\"¡Solo una vez! ¡La última vez!\"\nEstá bien, solo una vez—\nTomas una ficha. Decides—"
  },
  Event_7493_Name = {
    Text = "Juego sin fin"
  },
  Event_7494_ChoiceDesc1 = {
    Text = "[Resistir pensamientos malignos]obtienes reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_7494_ChoiceDesc2 = {
    Text = "[Abrazar pensamientos malignos]obtienes reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_7494_ChoiceDesc3 = {
    Text = "[Despertar]gana 25 el sigilo negro"
  },
  Event_7494_Desc = {
    Text = [[
Los pensamientos maliciosos se convierten en cuchillos, como afilados colmillos.
Ellos desgarran la cordura que se debilita en el dominio, devoran la voluntad que queda, igual que los males que la realidad te impone]]
  },
  Event_7494_Name = {
    Text = "Pensamiento Ilusorio"
  },
  Event_7495_ChoiceDesc1 = {
    Text = "[Luchar con todas las fuerzas]eliminar 1 carta de comando, obtener Arg1 el sigilo negro"
  },
  Event_7495_ChoiceDesc2 = {
    Text = "[Encender la telaraña]copiar 1 carta de comando, infectar con \"(Skill.Arg1)\""
  },
  Event_7495_ChoiceDesc3 = {
    Text = "[Esperar en silencio] elige 1 de 3 cartas de comando y obtiene el sello: «(EnchantConfig.Arg1)»"
  },
  Event_7495_Desc = {
    Text = "Hilos finos se enredan alrededor de ti, en este momento, te has convertido en la presa de dominio"
  },
  Event_7495_Name = {Text = "Enredado"},
  Event_7496_ChoiceDesc1 = {
    Text = "[Destinatario: ∞]Infectar\"(Skill.Arg1)\""
  },
  Event_7496_ChoiceDesc2 = {
    Text = "[Destinatario: Yo mismo]Eliminar 1 carta"
  },
  Event_7496_ChoiceDesc3 = {
    Text = "[Destinatario: maestro]obtener 25 el sigilo negro"
  },
  Event_7496_Desc = {
    Text = "Él le otorgó a los caminantes del dominio una oportunidad: una oportunidad de conectar con lo desconocido.\nUnas hojas de papel desgastadas, una máquina de escribir que emana tinta, y un destinatario desconocido y unidireccional.\nLa voluntad puede decidir a dónde se transmitirá tu mensaje"
  },
  Event_7496_Name = {
    Text = "Confesión unilateral"
  },
  Event_7497_ChoiceDesc1 = {
    Text = "[Aceptar con agrado]"
  },
  Event_7497_ChoiceDesc2 = {
    Text = "[Rechazar firmemente]"
  },
  Event_7497_Desc = {
    Text = "En el entorno vacío resuenan susurros.\n\"Oh, ese tonto, el famoso jugador que siempre dice 'o gano o muero', un inútil, mantente alejado de él.\"\nUna sombra delgada y desanimada te lanza unas monedas, cuyo sonido metálico llega a tu palma.\n\"Una partida.\""
  },
  Event_7497_Name = {
    Text = "Jugador famoso"
  },
  Event_7498_ChoiceDesc1 = {
    Text = "[Estamos todos bien] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7498_ChoiceDesc2 = {
    Text = "[¿Quién eres?] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7498_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7498_Desc = {
    Text = "La máquina de escribir escupe tinta de manera abrupta, con tantos signos de exclamación que resultan deslumbrantes. \n\"¿Doll, estás bien??? ¿Por qué el Guardián del secreto desapareció y tú también? ¡Por favor, envía un mensaje si estás a salvo! ¡Si seguimos esperando, el cabello de William se va a caer por completo!\""
  },
  Event_7498_Name = {
    Text = "Comunicación de emergencia"
  },
  Event_7499_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7499_Desc = {
    Text = "Al colocar la última pieza de yeso, ella soltó una risa aguda; una nube oscura se elevó y su figura flotante se desvaneció de tu vista"
  },
  Event_7499_Name = {
    Text = "Completar el cuerpo dañado"
  },
  Event_7500_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7500_Desc = {
    Text = "Sacas la llave de plata y la sostienes con devoción. Una luz tenue te envuelve.\nEn el silencio, solo queda un suspiro"
  },
  Event_7500_Name = {
    Text = "Ojo de contemplación"
  },
  Event_7501_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7501_Desc = {
    Text = "Las miradas que quedan aún te observan, las células de la carne bajo tu piel gritan locamente y huyen, los vasos sanguíneos se retuercen bajo la piel como insectos.\nSientes una corriente de poder fluyendo, estallando en las extrañas deformidades de tus extremidades"
  },
  Event_7501_Name = {
    Text = "Ojo de contemplación"
  },
  Event_7502_ChoiceDesc1 = {
    Text = "[Evitar mirada]Despertar aleatoriamente 1 entidad despierta"
  },
  Event_7502_ChoiceDesc2 = {
    Text = "[Mirada intensa]selecciona 1 despertador, y reduce su coste de consumo de carta de despertar en 2 puntos. Infección\"(Skill.Arg1)\""
  },
  Event_7502_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7502_Desc = {
    Text = "El túnel dimensional conecta miles de universos, y en el más alto pasaje, innumerables ojos observan a los que se deslizan"
  },
  Event_7502_Name = {Text = "Su mirada"},
  Event_7503_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7503_Desc = {
    Text = "Demasiado caótico, demasiado caótico.\nTodos los pensamientos fueron arrastrados por el río del pensamiento, llevados por la corriente.\nEn el valle del cerebro, solo quedaban confusión y dolor"
  },
  Event_7503_Name = {
    Text = "Chispa de inspiración"
  },
  Event_7504_ChoiceDesc1 = {Text = "[Guardar]"},
  Event_7504_Desc = {
    Text = "En la d-baba sobresaturada parece haber ciertas sustancias... observa con la llave de plata, transfórmalo en tu propia fuerza"
  },
  Event_7504_Name = {
    Text = "Punto de extracción"
  },
  Event_7505_ChoiceDesc1 = {
    Text = "[Ahuyentar cuervos]Obtén 35 sigilos negros, contagia\"(Skill.Arg2)\"，continúa eligiendo"
  },
  Event_7505_ChoiceDesc2 = {
    Text = "[Seguir Persiguiendo al Niño]Salir"
  },
  Event_7505_Desc = {
    Text = "Un cuervo se fue, dejando caer una pluma negra lentamente"
  },
  Event_7505_Name = {
    Text = "Mirada de Cuervo Negro"
  },
  Event_7506_ChoiceDesc1 = {
    Text = "[Confirmar]"
  },
  Event_7506_Desc = {
    Text = "Este es el campo de batalla del abismo, donde se necesita tanto valor como sabiduría.\n\nAfina tu vista, observa a tu enemigo, no necesitas derrotarlos a todos, solo a su líder"
  },
  Event_7506_Name = {
    Text = "Prueba de los Asuras"
  },
  Event_7507_ChoiceDesc1 = {
    Text = "[Conectar] recuperar Arg2 puntos de vida"
  },
  Event_7507_Desc = {
    Text = "Exploras en la niebla, de repente, el emblema en tu pecho emite un débil resplandor plateado. ¿Quién te llama desde el comunicador?"
  },
  Event_7507_Name = {
    Text = "Punto de contacto"
  },
  Event_7508_ChoiceDesc1 = {Text = "[Seguirlo]"},
  Event_7508_ChoiceDesc2 = {Text = "[Saludar]"},
  Event_7508_Desc = {
    Text = "Tic. Tic. Tic.\nUna figura blanca avanza lentamente en la niebla, como un barco navegando hacia la noche silenciosa.\nDesde atrás, parece un chico.\nEscuchas sus pasos cansados y tomas una decisión"
  },
  Event_7508_Name = {
    Text = "Ceremonia final I"
  },
  Event_7509_ChoiceDesc1 = {
    Text = "[Aceptar con gusto]"
  },
  Event_7509_ChoiceDesc2 = {
    Text = "[Desconfiar]"
  },
  Event_7509_Desc = {
    Text = "El Cuerpo de fusión cae gritando, y te sorprende descubrir que Clementine está detrás de él. \n \"Vine a despedirme\", ante tus preguntas, ella no responde, \"Para expresar mi agradecimiento, puedo darte algunas pistas. Sin embargo... eso requerirá tu confianza. \n Déjame hipnotizarte y sabrás todo lo que sé.\" \n ¿Puedes confiar en ella? \n \"Ten cuidado\", advierte Ramona, \"ella no puede tener otra intención.\""
  },
  Event_7509_Name = {
    Text = "Terapia de hipnosis"
  },
  Event_7510_ChoiceDesc1 = {
    Text = "[Confirmar]"
  },
  Event_7510_Desc = {
    Text = "Te concentras, la ilusión se disipa como tinta. Sigues adelante, pero no puedes despejar la oscuridad en tu corazón"
  },
  Event_7510_Name = {Text = "Ilusión"},
  Event_7511_ChoiceDesc1 = {
    Text = "[¿Criatura Desdichada?]"
  },
  Event_7511_ChoiceDesc2 = {
    Text = "[¿Humanos evolucionados?]"
  },
  Event_7511_ChoiceDesc3 = {
    Text = "[¿Quién eres?]"
  },
  Event_7511_Desc = {
    Text = "El hombre que veis por sexta vez está de pie en lo alto de la estructura de acero, mirando hacia la Tierra. El viento sopla, levantando su largo cabello y revelando la verdadera forma de una serpiente. \n Su mirada se centra en vosotros, y un momento después se lanza hacia la oscuridad lejana. \n \"Ah, qué criatura tan desgraciada. \n La sensación de ser traicionado debe ser tan dulce como la de un ser humano que ha <Bold:evolucionado>.\""
  },
  Event_7511_Name = {
    Text = "Compañero extraño VI"
  },
  Event_7512_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7512_Desc = {
    Text = "¿Quién prestaría atención a un rollo de película bajo la mirada de un sabueso infernal?"
  },
  Event_7512_Name = {
    Text = "Recuerdos luminosos"
  },
  Event_7513_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7513_Desc = {
    Text = "No mirar, no discutir, no escuchar, ni siquiera pensar—la elección de los sabios"
  },
  Event_7513_Name = {
    Text = "Rune de Frenesí"
  },
  Event_7514_ChoiceDesc1 = {
    Text = "[Salir]eliminar 2 cartas"
  },
  Event_7514_Desc = {
    Text = "En medio del bullicio a tu alrededor, apenas escuchas el extraño sonido de aleteo. La llave de plata vibra bruscamente en tu pecho, y te sientes impulsado por alguna fuerza a mirar hacia arriba, donde aparece un enorme agujero negro en el cielo. \n\"Lástima, lástima, pero no te preocupes. Nos volveremos a ver, mi respetado ojo sin visión.\""
  },
  Event_7514_Name = {
    Text = "Terapia de hipnosis"
  },
  Event_7515_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7515_Desc = {
    Text = "Puedes ignorar todo a tu alrededor, pero no el latido de tu corazón. Se acelera, te apura y te reprocha"
  },
  Event_7515_Name = {
    Text = "Atrio izquierdo"
  },
  Event_7516_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7516_Desc = {
    Text = "\"¡Qué bien! ¡El cabello del hermano William está a salvo!\"\nAunque solo era un mensaje de texto, podías imaginar el grito desgarrador"
  },
  Event_7516_Name = {
    Text = "Comunicación de emergencia"
  },
  Event_7517_ChoiceDesc1 = {
    Text = "[Decirle la verdad]Despertar aleatoriamente 1 entidad despierta, infectar\"(Skill.Arg1)\""
  },
  Event_7517_ChoiceDesc2 = {
    Text = "[Ocultar la verdad]Obtén un sigilo de entre 3 opciones"
  },
  Event_7517_Desc = {
    Text = "\"¡Ayúdame!\"\nEl viajero melancólico agarra tu mano. Ha estado vagando aquí durante siglos. \n\"Soy un soldado, enviado a la lejana oriente para combatir a los herejes. \nHe atravesado bosques densos y cruzado ríos, pero he perdido mi rumbo, volviendo una y otra vez al mismo lugar. \nHay algo mirándome desde la oscuridad. No puedo verlo, pero lo sé. Me está observando. \nAhora solo quiero volver a casa...\"\nMiras las sombras flotantes detrás de él. Primero son borrosas, luego se vuelven gradualmente nítidas—es una boca abierta, ansiosa por devorar el alma perdida que ha estado en salmuera durante cien años."
  },
  Event_7517_Name = {Text = "Devorador"},
  Event_7518_ChoiceDesc1 = {
    Text = "[Adentrarse en la oscuridad]"
  },
  Event_7518_ChoiceDesc2 = {
    Text = "[Despedirse]"
  },
  Event_7518_Desc = {
    Text = "\"Celeste, ¿me ayudarás esta vez?\"\nLa niña caminaba de un lado a otro con inquietud, mirando de vez en cuando hacia el tranquilo Despertado. \nElla no respondió a la niña, y cuando la expresión de la niña se volvió cada vez más ansiosa, una suave brisa levantó el velo blanco, empujando suavemente a la niña hacia cierta dirección. \n\"Te protegeré.\"\nTe protegeré, incluso si en una ocasión fallé en la \"protección\". \nPero esta vez, no te dejaré perderte en la oscuridad."
  },
  Event_7518_Name = {
    Text = "Bendición de la Santa Navegante"
  },
  Event_7519_ChoiceDesc1 = {
    Text = "[Salir]de 3 cartas de comando selecciona 1 para obtener oración:\"(EnchantConfig.Arg1)\""
  },
  Event_7519_Desc = {
    Text = "Esas canciones, algunas tan antiguas que se perdieron antes del diluvio; otras nuevas, cantando sobre el último año nuevo, los guantes nuevos de la esposa en Lentini... Después del caos emocional, queda un vacío en el corazón"
  },
  Event_7519_Name = {
    Text = "Canción del barco"
  },
  Event_7520_ChoiceDesc1 = {
    Text = "[Expulsar color]obtén una reliquia de oro\"(RelicConfig.Arg1)\",infección\"(Skill.Arg2)\""
  },
  Event_7520_ChoiceDesc2 = {
    Text = "[Abrazar el color]obtiene elección de 3 para 1 de creación de oro, infecta\"(Skill.Arg1)\""
  },
  Event_7520_ChoiceDesc3 = {
    Text = "[Dar la vuelta y salir] obtiene reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_7520_Desc = {
    Text = "Murphy te sigue de cerca, pero se detiene en seco al pasar por una esquina. \n Un flujo de colores brillantes gira ante tus ojos, sacando un suspiro del aire. \n \"Murphy@1...\" \n ¿Es el espíritu ahogado atrapado en la prisión del Sonanir? ¿O son los seres queridos que vienen a seguir a los vivos?"
  },
  Event_7520_Name = {
    Text = "Colores nostálgicos"
  },
  Event_7521_ChoiceDesc1 = {
    Text = "[Seguir Buscando]Aumentar Arg1 de vida, infectar\"(Skill.Arg2)\""
  },
  Event_7521_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7521_Desc = {
    Text = "Una voz familiar y reconfortante llegó a mis oídos, pero cuando intenté seguirla, se detuvo abruptamente"
  },
  Event_7521_Name = {
    Text = "Contacto Anómalo"
  },
  Event_7522_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7522_Desc = {
    Text = "\"Era una melodía profana.\"\nTe tapaste los oídos sangrantes, convencido de ello"
  },
  Event_7522_Name = {
    Text = "Sonido prohibido"
  },
  Event_7523_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7523_Desc = {
    Text = "Esos colores se distorsionan vagamente en dos formas humanas, pero ellos solo permanecen inmóviles en esa esquina, enviándoles su última bendición con la mirada."
  },
  Event_7523_Name = {
    Text = "Colores nostálgicos"
  },
  Event_7524_ChoiceDesc1 = {
    Text = "[Escuchar]gana 3 elige 1 reliquia de oro"
  },
  Event_7524_Desc = {
    Text = "La voz de la dama del narciso se detuvo por un momento.\n\"Oh, ¿has elegido esto? Buena elección, como recompensa, te haré un regalo especial.\""
  },
  Event_7524_Name = {
    Text = "Tiempo de pista"
  },
  Event_7525_ChoiceDesc1 = {
    Text = "[Persistir en preguntar]Infectar\"(Skill.Arg1)\""
  },
  Event_7525_ChoiceDesc2 = {
    Text = "[Dejar de preguntar]Elegir 1 carta para eliminar"
  },
  Event_7525_Desc = {
    Text = "\"Sí, una elección inteligente. Ante un gran enemigo, querrás conocerlo bien, ¿verdad? Pero saber demasiado sobre los secretos de las dimensiones puede afectar tu mente.\""
  },
  Event_7525_Name = {
    Text = "Tiempo de pista"
  },
  Event_7526_ChoiceDesc1 = {
    Text = "[Sigue preguntando] enfurece al narciso, entra en batalla"
  },
  Event_7526_ChoiceDesc2 = {
    Text = "[Dejar de preguntar]Recibir una pequeña penalización"
  },
  Event_7526_Desc = {
    Text = "\"¿Oh? ¿Aún piensas en seguirme? Pequeño, ser demasiado codicioso no es bueno.\""
  },
  Event_7526_Name = {
    Text = "Tiempo de pista"
  },
  Event_7527_ChoiceDesc1 = {
    Text = "[Centrarse en ver] aumenta Arg1 puntos de vida máxima"
  },
  Event_7527_ChoiceDesc2 = {
    Text = "[Ignorar] 2 Tarjetas de comando aleatorias obtienen Inscripción: \"(EnchantConfig.Arg1)\", infectar 2 \"(Skill.Arg2)\""
  },
  Event_7527_Desc = {
    Text = "Ustedes persiguen a la sombra del sabueso infernal por las calles del pueblo.\nComienza a caer nieve fría del cielo, acariciando suavemente sus mejillas y corazones inquietos"
  },
  Event_7527_Name = {Text = "Nieve"},
  Event_7528_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7528_Desc = {
    Text = "Agitas los brazos para ahuyentar a los molestos cuervos.\nSe ríen de ti, pero tu valentía los impresiona y recibes tu recompensa"
  },
  Event_7528_Name = {
    Text = "Canto de los Cuervos"
  },
  Event_7529_ChoiceDesc1 = {
    Text = "[Sobre lily]obtener reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_7529_ChoiceDesc2 = {
    Text = "[Sobre el sabueso infernal]obtener reliquia de oro\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7529_Desc = {
    Text = [[
Atravesar la puerta infinita, desde un lugar inalcanzable, se escucha la voz de Daphdel.
"Es la hora de los consejos de Daphdel."]]
  },
  Event_7529_Name = {
    Text = "Tiempo de pista"
  },
  Event_7530_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7530_Desc = {
    Text = "Sigues mostrando tu tenacidad, aún puedes seguir siendo tú mismo en el canto. \n No crees en los murmullos a tu alrededor, solo confías en la razón humana. \n Sin embargo... el sólido suelo del que dependes, el día que esté cubierto por esa espesa masa negra, sacar tus ojos como objetos de observación será tu única opción en el ocaso de tu vida."
  },
  Event_7530_Name = {
    Text = "Canto de los Cuervos"
  },
  Event_7531_ChoiceDesc1 = {
    Text = "[Fuente del sabueso infernal]obtiene reliquia de oro\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_7531_ChoiceDesc2 = {
    Text = "[enfocarse en batalla]elige 1 de 3 cartas de comando, obtén plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7531_Desc = {
    Text = "La silueta del sabueso infernal cambia.\nSu cuerpo conecta con las grietas de la pared, revelando una ilusión extraña"
  },
  Event_7531_Name = {
    Text = "desde el ángulo"
  },
  Event_7532_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7532_Desc = {
    Text = "\"Miau, miau, miau miau...\"\nTe esfuerzas por sonar débil e inofensivo.\n\"¡Miau! ¡Miau miau! ¡Miau miau miau!\"\nEl grupo de gatos parece aceptar tu buena intención y responde con fuertes maullidos. Sus voces resuenan día y noche, asustando a la luna que se esconde tras las nubes"
  },
  Event_7532_Name = {
    Text = "Ciudad de los gatos"
  },
  Event_7533_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7533_Desc = {
    Text = "Solo son seres luchando por sobrevivir, buscando un trozo de madera flotante para descansar...\nSuspiras, dejando que el líquido negro de la cola de la mariposa fluya por tu mejilla"
  },
  Event_7533_Name = {
    Text = "Mariposa de Líquido Negro"
  },
  Event_7534_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7534_Desc = {
    Text = "Usas todas tus fuerzas hasta alejarte de los gatos.\nAl mirar atrás, los gatos ya han vuelto a sus lugares. Aseándose, durmiendo, peleando...\nLa verdad, no les importan los humanos"
  },
  Event_7534_Name = {
    Text = "Ciudad de los gatos"
  },
  Event_7535_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7535_Desc = {
    Text = "Arrojaste los restos de carne a la multitud de gatos.\nLos gatos se abalanzaron como una marea negra, devorando la carne y dispersándose rápidamente.\nDesafortunadamente, era carne caducada. Llena el estómago, pero no es satisfactoria"
  },
  Event_7535_Name = {
    Text = "Ciudad de los gatos"
  },
  Event_7536_ChoiceDesc1 = {
    Text = "[Mirada penetrante]obtiene reliquia de oro\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_7536_ChoiceDesc2 = {
    Text = "[Dejar de resistir]Despertar aleatoriamente a 2 entidades, infectar dos veces\"(Skill.Arg1)\""
  },
  Event_7536_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7536_Desc = {
    Text = "Innumerables ojos susurran a tu alrededor. \n\"Viajamos, nos detenemos, hemos caminado a grandes pasos durante miles de años e incluso más. \nCuando el sol se oscurece gradualmente bajo nuestra mirada, cuando la vida de la antigua Tierra es ahogada por las inundaciones. \nDesde hace tiempo, hemos estado profundamente atraídos por los misterios del universo.\""
  },
  Event_7536_Name = {Text = "ojo"},
  Event_7537_ChoiceDesc1 = {
    Text = "[sentir pánico]Despertar aleatorio de 1 despertador"
  },
  Event_7537_ChoiceDesc2 = {
    Text = "[sentir satisfacción]Selecciona despertar a 1 despertador y reduce el costo de aritmética de su carta de despertar en 2 puntos. Infección\"(Skill.Arg1)\""
  },
  Event_7537_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7537_Desc = {
    Text = "Has visto un cielo sin luna ni estrellas, donde flotan innumerables pupilas agrandadas. \n Parece que al extender la mano podrías desatornillarlas, salpicando carne y sangre. \n Pero al abrir los cinco dedos, no hay nada en el lugar que tocas. \n Los ojos del destino te observan sin parpadear, han encontrado un grano de arena cristalina en el caos del universo."
  },
  Event_7537_Name = {
    Text = "Ojo del domo"
  },
  Event_7538_ChoiceDesc1 = {
    Text = "[Dejar caer las manos que cubren los oídos]obtener reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_7538_ChoiceDesc2 = {
    Text = "[Continuar tapándose los oídos]gana 75 el sigilo negro, infección\"(Skill.Arg2)\""
  },
  Event_7538_Desc = {
    Text = "Grito, un grito interminable——\nLa Cantante cuervo, con su pelaje negro brillante, un brillo frío y duro en su pico afilado, su lamento resonante perfora una y otra vez tu tímpano. \n¡Deja tus manos en tus oídos!\nLa bandada de cuervos que canta a placer en la noche desea beber de tu cuerpo encogido, ese estremecimiento no refinado."
  },
  Event_7538_Name = {
    Text = "Canto de la Manada de Cuervos"
  },
  Event_7539_ChoiceDesc1 = {
    Text = "[Imitar maullidos] obtiene 50 el sigilo negro"
  },
  Event_7539_ChoiceDesc2 = {
    Text = "[Dar de comer]obtienes 75 el sigilo negro, infección\"(Skill.Arg2)\""
  },
  Event_7539_Desc = {
    Text = "Te has adentrado en el territorio del gato negro.\nIncontables ojos se abren súbitamente en la oscuridad, llenos de curiosidad, examen, alerta... pero ninguno con benevolencia.\nEsmeralda, ámbar, azul pavo real...\nTe sientes como si estuvieras en un mar brillante de joyas.\nPara escapar, tú—"
  },
  Event_7539_Name = {
    Text = "Ciudad de los gatos"
  },
  Event_7540_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7540_Desc = {
    Text = "Notas una mano diferente. Es delicada, blanca y siempre tranquila.\nLo más importante es que la reconoces, es tu propia mano.\nLa rompes sin dudar.\nUnos chillidos agudos llenan tus oídos, y el pantano desaparece"
  },
  Event_7540_Name = {
    Text = "Marisma Oscura"
  },
  Event_7541_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7541_Desc = {
    Text = "\"Decisión sabia.\"dijo la figura vacía,\"las elecciones ya verificadas tienen un desenlace predeterminado, mientras que las acciones desconocidas conducen a un nuevo futuro.\"\nUna leve esperanza te envuelve con suavidad. La figura se disipa, te sostienes el pecho, sin saber si lo que ocurrió hace un momento fue una proyección o una ilusión generada bajo la presión mental."
  },
  Event_7541_Name = {
    Text = "Sendero bifurcado"
  },
  Event_7542_ChoiceDesc1 = {
    Text = "[elogiarlo]selecciona 1 de las 3 cartas de comando para obtener un sigilo:\"(EnchantConfig.Arg1)\""
  },
  Event_7542_ChoiceDesc2 = {
    Text = "[Sátiralo] infecta «(Skill.Arg1)», reimprime de nuevo, hasta 2 veces"
  },
  Event_7542_Desc = {
    Text = "El cerebro dice: las cadenas han atrapado mi neocortex, mi tronco encefálico, mi corteza cerebral, pero no pueden atar a más de diez mil millones de pequeñas células que buscan la verdad. \n Tú dices: ¿quién te ha atrapado aquí? ¿Y tu cuerpo? \n El cerebro dice: ¿Cuerpo? No me hagas reír. Antes me llamaban \"el viejo Johnny que vende carne de cerdo\". \n Cuando tenía cuerpo, ni siquiera podía entender las sumas y restas dentro de diez. \n ¡Pero mira cómo me he convertido después de que el director eliminara mi cuerpo redundante! ¡Un físico, un filósofo y un poeta aficionado."
  },
  Event_7542_Name = {
    Text = "Cerebro filosófico"
  },
  Event_7543_ChoiceDesc1 = {
    Text = "[demostrar la conjetura de Goldbach]obtén la reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_7543_ChoiceDesc2 = {
    Text = "[El final del viaje]al azar 1 carta y obtener plegaria：\"(EnchantConfig.Arg1)\""
  },
  Event_7543_ChoiceDesc3 = {
    Text = "[Rechazar las preguntas]obtienes 50 el sigilo negro"
  },
  Event_7543_Desc = {
    Text = "Cuando recoges la tabla de espiritismo, la voz de una joven mujer irrumpió en tu mente.  \n“Pregúntame, sé todo”.  \n“De mis respuestas, obtendrás el regalo del destino”"
  },
  Event_7543_Name = {
    Text = "Tablero espiritual"
  },
  Event_7544_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7544_Desc = {
    Text = "Lees las páginas manchadas y rotas, frases fragmentadas salen de tu boca, \"ancestros\", \"hijo sagrado\", \"muerte eterna\", \"memoria larga\" inundan tu mente, estimulando tus nervios ya sensibles por las pesadillas"
  },
  Event_7544_Name = {
    Text = "Orden secreta · Parte superior"
  },
  Event_7545_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7545_Desc = {
    Text = "El lodo negro goteó en tu cara, causando una sensación de picazón.\nNo pudiste soportarlo y apartaste la mariposa con la mano.\nLa mariposa esquivó tu movimiento y desapareció silenciosamente en la distancia"
  },
  Event_7545_Name = {
    Text = "Mariposa de Líquido Negro"
  },
  Event_7546_ChoiceDesc1 = {
    Text = "[Salir]buscar el reflector"
  },
  Event_7546_ChoiceDesc2 = {
    Text = "[Entrar en la niebla]Pierde Arg2 de vida"
  },
  Event_7546_ChoiceDesc3 = {
    Text = "[Entrar directamente]"
  },
  Event_7546_Desc = {
    Text = "Delante hay una densa niebla negra, entrar imprudentemente traerá desastres.\nQuizás deberías encontrar un \"faro\" para disipar la niebla"
  },
  Event_7546_Name = {
    Text = "desconocido"
  },
  Event_7547_ChoiceDesc1 = {
    Text = "[Aceptar el Fantasma] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7547_ChoiceDesc2 = {
    Text = "[negar ilusión] obtiene reliquia de plata\"(RelicConfig.Arg1)\"， infección\"(Skill.Arg2)\""
  },
  Event_7547_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7547_Desc = {
    Text = "Bajo el oscuro y pesado puente de hierro, en la orilla silenciosa llena de juncos, de repente vuela una mariposa brillante.\nLa mariposa se posa en tu mano, los gritos cesan, reemplazados por el canto de los trabajadores moviendo vigas, el golpeteo de martillos, el sonido metálico de los remaches"
  },
  Event_7547_Name = {
    Text = "Ilusión del Puente de Acero"
  },
  Event_7548_ChoiceDesc1 = {
    Text = "[Ahuyentar cuervos]Obtén 40 sigilos negros, contagia\"(Skill.Arg2)\"，continúa eligiendo"
  },
  Event_7548_ChoiceDesc2 = {
    Text = "[Continuar persiguiendo al niño]gana 25 el sigilo negro, sal"
  },
  Event_7548_Desc = {
    Text = "Un cuervo se posa en la lámpara. \nDos cuervos se posan en la lámpara. \nTres cuervos se posan en la lámpara. \n... \nEsas criaturas negras retuercen sus cuellos, de pie sobre la lámpara en la esquina del callejón, mirándote con una mirada llena de malicia. Esas cabezas en sombra parecen compartir un mismo cuerpo sumergido en D-Slime."
  },
  Event_7548_Name = {
    Text = "Mirada de Cuervo Negro"
  },
  Event_7549_ChoiceDesc1 = {
    Text = "[Salir]si el número de despertadores es menor a 3, obtiene reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_7549_ChoiceDesc2 = {
    Text = "[Salir]si el número de despertadores despiertos es al menos 3, obtiene reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_7549_Desc = {
    Text = "No hiciste caso a la huella y seguiste adelante.\n<Italic: qué tan pesado es el despertar del conocimiento>, la huella se expandió y retorció con tus pasos, como si de cualquier grieta pudiera surgir una mano y arrastrarte hacia lo profundo"
  },
  Event_7549_Name = {
    Text = "Grieta reptante"
  },
  Event_7550_ChoiceDesc1 = {
    Text = "[Responder mirada] obtiene reliquia de oro «(RelicConfig.Arg1)», infecta «(Skill.Arg2)»"
  },
  Event_7550_ChoiceDesc2 = {
    Text = "[Evitar la mirada]Despertar 2 cuerpos al azar, infectar dos veces con \"(Skill.Arg1)\""
  },
  Event_7550_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7550_Desc = {
    Text = "Puedes sentir una mirada, una mirada que trasciende dimensiones, mucho más alta que el dominio, que te observa, observando también a la niña frente a ti. \n Tu respiración comienza a acelerarse, en lo profundo de tu razón, un miedo primitivo comienza a gritar."
  },
  Event_7550_Name = {
    Text = "Quién mira"
  },
  Event_7551_ChoiceDesc1 = {
    Text = "[Seguir Buscando]Aumentar Arg1 de vida, infectar\"(Skill.Arg2)\""
  },
  Event_7551_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7551_Desc = {
    Text = "Una luz tenue aparece ante tus ojos, brillante y cálida, pero desaparece cuando intentas seguirla"
  },
  Event_7551_Name = {
    Text = "Contacto Anómalo"
  },
  Event_7552_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7552_Desc = {
    Text = "Susurrando en armonía con su canto, el cálido flujo de agua te trae bendiciones de regreso a casa"
  },
  Event_7552_Name = {
    Text = "Canción del mar"
  },
  Event_7553_ChoiceDesc1 = {
    Text = "[Confirmar]"
  },
  Event_7553_Desc = {
    Text = "Ves una luz tenue adelante, finalmente sales de la densa niebla asfixiante"
  },
  Event_7553_Name = {
    Text = "Niebla del Caos"
  },
  Event_7554_ChoiceDesc1 = {
    Text = "[Desatar rama inferior]"
  },
  Event_7554_Desc = {
    Text = "Las conexiones de la gnosis que quedan del dominio se entrelazan, formando un campo de fuerza inestable.\nQuizás puedas liberar el espíritu entrelazado y aclarar el camino hacia adelante para ti"
  },
  Event_7554_Name = {
    Text = "Camino enredado"
  },
  Event_7555_ChoiceDesc1 = {
    Text = "[Desatar rama superior]"
  },
  Event_7555_Desc = {
    Text = "Las conexiones de la gnosis que quedan del dominio se entrelazan, formando un campo de fuerza inestable.\nQuizás puedas liberar el espíritu entrelazado y aclarar el camino hacia adelante para ti"
  },
  Event_7555_Name = {
    Text = "Camino enredado"
  },
  Event_7556_ChoiceDesc1 = {
    Text = "[Desatar rama izquierda]"
  },
  Event_7556_Desc = {
    Text = "Las conexiones de la gnosis que quedan del dominio se entrelazan, formando un campo de fuerza inestable.\nQuizás puedas liberar el espíritu entrelazado y aclarar el camino hacia adelante para ti"
  },
  Event_7556_Name = {
    Text = "Camino enredado"
  },
  Event_7557_ChoiceDesc1 = {
    Text = "[Desatar rama izquierda]"
  },
  Event_7557_Desc = {
    Text = "Las conexiones de la gnosis que quedan del dominio se entrelazan, formando un campo de fuerza inestable.\nQuizás puedas liberar el espíritu entrelazado y aclarar el camino hacia adelante para ti"
  },
  Event_7557_Name = {
    Text = "Camino enredado"
  },
  Event_7558_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7558_Desc = {
    Text = "Aún enfrentan varias batallas, no es momento de investigar con calma"
  },
  Event_7558_Name = {
    Text = "Registro de órganos"
  },
  Event_7559_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7559_Desc = {
    Text = "Los caracteres en el papel de repente se volvieron completos y vívidos, las palabras aterradoras eran suficientes para sacudir la fe y los cimientos de cualquier sufridor inconsciente. Cuanto más leías, más confundido y aterrorizado te sentías, incapaz de detenerte de rascarte el cuero cabelludo con los dedos. \n De repente, aquellos símbolos llenos de maldición desaparecieron. Ramona interrumpió tu lectura y forzó las páginas del libro en el maletín."
  },
  Event_7559_Name = {
    Text = "Orden secreta · Parte inferior"
  },
  Event_7560_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7560_Desc = {
    Text = "Alegría, tristeza, dolor, angustia... todos son tus sentimientos.\nTú, y los muchos otros tú en diferentes dimensiones"
  },
  Event_7560_Name = {Text = "Adicción"},
  Event_7561_ChoiceDesc1 = {
    Text = "[Escuchar en silencio] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7561_ChoiceDesc2 = {
    Text = "[Ella está aquí] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7561_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7561_Desc = {
    Text = "El lamento del monstruo resuena en tu mente, en el líquido negro amorfo, una voz susurra débilmente \"Hermana Sasha\", \"Hermana Sasha\".\n\"Hermana Sasha, ¿dónde estás?\""
  },
  Event_7561_Name = {
    Text = "\"Hermana Sasha\""
  },
  Event_7562_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7562_Desc = {
    Text = "\"Únete a él, únete a ellos, únete a nosotros. \nConviértete en Su Guardián, conviértete en Su Executor. \nUsa Sus sueños como tu dirección para avanzar...\"\nLas oraciones de Caos agitan tu conciencia, y solo después de que esas voces desaparecen, te das cuenta de que ya estás empapado en sudor."
  },
  Event_7562_Name = {
    Text = "Plegaria del Sueño"
  },
  Event_7563_ChoiceDesc1 = {
    Text = "[Nunca escuché]"
  },
  Event_7563_ChoiceDesc2 = {
    Text = "[Escuchado]"
  },
  Event_7563_Desc = {
    Text = "\"Disculpa, ¿puedo tomar un momento de tu tiempo?\nQuisiera contarles algunas leyendas locales.\n¿Han oído hablar de una criatura llamada 'Cerbero'?\""
  },
  Event_7563_Name = {
    Text = "Compañero extraño I"
  },
  Event_7564_ChoiceDesc1 = {
    Text = "[Dejar de pensar]obtener reliquia maldita\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_7564_ChoiceDesc2 = {
    Text = "[Alcanzar el Conocimiento] 1 Tarjeta de comando aleatoria obtiene Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_7564_Desc = {
    Text = "El puerto fue atacado, un misterioso carguero sin retorno y un \"nuevo amigo\" con aletas... ¿Es esta una trampa cuidadosamente preparada? ¿O es otro viaje lleno de imprevistos? \n La realidad y la razón se entrelazan y se tiran mutuamente, innumerables inspiraciones y pensamientos brotan de tu mente."
  },
  Event_7564_Name = {
    Text = "Chispa de inspiración"
  },
  Event_7565_ChoiceDesc1 = {
    Text = "[¿Elworth volcán?] aumenta Arg1 puntos de PV Max"
  },
  Event_7565_ChoiceDesc2 = {
    Text = "[Esforzarse por recordar] Elige 1 Tarjeta de comando entre 3 para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7565_Desc = {
    Text = "Las mejillas de Lily están manchadas de lágrimas negras. \"Hemos estado aquí, mamá,\" susurra suavemente, \"en el volcán de Elworth...\""
  },
  Event_7565_Name = {
    Text = "Recuerdos volcánicos"
  },
  Event_7566_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7566_Desc = {
    Text = "\"Zambullirse en el mar...\"\n Las runas parpadean ante tus ojos, y no puedes evitar extender la mano hacia el vacío, tratando de atraparlas—\n\"¿Qué estás haciendo? ¡Ellos se están acercando!\"\n La chica misteriosa te agarra y corre hacia el otro lado de la cubierta, interrumpiendo tu conexión con las runas. \n Pero definitivamente hay alguna fuerza que ha dejado una huella en la punta de tus dedos."
  },
  Event_7566_Name = {
    Text = "Rune de Frenesí"
  },
  Event_7567_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7567_Desc = {
    Text = "No te interesan los murmullos crípticos, y no quieres arriesgarte a la locura entrando en la oscuridad"
  },
  Event_7567_Name = {
    Text = "Una carta de socorro"
  },
  Event_7568_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7568_Desc = {
    Text = "No importa qué, el deber del Guardián crece en tu pecho. No puedes renunciar a encontrar al remitente, aunque sea vago y oscuro"
  },
  Event_7568_Name = {
    Text = "Una carta de socorro"
  },
  Event_7569_ChoiceDesc1 = {
    Text = "[observarlo]puedes obtener 25 el sigilo negro"
  },
  Event_7569_ChoiceDesc2 = {
    Text = "[Acarícialo]50% de oportunidad de obtener 50 el sigilo negro, 50% de oportunidad de no obtener nada"
  },
  Event_7569_Desc = {
    Text = "De repente, un gato negro salió corriendo de un callejón, frotándose de manera inusualmente cariñosa entre vuestros pies, sus ojos verticales de un verde oscuro parpadeaban con un brillo escalofriante, como si dijera: \"No me persigas, juega conmigo un rato.\"\n \"Ya lo has visto, está a tu lado, esas sombras contaminadas por la locura, llenas de fervor... no mires directamente su contorno.\""
  },
  Event_7569_Name = {
    Text = "Elfo de la noche"
  },
  Event_7570_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7570_Desc = {
    Text = "\"¡No puede ser, no lo creo!\" gritó la voz, \"¡Esta mujer que me entregó al demonio no es mi hermana Sasa!\""
  },
  Event_7570_Name = {
    Text = "\"Hermana Sasha\""
  },
  Event_7571_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7571_Desc = {
    Text = "\"Recibido, procederemos con el envío de recursos básicos. Por favor, esté atento a la recepción.\""
  },
  Event_7571_Name = {
    Text = "Comunicación de apoyo"
  },
  Event_7572_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7572_Desc = {Text = "Ya inútil"},
  Event_7572_Name = {
    Text = "Reliquias de los antiguos"
  },
  Event_7573_ChoiceDesc1 = {
    Text = "[echar un vistazo]obtén 3 de 1 plegaria"
  },
  Event_7573_ChoiceDesc2 = {
    Text = "[Arrancar el cartel] 1 Tarjeta de comando aleatoria obtiene Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_7573_Desc = {
    Text = "Un candelabro común en el museo de cera.\nA la luz enfermiza de la vela, ves un cartel dibujado a mano en la pared"
  },
  Event_7573_Name = {
    Text = "Risas en la oscuridad"
  },
  Event_7574_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7574_Desc = {
    Text = "\"Lily tiene su propio corazón, no necesita obedecer a nadie.\" Respondes con dignidad.\nFrancis resopla, sin responder"
  },
  Event_7574_Name = {
    Text = "Su elección"
  },
  Event_7575_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7575_Desc = {
    Text = "Esta es una serie de retratos grupales.\nLas personas desanimadas se agachan detrás de la reja de hierro, con rostros llenos de sufrimiento.\nUna de las fotos atrae tu atención. Debe ser una joven delgada, con el rostro en blanco.\nEse ser grotesco y profano se entrelaza a su alrededor en círculos.\nNo puedes ver su cara, pero en tu imaginación, debería estar sin expresión."
  },
  Event_7575_Name = {
    Text = "registrar fielmente"
  },
  Event_7576_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7576_Desc = {
    Text = "Tú contemplas con fascinación estas relucientes joyas y, sin darte cuenta, ya has tomado la delgada y negra mano viscosa.\nY ella solo aprieta ligeramente la mano, luego la suelta.\nNada ha ocurrido, solo un hilo de aire negro que se desliza por la punta de tus dedos hacia la manga."
  },
  Event_7576_Name = {
    Text = "Invertir las garras del mal"
  },
  Event_7577_ChoiceDesc1 = {
    Text = "[tocar algunas notas]Obtén una reliquia de plata\"(RelicConfig.Arg1)\"，infección\"(Skill.Arg2)\""
  },
  Event_7577_ChoiceDesc2 = {
    Text = "[Cubrir la tapa] obtiene el sello de elegir 3"
  },
  Event_7577_Desc = {
    Text = "El piano junto a la pared tiene la tapa abierta. Tiene teclas amarillentas y bordes agrietados que muestran la madera, pero cada tecla está muy limpia.\nEs la fuente de alegría de muchas personas"
  },
  Event_7577_Name = {
    Text = "Melodía de la infancia"
  },
  Event_7578_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7578_Desc = {
    Text = "El portador de la lanza emite un quejido, como un niño abusado que solloza.\nEl sonido se desvanece en un instante, junto con otros dos marineros que desaparecen... Resulta ser solo una ilusión reflejada en el dominio"
  },
  Event_7578_Name = {
    Text = "Perseguir incansablemente"
  },
  Event_7579_ChoiceDesc1 = {
    Text = "[Salir]obtiene reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_7579_Desc = {
    Text = "\"Respuesta correcta.\"\nEl dueño de la voz está muy satisfecho con esta respuesta, y un objeto brillante emerge del agua.\n\"Recuerda, todo tiene un precio.\""
  },
  Event_7579_Name = {
    Text = "Voces del más allá"
  },
  Event_7580_ChoiceDesc1 = {
    Text = "[Dispersar la ilusión]Contagia el síntoma"
  },
  Event_7580_ChoiceDesc2 = {Text = "[Salir]"},
  Event_7580_Desc = {
    Text = "Rostros borrosos aparecen de repente, rodeándote y gimiendo desesperadamente con cuerdas vocales inexistentes"
  },
  Event_7580_Name = {Text = "Ilusión"},
  Event_7581_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7581_Desc = {
    Text = [[
Ignoras la grieta y avanzas.
Pero parece enfurecida, la grieta se expande y serpentea con cada paso, como si una mano pudiera salir y arrastrarte al abismo]]
  },
  Event_7581_Name = {
    Text = "Grieta reptante"
  },
  Event_7582_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7582_Desc = {
    Text = "No te dejas engañar fácilmente, te das la vuelta y te vas"
  },
  Event_7582_Name = {
    Text = "Grieta reptante"
  },
  Event_7583_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7583_Desc = {
    Text = "Te das cuenta de lo inusual de la grieta; te agachas para examinarla, pero extrañamente, la grieta detiene su expansión y cae en un silencio eterno"
  },
  Event_7583_Name = {
    Text = "Grieta reptante"
  },
  Event_7584_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7584_Desc = {
    Text = "\"No, es una mente despierta. La determinación no puede ayudarte a resolver el cuerpo disuelto, el guardián, piensa bien en la estrategia.\""
  },
  Event_7584_Name = {
    Text = "Regla de Logan"
  },
  Event_7585_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7585_Desc = {
    Text = "No puedes resistir el impulso interior. \n Los dedos vagan y juegan sobre el teclado como niños perdidos en el bosque... \n Poco a poco, mariposas comenzaron a salir de la máquina de escribir. \n Una, dos, tres... \n En la cara, en los dedos, grupos de mariposas brillaban en la oscuridad como fuegos artificiales, destellando con luz de joya. \n Esta máquina de escribir no tiene ningún uso práctico, pero es experta en crear belleza."
  },
  Event_7585_Name = {Text = "ojo"},
  Event_7586_ChoiceDesc1 = {
    Text = "[Atar a la gallina]"
  },
  Event_7586_Desc = {
    Text = "Producto de Lai, gallinas vivas y saltarinas, una tentación culinaria"
  },
  Event_7586_Name = {
    Text = "Fabricar una trampa"
  },
  Event_7587_ChoiceDesc1 = {
    Text = "[Trabajo hecho]"
  },
  Event_7587_Desc = {
    Text = "¡Trampas baratas pero efectivas!"
  },
  Event_7587_Name = {
    Text = "Fabricar una trampa"
  },
  Event_7588_ChoiceDesc1 = {
    Text = "[Colocar trampa]"
  },
  Event_7588_Desc = {
    Text = "Trampa de metal, la mejor amiga del cazador perezoso"
  },
  Event_7588_Name = {
    Text = "Fabricar una trampa"
  },
  Event_7589_ChoiceDesc1 = {
    Text = "[Ver telégrafo]infección\"(Skill.Arg1)\"，gana reliquia de oro\"(RelicConfig.Arg2)\""
  },
  Event_7589_ChoiceDesc2 = {
    Text = "[Ignorar]obtener 50 el sigilo negro"
  },
  Event_7589_Desc = {
    Text = "Te escondes en una grieta de la cueva para evitar la tormenta. Pero sabes que no puedes quedarte mucho tiempo, si esos hombres de negro te encuentran, no tendrás escapatoria.\nEn un rincón de la grieta, encuentras un telégrafo"
  },
  Event_7589_Name = {
    Text = "Telegrama Silencioso"
  },
  Event_7590_ChoiceDesc1 = {
    Text = "[Revisar diapositiva]mejora aleatoriamente 2 cartas de carta"
  },
  Event_7590_ChoiceDesc2 = {
    Text = "[Revisar cámara]de 3 cartas de comando selecciona 1 para ganar plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_7590_Desc = {
    Text = "Como si estuvieras sacando un trozo de víscera, la película en el vientre de la cámara fue desgarrada y desechada aquí, desollada y abandonada, sin que nadie se preocupara. \n Un destello de luz blanca deslumbrante pasó, la cámara abandonada en la esquina estaba inclinada, el obturador se presionó en el aire. \n \"Ka-chac——\"\n Tu expresión de asombro y confusión fue fielmente registrada en el rollo de película de la cámara."
  },
  Event_7590_Name = {
    Text = "Registro de inocencia"
  },
  Event_7591_ChoiceDesc1 = {
    Text = "[Apretar la garganta del cantante]Recibe reliquia maldita\"(RelicConfig.Arg1)\"、infectar\"(Skill.Arg2)\""
  },
  Event_7591_ChoiceDesc2 = {
    Text = "[Tropezar con los pasos del Bailarín] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_7591_ChoiceDesc3 = {
    Text = "[Quitarle el papel al poeta] obtiene 50 el sigilo negro"
  },
  Event_7591_Desc = {
    Text = "Te bloquean el camino tres figuras viscosas. \n Una figura canta, su voz es ronca y la letra es extraña, te tapas los oídos y la evitas. \n Una figura baila, sus movimientos son rígidos y sus pasos titubeantes, cierras los ojos y la esquivas. \n Una figura recita poesía, su ritmo es fragmentado y sus frases no tienen sentido, no puedes soportarlo más, así que—"
  },
  Event_7591_Name = {
    Text = "Malhechor en el Camino Estrecho"
  },
  Event_7592_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7592_Desc = {
    Text = "\"¡No! El progreso de la humanidad no se basa en la historia ni en la tecnología, sino en las ratas.\"\n\"Fueron las ratas las que abrieron esa era oscura, y solo después la humanidad vio la luz del renacimiento.\"\n\"La humanidad los necesita a ustedes, aunque no todos lo entiendan.\"\nLas ratas estaban un poco confundidas por tu largo discurso, pero aun así te dejaron ir."
  },
  Event_7592_Name = {Text = "Peste"},
  Event_7593_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7593_Desc = {
    Text = "Ignoraste el espasmo en tu nervio óptico y apenas lograste distinguir...\nParecía haber un círculo mágico rasgado.\nDentro del círculo, había innumerables líneas curvas, estáticas pero a la vez fluidas, hipnotizantes"
  },
  Event_7593_Name = {
    Text = "desde el ángulo"
  },
  Event_7594_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7594_Desc = {
    Text = "<Bold:Museo de Cera Rogers\nCalle Southwark 44, Ciudad de Lentinianta@2\nHorario de visita: 21:00-6:00\nÚltima entrada a las 3:00 (cerrado los fines de semana)\n\n<Bold:Exposición actual\nVladimir@2:\nLa filosofía de la sonrisa"
  },
  Event_7594_Name = {
    Text = "Risas en la oscuridad"
  },
  Event_7595_ChoiceDesc1 = {
    Text = "[Mirar fijamente] elige 1 de 3 cartas de comando y obtiene el sello: «(EnchantConfig.Arg1)», infecta «(Skill.Arg2)»"
  },
  Event_7595_ChoiceDesc2 = {
    Text = "[Cerrar ojos]Elige despertar 1 cuerpo, infecta\"(Skill.Arg1)\""
  },
  Event_7595_ChoiceDesc3 = {
    Text = "[Dar la espalda]gana 25 el sigilo negro"
  },
  Event_7595_Desc = {
    Text = "No deberías ver el cielo estrellado. \n En el Dominio del S.S. Sonanir, el firmamento brilla con luz deslumbrante, y las formas de las estrellas y la luna están ocultas. \n En la oscura cabina del barco, tampoco deberías ver el cielo estrellado. \n Aquí solo deberían haber luces incandescentes dispersas y viejas linternas—pero, ¿por qué aún sientes la mirada que cuelga en el horizonte?"
  },
  Event_7595_Name = {
    Text = "Mirar furtivamente"
  },
  Event_7596_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7596_Desc = {
    Text = "Eliges mirar valientemente a los ojos. \n Son estrellas brillantes que resplandecen en la oscuridad. \n Luego se ríen y se convierten en innumerables lunas curvas. \n Los ojos dicen: \"No temes las miradas. Tampoco deberías temer... hace mucho que no te veo, @2.\" \n Antes de desaparecer, te regalan un pequeño regalo como \"recuerdo del reencuentro\"."
  },
  Event_7596_Name = {Text = "ojo"},
  Event_7597_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7597_Desc = {
    Text = "El puente ferroviario, las venas y nervios de Londinium, conecta el corazón y extremidades de la ciudad; mientras el sol no se ponga por aquí, el corazón de Londinium latirá eternamente con fervor."
  },
  Event_7597_Name = {
    Text = "Ilusión del Puente de Acero"
  },
  Event_7598_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7598_Desc = {
    Text = "Una increíblemente lujosa fuga, el compositor es desconocido.\nIncontables voces entrelazan temas similares, cada nota es tan precisa y fría como el bisturí de un cirujano.\nPreciso y lujoso, esa es la estética de Rogers.\nFuga, ¡vuela!"
  },
  Event_7598_Name = {Text = "mal gusto"},
  Event_7599_ChoiceDesc1 = {
    Text = "[Saludo Expresado]"
  },
  Event_7599_ChoiceDesc2 = {
    Text = "[Buscar ayuda]"
  },
  Event_7599_Desc = {
    Text = "En el momento en que apoyaste la mano en el costado del barco, viste a una niña de vestido blanco. \n Noble, pura, etérea... y con un aire de familiaridad. \n ¿Dónde la habías visto antes? Mientras luchabas por desenterrar recuerdos confusos, ella de repente pareció darse cuenta de tu existencia, mirándote a través del vacío. \n Sus ojos eran tranquilos como el océano en la primavera, pero extrañamente leíste algo en ellos... \n Parecía estar esperando que la saludases, aunque solo fuera para hablar del clima de hoy."
  },
  Event_7599_Name = {
    Text = "niña de vestido blanco"
  },
  Event_7600_ChoiceDesc1 = {
    Text = "[elogiarlo]selecciona 1 de las 3 cartas de comando para obtener un sigilo:\"(EnchantConfig.Arg1)\""
  },
  Event_7600_ChoiceDesc2 = {
    Text = "[Sátiralo] infecta «(Skill.Arg1)», reimprime aleatoriamente"
  },
  Event_7600_Desc = {
    Text = "Jenkins dijo: ¡Johnny! Eres realmente... muy diferente a como eras antes, en todos los aspectos. \n Tú dijiste: Eres realmente una mente trabajadora y ambiciosa. \n La mente se retorció un poco, visiblemente muy feliz. \n La mente dijo: ¡Vamos! Dado que ustedes reconocen tanto mis logros actuales, les otorgaré todo lo que he aprendido en mi vida..."
  },
  Event_7600_Name = {
    Text = "Cerebro filosófico"
  },
  Event_7601_ChoiceDesc1 = {
    Text = "[fuga espléndida] obtiene reliquia de plata\"(RelicConfig.Arg1)\"， infección\"(Skill.Arg2)\""
  },
  Event_7601_ChoiceDesc2 = {
    Text = "[Serenata Simple]Todos los Despertados recuperan 50 de Locura, infectar\"(Skill.Arg1)\""
  },
  Event_7601_ChoiceDesc3 = {
    Text = "[Ruido sin sentido]gana 3 a elegir plegaria"
  },
  Event_7601_Desc = {
    Text = "\"Personalmente, no estoy de acuerdo con el gusto musical del director, ya sabes...\nEs demasiado ostentoso, y yo soy una persona práctica.»\nLa voz cansada de un hombre solitario se escuchaba en el gramófono chirriante.\n«Pero es mi trabajo... bien, ahorremos tiempo, elige uno.»"
  },
  Event_7601_Name = {Text = "mal gusto"},
  Event_7602_ChoiceDesc1 = {
    Text = "[Hay un objeto especial]gana reliquia de oro\"(RelicConfig.Arg1)\""
  },
  Event_7602_ChoiceDesc2 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7602_Desc = {
    Text = "Evento 253 (en desarrollo), no es el efecto final"
  },
  Event_7602_Name = {
    Text = "Evento 253 (en desarrollo)"
  },
  Event_7603_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7603_Desc = {
    Text = "Corres lo más rápido posible.\nAhora enfrentan al monstruo más difícil y repugnante de todos: esas estatuas de cera.\nComparadas con ellas, estos simples muñecos de barro no son nada.\nPriorizar es una de las reglas de los guardianes del secreto"
  },
  Event_7603_Name = {Text = "Borrador"},
  Event_7604_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7604_Desc = {
    Text = "La llave de plata parpadea, el destello de plata llena el espacio, tiñendo el denso flujo de colores en plata pura.\nLa luminosidad se desvanece en un instante, solo el viento deja un lamento triste"
  },
  Event_7604_Name = {
    Text = "Colores nostálgicos"
  },
  Event_7605_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7605_Desc = {
    Text = "Ese arco iris te dejó deslumbrado, sin darte cuenta, te perdiste en él"
  },
  Event_7605_Name = {
    Text = "Cruce de Estrellas"
  },
  Event_7606_ChoiceDesc1 = {
    Text = "[Seguir Cayendo]Infectar\"(Skill.Arg1)\", ¿continuar cayendo?"
  },
  Event_7606_ChoiceDesc2 = {
    Text = "[Retirarse]obtienes 25 el sigilo negro"
  },
  Event_7606_Desc = {
    Text = "\"'Tú' te invita.\nEn las profundidades de la espiral, el 'Tú' del pasado y del futuro te ofrece 'regalos' de diferentes dimensiones.\""
  },
  Event_7606_Name = {
    Text = "Abismo espiral"
  },
  Event_7607_ChoiceDesc1 = {
    Text = "[entender bien]obtén reliquia de oro\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_7607_ChoiceDesc2 = {
    Text = "[sin saber nada]obtén 3 de 1 reliquia de oro, infecta\"(Skill.Arg1)\""
  },
  Event_7607_ChoiceDesc3 = {
    Text = "[Salir]obtiene reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_7607_Desc = {
    Text = "Dos figuras plateadas brillantes aparecen ante tus ojos, mostrando una consistencia líquida, flotando en el aire. \n\"Aquí es el lugar donde yo desaparecí.\"Una figura se agachó. \n\"En el Reino Divino, sin enfermedades ni desastres, no hay tal cosa como deseo y pérdida, realmente no sabes — qué significa desaparecer.\" \n La otra figura suspiró, dirigiendo su mirada hacia ti."
  },
  Event_7607_Name = {
    Text = "Reino Olvidado de los Dioses"
  },
  Event_7608_ChoiceDesc1 = {
    Text = "[Salir]buscar el reflector"
  },
  Event_7608_ChoiceDesc2 = {
    Text = "[Entrar en la niebla]Infecta\"(Skill.Arg2)\""
  },
  Event_7608_ChoiceDesc3 = {
    Text = "[Entrar directamente]"
  },
  Event_7608_Desc = {
    Text = "Delante hay una densa niebla negra, entrar imprudentemente traerá desastres.\nQuizás deberías encontrar un \"faro\" para disipar la niebla"
  },
  Event_7608_Name = {
    Text = "desconocido"
  },
  Event_7609_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7609_Desc = {
    Text = "\"Es una proyección de memoria,\" te explicó Ramona, \"podría pertenecer a una persona o a varias.\"\nRecuerdos valiosos, dignos de ser cuidados"
  },
  Event_7609_Name = {
    Text = "Nuestros Recuerdos"
  },
  Event_7610_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7610_Desc = {
    Text = "Aunque no puedas descifrarlo ahora, no te rendiste, lo doblaste cuidadosamente y lo guardaste en tu bolsillo, esperando encontrar otra forma de leerlo al regresar a la escuela. \nPero, a medida que la carta se arrugaba misteriosamente, tu pecho comenzó a doler"
  },
  Event_7610_Name = {
    Text = "Carta tachada"
  },
  Event_7611_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7611_Desc = {
    Text = "La vela se enciende automáticamente al dejar la balanza, derramando lágrimas blancas que desaparecen entre tus dedos"
  },
  Event_7611_Name = {
    Text = "Razón y Emoción"
  },
  Event_7612_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7612_Desc = {
    Text = "Apresuradamente, arrancas el papel de la máquina de escribir—pero esta sigue funcionando. En este momento de pánico, una Tarjeta de comando cae dentro y queda inutilizable, manchada con la más negra de las tintas.\nTe tomas un momento para deshacerte de ella con cuidado, pero no puedes evitar notar el ominoso texto repetido ahora escrito sobre ella;\n<Bold:NO MIRES DIRECTAMENTE>\n<Bold:NO MIRES DIRECTAMENTE>\n<Bold:NO MIRES DIRECTAMENTE>\n<Bold:NO MIRES DIRECTAMENTE>\n<Bold:NO MIRES DIRECTAMENTE>\n<Bold:NO MIRES DIRECTAMENTE>\n<Bold:NO MIRES DIRECTAMENTE>\n<Bold:NO MIRES DIRECTAMENTE>"
  },
  Event_7612_Name = {
    Text = "Advertencia no invitada"
  },
  Event_7613_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7613_Desc = {
    Text = "Al tocar el borde helado de la taza lo suficientemente fría para congelar tu médula, un escalofrío te despierta.\nNo es adecuado dejarlo al borde del camino. Mejor guardarlo en el maletín"
  },
  Event_7613_Name = {
    Text = "Vino dulce de miel"
  },
  Event_7614_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7614_Desc = {
    Text = "Toses fuerte.\nEl sonido parece asustarse y luego cae en silencio.\nSientes que has perdido una pista importante...\nPero la vida siempre está llena de pérdidas y arrepentimientos, ¿no?"
  },
  Event_7614_Name = {
    Text = "Los muros tienen oídos"
  },
  Event_7615_ChoiceDesc1 = {
    Text = "[Cerrarse a hablar] obtiene 25 el sigilo negro"
  },
  Event_7615_ChoiceDesc2 = {
    Text = "[Extender la mano]50% de probabilidad de obtener 50 el sigilo negro, 50% de probabilidad de no obtener nada"
  },
  Event_7615_Desc = {
    Text = "\"Solo tengo un proverbio que decir: ¡Nadie puede matar a un gato!\"\n\"¡Ese maldito gato negro debería haber sido destripado y dejado a la intemperie, pero en cambio, cavó en la tumba de mi familia, devorando la carne humana en descomposición, mientras los huesos y extremidades se dispersaban por todas partes!\"\n\"Bajo la fría y oscura mirada de sus pupilas verticales, un líquido amarillento y pútrido emergió con un hedor horrible. Escapé a rastras de allí, atormentado por pesadillas que me dejaron mentalmente exhausto.\"\n\"Espera... ¿qué van a hacer? ¡No estoy loco! ¡No lo estoy! ¡Ustedes deben estar tratando de encubrir algo! ¡Esto es real!—\"\nEsto es realmente cierto, mientras observas desvanecerse la sombra de la persona enloquecida, intercambias una mirada con el gato negro que se sienta tranquilo a tus pies."
  },
  Event_7615_Name = {
    Text = "Desgracia del gato nocturno"
  },
  Event_7616_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7616_Desc = {
    Text = "Mientras dudabas, se hundió en la d-marca y pronto desapareció"
  },
  Event_7616_Name = {
    Text = "Objeto flotante en el cubo"
  },
  Event_7617_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7617_Desc = {
    Text = "Aplastaste la carta con disgusto y la tiraste al suelo"
  },
  Event_7617_Name = {
    Text = "Carta tachada"
  },
  Event_7618_ChoiceDesc1 = {
    Text = "[Confirmar]"
  },
  Event_7618_Desc = {
    Text = "Te concentras, la ilusión se disipa como tinta. Sigues adelante, pero no puedes despejar la oscuridad en tu corazón"
  },
  Event_7618_Name = {Text = "Ilusión"},
  Event_7619_ChoiceDesc1 = {
    Text = "[examinar con precaución]obtén la reliquia de plata\"(RelicConfig.Arg1)\"，infecta\"(Skill.Arg2)\""
  },
  Event_7619_ChoiceDesc2 = {
    Text = "[Esquivar la sombra]obtiene la reliquia de plata\"(RelicConfig.Arg1)\"，contagiar\"(Skill.Arg2)\""
  },
  Event_7619_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_7619_Desc = {
    Text = "Ramona estaba tensa, moviéndose con cuidado por el manicomio para evitar a la gente.\nSe escondió en una pequeña habitación.\nUna sombra apareció repentinamente en la ventana"
  },
  Event_7619_Name = {
    Text = "Reflejo en la ventana"
  },
  Event_7620_ChoiceDesc1 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_7620_Desc = {
    Text = "Lo más importante ahora es llevar al culpable ante la justicia. Pero la semilla de la ira sigue creciendo en tu corazón. Sin esperar respuesta, el hombre se fue"
  },
  Event_7620_Name = {
    Text = "Huella de bestia gigante"
  },
  Event_7621_ChoiceDesc1 = {
    Text = "[Salir]obtiene 75 sigilos negros, infecta\"(Skill.Arg2)\""
  },
  Event_7621_Desc = {
    Text = "La educación en Missaga te impide ignorar esta impresión. Al limpiar el polvo, parece que escuchas una respuesta de una dimensión lejana, \"Gracias\""
  },
  Event_7621_Name = {
    Text = "Huella de bestia gigante"
  },
  Event_7622_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7622_Desc = {
    Text = "Aprietas la llave de plata, la suave luz plateada y la débil vibración te tranquilizan. La mirada parece desaparecer, o tal vez no, pero de cualquier manera, deja una marca invisible en ti"
  },
  Event_7622_Name = {
    Text = "Quién mira"
  },
  Event_7623_ChoiceDesc1 = {
    Text = "[Buscar pasadizo]"
  },
  Event_7623_Desc = {
    Text = "Tú, Ramona y Lotan se separan en tres direcciones y comienzan a perseguir al perro del infierno. \n\n Corres rápidamente por varias callejones, y una enorme figura aparece frente a ti. \n Al verte venir, inmediatamente gira en la siguiente esquina. \n Te lanzas tras él, pero lo que aparece ante ti es una calle sin salida, con tres muros altos que encierran un estrecho cielo cuadrado."
  },
  Event_7623_Name = {
    Text = "Calle sin salida"
  },
  Event_7624_ChoiceDesc1 = {Text = "[Pasar]"},
  Event_7624_ChoiceDesc2 = {
    Text = "[Acariciar]"
  },
  Event_7624_Desc = {
    Text = "Al lado de la mesa de operaciones limpia y suave, yace el cuerpo ya inerte de Kum.  \nTodavía es alta, como una pequeña montaña, como la primera vez que la viste.  \nPero, comparada con el verdadero \"sabueso infernal\" en el aire, ella es tan pequeña, tan pequeña como un niño"
  },
  Event_7624_Name = {
    Text = "Residuo de calor"
  },
  Event_7625_ChoiceDesc1 = {
    Text = "[Obtén núcleo de plata]"
  },
  Event_7625_Desc = {
    Text = "¿Eh, hay muchas cosas brillantes adelante! \nHuele... delicioso.\nLame... ¡fresquito! \nParece valioso, llévaselo a Jenkins, tal vez consiga mucho queso"
  },
  Event_7625_Name = {Text = "Brillante"},
  Event_7626_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7626_Desc = {
    Text = "Un sentimiento de decepción ajena se extiende por tu corazón. La red ilusoria se disipa lentamente, dejando libre un camino"
  },
  Event_7626_Name = {
    Text = "Red errante"
  },
  Event_7627_ChoiceDesc1 = {
    Text = "[Comprenderlo]Despierta aleatoriamente a 1 despertador, contagia\"(Skill.Arg1)\""
  },
  Event_7627_ChoiceDesc2 = {
    Text = "[Ignorar esto]gana 3 a elegir plegaria"
  },
  Event_7627_Desc = {
    Text = "Runas fluidas emergen del rugido de la criatura en forma de pez, llenando tus oídos, nariz y garganta. Queman tu cuerpo, y en diez segundos más, comprenderás el significado del rugido"
  },
  Event_7627_Name = {
    Text = "Rune de Frenesí"
  },
  Event_7628_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7628_Desc = {
    Text = "Aprietas los dientes, tratando de resistir la ilusión deslumbrante. Ramona coloca un objeto frío en tu mano. \n \"Este es un objeto que encontré recién, puede que te ayude.\""
  },
  Event_7628_Name = {
    Text = "Ilusión dimensional"
  },
  Event_7629_ChoiceDesc1 = {
    Text = "Elige una plegaria avanzada"
  },
  Event_7630_ChoiceDesc1 = {
    Text = "[Sujetar al cuervo] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_7630_ChoiceDesc2 = {
    Text = "[Matar al cuervo]gana 3 a elegir plegaria"
  },
  Event_7630_ChoiceDesc3 = {Text = "[Salir]"},
  Event_7630_Desc = {
    Text = "El cuervo solitario arrancaba sus plumas negras una por una con su voz ronca.\nTemblaba de dolor, gritaba agudamente, pero no podía detener sus movimientos cada vez más rápidos.\n\"¡Caw—Caw—\"\nLágrimas azules mezcladas con tinta negra fluían de sus ojos, y nadie más que tú lo veía.\n"
  },
  Event_7630_Name = {
    Text = "Lágrima de magma fundido"
  },
  Event_7631_ChoiceDesc1 = {
    Text = "[Salir]aumenta Arg1 puntos de salud máxima"
  },
  Event_7631_Desc = {
    Text = "\"Déjamelo a mí,\" acariciaste el hueso de la bestia, como si estuvieras calmando a un pequeño gato enojado, \"ella seguramente despertará, no le haremos daño.\""
  },
  Event_7631_Name = {
    Text = "Llamada de la amistad"
  },
  Event_7632_ChoiceDesc1 = {
    Text = "[Salir]aumenta Arg1 puntos de salud máxima, infecta\"(Skill.Arg2)\"y\"(Skill.Arg3)\""
  },
  Event_7632_Desc = {
    Text = "\"Despierta, Lily, Kum también quiere que despiertes pronto.\""
  },
  Event_7632_Name = {
    Text = "Llamada de la amistad"
  },
  Event_7633_ChoiceDesc1 = {Text = "[Salir]"},
  Event_7633_Desc = {Text = "Ya inútil"},
  Event_7633_Name = {
    Text = "Telegrama Silencioso"
  },
  Event_79429_ChoiceDesc1 = {
    Text = "Elige un despertador y transmútalo en \"Insectoide\" mediante un ritual de vida. El costo de aritmética de las cartas de comando de \"Insectoide\" se reduce en 1, pero se consumen tras ser jugadas."
  },
  Event_79429_Desc = {
    Text = "\"En el proceso de autoconocimiento, siempre hay dolor, y la metamorfosis y el nuevo nacido son lo mismo.\"\nElla sonríe suavemente, acariciando tu rostro con ternura. \n\"No tengas miedo, estoy aquí contigo, así que abre tu alma y todo lo que eres, acéptalo.\"\n\"Buen niño, espero tu nuevo nacido, espero que tú... te conviertas en uno de nosotros.\""
  },
  Event_79429_Name = {
    Text = "Metamorfosis de la vida"
  },
  Event_80463_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de reliquia de plata, infecta\"(Skill.Arg1)\""
  },
  Event_80463_Desc = {
    Text = "Has elegido el camino y corres desesperadamente con el pequeño William de la mano. \n Afortunadamente, tu elección fue correcta. \n Esas contaminaciones espirituales, esas Clementines idénticas, finalmente lograste dejarlas atrás. \n Por supuesto, tuviste que pagar un precio."
  },
  Event_80463_Name = {
    Text = "Las \"Clementines\""
  },
  Event_80464_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80464_Desc = {
    Text = "Un recuerdo que supera la comprensión es implantado en tu cerebro, aplastando directamente tu razón.\nEn esa imagen que parece avanzar a toda velocidad, solo recuerdas una escena: un templo triangular.\nEsa es la gran obra construida por @2Zerg para la gran y absurda @4."
  },
  Event_80464_Name = {
    Text = "Memoria Profunda"
  },
  Event_80465_ChoiceDesc1 = {
    Text = "[Salir]Despertar 1 Despertado, infectar\"(Skill.Arg1)\""
  },
  Event_80465_Desc = {
    Text = "Has elegido el camino y corres desesperadamente con el pequeño William de la mano. \n Afortunadamente, tu elección fue correcta. \n Esas contaminaciones espirituales, esas Clementines idénticas, finalmente lograste dejarlas atrás. \n Por supuesto, tuviste que pagar un precio."
  },
  Event_80465_Name = {
    Text = "Las \"Clementines\""
  },
  Event_80466_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80466_Desc = {
    Text = "¡Clic! ¡Clic! ¡Clic!\nEl «trabajo» finalmente terminado. Sin embargo, aparte del «trabajo» en sí, ¿qué más has obtenido?"
  },
  Event_80466_Name = {
    Text = "Tortura eterna"
  },
  Event_80467_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de oración"
  },
  Event_80467_Desc = {
    Text = "«Me alegra escuchar tu respuesta sincera.»\n«Espero con ansias nuestro próximo encuentro.»"
  },
  Event_80467_Name = {
    Text = "Llamada en el sueño"
  },
  Event_80468_ChoiceDesc1 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_80468_Desc = {
    Text = "\"Ay, qué niño tan deshonesto.\"\n\"Pero no importa, la próxima vez, te haré decir la verdad.\"\n\"Toda la verdad, surgida del corazón y el alma.\""
  },
  Event_80468_Name = {
    Text = "Llamada en el sueño"
  },
  Event_80469_ChoiceDesc1 = {
    Text = "[Comenzar \"trabajo\"]elimina 1 carta de comando, obtiene Arg1 sigilo negro"
  },
  Event_80469_ChoiceDesc2 = {
    Text = "Retrocede y aléjate"
  },
  Event_80469_Desc = {
    Text = "«¡Ka-da!»\nSuena la máquina de escribir, y antes de que el «trabajo» termine, tú siempre serás su esclavo.\n\n."
  },
  Event_80469_Name = {
    Text = "Tortura eterna"
  },
  Event_80470_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80470_Desc = {
    Text = "«Qué pena, tu precaución te hizo perder la única oportunidad de conocer la verdad.»\nSuspiró y se disolvió en el silencio."
  },
  Event_80470_Name = {
    Text = "Memoria Profunda"
  },
  Event_80471_ChoiceDesc1 = {
    Text = "[ATQ total]"
  },
  Event_80471_ChoiceDesc2 = {
    Text = "[Retrocede mientras luchas]"
  },
  Event_80471_Desc = {
    Text = "Una figura inesperada aparece frente a ti: es Clementine.\n«No te sorprendas, solo quiero hacer una prueba especial.»\n«Y en cuanto a en qué consiste la prueba, es un secreto.» Clementine sonríe. «Para ti, el único objetivo de esta prueba...»\n«¡es sobrevivir!»"
  },
  Event_80471_Name = {
    Text = "Prueba especial"
  },
  Event_80472_ChoiceDesc1 = {
    Text = "[Recuerdos del pasado]"
  },
  Event_80472_ChoiceDesc2 = {
    Text = "[Quitar las escamas del insecto]"
  },
  Event_80472_Desc = {
    Text = "\"Por favor, créeme, no tengo malas intenciones, solo quiero ayudarte.\"\nClementine te persigue, gritando en voz alta. \nSu voz suena increíblemente sincera, sin embargo, ya no puedes creer en nada. \nTu moral ha sido atravesada por la \"teoría de la cognición encarnada\", y tu razón está a punto de colapsar. \nDebes, debes hacer algo, resistir las escamas de insecto que crecen en tu carne, resistir la locura y desesperación que se infiltran gradualmente en tu alma."
  },
  Event_80472_Name = {
    Text = "Alma luchadora"
  },
  Event_80473_ChoiceDesc1 = {
    Text = "[Salir]eliminar 2 cartas"
  },
  Event_80473_Desc = {
    Text = "\"¿Quieres conservar tu fuerza para la batalla final?\"\n\"Una elección muy inteligente. Pero cuando una persona obtiene algo, en realidad también está perdiendo algo.\"\n\"Porque en este mundo cruel y en llamas, simplemente sobrevivir ya requiere pagar un precio.\""
  },
  Event_80473_Name = {
    Text = "Prueba especial"
  },
  Event_80474_ChoiceDesc1 = {
    Text = "[Ignorar esto]gana 3 a elegir plegaria"
  },
  Event_80474_ChoiceDesc2 = {
    Text = "[Tocarlo] 1 Tarjeta de comando aleatoria obtiene Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_80474_Desc = {
    Text = "Cosas extrañas similares a esporas llaman tu atención.\nParecen delicadas medusas hechas de carne, o fibras nerviosas que albergan señales en lo profundo del cerebro.\n«Tócame», te tienta en silencio, «te mostraré una memoria cruel»."
  },
  Event_80474_Name = {
    Text = "Memoria Profunda"
  },
  Event_80475_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de oración"
  },
  Event_80475_Desc = {
    Text = "\"Ramona, Doll, Lotan, Ogier...\"\n Susurras nerviosamente esos nombres una y otra vez. \n Tu razón, que se ha derrumbado, ya no puede recordar sus rostros, pero la existencia que representan esos nombres aún puede calentar tu corazón y tu alma. \n Ellos existieron, rieron, ellos... son tu línea de base y ancla para mantener tu humanidad en este momento."
  },
  Event_80475_Name = {
    Text = "Alma luchadora"
  },
  Event_80476_ChoiceDesc1 = {
    Text = "[Salir]obtiene elección de 3 para 1 de reliquia de plata, infecta\"(Skill.Arg1)\""
  },
  Event_80476_Desc = {
    Text = "«¡¡¡¡Aaaaaaah!»\nAbres la boca y gritas, un sonido que más que un grito parece un chillido.\nLas escamas de insecto arrancadas vuelven a crecer, y la cordura, una vez perdida, no regresa.\n\n."
  },
  Event_80476_Name = {
    Text = "Alma luchadora"
  },
  Event_80477_ChoiceDesc1 = {
    Text = "[Salir]obtener creación\"(RelicConfig.Arg1)\"，infectar\"(Skill.Arg2)\""
  },
  Event_80477_Desc = {
    Text = "No ocultas nada y das todo de ti. Esta actitud claramente complace a Clementine. \n «Eres un buen niño». \n «Entonces, déjame darte un pequeño premio. Por supuesto, tiene un precio». \n «En este cruel mundo en llamas, simplemente sobrevivir ya requiere pagar un precio»."
  },
  Event_80477_Name = {
    Text = "Prueba especial"
  },
  Event_80478_ChoiceDesc1 = {
    Text = "[Comenzar \"trabajo\"]elimina 1 carta de comando, obtiene Arg1 sigilo negro"
  },
  Event_80478_ChoiceDesc2 = {
    Text = "Retrocede y aléjate"
  },
  Event_80478_Desc = {
    Text = "«Clic. Clic.»\nSuena la máquina de escribir. Durante el «trabajo», tú solo eres la herramienta para completar el «trabajo»."
  },
  Event_80478_Name = {
    Text = "Tortura eterna"
  },
  Event_80479_ChoiceDesc1 = {
    Text = "[Correr a la izquierda]"
  },
  Event_80479_ChoiceDesc2 = {
    Text = "[Correr a la derecha]"
  },
  Event_80479_Desc = {
    Text = "Las figuras familiares te siguen de cerca, no una ni dos, sino decenas y cientos. \n El estrecho pasillo no puede soportar tal cantidad de «Clementines», por lo que algunas «Clementines» son empujadas al suelo y otras son pisoteadas hasta convertirse en barro. \n Pero todas ellas te llaman unidas, repitiendo esa frase que te sumerge en la contaminación mental. \n «¿Por qué huyes? Solo quiero ofrecerte una consulta psicológica.» \n Y tú, corres por el pasillo del sanatorio, enfrentándote a la elección de un cruce de caminos."
  },
  Event_80479_Name = {
    Text = "Las \"Clementines\""
  },
  Event_80480_ChoiceDesc1 = {
    Text = "[Comenzar \"trabajo\"]elimina 1 carta de comando, obtiene Arg1 sigilo negro"
  },
  Event_80480_ChoiceDesc2 = {
    Text = "Retrocede y aléjate"
  },
  Event_80480_Desc = {
    Text = "\"¡Modifica! ¡Trabajo! ¡No te detengas!\"\nIncontables zumbidos resuenan en tus oídos, llevándote a acercarte a esa máquina de escribir que apareció de repente. \n\"¿Qué hago, qué hago? He estado escribiendo desde la mañana hasta la noche, pero el trabajo nunca termina.\"\n\"¡Modifica! ¡Modifica! ¡Modifica el plan, presenta la solicitud, completa el trabajo!\"\n\"¡Trabajo! ¡Trabajo! ¡¡Trabajo!!\"\nEl alma zumbante choca contra la máquina de escribir que no deja de golpear, y finalmente, esa máquina se detiene. \nSin embargo, un momento después, esa máquina vuelve a funcionar. \n\"¡Modifica! ¡Trabajo! ¡No te detengas!\"\nPorque el trabajo nunca tiene fin."
  },
  Event_80480_Name = {
    Text = "Tortura eterna"
  },
  Event_80481_ChoiceDesc1 = {
    Text = "[Responde con sinceridad]"
  },
  Event_80481_ChoiceDesc2 = {
    Text = "<Yellow:No puedes responder>"
  },
  Event_80481_Desc = {
    Text = "En un instante, el paisaje frente a ti se volvió borroso y etéreo. \n Pensaste que era la habitación la que se estaba distorsionando, pero luego entendiste que era tu nervio óptico el que había sido invadido. \n \"Nos volvemos a ver.\" \n En la visión borrosa, Clementine sonreía con dulzura. \n \"Aunque nos encontramos antes de lo que imaginaba, aún estoy muy feliz. No sé si tú, %player%, sientes lo mismo.\""
  },
  Event_80481_Name = {
    Text = "Llamada en el sueño"
  },
  Event_80595_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80595_Desc = {
    Text = "\nFrente a tu intento de alejarla, la mariposa permanece indiferente.\nPersiste en perseguir tu palma, y en tu mano pierde la vida.\n«¡Ah, qué cálido...»\nEstas son sus últimas palabras.\n\n."
  },
  Event_80595_Name = {
    Text = "Sueño de la mariposa"
  },
  Event_80596_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80596_Desc = {
    Text = "\"Deseo que las flores siempre estén en flor, deseo que las sonrisas perduren para siempre.\"\n\"Deseo que todas las personas que sufren de Disolución puedan curarse y estar en paz, deseo que este mundo vuelva a ser como antes, sin volver a arder.\"\n\"Deseo que...\"\nLa pequeña mariposa agita sus alas, perdiendo la vida en la palma de tu mano. \nAl menos, alguien ha escuchado su voz."
  },
  Event_80596_Name = {
    Text = "Sueño de la mariposa"
  },
  Event_80597_ChoiceDesc1 = {
    Text = "[Ahuyentar a la Mariposa] 1 Tarjeta de comando aleatoria obtiene Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_80597_ChoiceDesc2 = {
    Text = "[Escuchar el deseo]elige 1 de 3 cartas de comando para obtener plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_80597_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_80597_Desc = {
    Text = "La pequeña mariposa también tiene muchos sueños.\nEstos sueños se esparcen en el mar de flores, en la sala de enfermos, y en el altar lleno de carne y sangre de @2.\nFinalmente, ha esperado a la persona que la ata, no sabe si estás dispuesto a escuchar su pequeño, pequeño deseo."
  },
  Event_80597_Name = {
    Text = "Sueño de la mariposa"
  },
  Event_80610_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80610_Desc = {
    Text = "«¿Racionalidad? Una respuesta interesante.»\n«Ojalá no te arrepientas de tu elección.»"
  },
  Event_80610_Name = {
    Text = "El precio de la humanidad"
  },
  Event_80612_ChoiceDesc1 = {
    Text = "[Alimentarlos]obtiene reliquia de plata\"(RelicConfig.Arg1)\", selecciona 1 para infectar síntoma"
  },
  Event_80612_ChoiceDesc2 = {
    Text = "[Ignorar]Elige 1 de 3 cartas de comando para obtener plegaria:\"(EnchantConfig.Arg1)\", infecta\"(Skill.Arg2)\""
  },
  Event_80612_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_80612_Desc = {
    Text = "Los residentes van y vienen, pero la multitud de ratas persiste. \n En comparación con los humanos, ellos son los \"nativos\" de este castillo. \n Sin embargo, no tienen objeciones a la llegada de los humanos. \n Porque esas cosas feas, suaves y blancas, les alimentan con cosas igualmente suaves y blancas. \n \"¿Y tú, cosa fea, a cuál de ellas perteneces?\""
  },
  Event_80612_Name = {
    Text = "El secreto del castillo"
  },
  Event_80613_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80613_Desc = {
    Text = "\nEn la oscuridad se escucha una risa suave.\n«Te estoy esperando, ven a verme.»\n«Pequeña criatura valiente.»"
  },
  Event_80613_Name = {
    Text = "\"Ella\" mira furtivamente"
  },
  Event_80614_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80614_Desc = {
    Text = "\"¡Cállate, cállate, suena horrible!\"\nEl gato negro se cubre las orejas de manera humanizada. \n\"Humano, tu idioma felino es realmente malo, ¡hablas cosas sin sentido!\"\nAunque dice esto, la expresión del gato negro se calma. \n\"Por el hecho de que me haces feliz con tus maullidos, te regalaré algo.\"\n\"En cuanto al contenido del regalo, depende de tu suerte.\""
  },
  Event_80614_Name = {Text = "Nigerman"},
  Event_80615_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80615_Desc = {
    Text = "\n\"Madre, después de perder a amigos, esposo e hijo, he perdido para siempre a Diana, mi pequeña hija.\"\n\"Cuando se convirtió en cenizas frente a mí, mi mente se quedó en blanco...\"Las palabras siguientes ya no son legibles. \nSolo puedes leer la siguiente línea. \nHe tomado la decisión. Si me vuelves a ver, por favor no me culpes, solo... los extraño demasiado."
  },
  Event_80615_Name = {
    Text = "Anhelo Desvanecido"
  },
  Event_80616_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80616_Desc = {
    Text = "Tu expulsión ha tenido efecto. Unos pocos cuerpos de apariencia confusa se retuercen al huir, la mayoría permanece en su lugar. \n Ya no ríen, ya no recitan, sino que lloran desconsoladamente. \n El llanto de los niños resuena en tus oídos, repitiendo solo una frase. \n \"¡Mata al monstruo!\""
  },
  Event_80616_Name = {
    Text = "La infancia de \"él\""
  },
  Event_80617_ChoiceDesc1 = {
    Text = "[Salir]infectar\"(Skill.Arg1)\""
  },
  Event_80617_ChoiceDesc2 = {
    Text = "[Salir]infectar\"(Skill.Arg1)\""
  },
  Event_80617_ChoiceDesc3 = {
    Text = "[Salir]infectar\"(Skill.Arg1)\""
  },
  Event_80617_Desc = {
    Text = "Tu alimentación ha complacido a la multitud de ratas.\nLa inmensa horda se agita y te ofrece un regalo envuelto en un paquete burdo.\nNo logras distinguir la apariencia del regalo, solo ves la gran cantidad de sangre que impregna el envoltorio."
  },
  Event_80617_Name = {
    Text = "El secreto del castillo"
  },
  Event_80618_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80618_Desc = {
    Text = "\"...\"\n\"..........\"\n\"............\"\nLa sombra permanece en silencio, quiere llorar pero ya ha perdido la capacidad de derramar lágrimas.\nFinalmente, solo suspira profundamente.\n«Amigo, ojalá puedas proteger lo que más valoras.»"
  },
  Event_80618_Name = {
    Text = "Hombre hueco"
  },
  Event_80619_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80619_Desc = {
    Text = "Tu regaño no tiene efecto, sino que los hace más frenéticos y alegres. \n Las risas y los cantos se elevan aún más, entonando otra canción infantil. \n \"William, el compañero mayor, en el alto castillo,\nRatas devoradoras de hombres corren por la pared.\nCuando llegue el momento del Sacrificio humano,\nTodos serán devorados, uno por uno.\""
  },
  Event_80619_Name = {
    Text = "La infancia de \"él\""
  },
  Event_80620_ChoiceDesc1 = {
    Text = "[Evitar mirada]Despertar aleatoriamente 1 entidad despierta"
  },
  Event_80620_ChoiceDesc2 = {
    Text = "[Mirada intensa]selecciona 1 despertador, y reduce su coste de consumo de carta de despertar en 2 puntos. Infección\"(Skill.Arg1)\""
  },
  Event_80620_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_80620_Desc = {
    Text = "Todo en el sanatorio está bajo su control y observación. Por supuesto, tú también. Pero ella está dispuesta a hacerte la vista gorda. Después de todo, un juego es más divertido cuando hay interacción mutua."
  },
  Event_80620_Name = {
    Text = "\"Ella\" mira furtivamente"
  },
  Event_80621_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80621_Desc = {
    Text = "Colocas el sobre de vuelta en su lugar, preparándote para irte, pero de repente escuchas un susurro confuso. \n\"A petición mía, la doctora Clementine finalmente habló. \nMe describió ese vasto universo, en el misterioso cosmos, debe haber una forma de salvarlos. \nEstoy listo para el\"nuevo nacido\", sin importar cuántos años luz tenga que vagar, anhelo verlos de nuevo.\""
  },
  Event_80621_Name = {
    Text = "Anhelo Desvanecido"
  },
  Event_80622_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80622_Desc = {
    Text = "La doctora Clementine me salvó. \n Ella es realmente una persona muy, muy buena, dispuesta a escuchar mi voz. \n Realmente quiero decir algunas cosas felices, cosas alegres, sin embargo, en este momento, aparte del dolor y la desesperación, no tengo nada más. \n Me temo que voy a decepcionar la buena intención de la doctora. \n Después de perderlos, la vida para mí solo es desolación."
  },
  Event_80622_Name = {
    Text = "Anhelo Desvanecido"
  },
  Event_80623_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80623_Desc = {
    Text = "«¡Tú, tú...!»  \n«¡Hmph, no está mal tu técnica! Esta vez apruebas. ¡Pero la próxima no será tan fácil!»  \nEl gato negro dio un salto y corrió ágilmente hacia la distancia."
  },
  Event_80623_Name = {Text = "Nigerman"},
  Event_80624_ChoiceDesc1 = {
    Text = "[Atacar al gato negro]50% de probabilidad de obtener 125 sigilos negros, 50% de probabilidad de infectar «(Skill.Arg2)»"
  },
  Event_80624_ChoiceDesc2 = {
    Text = "[Imitar maullidos]75% de probabilidad de obtener 100 sigilos negros, 25% de probabilidad de infectar «(Skill.Arg2)»"
  },
  Event_80624_ChoiceDesc3 = {
    Text = "[Intentar acariciar al gato]obtiene 50 sigilos negros"
  },
  Event_80624_Desc = {
    Text = "\"¡Eh! Tú, prohíbete avanzar.\"\nLos gatos negros saltan de repente, impidiéndote continuar. \nLamen sus patas con elegancia, mostrando una actitud desafiante y orgullosa. \n\"Adelante está lleno de peligros, no es un lugar que pueda explorar un humano tan débil como tú.\"\nExpresaste tu determinación de seguir adelante, en ese momento, la pupila vertical del gato negro líder giró, revelando su naturaleza cruel de jugar con la presa. \"Entonces, demuéstranos tu determinación.\""
  },
  Event_80624_Name = {Text = "Nigerman"},
  Event_80625_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80625_Desc = {
    Text = "\nTu indiferencia enfurece a la horda de ratas, que gritan y se precipitan hacia ti, pero tú, mucho antes de que la horda de ratas se moviera, ya habías huido lejos."
  },
  Event_80625_Name = {
    Text = "El secreto del castillo"
  },
  Event_80626_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80626_Desc = {
    Text = "«¡Ah, así es, rompe mis alas!»  \n«Tiempo, salud, dignidad, vida... me han arrebatado demasiado.»  \n«Este último sueño, por supuesto, tampoco me pertenece.»  \n«Porque solo soy un pájaro encerrado y privado de libertad.»"
  },
  Event_80626_Name = {
    Text = "Hombre hueco"
  },
  Event_80627_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80627_Desc = {
    Text = "\"¿Sentimental? Una respuesta interesante.\"\n\"Ojalá no te arrepientas de tu elección.\""
  },
  Event_80627_Name = {
    Text = "El precio de la humanidad"
  },
  Event_80628_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80628_Desc = {
    Text = "«Acepto tu súplica.»\nUn zumbido se acerca, penetrando lentamente en tu cerebro a través del canal auditivo.\nTu cerebro tiembla, y en ese temblor, escuchas la «voz» del universo.\n«Conmigo, conéctate.»"
  },
  Event_80628_Name = {
    Text = "Redención Oscura"
  },
  Event_80629_ChoiceDesc1 = {
    Text = "[Rogar]Despertar aleatoriamente a 1 entidad despierta, infectar «(Skill.Arg1)»"
  },
  Event_80629_ChoiceDesc2 = {
    Text = "[Rechazar]obtienes sello de 3 opciones"
  },
  Event_80629_Desc = {
    Text = "\"No debería ser así, no debería ser así.\"\n\"Claramente, debería liberarme de esta vida humana tan primitiva y evolucionar a algo más avanzado...\"\nEn la oscuridad, se oyen sollozos de dolor. \nEstos sollozos se agrupan, surgen, formando un enorme zumbido. \n\"Este mundo en llamas, como un agujero negro insaciable, devora a cada persona, así que—\"\n\"¡Ruega por mí, el infinito universo te otorgará redención!\""
  },
  Event_80629_Name = {
    Text = "Redención Oscura"
  },
  Event_80630_ChoiceDesc1 = {
    Text = "[Abrir el sobre]obtienes una reliquia de oro «(RelicConfig.Arg1)», infección «(Skill.Arg2)»"
  },
  Event_80630_ChoiceDesc2 = {
    Text = "[Leer]elija 1 carta de comando de entre 3 para obtener plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_80630_ChoiceDesc3 = {
    Text = "[Dejar en su lugar]obtén 50 sigilos negros"
  },
  Event_80630_Desc = {
    Text = "En una esquina olvidada, yacía una carta abandonada. \nMuchas de las palabras escritas ya no eran legibles, pero solo una palabra destacaba con intensidad. \nEsa palabra era \"madre\"."
  },
  Event_80630_Name = {
    Text = "Anhelo Desvanecido"
  },
  Event_80631_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80631_Desc = {
    Text = "\"Ja, humanos insignificantes, has tomado la decisión equivocada.\"\nLos gatos negros te miran fríamente y atacan repentinamente.\n\"Debes pagar el precio—por supuesto, también respetamos a los fuertes.\""
  },
  Event_80631_Name = {Text = "Nigerman"},
  Event_80632_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80632_Desc = {
    Text = "\nEn la oscuridad se escucha una risa suave.\n«Te estoy esperando, ven a verme.»\n«Pequeña criatura adorable.»"
  },
  Event_80632_Name = {
    Text = "\"Ella\" mira furtivamente"
  },
  Event_80633_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80633_Desc = {
    Text = "Bajo tu ataque, esta multitud de figuras retorcidas y extrañas finalmente huye. \n Todo está tranquilo alrededor, solo tu corazón late en un llanto silencioso. \n Así que esta es la infancia de \"él\".\n\n."
  },
  Event_80633_Name = {
    Text = "La infancia de \"él\""
  },
  Event_80635_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80635_Desc = {
    Text = "«¡Ah, la pequeña trampa de palabras ha sido descubierta!»\n«Esto es una recompensa. Porque...»\n«No todas las decisiones deben ser elegidas.»"
  },
  Event_80635_Name = {
    Text = "El precio de la humanidad"
  },
  Event_80636_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80636_Desc = {
    Text = "\"@3Rebelde\"\nEl zumbido se fue debilitando hasta desaparecer. Solo quedaron las últimas palabras.\n«Conservar la humanidad no permite sobrevivir en este mundo cruel.»"
  },
  Event_80636_Name = {
    Text = "Redención Oscura"
  },
  Event_80637_ChoiceDesc1 = {
    Text = "[Elegir rechazar]elimina 1 carta de comando, obtén Arg1 sigilo negro"
  },
  Event_80637_ChoiceDesc2 = {
    Text = "[Elegir obedecer]Copiar 1 carta de comando, infectar\"(Skill.Arg1)\""
  },
  Event_80637_ChoiceDesc3 = {
    Text = "[Elegir abrazo]selecciona 1 de las 3 cartas de comando para obtener un sello:\"(EnchantConfig.Arg1)\""
  },
  Event_80637_Desc = {
    Text = "\"Soy un pájaro enjaulado, encerrado en un patio lleno de muchas habitaciones.\"\nEn la oscuridad, se mueven sombras borrosas, son las obsesiones dejadas por los que han partido. \n\"Dicen que es un manicomio, pero yo sé que es una prisión especial para humanos, que encierra a los pájaros libres que no quieren seguir las reglas de la sociedad.\"\n\"Pero, ¿puede un pájaro ser llamado pájaro si no puede volar?\"\nLas obsesiones se acercan a ti, suplicando redención. \n\"Por favor, rompe mis alas, estoy cansado de volar.\""
  },
  Event_80637_Name = {
    Text = "Hombre hueco"
  },
  Event_80638_ChoiceDesc1 = {Text = "[Salir]"},
  Event_80638_Desc = {
    Text = "\"...\"\n\"..........\"\n\"............\"\nLa sombra tiembla y se funde repentinamente en tu cuerpo.\n«Amigo, adelante, para proteger lo que más valoras.»\n«Aunque ya hemos desaparecido, aún deseamos dedicarte nuestra última bendición.»"
  },
  Event_80638_Name = {
    Text = "Hombre hueco"
  },
  Event_80639_ChoiceDesc1 = {
    Text = "[Elegir lo emocional]Recupera Arg1 puntos de vida"
  },
  Event_80639_ChoiceDesc2 = {
    Text = "[Mantener la razón]elige aleatoriamente 1 carta de comando y obtén un sello:\"(EnchantConfig.Arg1)\""
  },
  Event_80639_ChoiceDesc3 = {
    Text = "[Rechazar la opción]obtienes 25 sigilos negros"
  },
  Event_80639_Desc = {
    Text = "\"Elige, elige.\"\nEn la oscuridad que corre desenfrenada, se oyen innumerables susurros. \nEsta voz es suave y hipnótica, parece llevar consigo un poder infinito, provocando en ti una especie de locura fantasmagórica. \nTu cerebro se sumerge en la locura, retorciéndose fuera de tu cuerpo, mientras que tu corazón parece haber desarrollado una cierta conciencia, gritándote y llamándote. \n\"Elige, elige.\"\n\"Mantén la razón o la emoción, debes tomar una decisión.\""
  },
  Event_80639_Name = {
    Text = "El precio de la humanidad"
  },
  Event_80641_ChoiceDesc1 = {
    Text = "[Reprender a \"ellos\"]Infectar\"(Skill.Arg1)\", obtener reliquia maldita\"(RelicConfig.Arg2)\""
  },
  Event_80641_ChoiceDesc2 = {
    Text = "[alejar a «ellos»]infecta dos veces «(Skill.Arg1)», obtén una reliquia de plata «(RelicConfig.Arg2)» y «(RelicConfig.Arg3)»"
  },
  Event_80641_ChoiceDesc3 = {
    Text = "[Atacar \"ellos\"]obtiene una reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_80641_Desc = {
    Text = "\"William Jr., es un monstruo, duerme en la tumba, nadie lo ama. No te acerques a él, ten cuidado de que no te haga daño en secreto.\"\nUna figura de la que no se puede distinguir el rostro se retorcía, pero su voz sonaba como la de un niño. \nSe ríen y recitan, mirándote con una mirada despectiva y ansiosa. \nCon malicia."
  },
  Event_80641_Name = {
    Text = "La infancia de \"él\""
  },
  Event_90571_ChoiceDesc1 = {
    Text = "[Disfrútalo]Añade 1 carta \"Cóctel especial de la noche espiritual\" al mazo."
  },
  Event_90571_Desc = {
    Text = "Una mesa lujosa, una pista de baile animada, utensilios elegantes, un cadáver fragante...\nOh, sé que estás ansioso, pero espera un momento más, querido huésped.\nEsta bebida, especialmente preparada por el anfitrión del banquete, es un regalo exclusivo para los distinguidos invitados.\nTómala. Bébela. Disfruta de esta alegría en su retrogusto!"
  },
  Event_90571_Name = {
    Text = "Ritual previo al banquete"
  },
  Event_91460_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91460_Desc = {
    Text = "No puedes resistirte, solo puedes permitir que el sonido te atraviese.\nUn chillido agudo abre tu cerebro, algunos miedos olvidados fluyen hacia afuera, sientes su hambre.\n¡Una aterradora criatura caníbal...!"
  },
  Event_91460_Name = {
    Text = "Confesión Silenciosa"
  },
  Event_91461_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91461_Desc = {
    Text = "Ya no te contienes, dejas que ese calor se libere por completo, y todas las palabras no dichas estallan constantemente desde tu cráneo.\nSientes una inspiración maravillosa y te deleitas en el talento de Pickman."
  },
  Event_91461_Name = {
    Text = "Volcán Durmiente"
  },
  Event_91462_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91462_Desc = {
    Text = "La lengua de fuego se enredó con manchas de tinta, dejando un rastro de sangre. \n En ese momento, caes en la frontera entre el sueño y la realidad. Te ves convertido en una niña, tomando la mano de Doresain para danzar juntos. \n Cuando despiertas y miras de nuevo a Doresain, un profundo dolor inunda tu mente."
  },
  Event_91462_Name = {
    Text = "Revelación del Sueño"
  },
  Event_91463_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91463_Desc = {
    Text = "Te lanzas hacia adelante, las llamas se esconden bajo tu piel. En cuanto al cuadro, cualquiera que lo vea no será más que un retrato ordinario. \n En los sueños posteriores, siempre verás a tu yo en llamas, dorado a la perfección, y luego, algún día, servido en tu propia mesa."
  },
  Event_91463_Name = {
    Text = "Retrato Ardiente"
  },
  Event_91464_ChoiceDesc1 = {
    Text = "[Escuchar]obtiene 30 sigilos negros, infecta «(Skill.Arg2)», continúa eligiendo"
  },
  Event_91464_ChoiceDesc2 = {
    Text = "[Ignorar]Salir"
  },
  Event_91464_Desc = {
    Text = "En el ruido silencioso, poco a poco comprendiste el lenguaje de los cuervos..."
  },
  Event_91464_Name = {
    Text = "Confesión Silenciosa"
  },
  Event_91465_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91465_Desc = {
    Text = "Recoges una piedra y despiertas a las sombras de ratas que estaban concentradas en comer. \nTe miran con avidez. \nHueles el olor húmedo y sucio de sus cuerpos, como si fuera un presagio."
  },
  Event_91465_Name = {
    Text = "Reino Exiliado"
  },
  Event_91466_ChoiceDesc1 = {
    Text = "[Escuchar]obtiene 25 sigilos negros, infecta «(Skill.Arg2)», continúa eligiendo"
  },
  Event_91466_ChoiceDesc2 = {
    Text = "[Ignorar]Salir"
  },
  Event_91466_Desc = {
    Text = "Está dando la bienvenida. ¿A quién da la bienvenida?\n¡Por supuesto que a ti!\nQuizás te considera su deliciosa comida para mañana."
  },
  Event_91466_Name = {
    Text = "Confesión Silenciosa"
  },
  Event_91467_ChoiceDesc1 = {
    Text = "[Cortar la palma] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infecta \"(Skill.Arg2)\""
  },
  Event_91467_ChoiceDesc2 = {
    Text = "[Aceptar el crecimiento]obtén la reliquia de plata\"(RelicConfig.Arg1)\", infecta\"(Skill.Arg2)\""
  },
  Event_91467_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_91467_Desc = {
    Text = "La mariposa no vino volando, sino que creció lentamente desde tu palma. \n Al principio pensaste que era solo sudor, pero entre los dedos viste un líquido negro que brotaba silenciosamente como si fuera un vaso sanguíneo, solidificándose en alas frías y pulsantes. \n Cada aleteo provoca ondas en tu sangre."
  },
  Event_91467_Name = {
    Text = "Parásito de la alta sociedad"
  },
  Event_91468_ChoiceDesc1 = {
    Text = "[Rescatar el retrato] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_91468_ChoiceDesc2 = {
    Text = "[Aceptar el vacío] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: \"(EnchantConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_91468_ChoiceDesc3 = {
    Text = "[Salir]obtiene 25 sigilos negros"
  },
  Event_91468_Desc = {
    Text = "Te encuentras frente al regalo de Pickman. \n Es un retrato, pintado con sangre, con llamas negras que arden silenciosamente. \n A través de los vacíos ojos del retratado, ves— \n tus recuerdos arden y se agitan, se alargan, se distorsionan, brillan, como si un fuego invisible estuviera lamiendo los pasillos de tu mente. En un momento de confusión, oyes una voz. \n\"Es hora de ponerlo en la olla, el fuego está justo bien.\"\n Esta es la escena de recuerdos que tú mismo has pintado, luchando y deformándote en las llamas."
  },
  Event_91468_Name = {
    Text = "Retrato Ardiente"
  },
  Event_91469_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91469_Desc = {
    Text = "Rechazas la llamada y observas en silencio cómo vibra hasta detenerse.\nA lo largo de tantos años, has aprendido bien a luchar contra la locura."
  },
  Event_91469_Name = {
    Text = "Llamada perdida"
  },
  Event_91470_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91470_Desc = {
    Text = "Das un paso hacia atrás y dejas que la tela arda en llamas.\nVes cómo tu cuerpo se tuesta hasta alcanzar un dorado apetecible, la grasa se derrite y crepita con un sonido crujiente, como si pudieras oler el aroma de la carne a través de la tela.\n¿Esta es la tentación que sintió Dullahan?"
  },
  Event_91470_Name = {
    Text = "Retrato Ardiente"
  },
  Event_91471_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91471_Desc = {
    Text = "Con una curiosidad casi sacrílega, o tal vez con el desesperado valor de enfrentar lo desconocido, buscas una revelación en las sombras del pasado. \nVes a una chica bailando junto a un hombre alto cuyo rostro es borroso, y una alegría inexplicable llena tu corazón."
  },
  Event_91471_Name = {
    Text = "Sombra del pasado"
  },
  Event_91472_ChoiceDesc1 = {
    Text = "[Detener registro]Eliminar 2 cartas"
  },
  Event_91472_ChoiceDesc2 = {
    Text = "[Continuar escribiendo]obtén reliquia maldita\"(RelicConfig.Arg1)\", infecta\"(Skill.Arg2)\""
  },
  Event_91472_ChoiceDesc3 = {
    Text = "[Salir]obtiene Arg1 sigilo negro"
  },
  Event_91472_Desc = {
    Text = "Por fin te has liberado temporalmente del mercado de los gules, encontrando un rincón tranquilo para comenzar a registrar como de costumbre. \n La máquina de escribir tiembla furiosamente, las teclas se presionan solas, y un moco negro brota de las grietas, empapando tu cordura en las yemas de los dedos. \n Ves que en la hoja de papel comienzan a aparecer sombras de mariposas que claman por salir..."
  },
  Event_91472_Name = {
    Text = "Sombras de Mariposa"
  },
  Event_91473_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91473_Desc = {
    Text = "Es extraño, aunque nunca has aprendido este idioma, parece que entiendes su significado. \n El versículo está lleno de añoranza por los seres queridos, esta añoranza trasciende la vida y la muerte, y se transmite en tus sueños. \n Al final del poema, logras distinguir vagamente la escritura— \n es \"Celina\"."
  },
  Event_91473_Name = {
    Text = "Revelación del Sueño"
  },
  Event_91474_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91474_Desc = {
    Text = "Cortas con dolor la piel de tu palma, quemando la nueva carne alada con fuego. \n Un líquido negro se eleva, y la mariposa se rompe. \n Todo queda limpio y sin rastro, pero siempre sientes un débil aleteo en tu mano, como si una idea que no logró incubarse del todo aún respirara lentamente en tus venas. \n Doresain no se pronuncia al respecto, solo se lleva la sangre que dejaste."
  },
  Event_91474_Name = {
    Text = "Parásito de la alta sociedad"
  },
  Event_91475_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91475_Desc = {
    Text = "Sabes que la inspiración obsesiva siempre trae desastres, así que usaste la razón para sellarlo todo."
  },
  Event_91475_Name = {
    Text = "Volcán Durmiente"
  },
  Event_91476_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91476_Desc = {
    Text = "Fijas tu mirada en ese ojo, intentando comprender el mensaje que transmite. \n Aunque ya estás acostumbrado a la batalla, esta vez frente a Goliat... el miedo aprisiona tu corazón. \n «Casi normal, esa era la forma más silenciosa antes del desastre»."
  },
  Event_91476_Name = {
    Text = "Casi normal"
  },
  Event_91477_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91477_Desc = {
    Text = "Cierras los ojos y te adentras en la llanura.\nPuedes percibir el deseo y los presagios ocultos, pero nunca podrás detenerlos con tus propias manos.\nMirando las lápidas sin inscripciones a tu alrededor, quizás este sea tu destino."
  },
  Event_91477_Name = {
    Text = "Fiesta de Cuervos"
  },
  Event_91478_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91478_Desc = {
    Text = [[
Levantas lentamente la cabeza, y en ese momento, la luz atraviesa tus pupilas, el calor florece en blanco en tu mente. 
 Las estrellas de Necrovia no son diferentes a las de otros lugares, y los ghouls que parecen tener una eternidad solo pueden existir bajo las Estrellas, sin libertad.]]
  },
  Event_91478_Name = {
    Text = "Noche de las Estrellas"
  },
  Event_91479_ChoiceDesc1 = {
    Text = "[Echar al fuego]Elimina 1 carta"
  },
  Event_91479_ChoiceDesc2 = {
    Text = "[Intentar interpretar]Obtener \"(RelicConfig.Arg1)\", infectar \"(Skill.Arg2)\""
  },
  Event_91479_Desc = {
    Text = "Tu conciencia flota en la neblina negra infinita, atravesando los paisajes espirituales de innumerables vivos y muertos. \n En el sueño, una máquina de escribir mágica escupe un verso extraño. ¿De quién es esta historia? \n Está inscrita en un papel de origen desconocido, la escritura distorsionada parece haber sido escrita a mano por un borracho consciente. \n Te sientes impulsado por un anhelo indescriptible en el sueño, tomas ese papel, y la tinta salta entre las sombras del fuego."
  },
  Event_91479_Name = {
    Text = "Revelación del Sueño"
  },
  Event_91480_ChoiceDesc1 = {
    Text = "[Unirse]infecta\"(Skill.Arg1)\", aleatoriamente 1 carta obtiene un sello:\"(EnchantConfig.Arg2)\""
  },
  Event_91480_ChoiceDesc2 = {
    Text = "[Alejar]infecta\"(Skill.Arg1)\", aleatoriamente 1 carta obtiene un efecto: «(EnchantConfig.Arg2)»"
  },
  Event_91480_ChoiceDesc3 = {
    Text = "[Ignorar]elige 1 de 3 cartas de comando y obtén plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_91480_Desc = {
    Text = "Escuchas el sonido distante y tenue de un cuerno de hueso. \n La multitud de ratas surge del barro negro, devorando los cuerpos anónimos que yacen en el lecho seco del río. \n Forman un círculo, con el centro siendo el cadáver ya vacío, y la circunferencia es un nuevo reino donde el olvido es la ley. \n Y tú, estás de pie en la entrada de este reino."
  },
  Event_91480_Name = {
    Text = "Reino Exiliado"
  },
  Event_91481_ChoiceDesc1 = {
    Text = "[Mirar hacia arriba]obtener reliquia de plata «(RelicConfig.Arg1)»"
  },
  Event_91481_ChoiceDesc2 = {
    Text = "[Mirar hacia abajo y salir]obtiene 75 sigilos negros, infecta \"(Skill.Arg2)\""
  },
  Event_91481_Desc = {
    Text = "Los cuervos giran en el cielo, como una sierra dudosa que corta repetidamente la espina dorsal del cielo.\nVuelan bajos a tu alrededor, como si presagiaran tu muerte, esperando pacientemente el inicio del festín.\n\n"
  },
  Event_91481_Name = {
    Text = "Fiesta de Cuervos"
  },
  Event_91482_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91482_Desc = {
    Text = "Dejas que continúe escribiendo, con tu pulso, tu dolor, tu pasado y tus conjeturas.\nLa mariposa rompe las ataduras del papel, y tu alma se libera.\nComienzas a imaginarte disfrutando en un parque de atracciones. No le dijiste a Doresain que, en realidad, te gusta mucho el parque de atracciones, incluso si es un parque de atracciones de cadáveres...\nNo debería... ser demasiado macabro, ¿verdad?"
  },
  Event_91482_Name = {
    Text = "Sombras de Mariposa"
  },
  Event_91483_ChoiceDesc1 = {
    Text = "[Volver a observar]elige 1 de 3 cartas de comando para obtener plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_91483_Desc = {
    Text = "La cena clara del pasado se convirtió en un banquete sangriento y confuso, recuerdas los ingredientes en la estufa, el olor a podrido estimula tu nariz.\nEl miedo agarra tu corazón, tienes que tomar una decisión."
  },
  Event_91483_Name = {
    Text = "Sombra del pasado"
  },
  Event_91484_ChoiceDesc1 = {
    Text = "[Ignorar el timbre]obtener 3 opciones de sello avanzado"
  },
  Event_91484_ChoiceDesc2 = {
    Text = "[Levantar el auricular]Obtén una reliquia de oro\"(RelicConfig.Arg1)\", infección\"(Skill.Arg2)\""
  },
  Event_91484_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_91484_Desc = {
    Text = "No debería haber sonado—el teléfono, acurrucado detrás del lienzo. \n El cable del auricular está enrollado alrededor del gran cuerpo de la máquina, como un cordón umbilical oxidado, que parece extenderse desde tu mente. \n Intentas discernir la frecuencia de la vibración, el extraño sonido es como el arte surrealista de Pickman."
  },
  Event_91484_Name = {
    Text = "Llamada perdida"
  },
  Event_91485_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91485_Desc = {
    Text = "Amas esa fría cabeza, y en un instante se convierte en un flujo de agua que cae silenciosamente entre tus dedos. \n La balanza pierde su equilibrio, el corazón colapsa rápidamente como una fruta podrida, fusionándose en un charco de agua negra y silenciosa. \n Todo el hambre desaparece, y obtienes calma, sin arrepentimientos y una breve claridad."
  },
  Event_91485_Name = {
    Text = "Juego del Hambre"
  },
  Event_91486_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91486_Desc = {
    Text = "No hay sonido, nadie responde. ¿Quizás solo fue una broma? \nJusto cuando dejas el auricular, una sensación de peso vuelve a tu interior."
  },
  Event_91486_Name = {
    Text = "Llamada perdida"
  },
  Event_91487_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91487_Desc = {
    Text = "El cuervo desapareció.\nPero te ves de pie frente a un espejo de otra noche, observando a este cuervo.\nSigue gritando en silencio, como esperando tu respuesta."
  },
  Event_91487_Name = {
    Text = "Confesión Silenciosa"
  },
  Event_91488_ChoiceDesc1 = {
    Text = "[Volver a observar]elige 1 de 3 cartas de comando para obtener plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_91488_ChoiceDesc2 = {
    Text = "[Rendirse]infecta «(Skill.Arg1)», cambia el sello obtenido en la opción 1, que se puede usar una vez más"
  },
  Event_91488_Desc = {
    Text = "Desvías firmemente la mirada, pero esas imágenes aparecen como sombras en tus ojos...\nEs una danza triste para dos personas."
  },
  Event_91488_Name = {
    Text = "Sombra del pasado"
  },
  Event_91489_ChoiceDesc1 = {
    Text = "[Disfrutar]elige 1 de entre 3 cartas de comando para obtener plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_91489_ChoiceDesc2 = {
    Text = "[Rechazar amablemente]infecta «(Skill.Arg1)», reimprime, hasta 2 veces"
  },
  Event_91489_Desc = {
    Text = "Eso fue preparado con esmero por Dulcayn para ustedes, que investigaron arduamente. \nSin especias pero sin olor a podrido, tal como dijo Dulcayn, es el mejor ingrediente. \nEl banquete está dispuesto para ti, y el cerebro permanece en silencio en el plato. \n\"¿Quieres probarlo?\""
  },
  Event_91489_Name = {
    Text = "Degustando Delicias"
  },
  Event_91490_ChoiceDesc1 = {
    Text = "[Escuchar]obtiene 40 sigilos negros, infecta «(Skill.Arg2)», sigue eligiendo"
  },
  Event_91490_ChoiceDesc2 = {
    Text = "[Ignorar]obtener 25 el sigilo negro，salir"
  },
  Event_91490_Desc = {
    Text = "Era un cuervo. \nEstaba posado sobre la lámpara de calavera, abrió el pico, pero no emitió ningún sonido.\n"
  },
  Event_91490_Name = {
    Text = "Confesión Silenciosa"
  },
  Event_91491_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91491_Desc = {
    Text = "Extiendes lentamente la mano hacia ese corazón aún caliente, que late y se contrae, hasta convertirse en una fragancia caliente que se dispersa. \n La balanza tiembla violentamente, y tu mente cae en la oscuridad infinita. \n Una sensación de saciedad reemplaza el hambre, y comprendes la pasión, el dolor y los verdaderos recuerdos."
  },
  Event_91491_Name = {
    Text = "Juego del Hambre"
  },
  Event_91492_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91492_Desc = {
    Text = "Levantas la cabeza, recibiendo esa rotación silenciosa, como un peregrino de antiguos rituales. \nEllos disfrutan alegremente de tu carne y sangre, sientes dolor, pero también claridad. \nVes a tu yo perdido, esas partes que no pudieron morir, finalmente han sido llevadas. \nCuando la conciencia regresa, te das cuenta de que estás a salvo."
  },
  Event_91492_Name = {
    Text = "Fiesta de Cuervos"
  },
  Event_91493_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91493_Desc = {
    Text = "Sellaste el agujero de la cerradura con el cemento de tus recuerdos y emociones, la verdad ya no puede tentarte.\nAl ver tu expresión como si enfrentaras una gran amenaza, Dursain lamió sus labios.\n\"¿Aún quieres probarlo? Es una mozzarella especial para el Guardián de Secretos.\""
  },
  Event_91493_Name = {
    Text = "Apocalipsis"
  },
  Event_91494_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91494_Desc = {
    Text = "La verdad es que siempre has tenido curiosidad por la experiencia de un ghoul.\n«Así que entraste en la manada de ratas, convirtiéndote en uno más de ellos—»\nNo puedes evitar admitir que la llegada de los marineros ha hecho que tu mente esté algo confusa."
  },
  Event_91494_Name = {
    Text = "Reino Exiliado"
  },
  Event_91495_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91495_Desc = {
    Text = "No quieres mancharte con la corrupción y el caos.\nYa te has acostumbrado, todo el decaimiento parece normalidad."
  },
  Event_91495_Name = {
    Text = "Reino Exiliado"
  },
  Event_91496_ChoiceDesc1 = {
    Text = "[Disfrutar]elige 1 de entre 3 cartas de comando para obtener plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_91496_ChoiceDesc2 = {
    Text = "[Rechazar amablemente]infecta «(Skill.Arg1)», reimprime aleatoriamente"
  },
  Event_91496_Desc = {
    Text = "Dulcayn corta elegantemente un trozo de «cerebro» para ti. \nEste sabor dulce... \nEsta textura suave y esponjosa... \nRealmente quieres probar otro bocado."
  },
  Event_91496_Name = {
    Text = "Degustando Delicias"
  },
  Event_91497_ChoiceDesc1 = {
    Text = "[Estoy soñando]obtén la reliquia de plata\"(RelicConfig.Arg1)\""
  },
  Event_91497_ChoiceDesc2 = {
    Text = "[Esto no es normal]obtiene la reliquia de oro «(RelicConfig.Arg1)», infecta «(Skill.Arg2)»"
  },
  Event_91497_Desc = {
    Text = "La lápida lisa refleja un ojo que se está distorsionando lentamente. \n Parece estar cargando una imagen que el ojo humano no puede describir, un recuerdo que no te pertenece, pero que ya está profundamente arraigado en las arrugas de tus ojos. \n Intentas parpadear, frotar con la yema de los dedos, pero ese ojo ya no te pertenece, comienza a reflejar una escena como un caleidoscopio."
  },
  Event_91497_Name = {
    Text = "Casi normal"
  },
  Event_91498_ChoiceDesc1 = {
    Text = "[Seguir observando]elige 1 de 3 cartas de comando y obtén plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_91498_ChoiceDesc2 = {
    Text = "[Desviar la mirada]infección\"(Skill.Arg1)\", cambia el sello obtenido en la opción 1, puede usarse dos veces"
  },
  Event_91498_Desc = {
    Text = "En un rincón húmedo del castillo, descubriste el rollo de película. \n Las imágenes son como fantasmas ahogados en el río del tiempo, congelándose en un lento fotograma, a veces expandiéndose en objetos indescriptibles, a veces colapsando en puntos brillantes e inestables. \n Te sumerges en ello, un mareo te recuerda el transcurso del tiempo."
  },
  Event_91498_Name = {
    Text = "Sombra del pasado"
  },
  Event_91499_ChoiceDesc1 = {
    Text = "[Mirar fijamente las estrellas]obtiene la reliquia de oro «(RelicConfig.Arg1)», infecta «(Skill.Arg2)»"
  },
  Event_91499_ChoiceDesc2 = {
    Text = "[Cerrar los ojos]Despertar aleatoriamente a 2 entidades, infectar dos veces «(Skill.Arg1)»"
  },
  Event_91499_ChoiceDesc3 = {
    Text = "[Salir]obtiene 50 sigilos negros"
  },
  Event_91499_Desc = {
    Text = "Te encuentras de pie en un cementerio desierto, la existencia de las estrellas hace que la noche brille como el día. \n Las esferas de luz que flotan en el profundo mar del tiempo nunca han hablado, pero en su giro largo como murmullos, se enfocan lentamente. \n Te observan la solitaria estrella olvidada. \n Él te observa, observando toda la muerte y la eternidad."
  },
  Event_91499_Name = {
    Text = "Noche de las Estrellas"
  },
  Event_91500_ChoiceDesc1 = {
    Text = "[Escuchar]obtiene 20 sigilos negros, infecta «(Skill.Arg2)»"
  },
  Event_91500_ChoiceDesc2 = {
    Text = "[Ignorar]Salir"
  },
  Event_91500_Desc = {
    Text = [[
Te mira fijamente.
En la oscuridad, ves un fuego codicioso.]]
  },
  Event_91500_Name = {
    Text = "Confesión Silenciosa"
  },
  Event_91501_ChoiceDesc1 = {
    Text = "[Abrir la cerradura]obtener reliquia maldita\"(RelicConfig.Arg1)\", infectar\"(Skill.Arg2)\""
  },
  Event_91501_ChoiceDesc2 = {
    Text = "[Sellar la cerradura] 1 Carta aleatoria obtiene Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_91501_Desc = {
    Text = "Frente al lóbulo cerebral que te ofrece Doresain, rechazas varias veces, pero al final no puedes resistir la tentación de la sabiduría. \n El conocimiento no llega lentamente, sino que se derrama de repente. \n Tu cerebro comienza a doler, y el pensamiento sigue expandiéndose como un pan en fermentación. Cuando finalmente caes, el dolor se retira como una marea, y tu conciencia parece tener un vacío, dejando un agujero limpio y antiguo. \n ¡Esa es la forma del conocimiento! Sientes una sabiduría sin precedentes. \n Quizás... ¿puedes obtener más?"
  },
  Event_91501_Name = {
    Text = "Apocalipsis"
  },
  Event_91502_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91502_Desc = {
    Text = "Utilizas la hoja afilada de los restos de tu conciencia para forzar la cerradura. \n No sabes qué es una llave, solo intentas con tu obsesión. En ese momento, tu pensamiento se consume, dejando solo una cierta lógica no humana susurrando en el vacío de la cerradura. \n ¿Es esto la revelación? Te emocionas al compartirlo con Doresain. \n \"¿Aún quieres probarlo? Es una mozzarella especial para el Señor Guardián del secreto.\""
  },
  Event_91502_Name = {
    Text = "Apocalipsis"
  },
  Event_91503_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91503_Desc = {
    Text = "No lo detonas, ni lo reprimes.\nDesde un estado de observación misteriosa, contemplas esos pensamientos rebosantes como parte del cambio climático, dejándolos fluir solos hacia un desenlace desconocido.\nEn la obra de sangre y carne, has comprendido el arte eterno."
  },
  Event_91503_Name = {
    Text = "Volcán Durmiente"
  },
  Event_91504_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91504_Desc = {
    Text = "La tecla se detiene bruscamente, las mariposas desaparecen al instante.\n¿Es una ilusión? Sientes un vacío.\nQuizás debería escuchar a Dursayn e ir a comprar algunas hojas cerebrales a la tienda de memorias enlatadas.\n«No, ¿en qué estoy pensando?»"
  },
  Event_91504_Name = {
    Text = "Sombras de Mariposa"
  },
  Event_91505_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91505_Desc = {
    Text = "Ya no luchas, permitiendo que las alas y el líquido negro penetren en las líneas de tu palma.\nTe has convertido en su recipiente, mientras ella sigue pensando dentro de ti.\nLa mariposa crece cada vez más, y finalmente no puedes soportar su peso.\nAl ver esto, Doresain, emocionado, corta la conexión entre tú y la mariposa con un cuchillo de mesa. Su mirada ansiosa claramente indica que quiere...\nTú rechazas su solicitud."
  },
  Event_91505_Name = {
    Text = "Parásito de la alta sociedad"
  },
  Event_91506_ChoiceDesc1 = {
    Text = "[Escuchar]obtiene 35 sigilos negros, infecta «(Skill.Arg2)», continúa eligiendo"
  },
  Event_91506_ChoiceDesc2 = {
    Text = "[Ignorar]Salir"
  },
  Event_91506_Desc = {
    Text = "Pensabas que estaba en silencio, hasta que de repente tu conciencia se inclinó, como si incontables cabezas de cuervos chillaran dentro de tu mente.\nTe arrodillas en el suelo, el mundo gira ante tus ojos."
  },
  Event_91506_Name = {
    Text = "Confesión Silenciosa"
  },
  Event_91507_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91507_Desc = {
    Text = "Cierras los ojos y entras en esa niebla interminable y suave. Las nebulosas te abrazan, y pierdes tu forma, una existencia más sólida que el cuerpo se asienta dentro de ti. \n Esa noche, las estrellas continúan girando, brillantes como siempre. \n ¿Qué significa el cielo estrellado para los que viven eternamente? Quizás deberías preguntar a Doresain."
  },
  Event_91507_Name = {
    Text = "Noche de las Estrellas"
  },
  Event_91508_ChoiceDesc1 = {
    Text = "[Disfrutar]elige 1 de entre 3 cartas de comando para obtener plegaria:\"(EnchantConfig.Arg1)\""
  },
  Event_91508_Desc = {
    Text = "Resulta que es queso. \nTe alegras, pero también sientes un poco de arrepentimiento."
  },
  Event_91508_Name = {
    Text = "Degustando Delicias"
  },
  Event_91509_ChoiceDesc1 = {
    Text = "[Encender]infección\"(Skill.Arg1)\", obtén una reliquia de plata\"(RelicConfig.Arg2)\""
  },
  Event_91509_ChoiceDesc2 = {
    Text = "[Esperar]infección\"(Skill.Arg1)\", obtén una reliquia de plata\"(RelicConfig.Arg2)\""
  },
  Event_91509_ChoiceDesc3 = {
    Text = "[Sellado]obtén 25 sigilos negros"
  },
  Event_91509_Desc = {
    Text = "Miraste fijamente la pintura de Pickman, y el nauseabundo olor a descomposición te hizo sentir mareado.\nLos pensamientos surgieron lentamente de tu mente, al principio solo calor, luego una leve niebla, y después..."
  },
  Event_91509_Name = {
    Text = "Volcán Durmiente"
  },
  Event_91510_ChoiceDesc1 = {
    Text = "[Tocar el cerebro]Seleccionar 1 carta de comando aleatoria para obtener un sello:\"(EnchantConfig.Arg1)\""
  },
  Event_91510_ChoiceDesc2 = {
    Text = "[Tocar el corazón]aumenta Arg1 puntos de salud máxima, infecta\"(Skill.Arg2)\""
  },
  Event_91510_Desc = {
    Text = "Entras en la sala gris donde nadie susurra, una balanza aparece vagamente en la niebla negra. \n A la izquierda, hay un cerebro tranquilo como un lago, con surcos plateados que brillan débilmente; a la derecha, un corazón de color rojo ardiente que emana vapor caliente. \n De repente, sientes un aroma, un deseo voraz se expande constantemente, y la razón es comprimida por su oscuridad infinita. \n Extiendes la mano."
  },
  Event_91510_Name = {
    Text = "Juego del Hambre"
  },
  Event_91511_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91511_Desc = {
    Text = "Esto debe ser un sueño. Te lo repites una y otra vez. \n Sin darte cuenta, realmente caes en un sueño profundo. \n Quizás debido a demasiadas conversaciones recientes, sueñas con Dursay — ¿incluso le ofreces tu propia carne y sangre para que las coma? ¿Qué historia de terror es esta?"
  },
  Event_91511_Name = {
    Text = "Casi normal"
  },
  Event_91660_ChoiceDesc1 = {
    Text = "[Buscar otro camino] Elige 1 de 3 Tarjetas de comando para obtener Inscripción: [(EnchantConfig.Arg1)]"
  },
  Event_91660_ChoiceDesc2 = {
    Text = "[Dejar que exista]aleatoriamente 3 cartas de comando obtienen el sello: «(EnchantConfig.Arg1)», infecta «(Skill.Arg2)»"
  },
  Event_91660_Desc = {
    Text = "\"Impulsar el alma, necesitas guiar a los muertos hasta el final.\"\n Acompañado por las palabras de Doresain, parece que tienes una Epifanía. \n No es conocimiento, ni memoria—esa cosa se asemeja más a un peso, que se filtra por tus cuencas oculares, inundando tu cerebro como una riada. \n Tus emociones parecen ya no pertenecer a este momento y lugar, se retiran, revelando una rendija descuidada del universo. \n Todo lo que puedes percibir se detiene allí, como si hubieras llegado al final de un camino."
  },
  Event_91660_Name = {
    Text = "Fin del Alma"
  },
  Event_91661_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91661_Desc = {
    Text = "Haces que el alma se aleje. \n En el límite del \"yo\", parece que escuchas el susurro de los muertos. \n Pero cuando intentas escuchar con atención, todo desaparece."
  },
  Event_91661_Name = {
    Text = "Fin del Alma"
  },
  Event_91662_ChoiceDesc1 = {Text = "[Salir]"},
  Event_91662_Desc = {
    Text = "Envuelves tu conciencia para así aislar la tentación desconocida.  \nTe pierdes en el límite de tu alma, solo ves tu propio ser.  \nRealmente, como ser humano vivo que eres, no puedes poseer la habilidad de un ghul."
  },
  Event_91662_Name = {
    Text = "Fin del Alma"
  }
})
return Text_Event
