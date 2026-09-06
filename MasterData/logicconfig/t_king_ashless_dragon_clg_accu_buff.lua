-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ashless_dragon_clg_accu_buff.lua

module("logicconfig.config.t_king_ashless_dragon_clg_accu_buff", package.seeall)

local title = {
	activityId = 1,
	count = 2,
	desc = 3
}
local dataList = {
	{
		440001,
		1,
		"敌阵受击后，对伤害来源造成自身攻击力*30%的毁灭伤害"
	},
	{
		440001,
		2,
		"敌阵受击后，对伤害来源造成自身攻击力*30%的毁灭伤害，触发2次"
	},
	{
		440001,
		3,
		"敌阵受击后，对伤害来源造成自身攻击力*30%的毁灭伤害，触发3次"
	},
	{
		440001,
		4,
		"敌阵受击后，对伤害来源造成自身攻击力*30%的毁灭伤害，触发4次"
	},
	{
		440001,
		5,
		"敌阵受击后，对伤害来源造成自身攻击力*30%的毁灭伤害，触发5次"
	},
	{
		440001,
		6,
		"敌阵受击后，对伤害来源造成自身攻击力*30%的毁灭伤害，触发6次"
	},
	{
		440001,
		7,
		"敌阵受击后，对伤害来源造成自身攻击力*30%的毁灭伤害，触发7次"
	},
	{
		440001,
		8,
		"敌阵受击后，对伤害来源造成自身攻击力*30%的毁灭伤害，触发8次"
	},
	{
		440001,
		9,
		"敌阵受击后，对伤害来源造成自身攻击力*30%的毁灭伤害，触发9次"
	}
}
local t_king_ashless_dragon_clg_accu_buff = {
	[440001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_king_ashless_dragon_clg_accu_buff.dataList = dataList

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

return t_king_ashless_dragon_clg_accu_buff
