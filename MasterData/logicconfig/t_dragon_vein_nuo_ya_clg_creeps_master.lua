-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_vein_nuo_ya_clg_creeps_master.lua

module("logicconfig.config.t_dragon_vein_nuo_ya_clg_creeps_master", package.seeall)

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
		"第一层-1",
		3,
		"",
		"",
		74,
		0,
		0,
		0,
		"",
		"4回合内击败敌阵"
	},
	{
		1002,
		"第一层-2",
		3,
		"",
		"",
		74,
		0,
		0,
		0,
		"",
		"4回合内击败敌阵"
	},
	{
		1003,
		"第二层-1",
		3,
		"",
		"",
		75,
		0,
		0,
		0,
		"",
		"3回合内击败敌阵"
	},
	{
		1004,
		"第二层-2",
		3,
		"",
		"",
		75,
		0,
		0,
		0,
		"",
		"3回合内击败敌阵"
	},
	{
		1005,
		"第二层-3",
		3,
		"",
		"",
		75,
		0,
		0,
		0,
		"",
		"3回合内击败敌阵"
	},
	{
		1006,
		"第二层-4",
		3,
		"",
		"",
		75,
		0,
		0,
		0,
		"",
		"3回合内击败敌阵"
	},
	{
		1007,
		"第三层-1",
		3,
		"",
		"",
		163,
		0,
		0,
		0,
		"417020",
		"2回合内击败敌阵"
	},
	{
		1008,
		"第三层-2",
		3,
		"",
		"",
		163,
		0,
		0,
		0,
		"411020",
		"2回合内击败敌阵"
	},
	{
		1009,
		"第三层-3",
		3,
		"",
		"",
		163,
		0,
		0,
		0,
		"413015",
		"2回合内击败敌阵"
	},
	{
		1010,
		"第三层-4",
		3,
		"",
		"",
		163,
		0,
		0,
		0,
		"417016",
		"2回合内击败敌阵"
	},
	{
		1011,
		"第三层-5",
		3,
		"",
		"",
		163,
		0,
		0,
		0,
		"414027",
		"2回合内击败敌阵"
	},
	{
		1012,
		"第三层-6",
		3,
		"",
		"",
		163,
		0,
		0,
		0,
		"415027",
		"2回合内击败敌阵"
	},
	{
		2001,
		"第一层-boss",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"受到非克制属性伤害降低30%"
	},
	{
		2002,
		"第二层-boss",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"受到非克制属性伤害降低50%"
	},
	{
		2003,
		"第三层-boss",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"受到非克制属性伤害降低70%"
	}
}
local t_dragon_vein_nuo_ya_clg_creeps_master = {
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
	[2001] = dataList[13],
	[2002] = dataList[14],
	[2003] = dataList[15]
}

t_dragon_vein_nuo_ya_clg_creeps_master.dataList = dataList

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

return t_dragon_vein_nuo_ya_clg_creeps_master
