-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_idiom_chain_activity.lua

module("logicconfig.config.t_idiom_chain_activity", package.seeall)

local title = {
	dailyTimes = 2,
	ruleKeyMain = 3,
	activityId = 1
}
local dataList = {
	{
		543001,
		3,
		"chengyugame_rule"
	},
	{
		543002,
		3,
		"chengyugame_rule"
	}
}
local t_idiom_chain_activity = {
	[543001] = dataList[1],
	[543002] = dataList[2]
}

t_idiom_chain_activity.dataList = dataList

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

return t_idiom_chain_activity
