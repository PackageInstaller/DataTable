-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_ci_yuan_monster.lua

module("logicconfig.config.t_divine_king_ci_yuan_monster", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	ruleDesc = 11,
	skipTime = 3,
	retreatMsgType = 7,
	btlMode = 5,
	btlBg = 4,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 10
}
local dataList = {
	{
		1001,
		"Ⅰ-Ⅰ",
		5,
		"",
		"",
		0,
		0,
		335,
		0,
		"",
		"击败敌阵全体精灵且出手次数达到要求即可过关"
	},
	{
		1002,
		"Ⅰ-Ⅱ",
		5,
		"",
		"",
		0,
		0,
		335,
		0,
		"",
		"击败敌阵全体精灵且出手次数达到要求即可过关"
	},
	{
		1003,
		"Ⅰ-Ⅲ",
		5,
		"",
		"",
		0,
		0,
		335,
		0,
		"",
		"击败敌阵全体精灵且出手次数达到要求即可过关"
	},
	{
		1004,
		"Ⅰ-Ⅳ",
		5,
		"",
		"",
		0,
		0,
		335,
		0,
		"",
		"击败敌阵全体精灵且出手次数达到要求即可过关"
	},
	{
		1005,
		"Ⅰ-Ⅴ",
		5,
		"",
		"",
		0,
		0,
		335,
		0,
		"",
		"击败敌阵全体精灵且出手次数达到要求即可过关"
	},
	{
		2001,
		"Ⅱ-Ⅰ",
		5,
		"",
		"",
		0,
		0,
		142,
		0,
		"",
		"击败敌阵全体精灵且出手次数达到要求即可过关"
	},
	{
		2002,
		"Ⅱ-Ⅱ",
		5,
		"",
		"",
		0,
		0,
		142,
		0,
		"",
		"击败敌阵全体精灵且出手次数达到要求即可过关"
	},
	{
		2003,
		"Ⅱ-Ⅲ",
		5,
		"",
		"",
		0,
		0,
		142,
		0,
		"",
		"击败敌阵全体精灵且出手次数达到要求即可过关"
	},
	{
		2004,
		"Ⅱ-Ⅳ",
		5,
		"",
		"",
		0,
		0,
		142,
		0,
		"",
		"击败敌阵全体精灵且出手次数达到要求即可过关"
	},
	{
		2005,
		"Ⅱ-Ⅴ",
		5,
		"",
		"",
		0,
		0,
		142,
		0,
		"",
		"击败敌阵全体精灵且出手次数达到要求即可过关"
	},
	{
		3001,
		"Ⅲ-Ⅰ",
		5,
		"",
		"",
		0,
		0,
		142,
		0,
		"411020",
		"击败敌阵全体精灵且出手次数达到要求即可过关"
	},
	{
		3002,
		"Ⅲ-Ⅱ",
		5,
		"",
		"",
		0,
		0,
		142,
		0,
		"413015",
		"击败敌阵全体精灵且出手次数达到要求即可过关"
	},
	{
		3003,
		"Ⅲ-Ⅲ",
		5,
		"",
		"",
		0,
		0,
		142,
		0,
		"417016",
		"击败敌阵全体精灵且出手次数达到要求即可过关"
	},
	{
		3004,
		"Ⅲ-Ⅳ",
		5,
		"",
		"",
		0,
		0,
		142,
		0,
		"417020",
		"击败敌阵全体精灵且出手次数达到要求即可过关"
	},
	{
		3005,
		"Ⅲ-Ⅴ",
		5,
		"",
		"",
		0,
		0,
		142,
		0,
		"414024",
		"击败敌阵全体精灵且出手次数达到要求即可过关"
	}
}
local t_divine_king_ci_yuan_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[2001] = dataList[6],
	[2002] = dataList[7],
	[2003] = dataList[8],
	[2004] = dataList[9],
	[2005] = dataList[10],
	[3001] = dataList[11],
	[3002] = dataList[12],
	[3003] = dataList[13],
	[3004] = dataList[14],
	[3005] = dataList[15]
}

t_divine_king_ci_yuan_monster.dataList = dataList

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

return t_divine_king_ci_yuan_monster
