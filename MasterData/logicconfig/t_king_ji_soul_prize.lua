-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ji_soul_prize.lua

module("logicconfig.config.t_king_ji_soul_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	actId = 1,
	progress = 3
}
local dataList = {
	{
		308001,
		1,
		3,
		"4:380:5"
	},
	{
		308001,
		2,
		5,
		"4:380:5"
	},
	{
		308001,
		3,
		10,
		"4:380:5"
	},
	{
		308001,
		4,
		15,
		"4:380:5"
	},
	{
		308001,
		5,
		20,
		"4:380:10"
	},
	{
		308001,
		6,
		25,
		"4:380:10"
	},
	{
		308002,
		1,
		3,
		"8:1:1"
	},
	{
		308002,
		2,
		5,
		"8:1:1"
	},
	{
		308002,
		3,
		10,
		"8:1:1"
	},
	{
		308002,
		4,
		15,
		"8:1:1"
	},
	{
		308002,
		5,
		20,
		"8:1:1"
	},
	{
		308002,
		6,
		25,
		"8:1:1"
	}
}
local t_king_ji_soul_prize = {
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

t_king_ji_soul_prize.dataList = dataList

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

return t_king_ji_soul_prize
