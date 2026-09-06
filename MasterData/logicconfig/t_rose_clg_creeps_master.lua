-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rose_clg_creeps_master.lua

module("logicconfig.config.t_rose_clg_creeps_master", package.seeall)

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
		"阵-1",
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
		1002,
		"阵-2",
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
		1003,
		"阵-3",
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
		1004,
		"阵-4",
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
		1005,
		"阵-5",
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
		1006,
		"阵-6",
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
		1007,
		"阵-7",
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
		1008,
		"阵-8",
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
		1009,
		"阵-9",
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
		1010,
		"阵-10",
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
		1011,
		"阵-11",
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
		1012,
		"阵-12",
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
		1013,
		"阵-13",
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
		1014,
		"阵-14",
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
local t_rose_clg_creeps_master = {
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
	[1014] = dataList[14]
}

t_rose_clg_creeps_master.dataList = dataList

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

return t_rose_clg_creeps_master
