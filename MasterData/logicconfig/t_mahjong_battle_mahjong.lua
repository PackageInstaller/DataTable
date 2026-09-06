-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mahjong_battle_mahjong.lua

module("logicconfig.config.t_mahjong_battle_mahjong", package.seeall)

local title = {
	sameTypeMahjongSubId = 4,
	showPic = 5,
	type = 3,
	mahjongId = 2,
	activityId = 1
}
local dataList = {
	{
		571001,
		1,
		1,
		1,
		"board_luandoumajiang_mjtong01"
	},
	{
		571001,
		2,
		1,
		2,
		"board_luandoumajiang_mjtong02"
	},
	{
		571001,
		3,
		1,
		3,
		"board_luandoumajiang_mjtong03"
	},
	{
		571001,
		4,
		1,
		4,
		"board_luandoumajiang_mjtong04"
	},
	{
		571001,
		5,
		1,
		5,
		"board_luandoumajiang_mjtong05"
	},
	{
		571001,
		6,
		1,
		6,
		"board_luandoumajiang_mjtong06"
	},
	{
		571001,
		7,
		1,
		7,
		"board_luandoumajiang_mjtong07"
	},
	{
		571001,
		8,
		1,
		8,
		"board_luandoumajiang_mjtong08"
	},
	{
		571001,
		9,
		1,
		9,
		"board_luandoumajiang_mjtong09"
	},
	{
		571001,
		10,
		2,
		1,
		"board_luandoumajiang_mjtiao01"
	},
	{
		571001,
		11,
		2,
		2,
		"board_luandoumajiang_mjtiao02"
	},
	{
		571001,
		12,
		2,
		3,
		"board_luandoumajiang_mjtiao03"
	},
	{
		571001,
		13,
		2,
		4,
		"board_luandoumajiang_mjtiao04"
	},
	{
		571001,
		14,
		2,
		5,
		"board_luandoumajiang_mjtiao05"
	},
	{
		571001,
		15,
		2,
		6,
		"board_luandoumajiang_mjtiao06"
	},
	{
		571001,
		16,
		2,
		7,
		"board_luandoumajiang_mjtiao07"
	},
	{
		571001,
		17,
		2,
		8,
		"board_luandoumajiang_mjtiao08"
	},
	{
		571001,
		18,
		2,
		9,
		"board_luandoumajiang_mjtiao09"
	},
	{
		571001,
		19,
		3,
		1,
		"board_luandoumajiang_mjwan01"
	},
	{
		571001,
		20,
		3,
		2,
		"board_luandoumajiang_mjwan02"
	},
	{
		571001,
		21,
		3,
		3,
		"board_luandoumajiang_mjwan03"
	},
	{
		571001,
		22,
		3,
		4,
		"board_luandoumajiang_mjwan04"
	},
	{
		571001,
		23,
		3,
		5,
		"board_luandoumajiang_mjwan05"
	},
	{
		571001,
		24,
		3,
		6,
		"board_luandoumajiang_mjwan06"
	},
	{
		571001,
		25,
		3,
		7,
		"board_luandoumajiang_mjwan07"
	},
	{
		571001,
		26,
		3,
		8,
		"board_luandoumajiang_mjwan08"
	},
	{
		571001,
		27,
		3,
		9,
		"board_luandoumajiang_mjwan09"
	}
}
local t_mahjong_battle_mahjong = {
	[571001] = {
		dataList[1],
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
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27]
	}
}

t_mahjong_battle_mahjong.dataList = dataList

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

return t_mahjong_battle_mahjong
