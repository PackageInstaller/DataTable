-- chunkname: @modules/logic/necrologiststory/define/NecrologistStoryEnum.lua

module("modules.logic.necrologiststory.define.NecrologistStoryEnum", package.seeall)

local NecrologistStoryEnum = _M

NecrologistStoryEnum.RoleStoryId = {
	V3A4 = 29,
	V3A2 = 27,
	V3A8 = 32,
	V3A5 = 30,
	V3A9 = 33,
	V3A3 = 28,
	V3A1 = 26,
	V3A7 = 31
}
NecrologistStoryEnum.RoleStoryId2MOCls = {
	[NecrologistStoryEnum.RoleStoryId.V3A1] = "NecrologistV3A1MO",
	[NecrologistStoryEnum.RoleStoryId.V3A2] = "NecrologistV3A2MO",
	[NecrologistStoryEnum.RoleStoryId.V3A3] = "NecrologistV3A3MO",
	[NecrologistStoryEnum.RoleStoryId.V3A4] = "NecrologistV3A4MO",
	[NecrologistStoryEnum.RoleStoryId.V3A5] = "NecrologistV3A5MO",
	[NecrologistStoryEnum.RoleStoryId.V3A7] = "NecrologistV3A7MO",
	[NecrologistStoryEnum.RoleStoryId.V3A9] = "NecrologistV3A9MO"
}
NecrologistStoryEnum.StoryId2GameView = {
	[NecrologistStoryEnum.RoleStoryId.V3A1] = ViewName.V3A1_RoleStoryGameView,
	[NecrologistStoryEnum.RoleStoryId.V3A2] = ViewName.V3A2_RoleStoryGameView,
	[NecrologistStoryEnum.RoleStoryId.V3A3] = ViewName.V3A3_RoleStoryGameView,
	[NecrologistStoryEnum.RoleStoryId.V3A4] = ViewName.V3A4_RoleStoryLevelView,
	[NecrologistStoryEnum.RoleStoryId.V3A5] = ViewName.V3A5_RoleStoryGameView,
	[NecrologistStoryEnum.RoleStoryId.V3A7] = ViewName.V3A7_RoleStoryGameView,
	[NecrologistStoryEnum.RoleStoryId.V3A8] = ViewName.V3A8_RoleStoryGameView,
	[NecrologistStoryEnum.RoleStoryId.V3A9] = ViewName.V3A9_RoleStoryGameView
}
NecrologistStoryEnum.TaskParam = {
	V3A3End2 = 2802,
	V3A9ItemUnlockCount = 3301,
	V3A3End1 = 2801,
	V3A2ItemUnlockCount = 2701
}
NecrologistStoryEnum.Pivot = {
	Left = Vector2(0, 1),
	Right = Vector2(1, 1),
	Down = Vector2(1, 0)
}
NecrologistStoryEnum.DefaultInterval = 50
NecrologistStoryEnum.BottomMargin = 50
NecrologistStoryEnum.StoryState = {
	Finish = 4,
	Reading = 2,
	Lock = 1,
	Normal = 3
}
NecrologistStoryEnum.StoryControlType = {
	StoryPic = 1,
	DragPic = 7,
	Audio = 3,
	Effect = 4,
	Magic = 5,
	ChangeVolume = 11,
	ClickPic = 9,
	Bgm = 2,
	ShowPic = 12,
	StopAudio = 8,
	SlidePic = 10,
	ErasePic = 6
}
NecrologistStoryEnum.DialogTextAnimType = {
	Word = 1,
	Typewriter = 0
}
NecrologistStoryEnum.GameState = {
	Win = 3,
	Fail = 2,
	Normal = 1
}
NecrologistStoryEnum.BaseType = {
	InteractiveBase = 3,
	SmallBase = 2,
	BigBase = 1
}
NecrologistStoryEnum.WeatherType = {
	Light = 7,
	CloudyNotEffect = 10,
	Cloudy = 3,
	Rainy = 5,
	Sunny = 1,
	Fire = 8,
	Snowy = 4,
	Flow = 6,
	Fog = 2,
	Night = 9
}
NecrologistStoryEnum.WeatherType2ResIndex = {
	[NecrologistStoryEnum.WeatherType.Sunny] = 1,
	[NecrologistStoryEnum.WeatherType.Fog] = 2,
	[NecrologistStoryEnum.WeatherType.Cloudy] = 3,
	[NecrologistStoryEnum.WeatherType.Snowy] = 4,
	[NecrologistStoryEnum.WeatherType.Rainy] = 5,
	[NecrologistStoryEnum.WeatherType.Flow] = 6,
	[NecrologistStoryEnum.WeatherType.Night] = 9,
	[NecrologistStoryEnum.WeatherType.CloudyNotEffect] = 3
}
NecrologistStoryEnum.WeatherType2Name = {
	[NecrologistStoryEnum.WeatherType.Sunny] = "sun",
	[NecrologistStoryEnum.WeatherType.Fog] = "fog",
	[NecrologistStoryEnum.WeatherType.Cloudy] = "cloudy",
	[NecrologistStoryEnum.WeatherType.Rainy] = "rain",
	[NecrologistStoryEnum.WeatherType.Snowy] = "snow",
	[NecrologistStoryEnum.WeatherType.Flow] = "flow",
	[NecrologistStoryEnum.WeatherType.Light] = "light",
	[NecrologistStoryEnum.WeatherType.Fire] = "fire"
}
NecrologistStoryEnum.NeedDelayType = {
	options = 4,
	aside = 2,
	location = 3,
	dialog = 1
}
NecrologistStoryEnum.NeedDelayControlType = {
	[NecrologistStoryEnum.StoryControlType.Magic] = 1,
	[NecrologistStoryEnum.StoryControlType.ErasePic] = 2,
	[NecrologistStoryEnum.StoryControlType.DragPic] = 3
}
NecrologistStoryEnum.DirType = {
	Top = 3,
	Left = 1,
	Right = 2,
	Bottom = 4
}
NecrologistStoryEnum.MagicEffectType = {
	Distort = 1,
	SweepLight = 2
}
NecrologistStoryEnum.V3A2BaseState = {
	Finish = 3,
	Hide = 4,
	Lock = 1,
	Normal = 2
}
NecrologistStoryEnum.V3A3Story = {
	Last = 305107,
	Second = 305102,
	Memory = 305106
}
NecrologistStoryEnum.V3A5NodeStatus = {
	Front = 1,
	Back = 2,
	None = 0
}
NecrologistStoryEnum.V3A7SpLevelId = {
	Sp2 = 6,
	Sp1 = 3
}
NecrologistStoryEnum.PrefsKey = {
	V3A9ItemHasPlayUnlockTag = "NecrologistV3A9ItemHasPlayUnlockTag",
	V3A9ItemOldTag = "NecrologistV3A9ItemOldTag"
}

return NecrologistStoryEnum
