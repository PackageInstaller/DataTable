-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_monopoly_sale.lua

module("logicconfig.config.t_monopoly_sale", package.seeall)

local title = {
	giftContent = 5,
	startTime = 9,
	endTime = 10,
	payGoodsId = 3,
	tabName = 11,
	maxBuyTimes = 8,
	giftId = 2,
	mailDay = 7,
	mailContent = 6,
	activityId = 1,
	starPrize = 4
}
local dataList = {
	{
		84001,
		1,
		"rmb_25",
		"18:503:1",
		"4:503:255#8:1:1100000",
		"104:2:100",
		7,
		1,
		"2020-10-29T05:00:00",
		"2020-11-26T05:00:00",
		"生命星神"
	},
	{
		84001,
		2,
		"rmb_25",
		"18:504:1",
		"4:503:255#8:1:1100000",
		"104:2:100",
		7,
		1,
		"2020-11-05T05:00:00",
		"2020-11-26T05:00:00",
		"暴击星神"
	},
	{
		84001,
		3,
		"rmb_25",
		"18:506:1",
		"4:503:255#8:1:1100000",
		"104:2:100",
		7,
		1,
		"2020-11-12T05:00:00",
		"2020-11-26T05:00:00",
		"命中星神"
	},
	{
		84001,
		4,
		"rmb_25",
		"18:507:1",
		"4:503:255#8:1:1100000",
		"104:2:100",
		7,
		1,
		"2020-11-19T05:00:00",
		"2020-11-26T05:00:00",
		"闪避星神"
	}
}
local t_monopoly_sale = {
	[84001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_monopoly_sale.dataList = dataList

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

return t_monopoly_sale
