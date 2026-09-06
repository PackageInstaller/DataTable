-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_dishitian_master.lua

module("logicconfig.config.t_dragon_dishitian_master", package.seeall)

local title = {
	skipTime = 5,
	name = 2,
	WinDesc = 4,
	formCondition = 8,
	missionDesc = 3,
	heavenAwakenMasterId = 11,
	heavenAwakenSummonPetId = 12,
	stageDesc = 10,
	selfBuffProviderId = 7,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 9
}
local dataList = {
	{
		1001,
		"万事俱灭-1-1",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"",
		""
	},
	{
		1002,
		"万事俱灭-1-2",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"",
		""
	},
	{
		1003,
		"万事俱灭-1-3",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"",
		""
	},
	{
		1004,
		"万事俱灭-2-1",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"",
		""
	},
	{
		1005,
		"万事俱灭-2-2",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"",
		""
	},
	{
		1006,
		"万事俱灭-2-3",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"",
		""
	},
	{
		1007,
		"万事俱灭-3-1",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"",
		""
	},
	{
		1008,
		"万事俱灭-3-2",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"",
		""
	},
	{
		1009,
		"万事俱灭-3-3",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"",
		""
	},
	{
		2001,
		"青龙天玑-1-1",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"",
		""
	},
	{
		2002,
		"青龙天玑-1-2",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"5",
		"6"
	},
	{
		2003,
		"青龙天玑-1-3",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"414029",
		"击败敌阵全部精灵",
		"5",
		"6"
	},
	{
		2004,
		"苍龙玉衡-2-1",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"",
		""
	},
	{
		2005,
		"苍龙玉衡-2-2",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"",
		""
	},
	{
		2006,
		"苍龙玉衡-2-3",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"",
		""
	},
	{
		2007,
		"应龙开阳-3-1",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"5",
		"6"
	},
	{
		2008,
		"应龙开阳-3-2",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"",
		""
	},
	{
		2009,
		"应龙开阳-3-3",
		"",
		"击败敌阵全部精灵",
		3,
		0,
		0,
		0,
		"",
		"击败敌阵全部精灵",
		"",
		""
	}
}
local t_dragon_dishitian_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[2001] = dataList[10],
	[2002] = dataList[11],
	[2003] = dataList[12],
	[2004] = dataList[13],
	[2005] = dataList[14],
	[2006] = dataList[15],
	[2007] = dataList[16],
	[2008] = dataList[17],
	[2009] = dataList[18]
}

t_dragon_dishitian_master.dataList = dataList

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

return t_dragon_dishitian_master
