-- chunkname: @modules/logic/versionactivity1_8/common/AudioEnum1_8.lua

module("modules.logic.versionactivity1_8.common.AudioEnum1_8", package.seeall)

local AudioEnum = AudioEnum

AudioEnum.Warmup1_8 = {
	play_wrong = 20180003,
	play_caption = 20180002,
	play_noise = 20180001
}
AudioEnum.VersionActivity1_8Enter = {
	play_ui_jinye_open = 20180107,
	play_ui_jinye_unfold = 20180108
}

local bgm = {
	Act1_8DungeonBgm = 3200127
}
local UI = {
	play_activitystorysfx_shiji_receive_2 = 20180202,
	Act157FactoryNodeShow = 20180101,
	play_activitystorysfx_shiji_receive = 20180201,
	play_activitystorysfx_shiji_type = 20180203,
	Act157OpenBlueprintView = 20180105,
	play_activitystorysfx_shiji_unlock = 20180204,
	Act157UnlockFactoryComponent = 20180106,
	Act157GetBubbleReward = 20180102,
	Act157FactoryNodeLineShow = 20180103
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
