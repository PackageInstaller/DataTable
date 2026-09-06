-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wu_wen_clg_buff_plan.lua

module("logicconfig.config.t_wu_wen_clg_buff_plan", package.seeall)

local title = {
	planId = 1,
	desc = 4,
	buffId = 2,
	useCount = 3
}
local dataList = {
	{
		1,
		1,
		1,
		"敌阵超杀后，令己阵气势最高的一位精灵无法行动（1回合）"
	},
	{
		1,
		2,
		1,
		"己阵站位前三位精灵获得无法行动（1回合）"
	},
	{
		2,
		1,
		2,
		"敌阵超杀后，令己阵气势最高的一位精灵无法行动（1回合）"
	},
	{
		2,
		2,
		2,
		"己阵站位前三位精灵获得无法行动（1回合）"
	},
	{
		3,
		1,
		3,
		"敌阵超杀后，令己阵气势最高的一位精灵无法行动（1回合）"
	},
	{
		3,
		2,
		3,
		"己阵站位前三位精灵获得无法行动（1回合）"
	},
	{
		3,
		3,
		3,
		"敌阵精灵首次死亡时，复活恢复满血并令自身无法行动（1回合）"
	},
	{
		4,
		1,
		1,
		"敌阵若攻击目标包含男性精灵，则攻击后获得30气势并免疫下一次攻击"
	},
	{
		4,
		2,
		1,
		"敌阵超杀后，获得80气势并免疫攻击伤害直至出手（最多免疫4次）"
	},
	{
		5,
		1,
		2,
		"敌阵若攻击目标包含男性精灵，则攻击后获得30气势并免疫下一次攻击"
	},
	{
		5,
		2,
		2,
		"敌阵超杀后，获得80气势并免疫攻击伤害直至出手（最多免疫4次）"
	},
	{
		6,
		1,
		3,
		"敌阵若攻击目标包含男性精灵，则攻击后获得30气势并免疫下一次攻击"
	},
	{
		6,
		2,
		3,
		"敌阵超杀后，获得80气势并免疫攻击伤害直至出手（最多免疫4次）"
	},
	{
		6,
		3,
		3,
		"敌阵精灵首次死亡时，复活恢复满血并令自身无法行动（1回合）"
	},
	{
		7,
		1,
		1,
		"敌阵精灵获得40%减伤（2回合）"
	},
	{
		7,
		2,
		1,
		"敌阵精灵攻击没有护盾的目标后，恢复30气势"
	},
	{
		8,
		1,
		2,
		"敌阵精灵获得40%减伤（2回合）"
	},
	{
		8,
		2,
		2,
		"敌阵精灵攻击没有护盾的目标后，恢复30气势"
	},
	{
		9,
		1,
		3,
		"敌阵精灵获得40%减伤（2回合）"
	},
	{
		9,
		2,
		3,
		"敌阵精灵攻击没有护盾的目标后，恢复30气势"
	},
	{
		9,
		3,
		3,
		"敌阵精灵首次死亡时，满血复活并令敌阵血量最低的单位获得其生命值*100%的护盾"
	}
}
local t_wu_wen_clg_buff_plan = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7]
	},
	{
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11]
	},
	{
		dataList[12],
		dataList[13],
		dataList[14]
	},
	{
		dataList[15],
		dataList[16]
	},
	{
		dataList[17],
		dataList[18]
	},
	{
		dataList[19],
		dataList[20],
		dataList[21]
	}
}

t_wu_wen_clg_buff_plan.dataList = dataList

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

return t_wu_wen_clg_buff_plan
