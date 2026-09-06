-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_ji_master.lua

module("logicconfig.config.t_summon_master_ji_master", package.seeall)

local title = {
	selfBuffProviderId = 10,
	name = 2,
	WinDesc = 4,
	skipTime = 5,
	retreatMsgType = 9,
	formCondition = 11,
	stageDesc = 13,
	btlMode = 7,
	btlBg = 6,
	missionDesc = 3,
	winId = 8,
	creepsMasterId = 1,
	heroSkillId = 12
}
local dataList = {
	{
		1001,
		"1-1",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵"
	},
	{
		1002,
		"1-2",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵"
	},
	{
		1003,
		"1-3",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵"
	},
	{
		1004,
		"2-1",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵"
	},
	{
		1005,
		"2-2",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵"
	},
	{
		1006,
		"2-3",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵"
	},
	{
		1007,
		"3-1",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵"
	},
	{
		1008,
		"3-2",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵"
	},
	{
		1009,
		"3-3",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵"
	},
	{
		2001,
		"光",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"414020",
		"击败敌阵全部精灵"
	},
	{
		2002,
		"暗",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"415020",
		"击败敌阵全部精灵"
	},
	{
		2003,
		"水",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"411012",
		"击败敌阵全部精灵"
	},
	{
		2004,
		"火",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"412012",
		"击败敌阵全部精灵"
	},
	{
		2005,
		"草",
		"",
		"击败敌阵全部精灵",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"413009",
		"击败敌阵全部精灵"
	}
}
local t_summon_master_ji_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[2001] = dataList[10],
	[2002] = dataList[11],
	[2003] = dataList[12],
	[2004] = dataList[13],
	[2005] = dataList[14]
}

t_summon_master_ji_master.dataList = dataList

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

return t_summon_master_ji_master
