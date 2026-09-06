-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_canton_opera_road_enemy.lua

module("logicconfig.config.t_canton_opera_road_enemy", package.seeall)

local title = {
	skipTime = 6,
	name = 2,
	WinDesc = 4,
	formCondition = 7,
	retreatMsgType = 11,
	btlMode = 9,
	btlBg = 8,
	missionDesc = 3,
	winId = 10,
	creepsMasterId = 1,
	showFaceId = 5
}
local dataList = {
	{
		1001,
		"神秘关卡",
		"",
		"击败敌阵全部精灵",
		10142,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1002,
		"神秘关卡",
		"",
		"击败敌阵全部精灵",
		10143,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1003,
		"神秘关卡",
		"",
		"击败敌阵全部精灵",
		10144,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1004,
		"神秘关卡",
		"",
		"击败敌阵全部精灵",
		10145,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1005,
		"神秘关卡",
		"",
		"击败敌阵全部精灵",
		10146,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1006,
		"神秘关卡",
		"",
		"击败敌阵全部精灵",
		10142,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1007,
		"神秘关卡",
		"",
		"击败敌阵全部精灵",
		10143,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1008,
		"神秘关卡",
		"",
		"击败敌阵全部精灵",
		10144,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1009,
		"神秘关卡",
		"",
		"击败敌阵全部精灵",
		10145,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1010,
		"神秘关卡",
		"",
		"击败敌阵全部精灵",
		10146,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1011,
		"神秘关卡",
		"",
		"击败敌阵全部精灵",
		10142,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1012,
		"神秘关卡",
		"",
		"击败敌阵全部精灵",
		10143,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1013,
		"神秘关卡",
		"",
		"击败敌阵全部精灵",
		10144,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1014,
		"神秘关卡",
		"",
		"击败敌阵全部精灵",
		10145,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		1015,
		"神秘关卡",
		"",
		"击败敌阵全部精灵",
		10146,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		2001,
		"焚-1",
		"",
		"1.书化蝶·天蛮王每个大回合开始时为己方全体精灵+20气势和10%暴击率\n2.击败敌阵全部精灵",
		10369,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		2002,
		"焚-2",
		"",
		"1.虞美人·潘多拉每个大回合开始时为己方全体精灵+20气势和10%暴击率\n2.击败敌阵全部精灵",
		10369,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		2003,
		"焚-3",
		"",
		"1.楚霸王·阿瑞斯每个大回合开始时为己方全体精灵+20气势和10%暴击率\n2.击败敌阵全部精灵",
		10369,
		15,
		0,
		"",
		"",
		0,
		0
	},
	{
		2004,
		"焚-4",
		"",
		"1.白蛇心·王者圣女每个大回合开始时为己方全体精灵+20气势和10%暴击率\n2.击败敌阵全部精灵",
		10369,
		15,
		0,
		"",
		"",
		0,
		0
	}
}
local t_canton_opera_road_enemy = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[1010] = dataList[10],
	[1011] = dataList[11],
	[1012] = dataList[12],
	[1013] = dataList[13],
	[1014] = dataList[14],
	[1015] = dataList[15],
	[2001] = dataList[16],
	[2002] = dataList[17],
	[2003] = dataList[18],
	[2004] = dataList[19]
}

t_canton_opera_road_enemy.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_canton_opera_road_enemy
