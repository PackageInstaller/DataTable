-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_daily_recharge_prize.lua

module("logicconfig.config.t_activity_daily_recharge_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	money = 3,
	prizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		"8:1:100000#104:2:30#10:45001:100"
	},
	{
		1,
		2,
		6,
		"8:1:200000#104:2:200#10:45001:400"
	},
	{
		1,
		3,
		18,
		"8:1:300000#104:2:500#10:45001:1000"
	},
	{
		2,
		1,
		1,
		"104:2:30#4:503:10#10:45001:100"
	},
	{
		2,
		2,
		6,
		"104:2:200#4:503:50#10:45001:400"
	},
	{
		2,
		3,
		18,
		"104:2:500#4:36:2#10:45001:1000"
	}
}
local t_activity_daily_recharge_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_activity_daily_recharge_prize.dataList = dataList

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

return t_activity_daily_recharge_prize
