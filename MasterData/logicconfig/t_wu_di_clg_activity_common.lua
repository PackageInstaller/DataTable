-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wu_di_clg_activity_common.lua

module("logicconfig.config.t_wu_di_clg_activity_common", package.seeall)

local title = {
	jumpStrTwo = 7,
	skinId = 2,
	jumpStrOne = 6,
	jumpStrThree = 8,
	ruleKeyExt = 5,
	jumpRedIdThree = 11,
	ruleKeyNor = 4,
	jumpRedIdTwo = 10,
	comPlanId = 1,
	jumpRedIdOne = 9,
	extRuleDesc = 12,
	norRuleDesc = 13,
	ruleKeyMain = 3
}
local dataList = {
	{
		1,
		14017,
		"wudichallenge_rule_main",
		"wudichallenge_rule_guanghun",
		"wudichallenge_rule_pojun",
		"func#618#14017",
		"mibao#shuangjiekuanghuan3",
		"func#43#119",
		"",
		"",
		"",
		{
			"<color=#ababab>1</color>、所有关卡可以任选进行挑战",
			"<color=#ababab>2</color>、挑战敌阵时，需要击败敌阵所有精灵，且我方精灵群攻的使用次数达到要求才算挑战成功。",
			"<color=#ababab>3</color>、通关时，在该关卡群攻次数最多的精灵将被封印，无法在后续的关卡中使用。（次数相同的精灵将一同封印）",
			"<color=#ababab>4</color>、关卡可重复挑战，挑战成功后可选择最新的记录覆盖旧纪录。",
			"<color=#ababab>5</color>、重置时，将重置所有关卡为未挑战，解锁被封印的精灵。"
		},
		"1.<color=#96fa73>每日5:00</color>刷新3个敌阵，<color=#96fa73>成功破阵且满足计数条件</color>可获得光明之魂。\r\n2.使用群攻技能击败<color=#96fa73>1</color>名敌人，获得<color=#96fa73>3</color>点光明之魂。\r\n3.使用其他技能击败<color=#96fa73>1</color>名敌人，获得<color=#96fa73>1</color>点光明之魂。\r\n4,战斗中精灵无敌成功通灵<color=#96fa73>1</color>次，获得<color=#96fa73>10</color>点光明之魂。"
	},
	{
		2,
		14017,
		"wudichallenge_rule_pojun",
		"wudichallenge_rule_guanghun",
		"wudichallenge_rule_pojun",
		"func#618#14017",
		"mibao#shuangjiekuanghuan3",
		"func#43#119",
		"",
		"",
		"",
		{
			"<color=#ababab>1</color>、所有关卡可以任选进行挑战",
			"<color=#ababab>2</color>、挑战敌阵时，需要击败敌阵所有精灵，且我方精灵群攻的使用次数达到要求才算挑战成功。",
			"<color=#ababab>3</color>、通关时，在该关卡群攻次数最多的精灵将被封印，无法在后续的关卡中使用。（次数相同的精灵将一同封印）",
			"<color=#ababab>4</color>、关卡可重复挑战，挑战成功后可选择最新的记录覆盖旧纪录。",
			"<color=#ababab>5</color>、重置时，将重置所有关卡为未挑战，解锁被封印的精灵。"
		},
		"1.<color=#96fa73>每日5:00</color>刷新3个敌阵，<color=#96fa73>成功破阵且满足计数条件</color>可获得光明之魂。\r\n2.使用群攻技能击败<color=#96fa73>1</color>名敌人，获得<color=#96fa73>3</color>点光明之魂。\r\n3.使用其他技能击败<color=#96fa73>1</color>名敌人，获得<color=#96fa73>1</color>点光明之魂。\r\n4,战斗中精灵无敌成功通灵<color=#96fa73>1</color>次，获得<color=#96fa73>10</color>点光明之魂。"
	}
}
local t_wu_di_clg_activity_common = {
	dataList[1],
	dataList[2]
}

t_wu_di_clg_activity_common.dataList = dataList

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

return t_wu_di_clg_activity_common
