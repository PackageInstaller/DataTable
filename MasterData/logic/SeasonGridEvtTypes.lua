-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonGridEvtTypes.lua

module("logic.extensions.season.model.SeasonGridEvtTypes", package.seeall)

local SeasonGridEvtTypes = {}

SeasonGridEvtTypes.EVT_EMPTY = 0
SeasonGridEvtTypes.EVT_CHALLENGE = 1
SeasonGridEvtTypes.EVT_MATERIAL = 2
SeasonGridEvtTypes.EVT_PLOT = 3
SeasonGridEvtTypes.EVT_MEDAL = 4
SeasonGridEvtTypes.EVT_CONVEY = 5
SeasonGridEvtTypes.EVT_MAP_LOCK = 6
SeasonGridEvtTypes.EVT_WOODEN_STAKE = 7
SeasonGridEvtTypes.EVT_GAME = 8
SeasonGridEvtTypes.EVT_RAINBOW = 9
SeasonGridEvtTypes.EVT_CAMP = 10
SeasonGridEvtTypes.EVT_BOSS_DOPPELGANGER = 11
SeasonGridEvtTypes.EVT_BOSS = 12
SeasonGridEvtTypes.EVT_HIRE_PET = 13
SeasonGridEvtTypes.EVT_FIND_KEY = 14
SeasonGridEvtTypes.EVT_DANCE_LION = 15
SeasonGridEvtTypes.Weights = {
	[SeasonGridEvtTypes.EVT_EMPTY] = 0,
	[SeasonGridEvtTypes.EVT_CHALLENGE] = 0,
	[SeasonGridEvtTypes.EVT_MATERIAL] = 0,
	[SeasonGridEvtTypes.EVT_CONVEY] = 20,
	[SeasonGridEvtTypes.EVT_PLOT] = 0,
	[SeasonGridEvtTypes.EVT_MEDAL] = 0,
	[SeasonGridEvtTypes.EVT_MAP_LOCK] = 0,
	[SeasonGridEvtTypes.EVT_WOODEN_STAKE] = 20,
	[SeasonGridEvtTypes.EVT_GAME] = 0,
	[SeasonGridEvtTypes.EVT_RAINBOW] = 20,
	[SeasonGridEvtTypes.EVT_CAMP] = 1000,
	[SeasonGridEvtTypes.EVT_BOSS_DOPPELGANGER] = 0,
	[SeasonGridEvtTypes.EVT_BOSS] = 0,
	[SeasonGridEvtTypes.EVT_HIRE_PET] = 0,
	[SeasonGridEvtTypes.EVT_FIND_KEY] = 0,
	[SeasonGridEvtTypes.EVT_DANCE_LION] = 0
}
SeasonGridEvtTypes.Names = {
	[SeasonGridEvtTypes.EVT_EMPTY] = lang("空白地块"),
	[SeasonGridEvtTypes.EVT_CHALLENGE] = lang("挑战地块"),
	[SeasonGridEvtTypes.EVT_MATERIAL] = lang("资源地块"),
	[SeasonGridEvtTypes.EVT_CONVEY] = lang("传送地块"),
	[SeasonGridEvtTypes.EVT_PLOT] = lang("剧情地块"),
	[SeasonGridEvtTypes.EVT_MEDAL] = lang("徽章地块"),
	[SeasonGridEvtTypes.EVT_MAP_LOCK] = lang("机关地块"),
	[SeasonGridEvtTypes.EVT_WOODEN_STAKE] = lang("遗迹试炼"),
	[SeasonGridEvtTypes.EVT_GAME] = lang("游戏地块"),
	[SeasonGridEvtTypes.EVT_RAINBOW] = lang("彩虹地块"),
	[SeasonGridEvtTypes.EVT_CAMP] = lang("营地地块"),
	[SeasonGridEvtTypes.EVT_BOSS_DOPPELGANGER] = lang("boss分身地块"),
	[SeasonGridEvtTypes.EVT_BOSS] = lang("boss地块"),
	[SeasonGridEvtTypes.EVT_HIRE_PET] = lang("精灵殿地块"),
	[SeasonGridEvtTypes.EVT_FIND_KEY] = lang("桃符方块"),
	[SeasonGridEvtTypes.EVT_DANCE_LION] = lang("狮子头方块")
}
SeasonGridEvtTypes.IsNeedShowSearch = {
	[SeasonGridEvtTypes.EVT_EMPTY] = false,
	[SeasonGridEvtTypes.EVT_CHALLENGE] = true,
	[SeasonGridEvtTypes.EVT_MATERIAL] = true,
	[SeasonGridEvtTypes.EVT_CONVEY] = false,
	[SeasonGridEvtTypes.EVT_PLOT] = true,
	[SeasonGridEvtTypes.EVT_MEDAL] = true,
	[SeasonGridEvtTypes.EVT_MAP_LOCK] = true,
	[SeasonGridEvtTypes.EVT_WOODEN_STAKE] = true,
	[SeasonGridEvtTypes.EVT_GAME] = true,
	[SeasonGridEvtTypes.EVT_RAINBOW] = false,
	[SeasonGridEvtTypes.EVT_CAMP] = false,
	[SeasonGridEvtTypes.EVT_BOSS_DOPPELGANGER] = false,
	[SeasonGridEvtTypes.EVT_BOSS] = false,
	[SeasonGridEvtTypes.EVT_HIRE_PET] = true,
	[SeasonGridEvtTypes.EVT_FIND_KEY] = false,
	[SeasonGridEvtTypes.EVT_DANCE_LION] = false
}
SeasonGridEvtTypes.IsOccupiedNeedShow = {
	[SeasonGridEvtTypes.EVT_EMPTY] = false,
	[SeasonGridEvtTypes.EVT_CHALLENGE] = false,
	[SeasonGridEvtTypes.EVT_MATERIAL] = false,
	[SeasonGridEvtTypes.EVT_CONVEY] = true,
	[SeasonGridEvtTypes.EVT_PLOT] = false,
	[SeasonGridEvtTypes.EVT_MEDAL] = false,
	[SeasonGridEvtTypes.EVT_MAP_LOCK] = true,
	[SeasonGridEvtTypes.EVT_WOODEN_STAKE] = true,
	[SeasonGridEvtTypes.EVT_GAME] = false,
	[SeasonGridEvtTypes.EVT_RAINBOW] = false,
	[SeasonGridEvtTypes.EVT_CAMP] = true,
	[SeasonGridEvtTypes.EVT_BOSS_DOPPELGANGER] = false,
	[SeasonGridEvtTypes.EVT_BOSS] = false,
	[SeasonGridEvtTypes.EVT_HIRE_PET] = true,
	[SeasonGridEvtTypes.EVT_FIND_KEY] = true,
	[SeasonGridEvtTypes.EVT_DANCE_LION] = true
}

return SeasonGridEvtTypes
