-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_wei_lei_ta_clg_normal_prize.lua

module("logicconfig.config.t_divine_wei_lei_ta_clg_normal_prize", package.seeall)

local title = {
	prizeId = 2,
	score = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		433001,
		1,
		200,
		"4:90004:1"
	},
	{
		433001,
		2,
		350,
		"4:261:5"
	},
	{
		433001,
		3,
		550,
		"8:1:1000000"
	},
	{
		433001,
		4,
		750,
		"4:261:5"
	},
	{
		433001,
		5,
		1100,
		"4:261:10"
	},
	{
		433002,
		1,
		200,
		"8:1:1"
	},
	{
		433002,
		2,
		350,
		"8:1:1"
	},
	{
		433002,
		3,
		550,
		"8:1:1"
	},
	{
		433002,
		4,
		750,
		"8:1:1"
	},
	{
		433002,
		5,
		1100,
		"8:1:1"
	}
}
local t_divine_wei_lei_ta_clg_normal_prize = {
	[433001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[433002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_divine_wei_lei_ta_clg_normal_prize.dataList = dataList

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

return t_divine_wei_lei_ta_clg_normal_prize
