-- chunkname: @modules/logic/versionactivity2_4/common/AudioEnum2_4.lua

module("modules.logic.versionactivity2_4.common.AudioEnum2_4", package.seeall)

local AudioEnum = AudioEnum

AudioEnum.VersionActivity2_4Dungeon = {
	play_ui_diqiu_complete = 20240060,
	play_ui_lvhu_clue_write_2 = 20240058,
	enterview_tab_switch = 20240063,
	play_ui_diqiu_open = 20240057,
	play_ui_mln_page_turn = 20240059
}
AudioEnum.Bakaluoer = {
	play_ui_diqiu_settle_accounts = 20240050,
	play_ui_diqiu_unlock = 20240051,
	play_ui_diqiu_perfect = 20240056,
	play_ui_diqiu_count_down = 20240049
}
AudioEnum.Act181 = {
	play_ui_diqiu_xueye_open = 20240052
}
AudioEnum.Act178 = {
	act178_audio8 = 20249008,
	act178_audio14 = 20249014,
	bgm_city = 20240047,
	act178_audio3 = 20249003,
	act178_audio10 = 20249010,
	act178_audio20 = 20249020,
	act178_audio12 = 20249012,
	act178_audio15 = 20249015,
	act178_audio4 = 20249004,
	act178_audio9 = 20249009,
	act178_audio18 = 20249018,
	act178_audio13 = 20249013,
	act178_audio16 = 20249016,
	act178_audio5 = 20249005,
	act178_audio19 = 20249019,
	bgm_game = 20240048,
	act178_audio17 = 20249017,
	act178_audio6 = 20249006,
	act178_audio1 = 20249001,
	act178_audio7 = 20249007,
	act178_audio34 = 20249034,
	act178_audio2 = 20249002,
	act178_audio11 = 20249011
}
AudioEnum.WuErLiXi = {
	play_ui_diqiu_put = 20246004,
	bgm_wuerliximapgame = 20240045,
	play_ui_diqiu_jinru = 20246001,
	play_ui_diqiu_revolve = 20246005,
	play_ui_diqiu_success = 20246007,
	bgm_wuerliximap = 20240044,
	play_ui_diqiu_choose = 20246003,
	play_ui_diqiu_signal = 20246002,
	play_ui_diqiu_enable = 20246006
}
AudioEnum.PlayerCard = {
	play_ui_diqiu_card_open_2 = 20240062,
	play_ui_diqiu_card_open_1 = 20240061
}
AudioEnum.NewTurnabck = {
	play_ui_call_back_Interface_entry_04 = 20249025,
	play_ui_call_back_letter_expansion = 20249021,
	play_ui_call_back_Interface_entry_01 = 20249022,
	play_ui_call_back_nameplate_switch = 20249026,
	play_ui_call_back_Interface_entry_02 = 20249023,
	play_ui_call_back_Interface_entry_03 = 20249024
}

local bgm = {
	Act2_4DungeonBgm = 20240001
}
local UI = {
	play_ui_diqiu_yure_ring_20249041 = 20249041,
	play_ui_diqiu_yure_click_20249044 = 20249044,
	play_ui_diqiu_yure_success_20249043 = 20249043,
	play_ui_mln_remove_effect_20249042 = AudioEnum.Meilanni.play_ui_mln_remove_effect
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
