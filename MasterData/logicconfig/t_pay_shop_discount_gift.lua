-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_shop_discount_gift.lua

module("logicconfig.config.t_pay_shop_discount_gift", package.seeall)

local title = {
	gift = 3,
	name = 4,
	activityId = 1,
	giftId = 2
}
local dataList = {
	{
		117001,
		1,
		"4:97001:3",
		"200神钻优惠券"
	},
	{
		117001,
		2,
		"4:97002:4",
		"100神钻优惠券"
	},
	{
		117001,
		3,
		"4:97003:5",
		"50神钻优惠券"
	},
	{
		117002,
		1,
		"4:97001:1",
		"200神钻优惠券"
	},
	{
		117002,
		2,
		"4:97002:2",
		"100神钻优惠券"
	},
	{
		117002,
		3,
		"4:97003:3",
		"50神钻优惠券"
	},
	{
		117003,
		1,
		"4:97015:1",
		"200神钻优惠券"
	},
	{
		117003,
		2,
		"4:97016:1",
		"100神钻优惠券"
	},
	{
		117003,
		3,
		"4:97017:2",
		"50神钻优惠券"
	},
	{
		117004,
		1,
		"4:97015:1",
		"200神钻优惠券"
	},
	{
		117004,
		2,
		"4:97016:1",
		"100神钻优惠券"
	},
	{
		117004,
		3,
		"4:97017:2",
		"50神钻优惠券"
	},
	{
		117005,
		1,
		"4:97018:1",
		"200神钻优惠券"
	},
	{
		117005,
		2,
		"4:97019:1",
		"100神钻优惠券"
	},
	{
		117005,
		3,
		"4:97020:2",
		"50神钻优惠券"
	},
	{
		117006,
		1,
		"4:97018:1",
		"200神钻优惠券"
	},
	{
		117006,
		2,
		"4:97019:1",
		"100神钻优惠券"
	},
	{
		117006,
		3,
		"4:97020:2",
		"50神钻优惠券"
	}
}
local t_pay_shop_discount_gift = {
	[117001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[117002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[117003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[117004] = {
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[117005] = {
		dataList[13],
		dataList[14],
		dataList[15]
	},
	[117006] = {
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_pay_shop_discount_gift.dataList = dataList

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

return t_pay_shop_discount_gift
