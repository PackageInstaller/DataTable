-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summer_lottery_pool.lua

module("logicconfig.config.t_summer_lottery_pool", package.seeall)

local title = {
	poolPlanId = 1,
	dailyLimit = 6,
	lotteryCost = 4,
	progressPlanId = 11,
	koiPlanId = 8,
	koiPrizePlanId = 3,
	taskPlanId = 10,
	explainId = 15,
	recordNum = 9,
	weeklyTaskNum = 13,
	floorTimes = 5,
	onceLimit = 7,
	viewPlanId = 14,
	dailyTaskNum = 12,
	poolPrizePlanId = 2
}
local dataList = {
	{
		1,
		1,
		1,
		"10:167001:1",
		25,
		9999,
		5,
		1,
		100,
		1,
		1,
		6,
		5,
		1,
		1
	},
	{
		2,
		2,
		2,
		"10:167002:1",
		10,
		9999,
		5,
		2,
		100,
		2,
		2,
		6,
		5,
		2,
		3
	},
	{
		3,
		3,
		3,
		"10:167003:1",
		25,
		9999,
		5,
		3,
		100,
		3,
		3,
		6,
		5,
		3,
		3
	},
	{
		4,
		4,
		4,
		"10:167004:1",
		20,
		9999,
		5,
		4,
		100,
		4,
		4,
		6,
		5,
		4,
		4
	},
	{
		5,
		5,
		5,
		"10:167005:1",
		20,
		9999,
		5,
		4,
		100,
		5,
		5,
		6,
		5,
		5,
		5
	},
	{
		6,
		6,
		6,
		"10:167006:1",
		20,
		9999,
		10,
		4,
		100,
		6,
		6,
		6,
		5,
		6,
		6
	}
}
local t_summer_lottery_pool = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_summer_lottery_pool.dataList = dataList

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

return t_summer_lottery_pool
