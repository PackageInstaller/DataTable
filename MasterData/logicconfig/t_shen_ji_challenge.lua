-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shen_ji_challenge.lua

module("logicconfig.config.t_shen_ji_challenge", package.seeall)

local title = {
	dailyLimit = 9,
	jumpTo3 = 15,
	comPlanId = 17,
	redPointId = 8,
	goldBarCon = 11,
	jumpTo4 = 16,
	ruleTip = 12,
	challengeId = 10,
	jumpTo2 = 14,
	initGameValue = 4,
	dailySelectTimes = 2,
	minGameValue = 6,
	fightBossTimes = 7,
	maxGameValue = 5,
	jumpTo1 = 13,
	optionalStageCount = 3,
	actId = 1
}
local dataList = {
	{
		312001,
		5,
		3,
		0,
		100,
		0,
		3,
		532,
		false,
		135,
		"4:383",
		"shenjichallengemainview_rule",
		"func#970",
		"func#618#17013",
		"mibao#shenyaolibao",
		"mibao#longmaijuexing3",
		1
	},
	{
		312002,
		5,
		3,
		0,
		100,
		0,
		3,
		532,
		false,
		204,
		"4:260",
		"divinelounamainview_rule",
		"func#618#13020",
		"mibao#jinglingyangcheng",
		"func#545#3",
		"",
		2
	},
	{
		312003,
		5,
		3,
		0,
		100,
		0,
		3,
		532,
		false,
		301,
		"4:510780",
		"originmoonshadowkingmainview_rule",
		"func#618#15047",
		"ui#lottery",
		"mibao#jinglingyangcheng",
		"func#545#52",
		3
	}
}
local t_shen_ji_challenge = {
	[312001] = dataList[1],
	[312002] = dataList[2],
	[312003] = dataList[3]
}

t_shen_ji_challenge.dataList = dataList

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

return t_shen_ji_challenge
