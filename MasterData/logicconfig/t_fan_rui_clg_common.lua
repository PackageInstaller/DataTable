-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fan_rui_clg_common.lua

module("logicconfig.config.t_fan_rui_clg_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"FANRUI_DESC1",
		"克制攻击次数"
	},
	{
		"FANRUI_DESC2",
		"精灵存活数"
	},
	{
		"FANRUI_DESC3",
		"首杀敌阵站位"
	},
	{
		"FANRUI_DESC4",
		"先完成通关条件预测，达成三项预测即通关"
	},
	{
		"FANRUI_DESC5",
		"1、敌阵中的部分精灵带有特殊的加成，强化所在敌阵的实力。\r\n2、进入战斗前，可以随意调整敌阵精灵站位。\r\n3、挑战某个敌阵胜利后，已经使用过的精灵将被锁定。\r\n4、关卡中的3个敌阵均挑战成功即获得本关奖励并进入下一关。"
	}
}
local t_fan_rui_clg_common = {
	FANRUI_DESC1 = dataList[1],
	FANRUI_DESC2 = dataList[2],
	FANRUI_DESC3 = dataList[3],
	FANRUI_DESC4 = dataList[4],
	FANRUI_DESC5 = dataList[5]
}

t_fan_rui_clg_common.dataList = dataList

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

return t_fan_rui_clg_common
