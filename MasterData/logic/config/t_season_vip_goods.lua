-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_season_vip_goods.lua

module("logic.config.t_season_vip_goods", package.seeall)

local title = {
	goodsType = 2,
	name = 3,
	onlineEndTime = 6,
	type = 4,
	goodsId = 1,
	icon = 5,
	bindActivityLogic = 7,
	bindActivityConfig = 8
}
local dataList = {
	{
		16100001,
		12,
		"vip1",
		1,
		"shop_cf_1",
		nil,
		0,
		0
	},
	{
		16100002,
		12,
		"vip1-2",
		2,
		"shop_cf_1",
		nil,
		0,
		0
	},
	{
		16100003,
		12,
		"vip2",
		3,
		"shop_cf_1",
		nil,
		0,
		0
	}
}
local t_season_vip_goods = {}

t_season_vip_goods.dataList = dataList

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
	t_season_vip_goods[v[1]] = v

	setmetatable(v, mt)
end

return t_season_vip_goods
