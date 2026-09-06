-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_team_chapter_master.lua

module("logicconfig.config.t_dream_team_chapter_master", package.seeall)

local title = {
	skipTime = 3,
	heavenAwakenMasterId = 8,
	heavenAwakenSummonPetId = 9,
	formCondition = 6,
	name = 2,
	ruleDesc = 10,
	selfBuffProviderId = 5,
	winId = 4,
	creepsMasterId = 1,
	heroSkillId = 7
}
local dataList = {
	{
		1001,
		"梦队副本-1",
		5,
		0,
		0,
		232,
		"",
		"",
		"",
		""
	},
	{
		1002,
		"梦队副本-2",
		5,
		0,
		0,
		232,
		"",
		"",
		"",
		""
	},
	{
		1003,
		"梦队副本-3",
		5,
		0,
		0,
		232,
		"",
		"",
		"",
		""
	},
	{
		1004,
		"梦队副本-4",
		5,
		0,
		0,
		232,
		"",
		"",
		"",
		""
	},
	{
		1005,
		"梦队副本-5",
		5,
		0,
		0,
		232,
		"",
		"5",
		"6",
		""
	},
	{
		1006,
		"梦队副本-6",
		5,
		0,
		0,
		231,
		"",
		"5",
		"6",
		""
	},
	{
		1007,
		"梦队副本-7",
		5,
		0,
		0,
		231,
		"",
		"",
		"",
		""
	},
	{
		1008,
		"梦队副本-8",
		5,
		0,
		0,
		231,
		"",
		"",
		"",
		""
	},
	{
		1009,
		"梦队副本-9",
		5,
		0,
		0,
		231,
		"",
		"",
		"",
		""
	},
	{
		1010,
		"梦队副本-10",
		5,
		0,
		0,
		231,
		"",
		"",
		"",
		""
	},
	{
		1011,
		"梦队副本-11",
		5,
		0,
		0,
		233,
		"",
		"",
		"",
		""
	},
	{
		1012,
		"梦队副本-12",
		5,
		0,
		0,
		233,
		"",
		"",
		"",
		""
	},
	{
		1013,
		"梦队副本-13",
		5,
		0,
		0,
		233,
		"",
		"",
		"",
		""
	},
	{
		1014,
		"梦队副本-14",
		5,
		0,
		0,
		233,
		"",
		"",
		"",
		""
	},
	{
		1015,
		"梦队副本-15",
		5,
		0,
		0,
		233,
		"",
		"",
		"",
		""
	},
	{
		1016,
		"梦队副本-16",
		5,
		0,
		0,
		230,
		"",
		"",
		"",
		""
	},
	{
		1017,
		"梦队副本-17",
		5,
		0,
		0,
		230,
		"",
		"",
		"",
		""
	},
	{
		1018,
		"梦队副本-18",
		5,
		0,
		0,
		230,
		"",
		"",
		"",
		""
	},
	{
		1019,
		"梦队副本-19",
		5,
		0,
		0,
		230,
		"",
		"",
		"",
		""
	},
	{
		1020,
		"梦队副本-20",
		5,
		0,
		0,
		230,
		"",
		"",
		"",
		""
	},
	{
		1021,
		"梦魇",
		5,
		117,
		0,
		0,
		"",
		"",
		"",
		"在10个回合内造成尽可能多的伤害"
	}
}
local t_dream_team_chapter_master = {
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
	[1021] = dataList[21]
}

t_dream_team_chapter_master.dataList = dataList

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

return t_dream_team_chapter_master
