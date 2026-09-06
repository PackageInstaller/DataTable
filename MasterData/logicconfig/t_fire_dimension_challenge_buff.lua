-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fire_dimension_challenge_buff.lua

module("logicconfig.config.t_fire_dimension_challenge_buff", package.seeall)

local title = {
	buffId = 1,
	desc = 2
}
local dataList = {
	{
		1,
		"进入战斗时，敌阵损失50%生命值"
	},
	{
		2,
		"进入战斗时，敌阵损失20%生命值"
	},
	{
		3,
		"进入战斗时，敌阵损失1%生命值"
	},
	{
		4,
		"己阵命中率+20%"
	},
	{
		5,
		"己阵暴击率+20%"
	},
	{
		6,
		"己阵闪避率+20%"
	},
	{
		7,
		"己阵对受伤精灵伤害加深20%"
	},
	{
		8,
		"己阵攻击时降低目标20点气势"
	},
	{
		9,
		"己阵受到的群攻伤害降低20%"
	},
	{
		10,
		"己阵造成的群攻伤害增加20%"
	},
	{
		11,
		"己阵超杀后免疫1次攻击"
	},
	{
		12,
		"己阵超杀后眩晕敌阵气势最高的目标"
	},
	{
		13,
		"敌阵命中率+20%"
	},
	{
		14,
		"敌阵暴击率+20%"
	},
	{
		15,
		"敌阵闪避率+20%"
	},
	{
		16,
		"敌阵对受伤精灵伤害加深20%"
	},
	{
		17,
		"敌阵攻击时降低目标20点气势"
	},
	{
		18,
		"敌阵受到的群攻伤害降低20%"
	},
	{
		19,
		"敌阵造成的群攻伤害增加20%"
	},
	{
		20,
		"敌阵超杀后免疫1次攻击"
	},
	{
		21,
		"敌阵超杀后眩晕己阵气势最高的目标"
	},
	{
		22,
		"本层关卡无转移效果"
	},
	{
		23,
		"己阵精灵死亡时，使其变身为神曜蜜西西（1回合）并恢复100%生命值（每场对战最多触发2次效果）"
	},
	{
		24,
		"敌阵精灵死亡时，使其变身为神曜蜜西西（1回合）并恢复100%生命值（每场对战最多触发2次效果）"
	}
}
local t_fire_dimension_challenge_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21],
	dataList[22],
	dataList[23],
	dataList[24]
}

t_fire_dimension_challenge_buff.dataList = dataList

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

return t_fire_dimension_challenge_buff
