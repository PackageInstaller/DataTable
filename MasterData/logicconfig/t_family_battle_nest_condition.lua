-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_battle_nest_condition.lua

module("logicconfig.config.t_family_battle_nest_condition", package.seeall)

local title = {
	prize_client = 4,
	energy = 3,
	desc = 5,
	nestConditionPlanId = 1,
	nestConditionId = 2
}
local dataList = {
	{
		1,
		1,
		50,
		"4:10000046:50",
		"阵亡精灵不多余2只"
	},
	{
		1,
		2,
		50,
		"4:10000046:50",
		"暴击6次"
	},
	{
		1,
		3,
		50,
		"4:10000046:50",
		"3回合内结束战斗"
	},
	{
		2,
		1,
		50,
		"4:10000046:50",
		"阵亡精灵不多余2只"
	},
	{
		2,
		2,
		50,
		"4:10000046:50",
		"通灵次数不少于1次"
	},
	{
		2,
		3,
		50,
		"4:10000046:50",
		"3回合内结束战斗"
	},
	{
		3,
		1,
		50,
		"4:10000046:50",
		"阵亡精灵不多余2只"
	},
	{
		3,
		2,
		50,
		"4:10000046:50",
		"群攻次数不少于8次"
	},
	{
		3,
		3,
		50,
		"4:10000046:50",
		"3回合内结束战斗"
	},
	{
		4,
		1,
		50,
		"4:10000046:50",
		"阵亡精灵不多余2只"
	},
	{
		4,
		2,
		50,
		"4:10000046:50",
		"进攻时克制次数10次"
	},
	{
		4,
		3,
		50,
		"4:10000046:50",
		"3回合内结束战斗"
	}
}
local t_family_battle_nest_condition = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_family_battle_nest_condition.dataList = dataList

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

return t_family_battle_nest_condition
