-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_order_clg.lua

module("logicconfig.config.t_divine_king_order_clg", package.seeall)

local title = {
	stageRule = 7,
	jumpStrTwo = 3,
	skinId = 6,
	jumpStrOne = 2,
	jumpStrThree = 4,
	ruleKeyMain = 5,
	activityId = 1
}
local dataList = {
	{
		357001,
		"func#618#11020",
		"mibao#xinqionglongming3",
		"ui#lottery",
		"divinekingordermainview_rule",
		11020,
		"1、<color=#88df6c>水龙魂效果</color>：\r\n★敌阵效果：己阵其他精灵超杀时，自身获得<color=#88df6c>50</color>气势并立即出手一次（每个大回合限1次）\r\n★己阵效果：敌阵全体全属性<color=#88df6c>+5%</color>，每增加<color=#88df6c>1</color>个，数值<color=#88df6c>+5%</color>，最多为<color=#88df6c>+125%</color>\r\n2、<color=#88df6c> 空龙魂效果</color>：\r\n★敌阵效果：己阵其他精灵超杀时，自身下次受到伤害降低<color=#88df6c>100%</color>并降低敌阵<color=#88df6c>15</color>点通灵进度\r\n★己阵效果：自身生命上限<color=#88df6c>-33%</color>，每增加<color=#88df6c>1</color>个，数值<color=#88df6c>-33%</color>，最多为<color=#88df6c>-99%</color>"
	},
	{
		357002,
		"func#618#11020",
		"mibao#xinqionglongming3",
		"ui#lottery",
		"divinekingordermainview_rule1",
		11020,
		"1、<color=#88df6c>水龙魂效果</color>：\r\n★敌阵效果：己阵其他精灵超杀时，自身获得<color=#88df6c>50</color>气势并立即出手一次（每个大回合限1次）\r\n★己阵效果：敌阵全体全属性<color=#88df6c>+5%</color>，每增加<color=#88df6c>1</color>个，数值<color=#88df6c>+5%</color>，最多为<color=#88df6c>+125%</color>\r\n2、<color=#88df6c> 空龙魂效果</color>：\r\n★敌阵效果：己阵其他精灵超杀时，自身下次受到伤害降低<color=#88df6c>100%</color>并降低敌阵<color=#88df6c>15</color>点通灵进度\r\n★己阵效果：自身生命上限<color=#88df6c>-33%</color>，每增加<color=#88df6c>1</color>个，数值<color=#88df6c>-33%</color>，最多为<color=#88df6c>-99%</color>"
	}
}
local t_divine_king_order_clg = {
	[357001] = dataList[1],
	[357002] = dataList[2]
}

t_divine_king_order_clg.dataList = dataList

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

return t_divine_king_order_clg
