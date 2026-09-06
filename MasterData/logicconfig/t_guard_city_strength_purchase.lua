-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guard_city_strength_purchase.lua

module("logicconfig.config.t_guard_city_strength_purchase", package.seeall)

local title = {
	cost = 3,
	strengthPurchasePlanId = 1,
	times = 2
}
local dataList = {
	{
		1,
		1,
		"105:2:50"
	},
	{
		1,
		2,
		"105:2:50"
	},
	{
		1,
		3,
		"105:2:50"
	},
	{
		1,
		4,
		"105:2:100"
	},
	{
		1,
		5,
		"105:2:100"
	},
	{
		1,
		6,
		"105:2:100"
	},
	{
		1,
		7,
		"105:2:150"
	},
	{
		1,
		8,
		"105:2:150"
	}
}
local t_guard_city_strength_purchase = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_guard_city_strength_purchase.dataList = dataList

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

return t_guard_city_strength_purchase
