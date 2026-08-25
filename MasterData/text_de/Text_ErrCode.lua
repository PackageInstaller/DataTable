__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_CMD_UNDEFINED_Desc = {
    Text = "Befehl existiert nicht"
  },
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "Event beendet"
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "Nicht genügend Anmeldetage, um Belohnungen zu beanspruchen"
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "Bedingungen für die Teilnahme am Ereignis nicht erfüllt"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "Dieses Ereignis existiert nicht"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "Ereignis noch nicht entwickelt"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "Das Ereignis hat noch nicht begonnen"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "Ereignismission nicht abgeschlossen"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "Demo-Ereignis: Belohnungen können für unvollständige Stufen nicht beansprucht werden."
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "Prüfungsereignis: Diese Stufe wurde nicht gefunden."
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "Der Hüter dieses Events hat dir bereits einmal Unterstützung geboten."
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "Dieses Ereignis erfordert gegenseitige Aufmerksamkeit zwischen den Hütern, um Unterstützung zu bieten."
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "Die Anzahl der häufig verwendeten Unterstützungsschutzherren hat das Maximum erreicht. Bitte passen Sie die Liste der häufig verwendeten Unterstützung an"
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "Fähigkeitsaufstieg nicht erreicht"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "Wachaufkörperstufe nicht ausreichend"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "Der Erwacher hat die Öffnungszeit noch nicht erreicht."
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "Der Erwecker wurde bereits verwendet"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "Kann nicht erneut blockiert werde"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "Du wurdest von der anderen Person auf die schwarze Liste gesetzt, du kannst keine Aktionen ausführen"
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "Du bist von diesem Benutzer auf die schwarze Liste gesetzt worden und kannst ihnen nicht folgen oder sie mögen."
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "Du hast diesen Benutzer auf die schwarze Liste gesetzt und kannst ihn nicht mögen oder ihm folgen."
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "Blacklist-Limit erreicht"
  },
  ErrCode_ERR_BATTLE_CREATE_FAILED_Desc = {
    Text = "Kampferstellung fehlgeschlagen"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "Unzureichende Währung, um die Passstufe zu kaufen"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "Operation fehlgeschlagen"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "Durchgangskaufprivilegpreis nicht konfiguriert"
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "Das Pass-Niveau ist maximiert, kann nicht erneut gekauft werden."
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "Unzureichendes Privilegienniveau, um die Belohnung zu beanspruchen"
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "Belohnung existiert nicht"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "Belohnung abgeholt"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "Unzureichende Silberprimärwerte"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "Unzureichende Kaufanzahl"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "Relikte unterstützen keine Verstärkung."
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "Diese Karte hat das maximale Level erreicht und kann nicht verstärkt werden."
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "Diese Karte kann nicht verstärkt werden"
  },
  ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc = {
    Text = "Enthält blockierte Wörter"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "Kommentar wiederholen"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "Wiederholtes Löschen"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "Wiederholtes Lob"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "Wiederholen Sie das Abbrechen des Lobes"
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "Länge überschreitet das Limit"
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "Der Kommentar wurde gelöscht"
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "Kommentarzeitüberschreitung"
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Exklusive Karte aufgewertet, keine Versuche mehr"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "Keine Handlungsstränge für Dungeon-Herausforderungen gefunden"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "Keine Handlungsstränge für Dungeon-Herausforderungen gefunden"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "Die Daten zur Phantasmalen Sturzflug-Phase werden aktualisiert. Bitte versuchen Sie es später erneut."
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "Herausforderung abgeschlossen, Belohnung nicht erneut verfügbar"
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "Herausforderung nicht abgeschlossen, Belohnung nicht verfügbar"
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "Kapitelbelohnung nicht erreicht"
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "Kapitelbelohnung erhalten"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "Aktueller Knoten nicht gefunden"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "Duplizierter Charaktername"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "Client-Datenfehler"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "Aktueller Knoten nicht gefunden. Kann nicht geschlossen werden."
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "Konfigurationsfehler"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "Kann keine Belohnungen beanspruchen"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "Belohnungsbedingungen noch nicht erfüllt"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "Keine Levelaufgabendaten verfügbar"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "Keine Punkte für die Quest dieser Instanz"
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "Modul für die Fachnote nicht gefunden"
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "Bislang wurden keine Aufgaben gefunde"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "Keine Einheitendaten für das Thema gefunden"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "Modul eingereicht, keine erneute Einreichung nötig"
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "Teilaufgaben in der Mission sind unvollständig"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "Aufgabe abgeschlossen"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "Die Aufgaben unter der Einheit wurden nicht vollständig ausgeführt und können nicht eingereicht werden."
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "Die Registrierung neuer Hüter ist derzeit pausiert."
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "Kein Charakter gefunden. Bitte erstelle einen."
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "Die benutzerdefinierte Befehlsnutzung hat das Limit erreicht."
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "Relikt wurde verstärkt."
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "Menophin ist ausreichend, keine Auffüllung nötig"
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "Opfer können derzeit nicht dargebracht werden."
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "Zubehör existiert nicht"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "Fehler im Veranstaltungsbereich"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "Die Ereignisauswahlkarte existiert nicht"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "Zu viele Ereigniskarte"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "Ereignis Auswahlobjekt existiert nicht"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "Zu viele Relikte für das Ereignis ausgewählt"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = "Falscher Ereignistypen-Eintrag in der Dungeons-Konfigurationstabelle"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "Ereignisdaten Fehler"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "Kampf Drop-Aktualisierungskarten haben keine Begrenzung der Anzahl an Malen."
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "Keine Begrenzung für die Anzahl der Male, die Kampfbeute Relikte neu geladen werden könne"
  },
  ErrCode_ERR_EVENT_FINISH_Desc = {
    Text = "Ereignis abgeschlossen"
  },
  ErrCode_ERR_EVENT_NOT_FIND_Desc = {
    Text = "Ereignis existiert nicht im Verlies"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "Unzureichendes Mithril. Kauf nicht möglich."
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "Ereignis an diesem Knoten nicht gefunden"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "Keine Daten im Ereignis-Zufallspool"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "Funktion des Verbindungspunktes wurde gesperrt"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "Lagerfunktion wurde gewählt, kann nicht erneut gewählt werden"
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "Lagerfunktion hat keine Nutzungen mehr"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "Ereignis-Shop-Aktualisierung hat keine Begrenzung der Anzahl der Male."
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "Ereignis-Shop Kartenlöschungen aufgebraucht"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "Unzureichende Anzahl an gewählten Ereigniskarten"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "Ereignis Auswahlobjektanzahl unzureichend"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "Spezielle Karteninformationen nicht gefunden"
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "Upgrade-Pfad ohne Charakter-ID"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "Exklusive Karte nicht freigeschaltet"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "Exklusive Karte unverändert, Wechsel nicht möglich"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "Exklusive Karte wechseln fehlgeschlagen"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "Exklusive Karte nicht aufgewertet, Wechsel nicht möglich"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "UUID der speziellen Karte nicht gefunden"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "Der Unterstützungsmodus ist abgelaufen. Bitte aktualisieren Sie die Unterstützungsliste und wählen Sie einen neuen Unterstützungsmodus aus."
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "Synthesegegenstand nicht freigeschaltet"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "Nicht genügend Währung für die Synthese von Gegenständen"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc = {
    Text = "Nicht genügend andere Objekte für die Synthese von Gegenständen"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "Gebäude existiert bereits, kann nicht erneut gebaut werden"
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "Position bereits von einem Erwachten belegt, kann nicht betreten werden"
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "Gebäude hat das maximale Level erreicht"
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "Gebäude existiert nicht"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "Bedingungen für Upgrade/Bau unzureichend"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "Nicht genügend Gegenstände für das Upgrade/Bau"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "Keine Belohnungen am aktuellen Knoten verfügbar."
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "Keine Herausforderungen"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "Derzeit wenig Ausdauer, Sie befinden sich in einem geschwächten Zustand."
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "Freigeschaltet, wenn das Erkundungslevel 2 erreicht"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "Nachdem du erfolgreich eine Erkundung abgeschlossen hast, kannst du sofort wieder erkunden."
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "Dungeon-Fehler"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "Kein Entwurf gefunden"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "Knoten gesperrt"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "Knoten abgeschlossen"
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "Knoten nicht abgeschlossen"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "Knoten sind nicht benachbart"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "Unzureichende Ladenauffrischungen"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "Spielerlevel zu niedrig"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "Die Beschreibung enthält ungültige Zeichen. Bitte erneut eingeben."
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "Der Gegner befindet sich mitten in einer Untersuchung oder einem anderen Modus."
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "Falscher Indexwert"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "Sie sind bereits der Einlader der anderen Seite"
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "Einladender vorhanden"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "Dungeon-Zustandsfehler, bitte melden Sie sich erneut an"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "Inventar voll"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "Heute wurde das Kauf-Limit erreicht"
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "Gegenstand wurde ausgestattet"
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "Gegenstand ist gesperrt"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "Gegenstand Nicht Gesperrt"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "Gegenstand hat die maximale Stufe erreicht"
  },
  ErrCode_ERR_ITEM_NOT_ENOUGH_Desc = {
    Text = "Nicht genug Gegenstände"
  },
  ErrCode_ERR_ITEM_NOT_FIND_Desc = {
    Text = "Gegenstand nicht gefunden"
  },
  ErrCode_ERR_ITEM_NOT_MATCH_Desc = {
    Text = "Gegenstand nicht übereinstimmend"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "Gegenstand kann nicht verwendet werde"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "Duplizierter Gegenstand"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "Das Rad des Schicksals oder die Bande hat ihre Öffnungszeit noch nicht erreicht"
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "Falsche Anzahl an Gegenständen verwendet"
  },
  ErrCode_ERR_ITEM_UNUSABLE_Desc = {
    Text = "Gegenstand nicht nutzbar"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "Vorheriger Auslöseknoten nicht gefunden"
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "Die derzeit gesammelte Energie ist unzureichend, um das Portal zu aktivieren. {s1} Energiepunkte werden benötigt."
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "Maximales Level erreicht"
  },
  ErrCode_ERR_LOCKED_Desc = {
    Text = "Nicht freigeschaltet"
  },
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "Dungeon-Bereich noch nicht freigeschaltet"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "Handlungsstrang-Raid noch nicht freigeschaltet"
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "Gewählter Dungeon nicht freigeschaltet"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "Gewählte Storyline nicht freigeschaltet"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "Login-Serverfehler"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "Anhang beansprucht"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "Die Post existiert nicht"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "Spiel fehlgeschlagen"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "Maximale Anzahl an Erwachensvorgängen erreicht!"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "Nicht in der Lage, das spezifische Gold-Dungeon herauszufordern."
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "Bitte wählen Sie den Erweckten für den Einsatz"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "Zugesicherter Gold-Dungeon gesperrt - Bitte beende den angegebenen Ermittlungs-Dungeon"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "Die Wartezeit für eine erneute Namensänderung ist noch nicht abgelaufen. Bitte warten."
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "Der Name enthält unzulässige Zeichen. Bitte erneut eingeben."
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "Die Namenslänge ist ungültig. Es müssen 2–4 Zeichen sein."
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "Die Eingabestring ist zu lang"
  },
  ErrCode_ERR_NOTE_LENGTH_SHORT_Desc = {
    Text = "Eingabe zu kurz"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "Nicht genug Punkte"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "Sie haben diesen Gegenstand nicht"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "Kann nicht bewegen"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "Funktion noch nicht verfügbar"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "Belohnungsbedingungen nicht erfüllt. Kann nicht beansprucht werden."
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "Aktualisierung des Profils, bitte später erneut überprüfen."
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "Kein laufendes freundliches Spiel"
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "Kein untätiges Bündnis"
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "NPC-Datenfehler"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "NPC wurde bereits aktiviert"
  },
  ErrCode_ERR_NPC_NOT_FIND_Desc = {
    Text = "NPC existiert nicht"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "Der Gegner ist derzeit offline"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "Spielerlevel zu niedrig"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "Nicht genug Sterne im Handlungsstrang, um zu raiden"
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "Kein Handlungsdialogereignis gefunden"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "Nicht genug Käufe für Handlungsstrang-Herausforderung"
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "Belohnung abgeholt"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "Keine solche Belohnung"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "Rune-Einbettung fehlgeschlagen"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "PVP-Sammlung nicht erhalten"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "Die Traphase-Liste hat nicht genug Banden."
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "Unzureichendes Rad des Schicksals für die Traphase-Teamaufstellung"
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "Bedingungen zur Aktivierung des Wahlmodus nicht erfüllt"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "Herausforderung in Abkühlung"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "Keine Herausforderungen"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "Keine Herausforderer"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "Bitte wählen Sie den Erweckten für den Einsatz"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "Einer der beiden Spieler hat zwei Siege errungen. Keine weiteren Runden sind erlaubt."
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "Gegner hat das Spiel verlasse"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "Passwortkampf existiert nicht oder ist abgelaufen"
  },
  ErrCode_ERR_RANK_OUT_OF_RANGE_Desc = {
    Text = "Das Anzeigen von Ranginformationen außerhalb der Top 2000 wird derzeit nicht unterstützt."
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "Keine solche Konfiguration in der Aufladetabelle"
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "Bereits kostenlos aufgeladen, kann nicht erneut aufgeladen werden"
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "Die Anzahl der Artikelauffrischungen hat das obere Limit erreicht."
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "Nicht in einem gegenseitig befolgten Zustand"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "Relikte Voll"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "Anfrage zu häufig. Bitte versuchen Sie es später erneut."
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "Unzureichende Materialien für die Elite-Verbesserung"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "Unzureichende Währung zur Verbesserung des Erwachers"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "Charakterdatenfehler"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "Die Ankunftsrate des Erweckers ist maximal und kann nicht weiter erhöht werden."
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "Erwecker Stufe unzureichend"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "Der Erwecker hat die maximale Stufe erreicht und kann nicht weiter aufgerüstet werden."
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "Nicht genug Währung"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "Der Erwacher hat das höchste Bildungslevel erreicht."
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "Kann nicht vorankommen, ohne das höchste Level zu erreiche"
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "Keine Erwachensdaten gefunden"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "Der Erwacher hat keine Fähigkeiten."
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "Keine Slot-Informationen"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "Das Potenzial des Erweckers hat das höchste Niveau erreicht."
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "Unzureichende Gegenstände, um das Potenzial des Erwachers zu verbessern"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "Erwecker Fähigkeiten noch nicht freigeschaltet"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "Fähigkeit hat maximale Stufe erreicht"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "Nicht genug Gegenstände zur Verbesserung von Fähigkeiten"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "Unzureichende Währung für Fähigkeits-Upgrades"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "Maximales Level erreicht"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Keine manuellen Upgrade-Slots mehr"
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "Bereits fortgeschritten. Kann nicht erneut fortschreiten."
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "Unzureichende Gegenstände für den Verbrauch bei der Verbesserung des Erwachers"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "Unzureichende Währung zur Verbesserung des Erwachers"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "Das Reich erfüllt nicht die Bedingunge"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "Erwachende, die im Reichsturm eingesetzt sind, erfüllen nicht die Anforderungen des Reichs."
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "Die Stufe, die du betreten hast, ist derzeit nicht verfügbar."
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "Identische Erwacher können im Reichsturm nicht eingesetzt werden"
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "Silberkernmangel"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "Campus in Wartung, bitte warten"
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "Dienst nicht gestartet"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "Artikel gekauft"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "Derzeit nicht in der Lage zu fühlen"
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "Der Artikel ist abgelaufen und kann nicht eingelöst werden."
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "Das verkaufte Produkt ist nicht mehr auf Lager"
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "Keine Geschäftsdaten"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "Kein Geschäftstyp"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "Kein Verkauf dieses Artikels"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "Der Laden führt diesen Artikel nicht."
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "Keine Erfrischungen"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "Dieser Gegenstand ist im Laden nicht erhältlich."
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "Aktuell ist kein Shop-Knoten und kann nicht aktualisiert werden."
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "Der Spieler existiert nicht."
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "Alle Avatare der Urvision wurden besiegt"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "Die tägliche Herausforderungenanzahl des Quest-Typs hat das Limit erreicht"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "Zu häufiges Klicken. Bitte versuche es später noch einmal."
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "Wach-Funktion nicht aktiviert"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "Aktivierungsbedingungen nicht erfüllt"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "Resonanz aktiviert, keine erneute Aktivierung erforderlich"
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "Der anfängliche Resonanzzustand kann nicht zurückgesetzt werden."
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "Unzureichende Resonanzmaterialien."
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "Der Resonanzpunkt hat das maximale Niveau erreicht."
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "Keine Resonanz im Instance gefunden"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "Keine Resonanzdaten gefunden"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "Kein Resonanzlevel-bezogene Daten gefunden"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "Keine Rücksetzversuche verfügbar"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "Die Produktionseffekte des Erweckers sind freigeschaltet; es muss nichts mehr freigeschaltet werden."
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "Belohnung abgeholt"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "Die übertragene Mission ist abgeschlossen und kann nicht zurückgerufen werden."
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "Unzureichende Anforderungen für die Zuordnung"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "Aufgabe abgeschlossen"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "Aufgabe nicht gefunden"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "Quest unvollständig, Belohnung nicht verfügbar"
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "Der Teamname darf nur chinesische oder englische Zeichen enthalten."
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "Teamname darf nicht länger als 8 Zeichen sein"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "Mindestens vier Erwachte werden im Team benötigt, um die Bühne zu betreten."
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "Teamkonfiguration nicht gefunden"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "Der Erwecker des Teams hat das Rad des Schicksals nicht eingerichtet."
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "Es gibt einen Konflikt im Bereich mit den Erweckern im Team, bitte nehmen Sie Anpassungen vor"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "Rad des Schicksals existiert nicht"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "Unzureichende Beweise"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "Login-Token-Fehler"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "Aktueller Trigger-Knoten nicht gefunden"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "Zubehör nicht aufgezeichnet, Attribute können nicht ersetzt werden"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "Zuerst entfolgen, dann blocken"
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "Erwecker, Rad des Schicksals oder Bande wurden heute in diesem Gameplay verwendet."
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "Seitenquest konnte nicht freigeschaltet werden: Seitenquest verfügbar"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "Freischaltung der Nebenquest fehlgeschlagen: Nebenquest nicht aktiviert"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "Freischalten der Nebenquest fehlgeschlagen: Keine benötigten Gegenstände für das Freischalten vorhande"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "Seitenquest konnte nicht freigeschaltet werden: Seitenquest bereits freigeschaltet."
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "Versionsmissverhältnis. Bitte aktualisiere auf den neuesten Client; wenn bereits aktualisiert, warte bitte, bis die Wartungsarbeiten des Campus abgeschlossen sind."
  },
  ErrCode_FAILED_Desc = {Text = "Fehlschlag"},
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "Bereits existierende Charaktere müssen nicht erneut erstellt werden."
  },
  ErrCode_SUCCESS_Desc = {
    Text = "Operation erfolgreich"
  }
})
return Text_ErrCode
