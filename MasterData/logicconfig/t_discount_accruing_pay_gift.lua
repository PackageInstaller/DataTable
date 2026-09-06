-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_discount_accruing_pay_gift.lua

module("logicconfig.config.t_discount_accruing_pay_gift", package.seeall)

local title = {
	times = 6,
	name = 3,
	giftId = 2,
	icon = 5,
	prize = 4,
	giftPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"超值传说三选一",
		"4:90061:1#104:2:300#8:8:5000",
		"icon_sslsxy",
		1
	},
	{
		1,
		2,
		"特惠神唤大礼包",
		"4:36:10#104:2:300#10:35013:100",
		"icon_shop_shenhuan3",
		1
	},
	{
		1,
		3,
		"装备提升大礼包",
		"4:90031:1#4:30003:20#8:1:1000000",
		"icon_shop_zb01",
		1
	}
}
local t_discount_accruing_pay_gift = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_discount_accruing_pay_gift.dataList = dataList

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

return t_discount_accruing_pay_gift
