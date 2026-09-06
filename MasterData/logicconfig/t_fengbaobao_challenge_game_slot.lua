-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fengbaobao_challenge_game_slot.lua

module("logicconfig.config.t_fengbaobao_challenge_game_slot", package.seeall)

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
		"board_tzfbb_07",
		1
	},
	{
		2,
		3,
		"com_player_jg",
		2
	},
	{
		3,
		3,
		"com_player_gw01",
		4
	},
	{
		4,
		3,
		"com_player_gw",
		5
	},
	{
		5,
		3,
		"com_player_gw01",
		6
	},
	{
		6,
		3,
		"com_player_yg01",
		6
	},
	{
		7,
		3,
		"com_player_gw",
		8
	},
	{
		8,
		3,
		"com_player_gw01",
		9
	},
	{
		9,
		3,
		"com_player_yg01",
		10
	},
	{
		10,
		3,
		"com_player_gw",
		11
	},
	{
		11,
		3,
		"com_player_yg01",
		14
	},
	{
		12,
		3,
		"com_player_gw",
		15
	},
	{
		13,
		3,
		"com_player_yg01",
		16
	},
	{
		14,
		3,
		"com_player_yg",
		18
	},
	{
		15,
		3,
		"com_player_jg01",
		20
	},
	{
		100,
		4,
		"com_player_wy",
		100
	}
}
local t_fengbaobao_challenge_game_slot = {
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

t_fengbaobao_challenge_game_slot.dataList = dataList

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

return t_fengbaobao_challenge_game_slot
