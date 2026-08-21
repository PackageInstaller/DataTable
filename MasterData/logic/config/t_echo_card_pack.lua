-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_echo_card_pack.lua

module("logic.config.t_echo_card_pack", package.seeall)

local title = {
	reward = 6,
	name = 3,
	cost = 5,
	onlineEndTime = 8,
	goodsType = 2,
	bindActivityId = 9,
	goodsId = 1,
	icon = 4,
	onceMaxNum = 7
}
local dataList = {
	{
		17000001,
		17,
		"残响卡包",
		"cxkb_img_0004",
		"{1001001:1}",
		"{3700002:1}",
		0,
		nil,
		2
	}
}
local t_echo_card_pack = {}

t_echo_card_pack.dataList = dataList

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
	t_echo_card_pack[v[1]] = v

	setmetatable(v, mt)
end

return t_echo_card_pack
