-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_of_radiant_gold_activity.lua

module("logicconfig.config.t_king_of_radiant_gold_activity", package.seeall)

local title = {
	jumpStrOne = 10,
	jumpStrThree = 12,
	jumpStrFour = 13,
	skinId = 8,
	petPrize = 3,
	jumpRedIdOne = 14,
	jumpStrTwo = 11,
	scoreLimit = 4,
	xunzhangItem = 7,
	jumpRedIdTwo = 15,
	redPointId = 2,
	jumpRedIdThree = 16,
	fuwenItem = 6,
	ruleKeyMain = 9,
	activityId = 1,
	buffOpenTime = 5
}
local dataList = {
	{
		462001,
		682,
		"100:12030:1:1",
		20000,
		"2025-04-06T05:00:00",
		"1004:1436",
		"1004:1437",
		12030,
		"canjinlongzun_rule_main",
		"func#618#12030",
		"mibao#shuangjiekuanghuan3",
		"func#545#25",
		"mibao#Skin",
		"",
		"",
		""
	}
}
local t_king_of_radiant_gold_activity = {
	[462001] = dataList[1]
}

t_king_of_radiant_gold_activity.dataList = dataList

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

return t_king_of_radiant_gold_activity
