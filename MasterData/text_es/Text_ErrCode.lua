__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_CMD_UNDEFINED_Desc = {
    Text = "La orden no existe"
  },
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "Evento finalizado"
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "Días de inicio de sesión insuficientes para reclamar recompensas"
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "Condiciones para participar en el evento no cumplidas"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "Este evento no existe"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "Evento aún no desarrollado"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "El evento aún no ha comenzado"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "Misión del evento no completada"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "Evento de demostración: No se pueden reclamar recompensas por etapas incompletas."
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "Evento de Prueba: Este nivel no fue encontrado."
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "El Guardián de este evento ya te ha proporcionado apoyo una vez."
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "Este evento requiere atención mutua entre los Guardianes para proporcionar apoyo."
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "Se ha alcanzado el límite de los asistentes comunes del Guardián del Secreto, por favor ajusta la lista de asistentes comunes"
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "No se cumplen las condiciones para la mejora de habilidad"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "Nivel de elevación del despertador insuficiente"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "El Despertador aún no ha alcanzado el tiempo de apertura."
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "El Despertador ya ha sido utilizado"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "No se puede bloquear de nuevo"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "Has sido bloqueado por el usuario, no puedes realizar ninguna acción"
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "Has sido incluido en la lista negra por este usuario y no puedes seguirlo ni darle me gusta."
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "Has bloqueado a este usuario y no puedes darle like o seguirlo."
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "Límite de lista negra alcanzado"
  },
  ErrCode_ERR_BATTLE_CREATE_FAILED_Desc = {
    Text = "Error al crear la batalla"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "Insuficiente moneda para comprar el nivel de Pase"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "Operación Fallida"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "Precio de privilegio de compra de Pase no configurado"
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "El nivel de privilegio de Pasar está al máximo, no se puede comprar nuevamente."
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "Nivel de privilegio insuficiente para reclamar la recompensa"
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "La recompensa no existe"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "Recompensa recibida"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "Plata insuficiente"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "Número de compras con comprobante insuficiente"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "Las reliquias no son compatibles con el fortalecimiento."
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "Esta carta ha alcanzado el nivel máximo y no puede ser fortalecida."
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "Esta carta no se puede fortalecer"
  },
  ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc = {
    Text = "Contiene palabras bloqueadas"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "Repetir comentario"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "Repetir eliminación"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "Repetir me gusta"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "Repetir cancelar me gusta"
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "Longitud excede el límite"
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "Comentarios de me gusta eliminados"
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "Tiempo agotado para comentarios"
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Actualización de carta exclusiva, sin intentos"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "Línea de trama del desafío de mazmorra no encontrada"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "Línea de trama del desafío de mazmorra no encontrada"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "Los datos de la etapa de inmersión fantasmal están siendo actualizados. Por favor, inténtalo de nuevo más tarde."
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "Desafío completado, no se puede reclamar la recompensa de nuevo"
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "Desafío no completado, no se puede reclamar la recompensa"
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "Recompensa de capítulo no alcanzó la puntuación"
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "Recompensa de capítulo recibida"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "Nodo actual no encontrado"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "Nombre de personaje duplicado"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "Error en los datos recibidos del cliente"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "Nodo actual no encontrado. No se puede cerrar."
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "Error en la tabla de configuración"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "Incapaz de reclamar recompensas"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "Condiciones de recompensa aún no cumplidas"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "Sin datos de tareas de nivel disponibles"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "Sin puntos para la misión de esta instancia"
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "Módulo para puntaje de materia no encontrado"
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "No se han encontrado tareas hasta ahora"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "No se encontraron datos de unidad para el tema"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "Módulo enviado, no es necesario reenviar"
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "Las subtareas de la misión están incompletas"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "Misión completada"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "Las tareas bajo la unidad no se han completado completamente y no pueden ser sometidas."
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "El registro de nuevos Guardianes está actualmente en pausa."
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "No se encontró ningún personaje. Por favor, crea uno."
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "El uso de comandos personalizados ha alcanzado el límite."
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "La reliquia ha sido fortalecida."
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "Menofín suficiente, no necesita ser complementado"
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "No se pueden ofrecer sacrificios en este momento."
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "El accesorio no existe"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "Error en el área del evento"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "La Carta de Selección de Evento no existe"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "Demasiadas cartas de Evento"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "El objeto seleccionado del evento no existe"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "Demasiados relicarios seleccionados para el evento"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = "Entrada de tipo de evento incorrecto en la tabla de configuración de la mazmorras"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "Error en los datos del evento"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "Las cartas de caída de batalla no tienen límite en la cantidad de veces."
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "No hay límite en la cantidad de veces que se pueden refrescar los relicarios de batalla"
  },
  ErrCode_ERR_EVENT_FINISH_Desc = {
    Text = "Evento completado"
  },
  ErrCode_ERR_EVENT_NOT_FIND_Desc = {
    Text = "El evento no existe en la mazmorrra"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "Insuficiente Mithril. No se puede comprar."
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "Evento no encontrado en este nodo"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "No hay datos en el pool aleatorio del Evento"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "La función de la intersección está bloqueada"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "La función del campamento ya ha sido seleccionada y no se puede volver a elegir"
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "No hay más usos disponibles para la función del campamento"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "La renovación de la tienda de eventos no tiene límite en el número de veces."
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "No hay más eliminaciones de cartas en la tienda de eventos"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "Insuficiente número de Cartas de Evento seleccionadas"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "Cantidad insuficiente de objetos seleccionados del evento"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "No se encuentra la información de la carta exclusiva"
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "Ruta de mejora sin ID de personaje"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "Carta exclusiva no desbloqueada"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "No se puede cambiar sin cambios en la carta exclusiva"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "Cambio de carta exclusiva fallido"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "No se puede cambiar sin actualizar la carta exclusiva"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "No se encuentra el uuid de la carta exclusiva"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "El Despertado de asistencia en batalla ha dejado de ser válido. Por favor, actualiza la lista de asistencia y selecciona nuevamente un Despertado de asistencia en batalla."
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "Objeto de síntesis no desbloqueado"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "No hay suficiente moneda para sintetizar el objeto"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc = {
    Text = "Faltan otros objetos necesarios para la síntesis"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "Construcción ya existe, no se puede construir de nuevo"
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "Ubicación ocupada por un ser despierto, no se puede instalar"
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "Construcción al nivel máximo"
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "Construcción no existe"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "Condiciones insuficientes para subir de nivel/construir edificio"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "Faltan objetos necesarios para subir de nivel/construir"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "No hay recompensas disponibles en el nodo actual."
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "No hay intentos de desafío"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "Actualmente bajo en resistencia, estás en un estado de debilidad."
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "Desbloquea cuando el nivel de exploración alcanza 2"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "Después de completar con éxito una exploración, puedes explorar nuevamente instantáneamente."
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "Error de Mazmorras"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "No se encontró instancia"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "Nodo Bloqueado"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "Nodo Completado"
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "Nodo no completado"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "Los nodos no son adyacentes"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "Refrescos de tienda insuficientes"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "Nivel del jugador insuficiente"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "La descripción contiene caracteres ilegales. Por favor, vuelve a ingresar."
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "El oponente está en medio de una investigación o de otro modo."
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "Índice incorrecto"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "Ya eres el invitador de la otra parte"
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "Ya tiene un invitador"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "Error en el estado de la mazmorra, por favor inicie sesión de nuevo"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "Inventario completo"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "Límite de compras alcanzado hoy"
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "El objeto ha sido equipado"
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "El objeto está bloqueado"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "Objeto No Bloqueado"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "El objeto ha alcanzado el nivel máximo"
  },
  ErrCode_ERR_ITEM_NOT_ENOUGH_Desc = {
    Text = "Objetos insuficientes"
  },
  ErrCode_ERR_ITEM_NOT_FIND_Desc = {
    Text = "Objeto no encontrado"
  },
  ErrCode_ERR_ITEM_NOT_MATCH_Desc = {
    Text = "Incompatibilidad de objeto"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "No se puede usar el objeto"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "Objeto duplicado"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "La Rueda del Destino o la Pandilla aún no ha alcanzado su hora de apertura"
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "Cantidad de objetos incorrecta"
  },
  ErrCode_ERR_ITEM_UNUSABLE_Desc = {
    Text = "Objeto no utilizable"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "Nodo de activación anterior no encontrado"
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "La energía actualmente recolectada es insuficiente para activar el portal. Se requieren {s1} puntos de energía."
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "Nivel máximo alcanzado"
  },
  ErrCode_ERR_LOCKED_Desc = {
    Text = "No desbloqueado"
  },
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "Área de mazmorra no desbloqueada"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "Barrido de la línea de trama no desbloqueado"
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "La mazmorra seleccionada no está desbloqueada"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "La línea de historia seleccionada no está desbloqueada"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "Error del servidor de inicio de sesión"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "Adjunto reclamado"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "El correo no existe"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "Partida Fallida"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "¡Se ha alcanzado el número máximo de despertares!"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "Incapaz de desafiar la Mazmorras de Oro especificada."
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "Elige al Despertado que luchará"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "Mazmorras de Oro designadas bloqueadas - Por favor, completa la mazmorras de Investigación especificada"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "Aún no ha llegado el momento para cambiar el nombre de nuevo, por favor espera"
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "El nombre contiene caracteres no válidos, por favor inténtalo de nuevo"
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "La longitud del nombre no es válida, debe tener entre 2 y 4 caracteres"
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "La cadena de entrada es demasiado larga"
  },
  ErrCode_ERR_NOTE_LENGTH_SHORT_Desc = {
    Text = "El texto introducido es demasiado corto"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "No hay suficientes puntos"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "No tiene este objeto"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "No se puede mover"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "Función aún no disponible"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "Condiciones de recompensa no cumplidas. No se puede reclamar."
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "Actualizando el perfil, por favor espere para volver a ver."
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "No hay partido amistoso en curso"
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "Sin Pacto ocioso"
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "Error de datos del NPC"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "El NPC ya ha sido activado"
  },
  ErrCode_ERR_NPC_NOT_FIND_Desc = {
    Text = "NPC no existe"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "El oponente está actualmente fuera de línea"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "Nivel del jugador insuficiente"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "Estrellas de la línea de trama insuficientes, no se puede barrer"
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "No se encontró evento de diálogo de la historia"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "Intentos de desafío de la línea de trama insuficientes"
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "Recompensa recibida"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "No hay tal recompensa"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "Falló la inserción de la runa"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "Colección PVP No Obtenida"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "La lista de Traphase no tiene suficientes Pandillas."
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "Materiales del Rueda del Destino insuficientes para el Despliegue del Equipo Traphase"
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "Condiciones de desbloqueo del modo de selección de rueda no alcanzadas"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "Desafío en enfriamiento"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "No hay intentos de desafío"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "No hay oponentes para desafiar"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "Elige al Despertado que luchará"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "Uno de los dos jugadores ha logrado dos victorias. No se permiten rondas adicionales."
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "El oponente ha abandonado el juego"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "La batalla de contraseñas no existe o ha caducado"
  },
  ErrCode_ERR_RANK_OUT_OF_RANGE_Desc = {
    Text = "Por el momento no se puede consultar la información de clasificación fuera del puesto 2000."
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "No hay tal configuración en la tabla de recarga"
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "Recarga gratuita ya realizada, no se puede recargar de nuevo"
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "El número de renovaciones de ítems ha alcanzado el límite máximo."
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "No en un estado de seguimiento mutuo"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "Reliquias llenas"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "Solicitud demasiado frecuente. Por favor, inténtelo de nuevo más tarde."
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "Insuficientes materiales para la mejora de élite"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "Monedas insuficientes para mejorar al Despertador"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "Error en los datos del personaje"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "La tasa de llegada del Despertar está al máximo y no puede aumentarse más."
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "Nivel de Despertador insuficiente"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "El Despertador ha alcanzado el nivel máximo y no puede ser mejorado."
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "Fondos insuficientes"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "El Despertador ha alcanzado el nivel más alto de Edificación."
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "No se puede avanzar sin alcanzar el nivel más alto"
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "No se encontraron datos de cuerpos despiertos"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "El Despertador no tiene habilidades."
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "No hay información de ranuras"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "El potencial del Despertar ha alcanzado el nivel más alto."
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "Objetos insuficientes para mejorar el potencial del Despertador"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "Las habilidades del Despertador aún no han sido desbloqueadas"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "Habilidad al máximo nivel"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "No hay suficientes Objetos de Mejora de Habilidades"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "Insuficiente moneda para mejoras de habilidad"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "Nivel máximo alcanzado"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "No hay más ranuras de actualización manual"
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "Ya avanzado. No se puede avanzar de nuevo."
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "Objetos insuficientes para el consumo de mejora del Despertador"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "Monedas insuficientes para mejorar al Despertador"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "El reino no cumple con las condiciones"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "Los Despertadores desplegados en la Torre del Reino no cumplen con los requisitos del Reino."
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "El nivel que has ingresado no está actualmente disponible."
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "No se pueden desplegar Despertadores idénticos en la Torre del Reino"
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "Falta de núcleo de plata"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "Mantenimiento del campus en curso, espere a que termine"
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "Servicio no iniciado"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "Producto comprado"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "Actualmente incapaz de sentir"
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "El artículo ha caducado y no se puede canjear."
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "El artículo en venta está agotado"
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "No hay datos de la tienda"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "No hay este tipo de tienda"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "No hay este producto a la venta"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "La tienda no lleva este artículo."
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "No hay recargas disponibles"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "Este artículo no está disponible en la tienda."
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "Actualmente no es un nodo de tienda y no puede ser actualizado."
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "El jugador no existe."
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "Todos los avatares de la Visión Primordial han sido derrotados"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "El conteo de desafío diario del tipo de misión ha alcanzado el límite"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "Haciendo clic con demasiada frecuencia. Por favor, intenta de nuevo más tarde."
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "Función de despertar no habilitada"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "Condiciones de activación no cumplidas"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "Resonancia activada, no es necesario reactivarla"
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "El estado de Resonancia inicial no se puede reiniciar."
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "Insuficientes materiales de Resonancia."
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "El Punto de Resonancia ha alcanzado el nivel máximo."
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "No se encontró resonancia en la instancia"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "No se encontraron datos de resonancia"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "No se encontraron datos relacionados con el nivel de Resonancia"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "No hay intentos de reinicio disponibles"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "Efectos de producción de Despertador desbloqueados; no es necesario desbloquear de nuevo."
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "Recompensa recibida"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "La misión delegada está completa y no puede ser retirada."
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "Insuficientes condiciones de asignació"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "Misión completada"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "Tarea no encontrada"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "Misión incompleta, recompensa no disponible"
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "El nombre del equipo solo puede contener caracteres chinos o ingleses."
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "El nombre del equipo no puede tener más de 8 caracteres"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "Se requieren al menos cuatro Despertadores en el equipo para entrar al escenario."
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "Configuración del equipo no encontrada"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "El Despertador del equipo no ha configurado la Rueda del Destino."
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "Error en la configuración del equipo de investigación"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "La Rueda del destino no existe"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "Pruebas insuficientes"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "Error de Token de Inicio de Sesión"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "Nodo de activación actual no encontrado"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "Accesorio no registrado, incapaz de reemplazar atributos"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "Dejar de seguir primero, luego bloquear"
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "Los Despertadores, la Rueda del Destino, o Pandilla han sido utilizados en este juego hoy."
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "No se pudo desbloquear la misión secundaria: Misión secundaria disponible"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "Falló en desbloquear la misión secundaria: Misión secundaria no activada"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "Falló al desbloquear la misión secundaria: No hay elementos requeridos para el desbloqueo"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "No se pudo desbloquear la misión secundaria: Misión secundaria ya desbloqueada."
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "Incompatibilidad de versión. Por favor, actualiza al cliente más reciente; si ya está actualizado, espera a que termine el mantenimiento del campus."
  },
  ErrCode_FAILED_Desc = {Text = "Fracaso"},
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "Los personajes existentes no necesitan ser creados de nuevo."
  },
  ErrCode_SUCCESS_Desc = {
    Text = "Operación exitosa"
  }
})
return Text_ErrCode
