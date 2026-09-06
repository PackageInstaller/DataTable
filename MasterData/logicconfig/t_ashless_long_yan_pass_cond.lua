-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ashless_long_yan_pass_cond.lua

module("logicconfig.config.t_ashless_long_yan_pass_cond", package.seeall)

local title = {
	condKey = 1,
	resultTitle = 2,
	desc = 3
}
local dataList = {
	{
		"Survive",
		"当前精灵存活数：%s",
		"我方挑战成功精灵存活%s只"
	},
	{
		"Round",
		"当前胜利回合数：%s",
		"我方挑战成功回合数为%s回合内"
	},
	{
		"BuffCount",
		"敌阵受暴击次数：%s",
		"敌方精灵受到暴击伤害%s次"
	}
}
local t_ashless_long_yan_pass_cond = {
	Survive = dataList[1],
	Round = dataList[2],
	BuffCount = dataList[3]
}

t_ashless_long_yan_pass_cond.dataList = dataList

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

return t_ashless_long_yan_pass_cond
