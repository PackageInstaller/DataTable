-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ji_courier_prize.lua

module("logicconfig.config.t_king_ji_courier_prize", package.seeall)

local title = {
	prizeId = 2,
	damage = 3,
	actId = 1,
	prize = 4
}
local dataList = {
	{
		308001,
		1,
		50000000,
		"4:380:2"
	},
	{
		308001,
		2,
		100000000,
		"4:380:2"
	},
	{
		308001,
		3,
		500000000,
		"4:380:4"
	},
	{
		308001,
		4,
		1000000000,
		"4:380:4"
	},
	{
		308001,
		5,
		1500000000,
		"4:380:4"
	},
	{
		308001,
		6,
		2000000000,
		"4:380:4"
	},
	{
		308002,
		1,
		50000000,
		"8:1:1"
	},
	{
		308002,
		2,
		100000000,
		"8:1:1"
	},
	{
		308002,
		3,
		500000000,
		"8:1:1"
	},
	{
		308002,
		4,
		1000000000,
		"8:1:1"
	},
	{
		308002,
		5,
		1500000000,
		"8:1:1"
	},
	{
		308002,
		6,
		2000000000,
		"8:1:1"
	}
}
local t_king_ji_courier_prize = {
	[308001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[308002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_king_ji_courier_prize.dataList = dataList

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

return t_king_ji_courier_prize
