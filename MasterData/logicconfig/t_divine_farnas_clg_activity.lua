-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_farnas_clg_activity.lua

module("logicconfig.config.t_divine_farnas_clg_activity", package.seeall)

local title = {
	skinId = 5,
	jumpTo2 = 12,
	ruleDescNor = 10,
	ruleKeyExt = 8,
	jumpTo4 = 14,
	ruleDescExt = 9,
	ruleKeyNor = 7,
	jumpTo3 = 13,
	normalSignBuffId = 4,
	jumpTo5 = 15,
	redPointId = 3,
	jumpTo1 = 11,
	ruleKeyMain = 6,
	activityId = 1,
	extremePrize = 2
}
local dataList = {
	{
		522001,
		"4:510608:100",
		731,
		20052502,
		15037,
		"divinefarnasextview_mainRule",
		"divinefarnasextview_quanminRule",
		"divinefarnasextview_jixianRule",
		"1、毁灭关卡破阵即为通关，新生关卡需破阵且闪避达标\r\n2、根据毁灭关卡中存活精灵的数量，激活新生关卡中不同的加成，<color=#52D7A2FF>同一只精灵在多个关卡存活只算1次</color>，不累加\r\n3、<color=#52D7A2FF>敌阵效果</color>\r\n★敌阵命中率+100%\r\n★敌阵攻击后提高自身及除自身外站位最靠前的存活精灵40%闪避率(可叠加3次,持续1次攻击)\r\n★每次攻击令目标无法复活(1回合)且降低60%治疗量(1回合)",
		"1、每日5：00刷新3个敌阵，使用系统属性进行挑战\r\n2、成功破阵后，记录每日每关己阵的最高闪避次数\r\n3、活动期间，累积闪避次数达标即可领取进度奖励",
		"func#618#15037",
		"ui#lottery",
		"mibao#MibaoShop",
		"func#43#140",
		"event#gotofirstpassrankview#522001"
	}
}
local t_divine_farnas_clg_activity = {
	[522001] = dataList[1]
}

t_divine_farnas_clg_activity.dataList = dataList

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

return t_divine_farnas_clg_activity
