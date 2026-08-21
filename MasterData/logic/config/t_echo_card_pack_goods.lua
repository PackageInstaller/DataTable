-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_echo_card_pack_goods.lua

module("logic.config.t_echo_card_pack_goods", package.seeall)

local title = {
	reward = 7,
	name = 3,
	sortIndex = 10,
	onceMaxNum = 8,
	onlineEndTime = 11,
	cost = 5,
	quality = 9,
	bindActivityLogic = 12,
	goodsType = 2,
	bindActivityConfig = 13,
	goodsId = 1,
	icon = 4,
	exchangeable = 6
}
local dataList = {
	{
		17000001,
		17,
		"常驻残响卡包",
		"echopack_store_1013001",
		"{1100002:400}",
		false,
		"{1013001:1}",
		999,
		1,
		1,
		nil,
		0,
		0
	},
	{
		17000002,
		17,
		"限定：狂妄之智",
		"echopack_store_1013002",
		"{1100002:400}",
		true,
		"{1013002:1}",
		999,
		1,
		1,
		nil,
		1,
		1002
	},
	{
		17000003,
		17,
		"限定：映铁雷光",
		"echopack_store_1013003",
		"{1100002:400}",
		true,
		"{1013003:1}",
		999,
		1,
		1,
		nil,
		1,
		1003
	}
}
local t_echo_card_pack_goods = {}

t_echo_card_pack_goods.dataList = dataList

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
	t_echo_card_pack_goods[v[1]] = v

	setmetatable(v, mt)
end

return t_echo_card_pack_goods
