-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wisdom_courage_clg_boss_buff.lua

module("logicconfig.config.t_wisdom_courage_clg_boss_buff", package.seeall)

local title = {
	buffDesc = 3,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		456001,
		1,
		"祝福效果：技能命中目标后，额外造成攻击<color=#C54949>20%的伤害</color>"
	},
	{
		456001,
		2,
		"祝福效果：超杀伤害<color=#C54949>+20%</color>"
	},
	{
		456001,
		3,
		"祝福效果：攻击目标时，若对方被自己克制，伤害<color=#C54949>+40%</color>"
	},
	{
		456001,
		4,
		"祝福效果：攻击后有100%的概率额外出手一次（每轮最多额外出手1次）"
	},
	{
		456001,
		5,
		"祝福效果：全属性<color=#C54949>+100%</color>"
	}
}
local t_wisdom_courage_clg_boss_buff = {
	[456001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_wisdom_courage_clg_boss_buff.dataList = dataList

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

return t_wisdom_courage_clg_boss_buff
