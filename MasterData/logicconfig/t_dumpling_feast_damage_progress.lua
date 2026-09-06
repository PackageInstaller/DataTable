-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dumpling_feast_damage_progress.lua

module("logicconfig.config.t_dumpling_feast_damage_progress", package.seeall)

local title = {
	progressId = 2,
	damage = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		562001,
		1,
		"1000000",
		"4:30006:25"
	},
	{
		562001,
		2,
		"5000000",
		"4:36:10"
	},
	{
		562001,
		3,
		"10000000",
		"4:510022:5"
	},
	{
		562001,
		4,
		"50000000",
		"4:30006:25"
	},
	{
		562001,
		5,
		"100000000",
		"4:90203:1"
	},
	{
		562001,
		6,
		"300000000",
		"8:1:2500000"
	},
	{
		562001,
		7,
		"500000000",
		"4:30006:25"
	},
	{
		562001,
		8,
		"800000000",
		"8:1:2500000"
	},
	{
		562001,
		9,
		"1000000000",
		"4:30006:25"
	},
	{
		562001,
		10,
		"1500000000",
		"8:1:5000000"
	}
}
local t_dumpling_feast_damage_progress = {
	[562001] = {
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
	}
}

t_dumpling_feast_damage_progress.dataList = dataList

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

return t_dumpling_feast_damage_progress
