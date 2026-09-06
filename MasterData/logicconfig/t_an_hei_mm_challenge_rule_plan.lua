-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_an_hei_mm_challenge_rule_plan.lua

module("logicconfig.config.t_an_hei_mm_challenge_rule_plan", package.seeall)

local title = {
	formConditionId = 3,
	missionDesc = 4,
	ruleId = 1,
	modeId = 2,
	perfectWinId = 5,
	battleDesc = 6,
	perfectDes = 7,
	buffDes = 8
}
local dataList = {
	{
		1,
		1,
		28,
		"完美：上阵<color=#0174DEFF>1只光属性</color>精灵",
		0,
		"上阵光属性精灵",
		"上阵<color=#0174DEFF>1只光属性精灵</color>",
		"己阵光属性精灵攻击提升9%"
	},
	{
		2,
		1,
		0,
		"完美：存活<color=#0174DEFF>2只</color>精灵或以上",
		1,
		"存活精灵数",
		"存活<color=#0174DEFF>2只</color>精灵或以上",
		"己阵精灵生命提升5%"
	},
	{
		3,
		1,
		0,
		"完美：<color=#0174DEFF>4回合</color>内击败敌阵",
		13,
		"当前回合数",
		"<color=#0174DEFF>4回合</color>内击败敌阵",
		"己阵精灵攻击提升4%"
	},
	{
		4,
		2,
		0,
		"完美：<color=#0174DEFF>2号位和5号位</color>必须上阵精灵且存活",
		4,
		"2号位和5号位精灵存活",
		"<color=#0174DEFF>2号位和5号位</color>必须上阵精灵且存活",
		"敌方精灵每次攻击造成攻击12%的额外伤害"
	},
	{
		5,
		2,
		0,
		"完美：累计闪避次数不少于<color=#0174DEFF>4</color>次",
		15,
		"闪避次数",
		"累计闪避次数不少于<color=#0174DEFF>4</color>次",
		"敌方精灵暴击率提升30%"
	},
	{
		6,
		2,
		0,
		"完美：至少存活<color=#0174DEFF>2只</color>包含<color=#0174DEFF>光或草</color>属性精灵",
		14,
		"存活包含光或草属性精灵",
		"至少存活<color=#0174DEFF>2只</color>包含<color=#0174DEFF>光或草</color>属性精灵",
		"敌方精灵生命恢复效果提升30%"
	},
	{
		7,
		3,
		0,
		"完美：<color=#0174DEFF>3回合</color>内击败敌阵",
		17,
		"当前回合数",
		"<color=#0174DEFF>3回合</color>内击败敌阵",
		"敌阵精灵首次出手后额外出手一次"
	},
	{
		8,
		3,
		0,
		"完美：存活<color=#0174DEFF>4只</color>精灵或以上",
		20,
		"存活精灵数",
		"存活<color=#0174DEFF>4只</color>精灵或以上",
		"己阵精灵闪避率和暴击率降低99%"
	},
	{
		9,
		3,
		0,
		"完美：累计暴击次数不少于<color=#0174DEFF>6</color>次",
		21,
		"暴击次数",
		"累计暴击次数不少于<color=#0174DEFF>6</color>次",
		"敌阵精灵反弹50%的攻击伤害"
	},
	{
		10,
		4,
		0,
		"完美：至少存活<color=#0174DEFF>2只</color><color=#0174DEFF>火</color>属性精灵",
		18,
		"存活火属性精灵",
		"至少存活<color=#0174DEFF>2只</color><color=#0174DEFF>火</color>属性精灵",
		"己阵精灵无法恢复生命和复活"
	},
	{
		11,
		4,
		0,
		"完美：<color=#0174DEFF>4号位和6号位</color>必须上阵精灵且存活",
		19,
		"4号位和6号位精灵存活",
		"<color=#0174DEFF>4号位和6号位</color>必须上阵精灵且存活",
		"敌阵属性克制伤害提升150%"
	},
	{
		12,
		4,
		0,
		"完美：<color=#0174DEFF>3回合</color>内击败敌阵",
		17,
		"当前回合数",
		"<color=#0174DEFF>3回合</color>内击败敌阵",
		"敌阵每只精灵首次受到致命伤害时保留1点生命值"
	},
	{
		13,
		5,
		0,
		"完美：至少存活<color=#0174DEFF>4只</color>包含<color=#0174DEFF>水或火或草</color>属性精灵",
		16,
		"存活包含水或火或草属性精灵",
		"至少存活<color=#0174DEFF>4只</color>含<color=#0174DEFF>水或火或草</color>属性精灵",
		"敌阵精灵开局获得满气势"
	},
	{
		14,
		5,
		0,
		"完美：<color=#0174DEFF>1号位和3号位</color>必须上阵精灵且存活",
		3,
		"1号位和3号位精灵存活",
		"<color=#0174DEFF>1号位和3号位</color>必须上阵精灵且存活",
		"敌阵精灵免疫群体伤害"
	},
	{
		15,
		5,
		0,
		"完美：存活<color=#0174DEFF>3只</color>精灵或以上",
		2,
		"存活精灵数",
		"存活<color=#0174DEFF>3只</color>精灵或以上",
		"己阵精灵受到攻击后，身后的精灵会眩晕1回合"
	}
}
local t_an_hei_mm_challenge_rule_plan = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15]
}

t_an_hei_mm_challenge_rule_plan.dataList = dataList

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

return t_an_hei_mm_challenge_rule_plan
