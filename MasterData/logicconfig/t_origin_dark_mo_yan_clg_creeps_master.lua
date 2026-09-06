-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dark_mo_yan_clg_creeps_master.lua

module("logicconfig.config.t_origin_dark_mo_yan_clg_creeps_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	heavenAwakenSummonPetId = 12,
	skipTime = 3,
	retreatMsgType = 7,
	heavenAwakenMasterId = 11,
	ruleDesc = 13,
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
		82057708,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1002,
		82057709,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1003,
		82057710,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1004,
		82057711,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1005,
		82057712,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1006,
		82057713,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1007,
		82057714,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1008,
		82057715,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1009,
		82057716,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1010,
		82057717,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1011,
		82057718,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1012,
		82057719,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1013,
		82057720,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1014,
		82057721,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1015,
		82057722,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1016,
		82057723,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1017,
		82057724,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	},
	{
		1018,
		82057725,
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		82057993
	}
}
local t_origin_dark_mo_yan_clg_creeps_master = {
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

t_origin_dark_mo_yan_clg_creeps_master.dataList = dataList

local multiLanguageCells = {
	ruleDesc = true,
	name = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_origin_dark_mo_yan_clg_creeps_master
