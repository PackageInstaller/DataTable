-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_month_card_pack.lua

module("logicconfig.config.t_month_card_pack", package.seeall)

local title = {
	jumpToGoldenDiamondCard = 7,
	activityId = 1,
	jumpToResMonthCard = 9,
	payGoodsId = 3,
	addGoldenDiamondCard = 6,
	limit = 5,
	maxBuyTimes = 4,
	jumpToMonthCard = 8,
	cardIds = 2
}
local dataList = {
	{
		150001,
		{
			1,
			3
		},
		"rmb_45",
		1,
		5000,
		true,
		"mibao#GoldenDiamondCard",
		"mibao#MonthCard",
		"mibao#ResMonthCard"
	},
	{
		150002,
		{
			1,
			3
		},
		"rmb_45",
		1,
		1000,
		true,
		"mibao#GoldenDiamondCard",
		"mibao#MonthCard",
		"mibao#ResMonthCard"
	},
	{
		150003,
		{
			6,
			6
		},
		"rmb_45",
		1,
		0,
		false,
		"mibao#GoldenDiamondCard",
		"mibao#MonthCard",
		"mibao#ResMonthCard"
	},
	{
		150004,
		{
			6,
			7
		},
		"rmb_45",
		1,
		4000,
		true,
		"mibao#GoldenDiamondCard",
		"mibao#MonthCard2022",
		"mibao#ResMonthCard2022"
	}
}
local t_month_card_pack = {
	[150001] = dataList[1],
	[150002] = dataList[2],
	[150003] = dataList[3],
	[150004] = dataList[4]
}

t_month_card_pack.dataList = dataList

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

return t_month_card_pack
