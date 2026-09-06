-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_shen_convene.lua

module("logicconfig.config.t_ling_shen_convene", package.seeall)

local title = {
	gameActId = 5,
	redPointId = 2,
	showCostCoin = 4,
	activityId = 1,
	ruleKey = 3
}
local dataList = {
	{
		376001,
		582,
		"ling_shen_rule_key",
		"10:375001",
		375001
	}
}
local t_ling_shen_convene = {
	[376001] = dataList[1]
}

t_ling_shen_convene.dataList = dataList

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

return t_ling_shen_convene
