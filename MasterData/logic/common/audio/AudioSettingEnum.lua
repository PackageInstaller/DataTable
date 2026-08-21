-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/audio/AudioSettingEnum.lua

module("logic.common.audio.AudioSettingEnum", package.seeall)

local AudioSettingEnum = {}

AudioSettingEnum.GroupKeyEnum = {
	ENV = "environment",
	LEVEL_3 = "effect_level_3",
	BG = "backgound",
	LEVEL_4 = "effect_level_4",
	LEVEL_1 = "effect_level_1",
	LEVEL_2 = "effect_level_2"
}
AudioSettingEnum.VolumeKeyEnum = {
	ENV = "EnvVolume",
	LEVEL_3 = "Effect3Volume",
	BG = "BgVolume",
	LEVEL_4 = "Effect4Volume",
	LEVEL_1 = "Effect1Volume",
	LEVEL_2 = "Effect2Volume"
}

return AudioSettingEnum
