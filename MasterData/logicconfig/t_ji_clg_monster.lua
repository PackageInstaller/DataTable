-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ji_clg_monster.lua

module("logicconfig.config.t_ji_clg_monster", package.seeall)

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
		"诺亚试炼",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵后BOSS关卡大回合改为5个"
	},
	{
		1002,
		"帝释天试炼",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵后BOSS关卡每次攻击附带自身攻击力*200%的伤害"
	},
	{
		1003,
		"阿瑞斯试炼",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵后BOSS关卡BOSS每次受击极限伤害变为100万"
	},
	{
		1004,
		"修尔试炼",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵后BOSS关卡每个大回合开始时获得100点气势"
	},
	{
		1005,
		"龙炎试炼",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵后BOSS关卡全阵精灵全属性+100%"
	},
	{
		1006,
		"极试炼",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"3个大回合后结束战斗，每次受击最多受到50万伤害"
	},
	{
		2001,
		"光-1",
		3,
		"",
		"",
		0,
		0,
		0,
		75,
		"414020",
		""
	},
	{
		2002,
		"光-2",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"415020",
		""
	},
	{
		2003,
		"光-3",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"416020",
		""
	},
	{
		2004,
		"暗-1",
		3,
		"",
		"",
		0,
		0,
		0,
		69,
		"411020",
		""
	},
	{
		2005,
		"暗-2",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"413009",
		""
	},
	{
		2006,
		"暗-3",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"411012",
		""
	},
	{
		2007,
		"水-1",
		3,
		"",
		"",
		0,
		0,
		0,
		171,
		"416020",
		""
	},
	{
		2008,
		"水-2",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"414024",
		""
	},
	{
		2009,
		"水-3",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"417010",
		""
	},
	{
		2010,
		"火-1",
		3,
		"",
		"",
		0,
		0,
		0,
		170,
		"411012",
		""
	},
	{
		2011,
		"火-2",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"417010",
		""
	},
	{
		2012,
		"火-3",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"414020",
		""
	},
	{
		2013,
		"草-1",
		3,
		"",
		"",
		0,
		0,
		0,
		42,
		"415020",
		""
	},
	{
		2014,
		"草-2",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"416020",
		""
	},
	{
		2015,
		"草-3",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"414024",
		""
	}
}
local t_ji_clg_monster = {
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
	[2007] = dataList[13],
	[2008] = dataList[14],
	[2009] = dataList[15],
	[2010] = dataList[16],
	[2011] = dataList[17],
	[2012] = dataList[18],
	[2013] = dataList[19],
	[2014] = dataList[20],
	[2015] = dataList[21]
}

t_ji_clg_monster.dataList = dataList

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

return t_ji_clg_monster
