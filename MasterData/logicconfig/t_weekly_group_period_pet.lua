-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_weekly_group_period_pet.lua

module("logicconfig.config.t_weekly_group_period_pet", package.seeall)

local title = {
	sortId = 2,
	teamItem = 4,
	rankItem = 5,
	endTime = 7,
	raceId = 3,
	activityId = 1,
	startTime = 6
}
local dataList = {
	{
		287001,
		1,
		11011,
		"8:1:100",
		"8:1:100",
		"2023-06-30T05:00:00",
		"2023-07-14T05:00:00"
	},
	{
		287001,
		2,
		11014,
		"8:1:102",
		"8:1:102",
		"2021-07-15T05:00:00",
		"2023-08-25T05:00:00"
	}
}
local t_weekly_group_period_pet = {
	[287001] = {
		dataList[1],
		dataList[2]
	}
}

t_weekly_group_period_pet.dataList = dataList

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

return t_weekly_group_period_pet
