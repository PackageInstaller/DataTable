-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_summon_pet_obtain_rule.lua

module("logicconfig.config.t_new_summon_pet_obtain_rule", package.seeall)

local title = {
	score = 4,
	ruleParams = 3,
	ruleId = 1,
	txtCondDesc = 5,
	ruleHandler = 2
}
local dataList = {
	{
		1,
		"Win",
		{
			win = "胜利",
			defeat = "0"
		},
		100,
		"击败敌阵"
	},
	{
		2,
		"SurvivalNum",
		{},
		80,
		"精灵存活数量相同"
	},
	{
		3,
		"SurvivalSameAttributeNum",
		{
			num = "2"
		},
		80,
		"同属性精灵存活数量≥2"
	},
	{
		4,
		"SameAttributeNum",
		{
			equal = "true",
			num = "2"
		},
		50,
		"同属性精灵上阵数量=2"
	},
	{
		5,
		"Win",
		{
			win = "胜利",
			defeat = "0"
		},
		80,
		"击败敌阵"
	},
	{
		6,
		"SurvivalNum",
		{},
		40,
		"精灵存活数量相同"
	},
	{
		7,
		"SurvivalSameAttributeNum",
		{
			num = "3"
		},
		40,
		"同属性精灵存活数量≥3"
	},
	{
		8,
		"SameAttributeNum",
		{
			equal = "true",
			num = "3"
		},
		40,
		"同属性精灵上阵数量=3"
	}
}
local t_new_summon_pet_obtain_rule = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_new_summon_pet_obtain_rule.dataList = dataList

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

return t_new_summon_pet_obtain_rule
