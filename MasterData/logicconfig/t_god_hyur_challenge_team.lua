-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_hyur_challenge_team.lua

module("logicconfig.config.t_god_hyur_challenge_team", package.seeall)

local title = {
	description = 9,
	name = 2,
	formCondition = 3,
	skipTime = 4,
	effectPos = 12,
	completeTxt = 13,
	btlBg = 6,
	selfBuffProviderId = 10,
	background = 5,
	winId = 11,
	creepsMasterId = 1,
	heroSkillId = 7,
	recommendZdl = 8
}
local dataList = {
	{
		1111,
		"欢喜",
		0,
		15,
		"",
		"",
		"410181",
		800000,
		"击败敌方所有敌人，记录通关关卡时己阵存活数",
		0,
		0,
		nil,
		""
	},
	{
		1112,
		"惊喜",
		0,
		15,
		"",
		"",
		"",
		800000,
		"击败敌方所有敌人，记录通关关卡时己阵存活数",
		0,
		0,
		nil,
		""
	},
	{
		1113,
		"狂喜",
		0,
		15,
		"",
		"",
		"410334",
		800000,
		"击败敌方所有敌人，记录通关关卡时己阵存活数",
		0,
		0,
		nil,
		""
	},
	{
		1114,
		"欣喜",
		0,
		15,
		"",
		"",
		"410345",
		800000,
		"击败敌方所有敌人，记录通关关卡时己阵存活数",
		0,
		0,
		nil,
		""
	},
	{
		1115,
		"大喜",
		0,
		15,
		"",
		"",
		"412007",
		800000,
		"击败敌方所有敌人，记录通关关卡时己阵存活数",
		0,
		0,
		nil,
		""
	},
	{
		1121,
		"悲伤",
		0,
		15,
		"",
		"",
		"414004",
		800000,
		"击败敌方所有敌人，记录通关关卡时己阵回合数",
		0,
		0,
		nil,
		""
	},
	{
		1122,
		"悲痛",
		0,
		15,
		"",
		"",
		"415006",
		800000,
		"击败敌方所有敌人，记录通关关卡时己阵回合数",
		0,
		0,
		nil,
		""
	},
	{
		1123,
		"悲切",
		0,
		15,
		"",
		"",
		"416003",
		800000,
		"击败敌方所有敌人，记录通关关卡时己阵回合数",
		0,
		0,
		nil,
		""
	},
	{
		1124,
		"悲凉",
		0,
		15,
		"",
		"",
		"",
		800000,
		"击败敌方所有敌人，记录通关关卡时己阵回合数",
		0,
		0,
		nil,
		""
	},
	{
		1125,
		"悲惜",
		0,
		15,
		"",
		"",
		"410327",
		800000,
		"击败敌方所有敌人，记录通关关卡时己阵回合数",
		0,
		0,
		nil,
		""
	}
}
local t_god_hyur_challenge_team = {
	[1111] = dataList[1],
	[1112] = dataList[2],
	[1113] = dataList[3],
	[1114] = dataList[4],
	[1115] = dataList[5],
	[1121] = dataList[6],
	[1122] = dataList[7],
	[1123] = dataList[8],
	[1124] = dataList[9],
	[1125] = dataList[10]
}

t_god_hyur_challenge_team.dataList = dataList

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

return t_god_hyur_challenge_team
