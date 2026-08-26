-- chunkname: @modules/logic/versionactivity3_8/common/AudioEnum3_8.lua

module("modules.logic.versionactivity3_8.common.AudioEnum3_8", package.seeall)

local AudioEnum3_8 = _M

AudioEnum3_8.Puzzle = {
	play_ui_mistakes = 380006,
	play_ui_shiji_stone_shake_long = 380010,
	play_ui_shiji_stone_music = 380017,
	play_ui_shiji_stoneamb_loop = 380032,
	play_ui_shiji_place_success = 380008,
	play_ui_qiutu_organ_sink = 380005,
	play_ui_qiutu_stele_put = 380004,
	stop_ui_shiji_stoneamb_loop = 380033,
	play_ui_lushang_level_complete = 380019,
	stop_ui_bus = 380018,
	play_ui_shiji_stone_shake_short = 380009,
	play_ui_shiji_slot_light = 380007
}
AudioEnum3_8.VersionActivity3_8 = {
	play_ui_shiji_3_8_open_2 = 380021,
	play_ui_shiji_3_8_open_1 = 380020
}
AudioEnum3_8.FreeMonthCard = {
	play_ui_wulu_kerandian_monster02_stand = 380023,
	play_ui_mln_unlock = 380022
}
AudioEnum3_8.DianJiShi = {
	OnGameFinished = 360024,
	EndDragGameBlock = 380042,
	EnterGame = 313002,
	UnlockNewEpisode = 380040,
	BeginDragGameBlock = 380041,
	OnGameCompleted = 313006
}

return AudioEnum3_8
