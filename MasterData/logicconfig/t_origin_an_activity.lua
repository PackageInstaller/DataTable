-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_an_activity.lua

module("logicconfig.config.t_origin_an_activity", package.seeall)

local title = {
	extremeClgPrize = 2,
	jumpStrOne = 7,
	jumpStrThree = 9,
	skinId = 6,
	jumpStrFour = 10,
	jumpRedIdThree = 13,
	jumpStrTwo = 8,
	jumpRedIdTwo = 12,
	jumpRedIdFour = 14,
	blockHealTimesBuffId = 3,
	jumpRedIdOne = 11,
	normalRuleTips = 15,
	singleBuffDizzyTimes = 4,
	ruleKeyMain = 5,
	activityId = 1
}
local dataList = {
	{
		589001,
		"4:510776:100",
		30000101,
		1,
		"originanmainview_rule",
		15044,
		"event#gotofirstpassrankview#589001",
		"func#618#15044",
		"mibao#jinglingyangcheng",
		"ui#lottery",
		"",
		"",
		"",
		"",
		"1、每日5:00更新敌阵，使用背包精灵，系统属性进行战斗\r\n2、破阵后，记录敌阵今日最高禁疗次数\r\n3、活动期间，累计禁疗总次数达标即可领取对应的进度奖励"
	}
}
local t_origin_an_activity = {
	[589001] = dataList[1]
}

t_origin_an_activity.dataList = dataList

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

return t_origin_an_activity
