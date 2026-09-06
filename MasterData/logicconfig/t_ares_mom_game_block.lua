-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ares_mom_game_block.lua

module("logicconfig.config.t_ares_mom_game_block", package.seeall)

local title = {
	challengeId = 1,
	addTimes = 4,
	res = 9,
	prize = 3,
	isWhite = 8,
	canUnlock = 7,
	y = 6,
	id = 2,
	x = 5,
	dealType = 10
}
local dataList = {
	{
		51,
		1,
		"8:1:1000",
		0,
		1,
		1,
		true,
		true,
		"board_aruisimuqin_18",
		1
	},
	{
		51,
		2,
		"10:2130001:25",
		0,
		1,
		1,
		true,
		false,
		"board_tuan1_1",
		2
	},
	{
		51,
		3,
		"10:2130001:25",
		0,
		1,
		1,
		true,
		false,
		"board_tuan1_2",
		2
	},
	{
		51,
		4,
		"10:2130001:25",
		0,
		1,
		1,
		true,
		false,
		"board_tuan1_3",
		2
	},
	{
		51,
		5,
		"10:2130001:40",
		0,
		2,
		2,
		true,
		false,
		"board_tuan2",
		3
	},
	{
		51,
		6,
		"10:2130001:40",
		0,
		2,
		2,
		true,
		false,
		"board_tuan3",
		3
	},
	{
		51,
		7,
		"10:2130001:25",
		2,
		2,
		3,
		true,
		false,
		"board_tuan4",
		4
	},
	{
		51,
		8,
		"10:2130001:25",
		2,
		3,
		2,
		true,
		false,
		"board_tuan5",
		5
	},
	{
		51,
		9,
		"",
		0,
		1,
		1,
		false,
		false,
		"board_aruisimuqin_19",
		6
	},
	{
		51,
		10,
		"",
		0,
		1,
		1,
		false,
		false,
		"board_aruisimuqin_20",
		6
	},
	{
		127,
		1,
		"8:1:1000",
		0,
		1,
		1,
		true,
		true,
		"board_shenyaotianmanwang_09",
		1
	},
	{
		127,
		2,
		"10:2130002:120",
		0,
		1,
		1,
		true,
		false,
		"board_tuan1_1",
		2
	},
	{
		127,
		3,
		"10:2130002:120",
		0,
		1,
		1,
		true,
		false,
		"board_tuan1_1",
		2
	},
	{
		127,
		4,
		"10:2130002:120",
		0,
		1,
		1,
		true,
		false,
		"board_tuan1_1",
		2
	},
	{
		127,
		5,
		"10:2130002:160",
		0,
		2,
		2,
		true,
		false,
		"board_sytmw2x2_1",
		3
	},
	{
		127,
		6,
		"10:2130002:160",
		0,
		2,
		2,
		true,
		false,
		"board_sytmw2x2_2",
		3
	},
	{
		127,
		7,
		"10:2130002:120",
		2,
		2,
		3,
		true,
		false,
		"board_sytmw3x2_1",
		4
	},
	{
		127,
		8,
		"10:2130002:120",
		2,
		3,
		2,
		true,
		false,
		"board_sytmw3x2_2",
		5
	},
	{
		127,
		9,
		"",
		0,
		1,
		1,
		false,
		false,
		"board_shenyaotianmanwang_11",
		6
	},
	{
		127,
		10,
		"",
		0,
		1,
		1,
		false,
		false,
		"board_shenyaotianmanwang_12",
		6
	}
}
local t_ares_mom_game_block = {
	[51] = {
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
	[127] = {
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

t_ares_mom_game_block.dataList = dataList

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

return t_ares_mom_game_block
