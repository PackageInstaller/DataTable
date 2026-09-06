-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_weileita_monster.lua

module("logicconfig.config.t_origin_weileita_monster", package.seeall)

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
		"源起维蕾塔-1",
		3,
		0,
		0,
		0,
		"",
		"",
		"5",
		"6"
	},
	{
		1002,
		"源起维蕾塔-2",
		3,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1003,
		"源起维蕾塔-3",
		3,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1004,
		"源起维蕾塔-4",
		3,
		0,
		0,
		0,
		"",
		"",
		"5",
		"6"
	},
	{
		1005,
		"源起维蕾塔-5",
		3,
		0,
		0,
		0,
		"",
		"",
		"8",
		"9"
	},
	{
		1006,
		"源起维蕾塔-6",
		3,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1007,
		"源起维蕾塔全民-1",
		3,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1008,
		"源起维蕾塔全民-2",
		3,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1009,
		"源起维蕾塔全民-3",
		3,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1010,
		"源起维蕾塔全民-4",
		3,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1011,
		"源起维蕾塔全民-5",
		3,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1012,
		"源起维蕾塔全民-6",
		3,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1013,
		"源起维蕾塔全民-7",
		3,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1014,
		"源起维蕾塔全民-8",
		3,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1015,
		"源起维蕾塔全民-9",
		3,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1016,
		"源起维蕾塔全民-10",
		3,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1017,
		"源起维蕾塔全民-11",
		3,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1018,
		"源起维蕾塔全民-12",
		3,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	}
}
local t_origin_weileita_monster = {
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

t_origin_weileita_monster.dataList = dataList

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

return t_origin_weileita_monster
