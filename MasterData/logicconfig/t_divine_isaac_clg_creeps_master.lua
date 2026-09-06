-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_isaac_clg_creeps_master.lua

module("logicconfig.config.t_divine_isaac_clg_creeps_master", package.seeall)

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
		"神曜以撒-1-1",
		5,
		"",
		"",
		0,
		0,
		456,
		0,
		"",
		""
	},
	{
		1002,
		"神曜以撒-1-2",
		5,
		"",
		"",
		0,
		0,
		456,
		0,
		"",
		""
	},
	{
		1003,
		"神曜以撒-1-3",
		5,
		"",
		"",
		0,
		0,
		456,
		0,
		"",
		""
	},
	{
		1004,
		"神曜以撒-2-1",
		5,
		"",
		"",
		0,
		0,
		456,
		0,
		"",
		""
	},
	{
		1005,
		"神曜以撒-2-2",
		5,
		"",
		"",
		0,
		0,
		456,
		0,
		"",
		""
	},
	{
		1006,
		"神曜以撒-2-3",
		5,
		"",
		"",
		0,
		0,
		456,
		0,
		"",
		""
	},
	{
		1007,
		"神曜以撒-2-4",
		5,
		"",
		"",
		0,
		0,
		456,
		0,
		"",
		""
	},
	{
		1008,
		"神曜以撒-2-5",
		5,
		"",
		"",
		0,
		0,
		456,
		0,
		"",
		""
	},
	{
		1009,
		"神曜以撒-3-1",
		5,
		"",
		"",
		0,
		0,
		456,
		0,
		"",
		""
	},
	{
		1010,
		"神曜以撒-3-2",
		5,
		"",
		"",
		0,
		0,
		456,
		0,
		"",
		""
	},
	{
		1011,
		"神曜以撒-3-3",
		5,
		"",
		"",
		0,
		0,
		456,
		0,
		"",
		""
	},
	{
		1012,
		"神曜以撒-3-4",
		5,
		"",
		"",
		0,
		0,
		456,
		0,
		"",
		""
	},
	{
		1013,
		"神曜以撒-3-5",
		5,
		"",
		"",
		0,
		0,
		456,
		0,
		"",
		""
	},
	{
		1014,
		"神曜以撒-3-6",
		5,
		"",
		"",
		0,
		0,
		456,
		0,
		"",
		""
	},
	{
		1015,
		"神曜以撒-3-7",
		5,
		"",
		"",
		0,
		0,
		456,
		0,
		"",
		""
	}
}
local t_divine_isaac_clg_creeps_master = {
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
	[1015] = dataList[15]
}

t_divine_isaac_clg_creeps_master.dataList = dataList

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

return t_divine_isaac_clg_creeps_master
