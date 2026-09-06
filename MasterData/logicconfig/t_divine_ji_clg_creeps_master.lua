-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ji_clg_creeps_master.lua

module("logicconfig.config.t_divine_ji_clg_creeps_master", package.seeall)

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
		"全民阵-1",
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
		1002,
		"全民阵-2",
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
		1003,
		"全民阵-3",
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
		1004,
		"全民阵-4",
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
		1005,
		"全民阵-5",
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
		1006,
		"全民阵-6",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"412012",
		""
	},
	{
		1007,
		"全民阵-7",
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
		1008,
		"全民阵-8",
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
		1009,
		"全民阵-9",
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
		1010,
		"全民阵-10",
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
		2001,
		"水试炼",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"415027",
		""
	},
	{
		2002,
		"火试炼",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"414025",
		""
	},
	{
		2003,
		"草试炼",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"414027",
		""
	},
	{
		2004,
		"光试炼",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"413015",
		""
	},
	{
		2005,
		"暗试炼",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"414029",
		""
	},
	{
		2006,
		"空试炼",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"417020",
		""
	}
}
local t_divine_ji_clg_creeps_master = {
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
	[2001] = dataList[11],
	[2002] = dataList[12],
	[2003] = dataList[13],
	[2004] = dataList[14],
	[2005] = dataList[15],
	[2006] = dataList[16]
}

t_divine_ji_clg_creeps_master.dataList = dataList

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

return t_divine_ji_clg_creeps_master
