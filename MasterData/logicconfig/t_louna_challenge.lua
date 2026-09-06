-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_louna_challenge.lua

module("logicconfig.config.t_louna_challenge", package.seeall)

local title = {
	ruleId = 5,
	jumpTo2 = 7,
	tierPlanId = 2,
	prizePlanId = 3,
	raceId = 4,
	jumpTo1 = 6,
	activityId = 1
}
local dataList = {
	{
		183001,
		1,
		1,
		13004,
		"lounachallenge_rule",
		"func#618#13004",
		"mibao#Skin"
	}
}
local t_louna_challenge = {
	[183001] = dataList[1]
}

t_louna_challenge.dataList = dataList

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

return t_louna_challenge
