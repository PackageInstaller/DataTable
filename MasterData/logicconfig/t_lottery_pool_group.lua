-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lottery_pool_group.lua

module("logicconfig.config.t_lottery_pool_group", package.seeall)

local title = {
	poolIds = 2,
	openTime = 3,
	unlockCost = 6,
	endTime = 4,
	groupId = 1,
	recommendPoolId = 5
}
local dataList = {
	{
		1,
		{
			23,
			24,
			25,
			26,
			27
		},
		"2021-08-19T05:00:00",
		"2021-09-02T04:59:59",
		23,
		"105:185:300"
	},
	{
		2,
		{
			23,
			24,
			25,
			26,
			27
		},
		"2021-09-02T05:00:00",
		"2021-09-16T04:59:59",
		24,
		"105:185:300"
	},
	{
		3,
		{
			23,
			24,
			25,
			26,
			27
		},
		"2021-09-16T05:00:00",
		"2021-09-30T04:59:59",
		25,
		"105:185:300"
	},
	{
		4,
		{
			23,
			24,
			25,
			26,
			27
		},
		"2021-09-30T05:00:00",
		"2021-10-13T04:59:59",
		26,
		"105:185:300"
	},
	{
		5,
		{
			23,
			24,
			25,
			26,
			27
		},
		"2021-10-13T05:00:00",
		"2021-10-27T04:59:59",
		27,
		"105:185:300"
	},
	{
		6,
		{
			23,
			24,
			25,
			26,
			27
		},
		"2021-10-27T05:00:00",
		"2021-11-10T04:59:59",
		23,
		"105:185:300"
	},
	{
		7,
		{
			23,
			24,
			25,
			26,
			27
		},
		"2021-11-10T05:00:00",
		"2021-11-24T04:59:59",
		24,
		"105:185:300"
	},
	{
		8,
		{
			23,
			24,
			25,
			26,
			27
		},
		"2021-11-24T05:00:00",
		"2021-12-08T04:59:59",
		25,
		"105:185:300"
	},
	{
		9,
		{
			23,
			24,
			25,
			26,
			27
		},
		"2021-12-08T05:00:00",
		"2021-12-22T04:59:59",
		26,
		"105:185:300"
	},
	{
		10,
		{
			23,
			24,
			25,
			26,
			27
		},
		"2021-12-22T05:00:00",
		"2021-12-31T04:59:59",
		27,
		"105:185:300"
	}
}
local t_lottery_pool_group = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10]
}

t_lottery_pool_group.dataList = dataList

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

return t_lottery_pool_group
