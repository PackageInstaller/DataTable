-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_empress_clg_activity_common.lua

module("logicconfig.config.t_empress_clg_activity_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"empress_normal_rule",
		"1、成功击败敌阵<color=#4bf95c>+10</color>积分\r\n2、战斗中，我方成功免疫1次攻击<color=#4bf95c>+2</color>分\r\n3、敌阵可以重复挑战，不限次数，取本日最高分保存\r\n4、敌阵将在次日<color=#4bf95c>5:00</color>刷新"
	},
	{
		"empress_extreme_rule",
		"1、布阵时可选择任意<color=#4bf95c>命途</color>作为本次挑战的强化效果\r\n2、通关后，<color=#4bf95c>已经使用的命途</color>不可在新的挑战中使用\r\n3、通关后，<color=#4bf95c>我方杀敌最多的精灵将被封印（相同数量则都封印）</color>，不可在新的挑战中使用"
	}
}
local t_empress_clg_activity_common = {
	empress_normal_rule = dataList[1],
	empress_extreme_rule = dataList[2]
}

t_empress_clg_activity_common.dataList = dataList

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

return t_empress_clg_activity_common
