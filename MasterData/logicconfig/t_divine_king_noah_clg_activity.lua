-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_noah_clg_activity.lua

module("logicconfig.config.t_divine_king_noah_clg_activity", package.seeall)

local title = {
	progressPlanId = 3,
	skinId = 5,
	activityId = 1,
	ruleKeyChallenge = 8,
	jumpTo = 9,
	activityPlanId = 4,
	ruleKeyMain = 7,
	firstPassNeedPassStage = 2,
	ruleTip = 6
}
local dataList = {
	{
		471001,
		0,
		1,
		1,
		14033,
		"玩法说明规则：\r\n1、每一个格子中包含一个敌阵，挑战破阵成功后按照精灵存活数获得光暗标识\r\n存活数为奇数：光标识\r\n存活数为偶数：暗标识\r\n\r\n2、每个格子均可重复挑战获得意向的标识\r\n\r\n3、上下左右斜对角若有相同标识时，会连成对应标识链条；若连线上存在有4个相同，则链条数额外+1\r\n光链条：<color=#92FFFFFF>+50敌阵气势</color>\r\n暗链条：<color=#92FFFFFF>+50敌阵气势</color>\r\n\r\n4、可使用最右侧的道具打断链条的链接，也可使用道具重置关卡",
		"sywangzhenuoya_rule_main",
		"sywangzhenuoya_rule_main",
		{
			"func#618#14033",
			"mibao#jinglingyangcheng",
			"ui#lottery"
		}
	},
	{
		471002,
		13,
		0,
		1,
		14033,
		"玩法说明规则：\r\n1、每一个格子中包含一个敌阵，挑战破阵成功后按照精灵存活数获得光暗标识\r\n存活数为奇数：光标识\r\n存活数为偶数：暗标识\r\n\r\n2、每个格子均可重复挑战获得意向的标识\r\n\r\n3、上下左右斜对角若有相同标识时，会连成对应标识链条；若连线上存在有4个相同，则链条数额外+1\r\n光链条：<color=#92FFFFFF>+50敌阵气势</color>\r\n暗链条：<color=#92FFFFFF>+50敌阵气势</color>\r\n\r\n4、可使用最右侧的道具打断链条的链接，也可使用道具重置关卡",
		"sywangzhenuoya_rule_main",
		"sywangzhenuoya_rule_main",
		{
			"func#618#14033",
			"mibao#jinglingyangcheng",
			"ui#lottery"
		}
	},
	{
		471003,
		13,
		0,
		1,
		14033,
		"玩法说明规则：\r\n1、每一个格子中包含一个敌阵，挑战破阵成功后按照精灵存活数获得光暗标识\r\n存活数为奇数：光标识\r\n存活数为偶数：暗标识\r\n\r\n2、每个格子均可重复挑战获得意向的标识\r\n\r\n3、上下左右斜对角若有相同标识时，会连成对应标识链条；若连线上存在有4个相同，则链条数额外+1\r\n光链条：<color=#92FFFFFF>+50敌阵气势</color>\r\n暗链条：<color=#92FFFFFF>+50敌阵气势</color>\r\n\r\n4、可使用最右侧的道具打断链条的链接，也可使用道具重置关卡",
		"sywangzhenuoya_rule_main",
		"sywangzhenuoya_rule_main",
		{
			"func#618#14033",
			"mibao#jinglingyangcheng",
			"ui#lottery"
		}
	}
}
local t_divine_king_noah_clg_activity = {
	[471001] = dataList[1],
	[471002] = dataList[2],
	[471003] = dataList[3]
}

t_divine_king_noah_clg_activity.dataList = dataList

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

return t_divine_king_noah_clg_activity
