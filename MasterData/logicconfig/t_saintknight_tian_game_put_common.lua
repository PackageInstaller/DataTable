-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saintknight_tian_game_put_common.lua

module("logicconfig.config.t_saintknight_tian_game_put_common", package.seeall)

local title = {
	power = 4,
	typeId = 2,
	slotId = 1,
	resPath = 3
}
local dataList = {
	{
		0,
		1,
		"",
		0
	},
	{
		1,
		2,
		"btn_sqxt_05",
		1
	},
	{
		2,
		3,
		"com_play_sqxt_03",
		2
	},
	{
		3,
		3,
		"com_play_sqxt_04",
		4
	},
	{
		4,
		3,
		"com_play_sqxt_03",
		5
	},
	{
		5,
		3,
		"com_play_sqxt_04",
		6
	},
	{
		6,
		3,
		"com_play_sqxt_03",
		6
	},
	{
		7,
		3,
		"com_play_sqxt_04",
		8
	},
	{
		8,
		3,
		"com_play_sqxt_03",
		9
	},
	{
		9,
		3,
		"com_play_sqxt_04",
		10
	},
	{
		10,
		3,
		"com_play_sqxt_03",
		11
	},
	{
		11,
		3,
		"com_play_sqxt_04",
		14
	},
	{
		12,
		3,
		"com_play_sqxt_03",
		15
	},
	{
		13,
		3,
		"com_play_sqxt_04",
		16
	},
	{
		14,
		3,
		"com_play_sqxt_03",
		18
	},
	{
		15,
		3,
		"com_play_sqxt_04",
		20
	},
	{
		100,
		4,
		"com_player_wy",
		100
	}
}
local t_saintknight_tian_game_put_common = {
	[0] = dataList[1],
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
	[100] = dataList[17]
}

t_saintknight_tian_game_put_common.dataList = dataList

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

return t_saintknight_tian_game_put_common
