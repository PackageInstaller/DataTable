-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_card_lottery_card.lua

module("logicconfig.config.t_pet_card_lottery_card", package.seeall)

local title = {
	id = 2,
	icon = 3,
	activityId = 1
}
local dataList = {
	{
		271001,
		1,
		"emoji_2zn_01"
	},
	{
		271001,
		2,
		"emoji_2zn_02"
	},
	{
		271001,
		3,
		"emoji_2zn_05"
	},
	{
		271001,
		4,
		"emoji_2zn_04"
	},
	{
		271001,
		5,
		"emoji_2zn_03"
	},
	{
		271001,
		6,
		"emoji_2zn_08"
	},
	{
		271001,
		7,
		"emoji_2zn_11"
	},
	{
		271001,
		8,
		"emoji_2zn_13"
	},
	{
		271001,
		9,
		"emoji_2zn_14"
	},
	{
		271001,
		10,
		"emoji_2zn_15"
	},
	{
		271002,
		1,
		"emoji_2zn_17"
	},
	{
		271002,
		2,
		"emoji_2zn_18"
	},
	{
		271002,
		3,
		"emoji_2zn_19"
	},
	{
		271002,
		4,
		"emoji_2zn_20"
	},
	{
		271002,
		5,
		"emoji_2zn_21"
	},
	{
		271002,
		6,
		"emoji_2zn_22"
	},
	{
		271002,
		7,
		"emoji_2zn_23"
	},
	{
		271002,
		8,
		"emoji_2zn_24"
	},
	{
		271002,
		9,
		"emoji_2zn_25"
	},
	{
		271002,
		10,
		"emoji_2zn_26"
	}
}
local t_pet_card_lottery_card = {
	[271001] = {
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
	[271002] = {
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

t_pet_card_lottery_card.dataList = dataList

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

return t_pet_card_lottery_card
