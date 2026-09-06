-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gulas_clg_monster.lua

module("logicconfig.config.t_gulas_clg_monster", package.seeall)

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
		"饥荒-1",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		1002,
		"饥荒-2",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		1003,
		"饥荒-3",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		1004,
		"饥荒-4",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		1005,
		"饥荒-5",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		1006,
		"饥荒-6",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		1007,
		"饥荒-7",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		1008,
		"饥荒-8",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		1009,
		"饥荒-9",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		1010,
		"饥荒-10",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		1011,
		"饥荒-11",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		1012,
		"饥荒-12",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		2001,
		"源起天蛮王-1",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		2002,
		"源起天蛮王-2",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		2003,
		"源起天蛮王-3",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		2004,
		"源起天蛮王-4",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		2005,
		"源起天蛮王-5",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		2006,
		"源起天蛮王-6",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		2007,
		"源起天蛮王-7",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		2008,
		"源起天蛮王-8",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		2009,
		"源起天蛮王-9",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		2010,
		"源起天蛮王-10",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		2011,
		"源起天蛮王-11",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	},
	{
		2012,
		"源起天蛮王-12",
		3,
		"",
		"",
		0,
		0,
		0,
		64,
		"",
		""
	}
}
local t_gulas_clg_monster = {
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

t_gulas_clg_monster.dataList = dataList

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

return t_gulas_clg_monster
