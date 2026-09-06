-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_farnas_clg_creeps_master.lua

module("logicconfig.config.t_divine_farnas_clg_creeps_master", package.seeall)

local title = {
	skipTime = 3,
	ruleDesc = 8,
	heavenAwakenSummonPetId = 10,
	formCondition = 6,
	heavenAwakenMasterId = 9,
	name = 2,
	selfBuffProviderId = 5,
	winId = 4,
	creepsMasterId = 1,
	heroSkillId = 7
}
local dataList = {
	{
		1001,
		"毁灭关卡-1",
		5,
		0,
		0,
		0,
		"",
		"达到闪避次数且成功破阵",
		"5",
		"6"
	},
	{
		1002,
		"毁灭关卡-2",
		5,
		0,
		0,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		1003,
		"毁灭关卡-3",
		5,
		0,
		0,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		1004,
		"毁灭关卡-4",
		5,
		0,
		0,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		1005,
		"新生关卡-1",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		1006,
		"新生关卡-2",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"5",
		"6"
	},
	{
		1007,
		"新生关卡-3",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"8",
		"9"
	},
	{
		1008,
		"新生关卡-4",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"5",
		"6"
	},
	{
		2001,
		"阵-1",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		2002,
		"阵-2",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		2003,
		"阵-3",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		2004,
		"阵-4",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		2005,
		"阵-5",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		2006,
		"阵-6",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		2007,
		"阵-7",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		2008,
		"阵-8",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		2009,
		"阵-9",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		2010,
		"阵-10",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		2011,
		"阵-11",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		2012,
		"阵-12",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		2013,
		"阵-13",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		2014,
		"阵-14",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	},
	{
		2015,
		"阵-15",
		5,
		0,
		230,
		0,
		"",
		"达到闪避次数且成功破阵",
		"",
		""
	}
}
local t_divine_farnas_clg_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[2001] = dataList[9],
	[2002] = dataList[10],
	[2003] = dataList[11],
	[2004] = dataList[12],
	[2005] = dataList[13],
	[2006] = dataList[14],
	[2007] = dataList[15],
	[2008] = dataList[16],
	[2009] = dataList[17],
	[2010] = dataList[18],
	[2011] = dataList[19],
	[2012] = dataList[20],
	[2013] = dataList[21],
	[2014] = dataList[22],
	[2015] = dataList[23]
}

t_divine_farnas_clg_creeps_master.dataList = dataList

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

return t_divine_farnas_clg_creeps_master
