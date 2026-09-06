-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_chen_clg_suit_plan.lua

module("logicconfig.config.t_origin_chen_clg_suit_plan", package.seeall)

local title = {
	maxN = 4,
	name = 5,
	suitPlanId = 1,
	minN = 3,
	suit = 2,
	desc = 6
}
local dataList = {
	{
		1,
		1,
		0,
		2,
		"黑桃",
		"黑桃：女性精灵<=2，每个大回合开始时，己方降低70点气势，敌方获得70点气势"
	},
	{
		1,
		2,
		3,
		3,
		"红桃",
		"红桃：女性精灵=3，每个大回合开始时，己方降低80点气势"
	},
	{
		1,
		3,
		4,
		4,
		"梅花",
		"梅花：女性精灵=4，每个大回合开始时，敌方获得70点气势和无视1次超杀伤害（不叠加）"
	},
	{
		1,
		4,
		5,
		99,
		"方块",
		"方块：女性精灵>=5，每个大回合开始时，己方降低50点气势，敌方每次攻击后，若目标气势小于120，则自身获得一次立即出手（每个大回合限1次）"
	}
}
local t_origin_chen_clg_suit_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_origin_chen_clg_suit_plan.dataList = dataList

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

return t_origin_chen_clg_suit_plan
