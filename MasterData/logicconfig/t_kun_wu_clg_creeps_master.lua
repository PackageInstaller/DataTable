-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kun_wu_clg_creeps_master.lua

module("logicconfig.config.t_kun_wu_clg_creeps_master", package.seeall)

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
		"极限阵-1-1",
		3,
		"",
		"",
		0,
		0,
		0,
		55,
		"416028",
		""
	},
	{
		1002,
		"极限阵-1-2",
		3,
		"",
		"",
		0,
		0,
		0,
		56,
		"414024",
		""
	},
	{
		1003,
		"极限阵-1-3",
		3,
		"",
		"",
		0,
		0,
		0,
		57,
		"414020",
		""
	},
	{
		1004,
		"极限阵-2-1",
		3,
		"",
		"",
		0,
		0,
		0,
		55,
		"411020",
		""
	},
	{
		1005,
		"极限阵-2-2",
		3,
		"",
		"",
		0,
		0,
		0,
		56,
		"413020",
		""
	},
	{
		1006,
		"极限阵-2-3",
		3,
		"",
		"",
		0,
		0,
		0,
		57,
		"413015",
		""
	},
	{
		2001,
		"全民阵-1",
		3,
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
		"全民阵-2",
		3,
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
		"全民阵-3",
		3,
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
		"全民阵-4",
		3,
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
		"全民阵-5",
		3,
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
		2006,
		"全民阵-6",
		3,
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
		2007,
		"全民阵-7",
		3,
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
		"全民阵-8",
		3,
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
		"全民阵-9",
		3,
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
		"全民阵-10",
		3,
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
		"全民阵-11",
		3,
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
		"全民阵-12",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	}
}
local t_kun_wu_clg_creeps_master = {
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
	[2012] = dataList[18]
}

t_kun_wu_clg_creeps_master.dataList = dataList

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

return t_kun_wu_clg_creeps_master
