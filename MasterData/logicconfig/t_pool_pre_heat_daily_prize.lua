-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pool_pre_heat_daily_prize.lua

module("logicconfig.config.t_pool_pre_heat_daily_prize", package.seeall)

local title = {
	dailyPlanId = 1,
	massPrize = 4,
	instantPrize = 3,
	day = 2
}
local dataList = {
	{
		1,
		1,
		"104:2:50#4:602:1#8:1:50000",
		"4:36:2"
	},
	{
		1,
		2,
		"104:2:50#4:602:1#8:1:50000",
		"4:36:3"
	},
	{
		1,
		3,
		"104:2:50#4:602:1#8:1:50000",
		"4:36:5"
	},
	{
		2,
		1,
		"104:2:50#4:602:1#8:1:50000",
		"4:36:2"
	},
	{
		2,
		2,
		"104:2:50#4:602:1#8:1:50000",
		"4:36:3"
	},
	{
		2,
		3,
		"104:2:50#4:602:1#8:1:50000",
		"4:36:5"
	},
	{
		3,
		1,
		"104:2:50#4:602:1#8:1:50000",
		"4:36:3"
	},
	{
		3,
		2,
		"104:2:50#4:602:1#8:1:50000",
		"4:36:3"
	},
	{
		3,
		3,
		"104:2:50#4:602:1#8:1:50000",
		"4:36:3"
	},
	{
		4,
		1,
		"104:2:50#4:602:1#8:1:50000",
		"4:36:1"
	},
	{
		4,
		2,
		"104:2:50#4:602:1#8:1:50000",
		"4:36:1"
	},
	{
		4,
		3,
		"104:2:50#4:602:1#8:1:50000",
		"4:36:1"
	}
}
local t_pool_pre_heat_daily_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_pool_pre_heat_daily_prize.dataList = dataList

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

return t_pool_pre_heat_daily_prize
