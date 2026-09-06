-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_night_feast_boss_clg_monster.lua

module("logicconfig.config.t_night_feast_boss_clg_monster", package.seeall)

local title = {
	skipTime = 10,
	name = 2,
	formCondition = 8,
	retreatMsgType = 6,
	btlMode = 4,
	btlBg = 3,
	selfBuffProviderId = 7,
	winId = 5,
	creepsMasterId = 1,
	heroSkillId = 9
}
local dataList = {
	{
		1001,
		"技能点-阵1",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		1002,
		"技能点-阵2",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		1003,
		"技能点-阵3",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		1004,
		"技能点-阵4",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		1005,
		"技能点-阵5",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		1006,
		"技能点-阵6",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		1007,
		"技能点-阵7",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		1008,
		"技能点-阵8",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		1009,
		"技能点-阵9",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		1010,
		"技能点-阵10",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		1011,
		"技能点-阵11",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		1012,
		"技能点-阵12",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		1013,
		"技能点-阵13",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		1014,
		"技能点-阵14",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		1015,
		"技能点-阵15",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		9999,
		"盛宴boss",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		2001,
		"技能点-阵1",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		2002,
		"技能点-阵2",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		2003,
		"技能点-阵3",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		2004,
		"技能点-阵4",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		2005,
		"技能点-阵5",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		2006,
		"技能点-阵6",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		2007,
		"技能点-阵7",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		2008,
		"技能点-阵8",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		2009,
		"技能点-阵9",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		2010,
		"技能点-阵10",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		2011,
		"技能点-阵11",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		2012,
		"技能点-阵12",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		2013,
		"技能点-阵13",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		2014,
		"技能点-阵14",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		2015,
		"技能点-阵15",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		9001,
		"僵尸-希望",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		9002,
		"魅魔-超神",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	},
	{
		9003,
		"绷带-悼影",
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		5
	}
}
local t_night_feast_boss_clg_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[1010] = dataList[10],
	[1011] = dataList[11],
	[1012] = dataList[12],
	[1013] = dataList[13],
	[1014] = dataList[14],
	[1015] = dataList[15],
	[9999] = dataList[16],
	[2001] = dataList[17],
	[2002] = dataList[18],
	[2003] = dataList[19],
	[2004] = dataList[20],
	[2005] = dataList[21],
	[2006] = dataList[22],
	[2007] = dataList[23],
	[2008] = dataList[24],
	[2009] = dataList[25],
	[2010] = dataList[26],
	[2011] = dataList[27],
	[2012] = dataList[28],
	[2013] = dataList[29],
	[2014] = dataList[30],
	[2015] = dataList[31],
	[9001] = dataList[32],
	[9002] = dataList[33],
	[9003] = dataList[34]
}

t_night_feast_boss_clg_monster.dataList = dataList

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

return t_night_feast_boss_clg_monster
