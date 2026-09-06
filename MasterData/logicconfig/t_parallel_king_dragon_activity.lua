-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_parallel_king_dragon_activity.lua

module("logicconfig.config.t_parallel_king_dragon_activity", package.seeall)

local title = {
	paramStr = 2,
	ruleDesc = 4,
	activityId = 1,
	skinId = 3
}
local dataList = {
	{
		519001,
		"{\"jumpStr1\":\"event#gotofirstpassrankview#519001\",\"jumpStr2\":\"func#618#17024\",\"jumpStr3\":\"mibao#MibaoShop\",\"jumpStr4\":\"func#1271\",\"jumpStr5\":\"ui#lottery\"}",
		17024,
		"击败敌方所有敌人并且获得所有宝物。\r\n\r\n※宝物规则详情：\r\n1. 金币\r\n敌阵拥有效果：大回合结束时，令己阵随机1只精灵（优先死亡）清除负面后满血复活并提高30%全属性\r\n获得方式：若该精灵死亡时敌阵其他精灵均存活，则该宝物将会被获取，精灵拥有效果将消失\r\n\r\n2. 钻石\r\n敌阵精灵拥有效果：攻击时，令自身相邻的精灵获得100气势\r\n获取方式：该精灵超杀时该宝物将会被获取，精灵拥有效果将消失\r\n\r\n3. 翡翠\r\n敌阵精灵拥有效果：死亡时，清除负面后恢复满血并立即出手一次\r\n获取方式：该精灵受到相同属性攻击时该宝物将会被获取，精灵拥有效果将消失\r\n\r\n4.暗噬石\r\n敌阵精灵拥有效果：首次受到攻击时，吸收该伤害并立即出手一次（优先攻击伤害来源）\r\n获取方式：不可获得"
	}
}
local t_parallel_king_dragon_activity = {
	[519001] = dataList[1]
}

t_parallel_king_dragon_activity.dataList = dataList

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

return t_parallel_king_dragon_activity
