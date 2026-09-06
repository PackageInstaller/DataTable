-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mahjong_battle_teach_fake_data.lua

module("logicconfig.config.t_mahjong_battle_teach_fake_data", package.seeall)

local title = {
	handMJIds = 5,
	stystemMJIds = 6,
	creepsIds = 7,
	state = 3,
	summonCreepsIds = 9,
	randomGenre = 4,
	summonType = 8,
	id = 2,
	activityId = 1
}
local dataList = {
	{
		571001,
		1,
		"waiting_select_team",
		{
			1,
			2,
			3
		},
		nil,
		nil,
		nil,
		0
	},
	{
		571001,
		2,
		"waiting_select_mahjong",
		nil,
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			13
		},
		{
			13,
			2,
			3
		},
		{
			1,
			2,
			3,
			4,
			5
		},
		0
	},
	{
		571001,
		3,
		"waiting_drop_mahjong",
		nil,
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			13,
			13
		},
		{
			13,
			2,
			3
		},
		{
			1,
			2,
			3,
			4,
			5
		},
		0
	},
	{
		571001,
		4,
		"waiting_select_summon_pet",
		nil,
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			13,
			13
		},
		{
			13,
			2,
			3
		},
		{
			1,
			2,
			3,
			4,
			5
		},
		6,
		{
			5,
			6,
			7
		}
	},
	{
		571001,
		5,
		"matched_opponent",
		nil,
		nil,
		nil,
		nil,
		0
	}
}
local t_mahjong_battle_teach_fake_data = {
	[571001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_mahjong_battle_teach_fake_data.dataList = dataList

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

return t_mahjong_battle_teach_fake_data
