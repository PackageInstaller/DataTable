-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_king_mo_yan_clg_creeps_master.lua

module("logicconfig.config.t_origin_king_mo_yan_clg_creeps_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	ruleDesc = 11,
	skipTime = 3,
	retreatMsgType = 7,
	btlMode = 5,
	btlBg = 4,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 10
}
local dataList = {
	{
		1001,
		"源起王者末炎-1",
		5,
		"",
		"",
		233,
		0,
		0,
		0,
		"",
		"我方精灵存活数量需>=3"
	},
	{
		1002,
		"源起王者末炎-2",
		5,
		"",
		"",
		233,
		0,
		0,
		0,
		"",
		"我方精灵存活数量需>=3"
	},
	{
		1003,
		"源起王者末炎-3",
		5,
		"",
		"",
		235,
		0,
		0,
		0,
		"",
		"我方精灵存活数量需>=4"
	},
	{
		1004,
		"源起王者末炎-4",
		5,
		"",
		"",
		235,
		0,
		0,
		0,
		"",
		"我方精灵存活数量需>=4"
	},
	{
		1005,
		"源起王者末炎-5",
		5,
		"",
		"",
		237,
		0,
		0,
		0,
		"",
		"敌阵精灵进入战斗时给自己添加自身最大生命值*80%的护盾"
	},
	{
		1006,
		"源起王者末炎-6",
		5,
		"",
		"",
		237,
		0,
		0,
		0,
		"",
		"敌阵精灵进入战斗时给自己添加自身最大生命值*80%的护盾"
	},
	{
		1007,
		"源起王者末炎-7",
		5,
		"",
		"",
		237,
		0,
		0,
		0,
		"",
		"敌阵精灵进入战斗时给自己添加自身最大生命值*80%的护盾"
	},
	{
		1008,
		"源起王者末炎-8",
		5,
		"",
		"",
		237,
		0,
		0,
		0,
		"",
		"敌阵精灵进入战斗时给自己添加自身最大生命值*80%的护盾"
	},
	{
		1009,
		"源起王者末炎-9",
		5,
		"",
		"",
		237,
		0,
		0,
		0,
		"",
		"我方精灵受到伤害加深40%"
	},
	{
		1010,
		"源起王者末炎-10",
		5,
		"",
		"",
		237,
		0,
		0,
		0,
		"",
		"我方精灵受到伤害加深40%"
	},
	{
		1011,
		"源起王者末炎-11",
		5,
		"",
		"",
		237,
		0,
		0,
		0,
		"",
		"我方精灵受到伤害加深40%"
	},
	{
		1012,
		"源起王者末炎-12",
		5,
		"",
		"",
		187,
		0,
		0,
		0,
		"",
		"我方精灵受到伤害加深40%"
	}
}
local t_origin_king_mo_yan_clg_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[1010] = dataList[10],
	[1011] = dataList[11],
	[1012] = dataList[12]
}

t_origin_king_mo_yan_clg_creeps_master.dataList = dataList

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

return t_origin_king_mo_yan_clg_creeps_master
