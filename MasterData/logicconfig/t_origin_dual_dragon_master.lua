-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dual_dragon_master.lua

module("logicconfig.config.t_origin_dual_dragon_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	heavenAwakenSummonPetId = 12,
	skipTime = 3,
	retreatMsgType = 7,
	heavenAwakenMasterId = 11,
	ruleDesc = 13,
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
		"源起双生龙善-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵减伤和非伤减伤提高50%，且敌阵拉斐尔存活时，敌阵精灵闪避率+80%、增伤+50%"
	},
	{
		1002,
		"源起双生龙善-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵减伤和非伤减伤提高50%，且敌阵拉斐尔存活时，敌阵精灵闪避率+80%、增伤+50%"
	},
	{
		1003,
		"源起双生龙善-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵减伤和非伤减伤提高50%，且敌阵拉斐尔存活时，敌阵精灵闪避率+80%、增伤+50%"
	},
	{
		1004,
		"源起双生龙善-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵减伤和非伤减伤提高50%，且敌阵拉斐尔存活时，敌阵精灵闪避率+80%、增伤+50%"
	},
	{
		1005,
		"源起双生龙善-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵减伤和非伤减伤提高50%，且敌阵拉斐尔存活时，敌阵精灵闪避率+80%、增伤+50%"
	},
	{
		1006,
		"源起双生龙恶-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵每次受击标记伤害来源，被标记的精灵下个大回合开始时立即死亡，每个大回合标记目标最多为4个"
	},
	{
		1007,
		"源起双生龙恶-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵每次受击标记伤害来源，被标记的精灵下个大回合开始时立即死亡，每个大回合标记目标最多为4个"
	},
	{
		1008,
		"源起双生龙恶-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵每次受击标记伤害来源，被标记的精灵下个大回合开始时立即死亡，每个大回合标记目标最多为4个"
	},
	{
		1009,
		"源起双生龙恶-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"5",
		"7",
		"敌阵精灵每次受击标记伤害来源，被标记的精灵下个大回合开始时立即死亡，每个大回合标记目标最多为4个"
	},
	{
		1010,
		"源起双生龙恶-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		"敌阵精灵每次受击标记伤害来源，被标记的精灵下个大回合开始时立即死亡，每个大回合标记目标最多为4个"
	}
}
local t_origin_dual_dragon_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[1010] = dataList[10]
}

t_origin_dual_dragon_master.dataList = dataList

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

return t_origin_dual_dragon_master
