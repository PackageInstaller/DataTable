-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guess_box_game_box.lua

module("logicconfig.config.t_guess_box_game_box", package.seeall)

local title = {
	boxId = 2,
	minExchangeTimes = 5,
	boxPlanId = 1,
	pos = 4,
	flowerId = 3
}
local dataList = {
	{
		1,
		1,
		1,
		{
			-350,
			-75
		},
		1
	},
	{
		1,
		2,
		1,
		{
			-175,
			-75
		},
		1
	},
	{
		1,
		3,
		1,
		{
			0,
			-75
		},
		0
	},
	{
		1,
		4,
		2,
		{
			175,
			-75
		},
		1
	},
	{
		1,
		5,
		2,
		{
			350,
			-75
		},
		1
	},
	{
		2,
		1,
		1,
		{
			-350,
			-120
		},
		1
	},
	{
		2,
		2,
		1,
		{
			-175,
			-120
		},
		0
	},
	{
		2,
		3,
		1,
		{
			0,
			-120
		},
		0
	},
	{
		2,
		4,
		2,
		{
			175,
			-120
		},
		1
	},
	{
		2,
		5,
		3,
		{
			350,
			-120
		},
		1
	},
	{
		2,
		6,
		4,
		{
			-350,
			120
		},
		1
	},
	{
		2,
		7,
		1,
		{
			-175,
			120
		},
		0
	},
	{
		2,
		8,
		1,
		{
			0,
			120
		},
		1
	},
	{
		2,
		9,
		1,
		{
			175,
			120
		},
		0
	},
	{
		2,
		10,
		1,
		{
			350,
			120
		},
		1
	},
	{
		3,
		1,
		1,
		{
			-350,
			-75
		},
		1
	},
	{
		3,
		2,
		1,
		{
			-175,
			-75
		},
		1
	},
	{
		3,
		3,
		1,
		{
			0,
			-75
		},
		1
	},
	{
		3,
		4,
		1,
		{
			175,
			-75
		},
		1
	},
	{
		3,
		5,
		2,
		{
			350,
			-75
		},
		2
	}
}
local t_guess_box_game_box = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	},
	{
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_guess_box_game_box.dataList = dataList

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

return t_guess_box_game_box
