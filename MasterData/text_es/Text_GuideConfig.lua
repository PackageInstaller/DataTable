__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_GuideConfig = readonly({
  GuideConfig_10_Content_1 = {
    Text = "Más adelante, se erguía una <RedQuality:enorme criatura plateada de seis alas>, irradiando un brillo deslumbrante"
  },
  GuideConfig_11_Content_1 = {
    Text = "Podemos enfrentarlo directamente... o limpiar a los monstruos que rondan aquí y buscar un punto de intersección. Es hora de que tomes una decisión, guardián"
  },
  GuideConfig_12_Content_1 = {
    Text = "Mantén presionada la carta de comando y arrástrala hacia arriba para emitir la orden"
  },
  GuideConfig_13_Content_1 = {
    Text = "¡El enemigo atacará causando daño fatal! ¡Emite órdenes de defensa, guardián!"
  },
  GuideConfig_14_Content_1 = {
    Text = "Liberar repetidamente la espada de la reina puede hacer que los ataques sean más feroces. ¿Quieres probar esta técnica para acabar con tu oponente?"
  },
  GuideConfig_15_Content_1 = {
    Text = "Ejecutar órdenes de ataque otorga aliemus, y cuando está lleno se puede liberar una poderosa explosión de aliemus"
  },
  GuideConfig_1_Content_1 = {
    Text = "Guardián del secreto, ahora puedes explorar hacia adelante"
  },
  GuideConfig_2_Content_1 = {
    Text = "Es el punto de intersección de mitag, y el resonar de la llave de plata puede restaurar la vida, es justo lo que necesitamos"
  },
  GuideConfig_34_Content_1 = {
    Text = "Estás en la etapa de enseñanza de combate, aún quedan cartas de comando por jugar. Después de completar la enseñanza, podrás jugar libremente"
  },
  GuideConfig_35_Content_1 = {
    Text = "Estás en la etapa de enseñanza de combate, aún quedan cartas de comando por jugar. Después de completar la enseñanza, podrás jugar libremente"
  },
  GuideConfig_36_Content_1 = {
    Text = "Estás en la etapa de enseñanza de combate, aún quedan cartas de comando por jugar. Después de completar la enseñanza, podrás jugar libremente"
  },
  GuideConfig_37_Content_1 = {
    Text = "Estás en la etapa de enseñanza de combate, aún quedan cartas de comando por jugar. Después de completar la enseñanza, podrás jugar libremente"
  },
  GuideConfig_38_Content_1 = {
    Text = "Estás en la etapa de enseñanza de combate, aún queda la explosión del alíen por usar. Después de completar la enseñanza, podrás jugar libremente"
  },
  GuideConfig_39_Content_1 = {
    Text = "Estás en la etapa de enseñanza de combate, aún queda la explosión del alíen por usar. Después de completar la enseñanza, podrás jugar libremente"
  },
  GuideConfig_3_Content_1 = {
    Text = "Derrota rápidamente a <RedQuality:la ballena descontrolada>, no quiero ver otra tragedia como la de antes"
  },
  GuideConfig_40_Content_1 = {
    Text = "Estás en la etapa de enseñanza de combate, aún queda la explosión del alíen por usar. Después de completar la enseñanza, podrás jugar libremente"
  },
  GuideConfig_41_Content_1 = {
    Text = "Estás en la etapa de enseñanza de combate, aún queda la explosión del alíen por usar. Después de completar la enseñanza, podrás jugar libremente"
  },
  GuideConfig_42_Content_1 = {
    Text = "Estás en la etapa de enseñanza de combate, aún queda una llave por usar. Después de completar la enseñanza, podrás jugar libremente"
  },
  GuideConfig_47_Content_1 = {
    Text = "El Reino Caos tiene una fuerte Resonancia con la Llave de plata, otorgando 250 Keyflare cada turno para ayudarte a Liberar tu Posse más rápido. Si no hay Despertados de otros Reinos en tu equipo, también recibirás una Creación de plata al entrar al Nivel. Usa la Reliquia para ayudarte a derrotar a tus enemigos."
  },
  GuideConfig_47_TipsTitle_1 = {
    Text = "Reino del Caos"
  },
  GuideConfig_49_Content_1 = {
    Text = "El Reino Aequor genera 1 Tentáculo al inicio de la batalla. El Tentáculo ataca al enemigo de la fila delantera al final de cada turno. Los Cuerpos de despertar en las profundidades pueden proporcionar diversas mejoras al Tentáculo. Puedes consultar el Daño de tentáculos actual mediante el valor mostrado debajo del icono del Tentáculo."
  },
  GuideConfig_49_TipsTitle_1 = {
    Text = "Reino Aequor"
  },
  GuideConfig_4_Content_1 = {
    Text = "El sigilo negro puede ser sacrificado al dominio <Yellow:d-marca> para obtener varios <Yellow:reliquias>, lo cual es de gran ayuda en combate"
  },
  GuideConfig_55_Content_1 = {
    Text = "El Reino de Carne y sangre acumula Fusión Embrionaria y Horno Carmesí cada turno—cuanto más bajos sean tus PV, más rápida será la acumulación. Cuando el Nivel de Fusión Embrionaria alcanza su límite, se genera un Embrión y se coloca en tu Mano. Los Embriones pueden usarse directamente para otorgar la Alienación de Cuerpo Despertado correspondiente y Tasa de Crítico Temporal; o pueden ser Devorados por un Cuerpo Despierto de Carne y Sangre mediante Exaltar para activar Efectos adicionales."
  },
  GuideConfig_55_TipsTitle_1 = {
    Text = "Reino de carne y sangre"
  },
  GuideConfig_57_Content_1 = {
    Text = "¡Usa el \"Horno Carmesí\" para Recuperación de PV y resistir los ataques!"
  },
  GuideConfig_58_Content_1 = {
    Text = "Cuando un Cuerpo Despierto de Carne y Sangre Libera Exaltar, puede Devorar Embriones en tu Mano para Mejorar el Efecto de Exaltar. ¡Libera Ojo de la Eternidad y activa Devorar!"
  },
  GuideConfig_5_Content_1 = {
    Text = "Descubrí <Yellow:d-marca>, por lo que debes invertir la acumulación del el sigilo negro"
  },
  GuideConfig_60_Content_1 = {
    Text = "En el Reino Ultra, una copia Temporal de la primera Tarjeta de comando Jugada cada turno entra en el Espacio Hiperspacial. Cuando el Espacio Hiperspacial alcanza su límite, puedes entrar en un nuevo turno. En este nuevo turno, no Robarás Cartas; en su lugar, las Cartas del Espacio Hiperspacial se colocan en tu Mano."
  },
  GuideConfig_60_TipsTitle_1 = {
    Text = "Reino ultra"
  },
  GuideConfig_6_Content_1 = {
    Text = "Este es <Yellow:Reliquia>, originado de un objeto del dominio, pronto podrás percibir su poder. Lamentablemente, la reliquia se desvanecerá al salir del dominio"
  },
  GuideConfig_7_Content_1 = {
    Text = "Parece que hay un <Yellow:evento> súbito delante, ve a verlo. Quizás obtengas un refuerzo inesperado... aunque a veces viene con un costo"
  },
  GuideConfig_8_Content_1 = {
    Text = "Parece que hay más enemigos adelante"
  },
  GuideConfig_9_Content_1 = {
    Text = "Este es un pasaje unidireccional, debería llevar al salón subterráneo, vamos, cumplamos nuestra misión"
  }
})
return Text_GuideConfig
