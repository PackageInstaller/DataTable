-- chunkname: @modules/logic/versionactivity2_0/common/AudioEnum2_0.lua

module("modules.logic.versionactivity2_0.common.AudioEnum2_0", package.seeall)

local AudioEnum = AudioEnum

AudioEnum.VersionActivity2_0Enter = {
	play_ui_feichi_open = 20200002
}

local bgm = {
	play_ui_feichi_noise_yure_20200116 = 20200116,
	role_activity_joe = 3200157,
	Act2_0DungeonBgm = 3200152,
	role_activity_mercuria = 3200158,
	stop_ui_feichi_noise_yure_20200117 = 20200117
}
local UI = {
	play_ui_common_click_20200111 = 20200111,
	play_ui_feichi_dooreye_20200112 = 20200112,
	play_ui_feichi_yure_caption_20200114 = 20200114,
	play_ui_resonate_fm = 20200203,
	play_ui_feichi_zoom_20200113 = 20200113,
	stop_ui_feichi_spray_loop = 20200004,
	stop_ui_feichi_yure_caption_20200115 = 20200115,
	play_ui_feichi_spray_loop = 20200003,
	play_ui_resonate_unlock_01 = 20200202,
	play_ui_feichi_spray_finish = 20200005,
	play_ui_resonate_unlock_02 = 20200201
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
