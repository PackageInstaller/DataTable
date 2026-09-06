-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_expirable_item.lua

module("logicconfig.config.t_expirable_item", package.seeall)

local title = {
	expiredRefund = 8,
	quality = 3,
	name = 2,
	dailyLimit = 9,
	startDecTime = 6,
	desc = 4,
	globalExpiredTime = 7,
	id = 1,
	icon = 5
}
local dataList = {
	{
		1,
		82001029,
		4,
		"可以在秘宝商城中，直接抵扣48神钻，若购买不足48神钻的商品，则可直接以1金币的价格购买。自获得之日起，限时30天内可使用。将于2023-12-29 5:00过期。",
		"icon_nianfei_dikouquan",
		"2022-12-30T05:00:00",
		"2023-12-29T05:00:00",
		"8:1:10000",
		100
	},
	{
		2,
		82001029,
		4,
		"可以在秘宝商城中，直接抵扣48神钻，若购买不足48神钻的商品，则可直接以1金币的价格购买。自获得之日起，限时30天内可使用。将于2024-12-27 5:00过期。",
		"icon_nianfei_dikouquan",
		"2024-01-01T05:00:00",
		"2024-12-27T05:00:00",
		"8:1:10000",
		100
	},
	{
		3,
		82001029,
		4,
		"可以在秘宝商城中，直接抵扣48神钻，若购买不足48神钻的商品，则可直接以1金币的价格购买。自获得之日起，限时30天内可使用。将于2026-02-01 5:00过期。",
		"icon_nianfei_dikouquan",
		"2025-01-01T05:00:00",
		"2026-02-01T05:00:00",
		"8:1:10000",
		100
	},
	{
		4,
		82001029,
		4,
		"可以在秘宝商城中，直接抵扣48神钻，若购买不足48神钻的商品，则可直接以1金币的价格购买。自获得之日起，限时30天内可使用。将于2027-02-01 5:00过期。",
		"icon_nianfei_dikouquan",
		"2026-01-01T05:00:00",
		"2027-02-01T05:00:00",
		"8:1:10000",
		100
	}
}
local t_expirable_item = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_expirable_item.dataList = dataList

local multiLanguageCells = {
	name = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_expirable_item
