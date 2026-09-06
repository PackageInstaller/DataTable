-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dishitian_clg_team.lua

module("logicconfig.config.t_origin_dishitian_clg_team", package.seeall)

local title = {
	creepsMasterId = 1,
	name = 2,
	WinDesc = 5,
	formCondition = 8,
	skipTime = 3,
	heavenAwakenMasterId = 10,
	heavenAwakenSummonPetId = 11,
	selfBuffProviderId = 9,
	winId = 6,
	perfectWinId = 7,
	heroSkillId = 4
}
local dataList = {
	{
		1001,
		"源起帝释天-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1002,
		"源起帝释天-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1003,
		"源起帝释天-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1004,
		"源起帝释天-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1005,
		"源起帝释天-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"5",
		"6"
	},
	{
		1006,
		"源起帝释天-6",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"5",
		"6"
	},
	{
		1007,
		"源起帝释天-7",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1008,
		"源起帝释天-8",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1009,
		"源起帝释天-9",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1010,
		"源起帝释天-10",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1011,
		"源起帝释天-11",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1012,
		"源起帝释天-12",
		5,
		"412044",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		2001,
		"源起光明王-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		2002,
		"源起光明王-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		2003,
		"源起光明王-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		2004,
		"源起光明王-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		2005,
		"源起光明王-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"5",
		"6"
	},
	{
		2006,
		"源起光明王-6",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"5",
		"6"
	},
	{
		2007,
		"源起光明王-7",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		2008,
		"源起光明王-8",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		2009,
		"源起光明王-9",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		2010,
		"源起光明王-10",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		2011,
		"源起光明王-11",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		2012,
		"源起光明王-12",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"6",
		"7"
	}
}
local t_origin_dishitian_clg_team = {
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
	[2001] = dataList[13],
	[2002] = dataList[14],
	[2003] = dataList[15],
	[2004] = dataList[16],
	[2005] = dataList[17],
	[2006] = dataList[18],
	[2007] = dataList[19],
	[2008] = dataList[20],
	[2009] = dataList[21],
	[2010] = dataList[22],
	[2011] = dataList[23],
	[2012] = dataList[24]
}

t_origin_dishitian_clg_team.dataList = dataList

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

return t_origin_dishitian_clg_team
