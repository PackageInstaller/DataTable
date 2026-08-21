-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_season_constant.lua

module("logic.config.t_season_constant", package.seeall)

local title = {
	strValue = 3,
	key = 1,
	numValue = 2,
	numValues = 4
}
local dataList = {
	{
		"MaxLv",
		999,
		""
	},
	{
		"VipMoney",
		1100001,
		""
	},
	{
		"Vip1",
		680,
		""
	},
	{
		"Vip2",
		1280,
		""
	},
	{
		"Vip2_1",
		600,
		""
	},
	{
		"Vip2GiveLv",
		20,
		""
	},
	{
		"UpgradePoint",
		1000,
		""
	},
	{
		"LvMoney",
		1100002,
		""
	},
	{
		"LvMoneyNum",
		150,
		""
	},
	{
		"SettleTaskId",
		80001000,
		""
	},
	{
		"SpecialLvInterval",
		5,
		""
	},
	{
		"LoopAddLv",
		10,
		""
	},
	{
		"Vip1GoodsId",
		16100001,
		""
	},
	{
		"UpgradeVip2GoodsId",
		16100002,
		""
	},
	{
		"Vip2GoodsId",
		16100003,
		""
	}
}
local t_season_constant = {}

t_season_constant.dataList = dataList

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
	t_season_constant[v[1]] = v

	setmetatable(v, mt)
end

return t_season_constant
