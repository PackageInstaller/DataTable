-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hex_lineup_progress_prize.lua

module("logicconfig.config.t_hex_lineup_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		590001,
		1,
		80,
		"9:1300058:1"
	},
	{
		590001,
		2,
		160,
		"9:1300058:1"
	},
	{
		590001,
		3,
		240,
		"9:1300058:1"
	},
	{
		590001,
		4,
		320,
		"9:1300058:1"
	},
	{
		590001,
		5,
		400,
		"9:1300058:1"
	},
	{
		590001,
		6,
		480,
		"9:1300058:1"
	},
	{
		590001,
		7,
		560,
		"9:1300058:1"
	},
	{
		590001,
		8,
		640,
		"9:1300058:1"
	},
	{
		590001,
		9,
		720,
		"9:1300058:1"
	},
	{
		590001,
		10,
		800,
		"9:1300058:1"
	}
}
local t_hex_lineup_progress_prize = {
	[590001] = {
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

t_hex_lineup_progress_prize.dataList = dataList

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

return t_hex_lineup_progress_prize
