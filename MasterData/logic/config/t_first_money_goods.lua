-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_first_money_goods.lua

module("logic.config.t_first_money_goods", package.seeall)

local title = {
	name = 3,
	quality = 6,
	sortIndex = 7,
	bindActivityLogic = 9,
	onlineEndTime = 8,
	bindActivityConfig = 10,
	exchangeNum = 5,
	goodsType = 2,
	goodsId = 1,
	icon = 4
}
local dataList = {
	{
		10100001,
		10,
		"超凡介质*6",
		"shop_cf_1",
		6,
		1,
		1,
		nil,
		0,
		0
	},
	{
		10100002,
		10,
		"超凡介质*30",
		"shop_cf_2",
		30,
		1,
		3,
		nil,
		0,
		0
	},
	{
		10100003,
		10,
		"超凡介质*68",
		"shop_cf_3",
		68,
		2,
		5,
		nil,
		0,
		0
	},
	{
		10100004,
		10,
		"超凡介质*128",
		"shop_cf_4",
		128,
		3,
		2,
		nil,
		0,
		0
	},
	{
		10100005,
		10,
		"超凡介质*328",
		"shop_cf_5",
		328,
		3,
		4,
		nil,
		0,
		0
	},
	{
		10100006,
		10,
		"超凡介质*648",
		"shop_cf_6",
		648,
		4,
		6,
		nil,
		0,
		0
	}
}
local t_first_money_goods = {}

t_first_money_goods.dataList = dataList

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
	t_first_money_goods[v[1]] = v

	setmetatable(v, mt)
end

return t_first_money_goods
