-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_gem.lua

module("logicconfig.config.t_god_gem", package.seeall)

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
		"神钻",
		5,
		999999999,
		99999999,
		"icon_shenzuanbenti",
		"230",
		0,
		"",
		"万中无一的宝石，极其珍贵，神钻可用来购买奥奇世界精灵、皮肤、礼包、坐骑、服装等大部分商品。"
	},
	{
		2,
		"神钻",
		5,
		999999999,
		99999999,
		"icon_shenzuanbenti",
		"230",
		0,
		"",
		"万中无一的宝石，极其珍贵，神钻可用来购买奥奇世界精灵、皮肤、礼包、坐骑、服装等大部分商品。"
	}
}
local t_god_gem = {
	dataList[1],
	dataList[2]
}

t_god_gem.dataList = dataList

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

return t_god_gem
