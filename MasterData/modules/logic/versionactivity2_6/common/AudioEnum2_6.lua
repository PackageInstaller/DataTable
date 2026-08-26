-- chunkname: @modules/logic/versionactivity2_6/common/AudioEnum2_6.lua

module("modules.logic.versionactivity2_6.common.AudioEnum2_6", package.seeall)

local AudioEnum2_6 = _M

AudioEnum2_6.VersionActivity2_6Store = {
	play_ui_jinye_chess_talk = 20170010,
	play_ui_jinye_click_stage = 20170011,
	stop_ui_jinye_chess_talk = 20170012,
	play_ui_jinye_chess_enter = 20170009
}
AudioEnum2_6.VersionActivity2_6Enter = {
	play_ui_jinye_open = 20260001,
	play_ui_jinye_unfold = 20260002
}
AudioEnum2_6.WeekWalk_2 = {
	play_ui_fight_artificial_unlock = 20260143,
	play_ui_fight_artificial_equip = 20260123,
	play_ui_fight_artificial_stars_pad = 20260125,
	play_ui_fight_artificial_unequip = 20260124,
	play_ui_fight_artificial_star = 20260126
}
AudioEnum2_6.DiceHero = {
	play_ui_wenming_buff = 20260108,
	play_ui_wenming_roll = 20260110,
	play_ui_wenming_shotimp = 20260106,
	play_ui_wenming_cardready = 20260102,
	play_ui_wenming_glassclick = 20260115,
	play_ui_wenming_unclockglass = 20260116,
	play_ui_wenming_alaifuchapter = 20260113,
	Bgm = 3260002,
	play_ui_rewards = 20260119,
	play_ui_pkls_endpoint_arrival = 20260121,
	play_ui_pkls_challenge_fail = 20260122,
	play_ui_wenming_debuff = 20260109,
	play_ui_activity_open = 20260101,
	play_ui_wenming_cardrelease = 20260104,
	play_ui_wenming_cardunready = 20260103,
	play_ui_wenming_ideachange = 20260111,
	play_ui_wenming_alaifugameplay = 20260112,
	play_ui_wenming_unclockchapter = 20260114,
	Bgm_Game = 20260129,
	play_ui_feichi_yure_caption = 20260117,
	play_ui_rewards_rare = 20260120,
	play_ui_wenming_shot = 20260105,
	stop_ui_feichi_yure_caption = 20260118,
	play_ui_wenming_defense = 20260107
}
AudioEnum2_6.Xugouji = {
	episodeFinish = 20260147,
	cardPerspective = 20260136,
	episodeSelect = 20260139,
	episodeUnlock = 20260148,
	showGameTarget = 20260138,
	cardClose = 20260132,
	cardInfo = 20260134,
	cardPerspectiveEnd = 20260137,
	changeTurn = 20260149,
	enemyDamage = 20260145,
	cardBoxOpen = 20260140,
	cardFilp = 20260131,
	playerDamage = 20260146,
	cardDisappear = 20260135,
	cardBoxClose = 20260141,
	cardLock = 20260142,
	cardPair = 20260133
}
AudioEnum2_6.BP = {
	FaceView = 20260144,
	MainBtn = 20260020,
	BpDayFirstAnim = 20260130
}
AudioEnum2_6.WeekwalkHeart = {
	play_ui_wenming_popup = 20260902
}
AudioEnum2_6.WarmUp = {
	play_ui_wenming_cut_20260903 = 20260903,
	play_ui_wenming_page_20260904 = 20260904
}

local bgm = {
	XugoujiBgm = 3260003,
	Act2_6DungeonBgm = 3260001
}

for key, value in pairs(bgm) do
	if isDebugBuild and AudioEnum.Bgm[key] then
		logError("AudioEnum.Bgm重复定义" .. key)
	end

	AudioEnum.Bgm[key] = value
end

return AudioEnum2_6
