-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_angel_investor_activity.lua

module("logicconfig.config.t_angel_investor_activity", package.seeall)

local title = {
	payTypePrizeCountAdd = 4,
	ruleKey = 13,
	payCardMoney = 12,
	payCardTip = 10,
	cardDecrMinute = 3,
	coinMatStr = 15,
	lockCardBottomTip = 17,
	goodsId = 11,
	activityId = 1,
	revivePower = 14,
	dailyStageCount = 5,
	typeNameList = 8,
	storyId = 9,
	unLockCardBottomTip = 16,
	systemPetPlanId = 6,
	cardShopItemId = 2,
	buffCounterId = 7
}
local dataList = {
	{
		588001,
		99588001,
		20,
		3,
		4,
		1,
		20072403,
		{
			"精灵养成",
			"公共养成",
			"兑换代币"
		},
		4830006,
		"红星碎片+100%，神器币+50%，其余+30%，挂机时间-20分钟，每个大类下的奖励可领数量+3",
		"rmb_12",
		12,
		"angel_investor_rule",
		10,
		"1004:1633:1",
		"每个道具底部的数量为剩余可领数量，目前已激活高级卡，红星碎片+100%，神器币+50%，其余+30%！",
		"道具底部的数量为剩余可领数量，激活高级卡后红星碎片+100%，神器币+50%，其余+30%；且每次可选奖励数量增加！"
	}
}
local t_angel_investor_activity = {
	[588001] = dataList[1]
}

t_angel_investor_activity.dataList = dataList

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

return t_angel_investor_activity
