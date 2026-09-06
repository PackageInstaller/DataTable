-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_birthday_cake_activity.lua

module("logicconfig.config.t_birthday_cake_activity", package.seeall)

local title = {
	storePlan = 8,
	buyPlanId = 9,
	rewardNum = 6,
	prizePlanId = 11,
	carveUpTime = 5,
	makeOpenTime = 12,
	carveUpOpenTime = 14,
	makeEndTime = 13,
	transformNum = 4,
	defaultNum = 3,
	cakePlan = 10,
	carveUpEndTime = 15,
	contribute = 7,
	redPointId = 16,
	activityId = 1,
	randomTaskNum = 2
}
local dataList = {
	{
		224001,
		5,
		3,
		100,
		{
			10,
			5
		},
		1,
		500,
		1,
		1,
		1,
		1,
		"2022-11-25T05:00:00",
		"2022-12-02T05:00:00",
		"2022-12-02T05:00:00",
		"2022-12-09T05:00:00",
		388
	},
	{
		224002,
		5,
		3,
		100,
		{
			10,
			5
		},
		1,
		500,
		2,
		2,
		2,
		2,
		"2022-12-09T05:00:00",
		"2022-12-16T04:59:00",
		"2022-12-16T05:00:00",
		"2022-12-23T05:00:00",
		388
	}
}
local t_birthday_cake_activity = {
	[224001] = dataList[1],
	[224002] = dataList[2]
}

t_birthday_cake_activity.dataList = dataList

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

return t_birthday_cake_activity
