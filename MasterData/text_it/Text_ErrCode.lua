__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_CMD_UNDEFINED_Desc = {
    Text = "Il comando non esiste"
  },
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "L'evento è terminato."
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "Giorni di accesso insufficienti, impossibile riscuotere le ricompense"
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "Condizioni per la partecipazione all'evento non soddisfatte"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "Questo evento non esiste"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "Questo evento è in fase di sviluppo"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "Questo evento non è ancora iniziato"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "Missione dell'evento non completata"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "Evento demo: le ricompense non possono essere riscattate per i livelli incompleti"
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "Prova: questo livello non è stato trovato"
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "Questo Custode ha già fornito assistenza di supporto una volta per questo evento"
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "Questo evento richiede Custodi seguiti reciprocamente per fornire supporto in battaglia"
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "Hai aggiunto troppi Supporti preferiti. Per favore, modifica la lista."
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "Condizioni di potenziamento dell'abilità non soddisfatte"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "Il livello di Elevazione del Risvegliato è insufficiente"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "Il Risvegliatore non è ancora disponibile"
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "Il Risvegliato è già stato utilizzato"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "Non può essere bloccato nuovamente"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "Sei stato inserito nella lista nera da questo giocatore e non puoi procedere"
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "Sei nella lista nera di questo utente e non puoi seguirlo né mettere \"mi piace\""
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "Hai inserito questo utente nella lista nera e non puoi mettere \"mi piace\" né seguirlo"
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "Limite della lista nera raggiunto"
  },
  ErrCode_ERR_BATTLE_CREATE_FAILED_Desc = {
    Text = "Creazione Battaglia Fallita"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "Valuta insufficiente per acquistare il livello del Lasciapassare"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "Operazione fallita"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "Prezzo del privilegio di acquisto del Lasciapassare non configurato"
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "Il livello di privilegio del Lasciapassare è al massimo, impossibile acquistare di nuovo"
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "Livello di privilegio insufficiente per riscattare la ricompensa"
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "La ricompensa non esiste"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "Ricompensa riscossa"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "Essenza di Silver Core insufficiente"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "Tentativi di acquisto con voucher insufficienti"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "Le Reliquie non supportano il potenziamento"
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "Questa carta ha raggiunto il livello massimo e non può essere potenziata"
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "Questa carta non può essere potenziata"
  },
  ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc = {
    Text = "Il tuo commento contiene parole bloccate."
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "Hai già commentato."
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "L'hai già eliminato."
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "Hai già messo \"Mi piace\"."
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "Hai rimosso il \"Mi piace\" troppo velocemente."
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "Il commento è troppo lungo."
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "Questo commento è stato eliminato."
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "Tempo scaduto per il commento. Riprova."
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Nessun tentativo di potenziamento della carta esclusiva rimanente"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "Nessuna trama trovata per la sfida dell'istanza"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "Nessuna missione della trama trovata per le sfide dell'istanza"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "Immersione Fantasmatica in aggiornamento. Riprova più tardi."
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "Sfida completata. Le ricompense non possono essere riscattate di nuovo."
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "Sfida non completata. Ricompense non disponibili."
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "I punti richiesti per le ricompense del capitolo non sono stati raggiunti"
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "Le ricompense del capitolo sono già state riscattate"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "Nodo attuale non trovato"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "Nome del personaggio già in uso"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "Errore nell'inserimento dati del client"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "Nodo attuale non trovato. Impossibile chiudere."
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "Errore nei dati di configurazione"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "Impossibile riscuotere le ricompense"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "Condizioni di ricompensa non ancora soddisfatte"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "Nessun dato disponibile per i compiti del livello"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "Nessun punto per la missione di questa istanza"
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "Modulo per il punteggio dell'argomento non trovato"
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "Nessun compito trovato finora"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "Nessun dato unità trovato per l'argomento"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "L'unità è già stata inviata. Non è necessario inviarla di nuovo."
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "I sottocompiti della missione sono incompleti"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "Missione completata"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "I compiti dell'unità non sono stati completati interamente e non possono essere inviati"
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "La registrazione di nuovi Custodi è attualmente sospesa"
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "Nessun personaggio trovato. Creane uno."
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "Limite di utilizzo dei comandi personalizzati raggiunto"
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "La Reliquia è stata potenziata"
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "Menofina sufficiente, non è necessario ricaricare"
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "Non è possibile offrire sacrifici in questo momento."
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "L'accessorio non esiste"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "Errore nell'area dell'evento"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "La carta selezionata per l'evento non esiste"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "Troppe carte selezionate per l'evento"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "La Reliquia selezionata per l'evento non esiste"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "Troppe Reliquie selezionate per l'evento"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = "Tipo di evento inserito in modo errato nella tabella di configurazione dell'istanza"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "Errore nei dati dell'evento"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "Nessun aggiornamento delle carte bottino di battaglia rimasto"
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "Nessun aggiornamento delle Reliquie bottino di battaglia rimasto"
  },
  ErrCode_ERR_EVENT_FINISH_Desc = {
    Text = "Evento completato"
  },
  ErrCode_ERR_EVENT_NOT_FIND_Desc = {
    Text = "L'evento non esiste nell'istanza"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "Argento insufficiente. Impossibile acquistare."
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "Nessun evento trovato in questo nodo"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "Nessun dato nel pool casuale dell'evento"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "La funzione Giunzione è bloccata"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "L'accampamento ha già selezionato una funzione e non è possibile effettuare un'altra selezione"
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "La funzione accampamento non ha utilizzi rimanenti"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "Nessun aggiornamento del negozio dell'evento rimasto"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "I tentativi per rimuovere carte nel negozio dell'evento sono stati esauriti"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "Numero insufficiente di carte selezionate per l'evento"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "Reliquie selezionate per l'evento insufficienti"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "Impossibile trovare le informazioni sulla carta esclusiva specificata"
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "Il sentiero di potenziamento non ha un ID personaggio configurato"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "Carta esclusiva designata non sbloccata"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "Cambia la carta esclusiva per cambiare"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "Impossibile cambiare la carta esclusiva"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "Potenzia la carta esclusiva per cambiare"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "Impossibile trovare l'UUID per questa carta esclusiva"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "Il Risvegliatore di supporto non è più valido. Aggiorna la lista di assistenza e seleziona nuovamente un Risvegliatore di supporto."
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "Oggetto di sintesi non sbloccato"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "Valuta insufficiente per fabbricare l'oggetto"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc = {
    Text = "Materiali insufficienti per fabbricare l'oggetto richiesto"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "L'edificio esiste già e non può essere costruito di nuovo"
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "La posizione è già occupata da un Risvegliato, impossibile entrare"
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "L'edificio ha raggiunto il livello massimo"
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "L'edificio non esiste"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "Condizioni insufficienti per potenziare/costruire edifici"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "Oggetti insufficienti per il potenziamento/costruzione"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "Nessuna ricompensa disponibile al nodo attuale."
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "Nessun tentativo di sfida rimanente"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "I tuoi PV attuali sono troppo bassi e ti trovi ora in stato di Debolezza"
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "Si sblocca quando il livello di esplorazione raggiunge 2"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "Dopo aver completato un'esplorazione, puoi esplorare di nuovo istantaneamente."
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "Errore dell'istanza"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "Nessuna istanza trovata"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "Nodo bloccato"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "Nodo completato"
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "Nodo non completato"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "I nodi non sono adiacenti"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "Aggiornamenti del negozio insufficienti"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "Livello giocatore insufficiente"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "La descrizione contiene caratteri non consentiti. Inseriscila nuovamente."
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "L'avversario è attualmente occupato"
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "Valore dell'indice non valido"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "Sei già il loro invitante."
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "L'invitante esiste già"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "Errore di stato dell'istanza, effettua nuovamente l'accesso"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "Inventario pieno"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "Hai raggiunto il limite di acquisto giornaliero"
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "L'oggetto è già equipaggiato"
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "L'oggetto è bloccato"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "L'oggetto non è bloccato"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "L'oggetto ha raggiunto il livello massimo"
  },
  ErrCode_ERR_ITEM_NOT_ENOUGH_Desc = {
    Text = "Oggetti insufficienti"
  },
  ErrCode_ERR_ITEM_NOT_FIND_Desc = {
    Text = "Oggetto non trovato"
  },
  ErrCode_ERR_ITEM_NOT_MATCH_Desc = {
    Text = "Oggetto non corrispondente"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "Impossibile utilizzare l'oggetto"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "Oggetto duplicato"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "La Ruota del destino o la Posse non è ancora disponibile"
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "Quantità di utilizzo dell'oggetto non corretta"
  },
  ErrCode_ERR_ITEM_UNUSABLE_Desc = {
    Text = "Impossibile utilizzare l'oggetto"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "Nodo di attivazione precedente non trovato"
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "L'energia attualmente raccolta è insufficiente per attivare il portale. Sono necessari {s1} punti energia"
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "Livello massimo raggiunto"
  },
  ErrCode_ERR_LOCKED_Desc = {Text = "Bloccato"},
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "L'area dell'istanza non è ancora stata sbloccata"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "Spazzata della trama non ancora sbloccata"
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "L'istanza selezionata non è ancora stata sbloccata"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "La trama selezionata non è ancora stata sbloccata"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "Errore del server di accesso"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "Allegato riscattato"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "La posta non esiste"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "Partita fallita"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "Numero massimo di Risvegli raggiunto!"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "Impossibile sfidare il Dungeon d'Oro specificato"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "Seleziona un Risvegliato da schierare"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "Istanza di Oro designata bloccata - completare l'istanza di indagine specificata"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "Il tempo per cambiare nuovamente il nome non è ancora scaduto, si prega di attendere"
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "Il nome contiene caratteri non validi, si prega di reinserirlo"
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "La lunghezza del nome non è valida, deve essere di 2-4 caratteri"
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "La stringa inserita è troppo lunga"
  },
  ErrCode_ERR_NOTE_LENGTH_SHORT_Desc = {
    Text = "Testo inserito troppo corto"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "Punti insufficienti"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "Oggetto non posseduto"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "Impossibile muoversi"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "Funzione bloccata"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "Condizioni di ricompensa non soddisfatte. Impossibile riscuotere."
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "Profilo in aggiornamento, ricontrolla più tardi"
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "Nessuna Partita Amichevole in corso"
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "Nessun Patto inattivo"
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "Errore nei dati dell'NPC"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "L'NPC è già stato attivato"
  },
  ErrCode_ERR_NPC_NOT_FIND_Desc = {
    Text = "L'NPC non esiste"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "L'avversario è attualmente offline"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "Livello giocatore insufficiente"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "Stelle della trama insufficienti per la spazzata"
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "Nessun evento di dialogo della trama trovato"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "Tentativi di acquisto insufficienti per le sfide della storia"
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "Ricompensa riscossa"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "Ricompensa inesistente"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "Incastonamento della runa fallito"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "Collezione PVP non ottenuta"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "Posse insufficienti per lo schieramento della squadra Traphase"
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "WoD insufficienti per lo schieramento della squadra Traphase"
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "Requisiti della Modalità Selezione a Turno non soddisfatti"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "Sfida in fase di recupero"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "Nessun tentativo di sfida rimanente"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "Nessun avversario da sfidare"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "Seleziona un Risvegliato da schierare"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "Uno dei due giocatori ha ottenuto due vittorie. Non sono consentiti turni aggiuntivi."
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "L'avversario ha abbandonato la partita"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "Modalità Password non valida o scaduta"
  },
  ErrCode_ERR_RANK_OUT_OF_RANGE_Desc = {
    Text = "Al momento non è supportata la visualizzazione delle classifiche oltre il 2000° posto."
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "Nessuna configurazione corrispondente nelle impostazioni di ricarica"
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "Hai già ricevuto la ricarica gratuita e non puoi ricaricare di nuovo"
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "Limite di aggiornamento degli Oggetti raggiunto"
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "Dovete seguirvi a vicenda"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "Reliquie al completo"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "Richieste troppo frequenti. Riprova più tardi."
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "Materiali insufficienti per il potenziamento Élite"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "Valuta insufficiente per potenziare il Risvegliato"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "Errore nei dati del personaggio"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "Il tasso di avvento del Risvegliato è al massimo e non può essere aumentato ulteriormente"
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "Livello del Risvegliato insufficiente"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "Il Risvegliatore ha raggiunto il livello massimo e non può essere potenziato"
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "Valuta insufficiente"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "Il Risvegliato ha raggiunto il livello di Elevazione massimo."
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "Raggiungi il livello massimo per avanzare"
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "Nessun dato del Risvegliatore trovato"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "Il Risvegliato non possiede abilità"
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "Nessuna informazione sullo slot disponibile"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "Il potenziale del Risvegliato ha raggiunto il livello più alto"
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "Oggetti insufficienti per potenziare il potenziale del Risvegliato"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "Abilità del Risvegliato non ancora sbloccate"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "L'abilità ha raggiunto il livello massimo"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "Oggetti per il potenziamento dell'abilità insufficienti"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "Valuta insufficiente per il potenziamento delle abilità"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "Livello massimo raggiunto"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Nessuno slot di potenziamento manuale disponibile"
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "Avanzamento già effettuato; impossibile avanzare di nuovo"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "Oggetti insufficienti per il consumo di potenziamento del Risvegliato"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "Valuta insufficiente per potenziare il Risvegliato"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "Il Reame non soddisfa le condizioni"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "I Risvegliatori schierati nella Torre del Reame non soddisfano i requisiti del Reame"
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "Il livello inserito non è attualmente disponibile"
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "Impossibile schierare Risvegliatori identici nella Torre del Reame"
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "Argento insufficiente"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "Manutenzione del campus in corso. Attendere il completamento."
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "Servizio non avviato"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "Già acquistato"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "Attualmente impossibile percepire"
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "L'oggetto è scaduto e non può essere riscattato"
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "L'oggetto in vendita è esaurito"
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "Nessun dato del negozio disponibile"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "Nessun negozio di questo tipo"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "Oggetto non disponibile per la vendita"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "Il negozio non dispone di questo oggetto"
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "Nessun tentativo di aggiornamento disponibile"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "Questo oggetto non è disponibile nel negozio"
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "Il nodo attuale non è un negozio e non può essere aggiornato."
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "Il giocatore non esiste."
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "Tutti gli avatar della Visione Primordiale sono stati sconfitti"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "Il limite giornaliero di sfide per questo tipo di livello è stato raggiunto"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "Clic troppo frequenti. Riprova più tardi."
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "Funzione Risveglio non abilitata"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "Condizioni di attivazione non soddisfatte"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "Risonanza già attiva. Non è necessario attivarla di nuovo."
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "La Risonanza iniziale non può essere reimpostata"
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "Materiali di Risonanza insufficienti"
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "Il punto Risonanza ha raggiunto il livello massimo"
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "Nessuna Risonanza trovata nell'istanza"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "Nessun dato di Risonanza trovato"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "Nessun dato relativo al livello di Risonanza trovato"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "Nessun tentativo di ripristino disponibile"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "Effetti di produzione del Risvegliato sbloccati; non è necessario sbloccarli di nuovo."
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "Ricompensa riscossa"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "La missione delegata è completa e non può essere revocata"
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "Condizioni di assegnazione insufficienti"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "Missione completata"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "Compito non trovato"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "Missione incompleta, ricompensa non disponibile"
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "Il nome della squadra può contenere solo caratteri cinesi o inglesi"
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "Il nome della squadra non può superare gli 8 caratteri"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "Sono necessari 4 Risvegliati nella squadra"
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "Configurazione della squadra non trovata"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "Il Risvegliatore della squadra non ha configurato la Ruota del destino"
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "C'è un Conflitto di Reame con i Risvegliati nella squadra, si prega di effettuare delle modifiche"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "La Ruota del destino non esiste"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "Voucher insufficienti"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "Errore del token di accesso"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "Nodo di attivazione attuale non trovato"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "Accessorio non registrato, impossibile sostituire gli attributi"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "Smetti di seguire prima di bloccare"
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "Risveglio, Ruota del destino o Posse sono già stati utilizzati in questa sessione di gioco oggi"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "Impossibile sbloccare la missione secondaria: la missione secondaria è già disponibile"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "Impossibile sbloccare la missione secondaria: missione secondaria non attivata"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "Impossibile sbloccare la missione secondaria: nessun oggetto necessario per lo sblocco"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "Impossibile sbloccare la missione secondaria: missione secondaria già sbloccata"
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "Versione non corrispondente, effettua l'aggiornamento. Se già aggiornato, attendi il termine della manutenzione del campus."
  },
  ErrCode_FAILED_Desc = {Text = "Sconfitta"},
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "Questo personaggio esiste già; non è necessario crearne un altro"
  },
  ErrCode_SUCCESS_Desc = {Text = "Successo"}
})
return Text_ErrCode
