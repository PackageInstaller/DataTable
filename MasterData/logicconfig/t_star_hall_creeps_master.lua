-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_hall_creeps_master.lua

module("logicconfig.config.t_star_hall_creeps_master", package.seeall)

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
		"关卡-1",
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
		"关卡-1",
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
		"关卡-1",
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
		"关卡-2",
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
		"关卡-2",
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
		1006,
		"关卡-2",
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
		1007,
		"关卡-3",
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
		"关卡-3",
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
		"关卡-3",
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
		"关卡-4",
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
		"关卡-4",
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
		"关卡-4",
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
		1013,
		"关卡-5",
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
		1014,
		"关卡-5",
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
		1015,
		"关卡-5",
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
		1016,
		"关卡-6",
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
		1017,
		"关卡-6",
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
		1018,
		"关卡-6",
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
		1019,
		"关卡-7",
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
		1020,
		"关卡-7",
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
		1021,
		"关卡-7",
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
		1022,
		"关卡-8",
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
		1023,
		"关卡-8",
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
		1024,
		"关卡-8",
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
		1025,
		"关卡-9",
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
		1026,
		"关卡-9",
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
		1027,
		"关卡-9",
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
		1028,
		"关卡-10",
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
		1029,
		"关卡-10",
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
		1030,
		"关卡-10",
		5,
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
local t_star_hall_creeps_master = {
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
	[1015] = dataList[15],
	[1016] = dataList[16],
	[1017] = dataList[17],
	[1018] = dataList[18],
	[1019] = dataList[19],
	[1020] = dataList[20],
	[1021] = dataList[21],
	[1022] = dataList[22],
	[1023] = dataList[23],
	[1024] = dataList[24],
	[1025] = dataList[25],
	[1026] = dataList[26],
	[1027] = dataList[27],
	[1028] = dataList[28],
	[1029] = dataList[29],
	[1030] = dataList[30]
}

t_star_hall_creeps_master.dataList = dataList

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

return t_star_hall_creeps_master
