-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mi_ya_clg_creeps_master.lua

module("logicconfig.config.t_divine_mi_ya_clg_creeps_master", package.seeall)

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
		"时刻1阵",
		5,
		"",
		"",
		0,
		0,
		0,
		59,
		"414025",
		""
	},
	{
		1002,
		"时刻2阵",
		5,
		"",
		"",
		0,
		0,
		0,
		59,
		"411012",
		""
	},
	{
		1003,
		"时刻3阵",
		5,
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
		1004,
		"时刻4阵",
		5,
		"",
		"",
		0,
		0,
		0,
		57,
		"411010",
		""
	},
	{
		1005,
		"时刻5阵",
		5,
		"",
		"",
		0,
		0,
		0,
		55,
		"414024",
		""
	},
	{
		1006,
		"时刻6阵",
		5,
		"",
		"",
		0,
		0,
		0,
		55,
		"412012",
		""
	},
	{
		1007,
		"时刻7阵",
		5,
		"",
		"",
		0,
		0,
		0,
		56,
		"411020",
		""
	},
	{
		1008,
		"时刻8阵",
		5,
		"",
		"",
		0,
		0,
		0,
		56,
		"416020",
		""
	},
	{
		1009,
		"时刻9阵",
		5,
		"",
		"",
		0,
		0,
		0,
		58,
		"415020",
		""
	},
	{
		1010,
		"时刻10阵",
		5,
		"",
		"",
		0,
		0,
		0,
		58,
		"417010",
		""
	},
	{
		1011,
		"时刻11阵",
		5,
		"",
		"",
		0,
		0,
		0,
		196,
		"414020",
		""
	},
	{
		1012,
		"时刻12阵",
		5,
		"",
		"",
		0,
		0,
		0,
		196,
		"412018",
		""
	}
}
local t_divine_mi_ya_clg_creeps_master = {
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
	[1012] = dataList[12]
}

t_divine_mi_ya_clg_creeps_master.dataList = dataList

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

return t_divine_mi_ya_clg_creeps_master
