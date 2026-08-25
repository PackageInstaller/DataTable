__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TipsType = readonly({
  TipsType_100001_Desc = {
    Text = "Cambiar la resolución requiere reiniciar el cliente para que surta efecto, ¿confirmar?"
  },
  TipsType_100001_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_100001_RightBtnDesc = {Text = "Confirmar"},
  TipsType_100001_Title = {
    Text = "Confirmar cambio de resolución"
  },
  TipsType_100002_Desc = {
    Text = "Esperando a que {s1} acepte la invitación para otra partida"
  },
  TipsType_100002_RightBtnDesc = {Text = "Cancelar"},
  TipsType_100002_Title = {
    Text = "Otra partida"
  },
  TipsType_100003_Desc = {
    Text = "{s1} te invita a otra partida"
  },
  TipsType_100003_LeftBtnDesc = {Text = "Rechazar"},
  TipsType_100003_RightBtnDesc = {Text = "Aceptar"},
  TipsType_100003_Title = {
    Text = "Otra partida"
  },
  TipsType_100004_Desc = {
    Text = "Ya es el fondo del dormitorio actual"
  },
  TipsType_100005_Desc = {
    Text = "El modo de juego de traphase no está habilitado"
  },
  TipsType_100006_Desc = {
    Text = "El modo de traphase no está activado para el oponente"
  },
  TipsType_100007_Desc = {
    Text = "Solo al seguirse mutuamente se puede iniciar un partido amistoso"
  },
  TipsType_100008_Desc = {
    Text = "El oponente está desconectado"
  },
  TipsType_100009_Desc = {
    Text = "El oponente está explorando"
  },
  TipsType_100010_Desc = {
    Text = "Tiempo de espera agotado para el partido amistoso"
  },
  TipsType_100011_Desc = {
    Text = "Has cancelado el partido amistoso"
  },
  TipsType_100012_Desc = {
    Text = "Invitación a partido amistoso rechazada"
  },
  TipsType_100012_LeftBtnDesc = {Text = "Confirmar"},
  TipsType_100012_Title = {Text = "Sugerencia"},
  TipsType_100013_Desc = {
    Text = "El oponente está desconectado"
  },
  TipsType_100014_Desc = {
    Text = "El oponente ha entrado en otro modo de juego"
  },
  TipsType_100015_Desc = {
    Text = "Invitaciones demasiado frecuentes, inténtalo de nuevo en {s1} segundos"
  },
  TipsType_100016_Desc = {
    Text = "El oponente ha cancelado el amistoso"
  },
  TipsType_100016_LeftBtnDesc = {Text = "Confirmar"},
  TipsType_100016_Title = {Text = "Sugerencia"},
  TipsType_100017_Desc = {
    Text = "Este jugador está en un partido amistoso"
  },
  TipsType_100017_LeftBtnDesc = {Text = "Confirmar"},
  TipsType_100017_Title = {Text = "Sugerencia"},
  TipsType_100018_Desc = {
    Text = "Este equipo contiene cartas con uso limitado, necesitas desbloquear el tema central de este período para continuar usándolas, ¡espero luchar a tu lado nuevamente! \n ¿Deseas ir a desbloquear el tema central?"
  },
  TipsType_100018_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_100018_RightBtnDesc = {Text = "Confirmar"},
  TipsType_100018_Title = {
    Text = "Tema central caducado"
  },
  TipsType_10001_Desc = {
    Text = "Operación exitosa"
  },
  TipsType_100020_Desc = {
    Text = "¿Todavía estás en batalla? ¿Quieres continuar con la batalla anterior?"
  },
  TipsType_100020_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_100020_RightBtnDesc = {Text = "Confirmar"},
  TipsType_100020_Title = {Text = "Sugerencia"},
  TipsType_10002_Desc = {
    Text = "Error en la tabla de configuración"
  },
  TipsType_10003_Desc = {
    Text = "Error en los datos recibidos del cliente"
  },
  TipsType_10004_Desc = {
    Text = "Servidor no iniciado"
  },
  TipsType_10005_Desc = {
    Text = "Error en los datos del personaje"
  },
  TipsType_10006_Desc = {
    Text = "No se encontraron datos de cuerpos despiertos"
  },
  TipsType_10007_Desc = {
    Text = "El Despertado ha alcanzado el nivel máximo"
  },
  TipsType_10008_Desc = {
    Text = "No hay suficientes puntos de tarea"
  },
  TipsType_10009_Desc = {
    Text = "El despertador no ha alcanzado el nivel máximo, no puede iluminar"
  },
  TipsType_100100_Desc = {
    Text = "Hay una nueva versión disponible. Si la actualización no se inicia automáticamente, intenta reiniciar Steam para buscar actualizaciones."
  },
  TipsType_100100_RightBtnDesc = {Text = "Confirmar"},
  TipsType_100100_Title = {
    Text = "Aviso de actualización"
  },
  TipsType_10010_Desc = {
    Text = "Activación de Iluminar completada"
  },
  TipsType_10011_Desc = {
    Text = "No se ha creado personaje"
  },
  TipsType_10012_Desc = {
    Text = "Personaje ya existente"
  },
  TipsType_10013_Desc = {
    Text = "Nombre de personaje repetido"
  },
  TipsType_10014_Desc = {
    Text = "Error en la zona del dominio"
  },
  TipsType_10015_Desc = {
    Text = "No se puede localizar la zona del dominio"
  },
  TipsType_10016_Desc = {
    Text = "Energía baja"
  },
  TipsType_10017_Desc = {
    Text = "Desbloqueable de {s1} a {s2}"
  },
  TipsType_10018_Desc = {
    Text = "Después de llegar al segundo nivel de este dominio 1 vez, puedes realizar una investigación rápida"
  },
  TipsType_10019_Desc = {
    Text = "Evento completado"
  },
  TipsType_10020_Desc = {
    Text = "Error en el tipo en la tabla de configuración del evento"
  },
  TipsType_10021_Desc = {
    Text = "El evento no existe"
  },
  TipsType_10022_Desc = {
    Text = "Insuficiencia de el sigilo negro, no se puede comprar"
  },
  TipsType_10023_Desc = {
    Text = "Esta carta no puede ser fortalecida"
  },
  TipsType_10024_Desc = {
    Text = "Esta carta ha alcanzado el límite de fortalecimiento"
  },
  TipsType_10025_Desc = {
    Text = "El comerciante no vende este artículo"
  },
  TipsType_10026_Desc = {
    Text = "Sin recompensa"
  },
  TipsType_10027_Desc = {
    Text = "Recompensa recibida"
  },
  TipsType_10028_Desc = {
    Text = "Error en los datos del evento"
  },
  TipsType_10029_Desc = {
    Text = "Producto comprado"
  },
  TipsType_10030_Desc = {
    Text = "Energía insuficiente para activar el portal, se necesitan {s1} puntos de energía"
  },
  TipsType_10031_Desc = {
    Text = "Evento de diálogo de la trama no encontrado"
  },
  TipsType_10032_Desc = {
    Text = "La cantidad de cartas de comando para elegir el evento es insuficiente"
  },
  TipsType_10033_Desc = {
    Text = "La cantidad de cartas de comando para elegir el evento es excesiva"
  },
  TipsType_10034_Desc = {
    Text = "La carta de comando seleccionada del evento no existe"
  },
  TipsType_10035_Desc = {
    Text = "No hay datos en la piscina de eventos aleatorios"
  },
  TipsType_10036_Desc = {
    Text = "El comerciante no vende este artículo"
  },
  TipsType_10037_Desc = {
    Text = "Cantidad insuficiente de objetos seleccionados del evento"
  },
  TipsType_10038_Desc = {
    Text = "Demasiados objetos seleccionados del evento"
  },
  TipsType_10039_Desc = {
    Text = "El objeto seleccionado del evento no existe"
  },
  TipsType_10040_Desc = {
    Text = "Nodo de evento no encontrado"
  },
  TipsType_10041_Desc = {
    Text = "Se han agotado las veces de refresco del comerciante"
  },
  TipsType_10042_Desc = {
    Text = "El número de veces para refrescar cartas de comando de caída en la batalla se ha agotado"
  },
  TipsType_10043_Desc = {
    Text = "El número de veces para refrescar reliquias de caída en la batalla se ha agotado"
  },
  TipsType_10044_Desc = {
    Text = "La función de la intersección está bloqueada"
  },
  TipsType_10045_Desc = {
    Text = "¡Área del evento no coincide! Área actual: {s1}, área configurada del evento: {s2}"
  },
  TipsType_10046_Desc = {
    Text = "No hay más eliminaciones de cartas en la tienda de eventos"
  },
  TipsType_10047_Desc = {
    Text = "Datos de unidad de tema no encontrados"
  },
  TipsType_10048_Desc = {
    Text = "Módulo enviado, no es necesario reenviar"
  },
  TipsType_10049_Desc = {
    Text = "Los temas del módulo no están completos, no se puede enviar"
  },
  TipsType_10050_Desc = {
    Text = "Módulo de tema no encontrado"
  },
  TipsType_10051_Desc = {
    Text = "Sin datos de misión del nivel"
  },
  TipsType_10052_Desc = {
    Text = "No hay tema que corresponda a este dominio"
  },
  TipsType_10053_Desc = {
    Text = "Créditos insuficientes, no se puede reclamar la recompensa"
  },
  TipsType_10054_Desc = {
    Text = "La recompensa de créditos aún no cumple con los requisitos"
  },
  TipsType_10055_Desc = {
    Text = "Subtarea no encontrada"
  },
  TipsType_10056_Desc = {
    Text = "Subtarea completada"
  },
  TipsType_10057_Desc = {
    Text = "Subtarea de la tarea no completada"
  },
  TipsType_10058_Desc = {
    Text = "NPC activado"
  },
  TipsType_10059_Desc = {
    Text = "Error de datos del NPC"
  },
  TipsType_10060_Desc = {
    Text = "NPC no existe"
  },
  TipsType_10061_Desc = {
    Text = "No se ha encontrado nada en el dominio"
  },
  TipsType_10062_Desc = {
    Text = "No se encontraron datos de resonancia"
  },
  TipsType_10063_Desc = {
    Text = "Resonancia alcanzó el nivel máximo"
  },
  TipsType_10064_Desc = {
    Text = "No se encontraron datos de nivel de resonancia"
  },
  TipsType_10065_Desc = {
    Text = "Sin reinicios"
  },
  TipsType_10066_Desc = {
    Text = "Condiciones de activación de resonancia no alcanzadas"
  },
  TipsType_10067_Desc = {
    Text = "Partículas de resonancia insuficientes"
  },
  TipsType_10068_Desc = {
    Text = "Iluminar completado, no se puede iluminar de nuevo"
  },
  TipsType_10069_Desc = {
    Text = "Materiales necesarios para iluminar insuficientes"
  },
  TipsType_10070_Desc = {
    Text = "Materiales insuficientes para mejorar al despertado"
  },
  TipsType_10071_Desc = {
    Text = "Fondos insuficientes para mejorar al despertado"
  },
  TipsType_10072_Desc = {
    Text = "Fondos insuficientes para mejorar al despertado"
  },
  TipsType_10073_Desc = {
    Text = "Sin habilidades del despertador"
  },
  TipsType_10074_Desc = {
    Text = "No he desbloqueado la habilidad del despertador"
  },
  TipsType_10075_Desc = {
    Text = "Falta \"Plata\" necesaria para el Despertar."
  },
  TipsType_10076_Desc = {
    Text = "Objetos insuficientes"
  },
  TipsType_10077_Desc = {
    Text = "Límite de compras alcanzado hoy"
  },
  TipsType_10078_Desc = {
    Text = "Objeto no utilizable"
  },
  TipsType_10079_Desc = {
    Text = "Cantidad de objetos incorrecta"
  },
  TipsType_10080_Desc = {
    Text = "Habilidad al máximo nivel"
  },
  TipsType_10081_Desc = {
    Text = "Material insuficiente, no se puede mejorar"
  },
  TipsType_10082_Desc = {
    Text = "Fondos insuficientes, no se puede mejorar"
  },
  TipsType_10083_Desc = {
    Text = "El índice de conexión del despertador ha alcanzado el nivel máximo"
  },
  TipsType_10084_Desc = {
    Text = "Este despertar no tiene suficiente espíritu de origen"
  },
  TipsType_10085_Desc = {
    Text = "Ruta de mejora sin ID de personaje"
  },
  TipsType_10086_Desc = {
    Text = "No se encuentra la información de la carta exclusiva"
  },
  TipsType_10087_Desc = {
    Text = "Carta exclusiva no desbloqueada"
  },
  TipsType_10088_Desc = {
    Text = "No se encuentra el uuid de la carta exclusiva"
  },
  TipsType_10089_Desc = {
    Text = "Recompensa de capítulo no alcanzó la puntuación"
  },
  TipsType_10090_Desc = {
    Text = "Recompensa de capítulo recibida"
  },
  TipsType_10091_Desc = {
    Text = "La línea de historia seleccionada no está desbloqueada"
  },
  TipsType_10092_Desc = {
    Text = "La mazmorra seleccionada no está desbloqueada"
  },
  TipsType_10093_Desc = {
    Text = "Área de mazmorra no desbloqueada"
  },
  TipsType_10094_Desc = {
    Text = "Barrido de la línea de trama no desbloqueado"
  },
  TipsType_10095_Desc = {
    Text = "Línea de trama del desafío de mazmorra no encontrada"
  },
  TipsType_10096_Desc = {
    Text = "Línea de trama del desafío de mazmorra no encontrada"
  },
  TipsType_10097_Desc = {
    Text = "Desafío completado, no se puede reclamar la recompensa de nuevo"
  },
  TipsType_10098_Desc = {
    Text = "Desafío no completado, no se puede reclamar la recompensa"
  },
  TipsType_10099_Desc = {
    Text = "Construcción no existe"
  },
  TipsType_10100_Desc = {
    Text = "Construcción al nivel máximo"
  },
  TipsType_10101_Desc = {
    Text = "Condiciones insuficientes para subir de nivel/construir edificio"
  },
  TipsType_10102_Desc = {
    Text = "Construcción ya existe, no se puede construir de nuevo"
  },
  TipsType_10103_Desc = {
    Text = "Faltan objetos necesarios para subir de nivel/construir"
  },
  TipsType_10104_Desc = {
    Text = "Ubicación ocupada por un ser despierto, no se puede instalar"
  },
  TipsType_10105_Desc = {
    Text = "Faltan otros objetos necesarios para la síntesis"
  },
  TipsType_10106_Desc = {
    Text = "No hay suficiente moneda para sintetizar el objeto"
  },
  TipsType_10107_Desc = {
    Text = "Objeto de síntesis no desbloqueado"
  },
  TipsType_10108_Desc = {
    Text = "Error al conectar al servidor, por favor verifica la red y vuelve a intentarlo"
  },
  TipsType_10109_Desc = {
    Text = "La función del campamento ya ha sido seleccionada y no se puede volver a elegir"
  },
  TipsType_10110_Desc = {
    Text = "No hay más usos disponibles para la función del campamento"
  },
  TipsType_10111_Desc = {
    Text = "No se puede cambiar sin actualizar la carta exclusiva"
  },
  TipsType_10112_Desc = {
    Text = "No se puede cambiar sin cambios en la carta exclusiva"
  },
  TipsType_10113_Desc = {
    Text = "Cambio de carta exclusiva fallido"
  },
  TipsType_10114_Desc = {
    Text = "Obtener Despertado{s1}"
  },
  TipsType_10115_Desc = {
    Text = "Obtención repetida de {s1}, convertido en {s2}{s3}"
  },
  TipsType_10116_Desc = {
    Text = "Límite de {s1} emblemas superado, convertido en {s2}{s3}"
  },
  TipsType_10117_Desc = {
    Text = "Log subido con éxito"
  },
  TipsType_10118_Desc = {
    Text = "Comando no coincide, esperando comando {s1}, ingresado {s2}"
  },
  TipsType_10119_Desc = {
    Text = "Perder carta: {s1}; uid: {s2}"
  },
  TipsType_10120_Desc = {
    Text = "No se puede liberar"
  },
  TipsType_10121_Desc = {
    Text = "Sin habilidad"
  },
  TipsType_10122_Desc = {
    Text = "Habilidad en enfriamiento"
  },
  TipsType_10123_Desc = {
    Text = "Habilidad agotada"
  },
  TipsType_10124_Desc = {
    Text = "Verificar si el orden de actualización del edificio Tid {s1} está en bucle"
  },
  TipsType_10125_Desc = {
    Text = "Verificar si el edificio Tid {s1} no tiene configuración relacionada"
  },
  TipsType_10126_Desc = {
    Text = "Construcción Tid {s1} el nivel real debería ser {s2}, configurado como {s3}"
  },
  TipsType_10127_Desc = {
    Text = "No se encuentra la configuración del tipo de edificio"
  },
  TipsType_10128_Desc = {
    Text = "No se encuentra la configuración del edificio o no hay tipo de edificio"
  },
  TipsType_10129_Desc = {
    Text = "Esta línea de misión no está disponible"
  },
  TipsType_10130_Desc = {
    Text = "Eliminación exitosa"
  },
  TipsType_10131_Desc = {
    Text = "Éxito en obtener \"Morfina\" × {s1}."
  },
  TipsType_10132_Desc = {
    Text = "Reparación completada"
  },
  TipsType_10133_Desc = {
    Text = "GM No se encontró el objeto con el nombre[\"..arg1..\"]"
  },
  TipsType_10134_Desc = {
    Text = "El evento [\"..arg1..\"] no existe"
  },
  TipsType_10135_Desc = {
    Text = "Actual: presiona {s1}"
  },
  TipsType_10136_Desc = {
    Text = "Mejora de habilidad exitosa"
  },
  TipsType_10137_Desc = {
    Text = "Generación exitosa"
  },
  TipsType_10138_Desc = {
    Text = "Hora del servidor modificada con éxito"
  },
  TipsType_10139_Desc = {
    Text = "Error al modificar la hora del servidor"
  },
  TipsType_10140_Desc = {
    Text = "Total de construcciones: 17\nEsta versión temporal solo abre algunas construcciones"
  },
  TipsType_10141_Desc = {
    Text = "Condiciones de desbloqueo de edificio no alcanzadas"
  },
  TipsType_10142_Desc = {
    Text = "Construcción: {s1} la interfaz configurada no existe {s2}"
  },
  TipsType_10143_Desc = {
    Text = "Esta fórmula de síntesis no está desbloqueada"
  },
  TipsType_10144_Desc = {
    Text = "Material insuficiente"
  },
  TipsType_10145_Desc = {
    Text = "Síntesis exitosa"
  },
  TipsType_10146_Desc = {
    Text = "Subida de nivel exitosa"
  },
  TipsType_10147_Desc = {
    Text = "El campo del monstruo está vacío, no puede entrar en combate"
  },
  TipsType_10148_Desc = {
    Text = "Recuperación de \"Morfina\""
  },
  TipsType_10149_Desc = {
    Text = "La ID de personaje ingresada está duplicada, no se puede entrar en la batalla"
  },
  TipsType_10150_Desc = {
    Text = "La ID ingresada {s1} no existe, no se puede entrar en la batalla"
  },
  TipsType_10151_Desc = {
    Text = "El monstruo no tiene acción correspondiente"
  },
  TipsType_10152_Desc = {
    Text = "No disponible"
  },
  TipsType_10153_Desc = {
    Text = "Sin cartas en el mazo actual"
  },
  TipsType_10154_Desc = {
    Text = "No puedes jugar cartas mientras otras cartas están en efecto"
  },
  TipsType_10155_Desc = {
    Text = "No está en la mano, no se puede jugar"
  },
  TipsType_10156_Desc = {
    Text = "Esta carta no se puede jugar"
  },
  TipsType_10157_Desc = {
    Text = "Esta carta no tiene habilidades asignadas"
  },
  TipsType_10158_Desc = {
    Text = "Esta carta no se puede jugar"
  },
  TipsType_10159_Desc = {
    Text = "Aritmética insuficiente"
  },
  TipsType_10160_Desc = {
    Text = "No hay Despertado correspondiente en el campo"
  },
  TipsType_10161_Desc = {
    Text = "Veces restantes insuficientes"
  },
  TipsType_10162_Desc = {
    Text = "Usar habilidad de exploración"
  },
  TipsType_10163_Desc = {
    Text = "Has seleccionado %d cartas de comando"
  },
  TipsType_10164_Desc = {
    Text = "Límite de cantidad alcanzado"
  },
  TipsType_10165_Desc = {
    Text = "No seleccionado"
  },
  TipsType_10166_Desc = {
    Text = "Esta carta no puede ser jugada con consumo de aritmética"
  },
  TipsType_10167_Desc = {
    Text = "Consumo total excedido"
  },
  TipsType_10168_Desc = {
    Text = "Seleccionadas {s1} cartas"
  },
  TipsType_10169_Desc = {
    Text = "Cantidad de tentáculos al máximo"
  },
  TipsType_10170_Desc = {
    Text = "Eliminación exitosa"
  },
  TipsType_10171_Desc = {
    Text = "Fortalecimiento exitoso"
  },
  TipsType_10172_Desc = {
    Text = "Cambio exitoso"
  },
  TipsType_10173_Desc = {
    Text = "Copiado al portapapeles"
  },
  TipsType_10174_Desc = {
    Text = "Se ha obtenido con éxito la tarjeta de comando"
  },
  TipsType_10175_Desc = {
    Text = "Límite de eliminación alcanzado"
  },
  TipsType_10176_Desc = {
    Text = "No quedan usos para el fortalecimiento"
  },
  TipsType_10177_Desc = {
    Text = "Se agotaron las veces de cambio"
  },
  TipsType_10178_Desc = {
    Text = "Límite de copias alcanzado"
  },
  TipsType_10179_Desc = {
    Text = "Elige cuando el número de cartas de instrucción alcance el límite"
  },
  TipsType_10180_Desc = {
    Text = "No se ha seleccionado carta de comando"
  },
  TipsType_10181_Desc = {
    Text = "Tienda no disponible, espéralo"
  },
  TipsType_10182_Desc = {
    Text = "Próximamente"
  },
  TipsType_10183_Desc = {
    Text = "El objetivo de la tarea está demasiado lejos para localizarlo"
  },
  TipsType_10184_Desc = {
    Text = "Fuera del área objetivo, no se puede completar"
  },
  TipsType_10185_Desc = {
    Text = "No desbloqueado este tema"
  },
  TipsType_10186_Desc = {
    Text = "Explora el dominio para desbloquear más investigaciones"
  },
  TipsType_10187_Desc = {
    Text = "Desbloquea más investigaciones después de completar la misión previa"
  },
  TipsType_10188_Desc = {
    Text = "Envío exitoso, puntos de proyecto +{s1}"
  },
  TipsType_10189_Desc = {
    Text = "No hay temas para entregar"
  },
  TipsType_10190_Desc = {
    Text = "No disponible, revisa el horario de apertura"
  },
  TipsType_10191_Desc = {
    Text = "No cumplido los requisitos para desbloquear el nivel"
  },
  TipsType_10192_Desc = {
    Text = "{s1} no puede estar vacío"
  },
  TipsType_10193_Desc = {
    Text = "{s1} y {s2} no pueden estar vacíos"
  },
  TipsType_10194_Desc = {
    Text = "Se han agotado las actualizaciones, no se puede actualizar"
  },
  TipsType_10195_Desc = {
    Text = "No desbloqueado"
  },
  TipsType_10196_Desc = {
    Text = "Método no disponible en este momento"
  },
  TipsType_10197_Desc = {
    Text = "Elige la creación a cambiar"
  },
  TipsType_10198_Desc = {
    Text = "Eliminación exitosa"
  },
  TipsType_10199_Desc = {
    Text = "Límite de eliminación alcanzado"
  },
  TipsType_10200_Desc = {
    Text = "Se agotaron las veces de cambio"
  },
  TipsType_10201_Desc = {
    Text = "Elige la creación a eliminar"
  },
  TipsType_10202_Desc = {
    Text = "Cantidad máxima alcanzada"
  },
  TipsType_10203_Desc = {
    Text = "Elige al menos {s1} creaciones"
  },
  TipsType_10204_Desc = {
    Text = "Límite de cambios alcanzado, no se puede cambiar"
  },
  TipsType_10205_Desc = {
    Text = "Todas las cartas exclusivas han alcanzado el nivel máximo"
  },
  TipsType_10206_Desc = {
    Text = "Rechazo en 0, no puede bajar más"
  },
  TipsType_10207_Desc = {
    Text = "No disponible"
  },
  TipsType_10208_Desc = {
    Text = "Ancla de prisión espiritual insuficiente, no se puede realizar el fortalecimiento"
  },
  TipsType_10209_Desc = {
    Text = "Es necesario que {s1} alcance el nivel {s2} para activar Iluminar"
  },
  TipsType_10210_Desc = {
    Text = "{s1} insuficiente"
  },
  TipsType_10211_Desc = {
    Text = "No tienes \"{s1}\""
  },
  TipsType_10212_Desc = {
    Text = "Límite de nivel alcanzado"
  },
  TipsType_10213_Desc = {
    Text = "Primero selecciona los materiales"
  },
  TipsType_10214_Desc = {
    Text = "{s1} insuficiente"
  },
  TipsType_10215_Desc = {
    Text = "Subida de nivel exitosa"
  },
  TipsType_10216_Desc = {
    Text = "Elixir de Gnosis aumentado"
  },
  TipsType_10217_Desc = {
    Text = "Se ha alcanzado el límite de Iluminar"
  },
  TipsType_10218_Desc = {
    Text = "Subida de nivel fallida"
  },
  TipsType_10219_Desc = {
    Text = "Material insuficiente, no se puede mejorar"
  },
  TipsType_10221_Desc = {
    Text = "Mejora de habilidad exitosa"
  },
  TipsType_10222_Desc = {
    Text = "Insuficiencia de el sigilo negro, no se puede comprar"
  },
  TipsType_10223_Desc = {Text = "Agotado"},
  TipsType_10224_Desc = {
    Text = "Insuficiencia de el sigilo negro, no se puede remover la carta de comando"
  },
  TipsType_10225_Desc = {
    Text = "Eliminar {s1} cartas de comando"
  },
  TipsType_10226_Desc = {
    Text = "Esta dirección no está disponible aún y no puede ser fortalecida"
  },
  TipsType_10227_Desc = {
    Text = "Esta dirección ha sido fortalecida hasta el nivel máximo"
  },
  TipsType_10228_Desc = {
    Text = "Por favor, elija la dirección en la que desea fortalecer su carta exclusiva"
  },
  TipsType_10229_Desc = {
    Text = "Ancla de prisión espiritual insuficiente, no se puede realizar el fortalecimiento"
  },
  TipsType_10230_Desc = {
    Text = "No tienes despertados en este dominio, no se puede seleccionar"
  },
  TipsType_10231_Desc = {
    Text = "Crear un equipo"
  },
  TipsType_10232_Desc = {
    Text = "El nombre del equipo no puede exceder {s1} caracteres chinos"
  },
  TipsType_10233_Desc = {
    Text = "El nombre del equipo no puede estar vacío"
  },
  TipsType_10234_Desc = {
    Text = "Intercambio exitoso"
  },
  TipsType_10235_Desc = {
    Text = "No hay más \"Plata\""
  },
  TipsType_10236_Desc = {
    Text = "No se puede reducir más"
  },
  TipsType_10237_Desc = {
    Text = "{s1} aún no disponible, espera"
  },
  TipsType_10238_Desc = {
    Text = "Invocación no disponible, espera"
  },
  TipsType_10239_Desc = {
    Text = "Función de mapa del campus no disponible"
  },
  TipsType_10240_Desc = {
    Text = "Desbloqueado al nivel de tarea {s1}"
  },
  TipsType_10241_Desc = {
    Text = "No hay cartas que cumplan los requisitos"
  },
  TipsType_10242_Desc = {
    Text = "Todas las cartas de dominio han sido mejoradas"
  },
  TipsType_10243_Desc = {
    Text = "No hay cartas de comando disponibles para mejorar"
  },
  TipsType_10244_Desc = {
    Text = "¡Nuevo punto de teletransporte descubierto! Puedes ir a {s1}"
  },
  TipsType_10245_Desc = {
    Text = "Ya tienes esta creación, no se puede obtener de nuevo"
  },
  TipsType_10246_Desc = {
    Text = "Recuperación exitosa"
  },
  TipsType_10247_Desc = {
    Text = "Eliminación exitosa"
  },
  TipsType_10248_Desc = {
    Text = "Abrir la interfaz de la mochila"
  },
  TipsType_10249_Desc = {
    Text = "Se ha detectado que se desconectó anómalamente la última vez. Se han devuelto la \"Morfina\" y los materiales correspondientes. Puede abrir su mochila para revisarlos."
  },
  TipsType_10250_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10251_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10252_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10253_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10254_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10255_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10256_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10257_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10258_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10259_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10260_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10261_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10262_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10263_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10264_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10265_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10266_Desc = {
    Text = "La versión AVG solo ofrece algunos edificios, aquí se indica un total de 17 edificios"
  },
  TipsType_10267_Desc = {
    Text = "No se cumplen las condiciones de uso"
  },
  TipsType_10268_Desc = {
    Text = "Nivel de investigación 2 desbloquea investigación rápida"
  },
  TipsType_10269_Desc = {
    Text = "Conexión interrumpida"
  },
  TipsType_10270_Desc = {
    Text = "La conexión del servidor se ha interrumpido, volverás a la página de inicio de sesión más tarde"
  },
  TipsType_10271_Desc = {Text = "Confirmar"},
  TipsType_10272_Desc = {
    Text = "El servidor no está disponible, inténtalo más tarde"
  },
  TipsType_10273_Desc = {
    Text = "Operación exitosa"
  },
  TipsType_10274_Desc = {
    Text = "Dominio correspondiente no encontrado"
  },
  TipsType_10275_Desc = {
    Text = "El evento en el dominio ha sido completado"
  },
  TipsType_10276_Desc = {
    Text = "Error en el llenado del tipo de configuración del evento en el dominio"
  },
  TipsType_10277_Desc = {
    Text = "El evento en el dominio no existe"
  },
  TipsType_10278_Desc = {
    Text = "Insuficiencia de el sigilo negro, no se puede comprar"
  },
  TipsType_10279_Desc = {
    Text = "Esta carta no puede ser fortalecida"
  },
  TipsType_10280_Desc = {
    Text = "Esta carta ha alcanzado el límite de fortalecimiento"
  },
  TipsType_10281_Desc = {
    Text = "El comerciante no vende este artículo"
  },
  TipsType_10282_Desc = {
    Text = "Sin recompensa"
  },
  TipsType_10283_Desc = {
    Text = "Recompensa recibida"
  },
  TipsType_10284_Desc = {
    Text = "Error en la tabla de configuración"
  },
  TipsType_10285_Desc = {
    Text = "Error en los datos del evento"
  },
  TipsType_10286_Desc = {
    Text = "Producto comprado"
  },
  TipsType_10287_Desc = {
    Text = "Datos de unidad de tema no encontrados"
  },
  TipsType_10288_Desc = {
    Text = "Módulo enviado, no es necesario reenviar"
  },
  TipsType_10289_Desc = {
    Text = "Los temas del módulo no están completos, no se puede enviar"
  },
  TipsType_10290_Desc = {
    Text = "Tarea sin módulo"
  },
  TipsType_10291_Desc = {
    Text = "Sin datos de misión del nivel"
  },
  TipsType_10292_Desc = {
    Text = "Error en los datos recibidos del cliente"
  },
  TipsType_10293_Desc = {
    Text = "Servicio no iniciado"
  },
  TipsType_10294_Desc = {
    Text = "Error en los datos del personaje"
  },
  TipsType_10295_Desc = {
    Text = "No hay personaje, se necesita crear uno"
  },
  TipsType_10296_Desc = {
    Text = "Personaje existente, no es necesario crear de nuevo"
  },
  TipsType_10297_Desc = {
    Text = "Nombre de personaje repetido"
  },
  TipsType_10298_Desc = {
    Text = "Error en el dominio"
  },
  TipsType_10299_Desc = {
    Text = "Esta línea de historia no está desbloqueada, no se puede entrar"
  },
  TipsType_10300_Desc = {
    Text = "Aquí puedes ver los efectos del terreno y la información de los monstruos"
  },
  TipsType_10301_Desc = {
    Text = "{s1} alcanza {s2} para desbloquear {s3}"
  },
  TipsType_10302_Desc = {
    Text = "{s1} alcanza {s2} para desbloquear {s3}"
  },
  TipsType_10303_Desc = {
    Text = "Condiciones de desbloqueo de edificio no alcanzadas"
  },
  TipsType_10304_Desc = {
    Text = "Condiciones de mejora de edificio no alcanzadas"
  },
  TipsType_10305_Desc = {
    Text = "Materiales insuficientes para mejorar la construcción"
  },
  TipsType_10306_Desc = {
    Text = "Hay recompensas de misión disponibles"
  },
  TipsType_10307_Desc = {
    Text = "(PV se reducirá en <Negative:10%%>)"
  },
  TipsType_10308_Desc = {
    Text = "Al final de cada turno, obtén un valor de <BuffTipBlock:Escudo> igual al número de capas de Protección actuales. Cada vez que recibas daño, la Protección se reduce en <BuffTip:1> capa"
  },
  TipsType_10309_Desc = {
    Text = "Protección múltiple"
  },
  TipsType_10310_Desc = {
    Text = "Energía por debajo del nivel de alerta, riesgo de investigación aumentado"
  },
  TipsType_10311_Desc = {
    Text = "Energía por debajo del nivel de alerta, riesgo de investigación extremadamente alto, ¿deseas proceder?"
  },
  TipsType_10312_Desc = {
    Text = "La energía actual es demasiado baja para entrar en el dominio"
  },
  TipsType_10313_Desc = {
    Text = "Elige una carta exclusiva del mismo nivel para cambiar"
  },
  TipsType_10314_Desc = {
    Text = "Desbloqueado en esa dirección al alcanzar el nivel 2 de Despertar Espiritual"
  },
  TipsType_10315_Desc = {
    Text = "Desbloqueado en esa dirección al alcanzar el nivel 3 de iluminar el despertador"
  },
  TipsType_10316_Desc = {Text = "Actual"},
  TipsType_10317_Desc = {
    Text = "Todos los despertados no han desbloqueado habilidades, no pueden cargar"
  },
  TipsType_10318_Desc = {
    Text = "La energía de todas las habilidades de los Despertados está llena"
  },
  TipsType_10319_Desc = {Text = "Usado"},
  TipsType_10320_Desc = {
    Text = "Insuficiencia de el sigilo negro"
  },
  TipsType_10321_Desc = {
    Text = "Insuficiencia de el sigilo negro"
  },
  TipsType_10322_Desc = {
    Text = "Insuficiencia de el sigilo negro"
  },
  TipsType_10323_Desc = {
    Text = "No se pueden obtener creaciones repetidas"
  },
  TipsType_10324_Desc = {
    Text = "No hay suficientes actualizaciones"
  },
  TipsType_10325_Desc = {
    Text = "Causará {s1} puntos de daño a nuestro equipo"
  },
  TipsType_10326_Desc = {Text = "ATQ"},
  TipsType_10327_Desc = {
    Text = "Aquí se mostrará una vista previa del mini mapa del nivel, los jugadores pueden planificar su estrategia con anticipación"
  },
  TipsType_10328_Desc = {
    Text = "Tardaste 10 minutos en completar un nivel en la mazmorras diarias, donde obtuviste una experiencia de juego única y fortaleciste tu comprensión de la clase mediante el diseño del nivel"
  },
  TipsType_10329_Desc = {
    Text = "La salud actual ha caído por debajo del 50% del máximo, por favor, ten cuidado"
  },
  TipsType_10330_Desc = {
    Text = "Energía para mantener el cuerpo despierto. Recibir daño reduce la vida, y si la vida llega a cero, la investigación falla"
  },
  TipsType_10331_Desc = {
    Text = "Manifestación de la fuerza de ataque del despertador. Cuanto más fuerte sea, mayor será el daño causado al enemigo al usar la carta de comando"
  },
  TipsType_10332_Desc = {
    Text = "La manifestación de la capacidad defensiva del despertador. Cuanto mayor sea la alerta, más escudo se obtiene al usar la carta de comando"
  },
  TipsType_10333_Desc = {
    Text = "Haz clic en cualquier lugar para continuar"
  },
  TipsType_10334_Desc = {
    Text = "No se ha completado la investigación de la misión"
  },
  TipsType_10335_Desc = {
    Text = "Evaluación de investigación"
  },
  TipsType_10336_Desc = {
    Text = "Otorga 1 carta exclusiva con Espíritu de Revelación"
  },
  TipsType_10337_Desc = {
    Text = "Elija la dirección de refuerzo de la carta exclusiva"
  },
  TipsType_10338_Desc = {
    Text = "El minimapa de la ciudad principal aún no está disponible, espéralo con ansias"
  },
  TipsType_10339_Desc = {
    Text = "{s1}{s2} valor"
  },
  TipsType_10340_Desc = {
    Text = "Nivel de mazo base {s1} aumentado"
  },
  TipsType_10341_Desc = {
    Text = "<Positive:Afinidad:>"
  },
  TipsType_10342_Desc = {
    Text = "Reflejo del vínculo emocional con los Despertados. Aumenta la afinidad, permitiendo conocer mejor a los Despertados"
  },
  TipsType_10343_Desc = {
    Text = "<Positive:Nivel actual:>{s1}"
  },
  TipsType_10344_Desc = {
    Text = "<Positive:Mazo base:>"
  },
  TipsType_10345_Desc = {
    Text = "Mazo inicial al entrar en la mazmorra de este dominio"
  },
  TipsType_10346_Desc = {
    Text = "<Positive:Nivel máximo del mazo:>{s1} nivel"
  },
  TipsType_10347_Desc = {
    Text = "<Positive:Nivel del mazo:>"
  },
  TipsType_10348_Desc = {
    Text = "Este dominio puede mejorar el mazo básico cuando los despertares alcanzan el nivel de afinidad requerido"
  },
  TipsType_10349_Desc = {
    Text = "<Positive:Contenido mejorado:>"
  },
  TipsType_10350_Desc = {
    Text = "Cada vez que subes de nivel, mejora el valor base de una carta de comando"
  },
  TipsType_10351_Desc = {
    Text = "Aumento de afinidad {s1}"
  },
  TipsType_10352_Desc = {
    Text = "El dominio está en silencio"
  },
  TipsType_10353_Desc = {
    Text = "El dominio rechaza a los intrusos"
  },
  TipsType_10354_Desc = {
    Text = "Aumenta el rechazo del dominio"
  },
  TipsType_10355_Desc = {
    Text = "El nivel de rechazo ha alcanzado {s1}, el dominio te está observando"
  },
  TipsType_10356_Desc = {Text = "Iluminar 1"},
  TipsType_10357_Desc = {
    Text = "Aprender la habilidad"
  },
  TipsType_10358_Desc = {
    Text = "Número máximo de tentáculos coexistentes"
  },
  TipsType_10359_Desc = {
    Text = "Refleja la intensidad del ataque de tentáculos. Cuanta más fuerza tengan, mayor será el daño al activarlos"
  },
  TipsType_10360_Desc = {
    Text = "No se ha seleccionado carta de comando"
  },
  TipsType_10361_Desc = {
    Text = "Cambio exitoso"
  },
  TipsType_10362_Desc = {
    Text = "No se ha seleccionado carta de comando"
  },
  TipsType_10363_Desc = {
    Text = "Copia exitosa"
  },
  TipsType_10364_Desc = {
    Text = "Has seleccionado {s1} cartas de comando"
  },
  TipsType_10365_Desc = {
    Text = "No se ha seleccionado carta de comando"
  },
  TipsType_10366_Desc = {
    Text = "No se ha seleccionado carta de comando"
  },
  TipsType_10367_Desc = {
    Text = "Subida de nivel exitosa"
  },
  TipsType_10368_Desc = {
    Text = "Interfaz de mochila de creación en desarrollo, ¡espera con ansias!"
  },
  TipsType_10369_Desc = {
    Text = "Elige la creación a cambiar"
  },
  TipsType_10370_Desc = {
    Text = "Actualización de versión, reinstala el paquete"
  },
  TipsType_10371_Desc = {
    Text = "Efecto avanzado"
  },
  TipsType_10372_Desc = {
    Text = "Información del dominio"
  },
  TipsType_10373_Desc = {
    Text = "Cada vez que usas 1 carta de daño, el tentáculo causa {s1} puntos de daño a un enemigo aleatorio."
  },
  TipsType_10374_Desc = {
    Text = "No hay temas pendientes"
  },
  TipsType_10375_Desc = {
    Text = "No hay temas archivados"
  },
  TipsType_10376_Desc = {
    Text = "Investigación incompleta"
  },
  TipsType_10377_Desc = {
    Text = "No se puede retroceder"
  },
  TipsType_10378_Desc = {
    Text = "(Los siguientes temas se han archivado automáticamente)"
  },
  TipsType_10379_Desc = {
    Text = "Tarea objetivo completada"
  },
  TipsType_10380_Desc = {
    Text = "No tiene este objeto"
  },
  TipsType_10381_Desc = {
    Text = "Índice incorrecto"
  },
  TipsType_10382_Desc = {
    Text = "No desbloqueado"
  },
  TipsType_10383_Desc = {
    Text = "Actualización de carta exclusiva, sin intentos"
  },
  TipsType_10384_Desc = {
    Text = "¡1 ranura de creación desbloqueada!"
  },
  TipsType_10385_Desc = {
    Text = "Tasa de conexión aumentada"
  },
  TipsType_10386_Desc = {
    Text = "No hay información de ranuras"
  },
  TipsType_10387_Desc = {
    Text = "Fondos insuficientes"
  },
  TipsType_10388_Desc = {
    Text = "Nivel máximo alcanzado"
  },
  TipsType_10389_Desc = {
    Text = "En desarrollo, espéralo"
  },
  TipsType_10390_Desc = {
    Text = "No hay más ranuras de actualización manual"
  },
  TipsType_10391_Desc = {
    Text = "Disponible en la tienda o campamento tras romper el sello"
  },
  TipsType_10392_Desc = {
    Text = "Pierde {s1} de resistencia en esta batalla"
  },
  TipsType_10393_Desc = {
    Text = "Energía del Despertado llena, no se puede aumentar más"
  },
  TipsType_10394_Desc = {
    Text = "Energía de todos los Despertados completamente aumentada"
  },
  TipsType_10395_Desc = {
    Text = "Requiere usar el \"Ojo\" para desbloquear"
  },
  TipsType_10396_Desc = {
    Text = "Impresión exitosa"
  },
  TipsType_10397_Desc = {
    Text = "Ya en combate {s1} Despertado, el equipo tendrá la característica de dominio {s2}"
  },
  TipsType_10398_Desc = {
    Text = "El equipo se volverá neutral, sin características de dominio"
  },
  TipsType_10399_Desc = {
    Text = "El sistema de microciclo se verifica en el capítulo cuatro"
  },
  TipsType_10400_Desc = {
    Text = "Se pueden heredar hasta {s1} creaciones, reduce la cantidad seleccionada primero"
  },
  TipsType_10401_Desc = {
    Text = "Creación no seleccionada no puede ser heredada"
  },
  TipsType_10405_Desc = {
    Text = "Obtener {s1}"
  },
  TipsType_10406_Desc = {
    Text = "Límite de unidades activadas alcanzado"
  },
  TipsType_10407_Desc = {
    Text = "No se puede desafiar esta Torre Dorada"
  },
  TipsType_10408_Desc = {
    Text = "Esta Torre Dorada no está desbloqueada- completa la mazmorra de investigación requerida"
  },
  TipsType_10409_Desc = {
    Text = "Elige al Despertado que luchará"
  },
  TipsType_10410_Desc = {
    Text = "El despertador está trabajando para completar la tarea de asignación, vuelve más tarde a recogerlo"
  },
  TipsType_10411_Desc = {
    Text = "Has reclamado {s1} cupones rosa dorada"
  },
  TipsType_10412_Desc = {
    Text = "La recompensa temporal necesita acumularse con el tiempo"
  },
  TipsType_10413_Desc = {
    Text = "\"Plata\" insuficiente"
  },
  TipsType_10414_Desc = {
    Text = "No hay intentos de desafío"
  },
  TipsType_10415_Desc = {
    Text = "Desafío en enfriamiento"
  },
  TipsType_10416_Desc = {
    Text = "No hay oponentes para desafiar"
  },
  TipsType_10417_Desc = {
    Text = "Elige al Despertado que luchará"
  },
  TipsType_10418_Desc = {
    Text = "Elixir de Gnosis insuficiente, no se puede continuar aumentando el nivel"
  },
  TipsType_10419_Desc = {
    Text = "Nivel máximo alcanzado"
  },
  TipsType_10420_Desc = {
    Text = "Despertado no desbloqueado"
  },
  TipsType_10421_Desc = {
    Text = "Desactivar colección exitosa"
  },
  TipsType_10422_Desc = {
    Text = "Intentos de desafío de la línea de trama insuficientes"
  },
  TipsType_10423_Desc = {
    Text = "Estrellas de la línea de trama insuficientes, no se puede barrer"
  },
  TipsType_10424_Desc = {
    Text = "Error en la configuración del equipo de investigación"
  },
  TipsType_10425_Desc = {
    Text = "\"Plata\" insuficiente"
  },
  TipsType_10426_Desc = {
    Text = "Límite de compras de cupones alcanzado hoy"
  },
  TipsType_10427_Desc = {
    Text = "Desbloqueado tras completar el reino de tres estrellas"
  },
  TipsType_10428_Desc = {
    Text = "Obtuviste con éxito {s1} certificados"
  },
  TipsType_10429_Desc = {
    Text = "Obtuviste con éxito {s1} intentos de desafío"
  },
  TipsType_10430_Desc = {
    Text = "Pasar Investigación 4-6 para desbloquear"
  },
  TipsType_10431_Desc = {
    Text = "Pruebas insuficientes"
  },
  TipsType_10432_Desc = {
    Text = "Número de compras con comprobante insuficiente"
  },
  TipsType_10433_Desc = {
    Text = "Nivel de iluminar alcanzó el límite"
  },
  TipsType_10434_Desc = {
    Text = "{s1} insuficiente"
  },
  TipsType_10435_Desc = {
    Text = "No hay este producto a la venta"
  },
  TipsType_10436_Desc = {
    Text = "No hay este tipo de tienda"
  },
  TipsType_10437_Desc = {
    Text = "El artículo en venta está agotado"
  },
  TipsType_10438_Desc = {
    Text = "No hay datos de la tienda"
  },
  TipsType_10439_Desc = {
    Text = "No hay recargas disponibles"
  },
  TipsType_10440_Desc = {
    Text = "Hoy, el límite de compras de \"Morfina\" ha sido alcanzado."
  },
  TipsType_10441_Desc = {
    Text = "Fragmentos del Despertado insuficientes"
  },
  TipsType_10442_Desc = {
    Text = "Punto de iluminar activado"
  },
  TipsType_10443_Desc = {
    Text = "El punto de iluminación previo no está activado"
  },
  TipsType_10444_Desc = {
    Text = "Éxito al comprar \"Morfina\" × {s1}."
  },
  TipsType_10445_Desc = {
    Text = "\"Morfina\" ha alcanzado el límite"
  },
  TipsType_10446_Desc = {
    Text = "Desbloquear al completar Investigación 1-12"
  },
  TipsType_10447_Desc = {
    Text = "Desbloquear al completar el Prólogo"
  },
  TipsType_10448_Desc = {
    Text = "Desbloquear al completar el Prólogo"
  },
  TipsType_10449_Desc = {
    Text = "Desbloquear al completar Investigación 2-4"
  },
  TipsType_10450_Desc = {
    Text = "Este nivel de habilidad ha alcanzado el máximo"
  },
  TipsType_10451_Desc = {
    Text = "Clase de elevación del despertador insuficiente"
  },
  TipsType_10452_Desc = {
    Text = "Material de mejora de habilidad insuficiente"
  },
  TipsType_10453_Desc = {
    Text = "Desbloquear al completar Investigación 3-15"
  },
  TipsType_10454_Desc = {
    Text = "Desbloquear al completar Investigación 3-7"
  },
  TipsType_10455_Desc = {
    Text = "No se cumplen las condiciones para la mejora de habilidad"
  },
  TipsType_10456_Desc = {
    Text = "En la versión de prueba, cada opción de recarga solo permite una operación de recarga"
  },
  TipsType_10457_Desc = {
    Text = "El origen del despertador de este cuerpo está en enfriamiento, libérelo en el próximo turno"
  },
  TipsType_10458_Desc = {
    Text = "No hay tal configuración en la tabla de recarga"
  },
  TipsType_10459_Desc = {
    Text = "Recarga gratuita ya realizada, no se puede recargar de nuevo"
  },
  TipsType_10460_Desc = {
    Text = "Resonancia activada, no es necesario reactivarla"
  },
  TipsType_10461_Desc = {
    Text = "El precio del objeto {s1} ha cambiado, por favor verifica"
  },
  TipsType_10462_Desc = {
    Text = "Faltan rosas doradas"
  },
  TipsType_10463_Desc = {
    Text = "Insuficientes \"Insignia de entrenamiento\""
  },
  TipsType_10464_Desc = {
    Text = "Pasar Investigación 3-4 para desbloquear"
  },
  TipsType_10465_Desc = {
    Text = "Pasar Investigación 2-16 para desbloquear"
  },
  TipsType_10466_Desc = {
    Text = "Pasar Investigación 3-16 para desbloquear"
  },
  TipsType_10467_Desc = {
    Text = "Pasar Investigación 4-12 para desbloquear"
  },
  TipsType_10468_Desc = {
    Text = "Pasar Investigación 5-12 para desbloquear"
  },
  TipsType_10469_Desc = {
    Text = "Pasar Investigación 6-12 para desbloquear"
  },
  TipsType_10470_Desc = {
    Text = "Pasar Investigación 1-7 para desbloquear"
  },
  TipsType_10471_Desc = {
    Text = "Equipado con éxito"
  },
  TipsType_10472_Desc = {
    Text = "Desmontaje exitoso"
  },
  TipsType_10473_Desc = {
    Text = "Nivel máximo alcanzado"
  },
  TipsType_10474_Desc = {
    Text = "Faltan rosas doradas"
  },
  TipsType_10475_Desc = {
    Text = "Elige materiales"
  },
  TipsType_10476_Desc = {
    Text = "Protegido por bloqueo, desbloquea primero"
  },
  TipsType_10477_Desc = {
    Text = "Nivel no disponible"
  },
  TipsType_10478_Desc = {
    Text = "Fuera de batalla cerrada"
  },
  TipsType_10479_Desc = {
    Text = "El montón de descarte está vacío"
  },
  TipsType_10480_Desc = {
    Text = "Ajustes en la lucha RPG, ganancia de victoria directa actual"
  },
  TipsType_10482_Desc = {
    Text = "Rueda del destino bloqueada"
  },
  TipsType_10483_Desc = {
    Text = "Rueda del destino no encontrada"
  },
  TipsType_10484_Desc = {
    Text = "Rueda del destino alcanzó el nivel máximo"
  },
  TipsType_10485_Desc = {
    Text = "Rueda del destino equipada"
  },
  TipsType_10486_Desc = {
    Text = "Rueda del destino no coincide"
  },
  TipsType_10487_Desc = {
    Text = "Rueda del destino no bloqueada"
  },
  TipsType_10488_Desc = {
    Text = "El pacto en \"alineación del equipo\" y \"asistencia\" no se puede descomponer"
  },
  TipsType_10489_Desc = {
    Text = "La rueda del destino en \"alineación del equipo\" y \"asistencia\" no se puede descomponer"
  },
  TipsType_10490_Desc = {
    Text = "No hay suficiente valor de frenesí, no se puede liberar la explosión de frenesí"
  },
  TipsType_10491_Desc = {
    Text = "Primero reclama el paquete anterior"
  },
  TipsType_10492_Desc = {
    Text = "El pacto actual está bloqueado, desbloquea para consumir como material"
  },
  TipsType_10493_Desc = {
    Text = "La rueda del destino actual está bloqueada, desbloquea para consumir como material"
  },
  TipsType_10494_Desc = {
    Text = "Pasar Investigación 1-7 para desbloquear"
  },
  TipsType_10495_Desc = {
    Text = "Pasar Investigación 1-13 para desbloquear"
  },
  TipsType_10496_Desc = {
    Text = "El nivel del pacto actual ha alcanzado el límite máximo"
  },
  TipsType_10497_Desc = {
    Text = "Tienda reiniciada"
  },
  TipsType_10498_Desc = {
    Text = "Cambio exitoso"
  },
  TipsType_10499_Desc = {
    Text = "Colección exitosa"
  },
  TipsType_10500_Desc = {
    Text = "Apilamiento exitoso"
  },
  TipsType_10501_Desc = {
    Text = "Desafío no desbloqueado"
  },
  TipsType_10502_Desc = {
    Text = "El despertar está en otro nivel de {s1}, no puede volver a luchar"
  },
  TipsType_10503_Desc = {
    Text = "No hay suficientes unidades activadas para el desafío"
  },
  TipsType_10504_Desc = {
    Text = "Pasar Investigación 3-7 para desbloquear"
  },
  TipsType_10505_Desc = {
    Text = "Desbloqueo al alcanzar 3 estrellas en el nivel 1"
  },
  TipsType_10506_Desc = {
    Text = "Desbloqueo al alcanzar 3 estrellas en el nivel 2"
  },
  TipsType_10507_Desc = {
    Text = "Desbloqueo al alcanzar 3 estrellas en el nivel 3"
  },
  TipsType_10508_Desc = {
    Text = "Desbloqueo al alcanzar 3 estrellas en el nivel 4"
  },
  TipsType_10509_Desc = {
    Text = "Desbloqueo al alcanzar 3 estrellas en el nivel 5"
  },
  TipsType_10510_Desc = {
    Text = "Desbloqueo al alcanzar 3 estrellas en el nivel 6"
  },
  TipsType_10511_Desc = {
    Text = "Desbloqueo al alcanzar 3 estrellas en el nivel 7"
  },
  TipsType_10512_Desc = {
    Text = "Desbloqueo al alcanzar 3 estrellas en el nivel 8"
  },
  TipsType_10513_Desc = {
    Text = "Por favor, elija el pacto que desea fortalecer"
  },
  TipsType_10514_Desc = {Text = "Recibido"},
  TipsType_10515_Desc = {
    Text = "Pasar Investigación 2-14 para desbloquear"
  },
  TipsType_10516_Desc = {
    Text = "Pasar Investigación 4-7 para desbloquear"
  },
  TipsType_10517_Desc = {
    Text = "Pasar Investigación 4-7 para desbloquear"
  },
  TipsType_10518_Desc = {
    Text = "Alineación guardada"
  },
  TipsType_10519_Desc = {
    Text = "Toca la zona iluminada para moverte"
  },
  TipsType_10520_Desc = {
    Text = "El nombre del equipo no puede contener caracteres que no sean chinos, ingleses o números"
  },
  TipsType_10521_Desc = {
    Text = "El nombre del equipo no puede tener más de 8 caracteres"
  },
  TipsType_10522_Desc = {
    Text = "El equipo necesita {s1} Despertados para investigar"
  },
  TipsType_10523_Desc = {
    Text = "El despertador ha participado en otras batallas en esta capa de reino oscuro"
  },
  TipsType_10524_Desc = {
    Text = "El equipo ya tiene dos despertados de dominios diferentes, no se pueden seleccionar más despertados de otros dominios"
  },
  TipsType_10525_Desc = {
    Text = "Selecciona un Despertado"
  },
  TipsType_10526_Desc = {
    Text = "No se pueden seleccionar más despertadores"
  },
  TipsType_10527_Desc = {
    Text = "Atención de desarrollo: en la inmersión fantasmal, el nivel del despertador y el nivel de habilidad se ajustan a 1"
  },
  TipsType_10528_Desc = {
    Text = "El nombre del equipo no puede estar vacío"
  },
  TipsType_10529_Desc = {
    Text = "Un despertador en el equipo está exhausto y no puede seguir luchando"
  },
  TipsType_10530_Desc = {
    Text = "Todos los adjuntos del buzón han sido reclamados"
  },
  TipsType_10531_Desc = {
    Text = "Completa el prólogo para desbloquear"
  },
  TipsType_10532_Desc = {
    Text = "Mochila llena, no se ha completado la recogida, limpia la mochila para continuar"
  },
  TipsType_10533_Desc = {
    Text = "Mochila llena, las recompensas se enviarán al correo"
  },
  TipsType_10534_Desc = {
    Text = "La mochila está llena, no se ha recogido todo el material, se debe limpiar la mochila antes de seguir recogiendo"
  },
  TipsType_10535_Desc = {
    Text = "No hay archivos adjuntos en la carta"
  },
  TipsType_10536_Desc = {
    Text = "Primero canjea la creación"
  },
  TipsType_10537_Desc = {
    Text = "Desbloquear al completar Investigación 2-4"
  },
  TipsType_10538_Desc = {
    Text = "Desbloquear al completar Investigación 1-12"
  },
  TipsType_10539_Desc = {
    Text = "Desbloquear al completar Investigación 1-12"
  },
  TipsType_10540_Desc = {
    Text = "Desbloquear al completar Investigación 1-12"
  },
  TipsType_10541_Desc = {
    Text = "Desbloqueo al alcanzar 3 estrellas en el nivel 9"
  },
  TipsType_10542_Desc = {
    Text = "Desbloqueo al alcanzar 3 estrellas en el nivel 10"
  },
  TipsType_10543_Desc = {
    Text = "Desbloqueo al alcanzar 3 estrellas en el nivel 11"
  },
  TipsType_10544_Desc = {
    Text = "Desbloqueo al alcanzar 3 estrellas en el nivel 12"
  },
  TipsType_10545_Desc = {
    Text = "Desbloqueo al alcanzar 3 estrellas en el nivel 13"
  },
  TipsType_10546_Desc = {
    Text = "Desbloqueo al alcanzar 3 estrellas en el nivel 14"
  },
  TipsType_10547_Desc = {
    Text = "Esta función será eliminada"
  },
  TipsType_10548_Desc = {
    Text = "Desbloquear al completar Investigación 1-7"
  },
  TipsType_10549_Desc = {
    Text = "Límite de obtención de creación alcanzado, no se puede obtener más"
  },
  TipsType_10550_Desc = {
    Text = "¡Enlace completado con {s1}, ahora puedes comandarla en batalla!"
  },
  TipsType_10551_Desc = {
    Text = "El nivel y el nivel de habilidad de {s1} han superado el nivel proporcionado por el amplificador de gnosis, no se puede usar"
  },
  TipsType_10552_Desc = {
    Text = "El nivel del despertador y el nivel de habilidad han superado el nivel proporcionado por el amplificador de gnosis y no se puede usar"
  },
  TipsType_10553_Desc = {
    Text = "Próximamente"
  },
  TipsType_10554_Desc = {
    Text = "Desbloqueado después de pasar el nivel anterior"
  },
  TipsType_10555_Desc = {
    Text = "No hay vuelta atrás en el camino frágil"
  },
  TipsType_10556_Desc = {
    Text = "No disponible, próximamente"
  },
  TipsType_10557_Desc = {
    Text = "Ya tienes esta creación, no se puede obtener de nuevo"
  },
  TipsType_10558_Desc = {
    Text = "Próximo a obtener el contenido del portapapeles del sistema y realizar <Positive:[Pegar]>.\n¿Confirmar?"
  },
  TipsType_10558_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10558_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10558_Title = {
    Text = "Activar función de pegar"
  },
  TipsType_10559_Desc = {
    Text = "Material de elevación insuficiente"
  },
  TipsType_10560_Desc = {
    Text = "Ya en estado inicial"
  },
  TipsType_10561_Desc = {
    Text = "Faltan rosas doradas"
  },
  TipsType_10562_Desc = {Text = "No elevado"},
  TipsType_10563_Desc = {
    Text = "Reinicio de resonancia exitoso"
  },
  TipsType_10564_Desc = {
    Text = "Nivel de investigación {s1} alcanzado"
  },
  TipsType_10565_Desc = {
    Text = "La locura sellada no puede liberarse"
  },
  TipsType_1056601_Desc = {
    Text = "Comunicación de núcleo de plata anormal, por favor verifica la red y vuelve a intentar ({s1})"
  },
  TipsType_10566_Desc = {
    Text = "Comunicación de núcleo de plata anormal, por favor intenta de nuevo más tarde ({s1})"
  },
  TipsType_10567_Desc = {
    Text = "¡Error al obtener información del servidor! {s1}"
  },
  TipsType_10568_Desc = {
    Text = "Primero selecciona el servidor"
  },
  TipsType_10569_Desc = {
    Text = "No desbloqueado"
  },
  TipsType_10570_Desc = {
    Text = "Introduce la cuenta"
  },
  TipsType_10571_Desc = {
    Text = "Materiales insuficientes para la activación de resonancia"
  },
  TipsType_10572_Desc = {
    Text = "Punto de resonancia previo no mejorado"
  },
  TipsType_10573_Desc = {
    Text = "Nivel máximo alcanzado"
  },
  TipsType_10574_Desc = {
    Text = "Subida de nivel exitosa"
  },
  TipsType_10575_Desc = {
    Text = "Este despertar no se puede cambiar"
  },
  TipsType_10576_Desc = {
    Text = "No se puede desplegar en esta posición"
  },
  TipsType_10577_Desc = {
    Text = "Cantidad insuficiente de Despertados, no se puede desafiar"
  },
  TipsType_10578_Desc = {
    Text = "No desbloqueado el siguiente nivel"
  },
  TipsType_10579_Desc = {
    Text = "Ya es la última etapa"
  },
  TipsType_10580_Desc = {
    Text = "Límite de experiencia actual alcanzado, no se puede agregar"
  },
  TipsType_10581_Desc = {
    Text = "Ranura de la rueda del destino llena, no se puede agregar"
  },
  TipsType_10582_Desc = {
    Text = "No hay materiales para inserción rápida"
  },
  TipsType_10583_Desc = {
    Text = "Por favor, coloca los materiales en la ranura del destino"
  },
  TipsType_10584_Desc = {
    Text = "No hay ruedas de destino para equipar"
  },
  TipsType_10585_Desc = {
    Text = "Desbloquear al completar Investigación 2-8"
  },
  TipsType_10586_Desc = {
    Text = "Desbloquear al completar Investigación 2-14"
  },
  TipsType_10587_Desc = {
    Text = "Desbloquear al completar Investigación 3-16"
  },
  TipsType_10588_Desc = {
    Text = "Desbloquear al completar Investigación 4-12"
  },
  TipsType_10589_Desc = {
    Text = "Desbloquear al completar Investigación 5-12"
  },
  TipsType_10590_Desc = {
    Text = "Desbloquear al completar Investigación 6-12"
  },
  TipsType_10591_Desc = {
    Text = "Desbloquear al completar Investigación 2-12"
  },
  TipsType_10592_Desc = {
    Text = "Este usuario ha sido prohibido, si tienes dudas contacta al servicio al cliente"
  },
  TipsType_10593_Desc = {
    Text = "Sesión expirada, por favor inicia sesión de nuevo"
  },
  TipsType_10594_Desc = {
    Text = "\"Morfina\" insuficiente"
  },
  TipsType_10595_Desc = {
    Text = "¿Deseas activar \"{s1}\"?"
  },
  TipsType_10595_Title = {
    Text = "Activar talento"
  },
  TipsType_10596_Desc = {
    Text = "Aún no has obtenido este despertar"
  },
  TipsType_10597_Desc = {
    Text = "No hay ruedas de destino para fortalecer"
  },
  TipsType_10598_Desc = {
    Text = "Esta cuenta ha sido prohibida hasta {s1} por violar las reglas, si tienes dudas contacta al servicio al cliente"
  },
  TipsType_10599_Desc = {
    Text = "Pasar Investigación 2-15 para desbloquear"
  },
  TipsType_10600_Desc = {
    Text = "Límite de nivel alcanzado, no se puede agregar más"
  },
  TipsType_10601_Desc = {
    Text = "Desbloquea el registro de crecimiento del Guardián después de completar la investigación 1-7"
  },
  TipsType_10602_Desc = {
    Text = "Desbloquear la misión de Maestría del Reino al completar la Investigación 1-7"
  },
  TipsType_10603_Desc = {
    Text = "No se ha seleccionado material"
  },
  TipsType_10604_Desc = {
    Text = "Inactividad prolongada, salida automática de la mazmorra"
  },
  TipsType_10605_Desc = {
    Text = "¡Cuestionario completado, gracias por tu apoyo!"
  },
  TipsType_10606_Desc = {
    Text = "Material insuficiente para activar"
  },
  TipsType_10607_Desc = {
    Text = "Recompensas semanales agotadas, no recibirás más recompensas tras el desafío. ¿Deseas continuar?"
  },
  TipsType_10607_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10607_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10607_Title = {
    Text = "Consejo de desafío"
  },
  TipsType_10608_Desc = {
    Text = "Mantenimiento del campus en curso, espere a que termine"
  },
  TipsType_10609_Desc = {
    Text = "Invitaste con éxito a {s1} a tu dormitorio"
  },
  TipsType_10610_Desc = {
    Text = "{s1} ya está en tu dormitorio"
  },
  TipsType_10611_Desc = {
    Text = "Red no wifi actual, ¿deseas usar datos móviles para continuar la descarga?"
  },
  TipsType_10611_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10611_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10611_Title = {
    Text = "Confirmación de descarga"
  },
  TipsType_10612_Desc = {
    Text = "Todas las cartas han sido selladas"
  },
  TipsType_10613_Desc = {
    Text = "Error de red, por favor espera"
  },
  TipsType_10614_Desc = {
    Text = "Desafío no desbloqueado"
  },
  TipsType_10615_Desc = {
    Text = "Enfriando, se puede usar en el próximo turno"
  },
  TipsType_10616_Desc = {
    Text = "En selección, solo puede liberar después de elegir"
  },
  TipsType_10617_Desc = {
    Text = "En el estado Sellado, no se puede Exaltar."
  },
  TipsType_10618_Desc = {
    Text = "Nivel promedio del equipo {s1} por debajo del recomendado {s2}, puede ser desafiante, ¿confirmar?"
  },
  TipsType_10618_LeftBtnDesc = {
    Text = "Ir a mejorar"
  },
  TipsType_10618_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10618_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_10619_Desc = {
    Text = "Nivel de investigación {s1} requerido"
  },
  TipsType_10620_Desc = {
    Text = "La conexión de red es deficiente, por favor revise la conexión de Steam o reinicie Steam e intente nuevamente"
  },
  TipsType_10621_Desc = {
    Text = "¿Deseas confirmar el uso de <WeaponEffect_Num:{s1}> como tu nombre?"
  },
  TipsType_10621_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10621_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10621_Title = {
    Text = "Confirmar grabado"
  },
  TipsType_10622_Desc = {
    Text = "Grabado en enfriamiento, se puede volver a grabar en {s1} horas {s2} minutos"
  },
  TipsType_10623_Desc = {
    Text = "Grabado exitoso"
  },
  TipsType_10624_Desc = {
    Text = "El nombre solo puede contener caracteres chinos, ingleses y números"
  },
  TipsType_10625_Desc = {
    Text = "Esta carta será descartada"
  },
  TipsType_10626_Desc = {
    Text = "Activa las siguientes opciones en Steam:\n[Configuración de Steam - En el juego - Habilitar la interfaz de Steam en el juego]\nY reinicia el juego para aplicar los cambios"
  },
  TipsType_10626_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10626_Title = {Text = "Sugerencia"},
  TipsType_10628_Desc = {
    Text = "El nuevo nombre no puede ser el mismo que el actual"
  },
  TipsType_10629_Desc = {
    Text = "Introduce entre {s1} y {s2} caracteres"
  },
  TipsType_10630_Desc = {
    Text = "{s1} puede recrearse tras lograr tres estrellas"
  },
  TipsType_10631_Desc = {
    Text = "Tu cuenta ha sido desconectada por violar las reglas"
  },
  TipsType_10631_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10631_Title = {Text = "Aviso"},
  TipsType_10632_Desc = {
    Text = "Después de completar el desafío, puedes recrear hoy"
  },
  TipsType_10633_Desc = {
    Text = "Esta descomposición consumirá los siguientes materiales, <Blue: no se podrá recuperar después de la descomposición>, ¿confirmar descomposición?"
  },
  TipsType_10633_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10633_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10633_Title = {
    Text = "Confirmar descomposición"
  },
  TipsType_10634_Desc = {
    Text = "Días restantes de la tarjeta mensual superan {s1}, no se puede acumular"
  },
  TipsType_10635_Desc = {
    Text = "No hay suficiente \"Líquido de Origen de Núcleo de Plata\", ¿quieres ir a la extracción de prime de plata?"
  },
  TipsType_10635_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10635_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10635_Title = {
    Text = "Falta de prime de plata"
  },
  TipsType_10636_Desc = {
    Text = "No hay ruedas de destino inactivas"
  },
  TipsType_10637_Desc = {
    Text = "No hay pactos inactivos"
  },
  TipsType_10638_Desc = {
    Text = "No hay espacio para equipar el pacto, deséquipalo e inténtalo de nuevo"
  },
  TipsType_10640_Desc = {
    Text = "¿Retirar todos los pactos de este despertado?"
  },
  TipsType_10640_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10640_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10640_Title = {Text = "Sugerencia"},
  TipsType_10641_Desc = {
    Text = "Cambiar el idioma requiere reiniciar el cliente para que surta efecto, ¿confirmar?"
  },
  TipsType_10641_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10641_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10641_Title = {
    Text = "Confirmar cambio de idioma"
  },
  TipsType_10642_Desc = {
    Text = "Nivel del jugador insuficiente"
  },
  TipsType_10643_Desc = {
    Text = "Entrar en la zona corroída reduce la vida en {s1} puntos"
  },
  TipsType_10644_Desc = {
    Text = "Llave seleccionada"
  },
  TipsType_10645_Desc = {
    Text = "Llave no obtenida"
  },
  TipsType_10646_Desc = {
    Text = "{s1} insuficiente"
  },
  TipsType_10647_Desc = {
    Text = "La investigación del evento aún no ha comenzado, {s1}"
  },
  TipsType_10648_Desc = {
    Text = "La fisura de rotación ha sido actualizada"
  },
  TipsType_10649_Desc = {
    Text = "El número actual de despachos ha alcanzado el límite máximo"
  },
  TipsType_10650_Desc = {
    Text = "No hay personajes SSR desbloqueados"
  },
  TipsType_10651_Desc = {
    Text = "Se requiere alcanzar una cantidad determinada para poder usarlo"
  },
  TipsType_10652_Desc = {
    Text = "Actualmente no tienes avatares ni expresiones de batalla que no hayas adquirido"
  },
  TipsType_10701_Desc = {
    Text = "Ciclo de vida equipado, deséquipalo e inténtalo de nuevo"
  },
  TipsType_10702_Desc = {
    Text = "Solo se pueden equipar dos ruedas del destino SSR cuando la pila adicional de la rueda del destino SSR equipada alcanza 12"
  },
  TipsType_10703_Desc = {
    Text = "El Despertado ya tiene el mismo ciclo de vida equipado, no se puede repetir"
  },
  TipsType_10704_Desc = {
    Text = "El nivel del pacto ha alcanzado el límite"
  },
  TipsType_10705_Desc = {
    Text = "Límite de materiales alcanzado"
  },
  TipsType_10706_Desc = {
    Text = "Se pueden bloquear hasta dos subatributos"
  },
  TipsType_10707_Desc = {
    Text = "Materiales insuficientes para la transcripción"
  },
  TipsType_10708_Desc = {
    Text = "Desbloqueado al elevar el despertador al nivel {s1}"
  },
  TipsType_10709_Desc = {
    Text = "{s1} insuficiente"
  },
  TipsType_10710_Desc = {Text = "Agotado"},
  TipsType_10711_Desc = {
    Text = "Este artículo no está desbloqueado"
  },
  TipsType_10712_Desc = {
    Text = "Materiales consumidos completos"
  },
  TipsType_10713_Desc = {
    Text = "Acumulación de la rueda del destino alcanzó el límite"
  },
  TipsType_10714_Desc = {
    Text = "No se cumplen las condiciones del evento, no se puede seleccionar"
  },
  TipsType_10715_Desc = {
    Text = "Instala la app correspondiente antes de compartir"
  },
  TipsType_10716_Desc = {
    Text = "No se pueden seleccionar más ruedas del destino"
  },
  TipsType_10717_Desc = {
    Text = "No se pueden seleccionar más llaves"
  },
  TipsType_10718_Desc = {
    Text = "Activación exitosa"
  },
  TipsType_10719_Desc = {
    Text = "Sello de mil caras insuficiente. Puedes convertir materiales automáticamente en \"Configuración de intercambio\""
  },
  TipsType_10720_Desc = {
    Text = "Cambiado a velocidad 1x"
  },
  TipsType_10721_Desc = {
    Text = "Cambiado a velocidad 2x"
  },
  TipsType_10722_Desc = {
    Text = "Entrada del campus congestionada, intente más tarde"
  },
  TipsType_10723_Desc = {
    Text = "Guardado exitoso"
  },
  TipsType_10724_Desc = {
    Text = "Error al guardar, permisos de álbum no activados o memoria insuficiente"
  },
  TipsType_10725_Desc = {
    Text = "Materiales insuficientes"
  },
  TipsType_10726_Desc = {
    Text = "Elige una carta"
  },
  TipsType_10727_Desc = {
    Text = "Este despertar ha sido desactivado"
  },
  TipsType_10728_Desc = {
    Text = "La forma de génesis no se puede enviar, por favor selecciona de nuevo"
  },
  TipsType_10736_Desc = {
    Text = "\"Morfina\" suficiente, no necesita ser complementada."
  },
  TipsType_10737_Desc = {
    Text = "Se detectó una nueva versión del juego, reinicie el juego para actualizar y garantizar una experiencia normal"
  },
  TipsType_10738_Desc = {
    Text = "No hay tutoriales pendientes"
  },
  TipsType_10739_Desc = {
    Text = "{s1} ya ha sido desafiado en {s2}, no puede participar de nuevo"
  },
  TipsType_10740_Desc = {
    Text = "Nivel de investigación {s1} por debajo del recomendado {s2}, puede ser desafiante, ¿confirmar?"
  },
  TipsType_10740_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10740_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10740_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_10741_Desc = {
    Text = "Nivel promedio del equipo {s1} y nivel de investigación del guardián {s2} por debajo del recomendado, será muy desafiante, ¿confirmar?"
  },
  TipsType_10741_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10741_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10741_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_10742_Desc = {
    Text = "Los efectos de Ruedas de Destino repetidos no se acumulan, actualmente <Blue:{s1}> tiene Ruedas de Destino sin efecto, se recomienda ajustar antes de investigar.\n¿Desea continuar?"
  },
  TipsType_10742_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10742_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10742_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_10743_Desc = {
    Text = "Sin intentos de ayuda restantes en la Zona de Desastre"
  },
  TipsType_10744_Desc = {
    Text = "Límite de seguidores alcanzado"
  },
  TipsType_10745_Desc = {
    Text = "Fecha de cumpleaños incorrecta, no se puede establecer"
  },
  TipsType_10746_Desc = {
    Text = "Copiado al portapapeles"
  },
  TipsType_10747_Desc = {
    Text = "Me gusta exitoso"
  },
  TipsType_10748_Desc = {
    Text = "{s1} ya es un cuerpo de apoyo despertado"
  },
  TipsType_10749_Desc = {
    Text = "El Despertado de asistencia en batalla no puede estar vacío"
  },
  TipsType_10750_Desc = {
    Text = "Ya has dado me gusta a este Guardián del Secreto hoy"
  },
  TipsType_10751_Desc = {
    Text = "Se pueden mostrar hasta 4 Despertados"
  },
  TipsType_10752_Desc = {
    Text = "El dominio no cumple con los requisitos, no puede entrar"
  },
  TipsType_10753_Desc = {
    Text = "{s1} ya está en el equipo, no se puede seleccionar de nuevo"
  },
  TipsType_10754_Desc = {
    Text = "{s1} reiniciado"
  },
  TipsType_10755_Desc = {
    Text = "Desbloqueo exitoso"
  },
  TipsType_10756_Desc = {
    Text = "No hay materiales apilables disponibles para insertar"
  },
  TipsType_10757_Desc = {
    Text = "{s1} ya ha sido desafiado en esta actividad de hoy, no puede participar de nuevo"
  },
  TipsType_10758_Desc = {
    Text = "El dominio del equipo no cumple con los requisitos"
  },
  TipsType_10761_Desc = {
    Text = "El despertador de forma de génesis no puede participar en combate al mismo tiempo que su forma normal"
  },
  TipsType_10762_Desc = {
    Text = "El despertador de forma de génesis no puede ser mostrado al mismo tiempo que su forma normal"
  },
  TipsType_10799_Desc = {
    Text = "El efecto del conjunto de 6 piezas del pacto <Blue:{s1}> actualmente no está activo debido a la limitación de <Blue:Equipo Único>, se recomienda que el Guardián ajuste el pacto antes de investigar. \n ¿Desea continuar con la investigación?"
  },
  TipsType_10799_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10799_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10799_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_10801_Desc = {
    Text = "El número de planes del pacto ha alcanzado el límite"
  },
  TipsType_10802_Desc = {
    Text = "{s1} ya ha sido utilizado en otros planes de pacto, no se puede guardar el plan"
  },
  TipsType_10803_Desc = {
    Text = "El nombre del plan del pacto no puede estar vacío"
  },
  TipsType_10804_Desc = {
    Text = "Contiene caracteres ilegales, por favor reingrese"
  },
  TipsType_10805_Desc = {Text = "Guardado"},
  TipsType_10806_Desc = {
    Text = "El pacto actual ya ha sido aplicado en {s1}"
  },
  TipsType_10807_Desc = {Text = "Equipado"},
  TipsType_10808_Desc = {Text = "Desarmado"},
  TipsType_10809_Desc = {
    Text = "Equipo actual en combate"
  },
  TipsType_10810_Desc = {
    Text = "El plan del pacto no puede estar vacío"
  },
  TipsType_10811_Desc = {
    Text = "Plan ya equipado"
  },
  TipsType_10812_Desc = {Text = "Equipado"},
  TipsType_10813_Desc = {
    Text = "¿Deseas confirmar la eliminación del plan [{s1}]?"
  },
  TipsType_10813_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10813_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10814_Desc = {
    Text = "El Despertado activado para esta investigación no cumple con los requisitos del equipo."
  },
  TipsType_10815_Desc = {
    Text = "Despertar especial, no se puede ver detalles"
  },
  TipsType_10816_Desc = {
    Text = "\"Credencial de agente\" insuficiente"
  },
  TipsType_10817_Desc = {
    Text = "No hay registros de liquidación, \"desafía\" y espera la liquidación a las 9:00 del día siguiente"
  },
  TipsType_10818_Desc = {
    Text = "Delegación completada hoy, no se puede repetir"
  },
  TipsType_10821_Desc = {
    Text = "Actualmente no hay recursos, por favor vuelve más tarde"
  },
  TipsType_10822_Desc = {
    Text = "Evento finalizado"
  },
  TipsType_10823_Desc = {
    Text = "Solo se puede reabastecer la tienda cuando las semillas especiales se agoten"
  },
  TipsType_10824_Desc = {
    Text = "Se han agotado las reposiciones, no hay más reservas"
  },
  TipsType_10825_Desc = {
    Text = "{s1} insuficiente"
  },
  TipsType_10826_Desc = {
    Text = "Semillas especiales agotadas, elige sembrar para reiniciar"
  },
  TipsType_10827_Desc = {
    Text = "Semillas especiales reiniciadas"
  },
  TipsType_10828_Desc = {
    Text = "Todos los artículos han sido intercambiados, por favor elige restablecer"
  },
  TipsType_10829_Desc = {
    Text = "Reinicio exitoso"
  },
  TipsType_10830_Desc = {
    Text = "Hay Despertados que no se pueden desplegar en el equipo, no se puede investigar"
  },
  TipsType_10831_Desc = {
    Text = "Hay Ruedas de Destino repetidas en el equipo, no se puede entrar en la Zona de Desastre"
  },
  TipsType_10832_Desc = {
    Text = "El equipo no tiene llave equipada, no puede investigar"
  },
  TipsType_10833_Desc = {
    Text = "Hay Ruedas de Destino no equipables en el equipo, no se puede investigar"
  },
  TipsType_10834_Desc = {
    Text = "No se puede equipar el Rueda del Destino en el Despertar de apoyo"
  },
  TipsType_10835_Desc = {
    Text = "No se puede establecer el pacto del despertador para la asistencia en combate"
  },
  TipsType_10836_Desc = {
    Text = "No se puede equipar el Rueda del Destino en el Despertar predefinido de la trama"
  },
  TipsType_10837_Desc = {
    Text = "No se puede establecer el pacto del despertador para el desarrollo del argumento"
  },
  TipsType_10838_Desc = {
    Text = "El número de expresiones en el esquema de expresiones ha alcanzado el límite"
  },
  TipsType_10839_Desc = {
    Text = "Expresión usada, haz clic en la expresión del esquema para quitarla"
  },
  TipsType_10840_Desc = {
    Text = "Enviaste la expresión demasiado rápido"
  },
  TipsType_10841_Desc = {
    Text = "El esquema de expresión no puede estar vacío"
  },
  TipsType_10842_Desc = {
    Text = "Esquema de expresión actualizado"
  },
  TipsType_10843_Desc = {
    Text = "Esta entrada no está desbloqueada"
  },
  TipsType_10844_Desc = {
    Text = "No desbloqueado"
  },
  TipsType_10850_Desc = {
    Text = "Hay llaves no equipables en el equipo, no se puede investigar"
  },
  TipsType_10901_Desc = {Text = "Parálisis"},
  TipsType_10902_Desc = {
    Text = "Se desmayó"
  },
  TipsType_10903_Desc = {
    Text = "No tienes: {s1}"
  },
  TipsType_10904_Desc = {
    Text = "Superar el modo \"normal\" de este capítulo para desbloquear el modo \"recuerdo\" y ver la trama"
  },
  TipsType_10905_Desc = {
    Text = "Completar \"operación\" 1-15·normal para desbloquear la trama \"recuerdo\""
  },
  TipsType_10906_Desc = {
    Text = "Punto de inicio de la realidad insuficiente"
  },
  TipsType_10907_Desc = {
    Text = "Desbloqueado"
  },
  TipsType_10908_Desc = {
    Text = "El nivel de Despertar Espiritual de {s1} está completo, al continuar recibiendo se convertirá en <TipsHighlightText:\"Fragmento de rebobinado de alma ×2>. ¿Confirmas el Despertar?"
  },
  TipsType_10908_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10908_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10908_Title = {
    Text = "Confirmación de Despertar"
  },
  TipsType_10909_Desc = {
    Text = "{s1} ya ha sido despertado, al continuar recibiendo se convertirá en <TipsHighlightText:Fragmento: {s2}*1> y <TipsHighlightText:Sedimentos de la raíz*50>. ¿Confirmas el despertar?"
  },
  TipsType_10909_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10909_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10909_Title = {
    Text = "Confirmación de Despertar"
  },
  TipsType_10910_Desc = {
    Text = "¿Deseas confirmar el despertar de <TipsHighlightText:{s1}>?"
  },
  TipsType_10910_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10910_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10910_Title = {
    Text = "Confirmación de Despertar"
  },
  TipsType_10911_Desc = {
    Text = "Espacio insuficiente"
  },
  TipsType_10912_Desc = {
    Text = "No hay carta de comando en el espacio ultra, no se puede utilizar"
  },
  TipsType_10913_Desc = {
    Text = "Este turno, no se puede usar de nuevo"
  },
  TipsType_10914_Desc = {
    Text = "¿Deseas confirmar la selección de <TipsHighlightText:{s1}>?"
  },
  TipsType_10914_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10914_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10914_Title = {
    Text = "Confirmar elección"
  },
  TipsType_10915_Desc = {
    Text = "Para desbloquear escuadrones, debes seguir el orden establecido y no puedes saltar escuadrones que aún no estén desbloqueados"
  },
  TipsType_10916_Desc = {
    Text = "¿Desea gastar <Blue: {s1} × {s2}> para desbloquear?"
  },
  TipsType_10916_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10916_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10916_Title = {
    Text = "Confirmación de desbloqueo"
  },
  TipsType_10917_Desc = {
    Text = "Desbloqueo exitoso {s1}"
  },
  TipsType_10918_Desc = {
    Text = "Desbloqueo exitoso de {s1}, todo el equipo ha sido desbloqueado"
  },
  TipsType_10919_Desc = {
    Text = "Desbloquear después de completar [{s1}:{s2}]. ¿Deseas ir a [{s1}]?"
  },
  TipsType_10919_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10919_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10919_Title = {
    Text = "No desbloqueado"
  },
  TipsType_10920_Desc = {
    Text = "Acumula {s1}\"Bellota mágica\" en el evento por tiempo limitado \"Inversión de fase\" para desbloquearlo. ¿Ir al evento \"Inversión de fase\"?"
  },
  TipsType_10920_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10920_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10920_Title = {
    Text = "No desbloqueado"
  },
  TipsType_10921_Desc = {
    Text = "No se pueden equipar dos Ruedas del Destino con el mismo atributo principal"
  },
  TipsType_20001_Desc = {
    Text = "Activar confirmación secundaria"
  },
  TipsType_20001_LeftBtnDesc = {Text = "Aceptar"},
  TipsType_20001_Title = {Text = "Título"},
  TipsType_20002_Desc = {
    Text = "Sin confirmación secundaria"
  },
  TipsType_20002_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20002_RightBtnDesc = {Text = "Aceptar"},
  TipsType_20002_Title = {Text = "Título"},
  TipsType_20003_Desc = {
    Text = "Su cuenta ha iniciado sesión en otro dispositivo"
  },
  TipsType_20003_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20003_Title = {
    Text = "Aviso de desconexión"
  },
  TipsType_20004_Desc = {
    Text = "La conexión con el servidor se ha perdido, por favor inicie sesión de nuevo"
  },
  TipsType_20004_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20004_Title = {
    Text = "Aviso de desconexión"
  },
  TipsType_20005_Desc = {
    Text = "Sincronización fallida, ¿volver a intentarlo?"
  },
  TipsType_20005_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20005_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20005_Title = {
    Text = "Sincronización fallida"
  },
  TipsType_20006_Desc = {
    Text = "Desincronización, volverá a la pantalla de inicio en breve"
  },
  TipsType_20006_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20006_Title = {
    Text = "Sincronización fallida"
  },
  TipsType_20007_Desc = {
    Text = "Desincronización, volverá a la pantalla de inicio en breve"
  },
  TipsType_20007_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20007_Title = {
    Text = "Sincronización fallida"
  },
  TipsType_20008_Desc = {
    Text = "El consumo de energía de esta investigación es <Positive:{s1}>, ¿confirma que desea finalizar?"
  },
  TipsType_20008_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20008_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20008_Title = {
    Text = "Terminar exploración"
  },
  TipsType_20009_Desc = {
    Text = "La actualización refrescará los sellos y reliquias. Las veces de despertar del despachador y venta de cartas de comando no se reiniciarán, ¿confirmar?"
  },
  TipsType_20009_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20009_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20009_Title = {
    Text = "Confirmar actualización"
  },
  TipsType_20010_Desc = {
    Text = "No hay suficientes despertares en este dominio, ¿deseas continuar creando el equipo?"
  },
  TipsType_20010_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20010_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20011_Desc = {
    Text = "No se eligió ningún despertador, la alineación no será preservada"
  },
  TipsType_20011_LeftBtnDesc = {
    Text = "Confirmar salida"
  },
  TipsType_20011_RightBtnDesc = {
    Text = "Continuar formando equipo"
  },
  TipsType_20012_Desc = {
    Text = "No se eligió ningún Despertado"
  },
  TipsType_20012_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20013_Desc = {
    Text = "El equipo tiene vacantes, ¿confirmar partida?"
  },
  TipsType_20013_LeftBtnDesc = {Text = "Volver"},
  TipsType_20013_RightBtnDesc = {Text = "Partir"},
  TipsType_20014_Desc = {
    Text = "El equipo ha alcanzado el límite de miembros"
  },
  TipsType_20014_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20015_Desc = {
    Text = "¿Deseas eliminar este equipo?"
  },
  TipsType_20015_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20015_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20016_Desc = {
    Text = "Desbloqueado tras completar {s1}"
  },
  TipsType_20016_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20017_Desc = {
    Text = "Aquí puedes ver la información del mapa y los monstruos derrotados, esta versión aún no está desarrollada"
  },
  TipsType_20017_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20018_Desc = {
    Text = "No cumplido los requisitos para desbloquear el nivel"
  },
  TipsType_20018_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20018_Title = {
    Text = "Exploración rápida"
  },
  TipsType_20019_Desc = {
    Text = "Falta de \"Plata\", ¿deseas ir a la tienda a comprar?"
  },
  TipsType_20019_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20019_RightBtnDesc = {Text = "Ir"},
  TipsType_20020_Desc = {
    Text = "Desbloquea esta dificultad avanzada después de completar {s1}"
  },
  TipsType_20020_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20021_Desc = {
    Text = "{s1} desbloquea entrenamiento avanzado tras completar modo normal"
  },
  TipsType_20021_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20022_Desc = {
    Text = "Falta de \"Plata\", ¿deseas comprar?"
  },
  TipsType_20022_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20022_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20022_Title = {
    Text = "Falta de núcleo de plata"
  },
  TipsType_20023_Desc = {
    Text = "Esta mejora excede {s1} puntos de experiencia (no reembolsable), y el personaje no puede ganar más experiencia al alcanzar el límite de nivel. ¿Continuar?"
  },
  TipsType_20023_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20023_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20024_Desc = {
    Text = "El equipo no está completo, no puede entrar en la mazmorra"
  },
  TipsType_20024_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20026_Desc = {
    Text = "¿Deseas confirmar la carga?"
  },
  TipsType_20026_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20026_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20027_Desc = {
    Text = "¿Deseas confirmar la recuperación de vida?"
  },
  TipsType_20027_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20027_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20028_Desc = {
    Text = "Cerrar esta interfaz abandonará la recogida de [{s1}], ¿deseas continuar?"
  },
  TipsType_20028_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20028_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20029_Desc = {
    Text = "Cerrar esta interfaz saltará este evento (la creación no será eliminada), ¿confirmas?"
  },
  TipsType_20029_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20029_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20030_Desc = {
    Text = "Marcado, la creación no se llevará, ¿deseas renunciar a la herencia?"
  },
  TipsType_20030_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20030_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20031_Desc = {
    Text = "¿Deseas confirmar la salida de la batalla?"
  },
  TipsType_20031_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20031_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20032_Desc = {
    Text = "Nivel no desbloqueado, ¿ir a desbloquearlo completando la investigación?"
  },
  TipsType_20032_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20032_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20032_Title = {
    Text = "No desbloqueado"
  },
  TipsType_20033_Desc = {
    Text = "Intentos de desafío insuficientes, ¿gastar 500 Plata para reiniciar?"
  },
  TipsType_20033_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20033_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20034_Desc = {
    Text = "Enfriamiento de desafío, ¿gastar \"Plata\" × 50 para reiniciar?"
  },
  TipsType_20034_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20034_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20035_Desc = {
    Text = "Nivel recomendado {s1}, el nivel promedio del equipo actual es {s2}, la investigación encontrará obstáculos, ¿deseas continuar?"
  },
  TipsType_20035_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20035_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20035_Title = {
    Text = "Poder de combate insuficiente"
  },
  TipsType_20036_Desc = {
    Text = "Barrido configurado en {s1}, pero el desafío solo consume {s2} energía por recompensa, ¿confirmar desafío?"
  },
  TipsType_20036_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20036_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20036_Title = {
    Text = "Confirmación de desafío"
  },
  TipsType_20037_Desc = {
    Text = "Los materiales de fortalecimiento incluyen materiales avanzados, ¿confirmar fortalecimiento?"
  },
  TipsType_20037_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20037_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20037_Title = {
    Text = "Confirmación de fortalecimiento"
  },
  TipsType_20038_Desc = {
    Text = "Este equipo está bloqueado, ¿desea desbloquearlo?"
  },
  TipsType_20038_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20038_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20039_Desc = {
    Text = "Confirmar fallar esta investigación, no se recibirán recompensas posteriores. ¿Terminar investigación?"
  },
  TipsType_20039_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20039_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20039_Title = {
    Text = "Salir de la investigación"
  },
  TipsType_20040_Desc = {
    Text = "<WeaponEffect_Num:Salir ahora te costará {s1} Morfina.> La investigación fallará, no se podrán obtener recompensas posteriores. ¿Deseas continuar?"
  },
  TipsType_20040_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20040_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20040_Title = {
    Text = "Salir de la investigación"
  },
  TipsType_20041_BottomDesc = {
    Text = "Posees permisos de compresión de tiempo: {s1}"
  },
  TipsType_20041_Desc = {
    Text = "¿Gastar{s1} permisos de compresión del tiempo para acelerar?"
  },
  TipsType_20041_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20041_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20041_Title = {
    Text = "Confirmación de aceleración"
  },
  TipsType_20042_Desc = {
    Text = "Ajustes en la lucha RPG, ganancia de victoria directa actual"
  },
  TipsType_20042_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20042_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20043_Desc = {
    Text = "¿Deseas gastar {s1} núcleos de plata para refrescar la misión actual?"
  },
  TipsType_20043_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20043_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20043_Title = {
    Text = "Actualización de misión"
  },
  TipsType_20044_BottomDesc = {
    Text = "Agotamiento: {s1} Permiso de investigación"
  },
  TipsType_20044_Desc = {
    Text = "¿Deseas realizar la investigación de {s1}?\nEfecto de investigación: {s2}"
  },
  TipsType_20044_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20044_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20044_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20045_BottomDesc = {
    Text = "Cancelar investigación sin guardar progreso"
  },
  TipsType_20045_Desc = {
    Text = "¿Cancelar la investigación de {s1}? (Se reembolsará el permiso de investigación completo)"
  },
  TipsType_20045_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20045_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20045_Title = {
    Text = "Investigación cancelada"
  },
  TipsType_20046_Desc = {
    Text = "¿Deseas usar {s1} \"Plata\" para acelerar?"
  },
  TipsType_20046_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20046_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20046_Title = {
    Text = "Confirmación de aceleración"
  },
  TipsType_20047_Desc = {
    Text = "Faltan {s1} <Blue:\"{s2}\">, ¿quieres gastar <Blue:\"Plata\"×{s3}> para comprar?"
  },
  TipsType_20047_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20047_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20047_Title = {
    Text = "Confirmar compra"
  },
  TipsType_20048_Desc = {
    Text = "Faltan {s1} <Blue:\"{s2}\">, ¿quieres gastar <Blue:\"Plata\"×{s3}> para comprar?"
  },
  TipsType_20048_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20048_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20048_Title = {
    Text = "Confirmar compra"
  },
  TipsType_20049_Desc = {
    Text = "<Blue:\"{s1}\"> está equipado por <Blue:\"{s2}\">, ¿confirmar cambio?"
  },
  TipsType_20049_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20049_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20049_Title = {
    Text = "Aviso de cambio"
  },
  TipsType_20050_Desc = {
    Text = "Consumir Rueda del Destino ya apilada, ¿confirmar?"
  },
  TipsType_20050_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20050_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20050_Title = {
    Text = "Consejo de apilamiento"
  },
  TipsType_20051_Desc = {
    Text = "El nivel de apilamiento excederá el límite del ciclo de vida, se devolverán los ciclos excedentes. ¿Confirmar?"
  },
  TipsType_20051_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20051_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20051_Title = {
    Text = "Consejo de apilamiento"
  },
  TipsType_20052_Desc = {
    Text = "Nivel recomendado {s1}, el nivel promedio del equipo actual es {s2}, la investigación encontrará obstáculos significativos, ¿deseas continuar?"
  },
  TipsType_20052_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20052_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20052_Title = {
    Text = "Poder de combate insuficiente"
  },
  TipsType_20053_Desc = {
    Text = "Nivel recomendado {s1}, el nivel promedio del equipo actual es {s2}, la investigación encontrará grandes obstáculos, ¿deseas continuar?"
  },
  TipsType_20053_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20053_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20053_Title = {
    Text = "Poder de combate insuficiente"
  },
  TipsType_20054_Desc = {
    Text = "Recompensas de desafío reclamadas, continuar no dará más, ¿confirmar?"
  },
  TipsType_20054_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20054_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20054_Title = {
    Text = "Confirmación de desafío"
  },
  TipsType_20055_Desc = {
    Text = "Después de reiniciar, el progreso actual del nivel se restablecerá a 0 estrellas, el registro de batalla del despertador se borrará, ¿confirmar reinicio?"
  },
  TipsType_20055_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20055_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20055_Title = {
    Text = "Confirmar reinicio"
  },
  TipsType_20056_Desc = {
    Text = "Después de completar el desafío, los cuatro Despertados en la formación actual no podrán participar en otros niveles de {s1}, ¿confirmar desafío?"
  },
  TipsType_20056_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20056_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20056_Title = {
    Text = "Confirmación de desafío"
  },
  TipsType_20057_Desc = {
    Text = "La composición del equipo no sigue las recomendaciones del manual de la academia, ¿deseas continuar el desafío?"
  },
  TipsType_20057_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20057_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20057_Title = {
    Text = "Alineación confirmada"
  },
  TipsType_20058_Desc = {
    Text = "El nivel actual ha sido completado con éxito, si deseas intentar nuevamente, primero debes restablecer el progreso del nivel actual a 0 estrellas, y el registro de combate del despertador será borrado, ¿confirmar restablecimiento?"
  },
  TipsType_20058_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20058_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20058_Title = {
    Text = "Confirmar reinicio"
  },
  TipsType_20059_Desc = {
    Text = "El número de despertadores en el equipo no alcanza los cuatro, no se puede entrar en combate"
  },
  TipsType_20059_Title = {
    Text = "Alineación guardada"
  },
  TipsType_20060_BottomDesc = {
    Text = "<Confirmación:Una vez confirmado, no se podrá reactivar>"
  },
  TipsType_20060_Desc = {
    Text = "¿Deseas seleccionar el resultado de este despertar (obtendrás todos los cuerpos y ruedas de destino de este despertar)?"
  },
  TipsType_20060_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20060_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20060_Title = {
    Text = "Confirmar selección"
  },
  TipsType_20061_BottomDesc = {
    Text = "Núcleos de plata actuales: {s1}"
  },
  TipsType_20061_Desc = {
    Text = "¿Deseas usar {s1} \"Plata\" para Despertar de nuevo?\nDespertar de nuevo no conservará los resultados de esta tirada."
  },
  TipsType_20061_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20061_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20061_Title = {Text = "Reactivar"},
  TipsType_20062_Desc = {
    Text = "¿Confirmas eliminar todas las cartas leídas?\nLas cartas con archivos adjuntos no serán eliminadas"
  },
  TipsType_20062_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20062_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20062_Title = {
    Text = "Eliminar leídos"
  },
  TipsType_20063_Desc = {
    Text = "¿Confirmar eliminación?"
  },
  TipsType_20063_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20063_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20063_Title = {
    Text = "Eliminar carta actual"
  },
  TipsType_20064_Desc = {
    Text = "Las cartas eliminadas del cofre no se pueden recuperar,\n¿deseas eliminarlas?"
  },
  TipsType_20064_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20064_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20064_Title = {
    Text = "Eliminar cartas guardadas"
  },
  TipsType_20065_Desc = {
    Text = "¿Confirmar el uso de <Blue:{s1}> para sintetizar <Blue:{s2}>?"
  },
  TipsType_20065_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20065_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20065_Title = {
    Text = "Confirmar síntesis"
  },
  TipsType_20066_Desc = {
    Text = "¿Descomponer <Blue:{s1}> para obtener {s2}?"
  },
  TipsType_20066_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20066_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20066_Title = {
    Text = "Confirmar descomposición"
  },
  TipsType_20067_Desc = {
    Text = "¿Confirmar el consumo de <Blue:{s1}> pactos de calidad SSR, reimprimir <Blue:{s2}> <Blue:{s3}>?"
  },
  TipsType_20067_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20067_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20067_Title = {
    Text = "Confirmación de reimpresión"
  },
  TipsType_20068_Desc = {
    Text = "Todos los despertadores han perdido completamente la capacidad de luchar\n\n¡El único guardián!\n¿Qué vas a elegir ahora?"
  },
  TipsType_20068_LeftBtnDesc = {
    Text = "Repetir combate"
  },
  TipsType_20068_RightBtnDesc = {
    Text = "Retirada temporal"
  },
  TipsType_20068_Title = {
    Text = "Investigación fallida"
  },
  TipsType_20069_Desc = {
    Text = "El despertado seleccionado está lleno de locura, ¿confirmar selección?"
  },
  TipsType_20069_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20069_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20069_Title = {
    Text = "Confirmar selección"
  },
  TipsType_20070_Desc = {
    Text = "¿Confirmar el uso de {s1}?\nEl Despertado con nivel y habilidades mejorados no devolverá los materiales de mejora"
  },
  TipsType_20070_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20070_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20070_Title = {
    Text = "Confirmar amplificación"
  },
  TipsType_20071_Desc = {
    Text = "Con la limitación del nivel de investigación del guardián, el nivel del despertador se elevará a {s1} nivel, los materiales de mejora que falten no serán devueltos. ¿Confirmar la mejora?"
  },
  TipsType_20071_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20071_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20071_Title = {
    Text = "Confirmar amplificación"
  },
  TipsType_20072_Desc = {
    Text = "¿Confirmar saltar toda la historia de esta sección?\nNota: Podrás volver a ver la historia al reingresar al nivel"
  },
  TipsType_20072_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20072_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20072_Title = {
    Text = "Saltar escena"
  },
  TipsType_20073_Desc = {
    Text = "¿Confirmar descomposición {s1}, obtener {s2}?\n（El pacto actual ha sido mejorado, la descomposición no devolverá los materiales de mejora）"
  },
  TipsType_20073_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20073_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20073_Title = {
    Text = "Confirmar descomposición"
  },
  TipsType_20074_Desc = {
    Text = "¿Descomponer {s1} para obtener {s2}?\n(La rareza actual del ciclo de vida es alta)"
  },
  TipsType_20074_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20074_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20074_Title = {
    Text = "Confirmar descomposición"
  },
  TipsType_20075_BottomDesc = {
    Text = "Agotamiento: {s1} Permiso de investigación"
  },
  TipsType_20075_Desc = {
    Text = "¿Iniciar investigación sobre{s1}?\nEficiencia de producción: {s2} rosa dorada/cada 6 horas\n——>{s3} rosa dorada/cada 6 horas"
  },
  TipsType_20075_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20075_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20075_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20076_BottomDesc = {
    Text = "Agotamiento: {s1} Permiso de investigación"
  },
  TipsType_20076_Desc = {
    Text = "¿Iniciar investigación sobre{s1}?\nEficiencia de producción: {s2} elixires de gnosis/cada 6 horas\n——>{s3} elixires de gnosis/cada 6 horas"
  },
  TipsType_20076_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20076_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20076_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20077_BottomDesc = {
    Text = "Agotamiento: {s1} Permiso de investigación"
  },
  TipsType_20077_Desc = {
    Text = "¿Iniciar investigación sobre{s1}?\nEficiencia de producción: {s2} huellas de pacto/cada 6 horas\n——>{s3} huellas de pacto/cada 6 horas"
  },
  TipsType_20077_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20077_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20077_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20078_Desc = {
    Text = "¿Confirmar saltar toda esta parte de la historia?\nNota: Podrás volver a ver la historia al reingresar al nivel"
  },
  TipsType_20078_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20078_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20078_Title = {
    Text = "Saltar escena"
  },
  TipsType_20079_Desc = {
    Text = "La llave de plata detecta una crisis mortal, ¿activar el cuerpo de conocimiento de emergencia?\n(Resucitar consumirá 1 uso del cuerpo de conocimiento de emergencia, se obtiene 1 uso automáticamente a las 9 a.m. cada día, usos restantes actuales: {s1}/{s2})"
  },
  TipsType_20079_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20079_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20079_Title = {
    Text = "Confirmación de resurrección"
  },
  TipsType_20080_Desc = {
    Text = "La llave de plata detecta una crisis mortal, ¿activar el cuerpo de conocimiento de emergencia?\n(Resucitar consumirá 1 uso del cuerpo de conocimiento de emergencia, se obtiene 1 uso automáticamente a las 9 a.m. cada día, usos restantes actuales: {s1}/{s2})"
  },
  TipsType_20080_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20080_Title = {
    Text = "Confirmación de resurrección"
  },
  TipsType_20081_Desc = {
    Text = "Error al inicializar el juego. {s1}"
  },
  TipsType_20081_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20081_Title = {
    Text = "Mensaje de error de inicio de sesión"
  },
  TipsType_20082_Desc = {
    Text = "¿Deseas usar <Blue:\"Plata\" × {s1} > para comprar <Blue: {s2} > niveles?"
  },
  TipsType_20082_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20082_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20082_Title = {
    Text = "Subir de nivel"
  },
  TipsType_20083_Desc = {
    Text = "¿Consumir la rueda del destino {s1} para confirmar el refuerzo?"
  },
  TipsType_20083_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20083_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20083_Title = {
    Text = "Confirmar consumo"
  },
  TipsType_20084_Desc = {
    Text = "El nivel promedio del equipo es inferior al recomendado para la misión, las estadísticas de los avatares se reducirán, ¿aún deseas investigar?"
  },
  TipsType_20084_LeftBtnDesc = {
    Text = "Ir a mejorar"
  },
  TipsType_20084_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20084_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20085_Desc = {
    Text = "Confirmar salida del juego"
  },
  TipsType_20085_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20085_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20085_Title = {
    Text = "Salir del juego"
  },
  TipsType_20086_Desc = {
    Text = "Mantenimiento del servidor en curso"
  },
  TipsType_20086_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20086_Title = {
    Text = "Aviso de desconexión"
  },
  TipsType_20087_Desc = {
    Text = "¿Deseas confirmar el uso de <TipsHighlightText:{s1} × {s2}> para desbloquear <TipsHighlightText:{s3}>?"
  },
  TipsType_20087_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20087_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20087_Title = {
    Text = "Confirmar activación"
  },
  TipsType_20088_Desc = {
    Text = "Al recibirlo, la \"Morfina\" se desbordará, y la parte que supere {s1} no podrá ser adquirida.\n¿Deseas continuar?"
  },
  TipsType_20088_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20088_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20088_Title = {
    Text = "Menofín desbordado"
  },
  TipsType_20089_Desc = {
    Text = "Consume <Blue:{s1}> vales de Rosa para refrescar el inventario\nRestantes refrescos: <Blue:{s2}>\nCuantos más refrescos, mayor es la cantidad de vales de Rosa requerida."
  },
  TipsType_20089_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20089_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20089_Title = {
    Text = "Actualizar inventario"
  },
  TipsType_20090_Desc = {
    Text = "Cantidad máxima de Ruedas del Destino alcanzada. Debes limpiar Ruedas del Destino antes de poder despertar. ¿Ir ahora?\n\n<color=#ADC0CB>*Puedes configurar la descomposición automática de Ruedas del Destino de grado SR/R en \"Ajustes\"</color>"
  },
  TipsType_20090_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20090_RightBtnDesc = {
    Text = "Ir a limpiar"
  },
  TipsType_20090_Title = {
    Text = "Sugerencia de limpieza"
  },
  TipsType_20091_Desc = {
    Text = "El número de pactos ha alcanzado el límite, necesitas limpiar los pactos antes de continuar la investigación, ¿ir ahora?"
  },
  TipsType_20091_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20091_RightBtnDesc = {
    Text = "Ir a limpiar"
  },
  TipsType_20091_Title = {
    Text = "Sugerencia de limpieza"
  },
  TipsType_20092_Desc = {
    Text = "¿Deseas confirmar la eliminación de todo el equipo del cuerpo despertado actual?"
  },
  TipsType_20092_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20092_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20092_Title = {
    Text = "Confirmar desmontaje"
  },
  TipsType_20093_Desc = {
    Text = "¿Confirmar la mejora del pacto consumido?"
  },
  TipsType_20093_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20093_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20093_Title = {
    Text = "Confirmación de mejora"
  },
  TipsType_20094_Desc = {
    Text = "El nuevo atributo secundario es mejor, no se guardará el actual. ¿Confirmar reemplazo?"
  },
  TipsType_20094_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20094_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20094_Title = {
    Text = "Confirmar reemplazo"
  },
  TipsType_20095_Desc = {
    Text = "Hay buenas subatribuciones en la transcripción, continuar no las guardará, ¿confirmar?"
  },
  TipsType_20095_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20095_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20095_Title = {
    Text = "Confirmación de transcripción"
  },
  TipsType_20096_Desc = {
    Text = "Después de la actualización del pacto, excederá el límite de nivel. Se devolverán los materiales de transcripción sobrantes. ¿Confirmar?"
  },
  TipsType_20096_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20096_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20096_Title = {
    Text = "Confirmación de mejora"
  },
  TipsType_20097_Desc = {
    Text = "El Despertar Espiritual de este Cuerpo Despertado está completo.\nAl seleccionarlo solo obtendrás \"Fragmento de Rebobinado de Alma\" ×1"
  },
  TipsType_20097_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20097_RightBtnDesc = {Text = "Continuar"},
  TipsType_20097_Title = {
    Text = "Confirmar selección"
  },
  TipsType_20098_Desc = {
    Text = "Este artículo se puede comprar con <Blue:{s1}> certificados de plata"
  },
  TipsType_20098_LeftBtnDesc = {
    Text = "Pago en efectivo"
  },
  TipsType_20098_RightBtnDesc = {
    Text = "Pago con comprobante"
  },
  TipsType_20098_Title = {
    Text = "Seleccionar método de liquidación"
  },
  TipsType_20099_Desc = {
    Text = "¿Deseas salir del juego?"
  },
  TipsType_20099_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20099_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20099_Title = {Text = "Sugerencia"},
  TipsType_20100_Desc = {
    Text = "Se detectó una nueva versión del juego, reinicie el juego para actualizar los recursos"
  },
  TipsType_20100_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20100_Title = {
    Text = "Aviso de actualización"
  },
  TipsType_20101_Desc = {
    Text = "Investigación completada, ¿quieres saltar la historia al investigar de nuevo?"
  },
  TipsType_20101_LeftBtnDesc = {
    Text = "Saltar escena"
  },
  TipsType_20101_RightBtnDesc = {
    Text = "Guardar trama"
  },
  TipsType_20101_Title = {
    Text = "Confirmación de la trama"
  },
  TipsType_20102_Desc = {
    Text = "¿Dejar de seguir a {s1}?"
  },
  TipsType_20102_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20102_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20102_Title = {
    Text = "Dejar de seguir"
  },
  TipsType_20103_Desc = {
    Text = "Durante el evento <WeaponEffect_Num:Desbloqueo gratuito limitado>, ¿desbloquear?"
  },
  TipsType_20103_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20103_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20103_Title = {
    Text = "Beneficios de la actividad"
  },
  TipsType_20105_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_20105_LeftBtnDesc = {Text = "Salir"},
  TipsType_20105_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20105_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20106_Desc = {
    Text = "¿Gastar <Blue:\"Líquido de Origen de Núcleo de Plata\" ×  {s1} > para comprar?"
  },
  TipsType_20106_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20106_RightBtnDesc = {Text = "Comprar"},
  TipsType_20106_Title = {
    Text = "Confirmar compra"
  },
  TipsType_20107_Desc = {
    Text = "¿Estás seguro de que deseas seleccionar <Blue:{s1}>?"
  },
  TipsType_20107_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20107_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20107_Title = {
    Text = "Elige confirmar"
  },
  TipsType_20108_Desc = {
    Text = "Esta apilación consumirá el raro “maestro del bucle” \n ¿Desea continuar?"
  },
  TipsType_20108_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20108_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20108_Title = {
    Text = "Confirmar consumo"
  },
  TipsType_20109_Desc = {
    Text = "¿Reiniciar esta batalla?"
  },
  TipsType_20109_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20109_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20109_Title = {
    Text = "Repetir combate"
  },
  TipsType_20110_Desc = {
    Text = "¿Confirmar {s1} de {s2} como tu cumpleaños?\nNo se podrá cambiar después de confirmar"
  },
  TipsType_20110_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20110_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20110_Title = {
    Text = "Confirmación de cumpleaños"
  },
  TipsType_20111_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar las siguientes etapas de investigación."
  },
  TipsType_20111_LeftBtnDesc = {Text = "Salir"},
  TipsType_20111_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20111_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20112_Desc = {
    Text = "Para asegurar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_20112_LeftBtnDesc = {Text = "Salir"},
  TipsType_20112_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20112_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20113_Desc = {
    Text = "¿Deseas marcar todo el contenido educativo como leído y recibir las recompensas? (Se recomienda a los nuevos guardianes leer detenidamente el contenido educativo~)"
  },
  TipsType_20113_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20113_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20113_Title = {
    Text = "Lectura de confirmación con un clic"
  },
  TipsType_20114_Desc = {
    Text = "¿Confirmar selección de <WeaponEffect_Num:{s1}> para iniciar retroceso?\nEsta acción no se puede deshacer, por favor confirma con cuidado"
  },
  TipsType_20114_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20114_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20114_Title = {
    Text = "Selección de retroceso"
  },
  TipsType_201151_Desc = {
    Text = "El Despertado actual no ha sido iluminado, no es necesario realizar un retroceso de iluminación"
  },
  TipsType_20115_Desc = {
    Text = "El despertar no ha sido desarrollado, no necesita retroceso"
  },
  TipsType_20116_Desc = {
    Text = "<WeaponEffect_Num:{s1}>Reversión activada.\n¿Ir ahora para revertir?"
  },
  TipsType_20116_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20116_RightBtnDesc = {Text = "Ir"},
  TipsType_20116_Title = {
    Text = "Activación exitosa"
  },
  TipsType_20117_Desc = {
    Text = "Pronto se restablecerán los estados de mejora, ascenso, habilidad, talento y profundización del conocimiento del Despertado, y se reembolsará el consumo correspondiente. \n¿Confirmar la Regresión de Crianza para <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20117_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20117_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20117_Title = {
    Text = "Reinicio de Desarrollo"
  },
  TipsType_20118_Desc = {
    Text = "Pronto se reseteará el nivel de iluminación del despertador y se reembolsará el consumo de iluminación.\n¿Confirmar el retroceso de iluminación a <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20118_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20118_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20118_Title = {
    Text = "Reinicio Espiritual"
  },
  TipsType_20119_Desc = {
    Text = "Pronto se restablecerán los estados de mejora, ascenso, habilidades, Despertar Espiritual, talento y profundización de la Gnosis del Despertado, y se reembolsará el consumo correspondiente, \n además se devolverá el Despertado a la charca negra. \n ¿Confirmar el reembolso a <WeaponEffect_Num:{s1}> en la charca negra?"
  },
  TipsType_20119_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20119_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20119_Title = {
    Text = "Retorno de Génesis"
  },
  TipsType_20120_Desc = {
    Text = "No se puede devolver el cuerpo especial despertado"
  },
  TipsType_20121_Desc = {
    Text = "Próximo a restablecer el estado de acumulación del ciclo de vida y devolver todo el consumo de acumulación.\n¿Confirmar la reversión de acumulación para <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20121_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20121_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20121_Title = {
    Text = "Reversión de apilamiento"
  },
  TipsType_20122_Desc = {
    Text = "Pronto se reseteará el estado de apilamiento de la rueda del destino, se reembolsará todo el agotamiento de apilamiento y se devolverá la rueda a la charca negra.\n¿Confirmar el reembolso a <WeaponEffect_Num:{s1}> en la charca negra?"
  },
  TipsType_20122_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20122_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20122_Title = {
    Text = "Retorno de Génesis"
  },
  TipsType_20123_Desc = {
    Text = "Después de completar el desafío, los despertares, ruedas de destino y llaves en el equipo no podrán usarse en otras zonas de desastre. ¿Confirmar?"
  },
  TipsType_20123_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20123_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20123_Title = {
    Text = "Confirmación de desafío"
  },
  TipsType_20124_Desc = {
    Text = "Después de reiniciar, los despertados, ruedas de destino y llaves del equipo de investigación actual podrán volver a usarse, pero se deducirán los puntos de entrenamiento obtenidos en ese nivel (sin afectar las recompensas), ¿confirmar reinicio?"
  },
  TipsType_20124_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20124_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20124_Title = {
    Text = "Confirmar reinicio"
  },
  TipsType_20125_Desc = {
    Text = "Nivel de apilamiento del ciclo de vida en 0, no se necesita retroceso"
  },
  TipsType_20126_Desc = {
    Text = "El despertador actual está en proceso de despachar, por favor devuelve antes de volver o entregar"
  },
  TipsType_20127_Desc = {
    Text = "Ciclo de vida bloqueado, desbloquear antes de devolver"
  },
  TipsType_20128_Desc = {
    Text = "{s1} completado, necesita reiniciar para desafiar de nuevo, ¿confirmar reinicio?\n(Al reiniciar, los cuerpos despertados, ruedas de destino y órdenes clave del equipo de investigación pueden participar de nuevo, pero se deducirán los puntos de entrenamiento obtenidos en esa etapa.)"
  },
  TipsType_20128_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20128_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20128_Title = {
    Text = "Confirmar reinicio"
  },
  TipsType_20129_Desc = {
    Text = "Para asegurar la mejor experiencia de la trama, se recomienda completar las siguientes etapas de investigación."
  },
  TipsType_20129_LeftBtnDesc = {Text = "Salir"},
  TipsType_20129_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20129_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20130_Desc = {
    Text = "Para asegurar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_20130_LeftBtnDesc = {Text = "Salir"},
  TipsType_20130_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20130_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20131_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_20131_LeftBtnDesc = {Text = "Salir"},
  TipsType_20131_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20131_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20132_Desc = {
    Text = "Una vez marcado, si hay suficientes <TipsHighlightText: Restos del Pacto>, se consumirán prioritariamente.\nSi no hay suficientes restos, se consumirá automáticamente <TipsHighlightText:\"{s1}\"> para completar los restos"
  },
  TipsType_20132_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20132_RightBtnDesc = {
    Text = "Aún marcar"
  },
  TipsType_20132_Title = {
    Text = "Reabastecimiento automático"
  },
  TipsType_20133_Desc = {
    Text = "¿Deseas profundizar el conocimiento de <TipsHighlightText:\"{s1}\">?"
  },
  TipsType_20133_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20133_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20133_Title = {
    Text = "Avance Gnóstico"
  },
  TipsType_20134_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_20134_LeftBtnDesc = {Text = "Salir"},
  TipsType_20134_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20134_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20137_Desc = {
    Text = "¿Confirmar el uso de <Blue:\"{s1}\"×{s2}> para desbloquear esta pista?"
  },
  TipsType_20137_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20137_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20137_Title = {
    Text = "Confirmación de desbloqueo"
  },
  TipsType_20138_Desc = {
    Text = "Durante el evento <Blue:Desbloqueo gratuito limitado>, ¿desbloquear?"
  },
  TipsType_20138_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20138_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20138_Title = {
    Text = "Confirmación de desbloqueo"
  },
  TipsType_20139_Desc = {
    Text = "¿Confirmar el uso de <Blue:\"{s1}\"×{s3}> para abrir <Blue:\"{s2}\">?"
  },
  TipsType_20139_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20139_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20139_Title = {
    Text = "Confirmación de desbloqueo"
  },
  TipsType_20140_Desc = {
    Text = "<Blue:{s1}> Límite alcanzado, recibir más no proporcionará este objeto. ¿Aceptar?"
  },
  TipsType_20140_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20140_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20140_Title = {
    Text = "Confirmar recepción"
  },
  TipsType_20141_Desc = {
    Text = "¿Vas a saltar la batalla y eliminar al enemigo por el costo de 30% de la salud máxima ({s1})?\n\nSalud actual: {s2}"
  },
  TipsType_20141_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20141_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20141_Title = {
    Text = "memoria muscular"
  },
  TipsType_20142_Desc = {
    Text = "¿Elegir perder <color=#BB646D> {s1} </color> puntos de vida y obtener {s2} sellos negros?"
  },
  TipsType_20142_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20142_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20142_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20145_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20145_Title = {
    Text = "Recompensas de inicio de sesión"
  },
  TipsType_20151_Desc = {
    Text = "Después de reiniciar, la cantidad restante de \"objetos especiales\" se restablecerá al máximo, ¿confirmar?"
  },
  TipsType_20151_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20151_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20151_Title = {
    Text = "Confirmar reinicio"
  },
  TipsType_20152_Desc = {
    Text = "{s1} es insuficiente, ¿quieres usar un vale de rosa dorada*{s2} para completarlo?"
  },
  TipsType_20152_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20152_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20152_Title = {
    Text = "Confirmación de activación"
  },
  TipsType_20153_Desc = {
    Text = "Después de reiniciar, la cantidad restante de \"objetos especiales\" y \"objetos comunes\" se restablecerá al máximo.\nA partir de la {s1}ª vez, los \"objetos especiales\" ya no se restablecerán.\n¿Confirmar?"
  },
  TipsType_20153_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20153_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20153_Title = {
    Text = "Confirmar reinicio"
  },
  TipsType_20154_Desc = {
    Text = "Después de reiniciar, la cantidad restante de \"objetos especiales\" y \"objetos comunes\" se restablecerá al máximo.\nA partir de la tercera vez, los \"objetos especiales\" ya no se restablecerán.\n <Blue:Aún hay \"objetos comunes\">, ¿confirmar?"
  },
  TipsType_20154_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20154_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20154_Title = {
    Text = "Confirmar reinicio"
  },
  TipsType_20155_Desc = {
    Text = "El material de apilamiento contiene un ciclo de vida bloqueado, ¿confirmar el uso para apilar?"
  },
  TipsType_20155_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20155_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20155_Title = {
    Text = "Confirmación de apilamiento"
  },
  TipsType_20156_Desc = {
    Text = "¿Confirmar el gasto de <TipsHighlightText:Punto de partida real*1> para desbloquear?\n(Durante la actividad Olas de Deseo, el costo para desbloquear el Punto de partida real se reduce de {s1} a {s2}.)"
  },
  TipsType_20156_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20156_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20156_Title = {
    Text = "Confirmación de desbloqueo"
  },
  TipsType_20157_Desc = {
    Text = "¿Confirmar el gasto de <TipsHighlightText:Punto de partida real*{s1}> para desbloquear?"
  },
  TipsType_20157_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20157_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20157_Title = {
    Text = "Confirmación de desbloqueo"
  },
  TipsType_20158_Desc = {
    Text = "Nivel actual caducado, no recibirás recompensas tras completar el desafío, ¿confirmar salida?"
  },
  TipsType_20158_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20158_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20158_Title = {
    Text = "Confirmar salida"
  },
  TipsType_20159_Desc = {
    Text = "<TipsHighlightText:\"{s1}\"> superó el límite de <TipsHighlightText: {s2}> unidades, cada una se ha convertido en <Blue:\"Invitación para el ingrávido\" × 1>"
  },
  TipsType_20159_Title = {
    Text = "Aviso de conversión"
  },
  TipsType_20160_Desc = {
    Text = "Has desbloqueado <TipsHighlightText:\"{s1}\"»>\nEl beneficio gratuito de desbloqueo de este evento te proporcionará la siguiente compensación."
  },
  TipsType_20160_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20160_Title = {
    Text = "Aviso de compensación"
  },
  TipsType_20161_Desc = {
    Text = "La cantidad de <TipsHighlightText:{s1}> que tienes superó el límite de <TipsHighlightText:{s2}> unidades. Cada excedente se ha convertido en <Blue:Rosa dorada*5000>"
  },
  TipsType_20161_Title = {
    Text = "Aviso de conversión"
  },
  TipsType_20162_Desc = {
    Text = "Pronto se restablecerán los estados de mejora, ascenso, habilidad, talento y profundización del conocimiento del Despertado, y se reembolsará el consumo correspondiente. \n¿Confirmar la Regresión de Crianza para <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20162_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20162_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20162_Title = {
    Text = "Reinicio de Desarrollo"
  },
  TipsType_20163_Desc = {
    Text = "Pronto se reseteará el estado de iluminación del Despertado y se reembolsará el consumo correspondiente.\n¿Confirmar la Regresión de Crianza para <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20163_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20163_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20163_Title = {
    Text = "Reinicio Espiritual"
  },
  TipsType_20164_Desc = {
    Text = "Pronto se restablecerán los estados de mejora, ascenso, habilidades, talentos, Despertar Espiritual y profundización de Gnosis del Despertado, y se reembolsará el consumo correspondiente, \n y se devolverá el Despertado a la charca negra. \n ¿Confirmar el reembolso a <WeaponEffect_Num:{s1}> en la charca negra?"
  },
  TipsType_20164_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20164_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20164_Title = {
    Text = "Retorno de Génesis"
  },
  TipsType_20165_Desc = {
    Text = "<WeaponEffect_Num:{s1}> pertenece a un Despertado especial, solo se puede revertir el desarrollo de mejora, ascenso, habilidades, talento y avance gnóstico, <Red:no se puede revertir el desarrollo del Despertar Espiritual>, ¿confirmar la selección de <WeaponEffect_Num:{s1}> para iniciar el retroceso?\nEsta acción no se puede deshacer, por favor confirma con cuidado"
  },
  TipsType_20165_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20165_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20165_Title = {
    Text = "Selección de retroceso"
  },
  TipsType_20166_Desc = {
    Text = "Despertado especial no puede retroceder la iluminación"
  },
  TipsType_20167_Desc = {
    Text = "Este retroceso ya ha utilizado \"regresión de crianza\", por favor realiza \"regresión de crianza\" cuando se active el próximo retroceso."
  },
  TipsType_20168_Desc = {
    Text = "Este retroceso ya ha utilizado \"Iluminar·Retroceder\", por favor realiza \"Iluminar·Retroceder\" cuando se active el próximo retroceso."
  },
  TipsType_20169_BottomDesc = {
    Text = "<Blue:Atención: ¡Una vez seleccionado, no se podrá modificar en este evento!>"
  },
  TipsType_20169_Desc = {
    Text = "¿Confirmas la selección del Despertado <OrangeQuality:\"{s1}\"> y la Rueda del Destino recomendada <OrangeQuality:\"{s2}\"> como UP específica para este evento?"
  },
  TipsType_20169_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20169_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20169_Title = {
    Text = "Confirmar selección"
  },
  TipsType_20170_Desc = {
    Text = "¡Se ha alcanzado el límite de desafíos diarios! Vuelve a intentarlo mañana."
  },
  TipsType_20171_Desc = {
    Text = "¡Ahora puedes acceder a \"Inmersión fantasmal\"!"
  },
  TipsType_20173_Desc = {
    Text = "¡Ahora puedes acceder a \"Traphase\"!"
  },
  TipsType_20174_Desc = {
    Text = "¡Ahora puedes dirigirte a la \"Operación de Investigación · Difícil\"!"
  },
  TipsType_20175_Desc = {
    Text = "¡Ahora puedes dirigirte a la Existencia Trascendental!"
  },
  TipsType_20176_Desc = {
    Text = "¡Ahora puedes acceder a la Zona de Desastre!"
  },
  TipsType_20177_Desc = {
    Text = "¡Ahora puedes dirigirte al Frenzy de Reproducción!"
  },
  TipsType_20178_Desc = {
    Text = "¡Ahora puedes equipar la \"segunda rueda de vida\"!"
  },
  TipsType_20179_Desc = {
    Text = "¡Ahora puedes dirigirte al \"Enjambre del Caos\"!"
  },
  TipsType_20180_Desc = {
    Text = "¡Ahora puedes acceder a \"Compilación Tabú\"!"
  },
  TipsType_20181_Desc = {
    Text = "¡Ahora puedes ir a \"Actualización del pacto\"!"
  },
  TipsType_20182_Desc = {
    Text = "¡Ahora puedes dirigirte a \"Transcripción del pacto\"!"
  },
  TipsType_20183_Desc = {
    Text = "Evento actual finalizado"
  },
  TipsType_20184_Desc = {
    Text = "¡Ahora puedes acceder a \"Notas\"!"
  },
  TipsType_20185_Desc = {
    Text = "¿Confirmar saltar toda esta parte de la historia?"
  },
  TipsType_20185_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20185_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20185_Title = {
    Text = "Saltar escena"
  },
  TipsType_20186_Desc = {
    Text = "Se descargarán los datos necesarios para ejecutar el juego.\n¿Deseas continuar?\n\n*Se recomienda descargar en una red WiFi."
  },
  TipsType_20186_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20186_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20187_Desc = {
    Text = "Recurso descargado"
  },
  TipsType_20187_LeftBtnDesc = {Text = "Confirmar"},
  TipsType_20188_Desc = {
    Text = "Espacio de almacenamiento insuficiente. Se requiere reservar al menos {s1} de espacio disponible, de lo contrario podría ocurrir pérdida de recursos durante la ejecución. ¿Continuar con la descarga?"
  },
  TipsType_20188_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20188_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20189_Desc = {
    Text = "Recurso de descarga fallida, ¿volver a intentarlo?"
  },
  TipsType_20189_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20189_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20190_Desc = {
    Text = "<TipsHighlightText:{s1}> superó el límite de <TipsHighlightText: {s2}> unidades, cada una se ha convertido en <Blue:{s3}>"
  },
  TipsType_20190_Title = {
    Text = "Aviso de conversión"
  },
  TipsType_20191_Desc = {
    Text = "¡Ahora puedes ir al evento!"
  },
  TipsType_20192_Desc = {
    Text = "Se descargarán los datos necesarios para jugar la continuación del prólogo.\nTamaño del recurso: {s1}\n¿Deseas continuar?\n\n*Se recomienda descargar en una red WiFi."
  },
  TipsType_20192_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20192_RightBtnDesc = {Text = "Descargar"},
  TipsType_20193_Desc = {
    Text = "¡Ahora puedes acceder a \"Asignaciones\"!"
  },
  TipsType_20194_Desc = {
    Text = "¡Ahora puedes acceder a \"Comunicación de núcleo de plata\"!"
  },
  TipsType_20195_Desc = {
    Text = "¡Ahora puedes acceder al \"Registro del curso\"!"
  },
  TipsType_20196_Desc = {
    Text = "¡Ahora puedes acceder al \"Reino Oscuro\"!"
  },
  TipsType_20197_Desc = {
    Text = "¡Se ha alcanzado el número máximo de despertares! ¡Por favor, ve a reclamar la recompensa de la misión!"
  },
  TipsType_20198_Desc = {
    Text = "Todavía no has completado la misión. ¡Vuelve a reclamarla cuando la completes!"
  },
  TipsType_20199_Desc = {
    Text = "Al recibir, la \"Credencial de agente\" excederá el límite de posesión,\nno se obtendrá la parte excedente.\n¿Deseas continuar?"
  },
  TipsType_20199_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20199_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20199_Title = {
    Text = "Confirmar recepción"
  },
  TipsType_20200_Desc = {
    Text = "¿Confirmar el uso de <Blue:Credencial de agente*1> para completar instantáneamente la misión diaria?"
  },
  TipsType_20200_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20200_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20200_Title = {
    Text = "Confirmación de Agente"
  },
  TipsType_20201_Desc = {
    Text = "¿El siguiente pacto se está equipando, desea reemplazarlo?"
  },
  TipsType_20201_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20201_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20201_Title = {
    Text = "Confirmar reemplazo"
  },
  TipsType_20202_Desc = {
    Text = "Plan aplicado a {s1}, ¿confirmar eliminación del plan [{s2}]?"
  },
  TipsType_20202_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20202_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20202_Title = {
    Text = "Confirmar eliminación"
  },
  TipsType_20203_Desc = {
    Text = "Los efectos de Ruedas de Destino repetidos no se acumulan, {s1} ya está equipado, ¿confirmar equipamiento?"
  },
  TipsType_20203_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20203_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20203_Title = {
    Text = "Confirmar equipamiento"
  },
  TipsType_20204_Desc = {
    Text = "Actualmente el pacto ya ha sido usado en {s1}, una vez descompuesto será removido de ese plan, ¿confirmar?"
  },
  TipsType_20204_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20204_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20204_Title = {
    Text = "Confirmar eliminación"
  },
  TipsType_20205_Desc = {
    Text = "El pacto actual ya ha sido usado en la alineación {s1}, una vez descompuesto, se quitará ese pacto, ¿confirmar?"
  },
  TipsType_20205_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20205_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20205_Title = {
    Text = "Confirmar eliminación"
  },
  TipsType_20206_Desc = {
    Text = "La rueda del destino actual ya ha sido usada en la alineación {s1}, una vez descompuesta, será removida de la alineación, ¿confirmar?"
  },
  TipsType_20206_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20206_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20206_Title = {
    Text = "Confirmar eliminación"
  },
  TipsType_20207_Desc = {
    Text = "Plan no guardado, salir borrará la edición, ¿confirmar salida?"
  },
  TipsType_20207_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20207_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20207_Title = {
    Text = "Confirmación de guardado"
  },
  TipsType_20208_Desc = {
    Text = "Recompensa de misión recibida, ¡ve a echar un vistazo a otras misiones!"
  },
  TipsType_20209_Desc = {
    Text = "Misión caducada"
  },
  TipsType_20210_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar las siguientes etapas de investigación."
  },
  TipsType_20210_LeftBtnDesc = {Text = "Salir"},
  TipsType_20210_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20210_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20211_Desc = {
    Text = "Se abre en {s1} días {s2} horas"
  },
  TipsType_20212_Desc = {
    Text = "Se abre en {s1} horas {s2} minutos"
  },
  TipsType_20213_Desc = {
    Text = "<WeaponEffect_Num:{s1}>Ha activado la Causalidad Extrema en la formación, cualquier retroceso resultará en la desactivación de la Causalidad Extrema y se eliminará automáticamente de la formación. ¿Confirmar selección de <WeaponEffect_Num:{s1}> para iniciar retroceso?\nEsta acción no se puede deshacer, por favor confirma con cuidado"
  },
  TipsType_20213_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20213_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20213_Title = {
    Text = "Selección de retroceso"
  },
  TipsType_20214_Desc = {
    Text = "Pronto se restablecerá el estado de acumulación de la rueda del destino y se reembolsará todo el consumo de acumulación. \n<WeaponEffect_Num:{s1}> ha activado Causalidad Extrema en la formación, será removido automáticamente de la formación tras la reversión. \n¿Confirmar la reversión de acumulación para <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20214_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20214_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20214_Title = {
    Text = "Reversión de apilamiento"
  },
  TipsType_20215_Desc = {
    Text = "Pronto se reseteará el estado de apilamiento de la rueda del destino, se reembolsará todo el agotamiento de apilamiento y se devolverá la rueda a la charca negra. \n<WeaponEffect_Num:{s1}> ya ha activado la causalidad extrema en la formación, será removida automáticamente de la formación después del reembolso. \n¿Confirmar el reembolso a <WeaponEffect_Num:{s1}> en la charca negra?"
  },
  TipsType_20215_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20215_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20215_Title = {
    Text = "Retorno de Génesis"
  },
  TipsType_20216_Desc = {
    Text = "¿Deseas gastar <Blue:{s1} × {s2}> para comprar?"
  },
  TipsType_20216_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20216_RightBtnDesc = {Text = "Comprar"},
  TipsType_20216_Title = {
    Text = "Confirmar compra"
  },
  TipsType_20217_Desc = {
    Text = "{s1} se abrirá después de {s2}."
  },
  TipsType_20218_Desc = {
    Text = "Los Despertados preseleccionados para esta investigación no pueden ser retirados del equipo, solo pueden ser sustituidos por sus respectivos Despertados."
  },
  TipsType_20219_Desc = {
    Text = "Ya hay un Despertado idéntico en el campo de batalla, no se puede seleccionar de nuevo."
  },
  TipsType_20220_Desc = {
    Text = "Se ha detectado que actualmente no estás conectado a una red WiFi. La descarga consumirá una gran cantidad de datos móviles, ¿deseas confirmar la descarga?\nTamaño del recurso: {s1}\n¿Continuar?"
  },
  TipsType_20220_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20220_RightBtnDesc = {Text = "Descargar"},
  TipsType_20221_Desc = {
    Text = "Recurso descargado"
  },
  TipsType_20221_LeftBtnDesc = {Text = "Confirmar"},
  TipsType_20222_Desc = {
    Text = "Espacio de almacenamiento insuficiente. Se requiere reservar al menos {s1} de espacio disponible, de lo contrario podría ocurrir pérdida de recursos durante la ejecución. ¿Continuar con la descarga?"
  },
  TipsType_20222_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20222_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20223_Desc = {
    Text = "Recurso de descarga fallida, ¿volver a intentarlo?"
  },
  TipsType_20223_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20223_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20224_Desc = {
    Text = "Se descargarán los datos necesarios para jugar la continuación del prólogo.\nTamaño del recurso: {s1}\n¿Deseas continuar?\n\n*Se recomienda descargar en una red WiFi."
  },
  TipsType_20224_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20224_RightBtnDesc = {Text = "Descargar"},
  TipsType_20225_Desc = {
    Text = "{s1} completado, ¿deseas realizar un desafío adicional?\nSe obtiene {s2} valor de entrenamiento en desafíos adicionales"
  },
  TipsType_20225_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20225_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20225_Title = {
    Text = "Desafío extra"
  },
  TipsType_20226_Desc = {
    Text = "Después de reiniciar, los cuerpos despertados, órdenes clave y ruedas de destino del equipo de desafío extra podrán participar nuevamente, pero se deducirán los valores de entrenamiento obtenidos por completar el extra del nivel (no afecta al estado de recompensa), ¿confirmar reinicio?"
  },
  TipsType_20226_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20226_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20226_Title = {
    Text = "Confirmar reinicio"
  },
  TipsType_20227_Desc = {
    Text = "Después de reiniciar, los cuerpos despertados, órdenes clave y ruedas de destino del equipo de investigación actual podrán volver a usarse, y el equipo de desafío adicional reemplazará al equipo de investigación actual, pero se deducirán los puntos de entrenamiento obtenidos por completar el extra del nivel (sin afectar al estado de recompensa), ¿confirmar reinicio?"
  },
  TipsType_20227_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20227_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20227_Title = {
    Text = "Confirmar reinicio"
  },
  TipsType_20228_Desc = {
    Text = "Desplaza la lista hacia abajo para ver más anuncios"
  },
  TipsType_20229_Desc = {
    Text = "<Blue:{s1}> ha alcanzado el límite de nivel de ascensión.\n¿Te gustaría continuar comprando?\nCantidad restante: {s2}"
  },
  TipsType_20229_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20229_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20229_Title = {
    Text = "Confirmar compra"
  },
  TipsType_20230_Desc = {
    Text = "Para asegurar la mejor experiencia de la trama, se recomienda completar las siguientes etapas de investigación."
  },
  TipsType_20230_LeftBtnDesc = {Text = "Salir"},
  TipsType_20230_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20230_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20231_Desc = {
    Text = "Para asegurar la mejor experiencia de la trama, se recomienda completar las siguientes etapas de investigación."
  },
  TipsType_20231_LeftBtnDesc = {Text = "Salir"},
  TipsType_20231_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20231_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20232_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_20232_LeftBtnDesc = {Text = "Salir"},
  TipsType_20232_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20232_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20233_Desc = {
    Text = "Materiales insuficientes actualmente, ¿deseas consumir los siguientes materiales para completarlos?"
  },
  TipsType_20233_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20233_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20233_Title = {
    Text = "Confirmar relleno"
  },
  TipsType_20234_Desc = {
    Text = "Este nivel solo permite equipar llaves específicas y no se pueden sustituir."
  },
  TipsType_20235_Desc = {
    Text = "Para asegurar la mejor experiencia de la trama, se recomienda completar las siguientes etapas de investigación."
  },
  TipsType_20235_LeftBtnDesc = {Text = "Salir"},
  TipsType_20235_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20235_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20236_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar las siguientes etapas de investigación."
  },
  TipsType_20236_LeftBtnDesc = {Text = "Salir"},
  TipsType_20236_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20236_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20237_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar las siguientes etapas de investigación."
  },
  TipsType_20237_LeftBtnDesc = {Text = "Salir"},
  TipsType_20237_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20237_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20238_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar las siguientes etapas de investigación."
  },
  TipsType_20238_LeftBtnDesc = {Text = "Salir"},
  TipsType_20238_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20238_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20239_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar las siguientes etapas de investigación."
  },
  TipsType_20239_LeftBtnDesc = {Text = "Salir"},
  TipsType_20239_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20239_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20240_Desc = {
    Text = "Reparación completada, por favor reinicie el juego"
  },
  TipsType_20240_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20240_Title = {Text = "Aviso"},
  TipsType_20241_Desc = {
    Text = "Se necesitan {s1} más \"<Blue:{s2}>\" para alcanzar el límite de nivel de apilamiento.\n¿Continuar comprando?"
  },
  TipsType_20241_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20241_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20241_Title = {
    Text = "Confirmar compra"
  },
  TipsType_20250_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_20250_LeftBtnDesc = {Text = "Salir"},
  TipsType_20250_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20250_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20251_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_20251_LeftBtnDesc = {Text = "Salir"},
  TipsType_20251_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20251_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20252_Desc = {
    Text = "Para asegurar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_20252_LeftBtnDesc = {Text = "Salir"},
  TipsType_20252_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_20252_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20259_Desc = {
    Text = "Configuración de intercambio guardada para cuando los \"Sellos de mil caras\" sean insuficientes"
  },
  TipsType_20300_Desc = {
    Text = "Ya hay {s1} despertado con esta posición, no se puede usar en el mismo equipo"
  },
  TipsType_20301_Desc = {
    Text = "¡Ahora puedes proceder a \"Tareas Regulares!\""
  },
  TipsType_20351_Desc = {
    Text = "{s1} insuficiente, ¿deseas usar {s2}{s3} para canjear {s4}{s5}?"
  },
  TipsType_20351_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20351_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20351_Title = {
    Text = "{s1} insuficiente"
  },
  TipsType_20352_Desc = {
    Text = "Está a punto de vincularse con el otro jugador. Una vez vinculado, no podrá desvincularse. ¿Está seguro de que desea continuar con la vinculación?"
  },
  TipsType_20352_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20352_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20352_Title = {
    Text = "Invitación: Confirmar"
  },
  TipsType_20353_Desc = {
    Text = "El código de invitación se ha copiado al portapapeles."
  },
  TipsType_20354_Desc = {
    Text = "Ya eres el invitador de la otra parte."
  },
  TipsType_20355_Desc = {
    Text = "No puedes ingresar tu propio código de invitación. Inténtalo obteniendo el código de invitación de otro Guardián del Secreto."
  },
  TipsType_20356_Desc = {
    Text = "Volver a jugar te permitirá experimentar nuevamente la trama del prólogo y el tutorial. \nSin embargo, al volver a jugar, todas las recompensas del nivel serán solo demostrativas y no podrás obtener recompensas reales. \n¿Confirmar?"
  },
  TipsType_20356_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20356_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20356_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_20357_Desc = {
    Text = "¿Estás seguro de que no prestarás más atención a este {s1} guardián?"
  },
  TipsType_20357_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20357_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20357_Title = {
    Text = "Dejar de seguir"
  },
  TipsType_20358_Desc = {
    Text = "Hay seguimientos no confirmados, salir no guardará ninguna operación, ¿confirmar salida?"
  },
  TipsType_20358_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20358_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20358_Title = {
    Text = "Confirmar salida"
  },
  TipsType_20400_Desc = {
    Text = "<WeaponEffect_Num:\"{s1}\"> insuficiente, ¿deseas ir a canjear?"
  },
  TipsType_20400_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20400_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20400_Title = {
    Text = "Faltan objetos de lotería"
  },
  TipsType_300001_Desc = {
    Text = "\"Brillo plateado» solo tienes una oportunidad de despertar gratis, ¿deseas usarla?"
  },
  TipsType_300001_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_300001_RightBtnDesc = {Text = "Confirmar"},
  TipsType_300001_Title = {
    Text = "Confirmación de Despertar"
  },
  TipsType_300002_Desc = {
    Text = "¿Confirmar la selección del resultado de este despertar? Al confirmar, este despertar consumirá un intento gratuito de 5 tiradas consecutivas"
  },
  TipsType_300002_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_300002_RightBtnDesc = {Text = "Confirmar"},
  TipsType_300002_Title = {
    Text = "Confirmación de Despertar"
  },
  TipsType_30001_Desc = {
    Text = "Aviso lateral sin icono"
  },
  TipsType_30002_Desc = {
    Text = "[原文内容]"
  },
  TipsType_30003_Desc = {
    Text = "{s1} desbloqueado"
  },
  TipsType_30004_Desc = {
    Text = "Modo avanzado de {s1} desbloqueado"
  },
  TipsType_30005_Desc = {
    Text = "Desbloqueado (difícil) {s1}"
  },
  TipsType_31000_Desc = {
    Text = "¿Confirmar esta fecha de nacimiento para la verificación? Una vez confirmada, la fecha de nacimiento no se podrá modificar."
  },
  TipsType_31000_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_31000_RightBtnDesc = {Text = "Confirmar"},
  TipsType_31000_Title = {
    Text = "Verificación de edad"
  },
  TipsType_31001_Desc = {
    Text = "Este mes ya has recargado <Blue:{s1}> yuanes, el límite máximo es de <Blue:{s2}> yuanes. Por favor, intenta recargar el próximo mes o prueba con una cantidad menor."
  },
  TipsType_31002_Desc = {
    Text = "Primero debes completar la verificación de edad"
  },
  TipsType_31003_Desc = {
    Text = "La llave de plata detecta una crisis mortal, ¿activar el cuerpo de conocimiento de emergencia?\n(Resucitar consumirá 1 uso del cuerpo de conocimiento de emergencia, se obtiene 1 uso automáticamente a las 9 a.m. cada día, usos restantes actuales: {s1})\n<Blue:(la primera resurrección no consume el cuerpo de conocimiento de emergencia)>"
  },
  TipsType_31003_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_31003_RightBtnDesc = {Text = "Confirmar"},
  TipsType_31003_Title = {
    Text = "Confirmación de resurrección"
  },
  TipsType_31004_Desc = {
    Text = "La llave de plata detecta una crisis mortal, ¿activar el cuerpo de conocimiento de emergencia?\n(Resucitar consumirá 1 uso del cuerpo de conocimiento de emergencia, se obtiene 1 uso automáticamente a las 9 a.m. cada día, usos restantes actuales: {s1})\n<Blue:(La primera resurrección no consume el cuerpo de conocimiento de emergencia)>"
  },
  TipsType_31004_RightBtnDesc = {Text = "Confirmar"},
  TipsType_31004_Title = {
    Text = "Confirmación de resurrección"
  },
  TipsType_40001_Desc = {
    Text = "Cuando la vida llegue a 0, la investigación se terminará forzosamente"
  },
  TipsType_40001_Title = {Text = "PV"},
  TipsType_40002_Desc = {
    Text = "El movimiento en el mapa y los eventos de investigación generarán estrés mental, y la acumulación de estrés causará síntomas en el guardián. \n Por cada casilla que se mueva, el estrés aumentará en 10 puntos. Por cada 100 puntos de estrés acumulados, se obtendrá 1 síntoma. \n Cuando el estrés alcance 500, por cada casilla que se mueva, se perderá el 10% de PV."
  },
  TipsType_40002_Title = {Text = "Estrés"},
  TipsType_40003_Desc = {
    Text = "Cuanto mayor sea el nivel de despacho, mayor será la dificultad de la tarea y las recompensas obtenidas por el despacho también se incrementarán"
  },
  TipsType_40003_Title = {
    Text = "Nivel de despacho"
  },
  TipsType_40004_Desc = {
    Text = "La copia temporal de la primera tarjeta de comando jugada en cada turno irá al espacio hiperspacial. \n Cuando el espacio hiperspacial alcance su límite, obtén 1 turno ultra adicional y retén el blindaje. \n Efecto de maestría del reino: al comienzo del turno, hay una probabilidad de agregar 1 carta de \"conocimiento\" a la mano."
  },
  TipsType_40004_Title = {
    Text = "Espacio Hiperspacial"
  },
  TipsType_40005_Desc = {
    Text = "El guardián puede elevar su nivel a través de investigaciones, interludios y otros desafíos. Más tipos de juegos se desbloquearán a medida que el guardián aumente de nivel"
  },
  TipsType_40005_Title = {Text = "Nivel"},
  TipsType_40006_Desc = {
    Text = "Jugar una tarjeta de comando requiere consumir aritmética. No se conservará la aritmética restante al final del turno, y al inicio del turno, se restaurará hasta el límite."
  },
  TipsType_40006_Title = {
    Text = "Aritmética"
  },
  TipsType_40007_Desc = {
    Text = "La llave de plata percibe una energía especial, puede que haya suministros valiosos ocultos en el mapa"
  },
  TipsType_40007_Title = {
    Text = "Ocultar suministros"
  },
  TipsType_40008_Desc = {
    Text = "Se puede activar en caso de una crisis mortal durante la batalla, cada activación consume 1 carta, recuperando la vida del guardián y la locura del despertador hasta el máximo, ganando 1 carta automáticamente a las 9 de la mañana"
  },
  TipsType_40008_Title = {
    Text = "Cuerpo de Gnosis de Emergencia"
  },
  TipsType_40009_Desc = {
    Text = "Jugar una carta de comando requiere consumir aritmética. No se conservará la aritmética restante al final del turno, y al inicio del turno, el límite de aritmética aumenta en 1 y se restaura hasta el límite. Actualmente es el turno {s1}"
  },
  TipsType_40009_Title = {
    Text = "Aritmética"
  },
  TipsType_AbyssChallengeResetTips_Desc = {
    Text = "La Zona Prohibida de Fusión de desastres ha sido reiniciada. El desafío en curso finalizará de inmediato."
  },
  TipsType_AbyssChallengeResetTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_AbyssChallengeResetTips_Title = {Text = "Sugerencia"},
  TipsType_AbyssChallengeRevivalTips_Desc = {
    Text = "La Llave de Plata detecta una crisis fatal. ¿Activar el Cuerpo de Gnosis de Emergencia?\n(El Renacimiento consumirá 1 Cuerpo de Gnosis de Emergencia. Recibes 1 diariamente a las 9 AM.)"
  },
  TipsType_AbyssChallengeRevivalTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_AbyssChallengeRevivalTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_AbyssChallengeRevivalTips_Title = {
    Text = "Confirmación de resurrección"
  },
  TipsType_AcceptConfirm_Desc = {
    Text = "¿Aceptar la invitación de <Blue:{s1}> para <Blue:{s2}>?"
  },
  TipsType_AcceptConfirm_LeftBtnDesc = {Text = "Rechazar"},
  TipsType_AcceptConfirm_RightBtnDesc = {Text = "Aceptar"},
  TipsType_AcceptConfirm_Title = {
    Text = "Batalla de contraseñas"
  },
  TipsType_ActivitySignRewardTaskNotCompleteTips_Desc = {
    Text = "Completa la tarea correspondiente para poder realizar el despertar"
  },
  TipsType_AlreadyIsBackgroundMusicTips_Desc = {
    Text = "Ya es la música de fondo actual"
  },
  TipsType_AwakerAutoInsertCoinNotEnoughTips_Desc = {
    Text = "Las \"Rosa Dorada\" no son suficientes para usar completamente los \"Elixir de Gnosis\" que posees actualmente. Puedes intentarlo de nuevo después de reponer las \"Rosa Dorada\"."
  },
  TipsType_AwakerNotOpenTips_Desc = {
    Text = "El Despertado aún no está disponible. ¡Estén atentos!"
  },
  TipsType_AwakerRandomChestConfirm_Desc = {
    Text = "¿Confirmar el uso de <Blue:{s1}> para obtener 1 Cuerpo Despertado <Blue:aleatorio>?"
  },
  TipsType_AwakerRandomChestConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_AwakerRandomChestConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_AwakerRandomChestConfirm_Title = {
    Text = "Confirmación de uso"
  },
  TipsType_BattleCreateFail_Desc = {
    Text = "Error al crear la batalla"
  },
  TipsType_BattlePassAllCompleteTips_Desc = {
    Text = "Las Crónicas del Guardián del Secreto actuales ya se han completado en su totalidad."
  },
  TipsType_BestExperienceTips_Chapter3_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_BestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Salir"},
  TipsType_BestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_BestExperienceTips_Chapter3_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_BestExperienceTips_Chapter7_Desc = {
    Text = "Para asegurar la mejor experiencia de la trama, se recomienda completar las siguientes etapas de investigación."
  },
  TipsType_BestExperienceTips_Chapter7_LeftBtnDesc = {Text = "Salir"},
  TipsType_BestExperienceTips_Chapter7_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_BestExperienceTips_Chapter7_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_BestExperienceTips_Chapter8_Desc = {
    Text = "Para asegurar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_BestExperienceTips_Chapter8_LeftBtnDesc = {Text = "Salir"},
  TipsType_BestExperienceTips_Chapter8_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_BestExperienceTips_Chapter8_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_BestExperienceTips_ChapterS2_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_BestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Salir"},
  TipsType_BestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_BestExperienceTips_ChapterS2_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_BestExperienceTips_ChapterS3_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_BestExperienceTips_ChapterS3_LeftBtnDesc = {Text = "Salir"},
  TipsType_BestExperienceTips_ChapterS3_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_BestExperienceTips_ChapterS3_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_BestExperienceTips_ChapterS4_Desc = {
    Text = "Para asegurar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_BestExperienceTips_ChapterS4_LeftBtnDesc = {Text = "Salir"},
  TipsType_BestExperienceTips_ChapterS4_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_BestExperienceTips_ChapterS4_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_BestExperienceTips_ChapterS5_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_BestExperienceTips_ChapterS5_LeftBtnDesc = {Text = "Salir"},
  TipsType_BestExperienceTips_ChapterS5_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_BestExperienceTips_ChapterS5_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_BestExperienceTips_MainStoryS1_6_LeftBtnDesc = {Text = "Salir"},
  TipsType_BestExperienceTips_MainStoryS1_6_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Desc = {
    Text = "Para garantizar la mejor experiencia de trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_LeftBtnDesc = {Text = "Salir"},
  TipsType_BestExperienceTips_TwoAnniversarySubStage_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_CancelCollectAwakerTips_Desc = {
    Text = "Colección cancelada"
  },
  TipsType_CoinBulkBuyConfirm_Desc = {
    Text = "¿Deseas consumir \"Cupón Rosa\" × {s1} para realizar la compra?"
  },
  TipsType_CoinBulkBuyConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_CoinBulkBuyConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_CoinBulkBuyConfirm_Title = {
    Text = "Confirmar compra"
  },
  TipsType_CollectAwakerTips_Desc = {
    Text = "Colección exitosa"
  },
  TipsType_CommonUseBattleHelpLimitTips_Desc = {
    Text = "Se ha alcanzado el límite de los Asistentes comunes del Guardián del Secreto, por favor ajusta la lista de Asistentes comunes"
  },
  TipsType_DiskIsFullOrViolation_Desc = {
    Text = "Error al cargar los archivos. Por favor, comprueba tu espacio de almacenamiento."
  },
  TipsType_DiskIsFullOrViolation_RightBtnDesc = {Text = "Confirmar"},
  TipsType_DiskSpaceNotEnough_Desc = {
    Text = "Espacio de almacenamiento insuficiente. ¿Desea continuar intentando la descarga?"
  },
  TipsType_DiskSpaceNotEnough_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_DiskSpaceNotEnough_RightBtnDesc = {Text = "Confirmar"},
  TipsType_DoubleExBPBuyConfirm_Desc = {
    Text = "¿Gastar <Blue:{s1}> Líquido de Origen de Núcleo de Plata para comprar?\n <color=#ACBFCA>Este período presenta temas especiales, con un precio reducido para temas Avanzados.</color>"
  },
  TipsType_DoubleExBPBuyConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_DoubleExBPBuyConfirm_RightBtnDesc = {Text = "Comprar"},
  TipsType_DoubleExBPBuyConfirm_Title = {
    Text = "Confirmar compra"
  },
  TipsType_EnterSix_DigitPasswordTips_Desc = {
    Text = "Por favor, ingresa <color=#5EF2FF>valor de fase</color>"
  },
  TipsType_FilterMaxAwakerCountTips_Desc = {
    Text = "Selecciona hasta {s1} Cuerpos Despertados para filtrar"
  },
  TipsType_FollowBackConfirm_Desc = {
    Text = "¿Estás seguro de seguir a los <color=#5EF2FF>{s1}</color> seguidores en la página actual?\n\n<color=#96947F>Seguimiento actual </color>{s2}<color=#A0A0A0>/{s3}\nNo podrás seguir una vez que se alcance el límite</color>"
  },
  TipsType_FollowBackConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_FollowBackConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_FollowBackConfirm_Title = {
    Text = "Confirmar seguimiento"
  },
  TipsType_FrenziedOmenUpgradeConfirm_Desc = {
    Text = "Esta operación consumirá una gran cantidad de recursos, adecuada para quienes desean llevar las capacidades del Cuerpo Despertado al límite. ¿Confirmas el Refuerzo de \"Presagio de Locura\"?"
  },
  TipsType_FrenziedOmenUpgradeConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_FrenziedOmenUpgradeConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_FrenziedOmenUpgradeConfirm_Title = {
    Text = "Confirmación de fortalecimiento"
  },
  TipsType_GnosticPotentialUpgradeConfirm_Desc = {
    Text = "Esta operación consumirá una gran cantidad de recursos, adecuada para quienes desean llevar las capacidades del Cuerpo Despertado al límite. ¿Confirmas el Refuerzo de \"Potencial Gnóstico\"?"
  },
  TipsType_GnosticPotentialUpgradeConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_GnosticPotentialUpgradeConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_GnosticPotentialUpgradeConfirm_Title = {
    Text = "Confirmación de fortalecimiento"
  },
  TipsType_InCharging_Desc = {
    Text = [[
Pedido en proceso, por favor no pague de nuevo. 
 Si el pago se ha completado, por favor tenga paciencia y espere a que el sistema otorgue las recompensas. 
 Si el pago no se ha completado, intente reiniciar el juego y vuelva a intentarlo. 
 Si tiene alguna pregunta, por favor contacte al servicio al cliente.]]
  },
  TipsType_InCharging_RightBtnDesc = {Text = "Confirmar"},
  TipsType_InCharging_Title = {Text = "Aviso"},
  TipsType_KeyShortNameDownLoadTips_Desc = {
    Text = "Se están descargando los recursos de identificación de texto, por favor inténtelo de nuevo más tarde"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_Desc = {
    Text = "El Despertar Espiritual de este Despertado está completo.\nAl seleccionarlo solo obtendrás \"Fragmento de Rebobinado de Alma\" ×2"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_RightBtnDesc = {Text = "Continuar"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_Title = {
    Text = "Confirmar selección"
  },
  TipsType_MainResetBG_Desc = {
    Text = "¿Deseas restablecer el fondo del dormitorio <Blue:\"pantalla\"> y <Blue:\"música\"> a los valores predeterminados?"
  },
  TipsType_MainResetBG_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_MainResetBG_RightBtnDesc = {Text = "Confirmar"},
  TipsType_MainResetBG_Title = {
    Text = "Restablecer predeterminado"
  },
  TipsType_MultiSelectBox_FixItemTips_Desc = {
    Text = "Objeto fijo obtenido, no se puede cambiar"
  },
  TipsType_MultiSelectBox_SelectTips_Desc = {
    Text = "Por favor, completa la selección de todos los artículos autoseleccionados antes de proceder a la compra"
  },
  TipsType_OppositeSideCancelMatchTips_Desc = {
    Text = "El oponente ha cancelado el partido"
  },
  TipsType_OppositeSideRejectTips_Desc = {
    Text = "El oponente ha rechazado la invitación de <Blue:{s1}>, por favor elige un modo nuevamente"
  },
  TipsType_PVEExceedMaxRoundsTips_Desc = {
    Text = "El número de rondas de combate ha alcanzado el límite máximo\n\nÚnico Gardian del secreto\n¿Cuál será tu elección a partir de ahora?"
  },
  TipsType_PVEExceedMaxRoundsTips_LeftBtnDesc = {
    Text = "Repetir combate"
  },
  TipsType_PVEExceedMaxRoundsTips_RightBtnDesc = {
    Text = "Retirada temporal"
  },
  TipsType_PVEExceedMaxRoundsTips_Title = {
    Text = "Investigación fallida"
  },
  TipsType_PVEReplayErrorTips_Desc = {
    Text = "Error al obtener la repetición de la batalla, por favor inténtelo de nuevo más tarde"
  },
  TipsType_PVEReplayMaxRounds_Desc = {
    Text = "Se ha alcanzado el límite máximo de 25 turnos en la repetición, \n Fin de la repetición."
  },
  TipsType_PVEReplayMaxRounds_RightBtnDesc = {Text = "Confirmar"},
  TipsType_PVEReplayMaxRounds_Title = {
    Text = "Confirmar finalización"
  },
  TipsType_PVEReplayNoDataTips_Desc = {
    Text = "No hay registros de operación de investigación"
  },
  TipsType_PVEReplayRepeatClickTips_Desc = {
    Text = "Cargando la repetición de la batalla, por favor no repita operaciones"
  },
  TipsType_PVEReplaySpecialTeamAssignTips_Desc = {
    Text = "No se admite la repetición de batalla de formaciones especiales, espera"
  },
  TipsType_PVEReplayTimeoutTips_Desc = {
    Text = "Tiempo de espera para obtener la repetición de la batalla"
  },
  TipsType_PVEReplayUnableOperateTips_Desc = {
    Text = "No se pueden realizar operaciones durante la repetición de la batalla"
  },
  TipsType_PVETeamShareCodeCopyTips_Desc = {
    Text = "Copiado al portapapeles"
  },
  TipsType_PVETeamShareCodeError_Desc = {
    Text = "No se pudo identificar correctamente la alineación de <color=#5EF2FF>Operación de investigación</color> en el portapapeles"
  },
  TipsType_PVETeamShareCodeSaveTips_Desc = {
    Text = "¿Confirmar la salvación de la configuración del equipo correspondiente a este código de alineación?\nLas partes que no se tengan de esta configuración quedarán vacías."
  },
  TipsType_PVETeamShareCodeSaveTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_PVETeamShareCodeSaveTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_PVETeamShareCodeSaveTips_Title = {
    Text = "Confirmación de guardado"
  },
  TipsType_PVETeamShareCodeSpecialTeamAssignTips_Desc = {
    Text = "Este equipo contiene un Despertador preestablecido, no se puede copiar o importar el código de formación"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_Desc = {
    Text = "La partida ha alcanzado el límite de rondas. El jugador en primera posición no pudo poner Fin a la partida y se declara derrotado."
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_RightBtnDesc = {Text = "Confirmar"},
  TipsType_PVPExceedMaxRoundsTips_Loser_Title = {
    Text = "Combate finalizado"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_Desc = {
    Text = "La partida ha alcanzado el límite de rondas. El jugador en segunda posición logró resistir hasta el Fin de la partida y se declara victorioso."
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_RightBtnDesc = {Text = "Confirmar"},
  TipsType_PVPExceedMaxRoundsTips_Winner_Title = {
    Text = "Combate finalizado"
  },
  TipsType_PVPSurrenderConfirm_Desc = {
    Text = "¿Te rindes?"
  },
  TipsType_PVPSurrenderConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_PVPSurrenderConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_PVPSurrenderConfirm_Title = {
    Text = "Confirmar rendición"
  },
  TipsType_PVPTeamShareCodeError_Desc = {
    Text = "No se pudo identificar correctamente que hay <color=#5EF2FF>Fase de Duelo</color> en el portapapeles"
  },
  TipsType_PVP_PasswordBattle_BlockTips_Desc = {
    Text = "¿Es necesario bloquear a este Guardián del Secreto?"
  },
  TipsType_PVP_PasswordBattle_BlockTips_LeftBtnDesc = {Text = "Rechazar"},
  TipsType_PVP_PasswordBattle_BlockTips_RightBtnDesc = {Text = "Aceptar"},
  TipsType_PVP_PasswordBattle_BlockTips_Title = {Text = "¿Bloquear"},
  TipsType_PVP_PasswordBattle_GameStartedTips_Desc = {
    Text = "Esta batalla de contraseñas ha comenzado"
  },
  TipsType_PVP_PasswordBattle_OthersEnterTips_Desc = {
    Text = "Un nuevo guardián ha entrado en esta ronda de la batalla criptográfica"
  },
  TipsType_PVP_PasswordBattle_QueueTips_Desc = {
    Text = "Actualmente en espera..."
  },
  TipsType_PVP_PasswordBattle_QuitTips_Desc = {
    Text = "¿Quieres salir de la batalla de contraseñas?"
  },
  TipsType_PVP_PasswordBattle_QuitTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_PVP_PasswordBattle_QuitTips_RightBtnDesc = {Text = "Salir"},
  TipsType_PVP_PasswordBattle_QuitTips_Title = {
    Text = "Confirmar salida"
  },
  TipsType_PVP_PasswordBattle_RejectedTips_Desc = {
    Text = "El oponente se negó a pelear contigo"
  },
  TipsType_PassportHoistTips1_Desc = {
    Text = "\"Ion Activo Básico\"\n·Después de desbloquear, el \"Punto de partida real\", \"Núcleo Puro\", \"Experiencia\" y \"Núcleo de plata\" obtenidos en las recompensas acumuladas de \"Ion Activo Básico\" del \"Entrenamiento diario\" durante el período de este tema aumentarán a 3 veces. Tras comprar el \"Tema principal\", se compensará la parte adicional de las recompensas acumuladas de \"Ion Activo Básico\" ya reclamadas en este período."
  },
  TipsType_PassportHoistTips2_Desc = {
    Text = "\"Inversión temporal\"\n·Puede regresar a turnos experimentados en la batalla.\n·Puede regresar a cualquier turno de los últimos 25 turnos de la batalla.\n·Después de reiniciar el desafío, la función de inversión aún se puede usar para regresar a turnos anteriores."
  },
  TipsType_PassportHoistTips3_Desc = {
    Text = "\"Fase de Duelo\"\n·Después de desbloquear, podrás usar todas las cartas de \"Fase de Duelo\" durante la duración de este tema."
  },
  TipsType_Password_CopiedTips_Desc = {
    Text = "<color=#5EF2FF>El valor de fase</color> ha sido copiado al portapapeles"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_Desc = {
    Text = "¿Deseas gastar <Blue:\"Líquido de origen\" × {s1} >para comprar?\n\n<size=30><color=#ACBFCA>Al consumir \"Líquido de origen\", se deducirá primero el \"Líquido de origen\" obsequiado.\n(Extraído: {s2}, Obsequiado: {s3})</color></size>"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_PayMoneyBuyConfirmDescDetail_RightBtnDesc = {Text = "Comprar"},
  TipsType_PayMoneyBuyConfirmDescDetail_Title = {
    Text = "Confirmar compra"
  },
  TipsType_PublishEmptyCommentTips_Desc = {
    Text = "El contenido del comentario no puede estar vacío"
  },
  TipsType_PvpCollectionCommentDeleteTips_Desc = {
    Text = "¿Eliminar este comentario?"
  },
  TipsType_PvpCollectionCommentDeleteTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_PvpCollectionCommentDeleteTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_PvpCollectionCommentDeleteTips_Title = {
    Text = "Confirmar eliminación"
  },
  TipsType_PvpHideCommentConfirm_Desc = {
    Text = "¿Ocultar todos sus comentarios?"
  },
  TipsType_PvpHideCommentConfirm_LeftBtnDesc = {Text = "No"},
  TipsType_PvpHideCommentConfirm_RightBtnDesc = {Text = "Sí"},
  TipsType_PvpHideCommentConfirm_Title = {Text = "Ocultar"},
  TipsType_PvpMatchingInterruptTips_Desc = {
    Text = "Se detectó una anomalía en la red, la búsqueda de partida fue interrumpida."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Desc = {
    Text = "Aún en combate, ¿deseas continuar la batalla anterior? \n La temporada \"Tren de la Alegría Veloz\" ha sido actualizada. Continuar el desafío permite completar las misiones de la temporada más reciente, pero no podrás acceder a la \"Lista de Huéspedes VIP\"."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Title = {Text = "Sugerencia"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Desc = {
    Text = "El progreso del último desafío es {s1} - Fase {s2} - Combate {s3}, con \"Puntos VIP\" × {s4} obtenidos.\nLa temporada ha sido actualizada. Continuar el desafío permite completar las misiones de la temporada más reciente, pero no podrás acceder a la \"Lista de Huéspedes VIP\". ¿Deseas continuar el desafío?"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Title = {
    Text = "Continuar desafío"
  },
  TipsType_RailWayContinueSaveStage_Desc = {
    Text = "Progreso del último desafío: {s1} - Fase {s2} - Batalla {s3}.\nPuntos VIP obtenidos: {s4}.\n¿Deseas continuar con el desafío?"
  },
  TipsType_RailWayContinueSaveStage_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_RailWayContinueSaveStage_RightBtnDesc = {Text = "Confirmar"},
  TipsType_RailWayContinueSaveStage_Title = {
    Text = "Continuar desafío"
  },
  TipsType_RailWayHaveSaveStage_Desc = {
    Text = "Se necesita finalizar el desafío guardado anteriormente para poder realizar uno nuevo"
  },
  TipsType_RailWaySaveAndExitInBattleTips_Desc = {
    Text = "¿Confirmar salida del desafío?\nEl progreso de este desafío se guardará y continuarás desde el progreso actual en el próximo desafío, reabriendo esta batalla."
  },
  TipsType_RailWaySaveAndExitInBattleTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_RailWaySaveAndExitInBattleTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_RailWaySaveAndExitInBattleTips_Title = {
    Text = "Guardar y salir"
  },
  TipsType_RailWaySaveAndExitTips_Desc = {
    Text = "¿Confirmar salida del desafío?\nEl progreso de este desafío se guardará y se continuará con el progreso actual en el próximo desafío."
  },
  TipsType_RailWaySaveAndExitTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_RailWaySaveAndExitTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_RailWaySaveAndExitTips_Title = {
    Text = "Guardar y salir"
  },
  TipsType_RailWaySeasonSwitchTips_Desc = {
    Text = "La temporada ha sido actualizada. Continuar el desafío permite completar las misiones de la temporada más reciente, pero no podrás acceder a la \"Lista de Huéspedes VIP\"."
  },
  TipsType_ReplayNullTips_Desc = {
    Text = "La información de reproducción no puede estar vacía"
  },
  TipsType_SchoolConflictTips_Desc = {
    Text = "Hay conflictos de dominio con los Despertados en el equipo, por favor ajústalo."
  },
  TipsType_SelectedAwakensAndCardsExceedLimit_Desc = {
    Text = "Se ha superado la cantidad seleccionada"
  },
  TipsType_ServerRankDataLoading_Desc = {
    Text = "Los datos de esta clasificación aún no se han cargado. Por favor, vuelve a abrir la interfaz más tarde."
  },
  TipsType_ServerRankDataLoading_RightBtnDesc = {Text = "Confirmar"},
  TipsType_ServerRankDataLoading_Title = {
    Text = "Inicializando datos del ranking del servidor"
  },
  TipsType_ShopBulkBuyConfirm_Desc = {
    Text = "Se usarán <Blue:{s1}> {s2} para canjear <Blue:{s3}> {s4}. ¿Confirmar el canje?"
  },
  TipsType_ShopBulkBuyConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_ShopBulkBuyConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_ShopBulkBuyConfirm_Title = {
    Text = "Confirmación de Redención"
  },
  TipsType_SocialRecordHideTips_Desc = {
    Text = "Los registros de batalla están ocultos"
  },
  TipsType_SteamOverlayEnabledTips_Desc = {
    Text = "Por favor, activa la opción \"Habilitar la interfaz de Steam mientras juegas\" en \"Configuración - En el juego\" de Steam y en \"Propiedades - General\" del juego. Una vez hecho, reinicia el juego para volver a intentarlo."
  },
  TipsType_SteamOverlayEnabledTips_LeftBtnDesc = {Text = "Confirmar"},
  TipsType_SteamOverlayEnabledTips_Title = {Text = "Aviso"},
  TipsType_SteamRestartTips_Desc = {
    Text = "Error de autorización de Steam. Por favor, reinicia el cliente de Steam e inténtalo de nuevo."
  },
  TipsType_SteamRestartTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_SteamRestartTips_Title = {
    Text = "Error de inicio de sesión"
  },
  TipsType_SubBestExperienceTips_Chapter3_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_SubBestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Salir"},
  TipsType_SubBestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_SubBestExperienceTips_Chapter3_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_SubBestExperienceTips_Chapter5_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_SubBestExperienceTips_Chapter5_LeftBtnDesc = {Text = "Salir"},
  TipsType_SubBestExperienceTips_Chapter5_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_SubBestExperienceTips_Chapter5_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Desc = {
    Text = "Para garantizar la mejor experiencia de la trama, se recomienda completar los siguientes niveles de investigación."
  },
  TipsType_SubBestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Salir"},
  TipsType_SubBestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Aún investigar"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Title = {
    Text = "Confirmación de investigación"
  },
  TipsType_SummonFailureTips_Desc = {
    Text = "El coste de materiales de Despertar ha cambiado, intenta Redespertar"
  },
  TipsType_SummonPriorityNotEnoughTips_Desc = {
    Text = "Te faltan {s1} <Blue:\"{s2}\">. ¿Consumir <Blue:{s4} × {s3} > en su lugar?"
  },
  TipsType_SummonPriorityNotEnoughTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_SummonPriorityNotEnoughTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_SummonPriorityNotEnoughTips_Title = {
    Text = "Confirmación de Redención"
  },
  TipsType_SummonType_14SelectConfirm_BottomDesc = {
    Text = "<Blue:Atención: ¡Una vez seleccionado, no se podrá modificar en este evento!>"
  },
  TipsType_SummonType_14SelectConfirm_Desc = {
    Text = "¿Deseas confirmar la selección del Despertado<OrangeQuality:\"{s1}\",\"{s2}\",\"{s3}\",\"{s4}\"> como el UP dirigido de esta actividad?"
  },
  TipsType_SummonType_14SelectConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_SummonType_14SelectConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_SummonType_14SelectConfirm_Title = {
    Text = "Confirmar selección"
  },
  TipsType_SummonType_14SelectLimitTips_BottomDesc = {
    Text = "<Blue:Atención: ¡Una vez seleccionado, no se podrá modificar en este evento!>"
  },
  TipsType_SummonType_14SelectLimitTips_Desc = {
    Text = "Límite de cantidad alcanzado"
  },
  TipsType_SummonType_17IncompleteSelectionTips_Desc = {
    Text = "Por favor, completa todos los tipos de selecciones antes de intentarlo de nuevo"
  },
  TipsType_SummonType_17SelectConfirm_Desc = {
    Text = "¿Confirmar la selección del Despertado designado?\nUna vez confirmado, la selección de este período no podrá cambiarse de nuevo."
  },
  TipsType_SummonType_17SelectConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_SummonType_17SelectConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_SummonType_17SelectConfirm_Title = {
    Text = "Confirmar selección"
  },
  TipsType_SupportListLatestTips_Desc = {
    Text = "¡Ya está en el último Estado! ¡Ve a seguir a más compañeros para obtener más opciones de Asistencia en batalla!"
  },
  TipsType_TrinketAutoRefineExitTips_Desc = {
    Text = "Transcripción Automática en curso, operación no disponible."
  },
  TipsType_TrinketAutoRefineTips_BottomDesc = {
    Text = "(La Transcripción Automática se detiene cuando un atributo desbloqueado alcanza 8.)"
  },
  TipsType_TrinketAutoRefineTips_Desc = {
    Text = [[
Transcribir hasta {s1} veces
Consumir hasta]]
  },
  TipsType_TrinketAutoRefineTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketAutoRefineTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketAutoRefineTips_Title = {
    Text = "Confirmación de Transcripción Automática"
  },
  TipsType_TrinketBagFullTips_Desc = {
    Text = "La mochila de Pactos está llena"
  },
  TipsType_TrinketBatchUnbindTips_Desc = {
    Text = "¿Desvincular todos los Pactos?"
  },
  TipsType_TrinketBatchUnbindTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketBatchUnbindTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketBatchUnbindTips_Title = {
    Text = "Confirmación de desvinculación"
  },
  TipsType_TrinketBindSaveTips_Desc = {
    Text = "Hay Pactos inmovilizados, ¡no se puede guardar como plan!"
  },
  TipsType_TrinketBindTips_Desc = {
    Text = "¿Confirmas la combinación de los siguientes Pactos? Los Pactos equipados por otros Despertados o presentes en formaciones/esquemas/apoyo serán retirados automáticamente."
  },
  TipsType_TrinketBindTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketBindTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketBindTips_Title = {
    Text = "Confirmación de modificación de vinculación"
  },
  TipsType_TrinketChangeBindTips_Desc = {
    Text = "¿Confirmar la modificación del Inmovilizado?"
  },
  TipsType_TrinketChangeBindTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketChangeBindTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketChangeBindTips_Title = {
    Text = "Confirmación de modificación de Inmovilizado"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_Desc = {
    Text = "¿Desvincular todos los conjuntos de Pactos?\n\n<color=#9BA3A2><size=30>Se consumirán +12 piezas de Pacto.</size></color>"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketHighLevelBatchUnbindTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketHighLevelBatchUnbindTips_Title = {
    Text = "Confirmación de desvinculación"
  },
  TipsType_TrinketHighLevelChangeBindTips_Desc = {
    Text = "¿Confirmar el cambio?\n\n<color=#9BA3A2><size=30>Se consumirán +12 piezas de Pacto.</size></color>"
  },
  TipsType_TrinketHighLevelChangeBindTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketHighLevelChangeBindTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketHighLevelChangeBindTips_Title = {
    Text = "Confirmación de modificación de Inmovilizado"
  },
  TipsType_TrinketHighLevelUnbindTips_Desc = {
    Text = "¿Desvincular este conjunto de Pactos?\n\n<color=#9BA3A2><size=30>Se consumirán +12 piezas de Pacto.</size></color>"
  },
  TipsType_TrinketHighLevelUnbindTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketHighLevelUnbindTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketHighLevelUnbindTips_Title = {
    Text = "Confirmación de desvinculación"
  },
  TipsType_TrinketUnbindTips_Desc = {
    Text = "¿Confirmar la desvinculación de este Pacto?"
  },
  TipsType_TrinketUnbindTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketUnbindTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketUnbindTips_Title = {
    Text = "Confirmación de desvinculación"
  },
  TipsType_TryAgainLaterTips_Desc = {
    Text = "El <color=#5EF2FF>valor de fase</color> está actualmente en uso, por favor, inténtalo de nuevo más tarde"
  },
  TipsType_WaitOppositeSideAccept_Desc = {
    Text = "Esperando\n{s1}\naceptar la invitación de <Blue:{s2}>"
  },
  TipsType_WaitOppositeSideAccept_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_WaitOppositeSideAccept_Title = {
    Text = "Batalla de contraseñas"
  },
  TipsType_WaitOthersEnter_Desc = {
    Text = "Esperando a que otros guardianes ingresen\n<Blue:{s1}>\ncontraseña de combate coincidente"
  },
  TipsType_WaitOthersEnter_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_WaitOthersEnter_RightBtnDesc = {
    Text = "Copia <color=#5EF2FF>valor de fase</color>"
  },
  TipsType_WaitOthersEnter_Title = {
    Text = "Batalla de contraseñas"
  },
  TipsType_WeaponRandomChestConfirm_Desc = {
    Text = "¿Confirmar el uso de <Blue:{s1}> para obtener 1 Rueda del destino <Blue:aleatoria>?"
  },
  TipsType_WeaponRandomChestConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_WeaponRandomChestConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_WeaponRandomChestConfirm_Title = {
    Text = "Confirmación de uso"
  },
  TipsType_WeekChallengeSweepTips_Desc = {
    Text = "Recompensas semanales agotadas, no se puede reproducir."
  }
})
return Text_TipsType
