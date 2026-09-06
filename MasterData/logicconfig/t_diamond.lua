-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_diamond.lua

module("logicconfig.config.t_diamond", package.seeall)

local title = {
	name = 2,
	dailyLimit = 5,
	quality = 3,
	effect = 9,
	source = 7,
	desc = 10,
	maxQuantity = 4,
	id = 1,
	icon = 6,
	showLimit = 8
}
local dataList = {
	{
		1,
		"钻石",
		4,
		999999999,
		99999999,
		"icon_zuanshi",
		"50,51,7,31",
		0,
		"",
		"十分稀有的宝石，只要你拥有足够多的数量，就可以兑换到奥奇世界最珍贵的商品。"
	},
	{
		2,
		"钻石",
		4,
		999999999,
		99999999,
		"icon_zuanshisuo",
		"50,51,7,31",
		0,
		"",
		"十分稀有的宝石，只要你拥有足够多的数量，就可以兑换到奥奇世界最珍贵的商品。"
	}
}
local t_diamond = {
	dataList[1],
	dataList[2]
}

t_diamond.dataList = dataList

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

return t_diamond
