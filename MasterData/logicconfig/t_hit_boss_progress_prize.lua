-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hit_boss_progress_prize.lua

module("logicconfig.config.t_hit_boss_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		327001,
		1,
		"100000000",
		"4:510022:1"
	},
	{
		327001,
		2,
		"200000000",
		"4:30006:20"
	},
	{
		327001,
		3,
		"300000000",
		"4:510022:1"
	},
	{
		327001,
		4,
		"400000000",
		"4:30006:20"
	},
	{
		327001,
		5,
		"500000000",
		"4:510022:1"
	},
	{
		327001,
		6,
		"600000000",
		"4:30006:20"
	},
	{
		327001,
		7,
		"700000000",
		"4:510022:1"
	},
	{
		327001,
		8,
		"800000000",
		"4:30006:20"
	},
	{
		327001,
		9,
		"900000000",
		"4:510022:1"
	},
	{
		327001,
		10,
		"1000000000",
		"4:30006:20"
	},
	{
		327002,
		1,
		"100000000",
		"4:239:5"
	},
	{
		327002,
		2,
		"200000000",
		"4:239:5"
	},
	{
		327002,
		3,
		"300000000",
		"4:239:5"
	},
	{
		327002,
		4,
		"400000000",
		"4:239:10"
	},
	{
		327002,
		5,
		"500000000",
		"4:239:10"
	},
	{
		327002,
		6,
		"600000000",
		"4:239:10"
	},
	{
		327002,
		7,
		"700000000",
		"4:239:15"
	},
	{
		327002,
		8,
		"800000000",
		"4:239:15"
	},
	{
		327002,
		9,
		"900000000",
		"4:239:15"
	},
	{
		327002,
		10,
		"1000000000",
		"4:239:30"
	},
	{
		327003,
		1,
		"100000000",
		"4:239:5"
	},
	{
		327003,
		2,
		"200000000",
		"4:239:5"
	},
	{
		327003,
		3,
		"300000000",
		"4:239:5"
	},
	{
		327003,
		4,
		"400000000",
		"4:239:10"
	},
	{
		327003,
		5,
		"500000000",
		"4:239:10"
	},
	{
		327003,
		6,
		"600000000",
		"4:239:10"
	},
	{
		327003,
		7,
		"700000000",
		"4:239:15"
	},
	{
		327003,
		8,
		"800000000",
		"4:239:15"
	},
	{
		327003,
		9,
		"900000000",
		"4:239:15"
	},
	{
		327003,
		10,
		"1000000000",
		"4:239:30"
	}
}
local t_hit_boss_progress_prize = {
	[327001] = {
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
	[327002] = {
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
	},
	[327003] = {
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	}
}

t_hit_boss_progress_prize.dataList = dataList

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

return t_hit_boss_progress_prize
