-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_order_dragon_clg_creeps_master.lua

module("logicconfig.config.t_origin_order_dragon_clg_creeps_master", package.seeall)

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
		"源起秩序-1",
		5,
		0,
		0,
		142,
		0,
		"416044",
		"敌阵精灵攻击目标后降低目标70点气势，首次死亡时解除负面效果复活并获得100点气势，30%免伤及非伤免伤",
		"",
		""
	},
	{
		1002,
		"源起秩序-2",
		5,
		0,
		0,
		142,
		0,
		"412044",
		"敌阵精灵释放超杀后为敌阵全体精灵恢复50点气势，首次死亡时解除负面效果复活并获得100点气势，30%免伤及非伤免伤",
		"",
		""
	},
	{
		1003,
		"源起秩序-3",
		5,
		0,
		0,
		142,
		0,
		"413029",
		"敌阵精灵普攻后令自身获得1次立即出手（每个大回合限1次），首次死亡时解除负面效果复活并获得100点气势，30%免伤及非伤免伤",
		"5",
		"6"
	},
	{
		1004,
		"源起秩序-4",
		5,
		0,
		0,
		142,
		0,
		"414037",
		"敌阵精灵释放超杀后获得1次立即出手（每个大回合限1次），首次死亡时解除负面效果复活并获得100点气势，30%免伤及非伤免伤",
		"7",
		"8"
	}
}
local t_origin_order_dragon_clg_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4]
}

t_origin_order_dragon_clg_creeps_master.dataList = dataList

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

return t_origin_order_dragon_clg_creeps_master
