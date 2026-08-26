-- chunkname: @modules/logic/versionactivity2_1/common/AudioEnum2_1.lua

module("modules.logic.versionactivity2_1.common.AudioEnum2_1", package.seeall)

local AudioEnum = AudioEnum

AudioEnum.VersionActivity2_1Enter = {
	play_ui_open = 20210103
}
AudioEnum.Activity156 = {
	play_ui_wangshi_fill_win = 20211203,
	play_ui_wangshi_generate = 20211205,
	play_ui_wangshi_fill = 20211202,
	play_ui_wangshi_review = 20211206,
	play_ui_wangshi_fill_fail = 20211204,
	play_ui_wangshi_enter = 20211201
}
AudioEnum.VersionActivity2_1ChessGame = {
	play_ui_molu_jlbn_move = 20211301,
	play_ui_molu_monster_awake = 20211302,
	play_ui_activity_box_push = 20211303,
	play_ui_wangshi_bad = 20211304
}
AudioEnum.Activity163 = {
	play_ui_wangshi_argus_level_error = 20211504,
	play_ui_wangshi_argus_level_pop = 20211506,
	play_ui_wangshi_argus_level_over = 20211502,
	play_ui_wangshi_argus_level_ask = 20211505,
	play_ui_wangshi_argus_level_hybrid = 20211507,
	play_ui_wangshi_argus_level_open = 20211503,
	play_ui_wangshi_argus_level_slide = 20211501,
	play_ui_wangshi_argus_level_finish = 20211508
}

local bgm = {
	stop_ui_preheat_2_1_music_20211602 = 20211602,
	play_ui_preheat_2_1_music_20211601 = 20211601,
	Act2_1_LanShouPa = 3200166,
	Act2_1DungeonBgm = 3200162,
	Act2_1_Aergusi = 3200167
}
local UI = {
	play_ui_wangshi_carton_open_20211603 = 20211603
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
