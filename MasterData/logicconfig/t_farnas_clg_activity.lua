-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_farnas_clg_activity.lua

module("logicconfig.config.t_farnas_clg_activity", package.seeall)

local title = {
	extremeClgPrize = 2,
	skinId = 5,
	normalClgWinBaseScore = 3,
	jumpStrThree = 8,
	jumpStrOne = 6,
	ruleKeyNor = 11,
	jumpStrTwo = 7,
	ruleKeyExt = 12,
	redPointId = 4,
	norRuleDesc = 9,
	ruleKeyMain = 10,
	activityId = 1
}
local dataList = {
	{
		333001,
		"100:15021:1:1",
		25,
		544,
		15021,
		"func#618#15021",
		"mibao#huimiexinsheng2",
		"func#43#122",
		"1、成功击败敌阵<color=#4bf95c>+25</color>积分\r\n2、战斗中，我方精灵死亡1次<color=#EB4642>-2</color>分，精灵复活1次<color=#4bf95c>+2</color>分，闪避1次<color=#4bf95c>+5</color>分，最低为<color=#4bf95c>0</color>分\r\n3、敌阵可以重复挑战，不限次数，取本日最高分保存\r\n4、敌阵将在次日<color=#4bf95c>5:00</color>刷新",
		"farnasmainview_rule",
		"farnasnorview_rule",
		"farnasextview_rule"
	},
	{
		333002,
		"8:1:1000",
		25,
		649,
		15021,
		"func#618#15021",
		"mibao#huimiexinsheng2",
		"func#43#122",
		"1、成功击败敌阵<color=#4bf95c>+25</color>积分\r\n2、战斗中，我方精灵死亡1次<color=#EB4642>-2</color>分，精灵复活1次<color=#4bf95c>+2</color>分，闪避1次<color=#4bf95c>+5</color>分，最低为<color=#4bf95c>0</color>分\r\n3、敌阵可以重复挑战，不限次数，取本日最高分保存\r\n4、敌阵将在次日<color=#4bf95c>5:00</color>刷新",
		"farnasextview_rule",
		"farnasnorview_rule",
		"farnasextview_rule"
	}
}
local t_farnas_clg_activity = {
	[333001] = dataList[1],
	[333002] = dataList[2]
}

t_farnas_clg_activity.dataList = dataList

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

return t_farnas_clg_activity
