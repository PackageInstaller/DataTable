-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_party_prize.lua

module("logicconfig.config.t_party_prize", package.seeall)

local title = {
	accumulateDays = 4,
	accumulateEndTime = 8,
	accumulatePrize = 5,
	accumulateStartTime = 7,
	dailyPrizePlanId = 6,
	checkInPlanId = 2,
	activityId = 1,
	checkInEndTime = 3
}
local dataList = {
	{
		90001,
		1,
		"2021-11-26T05:00:00",
		3,
		"1:13005:-1:1#1:13006:-1:1",
		1,
		"2021-11-26T05:00:00",
		"2021-12-03T05:00:00"
	}
}
local t_party_prize = {
	[90001] = dataList[1]
}

t_party_prize.dataList = dataList

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

return t_party_prize
