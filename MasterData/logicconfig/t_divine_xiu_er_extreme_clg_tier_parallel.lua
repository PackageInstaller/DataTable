-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xiu_er_extreme_clg_tier_parallel.lua

module("logicconfig.config.t_divine_xiu_er_extreme_clg_tier_parallel", package.seeall)

local title = {
	parallelId = 1,
	ruleDesc = 2
}
local dataList = {
	{
		1,
		"1、非之目标：<color=#f6de9e>我方全体精灵阵亡</color>时，敌方剩余精灵数量达到目标即可通关<color=#f6de9e>（我方必须先击败敌方一定数量的精灵）</color>\r\n2、通关本层所有关卡即可解锁下一层关卡"
	},
	{
		2,
		"1、是之目标：击败敌阵时，我方精灵存活数达到目标即可通关\r\n2、通关本层所有关卡即可解锁下一层关卡"
	}
}
local t_divine_xiu_er_extreme_clg_tier_parallel = {
	dataList[1],
	dataList[2]
}

t_divine_xiu_er_extreme_clg_tier_parallel.dataList = dataList

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

return t_divine_xiu_er_extreme_clg_tier_parallel
