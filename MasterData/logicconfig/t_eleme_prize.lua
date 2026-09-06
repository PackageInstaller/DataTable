-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eleme_prize.lua

module("logicconfig.config.t_eleme_prize", package.seeall)

local title = {
	prizeId = 2,
	likeNum = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		332001,
		1,
		3,
		"104:2:100"
	},
	{
		332001,
		2,
		5,
		"8:1:300000"
	},
	{
		332001,
		3,
		10,
		"104:2:100"
	},
	{
		332001,
		4,
		15,
		"8:1:300000"
	},
	{
		332001,
		5,
		20,
		"104:2:100"
	},
	{
		332001,
		6,
		25,
		"8:1:300000"
	},
	{
		332001,
		7,
		30,
		"104:2:100"
	},
	{
		332001,
		8,
		35,
		"8:1:300000"
	},
	{
		332001,
		9,
		40,
		"104:2:100"
	},
	{
		332001,
		10,
		45,
		"14:240:1"
	},
	{
		332001,
		11,
		50,
		"8:1:300000"
	},
	{
		332001,
		12,
		55,
		"104:2:100"
	},
	{
		332001,
		13,
		60,
		"8:1:300000"
	},
	{
		332001,
		14,
		65,
		"104:2:100"
	},
	{
		332001,
		15,
		70,
		"8:1:300000"
	},
	{
		332001,
		16,
		75,
		"104:2:150"
	},
	{
		332001,
		17,
		80,
		"8:1:300000"
	},
	{
		332001,
		18,
		85,
		"104:2:150"
	},
	{
		332001,
		19,
		90,
		"8:1:600000"
	},
	{
		332001,
		20,
		100,
		"2:144:1"
	}
}
local t_eleme_prize = {
	[332001] = {
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
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_eleme_prize.dataList = dataList

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

return t_eleme_prize
