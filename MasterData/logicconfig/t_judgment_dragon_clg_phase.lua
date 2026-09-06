-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_judgment_dragon_clg_phase.lua

module("logicconfig.config.t_judgment_dragon_clg_phase", package.seeall)

local title = {
	stagePlanId = 3,
	terrainPlanId = 4,
	phaseId = 2,
	prize = 5,
	ruleDesc = 6,
	activityId = 1
}
local dataList = {
	{
		461001,
		1,
		1,
		0,
		"4:273:20",
		"1、地形以及对应的效果如下\r\n漩涡（蓝色光圈）：每次出手前获得伤害-10%（最多叠加9层）\r\n引雷（紫色光圈）：每个大回合结束时，获得1回合嘲讽并+50%易伤（最多叠加9层）\r\n熔浆（红色光圈）：每个大回合结束时，获得禁疗，并受到自身20%最大生命值的伤害"
	},
	{
		461001,
		2,
		2,
		0,
		"4:273:40",
		"1、地形以及对应的效果如下\r\n漩涡（蓝色光圈）：每次出手前获得伤害-10%（最多叠加9层）\r\n引雷（紫色光圈）：每个大回合结束时，获得1回合嘲讽并+50%易伤（最多叠加9层）\r\n熔浆（红色光圈）：每个大回合结束时，获得禁疗，并受到自身20%最大生命值的伤害\r\n2、<color=#25fffb>每个大回合结束时，随机刷新全部地形</color>"
	},
	{
		461001,
		3,
		3,
		1,
		"4:273:60",
		"1、地形以及对应的效果如下\r\n漩涡（蓝色光圈）：每次出手前获得伤害-10%（最多叠加9层）\r\n引雷（紫色光圈）：每个大回合结束时，获得1回合嘲讽并+50%易伤（最多叠加9层）\r\n熔浆（红色光圈）：每个大回合结束时，获得禁疗，并受到自身20%最大生命值的伤害\r\n2、<color=#25fffb>每个大回合结束时，随机刷新全部地形，根据地形的数量激活额外的效果，详细效果请查看说明规则</color>"
	}
}
local t_judgment_dragon_clg_phase = {
	[461001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_judgment_dragon_clg_phase.dataList = dataList

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

return t_judgment_dragon_clg_phase
