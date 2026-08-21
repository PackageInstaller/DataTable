-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_battle_report_desc.lua

module("logic.config.t_battle_report_desc", package.seeall)

local title = {
	title = 2,
	subtitle = 3,
	idea = 5,
	code = 1,
	desc = 4
}
local dataList = {
	{
		1,
		"损伤报告",
		"INJURY    REPORT1",
		"根据ODA的▉▉▉▉需要对参与了危险战斗的人员进行必要的身体状态评估。",
		"%s在战斗中损失/消耗了<color=#4481cd>%s</color>点生命值。"
	},
	{
		2,
		"理智报告",
		"INJURY    REPORT2",
		"根据ODA的组织要求要对参与了危险战斗的人员进行必要的▉▉▉▉评估。能力的使用和敌人的精神干扰引起了一定的&大脑波动，但大脑在一定范围内相对稳定的功能状态未被破坏；涉及感知、思维、情感和行为的精神活动未出现不协调情况，▉▉▉▉、智能正常、认知功能未出现任何障碍。",
		"%s在战斗中损失/消耗了<color=#4482cd>%s</color>点理智值。"
	},
	{
		3,
		"歼敌报告",
		"INJURY    REPORT3",
		"根据ODA的组织要求需要对▆▇█▋▊▉参与了▉▉▉▉进行必要的战损比统计。",
		"%s在战斗中击败了<color=#4483cd>%s</color>个敌人。"
	},
	{
		4,
		"攻击报告",
		"INJURY    REPORT4",
		"根据ODA的组织要求需要对危险战斗的敌方损伤▉▉▉▉进行统计和分析。",
		"%s在战斗中对敌方造成<color=#4484cd>%s</color>点生物理伤害。"
	},
	{
		5,
		"以太报告",
		"INJURY    REPORT5",
		"根据ODA的组织要求需要对危险战斗的敌方损伤进行统计和▉▉▉。",
		"%s在战斗中对敌方造成<color=#4485cd>%s</color>点以太伤害。"
	},
	{
		6,
		"治疗报告",
		"INJURY    REPOR6",
		"根据▉▉▉的组织要求需要对参与了危险战斗的医疗人员救助情况进行记录和分析。",
		"%s在战斗中恢复己方<color=#4486cd>%s</color>点生命值。"
	}
}
local t_battle_report_desc = {}

t_battle_report_desc.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_battle_report_desc[v[1]] = v

	setmetatable(v, mt)
end

return t_battle_report_desc
