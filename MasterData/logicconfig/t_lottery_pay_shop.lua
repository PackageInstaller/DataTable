-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lottery_pay_shop.lua

module("logicconfig.config.t_lottery_pay_shop", package.seeall)

local title = {
	consume = 9,
	name = 5,
	itemIds = 3,
	viweBg = 8,
	funcId = 2,
	tag = 7,
	icon = 6,
	indexId = 1,
	isShow = 4
}
local dataList = {
	{
		1,
		421,
		{
			809,
			810,
			811
		},
		false,
		"1元特惠",
		"icon_shop_zhaohuanlibao02",
		"超值",
		"board_zhaohuanlibao_01.png",
		"4:36:1"
	}
}
local t_lottery_pay_shop = {
	dataList[1]
}

t_lottery_pay_shop.dataList = dataList

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

return t_lottery_pay_shop
