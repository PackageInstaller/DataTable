-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_linkage_lottery.lua

module("logicconfig.config.t_linkage_lottery", package.seeall)

local title = {
	buyPlanId = 3,
	dailyLimit = 7,
	randDecNum = 5,
	jumpTo = 8,
	randDec = 4,
	caption = 10,
	text = 9,
	startLimitDay = 6,
	lotteryPlanId = 2,
	activityId = 1
}
local dataList = {
	{
		229001,
		1,
		1,
		"10:229001",
		2,
		5,
		200,
		"mibao#Pifu_quanbu",
		{
			"登陆奥奇传说H5签到获得兑换码",
			"选择【年费福利】按钮进入活动界面领取兑换码；前往奥奇传说手游，在兑换码界面输入兑换码，获得樱花币",
			"参与抽奖即可获得以下奖励：春水煎茶·伊丽莎白 x1、橙色装备宝箱 x1、神唤券 x5、召唤券 x5、金币 x50万、高级强化石 x80、超级星元 x75"
		},
		{
			"board_dhm_01",
			"board_dhm_05",
			"board_dhm_06"
		}
	},
	{
		229002,
		2,
		1,
		"10:229002",
		2,
		5,
		200,
		"mibao#Pifu_quanbu",
		{
			"登陆奥奇传说H5签到获得兑换码",
			"选择【年费福利】按钮进入活动界面领取兑换码；前往奥奇传说手游，在兑换码界面输入兑换码，获得樱花币",
			"参与抽奖即可获得以下奖励：萌狮幻想·小雅 x1、橙色装备宝箱 x1、高级精粹 x28、随机红色灵纹 x1、金币 x50万、高级强化石 x80、超级星元 x75"
		},
		{
			"board_dhm_01",
			"board_dhm_05",
			"board_dhm_06"
		}
	}
}
local t_linkage_lottery = {
	[229001] = dataList[1],
	[229002] = dataList[2]
}

t_linkage_lottery.dataList = dataList

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

return t_linkage_lottery
