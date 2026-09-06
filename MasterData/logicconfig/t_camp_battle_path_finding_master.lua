-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_path_finding_master.lua

module("logicconfig.config.t_camp_battle_path_finding_master", package.seeall)

local title = {
	score = 3,
	name = 2,
	WinDesc = 6,
	skipTime = 8,
	retreatMsgType = 12,
	btlMode = 10,
	missionCondition = 4,
	btlBg = 9,
	missionDesc = 5,
	winId = 11,
	creepsMasterId = 1,
	showFaceId = 7
}
local dataList = {
	{
		1001,
		"入侵者阵容",
		20,
		"击败敌阵全部精灵",
		"",
		"击败敌阵全部精灵",
		10075,
		3,
		"",
		"",
		0,
		0
	},
	{
		1002,
		"入侵者阵容",
		0,
		"击败敌阵全部精灵",
		"",
		"击败敌阵全部精灵",
		10155,
		3,
		"",
		"",
		0,
		0
	},
	{
		1003,
		"入侵者阵容",
		0,
		"击败敌阵全部精灵",
		"",
		"击败敌阵全部精灵",
		10019,
		3,
		"",
		"",
		0,
		0
	},
	{
		1004,
		"入侵者阵容",
		0,
		"击败敌阵全部精灵",
		"",
		"击败敌阵全部精灵",
		10349,
		3,
		"",
		"",
		0,
		0
	},
	{
		1005,
		"入侵者阵容",
		0,
		"击败敌阵全部精灵",
		"",
		"击败敌阵全部精灵",
		10072,
		3,
		"",
		"",
		0,
		0
	},
	{
		2001,
		"入侵者阵容",
		0,
		"击败敌阵全部精灵",
		"",
		"击败敌阵全部精灵",
		10033,
		3,
		"",
		"",
		0,
		0
	},
	{
		2002,
		"入侵者阵容",
		0,
		"击败敌阵全部精灵",
		"",
		"击败敌阵全部精灵",
		10018,
		3,
		"",
		"",
		0,
		0
	},
	{
		2003,
		"入侵者阵容",
		0,
		"击败敌阵全部精灵",
		"",
		"击败敌阵全部精灵",
		10016,
		3,
		"",
		"",
		0,
		0
	},
	{
		2004,
		"入侵者阵容",
		0,
		"击败敌阵全部精灵",
		"",
		"击败敌阵全部精灵",
		10037,
		3,
		"",
		"",
		0,
		0
	},
	{
		2005,
		"入侵者阵容",
		0,
		"击败敌阵全部精灵",
		"",
		"击败敌阵全部精灵",
		10037,
		3,
		"",
		"",
		0,
		0
	},
	{
		3001,
		"入侵者阵容",
		0,
		"击败敌阵全部精灵",
		"",
		"击败敌阵全部精灵",
		10032,
		3,
		"",
		"",
		0,
		0
	},
	{
		3002,
		"入侵者阵容",
		0,
		"击败敌阵全部精灵",
		"",
		"击败敌阵全部精灵",
		10360,
		3,
		"",
		"",
		0,
		0
	},
	{
		3003,
		"入侵者阵容",
		0,
		"击败敌阵全部精灵",
		"",
		"击败敌阵全部精灵",
		10016,
		3,
		"",
		"",
		0,
		0
	},
	{
		3004,
		"入侵者阵容",
		0,
		"击败敌阵全部精灵",
		"",
		"击败敌阵全部精灵",
		10349,
		3,
		"",
		"",
		0,
		0
	},
	{
		3005,
		"入侵者阵容",
		0,
		"击败敌阵全部精灵",
		"",
		"击败敌阵全部精灵",
		10072,
		3,
		"",
		"",
		0,
		0
	}
}
local t_camp_battle_path_finding_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[2001] = dataList[6],
	[2002] = dataList[7],
	[2003] = dataList[8],
	[2004] = dataList[9],
	[2005] = dataList[10],
	[3001] = dataList[11],
	[3002] = dataList[12],
	[3003] = dataList[13],
	[3004] = dataList[14],
	[3005] = dataList[15]
}

t_camp_battle_path_finding_master.dataList = dataList

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

return t_camp_battle_path_finding_master
