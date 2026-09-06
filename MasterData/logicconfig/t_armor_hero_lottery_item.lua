-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_armor_hero_lottery_item.lua

module("logicconfig.config.t_armor_hero_lottery_item", package.seeall)

local title = {
	itemId = 2,
	icon = 3,
	activityId = 1
}
local dataList = {
	{
		553001,
		1,
		"ui/icon/items/icon_ddp_01"
	},
	{
		553001,
		2,
		"ui/icon/items/icon_ddp_02"
	},
	{
		553001,
		3,
		"ui/icon/items/icon_ddp_03"
	},
	{
		553001,
		4,
		"ui/icon/items/icon_ddp_04"
	},
	{
		553001,
		5,
		"ui/icon/items/icon_ddp_05"
	},
	{
		553001,
		6,
		"ui/icon/items/icon_ddp_06"
	},
	{
		553001,
		7,
		"ui/icon/items/icon_ddp_07"
	},
	{
		553001,
		8,
		"ui/icon/items/icon_ddp_08"
	},
	{
		553001,
		9,
		"ui/icon/items/icon_ddp_09"
	},
	{
		553002,
		1,
		"ui/icon/items/icon_baji_01"
	},
	{
		553002,
		2,
		"ui/icon/items/icon_baji_02"
	},
	{
		553002,
		3,
		"ui/icon/items/icon_baji_03"
	},
	{
		553002,
		4,
		"ui/icon/items/icon_baji_04"
	},
	{
		553002,
		5,
		"ui/icon/items/icon_baji_05"
	},
	{
		553002,
		6,
		"ui/icon/items/icon_baji_06"
	},
	{
		553002,
		7,
		"ui/icon/items/icon_baji_07"
	},
	{
		553002,
		8,
		"ui/icon/items/icon_baji_08"
	},
	{
		553002,
		9,
		"ui/icon/items/icon_baji_09"
	}
}
local t_armor_hero_lottery_item = {
	[553001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[553002] = {
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_armor_hero_lottery_item.dataList = dataList

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

return t_armor_hero_lottery_item
