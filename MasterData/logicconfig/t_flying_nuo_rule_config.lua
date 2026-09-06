-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_flying_nuo_rule_config.lua

module("logicconfig.config.t_flying_nuo_rule_config", package.seeall)

local title = {
	id = 1,
	desc = 2
}
local dataList = {
	{
		1,
		"点击屏幕，可控制角色向上飞行"
	},
	{
		2,
		"开具使用无敌之翼，可获得无敌加速冲刺的效果"
	},
	{
		3,
		"可以捡到时光盾，获得后可以抵消一次伤害"
	},
	{
		4,
		"可以捡到积分药，可以立即增长对应的积分"
	},
	{
		5,
		"撞到障碍物，角色身体会闪烁，扣除一颗爱心"
	},
	{
		6,
		"当所有爱心消耗完毕时，游戏结束"
	}
}
local t_flying_nuo_rule_config = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_flying_nuo_rule_config.dataList = dataList

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

return t_flying_nuo_rule_config
