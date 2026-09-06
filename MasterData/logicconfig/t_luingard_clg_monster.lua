-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luingard_clg_monster.lua

module("logicconfig.config.t_luingard_clg_monster", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	ruleDesc = 11,
	skipTime = 3,
	retreatMsgType = 7,
	btlMode = 5,
	btlBg = 4,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 10
}
local dataList = {
	{
		1001,
		"时间敌阵-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"每个大回合结束时，敌阵全体精灵获得100点气势"
	},
	{
		1002,
		"空间敌阵-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"敌阵精灵攻击时，优先攻击与自身相同站位的精灵"
	},
	{
		1003,
		"时间敌阵-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"每个大回合结束时，敌阵全体精灵获得100点气势"
	},
	{
		1004,
		"空间敌阵-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"敌阵精灵攻击时，优先攻击与自身相同站位的精灵"
	},
	{
		1005,
		"时间敌阵-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"每个大回合结束时，敌阵全体精灵获得100点气势"
	},
	{
		1006,
		"空间敌阵-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"敌阵精灵攻击时，优先攻击与自身相同站位的精灵"
	},
	{
		1007,
		"时间敌阵-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"每个大回合结束时，敌阵全体精灵获得100点气势"
	},
	{
		1008,
		"空间敌阵-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"敌阵精灵攻击时，优先攻击与自身相同站位的精灵"
	},
	{
		1009,
		"时间敌阵-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"每个大回合结束时，敌阵全体精灵获得100点气势"
	},
	{
		1010,
		"空间敌阵-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"敌阵精灵攻击时，优先攻击与自身相同站位的精灵"
	},
	{
		1011,
		"时间敌阵-6",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"每个大回合结束时，敌阵全体精灵获得100点气势"
	},
	{
		1012,
		"空间敌阵-6",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"敌阵精灵攻击时，优先攻击与自身相同站位的精灵"
	},
	{
		1013,
		"时间敌阵-7",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"416020",
		"每个大回合结束时，敌阵全体精灵获得100点气势"
	},
	{
		1014,
		"空间敌阵-7",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"414020",
		"敌阵精灵攻击时，优先攻击与自身相同站位的精灵"
	},
	{
		1015,
		"时间敌阵-8",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"411012",
		"每个大回合结束时，敌阵全体精灵获得100点气势"
	},
	{
		1016,
		"空间敌阵-8",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"415020",
		"敌阵精灵攻击时，优先攻击与自身相同站位的精灵"
	}
}
local t_luingard_clg_monster = {
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
	[1016] = dataList[16]
}

t_luingard_clg_monster.dataList = dataList

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

return t_luingard_clg_monster
