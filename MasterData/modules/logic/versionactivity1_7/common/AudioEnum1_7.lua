-- chunkname: @modules/logic/versionactivity1_7/common/AudioEnum1_7.lua

module("modules.logic.versionactivity1_7.common.AudioEnum1_7", package.seeall)

local AudioEnum = AudioEnum

AudioEnum.RoleActivity = {
	fight_switch = 20161044,
	star_show = 20170001,
	level_switch = 20161041,
	level_view_open = 20161047
}
AudioEnum.VersionActivity1_7Store = {
	play_ui_jinye_chess_talk = 20170010,
	play_ui_jinye_click_stage = 20170011,
	stop_ui_jinye_chess_talk = 20170012,
	play_ui_jinye_chess_enter = 20170009
}
AudioEnum.VersionActivity1_7Enter = {
	play_ui_jinye_open = 20170042,
	play_ui_jinye_unfold = 20170043
}

local bgm = {
	Act1_7DungeonBgm = 3200118
}
local UI = {
	season123_stage_star = 20170037,
	season123_map_scale = 20170025,
	play_ui_mln_no_effect = 20170048,
	season123_entryview_open = 20170020,
	season123_stage_click = 20170022,
	season123_stage_switch = 20170040,
	season123_overview_open = 20170021,
	season123_stage_unlock = 20170023,
	play_ui_mln_page_turn = 20170008
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
