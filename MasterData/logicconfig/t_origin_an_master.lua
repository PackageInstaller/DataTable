-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_an_master.lua

module("logicconfig.config.t_origin_an_master", package.seeall)

local title = {
	skipTime = 3,
	name = 2,
	heavenAwakenSummonPetId = 10,
	formCondition = 7,
	retreatMsgType = 5,
	heavenAwakenMasterId = 9,
	ruleDesc = 11,
	selfBuffProviderId = 6,
	winId = 4,
	creepsMasterId = 1,
	heroSkillId = 8
}
local dataList = {
	{
		1001,
		"源起安-1",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1002,
		"源起安-2",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1003,
		"源起安-3",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1004,
		"源起安-4",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1005,
		"源起安-5",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1006,
		"源起安-6",
		5,
		0,
		0,
		595,
		0,
		"",
		"5",
		"6",
		""
	},
	{
		1007,
		"源起安全民-1",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1008,
		"源起安全民-2",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1009,
		"源起安全民-3",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1010,
		"源起安全民-4",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1011,
		"源起安全民-5",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1012,
		"源起安全民-6",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1013,
		"源起安全民-7",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1014,
		"源起安全民-8",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1015,
		"源起安全民-9",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1016,
		"源起安全民-10",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1017,
		"源起安全民-11",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	},
	{
		1018,
		"源起安全民-12",
		5,
		0,
		0,
		595,
		0,
		"",
		"",
		"",
		""
	}
}
local t_origin_an_master = {
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
	[1018] = dataList[18]
}

t_origin_an_master.dataList = dataList

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

return t_origin_an_master
