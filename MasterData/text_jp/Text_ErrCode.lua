__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_CMD_UNDEFINED_Desc = {
    Text = "命令は存在しません"
  },
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "イベント終了"
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "ログイン日数が足りないため、報酬を受け取れません"
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "イベント参加、条件未達成"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "このイベントは存在しない"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "イベント未開発"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "イベント未開始"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "イベントタスク未完了"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "試遊イベント、未完了のステージでは報酬を受け取れません"
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "試遊イベント中、このステージは見つかりませんでした"
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "本イベントでは、この守秘者は既にあなたに一度救援をしました。"
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "本イベントでは、相互フォローしている守秘者だけが救援を提供できます。"
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "常用救援守秘者が上限に達しました。常用救援リストを調整してください"
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "スキルアップ条件未達成"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "覚醒体の昇格レベルが不足"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "覚醒体はまだ開放時間に達していない"
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "覚醒体は使用済みです"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "ブロックリストに再追加できません"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "相手にブロックされているため、操作が制限されています。"
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "相手にブロックリストに追加されました。フォローといいねができません。"
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "相手をブロックリストに追加しました。いいねとフォローができません。"
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "ブロック人数が上限に達しました"
  },
  ErrCode_ERR_BATTLE_CREATE_FAILED_Desc = {
    Text = "バトルの作成に失敗しました"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "通行証レベル購入に必要な通貨が不足しています"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "操作失敗"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "通行証の特権購入価格が設定されていません"
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "通行証特権レベル満了、再度購入不可"
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "特権レベル不足、受け取れません"
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "報酬は存在しません"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "報酬を受け取りました"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "シルバーコアプラチナジェル不足"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "証拠購入回数不足"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "遺物は強化をサポートしていません"
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "このカードは最大レベルに達しており、強化できません"
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "このカードは強化できません"
  },
  ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc = {
    Text = "禁止ワードを含んでいます"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "コメントが重複しています"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "既に削除済みです"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "既に「いいね」済みです"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "既に「いいね」は解除されています"
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "長さが制限を超えています"
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "「いいね」したコメントは削除されました"
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "コメントのタイムアウト"
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "専用カードの強化回数がありません"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "未発見のステージチャレンジのストーリーライン"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "未発見のステージチャレンジのストーリーライン任務"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "幻夢の深奥ステージデータ更新中です。しばらくしてから再試行してください。"
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "挑戦任務が完了しているため、再度報酬を受け取れません"
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "挑戦任務が未完了のため、報酬を受け取れません"
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "章の報酬がポイントに達していません"
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "章の報酬を受け取りました"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "現在のノードが見つかりません"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "キャラクター名が重複しています"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "クライアントデータエラー"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "現在のクローズノードが見つかりません"
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "設定表エラー"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "報酬受領不可"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "報酬の受け取り条件を満たしていません"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "ステージに課題分データがありません"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "このステージの課題ポイントがありません"
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "課題のモジュールが見つかりません"
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "任務はまだ見つかっていません"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "課題の分単元データが見つかりません"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "ユニットは提出済み、再提出不要"
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "任務中のサブ任務が未完了"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "任務完了"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "ユニットのタスクがすべて完了していないため、提出できません"
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "現在新しい守秘者の登録は一時停止されています"
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "キャラクターがいません、作成が必要です"
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "カスタム指令の使用回数が上限に達しました"
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "遺物は強化済みです"
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "エンフェリン十分、補充不要"
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "現在祭祀を行うことができません"
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "「密約」が存在しません"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "事件エリアエラー"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "事件選択カードが存在しません"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "事件選択カードが多すぎます"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "事件選択遺物が存在しません"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "事件選択遺物が多すぎます"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = "ステージ事件リストに入力ミス"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "事件データエラー"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "戦闘でのドロップカードの更新回数は無制限"
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "戦闘でのドロップ遺物の更新回数は無制限"
  },
  ErrCode_ERR_EVENT_FINISH_Desc = {
    Text = "ステージ事件完了"
  },
  ErrCode_ERR_EVENT_NOT_FIND_Desc = {
    Text = "ステージ事件は存在しません"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "白銀が不足しているため購入できません"
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "事件ノードが見つかりません"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "事件ランダムプールにデータがありません"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "休憩所の機能がロックされています"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "選択したキャンプ機能は再度選択できません"
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "キャンプ機能の使用回数がなくなりました"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "事件商店の更新回数がありません"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "事件商店のカード削除回数が上限に達しました"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "事件選択カードが不足"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "事件選択遺物が不足"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "指定された専用カード情報が見つかりません"
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "強化ルートにキャラIDが設定されていません"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "専用カード未解放"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "専用カードに変化がないため、切り替えできません"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "専用カードの切り替えに失敗しました"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "専用カードが強化されていないため、切り替えできません"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "この専用カードのuuidが見つかりません"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "救援覚醒体が無効になりました。救援リストを更新して再選択してください。"
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "合成アイテムが未解放"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "合成アイテムに必要な通貨が不足しています"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc = {
    Text = "合成アイテムに必要な他のアイテムが不足しています"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "建物は既に存在し、再建設できません"
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "位置に既に覚醒体が存在し、入居できません"
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "建物は最大レベルに達しています"
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "建物が存在しません"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "強化/建設条件不足"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "強化/建設に必要なアイテムが不足しています"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "現在のノードには報酬がありません"
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "挑戦回数がありません"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "現在のスタミナは低すぎ、すでに衰弱した状態にあります"
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "ステージ探索レベル2で解放"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "探索を一回成功すると即時探索可能"
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "ステージエラー"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "ステージが見つかりません"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "ノード未解放"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "ノード完了"
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "ノード未完了"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "ノードが隣接していない"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "商店の更新回数が不足"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "プレイヤーレベル不足"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "概要に不正な文字が含まれています、再入力してください"
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "相手が調査または他のプレイモード中です"
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "誤ったインデックス値"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "あなたは既に相手の招待者です"
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "既に招待者がいます"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "ステージ状態エラー、再ログインしてください"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "バックパックが満杯です"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "今日の購入回数が上限に達しました"
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "アイテムが装備されています"
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "アイテムがロックされています"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "アイテムがロックされていません"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "アイテムが最大ランクに達しました"
  },
  ErrCode_ERR_ITEM_NOT_ENOUGH_Desc = {
    Text = "アイテムが不足しています"
  },
  ErrCode_ERR_ITEM_NOT_FIND_Desc = {
    Text = "アイテムが見つかりません"
  },
  ErrCode_ERR_ITEM_NOT_MATCH_Desc = {
    Text = "アイテムが一致しません"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "アイテムが使用できません"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "アイテム重複"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "命輪またはキーオーダーはまだ開放時間に達していない"
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "アイテム使用数エラー"
  },
  ErrCode_ERR_ITEM_UNUSABLE_Desc = {
    Text = "アイテム使用不可"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "前のトリガーノードが見つかりません"
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "現在収集したエネルギーがポータルを起動するのに不足しています。ポータルを起動するには{s1}ポイントのエネルギーが必要です。"
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "最大レベルに到達済み"
  },
  ErrCode_ERR_LOCKED_Desc = {Text = "未解放"},
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "ステージエリア未解放"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "ストーリーライン掃討未解放"
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "選択したステージは未解放"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "選択したストーリーラインは未解放"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "サーバーログインエラー"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "添付ファイルを受け取りました"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "メールが存在しません"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "マッチング失敗"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "最大覚醒可能回数に達しました！"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "指定ゴールド本挑戦不可"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "出陣する覚醒体を選択してください"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "指定ゴールド本未解放-指定の調査サブを完了してください"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "名前変更の待機時間が終わっていません。しばらく待つてください"
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "名前に不正な文字が含まれています。再度入力してください"
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "名前の長さが不正です。2〜4文字で入力してください"
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "文字数が長すぎます"
  },
  ErrCode_ERR_NOTE_LENGTH_SHORT_Desc = {
    Text = "入力文字が短すぎます"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "ポイントが足りません"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "このアイテムはありません"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "移動不可"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "機能は未開放です"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "報酬の条件を満たしていないため、受け取れない"
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "プロフィールを更新中です。しばらくしてから再度ご確認ください。"
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "現在進行中のフレンドマッチはありません"
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "現在、待機状態の密約はありません"
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "NPCデータエラー"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "NPCは既にトリガーされています"
  },
  ErrCode_ERR_NPC_NOT_FIND_Desc = {
    Text = "NPCが存在しません"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "相手が現在オンラインではありません"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "プレイヤーレベル不足"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "ストーリーライン星評価数不足、掃討不可"
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "シナリオ対話事件が見つかりません"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "ストーリーライン挑戦購入回数不足"
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "報酬を受け取りました"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "この報酬はありません"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "ルーンの埋め込み失敗"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "PVPコレクション未取得"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "対人戦チームのキーオーダーが不足しています"
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "対人戦チームの命輪が不足しています"
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "ドラフトモードの解放条件を満たしていません"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "挑戦クールダウン中"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "挑戦回数がありません"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "挑戦相手がいません"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "出陣する覚醒体を選択してください"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "どちらかが2回勝利したため、もう1戦はできません"
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "対人戦相手が退出しました"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "パスワード対戦が存在しないか、期限切れです"
  },
  ErrCode_ERR_RANK_OUT_OF_RANGE_Desc = {
    Text = "現在、2000位以外のランキング情報の閲覧はサポートされていません。"
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "チャージ設定表にこの設定はありません"
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "無料チャージ済みで再チャージ不可"
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "商品更新回数が上限に達しました"
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "相互フォローではない"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "遺物が満杯です"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "リクエストが多すぎます。しばらくしてからお試しください"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "精鋭化に必要な素材が不足しています"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "覚醒体のレベルアップに必要な通貨が不足しています"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "キャラクターデータエラー"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "覚醒体の降臨度は満たされ、これ以上の向上はできません"
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "覚醒体レベル不足"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "覚醒体は最大レベルに達しており、これ以上レベルアップできません"
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "通貨が不足しています"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "覚醒体は最高ランクに昇格済みです"
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "最大レベルに達していないため、進級できません"
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "覚醒体データが見つかりません"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "覚醒体はスキルを持っていません"
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "スロット情報がありません"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "覚醒体の潜在能力は最大レベルに達しています"
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "覚醒体の潜在能力アップアイテムが不足しています"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "覚醒体はスキルが未解放です"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "スキルが最大レベルに達しました"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "スキルアップ用アイテムが不足しています"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "スキルアップ通貨が不足しています"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "最大レベルに到達済みです"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "手動スロット強化の回数がありません"
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "進級済み、再進級不可"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "覚醒体の強化に必要なアイテムが不足しています"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "覚醒体のレベルアップに必要な通貨が不足しています"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "界域が条件を満たしていません"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "界域タワーに出撃する覚醒体がエリア要件を満たしていません"
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "入ったステージが現在開いているステージに含まれていない"
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "界域タワーに同じ覚醒体を出撃させることはできません"
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "シルバーコア不足しています"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "現在メンテナンス中です\n完了するまでお待ちください"
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "サービス未起動"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "商品購入済み"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "現在感応を行うことができません"
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "商品の期限が切れ、交換不可"
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "販売商品は在庫がありません"
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "商店データがありません"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "このタイプの商店はありません"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "この商品は販売されていません"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "商店にこの商品は売っていません"
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "更新回数がありません"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "商店にこの商品はありません"
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "現在はショップノードではないため更新できません"
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "このプレイヤーは存在しません"
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "この原初の視線のすべての分身は既に撃破された"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "ステージタイプのデイリー挑戦回数が上限に達しました"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "タップが多すぎます、しばらくしてからお試しください"
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "覚醒機能未開放"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "起動条件が不足しています"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "共鳴は起動済みのため、再度起動する必要はありません"
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "共鳴初期状態はリセットできません"
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "共鳴材料が不足しています"
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "共鳴は最大レベルに達しました"
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "ステージの共鳴が見つかりません"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "共鳴データが見つかりません"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "共鳴レベル関連データが見つかりません"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "リセット回数がありません"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "覚醒体の生産効果が解放されており、再度解放する必要はありません"
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "報酬を受け取りました"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "派遣任務が完了しました。取り消し不可です。"
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "派遣条件不足"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "任務完了"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "未発見の任務"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "任務未完了、報酬を受け取れません"
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "チーム名には漢字または英字以外の文字を含めないでください"
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "チーム名の長さは8文字以下にしてください"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "チームに最低4体の覚醒体が必要です"
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "チーム設定が見つかりません"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "チームの覚醒体に命輪が設定されていません"
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "同時に編成できない界域の覚醒体が設定されています。\n編成を変更してください。"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "命輪は存在しません"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "証拠不足"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "ログイントークンエラー"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "現在のトリガーノードが見つかりません"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "「密約」未転写、能力変更不可"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "まずはフォローを解放してからブロックしてください"
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "覚醒体、命輪、またはキーオーダーは今日このプレイで使用済みです"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "サブステージ解放失敗：既に利用可能"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "サブステージ解放失敗：未開放"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "サブステージ解放失敗：解放アイテム不要"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "サブステージ解放失敗：解放済み"
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "バージョンが一致しません。最新のクライアントを更新してください。\n更新済みの場合は、メンテナンスが完了するまでお待ちください。"
  },
  ErrCode_FAILED_Desc = {Text = "失敗"},
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "キャラクターが既に存在、再作成不要"
  },
  ErrCode_SUCCESS_Desc = {
    Text = "成功操作"
  }
})
return Text_ErrCode
