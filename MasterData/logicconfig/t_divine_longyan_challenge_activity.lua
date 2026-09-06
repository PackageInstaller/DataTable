-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_longyan_challenge_activity.lua

module("logicconfig.config.t_divine_longyan_challenge_activity", package.seeall)

local title = {
	jumpStrOne = 4,
	skinId = 9,
	supportPetId = 3,
	jumpStrThree = 6,
	lineStageRuleDesc = 12,
	powerStageRuleDesc = 11,
	jumpStrTwo = 5,
	costMp = 13,
	redPointId = 2,
	jumpStrFive = 8,
	jumpStrFour = 7,
	ruleKeyMain = 10,
	activityId = 1
}
local dataList = {
	{
		355001,
		566,
		100001,
		"func#618#12018",
		"mibao#rexueguixin1",
		"func#375",
		"mibao#shenyaolibao",
		"func#545#1",
		12018,
		"divinelongyanmainview_rule",
		"1、活动期间力量领域每日5:00刷新三个平行关卡。\r\n2、力量领域中，每关可获得<color=#EB4642>【炽种】*80</color>。<color=#EB4642>【炽种】</color>用于助战精灵神曜龙炎升级。",
		"1、神曜领域设有12个线性关卡，需要通过上一关的挑战才能进入下一关。\r\n2、击败敌阵即记为通关，通关后自动发放奖励<color=#EB4642>【狂焰烈甲】</color>，通关后不可重复挑战。",
		"4:231"
	}
}
local t_divine_longyan_challenge_activity = {
	[355001] = dataList[1]
}

t_divine_longyan_challenge_activity.dataList = dataList

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

return t_divine_longyan_challenge_activity
