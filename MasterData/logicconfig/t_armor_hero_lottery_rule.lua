-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_armor_hero_lottery_rule.lua

module("logicconfig.config.t_armor_hero_lottery_rule", package.seeall)

local title = {
	score = 3,
	name = 4,
	ruleId = 2,
	activityId = 1
}
local dataList = {
	{
		553001,
		1,
		200,
		"全家福"
	},
	{
		553001,
		2,
		50,
		"三连"
	},
	{
		553001,
		3,
		20,
		"对对碰"
	},
	{
		553002,
		1,
		200,
		"全家福"
	},
	{
		553002,
		2,
		50,
		"三连"
	},
	{
		553002,
		3,
		20,
		"对对碰"
	}
}
local t_armor_hero_lottery_rule = {
	[553001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[553002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_armor_hero_lottery_rule.dataList = dataList

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

return t_armor_hero_lottery_rule
