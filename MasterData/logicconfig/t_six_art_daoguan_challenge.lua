-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_six_art_daoguan_challenge.lua

module("logicconfig.config.t_six_art_daoguan_challenge", package.seeall)

local title = {
	challengeId = 2,
	resetDropBuffCost = 5,
	bubble = 8,
	openDateTime = 4,
	raceId = 6,
	trans = 7,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		447001,
		1,
		"乐",
		"2025-01-24T05:00:00",
		"",
		1302101,
		{
			-240,
			-530,
			0.9
		},
		"击败敌阵全部拥有音符的精灵即可通关，音符存在有回合数限制，过后将消失（非直伤击杀的精灵不算）"
	},
	{
		447001,
		2,
		"射",
		"2025-01-28T05:00:00",
		"",
		1202701,
		{
			-405,
			-605,
			0.9
		},
		"限定回合击败敌阵全部精灵即可通关"
	},
	{
		447001,
		3,
		"御",
		"2025-01-31T05:00:00",
		"105:2:50",
		1202801,
		{
			-425,
			-585,
			0.9
		},
		"每关连续战斗5场，结束后不恢复状态，全部破阵后即可通关；通关后的祝福在本挑战所有关卡中生效"
	},
	{
		447001,
		4,
		"书",
		"2025-02-07T05:00:00",
		"",
		1102601,
		{
			-300,
			-500,
			0.9
		},
		"按顺序击杀敌阵拥有文案的精灵即可通关"
	},
	{
		447001,
		5,
		"数",
		"2025-02-07T05:00:00",
		"",
		1302202,
		{
			-300,
			-500,
			0.9
		},
		"己方精灵存活数满足数学等式即可通关"
	}
}
local t_six_art_daoguan_challenge = {
	[447001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_six_art_daoguan_challenge.dataList = dataList

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

return t_six_art_daoguan_challenge
