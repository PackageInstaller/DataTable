-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_farnas_normal_clg_rule.lua

module("logicconfig.config.t_farnas_normal_clg_rule", package.seeall)

local title = {
	activityId = 1,
	name = 3,
	ruleId = 2
}
local dataList = {
	{
		333001,
		1,
		"精灵死亡"
	},
	{
		333001,
		2,
		"精灵复活"
	},
	{
		333001,
		3,
		"闪避"
	},
	{
		333002,
		1,
		"精灵死亡"
	},
	{
		333002,
		2,
		"精灵复活"
	},
	{
		333002,
		3,
		"闪避"
	}
}
local t_farnas_normal_clg_rule = {
	[333001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[333002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_farnas_normal_clg_rule.dataList = dataList

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

return t_farnas_normal_clg_rule
