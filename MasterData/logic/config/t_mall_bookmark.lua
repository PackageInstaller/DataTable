-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_mall_bookmark.lua

module("logic.config.t_mall_bookmark", package.seeall)

local title = {
	name = 2,
	isOnline = 3,
	sortIndex = 4,
	prefab = 6,
	code = 1,
	className = 5
}
local dataList = {
	{
		1001,
		"超值活动",
		1,
		1,
		"StoreBannerView",
		"ui/views/store/store_super_value_panel.prefab"
	},
	{
		1002,
		"热卖榜单",
		1,
		2,
		"StoreHotListView",
		"ui/views/store/store_hot_list_panel.prefab"
	},
	{
		1003,
		"作战装束",
		0,
		3,
		"StoreSkinView",
		"ui/views/store/store_skin_panel.prefab"
	},
	{
		1004,
		"主题家居",
		0,
		4,
		"StoreFurnitureView",
		""
	},
	{
		1005,
		"补给礼包",
		1,
		5,
		"StoreGiftBagView",
		"ui/views/store/store_gift_bag_panel.prefab"
	},
	{
		1006,
		"专享兑换",
		1,
		6,
		"StoreExchangeView",
		"ui/views/store/store_exchange_panel.prefab"
	},
	{
		1007,
		"残响专供",
		1,
		7,
		"StoreExchangeView",
		"ui/views/store/store_exchange_panel.prefab"
	}
}
local t_mall_bookmark = {}

t_mall_bookmark.dataList = dataList

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
	t_mall_bookmark[v[1]] = v

	setmetatable(v, mt)
end

return t_mall_bookmark
