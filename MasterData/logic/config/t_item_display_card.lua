-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_item_display_card.lua

module("logic.config.t_item_display_card", package.seeall)

local title = {
	icon = 7,
	quality = 5,
	useDesc = 15,
	type = 3,
	getWays = 14,
	unlockdesc = 12,
	desc = 11,
	repeatItem = 6,
	icon3 = 10,
	subType = 4,
	icon2 = 9,
	isShowBag = 13,
	id = 1,
	icon1 = 8,
	name = 2
}
local dataList = {
	{
		2201001,
		"默认",
		22,
		1,
		2,
		"{1100003:5000}",
		"1001001111",
		"1001001111",
		"zg_bf_001",
		"zg_bf_list_001",
		"主管的默认卡片",
		"初始拥有",
		0,
		"",
		""
	},
	{
		2201004,
		"云雾迷踪",
		22,
		1,
		3,
		"{1100003:5000}",
		"2201004",
		"2201004",
		"zg_bf_004",
		"zg_bf_list_004",
		"云雾缭绕的密室，追寻风声的指引。蜂巢评议专家专属卡片",
		"评议升级为专家评议",
		0,
		"11100103",
		""
	},
	{
		2202001,
		"默认",
		22,
		2,
		2,
		"{1100003:5000}",
		"1001001112",
		"1001001112",
		"zg_img_001",
		"",
		"主管的默认卡套",
		"初始拥有",
		0,
		"",
		""
	},
	{
		2202004,
		"云雾迷踪",
		22,
		2,
		3,
		"{1100003:5000}",
		"2202004",
		"2202004",
		"zg_img_004",
		"",
		"云雾缭绕的密室，追寻风声的指引。蜂巢评议专家专属卡套",
		"评议升级为专家评议",
		0,
		"11100103",
		""
	}
}
local t_item_display_card = {}

t_item_display_card.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_item_display_card[v[1]] = v

	setmetatable(v, mt)
end

return t_item_display_card
