-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dishitian_challenge_common.lua

module("logicconfig.config.t_divine_dishitian_challenge_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"参数名",
		"值"
	},
	{
		"ACTIVITY_ID",
		"363001"
	},
	{
		"NORMAL_RULE_DESC",
		"1、每日5:00刷新全部敌阵，使用系统精灵与系统属性进行挑战\r\n2、己方的上阵要求均为随机，必须同时满足属性与职业条件才能上阵\r\n3、可消耗钻石将所有站位的要求重新随机"
	},
	{
		"EXTREME_RULE_DESC",
		"1、一层规则：敌阵镜像复制己阵精灵，敌阵精灵为系统属性\r\n2、二层规则：敌阵标记的精灵攻击对手后变身为对手并立刻出手一次\r\n3、三层规则：敌阵标记的精灵攻击对手后变身为对手并立刻出手一次，且首次死亡时复活\r\n4、成功破阵后，保存上阵精灵的血量，在本层进入新关卡时，延续上一轮战斗的血量"
	}
}
local t_divine_dishitian_challenge_common = {
	参数名 = dataList[1],
	ACTIVITY_ID = dataList[2],
	NORMAL_RULE_DESC = dataList[3],
	EXTREME_RULE_DESC = dataList[4]
}

t_divine_dishitian_challenge_common.dataList = dataList

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

return t_divine_dishitian_challenge_common
