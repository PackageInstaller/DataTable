-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dress_discount_plan.lua

module("logicconfig.config.t_dress_discount_plan", package.seeall)

local title = {
	showDiscount = 6,
	type = 3,
	id = 2,
	discountCost = 5,
	planId = 1,
	userNum = 4
}
local dataList = {
	{
		1,
		1,
		2,
		1200,
		"204:190002:248",
		"8.3"
	},
	{
		1,
		2,
		2,
		1500,
		"204:190002:270",
		"9"
	},
	{
		2,
		1,
		2,
		500,
		"204:190002:248",
		"6.4"
	},
	{
		2,
		2,
		2,
		1000,
		"204:190002:268",
		"7"
	},
	{
		2,
		3,
		2,
		1500,
		"204:190002:288",
		"7.4"
	},
	{
		3,
		1,
		2,
		800,
		"204:190002:328",
		"7.7"
	},
	{
		3,
		2,
		2,
		1200,
		"204:190002:358",
		"8.4"
	},
	{
		4,
		1,
		2,
		1500,
		"204:190002:328",
		"7.7"
	},
	{
		5,
		1,
		2,
		1500,
		"204:190002:328",
		"7.7"
	},
	{
		6,
		1,
		2,
		99999,
		"204:190002:288",
		"6.7"
	},
	{
		7,
		1,
		2,
		99999,
		"204:190002:328",
		"7.7"
	},
	{
		8,
		1,
		2,
		99999,
		"204:190007:298",
		"7.0"
	},
	{
		9,
		1,
		2,
		99999,
		"204:190008:248",
		"5.8"
	}
}
local t_dress_discount_plan = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7]
	},
	{
		dataList[8]
	},
	{
		dataList[9]
	},
	{
		dataList[10]
	},
	{
		dataList[11]
	},
	{
		dataList[12]
	},
	{
		dataList[13]
	}
}

t_dress_discount_plan.dataList = dataList

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

return t_dress_discount_plan
