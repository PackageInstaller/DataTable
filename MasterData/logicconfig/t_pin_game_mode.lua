-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pin_game_mode.lua

module("logicconfig.config.t_pin_game_mode", package.seeall)

local title = {
	score = 4,
	name = 3,
	mode = 2,
	stagePlanId = 5,
	raceId = 6,
	actId = 1
}
local dataList = {
	{
		325001,
		1,
		"普通暗蚀",
		10,
		1,
		10374
	},
	{
		325001,
		2,
		"精英暗蚀",
		20,
		2,
		10348
	},
	{
		325001,
		3,
		"暗蚀首领",
		30,
		3,
		10373
	},
	{
		325002,
		1,
		"一朵花",
		10,
		1,
		1401602
	},
	{
		325002,
		2,
		"一小把花",
		20,
		2,
		16019
	},
	{
		325002,
		3,
		"一大把花",
		30,
		3,
		1800101
	},
	{
		325003,
		1,
		"一朵花",
		10,
		1,
		1202902
	},
	{
		325003,
		2,
		"一小把花",
		20,
		2,
		1603102
	},
	{
		325003,
		3,
		"一大把花",
		30,
		3,
		1503101
	},
	{
		325004,
		1,
		"一朵花",
		10,
		1,
		11036
	},
	{
		325004,
		2,
		"一小把花",
		20,
		2,
		1103704
	},
	{
		325004,
		3,
		"一大把花",
		30,
		3,
		1104003
	}
}
local t_pin_game_mode = {
	[325001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[325002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[325003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[325004] = {
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_pin_game_mode.dataList = dataList

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

return t_pin_game_mode
