__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_CMD_UNDEFINED_Desc = {
    Text = "La commande n'existe pas"
  },
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "Événement terminé"
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "Jours de connexion insuffisants pour réclamer des récompenses"
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "Conditions pour participer à l'événement non remplies"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "Cet événement n'existe pas"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "Événement encore en développement"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "L'événement n'a pas encore commencé"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "Mission d'événement non terminée"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "Événement démo : Les récompenses ne peuvent pas être réclamées pour les phases incomplètes."
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "Événement d'Essai : Ce niveau n'a pas été trouvé."
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "Le Gardien de cet événement vous a déjà apporté son soutien une fois."
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "Cet événement nécessite une attention mutuelle entre les Gardiens pour fournir un soutien."
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "Le nombre d'assistance au combat courante du Gardien a atteint sa limite, veuillez ajuster la liste d'assistance au combat courante"
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "Conditions d'amélioration de compétence non remplies"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "Le grade du réveilleur n'est pas suffisant pour l'élévation"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "L'Éveilleur n'a pas encore atteint l'heure d'ouverture."
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "L'Éveilleur a déjà été utilisé"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "Impossible d'être bloqué à nouveau"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "Vous avez été ajouté à la liste noire de l'adversaire, vous ne pouvez pas agir"
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "Vous avez été black-listé par cet utilisateur et vous ne pouvez pas le suivre ou l'aimer."
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "Tu as mis cet utilisateur sur liste noire et tu ne peux pas aimer ou le suivre."
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "Limite de liste noire atteinte"
  },
  ErrCode_ERR_BATTLE_CREATE_FAILED_Desc = {
    Text = "Échec de la création du combat"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "Monnaie insuffisante pour acheter le niveau de Pass"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "Échec de l'opération"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "Prix du privilège d'achat de passage non configuré"
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "Le niveau de privilège Pass est au maximum, incapacité à acheter à nouveau."
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "Niveau de privilège insuffisant pour réclamer la récompense"
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "La récompense n'existe pas"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "Récompense reçue"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "Prime d'argent insuffisante"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "Nombre d'achats par preuve insuffisant"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "Les Reliques ne soutiennent pas le renforcement."
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "Cette carte a atteint le niveau maximum et ne peut pas être renforcée."
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "Cette carte ne peut pas être renforcée"
  },
  ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc = {
    Text = "Contient des mots bloqués"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "Répéter le commentaire"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "Suppression répétée"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "Bien répété"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "Annuler le like"
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "Longueur dépassant la limite"
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "Commentaire de J'aime supprimé"
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "Temps écoulé pour les commentaires"
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Pas de mise à niveau de la carte exclusive"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "Ligne de scénario de défi de donjon non trouvée"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "Ligne de scénario de défi de donjon non trouvée"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "Les données de la scène de plongée fantomale sont en cours de mise à jour. Veuillez réessayer plus tard."
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "Défi terminé, récompense non disponible"
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "Défi non terminé, récompense non disponible"
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "Récompense de chapitre non atteinte"
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "Récompense de chapitre reçue"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "Nœud actuel introuvable"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "Nom de personnage en double"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "Erreur de données du client"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "Nœud actuel non trouvé. Impossible à fermer."
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "Erreur de configuration"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "Incapable de réclamer des récompenses"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "Conditions de récompense pas encore remplies"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "Aucune donnée de tâche de niveau disponible"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "Pas de points pour cette quête d'instance"
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "Module pour le score du sujet introuvable"
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "Aucune tâche trouvée jusqu'à présent"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "Aucune donnée d'unité trouvée pour le sujet"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "Unité soumise, pas besoin de soumettre à nouveau"
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "Les sous-tâches de la mission sont incomplètes"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "Mission terminée"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "Les tâches sous l'unité n'ont pas été entièrement complétées et ne peuvent pas être soumises."
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "L'enregistrement de nouveaux Gardiens est actuellement en pause."
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "Aucun personnage trouvé. Veuillez en créer un."
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "L'utilisation de commande personnalisée a atteint la limite."
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "La Relique a été renforcée."
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "Menophin suffisant, aucun complément nécessaire"
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "Les sacrifices ne peuvent pas être offerts en ce moment."
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "L'accessoire n'existe pas"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "Erreur dans la zone d'événement"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "La Carte de Sélection d'Événement n'existe pas"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "Trop de cartes Événement"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "Création de sélection d'événement inexistante"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "Trop de reliques sélectionnées pour l'événement"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = ": Type d'événement incorrect dans le tableau de configuration du donjon"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "Erreur de données d'événement"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "Le nombre de fois où les cartes de rafraîchissement de chute de bataille peuvent être utilisées n'est pas limité."
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "Pas de limite au nombre de fois que les reliques des batailles peuvent être rafraîchies"
  },
  ErrCode_ERR_EVENT_FINISH_Desc = {
    Text = "Événement complété"
  },
  ErrCode_ERR_EVENT_NOT_FIND_Desc = {
    Text = "L'événement n'existe pas dans le donjon"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "Mithril insuffisant. Impossible d'acheter."
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "Événement introuvable à ce nœud"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "Aucune donnée dans le pool aléatoire de l'Événement"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "La fonction de point de contact est verrouillée"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "Fonction du campement déjà sélectionnée, impossible de choisir à nouveau"
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "Fonction du campement épuisée"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "Le rafraîchissement de la boutique d'événements n'a pas de limite sur le nombre de fois."
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "Nombre de suppressions de cartes dans la boutique d'événements épuisé"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "Nombre de cartes d'événement sélectionnées insuffisantes"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "Nombre de créations de sélection d'événement insuffisant"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "Carte exclusive introuvable"
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "Aucun ID de personnage configuré pour la route de mise à niveau"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "Carte exclusive non déverrouillée"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "Pas de changement de la carte exclusive, impossible de changer"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "Échec du changement de carte exclusive"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "Pas de mise à niveau de la carte exclusive, impossible de changer"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "UUID de la carte exclusive introuvable"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "L'éveillé d'assistance au combat n'est plus valide. Veuillez actualiser la liste d'assistance et sélectionner à nouveau un éveillé d'assistance au combat."
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "Objet de synthèse non déverrouillé"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "Pas assez de monnaie pour composer un objet"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc = {
    Text = "Pas assez d'objets nécessaires pour la synthèse"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "Construction existante, impossible de reconstruire"
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "Position occupée par un éveillé, impossible de s'installer"
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "Construction au niveau maximum"
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "Construction inexistante"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "Conditions insuffisantes pour améliorer/construire le bâtiment"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "Objets nécessaires pour améliorer/construire insuffisants"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "Aucune récompense disponible au nœud actuel."
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "Pas de tentatives de défi"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "Actuellement faible en endurance, vous êtes dans un état de faiblesse."
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "Débloqué lorsque le niveau d'exploration atteint 2"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "Après avoir réussi à compléter une exploration, vous pouvez immédiatement explorer à nouveau."
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "Erreur de donjon"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "Aucune instance trouvée"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "Nœud verrouillé"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "Nœud Complété"
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "Noeud non complété"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "Les nœuds ne sont pas adjacents"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "Rafraîchissements de magasin insuffisants"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "Niveau du joueur insuffisant"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "La description contient des caractères illégaux. Veuillez ressaisir."
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "L'adversaire est en train d'enquêter ou dans un autre mode."
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "Index erroné"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "Vous êtes déjà l'invitant de l'autre partie"
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "Invitation existante"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "Erreur d'état du donjon, veuillez vous reconnecter"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "Inventaire plein"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "Nombre maximum d'achats atteint aujourd'hui"
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "Objet a été équipé"
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "L'objet est verrouillé"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "Objet Non Verrouillé"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "Objet a atteint le niveau maximum"
  },
  ErrCode_ERR_ITEM_NOT_ENOUGH_Desc = {
    Text = "Objets insuffisants"
  },
  ErrCode_ERR_ITEM_NOT_FIND_Desc = {
    Text = "Objet non trouvé"
  },
  ErrCode_ERR_ITEM_NOT_MATCH_Desc = {
    Text = "Incompatibilité d'objet"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "Objet ne peut pas être utilisé"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "Objet dupliqué"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "La Roue du Destin ou la Posse n'a pas encore atteint son heure d'ouverture"
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "Erreur de quantité d'objets"
  },
  ErrCode_ERR_ITEM_UNUSABLE_Desc = {
    Text = "Objet inutilisable"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "Nœud de déclenchement précédent introuvable"
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "L'énergie actuellement collectée est insuffisante pour activer le portail. {s1} points d'énergie sont nécessaires."
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "Niveau maximum atteint"
  },
  ErrCode_ERR_LOCKED_Desc = {
    Text = "Non déverrouillé"
  },
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "Zone de donjon non débloquée"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "Balayage de la ligne de scénario non débloqué"
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "Le donjon choisi n'est pas débloqué"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "La ligne de scénario choisie n'est pas débloquée"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "Erreur du serveur de connexion"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "Pièce jointe revendiquée"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "Le courrier n'existe pas"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "Échec de la partie"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "Nombre maximum de réveils atteint !"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "Impossible de défier le Donjon d'Or spécifié."
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "Choisissez l'éveillé à déployer"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "Donjon d'Or Désigné Verrouillé - Veuillez compléter le donjon d'Investigation spécifié"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "Le délai avant de pouvoir changer de nom à nouveau n'est pas encore écoulé, veuillez Attendre"
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "Le nom contient des caractères illégaux, veuillez réessayer"
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "La longueur du nom est invalide, elle doit être de 2 à 4 caractères"
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "La chaîne d'entrée est trop longue"
  },
  ErrCode_ERR_NOTE_LENGTH_SHORT_Desc = {
    Text = "Saisie trop courte"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "Pas assez de points"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "Vous n'avez pas cet objet"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "Impossible de bouger"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "Fonction pas encore disponible"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "Conditions de récompense non remplies. Impossible à réclamer."
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "Mise à jour du profil en cours, veuillez revenir plus tard."
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "Aucun match amical en cours"
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "Pas de Pacte inactif"
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "Erreur de données NPC"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "Le NPC a déjà été déclenché"
  },
  ErrCode_ERR_NPC_NOT_FIND_Desc = {
    Text = "NPC inexistant"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "L'adversaire est actuellement hors ligne"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "Niveau du joueur insuffisant"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "Étoiles de la ligne de scénario insuffisantes, balayage impossible"
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "Aucun événement de dialogue d'intrigue trouvé"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "Nombre d'achats de défis de la ligne de scénario insuffisant"
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "Récompense reçue"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "Pas de telle récompense"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "Échec de l'encrage de rune"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "Collection PVP Non Obtenue"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "Le roster de Traphase manque suffisamment de Posses."
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "Roue du destin insuffisante pour le déploiement de l'équipe Traphase"
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "Conditions de déverrouillage du mode de sélection de roue non remplies"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "Défi en cours de recharge"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "Pas de tentatives de défi"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "Pas d'adversaire à défier"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "Choisissez l'éveillé à déployer"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "Un des deux joueurs a réalisé deux victoires. Aucun tour supplémentaire n'est autorisé."
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "L'adversaire a quitté le jeu"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "Combat de mot de passe n'existe pas ou a expiré"
  },
  ErrCode_ERR_RANK_OUT_OF_RANGE_Desc = {
    Text = "La consultation des informations de classement au-delà du rang 2000 n'est pas encore prise en charge."
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "Aucune configuration de recharge trouvée"
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "Recharge gratuite déjà effectuée, impossible de recharger à nouveau"
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "Le nombre de rafraîchissements d'objets a atteint la limite supérieure."
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "Pas dans un état de suivi mutuel"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "Reliques pleines"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "Demande trop fréquente. Veuillez réessayer plus tard."
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "Matériaux insuffisants pour l'amélioration élite"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "Monnaie insuffisante pour améliorer le Réveilleur"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "Erreur de données du personnage"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "Le taux d'arrivée de l'Éveillé est au maximum et ne peut plus être augmenté."
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "Niveau d'Éveilleur insuffisant"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "L'Éveilleur a atteint le niveau maximum et ne peut pas être amélioré."
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "Fonds insuffisants"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "L'Éveilleur a atteint le plus haut niveau d'Édification."
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "Impossible d'avancer sans atteindre le niveau maximum"
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "Pas de données d'éveillés trouvées"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "L'Éveilleur n'a pas encore de compétences."
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "Pas d'informations de slot"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "Le potentiel de l'Éveillé a atteint le niveau maximum."
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "Articles insuffisants pour améliorer le potentiel du Réveilleur"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "Compétences d'Éveilleur pas encore déverrouillées"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "Compétence au niveau maximum"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "Pas assez d'Objets de Mise à Niveau de Compétences"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "Monnaie insuffisante pour les mises à niveau de compétence"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "Niveau maximum atteint"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Plus de tentatives de mise à niveau manuelle"
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "Déjà avancé. Ne peut plus avancer."
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "Articles insuffisants pour la consommation de mise à niveau du Réveilleur"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "Monnaie insuffisante pour améliorer le Réveilleur"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "Le Royaume ne remplit pas les conditions"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "Les Éveilleurs déployés dans la Tour du Royaume ne remplissent pas les exigences du Royaume."
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "Le niveau que vous avez atteint n'est actuellement pas disponible."
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "Impossible de déployer des Réveilleurs identiques dans la Tour du Royaume"
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "Noyau d'argent insuffisant"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "Maintenance du campus en cours, veuillez patienter"
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "Service non démarré"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "Article acheté"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "Actuellement incapable de percevoir"
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "L'article a expiré et ne peut pas être échangé."
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "L'article vendu est en rupture de stock"
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "Pas de données de magasin"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "Pas de type de magasin"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "Pas de produit à vendre"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "Le magasin ne porte pas cet article."
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "Pas de tentatives de rafraîchissement"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "Cet objet n'est pas disponible dans le magasin."
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "Actuellement, ce n'est pas un nœud de boutique et ne peut pas être actualisé."
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "Le joueur n'existe pas."
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "Tous les avatars de la Vision Primordiale ont été vaincus"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "Le compteur de défis quotidiens du type de quête a atteint la limite"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "Cliquez trop fréquemment. Veuillez réessayer plus tard."
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "Fonction réveil non activée"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "Conditions d'activation non remplies"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "Résonance activée, pas besoin de réactiver"
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "L'état de Résonance initial ne peut pas être réinitialisé."
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "Matériaux de Résonance insuffisants."
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "Le Point de Résonance a atteint le niveau maximum."
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "Aucune résonance trouvée dans l'instance"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "Aucune donnée de résonance trouvée"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "Aucune donnée liée au niveau de Résonance trouvée"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "Aucune tentative de réinitialisation disponible"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "Effets de production d'Éveilleur déverrouillés ; pas besoin de déverrouiller à nouveau."
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "Récompense reçue"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "La mission déléguée est complète et ne peut être rappelée."
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "Conditions d'attribution insuffisantes"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "Mission terminée"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "Tâche non trouvée"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "Quête incomplète, récompense indisponible"
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "Le nom de l'équipe ne peut contenir que des caractères chinois ou anglais."
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "Nom de l'équipe ne peut dépasser 8 caractères"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "Au moins quatre Réveillés sont requis dans l'équipe pour entrer sur la scène."
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "Configuration de l'équipe non trouvée"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "L'Awakener de l'équipe n'a pas mis en place la Roue du Destin."
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "Il y a un conflit de royaume avec les Éveilleurs dans l'équipe, veuillez apporter des ajustements"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "La Pile du Destin n'existe pas"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "Preuve insuffisante"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "Erreur de jeton de connexio"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "Nœud de déclenchement actuel introuvable"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "Accessoire non enregistré, impossible de remplacer les attributs"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "Se désabonner d'abord, puis bloquer"
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "Les Réveilleurs, la Roue du Destin ou Posse ont été utilisés dans cette gameplay aujourd'hui."
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "Échec du déverrouillage de la quête secondaire : Quête secondaire disponible"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "Échec du déblocage de la quête secondaire : quête secondaire non activée"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "Échec du déblocage de la quête secondaire : Aucun objet requis pour le déblocage"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "Échec du déverrouillage de la quête secondaire : Quête secondaire déjà déverrouillée."
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "Incompatibilité de version. Veuillez mettre à jour vers le dernier client ; si déjà mis à jour, veuillez attendre la fin de la maintenance du campus."
  },
  ErrCode_FAILED_Desc = {Text = "Échec"},
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "Les personnages existants n'ont pas besoin d'être recréés."
  },
  ErrCode_SUCCESS_Desc = {
    Text = "Opération réussie"
  }
})
return Text_ErrCode
