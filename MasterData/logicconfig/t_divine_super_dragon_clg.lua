-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_super_dragon_clg.lua

module("logicconfig.config.t_divine_super_dragon_clg", package.seeall)

local title = {
	jumpStrOne = 2,
	xzRuleDesc = 10,
	jumpStrThree = 4,
	ruleKeyXingzhou = 8,
	skinId = 6,
	jumpStrTwo = 3,
	ruleKeyChaoshen = 9,
	jumpStrFour = 5,
	ruleKeyMain = 7,
	activityId = 1
}
local dataList = {
	{
		344001,
		"func#618#16022",
		"mibao#liudaojijie4",
		"mibao#shenyaolibao",
		"func#375",
		16022,
		"ShenyaoFxxkgodDragonChallengemainview_rule",
		"ShenyaoFxxkgodDragonChallengeStaruniverse_rule",
		"ShenyaoFxxkgodDragonChallengefxxkgod_rule",
		"1.击败敌阵即可获得胜利。活动时间内，每个关卡只能通关一次。\r\n2.每个关卡对应一个属性buff。效果：在超神挑战中的boss战中生效。"
	},
	{
		344002,
		"func#618#16022",
		"mibao#liudaojijie4",
		"mibao#shenyaolibao",
		"func#375",
		16022,
		"ShenyaoFxxkgodDragonChallengemainview_rule",
		"ShenyaoFxxkgodDragonChallengeStaruniverse_rule",
		"ShenyaoFxxkgodDragonChallengefxxkgod_rule",
		"1.击败敌阵即可获得胜利。活动时间内，每个关卡只能通关一次。\r\n2.每个关卡对应一个属性buff。效果：在超神挑战中的boss战中生效。"
	}
}
local t_divine_super_dragon_clg = {
	[344001] = dataList[1],
	[344002] = dataList[2]
}

t_divine_super_dragon_clg.dataList = dataList

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

return t_divine_super_dragon_clg
