-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_dragon_team.lua

module("logicconfig.config.t_dark_dragon_team", package.seeall)

local title = {
	description = 8,
	name = 2,
	video = 9,
	skipTime = 3,
	perfectWinId = 12,
	formCondition = 13,
	ruleDesc = 15,
	btlMode = 7,
	btlBg = 4,
	selfBuffProviderId = 14,
	winId = 11,
	creepsMasterId = 1,
	heroSkillId = 5,
	recommendZdl = 6,
	introdRaceId = 10
}
local dataList = {
	{
		10101,
		"挑战 I-I",
		0,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵全部精灵"
	},
	{
		10102,
		"挑战 I-II",
		0,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵全部精灵"
	},
	{
		10103,
		"挑战 I-III",
		0,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵全部精灵"
	},
	{
		10104,
		"挑战 I-IV",
		0,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵全部精灵"
	},
	{
		10201,
		"挑战 II",
		0,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵全部精灵"
	},
	{
		10301,
		"挑战 III",
		0,
		"",
		"410142",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵全部精灵"
	},
	{
		10401,
		"挑战 IV",
		0,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵全部精灵"
	},
	{
		10501,
		"挑战 V",
		0,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵全部精灵"
	},
	{
		10601,
		"挑战 VI",
		0,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵全部精灵"
	},
	{
		10701,
		"挑战 VII-I",
		0,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵全部精灵"
	},
	{
		10702,
		"挑战 VII-II",
		0,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵全部精灵"
	},
	{
		10703,
		"挑战 VII-III",
		0,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵全部精灵"
	},
	{
		10704,
		"挑战 VII-IV",
		0,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵全部精灵"
	}
}
local t_dark_dragon_team = {
	[10101] = dataList[1],
	[10102] = dataList[2],
	[10103] = dataList[3],
	[10104] = dataList[4],
	[10201] = dataList[5],
	[10301] = dataList[6],
	[10401] = dataList[7],
	[10501] = dataList[8],
	[10601] = dataList[9],
	[10701] = dataList[10],
	[10702] = dataList[11],
	[10703] = dataList[12],
	[10704] = dataList[13]
}

t_dark_dragon_team.dataList = dataList

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

return t_dark_dragon_team
