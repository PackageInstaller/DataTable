-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_hero_skin_goods.lua

module("logic.config.t_hero_skin_goods", package.seeall)

local title = {
	goodsId = 1,
	name = 3,
	bindActivityLogic = 13,
	skinId = 7,
	bindActivityConfig = 14,
	discountEndTime = 11,
	desc = 17,
	goodsType = 2,
	tag = 16,
	icon = 6,
	cost = 5,
	isOnline = 4,
	sortIndex = 15,
	onlineEndTime = 12,
	discountCost = 8,
	discount = 9,
	discountStartTime = 10
}
local dataList = {
	{
		15000001,
		15,
		"皮肤1",
		true,
		"{1100001:60}",
		"role_3to2_dlx",
		1500005,
		"{1100001:6}",
		10,
		"2022-08-01T05:00:00",
		"2022-12-23T05:00:00",
		nil,
		0,
		0,
		1,
		1,
		"老铁的皮肤1"
	},
	{
		15000002,
		15,
		"皮肤2",
		false,
		"{1100001:70}",
		"role_3to2_dlx",
		1500011,
		"",
		0,
		nil,
		nil,
		nil,
		0,
		0,
		1,
		0,
		"老铁的皮肤2"
	},
	{
		15000003,
		15,
		"皮肤3",
		true,
		"{1100001:80}",
		"role_3to2_dlx",
		1500012,
		"{1100001:40}",
		50,
		"2021-08-01T05:00:00",
		"2021-08-12T05:00:00",
		nil,
		0,
		0,
		1,
		0,
		"老铁的皮肤3"
	},
	{
		15000004,
		15,
		"皮肤4",
		true,
		"{1100001:90}",
		"role_3to2_dlx",
		1500013,
		"",
		0,
		nil,
		nil,
		nil,
		0,
		0,
		1,
		1,
		"老铁的皮肤4"
	},
	{
		15000005,
		15,
		"皮肤5",
		true,
		"{1100001:100}",
		"role_3to2_dlx",
		1500019,
		"",
		0,
		nil,
		nil,
		nil,
		0,
		0,
		1,
		1,
		"老铁的皮肤5"
	},
	{
		15000006,
		15,
		"皮肤6",
		true,
		"{1100001:110}",
		"role_3to2_fn",
		1500021,
		"",
		0,
		nil,
		nil,
		nil,
		0,
		0,
		1,
		0,
		"老铁的皮肤6"
	},
	{
		15000007,
		15,
		"皮肤7",
		true,
		"{1100001:120}",
		"role_3to2_fn",
		1505601,
		"",
		0,
		nil,
		nil,
		nil,
		0,
		0,
		1,
		1,
		"老铁的皮肤7"
	},
	{
		15000008,
		15,
		"皮肤8",
		true,
		"{1100001:130}",
		"role_3to2_fn",
		1505602,
		"",
		0,
		nil,
		nil,
		nil,
		0,
		0,
		1,
		1,
		"老铁的皮肤8"
	},
	{
		15000009,
		15,
		"皮肤9",
		true,
		"{1100001:140}",
		"role_3to2_fn",
		1505603,
		"{1100001:6}",
		10,
		"2022-08-01T05:00:00",
		"2023-08-12T05:00:00",
		nil,
		0,
		0,
		1,
		0,
		"老铁的皮肤9"
	},
	{
		15000010,
		15,
		"皮肤10",
		false,
		"{1100001:150}",
		"role_3to2_mx",
		1505604,
		"",
		0,
		nil,
		nil,
		nil,
		0,
		0,
		1,
		1,
		"老铁的皮肤10"
	},
	{
		15000011,
		15,
		"皮肤11",
		true,
		"{1100001:160}",
		"role_3to2_mx",
		1505605,
		"{1100001:40}",
		50,
		"2021-08-01T05:00:00",
		"2021-08-12T05:00:00",
		nil,
		0,
		0,
		1,
		0,
		"老铁的皮肤11"
	},
	{
		15000012,
		15,
		"皮肤12",
		true,
		"{1100001:170}",
		"role_3to2_mx",
		1505606,
		"",
		0,
		nil,
		nil,
		nil,
		0,
		0,
		1,
		1,
		"老铁的皮肤12"
	}
}
local t_hero_skin_goods = {}

t_hero_skin_goods.dataList = dataList

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
	t_hero_skin_goods[v[1]] = v

	setmetatable(v, mt)
end

return t_hero_skin_goods
