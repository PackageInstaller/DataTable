-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_breach_formation_score.lua

module("logicconfig.config.t_breach_formation_score", package.seeall)

local title = {
	scoreProcessor = 1,
	point = 3,
	scoreRange = 2,
	evaluate = 4,
	desc = 5
}
local dataList = {
	{
		"ShotTimes",
		1,
		1000,
		"S",
		"1~15"
	},
	{
		"ShotTimes",
		16,
		700,
		"A",
		"16~25"
	},
	{
		"ShotTimes",
		26,
		400,
		"B",
		"26~35"
	},
	{
		"ShotTimes",
		36,
		200,
		"C",
		"36~45"
	},
	{
		"ShotTimes",
		46,
		100,
		"D",
		"46及以上"
	},
	{
		"MyAliveNum",
		1,
		100,
		"D",
		"1"
	},
	{
		"MyAliveNum",
		2,
		200,
		"C",
		"2"
	},
	{
		"MyAliveNum",
		3,
		400,
		"B",
		"3"
	},
	{
		"MyAliveNum",
		4,
		700,
		"A",
		"4"
	},
	{
		"MyAliveNum",
		5,
		1000,
		"S",
		"5"
	},
	{
		"UltimateNum",
		0,
		1000,
		"S",
		"0~9"
	},
	{
		"UltimateNum",
		10,
		700,
		"A",
		"10~15"
	},
	{
		"UltimateNum",
		16,
		400,
		"B",
		"16~20"
	},
	{
		"UltimateNum",
		21,
		200,
		"C",
		"21~25"
	},
	{
		"UltimateNum",
		26,
		100,
		"D",
		"26及以上"
	}
}
local t_breach_formation_score = {
	ShotTimes = {
		dataList[1],
		[16] = dataList[2],
		[26] = dataList[3],
		[36] = dataList[4],
		[46] = dataList[5]
	},
	MyAliveNum = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	UltimateNum = {
		[0] = dataList[11],
		[10] = dataList[12],
		[16] = dataList[13],
		[21] = dataList[14],
		[26] = dataList[15]
	}
}

t_breach_formation_score.dataList = dataList

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

return t_breach_formation_score
