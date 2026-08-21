-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_skill_effect_occasion.lua

module("logic.config.t_skill_effect_occasion", package.seeall)

local title = {
	editorType = 7,
	name = 2,
	sortIndex = 4,
	timeTypeName = 6,
	code = 1,
	programming = 3,
	desc = 5
}
local dataList = {
	{
		-1,
		"无时机",
		"ANYTIME",
		1,
		"",
		"",
		"回合流程时机"
	},
	{
		1,
		"关卡开始",
		"BATTLE_STARTED",
		2,
		"关卡开始",
		"技能流程外",
		"回合流程时机"
	},
	{
		2,
		"回合开始",
		"ROUND_STARTED",
		3,
		"回合开始",
		"技能流程外",
		"回合流程时机"
	},
	{
		3,
		"回合结束",
		"ROUND_ENDED",
		7,
		"回合结束",
		"技能流程外",
		"回合流程时机"
	},
	{
		4,
		"阶段开始",
		"STAGE_STARTED",
		4,
		"阶段开始",
		"技能流程外",
		"回合流程时机"
	},
	{
		5,
		"阶段结束",
		"STAGE_ENDED",
		6,
		"阶段结束",
		"技能流程外",
		"回合流程时机"
	},
	{
		6,
		"行动结束",
		"STEP_ENDED",
		5,
		"行动结束",
		"技能流程外",
		"回合流程时机"
	},
	{
		7,
		"主动攻击前",
		"ATTACKING_STARTED",
		2,
		"主动攻击前",
		"技能流程内",
		"攻击流程时机"
	},
	{
		8,
		"主动攻击后",
		"ATTACKING_ENDED",
		5,
		"主动攻击后",
		"技能流程内",
		"攻击流程时机"
	},
	{
		9,
		"受到攻击前",
		"BEING_ATTACKED_STARTED",
		3,
		"受到攻击前",
		"技能流程内",
		"攻击流程时机"
	},
	{
		10,
		"受到攻击后",
		"BEING_ATTACKED_ENDED",
		4,
		"受到攻击后",
		"技能流程内",
		"攻击流程时机"
	},
	{
		29,
		"进入战斗前",
		"ATTACK_PREPARED",
		1,
		"进入战斗前",
		"技能流程内",
		"攻击流程时机"
	},
	{
		30,
		"退出战斗后",
		"ATTACK_POSTED",
		6,
		"退出战斗后",
		"技能流程内",
		"攻击流程时机"
	},
	{
		31,
		"施加位移前",
		"POSITION_CHANGING_STARTED",
		1,
		"施加位移前",
		"技能流程内",
		"位移流程时机"
	},
	{
		32,
		"施加位移后",
		"POSITION_CHANGING_ENDED",
		4,
		"施加位移后",
		"技能流程内",
		"位移流程时机"
	},
	{
		33,
		"受到位移前",
		"BEING_POSITION_CHANGED_STARTED",
		2,
		"受到位移前",
		"技能流程内",
		"位移流程时机"
	},
	{
		34,
		"受到位移后",
		"BEING_POSITION_CHANGED_ENDED",
		3,
		"受到位移后",
		"技能流程内",
		"位移流程时机"
	},
	{
		35,
		"施加支援前",
		"ASSISTING_STARTED",
		1,
		"施加支援前",
		"技能流程内",
		"支援流程时机"
	},
	{
		36,
		"施加支援后",
		"ASSISTING_ENDED",
		4,
		"施加支援后",
		"技能流程内",
		"支援流程时机"
	},
	{
		37,
		"受到支援前",
		"BEING_ASSISTED_STARTED",
		2,
		"受到支援前",
		"技能流程内",
		"支援流程时机"
	},
	{
		38,
		"受到支援后",
		"BEING_ASSISTED_ENDED",
		3,
		"受到支援后",
		"技能流程内",
		"支援流程时机"
	},
	{
		39,
		"释放跨回合 aoe 技能前",
		"MULTI_ROUND_AOE_STARTED",
		1,
		"释放跨回合 aoe 技能前",
		"技能流程内",
		"特殊技能流程时机"
	},
	{
		40,
		"释放跨回合 aoe 技能后",
		"MULTI_ROUND_AOE_ENDED",
		2,
		"释放跨回合 aoe 技能后",
		"技能流程内",
		"特殊技能流程时机"
	},
	{
		41,
		"释放召唤技能前",
		"SUMMONING_STARTED",
		3,
		"释放召唤技能前",
		"技能流程内",
		"特殊技能流程时机"
	},
	{
		42,
		"释放召唤技能后",
		"SUMMONING_ENDED",
		4,
		"释放召唤技能后",
		"技能流程内",
		"特殊技能流程时机"
	},
	{
		43,
		"释放标记技能前",
		"MARK_STARTED",
		5,
		"释放标记技能前",
		"技能流程内",
		"特殊技能流程时机"
	},
	{
		44,
		"释放标记技能后",
		"MARK_ENDED",
		6,
		"释放标记技能后",
		"技能流程内",
		"特殊技能流程时机"
	},
	{
		45,
		"所处格子地形改变后",
		"TERRAIN_CHANGED",
		0,
		"所处格子地形改变后",
		"技能流程内",
		"特殊技能流程时机"
	},
	{
		46,
		"自身死亡时",
		"DIE",
		0,
		"自身死亡时",
		"技能流程内",
		"特殊技能流程时机"
	}
}
local t_skill_effect_occasion = {}

t_skill_effect_occasion.dataList = dataList

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
	t_skill_effect_occasion[v[1]] = v

	setmetatable(v, mt)
end

return t_skill_effect_occasion
