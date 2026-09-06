-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rebate_mall_prize.lua

module("logicconfig.config.t_rebate_mall_prize", package.seeall)

local title = {
	id = 2,
	needMoney = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		277001,
		1,
		60,
		"10:277001:50"
	},
	{
		277001,
		2,
		80,
		"10:277001:100"
	},
	{
		277001,
		3,
		100,
		"10:277001:850"
	},
	{
		277002,
		1,
		30,
		"10:277002:50"
	},
	{
		277002,
		2,
		50,
		"10:277002:50"
	},
	{
		277002,
		3,
		80,
		"10:277002:100"
	},
	{
		277002,
		4,
		100,
		"10:277002:800"
	}
}
local t_rebate_mall_prize = {
	[277001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[277002] = {
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_rebate_mall_prize.dataList = dataList

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

return t_rebate_mall_prize
