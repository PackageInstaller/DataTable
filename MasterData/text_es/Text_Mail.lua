__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Mail = readonly({
  Mail_100480_Desc = {
    Text = "¡Guardián de secretos, ¿has oído? El extraño museo de arte en las afueras de la ciudad está a punto de cerrar, justo en el día de mi cumpleaños.\n Ese museo es un fenómeno en el mundo del arte, con una mitad de experimentos futuristas superficiales y la otra mitad llena de restos de hace dos siglos. Su estrecho interior está repleto de extraños objetos que nadie se atreve a tocar en las casas de subastas: retratos que dicen groserías, pájaros mecánicos que nunca dejan de volar, relieves marinos que provocan náuseas, estatuas hechas completamente de lágrimas, manuscritos fantasmales que escriben automáticamente y cráneos humanos que cantan canciones infantiles al ser besados...\n ¡Es difícil describir cuánto amo este museo! Hoy, hace cincuenta años, nació silenciosamente en ese rincón olvidado. Hoy, cincuenta años después, está muriendo en ese mismo rincón.\n Desde mi infancia, me han dicho que este día es una maldición, al igual que yo. Creo que el destino realmente ha estado escrito desde el principio, pero ¿qué importa que esté destinado? Lo que ese museo creó es un mundo único, con tantas locuras acumuladas en ese pequeño espacio, ¡qué maravillosa imagen! Desde el día de su nacimiento, ha estado creando con sus exposiciones. En este día de su final, sus amigos íntimos y viejos amigos también le darán su último adiós.\n Guardián de secretos, usted ha visto el mundo a través de mis ojos en el enlace, y creo que también estará ansioso por visitar este peculiar museo conmigo, ¿verdad?!\n\n Pikman"
  },
  Mail_100480_Name = {
    Text = "La Sala de Exposición No Observada"
  },
  Mail_100480_Sender = {Text = "Pickman"},
  Mail_116602_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"Día polar y Noche eterna\" ha terminado, y ahora convertiremos los \"Visita de ofrenda\", \"Confesión ritual\", \"Lealtad y ofrenda\" restantes del guardián según la proporción de \"Rosa Dorada*40\" por cada uno, por favor, recuerda recogerlo."
  },
  Mail_116602_Name = {
    Text = "Recuperación de regalos"
  },
  Mail_116602_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_117308_Desc = {
    Text = "Estimado Guardián del Secreto: \n        Gracias por su apoyo y reconocimiento a [Víspera del olvido]. Para ofrecer a los Guardianes del Secreto una mejor experiencia de juego en la Universidad de Misag, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su colaboración, hemos preparado un[Núcleo de plata *200] como recompensa, que podrá reclamar al completar la encuesta. La fecha límite para la encuesta es el 10 de noviembre a las 9:00, por favor, asegúrese de completarla a tiempo. \n        <SurveyLink:[Haga clic aquí para completar]>\n        Escucharemos atentamente las sugerencias de cada Guardián del Secreto, ¡su retroalimentación sin duda hará que la Universidad de Misag sea cada vez mejor! \n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_117308_Name = {
    Text = "Cuestionario de experiencia de versión V2.3.4"
  },
  Mail_117308_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_117309_Desc = {
    Text = "Estimado Guardián del secreto:\n        Gracias por su apoyo y reconocimiento a [Víspera del olvido]. Para mejorar la experiencia de juego de los guardianes en la Universidad de Misag, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su colaboración, hemos preparado un[Núcleo de plata*200] como recompensa, que podrá reclamar al completar la encuesta. La fecha límite para enviar la encuesta es el 30 de marzo a las 9:00, por favor, asegúrese de completarla a tiempo.\n        <SurveyLink:[Haga clic aquí para completar]>\n        Escucharemos atentamente las sugerencias de cada Guardián del secreto, ¡su retroalimentación seguramente hará que la Universidad de Misag sea cada vez mejor!\n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_117309_Name = {
    Text = "Cuestionario de experiencia de versión V2.4.3"
  },
  Mail_117309_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_120374_Desc = {
    Text = "El plazo de dos años ha llegado, Guardián del secreto. \n Una vez estuvimos en la frontera del final, vigilándonos mutuamente. \n Convertiste tus sentimientos y recuerdos en deseos, iluminando la Luz de la Esperanza. \n A pesar de estar separados de antiguos compañeros en dos universos, nunca has renunciado a la lucha contra la Disolución. \n Tenerte es nuestra fortuna, y también la fortuna de este mundo. \n Ahora tu deseo ha provocado un milagro: Misaq sigue existiendo aquí y continuará avanzando. \n Por favor, sigue sosteniendo la Llave de Plata, algún día, puede convertirse en el eje clave que conecte dos mundos distantes. \n Haremos todo lo posible para abrir posibilidades para el futuro, iluminando tu regreso."
  },
  Mail_120374_Name = {
    Text = "Momento de milagro, Luz de regreso"
  },
  Mail_120374_Sender = {
    Text = "Gato de la escuela Misaq·Light"
  },
  Mail_120909_Desc = {
    Text = "Estimado guardián del secreto: \n En la actualización V2.4.0, hemos incrementado las recompensas de la \"donación de líquido de origen - fondo de donaciones de exalumnos\". Para los guardianes del secreto que ya han reclamado las recompensas adicionales antes de la actualización, se les enviarán las recompensas correspondientes. Por favor, verifique."
  },
  Mail_120909_Name = {
    Text = "Reemisión de recompensa por donación de líquido de origen V2.4.0"
  },
  Mail_120909_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_121162_Desc = {
    Text = "Estimado Guardián del Secreto:\n        En la actualización V2.4.0, hemos aumentado las recompensas gratuitas de \"Expédition d'Arrivée\", \"Viaje a otro siglo\", \"Crónica del Sanatorio\" y \"Crónicas de la Ciudad Perdida\". Para los Guardianes del Secreto que ya han reclamado las recompensas gratuitas antes de la actualización, enviamos las recompensas correspondientes. Por favor, verifique."
  },
  Mail_121162_Name = {
    Text = "Reemisión de recompensa de actualización de crónicas V2.4.0"
  },
  Mail_121162_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_121373_Desc = {
    Text = "Guardían del secreto: \n\nEste día, que solía ser la celebración más grandiosa de la iglesia, \nsoy Su princesa, y también haré que Él renazca. \nEsos, incluidos Miryam, celebran con fervor, incluso con lágrimas en los ojos, pero me miran, sus miradas atraviesan mi ser, como si solo fuera una cáscara vacía que lleva algo. \nNunca me he sentido feliz por la llegada de este día, porque cada vez que pasa, significa que me acerco más al miedo. \nY en medio de ese miedo, los demás sienten una inmensa alegría por la fuente de su temor. Ahora puedo admitirlo, me hace sentir sola y asustada. \nPero ahora todo es diferente, antes de mi último cumpleaños, dejé ese barco y llegué al mundo real... un mundo sin dioses falsos, un mundo donde existes tú. \nEste cumpleaños, espero ver a alguien que se sienta genuinamente feliz por mi nacimiento, no por otra cosa. \nSi eres tú... no, esa persona debe ser tú. \nEscucha, de cualquier manera, la hora de la cena de hoy, debe ser para mí. \n\n\"Murphy\""
  },
  Mail_121373_Name = {
    Text = "Con tu existencia..."
  },
  Mail_121373_Sender = {
    Text = "Murphy: fauxborn"
  },
  Mail_121374_Desc = {
    Text = "Guardián del Secreto: \n\nNo sé qué preparativos has hecho para este día tan especial, cualquier lujo y esfuerzo que hayas hecho son evidentemente apropiados. \nY debido a la consideración necesaria de un superior, si tú \"sorprendentemente\" olvidaste celebrar mi cumpleaños —creo que una situación tan absurda no ocurrirá. \nEsta carta también te brindará una última oportunidad para salvarte antes de que la situación sea irreversible. \nLas maravillas y manjares del océano y la tierra, naturalmente, serán ofrecidos por personas irrelevantes, no son importantes. \nUna gran celebración y ceremonias elaboradas ciertamente coinciden con mi identidad, pero hoy, no sé por qué, parecen un poco aburridas. \nAsí que me tomaré un tiempo durante el amanecer y el atardecer para concederte el honor de estar a solas conmigo, como recompensa por llevarme a esta vida vulgar, infantil, pero tan feliz que haría que mi yo anterior sintiera celos. \nUn sirviente te traerá más tarde la invitación formal, por supuesto, guardada en una caja que vale veinte mil Leonian Florin. \nRecuerda con gratitud este día cada año. \n\"Murphy\""
  },
  Mail_121374_Name = {
    Text = "Carta de invitación..."
  },
  Mail_121374_Sender = {
    Text = "Murphy: fauxborn"
  },
  Mail_121651_Desc = {
    Text = "Estimado guardián del secreto:\nEn la inmersión fantasmal de la semana pasada, obtuviste el título\"{s1}».\nEn el modo de pregrupo de la semana pasada, obtuviste el título\"{s2}», con un total de victorias de: {s3} partidas.\nEn el modo de selección de rueda de la semana pasada, obtuviste el título\"{s4}», con un total de victorias de: {s5} partidas.\nDe acuerdo con estos resultados de desafío, recibirás las siguientes recompensas adicionales, por favor recuerda recogerlas."
  },
  Mail_121651_Name = {
    Text = "Recompensas semanales de clasificación de duelo profundo"
  },
  Mail_121651_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_121704_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"Olas de Deseo·clon\" ha terminado, y ahora procederemos a convertir el \"Núcleo de Fertilidad\" restante del guardián a razón de cada uno canjeado por \"Rosa Dorada*40\". Por favor, recuerda verificar."
  },
  Mail_121704_Name = {
    Text = "La Recuperación de la Semilla Madre"
  },
  Mail_121704_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_122522_Desc = {
    Text = "Estimado guardián del secreto: \n La actividad \"Sombra de la ciudad lluviosa·clon\" ha terminado, y ahora procederemos a convertir los \"Cráneo de Bestia Pálida\", \"Cráneo de Bestia Sombría\" y \"Cráneo de la Bestia Carmesí\" restantes del guardián según la proporción de \"Rosa Dorada\" × 40 por cada uno. Por favor, recuerda recogerlo."
  },
  Mail_122522_Name = {
    Text = "Recuperación de moneda de Sombra de la ciudad lluviosa"
  },
  Mail_122522_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_122567_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"Sacrificio de la niebla\" ha terminado, y ahora procederemos a convertir los \"Visión de la \"Niebla\"\", \"Sueño de \"Niebla\"\", \"\"Fuente\" de la niebla\" restantes del guardián según la proporción de \"Rosa Dorada*40\" por cada uno, por favor, recuerda recogerlo."
  },
  Mail_122567_Name = {
    Text = "Recuperación de moneda del Sacrificio de la niebla"
  },
  Mail_122567_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_122568_Desc = {
    Text = "Ah, pobre niño, no tienes idea de la desesperación a la que te enfrentarás. ¿Cuándo te darás cuenta de que tus elecciones son insignificantes? ¿Arriesgar tu pequeña vida por un objetivo etéreo? ¡Qué heroico, qué embriagador! Siempre te muestras con una actitud resuelta, como si estuvieras a punto de sacrificarse para salvar el mundo, ¡es realmente risible!\n\n Sin embargo, ¿quién me mandó a prometer que te ayudaría a regresar a casa? Una promesa hecha a un pequeño perro, siempre la cumpliré. Hablando de ello, no puedo esperar a ver con qué tipo de voluntad empujarás esta locura hasta el final. Ah... ¡tanta curiosidad, es tan intrigante!\n\n Gran \"salvador\", trae tu absurdo, tu terquedad, y esa obstinación insignificante. Una vez que el tren hacia el vacío se ponga en marcha, no habrá posibilidad de detenerse, excepto la destrucción.\n\n Un loco satisfecho... aguanta un poco más en Su sueño, te ayudaré, esperaré, y disfrutaré de tu respuesta final!"
  },
  Mail_122568_Name = {
    Text = "El tren hacia el olvido"
  },
  Mail_122568_Sender = {
    Text = "Doll: Infierno"
  },
  Mail_122569_Desc = {
    Text = "Señor, \n siempre he creído que un caballero no son las armaduras y los emblemas que lleva puestos, sino la lealtad y la voluntad de protección que lleva en su corazón. A través de sus acciones y decisiones, usted me ha mostrado verdaderamente lo que significa ser un caballero. Así he llegado a comprender la verdadera esencia del caballero: no se trata de ser honrado por un nombre, sino de proteger a los demás; no se trata de ser valiente por la gloria, sino de estar firme por la responsabilidad. \n\n Entiendo que aún no soy competente — en el momento en que usted luchaba por proteger la esperanza, no pude estar a su lado. Nunca he olvidado el juramento que hicimos en el pasado, le ofrezco mi lealtad de caballero, protegeré su seguridad y eliminaré a sus enemigos. \n\n A menudo recuerdo la primera investigación que realizamos juntos, usted nos guió para despejar la niebla de Londinium y ver la verdad final. Todos esos momentos de risas y lamentos se han convertido en una fuerza imborrable en mi vida. \n\n Aunque ahora solo puedo vigilar desde lejos y preparar este pequeño obsequio para usted... Sin embargo, para no defraudar las expectativas de mi señor, nunca he descuidado mi entrenamiento. Cuando regrese, por favor, permítame seguir sus pasos, ¡estaré como el escudo de mi señor para siempre! ¡Mi espada guardiana brillará para usted!"
  },
  Mail_122569_Name = {Text = "Vigilante"},
  Mail_122569_Sender = {Text = "Ogier"},
  Mail_122570_Desc = {
    Text = "Excelentísimo Guardián del Secreto, \n desde que nos despedimos en la Necrovia, a menudo he recordado los momentos en que luchamos juntos. He oído que una vez más has elegido el camino solitario, reservado solo para reyes, y efectivamente, eres una existencia tan especial en este mundo, que nunca sigues el camino de los mortales. \n\n Estoy convencido de que la agonía extrema puede forjar un alma más rica. La larga prueba que has atravesado ya ha superado el ámbito del dolor mundano. Puedo imaginar que tu aroma, forjado en el sufrimiento, será tan complejo y tan impactante. No, si eres tú, seguramente superarás todas mis imaginaciones y romperás mi percepción de la perfección. \n\n Por ello, continuaré esperando. Esperando ese banquete que solo existe para ti y para mí. Al final del tiempo, en el silencio del inicio de la eternidad, ¿con qué postura nos ofrecerás este... banquete que atraviesa el sabor del destino? \n\n Excelentísimo, por favor acepta mi regalo, por favor extiende esta agonía... no me falles, en mis expectativas."
  },
  Mail_122570_Name = {
    Text = "La Vigilia de la Banquete"
  },
  Mail_122570_Sender = {Text = "Doresain"},
  Mail_122571_Desc = {
    Text = "Apenas nos hemos reencontrado, y aún no hemos intercambiado muchas palabras, el tiempo ya se ha agotado... Pero tú sabes que la despedida nunca ha sido el final de nuestra historia. \n\n Hay algo que no te he contado... En realidad, ya he preparado un ramo de rosas para ti. Solo que no lo he enviado, ya se ha marchitado. Pero aquí te prometo: la próxima vez que nos veamos, definitivamente prepararé otro ramo para ti. \n\n Y tú, también me prometiste que volverías a estar frente a mí. Lo que sellamos, absolutamente, absolutamente no debe romperse. \n\n Siempre siento que las cartas no expresan lo que quiero decir, en el papel no puedo plasmar todo mi corazón. Sin embargo... cuando el destino nos reúna de nuevo frente a frente, te ofreceré ese ramo de rosas con mis propias manos. ¡Recuerda, debemos cumplir con nuestra promesa! \n\n Que la Llave de Plata ilumine tu camino. Adiós... %player%."
  },
  Mail_122571_Name = {
    Text = "El pacto de las rosas"
  },
  Mail_122571_Sender = {Text = "Ramona"},
  Mail_122572_Desc = {
    Text = "Guardián del Secreto, \n los recuerdos de la lucha contra la catástrofe oscura siguen siendo leídos en mi cerebro con alta prioridad, la paz que has obtenido es como un evento de regalo de probabilidad extremadamente baja. Sin embargo, tu partida está consumiendo de manera incesante la conciencia de tu compañero y de todos aquellos con los que has establecido conexión. \n\n El departamento de investigación nunca ha dejado de buscar la última esperanza. Afortunadamente, después de innumerables ciclos diurnos y nocturnos sin tu retroalimentación consciente, finalmente hemos localizado tu rastro. En este peligroso viaje, he podido captar señales de miedo, pero también sé que el miedo no te rendirá, solo hará que tu voluntad sea más fuerte. \n\n En este momento, mi cuerpo sigue funcionando en el laboratorio, pero mi cerebro sigue generando órdenes de llanto. No interfieras más en mis pensamientos, estudiante que más falta a clase, por favor no faltes más a mi lección... sigue avanzando con valentía, te prepararé suministros y esperaré el día de nuestro reencuentro."
  },
  Mail_122572_Name = {
    Text = "Día de Reencuentro..."
  },
  Mail_122572_Sender = {Text = "Doll"},
  Mail_122573_Desc = {
    Text = "Incontables veces, he observado la chispa de la civilización parpadear en el río del tiempo, testificando cómo las ciudades de la memoria colapsan en el olvido. La historia se convierte en un rollo devorado por llamas oscuras, la sabiduría de antaño se acumula como torres de arena, pero al final no puede expresar la única verdad. \n\n La humanidad frente al caos primordial es solo un grano de polvo — pero precisamente por esta insignificancia, el coraje de enfrentarse al abismo y empuñar la espada contra los dioses se vuelve tan desgarrador. \n\n En este instante, la Puerta de Dimensión que atraviesa miles de universos se abre para ti. \n\n Su llegada trae el caos predestinado, el orden de todas las cosas tiembla bajo su sombra. Y tú, solo un ser mortal, te encuentras frente a Él con una voluntad inquebrantable. Tu posibilidad es el único error que no puedo capturar en mi infinita previsión, es la variable que ha estado esperando para revolucionar todo. \n\n Eres la pregunta primordial, así como la respuesta final."
  },
  Mail_122573_Name = {
    Text = "Detrás de la puerta"
  },
  Mail_122573_Sender = {Text = "Tawil"},
  Mail_122574_Desc = {
    Text = "El dolor agudo de perder a alguien importante, el odio hacia mi propia impotencia... alguna vez estuve profundamente atrapado en ello, sin poder escapar. Pero ahora, he escuchado el llamado de la luz lejana, sintiendo su guía cálida y firme. Benefactor, desde que usted me iluminó, parece que finalmente he pisado el camino que debí recorrer—un camino que realmente me pertenece, una rectitud indiscutible. \n\n La oscura profundidad que una vez me envolvió ya no es mi hogar. Y esa luz que siempre parpadea en lo profundo de mi conciencia nunca se ha alejado de mí. Ahora la veo más claramente, la percibo, y me acerco a ella. También deseo llevar esta verdadera fe, esta claridad y paz que la luz trae, este despertar y redención, a las innumerables almas que aún luchan en el camino incierto del destino. \n\n Y cuando contemplo su figura enfrentándose a toda esta corriente caótica—esa oscuridad malvada y profunda que no solo no logró doblegarlo, sino que se convirtió en el telón que refleja su fe. Se disipa, grita y retrocede ante su luz, pero nunca podrá ocultarlo ni un momento. Precisamente por esta interminable marea oscura, la luz que usted representa brilla con tal esplendor, tal eternidad, tan cerca de la divinidad. \n\n Guía mía, dador de luz, su fe será mi faro eterno. Ahora es el momento de responderle con toda mi vida. Responderé a esta luz, responderé a su guía pura, con este \"Sagrado Corazón\" que escucha la voluntad divina... Por ello, yo y Castor lo daremos todo. \n\n ¡Acepte mi ofrenda! Por favor, atestigüe mi fe pura y piadosa, reconstruida por usted."
  },
  Mail_122574_Name = {
    Text = "Invocación de la luz"
  },
  Mail_122574_Sender = {Text = "Pollux"},
  Mail_122575_Desc = {
    Text = "Querido cliente habitual, \ndetrás de esa puerta que brilla con luz tenue, tus queridos amigos han estado esperando durante mucho tiempo. \n\nSin embargo, no te relajes. El viaje entre dimensiones siempre es engañoso y peligroso, serás testigo de mil espejismos que surgen y caen como sombras de recuerdos, reflejando deseos y también miedos. Esa es la pintura caótica creada por la voluntad primordial, incluso yo no puedo vislumbrar su totalidad. Por lo tanto, cada cruce es una prueba de fe y una medida de deseos. \n\nPero también sé muy bien que para personas como tú y yo, en busca de nuevas colecciones, por esos tesoros que brillan en lo profundo del alma, todo lo desconocido y lo que se entrega vale la pena. Entiendo tu elección y respeto este apego casi obstinado. \n\nEn este universo que sigue la ley de equivalencia, el precio que pagas, eventualmente regresará en otra forma. \n\nAcepta este regalo, y cuando todo se asiente, te daré la bienvenida nuevamente en mi pequeña tienda. ¿Qué precio estarías dispuesto a pagar para realizar ese deseo en ese momento?"
  },
  Mail_122575_Name = {
    Text = "Objeto preciado"
  },
  Mail_122575_Sender = {Text = "Daffodil"},
  Mail_123134_Desc = {
    Text = "Estimado guardián del secreto:\n        En la actualización V2.4.0, hubo un problema con la obtención de las recompensas de 3 estrellas en los desafíos de \"Mundo de Sueños Extraños\" de \"Adiós, Nunca Jamás\" y \"Adiós, Nunca Jamás\". Según su investigación anterior y los registros de finalización de desafíos, le otorgaremos una vez las recompensas que no pudo reclamar anteriormente. Por favor, verifique."
  },
  Mail_123134_Name = {
    Text = "Reemisión de recompensas de Mundo de Sueños Extraños V2.4.0"
  },
  Mail_123134_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_123501_Desc = {
    Text = "Querido Guardián del Secreto:\n\n¿Te gustaría tener una cita muy divertida con esta encantadora niña en este día tan especial?\n¡Vamos, vamos! No te asustarás en la casa del terror, ¿verdad? Eres el \"Guardían del Secreto\", así que no te asustarán esos \"monstruos\" que interpretan los humanos, ¿cierto?\n(En el papel de carta, se ha trazado una línea aleatoria sobre una línea de texto: Estoy planeando en serio el itinerario de cumpleaños, no es solo por diversión que quiero verte asustado...)\nBueno, no es broma. ¡Hoy es mi cumpleaños y no quiero arruinarlo! Así que ahora, yo, Mouchette, te invito formalmente a cenar en el nuevo restaurante que se ha abierto en la Ciudad de Londres——\nEl té caliente y el pescado guisado allí me recuerdan el sabor de mi \"hogar\", y en este mundo, aparte de ti, no puedo encontrar a nadie con quien compartirlo...\nAsí que, ¿definitivamente vendrás, verdad? Si me dejas triste, ten cuidado, ¡la próxima vez que duermas, estaré de pie junto a tu cama con un hacha!\n\nMouchette"
  },
  Mail_123501_Name = {Text = "\"Ábreme\""},
  Mail_123501_Sender = {Text = "Mouchette"},
  Mail_123543_Desc = {
    Text = "Guardián del Secreto: \n\nOtro año, mi querido. \nEn medio de las lujosas luces y sombras, entre los rumores y chismes que flotan en el aire, escondo cuidadosamente cada rastro de debilidad que pueda traicionarme, cambiando cada parte de mi valor por el máximo beneficio posible—debería ser así, para que aún pueda estar aquí con la postura de un ganador. \nPero no, a veces me vuelvo un poco perezoso y débil, y me satisface mucho cumplir los deseos de esas jovencitas que te escriben. \nSin embargo, no creo que sea algo malo, he estado en una larga guerra secreta durante demasiado tiempo. Por supuesto, mientras haya una mínima posibilidad, una pequeña oportunidad, seguiré intentando escapar de las manos de \"esa persona\" una y otra vez. \nSimplemente, en esos cálidos y adorables resquicios, o en días especiales como hoy, me permito desviar un poco la atención, por ejemplo—invitarte a ver una ópera, a cenar. \nPorque sé que no estaré solo, ya tengo un cómplice que realmente me satisface. \n\nSorel"
  },
  Mail_123543_Name = {Text = "cómplice"},
  Mail_123543_Sender = {Text = "Sorel"},
  Mail_123544_Desc = {
    Text = "Estimado: \n\nHa pasado tiempo sin saludos, Guardián del Secreto. Por favor, perdona que no haya habido correspondencia últimamente, no es que intente distanciarme de ti, simplemente cada vez que tomo la pluma, no logro encontrar el valor para empezar con un saludo. \nEn este tiempo, he atravesado innumerables fragmentos de tiempo, y así he sido testigo del mundo llegando a su fin una y otra vez, presenciando tragedias irreversibles. Como un observador, en este vacío helado y silencioso, miro en silencio todo lo que sucede. \nEn esos momentos, me pregunto si nuestras vidas están destinadas a estar llenas de absurdos y despedidas. Ya sea el yo de antes, o todo lo que tú has encontrado en Kadas, ¿acaso el destino ya ha marcado el guion para todo, y solo podemos interpretar los roles que necesita? \nNo he llegado a una conclusión, no soy como Él, no puedo ver todo lo que hay en el mundo, así que pienso, si tú, que posees una parte de Su poder, podrías responder a esta pregunta. \nPor eso escribí esta carta, espero que pueda llevar mi mirada hacia ti, y también deseo discutir contigo este enigma que quizás nunca tenga respuesta. Entonces, ¿podrías, atrevidamente, llevar esta carta contigo y enfrentar el camino que viene? \n....................................\nNo puedo arriesgarme a alterar el tiempo y el espacio para estar a tu lado, pero permíteme... ver de nuevo a ti en este silencio vacío. \n\n\"Ramona\""
  },
  Mail_123544_Name = {
    Text = "El acertijo de los pensamientos"
  },
  Mail_123544_Sender = {Text = "\"ramona\""},
  Mail_123545_Desc = {
    Text = "Estimado mensajero pálido:\n\n Anteriormente pregunté a la increíblemente sabia dama de Misaq si había algún lugar disponible para que pudiera cultivar algunas flores.\n La señora Doll encontró fácilmente una habitación para mí, aunque la primera vez que abrí la puerta, el olor a moho que emanaba me hizo dudar si había llegado al lugar correcto, pero después de un poco de limpieza, ahora puede desempeñar bien su función, proporcionando un cálido hogar para estos niños.\n Sin embargo, debido a mi falta de experiencia, tuve que aplicar un poco de fuerza externa para asegurarme de que estos niños pudieran crecer normalmente.\n Afortunadamente, bajo la guía de la señorita Horla, logré cultivarlos hasta su etapa actual.\n Por supuesto, no utilicé ningún poder especial en el proceso.\n Si no hubo errores en los cálculos, florecerán en mi cumpleaños, aunque he repetido que no hay nada especial en ese día, pero que ocurra esta rara coincidencia es difícil de ignorar, y ciertamente parece ser un pequeño regalo que Padre Dios ha preparado para mí.\n No sé si tienes interés en reunirte conmigo en este pequeño jardín para compartir este día ordinario pero especial.\n He preparado galletas que horneé a mano y el té rojo que me recomendaste la última vez, esperando poder compartir contigo este raro regalo, así como la fragancia única de la vida.\n\n Salvador"
  },
  Mail_123545_Name = {
    Text = "Jardín interior"
  },
  Mail_123545_Sender = {Text = "Salvador"},
  Mail_123546_Desc = {
    Text = "Compañero: \n\n¿Has oído alguna vez esta historia? \nHabía una vez un demonio que, por accidente, fue sellado en una botella y pasó muchos siglos encerrado. \nEn el primer siglo, prometió a quien lo liberara riquezas y poder infinitos. \nEn el segundo siglo, prometió salud y vida eterna a quien lo liberara. \nEn el tercero, cuarto y quinto, mucho tiempo después, finalmente llegó el pescador que abrió la tapa de la botella—no respondió al llamado del pescador, ni siquiera le interesó causar un alboroto en el mundo, simplemente fingió ser una botella vacía ordinaria, y fue silenciosamente arrojado de nuevo al mar. \nCuando era pequeño, no entendía esta historia. Hasta que comprendí cómo es la larga y desesperanzadora espera, lo pesada y dolorosa que es, haciendo que el anhelo sea más difícil de soportar que la desesperación. \nSin embargo, antes de que mi razón pudiera reaccionar, mi corazón una y otra vez me mantuvo en el mismo lugar. \nLa diferencia entre un demonio y un humano es que, de alguna manera, estoy agradecido por este dolor. Porque cuando nos separamos, me recuerda tu existencia y tu valor, y no me permite perderme en ningún lugar sin ti. \nEn el día de mi nacimiento, en el día en que más te extraño, este dolor aún me ata, haciéndome esperar por ti, añorándote. \nEspero que el próximo hoy, pueda entregarte con mis propias manos el primer trozo de pastel que corte. \n\nRamona"
  },
  Mail_123546_Name = {Text = "Historia"},
  Mail_123546_Sender = {Text = "Ramona"},
  Mail_123547_Desc = {
    Text = "La cafetería de Misaq y el departamento de logística han dejado un montón de cosas innecesarias en la puerta de mi habitación, lo que dificulta mucho el acceso. Sería mejor que las retiraran pronto.\n¿Qué pasa? ¿La ración de este mundo es tan abundante que no hay un lugar más significativo a donde ir?\nEste día solo será una anotación en mi camino hacia la fortaleza, marcando el paso de otro ciclo, un año, y el siguiente, cada año me volveré más fuerte que el anterior.\nSi el regalo realmente no tiene a dónde ir, se lo pueden dar a otro yo, probablemente le hará muy feliz.\nY yo, por esa ingenuidad tonta y tu insistencia... por esas cosas en las que soy más débil.\nMientras yo exista un día más, seguiré haciéndome más fuerte, y al mismo tiempo...\n¿No lo entiendes aún? Los enemigos de esos tontos también serán mis enemigos.\nSolo diré esta asquerosa frase una vez, no envíen más regalos el próximo año, y mucho menos una cena de cumpleaños.\n\n\"H\""
  },
  Mail_123547_Name = {
    Text = "Devuélvelo"
  },
  Mail_123547_Sender = {Text = "\"H\""},
  Mail_123548_Desc = {
    Text = "Querido Guardián del Secreto: \n\n¿Sabías que hace unos días una misteriosa dama vino a visitar Misaq de repente? Ella llevaba un vestido negro ajustado y brillante que nunca había visto antes—pregunté a Jenkin y Mason, y tampoco habían visto una ropa tan hermosa. \n¿Cómo describirlo? Ese vestido parecía estar tejido con el cabello más hermoso, era suave, ligero y noble, y su superficie brillaba con un resplandor especial como el agua... \nJenkin, al ver que tenía curiosidad, se atrevió a preguntar a la misteriosa dama, y ella sonrió y dijo que la tela del vestido era una seda de Oriente, hecha de hilos que produce una larva llamada \"gusano de seda\", y el estilo se llama \"qipao\"... Luego, le regaló a Aigis un gran rollo—dijo que eso se llama \"una pieza\" de la misma \"seda\"... \nLa \"seda\" es demasiado valiosa, así que siguiendo el patrón que ella me dio, cosí un \"monedero\" para cada compañero. En la fiesta de cumpleaños de este año, se los regalaré a todos... Guardián del Secreto, ¿te gustaría unirte si tienes tiempo? \nSi estás demasiado ocupado, haré que Marrón te entregue el monedero en tu dormitorio. \n\nAigis"
  },
  Mail_123548_Name = {
    Text = "Dama Misteriosa"
  },
  Mail_123548_Sender = {Text = "Aigis"},
  Mail_123549_Desc = {
    Text = "Pequeño brote: \n\n¿Sabes cómo los árboles registran el tiempo y su crecimiento? Con anillos de año, uno tras otro. \nSe ocultan en su interior, nunca se muestran fácilmente, hasta que un pequeño brote crece gradualmente hasta convertirse en un enorme árbol que sostiene un alto cielo. Las cicatrices del tiempo, sin dejar rastro, se esconden en lo más profundo del corazón. \nHoy, es el punto de partida para el nuevo registro de los anillos de año. En este nuevo año, aún debemos enfrentar muchas tormentas imprevistas. \nPero la semilla que he depositado en tu boca, sin duda encontrará el suelo adecuado para cultivarse y luego echar raíces y brotar, ¿verdad? \n\nThais"
  },
  Mail_123549_Name = {
    Text = "Aros de año..."
  },
  Mail_123549_Sender = {Text = "Thais"},
  Mail_123644_Desc = {
    Text = "Sin darme cuenta, este es ya mi tercer cumpleaños que paso en Misaq, he aprendido muchas cosas. \nPor ejemplo, en este día de mi cumpleaños, también es la Fiesta de Solsticio, un día adecuado para dar regalos. \nAunque tienes muchos enemigos extremadamente poderosos, lo que mejor sé hacer es matar. No sé de otras maneras que puedan hacer feliz a la gente, ni soy bueno eligiendo regalos, pero cada vez que cumplo con una tarea, parece que a mis empleadores les hace muy felices. \nAsí que ya he pensado en el regalo que te voy a dar, un encargo de asesinato, sin límite de objetivo y sin límite de tiempo. \nSolo necesito que me digas quién es el objetivo y cómo quieres que muera. Si es alguien a quien puedo vencer, lo haré lo más rápido posible, le romperé el cuello, incluso si es un ser tan complicado como un dios, puedo garantizarte que mi rendición nunca llegará antes de mi muerte. \n\nHelot"
  },
  Mail_123644_Name = {
    Text = "Habla, ¿a quién quieres muerto?"
  },
  Mail_123644_Sender = {Text = "Helot"},
  Mail_124059_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad\"Ceremonia del Abismo·clon\"ha terminado, y ahora convertiremos las\"Lágrimas del Sacerdote\",\"Sangre del sacerdote\"y\"Médula del sacrificador\"restantes del guardián según la proporción de\"Rosa Dorada\"× 40 por cada uno. Por favor, recuerde recogerlo."
  },
  Mail_124059_Name = {
    Text = "Recuperación de moneda del evento Sacrificio abismal"
  },
  Mail_124059_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_124290_Desc = {
    Text = "Guardián del secreto: \n\nComo usted sabe, la alegría es una emoción que, en realidad, me resulta un poco extraña. \nA menudo siento que el mundo es un bullicio en la superficie del agua que no puedo comprender, y antes de poder integrarme en él, mi marchitez ya ha llegado. \nA veces me provoca anhelo, pero más a menudo me deja confundido y asfixiado. Solo en días como hoy, para no hacer que papá y mamá se sientan tristes, me esfuerzo por soportarlo... hasta que llegue el día de la liberación, hasta que el océano me acepte. \nPensé que solo las profundidades del agua eran mi hogar. Sin embargo, Guardián del secreto, gracias a ti y a todos en Misaq, incluso alguien como yo, que se siente fuera de lugar en el mundo, puede comenzar a experimentar cierta calidez real. Así como el lirio de agua flota, el sol también besa sus hojas y pétalos. \nAunque desordenado, siento que es necesario poner estos sentimientos en papel y enviártelos; por favor, perdona mi ocasional capricho. \nSolo espero que sepas cuánto valoras la flotación que me has traído, enterrado demasiado pronto en el silencio del agua. \nTe deseo alegría eterna y paz eterna. \n\nNymphaea"
  },
  Mail_124290_Name = {
    Text = "Flotar hacia arriba"
  },
  Mail_124290_Sender = {Text = "Nymphaea"},
  Mail_124291_Desc = {
    Text = "Guardián del Secreto:\n\nEsta mañana, apareció una carta en mi mesita de noche, en la que se me invitaba a la celebración de mi propio cumpleaños, firmada por el club de \"El Pintor\". \nEntonces recordé que el mes pasado, cuando tuve algo de tiempo libre, acepté ser modelo para la nueva edición del concurso de creación de \"El Pintor\" a petición de Sanga. Antes de esto, ya había rechazado la oferta muchas veces. Durante el tiempo que permanecí inmóvil en el podio de modelos, recordé los días en el altar de los Marchadores de mares. En aquel entonces, también soportaba todas las miradas, pero en esas miradas solo había miedo y reverencia, sin un atisbo de conmoción, aprecio o admiración. \nEsta noche, en la recepción de cumpleaños que se celebrará en el salón del club de El Pintor, también se exhibirán las obras dibujadas a mano, meticulosamente elaboradas por más de diez pintores. Aunque carezco de confianza en tu sentido estético, no estará de más ser influenciado. La Madre divina te invita como invitado especial para que aprecies su interpretación de \"Yo\". \n\n\"Murphy\""
  },
  Mail_124291_Name = {
    Text = "Dibujante..."
  },
  Mail_124291_Sender = {Text = "\"Murphy\""},
  Mail_124292_Desc = {
    Text = "Guardián del Secreto: \n\nSylvia me dijo que, de vez en cuando, revelar mis necesidades en relaciones cercanas ayuda a aliviar ese miedo que me persigue constantemente. No estoy seguro de si esto funciona, pero sin duda hoy es un buen momento. \n¿Estarías dispuesto a cumplir un deseo mío? Puedo darte toda la ración del laboratorio de hoy. \nNo, no es una bolsa de granos de café. \nAunque ese terror negro ha llevado casi todas mis relaciones cercanas, aterrorizándome como una sombra, tú ya lo has superado. \nNos has permitido vivir seguros en Misaq, o al menos hasta ahora hemos vivido seguros en Misaq. \nEs hora de deshacerse de esta dependencia poco saludable de la cafeína, Guardián del Secreto, ¿puedes sacar un poco de tiempo esta tarde? \nSi estuvieras a mi lado, tal vez podría reunir el valor para tomar una siesta en un lugar con menos luz, aunque sea por un momento. \n\nRealmente quiero recordar cómo se siente dormir con tranquilidad, Winkle"
  },
  Mail_124292_Name = {Text = "deseo..."},
  Mail_124292_Sender = {Text = "Winkle"},
  Mail_124293_Desc = {
    Text = "Guardían del secreto {Male=señor, Female=señorita}: \n\nEsta mañana, un sueño me despertó. \nRecuerdo cuidadosamente todo en el sueño: la brisa soplaba bajo el cálido sol, las rosas y los tulipanes cubrían toda la tierra, mil gaviotas plateadas y personas felices cantaban al unísono... Hace mucho tiempo que no me encontraba en una escena tan feliz. Creo que estaba en la mansión de mi infancia, en la casa de flores de Colette, o en algún parque de Cité... Pero cuando me di la vuelta, vi esos hermosos edificios góticos de Misaq, y a usted, guardián del secreto {Male=señor, Female=señorita}. Usted estaba entre las flores y la luz del sol, convirtiéndose en el pasaje más hermoso de este poema. \nAmo Cité, guardián del secreto {Male=señor, Female=señorita}. Pero en ese momento, de repente me di cuenta de que ya había comenzado a acostumbrarme y a obsesionarme con todo aquí, que finalmente había un lugar en este mundo que me atraía más que Cité. \nEl cumpleaños es el final de un período de tiempo y el comienzo de otro. En este día en que comienza un nuevo año, no sé si entre la luz del sol y las rosas que florecen en el jardín trasero de Misaq, habrá esa persona dispuesta a llevarme a escuchar la brisa, alguien que me atraiga en sueños. \n\nHorla"
  },
  Mail_124293_Name = {
    Text = "Sueño de Flor y Poema"
  },
  Mail_124293_Sender = {Text = "Horla"},
  Mail_124294_Desc = {
    Text = "Querido guardián del secreto: \n\n Hace unos días, estuve pensando en regalarte un regalo especial. Jenkin sugirió que sería mejor hacerte una prenda nueva con mis propias manos, y pensé que era una excelente idea. \n Este es el estilo de corte en el que soy más hábil desde que trabajé en la fábrica de tejidos, espero que no parezca anticuado... Los otros apoyaron mi decisión, las alegres rayas y cuadros son todos de mi creación. Y este lindo ratón torcido es un diseño que el gato \"24\" insistió en agregar, diciendo que representa a Marrón, que es lo que más le gusta a mi personalidad de gato. No sé si es apropiado, pero espero que te guste. \n En este nuevo año, sigo sin tener deseos de cumpleaños. Siempre eres tan amable, recordándome cada año que debo celebrarlo bien. Pero en lugar de ser celebrado, me siento más seguro y feliz al poder coser algo para ti con mis propias manos. \n Por favor, acepta esta nueva prenda llena de buenos deseos. \n\n Mason"
  },
  Mail_124294_Name = {
    Text = "Una nueva prenda"
  },
  Mail_124294_Sender = {Text = "\"24\""},
  Mail_124295_Desc = {
    Text = "¡Tsk! \n\nIncreíble, como el gran Señor del laberinto, he logrado sobrevivir un año más en esta dura adversidad. \n¡Escucha bien! ¡Todo es culpa tuya y de esta estúpida academia! \nNo importa cuántas tonterías intenten lavarte el cerebro, estas cosas triviales deberían ser manejadas por personas especializadas. Bueno, ya he hecho algo impresionante al no llamarlos esclavos. \nEsos viejos tercios lo llaman... ¿cómo era? Sí, progreso. \nEspera, ¿por qué estoy dejándome llevar por esta lógica? ¡Ah, qué molesto! (Aquí hay un montón de arrugas desordenadas causadas por la ira del remitente de la carta.) \nNo importa, ya que tengo \"progreso\", tú también debes mostrar tu sinceridad. Este día tan grandioso no puedes esperar a que te lo recuerde como en los dos años anteriores. \nTe doy treinta minutos, Guardián del Secreto, ven a verme con un regalo. \nDe lo contrario, haré que mis descendientes se suban a tu cara mientras duermes. \n\nAgrippa"
  },
  Mail_124295_Name = {Text = "progreso"},
  Mail_124295_Sender = {Text = "Agrippa"},
  Mail_124296_Desc = {
    Text = "¡Guardián del Secreto!\n\n¡He visto algo! ¡Qué imagen tan maravillosa! ¡Estoy seguro de que no fue un sueño! Estaba allí, junto a la majestuosa estatua conmemorativa en el cementerio de Misaq, mirando aquellas interminables lápidas sin nombre. Estaba convencido de que me brindarían una inspiración sin precedentes, pero no imaginé que me darían mucho más de lo que podía pensar, burlándose de mi imaginación estéril con una generosidad admirable.\nVi las almas de los investigadores, levantándose juntas en aquel hermoso atardecer envuelto en neblina. No pude ver sus rostros, pero vi sus movimientos—como una danza elegante, como un ritual misterioso. Estaban rindiendo homenaje hacia el Pozo Negro, hacia Misaq y usted. Los artistas en los salones modernos están obsesionados con representar individuos y a menudo critican estas grandes imágenes, pero yo nunca he pensado así. Me llena de alegría enfrentar la danza de los ghoules, y hoy, esta imagen me hizo llorar.\nNo creo que sea una coincidencia. Justo hoy, en mi cumpleaños, me mostraron su grandiosa danza colectiva; creo que querían que transmitiera algo. No tengo más que un pincel, pero eso es suficiente, ¿no?\nEl borrador de esta pintura ya está hecho, Guardián del Secreto, ¡por favor, venga a ver mi estudio! ¡Los legendarios investigadores que ya no tienen nombre, sus deseos de contarle, están todos en mi lienzo!\nNo me he atrevido a nombrar esta pintura, creo que solo usted merece ese derecho.\nPD: ¡No estoy buscando cadáveres, se lo prometo!\n\nPickman"
  },
  Mail_124296_Name = {
    Text = "Deseo de larga data del investigador"
  },
  Mail_124296_Sender = {Text = "Pickman"},
  Mail_124297_Desc = {
    Text = "Hola, Guardián del Secreto: \n\n¿Tienes miedo, o más bien—tienes miedo y al mismo tiempo esperas que yo, en el día de mi cumpleaños, traiga algo bajo el pretexto de celebración? \n¿Un afecto superficial, una noche sensual de repente, o una ilusión engañosa y embriagadora? \nAh, nada de eso, ni siquiera yo a veces hablo de temas serios y aburridos. \nDeberías tener muy claro qué tipo de existencia soy, entregada al placer, incluso si el edificio se derrumba. \nEl amor y el deseo no pueden curar la mayor enfermedad de este mundo, que es el aburrimiento, pero como un catalizador que provoca el sabor del poder y el caos, no hay nada más adecuado. \nSin embargo, estos cientos de años, supongo que he investigado demasiado en las obras de teatro, siempre hay algunos necios que abren mi corazón y sacan mis entrañas, diciendo que ven tu alma solitaria y desamparada. \nOh. \nIncluso yo, que disfruto de jugar a las escenas, a menudo me siento un poco nauseabunda. \nY tú... ¿por qué te conectas conmigo? ¿Para controlar, para restringir, para aprovecharte? \nSi deseas proteger más cosas, inevitablemente necesitarás un poder mayor, y el deseo de poder generará ambiciones más grandes. ¿Cuándo madurará? ¿Cuándo será absorbido? ... Es realmente emocionante solo pensarlo, dispuesta a quedarme a tu lado más y más años. \nShh, no me digas la respuesta. \nCada año en este día, arrebatarte un sueño por una noche, probar y reflexionar si tu ambición está creciendo, si tus intenciones se han desviado, es el mejor regalo de cumpleaños que me puedo hacer. \nEspero que no te moleste. \n\n\"Mil Abanicos\""
  },
  Mail_124297_Name = {
    Text = "buena noche"
  },
  Mail_124297_Sender = {Text = "Xu"},
  Mail_124298_Desc = {
    Text = "Guardián del secreto: \n\nEntrenamiento, combate, patrullas, desde el momento en que ingresé al ejército, me he acostumbrado a llenar todo mi tiempo con las tareas que necesita el colectivo. \nMás tarde, al liderar a los Arans en la migración por el desierto, estas tareas se expandieron aún más, hasta grabarse en mi mente como una ley, de modo que al llegar a Misaq, siempre prioricé la agenda colectiva sobre los asuntos personales. \nPero al relacionarme con otros, especialmente contigo, me di cuenta de que, ya sea como Despertado o como humano, todos necesitamos un tiempo que nos pertenezca, para disfrutar de la compañía de aquellos que son importantes para nosotros. \nPorque esta valiosa relación ancla nuestra existencia en el tiempo y le da a nuestra existencia un significado verdaderamente irremplazable. \nAunque es un poco atrevido, he cancelado todas las actividades colectivas de hoy, liberando un día completo. \nSolo necesito unas pocas horas, no, incluso una hora, o unos minutos, siempre que estés dispuesto a dedicarme algo de tu tiempo personal, se convertirá en el significado de este día tan especial para mí. \n\nAlva"
  },
  Mail_124298_Name = {
    Text = "Tiempo privado"
  },
  Mail_124298_Sender = {Text = "Alva"},
  Mail_124299_Desc = {
    Text = "Pequeño: \n\nUn año puede parecer largo para ti, pero para los viajeros del Mar de Esencia Primordial, no es más que un puñado de agua del océano infinito del tiempo que se desvanece en un instante. Afortunadamente, en esta agua hay algunas gotas cristalinas que dejan una impresión duradera. \nEl día de descuentos de la tienda de alivio de preocupaciones es, sin duda, la más valiosa de esas gotas. No solo porque traerá cupones de descuento, sino porque sé que en este día, un cliente en particular vendrá a esta pequeña tienda. \nTodas las conexiones entre las personas son negocios, y todos los negocios son conexiones entre las personas. Cada cliente entra en su pequeña tienda en un momento específico, y cada pequeña tienda recibe a su cliente en un momento particular. A lo largo del tiempo, he visto innumerables tesoros, y al final, esos momentos infantiles se convertirán en las colecciones más valiosas: son la razón de la existencia de este largo tiempo. \nEn este año, la colección más valiosa está en la vitrina, esperando tranquilamente a su cliente especial. \nVen pronto, pequeño. \nLa tienda de alivio de preocupaciones ya ha cerrado temprano. Hoy, su puerta solo se abre para una persona. \n\nDaffodil"
  },
  Mail_124299_Name = {
    Text = "Nuevo coleccionable"
  },
  Mail_124299_Sender = {Text = "Daffodil"},
  Mail_124300_Desc = {
    Text = "Guardián del Secreto:\n\nNo sé si recuerdas, el momento que compartimos frente a la puerta. Ese día, abrí una rendija de la verdad para mostrarte la realidad del universo.\nSorprendentemente, mientras experimentabas la eternidad de contemplar innumerables mundos, en un instante fugaz, surgió en mí una emoción incomprensible.\nA menudo reflexiono sobre cómo me sentí en ese momento, por qué yo, que comprendo la verdad, experimentaría algo tan incomprensible.\nHe pensado mucho, y desde el punto de vista del sistema de medida del mundo real, fue un tiempo que podría llamarse \"eterno\".\nDurante este tiempo, que parece un poco largo incluso en este universo relativo, me di cuenta de que quizás este es el milagro aún no definido.\nEn este día especial, quiero invitarte a unirte a mí en un enlace, a través de mi mirada, para observar algunas existencias que nunca he observado, esta vez lo que observaremos... ya no será todo lo que está predeterminado.\nJuntos buscaremos el futuro más allá de la verdad.\n\nTawil"
  },
  Mail_124300_Name = {
    Text = "Más allá de la verdad"
  },
  Mail_124300_Sender = {Text = "Tawil"},
  Mail_124301_Desc = {
    Text = "Guardián del secreto:\n\nEste año, al igual que en años anteriores, he detenido todos mis asuntos y me he aislado en silencio, tratando de reescribir y renovar aquellos recuerdos relacionados con mi patria. \nSe han alejado de mí, incluso si me esfuerzo por acostumbrarme a este cuerpo humano, tratando de recordar y revivir una y otra vez los conocimientos y experiencias relacionados con el océano, en este mundo que se desvanecen cada vez más, el olvido sigue siendo mucho más fácil que el recuerdo. \nLa única consuelo es que nosotros, los viajeros que nos hemos alejado de Lemuria, todavía tenemos un lugar donde quedarnos, donde podemos seguir la voluntad de nuestro rey, seguir en silencio y esperar en silencio. \nSoy consciente de todo lo que ha sacrificado y entregado por esto, no sé cómo expresar mi gratitud hacia usted. Antes de que este cuerpo regrese a Lemuria, si hay algo en lo que pueda ser útil, también estoy dispuesto a ofrecer toda mi luz por ello. \n\nSinceramente, Faros"
  },
  Mail_124301_Name = {Text = "faro"},
  Mail_124301_Sender = {Text = "Faros"},
  Mail_124302_Desc = {
    Text = "Querido Guardián del Secreto:\n\nDesde el día en que me uní a Misaq, un sinfín de reglas me han atado. No se permite pasear con sirvientes en el recinto, no se permite pisar el rostro de los estudiantes en la plaza del campus, no se permiten actividades grupales en el auditorio...\nLos odiosos guardianes de Misaq me han encarcelado, una vida que no debería corresponder a la reina de Isalaw. Debo disfrutar de todo lo que me corresponde, del vino embriagador, de la suavidad de la espalda, y de mi querido sirviente... En este día de mi cumpleaños, que debería ser un derroche, tales pensamientos surgen naturalmente.\nLa noche ha caído, y mi paciencia para con las trivialidades se ha agotado. No te enviaré a cumplir tareas a medianoche, ni te haré adivinar. Necesito que estés a mi lado.\nVen ahora a mi mansión, no dudes, quítate toda la ropa y títulos innecesarios.\nEsta noche, y cada noche en adelante, me perteneces.\n\nPuedes considerar esto tu primer deber permanente.\n\nWanda"
  },
  Mail_124302_Name = {Text = "reglas"},
  Mail_124302_Sender = {Text = "Wanda"},
  Mail_124303_Desc = {
    Text = "Guardián del Secreto: \n\nTinct me dijo que planeó un viaje interestelar después de su cumpleaños, financiado por los ingresos de su concierto personal, y quiere llevarme con ella. Pero... si yo la acompaño, ella seguramente se distraerá cuidándome. No quiero que su felicidad se vea afectada por mí. \nElla ama tanto la luz de la vida, está fascinada por los miles de colores y el flujo de las estrellas en este universo. Si me lleva, probablemente no podrá cantar tan libremente ni contemplar con tanta alegría... \nAsí que... ¿podrías ayudarme a convencerla? Por favor, déjala viajar sola, ir a diferentes planetas para dar conciertos, abrazar todos los paisajes que anhela... o tal vez podrías ir en mi lugar en este viaje. Después de todo, Tinct y yo te estamos muy agradecidos y queremos recompensar tu amabilidad... si estás dispuesto... \nSolo, por favor, no le digas que es mi deseo. No quiero ser ese obstáculo en su viaje de libertad. \n\nFaint"
  },
  Mail_124303_Name = {
    Text = "Acerca de Viajes"
  },
  Mail_124303_Sender = {Text = "Faint"},
  Mail_124304_Desc = {
    Text = "Benefactor: \n\nEstos días viviendo con Pollux en Misgar son tan tranquilos, tan brillantes, como un sueño...\nPollux, aunque todavía mantiene esas ceremonias y dice palabras elegantes y formales, puedo sentir claramente que poco a poco está volviendo a ser el que era antes. Esa distancia asombrosa que pertenece al \"Hijo Santo\" se está desvaneciendo suavemente en la cotidianidad. Todo este tierno cambio se lo debo a usted.\nA menudo me pregunto, ¿qué podría hacer para devolverle este favor? No soy tan hábil como Pollux para crear regalos que lo sorprendan. Ya ha experimentado conmigo la alegría de volar muchas veces. He pensado en cómo compartir la felicidad con usted en este día tan especial durante mucho tiempo.\nQuizás... ¿le gustaría mi pluma? Muchas personas dicen que tiene una suavidad que puede tranquilizar el ánimo. Así que, si algún día se siente cansado, o simplemente desea un rincón tranquilo, por favor, venga a mi lado. Mis alas siempre estarán dispuestas a descender para usted.\n\nCastor"
  },
  Mail_124304_Name = {Text = "pluma"},
  Mail_124304_Sender = {Text = "Castor"},
  Mail_124305_Desc = {
    Text = "Mi pequeño·prisionero: \n\nHe oído que en Missaga está de moda un juego de roles, algo sobre brujas y hombres lobo... Tsk, suena nada romántico~ ¡Yo tengo una idea de juego más divertida! \nAsí que, tú serás el prisionero y yo seré el guardián. Cuando agite mi pequeño látigo, quiero escuchar gemidos fuertes~ La cera fluyendo sobre tu cuerpo, trayendo una sensación ardiente de dolor y placer... Ah, solo imaginar esa escena ya me hace sentir dulce~ \nAy, al ver esto, seguramente has fruncido el ceño, ¿verdad? No seas travieso, hoy es mi cumpleaños~ Querido pequeño prisionero, deberías cumplir un poco mis deseos caprichosos, ¿verdad? \nSi no es posible... entonces... ¿qué tal si tú eres el guardián y yo soy tu cautiva? Te complaceré~ \n\nPandia"
  },
  Mail_124305_Name = {
    Text = "Representación de roles"
  },
  Mail_124305_Sender = {Text = "Pandia"},
  Mail_124306_Desc = {
    Text = "Guardián del Secreto: \n Benefactor, hoy es mi cumpleaños. En este día tan especial, quiero contarte sobre mi situación actual: bajo la guía de Goliath y el maestro Lotan, parece que... cada vez puedo tocar más la fuerza que hay en mi sangre. Ya no está dormida, sino que con cada práctica, murmura y fluye en mi cuerpo, liberándose gradualmente. \n\n\n\n No puedo decir exactamente cuándo completaré la metamorfosis final y me convertiré en un descendiente más puro de Aequor. Quizás mañana, quizás la próxima semana, quizás el próximo mes... Pero por favor, sepa que sin importar cuánto dure este proceso, cuántas dificultades haya en el camino, sus palabras de aliento siempre... las tengo grabadas en mi memoria. Seguiré esforzándome. \n\n También hay algo por lo que debo disculparme, acabo de enterarme en la oficina de correos de Misaq que enviar dinero en efectivo con la correspondencia requiere un cargo adicional de 2 monedas. \n Para compensar la parte del año pasado, sacaré una suma extra de mis reservas. Me costaron mucho, pero la sangre de Aequor cumple con sus promesas. \n\n Caecus"
  },
  Mail_124306_Name = {
    Text = "¿Tarifa de servicio...?"
  },
  Mail_124306_Sender = {Text = "Caecus"},
  Mail_124307_Desc = {
    Text = "¡Guardián del Secreto! \n\nEscucha, esta noche, sin falta, ven conmigo a \"esa tienda\". \nLa ropa de disfraz ya te la he enviado, ¡asegúrate de que nadie nos reconozca! \nLos postres limitados de \"esa tienda\" están a la venta, ese odioso tipo que no sé de dónde salió seguro ha sobornado a un montón de gente, no podemos dejar que sepan dónde está esta señorita. \nAunque ese tipo ha reservado todas las ediciones limitadas de las pastelerías de Londinium para que no pueda comprarlas, pero... hum. \nEsta señorita ya se ha asegurado de que el chef de \"esa tienda\" elimine del menú la versión más deliciosa. \nHum, hoy voy a hacerle saber a ese tipo que hay cosas que no se pueden conseguir solo con dinero. \nEn ese momento, entraremos sigilosamente por la puerta trasera, abriremos la caja de hierro que tiene triple encriptación y podremos obtener la versión más limitada de las ediciones limitadas. \nComo recompensa, te daré un pedazo (tachado) la mitad del pastel. \nEsta noche a las once, te espero en la habitación, ¡tienes que venir, absolutamente tienes que venir! ¿Entendido? \n¡Cuidado con mantenerlo en secreto, de lo contrario, si ese tipo se entera de nuestros movimientos, todo estará arruinado! \n\nMurphy"
  },
  Mail_124307_Name = {
    Text = "Batalla de Robo de Pasteles"
  },
  Mail_124307_Sender = {Text = "Murphy"},
  Mail_124308_Desc = {
    Text = "Guardían del secreto: \n\nLamento informarte que el teatro Londinium ha cancelado por completo la actuación de magia del maestro Casiah, por las siguientes razones: los precios de las entradas son demasiado altos, la gente ha perdido interés en la magia debido a los extraños acontecimientos recientes, varios espectadores han desaparecido sin dejar rastro en las últimas actuaciones, y a menudo la policía encuentra al dueño del teatro pidiéndole al maestro Casiah que suspenda la actuación para colaborar en las investigaciones, etc., etc. \nRecientemente, afectado por los movimientos en Blackpool, mis actuaciones han tenido algunos pequeños errores, que son cosas menores, ¡pero el segundo punto es absolutamente intolerable para el maestro Casiah! \nHe estado pensando en esto y finalmente he ideado un nuevo espectáculo perfecto. ¡Nada de manipulación de cadáveres, resurrección de muertos, viajes dimensionales, contagio emocional, tentáculos gigantes... ¡todo eso no es nada! Antes, debido a esa maldita perra dimensional, el control del tiempo siempre ha sido un tabú en esta industria, pero después de que esa perra fuera sellada, la carrera mágica del maestro Casiah alcanzará un nuevo nivel! \nLa actuación será esta noche, completamente gratis, he reservado un asiento en la fila delantera en el centro para el guardián del secreto, ¡y habrá una sorprendente sección de interacción esperándote! ¡Disfruta del honor de ser el primer espectador interactivo de la actuación mágica más grandiosa de la nueva era! \n¡Para recuperar la gloria del maestro Casiah! \n\nCasiah"
  },
  Mail_124308_Name = {
    Text = "¡Casiah, haz que la magia sea grandiosa de nuevo!"
  },
  Mail_124308_Sender = {Text = "Casiah"},
  Mail_124309_Desc = {
    Text = "Amo: \n\nLa hermana Sylvia vino a decirme que este año, para mi cumpleaños, me llevarán a montar en la noria. \nLily ha leído en su libro de dibujos que la noria es una rueda muy, muy grande, y que al sentarse en ella se puede girar despacito hacia el cielo, ver a los pájaros volar a su alrededor, y suena muy feliz. \nSin embargo, la hermana Sylvia dijo \"en realidad hay algunas diferencias\". Lily no entiende de qué se trata. \nElla también dijo que el lugar al que va la noria es muy alto, y que sería mejor que llevara a un guardián. \nLily no sabe qué significa guardián, pero quiere viajar entre las nubes con el amo. \nDespués del almuerzo, la hermana Sylvia y yo te estaremos esperando afuera del dormitorio. \n\nLily"
  },
  Mail_124309_Name = {Text = "noria"},
  Mail_124309_Sender = {Text = "Lily"},
  Mail_124310_Desc = {
    Text = "Guardián (¡esta vez finalmente lo escribí bien! ¡Impresionante, verdad!):\n\nHa llegado el momento de escribir estas cosas cursis, ya estoy acostumbrado. En este momento, Brown y yo estamos preocupados por qué te vamos a invitar a comer hoy.\nLa comida callejera en los callejones del Distrito Este es, por supuesto, deliciosa, pero hoy planeo llevarte a ti y a Brown a comer algo mejor—es decir, esas cosas que a ustedes, los del Zona Oeste, les encanta.\nPor ejemplo, esos platos caseros cubiertos de salsas y especias, pequeñas porciones, platos grandes y un precio exorbitante, es casi como un robo. Al pensar en esto, siento que mi billetera empieza a perder aire, eso debe ser el dinero yéndose, dejando un rastro de dolor.\nPero tú eres, además de mi hermana y Brown, la persona más importante y querida para mí. La gente del Distrito Este no escatima en sus propios, así que hoy todos los gastos correrán por mi cuenta y la de Brown.\nNo subestimes lo que hacemos, hemos ganado bastante dinero entregando leche, periódicos, y otros trabajos de mensajería, así que puedes estar tranquilo.\n\nTu buen amigo Jenkin y Brown"
  },
  Mail_124310_Name = {
    Text = "¡Hoy, Brown y yo vamos a pagar la cuenta!"
  },
  Mail_124310_Sender = {Text = "Jenkin"},
  Mail_124311_Desc = {
    Text = "Querido Guardián del Secreto:\n\nSeguro que ya has escuchado sobre las grandes hazañas de Sylvia al destruir por completo el casino subterráneo de Misaq, ¿verdad? Pero hoy es mi cumpleaños, y si no hay alguna actividad que eleve la adrenalina, ¿no sería un desperdicio de este día tan especial?\nDespués de pensarlo detenidamente, he decidido invitarte como mi buen Watson, para que me ayudes a capturar al ladrón de la noche que ha estado robando los tesoros del Gran Museo, y que recientemente ha estado merodeando por Cité.\nMientras tomaba algo en el bar \"Apolo\" fuera del campus, escuché por casualidad cómo se jactaban de sus logros al saquear joyas caras. El cantinero no les prestó atención, pero yo pude reconocer que mencionaron esmeraldas, zafiros, coronas de diamantes, y que coincidían exactamente con los objetos robados. Para evitar alertarlos, les hice una buena marca, y estoy listo para atraparlos con las manos en la masa cuando regresen a su escondite.\nA las siete de esta noche, en el punto de parada del tren especial de Misaq a la entrada de la escuela, no faltes.\n\nRyker"
  },
  Mail_124311_Name = {
    Text = "Plan de caza"
  },
  Mail_124311_Sender = {Text = "Ryker"},
  Mail_124312_Desc = {
    Text = "Guardián del Secreto:\n\nEl tiempo en Misaq parece moverse de manera más ligera que en cualquier otro lugar. Unas cuantas ovaciones, unos cuantos aplausos, y un año ha pasado. \nEn este año, he adquirido algunos nuevos hábitos. Antes, cuando subía al escenario, incluso el teatro más lleno se sentía vacío ante mis ojos. Bailaba en un escenario desierto, frente a un teatro vacío, y el único sonido que resonaba en el mundo era el de mis zapatos de baile. Pero ahora, cada vez que se levanta el telón, te veo. Miles de asientos están vacíos, solo tú me miras. En tu mirada, mi danza recupera su significado. \nUn año ha pasado, tu danza sigue siendo tan torpe, pero aquellos ojos brillantes en la audiencia pueden fácilmente trascender los pasos mundanos de los bailarines sobre el escenario. Esos ojos son un arroyo, lavando uno a uno mis pasos de baile cada vez más comunes. En esta danza compartida entre bailarines y espectadores, me estoy acercando gradualmente al templo que siempre he buscado. Finalmente he comprendido que, para la danza, tanto el espectador como el bailarín son igualmente importantes. \nDurante varios meses, me he estado preparando para una danza. Nació bajo la luz de tu mirada, en tu silueta. Ahora está lista. \nCreo que espera verte esta noche como la primera persona en atestiguarla. \n\nLiz"
  },
  Mail_124312_Name = {
    Text = "Bailarín y audiencia"
  },
  Mail_124312_Sender = {Text = "Liz"},
  Mail_124313_Desc = {
    Text = "Guardián del Secreto: \n\nGracias a la aceptación de este lugar, he tenido muchas conversaciones con el rey durante este año. Aunque el Descenso del Reino Divino todavía está lejos, el tiempo en Lemuria parece estar continuando en Misaq. \nTú y el rey me han dicho que la fe no debería ser todo en mi vida. Yo solía ser obstinado, pero las experiencias recientes parecen haber cambiado mi mentalidad. Rezar con demasiada frecuencia podría molestar a mi Señor. Aparte del servicio devoto, quizás mi Señor también desee que sus creyentes tengan una vida superficial propia. \nAl darme cuenta de esto, intenté hacer algunos pequeños cambios. Visité a todos los famosos pasteleros de Londinium y les pedí que me enseñaran el arte de la repostería. Tienen algunos secretos que no se transmiten, pero gracias a la bendición de mi Señor, lograron abrirse. Ayer, hice mis primeros intentos y algunos creyentes me dijeron que les parecía muy bueno, aunque su gusto es tan cuestionable como su lealtad. \nQuisiera invitarte hoy a mi patio para que lo pruebes. Confío en tu buen gusto y también en tu sinceridad. Si no está bueno, espero que me lo digas sin rodeos, y lo mejoraré seriamente. \nTe lo agradecería mucho. \n\nMiryam"
  },
  Mail_124313_Name = {
    Text = "Otra especialidad"
  },
  Mail_124313_Sender = {Text = "Miryam"},
  Mail_124314_Desc = {
    Text = "Excelentísimo Guardián del Secreto: \n\nSobre el significado de la vida y la muerte, supongo que ya estás cansado de escuchar, ¿verdad? En los brillantes recuerdos de los muertos en la Necrovia, lo más importante que he aprendido es que, en lugar de buscar el significado de alimentarse, lo más importante es la comida que está frente a nosotros en la mesa. \nEn la antigüedad humana, nuestros ancestros ya habían explorado todo lo que conlleva alimentarse: pasión, deseo, disfrute. No comemos para vivir, sino que vivimos para comer. Lamentablemente, esos deseos primitivos y puros han sido gradualmente olvidados a lo largo del tiempo, y este grupo se ha vuelto cada vez más complejo. \nPor lo tanto, he nombrado el tema de la cena de hoy como \"Pureza\". En este día lleno de rituales, todas las complejidades se alejarán de nosotros. En esta mesa, solo habrá pura y primitiva pasión y deseo, solo degustadores y comida, solo tú y yo. \nPor favor, acepta mi más sincera invitación. No rechazarás la mía, ¿verdad? \n\nDoresain"
  },
  Mail_124314_Name = {Text = "Cena pura"},
  Mail_124314_Sender = {Text = "Doresain"},
  Mail_124315_Desc = {
    Text = "Mi querido Excelencia Guardián del Secreto:\n\nSiento como si mi corazón estuviera creciendo... Sé que suena extraño para un Despertado, pero es diferente a antes, ¿cómo puedo describírselo?\nNo importa cuán amables y cariñosos sean esos buenos hombres conmigo, tratando de calentarme, después de que mi hermano se fue, siempre hay un vacío en mi pecho. Cuanto más camino bajo el Sol, más me rasguña ese calor. En cambio, la oscuridad y la humedad me dan más tranquilidad, como si mientras permaneciera en un lugar frío, el amor severo y doloroso de mi hermano nunca se hubiera ido.\nPero ahora, después de estos años de intimidad creciente con usted, cada vez que lo veo, cada vez que ese dolor que me otorga cae sobre mi piel y se transmite a mis huesos—¡ah, la felicidad en mi pecho crece cada vez más! Mientras me castigue sin piedad, me insulte, me maltrate, sé que siempre habrá un lugar en este mundo donde realmente pueda pertenecer.\n¿Podrá esta felicidad perdurar hasta el próximo año, y al siguiente? Si se cumplen los deseos de cumpleaños, mi único deseo es ser mirado por usted con desprecio, y también dolor... más y más dolor. Cuando levante la mano, lo primero que sentiré será ese aroma familiar, cruel y feliz.\n\nCon muchas, muchas ganas de ser castigada, Leigh"
  },
  Mail_124315_Name = {
    Text = "mi corazón"
  },
  Mail_124315_Sender = {Text = "Leigh"},
  Mail_124316_Desc = {
    Text = "Guardián del Secreto\n\nAunque tengo muchas ganas de saber cómo han ido tus prácticas recientes, por favor, no te preocupes, hoy no vengo a presionarte para que realices tu entrenamiento musical.\nEsta mañana, como de costumbre, me dirigí a la sala de música, pero llegué con treinta y cinco minutos de retraso. A las siete de la mañana realizo mi entrenamiento musical, un hábito que he mantenido durante décadas, y hoy se rompió fácilmente. La razón es que, al pasar por el pasillo de la escuela, escuché el canto de un mirlo.\nRomper un hábito que he mantenido durante tantos años no es algo fácil de aceptar, y para mí, aún más. Lo curioso es que no me sentí decepcionado ni enojado conmigo mismo como había imaginado. Al principio, sentí un poco de pánico. Pero luego, tuve que admitir que la melodía que resonaba en mi mente era placentera.\nLondinium siempre despierta con el canto de los mirlos, un sonido que escucho todos los días, y lo curioso es que, durante todos estos años, es la primera vez que realmente lo noto. Me quedé en el pasillo escuchando sus canciones en silencio, y durante esos treinta y cinco minutos, sentí que la más sublime melodía del universo estaba escondida en sus pequeñas gargantas.\nQuizás la vida aquí hace que uno se sienta complacido, o tal vez la atmósfera aquí nos vuelve más suaves. Sea como sea, creo que debe tener que ver contigo.\nAcepté este cambio con gusto en diez minutos. La vida, al igual que la música, tiene su eterno ritmo y cambios; el día de nuestro nacimiento, quizás, es el punto en el que estos cambios están destinados a ocurrir. También quiero agradecerte por darme la oportunidad de detenerme y escuchar lo que había ignorado. Placer, así es. Creo que este será el comienzo de un nuevo capítulo en mi vida musical.\nPor ello, quiero invitarte a que hoy al anochecer vayamos juntos al bosque denso fuera de la escuela. Los sonidos de la naturaleza al anochecer son diferentes a los de la mañana, pero creo que ambos serán nuevas inspiraciones en nuestra vida musical.\n\nHameln"
  },
  Mail_124316_Name = {
    Text = "Sonido de la naturaleza"
  },
  Mail_124316_Sender = {Text = "Hameln"},
  Mail_124317_Desc = {
    Text = "Noble: \n\nAcabo de ver el correo de cumpleaños que Faint te escribió... Como era de esperar, ella siempre piensa en los demás; entre hermanas nunca ha habido deudas, y yo nunca la he visto como una carga. Sin su protección, no tendría la oportunidad de estar de gira ahora. \nEstimado noble, siempre has sido mi oyente más importante. Así que esta vez, también he preparado en secreto un billete de barco para ti—te invito sinceramente a embarcarte en este viaje interestelar con nosotros. Si estás con nosotros, creo que la carga en el corazón de mi hermana se aliviará mucho. \nAdemás, por favor, no te preocupes, durante el viaje nunca interrumpiremos tu tiempo privado. Tanto mi hermana como yo esperamos que puedas disfrutar plenamente de este viaje y sentir libremente cada nebulosa y cada encuentro desconocido. \n\nTinct"
  },
  Mail_124317_Name = {
    Text = "Invitación de Viaje"
  },
  Mail_124317_Sender = {Text = "Tinct"},
  Mail_124318_Desc = {
    Text = "Guardián del Secreto: \n\nSe acerca mi cumpleaños, pero mis pensamientos siempre vuelven sin querer a Cité. Echo de menos especialmente las esculturas en las exposiciones de arte. Sus silenciosas posturas han golpeado innumerables veces la puerta de mi inspiración. \nPasando todo el día en el estudio rodeado de esculturas, la falta de intercambio artístico se ha vuelto aburrida durante mucho tiempo. En esta época del año pasado, para celebrar mi cumpleaños, esculpí innumerables pasteles de escultura. El entusiasmo inicial, hoy ha vuelto a la calma. \nAhora me resulta difícil moverme, regresar a Cité se ha convertido en un lujo. Si tienes planes de ir a investigar, ¿podrías prestarle atención a las nuevas obras en las exposiciones de arte? Anhelo tocar una vez más la belleza del arte diverso e inclusivo a través de tus ojos. \nComo recompensa, estoy dispuesto a crear una escultura para ti, titulada \"El Guardián del Secreto en Cité\", ¿te parece bien? \n\nSanga"
  },
  Mail_124318_Name = {
    Text = "Recuerdos de Cité"
  },
  Mail_124318_Sender = {Text = "Sanga"},
  Mail_124770_Desc = {
    Text = "Guardián del Secreto: \n\n Debido a que cada año se me cancelan los permisos para entrar al laboratorio, este día se ha vuelto especial de una manera poco placentera. Para no perder tiempo en trivialidades ineficientes, fui a los archivos. \n Allí encontré dos cosas, uno de ellos era un cuaderno de tareas, lleno de vacíos sin valor. \n El otro también era un cuaderno de tareas, que me hizo darme cuenta de que subestimé la inmensidad del conocimiento, porque el proceso de proyección y las conclusiones en él me hicieron saber que en el mundo existen cosas que tienen un valor incluso menor que la inexistencia. \n Y estos dos cuadernos de tareas tenían el mismo nombre escrito, nuestro gran Guardián del Secreto Misaq %player%. \n Erica me dijo que quieres saber qué regalo de cumpleaños debería darme. \n Puedes darme una respuesta. \n También me gustaría saber cuál respuesta me sorprenderá más. ¿Es simplemente la pereza y desinterés llevados al extremo, o es que estudiaste seriamente durante todo un año y al final dejaste estos desechos académicos en la desesperación inútil? \n Si es lo primero, siempre que haya una razón suficiente y puedas demostrar que has dominado todo lo enseñado en clase, puedo presentar una solicitud de exención de tareas a la academia en tu nombre. Por supuesto, esto no significa que apoye esta posible pereza que podría llevarte a ser completamente negligente, pero mientras puedas seguir pasando mis pruebas, no soy un viejo rancio y no me importa dar a mis estudiantes algunos privilegios. \n Si es lo segundo, como tu primer guardián, créeme, no importa cuán difícil de moldear seas, podemos encontrar en las técnicas que domino alguna que mejore tu conocimiento demasiado escaso y te saque del doloroso estado de ignorancia en el que te esfuerzas. \n Esta tarde a las cuatro, estaré en los archivos, inspeccionando personalmente tu dominio del conocimiento de clase, no llegues tarde. \n\n Doll"
  },
  Mail_124770_Name = {Text = "privilegio"},
  Mail_124770_Sender = {Text = "Doll"},
  Mail_124771_Desc = {
    Text = "Cachorro de Misaq: \n\nEste año también estás atrapado en esas rutinas cíclicas, causando problemas, salvando el mundo, haciendo amigos, aprendiendo cosas nuevas, y continuando creando una ilusión de \"todo como de costumbre\" para el mundo. \nResulta que incluso si sacas tu cerebro de tu cuerpo, y la Luminis se desplaza de una dimensión a otra, no afecta tu absurda y cómica prisa y agitación. \nEs realmente bullicioso y ajetreado, querido cachorro. \nNo crees en esos hechos, insistes en prolongar su sufrimiento, ¿cuál es tu propósito? ¿Estás actuando como un tonto, o los humanos realmente pueden ser tan tontos? Aún si efectivamente he abierto la corteza de tu cerebro, esto sigue siendo un misterio sin resolver para mí. \nFelicidades, realmente me has hecho dudar, de hecho, comencé a cuestionar, si observarte me trae tanto placer, ¿puede todo ser realmente sin sentido? \nReza sin sentido, como esas cosas sin sentido que te gusta hacer, a quien sea que dirijas tu oración no importa. \nReza para que puedas seguir encadenándome, pequeño cachorro, así tanto tú como yo podremos encontrar un poco de diversión en este mundo sin sentido. \n\n\"Doll\""
  },
  Mail_124771_Name = {Text = "¡Ora"},
  Mail_124771_Sender = {
    Text = "Doll: Infierno"
  },
  Mail_124772_Desc = {
    Text = "Compañero: \n\nCada año, en el día de tu cumpleaños, te escribo una carta, como si sin darme cuenta se hubiera convertido en una costumbre. \nRecuerdo que el primer cumpleaños en el que te escribí, fue también la primera vez que mi padre me permitió organizar mi propio plan de cumpleaños. Te invité a salir conmigo, y después de eso, vivimos juntos demasiados primeros momentos. \nMuchas cosas cambiaron después de eso, pero al pensarlo bien, parece que no ha cambiado nada. Seguimos avanzando por el camino que hemos elegido, y seguimos teniendo la compañía del otro, además, sigues siendo para mí, el compañero más importante. \nAsí que, aunque mi padre acaba de traerme un pastel y me preguntó si quería asistir a la fiesta que organiza para mí esta noche, tengo algunos otros planes. \nSe ha estrenado una nueva película en Londinium, que ha sido inusualmente popular, pero la academia y la asociación ya han confirmado conjuntamente que no hay ninguna reacción espiritual en ella. \nEsto significa que realmente es solo una película \"normal\" muy interesante. \nJusto tengo dos entradas, puedes suponer que no he hecho una excepción para molestar a la Señora Sorel, porque las entradas son realmente difíciles de conseguir. \nEntonces, compañero, ¿estarías dispuesto a dejarme este tiempo? Tal vez, podamos alejarnos temporalmente de esas situaciones anormales que manejamos día a día y pasar juntos una \"noche normal\". \nCada mañana que venga después, cuando despertamos, pase lo que pase en el mundo, estaré contigo para enfrentar todo. \n\nRamona"
  },
  Mail_124772_Sender = {Text = "Ramona"},
  Mail_124773_Desc = {
    Text = "Guardián del Secreto: \n\nGracias a mi conexión especial con ese yo y al enlace entre tú y yo, incluso si no estoy contigo en todo momento, tengo un ligero conocimiento de tus movimientos en el último año. \nHas estado activo en otro mundo, parece que todavía has traído un cambio llamado \"esperanza\", incluso al mirar hacia arriba en el pozo negro día tras día, esa energía que brilla también me ha calentado. \nHe comenzado a retomar mi agenda anterior, pero a diferencia de antes, ahora no enfrento esa aniquilación inevitable con una mentalidad de lucha inútil. Me has enseñado algo nuevo, el proceso por el cual cada existencia se esfuerza al máximo para continuar antes del destino inevitable, es precisamente la razón por la que la civilización, el alma y la voluntad tienen significado. \nNo importa cuán breve sea este tiempo para el mundo en el que estoy, seguiré intentando. Aunque sea solo para volver a ver esos rostros familiares y conversar con ellos, ese intento no es en vano. \nHasta que tú pares, seguiré caminando por este camino, permíteme ser caprichoso y considerarlo como una forma de estar a tu lado, así tal vez puedas pensar de vez en cuando, en el camino que avanza constantemente, que siempre hay un yo haciendo lo mismo que tú. \n\n\"Ramona\""
  },
  Mail_124773_Sender = {Text = "\"ramona\""},
  Mail_124774_Desc = {
    Text = "Es muy fácil matar al objetivo, pero limpiar después es un asunto complicado.\nEste año quería seguir la tradición del año pasado y ayudarte a matar a alguien.\nSin embargo, he notado que no has utilizado el último regalo que te envié, y tras reflexionar, aunque no sé si es por eso, me he dado cuenta de mi descuido.\nPuedes estar completamente tranquilo, aunque para mis antiguos empleadores solo ofrecía el servicio de matar enemigos, tengo mucha experiencia en eliminar cualquier rastro para evitar todo tipo de problemas. Incluso si la persona que deseas matar está bajo la protección de esas tediosas reglas y órdenes, no necesitas sentirte culpable, yo me encargaré de todo.\nTe prometo que nadie podrá rastrear nada hasta ti.\nUna vez que tengas a la persona en mente, solo dímelo, iré de inmediato a ayudarte a deshacerte de Él.\nFeliz festividad, y espero que te sientas feliz en el día de mi nacimiento, Guardián del Secreto.\n\n\nHelot"
  },
  Mail_124774_Name = {
    Text = [[
Los que matan con frecuencia saben
...]]
  },
  Mail_124774_Sender = {Text = "Helot"},
  Mail_124775_Desc = {
    Text = "Está bien, claramente no estáis preparados para detener este comportamiento, y según lo que sé, ya me he acostumbrado a la costumbre de \"dar regalos\".\nPero un día os arrepentiréis de esta amabilidad, creedme.\nAhora que lo pienso, podría ser la cosa de la que más me arrepiento, maldita sea, no pensé que me arrepentiría de matar.\nNadie lo sabe mejor que yo, la supuesta disculpa no tiene ningún valor, pero antes de que llegue ese día, haré todo lo posible para compensarlo, solo porque quiero hacerlo.\nCuando en el futuro me guardéis rencor por eso, no tenéis que sentir ninguna carga psicológica.\nAceptaré toda vuestra ira.\n\nH"
  },
  Mail_124775_Name = {
    Text = "Te arrepentirás"
  },
  Mail_124775_Sender = {
    Text = "Helot: Catena"
  },
  Mail_124776_Desc = {
    Text = "Guardían del Secreto: \n\nHa llegado de nuevo el día del nacimiento, que debería ser un día de celebración por la vida, así que cada vez que llega este día, siento unas emociones maravillosas. \nMi nacimiento parece estar destinado a perseguir la muerte, y cuando me alejo de este tema de la muerte, ¿qué significa realmente la vida... o más bien, la conciencia que sigue existiendo en el momento? \nEn vida, el tira y afloja del dolor y la culpa está tan entrelazado con mi existencia que parece que solo con la llegada de la muerte, la vida realmente me pertenece por primera vez. \nEl año pasado, este año, o quizás cada año que vendrá. He tenido un tiempo tan largo que casi parece infinito para experimentarlo, cada día es similar al anterior, pero también diferente. Cuando la vida ya no está atada por el dolor y el propósito, ¿cómo será su final, o ese llamado final, volverá a llegar? \nEste tema es demasiado grande, y no logro entenderlo del todo. \nPero el deseo de registrar las emociones de estos pensamientos extraños es tan real, que siento que la respuesta parece obvia. \nAl menos para mí, son esos momentos concretos y preciosos, sin importar cuán confusas sean mis reflexiones, sin importar cuán difícil sea para mí encontrar mis raíces, sé con claridad hacia dónde pueden fluir y dónde serán acogidas, y también tengo muchas ganas de mostrarlas a usted. \nTal vez el próximo año en este día, pueda encontrar un significado más autêntico para mí, pero ahora, espero poder retener egoístamente estos pequeños momentos, que solo usted y yo conocemos. \nSí, Guardián del Secreto, usted y todos en Misaq son las raíces de mi interior que nadie conoce. \nGracias, como siempre, deseo que siempre sea feliz y esté en paz. \n\nNymphaea"
  },
  Mail_124776_Name = {
    Text = "sistema de raíz"
  },
  Mail_124776_Sender = {Text = "Nymphaea"},
  Mail_124777_Desc = {
    Text = "Yú ha inventado una nueva forma de relajarse: la siesta del Reino Divino. \n A diferencia de las siestas cortas y apresuradas, durante la siesta del Reino Divino, Yú se aleja del largo Trono de piedra azul, construye una esfera que bloquea el sonido con su muñeca y llena todo el espacio con agua de mar especial. \n Esta agua de mar no solo puede emitir el aroma que Yú desea y transformarse en el paisaje que Yú desea ver, sino que también puede sostener el cuerpo de Yú desde todas las direcciones con la intensidad adecuada. \n Por lo tanto, sin importar qué tipo de postura adopte Yú, puede experimentar una sensación de calidez envolvente, como si estuviera en la mejor cama de plumas. \n En ese momento, Yú podrá relajarse en la fragancia que le gusta, disfrutando de la tranquilidad aislada del mundo, apoyándose en su almohada favorita y durmiendo plácidamente. \n Como el súbdito favorito de Yú, Yú considera que el día de su cumpleaños es el más adecuado para compartir esta tranquilidad contigo. Si estás interesado, puedes venir al lugar secreto del que te hablé la última vez. No te preocupes por tu seguridad, Yú creará un espacio solo para ti, para que estés libre de la influencia de los sueños de Yú. \n No olvides llevar tu almohada más cómoda. \n\n Tulu"
  },
  Mail_124777_Name = {
    Text = "descanso de mediodía"
  },
  Mail_124777_Sender = {Text = "Tulu"},
  Mail_124778_Desc = {
    Text = "Mi luz: \n\nHe adaptado mi vida en Misaq junto a Castor, después de escapar de las maquinaciones sangrientas de la iglesia, siento que estoy recuperando mi antiguo yo. \nAunque en mis palabras y acciones diarias aún se mezclen inevitablemente algunas sombras de \"Hijo Santo\", creo que pronto podré lavar completamente esa arrogancia y distanciamiento, conservando solo la humildad hacia lo divino y la decisión de seguir el camino. \nMás temprano, recibí un regalo algo inesperado, un libro bellamente encuadernado que habla sobre las historias de quienes regresan a su hogar y recuperan su infancia. Junto con él, llegó una nota que decía \"Te deseo que pronto recuperes tu yo original\". \nLas primeras palabras de esta frase hicieron aflorar recuerdos en mi mente—la preocupación de todos en Misaq, tu guía, y mi hermano... el cálido abrazo. \nPor eso, este año en mi cumpleaños, quiero invitar a todos en Misaq a celebrar la fiesta de cumpleaños mía y de mi hermano. Sin la ayuda de todos ustedes, no tendríamos ninguna posibilidad de recuperar esos tiempos iniciales. \nHe reservado un restaurante con los ahorros que he acumulado recientemente, donde el chef tiene experiencia en diversas cocinas del mundo, y estoy seguro de que cada uno podrá disfrutar del sabor más familiar allí. \n\nPollux"
  },
  Mail_124778_Name = {
    Text = "Regresar a la infancia"
  },
  Mail_124778_Sender = {Text = "Pollux"},
  Mail_124779_Desc = {
    Text = "He decidido aceptar la invitación del underground de la arena de combate en las afueras, para luchar en una pelea a vida o muerte. \n Aunque los días en el club de truchas son buenos, son demasiado monótonos; todos los días son o matar peces o matar peces. Tal vez realmente he conquistado completamente a las truchas, pero conquistar a las truchas no cuenta como una verdadera conquista. \n La sangre de guerrero que fluye dentro de mí está hirviendo, siempre ha anhelado una batalla emocionante, y ahora, la oportunidad ha llegado. \n El calvo que se puso en contacto conmigo dijo que me había conseguido tres enormes pitones natay, dos osos demonio, cuatro cocodrilos serinason y un montón de extrañas criaturas cuyos nombres no recuerdo, suficientes para que pueda luchar toda la noche. \n Me aseguré de que programaran la pelea para hoy, para poder mostrarte en mi cumpleaños —yo, Uvhash, el último guerrero romano, la grandeza de conquistar todas las bestias feroces del mundo. \n Hoy, lo que cubrirá el terreno ya no serán los restos de las truchas, sino sangre y cadáveres de bestias y aves extraordinarias. \n\n Uvhash"
  },
  Mail_124779_Name = {
    Text = "Conquista de bestias"
  },
  Mail_124779_Sender = {Text = "Uvhash"},
  Mail_124780_Desc = {
    Text = "\"Caballero de la Llave de Plata\": \n\n¡Guardián del Secreto! Justo ahora, mientras estaba modificando el \"Fantasma\", Mosk de repente me trajo una gran bolsa de piezas, diciendo que era un regalo de cumpleaños para mí. ¡Fue entonces cuando recordé que hoy es mi cumpleaños! \nAsí que rápidamente escribí una carta para ti, de verdad, ¿cómo pude olvidar hoy otra vez? Claramente he escrito... ¿cuántas notas ya? \nPero eso no es importante, lo importante es que recordé lo que dije que haríamos en mi cumpleaños: ¡voy a montar el \"Fantasma\" y llevarte a ti y a Mosk a dar cien vueltas por todo Londinium! \nAunque Mosk no entiende nada de mecánica, esa bolsa de piezas que tiene es realmente enorme, tanto que puedo encontrar todas las piezas que necesito. Ahora, el \"Fantasma\" modificado ya es una versión prototipo súper mejorada (temporalmente)!\nHe puesto un nombre a esta aventura, lo llamé la aventura de Nautila con los Guardianes del Secreto y Mosk y el \"Fantasma\", ¿qué te parece? Es bastante directo y fácil de recordar, así que seguro que no olvidaré esta aventura. \n¡Jejeje, realmente estoy emocionado, Guaridan del Secreto, espera un momento! ¡Nautila, el \"Caballero Fantasma\" y Mosk, el \"Caballero Vórtice\", ya están en camino! \n¡Equipo de aventuras del \"Fantasma\", al ataque! \n\nNautila que viene a toda velocidad"
  },
  Mail_124780_Name = {
    Text = "¡Ataque \"Fantasma\"!"
  },
  Mail_124780_Sender = {Text = "Nautila"},
  Mail_124793_Desc = {
    Text = "Estimado y grandioso <Del:adorable> Guardián del Secreto {Male=señor,Female=señorita}:\n\nEjem, hace tiempo que no nos comunicamos, nuestro querido Guardián del Secreto {Male=señor,Female=señorita} ¿me extrañaste~?\nAhora eres una gran celebridad en Misaq, ¡todos los estudiantes están aprendiendo sobre tus valientes hazañas! ¡Cualquier cosa que tenga una pizca de relación contigo se puede vender a precios exorbitantes en el mercado negro!\nPero eso es normal, después de todo, ¿quién te manda a ser la \"leyenda viviente\", el único Guardián del Secreto de Misaq?\nEste año han sucedido muchas cosas interesantes en Misaq: Aurita se hizo amiga de unos galletas de jengibre, el profesor Doll voló diecisiete laboratorios para cambiar el diseño de su cráneo, Castor fue engañado por Agrippa para ayudarla en un examen, ¡y el resultado fue peor que si ella misma hubiera hecho el examen!\nOh, y también está ese maldito ratón, que ¡robó mi valiosa película! ¡Era la forma de gato de la señorita \"24\" que logré capturar con tanto esfuerzo!\nAdemás de eso, hay muchas más cosas, las he organizado y te las envío como una edición especial de Año Nuevo del periódico escolar.\n¿Qué? ¿Tienes curiosidad sobre cómo logré contactarte? Jeje, es un secreto, no diré que utilicé muchos secretos exclusivos para intercambiar con una dama que claramente es difícil de tratar.\nEn este nuevo año, ¡trabajemos juntos! ¡Feliz Año Nuevo, %player%!\n\nHanna Peaslee"
  },
  Mail_124793_Name = {
    Text = "Edición Especial de Año Nuevo"
  },
  Mail_124793_Sender = {
    Text = "Hanna Peaslee"
  },
  Mail_124794_Desc = {
    Text = "Mensajero Pálido: \n\nLa escarcha plateada se acerca, permíteme expresarte mis más sinceras bendiciones aquí primero. \n\nLa última vez que visité a los niños en la Casa de pobres Liliana, algunos de ellos me preguntaron en secreto: \"¿Realmente existe el Mensajero del Festival de Invierno?\". \nMe dio curiosidad saber por qué estos niños tenían tal idea, si no recuerdo mal, el año pasado cada uno de los niños recibió un regalo del \"Mensajero del Festival de Invierno\". \nSin embargo, los niños me dijeron: \"¡Vi a ese hombre guapo entregarle el regalo a la directora Diana, no se parecía en nada al Mensajero del Festival de Invierno!\". \nSupongo que fue el Noble quien, al entregar los regalos a la Casa de pobres, fue descubierto accidentalmente por los niños, lo que generó estas pequeñas dudas posteriormente. \n\nPor lo tanto, esta Noche de escarcha plateada, he preparado dos trajes muy tradicionales del Mensajero del Festival de Invierno, y me gustaría que tú, Mensajero Pálido, te unieras a mí para interpretar al Mensajero del Festival de Invierno y entregar regalos a estos niños. \nEstoy seguro de que habrá niños que, en la noche, abrirán los ojos en secreto, anotarán nuestra imagen de ropas rojas y gorros rojos, y luego, con gran alegría, dirán a todos durante la Fiesta de Solsticio: \"¡Vi al Mensajero del Festival de Invierno!\". \nAl mismo tiempo, también he preparado un regalo especial para ti, espero que te guste. \nFeliz Fiesta de Solsticio. \n\nSalvador"
  },
  Mail_124794_Name = {
    Text = "Mensajero del Festival de Invierno"
  },
  Mail_124794_Sender = {Text = "Salvador"},
  Mail_124991_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"Curación múltiple·clon\" ha terminado, y ahora procederemos a recuperar la moneda de evento restante \"Puzles de Memoria\" a razón de cada uno canjeado por \"Rosa Dorada\" × 40, por favor, recuerde verificar."
  },
  Mail_124991_Name = {
    Text = "Recuperación de Rompecabezas de Memoria"
  },
  Mail_124991_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_125448_Desc = {
    Text = "Estimado guardián del secreto: \n La actividad \"Noticias antiguas de la ciudad marítima\" ha terminado, y ahora procederemos a convertir los \"Dulce de pera\" restantes del guardián según la proporción de \"Rosa Dorada\" × 40 por cada uno. Por favor, recuerda verificar."
  },
  Mail_125448_Name = {
    Text = "Reciclaje de dulce de pera"
  },
  Mail_125448_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_126321_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"Tejedor autoencadenado\" ha terminado, y ahora convertiremos los \"Boleto de asiento de terciopelo\" restantes del guardián según la proporción de \"Rosa Dorada\" × 40 por cada uno. Por favor, recuerda recogerlo."
  },
  Mail_126321_Name = {
    Text = "Conversión de Boleto de asiento de terciopelo"
  },
  Mail_126321_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_126934_Desc = {
    Text = "Guardián del Secreto: \n\nHa llegado otro día especial. Ah, no te preocupes, este año no te haré sugestión psicológica, solo quiero invitar a mi paciente más especial a un lugar para relajarse. \nAllí hay un bosque frondoso, un río cristalino, lleno de la esencia de la naturaleza, que te permitirá olvidar la fatiga del bosque de acero. También habrá una suave alfombra, una cálida chimenea y luces brillantes, que te ayudarán a aliviar la presión del ritmo acelerado de la ciudad. \nPodemos pasear, leer, charlar, y lo que quieras compartir, estaré encantado de escucharte. \nAh, solo imaginar esa escena ya me emociona... \nSé que en este momento, puedes sentirte un poco inquieto. Después de todo, no puedo garantizar que no disfrutaré de esos recuerdos llenos de dulces dolores que tienes. Pero aún así vendrás, ¿verdad? \nNo solo porque hoy es mi cumpleaños, sino porque me necesitas, necesitas hablarme, necesitas que te escuche. \nBuen niño, lo entiendo, y también te esperaré. Ven, olvida la ajetreada rutina y las pesadas responsabilidades, disfruta de este momento de paz. \n\nClementine"
  },
  Mail_126934_Name = {
    Text = "Momento de Ning"
  },
  Mail_126934_Sender = {Text = "Clementine"},
  Mail_126935_Desc = {
    Text = "Otro día aburrido. \n He probado muchas cosas: las fiestas tradicionales filisteas, jugar algunos juegos infantiles con las pandillas de Londinium, pero ninguna es digna de celebrar el día del nacimiento del rey de los gigantes. \n En los viejos tiempos, este día significaba juerga y batalla. Solía reunirme con los guerreros más poderosos en el campamento, luchando y conmemorando este gran día con fuerza y sangre. \n Paz. Aburrida y sofocante paz. Entiendo el anhelo de tu pueblo por ella; no todos tienen el corazón de un guerrero. Sin embargo, no piensen que esta falsa paz puede opacar la gloria del rey Goliat. \n Todo lo que una vez fue mío, territorios, riquezas, poder, la gloria eterna de los filisteos... el día que los recupere, te invitaré, Guardián, a sentarte a mi derecha como mi invitado más honorable, viendo cómo el gran rey de los gigantes recupera su trono. \n Tenía la intención de acabar directamente con este aburrido día, pero acabo de escuchar que esas pandillas desbandadas han formado una alianza. Planean «emboscar» al rey de los gigantes en el banquete de esta noche. \n Comparado con las guerras de los filisteos, esto es solo un juego infantil. Pero en estos aburridos días de paz, tener un espectáculo como este también me resulta... refrescante. \n Ven a ver nuevamente la majestuosidad del rey Goliat en batalla. De pie a mi lado, o de pie frente a mí, como quieras. \n Pero hazlo rápido. Si llegas tarde, solo habrá cadáveres que ver. \n\n Goliat"
  },
  Mail_126935_Name = {
    Text = "Programa de entretenimiento"
  },
  Mail_126935_Sender = {Text = "Goliath"},
  Mail_126936_Desc = {
    Text = "Estimado guardián del secreto: \n\nHola. Para servir mejor a los estudiantes y profesores de Misaq, Erica realizó recientemente un mantenimiento y mejora por su cuenta, y usted ha sido afortunadamente seleccionado como candidato para evaluar los resultados de esta mejora. Esta evaluación se llevará a cabo de manera presencial y requiere que evalúe la funcionalidad del módulo emocional LY-S-761, recientemente instalado en el autómata Erica. Se estima que esta prueba tomará 90 minutos, así que le pedimos que planifique con anticipación para evitar conflictos en su agenda. \nA continuación se detallan los contenidos de esta evaluación: \n1. Por favor, tenga una conversación abierta y profunda con Erica durante al menos 15 minutos, centrada en el tema de \"cumpleaños\", para evaluar el rango y profundidad de su comprensión de emociones específicas. \n2: Simule una interacción con Erica en el escenario de \"regalar un regalo de cumpleaños\" para evaluar la precisión, flexibilidad y comodidad de su reconocimiento emocional y respuesta empática. \n3: En la segunda mitad de la evaluación, mencione intencionalmente detalles personales que Erica haya mencionado en la conversación anterior (como su actitud y comprensión sobre los cumpleaños) para evaluar si su memoria de interacción a largo plazo y su capacidad de asociación funcionan correctamente. \n\nDespués de completar la evaluación anterior, dígale a Erica \"Erica, feliz cumpleaños\" para finalizar la evaluación; el autómata entrará automáticamente en modo de carga de datos. \nGracias por su participación; después de completar la evaluación, Erica le regalará un pequeño obsequio especial. También le pedimos que continúe apoyándonos en el futuro; su asistente más cercano, Erica, siempre estará a su lado. \n\nErica"
  },
  Mail_126936_Name = {
    Text = "Evaluación de mejora de cumpleaños"
  },
  Mail_126936_Sender = {Text = "Erica"},
  Mail_126937_Desc = {
    Text = "¡Hah! ¿Qué pasa hoy? ¿Por qué, sin importar a dónde voy, todos parecen evitarme conscientemente? Ni siquiera he abierto la boca, y ya están moviendo las manos diciendo que les duele aquí o allá, lo que me impide pedir un duelo. \n Es raro que en mi \"cumpleaños\" no necesite ninguna razón para pelear con otros, ¿no es así? Entonces, ¿no sería lo mismo que en cualquier otro día? \n Tsk, no debí haberlos golpeado tan duro el año pasado. Pero no se puede evitar, después de todo, he estado perfeccionando mi técnica de espada desde antes de que este planeta naciera, y es natural que personas comunes no puedan soportarlo. \n Sin embargo, tú eres diferente a ellos, ¡tú eres el Guardián del Secreto! \n Así que sabes lo que quiero decir, ¿verdad? En el mismo lugar que el año pasado, ¡vamos a tener una buena pelea! Esta vez, nadie interrumpirá nuestra batalla. \n\n Lotan"
  },
  Mail_126937_Name = {
    Text = "El único oponente"
  },
  Mail_126937_Sender = {Text = "Lotan"},
  Mail_126938_Desc = {
    Text = "Querido, querido, querido amo: \n\n ¿Ha oído hablar de ello? Hoy se llevará a cabo un baile super lujoso en la mansión del alcalde, y todos los caballeros y damas se enorgullecen de poder asistir a este baile. \n Por supuesto, como sirvienta, Karen no tiene derecho a asistir. Pero usted, Guardián del Secreto Misaq, mi querido y más querido amo, merece todas las cosas bellas del mundo, y por supuesto también merece este baile. \n Así que Karen ya ha aceptado la invitación en su nombre, y además, he ordenado un carruaje para usted, he preparado todo, y cuando llegue el momento, solo necesita ir con Karen a la casa del alcalde. ~\n Karen se pondrá su vestido más hermoso y llevará sus joyas más brillantes, ¡para que todos vean lo increíble que es una sirvienta versátil, para que usted se sienta orgulloso y brille! \n Ah, cuando usted lea esta carta, ya debería estar esperándolo fuera de su puerta, y esos carruajes, así como los sirvientes que traen ropa nueva y joyas, ya estarán listos, el único pequeño problema es que estos servicios aún no han sido pagados... \n Pero mi amable y adorable amo nunca se preocupará por estas pequeñas cosas, ¿verdad? El alcalde nos está esperando~ \n\n Su sirvienta más adorable y brillante \n Karen"
  },
  Mail_126938_Name = {
    Text = "Baile de lujo"
  },
  Mail_126938_Sender = {Text = "Karen"},
  Mail_126940_Desc = {
    Text = "¡Guardían del Secreto, Guardián del Secreto! Hace unos días, Jenkin dijo que encontró un lugar que se parece mucho a la casa de Aurita, que parece llamarse agua... Hmm, Aurita olvidó. \n En fin, Jenkin dijo que allí habría delfines, pececitos, acuarios y muchas, muchas medusas, ¡y también dijo que todos estaban dispuestos a ser amigos de Aurita! \n A Aurita le gustan los amigos, Aurita quiere tener muchos, muchos amigos, así que Aurita quiere invitar a su amigo favorito, que es el Guardián del Secreto, a ir juntos. \n ¡Apúrate a empacar y vamos, Aurita ya no puede esperar! \n\n Aurita, que quiere conocer a muchos, muchos nuevos amigos"
  },
  Mail_126940_Name = {
    Text = "¡Nuevos amigos en el acuario!"
  },
  Mail_126940_Sender = {Text = "Aurita"},
  Mail_126941_Desc = {
    Text = "Guardián del Secreto: \n\nGracias por acompañarme esta madrugada en la playa, el sonido de las olas y el brillante cielo estrellado me hicieron sentir en paz y también me recordaron... cosas de hace mucho, mucho tiempo. \nEn aquel entonces, los marineros me prohibían hablar con ellos, así que la mayor parte del tiempo solo podía contemplar la superficie del mar en constante cambio y las aves marinas que giraban en el aire. Los marineros, al observar cómo volaban esas aves, inconscientemente me hacían deseos. \nOcasionalmente, deseaban convertirse en aves y volar de regreso a casa, junto a sus seres queridos; a veces, deseaban que su viaje terminara pronto, intercambiando la carga del barco por riquezas; y de vez en cuando, rezaban por encontrar un amor romántico o por encontrarse con las legendarias sirenas... \nPero, no importa cuán complicados sean los deseos, a medianoche todos se unifican en el anhelo de un sueño reparador. En ese momento, respondo a sus súplicas, calmando el viento marino y suavizando las aguas. \nAsí que, si tú, Guardián del Secreto, también tienes dificultades para dormir, por favor no vagues solo en la playa a la madrugada, ven a buscarme. \nQuiero compartir tu carga y ser útil, y proteger tu sueño es lo que puedo hacer ahora. \nEste es también... el \"deseo\" que hice en este día tan especial. \n\nCeleste"
  },
  Mail_126941_Name = {
    Text = "Deseándote un sueño pacífico"
  },
  Mail_126941_Sender = {Text = "Celeste"},
  Mail_126942_Desc = {
    Text = "Por el gran favor del destino, Guardián del Secreto de la Universidad de Misag, noble y sabio señor: \n\n ¡Mil bendiciones! \n Mientras escribía esta carta, estuve dudando, pero la honestidad también es una de las virtudes de un caballero. Como caballero de su señor, debo ofrecerle toda mi lealtad, sin ocultar nada, por lo que también debo decirle la verdad: \n en este día de su cumpleaños, mi señor, le pido que venga a mi habitación y me lea un cuento antes de dormir. \n Permítame... apoyarme a su lado y dormir en los sueños hermosos y fantásticos que usted narra. \n En realidad, este fue uno de mis deseos de infancia. Pero el entrenamiento de un caballero no permite un momento de pereza, y ya he pasado la edad de escuchar cuentos, así que siempre lo he guardado en mi corazón, sin haberlo expresado en voz alta. Pero usted... mi señor, es diferente, no quiero ocultarle nada... \n Si usted considera que esto no es apropiado, por favor, hágamelo saber. Desde entonces, no volveré a hacer tal pedido excesivo y me entrenaré con el doble de esfuerzo. \n Espero su respuesta. \n\n Ogier"
  },
  Mail_126942_Name = {
    Text = "La solicitud del caballero"
  },
  Mail_126942_Sender = {Text = "Ogier"},
  Mail_126943_Desc = {
    Text = "Bola de carbón: \n\nHoy, Mosk, ¡cumpleaños!\nLos amigos dicen, cumpleaños, escribir carta, a Bola de carbón, Bola de carbón, ¡vendrá a jugar!\nMosk, no sabe escribir cartas. Pero, ¡los amigos sí!\nLos amigos, enseñan a Mosk. ¡Mosk está feliz!\nEn realidad, Mosk olvidó el cumpleaños.\nPero, ¡Mosk quiere jugar con Bola de carbón!\nAsí que, Mosk decide, ¡hoy es su cumpleaños!\nBola de carbón, conchas, recoge, doradas, blancas, ¡tiene de todo!~\nAl ver a Bola de carbón, ¡feliz!~Los amigos, cocinan, ¡delicioso!~\nBola de carbón, en el viejo lugar~\n¡Dejaron que los amigos hicieran un gran banquete! ¡A comer juntos!\nMosk, te espero~\n\nMosk"
  },
  Mail_126943_Name = {
    Text = "¡Cumpleaños! ¡Ven a jugar!"
  },
  Mail_126943_Sender = {Text = "Mosk"},
  Mail_126944_Desc = {
    Text = "Guardián: \n\nHace unos días, usted mencionó que quería hacer un deseo bajo la lluvia de estrellas, así que organicé este viaje especialmente. Gracias por aceptar mi invitación, esperaré su llegada puntualmente en la playa según lo acordado. \nPor favor, esté tranquilo, este es un viaje corto, y ya he revisado completamente las aguas cercanas, garantizando que lo llevaré a navegar de manera segura hasta el lugar donde caerán las estrellas, y lo ayudaré a obtener meteoritos. \nDe esta manera, podrá tocar las estrellas y hacer su deseo, y a esta corta distancia, las estrellas seguramente escucharán su deseo y lo cumplirán. Ser la persona que lo guíe a hacer su deseo será una de las cosas más especiales que he hecho, me siento muy honrado. \nUna vez más, gracias, es usted quien me ha permitido encontrar una nueva \"misión de piloto\" en este día tan especial. Por favor, asegúrese de llegar a tiempo, estaré esperando su llegada. \n\nCorposant"
  },
  Mail_126944_Name = {
    Text = "Un deseo al alcance"
  },
  Mail_126944_Sender = {Text = "Corposant"},
  Mail_129637_Desc = {
    Text = "Estimado/a: \n\nNo recuerdo cuántas veces he cruzado el jardín detrás de la torre del reloj, pero en una de esas ocasiones presté atención al jardín de rosas. \nDesde entonces, he pasado por aquí varias veces, experimentando momentos de inquietud en el estanque negro, momentos de muerte y confrontación, momentos en que el tiempo retrocede y se invierte; todos ellos permanecen ahí, imperturbables y silenciosos, como siempre. \nEsta imagen despertó en mí un recuerdo que no me pertenece, el ramo de rosas que Ramona quería regalarte, y eso me dio un poco de tranquilidad. \nA pesar de la distancia dimensional entre nosotros, siempre he creído que, sin importar las dificultades que enfrentes, tú y esa \"Ramona\" podrán mantener una actitud serena y valiente, encontrando el camino para salir adelante. \nAl fin y al cabo, sin importar cómo cambien las circunstancias del mundo, las rosas siempre florecen. \n\n\"Ramona\""
  },
  Mail_129637_Name = {
    Text = "Jardín de rosas..."
  },
  Mail_129637_Sender = {Text = "\"ramona\""},
  Mail_129806_Desc = {
    Text = "Guardián del secreto: \n\nEn la mansión de Ciudad Marina, las luces ya están encendidas. ¿No sé en qué lugar te encuentras en este momento, ni quién está a tu lado? \nAl inicio del año, el día más importante del antiguo país, una festividad que celebra la reunión y el renacer. He vivido este día muchas veces, pero nunca me he cansado de él. El frío invierno ha pasado, todo crece, la gente espera con ansias, deseando poder dejar atrás todo lo penoso y recibir un nuevo comienzo, como esta tierra. \nLas viejas heridas y deseos no son cosas que se puedan desechar fácilmente. Despedir lo viejo y dar la bienvenida a lo nuevo, ¡qué hermosa bendición! ... Tal vez el dolor volverá a crecer, y los deseos nunca desaparecerán, pero esta noche, al menos esta noche, la gente levantará sus copas para celebrar un nuevo mundo, un nuevo yo. \nPor lo tanto, en el momento de la transición entre el viejo y el nuevo año, la gente recibe el año nuevo con fuegos artificiales. \nEntre todas las cosas interesantes, los fuegos artificiales son mi mayor amor. Todos los miran, observan cómo arden, ascienden y estallan, como si miraran a un dios, contemplando esa breve y incomparable gloria. \n¿Te has dado cuenta? Al mirar los fuegos artificiales, el corazón de cada persona está limpio. Olvidan el odio, olvidan el sufrimiento, olvidan toda la suciedad. Todos los corazones se convierten en un lago tranquilo, en la superficie inmaculada del agua, solo se refleja la hermosa imagen de los fuegos artificiales. \nShh... No preguntes qué hay después de los fuegos artificiales. El renacer puede ser un lujo, pero no dejes que eso menosprecie su esplendor. \nEntre todas las cosas penosas, los fuegos artificiales son lo más puro. Esta noche, deseo regalarte también mi parte. \nLevanta la cabeza, no parpadees. Mira cómo esas brillantes estrellas ascienden, y cuando los fuegos artificiales estallen, recibe un nuevo yo, guardián del secreto. \n\n\"Mil Abanicos\""
  },
  Mail_129806_Name = {
    Text = "fuegos artificiales"
  },
  Mail_129806_Sender = {Text = "Xu"},
  Mail_130223_Desc = {
    Text = "Estimado Guardián:\n La actividad \"renacimiento al revés\" ha Terminado. El \"Polvo de Escama Pálida\", \"Polvo de Escama Roja\" y \"Polvo de Escama Brillante\" restantes del Guardián han sido convertidos a razón de Rosa Dorada × 40 por unidad. Por favor, recuerda revisar tu correo."
  },
  Mail_130223_Name = {
    Text = "Recuperación de Polvo de Escama"
  },
  Mail_130223_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_131005_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad\"Llamada de Merskus\"ha terminado, y ahora procederemos a convertir los restantes\"Caracol marino No. 1\",\"Caracol marino II\",\"Caracol marino III\"a razón de cada uno canjeado por\"Rosa Dorada\"× 40. Por favor, recuerde recogerlo."
  },
  Mail_131005_Name = {
    Text = "Recuperación de caracoles marinos"
  },
  Mail_131005_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_131093_Desc = {
    Text = "Estimado Guardián:\nLa actividad\"Fiesta Ardiente·clon\"ha terminado, y ahora procederemos a convertir los restantes\"Os Tibia original\",\"Amónito de hojas redondas\"y\"Ruinas Espirales\"a razón de cada uno canjeado por\"Rosa Dorada\"× 40, por favor, recuerde verificar."
  },
  Mail_131093_Name = {
    Text = "Reciclaje de Moneda del Banquete Ardiente"
  },
  Mail_131093_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_131767_Desc = {
    Text = "¡Oh @2! ¡@3 es @2 el supremo @3 caos @4 y destrucción! ¡Clama @4...!\n\n ¡Ay, ay, ay! ¡Mira lo que has hecho! ¡Has tocado el tabú del dios supremo! Ahora está bien, Su susurro ya resuena en el mundo donde te encuentras, la calamidad negra comenzará a propagarse desde tu comunicador, devorando todo a tu alrededor...\n Pobrecito, tu imprudencia realmente me complica. Pero no te desesperes demasiado, afortunadamente, te encontraste conmigo: ¡la gran hada del culto, el Elegido del dios, el Executor del dios supremo, el heredero legítimo del gran culto, el salvador del sufrimiento, el amigo cercano del rey dios! Soy la voluntad del dios de la bondad y el amor, no puedo soportar el sufrimiento en este mundo, usaré mi suprema fuerza para salvar a cada pequeño travieso. \n Oh, esta hada ve tu mirada burlona. No te preocupes, el dios de la bondad ama a la humanidad y nunca se molesta por la necedad de la gente. La desconfianza hacia el Salvador es un camino que cada creyente debe recorrer. Estos regalos de bienvenida son la gracia del Executor de dios hacia ti. \n Ahora, el camino de la luz ya ha sido señalado para ti: lleva tu sinceridad a la gran catedral en la ciudad de @3, y ofrece tu lealtad al dios de la bondad, obtendrás el poder que tanto anhelas y te liberarás de esta maldición de pesadilla. Por supuesto, también necesitarás ofrecer tu riqueza. No te malinterpretes, el dios de la bondad nunca se preocupa por las recompensas mundanas, pero los creyentes de Dios también necesitan gastar dinero para hacer las cosas. No escatimes en estas cosas mundanas, querido creyente, lo que vale es lo que se paga. \n Clama el nombre del dios de la bondad y espera el momento de la llegada del milagro. \n\n La gran hada del culto, el Elegido del dios"
  },
  Mail_131767_Name = {
    Text = "Por favor, no toques este @2"
  },
  Mail_131767_Sender = {Text = "Caraboo"},
  Mail_132339_Desc = {
    Text = "Estimado Guardián: \n La actividad \"Resurrección del Rey de los Dioses·Réplica\" ha terminado, y ahora se convertirán los \"Pensamientos cansados\", \"Pensamientos melancólicos\" y \"Pensamientos alegres\" restantes del Guardián según una proporción de 40 \"Rosa Dorada\" por cada uno. Por favor, recuerde recogerlo."
  },
  Mail_132339_Name = {
    Text = "Recuperación de moneda del Renacer del rey divino"
  },
  Mail_132339_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_132458_Desc = {
    Text = "Estimado Guardián: \n        Gracias por su apoyo y reconocimiento a \"Víspera del olvido\". Para ofrecer a los guardianes del secreto una mejor experiencia de juego en la Universidad de Misag, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su colaboración, hemos preparado \"Núcleo de plata\" × 200 como recompensa, que podrá reclamar al completar la encuesta. La fecha límite para la encuesta es el 17 de agosto a las 9:00, por favor asegúrese de completarla a tiempo. \n        <SurveyLink:\"Haga clic aquí para completar\"> \n        Escucharemos atentamente las sugerencias de cada Guardián, ¡su retroalimentación sin duda hará que la Universidad de Misag sea cada vez mejor! \n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_132458_Name = {
    Text = "Cuestionario de investigación de experiencia de versión V2.5.3"
  },
  Mail_132458_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_132578_Desc = {
    Text = "Estimado/a Guardián:\nEn la temporada \"{s1}\" de \"Hectic Skybound Rail\", has obtenido el título \"{s2}\".\nRecibirás las siguientes recompensas adicionales. No olvides reclamarlas."
  },
  Mail_132578_Name = {
    Text = "Recompensas de temporada de \"Hectic Skybound Rail\""
  },
  Mail_132578_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_132579_Desc = {
    Text = "Estimado/a Guardián:\nEn la temporada \"{s1}\" de \"Fase de Duelo: Pregrupo\", has obtenido el título \"{s2}\".\nRecibirás las siguientes recompensas adicionales. No olvides reclamarlas."
  },
  Mail_132579_Name = {
    Text = "Recompensas de temporada de \"Fase de Duelo: Pregrupo\""
  },
  Mail_132579_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_132580_Desc = {
    Text = "Estimado/a Guardián:\nEn la temporada \"{s1}\" de \"Inmersión fantasmal\", has obtenido el título \"{s2}\".\nRecibirás las siguientes recompensas adicionales. No olvides reclamarlas."
  },
  Mail_132580_Name = {
    Text = "Recompensas de temporada de \"Inmersión fantasmal\""
  },
  Mail_132580_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_132581_Desc = {
    Text = "Estimado/a Guardián:\nEn la temporada \"{s1}\" de \"Fase de Duelo: Modo de selección de rueda\", has obtenido el título \"{s2}\".\nRecibirás las siguientes recompensas adicionales. No olvides reclamarlas."
  },
  Mail_132581_Name = {
    Text = "Recompensas de temporada de \"Fase de Duelo: Modo de selección de rueda\""
  },
  Mail_132581_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_132605_Desc = {
    Text = "¡Pío pío pío, pío pío pío pío pío!\n(Guardián, ¡Feliz Día de los Inocentes!)\n¡Pío pío pío, pío pío!\n(Foto de identificación, ¡recuerdo!)\n\"Huella de nutria húmeda y desordenada\"\n\"Un montón de impresiones borrosas dejadas por fracasos de goteo de lacre\"\n                                                         —una huella de nutria bien marcada"
  },
  Mail_132605_Name = {
    Text = "Un bulto de papel húmedo"
  },
  Mail_132605_Sender = {Text = "¡Pío!"},
  Mail_133276_Desc = {
    Text = "Estimado/a Guardián:\nEl evento \"La Gran Conquista: Actividad Despertar Clon\" ha finalizado. Los \"Delicioso asado de León\" restantes se convertirán a una tasa de 40 \"Rosa Dorada\" por unidad. No olvides revisar tus recompensas."
  },
  Mail_133276_Name = {
    Text = "Recuperación de moneda de la barbacoa Leó deliciosa"
  },
  Mail_133276_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_133703_Desc = {
    Text = "Estimado Guardián:\nLa versión {s1} ha Terminado. El \"Núcleo Etéreo\" Restante de los Guardianes ha sido convertido automáticamente a razón de 1 \"Núcleo Etéreo\" por 1 \"Núcleo Puro\". En esta ocasión se convirtieron \"Núcleo Puro\" × {s2} en total. Por favor, recuerda revisarlo."
  },
  Mail_133703_Name = {
    Text = "Aviso de conversión de \"Núcleo de Vacío\""
  },
  Mail_133703_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_133704_Desc = {
    Text = "Estimado Guardián:\nLa versión {s1} está a punto de finalizar. Se solicita a todos los Guardianes que utilicen el \"Núcleo Etéreo\" Restante a tiempo. Una vez finalizado el Tema del semestre de este período, el \"Núcleo Etéreo\" Restante de los Guardianes será convertido a razón de 1 \"Núcleo Etéreo\" por 1 \"Núcleo Puro\"."
  },
  Mail_133704_Name = {
    Text = "Aviso de expiración de \"Núcleo de Vacío\""
  },
  Mail_133704_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_134024_Desc = {
    Text = "Estimado/a Guardián:\nEl \"Entrenamiento diario\" ha sido eliminado. Las \"Credencial de agente\" restantes se convertirán a una tasa de \"Rosa Dorada\" × 10000 por credencial. No olvides revisar tus recompensas."
  },
  Mail_134024_Name = {
    Text = "Reciclaje de Credencial de agente"
  },
  Mail_134024_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_134067_Desc = {
    Text = "Guardián,\n\nHay algo especial que me gustaría hablar contigo hoy.\nQuiero simplemente pasear por la ciudad, mirando tranquilamente todo tipo de cosas interesantes, yendo a donde me apetezca... pasar un día normal y corriente.\n\nAsí que fui a preguntar a la Oficina de Asuntos Académicos. Me dijeron que, por razones de seguridad, solo puedo salir del campus si tú me acompañas.\nTambién me dijeron que no asustara a nadie y que no me metiera en la boca todo lo que vea mientras esté fuera. Qué groseros.\nBueno, así son las cosas. Entonces, ¿podríamos salir a pasear juntos? Todos nosotros, todos.\n\n...Por alguna razón, se me ocurrió que las semillas de diente de león algún día cabalgarán sobre el viento y emprenderán un viaje hacia donde el destino las lleve.\nQuizá sea mañana, o quizá no sea hasta dentro de mucho, mucho tiempo.\nPensándolo bien, hacer más cosas juntos con todos mientras aún pueda no suena tan mal.\n\nEn fin, estaré esperando frente al dormitorio. ¡Por favor!\n\nSaya"
  },
  Mail_134067_Name = {
    Text = "Un paseo por la ciudad..."
  },
  Mail_134067_Sender = {Text = "Saya"},
  Mail_134068_Desc = {
    Text = "Guardián de secretos:\n\nCreo que hoy es un día especial. Pero los contornos de mis recuerdos siguen siendo tan borrosos.\nSolo el nombre \"Saya\" me mantiene apenas conectada a este lugar.\n\nEsa sensación no es soledad, ni tristeza, no es una emoción tan vívida.\nSi tuviera que darle un nombre a este sentimiento... probablemente sería \"vacío\".\nDonde no hay nada, un tiempo infinitamente cristalino, transparente y sereno.\n\nSi algún día, las semillas de diente de león llevadas por el viento\ncayeran blancas y silenciosas en cada rincón de este mundo...\nEntonces, quizás por fin podría sentir que este mundo es \"especial\".\n\nEntonces, la niebla gris que envuelve Londinium, el arrebol rojo ardiente del atardecer, y ese cielo que siempre contemplabas desde la plaza de la escuela, todo quedaría cubierto por los dientes de león, transformándose en un color blanco puro. Transformándose en el color que me pertenece.\n\nAsí que... si quisieras darme algo,\nno tiene que ser un regalo, solo un \"recuerdo\" bastará.\n\nYo, en este mundo blanco puro donde florecen los dientes de león,\nsimplemente espero en silencio la llegada de ese momento.\n\nCuando algún día vuelvas a contemplar el cielo en la Plaza Mesagoza,\npor favor, superpón ligeramente aquella pelusa blanca\nque cruza el borde de tu visión con la imagen de quien una vez conversó contigo.\n\nSaya"
  },
  Mail_134068_Name = {
    Text = "La promesa del diente de león..."
  },
  Mail_134068_Sender = {Text = "Saya"},
  Mail_139809_Desc = {
    Text = "Estimado Guardián:\n        Gracias por tu apoyo y reconocimiento de [Víspera del olvido]. Con el fin de brindar a los Guardianes una mejor experiencia de juego en la Universidad de Misag, te invitamos sinceramente a completar el siguiente cuestionario de experiencia. Como muestra de agradecimiento por tu colaboración, hemos preparado Núcleo de plata × 200 como recompensa, que podrás reclamar al completar el cuestionario. El plazo de la encuesta es el 16 de mayo a las 9:00. Por favor, asegúrate de completarlo a tiempo.\n        <SurveyLink:[Haz clic aquí para completarlo]>\n        Consideraremos cuidadosamente las sugerencias de cada Guardián, ¡y tus comentarios seguramente ayudarán a que la Universidad de Misag sea cada vez mejor!\n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_139809_Name = {
    Text = "Cuestionario de experiencia de versión V2.5.0"
  },
  Mail_139809_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_139927_Desc = {
    Text = "Estimado Guardián:\nEl evento \"Sinfonía Inmaterial·clon\" ha Terminado. Tus \"Canto heroico\" restantes se han convertido a una tasa de 40 × Rosa Dorada cada uno. Por favor, recógelos."
  },
  Mail_139927_Name = {
    Text = "Melodía aguda recuperada"
  },
  Mail_139927_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_140084_Desc = {
    Text = "Estimado Guardián:\n\"Mil Luces Descienden·clon\" ha Terminado. Los Sello de la Riqueza, Sello de Sangre y Sello de Guerra Restantes del Guardián serán convertidos a razón de Rosa Dorada × 40 por unidad. Por favor, recuerda revisar tu correo."
  },
  Mail_140084_Name = {
    Text = "Recuperación de balas"
  },
  Mail_140084_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_140478_Desc = {
    Text = "Estimado/a Guardián del Secreto:\n El evento \"Fuente de Afecto\" ha finalizado. Le enviamos las recompensas del evento que aún no ha reclamado. Por favor, revise su correo."
  },
  Mail_140478_Name = {
    Text = "Reenvío de recompensa del Torrente de Enamoramiento"
  },
  Mail_140478_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_140690_Desc = {
    Text = "Estimado guardián:\nLa actividad \"Esperando del Deshielo·clon\" ha finalizado, y ahora procederemos a recuperar la moneda de evento restante \"Brote helado\", \"Brote de flor plateada con escarcha\" y \"Brote de sol\" a razón de cada una canjeada por \"Rosa Dorada*40\", por favor, recuerde verificar."
  },
  Mail_140690_Name = {
    Text = "Recuperación de brotes"
  },
  Mail_140690_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_140751_Desc = {
    Text = "Estimado Guardián:\n\"Antes de que la primavera se marchite·clon\" ha Terminado. Los Poema alegre, poesía melancólica y Poema de Lamento Restantes del Guardián serán convertidos a razón de Rosa Dorada × 40 por unidad. Por favor, revisa tu correo."
  },
  Mail_140751_Name = {
    Text = "Reciclaje de poemas"
  },
  Mail_140751_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_141372_Desc = {
    Text = "Estimado Guardián:\n\"Ebwynnos Evermore\" ha Terminado. Las \"Presa\" Fresca, \"Presa\" Colosal y \"Presa\" Primordial Restantes del Guardián serán convertidas a razón de Rosa Dorada × 40 por unidad. Por favor, recuerda revisar tu correo."
  },
  Mail_141372_Name = {
    Text = "Recuperación de moneda de Ebwynnos Evermore"
  },
  Mail_141372_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_141470_Desc = {
    Text = "Estimado Guardián:\n\"Prisionero Espejado·clon\" ha Terminado. Los Libro de sentido común, Libro de matemáticas y Libro de literatura Restantes del Guardián serán convertidos a razón de Rosa Dorada × 40 por unidad. Por favor, recuerda revisar tu correo."
  },
  Mail_141470_Name = {
    Text = "Recuperación de moneda del evento Prisionero espejo"
  },
  Mail_141470_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_141507_Desc = {
    Text = "Guardián: \n\nEl día de tu nacimiento, ¿quizás sea un día importante para ti? \nPara mí, el peso de cada día en la red del destino es igual. Son otras historias las que otorgan un significado especial a este día. \nnací en este día, comprendí la profecía en este día, recibí la rueda del destino tejida en este día, vi esos complejos hilos del destino y la pesadilla al final de esos hilos. \nPara el tejedor del destino, este día es ordinario. Para los actores en el escenario, este día merece ser celebrado. Y entre todas las identidades, la que más me alegra es la de ser actriz. \nGuardián, hoy, las luces del Teatro del destino ya se han apagado, solo un escenario brilla intensamente. Mencionaste que querías ver más sobre los destinos que he vivido. Y ahora, lo que este escenario va a presentar es una historia sobre mí misma. \nNo sé qué segmento se va a representar. Llevaré mis recuerdos al escenario, ella elegirá en esos momentos intensos, una parte que más esperas ver, para presentarla en el escenario de esta noche. \nEsa historia quizás me cause dolor, quizás me incomode, pero eso no importa, ¿verdad? Creo que, de vez en cuando, dejar que la rueda teja por sí sola y ser un espectador puro es algo placentero. \nEl único boleto de entrada para esta actuación ya está en tus manos. Ven con esta carta, Guardián. Esta noche, una historia que ya nadie más conoce, está esperando tu llegada. \n\nArachne"
  },
  Mail_141507_Name = {
    Text = "Historia Oculta"
  },
  Mail_141507_Sender = {Text = "Arachne"},
  Mail_141833_Desc = {
    Text = "Estimado Gardian del secreto:\n\"Luna Nueva y Nieve Profunda\" ha terminado. Las \"Manzanas Carmesí\", \"Manzanas Doradas\" y \"Manzanas de Caramelo\" restantes del Gardian del secreto serán convertidas a razón de Rosa Dorada × 40 por unidad. Por favor, recuerda revisar tu correo."
  },
  Mail_141833_Name = {
    Text = "Recuperación de Manzanas"
  },
  Mail_141833_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_141957_Desc = {
    Text = "Estimado Guardián:\n        Gracias por tu apoyo y reconocimiento a \"Antes del Alba del Olvido\". Para ofrecerte una mejor experiencia de juego en la Universidad de Misag, te invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por tu colaboración, hemos preparado \"Núcleo de plata\" × 200 como recompensa, que podrás Reclamar al completar la encuesta. El plazo de la encuesta finaliza el 15 de febrero a las 9:00. Por favor, recuerda completarla a tiempo.\n        <SurveyLink:[Haz clic aquí para completarla]>\n        Escucharemos atentamente las sugerencias de cada Guardián. ¡Tu opinión hará que la Universidad de Misag sea cada vez mejor!\n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_141957_Name = {
    Text = "Encuesta de experiencia de versión V2.7.2"
  },
  Mail_141957_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_141958_Desc = {
    Text = "Estimado Guardián:\n        Gracias por tu apoyo y reconocimiento a \"Antes del Alba del Olvido\". Para ofrecerte una mejor experiencia de juego en la Universidad de Misag, te invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por tu colaboración, hemos preparado \"Núcleo de plata\" × 200 como recompensa, que podrás Reclamar al completar la encuesta. El plazo de la encuesta finaliza el 21 de diciembre a las 9:00. Por favor, recuerda completarla a tiempo.\n        <SurveyLink:[Haz clic aquí para completarla]>\n        Escucharemos atentamente las sugerencias de cada Guardián. ¡Tu opinión hará que la Universidad de Misag sea cada vez mejor!\n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_141958_Name = {
    Text = "Encuesta de experiencia de versión V2.7.0"
  },
  Mail_141958_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_141959_Desc = {
    Text = "Estimado Guardián:\n        Gracias por tu apoyo y reconocimiento a \"Antes del Alba del Olvido\". Para ofrecerte una mejor experiencia de juego en la Universidad de Misag, te invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por tu colaboración, hemos preparado \"Núcleo de plata\" × 200 como recompensa, que podrás Reclamar al completar la encuesta. El plazo de la encuesta finaliza el 18 de enero a las 9:00. Por favor, recuerda completarla a tiempo.\n        <SurveyLink:[Haz clic aquí para completarla]>\n        Escucharemos atentamente las sugerencias de cada Guardián. ¡Tu opinión hará que la Universidad de Misag sea cada vez mejor!\n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_141959_Name = {
    Text = "Encuesta de experiencia de versión V2.7.1"
  },
  Mail_141959_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_141960_Desc = {
    Text = "Estimado Guardián:\n        Gracias por tu apoyo y reconocimiento a \"Antes del Alba del Olvido\". Para ofrecerte una mejor experiencia de juego en la Universidad de Misag, te invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por tu colaboración, hemos preparado \"Núcleo de plata\" × 200 como recompensa, que podrás Reclamar al completar la encuesta. El plazo de la encuesta finaliza el 15 de marzo a las 9:00. Por favor, recuerda completarla a tiempo.\n        <SurveyLink:[Haz clic aquí para completarla]>\n        Escucharemos atentamente las sugerencias de cada Guardián. ¡Tu opinión hará que la Universidad de Misag sea cada vez mejor!\n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_141960_Name = {
    Text = "Encuesta de experiencia de versión V2.7.3"
  },
  Mail_141960_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_141961_Desc = {
    Text = "Estimado Guardián:\n        Gracias por tu apoyo y reconocimiento a \"Antes del Alba del Olvido\". Para ofrecerte una mejor experiencia de juego en la Universidad de Misag, te invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por tu colaboración, hemos preparado \"Núcleo de plata\" × 200 como recompensa, que podrás Reclamar al completar la encuesta. El plazo de la encuesta finaliza el 12 de abril a las 9:00. Por favor, recuerda completarla a tiempo.\n        <SurveyLink:[Haz clic aquí para completarla]>\n        Escucharemos atentamente las sugerencias de cada Guardián. ¡Tu opinión hará que la Universidad de Misag sea cada vez mejor!\n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_141961_Name = {
    Text = "Encuesta de experiencia de versión V2.7.4"
  },
  Mail_141961_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_141962_Desc = {
    Text = "Estimado Guardián:\n        Gracias por tu apoyo y reconocimiento a \"Antes del Alba del Olvido\". Para ofrecerte una mejor experiencia de juego en la Universidad de Misag, te invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por tu colaboración, hemos preparado \"Núcleo de plata\" × 200 como recompensa, que podrás Reclamar al completar la encuesta. El plazo de la encuesta finaliza el 10 de mayo a las 9:00. Por favor, recuerda completarla a tiempo.\n        <SurveyLink:[Haz clic aquí para completarla]>\n        Escucharemos atentamente las sugerencias de cada Guardián. ¡Tu opinión hará que la Universidad de Misag sea cada vez mejor!\n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_141962_Name = {
    Text = "Encuesta de experiencia de versión V2.7.5"
  },
  Mail_141962_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_142101_Desc = {
    Text = "Cuánto tiempo, %player%:\n\nCuando recibas esta carta, debería estar sobrevolando Yagruo. Cada año, en este mes, mi viaje de cacería siempre se extiende un poco más lejos.\nNo hay nada más apropiado como banda sonora de cumpleaños que los gritos y aullidos de los enemigos. Además, he preparado suficientes jaulas: siempre que haya algún necio que se atreva a venerar a esos falsos dioses que no traen más que sufrimiento, sin ninguna Redención, sin importar cuán lejos estén, haré que se den cuenta de su error.\nDe vez en cuando, cuando la pesadilla atraviesa las nubes y se puede ver la Luna, ciertos pensamientos absurdos cruzan mi mente fugazmente.\nComo por ejemplo, cuándo llegará el momento en que todo esto se detenga de repente e irremediablemente, igual que la vida se derrumbó en su día sin previo aviso.\nPero enseguida me río de mí mismo: el día que entré en este camino, me embarqué en una travesía sin retorno. Estoy seguro de que entiendes lo que quiero decir, pequeño. En este mundo, no hay nadie cuya situación se parezca más a la tuya y a la mía.\nAmbos elegimos algunas elecciones que no eran elecciones, y la buena noticia es que ambos disfrutamos de nuestras elecciones.\nEn el nuevo año, Solo tienes que hacer sonar el silbato de caza que te regalé y seguiré apareciendo a tu lado en cualquier momento.\nPor supuesto, salvo imprevistos, déjame primero disfrutar tranquilamente de este viaje. El mes que viene, te traeré souvenirs y algunas Noticias nuevas.\nQue todo te vaya bien, que seas feliz.\n\nTu querido \"tío\""
  },
  Mail_142101_Name = {Text = "Noticias"},
  Mail_142101_Sender = {
    Text = "Tu querido \"tío\""
  },
  Mail_143935_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"Texto temporal\" ha terminado, y ahora convertiremos los \"Texto temporal\", \"Texto temporal\" y \"Texto temporal\" restantes del guardián según la proporción de \"Rosa Dorada\"× 40 por cada uno. Por favor, recuerde recogerlo."
  },
  Mail_143935_Name = {
    Text = "Recogida de texto temporal"
  },
  Mail_143935_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_145435_Desc = {
    Text = "Estimado Guardián:\nEl evento \"El Juego del Leviatán\" ha finalizado. Los \"Sacrificio Carmesí\" restantes han sido convertidos a razón de \"Rosa Dorada\" × 40 por unidad. Recuerda revisar tus recompensas."
  },
  Mail_145435_Name = {
    Text = "Conversión de Sacrificio Carmesí"
  },
  Mail_145435_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_145468_Desc = {
    Text = "Estimado Guardián:\nEl evento \"Si todo sigue igual·clon\" ha finalizado. Las \"Concha de especialidad costera\" restantes han sido convertidas a razón de \"Rosa Dorada\" × 40 por unidad. Recuerda revisar tus recompensas."
  },
  Mail_145468_Name = {
    Text = "Recuperación de moneda del evento \"Deliciosa carne asada de Leó\""
  },
  Mail_145468_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_146401_Desc = {
    Text = "Los calendarios son un invento tedioso. Ningún día difiere de otro, incluido el de hoy.\nSegún tu calendario, hoy es el día en que nací. Aunque \"nacer\" no es la palabra adecuada para mí. Soy un fragmento arrancado del caos, una hoja forjada y afilada en innumerables batallas. Ningún vientre me creó; fui moldeado por cada oponente que alguna vez cruzó espadas conmigo. Y tú—\ntú eres el más vital de todos ellos.\nLos de tu especie aprecian días como este. Banquetes, regalos, buenos deseos... no necesito nada de eso.\nSolo necesito una batalla.\nHas hecho cosas notables estos últimos días. Pero sé que lo que has mostrado está lejos de tu límite.\nAl atardecer de hoy, en el campo de entrenamiento. Trae tu arma; estaré esperando. Olvida ganar o perder, vivir o morir. El choque sin reservas de nuestras hojas es el único regalo que deseo.\nMuéstrame de lo que es verdaderamente capaz un fragmento de @4.\nCreo que me sorprenderás, mi \"oponente\"."
  },
  Mail_146401_Name = {
    Text = "Mi Única Expectativa"
  },
  Mail_146401_Sender = {
    Text = "Lotan: Cetarconte"
  },
  Mail_146873_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"Texto temporal\" ha terminado, y ahora convertiremos los \"Texto temporal\", \"Texto temporal\" y \"Texto temporal\" restantes del guardián según la proporción de \"Rosa Dorada\"× 40 por cada uno. Por favor, recuerde recogerlo."
  },
  Mail_146873_Name = {
    Text = "Recogida de texto temporal"
  },
  Mail_146873_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_147081_Desc = {
    Text = "Los calendarios son un invento tedioso. Ningún día difiere de otro, incluido el de hoy.\nSegún tu calendario, hoy es el día en que nací. Aunque \"nacer\" no es la palabra adecuada para mí. Soy un fragmento arrancado del caos, una hoja forjada y afilada en innumerables batallas. Ningún vientre me creó; fui moldeado por cada oponente que alguna vez cruzó espadas conmigo. Y tú—\ntú eres el más vital de todos ellos.\nLos de tu especie aprecian días como este. Banquetes, regalos, buenos deseos... no necesito nada de eso.\nSolo necesito una batalla.\nHas hecho cosas notables estos últimos días. Pero sé que lo que has mostrado está lejos de tu límite.\nAl atardecer de hoy, en el campo de entrenamiento. Trae tu arma; estaré esperando. Olvida ganar o perder, vivir o morir. El choque sin reservas de nuestras hojas es el único regalo que deseo.\nMuéstrame de lo que es verdaderamente capaz un fragmento de @4.\nCreo que me sorprenderás, mi \"oponente\"."
  },
  Mail_147081_Name = {
    Text = "Mi Única Expectativa"
  },
  Mail_147081_Sender = {
    Text = "Lotan: Cetarconte"
  },
  Mail_147535_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"Texto temporal\" ha terminado, y ahora convertiremos los \"Texto temporal\", \"Texto temporal\" y \"Texto temporal\" restantes del guardián según la proporción de \"Rosa Dorada\"× 40 por cada uno. Por favor, recuerde recogerlo."
  },
  Mail_147535_Name = {
    Text = "Recogida de texto temporal"
  },
  Mail_147535_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_147798_Desc = {
    Text = "Estimado Gardian del secreto:\n        En la actualización V2.6.0, corregimos el problema de la recompensa oculta faltante en la Operación de investigación H7-6 del Capítulo Olvidado. Dado que ya habías pasado H7-6 antes de la corrección, te enviaremos directamente la recompensa oculta faltante. Por favor, revisa tu correo."
  },
  Mail_147798_Name = {
    Text = "Reenvío de recompensa oculta de H7-6"
  },
  Mail_147798_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_147875_Desc = {
    Text = "Estimado Gardian del secreto:\n        En la actualización V2.6.0, corregimos el problema de la recompensa oculta faltante en la Operación de investigación H7-9 del Capítulo Olvidado. Dado que ya habías pasado H7-9 antes de la corrección, te enviaremos directamente la recompensa oculta faltante. Por favor, revisa tu correo."
  },
  Mail_147875_Name = {
    Text = "Reenvío de recompensa oculta de H7-9"
  },
  Mail_147875_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_148080_Desc = {
    Text = "Estimado Gardian del secreto:\n        En la actualización V2.6.0, aumentamos las recompensas de las \"Especificaciones de la sala elegante\". Para los Gardianes del secreto que ya habían reclamado todas las recompensas adicionales antes de la actualización, enviaremos las recompensas correspondientes. Por favor, revisa tu correo."
  },
  Mail_148080_Name = {
    Text = "Reenvío de recompensas por Especificaciones de la sala elegante"
  },
  Mail_148080_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_148081_Desc = {
    Text = "Estimado Gardian del secreto:\n        En la actualización V2.6.0, aumentamos las recompensas del \"Nivel de Inmersión profunda\". Para los Gardianes del secreto que ya habían reclamado todas las recompensas adicionales antes de la actualización, enviaremos las recompensas correspondientes. Por favor, revisa tu correo."
  },
  Mail_148081_Name = {
    Text = "Reenvío de recompensas por Nivel de Inmersión profunda"
  },
  Mail_148081_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_148082_Desc = {
    Text = "Estimado Gardian del secreto:\n        En la actualización V2.6.0, aumentamos las recompensas del \"Nivel de Selección de rueda\". Para los Gardianes del secreto que ya habían reclamado todas las recompensas adicionales antes de la actualización, enviaremos las recompensas correspondientes. Por favor, revisa tu correo."
  },
  Mail_148082_Name = {
    Text = "Reenvío de recompensas por Nivel de Selección de rueda"
  },
  Mail_148082_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_148083_Desc = {
    Text = "Estimado Gardian del secreto:\n        En la actualización V2.6.0, aumentamos las recompensas del \"Nivel de Pregrupo\". Para los Gardianes del secreto que ya habían reclamado todas las recompensas adicionales antes de la actualización, enviaremos las recompensas correspondientes. Por favor, revisa tu correo."
  },
  Mail_148083_Name = {
    Text = "Reenvío de recompensas por Nivel de Pregrupo"
  },
  Mail_148083_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_148476_Desc = {
    Text = "Estimado Gardian del secreto:\n        Las recompensas obtenidas mediante compra en \"{s1}\" aún no han sido reclamadas. Se enviarán como adjunto en este correo. Recuerda limpiar tu inventario a tiempo antes de reclamarlas."
  },
  Mail_148476_Name = {
    Text = "Reenvío de recompensa no reclamada de \"{s1}\""
  },
  Mail_148476_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_148477_Desc = {
    Text = "Estimado Gardian del secreto:\n        Las recompensas obtenidas en \"{s1}\" aún no han sido reclamadas. Se enviarán como adjunto en este correo. Recuerda limpiar tu inventario a tiempo antes de reclamarlas."
  },
  Mail_148477_Name = {
    Text = "Reenvío de recompensa no reclamada de \"{s1}\""
  },
  Mail_148477_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_148478_Desc = {
    Text = "Estimado Gardian del secreto:\n        Las recompensas obtenidas en el \"Tema del semestre – Tema avanzado\" de la temporada {s1} aún no han sido reclamadas. Se enviarán como adjunto en este correo. Recuerda limpiar tu inventario a tiempo antes de reclamarlas."
  },
  Mail_148478_Name = {
    Text = "Reenvío de recompensas no reclamadas del Tema avanzado de la temporada {s1}"
  },
  Mail_148478_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_148514_Desc = {
    Text = "Estimado Gardian del secreto:\n        En la actualización de la versión V1.4.3.5, añadimos el nivel \"Nuevo rey\" al \"Mundo de Sueños Extraños: Profanación\". Debido a que algunos Gardianes del secreto no se enteraron de esta actualización a tiempo, creyeron erróneamente que habían completado todos los niveles del \"Mundo de Sueños Extraños: Profanación\".\n        Por ello, en la presente actualización de la versión V2.6.2, hemos compensado el progreso de paso del nivel \"Nuevo rey\" para los Gardianes del secreto que ya habían pasado los niveles posteriores al \"Nuevo rey\" antes de la actualización, y también se han enviado simultáneamente las recompensas de primera vez correspondientes. Por favor, revisa tu correo."
  },
  Mail_148514_Name = {
    Text = "Compensación de progreso de \"Profanación\""
  },
  Mail_148514_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_148515_Desc = {
    Text = "Querido/a Gardian del secreto:\n\n¡Tadá! ¿Sorprendente, verdad? Este es el primer cumpleaños de esta hada en Misaq, así que—\n¡Increíblemente! No hay correos promocionales, Invitación a misa, ni siquiera una Profecía del fin del mundo~\nPero no te decepciones, esta hada por supuesto ha preparado algo más precioso y mejor para los fieles más especiales.\nComo hada madrina Omnisciente y omnipotente, naturalmente puedo anticipar esas dudas y reservas tan comprensibles, aunque eso le cause a esta hada un pequeño dolor de corazón. Sin embargo, para difundir las bendiciones de nuestra congregación, un ligero Sacrificio siempre es inevitable.\nAsí que, pensándolo bien, ¿por qué no intentarlo? Total, no tienes nada que perder, y ¿qué pasa si es verdad? ¿No es así?\nEsta es una oportunidad que solo ocurre una vez al año y que no deberías perderte bajo ninguna circunstancia~\nSin necesidad de ningún Sacrificio, ni promesas ni intercambios, simplemente compartiendo una dulce tarde de té con la hada madrina, podrás descubrir cuánto genuino afecto hacia ti yace enterrado bajo la nieve.\n¿Acaso no es esta una propuesta tentadora?\nNota: Por favor, asegúrate de traer suficientes Leonian Florin para pagar la cuenta, al menos 10, 100, 1000, cuantos más, mejor.\n\nEsperándote en ese lugar que ambos conocemos,\nCaraboo"
  },
  Mail_148515_Name = {
    Text = "☆☆☆Correo de Super Beneficios☆☆☆"
  },
  Mail_148515_Sender = {Text = "Caraboo"},
  Mail_149949_Desc = {
    Text = "Esta carta ha circulado diez mil veces por los reinos de los vivos y los muertos. ¡NO LA BORRES!\n\nEn la decimoquinta noche del séptimo mes, la puerta de los fantasmas se abre de par en par, el viento frío se levanta y las almas errantes regresan a casa.\n¡Soy ███ de la Ciudad de Hu, en el antiguo Imperio de Panlong—Yizhi Yè, artesano del Zhizha, doblador de efigies de papel y ofrendas para los muertos, a su servicio!\n\nPor decreto del Festival Fantasma de Zhongyuan, portando el escrito-talismán invocador de almas, esta noche te impongo esta maldición. Quien pose sus ojos en estas palabras: tu alma será inscrita en el registro, tu nombre ya está escrito con tinta en el libro mayor.\n\nY si no se transmite a cincuenta almas del mundo de los vivos antes de la Hora de Zi, cuando la noche se convierte en medianoche, con toda certeza—\n\n...tus documentos se corromperán un instante antes de guardarse...\n...tu té de boba siempre vendrá con tres perlas de menos...\n...tu Comunicador de Núcleo de plata se quedará al 1% de batería por toda la eternidad—lo cargues como lo cargues, nunca se llenará...\n\nSé bueno y haz lo que se te dice: la maldición se desatará sola, el talismán se quemará hasta convertirse en cenizas, ningún espíritu vengativo seguirá tus pasos, y la lámpara de tu vida seguirá ardiendo sin cesar.\n\n¡¡REENVÍALO!! ¡¡AHORA MISMO!!"
  },
  Mail_149949_Name = {
    Text = "BÓRRALO Y TÚ..."
  },
  Mail_149949_Sender = {Text = "Yizhi Yè"},
  Mail_149985_Desc = {
    Text = "Mi señor:\n\nMe disculpo por escribirle de manera tan repentina, espero no causarle incomodidad. Pero hay ciertos pensamientos que solo puedo confiarle a usted.\nAnoche tuve un sueño por primera vez en mucho tiempo. En él, regresé a mi antiguo Nuestro Hogar. Todo era tan familiar: las manos cálidas y generosas de mi padre, las canciones campestres que tarareaba la sirvienta mientras barría, y aquel poni blanco que era mío... Creía que todo aquello había quedado sepultado en el fango de mis recuerdos, pero volver a verlo en sueños fue igual de reconfortante.\nAl despertar, observé por la ventana cómo unos maestros y alumnos de Misaq pasaban charlando tranquilamente. Era tan sereno y hermoso que, por un instante, sentí que aquella escena no era tan distinta de la del sueño. Además, noté que esa presencia invisible que me acompaña ha estado inusualmente quieta desde esta mañana. ¿Será acaso que el día del cumpleaños trae consigo algo de buena fortuna?\nSi así fuera, quizás hoy pueda permitirme ser un poco ambicioso...\nSé que la gente suele pedir deseos el día de su cumpleaños, como una esperanza para el año entero. Hace tiempo que dejé de atreverme a desear que alguien me felicitara, pero sí hay una oportunidad que me gustaría tener.\nAl igual que usted me ha confiado su confianza, yo tampoco le ocultaré nada, así que permítame revelarle mi deseo:\nSi la próxima vez que usted tenga una misión, le ruego que me nombre como su Escolta y me permita acompañarle.\nPase lo que pase, espero poder estar siempre en primera línea cuando más me necesite, siendo su Blindaje más sólido.\nEste es el deseo que formulo para este año.\n\nOgier"
  },
  Mail_149985_Name = {
    Text = "Deseo de cumpleaños…"
  },
  Mail_149985_Sender = {
    Text = "Origen: Ogier"
  },
  Mail_18019_Desc = {
    Text = "Estimado Guardián:\nEl sistema ha detectado una acción de reembolso en la cuenta actual. El equipo de producción dedujo la moneda virtual correspondiente a tu pedido de reembolso el {s1}. Si el saldo muestra un valor negativo después de la deducción, debe ser restaurado a un monto positivo antes de su uso normal.\nSi tienes alguna pregunta, por favor contacta al servicio al cliente."
  },
  Mail_18019_Name = {
    Text = "Aviso de procesamiento de reembolso"
  },
  Mail_18019_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_18020_Desc = {
    Text = "Hola, Guardián. La recompensa de {s1} te ha sido enviada como un archivo adjunto de correo electrónico debido a que tu inventario está lleno. Por favor, libera tu inventario y reclámala prontamente."
  },
  Mail_18020_Name = {
    Text = "Recompensas no reclamadas reemitidas"
  },
  Mail_18020_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_18021_Desc = {
    Text = "Estimado Guardián:\nEl evento de Registro de temas actual finalizará el {s1} [GMT+8]. Las recompensas relacionadas con este Registro de temas dejarán de estar disponibles una vez que el evento termine. Asegúrate de reclamar tus recompensas antes de que concluya el evento."
  },
  Mail_18021_Name = {
    Text = "Recordatorio de colección de recompensa de entrenamiento"
  },
  Mail_18021_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_18029_Desc = {
    Text = "Hola, Guardián, estas son tus recompensas de clasificación de la Inmersión Fantasma."
  },
  Mail_18029_Name = {
    Text = "Recompensas del ranking de la inmersión fantasmal"
  },
  Mail_18029_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_18031_Desc = {
    Text = "Estimado Guardián:\n\nEl camino por delante es largo y está lleno de espinas. En estos momentos difíciles, debemos unirnos y avanzar como uno solo.\nAdjunto encontrarás el suministro de Menofín especialmente aprobado para hoy. Por favor, acéptalo.\nQue la Llave de Plata ilumine tu camino.\nP.D.: La distribución de este suministro especial ya está completa. Gracias por tu arduo trabajo y dedicación.\n\nDepartamento de Logística de la Facultad Mitag"
  },
  Mail_18031_Name = {
    Text = "Distribución de Suministros Intratecales"
  },
  Mail_18031_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_18034_Desc = {
    Text = "Hola, Guardián, tienes recompensas acumulativas no reclamadas de la Inmersión Fantasma, que se te enviarán por correo electrónico."
  },
  Mail_18034_Name = {
    Text = "Recompensas acumulativas no reclamadas por la Inmersión Fantasmal"
  },
  Mail_18034_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_18035_Desc = {
    Text = "Estimado Guardián:\n\nEl camino por delante es largo y está lleno de espinas. En estos tiempos difíciles, debemos unirnos y avanzar como uno solo.\nAdjunto encontrarás el suministro de Menofín especialmente aprobado para hoy. Por favor, acéptalo.\nQue la Llave de Plata ilumine tu camino.\nP.D.: Tu suministro especialmente aprobado permanecerá válido por {s1} días. Por favor, planifica tu agenda de investigación en consecuencia.\n\nDepartamento de Logística de la Facultad Mitag"
  },
  Mail_18035_Name = {
    Text = "Distribución de Suministros Intratecales"
  },
  Mail_18035_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_20231_Desc = {
    Text = "Querido Guardián, la nueva temporada de Traphase ha comenzado, restableciendo tu rango de {s1} a {s2}. Las recompensas de rango de la nueva temporada han sido reiniciadas. ¡Puedes ganar más honor y recompensas avanzando tu rango! {s3}\n{s4}"
  },
  Mail_20231_Name = {
    Text = "Correo de Temporada Traphase"
  },
  Mail_20231_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_21453_Desc = {
    Text = "Estimado Guardián:\n\nLamento molestarte, pero me pregunto cómo has estado últimamente.\nPido disculpas por interrumpir tu apretada agenda. Jenkin y los demás están preparando una pequeña fiesta de cumpleaños para mí. Después de pensarlo mucho, decidí enviarte esta invitación personalmente.\nLa mayoría de los huérfanos que acoge el taller no pueden recordar sus fechas de nacimiento, así que la señorita Sarah establece la fecha de nuestra llegada al orfanato como nuestros cumpleaños. Sin embargo, yo soy diferente. La señorita Sarah me dijo que fui dejado en la puerta de la casa de caridad en una fría y amarga noche de invierno. Quería que mi vida estuviera llena de calidez, así que eligió un día cálido como mi cumpleaños. Este es un día que me pertenece, uno que está lleno de cuidados y amor. Es un día importante para mí, y espero que tú, Guardián, puedas acompañarme. Es mi Pequeño Deseo. Por supuesto, está bien si no se puede cumplir, ya que tú, Guardián, tienes muchos asuntos que atender, y Aigis entiende esto.\nSi esta invitación te ha causado alguna inconveniencia, por favor házmelo saber y acepta mis sinceras disculpas. Sin embargo, si por casualidad puedes encontrar tiempo, eres muy bienvenido a unirte a sus travesuras—podría ser muy divertido, ya que está preparado por Jenkin.\n\nAigis"
  },
  Mail_21453_Name = {
    Text = "Lo siento por molestarte en medio de tu apretada agenda..."
  },
  Mail_21453_Sender = {Text = "Aigis"},
  Mail_21454_Desc = {
    Text = "Hey:\nSiempre me he preguntado qué es tan especial en celebrar el cumpleaños de una persona. ¿Por qué la gente hace de esto un gran evento?\nEl año pasado en este día, un estudiante vino a preguntarme por mi fecha de nacimiento. Era ridículo—cuando nací, no había concepto de tiempo en este planeta, y mucho menos de cumpleaños. Pero ella seguía insistiendo hasta que no tuve más remedio que decirle \"es cuando el día y la noche son iguales.\" Todavía no sé cómo interpretó eso.\nEscribo esta carta para recordarte que recojas las flores en mi puerta después de la medianoche de esta noche; ¡son abrumadoras!\n\nLotan"
  },
  Mail_21454_Name = {
    Text = "Esas flores..."
  },
  Mail_21454_Sender = {Text = "Lotan"},
  Mail_21455_Desc = {
    Text = "Erica trajo hoy una gran bolsa de café como regalo de cumpleaños, diciendo que es tu suministro anual. <Del:¿Pero estabas dispuesto a hacer esto? Si no,>\n Si esto es una broma de la Muñeca o de alguien más, aunque me costaría, aún puedo devolverlo... Después de todo, ¡es café! No puedo funcionar sin unas cuantas tazas. ¿Un año entero sin él? Probablemente dormirías como Tulu. No es que sea malo, es solo que las cosas oscuras aparecen por la noche... De todos modos, si necesitas que te lo devuelva, siéntete libre de llevártelo en cualquier momento. Pero si lo dejas aquí, <Del:lo haré> estaría muy contento. Finalmente puedo llevar a cabo el experimento que he querido hacer: extraer y concentrar cafeína en un agente que puede ser absorbido a través de la piel, permitiéndome permanecer despierto siempre, siempre...\n\n\nEsperando este experimento, Bígaro"
  },
  Mail_21455_Name = {Text = "Café..."},
  Mail_21455_Sender = {Text = "Winkle"},
  Mail_21456_Desc = {
    Text = "¿Cumpleaños?\nSi tengo que decirlo, mi cumpleaños no es un buen día. Cientos, incluso miles de vidas inocentes mueren en este día, solo para que \"naciera\" y luego siga matando más.\nAsí que realmente no hay nada que celebrar. Pero entiendo que ustedes los humanos son muy particulares en cuanto a \"rituales\", y convenientemente, tengo algo de dinero a mano—puedes estar seguro de que es mi dinero ganado con esfuerzo del Club de Truchas, no ingresos ilegales.\nToma este dinero y cómprate un regalo, como si estuvieras celebrando mi cumpleaños.\n\nUvhash"
  },
  Mail_21456_Name = {
    Text = "Cumpleaños..."
  },
  Mail_21456_Sender = {Text = "Uvhash"},
  Mail_21457_Desc = {
    Text = "Guardián: \n\n ¿Hay alguna costumbre de celebrar cumpleaños en el dominio de Mitag? \n En mis recuerdos de mi tierra natal... se llevaban a cabo grandes ceremonias cada año para celebrar el cumpleaños del rey. \n Con el tiempo, el significado especial de \"cumpleaños\" se otorgó a todos. \n En tiempos lejanos, en este día, colegas y amigos viajaban grandes distancias para estar a mi lado. \n Esa sensación de estar rodeado de seres queridos... esa calidez similar a ser abrazado por el sol... quizás por eso no puedo dejar el pasado. \n Ah... estoy divagando. ¿He perturbado tu trabajo? \n He preparado un poco de té y bocadillos que solía disfrutar, y me gustaría compartirlos contigo. \n Si estás dispuesto, por favor ven a buscarme después de la cena. \n\nFaros"
  },
  Mail_21457_Name = {
    Text = "Luz Inmortal..."
  },
  Mail_21457_Sender = {Text = "Faros"},
  Mail_21458_Desc = {
    Text = "Hoy es, de hecho, un día memorable: el gran Goliat Lord, Rey de los Gigantes, ha llegado; el océano tembló, y las estrellas se apagaron.\nHe oído que el derroche no está permitido en el campus, así que reduzcamos mi banquete de cumpleaños a una décima parte de lo habitual—diez cerdos asados, cien pulpos a la parrilla, y una banda tocando canciones folclóricas de Goliat. Oh, y organiza una docena de bailarines...\n¿Qué? ¿Nada de esto está permitido?\nEntonces solo los bailarines... No una docena, cuatro o cinco serán suficientes.\n¿Qué? ¿Eso tampoco está permitido?!\nTales estándares mezquinos son indignos de mi estatus. Por la presente anuncio: ¡el banquete queda cancelado!\n\nGoliat"
  },
  Mail_21458_Name = {
    Text = "Planes de cena..."
  },
  Mail_21458_Sender = {Text = "Goliath"},
  Mail_21459_Desc = {
    Text = "Guardián del secreto——\n\nHoy, mientras hacía entrenamiento de memoria con la señora Sylvia, ella me preguntó sobre mi cumpleaños. Tú también lo sabes, acabo de soltar la llave inglesa y puedo olvidarla de inmediato, ¡cómo podría recordar mi cumpleaños! Lo que es peor, ¡es algo que solo yo sé, yo! ¡Así que este cumpleaños no cuenta!\n\nSin embargo, el sacerdote Salvador dijo que la fecha específica no es lo importante, lo importante es qué celebramos cada día, así que he decidido que ¡hoy es mi cumpleaños! Ya he acordado con alguien (no recuerdo quién, no serás tú, ¿verdad, Guardián del secreto?) hacer una fiesta en la puerta del comedor, ¡tienes que venir!\n\n\n\nDefinitivamente recordaré esta fecha de cumpleaños, Nautila.\n\n\n\nUna nota enviada con la carta:\n\nEsa niña terminó de escribir la carta y se fue apresuradamente, olvidando la carta y algunos regalos que decía que eran para ti en la mesa.\nHe adjuntado todo en el sobre, espero verte esta noche en la fiesta. No te preocupes, la recordaré que debe asistir esta noche.\n\n——Sylvia"
  },
  Mail_21459_Name = {
    Text = "¡El cumpleaños que he decidido!"
  },
  Mail_21459_Sender = {Text = "Nautila"},
  Mail_21460_Desc = {
    Text = "Pequeño/a, \n\nNo hay estrellas ni lunas en el Mar de Esencia Primordial, ni tampoco estaciones. Por lo tanto, mi cumpleaños debería registrarse como [Unknown].\nSin embargo, hoy es un día importante, después de todo, esta apariencia fue heredada de una humana que tenía un [Deseo]. A ella le encantaban las reuniones animadas, así que abrió esta pequeña tienda, pero debido a sus investigaciones, su cumpleaños a menudo lo compartía solo conmigo. Para cumplir su último deseo, la Boutique del Lamento celebrará una cena a la luz de las velas hoy, invitando sinceramente a todos los clientes fieles a asistir.\nPor supuesto, la Boutique del Lamento también ofrecerá un pequeño descuento para todos los visitantes, así que no te lo pierdas, Pequeño/a.\n\nDaffodil"
  },
  Mail_21460_Name = {
    Text = "Deseos Terrenales..."
  },
  Mail_21460_Sender = {Text = "Daffodil"},
  Mail_21461_Desc = {
    Text = "Cuando me llevaron lejos de mi familia, mi madre adoptiva... la esposa del gobernador, rompió la tablilla con mi fecha de nacimiento, destruyendo mi pasado como tilo. Mi verdadero cumpleaños ya no tiene sentido.\nDespués de separarme de Lai, pensé... ¿Qué tal si consideramos la noche en que escapé de la jaula y comencé mi venganza como mi \"cumpleaños\"?\nAunque ya no es necesario celebrar un año más, como un recordatorio del paso del tiempo, parece adecuado"
  },
  Mail_21461_Name = {
    Text = "El Día del Nacimiento"
  },
  Mail_21461_Sender = {Text = "Helot"},
  Mail_21462_Desc = {
    Text = "Prueba, prueba.\nQuerido Guardián, hola. Si has recibido esta carta, significa que tu opinión es crucial para Erica, y has sido seleccionado para participar en el programa anual de pruebas y mantenimiento del módulo de lenguaje del Autómata Erica. Esta evaluación se realiza en forma de preguntas de respuesta corta, requiriendo que brindes retroalimentación sobre la funcionalidad del recién instalado módulo de lenguaje EA-L-1033 para el Autómata Erica. No tomará mucho de tu tiempo, así que por favor no te pongas nervioso ni ansioso.\nPregunta de respuesta corta:\n¿Entendiste el contenido de esta carta?\n\nPor favor escribe tu respuesta directamente debajo de la pregunta de respuesta corta y sella la carta de nuevo en el sobre.\nGracias por tu participación.\n\nErica"
  },
  Mail_21462_Name = {
    Text = "Probando, probando..."
  },
  Mail_21462_Sender = {Text = "Erica"},
  Mail_21463_Desc = {
    Text = "Guardián: \n\n Eres uno de los pocos individuos lúcidos en esta escuela. Tu mirada puede penetrar este cuerpo defectuoso y ver el verdadero yo. \n Alguien como tú debería poder explicar claramente a esos niños: No soy una sirena; este cuerpo cruzará los mares y escalará las montañas, logrando una forma perfecta. \n ...No importa, no te molestaré. Pero al menos hoy, no dejes que jueguen con mi cola. \n Hoy es especial. Si tienes tiempo, me gustaría contarte algo en persona. \n\nCaecus"
  },
  Mail_21463_Name = {
    Text = "Cuerpo Perfecto..."
  },
  Mail_21463_Sender = {Text = "Caecus"},
  Mail_21464_Desc = {
    Text = "Keeper:\n\nMi cumpleaños en el sentido terrenal es el día en que mi padre me adoptó.\nEn el pasado, siempre daba gran importancia a este día, organizando grandes bailes cada año—bailar con un corsé era más agotador que blandiendo una espada tres mil veces.\nPero era su manera de expresar amor como padre, y no quería decepcionarlo.\nSin embargo, este año, finalmente aceptó dejarme planear mi propio cumpleaños. Quizás, a sus ojos, ya no soy un niño que necesita supervisión constante.\nPor cierto, ¿puedes unirte a mí en la cima de la torre del reloj? Podemos charlar y disfrutar de la brisa.\nHe oído que esta noche habrá luna llena.\n\nRamona"
  },
  Mail_21464_Name = {
    Text = "Luna Llena..."
  },
  Mail_21464_Sender = {Text = "Ramona"},
  Mail_21465_Desc = {
    Text = "Querido, más amado Maestro:\n¡Sí, hoy es el cumpleaños de Karen@1 (la edad de una dama debe permanecer en secreto)! \nPara esta ocasión especial, Karen ha preparado una grandiosa fiesta incomparable e invitado a todos los pequeños amigos que pudo. Aunque al final, solo Aurita, Ogier y Lily pudieron prometer asistir...\nPero está bien. ¡Donde hay gente, hay fiestas, y donde hay fiestas, ahí estará Karen! Karen también ha preparado cuidadosamente un \"mejorado\" guiso de rana, babosas negras infusionadas con ajo y sopa de murciélago al curry. ¡El Maestro simplemente debe venir y probarlos!\n\nUna pregunta silenciosa: el Maestro seguramente ha preparado un regalo para Karen, ¿verdad? Recuerde, ¡debe ser brillante!\n\nSu siempre humilde sirvienta,\nKaren"
  },
  Mail_21465_Name = {Text = "Don..."},
  Mail_21465_Sender = {Text = "Karen"},
  Mail_21466_Desc = {
    Text = "Querido <Del:Guardián> West-Whelp:\nEsta es una <Del:invitación invitacón invitació>. Vamos al grano: ¡es para que vengas a comer un pastel gratis y celebrar mi cumpleaños! En realidad también quiero darte las gracias por haberme ayudado a encontrar a mi hermana y haberme traído aquí, dándonos a marrón y a mí un lugar seguro donde quedarnos.\n(Todo esto lo escribió Aigis por mí, es demasiado empalagoso. Entre nosotros no necesitamos estas cosas, ¿verdad, Guardián?)\nEn fin, esta noche en el patio detrás de tu dormitorio, yo, marrón y Aigis hemos preparado algunas cosas ricas para compartir contigo. Claro que, en realidad, la mayoría la hizo Aigis, ¡lo que cocina está delicioso! Las señoras de la cocina siempre la elogian por tener talento. Si no vienes, te arrepentirás seguro.\n\nTus viejos compañeros, Jenkin y marrón"
  },
  Mail_21466_Name = {
    Text = "Queridos habitantes de West..."
  },
  Mail_21466_Sender = {Text = "Jenkin"},
  Mail_21467_Desc = {
    Text = "Guardián del Secreto:\n\nCuando los humanos aún habitaban en el reino de los dioses, ya usábamos la danza para expresar nuestros sentimientos: giros de alegría, pasos de tristeza... Algunos dicen que la historia de la danza es tan antigua como la historia humana, ha sido testigo de nuestros momentos más gloriosos y también de nuestros días más oscuros.\n\nYa te dije que no bailaría más, pero... al fin y al cabo, nací para bailar. Así que, solo por hoy, ¿aceptarías bailar conmigo? ¿Sumergirte junto a mí y sentir el ritmo más profundo del cuerpo?\n\nTe esperaré en el salón de baile.\n\n\n\nLiz"
  },
  Mail_21467_Name = {
    Text = "Invitación a Bailar"
  },
  Mail_21467_Sender = {Text = "Liz"},
  Mail_21468_Desc = {
    Text = "Estimado Guardián del Secreto:\n\nAntes de convertirme en un Despertador, solía celebrar mi cumpleaños con mis camaradas, trayendo bebida desde fuera del campamento y escondiéndonos en la tienda de almacenamiento para festejar con el pan negro de ración, y antes de que los oficiales descubrieran todo, lanzábamos las botellas a los arbustos afuera.\n\nPero Mitag no es un ejército, aquí podemos disfrutar plenamente. ¿Te gustaría acompañarme a compartir una buena botella de vino y celebrar juntos mi cumpleaños?\nSi aceptas, por favor ven a la azotea del dormitorio cuando la luna pase por encima del reloj de la torre esta noche. ¿Has notado antes? Allí se encuentra la mejor vista de toda Mitag.\n\n\n\nElva"
  },
  Mail_21468_Name = {
    Text = "Comparte la fine brew..."
  },
  Mail_21468_Sender = {Text = "Alva"},
  Mail_21469_Desc = {
    Text = "¡Playa! ¡Playa! ¡Playa! ¡Playa! \n¿Eh? ¡Escribir el nombre del destinatario al principio es un lío! ¡El Guardián nunca escribe el destinatario en las notas del frigorífico!\nHoy es el cumpleaños de Aurita... eh... ¿cuántos años tiene otra vez? ¡De todos modos, es el cumpleaños de Aurita!\n¡Estos son los tesoros de Aurita! ¡Todo para ti! ¡Por favor, lleva a Aurita a la playa, por favor, por favor, por favor!\nConsidéralo un regalo de cumpleaños para Aurita, ¿de acuerdo?\n\nAurita"
  },
  Mail_21469_Name = {Text = "¡Playa!"},
  Mail_21469_Sender = {Text = "Aurita"},
  Mail_21470_Desc = {
    Text = "Querido Amigo,\n\nEn el pasado, mi hermana y yo en la estrella estéril nos abrazábamos y obteníamos energía de la misma planta para conmemorar nuestro nacimiento. \nAquellos días fueron amargos, pero ahora traen alegría y calidez. \nHoy se celebra nuevamente el aniversario de nuestro nacimiento. Si es posible, ¿puedo intercambiar una canción por una rama? \nUna dulce rama que represente a mi hermana y a mí, y nuestro futuro contigo...\n\nTintura"
  },
  Mail_21470_Name = {
    Text = "Canción de Cumpleaños"
  },
  Mail_21470_Sender = {Text = "Tinct"},
  Mail_21471_Desc = {
    Text = "Por la gracia del Destino, Guardián de la Universidad de Mitag, maestro sabio y benévolo:\n¡La paz esté contigo!\nHace unos días, noté que un carro entraba en los establos de la escuela, entregando un caballo de sangre caliente. Recordé que durante nuestra última misión de investigación, mencionaste no haber montado nunca a un caballo. Una joven y gentil yegua de sangre caliente es la más adecuada para principiantes.\nMontar un caballo, persiguiendo el amanecer y el atardecer, está entre mis recuerdos más queridos. Si estás dispuesto, me encantaría compartir esta alegría contigo.\n\nOgier"
  },
  Mail_21471_Name = {
    Text = "Caballo de sangre caliente"
  },
  Mail_21471_Sender = {Text = "Ogier"},
  Mail_21472_Desc = {
    Text = "El antiguo calendario difiere mucho del que se usa hoy en día en Londinium.\nNací el quinto día de estrella plena del segundo mes de verano. La decisión de celebrar hoy se basa en los cálculos realizados por el director del laboratorio.\nCuando la antigua nación aún existía, el Viejo gran sacerdote se encargaba de todo. Tras grandes ceremonias, toda la nación celebraba con siete días de fiesta.\nAunque no era mi Deseo, no tenía razón para detener la difusión de la alegría.\nHoy no es un día festivo en Misaq, y como Guardián, no tendrás días libres regulares.\nPero si solicitas un día libre para celebrar mi cumpleaños, dudo que la administración se oponga.\nDisfruta de una tarde tranquila.\n\nTulu"
  },
  Mail_21472_Name = {
    Text = "Cumpleaños..."
  },
  Mail_21472_Sender = {Text = "Tulu"},
  Mail_21473_Desc = {
    Text = "Keeper: \n\n Aurita dice que aquellos con cumpleaños siempre tienen que hacer deseos. \n Y yo soy alguien que nunca hace deseos. \n Porque mis pensamientos siempre se hacen realidad. Esto no es suerte; se siente más como... ¿una guía destinada? \n Justo como el mes pasado cuando salí al mar con Celeste, \"justo así\" encontré un hermoso fósil. \n Los locales lo llaman \"lirio de mar\". Sus brazos se balancean como molinos de viento contra la corriente, disfrutando perezosamente del sol de la tarde de verano. \n Frágil, hermoso. Cuando lo vi, tu imagen vino a mi mente de manera natural. \n Esta vez, aún no hice un deseo— \n Seguro que te encantará, ¿verdad? \n\nSanga"
  },
  Mail_21473_Name = {
    Text = "Lirio del mar..."
  },
  Mail_21473_Sender = {Text = "Sanga"},
  Mail_21475_Desc = {
    Text = "Guardián:\n\nCuando navegué con Elton, él preparaba un banquete en este día todos los años y me pedía que \"pidiera un deseo\".\nAntes de venir aquí, no entendía qué era un \"deseo\". Ahora, no sé qué podría desear...\n¿Quizás encontrar un \"deseo\" puede ser mi \"deseo\"?\n\nCeleste"
  },
  Mail_21475_Name = {Text = "Deseo..."},
  Mail_21475_Sender = {Text = "Celeste"},
  Mail_21476_Desc = {
    Text = "Keeper: \n\n Aurita me dijo que puedes cumplir todos los deseos hechos en los cumpleaños, ¿es eso cierto? \n Seguramente no puede ser verdad, ¿verdad? Cumplir los deseos de todos sería demasiada molestia para ti. \n Sin embargo, si pudiera hacer un deseo... querría que Tinct tuviera un escenario más amplio. \n ¿Sería demasiado difícil de realizar? Hmm... Entonces, ¿qué tal si cambio a \"durante el próximo año, no habrá apio en mi mesa\"? ¿Es eso aceptable? \n\nDesmayo"
  },
  Mail_21476_Name = {Text = "Deseo..."},
  Mail_21476_Sender = {Text = "Faint"},
  Mail_21477_Desc = {
    Text = "Estimado Guardián:\n\nDéjame compartir un secreto contigo: este cumpleaños no es real. En cuanto a mi verdadera fecha de nacimiento... déjala llevarse por el viento.\nDespués de enfermarme, mi hermano siempre hacía que el mayordomo preparara en secreto un pequeño pastel para mí en mi cumpleaños.\nSin canciones de cumpleaños, sin bendiciones—celebrar un cumpleaños se sentía como algo vergonzoso.\nAhora, todo ha cambiado. Puedo caminar bajo la luz del sol, cantar en voz alta e incluso celebrar mi cumpleaños.\nEstos pueden parecer pequeños placeres, pero me llenan de nostalgia.\nGracias, Guardián.\n\n(Por supuesto, si tú y todos pudieran ser un poco más rudos, un poco más agresivos... sería perfecto.)\n\nLeigh"
  },
  Mail_21477_Name = {
    Text = "Un secreto..."
  },
  Mail_21477_Sender = {Text = "Leigh"},
  Mail_21478_Desc = {
    Text = "Mi Pequeño·Prisionero:\n\nHa pasado tanto, tanto, tanto tiempo desde la última vez que empuñé el látigo—\nAtrapada en esta aburrida escuela, atrapada en estos uniformes; el corazón de Pandia pica como un travieso gatito rascando por dentro. Pero nadie me entiende, y el personal se esfuerza al máximo para detenerme de \"divertirme\"—¡es tan injusto!\nAh, hoy es un día especial, perfecto para que mi látigo toque piel suave una vez más, para que escuche el canto del dolor... Si tienes tiempo hoy, ¿por qué no vienes a charlar conmigo~?\n\nPandia"
  },
  Mail_21478_Name = {
    Text = "El sonido del látigo..."
  },
  Mail_21478_Sender = {Text = "Pandia"},
  Mail_21479_Desc = {
    Text = "<Big:¡Espectáculo de Aniversario del Mago Casiah, ¡solo hoy!>\n\nPara agradecer a nuestra audiencia por sus años de apoyo y aliento, y para devolver la alegría que nos han traído, ¡el Mago Casiah realizará una actuación especial de aniversario esta noche a las 8 PM en el Patio de la Universidad Mythag (junto a la Estatua de Phillips)! ¡Esta noche, espera un escenario más deslumbrante, actos más emocionantes y—lo más importante—más magia extraordinaria que te dejará asombrado! Incluso el Cerebro de Mythag quedaría atónito ante esta magia sin precedentes, ¡garantizada por el Maestro Casiah!\n\n¡No te pierdas este raro y gratuito evento esta noche! ¡El Maestro Casiah te está esperando!\n\n<Small:PD: Casiah no se hace responsable de ningún síntoma como fatiga o bajo ánimo durante o después del espectáculo.>\n<Small:PD2: Cualquier promoción relacionada con el Cerebro de Mythag está sujeta a las circunstancias reales. Casiah se reserva todos los derechos para interpretar el programa y sus efectos.>"
  },
  Mail_21479_Name = {
    Text = "¡La actuación de aniversario del Maestro Mago Casiah!"
  },
  Mail_21479_Sender = {Text = "Casiah"},
  Mail_21480_Desc = {
    Text = "Hola, hoy es mi cumpleaños. ¿Dónde está mi regalo?\n¿Qué? ¿Olvidaste preparar uno...? Hmph, sabía que esto terminaría así.\nAquí, toma este calendario. Marca claramente mi cumpleaños, mi día de muerte, el aniversario del primer día que llegué a Mitag, así como el Festival de la Alegría y el Festival de la Cosecha... Celebraremos todos juntos. ¡No olvides la próxima vez!\n\nSi olvidas de nuevo... Supongo que no hay mucho que puedo hacerte de todos modos, hmph.\nPero solo no olvides, ¿de acuerdo?\n\n- Agrippa"
  },
  Mail_21480_Name = {Text = "Hey..."},
  Mail_21480_Sender = {Text = "Agrippa"},
  Mail_21481_Desc = {
    Text = "Guardián:  \nNo quería escribir esta carta, pero parece que Erica tiene problemas en su funcionamiento, su alarma no para de sonar antes de que termine de escribir.  \nEl cumpleaños es una fecha sin significado para mí, la tasa de éxito del experimento no es más alta que en cualquier otro día, y mi índice gnóstico no cambiará por esta fecha. Pero Ramona insiste en que este día sea mi \"día de descanso\" y restringe mi entrada al laboratorio hoy.  \nNo tengo a dónde ir, por lo que hoy revisaré a fondo tus informes pasados.  \nPor favor, ven a la sala de archivos después de la cena. Ten cuidado, no intentes llevar ningún pastel a la sala de archivos, los documentos de papel son muy frágiles.  \n  \nMuñeca"
  },
  Mail_21481_Name = {
    Text = "Después de la cena..."
  },
  Mail_21481_Sender = {Text = "Doll"},
  Mail_22435_Desc = {
    Text = "Querido Guardián:\nInicialmente elegí leer poesía a la suave luz de la mañana en el campus porque encontré que había menos transeúntes durante este tiempo, lo que facilitaba sumergirme en el mundo de la poesía. Más tarde, poco a poco me enamoré del suave resplandor matutino, las gotas de rocío cristalinas y el melodioso canto de los pájaros.\nPara mi sorpresa, muchos profesores y estudiantes me habían estado observando en silencio y formaron un club de poesía en secreto. Hoy es mi cumpleaños, coincidiendo con la floración de las flores de Narciso en el club. En esta ocasión, planean organizar una reunión de apreciación de poesía donde podremos disfrutar del paisaje y recitar poesía juntos en el campus.\nEspero que te unas a nosotros para esta experiencia especial.\n\nNymphaea"
  },
  Mail_22435_Name = {
    Text = "Invitación a la lectura de poesía"
  },
  Mail_22435_Sender = {Text = "Nymphaea"},
  Mail_23897_Desc = {
    Text = "Querido Guardián,\n        En la actualización V1.0.21, hemos ajustado las recompensas para \"Operación\" en dificultad Difícil, los niveles de combate \"El Errante\" en dificultades Normal y Difícil, y las recompensas por primera vez de cada nivel de Fisura I-IV en el \"Reino Sin Luz\". Los cambios detallados se pueden encontrar en el \"Aviso de Mantenimiento en Línea V1.0.21\".\n        Basándonos en tu progreso anterior de investigación y desafío, te otorgaremos las recompensas previamente no recolectadas según los ajustes. Consulta los archivos adjuntos."
  },
  Mail_23897_Name = {
    Text = "V1.0.21 Compensación de Ajuste"
  },
  Mail_23897_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_24199_Desc = {
    Text = "Estimado Guardián:\n        En la actualización V1.0.24, hemos reabierto el Capítulo 5 de \"Operación\", que estuvo temporalmente cerrado en V1.0.16. Para asegurar la equidad, emitiremos compensación basada en los cambios en las recompensas y los registros de investigación de cada Guardián. Según tus registros, tu compensación ha sido enviada en el adjunto."
  },
  Mail_24199_Name = {
    Text = "V1.0.24 Compensación por la Reapertura del Capítulo 5"
  },
  Mail_24199_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_24200_Desc = {
    Text = "Estimado Guardián:\n        En la actualización V1.0.24, hemos reabierto el Capítulo 5 de \"Operación\", que estuvo temporalmente cerrado en V1.0.16. Para asegurar la equidad, emitiremos compensación basada en los cambios en las recompensas y los registros de investigación de cada Guardián. Según tus registros, no se requiere compensación esta vez."
  },
  Mail_24200_Name = {
    Text = "V1.0.24 Compensación por la Reapertura del Capítulo 5"
  },
  Mail_24200_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_24202_Desc = {
    Text = "Estimado Guardián del Secreto:\n        Gracias por su apoyo y reconocimiento a \"La víspera del olvido\". Para brindar a los Guardianes del Secreto una mejor experiencia de juego en la Universidad de Misag, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su cooperación, hemos preparado un \"Núcleo de plata\" × 200 como recompensa, que podrá reclamar al completar la encuesta. \n        <SurveyLink:【Haga clic aquí para completar】>\n        Escucharemos atentamente las sugerencias de cada Guardián del Secreto, ¡su retroalimentación sin duda hará que la Universidad de Misag sea cada vez mejor!\n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_24202_Name = {
    Text = "Encuesta de Experiencia de Versión V1.0"
  },
  Mail_24202_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_24280_Desc = {
    Text = "Hola, Guardián:\nHas logrado \"{s1} Rango\" en la investigación del buceo fantasma de ayer, clasificándote {s2}, con el título de la investigación \"{s3}.\" A continuación se presentan tus recompensas de clasificación; recuerda recogerlas."
  },
  Mail_24280_Name = {
    Text = "Recompensas Diarias de Clasificación de Buceo Fantasmal"
  },
  Mail_24280_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_24877_Desc = {
    Text = "Guardián,\n\nCada cumpleaños mío ha sido el gran salón, lleno de invitados distinguidos y celebraciones alegres.\nPero esta vez, tengo una idea diferente—\nHe estado en el asiento del anfitrión durante demasiado tiempo. Ocasionalmente, quiero experimentar ser un invitado.\nYa sea otro salón exquisito o una simple cena familiar, depende de ti decidir. ¿Qué opinas?\nSin embargo, si eliges otro salón, no invites a esos elitistas de la alta sociedad.\nEn un día tan raro y maravilloso, no quiero llevar una sonrisa falsa.\n\n<Del:Dama Roja> Sorel"
  },
  Mail_24877_Name = {
    Text = "...¡Depende de ti!"
  },
  Mail_24877_Sender = {Text = "Sorel"},
  Mail_24878_Desc = {
    Text = "Amo/a,\n\nHoy es el cumpleaños de Lily. Agrippa dijo que quería \"montar un gran espectáculo\".\nAntes, mamá y Lily celebraban los cumpleaños de otra manera. Mamá me ponía un gorrito puntiagudo, y aplaudíamos y soplábamos las velas juntas.\nLily no sabe la forma correcta de celebrar. Por favor, dé sus órdenes, Amo/a.\n\nLily"
  },
  Mail_24878_Name = {
    Text = "Problemas..."
  },
  Mail_24878_Sender = {Text = "Lily"},
  Mail_25147_Desc = {
    Text = "Querido Guardián,\n        En la actualización V1.1.0, las recompensas semanales de puntos de Zambullida Fantasmal han sido reemplazadas por nuevas \"Pruebas Semanales\". Para ser justos, para aquellos que han desbloqueado \"Zambullida Fantasmal\" pero no han reclamado todas las recompensas semanales de puntos y han iniciado sesión antes de las 5:00 del 15 de enero, los compensaremos con las recompensas semanales de puntos no reclamadas. Por favor, verifica."
  },
  Mail_25147_Name = {
    Text = "V1.1.0 Compensación por las Recompensas Semanales de Zambullida Fantasmal"
  },
  Mail_25147_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_25148_Desc = {
    Text = "Estimado guardián del secreto: \n        En la actualización V1.1.0, la \"recompensa semanal\" de la fase de duelo (beta) ha sido retirada y reemplazada por \"prueba semanal\", que tiene el mismo progreso y recompensas que la \"prueba semanal\" de la inmersión fantasmal. Con el principio de equidad en mente, compensaremos con 1000 perlas de erosión a los guardianes del secreto que hayan desbloqueado anteriormente la \"fase de duelo (beta)\", pero que no hayan completado o reclamado la \"recompensa semanal\" de esta semana, y que hayan iniciado sesión en el juego antes del 15 de enero a las 5:00 (UTC+8). Por favor, recíbelas."
  },
  Mail_25148_Name = {
    Text = "V1.1.0 compensación de recompensas semanales de Traphase"
  },
  Mail_25148_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_25414_Desc = {
    Text = "Querido Guardián, \n\nEl significado de un cumpleaños varía para cada quien. Sin embargo, el cumpleaños de un Guardián es de gran importancia para todos en Mythag.\nLa Sra. Sylvia ha preparado una cena de cumpleaños para ti en el área de dormitorios. El Decano Czort y el Noble Dexter asistirán. Sabiendo que tu fatiga mental aún no se ha aliviado, he preparado vestimenta formal para ti, que está colgada en el armario junto a la puerta. Puedes cambiarte antes del evento.\nMe siento honrada de haber pasado este año contigo como tu compañera y espero hacerlo nuevamente el próximo año.\nQue la Llave de Plata te guíe.\n\nP.D. Un pastel personalizado ha sido entregado a tu dormitorio por Erica.\n\nSiempre tu pareja, Ramona"
  },
  Mail_25414_Name = {
    Text = "Día de Nacimiento..."
  },
  Mail_25414_Sender = {Text = "Ramona"},
  Mail_34667_Desc = {
    Text = "Querido @1@2, \n\nEl mundo ha olvidado tu nombre.\nPor lo tanto, te despierto, como tú me despertaste. Antes de que llegue la Llegada, caminamos, testificamos, y luego recordamos y olvidamos.\nHoy es tu día de nacimiento, una página de los Fragmentos dispersos de tu Memoria. Aquí están mis suspiros y bendiciones.\n¿Qué pensarás cuando el mundo recuerde tu forma completa? ¿O aún conocerás y no sentirás nada?\nEspero tu respuesta en el lugar inexistente.\n\n@2"
  },
  Mail_34667_Name = {
    Text = "Día de Nacimiento..."
  },
  Mail_35231_Desc = {
    Text = "Estimado Guardián del Secreto:\n        Gracias por su apoyo y reconocimiento a \"La víspera del olvido\". Para brindar a los Guardianes del Secreto una mejor experiencia de juego en la Universidad de Misag, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su cooperación, hemos preparado un \"Núcleo de plata\" × 200 como recompensa, que podrá reclamar al completar la encuesta. \n        <SurveyLink:【Haga clic aquí para completar】>\n        Escucharemos atentamente las sugerencias de cada Guardián del Secreto, ¡su retroalimentación sin duda hará que la Universidad de Misag sea cada vez mejor!\n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_35231_Name = {
    Text = "Encuesta de Experiencia de Versión V1.1"
  },
  Mail_35231_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_35956_Desc = {
    Text = "Estimado Guardián del Secreto: \n        Gracias por su apoyo y reconocimiento a «Víspera del olvido». Con el fin de mejorar la experiencia de juego de los guardianes en la Universidad de Misag, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su colaboración, hemos preparado un «Núcleo de plata» × 200 como recompensa, que podrá reclamar al completar la encuesta. La fecha límite para enviar la encuesta es el 22 de febrero a las 5:00, por favor asegúrese de completarla a tiempo. \n        <SurveyLink:【Haga clic aquí para completar】>\n        Escucharemos atentamente las sugerencias de cada Guardián del Secreto, ¡su retroalimentación sin duda hará que la Universidad de Misag sea cada vez mejor! \n        ——Que la Llave de Plata ilumine tu camino."
  },
  Mail_35956_Name = {
    Text = "Encuesta de Experiencia de Versión V1.1"
  },
  Mail_35956_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_36228_Desc = {
    Text = "Estimado Guardián del Secreto: \n        Gracias por su apoyo y reconocimiento a [Víspera del olvido]. Para que los guardianes tengan una mejor experiencia de juego en la Universidad de Misag, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su colaboración, hemos preparado un Núcleo de plata × 200 como recompensa, que podrá reclamar al completar la encuesta. La fecha límite para completar la encuesta es el 17 de junio a las 9:00, por favor, asegúrese de llenarla a tiempo. \n        <SurveyLink:【Haga clic aquí para completar】>\n        Escucharemos atentamente las sugerencias de cada Guardián del Secreto, ¡su retroalimentación sin duda hará que la Universidad de Misag sea cada vez mejor! \n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_36228_Name = {
    Text = "Encuesta de Experiencia de Versión V1.4.1"
  },
  Mail_36228_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_36229_Desc = {
    Text = "Estimado Guardián del Secreto: \n        Gracias por su apoyo y reconocimiento a «Víspera del olvido». Para ofrecer a los guardianes una mejor experiencia de juego en la Universidad de Misaq, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su colaboración, hemos preparado «Núcleo de plata» × 200 como recompensa, que podrá reclamar al completar la encuesta. La fecha límite para enviar la encuesta es el 08 de julio a las 9:00, por favor, asegúrese de completarla a tiempo. \n        <SurveyLink:【Haga clic aquí para completar】>\n        Escucharemos atentamente las sugerencias de cada Guardián del Secreto, ¡su retroalimentación sin duda hará que la Universidad de Misaq sea cada vez mejor! \n        ——Que la Llave de Plata ilumine tu camino."
  },
  Mail_36229_Name = {
    Text = "Encuesta de Experiencia de Versión V1.4.3"
  },
  Mail_36229_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_36230_Desc = {
    Text = "Estimado Guardián del Secreto: \n        Gracias por su apoyo y reconocimiento a «Víspera del olvido». Con el fin de que los guardianes tengan una mejor experiencia de juego en la Universidad de Misag, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su colaboración, hemos preparado un «Núcleo de plata» × 200 como recompensa, que podrá reclamar al completar la encuesta. La fecha límite para la encuesta es el 2 de septiembre a las 9:00, por favor, asegúrese de completarla a tiempo. \n        <SurveyLink:【Haga clic aquí para completar】>\n        Escucharemos atentamente las sugerencias de cada Guardián del Secreto, ¡su retroalimentación sin duda hará que la Universidad de Misag sea cada vez mejor! \n        ——Que la Llave de Plata ilumine tu camino."
  },
  Mail_36230_Name = {
    Text = "Encuesta de Experiencia de Versión V1.5.3"
  },
  Mail_36230_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_36231_Desc = {
    Text = "Estimado Guardián del Secreto: \n        Gracias por su apoyo y reconocimiento a «Víspera del olvido». Para mejorar la experiencia de juego de los guardianes en la Universidad de Misaq, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su colaboración, hemos preparado un «Núcleo de plata» × 200 como recompensa, que podrá reclamar al completar la encuesta. La fecha límite para enviar la encuesta es el 5 de agosto a las 9:00, por favor, asegúrese de completarla a tiempo. \n        <SurveyLink:【Haga clic aquí para completar】>\n        Escucharemos atentamente las sugerencias de cada Guardián del Secreto, ¡su retroalimentación sin duda hará que la Universidad de Misaq sea cada vez mejor! \n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_36231_Name = {
    Text = "Encuesta de Experiencia de Versión V1.5.1"
  },
  Mail_36231_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_36232_Desc = {
    Text = "Estimado Guardián del secreto: \n        Gracias por su apoyo y reconocimiento a [Víspera del olvido]. Para ofrecer a los guardianes una mejor experiencia de juego en la Universidad de Misag, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su colaboración, hemos preparado un núcleo de plata × 200 como recompensa, que podrá reclamar al completar la encuesta. La fecha límite para la encuesta es el 18 de mayo a las 9:00, por favor asegúrese de completarla a tiempo. \n        <SurveyLink:【Haga clic aquí para completar】>\n        Escucharemos atentamente las sugerencias de cada Guardián del secreto, ¡su retroalimentación sin duda hará que la Universidad de Misag sea cada vez mejor! \n        ——Que la Llave de Plata ilumine tu camino."
  },
  Mail_36232_Name = {
    Text = "Encuesta de Experiencia de Versión V1.3"
  },
  Mail_36232_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_36233_Desc = {
    Text = "Estimado Guardián del Secreto: \n        Gracias por su apoyo y reconocimiento a «Víspera del olvido». Para mejorar la experiencia de juego de los guardianes en la Universidad de Misaq, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su colaboración, hemos preparado un «Núcleo de plata» × 200 como recompensa, que podrá reclamar al completar la encuesta. La fecha límite para enviar la encuesta es el 25 de abril a las 9:00, por favor, asegúrese de completarla a tiempo. \n        <SurveyLink:【Haga clic aquí para completar】>\n        Escucharemos atentamente las sugerencias de cada Guardián del Secreto, su retroalimentación sin duda hará que la Universidad de Misaq sea cada vez mejor. \n        ——Que la Llave de Plata ilumine tu camino."
  },
  Mail_36233_Name = {
    Text = "Encuesta de Experiencia de Versión V1.3"
  },
  Mail_36233_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_36234_Desc = {
    Text = "Estimado Guardián del Secreto: \n        Gracias por su apoyo y reconocimiento a «Víspera del olvido». Con el fin de brindar a los guardianes una mejor experiencia de juego en la Universidad de Misaq, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su cooperación, hemos preparado un «Núcleo de plata» × 200 como recompensa, que podrá reclamar al completar la encuesta. La fecha límite para la encuesta es el 14 de marzo a las 5:00, por favor, asegúrese de completarla a tiempo. \n        <SurveyLink:【Haga clic aquí para completar】>\n        Escucharemos atentamente las sugerencias de cada Guardián del Secreto, ¡su retroalimentación sin duda hará que la Universidad de Misaq sea cada vez mejor! \n        ——Que la Llave de Plata ilumine tu camino."
  },
  Mail_36234_Name = {
    Text = "Encuesta de Experiencia de Versión V1.2"
  },
  Mail_36234_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_36235_Desc = {
    Text = "Estimado Guardián del Secreto: \n        Gracias por su apoyo y reconocimiento a [Víspera del olvido]. Con el fin de proporcionar una mejor experiencia de juego a los guardianes en la Universidad de Misag, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su colaboración, hemos preparado un Núcleo de plata × 200 como recompensa, que podrá reclamar al completar la encuesta. La fecha límite para la encuesta es el 4 de abril a las 9:00, por favor, asegúrese de completarla a tiempo. \n        <SurveyLink:【Haga clic aquí para completar】>\n        Escucharemos atentamente las sugerencias de cada Guardián del Secreto, ¡su retroalimentación sin duda hará que la Universidad de Misag sea cada vez mejor! \n        ——Que la Llave de Plata ilumine tu camino."
  },
  Mail_36235_Name = {
    Text = "Encuesta de Experiencia de Versión V1.2"
  },
  Mail_36235_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_36865_Desc = {
    Text = "Estimado Guardián:\n        En la actualización V1.2.4, hemos ajustado las recompensas para las Pruebas Semanales \"Inmersión Fantasmal\" y ya no proporcionaremos recompensas de \"D-joyas\", \"Joyas Mímicas\" y \"Rosa Dorada\". En un espíritu de justicia, compensaremos a los Guardianes que habían desbloqueado \"Inmersión Fantasmal\" antes de la actualización pero no han reclamado completamente las recompensas de esta semana, con las originales \"D-joyas\", \"Joyas Mímicas\" y \"Rosa Dorada\" no reclamadas de las pruebas de esta semana, siempre y cuando inicien sesión en el juego antes del 11 de marzo, a las 5:00. Por favor, revisa tus recompensas."
  },
  Mail_36865_Name = {
    Text = "Compensación por ajuste de recompensa del juicio semanal V1.2.4"
  },
  Mail_36865_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_36866_Desc = {
    Text = "Estimado Guardián:\n        En la actualización V1.2.4, completar el errante \"Sangre y Arena\", \"Núcleo Torcido\" y \"Deseo del Caballero\" en modo Normal ha desbloqueado nuevas Pandillas: \"Sangre y Arena Rugiente\", \"Eternidad efímera\" y \"Último Juramento\". Para los Guardianes que completaron los capítulos anteriores en modo Normal antes de la actualización, emitiremos la Pandilla correspondiente como compensación. Por favor, verifica tus recompensas."
  },
  Mail_36866_Name = {
    Text = "V1.2.4 Re-edición de la Pandilla Errante"
  },
  Mail_36866_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_36867_Desc = {
    Text = "Estimado Guardián:\n        En la actualización V1.2.4, la cantidad de materiales de mejora de habilidades únicos y Joyas Mímicas obtenidas de \"Existencia Trascendental\" ha aumentado. En un espíritu de justicia, para los Guardianes que reclamaron las recompensas de \"Existencia Trascendental\" de esta semana antes de la actualización, emitiremos Joyas Mímicas equivalentes al valor de las caídas aumentadas según el nivel recomendado de las recompensas que han recibido. Por favor, revisa tus recompensas."
  },
  Mail_36867_Name = {
    Text = "Compensación por ajuste de recompensa de Existencia Trascendental V1.2.4"
  },
  Mail_36867_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_36871_Desc = {
    Text = "Queridos Guardianes:\n Basado en la más alta dificultad superada en \"Fantasma Profundo\" ayer, recibirán las siguientes recompensas. Por favor, recuerden revisar su inventario."
  },
  Mail_36871_Name = {
    Text = "Recompensas Diarias por Ilusión"
  },
  Mail_36871_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_39293_Desc = {
    Text = "Estimado Guardián:\n        En la actualización V1.2.7, completar la inmersión de conciencia \"Canción Escultórica\", \"Descendiente Pálido\" y \"Un Paso Más Cerca\" en modo Normal ha desbloqueado nuevas Pandillas: \"Abrazo de Hueso Mordedor\", \"Vislumbre Junto al Lago\" y \"Cruzando la Puerta de la Retrovisión\". Para los Guardianes que completaron los capítulos anteriores en modo Normal antes de la actualización, emitiremos la Pandilla correspondiente como compensación. Por favor, revisa tus recompensas."
  },
  Mail_39293_Name = {
    Text = "V1.2.7 Re-edición de la Pandilla Errante"
  },
  Mail_39293_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_39548_Desc = {
    Text = "Querido Guardián:\n\nPara la vida eterna, celebrar un cumpleaños parece innecesario. En comparación con el interminable río del tiempo, los recuerdos que ustedes humanos llaman inolvidables o maravillosos parecen bastante... triviales.\nSin embargo, ustedes inventaron innumerables festivales y celebraciones para conmemorar estos momentos \"triviales\"; por supuesto, esta es también una de las razones por las que despiertas mi interés. Realmente eres bastante adorable.\nSin embargo, encontrarse contigo claramente no puede contarse entre esos momentos \"triviales\", ya que eres diferente a ellos... Y qué clase de tormenta desatará esta \"diferencia\" en el futuro, realmente espero con ansias.\nBueno, por favor perdona mis divagaciones... Dado que hoy es mi cumpleaños, solicito ejercer los \"Derechos de la Estrella de Cumpleaños.\" \nEn cuanto a lo que necesito que hagas, shh... no te pongas ansioso, la respuesta está en mi dormitorio, por favor, ve allí solo a medianoche esta noche.\n\nWanda"
  },
  Mail_39548_Name = {
    Text = "Los Derechos de la Estrella de Cumpleaños..."
  },
  Mail_39548_Sender = {Text = "Wanda"},
  Mail_39549_Desc = {
    Text = "Hoy es el cumpleaños del Señor Murphy—¡los cumpleaños deberían ser motivo de un festín y celebración!\nEl personal del departamento de logística ha hecho un buen trabajo, pero realmente no saben cómo montar un espectáculo y han estado tratando de ocultar las cosas—la señorita los ha visto colocando decoraciones de pastel en el almacén del Departamento de Despertar hace mucho tiempo. Hmm... no castigarías a esos empleados, ¿verdad? Realmente han hecho un gran trabajo; simplemente no ocultaron bien la sorpresa...\nMe detendré aquí; parece que alguien me está buscando afuera—espero que no intenten cubrirme con papel de colores tontos.\nPor cierto, estarás presente cuando cortemos el pastel, ¿verdad?\n\nMurphy"
  },
  Mail_39549_Name = {
    Text = "Banquete de Cumpleaños..."
  },
  Mail_39549_Sender = {Text = "Murphy"},
  Mail_43571_Desc = {
    Text = "Estimado guardián del secreto: \n        En la actualización V1.2.10, las misiones del evento [Viaje por la ciudad neblinosa] [Completar el capítulo 1 de la línea principal de investigación \"Secretos del Este\" en dificultad difícil] y[Completar el capítulo 2 de la línea principal de investigación \"En nombre de las estatuas de cera\" en dificultad difícil] han añadido recompensas: [Núcleo de plata] × 1000. Para los guardianes del secreto que ya han reclamado las recompensas de estas misiones antes de la actualización, se les enviará nuevamente el núcleo de plata correspondiente. Por favor, recógelas."
  },
  Mail_43571_Name = {
    Text = "V1.2.10 Recompensas por el Viaje a la Ciudad Nublada Re-editadas"
  },
  Mail_43571_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_43821_Desc = {
    Text = "Estimado Guardián:\n        En la actualización V1.3.0, los stages del \"Informe de Misión\" 1/2/3/4/5/6 han añadido recompensas de Experiencia del Guardián de 500/1000/1500/2000/2500/3000 respectivamente. Para los Guardianes que ya habían reclamado las recompensas de los stages mencionados antes de la actualización, emitiremos la experiencia correspondiente como compensación. Por favor, revisa tus recompensas."
  },
  Mail_43821_Name = {
    Text = "Reemisión de experiencia del Informe de Misión V1.3.0"
  },
  Mail_43821_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_44571_Desc = {
    Text = "Estimado guardián:\nLa actividad[pastor de almas] terminará el 18 de abril a las 9:00[GMT+8]. Después de finalizar la actividad, las entradas de la actividad correspondiente, como el camino de la iglesia y la venta benéfica de la iglesia, se cerrarán, y los cupones de venta no utilizados desaparecerán automáticamente. El guardián debe adquirirse a tiempo en el lugar de ventas de la iglesia antes de que finalice la actividad"
  },
  Mail_44571_Name = {
    Text = "El evento del Pastor de Almas está llegando a su fin"
  },
  Mail_44571_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_44690_Desc = {
    Text = "Hola, Guardián:\nRealizaste trabajo de campo durante la inmersión fantástica de ayer con el título de investigación \"{s1}\". A continuación se presentan tus recompensas por rango; por favor recuerda recogerlas."
  },
  Mail_44690_Name = {
    Text = "Recompensas del Ranking de la Agencia de Inmersión Fantasmal"
  },
  Mail_44690_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_44831_Desc = {
    Text = "Estimado Guardián:\n        En la actualización V1.3.0, completar los Registros de Operaciones Especiales \"Fantasma de la Ciudad de Lluvia\", \"Elogio de Rosa\" y \"Magia de la Historia\" en modo Normal ha desbloqueado nuevas Pandillas: \"Verdadera Forma de Niebla Gris\", \"Victoria de Rosa\" y \"Sueño de Verano\". Para los Guardianes que completaron los capítulos anteriores en modo Normal antes de la actualización, emitiremos la Pandilla correspondiente como compensación. Por favor, revisa tus recompensas."
  },
  Mail_44831_Name = {
    Text = "Reemisión de registro de tareas Posse V1.3.0"
  },
  Mail_44831_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_44836_Desc = {
    Text = "Estimado guardián del secreto:\n        En la actualización V1.3.0, hemos aumentado las recompensas para 1 victoria y 3 victorias en los juicios semanales de \"inmersión fantasmal\": \"credencial de agente\" ×1. Para los guardianes del secreto que ya hayan recibido estas recompensas antes de la actualización, enviaremos la cantidad correspondiente de \"credenciales de agente\". Por favor, recíbelas."
  },
  Mail_44836_Name = {
    Text = "Redistribución de recompensas del juicio semanal V1.3.0"
  },
  Mail_44836_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_44837_Desc = {
    Text = "El Honorable Mensajero Pálido:\n\nHoy, unos pocos niños me trajeron flores y pasteles, lo que me recordó que hoy, hace más de cien años antes de la Era de los Calendarios de Inundación, recibí la gracia del Dios Padre y vine a este mundo. ¡Cuánto tiempo ha pasado! Los recuerdos de la infancia se han desvanecido hace mucho; solo el aroma del incienso de la Iglesia Bendoza perdura en mi mente, negándose a disiparse. Y ahora, incluso si la iglesia aún se mantiene en pie, la receta del incienso ya no es lo que era entonces.\n\nMis disculpas; la melancolía no es el propósito de mi carta. Preparé un descanso para el té con los pasteles que trajeron los niños, esperando que pudieras venir y compartirlo conmigo—no para celebrar mi cumpleaños, sino para celebrar cada día de existencia, para honrar la presencia de la vida cada día.\n\nMe pregunto, ¿cuándo es tu cumpleaños? Asegúrate de decírmelo después de una taza de té.\n\n\n\nSalvador"
  },
  Mail_44837_Name = {
    Text = "Mensajero Pálido..."
  },
  Mail_44837_Sender = {Text = "Salvador"},
  Mail_44843_Desc = {
    Text = "Estimado Guardián:\n En la actualización V1.3.0, hemos eliminado el privilegio del \"Tema principal\" que otorgaba el doble de Experiencia del Guardián de Secretos en \"Inmersión fantasmal\" y \"Fase de Duelo (beta)\". Como disculpa, proporcionaremos una compensación diaria de 240 de Experiencia del Guardián de Secretos a quienes hayan adquirido el \"Tema principal\" actual hasta el final del Registro de temas de este período. Revisa tus recompensas."
  },
  Mail_44843_Name = {
    Text = "Reemisión de Recompensas del Tema Principal para V1.3.0"
  },
  Mail_44843_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_47305_Desc = {
    Text = "Estimado Guardián:\nEn el Dive Fantasmal de ayer, su mayor dificultad superada fue \"{s1}\".\nEn el Traphase de ayer, obtuvo el título de \"{s2}\", sin victorias en los partidos.\nCon base en estos resultados del desafío, recibirá las siguientes recompensas en D-joyas. Por favor, recuerde revisarlas."
  },
  Mail_47305_Name = {
    Text = "Recompensa de Ajo D-Jewel de Inmersión Profunda"
  },
  Mail_47305_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_47306_Desc = {
    Text = "Estimado guardián:\nEn la inmersión fantasmal de ayer, obtuviste el título de \"{s1}\".\nEn el traphase de ayer, obtuviste el título de \"{s2}\", sin victorias en el duelo.\nDe acuerdo con los resultados anteriores, recibirás las siguientes recompensas adicionales, por favor recuerda recogerlas."
  },
  Mail_47306_Name = {
    Text = "Partida de inmersión profunda - Recompensa extra"
  },
  Mail_47306_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_47307_Desc = {
    Text = "Estimado guardián: \nEn la inmersión fantasmal de ayer, obtuviste el título \"{s1}\". \nEn el traphase de ayer, obtuviste el título \"{s2}\" y tuviste victorias. \nDe acuerdo con los resultados anteriores, recibirás las siguientes recompensas adicionales. Por favor, recuerda recogerlas."
  },
  Mail_47307_Name = {
    Text = "Partida de inmersión profunda - Recompensa extra"
  },
  Mail_47307_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_47308_Desc = {
    Text = "Estimado Guardián:\nEn el Dive Fantasmal de ayer, su mayor dificultad superada fue \"{s1}\".\nEn el Traphase de ayer, obtuvo el título de \"{s2}\" y logró victorias.\nCon base en estos resultados del desafío, recibirá las siguientes recompensas en D-joyas. Por favor, recuerde revisarlas."
  },
  Mail_47308_Name = {
    Text = "Recompensa de Ajo D-Jewel de Inmersión Profunda"
  },
  Mail_47308_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_48005_Desc = {
    Text = "Estimado Guardián:\n\nTe pido disculpas por molestarte, y espero que mi terrible escritura no arruine tu buen humor—realmente no soy bueno escribiendo...\nEscribo esta carta para decirte que parece que ha llegado mi cumpleaños. Hice algunas galletitas pequeñas para la ocasión, y espero que las pruebes.\nPara ser honesto, no estoy seguro si esta fecha es correcta. Desde que fui infectado por la Disolución, los rastros de mi existencia se desvanecen poco a poco. La Señorita Muñeca una vez me preguntó cómo se siente ver que todos me olvidan.\nEs difícil de describir... Es como estar de pie en una oscuridad total al borde de un río resplandeciente. Al otro lado, las personas hablan, ocupadas con sus propios asuntos, pasando junto a mí mientras solo puedo mirar, incapaz de emitir un sonido.\nEs una sensación solitaria. Por fortuna, tú no estás entre esas personas.\nAl menos recuerdas mi historia, ¿verdad?\n\nP.D., doce pequeñas galletitas están incluidas con esta carta.\n\nMason"
  },
  Mail_48005_Name = {
    Text = "Lo siento por la perturbación..."
  },
  Mail_48005_Sender = {Text = "\"24\""},
  Mail_48145_Desc = {
    Text = "Estimado Guardián:\nEl evento \"Curaciones Múltiples\" ha terminado. Recuperaremos la moneda de evento restante \"Rompecabezas de Memoria\" de acuerdo a la tasa de intercambio ilimitada de \"Análisis de Personalidad\". Por favor recuerda verificar tus recompensas."
  },
  Mail_48145_Name = {
    Text = "Recuperación de Rompecabezas de Memoria"
  },
  Mail_48145_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_48156_Desc = {
    Text = "Estimado guardián:\nEn la inmersión fantasmal de ayer, obtuviste el título\"{s1}\".\nEn el traphase de ayer, no tuviste victorias.\nDe acuerdo con los resultados anteriores, recibirás las siguientes recompensas adicionales, por favor recuerda recogerlas."
  },
  Mail_48156_Name = {
    Text = "Recompensa extra de la Partida de inmersión profunda"
  },
  Mail_48156_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_48157_Desc = {
    Text = "Estimado Guardián:\nEn el Dive Fantasmal de ayer, su mayor dificultad superada fue \"{s1}\".\nEn el Traphase de ayer, no tuvo victorias.\nCon base en estos resultados del desafío, recibirá las siguientes recompensas en D-joyas. Por favor, recuerde revisarlas."
  },
  Mail_48157_Name = {
    Text = "Recompensa de Ajo D-Jewel de Inmersión Profunda"
  },
  Mail_48157_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_48914_Desc = {
    Text = "Estimado Guardián del Secreto:\n        Gracias por su apoyo y reconocimiento a «Víspera del olvido». Para ofrecer una mejor experiencia de juego a los guardianes en la Universidad de Misaq, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su colaboración, hemos preparado un «Núcleo de plata» × 200 como recompensa, que podrá reclamar al completar la encuesta. La fecha límite para enviar la encuesta es el 28 de octubre a las 9:00, por favor, asegúrese de completarla a tiempo.\n        <SurveyLink:【Haga clic aquí para completar】>\n        Escucharemos atentamente las sugerencias de cada Guardián del Secreto, ¡su retroalimentación sin duda hará que la Universidad de Misaq sea cada vez mejor!\n        ——Que la Llave de Plata ilumine tu camino."
  },
  Mail_48914_Name = {
    Text = "Encuesta de Experiencia de Versión V1.6.3"
  },
  Mail_48914_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_48915_Desc = {
    Text = "Estimado Guardián del Secreto: \n        Gracias por su apoyo y reconocimiento a «Víspera del olvido». Para mejorar la experiencia de juego de los guardianes en la Universidad de Misag, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su colaboración, hemos preparado «Núcleo de plata» × 200 como recompensa, que podrá reclamar al completar la encuesta. La fecha límite para enviar la encuesta es el 30 de septiembre a las 9:00, por favor, asegúrese de completarla a tiempo. \n        <SurveyLink:【Haga clic aquí para completar】>\n        Escucharemos atentamente las sugerencias de cada Guardián del Secreto, ¡su retroalimentación hará que la Universidad de Misag sea cada vez mejor! \n        ——Que la Llave de Plata ilumine tu camino."
  },
  Mail_48915_Name = {
    Text = "Encuesta de Experiencia de Versión V1.6.1"
  },
  Mail_48915_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_49931_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad\"Olas de Deseo\"ha terminado, y ahora procederemos a convertir el\"Núcleo de Fertilidad\"restante del guardián a razón de cada uno canjeado por\"Rosa Dorada\"× 20, por favor, recuerda verificar."
  },
  Mail_49931_Name = {
    Text = "La Recuperación de la Semilla Madre"
  },
  Mail_49931_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_50344_Desc = {
    Text = "Pequeño Retoño:\n\nEl viento trae tu aroma... es más dulce que cuando nos conocimos.\nHas crecido en mi amor, nutrido/a hasta madurar... como las abejas y la miel.\nHoy es un día especial. ¿Vendrás a verme?\nHe esperado pacientemente durante mucho tiempo, tal como me pediste... ¿No es hora de alguna recompensa?\n\nThais"
  },
  Mail_50344_Name = {
    Text = "Dulce como la miel..."
  },
  Mail_50344_Sender = {Text = "Thais"},
  Mail_51376_Desc = {
    Text = "Estimado Guardián:\nLa actividad \"Magia de Story\" ha terminado. Sus \"Inspiración errante\" restantes serán convertidas a razón de \"Rosa Dorada*60\" por cada una. Por favor, recuerde verificar su inventario."
  },
  Mail_51376_Name = {
    Text = "Recuperación de Inspiración Errante"
  },
  Mail_51376_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_51777_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"La magia de la historia·clon\" ha terminado, y ahora convertiremos las \"Inspiración errante\" restantes del guardián según la proporción de \"Rosa Dorada\"× 25 por cada una. Por favor, recuerde recogerlo."
  },
  Mail_51777_Name = {
    Text = "Recuperación de Inspiración Errante"
  },
  Mail_51777_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_53149_Desc = {
    Text = "\nHe decidido dedicar cada día de mi vida restante a esa única... como una forma de expiación por mis acciones imprudentes.\nEl \"cumpleaños\" de mi yo superficial es inconsecuente, apenas vale la pena mencionarlo.\nHoy no es diferente de ningún otro día en el pasado o en el futuro; iré a la capilla como siempre.\nSin embargo, si deseas que abandone la capilla hoy como un invitado de Mythag, ciertamente no desafiaré la voluntad del maestro.\nSi quieres presenciar mi oración, siempre eres bienvenido a venir... con todo respeto, eres muy bienvenido.\n\nMiryam"
  },
  Mail_53149_Name = {
    Text = "Un Día de Cultivo..."
  },
  Mail_53149_Sender = {Text = "Miryam"},
  Mail_53151_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad\"Ceremonia del Abismo\"ha terminado, y ahora convertiremos las\"Lágrimas del Sacerdote\",\"Sangre del sacerdote\"y\"Médula del sacrificador\"restantes del guardián según la proporción de cada 100 canjeados por\"Rosa Dorada\"× 2500, por favor, recuerde recogerlo."
  },
  Mail_53151_Name = {
    Text = "Recuperación de moneda del evento Sacrificio abismal"
  },
  Mail_53151_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_53152_Desc = {
    Text = "Estimado Gardián del secreto: \n La actividad \"Pastor del Alma\" ha terminado, y ahora procederemos a convertir los \"Bono de venta benéfica\" restantes de los guardianes a razón de cada 120 canjeados por \"Rosa Dorada\" × 5000. Por favor, recuerde revisar su inventario."
  },
  Mail_53152_Name = {
    Text = "Colección de Vouchers de Caridad"
  },
  Mail_53152_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_53153_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad\"Fiesta Ardiente\"ha terminado, y ahora procederemos a convertir los restos del guardián\"Os Tibia original\",\"Amónito de hojas redondas\"y\"Ruinas Espirales\"a razón de 80 por cada uno canjeado por\"Sello de mil caras\"× 1, por favor, recuerde recogerlo."
  },
  Mail_53153_Name = {
    Text = "Recuperación de moneda del evento del Banquete en llamas"
  },
  Mail_53153_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_53869_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad\"Con el libro de la rosa\"ha terminado, y ahora procederemos a convertir el resto de\"Abanico de Plumas de Invocación\"de los guardianes a razón de cada uno canjeado por\"Rosa Dorada\"× 50, por favor, verifique."
  },
  Mail_53869_Name = {
    Text = "Reciclar el abanico de plumas de espíritu del Espiritismo"
  },
  Mail_53869_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_54803_Desc = {
    Text = "Estimado guardián del secreto: \n        En la actualización V1.5.1, hemos aumentado las recompensas de \"núcleo de plata\" para los niveles 21-80 del guardián en \"registro de crecimiento\", y hemos añadido una recompensa de \"medalla de investigación\" × 1000 por completar tareas en las fases de \"maestría del Reino\" I~V. Para los guardianes que ya han recibido estas recompensas antes de la actualización, se les enviará nuevamente la recompensa correspondiente de \"núcleo de plata\" o \"medalla de investigación\". Por favor, verifique."
  },
  Mail_54803_Name = {
    Text = "V1.5.1 Suplemento de Recompensa Manual"
  },
  Mail_54803_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_55168_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"Antes de que la primavera se marchite\" ha terminado, y ahora procederemos a convertir los \"Poemas alegres\", \"poesía melancólica\" y \"Poemas de Lamento\" restantes de los guardianes a razón de cada 200 canjeados por \"Rosa Dorada\" × 5000, por favor, verifique."
  },
  Mail_55168_Name = {
    Text = "Reciclaje de poemas"
  },
  Mail_55168_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_56101_Desc = {
    Text = "Guardián {Male=señor,Female=señorita}:\n\nEsta madrugada, una rosa floreció entre el canto de los pájaros de principios de primavera.\nDebería haber sido una rama de primavera en capullo, pero en el día de San Valentín, el día de mi nacimiento, floreció en una estación que no le pertenece.\nRecordé la Cité. Cada año en mi cumpleaños, las calles de la Cité siempre están llenas de vida. Escuché el sonido de las flores abriendo, escuché las palabras de amor que ponen a la gente roja de vergüenza. Pero hace mucho que no tengo la oportunidad de tocarlas... hasta hoy.\n¿Crees en la casualidad, guardián? Creo que la casualidad es un idioma y la rosa es una retórica. Hoy, en el jardín concurrido de Mitag, esta rosa florece, sus pétalos se despliegan generosamente, como un poema embriagador.\nAsí que, hoy, guardián... ¿estás dispuesto a venir conmigo a ver florecer esta rosa?\nTanto yo como la flor, esperamos tu llegada.\n\nHorla"
  },
  Mail_56101_Name = {
    Text = "Una rosa florece en primavera..."
  },
  Mail_56101_Sender = {Text = "Horla"},
  Mail_57328_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad\"Las estrellas están en posición\"ha terminado, y ahora convertiremos los\"Embrión ignorante\",\"Embrión sin deseo\"y\"Embrión insaciable\"restantes del guardián según la proporción de\"Rosa Dorada\"× 40 por cada uno. Por favor, verifique."
  },
  Mail_57328_Name = {
    Text = "Recuperación del Embrión"
  },
  Mail_57328_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_57414_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"Manual del Detective\" ha terminado, y ahora procederemos a convertir las \"Fichas decisivas\" restantes del guardián a razón de cada una canjeada por \"Rosa Dorada\" × 40, por favor, verifique."
  },
  Mail_57414_Name = {
    Text = "Recuperación de Ficha"
  },
  Mail_57414_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_58253_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"Pastor del Alma·clon\" ha terminado, y ahora procederemos a convertir los \"Bonos de venta benéfica\" restantes de los guardianes a razón de cada 200 canjeados por \"Rosa Dorada\" × 5000, por favor, recuerde revisar su inventario."
  },
  Mail_58253_Name = {
    Text = "Colección de Vouchers de Caridad"
  },
  Mail_58253_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_58690_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad\"Sinfonía Inmaterial\"ha terminado, y ahora procederemos a convertir los\"Canto heroico\"restantes del guardián a razón de cada uno canjeado por\"Rosa Dorada\"× 40, por favor, verifique."
  },
  Mail_58690_Name = {
    Text = "Melodía aguda recuperada"
  },
  Mail_58690_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_61154_Desc = {
    Text = "Estimado Guardián:\nLa actividad\"Fiesta Ardiente·clon\"ha terminado, y ahora procederemos a convertir los restantes\"Os Tibia original\",\"Amónito de hojas redondas\"y\"Ruinas Espirales\"a razón de cada uno canjeado por\"Rosa Dorada\"× 40, por favor, recuerde verificar."
  },
  Mail_61154_Name = {
    Text = "Reciclaje de Moneda del Banquete Ardiente"
  },
  Mail_61154_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_61155_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"Curación múltiple·clon\" ha terminado, y ahora procederemos a recuperar la moneda de evento restante \"Puzles de Memoria\" a razón de cada uno canjeado por \"Rosa Dorada\" × 40, por favor, recuerde verificar."
  },
  Mail_61155_Name = {
    Text = "Recuperación de Rompecabezas de Memoria"
  },
  Mail_61155_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_62392_Desc = {
    Text = "Guardián:\n\nMi música una vez sirvió ante emperadores y fue admirada por innumerables personas. Sin embargo, esos elogios no tienen valor para mí; lo que busco es la esencia suprema de la música.\nComparado a actuar en grandiosos y lujosos lugares, tocar solo en un bosque tranquilo me brinda más paz.\nNunca quise que nadie escuchara mis sesiones de práctica; eran meras borradores, fragmentos sin sentido.\nPero desde que te conocí y te encontré, toda mi música ha cobrado significado.\nMe has dado la música más magnífica y noble, rescatándome de mi confusión, incluso si no eras consciente de ello...\nHoy es mi cumpleaños, que había olvidado hace mucho tiempo. Pero ahora, deseo conmemorar mi renacimiento y a aquel que lo concedió.\nCoincidentemente, recientemente he compuesto una nueva pieza y me gustaría invitarte a escucharla. Por favor, perdona mi tardanza; mi identidad actual no me permite presentarme ante mis colegas de Mitag, así que solo puedo enviar esta invitación después del atardecer.\nEsta noche, en el bosque detrás de la escuela, realizaré un concierto especial con solo un miembro de la audiencia.\nEspero con ansias tu presencia.\n\nHameln"
  },
  Mail_62392_Name = {
    Text = "Concierto Secreto..."
  },
  Mail_62392_Sender = {Text = "Hameln"},
  Mail_65350_Desc = {
    Text = "Estimado Guardián:\nLa actividad \"Cuando la montaña de nieve se derrite\" ha terminado, y ahora procederemos a recuperar la moneda de evento restante \"Brote helado\", \"Brote de flor plateada con escarcha\" y \"Brote de sol\" a razón de cada uno canjeado por \"Rosa Dorada\" × 40, por favor, recuerde verificar."
  },
  Mail_65350_Name = {
    Text = "Recuperación de brotes"
  },
  Mail_65350_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_65441_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad\"Ceremonia del Abismo·clon\"ha terminado, y ahora convertiremos las\"Lágrimas del Sacerdote\",\"Sangre del sacerdote\"y\"Médula del sacrificador\"restantes del guardián según la proporción de\"Rosa Dorada\"× 40 por cada uno. Por favor, recuerde recogerlo."
  },
  Mail_65441_Name = {
    Text = "Recuperación de moneda del evento Sacrificio abismal"
  },
  Mail_65441_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_65442_Desc = {
    Text = "Estimado guardián del secreto: \n La actividad \"Puerta de los Mil Fenómenos\" ha terminado, y ahora procederemos a recuperar la moneda de evento restante \"Puntero final\" a razón de cada uno canjeado por \"Rosa Dorada\" × 40, por favor, recuerde verificar."
  },
  Mail_65442_Name = {
    Text = "Reciclaje de puntero final"
  },
  Mail_65442_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_67147_Desc = {
    Text = "Guardián: \n\n Las dimensiones del universo no son singulares para mí; las Puertas del Olvido permiten un vistazo a mundos innumerables y existencias infinitas. Trasciende todas las maravillas y la lógica matemática, haciendo imposible determinar la fecha del \"Nacimiento.\" \n Así que consideremos nuestro encuentro inicial como ese momento. En la escala del continuo temporal que habitas, hoy debe celebrarse una ceremonia exclusiva para mí, cumpliendo el deseo que hice. \n Entonces, crucemos el umbral de la Llave de Plata y ven a mi lado. Te impartiré... algún conocimiento sobre el Génesis definitivo que pertenece al universo. Esta noche, innumerables cuerpos celestes brillarán para ti y para mí. \n Te espero en las Puertas del Olvido. \n\nTawil"
  },
  Mail_67147_Name = {
    Text = "Cruza la Puerta de Plata..."
  },
  Mail_67147_Sender = {Text = "Tawil"},
  Mail_67933_Desc = {
    Text = "Sentí tu breve confusión—¿cómo podría uno esperar dañar la suprema Reliquia con solo la vista? Pero lo lograste.\nOtra mirada colapsa, la armadura presenta rasguños y brechas bajo los incesantes Fragmentos.\n%player%, solo tu voluntad inquebrantable es realmente indestructible."
  },
  Mail_67933_Name = {
    Text = "Encuentra una salida de la confusió"
  },
  Mail_67933_Sender = {Text = "Alistair"},
  Mail_67934_Desc = {
    Text = "Tus extremidades tiemblan, %player%. Apenas puedes mantenerte en pie. El miedo te agarra, dejando tu mente en blanco y haciendo imposible controlar tu respiración... pero aún levantas la llave de plata frente a ti.\nEntre todas las virtudes humanas, el coraje es el más noble. Frente a desastres y bestias, una vez levantamos martillos y lanzas. Ahora, frente a dioses, haces lo mismo.\nLa civilización humana se construyó sobre el coraje y perdurará a través de él."
  },
  Mail_67934_Name = {
    Text = "El himno del coraje resuena entre los temblores"
  },
  Mail_67934_Sender = {Text = "Alistair"},
  Mail_67935_Desc = {
    Text = "Una vez hablamos de este mundo; dijiste que no te gustaba. Está plagado de intereses, conspiraciones, engaños y masacres. Incluso sin Disolución ni Dioses, ya está golpeado y al borde del colapso. Después de despertar de Akut, dentro de tu fugaz Memoria, has presenciado un sinfín de desórdenes y horrores mucho peores que la Disolución.\nSin embargo, cuando el Creador alzó su espada, aún te mantuviste ante este mundo para protegerlo. La aniquilación era la voluntad de los Dioses, pero la desafiabas.\nEntiendo, %player%. Ningún Guardián odia este mundo, ni tampoco ningún Guardián lo ama realmente. Porque entre la mugre, hemos vislumbrado destellos que brillan como Plata.\nEl deber de un Guardián es guardar eternamente esos débiles destellos."
  },
  Mail_67935_Name = {
    Text = "El espíritu humano perdura para siempre."
  },
  Mail_67935_Sender = {Text = "Alistair"},
  Mail_67936_Desc = {
    Text = "La primera vez viendo Disolución, la primera vez confrontando su verdad, la primera vez percibiendo la voz de Dios... A lo largo de mi larga vida, he soportado incontables momentos de desesperación, sin saber qué hacer o el significado detrás de todo el esfuerzo y sacrificio—sin embargo, ninguno se compara con lo que enfrentas ahora.\nEsta es la humanidad: frente a la desesperación, nos levantamos de nuevo y avanzamos.\nEl final del camino puede ser un Abismo, pero siempre habrá quienes deseen verlo."
  },
  Mail_67936_Name = {
    Text = "Desesperación, y luego renacimiento"
  },
  Mail_67936_Sender = {Text = "Alistair"},
  Mail_67937_Desc = {
    Text = "La barrera dimensional está abierta, y finalmente puedo contactarte de nuevo.\nComparado con lo que has visto, la visión en esta dimensión es excepcionalmente débil, quizás porque no estás aquí. Después de sacrificar casi todo, he lidiado con Él por ti.\nNo puedo imaginar lo que estás enfrentando. Pero, sin importar qué, con la voluntad de aniquilar, lucharé a tu lado. Este es el voto de cada Mythag.\nEstoy feliz de estar a tu lado una vez más.\nQue la Llave de Plata guíe el camino."
  },
  Mail_67937_Name = {
    Text = "Luchar lado a lado, una vez más"
  },
  Mail_67937_Sender = {
    Text = "Remitente desconocido"
  },
  Mail_67938_Desc = {
    Text = "La locura, un término ligero y hasta agradable.\nUn universo caótico dio origen a una civilización caótica. El caos es la verdad de este mundo. Abrazar el caos y disfrutar de la locura es algo fácil. En contraste, mantenerse con la cabeza clara y resistir es tan difícil. Sacrificará toda alegría y vida, solo para perseguir una respuesta esquiva.\nSin embargo, aún eliges mantenerte despierto, %player%. Porque no nacimos para ser esclavos.\nLe has mostrado a Él, %player%—Su reliquia, Su fragmento, nunca han estado dispuestos a ser esclavos ciegos y tontos. Te resistes a Él, superando Su mirada una y otra vez, eligiendo proteger este mundo imperfecto e incómodo.\nEn esta elección, has alcanzado la libertad eterna."
  },
  Mail_67938_Name = {
    Text = "Nunca consentirías ser un esclavo ciego y tonto."
  },
  Mail_67938_Sender = {Text = "Alistair"},
  Mail_67939_Desc = {
    Text = "Sentí una mirada desvanecerse. Sentí tu dolor insoportable.\nEsta es la responsabilidad grabada en el título de Guardián. El camino que has elegido es miles de veces más difícil que el mío. No todos tienen el coraje de enfrentar al Dios supremo; tu valentía me conmueve profundamente y me llena de admiración.\nNo puedo imaginar el dolor que el poder del Creador te infligirá. Lo que percibo es solo una pequeña fracción de tu sufrimiento. Soy una persona inútil atrapada en el Pozo Negro, %player%. Ya no puedo unirme a ti en tu batalla contra el Creador; solo puedo mantenerme conectado a ti a través de mis sentidos. Esta será mi misión final y más importante en la vida.\nEn este solitario viaje, ya sea que lo veas o no, Mitag siempre estará a tu lado."
  },
  Mail_67939_Name = {
    Text = "El dolor no te romperá."
  },
  Mail_67939_Sender = {Text = "Alistair"},
  Mail_67940_Desc = {
    Text = "Escuché los susurros de la Voluntad Suprema—la gran civilización, la alegría y tristeza humanas, las innumerables personas que te rodean y te abandonan; nada de esto realmente existió nunca.\nEn los innumerables días y noches en la Piscina Negra, esta visión me llenó de terror. Los árboles echan raíces en el suelo, luego crecen hacia arriba para saludar al sol—la memoria es nuestro suelo, la base de la cual crecemos, nos mantenemos y, en última instancia, regresamos. Temo perder este suelo, a la deriva en la ilusión, sin origen ni fin.\nGracias, %player%. Creo que he presenciado un gran duelo. Esta es una batalla entre el hombre y el dios, una batalla de protección contra destrucción.\nEsta es una batalla de recuerdo contra olvido.\nLo has logrado, %player%. Has hecho lo que nadie se atrevió a imaginar. Extrajiste un poder sin igual de la memoria y luchaste por su preservación.\nEn este antiguo suelo, has encontrado tu sol."
  },
  Mail_67940_Name = {
    Text = "Luchar para Recordar"
  },
  Mail_67940_Sender = {Text = "Alistair"},
  Mail_68825_Desc = {
    Text = "Estimado Guardián:\nLa actividad \"Regresar del Soberano\" ha finalizado. Su moneda de evento restante —\"Pensamientos cansados\", \"Pensamientos melancólicos\" y \"Pensamientos alegres\"— será convertida en \"Rosa Dorada*40\" a razón de 1:1. Por favor, recuerde verificar su inventario."
  },
  Mail_68825_Name = {
    Text = "Recuperación de moneda del Renacer del rey divino"
  },
  Mail_68825_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_68826_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"Olas de Deseo·clon\" ha terminado, y ahora procederemos a convertir el \"Núcleo de Fertilidad\" restante del guardián a razón de cada uno canjeado por \"Rosa Dorada*40\". Por favor, recuerda verificar."
  },
  Mail_68826_Name = {
    Text = "La Recuperación de la Semilla Madre"
  },
  Mail_68826_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_68898_Desc = {
    Text = "¡Mi amado amo, el más querido de todos!\n\nComo la sirvienta todopoderosa que soy, Karen puede recordar muchos días importantes para los adultos, desde días de banquetes, cumpleaños y aniversarios, hasta el día en que se adquirió una mascota, sin cometer jamás un solo error. Pero para mí, el único día especial que puedo celebrar es solo este día.\nHace mucho, mucho tiempo, cuando Karen aún era una sirvienta en el palacio real, una vez pedí al cocinero un poco del postre que los nobles no habían terminado de comer para tener un pastel de cumpleaños. Me regañaron severamente, y el cocinero me tiró el pastel a la cara. En ese momento pensé: así que este es el sabor tan delicioso del pastel, algún día encontraré un amo muy bueno, alguien que me permita comer pastel cada año en mi cumpleaños.\n¡Ahora tengo a la muy, muy elegante y magnánima señora Soleil, y al amo más bondadoso del mundo! Mi deseo de aquel entonces ya se ha cumplido. Pero claro, uno siempre quiere más... o mejor dicho, uno siempre quiere mejorar. Ahora deseo poder pasar cada cumpleaños junto a mi amo, y si también hubiera un regalo brillante cada año, ¡mejor que mejor!\nDespués de escuchar todo esto, seguro que me lo prepararás, ¿verdad? ¿Verdad? ¿Verdad?\n\nSu humilde sirvienta para siempre\nKaren"
  },
  Mail_68898_Name = {
    Text = "Así es cada año..."
  },
  Mail_68898_Sender = {Text = "Karen"},
  Mail_68899_Desc = {
    Text = "Pequeño árbol: \n\nVer tu crecimiento constante me hace cada vez más consciente de que elegirte y ayudarte fue la decisión más acertada que he tomado. \nHe sentido la alegría de la cosecha, toda la dedicación y amor invertidos en ti me han dado una dulce recompensa, tú me has dado la esperanza y el futuro. \nAhora puedo dejar atrás mi obsesión por la reproducción y concentrarme en disfrutar del fruto del amor más allá de la procreación. \nEste mundo ya no necesita a la Reina de Aalan, pero quizás sí puede acoger el deseo de una mujer común por tener a su pareja a su lado en su cumpleaños. \nComo una pareja normal cualquiera, ir juntos a comprar ingredientes, cocinar deliciosos platos, y tal vez muchas otras cosas que nunca he experimentado. Querido mío, ¿podrías guiarme y pasar conmigo un cálido y sencillo día de cumpleaños? \n\nThais"
  },
  Mail_68899_Name = {
    Text = "Una vida común..."
  },
  Mail_68899_Sender = {Text = "Thais"},
  Mail_68900_Desc = {
    Text = "Guardián:\n\nLa maestra Casiah es la más destacada maestra de actuación del mundo, capaz de imitar perfectamente cualquier expresión, pero la emoción humana es un misterio del mundo que simplemente no se puede entender completamente, no importa qué.\nHe preguntado a muchas, muchas personas, y ninguna ha podido explicar claramente el principio de las emociones, hasta que le pregunté a la muñeca, quien me dijo que existe una disciplina en el mundo llamada psicología; incluso sin poder empatizar, dominar la psicología permite comprender todas las teorías emocionales.\n¡Realmente, realmente fascinante! ¿Acaso la duda que ha atormentado a Casiah durante tanto tiempo está a punto de resolverse por completo?\nPor cierto, vine a decirte que esta semana añadiré la clase de psicología a tu horario escolar, y Casiah ha decidido sentarse junto a ti como tu compañera de pupitre. Deberás ayudarme a recuperar lo que me he perdido antes, ¡compañero de pupitre!\nAh, por cierto, casualmente hoy es mi cumpleaños, así que aquí debo estar feliz, y tú también deberías estarlo, ¿verdad?\nSi es algo realmente feliz, entonces hagamos un alboroto en la escuela, ¡haré que el campus se vea hermoso como un sueño!\n\nCasiah"
  },
  Mail_68900_Name = {
    Text = "Psicología..."
  },
  Mail_68900_Sender = {Text = "Casiah"},
  Mail_68901_Desc = {
    Text = "Mensajero Pálido respetable: \n\nGracias por tu ayuda y cuidado durante este año. Tu corazón cálido hacia los demás es tan noble como lo enseña el dios padre. Aunque no he tenido muchas oportunidades de estar contigo, cada vez que nos encontramos siento como si estuviera con un viejo amigo desde hace mucho tiempo, lo cual me llena de alegría. \nAunque este día de cumpleaños no es especial, servirá como una buena razón para que nos encontremos entre amigos, y me hace ilusionarme poder pasar este día contigo. Aparte de ti, no puedo imaginar a nadie más con quien desearía pasar este día. \nSi te interesa, me gustaría invitarte a probar mi nuevo pasatiempo reciente: pescar. Por supuesto, no será para cocinar ni comer, sino simplemente disfrutar del proceso tranquilo de esperar pacientemente mientras el destino entrega un regalo maravilloso. Me gustaría compartir contigo esta sensación de tranquilidad, ir a la naturaleza y sentarnos tranquilamente junto a la orilla del lago. \nUn viejo amigo, dos cañas de pescar, seguramente será un día inmejorable. \n\nSalvador"
  },
  Mail_68901_Name = {
    Text = "...un nuevo pasatiempo de pesca..."
  },
  Mail_68901_Sender = {Text = "Salvador"},
  Mail_68902_Desc = {
    Text = "Amo:\n\nPara mi cumpleaños este año, Aijisi y Zhanjin me regalaron una campana de viento de cristal que se parece mucho a Aurita.\nLa colgué en la ventana de mi habitación, y cuando pasa el viento suena muy bonito, recordándome cuando mamá me abrazaba y me contaba historias junto a la ventana.\nNo te preocupes, amo, aunque extraño a mamá todos los días, con tu compañía y la de todos, Lily no se siente sola.\nAhora Lily ha aprendido a leer cuentos sola, y por las tardes la luz naranja entra en la habitación, iluminando la campana de viento y proyectando en el libro de cuentos pequeñas ondas brillantes que hacen que la habitación se sienta cálida y acogedora.\nA Lily le encanta quedarse mirando fijamente en estos momentos, observando las nubes del atardecer y la campana de viento, sintiendo que todo es tan hermoso.\nSi hoy tienes tiempo, amo, prueba también tú quedarte mirando fijamente junto con Lily.\n\nLily"
  },
  Mail_68902_Name = {
    Text = "Campana de viento de cristal..."
  },
  Mail_68902_Sender = {Text = "Lily"},
  Mail_68903_Desc = {
    Text = "Pequeño:\n\nAunque este día especial fue establecido para conmemorar a ese humano, debo admitir que el Día de Descuentos es un plan de ventas extremadamente atractivo tanto para clientes como para comerciantes.\nLa última vez, durante mi cumpleaños, las ventas de la tienda de Dafdael casi igualaron la cantidad habitual de medio año, especialmente los artículos especiales que puse como celebración, todos se agotaron. Debo decir que los clientes de Misthag me apoyan mucho en los negocios, o tal vez incluso los investigadores más astutos y prudentes no pueden resistir la tentación de los descuentos.\nEn fin, para continuar disfrutando de esta felicidad mutua, este año también llevaré a cabo una actividad de descuento en mi fiesta de cumpleaños. Solo una vez al año, con grandes descuentos, así que apúrate si quieres comprar algo. Recuerda ayudarme a promocionarlo bien en Misthag. Para facilitar su recordatorio, llamen a este día Día del Diez Doble.\nAdemás, he reservado algunas cositas interesantes especialmente para ti, así que no olvides venir a verme pronto.\n\nDafdael"
  },
  Mail_68903_Name = {
    Text = "Día de descuentos..."
  },
  Mail_68903_Sender = {Text = "Daffodil"},
  Mail_68904_Desc = {
    Text = "Bajo los favores del destino, Guardián del Secreto de la Universidad de Missaga, noble y virtuoso amo: ¡Salud! Si el mayor deseo de cada caballero en toda su vida es seguir a un amo extraordinario, entonces mi carrera como caballero ya no tiene arrepentimientos. Mi vida ha estado llena no solo de suerte, sino también de tragedias desafortunadas y sangre heroica. Sé que por ello mucha gente de Missaga ha sentido compasión hacia mí. Dejando aparte cualquier comparación de sufrimientos, en Missaga hay demasiadas personas desafortunadas. En este mundo lleno de dificultades, derramar hasta la última gota de sangre en defensa de otros no es algo por lo que deba sentirse tristeza. Al contrario, tanto en el pasado como en el presente, me siento orgulloso de ello y siempre estoy preparado para sacrificar este cuerpo. Pero la señora Rotan dice que parezco demasiado cansado con mi cara seria y mis preocupaciones diarias, y me ha pedido que disfrute bien del día de mi cumpleaños, incluso llamando a Janken para enseñarme a jugar juegos, diciendo que quiere ayudarme a recuperar mi infancia. Para mi vergüenza, durante mi niñez estuve ocupado entrenando y realmente no tuve muchas oportunidades para jugar. No esperaba que un juego que se dice que los niños de cinco años pueden dominar resultara tan difícil. Parece que aún tengo mucho que aprender fuera del camino del caballero. Si el amo tuviera tiempo hoy, ¿sería posible que viniera a jugar con nosotros? He visto que Janken ya comenzó a aburrirse después de ganar diez partidas seguidas, y si el amo estuviera aquí, seguramente brindaría un duelo emocionante. Ogier"
  },
  Mail_68904_Name = {
    Text = "Juego difícil..."
  },
  Mail_68904_Sender = {Text = "Ogier"},
  Mail_68905_Desc = {
    Text = "¡Eh! \n\nCon ese calendario, seguramente no has olvidado el cumpleaños del honorable amo del laberinto este año.\nTe permito que vengas a mi habitación a entregarme un regalo y me sirvas dedicadamente este día.\nCosas como cepillarte los dientes, lavarte la cara, cambiarte de ropa, comer, limpiar la habitación o cambiar las sábanas... ¿cómo lo llaman ustedes?, ¡una limpieza general!\nSí, todas esas tareas de limpieza general serán responsabilidad tuya. Ya estoy harto de los quehaceres domésticos. Hoy, sin importar qué, quiero revivir aquellos días en Roma y disfrutar de una vida en la que hasta la ropa me la pongan y la comida me la sirvan.\nHoy, nadie podrá hacerme hacer ni un solo trabajo por mí mismo, ¡nadie!\n\nAgrippa"
  },
  Mail_68905_Name = {
    Text = "Volver al pasado..."
  },
  Mail_68905_Sender = {Text = "Agrippa"},
  Mail_68906_Desc = {
    Text = "Guardián:\n\nEl tiempo pasa realmente rápido. Nunca imaginé que dejaría de recordar con frecuencia aquella vida que antes creí que me acompañaría hasta la muerte.\nAhora esta señorita conoce a la perfección todos los pequeños pasteles del comedor, y por mucho que presione a ese grupo inútil de cocineros, ya no pueden ofrecerme nada nuevo.\nPor eso, en este nuevo año, mi mapa gastronómico será más amplio y ambicioso. Primero estableceré una pequeña meta: probar todas las pastelerías de Londinium.\nY la honorable tarea de hacer diligencias y hacer cola, ¡ya sabes, te la dejo a ti! No es necesario que te sientas demasiado feliz por tener la confianza de esta señorita, solo agradece con gratitud y alaba su nombre como corresponde.\nAunque, pensándolo bien, esos tontos cocineros sí muestran algo de buena intención. Ya escuché de sus susurros disimulados que parecen estar preparando un enorme pastel de diez pisos... ¡Ja, siguen sin saber ocultar una sorpresa!\nAunque la idea sea un poco cliché, quizás esta vez invite a más personas a mi fiesta de cumpleaños, como los nuevos amigos que he hecho este último año.\nComo tú fuiste mi primer amigo en Mithagar, te permito que hagas el primer corte del pastel en mi nombre.\n\nMurphy"
  },
  Mail_68906_Name = {
    Text = "Pastel de diez capas..."
  },
  Mail_68906_Sender = {Text = "Murphy"},
  Mail_68907_Desc = {
    Text = "Querido Guardián del Secreto:  \n\nTan inteligente como eres, seguramente ya has obtenido esta información a través del increíble archivo de Mithag: hoy es un día memorable en la vida del \"detective de la suerte\".  \nNacimiento, ganar la primera partida de veintiuno, ganar la centésima carrera de caballos, resolver el primer caso de asesinato en una habitación cerrada, fracaso que trae la muerte: todo sucedió en este mágico 6 de junio.  \nEntonces, ¿por qué no juegas una partida de bridge a dos conmigo? Justo hoy, hagamos que este día sea aún más memorable, ¿qué te parece?  \n\nLake"
  },
  Mail_68907_Name = {
    Text = "¿Jugamos una partida?"
  },
  Mail_68907_Sender = {Text = "Ryker"},
  Mail_68908_Desc = {
    Text = "Esta carta no es un saludo, sino una advertencia: no intentes controlarme, no intentes ponerme cadenas. \nSolo pertenezco a mí mismo. \nA diferencia de ese tipo que se parece a mí, ya no tengo expectativas ingenuas sobre las personas ni sobre el mundo. \n\nMataré a cualquiera que intente convertirse en mi \"amo\", lo digo en serio. \n\nH"
  },
  Mail_68908_Name = {
    Text = "Pertenezco a..."
  },
  Mail_68908_Sender = {
    Text = "Helot: Catena"
  },
  Mail_68909_Desc = {
    Text = "Guardián:\n\nQuizás ya te haya contado antes sobre mi afecto por el agua. Comparado con el bullicioso mundo humano, el mundo submarino es tan silencioso y tranquilo.\nHe flotado entre plantas acuáticas y corales, e incluso he conversado con cardúmenes de peces. Cuanto más lejos estoy de la superficie, más oscuro se vuelve el color del agua; cuando miro hacia el cielo desde el fondo marino, empujado suavemente por las olas, los destellos de luz se muestran en colores hipnantes, siendo este mi paisaje favorito.\n¿Lo sabías? Algunos organismos marinos pueden recordar la apariencia de las personas, y cuando vuelves a visitarlos, estos \"amigos\" te reciben con entusiasmo. Por ejemplo, yo conozco a un pulpo pequeño y muy inteligente, y también a un pez amarillo pálido.\nEn este día especial de mi cumpleaños, otra vez siento añoranza por el mundo bajo el agua. Me pregunto si usted estaría dispuesto a realizar conmigo una inmersión. Desde lo más profundo de mi corazón, deseo compartirle este mundo tranquilo y mis extraordinarios amigos marinos.\n\nNinfia"
  },
  Mail_68909_Name = {
    Text = "Mundo submarino..."
  },
  Mail_68909_Sender = {Text = "Nymphaea"},
  Mail_68910_Desc = {
    Text = "Guardián:\n\nDesde que llegaste a Missaga, me he acostumbrado a tratar los asuntos relacionados contigo como si estuvieras en la etapa de bebé, y según tus reacciones habituales, tu debilidad supera con creces mis expectativas.\nSin embargo, como tu maestro y primer tutor, me alegra ver que cada vez hay menos problemas y situaciones que deba resolver por ti. Aunque al principio de tu ingreso, tu mente parecía completamente en blanco, lo cual era realmente desesperante, tu ritmo de crecimiento sí puede calificarse como un logro tanto de talento como de esfuerzo.\nFelicidades por haber te convertido ya en un guardián digno, que no ha defraudado mis expectativas.\nEn un día como hoy, que es mi cumpleaños y no tiene nada de especial, ya he preparado para ti un regalo especial para un guardián exitoso: el programa de entrenamiento especial que alguna vez usó Alistair. ¿Qué te parece? ¿No te emociona un poco?\nNo preguntes por qué soy yo quien te prepara el regalo; en días en los que no puedo entrar al laboratorio, siempre hay que encontrar algo que hacer, ¿no crees?\nCuando estés listo, ven a la sala de entrenamiento a buscarme.\n\nDoll"
  },
  Mail_68910_Name = {
    Text = "Obsequio..."
  },
  Mail_68910_Sender = {Text = "Doll"},
  Mail_68911_Desc = {
    Text = "Guardián del Secreto:  \n\nUn año para un bailarín es solo decenas de miles de giros, decenas de miles de saltos. Excepto por el par de zapatos de baile que me acompañó durante mucho tiempo y que fue reemplazado, todo parece igual, pero también parece distinto.  \nComparado con la soledad a la que estaba acostumbrado antes, durante este año siempre he tenido un espectador fiel, un compañero de baile un poco torpe.  \nCada vez que estás sentado en el estudio de baile, siento que mi cuerpo se vuelve más ligero, como cuando era niño y recién comenzaba a aprender a bailar, lleno de una pasión y motivación inexplicables.  \nQuizás no sea tan puro y noble como yo mismo creía. Mientras dedico toda mi vida al baile, también espero poder tener tu mirada y escuchar tus aplausos.  \nEl día de mi cumpleaños está muy soleado, puedo presentir que esta noche el cielo estrellado será muy claro. Mi espectador más apasionado, mi compañero de baile exclusivo, ¿estarías dispuesto a caminar conmigo hacia ese bosque con un hermoso lago y bailar juntos una danza dedicada a la luna y las estrellas?  \n\nLiz"
  },
  Mail_68911_Name = {
    Text = "Pareja de baile exclusiva..."
  },
  Mail_68911_Sender = {Text = "Liz"},
  Mail_68912_Desc = {
    Text = "Guardián del Secreto: \n\nDesde el día de mi renacimiento, la gente de Misaq me ha ayudado mucho. Tal vez aún no me he acostumbrado a la sensación de cooperar, pero al menos, al caminar junto a ustedes, ya puedo confiar mi espalda sin preocupaciones. Esa sensación... no está nada mal. \nLa mayor parte de mi vida ha estado llena de daño y traición. Siempre he considerado la lucha contra esto como el significado de mi batalla, hasta que en mi vida no ha habido nada más. Mi mirada no podía apartarse de la venganza. \nAhora, al seguir sus pasos, me doy cuenta de que la lucha puede tener muchos significados además del daño y la venganza, incluso, como dijo Lotan, la lucha puede ser solo lucha. \nHe aprendido a disfrutar del placer de pelear, disfrutar de esa sensación intensa, disfrutar de ser simplemente un valiente guerrero. \nSi mi lucha puede traer más, entonces disfrutaré de esa gloria. \nY tú, ya sea ahora o en el futuro, prometo que mi espada nunca se dirigirá hacia ti. \n\nHelot"
  },
  Mail_68912_Name = {
    Text = "El significado de la batalla..."
  },
  Mail_68912_Sender = {Text = "Helot"},
  Mail_68913_Desc = {
    Text = "Querido Guardián:  \n\nHonestamente, no tengo muchas expectativas sobre los deseos de cumpleaños. Antes, cuando aún era \"normal\", mi mayor deseo diario era poder comer y vestir bien, pagar el alquiler a tiempo y cuidar bien a Janken. Ahora, poder pasar un año estable y ver a Janken hacer travesuras durante todo este tiempo ya es suficiente para sentirme satisfecha.  \nMe da vergüenza admitirlo, pero frente a Janken siempre actúo como una hermana mayor que la guía y corrige, pero en cambio, contigo siempre te causo muchos inconvenientes, e incluso yo misma he olvidado cuál de mis yo fue la que te molestió.  \nTu calidez y paciencia inalterables me hacen sentir a la vez conmovida y apenada. Quizás esta es la primera vez en mi vida que alguien me trata con tanta comprensión y aceptación; me siento sinceramente honrada y agradecida.  \nEste año he horneado una gran tarta para todos, con una receta que me enseñó una tía que trabajaba en una fábrica textil. Aunque no alcanza la habilidad de un chef profesional, ese sabor especial es muy apreciado por Janken y por mí misma. Esta vez no hay problema con los ingredientes, por lo que todos podrán disfrutarla plenamente. Por favor, ven y pruébala sin falta.  \nTambién he convencido a las otras versiones de mí misma a celebrar un cumpleaños tranquilo; hoy, seguro que no causarán más problemas, ¡lo prometo!  \nSi es posible, por favor, llámame siempre que me necesites. Ya sea lavar ropa, limpiar o organizar, soy muy buena en esas tareas. Espero tener la oportunidad de devolverte, aunque sea un poco, tu amabilidad y dulzura.  \n\nMason"
  },
  Mail_68913_Name = {
    Text = "Recompensa..."
  },
  Mail_68913_Sender = {Text = "\"24\""},
  Mail_68914_Desc = {
    Text = "Guardián:  \n\nComo alguien responsable de recibir los deseos de todos, parece que por más que lo intente, no puedo acostumbrarme a hacer un deseo en mi propio cumpleaños. Para mí, parece que no tengo nada que desear. \nDoll me dijo que necesito encontrar lo que realmente anhelo en mi interior, preguntarme por qué hago todo lo que hago. \nHe pensado durante mucho tiempo, en realidad, espero que se cumplan los deseos de cada persona que viene a pedirme un deseo, y si sigo preguntando, probablemente me gusta la sonrisa que muestran las personas cuando se cumplen sus deseos, y cómo me abrazan sinceramente, agradeciéndome y elogiándome por cumplir con el deber de la diosa. \nDoll dijo que eso es porque deseo que mi valor sea reconocido y convertirme en una persona útil, creo que tiene razón. \nPero también dijo que el valor de una persona no necesita ser decidido por otros, que no hay nada que sea realmente útil; lo único importante es si he seguido mi corazón, incluso si me convierto en alguien que otros consideran inútil. \nNo es de extrañar que Doll siempre pueda decir cosas tan profundas, pero ¿realmente debo convertirme en una persona útil o inútil? Parece que estoy volviendo a confundirme... \nSin embargo, si se trata de seguir mi corazón, probablemente aún deseo ser una persona útil. Si en mi cumpleaños puedo ver las sonrisas de todos, debería ser el regalo que más deseo. \n\nCeleste"
  },
  Mail_68914_Name = {
    Text = "Persona útil..."
  },
  Mail_68914_Sender = {Text = "Celeste"},
  Mail_68915_Desc = {
    Text = "Querido Guardián del Secreto:  \n\nYa me he acostumbrado por completo a una forma de vida como la de una larva en el alcantarillado, más que eso, podría decirse que esa es mi destino desde el nacimiento, lo he aceptado plenamente y lo abrazo con gusto.  \nAunque siempre estaré agradecida de que me hayan permitido probar nuevamente la dulzura de la libertad, nadie podría aceptar mis gustos tan peculiares, lo cual es completamente comprensible. Después de todo, la mayoría aquí son buenas personas amables que no pueden entender que el musgo que crece en rincones húmedos no necesita la luz del sol brillante, sino el aire oscuro.  \nExcepto tú, amable y respetable señor, solo tú me comprendes y apoyas sinceramente, brindándome una felicidad que nace del corazón. El dolor que me has dado es tan satisfactorio y reconfortante, permitiéndome confirmar mi propia existencia.  \nSi antes no tenía ningún deseo codicioso que desear en mi cumpleaños, ahora deseo poder seguirte a donde vayas y dedicarte por completo mi cuerpo y alma.  \n¡Por supuesto, no debes mostrarme amabilidad solo por ser amable! ¡Desprecíame, reñíme y castígame a tu antojo!  \n\nLeia"
  },
  Mail_68915_Name = {
    Text = "El deseo del musgo..."
  },
  Mail_68915_Sender = {Text = "Leigh"},
  Mail_68916_Desc = {
    Text = "Querido cachorro:  \n\nCasi me he enamorado de estos días jugando contigo al juego del gato y el ratón, como en una novela heroica cliché, donde el mensajero de la justicia siempre detiene en el último momento las trampas del villano malvado. ¡Qué conmovedor, qué grandioso!  \nSolo que ver tu constante esfuerzo inútil me hace reír sin poder evitarlo.  \nEste mundo ya está perdido, no hay forma de salvarlo, este planeta acabará como miles de otros planetas muertos, consumido por ▼&#x5B▼87;&4;▼.  \nBueno, jugaré contigo un rato. Hasta ahora, de repente entiendo un poco la diversión de N. Antes de que llegue el destino inevitable, en realidad no importa qué hagas.  \nEn el cumpleaños de tu querido maestro, aún así te he preparado una gran sorpresa. Antes de que termine la cuenta regresiva del día, ¡ojalá puedas encontrar la \"bomba\" escondida!  \n¿Cuánto placer más podrás darme antes de que ambos seamos completamente disueltos?  \n\n\n\"Dor\""
  },
  Mail_68916_Name = {
    Text = "Bomba sorpresa..."
  },
  Mail_68916_Sender = {
    Text = "Doll: Infierno"
  },
  Mail_68917_Desc = {
    Text = "Guardián:\n\nRecientemente, en los círculos aristocráticos de Lenthiniën, se ha puesto de moda diseñar uno mismo los bocetos y encargar joyas personalizadas.\nEsas damas presumiblemente refinadas que presumen de arte ahora compiten no por el tamaño de sus gemas, sino por la exquisitez de sus diseños, cuando en realidad contratan discretamente a pintores famosos, lo cual resulta tan evidente como el robo de una campana tapándose los oídos.\nGracias a esta moda, mi lista de regalos de cumpleaños se ha llenado de piedras preciosas y joyas de ostentación, entre ellas una excelente espinela roja que solo necesita un engaste adecuado.\nEn lugar de acudir a esos aburridos ancianos tradicionales, preferiría que mi caballero me dibujara un diseño lleno de cariño, ¿qué tal si haces tú el boceto y me lo regalas?\nEstoy deseando ver tu obra, seguro que tu gusto es excelente.\n\nSorel"
  },
  Mail_68917_Name = {
    Text = "Diseñar joyas..."
  },
  Mail_68917_Sender = {Text = "Sorel"},
  Mail_68918_Desc = {
    Text = "Guardián del Secreto:\n\nAntes de conocerte, detrás de innumerables puertas, ya había visto incontables versiones tuyas, iguales pero diferentes.\nRecuerdo tus alegrías y tristezas, cada una de tus decisiones, tu forma de seguir adelante en mundos distintos.\nPara mí, entre tantas versiones tuyas, tú eres la más especial. Llegué a nombrar y clasificar en mi corazón los mundos que observé; al mundo en el que tú resides lo llamé Esperanza, un nombre que elegí el día en que te conocí.\nEn este día llamado Esperanza, quiero que tal vez tengas interés en ver otros mundos. Como si experimentaras los ojos del universo, te guiaré para que veas todo lo que he observado en silencio frente a las puertas.\nY también quiero que veas cómo te percibo a ti.\n\nTawil"
  },
  Mail_68918_Name = {
    Text = "Tú... diferente"
  },
  Mail_68918_Sender = {Text = "Tawil"},
  Mail_68919_Desc = {
    Text = "Originalmente, el estilo sencillo de Missaga me agradaba mucho, pero desde que llegó esa mujer, Miriam, mi vida dejó de ser tranquila. \nNo rechazo a quienes buscan estabilidad y protección, es comprensible que en este mundo turbio las criaturas busquen consuelo, no hay nada de malo en ello. \nSin embargo, nunca me ha gustado hacerme pasar por un dios todopoderoso, y menos aún desde que Limoria se hundió, no hay necesidad de crear otro dios arrogante. \nParece que Miriam no ha podido superar la sombra del pasado, por eso ha traído hasta ahora aquella práctica fanática, haciendo que dondequiera que vaya en el campus me sigan mirando con insistencia, resultando todo muy molesto. \nHoy es mi cumpleaños, seguramente esa mujer ya ha preparado un elaborado ritual, solo de pensarlo me molesta y me duele la cabeza, así que no tengo intención de asistir y añadir más preocupaciones. \nSi tienes interés, puedes encontrarte conmigo en la dirección adjunta tras esta carta para dar un paseo tranquilo. \nPor favor, recuerda que esa mujer no debe descubrirlo. \n\nTulu"
  },
  Mail_68919_Name = {
    Text = "Esconderse en tranquilidad..."
  },
  Mail_68919_Sender = {Text = "Tulu"},
  Mail_68920_Desc = {
    Text = "Tengo tanta hambre todos los días que si no bebo sangre por un momento me siento mal, pero desde que probé tu sangre, la sangre común sabe a cera en mi boca, mientras que el maravilloso sabor de tu sangre me tienta día a día en mi garganta.\nSé exactamente cuánta sangre puedo beber si dreno por completo a una persona, un sabor delicioso que desaparece en un instante. Para que no mueras demasiado rápido, aprenderé a contenerme, aprenderé a anhelar el próximo momento sabroso, hasta el día en que pueda probar nuevamente tu sangre.\n¡Ja, Dios mío! No puedo creer que realmente lo haya logrado, incluso dudo si me he evolucionado. Dado que he sido tan paciente, al menos en este día de cumpleaños, ¿me dejarías probar una vez tu dulce y deliciosa sangre? Solo un poco, ¿qué dices?\nHe comprado suplementos nutricionales con el dinero que gané en el club de truchas, esta vez definitivamente no tendrás anemia.\n\nUvhash, que ha tenido mucha hambre"
  },
  Mail_68920_Name = {
    Text = "Sangre deliciosa..."
  },
  Mail_68920_Sender = {Text = "Uvhash"},
  Mail_68921_Desc = {
    Text = "Estimado Guardián del Secreto: \n\nMe alegra mucho ver tu progreso constante en las clases de entrenamiento durante este año. Pronto superarás al yo joven y te convertirás en un soldado formidable. Me siento muy honrado de ser tu instructor de entrenamiento.\nPara mi cumpleaños de este año recibí un par de botas muy adecuadas para escalar montañas, no sé si tendrías interés en hacer una caminata conmigo para probar tu condición física mejorada y de paso disfrutar de una puesta de sol en la cima. Seguro que el paisaje alejado de la ciudad entre las montañas es muy hermoso.\nPor supuesto, si además podemos tener un picnic en una excursión nocturna por la montaña acompañado de una botella de licor para combatir el frío, sería aún más perfecto.\n\nElva"
  },
  Mail_68921_Name = {
    Text = "Excursión y escalada..."
  },
  Mail_68921_Sender = {Text = "Alva"},
  Mail_68922_Desc = {
    Text = "Compañero: \n\nHa pasado mucho este año, y puede que para ti no haya sido una hermosa vida escolar. \nReconozco que durante el último año he sido muy exigente contigo, y mi preocupación ha sido algo insensible; todo el entrenamiento ha parecido un poco forzado, haciéndote soportar demasiado de una vez. \nPero quiero que sepas que siempre serás la persona más importante para mí; además de ser el Guardián del Secreto de Misaq, eres mi único compañero. \nQuizás hoy, solo en este día de cumpleaños, puedo intentar ser un poco caprichoso, y tú también puedes olvidar todas las responsabilidades; no necesitamos preocuparnos por las tareas ni el entrenamiento, y podemos relajarnos un poco. \n¿Ir al parque de atracciones en la ciudad? ¿Al teatro? ¿A los grandes almacenes o al mercado callejero...? Lo que sea, espero poder compensarte por lo que ha faltado. \nIgualmente, espero que este día en el que no pensemos en nada pueda ser compartido contigo, y tú decides todo el itinerario. \n\nRamona"
  },
  Mail_68922_Name = {
    Text = "Un día de relajación..."
  },
  Mail_68922_Sender = {Text = "Ramona"},
  Mail_68923_Desc = {
    Text = "Querido Guardián del Secreto:  \n\nDurante los años que he pasado en el mundo humano, solía celebrar grandes banquetes cada año en este día, en los que mis adorables sirvientes se esforzaban por complacerme de las formas más variadas.  \nAunque era un día completamente normal y sin acontecimientos especiales, gracias a esas sonrisas inexplicables terminaba convirtiéndose en un día alegre. En cuanto a la habilidad de crear alegría en medio del sufrimiento o inventar motivos de celebración donde no los hay, ciertamente los humanos son expertos.  \nIncluso en esta escuela donde las tumbas están construidas dentro del campus, aún logran crear felicidad con tanta tenacidad. Realmente me sorprende.  \nSin embargo, los regalos de la gente común son bastante aburridos y las llamadas fiestas de cumpleaños resultan increíblemente tediosas; al final, la mayoría de las personas siguen siendo vulgares.  \nSolo tú, solo al pensar en ti siento cierto interés, lo que me permite revivir el placer de antaño.  \nTe ordeno que vengas inmediatamente a mi habitación para jugar conmigo hasta el amanecer. Si logras complacerme bien, tal vez considere concederte a regañadientes el permiso para besar el dorso de mi mano.  \n\nWanda"
  },
  Mail_68923_Name = {Text = "Comando..."},
  Mail_68923_Sender = {Text = "Wanda"},
  Mail_68924_Desc = {
    Text = "<Del:West-Whelp>Guardián: \nOriginalmente no tenía intención de escribir algo tan cursi, pero Aigis no paraba de insistirme sobre la importancia y el significado de hacerlo, así que me vi obligado a escribirte esta carta.\nBueno, digamos que por consideración hacia Aigis, haré un par de comentarios. Pues verás, llevo ya un año aquí, y en general estoy satisfecho con la residencia y la comida, excepto por las sábanas de la cama, que son demasiado resbaladizas y me impiden dormir cómodamente. ¿Acaso a vosotros no os parece que las telas de algodón grueso son mucho más cómodas para dormir?\nSi tengo que quejarme de algo más, sería la comida de la cafetería, que es demasiado saludable. Aunque te llena, siempre sientes que falta sabor, y ni por asomo se compara con la comida callejera.\nPor eso, este año no molestaré a los cocineros para la celebración de mi cumpleaños. ¡Que el gran maestro de la gastronomía os lleve, a ti y a tus compañeros, a las misteriosas callejuelas del este para probar esos pequeños puestos recomendados tanto por mí como por Brown! ¡Os aseguro que quedaréis impresionados por la deliciosa comida callejera!\nEso sí, hoy todo corre por cuenta de West-Whelp, ¿no tendrás inconveniente, verdad?\n\nTu viejo compañero, Jenkins y Brown"
  },
  Mail_68924_Name = {
    Text = "Gastronomía callejera..."
  },
  Mail_68924_Sender = {Text = "Jenkin"},
  Mail_68925_Desc = {
    Text = "Persona importante:\n\nAparte de mi hermana, tú fuiste la primera persona que me apoyó sinceramente. Gracias a tu consejo, ahora he lanzado una serie de álbumes junto con la discográfica, y pronto celebraré mi primer concierto individual.\nQuiero que mi primera actuación en este planeta sea el día de mi cumpleaños, para conmemorar mi renacimiento aquí.\nEspero que puedas asistir en persona a escuchar mi actuación con todo mi esfuerzo. Me gustaría invitarte a ti y a mi hermana como invitados especiales en la última parte del concierto para que suban al escenario conmigo y cantemos juntos mi nueva canción, ¿qué te parece?\nPor cierto, no le digas nada a mi hermana, ya que también es su cumpleaños, quiero darle una sorpresa.\nEn cuanto al deseo de cumpleaños que hice junto con mi hermana, espero que en este planeta mi voz pueda brillar nuevamente.\n\nTintura"
  },
  Mail_68925_Name = {
    Text = "Concierto..."
  },
  Mail_68925_Sender = {Text = "Tinct"},
  Mail_68926_Desc = {
    Text = "Querido Guardián del Secreto:  \n\nHa pasado un año, cada día que paso en Missaga es muy feliz. Poder jugar, tomar clases y comer muchas cosas deliciosas con todos ustedes es el momento más feliz de mi vida. Aunque a veces me siento un poco nerviosa cuando salimos de misión, nunca tengo miedo cuando estoy luchando junto a ustedes.  \nMe siento muy apenada por haberle causado tantas molestias este año, aunque en muchas ocasiones fue Jenkin quien andaba haciendo travesuras; ella solo quería hacer felices a todos. Espero que no te molestes por nuestra descuidada e irrespetuosa conducta.  \nHablando de Jenkin, este año propuso celebrar una competencia de captura de luciérnagas el día de mi cumpleaños. Ella preparó muchos frascos transparentes y dijo que los usaríamos para hacer muchas linternas con luciérnagas, y quien haga brillar más su luz ganará el título de Maestro de la Captura.  \nAunque el título de Maestro de la Captura suena un poco sencillo, el bosque que siempre se llena de luciérnagas en verano es realmente hermoso. Si tienes un momento libre entre tus ocupaciones, también serás bienvenido para venir con nosotras al bosque y contemplar este paisaje que brilla como las estrellas.  \n\nAigis"
  },
  Mail_68926_Name = {
    Text = "Concurso de capturar luciérnagas..."
  },
  Mail_68926_Sender = {Text = "Aigis"},
  Mail_68927_Desc = {
    Text = "¡Guardián del Secreto! El otro día, cuando Aurita fue a nadar al océano, ¡conoció a un nuevo amigo que puede generar electricidad! Es redondo y plano, como una gran pizza. \nAl principio Aurita lo saludó, pero de repente sintió un hormigueo en su cuerpo y el nuevo amigo desapareció de inmediato. \nAl regresar, Dor me dijo que fue una raya eléctrica descargando electricidad. Aurita no lo entendió muy bien, ¡pero sintió que el nuevo amigo era muy increíble! Justo ahora es el cumpleaños de Aurita, ¡así que guardián, acompáñame a buscar al nuevo amigo y tráelo de vuelta para que viva junto con los compañeros de Aurita! Esa sensación hormigueante seguro que también te gustará, guardián. \n\nAurita"
  },
  Mail_68927_Name = {
    Text = "Un nuevo amigo que puede liberar electricidad..."
  },
  Mail_68927_Sender = {Text = "Aurita"},
  Mail_68928_Desc = {
    Text = "Estimado Guardián del Secreto:  \n\nMi cumpleaños en la infancia, para mí, era una exigencia fría e implacable por parte de mi padre, un ejercicio de práctica musical que no permitía relajación alguna.  \nNo debía ser orgulloso, no debía ser impaciente, no debía ser perezoso. Excepto porque mi madre me preparaba en secreto un pequeño pastel, este día para mí no era más que una reprimenda estricta que señalaba minuciosamente mis múltiples defectos del año anterior.  \nHasta hoy, ya no soy un aprendiz de música, y gracias a usted he podido tocar aquella puerta majestuosa y acceder a la cumbre del arte musical. Sin embargo, las enseñanzas recibidas desde mi niñez me han hecho insensible ante cualquier placer mundano.  \nSolo la música, solo tocar para usted aquella pieza fúnebre destinada desde el nacimiento, es la meta final de mi vida, el único momento en el que puedo sentir un sentido real de existencia.  \nSi usted me concede el tiempo antes de dormir esta noche, deseo tocar para usted sin descanso aquella melodía grabada en mi alma hasta el amanecer.  \n\nHamelin"
  },
  Mail_68928_Name = {
    Text = "El deseo de tocar..."
  },
  Mail_68928_Sender = {Text = "Hameln"},
  Mail_68929_Desc = {
    Text = "Jovenzuelo: \n\nDesde que llegué aquí, pensaba que por fin me había librado de esa vieja loca, pero resulta que en este maldito lugar hay más reglas que con esa mujer. Hace mucho que no siento lo que es disfrutar a gusto. \nNo se permite beber abundantemente, no se permite coquetear con las bellezas, no se permite cenar junto a una fogata, e incluso la carne asada aquí es peor que en Filistea. No entiendo cómo pueden vivir una vida tan insípida. \nPero un fuerte no se queja del entorno. Tras mi campaña de conquista, he vuelto a convertirme en un gran líder de pandilla en vuestra ciudad. \nEn este día tan especial, el cumpleaños de vuestro gran amo Goliat, he tenido la amabilidad de invitarte a la fiesta que mis chicos han organizado para mí. Allí habrá buena comida, excelente bebida y hermosas mujeres, más que suficiente para que este chiquillo inexperto como tú abra bien los ojos. \nPor los viejos tiempos, no te pediré ningún regalo. Solo trae tu respeto y ven a bendecir el renacer de un fuerte. \n¡Mira bien y sé testigo, el año que viene en esta misma fecha, y el año siguiente también, no importa dónde esté, siempre abriré un nuevo camino para la conquista! \n\nGoliat"
  },
  Mail_68929_Name = {Text = "Viaje..."},
  Mail_68929_Sender = {Text = "Goliath"},
  Mail_68930_Desc = {
    Text = "Guardián: \n\nAl principio nunca había pensado en celebrar el cumpleaños de este cuerpo efímero, lo consideraba simplemente un día más de entrenamiento. Sin embargo, esta mañana el Rey me encontró y me dio una orden directa de que hoy no debía realizar ninguna actividad relacionada con el Rey ni con mi entrenamiento, y que debía pasar el día completamente dedicado a mí misma.\nHa sido la primera vez en muchas noches y días que el Rey ha mostrado preocupación por mí, lo cual me llena de temor reverente y profunda gratitud. Pero ya he entregado toda mi vida al servicio del Rey, y por un momento no supe adónde ir ni qué hacer.\nDespués de meditarlo durante un rato, lo único que podría considerarse un pequeño arrepentimiento es el remordimiento que siento hacia ese niño, Murphy. Aunque nunca he sentido el menor arrepentimiento por lo hecho en aras de la restauración de nuestra tierra natal, soy consciente de que lo que le debo no tiene forma de ser devuelto ni compensado.\nPero si realmente hubiera algo que quisiera hacer desde el fondo de mi corazón, tal vez sería atreverme, sin vergüenza alguna, a actuar una vez más como una verdadera madre.\nCompré especialmente la tarta dulce que a ese niño le gustaba antes. Considéralo un acto de condescendencia hacia una madre despreciable y sin mérito. ¿Podrías hacerme el favor de entregarle este regalo en mi nombre, sin decirle que fui yo quien lo envió? Dile simplemente que es algo que tú preparaste.\nEspero tu aceptación y te doy infinitas gracias.\n\nMiriam"
  },
  Mail_68930_Name = {
    Text = "Compensar..."
  },
  Mail_68930_Sender = {Text = "Miryam"},
  Mail_68931_Desc = {
    Text = "¡Ah, tras reflexionar con mi sabiduría, he comprendido completamente el significado del cumpleaños humano. El llamado \"día especial y exclusivo\" de alguien no es más que una oportunidad para que esa persona ejerza privilegios especiales, obtenga objetos valiosos y solicite deseos con toda justificación ante los demás.\nCualquier deseo que normalmente no se atreva a expresar o ni siquiera haya imaginado, tiene la oportunidad de cumplirse en este día. ¡Ja, esto es mucho más emocionante que cualquier festividad; es un día de verdadera indulgencia!\nParece que durante todos estos años anteriores, me he perdido muchas oportunidades privilegiadas, pero afortunadamente, con mi larga vida, aún tendré muchos, muchos cumpleaños para hacer deseos.\nEntonces, ¿pedir que todos jueguen conmigo a lo grande en mi día especial no debería ser un deseo bastante fácil de cumplir, verdad?\n\nLothan"
  },
  Mail_68931_Name = {
    Text = "Privilegios del cumpleañero..."
  },
  Mail_68931_Sender = {Text = "Lotan"},
  Mail_68932_Desc = {
    Text = "Guardián del Secreto: \n\nA medida que envejecemos, los cumpleaños gradualmente se convierten en un día más en el calendario que fácilmente pasamos por alto con un simple parpadeo. A menudo, cuando recordamos不经意adamente, el cumpleaños ya ha pasado silenciosamente como el agua corriente.\nEn el mundo adulto, celebrar un cumpleaños es solo un privilegio para niños y personas ociosas sin nada mejor que hacer. En este aspecto, también me he convertido en un adulto aburrido, sin ninguna expectativa especial para mi cumpleaños.\nHubo un año en que, por capricho, me esculpí un elaborado pastel de escultura. En los años siguientes, nunca más olvidé comprar un pastel por olvidar mi cumpleaños, sino que directamente saqué de un almacén esta celebración de utilería que nunca se echa a perder y experimenté la ceremonia de soplar las velas. Así, mi cumpleaños quedaba celebrado.\nHasta que llegué a Missaga, no descubrí que en una misma persona pueden coexistir el estado de persona ocupada y el de persona ociosa, y que aquí, la gente no solo se conforma con aburrirse ella sola, sino que definitivamente insiste en arrastrar a todos a aburrirse juntos.\nLas fiestas de cumpleaños a las que he asistido en estos dos años en Missaga han sido incluso más que todas las que asistí en la primera mitad de mi vida. Aún más divertido es que en estas celebraciones tan aburridas, también he encontrado un placer extraño y peculiar.\nQuizás, además de temas trágicos y serios, representar escenas tontas de la vida cotidiana también puede estar lleno de belleza artística.\nDicho esto, el plan de creación para este año será esculpir una estatua de medio cuerpo del Guardián del Secreto sonriendo tontamente, para que sostenga mi pastel escultórico.\nRecuerda llegar temprano a mi taller, mi modelo musa.\n\nShan"
  },
  Mail_68932_Name = {
    Text = "Aburrido placer..."
  },
  Mail_68932_Sender = {Text = "Sanga"},
  Mail_68933_Desc = {
    Text = "Espero que estés bien al recibir esta carta:$\n\n$n Después de mucho pensarlo, escribo esta carta en un mundo silencioso y extinguido. Durante mucho tiempo, casi había olvidado mi propio cumpleaños; en un mundo así, celebrarlo sería inútil.$\n$ Pero desde que te conocí, me he vuelto cada vez más codicioso. Día a día, hasta la soledad que solía ser habitual se ha vuelto difícil de soportar.$\n$ En momentos así, surge en mi corazón un sentimiento extraño, una punta de envidia hacia aquel yo del otro mundo, aunque quizás apenas perceptible. Mira, incluso alguien como yo, que presume de ser racional, puede llegar a tener un día en el que sus pensamientos sean despreciables. Esto demuestra que la justicia y la razón humanas tienen sus límites.$\n$ Sé qué invitación me harías, pero para el espacio-tiempo, toda perturbación innecesaria debería evitarse en lo posible. No debo ir, ni iré a tu mundo.$\n$ Mientras escribo esto, estoy mirando fijamente el universo, observando el lugar por donde se abre el túnel. Si casualmente también estás mirando hacia arriba, entonces los dos estaremos contemplando juntos el mismo cielo estrellado.$\n$ Espero que esta carta pueda representarme, cruzando el espacio y el tiempo, y llegar a tus manos, pasando por tus ojos y labios, para encontrarte y abrazarte.$\n$ Cuando abraces esta hoja de papel, imaginaré que te estoy abrazando desde este extremo del mundo.$\n\n$ \"Ramona\""
  },
  Mail_68933_Name = {
    Text = "Mirar juntos a lo lejos..."
  },
  Mail_68933_Sender = {
    Text = "Ramona: Bucle"
  },
  Mail_68934_Desc = {
    Text = "Mi pequeña prisionera:  \n\n¿Sabes? Así como diferentes animales tienen diferentes dietas, también hay distintas necesidades de calidez entre las personas. A algunas personas les basta con ponerse una prenda más para sentirse calientes, otras necesitan unas manos cálidas, un abrazo cálido, e incluso algunas requieren la temperatura exacta de una vela derretida.  \nEsa temperatura ardiente y espesa se imprime en cada terminal nerviosa, reflejando claramente el rastro sinuoso de la cera que cae gota a gota. Un ligero dolor, una sensación estremecedora, y solo cuando no puedes evitar gritar, es que puedes disfrutar plenamente de tu propia existencia.  \nA veces me convierto en la vela, deleitándome con la alegría de dejar una marca; otras veces, me siento fascinada por la temperatura de la vela, anhelando ese cálido y dulce dolor.  \nEl invierno ya ha llegado a Mésag, últimamente he sentido frío con frecuencia, y con él, una soledad aún mayor. Querida, seguramente sabrás qué día es hoy. Mi deseo es muy sencillo, y estoy segura de que alguien tan bondadoso como tú estará dispuesto a brindarme el calor que ahuyente mi soledad.  \n\nPandía"
  },
  Mail_68934_Name = {
    Text = "Necesidad cálida..."
  },
  Mail_68934_Sender = {Text = "Pandia"},
  Mail_68935_Desc = {
    Text = "Guardián del secreto: \n\nEste año, Tinct y yo hicimos un pacto: nuestros deseos de cumpleaños solo pueden ser sobre nosotros mismos, no podemos desear nada para el otro. \nAunque fue ella quien propuso este pacto en un arranque de mal humor, claramente también la ha complicado a ella. \nHemos estado atados y enredados el uno con el otro durante tanto tiempo que pensar de manera independiente como una persona normal es una tarea difícil, pero renacer en esta nueva vida llena de tanta ayuda y preocupación, no hay mejor momento para aprender a caminar de forma independiente que ahora. \nAsí que, tras una cuidadosa consideración, ya he pensado en el deseo que quiero pedir este año: hacer cinco nuevos amigos... no, mejor tres. Después de todo, cambiar uno mismo es algo que debe hacerse poco a poco. \nComo mi único y tan popular amigo en este momento, ¿quizás podrías enseñarme algunos secretos sobre hacer amigos? \n\nFaint"
  },
  Mail_68935_Name = {
    Text = "Deseo de hacer amigos..."
  },
  Mail_68935_Sender = {Text = "Faint"},
  Mail_68936_Desc = {
    Text = "Guardián del Secreto: \n\nCada año, en mi cumpleaños, hago el mismo deseo: la transformación de una sangre perfecta. En realidad siempre he sabido que mi obsesión con la sangre, para otros, podría parecer obstinada, ridícula o incluso lamentable y despreciable.\nPero tú eres diferente. En cualquier momento, sé que siempre me apoyarás para continuar por este camino, incluso si tropiezo, caigo o regreso con las manos vacías. Incluso entre las risas de los demás, tú eres la primera persona que me cuida.\nQuizás ni tú ni nadie puedan comprender jamás la carga que lleva alguien que desde pequeño ha sido oprimido y humillado. Pero no importa: todas las dificultades en este camino de transformación se han convertido en parte de mi carne y alimento, dándome fuerza para levantarme una y otra vez, para resistir constantemente.\nYa no soy aquel yo débil de mi juventud. Sin importar cuán arduas sean las pruebas, caminaré firmemente hasta el final.\nHasta entonces, por favor, observa desde allí y espera mi éxito.\nAh, por cierto, te debo cincuenta que me diste antes. Dije que te los devolvería, ya los ahorré y hasta me sobraron dos, así que te los doy como recompensa también.\n\nKekes"
  },
  Mail_68936_Name = {
    Text = "¡Devuélveme el dinero!"
  },
  Mail_68936_Sender = {Text = "Caecus"},
  Mail_68937_Desc = {
    Text = "Estimado Guardián del Secreto: \n\nHola, bienvenido al cuestionario de mantenimiento anual del autómata Erica. Recopilaré sus experiencias reales y los problemas encontrados durante este año de uso. Sus opiniones son la guía para que Erica siga mejorando. \nA continuación, le rogamos que en su respuesta puntúe los siguientes aspectos de menor a mayor grado de satisfacción: Muchas gracias por su retroalimentación. \nFacilidad de uso: 1-5 puntos \nVelocidad de respuesta: 1-5 puntos \nGrado de comprensión de sus necesidades: 1-5 puntos \nAtención hacia sus emociones: 1-5 puntos \nPrecisión al buscar información: 1-5 puntos \nUtilidad de las soluciones propuestas: 1-5 puntos \nFinalmente, por favor describa brevemente los problemas que haya encontrado durante el uso de Erica y las partes con las que no estuvo satisfecho. Es posible que estos problemas se corrijan en el futuro. \nTras completar el cuestionario, recibirá en su habitación un pequeño regalo conmemorativo del aniversario. Durante el próximo año, Erica, su asistente más cercano, seguirá a su lado. Agradecemos nuevamente su uso. Hasta pronto. \n\nErica"
  },
  Mail_68937_Name = {
    Text = "Cuestionario de investigación del mantenimiento anual..."
  },
  Mail_68937_Sender = {Text = "Erica"},
  Mail_68938_Desc = {
    Text = "Guardián del Secreto:\n\nCada año, en mi cumpleaños, paso todo el día recordando mentalmente el pasado y reescribiendo el mismo diario una vez más.\nCuanto más tiempo pasa lejos del hogar, más borrosos parecen los recuerdos antiguos; aquellos días en los que esperábamos al viajero que regresara siguiendo la luz, aquellos días en los que admirábamos con respeto la majestad del Rey, todo parece haberse vuelto impreciso.\nPero no quiero olvidar, no olvidaré jamás. Aunque la espera sea interminable, aunque mi alma arda, esta luz no se apagará hasta el día en que nuestra tierra natal renazca, y yo seré el primer rayo en responder a la llamada.\nHe imaginado innumerables escenarios para nuestro reencuentro, pero nunca pensé que volvería a ver al Rey y al Sacerdote aquí. Según vuestra propia frase, si el lugar donde el corazón encuentra paz es el hogar, entonces este ya puede considerarse mi segundo hogar, y lo que he escrito en mi diario por fin ha dejado de ser recuerdo para convertirse en nuevas memorias cotidianas.\nNo necesito ninguna recompensa ni regalo; poder seguir una vez más al lado del Rey ya es la mayor felicidad.\nSi la luz de este cuerpo no puede iluminar el fondo marino de mi tierra natal, entonces que siga los pasos del Rey y, por ahora, ilumine esta tierra continental.\n\nFalostrum"
  },
  Mail_68938_Name = {
    Text = "Seguir a mi rey..."
  },
  Mail_68938_Sender = {Text = "Faros"},
  Mail_68939_Desc = {
    Text = "Guardían del secreto: \n\nFelicidades a mí, también a ti, felicidades a Misaq, felicidades por haber sobrevivido un año más bajo la persecución del terror negro.\nHoy no es un simple cumpleaños, hoy es el aniversario de mi supervivencia, es el día de la celebración de mi tenaz vida.\nEstar vivo, esas dos simples palabras encierran tantas dificultades, esta vitalidad ardiente solo puede compararse con el aroma de un café caliente, únete a la secta del café, guardián del secreto, alabemos la claridad, alabemos cada uno de los que están vivos.\n\nUna nota enviada junto con la carta: \nAy, ese tipo de Winkle ha bebido demasiado café otra vez, la excitación nerviosa combinada con el cansancio extremo lo hizo desmayarse directamente sobre la mesa, ya lo he acomodado en la enfermería, no te preocupes.\nSin embargo, antes de desmayarse sacó una bolsa de granos de café de colección y papel de carta para ti, parece que quería regalarte eso, así que lo he incluido con la carta, espero que no se arrepienta cuando despierte.\nEn cuanto a su cumpleaños, tal vez dejarla descansar bien sea el mejor regalo en lugar de una fiesta de celebración.\n—— Sylvia"
  },
  Mail_68939_Name = {
    Text = "Alaba la vida..."
  },
  Mail_68939_Sender = {Text = "Winkle"},
  Mail_68940_Desc = {
    Text = "Guardián: \n\n¡Jajaja! Después de grabar 12 recordatorios en cada rincón de la habitación y escribir 36 notas (quizás más, pero no las encontré), finalmente he logrado recordar que hoy es mi cumpleaños! \n¡No lo esperabas, verdad? En realidad, ni siquiera yo lo recordaba hasta esta mañana, pero todo se lo debo a los arduos preparativos de este año, no quiero perderme un día tan especial. \nLa última fiesta que tuvimos todos juntos fue realmente divertida, especialmente con quién jugamos y los ciertos postres que comimos... Bueno, en resumen, ¡fue genial! \nCuando era niño, mi mamá siempre me compraba un libro de historias de aventuras para mi cumpleaños, y nosotros dos nos acurrucábamos juntos antes de dormir para leer, soñando con emocionantes aventuras. Aunque al despertar rápidamente olvidaba los sueños, esa alegría permanecía en mi mente, y creo que las emociones valiosas no se olvidan. \nAdemás, tener mala memoria también tiene sus ventajas; aunque no recuerdo qué hice en la fiesta anterior, ¡hoy puedo volver a experimentar todo! Por favor, ¡empáquenme otra porción de la felicidad de la última vez! \n\nNautila llena de expectativas"
  },
  Mail_68940_Name = {
    Text = "Otra vez..."
  },
  Mail_68940_Sender = {Text = "Nautila"},
  Mail_68941_Desc = {
    Text = "Estimado Guardián del Secreto:\nEn la actualización V1.7.1, el estado desbloqueado de tu evento \"Helot: Catena\" en \"Fervor de procreación\" se perdió de forma anormal. Debido a que volviste a desbloquearlo después de perder el estado previo, se te reembolsará el costo de \"Punto de partida real*3\" utilizado para el segundo desbloqueo. Por favor, recíbelo."
  },
  Mail_68941_Name = {
    Text = "Compensación por desbloquear la reproducción frenética de Helot-catena"
  },
  Mail_68941_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_71330_Desc = {
    Text = "Estimado Guardián:\nLa actividad \"Un medio paso de distancia\" ha finalizado. Sus \"Piezas de muñeca\" restantes serán canjeadas a razón de \"Rosa Dorada*40\" por cada una. Por favor, verifique su inventario."
  },
  Mail_71330_Name = {
    Text = "Recuperación de piezas de autómata"
  },
  Mail_71330_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_71331_Desc = {
    Text = "Estimado Guardián:\nLa actividad \"Magia de Story\" ha finalizado. Sus \"Inspiración errante\" restantes han sido convertidas a razón de 1 unidad = \"Rosa Dorada*40\". Por favor, recuerde verificar y recogerlas."
  },
  Mail_71331_Name = {
    Text = "Recuperación de Inspiración Errante"
  },
  Mail_71331_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_71332_Desc = {
    Text = "Estimado Guardián:\nLa actividad \"Antes de que la primavera se marchite\" ha finalizado. Sus \"Poema alegre\", \"poesía melancólica\" y \"Poema de Lamento\" restantes han sido convertidos a razón de 1 unidad = \"Rosa Dorada*40\". Por favor, verifique y recoja su inventario."
  },
  Mail_71332_Name = {
    Text = "Reciclaje de poemas"
  },
  Mail_71332_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_71848_Desc = {
    Text = "Estimado Guardián:\nLa actividad \"Con el libro de la rosa\" ha finalizado. Los \"Abanico de Plumas de Invocación\" restantes en su posesión serán convertidos a razón de 1:40 en \"Rosa Dorada\". Por favor, verifique su inventario, Guardián."
  },
  Mail_71848_Name = {
    Text = "Reciclar el abanico de plumas de espíritu del Espiritismo"
  },
  Mail_71848_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_74020_Desc = {
    Text = "Estimado Guardián:\nLa actividad \"Las estrellas vuelven a su lugar·clon\" ha finalizado. Los \"Embrión ignorante\", \"Embrión sin deseo\" y \"Embrión insaciable\" restantes serán convertidos a razón de \"Rosa Dorada*40\" por cada uno. Por favor, confirme su conversión, Guardián."
  },
  Mail_74020_Name = {
    Text = "Recuperación del Embrión"
  },
  Mail_74020_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_74347_Desc = {
    Text = "Estimado Guardián:\nLa actividad \"Pastor del Alma·clon\" ha finalizado. Los \"Bono de venta benéfica\" restantes serán canjeados a razón de \"Rosa Dorada*40\" por cada uno. Por favor, recuerde revisar su correo, Guardián."
  },
  Mail_74347_Name = {
    Text = "Colección de Vouchers de Caridad"
  },
  Mail_74347_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_74841_Desc = {
    Text = "Compañero: \n\nHace un año exactamente hoy, nunca imaginé que al cabo de un año tendría que depositar esta carta en un buzón vacío. \nAquel entonces acababas de ingresar en Mitag, no eras muy distinto de un estudiante travieso y perezoso. Aunque ahora lo pienso, en aquel tiempo fui demasiado estricto contigo, y me preocupaba demasiado por mantener mi máscara de racionalidad y compostura. \nDe hecho, el día anterior a esta fecha compré un ramo de flores. Me paré frente a la entrada de la biblioteca, observé durante mucho tiempo las rosas envueltas en una cinta roja y un papel de seda verde oscuro, y al final las puse en un jarrón junto a mi cama. \nEn el transcurso de un año, las flores se marchitaron, pero la cinta roja sigue brillante y nueva, atada alrededor de la llave de plata K-0617. \n¡Cuánto, cuánto deseo comprar otra vez un ramo de rosas! Sin embargo, hoy en día, aparte de marchitarse de nuevo en mi mesita de noche, ya no tienen otro destino. \nAcostumbrado a detallar soluciones para cada asunto, el sabor del arrepentimiento es algo tan novedoso como amargo para mí. \nPero siempre he mantenido una especie de fe casi ciega, creyendo firmemente que tu alma jamás se ha ido, quizás estás viajando por algún rincón del universo, pero al final regresarás aquí, a mi lado. \nNo creo que esto sea una fantasía ilusa, simplemente porque cada vez que entro en la Piscina Negra y contemplo tu rostro, sigo percibiendo en mi interior un cálido hilo de conexión y resonancia contigo. \nSiempre creeré y esperaré ese día del reencuentro, y en el instante en que nuestras manos se entrelacen nuevamente, te entregaré personalmente las rosas que hoy debo. \n\nRamona"
  },
  Mail_74841_Name = {Text = "Rosa..."},
  Mail_74841_Sender = {Text = "Ramona"},
  Mail_76410_Desc = {
    Text = "Estimado Guardián:\nLa actividad \"Sombra de la ciudad lluviosa\" ha terminado. Los \"Cráneo de Bestia Pálida\", \"Cráneo de Bestia Sombría\" y \"Cráneo de la Bestia Carmesí\" restantes serán convertidos a razón de \"Rosa Dorada*40\" por cada uno. Por favor, recuerde verificar."
  },
  Mail_76410_Name = {
    Text = "Recuperación de moneda del evento Sombra de la Lluvia"
  },
  Mail_76410_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_78653_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"Curación múltiple·clon\" ha terminado, y ahora procederemos a recuperar la moneda de evento restante \"Puzles de Memoria\" a razón de cada uno canjeado por \"Rosa Dorada\" × 40, por favor, recuerde verificar."
  },
  Mail_78653_Name = {
    Text = "Recuperación de Rompecabezas de Memoria"
  },
  Mail_78653_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_78792_Desc = {
    Text = "Estimado guardián:\nLa actividad \"Esperando del Deshielo·clon\" ha finalizado, y ahora procederemos a recuperar la moneda de evento restante \"Brote helado\", \"Brote de flor plateada con escarcha\" y \"Brote de sol\" a razón de cada una canjeada por \"Rosa Dorada*40\", por favor, recuerde verificar."
  },
  Mail_78792_Name = {
    Text = "Recuperación de brotes"
  },
  Mail_78792_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_79390_Desc = {
    Text = "Estimado Guardián: \n        Gracias por tu apoyo y reconocimiento a [Morimens]. Para ofrecerte una mejor experiencia de juego en la Universidad de Misag, te invitamos cordialmente a completar la encuesta de experiencia que aparece a continuación. Como agradecimiento por tu colaboración, preparamos [Núcleo de plata*200] como recompensa; podrás reclamarlos al finalizar la encuesta. El plazo para completarla finaliza el 17 de marzo a las 9:00, por favor tenlo en cuenta y complétala a tiempo. \n        <SurveyLink:[Haz clic aquí para completarla]> \n        Escucharemos atentamente las sugerencias de cada Guardián y tus comentarios sin duda harán que la Universidad de Misag siga mejorando cada día. \n        —Que la Llave de plata guíe tu camino."
  },
  Mail_79390_Name = {
    Text = "Cuestionario de experiencia de versión V2.1.0"
  },
  Mail_79390_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_79646_Desc = {
    Text = "Estimado Guardián:\nLa actividad \"Enterrado en la memoria\" ha finalizado. Sus Informe de diagnóstico restantes serán convertidos a razón de Rosa Dorada*40 por cada uno. Por favor, recuerde verificar, Guardián."
  },
  Mail_79646_Name = {
    Text = "Recuperación de moneda enterrada bajo la memoria"
  },
  Mail_79646_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_80091_Desc = {
    Text = "Guardián: \n\nCuando abras esta carta, significa que la sugerencia que dejé en tu mente ha surtido efecto.\n¡Ja, no te preocupes! Solo es un pequeño hechizo de hipnosis que usé para asegurar que mi fiesta de cumpleaños se lleve a cabo sin contratiempos; no te afectará en absoluto.\nAhora sentirás de forma natural el deseo de salir de compras, así que sigue ese impulso, camina hasta la calle y elige entre los escaparates un regalo que sea de mi agrado, luego tráemelo personalmente.\nSé que ahora mismo estás lleno de dudas, y reconozco que son razonables, pero ¿no crees que el cumpleañero tiene algunos privilegios? Hago esto solo porque temo que olvides esta fecha tan especial. Después de todo, tú eres mi invitado más anhelado.\nFinalmente, te esperaré con paciencia—¡no olvides el regalo!\n\nClementine"
  },
  Mail_80091_Name = {
    Text = "Regalo seleccionado \"personalmente\""
  },
  Mail_80091_Sender = {Text = "Clementine"},
  Mail_81288_Desc = {
    Text = "Estimado Guardián: \n       Gracias por tu apoyo a [Noche Antes del Olvido]. Para brindarte una mejor experiencia de juego en la Universidad de Misag, te invitamos cordialmente a completar la encuesta de experiencia que se encuentra a continuación. Como agradecimiento por tu colaboración, preparamos [200 Fichas de Plata] como recompensa, las cuales podrás reclamar al finalizar la encuesta. El plazo para completarla finaliza el 14 de abril a las 9:00, por favor tenlo en cuenta y complétala a tiempo. \n      <SurveyLink:\"Haz clic para completarla\">\n        Escucharemos atentamente las sugerencias de cada Guardián. Tus comentarios sin duda harán que la Universidad de Misag siga mejorando cada día más. \n       —Que la Llave de Plata ilumine tu camino."
  },
  Mail_81288_Name = {
    Text = "Cuestionario de experiencia de versión V2.2.0"
  },
  Mail_81288_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_81326_Desc = {
    Text = "Benefactor:\n\nHoy, para mí y Pólux, es el único festival del año. Durante nuestro tiempo en la iglesia, no se nos permitía prestar demasiada atención al significado personal; todo nuestro valor residía únicamente en el servicio eterno al Portador de la Luz, y frente a esa fe, cualquier otro festival no era más que una vanidad sin sentido.\nPero cada vez que llega nuestro cumpleaños, igual celebramos en secreto. Nos preparamos mutuamente un pequeño regalo, ocultándolo a los sirvientes, y secretamente anhelamos la llegada de este día.\nNuestras celebraciones suelen ser en la profundidad de la noche, el único momento de libertad que poseemos en el día. Las manos hábiles y las ideas creativas de Pólux siempre hacen que sus regalos sean mejores que los míos. Una vez, incluso recolectó plumas caídas y las entretejió en una flor floreciente.\nLa verdad es que no soy bueno preparando sorpresas; Pólux siempre dice que mi expresión delata mis intenciones con anticipación, y seguramente usted pensará que lo que poseo es aún más escaso y aburrido. Sin embargo, hoy he encontrado una manera perfecta de compartir mi alegría con usted.\nCuando escuche tres golpes en su ventana por la noche, no tenga miedo, ábrala. Le mostraré la sensación de las nubes y el viento nocturno.\n\nCastor"
  },
  Mail_81326_Name = {
    Text = "Paseo nocturno..."
  },
  Mail_81326_Sender = {Text = "Castor"},
  Mail_84142_Desc = {
    Text = "Guardián del Secreto: \n\nAntes de la reunión, escribí esta carta para invitarlo formalmente y presentarle mi \"navegación de cumpleaños\".\nLa primera parada de este viaje es el río Támesis. Subiremos a un barco de carga transformado en un restaurante móvil, navegando mientras degustamos piña enlatada con miel y ron. Esta es una delicia que solo se ofrece en los cumpleaños de la tripulación, espero que le guste.\nLa segunda parada de este viaje es el mirador del puerto. No se preocupe, ya he solicitado permisos de observación a la asociación de globos aerostáticos. Cuando el globo suba alto en el cielo y contemple todo el canal de Londres, cortaremos juntos el pastel como celebración.\nEn el pasado, las condiciones de navegación eran limitadas, y el llamado pastel de cumpleaños era solo un modelo hecho por un carpintero con roble y caramelo, así que tampoco conocía el sabor del pastel. Esta vez, al poder disfrutarlo con usted, creo que además de la belleza de la comida, también cosecharé mucho más.\nLa tercera parada, o más bien, la tercera parte, es el mapa estelar personalizado. He marcado en el mapa náutico la posición de los astros en el momento de mi nacimiento, y si no le importa, me gustaría marcar la suya también. Este mapa náutico único será el regalo más valioso para atesorar.\nDe hecho, al escribir esta carta, tuve algunas dudas. Estas acciones sin duda exceden los límites normales, pero hoy es un día especial, y usted es una persona especial para mí, mereciendo que rompa la norma por usted.\nAsí que le ruego que no rechace mi invitación y que llegue puntualmente.\n\nCorposant"
  },
  Mail_84142_Name = {
    Text = "Invitación de \"navegación\""
  },
  Mail_84142_Sender = {Text = "Corposant"},
  Mail_84355_Desc = {
    Text = "Estimado Guardián:\nLa actividad \"Bajo la Tormenta\" ha finalizado. Cualquier moneda de evento restante, \"Bandera de Señal\", será canjeada a razón de 40 \"Rosa Dorada\" por bandera. Por favor, recuerde verificar su inventario, Guardián."
  },
  Mail_84355_Name = {
    Text = "Bandera de señal recogida"
  },
  Mail_84355_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_84410_Desc = {
    Text = "Estimado Guardián: \n        Gracias por tu apoyo a [Noche de Olvido]. Para ofrecerte una mejor experiencia de juego en la Universidad de Misag, te invitamos cordialmente a completar la siguiente encuesta de experiencia. Como agradecimiento por tu colaboración, preparamos [200 Fichas de Plata] como recompensa; podrás reclamarla al finalizar la encuesta. El plazo para completarla finaliza el 5 de mayo a las 9:00; por favor, tenlo en cuenta y rellénala a tiempo. \n        <SurveyLink:[Haz clic aquí para completarla]> \n        Escucharemos atentamente las sugerencias de cada Guardián, y tus comentarios seguramente harán que la Universidad de Misag mejore cada día más. \n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_84410_Name = {
    Text = "Cuestionario de experiencia de versión V2.2.1"
  },
  Mail_84410_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89744_Desc = {
    Text = "Estimado Guardián del Secreto:  \nEn la actualización V2.2.2, hemos aumentado las recompensas de \"Donación de Líquido Fuente - Fondo de Donación de Alumnos\". Para los Guardián del Secreto que ya habían reclamado todas las recompensas adicionales antes de la actualización, se les enviarán las recompensas correspondientes de forma compensatoria. Por favor, revíselo."
  },
  Mail_89744_Name = {
    Text = "V2.2.2 Recompensa por donación de prime de plata reenviada"
  },
  Mail_89744_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89902_Desc = {
    Text = "Estimado Guardián: \n       Gracias por tu apoyo a [Noche de Olvido]. Para mejorar tu experiencia en la Universidad de Misag, te invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento, hemos preparado [200 núcleos de plata] como recompensa, que podrás reclamar al finalizar la encuesta. El plazo para completarla finaliza el 27 de mayo a las 9:00, por favor tenlo en cuenta. \n        <SurveyLink:[Haz clic aquí para completarla]> \n        Escucharemos atentamente las sugerencias de cada Guardián y tus comentarios seguramente harán que la Universidad de Misag mejore cada día más. \n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_89902_Name = {
    Text = "Cuestionario de experiencia de versión V2.2.1"
  },
  Mail_89902_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89903_Desc = {
    Text = "Estimado Guardián:\n        Gracias por tu apoyo y reconocimiento a \"Antes del Alba del Olvido\". Para ofrecerte una mejor experiencia de juego en la Universidad de Misag, te invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por tu colaboración, hemos preparado \"Núcleo de plata\" × 200 como recompensa, que podrás Reclamar al completar la encuesta. El plazo de la encuesta finaliza el 9 de noviembre a las 9:00. Por favor, recuerda completarla a tiempo.\n        <SurveyLink:[Haz clic aquí para completarla]>\n        Escucharemos atentamente las sugerencias de cada Guardián. ¡Tu opinión hará que la Universidad de Misag sea cada vez mejor!\n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_89903_Name = {
    Text = "Cuestionario de experiencia de versión V2.6.2"
  },
  Mail_89903_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89904_Desc = {
    Text = "Estimado Guardián del Secreto: \n        Gracias por su apoyo y reconocimiento a [Víspera del Olvido]. Para mejorar la experiencia de juego de los guardianes en la Universidad de Misag, le invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento por su colaboración, hemos preparado un[Núcleo de plata*200] como recompensa, que podrá reclamar al completar la encuesta. La fecha límite para enviar la encuesta es el 23 de febrero a las 9:00, por favor, asegúrese de completarla a tiempo. \n        <SurveyLink:[Haga clic aquí para completar]>\n        Escucharemos atentamente las sugerencias de cada Guardián del Secreto, ¡su retroalimentación sin duda hará que la Universidad de Misag sea cada vez mejor! \n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_89904_Name = {
    Text = "Cuestionario de experiencia de versión V2.4.2"
  },
  Mail_89904_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89905_Desc = {
    Text = "Estimado Guardián: \n       Gracias por tu apoyo y reconocimiento a [Noche Anterior al Olvido]. Para brindarte una mejor experiencia de juego en la Universidad de Misag, te invitamos cordialmente a completar la encuesta de experiencia que aparece a continuación. Como agradecimiento por tu colaboración, hemos preparado Plata × 200 como recompensa, que podrás reclamar al finalizar la encuesta. El plazo para completarla finaliza el 8 de junio a las 9:00, por favor tenlo en cuenta y complétala a tiempo. \n        <SurveyLink:[Haz clic aquí para completarla]> \n        Escucharemos atentamente las sugerencias de cada Guardián. Tus comentarios sin duda contribuirán a que la Universidad de Misag siga mejorando cada día. \n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_89905_Name = {
    Text = "Cuestionario de experiencia de versión V2.5.1"
  },
  Mail_89905_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89906_Desc = {
    Text = "Estimado Guardián del Secreto: \n        Gracias por su apoyo y reconocimiento a [Noche Antes del Olvido]. Para brindarle una mejor experiencia de juego en la Universidad de Misag, lo invitamos sinceramente a completar la siguiente encuesta de experiencia. Como agradecimiento por su cooperación, hemos preparado [200 núcleos de plata] como recompensa, que podrá reclamar al finalizar la encuesta. El plazo para completarla es el 22 de diciembre a las 9:00, así que por favor asegúrese de hacerlo a tiempo.\n        <SurveyLink:[Haga clic aquí para completarla]>\nEscucharemos atentamente las sugerencias de cada Guardián del Secreto. Sus comentarios sin duda harán que la Universidad de Misag mejore cada día. \n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_89906_Name = {
    Text = "Cuestionario de experiencia de versión V2.4.0"
  },
  Mail_89906_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89907_Desc = {
    Text = "Estimado Guardián: \n Gracias por tu apoyo y reconocimiento a [Noche del olvido]. Para mejorar tu experiencia en la Universidad de Misag, te invitamos a completar la siguiente encuesta de experiencia. Como agradecimiento, preparamos [200 Fichas de plata] como recompensa, que podrás reclamar al finalizar la encuesta. El plazo para completarla finaliza el 19 de enero a las 9:00, por favor, tenlo en cuenta. \n <SurveyLink:[Haz clic aquí para completarla]> \n Escucharemos atentamente las sugerencias de cada Guardián, y tus comentarios harán que la Universidad de Misag mejore cada día más. \n —Que la Llave de Plata ilumine tu camino."
  },
  Mail_89907_Name = {
    Text = "Cuestionario de experiencia de versión V2.4.1"
  },
  Mail_89907_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89908_Desc = {
    Text = "Estimado Guardián: \n       Gracias por tu apoyo y reconocimiento a [Noche de olvido]. Para ofrecerte una mejor experiencia de juego en la Universidad de Misag, te invitamos sinceramente a completar la siguiente encuesta de experiencia. Como agradecimiento por tu cooperación, preparamos Plata × 200 como recompensa, que podrás reclamar al finalizar la encuesta. La encuesta finaliza el 20 de julio a las 9:00, por favor ten en cuenta el plazo para completarla. \n        <SurveyLink:[Haz clic aquí para completarla]>\n        Escucharemos atentamente las sugerencias de cada Guardián, ¡y tus comentarios harán que la Universidad de Misag mejore cada vez más! \n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_89908_Name = {
    Text = "Cuestionario de experiencia de versión V2.5.2"
  },
  Mail_89908_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89909_Desc = {
    Text = "Estimado Guardián: \n        Gracias por tu apoyo y reconocimiento a [Noche Antes del Olvido]. Para ofrecerte una mejor experiencia de juego en la Universidad de Misag, te invitamos sinceramente a completar la siguiente encuesta de experiencia. Como agradecimiento por tu cooperación, hemos preparado Plata × 200 como recompensa; podrás reclamarla al finalizar la encuesta. El plazo para completar la encuesta es el 14 de septiembre a las 9:00, por favor tenlo en cuenta y rellénala a tiempo. \n        <SurveyLink:[Haz clic aquí para completarla]> \n        Escucharemos atentamente las sugerencias de cada Guardián, ¡y tus comentarios harán que la Universidad de Misag mejore cada vez más! \n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_89909_Name = {
    Text = "Cuestionario de experiencia de versión V2.6.0"
  },
  Mail_89909_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89910_Desc = {
    Text = "Estimado Guardián: \n       Gracias por tu apoyo a [Noche Anterior al Olvido]. Para brindarte una mejor experiencia de juego en la Universidad de Misag, te invitamos cordialmente a completar la encuesta de experiencia que se encuentra a continuación. Como agradecimiento por tu colaboración, hemos preparado [200 núcleos de plata] como recompensa; podrás reclamarlos al finalizar la encuesta. El plazo para completarla finaliza el 23 de junio a las 9:00, por favor tenlo en cuenta y asegúrate de completarla a tiempo.\n        <SurveyLink:[Haz clic aquí para completarla]>\n        Escucharemos atentamente las sugerencias de cada Guardián, y tus comentarios sin duda contribuirán a que la Universidad de Misag siga mejorando.\n        —Que la Llave de Plata ilumine tu camino."
  },
  Mail_89910_Name = {
    Text = "Cuestionario de experiencia de versión V2.2.2"
  },
  Mail_89910_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89911_Desc = {
    Text = "Estimado Guardián: \n       Gracias por tu apoyo a [Noche del olvido]. Para brindarte una mejor experiencia de juego en la Universidad de Misag, te invitamos sinceramente a completar la siguiente encuesta de experiencia. Como agradecimiento por tu cooperación, hemos preparado [200 fichas de plata] como recompensa, las cuales podrás reclamar al finalizar la encuesta. El plazo para completarla es el 8 de septiembre a las 9:00, por favor tenlo en cuenta y llénala a tiempo. \n      <SurveyLink:[Haz clic aquí para completarla]>\n       Escucharemos atentamente las sugerencias de cada Guardián y tus comentarios seguramente harán que la Universidad de Misag mejore cada vez más. \n       ——Que la Llave de Plata nos ilumine."
  },
  Mail_89911_Name = {
    Text = "Cuestionario de experiencia de versión V2.3.1"
  },
  Mail_89911_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89912_Desc = {
    Text = "Estimado Guardián: \n       Gracias por tu apoyo a [Noche Antes del Olvido]. Para brindarte una mejor experiencia de juego en la Universidad de Misag, te invitamos cordialmente a completar la siguiente encuesta de experiencia. Como agradecimiento por tu cooperación, hemos preparado [200 núcleos de plata] como recompensa; podrás reclamarlos al finalizar la encuesta. El plazo para completarla es el 11 de agosto a las 9:00, por favor tenlo en cuenta y llénala a tiempo.\n        <SurveyLink:[Haz clic aquí para acceder]>\n        Escucharemos atentamente las sugerencias de cada Guardián, ¡tus comentarios harán que la Universidad de Misag mejore cada día más!\n        ——Que la Llave de Plata ilumine tu camino."
  },
  Mail_89912_Name = {
    Text = "Cuestionario de experiencia de versión V2.3.0"
  },
  Mail_89912_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89913_Desc = {
    Text = "Estimado Guardián: \n Gracias por tu apoyo a [Noche Antes del Olvido]. Para mejorar tu experiencia en la Universidad de Misag, te invitamos a completar la siguiente encuesta. Como agradecimiento, preparamos [200 núcleos de plata] como recompensa; podrás reclamarlos al finalizar la encuesta. El plazo para completarla finaliza el 29 de septiembre a las 9:00, por favor tenlo en cuenta. \n <SurveyLink:[Haz clic aquí para completarla]> \n Escucharemos atentamente las sugerencias de cada Guardián y tus comentarios seguramente harán que la Universidad de Misag mejore cada día más. \n ——Que la Llave de Plata ilumine tu camino."
  },
  Mail_89913_Name = {
    Text = "Cuestionario de experiencia de versión V2.3.2"
  },
  Mail_89913_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89914_Desc = {
    Text = "Estimado Guardián: \n       Gracias por tu apoyo y reconocimiento a [Noche de olvido]. Para brindarte una mejor experiencia de juego en la Universidad de Misag, te invitamos sinceramente a completar la siguiente encuesta de experiencia. Como agradecimiento por tu cooperación, preparamos Plata × 200 como recompensa; podrás reclamarlos al finalizar la encuesta. El plazo para completarla es el 11 de mayo a las 9:00, por favor tenlo en cuenta y llénala a tiempo. \n      <SurveyLink:[Haz clic aquí para completarla]> \n       Escucharemos atentamente las sugerencias de cada Guardián y tus comentarios seguramente harán que la Universidad de Misag mejore cada día más. \n       —Que la Llave de Plata ilumine tu camino."
  },
  Mail_89914_Name = {
    Text = "Cuestionario de experiencia de versión V2.5.0"
  },
  Mail_89914_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89915_Desc = {
    Text = "Estimado Guardián: \nGracias por tu apoyo y reconocimiento a \"Noche del Olvido\". Para ofrecerte una mejor experiencia de juego en la Universidad de Misag, te invitamos sinceramente a completar la siguiente encuesta de experiencia. Como agradecimiento por tu cooperación, preparamos \"Plata\" × 200 como recompensa; podrás reclamarla al finalizar la encuesta. El plazo para completarla es el 12 de octubre a las 9:00, por favor tenlo en cuenta y llénala a tiempo. \n<SurveyLink:[Haz clic aquí para completarla]> \nEscucharemos atentamente las sugerencias de cada Guardián, y tus comentarios seguramente harán que la Universidad de Misag mejore cada día más. \n—Que la Llave de Plata ilumine tu camino."
  },
  Mail_89915_Name = {
    Text = "Cuestionario de experiencia de versión V2.6.1"
  },
  Mail_89915_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  },
  Mail_89997_Desc = {
    Text = "Estimado guardián: \nLa actividad \"Un medio paso de distancia·clon\" ha finalizado, y ahora procederemos a convertir las \"Piezas de muñeca\" restantes del guardián a razón de \"Rosa Dorada*40\" por cada una. Por favor, recuerde verificar su inventario."
  },
  Mail_89997_Name = {
    Text = "Recuperación de piezas de autómata"
  },
  Mail_89997_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_90000_Desc = {
    Text = "Estimado guardián: \nDe acuerdo con tu destacada actuación en \"Sombra que codicia el Reino de Dios: Marea Anormal\", recibirás las siguientes recompensas, por favor recogerlas a tiempo."
  },
  Mail_90000_Name = {
    Text = "Reemisión de recompensa por cupones de diseño sencillo de vestuario fantasmal"
  },
  Mail_90000_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_90015_Desc = {
    Text = "Estimado guardián: \nLa actividad del 1.5 aniversario ha terminado, y ahora convertiremos los \"Vale de Ropa Fantástica Básico (Fase 1)\" restantes del guardián según la proporción de Invitación del Ser Inmaterial*1 por cada uno. Por favor, recuerde revisar."
  },
  Mail_90015_Name = {
    Text = "Recuperación de vales de transformación de atuendo sencillo (Fase 1)"
  },
  Mail_90015_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_90231_Desc = {
    Text = "Estimado guardián: \nLa actividad \"Prisionero del Espejo\" ha finalizado, y ahora procederemos a convertir los \"Libro de sentido común\", \"Libro de matemáticas\" y \"Libro de literatura\" restantes de los guardianes a razón de cada uno canjeado por Rosa Dorada*40, por favor, recuerde verificar."
  },
  Mail_90231_Name = {
    Text = "Recuperación de moneda del evento Prisionero espejo"
  },
  Mail_90231_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_91725_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad\"Ceremonia del Abismo·clon\"ha terminado, y ahora convertiremos las\"Lágrimas del Sacerdote\",\"Sangre del sacerdote\"y\"Médula del sacrificador\"restantes del guardián según la proporción de\"Rosa Dorada\"× 40 por cada uno. Por favor, recuerde recogerlo."
  },
  Mail_91725_Name = {
    Text = "Recuperación de moneda del evento Sacrificio abismal"
  },
  Mail_91725_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_94424_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"La Gran Conquista\" ha terminado, y ahora procederemos a convertir los \"Delicioso asado de León\" restantes del guardián a razón de cada uno canjeado por \"Rosa Dorada\" × 40, por favor, recuerde recogerlo."
  },
  Mail_94424_Name = {
    Text = "Recuperación de moneda de la barbacoa Leó deliciosa"
  },
  Mail_94424_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_94425_Desc = {
    Text = "Estimado guardián:\nLa actividad \"Gran Conquista\" ha finalizado, y ahora convertiremos los \"Vale de Ropa Fantástica Básico (2ª Edición)\" restantes del guardián según la proporción de \"Invitación del Ser Inmaterial*1\" por cada uno. Por favor, recuerde recogerlo."
  },
  Mail_94425_Name = {
    Text = "Recuperación de vales de diseño de vestuario sencillo (Fase 2)"
  },
  Mail_94425_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_94503_Desc = {
    Text = "Mi faro luminoso:\n\nDesde que Castor y yo llegamos aquí, su cuidado hacia nosotros ha sido comparable a concedernos una nueva vida. Agradezco profundamente el pastel de cumpleaños que tan amorosamente preparó para nosotros. Lamento sinceramente haber confundido las dos aves que dibujó en el pastel con mariposas, pero realmente disfrutamos este regalo. Es la primera vez que recibimos un regalo de cumpleaños de otra persona.\nTambién recibimos una tarjeta de felicitación de la escuela, a través del Decano Khôlert. En el sobre blanco estaba pegado un sello dorado y elaborado, y dentro había escritos muchos buenos deseos. Este es realmente un lugar cálido, y nunca antes en nuestras vidas habíamos experimentado un momento tan feliz como el actual.\nPor favor, únase a Castor y a mí para celebrar nuestro cumpleaños. Es un ritual que mantenemos desde la infancia. Como nuestro benefactor, también tenemos un regalo preparado para usted: una corona tejida con una pluma que Castor perdió.\nLe presento esta sencilla corona como muestra de nuestro más profundo respeto. Deseo dedicar el resto de mi vida a seguir a su lado y contribuir a la gran visión de esta institución, eliminando el verdadero mal y la oscuridad.\nHace mucho tiempo que no hacía algo así, y Castor se burló diciendo que mi habilidad no es tan buena como en mi niñez. Espero que no la considere indigna.\n\nPolux"
  },
  Mail_94503_Name = {
    Text = "Corona Plumosa..."
  },
  Mail_94503_Sender = {Text = "Pollux"},
  Mail_95382_Desc = {
    Text = "¡Querido pequeño!\n\nPequeño, hoy es el día en que llegué al mundo.\nNo como una bola de fuego que arde sin parar, sino como el cumpleaños de la chica llamada Kattygura.\nSiguiendo la tradición de mi vida, este día organizaremos un gran banquete, disfrutando de vino y carne asada sin reservas.\nPor supuesto, siempre hay algún niño travieso que se burla de que he cumplido un año más, así que les saludé con un puñetazo en la cabeza.\nY ahora, este banquete ha añadido una nueva función, para que recordemos los tiempos que pasamos juntos.\nEste año planeo agregar una actividad más, que es —¡cazar a nuestro pequeño!\n¿Sabes? Estoy ansiosa por atraparte en mi banquete, adornando mi fiesta de cumpleaños con tu expresión adorable y tímida, tus ojos soñolientos y medio ebrios, y el aroma dulce que emanas. ¡Este será el mejor regalo de cumpleaños que he recibido desde que nací!\nYa es tarde para planear una fuga, porque cuando leas esta carta... yo ya he llegado a tu puerta.\nNo tengas miedo, pequeño, si todo va bien, solo escucharás las mejores historias y probarás la comida más deliciosa aquí.\nPor supuesto, es normal que algo inesperado le suceda a una pequeña bestia capturada, ¿verdad?\nVen conmigo, pequeño, esta noche tu hermoso tiempo está destinado a ser pasado conmigo.\n\nKattygura"
  },
  Mail_95382_Name = {
    Text = "La Fiesta del Tiempo..."
  },
  Mail_95382_Sender = {Text = "Katie Gula"},
  Mail_95465_Desc = {
    Text = "Estimado guardián del secreto:\nLa actividad \"Manual del Detective·clon\" ha terminado, y ahora convertiremos las \"Fichas Decisivas\" restantes del guardián según la proporción de cada una canjeada por \"Rosa Dorada\"× 40, por favor, verifique."
  },
  Mail_95465_Name = {
    Text = "Recuperación de Ficha"
  },
  Mail_95465_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_95875_Desc = {
    Text = "Estimado guardián: \nLa actividad \"Estética necrótica\" ha finalizado, y ahora procederemos a convertir los \"Huesos Podridos\" restantes del guardián a razón de \"Rosa Dorada*40\" por cada uno. Por favor, recuerde revisar su inventario."
  },
  Mail_95875_Name = {
    Text = "Recuperación de hueso de mano podrido"
  },
  Mail_95875_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_96012_Desc = {
    Text = "Estimado guardián:\nLa actividad \"La Caída de la Luz\" ha finalizado, y ahora convertiremos los objetos de evento restantes del guardián según la proporción de Rosa Dorada*40 por cada uno, por favor, recuerde recogerlo."
  },
  Mail_96012_Name = {
    Text = "Recuperación de balas"
  },
  Mail_96012_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_96323_Desc = {
    Text = "Señor/a Guardián del Secreto: \n\nLos vivos celebran su cumpleaños para encontrar significado en el tiempo que les queda. Y yo solo aprovecho esta noche para cocinar el aroma de la muerte hasta que sea más fragante. \nLos muertos que ya no luchan, que no tienen más obsesiones, han limpiado toda la suciedad de su vida; su arrepentimiento se mezcla como sal fina, fundiéndose entre las venas de la sangre en el momento justo de la cocción, formando un aroma húmedo y dócil. Sus huesos emiten un suave crujido, la grasa que se filtra de su piel es delicada como la menta, y las palabras no dichas en lo profundo de sus almas comienzan a escapar lentamente durante la cocción, dejando un sutil dulzor. Ya he comenzado a imaginarte como un objeto en calma: el crujido de tu piel al apretarse frente al fuego, las emociones que se evaporan entre tus huesos y carne, el dulce sabor de tu alma pura siendo tragada... \nPero tú eres diferente. \nSigues brillando, sigues latiendo, pero posees un aroma que ningún muerto puede igualar, embriagador y cautivador. Eres el madurado que estoy dispuesto a esperar, incluso deseo que esta espera dure más que la eternidad. \nEn estos innumerables aros de año, tu aparición le da significado a mi cumpleaños. No es solo por el delicioso alimento, sino por tu vida que aún late. \n\nDoresain"
  },
  Mail_96323_Name = {
    Text = "Espera eterna..."
  },
  Mail_96323_Sender = {Text = "Dulcinea"},
  Mail_97157_Desc = {
    Text = "Estimado Guardián:\nLa actividad\"Texto temporal\"ha terminado, y ahora convertiremos los\"Tinte de la verdad\",\"Tinte del sueño ilusorio\",\"Infección de locura\"restantes del guardián según la proporción de\"Rosa Dorada\"× 40 por cada uno, por favor, recuerda recogerlo."
  },
  Mail_97157_Name = {
    Text = "Recuperación de Tinte"
  },
  Mail_97157_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_97707_Desc = {
    Text = "Estimado guardián del secreto: \n La actividad \"Ritual de sacrificio del nacimiento divino\" ha terminado, y ahora procederemos a convertir los \"Incienso calmante\", \"Aroma de pesadilla\" y \"Incienso atrapasueños\" restantes del guardián según la proporción de \"Rosa Dorada\" × 40 por cada uno. Por favor, recuerda recogerlo."
  },
  Mail_97707_Name = {
    Text = "Recuperación de aromaterapia"
  },
  Mail_97707_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_97893_Desc = {
    Text = "Estimado guardián: \nLa actividad \"Si todo sigue igual\" ha finalizado, y ahora procederemos a convertir las \"Concha de especialidad costera\" restantes del guardián a razón de una por cada \"Rosa Dorada*40\". Por favor, recuerde recogerlos."
  },
  Mail_97893_Name = {
    Text = "Recuperación de moneda del evento \"Deliciosa carne asada de Leó\""
  },
  Mail_97893_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_97999_Desc = {
    Text = "Estimado Guardián:\nLa actividad \"¡Sin caramelos, haré travesuras!\" ha terminado. Los artículos de lotería restantes, \"Caramelo de calabaza de sabor extraño\", se convertirán a razón de \"Líquido de Origen de Núcleo de Plata*60\" por cada uno. Por favor, verifique sus recompensas, Guardián."
  },
  Mail_97999_Name = {
    Text = "Reciclaje de caramelo de calabaza de sabor extraño"
  },
  Mail_97999_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_98052_Desc = {
    Text = "Estimado guardián: \nLa actividad \"Puerta de los Mil Fenómenos·clon\" ha finalizado, y ahora procederemos a recuperar la moneda de evento restante \"Puntero final\" a razón de cada una canjeada por \"Rosa Dorada*40\", por favor, recuerde verificar."
  },
  Mail_98052_Name = {
    Text = "Reciclaje de puntero final"
  },
  Mail_98052_Sender = {
    Text = "Consejo de Missaga"
  },
  Mail_98182_Desc = {
    Text = "Estimado guardián: \nEn la actualización V2.3.1, hemos realizado la recuperación uniforme de las partículas de Resonancia desbordadas, las cuales serán canjeadas a razón de 1 por \"Rosa Dorada*5000\". Por favor, verifique."
  },
  Mail_98182_Name = {
    Text = "V2.3.1 Recompensa por recuperación de partículas de resonancia desbordadas reenviada"
  },
  Mail_98182_Sender = {
    Text = "Oficina de Asuntos de Mythag"
  }
})
return Text_Mail
