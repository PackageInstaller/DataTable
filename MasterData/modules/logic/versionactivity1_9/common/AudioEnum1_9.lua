-- chunkname: @modules/logic/versionactivity1_9/common/AudioEnum1_9.lua

module("modules.logic.versionactivity1_9.common.AudioEnum1_9", package.seeall)

local AudioEnum = AudioEnum

AudioEnum.VersionActivity1_9Store = {
	play_ui_jinye_chess_talk = 20170010,
	play_ui_jinye_click_stage = 20170011,
	stop_ui_jinye_chess_talk = 20170012,
	play_ui_jinye_chess_enter = 20170009
}
AudioEnum.VersionActivity1_9Enter = {
	play_ui_jinye_open = 20190004,
	play_ui_jinye_unfold = 20190021
}

local bgm = {
	ToughBattle = 3200140,
	role_activity_kakania = 3200139,
	Act1_9DungeonBgm = 3200137,
	HeroInvitation = 3200062,
	SemmelWeisGift = 20190124,
	role_activity_lucy = 3200138,
	RougeFavorite = 3200099,
	RougeMain = 3200143,
	FairyLand = 3200063
}
local UI = {
	OpenRewardNoticeView = 20190380,
	AddRougeDLC = 25002406,
	LossCollectionViewOpen = 20190340,
	RougeFavoriteAudio4 = 20190386,
	play_ui_replay_hearton = 20190215,
	play_ui_replay_boot = 20190202,
	play_ui_replay_whitenoise_loop = 20190203,
	LightTalentBranch = 20190375,
	StartShowSettlementTxt = 20190371,
	play_ui_dungeon_1_6_preparation_open_20190325 = 20190325,
	SwitchNormalLayer = 20190351,
	HeroGroupViewOpen = 20190343,
	LineExpanded = 20190332,
	play_ui_replay_shutdown = 20190205,
	RougeFavoriteAudio6 = 20190388,
	RougeFavoriteAudio3 = 20190385,
	ShowEndingTxt = 20190355,
	NextShowSettlementTxt = 20190383,
	play_ui_permanent_unlock = 20190003,
	play_ui_activity_course_open_20190317 = 20190317,
	play_ui_gudu_barrier_fall = 20190013,
	play_ui_gudu_bubble_click = 20190011,
	stop_ui_replay_whitenoise_loop = 20190204,
	OneKeyPlaceSlotArea = 20190310,
	UnEquipCollection = 20190305,
	StoreOpen = 20190347,
	OpenEndingThreeView = 25002518,
	play_ui_replay_heartoff = 20190216,
	LimiterStageChanged_5 = 20211705,
	ShowAchievement = 20190356,
	ComputeScore = 20190357,
	play_ui_gudu_soundwave_loop = 20190014,
	RougeFavoriteAudio5 = 20190387,
	RotateCollection = 20190306,
	LvUp = 20190362,
	play_ui_common_click_20190324 = 20190324,
	SwitchRougeDLC = 25002110,
	play_ui_dungeon_1_6_columns_update_20190318 = 20190318,
	NormalLayerMove = 25002519,
	play_ui_help_switch_20190322 = 20190322,
	play_ui_gudu_bean_fall = 20190018,
	RougeFavoriteAudio7 = 20190389,
	play_ui_gudu_bean_shaking = 20190012,
	RougeFavoriteAudio9 = 20190391,
	play_ui_checkpoint_insight_close_20190315 = 20190315,
	play_ui_replay_buttonsilp = 20190210,
	OneKeyClearSlotArea = 20190311,
	OpenLimiterResultView = 25002515,
	OpenRougeDangerousView = 25001313,
	play_ui_replay_buttonegg = 20190213,
	OpenRewardView = 20190379,
	play_ui_team_open_20190328 = 20190328,
	play_ui_pkls_role_move = 20190009,
	SelectNode = 20190334,
	RefreshRougeMapRule = 25002514,
	stop_ui_gudu_preheat = 20190126,
	LimiterStageChanged_4 = 20211704,
	ResetRougeLimiter = 25002515,
	DropRefresh = 20190345,
	play_ui_common_click_20190327 = 20190327,
	ChoiceViewOpen = 20190338,
	play_ui_qiutu_list_maintain_20190330 = 20190330,
	SwtichTalentTreeView = 20190376,
	play_ui_replay_open = 20190206,
	OpenTalentOverView = 20190377,
	play_ui_replay_tinyclose = 20190209,
	ChoiceViewChoiceOpen = 20190339,
	RefreshRougeBossCollection = 25001019,
	StopMoveAudio = 20190337,
	ClickLimiter2MaxLevel = 20190308,
	FailOpen = 20190360,
	play_ui_common_click_20190316 = 20190316,
	RougeFavoriteAudio8 = 20190390,
	play_ui_task_page_20190326 = 20190326,
	PlaceSlotCollection = 20190302,
	CoinChange = 20190348,
	play_ui_gudu_preheat = 20190125,
	PurdahPull = 20190358,
	MoveAudio = 20190336,
	play_ui_common_click_20190321 = 20190321,
	play_ui_gudu_kaishi = 20190006,
	LevelUpEffect = 20190307,
	play_ui_gudu_input_mistake = 20190016,
	UnlockRougeSkill = 25002110,
	MiddleLayerFocus = 20190349,
	OpenTalentTreeView = 20190372,
	SettlementCloseWindow = 20190352,
	play_ui_gudu_input_right = 20190017,
	play_ui_pkls_star_light_20190329 = 20190329,
	SelcetTalentItem = 20190373,
	play_ui_team_open_20190331 = 20190331,
	LimiterStageChanged_3 = 20211703,
	play_ui_replay_close = 20190207,
	LimiterStageChanged_2 = 20211702,
	LightTalentItem = 20190374,
	OpenRewardRoleView = 20190381,
	EquipedBlankLimiterBuff = 20211708,
	RougeAddExtraPoint = 20190006,
	play_ui_replay_tapswitch = 20190212,
	play_ui_replay_tunetable = 20190201,
	EngulfEffect = 20190308,
	ClickOverBranch = 20190378,
	play_ui_gudu_decrypt_succeed = 20190015,
	play_ui_replay_tinyopen = 20190208,
	MaxLevelLimiter = 2000071,
	OpenRougeLimiterLockedTips = 20161022,
	ElectricEffect = 20190309,
	PointLight = 20190341,
	DecreasePower = 20211706,
	play_ui_checkpoint_chain_20190320 = 20190320,
	FightSuccReward = 20190344,
	RougeFavoriteAudio2 = 20190384,
	play_ui_mln_unlock = 20190008,
	play_ui_dungeon_1_6_clearing_open_20190313 = 20190313,
	play_ui_dungeon_1_6_store_open_20190312 = 20190312,
	OpenLimiterBuffView = 25002104,
	play_ui_replay_buttoncut = 20190211,
	play_ui_gudu_symbol_click = 20190010,
	ShowRougeLimiter = 25002104,
	CollectionEnchant = 25001403,
	RefreshLimiterTips = 20161031,
	OpenTalentTrunkTreeView = 20190371,
	LimiterStageChanged_1 = 20211701,
	play_ui_dungeon_1_6_clearing_open_20190323 = 20190323,
	AddLimiterLevel = 20190006,
	DragCollection = 20007007,
	RewardCommonClick = 20190382,
	RougeFavoriteAudio1 = 20190383,
	UnlockLimiterBuff = 25002110,
	play_ui_gudu_win = 20190007,
	play_ui_replay_flap = 20190214,
	play_ui_gudu_bushu = 20190005,
	play_ui_dungeon_1_6_clearing_open_20190319 = 20190319,
	play_ui_checkpoint_chain_20190314 = 20190314,
	VictoryOpen = 20190361,
	CollectionChange = 20190363,
	EquipedNormalLimiterBuff = 20211707
}

for key, value in pairs(bgm) do
	if isDebugBuild and AudioEnum.Bgm[key] then
		logError("AudioEnum.Bgm重复定义" .. key)
	end

	AudioEnum.Bgm[key] = value
end

for key, value in pairs(UI) do
	if isDebugBuild and AudioEnum.UI[key] then
		logError("AudioEnum.UI重复定义" .. key)
	end

	AudioEnum.UI[key] = value
end

function AudioEnum.activate()
	return
end

return AudioEnum
