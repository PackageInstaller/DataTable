-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_yu_hui_clg_stage.lua

module("logicconfig.config.t_divine_yu_hui_clg_stage", package.seeall)

local title = {
	stageRule = 4,
	stageBuffDesc = 5,
	stageId = 2,
	name = 6,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		499001,
		1,
		1003,
		"破阵成功后本关上阵过的精灵，则敌阵会携带本关卡暴食效果",
		"敌方击杀己阵精灵时，会吸取被击败精灵50%的属性",
		"暴食"
	},
	{
		499001,
		2,
		1005,
		"破阵成功后本关上阵过的精灵，则敌阵会携带本关卡傲慢效果",
		"敌阵精灵免疫所有负面效果以及控制效果",
		"傲慢"
	},
	{
		499001,
		3,
		1006,
		"破阵成功后本关上阵过的精灵，则敌阵会携带本关卡嫉妒效果",
		"敌阵精灵获得80%全属性提升",
		"嫉妒"
	},
	{
		499001,
		4,
		1001,
		"破阵成功后本关上阵过的精灵，则敌阵会携带本关卡暴怒效果",
		"敌阵精灵获得50%伤害加成",
		"暴怒"
	},
	{
		499001,
		5,
		1002,
		"破阵成功后本关上阵过的精灵，则敌阵会携带本关卡色域效果",
		"进入战斗时，使己阵攻击最高的2只精灵混乱",
		"色域"
	},
	{
		499001,
		6,
		1004,
		"破阵成功后本关上阵过的精灵，则敌阵会携带本关卡懒惰效果",
		"令己阵攻击力最高的2只精灵眩晕1个回合",
		"懒惰"
	},
	{
		499001,
		7,
		1007,
		"破阵成功后本关上阵过的精灵，则敌阵会携带本关卡贪婪效果",
		"敌阵精灵攻击时会吸取30点气势",
		"贪婪"
	}
}
local t_divine_yu_hui_clg_stage = {
	[499001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_divine_yu_hui_clg_stage.dataList = dataList

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

return t_divine_yu_hui_clg_stage
