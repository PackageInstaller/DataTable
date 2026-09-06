-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_idiom_chain_prize.lua

module("logicconfig.config.t_idiom_chain_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	needScore = 3
}
local dataList = {
	{
		543001,
		1,
		50,
		"8:1:4000000"
	},
	{
		543001,
		2,
		100,
		"4:36:3"
	},
	{
		543001,
		3,
		150,
		"10:544001:10"
	},
	{
		543001,
		4,
		200,
		"8:1:4000000"
	},
	{
		543001,
		5,
		250,
		"4:36:3"
	},
	{
		543001,
		6,
		300,
		"10:544001:20"
	},
	{
		543001,
		7,
		350,
		"8:1:6000000"
	},
	{
		543001,
		8,
		400,
		"4:36:4"
	},
	{
		543001,
		9,
		450,
		"10:544001:20"
	},
	{
		543001,
		10,
		500,
		"8:1:6000000"
	},
	{
		543002,
		1,
		50,
		"8:1:4000"
	}
}
local t_idiom_chain_prize = {
	[543001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[543002] = {
		dataList[11]
	}
}

t_idiom_chain_prize.dataList = dataList

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

return t_idiom_chain_prize
