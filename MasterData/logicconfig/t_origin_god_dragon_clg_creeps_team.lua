-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_god_dragon_clg_creeps_team.lua

module("logicconfig.config.t_origin_god_dragon_clg_creeps_team", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	heavenAwakenSummonPetId = 12,
	skipTime = 3,
	retreatMsgType = 7,
	heavenAwakenMasterId = 11,
	missionDesc = 13,
	btlMode = 5,
	btlBg = 4,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 10
}
local dataList = {
	{
		2001,
		"星宙关卡-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"6",
		"7",
		""
	},
	{
		2002,
		"星宙关卡-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"6",
		"7",
		""
	},
	{
		2003,
		"星宙关卡-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵减伤和非伤减伤提高50%"
	},
	{
		2004,
		"星宙关卡-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"5",
		"6",
		"敌阵精灵减伤和非伤减伤提高50%"
	},
	{
		2005,
		"星宙关卡-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵攻击目标时附带自身攻击力*100%的毁灭伤害"
	},
	{
		2006,
		"星宙关卡-6",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"6",
		"7",
		"敌阵精灵攻击目标时附带自身攻击力*100%的毁灭伤害"
	},
	{
		1001,
		"超神关卡-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1002,
		"超神关卡-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1003,
		"超神关卡-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1004,
		"超神关卡-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"5",
		"7",
		""
	},
	{
		1005,
		"超神关卡-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1006,
		"超神关卡-6",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1007,
		"超神关卡-7",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1008,
		"超神关卡-8",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1009,
		"超神关卡-9",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	}
}
local t_origin_god_dragon_clg_creeps_team = {
	[2001] = dataList[1],
	[2002] = dataList[2],
	[2003] = dataList[3],
	[2004] = dataList[4],
	[2005] = dataList[5],
	[2006] = dataList[6],
	[1001] = dataList[7],
	[1002] = dataList[8],
	[1003] = dataList[9],
	[1004] = dataList[10],
	[1005] = dataList[11],
	[1006] = dataList[12],
	[1007] = dataList[13],
	[1008] = dataList[14],
	[1009] = dataList[15]
}

t_origin_god_dragon_clg_creeps_team.dataList = dataList

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

return t_origin_god_dragon_clg_creeps_team
