-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_empress_clg_creeps_master.lua

module("logicconfig.config.t_divine_empress_clg_creeps_master", package.seeall)

local title = {
	skipTime = 3,
	heavenAwakenMasterId = 8,
	heavenAwakenSummonPetId = 9,
	formCondition = 6,
	name = 2,
	ruleDesc = 10,
	selfBuffProviderId = 5,
	winId = 4,
	creepsMasterId = 1,
	heroSkillId = 7
}
local dataList = {
	{
		1001,
		"神曜女帝-1",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		1002,
		"神曜女帝-2",
		5,
		0,
		457,
		0,
		"",
		"5",
		"6",
		""
	},
	{
		1003,
		"神曜女帝-3",
		5,
		0,
		457,
		0,
		"",
		"5",
		"6",
		""
	},
	{
		1004,
		"神曜女帝-4",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		1005,
		"神曜女帝-5",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		1006,
		"神曜女帝-6",
		5,
		0,
		457,
		0,
		"",
		"5",
		"6",
		""
	},
	{
		2001,
		"阵-1",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		2002,
		"阵-2",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		2003,
		"阵-3",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		2004,
		"阵-4",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		2005,
		"阵-5",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		2006,
		"阵-6",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		2007,
		"阵-7",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		2008,
		"阵-8",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		2009,
		"阵-9",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		2010,
		"阵-10",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		2011,
		"阵-11",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		2012,
		"阵-12",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		2013,
		"阵-13",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		2014,
		"阵-14",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	},
	{
		2015,
		"阵-15",
		5,
		0,
		457,
		0,
		"",
		"",
		"",
		""
	}
}
local t_divine_empress_clg_creeps_master = {
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

t_divine_empress_clg_creeps_master.dataList = dataList

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

return t_divine_empress_clg_creeps_master
