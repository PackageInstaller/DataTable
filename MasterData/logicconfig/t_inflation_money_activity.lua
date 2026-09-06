-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_inflation_money_activity.lua

module("logicconfig.config.t_inflation_money_activity", package.seeall)

local title = {
	inflationMoneyMaterialKey = 3,
	ruleKey = 4,
	activityId = 1,
	oncePrize = 2
}
local dataList = {
	{
		452001,
		"10:452001:20",
		"10:452001",
		"godesscloset_rule"
	}
}
local t_inflation_money_activity = {
	[452001] = dataList[1]
}

t_inflation_money_activity.dataList = dataList

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

return t_inflation_money_activity
