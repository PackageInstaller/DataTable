-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gift_box_rate.lua

module("logicconfig.config.t_gift_box_rate", package.seeall)

local title = {
	rateId = 2,
	ratePlan = 1,
	score = 3,
	rate = 4
}
local dataList = {
	{
		1,
		1,
		0,
		0.072
	},
	{
		1,
		2,
		10,
		0.108
	},
	{
		1,
		3,
		20,
		0.144
	},
	{
		1,
		4,
		30,
		0.18
	},
	{
		1,
		5,
		40,
		0.216
	},
	{
		1,
		6,
		50,
		0.252
	},
	{
		1,
		7,
		60,
		0.288
	},
	{
		1,
		8,
		70,
		0.324
	},
	{
		1,
		9,
		80,
		0.36
	},
	{
		1,
		10,
		90,
		0.396
	},
	{
		1,
		11,
		100,
		1
	},
	{
		2,
		1,
		0,
		0.1
	},
	{
		2,
		2,
		20,
		0.12
	},
	{
		2,
		3,
		50,
		0.16
	},
	{
		2,
		4,
		80,
		0.2
	}
}
local t_gift_box_rate = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	},
	{
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_gift_box_rate.dataList = dataList

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

return t_gift_box_rate
