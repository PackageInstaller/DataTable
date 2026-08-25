__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MapNodeType = readonly({
  MapNodeType_116420_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_116420_Name = {
    Text = "Nodo aleatorio"
  },
  MapNodeType_116421_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_116421_Name = {
    Text = "Combate aleatorio"
  },
  MapNodeType_116422_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_116422_Name = {
    Text = "Evento aleatorio"
  },
  MapNodeType_121329_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_121329_Name = {
    Text = "El Fantasma de Murphy"
  },
  MapNodeType_128222_Name = {
    Text = "Nodo de comando"
  },
  MapNodeType_130326_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_130326_Name = {
    Text = "Teatro del destino"
  },
  MapNodeType_149067_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_149067_Name = {
    Text = "Espejismo Celestial"
  },
  MapNodeType_18391_Desc = {
    Text = "Peligro o oportunidad, depende de tu elección"
  },
  MapNodeType_18391_Name = {Text = "Evento"},
  MapNodeType_18392_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_18392_Name = {
    Text = "Pústula extraña"
  },
  MapNodeType_18393_Desc = {
    Text = "La niebla mental es invisible pero dura, no permite que nada la atraviese"
  },
  MapNodeType_18393_Name = {Text = "Oblivion"},
  MapNodeType_18394_Desc = {
    Text = "Peligro o oportunidad, depende de tu elección"
  },
  MapNodeType_18394_Name = {Text = "Evento"},
  MapNodeType_18395_Desc = {
    Text = "Un encuentro, una crisis, o un recuerdo"
  },
  MapNodeType_18395_Name = {Text = "Trama"},
  MapNodeType_18396_Desc = {
    Text = "El enemigo final y más fuerte, derrotarlo terminará la investigación"
  },
  MapNodeType_18396_Name = {
    Text = "Batalla final"
  },
  MapNodeType_18397_Desc = {
    Text = "Tras activar, entrar en d-marca, la existencia posterior anhela intercambiar el sello negro que tienes en tus manos con poderes misteriosos"
  },
  MapNodeType_18397_Name = {
    Text = "Grabado de reliquia de disolución"
  },
  MapNodeType_18398_Desc = {
    Text = "Activar para obtener la ayuda de la Universidad de Mitag, se puede recuperar vida"
  },
  MapNodeType_18398_Name = {
    Text = "Punto de contacto"
  },
  MapNodeType_18399_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_18399_Name = {
    Text = "Vino dulce de miel"
  },
  MapNodeType_18400_Desc = {
    Text = "El agua de la sombra es profunda e incierta, al activarla puedes obtener recompensas aleatorias"
  },
  MapNodeType_18400_Name = {
    Text = "Piscina de Sombras"
  },
  MapNodeType_18401_Desc = {
    Text = "Peligro o oportunidad, depende de tu elección"
  },
  MapNodeType_18401_Name = {Text = "Evento"},
  MapNodeType_18402_Desc = {
    Text = "Posición inicial del jugador, no deberías ver este nodo, ¡si lo ves, hay un BUG!"
  },
  MapNodeType_18402_Name = {Text = "Comenzar"},
  MapNodeType_18403_Desc = {
    Text = "Spectáculo de luz y sombra"
  },
  MapNodeType_18403_Name = {
    Text = "Spectáculo de luz y sombra"
  },
  MapNodeType_18404_Desc = {
    Text = "Obtén el sigilo negro — una moneda de intercambio en el Espacio de Ensueño"
  },
  MapNodeType_18404_Name = {
    Text = "Marca negra"
  },
  MapNodeType_18405_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_18405_Name = {
    Text = "Estatua Inacabada"
  },
  MapNodeType_18406_Desc = {
    Text = "La salida del camino sin retorno ha colapsado por dentro, no se puede regresar a la entrada del camino desde aquí"
  },
  MapNodeType_18406_Name = {
    Text = "Salida del pasadizo secreto"
  },
  MapNodeType_18407_Desc = {
    Text = "Obtén creación"
  },
  MapNodeType_18407_Name = {Text = "Reliquia"},
  MapNodeType_18408_Desc = {
    Text = "Un camino inestable sin retorno, una vez dentro, no hay vuelta atrás"
  },
  MapNodeType_18408_Name = {
    Text = "Pasillo secreto"
  },
  MapNodeType_18409_Desc = {
    Text = "Bola de Cristal de Prueba"
  },
  MapNodeType_18409_Name = {
    Text = "Bola de Cristal de Prueba"
  },
  MapNodeType_18410_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_18410_Name = {
    Text = "Ceremonia de la Intercesión"
  },
  MapNodeType_18411_Desc = {
    Text = "Algunos enemigos desafiantes desencadenarán una batalla un poco más difícil"
  },
  MapNodeType_18411_Name = {Text = "Élite"},
  MapNodeType_18412_Desc = {
    Text = "Tras activar, entrar en d-marca, la existencia posterior anhela intercambiar el sello negro que tienes en tus manos con poderes misteriosos"
  },
  MapNodeType_18412_Name = {
    Text = "Gravura de traza fusionada personalizada"
  },
  MapNodeType_18413_Desc = {
    Text = "Activar para obtener la ayuda de la Universidad de Mitag, se puede recuperar vida, o elegir despertar a un despertador"
  },
  MapNodeType_18413_Name = {
    Text = "Punto de contacto"
  },
  MapNodeType_18414_Desc = {
    Text = "Tras activar, entrar en d-marca, la existencia posterior anhela intercambiar el sello negro que tienes en tus manos con poderes misteriosos"
  },
  MapNodeType_18414_Name = {
    Text = "Gravura de traza fusionada"
  },
  MapNodeType_18415_Desc = {
    Text = "Recompensa oculta"
  },
  MapNodeType_18415_Name = {
    Text = "Recompensa oculta"
  },
  MapNodeType_18416_Desc = {
    Text = "Tras activar, entrar en d-marca, la existencia posterior anhela intercambiar el sello negro que tienes en tus manos con poderes misteriosos"
  },
  MapNodeType_18416_Name = {
    Text = "Rastro de Creación"
  },
  MapNodeType_18417_Desc = {
    Text = "El camino negro conduce a lo desconocido, entrando te transportará al otro extremo del pasaje"
  },
  MapNodeType_18417_Name = {Text = "túnel"},
  MapNodeType_18419_Desc = {
    Text = "Piso colapsable de prueba con temporizador"
  },
  MapNodeType_18419_Name = {
    Text = "Piso de colapso temporizado"
  },
  MapNodeType_18420_Desc = {
    Text = "Probar Pasaje Oculto"
  },
  MapNodeType_18420_Name = {
    Text = "Probar Pasaje Oculto"
  },
  MapNodeType_18421_Desc = {
    Text = "Dispositivo de iluminación dejado por los antepasados, puede dispersar la niebla densa alrededor"
  },
  MapNodeType_18421_Name = {Text = "proyector"},
  MapNodeType_18422_Desc = {
    Text = "Una puerta robusta y silenciosa. Necesitas una llave oxidada para abrirla"
  },
  MapNodeType_18422_Name = {
    Text = "Puerta oxidada"
  },
  MapNodeType_18423_Desc = {
    Text = "Tras activar, entrar en d-marca, la existencia posterior anhela intercambiar el sello negro que tienes en tus manos con poderes misteriosos"
  },
  MapNodeType_18423_Name = {Text = "D-mark"},
  MapNodeType_18424_Desc = {
    Text = "Piso inestable"
  },
  MapNodeType_18424_Name = {
    Text = "Piso inestable"
  },
  MapNodeType_18425_Desc = {
    Text = "Busca pacientemente su puerta"
  },
  MapNodeType_18425_Name = {
    Text = "Llave oxidada"
  },
  MapNodeType_18426_Desc = {
    Text = "Reemplazo de avatar"
  },
  MapNodeType_18426_Name = {
    Text = "Reemplazo de avatar"
  },
  MapNodeType_18427_Desc = {
    Text = "Una ilusión distorsionada bloquea tu camino, si decides romperla, te infectarás con síntomas desconocidos"
  },
  MapNodeType_18427_Name = {Text = "Ilusión"},
  MapNodeType_18428_Desc = {
    Text = "Obtener núcleo de plata suelto"
  },
  MapNodeType_18428_Name = {
    Text = "Núcleo de plata"
  },
  MapNodeType_18429_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_18429_Name = {
    Text = "Regalo Amable"
  },
  MapNodeType_18430_Desc = {
    Text = "Nodo de tienda especial para prueba, si lo ves significa que no estás en un nivel oficial"
  },
  MapNodeType_18430_Name = {
    Text = "Tienda especial"
  },
  MapNodeType_18431_Desc = {
    Text = "Algunos enemigos inesperados desencadenarán una batalla"
  },
  MapNodeType_18431_Name = {Text = "Batalla"},
  MapNodeType_18432_Desc = {
    Text = "Zona de fusión peligrosa, no entres sin cuidado"
  },
  MapNodeType_18432_Name = {
    Text = "Pantano Maldito"
  },
  MapNodeType_24876_Desc = {
    Text = "Algunos enemigos desafiantes desencadenarán una batalla un poco más difícil"
  },
  MapNodeType_24876_Name = {Text = "Élite"},
  MapNodeType_35056_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_35056_Name = {
    Text = "El mito del productor"
  },
  MapNodeType_35889_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_35889_Name = {
    Text = "Vela blanca pura"
  },
  MapNodeType_37987_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_37987_Name = {
    Text = "Orden secreto"
  },
  MapNodeType_38711_Desc = {
    Text = "Tras activar, entrar en d-marca, la existencia posterior anhela intercambiar el sello negro que tienes en tus manos con poderes misteriosos"
  },
  MapNodeType_38711_Name = {
    Text = "Mercado de Harichi"
  },
  MapNodeType_44838_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_44838_Name = {Text = "Deseo"},
  MapNodeType_44839_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_44839_Name = {Text = "Redención"},
  MapNodeType_44840_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_44840_Name = {Text = "Confesión"},
  MapNodeType_46149_Desc = {
    Text = "Tras activar, entrar en d-marca, la existencia posterior anhela intercambiar el sello negro que tienes en tus manos con poderes misteriosos"
  },
  MapNodeType_46149_Name = {Text = "D-mark"},
  MapNodeType_47473_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_47473_Name = {
    Text = "Sueño lúcido"
  },
  MapNodeType_47474_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_47474_Name = {
    Text = "Fusión principal"
  },
  MapNodeType_47475_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_47475_Name = {
    Text = "Serpiente hipnótica"
  },
  MapNodeType_48144_Desc = {
    Text = "Peligro o oportunidad, depende de tu elección"
  },
  MapNodeType_48144_Name = {
    Text = "Conciencia de uno mismo"
  },
  MapNodeType_49058_Desc = {
    Text = "Parece que hay algo oculto en el agua de la piscina roja y oscura"
  },
  MapNodeType_49058_Name = {
    Text = "Bacin de sangre"
  },
  MapNodeType_49100_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_49100_Name = {
    Text = "Madre nutricia"
  },
  MapNodeType_52484_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_52484_Name = {Text = "Desastre"},
  MapNodeType_52485_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_52485_Name = {Text = "Desastre"},
  MapNodeType_52486_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_52486_Name = {Text = "Desastre"},
  MapNodeType_52487_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_52487_Name = {
    Text = "Sacrificio final"
  },
  MapNodeType_55797_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_55797_Name = {
    Text = "Regalo de la primavera"
  },
  MapNodeType_55798_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_55798_Name = {
    Text = "Bendición de Muzus"
  },
  MapNodeType_57740_Desc = {
    Text = "Esta área sin cobertura está completamente expuesta a la vigilancia del Comité de Censura"
  },
  MapNodeType_57740_Name = {
    Text = "Punto de vigilancia"
  },
  MapNodeType_57741_Desc = {
    Text = "La vigilancia del Comité de Censura no es estricta, ¿quizás esto podría ser una oportunidad?"
  },
  MapNodeType_57741_Name = {
    Text = "Punto de detención"
  },
  MapNodeType_57742_Desc = {
    Text = "Los sabuesos de Juliette parecen ser interminables. Otro grupo de agentes del comité bloqueó tu camino"
  },
  MapNodeType_57742_Name = {
    Text = "Agente del Comité de Revisión"
  },
  MapNodeType_59662_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_59662_Name = {
    Text = "Ceremonia de ingreso"
  },
  MapNodeType_65469_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_65469_Name = {
    Text = "Punto de Extracción Seguro"
  },
  MapNodeType_74221_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_74221_Name = {
    Text = "Conciencia que aún no se ha perdido"
  },
  MapNodeType_76256_Desc = {
    Text = "Las ruinas sumergidas de Lemuria, la existencia posterior anhela intercambiar el sello negro que tienes en tus manos con poderes misteriosos."
  },
  MapNodeType_76256_Name = {
    Text = "Ruinas Cenicientas"
  },
  MapNodeType_76417_Desc = {
    Text = "Un fragmento de hueso pálido, la mitad sumergido en la disolución negra"
  },
  MapNodeType_76417_Name = {
    Text = "Huesos descoloridos"
  },
  MapNodeType_80599_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_80599_Name = {
    Text = "Metamorfosis de la vida"
  },
  MapNodeType_90661_Desc = {
    Text = "La llave de plata te guía a este lugar, resuena con lo que existe aquí"
  },
  MapNodeType_90661_Name = {
    Text = "Gusto perfecto"
  }
})
return Text_MapNodeType
