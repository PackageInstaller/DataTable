-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_water_tian_yan_clg_creeps_master.lua

module("logicconfig.config.t_divine_water_tian_yan_clg_creeps_master", package.seeall)

local title = {
	skipTime = 3,
	name = 2,
	heavenAwakenSummonPetId = 11,
	formCondition = 7,
	retreatMsgType = 5,
	heavenAwakenMasterId = 10,
	ruleDesc = 9,
	selfBuffProviderId = 6,
	winId = 4,
	creepsMasterId = 1,
	heroSkillId = 8
}
local dataList = {
	{
		1001,
		"神曜水天炎-1",
		5,
		0,
		0,
		491,
		0,
		"",
		"敌阵神曜昼夜·诺雅存活时，每个大回合结束时会对己方所有精灵造成当前最大生命值*10%的伤害",
		"",
		""
	},
	{
		1002,
		"神曜水天炎-2",
		5,
		0,
		0,
		491,
		0,
		"",
		"敌阵神曜意志·极存活时，每个大回合结束时会对己方所有精灵造成当前最大生命值*10%的伤害",
		"",
		""
	},
	{
		1003,
		"神曜水天炎-3",
		5,
		0,
		0,
		491,
		0,
		"",
		"敌阵神曜迷魇·维蕾塔存活时，每个大回合结束时会对己方所有精灵造成当前最大生命值*10%的伤害",
		"",
		""
	},
	{
		1004,
		"神曜水天炎-4",
		5,
		0,
		0,
		491,
		0,
		"",
		"敌阵创始天璇·昆吾存活时，每个大回合结束时会对己方所有精灵造成当前最大生命值*10%的伤害",
		"",
		""
	},
	{
		1005,
		"神曜水天炎-5",
		5,
		0,
		0,
		491,
		0,
		"",
		"敌阵神曜落情·尘存活时，每个大回合结束时会对己方所有精灵造成当前最大生命值*10%的伤害",
		"",
		""
	},
	{
		1006,
		"神曜水天炎-6",
		5,
		0,
		0,
		491,
		0,
		"",
		"敌阵万灵始祖·究存活时，每个大回合结束时会对己方所有精灵造成当前最大生命值*10%的伤害",
		"",
		""
	},
	{
		1007,
		"神曜水天炎-7",
		5,
		0,
		0,
		491,
		0,
		"",
		"敌阵神曜天命·弥娅存活时，每个大回合结束时会对己方所有精灵造成当前最大生命值*10%的伤害",
		"",
		""
	},
	{
		1008,
		"神曜水天炎-8",
		5,
		0,
		0,
		491,
		0,
		"",
		"敌阵逆海吞天·兰德斯存活时，每个大回合结束时会对己方所有精灵造成当前最大生命值*10%的伤害",
		"",
		""
	},
	{
		1009,
		"神曜水天炎-9",
		5,
		0,
		0,
		16,
		0,
		"",
		"6回合内达到指定破盾次数，绝命终焉·路因加德拥有永久嘲讽和护盾，敌阵所有精灵阵亡时会复活",
		"5",
		"6"
	},
	{
		1010,
		"神曜水天炎-10",
		5,
		0,
		0,
		16,
		0,
		"",
		"6回合内达到指定破盾次数，圣幻希望·夏因拥有永久嘲讽和护盾，敌阵所有精灵阵亡时会复活",
		"",
		""
	},
	{
		1011,
		"神曜水天炎-11",
		5,
		0,
		0,
		15,
		0,
		"",
		"5回合内达到指定破盾次数，神曜昼夜·诺雅拥有永久嘲讽和护盾，敌阵所有精灵阵亡时会复活",
		"5",
		"6"
	},
	{
		1012,
		"神曜水天炎-12",
		5,
		0,
		0,
		15,
		0,
		"",
		"5回合内达到指定破盾次数，神曜权御·龙尊圣主拥有永久嘲讽和护盾，敌阵所有精灵阵亡时会复活",
		"",
		""
	},
	{
		1013,
		"神曜水天炎-13",
		5,
		0,
		0,
		14,
		0,
		"",
		"4回合内达到指定破盾次数，神曜战狂·无敌拥有永久嘲讽和护盾，敌阵所有精灵阵亡时会复活",
		"5",
		"6"
	},
	{
		1014,
		"神曜水天炎-14",
		5,
		0,
		0,
		17,
		0,
		"",
		"3回合内达到指定破盾次数，浴血罪冠·誓祖圣龙拥有永久嘲讽和护盾，敌阵所有精灵阵亡时会复活",
		"",
		""
	},
	{
		1015,
		"神曜水天炎-15",
		5,
		0,
		0,
		17,
		0,
		"",
		"3回合内达到指定破盾次数，神曜吞天·兰德斯拥有永久嘲讽和护盾，敌阵所有精灵阵亡时会复活",
		"",
		""
	},
	{
		1016,
		"神曜水天炎-16",
		5,
		0,
		0,
		14,
		0,
		"",
		"4回合内达到指定破盾次数，神曜圣谕·女帝拥有永久嘲讽和护盾，敌阵所有精灵阵亡时会复活",
		"",
		""
	}
}
local t_divine_water_tian_yan_clg_creeps_master = {
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
	[1012] = dataList[12],
	[1013] = dataList[13],
	[1014] = dataList[14],
	[1015] = dataList[15],
	[1016] = dataList[16]
}

t_divine_water_tian_yan_clg_creeps_master.dataList = dataList

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

return t_divine_water_tian_yan_clg_creeps_master
