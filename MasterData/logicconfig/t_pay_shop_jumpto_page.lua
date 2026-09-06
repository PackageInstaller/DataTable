-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_shop_jumpto_page.lua

module("logicconfig.config.t_pay_shop_jumpto_page", package.seeall)

local title = {
	funcId = 3,
	name = 4,
	bgName = 5,
	jumpTo = 6,
	rank = 2,
	redPoints = 8,
	id = 1,
	tabTypes = 7,
	tagDesc = 9
}
local dataList = {
	{
		1,
		2,
		0,
		"月卡",
		"board_rk_14",
		"mibao#GoldenDiamondCard",
		{
			5,
			7
		},
		{
			60,
			-31,
			-32,
			-33,
			-34,
			-35,
			-67,
			118,
			55
		},
		"强烈推荐"
	},
	{
		3,
		1,
		0,
		"直购商城",
		"board_rk_12",
		"mibao#Zhuoyanmixin",
		{
			1,
			8,
			9,
			10,
			20,
			21
		},
		{
			48
		},
		"版本特惠"
	},
	{
		4,
		4,
		0,
		"精灵直升",
		"board_rk_06_1",
		"func#463",
		nil,
		nil,
		"次数重置"
	},
	{
		5,
		5,
		0,
		"时装",
		"board_rk_03",
		"func#311",
		nil,
		nil,
		""
	},
	{
		6,
		3,
		0,
		"神钻&钻石",
		"board_rk_10",
		"mibao#GodDiamond",
		{
			16,
			17,
			19,
			7
		},
		{
			-36
		},
		""
	}
}
local t_pay_shop_jumpto_page = {
	dataList[1],
	[3] = dataList[2],
	[4] = dataList[3],
	[5] = dataList[4],
	[6] = dataList[5]
}

t_pay_shop_jumpto_page.dataList = dataList

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

return t_pay_shop_jumpto_page
