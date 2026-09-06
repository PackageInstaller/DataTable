-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_free_scuffle_lottery_pool.lua

module("logicconfig.config.t_free_scuffle_lottery_pool", package.seeall)

local title = {
	wight = 4,
	quality = 5,
	pos = 6,
	lotteryPlanId = 3,
	activityId = 1,
	poolId = 2
}
local dataList = {
	{
		489001,
		1,
		1,
		100,
		1,
		{
			-289.69,
			-73.9
		}
	},
	{
		489001,
		2,
		2,
		100,
		2,
		{
			35.6,
			-118
		}
	},
	{
		489001,
		3,
		3,
		100,
		3,
		{
			345.25,
			-86.5
		}
	},
	{
		489002,
		1,
		4,
		100,
		1,
		{
			-289.69,
			-73.9
		}
	},
	{
		489002,
		2,
		5,
		100,
		2,
		{
			35.6,
			-118
		}
	},
	{
		489002,
		3,
		6,
		100,
		3,
		{
			345.25,
			-86.5
		}
	},
	{
		489003,
		1,
		7,
		100,
		1,
		{
			-289.69,
			-73.9
		}
	},
	{
		489003,
		2,
		8,
		100,
		2,
		{
			35.6,
			-118
		}
	},
	{
		489003,
		3,
		9,
		100,
		3,
		{
			345.25,
			-86.5
		}
	}
}
local t_free_scuffle_lottery_pool = {
	[489001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[489002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[489003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_free_scuffle_lottery_pool.dataList = dataList

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

return t_free_scuffle_lottery_pool
