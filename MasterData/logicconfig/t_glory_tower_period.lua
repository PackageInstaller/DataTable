-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_glory_tower_period.lua

module("logicconfig.config.t_glory_tower_period", package.seeall)

local title = {
	endTime = 3,
	periodId = 1,
	startTime = 2
}
local dataList = {
	{
		1,
		"2023-03-03T05:00:00",
		"2023-04-28T05:00:00"
	},
	{
		2,
		"2023-04-28T05:00:00",
		"2023-06-02T05:00:00"
	},
	{
		3,
		"2023-06-02T05:00:00",
		"2023-06-30T05:00:00"
	},
	{
		4,
		"2023-06-30T05:00:00",
		"2023-07-28T05:00:00"
	},
	{
		5,
		"2023-07-28T05:00:00",
		"2023-08-25T05:00:00"
	},
	{
		6,
		"2023-08-25T05:00:00",
		"2023-09-29T05:00:00"
	},
	{
		7,
		"2023-09-29T05:00:00",
		"2023-10-27T05:00:00"
	},
	{
		8,
		"2023-10-27T05:00:00",
		"2023-11-24T05:00:00"
	},
	{
		9,
		"2023-11-24T05:00:00",
		"2023-12-22T05:00:00"
	}
}
local t_glory_tower_period = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_glory_tower_period.dataList = dataList

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

return t_glory_tower_period
