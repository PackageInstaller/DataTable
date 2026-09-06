-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_exchange_level3tab_define.lua

module("logicconfig.config.t_exchange_level3tab_define", package.seeall)

local title = {
	preview = 13,
	redPointIds = 14,
	name = 5,
	jumpTo = 15,
	type = 1,
	level2Id = 2,
	activityIds = 17,
	isAllTimeLimitBuy = 20,
	startTime = 18,
	sellKey = 22,
	jobIds = 23,
	endTime = 19,
	viewName = 8,
	reportBehavior = 21,
	param = 9,
	jumpInTag = 6,
	activityType = 16,
	lockTip = 11,
	rank = 4,
	funcId = 7,
	id = 3,
	costMats = 10,
	ruleKey = 12
}
local dataList = {
	{
		3,
		1,
		1,
		1,
		"普通",
		"ExchangeJiazu",
		60,
		"baseexchangestack",
		"1",
		"8:5",
		"锁定",
		"duihuan_rule",
		true,
		nil,
		"",
		0,
		nil,
		"",
		"",
		false,
		0,
		""
	},
	{
		3,
		1,
		2,
		2,
		"高级",
		"ExchangeJiazu_High",
		60,
		"baseexchangestack",
		"13",
		"8:27",
		"锁定",
		"duihuan_rule",
		false,
		nil,
		"",
		0,
		nil,
		"",
		"",
		false,
		0,
		""
	},
	{
		3,
		1,
		3,
		3,
		"神柱之战",
		"ExchangeJiazu_Fight",
		60,
		"baseexchangestack",
		"20",
		"8:42",
		"锁定",
		"duihuan_rule",
		false,
		nil,
		"",
		0,
		nil,
		"",
		"",
		false,
		0,
		""
	},
	{
		3,
		7,
		1,
		1,
		"神秘币商店",
		"ExchangeExpedition_Low",
		52,
		"baseexchangestack",
		"7",
		"8:10#104:2",
		"锁定",
		"duihuan_rule",
		false,
		nil,
		"",
		0,
		nil,
		"",
		"",
		false,
		0,
		""
	},
	{
		3,
		7,
		2,
		2,
		"奥秘币商店",
		"ExchangeExpedition_Mid",
		52,
		"baseexchangestack",
		"21",
		"8:22",
		"锁定",
		"duihuan_rule",
		false,
		nil,
		"",
		0,
		nil,
		"",
		"",
		false,
		0,
		""
	},
	{
		3,
		7,
		3,
		3,
		"神器币商店",
		"ExchangeExpedition_High",
		52,
		"baseexchangestack",
		"12",
		"8:25#104:2",
		"锁定",
		"duihuan_rule",
		false,
		nil,
		"",
		0,
		nil,
		"",
		"",
		false,
		0,
		""
	}
}
local t_exchange_level3tab_define = {
	[3] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		[7] = {
			dataList[4],
			dataList[5],
			dataList[6]
		}
	}
}

t_exchange_level3tab_define.dataList = dataList

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

return t_exchange_level3tab_define
