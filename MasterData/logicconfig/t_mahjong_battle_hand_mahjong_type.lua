-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mahjong_battle_hand_mahjong_type.lua

module("logicconfig.config.t_mahjong_battle_hand_mahjong_type", package.seeall)

local title = {
	activityId = 1,
	num = 3,
	handMahjongType = 2
}
local dataList = {
	{
		571001,
		1,
		0
	},
	{
		571001,
		1,
		1
	},
	{
		571001,
		1,
		2
	},
	{
		571001,
		1,
		3
	},
	{
		571001,
		1,
		4
	},
	{
		571001,
		2,
		0
	},
	{
		571001,
		2,
		1
	},
	{
		571001,
		2,
		2
	},
	{
		571001,
		2,
		3
	},
	{
		571001,
		2,
		4
	},
	{
		571001,
		3,
		0
	},
	{
		571001,
		3,
		1
	},
	{
		571001,
		3,
		2
	},
	{
		571001,
		3,
		3
	},
	{
		571001,
		3,
		4
	}
}
local t_mahjong_battle_hand_mahjong_type = {
	[571001] = {
		{
			[0] = dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5]
		},
		{
			[0] = dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10]
		},
		{
			[0] = dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15]
		}
	}
}

t_mahjong_battle_hand_mahjong_type.dataList = dataList

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

return t_mahjong_battle_hand_mahjong_type
