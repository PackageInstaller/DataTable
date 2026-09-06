-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ashless_long_yan_monster.lua

module("logicconfig.config.t_ashless_long_yan_monster", package.seeall)

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
		"无烬龙炎Ⅰ-Ⅰ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		1002,
		"无烬龙炎Ⅰ-Ⅱ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		1003,
		"无烬龙炎Ⅰ-Ⅲ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		1004,
		"无烬龙炎Ⅰ-Ⅳ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		1005,
		"无烬龙炎Ⅰ-Ⅴ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		1006,
		"无烬龙炎Ⅰ-Ⅵ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		2001,
		"无烬龙炎Ⅱ-Ⅰ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		2002,
		"无烬龙炎Ⅱ-Ⅱ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		2003,
		"无烬龙炎Ⅱ-Ⅲ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		2004,
		"无烬龙炎Ⅱ-Ⅳ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		2005,
		"无烬龙炎Ⅱ-Ⅴ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		2006,
		"无烬龙炎Ⅱ-Ⅵ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		3001,
		"无烬龙炎Ⅲ-Ⅰ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		3002,
		"无烬龙炎Ⅲ-Ⅱ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		3003,
		"无烬龙炎Ⅲ-Ⅲ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		3004,
		"无烬龙炎Ⅲ-Ⅳ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		3005,
		"无烬龙炎Ⅲ-Ⅴ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	},
	{
		3006,
		"无烬龙炎Ⅲ-Ⅵ",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵即可过关"
	}
}
local t_ashless_long_yan_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[2001] = dataList[7],
	[2002] = dataList[8],
	[2003] = dataList[9],
	[2004] = dataList[10],
	[2005] = dataList[11],
	[2006] = dataList[12],
	[3001] = dataList[13],
	[3002] = dataList[14],
	[3003] = dataList[15],
	[3004] = dataList[16],
	[3005] = dataList[17],
	[3006] = dataList[18]
}

t_ashless_long_yan_monster.dataList = dataList

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

return t_ashless_long_yan_monster
