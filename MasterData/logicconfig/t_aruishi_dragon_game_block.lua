-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_aruishi_dragon_game_block.lua

module("logicconfig.config.t_aruishi_dragon_game_block", package.seeall)

local title = {
	addTimes = 4,
	x = 5,
	res = 9,
	prize = 3,
	isWhite = 8,
	canUnlock = 7,
	y = 6,
	id = 2,
	activityId = 1,
	dealType = 10
}
local dataList = {
	{
		366001,
		1,
		"10:366001:25",
		0,
		1,
		1,
		true,
		true,
		"board_syars_07",
		1
	},
	{
		366001,
		2,
		"10:366001:25",
		0,
		1,
		1,
		true,
		false,
		"board_syars_tuan1_1",
		2
	},
	{
		366001,
		3,
		"10:366001:25",
		0,
		1,
		1,
		true,
		false,
		"board_syars_tuan1_1",
		2
	},
	{
		366001,
		4,
		"10:366001:25",
		0,
		1,
		1,
		true,
		false,
		"board_syars_tuan1_2",
		2
	},
	{
		366001,
		5,
		"10:366001:40",
		0,
		2,
		2,
		true,
		false,
		"board_syars_tuan2",
		3
	},
	{
		366001,
		6,
		"10:366001:40",
		0,
		2,
		2,
		true,
		false,
		"board_syars_tuan3",
		3
	},
	{
		366001,
		7,
		"10:366001:25",
		2,
		2,
		3,
		true,
		false,
		"board_syars_tuan4",
		4
	},
	{
		366001,
		8,
		"10:366001:25",
		2,
		3,
		2,
		true,
		false,
		"board_syars_tuan5",
		5
	},
	{
		366001,
		9,
		"",
		0,
		1,
		1,
		false,
		false,
		"board_syars_10",
		6
	},
	{
		366001,
		10,
		"",
		0,
		1,
		1,
		false,
		false,
		"board_syars_11",
		6
	}
}
local t_aruishi_dragon_game_block = {
	[366001] = {
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

t_aruishi_dragon_game_block.dataList = dataList

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

return t_aruishi_dragon_game_block
