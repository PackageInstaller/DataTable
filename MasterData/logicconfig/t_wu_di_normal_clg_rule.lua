-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wu_di_normal_clg_rule.lua

module("logicconfig.config.t_wu_di_normal_clg_rule", package.seeall)

local title = {
	activityId = 1,
	name = 3,
	ruleId = 2
}
local dataList = {
	{
		317001,
		1,
		"群攻技能击杀"
	},
	{
		317001,
		2,
		"非群攻技能击杀"
	},
	{
		317001,
		3,
		"无敌通灵"
	},
	{
		317002,
		1,
		"群攻技能击杀"
	},
	{
		317002,
		2,
		"非群攻技能击杀"
	},
	{
		317002,
		3,
		"无敌通灵"
	}
}
local t_wu_di_normal_clg_rule = {
	[317001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[317002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_wu_di_normal_clg_rule.dataList = dataList

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

return t_wu_di_normal_clg_rule
