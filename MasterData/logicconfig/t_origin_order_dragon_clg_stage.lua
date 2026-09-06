-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_order_dragon_clg_stage.lua

module("logicconfig.config.t_origin_order_dragon_clg_stage", package.seeall)

local title = {
	stageId = 2,
	activityId = 1,
	showDesc = 6,
	creepsMasterId = 5,
	hpWanScoreRate = 4,
	hitCountScoreRate = 3,
	stageName = 7
}
local dataList = {
	{
		568001,
		1,
		1,
		0.1,
		1001,
		"★战场规则:敌阵精灵攻击目标后降低目标70点气势，首次死亡时解除负面效果复活并获得100点气势，30%免伤及非伤免伤\r\n★积分规则:出手次数*系数+平均血量万分比*系数",
		"源起秩序-1"
	},
	{
		568001,
		2,
		1,
		0.1,
		1002,
		"★战场规则:敌阵精灵释放超杀后为敌阵全体精灵恢复50点气势，首次死亡时解除负面效果复活并获得100点气势，30%免伤及非伤免伤\r\n★积分规则:出手次数*系数+平均血量万分比*系数",
		"源起秩序-2"
	},
	{
		568001,
		3,
		1,
		0.1,
		1003,
		"★战场规则:敌阵精灵普攻后令敌阵全体获得1次立即出手（每个大回合限1次），首次死亡时解除负面效果复活并获得100点气势，30%免伤及非伤免伤\r\n★积分规则:出手次数*系数+平均血量万分比*系数",
		"源起秩序-3"
	},
	{
		568001,
		4,
		1,
		0.1,
		1004,
		"★战场规则:敌阵精灵释放超杀后获得1次立即出手（每个大回合限1次），首次死亡时解除负面效果复活并获得100点气势，30%免伤及非伤免伤\r\n★积分规则:出手次数*系数+平均血量万分比*系数",
		"源起秩序-4"
	}
}
local t_origin_order_dragon_clg_stage = {
	[568001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_origin_order_dragon_clg_stage.dataList = dataList

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

return t_origin_order_dragon_clg_stage
