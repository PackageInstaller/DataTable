__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_CMD_UNDEFINED_Desc = {
    Text = "Команда не существует"
  },
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "Мероприятие завершено"
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "Недостаточно дней входа, награду получить нельзя"
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "Участвовать в акции, не выполнены условия"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "Эта акция не существует"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "Акция ещё не запущена"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "Акция еще не активирована"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "Задача на акцию не завершена"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "Тестовая акция: награду можно получить только за завершенные Уровни"
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "Во время акции не удалось найти этот Уровень"
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "В этой акции Страж уже предоставил вам помощь в бою"
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "Для участия в этой акции нужно взаимное внимание Хранителей тайн, чтобы оказать помощь в бою"
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "Максимум часто используемых помощников достигнут, пожалуйста, отрегулируйте список часто используемых помощников"
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "Навык улучшен не достиг настроек"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "Уровень пробуждающего тела недостаточен"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "Время открытия пробуждающего тела ещё не наступило"
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "Пробуждающее тело было использовано"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "Повторная блокировка невозможна"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "Ты был занесён в черный список, невозможно действовать"
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "Вы были добавлены в черный список и не можете ни обратить внимание, ни лайкнуть"
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "Вы уже добавили этого пользователя в черный список, поэтому не можете лайкнуть и подписаться"
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "Количество заблокированных пользователей достигло максимума"
  },
  ErrCode_ERR_BATTLE_CREATE_FAILED_Desc = {
    Text = "Ошибка создания боя"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "Недостаточно валюты для покупки уровня пропуска"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "Операция не удалась"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "В паспорте не настроена цена покупки привилегий"
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "Уровень привилегий паспорта полностью заполнен, невозможно совершить повторную покупку"
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "Недостаточный Уровень привилегий для получения"
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "Награда отсутствует"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "Награда получено"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "Недостаточно источной жидкости в сердечнике из серебра"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "Недостаточно раз покупки сертификата"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "Артефакт не поддерживает Усиление"
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "Эта Карта достигла максимального уровня и не может быть усиленена"
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "Эта Карта не может быть Усиление"
  },
  ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc = {
    Text = "Содержит блокированные слова"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "Повторное комментирование"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "Повторное удаление"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "Повторное добавление лайка"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "Повторное снятие лайка"
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "Длина превышает лимит"
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "Комментарий «нравится» был удалён"
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "Время комментария истекло"
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Улучшение эксклюзивной карты, без ограничения по количеству раз"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "Не удалось найти сюжетную линию для копии с вызовом"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "Не удалось найти сюжетную задачу для вызова копии"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "Данные уровня «Иллюзорное Вдаль от берегов» обновляются, пожалуйста, повторите попытку позже."
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "Задача на вызов завершена, награду уже нельзя получить"
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "Задача на вызов пока не завершена, невозможно получить награду"
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "Не набрано достаточное количество очков для награды главы"
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "Награда за главу получена"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "Выбор текущего узла не найден"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "Имя роли повторяется"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "Ошибка при передаче данных клиентом"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "Текущий узел не найден, закрытие невозможно"
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "Ошибка в таблице конфигурации"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "Награду получить невозможно"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "Награда пока недоступна для получения"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "Уровень не имеет данных о темах"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "У этой копии нет темы"
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "Тема не найдена в модуле"
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "Задача ещё не найдена"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "Не удалось найти данные о разделении темы"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "Юнит уже отправлен на проверку, повторная отправка не требуется"
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "В задаче подзадача Не завершено"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "Задача Завершено"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "Задачи подраздела ещё не всё выполнены, нельзя отправить"
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "В настоящее время регистрация новых Хранителей тайн приостановлена"
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "Нет персонажа, нужно создать"
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "Достигнут предел количества использований пользовательской команды"
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "Создание Усиление"
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "Линфеин уже достаточен, пополнение не требуется"
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "Сейчас нельзя провести Жертвенный ритуал"
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "Украшение отсутствует"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "Ошибка зоны события"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "Карта выбора события отсутствует"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "Количество карт выбора события слишком велико"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "Событие выбора не существует в создании"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "Слишком много событий для выбора создания"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = "Ошибка в заполнении типа в таблице конфигурации копий событий"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "Ошибка события"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "В бою дроп карт не имеет ограничений по количеству раз"
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "Бой обновляет дроп созданий без ограничений по количеству раз"
  },
  ErrCode_ERR_EVENT_FINISH_Desc = {
    Text = "Событие в копии завершено"
  },
  ErrCode_ERR_EVENT_NOT_FIND_Desc = {
    Text = "Событие копии не существует"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "Недостаточно мифрила для покупки"
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "Событие не содержит этот узел"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "Событие случайный пул не содержит данных"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "Функция точки связи недоступна"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "В лагере уже выбрана функция, которую нельзя выбрать повторно"
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "Функция лагеря больше не имеет раз использования"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "Магазин событий обновляется без ограничений"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "Количество использований для удаления карт в магазине событий закончилось"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "Недостаточно карт для события"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "Количество созданий для выбора создания недостаточно"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "Не удалось найти информацию об указанной эксклюзивной карте"
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "Маршрут улучшения не сконфигурирован для ID роли"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "Указанная эксклюзивная Карта не разблокировано"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "Специальная Карта не изменилась, переключение невозможно"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "Неудача при переключении специальной карты"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "Эксклюзивная Карта не может быть переключена без улучшения"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "Uuid этой эксклюзивной карты не найден"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "Эффект призыва к бою потерян, обновите список помощи и выберите заново призываемый корпус."
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "Синтезировать предмет не разблокировано"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "Недостаточно валюты для синтезировать предмета"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc = {
    Text = "Не хватает предметов для синтезировать"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "Здание уже существует и не может быть построено повторно"
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "Место уже содержит пробуждающее тело, невозможно разместиться"
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "Здание уже достигло максимального уровня"
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "Здания отсутствует"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "Условия для улучшения/строительства здания не соблюдены"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "Недостаточно предметов для улучшения/строительства"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "Текущий узел не имеет награды, которую можно получить"
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "Нет раз вызова"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "Текущий Уровень выносливости слишком низкий, вы уже ослаблены."
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "Исследование копии разблокируется при достижении 2-го уровня"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "Успешно завершив исследование, можно мгновенно исследовать"
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "Копия ошибки"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "Не удалось найти подземелье"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "Узел не разблокировано"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "Узел Завершено"
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "Узел не завершено"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "Узлы не смежны"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "Не хватает раз обновления магазина"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "Недостаточный Уровень игрока"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "Описание содержит недопустимые символы, пожалуйста, введите снова"
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "Соперник находится в расследовании или занят в другом игровом режиме"
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "Неправильное значение индекса"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "Вы уже являетесь приглашенным другой стороны"
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "Уже есть приглашенные"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "Ошибка состояния копии, пожалуйста, войдите снова"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "Рюкзак полон"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "Лимит покупок на сегодня исчерпан"
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "Предмет уже в снаряжении"
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "Предмет был заблокирован"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "Предмет разблокирован"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "Предмет достиг максимального ранга"
  },
  ErrCode_ERR_ITEM_NOT_ENOUGH_Desc = {
    Text = "Предметов недостаточно"
  },
  ErrCode_ERR_ITEM_NOT_FIND_Desc = {
    Text = "Предмет не найден"
  },
  ErrCode_ERR_ITEM_NOT_MATCH_Desc = {
    Text = "Предмет не подходит"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "Предмет невозможно использовать"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "Предмет дублируется"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "Судьба или ключевой приказ ещё не открыты"
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "Ошибка в использовании количества предметов"
  },
  ErrCode_ERR_ITEM_UNUSABLE_Desc = {
    Text = "Предмет нельзя использовать"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "Предыдущий триггерный узел не найден"
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "Текущий запас энергии недостаточен для активации портала, нужно {s1} единиц энергии."
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "Достигнут максимальный Уровень"
  },
  ErrCode_ERR_LOCKED_Desc = {
    Text = "Не разблокировано"
  },
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "Область копии не разблокирована"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "Сюжетная линия очистки не разблокирована"
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "Выбранная Копия не разблокирована"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "Выбранная сюжетная линия еще не разблокирована"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "Ошибка при входе на сервер"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "Награда получена"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "Почтовое сообщение отсутствует"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "Соответствие не найдено"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "Достигнуто максимальное количество пробуждений!"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "Указанное золотое подземелье невозможно вызвать —"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "Выберите пробуждающее тело в бой"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "Указанный золотой режим не разблокировано - пожалуйста, завершите указанную копию расследования"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "Время до следующей смены имени ещё не истекло, пожалуйста, подождите"
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "Имя содержит недопустимые символы, пожалуйста, введите снова"
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "Недопустимая длина имени, необходимо от 2 до 4 символов"
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "Слишком много символов"
  },
  ErrCode_ERR_NOTE_LENGTH_SHORT_Desc = {
    Text = "Введено слишком мало символов"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "Недостаточно очков"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "У вас нет этого предмета"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "Неподвижный"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "Функция пока недоступна"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "Условия не выполнены, награда недоступна"
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "Обновление личной информации, пожалуйста, проверьте позже."
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "Текущий дружеский матч не в процессе"
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "В данный момент нет свободных мистерий"
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "Ошибка данных NPC"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "NPC уже активирован"
  },
  ErrCode_ERR_NPC_NOT_FIND_Desc = {
    Text = "NPC не существует"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "Противник сейчас не в сети"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "Недостаточный Уровень игрока"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "Сюжетная линия не имеет достаточного количества звезд для быстрой очистки"
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "Не удалось найти событие сюжетного диалога"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "Недостаточно покупок для вызова в сюжете"
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "Награда получено"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "Такой награды нет"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "Вставка руны неудача"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "Не получено PVP-избранное"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "Фазовый поединок: команде не хватает ключевых приказов для выхода в бой"
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "В команде фазового поединка не хватает судьбы для выхода в бой"
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "Условия для включения режима выбора не достигнуты"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "Перезарядка вызова"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "Нет раз вызова"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "Нет противника для вызова"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "Выберите пробуждающее тело в бой"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "Один из игроков уже одержал две победы, нельзя начать ещё одну игру"
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "Противник Выход"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "Битва с кодом не существует или устарела."
  },
  ErrCode_ERR_RANK_OUT_OF_RANGE_Desc = {
    Text = "Просмотр рейтинговой информации за пределами топ-2000 пока не поддерживается."
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "В таблице конфигурации пополнения отсутствует такая конфигурация"
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "Бесплатное пополнение уже выполнено, повторное невозможно"
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "Количество обновлений товара достигло лимита"
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "Не находятся в состоянии взаимной подписки"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "Реликвии заполнены"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "Запрос слишком частый, попробуйте ещё раз чуть позже"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "Недостаточно материалов для элиты"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "Недостаточно валюты для расхода на Улучшение пробуждающего тела"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "Ошибка данных роли"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "Уровень прибытия тела пробуждения достиг максимума, дальнейшее Улучшение невозможно"
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "Недостаточный Уровень пробуждающего тела"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "Пробуждающее тело достигло максимального уровня и его нельзя улучшить"
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "Недостаточно валюты"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "Пробуждающее тело достигло высшего уровня"
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "Не достигнут максимальный Уровень, невозможно повысить ранг"
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "Не удалось найти данные тела пробуждения"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "Пробуждающее тело не имеет навык"
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "Нет информации о слотах"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "Потенциал пробуждающего тела достиг максимума"
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "Недостаточно предметов для улучшения потенциала пробуждающего тела"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "Пробуждающее тело еще не разблокировало навык"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "Навык достиг максимума своего уровня"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "Недостаточно предметов для улучшения навыков"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "Недостаточно валюты для Навыка улучшен"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "Достигнут максимальный Уровень"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Нет доступных раз для ручного улучшения слотов"
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "Уже продвинут, не может быть продвинут снова"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "Для улучшения пробуждающего тела не хватает предметов"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "Недостаточно валюты для расхода на Улучшение пробуждающего тела"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "Регион не удовлетворяет условиям"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "Пробуждающее тело, задействованное в башне границ, не удовлетворяет требованиям области"
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "Входящий Уровень не входит в список доступных уровней"
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "Башня границ не может использовать одинаковые пробуждающие тела в бою"
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "Сердечника недостаточно"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "Кампус закрыт на обслуживание, пожалуйста, подождите завершения ремонта"
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "Сервис не запущен"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "Товар куплено"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "В данный момент индукция невозможна"
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "Товар просрочен и не подлежит обмену"
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "Товаров для продажи больше нет в наличии"
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "Нет данных о магазине"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "Нет этого типа магазина"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "Такой товар не продаётся"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "Магазин не продает этот товар"
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "Нет доступных обновлений"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "В магазине нет этого товара"
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "Текущий узел не магазин, невозможно обновить"
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "Этот игрок не существует"
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "Все клоны Первоначального зрения уже убиты"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "Тип уровня достигнут лимита ежедневных испытаний"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "Слишком частые нажатия. Пожалуйста, попробуйте позже"
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "Функция пробуждения не активирована"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "Условия активации не хватает"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "Резонанс активирован, повторная активация не требуется"
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "Резонанс в начальном состоянии не может быть сброшен"
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "Материал для резонанса недостаточен."
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "Резонанс достиг максимального уровня"
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "В копии не обнаружено резонанса"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "Данные о резонансе не найдены"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "Данные о уровне резонанса не найдены"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "Нет раза сброса"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "Эффект производства пробуждающего тела разблокировано, повторная разблокировка не требуется"
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "Награда получено"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "Задача завершена, возврат невозможен"
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "Недостаточно условий для делегирования"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "Задача Завершено"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "Задача не найдена"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "Задача не завершена, награда недоступна для получения"
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "Название команды не может содержать не китайские или английские символы"
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "Длина имени команды не может быть больше 8 символов"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "Количество пробуждающих тел в команде должно быть четыре для входа в Уровень"
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "Не найдена командная конфигурация"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "У команды пробуждающего тела не активирована Колесо Судьбы"
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "Ошибка в составе команды для расследования границы"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "Не существует судьбы"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "Доказательства недостаточны"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "Ошибка маркера входа"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "Текущий триггерный узел не найден"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "Аксессуар не имеет транскрипции, невозможно заменить свойства"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "Сначала отписаться от пользователя, чтобы заблокировать его"
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "Пробуждающее тело, Колесо Судьбы или ключевой приказ сегодня уже Использовано в этом режиме игры"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "Разблокировка побочного задания неудача: побочное задание доступно"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "Разблокировка побочной линии неудача: побочная линия не активирована"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "Разблокировка побочного квеста неудача: нет необходимости разблокировать предмет"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "Неудача при разблокировке побочной линии: побочная линия разблокировано"
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "Номер версии не соответствует, пожалуйста, обновите последнюю версию клиента; если уже обновлено, пожалуйста, подождите завершения обслуживания системы"
  },
  ErrCode_FAILED_Desc = {
    Text = "Неудача"
  },
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "Уже имеющаяся роль не требует повторного создания"
  },
  ErrCode_SUCCESS_Desc = {
    Text = "Операция успешно выполнена"
  }
})
return Text_ErrCode
