-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_shop_coupon.lua

module("logicconfig.config.t_activity_shop_coupon", package.seeall)

local title = {
	deductCount = 4,
	couponId = 1,
	discountCost = 6,
	deductMaterialType = 3,
	minCost = 5,
	couponName = 2
}
local dataList = {
	{
		1,
		"20神钻抵扣券",
		204,
		20,
		0,
		"10:219001:1"
	},
	{
		2,
		"50神钻抵扣券",
		204,
		50,
		0,
		"10:219002:1"
	},
	{
		3,
		"100神钻抵扣券",
		204,
		100,
		0,
		"10:219003:1"
	},
	{
		4,
		"20神钻抵扣券",
		204,
		20,
		0,
		"10:219004:1"
	},
	{
		5,
		"50神钻抵扣券",
		204,
		50,
		0,
		"10:219005:1"
	},
	{
		6,
		"100神钻抵扣券",
		204,
		100,
		0,
		"10:219006:1"
	},
	{
		7,
		"20神钻抵扣券",
		204,
		20,
		0,
		"10:219007:1"
	},
	{
		8,
		"50神钻抵扣券",
		204,
		50,
		0,
		"10:219008:1"
	},
	{
		9,
		"100神钻抵扣券",
		204,
		100,
		0,
		"10:219009:1"
	},
	{
		10,
		"20神钻抵扣券",
		204,
		20,
		0,
		"10:219010:1"
	},
	{
		11,
		"50神钻抵扣券",
		204,
		50,
		0,
		"10:219011:1"
	},
	{
		12,
		"100神钻抵扣券",
		204,
		100,
		0,
		"10:219012:1"
	},
	{
		13,
		"200神钻抵扣券",
		204,
		200,
		0,
		"10:219013:1"
	}
}
local t_activity_shop_coupon = {
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
	dataList[13]
}

t_activity_shop_coupon.dataList = dataList

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

return t_activity_shop_coupon
