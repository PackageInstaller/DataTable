-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_potluck_dinner_food_prize.lua

module("logicconfig.config.t_potluck_dinner_food_prize", package.seeall)

local title = {
	prizeId = 3,
	foodPrizePlanId = 1,
	weight = 5,
	broadcast = 6,
	prize = 4,
	foodType = 2
}
local dataList = {
	{
		1,
		1,
		1,
		"104:2:888",
		5,
		true
	},
	{
		1,
		1,
		2,
		"4:70003:1",
		2,
		true
	},
	{
		1,
		1,
		3,
		"4:112:10",
		5,
		true
	},
	{
		1,
		1,
		4,
		"4:36:10",
		5,
		true
	},
	{
		1,
		1,
		5,
		"4:71003:1",
		70,
		false
	},
	{
		1,
		1,
		6,
		"4:31:3",
		40,
		false
	},
	{
		1,
		1,
		7,
		"4:111:3",
		40,
		false
	},
	{
		1,
		1,
		8,
		"8:1:250000",
		30,
		false
	},
	{
		1,
		2,
		1,
		"4:30005:3",
		50,
		false
	},
	{
		1,
		2,
		2,
		"4:30005:5",
		50,
		false
	},
	{
		1,
		2,
		3,
		"4:30005:8",
		50,
		false
	},
	{
		1,
		2,
		4,
		"4:30005:10",
		50,
		false
	},
	{
		1,
		3,
		1,
		"104:2:188",
		1,
		false
	},
	{
		1,
		3,
		2,
		"104:2:88",
		10,
		false
	},
	{
		1,
		3,
		3,
		"104:2:38",
		20,
		false
	},
	{
		1,
		3,
		4,
		"104:2:28",
		20,
		false
	}
}
local t_potluck_dinner_food_prize = {
	{
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		},
		{
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		},
		{
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16]
		}
	}
}

t_potluck_dinner_food_prize.dataList = dataList

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

return t_potluck_dinner_food_prize
