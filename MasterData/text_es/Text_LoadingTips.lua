__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_LoadingTips = readonly({
  LoadingTips_17465_LoadingTips = {
    Text = "\nTasa de Afinidad: El grado de sincronización mental entre el Investigador, el Guardián y su Despertador asociado.\nCuanto más alta sea la Tasa de Afinidad, más profunda será la comprensión, más cercana será la relación y más fuerte será la confianza entre ellos."
  },
  LoadingTips_17466_LoadingTips = {
    Text = "En el Dominio, las emociones, pensamientos, ideas y obsesiones pueden manifestarse como proyecciones observables. Estas proyecciones son en general objetos intangibles, ilusiones engañosas creadas por la dimensión espiritual para engañar los sentidos de los individuos en la dimensión real."
  },
  LoadingTips_17467_LoadingTips = {
    Text = "La transferencia de gnosis es un dispositivo especial instalado en los maletines de los Investigadores y Guardianes, que permite la transferencia de conciencia a Cartas de alta dimensión: Cartas de Comando, visibles solo a través de equipos de observación de Disolución."
  },
  LoadingTips_17468_LoadingTips = {
    Text = [[
Una vez que se forme un D-Rift, no puede encogerse ni ser terminado.
Los medios ordinarios no pueden afectar un D-Rift, pero una Llave de Plata puede suprimirlo o incluso "cerrarlo" hasta cierto punto.]]
  },
  LoadingTips_17469_LoadingTips = {
    Text = "La mayoría de los individuos afectados por la Disolución experimentan perturbaciones mentales, como paranoia, TOC y manía, junto con pérdida de memoria."
  },
  LoadingTips_17470_LoadingTips = {
    Text = "La corrosión de la disolución puede ocurrir en seres orgánicos, incluyendo humanos, animales y plantas, así como en sustancias inorgánicas como minerales y metales.\nNo se ha encontrado ningún material que sea inmune al D-fenómeno."
  },
  LoadingTips_17471_LoadingTips = {
    Text = "La mayoría de los humanos no pueden observar el D-fenómeno a simple vista."
  },
  LoadingTips_17472_LoadingTips = {
    Text = "Los cuerpos disueltos pueden clasificarse generalmente según diferentes aberraciones. Los tipos más comunes son cuerpos disueltos cooperativos, cuerpos disueltos de interferencia y cuerpos disueltos compuestos."
  },
  LoadingTips_17473_LoadingTips = {
    Text = "Las manifestaciones del D-fenómeno en materiales aparecen como agujeros triangulares pequeños, invertidos y únicos o múltiples. \nEstos agujeros varían en tamaño desde aproximadamente 3mm hasta 1cm, con D-marcas que se expanden a medida que la disolución progresa."
  },
  LoadingTips_17474_LoadingTips = {
    Text = "La disolución es un fenómeno único de desintegración y disolución material, con características regionales."
  },
  LoadingTips_17475_LoadingTips = {
    Text = "En una cierta etapa del desarrollo del D-fenómeno, hay una cierta probabilidad de que surjan crecimientos de D-marca. \nEstos podrían ser extremidades adicionales, tentáculos, o tal vez engranajes y piezas de metal..."
  },
  LoadingTips_17476_LoadingTips = {
    Text = "D-Baba es hidrofóbica, impermeable y difícil de disolver en agua, con viscosidad moderada y algo de elasticidad.\nHace cientos de años, humanos imprudentes intentaron usarla como material industrial y artístico."
  },
  LoadingTips_17477_LoadingTips = {
    Text = "\"Bienvenido al Granero—donde tenemos los archivos más numerosos y los funerales menos frecuentes.\"\nEl Archivo y Oficina de Registros CMT es apodado humorísticamente \"el Granero\" por el Comité debido a su similitud fonética."
  },
  LoadingTips_17478_LoadingTips = {
    Text = "Los miembros de los escultores a menudo se refieren a sí mismos como \"Pigmalión\", y su logo organizativo también es un cincel."
  },
  LoadingTips_17479_LoadingTips = {
    Text = "La disolución es desconocida para lo mundano, pero en ciertas sociedades secretas, la gente cree firmemente que no es una calamidad, sino más bien una bendición de Dios."
  },
  LoadingTips_17480_LoadingTips = {
    Text = "\nUna masiva D-marca con un diámetro que excede los 5 metros y el potencial para una expansión futura es conocida como una D-grieta.\nEl núcleo de la grieta se llama \"Clados\"."
  },
  LoadingTips_17481_LoadingTips = {
    Text = "La Gnosis de emergencia impacta directamente el espíritu del Despertador, desbloqueando su potencial y restaurando instantáneamente su estado. La única desventaja es su alto costo."
  },
  LoadingTips_17482_LoadingTips = {
    Text = "Las misiones de campo son altamente impredecibles y están cargadas de fuertes factores incontrolables.\nPara abordar esto, la Universidad Mythag proporciona a su personal de campo dispositivos de emergencia para maximizar su seguridad."
  },
  LoadingTips_17483_LoadingTips = {
    Text = "Los Investigadores y Guardianes generalmente no manejan eventos ordinarios del mundo real, sino eventos especiales que involucran Disolución, Cuerpos Disueltos y conexiones significativas con la Dimensión del Espíritu."
  },
  LoadingTips_17484_LoadingTips = {
    Text = "En áreas con D-fenómeno, las proyecciones de la Dimensión espiritual son más claras y los Dominios son más fáciles de observar, aunque son más volátiles y peligrosos."
  },
  LoadingTips_17485_LoadingTips = {
    Text = "Los Despertadores se dividen aproximadamente en cuatro Reinos: Aequor, Caro, Ultra, y Caos, según sus características."
  },
  LoadingTips_17486_LoadingTips = {
    Text = "Después del Ritual de la Llave Mound, los Investigadores y Guardianes deben completar una tarea de campo supervisada con sus Despertadores asociados para asegurar que poseen la habilidad de llevar a cabo tareas de campo futuras de forma independiente."
  },
  LoadingTips_17487_LoadingTips = {
    Text = "El Comité Mystia (abreviado como CMT) es una organización encubierta compuesta por humanos ordinarios, establecida en conjunto por gobiernos pero existiendo de manera independiente de ellos. \nEs el primer descubridor y primer respondedor al D-fenómeno, \ny también la primera línea de defensa para los humanos ordinarios contra la Disolución."
  },
  LoadingTips_17488_LoadingTips = {
    Text = "Los diferentes Despertadores en el mismo Reino pueden cooperar mejor, mientras que puede haber cierta repulsión entre diferentes Reinos.\nSolo el Reino del Caos no presenta este fenómeno."
  },
  LoadingTips_17489_LoadingTips = {
    Text = "Las platas generalmente existen en dos formas en el mundo real: plata prima y platas romboédricas."
  },
  LoadingTips_17490_LoadingTips = {
    Text = "El índice gnóstico mide la estabilidad de los Fragmentos de Espíritu en Platas.\nLos Despertadores con índices más altos son menos propensos a perder el control, y si lo hacen, causarán menos bajas."
  },
  LoadingTips_17491_LoadingTips = {
    Text = "La creación de una Llave de Plata implica una serie de procesos complejos, culminando en el grabado de un número único.\nLas Llaves de Plata están estrictamente prohibidas para ser comerciadas o regaladas, y serán recuperadas por Mitag cuando no tengan dueño."
  },
  LoadingTips_17492_LoadingTips = {
    Text = "Los libros tabú están guardados en la estantería más alta de la biblioteca y solo pueden ser accedidos por personal autorizado."
  },
  LoadingTips_17493_LoadingTips = {
    Text = "La Universidad Mythag proporcionará apoyo de la Tecnología de Chip de Plata al Comité del Tratado Mystia según las cláusulas relevantes del Tratado Mystia para resistir conjuntamente la disolución y afrontar la crisis"
  },
  LoadingTips_17494_LoadingTips = {
    Text = "Cada individuo rinde diferentes cantidades de Plata al disolverse.\nLos individuos con un mayor poder espiritual rinden más Plata cuando se disuelven, mientras que aquellos con un poder espiritual más débil rinden menos."
  },
  LoadingTips_17495_LoadingTips = {
    Text = "Los elementos representativos en la Tecnología de Chip de Plata incluyen Equipamiento de Observación de Disolución, Comunicador de la Universidad Mitag y Llave de Plata.\nEl más único y precioso de ellos es la Llave de Plata."
  },
  LoadingTips_17496_LoadingTips = {
    Text = "En la Ceremonia de Despertar, los Investigadores y Guardianes utilizan Llaves de Plata para fortalecer la conexión entre la Plata y la Dimensión del Espíritu.\nA través de esta conexión, los Investigadores y Guardianes pueden capturar Fragmentos de Espíritu que vagan en la Dimensión del Espíritu y anclarlos dentro de la Plata."
  },
  LoadingTips_17497_LoadingTips = {
    Text = "Los Despertadores se crean forzosamente cuando la Plata captura y fija Fragmentos de Espíritu de la Dimensión Espíritu. Estos fragmentos están influenciados por la Dimensión Espíritu, por lo que todos los Despertadores entran naturalmente en un Estado de Locura al ser despertados. Este estado persiste hasta que un Investigador o Guardián establece un Enlace con ellos."
  },
  LoadingTips_17498_LoadingTips = {
    Text = "La Universidad Mythag, establecida el 16 de octubre de 187 Hongji, es una institución de educación superior dedicada a la investigación y combate de la Disolución."
  },
  LoadingTips_17499_LoadingTips = {
    Text = "El predecesor de la Universidad Mythag, el Colegio Mythag, fue fundado el 16 de octubre del año 90 de la Era Hongji por Wald Phillips y otros dos fundadores."
  },
  LoadingTips_17500_LoadingTips = {
    Text = "Los Investigadores y los Guardianes con una Llave de Plata pueden atravesar la Niebla del Patio Escolar y entrar en el campus con Despertadores vinculados."
  },
  LoadingTips_17501_LoadingTips = {
    Text = "Hace 315 años, un desastre masivo azotó el globo.\nEste año fue marcado como el comienzo de una nueva era—la Época de las Inundaciones."
  },
  LoadingTips_17502_LoadingTips = {
    Text = "\"Que la Llave de Plata guíe tu camino.\"\nUna bendición común entre los miembros de la Universidad Mythag, que encarna su espíritu indomable."
  },
  LoadingTips_17503_LoadingTips = {
    Text = "\"¡Juro atravesar la oscuridad con la espada!\"\nUn juramento común de los miembros del Comité del Tratado Mystia, reflejando su firme resolución de luchar contra la Disolución."
  },
  LoadingTips_17504_LoadingTips = {
    Text = "Aquellos talentos especiales que poseen más habilidades y pueden vincular a más Despertadores que los investigadores regulares reciben el título de Guardián.\nHasta ahora, solo unos pocos en el mundo llevan el nombre de Guardián."
  },
  LoadingTips_17505_LoadingTips = {
    Text = "Generalmente, un Investigador solo puede vincularse a un Despertador a la vez. Sin embargo, existen excepciones."
  },
  LoadingTips_17506_LoadingTips = {
    Text = "Cuando no hay misiones de campo, los Investigadores, Guardianes y sus Despertadores descansan en la Universidad Mitag.\nAsisten a clases, presentan exámenes y completan largas tareas extracurriculares."
  },
  LoadingTips_17507_LoadingTips = {
    Text = "Todos los Despertadores deben cumplir con las regulaciones del Tratado Mystia y registrarse después de despertar"
  },
  LoadingTips_17508_LoadingTips = {
    Text = "Dicho estrictamente, los Despertadores también son una forma de Tecnología de Chip de Plata."
  },
  LoadingTips_36756_LoadingTips = {
    Text = "Dependiendo del tipo de fisura, una fisura puede tener uno o más núcleos conocidos como \"Desastre\"."
  },
  LoadingTips_36757_LoadingTips = {
    Text = "Mitag desarrolló, refinó y personalizó una serie de procesos de selección basados en la teoría de \"Composición Mental e Potencial del Investigador\" con el fin de descubrir Investigadores potenciales sin alarmar al público en general."
  },
  LoadingTips_36758_LoadingTips = {
    Text = "El espíritu de todos es diferente, y las habilidades únicas de cada Guardián también varían.\nLas habilidades actualmente conocidas incluyen: Memoria compartida, emociones compartidas y percepción del estado de ánimo, entre otras."
  },
  LoadingTips_36759_LoadingTips = {
    Text = "Hace 315 años, una gran inundación barrió el mundo. El orden colapsó, las ciudades se desmoronaron y las montañas bajo el mar emergieron de repente, formando nuevas tierras."
  },
  LoadingTips_36760_LoadingTips = {
    Text = "Leo Colmillo, la moneda común del Reino de Leo. Monedas auxiliares como Mane y Pensh también están en circulación. 1 Leo Colmillo equivale a 10 Mane, y 1 Mane equivale a 10 Pensh."
  },
  LoadingTips_36761_LoadingTips = {
    Text = "Un espacio especial aislado temporalmente con la ayuda de instrumentos y Plata, no afectado por otros espíritus o la dimensión real, se llama un Dominio Artificial."
  },
  LoadingTips_36762_LoadingTips = {
    Text = "A través del ascensor, puedes acceder al espacio subterráneo de Mitag.\nAdemás de la mayor Fisura L-01 \"Pozo Negro\" en Londinium, hay varias áreas restringidas que requieren un cierto nivel de seguridad para entrar."
  },
  LoadingTips_36763_LoadingTips = {
    Text = "Debido a la conexión entre la llave de plata y la dimensión espiritual, la llave puede reaccionar al estar cerca de individuos con estados espirituales anormales"
  },
  LoadingTips_36764_LoadingTips = {
    Text = "Los Pactos son runas misteriosas registradas en materiales con Plata utilizando métodos especiales.\nDiferentes pactos proporcionan diferentes ayudas, y la misma serie de pactos puede ofrecer más asistencia."
  },
  LoadingTips_36765_LoadingTips = {
    Text = "D-baba es una sustancia negra que se filtra de los D-marca.\nAl igual que el propio D-fenómeno, sin instrumentos especiales, las personas comunes no pueden observarlo directamente."
  },
  LoadingTips_36766_LoadingTips = {
    Text = "Algunos cuerpos disueltos se convierten en un polvo negro, conocido como D-polvo, al momento de morir."
  },
  LoadingTips_36767_LoadingTips = {
    Text = "El Reino de Leo está ubicado al este del Océano Atlanta, limitando con la Federación Constante y la Unión Evergreen.\nEl reino es pequeño en tamaño pero poderoso, siendo uno de los primeros en completar la reconstrucción después del diluvio."
  },
  LoadingTips_36768_LoadingTips = {
    Text = "La República Aglo está ubicada en el lado occidental del Océano Atlanta, rodeada de mar y poseyendo vastas áreas interiores.\nLa República Aglo está altamente desarrollada en industria y finanzas, con su centro financiero, Fletcher, siendo un bullicioso núcleo que muchos sueñan con visitar."
  },
  LoadingTips_36769_LoadingTips = {
    Text = "En el Dominio, las emociones, pensamientos, ideas y obsesiones pueden manifestarse como proyecciones observables.\nEstas proyecciones son generalmente intangibles o se disipan al contacto, ilusiones de la Dimensión Espiritual que engañan los sentidos de los individuos en la dimensión física."
  },
  LoadingTips_36770_LoadingTips = {
    Text = "La Federación Constante se ubica en el continente de Laurasia Oriental, una federación formada por varios pequeños países. En la federación, el arte es una búsqueda común para todos."
  },
  LoadingTips_36771_LoadingTips = {
    Text = "Algunas proyecciones especiales pueden ser capturadas por la Transferencia de Gnosis y adjuntadas a cartas de comando, proporcionando bonificaciones a los Despertadores. Estas proyecciones se llaman Plegaria."
  },
  LoadingTips_36772_LoadingTips = {
    Text = "Basado en el tamaño de las D-Rifts, se pueden clasificar aproximadamente en seis categorías: C, B, A, S, SS y SSS."
  },
  LoadingTips_36773_LoadingTips = {
    Text = "Los Escultores, una organización extrema obsesionada con experimentos humanos pecaminosos, fue fundada por Robert Rosenthal, un traidor de Mitag."
  },
  LoadingTips_36774_LoadingTips = {
    Text = "El Marinero es una antigua organización religiosa liderada por Miryam.\nTrabajan con ahínco, todo con el propósito de revivir a su único y verdadero Rey-Dios."
  },
  LoadingTips_36775_LoadingTips = {
    Text = "Diferentes áreas del Dominio producen diferentes artículos durante la Investigación. Incluso los artículos aparentemente idénticos pueden poseer esencias muy diferentes."
  },
  LoadingTips_36776_LoadingTips = {
    Text = "Un Dominio es una dimensión especial entre la dimensión espiritual y la dimensión física, y es el espacio más cercano que los humanos pueden ingresar físicamente a la dimensión espiritual."
  },
  LoadingTips_36777_LoadingTips = {
    Text = "La Universidad Mythag es una tercera parte absolutamente neutral. Todos los asuntos, grandes o pequeños, son decididos conjuntamente por el director y el equipo de gestión mediante consulta, libres de cualquier restricción organizativa."
  },
  LoadingTips_36778_LoadingTips = {
    Text = "Los D-Rifts no necesitan depender de objetos físicos para existir; pueden aparecer en el cielo, el océano y otros lugares."
  },
  LoadingTips_36779_LoadingTips = {
    Text = "La Iglesia de la Luz del Templo, un culto secreto y malvado, parece tener profundas conexiones con los Escultores y Marinero."
  },
  LoadingTips_36780_LoadingTips = {
    Text = "El Comité del Tratado Mystia es una organización extremadamente grande.\nAparte del Reino de Leo, tiene sucursales en la República Aglo, la Federación Constante y hasta en el Imperio Remouahe."
  }
})
return Text_LoadingTips
