-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_qing_gu_clg_creeps_master.lua

module("logicconfig.config.t_divine_qing_gu_clg_creeps_master", package.seeall)

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
		"化器道",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"417010",
		"敌阵首次死亡时会令其他存活精灵全属性增加10%"
	},
	{
		1002,
		"束鬼道",
		5,
		"",
		"",
		0,
		0,
		283,
		0,
		"414020",
		"己阵攻击击杀目标时会无法行动1回合"
	},
	{
		1003,
		"缚神道",
		5,
		"",
		"",
		0,
		0,
		0,
		191,
		"415020",
		"本关不能上阵龙族精灵"
	},
	{
		1004,
		"无人道",
		5,
		"",
		"",
		174,
		0,
		0,
		0,
		"416020",
		"击败敌阵时，己阵只有一只精灵存活才可通关"
	},
	{
		1005,
		"堕心道",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"414024",
		"每个大回合结束时，己阵气势最高的精灵会被混乱（1回合）"
	},
	{
		1006,
		"修罗道",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"411020",
		"敌阵攻击击杀目标时会获得50气势并立即出手一次"
	}
}
local t_divine_qing_gu_clg_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6]
}

t_divine_qing_gu_clg_creeps_master.dataList = dataList

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

return t_divine_qing_gu_clg_creeps_master
