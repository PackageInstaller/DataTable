-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_farm_collect_prize.lua

module("logicconfig.config.t_eternal_farm_collect_prize", package.seeall)

local title = {
	prizeId = 3,
	name = 6,
	prize = 5,
	itemId = 2,
	activityId = 1,
	number = 4
}
local dataList = {
	{
		296006,
		296058,
		1,
		840,
		"4:30006:25",
		"希望"
	},
	{
		296006,
		296058,
		2,
		1680,
		"4:111:2",
		"希望"
	},
	{
		296006,
		296058,
		3,
		2520,
		"4:400002:25",
		"希望"
	},
	{
		296006,
		296058,
		4,
		3360,
		"8:1:250000",
		"希望"
	},
	{
		296006,
		296059,
		1,
		525,
		"4:30006:25",
		"快乐"
	},
	{
		296006,
		296059,
		2,
		1050,
		"4:111:2",
		"快乐"
	},
	{
		296006,
		296059,
		3,
		1050,
		"4:400002:25",
		"快乐"
	},
	{
		296006,
		296059,
		4,
		2100,
		"8:1:250000",
		"快乐"
	},
	{
		296006,
		296060,
		1,
		525,
		"4:30006:25",
		"有钱"
	},
	{
		296006,
		296060,
		2,
		1050,
		"4:111:3",
		"有钱"
	},
	{
		296006,
		296060,
		3,
		1050,
		"4:400002:25",
		"有钱"
	},
	{
		296006,
		296060,
		4,
		2100,
		"8:1:250000",
		"有钱"
	},
	{
		296006,
		296061,
		1,
		525,
		"4:30006:25",
		"健康"
	},
	{
		296006,
		296061,
		2,
		1050,
		"4:111:3",
		"健康"
	},
	{
		296006,
		296061,
		3,
		1050,
		"4:400002:25",
		"健康"
	},
	{
		296006,
		296061,
		4,
		2100,
		"8:1:250000",
		"健康"
	}
}
local t_eternal_farm_collect_prize = {
	[296006] = {
		[296058] = {
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4]
		},
		[296059] = {
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		},
		[296060] = {
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		},
		[296061] = {
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16]
		}
	}
}

t_eternal_farm_collect_prize.dataList = dataList

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

return t_eternal_farm_collect_prize
