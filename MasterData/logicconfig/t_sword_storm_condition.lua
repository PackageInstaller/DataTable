-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sword_storm_condition.lua

module("logicconfig.config.t_sword_storm_condition", package.seeall)

local title = {
	enemyRaceId = 3,
	conditionPlanId = 1,
	conditionId = 2,
	prize = 6,
	scoreRange = 5,
	circleLimit = 4
}
local dataList = {
	{
		1,
		1,
		97025,
		2,
		"5000000-10000000",
		"10:583002:100"
	},
	{
		1,
		2,
		97025,
		5,
		"50000000-100000000",
		"4:400004:10#4:30006:25"
	},
	{
		2,
		1,
		97026,
		2,
		"5000000-10000000",
		"10:583003:100"
	},
	{
		2,
		2,
		97026,
		5,
		"50000000-100000000",
		"4:400004:10#4:30006:25"
	},
	{
		3,
		1,
		97015,
		2,
		"5000000-10000000",
		"10:583004:100"
	},
	{
		3,
		2,
		97015,
		5,
		"50000000-100000000",
		"4:400004:10#4:30006:50"
	},
	{
		4,
		1,
		97027,
		2,
		"5000000-10000000",
		"10:583005:100"
	},
	{
		4,
		2,
		97027,
		5,
		"50000000-100000000",
		"4:400004:10#4:30006:25"
	},
	{
		5,
		1,
		93030,
		2,
		"5000000-10000000",
		"10:583006:100"
	},
	{
		5,
		2,
		93030,
		5,
		"50000000-100000000",
		"4:400004:10#4:30006:25"
	},
	{
		6,
		1,
		97028,
		2,
		"5000000-10000000",
		"10:583007:100"
	},
	{
		6,
		2,
		97028,
		5,
		"50000000-100000000",
		"4:400004:10#4:30006:50"
	}
}
local t_sword_storm_condition = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12]
	}
}

t_sword_storm_condition.dataList = dataList

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

return t_sword_storm_condition
