__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Activity = readonly({
  Activity_100432_ActivityName = {
    Text = "Shaggai hipnótico"
  },
  Activity_100432_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento, los Guardianes del Secreto pueden usar equipos preestablecidos del sistema que incluyan a Clementine para experimentar niveles designados sin límite. \n· No se pueden ajustar los Despertados en la formación durante la experiencia de los niveles del evento. \n<Title:Recompensas del evento>\n· Después de completar el desafío del nivel por primera vez, se pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_100433_ActivityName = {
    Text = "Obispo de bálsamos"
  },
  Activity_100433_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Obispo Benevolente\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan a Salvador para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_116469_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_116470_ActivityName = {
    Text = "Noche del día polar"
  },
  Activity_116470_ActivityPlot = {
    Text = "Se cruzaron al final del destino; el reloj que había sido reiniciado ya era demasiado tarde, y solo ese corazón lleno de remordimiento juró iluminar toda la suciedad en la oscuridad."
  },
  Activity_116470_ActivityStageEndContent = {
    Text = "Evento finalizado, actualmente solo puedes participar en \"Bendición\""
  },
  Activity_116470_ActivityTips = {
    Text = "<Title:Introducción a la actividad>\n1. Durante el evento, los Guardianes pueden recopilar la moneda del evento \"Visita de ofrenda\", \"Confesión ritual\" y \"Lealtad y ofrenda\" a través de las mecánicas limitadas \"Sangre amarga de fusión\" y \"Recompensas de logro\". \"Visita de ofrenda\", \"Confesión ritual\" y \"Lealtad y ofrenda\" se pueden utilizar para comprar artículos en la \"Bendición\", incluyendo la Rueda del destino SR limitada del evento \"Pólux SR (Texto temporal)\", Núcleo de Lumen, Núcleo Puro, entre otros.\n2. Durante el evento, \"Mundo de Sueños Extraños: Más allá del horizonte·bajo\" se desbloqueará de forma gratuita por tiempo limitado. ¡Completar los logros del evento también otorgará un avatar limitado del evento \"Por la Llave de Plata: Pollux\"!\n\n<Title:Tiempo de la actividad>\n1. Del 20 de octubre a las 9:00 hasta el 3 de noviembre a las 9:00 (GMT+8), todas las mecánicas del evento estarán disponibles.\n2. Del 3 de noviembre a las 9:00 hasta el 10 de noviembre a las 9:00 (GMT+8), solo se podrá participar en la \"Bendición\" y las recompensas de logro.\n\n<Title:Sangre amarga de fusión>\n1. \"Sangre amarga de fusión\" consta de 7 niveles, uno se abrirá automáticamente cada día.\n2. Cada desafío consumirá 120 puntos de neuropéptido y al completar el desafío se obtendrá moneda del evento.\n3. Después de completar un nivel, se desbloqueará la función de \"Repetición\" de ese nivel. Tenga en cuenta: al usar la función de \"Repetición\", no se obtendrá tasa de sincronización.\n4. Se puede utilizar la ayuda de los Alumnis para facilitar el paso de los niveles.\n\n<Title:Vórtice de recuerdos>\n Después de que comience el evento, se obtendrán automáticamente 60 \"Visita de ofrenda\" cada hora, con un máximo de almacenamiento de 25 horas.\n\n<Title:Bendición>\n1. La \"Bendición\" tiene tres tiendas, cuyos horarios son los siguientes:\n\"lavar el cuerpo\": se abrirá el 20 de octubre a las 9:00.\n\"Alma de confesión\": se abrirá el 21 de octubre a las 9:00.\n\"Extraer el pecado\": se abrirá el 22 de octubre a las 9:00.\n2. Cada intercambio consumirá 750 \"Visita de ofrenda\"/\"Confesión ritual\"/\"Lealtad y ofrenda\", obteniendo aleatoriamente cinco artículos como recompensa en el estudio.\n3. Las recompensas de cada estudio se dividen en \"Objeto especial\" y \"Objeto normal\". Al reiniciar, se puede restablecer la cantidad restante de artículos especiales al máximo, las reglas específicas son:\n(1) Primeros 2 reinicios: cuando no haya más cantidad restante de \"Objeto especial\", el Guardián puede elegir reiniciar, lo que restablecerá la cantidad restante de \"Objeto especial\" y \"Objeto normal\" al máximo; también puede optar por continuar intercambiando, cuando no haya más cantidad restante de \"Objeto normal\", se debe reiniciar para continuar intercambiando.\n(2) A partir del tercer reinicio: solo se puede reiniciar cuando no haya más cantidad restante de \"Objeto normal\". El reinicio restablecerá la cantidad restante de \"Objeto normal\" al máximo, \"Objeto especial\" no se restablecerán más.\n\n<Title:Bonificaciones del evento>\n1. Los Guardianes que posean un Cuerpo Despertado específico o una Rueda del destino (no se requiere que estén en el equipo) pueden obtener un aumento adicional en las recompensas de \"Visita de ofrenda\", \"Confesión ritual\" y \"Lealtad y ofrenda\" en las tareas de \"Sangre amarga de fusión\". Los aumentos específicos son los siguientes:\nCuerpo Despertado \"Pollux\": Despertar Espiritual 0/1/2/3 y más, bonificación del 20%/30%/40%/50%.\nRueda del destino SSR \"Pólux\": Posición superpuesta 0/1/2/3 y más, bonificación del 20%/30%/40%/50%.\nRueda del destino SR \"Pólux SR (Texto temporal)\": Posición superpuesta 0/1/2/3 y más, bonificación del 20%/30%/40%/50%.\n2. Las \"bonificaciones del evento\" de diferentes Cuerpos Despertados o Ruedas del destino se suman de manera acumulativa.\n3. De manera especial, las recompensas por completar el desafío de dificultad locura no se verán afectadas por las \"bonificaciones del evento\".\n\n<Title:Mundo de Sueños Extraños>\n1. Durante el evento, \"Mundo de Sueños Extraños: Más allá del horizonte·bajo\" se desbloqueará de forma gratuita.\n2. Al finalizar el evento, el progreso de la investigación de \"Mundo de Sueños Extraños: Más allá del horizonte·bajo\" se mantendrá, y completar eventos de investigación no finalizados durante el evento también otorgará recompensas de investigación consistentes con las del evento. Si no se desbloqueó \"Mundo de Sueños Extraños: Más allá del horizonte·bajo\" durante el evento, aún se podrá desbloquear consumiendo \"Punto de partida real\"*7 después de que finalice el evento.\n3. Independientemente de si es durante el evento o no, al completar \"Mundo de Sueños Extraños: Más allá del horizonte·bajo\" se puede obtener \"Posse: Corazón sagrado de llanto\"."
  },
  Activity_116470_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_116765_ActivityName = {
    Text = "Partida de Grabado"
  },
  Activity_116765_ActivityTips = {
    Text = "Reglas del evento: \n1. Los Guardianes del Secreto que completen las tareas designadas de la misión pueden reclamar recompensas en \"Partida Grabada\". \n2. Después de desbloquear el \"Archivo Premium\", se pueden obtener recompensas adicionales al completar las tareas. \n3. La compra de este \"Archivo Premium\" está limitada en el tiempo; una vez pasado el plazo, no se podrá volver a comprar. Se recomienda a los Guardianes del Secreto que realicen la compra antes del 3 de noviembre a las 9:00. \n4. Tenga en cuenta: el \"Archivo Premium\" desbloqueado en este evento solo es válido durante la duración de este evento. Se recomienda a los Guardianes del Secreto que consuman de manera racional."
  },
  Activity_116765_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_116818_ActivityName = {
    Text = "Repetir el combate primordial"
  },
  Activity_116818_ActivityPlot = {
    Text = "\"Las Estrellas\" son Sus ojos, observando, o deberíamos decir monitoreando todo en el mundo.\nCrees que has escapado de Su mirada, pero la verdad es que——sigues en Su sueño.\n\"¡Te atrapé——\"\nEn el momento de capturarte, las estrellas emitieron un suspiro de satisfacción."
  },
  Activity_116818_ActivityStageEndContent = {
    Text = "Evento finalizado"
  },
  Activity_116818_ActivityTips = {
    Text = "<Title: Repetir el combate primordial>\n·\"Repetir el combate primordial\" incluye 7 niveles que no se pueden reproducir y desafían directamente la visión primigenia. Durante los primeros dos días de la actividad, se abrirá 1 nivel, el tercer día se abrirán 3 niveles, y durante los siguientes dos días se abrirá 1 nivel cada día. \n·Cada vez que se desafíe y se derrote a la correspondiente visión primigenia de las estrellas, se obtendrá la recompensa correspondiente. \n·Cada tipo de visión primigenia de las estrellas tiene una gran cantidad de duplicados. Cada vez que un tipo de visión primigenia de las estrellas sea derrotada por cualquier guardián, la \"cantidad restante\" de ese tipo se reducirá en 1. Una vez que se elimine ese tipo de visión primigenia de las estrellas, el nivel correspondiente se cerrará y no se podrá desafiar de nuevo. \n·Cada nivel ofrecerá diferentes reliquias que te proporcionarán poderosos aumentos. \n·Todos los niveles deben elegir un compañero de combate. Durante toda la actividad, cada guardián que se siga mutuamente solo podrá proporcionarte asistencia una vez. Al usar asistencia, la recompensa real de la tasa de sincronización aumentará un 50% sobre la base de la recompensa. \n·Cada día, cada despertado, rueda del destino y orden clave solo puede participar una vez. \n·Durante la actividad, el registro de la fuerza especial \"Estrellas aria\" se desbloqueará y abrirá de forma gratuita sin condiciones previas. Después de que termine la actividad \"Repetir el combate primordial\", será necesario completar \"Operación de investigación - Capítulo de las Estrellas - Cuarta parte\" para desbloquear el registro de la fuerza especial \"Estrellas aria\".\n\n<Title: Compensación de nivel>\n·En \"Repetir el combate primordial\" hay un mecanismo de compensación de nivel para que los guardianes puedan luchar juntos. \nLas reglas de compensación de nivel son las siguientes: \n  ·Los despertados en el equipo de investigación que tengan un nivel inferior a 60 se compensarán hasta el nivel 60 en este desafío. \n  ·Los despertados en el equipo de investigación que tengan un nivel de habilidad inferior a 5 se compensarán hasta el nivel 5 en este desafío. \n  ·Los despertados en el equipo de investigación que tengan \"Presagio de Locura\" inferior a 6 se compensarán hasta el nivel 6 en este desafío. \n  ·Los despertados en el equipo de investigación que tengan \"Afinidad Espiritual\" inferior a 5 se compensarán hasta el nivel 5 en este desafío. \n  ·Si el guardián tiene un nivel inferior a 60, se compensará hasta el nivel 60 en este desafío. \n\n<Title: Registro de la fuerza especial>\n·Durante la actividad, el \"Registro de la fuerza especial: Estrellas aria\" se desbloqueará y abrirá de forma gratuita sin condiciones previas. \n·Después de que termine la actividad, el progreso de la investigación del \"Registro de la fuerza especial: Estrellas aria\" se mantendrá, y al completar los eventos de investigación no finalizados durante la actividad, también se podrán obtener recompensas de investigación consistentes con las de la actividad. Si no se desbloqueó el \"Registro de la fuerza especial: Estrellas aria\" durante la actividad, será necesario completar \"Operación de investigación - Capítulo de las Estrellas - Cuarta parte\" y consumir \"Punto de partida real\" ×7 para desbloquear el registro de la fuerza especial \"Estrellas aria\". \n·Independientemente de si se realizó durante la actividad, después de completar \"Registro de la fuerza especial: Estrellas aria\", se puede obtener \"Orden clave: Deseo de reencuentro\"."
  },
  Activity_116818_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_117836_ActivityName = {
    Text = "Señora de rojo"
  },
  Activity_117836_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Dama Roja\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Sorel para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_117837_ActivityName = {
    Text = "Dama de las profundidades"
  },
  Activity_117837_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n· Durante el evento \"Dama Aequor\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyan a Murphy para experimentar niveles designados de manera infinita.\n· Durante la experiencia de los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n· Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_117838_ActivityName = {
    Text = "Divus: la pluma de ónice"
  },
  Activity_117838_ActivityTips = {
    Text = "<Title:Reglas del evento>\n·Durante el evento de\"Hijo Santo · Pluma Negra\", los Guardianes del Secreto pueden usar equipos predefinidos que incluyan a Castor para experimentar niveles designados sin límite. \n·Durante la experiencia de los niveles del evento, no se puede ajustar el Despertado en la formación. \n<Title:Recompensas del evento>\n·Después de completar el desafío del nivel por primera vez, puedes reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_117839_ActivityName = {
    Text = "Llave de la puerta"
  },
  Activity_117839_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante el evento \"Key of the Door\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyen a Tawil para experimentar niveles designados infinitamente.\n·Mientras se experimentan los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Event Rewards>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_119662_ActivityName = {
    Text = "Flor de lodo"
  },
  Activity_119662_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Flor del Pantano\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Lily para experimentar niveles designados infinitamente.\n·Al jugar los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_119663_ActivityName = {
    Text = "Aliento de fertilidad"
  },
  Activity_119663_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Aliento Abundante\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan a Thais para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_119693_ActivityName = {
    Text = "Por la Llave de Plata"
  },
  Activity_119693_ActivityPlot = {
    Text = "¡Después de completar la misión, puedes elegir uno de los siguientes Despertados limitados!"
  },
  Activity_119693_ActivityTips = {
    Text = "<Title:Reglas del evento>\nDurante el evento, cada guardián puede elegir 1 Despertado de entre 8 Despertados SSR limitados después de usar su habilidad de Posse 200 veces.\nLa lista incluye: Doll: Infierno, Clementine, Corposant, Castor, Doresain, Katie Gula, Pickman y Pollux.\nCuando el guardián elige un Despertado ya poseído, las copias subsiguientes (de la 2ª a la 16ª) se convertirán en 1 fragmento correspondiente del Despertado y 50 sedimentos fundamentales.\nA partir de la 17ª copia en adelante, el Despertado SSR limitado se convertirá en 2 Fragmentos de núcleo espiritual esencial, 6 Fragmentos de núcleo espiritual y 250 sedimentos fundamentales."
  },
  Activity_119693_BannerText = {
    Text = "Despertar Limitado Gratuito"
  },
  Activity_119694_ActivityName = {
    Text = "La guía de la estrella de la mañana"
  },
  Activity_119694_ActivityTips = {
    Text = "<Title:Reglas del evento>\n·Los Guardianes del Secreto pueden reclamar recompensas en \"La guía de la estrella de la mañana\" al completar las tareas designadas del archivo. \n·Después de desbloquear el \"Archivo Premium\", se pueden obtener recompensas adicionales al completar tareas. \n·La compra de este \"Archivo Premium\" tiene un límite de tiempo, y no se podrá comprar después de la fecha límite. Se recomienda a los Guardianes del Secreto que compren antes del 26 de enero a las 9:00 (GMT+8). \n·Por favor, ten en cuenta: el \"Archivo Premium\" desbloqueado en este evento solo es válido durante la duración de este evento. Se recomienda a los Guardianes del Secreto que consuman de manera racional."
  },
  Activity_119694_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_119857_ActivityName = {
    Text = "Soberano que duerme"
  },
  Activity_119857_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Soberano del Sueño\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Tulu para experimentar niveles designados infinitamente.\n·Al experimentar niveles de evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_120495_ActivityName = {
    Text = "Ofrenda Conmemorativa de la Travesía · Capítulo de las Estrellas Ⅳ"
  },
  Activity_120495_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_120496_ActivityName = {
    Text = "Crónicas de la Reencarnación"
  },
  Activity_120496_ActivityTips = {
    Text = "Reglas del evento: \n1. Los Guardianes del secreto que completen las tareas designadas de las Crónicas de la Reencarnación pueden reclamar recompensas en \"Crónicas de la Reencarnación\". \n2. Las \"Crónicas de la Reencarnación\" están permanentemente abiertas. \n3. Después de desbloquear el Archivo Premium, se pueden reclamar recompensas adicionales al completar las tareas. \n4. Tenga en cuenta: el Archivo Premium desbloqueado en este evento solo es válido durante este evento. Se recomienda a los Guardianes del secreto que gasten de manera razonable."
  },
  Activity_120954_ActivityName = {
    Text = "Estrellas aria"
  },
  Activity_122195_ActivityName = {
    Text = "Sacrificio de la niebla"
  },
  Activity_122195_ActivityPlot = {
    Text = "La luz del amanecer disipa el sufrimiento de los devotos, y las estrellas actúan como un barco, llevando a hermanos y hermanas al reino elevado. \n Los corderos perdidos cantan y bailan en la puerta, mientras las velas estelares adornan el eterno tribunal divino. \n Pero la niebla detrás de la puerta ya ha llegado a la llamada, esa niebla engaña y confunde, solo para satisfacer su propia distorsionada curiosidad. \n Esa niebla bloqueará el \"amanecer\", cortando el camino hacia la liberación. \n Ella estará aquí, testificando el fin del mundo una vez más."
  },
  Activity_122195_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible para participar en\"Cabaña de Mouchette\""
  },
  Activity_122195_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes del Secreto pueden recolectar la moneda del evento \"Visión de la \"Niebla\"\",\"Sueño de \"Niebla\"\",\"\"Fuente\" de la niebla\" a través de los modos limitados \"El yo perdido\" y \"Recompensa de logro\". \"Visión de la \"Niebla\"\",\"Sueño de \"Niebla\"\",\"\"Fuente\" de la niebla\" pueden ser utilizados para comprar artículos en \"Cabaña de Mouchette\", incluyendo la rueda del destino SR exclusiva del evento \"Luz de la razón\", Núcleo de Lumen, Núcleo Puro, entre otros. \n2. Durante el evento, \"Conexión multidimensional: Bautismo de Plata y Sangre\" se desbloqueará gratuitamente por tiempo limitado, ¡completar los logros del evento también otorgará el avatar exclusivo del evento \"Por la Llave de Plata: Mouchette\"!\n\n<Title:Tiempo del evento>\n1. Del 29 de diciembre a las 9:00 hasta el 12 de enero a las 9:00 (GMT+8), se podrá participar en todos los modos del evento. \n2. Del 12 de enero a las 9:00 hasta el 19 de enero a las 9:00 (GMT+8), solo se podrá participar en \"Cabaña de Mouchette\" y en las recompensas de logro. \n\n<Title:El yo perdido>\n1. \"El yo perdido\" consta de 7 niveles, uno se abrirá automáticamente cada día. \n2. Cada desafío consumirá 120 puntos de Morfina, y al completar el desafío se obtendrá moneda del evento. \n3. Al pasar un nivel, se desbloqueará la función de \"Reproducir\" de ese nivel. Por favor, ten en cuenta: al usar la función de \"Reproducir\", no se obtendrá tasa de sincronización. \n4. Puedes utilizar el apoyo de la asociación de exalumnos para ayudarte a superar los niveles más fácilmente. \n\n<Title:Cabaña de Mouchette>\n\"Cabaña de Mouchette\" tiene tres tiendas, los horarios de apertura son los siguientes: \n·\"Sala de materiales\": abre el 29 de diciembre a las 9:00. \n·\"Cámara de sueños\": abre el 30 de diciembre a las 9:00. \n·\"Sala de cultivo\": abre el 31 de diciembre a las 9:00. \nEn la tienda, puedes seleccionar productos y comprarlos directamente. \n\n<Title:Bonificación del evento>\n1. Los Guardianes del Secreto que posean un Despertado o Rueda del Destino específicos (no se requiere que estén en el equipo) pueden obtener un bonus adicional en la moneda del evento \"Visión de la \"Niebla\"\",\"Sueño de \"Niebla\"\",\"\"Fuente\" de la niebla\" de las misiones de los niveles de \"El yo perdido\", los bonus específicos son los siguientes: \n·Despertado \"Mouchette\": Despertar Espiritual 0/1/2/3 y más, bonificación del 20%/30%/40%/50%. \n·Rueda del Destino SSR \"Matanza hasta el fin del mundo\": Posición superpuesta 0/1/2/3 y más, bonificación del 20%/30%/40%/50%. \n·Rueda del Destino SR \"Luz de la razón\": Posición superpuesta 0/1/2/3 y más, bonificación del 20%/30%/40%/50%. \n2. Los \"bonus del evento\" de diferentes Despertados o Ruedas del Destino se calcularán de forma acumulativa. \n3. Especialmente, las recompensas de desafío de dificultad locura no se verán afectadas por los \"bonus del evento\". \n\n<Title:Conexión multidimensional>\n1. Durante el evento, \"Conexión multidimensional: Bautismo de Plata y Sangre\" se desbloqueará gratuitamente. \n2. Después de que finalice el evento, el progreso de la investigación de \"Conexión multidimensional: Bautismo de Plata y Sangre\" se mantendrá, y al completar los eventos de investigación no finalizados durante el evento, también se podrá obtener recompensas de investigación consistentes con las del evento. Si no se desbloqueó \"Conexión multidimensional: Bautismo de Plata y Sangre\" durante el evento, aún se podrá consumir \"Punto de partida real\"*3 para desbloquearlo después de que finalice el evento. \n3. Independientemente de si se está durante el evento o no, al completar \"Conexión multidimensional: Bautismo de Plata y Sangre\" se podrá obtener \"Posse: Desde el Reino de la Bruma\"."
  },
  Activity_122195_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_122196_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_122520_ActivityName = {
    Text = "Sombra de la ciudad lluviosa·clon"
  },
  Activity_122520_ActivityPlot = {
    Text = "Un encuentro predestinado aguarda bajo la lluvia húmeda y brumosa. Conoces su nombre y su rostro, y su voz aún te arrulla hasta hacerte sentir en calma. \nPero recuerda—solo los dioses y los demonios están tan desesperados por satisfacer los deseos humanos. \nAdivina. ¿Cuál de ellos es ella?"
  },
  Activity_122520_ActivityStageEndContent = {
    Text = "El evento ha terminado. Ahora solo puedes participar en \"La Bóveda de la Bruja\"."
  },
  Activity_122520_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Secret Keepers pueden recoger moneda del evento a través de las actividades limitadas \"Tienda de la Bruja\" y \"Recompensa de logro\". La moneda del evento se puede usar en \"Tesoro de la Bruja\" para intercambiar y obtener recompensas de objetos, incluyendo la rueda del destino SR exclusiva del evento \"Sombrero de Bruja de Ala Ancha\", la piedra filosofal, Núcleo Puro, Núcleo de Lumen, entre otros. \n2. Durante el evento, \"Registro de la fuerza especial: Sombra de la ciudad lluviosa\" se abrirá gratuitamente, ¡completar los logros del evento también otorgará el avatar exclusivo del evento \"Por la Llave de Plata: Daffodil\"!\n\n<Title: Tiempo del evento>\n1. Del 12 de enero a las 9:00 hasta el 26 de enero a las 9:00 (GMT+8), todos los contenidos del evento están disponibles para participar. \n2. Del 26 de enero a las 9:00 hasta el 2 de febrero a las 9:00 (GMT+8), solo permanecerán \"Tesoro de la Bruja\" y \"Recompensa de logro\", los demás contenidos habrán finalizado y no estarán disponibles para participar. \n\n<Title: Tienda de la Bruja>\n1. \"Tienda de la Bruja\" consta de 5 niveles, cada 2 días se abrirá automáticamente 1. \n2. Cada intento de desafío consumirá 120 puntos de Morfina, y al completar el desafío se obtendrá moneda del evento. \n3. Después de completar un nivel, se desbloqueará la función de \"Reproducción\" de ese nivel. Tenga en cuenta: al usar la función de \"Reproducción\", no se obtendrá la tasa de sincronización. \n4. Se puede utilizar el apoyo de la asociación de antiguos alumnos para ayudar a facilitar el paso de los niveles. \n\n<Title: Bonificación del evento>\n1. Los Secret Keepers que posean un Despertado o rueda del destino específicos (no se requiere que estén en el equipo) pueden hacer que las recompensas de la misión de la \"Tienda de la Bruja\" que incluyen \"Cráneo de Bestia Pálida\", \"Cráneo de Bestia Sombría\" y \"Cráneo de la Bestia Carmesí\" obtengan un aumento adicional de caídas, los detalles del aumento son los siguientes: \n· Despertado \"Daffodil\": Despertar 0/1/2/3 y más, aumento del 20%/30%/40%/50% \n· Rueda del destino SSR \"Reliquia Preciada\": Superposición 0/1/2/3 y más, aumento del 20%/30%/40%/50% \n· Rueda del destino SR \"Sombrero de Bruja de Ala Ancha\": Superposición 0/1/2/3 y más, aumento del 20%/30%/40%/50% \n2. Los \"aumentos de evento\" de diferentes Despertados o ruedas del destino se calcularán de manera acumulativa. \n3. Especialmente, la recompensa del primer desafío de dificultad Frenesí no se verá afectada por el \"aumento del evento\". \n\n<Title: Tesoro de la Bruja>\n1. \"Tesoro de la Bruja\" tiene tres, los tiempos de apertura son los siguientes: \n· \"Producto ideal para eliminar preocupaciones\": del 12 de enero a las 9:00 hasta el 2 de febrero a las 9:00. \n· \"Tesoro Magnífico\": del 14 de enero a las 9:00 hasta el 2 de febrero a las 9:00. \n· \"Colección de Tesoros Exóticos\": del 16 de enero a las 9:00 hasta el 2 de febrero a las 9:00. \n2. Cada intercambio consumirá 750 \"Cráneo de Bestia Pálida\"/\"Cráneo de Bestia Sombría\"/\"Cráneo de la Bestia Carmesí\", y se obtendrán aleatoriamente cinco recompensas de objetos del tesoro. \n3. Las recompensas de objetos de cada tesoro se dividen en dos tipos: \"Objeto especial\" y \"Objeto normal\". Al reiniciar, se puede restablecer el número restante de recompensas de objetos especificados al máximo, las reglas específicas son: \n(1) Para los 2 primeros reinicios: cuando no haya número restante de \"Objeto especial\", el Secret Keeper puede elegir reiniciar; después del reinicio, se restablecerán los números restantes de \"Objeto especial\" y \"Objeto normal\" al máximo; también puede optar por continuar intercambiando; cuando no haya número restante de \"Objeto normal\", debe reiniciar para poder continuar intercambiando. \n(2) A partir del tercer reinicio: solo se puede reiniciar cuando no haya número restante de \"Objeto normal\", el reinicio restablecerá el número restante de \"Objeto normal\" al máximo, \"Objeto especial\" ya no se restablecerá. \n\n<Title: Registro de la fuerza especial>\n1. Durante el evento, \"Registro de la fuerza especial: Sombra de la ciudad lluviosa\" estará disponible gratuitamente. \n2. Después del evento, el progreso de investigación de \"Registro de la fuerza especial: Sombra de la ciudad lluviosa\" se mantendrá; si no se desbloqueó durante el evento, después de que el evento termine aún se puede consumir \"Punto de partida real\"*7 para desbloquear. \n3. Independientemente de si fue durante el evento, al completar \"Registro de la fuerza especial: Sombra de la ciudad lluviosa\" se puede obtener \"Posse: Verdadera apariencia de la Bruma Gris\"."
  },
  Activity_122520_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_122521_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_122803_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_122803_ActivityPlot = {
    Text = "Después de la compra, \"Mouchette\" se puede activar\n<BlueQuality:Desarrollo de la personalidad +4, desbloquear sobreexaltar>"
  },
  Activity_122804_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_122804_ActivityPlot = {
    Text = "Después de la compra, \"Mouchette\" se puede activar<BlueQuality:Despertar Espiritual 3>"
  },
  Activity_122827_ActivityName = {
    Text = "La gracia de la cría"
  },
  Activity_122827_ActivityTips = {
    Text = "<Title:Descripción>\n·Durante el evento, los Guardianes del Secreto pueden reclamar recompensas correspondientes en \"La gracia de la cría\" después de completar los objetivos designados."
  },
  Activity_122827_BannerText = {
    Text = "¡Recibe gratis la ilusión de ropa!"
  },
  Activity_123150_ActivityName = {
    Text = "Cazadora de cráneos"
  },
  Activity_123150_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Cazadora de Calaveras\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Narciso para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_123151_ActivityName = {
    Text = "Señor de Necrovia"
  },
  Activity_123151_ActivityTips = {
    Text = "<Title:Reglas del evento>\n·Durante el evento \"Señor de los Huesos Enterrados\", los Guardianes del Secreto pueden usar equipos predefinidos que incluyan a Doresain para experimentar niveles designados sin límite. \n·Durante la experiencia en los niveles del evento, no se puede ajustar el Despertado en la formación. \n<Title:Recompensas del evento>\n·Después de completar el desafío del nivel por primera vez, se pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_123152_ActivityName = {
    Text = "Apóstol del mar"
  },
  Activity_123152_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n· Durante el evento \"Apóstol del Mar\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyan a Miryam para experimentar niveles designados de manera infinita.\n· Al experimentar los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n· Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_123322_ActivityName = {
    Text = "Crónicas de la escarcha plateada"
  },
  Activity_123322_ActivityTips = {
    Text = "<Title:Reglas del evento>\n1. Los Guardianes del Secreto pueden reclamar recompensas en \"Crónicas de la escarcha plateada\" después de completar las tareas designadas. \n2. \"Crónicas de la escarcha plateada\" finalizará el 12 de enero a las 9:00 (GMT+8). \n3. Después de desbloquear \"Archivo Premium\", se pueden reclamar recompensas adicionales al completar las tareas. \n4. Atención: el \"Archivo Premium\" desbloqueado en este evento solo es válido durante este evento. Se recomienda a los Guardianes del Secreto que consuman de manera razonable."
  },
  Activity_123322_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_123323_ActivityName = {
    Text = "Danza frenética de la oveja dorada"
  },
  Activity_123323_ActivityTips = {
    Text = "<Title:Reglas del evento>\n1. Los Guardianes del Secreto que completen las misiones designadas del archivo pueden reclamar recompensas en \"Danza frenética de la oveja dorada\".\n2. \"Danza frenética de la oveja dorada\" finalizará el 26 de enero a las 9:00 (GMT+8).\n3. Después de desbloquear el \"Archivo Premium\", se pueden obtener recompensas adicionales al completar misiones.\n4. Tenga en cuenta: el \"Archivo Premium\" desbloqueado en esta actividad solo será válido durante esta actividad. Por favor, los Guardianes del Secreto consuman de manera razonable."
  },
  Activity_123323_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_124049_ActivityName = {
    Text = "Cerebro corrupto"
  },
  Activity_124049_ActivityTips = {
    Text = "<Title:Reglas del evento>\n·Durante el evento \"Cerebro corrupto\", los guardianes pueden usar equipos predefinidos del sistema que incluyen \"Fusión · Dor\" para experimentar niveles designados sin límite. \n·Durante la experiencia del nivel del evento, no se puede ajustar el Despertado en la formación. \n<Title:Recompensas del evento>\n·Después de completar el desafío del nivel por primera vez, se puede reclamar la recompensa de prueba en la interfaz del evento."
  },
  Activity_124050_ActivityName = {
    Text = "Apóstol del mar"
  },
  Activity_124050_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n· Durante el evento \"Apóstol del Mar\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyan a Miryam para experimentar niveles designados de manera infinita.\n· Al experimentar los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n· Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_124051_ActivityName = {
    Text = "Sacrificio del Abismo: Repetir"
  },
  Activity_124051_ActivityPlot = {
    Text = "En el reflejo del océano, el sueño del rey se desvanece y el reino de los dioses se corrompe.\nElla viene del sueño antiguo, hacia las ruinas del futuro.\nPregunta al abismo, pero el abismo guarda silencio.\nElla ofrece sacrificios al abismo, y solo se responde a sí misma"
  },
  Activity_124051_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Respuesta del abismo\""
  },
  Activity_124051_ActivityTips = {
    Text = "<Title:Introducción a la actividad>\n1. Durante el periodo de la actividad, los Guardianes pueden recolectar moneda de actividad a través de las jugadas limitadas \"Nacimiento del Reino Divino\", \"Santuario del Rey Dios\" y \"Recompensa de logro\". La moneda de actividad se puede usar en \"Respuesta del Abismo\" para ofrendas y obtener recompensas de objetos, incluyendo la Rueda del destino SR limitada \"El Llamado del Aequor\", Piedra filosofal, Núcleo Puro, Núcleo de Vacío, entre otros.\n2. Durante el periodo de la actividad, \"Mundo de Sueños Extraños: Profanación\" estará disponible de forma gratuita. Completar los logros de la actividad también otorgará el avatar limitado \"Por la Llave de plata: Miryam\"!\n\n<Title:Tiempo de la actividad>\n1. Del 9 de marzo a las 9:00 al 23 de marzo a las 9:00 (GMT+8), todos los contenidos de la actividad son accesibles.\n2. Del 23 de marzo a las 9:00 al 30 de marzo a las 9:00 (GMT+8), solo estarán disponibles \"Respuesta del Abismo\" y \"Recompensa de logro\", el resto de los contenidos habrán finalizado y no se podrá participar.\n\n<Title: Nacimiento del Reino Divino>\n1. \"Nacimiento del Reino Divino\" consta de 5 niveles, uno se abrirá automáticamente cada 2 días.\n2. Cada desafío consumirá 120 puntos de Menophin, y al completar el desafío se obtendrá moneda de actividad.\n3. Al completar un nivel, se desbloqueará la función de \"Reproducción\" para ese nivel. Nota: Al usar la función de \"Reproducción\", no se obtendrá Afinidad.\n4. Se pueden usar aliados de la Asociación de Alumni y \"Resonancia: Ofrenda del Abismo\" para facilitar el paso de los niveles.\n\n<Title: Bonificación de Ofrenda>\n1. Los Guardianes que posean un Despertado o Rueda del destino específica (no se requiere que estén en el equipo) pueden obtener un aumento adicional de caída de \"Lágrimas del Sacrificador\", \"Sangre del Sacrificio\" y \"Médula Sacrificial\" en las recompensas de la misión del nivel \"Nacimiento del Reino Divino\" (incluyendo la Reproducción), los aumentos específicos son los siguientes:\nDespertado \"Miryam\": Despertar Espiritual 0/1/2/3 y más, aumento del 20%/30%/40%/50%\nRueda del destino SSR \"El Poder de la Devoción\": Posición superpuesta 0/1/2/3 y más, aumento del 20%/30%/40%/50%\nRueda del destino SR \"El Llamado del Aequor\": Posición superpuesta 0/1/2/3 y más, aumento del 20%/30%/40%/50%\n2. Las \"Bonificaciones de Ofrenda\" de diferentes Despertados o Ruedas del destino se calculan de forma acumulativa.\n3. De manera especial, la recompensa del primer desafío de dificultad locura no se verá afectada por las \"Bonificaciones de Ofrenda\".\n\n<Title: Resonancia: Ofrenda del Abismo>\n1. Los Guardianes pueden obtener \"Corazón piadoso\" al completar los logros de la actividad.\n2. Al consumir \"Corazón piadoso\" y activar \"Resonancia: Ofrenda del Abismo\", se pueden obtener las siguientes bonificaciones:\n(1) Hacer que los Guardianes sean más fuertes en la jugada de la actividad \"Nacimiento del Reino Divino\", facilitando los desafíos.\n(2) Aumentar la moneda de actividad obtenida tras completar el desafío de \"Nacimiento del Reino Divino\".\n(3) Activar la jugada de la actividad \"Santuario del Rey Dios\".\n\n<Title: Santuario del Rey Dios>\nAl activar la resonancia \"Prueba de sacrificio\", se obtendrán automáticamente 60 \"Lágrimas del Sacrificador\" cada hora, con un máximo de almacenamiento de 25 horas.\n\n<Title: Respuesta del Abismo>\n1. \"Respuesta del Abismo\" tiene tres altares, los tiempos de apertura son los siguientes:\n\"Altar de Lágrimas Brillantes\": del 9 de marzo a las 9:00 hasta el 30 de marzo a las 9:00.\n\"Altar de Sangre de Gorila\": del 11 de marzo a las 9:00 hasta el 30 de marzo a las 9:00.\n\"Altar de Espíritus\": del 13 de marzo a las 9:00 hasta el 30 de marzo a las 9:00.\n2. Cada ofrenda consumirá 750 \"Lágrimas del Sacrificador\"/\"Sangre del Sacrificio\"/\"Médula Sacrificial\", y se obtendrán aleatoriamente cinco recompensas de objetos del altar.\n3. Las recompensas de objetos de cada altar se dividen en \"Objeto especial\" y \"Objeto normal\". Al reiniciar, se puede restablecer la cantidad restante de un objeto específico a su límite, las reglas específicas son:\n(1) Primeros 3 reinicios: cuando no haya cantidad restante de \"Objeto especial\", el Guardián puede elegir reiniciar; al reiniciar, se restablecerán las cantidades restantes de \"Objeto especial\" y \"Objeto normal\" a su límite; también puede elegir continuar ofreciendo. Cuando no haya cantidad restante de \"Objeto normal\", deberá reiniciar para continuar ofreciendo.\n(2) A partir del cuarto reinicio: solo se puede reiniciar cuando no haya cantidad restante de \"Objeto normal\", y el reinicio restablecerá la cantidad restante de \"Objeto normal\" a su límite, \"Objeto especial\" ya no se reiniciará.\n\n<Title: Mundo de Sueños Extraños>\n1. Durante el periodo de la actividad, \"Mundo de Sueños Extraños: Profanación\" estará disponible de forma gratuita.\n2. Al finalizar la actividad, el progreso de la investigación de \"Mundo de Sueños Extraños: Profanación\" se mantendrá. Si no se ha desbloqueado \"Mundo de Sueños Extraños: Profanación\" durante el periodo de actividad, aún se podrá consumir \"Punto de partida real\"*7 para desbloquearlo después de finalizar la actividad.\n3. Independientemente de si está dentro del periodo de actividad, tras completar \"Mundo de Sueños Extraños: Profanación\" se puede obtener \"Posse: Festival de las Mareas\".\n\n<Title: Compensación de réplica>\n1. Los Guardianes que ya han desbloqueado \"Mundo de Sueños Extraños: Profanación\" recibirán una compensación de \"Lágrimas del Sacrificador\"*700 al desbloquearlo nuevamente durante este evento de réplica.\n2. Los Guardianes que ya han obtenido el avatar limitado \"Por la Llave de plata: Miryam\" recibirán automáticamente \"Invitación del Ser Inmaterial\"*1 al obtenerlo nuevamente.\n3. Los Guardianes que ya han obtenido el material para activar resonancia \"Corazón piadoso\", cada vez que obtengan 1 adicional de \"Corazón piadoso\" se convertirá automáticamente en \"Rosa Dorada\"*5000.\n"
  },
  Activity_124051_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_124052_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_124053_ActivityName = {
    Text = "Reina de Espinas"
  },
  Activity_124053_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Reina de las Espinas\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Wanda para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_124800_ActivityName = {Text = "Mi turno"},
  Activity_124801_ActivityName = {
    Text = "Inversión de fase"
  },
  Activity_124801_ActivityPlot = {
    Text = "\"¡Quiero que todos jueguen a la Carta de Cartas Wanxiang!\"\nUn visitante de otro espacio-temporal entró en el espacio de Fase de Duelo debido a un accidente, transformándolo en algo muy diferente a su forma original.\nPara revertir el espacio nuevamente, los Guardianes del Secreto de diferentes espacios-temporales deben decidir quién es el más fuerte y desafiar a este visitante."
  },
  Activity_124801_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardián pueden completar logros en \"Fase de Duelo\" para obtener \"Bellotas mágicas\" a través de la \"Recompensa de logro\".\n2. Las \"Bellotas mágicas\" se pueden canjear por recompensas ricas en \"Recompensa del Rey\", incluyendo el avatar exclusivo del evento \"Mi turno: Carta deCartas Wanxiang\", 10 expresiones exclusivas del evento, así como \"Sueño fragmentado\", \"Sueños Residuales de las Estrellas\", etc.\n3. Durante el evento, \"Conexión Multidimensional: Mi turno\" estará disponible de forma gratuita.\n4. Los Guardián que superen \"Conexión Multidimensional: Mi turno: Invitado de otro mundo\" durante el evento tendrán el fondo de batalla de \"Fase de Duelo\" temporalmente reemplazado por \"Mi turno: Espacio de conciencia\".\n\n<Title: Recompensa de logro>\n1. \"Recompensa de logro\" incluye \"Prueba Arcana\", \"Prueba de Honor\" y \"Prueba de Umbral\". Los Guardián pueden completar los objetivos de logro para obtener \"Bellotas mágicas\".\n2. En los logros de \"Prueba Arcana\", por cada 3 Cuerpos Despertados enemigos derrotados se obtienen 10 \"Bellotas mágicas\", hasta 50 veces. Por cada 6 Exaltaciones realizadas se obtienen 10 \"Bellotas mágicas\", hasta 50 veces. Por cada 20 Cartas jugadas se obtienen 10 \"Bellotas mágicas\", hasta 50 veces.\n3. Los Cuerpos Despertados, Ruedas del destino y Posses temporalmente desbloqueados a través de Tema principal contarán normalmente para las victorias y las cartas jugadas.\n\n<Title: Recompensa del Rey>\n1. Los Guardián pueden acumular \"Bellotas mágicas\" para obtener recompensas correspondientes, acumular 3,600 \"Bellotas mágicas\" permitirá obtener todas las recompensas principales, y acumular 6,000 \"Bellotas mágicas\" otorgará todas las recompensas.\n2. Después de superar \"Mi turno: Invitado de otro mundo\", se desbloqueará la recompensa por acumular de 100 a 900 \"Bellotas mágicas\", y después de superar \"Mi turno: El momento de reversión de todo\", se desbloqueará la recompensa por acumular de 1,000 a 6,000 \"Bellotas mágicas\".\n\n<Title: Conexión Multidimensional>\n1. Durante el evento, \"Conexión Multidimensional: Mi turno\" estará disponible de forma gratuita.\n2. Después de que termine el evento, el progreso de la investigación de \"Conexión Multidimensional: Mi turno\" se conservará. Si no se desbloqueó durante el evento, aún se podrá desbloquear consumiendo \"Punto de partida real\" *3 después de que termine el evento.\n3. Independientemente de si fue durante el evento o no, después de superar \"Conexión Multidimensional: Mi turno\", se obtendrá \"Posse: La puerta de la taberna\".\n\n<Title: Tiempo del evento>\nEste evento solo estará disponible del 16 de marzo a las 9:00 al 30 de marzo a las 9:00 (GMT+8). Después del 30 de marzo a las 9:00 (GMT+8), el evento finalizará, ¡por favor, recuerden los Guardián reclamar las recompensas en \"Recompensa del Rey\"!"
  },
  Activity_124801_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_124801_UnlockConditionExplanation = {
    Text = "Completar \"Operación\" 3-2 · Normal Desbloqueado"
  },
  Activity_124834_ActivityName = {
    Text = "En nombre de la niebla"
  },
  Activity_124834_ActivityPlot = {
    Text = "Víspera del olvido × Secuencia de niebla\nInvitación especial de colaboración\n\n\"Mouchette, el grupo de investigación... oh no, ya no soy la vanguardia del grupo de investigación. Así que, permítanme reintroducirme—me llamo Mouchette, solo una chica encantadora~\""
  },
  Activity_124834_ActivityTips = {
    Text = "<Title:Reglas del evento>\nDurante el evento \"En nombre de la niebla\", al completar Capítulo Olvidado Cap. 1 \"Secretos del Este\", ¡puedes obtener gratis el nuevo Despertado SSR limitado \"Mouchette\"!\nCuando obtengas el mismo Despertado SSR de la 2ª a la 16ª vez, cada vez se convertirá en 1 fragmento correspondiente del Despertado y 50 sedimentos fundamentales; a partir de la 17ª vez y en adelante, el Despertado SSR limitado se convertirá en 2 Fragmentos de núcleo espiritual esencial, 6 Fragmentos de núcleo espiritual y 250 sedimentos fundamentales."
  },
  Activity_124834_BannerText = {
    Text = "Despertar Limitado Gratuito"
  },
  Activity_124981_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_124982_ActivityName = {
    Text = "Paciente disociativo: caos"
  },
  Activity_124982_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Paciente Astillado: Caos\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan \"24\" para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_124983_ActivityName = {
    Text = "Paciente disociativo: caro"
  },
  Activity_124983_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Paciente Dividido: Caro\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen \"24\" para experimentar niveles designados infinitamente.\n·Al experimentar niveles de evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_124984_ActivityName = {
    Text = "Poema sin nombre"
  },
  Activity_124984_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Poema Sin Nombre\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Horla para experimentar niveles designados infinitamente.\n·Mientras experimentan niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_124985_ActivityName = {
    Text = "Paciente disociativo: aequor"
  },
  Activity_124985_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Paciente Astillado: Aequor\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan \"24\" para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_124986_ActivityName = {
    Text = "Paciente disociativo: ultra"
  },
  Activity_124986_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Paciente Dividido: Ultra\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen \"24\" para experimentar niveles designados infinitamente.\n·Al experimentar niveles de evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_124987_ActivityName = {
    Text = "Sanación múltiple · Réplica"
  },
  Activity_124987_ActivityPlot = {
    Text = "Hysteria, también conocida como histeria.\nEn su época, era sinónimo de muerte.\n\nAfortunadamente, los científicos e investigadores de mitag están igualmente locos: están decididos a resolver este problema"
  },
  Activity_124987_ActivityStageEndContent = {
    Text = "El evento ha terminado. Actualmente, solo \"Análisis de Personalidad\" está disponible."
  },
  Activity_124987_ActivityTips = {
    Text = "<Title:Introducción a la actividad>\n1. Durante el evento, los guardianes pueden recolectar la moneda del evento \"Puzle de Memoria\" a través de los modos de juego limitados \"Código de Memoria\", \"Acumulación Frenética\" y \"Recompensa de logro\". \"Puzle de Memoria\" se puede utilizar para comprar artículos en \"Análisis de personalidad\", incluyendo el SR limitado de la rueda del destino \"Voluntad del Pez Plateado\", Núcleo de Lumen, Núcleo Puro, etc. \n2. Durante el evento, \"Registro de la fuerza especial: Fisión Tranquila\" se desbloqueará de forma gratuita por tiempo limitado, y completar los logros del evento también otorgará un ícono exclusivo del evento \"Por la Llave de Plata: \"24\"\"!\n\n<Title:Tiempo de la actividad>\n1. Del 23 de febrero a las 9:00 al 9 de marzo a las 9:00 (GMT+8), todos los modos de juego están disponibles. \n2. Del 9 de marzo a las 9:00 al 16 de marzo a las 9:00 (GMT+8), solo se puede participar en \"Análisis de personalidad\" y recompensas de logro. \n\n<Title:Código de Memoria>\n1. \"Código de Memoria\" consta de 5 niveles, que se desbloquean automáticamente uno cada 2 días. \n2. Cada desafío consumirá 120 puntos de morfina, y el éxito del desafío otorgará moneda del evento. \n3. Después de completar un nivel, se desbloqueará la función de \"Reproducción\" de ese nivel. Tenga en cuenta: al usar la función de \"Reproducción\", no se obtendrá tasa de sincronización. \n4. Se puede usar la ayuda de la asociación de antiguos alumnos y \"Resonancia: Síndrome Disociativo\" para facilitar el paso de los niveles. \n\n<Title:Bonificación de racionalidad>\n1. Los guardianes que posean un Cuerpo Despertado específico o rueda del destino (no se requiere en el campo de batalla) pueden hacer que la recompensa de \"Puzle de Memoria\" en los niveles de \"Código de Memoria\" obtenga una bonificación adicional de caída, las bonificaciones específicas son las siguientes: \n· Cuerpo Despertado \"24\": Despertar Espiritual 0/1/2/3 y más, bonificación del 20%/30%/40%/50%. \n· Rueda del destino SSR \"Restitución de la forma alterada\": Posición superpuesta 0/1/2/3 y más, bonificación del 20%/30%/40%/50%. \n· Rueda del destino SR \"Voluntad del Pez Plateado\": Posición superpuesta 0/1/2/3 y más, bonificación del 20%/30%/40%/50%. \n2. La \"bonificación de racionalidad\" de diferentes Cuerpos Despertados o ruedas del destino se calcula de forma acumulativa. \n3. De manera especial, la recompensa del primer desafío en dificultad locura no se verá afectada por la \"bonificación de racionalidad\". \n\n<Title:Resonancia: Síndrome Disociativo>\n1. Los guardianes pueden obtener \"Corazón dividido\" completando logros de la actividad. \n2. Consumir \"Corazón dividido\" y activar \"Resonancia: Síndrome Disociativo\" otorgará las siguientes bonificaciones: \n(1) Haciendo que los guardianes sean más fuertes en los modos de juego \"Código de Memoria\" y \"Registro de la fuerza especial: Fisión Tranquila\", facilitando los desafíos. \n(2) Aumentar las recompensas obtenidas después de completar el desafío de \"Código de Memoria\". \n(3) Activar el modo de juego \"Acumulación Frenética\". \n\n<Title:Acumulación Frenética>\n1. Después de activar la resonancia \"Diagnóstico: Fisura de personalidad\", se obtendrán automáticamente 60 \"Puzzle de Memoria α\" cada hora, con un almacenamiento máximo de 25 horas. \n2. Después de activar la resonancia \"Conocimiento armonizado\", se obtendrán automáticamente 30 \"Puzzle de Memoria β\" cada hora, con un almacenamiento máximo de 25 horas. \n\n<Title:Registro de la fuerza especial>\n1. Durante el evento, \"Registro de la fuerza especial: Fisión Tranquila\" se desbloqueará de forma gratuita. \n2. Al finalizar el evento, el progreso de la investigación de \"Registro de la fuerza especial: Fisión Tranquila\" se conservará, y completar eventos de investigación que no se hayan completado durante el evento otorgará recompensas de investigación consistentes con las del evento. Si \"Registro de la fuerza especial: Fisión Tranquila\" no se desbloqueó durante el evento, aún se puede consumir \"Punto de partida real\" *7 para desbloquearlo después de que finalice el evento. \n3. Independientemente de si es durante el evento o no, al completar \"Registro de la fuerza especial: Fisión Tranquila\" se puede obtener \"Posse: Toda ella\". \n\n<Title:Compensación de réplica>\n1. Los guardianes que ya hayan desbloqueado \"Registro de la fuerza especial: Fisión Tranquila\" recibirán una compensación de \"Puzzle de Memoria α\" *700 al desbloquearlo nuevamente durante este evento de réplica. \n2. Los guardianes que ya hayan obtenido el ícono exclusivo del evento \"Por la Llave de Plata: \"24\"\" recibirán automáticamente \"Invitación del Ser Inmaterial\" *1 al obtenerlo nuevamente. \n3. Los guardianes que ya hayan obtenido el material de activación de resonancia \"Corazón dividido\" recibirán automáticamente \"Rosa Dorada\" *5000 por cada \"Corazón dividido\" adicional que obtengan. \n"
  },
  Activity_124987_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_124988_ActivityName = {
    Text = "Segador de almas"
  },
  Activity_124988_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante el evento \"Coleccionista de Almas\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen Helot: Catena para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Event Rewards>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_125364_ActivityName = {
    Text = "Noticias antiguas de la ciudad marítima"
  },
  Activity_125364_ActivityPlot = {
    Text = "Poder, lujuria, y la intoxicación de la riqueza; sobre el altar donde yacen los cadáveres en la profunda mansión, el antiguo ser abre lentamente los ojos. \n Ah, pero esta no es una historia aterradora; Él \"te ama\", y \"te protegerá\" para siempre... Él desea darte todo lo \"mejor\"."
  },
  Activity_125364_ActivityStageEndContent = {
    Text = "Evento finalizado, actualmente solo puedes participar en \"La mansión abandonada\""
  },
  Activity_125364_ActivityTips = {
    Text = "<Title:Descripción del evento>\nDurante el evento, los Guardián pueden recoger la moneda del evento \"Dulce de pera\" a través de las mecánicas limitadas \"Ninguna forma de la Diosa Misteriosa\" y \"Recompensa de logro\". \"Dulce de pera\" se puede intercambiar en \"La mansión abandonada\" por recompensas, incluyendo el SR de la rueda del destino limitada del evento \"Cebo de magnolia\", Núcleo de Lumen, Núcleo Puro, Fragmentos de Piedra Sabia, Cristal de Mimesis, entre otros. \n\n<Title:Ninguna forma de la Diosa Misteriosa>\n1. \"Ninguna forma de la Diosa Misteriosa\" incluye 9 niveles de materiales que no requieren exploración y se pueden luchar directamente, uno se abre cada día. \n2. Cada desafío consumirá 120 puntos de Morfina, y al completar el desafío se obtendrán materiales de cultivo y moneda del evento. \n3. Después de completar el nivel, se desbloqueará la función de \"Reproducir\" para ese nivel. Tenga en cuenta: al usar la función de \"Reproducir\", no se obtendrá la tasa de sincronización. \n4. Se puede utilizar el apoyo de la asociación de exalumnos para ayudar a completar el nivel más fácilmente. \n\n<Title:Bonificación del evento>\n1. Los Guardián que tengan un Cuerpo Despertado específico o una rueda del destino (no se requiere que estén en el equipo) pueden obtener un aumento adicional en la caída de \"Dulce de pera\" en las recompensas de la misión de los niveles de \"Ninguna forma de la Diosa Misteriosa\" (incluyendo la reproducción), las bonificaciones específicas son las siguientes: \n· Cuerpo Despertado \"Xu\": Despertar Espiritual 0/1/2/3 y superior, bonificación del 20%/30%/40%/50% \n· Rueda del destino SSR \"Fruncir el ceño en vano\": Posición superpuesta 0/1/2/3 y superior, bonificación del 20%/30%/40%/50% \n· Rueda del destino SR \"Cebo de magnolia\": Posición superpuesta 0/1/2/3 y superior, bonificación del 20%/30%/40%/50% \n2. Las \"bonificaciones del evento\" de diferentes Cuerpos Despertados o ruedas del destino se suman de forma acumulativa. \n3. Especialmente, las recompensas de los desafíos de dificultad locura no se verán afectadas por las bonificaciones anteriores. \n\n<Title:La mansión abandonada>\n1. Cada \"Ofrenda a los dioses\" consumirá 750 \"Dulce de pera\", y se obtendrán aleatoriamente cinco recompensas de \"La mansión abandonada\". \n2. Las recompensas de los objetos en \"La mansión abandonada\" se dividen en \"Objeto especial\" y \"Objeto normal\", al reiniciar se puede restablecer el número restante de objetos especiales al límite, las reglas específicas son: \n(1) Primeras 5 reinicios: cuando no haya más cantidad restante de \"Objetos especiales\", el Guardián puede optar por reiniciar, al reiniciar se restablecerá la cantidad restante de \"Objetos especiales\" y \"Objetos normales\" al límite; también puede optar por continuar intercambiando, cuando no haya más cantidad restante de \"Objetos normales\", debe reiniciar para continuar intercambiando. \n(2) A partir del 6to reinicio: solo se puede reiniciar cuando no haya más cantidad restante de \"Objetos normales\", el reinicio restablecerá la cantidad restante de \"Objetos normales\" al límite, \"Objetos especiales\" no se restablecerán. \n\n<Title:Inmersión en la conciencia>\n1. Durante el evento, \"Charla nocturna bajo el abanico\" se desbloqueará gratuitamente. \n2. Después de que termine el evento, el progreso de la investigación de \"Charla nocturna bajo el abanico\" se mantendrá, al completar los eventos de investigación no finalizados durante el evento también se puede obtener recompensas de investigación consistentes con las del evento. Si \"Charla nocturna bajo el abanico\" no se desbloqueó durante el evento, después de que termine el evento aún se puede gastar \"Punto de partida real\" *3 para desbloquearlo. \n3. Independientemente de si fue durante el evento, después de completar \"Inmersión en la conciencia: Charla nocturna bajo el abanico\" se puede obtener \"Posse: Recuerdos de una casa antigua\". \n\n<Title:Tiempo del evento>\n1. 26 de enero 9:00 – 9 de febrero 9:00 (GMT+8), todo el contenido en la descripción del evento es accesible. \n2. 9 de febrero 9:00 – 16 de febrero 9:00 (GMT+8), solo se mantienen \"La mansión abandonada\" y \"Recompensa de logro\", el resto del contenido habrá terminado y no será accesible. \n3. Después del 16 de febrero 9:00 (GMT+8), el \"Dulce de pera\" restante no canjeado se recuperará a razón de 40 \"Rosa Dorada\" por cada uno, se recomienda a los Guardián que revisen su correo."
  },
  Activity_125364_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_125366_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_125366_ActivityPlot = {
    Text = "Después de la compra, \"Xu\" se puede activar\n<BlueQuality: Desarrollo de la personalidad +4, desbloquear sobreexaltar>"
  },
  Activity_125367_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_125368_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_125368_ActivityPlot = {
    Text = "Después de la compra, \"Xu\" se puede activar<BlueQuality:Despertar Espiritual 3>"
  },
  Activity_126275_ActivityName = {
    Text = "Tejedor autoencadenado"
  },
  Activity_126275_ActivityPlot = {
    Text = "La rueda gira suavemente, hilando a través de los eones sin cesar. Danza a lo largo de los filamentos plateados, oh Gran Tejedora. Pues el destino es el escenario del que nunca podrás huir.\nJueza. Redentora. Señora. Cautiva...\nDesde el momento en que pisaste estas tablas, el papel que habías de Jugar ya no fue tuyo para elegir."
  },
  Activity_126275_ActivityStageEndContent = {
    Text = "El evento ha terminado. Actualmente, solo la \"Tienda de regalos del teatro\" está disponible."
  },
  Activity_126275_ActivityTips = {
    Text = "<Title:Descripción del evento>\nDurante el evento, el Guardián puede recolectar la moneda del evento \"Boleto de asiento de terciopelo\" a través de las mecánicas limitadas \"El escenario de los títeres\" y \"Recompensa de logro\". El \"Boleto de asiento de terciopelo\" se puede canjear en la \"Tienda de regalos del teatro\" por recompensas, incluyendo la rueda del destino SR limitada del evento \"Rota Fortunae\", Núcleo de Vacío, Núcleo Puro, Fragmentos de Piedra Sabia, Cristal de Mimesis, entre otros. \n\n<Title:El escenario de los títeres>\n1. \"El escenario de los títeres\" incluye 5 niveles, uno se abre cada 2 días. \n2. Cada desafío consumirá \"Morfina\" × 120, y al completar el desafío se obtendrán materiales de crianza y moneda del evento. \n3. Después de completar un nivel, se desbloqueará la función de \"Reproducir\" de ese nivel. Por favor, ten en cuenta: al usar la función de \"Reproducir\", no se obtendrá tasa de sincronización. \n4. Se puede usar asistencia en batalla de la asociación de exalumnos para ayudarte a completar los niveles más fácilmente. \n\n<Title:Aumento del evento>\n1. Si el Guardián tiene un Cuerpo Despertado o Rueda del destino específicos (no se requiere en el equipo), puede hacer que la recompensa de la misión del nivel \"El escenario de los títeres\" obtenga un aumento adicional en la caída del \"Boleto de asiento de terciopelo\" (incluyendo reproducir), los detalles del aumento son los siguientes: \n· Cuerpo Despertado \"Aracne\": Despertar Espiritual 0/1/2/3 y más, aumento del 20%/30%/40%/50%\n· Rueda del destino SSR \"Tejido Eterno\": Posición superpuesta 0/1/2/3 y más, aumento del 20%/30%/40%/50%\n· Rueda del destino SR \"Rota Fortunae\": Posición superpuesta 0/1/2/3 y más, aumento del 20%/30%/40%/50%\n2. Los \"aumentos de actividad\" de diferentes Cuerpos Despertados o Ruedas del destino se calculan de manera acumulativa. \n3. Especialmente, las recompensas del primer desafío en dificultad locura no se verán afectadas por los aumentos mencionados anteriormente. \n\n<Title:Tienda de regalos del teatro>\n1. Cada \"Intercambio de regalos\" consumirá 750 \"Boletos de asiento de terciopelo\", y se obtendrán aleatoriamente cinco recompensas de la \"Tienda de regalos del teatro\". \n2. Las recompensas de la \"Tienda de regalos del teatro\" se dividen en dos tipos: \"Objeto especial\" y \"Objeto normal\", al reiniciar puedes restablecer la cantidad restante de recompensas de objeto especial al límite, las reglas específicas son: \n(1) Primeras 5 reinicios: cuando no haya cantidad restante de \"objeto especial\", el Guardián puede elegir reiniciar, al reiniciar se restablecerán las cantidades restantes de \"objeto especial\" y \"objeto normal\" al límite; también puede optar por continuar intercambiando, cuando no haya cantidad restante de \"objeto normal\", se deberá reiniciar para continuar intercambiando. \n(2) A partir del 6º reinicio: solo se puede reiniciar cuando no haya cantidad restante de \"objeto normal\", el reinicio restablecerá la cantidad restante de \"objeto normal\" al límite, \"objeto especial\" no se reiniciará. \n\n<Title:Tiempo del evento>\n1. 20 de abril 9:00 – 18 de mayo 9:00 (GMT+8), todo el contenido del evento es participable. \n2. 18 de mayo 9:00 – 25 de mayo 9:00 (GMT+8), solo se mantendrán la \"Tienda de regalos del teatro\" y \"Recompensa de logro\". \n3. Después del 25 de mayo 9:00 (GMT+8), los \"Boletos de asiento de terciopelo\" no canjeados restantes se reciclarán a razón de cada canje de \"Rosa Dorada\" × 40, por favor, el Guardián preste atención a su correo."
  },
  Activity_126275_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_126365_ActivityName = {
    Text = "Crónica predestinada"
  },
  Activity_126365_ActivityTips = {
    Text = "Reglas del evento:\n1. Los Guardianes del secreto que completen las misiones designadas en los Archivos del Destino pueden reclamar recompensas.\n2. Las misiones están agrupadas, y un grupo se desbloquea diariamente después del inicio del evento.\n3. Después de desbloquear el Archivo de Peregrinación, se pueden reclamar recompensas adicionales al completar misiones.\n4. Tenga en cuenta: el Archivo Premium desbloqueado solo es válido durante este evento de Crónicas."
  },
  Activity_126366_ActivityName = {
    Text = "Ofrenda Conmemorativa de la Travesía · Capítulo de las Estrellas V"
  },
  Activity_126366_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_126492_ActivityName = {
    Text = "Antología de los antiguos países"
  },
  Activity_126492_ActivityTips = {
    Text = "<Title:Antología de los antiguos países>\n·Esta Crónica incluye 8 paquetes; el primer paquete se puede reclamar de forma gratuita.\n·Después de comprar la \"Antología de los antiguos países\", podrás reclamar inmediatamente el segundo paquete y desbloquear los paquetes 3 a 8 después de periodos de espera específicos.\n·Reclama hasta \"Plata\" *20,000, \"Núcleo de Lumen\" *30, \"modelo de bucle\", \"Horizonte de Prototipo\" y más. Si compras antes del 26 de enero a las 9:00, también recibirás el avatar exclusivo \"La verdadera forma del abanico\" y \"Invitación del Ser Inmaterial\" *10.\n·Las compras realizadas después de esa fecha no incluirán estas recompensas exclusivas por tiempo limitado. Después de la compra, la duración de la crónica se convierte en permanente y solo se cerrará al día siguiente de haber reclamado todos los paquetes.\n·La \"Antología de los antiguos países\" está disponible por tiempo limitado; por favor, completa tu compra antes del 23 de febrero a las 9:00."
  },
  Activity_126492_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_127173_ActivityName = {Text = "El pintor"},
  Activity_127173_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento \"El Pintor\", los Guardianes del Secreto pueden usar equipos preconfigurados que incluyan a Pickman para experimentar niveles designados sin límite. \n· No se puede ajustar a los Despertados en la formación durante la experiencia de los niveles del evento. \n<Title:Recompensas del evento>\n· Después de completar el desafío de nivel por primera vez, se pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_129488_ActivityName = {
    Text = "Tren de placer acelerado"
  },
  Activity_129488_ActivityPlot = {
    Text = "En el tren, ruidos molestos y gruñidos salían constantemente de la suite. \n \"¡Salvador, se necesita apoyo en el tercer vagón!\" \n \"¡Wanda, manda a los enemigos que controlas hacia la parte trasera del tren, ya te están alcanzando!\" \n \"¡Ryker! ¡No coquetees más! ¡Apresúrate y ahuyenta a los tipos fuera de mi ventana!\" \n Mientras te encontrabas en un lío en el lujoso vagón, no te diste cuenta de que una pequeña figura ya se había colado sigilosamente en tu bolsillo. \n \"Hehe, así es como se pone interesante.\" \n \"He capturado unas buenas imágenes~ así que ahora— ¡es hora de que el pequeño 'N' entre en acción~!\""
  },
  Activity_129488_ActivityTips = {
    Text = "<Title:Introducción a la actividad>\nDurante el evento, los guardianes pueden obtener recompensas exclusivas a través de \"Marca de trayectoria larga\". Después de que finalice el evento, estas recompensas limitadas ya no estarán disponibles, por lo que se recomienda reclamarlas a tiempo.\nParticipar otorga compensaciones de nivel para tu equipo: los Despertados con nivel inferior a 60, nivel de habilidad inferior a 5, nivel de Presagio de Locura inferior a 6 o nivel de Afinidad Espiritual inferior a 5 serán compensados hasta estos mínimos. Los guardianes con nivel inferior a 60 también serán compensados hasta nivel 60 durante este desafío.\n\n<Title:Registro de la fuerza especial>\nDurante el evento, \"Registro de la fuerza especial: El tren hacia el Festival de la Oración por la Prosperidad\" estará disponible de forma gratuita.\nEl progreso se mantendrá después de que finalice el evento. Si no se desbloquea durante el periodo del evento, \"El tren hacia el Festival de la Oración por la Prosperidad\" aún se podrá desbloquear consumiendo \"Punto de partida real\"*7.\nCompletar \"El tren hacia el Festival de la Oración por la Prosperidad\" otorgará \"Posse: fuegos artificiales de fin de año\", independientemente del momento del evento.\n<Title:Tren de placer acelerado>\nUn desafío permanente basado en las reglas del \"Capítulo de las Estrellas\". ¡Enfrenta a varios jefes de investigación a través de encuentros dinámicos y aleatorios!\nEl límite de posesión de reliquias se amplía, permitiendo tener hasta 36 reliquias simultáneamente.\nLos guardianes ahora pueden poseer y potenciar poderosos efectos de \"Resonancia\" de 3 acciones de investigación diferentes a la vez.\nCada vez que se use el Cuerpo de Gnosis de Emergencia, se obtendrá un 20% menos de Puntos VIP en este desafío; planifica tus estrategias tácticas con precaución adicional.\nSe permite salir a mitad de camino para guardar el progreso, pero el estado del equipo no se sincronizará con mejoras externas. El progreso se conserva durante 7 días después de la última sesión; si no se reanuda dentro de este periodo, la partida se considerará abandonada.\n\n<Title:Lista VIP>\n1. Durante el periodo del evento, los registros en la \"Lista VIP\" se mantendrán, y se reiniciarán según el ciclo de la Actividad de la Academia después de que finalice el evento.\n2. La \"Lista VIP\" registrará a los guardianes que hayan tenido un excelente desempeño en los desafíos. Los guardianes que desafíen una vez durante cada periodo de Actividad de la Academia y obtengan exitosamente \"Puntos VIP\" serán incluidos en la \"Lista VIP\".\n3. La clasificación en la \"Lista VIP\" se basará en el máximo de \"Puntos VIP\" obtenidos en un solo desafío y el mínimo de \"Turnos\" utilizados. Se pueden realizar nuevos desafíos para mejorar la clasificación.\n\n<Title:Duración del evento>\n1. Del 9 de febrero a las 9:00 al 9 de marzo a las 9:00 (GMT+8), todos los contenidos del evento están disponibles para participar.\n2. Después del 9 de marzo a las 9:00 (GMT+8), el evento será archivado en \"Eco de la memoria\", y las recompensas en \"Marca de trayectoria larga\" ya no podrán ser reclamadas."
  },
  Activity_129488_BannerText = {
    Text = "¡Evento de juego especial completamente nuevo!"
  },
  Activity_129508_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_129509_ActivityName = {
    Text = "Pluma de buena fortuna del inicio del año"
  },
  Activity_129509_ActivityTips = {
    Text = "Reglas del evento:\n1. Los Guardián que inicien sesión diariamente pueden reclamar recompensas del día en \"Fragmentos de luz de principios de año\".\n2. Las recompensas se desbloquearán según el número de días acumulados de inicio de sesión y se restablecerán a las 9:00 (GMT+8) cada día."
  },
  Activity_129509_BannerText = {
    Text = "Iniciar sesión para recibir Núcleos de Plata y muchas recompensas"
  },
  Activity_129705_ActivityName = {
    Text = "Señor de la Explosión Ardiente"
  },
  Activity_129705_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento \"Señor de la Explosión Ardiente\", los guardianes pueden usar equipos predefinidos que incluyen a Katie Gula para experimentar niveles específicos sin límite. \n· Al experimentar los niveles del evento, no se puede ajustar el Despertado en la formación. \n<Title:Recompensas del evento>\n· Después de completar el desafío del nivel por primera vez, se puede reclamar una recompensa de prueba en la interfaz del evento."
  },
  Activity_129706_ActivityName = {
    Text = "Obispo de bálsamos"
  },
  Activity_129706_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Obispo Benevolente\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan a Salvador para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_130174_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_130175_ActivityName = {
    Text = "renacimiento al revés"
  },
  Activity_130175_ActivityPlot = {
    Text = "El mundo es demasiado solitario, el mundo es demasiado desolado. Por favor escucha, por favor sé testigo.\nLa carne que grita espera a través del largo silencio, esperando que los dientes de león florezcan en el desierto.\nEntonces se llenará de amor radiante, y se le concederá un nuevo nacido sanado una vez más."
  },
  Activity_130175_ActivityStageEndContent = {
    Text = "El evento ha Terminado. Actualmente, solo el \"Jardín de Dientes de León\" está disponible."
  },
  Activity_130175_ActivityTips = {
    Text = "<Title:Introducción de la actividad>\n1,Durante la actividad, los Guardianes pueden recolectar las monedas de actividad \"Polvo de Escama Pálida\", \"Polvo de Escama Roja\" y \"Polvo de Escama Brillante\" a través del modo de juego por tiempo limitado \"Notas del cuarto oscuro\" y las \"Recompensas de logro\", y canjear artículos en el \"Jardín de Dientes de León\", incluyendo la Rueda del destino SR de edición limitada \"Cuento de hadas en el barro\", Núcleo de Lumen, Núcleo Puro, entre otros.\n2,Durante la actividad, \"Conexión multidimensional: Semillas olvidadas de amor\" se desbloquea gratis por tiempo limitado. ¡Completar los logros de la actividad también te permitirá obtener el avatar de edición limitada \"Por la Llave de Plata: Saya\"!\n\n<Title:Período de la actividad>\n1,Del 30 de mayo a las 9:00 al 24 de agosto a las 9:00 (GMT+8), todos los modos de juego de la actividad estarán disponibles.\n2,Del 24 de agosto a las 9:00 al 31 de agosto a las 9:00 (GMT+8), solo se podrá participar en el \"Jardín de Dientes de León\" y las recompensas de logro.\n\n<Title:Notas del cuarto oscuro>\n1,\"Notas del cuarto oscuro\" contiene 7 niveles, y se abre automáticamente 1 por día.\n2,Cada desafío consumirá \"Morfina\" × 120; al superar el desafío se obtendrán monedas de actividad.\n3,Tras pasar un nivel, se desbloquea la función \"Repetir\" de dicho nivel. Nota: al usar la función \"Repetir\", no se puede obtener tasa de sincronización.\n4,Puedes usar la Asistencia en batalla de la asociación de exalumnos para ayudarte a pasar los niveles más fácilmente.\n\n<Title: Jardín de Dientes de León>\n1,El \"Jardín de Dientes de León\" cuenta con tres tiendas, con los siguientes horarios de apertura:\n·\"Jardín de Cría\": abre el 30 de mayo a las 9:00.\n·\"Jardín de Crecimiento\": abre el 31 de mayo a las 9:00.\n·\"Jardín en Flor\": abre el 1 de junio a las 9:00.\n2,Cada intercambio consumirá \"Polvo de Escama Pálida\"/\"Polvo de Escama Roja\"/\"Polvo de Escama Brillante\" × 750, y se obtendrán aleatoriamente cinco recompensas de objetos del \"Jardín de Dientes de León\".\n3,Las recompensas de objetos de cada \"Jardín de Dientes de León\" se dividen en \"Objeto especial\" y \"Objeto normal\". Al reiniciar, se puede restablecer la cantidad restante de recompensas de objetos especiales al límite máximo. Las reglas específicas son:\n(1) Primeros 2 reinicios: cuando el \"Objeto especial\" no tenga cantidad restante, el Guardián puede optar por reiniciar; tras el reinicio, la cantidad restante de \"Objeto especial\" y \"Objeto normal\" se restablecerá al límite máximo. También puede optar por continuar intercambiando; cuando el \"Objeto normal\" tampoco tenga cantidad restante, será necesario reiniciar para continuar intercambiando.\n(2) A partir del 3.er reinicio: solo se podrá reiniciar cuando el \"Objeto normal\" no tenga cantidad restante; el reinicio restablecerá la cantidad restante de \"Objeto normal\" al límite máximo, y el \"Objeto especial\" ya no se reiniciará.\n\n<Title:Bonificación de actividad>\n1,Si el Guardián posee ciertos Cuerpos Despertados o Ruedas del destino (no es necesario que estén en combate), los tres tipos de monedas de actividad en las recompensas de misiones de los niveles de \"Notas del cuarto oscuro\" obtendrán una bonificación adicional:\n·Cuerpo Despertado \"Saya\": Despertar Espiritual 0/1/2/3 o más, bonificación del 20%/30%/40%/50%.\n·Rueda del destino SSR \"Que el mundo se convierta en fragancia\": Posición superpuesta 0/1/2/3 o más, bonificación del 20%/30%/40%/50%.\n·Rueda del destino SR \"Cuento de hadas en el barro\": Posición superpuesta 0/1/2/3 o más, bonificación del 20%/30%/40%/50%.\n2,Múltiples \"Bonificaciones de actividad\" pueden acumularse. \n3,Nota: las recompensas del primer desafío superado en dificultad locura no se verán afectadas por la \"Bonificación de actividad\".\n\n<Title:Conexión multidimensional>\n1,Durante la actividad, \"Conexión multidimensional: Semillas olvidadas de amor\" se puede desbloquear gratis.\n2,Tras finalizar la actividad, el progreso de investigación se Retendrá; los eventos de investigación no completados durante la actividad podrán completarse después y seguirán otorgando las recompensas correspondientes. Si no se desbloqueó durante la actividad, aún se podrá desbloquear después consumiendo \"Punto de partida real\" × 3.\n3,Independientemente de si es durante la actividad o no, pasar \"Conexión multidimensional: Semillas olvidadas de amor\" permitirá obtener \"Posse: Dedicado al nuevo mundo\"."
  },
  Activity_130175_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_130176_ActivityName = {
    Text = "Ágape Floreciente"
  },
  Activity_130176_ActivityTips = {
    Text = "<Title:Reglas del evento>\nDurante el evento \"Ágape Floreciente,\" los Guardianes pueden usar la Formación preestablecida del sistema que contiene a Saya para experimentar los Niveles designados un número ilimitado de veces.\nAl experimentar los Niveles del evento, los Cuerpos Despertados en la Formación no se pueden ajustar.\n<Title:Recompensas del evento>\nTras completar un desafío de Nivel por primera vez, las recompensas de prueba se pueden reclamar en la interfaz del evento."
  },
  Activity_130376_ActivityName = {
    Text = "Texto temporal"
  },
  Activity_130376_ActivityTips = {
    Text = "<Title:Reglas del evento>\nDurante el evento \"Origen: Poder Real\", los Gardianes del secreto pueden usar equipos preestablecidos por el sistema que incluyan a Origen: Poder Real para experimentar los niveles designados un número ilimitado de veces.\nAl experimentar los niveles del evento, no se pueden realizar ajustes a los Despertados en la formación del equipo.\n<Title:Recompensas del evento>\nTras completar el desafío del nivel por primera vez, puedes reclamar las recompensas de demostración en la interfaz del evento."
  },
  Activity_130403_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_130403_ActivityPlot = {
    Text = [[
Tras la compra, "Origen Ogier" puede activar
<BlueQuality:Desarrollo de la personalidad +4, Desbloquear Furia explosiva sobrecargada>]]
  },
  Activity_130404_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_130404_ActivityPlot = {
    Text = [[
Tras la compra, "Satogua" puede activar
<BlueQuality:Desarrollo de la personalidad +4, Desbloquear Furia explosiva sobrecargada>]]
  },
  Activity_130406_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_130406_ActivityPlot = {
    Text = "Tras la compra, \"Satogua\" puede activar <BlueQuality:Despertar Espiritual 3>"
  },
  Activity_130407_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_130407_ActivityPlot = {
    Text = "Tras la compra, \"Origen Ogier\" puede activar <BlueQuality:Despertar Espiritual 3>"
  },
  Activity_130408_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_130408_ActivityPlot = {
    Text = "Tras la compra, \"Saya\" puede activar <BlueQuality:Despertar Espiritual 3>"
  },
  Activity_130409_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_130409_ActivityPlot = {
    Text = [[
Tras la compra, "Saya" puede activar
<BlueQuality:Desarrollo de la personalidad +4, Desbloquear Furia explosiva sobrecargada>]]
  },
  Activity_130921_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_130922_ActivityName = {Text = "Vórtice"},
  Activity_130922_ActivityTips = {
    Text = "<Title:Reglas del evento>\nDurante el evento \"remolino\", los Guardianes pueden usar la Formación predefinida del sistema que contiene a Mosk para experimentar los niveles designados un número ilimitado de veces.\nAl experimentar los niveles del evento, los Cuerpos Despertados en la Formación no se pueden ajustar.\n<Title:Recompensas del evento>\nTras completar un desafío de nivel por primera vez, se pueden reclamar las recompensas de prueba en la interfaz del evento."
  },
  Activity_130923_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_130923_ActivityPlot = {
    Text = [[
Tras la compra, "Mosk" puede activar
<BlueQuality:Desarrollo de la personalidad +4, Desbloquear Furia explosiva sobrecargada>]]
  },
  Activity_130924_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_130924_ActivityPlot = {
    Text = "Tras la compra, \"Mosk\" puede activar <BlueQuality:Despertar Espiritual 3>"
  },
  Activity_130925_ActivityName = {
    Text = "Llamada de Merskus"
  },
  Activity_130925_ActivityPlot = {
    Text = "En lo profundo del mar, el vórtice está devorando todo. \n El demonio bajo Mersk se abre de par en par, invitando equitativamente a todos los seres que se acercan. \n Gira día tras día, grita una y otra vez, llamando a la persona destinada que inevitablemente llegará. \n Ven, ven, las \"algas\" te entrelazarán, las \"rocas\" te acompañarán, en el fondo oscuro del mar, estás destinado a danzar con la calamidad. \n Y la calamidad también responderá a tu último deseo. \n Bienvenido a casa, el destinado que no pudo elegir."
  },
  Activity_130925_ActivityStageEndContent = {
    Text = "Evento finalizado, actualmente solo puedes participar en \"Tesoro de Mosk\""
  },
  Activity_130925_ActivityTips = {
    Text = "<Title:Descripción de la actividad>\n1 Durante el período de la actividad, los Guardianes del Secreto pueden recolectar la moneda del evento \"Caracol marino No. 1\", \"Caracol marino II\" y \"Caracol marino III\" a través de las mecánicas limitadas \"Mosk y el mar\" y \"Recompensa de logro\". \"Caracol marino No. 1\", \"Caracol marino II\" y \"Caracol marino III\" se pueden utilizar para comprar artículos en \"El tesoro de Mosk\", incluyendo el SR de tiempo limitado \"Locura encarcelada\", Núcleo de Lumen, Núcleo Puro, entre otros. \n2 Durante el período de la actividad, \"Inmersión en la conciencia: Adicción\" se desbloqueará gratis por tiempo limitado, ¡completar los logros del evento también otorgará el avatar exclusivo del evento \"Por la Llave de Plata: Mosk\"!\n\n<Title:Horario de la actividad>\n1 Del 9 de marzo a las 9:00 - 6 de abril a las 9:00 (GMT+8), se puede participar en todas las mecánicas del evento. \n2 Del 6 de abril a las 9:00 - 13 de abril a las 9:00 (GMT+8), solo se puede participar en \"El tesoro de Mosk\" y en las recompensas de logro. \n\n<Title:Mosk y el mar>\n1 \"Mosk y el mar\" contiene 7 niveles, uno se abrirá automáticamente cada día. \n2 Cada desafío consumirá \"Morfina\" × 120, y al completar el desafío se obtendrá moneda del evento. \n3 Después de pasar un nivel, se desbloqueará la función de \"Reproducir\" de ese nivel. Tenga en cuenta: al usar la función \"Reproducir\", no se puede obtener tasa de sincronización. \n4 Se puede utilizar la asistencia de la asociación de exalumnos para ayudar a superar los niveles más fácilmente. \n\n<Title:El tesoro de Mosk>\n1 \"El tesoro de Mosk\" tiene tres tiendas, y los horarios de apertura son los siguientes: \n· \"Cofre número uno\": se abre el 9 de marzo a las 9:00. \n· \"Cofre dos\": se abre el 10 de marzo a las 9:00. \n· \"Cofre número tres\": se abre el 11 de marzo a las 9:00. \n2 Cada intercambio consumirá \"Caracol marino No. 1\"/\"Caracol marino II\"/\"Caracol marino III\" × 750, y se obtendrán al azar cinco recompensas de artículos de \"El tesoro de Mosk\". \n3 Cada recompensa de artículo de \"El tesoro de Mosk\" se clasifica en \"Objeto especial\" y \"Objeto normal\", y al reiniciar se puede restablecer la cantidad restante de objetos especiales al límite, las reglas específicas son: \n(1) Primeras 2 reinicios: cuando no haya cantidad restante de \"Objeto especial\", el Guardián del Secreto puede elegir reiniciar, lo que restablecerá la cantidad restante de \"Objeto especial\" y \"Objeto normal\" al límite; también puede elegir continuar intercambiando, cuando no haya cantidad restante de \"Objeto normal\", debe reiniciar para continuar intercambiando. \n(2) A partir del tercer reinicio: cuando no haya cantidad restante de \"Objeto normal\", se puede reiniciar, lo que restablecerá la cantidad restante de \"Objeto normal\" al límite, \"Objeto especial\" no se volverá a restablecer. \n\n<Title:Bonificación de la actividad>\n1 Los Guardianes del Secreto que tengan un despertar específico o una rueda de destino (no se requiere estar en el equipo) pueden hacer que las recompensas de la misión del nivel de \"El tesoro de Mosk\" obtengan un aumento adicional en la caída de \"Caracol marino No. 1\", \"Caracol marino II\", \"Caracol marino III\", los aumentos específicos son: \n· Despertado \"Mosk\": Despertar 0/1/2/3 y más, aumento del 20%/30%/40%/50%. \n· Rueda de destino SSR \"Edén distante\": Posición 0/1/2/3 y más, aumento del 20%/30%/40%/50%. \n· Rueda de destino SR \"Locura encarcelada\": Posición 0/1/2/3 y más, aumento del 20%/30%/40%/50%. \n2 Diferentes despertados o ruedas de destino tienen \"bonificaciones de actividad\" que se suman. \n3 Especialmente, la recompensa del primer desafío en dificultad locura no se verá afectada por las \"bonificaciones de actividad\". \n\n<Title:Inmersión en la conciencia>\n1 Durante el período de la actividad, \"Inmersión en la conciencia: Adicción\" se desbloqueará gratis. \n2 Después de que termine la actividad, el progreso de la investigación de \"Inmersión en la conciencia: Adicción\" se mantendrá, y al completar los eventos de investigación que no se completaron durante el período de actividad, también se pueden obtener recompensas de investigación consistentes con las del período de actividad. Si \"Inmersión en la conciencia: Adicción\" no se desbloqueó durante el período de actividad, aún se puede consumir \"Punto de partida real\" × 3 para desbloquearlo después de que termine la actividad. \n3 Independientemente de si es durante el período de actividad, después de pasar \"Inmersión en la conciencia: Adicción\", se puede obtener \"Posse: Inocencia ahogada\"."
  },
  Activity_130925_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_131090_ActivityName = {
    Text = "Banquete Ardiente: Recurencia"
  },
  Activity_131090_ActivityPlot = {
    Text = "Isaralu, la ciudad en el lago, supuestamente es el lugar de origen de wanda.\nEsta vez cruzarás la puerta del sueño, llegando a un antiguo grupo de torres llenas de campanas"
  },
  Activity_131090_ActivityStageEndContent = {
    Text = "La actividad ha terminado, actualmente solo puedes participar en \"el cofre del tesoro de wanda\""
  },
  Activity_131090_ActivityTips = {
    Text = "<Title:Descripción de la actividad>\n1. Durante el evento, los guardianes del secreto pueden recolectar la moneda del evento \"T fiesta ardiente\" y \"Recompensa de logro\" mediante modos de juego limitados, como \"Os Tibia original\", \"Amónito de hojas redondas\" y \"Ruinas Espirales\". La moneda del evento se puede usar para comprar productos en \"La Caja de Tesoros Extraordinarios de Wanda\", incluyendo el SR de la rueda del destino limitado del evento \"La mirada de Isarau\", Núcleo de Lumen, Núcleo Puro, entre otros. \n2. Durante el evento, \"Inmersión en la conciencia: T fiesta ardiente\" se desbloqueará de forma gratuita por tiempo limitado, y completar los logros del evento también otorgará el avatar limitado del evento \"Por la Llave de Plata: Wanda\".\n\n<Title:Tiempo de la actividad>\n1. Del 23 de marzo a las 9:00 - 20 de abril a las 9:00 (GMT+8), todos los modos de juego del evento son accesibles. \n2. Del 20 de abril a las 9:00 - 27 de abril a las 9:00 (GMT+8), solo se puede participar en \"La Caja de Tesoros Extraordinarios de Wanda\" y en la recompensa de logro. \n\n<Title:Ciudad en el lago>\n1. \"Ciudad en el lago\" tiene 7 niveles, que se abrirán automáticamente uno cada día. \n2. Cada desafío consumirá \"Morfina\" × 120, y si el desafío es exitoso, se obtendrá moneda del evento. \n3. Después de completar el nivel, se desbloqueará la función de \"Reproducir\" de ese nivel. Tenga en cuenta: al usar la función de \"Reproducir\", no se podrá obtener la tasa de sincronización. \n4. Se puede utilizar la asistencia de la asociación de exalumnos y \"Resonancia: Orden secreta\" para ayudarle a superar los niveles más fácilmente. \n\n<Title:Bonificación especial>\n1. Los guardianes del secreto que posean un cuerpo despierto o rueda del destino específicos (no es necesario que estén en el equipo) pueden obtener un aumento en la recompensa de moneda del evento de las misiones de \"Ciudad en el lago\", con los siguientes aumentos específicos: \n· Cuerpo despierto \"Wanda\": Despertar 0/1/2/3 y más, bonificación del 20%/30%/40%/50%. \n· Rueda del destino SSR \"Edicto de la Reina\": Posición superpuesta 0/1/2/3 y más, bonificación del 20%/30%/40%/50%. \n· Rueda del destino SR \"La mirada de Isarau\": Posición superpuesta 0/1/2/3 y más, bonificación del 20%/30%/40%/50%. \n2. La \"bonificación especial\" de diferentes cuerpos despiertos o ruedas del destino se calcula de manera acumulativa. \n3. Específicamente, la recompensa del desafío de la primera superación en dificultad locura no se verá afectada por la \"bonificación especial\". \n\n<Title:Resonancia: Orden secreta>\n1. Los guardianes del secreto pueden obtener \"Corazón del placer\" al completar logros del evento. \n2. Al consumir \"Corazón del placer\", se activa \"Resonancia: Orden secreta\", lo que permite a los guardianes del secreto volverse más fuertes en \"Ciudad en el lago\", haciendo que los desafíos sean más fáciles; también permite a los guardianes del secreto obtener moneda del evento adicional al completar niveles. \n\n<Title:Inmersión en la conciencia>\n1. Durante el evento, \"T fiesta ardiente\" se desbloqueará de forma gratuita. \n2. Después de que termine el evento, el progreso de la investigación de \"T fiesta ardiente\" se mantendrá, y completar eventos de investigación no terminados durante el evento también otorgará recompensas de investigación consistentes con las del evento. Si no se desbloqueó \"T fiesta ardiente\" durante el evento, aún se puede consumir \"Punto de partida real\" × 3 para desbloquearlo después de que el evento termine. \n3. Independientemente de si fue durante el evento o no, después de completar \"T fiesta ardiente\", se puede obtener \"Posse: Fiesta de la decadencia\". \n\n<Title:Compensación por réplica>\n1. Los guardianes del secreto que ya habían desbloqueado \"Inmersión en la conciencia: T fiesta ardiente\" recibirán una compensación de \"Os Tibia original\" × 300 al desbloquearlo nuevamente durante este evento de réplica. \n2. Los guardianes del secreto que ya habían obtenido el avatar limitado del evento \"Por la Llave de Plata: Wanda\" convertirán automáticamente cualquier obtención repetida en \"Invitación del Ser Inmaterial\" × 1. \n3. Los guardianes del secreto que ya habían obtenido el material de activación de resonancia \"Corazón del placer\" convertirán automáticamente cada \"Corazón del placer\" adicional en \"Rosa Dorada\" × 5000. \n"
  },
  Activity_131090_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_131091_ActivityName = {
    Text = "Fiesta Ardiente"
  },
  Activity_131370_ActivityName = {
    Text = "Ganador afortunado"
  },
  Activity_131370_ActivityTips = {
    Text = "<Title:Resumen del Evento>\n1. Tras completar las tareas designadas de las Crónicas del Guardián del Secreto, los Guardián pueden reclamar recompensas en \"Ganador afortunado\".\n2. \"Ganador afortunado\" finalizará el 6 de abril a las 9:00.\n3. Desbloquea \"Archivo Premium\" para reclamar recompensas adicionales al completar tareas.\n4. Ten en cuenta: El \"Archivo Premium\" desbloqueado en este evento solo es válido para este evento. Guardián, por favor consume de forma racional."
  },
  Activity_131370_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_131849_ActivityName = {
    Text = "memoria eterna"
  },
  Activity_131849_ActivityTips = {
    Text = "<Title:memoria eterna>\n\nEsta Crónica Temporal contiene 8 paquetes de regalo. El primer paquete de regalo se puede reclamar directamente de forma gratuita, mientras que los paquetes de regalo 2–8 requieren comprar \"memoria eterna\" antes de poder reclamarlos.\n\nTras comprar \"memoria eterna,\" las recompensas del 2.º paquete de regalo se pueden reclamar inmediatamente; los paquetes de regalo posteriores requieren esperar un cierto tiempo antes de poder reclamarlos.\n\nComprar \"memoria eterna\" antes de las 9:00 del 30 de mayo también otorgará recompensas adicionales: ¡avatar exclusivo \"Bon Appetite\" e \"Invitación del Ser Inmaterial\" ×10! Comprar después de las 9:00 del 30 de mayo ya no otorgará las recompensas exclusivas por tiempo limitado.\n\nTen en cuenta: \"memoria eterna\" estará disponible para comprar hasta el 29 de junio, 9:00."
  },
  Activity_131849_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_132331_ActivityName = {
    Text = "Señora de rojo"
  },
  Activity_132331_ActivityTips = {
    Text = "<Title:Reglas del evento>\nDurante el evento \"La Dama Carmesí\", los Guardianes pueden usar la Formación predefinida del sistema que incluye a \"Sorel\" para experimentar los Niveles designados un número ilimitado de veces.\nAl experimentar los Niveles del evento, los Cuerpos Despertados en la Formación no se pueden ajustar.\n<Title:Recompensas del evento>\nTras completar un desafío de Nivel por primera vez, puedes reclamar las recompensas de prueba en la interfaz del evento."
  },
  Activity_132332_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_132333_ActivityName = {
    Text = "Resurrección del Rey de los Dioses"
  },
  Activity_132333_ActivityPlot = {
    Text = "En el deseo interminable de deseos, brevemente despierta en su largo sueño y echa una mirada real a este mundo tenue.\nEn la vida eterna, esta mirada es tan breve"
  },
  Activity_132333_ActivityStageEndContent = {
    Text = "El evento ha terminado. Actualmente, solo \"Abismo de Conciencia\" está disponible."
  },
  Activity_132333_ActivityTips = {
    Text = "<Title:Descripción de la actividad>\n1. Durante el período de la actividad, los Guardianes del Secreto pueden recolectar la moneda del evento \"Pensamientos cansados\", \"Pensamientos melancólicos\" y \"Pensamientos alegres\" a través de las modalidades limitadas \"Mirada del Mar Profundo\" y \"Recompensa de logro\". La moneda del evento se puede usar en \"Abismo del mar de la percepción\" para comprar artículos, incluyendo la Rueda SR limitada del evento \"Trono de piedra azul\", Núcleo de Lumen, Núcleo Puro, Fragmentos de Piedra Sabia, Cristal de Mimesis, entre otros. \n2. Durante el período de la actividad, completar logros del evento también otorgará un avatar limitado del evento \"Por la Llave de Plata: Tulu\", la Rueda SR limitada del evento \"Trono de piedra azul\", Núcleo de plata y una gran cantidad de moneda del evento. \n\n<Title:Tiempo de la actividad>\n1. Del 6 de abril a las 9:00 - 4 de mayo a las 9:00 (GMT+8), se podrá participar en todas las modalidades de la actividad. \n2. Del 4 de mayo a las 9:00 - 11 de mayo a las 9:00 (GMT+8), solo se podrá participar en \"Abismo del mar de la percepción\" y la Recompensa de logro. \n\n<Title:Mirada del Mar Profundo>\n1. \"Mirada del Mar Profundo\" tiene 5 niveles, uno se abrirá automáticamente cada 2 días. \n2. Cada desafío consumirá \"Morfina\" × 120, y al completar el desafío se obtendrá moneda del evento. \n3. Al completar un nivel, se desbloqueará la función de \"Reproducir\" de ese nivel. Nota: Al usar la función \"Reproducir\", no se obtendrá tasa de sincronización. \n4. Se puede usar la asistencia de la asociación de exalumnos para ayudar a pasar los niveles más fácilmente. \n\n<Title:Aumento de pensamientos>\n1. Los Guardianes del Secreto que tengan un Despertado o Rueda específica (no se requiere que estén en el equipo) pueden hacer que la moneda del evento en las recompensas de la misión de \"Mirada del Mar Profundo\" obtenga un aumento adicional en las caídas, los aumentos específicos son los siguientes: \n· Despertado \"Tulu\": Despertar 0/1/2/3 y más, aumento del 20%/30%/40%/50%. \n· Rueda SSR \"Himno al Dios-Rey\": Posición 0/1/2/3 y más, aumento del 20%/30%/40%/50%. \n· Rueda SR \"Trono de piedra azul\": Posición 0/1/2/3 y más, aumento del 20%/30%/40%/50%. \n2. Los \"Aumentos de pensamientos\" de diferentes Despertados o Ruedas se calcularán de manera acumulativa. \n3. Especialmente, la recompensa por completar el desafío de dificultad locura no se verá afectada por los \"Aumentos de pensamientos\". \n\n<Title:Abismo del mar de la percepción>\n1. \"Abismo del mar de la percepción\" solo estará abierto del 6 de abril a las 9:00 - 11 de mayo a las 9:00 (GMT+8). \n2. Después del 11 de mayo a las 9:00 (GMT+8), la \"Pensamientos cansados\", \"Pensamientos melancólicos\" y \"Pensamientos alegres\" no canjeados serán recuperados a razón de cada canje \"Rosa Dorada\" × 40, por favor, los Guardianes del Secreto presten atención al correo. \n\n<Title:Inmersión en la conciencia>\n1. Durante el período de la actividad, \"Inmersión en la conciencia: Día de la coronación\" se puede desbloquear gratuitamente. \n2. Después de que termine la actividad, el progreso de investigación de \"Inmersión en la conciencia: Día de la coronación\" se mantendrá, y completar los eventos de investigación que no se completaron durante el período de la actividad también otorgará recompensas de investigación consistentes con las del período de la actividad. Si \"Inmersión en la conciencia: Día de la coronación\" no se desbloqueó durante el período de la actividad, aún se puede desbloquear después de la actividad consumiendo \"Punto de partida real\" × 3. \n3. Independientemente de si se completó durante el período de la actividad, al completar \"Inmersión en la conciencia: Día de la coronación\" se podrá obtener \"Posse: Bendición de las estrellas\". \n\n<Title:Compensación por replicar>\n1. Los Guardianes del Secreto que ya habían desbloqueado \"Inmersión en la conciencia: Día de la coronación\" recibirán una compensación de \"Pensamientos cansados\" × 300 al desbloquearlo nuevamente durante este evento de replicación. \n2. Los Guardianes del Secreto que ya habían obtenido el avatar limitado del evento \"Por la Llave de Plata: Tulu\", al obtenerlo nuevamente se convertirá automáticamente en \"Invitación del Ser Inmaterial\" × 1."
  },
  Activity_132333_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_132334_ActivityName = {
    Text = "Soberano que duerme"
  },
  Activity_132334_ActivityTips = {
    Text = "<Title:Reglas del evento>\nDurante el evento \"El Señor Durmiente\", los Guardianes pueden usar la Formación predefinida del sistema que contiene a \"Tulu\" para experimentar los niveles designados un número ilimitado de veces.\nDurante los niveles de prueba, los Cuerpos Despertados en la Formación no se pueden ajustar.\n<Title:Recompensas del evento>\nTras completar el desafío de nivel por primera vez, se pueden reclamar las recompensas de prueba en la interfaz del evento."
  },
  Activity_132688_ActivityName = {
    Text = "Cambio de comunicaciones"
  },
  Activity_132688_ActivityTips = {
    Text = "<Title:Introducción a la actividad>\n 1,Después de que el Guardián complete las tareas designadas de la actividad, podrá reclamar el \"Núcleo de Lumen\", el avatar limitado de la actividad \"Winkle·Terminal grande\", \"Erica·Terminal portátil\" y \"Colección de sellos: Guardián\". ¡Además, hay recompensas limitadas de la actividad como el nuevo traje de ilusión de 1 estrella \"Nautila·Eco de rosca\" y \"Helot·Momento de ruptura\"! \n 2,Esta actividad está disponible de forma permanente. Una vez completadas todas las tareas de la actividad y reclamadas todas las recompensas, la actividad finalizará y dejará de mostrarse a partir de las 9:00 del día siguiente (GMT+8).\n 3,Si anteriormente ya completaste las tareas \"Iniciar sesión con un dispositivo PC\" o \"Iniciar sesión con un dispositivo móvil\" en la función de recompensas de inicio de sesión, estas no se contabilizarán como completadas nuevamente aquí."
  },
  Activity_132908_ActivityName = {
    Text = "Texto temporal"
  },
  Activity_132908_ActivityTips = {
    Text = "Reglas del Evento:\n1. Tras completar las misiones designadas de las Crónicas del Guardián del Secreto, los Guardián pueden reclamar recompensas en \"Texto temporal\".\n2. Después de desbloquear \"Archivo Premium\", completar misiones otorgará recompensas adicionales.\n3. El \"Archivo Premium\" de este evento tiene un período de compra limitado. Ya no estará disponible para comprar después de la fecha límite. Por favor, compra a tu discreción antes del 20 de mayo a las 9:00.\n6. Ten en cuenta: El \"Archivo Premium\" desbloqueado en este evento solo es válido para este evento. Por favor, gasta con prudencia."
  },
  Activity_132908_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_132934_ActivityName = {
    Text = "Beso de Gancho de la Sepultura"
  },
  Activity_132934_ActivityTips = {
    Text = "<Title:Introducción>\n·Durante el evento, los Guardianes pueden reclamar las recompensas correspondientes en \"Beso de Gancho de la Sepultura\" tras completar los objetivos designados."
  },
  Activity_132934_BannerText = {
    Text = "¡Recibe gratis la ilusión de ropa!"
  },
  Activity_133271_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_133272_ActivityName = {
    Text = "La Gran Conquista: Actividad Despertar Clon"
  },
  Activity_133272_ActivityPlot = {
    Text = "¡Una era gloriosa tal vez al final perezca, mas la voluntad de los grandes guerreros jamás desaparecerá! \n Las tumbas no pueden enterrarlos, las cadenas no pueden domarlos. \n Cuando surge un nuevo destino, deliciosas carnes asadas los aguardan al final del camino de conquista; los guerreros lanzan su acometida y reclaman como suyo el glorioso botín. \n ¡Cantemos al valor imperecedero, al sagrado imperio! \n ¡Roma! ¡Roma! \n \n"
  },
  Activity_133272_ActivityStageEndContent = {
    Text = "Evento finalizado, actualmente solo puedes participar en \"Ofrecer ofrenda\""
  },
  Activity_133272_ActivityTips = {
    Text = "<Title:Resumen del evento>\n1. Durante el evento, los Guardianes podrán recolectar la moneda de evento \"Delicioso asado de León\" a través de la jugabilidad por tiempo limitado \"Caza Divina\". \"Delicioso asado de León\" se puede usar en \"Ofrecer tributo\" para comprar objetos, incluyendo Núcleo de Vacío, Núcleo Puro, y más.\n2. Durante el evento, \"Mundo de Sueños Extraños: Conquista de la Cocina\" se desbloquea temporalmente de forma gratuita.\n\n<Title:Período del evento>\n1. 4 de mayo, 9:00 – 18 de mayo, 9:00 (GMT+8): Toda la jugabilidad del evento está disponible.\n2. 18 de mayo, 9:00 – 25 de mayo, 9:00 (GMT+8): Solo \"Ofrecer tributo\" y Recompensa de logro están disponibles.\n\n<Title:Caza Divina>\n1. \"Caza Divina\" contiene 5 niveles, con 1 nivel desbloqueándose automáticamente cada 2 días.\n2. Cada desafío consume Menophin × 120, y completar exitosamente un desafío recompensa moneda de evento.\n3. Después de pasar un nivel, se desbloqueará la función \"Recrear\" para ese nivel. Ten en cuenta: No se puede obtener Afinidad al usar la función \"Recrear\".\n4. Puedes usar la Asistencia en batalla de exalumnos para ayudarte a pasar los niveles más fácilmente.\n\n<Title: Ofrecer tributo>\nEn la tienda de \"Ofrecer tributo\", puedes usar la moneda de evento \"Delicioso asado de León\" para seleccionar y comprar objetos directamente.\n\n<Title:Mundo de Sueños Extraños>\n1. Durante el evento, \"Mundo de Sueños Extraños: Conquista de la Cocina\" se puede desbloquear de forma gratuita.\n2. Después de que el evento finalice, el progreso de investigación de \"Mundo de Sueños Extraños: Conquista de la Cocina\" se conservará. Completar cualquier Evento de investigación que haya quedado sin terminar durante el evento seguirá recompensando las mismas recompensas de investigación que durante el evento. Si \"Mundo de Sueños Extraños: Conquista de la Cocina\" no se desbloqueó durante el evento, aún se puede desbloquear después de que el evento finalice consumiendo \"Punto de partida real\" × 7.\n3. Independientemente de si es durante el período del evento, pasar \"Mundo de Sueños Extraños: Conquista de la Cocina\" recompensará \"Grupo: Resolución Voraz\"."
  },
  Activity_133272_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_133301_ActivityName = {
    Text = "L'Heure du Thé"
  },
  Activity_133301_ActivityTips = {
    Text = "<Title:Reglas del evento>\n1. Después de completar las tareas designadas de Crónicas del Guardián del Secreto, los Guardianes pueden reclamar recompensas en \"L'Heure du Thé\".\n2. \"L'Heure du Thé\" finalizará el 18 de mayo a las 9:00.\n3. Desbloquea \"Archivo Premium\" para reclamar recompensas adicionales al completar tareas.\n4. Ten en cuenta: El \"Archivo Premium\" desbloqueado en este evento solo es válido para este evento. Guardianes, por favor consuman de forma racional."
  },
  Activity_133301_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_134393_ActivityName = {
    Text = "Ex Stellaris"
  },
  Activity_134393_ActivityPlot = {
    Text = "¡Inicia sesión diariamente para reclamar la Rueda del destino SSR conmemorativa de edición limitada \"Ex Stellaris,\" hasta 16 en total!"
  },
  Activity_134393_ActivityTips = {
    Text = "<Title:Reglas del evento>\n·Durante el evento, los Guardianes pueden iniciar sesión diariamente para reclamar la Rueda del destino SSR conmemorativa de edición limitada \"a las estrellas\" en \"a las estrellas,\" para un total de 16 reclamaciones.\n·Las recompensas se desbloquearán secuencialmente según los inicios de sesión acumulados del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_134393_BannerText = {
    Text = "Rueda del destino SSR limitada gratis"
  },
  Activity_138582_ActivityName = {
    Text = "Té de la Sakura"
  },
  Activity_138582_ActivityTips = {
    Text = "<Title:Reglas del evento>\n1. Después de completar misiones de archivo específicas, los Guardianes pueden reclamar recompensas en \"Té de la Sakura\".\n2. \"Té de la Sakura\" finalizará el 15 de junio a las 09:00.\n3. Después de desbloquear \"Archivo Premium\", se pueden reclamar recompensas adicionales al completar misiones.\n4. Ten en cuenta: El \"Archivo Premium\" desbloqueado en este evento solo es válido para este evento. Por favor, gasta con prudencia según tu criterio."
  },
  Activity_138582_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_139116_ActivityName = {
    Text = "Cita Soñada"
  },
  Activity_139116_ActivityTips = {
    Text = "<Title:Reglas del evento>\n·Los Guardianes pueden reclamar recompensas de la \"Cita Soñada\" tras completar las tareas designadas.\n·Tras desbloquear el \"Archivo Premium,\" se pueden reclamar recompensas adicionales al completar las tareas.\n·Hay un límite de tiempo para comprar el \"Archivo Premium\" en esta ocasión. No se podrá comprar después de la fecha límite. Por favor, compra a tu discreción antes del 29 de junio, 9:00 (GMT+8).\n·Ten en cuenta: el \"Archivo Premium\" desbloqueado durante este evento solo es válido para este evento. Se aconseja a los Guardianes gastar con prudencia."
  },
  Activity_139116_BannerText = {
    Text = "¡Reclama un nuevo Cuerpo Despertado limitado gratis!"
  },
  Activity_139117_ActivityName = {
    Text = "Ofrenda Onírica"
  },
  Activity_139117_ActivityTips = {
    Text = "<Title:Introducción>\n·Durante el evento, tras completar objetivos específicos, los Guardianes podrán reclamar las recompensas correspondientes en \"Ofrenda Onírica\"."
  },
  Activity_139117_BannerText = {
    Text = "¡Reclama Sueños Residuales de las Estrellas gratis!"
  },
  Activity_139591_ActivityName = {
    Text = "¡Miagracias!"
  },
  Activity_139591_ActivityPlot = {
    Text = "\"Aviso de emergencia: Todo el personal y estudiantes, por favor cesen sus tareas actuales inmediatamente y ayuden a capturar a los sujetos de prueba escapados.\"\n\"Repito: Todo el personal y estudiantes, por favor cesen sus tareas actuales inmediatamente y ayuden a capturar a los escapados—¡Maldición! ¡Los gatos han entrado!\"\n\nPara cuando escuchaste la voz alarmada por el altavoz, todo el campus ya había sido engullido por pelaje negro, y todos estaban agitados intentando atrapar a estos pequeños alborotadores que escaparon del laboratorio.\nComo si buscaran venganza por el Festival de Oración por el Año, estos gatos negros convergían lenta y metódicamente hacia tu dormitorio.\n\nPero pensándolo bien... considerando la gran cantidad de Rosa Dorada y Plata que llevan consigo, es difícil decir si vienen por venganza o a devolver el favor.\nSin embargo, ten cuidado de no atraparlos en exceso."
  },
  Activity_139591_ActivityStageEndContent = {
    Text = "Evento finalizado"
  },
  Activity_139591_ActivityTips = {
    Text = "<Title: ¡Miagracias!>\n¡Miagracias! presenta 7 niveles únicos y no repetibles que deben ser desafiados directamente. Un nuevo nivel se desbloquea cada día.\nDerrotar al \"Gato Negro Dimensional\" correspondiente en cada desafío contribuye al progreso del evento. Las recompensas se pueden reclamar a través del \"Registro de Capturas del Gato\".\nCada \"Gato Negro Dimensional\" tiene numerosos duplicados—los desafíos se pueden intentar un número ilimitado de veces durante el evento y admiten auto–batalla.\nCada nivel proporciona diferentes Reliquias que otorgan poderosas bonificaciones.\nTodos los niveles requieren un Guardián de Asistencia en batalla. Durante el evento, cada Guardián con seguimiento mutuo solo puede proporcionarte asistencia en batalla una vez.\n\n\n<Title: Compensación de Nivel>\n¡Miagracias! incluye un sistema de compensación de nivel para que todos los Guardianes puedan luchar codo a codo.\nLas reglas de compensación son las siguientes:\nLos Cuerpos Despertados en tu equipo por debajo del nivel 60 serán compensados al nivel 60 durante la duración del desafío.\nLos Cuerpos Despertados en tu equipo con niveles de habilidad por debajo de 5 serán compensados al nivel de habilidad 5 durante la duración del desafío.\nLos Cuerpos Despertados en tu equipo con Presagio de Locura por debajo del nivel 6 serán compensados al nivel 6 durante la duración del desafío.\nLos Cuerpos Despertados en tu equipo con Afinidad Espiritual por debajo del nivel 5 serán compensados al nivel 5 durante la duración del desafío.\nLos Guardianes por debajo del nivel 60 serán compensados al nivel 60 durante la duración del desafío.\n\n<Title: Registro de Capturas del Gato Negro>\nDurante el evento, derrotar al \"Gato Negro Dimensional\" correspondiente acumula progreso de misión, permitiendo a los Guardianes reclamar recompensas a través del \"Registro de Capturas del Gato\". El Registro se divide en dos secciones: \"Registro de Capturas Personal\" y \"Registro de Capturas del Campus\". El \"Registro de Capturas Personal\" rastrea el progreso individual de cada Guardián. El \"Registro de Capturas del Campus\" rastrea el progreso combinado de todos los Guardianes en todo el campus.\n\n<Title: Clasificaciones de Captura>\nDurante el evento, los Guardianes pueden ver la \"Clasificación de Guardianes\" y la \"Clasificación de Apoyo\" en \"Clasificaciones de Captura\".\n\n<Title: Duración del Evento>\nLos Guardianes pueden acceder a la página del evento y unirse al desafío antes de las 9:00 AM del 15 de junio (GMT+8). No se admitirán nuevos Guardianes después de esta hora. Los Guardianes que ya se hayan unido pueden seguir participando si el evento aún no ha concluido.\nSi el \"Total de Capturas\" se alcanza antes de las 9:00 AM del 15 de junio (GMT+8), el evento terminará el 29 de junio a las 9:00 AM (GMT+8). Si el \"Total de Capturas\" no se alcanza para esa fecha, el evento terminará 14 días después de que se alcance el \"Total de Capturas\"."
  },
  Activity_139591_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_139922_ActivityName = {
    Text = "Shaggai hipnótico"
  },
  Activity_139922_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante el evento \"Hypnotic Worm\", el Guardián puede utilizar equipos preestablecidos por el sistema que incluyen a Clementine para experimentar etapas especificadas infinitamente.\n·Mientras se experimentan las etapas del evento, no se pueden hacer ajustes a los Despertadores en la alineación del equipo.\n<Title:Event Rewards>\n·Después de completar el desafío de etapa por primera vez, puedes reclamar las recompensas de prueba en la interfaz del evento."
  },
  Activity_139923_ActivityName = {
    Text = "Sinfonía Inmaterial"
  },
  Activity_139923_ActivityPlot = {
    Text = "La sinfonía es un arte de tejido, donde las trayectorias de los instrumentos se entrelazan en un patrón.\nEn su red, cada nota tiene su función.\nEscucha, una sinfonía sublime está por comenzar"
  },
  Activity_139923_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Palacio del sueño\""
  },
  Activity_139923_ActivityTips = {
    Text = "<Title:Introducción del evento>\n1. Durante el evento, los Guardianes podrán recolectar la moneda de evento \"Canto heroico\" a través de la jugabilidad por tiempo limitado \"Sonido atronador\" y \"Recompensa de logro\". \"Canto heroico\" se puede intercambiar por generosas recompensas en \"Palacio del Sueño\", incluyendo la Rueda del destino SR limitada del evento \"Eterna Interpretación\", \"Núcleo Puro\", \"Núcleo de Lumen\", \"Fragmentos de Piedra Sabia\", \"Cristal de Mimesis\", y más.\n2. Durante el evento, completar las misiones de \"Recompensa de logro\" otorgará el avatar limitado del evento \"En el Nombre de la Llave de plata: Hameln\", la Rueda del destino SR limitada del evento \"Eterna Interpretación\", Plata, y una gran cantidad de moneda de evento \"Canto heroico\".\n\n<Title:Duración del evento>\n1. 15 de junio, 9:00 – 13 de julio, 9:00 (GMT+8): Todo el contenido del evento estará disponible.\n2. 13 de julio, 9:00 – 20 de julio, 9:00 (GMT+8): Solo \"Palacio del Sueño\" y \"Recompensa de logro\" permanecerán disponibles. Todo el resto del contenido habrá Terminado y no se podrá acceder.\n\n<Title: Sonido atronador>\n1. \"Sonido atronador\" contiene 9 Niveles, con 1 abriéndose automáticamente cada día.\n2. Cada intento de desafío cuesta Neurobrew × 120. Desafiar diferentes Niveles otorgará diferentes materiales así como la moneda de evento \"Canto heroico\".\n3. Los Niveles de este evento son Niveles de materiales de combate directo. ¡Después de pasarlos, se pueden repetir! Cada repetición cuesta Neurobrew × 120.\n4. Ten en cuenta: Al usar la función de repetición, no se puede obtener Tasa de Sincronización.\n\n<Title: Bonificación de Canto>\n1. Los Guardianes que posean Cuerpos Despertados o Ruedas del destino específicos (no es necesario desplegarlos) pueden recibir bonificaciones adicionales de \"Canto heroico\" en las recompensas de misión de Nivel de \"Sonido atronador\" (incluyendo repeticiones). Las bonificaciones específicas son las siguientes:\n·Cuerpo Despertado \"Hameln\": Despertar Espiritual 0/1/2/3 o superior, bonificación 20%/30%/40%/50%\n·Rueda del destino SSR \"Réquiem Eterno\": Posición superpuesta 0/1/2/3 o superior, bonificación 20%/30%/40%/50%\n·Rueda del destino SR \"Eterna Interpretación\": Posición superpuesta 0/1/2/3 o superior, bonificación 20%/30%/40%/50%\n2. La \"Bonificación de Canto\" de diferentes Cuerpos Despertados o Ruedas del destino se calcula de forma aditiva.\n3. Específicamente, las recompensas del primer desafío pasado en dificultad locura no se ven afectadas por la \"Bonificación de Canto\".\n\n<Title: Palacio del Sueño>\n1. \"Palacio del Sueño\" solo está abierto del 15 de junio, 9:00 al 13 de julio, 9:00 (GMT+8).\n2. Después del 20 de julio, 9:00 (GMT+8), los \"Canto heroico\" restantes no intercambiados se convertirán a razón de Rosa Dorada × 40 por unidad. Por favor, consulta tu correo."
  },
  Activity_139923_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_139924_ActivityName = {
    Text = "Intérprete eterno"
  },
  Activity_139924_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante el evento \"Eternal Performer\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyen a Hameln para experimentar niveles designados infinitamente.\n·Al experimentar los niveles del evento, no se permite hacer ajustes a los Despertadores en la alineación del equipo.\n<Title:Event Rewards>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_139925_ActivityName = {
    Text = "Dama de las profundidades"
  },
  Activity_139925_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n· Durante el evento \"Dama Aequor\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyan a Murphy para experimentar niveles designados de manera infinita.\n· Durante la experiencia de los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n· Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_140080_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_140081_ActivityName = {
    Text = "La llama viviente"
  },
  Activity_140081_ActivityTips = {
    Text = "<Title:Event Rules>\n· Durante el evento \"Señor de las Llamas Explosivas\", los Guardianes pueden usar un equipo preestablecido del sistema que incluye a Kathigu-Ra para experimentar el nivel especificado un número ilimitado de veces.\n· Al experimentar los niveles del evento, no se pueden hacer ajustes a los Despertadores en la alineación.\n<Title:Event Rewards>\n· Al completar por primera vez el desafío de nivel, puedes reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_140082_ActivityName = {
    Text = "Mil Luces Descienden·clon"
  },
  Activity_140082_ActivityPlot = {
    Text = "Cantan alabanzas inolvidables, dando la bienvenida al Señor inmortal.\nÉl vendrá desde el cielo más alto con innumerables destellos, proclamando su gloria eterna.\nCuando Él llegue, una luz ámbar cubrirá el mundo.\nEste es el funeral que Él le ofrece al mundo."
  },
  Activity_140082_ActivityStageEndContent = {
    Text = "El evento ha Terminado. Actualmente, solo \"Base Oculta\" está disponible."
  },
  Activity_140082_ActivityTips = {
    Text = "<Title:Introducción de la actividad>\n1,Durante la actividad, los Guardianes pueden recolectar las monedas de actividad \"Sello de la Riqueza\", \"Sello de la Muerte\" y \"Sello de Guerra\" a través de los modos de juego por tiempo limitado \"Caza de la Ceniza\", \"La Fiesta sin Altercados\" y \"Recompensas de Logros\". Los \"Sello de la Riqueza\", \"Sello de la Muerte\" y \"Sello de Guerra\" pueden usarse para comprar artículos en \"Base Oculta\", incluyendo la Rueda del destino SR de edición limitada \"Sol Impending\", Núcleo de Lumen, Núcleo Puro, entre otros.\n2,Durante la actividad, \"Día polar eterno\" se desbloqueará de forma gratuita por tiempo limitado. ¡Completar los logros de la actividad también te permitirá obtener el avatar de edición limitada \"Por la Llave de Plata: Katie Gula\"!\n\n<Title:Período de la actividad>\n1,Del 7 de septiembre 9:00 al 5 de octubre 9:00 (GMT+8), se puede participar en todos los modos de juego de la actividad.\n2,Del 5 de octubre 9:00 al 12 de octubre 9:00 (GMT+8), solo se puede participar en \"Base Oculta\" y las Recompensas de Logros.\n\n<Title:Caza de la Ceniza>\n1,\"Caza de la Ceniza\" contiene 7 niveles, y se abre automáticamente 1 nivel cada día.\n2,Cada desafío consumirá \"Morfina\" × 120; si el desafío tiene éxito, se obtendrán monedas de actividad.\n3,Después de pasar un nivel, se desbloquea la función \"Repetir\" de ese nivel. Nota: al usar la función \"Repetir\", no se puede obtener Tasa de sincronización.\n4,Puedes usar la Asistencia en batalla de la asociación de exalumnos para ayudarte a pasar los niveles más fácilmente.\n\n<Title: Base Oculta>\n\"Base Oculta\" tiene tres tiendas, con los siguientes horarios de apertura:\n·\"Cofre de Tesoros\": abre el 7 de septiembre a las 9:00.\n·\"Habitación de Comisiones\": abre el 8 de septiembre a las 9:00.\n·\"Campamento de Guerra\": abre el 9 de septiembre a las 9:00.\nEn la tienda puedes seleccionar artículos y comprarlos directamente.\n\n<Title:Bonificación de actividad>\n1,Si los Guardianes poseen ciertos Cuerpos Despertados o Ruedas del destino (no es necesario que estén en el equipo activo), pueden obtener bonificaciones adicionales de caída en las recompensas de misiones del nivel \"Caza de la Ceniza\" para \"Sello de la Riqueza\", \"Sello de la Muerte\" y \"Sello de Guerra\". Las bonificaciones específicas son las siguientes:\n·Cuerpo Despertado \"Katie Gula\": Despertar Espiritual 0/1/2/3 o más, bonificación 20%/30%/40%/50%.\n·Rueda del destino SSR \"Muerte ámbar\": Posición superpuesta 0/1/2/3 o más, bonificación 20%/30%/40%/50%.\n·Rueda del destino SR \"Sol Impending\": Posición superpuesta 0/1/2/3 o más, bonificación 20%/30%/40%/50%.\n2,La \"Bonificación de actividad\" de diferentes Cuerpos Despertados o Ruedas del destino se acumula de forma sumada.\n3,En particular, las recompensas del primer desafío superado en dificultad Locura no se verán afectadas por la \"Bonificación de actividad\".\n\n<Title: La Fiesta sin Altercados>\n1,Se obtienen automáticamente 60 \"Sello de la Riqueza\" por hora, con un máximo de almacenamiento de 25 horas.\n\n<Title:Inmersión en la conciencia>\n1,Durante la actividad, \"Día polar eterno\" se puede desbloquear de forma gratuita.\n2,Después de que termine la actividad, el progreso de investigación de \"Día polar eterno\" se conservará. Completar los eventos de investigación no completados durante la actividad también permitirá obtener las mismas recompensas de investigación que durante la actividad. Si no se desbloqueó \"Día polar eterno\" durante la actividad, aún se puede desbloquear después de que termine consumiendo \"Punto de partida real\" × 3.\n3,Independientemente de si es durante la actividad o no, al pasar \"Inmersión en la conciencia: Día polar eterno\" se puede obtener \"Posse: Sol Eterno\"."
  },
  Activity_140082_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_140188_ActivityName = {
    Text = "Torrente de Enamoramiento"
  },
  Activity_140188_ActivityTips = {
    Text = "<Title:Introducción>\n·Durante el evento, después de que el Guardián haya extraído de forma acumulada una cantidad especificada de Líquido de Origen de Núcleo de Plata en \"Extracción de líquido fuente,\" se pueden reclamar las recompensas correspondientes en \"Torrente de Enamoramiento.\"\n·Ten en cuenta que el Líquido de Origen de Núcleo de Plata regalado en \"Extracción de líquido fuente\" no contará para la cantidad acumulada de extracción de Líquido de Origen de Núcleo de Plata del evento."
  },
  Activity_140188_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_140462_ActivityName = {
    Text = "Prólogo de Todas las Cosas"
  },
  Activity_140462_ActivityTips = {
    Text = "<Title:Introducción>\n·Durante el evento, después de completar los objetivos especificados, los Guardián pueden reclamar las recompensas correspondientes en \"Prólogo de la Naturaleza.\""
  },
  Activity_140462_BannerText = {
    Text = "¡Recibe gratis la ilusión de ropa!"
  },
  Activity_140760_ActivityName = {Text = "Pólux"},
  Activity_140760_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento «Pollux», los Guardianes pueden utilizar equipos preestablecidos del sistema que incluyan a Pollux para experimentar sin límite las misiones designadas.\n· Al jugar las misiones del evento, no se puede ajustar el orden de los personajes despiertos en el equipo.\n<Title:Recompensas del evento>\n· Al completar por primera vez una misión del evento, se podrá reclamar una recompensa de prueba en la interfaz del evento."
  },
  Activity_140761_ActivityName = {
    Text = "Brillo de Mareel"
  },
  Activity_140761_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n· Durante el evento \"Luz Fría\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyan Kepler Sanga para experimentar niveles designados un número ilimitado de veces.\n· Al experimentar niveles del evento, no se pueden realizar ajustes a los Despertadores dentro de la alineación del equipo.\n<Title:Recompensas del Evento>\n· Después de lograr un desafío de nivel por primera vez, se pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_140762_ActivityName = {Text = "Mitsuka"},
  Activity_140762_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento \"Princesa de los Mil Abanicos\", los Secret Keepers pueden usar equipos preestablecidos del sistema que incluyen a la Princesa de los Mil Abanicos para experimentar las etapas designadas un número ilimitado de veces.\n· Durante la experiencia en el evento, no es posible ajustar a los Despertados dentro del equipo.\n<Title:Recompensas del evento>\n· Tras completar el desafío de la etapa por primera vez, podrás reclamar la recompensa de prueba en la interfaz del evento."
  },
  Activity_140763_ActivityName = {
    Text = "Poema sin nombre"
  },
  Activity_140763_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Poema Sin Nombre\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Horla para experimentar niveles designados infinitamente.\n·Mientras experimentan niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_140764_ActivityName = {
    Text = "Señor de Necrovia"
  },
  Activity_140764_ActivityTips = {
    Text = "<Title:Event Rules>\n· Durante el evento \"Señor de los Sepulcros\", los Guardianes pueden utilizar un equipo predeterminado del sistema que incluye a Durusain para experimentar el nivel especificado un número ilimitado de veces.\n· Al experimentar los niveles del evento, no se pueden realizar ajustes a los Despertadores en la alineación.\n<Title:Event Rewards>\n· Al completar por primera vez el desafío de nivel, puedes reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_141306_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_141306_ActivityPlot = {
    Text = "Tras la compra, \"Pontos\" puede activar <BlueQuality:Despertar Espiritual 3>"
  },
  Activity_141307_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_141307_ActivityPlot = {
    Text = [[
Tras la compra, "Pontos" puede activar
<BlueQuality:Desarrollo de la personalidad +4, desbloquear Sobreexaltar>]]
  },
  Activity_141308_ActivityName = {
    Text = "Fuente del Abismo"
  },
  Activity_141308_ActivityTips = {
    Text = "<Title:Reglas del Evento>\nDurante el Evento \"Fuente del Abismo\", los Guardianes pueden usar la Formación predeterminada del sistema que incluye a Pontos para experimentar los Niveles designados de forma ilimitada.\nAl experimentar los Niveles del Evento, los Cuerpos Despertados en la Formación no pueden ajustarse.\n<Title:Recompensas del Evento>\nDespués de completar el desafío de un Nivel por primera vez, se podrán reclamar las recompensas de prueba en la interfaz del Evento."
  },
  Activity_141460_ActivityName = {
    Text = "Divus: la pluma de ónice"
  },
  Activity_141460_ActivityTips = {
    Text = "<Title:Event Rules>\n· Durante el evento \"Sagrado Ala Negra\", los Guardianes pueden utilizar el equipo preestablecido del sistema que incluye a Castor para experimentar etapas específicas indefinidamente.\n· Los Despertadores en la alineación del equipo no pueden ser ajustados durante las etapas del evento.\n<Title:Event Rewards>\n· Después de completar un desafío de etapa por primera vez, se puede reclamar una recompensa de prueba en la interfaz del evento."
  },
  Activity_141462_ActivityName = {
    Text = "Soberano que duerme"
  },
  Activity_141462_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Soberano del Sueño\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Tulu para experimentar niveles designados infinitamente.\n·Al experimentar niveles de evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_141464_ActivityName = {
    Text = "Mil puertas de la diosa Xuan"
  },
  Activity_141464_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento \"Mil puertas de la diosa Xuan\", los Guardianes del secreto pueden usar equipos preestablecidos del sistema que incluyen a Xu para experimentar niveles designados sin límite. \n· Al experimentar niveles del evento, no se puede ajustar el Despertado en la formación. \n<Title:Recompensas del evento>\n· Después de completar el desafío del nivel por primera vez, se pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_141466_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_141467_ActivityName = {
    Text = "Prisionero Espejado·clon"
  },
  Activity_141467_ActivityPlot = {
    Text = "Pájaro, pájaro, ¿por qué tienes grilletes rotos en los pies?\nPájaro, pájaro, ¿por qué lloras solo en lo alto del cielo?\nRompe las espinas, escapa de la jaula, vuelas con tus alas sobre el vasto mar de arena, pero tus tristes llamados no cesan. ¿Quién es, después de todo, el compañero leal que buscas? ¿Dónde está, después de todo, el hogar verdadero que anhelas?"
  },
  Activity_141467_ActivityStageEndContent = {
    Text = "Evento finalizado, actualmente solo disponible \"Avididad de conocimiento\""
  },
  Activity_141467_ActivityTips = {
    Text = "<Title:Introducción de la actividad>\n1,Durante la actividad, los Guardianes pueden recolectar las monedas de actividad \"Libro de sentido común\", \"Libro de matemáticas\" y \"Libro de literatura\" a través de los modos de juego por tiempo limitado \"Vuelo por el cielo azul\", \"Crucero Onírico\" y \"Recompensas de Logros\". Los \"Libro de sentido común\", \"Libro de matemáticas\" y \"Libro de literatura\" pueden usarse para comprar artículos en \"Deseo de conocimiento\", incluyendo la Rueda del destino SR de edición limitada \"Pluma Solitaria\", Núcleo de Lumen, Núcleo Puro, entre otros.\n2,Durante la actividad, \"Mundo de Sueños Extraños: Más allá del horizonte·Arriba\" se desbloqueará de forma gratuita por tiempo limitado. ¡Completar los logros de la actividad también te permitirá obtener el avatar de edición limitada \"Por la Llave de Plata: Castor\"!\n\n<Title:Período de la actividad>\n1,Del 5 de octubre 9:00 al 2 de noviembre 9:00 (GMT+8), se puede participar en todos los modos de juego de la actividad.\n2,Del 2 de noviembre 9:00 al 9 de noviembre 9:00 (GMT+8), solo se puede participar en \"Deseo de conocimiento\" y las Recompensas de Logros.\n\n<Title:Vuelo por el cielo azul>\n1,\"Vuelo por el cielo azul\" contiene 7 niveles, y se abre automáticamente 1 nivel cada día.\n2,Cada desafío consumirá \"Morfina\" × 120; si el desafío tiene éxito, se obtendrán monedas de actividad.\n3,Después de pasar un nivel, se desbloquea la función \"Repetir\" de ese nivel. Nota: al usar la función \"Repetir\", no se puede obtener Tasa de sincronización.\n4,Puedes usar la Asistencia en batalla de la asociación de exalumnos para ayudarte a pasar los niveles más fácilmente.\n\n<Title: Deseo de conocimiento>\n\"Deseo de conocimiento\" tiene tres tiendas, con los siguientes horarios de apertura:\n·\"Clases electivas generales\": abre el 5 de octubre a las 9:00.\n·\"Clase optativa de ciencias\": abre el 6 de octubre a las 9:00.\n·\"Clase optativa de literatura\": abre el 7 de octubre a las 9:00.\nEn la tienda puedes seleccionar artículos y comprarlos directamente.\n\n<Title:Bonificación de actividad>\n1,Si los Guardianes poseen ciertos Cuerpos Despertados o Ruedas del destino (no es necesario que estén en el equipo activo), pueden obtener bonificaciones adicionales de caída en las recompensas de misiones del nivel \"Vuelo por el cielo azul\" para \"Libro de sentido común\", \"Libro de matemáticas\" y \"Libro de literatura\". Las bonificaciones específicas son las siguientes:\n·Cuerpo Despertado \"Castor\": Despertar Espiritual 0/1/2/3 o más, bonificación 20%/30%/40%/50%.\n·Rueda del destino SSR \"Libertad Insoportable\": Posición superpuesta 0/1/2/3 o más, bonificación 20%/30%/40%/50%.\n·Rueda del destino SR \"Pluma Solitaria\": Posición superpuesta 0/1/2/3 o más, bonificación 20%/30%/40%/50%.\n2,La \"Bonificación de actividad\" de diferentes Cuerpos Despertados o Ruedas del destino se acumula de forma sumada.\n3,En particular, las recompensas del primer desafío superado en dificultad Locura no se verán afectadas por la \"Bonificación de actividad\".\n\n<Title: Crucero Onírico>\n1,Se obtienen automáticamente 60 \"Libro de sentido común\" por hora, con un máximo de almacenamiento de 25 horas.\n\n<Title:Mundo de Sueños Extraños>\n1,Durante la actividad, \"Mundo de Sueños Extraños: Más allá del horizonte·Arriba\" se puede desbloquear de forma gratuita.\n2,Después de que termine la actividad, el progreso de investigación de \"Mundo de Sueños Extraños: Más allá del horizonte·Arriba\" se conservará. Completar los eventos de investigación no completados durante la actividad también permitirá obtener las mismas recompensas de investigación que durante la actividad. Si no se desbloqueó \"Mundo de Sueños Extraños: Más allá del horizonte·Arriba\" durante la actividad, aún se puede desbloquear después de que termine consumiendo \"Punto de partida real\" × 7.\n3,Independientemente de si es durante la actividad o no, al pasar \"Mundo de Sueños Extraños: Más allá del horizonte·Arriba\" se puede obtener \"Posse: Desplazamiento del Destino\"."
  },
  Activity_141467_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_141509_ActivityName = {
    Text = "Diario de viaje secreto"
  },
  Activity_141509_ActivityTips = {
    Text = "<Title:Reglas de la actividad>\n1,Tras completar las misiones de archivo designadas, los Guardianes podrán reclamar recompensas en el \"Diario de viaje secreto\".\n2,El \"Diario de viaje secreto\" finalizará el 27 de julio a las 09:00.\n3,Tras desbloquear el \"Archivo Premium\", se podrán reclamar recompensas adicionales al completar las misiones.\n4,Tenga en cuenta: el \"Archivo Premium\" desbloqueado en esta actividad solo es válido para esta actividad. Los Guardianes deben consumir con moderación y responsabilidad."
  },
  Activity_141509_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_141533_ActivityName = {
    Text = "Ebwynnos Evermore"
  },
  Activity_141533_ActivityPlot = {
    Text = "Riamos a carcajadas, celebremos hasta el amanecer.\nQue nuestras garras atraviesen la garganta del enemigo, y que los días mundanos se oxiden en el abismo.\nNunca más nos atraparán la vejez, la mediocridad ni la soledad.\nEste es Ebwynnos, donde somos eternamente felices, donde nos reunimos para siempre.\nNunca nos separaremos."
  },
  Activity_141533_ActivityStageEndContent = {
    Text = "El Evento ha Terminado; actualmente solo se puede participar en los \"Terrenos de Caza\""
  },
  Activity_141533_ActivityTips = {
    Text = "<Title:Introducción de la actividad>\n1,Durante la actividad, los Guardianes pueden recolectar las monedas de actividad \"Nueva \"Presa\" Fresca\", \"\"Presa\" Colosal\" y \"\"Presa\" Primordial\" a través de la actividad por tiempo limitado \"La Gran Cacería de la Casa\" y las \"Recompensas de Logros\", y canjearlas en \"Terrenos de Caza\" por productos, incluyendo la Rueda del destino SR de edición limitada \"La Brújula Errante\", Núcleo de Lumen, Núcleo Puro, entre otros.\n2,Durante la actividad, \"Inmersión en la conciencia: Ebwynnos Evermore\" estará disponible de forma gratuita por tiempo limitado. ¡Completar los logros de la actividad también permitirá obtener el avatar de edición limitada \"Por la Llave de Plata: Pontos\"!\n\n<Title:Período de la actividad>\n1,Del 29 de junio a las 9:00 al 27 de julio a las 9:00 (GMT+8), se puede participar en todas las actividades de juego.\n2,Del 27 de julio a las 9:00 al 3 de agosto a las 9:00 (GMT+8), solo se puede participar en \"Terrenos de Caza\" y las Recompensas de Logros.\n\n<Title:La Gran Cacería de la Casa>\n1,\"La Gran Cacería de la Casa\" contiene 7 Niveles, y se abre automáticamente 1 cada día.\n2,Cada desafío consumirá \"Morfina\" × 120; si el desafío tiene éxito, se obtendrán monedas de actividad.\n3,Tras Pasar un Nivel, se desbloquea la función \"Repetir\" de dicho Nivel. Tenga en cuenta: al usar la función \"Repetir\", no se puede obtener Tasa de sincronización.\n4,Puedes usar la Asistencia en batalla de la asociación de exalumnos para ayudarte a superar los Niveles con mayor facilidad.\n\n<Title: Terrenos de Caza>\n\"Terrenos de Caza\" cuenta con tres tiendas, con los siguientes horarios de apertura:\n·\"Hierro Frío\": Apertura el 29 de junio a las 9:00.\n·\"Fuego y Azufre\": Apertura el 30 de junio a las 9:00.\n·\"Hechicería\": Apertura el 1 de julio a las 9:00.\nEn las tiendas se pueden seleccionar productos para comprarlos directamente.\n\n<Title:Bonificación de la actividad>\n1,Si los Guardianes poseen ciertos Cuerpos Despertados o Ruedas del destino específicos (no es necesario que estén en el equipo activo), podrán obtener bonificaciones adicionales de caída de los tres tipos de monedas de actividad en las recompensas de misiones de los Niveles de \"La Gran Cacería de la Casa\":\n·Cuerpo Despertado \"Pontos\": Despertar Espiritual 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n·Rueda del destino SSR \"Jaula Viviente\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n·Rueda del destino SR \"La Brújula Errante\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n2,Las \"Bonificaciones de la actividad\" de diferentes Cuerpos Despertados o Ruedas del destino se acumulan entre sí.\n3,En particular, las recompensas de la primera pasada en dificultad locura no se verán afectadas por la \"Bonificación de la actividad\".\n\n<Title:Inmersión en la conciencia>\n1,Durante la actividad, \"Inmersión en la conciencia: Ebwynnos Evermore\" puede desbloquearse de forma gratuita.\n2,Tras finalizar la actividad, el progreso de investigación se conservará; completar los Eventos de investigación no completados durante la actividad también permitirá obtener las recompensas correspondientes. Si no se desbloqueó durante la actividad, aún se podrá desbloquear consumiendo \"Punto de partida real\" × 3 después de que finalice la actividad.\n3,Independientemente de si se está en el período de la actividad o no, tras Pasar \"Inmersión en la conciencia: Ebwynnos Evermore\" siempre se podrá obtener la \"Posse: Hombre hueco\"."
  },
  Activity_141533_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_141534_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_141535_ActivityName = {
    Text = "El verano eterno bajo la luz del Sol Negro·clon"
  },
  Activity_141535_ActivityPlot = {
    Text = "Verano, playa, sol abrasador y muchos rostros conocidos.\nBajo la luz del sol negro, olvida todo y sumérgete en esta ilusión desbordante que satisface todos tus anhelos."
  },
  Activity_141535_ActivityTips = {
    Text = "<Title:Introducción de la actividad>\n1,Durante la actividad, ¡\"Mundo de Sueños Extraños: Adiós Nunca Jamás\" estará disponible de forma gratuita por tiempo limitado!\n2,Durante la actividad, al iniciar sesión acumulando 7 días se podrá obtener \"Núcleo de Lumen\" × 10 en \"Fiesta estival sin fin\"; el día 7 se podrá obtener adicionalmente el avatar de combate de edición limitada \"Voleibol 'Gran General'\".\n\n<Title:Período de la actividad>\n1,Del 6 de julio a las 9:00 al 20 de julio a las 9:00 (GMT+8), se puede participar en todas las actividades.\n\n<Title:Mundo de Sueños Extraños>\n1,Durante la actividad, \"Mundo de Sueños Extraños: Adiós Nunca Jamás\" puede desbloquearse de forma gratuita.\n2,Tras finalizar la actividad, el progreso de investigación de \"Mundo de Sueños Extraños: Adiós Nunca Jamás\" se conservará; completar los Eventos de investigación no completados durante la actividad también permitirá obtener las mismas recompensas de investigación que durante la actividad. Si no se desbloqueó \"Mundo de Sueños Extraños: Adiós Nunca Jamás\" durante la actividad, aún se podrá desbloquear consumiendo \"Punto de partida real\" × 7 después de que finalice la actividad.\n3,Independientemente de si se está en el período de la actividad o no, tras Pasar \"Mundo de Sueños Extraños: Adiós Nunca Jamás\" siempre se podrá obtener la \"Posse: Recuerdo del verano inmovilizado\"."
  },
  Activity_141535_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_141536_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_142866_ActivityName = {
    Text = "Origen Dama del Mar Profundo"
  },
  Activity_142866_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento \"Dama del Mar Profundo Primordial\", los Secret Keepers pueden usar equipos preestablecidos que incluyan a \"Dama del Mar Profundo Primordial\" para experimentar las etapas designadas sin límite de veces.\n· Durante las etapas del evento, no se puede ajustar la formación de entidades despiertas dentro del equipo.\n<Title:Recompensas del evento>\n· Tras completar el desafío de la etapa por primera vez, podrás reclamar la recompensa de prueba en la interfaz del evento.\n"
  },
  Activity_142867_ActivityName = {
    Text = "Cazadora de cráneos"
  },
  Activity_142867_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Cazadora de Calaveras\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Narciso para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_143933_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_144359_ActivityName = {
    Text = "Testigo de Todo"
  },
  Activity_144359_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Después de completar las tareas designadas de Crónicas del Guardián del Secreto, los Guardianes pueden reclamar recompensas en \"Testigo de Todo\".\n2. \"Testigo de Todo\" finalizará el 24 de agosto a las 9:00.\n3. Desbloquea el \"Archivo Premium\" para reclamar recompensas adicionales al completar tareas.\n4. Ten en cuenta: El \"Archivo Premium\" desbloqueado en este evento solo es válido para este evento. Guardianes, por favor, consuman de forma racional."
  },
  Activity_144359_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_145382_ActivityName = {
    Text = "Caída de la Ballena"
  },
  Activity_145382_ActivityTips = {
    Text = "<Title:Reglas del evento>\nDurante el evento \"Caída de la Ballena\", los Guardianes pueden usar alineaciones preestablecidas por el sistema que incluyen a \"Lotan: Cetarconte\" para experimentar las fases designadas un número ilimitado de veces.\n Al experimentar las fases del evento, los Despertados de la alineación no pueden ajustarse.\n<Title:Recompensas del evento>\nDespués de completar el desafío de la fase por primera vez, puedes reclamar las recompensas de prueba en la interfaz del evento."
  },
  Activity_145383_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_145383_ActivityPlot = {
    Text = "Tras la compra, \"Lotan: Cetarconte\" puede activar <BlueQuality:Despertar Espiritual 3>"
  },
  Activity_145384_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_145384_ActivityPlot = {
    Text = "Tras la compra, \"Lotan: Cetarconte\" puede activar\n<BlueQuality:Desarrollo de la personalidad +4, Desbloquear Exaltación Excesiva>"
  },
  Activity_145458_ActivityName = {
    Text = "El Juego del Leviatán"
  },
  Activity_145458_ActivityPlot = {
    Text = "Héroes codiciosos anhelan tronos inmortales, madres desesperadas buscan hijos resucitados, y magos enloquecidos tienen hambre de conocimiento prohibido—se arrodillan ante Él, suplicando con las mismas palabras que Él ha escuchado durante más de diez mil años.\nÉl les concede todo, solo para verlos perderlo todo. Ha sido testigo de cuatro mil brutales contiendas, y aun así permanece insaciable.\nEsta vez, las puertas de la arena se abren para ti. Ven, dile—¿qué es lo que deseas?\nDile en qué te diferencias de esas cuatro mil almas caídas."
  },
  Activity_145458_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Texto temporal\""
  },
  Activity_145458_ActivityTips = {
    Text = "<Title:Descripción del evento>\nDurante el evento, los Guardianes pueden recolectar la moneda del evento \"Sacrificio Carmesí\" a través del modo de juego de tiempo limitado \"Codicia y Sed de Sangre\" y los \"Logros\". El \"Sacrificio Carmesí\" puede canjearse por recompensas en el \"Altar de la Arena\", incluyendo la Rueda del destino SR exclusiva \"Huesohambrienta Inmortal\", Núcleo de Lumen, Núcleo Puro, Fragmentos de Piedra Sabia, Cristal de Mimesis y más.\n\n<Title:Codicia y Sed de Sangre>\n1. \"Codicia y Sed de Sangre\" contiene 5 fases, con 1 fase que se desbloquea automáticamente cada 2 días.\n2. Cada desafío consume 120 de Morfina. Completar un desafío con éxito recompensa con la moneda del evento \"Sacrificio Carmesí\".\n3. Después de superar una fase, se desbloquea la función \"Repetir\" para esa fase. Ten en cuenta: no se puede obtener Tasa de sincronización al usar la función \"Repetir\".\n4. Puedes usar el Apoyo de Exalumnos para ayudarte a superar las fases más fácilmente.\n\n<Title:Bonificación del evento>\n1. Los Guardianes que posean Despertados o Ruedas del destino específicos (no es necesario que estén desplegados) pueden obtener bonificaciones adicionales de botín de \"Sacrificio Carmesí\" en las recompensas de misiones de fase de \"Codicia y Sed de Sangre\" (incluyendo Repetir). Las bonificaciones específicas son las siguientes:\nDespertado \"Lotan: Cetarconte\": Despertar Espiritual 0/1/2/3 o superior, bonificación 20%/30%/40%/50%.\nRueda del destino SSR \"Cetus Occasus\": Posición superpuesta 0/1/2/3 o superior, bonificación 20%/30%/40%/50%.\nRueda del destino SR \"Huesohambrienta Inmortal\": Posición superpuesta 0/1/2/3 o superior, bonificación 20%/30%/40%/50%.\n2. Las \"Bonificaciones del evento\" de diferentes Despertados o Ruedas del destino se calculan de forma acumulativa.\n3. En particular, las recompensas de primera superación de los desafíos de dificultad locura no se ven afectadas por las bonificaciones anteriores.\n\n<Title:Inmersión en la conciencia>\n1. Durante el evento, \"Inmersión en la conciencia: Hasta que Caiga el Cetus\" puede desbloquearse de forma gratuita.\n2. Después de que el evento termine, el progreso de investigación de \"Inmersión en la conciencia: Hasta que Caiga el Cetus\" se conservará. Completar Eventos de investigación que no se terminaron durante el evento seguirá recompensando con las mismas recompensas de investigación que durante el evento. Si \"Inmersión en la conciencia: Hasta que Caiga el Cetus\" no se desbloqueó durante el evento, aún puede desbloquearse después de que el evento termine consumiendo \"Punto de partida real\" ×3.\n3. Independientemente de si es durante el período del evento o no, superar \"Inmersión en la conciencia: Hasta que Caiga el Cetus\" recompensará con \"Posse: Tormenta Devoradora de Cetus\".\n\n<Title:Duración del evento>\n1. 27 de julio, 9:00 - 24 de agosto, 9:00 (GMT+8): Todo el contenido de la Descripción del evento está disponible.\n2. 24 de agosto, 9:00 - 31 de agosto, 9:00 (GMT+8): Solo el \"Altar de la Arena\" y las \"Recompensas de Logros\" permanecen disponibles; todo el demás contenido ha finalizado y ya no es accesible.\n3. Después del 31 de agosto a las 9:00 (GMT+8), cualquier \"Sacrificio Carmesí\" restante sin canjear se convertirá a una tasa de 40 Rosa Dorada por unidad. Por favor, revisa tu correo, Guardianes."
  },
  Activity_145458_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_145459_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_145465_ActivityName = {
    Text = "Si todo sigue igual: Actividad Despertar Clon"
  },
  Activity_145465_ActivityPlot = {
    Text = "¿Alguna vez has imaginado cómo sería la vida de todos si la catástrofe no hubiera llegado? \n Tu poder para salvar el mundo ya no tiene lugar donde utilizarse, y cada día tienes que luchar por la vida cotidiana en el campus y ganar unos míseros créditos. En el patio ya no hay figuras entrenando para la batalla, en su lugar hay filas de carpas para actividades de clubes, junto con gritos de promoción y risas; cuando suena el timbre de salida, los estudiantes hambrientos se apresuran a llenar el comedor... \n Al tocar la puerta de las personas que te importan, ¿qué sonrisas verías?"
  },
  Activity_145465_ActivityStageEndContent = {
    Text = "【Si todo como siempre】Evento finalizado, actualmente solo puedes participar en \"Edificio de la Asociación de Estudiantes\""
  },
  Activity_145465_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, puedes recolectar la moneda del evento \"Concha de especialidad costera\" a través del modo de juego de tiempo limitado \"Nada nuevo bajo la luz del sol\". Puedes usar las \"Conchas de especialidad costera\" para comprar objetos en el \"Edificio de la oficina del consejo estudiantil\", incluyendo Núcleo de Lumen, Núcleo Puro, Fragmentos de Piedra Sabia y más.\n2. Durante el evento, ¡\"Mundo de Sueños Extraños: Adiós, Nunca Jamás\" estará disponible para acceso gratuito por tiempo limitado!\n\n<Title:Duración del evento>\n1. 3 de agosto, 9:00 AM - 17 de agosto, 9:00 AM (GMT+8): todo el contenido del evento está disponible.\n2. 17 de agosto, 9:00 AM - 24 de agosto, 9:00 AM (GMT+8): solo puedes participar en el \"Edificio de la oficina del consejo estudiantil\" y reclamar Recompensas de Logros.\n\n<Title:Nada nuevo bajo la luz del sol>\n1. \"Nada nuevo bajo la luz del sol\" consta de 5 niveles, con uno que se abre automáticamente cada 2 días.\n2. Cada desafío consumirá 120 de Morfina, y los desafíos completados con éxito te otorgarán moneda del evento.\n3. Después de completar un nivel, se desbloqueará la función \"Repetir\" para ese nivel. Nota: Cuando uses la función \"Repetir\", no podrás obtener Tasa de sincronización.\n4. Puedes solicitar la ayuda de Exalumnos para facilitar la superación de los niveles.<Title:Edificio de la oficina del consejo estudiantil>\nEl \"Edificio de la oficina del consejo estudiantil\" tiene una tienda que abre el 3 de agosto a las 9:00 AM.\nEn la tienda, puedes seleccionar objetos para compra directa.\n\n<Title:Mundo de Sueños Extraños>\n1. Durante el evento, puedes desbloquear \"Mundo de Sueños Extraños: Adiós, Nunca Jamás\" de forma gratuita.\n2. Después de que el evento termine, tu progreso de investigación en \"Mundo de Sueños Extraños: Adiós, Nunca Jamás\" se conservará. Completar cualquier evento de investigación sin terminar del período del evento seguirá otorgándote recompensas de investigación consistentes con el período del evento. Si no desbloqueaste \"Mundo de Sueños Extraños: Adiós, Nunca Jamás\" durante el evento, aún puedes desbloquearlo después del evento consumiendo \"Punto de partida real\" *7.\n3. Independientemente de si es durante el evento o no, completar \"Mundo de Sueños Extraños: Adiós, Nunca Jamás\" te otorgará \"Posse: Momento de un Sueño Hermoso\"."
  },
  Activity_145465_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_145466_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_145717_ActivityName = {
    Text = "Luna Nueva y Nieve Profunda"
  },
  Activity_145717_ActivityPlot = {
    Text = "El séptuple rito de adoración, el triple juramento sagrado: lleva una fe devota en la hada de blanco puro y escala hasta donde el cielo y la nieve se encuentran, y ella concederá cada uno de tus deseos. Absolutamente todos. Cada alma tiene su propósito, y bajo cada propósito yace su propia mentira. Desentiérralos. Sácalos a la luz... antes de rendirte ante la superficie impecable de su relato. No te hundas en esta nieve profunda a su lado."
  },
  Activity_145717_ActivityStageEndContent = {
    Text = "El evento ha finalizado. Actualmente, solo están disponibles los \"Rituales del Hada\"."
  },
  Activity_145717_ActivityTips = {
    Text = "<Title:Resumen del evento>\n1. Durante el evento, los Gardianes del secreto pueden recolectar las monedas del evento \"Manzana Carmesí\", \"Manzana de Oro\" y \"Manzana de Caramelo\" a través del modo de juego de tiempo limitado \"Tesoros de Umapati\" y \"Logros\", y canjearlas por artículos en la \"Ceremonia del Hada\", incluyendo la Rueda del destino SR exclusiva \"Verdad hermosa\", Núcleo de Lumen, Núcleo Puro y más.\n2. ¡Completar los logros del evento durante el evento también puede recompensar el avatar exclusivo \"Por la Llave de Plata: Caraboo\"!\n\n<Title:Duración del evento>\n1. Agosto 24, 9:00 – Septiembre 21, 9:00 (GMT+8): Todo el modo de juego del evento está disponible.\n2. Septiembre 21, 9:00 – Septiembre 28, 9:00 (GMT+8): Solo están disponibles los \"Rituales del Hada\" y las recompensas de logros.\n<Title:Tesoros de Umapati>\n1. \"Tesoros de Umapati\" contiene 7 fases, con 1 fase desbloqueada automáticamente cada día.\n2. Cada desafío consume 120 Morfina. Completar un desafío con éxito recompensa con moneda del evento.\n3. Tras superar una fase, se desbloquea la función \"Reproducir\" para esa fase. Por favor, tenga en cuenta: la Tasa de sincronización no se puede obtener al usar la función \"Reproducir\".\n4. Puedes usar el Apoyo de Exalumnos para ayudarte a superar las fases más fácilmente.\n\n<Title: Rituales del Hada>\n1. \"Rituales del Hada\" tiene tres tiendas, con los siguientes horarios de apertura:\n\"Bendición de Nieve\": Abre a las 9:00 del 24 de agosto.\n\"Bendición de Escarcha\": Abre a las 9:00 del 25 de agosto.\n\"Bendición de Blancura\": Abre a las 9:00 del 26 de agosto.\n2. Cada \"Recibir Bendiciones\" consumirá 750 \"Manzana Carmesí\"/\"Manzana de Oro\"/\"Manzana de Caramelo\" para obtener aleatoriamente cinco recompensas de objetos de los \"Rituales del Hada\".\n3. Las recompensas de objetos en cada \"Rituales del Hada\" se dividen en dos tipos: \"Objeto especial\" y \"Objeto normal\". Durante un reinicio, la cantidad restante de recompensas de Objeto especial puede restablecerse al límite. Las reglas específicas son las siguientes:\n(1) Primeros 2 Reinicios: Cuando los \"Objetos especiales\" no tengan cantidad restante, los Gardianes del secreto pueden elegir reiniciar, lo que restablecerá las cantidades restantes tanto de \"Objetos especiales\" como de \"Objetos normales\" al límite; o pueden elegir continuar canjeando. Cuando los \"Objetos normales\" tampoco tengan cantidad restante, se debe realizar un reinicio para continuar canjeando.\n(2) A partir del 3er Reinicio: Solo se puede realizar un reinicio cuando los \"Objetos normales\" no tengan cantidad restante. El reinicio restaurará la cantidad restante de \"Objetos normales\" al límite, mientras que los \"Objetos especiales\" ya no se reiniciarán.\n\n<Title:Bonificación del evento>\n1. Los Gardianes del secreto que posean Despertados o Ruedas del destino específicos (no es necesario que estén desplegados) pueden obtener bonificaciones de botín adicionales para las tres monedas del evento en las recompensas de misiones de fase de \"Tesoros de Umapati\":\nDespertado \"Caraboo\": Despertar Espiritual 0/1/2/3 o superior, bonificación 20%/30%/40%/50%.\nRueda del destino SSR \"Engaño Meloso\": Posición superpuesta 0/1/2/3 o superior, bonificación 20%/30%/40%/50%.\nRueda del destino SR \"Verdad hermosa\": Posición superpuesta 0/1/2/3 o superior, bonificación 20%/30%/40%/50%.\n2. Múltiples \"Bonificaciones del evento\" pueden acumularse y calcularse juntas.\n3. Por favor, tenga en cuenta: Las recompensas de primera superación de los desafíos de dificultad Locura no se ven afectadas por la \"Bonificación del evento\"."
  },
  Activity_145717_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_146540_ActivityName = {
    Text = "Ofrenda Conmemorativa de la Travesía·Capítulo de las Estrellas VI"
  },
  Activity_146540_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_146541_ActivityName = {
    Text = "Archivos de Hiperbórea"
  },
  Activity_146541_ActivityTips = {
    Text = "Reglas del evento:\n1. Completa tareas para reclamar recompensas en Archivos de Hiperbórea\n2. Los Archivos de Hiperbórea permanecen accesibles de forma permanente\n3. Desbloquea el Archivo Premium para obtener recompensas adicionales al completar tareas\nNota: El Archivo Premium activado solo tiene efecto en este evento de Archivos."
  },
  Activity_146799_ActivityName = {
    Text = "Texto temporal"
  },
  Activity_146799_ActivityPlot = {
    Text = "Texto temporal"
  },
  Activity_146799_ActivityStageEndContent = {
    Text = "Texto temporal"
  },
  Activity_146799_ActivityTips = {
    Text = "Texto temporal"
  },
  Activity_146799_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_147423_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_147423_ActivityPlot = {
    Text = "Tras la compra, \"Tinct: Vespera\" puede activar<BlueQuality:Despertar Espiritual 3>"
  },
  Activity_147424_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_147424_ActivityPlot = {
    Text = "Tras la compra, \"Tinct: Vespera\" puede activar\n<BlueQuality:Profundización de Personalidad +4, desbloquear Sobreexaltar>"
  },
  Activity_147425_ActivityName = {
    Text = "Texto temporal"
  },
  Activity_147425_ActivityTips = {
    Text = "<Title:Reglas del evento>\nDurante el evento \"Origen: Poder Real\", los Gardianes del secreto pueden usar equipos preestablecidos por el sistema que incluyan a Origen: Poder Real para experimentar los niveles designados un número ilimitado de veces.\nAl experimentar los niveles del evento, no se pueden realizar ajustes a los Despertados en la formación del equipo.\n<Title:Recompensas del evento>\nTras completar el desafío del nivel por primera vez, puedes reclamar las recompensas de demostración en la interfaz del evento."
  },
  Activity_147426_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_148119_ActivityName = {
    Text = "Tiempo Extracurriculares"
  },
  Activity_148119_ActivityTips = {
    Text = "<Title:Resumen del evento>\n1. Tras completar las tareas designadas de Crónicas del Guardián del Secreto, los Gardianes del secreto pueden reclamar recompensas en \"Horas Extraescolares\".\n2. \"Horas Extraescolares\" finalizará el 21 de septiembre a las 9:00.\n3. Desbloquea el \"Archivo Premium\" para reclamar recompensas adicionales al completar tareas.\n4. Por favor, tenga en cuenta: El \"Archivo Premium\" desbloqueado en este evento solo es válido para este evento. Gardianes del secreto, por favor consuman de forma racional."
  },
  Activity_148119_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_148889_ActivityName = {
    Text = "Origen de Ogier"
  },
  Activity_148889_ActivityTips = {
    Text = "<Title:Reglas del evento>\n·Durante el evento \"Origen Ogier\", los Guardianes pueden usar equipos predefinidos del sistema que incluyen a Origen Ogier para experimentar los Niveles designados un número ilimitado de veces.\n·Al experimentar los Niveles del evento, los Cuerpos Despertados en la Formación no se pueden ajustar.\n<Title:Recompensas del evento>\n·Tras completar un desafío de Nivel por primera vez, se pueden reclamar las recompensas de prueba en la página del evento."
  },
  Activity_15788_ActivityName = {
    Text = "Estética de alquimia"
  },
  Activity_15788_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estética de la alquimia\", después de que el Guardián pase \"Búsqueda de cupones de oro\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_15791_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_15791_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", después de que el Guardián pase \"Preparación y afilado\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_15793_ActivityName = {
    Text = "Sombra de la ciudad lluviosa"
  },
  Activity_15793_ActivityPlot = {
    Text = "Cada noche lluviosa viene acompañada de decepción y soledad.\nAlgunos pierden el amor, otros pierden la dignidad.\nY algunos pierden la cabeza."
  },
  Activity_15793_ActivityTips = {
    Text = "<Title:Condiciones de Participación>\n·Completa \"Operación de Investigación\" 2-9 (Normal) para participar.\n<Title:Evento de Investigación>\n·Durante el período del evento, se lanzará diariamente un nuevo evento de investigación en \"Sombras de la Ciudad de Lluvia\". Los Guardianes pueden desbloquear e investigar sin consumir inventario. Después de completar el evento de investigación, se pueden obtener recompensas como Núcleo Puro, Insignia de Investigación y Experiencia de Guardián.\n·Después de que termine el evento, el progreso de la investigación de \"Sombras de la Ciudad de Lluvia\" se mantendrá. Los Guardianes pueden consumir D-joyas en el Registro Especial para desbloquear investigaciones no completadas. Completar eventos de investigación no finalizados durante el período del evento también otorgará recompensas consistentes con las de durante el evento.<Title:Recompensas por Tiempo Limitado>\n·Las recompensas por tiempo limitado estarán disponibles durante el evento. ¡Los Guardianes pueden obtener Núcleo Puro, Piedra Filosofal y recompensas de Plata después de completar \"Sombras de la Ciudad de Lluvia\" (modo Normal) y completar eventos de investigación de \"Sombras de la Ciudad de Lluvia\"! Las recompensas por tiempo limitado solo están disponibles durante el período del evento y no se pueden completar ni reclamar después de que termine el evento."
  },
  Activity_15793_UnlockConditionExplanation = {
    Text = "Desbloquea después de completar \"Operación de Investigación\" 2-9 · Normal"
  },
  Activity_15797_ActivityName = {
    Text = "Soberano que duerme"
  },
  Activity_15797_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Soberano del Sueño\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Tulu para experimentar niveles designados infinitamente.\n·Al experimentar niveles de evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_15805_ActivityName = {
    Text = "Viaje por la ciudad neblinosa"
  },
  Activity_15805_ActivityTips = {
    Text = "\nReglas del Evento:\n1. Después de completar las tareas de viaje especificadas, los Guardianes pueden reclamar recompensas en \"Viaje a la Ciudad de la Neblina\".\n2. \"Viaje a la Ciudad de la Neblina\" está abierto de forma permanente.\n3. Después de desbloquear \"Viaje Avanzado\", los Guardianes pueden recibir recompensas adicionales al completar tareas.\n4. Tenga en cuenta: El \"Viaje Avanzado\" desbloqueado en este evento es solo válido durante este evento. Se recomienda que los Guardianes consuman razonablemente."
  },
  Activity_15809_ActivityName = {
    Text = "Semilla Estelar (Caducada)"
  },
  Activity_15809_ActivityTips = {
    Text = "Reglas del evento:\nDespués de que el Guardián complete las tareas designadas, las recompensas se podrán reclamar en \"Brote Estelar\"."
  },
  Activity_15818_ActivityName = {
    Text = "Tallador (Caducado)"
  },
  Activity_15818_ActivityTips = {
    Text = "Reglas del evento:\nUna vez que el Guardián de Secretos complete las tareas designadas, podrá reclamar las recompensas en \"La Escultora.\""
  },
  Activity_15821_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_15821_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_15825_ActivityName = {
    Text = "Poema Sin Nombre (Caducado)"
  },
  Activity_15825_ActivityTips = {
    Text = "Reglas del evento:\nUna vez que el Guardián de Secretos complete las tareas designadas, podrá reclamar las recompensas en \"Poema Anónimo.\""
  },
  Activity_15828_ActivityName = {
    Text = "Ceremonia de entrada"
  },
  Activity_15828_ActivityTips = {
    Text = "\nReglas del Evento:\n1. Los Guardianes pueden recoger recompensas en \"Ceremonia de Entrada\" cuando su nivel de investigación alcance 5/15/25/35/45/55. \n2. La experiencia del guardián se puede obtener a través de los niveles de investigación y los interludios."
  },
  Activity_20344_ActivityName = {
    Text = "Encuentro sin luz"
  },
  Activity_20344_ActivityTips = {
    Text = "\nReglas del Evento:\n1. Después de completar las tareas de viaje especificadas, los Guardianes pueden reclamar recompensas en \"Vista Inicial Sin Luz\".\n2. \"Vista Inicial Sin Luz\" está permanentemente abierta."
  },
  Activity_20683_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_20683_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", después de que el Guardián pase \"Residuo dimensional\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_20684_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_20684_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", después de que el Guardián pase \"Garganta de Schwarzschild\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_20685_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_20685_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", después de que el Guardián pase \"Residuo orgánico\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_20686_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_20686_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", después de que el Guardián pase \"Ruinas de Ponape\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_20687_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_20687_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", después de que el Guardián pase \"Cluster caótico\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_20688_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_20688_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", después de que el Guardián pase \"Nido de gusanos\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_20689_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_20689_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", después de que el Guardián pase \"Residuo de las Abejas\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_20690_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_20690_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", después de que el Guardián pase \"Residuo turbio\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_20691_ActivityName = {
    Text = "Cazadora de cráneos"
  },
  Activity_20691_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Cazadora de Calaveras\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Narciso para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_21502_ActivityName = {
    Text = "Apóstol del mar"
  },
  Activity_21502_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n· Durante el evento \"Apóstol del Mar\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyan a Miryam para experimentar niveles designados de manera infinita.\n· Al experimentar los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n· Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_21781_ActivityName = {
    Text = "Caja de Selección del Curriculum"
  },
  Activity_21781_ActivityPlot = {
    Text = "Completa la misión para elegir un Despertador específico de \"Estudio del Reino\" o una rueda específica de destino de \"Aspecto de Rotación\"!"
  },
  Activity_21781_ActivityTips = {
    Text = "Reglas del evento:\n1. Acumular 50 Despertares, iniciar sesión durante 3 días e iniciar sesión durante 7 días otorgará recompensas de \"Parque prototípico\". \"Parque prototípico\" se puede usar en \"Suministros: Consumibles\". Al usarlo, podrás seleccionar 1 Cuerpo Despertado específico de \"Estudio de dominio\" para Despertar.\n2. Acumular 300 Despertares, 1000 Despertares e iniciar sesión durante 30 días otorgará recompensas de \"Libro de rotación\". \"Libro de rotación\" se puede usar en \"Suministros: Consumibles\". Al usarlo, podrás seleccionar 1 Rueda del destino específica de \"Fase de Rotación\" para obtener."
  },
  Activity_22367_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_22367_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_23671_ActivityName = {
    Text = "Duelo de inmersión profunda"
  },
  Activity_23671_ActivityPlot = {
    Text = "Durante el evento, la Experiencia del Guardián de Secretos obtenida por el Guardián de Secretos a través de \"Inmersión fantasmal\" y \"Fase de Duelo\" se duplicará, con un límite diario aumentado a 480 puntos."
  },
  Activity_23671_ActivityTips = {
    Text = "\nReglas del Evento:\n1. Durante el evento \"Inmersión Fantasmal y Traphase\", el Guardián recibirá el doble de experiencia del Guardián por \"Inmersión Fantasmal\" y \"Traphase,\" con un límite diario aumentado a 480 puntos. Si el sujeto principal también está desbloqueado, la experiencia del Guardián obtenida a través de esta ruta se duplicará nuevamente, manteniendo el límite diario en 480 puntos.\n2. Cualquier experiencia del Guardián doble no utilizada para el día se reiniciará a las 9:00 AM (GMT+8) al día siguiente, así que recuerda usarla a tiempo, Guardián~"
  },
  Activity_23693_ActivityName = {
    Text = "Descendiente Pálido"
  },
  Activity_23693_ActivityPlot = {
    Text = "Cuenta la leyenda que bajo Londinium existe una única Puerta.\nConduce al dominio de la Señora Pálida..."
  },
  Activity_23693_ActivityTips = {
    Text = "<Title:Condiciones de Participación>\n· La participación está disponible después de completar el modo normal de la vaganza de conciencia \"Deseo del Caballero\". \n<Title:Eventos de Investigación>\n· Durante el período del evento, se lanzará un nuevo evento de investigación diariamente en \"Descendiente Pálido\". Los Guardianes pueden desbloquear y realizar investigaciones sin consumir ningún inventario, y completar eventos de investigación otorgará recompensas como núcleos puros, insignias de investigación y experiencia del guardián.\n· Después de que termine el evento, el progreso de la investigación en \"Descendiente Pálido\" se conservará. Los Guardianes pueden desbloquear cualquier investigación bloqueada en la vaganza de conciencia consumiendo D-joyas, y completar cualquier evento de investigación no terminado durante el período del evento también otorgará recompensas de investigación consistentes con las disponibles durante el evento.<Title:Recompensas por Tiempo Limitado>\n· Las recompensas por tiempo limitado estarán disponibles durante el período del evento. ¡Los Guardianes pueden recibir el Candado Oscuro y recompensas de Plata después de completar el modo normal de \"Descendiente Pálido\" y finalizar sus eventos de investigación! Las recompensas por tiempo limitado solo están disponibles durante el evento y no se pueden completar ni reclamar después de que termine."
  },
  Activity_23693_UnlockConditionExplanation = {
    Text = "Complete el vagabundeo \"Deseo del Caballero\" para desbloquear después"
  },
  Activity_23723_ActivityName = {
    Text = "Se avecina una tormenta"
  },
  Activity_23723_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento, el Capítulo 5 de la Operación de investigación estará temporalmente cerrado. El Posse \"Obsesión eterna\" se podrá obtener temporalmente al pasar el Capítulo 4 de la Operación de investigación.\n2. Tras finalizar el evento, el Capítulo 5 de la Operación de investigación se reabrirá y el Posse \"Obsesión eterna\" volverá a requerir pasar el Capítulo 5 de la Operación de investigación.\n3. Además, todas las Recompensas de logro del Capítulo 5 obtenidas previamente, los Logros de Nivel, las recompensas de exploración y las Recompensas por completar se conservarán. Cuando se reabra (actualmente previsto para el 27 de diciembre), el progreso completado relacionado se mantendrá en la medida de lo posible, por lo que no será necesario repetirlo."
  },
  Activity_23870_ActivityName = {
    Text = "Inferencia de Traphase"
  },
  Activity_23870_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento, completa las misiones del evento para recibir recompensas.\n2. Una vez finalizado el evento, las recompensas no reclamadas ya no podrán ser reclamadas. Guardianes de Secretos, recuerden reclamarlas a tiempo～"
  },
  Activity_23936_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23936_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo de las Abejas\", sin límite diario."
  },
  Activity_23937_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23937_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% extra de recompensa de materiales (excluyendo Experiencia del Guardián de Secretos y Rosa Dorada) al investigar o Repetir en \"Cluster caótico\", sin límite diario."
  },
  Activity_23938_ActivityName = {
    Text = "Duelo de inmersión profunda"
  },
  Activity_23938_ActivityPlot = {
    Text = "Durante el evento, la Experiencia del Guardián de Secretos obtenida por el Guardián de Secretos a través de \"Inmersión fantasmal\" y \"Fase de Duelo\" se duplicará, con un límite diario aumentado a 480 puntos."
  },
  Activity_23938_ActivityTips = {
    Text = "\nReglas del Evento:\n1. Durante el evento \"Inmersión Fantasmal y Traphase\", el Guardián recibirá el doble de experiencia del Guardián por \"Inmersión Fantasmal\" y \"Traphase,\" con un límite diario aumentado a 480 puntos. Si el sujeto principal también está desbloqueado, la experiencia del Guardián obtenida a través de esta ruta se duplicará nuevamente, manteniendo el límite diario en 480 puntos.\n2. Cualquier experiencia del Guardián doble no utilizada para el día se reiniciará a las 9:00 AM (GMT+8) al día siguiente, así que recuerda usarla a tiempo, Guardián~"
  },
  Activity_23939_ActivityName = {
    Text = "Duelo de inmersión profunda"
  },
  Activity_23939_ActivityPlot = {
    Text = "Durante el evento, la Experiencia del Guardián de Secretos obtenida por el Guardián de Secretos a través de \"Inmersión fantasmal\" y \"Fase de Duelo\" se duplicará, con un límite diario aumentado a 480 puntos."
  },
  Activity_23939_ActivityTips = {
    Text = "\nReglas del Evento:\n1. Durante el evento \"Inmersión Fantasmal y Traphase\", el Guardián recibirá el doble de experiencia del Guardián por \"Inmersión Fantasmal\" y \"Traphase,\" con un límite diario aumentado a 480 puntos. Si el sujeto principal también está desbloqueado, la experiencia del Guardián obtenida a través de esta ruta se duplicará nuevamente, manteniendo el límite diario en 480 puntos.\n2. Cualquier experiencia del Guardián doble no utilizada para el día se reiniciará a las 9:00 AM (GMT+8) al día siguiente, así que recuerda usarla a tiempo, Guardián~"
  },
  Activity_23940_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_23940_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", después de que el Guardián pase \"Preparación y afilado\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_23941_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23941_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% extra de recompensa de materiales (excluyendo Experiencia del Guardián de Secretos y Rosa Dorada) al investigar o Repetir en \"Garganta de Schwarzschild\", sin límite diario."
  },
  Activity_23942_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23942_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", después de que el Guardián pase \"Nido de gusanos\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_23943_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23943_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Residuo dimensional\", sin límite diario."
  },
  Activity_23944_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23944_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo orgánico\", sin límite diario."
  },
  Activity_23945_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23945_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", después de que el Guardián pase \"Residuo turbio\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_23946_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23946_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Residuo dimensional\", sin límite diario."
  },
  Activity_23947_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23947_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Ruinas de Ponape\", sin límite diario."
  },
  Activity_23948_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23948_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Cluster caótico\", sin límite diario."
  },
  Activity_23949_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23949_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo turbio\", sin límite diario."
  },
  Activity_23950_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23950_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo de las Abejas\", sin límite diario."
  },
  Activity_23951_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23951_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Cluster caótico\", sin límite diario."
  },
  Activity_23953_ActivityName = {
    Text = "Duelo de inmersión profunda"
  },
  Activity_23953_ActivityPlot = {
    Text = "Durante el evento, la Experiencia del Guardián de Secretos obtenida por el Guardián de Secretos a través de \"Inmersión fantasmal\" y \"Fase de Duelo\" se duplicará, con un límite diario aumentado a 480 puntos."
  },
  Activity_23953_ActivityTips = {
    Text = "\nReglas del Evento:\n1. Durante el evento \"Inmersión Fantasmal y Traphase\", el Guardián recibirá el doble de experiencia del Guardián por \"Inmersión Fantasmal\" y \"Traphase,\" con un límite diario aumentado a 480 puntos. Si el sujeto principal también está desbloqueado, la experiencia del Guardián obtenida a través de esta ruta se duplicará nuevamente, manteniendo el límite diario en 480 puntos.\n2. Cualquier experiencia del Guardián doble no utilizada para el día se reiniciará a las 9:00 AM (GMT+8) al día siguiente, así que recuerda usarla a tiempo, Guardián~"
  },
  Activity_23954_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23954_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Cluster caótico\", sin límite diario."
  },
  Activity_23955_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23955_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa de materiales (excluyendo Experiencia del Guardián de Secretos y Rosa Dorada) al investigar o Repetir en \"Residuo de las Abejas\", sin límite diario."
  },
  Activity_23956_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23956_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Ruinas de Ponape\", sin límite diario."
  },
  Activity_23957_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_23957_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_23958_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23958_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo orgánico\", sin límite diario."
  },
  Activity_23959_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23959_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Garganta de Schwarzschild\", sin límite diario."
  },
  Activity_23960_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23960_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Ruinas de Ponape\", sin límite diario."
  },
  Activity_23961_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23961_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Cluster caótico\", sin límite diario."
  },
  Activity_23962_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_23962_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_23963_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23963_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo de las Abejas\", sin límite diario."
  },
  Activity_23964_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23964_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Residuo dimensional\", sin límite diario."
  },
  Activity_23965_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23965_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Cluster caótico\", sin límite diario."
  },
  Activity_23966_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23966_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Residuo dimensional\", sin límite diario."
  },
  Activity_23967_ActivityName = {
    Text = "Duelo de inmersión profunda"
  },
  Activity_23967_ActivityPlot = {
    Text = "Durante el evento, la Experiencia del Guardián de Secretos obtenida por el Guardián de Secretos a través de \"Inmersión fantasmal\" y \"Fase de Duelo\" se duplicará, con un límite diario aumentado a 480 puntos."
  },
  Activity_23967_ActivityTips = {
    Text = "\nReglas del Evento:\n1. Durante el evento \"Inmersión Fantasmal y Traphase\", el Guardián recibirá el doble de experiencia del Guardián por \"Inmersión Fantasmal\" y \"Traphase,\" con un límite diario aumentado a 480 puntos. Si el sujeto principal también está desbloqueado, la experiencia del Guardián obtenida a través de esta ruta se duplicará nuevamente, manteniendo el límite diario en 480 puntos.\n2. Cualquier experiencia del Guardián doble no utilizada para el día se reiniciará a las 9:00 AM (GMT+8) al día siguiente, así que recuerda usarla a tiempo, Guardián~"
  },
  Activity_23968_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_23968_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_23969_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23969_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Garganta de Schwarzschild\", sin límite diario."
  },
  Activity_23970_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23970_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo de las Abejas\", sin límite diario."
  },
  Activity_23971_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23971_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Residuo dimensional\", sin límite diario."
  },
  Activity_23972_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23972_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Nido de gusanos\", sin límite diario."
  },
  Activity_23973_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23973_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa de materiales (excluyendo Experiencia del Guardián de Secretos y Rosa Dorada) al investigar o Repetir en \"Residuo turbio\", sin límite diario."
  },
  Activity_23974_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_23974_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_23975_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23975_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", después de que el Guardián pase \"Residuo orgánico\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_23976_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23976_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo de las Abejas\", sin límite diario."
  },
  Activity_23977_ActivityName = {
    Text = "Estética de alquimia"
  },
  Activity_23977_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estética de la alquimia\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Búsqueda de cupones de oro\", sin límite diario."
  },
  Activity_23978_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_23978_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_23979_ActivityName = {
    Text = "Estética de alquimia"
  },
  Activity_23979_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estética de la alquimia\", después de que el Guardián pase \"Búsqueda de cupones de oro\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_23980_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23980_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", después de que el Guardián pase \"Cluster caótico\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_23981_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23981_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Residuo dimensional\", sin límite diario."
  },
  Activity_23982_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23982_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Nido de gusanos\", sin límite diario."
  },
  Activity_23983_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23983_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", después de que el Guardián pase \"Residuo dimensional\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_23984_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23984_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Nido de gusanos\", sin límite diario."
  },
  Activity_23985_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_23985_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_23986_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23986_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo turbio\", sin límite diario."
  },
  Activity_23987_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_23987_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_23988_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23988_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo turbio\", sin límite diario."
  },
  Activity_23989_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23989_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Nido de gusanos\", sin límite diario."
  },
  Activity_23990_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23990_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Garganta de Schwarzschild\", sin límite diario."
  },
  Activity_23991_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23991_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Nido de gusanos\", sin límite diario."
  },
  Activity_23992_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23992_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo de las Abejas\", sin límite diario."
  },
  Activity_23993_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23993_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo orgánico\", sin límite diario."
  },
  Activity_23994_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23994_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Cluster caótico\", sin límite diario."
  },
  Activity_23995_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23995_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Garganta de Schwarzschild\", sin límite diario."
  },
  Activity_23996_ActivityName = {
    Text = "Duelo de inmersión profunda"
  },
  Activity_23996_ActivityPlot = {
    Text = "Durante el evento, la Experiencia del Guardián de Secretos obtenida por el Guardián de Secretos a través de \"Inmersión fantasmal\" y \"Fase de Duelo\" se duplicará, con un límite diario aumentado a 480 puntos."
  },
  Activity_23996_ActivityTips = {
    Text = "\nReglas del Evento:\n1. Durante el evento \"Inmersión Fantasmal y Traphase\", el Guardián recibirá el doble de experiencia del Guardián por \"Inmersión Fantasmal\" y \"Traphase,\" con un límite diario aumentado a 480 puntos. Si el sujeto principal también está desbloqueado, la experiencia del Guardián obtenida a través de esta ruta se duplicará nuevamente, manteniendo el límite diario en 480 puntos.\n2. Cualquier experiencia del Guardián doble no utilizada para el día se reiniciará a las 9:00 AM (GMT+8) al día siguiente, así que recuerda usarla a tiempo, Guardián~"
  },
  Activity_23997_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23997_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Ruinas de Ponape\", sin límite diario."
  },
  Activity_23998_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_23998_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa de materiales (excluyendo Experiencia del Guardián de Secretos y Rosa Dorada) al investigar o Repetir en \"Residuo orgánico\", sin límite diario."
  },
  Activity_23999_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_23999_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Garganta de Schwarzschild\", sin límite diario."
  },
  Activity_24000_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24000_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo de las Abejas\", sin límite diario."
  },
  Activity_24001_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24001_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Cluster caótico\", sin límite diario."
  },
  Activity_24002_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24002_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo orgánico\", sin límite diario."
  },
  Activity_24003_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24003_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Nido de gusanos\", sin límite diario."
  },
  Activity_24004_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24004_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Residuo dimensional\", sin límite diario."
  },
  Activity_24005_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24005_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Garganta de Schwarzschild\", sin límite diario."
  },
  Activity_24006_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24006_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Ruinas de Ponape\", sin límite diario."
  },
  Activity_24007_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24007_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", después de que el Guardián pase \"Ruinas de Ponape\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_24009_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24009_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo orgánico\", sin límite diario."
  },
  Activity_24010_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24010_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo turbio\", sin límite diario."
  },
  Activity_24011_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_24011_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_24012_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24012_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo orgánico\", sin límite diario."
  },
  Activity_24013_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24013_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Garganta de Schwarzschild\", sin límite diario."
  },
  Activity_24014_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24014_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo turbio\", sin límite diario."
  },
  Activity_24015_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_24015_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_24016_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24016_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo de las Abejas\", sin límite diario."
  },
  Activity_24017_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24017_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Garganta de Schwarzschild\", sin límite diario."
  },
  Activity_24018_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24018_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo turbio\", sin límite diario."
  },
  Activity_24019_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24019_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", después de que el Guardián pase \"Residuo de las Abejas\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_24020_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_24020_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_24021_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24021_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Ruinas de Ponape\", sin límite diario."
  },
  Activity_24022_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_24022_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_24023_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24023_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", después de que el Guardián pase \"Garganta de Schwarzschild\", algunas recompensas de materiales se duplicarán, hasta 3 veces al día.\n2. Las oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 (GMT+8) del día siguiente, así que recuerda usarlas a tiempo～"
  },
  Activity_24025_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24025_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Ruinas de Ponape\", sin límite diario."
  },
  Activity_24026_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24026_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% extra de recompensa de materiales (excluyendo Experiencia del Guardián de Secretos y Rosa Dorada) al investigar o Repetir en \"Nido de gusanos\", sin límite diario."
  },
  Activity_24027_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24027_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Nido de gusanos\", sin límite diario."
  },
  Activity_24028_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24028_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo orgánico\", sin límite diario."
  },
  Activity_24029_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24029_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Garganta de Schwarzschild\", sin límite diario."
  },
  Activity_24030_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24030_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo turbio\", sin límite diario."
  },
  Activity_24031_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_24031_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_24032_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24032_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo de las Abejas\", sin límite diario."
  },
  Activity_24033_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24033_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo orgánico\", sin límite diario."
  },
  Activity_24034_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24034_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Ruinas de Ponape\", sin límite diario."
  },
  Activity_24035_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24035_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Nido de gusanos\", sin límite diario."
  },
  Activity_24036_ActivityName = {
    Text = "Duelo de inmersión profunda"
  },
  Activity_24036_ActivityPlot = {
    Text = "Durante el evento, la Experiencia del Guardián de Secretos obtenida por el Guardián de Secretos a través de \"Inmersión fantasmal\" y \"Fase de Duelo\" se duplicará, con un límite diario aumentado a 480 puntos."
  },
  Activity_24036_ActivityTips = {
    Text = "\nReglas del Evento:\n1. Durante el evento \"Inmersión Fantasmal y Traphase\", el Guardián recibirá el doble de experiencia del Guardián por \"Inmersión Fantasmal\" y \"Traphase,\" con un límite diario aumentado a 480 puntos. Si el sujeto principal también está desbloqueado, la experiencia del Guardián obtenida a través de esta ruta se duplicará nuevamente, manteniendo el límite diario en 480 puntos.\n2. Cualquier experiencia del Guardián doble no utilizada para el día se reiniciará a las 9:00 AM (GMT+8) al día siguiente, así que recuerda usarla a tiempo, Guardián~"
  },
  Activity_24037_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24037_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa de materiales (excluyendo Experiencia del Guardián de Secretos y Rosa Dorada) al investigar o Repetir en \"Residuo dimensional\", sin límite diario."
  },
  Activity_24038_ActivityName = {
    Text = "Duelo de inmersión profunda"
  },
  Activity_24038_ActivityPlot = {
    Text = "Durante el evento, la Experiencia del Guardián de Secretos obtenida por el Guardián de Secretos a través de \"Inmersión fantasmal\" y \"Fase de Duelo\" se duplicará, con un límite diario aumentado a 480 puntos."
  },
  Activity_24038_ActivityTips = {
    Text = "\nReglas del Evento:\n1. Durante el evento \"Inmersión Fantasmal y Traphase\", el Guardián recibirá el doble de experiencia del Guardián por \"Inmersión Fantasmal\" y \"Traphase,\" con un límite diario aumentado a 480 puntos. Si el sujeto principal también está desbloqueado, la experiencia del Guardián obtenida a través de esta ruta se duplicará nuevamente, manteniendo el límite diario en 480 puntos.\n2. Cualquier experiencia del Guardián doble no utilizada para el día se reiniciará a las 9:00 AM (GMT+8) al día siguiente, así que recuerda usarla a tiempo, Guardián~"
  },
  Activity_24039_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24039_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Nido de gusanos\", sin límite diario."
  },
  Activity_24040_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_24040_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_24041_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_24041_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa de Elixir de Gnosis al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_24042_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24042_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Residuo dimensional\", sin límite diario."
  },
  Activity_24043_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_24043_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_24044_ActivityName = {
    Text = "Estética de alquimia"
  },
  Activity_24044_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estética de la alquimia\", los Guardianes de Secretos recibirán un 50% extra de recompensa de Rosa Dorada al investigar o Repetir en \"Búsqueda de cupones de oro\", sin límite diario."
  },
  Activity_24045_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24045_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Cluster caótico\", sin límite diario."
  },
  Activity_24046_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_24046_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_24047_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24047_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% extra de recompensa de materiales (excluyendo Experiencia del Guardián de Secretos y Rosa Dorada) al investigar o Repetir en \"Ruinas de Ponape\", sin límite diario."
  },
  Activity_24049_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24049_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo orgánico\", sin límite diario."
  },
  Activity_24050_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24050_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Ruinas de Ponape\", sin límite diario."
  },
  Activity_24051_ActivityName = {
    Text = "Entrenamiento intensivo"
  },
  Activity_24051_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Entrenamiento Intensivo\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Cluster caótico\", sin límite diario."
  },
  Activity_24052_ActivityName = {
    Text = "Explosión de Gnosis"
  },
  Activity_24052_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estallido de Conocimiento\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Preparación y afilado\", sin límite diario."
  },
  Activity_24053_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24053_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo turbio\", sin límite diario."
  },
  Activity_24054_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24054_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% extra de recompensa (excluyendo Experiencia del Guardián de Secretos) al investigar o Repetir en \"Residuo turbio\", sin límite diario."
  },
  Activity_24055_ActivityName = {
    Text = "Edificar rendimiento"
  },
  Activity_24055_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Escena de ascenso\", los Guardianes de Secretos recibirán un 50% de recompensa extra (excluyendo Experiencia del Guardián de Secretos) al investigar o Reproducir en \"Residuo dimensional\", sin límite diario."
  },
  Activity_24194_ActivityName = {
    Text = "Señora de rojo"
  },
  Activity_24194_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Dama Roja\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Sorel para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_24195_ActivityName = {
    Text = "Flor de lodo"
  },
  Activity_24195_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Flor del Pantano\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Lily para experimentar niveles designados infinitamente.\n·Al jugar los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_24992_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_24992_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_25011_ActivityName = {
    Text = "Un paso más cerca"
  },
  Activity_25011_ActivityPlot = {
    Text = "Das un paso adelante y cruzas a otro tiempo y espacio."
  },
  Activity_25011_ActivityTips = {
    Text = "<Title:Condiciones de Participación>\n·Completa la aventura de conciencia \"Deseo del Caballero\" en modo Normal para participar.\n<Title:Evento de Investigación>\n·Durante el período del evento, se lanzará diariamente un nuevo evento de investigación de \"Un Paso Atrás\". Los Guardianes pueden desbloquear e investigar sin consumir inventario. Tras completar el evento de investigación, se pueden obtener recompensas como Núcleo Puro, Insignia de Investigación y Experiencia del Guardián.\n·Después de que termine el evento, el progreso de la investigación de \"Un Paso Atrás\" se mantendrá, y los Guardianes pueden consumir D-joyas en la aventura de conciencia para desbloquear investigaciones incompletas. Completar eventos de investigación incompletos durante el período del evento también otorgará recompensas consistentes con las de durante el evento.<Title:Recompensas por Tiempo Limitado>\n·Las recompensas por tiempo limitado estarán disponibles durante el evento. Los Guardianes pueden obtener Dulce de Suerte y recompensas de Plata después de completar el modo Normal de \"Un Paso Atrás\" y finalizar los eventos de investigación de \"Un Paso Atrás\"! Las recompensas por tiempo limitado solo están disponibles durante el período del evento y no se pueden completar ni reclamar después de que termine el evento."
  },
  Activity_25011_UnlockConditionExplanation = {
    Text = "Complete el vagabundeo \"Deseo del Caballero\" para desbloquear después"
  },
  Activity_25012_ActivityName = {
    Text = "Himno a la Rosa"
  },
  Activity_25012_ActivityPlot = {
    Text = "Damas y caballeros.\nLa noche tranquila ha comenzado, preparen sus bebidas.\nEs una historia larga, déjennos contarla lentamente"
  },
  Activity_25012_ActivityTips = {
    Text = "<Title:Condiciones de Participación>\n·Completa \"Operación de Investigación\" 2-9 (Normal) para participar.\n<Title:Evento de Investigación>\n·Durante el período del evento, se lanzará un nuevo evento de investigación de \"Tributo Rosado\" diariamente. Los Guardianes pueden desbloquear e investigar sin consumir inventario. Después de completar el evento de investigación, se pueden obtener recompensas como Núcleo Puro, Insignia de Investigación y Experiencia de Guardián.\n·Después de que el evento finalice, el progreso de investigación de \"Tributo Rosado\" se mantendrá, y los Guardianes pueden consumir D-joyas en el Registro Especial para desbloquear investigaciones no completadas. Completar eventos de investigación no completados durante el período del evento también otorgará recompensas consistentes con las de durante el evento.<Title:Recompensas por Tiempo Limitado>\n·Las recompensas por tiempo limitado estarán disponibles durante el evento. Los Guardianes pueden obtener Núcleo Puro, Piedra Filosofal y recompensas de Plata después de completar el modo \"Tributo Rosado\" (Normal) y completar los eventos de investigación de \"Tributo Rosado\"! Las recompensas por tiempo limitado solo están disponibles durante el período del evento y no se pueden completar ni reclamar después de que finalice el evento."
  },
  Activity_25012_UnlockConditionExplanation = {
    Text = "Desbloquea después de completar \"Operación de Investigación\" 2-9 · Normal"
  },
  Activity_34754_ActivityName = {
    Text = "La magia de la historia"
  },
  Activity_34754_ActivityTips = {
    Text = "<Title:Condiciones de Participación>\n·Completa la \"Operación de Investigación\" 2-9 (Normal) para participar.\n<Title:Evento de Investigación>\n·Durante el período del evento, se lanzará diariamente un nuevo evento de investigación de \"La Magia de las Historias\". Los Guardianes pueden desbloquear e investigar sin consumir inventario. Después de completar el evento de investigación, se pueden obtener recompensas como Núcleo Puro, Insignia de Investigación, y Experiencia de Guardián.\n·Después de que termine el evento, el progreso de la investigación de \"La Magia de las Historias\" se conservará. Los Guardianes pueden consumir D-joyas en el Registro Especial para desbloquear investigaciones incompletas. Completar eventos de investigación incompletos durante el período del evento también otorgará recompensas consistentes con las de durante el evento.<Title:Recompensas por Tiempo Limitado>\n·Las recompensas por tiempo limitado estarán disponibles durante el evento. Los Guardianes pueden obtener Núcleo Puro, Piedra Filosofal y recompensas de Plata después de completar \"La Magia de las Historias\" (modo Normal) y completar eventos de investigación de \"La Magia de las Historias\"! Las recompensas por tiempo limitado solo están disponibles durante el período del evento y no se pueden completar ni reclamar después de que termine el evento."
  },
  Activity_34755_ActivityName = {
    Text = "La magia de la historia"
  },
  Activity_34755_ActivityTips = {
    Text = "<Title:Resumen del Evento>\nDurante el evento, la modalidad de juego \"Misterio del guion\" estará disponible por tiempo limitado, y se desbloqueará gratis \"Registro de la fuerza especial: La magia de la historia\".\n\n<Title:Misterio del guion>\n\"Misterio del guion\" contiene 9 niveles de dificultad, recomendados para niveles 30 a 70. Los niveles de dificultad más altos se desbloquean tras completar los más bajos.\nCada desafío requiere consumir Morfina *60, y completar cada etapa te otorgará la moneda de evento \"Inspiración errante\". ¡Cuanto mayor sea la dificultad, más \"Inspiración errante\" podrás obtener!\n\"Inspiración errante\" se puede intercambiar por una gran cantidad de materiales de entrenamiento de Cuerpo Despertado en la \"Tienda de guiones mágicos\", y también se puede intercambiar por la Rueda del destino SR exclusiva del evento \"Magia de 35 mm\", que podría relanzarse o incluirse en despertares permanentes en el futuro.\nDurante cada desafío, además del jefe, los enemigos, eventos y mapas pueden variar, ¡y pueden aparecer más Reliquias en los niveles!\nPuedes usar la asistencia de Alumnis en \"Misterio del guion\".\n\n<Title:Resonancia y Recompensa de logro>\nAl consumir \"Corazón de la interpretación\" y activar \"Resonancia: valor de fase del Director\", los Guardián pueden volverse más fuertes en \"Misterio del guion\", facilitando los desafíos.\n¡Los Guardián pueden obtener \"Corazón de la interpretación\" completando logros del Evento, y además pueden recibir el avatar exclusivo del evento \"Por la Llave de Plata: Lily\" a través de estos logros!\n\n<Title:Registro de la fuerza especial>\nDurante el evento, se publicará diariamente un nuevo evento de investigación de \"La magia de la historia\", y los Guardián pueden desbloquear investigaciones sin consumir recursos; al completar el evento de investigación, se obtendrán recompensas como Núcleo Puro, Medalla de investigación y Experiencia del Guardián de Secretos.\nDespués de que termine el evento, el progreso de investigación de \"La magia de la historia\" se conservará, y los Guardián pueden usar Perla de erosión para desbloquear investigaciones que aún no se hayan completado. Completar investigaciones sin terminar durante el evento seguirá otorgando las mismas recompensas que durante el evento.\nSe publicarán recompensas de Recompensa de logro por tiempo limitado durante el evento. ¡Los Guardián pueden recibir recompensas de Plata en los Logros del Evento tras completar el modo normal de \"La magia de la historia\" y los eventos de investigación! Las recompensas de logro solo estarán disponibles durante el evento; no se pueden completar ni reclamar después de que termine el evento.\n"
  },
  Activity_34764_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34765_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34766_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34767_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34768_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34769_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34770_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34771_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34772_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34773_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34774_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34775_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34776_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34777_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34778_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34779_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34780_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34781_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34782_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34783_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34784_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34785_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34786_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34787_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34788_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34789_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34790_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34791_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34792_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34793_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34794_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34795_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34796_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34797_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34798_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34799_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34800_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34801_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34802_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34803_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34804_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34805_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34806_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34807_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34808_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34809_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34810_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34811_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34812_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34813_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34814_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34815_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34816_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34817_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34818_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34819_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34820_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34821_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34822_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34823_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34824_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34825_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34826_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34827_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_34828_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_35844_ActivityName = {
    Text = "Dama de las profundidades"
  },
  Activity_35844_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n· Durante el evento \"Dama Aequor\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyan a Murphy para experimentar niveles designados de manera infinita.\n· Durante la experiencia de los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n· Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_35983_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_35983_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_36841_ActivityName = {
    Text = "Eadem omnia"
  },
  Activity_36841_ActivityPlot = {
    Text = "Este es un día simple y feliz para Aurita. Este es cada uno de sus días."
  },
  Activity_36841_ActivityTips = {
    Text = "<Title:Condiciones de Participación>\n·Completa la vagabundeo de conciencia \"Deseo del Caballero\" en modo Normal para participar.\n<Title:Evento de Investigación>\n·Durante el período del evento, los Guardianes pueden desbloquear e investigar sin consumir inventario. Después de completar el evento de investigación, se pueden obtener recompensas como Núcleo Puro, Insignia de Investigación y Experiencia de Guardián.\n·Después de que finalice el evento, el progreso de investigación de \"Todo como Siempre\" se conservará. Los Guardianes pueden consumir D-joya en la vagabundeo de conciencia para desbloquear investigaciones no completadas. Completar eventos de investigación no completados durante el período del evento también otorgará recompensas consistentes con las del evento.<Title:Recompensas por Tiempo Limitado>\n·Las recompensas por tiempo limitado estarán disponibles durante el evento. Los Guardianes pueden obtener Candado Negro y recompensas de Plata después de completar \"Todo como Siempre\" en modo Normal y completar eventos de investigación de \"Todo como Siempre\"! Las recompensas por tiempo limitado solo estarán disponibles durante el período del evento y no se podrán completar o reclamar después de que finalice el evento."
  },
  Activity_36841_UnlockConditionExplanation = {
    Text = "Complete el vagabundeo \"Deseo del Caballero\" para desbloquear después"
  },
  Activity_36885_ActivityName = {
    Text = "Fiesta Ardiente"
  },
  Activity_36886_ActivityName = {
    Text = "Reina de Espinas"
  },
  Activity_36886_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Reina de las Espinas\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Wanda para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_38716_ActivityName = {
    Text = "Investigación reiniciada"
  },
  Activity_38716_ActivityTips = {
    Text = "<Title:Event Introduction>\n· Los Guardianes pueden reclamar directamente las recompensas de \"Reabastecimiento\" en las \"Recompensas de Regreso a Clases.\" \n· Completa las tareas de entrenamiento designadas para recibir recompensas en el evento \"Reinicio de Investigación\".\n· Completar todas las tareas de entrenamiento también otorgará recompensas adicionales."
  },
  Activity_38717_ActivityName = {
    Text = "Registro de regreso a clases"
  },
  Activity_38717_ActivityTips = {
    Text = "<Title:Event Overview>\n· Los Guardianes pueden reclamar la recompensa diaria de registro en \"Informe de Regreso a Clases\" después de iniciar sesión cada día.\n· Las recompensas se desbloquearán secuencialmente basadas en los inicios de sesión acumulativos de los Guardianes, y las recompensas diarias de registro se actualizarán a las 9:00 AM (GMT+8)."
  },
  Activity_38805_ActivityName = {
    Text = "Fiesta Ardiente"
  },
  Activity_38805_ActivityPlot = {
    Text = "Isaralu, la ciudad en el lago, supuestamente es el lugar de origen de wanda.\nEsta vez cruzarás la puerta del sueño, llegando a un antiguo grupo de torres llenas de campanas"
  },
  Activity_38805_ActivityTips = {
    Text = "<Title:Resumen del Evento>\nDurante el evento, la modalidad de juego \"Fiesta Ardiente\" estará disponible por tiempo limitado, y se desbloqueará gratis \"Inmersión en la conciencia: Fiesta Ardiente\".\n\n<Title:Ciudad en el lago>\n\"Ciudad en el lago\" contiene 7 etapas, y se abrirá 1 etapa cada 2 días. Los enemigos y eventos de cada etapa pueden cambiar aleatoriamente.\nTen en cuenta que el tipo, la cantidad y la proporción de mezcla de los materiales de recompensa de las etapas pueden variar. Las etapas que se abren primero tienen tipos de materiales más simples, mientras que las etapas posteriores tienen tipos más diversos y cantidades totales mayores. ¡Elige tu estrategia en consecuencia!\nCada etapa incluye 7 niveles de dificultad, con niveles recomendados de 15～65. Todas las dificultades están desbloqueadas por defecto.\nCada desafío consume 120 Morfina. Las dificultades más altas ofrecen mejores recompensas, así que elige la dificultad que más te convenga.\nLos materiales obtenidos en las etapas se pueden intercambiar en \"La Caja de Tesoros Extraordinarios de Wanda\" por una gran cantidad de materiales de cultivo de Cuerpo Despertado, así como el avatar exclusivo del evento \"Por la Llave de Plata: Wanda\".\nPuedes usar la asistencia de Alumnis y \"Resonancia: Orden secreto\" para superar las etapas más fácilmente.\n\n<Title:Resonancia y Recompensa de logro>\nConsumir \"Corazón del placer\" para activar \"Resonancia: Orden secreto\" puede hacer que el Guardián sea más fuerte en \"Ciudad en el lago\" y facilitar los desafíos; también puede otorgar moneda de evento adicional al completar las etapas.\nLos Guardián pueden obtener \"Corazón del placer\" completando logros del evento o intercambiarlos en \"La Caja de Tesoros Extraordinarios de Wanda\".\n\n<Title:Inmersión en la conciencia>\nDurante el evento, \"Fiesta Ardiente\" se puede desbloquear gratis. Cada día se publicará un nuevo evento de investigación de \"Fiesta Ardiente\", y completar estos eventos otorga recompensas como Núcleo Puro, Medalla de investigación y Experiencia del Guardián de Secretos.\nDespués de que termine el evento, el progreso de investigación en \"Fiesta Ardiente\" se conservará. Completar eventos de investigación sin terminar después del evento seguirá otorgando las mismas recompensas que durante el evento. Si \"Fiesta Ardiente\" no se desbloqueó durante el evento, aún se puede desbloquear después del evento consumiendo 3 \"Punto de partida real\".\nDurante el evento, habrá recompensas de logro por tiempo limitado. ¡Los Guardián que completen eventos de investigación en \"Fiesta Ardiente\" pueden reclamar recompensas de Plata en los Logros del Evento! Las recompensas de logro solo están disponibles durante el evento y no se pueden completar ni reclamar después.\n"
  },
  Activity_41378_ActivityName = {
    Text = "Entrenamiento especial para desastres"
  },
  Activity_41378_ActivityTips = {
    Text = "\nReglas del Evento:\n1. Después de completar las tareas especificadas, los Guardianes pueden reclamar recompensas en \"Entrenamiento de Bienvenida ante Desastres\".\n2. \"Entrenamiento de Bienvenida ante Desastres\" está permanentemente disponible.\n3. Después de desbloquear \"Viaje Avanzado\", los Guardianes pueden recibir recompensas adicionales al completar tareas.\n4. Tenga en cuenta: El \"Viaje Avanzado\" desbloqueado en este evento solo es válido durante este evento. Se aconseja a los Guardianes que consuman de manera racional."
  },
  Activity_43569_ActivityName = {
    Text = "Viaje oceánico"
  },
  Activity_43569_ActivityTips = {
    Text = "\nReglas del Evento:\n1. Después de completar las tareas de viaje especificadas, los Guardianes pueden reclamar recompensas en \"Viaje Oceánico\".\n2. \"Viaje Oceánico\" está permanentemente abierto.\n3. Después de desbloquear \"Viaje Avanzado\", los Guardianes pueden recibir recompensas adicionales al completar tareas.\n4. Tenga en cuenta: El \"Viaje Avanzado\" desbloqueado en este evento solo es válido durante este evento. Se aconseja a los Guardianes que consuman de manera racional."
  },
  Activity_43570_ActivityName = {
    Text = "Viaje a la Ciudad de la Nieve"
  },
  Activity_43570_ActivityTips = {
    Text = "\nReglas del Evento:\n1. Después de completar las tareas de viaje especificadas, los Guardianes pueden reclamar recompensas en \"Viaje a la Ciudad de Nieve\".\n2. \"Viaje a la Ciudad de Nieve\" está permanentemente abierto.\n3. Después de desbloquear \"Viaje Avanzado\", los Guardianes pueden recibir recompensas adicionales al completar tareas.\n4. Tenga en cuenta: El \"Viaje Avanzado\" desbloqueado en este evento solo es válido durante este evento. Se aconseja a los Guardianes que consuman de manera razonable."
  },
  Activity_43572_ActivityName = {
    Text = "Estética de alquimia"
  },
  Activity_43572_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estética de la alquimia\", los Guardianes de Secretos recibirán un 100% de bonificación extra (excluyendo Experiencia del Guardián de Secretos) al investigar o reproducir en \"Búsqueda de cupones de oro\", limitado a 6 veces por día."
  },
  Activity_43573_ActivityName = {
    Text = "Estética de alquimia"
  },
  Activity_43573_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estética de la alquimia\", los Guardianes de Secretos recibirán un 50% de bonificación extra de Rosa Dorada al investigar o reproducir en \"Búsqueda de cupones de oro\"."
  },
  Activity_43574_ActivityName = {
    Text = "Estética de alquimia"
  },
  Activity_43574_ActivityTips = {
    Text = "Reglas del evento:\n1. Durante el evento \"Estética de la alquimia\", los Guardianes de Secretos recibirán un 50% de bonificación extra de Rosa Dorada al investigar o reproducir en \"Búsqueda de cupones de oro\"."
  },
  Activity_44273_ActivityName = {
    Text = "Pastor del alma"
  },
  Activity_44273_ActivityPlot = {
    Text = "Él sufrió por ustedes, cargó con sus calamidades.\nPor su carne y sangre, fueron sanados;\npor su vida, fueron perdonados"
  },
  Activity_44273_ActivityTips = {
    Text = "<Title:Introducción a la actividad>\n1. Durante el evento, los Guardianes del Secreto pueden recoger la moneda de actividad \"Bono de venta benéfica\" a través de las jugadas limitadas \"Camino del Santuario\", \"La bondad de los ciudadanos\" y \"Recompensas de logro\". Los \"Bonos de venta benéfica\" se pueden cambiar por productos aleatorios en el \"Lugar de venta benéfica de la iglesia\", incluyendo la rueda del destino SR limitada \"El hombre en el espejo\", Núcleo Puro, Núcleo de Lumen, entre otros.\n2. Completar \"Registro de la fuerza especial: El color de la sangre\" otorga la nueva Posse \"El amanecer del milagro\". Durante el evento, \"Registro de la fuerza especial: El color de la sangre\" se desbloquea gratuitamente por tiempo limitado, y completar los logros de la actividad también otorga el avatar limitado \"Por la Llave de Plata: Salvador\"#!\n\n<Title:Camino del Santuario>\n1. \"Camino del Santuario\" consta de 5 niveles, los Guardianes del Secreto pueden desbloquear uno a uno completando los niveles 2/4/6/7/9 de \"Registro de la fuerza especial: El color de la sangre\".\n2. Cada nivel tiene 7 dificultades, con un nivel recomendado de 15 a 65, todas las dificultades están desbloqueadas por defecto. Los enemigos y eventos en cada nivel pueden cambiar aleatoriamente.\n3. Puedes usar el apoyo de la asociación de exalumnos y \"Resonancia: La bifurcación del alma\" para ayudarte a superar los niveles más fácilmente.\n4. Cada desafío requiere 120 Morfina, cuanto mayor sea la dificultad, más \"Bonos de venta benéfica\" obtendrás al completar el nivel. Además, los Guardianes del Secreto pueden elegir un desafío doble, consumiendo 240 Morfina, para obtener el doble de \"Bonos de venta benéfica\" y experiencia del Guardián.\n\n<Title:Aumento de Resplandor>\n1. Bajo la influencia de \"Resplandor del alma\", el despertado \"Salvador\", la rueda del destino SSR \"Tablilla Sagrada\" y la rueda del destino SR \"El hombre en el espejo\" pueden otorgar un aumento adicional en la caída de \"Bonos de venta benéfica\" en las recompensas de la misión del \"Camino del Santuario\", con los siguientes detalles:\n(1) Opción 1: El Guardián posee un despertado o rueda del destino específica (no se requiere que estén en el equipo)\n· Despertado \"Salvador\": Despertar 0/1/2/3 y más, aumento del 30%/40%/50%/60%.\n· Rueda del destino SSR \"Tablilla Sagrada\": Posición superpuesta 0/1/2/3 y más, aumento del 30%/40%/50%/60%.\n· Rueda del destino SR \"El hombre en el espejo\": Posición superpuesta 0/1/2/3 y más, aumento del 15%/20%/25%/30%.\n(2) Opción 2: Usar un despertado o rueda del destino específica para apoyo\n· Despertado \"Salvador\": aumento del 10%.\n· Rueda del destino SSR \"Tablilla Sagrada\": aumento del 10%.\n· Rueda del destino SR \"El hombre en el espejo\": aumento del 5%.\n2. Para el mismo despertado o rueda del destino, se activa el \"Aumento de Resplandor\" de la forma que más alto sea, no se acumula.\n3. El \"Aumento de Resplandor\" de diferentes despertados o ruedas del destino se calcula de manera acumulativa, siguiendo las reglas anteriores, el Guardián puede obtener un máximo del 150% de \"Aumento de Resplandor\"!\n\n<Title:Resonancia: La bifurcación del alma>\n1. Los Guardianes del Secreto pueden obtener \"Corazón de penitencia\" completando logros de la actividad.\n2. Consumir \"Corazón de penitencia\" para activar \"Resonancia: La bifurcación del alma\" otorga los siguientes aumentos:\n(1) Hacer que los Guardianes sean más fuertes en las jugadas de actividad \"Camino del Santuario\" y \"Registro de la fuerza especial: El color de la sangre\", facilitando los desafíos.\n(2) Aumentar la tasa de sincronización obtenida después de completar el desafío del \"Camino del Santuario\".\n(3) Activar la jugada de actividad \"La bondad de los ciudadanos\".\n\n<Title:La bondad de los ciudadanos>\n1. Después de activar la resonancia \"Forma fácil\", obtienes automáticamente 60 \"Bonos de venta benéfica\" cada hora, acumulándose hasta un máximo de 25 horas.\n2. Después de activar la resonancia \"Purgación, Purgación\", obtienes automáticamente 1800 Rosa Dorada adicionales cada hora.\n\n<Title:Lugar de venta benéfica de la iglesia>\n1. Los Guardianes del Secreto pueden usar \"Bonos de venta benéfica\" para cambiar aleatoriamente productos en las tiendas del \"Lugar de venta benéfica de la iglesia\", donde te esperan la rueda del destino SR limitada \"El hombre en el espejo\", Núcleo de Lumen y Núcleo Puro, entre otros productos~\n2. El lugar de venta benéfica cuenta con tres tiendas, con los siguientes horarios de apertura:\n· Tienda \"La tienda de la Sra. Grey\": Abierta inicialmente.\n· Tienda \"La venta mágica de Big John\": Abre el día 4 del evento.\n· Tienda \"Venta especial de Smith\": Abre el día 7 del evento.\n3. Los productos en diferentes tiendas son distintos, los Guardianes del Secreto pueden elegir productos para cambiar según sus necesidades.\n4. Cada tienda incluye productos especiales y productos comunes, cada cambio costará 600 \"Bonos de venta benéfica\", obteniendo aleatoriamente cinco productos de la tienda.\n5. Cuando todos los productos especiales de la tienda hayan sido cambiados, los Guardianes del Secreto pueden solicitar que la tienda reponga el inventario, o pueden optar por continuar cambiando. Cuando todos los productos de la tienda hayan sido cambiados, los Guardianes del Secreto deberán elegir reponer el inventario para continuar cambiando.\n6. Las primeras 2 reposiciones de cada tienda repondrán la cantidad restante de todos los productos de la tienda hasta el límite. A partir de la tercera reposición, solo se repondrán productos comunes, no se repondrán productos especiales. Después de reponer el inventario, las cantidades restantes de productos que no se han cambiado previamente no se conservarán, así que los Guardianes del Secreto deben pensarlo bien antes de elegir reponer el inventario~\n\n<Title:Registro de la fuerza especial>\n1. Durante el evento, el registro \"El color de la sangre\" se desbloqueará gratuitamente. Cada dos días se lanzará un nuevo evento de investigación de \"El color de la sangre\", completando el evento de investigación se pueden obtener Posse \"El amanecer del milagro\", Núcleo Puro, Medalla de investigación y experiencia del Guardián, entre otras recompensas de investigación.\n2. Después de que finalice el evento, el progreso de investigación de \"El color de la sangre\" se conservará, y completar los eventos de investigación no finalizados durante el evento también otorgará recompensas de investigación consistentes con las del evento. Si \"El color de la sangre\" no se desbloqueó durante el evento, se podrá desbloquear después del evento consumiendo \"Punto de partida real\" ×7.\n3. Durante el evento se lanzarán recompensas de logros limitadas, después de que los Guardianes del Secreto completen todos los eventos de investigación de \"El color de la sangre\", podrán reclamar el avatar \"Por la Llave de Plata: Salvador\" en los logros de la actividad. Las recompensas de logro solo estarán disponibles durante el evento, y no se podrán completar ni reclamar después de que finalice el evento.\n\n"
  },
  Activity_44626_ActivityName = {
    Text = "Pastor del alma"
  },
  Activity_44705_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_44705_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_44706_ActivityName = {
    Text = "Obispo de bálsamos"
  },
  Activity_44706_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Obispo Benevolente\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan a Salvador para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_44716_ActivityName = {
    Text = "Soberano que duerme"
  },
  Activity_44716_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Soberano del Sueño\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Tulu para experimentar niveles designados infinitamente.\n·Al experimentar niveles de evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_45664_ActivityName = {
    Text = "La caída de un gigante"
  },
  Activity_45664_ActivityPlot = {
    Text = "El océano interminable, el sol abrasador, un héroe Filisteo exiliado y su único asistente.\nEsta es una historia sobre \"buscar\"."
  },
  Activity_45664_ActivityTips = {
    Text = "<Title:Condiciones de participación>\nCompleta el modo Normal de la Inmersión en la conciencia \"El Deseo del Caballero\" para participar.\n<Title:Evento de investigación>\nDurante el período del evento, los Guardianes de Secretos pueden desbloquear e investigar sin consumir inventario. Al completar el evento de investigación, se pueden obtener recompensas como Núcleo Puro, Medalla de investigación y Experiencia del Guardián de Secretos.\nDespués de que finalice el evento, el estado de desbloqueo y el progreso de investigación de \"La caída del gigante\" se conservarán. Completar los eventos de investigación no completados durante el período del evento también otorgará recompensas consistentes con las del evento; si no se desbloqueó durante el período del evento, se puede desbloquear después de que finalice el evento consumiendo Punto de partida real *3.<Title:Recompensas por tiempo limitado>\nLas recompensas por tiempo limitado estarán disponibles durante el evento. ¡Los Guardianes de Secretos pueden obtener recompensas de Cristal de dimensión y Plata después de completar el modo Normal de \"La caída del gigante\" y completar los eventos de investigación de \"La caída del gigante\"! Las recompensas por tiempo limitado solo están disponibles durante el período del evento y no se pueden completar ni reclamar después de que finalice el evento."
  },
  Activity_45664_UnlockConditionExplanation = {
    Text = "Complete el vagabundeo \"Deseo del Caballero\" para desbloquear después"
  },
  Activity_46167_ActivityName = {
    Text = "Paciente disociativo: caos"
  },
  Activity_46167_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Paciente Astillado: Caos\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan \"24\" para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_46168_ActivityName = {
    Text = "Cazadora de cráneos"
  },
  Activity_46168_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Cazadora de Calaveras\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Narciso para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_46609_ActivityName = {
    Text = "Curación múltiple"
  },
  Activity_46609_ActivityPlot = {
    Text = "Hysteria, también conocida como histeria.\nEn su época, era sinónimo de muerte.\n\nAfortunadamente, los científicos e investigadores de mitag están igualmente locos: están decididos a resolver este problema"
  },
  Activity_46609_ActivityStageEndContent = {
    Text = "El evento ha terminado. Actualmente, solo \"Análisis de Personalidad\" está disponible."
  },
  Activity_46609_ActivityTips = {
    Text = "<Title:Descripción de la actividad>\n1. Durante el evento, los guardianes pueden recolectar la moneda del evento \"Puzle de Memoria\" a través de las mecánicas limitadas \"Codificación de Memoria\", \"Almacenamiento en el Límite\" y \"Recompensas de Logro\". \"Puzle de Memoria\" se puede utilizar para comprar artículos en \"Análisis de Personalidad\", incluyendo la rueda del destino SR exclusiva del evento \"Determinación del Bacalao Plateado\", Núcleo de Lumen, Núcleo Puro, Piedra Filosofal y materiales de cultivo abundantes. \n2. Completar \"Registro de la fuerza especial: Fisión Tranquila\" otorga la nueva llave \"Toda ella\". Durante el evento, \"Registro de la fuerza especial: Fisión Tranquila\" se desbloquea gratuitamente por tiempo limitado, y completar los logros del evento también otorga el avatar exclusivo del evento \"Por la Llave de Plata:\"24\"\"!\n\n<Title:Tiempo de la actividad>\n1. Del 27 de abril a las 9:00 al 18 de mayo a las 9:00 (GMT+8), todas las mecánicas del evento son accesibles, y \"Registro de la fuerza especial: Fisión Tranquila\" se desbloquea gratuitamente por tiempo limitado. \n2. Del 18 de mayo a las 9:00 al 25 de mayo a las 9:00 (GMT+8), solo se puede participar en \"Análisis de Personalidad\" y recompensas de logro, y \"Registro de la fuerza especial: Fisión Tranquila\" requiere consumir Punto de partida real×7 para desbloquear. \n\n<Title:Codificación de Memoria>\n1. \"Codificación de Memoria\" consta de 5 niveles, los guardianes pueden desbloquearlos uno por uno al completar los niveles 2/4/6/8/10 de \"Registro de la fuerza especial: Fisión Tranquila\". \n2. Cada nivel tiene 7 dificultades, el nivel recomendado es de 15 a 65, todas las dificultades están desbloqueadas por defecto. Los enemigos y eventos de cada nivel pueden cambiar de manera aleatoria. \n3. Se puede utilizar el apoyo de la Asociación de Exalumnos y \"Resonancia: Síndrome de Separación\" para facilitar el paso de los niveles. \n4. Cada intento consume 120 Morfina, cuanto mayor sea la dificultad, más \"Puzles de Memoria\" se obtienen al completar el nivel; además, los guardianes pueden optar por un desafío doble, consumiendo 240 Morfina, obteniendo el doble de \"Puzles de Memoria\" y experiencia del guardián. \n\n<Title:Bonificación Racional>\n1. Los guardianes que posean un despertar específico o rueda (no se requiere estar en el equipo) pueden hacer que la recompensa de \"Puzle de Memoria\" de la misión de \"Codificación de Memoria\" obtenga una bonificación adicional, las bonificaciones son las siguientes: \n· Despertar \"24\": Despertar 0/1/2/3 y superior, bonificación 15%/20%/25%/30%. \n· Despertar \"Daffodil\": Despertar 0/1/2/3 y superior, bonificación 15%/20%/25%/30%. \n· Rueda SSR \"Restitución de la forma alterada\": Superposición 0/1/2/3 y superior, bonificación 15%/20%/25%/30%. \n· Rueda SSR \"Reliquia Preciada\": Superposición 0/1/2/3 y superior, bonificación 15%/20%/25%/30%. \n· Rueda SR \"Determinación del Bacalao Plateado\": Superposición 0/1/2/3 y superior, bonificación 15%/20%/25%/30%. \n2. Las \"bonificaciones racionales\" de diferentes despertares o ruedas se calculan de manera acumulativa. \n\n<Title:Resonancia: Síndrome de Separación>\n1. Los guardianes pueden obtener \"Corazón dividido\" completando logros del evento. \n2. Consumir \"Corazón dividido\" para activar \"Resonancia: Síndrome de Separación\" proporciona las siguientes bonificaciones: \n(1) Hace que los guardianes sean más fuertes en las mecánicas del evento \"Codificación de Memoria\" y \"Registro de la fuerza especial: Fisión Tranquila\", facilitando los desafíos. \n(2) Mejora las recompensas obtenidas después de completar el desafío de \"Codificación de Memoria\". \n(3) Activa la mecánica del evento \"Almacenamiento en el Límite\". \n\n<Title: Almacenamiento en el Límite>\n· Después de activar la resonancia \"Diagnóstico: Fisura de personalidad\", se obtienen automáticamente 60 \"Puzles de Memoria α\" cada hora, con un máximo de 25 horas. \n\n<Title:Registro de la fuerza especial>\n1. Durante el evento, \"Registro de la fuerza especial: Fisión Tranquila\" se desbloquea gratuitamente. Cada 2 días se lanzará un nuevo evento de investigación \"Fisión Tranquila\", completando el evento de investigación se obtienen llaves \"Toda ella\", Núcleo Puro, Medalla de investigación y experiencia del guardián, entre otras recompensas de investigación. \n2. Después del evento, el progreso de investigación de \"Registro de la fuerza especial: Fisión Tranquila\" se mantendrá, y completar eventos de investigación no terminados durante el evento también otorgará recompensas de investigación consistentes con las del periodo del evento. Si \"Registro de la fuerza especial: Fisión Tranquila\" no se desbloqueó durante el evento, aún se puede desbloquear consumiendo \"Punto de partida real\"×7 después de que termine el evento. \n3. Durante el evento se lanzarán recompensas de logros limitadas, y los guardianes que completen todos los eventos de investigación de \"Registro de la fuerza especial: Fisión Tranquila\" podrán reclamar el avatar \"Por la Llave de Plata:\"24\"\" en los logros del evento. Las recompensas de logro solo estarán disponibles durante el evento, y no se podrán completar ni reclamar después de que termine. \n\n\n"
  },
  Activity_46609_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_47534_ActivityName = {
    Text = "Fisión Tranquila"
  },
  Activity_48136_ActivityName = {
    Text = "Paciente disociativo: aequor"
  },
  Activity_48136_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Paciente Astillado: Aequor\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan \"24\" para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_48137_ActivityName = {
    Text = "Paciente disociativo: caro"
  },
  Activity_48137_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Paciente Dividido: Caro\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen \"24\" para experimentar niveles designados infinitamente.\n·Al experimentar niveles de evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_48138_ActivityName = {
    Text = "Paciente disociativo: ultra"
  },
  Activity_48138_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Paciente Dividido: Ultra\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen \"24\" para experimentar niveles designados infinitamente.\n·Al experimentar niveles de evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_48719_ActivityName = {
    Text = "Olas de Deseo"
  },
  Activity_48719_ActivityPlot = {
    Text = "Los sueños son la revelación de deseos sumergidos. Quienes se demoran en ellos serán atrapados por las mareas del anhelo, convirtiéndose en apóstoles de la lujuria—a menos que..."
  },
  Activity_48719_ActivityStageEndContent = {
    Text = "El evento ha Terminado. Actualmente, solo \"Proliferación del Deseo\" está disponible."
  },
  Activity_48719_ActivityTips = {
    Text = "<Title:Descripción de la actividad>\n1. Durante el evento, los guardianes podrán recolectar la moneda de actividad \"semilla madre\" a través de las mecánicas temporales \"deseo desordenado\" y \"recompensas de logro\". Las \"semilla madre\" pueden intercambiarse por recompensas en \"brotes lujuriantes\", incluyendo núcleo luminoso, núcleo puro y abundantes materiales de desarrollo.\n2. Durante el evento, los guardianes que completen la \"misión de investigación\" 2-9·normal también podrán participar en \"locura reproductiva\", y no será necesario cumplir con el requisito de tasa de sincronización del despertador para desbloquear el \"evento de locura reproductiva\". Además, ¡la cantidad requerida de \"punto de partida real\" se reduce a solo 1!\n3. ¡Una misteriosa fuerza parece ayudarte a establecer una relación más profunda con los despertadores! Durante el evento, la tasa de sincronización obtenida por cualquier medio se duplicará.\n\n<Title:Duración del evento>\n1. Del 18 de mayo a las 9:00 al 3 de junio a las 9:00 (GMT+8), todas las actividades mencionadas en la descripción estarán disponibles.\n2. Del 3 de junio a las 9:00 al 10 de junio a las 9:00 (GMT+8), solo permanecerán disponibles \"brotes lujuriantes\" y \"recompensas de logro\", el resto de contenido finalizará y no podrá participarse.\n\n<Title:Deseo desordenado>\n1. \"Deseo desordenado\" incluye 10 etapas de materiales que no requieren exploración y pasan directamente a la batalla, abriéndose 1 por día.\n2. En estas etapas de materiales, despertarás a todos los despertadores directamente y obtendrás criaturas preestablecidas. Además, tras 6 rondas recibirás una vez la ayuda de Tais.\n3. Cada desafío consumirá 60 puntos de encefalina. Tras superar estas etapas de materiales de la actividad, se podrá realizar la recreación.\n4. Puedes usar el apoyo de los \"alumnos\" para facilitar el paso de las etapas.\n\n<Title:Bonificación de deseo>\n1. Si el guardián posee ciertos despertadores o ruedas de destino específicas (no es necesario tenerlos en combate), obtendrá una bonificación adicional en la cantidad de \"semilla madre\" obtenida en las recompensas de las etapas de \"deseo desordenado\" (incluyendo recreación). Los detalles son los siguientes:\n· Despertador \"Tais\": Despertar 0/1/2/3 o más, bonificación del 20%/30%/40%/50%\n· Rueda de destino SSR \"amamantamiento compasivo\": Apilamiento 0/1/2/3 o más, bonificación del 20%/30%/40%/50%\n· Rueda de destino SR \"beso ardiente\": Apilamiento 0/1/2/3 o más, bonificación del 20%/30%/40%/50%\n2. Las \"bonificaciones de deseo\" de diferentes despertadores o ruedas de destino se acumulan.\n\n<Title:Locura reproductiva>\n1. Tras superar la misión \"misión de investigación\" 7-3·normal, se desbloqueará el nuevo contenido especial \"locura reproductiva\".\n2. Con la llegada de la actividad \"brotes lujuriantes\", los despertadores han sido afectados por una fuerza misteriosa, cayendo en un estado de \"locura reproductiva\"... ¡Cuidado, guardianes!\n3. Cuando la tasa de sincronización del despertador alcance el nivel 10, se desbloqueará el \"evento de locura reproductiva\" de dicho despertador, consumiendo \"punto de partida real\"*7 para desbloquearlo. Al completarlo obtendrás \"núcleo puro\"*1.\n4. Durante la actividad \"brotes lujuriantes\" (antes del 3 de junio a las 9:00), las condiciones para participar se relajan a superar la \"misión de investigación\" 2-9·normal, y no será necesario cumplir con el requisito de tasa de sincronización del despertador para desbloquear el \"evento de locura reproductiva\". Además, ¡la cantidad requerida de \"punto de partida real\" se reduce a solo 1!\n\n<Title:Duplicado de sincronización>\n1. ¡Una misteriosa fuerza parece ayudarte a establecer una relación más profunda con los despertadores! Durante el evento, la tasa de sincronización obtenida por cualquier medio se duplicará.\n2. Se calculará de forma multiplicativa junto con otras bonificaciones de tasa de sincronización, como las bonificaciones por usar apoyo en combate.\n<Title:Recompensas de logro>\n1. Al completar todas las misiones podrás obtener las siguientes recompensas: núcleo plateado*800, gran cantidad de \"semilla madre\", rueda de destino SR limitada de la actividad \"beso ardiente\"*16 y avatar limitado \"en nombre de la llave plateada: Tais\".\n2. Incluye 16 misiones: superar cada etapa de \"deseo desordenado\" una vez, recrear un total de 10/20/30/40/50 veces en \"deseo desordenado\", completar todos los logros de la actividad.\n\n\n\n"
  },
  Activity_48719_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_48825_ActivityName = {
    Text = "Agradecimiento del gato de la escuela"
  },
  Activity_48825_ActivityPlot = {
    Text = "¡Los Guardianes pueden elegir 1 de los siguientes Cuerpos Despertados limitados para Despertar!"
  },
  Activity_48825_ActivityTips = {
    Text = "<Title:Descripción>\nDe no haber sido por tu entusiasta vigilancia, los Misaq podrían haber quedado enterrados para siempre en la larga noche. Ahora, hemos cumplido nuestra promesa, atravesado dificultades y alcanzado el momento del medio aniversario. Por ello, el gato de la escuela te presentará un regalo especial como muestra de agradecimiento por tu compañía durante todo este tiempo.\n\n<Title:Reglas del evento>\nDurante el evento, cada Guardián puede elegir 1 Cuerpo Despertado de entre 8 Cuerpos Despertados SSR limitados, incluyendo Tulu, Daffodil, Sorel, Lily, Murphy, Wanda, Salvador y \"24\".\nCuando un Guardián seleccione un Cuerpo Despertado ya despertado, se convertirá en el Fragmento correspondiente*1 y sedimento fundamental*50; si el nivel de Despertar Espiritual del Cuerpo Despertado correspondiente está al máximo, se convertirá en Fragmento de núcleo espiritual*1 y sedimento fundamental*150."
  },
  Activity_48825_BannerText = {
    Text = "Despertar Limitado Gratuito"
  },
  Activity_48826_ActivityName = {
    Text = "Anochecer y Amanecer"
  },
  Activity_48826_ActivityPlot = {
    Text = "¡Inicia sesión diariamente para reclamar la Rueda del destino SSR conmemorativa limitada \"Anochecer y Amanecer\", hasta 16 en total!"
  },
  Activity_48826_ActivityTips = {
    Text = "<Title:Introducción>\nEste es un poema dedicado a los jugadores, sobre ideales, sobre fe, y sobre el tiempo pasado juntos. Que el corazón sincero nunca deje de latir, y que la Llave de Plata guíe el camino hacia adelante.\n\n<Title:Reglas del Evento>\n· Durante el evento, los Guardianes pueden iniciar sesión diariamente para recibir el limitado SSR Rueda del Destino conmemorativa \"Noche Polar y Amanecer\", con un total de hasta 16 reclamos.\n· Las recompensas se desbloquearán secuencialmente según los inicios de sesión diarios acumulativos de los Guardianes, y las recompensas diarias de inicio de sesión se actualizarán a las 9 AM (GMT+8)."
  },
  Activity_48826_BannerText = {
    Text = "Rueda del destino SSR limitada gratis"
  },
  Activity_48827_ActivityName = {
    Text = "Plata en el sombrero"
  },
  Activity_48827_ActivityPlot = {
    Text = "Según estadísticas incompletas, durante los últimos seis meses, el sombrero del Gato de la escuela ha sido acariciado miles de veces por los estudiantes, y muchas piezas diminutas e imperceptibles de Plata han caído al suelo sin ser notadas. Los conserjes están bastante preocupados por esto. La escuela ha recopilado y limpiado a fondo estas piezas de Plata, almacenándolas en objetos perdidos. Se aconseja a los propietarios que vengan a reclamarlas cuanto antes."
  },
  Activity_48827_ActivityTips = {
    Text = "<Title:Resumen>\nSegún estadísticas incompletas, durante los últimos seis meses, los estudiantes han tomado miles de fotos del sombrero del Gato de la escuela. Muchas piezas pequeñas e imperceptibles de Plata han caído al suelo y permanecen sin reclamar. Los conserjes encargados de la limpieza están bastante preocupados. La escuela ha recopilado estas piezas de Plata, las ha limpiado a fondo y las ha almacenado en objetos perdidos. Se solicita a los legítimos propietarios que se presenten a reclamarlas.\n\n<Title:Reglas del evento>\nDurante el evento, los Guardianes pueden iniciar sesión diariamente para reclamar 1000 de Plata en \"Núcleo de plata en el sombrero\", con un máximo de 5 reclamaciones.\nLas recompensas se desbloquearán secuencialmente según los inicios de sesión acumulados de los Guardianes, y las recompensas diarias de inicio de sesión se actualizarán a las 9 AM (GMT+8)."
  },
  Activity_48827_BannerText = {
    Text = "Inicia sesión para reclamar toneladas de Plata"
  },
  Activity_48849_ActivityName = {
    Text = "Apóstol del mar"
  },
  Activity_48849_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n· Durante el evento \"Apóstol del Mar\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyan a Miryam para experimentar niveles designados de manera infinita.\n· Al experimentar los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n· Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_48850_ActivityName = {
    Text = "Aliento de fertilidad"
  },
  Activity_48850_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Aliento Abundante\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan a Thais para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_48851_ActivityName = {
    Text = "Dama de las profundidades"
  },
  Activity_48851_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n· Durante el evento \"Dama Aequor\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyan a Murphy para experimentar niveles designados de manera infinita.\n· Durante la experiencia de los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n· Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_48852_ActivityName = {
    Text = "Reina de Espinas"
  },
  Activity_48852_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Reina de las Espinas\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Wanda para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_48853_ActivityName = {
    Text = "Poema sin nombre"
  },
  Activity_48853_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Poema Sin Nombre\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Horla para experimentar niveles designados infinitamente.\n·Mientras experimentan niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_48854_ActivityName = {
    Text = "Detective afortunado"
  },
  Activity_48854_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante el evento \"Lucky Detective\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyen a Ryker para experimentar niveles designados infinitamente.\n·Al experimentar los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Event Rewards>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_48855_ActivityName = {
    Text = "Flor de lodo"
  },
  Activity_48855_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Flor del Pantano\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Lily para experimentar niveles designados infinitamente.\n·Al jugar los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_48856_ActivityName = {
    Text = "Señora de rojo"
  },
  Activity_48856_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Dama Roja\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Sorel para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_49249_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_49249_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_49405_ActivityName = {
    Text = "Evento de Confesión: Actividad de Desbloqueo de Descuentos"
  },
  Activity_49406_ActivityName = {
    Text = "Evento doble de afinidad"
  },
  Activity_51127_ActivityName = {
    Text = "Historia magia·copia de luz"
  },
  Activity_51127_ActivityPlot = {
    Text = "Las tareas asignadas por la muñeca nunca son simples.\nIncluso si ella ha recordado varias veces a todos \"diviértanse\", ¿cómo puede el guardián no estar asustado al llevar por primera vez un grupo de despertadores a salir?\nPero, recuerda \"divertirse\""
  },
  Activity_51127_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Tienda de guiones mágicos\""
  },
  Activity_51127_ActivityTips = {
    Text = "<Title:Resumen del evento>\n1. ¡El evento de jugabilidad \"La magia de la historia\" regresa por tiempo limitado! ¡Los Guardianes pueden acceder a la \"Tienda de guiones mágicos\" y \"Recompensas de logros\" para obtener la Rueda del destino exclusiva del evento \"Magia de 35 mm\" y el avatar exclusivo del evento \"Por la Llave de Plata: Lily\" una vez más!\n2. Durante el evento, \"Operación Especial: La magia de la historia\" estará disponible con acceso gratuito por tiempo limitado.\n\n<Title:Duración del evento>\n1. Del 3 de junio, 9:00 al 17 de junio, 9:00 (GMT+8), se puede participar en todo el contenido de la introducción del evento.\n2. Del 17 de junio, 9:00 al 24 de junio, 9:00 (GMT+8), solo la \"Tienda de guiones mágicos\" y las \"Recompensas de logros\" permanecerán accesibles; el resto del contenido habrá terminado y no se podrá participar.\n\n<Title:Misterio del guion>\n1. \"Misterio del guion\" consta de 9 niveles de materiales, con un nivel desbloqueándose automáticamente cada día. Tras desbloquearse, debes pasar el nivel de Operación Especial anterior para desafiarlo.\n2. Cada desafío consume 60 puntos de Morfina. Los desafíos exitosos te recompensan con la moneda del evento \"Inspiración errante\" y materiales de cultivo. Pasar los niveles de materiales en este evento admite recreación.\n3. Puedes usar el apoyo de Alumni y \"Resonancia: valor de fase del Director\" para pasar los niveles más fácilmente.\n\n<Title:Bonificación de Inspiración>\n1. Los Guardianes con Cuerpos Despertados o Ruedas del destino específicos (no se requieren en la Formación) obtienen bonificaciones adicionales de obtención de \"Inspiración errante\" en las recompensas de tarea de \"Misterio del guion\" (incluyendo recreación). Las bonificaciones específicas son las siguientes:\nCuerpo Despertado \"Lily\": Despertar Espiritual 0/1/2/3 y superior, bonificación 20%/30%/40%/50%\nRueda del destino SSR \"Transgresión del Sufrimiento\": Acumulación 0/1/2/3 y superior, bonificación 20%/30%/40%/50%\nRueda del destino SR \"Magia de 35 mm\": Acumulación 0/1/2/3 y superior, bonificación 20%/30%/40%/50%\n2. Las \"Bonificaciones de Inspiración\" de diferentes Cuerpos Despertados o Ruedas del destino se acumulan.\n\n<Title:Resonancia: valor de fase del Director>\n1. Los Guardianes pueden adquirir \"Corazón de la interpretación\" completando logros del evento.\n2. Consumir \"Corazón de la interpretación\" para activar \"Resonancia: valor de fase del Director\" hace a los Guardianes más fuertes en la jugabilidad del evento \"Misterio del guion\" y \"Operación Especial: La magia de la historia,\" y mejora las recompensas de \"Inspiración errante\" y Tasa de sincronización obtenidas tras completar los desafíos de \"Misterio del guion\".\n\n<Title:Recompensas de logros>\n1. Completar tareas de logros otorga el avatar exclusivo del evento \"Por la Llave de Plata: Lily,\" la moneda del evento \"Inspiración errante,\" y Plata.\n2. Incluye 25 tareas: pasar cada nivel de \"Misterio del guion\" una vez, usar cada equipo de Reino para pasar \"Misterio del guion\" 1/2 veces, pasar cada evento de investigación en \"Operación Especial: La magia de la historia\" una vez, y completar todos los logros del evento.\n\n<Title:Operación Especial>\n1. Durante el evento, \"Operación Especial: La magia de la historia\" se puede desbloquear de forma gratuita.\n2. En \"Operación Especial: La magia de la historia,\" los Guardianes desafiarán usando una configuración de equipo especial que incluye el preset de historia \"Lily.\"\n\n<Title:Compensación de Renacimiento>\n1. Los Guardianes que previamente desbloquearon \"Operación Especial: La magia de la historia\" recibirán una compensación de \"Inspiración errante\" *1000 al volver a desbloquear durante este evento de Renacimiento.\nLos Guardianes que previamente obtuvieron el avatar exclusivo del evento \"Por la Llave de Plata: Lily\" convertirán automáticamente cualquier recompensa repetida en \"Inspiración errante\" *3000.\nLos Guardianes que previamente obtuvieron el material de activación de Resonancia \"Corazón de la interpretación\" convertirán automáticamente cada \"Corazón de la interpretación\" adicional obtenido en \"Rosa Dorada\" *5000.\n"
  },
  Activity_51127_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_51611_ActivityName = {
    Text = "La magia de la historia"
  },
  Activity_51611_ActivityTips = {
    Text = "<Title:Condiciones de Participación>\n·Completa la \"Operación de Investigación\" 2-9 (Normal) para participar.\n<Title:Evento de Investigación>\n·Durante el período del evento, se lanzará diariamente un nuevo evento de investigación de \"La Magia de las Historias\". Los Guardianes pueden desbloquear e investigar sin consumir inventario. Después de completar el evento de investigación, se pueden obtener recompensas como Núcleo Puro, Insignia de Investigación, y Experiencia de Guardián.\n·Después de que termine el evento, el progreso de la investigación de \"La Magia de las Historias\" se conservará. Los Guardianes pueden consumir D-joyas en el Registro Especial para desbloquear investigaciones incompletas. Completar eventos de investigación incompletos durante el período del evento también otorgará recompensas consistentes con las de durante el evento.<Title:Recompensas por Tiempo Limitado>\n·Las recompensas por tiempo limitado estarán disponibles durante el evento. Los Guardianes pueden obtener Núcleo Puro, Piedra Filosofal y recompensas de Plata después de completar \"La Magia de las Historias\" (modo Normal) y completar eventos de investigación de \"La Magia de las Historias\"! Las recompensas por tiempo limitado solo están disponibles durante el período del evento y no se pueden completar ni reclamar después de que termine el evento."
  },
  Activity_51888_ActivityName = {
    Text = "Profanación"
  },
  Activity_51905_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_51905_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_52040_ActivityName = {
    Text = "Ceremonia del Abismo"
  },
  Activity_52040_ActivityPlot = {
    Text = "En el reflejo del océano, el sueño del rey se desvanece y el reino de los dioses se corrompe.\nElla viene del sueño antiguo, hacia las ruinas del futuro.\nPregunta al abismo, pero el abismo guarda silencio.\nElla ofrece sacrificios al abismo, y solo se responde a sí misma"
  },
  Activity_52040_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Respuesta del abismo\""
  },
  Activity_52040_ActivityTips = {
    Text = "<Title:Introducción a la actividad>\n1. Durante el período de la actividad, los guardianes pueden recolectar moneda de la actividad a través de las mecánicas limitadas \"Nacimiento del Reino Divino\", \"El Decreto del Soberano\" y \"Recompensas de Logro\". La moneda de la actividad se puede utilizar en \"Respuesta del Abismo\" para ofrecer ofrendas y obtener recompensas de objetos, incluyendo la rueda del destino SR exclusiva de evento \"El Llamado del Mar Profundo\", la Piedra Filosofal, Núcleo Puro, Núcleo de Lumen, entre otros.\n2. Durante el período de la actividad, \"Mundo de Sueños Extraños: Profanación\" estará disponible de forma gratuita.\n\n<Title: Tiempo de la actividad>\n1. Del 17 de junio a las 9:00 - 1 de julio a las 9:00 (GMT+8), todo el contenido de la actividad estará disponible para participar.\n2. Del 1 de julio a las 9:00 - 8 de julio a las 9:00 (GMT+8), solo permanecerán \"Respuesta del Abismo\" y \"Recompensas de Logro\", el resto de los contenidos habrán terminado y no se podrá participar.\n\n<Title: Nacimiento del Reino Divino>\n1. \"Nacimiento del Reino Divino\" consta de 5 niveles, uno se abrirá automáticamente cada 2 días.\n2. Cada desafío consumirá \"Morfina\" × 120, y al completar el desafío se obtendrán monedas de la actividad \"Lágrimas del Sacerdote\", \"Sangre del Sacerdote\" y \"Médula del Sacerdote\". Durante los desafíos dobles, se necesitarán 240 Morfina, y las recompensas de las misiones de los niveles también se duplicarán, sin cambiar la recompensa de la tasa de sincronización.\n3. Una vez alcanzado el 100% de completitud en \"Recompensas de Logro\", se desbloqueará la función de \"Reproducción\" para los niveles completados. Cada \"Reproducción\" consumirá \"Morfina\" × 120. Nota: Al usar la función de \"Reproducción\", no se obtendrá tasa de sincronización.\n4. Se puede utilizar la ayuda de la Asociación de Antiguos y \"Resonancia: Ritual de Sacrificio del Mar\" para facilitar el paso de los niveles.\n\n<Title: Bonificación de Ofrenda>\n1. Los guardianes que posean cuerpos despertados o ruedas del destino específicos (no es necesario que estén en el equipo) pueden hacer que las recompensas de las misiones de \"Nacimiento del Reino Divino\" de \"Lágrimas del Sacerdote\", \"Sangre del Sacerdote\" y \"Médula del Sacerdote\" obtengan un bono adicional de caída (incluyendo la reproducción), los bonos específicos son los siguientes:\n· Cuerpo despertado \"Miryam\": Despertar 0/1/2/3 y más, bono de 20%/30%/40%/50%\n· Rueda del destino SSR \"Poder del Piadoso\": Superposición 0/1/2/3 y más, bono de 20%/30%/40%/50%\n· Rueda del destino SR \"El Llamado del Mar Profundo\": Superposición 0/1/2/3 y más, bono de 20%/30%/40%/50%\n2. La \"Bonificación de Ofrenda\" de diferentes cuerpos despertados o ruedas del destino se calculará de manera acumulativa.\n\n<Title: Resonancia: Ritual de Sacrificio del Mar>\n1. Los guardianes pueden obtener \"Corazón Piadoso\" al completar logros de la actividad.\n2. Al consumir \"Corazón Piadoso\", se activa \"Resonancia: Ritual de Sacrificio del Mar\", lo que proporciona los siguientes beneficios:\n(1) Hace que los guardianes sean más fuertes en la mecánica de la actividad \"Nacimiento del Reino Divino\", facilitando los desafíos.\n(2) Aumenta la moneda de actividad obtenida al completar los desafíos de \"Nacimiento del Reino Divino\".\n(3) Activa la mecánica de la actividad \"El Decreto del Soberano\".\n\n<Title: El Decreto del Soberano>\n· Al activar la resonancia \"Prueba de Sacrificio\", se obtendrán automáticamente 60 \"Lágrimas del Sacerdote\" cada hora, con un máximo de almacenamiento de 25 horas.\n\n<Title: Respuesta del Abismo>\n1. \"Respuesta del Abismo\" consta de tres altares, los horarios de apertura son los siguientes:\n· \"Altar de Lágrimas Brillantes\": se abrirá el 17 de junio a las 9:00.\n· \"Altar de Sangre de Gorila\": se abrirá el 19 de junio a las 9:00.\n· \"Altar de Espíritus\": se abrirá el 21 de junio a las 9:00.\n2. Cada ofrenda consumirá 500 \"Lágrimas del Sacerdote\"/\"Sangre del Sacerdote\"/\"Médula del Sacerdote\", y se obtendrán aleatoriamente cinco recompensas de los altares.\n3. Las recompensas de los altares se dividen en dos tipos: \"Don del Reino Divino\" y \"Recompensa Común\". Al reiniciar, se puede restablecer la cantidad restante de recompensas específicas a su límite, las reglas específicas son:\n(1) En las primeras 2 reinicios: cuando no haya cantidad restante de \"Don del Reino Divino\", el guardián puede elegir reiniciar; al reiniciar, se restablecerán las cantidades restantes de \"Don del Reino Divino\" y \"Recompensa Común\" a su límite; también puede elegir continuar ofreciendo ofrendas; cuando no haya cantidad restante de \"Recompensa Común\", debe reiniciar para poder continuar ofreciendo ofrendas.\n(2) A partir del tercer reinicio: solo se puede reiniciar cuando no haya cantidad restante de \"Recompensa Común\"; el reinicio restablecerá la cantidad restante de \"Recompensa Común\" a su límite, y \"Don del Reino Divino\" no se restablecerá más.\n\n<Title: Mundo de Sueños Extraños>\n1. \"Mundo de Sueños Extraños\" es un nuevo tipo de investigación, en comparación con la forma habitual de interpretación de la trama, \"Mundo de Sueños Extraños\" se centrará más en la expresión escrita, con un mayor volumen de contenido textual.\n2. En \"Mundo de Sueños Extraños: Profanación\", a través de la conexión con el espíritu de Miryam, se leerán directamente sus recuerdos, lo que permitirá presenciar cómo, siendo aún una niña, Miryam experimenta paso a paso las dificultades de Lemuria, se pierde en la fe, lucha en la fe, y finalmente se convierte en salvadora y destructora...\n3. Durante el período de la actividad, \"Mundo de Sueños Extraños: Profanación\" estará disponible de forma gratuita. Cada dos días se lanzarán nuevos eventos, y al completar \"Mundo de Sueños Extraños: Profanación\" se podrán obtener recompensas como Núcleo de Plata y la rueda del destino SR exclusiva de evento \"El Llamado del Mar Profundo\" en las recompensas de logro, estas solo estarán disponibles durante el período de la actividad, y no se podrán completar ni recoger al final de la actividad.\n4. Al finalizar la actividad, el progreso de investigación de \"Mundo de Sueños Extraños: Profanación\" se mantendrá; si no se desbloquea \"Mundo de Sueños Extraños: Profanación\" durante el período de la actividad, se podrá desbloquear consumiendo \"Punto de partida real\" × 7 después de que la actividad haya terminado.\n5. Independientemente de si se completó durante el período de la actividad, al completar \"Mundo de Sueños Extraños: Profanación\" se obtendrá \"Posse: Festival de las Mareas\".\n\n\n\n"
  },
  Activity_52040_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_53727_ActivityName = {
    Text = "Día de regreso a clases"
  },
  Activity_53727_ActivityTips = {
    Text = "<Title:Event Introduction>\n· Las tareas de \"Día de Regreso a Clases\" están divididas en 4 grupos, desbloqueándose en el 1er, 2do, 3er y 4to día del evento.\n· Los Guardianes pueden obtener \"Invitación de Regreso a Clases\" al completar las tareas de \"Día de Regreso a Clases\".\n· Usar \"Invitación de Regreso a Clases\" permite a los Guardianes intercambiar por generosas recompensas en la \"Tienda de Regreso a Clases.\""
  },
  Activity_53728_ActivityName = {
    Text = "Ayuda para el camino del peregrino"
  },
  Activity_53728_ActivityTips = {
    Text = "<Title:Resumen del evento>\n Durante el evento \"Apoya el nuevo camino\", los Guardianes recibirán el doble de recompensas de Rosa Dorada y materiales tras completar \"Preparación y afilado\", \"Residuo turbio\", \"Residuo de las Abejas\", \"Residuo orgánico\", \"Residuo dimensional\", \"Cluster caótico\", \"Ruinas de Ponape\", \"Nido de gusanos\" y \"Garganta de Schwarzschild\". Se pueden disfrutar un total de 6 recompensas dobles cada día.\nLas oportunidades de recompensa doble no utilizadas durante el día se reiniciarán a las 9:00 AM (GMT+8) del día siguiente. ¡Guardianes, recuerden usarlas a tiempo!"
  },
  Activity_53729_ActivityName = {
    Text = "Registro de regreso a clases"
  },
  Activity_53729_ActivityTips = {
    Text = "<Title:Event Overview>\n· Los Guardianes pueden reclamar la recompensa diaria de registro en \"Informe de Regreso a Clases\" después de iniciar sesión cada día.\n· Las recompensas se desbloquearán secuencialmente basadas en los inicios de sesión acumulativos de los Guardianes, y las recompensas diarias de registro se actualizarán a las 9:00 AM (GMT+8)."
  },
  Activity_53829_ActivityName = {
    Text = "Con el libro de la rosa"
  },
  Activity_53829_ActivityPlot = {
    Text = "Diamantes dorados, perlas brillantes... \nInnumerables adornos ostentosos le ganaron una ilusión de emperatriz. \nAhora, está decidida a mantener esa ilusión para siempre"
  },
  Activity_53829_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Festival dorado\""
  },
  Activity_53829_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes pueden recolectar la moneda del evento \"Plumas de Invocación\" a través de las actividades limitadas \"Recuerdos de la Rosa\" y \"Recompensa de logro\". Las \"Plumas de Invocación\" se pueden canjear en la \"Celebración Dorada y Roja\" por recompensas abundantes, incluyendo la rueda de destino SR limitada del evento \"La Mirada Favorecida por Millones\", \"Núcleo Puro\", \"Núcleo de Lumen\", \"Fragmentos de Piedra Sabia\", \"Cristal de Mimesis\", entre otros. \n2. Durante el evento, completar las tareas de \"Recompensa de logro\" permitirá obtener el avatar limitado del evento \"En Nombre de la Rosa: Sorel\", la rueda de destino SR limitada \"La Mirada Favorecida por Millones\", Núcleo de plata y una gran cantidad de la moneda del evento \"Plumas de Invocación\". \n3. Durante el evento, \"Registro de la fuerza especial: Himno a la Rosa\" estará disponible de forma gratuita. \n\n<Title:Tiempo del evento>\n1. Del 1 de julio a las 9:00 - 15 de julio a las 9:00 (GMT+8), todos los contenidos del evento son accesibles. \n2. Del 15 de julio a las 9:00 - 22 de julio a las 9:00 (GMT+8), solo se mantendrán \"Celebración Dorada y Roja\" y \"Recompensa de logro\", los demás contenidos habrán finalizado y no estarán disponibles. \n\n<Title:Recuerdos de la Rosa>\n1. \"Recuerdos de la Rosa\" consta de 9 niveles, uno se abrirá automáticamente cada día. \n2. Cada desafío consumirá \"Morfina\" × 120. Al desafiar diferentes niveles, además de obtener diferentes materiales, también se obtendrá la moneda del evento \"Plumas de Invocación\". \n3. Los niveles de este evento son niveles de materiales de combate directo, y después de completarlos se pueden reproducir. Cada \"reproducción\" consume \"Morfina\" × 120. \n4. Tenga en cuenta: al usar la función \"reproducción\", no se obtendrá la tasa de sincronización. \n\n<Title:Bonificación de las Plumas>\n1. Los Guardianes que posean un Despertado o rueda de destino específica (no es necesario que estén en el equipo) pueden obtener una bonificación adicional de caída en las \"Plumas de Invocación\" de las recompensas de la tarea de \"Recuerdos de la Rosa\" (incluyendo reproducción), las bonificaciones son las siguientes: \n·Despertado \"Sorel\": Despertar 0/1/2/3 y más, bonificación 20%/30%/40%/50% \n·Rueda de destino SSR \"En Nombre de la Rosa\": Posición superpuesta 0/1/2/3 y más, bonificación 20%/30%/40%/50% \n·Rueda de destino SR \"La Mirada Favorecida por Millones\": Posición superpuesta 0/1/2/3 y más, bonificación 20%/30%/40%/50% \n2. Las \"bonificaciones de las Plumas\" de diferentes Despertados o ruedas de destino se suman de manera acumulativa. \n\n<Title:Registro de la fuerza especial>\n1. Durante el evento, los Guardianes que hayan desbloqueado previamente \"Registro de la fuerza especial: Himno a la Rosa\" recibirán una compensación de \"Plumas de Invocación\" × 600 al volver a desbloquearlo. \n2. En \"Registro de la fuerza especial: Himno a la Rosa\", los Guardianes utilizarán un equipo especial que incluye la configuración de la trama \"Sorel\" para los desafíos."
  },
  Activity_53829_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_54375_ActivityName = {
    Text = "Himno a la Rosa"
  },
  Activity_54375_ActivityPlot = {
    Text = "Damas y caballeros.\nLa noche tranquila ha comenzado, preparen sus bebidas.\nEs una historia larga, déjennos contarla lentamente"
  },
  Activity_54375_ActivityTips = {
    Text = "<Title:Condiciones de Participación>\n·Completa \"Operación de Investigación\" 2-9 (Normal) para participar.\n<Title:Evento de Investigación>\n·Durante el período del evento, se lanzará un nuevo evento de investigación de \"Tributo Rosado\" diariamente. Los Guardianes pueden desbloquear e investigar sin consumir inventario. Después de completar el evento de investigación, se pueden obtener recompensas como Núcleo Puro, Insignia de Investigación y Experiencia de Guardián.\n·Después de que el evento finalice, el progreso de investigación de \"Tributo Rosado\" se mantendrá, y los Guardianes pueden consumir D-joyas en el Registro Especial para desbloquear investigaciones no completadas. Completar eventos de investigación no completados durante el período del evento también otorgará recompensas consistentes con las de durante el evento.<Title:Recompensas por Tiempo Limitado>\n·Las recompensas por tiempo limitado estarán disponibles durante el evento. Los Guardianes pueden obtener Núcleo Puro, Piedra Filosofal y recompensas de Plata después de completar el modo \"Tributo Rosado\" (Normal) y completar los eventos de investigación de \"Tributo Rosado\"! Las recompensas por tiempo limitado solo están disponibles durante el período del evento y no se pueden completar ni reclamar después de que finalice el evento."
  },
  Activity_54402_ActivityName = {
    Text = "Paciente disociativo: caos"
  },
  Activity_54402_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Paciente Astillado: Caos\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan \"24\" para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_54403_ActivityName = {
    Text = "Llave de la puerta"
  },
  Activity_54403_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante el evento \"Key of the Door\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyen a Tawil para experimentar niveles designados infinitamente.\n·Mientras se experimentan los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Event Rewards>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_54404_ActivityName = {
    Text = "Obispo de bálsamos"
  },
  Activity_54404_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Obispo Benevolente\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan a Salvador para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_54405_ActivityName = {
    Text = "Paciente disociativo: ultra"
  },
  Activity_54405_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Paciente Dividido: Ultra\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen \"24\" para experimentar niveles designados infinitamente.\n·Al experimentar niveles de evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_54406_ActivityName = {
    Text = "Apóstol del mar"
  },
  Activity_54406_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n· Durante el evento \"Apóstol del Mar\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyan a Miryam para experimentar niveles designados de manera infinita.\n· Al experimentar los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n· Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_54407_ActivityName = {
    Text = "Intérprete eterno"
  },
  Activity_54407_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante el evento \"Eternal Performer\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyen a Hameln para experimentar niveles designados infinitamente.\n·Al experimentar los niveles del evento, no se permite hacer ajustes a los Despertadores en la alineación del equipo.\n<Title:Event Rewards>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_54408_ActivityName = {
    Text = "Segador de almas"
  },
  Activity_54408_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante el evento \"Coleccionista de Almas\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen Helot: Catena para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Event Rewards>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_54409_ActivityName = {
    Text = "Paciente disociativo: aequor"
  },
  Activity_54409_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Paciente Astillado: Aequor\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan \"24\" para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_54410_ActivityName = {
    Text = "Paciente disociativo: caro"
  },
  Activity_54410_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Paciente Dividido: Caro\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen \"24\" para experimentar niveles designados infinitamente.\n·Al experimentar niveles de evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_54411_ActivityName = {
    Text = "Cerebro corrupto"
  },
  Activity_54411_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento \"Cerebro en putrefacción\", los guardianes pueden usar el equipo preestablecido que incluye \"Dol: Fusión\" para repetir las misiones designadas sin límite de veces.\n· Al jugar las misiones del evento, no se puede ajustar la formación de cuerpos despiertos en el equipo.\n<Title:Recompensas del evento>\n· Tras completar por primera vez el desafío de la misión, se podrá reclamar la recompensa de prueba en la interfaz del evento.\n\n."
  },
  Activity_54521_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_54521_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_54522_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_54522_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_54523_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_54523_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_54524_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_54524_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_54525_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_54525_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_54526_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_54526_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_54527_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_54527_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_54596_ActivityName = {
    Text = "Don del conocimiento"
  },
  Activity_54596_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Después de que los Guardianes de Secretos completen las tareas designadas del evento, podrán reclamar recompensas abundantes como \"Parque prototípico\", \"Libro de rotación\", \"Horizonte de Prototipo\", \"modelo de bucle\", \"Núcleo de Retroceso del Alma\", \"Núcleo de Retroceso del Destino\", así como los cuerpos despertados y las ruedas del destino de la \"Capítulo Olvidado\" y \"Capítulo de las Estrellas\", además del marco de avatar exclusivo del evento \"Rectángulo Plateado\" y aceleración de la Experiencia del Guardián de Secretos, entre otras recompensas!\n2. Este evento estará disponible de forma permanente. Después de completar todas las tareas del evento y reclamar todas las recompensas, el evento finalizará y no se mostrará más después de las 9:00 (GMT+8) del día siguiente.\n\n<Title:Elogio Supremo>\n1. Completar las tareas designadas del evento puede otorgar el efecto \"Elogio Supremo\", lo que acelera la Experiencia del Guardián de Secretos, alcanzando hasta un 100%. Si hay múltiples efectos de \"Elogio Supremo\" activos, se tomará el efecto de aceleración más alto.\n2. Al desbloquear o recibir un efecto de \"Elogio Supremo\" de mayor nivel, se obtendrá inmediatamente experiencia adicional del Guardián de Secretos, según la proporción de aceleración y la cantidad total de experiencia del Guardián de Secretos que puede ser acelerada.\n3. Después de desbloquear \"Elogio Supremo\", cada vez que un Guardián de Secretos obtenga experiencia, también recibirá experiencia adicional correspondiente a la proporción de aceleración.\n4. Tenga en cuenta que la experiencia adicional del Guardián de Secretos proporcionada por \"Elogio Supremo\" no se incluirá en la cantidad total de experiencia del Guardián de Secretos que puede ser acelerada.\n5. Cantidad total de experiencia del Guardián de Secretos que puede ser acelerada actualmente: {s1}.\n6. Experiencia adicional del Guardián de Secretos acumulada por aceleración: {s2} ({s3}%)."
  },
  Activity_55110_ActivityName = {
    Text = "Antes de que la primavera se marchite"
  },
  Activity_55110_ActivityPlot = {
    Text = "La risa de las chicas resuena en el jardín antes de que el fuego comience.\nPausa por este hermoso pasado, amigo mío.\nEscucha las historias de la primavera no desvanecida, narradas suavemente."
  },
  Activity_55110_ActivityStageEndContent = {
    Text = "El evento ha terminado. Actualmente, solo \"Casa Floral de Colette\" está disponible."
  },
  Activity_55110_ActivityTips = {
    Text = "<Title:Descripción de la actividad>\n1. Durante el evento, los Guardianes del Secreto pueden recolectar tres tipos de \"poemas\" a través de las actividades temporales \"Jardín de recuerdos\", \"Beso de la musa\" y \"Recompensas de logro\". Los \"poemas\" se pueden utilizar en \"La casa de flores de Colette\" para intercambiar y obtener recompensas de objetos, incluyendo la Rueda SR limitada \"Flores y poemas del pasado\", \"Núcleo Puro\", \"Núcleo de Lumen\", \"Fragmentos de Piedra Sabia\", \"Cristal de Mimesis\", entre otros. \n2. Durante el evento, \"Registro de la fuerza especial: Morada de la Rosa\" estará disponible de forma gratuita. \n\n<Title:Tiempo de la actividad>\n1. Del 15 de julio a las 9:00 al 29 de julio a las 9:00 (GMT+8), todos los contenidos del evento estarán disponibles. \n2. Del 29 de julio a las 9:00 al 5 de agosto a las 9:00 (GMT+8), solo estarán disponibles \"La casa de flores de Colette\" y \"Recompensas de logro\", el resto de contenidos finalizarán y no podrán participar. \n\n<Title:Jardín de recuerdos>\n1. \"Jardín de recuerdos\" consta de 5 niveles, uno se abrirá automáticamente cada 2 días. \n2. Cada desafío consumirá \"Morfina\" × 120, y al completar el desafío, se obtendrán monedas del evento \"poesía melancólica\", \"Poema de Lamento\" y \"Poema alegre\". \n3. Tras completar un nivel, se desbloqueará la función de \"Reproducción\" de ese nivel. Tenga en cuenta: al usar la función de \"Reproducción\", no se obtendrá tasa de sincronización. \n4. Se puede utilizar la ayuda de la Asociación de exalumnos y \"Resonancia: Elegía del jardín\" para facilitar la superación de los niveles. \n5. Dos días después de desbloquear el nivel, se activará la dificultad de locura de ese nivel. Completar la primera vez en dificultad de locura otorgará recompensas de moneda del evento significativas. \n6. Tenga en cuenta: los desafíos de dificultad de locura no consumen Morfina, no se pueden reproducir, y después de la primera superación, no se obtendrán más recompensas de moneda del evento en desafíos repetidos. \n\n<Title:Bonificación de poemas>\n1. Los Guardianes del Secreto que posean cuerpos despertados o Ruedas específicas (no se requiere que estén en el equipo) pueden hacer que las recompensas de las misiones en \"Jardín de recuerdos\" de \"poesía melancólica\", \"Poema de Lamento\" y \"Poema alegre\" obtengan bonificaciones adicionales de caída (incluyendo la reproducción), las bonificaciones son las siguientes: \n· Cuerpo despertado \"Horla\": Despertar 0/1/2/3 y superior, bonificación 20%/30%/40%/50% \n· Rueda SSR \"El Último Verso\": Sincronización 0/1/2/3 y superior, bonificación 20%/30%/40%/50% \n· Rueda SR \"Flores y poemas del pasado\": Sincronización 0/1/2/3 y superior, bonificación 20%/30%/40%/50% \n2. Las \"bonificaciones de poemas\" de diferentes cuerpos despertados o Ruedas se calcularán de manera acumulativa. \n3. Especialmente, las recompensas de la primera superación en dificultad de locura no se verán afectadas por las \"bonificaciones de poemas\". \n\n<Title:Resonancia: Elegía del jardín>\n1. Los Guardianes del Secreto pueden obtener \"Corazón de cenizas\" al completar logros del evento. \n2. Al consumir \"Corazón de cenizas\", se activa \"Resonancia: Elegía del jardín\", lo que proporciona las siguientes bonificaciones: \n(1) Permite a los Guardianes del Secreto ser más fuertes en la actividad \"Jardín de recuerdos\", haciendo que los desafíos sean más fáciles. \n(2) Aumenta la cantidad de moneda del evento obtenida después de completar los desafíos de \"Jardín de recuerdos\". \n(3) Activa la actividad \"Beso de la musa\". \n\n<Title:Beso de la musa>\n· Al activar la resonancia \"Todo crece\", se obtienen automáticamente 60 \"poesía melancólica\" por hora, con un máximo de 25 horas de almacenamiento. \n· Al activar la resonancia \"Intercambiar poemas por flores\", \"Beso de la musa\" puede obtener 60 \"Poema de Lamento\" adicionales por hora. \n\n<Title:La casa de flores de Colette>\n1. \"La casa de flores de Colette\" tiene tres jardines, los tiempos de apertura son los siguientes: \n· \"Jardín de lirios\": se abrirá el 15 de julio a las 9:00. \n· \"Jardín de campanillas\": se abrirá el 17 de julio a las 9:00. \n· \"Jardín de rosas\": se abrirá el 19 de julio a las 9:00. \n2. Cada intercambio consumirá 1000 \"poesía melancólica\"/\"Poema de Lamento\"/\"Poema alegre\", y se obtendrán aleatoriamente cinco recompensas de objetos del jardín. \n3. Las recompensas de objetos de cada jardín se dividen en \"objetos especiales\" y \"objetos normales\", al reiniciar se puede restablecer la cantidad restante de objetos especiales al límite, las reglas específicas son: \n(1) Primeras 2 reinicios: cuando no haya cantidad restante de \"objetos especiales\", el Guardián puede elegir reiniciar, el reinicio restablecerá la cantidad restante de \"objetos especiales\" y \"objetos normales\" al límite; también se puede elegir continuar intercambiando, cuando no haya cantidad restante de \"objetos normales\", se deberá reiniciar para poder continuar intercambiando. \n(2) A partir del tercer reinicio: solo se puede reiniciar cuando no haya cantidad restante de \"objetos normales\", el reinicio restablecerá la cantidad restante de \"objetos normales\" al límite, y \"objetos especiales\" no se reiniciarán. \n4. Después del 5 de agosto a las 9:00 (GMT+8), los \"poemas\" restantes no intercambiados se convertirán a razón de cada 200 por \"Rosa Dorada ×5000\", por favor, los Guardianes del Secreto estén atentos a su correo. \n\n<Title:Registro de la fuerza especial>\n1. Durante el evento, \"Registro de la fuerza especial: Morada de la Rosa\" estará disponible de forma gratuita. Cada 2 días se lanzará un nuevo evento, al completar \"Registro de la fuerza especial: Morada de la Rosa\" se pueden obtener \"Núcleo de plata\", Rueda SR limitada \"Flores y poemas del pasado\", y recompensas de logro, las recompensas de logro solo estarán disponibles durante el evento, después de finalizar el evento no se podrán completar ni reclamar. \n2. Después de finalizar el evento, el progreso de investigación de \"Registro de la fuerza especial: Morada de la Rosa\" se mantendrá, si no se desbloqueó \"Registro de la fuerza especial: Morada de la Rosa\" durante el evento, después de finalizar el evento aún se podrá consumir \"Punto de partida real\" ×7 para desbloquearlo. \n3. Independientemente de si fue durante el evento, al completar \"Registro de la fuerza especial: Morada de la Rosa\" se obtendrá \"Posse: Ofrenda de primavera\"."
  },
  Activity_55110_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_55457_ActivityName = {
    Text = "Fisión Tranquila"
  },
  Activity_56427_ActivityName = {
    Text = "Pastor de Almas: Réplica"
  },
  Activity_56427_ActivityPlot = {
    Text = "Él sufrió por ustedes, cargó con sus calamidades.\nPor su carne y sangre, fueron sanados;\npor su vida, fueron perdonados"
  },
  Activity_56427_ActivityStageEndContent = {
    Text = "La actividad ha terminado, actualmente solo puedes participar en \"venta benéfica de la iglesia\""
  },
  Activity_56427_ActivityTips = {
    Text = "<Title:Descripción de la actividad>\n1. Durante el evento, los Guardianes del Secreto pueden recolectar la moneda del evento \"Bono de venta benéfica\" a través de los modos limitados \"Camino del Santuario\", \"La bondad de los ciudadanos\" y \"Recompensas de logro\". Los \"Bonos de venta benéfica\" se pueden canjear en el \"Lugar de venta benéfica de la iglesia\" por productos aleatorios, incluyendo el SR de edición limitada \"El hombre en el espejo\", Núcleo Puro, Núcleo de Lumen, etc. \n2. Durante el evento, \"Registro de la fuerza especial: El color de la sangre\" estará disponible de forma gratuita. ¡Completar los logros del evento también otorgará el avatar de edición limitada \"Por la Llave de Plata: Salvador\"!\n\n<Title:Tiempo de la actividad>\n1. Desde el 26 de agosto a las 9:00 hasta el 9 de septiembre a las 9:00 (GMT+8), todos los contenidos del evento estarán disponibles. \n2. Desde el 9 de septiembre a las 9:00 hasta el 16 de septiembre a las 9:00 (GMT+8), solo permanecerán el \"Lugar de venta benéfica de la iglesia\" y \"Recompensas de logro\", otros contenidos habrán terminado y no estarán disponibles. \n\n<Title:Camino del Santuario>\n1. \"Camino del Santuario\" consta de 5 niveles, que se abrirán automáticamente uno cada 2 días. \n2. Cada desafío consumirá \"Morfina\" × 120, y al completar el desafío se obtendrá la moneda del evento \"Bono de venta benéfica\". \n3. Después de completar el nivel, se desbloqueará la función de \"Reproducción\" de ese nivel. Tenga en cuenta: al usar la función de \"Reproducción\", no se obtendrá la tasa de sincronización. \n4. Se puede utilizar el apoyo de la asociación de exalumnos y \"Resonancia: La bifurcación del alma\" para ayudar a superar los niveles más fácilmente. \n\n<Title:Bonificación de Resplandor>\n1. Bajo la influencia de \"Resplandor del alma\", los Guardianes del Secreto que tengan un Despertado o Rueda específica (no es necesario que estén en la batalla) pueden hacer que la recompensa de la tarea de \"Camino del Santuario\" contenga una bonificación adicional de \"Bono de venta benéfica\" (incluyendo Reproducción), las bonificaciones específicas son las siguientes: \n· Despertado \"Salvador\": Despertar 0/1/2/3 y más, bonificación 20%/30%/40%/50%. \n· Rueda SSR \"Tablilla Sagrada\": Superposición 0/1/2/3 y más, bonificación 20%/30%/40%/50%. \n· Rueda SR \"El hombre en el espejo\": Superposición 0/1/2/3 y más, bonificación 20%/30%/40%/50%. \n2. Las \"bonificaciones de resplandor\" de diferentes Despertados o Ruedas se contabilizan de manera acumulativa. \n3. Especialmente, las recompensas por completar el desafío de dificultad locura no se verán afectadas por las \"bonificaciones de resplandor\". \n\n<Title:Resonancia: La bifurcación del alma>\n1. Los Guardianes del Secreto pueden obtener \"Corazón de penitencia\" al completar los logros del evento. \n2. Al consumir \"Corazón de penitencia\" y activar \"Resonancia: La bifurcación del alma\", se pueden obtener las siguientes bonificaciones: \n(1) Hacer que los Guardianes del Secreto se vuelvan más fuertes en los modos de evento \"Camino del Santuario\" y \"Registro de la fuerza especial: El color de la sangre\", haciendo los desafíos más fáciles. \n(2) Aumentar la tasa de sincronización obtenida tras completar el desafío de \"Camino del Santuario\". \n(3) Activar el modo de evento \"La bondad de los ciudadanos\". \n\n<Title:La bondad de los ciudadanos>\n1. Al activar la resonancia \"Forma fácil\", se obtendrán automáticamente 60 \"Bonos de venta benéfica\" cada hora, acumulando un máximo de 25 horas. \n2. Al activar la resonancia \"Purgación, Purgación\", se obtendrán automáticamente 1800 Rosa Dorada adicionales cada hora. \n\n<Title: Lugar de venta benéfica de la iglesia>\n1. El \"Lugar de venta benéfica de la iglesia\" tiene tres tiendas, los horarios de apertura son los siguientes: \n· \"La tienda de la Sra. Grey\": se abrirá el 26 de agosto a las 9:00. \n· \"La venta mágica de Big John\": se abrirá el 29 de agosto a las 9:00. \n· \"Venta especial de Smith\": se abrirá el 1 de septiembre a las 9:00. \n2. Cada intercambio consumirá 1000 \"Bonos de venta benéfica\", y se obtendrán aleatoriamente cinco recompensas de la tienda. \n3. Las recompensas de los artículos de cada tienda se dividen en \"Objeto especial\" y \"Objeto normal\", al reiniciar se puede restablecer la cantidad restante de recompensas de objetos especiales a su límite, las reglas específicas son: \n(1) Primeras 2 reinicios: cuando no haya cantidad restante de \"Objeto especial\", el Guardián del Secreto puede elegir reiniciar, después del reinicio se restablecerán las cantidades restantes de \"Objeto especial\" y \"Objeto normal\" a su límite; también puede optar por continuar intercambiando, cuando no haya cantidad restante de \"Objeto normal\", debe reiniciar para continuar intercambiando. \n(2) A partir del tercer reinicio: solo se puede reiniciar cuando no haya cantidad restante de \"Objeto normal\", el reinicio restablecerá la cantidad restante de \"Objeto normal\" a su límite, \"Objeto especial\" no se reiniciará. \n4. Después del 16 de septiembre a las 9:00 (GMT+8), los \"Bonos de venta benéfica\" restantes no intercambiados se convertirán en \"Rosa Dorada×5000\" por cada 200, por favor, los Guardianes del Secreto presten atención a revisar su correo. \n\n<Title:Registro de la fuerza especial>\n1. Durante el evento, \"Registro de la fuerza especial: El color de la sangre\" estará disponible de forma gratuita. \n2. Después de que termine el evento, el progreso de la investigación de \"Registro de la fuerza especial: El color de la sangre\" se mantendrá, si no se desbloqueó \"Registro de la fuerza especial: El color de la sangre\" durante el evento, aún se podrá consumir \"Punto de partida real\" × 7 para desbloquearlo después de que termine el evento. \n3. Independientemente de si se realizó durante el evento, tras completar \"Registro de la fuerza especial: El color de la sangre\" se puede obtener \"Posse: El amanecer del milagro\". \n\n<Title:Compensación de reedición>\n1. Los Guardianes del Secreto que ya hayan desbloqueado \"Registro de la fuerza especial: El color de la sangre\" recibirán una compensación de \"Bonos de venta benéfica\" × 700 al desbloquearlo nuevamente durante este evento de reedición. \n2. Los Guardianes del Secreto que ya hayan obtenido el avatar de edición limitada \"Por la Llave de Plata: Salvador\", al obtenerlo nuevamente se convertirá automáticamente en \"Bonos de venta benéfica\" × 2000. \n3. Los Guardianes del Secreto que ya hayan obtenido el material de activación de resonancia \"Corazón de penitencia\", cada vez que obtengan 1 \"Corazón de penitencia\" adicional se convertirá automáticamente en \"Rosa Dorada\" × 5000. \n"
  },
  Activity_56427_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_56428_ActivityName = {
    Text = "Sacrificio del Abismo: Repetir"
  },
  Activity_56428_ActivityPlot = {
    Text = "En el reflejo del océano, el sueño del rey se desvanece y el reino de los dioses se corrompe.\nElla viene del sueño antiguo, hacia las ruinas del futuro.\nPregunta al abismo, pero el abismo guarda silencio.\nElla ofrece sacrificios al abismo, y solo se responde a sí misma"
  },
  Activity_56428_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Respuesta del abismo\""
  },
  Activity_56428_ActivityTips = {
    Text = "<Title:Introducción a la actividad>\n1. Durante el evento, los Guardianes del Secreto pueden recolectar moneda del evento a través de las jugadas limitadas \"Nacimiento del Reino Divino\", \"El decreto del soberano\" y \"Recompensa de logro\". La moneda del evento se puede usar en \"Respuesta del Abismo\" para hacer ofrendas y obtener recompensas de artículos, incluyendo la rueda del destino SR exclusiva de evento \"El Llamado del Mar Profundo\", la Piedra Filosofal, Núcleo Puro, Núcleo de Lumen, entre otros. \n2. Durante el evento, \"Mundo de Sueños Extraños: Profanación\" estará disponible de forma gratuita, y completar los logros del evento también otorgará el avatar exclusivo de evento \"Por la Llave de Plata: Miryam\"!\n\n<Title:Tiempo de la actividad>\n1. Del 4 de noviembre a las 9:00 - 18 de noviembre a las 9:00 (GMT+8), todos los contenidos del evento están disponibles para participar. \n2. Del 18 de noviembre a las 9:00 - 25 de noviembre a las 9:00 (GMT+8), solo se conservarán \"Respuesta del Abismo\" y \"Recompensa de logro\", el resto de los contenidos ya han finalizado y no se pueden participar. \n\n<Title:Nacimiento del Reino Divino>\n1. \"Nacimiento del Reino Divino\" consta de 5 niveles, que se abrirán automáticamente uno cada 2 días. \n2. Cada desafío consumirá \"Morfina\" × 120, y al completar el desafío se obtendrá moneda del evento. \n3. Después de completar el nivel, se desbloqueará la función de \"Reproducción\" de ese nivel. Por favor, ten en cuenta: al usar la función de \"Reproducción\", no se obtendrá tasa de sincronización. \n4. Puedes usar el apoyo de la asociación de antiguos alumnos y \"Resonancia: Ritual de las Mareas\" para ayudarte a completar los niveles más fácilmente. \n\n<Title:Bonificación de Ofrenda>\n1. Los Guardianes del Secreto que tengan cuerpos despertados o ruedas del destino específicos (no se requiere que estén en el equipo) pueden hacer que las recompensas de las misiones de \"Nacimiento del Reino Divino\" obtengan caídas adicionales de \"Lágrimas del Sacerdote\", \"Sangre del sacerdote\" y \"Médula del sacrificador\" (incluyendo la reproducción), los detalles de las bonificaciones son los siguientes: \n· Cuerpo despertado \"Miryam\": Despertar 0/1/2/3 y más, bonificación 20%/30%/40%/50% \n· Rueda del destino SSR \"Poder del piadoso\": Posición superpuesta 0/1/2/3 y más, bonificación 20%/30%/40%/50% \n· Rueda del destino SR \"El Llamado del Mar Profundo\": Posición superpuesta 0/1/2/3 y más, bonificación 20%/30%/40%/50% \n2. Las \"Bonificaciones de Ofrenda\" de diferentes cuerpos despertados o ruedas del destino se calcularán de manera acumulativa. \n3. De manera especial, la recompensa del primer desafío de dificultad locura no se verá afectada por las \"Bonificaciones de Ofrenda\". \n\n<Title:Resonancia: Ritual de las Mareas>\n1. Los Guardianes del Secreto pueden obtener \"Corazón piadoso\" completando logros del evento. \n2. Consumir \"Corazón piadoso\" para activar \"Resonancia: Ritual de las Mareas\" otorgará las siguientes bonificaciones: \n(1)Hará que los Guardianes del Secreto sean más fuertes en la jugabilidad del evento \"Nacimiento del Reino Divino\", haciendo que los desafíos sean más fáciles. \n(2)Aumentará la moneda del evento obtenida después de completar el desafío \"Nacimiento del Reino Divino\". \n(3)Activará la jugabilidad del evento \"El decreto del soberano\". \n\n<Title:El decreto del soberano>\n· Al activar la resonancia \"Prueba de sacrificio\", se obtendrán automáticamente 60 \"Lágrimas del Sacerdote\" cada hora, con un máximo de 25 horas. \n\n<Title:Respuesta del Abismo>\n1. \"Respuesta del Abismo\" tiene tres altares, los tiempos de apertura son los siguientes: \n· \"Altar de Lágrimas Brillantes\": del 4 de noviembre a las 9:00 ~ 25 de noviembre a las 9:00. \n· \"Altar de Sangre de Gorila\": del 6 de noviembre a las 9:00 ~ 25 de noviembre a las 9:00. \n· \"Altar de Espíritus\": del 8 de noviembre a las 9:00 ~ 25 de noviembre a las 9:00. \n2. Cada ofrenda de sacrificios consumirá 1000 \"Lágrimas del Sacerdote\"/\"Sangre del sacerdote\"/\"Médula del sacrificador\", y se obtendrán aleatoriamente cinco recompensas de artículos del altar. \n3. Las recompensas de artículos de cada altar se dividen en \"Objetos especiales\" y \"Objetos normales\", al reiniciar se puede restablecer la cantidad restante de artículos designados a su límite, las reglas específicas son: \n(1)Las primeras 2 reinicios: cuando no haya cantidad restante de \"Objetos especiales\", el Guardián del Secreto puede elegir reiniciar, después de reiniciar se restablecerán las cantidades restantes de \"Objetos especiales\" y \"Objetos normales\" a su límite; también puede elegir continuar ofrendando sacrificios, cuando no haya cantidad restante de \"Objetos normales\", deberá reiniciar para poder continuar ofrendando sacrificios. \n(2)A partir del 3er reinicio: solo se puede reiniciar cuando no haya cantidad restante de \"Objetos normales\", el reinicio restablecerá la cantidad restante de \"Objetos normales\" a su límite, \"Objetos especiales\" no se reiniciarán. \n\n<Title:Mundo de Sueños Extraños>\n1. Durante el evento, \"Mundo de Sueños Extraños: Profanación\" estará disponible de forma gratuita. \n2. Al finalizar el evento, el progreso de investigación de \"Mundo de Sueños Extraños: Profanación\" se mantendrá, si no se desbloqueó \"Mundo de Sueños Extraños: Profanación\" durante el evento, aún se puede consumir \"Punto de partida real\" ×7 para desbloquear. \n3. Independientemente de si está o no durante el evento, después de completar \"Mundo de Sueños Extraños: Profanación\", se puede obtener \"Posse: Festival de las Mareas\". \n\n<Title:Compensación por repetición>\n1. Los Guardianes del Secreto que ya han desbloqueado \"Mundo de Sueños Extraños: Profanación\" recibirán una compensación de \"Lágrimas del Sacerdote\" ×700 durante este periodo de repetición al volver a desbloquear. \n2. Los Guardianes del Secreto que ya han obtenido el avatar exclusivo de evento \"Por la Llave de Plata: Miryam\" al obtenerlo nuevamente se convertirá automáticamente en \"Lágrimas del Sacerdote\" ×2000. \n3. Los Guardianes del Secreto que ya han obtenido el material de activación de resonancia \"Corazón piadoso\", cada vez que obtengan un \"Corazón piadoso\" adicional se convertirá automáticamente en \"Rosa Dorada\" ×5000. \n"
  },
  Activity_56428_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_56429_ActivityName = {
    Text = "A medio paso de distancia"
  },
  Activity_56429_ActivityPlot = {
    Text = "Ella siempre va un paso por delante del mundo.\nUn paso, dos pasos—sus huellas iluminan el camino para todos.\nPero los necios olvidan con demasiada facilidad:\nLa distancia entre la genialidad y la locura\nes de apenas medio paso."
  },
  Activity_56429_ActivityStageEndContent = {
    Text = "El evento ha Terminado. Actualmente, solo \"Enseñanzas del Maestro\" está disponible."
  },
  Activity_56429_ActivityTips = {
    Text = "<Title:Descripción del evento>\nDurante el evento, los Guardianes pueden recolectar la moneda de evento \"Piezas de muñeca\" a través de las mecánicas limitadas \"Puerta de la Nada\" y \"Recompensas por Logros\". Las \"Piezas de muñeca\" pueden intercambiarse por recompensas en \"Enseñanzas del Maestro\", incluyendo la Rueda del destino SR exclusiva del evento \"Bastón del Pastor\", Núcleo de Lumen, Núcleo Puro, Fragmentos de Piedra Sabia, Cristal de Mimesis y otros.\n\n<Title:Puerta de la Nada>\n1. \"Puerta de la Nada\" contiene 9 misiones de materiales que no requieren exploración, solo combate directo, abriéndose 1 por día.\n2. Cada desafío consume 120 puntos de neuropéptido, y al tener éxito se obtienen materiales de entrenamiento y moneda de evento.\n3. Al completar una misión, se desbloquea su función \"Repetición\". Por favor, ten en cuenta: al usar la función \"Repetición\", no se obtiene tasa de sincronización.\n4. Puedes usar el apoyo de los Alumnis para ayudarte a pasar las misiones más fácilmente.\n\n<Title:Bonificación de Piezas de muñeca>\n1. Cuando los Guardianes posean ciertos Cuerpos Despertados o Ruedas del destino específicas (no es necesario tenerlos en batalla), las \"Piezas de muñeca\" obtenidas como recompensa en las misiones de \"Puerta de la Nada\" (incluyendo la repetición) recibirán bonificaciones adicionales de caída, como se detalla a continuación:\nCuerpo Despertado \"Doll: Infierno\": Despertar Espiritual 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\nRueda del destino SSR \"Títere del Vacío\": Apilamiento 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\nRueda del destino SR \"Bastón del Pastor\": Apilamiento 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\n2. Las bonificaciones de \"Piezas de muñeca\" de diferentes Cuerpos Despertados o Ruedas del destino se aplican de forma acumulativa.\n3. Especialmente, las recompensas por primera vez en dificultad Locura no se ven afectadas por las bonificaciones mencionadas anteriormente.\n\n<Title:Enseñanzas del Maestro>\n1. Cada \"Intercambio de Piezas\" consumirá 750 \"Piezas de muñeca\", otorgando aleatoriamente cinco recompensas entre los artículos de \"Enseñanzas del Maestro\".\n2. Las recompensas de artículos en \"Enseñanzas del Maestro\" se dividen en dos tipos: \"Objeto especial\" y \"Objeto normal\". Al reiniciar, se puede restablecer la cantidad restante de recompensas de objetos especiales hasta el límite máximo. Las reglas específicas son las siguientes:\n(1) Primeros 5 reinicios: cuando ya no haya \"Objeto especial\" disponible, los Guardianes pueden elegir reiniciar, lo que restablecerá la cantidad restante de \"Objeto especial\" y \"Objeto normal\" hasta el límite máximo; también pueden optar por continuar intercambiando, y cuando ya no haya \"Objeto normal\" disponible, deberán reiniciar para poder seguir intercambiando.\n(2) A partir del sexto reinicio: solo se podrá reiniciar cuando ya no haya \"Objeto normal\" disponible, el reinicio restablecerá la cantidad restante de \"Objeto normal\" hasta el límite máximo, pero ya no se restablecerá el \"Objeto especial\".\n\n<Title:Duración del Evento>\n1. Del 17 de febrero 09:00 al 3 de marzo 09:00 (GMT+8), todo el contenido mencionado en la descripción del evento estará disponible.\n2. Del 3 de marzo 09:00 al 10 de marzo 09:00 (GMT+8), solo permanecerán disponibles \"Enseñanzas del Maestro\" y \"Recompensas por Logros\", el resto del contenido habrá finalizado y ya no será jugable.\n3. Después del 10 de marzo 09:00 (GMT+8), las \"Piezas de muñeca\" restantes que no hayan sido canjeadas se convertirán en \"Rosa Dorada*40\" por cada intercambio, por favor asegúrate de revisar tu correo."
  },
  Activity_56429_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_56430_ActivityName = {
    Text = "Sinfonía Inmaterial"
  },
  Activity_56430_ActivityPlot = {
    Text = "La sinfonía es un arte de tejido, donde las trayectorias de los instrumentos se entrelazan en un patrón.\nEn su red, cada nota tiene su función.\nEscucha, una sinfonía sublime está por comenzar"
  },
  Activity_56430_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Palacio del sueño\""
  },
  Activity_56430_ActivityTips = {
    Text = "<Title:Introducción a la actividad>\n1. Durante el evento, los Guardianes del Secreto pueden recolectar la moneda del evento \"Canto heroico\" a través de los modos limitados \"Sonido atronador\" y \"Recompensa de logro\". \"Canto heroico\" se puede canjear por recompensas abundantes en el \"Palacio del Sueño\", incluyendo la rueda de destino SR limitada del evento \"Presentación que nunca para\", \"Núcleo Puro\", \"Núcleo de Lumen\", \"Fragmentos de Piedra Sabia\", \"Cristal de Mimesis\", entre otros.\n2. Durante el evento, al completar las misiones de \"Recompensa de logro\" se puede obtener el avatar limitado del evento \"Por la Llave de Plata: Hameln\", la rueda de destino SR limitada del evento \"Presentación que nunca para\", Núcleo de plata y una gran cantidad de moneda del evento \"Canto heroico\".\n\n<Title: Tiempo de la actividad>\n1. Del 9 de septiembre a las 9:00 al 23 de septiembre a las 9:00 (GMT+8), todo el contenido del evento está disponible para participar.\n2. Del 23 de septiembre a las 9:00 al 30 de septiembre a las 9:00 (GMT+8), solo se mantendrán el \"Palacio del Sueño\" y \"Recompensa de logro\", el resto del contenido ha finalizado y no se puede participar.\n\n<Title: Sonido atronador>\n1. \"Sonido atronador\" consta de 9 niveles, uno se abrirá automáticamente cada día.\n2. Cada desafío consumirá \"Morfina\" × 120. Al desafiar diferentes niveles, además de obtener diferentes materiales, también se obtendrá la moneda del evento \"Canto heroico\".\n3. Los niveles de este evento son niveles de combate directo, ¡se pueden reproducir después de completarlos! Cada vez que se \"reproduce\" se consumirá \"Morfina\" × 120.\n4. Tenga en cuenta: al usar la función \"reproducir\", no se obtendrá la tasa de sincronización.\n\n<Title: Bonificación de la música>\n1. Los Guardianes del Secreto que posean ciertos Despertados o ruedas de destino (no es necesario que estén en el equipo) pueden hacer que la moneda \"Canto heroico\" en las recompensas de las misiones de los niveles de \"Sonido atronador\" obtengan una bonificación adicional (incluido en la reproducción), las bonificaciones específicas son las siguientes:\n· Despertado \"Hameln\": Despertar 0/1/2/3 y más, bonificación del 20%/30%/40%/50%\n· Rueda de destino SSR \"Réquiem Eterno\": Posición superpuesta 0/1/2/3 y más, bonificación del 20%/30%/40%/50%\n· Rueda de destino SR \"Presentación que nunca para\": Posición superpuesta 0/1/2/3 y más, bonificación del 20%/30%/40%/50%\n2. Las \"bonificaciones de música\" de diferentes Despertados o ruedas de destino se calcularán de manera acumulativa.\n3. Especialmente, las recompensas del primer desafío de dificultad locura no se verán afectadas por las \"bonificaciones de música\".\n\n<Title: Palacio del Sueño>\n1. \"Palacio del Sueño\" solo estará abierto del 9 de septiembre a las 9:00 al 30 de septiembre a las 9:00 (GMT+8).\n2. Después del 30 de septiembre a las 9:00 (GMT+8), la \"Canto heroico\" restante no canjeada se recuperará a razón de 40 \"Rosa Dorada\" por cada uno, los Guardianes del Secreto deben estar atentos a revisar su correo."
  },
  Activity_56430_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_56431_ActivityName = {
    Text = "Las estrellas están alineadas"
  },
  Activity_56431_ActivityPlot = {
    Text = "El momento de la alineación de las estrellas está por llegar, las primeras vibraciones en su vientre se sienten como un tambor.\nLos pesares de las noches oscuras que la atormentaron durante años están a punto de llegar a su fin, acompañados por el llanto de inumerables creyentes.\nDesde su @1 oscuridad @2, la gran @3 descenderá al mundo"
  },
  Activity_56431_ActivityStageEndContent = {
    Text = "La actividad ha terminado, actualmente solo puedes participar en \"eclosión del embrión sagrado\""
  },
  Activity_56431_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes del Secreto pueden recolectar tres tipos de \"Embrión\" a través de las mecánicas limitadas \"Útero Oscuro\" y \"Recompensa de logro\". Los \"Embriones\" se pueden canjear por recompensas de objetos en \"Eclosión del Feto Sagrado\", incluyendo la rueda del destino SR exclusiva del evento \"Sueño Bajo el Glaciar\", \"Núcleo Puro\", \"Núcleo de Lumen\", \"Fragmentos de Piedra Sabia\", \"Cristal de Mimesis\", entre otros.\n2. Durante el evento, completar las misiones de \"Recompensa de logro\" permitirá obtener el avatar exclusivo del evento \"Por la Llave de Plata: Goliath\", la rueda del destino SR exclusiva del evento \"Sueño Bajo el Glaciar\" y una gran cantidad de \"Embriones\".\n\n<Title: Tiempo del evento>\n1. Del 29 de julio a las 9:00 al 12 de agosto a las 9:00 (GMT+8), todos los contenidos del evento estarán disponibles para participar.\n2. Del 12 de agosto a las 9:00 al 19 de agosto a las 9:00 (GMT+8), solo estarán disponibles \"Eclosión del Feto Sagrado\" y \"Recompensa de logro\", los demás contenidos habrán finalizado y no se podrán participar.\n\n<Title: Útero Oscuro>\n1. \"Útero Oscuro\" contiene 7 niveles, uno se abrirá automáticamente cada día.\n2. Cada intento de desafío consumirá \"Morfina\" × 120, y al tener éxito en el desafío se obtendrán las monedas del evento \"Embrión ignorante\", \"Embrión sin deseo\" y \"Embrión insaciable\".\n3. Después de completar un nivel, se desbloqueará la función de \"Reproducir\" para ese nivel. Tenga en cuenta: al usar la función de \"Reproducir\", no se obtendrá la tasa de sincronización.\n4. Se puede utilizar la asistencia de la asociación de exalumnos para ayudarle a completar los niveles más fácilmente.\n5. Después de completar un nivel en cualquier dificultad, se desbloqueará la dificultad de locura para ese nivel. Completar la primera vez en la dificultad de locura otorgará una generosa recompensa de monedas del evento.\n6. Tenga en cuenta: el desafío de dificultad de locura no consume Morfina, no se puede reproducir, y después de la primera vez, los intentos repetidos no otorgarán más recompensas de monedas del evento.\n\n<Title: Bonificación de Embrión>\n1. Los Guardianes del Secreto que tengan un Despertado específico o una rueda del destino (no es necesario que estén en el equipo) pueden hacer que las recompensas de la misión del nivel \"Útero Oscuro\" de \"Embrión ignorante\", \"Embrión sin deseo\" y \"Embrión insaciable\" obtengan un aumento de caída adicional (incluyendo la reproducción), las bonificaciones específicas son las siguientes:\n· Despertado \"Murphy\": Despertar 0/1/2/3 y más, bonificación 20%/30%/40%/50%\n· Rueda del destino SSR \"Nacimiento Secreto\": Posición superpuesta 0/1/2/3 y más, bonificación 20%/30%/40%/50%\n· Rueda del destino SR \"Sueño Bajo el Glaciar\": Posición superpuesta 0/1/2/3 y más, bonificación 20%/30%/40%/50%\n2. Las \"bonificaciones de Embrión\" de diferentes Despertados o ruedas del destino se suman de forma acumulativa.\n3. Especialmente, las recompensas del primer desafío en la dificultad de locura no se verán afectadas por las \"bonificaciones de Embrión\".\n\n<Title: Eclosión del Feto Sagrado>\n1. \"Eclosión del Feto Sagrado\" solo estará abierta del 29 de julio a las 9:00 al 19 de agosto a las 9:00 (GMT+8).\n2. Después del 19 de agosto a las 9:00 (GMT+8), los \"Embriones\" restantes no canjeados se recuperarán a razón de 40 \"Rosa Dorada\" por cada uno, por favor, los Guardianes del Secreto revisen su correo."
  },
  Activity_56431_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_56432_ActivityName = {
    Text = "Hasta que la nieve se derrita"
  },
  Activity_56432_ActivityPlot = {
    Text = "La nieve y el hielo de Elworth nunca se deshacen, al igual que su odio. \n Cuando el futuro y el pasado entrelazan sus manos, el guerrero levantará su espada y cargará contra el destino en busca de venganza. \n Cuando ella se enfrente a las olas negras, eres su estandarte"
  },
  Activity_56432_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Boca de la montaña\""
  },
  Activity_56432_ActivityTips = {
    Text = "<Title:Introducción a la actividad>\n1. Durante el evento, los Guardianes del secreto pueden recolectar tres tipos de \"capullos\" a través de los modos limitados \"Ambición de la Bestia\" y \"Recompensas de logros\". Los \"capullos\" se pueden usar en \"Boca gigante de la montaña\" para intercambiar y obtener recompensas, incluidas la rueda SR limitada del evento \"Hasta la fusión de la montaña de nieve\", \"Núcleo Puro\", \"Núcleo de Lumen\", \"Fragmentos de Piedra Sabia\", \"Cristal de Mimesis\", entre otros. \n2. Durante el evento, \"Registro de la fuerza especial: El retorno de Elworth\" estará disponible de forma gratuita. \n\n<Title:Tiempo de la actividad>\n1. Del 7 de octubre a las 9:00 - 21 de octubre a las 9:00 (GMT+8), todos los contenidos del evento son accesibles. \n2. Del 21 de octubre a las 9:00 - 28 de octubre a las 9:00 (GMT+8), solo se mantendrán \"Boca gigante de la montaña\" y \"Recompensas de logros\", el resto de los contenidos habrá finalizado y no se podrá participar. \n\n<Title: Ambición de la Bestia>\n1. \"Ambición de la Bestia\" consta de 5 niveles, uno se abrirá automáticamente cada 2 días. \n2. Cada desafío consumirá \"Morfina\" × 120, y si el desafío es exitoso, se obtendrán monedas del evento \"Brote helado\", \"Brote de flor plateada con escarcha\" y \"Brote de sol\". \n3. Después de completar un nivel, se desbloqueará la función de \"Reproducción\" de ese nivel. Por favor, ten en cuenta: al usar la función de \"Reproducción\", no se podrá obtener tasa de sincronización. \n4. Puedes usar la ayuda de la asociación de exalumnos y \"Resonancia: Devorar montañas\" para facilitar el paso de los niveles. \n5. Al segundo día después de desbloquear un nivel, se desbloqueará la dificultad de locura de ese nivel. Completar la primera vez en dificultad de locura otorgará generosas recompensas en monedas del evento. \n6. Por favor, ten en cuenta: los desafíos de dificultad de locura no consumen Morfina, no se pueden reproducir, y después de completar la primera vez, repetir el desafío no otorgará más recompensas en monedas del evento. \n\n<Title: Bonificación de capullos>\n1. Los Guardianes del secreto que tengan un Despertado o una rueda específicos (no es necesario que estén en el equipo) pueden hacer que las recompensas de las misiones de los niveles de \"Ambición de la Bestia\" obtengan una bonificación adicional en la caída de \"Brote helado\", \"Brote de flor plateada con escarcha\" y \"Brote de sol\" (incluyendo la reproducción), las bonificaciones específicas son las siguientes: \n· Despertado \"Cadena de sangre · Helot\": Despertar 0/1/2/3 y más, bonificación del 20%/30%/40%/50% \n· Rueda SSR \"Sumergirse en Carmesí\": Posición 0/1/2/3 y más, bonificación del 20%/30%/40%/50% \n· Rueda SR \"Hasta la fusión de la montaña de nieve\": Posición 0/1/2/3 y más, bonificación del 20%/30%/40%/50% \n2. Las \"bonificaciones de capullos\" de diferentes Despertados o ruedas se calcularán de forma acumulativa. \n3. De manera especial, las recompensas por completar la primera vez en dificultad de locura no se verán afectadas por las \"bonificaciones de capullos\". \n\n<Title: Resonancia: Devorar montañas>\n1. Los Guardianes del secreto pueden obtener \"Corazón Devorador\" completando logros del evento. \n2. Al consumir \"Corazón Devorador\", se activa \"Resonancia: Devorar montañas\", lo que permite a los Guardianes del secreto volverse más fuertes en el modo de juego del evento \"Ambición de la Bestia\", haciendo los desafíos más fáciles. \n\n<Title: Boca gigante de la montaña>\n1. \"Boca gigante de la montaña\" tiene tres tiendas de intercambio, con los siguientes horarios de apertura: \n· \"Ambición devoradora\": se abre el 7 de octubre a las 9:00. \n· \"Espíritu de venganza\": se abre el 9 de octubre a las 9:00. \n· \"Esperanza de resurrección\": se abre el 11 de octubre a las 9:00. \n2. Cada intercambio consumirá 1000 \"Brote helado\"/\"Brote de flor plateada con escarcha\"/\"Brote de sol\", y se recibirán aleatoriamente cinco recompensas de la tienda de intercambio. \n3. Las recompensas de cada tienda de intercambio se dividen en dos tipos: \"Objetos especiales\" y \"Objetos normales\", y al reiniciar se puede restablecer la cantidad restante de los objetos especiales a su límite, las reglas específicas son: \n(1) Primeras 2 reinicios: cuando no haya cantidad restante de \"Objetos especiales\", el Guardián del secreto puede optar por reiniciar, y al reiniciar se restablecerán las cantidades restantes de \"Objetos especiales\" y \"Objetos normales\" a su límite; también puede optar por continuar intercambiando, cuando no haya cantidad restante de \"Objetos normales\", se debe reiniciar para continuar intercambiando. \n(2) A partir del tercer reinicio: solo se puede reiniciar cuando no haya cantidad restante de \"Objetos normales\", y el reinicio restablecerá la cantidad restante de \"Objetos normales\" a su límite, \"Objetos especiales\" no se reiniciarán. \n4. Después del 28 de octubre a las 9:00 (GMT+8), los \"capullos\" no intercambiados restantes se reciclarán a razón de 40 \"Rosa Dorada\" por cada uno, por favor, los Guardianes del secreto presten atención a revisar su correo. \n\n<Title: Registro de la fuerza especial>\n1. Durante el evento, \"Registro de la fuerza especial: El retorno de Elworth\" estará disponible de forma gratuita. Cada dos días se lanzará un nuevo evento, después de completar \"Registro de la fuerza especial: El retorno de Elworth\" se podrán obtener recompensas como Núcleo de plata, y la rueda SR limitada del evento \"Hasta la fusión de la montaña de nieve\" en las recompensas de logros, las recompensas de logros solo estarán disponibles durante el evento, y después de que finalice el evento no se podrá completar ni reclamar. \n2. Después de que finalice el evento, el progreso de la investigación de \"Registro de la fuerza especial: El retorno de Elworth\" se mantendrá, si durante el evento no se desbloqueó \"Registro de la fuerza especial: El retorno de Elworth\", después de que finalice el evento aún se podrá consumir \"Punto de partida real\" × 7 para desbloquear. \n3. Independientemente de si fue durante el evento o no, después de completar \"Registro de la fuerza especial: El retorno de Elworth\", se podrá obtener \"Posse: La resolución de las montañas\"."
  },
  Activity_56432_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_56433_ActivityName = {
    Text = "Manual del detective"
  },
  Activity_56433_ActivityPlot = {
    Text = "Un manual ordinario.\nRegistra las experiencias de un detective durante años.\nEspero que inspire a los jóvenes aspirantes a detectives"
  },
  Activity_56433_ActivityStageEndContent = {
    Text = "El evento ha terminado. Actualmente, solo \"Club de Buena Suerte\" está disponible."
  },
  Activity_56433_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes del Secreto pueden recolectar la moneda del evento \"Ficha decisiva\" a través de las mecánicas limitadas \"Leyenda de la noche lunar\" y \"Recompensa de logro\". \"Ficha decisiva\" se puede canjear en \"Club de la Suerte\" por recompensas abundantes, incluyendo la rueda del destino SR exclusiva del evento \"Roulette del Destino\", \"Núcleo Puro\", \"Núcleo de Lumen\", \"Fragmentos de Piedra Sabia\", \"Cristal de Mimesis\", entre otros. \n2. Durante el evento, completar las tareas de \"Recompensa de logro\" otorgará el avatar exclusivo del evento \"Por la Llave de Plata: Ryker\", la rueda del destino SR exclusiva del evento \"Roulette del Destino\", núcleos de plata y una gran cantidad de moneda del evento \"Ficha decisiva\".\n3. Durante el evento, \"Registro de la fuerza especial: Buena caza!\" se abrirá de forma gratuita. \n\n<Title: Tiempo del evento>\n1. Del 12 de agosto a las 9:00 al 26 de agosto a las 9:00 (GMT+8), todo el contenido del evento estará disponible para participar. \n2. Del 26 de agosto a las 9:00 al 2 de septiembre a las 9:00 (GMT+8), solo se conservarán \"Club de la Suerte\" y \"Recompensa de logro\", el resto del contenido habrá finalizado y no estará disponible. \n\n<Title: Leyenda de la noche lunar>\n1. \"Leyenda de la noche lunar\" consta de 9 niveles, uno se abrirá automáticamente cada día. \n2. Cada desafío consumirá \"Morfina\" × 120. Al desafiar diferentes niveles, además de obtener diferentes materiales, también se obtendrá la moneda del evento \"Ficha decisiva\". \n3. Los niveles de este evento son niveles de combate directo, ¡se pueden reproducir después de completarlos! Cada vez que se \"reproduce\" se consumirá \"Morfina\" × 120. \n4. Por favor, ten en cuenta: al usar la función de \"reproducción\", no se obtendrá la tasa de sincronización. \n\n<Title: Bonificación de fichas>\n1. Los Guardianes del Secreto que posean ciertos Despertados o Ruedas del destino (no es necesario que estén en el equipo) pueden hacer que la recompensa de \"Ficha decisiva\" en las misiones de los niveles de \"Leyenda de la noche lunar\" obtenga una bonificación adicional (incluida la reproducción), la bonificación específica es la siguiente: \n· Despertado \"Ryker\": Despertar 0/1/2/3 y superior, bonificación 20%/30%/40%/50%\n· Rueda del destino SSR \"Hora de la Fortuna\": Posición superpuesta 0/1/2/3 y superior, bonificación 20%/30%/40%/50%\n· Rueda del destino SR \"Roulette del Destino\": Posición superpuesta 0/1/2/3 y superior, bonificación 20%/30%/40%/50%\n2. La \"bonificación de fichas\" de diferentes Despertados o Ruedas del destino se contabiliza de forma acumulativa. \n3. Especialmente, la recompensa del primer desafío de dificultad locura no se verá afectada por la \"bonificación de fichas\". \n\n<Title: Club de la Suerte>\n1. \"Club de la Suerte\" solo estará abierto del 12 de agosto a las 9:00 al 2 de septiembre a las 9:00 (GMT+8). \n2. Después del 2 de septiembre a las 9:00 (GMT+8), las \"Fichas decisivas\" no canjeadas restantes se recuperarán a una tasa de 40 \"Rosa Dorada\" por cada ficha canjeada, por favor, los Guardianes del Secreto deben estar atentos a su correo. \n\n<Title: Registro de la fuerza especial>\n1. En \"Registro de la fuerza especial: Buena caza!\", los Guardianes del Secreto utilizarán un equipo especial que incluye la historia predefinida \"Ryker\" para enfrentar desafíos. \n2. Completar \"Registro de la fuerza especial: Buena caza!\" otorgará la nueva llave \"Llave: El grito de un arma\"."
  },
  Activity_56433_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_56434_ActivityName = {
    Text = "Puerta de los Mil Fenómenos"
  },
  Activity_56434_ActivityPlot = {
    Text = "Nadie sabe cuánto tiempo ha permanecido en silenciosa guardia ante la Puerta de la Pobreza Extrema.\nNunca tuvo la intención de manifestarse en ningún mundo tangible, ni de ser arrastrada por ninguna corriente espacio–temporal.\nAllí, en la Puerta, permaneció imperturbable—\nHasta el momento en que sus ojos se encontraron con los tuyos."
  },
  Activity_56434_ActivityStageEndContent = {
    Text = "El evento ha Terminado. Actualmente, solo \"Eco\" está disponible."
  },
  Activity_56434_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los guardianes podrán recolectar la moneda de evento \"agujas finales\" a través de las actividades limitadas \"prueba final\" y \"recompensas por logros\". Las \"agujas finales\" podrán canjearse por generosas recompensas en \"eco\", incluyendo la rueda de destino SR exclusiva del evento \"puerta de la verdad\", núcleo inmaculado, núcleo luminoso, astillas de piedra preciosa y cristal de imitación, entre otros.\n2. Durante el evento, al completar las tareas de \"recompensas por logros\" podrás obtener el avatar exclusivo del evento \"en nombre de la llave plateada: Tavy\", la rueda de destino SR exclusiva del evento \"puerta de la verdad\", núcleo plateado y una gran cantidad de moneda de evento \"agujas finales\".\n\n<Title:Duración del evento>\n1. Del 18 de noviembre 9:00 al 2 de diciembre 9:00 (GMT+8), todas las actividades estarán disponibles.\n2. Del 2 de diciembre 9:00 al 9 de diciembre 9:00 (GMT+8), solo permanecerán \"eco\" y \"recompensas por logros\", el resto de contenidos finalizarán y ya no estarán disponibles.\n\n<Title:Prueba final>\n1. \"Prueba final\" contiene 9 etapas, se abre automáticamente 1 por día.\n2. Cada intento consumirá 120 puntos de neuropéptido. Al desafiar diferentes etapas, además de obtener distintas recompensas de materiales, también obtendrás la moneda de evento \"agujas finales\".\n3. Las etapas de este evento son misiones de materiales de combate directo y podrán repetirse tras completarlas. Cada \"repetición\" consumirá 120 puntos de neuropéptido.\n4. Por favor, tenga en cuenta: al usar la función \"repetición\" no se obtendrá tasa de sincronización.\n\n<Title:Bonificación de agujas finales>\n1. Si los guardianes poseen ciertos cuerpos de despertar o ruedas de destino específicas (no es necesario tenerlos activos), obtendrán una bonificación adicional de \"agujas finales\" en las recompensas de las etapas de \"prueba final\" (incluyendo la repetición). Las bonificaciones específicas son las siguientes:\n· Cuerpo de despertar \"Tavy\": con activación 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n· Rueda de destino SSR \"rueda oculta\": con superposición 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n· Rueda de destino SR \"puerta de la verdad\": con superposición 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n2. Las bonificaciones de \"agujas finales\" de diferentes cuerpos de despertar o ruedas de destino se acumulan.\n3. Especialmente, las recompensas por primera vez en dificultad maníaca no se verán afectadas por la bonificación de \"agujas finales\".\n\n<Title:Eco>\n1. \"Eco\" solo estará disponible del 18 de noviembre 9:00 al 9 de diciembre 9:00 (GMT+8).\n2. Después del 9 de diciembre 9:00 (GMT+8), las \"agujas finales\" restantes serán recuperadas a razón de cada una canjeada por \"rosa dorada*40\". Por favor, recuerda revisar tu correo."
  },
  Activity_56434_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_56435_ActivityName = {
    Text = "Sanación múltiple · Réplica"
  },
  Activity_56435_ActivityPlot = {
    Text = "Hysteria, también conocida como histeria.\nEn su época, era sinónimo de muerte.\n\nAfortunadamente, los científicos e investigadores de mitag están igualmente locos: están decididos a resolver este problema"
  },
  Activity_56435_ActivityStageEndContent = {
    Text = "El evento ha terminado. Actualmente, solo \"Análisis de Personalidad\" está disponible."
  },
  Activity_56435_ActivityTips = {
    Text = "<Title:Descripción de la actividad>\n1. Durante el evento, los Guardianes del Secreto pueden recolectar la moneda del evento \"Puzles de Memoria\" a través de las modalidades temporales \"Código de Memoria\", \"Almacenamiento en el borde\" y \"Recompensa de logro\". Los \"Puzles de Memoria\" se pueden usar para comprar artículos en \"Análisis de personalidad\", incluyendo la rueda del destino SR exclusiva del evento \"Determinación del Bacalao Plateado\", Núcleo de Lumen, Núcleo Puro, entre otros.\n2. Durante el evento, el \"Registro de la fuerza especial: Fisión Tranquila\" se desbloqueará de forma gratuita por tiempo limitado, y completar los logros del evento también otorgará el avatar exclusivo del evento \"Por la Llave de Plata:\"24\"\"!\n\n<Title:Tiempo de la actividad>\n1. Del 21 de octubre a las 9:00 hasta el 4 de noviembre a las 9:00 (GMT+8), todas las modalidades del evento estarán disponibles para participar.\n2. Del 4 de noviembre a las 9:00 hasta el 11 de noviembre a las 9:00 (GMT+8), solo se podrá participar en \"Análisis de personalidad\" y en la recompensa de logro.\n\n<Title:Código de Memoria>\n1. \"Código de Memoria\" consta de 5 niveles, uno se desbloqueará automáticamente cada 2 días.\n2. Cada desafío consumirá \"Morfina\" × 120, y al completar el desafío se obtendrá moneda del evento.\n3. Después de completar un nivel, se desbloqueará la función de \"Reproducción\" de ese nivel. Tenga en cuenta: al utilizar la función \"Reproducción\", no se obtendrá tasa de sincronización.\n4. Se pueden usar aliados de la asociación y \"Resonancia: Síndrome de separación\" para ayudarte a superar los niveles más fácilmente.\n\n<Title:Bonificación de racionalidad>\n1. Los Guardianes del Secreto que posean un Despertado o rueda del destino específicos (no se requiere que estén en el campo de batalla) pueden obtener un aumento adicional en la caída de \"Puzles de Memoria\" en las recompensas de las misiones del nivel \"Código de Memoria\". Los aumentos específicos son los siguientes:\n· Despertado \"24\": Despertar 0/1/2/3 y más, bonificación del 20%/30%/40%/50%.\n· Rueda del destino SSR \"Restitución de la forma alterada\": Posicionamiento 0/1/2/3 y más, bonificación del 20%/30%/40%/50%.\n· Rueda del destino SR \"Determinación del Bacalao Plateado\": Posicionamiento 0/1/2/3 y más, bonificación del 20%/30%/40%/50%.\n2. Las \"bonificaciones de racionalidad\" de diferentes Despertados o ruedas del destino se suman. \n3. Especialmente, la recompensa del primer desafío de dificultad locura no se verá afectada por la \"bonificación de racionalidad\".\n\n<Title:Resonancia: Síndrome de separación>\n1. Los Guardianes del Secreto pueden obtener \"Corazón dividido\" al completar logros del evento.\n2. Consumir \"Corazón dividido\" y activar \"Resonancia: Síndrome de separación\" otorgará las siguientes bonificaciones:\n(1) Hará que los Guardianes sean más fuertes en las modalidades del evento \"Código de Memoria\" y \"Registro de la fuerza especial: Fisión Tranquila\", facilitando los desafíos.\n(2) Aumentará las recompensas obtenidas tras completar el desafío \"Código de Memoria\".\n(3) Activará la modalidad del evento \"Almacenamiento en el borde\".\n\n<Title: Almacenamiento en el borde>\n1. Tras activar la resonancia \"Diagnóstico: Fisura de personalidad\", se obtendrán automáticamente 60 \"Puzzle de Memoria α\" cada hora, con un máximo de 25 horas almacenadas.\n2. Tras activar la resonancia \"Conocimiento armonizado\", se obtendrán automáticamente 30 \"Puzzle de Memoria β\" cada hora, con un máximo de 25 horas almacenadas.\n\n<Title:Registro de la fuerza especial>\n1. Durante el evento, el \"Registro de la fuerza especial: Fisión Tranquila\" se podrá desbloquear de forma gratuita.\n2. Después de que finalice el evento, el progreso de investigación del \"Registro de la fuerza especial: Fisión Tranquila\" se mantendrá, y completar eventos de investigación no finalizados durante el evento otorgará recompensas de investigación consistentes con las del evento. Si no se desbloqueó el \"Registro de la fuerza especial: Fisión Tranquila\" durante el evento, aún se podrá consumir \"Punto de partida real\" × 7 para desbloquearlo después de que finalice el evento.\n3. Independientemente de si fue durante el evento o no, al completar el \"Registro de la fuerza especial: Fisión Tranquila\" se obtendrá \"Posse: Toda ella\".\n\n<Title:Compensación de recuperación>\n1. Los Guardianes del Secreto que ya hayan desbloqueado el \"Registro de la fuerza especial: Fisión Tranquila\" recibirán una compensación de \"Puzzle de Memoria α\" × 700 al desbloquearlo nuevamente durante este evento de recuperación.\n2. Los Guardianes del Secreto que ya hayan obtenido el avatar exclusivo del evento \"Por la Llave de Plata:\"24\"\" recibirán automáticamente \"Puzzle de Memoria α\" × 2000 al volver a obtenerlo.\n3. Los Guardianes del Secreto que ya hayan obtenido el material de activación de resonancia \"Corazón dividido\" recibirán automáticamente \"Rosa Dorada\" × 5000 por cada \"Corazón dividido\" adicional que obtengan.\n"
  },
  Activity_56435_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_56436_ActivityName = {
    Text = "Banquete Ardiente: Recurencia"
  },
  Activity_56436_ActivityPlot = {
    Text = "Isaralu, la ciudad en el lago, supuestamente es el lugar de origen de wanda.\nEsta vez cruzarás la puerta del sueño, llegando a un antiguo grupo de torres llenas de campanas"
  },
  Activity_56436_ActivityStageEndContent = {
    Text = "La actividad ha terminado, actualmente solo puedes participar en \"el cofre del tesoro de wanda\""
  },
  Activity_56436_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes del secreto pueden recolectar monedas del evento \"Os Tibia original\", \"Amónito de hojas redondas\", \"Ruinas Espirales\" a través de las actividades limitadas \"Fiesta Ardiente\" y \"Recompensa de logro\". Las monedas del evento se pueden usar para comprar artículos en \"La Caja de Tesoros Extraordinarios de Wanda\", incluyendo la rueda del destino SR exclusiva del evento \"La mirada de Isarau\", Núcleo de Lumen, Núcleo Puro, entre otros. \n2. Durante el evento, \"Inmersión en la conciencia: Fiesta Ardiente\" se desbloquea gratis por tiempo limitado, ¡completar los logros del evento también te permitirá obtener el avatar exclusivo del evento \"Por la Llave de Plata: Wanda\"!\n\n<Title:Tiempo del evento>\n1. 23 de septiembre a las 9:00 - 7 de octubre a las 9:00 (GMT+8), todas las actividades están disponibles para participar. \n2. 7 de octubre a las 9:00 - 14 de octubre a las 9:00 (GMT+8), solo se puede participar en \"La Caja de Tesoros Extraordinarios de Wanda\" y en las recompensas de logro. \n\n<Title:Ciudad en el lago>\n1. \"Ciudad en el lago\" tiene 7 niveles, uno se abrirá automáticamente cada día. \n2. Cada desafío consumirá \"Morfina\" × 120, y al completar el desafío se obtendrán monedas del evento. \n3. Después de completar un nivel, se desbloqueará la función de \"Reproducir\" para ese nivel. Ten en cuenta: al usar la función de \"Reproducir\", no se obtendrá la tasa de sincronización. \n4. Puedes usar el apoyo del club de exalumnos y \"Resonancia: Orden secreta\" para ayudarte a pasar más fácilmente los niveles. \n\n<Title:Bonificación de tesoros>\n1. Los Guardianes del secreto que posean un cuerpo despertado o rueda del destino específica (no es necesario que estén en el equipo) pueden recibir un incremento adicional en la recompensa de monedas del evento en las misiones del nivel \"Ciudad en el lago\", los incrementos son los siguientes: \n· Cuerpo despertado \"Wanda\": Despertar 0/1/2/3 y superior, incremento 20%/30%/40%/50%. \n· Rueda del destino SSR \"Edicto de la Reina\": Posición superpuesta 0/1/2/3 y superior, incremento 20%/30%/40%/50%. \n· Rueda del destino SR \"La mirada de Isarau\": Posición superpuesta 0/1/2/3 y superior, incremento 20%/30%/40%/50%. \n2. Las \"Bonificaciones de tesoros\" de diferentes cuerpos despertados o ruedas del destino se calculan de forma acumulativa. \n3. De manera especial, la recompensa del primer desafío en dificultad locura no se verá afectada por las \"Bonificaciones de tesoros\". \n\n<Title:Resonancia: Orden secreta>\n1. Los Guardianes del secreto pueden obtener \"Corazón del placer\" al completar logros del evento. \n2. Al consumir \"Corazón del placer\", se activa \"Resonancia: Orden secreta\", lo que permite a los Guardianes del secreto volverse más fuertes en \"Ciudad en el lago\", facilitando los desafíos; también permite a los Guardianes del secreto obtener monedas del evento adicionales al completar niveles. \n\n<Title:Inmersión en la conciencia>\n1. Durante el evento, \"Fiesta Ardiente\" se puede desbloquear gratis. \n2. Después de que finalice el evento, el progreso de la investigación de \"Fiesta Ardiente\" se mantendrá, y completar los eventos de investigación que no se completaron durante el evento también permitirá obtener recompensas de investigación consistentes con las del evento. Si no se desbloqueó \"Fiesta Ardiente\" durante el evento, aún se puede desbloquear después de que finalice el evento consumiendo \"Punto de partida real\" × 3. \n3. Independientemente de si fue durante el evento, al completar \"Fiesta Ardiente\" se puede obtener \"Posse: Fiesta de la decadencia\". \n\n<Title:Compensación de recreación>\n1. Los Guardianes del secreto que ya habían desbloqueado \"Inmersión en la conciencia: Fiesta Ardiente\" recibirán una compensación de \"Os Tibia original\" × 300 al desbloquearla nuevamente durante este evento de recreación. \n2. Los Guardianes del secreto que ya habían obtenido el avatar exclusivo del evento \"Por la Llave de Plata: Wanda\", al recibirlo de nuevo, se convertirá automáticamente en \"Os Tibia original\" × 2000. \n3. Los Guardianes del secreto que ya habían obtenido el material de activación de resonancia \"Corazón del placer\", cada \"Corazón del placer\" adicional obtenido se convertirá automáticamente en \"Rosa Dorada\" × 5000. \n"
  },
  Activity_56436_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_56477_ActivityName = {
    Text = "Profanación"
  },
  Activity_56478_ActivityName = {
    Text = "Buena caza!"
  },
  Activity_56479_ActivityName = {
    Text = "Pastor del alma"
  },
  Activity_56480_ActivityName = {
    Text = "Fiesta Ardiente"
  },
  Activity_56481_ActivityName = {
    Text = "Retornante de Elworth"
  },
  Activity_56482_ActivityName = {
    Text = "Fisión Tranquila"
  },
  Activity_59841_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59841_ActivityPlot = {
    Text = "Después de la compra, \"Daffodil\" puede crecer hasta\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59842_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59842_ActivityPlot = {
    Text = "Después de la compra, \"Wanda\" puede crecer a\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59843_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59843_ActivityPlot = {
    Text = [[
Tras la compra, "Tulu" puede crecer hasta
<BlueQuality:Nv50>, <BlueQuality:Todas las habilidades Nv4>]]
  },
  Activity_59844_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59844_ActivityPlot = {
    Text = "Después de la compra, \"Thais\" puede crecer a\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59845_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59845_ActivityPlot = {
    Text = "Después de la compra, \"Miryam\" puede crecer hasta\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59846_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59846_ActivityPlot = {
    Text = [[
Tras la compra, "Hameln" puede crecer hasta
<BlueQuality:Nv50>, <BlueQuality:Todas las habilidades Nv4>]]
  },
  Activity_59847_ActivityName = {
    Text = "Tributo Retrospectivo VIII"
  },
  Activity_59847_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_59848_ActivityName = {
    Text = "Tributo Retrospectivo III"
  },
  Activity_59848_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_59849_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59849_ActivityPlot = {
    Text = "Después de la compra, \"Helot·Catena\" puede crecer hasta\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59850_ActivityName = {
    Text = "Conmemoración del viaje I"
  },
  Activity_59850_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_59851_ActivityName = {
    Text = "Tributo Retrospectivo: Preludio"
  },
  Activity_59851_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_59852_ActivityName = {
    Text = "Tributo Retrospectivo VII"
  },
  Activity_59852_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_59853_ActivityName = {
    Text = "Tributo Retrospectivo VI"
  },
  Activity_59853_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_59854_ActivityName = {
    Text = "Tributo Retrospectivo V"
  },
  Activity_59854_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_59855_ActivityName = {
    Text = "Tributo Retrospectivo IV"
  },
  Activity_59855_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_59856_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59856_ActivityPlot = {
    Text = [[
Tras la compra, "Murphy" puede crecer hasta
<BlueQuality:Nv50>, <BlueQuality:Todas las habilidades Nv4>]]
  },
  Activity_59857_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59857_ActivityPlot = {
    Text = "Después de la compra, \"Ryker\" puede crecer hasta\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59858_ActivityName = {
    Text = "Tributo Retrospectivo II"
  },
  Activity_59858_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_59859_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59859_ActivityPlot = {
    Text = "Después de la compra, \"Sorel\" puede crecer a\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59860_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59860_ActivityPlot = {
    Text = "Después de la compra, \"Horla\" puede crecer hasta\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59861_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59861_ActivityPlot = {
    Text = "Después de la compra, \"Salvador\" puede crecer hasta\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59862_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59862_ActivityPlot = {
    Text = [[
Tras la compra, "Tavi" puede crecer hasta
<BlueQuality:Nv50>, <BlueQuality:Todas las habilidades Nv4>]]
  },
  Activity_59863_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59863_ActivityPlot = {
    Text = "Después de la compra, \"Lily\" puede crecer hasta\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59864_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59864_ActivityPlot = {
    Text = [[
Tras la compra, "24" puede crecer hasta
<BlueQuality:Nv50>, <BlueQuality:Todas las habilidades Nv4>]]
  },
  Activity_59865_ActivityName = {
    Text = "Paquete de Crecimiento de Valor (Descontinuado)"
  },
  Activity_59865_ActivityPlot = {
    Text = "Después de la compra, \"Génesis·Muñeca\" puede crecer hasta\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_61156_ActivityName = {
    Text = "Fin del viaje"
  },
  Activity_61156_ActivityTips = {
    Text = "Reglas del Evento:\n1. Después de completar las tareas designadas del Guardián, se pueden reclamar recompensas en el \"Diario Final\".\n2. El \"Diario Final\" está disponible permanentemente.\n3. Desbloquea el \"Diario Avanzado\" para recibir recompensas adicionales al completar tareas.\n4. Nota: El \"Diario Avanzado\" desbloqueado durante este evento es solo válido por la duración de este evento. Se aconseja a los Guardianes gastar sabiamente."
  },
  Activity_61369_ActivityName = {
    Text = "Ritmo progresivo"
  },
  Activity_61369_ActivityPlot = {
    Text = "¡Los Guardianes pueden elegir una de las siguientes Ruedas del destino limitadas para Despertar gratis!"
  },
  Activity_61369_ActivityTips = {
    Text = "<Title:Descripción>\nEn el misterioso Estanque Negro, donde nubes de intriga se arremolinan, la Rueda del destino gira una y otra vez. Guiadas por la música de Hameln, incontables melodías se armonizan en la Rueda de tu viaje. Que su ayuda te acompañe hasta la nota final de la sinfonía conclusiva.\n\n<Title:Reglas del evento>\nDurante el evento, inicia sesión un día para seleccionar y despertar una de las siguientes 12 Ruedas limitadas, incluyendo: Himno al Dios–Rey, Reliquia Preciada, En Nombre de la Rosa, Transgresión del Sufrimiento, Nacimiento Secreto, Edicto de la Reina, Tablilla Sagrada, Restitución de la forma alterada, El Poder de la Devoción, El Último Verso, Amparo Misericordioso y Hora de la Fortuna."
  },
  Activity_61369_BannerText = {
    Text = "Reclama una Rueda del destino limitada gratis"
  },
  Activity_61370_ActivityName = {
    Text = "Corazón de Plata Pura"
  },
  Activity_61370_ActivityPlot = {
    Text = "¡Inicia sesión diariamente para reclamar la Rueda del destino SSR conmemorativa de edición limitada \"Corazón de Plata Pura\", hasta 16 en total!"
  },
  Activity_61370_ActivityTips = {
    Text = "<Title:Introducción>\nNo importa cómo el mundo pueda volcarse, mientras todos cuiden su corazón original y puro de plata, la historia inevitablemente se ciclo, y nueva vida renacerá en la tierra desolada.\n\n<Title:Reglas del Evento>\n·Durante el evento, los guardianes pueden iniciar sesión diariamente para reclamar la edición limitada SSR Rueda del Destino \"Corazón Puro de Plata\", con un total de 16 reclamaciones.\n·Las recompensas se desbloquearán en orden según los inicios de sesión acumulativos de los guardianes, y las recompensas diarias se actualizarán a las 9 AM (GMT+8)"
  },
  Activity_61370_BannerText = {
    Text = "Rueda del destino SSR limitada gratis"
  },
  Activity_61371_ActivityName = {
    Text = "Oraciones de las alas hexad"
  },
  Activity_61371_ActivityPlot = {
    Text = "En medio de la agitación del Estanque Negro, la Plata de infinitas Dimensiones se dispersó por sus orillas a través de grietas dimensionales. Tawil las recogió cuidadosamente y las colocó en un rincón del Estanque Negro. Aunque esta Plata no puede detener la Propagación de la Disolución, los sentimientos y emociones que guardan en su interior brillarán con esplendor por siempre."
  },
  Activity_61371_ActivityTips = {
    Text = "<Title:Descripción>\nEn medio de la agitación del Estanque Negro, la Plata dispersa a través de grietas dimensionales desde infinitas Dimensiones yace junto al borde del Estanque Negro. Tawil las recoge cuidadosamente y las coloca en un rincón del Estanque Negro. Aunque esta Plata no puede detener la Propagación de la Disolución, los recuerdos y sentimientos que albergan siempre brillarán con esplendor.\n\n<Title:Reglas del evento>\nDurante el evento, los Guardianes pueden iniciar sesión diariamente para recibir 1000 de Plata durante la actividad, con un máximo de 6 reclamaciones.\n¡En el 7.º día acumulado de inicio de sesión, los Guardianes pueden reclamar directamente al Cuerpo Despertado limitado \"Tavi\"!\nLas recompensas se desbloquearán secuencialmente según los inicios de sesión diarios acumulados de los Guardianes, y las recompensas diarias de inicio de sesión se actualizarán a las 9 AM (GMT+8)."
  },
  Activity_61371_BannerText = {
    Text = "Inicia sesión para reclamar toneladas de Plata"
  },
  Activity_61482_ActivityName = {
    Text = "Don conmemorativo de promoción V"
  },
  Activity_61482_ActivityPlot = {
    Text = "El camino se extiende largo, envuelto en la oscuridad de la Disolución.\nLa luz de la Llave de plata nos guiará a todos."
  },
  Activity_61483_ActivityName = {
    Text = "Don conmemorativo de promoción IV"
  },
  Activity_61483_ActivityPlot = {
    Text = "El camino se extiende largo, envuelto en la oscuridad de la Disolución.\nLa luz de la Llave de plata nos guiará a todos."
  },
  Activity_61484_ActivityName = {
    Text = "Don conmemorativo de promoción VII"
  },
  Activity_61484_ActivityPlot = {
    Text = "El camino se extiende largo, envuelto en la oscuridad de la Disolución.\nLa luz de la Llave de plata nos guiará a todos."
  },
  Activity_61485_ActivityName = {
    Text = "Don conmemorativo de promoción VI"
  },
  Activity_61485_ActivityPlot = {
    Text = "El camino se extiende largo, envuelto en la oscuridad de la Disolución.\nLa luz de la Llave de plata nos guiará a todos."
  },
  Activity_61486_ActivityName = {
    Text = "Don conmemorativo de promoción I"
  },
  Activity_61486_ActivityPlot = {
    Text = "El camino se extiende largo, envuelto en la oscuridad de la Disolución.\nLa luz de la Llave de plata nos guiará a todos."
  },
  Activity_61487_ActivityName = {
    Text = "Don conmemorativo de promoción III"
  },
  Activity_61487_ActivityPlot = {
    Text = "El camino se extiende largo, envuelto en la oscuridad de la Disolución.\nLa luz de la Llave de plata nos guiará a todos."
  },
  Activity_61488_ActivityName = {
    Text = "Don conmemorativo de promoción II"
  },
  Activity_61488_ActivityPlot = {
    Text = "El camino se extiende largo, envuelto en la oscuridad de la Disolución.\nLa luz de la Llave de plata nos guiará a todos."
  },
  Activity_61489_ActivityName = {
    Text = "Don conmemorativo de promoción VIII"
  },
  Activity_61489_ActivityPlot = {
    Text = "El camino se extiende largo, envuelto en la oscuridad de la Disolución.\nLa luz de la Llave de plata nos guiará a todos."
  },
  Activity_61517_ActivityName = {
    Text = "Caja de suministros de investigación"
  },
  Activity_61517_ActivityPlot = {
    Text = "Investigación de suministros proporcionados por la Oficina Administrativa de Misaq. Refinados por Alistair a partir de los restos flotantes del Estanque Negro."
  },
  Activity_61546_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61546_ActivityPlot = {
    Text = [[
Al comprar, "Tulu" puede ser activado
<BlueQuality:Mejora de persona +4, desbloquear Sobre-Exaltar>]]
  },
  Activity_61547_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61547_ActivityPlot = {
    Text = "Después de la compra, \"Horla\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61548_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61548_ActivityPlot = {
    Text = "Después de la compra, \"Faros\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61549_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61549_ActivityPlot = {
    Text = "Al comprar, \"Alva\" se puede activar\n<BlueQuality:mejora de Persona +4, desbloquear Sobre-Exaltación>"
  },
  Activity_61550_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61550_ActivityPlot = {
    Text = "Al comprar, \"Jenkin\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61551_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61551_ActivityPlot = {
    Text = "Al comprar, \"Pandia\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61552_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61552_ActivityPlot = {
    Text = "Después de la compra, \"Celeste\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61553_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61553_ActivityPlot = {
    Text = "Al comprar, \"\"24\"\" activa <BlueQuality:Iluminar 3>"
  },
  Activity_61554_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61554_ActivityPlot = {
    Text = "Después de la compra, \"Desmayo\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61555_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61555_ActivityPlot = {
    Text = [[
Al comprar, "Tintura" puede ser activado
<BlueQuality:Mejora de persona +4, desbloquear Sobre-Exaltar>]]
  },
  Activity_61556_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61556_ActivityPlot = {
    Text = "Al comprar, \"Casiah\" activa <BlueQuality:Iluminar 3>"
  },
  Activity_61557_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61557_ActivityPlot = {
    Text = "Después de la compra, \"Salvador\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61558_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61558_ActivityPlot = {
    Text = "Al comprar, \"Salvador\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61559_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61559_ActivityPlot = {
    Text = "Después de la compra, \"Thais\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61560_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61560_ActivityPlot = {
    Text = "Al comprar, \"Lily\" se puede activar\n<BlueQuality:Mejora de Personalidad +4, desbloquear Sobreesaltación>"
  },
  Activity_61561_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61561_ActivityPlot = {
    Text = "Después de la compra, \"Goliat\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61562_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61562_ActivityPlot = {
    Text = "Después de la compra, \"Lily\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61563_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61563_ActivityPlot = {
    Text = "Después de la compra, \"Sanga\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61564_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61564_ActivityPlot = {
    Text = "Después de la compra, \"Narciso\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61565_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61565_ActivityPlot = {
    Text = "Al comprar, \"Nautila\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61566_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61566_ActivityPlot = {
    Text = "Después de la compra, \"Karen\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61567_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61567_ActivityPlot = {
    Text = "Después de la compra, \"Alva\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61568_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61568_ActivityPlot = {
    Text = "Al comprar, \"Leigh\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61569_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61569_ActivityPlot = {
    Text = "Al comprar, \"Tulu\" activa <BlueQuality:Iluminar 3>"
  },
  Activity_61570_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61570_ActivityPlot = {
    Text = "Al comprar, \"Caecus\" activa <BlueQuality:Iluminar 3>"
  },
  Activity_61571_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61571_ActivityPlot = {
    Text = "Al comprar, \"Bígaro\" puede ser activado\n<BlueQuality:Mejora de persona +4, desbloquear Sobre-Exaltar>"
  },
  Activity_61572_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61572_ActivityPlot = {
    Text = [[
Al comprar, "Wanda" puede ser activado
<BlueQuality:Mejora de persona +4, desbloquear Sobre-Exaltar>]]
  },
  Activity_61573_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61573_ActivityPlot = {
    Text = "Al comprar, \"Goliat\" se puede activar\n<BlueQuality:Mejora de Personalidad +4, desbloquear Sobreesaltación>"
  },
  Activity_61574_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61574_ActivityPlot = {
    Text = "Después de la compra, \"Ryker\" puede activar <BlueQuality:Iluminar 3>."
  },
  Activity_61575_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61575_ActivityPlot = {
    Text = "Después de la compra, \"Nymphaea\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61576_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61576_ActivityPlot = {
    Text = "Al comprar, \"Caecus\" se puede activar\n<BlueQuality:mejora de Persona +4, desbloquear Sobre-Exaltación>"
  },
  Activity_61577_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61577_ActivityPlot = {
    Text = "Después de la compra, \"Miria\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61578_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61578_ActivityPlot = {
    Text = "Al comprar, \"Ryker\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61579_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61579_ActivityPlot = {
    Text = "Al comprar, \"Sanga\" se puede activar\n<BlueQuality:Mejora de Personalidad +4, desbloquear Sobreesaltación>"
  },
  Activity_61580_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61580_ActivityPlot = {
    Text = "Después de la compra, \"Tintura\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61581_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61581_ActivityPlot = {
    Text = "Al comprar, \"Leigh\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61582_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61582_ActivityPlot = {
    Text = "Después de la compra, \"Liz\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61583_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61583_ActivityPlot = {
    Text = "Al comprar, \"Helot\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61584_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61584_ActivityPlot = {
    Text = "Al comprar, \"Casiah\" se puede activar\n<BlueQuality:mejora de Persona +4, desbloquear Sobre-Exaltación>"
  },
  Activity_61585_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61585_ActivityPlot = {
    Text = "Al comprar, \"Faros\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61586_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61586_ActivityPlot = {
    Text = "Al comprar, \"Agrippa\" se puede activar\n<BlueQuality:mejora de Persona +4, desbloquear Sobre-Exaltación>"
  },
  Activity_61587_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61587_ActivityPlot = {
    Text = "Después de la compra, \"Nautila\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61588_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61588_ActivityPlot = {
    Text = "Al comprar, \"Narciso\" se puede activar\n<BlueQuality:mejora de Persona +4, desbloquear Sobre-Exaltación>"
  },
  Activity_61589_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61589_ActivityPlot = {
    Text = "Al comprar, \"Hameln\" activa <BlueQuality:Iluminar 3>"
  },
  Activity_61590_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61590_ActivityPlot = {
    Text = "Al comprar, \"Liz\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61591_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61591_ActivityPlot = {
    Text = "Al comprar, \"Miryam\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61592_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61592_ActivityPlot = {
    Text = "Después de la compra, \"Wanda\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61593_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61593_ActivityPlot = {
    Text = "Al comprar, \"Karen\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61594_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61594_ActivityPlot = {
    Text = "Después de la compra, \"Uvhash\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61595_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61595_ActivityPlot = {
    Text = [[
Al comprar, "Thais" puede ser activado
<BlueQuality:Mejora de persona +4, desbloquear Sobre-Exaltar>]]
  },
  Activity_61596_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61596_ActivityPlot = {
    Text = [[
Al comprar, "Uvhash" puede ser activado
<BlueQuality:Mejora de persona +4, desbloquear Sobre-Exaltar>]]
  },
  Activity_61597_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61597_ActivityPlot = {
    Text = "Al comprar, \"Hameln\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61598_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61598_ActivityPlot = {
    Text = "Al comprar, \"Murphy\" activa <BlueQuality:Iluminar 3>"
  },
  Activity_61599_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61599_ActivityPlot = {
    Text = "Después de la compra, \"Sorel\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61600_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61600_ActivityPlot = {
    Text = "Al comprar, \"Sorel\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61601_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61601_ActivityPlot = {
    Text = "Después de la compra, \"Helot\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61602_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61602_ActivityPlot = {
    Text = "Al comprar, \"Horla\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61603_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61603_ActivityPlot = {
    Text = "Al comprar, \"Tawil\" activa <BlueQuality:Iluminar 3>"
  },
  Activity_61604_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61604_ActivityPlot = {
    Text = "Al comprar, \"\"24\"\" se puede activar\n<BlueQuality:mejora de Persona +4, desbloquear Sobre-Exaltación>"
  },
  Activity_61605_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61605_ActivityPlot = {
    Text = "Al comprar, \"Agrippa\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61606_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61606_ActivityPlot = {
    Text = "Después de la compra, \"Pandia\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61607_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61607_ActivityPlot = {
    Text = "Después de la compra, \"Helot·Catena\" puede ser activado\n<BlueQuality:Personalidad Profundizando +4, Unlock Over-Exaltation>"
  },
  Activity_61608_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61608_ActivityPlot = {
    Text = "Después de la compra, \"Jenkin\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61609_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61609_ActivityPlot = {
    Text = "Al comprar, \"Nymphaea\" se puede activar\n<BlueQuality:+4 a la Mejora de Persona, desbloquear Sobreesaltación>"
  },
  Activity_61610_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61610_ActivityPlot = {
    Text = "Después de la compra, \"Bígaro\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61611_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61611_ActivityPlot = {
    Text = "Al comprar, \"Desmayo\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61612_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61612_ActivityPlot = {
    Text = "Al comprar, \"Murphy\" se puede activar\n<BlueQuality:Mejora de Persona +4, desbloquear Sobreesaltación>"
  },
  Activity_61613_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61613_ActivityPlot = {
    Text = [[
Al comprar, "Tawil" puede ser activado
<BlueQuality:Mejora de persona +4, desbloquear Sobre-Exaltar>]]
  },
  Activity_61614_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_61614_ActivityPlot = {
    Text = "Después de la compra, \"Helot·Catena\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_61615_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_61615_ActivityPlot = {
    Text = "Al comprar, \"Celeste\" se puede activar\n<BlueQuality:mejora de Persona +4, desbloquear Sobre-Exaltación>"
  },
  Activity_65387_ActivityName = {
    Text = "Disculpa del gato de la escuela"
  },
  Activity_65387_ActivityPlot = {
    Text = "Debido a recientes vulnerabilidades en las medidas de protección de la escuela, <Del:\"Texto temporal, Punto Rojo\"> los incidentes de Acoso de Fusión en el campus han ido en aumento, causando grandes inconvenientes a los estudiantes. Por ello, la administración escolar ha establecido múltiples puntos de suministro para distribuir materiales como compensación. (Dada la responsabilidad por la negligencia en la gestión de instalaciones, todos los materiales de suministro esta vez serán transportados íntegramente por el Gato de la escuela.)"
  },
  Activity_65387_ActivityTips = {
    Text = "<Title:Descripción>\nRecientemente, debido a fallos en las medidas de protección de la escuela, ha habido un número creciente de <Del>\"texto temporal, punto rojo\"> incidentes de Fusión perturbando el campus, causando grandes inconvenientes a los estudiantes. Por ello, la administración escolar ha establecido múltiples puntos de suministro para distribuir inventario como compensación. (Debido a la responsabilidad por errores en la gestión de instalaciones, la distribución de materiales será gestionada íntegramente por el gato de la escuela.)\n\n<Title:Reglas del evento>\nDurante el evento, los Guardianes pueden iniciar sesión diariamente para reclamar 500 de Plata de \"Disculpa del gato de la escuela\", con un máximo de 5 reclamaciones.\nLas recompensas se desbloquearán secuencialmente según los inicios de sesión diarios acumulados de los Guardianes, y las recompensas diarias de inicio de sesión se actualizarán a las 9 AM (GMT+8)."
  },
  Activity_65387_BannerText = {
    Text = "Inicia sesión para reclamar Plata"
  },
  Activity_65502_ActivityName = {
    Text = "Melodía Progresiva: Dúo"
  },
  Activity_65502_ActivityPlot = {
    Text = "¡Los Guardianes pueden elegir una de las siguientes Ruedas del destino limitadas para Despertar gratis!"
  },
  Activity_65502_ActivityTips = {
    Text = "<Title:Descripción>\nEn el misterioso Estanque Negro, donde nubes de intriga se arremolinan, la Rueda del destino gira una y otra vez. Guiadas por la música de Hameln, incontables melodías se armonizan en la Rueda de tu viaje. Que su ayuda te acompañe hasta la nota final de la sinfonía conclusiva.\n\n<Title:Reglas del evento>\nDurante el evento, inicia sesión un día para seleccionar y despertar una de las siguientes 12 Ruedas limitadas, incluyendo: Himno al Dios–Rey, Reliquia Preciada, En Nombre de la Rosa, Transgresión del Sufrimiento, Nacimiento Secreto, Edicto de la Reina, Tablilla Sagrada, Restitución de la forma alterada, El Poder de la Devoción, El Último Verso, Amparo Misericordioso y Hora de la Fortuna."
  },
  Activity_65502_BannerText = {
    Text = "Reclama una Rueda del destino limitada gratis"
  },
  Activity_65521_ActivityName = {
    Text = "Caja de suministros de investigación"
  },
  Activity_65521_ActivityPlot = {
    Text = "Investigación de suministros proporcionados por la Oficina Administrativa de Misaq. Refinados por Alistair a partir de los restos flotantes del Estanque Negro."
  },
  Activity_65949_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65949_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65950_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65950_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65951_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65951_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65952_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65952_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65953_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65953_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65954_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65954_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65955_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65955_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65956_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65956_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65957_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65957_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65958_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65958_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65959_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65959_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65960_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65960_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65961_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65961_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65962_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65962_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65963_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65963_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65964_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65964_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65965_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65965_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65966_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65966_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65967_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65967_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65968_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65968_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65969_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65969_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65970_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65970_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65971_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65971_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65972_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65972_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65973_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65973_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65974_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65974_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65975_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65975_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65976_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65976_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65977_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65977_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65978_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65978_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65979_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65979_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65980_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65980_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65981_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65981_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65982_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65982_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65983_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65983_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65984_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65984_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65985_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65985_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65986_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65986_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65987_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65987_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65988_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65988_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65989_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65989_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65990_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65990_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65991_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65991_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65992_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65992_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65993_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65993_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65994_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65994_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65995_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65995_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65996_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65996_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65997_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65997_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65998_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65998_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_65999_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_65999_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_66000_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_66000_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_66001_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_66001_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_66002_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_66002_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_66003_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_66003_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_66004_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_66004_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_66005_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_66005_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_66006_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_66006_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_66007_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_66007_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_66008_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_66008_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_66009_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_66009_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_66010_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_66010_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_66011_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_66011_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_66012_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_66012_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_66013_ActivityName = {
    Text = "Regalos de mythag"
  },
  Activity_66013_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardián pueden reclamar recompensas de inicio de sesión diario en \"Regalo de la Academia\" después de iniciar sesión cada día.\n2. Las recompensas se desbloquearán secuencialmente según los días acumulados de inicio de sesión del Guardián. Las recompensas de inicio de sesión diario se actualizarán a las 9:00 (GMT+8)."
  },
  Activity_66375_ActivityName = {
    Text = "Batalla Final: Sombra Primordial"
  },
  Activity_66375_ActivityPlot = {
    Text = "Su mirada recorrió innumerables Dimensiones, y devolviendo la mirada había innumerables siluetas plateadas. \nSon pequeñas, Frágiles. Luchan por recordar, hasta que la muerte las reclama."
  },
  Activity_66375_ActivityStageEndContent = {
    Text = "Evento completado, continúa investigando"
  },
  Activity_66375_ActivityTips = {
    Text = "<Title: Confrontación contra lo Primordial>\n·\"Confrontación contra lo Primordial\" contiene 7 etapas que no se pueden recrear, desafíos directos contra las Visiones Primordiales; las 3 primeras se abren el primer día del evento y una cada 3 días posteriores.\n·Cada vez que superes a una Visión Primordial correspondiente, obtendrás su recompensa.\n·Cada tipo de Visión Primordial tiene muchas copias. Cada vez que cualquier Guardián venza a una de ellas, la \"Cantidad residual mundial\" de ese tipo de Visión Primordial disminuirá en 1. Cuando todas las copias de un tipo de Visión Primordial sean eliminadas, la etapa correspondiente se cerrará y no podrá ser desafiada nuevamente.\n·Todas las etapas están influenciadas por la \"Marea Negra de la Catástrofe Final\", pero cada etapa proporciona una reliquia diferente de \"Núcleo de Plata Pura\", que te brindará poderosos aumentos. Además, cada etapa también ofrece la reliquia \"Ojo de la Omnicencia\", que otorgará a Tavy 120 de locura al inicio de la batalla, aumentando en 50% todo el daño causado por Tavy, escudos y efectos de recuperación de vida.\n·Se debe seleccionar ayuda en todas las etapas. Durante todo el evento, cada Guardián que esté mutuamente interesado solo puede brindarte ayuda una vez. Debido al uso de ayuda, la recompensa real de afinidad aumentará un 50% sobre la base de la recompensa original.\n·El Guardián debe completar al menos la Operación de Investigación 2-9 para participar en este evento.\n\n<Title:Operación de Investigación: Epílogo>\n·Los cuerpos principales de cada tipo de Visión Primordial aún deben ser derrotados por ti mismo en las operaciones de investigación 9-5 a 9-11. Estas etapas especiales no tienen logros, no tienen estrellas, no cuentan con la ayuda de la reliquia \"Ojo de la Omnicencia\", tampoco se puede utilizar ayuda, y además son más difíciles.\n·Las etapas posteriores de \"Operación de Investigación: Epílogo\" se desbloquearán una vez finalizado el evento \"Confrontación contra lo Primordial\". Después de eliminar conjuntamente con otros Guardiánes todas las copias de cada tipo de Visión Primordial, podrás desbloquear anticipadamente las etapas correspondientes en las operaciones de investigación 9-5 a 9-11.\n\n."
  },
  Activity_66375_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_66908_ActivityName = {
    Text = "Aliento de fertilidad"
  },
  Activity_66908_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Aliento Abundante\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan a Thais para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_67077_ActivityName = {
    Text = "Viaje del recuerdo IX"
  },
  Activity_67077_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_67718_ActivityName = {
    Text = "Antes de que Se Reemita la Primavera Marchita"
  },
  Activity_67718_ActivityPlot = {
    Text = "La risa de las chicas resuena en el jardín antes de que el fuego comience.\nPausa por este hermoso pasado, amigo mío.\nEscucha las historias de la primavera no desvanecida, narradas suavemente."
  },
  Activity_67718_ActivityStageEndContent = {
    Text = "El evento ha terminado. Actualmente, solo \"Casa Floral de Colette\" está disponible."
  },
  Activity_67718_ActivityTips = {
    Text = "<Title:Introducción de la actividad>\n1,Durante la actividad, los Guardianes pueden recolectar tres tipos de \"poesía\" a través de los modos de juego por tiempo limitado \"Jardín de recuerdos\", \"Beso de la musa\" y \"Recompensas de Logros\". La \"poesía\" puede intercambiarse en \"La casa de flores de Colette\" para obtener recompensas de objetos, incluyendo la Rueda del destino SR de edición limitada \"Flores y Poemas del Pasado\", \"Núcleo Puro\", \"Núcleo de Lumen\", \"Fragmentos de Piedra Sabia\", \"Cristal de Mimesis\", entre otros.\n2,Durante la actividad, \"Registro de la fuerza especial: Morada de la Rosa\" estará disponible de forma gratuita.\n\n<Title:Período de la actividad>\n1,Del 10 de agosto 9:00 al 7 de septiembre 9:00 (GMT+8), se puede participar en todos los contenidos de la actividad.\n2,Del 7 de septiembre 9:00 al 14 de septiembre 9:00 (GMT+8), solo se conservan \"La casa de flores de Colette\" y las \"Recompensas de Logros\"; el resto del contenido ha Terminado y no se puede participar.\n\n<Title: Jardín de recuerdos>\n1,\"Jardín de recuerdos\" contiene 5 niveles, y se abre automáticamente 1 nivel cada 2 días.\n2,Cada desafío consumirá \"Morfina\" × 120; si el desafío tiene éxito, se obtendrán las monedas de actividad \"poesía melancólica\", \"Poema de Lamento\" y \"Poema alegre\".\n3,Después de pasar un nivel, se desbloquea la función \"Repetir\" de ese nivel. Nota: al usar la función \"Repetir\", no se puede obtener Tasa de sincronización.\n4,Puedes usar la Asistencia en batalla de la asociación de exalumnos y la \"Resonancia: Elegía del jardín\" para ayudarte a pasar los niveles más fácilmente.\n5,Al día siguiente del desbloqueo del nivel, se desbloquea la dificultad Locura de ese nivel. Completar el primer desafío en dificultad Locura otorgará generosas recompensas de monedas de actividad.\n6,Nota: el desafío en dificultad Locura no consume Morfina, no se puede Repetir, y tras el primer éxito, los desafíos repetidos no otorgarán más monedas de actividad.\n\n<Title: Bonificación de poesía>\n1,Si los Guardianes poseen ciertos Cuerpos Despertados o Ruedas del destino (no es necesario que estén en el equipo activo), pueden obtener bonificaciones adicionales de caída en las recompensas de misiones del nivel \"Jardín de recuerdos\" para \"poesía melancólica\", \"Poema de Lamento\" y \"Poema alegre\" (incluyendo Repetir). Las bonificaciones específicas son las siguientes:\n·Cuerpo Despertado \"Horla\": Despertar Espiritual 0/1/2/3 o más, bonificación 20%/30%/40%/50%\n·Rueda del destino SSR \"El Último Verso\": Posición superpuesta 0/1/2/3 o más, bonificación 20%/30%/40%/50%\n·Rueda del destino SR \"Flores y Poemas del Pasado\": Posición superpuesta 0/1/2/3 o más, bonificación 20%/30%/40%/50%\n2,La \"Bonificación de poesía\" de diferentes Cuerpos Despertados o Ruedas del destino se acumula de forma sumada.\n3,En particular, las recompensas del primer desafío superado en dificultad Locura no se verán afectadas por la \"Bonificación de poesía\".\n\n<Title:Resonancia: Elegía del jardín>\n1,Los Guardianes pueden obtener \"Corazón de cenizas\" completando los logros de la actividad.\n2,Consumiendo \"Corazón de cenizas\", se activa la \"Resonancia: Elegía del jardín\", lo que otorga las siguientes bonificaciones:\n(1) Hace que los Guardianes sean más fuertes en el modo de juego \"Jardín de recuerdos\", facilitando los desafíos.\n(2) Aumenta las monedas de actividad obtenidas al completar los desafíos de \"Jardín de recuerdos\".\n(3) Activa el modo de juego \"Beso de la musa\".\n\n<Title: Beso de la musa>\n·Después de activar la Resonancia \"Todo crece\", se obtienen automáticamente \"poesía melancólica\" × 60 por hora, con un máximo de almacenamiento de 25 horas.\n·Después de activar la Resonancia \"Intercambiar poemas por flores\", \"Beso de la musa\" puede obtener adicionalmente \"Poema de Lamento\" × 60 por hora.\n\n<Title: La casa de flores de Colette>\n1,\"La casa de flores de Colette\" tiene tres jardines de flores, con los siguientes horarios de apertura:\n·\"Jardín de iris\": abre el 10 de agosto a las 9:00.\n·\"Jardín de campanillas\": abre el 12 de agosto a las 9:00.\n·\"Jardín de rosas\": abre el 14 de agosto a las 9:00.\n2,Cada intercambio consumirá \"poesía melancólica\"/\"Poema de Lamento\"/\"Poema alegre\" × 750, y se obtendrán aleatoriamente cinco recompensas de objetos del jardín.\n3,Las recompensas de objetos de cada jardín se dividen en \"Objeto especial\" y \"Objeto normal\". Al reiniciar, se puede restablecer la cantidad restante de recompensas de Objeto especial al límite máximo. Las reglas específicas son:\n(1) Primeros 2 reinicios: cuando no queden \"Objeto especial\", los Guardianes pueden elegir reiniciar; tras el reinicio, la cantidad restante de \"Objeto especial\" y \"Objeto normal\" se restablecerá al límite máximo. También pueden elegir continuar intercambiando; cuando tampoco queden \"Objeto normal\", será necesario reiniciar para continuar intercambiando.\n(2) A partir del 3.er reinicio: solo se puede reiniciar cuando no queden \"Objeto normal\"; el reinicio restablecerá la cantidad restante de \"Objeto normal\" al límite máximo, y los \"Objeto especial\" ya no se reiniciarán.\n4,Después del 14 de septiembre a las 9:00 (GMT+8), la \"poesía\" Restante no intercambiada será recuperada a razón de \"Rosa Dorada\" × 40 por cada unidad canjeada. Los Guardianes deben revisar su correo.\n\n<Title: Registro de la fuerza especial>\n1,Durante la actividad, \"Registro de la fuerza especial: Morada de la Rosa\" estará disponible de forma gratuita. Cada 2 días se lanzarán nuevos eventos. Al pasar \"Registro de la fuerza especial: Morada de la Rosa\" se pueden obtener recompensas como Núcleo de plata y la Rueda del destino SR de edición limitada \"Flores y Poemas del Pasado\" en las Recompensas de Logros. Las Recompensas de Logros solo están disponibles durante la actividad y no se podrán completar ni reclamar una vez finalizada.\n2,Después de que termine la actividad, el progreso de investigación de \"Registro de la fuerza especial: Morada de la Rosa\" se conservará. Si no se desbloqueó \"Registro de la fuerza especial: Morada de la Rosa\" durante la actividad, aún se puede desbloquear después de que termine consumiendo \"Punto de partida real\" × 7.\n3,Independientemente de si es durante la actividad o no, al pasar \"Registro de la fuerza especial: Morada de la Rosa\" se puede obtener \"Posse: El verso de la primavera\"."
  },
  Activity_67718_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_67719_ActivityName = {
    Text = "Evento de Confesión: Actividad de Desbloqueo de Descuentos"
  },
  Activity_67721_ActivityName = {
    Text = "Antes de que Se Reemita la Primavera Marchita"
  },
  Activity_67721_ActivityPlot = {
    Text = "La risa de las chicas resuena en el jardín antes de que el fuego comience.\nPausa por este hermoso pasado, amigo mío.\nEscucha las historias de la primavera no desvanecida, narradas suavemente."
  },
  Activity_67721_ActivityStageEndContent = {
    Text = "El evento ha terminado. Actualmente, solo \"Casa Floral de Colette\" está disponible."
  },
  Activity_67721_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes podrán recolectar tres tipos de \"poemas\" a través de las actividades limitadas \"Jardín de recuerdos\", \"Besos de la Musa\" y \"Recompensas por Logros\". Estos \"poemas\" podrán ser intercambiados en \"La Florería de Colette\" para obtener recompensas, incluyendo la Rueda del destino SR exclusiva del evento \"Flores y Poemas del Pasado\", Núcleo Puro, Núcleo de Lumen, Fragmentos de Piedra Sabia, Cristal de Mimesis, y más.\n2. Durante el evento, el \"Registro de la fuerza especial: Morada de la Rosa\" estará disponible gratuitamente.\n\n<Title:Duración del evento>\n1. Del 25 de agosto a las 9:00 al 8 de septiembre a las 9:00 (GMT+8), todas las actividades del evento estarán disponibles.\n2. Del 8 de septiembre a las 9:00 al 15 de septiembre a las 9:00 (GMT+8), solo permanecerán disponibles \"La Florería de Colette\" y \"Recompensas por Logros\". El resto de actividades finalizarán y no podrán ser accedidas.\n\n<Title:Jardín de recuerdos>\n1. \"Jardín de recuerdos\" contiene 5 niveles, los cuales se abrirán automáticamente cada 2 días.\n2. Cada intento consumirá 120 puntos de neuropéptido. Al superar con éxito el nivel obtendrás la moneda del evento \"poesía melancólica\", \"Poema de Lamento\" y \"Poema alegre\".\n3. Al completar un nivel se desbloqueará su función de \"Repetición\". Nota: al utilizar la función de \"Repetición\", no se obtendrá tasa de sincronización.\n4. Puedes utilizar el apoyo de los Alumnis y activar la \"Resonancia: Elegía del jardín\" para ayudarte a pasar los niveles más fácilmente.\n\n<Title:Bonificación de Poemas>\n1. Si los Guardianes poseen ciertos Cuerpos Despertados o Ruedas del destino específicas (no es necesario tenerlos activos), obtendrán bonificaciones adicionales en la caída de \"poesía melancólica\", \"Poema de Lamento\" y \"Poema alegre\" obtenidos en las misiones de \"Jardín de recuerdos\" (incluyendo la repetición). Las bonificaciones específicas son las siguientes:\n Cuerpo Despertado \"Horla\": Despertar Espiritual 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\n Rueda del destino SSR \"El Último Verso\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\n Rueda del destino SR \"Flores y Poemas del Pasado\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\n2. Las bonificaciones de \"Bonificación de Poemas\" de diferentes Cuerpos Despertados o Ruedas del destino se acumulan.\n3. Especialmente, las recompensas por primera vez en dificultad locura no se verán afectadas por la \"Bonificación de Poemas\".\n\n<Title:Resonancia: Elegía del jardín>\n1. Los Guardianes pueden obtener \"Corazón de cenizas\" completando logros del evento.\n2. Al consumir \"Corazón de cenizas\", podrás activar la \"Resonancia: Elegía del jardín\", lo que te otorgará los siguientes beneficios:\n(1) Hará que los Guardianes sean más fuertes durante la actividad \"Jardín de recuerdos\", facilitando el paso de niveles.\n(2) Aumentará la cantidad de moneda del evento obtenida tras completar los desafíos de \"Jardín de recuerdos\".\n(3) Activará la actividad \"Besos de la Musa\".\n\n<Title:Besos de la Musa>\n Tras activar la resonancia \"Crecimiento de Todas las Cosas\", obtendrás automáticamente 60 \"poesía melancólica\" por hora, con un máximo de almacenamiento de 25 horas.\n Tras activar la resonancia \"Intercambiar poemas por flores\", \"Besos de la Musa\" otorgará adicionalmente 60 \"Poema de Lamento\" por hora.\n\n<Title:La Florería de Colette>\n1. \"La Florería de Colette\" cuenta con tres jardines, los cuales se activarán según el siguiente cronograma:\n \"Jardín de los Lirios\": se activará el 25 de agosto a las 9:00.\n \"Jardín de las Campanillas\": se activará el 27 de agosto a las 9:00.\n \"Rosaleda\": se activará el 29 de agosto a las 9:00.\n2. Cada intercambio consumirá 750 \"poesía melancólica\"/\"Poema de Lamento\"/\"Poema alegre\", otorgando aleatoriamente uno de cinco objetos del jardín.\n3. Las recompensas de cada jardín se dividen en \"Objeto especial\" y \"Objeto normal\". Al reiniciar, se restaurará la cantidad restante de \"Objeto especial\" hasta el límite máximo. Las reglas específicas son las siguientes:\n(1) Primeras 2 veces de reinicio: cuando ya no quede \"Objeto especial\", los Guardianes podrán elegir reiniciar, lo que restaurará la cantidad restante de \"Objeto especial\" y \"Objeto normal\" hasta el límite máximo; también pueden continuar intercambiando, y cuando ya no quede \"Objeto normal\", deberán reiniciar para continuar intercambiando.\n(2) A partir de la tercera vez de reinicio: solo podrá reiniciarse cuando ya no quede \"Objeto normal\", el reinicio restaurará la cantidad restante de \"Objeto normal\" hasta el límite máximo, pero ya no restaurará los \"Objeto especial\".\n4. Tras las 9:00 del 15 de septiembre (GMT+8), los \"poemas\" restantes que no hayan sido intercambiados serán convertidos automáticamente a razón de \"Rosa Dorada*40\". Por favor preste atención a revisar su correo.\n\n<Title:Registro de la fuerza especial>\n1. Durante el evento, el \"Registro de la fuerza especial: Morada de la Rosa\" estará disponible gratuitamente. Se añadirán nuevos eventos cada 2 días. Al completar el \"Registro de la fuerza especial: Morada de la Rosa\" podrás obtener Núcleo de plata y la Rueda del destino SR exclusiva del evento \"Flores y Poemas del Pasado\" entre otras recompensas en las recompensas por logros. Las recompensas por logros estarán disponibles únicamente durante el evento, y no podrán completarse ni reclamarse tras su finalización.\n2. Tras finalizar el evento, se mantendrá el progreso en \"Registro de la fuerza especial: Morada de la Rosa\". Si no lo desbloqueaste durante el evento, aún podrás desbloquearlo tras su finalización consumiendo 7 \"Punto de partida real\".\n3. Independientemente de si estás durante el evento o no, tras completar \"Registro de la fuerza especial: Morada de la Rosa\" siempre obtendrás \"Posse: Ofrenda a los dioses de Primavera\"."
  },
  Activity_67721_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_67723_ActivityName = {
    Text = "Evento de Confesión: Actividad de Desbloqueo de Descuentos"
  },
  Activity_67725_ActivityName = {
    Text = "Evento doble de afinidad"
  },
  Activity_67726_ActivityName = {
    Text = "Pastor de Almas: Réplica"
  },
  Activity_67726_ActivityPlot = {
    Text = "Él sufrió por ustedes, cargó con sus calamidades.\nPor su carne y sangre, fueron sanados;\npor su vida, fueron perdonados"
  },
  Activity_67726_ActivityStageEndContent = {
    Text = "La actividad ha terminado, actualmente solo puedes participar en \"venta benéfica de la iglesia\""
  },
  Activity_67726_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los guardianes podrán recolectar la moneda de evento \"Cupones de venta\" a través de las actividades limitadas \"Camino del Santuario\", \"La bondad de los ciudadanos\" y \"Recompensas por logros\". Los \"Cupones de venta\" podrán intercambiarse por artículos aleatorios en el \"Mercado de venta del Santuario\", incluyendo la rueda de destino SR exclusiva del evento \"Persona en el espejo\", Núcleo inmaculado, Núcleo luminoso, etc.\n2. Durante el evento, el \"Registro especial: El color de la sangre\" estará disponible de forma gratuita. ¡Al completar los logros del evento también podrás obtener el avatar exclusivo del evento \"Con la llave de plata: Salvador\"!\n\n<Title:Duración del evento>\n1. Del 24 de marzo 09:00 al 7 de abril 09:00 (GMT+8), todas las actividades estarán disponibles.\n2. Del 7 de abril 09:00 al 14 de abril 09:00 (GMT+8), solo permanecerán disponibles el \"Mercado de venta del Santuario\" y las \"Recompensas por logros\", las demás actividades finalizarán y no podrán participarse.\n\n<Title:Camino del Santuario>\n1. \"Camino del Santuario\" contiene 5 etapas, se abrirá 1 etapa cada 2 días.\n2. Cada intento consumirá 120 puntos de neuropéptido, al superar con éxito obtendrás la moneda de evento \"Cupones de venta\".\n3. Al superar una etapa, se desbloqueará la función \"Repetición\" de dicha etapa. Ten en cuenta: al usar la función \"Repetición\", no obtendrás porcentaje de sincronización.\n4. Puedes usar el apoyo de Alumnis y la \"Resonancia: Cruce de Estrellas\" para ayudarte a pasar las etapas más fácilmente.\n\n<Title:Resplandor de aumento>\n1. Bajo la influencia del \"Resplandor del alma\", si el guardián posee ciertos Despertados o Ruedas de destino específicas (no es necesario tenerlos en combate), podrá obtener un aumento adicional en la obtención de \"Cupones de venta\" en las recompensas de las misiones de las etapas de \"Camino del Santuario\" (incluyendo repetición), los aumentos específicos son los siguientes:\n· Despertado \"Salvador\": con 0/1/2/3 o más Despertar Espiritual, aumento del 20%/30%/40%/50%.\n· Rueda de destino SSR \"Tabla de palabras divinas\": con 0/1/2/3 o más duplicados, aumento del 20%/30%/40%/50%.\n· Rueda de destino SR \"Persona en el espejo\": con 0/1/2/3 o más duplicados, aumento del 20%/30%/40%/50%.\n2. Los aumentos por \"Resplandor\" de diferentes Despertados o Ruedas de destino se acumulan.\n3. Especialmente, las recompensas por primera vez en dificultad Locura no se verán afectadas por el \"Resplandor de aumento\".\n\n<Title:Resonancia: Cruce de Estrellas>\n1. Los guardianes podrán obtener \"Corazón de penitencia\" al completar logros del evento.\n2. Al consumir \"Corazón de penitencia\", podrás activar la \"Resonancia: Cruce de Estrellas\", obteniendo los siguientes beneficios:\n(1) Hace que el guardián sea más fuerte en las actividades del evento \"Camino del Santuario\" y \"Registro especial: El color de la sangre\", facilitando los desafíos.\n(2) Aumenta el porcentaje de sincronización obtenido al completar los desafíos de \"Camino del Santuario\".\n(3) Activa la actividad del evento \"La bondad de los ciudadanos\".\n\n<Title:La bondad de los ciudadanos>\n1. Tras activar la resonancia \"forma fácil\", obtendrás automáticamente 60 \"Cupones de venta\" por hora, con un máximo de almacenamiento de 25 horas.\n2. Tras activar la resonancia \"Expiación, expiación\", obtendrás automáticamente 1800 \"Rosas doradas\" por hora adicionales.\n\n<Title:Mercado de venta del Santuario>\n1. \"Mercado de venta del Santuario\" tiene tres tiendas, con los siguientes horarios de apertura:\n· \"La tienda de la Sra. Grey\": se abre el 24 de marzo a las 09:00.\n· \"Venta especial del Gran John\": se abre el 27 de marzo a las 09:00.\n· \"Venta especial de Smith\": se abre el 30 de marzo a las 09:00.\n2. Cada intercambio consumirá 750 \"Cupones de venta\", recibiendo aleatoriamente cinco artículos de recompensa de la tienda.\n3. Las recompensas de cada tienda se dividen en dos tipos: \"Objetos especiales\" y \"Objetos comunes\". Al reiniciar, se puede restablecer la cantidad restante de \"Objetos especiales\" hasta el límite máximo. Las reglas específicas son las siguientes:\n(1) Primeras 2 veces de reinicio: cuando ya no quede \"Objetos especiales\", el guardián podrá elegir reiniciar, lo que restablecerá la cantidad restante de \"Objetos especiales\" y \"Objetos comunes\" hasta el límite máximo; también puede elegir continuar intercambiando, y cuando ya no quede \"Objetos comunes\", deberá reiniciar para continuar intercambiando.\n(2) A partir de la tercera vez de reinicio: solo podrá reiniciar cuando ya no quede \"Objetos comunes\", el reinicio restablecerá la cantidad restante de \"Objetos comunes\" hasta el límite máximo, pero ya no se reiniciarán los \"Objetos especiales\".\n4. Después de las 09:00 del 14 de abril (GMT+8), los \"Cupones de venta\" restantes que no se hayan intercambiado se convertirán en \"Rosas doradas*40\" por cada uno, según la proporción establecida. Por favor, presta atención a revisar tu correo.\n\n<Title:Registro especial>\n1. Durante el evento, el \"Registro especial: El color de la sangre\" estará disponible de forma gratuita.\n2. Al finalizar el evento, se conservará el progreso del \"Registro especial: El color de la sangre\". Si no desbloqueaste el \"Registro especial: El color de la sangre\" durante el evento, aún podrás desbloquearlo después del evento consumiendo 7 \"Punto de partida real\".\n3. Independientemente de si es durante el evento o no, al superar el \"Registro especial: El color de la sangre\" siempre obtendrás \"Sello de llave: El amanecer del milagro\".\n\n<Title:Compensación por reedición>\n1. Los guardianes que ya hayan desbloqueado anteriormente el \"Registro especial: El color de la sangre\", al desbloquearlo nuevamente durante esta reedición del evento, recibirán una compensación de 700 \"Cupones de venta\".\n2. Los guardianes que ya hayan obtenido anteriormente el avatar exclusivo del evento \"Con la llave de plata: Salvador\", al obtenerlo nuevamente se convertirá automáticamente en 1 \"Invitación del Ser Inmaterial\".\n3. Los guardianes que ya hayan obtenido anteriormente el material de activación de resonancia \"Corazón de penitencia\", por cada \"Corazón de penitencia\" adicional que obtengan se convertirá automáticamente en 5000 \"Rosas doradas\".\n"
  },
  Activity_67726_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_67727_ActivityName = {
    Text = "Ola de Deseo·Reedición"
  },
  Activity_67727_ActivityPlot = {
    Text = "Los sueños son la revelación de deseos sumergidos. Quienes se demoran en ellos serán atrapados por las mareas del anhelo, convirtiéndose en apóstoles de la lujuria—a menos que..."
  },
  Activity_67727_ActivityStageEndContent = {
    Text = "El evento ha Terminado. Actualmente, solo \"Proliferación del Deseo\" está disponible."
  },
  Activity_67727_ActivityTips = {
    Text = "<Title:Descripción de la actividad>\n1. Durante el evento, los guardianes podrán recolectar la moneda de actividad \"semilla madre\" a través de las mecánicas temporales \"deseo caótico\" y las recompensas por logros. Con \"semilla madre\" podrás canjear recompensas en \"brote de deseo\", incluyendo la rueda de destino SR exclusiva del evento \"beso ardiente\", núcleo de luz, núcleo puro, astillas de sabiduría y cristal de imitación, entre otros.\n2. Durante la actividad, se han reducido los requisitos para participar en \"fervor reproductivo\": ahora solo necesitas haber completado la misión de investigación 2-9 en modo normal, y no será necesario cumplir con el requisito de tasa de sincronización del cuerpo de vigilia para desbloquear el evento \"fervor reproductivo\". Además, ¡la cantidad requerida de \"punto de partida real\" ahora solo será de 1!\n3. ¡El arribo de una fuerza misteriosa parece ayudarte a establecer una relación más profunda con los cuerpos de vigilia! Durante el evento, ¡la tasa de sincronización obtenida por cualquier medio se duplicará!\n\n<Title:Deseo caótico>\n1. \"Deseo caótico\" incluye 10 etapas de materiales que no requieren exploración, directamente batallas, y cada día se abre una nueva.\n2. En estas etapas de materiales, despertarás a todos los cuerpos de vigilia y obtendrás criaturas preestablecidas. Además, tras el sexto turno recibirás una vez la ayuda de Teyis.\n3. Cada desafío consumirá 120 puntos de neuropéptido, y al vencerlo obtendrás materiales de entrenamiento y moneda de actividad.\n4. Una vez completada la etapa, se desbloqueará su función de \"reproducción\". Ten en cuenta que al usar la función \"reproducción\" no se obtendrá tasa de sincronización.\n5. Puedes usar el apoyo de la asociación de exalumnos para ayudarte a pasar la etapa más fácilmente.\n\n<Title:Bonificación de deseo>\n1. Si el guardián posee ciertos cuerpos de vigilia o ruedas de destino (no es necesario tenerlos activos), obtendrá una bonificación adicional de \"semilla madre\" en las recompensas de las misiones de \"deseo caótico\" (incluyendo reproducción). Las bonificaciones específicas son las siguientes:\n·Cuerpo de vigilia \"Teyis\": Despertar 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n·Rueda de destino SSR \"amamantamiento compasivo\": Superposición 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n·Rueda de destino SR \"beso ardiente\": Superposición 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n2. Las bonificaciones \"Bonificación de deseo\" de diferentes cuerpos de vigilia o ruedas de destino se acumulan.\n3. Especialmente, las recompensas por primera vez al vencer la dificultad maníaca no se verán afectadas por las bonificaciones anteriores.\n\n<Title:Brote de deseo>\n1. Cada \"intercambio de semilla\" consumirá 1000 \"semilla madre\" y otorgará aleatoriamente cinco objetos de recompensa de entre los disponibles en \"brote de deseo\".\n3. Las recompensas de \"brote de deseo\" se dividen en \"objetos especiales\" y \"objetos comunes\". Al reiniciar, puedes restablecer la cantidad restante de recompensas \"objetos especiales\" al límite máximo. Las reglas específicas son las siguientes:\n(1) Primeros 4 reinicios: cuando ya no haya \"objetos especiales\" disponibles, el guardián podrá elegir reiniciar, lo que restablecerá la cantidad restante de \"objetos especiales\" y \"objetos comunes\" al límite máximo; también puede optar por continuar intercambiando, y cuando ya no haya \"objetos comunes\" disponibles, deberá reiniciar para continuar.\n(2) A partir del quinto reinicio: solo será posible reiniciar cuando ya no haya \"objetos comunes\" disponibles. Al reiniciar, se restablecerá la cantidad restante de \"objetos comunes\" al límite máximo, pero ya no se restablecerán los \"objetos especiales\".\n\n<Title:Duración del evento>\n1. Del 16 de diciembre a las 9:00 hasta el 30 de diciembre a las 9:00 (GMT+8), todas las funciones mencionadas en la descripción estarán disponibles.\n2. Del 30 de diciembre a las 9:00 hasta el 6 de enero a las 9:00 (GMT+8), solo permanecerán disponibles \"brote de deseo\" y \"recompensas por logros\", el resto de funciones finalizarán y no estarán disponibles.\n3. Tras el 6 de enero a las 9:00 (GMT+8), los \"semilla madre\" restantes que no hayan sido canjeados se reciclarán a razón de 1 \"semilla madre\" por cada \"rosa dorada *40\". Por favor, ten en cuenta revisar tu correo para recibir las recompensas."
  },
  Activity_67727_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_67728_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_67729_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_67731_ActivityName = {
    Text = "Banquete Ardiente: Recurencia"
  },
  Activity_67731_ActivityPlot = {
    Text = "Isaralu, la ciudad en el lago, supuestamente es el lugar de origen de wanda.\nEsta vez cruzarás la puerta del sueño, llegando a un antiguo grupo de torres llenas de campanas"
  },
  Activity_67731_ActivityStageEndContent = {
    Text = "La actividad ha terminado, actualmente solo puedes participar en \"el cofre del tesoro de wanda\""
  },
  Activity_67731_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes del secreto pueden recolectar monedas del evento \"Os Tibia original\", \"Amónito de hojas redondas\", \"Ruinas Espirales\" a través de las actividades limitadas \"Fiesta Ardiente\" y \"Recompensa de logro\". Las monedas del evento se pueden usar para comprar artículos en \"La Caja de Tesoros Extraordinarios de Wanda\", incluyendo la rueda del destino SR exclusiva del evento \"La mirada de Isarau\", Núcleo de Lumen, Núcleo Puro, entre otros. \n2. Durante el evento, \"Inmersión en la conciencia: Fiesta Ardiente\" se desbloquea gratis por tiempo limitado, ¡completar los logros del evento también te permitirá obtener el avatar exclusivo del evento \"Por la Llave de Plata: Wanda\"!\n\n<Title:Tiempo del evento>\n1. 23 de septiembre a las 9:00 - 7 de octubre a las 9:00 (GMT+8), todas las actividades están disponibles para participar. \n2. 7 de octubre a las 9:00 - 14 de octubre a las 9:00 (GMT+8), solo se puede participar en \"La Caja de Tesoros Extraordinarios de Wanda\" y en las recompensas de logro. \n\n<Title:Ciudad en el lago>\n1. \"Ciudad en el lago\" tiene 7 niveles, uno se abrirá automáticamente cada día. \n2. Cada desafío consumirá \"Morfina\" × 120, y al completar el desafío se obtendrán monedas del evento. \n3. Después de completar un nivel, se desbloqueará la función de \"Reproducir\" para ese nivel. Ten en cuenta: al usar la función de \"Reproducir\", no se obtendrá la tasa de sincronización. \n4. Puedes usar el apoyo del club de exalumnos y \"Resonancia: Orden secreta\" para ayudarte a pasar más fácilmente los niveles. \n\n<Title:Bonificación de tesoros>\n1. Los Guardianes del secreto que posean un cuerpo despertado o rueda del destino específica (no es necesario que estén en el equipo) pueden recibir un incremento adicional en la recompensa de monedas del evento en las misiones del nivel \"Ciudad en el lago\", los incrementos son los siguientes: \n· Cuerpo despertado \"Wanda\": Despertar 0/1/2/3 y superior, incremento 20%/30%/40%/50%. \n· Rueda del destino SSR \"Edicto de la Reina\": Posición superpuesta 0/1/2/3 y superior, incremento 20%/30%/40%/50%. \n· Rueda del destino SR \"La mirada de Isarau\": Posición superpuesta 0/1/2/3 y superior, incremento 20%/30%/40%/50%. \n2. Las \"Bonificaciones de tesoros\" de diferentes cuerpos despertados o ruedas del destino se calculan de forma acumulativa. \n3. De manera especial, la recompensa del primer desafío en dificultad locura no se verá afectada por las \"Bonificaciones de tesoros\". \n\n<Title:Resonancia: Orden secreta>\n1. Los Guardianes del secreto pueden obtener \"Corazón del placer\" al completar logros del evento. \n2. Al consumir \"Corazón del placer\", se activa \"Resonancia: Orden secreta\", lo que permite a los Guardianes del secreto volverse más fuertes en \"Ciudad en el lago\", facilitando los desafíos; también permite a los Guardianes del secreto obtener monedas del evento adicionales al completar niveles. \n\n<Title:Inmersión en la conciencia>\n1. Durante el evento, \"Fiesta Ardiente\" se puede desbloquear gratis. \n2. Después de que finalice el evento, el progreso de la investigación de \"Fiesta Ardiente\" se mantendrá, y completar los eventos de investigación que no se completaron durante el evento también permitirá obtener recompensas de investigación consistentes con las del evento. Si no se desbloqueó \"Fiesta Ardiente\" durante el evento, aún se puede desbloquear después de que finalice el evento consumiendo \"Punto de partida real\" × 3. \n3. Independientemente de si fue durante el evento, al completar \"Fiesta Ardiente\" se puede obtener \"Posse: Fiesta de la decadencia\". \n\n<Title:Compensación de recreación>\n1. Los Guardianes del secreto que ya habían desbloqueado \"Inmersión en la conciencia: Fiesta Ardiente\" recibirán una compensación de \"Os Tibia original\" × 300 al desbloquearla nuevamente durante este evento de recreación. \n2. Los Guardianes del secreto que ya habían obtenido el avatar exclusivo del evento \"Por la Llave de Plata: Wanda\", al recibirlo de nuevo, se convertirá automáticamente en \"Os Tibia original\" × 2000. \n3. Los Guardianes del secreto que ya habían obtenido el material de activación de resonancia \"Corazón del placer\", cada \"Corazón del placer\" adicional obtenido se convertirá automáticamente en \"Rosa Dorada\" × 5000. \n"
  },
  Activity_67731_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_67732_ActivityName = {
    Text = "Manual del gran detective·Replica"
  },
  Activity_67732_ActivityPlot = {
    Text = "Un manual ordinario.\nRegistra las experiencias de un detective durante años.\nEspero que inspire a los jóvenes aspirantes a detectives"
  },
  Activity_67732_ActivityStageEndContent = {
    Text = "El evento ha terminado. Actualmente, solo \"Club de Buena Suerte\" está disponible."
  },
  Activity_67732_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes del Secreto pueden recolectar la moneda del evento \"Ficha decisiva\" a través de las mecánicas limitadas \"Leyenda de la noche lunar\" y \"Recompensa de logro\". \"Ficha decisiva\" se puede canjear en \"Club de la Suerte\" por recompensas abundantes, incluyendo la rueda del destino SR exclusiva del evento \"Roulette del Destino\", \"Núcleo Puro\", \"Núcleo de Lumen\", \"Fragmentos de Piedra Sabia\", \"Cristal de Mimesis\", entre otros. \n2. Durante el evento, completar las tareas de \"Recompensa de logro\" otorgará el avatar exclusivo del evento \"Por la Llave de Plata: Ryker\", la rueda del destino SR exclusiva del evento \"Roulette del Destino\", núcleos de plata y una gran cantidad de moneda del evento \"Ficha decisiva\".\n3. Durante el evento, \"Registro de la fuerza especial: Buena caza!\" se abrirá de forma gratuita. \n\n<Title: Tiempo del evento>\n1. Del 12 de agosto a las 9:00 al 26 de agosto a las 9:00 (GMT+8), todo el contenido del evento estará disponible para participar. \n2. Del 26 de agosto a las 9:00 al 2 de septiembre a las 9:00 (GMT+8), solo se conservarán \"Club de la Suerte\" y \"Recompensa de logro\", el resto del contenido habrá finalizado y no estará disponible. \n\n<Title: Leyenda de la noche lunar>\n1. \"Leyenda de la noche lunar\" consta de 9 niveles, uno se abrirá automáticamente cada día. \n2. Cada desafío consumirá \"Morfina\" × 120. Al desafiar diferentes niveles, además de obtener diferentes materiales, también se obtendrá la moneda del evento \"Ficha decisiva\". \n3. Los niveles de este evento son niveles de combate directo, ¡se pueden reproducir después de completarlos! Cada vez que se \"reproduce\" se consumirá \"Morfina\" × 120. \n4. Por favor, ten en cuenta: al usar la función de \"reproducción\", no se obtendrá la tasa de sincronización. \n\n<Title: Bonificación de fichas>\n1. Los Guardianes del Secreto que posean ciertos Despertados o Ruedas del destino (no es necesario que estén en el equipo) pueden hacer que la recompensa de \"Ficha decisiva\" en las misiones de los niveles de \"Leyenda de la noche lunar\" obtenga una bonificación adicional (incluida la reproducción), la bonificación específica es la siguiente: \n· Despertado \"Ryker\": Despertar 0/1/2/3 y superior, bonificación 20%/30%/40%/50%\n· Rueda del destino SSR \"Hora de la Fortuna\": Posición superpuesta 0/1/2/3 y superior, bonificación 20%/30%/40%/50%\n· Rueda del destino SR \"Roulette del Destino\": Posición superpuesta 0/1/2/3 y superior, bonificación 20%/30%/40%/50%\n2. La \"bonificación de fichas\" de diferentes Despertados o Ruedas del destino se contabiliza de forma acumulativa. \n3. Especialmente, la recompensa del primer desafío de dificultad locura no se verá afectada por la \"bonificación de fichas\". \n\n<Title: Club de la Suerte>\n1. \"Club de la Suerte\" solo estará abierto del 12 de agosto a las 9:00 al 2 de septiembre a las 9:00 (GMT+8). \n2. Después del 2 de septiembre a las 9:00 (GMT+8), las \"Fichas decisivas\" no canjeadas restantes se recuperarán a una tasa de 40 \"Rosa Dorada\" por cada ficha canjeada, por favor, los Guardianes del Secreto deben estar atentos a su correo. \n\n<Title: Registro de la fuerza especial>\n1. En \"Registro de la fuerza especial: Buena caza!\", los Guardianes del Secreto utilizarán un equipo especial que incluye la historia predefinida \"Ryker\" para enfrentar desafíos. \n2. Completar \"Registro de la fuerza especial: Buena caza!\" otorgará la nueva llave \"Llave: El grito de un arma\"."
  },
  Activity_67732_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_67733_ActivityName = {
    Text = "Sacrificio del Abismo: Repetir"
  },
  Activity_67733_ActivityPlot = {
    Text = "En el reflejo del océano, el sueño del rey se desvanece y el reino de los dioses se corrompe.\nElla viene del sueño antiguo, hacia las ruinas del futuro.\nPregunta al abismo, pero el abismo guarda silencio.\nElla ofrece sacrificios al abismo, y solo se responde a sí misma"
  },
  Activity_67733_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Respuesta del abismo\""
  },
  Activity_67733_ActivityTips = {
    Text = "<Title:Descripción de la actividad>\n1. Durante el evento, los Guardián podrán recolectar monedas de actividad a través de las mecánicas limitadas \"Nacimiento del Reino Divino\", \"Santuario del Rey Dios\" y \"Recompensas por logros\". Las monedas de actividad podrán usarse en \"Respuesta del Abismo\" para hacer ofrendas y obtener recompensas, incluyendo la Rueda del destino SR exclusiva del evento \"El Llamado del Aequor\", Piedra filosofal, Núcleo Puro, Núcleo de Lumen y más.\n2. Durante el evento, se abrirá gratuitamente \"Mundo de Sueños Extraños: Profanación\", ¡y al completar los logros del evento también podrás obtener el avatar exclusivo \"Llave de plata: Miryam\"!\n\n<Title:Duración del evento>\n1. Del 28 de julio 9:00 al 18 de Agosto 9:00 (GMT+8), todas las actividades estarán disponibles.\n2. Del 18 de Agosto 9:00 al 25 de Agosto 9:00 (GMT+8), solo se mantendrá \"Respuesta del Abismo\" y \"Recompensas por logros\". El resto de contenido habrá finalizado y no estará disponible.\n\n<Title:Nacimiento del Reino Divino>\n1. \"Nacimiento del Reino Divino\" contiene 5 etapas, cada 2 días se desbloqueará una nueva.\n2. Cada intento consumirá 120 puntos de neuropéptido, al superar el desafío obtendrás monedas de actividad.\n3. Al completar una etapa se desbloqueará su función de \"Repetición\". Nota: al usar la función \"Repetición\" no se obtendrá tasa de sincronización.\n4. Puedes usar aliados de la hermandad y \"Resonancia: Festival de las Mareas\" para facilitar la finalización.\n\n<Title:Bonificación de ofrendas>\n1. Si los Guardián poseen ciertos Cuerpo Despertado o Rueda del destino específicas (no es necesario tenerlos activos), obtendrán bonificaciones adicionales en la caída de \"Lágrimas del Sacrificador\", \"Sangre del Sacrificio\" y \"Médula Sacrificial\" en las recompensas de las misiones de \"Nacimiento del Reino Divino\" (incluyendo Repetición). Las bonificaciones específicas son las siguientes:\nCuerpo Despertado \"Miryam\": Despertar Espiritual en nivel 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\nRueda del destino SSR \"El Poder de la Devoción\": Posición superpuesta en nivel 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\nRueda del destino SR \"El Llamado del Aequor\": Posición superpuesta en nivel 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n2. Las bonificaciones de \"Bonificación de ofrendas\" de diferentes Cuerpo Despertado o Rueda del destino se acumulan.\n3. Especialmente, las recompensas por primera vez en dificultad Locura no se verán afectadas por la \"Bonificación de ofrendas\".\n\n<Title:Resonancia: Festival de las Mareas>\n1. Los Guardián podrán obtener \"Corazón piadoso\" al completar logros del evento.\n2. Al consumir \"Corazón piadoso\" y activar \"Resonancia: Festival de las Mareas\", se obtendrán las siguientes bonificaciones:\n(1) Hará que los Guardián sean más fuertes en la actividad \"Nacimiento del Reino Divino\", facilitando los desafíos.\n(2) Aumentará la cantidad de monedas de actividad obtenidas tras completar los desafíos de \"Nacimiento del Reino Divino\".\n(3) Desbloqueará la mecánica de actividad \"Santuario del Rey Dios\".\n\n<Title:Bonificación de ofrendas>\nTras activar la Resonancia \"Prueba de sacrificio\", obtendrás automáticamente 60 \"Lágrimas del Sacrificador\" por hora, con un máximo de almacenamiento de 25 horas.\n\n<Title:Respuesta del Abismo>\n1. \"Respuesta del Abismo\" cuenta con tres altares, con los siguientes horarios de apertura:\n\"Altar de lágrimas cristalinas\": del 28 de julio 9:00 al 25 de Agosto 9:00.\n\"Altar de sangre Carmesí\": del 30 de julio 9:00 al 25 de Agosto 9:00.\n\"Altar de médula espiritual\": del 1 de Agosto 9:00 al 25 de Agosto 9:00.\n2. Cada ofrenda consumirá 1000 \"Lágrimas del Sacrificador\"/\"Sangre del Sacrificio\"/\"Médula Sacrificial\", obteniendo aleatoriamente una de las cinco recompensas de los altares.\n3. Las recompensas de los altares se dividen en \"Objeto especial\" y \"Objeto normal\". Al reiniciar, puedes restablecer la cantidad restante de recompensas de artículos específicos hasta el límite máximo. Las reglas específicas son las siguientes:\n(1) Primeros 3 reinicios: cuando no haya más \"Objeto especial\" restantes, los Guardián pueden elegir reiniciar, lo que restablecerá la cantidad restante de \"Objeto especial\" y \"Objeto normal\" hasta el límite máximo; también puedes continuar haciendo ofrendas. Cuando también se agoten los \"Objeto normal\", deberás reiniciar para seguir haciendo ofrendas.\n(2) A partir del cuarto reinicio: solo podrás reiniciar cuando se agoten los \"Objeto normal\", el reinicio restablecerá la cantidad restante de \"Objeto normal\" hasta el límite máximo, pero los \"Objeto especial\" ya no se reiniciarán.\n\n<Title:Mundo de Sueños Extraños>\n1. Durante el evento, \"Mundo de Sueños Extraños: Profanación\" estará disponible gratuitamente.\n2. Tras finalizar el evento, se mantendrá el progreso en \"Mundo de Sueños Extraños: Profanación\". Si no lo desbloqueaste durante el evento, aún podrás desbloquearlo tras finalizar consumiendo 7 Punto de partida real.\n3. Independientemente de si es durante el evento o no, al completar \"Mundo de Sueños Extraños: Profanación\" obtendrás \"Posse: Festival de las Mareas\".\n\n<Title:Compensación por reedición>\n1. Los Guardián que ya hayan desbloqueado \"Mundo de Sueños Extraños: Profanación\" anteriormente, al volver a desbloquearlo durante este evento de reedición recibirán una compensación de 700 \"Lágrimas del Sacrificador\".\n2. Los Guardián que ya hayan obtenido anteriormente el avatar exclusivo \"Llave de plata: Miryam\", al obtenerlo nuevamente se convertirá automáticamente en 1 \"Invitación del Ser Inmaterial\".\n3. Los Guardián que ya hayan obtenido anteriormente el material para activar Resonancia \"Corazón piadoso\", por cada \"Corazón piadoso\" adicional obtenido se convertirá automáticamente en 5000 \"Rosa Dorada\".\n"
  },
  Activity_67733_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_67734_ActivityName = {
    Text = "Sinfonía Intangible·Reproducción"
  },
  Activity_67734_ActivityPlot = {
    Text = "La sinfonía es un arte de tejido, donde las trayectorias de los instrumentos se entrelazan en un patrón.\nEn su red, cada nota tiene su función.\nEscucha, una sinfonía sublime está por comenzar"
  },
  Activity_67734_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Palacio del sueño\""
  },
  Activity_67734_ActivityTips = {
    Text = "<Title:Introducción a la actividad>\n1. Durante el evento, los Guardianes del Secreto pueden recolectar la moneda del evento \"Canto heroico\" a través de los modos limitados \"Sonido atronador\" y \"Recompensa de logro\". \"Canto heroico\" se puede canjear por recompensas abundantes en el \"Palacio del Sueño\", incluyendo la rueda de destino SR limitada del evento \"Presentación que nunca para\", \"Núcleo Puro\", \"Núcleo de Lumen\", \"Fragmentos de Piedra Sabia\", \"Cristal de Mimesis\", entre otros.\n2. Durante el evento, al completar las misiones de \"Recompensa de logro\" se puede obtener el avatar limitado del evento \"Por la Llave de Plata: Hameln\", la rueda de destino SR limitada del evento \"Presentación que nunca para\", Núcleo de plata y una gran cantidad de moneda del evento \"Canto heroico\".\n\n<Title: Tiempo de la actividad>\n1. Del 9 de septiembre a las 9:00 al 23 de septiembre a las 9:00 (GMT+8), todo el contenido del evento está disponible para participar.\n2. Del 23 de septiembre a las 9:00 al 30 de septiembre a las 9:00 (GMT+8), solo se mantendrán el \"Palacio del Sueño\" y \"Recompensa de logro\", el resto del contenido ha finalizado y no se puede participar.\n\n<Title: Sonido atronador>\n1. \"Sonido atronador\" consta de 9 niveles, uno se abrirá automáticamente cada día.\n2. Cada desafío consumirá \"Morfina\" × 120. Al desafiar diferentes niveles, además de obtener diferentes materiales, también se obtendrá la moneda del evento \"Canto heroico\".\n3. Los niveles de este evento son niveles de combate directo, ¡se pueden reproducir después de completarlos! Cada vez que se \"reproduce\" se consumirá \"Morfina\" × 120.\n4. Tenga en cuenta: al usar la función \"reproducir\", no se obtendrá la tasa de sincronización.\n\n<Title: Bonificación de la música>\n1. Los Guardianes del Secreto que posean ciertos Despertados o ruedas de destino (no es necesario que estén en el equipo) pueden hacer que la moneda \"Canto heroico\" en las recompensas de las misiones de los niveles de \"Sonido atronador\" obtengan una bonificación adicional (incluido en la reproducción), las bonificaciones específicas son las siguientes:\n· Despertado \"Hameln\": Despertar 0/1/2/3 y más, bonificación del 20%/30%/40%/50%\n· Rueda de destino SSR \"Réquiem Eterno\": Posición superpuesta 0/1/2/3 y más, bonificación del 20%/30%/40%/50%\n· Rueda de destino SR \"Presentación que nunca para\": Posición superpuesta 0/1/2/3 y más, bonificación del 20%/30%/40%/50%\n2. Las \"bonificaciones de música\" de diferentes Despertados o ruedas de destino se calcularán de manera acumulativa.\n3. Especialmente, las recompensas del primer desafío de dificultad locura no se verán afectadas por las \"bonificaciones de música\".\n\n<Title: Palacio del Sueño>\n1. \"Palacio del Sueño\" solo estará abierto del 9 de septiembre a las 9:00 al 30 de septiembre a las 9:00 (GMT+8).\n2. Después del 30 de septiembre a las 9:00 (GMT+8), la \"Canto heroico\" restante no canjeada se recuperará a razón de 40 \"Rosa Dorada\" por cada uno, los Guardianes del Secreto deben estar atentos a revisar su correo."
  },
  Activity_67734_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_67735_ActivityName = {
    Text = "Ola de Deseo·Reedición"
  },
  Activity_67735_ActivityPlot = {
    Text = "Los sueños son la revelación de deseos sumergidos. Quienes se demoran en ellos serán atrapados por las mareas del anhelo, convirtiéndose en apóstoles de la lujuria—a menos que..."
  },
  Activity_67735_ActivityStageEndContent = {
    Text = "El evento ha Terminado. Actualmente, solo \"Proliferación del Deseo\" está disponible."
  },
  Activity_67735_ActivityTips = {
    Text = "<Title:actividad introductoria>\n1. Durante el evento, los guardianes podrán recolectar la moneda de actividad «Núcleo de Abundancia» a través de las actividades limitadas «Deseo caótico» y «recompensas de logro». Con «Núcleo de Abundancia» podrás canjear recompensas en «Proliferación del Deseo», incluyendo la rueda de destino SR exclusiva del evento «Beso Ardiente de Despedida», Núcleo de Lumen, Núcleo Puro, Fragmentos de Piedra Sabia y Cristal de Mimesis, entre otros.\n2. Durante el evento, se relajan las condiciones para participar en «Fiebre de reproducción»: solo se requiere haber completado la Trama principal: 1-2: Normal, y no será necesario cumplir con el requisito de tasa de sincronización del Cuerpo Despertado para desbloquear el «evento de Fiebre de reproducción». Además, la cantidad requerida de «Punto de partida real» se reduce a solo 1.\n3. Una misteriosa fuerza parece ayudarte a establecer una relación más profunda con los Cuerpos Despertados. Durante el evento, ¡la tasa de sincronización obtenida por cualquier medio se duplicará!\n\n<Title:Deseo caótico>\n1. «Deseo caótico» incluye 10 niveles de materiales que no requieren exploración, directamente batallas, y cada día se abre 1 nivel.\n2. En estos niveles de materiales despertarás directamente a todos los Cuerpos Despertados y obtendrás criaturas preestablecidas. Además, tras el sexto turno recibirás una vez la ayuda de Thais.\n3. Cada desafío consumirá 120 puntos de Morfina, y al vencer obtendrás materiales y moneda de actividad.\n4. Una vez completado el nivel, se desbloqueará su función de «Reproducción». Ten en cuenta que al usar la función «Reproducción» no se obtendrá tasa de sincronización.\n5. Puedes usar el apoyo para facilitar el paso del nivel.\n\n<Title:Bono de codicia>\n1. Si el guardián posee ciertos Cuerpos Despertados o Ruedas del Destino (no es necesario tenerlos en combate), obtendrá un bono adicional en la cantidad de «Núcleo de Abundancia» recibida en las recompensas de las misiones de «Deseo caótico» (incluyendo reproducción). Los bonos específicos son los siguientes:\n· Cuerpo Despertado «Thais»: al tener nivel de Despertar Espiritual 0/1/2/3 o superior, el bono es del 20%/30%/40%/50%.\n· Rueda del Destino SSR «Amparo Misericordioso»: al tener nivel de Posición superpuesta 0/1/2/3 o superior, el bono es del 20%/30%/40%/50%.\n· Rueda del Destino SR «Beso Ardiente de Despedida»: al tener nivel de Posición superpuesta 0/1/2/3 o superior, el bono es del 20%/30%/40%/50%.\n2. Los bonos de «Bono de codicia» de diferentes Cuerpos Despertados o Ruedas del Destino se acumulan.\n3. Especialmente, las recompensas por primera vez en dificultad locura no se verán afectadas por los bonos anteriores.\n\n<Title:Proliferación del Deseo>\n1. Cada «Intercambio de núcleo de semilla» consumirá 750 «Núcleo de Abundancia» y otorgará aleatoriamente cinco objetos de recompensa dentro de «Proliferación del Deseo».\n3. Las recompensas de objetos en «Proliferación del Deseo» se dividen en «Objeto especial» y «Objeto normal». Al reiniciar, se puede restablecer la cantidad restante de recompensas de «Objeto especial» al límite máximo. Las reglas específicas son las siguientes:\n(1) Primeros 4 reinicios: cuando ya no haya cantidad restante de «Objeto especial», el guardián podrá elegir reiniciar, lo que restablecerá la cantidad restante de «Objeto especial» y «Objeto normal» al límite máximo; también puede elegir continuar intercambiando, y cuando ya no haya cantidad restante de «Objeto normal», deberá reiniciar para continuar intercambiando.\n(2) Quinto reinicio y posteriores: cuando «Objeto normal» no tenga cantidad restante, podrá reiniciar, lo que restablecerá la cantidad restante de «Objeto normal» al límite máximo, pero ya no se restablecerán los «Objeto especial».\n\n<Title:tiempo del evento>\n1. Del 15 de diciembre a las 9:00 hasta el 29 de diciembre a las 9:00 (GMT+8), todas las actividades mencionadas en la introducción estarán disponibles.\n2. Del 29 de diciembre a las 9:00 hasta el 5 de enero a las 9:00 (GMT+8), solo permanecerán disponibles «Proliferación del Deseo» y «recompensas de logro», el resto de actividades finalizarán y no podrán participarse.\n3. Tras el 5 de enero a las 9:00 (GMT+8), los «Núcleo de Abundancia» restantes que no hayan sido canjeados se reciclarán a razón de 1 por «Rosa Dorada*40». Por favor, presta atención a revisar tu correo."
  },
  Activity_67735_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_67736_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_67737_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_67738_ActivityName = {
    Text = "Evento doble de afinidad"
  },
  Activity_67739_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_67741_ActivityName = {
    Text = "Magia de la historia·Reproducción"
  },
  Activity_67741_ActivityPlot = {
    Text = "Las tareas asignadas por la muñeca nunca son simples.\nIncluso si ella ha recordado varias veces a todos \"diviértanse\", ¿cómo puede el guardián no estar asustado al llevar por primera vez un grupo de despertadores a salir?\nPero, recuerda \"divertirse\""
  },
  Activity_67741_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Tienda de guiones mágicos\""
  },
  Activity_67741_ActivityTips = {
    Text = "<Title:Descripción de la actividad>\n1. La actividad recreada \"La magia de la historia\" estará disponible por tiempo limitado. Los Guardianes podrán obtener nuevamente la Rueda del destino limitada \"Magia de 35 mm\" y el avatar limitado \"Llave de plata: Lily\" a través de la \"Tienda de guiones mágicos\" y las \"Recompensas por logros\".\n2. Durante la actividad, los \"Registro de la fuerza especial: La magia de la historia\" se desbloquearán gratuitamente por tiempo limitado.\n\n<Title:Guiones enigmáticos>\n1. \"Guiones enigmáticos\" contiene 9 etapas de materiales, se abre automáticamente 1 por día.\n2. Cada desafío consumirá 120 puntos de neuropéptido, al tener éxito obtendrás moneda de evento.\n3. Al completar una etapa, se desbloqueará la función \"Repetición\" de dicha etapa. Tenga en cuenta: al usar la función \"Repetición\", no se obtendrá tasa de sincronización.\n4. Puedes usar el apoyo de Alumnis y \"Resonancia: valor de fase del director\" para ayudarte a pasar las etapas más fácilmente.\n\n<Title:Bonificación de inspiración>\n1. Los Guardianes que posean Cuerpos Despertados específicos o Ruedas del destino (no es necesario equiparlos) podrán obtener bonificaciones adicionales de \"Inspiración errante\" en las recompensas de las misiones de \"Guiones enigmáticos\" (incluyendo repetición), las bonificaciones específicas son las siguientes:\nCuerpo Despertado \"Lily\": Despertar Espiritual 0/1/2/3 o más, bonificación 20%/30%/40%/50%\nRueda del destino SSR \"Transgresión del Sufrimiento\": Apilamiento 0/1/2/3 o más, bonificación 20%/30%/40%/50%\nRueda del destino SR \"Magia de 35 mm\": Apilamiento 0/1/2/3 o más, bonificación 20%/30%/40%/50%\n2. Las \"Bonificaciones de inspiración\" de diferentes Cuerpos Despertados o Ruedas del destino se calcularán de forma acumulativa.\n3. Especialmente, las recompensas por primera vez en dificultad Locura no se verán afectadas por las bonificaciones anteriores.\n\n<Title:Resonancia: valor de fase del director>\n1. Los Guardianes pueden obtener \"Corazón de la interpretación\" completando los logros de la actividad.\n2. Al consumir \"Corazón de la interpretación\" y activar \"Resonancia: valor de fase del director\", los Guardianes serán más fuertes en las mecánicas de la actividad \"Guiones enigmáticos\" y \"Registro de la fuerza especial: La magia de la historia\".\n\n<Title:Compensación por recreación>\n1. Los Guardianes que ya hayan desbloqueado los \"Registro de la fuerza especial: La magia de la historia\" anteriormente recibirán una compensación de \"Inspiración errante\"*700 al re-desbloquearlos durante esta recreación.\nLos Guardianes que ya hayan obtenido anteriormente el avatar limitado \"Llave de plata: Lily\", se convertirá automáticamente en \"Inspiración errante\"*2000 al obtenerlo nuevamente.\nLos Guardianes que ya hayan obtenido anteriormente el material de activación de resonancia \"Corazón de la interpretación\", cada vez que obtengan 1 adicional de \"Corazón de la interpretación\" se convertirá automáticamente en \"Rosa Dorada\"*5000.\n\n<Title:Duración de la actividad>\n1. Del 13 de enero 9:00 al 27 de enero 9:00 (GMT+8), todo el contenido mencionado en la descripción de la actividad estará disponible.\n2. Del 27 de enero 9:00 al 3 de febrero 9:00 (GMT+8), solo se mantendrá la \"Tienda de guiones mágicos\" y las \"Recompensas por logros\", el resto del contenido finalizará y no estará disponible.\n3. Después del 3 de febrero 9:00 (GMT+8), la \"Inspiración errante\" restante que no haya sido canjeada se recuperará a razón de \"Rosa Dorada*40\" por cada intercambio, por favor revise su correo electrónico."
  },
  Activity_67741_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_67742_ActivityName = {
    Text = "Con el Tomo de la Rosa · Reedición"
  },
  Activity_67742_ActivityPlot = {
    Text = "Diamantes dorados, perlas brillantes... \nInnumerables adornos ostentosos le ganaron una ilusión de emperatriz. \nAhora, está decidida a mantener esa ilusión para siempre"
  },
  Activity_67742_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Festival dorado\""
  },
  Activity_67742_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes podrán recolectar la moneda de evento \"Plumas de Espíritu\" a través de las actividades limitadas \"Memorias de Rosa\" y \"Recompensas por logros\". Las \"Plumas de Espíritu\" pueden canjearse por generosas recompensas en la \"Celebración de Oro y Carmesí\", incluyendo la Rueda del destino SR exclusiva del evento \"La Mirada Favorecida por Millones\", Núcleo Puro, Núcleo de Lumen, Fragmentos de Piedra Sabia y Cristal de Mimesis.\n2. Durante el evento, al completar las tareas de \"Recompensas por logros\" podrás obtener el avatar exclusivo del evento \"Llave de plata: Sorel\", la Rueda del destino SR exclusiva del evento \"La Mirada Favorecida por Millones\", Núcleo de plata y una gran cantidad de moneda de evento \"Plumas de Espíritu\".\n3. Durante el evento, se abrirá gratuitamente el \"Registro de la fuerza especial: Himno a la Rosa\".\n\n<Title:Memorias de Rosa>\n1. \"Memorias de Rosa\" contiene 9 etapas, las cuales se abren automáticamente una cada día.\n2. Cada intento consumirá 120 puntos de neuropéptido. Al desafiar diferentes etapas no solo obtendrás distintas recompensas, sino también moneda de evento \"Plumas de Espíritu\".\n3. Al completar una etapa, se desbloqueará su función de \"Repetición\". Por favor, ten en cuenta que al usar la función \"Repetición\" no se obtendrá tasa de sincronización.\n4. Puedes usar el apoyo de los Alumnis para ayudarte a pasar las etapas más fácilmente.\n\n<Title:Bonificación de plumas>\n1. Cuando los Guardianes posean ciertos Cuerpos Despertados o Ruedas del destino específicas (no es necesario tenerlas activas), podrán recibir bonificaciones adicionales en la obtención de \"Plumas de Espíritu\" como recompensa en las misiones de \"Memorias de Rosa\" (incluida la repetición). Las bonificaciones específicas son las siguientes:\nCuerpo Despertado \"Sorel\": Despertar Espiritual 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\nRueda del destino SSR \"En Nombre de la Rosa\": Apilamiento 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\nRueda del destino SR \"La Mirada Favorecida por Millones\": Apilamiento 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\n2. Las bonificaciones de \"Bonificación de plumas\" de diferentes Cuerpos Despertados o Ruedas del destino se acumulan.\n3. Especialmente, las recompensas por primera vez en dificultad Locura no se verán afectadas por las bonificaciones mencionadas anteriormente.\n\n<Title:Compensación por repetición>\n1. Durante el evento, los Guardianes que ya hayan desbloqueado anteriormente el \"Registro de la fuerza especial: Himno a la Rosa\" recibirán una compensación de \"Plumas de Espíritu\"*700 al desbloquearlo nuevamente.\nLos Guardianes que ya hayan obtenido anteriormente el avatar exclusivo del evento \"Llave de plata: Sorel\" y lo obtengan nuevamente tendrán automáticamente la recompensa convertida en \"Plumas de Espíritu\"*2000.\n\n<Title:Duración del evento>\n1. Del 27 de enero a las 9:00 al 10 de febrero a las 9:00 (GMT+8), todas las actividades estarán disponibles.\n2. Del 10 de febrero a las 9:00 al 17 de febrero a las 9:00 (GMT+8), solo permanecerán disponibles la \"Celebración de Oro y Carmesí\" y las \"Recompensas por logros\", el resto de contenidos finalizarán y ya no estarán disponibles.\n3. Después del 17 de febrero a las 9:00 (GMT+8), las \"Plumas de Espíritu\" restantes que no hayan sido canjeadas se convertirán según la proporción de una \"Rosa Dorada*40\" por cada intercambio, por favor, presta atención a revisar tu correo."
  },
  Activity_67742_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_67743_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_67744_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_67744_ActivityPlot = {
    Text = "Damas y caballeros.\nLa noche tranquila ha comenzado, preparen sus bebidas.\nEs una historia larga, déjennos contarla lentamente"
  },
  Activity_67745_ActivityName = {
    Text = "Deshielo en la montaña nevada·Reproducción"
  },
  Activity_67745_ActivityPlot = {
    Text = "La nieve y el hielo de Elworth nunca se deshacen, al igual que su odio. \n Cuando el futuro y el pasado entrelazan sus manos, el guerrero levantará su espada y cargará contra el destino en busca de venganza. \n Cuando ella se enfrente a las olas negras, eres su estandarte"
  },
  Activity_67745_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Boca de la montaña\""
  },
  Activity_67745_ActivityTips = {
    Text = "<Title:Introducción de la actividad>\n1,Durante la actividad, los Guardianes pueden recolectar tres tipos de \"Brotes\" a través de la actividad por tiempo limitado \"Ambición de la Bestia\" y las \"Recompensas de Logros\". Los \"Brotes\" pueden canjearse en \"Boca gigante de la montaña\" para obtener recompensas de objetos, incluyendo la Rueda del destino SR de edición limitada \"Esperando del Deshielo\", \"Núcleo Puro\", \"Núcleo de Lumen\", \"Fragmentos de Piedra Sabia\", \"Cristal de Mimesis\", entre otros.\n2,Durante la actividad, el \"Registro de la fuerza especial: El retorno de Elworth\" estará disponible de forma gratuita.\n\n<Title:Período de la actividad>\n1,Del 13 de julio a las 9:00 al 10 de agosto a las 9:00 (GMT+8), se puede participar en todos los contenidos de la actividad.\n2,Del 10 de agosto a las 9:00 al 17 de agosto a las 9:00 (GMT+8), solo se conservarán \"Boca gigante de la montaña\" y \"Recompensas de Logros\"; el resto de los contenidos habrán Terminado y no se podrá participar en ellos.\n\n<Title: Ambición de la Bestia>\n1,\"Ambición de la Bestia\" contiene 5 Niveles, y se abre automáticamente 1 cada 2 días.\n2,Cada desafío consumirá \"Morfina\" × 120; si el desafío tiene éxito, se obtendrán las monedas de actividad \"Brote helado\", \"Brote de flor plateada con escarcha\" y \"Brote de sol\".\n3,Tras Pasar un Nivel, se desbloquea la función \"Repetir\" de dicho Nivel. Tenga en cuenta: al usar la función \"Repetir\", no se puede obtener Tasa de sincronización.\n4,Puedes usar la Asistencia en batalla de la asociación de exalumnos y la \"Resonancia: Devorar montañas\" para ayudarte a Pasar los Niveles con mayor facilidad.\n5,Tenga en cuenta: los desafíos en dificultad locura no consumen Morfina, no se pueden Repetir, y los desafíos repetidos tras la primera pasada no otorgarán más recompensas de monedas de actividad.\n\n<Title: Bonificación de Brotes>\n1,Si los Guardianes poseen ciertos Cuerpos Despertados o Ruedas del destino específicos (no es necesario que estén en el equipo activo), podrán obtener bonificaciones adicionales de caída de \"Brote helado\", \"Brote de flor plateada con escarcha\" y \"Brote de sol\" en las recompensas de misiones de los Niveles de \"Ambición de la Bestia\" (incluida la función Repetir). Las bonificaciones específicas son las siguientes:\n·Cuerpo Despertado \"Helot: Catena\": Despertar Espiritual 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\n·Rueda del destino SSR \"Sumergirse en Carmesí\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\n·Rueda del destino SR \"Esperando del Deshielo\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\n2,Las \"Bonificaciones de Brotes\" de diferentes Cuerpos Despertados o Ruedas del destino se acumulan entre sí.\n3,En particular, las recompensas de la primera pasada en dificultad locura no se verán afectadas por la \"Bonificación de Brotes\".\n\n<Title:Resonancia: Devorar montañas>\n1,Los Guardianes pueden obtener el \"Corazón Devorador\" completando los logros de la actividad.\n2,Al consumir el \"Corazón Devorador\" y activar la \"Resonancia: Devorar montañas\", los Guardianes se volverán más poderosos en la actividad de juego \"Ambición de la Bestia\", haciendo los desafíos más sencillos.\n\n<Title: Boca gigante de la montaña>\n1,\"Boca gigante de la montaña\" cuenta con tres tiendas de canje, con los siguientes horarios de apertura:\n·\"Ambición devoradora\": Apertura el 13 de julio a las 9:00.\n·\"Espíritu de venganza\": Apertura el 15 de julio a las 9:00.\n·\"Esperanza de resurrección\": Apertura el 17 de julio a las 9:00.\n2,Cada canje consumirá \"Brote helado\"/\"Brote de flor plateada con escarcha\"/\"Brote de sol\" × 750, y se obtendrán aleatoriamente cinco recompensas de objetos de la tienda de canje.\n3,Las recompensas de objetos de cada tienda de canje se dividen en \"Objeto especial\" y \"Objeto normal\". Al reiniciar, se puede restablecer la cantidad Restante de recompensas de Objetos especiales al límite máximo. Las reglas específicas son:\n(1)Primeros 2 reinicios: Cuando los \"Objetos especiales\" no tengan cantidad Restante, los Guardianes pueden elegir reiniciar; tras el reinicio, la cantidad Restante de \"Objetos especiales\" y \"Objetos normales\" se restablecerá al límite máximo. También pueden optar por continuar canjeando; cuando los \"Objetos normales\" tampoco tengan cantidad Restante, será necesario reiniciar para continuar canjeando.\n(2)A partir del 3.er reinicio: Solo se podrá reiniciar cuando los \"Objetos normales\" no tengan cantidad Restante; el reinicio restablecerá la cantidad Restante de \"Objetos normales\" al límite máximo, y los \"Objetos especiales\" ya no se reiniciarán.\n4,Después de las 9:00 del 17 de agosto (GMT+8), los \"Brotes\" Restantes no canjeados serán recuperados a razón de \"Rosa Dorada\" × 40 por unidad. Los Guardianes deben revisar su correo.\n\n<Title: Registro de la fuerza especial>\n1,Durante la actividad, el \"Registro de la fuerza especial: El retorno de Elworth\" estará disponible de forma gratuita. Tras Pasar el \"Registro de la fuerza especial: El retorno de Elworth\", se podrán obtener recompensas como \"Núcleo de plata\" y la Rueda del destino SR de edición limitada \"Esperando del Deshielo\" en las Recompensas de Logros. Las Recompensas de Logros solo estarán disponibles durante el período de la actividad; una vez finalizada la actividad, no se podrán completar ni reclamar.\n2,Tras finalizar la actividad, el progreso de investigación del \"Registro de la fuerza especial: El retorno de Elworth\" se conservará. Si no se desbloqueó el \"Registro de la fuerza especial: El retorno de Elworth\" durante la actividad, aún se podrá desbloquear consumiendo \"Punto de partida real\" × 7 después de que finalice la actividad.\n3,Independientemente de si se está en el período de la actividad o no, tras Pasar el \"Registro de la fuerza especial: El retorno de Elworth\" siempre se podrá obtener la \"Posse: La resolución de las montañas\"."
  },
  Activity_67745_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_67746_ActivityName = {
    Text = "Portal de todos los reinos: repetició"
  },
  Activity_67746_ActivityPlot = {
    Text = "Nadie sabe cuánto tiempo ha permanecido en silenciosa guardia ante la Puerta de la Pobreza Extrema.\nNunca tuvo la intención de manifestarse en ningún mundo tangible, ni de ser arrastrada por ninguna corriente espacio–temporal.\nAllí, en la Puerta, permaneció imperturbable—\nHasta el momento en que sus ojos se encontraron con los tuyos."
  },
  Activity_67746_ActivityStageEndContent = {
    Text = "El evento ha Terminado. Actualmente, solo \"Eco\" está disponible."
  },
  Activity_67746_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los guardianes podrán recolectar la moneda del evento \"Puntero final\" a través de las actividades limitadas \"Test final\" y \"Recompensas por logros\". \"Puntero final\" podrá canjearse por generosas recompensas en \"Eco\", incluyendo la Rueda del destino SR exclusiva del evento \"Puerta de la Verdad\", Núcleo Puro, Núcleo de Lumen, Fragmentos de Piedra Sabia, Cristal de Mimesis, entre otros.\n2. Durante el evento, al completar las tareas de \"Recompensas por logros\" podrás obtener el avatar exclusivo del evento \"Por la Llave de Plata: \"Tavi\"\", la Rueda del destino SR exclusiva del evento \"Puerta de la Verdad\", Núcleo de plata y una gran cantidad de moneda del evento \"Puntero final\".\n\n<Title:Duración del evento>\n1. Del 3 de noviembre a las 9:00 hasta el 17 de noviembre a las 9:00 (GMT+8), todas las actividades estarán disponibles.\n2. Del 17 de noviembre a las 9:00 hasta el 24 de noviembre a las 9:00 (GMT+8), solo permanecerán disponibles \"Eco\" y \"Recompensas por logros\", el resto de contenidos finalizarán y no podrán ser accedidos.\n\n<Title:Test final>\n1. \"Test final\" contiene 9 etapas, se abre 1 automáticamente cada día.\n2. Cada desafío consumirá 120 puntos de neuropéptido, al desafiar diferentes etapas obtendrás caídas de materiales distintos, además de la moneda del evento \"Puntero final\".\n3. Las etapas de este evento son misiones de materiales de combate directo, ¡una vez superadas podrás repetirlas! Cada \"repetición\" consumirá 120 puntos de neuropéptido.\n4. Por favor, ten en cuenta: al usar la función \"repetición\" no se obtendrá tasa de sincronización.\n\n<Title:Bonificación de Puntero final>\n1. Si los guardianes poseen ciertos Cuerpos Despertados o Ruedas del destino específicas (no es necesario tenerlas activas), obtendrán una bonificación adicional de \"Puntero final\" en las recompensas de las misiones del \"Test final\" (incluyendo repeticiones). Las bonificaciones específicas son las siguientes:\n· Cuerpo Despertado \"\"Tavi\"\": con Despertar Espiritual 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n· Rueda del destino SSR \"Rueda Oculta\": con Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n· Rueda del destino SR \"Puerta de la Verdad\": con Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n2. Las bonificaciones de \"Puntero final\" de diferentes Cuerpos Despertados o Ruedas del destino se acumulan.\n3. Especialmente, las recompensas por primera vez en dificultad locura no se verán afectadas por la bonificación de \"Puntero final\".\n\n<Title:Eco>\n1. \"Eco\" solo estará disponible del 3 de noviembre a las 9:00 hasta el 24 de noviembre a las 9:00 (GMT+8).\n2. Después del 24 de noviembre a las 9:00 (GMT+8), los \"Punteros finales\" restantes no canjeados se convertirán automáticamente a razón de \"Rosa Dorada*40\" por cada uno, por favor recuerda revisar tu correo para reclamarlos."
  },
  Activity_67746_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_67746_UnlockConditionExplanation = {
    Text = "Desbloquea después de completar \"Operación de Investigación\" 2-9 · Normal"
  },
  Activity_67748_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_67749_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_68349_ActivityName = {
    Text = "Más allá de las estrellas · Preventa por tiempo limitado"
  },
  Activity_68349_ActivityTips = {
    Text = "<Title: Más allá de las estrellas · Precompra limitada>\n· La actividad de precompra limitada incluye 8 paquetes, el primero de los cuales puede reclamarse gratuitamente de inmediato. Los paquetes del 2 al 8 solo podrán reclamarse tras comprar \"Más allá de las estrellas · Precompra limitada\".\n· Tras comprar \"Más allá de las estrellas · Precompra limitada\", podrás reclamar inmediatamente la recompensa del segundo paquete; los paquetes siguientes deberán esperar un tiempo determinado antes de poder ser reclamados.\n· La compra de \"Más allá de las estrellas · Precompra limitada\" tiene límite de tiempo, y tras su vencimiento ya no podrá comprarse. Por favor, adquiérelo según convenga."
  },
  Activity_68374_ActivityName = {
    Text = "Caja de regalo del Festival de Invierno"
  },
  Activity_68374_ActivityPlot = {
    Text = "Una caja de regalo proporcionada por los Misaq para la celebración de la Fiesta de Solsticio. Ni el viento ni la escarcha pueden destruir la voluntad de los Misaq de resistir la Fusión. A la luz festiva del fuego, las almas que se apoyan mutuamente protegerán a todos los que se niegan a ceder ante el Destino."
  },
  Activity_68375_ActivityName = {
    Text = "Caja de regalo especial de aniversario"
  },
  Activity_68375_ActivityPlot = {
    Text = "Reformada por la Tecnología de núcleo de plata, Su mirada adopta nuevas formas para acompañarte. En cada momento del último año, ha estado contigo."
  },
  Activity_68404_ActivityName = {
    Text = "Texto temporal"
  },
  Activity_68404_ActivityPlot = {
    Text = "Texto temporal"
  },
  Activity_68404_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Texto temporal\""
  },
  Activity_68404_ActivityTips = {
    Text = [[
<Title:Resumen del Evento>
Texto temporal]]
  },
  Activity_68404_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_68405_ActivityName = {
    Text = "Resurrección del Rey de los Dioses"
  },
  Activity_68405_ActivityPlot = {
    Text = "En el deseo interminable de deseos, brevemente despierta en su largo sueño y echa una mirada real a este mundo tenue.\nEn la vida eterna, esta mirada es tan breve"
  },
  Activity_68405_ActivityStageEndContent = {
    Text = "El evento ha terminado. Actualmente, solo \"Abismo de Conciencia\" está disponible."
  },
  Activity_68405_ActivityTips = {
    Text = "<Title:Descripción de la actividad>\n1. Durante el evento, los guardianes pueden recolectar las monedas de evento \"pensamiento fatigado\", \"pensamiento triste\" y \"pensamiento alegre\" a través de las actividades limitadas \"mirada abismal\" y \"recompensas de logro\". Estas monedas pueden ser utilizadas en \"abismo consciente\" para comprar artículos, incluyendo la rueda de destino SR exclusiva del evento \"trono de piedra grisácea\", núcleo de luz, núcleo puro, astillas de piedra preciosa, cristal mimético, entre otros.\n2. Durante el evento, también podrás obtener recompensas al completar los logros de la actividad, incluyendo el avatar exclusivo del evento \"en nombre de la llave plateada: Turu\", la rueda de destino SR exclusiva del evento \"trono de piedra grisácea\", plata del núcleo y muchas monedas de evento.\n\n<Title:Duración del evento>\n1. Del 30 de diciembre a las 9:00 hasta el 13 de enero a las 9:00 (GMT+8), todas las actividades del evento estarán disponibles.\n2. Del 13 de enero a las 9:00 hasta el 20 de enero a las 9:00 (GMT+8), solo podrás participar en \"abismo consciente\" y las recompensas de logro.\n\n<Title:Mirada abismal>\n1. \"Mirada abismal\" tiene 5 niveles, cada 2 días se desbloqueará 1 nivel automáticamente.\n2. Cada intento consume 120 puntos de neuropep, si tienes éxito obtendrás monedas de evento.\n3. Una vez que completes un nivel, desbloquearás su función de \"repetición\". Ten en cuenta que al usar la función de \"repetición\" no obtendrás tasa de sincronización.\n4. Puedes usar el apoyo de los \"alumnos\" para ayudarte a pasar los niveles más fácilmente.\n\n<Title:Bonificación de pensamiento>\n1. Si el guardián posee ciertos cuerpos de despertar o ruedas de destino específicas (no es necesario tenerlas en batalla), obtendrá una bonificación adicional en las monedas de evento obtenidas en las recompensas de las misiones de \"mirada abismal\". Las bonificaciones específicas son las siguientes:\n· Cuerpo de despertar \"Turu\": afinación 0/1/2/3 o más, bonificación del 20%/30%/40%/50%.\n· Rueda de destino SSR \"Himno del rey divino\": superposición 0/1/2/3 o más, bonificación del 20%/30%/40%/50%.\n· Rueda de destino SR \"Trono de piedra grisácea\": superposición 0/1/2/3 o más, bonificación del 20%/30%/40%/50%.\n2. Las bonificaciones de \"bonificación de pensamiento\" de diferentes cuerpos de despertar o ruedas de destino se suman.\n3. Especialmente, las recompensas por primera vez en dificultad frenética no se ven afectadas por la \"bonificación de pensamiento\".\n\n<Title:Abismo consciente>\n1. \"Abismo consciente\" solo estará disponible del 30 de diciembre a las 9:00 al 20 de enero a las 9:00 (GMT+8).\n2. Después del 20 de enero a las 9:00 (GMT+8), los \"pensamiento fatigado\", \"pensamiento triste\" y \"pensamiento alegre\" restantes serán canjeados por \"billete de rosa dorada*40\" según la proporción de uno por cada moneda, por favor asegúrate de revisar tu correo."
  },
  Activity_68405_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_68406_ActivityName = {
    Text = "Enterrado en la memoria"
  },
  Activity_68406_ActivityPlot = {
    Text = "Las personas entierran profundamente en su memoria aquello que desean y usan una máscara ilusoria para adaptarse al mundo.  ¡Escucha! El grito de lo oculto tras la carne y la piel resuena en la niebla de la memoria.  Vacía tu mente, abandona la carne y recibe a tu yo verdadero.\n"
  },
  Activity_68406_ActivityStageEndContent = {
    Text = "Evento finalizado, actualmente solo disponible \"Consultorio de Neurología\""
  },
  Activity_68406_ActivityTips = {
    Text = "<Title:Descripción del evento>\nDurante el evento, los guardianes podrán recolectar monedas de evento a través de las actividades limitadas \"Curación del Miedo\" y \"Recompensas por Logros\". Las monedas de evento podrán ser utilizadas en el \"Consultorio Neurológico\" para intercambiar por recompensas, incluyendo la Rueda del destino SR exclusiva del evento \"Péndulo Hipnótico\", Piedra Filosofal, Núcleo Puro, Núcleo de Lumen, entre otros.\n\n<Title:Duración del evento>\n1. Del 7 de abril a las 9:00 al 21 de abril a las 9:00 (GMT+8), todas las actividades estarán disponibles.\n2. Del 21 de abril a las 9:00 al 28 de abril a las 9:00 (GMT+8), solo permanecerán disponibles el \"Consultorio Neurológico\" y las \"Recompensas por Logros\", el resto de actividades finalizarán y no podrán ser accedidas.\n\n<Title:Curación del Miedo>\n1. \"Curación del Miedo\" contiene 5 etapas, las cuales se desbloquearán automáticamente cada 2 días.\n2. Cada intento consumirá 120 puntos de neuropéptido, y al superar la etapa se obtendrán monedas de evento.\n3. Al completar una etapa se desbloqueará su función de \"Repetición\". Por favor, tenga en cuenta: al usar la función de \"Repetición\" no se obtendrá porcentaje de sincronización.\n4. Puedes usar aliados del club para facilitar el paso de las etapas.\n\n<Title:Bonificaciones del evento>\n1. Si el guardián posee un Cuerpo Despertado específico o una Rueda del destino (no es necesario tenerla activa), podrá obtener bonificaciones adicionales en la obtención de \"Informe de diagnóstico\" en las recompensas de las etapas de \"Curación del Miedo\" (incluyendo la repetición). Las bonificaciones específicas son las siguientes:\nCuerpo Despertado \"\"Clementine\"\": Despertar Espiritual 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\nRueda del destino SSR \"Angustia Velada\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\nRueda del destino SR \"Péndulo Hipnótico\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n2. Las bonificaciones de diferentes Cuerpos Despertados o Ruedas del destino se acumularán.\n3. Especialmente, las recompensas por primera vez en dificultad Locura no se verán afectadas por las bonificaciones del evento.\n\n<Title:Consultorio Neurológico>\n1. Cada \"Enviar informe\" consumirá 1000 \"Informe de diagnóstico\", otorgando aleatoriamente cinco recompensas disponibles en el \"Consultorio Neurológico\".\n2. Las recompensas del \"Consultorio Neurológico\" se dividen en \"Objeto especial\" y \"Objeto normal\". Al reiniciar se podrá restaurar la cantidad restante de recompensas especiales hasta el límite máximo. Las reglas específicas son las siguientes:\n(1) Primeros 5 reinicios: cuando ya no haya \"Objeto especial\" disponibles, el guardián podrá elegir reiniciar, restaurando la cantidad restante tanto de \"Objeto especial\" como de \"Objeto normal\"; también puede optar por continuar intercambiando, y cuando ya no haya \"Objeto normal\", será necesario reiniciar para continuar.\n(2) A partir del sexto reinicio: solo será posible reiniciar cuando ya no haya \"Objeto normal\" disponibles. Al reiniciar se restaurará la cantidad restante de \"Objeto normal\" hasta el límite máximo, pero ya no se restaurarán los \"Objeto especial\".\n3. Después de las 9:00 del 28 de abril (GMT+8), los \"Informe de diagnóstico\" restantes no canjeados serán convertidos a razón de cada uno por \"Rosa Dorada*40\", por favor, revise su correo."
  },
  Activity_68406_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_68407_ActivityName = {
    Text = "Texto temporal"
  },
  Activity_68407_ActivityPlot = {
    Text = "Texto temporal"
  },
  Activity_68407_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Texto temporal\""
  },
  Activity_68407_ActivityTips = {
    Text = [[
<Title:Resumen del Evento>
Texto temporal]]
  },
  Activity_68407_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_68409_ActivityName = {
    Text = "Texto temporal"
  },
  Activity_68409_ActivityPlot = {
    Text = "Texto temporal"
  },
  Activity_68409_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Texto temporal\""
  },
  Activity_68409_ActivityTips = {
    Text = [[
<Title:Resumen del Evento>
Texto temporal]]
  },
  Activity_68409_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_68410_ActivityName = {
    Text = "Sombra de la ciudad lluviosa"
  },
  Activity_68410_ActivityPlot = {
    Text = "Un encuentro predestinado aguarda bajo la lluvia húmeda y brumosa. Conoces su nombre y su rostro, y su voz aún te arrulla hasta hacerte sentir en calma. \nPero recuerda—solo los dioses y los demonios están tan desesperados por satisfacer los deseos humanos. \nAdivina. ¿Cuál de ellos es ella?"
  },
  Activity_68410_ActivityStageEndContent = {
    Text = "El evento ha terminado. Ahora solo puedes participar en \"La Bóveda de la Bruja\"."
  },
  Activity_68410_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes podrán recolectar monedas del evento a través de las actividades limitadas \"Tienda de la Bruja\" y \"Recompensas por Logros\". Las monedas del evento podrán ser utilizadas en \"El Tesoro de la Bruja\" para intercambiar y obtener recompensas de objetos, incluyendo la Rueda del destino limitada SR \"Sombrero de Bruja de Ala Ancha\", Piedra Filosofal, Núcleo Puro y Núcleo de Lumen.\n2. Durante el evento, se abrirá gratuitamente \"Registro de la fuerza especial: Sombras en la Ciudad Lluviosa\", ¡y al completar los logros del evento también podrás obtener el avatar exclusivo \"Llave de plata: Daffodil\"!\n\n<Title:Duración del evento>\n1. Del 24 de febrero a las 9:00 al 10 de marzo a las 9:00 (GMT+8), todas las actividades estarán disponibles.\n2. Del 10 de marzo a las 9:00 al 17 de marzo a las 9:00 (GMT+8), solo permanecerán \"El Tesoro de la Bruja\" y \"Recompensas por Logros\", el resto de contenidos finalizarán y no estarán disponibles.\n\n<Title:Tienda de la Bruja>\n1. \"Tienda de la Bruja\" contiene 5 niveles, cada 2 días se desbloqueará 1 nivel automáticamente.\n2. Cada desafío consumirá 120 puntos de neuropéptido, y al superarlo obtendrás monedas del evento.\n3. Una vez superado un nivel, se desbloqueará su función de \"Repetición\". Por favor, ten en cuenta: al usar la función de \"Repetición\", no se obtendrá tasa de sincronización.\n4. Puedes usar el apoyo de los Alumnis para ayudarte a superar el nivel más fácilmente.\n\n<Title:Bonificaciones del evento>\n1. Si el Guardián posee ciertos Cuerpos Despertados o Ruedas del destino específicas (no es necesario tenerlas en combate), podrá obtener bonificaciones adicionales en la obtención de \"Cráneo de Bestia Pálida\", \"Cráneo de Bestia Sombría\" y \"Cráneo de la Bestia Carmesí\" en las recompensas de las misiones de \"Tienda de la Bruja\" (incluyendo la repetición). Las bonificaciones específicas son las siguientes:\nCuerpo Despertado \"Daffodil\": Despertar Espiritual 0/1/2/3 o más, bonificación del 20%/30%/40%/50%\nRueda del destino SSR \"Colección más Preciada\": Apilamiento 0/1/2/3 o más, bonificación del 20%/30%/40%/50%\nRueda del destino SR \"Sombrero de Bruja de Ala Ancha\": Apilamiento 0/1/2/3 o más, bonificación del 20%/30%/40%/50%\n2. Las \"Bonificaciones del evento\" de diferentes Cuerpos Despertados o Ruedas del destino se aplicarán de forma acumulativa.\n3. Especialmente, las recompensas por primera vez en dificultad Locura no se verán afectadas por las \"Bonificaciones del evento\".\n\n<Title:El Tesoro de la Bruja>\n1. Existen tres \"Tesoros de la Bruja\", y sus fechas de apertura son las siguientes:\n\"Remedio Perfecto\": del 24 de febrero a las 9:00 al 17 de marzo a las 9:00.\n\"Tesoro Resplandeciente\": del 26 de febrero a las 9:00 al 17 de marzo a las 9:00.\n\"Mercancía Extraordinaria\": del 28 de febrero a las 9:00 al 17 de marzo a las 9:00.\n2. Cada intercambio consumirá 750 \"Cráneo de Bestia Pálida\"/\"Cráneo de Bestia Sombría\"/\"Cráneo de la Bestia Carmesí\", y obtendrás aleatoriamente cinco recompensas del tesoro.\n3. Las recompensas de objetos de cada tesoro se dividen en dos tipos: \"Objeto especial\" y \"Objeto normal\". Al reiniciar, puedes restablecer la cantidad restante de recompensas de objetos especificados hasta el límite máximo. Las reglas específicas son las siguientes:\n(1) Primeros 2 reinicios: cuando ya no quede cantidad de \"Objeto especial\", el Guardián podrá elegir reiniciar, y tras el reinicio se restablecerá la cantidad restante de \"Objeto especial\" y \"Objeto normal\" al límite máximo; también puedes continuar intercambiando, y cuando ya no quede cantidad de \"Objeto normal\", deberás reiniciar para continuar intercambiando.\n(2) A partir del tercer reinicio: solo podrás reiniciar cuando ya no quede cantidad de \"Objeto normal\", el reinicio restablecerá la cantidad restante de \"Objeto normal\" al límite máximo, pero los \"Objeto especial\" ya no se restablecerán.\n\n<Title:Registro Especial>\n1. Durante el evento, \"Registro de la fuerza especial: Sombras en la Ciudad Lluviosa\" estará disponible gratuitamente.\n2. Tras finalizar el evento, se conservará el progreso de \"Registro de la fuerza especial: Sombras en la Ciudad Lluviosa\". Si no lo desbloqueaste durante el evento, aún podrás desbloquearlo tras finalizar el evento consumiendo 7 \"Punto de partida real\".\n3. Independientemente de si es durante el evento o no, podrás obtener \"Llave: Verdadero Rostro de la Niebla Gris\" al superar \"Registro de la fuerza especial: Sombras en la Ciudad Lluviosa\"."
  },
  Activity_68410_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_68411_ActivityName = {
    Text = "Texto temporal"
  },
  Activity_68411_ActivityPlot = {
    Text = "Texto temporal"
  },
  Activity_68411_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Texto temporal\""
  },
  Activity_68411_ActivityTips = {
    Text = [[
<Title:Resumen del Evento>
Texto temporal]]
  },
  Activity_68411_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_70438_ActivityName = {
    Text = "Uma Nya Nya Rate"
  },
  Activity_70438_ActivityPlot = {
    Text = "Se acerca el Festival de Oración Anual, y todos están enfocados en los preparativos de la celebración, nadie presta atención al rincón donde una mancha oscura comienza a moverse lentamente, y el pequeño prisionero se transforma en líquido escapando de su jaula.\nCon las grietas brillantes de las dimensiones, el pelotón negro comienza a dividirse... ¡una vasta mar de gatos negros está devorando todo el campus!\nAl principio quieres ignorarlo, sería mejor dejar que el personal escolar se encargara de este extraño incidente.\nPero al ver que dejan caer núcleos plateados y cupones dorados, cambias de opinión."
  },
  Activity_70438_ActivityTips = {
    Text = "<Title:Descripción del evento>\n¡El evento de juego \"Uma Nya Nya Rate\" está disponible por tiempo limitado! Durante el evento, los Guardianes pueden golpear a los gatos del campus en \"Danza Caótica de Gatos\" y obtener grandes cantidades de Núcleos de plata y vales de Rosa Dorada.\n\n<Title:Duración del evento>\nDel 24 de enero a las 9:00 al 5 de febrero a las 9:00 (GMT+8). Durante el evento, se pueden jugar las fases de \"Danza Caótica de Gatos\" desbloqueadas cada día. Las fases finalizadas no se pueden repetir.\n\n<Title:Danza Caótica de Gatos>\n1. \"Danza Caótica de Gatos\" tiene un total de 12 fases. Cada día se abren fases diferentes y las fases finalizadas no se pueden repetir.\n2. Cada desafío no consume Menophin, y al completar cada fase se obtendrán Núcleos Puros, Núcleos de plata y vales de Rosa Dorada.\n3. En estas fases no se puede utilizar la asistencia de Alumni.\n4. En las fases diarias, cada Despertado solo puede participar una vez.\n5. Las fases diarias requieren reinos específicos para los desafíos:\n24 de enero: Reino del Caos\n25 de enero: Reino del Aequor\n26 de enero: Reino de Caro\n27 de enero: Ultra Reino\n28 de enero: Sin restricciones\n29 de enero: Sin restricciones\n30 de enero: Reino del Caos y Reino del Aequor\n31 de enero: Reino de Caro y Ultra Reino\n1 de febrero: Reino del Caos y Reino de Caro\n2 de febrero: Reino del Aequor y Ultra Reino\n3 de febrero: Reino del Caos y Ultra Reino\n4 de febrero: Reino de Caro y Reino del Aequor"
  },
  Activity_70438_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_71095_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_71095_ActivityTips = {
    Text = "<Title:Condiciones de Participación>\n·Completa la \"Operación de Investigación\" 2-9 (Normal) para participar.\n<Title:Evento de Investigación>\n·Durante el período del evento, se lanzará diariamente un nuevo evento de investigación de \"La Magia de las Historias\". Los Guardianes pueden desbloquear e investigar sin consumir inventario. Después de completar el evento de investigación, se pueden obtener recompensas como Núcleo Puro, Insignia de Investigación, y Experiencia de Guardián.\n·Después de que termine el evento, el progreso de la investigación de \"La Magia de las Historias\" se conservará. Los Guardianes pueden consumir D-joyas en el Registro Especial para desbloquear investigaciones incompletas. Completar eventos de investigación incompletos durante el período del evento también otorgará recompensas consistentes con las de durante el evento.<Title:Recompensas por Tiempo Limitado>\n·Las recompensas por tiempo limitado estarán disponibles durante el evento. Los Guardianes pueden obtener Núcleo Puro, Piedra Filosofal y recompensas de Plata después de completar \"La Magia de las Historias\" (modo Normal) y completar eventos de investigación de \"La Magia de las Historias\"! Las recompensas por tiempo limitado solo están disponibles durante el período del evento y no se pueden completar ni reclamar después de que termine el evento."
  },
  Activity_71097_ActivityName = {
    Text = "Texto temporal"
  },
  Activity_71097_ActivityPlot = {
    Text = "Texto temporal"
  },
  Activity_71097_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Texto temporal\""
  },
  Activity_71097_ActivityTips = {
    Text = [[
<Title:Resumen del Evento>
Texto temporal]]
  },
  Activity_71097_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_71098_ActivityName = {
    Text = "Medio paso de distancia · Réplica"
  },
  Activity_71098_ActivityPlot = {
    Text = "Ella siempre va un paso por delante del mundo.\nUn paso, dos pasos—sus huellas iluminan el camino para todos.\nPero los necios olvidan con demasiada facilidad:\nLa distancia entre la genialidad y la locura\nes de apenas medio paso."
  },
  Activity_71098_ActivityStageEndContent = {
    Text = "El evento ha Terminado. Actualmente, solo \"Enseñanzas del Maestro\" está disponible."
  },
  Activity_71098_ActivityTips = {
    Text = "<Title:Descripción del evento>\nDurante el evento, los Guardianes podrán recolectar la moneda de evento «Piezas de muñeca» a través de las actividades limitadas «Puerta de la Nada» y «Recompensas por Logros». Las «Piezas de muñeca» pueden intercambiarse por recompensas en «Enseñanzas del Maestro», incluyendo la rueda de destino SR exclusiva del evento «Bastón del Pastor», Núcleos de Lumen, Núcleo Puro, Fragmentos de Piedra Sabia, Cristales de Mimesis y otros.\n\n<Title:Puerta de la Nada>\n1. «Puerta de la Nada» contiene 9 misiones de materiales en las que no es necesario explorar, solo combatir, y se abre 1 por día.\n2. Cada desafío consume 120 puntos de neuropéptido, y al tener éxito se obtendrán materiales de entrenamiento y moneda de evento.\n3. Tras completar una misión, se desbloqueará su función «Repetición». Nota: al usar la función «Repetición», no se obtendrá tasa de sincronización.\n4. Puedes usar el apoyo de los Alumnis para ayudarte a pasar las misiones más fácilmente.\n\n<Title:Bonificación de Piezas de muñeca>\n1. Cuando los Guardianes posean ciertos Despertados o Ruedas de Destino específicos (no es necesario tenerlos en batalla), las «Piezas de muñeca» obtenidas en las misiones de «Puerta de la Nada» recibirán bonificaciones adicionales (incluyendo repetición), las bonificaciones específicas son las siguientes:\n· Cuerpo Despertado «Doll: Infierno»: con Despertar Espiritual 0/1/2/3 o más, bonificación del 20%/30%/40%/50%.\n· Rueda de Destino SSR «Títere del Vacío»: con Posición superpuesta 0/1/2/3 o más, bonificación del 20%/30%/40%/50%.\n· Rueda de Destino SR «Bastón del Pastor»: con Posición superpuesta 0/1/2/3 o más, bonificación del 20%/30%/40%/50%.\n2. Las bonificaciones de «Bonificación de Piezas de muñeca» de diferentes Despertados o Ruedas de Destino se suman.\n3. Especialmente, las recompensas por primera vez en dificultad Locura no se ven afectadas por las bonificaciones anteriores.\n\n<Title:Enseñanzas del Maestro>\n1. Cada «Intercambio de Piezas» consumirá 750 «Piezas de muñeca», y obtendrás aleatoriamente 5 recompensas entre los artículos de «Enseñanzas del Maestro».\n2. Las recompensas de «Enseñanzas del Maestro» se dividen en dos tipos: «Objeto especial» y «Objeto normal». Al reiniciar, la cantidad restante de «Objeto especial» se restablecerá al máximo. Las reglas específicas son las siguientes:\n(1) Primeros 5 reinicios: cuando ya no haya «Objeto especial» disponibles, el Guardián podrá elegir reiniciar, lo que restablecerá la cantidad restante de «Objeto especial» y «Objeto normal» al máximo; también puede elegir continuar intercambiando, y cuando ya no haya «Objeto normal» disponibles, deberá reiniciar para continuar intercambiando.\n(2) A partir del sexto reinicio: solo podrá reiniciar cuando ya no haya «Objeto normal» disponibles, el reinicio restablecerá la cantidad restante de «Objeto normal» al máximo, pero ya no se restablecerán los «Objeto especial».\n\n<Title:Duración del evento>\n1. Del 16 de junio a las 9:00 al 30 de junio a las 9:00 (GMT+8), todas las actividades mencionadas en la descripción del evento estarán disponibles.\n2. Del 30 de junio a las 9:00 al 7 de julio a las 9:00 (GMT+8), solo permanecerán disponibles «Enseñanzas del Maestro» y «Recompensas por Logros», el resto de actividades finalizarán y ya no podrán participarse.\n3. Tras las 9:00 del 7 de julio (GMT+8), las «Piezas de muñeca» no canjeadas se convertirán a razón de 40 Rosa Dorada por pieza. Por favor, asegúrate de revisar tu correo, Guardianes."
  },
  Activity_71098_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_71100_ActivityName = {
    Text = "Resurrección del Rey de los Dioses"
  },
  Activity_71100_ActivityPlot = {
    Text = "En el deseo interminable de deseos, brevemente despierta en su largo sueño y echa una mirada real a este mundo tenue.\nEn la vida eterna, esta mirada es tan breve"
  },
  Activity_71100_ActivityStageEndContent = {
    Text = "El evento ha terminado. Actualmente, solo \"Abismo de Conciencia\" está disponible."
  },
  Activity_71100_ActivityTips = {
    Text = "<Title:Descripción de la actividad>\n1. Durante la actividad, los guardianes podrán recolectar las monedas de evento \"Pensamientos cansados\", \"pensamiento triste\" y \"pensamiento alegre\" a través de las actividades limitadas \"mirada abismal\" y \"recompensas de logros\". Estas monedas pueden ser utilizadas en \"Abismo del mar de la percepción\" para comprar artículos, incluyendo la Rueda del destino SR exclusiva del evento \"trono de piedra verde\", Núcleo de Lumen, Núcleo Puro, Fragmentos de Piedra Sabia y Cristal de Mimesis, entre otros.\n2. Durante la actividad, también podrás obtener recompensas al completar logros de evento, incluyendo el avatar exclusivo \"con la Llave de plata: Caecus\", la Rueda del destino SR exclusiva \"trono de piedra verde\", Plata y muchas monedas de evento.\n\n<Title:Duración del evento>\n1. Del 30 de diciembre a las 9:00 hasta el 13 de enero a las 9:00 (GMT+8), todas las actividades del evento estarán disponibles.\n2. Del 13 de enero a las 9:00 hasta el 20 de enero a las 9:00 (GMT+8), solo estará disponible \"Abismo del mar de la percepción\" y las recompensas de logros.\n\n<Title:Mirada abismal>\n1. \"Mirada abismal\" tiene 5 etapas, las cuales se desbloquean automáticamente cada 2 días.\n2. Cada intento consume 120 éxtasis, y al superar la etapa obtendrás monedas de evento.\n3. Al completar una etapa, se desbloquea la función \"repetición\" de dicha etapa. Ten en cuenta que al usar la función \"repetición\" no se obtiene tasa de sincronización.\n4. Puedes usar el apoyo de los compañeros de la asociación de exalumnos para superar las etapas con mayor facilidad.\n\n<Title:Bonificación de pensamientos>\n1. Si el guardián posee ciertos Cuerpos Despertados o Ruedas del destino (no es necesario tenerlos activados), obtendrá una bonificación adicional en las monedas de evento obtenidas en las recompensas de las misiones de \"mirada abismal\". Las bonificaciones específicas son las siguientes:\nCuerpo Despertado \"Tulu\": Despertar Espiritual 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\nRueda del destino SSR \"Himno al Dios-Rey\": Apilamiento 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\nRueda del destino SR \"trono de piedra verde\": Apilamiento 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n2. Las bonificaciones \"bonificación de pensamientos\" de diferentes Cuerpos Despertados o Ruedas del destino se suman.\n3. Especialmente, las recompensas por primera vez en dificultad Locura no se ven afectadas por la \"bonificación de pensamientos\".\n\n<Title:Abismo del mar de la percepción>\n1. \"Abismo del mar de la percepción\" solo estará disponible del 30 de diciembre a las 9:00 al 20 de enero a las 9:00 (GMT+8).\n2. Después del 20 de enero a las 9:00 (GMT+8), las monedas \"Pensamientos cansados\", \"pensamiento triste\" y \"pensamiento alegre\" restantes serán canjeadas a razón de \"Rosa Dorada *40 por canje\". Por favor, recuerda revisar tu correo."
  },
  Activity_71100_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_71101_ActivityName = {
    Text = "Texto temporal"
  },
  Activity_71101_ActivityPlot = {
    Text = "Texto temporal"
  },
  Activity_71101_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Texto temporal\""
  },
  Activity_71101_ActivityTips = {
    Text = [[
<Title:Resumen del Evento>
Texto temporal]]
  },
  Activity_71101_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_71102_ActivityName = {
    Text = "Magia de la historia·Reproducción"
  },
  Activity_71102_ActivityPlot = {
    Text = "Las tareas asignadas por la muñeca nunca son simples.\nIncluso si ella ha recordado varias veces a todos \"diviértanse\", ¿cómo puede el guardián no estar asustado al llevar por primera vez un grupo de despertadores a salir?\nPero, recuerda \"divertirse\""
  },
  Activity_71102_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Tienda de guiones mágicos\""
  },
  Activity_71102_ActivityTips = {
    Text = "<Title:Resumen del evento>\n1. ¡El evento de jugabilidad \"La magia de la historia\" regresa por tiempo limitado! ¡Los Guardianes pueden acceder a la \"Tienda de guiones mágicos\" y \"Recompensas de logros\" para obtener la Rueda del destino exclusiva del evento \"Magia de 35 mm\" y el avatar exclusivo del evento \"Por la Llave de Plata: Lily\" una vez más!\n2. Durante el evento, \"Operación Especial: La magia de la historia\" estará disponible con acceso gratuito por tiempo limitado.\n\n<Title:Duración del evento>\n1. Del 3 de junio, 9:00 al 17 de junio, 9:00 (GMT+8), se puede participar en todo el contenido de la introducción del evento.\n2. Del 17 de junio, 9:00 al 24 de junio, 9:00 (GMT+8), solo la \"Tienda de guiones mágicos\" y las \"Recompensas de logros\" permanecerán accesibles; el resto del contenido habrá terminado y no se podrá participar.\n\n<Title:Misterio del guion>\n1. \"Misterio del guion\" consta de 9 niveles de materiales, con un nivel desbloqueándose automáticamente cada día. Tras desbloquearse, debes pasar el nivel de Operación Especial anterior para desafiarlo.\n2. Cada desafío consume 60 puntos de Morfina. Los desafíos exitosos te recompensan con la moneda del evento \"Inspiración errante\" y materiales de cultivo. Pasar los niveles de materiales en este evento admite recreación.\n3. Puedes usar el apoyo de Alumni y \"Resonancia: valor de fase del Director\" para pasar los niveles más fácilmente.\n\n<Title:Bonificación de Inspiración>\n1. Los Guardianes con Cuerpos Despertados o Ruedas del destino específicos (no se requieren en la Formación) obtienen bonificaciones adicionales de obtención de \"Inspiración errante\" en las recompensas de tarea de \"Misterio del guion\" (incluyendo recreación). Las bonificaciones específicas son las siguientes:\nCuerpo Despertado \"Lily\": Despertar Espiritual 0/1/2/3 y superior, bonificación 20%/30%/40%/50%\nRueda del destino SSR \"Transgresión del Sufrimiento\": Acumulación 0/1/2/3 y superior, bonificación 20%/30%/40%/50%\nRueda del destino SR \"Magia de 35 mm\": Acumulación 0/1/2/3 y superior, bonificación 20%/30%/40%/50%\n2. Las \"Bonificaciones de Inspiración\" de diferentes Cuerpos Despertados o Ruedas del destino se acumulan.\n\n<Title:Resonancia: valor de fase del Director>\n1. Los Guardianes pueden adquirir \"Corazón de la interpretación\" completando logros del evento.\n2. Consumir \"Corazón de la interpretación\" para activar \"Resonancia: valor de fase del Director\" hace a los Guardianes más fuertes en la jugabilidad del evento \"Misterio del guion\" y \"Operación Especial: La magia de la historia,\" y mejora las recompensas de \"Inspiración errante\" y Tasa de sincronización obtenidas tras completar los desafíos de \"Misterio del guion\".\n\n<Title:Recompensas de logros>\n1. Completar tareas de logros otorga el avatar exclusivo del evento \"Por la Llave de Plata: Lily,\" la moneda del evento \"Inspiración errante,\" y Plata.\n2. Incluye 25 tareas: pasar cada nivel de \"Misterio del guion\" una vez, usar cada equipo de Reino para pasar \"Misterio del guion\" 1/2 veces, pasar cada evento de investigación en \"Operación Especial: La magia de la historia\" una vez, y completar todos los logros del evento.\n\n<Title:Operación Especial>\n1. Durante el evento, \"Operación Especial: La magia de la historia\" se puede desbloquear de forma gratuita.\n2. En \"Operación Especial: La magia de la historia,\" los Guardianes desafiarán usando una configuración de equipo especial que incluye el preset de historia \"Lily.\"\n\n<Title:Compensación de Renacimiento>\n1. Los Guardianes que previamente desbloquearon \"Operación Especial: La magia de la historia\" recibirán una compensación de \"Inspiración errante\" *1000 al volver a desbloquear durante este evento de Renacimiento.\nLos Guardianes que previamente obtuvieron el avatar exclusivo del evento \"Por la Llave de Plata: Lily\" convertirán automáticamente cualquier recompensa repetida en \"Inspiración errante\" *3000.\nLos Guardianes que previamente obtuvieron el material de activación de Resonancia \"Corazón de la interpretación\" convertirán automáticamente cada \"Corazón de la interpretación\" adicional obtenido en \"Rosa Dorada\" *5000.\n"
  },
  Activity_71102_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_71325_ActivityName = {
    Text = "Poema sin nombre"
  },
  Activity_71325_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Poema Sin Nombre\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Horla para experimentar niveles designados infinitamente.\n·Mientras experimentan niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_71329_ActivityName = {
    Text = "Flor de lodo"
  },
  Activity_71329_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Flor del Pantano\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Lily para experimentar niveles designados infinitamente.\n·Al jugar los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_71743_ActivityName = {
    Text = "Cazadora de cráneos"
  },
  Activity_71743_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Cazadora de Calaveras\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Narciso para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_71744_ActivityName = {
    Text = "Obispo de bálsamos"
  },
  Activity_71744_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Obispo Benevolente\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan a Salvador para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_71745_ActivityName = {
    Text = "Señora de rojo"
  },
  Activity_71745_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Dama Roja\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Sorel para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_71746_ActivityName = {
    Text = "Dama de las profundidades"
  },
  Activity_71746_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n· Durante el evento \"Dama Aequor\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyan a Murphy para experimentar niveles designados de manera infinita.\n· Durante la experiencia de los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n· Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_71747_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_71956_ActivityName = {
    Text = "Regalo de ascenso X"
  },
  Activity_71956_ActivityPlot = {
    Text = "El camino se extiende largo, envuelto en la oscuridad de la Disolución.\nLa luz de la Llave de plata nos guiará a todos."
  },
  Activity_71957_ActivityName = {
    Text = "Regalo de ascenso IX"
  },
  Activity_71957_ActivityPlot = {
    Text = "El camino se extiende largo, envuelto en la oscuridad de la Disolución.\nLa luz de la Llave de plata nos guiará a todos."
  },
  Activity_71982_ActivityName = {
    Text = "Resonancia del Alma"
  },
  Activity_71982_ActivityPlot = {
    Text = "Llegas a la oficina del director, solo para descubrir que la sala está vacía. Parece que la carta era solo una broma.\nJusto cuando estás a punto de irte, vislumbras una exquisita caja de regalo en la esquina de tu campo de visión, con una nota adjunta — Para mi amado/a."
  },
  Activity_71983_ActivityName = {
    Text = "Vigilar el regalo del destino"
  },
  Activity_71983_ActivityPlot = {
    Text = "Un chasquido resuena en la silenciosa habitación. Cuando te acercas a investigar, la ventana abierta revela que el \"Invitado indeseado\" ya se ha marchado.\nLa cálida luz del sol cae sobre una caja de regalo adicional en el escritorio, cuya elegante caligrafía brilla con luz plateada — Que el Destino te Bendiga por siempre."
  },
  Activity_72101_ActivityName = {
    Text = "Inversión de fase"
  },
  Activity_72101_ActivityPlot = {
    Text = "\"¡Quiero que todos jueguen a la Carta de Cartas Wanxiang!\"\nUn visitante de otro espacio-temporal entró en el espacio de Fase de Duelo debido a un accidente, transformándolo en algo muy diferente a su forma original.\nPara revertir el espacio nuevamente, los Guardianes del Secreto de diferentes espacios-temporales deben decidir quién es el más fuerte y desafiar a este visitante."
  },
  Activity_72101_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Secret Keepers pueden completar logros en «Fase de Duelo» para obtener recompensas en «Recompensas de logro» y recibir «Bellotas mágicas».\n2. Las «Bellotas mágicas» se pueden usar en «Recompensa por turnos» para obtener diversas recompensas, incluyendo el avatar limitado «Turno invertido: Cartas multiversales», 10 expresiones limitadas del evento, así como «Sueño fragmentado» y «Sueño estelar», entre otros.\n3. Durante el evento, ¡«Conexión multidimensional: Turno invertido» estará disponible de forma gratuita!\n4. Durante el evento, los Secret Keepers que hayan completado «Conexión multidimensional: Turno invertido: Invitado del otro mundo» tendrán el fondo de batalla de «Fase de Duelo» reemplazado temporalmente por «Turno invertido: Espacio consciente».\n\n<Title:Recompensas de logro>\n1. Las «Recompensas de logro» incluyen logros de victoria con «Entidad despierta», logros de victoria con «Rueda del destino», logros de victoria con «Sello clave» y logros por cantidad de cartas jugadas. Los Secret Keepers pueden recibir «Bellotas mágicas» al completar dichos logros.\n2. Usar distintas «Entidades despiertas» en «Fase de Duelo» y jugar 25 cartas otorga 30 «Bellotas mágicas». Cada logro de cantidad de cartas por clase puede completarse un máximo de 80 veces.\n3. Logro «Entidad despierta»: Cada «Entidad despierta» obtiene 10 «Bellotas mágicas» al lograr 1/3/6/10 victorias en «Fase de Duelo».\n4. Logro «Rueda del destino»: Cada «Rueda del destino» obtiene 10 «Bellotas mágicas» al lograr 1/3/6 victorias en «Fase de Duelo».\n5. Logro «Sello clave»: Cada «Sello clave» obtiene 10 «Bellotas mágicas» al lograr 1/3/6 victorias en «Fase de Duelo».\n6. Las «Entidades despiertas», «Ruedas del destino» y «Sellos clave» desbloqueados temporalmente mediante temas principales también contarán normalmente las victorias y cartas jugadas, pero deberás poseer dicha «Entidad despierta», «Rueda del destino» o «Sello clave» para poder reclamar las recompensas de logro.\n\n<Title:Recompensa por turnos>\n1. Los Secret Keepers pueden recibir recompensas acumulando «Bellotas mágicas». Al acumular 2500 «Bellotas mágicas» se obtienen todas las recompensas principales, y al acumular 5000 «Bellotas mágicas» se obtienen todas las recompensas disponibles.\n2. Al completar «Turno invertido: Invitado del otro mundo» se desbloquean las recompensas por acumular entre 100 y 900 «Bellotas mágicas». Al completar «Turno invertido: El instante de invertir todo» se desbloquean las recompensas por acumular entre 1000 y 5000 «Bellotas mágicas».\n\n<Title:Conexión multidimensional>\n1. Durante el evento, «Conexión multidimensional: Turno invertido» estará disponible de forma gratuita.\n2. Durante el evento, será necesario acumular 1000 «Bellotas mágicas» para desbloquear «Turno invertido: La absoluta voluntad».\n3. Tras finalizar el evento, se conservará el progreso en «Conexión multidimensional: Turno invertido». Si no se desbloqueó durante el evento, aún será posible desbloquearlo tras finalizar consumiendo 3 «Punto de partida real».\n4. Independientemente de si es durante o fuera del evento, al completar «Conexión multidimensional: Turno invertido» se obtiene «Sello clave: Puerta de la taberna».\n\n<Title:Duración del evento>\nEste evento solo estará disponible del 18 de marzo 9:00 al 1 de abril 9:00 (GMT+8). Tras finalizar el evento el 1 de abril a las 9:00 (GMT+8), recuerda reclamar las recompensas en «Recompensa por turnos»."
  },
  Activity_72101_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_72101_UnlockConditionExplanation = {
    Text = "Completar \"Operación\" 3-2 · Normal Desbloqueado"
  },
  Activity_73680_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_73680_ActivityPlot = {
    Text = "Después de la compra, \"fusión·dor\" se puede activar\n<BlueQuality: Profundización de la personalidad +4, desbloquear sobreexaltación>"
  },
  Activity_73681_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_73681_ActivityPlot = {
    Text = "Después de la compra, \"Fusión·Dor\" se puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_73879_ActivityName = {
    Text = "Alineación de las estrellas · Réplica"
  },
  Activity_73879_ActivityPlot = {
    Text = "El momento de la alineación de las estrellas está por llegar, las primeras vibraciones en su vientre se sienten como un tambor.\nLos pesares de las noches oscuras que la atormentaron durante años están a punto de llegar a su fin, acompañados por el llanto de inumerables creyentes.\nDesde su @1 oscuridad @2, la gran @3 descenderá al mundo"
  },
  Activity_73879_ActivityStageEndContent = {
    Text = "La actividad ha terminado, actualmente solo puedes participar en \"eclosión del embrión sagrado\""
  },
  Activity_73879_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los guardianes podrán recolectar tres tipos de \"embriones\" a través del modo temporal \"Útero oscuro\" y las \"Recompensas por logro\". Estos embriones podrán canjearse por recompensas en objetos dentro de \"Eclosión del feto sagrado\", incluyendo la rueda de destino SR exclusiva del evento \"Sueño bajo el glaciar\", núcleo puro, núcleo de luz, Fragmentos de La Sabia, cristal de mimetismo, entre otros.\n2. Durante el evento, completar las tareas de \"Recompensas por logro\" permitirá obtener el retrato exclusivo del evento \"En nombre de la llave plateada: Murphy\", la rueda de destino SR exclusiva del evento \"Sueño bajo el glaciar\" y una gran cantidad de \"embriones\".\n\n<Title:Duración del evento>\n1. Del 10 al 24 de marzo a las 9:00 (GMT+8), todas las actividades estarán disponibles.\n2. Del 24 de marzo a las 9:00 al 31 de marzo a las 9:00 (GMT+8), solo permanecerán disponibles \"Eclosión del feto sagrado\" y \"Recompensas por logro\", el resto de contenidos finalizarán y ya no serán accesibles.\n\n<Title:Útero oscuro>\n1. \"Útero oscuro\" contiene 7 etapas, abriéndose una automáticamente cada día.\n2. Cada desafío consumirá 120 puntos de neuropéptido, y al superarlo se obtendrán las monedas del evento \"Embriones sin conocimiento\", \"Embriones sin deseo\" y \"Embriones insaciables\".\n3. Al completar una etapa, se desbloqueará su función de \"Repetición\". Por favor, ten en cuenta que al usar la función \"Repetición\" no se obtendrá tasa de sincronización.\n4. Puedes usar la ayuda de los Alumnis para facilitar el paso de las etapas.\n5. Al completar cualquier dificultad de una etapa, se desbloqueará la dificultad \"Locura\". Al superar por primera vez la dificultad \"Locura\" se obtendrá una generosa recompensa en monedas del evento.\n6. Por favor, ten en cuenta que la dificultad \"Locura\" no consume neuropéptido, no permite repetición y al repetir el desafío tras el primer paso ya no se obtendrán recompensas en monedas del evento.\n\n<Title:Bonificación de embriones>\n1. Cuando los guardianes posean ciertos cuerpos despiertos o ruedas de destino (no es necesario tenerlos activados), se obtendrá una bonificación adicional en la obtención de \"Embriones sin conocimiento\", \"Embriones sin deseo\" y \"Embriones insaciables\" como recompensa en las misiones de las etapas de \"Útero oscuro\" (incluyendo la repetición). Las bonificaciones específicas son las siguientes:\n· Cuerpo despierto \"Murphy\": Despertar Espiritual 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\n· Rueda de destino SSR \"Nacimiento secreto\": Superposición 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\n· Rueda de destino SR \"Sueño bajo el glaciar\": Superposición 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\n2. Las bonificaciones de \"Bonificación de embriones\" de distintos cuerpos despiertos o ruedas de destino se acumulan.\n3. Especialmente, las recompensas por primera superación de la dificultad \"Locura\" no se verán afectadas por la \"Bonificación de embriones\".\n\n<Title:Eclosión del feto sagrado>\n1. \"Eclosión del feto sagrado\" solo estará disponible del 10 al 31 de marzo a las 9:00 (GMT+8).\n2. Tras las 9:00 del 31 de marzo (GMT+8), los \"embriones\" restantes que no hayan sido canjeados se reciclarán a razón de \"Vale de Rosa Dorada*40\" por cada uno. Por favor, recuerda revisar tu correo para recibir la compensación."
  },
  Activity_73879_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_74213_ActivityName = {
    Text = "Homenaje al Recuerdo del Viaje · Cápítulo de las Estrellas I"
  },
  Activity_74213_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_74340_ActivityName = {Text = "Mi turno"},
  Activity_74364_ActivityName = {
    Text = "Manual del gran detective·Replica"
  },
  Activity_74364_ActivityPlot = {
    Text = "Un manual ordinario.\nRegistra las experiencias de un detective durante años.\nEspero que inspire a los jóvenes aspirantes a detectives"
  },
  Activity_74364_ActivityStageEndContent = {
    Text = "El evento ha terminado. Actualmente, solo \"Club de Buena Suerte\" está disponible."
  },
  Activity_74364_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes podrán recolectar la moneda del evento \"Fichas decisivas\" a través de las actividades limitadas \"Leyenda de la noche lunar\" y \"Recompensas por logros\". Las \"Fichas decisivas\" podrán canjearse por generosas recompensas en el \"Club de la Suerte\", incluyendo la Rueda del destino SR exclusiva del evento \"Ruleta del Destino\", Núcleo Puro, Núcleo de Lumen, Fragmentos de Piedra Sabia y Cristal de Mimesis, etc.\n2. Durante el evento, completar las tareas de \"Recompensas por logros\" permitirá obtener el avatar exclusivo del evento \"Con la Llave de plata: Ryker\", la Rueda del destino SR exclusiva \"Ruleta del Destino\", Núcleo de plata y una gran cantidad de moneda del evento \"Fichas decisivas\".\n3. Durante el evento, \"Registro de la fuerza especial: Buena caza!\" estará disponible de forma gratuita.\n\n<Title:Duración del evento>\n1. Del 22 de septiembre a las 9:00 al 6 de octubre a las 9:00 (GMT+8): todas las actividades del evento estarán disponibles.\n2. Del 6 de octubre a las 9:00 al 13 de octubre a las 9:00 (GMT+8): solo permanecerán disponibles el \"Club de la Suerte\" y las \"Recompensas por logros\"; el resto de contenidos finalizarán y no estarán disponibles.\n\n<Title:Leyenda de la noche lunar>\n1. \"Leyenda de la noche lunar\" contiene 9 etapas, se abre 1 automáticamente cada día.\n2. Cada desafío consumirá 120 puntos de neuropéptido. Al desafiar diferentes etapas, además de obtener distintos materiales, también se obtendrán \"Fichas decisivas\".\n3. En esta ocasión, las etapas del evento son etapas de materiales de combate y podrán \"repetirse\" tras completarlas. Cada \"repetición\" consumirá 120 puntos de neuropéptido.\n4. Por favor, tenga en cuenta: al usar la función \"repetición\", no se obtendrá tasa de sincronización.\n\n<Title:Bonificación de fichas>\n1. Los Guardianes que posean ciertos Cuerpos Despertados o Ruedas del destino específicas (no es necesario tenerlos en batalla) podrán obtener una bonificación adicional de \"Fichas decisivas\" en las recompensas de las etapas de \"Leyenda de la noche lunar\" (incluyendo la repetición). Las bonificaciones específicas son las siguientes:\nCuerpo Despertado \"Ryker\": Despertar Espiritual 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\nRueda del destino SSR \"Hora de la Fortuna\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\nRueda del destino SR \"Ruleta del Destino\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\n2. Las bonificaciones de \"Bonificación de fichas\" de diferentes Cuerpos Despertados o Ruedas del destino se aplicarán de forma acumulativa.\n3. Especialmente, las recompensas por primera vez al completar en dificultad locura no se verán afectadas por la \"Bonificación de fichas\".\n\n<Title:Club de la Suerte>\n1. \"Club de la Suerte\" solo estará disponible del 22 de septiembre a las 9:00 al 13 de octubre a las 9:00 (GMT+8).\n2. Tras las 9:00 del 13 de octubre (GMT+8), las \"Fichas decisivas\" restantes que no se hayan canjeado se reciclarán a razón de \"Rosa Dorada ×40\" por ficha. Por favor revise su correo.\n\n<Title:Registro de la fuerza especial>\n1. Durante el evento, \"Registro de la fuerza especial: Buena caza!\" estará disponible de forma gratuita.\n2. Tras finalizar el evento, se conservará el progreso de investigación de \"Registro de la fuerza especial: Buena caza!\". Si no se desbloqueó durante el evento, podrá desbloquearse consumiendo 7 \"Punto de partida real\".\n3. Independientemente de si es durante el evento o no, tras completar \"Registro de la fuerza especial: Buena caza!\" se obtendrá \"Posse: El grito de un arma\".\n\n<Title:Compensación por repetición>\n1. Los Guardianes que ya hayan desbloqueado anteriormente \"Registro de la fuerza especial: Buena caza!\" obtendrán una compensación de \"Fichas decisivas\" ×700 al desbloquearlo nuevamente durante este evento.\n2. Los Guardianes que ya hayan obtenido anteriormente el avatar exclusivo del evento \"Con la Llave de plata: Ryker\", al obtenerlo nuevamente se convertirá automáticamente en \"Invitación del invisible\" ×1."
  },
  Activity_74364_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_74365_ActivityName = {
    Text = "Buena caza!"
  },
  Activity_76217_ActivityName = {
    Text = "Viaje dimensional del nuevo siglo"
  },
  Activity_76217_ActivityTips = {
    Text = "Reglas del evento: \n1. Los Secret Keepers que completen las tareas designadas del viaje dimensional pueden reclamar recompensas en \"Siglo de Viaje Dimensional\". \n2. \"Siglo de Viaje Dimensional\" está siempre disponible. \n3. Al desbloquear el \"Viaje Avanzado\", podrás obtener recompensas adicionales al completar las misiones. \n4. Ten en cuenta: el \"Viaje Avanzado\" desbloqueado en este evento solo es válido durante este evento. Por favor, gestiona tus recursos con prudencia."
  },
  Activity_76218_ActivityName = {
    Text = "Llegada: Crónica"
  },
  Activity_76218_ActivityTips = {
    Text = "Reglas del evento: \n1. Los Secret Keepers que completen las tareas designadas pueden reclamar recompensas en \"Crónica de la Llegada\". \n2. \"Crónica de la Llegada\" está siempre disponible. \n3. Después de desbloquear \"Viaje Avanzado\", puedes obtener recompensas adicionales al completar las tareas. \n4. Ten en cuenta: El \"Viaje Avanzado\" desbloqueado en este evento solo es válido durante este evento. Por favor, realiza compras razonablemente según tus necesidades."
  },
  Activity_77970_ActivityName = {Text = "Pólux"},
  Activity_77970_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento «Pollux», los Guardianes pueden utilizar equipos preestablecidos del sistema que incluyan a Pollux para experimentar sin límite las misiones designadas.\n· Al jugar las misiones del evento, no se puede ajustar el orden de los personajes despiertos en el equipo.\n<Title:Recompensas del evento>\n· Al completar por primera vez una misión del evento, se podrá reclamar una recompensa de prueba en la interfaz del evento."
  },
  Activity_77972_ActivityName = {
    Text = "Shaggai hipnótico"
  },
  Activity_77972_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento \"Insecto hipnótico\", los guardianes pueden utilizar equipos preestablecidos del sistema que incluyan a Clementine para repetir ilimitadamente las etapas designadas.\n· Durante la experiencia en las etapas del evento, no es posible ajustar la formación de los Cuerpos Despiertos.\n<Title:Recompensas del evento>\n· Al completar por primera vez el desafío de la etapa, se pueden reclamar las recompensas de prueba en la interfaz del evento."
  },
  Activity_77974_ActivityName = {
    Text = "Brillo de Mareel"
  },
  Activity_77974_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento «Luz Fría», los Secret Keepers pueden utilizar equipos preestablecidos del sistema que incluyen a Kepeshiant para repetir de forma ilimitada los niveles designados.\n· Durante la experiencia de las misiones del evento, no es posible ajustar los Cuerpos Despiertos dentro del equipo.\n<Title:Recompensas del evento>\n· Al completar por primera vez el desafío de una misión, se podrá reclamar una recompensa de prueba desde la interfaz del evento.\n"
  },
  Activity_77977_ActivityName = {
    Text = "Blancanieves el Hada"
  },
  Activity_77977_ActivityTips = {
    Text = "<Title:Reglas del evento>\nDurante el evento \"Blancanieves el Hada\", los Gardianes del secreto pueden usar equipos preestablecidos por el sistema que incluyan a \"Caraboo\" para experimentar las fases designadas un número ilimitado de veces.\n Al experimentar las fases del evento, los Despertados del equipo no pueden ser ajustados.\n<Title:Recompensas del evento>\nTras completar el desafío de la fase por primera vez, puedes reclamar las recompensas de prueba en la interfaz del evento."
  },
  Activity_77979_ActivityName = {
    Text = "Señor de la Explosión"
  },
  Activity_77979_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento \"Señor de la Explosión\", los Guardianes pueden utilizar equipos predeterminados del sistema que incluyen a Katyura para experimentar niveles designados sin límite de veces.\n· Durante la experiencia en las misiones del evento, no se permite ajustar el Despertador dentro del equipo.\n<Title:Recompensas del evento>\n· Al completar el desafío de la misión por primera vez, podrás reclamar la recompensa de prueba en la interfaz del evento."
  },
  Activity_77980_ActivityName = {
    Text = "Tela Perpetua"
  },
  Activity_77980_ActivityTips = {
    Text = "<Title:Reglas del evento>\nDurante el evento \"Tela Perpetua\", los Guardianes del secreto pueden usar equipos predefinidos que incluyan a Aracne para experimentar los niveles designados sin límite de veces.\nAl experimentar los niveles del evento, no se puede ajustar los Despertados en la formación.\n<Title:Recompensas del evento>\nDespués de completar el desafío del nivel por primera vez, se pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_77984_ActivityName = {Text = "El pintor"},
  Activity_77984_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el periodo de la actividad \"Pintor\", los Guardianes pueden utilizar equipos preestablecidos del sistema que incluyan a Pickman para experimentar niveles designados sin límite. \n· Al experimentar niveles de la actividad, no se pueden ajustar los Despertados en el equipo. \n<Title:Recompensas del evento>\n· Después de completar el desafío del nivel por primera vez, se pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_78501_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_78501_ActivityPlot = {
    Text = "Después de la compra, \"faraón negro\" se puede activar\n<BlueQuality:Profundidad de personalidad +4, desbloquear sobreexaltación>"
  },
  Activity_78502_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_78502_ActivityPlot = {
    Text = "Después de la compra, \"Arachne\" puede activar\n<BlueQuality:Desarrollo de la personalidad +4, desbloquear sobreexaltar>"
  },
  Activity_78503_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_78503_ActivityPlot = {
    Text = "Después de la compra, \"Kepsant\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_78505_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_78505_ActivityPlot = {
    Text = "Después de la compra, \"Clementine\" puede activar\n<BlueQuality:Profundización de Personalidad +4, Desbloquear Sobreesaltación>"
  },
  Activity_78506_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_78506_ActivityPlot = {
    Text = "Después de la compra, \"Faraón Negro\" se puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_78507_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_78507_ActivityPlot = {
    Text = "Después de la compra, \"Buitre\" se puede activar<BlueQuality:Iluminar 3>"
  },
  Activity_78508_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_78508_ActivityPlot = {
    Text = "Después de la compra, \"Afrogemon\" se puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_78509_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_78509_ActivityPlot = {
    Text = "Después de la compra, \"Pólux\" se puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_78511_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_78511_ActivityPlot = {
    Text = "Después de la compra, \"Karabu\" se puede activar\n<BlueQuality:Profundidad de personalidad +4, desbloquear sobreexaltación>"
  },
  Activity_78513_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_78513_ActivityPlot = {
    Text = "Después de la compra, \"Arachne\" puede activar <BlueQuality:Despertar Espiritual 3>"
  },
  Activity_78514_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_78514_ActivityPlot = {
    Text = "Después de la compra, \"Pickman\" se puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_78515_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_78515_ActivityPlot = {
    Text = "Después de la compra, \"Pickman\" se puede activar\n<BlueQuality:Profundidad de personalidad +4, desbloquear sobreexaltación>"
  },
  Activity_78516_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_78516_ActivityPlot = {
    Text = "Después de la compra, \"Clementine\" se puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_78517_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_78517_ActivityPlot = {
    Text = "Después de la compra, \"Kepsante\" se puede activar\n<BlueQuality:Profundidad de personalidad +4, desbloquear sobreexaltación>"
  },
  Activity_78518_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_78518_ActivityPlot = {
    Text = "Después de la compra, \"Buitre\" se puede activar\n<BlueQuality:Profundidad de personalidad +4, desbloquear sobreexaltación>"
  },
  Activity_78519_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_78519_ActivityPlot = {
    Text = "Después de la compra, \"Shartak\" se puede activar\n<BlueQuality:Profundidad de personalidad +4, desbloquear sobreexaltación>"
  },
  Activity_78521_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_78521_ActivityPlot = {
    Text = "Después de la compra, \"Pólux\" se puede activar\n<BlueQuality:Profundidad de personalidad +4, desbloquear sobreexaltación>"
  },
  Activity_78523_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_78523_ActivityPlot = {
    Text = "Después de la compra, \"Afrogemon\" se puede activar\n<BlueQuality:Profundidad de personalidad +4, desbloquear sobreexaltación>"
  },
  Activity_78524_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_78524_ActivityPlot = {
    Text = "Después de la compra, \"Lantigos\" se puede activar\n<BlueQuality:Profundidad de personalidad +4, desbloquear sobreexaltación>"
  },
  Activity_78525_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_78525_ActivityPlot = {
    Text = "Después de la compra, \"Castor\" puede activar\n<BlueQuality:Profundización de Personalidad +4, Desbloquear Sobreesaltación>"
  },
  Activity_78526_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_78526_ActivityPlot = {
    Text = "Después de la compra, \"Catigura\" se puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_78531_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_78531_ActivityPlot = {
    Text = "Después de la compra, \"Shathak\" se puede activar<BlueQuality:Iluminar 3>"
  },
  Activity_78532_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_78532_ActivityPlot = {
    Text = "Después de la compra, \"Karabu\" puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_78533_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_78533_ActivityPlot = {
    Text = "Después de la compra, \"Castor\" se puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_78534_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_78534_ActivityPlot = {
    Text = "Después de la compra, \"Lantigos\" se puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_78536_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_78536_ActivityPlot = {
    Text = "Después de la compra, \"Catigura\" se puede activar\n<BlueQuality:Profundidad de personalidad +4, desbloquear sobreexaltación>"
  },
  Activity_78651_ActivityName = {
    Text = "Fisión Tranquila"
  },
  Activity_78652_ActivityName = {
    Text = "Sanación múltiple · Réplica"
  },
  Activity_78652_ActivityPlot = {
    Text = "Hysteria, también conocida como histeria.\nEn su época, era sinónimo de muerte.\n\nAfortunadamente, los científicos e investigadores de mitag están igualmente locos: están decididos a resolver este problema"
  },
  Activity_78652_ActivityStageEndContent = {
    Text = "El evento ha terminado. Actualmente, solo \"Análisis de Personalidad\" está disponible."
  },
  Activity_78652_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los guardianes podrán recolectar la moneda del evento \"Puzle de Memoria\" a través de las actividades por tiempo limitado \"Codificación de Memoria\", \"Almacenamiento Periférico\" y \"Recompensas de Logro\". Los \"Puzle de Memoria\" podrán ser utilizados en \"Análisis de Personalidad\" para comprar artículos, incluyendo la Rueda del destino limitada SR \"Determinación del Bacalao Plateado\", Núcleo Puro, Núcleo de Lumen y otros. \n2. Durante el evento, el \"Registro Especial: La Fisión Tranquila\" estará disponible gratuitamente por tiempo limitado. ¡Al completar los logros del evento también podrás obtener el avatar exclusivo \"En Nombre de la Llave de plata: '\"24\"'\"!\n\n<Title:Duración del evento>\n1. Del 21 de abril a las 9:00 al 5 de mayo a las 9:00 (GMT+8), todas las actividades del evento estarán disponibles. \n2. Del 5 de mayo a las 9:00 al 12 de mayo a las 9:00 (GMT+8), solo será posible participar en \"Análisis de Personalidad\" y en las recompensas de logro.\n\n<Title:Codificación de Memoria>\n1. \"Codificación de Memoria\" contiene 5 niveles, cada 2 días se desbloqueará automáticamente uno. \n2. Cada intento consumirá 120 puntos de neuropéptido, y al tener éxito en el desafío obtendrás moneda del evento. \n3. Una vez completado el nivel, se desbloqueará la función \"Repetición\" de dicho nivel. Ten en cuenta: al usar la función \"Repetición\", no se obtendrá tasa de sincronización. \n4. Puedes usar el apoyo de Alumnis y la \"Resonancia: Síndrome de Disociación\" para ayudarte a pasar los niveles más fácilmente.\n\n<Title:Bonificación Racional>\n1. Si el Guardián posee ciertos Cuerpos Despertados o Ruedas del destino (no es necesario tenerlos activados), obtendrá una bonificación adicional en los \"Puzle de Memoria\" que se obtienen como recompensa en las misiones de los niveles de \"Codificación de Memoria\". Las bonificaciones específicas son las siguientes: \nCuerpo Despertado \"\"24\"\": Despertar Espiritual 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%. \nRueda del destino SSR \"Restitución de la forma alterada\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%. \nRueda del destino SR \"Determinación del Bacalao Plateado\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%. \n2. Las \"Bonificaciones Racionales\" de diferentes Cuerpos Despertados o Ruedas del destino se aplican de forma acumulativa. \n3. Especialmente, las recompensas por primera vez en dificultad Locura no se ven afectadas por la \"Bonificación Racional\".\n\n<Title:Resonancia: Síndrome de Disociación>\n1. Los guardianes pueden obtener \"Corazón dividido\" completando logros del evento. \n2. Al consumir \"Corazón dividido\", puedes activar la \"Resonancia: Síndrome de Disociación\", lo que te permitirá obtener las siguientes bonificaciones: \n(1) Hace que el Guardián sea más fuerte en las actividades del evento \"Codificación de Memoria\" y \"Registro Especial: La Fisión Tranquila\", facilitando los desafíos. \n(2) Mejora las recompensas obtenidas tras completar los desafíos de \"Codificación de Memoria\". \n(3) Activa la actividad \"Almacenamiento Periférico\".\n\n<Title:Almacenamiento Periférico>\n1. Tras activar la resonancia \"Diagnóstico: Fisura de personalidad\", se obtienen automáticamente 60 \"Puzzle de Memoria α\" por hora, con un máximo de almacenamiento de 25 horas. \n2. Tras activar la resonancia \"Alineación Cognitiva\", se obtienen automáticamente 30 \"Puzzle de Memoria β\" por hora, con un máximo de almacenamiento de 25 horas.\n\n<Title:Registro Especial>\n1. Durante el evento, el \"Registro Especial: La Fisión Tranquila\" podrá desbloquearse gratuitamente. \n2. Al finalizar el evento, se conservará el progreso de investigación del \"Registro Especial: La Fisión Tranquila\", y tras completar los eventos de investigación no terminados durante el evento también podrás obtener las mismas recompensas que durante el evento. Si no desbloqueaste el \"Registro Especial: La Fisión Tranquila\" durante el evento, aún podrás desbloquearlo tras el evento consumiendo 7 \"Punto de partida real\". \n3. Independientemente de si es durante el evento o no, tras completar el \"Registro Especial: La Fisión Tranquila\" podrás obtener el \"Sello de Llave: Toda ella\".\n\n<Title:Compensación por Recuperación>\n1. Los guardianes que ya hayan desbloqueado anteriormente el \"Registro Especial: La Fisión Tranquila\" recibirán una compensación de 700 \"Puzzle de Memoria α\" al desbloquearlo nuevamente durante este evento de recuperación. \n2. Los guardianes que ya hayan obtenido anteriormente el avatar exclusivo del evento \"En Nombre de la Llave de plata: '\"24\"'\", al obtenerlo nuevamente se convertirá automáticamente en 1 \"Invitación del Ser Inmaterial\". \n3. Los guardianes que ya hayan obtenido anteriormente el material para activar la resonancia \"Corazón dividido\", por cada \"Corazón dividido\" adicional obtenido, se convertirá automáticamente en 5000 \"Rosa Dorada\".\n"
  },
  Activity_78652_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_78722_ActivityName = {
    Text = "Murmuró el insecto en la oscuridad · Preventa por tiempo limitado"
  },
  Activity_78722_ActivityTips = {
    Text = "<Title: Murmullo de Insectos en la Oscuridad: Precompra Temporal>\n·La actividad de precompra temporal incluye 8 paquetes, de los cuales el primero puede reclamarse directamente de forma gratuita; los paquetes del 2 al 8 solo podrán reclamarse tras adquirir \"Murmullo de Insectos en la Oscuridad: Precompra Temporal\".\n·Tras adquirir \"Murmullo de Insectos en la Oscuridad: Precompra Temporal\", podrás reclamar inmediatamente la recompensa del segundo paquete; los paquetes siguientes deberán esperar un determinado periodo de tiempo antes de poder ser reclamados.\n·La compra de \"Murmullo de Insectos en la Oscuridad: Precompra Temporal\" tiene una fecha límite; una vez vencida, ya no será posible adquirirla. Por favor, realiza la compra con prudencia antes del 7 de abril a las 9:00."
  },
  Activity_78751_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_78751_ActivityPlot = {
    Text = "Después de la compra, \"Señor del Sueño Primordial\" se puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_78752_ActivityName = {
    Text = "Texto temporal"
  },
  Activity_78752_ActivityTips = {
    Text = "<Title:Reglas del evento>\nDurante el evento \"Origen: Poder Real\", los Gardianes del secreto pueden usar equipos preestablecidos por el sistema que incluyan a Origen: Poder Real para experimentar los niveles designados un número ilimitado de veces.\nAl experimentar los niveles del evento, no se pueden realizar ajustes a los Despertados en la formación del equipo.\n<Title:Recompensas del evento>\nTras completar el desafío del nivel por primera vez, puedes reclamar las recompensas de demostración en la interfaz del evento."
  },
  Activity_78753_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_78753_ActivityPlot = {
    Text = "Después de la compra, \"Señor del Sueño Primordial\" se puede activar\n<BlueQuality:Profundidad de personalidad +4, desbloquear sobreexaltación>"
  },
  Activity_78776_ActivityName = {
    Text = "Origen Dama del Mar Profundo"
  },
  Activity_78776_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento \"Dama del Mar Profundo Primordial\", los Secret Keepers pueden usar equipos preestablecidos que incluyan a \"Dama del Mar Profundo Primordial\" para experimentar las etapas designadas sin límite de veces.\n· Durante las etapas del evento, no se puede ajustar la formación de entidades despiertas dentro del equipo.\n<Title:Recompensas del evento>\n· Tras completar el desafío de la etapa por primera vez, podrás reclamar la recompensa de prueba en la interfaz del evento.\n"
  },
  Activity_78777_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_78777_ActivityPlot = {
    Text = "Después de la compra, \"Dama del Mar Profundo Primordial\" se puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_78778_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_78778_ActivityPlot = {
    Text = "Después de la compra, \"Dama del Mar Profundo Primordial\" se puede activar\n<BlueQuality:Profundidad de personalidad +4, desbloquear sobreexaltación>"
  },
  Activity_78790_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_78791_ActivityName = {
    Text = "Deshielo en la montaña nevada·Reproducción"
  },
  Activity_78791_ActivityPlot = {
    Text = "La nieve y el hielo de Elworth nunca se deshacen, al igual que su odio. \n Cuando el futuro y el pasado entrelazan sus manos, el guerrero levantará su espada y cargará contra el destino en busca de venganza. \n Cuando ella se enfrente a las olas negras, eres su estandarte"
  },
  Activity_78791_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Boca de la montaña\""
  },
  Activity_78791_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes pueden recolectar tres tipos de \"brotes\" a través del modo temporal \"Corazón de bestia\" y las recompensas por logros. Los \"brotes\" pueden ser utilizados para intercambiar objetos en \"Boca Gigante de la Montaña\", incluyendo la rueda de destino SR exclusiva del evento \"Espera hasta que la nieve de la montaña se derrita\", Núcleo Puro, Núcleo de Lumen, Fragmentos de Piedra Sabia y Cristal de Mimesis.\n2. Durante el evento, el \"Registro especial: El retorno de Elworth\" estará disponible gratuitamente.\n\n<Title:Duración del evento>\n1. Del 19 de mayo a las 9:00 al 2 de junio a las 9:00 (GMT+8), todos los contenidos del evento estarán disponibles.\n2. Del 2 de junio a las 9:00 al 9 de junio a las 9:00 (GMT+8), solo permanecerán disponibles \"Boca Gigante de la Montaña\" y las \"Recompensas por logros\", los demás contenidos finalizarán y no podrán ser accedidos.\n\n<Title:Corazón de bestia>\n1. \"Corazón de bestia\" contiene 5 niveles, cada 2 días se desbloqueará automáticamente uno.\n2. Cada desafío consumirá 120 puntos de neuropéptido, y al tener éxito obtendrás la moneda del evento \"Brote helado\", \"Brote de flor plateada con escarcha\" y \"Brote de sol\".\n3. Una vez completado un nivel, se desbloqueará la función \"Recrear\" de ese nivel. Nota: Al utilizar la función \"Recrear\", no se obtendrá tasa de sincronización.\n4. Puedes utilizar aliados de la hermandad y \"Resonancia: Devorar montañas\" para facilitar la finalización.\n5. Al segundo día después de desbloquear un nivel, se desbloqueará la dificultad Locura de dicho nivel. Completar por primera vez la dificultad Locura otorgará una generosa recompensa en moneda del evento.\n6. Nota: La dificultad Locura no consume neuropéptido, no se puede recrear, y tras completarla por primera vez, los desafíos repetidos no otorgarán más recompensas en moneda del evento.\n\n<Title:Bonificación de brotes>\n1. Si los Guardianes poseen ciertos Cuerpos Despertados o Ruedas de Destino específicas (no es necesario tenerlos activos), se obtendrá una bonificación adicional en la caída de \"Brote helado\", \"Brote de flor plateada con escarcha\" y \"Brote de sol\" en las recompensas de las misiones de \"Corazón de bestia\" (incluyendo la recreación). Los detalles son los siguientes:\n· Cuerpo Despertado \"Helot: Catena\": Despertar Espiritual 0/1/2/3 o más, bonificación del 20%/30%/40%/50%\n· Rueda de Destino SSR \"Hundirse en el Carmesí\": Posición superpuesta 0/1/2/3 o más, bonificación del 20%/30%/40%/50%\n· Rueda de Destino SR \"Espera hasta que la nieve de la montaña se derrita\": Posición superpuesta 0/1/2/3 o más, bonificación del 20%/30%/40%/50%\n2. Las bonificaciones de \"Bonificación de brotes\" de diferentes Cuerpos Despertados o Ruedas de Destino se acumulan.\n3. Especialmente, las recompensas por completar por primera vez la dificultad Locura no se ven afectadas por la \"Bonificación de brotes\".\n\n<Title:Resonancia: Devorar montañas>\n1. Los Guardianes pueden obtener \"Corazón devorador\" completando logros del evento.\n2. Al consumir \"Corazón devorador\", se activa la \"Resonancia: Devorar montañas\", lo que hará que los Guardianes sean más fuertes durante el modo \"Corazón de bestia\" y los desafíos sean más fáciles.\n\n<Title:Boca Gigante de la Montaña>\n1. \"Boca Gigante de la Montaña\" tiene tres tiendas de intercambio, con los siguientes horarios de apertura:\n·\"Ambición devoradora\": Se abre el 19 de mayo a las 9:00.\n·\"Intención de venganza\": Se abre el 21 de mayo a las 9:00.\n·\"Esperanza de resurrección\": Se abre el 23 de mayo a las 9:00.\n2. Cada intercambio consumirá 750 \"Brote helado\"/\"Brote de flor plateada con escarcha\"/\"Brote de sol\", y obtendrás aleatoriamente una de las cinco recompensas disponibles en la tienda.\n3. Las recompensas de cada tienda de intercambio se dividen en \"Objeto especial\" y \"Objeto normal\". Al reiniciar, se puede restablecer la cantidad restante de \"Objeto especial\" al límite máximo. Las reglas específicas son las siguientes:\n(1) Primeros 2 reinicios: Cuando ya no quede cantidad de \"Objeto especial\", los Guardianes pueden elegir reiniciar, lo que restablecerá la cantidad restante de \"Objeto especial\" y \"Objeto normal\" al límite máximo; también pueden continuar intercambiando, y cuando ya no quede cantidad de \"Objeto normal\", deberán reiniciar para continuar intercambiando.\n(2) A partir del tercer reinicio: Solo se podrá reiniciar cuando ya no quede cantidad de \"Objeto normal\", el reinicio restablecerá la cantidad restante de \"Objeto normal\" al límite máximo, pero los \"Objeto especial\" ya no se reiniciarán.\n4. Después del 9 de junio a las 9:00 (GMT+8), los \"brotes\" restantes que no se hayan intercambiado serán recuperados a razón de cada uno canjeado por \"Rosa Dorada*40\", por favor recuerda revisar tu correo.\n\n<Title:Registro especial>\n1. Durante el evento, el \"Registro especial: El retorno de Elworth\" estará disponible gratuitamente. Tras completar el \"Registro especial: El retorno de Elworth\", podrás obtener en las recompensas por logros la rueda de destino SR exclusiva del evento \"Espera hasta que la nieve de la montaña se derrita\" y otras recompensas. Las recompensas por logros solo estarán disponibles durante el evento, y tras finalizar no podrán completarse ni reclamarse.\n2. Tras finalizar el evento, se conservará el progreso del \"Registro especial: El retorno de Elworth\". Si no lo desbloqueaste durante el evento, aún podrás desbloquearlo consumiendo 7 \"Punto de partida real\".\n3. Independientemente de si estás en el periodo del evento o no, tras completar el \"Registro especial: El retorno de Elworth\" siempre obtendrás la \"Llave: Despertar de las montañas\"."
  },
  Activity_78791_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_79851_ActivityName = {
    Text = "Brillo plateado: Partida · Edición especial de primera vez"
  },
  Activity_79851_ActivityPlot = {
    Text = "El resplandor de Plata otorga sincera Bendición a cada viaje de los Guardianes nuevo nacido sanado. Que la Llave de Plata ilumine tu camino.\n*Tras la compra, se puede usar en \"Suministros – Consumibles.\""
  },
  Activity_80163_ActivityName = {
    Text = "Paciente disociativo: ultra"
  },
  Activity_80163_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Paciente Dividido: Ultra\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen \"24\" para experimentar niveles designados infinitamente.\n·Al experimentar niveles de evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_80164_ActivityName = {
    Text = "Paciente disociativo: caro"
  },
  Activity_80164_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Paciente Dividido: Caro\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen \"24\" para experimentar niveles designados infinitamente.\n·Al experimentar niveles de evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_80165_ActivityName = {
    Text = "Paciente disociativo: aequor"
  },
  Activity_80165_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Paciente Astillado: Aequor\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan \"24\" para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_80166_ActivityName = {
    Text = "Paciente disociativo: caos"
  },
  Activity_80166_ActivityTips = {
    Text = "<Title:Actividad Reglas>\n·Durante el evento \"Paciente Astillado: Caos\", los Guardianes pueden usar equipos preestablecidos por el sistema que contengan \"24\" para experimentar niveles designados un número ilimitado de veces.\n·Al jugar niveles del evento, no se pueden hacer ajustes al Despertador en la alineación del equipo.\n<Title:Actividad Recompensas>\n·Después de completar con éxito un desafío de nivel por primera vez, puedes reclamar recompensas de prueba desde la interfaz del evento."
  },
  Activity_80167_ActivityName = {
    Text = "Segador de almas"
  },
  Activity_80167_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante el evento \"Coleccionista de Almas\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen Helot: Catena para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Event Rewards>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_80311_ActivityName = {
    Text = "Homenaje al Recuerdo del Viaje · Cápítulo de las Estrellas II"
  },
  Activity_80311_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_80312_ActivityName = {
    Text = "Viaje por el sanatorio"
  },
  Activity_80312_ActivityTips = {
    Text = "Reglas del evento:\n1. Los Secret Keepers que completen las tareas designadas del Viaje pueden reclamar recompensas en \"Viaje terapéutico\".\n2. \"Viaje terapéutico\" está siempre disponible.\n3. Después de desbloquear \"Viaje avanzado\", puedes obtener recompensas adicionales al completar misiones.\n4. Ten en cuenta: el \"Viaje avanzado\" desbloqueado en este evento solo es válido dentro de este evento. Por favor, los Secret Keepers consuman de manera racional."
  },
  Activity_81019_ActivityName = {
    Text = "Viaje extraño de purificación"
  },
  Activity_81019_ActivityPlot = {
    Text = "¿Quién atraviesa el Kadath soñado para limpiar la basura por el amo?  \n¡Es Karen~ es Karen!  \n¡Limpieza y fusión! ¡Ventilación de sueños! ¡Desinfección dimensional! ¡Voy a limpiar todo!  \nPues en cuanto a la limpieza, ¡yo, Karen, soy una profesional!  \n¡Amo, ¿quieres probarlo?! ¡Karen te enseñará sin reservas el arte de la limpieza!"
  },
  Activity_81019_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes del Secreto pueden participar en \"Progreso de Limpieza\" y reclamar \"Herramientas de Limpieza\".\n2. Una vez acumuladas suficientes \"Herramientas de Limpieza\", se pueden reclamar recompensas ricas en \"Subsidio de Limpieza\", incluyendo el avatar exclusivo del evento \"Maestro de limpieza\", Núcleo de plata, Núcleo Puro, Fragmentos de Piedra Sabia, etc.\n\n<Title: Progreso de Limpieza>\n1. \"Progreso de Limpieza\" incluye varios tipos de tareas de limpieza diferentes, los Guardianes del Secreto pueden obtener \"Herramientas de Limpieza\" al completar las tareas de limpieza. ¡Después de completar todos los tipos de tareas de limpieza diariamente, habrá una recompensa adicional!\n2. Durante el evento, cada vez que se complete un tipo de tarea de limpieza por primera vez, se reproducirá una trama oculta.\n3. \"Progreso de Limpieza\" se restablecerá diariamente a las 9:00 (GMT+8) durante el evento.\n\n<Title: Subsidio de Limpieza>\n1. Los Guardianes del Secreto pueden reclamar recompensas correspondientes acumulando \"Herramientas de Limpieza\". Cada 1000 \"Herramientas de Limpieza\" se puede reclamar una generosa recompensa de suministros, y al acumular 10000 \"Herramientas de Limpieza\" se obtendrá el avatar exclusivo \"Maestro de limpieza\" del Viaje Maravilloso de Limpieza.\n\n<Title:Agradecimiento de Karen>\nDurante el evento, se puede firmar en \"Agradecimiento de Karen\" para recibir los regalos que Karen ha preparado para los Guardianes del Secreto.\n\n<Title:Tiempo del evento>\nEste evento estará abierto solo del 28 de abril a las 9:00 al 12 de mayo a las 9:00 (GMT+8). Después de las 9:00 (GMT+8) del 12 de mayo, el evento finalizará. ¡Recuerden reclamar las recompensas en \"Subsidio de Limpieza\""
  },
  Activity_81019_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_81178_ActivityName = {
    Text = "Bajo la lluvia torrencial"
  },
  Activity_81178_ActivityPlot = {
    Text = "La lluvia torrencial caía del cielo sombrío, golpeando la superficie del mar con un repiqueteo implacable.\nRelámpagos despiadados rugían a voluntad, anunciando la llegada de un terror sin límites bajo las olas.\nEl magnífico Nautilus se mecía Frágil como un infante tambaleante entre las mareas crecientes.\nNadie sabía qué Destino les aguardaba, así como solo cuando el mar caprichoso Libera su ira uno comprende verdaderamente lo insignificante que es."
  },
  Activity_81178_ActivityStageEndContent = {
    Text = "El evento ha Terminado. Actualmente, solo \"Tesoros de la tripulación\" está disponible."
  },
  Activity_81178_ActivityTips = {
    Text = "<Title:Descripción del evento>\nDurante el evento, los Guardianes podrán recolectar la moneda del evento \"Bandera de señal\" a través de las actividades limitadas \"Perdido en las Profundidades\" y \"Recompensas por logros\". Con \"Bandera de señal\" podrás canjear recompensas en \"Tesoros de la tripulación\", incluyendo la Rueda del destino SR exclusiva del evento \"Navegante de los Mares\", Núcleo de Lumen, Núcleo Puro, Fragmentos de Piedra Sabia, Cristal de Mimesis y otros materiales.\n\n<Title:Perdido en las Profundidades>\n1. \"Perdido en las Profundidades\" contiene 9 etapas de materiales que no requieren exploración y directamente se inicia el combate, una etapa se abre cada día.\n2. Cada intento consume 120 puntos de neuropéptido, si tienes éxito en el desafío obtendrás materiales de entrenamiento y moneda del evento.\n3. Una vez que completes una etapa, desbloquearás la función \"Repetir\" de dicha etapa. Ten en cuenta: cuando uses la función \"Repetir\", no podrás obtener tasa de sincronización.\n4. Puedes usar el apoyo de Asistencia en batalla para ayudarte a pasar la etapa más fácilmente.\n\n<Title:Bonificación de bandera de señal>\n1. Si posees ciertos Cuerpos Despertados o Ruedas del destino específicas (no es necesario tenerlas en batalla), podrás obtener una bonificación adicional de \"Bandera de señal\" en las recompensas de las misiones de \"Perdido en las Profundidades\" (incluyendo repetición). Las bonificaciones específicas son las siguientes:\nCuerpo Despertado \"Corposant\": Despertar Espiritual 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\nRueda del destino SSR \"Guía del Fuego Sagrado\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\nRueda del destino SR \"Navegante de los Mares\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n2. Las bonificaciones de \"Bandera de señal\" de diferentes Cuerpos Despertados o Ruedas del destino se aplican de forma acumulativa.\n3. Especialmente, las recompensas por primera vez en dificultad Locura no se verán afectadas por las bonificaciones mencionadas anteriormente.\n\n<Title:Tesoros de la tripulación>\n1. Cada \"Entregar banderas\" consumirá 750 \"Bandera de señal\" y obtendrás aleatoriamente cinco artículos de \"Tesoros de la tripulación\".\n2. Las recompensas de \"Tesoros de la tripulación\" se dividen en dos tipos: \"Objeto especial\" y \"Objeto normal\". Al reiniciar, puedes restablecer la cantidad restante de recompensas de \"Objeto especial\" al límite máximo. Las reglas específicas son las siguientes:\n(1) Primeros 5 reinicios: cuando ya no haya cantidad restante de \"Objeto especial\", el Guardián podrá elegir reiniciar, después del reinicio, la cantidad restante de \"Objeto especial\" y \"Objeto normal\" se restablecerá al límite máximo; también puedes elegir continuar canjeando, cuando ya no haya cantidad restante de \"Objeto normal\", deberás reiniciar para poder seguir canjeando.\n(2) A partir del sexto reinicio: solo podrás reiniciar cuando ya no haya cantidad restante de \"Objeto normal\", el reinicio restablecerá la cantidad restante de \"Objeto normal\" al límite máximo, los \"Objeto especial\" ya no se reiniciarán.\n\n<Title:Duración del evento>\n1. Del 5 de mayo a las 9:00 al 19 de mayo a las 9:00 (GMT+8), podrás participar en todo el contenido mencionado en la descripción del evento.\n2. Del 19 de mayo a las 9:00 al 26 de mayo a las 9:00 (GMT+8), solo permanecerán disponibles \"Tesoros de la tripulación\" y \"Recompensas por logros\", el resto del contenido habrá finalizado y ya no será accesible.\n3. Después del 26 de mayo a las 9:00 (GMT+8), las \"Bandera de señal\" restantes que no hayas canjeado se convertirán automáticamente en Rosa Dorada *40 por unidad, por favor presta atención a revisar tu correo."
  },
  Activity_81178_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_81179_ActivityName = {
    Text = "Última guía"
  },
  Activity_81771_ActivityName = {
    Text = "Sombra que observa el Reino de Dios"
  },
  Activity_81771_ActivityPlot = {
    Text = "Nadie ha contemplado la santa luz del Reino de Dios, pero a través de la verdad que ocasionalmente se revela, las personas pueden percibir su sombra. \nEstá allí, siempre ha estado allí, y serán incontables los fieles que lo harán descender verdaderamente. \nNo importa qué tan grave pecado deba ser el precio a pagar."
  },
  Activity_81771_ActivityStageEndContent = {
    Text = "Evento finalizado"
  },
  Activity_81771_ActivityTips = {
    Text = "<Title:Marea Inquieta>\n\"Marea Inquieta\" contiene 7 niveles. Los primeros 3 se abrirán el primer día del evento, y se abrirá 1 nivel cada 3 días después. ¡Cada nivel ofrece recompensas únicas y generosas!\nCada tipo de \"Marea Inquieta\" tiene una gran cantidad de grupos. Cada vez que cualquier guardián derrota exitosamente a un grupo de un tipo específico, la cantidad de grupos de ese tipo disminuirá en 1. Cuando se eliminen todos los grupos de un tipo específico, el nivel correspondiente se cerrará permanentemente.\nCada guardián puede repeler como máximo 20 veces los grupos de \"Marea Inquieta\" por día, con restablecimiento a las 9:00 (GMT+8) durante el periodo del evento.\nCada nivel proporciona diferentes Reliquias que otorgan poderosos aumentos.\nEn cada nivel es necesario elegir asistencia. Durante todo el evento, los guardianes que se sigan mutuamente solo podrán brindarte asistencia una vez.\nLos guardianes deberán completar la Operación de investigación 2-9 para poder participar en este evento.\n\n<Title:Compensación de nivel>\n\"Echar un vistazo a las sombras del Reino Divino: Marea Inquieta\" cuenta con un sistema de compensación de nivel, ¡para que todos los guardianes puedan unirse para resistir la invasión!\nLas reglas de compensación son las siguientes:\nEn el equipo de investigación, los Despertados con nivel inferior a 60 se compensarán hasta el nivel 60 en este desafío.\nEn el equipo de investigación, los Despertados cuyo nivel de habilidad sea inferior a 5 se compensarán hasta el nivel 5 en este desafío.\nEn el equipo de investigación, los Despertados cuyo nivel de \"Presagio de Locura\" sea inferior a 6 se compensarán hasta el nivel 6 en este desafío.\nEn el equipo de investigación, los Despertados cuyo nivel de \"Afinidad Espiritual\" sea inferior a 5 se compensarán hasta el nivel 5 en este desafío.\nSi el nivel del guardián es inferior a 60, se compensará hasta el nivel 60 en este desafío.\n\n<Title:Misión limitada>\nDurante el evento, completa la misión limitada repeliendo la Marea Inquieta 30 veces y obtén \"Vale de Ropa Fantástica Básico (Fase 1)\" *1.\nDurante el periodo del 26 de mayo a las 9:00 al 9 de junio a las 9:00 (GMT+8), podrás usar el \"Vale de Ropa Fantástica Básico (Fase 1)\" en la \"Tienda: Pedido de Skin\" para canjear skins básicas.\nPuedes conocer más formas de obtener el \"Vale de Ropa Fantástica Básico (Fase 1)\" en la comunidad y en los anuncios."
  },
  Activity_81771_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_83305_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83306_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83307_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83308_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83309_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83310_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83311_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83312_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83313_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83314_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83315_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83316_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83317_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83318_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83319_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83320_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83321_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83322_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83323_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83324_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83325_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83326_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83327_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83328_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83329_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83330_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83331_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83332_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83333_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83334_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83335_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83336_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83337_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_83338_ActivityName = {
    Text = "Abismo disoluto"
  },
  Activity_84175_ActivityName = {
    Text = "Viaje de ritmo"
  },
  Activity_84175_ActivityTips = {
    Text = "Reglas del evento:\n1. Los Secret Keepers que completen las tareas designadas del viaje pueden reclamar recompensas en \"Viaje de ritmo restaurado\".\n2·Las tareas se dividen en varios grupos, y un nuevo grupo se desbloqueará cada día tras el inicio del evento.\n3. Después de desbloquear \"Viaje de ritmo restaurado\", al completar las tareas podrás obtener recompensas adicionales.\n4. Ten en cuenta: El \"Viaje de ritmo restaurado\" desbloqueado en este evento solo será válido dentro de este evento. Por favor, consume con prudencia y moderación."
  },
  Activity_84176_ActivityName = {
    Text = "Viaje de la Cuerda del Tiempo"
  },
  Activity_84176_ActivityTips = {
    Text = "Reglas del evento:  \n1. Los Secret Keepers que completen las tareas designadas pueden reclamar recompensas en \"Viaje de los lazos del tiempo\".  \n2. Las tareas están divididas en varios grupos, y un nuevo grupo se desbloqueará cada día tras el inicio del evento.  \n3. Una vez desbloqueado \"Viaje de los lazos del tiempo\", al completar las tareas podrás recibir recompensas adicionales.  \n4. Ten en cuenta: el \"Viaje de los lazos del tiempo\" desbloqueado en este evento solo será válido durante este evento. Por favor, consume de manera racional."
  },
  Activity_89008_ActivityName = {
    Text = "Seguimiento resonante en la dimensión"
  },
  Activity_89008_ActivityPlot = {
    Text = "Ella ha atravesado incontables Dimensiones, incontables mundos, y experimentado incontables esperanzas y desesperaciones, pero nunca se detendrá. Porque sabe exactamente dónde está su destino — donde sea que tú estés."
  },
  Activity_89008_ActivityTips = {
    Text = "<Title:Breve introducción>\n1. Durante el evento, los Guardianes que inicien sesión diariamente pueden reclamar las recompensas de registro diario en \"Seguido a través de las dimensiones\".\n2. Las recompensas se desbloquearán según los días acumulados de inicio de sesión y se restablecerán a las 9:00 (GMT+8) cada día.\n\n<Title:Misión limitada>\nDurante el evento, si inicias sesión acumuladamente durante 7 días, podrás completar la misión limitada y recibir \"Vale de Ropa Fantástica Básico (Fase 1)\" *1.\nEntre las 9:00 del 26 de mayo y las 9:00 del 9 de junio (GMT+8), podrás usar el \"Vale de Ropa Fantástica Básico (Fase 1)\" en la \"Tienda: Trajes mágicos por encargo\" para canjear trajes mágicos sencillos.\nPara obtener más información sobre otras formas de conseguir el \"Vale de Ropa Fantástica Básico (Fase 1)\", visita la comunidad y consulta los anuncios."
  },
  Activity_89008_BannerText = {
    Text = "Iniciar sesión para recibir muchos Núcleos Inmaculados"
  },
  Activity_89576_ActivityName = {
    Text = "Que la esperanza vuelva a brotar"
  },
  Activity_89576_ActivityPlot = {
    Text = "Inicia sesión diariamente para recibir la rueda del destino SSR conmemorativa \"Renacimiento en la Tierra de la Nada\", ¡un total de 16!"
  },
  Activity_89576_ActivityTips = {
    Text = "<Title:Breve introducción>\nEl mundo se está desmoronando. En un mundo así, la desesperanza y el dolor son lo habitual. Debo acostumbrarme. Pero... aún hay calidez escondida en mi corazón, esperando a salir a la luz.\n\n<Title:Reglas del evento>\n· Durante el evento, los Secret Keepers podrán recibir diariamente la rueda del destino SSR conmemorativa «Renacimiento en la Tierra de la Nada» en «Que la esperanza germine una vez más» tras iniciar sesión, un total de 16 veces.\n· Las recompensas se desbloquearán según los días acumulados de inicio de sesión del Secret Keeper. Las recompensas diarias se renovarán a las 9:00 (GMT+8).\n\n."
  },
  Activity_89576_BannerText = {
    Text = "Rueda del destino SSR limitada gratis"
  },
  Activity_89729_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_89730_ActivityName = {
    Text = "Prisionero del espejo"
  },
  Activity_89730_ActivityPlot = {
    Text = "Pájaro, pájaro, ¿por qué tienes grilletes rotos en los pies?\nPájaro, pájaro, ¿por qué lloras solo en lo alto del cielo?\nRompe las espinas, escapa de la jaula, vuelas con tus alas sobre el vasto mar de arena, pero tus tristes llamados no cesan. ¿Quién es, después de todo, el compañero leal que buscas? ¿Dónde está, después de todo, el hogar verdadero que anhelas?"
  },
  Activity_89730_ActivityStageEndContent = {
    Text = "Evento finalizado, actualmente solo disponible \"Avididad de conocimiento\""
  },
  Activity_89730_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes podrán recolectar la moneda de evento \"Libro del Conocimiento Común\", \"Libro del Conocimiento Matemático\" y \"Libro del Conocimiento Literario\" a través de las actividades limitadas \"Más allá del horizonte\", \"Recorrido Onírico\" y \"Recompensas de Logros\". Estas monedas podrán ser utilizadas en \"Deseo de conocimiento\" para adquirir artículos, incluyendo la rueda de destino SR exclusiva del evento \"Pluma Solitaria\", Núcleo de Lumen, Núcleo Puro, etc.\n2. Durante el evento, \"Mundo de Sueños Extraños: Más allá del horizonte - Parte 1\" estará disponible gratuitamente por tiempo limitado. ¡Al completar los logros del evento también podrás obtener el avatar exclusivo \"Con la Llave de plata: Castor\"!\n\n<Title:Duración del evento>\n1. Del 2 de junio a las 9:00 al 16 de junio a las 9:00 (GMT+8), todas las actividades del evento estarán disponibles.\n2. Del 16 de junio a las 9:00 al 23 de junio a las 9:00 (GMT+8), solo estará disponible \"Deseo de conocimiento\" y la recompensa de logros.\n\n<Title:Más allá del horizonte>\n1. \"Más allá del horizonte\" contiene 7 etapas, cada una se desbloqueará automáticamente un día después de la anterior.\n2. Cada intento consumirá 120 puntos de neuropéptido, y al superar con éxito la etapa obtendrás moneda de evento.\n3. Al completar una etapa, se desbloqueará su función de \"Repetición\". Ten en cuenta que al usar la función de \"Repetición\" no se obtendrá tasa de sincronización.\n4. Puedes utilizar aliados de los Alumnis para ayudarte a pasar las etapas más fácilmente.\n\n<Title:Deseo de conocimiento>\n\"Deseo de conocimiento\" cuenta con tres tiendas, con horarios de apertura como sigue:\n· \"Clases electivas generales\": se abre el 2 de junio a las 9:00.\n· \"Clase optativa de ciencias\": se abre el 4 de junio a las 9:00.\n· \"Clase optativa de literatura\": se abre el 6 de junio a las 9:00.\nEn las tiendas puedes seleccionar artículos y comprarlos directamente.\n\n<Title:Bonificaciones del evento>\n1. Si los Guardianes poseen ciertos Cuerpos Despertados o Ruedas de Destino específicas (no es necesario tenerlas en combate), obtendrán bonificaciones adicionales en la caída de \"Libro del Conocimiento Común\", \"Libro del Conocimiento Matemático\" y \"Libro del Conocimiento Literario\" en las recompensas de las misiones de \"Más allá del horizonte\". Las bonificaciones específicas son las siguientes:\n· Cuerpo Despertado \"Castor\": con Despertar Espiritual 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n· Rueda de Destino SSR \"Libertad Insoportable\": con Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n· Rueda de Destino SR \"Pluma Solitaria\": con Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n2. Las bonificaciones de \"Bonificación del evento\" de diferentes Cuerpos Despertados o Ruedas de Destino se acumulan.\n3. Especialmente, las recompensas por primera vez en dificultad Locura no se verán afectadas por las \"Bonificaciones del evento\".\n\n<Title:Recorrido Onírico>\n1. Se obtienen automáticamente 60 \"Libros del Conocimiento Común\" cada hora, con un máximo de almacenamiento de 25 horas.\n\n<Title:Mundo de Sueños Extraños>\n1. Durante el evento, \"Mundo de Sueños Extraños: Más allá del horizonte - Parte 1\" estará disponible gratuitamente.\n2. Al finalizar el evento, se conservará el progreso en \"Mundo de Sueños Extraños: Más allá del horizonte - Parte 1\", y al completar eventos de investigación no terminados durante el evento también se obtendrán las mismas recompensas. Si no desbloqueaste \"Mundo de Sueños Extraños: Más allá del horizonte - Parte 1\" durante el evento, aún podrás desbloquearlo después del evento consumiendo 7 \"Punto de partida real\".\n3. Independientemente de si es durante o fuera del periodo del evento, al completar \"Mundo de Sueños Extraños: Más allá del horizonte - Parte 1\" obtendrás la insignia \"Llave: Burla del destino\"."
  },
  Activity_89730_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_89899_ActivityName = {
    Text = "Confección de ropa ilusoria"
  },
  Activity_89899_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Secret Keepers pueden realizar sorteos utilizando el \"lente monocromático de ilusión\". La cantidad necesaria de \"lentes monocromáticos de ilusión\" aumentará con cada sorteo.\n2. La Ilusión de vestimenta de la llave plateada puede obtenerse a partir de la quinta tirada. Al completar 10 sorteos, se garantiza recibir la Ilusión de vestimenta de la llave plateada de ese periodo.\n3. Al finalizar el evento, si quedan \"lentes monocromáticos de ilusión\" restantes, se convertirán automáticamente en líquido fuente."
  },
  Activity_89899_BannerText = {
    Text = "¡Evento de sorteo limitado por tiempo!"
  },
  Activity_90052_ActivityName = {
    Text = "Cerebro corrupto"
  },
  Activity_90052_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento «Cerebro en putrefacción», los guardianes pueden utilizar equipos preestablecidos que incluyan a «Dol, la Fundida» para experimentar ilimitadas veces las misiones designadas.\n· Al jugar las misiones del evento, no se puede ajustar la formación de cuerpos despiertos en el equipo.\n<Title:Recompensas del evento>\n· Tras completar por primera vez el desafío de una misión, se podrá reclamar una recompensa de prueba en la interfaz del evento."
  },
  Activity_90493_ActivityName = {
    Text = "Entrenamiento de combate"
  },
  Activity_90493_ActivityTips = {
    Text = "Reglas del evento:\n1. Los Guardianes pueden aprender y practicar contenido de combate relevante en los Niveles correspondientes.\n2. Cuando los Guardianes Pasen los Niveles de entrenamiento práctico correspondientes, se pueden reclamar recompensas en \"Entrenamiento Práctico\"."
  },
  Activity_90861_ActivityName = {
    Text = "Destino conjugado"
  },
  Activity_90861_ActivityTips = {
    Text = "<Title:Destino conjugado>\nEsta Crónica Temporal contiene 8 paquetes de regalo. El primer paquete de regalo se puede reclamar gratis directamente, mientras que los paquetes de regalo 2–8 requieren comprar \"Destino conjugado\" antes de poder reclamarlos.\nDespués de comprar \"Destino conjugado\", las recompensas del 2.º paquete de regalo se pueden reclamar de inmediato; los paquetes de regalo siguientes requieren esperar un cierto período de tiempo antes de poder reclamarlos.\n¡Comprar \"Destino conjugado\" antes de las 9:00 del 20 de abril también otorgará recompensas adicionales: avatar exclusivo \"Tejedor del destino\" e \"Invitación del Ser Inmaterial\" ×10! Comprar después de las 9:00 del 20 de abril ya no otorgará las recompensas exclusivas por tiempo limitado.\nDespués de la compra, la duración de esta Crónica Temporal se volverá permanente, y el evento se cerrará el día después de que se hayan reclamado todos los paquetes de regalo.\n\"Destino conjugado\" estará disponible para comprar hasta las 9:00 del 18 de mayo."
  },
  Activity_90861_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_90862_ActivityName = {
    Text = "Texto temporal"
  },
  Activity_90862_ActivityTips = {
    Text = "<Title: Texto temporal>\n·Este evento de Pre-compra limitada incluye 8 paquetes de regalo. El primer paquete se puede reclamar gratis, mientras que los paquetes 2–8 requieren comprar \"Texto temporal\" antes de poder reclamarlos.\n·Después de comprar \"Texto temporal\", la recompensa del 2.º paquete de regalo se puede reclamar de inmediato; los paquetes siguientes requieren esperar un cierto período de tiempo antes de poder reclamarlos.\n·\"Texto temporal\" tiene un período de compra limitado. Ya no estará disponible para comprar después de la fecha límite. Por favor, compra a tu discreción antes del 7 de abril a las 9:00."
  },
  Activity_90862_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_90863_ActivityName = {
    Text = "Artesanía de Deseos Infinitos"
  },
  Activity_90863_ActivityTips = {
    Text = "<Title:Artesanía de Deseos Infinitos>\nEste evento de Crónicas del Guardián del Secreto incluye 8 paquetes de regalo; el primer paquete de regalo puede reclamarse de forma gratuita.\nDespués de adquirir \"Artesanía de Deseos Infinitos\", puedes reclamar inmediatamente el 2.º paquete de regalo y desbloquear los paquetes del 3 al 8 tras períodos de espera específicos.\n¡Compra antes del 24 de agosto a las 9:00 AM para recibir adicionalmente el avatar exclusivo \"Engaño en Movimiento\" e \"Invitación del Ser Inmaterial\" ×10!\nLas compras realizadas después de este momento no incluirán estas recompensas exclusivas de tiempo limitado. \"Artesanía de Deseos Infinitos\" está disponible por tiempo limitado; por favor, completa tu compra antes del 21 de septiembre a las 9:00 AM. Tras la compra, el tiempo de finalización del evento de Crónicas del Guardián del Secreto se extenderá hasta el 28 de septiembre a las 9:00 AM, ¡dando a todos los Guardianes tiempo suficiente para reclamar sus recompensas!"
  },
  Activity_90863_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_90864_ActivityName = {
    Text = "Elegía del jardín de cráneos · Viaje del fin"
  },
  Activity_90864_ActivityTips = {
    Text = "<Title:Ossuario Antífona: Crónica Temporal>\n·Esta Crónica Temporal contiene 8 paquetes, de los cuales el primer paquete puede reclamarse directamente de forma gratuita; los paquetes del 2 al 8 solo podrán reclamarse tras adquirir \"Ossuario Antífona: Crónica Temporal\".\n·Tras adquirir \"Ossuario Antífona: Crónica Temporal\", podrás reclamar inmediatamente la recompensa del segundo paquete; los paquetes siguientes deberán esperar un periodo determinado antes de poder ser reclamados.\n·Si adquieres antes del 21 de julio a las 9:00 (GMT+8), también obtendrás el avatar exclusivo \"La mirada hambrienta de la noche eterna\" y \"Invitación del Ser Inmaterial\" ×10. Después de las 9:00 del 21 de julio, ya no se podrán obtener las recompensas exclusivas por tiempo limitado.\n·Disponible hasta: 18 de agosto a las 9:00 (GMT+8)."
  },
  Activity_90865_ActivityName = {
    Text = "Texto temporal"
  },
  Activity_90865_ActivityTips = {
    Text = "<Title:Movimiento fetal del abismo marino: Crónica Temporal>\n·Esta Crónica Temporal contiene 8 paquetes. El primer paquete puede reclamarse de forma gratuita.\n·Los paquetes del 2 al 8 solo podrán reclamarse tras comprar \"Movimiento fetal del abismo marino: Crónica Temporal\".\n·Tras la compra, podrás reclamar inmediatamente el segundo paquete. Los paquetes restantes podrán reclamarse después de periodos de espera específicos.\n·Para una bonificación exclusiva, compra antes del 17 de noviembre a las 9:00 para recibir el avatar \"Endecha del Aequor\" y 10 \"Invitación del Ser Inmaterial\". Esta oferta es limitada y no estará disponible después de la fecha límite.\n·Ten en cuenta: \"Movimiento fetal del abismo marino: Crónica Temporal\" solo está disponible por tiempo limitado y ya no podrá adquirirse después del 15 de diciembre a las 9:00."
  },
  Activity_91026_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_91027_ActivityName = {
    Text = "Gran conquista"
  },
  Activity_91027_ActivityPlot = {
    Text = "¡Una era gloriosa tal vez al final perezca, mas la voluntad de los grandes guerreros jamás desaparecerá! \n Las tumbas no pueden enterrarlos, las cadenas no pueden domarlos. \n Cuando surge un nuevo destino, deliciosas carnes asadas los aguardan al final del camino de conquista; los guerreros lanzan su acometida y reclaman como suyo el glorioso botín. \n ¡Cantemos al valor imperecedero, al sagrado imperio! \n ¡Roma! ¡Roma! \n \n"
  },
  Activity_91027_ActivityStageEndContent = {
    Text = "Evento finalizado, actualmente solo puedes participar en \"Ofrecer ofrenda\""
  },
  Activity_91027_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardián pueden recolectar la moneda del evento \"Delicioso asado de León\" a través de la actividad temporal \"Caza Divina\". Con esta moneda podrás comprar artículos en la sección \"Ofrecer tributo\", incluyendo Núcleo de Lumen y Núcleo Puro.\n2. Durante el evento, \"Mundo de Sueños Extraños: Dominio Culinario\" se desbloqueará gratuitamente por tiempo limitado.\n\n<Title:Duración del evento>\n1. Del 30 de junio a las 9:00 al 21 de julio a las 9:00 (GMT+8), todas las actividades del evento estarán disponibles.\n2. Del 21 de julio a las 9:00 al 28 de julio a las 9:00 (GMT+8), solo estarán disponibles \"Ofrecer tributo\" y las recompensas por logros.\n\n<Title:Caza Divina>\n1. \"Caza Divina\" contiene 5 niveles, los cuales se abrirán automáticamente cada 2 días.\n2. Cada desafío consumirá 120 puntos de neuropéptido, y al superarlo obtendrás moneda del evento.\n3. Al completar un nivel se desbloqueará su función de \"Repetición\". Ten en cuenta que al usar la función \"Repetición\" no se obtendrá tasa de sincronización.\n4. Puedes usar el apoyo de los Alumnis para ayudarte a pasar los niveles más fácilmente.\n\n<Title:Ofrecer tributo> En la tienda \"Ofrecer tributo\" podrás usar la moneda del evento \"Delicioso asado de León\" para comprar directamente los artículos deseados.\n\n<Title:Mundo de Sueños Extraños>\n1. Durante el evento, \"Mundo de Sueños Extraños: Dominio Culinario\" podrá desbloquearse gratuitamente.\n2. Al finalizar el evento, se conservará el progreso de investigación de \"Mundo de Sueños Extraños: Dominio Culinario\", y podrás obtener recompensas de investigación iguales a las del periodo del evento al completar eventos de investigación no terminados durante el mismo. Si no desbloqueaste \"Mundo de Sueños Extraños: Dominio Culinario\" durante el evento, aún podrás desbloquearlo después del evento consumiendo 7 Punto de partida real.\n3. Independientemente de si es durante o fuera del periodo del evento, podrás obtener \"Posse: Resolución Voraz\" al completar \"Mundo de Sueños Extraños: Dominio Culinario\"."
  },
  Activity_91027_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_91112_ActivityName = {Text = "Mitsuka"},
  Activity_91112_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento \"Princesa de los Mil Abanicos\", los Secret Keepers pueden usar equipos preestablecidos del sistema que incluyen a la Princesa de los Mil Abanicos para experimentar las etapas designadas un número ilimitado de veces.\n· Durante la experiencia en el evento, no es posible ajustar a los Despertados dentro del equipo.\n<Title:Recompensas del evento>\n· Tras completar el desafío de la etapa por primera vez, podrás reclamar la recompensa de prueba en la interfaz del evento."
  },
  Activity_91355_ActivityName = {
    Text = "Homenaje al Recuerdo del Viaje · Cápítulo de las Estrellas III"
  },
  Activity_91355_ActivityPlot = {
    Text = "Un recuerdo sellado y archivado, un viaje registrado hacia el pasado. En los momentos de remembranza, no olvides ofrecer tu reverente Visitar."
  },
  Activity_91356_ActivityName = {
    Text = "Crónicas de la Ciudad Perdida"
  },
  Activity_91356_ActivityTips = {
    Text = "Reglas del Evento:\n1. Los Guardianes pueden recibir recompensas en \"Viaje de Ciudad Desperdiciada\" después de completar tareas de viaje designadas.\n2. \"Viaje de Ciudad Desperdiciada\" está abierto de forma permanente.\n3. Después de desbloquear \"Viaje Avanzado\", se pueden recibir recompensas adicionales al completar tareas.\n4. Por favor nota: El \"Viaje Avanzado\" desbloqueado en este evento solo es efectivo durante este evento. Los Guardianes deben consumir de manera razonable y juiciosa."
  },
  Activity_91719_ActivityName = {
    Text = "Vale de intercambio de moda Fase 2"
  },
  Activity_91719_ActivityPlot = {
    Text = "Vale de intercambio de moda Fase 2"
  },
  Activity_91719_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Secret Keepers pueden obtener Vale de personalización de ropa sencilla - Ilusión a través de otras actividades"
  },
  Activity_91728_ActivityName = {
    Text = "Apóstol del mar"
  },
  Activity_91728_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n· Durante el evento \"Apóstol del Mar\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyan a Miryam para experimentar niveles designados de manera infinita.\n· Al experimentar los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n· Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_94858_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_94859_ActivityName = {
    Text = "Viaje estival"
  },
  Activity_94859_ActivityTips = {
    Text = "Reglas del evento: \n1. Los Secret Keepers que completen las tareas designadas pueden reclamar recompensas en \"Viaje de Verano\". \n2. Después de desbloquear \"Viaje Avanzado\", se pueden obtener recompensas adicionales al completar misiones. \n3. La compra de \"Viaje Avanzado\" tiene un límite de tiempo; una vez pasado el plazo, no se podrá comprar. Se recomienda a los Secret Keepers que compren antes del 6 de octubre a las 9:00. \n4. Tenga en cuenta: el \"Viaje Avanzado\" desbloqueado en esta actividad solo es válido durante la duración de esta actividad. Se recomienda a los Secret Keepers que consuman de manera razonable."
  },
  Activity_94859_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_94860_ActivityName = {
    Text = "Verano bajo el sol negro"
  },
  Activity_94860_ActivityPlot = {
    Text = "Verano, playa, sol abrasador y muchos rostros conocidos.\nBajo la luz del sol negro, olvida todo y sumérgete en esta ilusión desbordante que satisface todos tus anhelos."
  },
  Activity_94860_ActivityTips = {
    Text = "<Title:Introducción al evento>\n1. Durante el evento, ¡el desbloqueo gratuito por tiempo limitado de \"Mundo de Sueños Extraños: Adiós Nunca Jamás\"!\n2. Durante el evento, al iniciar sesión acumulativamente durante 7 días, podrás obtener \"Núcleo de Lumen\"*10 en \"Fiesta estival sin fin\", y el día 7 recibirás un avatar de batalla exclusivo \"Voleibol 'Gran General'\".\n\n<Title:Tiempo del evento>\n1. Del 1 de septiembre a las 9:00 al 6 de octubre a las 9:00 (GMT+8), todos los eventos son participables.\n\n<Title:Mundo de Sueños Extraños>\n1. Durante el evento, \"Mundo de Sueños Extraños: Adiós Nunca Jamás\" se puede desbloquear gratuitamente.\n2. Al finalizar el evento, el progreso de la investigación de \"Mundo de Sueños Extraños: Adiós Nunca Jamás\" se mantendrá, y al completar los eventos de investigación no realizados durante el evento, se podrán obtener recompensas de investigación consistentes con las del período del evento. Si no se desbloqueó \"Mundo de Sueños Extraños: Adiós Nunca Jamás\" durante el evento, aún se podrá desbloquear después del evento consumiendo \"Punto de partida real\"*7.\n3. Independientemente de si se completó durante el evento, al terminar \"Mundo de Sueños Extraños: Adiós Nunca Jamás\" se puede obtener \"Posse: Recuerdo del verano inmovilizado\"."
  },
  Activity_94860_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_95190_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_95191_ActivityName = {
    Text = "La deslumbrante caída de luz de innumerables mundos"
  },
  Activity_95191_ActivityPlot = {
    Text = "Cantan alabanzas inolvidables, dando la bienvenida al Señor inmortal.\nÉl vendrá desde el cielo más alto con innumerables destellos, proclamando su gloria eterna.\nCuando Él llegue, una luz ámbar cubrirá el mundo.\nEste es el funeral que Él le ofrece al mundo."
  },
  Activity_95191_ActivityStageEndContent = {
    Text = "El evento ha Terminado. Actualmente, solo \"Base Oculta\" está disponible."
  },
  Activity_95191_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardián pueden recolectar la moneda de evento Sello de la Riqueza, Sello de la Muerte y Sello de Guerra a través de las actividades por tiempo limitado \"Caza de la Ceniza\", \"La Fiesta sin Altercados\" y \"Recompensas de Logro\". Con dichas monedas, podrás comprar artículos en \"Base Oculta\", incluyendo la Rueda del destino SR limitada de la actividad \"Sol Impending\", Núcleo de Lumen, Núcleo Puro y otros.\n2. Durante el evento, \"Día polar eterno\" se desbloqueará gratuitamente por tiempo limitado. ¡Al completar los logros del evento también podrás obtener el avatar limitado \"Llave de plata: Katie Gula\"!\n\n<Title:Duración del evento>\n1. Del 18 de Agosto a las 9:00 al 1 de septiembre a las 9:00 (GMT+8), todas las actividades estarán disponibles.\n2. Del 1 de septiembre a las 9:00 al 8 de septiembre a las 9:00 (GMT+8), solo podrás participar en \"Base Oculta\" y en las Recompensas de Logro.\n\n<Title:Caza de la Ceniza>\n1. \"Caza de la Ceniza\" contiene 7 etapas, las cuales se abrirán automáticamente una cada día.\n2. Cada desafío consumirá 120 puntos de neuropéptido, y al superarlo obtendrás moneda de evento.\n3. Al completar una etapa, desbloquearás su función \"Repetición\". Ten en cuenta que al usar la función \"Repetición\" no podrás obtener porcentaje de sincronización.\n4. Puedes usar el apoyo de los Alumnis para ayudarte a pasar las etapas más fácilmente.\n\n<Title>Base Oculta>\n\"Base Oculta\" cuenta con tres tiendas, las cuales se activarán en los siguientes momentos:\nCofre de Tesoros: se activará el 18 de Agosto a las 9:00.\nHabitación de Comisiones: se activará el 20 de Agosto a las 9:00.\nCampamento de Guerra: se activará el 22 de Agosto a las 9:00.\nDentro de las tiendas puedes seleccionar los artículos y comprarlos directamente.\n\n<Title:Bonificación de evento>\n1. Si posees ciertos Cuerpo Despertado o Rueda del destino (no es necesario tenerlos activados), obtendrás bonificaciones adicionales en las recompensas de las misiones de la actividad \"Caza de la Ceniza\", específicamente en Sello de la Riqueza, Sello de la Muerte y Sello de Guerra. Las bonificaciones son las siguientes:\nCuerpo Despertado \"Katie Gula\": cuando el Despertar Espiritual esté en nivel 0/1/2/3 o superior, obtendrás un bono del 20%/30%/40%/50%.\nRueda del destino SSR \"Muerte ámbar\": cuando la Posición superpuesta esté en nivel 0/1/2/3 o superior, obtendrás un bono del 20%/30%/40%/50%.\nRueda del destino SR \"Sol Impending\": cuando la Posición superpuesta esté en nivel 0/1/2/3 o superior, obtendrás un bono del 20%/30%/40%/50%.\n2. Las bonificaciones de diferentes Cuerpo Despertado o Rueda del destino se acumulan.\n3. Especialmente, las recompensas por primera vez en dificultad Locura no se verán afectadas por las bonificaciones del evento.\n\n<Title:La Fiesta sin Altercados>\n1. Ganarás automáticamente 60 Sello de la Riqueza cada hora, con un máximo de almacenamiento de 25 horas.\n\n<Title:Inmersión en la conciencia>\n1. Durante el evento, \"Día polar eterno\" podrá desbloquearse gratuitamente.\n2. Al finalizar el evento, se conservará el progreso de investigación de \"Día polar eterno\". Incluso después del evento, podrás obtener las mismas recompensas por investigación al completar eventos de investigación no terminados durante el evento. Si no desbloqueaste \"Día polar eterno\" durante el evento, aún podrás desbloquearlo después consumiendo 3 Punto de partida real.\n3. Independientemente de si es durante o fuera del evento, al completar \"Inmersión en la conciencia: Día polar eterno\" obtendrás \"Posse: Sol Eterno\"."
  },
  Activity_95191_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_95492_ActivityName = {
    Text = "Recompensa del Rey"
  },
  Activity_95492_ActivityPlot = {
    Text = "Es un gobernante generoso, bondadoso y compasivo que reina sobre un reino de muerte. Bienvenido, extraño que aún no ha muerto, tu aroma exquisito y fragante ya ha ganado su favor. Acepta este regalo; las puertas de este castillo siempre estarán abiertas para ti."
  },
  Activity_95492_ActivityTips = {
    Text = "<Title:Descripción>\n1. Durante el evento, los Secret Keepers que inicien sesión diariamente pueden reclamar las recompensas del día en \"Recompensa del Rey\".\n2. Las recompensas se desbloquearán según los días acumulados de inicio de sesión y se restablecerán a las 9:00 (GMT+8) cada día.\n"
  },
  Activity_95492_BannerText = {
    Text = "Iniciar sesión para recibir muchos Núcleos Puros"
  },
  Activity_95977_ActivityName = {
    Text = "La estética de los no muertos"
  },
  Activity_95977_ActivityPlot = {
    Text = "La muerte, lejos de ser el final de la vida. \nNo temas a la muerte, querido huésped. \nEn el ritual festivo, junto con ese amable anfitrión, serás testigo de la estética que pertenece a los espíritus."
  },
  Activity_95977_ActivityStageEndContent = {
    Text = "Evento finalizado, actualmente solo disponible \"Salón del Castillo\""
  },
  Activity_95977_ActivityTips = {
    Text = "<Title:Descripción del evento>\nDurante el evento, los Guardián pueden recolectar monedas de evento a través de las actividades limitadas \"Fiesta de las Almas\" y \"Recompensas por logros\". Las monedas de evento pueden ser utilizadas en el \"Restaurante del Palacio Real\" para intercambiar y obtener recompensas de objetos, incluyendo la Rueda del destino SR exclusiva del evento \"Manjar Exquisito\", Piedra filosofal, Núcleo Puro, Núcleo de Lumen, entre otros.\n\n<Title:Duración del evento>\n1. Del 21 de julio 9:00 al 4 de Agosto 9:00 (GMT+8), todas las actividades estarán disponibles.\n2. Del 4 de Agosto 9:00 al 11 de Agosto 9:00 (GMT+8), solo permanecerán disponibles el \"Restaurante del Palacio Real\" y las \"Recompensas por logros\", el resto de contenidos finalizarán y no estarán disponibles.\n\n<Title:Fiesta de las Almas>\n1. \"Fiesta de las Almas\" contiene 5 misiones, se abrirá 1 cada 2 días.\n2. Cada desafío consumirá 120 puntos de neuropéptido, al vencer obtendrás monedas de evento.\n3. Al completar una misión se desbloqueará su función de \"Repetición\". Por favor, ten en cuenta: al usar la función de \"Repetición\" no se obtendrá tasa de sincronización.\n4. Puedes usar el apoyo de la Hermandad para ayudarte a pasar las misiones más fácilmente.\n\n<Title:Bonificaciones del evento>\n1. Si el Guardián posee ciertos Cuerpo Despertado o Rueda del destino específicas (no es necesario tenerlas activas), podrá obtener bonificaciones adicionales de caída de \"Huesos Podridos\" en las recompensas de las misiones de \"Fiesta de las Almas\" (incluyendo Repetición), las bonificaciones específicas son las siguientes:\nCuerpo Despertado \"Doresain\": Despertar Espiritual 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\nRueda del destino SSR \"Beso del Descanso\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\nRueda del destino SR \"Manjar Exquisito\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%\n2. Las \"Bonificaciones del evento\" de diferentes Cuerpo Despertado o Rueda del destino se aplican de forma acumulativa.\n3. Especialmente, las recompensas por primera vez en dificultad Locura no se verán afectadas por las \"Bonificaciones del evento\".\n\n<Title:Restaurante del Palacio Real>\n1. Cada \"envío de informe\" consumirá 750 \"Huesos Podridos\" y obtendrás aleatoriamente una de las cinco recompensas del \"Restaurante del Palacio Real\".\n2. Las recompensas de objetos del \"Restaurante del Palacio Real\" se dividen en dos tipos: \"Objeto especial\" y \"Objeto normal\". Al reiniciar se podrá restablecer la cantidad restante de recompensas de \"Objeto especial\" hasta el límite máximo, las reglas específicas son las siguientes:\n(1) Primeros 5 reinicios: cuando ya no quede cantidad disponible de \"Objeto especial\", el Guardián podrá elegir reiniciar, al hacerlo se restablecerá la cantidad disponible de \"Objeto especial\" y \"Objeto normal\" hasta el límite máximo; también puedes elegir continuar intercambiando, cuando ya no quede cantidad disponible de \"Objeto normal\", deberás reiniciar para poder seguir intercambiando.\n(2) A partir del sexto reinicio: solo podrás reiniciar cuando ya no quede cantidad disponible de \"Objeto normal\", al reiniciar se restablecerá la cantidad disponible de \"Objeto normal\" hasta el límite máximo, pero ya no se restablecerá la cantidad de \"Objeto especial\".\n3. Después de las 9:00 del 11 de Agosto (GMT+8), los \"Huesos Podridos\" restantes no canjeados serán reciclados según la proporción de \"Rosa Dorada*40\" por cada uno, por favor recuerda revisar tu correo."
  },
  Activity_95977_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_95978_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual I"
  },
  Activity_95978_ActivityPlot = {
    Text = "Después de la compra, \"Dursain\" se puede activar <BlueQuality:Iluminar 3>"
  },
  Activity_95979_ActivityName = {
    Text = "Señor de Necrovia"
  },
  Activity_95979_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento «Señor de las Tumbas», los Secret Keepers pueden utilizar equipos preestablecidos del sistema que incluyen a Dullahan para experimentar ilimitadamente las misiones designadas.\n· Durante la experiencia de las misiones del evento, no se pueden ajustar los Despertados en la formación.\n<Title:Recompensas del evento>\n· Tras completar por primera vez el desafío de la misión, se pueden reclamar las recompensas de prueba en la interfaz del evento."
  },
  Activity_95980_ActivityName = {
    Text = "Caja de Regalo de Fijación de Núcleo Espiritual II"
  },
  Activity_95980_ActivityPlot = {
    Text = "Después de la compra, \"Duresein\" se puede activar\n<BlueQuality:Profundidad de personalidad +4, desbloquear sobreexaltación>"
  },
  Activity_96174_ActivityName = {
    Text = "Detective afortunado"
  },
  Activity_96174_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante el evento \"Lucky Detective\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyen a Ryker para experimentar niveles designados infinitamente.\n·Al experimentar los niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Event Rewards>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_96617_ActivityName = {
    Text = "Varios tonos de rojo arce"
  },
  Activity_96617_ActivityTips = {
    Text = "<Title:Reglas del evento>\n1. Los Secret Keepers que completen las misiones designadas del Archivo pueden reclamar recompensas en \"Varios tonos de rojo arce\".\n2. \"Varios tonos de rojo arce\" finalizará el 23 de marzo a las 9:00 (GMT+8).\n3. Después de desbloquear el \"Archivo Premium\", se pueden obtener recompensas adicionales al completar misiones.\n4. Tenga en cuenta: el \"Archivo Premium\" desbloqueado en esta actividad solo será válido durante esta actividad. Por favor, los Secret Keepers consuman de manera razonable y prudente."
  },
  Activity_96617_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_96838_ActivityName = {
    Text = "Texto temporal"
  },
  Activity_96838_ActivityPlot = {
    Text = "Una explosión nuclear de color, un frenesí de formas. \n Un lienzo casi normal, cubierto por trazos de sangre, \n bajo la espátula, las almas en pena susurran temblorosas en el lado oscuro del lienzo. \n El arte más real y perfecto se oculta detrás de la locura y lo absurdo, \n solo la locura que rasga la superficie puede vislumbrar el interior del mundo."
  },
  Activity_96838_ActivityStageEndContent = {
    Text = "Evento finalizado, solo disponible \"Estudio de Pikman\""
  },
  Activity_96838_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes pueden coleccionar la moneda del evento \"Tinte de la verdad\", \"Tinte del sueño ilusorio\" e \"Infección de locura\" a través de las actividades limitadas \"Rollos de Dimensión\" y \"Recompensas de Logros\". \"Tinte de la verdad\", \"Tinte del sueño ilusorio\" e \"Infección de locura\" se pueden usar para comprar productos en \"Estudio de Pikman\", incluyendo la Rueda del destino SR exclusiva del evento \"Pincel ansioso\", Núcleo de Lumen, Núcleo Puro, entre otros.\n2. Durante el evento, \"Inmersión en la conciencia: Pintura de aberración\" se desbloqueará gratis por tiempo limitado. ¡Al completar los logros del evento, también se puede obtener el avatar exclusivo del evento \"Con la Llave de plata: Pickman\"!\n\n<Title:Tiempo del evento>\n1. Del 8 de septiembre a las 9:00 al 22 de septiembre a las 9:00 (GMT+8), se podrá participar en todas las actividades.\n2. Del 22 de septiembre a las 9:00 al 29 de septiembre a las 9:00 (GMT+8), solo se podrá participar en \"Estudio de Pikman\" y las recompensas de logros.\n\n<Title:Rollos de Dimensión>\n1. \"Rollos de Dimensión\" consta de 7 niveles, uno se abrirá automáticamente cada día.\n2. Cada desafío consumirá 120 puntos de neuropéptido, y al completar el desafío se obtendrá moneda del evento.\n3. Después de completar un nivel, se desbloqueará la función de \"Repetición\" de ese nivel. Tenga en cuenta: Al usar la función de \"Repetición\", no se podrá obtener la tasa de sincronización.\n4. Se puede utilizar el apoyo de Alumnis para ayudar a superar los niveles más fácilmente.\n\n<Title:Estudio de Pikman>\n1. \"Estudio de Pikman\" tiene tres tiendas, que abrirán en los siguientes horarios:\n \"Estudio de Realidad\": se abrirá el 8 de septiembre a las 9:00.\n \"Estudio de Sueños\": se abrirá el 10 de septiembre a las 9:00.\n \"Estudio de locura\": se abrirá el 12 de septiembre a las 9:00.\n2. Cada intercambio consumirá 750 \"Tinte de la verdad\"/\"Tinte del sueño ilusorio\"/\"Infección de locura\", y se obtendrán aleatoriamente cinco recompensas de la tienda.\n3. Las recompensas de cada tienda se dividen en \"Objeto especial\" y \"Objeto normal\". Al reiniciar, se puede restablecer la cantidad restante de objetos especiales al máximo; las reglas específicas son:\n(1) En los primeros 2 reinicios: Cuando no queden objetos especiales, el Guardián puede elegir reiniciar, lo que restablecerá la cantidad restante de objetos especiales y normales al máximo; también puede optar por continuar intercambiando, y cuando no queden objetos normales, debe reiniciar para poder continuar intercambiando.\n(2) A partir del tercer reinicio: Solo se puede reiniciar cuando no queden objetos normales, y el reinicio restablecerá la cantidad restante de objetos normales al máximo, no se restablecerán los objetos especiales.\n\n<Title:Bonificaciones del evento>\n1. Los Guardianes que posean Cuerpos Despertados o Ruedas del destino específicas (no es necesario que estén en el equipo) pueden obtener un aumento adicional en la caída de \"Tinte de la verdad\", \"Tinte del sueño ilusorio\" e \"Infección de locura\" en las recompensas de las misiones de los niveles de \"Rollos de Dimensión\". Los aumentos específicos son los siguientes:\n Cuerpo Despertado \"Pickman\": Despertar Espiritual 0/1/2/3 o superior, aumento del 20%/30%/40%/50%.\n Rueda del destino SSR \"Paradoja del Realismo\": Posición superpuesta 0/1/2/3 o superior, aumento del 20%/30%/40%/50%.\n Rueda del destino SR \"Pincel ansioso\": Posición superpuesta 0/1/2/3 o superior, aumento del 20%/30%/40%/50%.\n2. Los \"Aumentos del Evento\" de diferentes Cuerpos Despertados o Ruedas del destino se calcularán de manera acumulativa.\n3. De manera especial, las recompensas por completar el desafío de dificultad locura no se verán afectadas por los \"Aumentos del Evento\".\n\n<Title:Inmersión en la conciencia>\n1. Durante el evento, \"Inmersión en la conciencia: Pintura de aberración\" se desbloqueará gratis.\n2. Al finalizar el evento, el progreso de la investigación de \"Inmersión en la conciencia: Pintura de aberración\" se mantendrá, y al completar los eventos de investigación no finalizados durante el evento, se podrán obtener recompensas de investigación consistentes con las del evento. Si no se desbloqueó \"Inmersión en la conciencia: Pintura de aberración\" durante el evento, aún se podrá desbloquear consumiendo \"Punto de partida real\"*3 después de que finalice el evento.\n3. Independientemente de si está dentro del período del evento o no, al completar \"Inmersión en la conciencia: Pintura de aberración\", se podrá obtener \"Posse: Color de la ilusión\"."
  },
  Activity_96838_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_96839_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_97190_ActivityName = {
    Text = "Viaje del Fénix de los Huesos"
  },
  Activity_97190_ActivityTips = {
    Text = "Reglas del evento: \n1. Los Secret Keepers que completen las tareas designadas del viaje pueden reclamar recompensas en \"Viaje del Descanso Final\". \n2. Después de desbloquear el \"Viaje Avanzado\", podrás recibir recompensas adicionales al completar las tareas. \n3. La compra del \"Viaje Avanzado\" en este evento tiene un límite de tiempo; una vez vencido, ya no será posible adquirirlo. Por favor, compra con criterio antes del 18 de agosto a las 9:00. \n4. Ten en cuenta: el \"Viaje Avanzado\" desbloqueado en este evento solo es válido durante el mismo. Por favor, consume con responsabilidad."
  },
  Activity_97190_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_97297_ActivityName = {
    Text = "Reina de Espinas"
  },
  Activity_97297_ActivityTips = {
    Text = "<Title:Reglas del Evento>\n·Durante el evento \"Reina de las Espinas\", los Guardianes pueden usar equipos preestablecidos por el sistema que incluyen a Wanda para experimentar niveles designados infinitamente.\n·Al experimentar niveles del evento, no se permiten ajustes a los Despertadores en la alineación del equipo.\n<Title:Recompensas del Evento>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_97672_ActivityName = {
    Text = "Texto temporal"
  },
  Activity_97672_ActivityPlot = {
    Text = "Texto temporal"
  },
  Activity_97672_ActivityStageEndContent = {
    Text = "Evento finalizado, actualmente solo se puede participar en\"Siete días de creación\""
  },
  Activity_97672_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes pueden recolectar la moneda de evento \"Incienso calmante\", \"Aroma de pesadilla\" e \"Incienso atrapasueños\" a través de las actividades limitadas \"Siete días de creación\" y \"Recompensas de Logro\". \"Incienso calmante\", \"Aroma de pesadilla\" e \"Incienso atrapasueños\" pueden ser utilizados en \"Cámara de la Madre divina\" para comprar artículos, incluyendo la Rueda del destino SR conmemorativa \"Toxina del anillo azul\", Núcleo de Lumen, Núcleo Puro, entre otros.\n2. Al completar los logros del evento también podrás obtener el avatar conmemorativo \"Por la Llave de Plata: Murphy: Falso Engendro\".\n\n<Title:Duración del evento>\n1. Del 24 de noviembre a las 9:00 al 15 de diciembre a las 9:00 (GMT+8), todas las actividades estarán disponibles.\n2. Del 15 de diciembre a las 9:00 al 22 de diciembre a las 9:00 (GMT+8), solo estarán disponibles \"Cámara de la Madre divina\" y las recompensas de logro.\n\n<Title:Siete días de creación>\n1. \"Siete días de creación\" contiene 7 etapas, las cuales se desbloquean una cada día.\n2. Cada intento consume 120 puntos de neuropéptido y al tener éxito otorga moneda de evento.\n3. Al completar una etapa se desbloquea su función de \"Repetición\". Nota: al usar la función \"Repetición\" no se obtiene tasa de sincronización.\n4. Puedes usar el apoyo de los Alumnis para ayudarte a pasar las etapas más fácilmente.\n\n<Title:Fiesta de blasfemia>\n Después de que comience el evento, se obtendrán automáticamente 60 \"Incienso calmante\" cada hora, con un máximo de almacenamiento de 25 horas.\n\n<Title:Cámara de la Madre divina>\n1. La \"Cámara de la Madre divina\" tiene tres tiendas, cuyos horarios son los siguientes:\n\"Sueño Dulce de Caminos Diferentes\": se abre el 24 de noviembre a las 9:00.\n\"Sueño Profundo de Nacimiento Divino\": se abre el 25 de noviembre a las 9:00.\n\"Pesadilla sin esperanza\": se abre el 26 de noviembre a las 9:00.\n2. Cada ofrenda consumirá 750 \"Incienso calmante\"/\"Aroma de pesadilla\"/\"Incienso atrapasueños\", obteniendo aleatoriamente cinco artículos como recompensa de la cámara.\n3. Las recompensas de cada cámara se dividen en \"Objeto especial\" y \"Objeto normal\". Al reiniciar, se puede restablecer la cantidad restante de artículos especiales al máximo, las reglas específicas son:\n(1) Primeros 2 reinicios: cuando no haya más cantidad restante de \"Objeto especial\", el Guardián puede elegir reiniciar, lo que restablecerá la cantidad restante de \"Objeto especial\" y \"Objeto normal\" al máximo; también puede optar por continuar ofrendando, cuando no haya más cantidad restante de \"Objeto normal\", se debe reiniciar para continuar ofrendando.\n(2) A partir del tercer reinicio: solo se puede reiniciar cuando no haya más cantidad restante de \"Objeto normal\". El reinicio restablecerá la cantidad restante de \"Objeto normal\" al máximo, \"Objeto especial\" no se restablecerán más.\n\n<Title:Bonificaciones del evento>\n1. Si los Guardianes poseen ciertos Cuerpos Despertados o Ruedas del destino (no es necesario tenerlos activos), obtendrán bonificaciones adicionales en la caída de \"Incienso calmante\", \"Aroma de pesadilla\" e \"Incienso atrapasueños\" en las recompensas de las misiones de \"Siete días de creación\". Las bonificaciones específicas son las siguientes:\nCuerpo Despertado \"Dama de las profundidades del Origen\": Despertar Espiritual 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\nRueda del destino SSR \"Sueño en la Oscuridad\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\nRueda del destino SR \"Toxina del anillo azul\": Posición superpuesta 0/1/2/3 o superior, bonificación del 20%/30%/40%/50%.\n2. Las bonificaciones de diferentes Cuerpos Despertados o Ruedas del destino se suman.\n3. Especialmente, las recompensas por primera vez en dificultad locura no se ven afectadas por las bonificaciones del evento."
  },
  Activity_97672_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_97853_ActivityName = {
    Text = "Si todo sigue igual"
  },
  Activity_97853_ActivityPlot = {
    Text = "¿Alguna vez has imaginado cómo sería la vida de todos si la catástrofe no hubiera llegado? \n Tu poder para salvar el mundo ya no tiene lugar donde utilizarse, y cada día tienes que luchar por la vida cotidiana en el campus y ganar unos míseros créditos. En el patio ya no hay figuras entrenando para la batalla, en su lugar hay filas de carpas para actividades de clubes, junto con gritos de promoción y risas; cuando suena el timbre de salida, los estudiantes hambrientos se apresuran a llenar el comedor... \n Al tocar la puerta de las personas que te importan, ¿qué sonrisas verías?"
  },
  Activity_97853_ActivityStageEndContent = {
    Text = "[Si todo como siempre]Evento finalizado, actualmente solo puedes participar en \"Edificio de la Asociación de Estudiantes\""
  },
  Activity_97853_ActivityTips = {
    Text = "<Title:Descripción del evento>\n1. Durante el evento, los Guardianes pueden recolectar la moneda del evento \"Concha de especialidad costera\" a través de la mecánica temporal \"Nada nuevo bajo la luz del sol\". La \"Concha de especialidad costera\" se puede usar para comprar productos en \"Edificio de la oficina del consejo estudiantil\", incluyendo Núcleo de Lumen, Núcleo Puro, Fragmentos de Piedra Sabia, entre otros.\n2. Durante el evento, \"Mundo de Sueños Extraños: Adiós, Nunca Jamás\" se desbloqueará gratuitamente por tiempo limitado.\n\n<Title:Tiempo del evento>\n1. Del 6 de octubre a las 9:00 hasta el 20 de octubre a las 9:00 (GMT+8), se puede participar en todas las mecánicas del evento.\n2. Del 20 de octubre a las 9:00 hasta el 27 de octubre a las 9:00 (GMT+8), solo se puede participar en \"Edificio de la oficina del consejo estudiantil\" y en recompensas de logros.\n\n<Title:Nada nuevo bajo la luz del sol>\n1. \"Nada nuevo bajo la luz del sol\" consta de 5 niveles, uno se desbloqueará automáticamente cada 2 días.\n2. Cada desafío consumirá 120 puntos de neuropéptido, y al completar el desafío se obtendrá moneda del evento.\n3. Al completar un nivel, se desbloqueará la función de \"Repetir\" de ese nivel. Por favor, ten en cuenta: al usar la función \"Repetir\", no se podrá obtener la tasa de sincronización.\n4. Se puede usar el apoyo de Alumnis para ayudarte a superar los niveles más fácilmente.\n\n<Title:Bonificaciones de actividad>\n1. Desbloquea \"Archivo Premium\" en \"Viaje de Dibujo y Medición\" para activar una bonificación del 100% en la caída de \"Concha de especialidad costera\" (incluyendo repeticiones).\n\n<Title:Edificio de la oficina del consejo estudiantil>\nEl \"Edificio de la oficina del consejo estudiantil\" tiene una tienda, que abrirá el 6 de octubre a las 9:00.\nEn la tienda, puedes elegir productos y comprarlos directamente.\n\n<Title:Mundo de Sueños Extraños>\n1. Durante el evento, \"Mundo de Sueños Extraños: Adiós, Nunca Jamás\" se puede desbloquear gratuitamente.\n2. Al finalizar el evento, el progreso de la investigación de \"Mundo de Sueños Extraños: Adiós, Nunca Jamás\" se conservará. Al completar eventos de investigación no finalizados durante el evento, también se puede obtener recompensas de investigación consistentes con las del evento. Si \"Mundo de Sueños Extraños: Adiós, Nunca Jamás\" no se desbloqueó durante el evento, aún se puede desbloquear después del evento consumiendo \"Punto de partida real\" *7.\n3. Independientemente de si fue durante el evento o no, al completar \"Mundo de Sueños Extraños: Adiós, Nunca Jamás\" se puede obtener \"Posse: Momento de un Sueño Hermoso\"."
  },
  Activity_97853_BannerText = {
    Text = "¡Evento por tiempo limitado ahora disponible!"
  },
  Activity_97854_ActivityName = {
    Text = "Evento de desbloqueo gratuito"
  },
  Activity_97950_ActivityName = {
    Text = "Crónica de Cartografía"
  },
  Activity_97950_ActivityPromotionalText1 = {
    Text = "Aumenta la recompensa de moneda de evento en un 100% en el nivel \"Nada nuevo bajo la luz del sol\""
  },
  Activity_97950_ActivityTips = {
    Text = "Reglas del evento:\n1. Los Secret Keepers que completen las tareas designadas pueden reclamar recompensas en \"Registro de Cartografía\".\n2. Después de desbloquear \"Viaje Avanzado\", podrán recibir recompensas adicionales al completar las tareas.\n3. La compra de \"Viaje Avanzado\" tiene un límite de tiempo, no se podrá comprar después de la fecha límite. Por favor, los Secret Keepers compren con prudencia antes del 17 de noviembre a las 9:00.\n4. Tenga en cuenta: el \"Viaje Avanzado\" desbloqueado en este evento solo estará disponible durante este evento. Los Secret Keepers deben consumir de manera responsable."
  },
  Activity_97950_BannerText = {
    Text = "¡Evento especial de Crónica Temporal por tiempo limitado!"
  },
  Activity_97995_ActivityName = {
    Text = "¡Sin caramelos, haré travesuras!"
  },
  Activity_97995_ActivityTips = {
    Text = "<Title:Descripción>\n¡Una extraña llama de vela, un bullicioso banquete nocturno, y una pequeña bruja cazadora de caramelos, aparecen en grande rodeadas de fantasmas!\n\"¡Robo! ¡Pongan todos los caramelos, como toffees, chocolates, caramelos de leche, gomitas de frutas... cough! ¡En resumen, pónganme todos los caramelos—todo en la bolsa!\"\n\"¿Dices que es incómodo poner los malvaviscos? Ugh... ¡dámelos, los eliminaré ahora mismo!\"\n\n<Title:Reglas del evento>\n1. Durante el evento, los Guardianes del Secreto pueden usar \"Caramelo de calabaza de sabor extraño\" para obtener el nuevo atuendo de 4 estrellas de Murphy \"Caso de robo de dulces\".\n2. ¡La primera extracción es gratuita! Cada \"Caramelo de calabaza de sabor extraño\" comprado requiere \"Líquido de origen\" ×60, las 2-10 extracciones requieren \"Caramelo de calabaza de sabor extraño\" ×1/2/2/3/5/5/5/5/5 respectivamente.\n3. A partir de la 5ª extracción, hay la posibilidad de obtener un atuendo de 4 estrellas, garantizando la obtención del atuendo de 4 estrellas de la temporada después de 10 extracciones.\n4. Al finalizar el evento, los \"Caramelos de calabaza de sabor extraño\" restantes serán devueltos por correo y reembolsados al precio original."
  },
  Activity_97995_BannerText = {
    Text = "¡Evento de sorteo de ilusión de vestimenta limitado por tiempo!"
  },
  Activity_98445_ActivityName = {
    Text = "Intérprete eterno"
  },
  Activity_98445_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante el evento \"Eternal Performer\", los Guardianes pueden utilizar equipos preestablecidos por el sistema que incluyen a Hameln para experimentar niveles designados infinitamente.\n·Al experimentar los niveles del evento, no se permite hacer ajustes a los Despertadores en la alineación del equipo.\n<Title:Event Rewards>\n·Después de completar con éxito el desafío de nivel por primera vez, los jugadores pueden reclamar recompensas de prueba en la interfaz del evento."
  },
  Activity_98446_ActivityName = {
    Text = "Brillo de Mareel"
  },
  Activity_98446_ActivityTips = {
    Text = "<Title:Reglas del evento>\n· Durante el evento \"Luz Fría\", los Secret Keepers pueden utilizar equipos preestablecidos del sistema que incluyen a Kepersant para repetir niveles designados sin límite de veces.\n· Durante las misiones del evento, no se permite ajustar a los Despertados en el equipo.\n<Title:Recompensas del evento>\n· Tras completar por primera vez el desafío de una misión, se podrá reclamar una recompensa de prueba en la interfaz del evento."
  },
  Activity_99296_ActivityName = {
    Text = "Tú y yo, al final nos reencontraremos"
  },
  Activity_99296_ActivityPlot = {
    Text = "Inicia sesión diariamente para recibir la rueda del destino SSR conmemorativa limitada\"Tú y yo, al final nos reencontraremos\", ¡un total de 16 se pueden reclamar!"
  },
  Activity_99296_ActivityTips = {
    Text = "<Title:Descripción>\nEsta es una poesía dedicada a los jugadores, sobre ideales, sobre creencias, sobre los momentos de avanzar juntos. Que el corazón sincero nunca deje de latir, que la llave de plata guíe el camino.\n\n<Title:Reglas del evento>\n·Durante el evento, los Guardianes del Secreto que inicien sesión diariamente pueden reclamar la Rueda del Destino SSR conmemorativa \"Tú y yo, al final nos reencontraremos\" en \"Tú y yo, al final nos reencontraremos\", con un total de 16 reclamaciones. \n·Las recompensas se desbloquearán según los días acumulados de inicio de sesión y se restablecerán a las 9:00 (GMT+8) cada día."
  },
  Activity_99296_BannerText = {
    Text = "Rueda del destino SSR limitada gratis"
  }
})
return Text_Activity
