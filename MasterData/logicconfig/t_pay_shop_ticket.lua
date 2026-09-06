-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_shop_ticket.lua

module("logicconfig.config.t_pay_shop_ticket", package.seeall)

local title = {
	duration = 5,
	afterGoodsIds = 4,
	id = 1,
	beforeGoodsIds = 3,
	price = 2
}
local dataList = {
	{
		1,
		1,
		"rmb_1",
		"none",
		48
	},
	{
		2,
		6,
		"rmb_18,rmb_12",
		"rmb_12,rmb_6",
		48
	},
	{
		3,
		12,
		"rmb_30,rmb_40",
		"rmb_18,rmb_28",
		48
	},
	{
		4,
		15,
		"rmb_40,rmb_45,rmb_60",
		"rmb_25,rmb_30,rmb_45",
		48
	}
}
local t_pay_shop_ticket = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_pay_shop_ticket.dataList = dataList

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

return t_pay_shop_ticket
