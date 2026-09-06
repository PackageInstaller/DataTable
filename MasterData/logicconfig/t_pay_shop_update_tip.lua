-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_shop_update_tip.lua

module("logicconfig.config.t_pay_shop_update_tip", package.seeall)

local title = {
	id = 1,
	openTime = 2,
	desc = 3
}
local dataList = {
	{
		1,
		"时段|2022-10-28 05:00:00,2022-11-04 05:00:00",
		"10.28礼包更新！"
	},
	{
		2,
		"时段|2022-11-04 05:00:00,2022-11-11 05:00:00",
		"11.04礼包更新！"
	},
	{
		3,
		"时段|2022-11-11 05:00:00,2022-11-18 05:00:00",
		"双十一礼包更新！"
	},
	{
		4,
		"时段|2022-11-25 05:00:00,2022-12-02 05:00:00",
		"11.25礼包更新！"
	},
	{
		5,
		"时段|2022-12-02 05:00:00,2022-12-09 05:00:00",
		"12.02礼包更新！"
	},
	{
		6,
		"时段|2022-12-09 05:00:00,2022-12-23 05:00:00",
		"12.09礼包更新！"
	},
	{
		7,
		"时段|2022-12-23 05:00:00,2022-12-30 05:00:00",
		"12.23礼包更新！"
	},
	{
		8,
		"时段|2022-12-30 05:00:00,2023-01-06 05:00:00",
		"12.30礼包更新！"
	},
	{
		9,
		"时段|2023-01-06 05:00:00,2023-01-20 05:00:00",
		"01.06礼包更新！"
	}
}
local t_pay_shop_update_tip = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_pay_shop_update_tip.dataList = dataList

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

return t_pay_shop_update_tip
