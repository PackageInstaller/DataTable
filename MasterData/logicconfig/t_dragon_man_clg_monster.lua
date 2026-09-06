-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_man_clg_monster.lua

module("logicconfig.config.t_dragon_man_clg_monster", package.seeall)

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
		"源起炎龙侠-1",
		3,
		171,
		0,
		0,
		"",
		"破阵，且己方精灵存活数量≥3",
		"",
		""
	},
	{
		1002,
		"源起炎龙侠-2",
		3,
		171,
		0,
		0,
		"",
		"破阵，且己方精灵存活数量≥3",
		"",
		""
	},
	{
		1003,
		"源起炎龙侠-3",
		3,
		171,
		0,
		0,
		"",
		"破阵，且己方精灵存活数量≥3",
		"",
		""
	},
	{
		1004,
		"源起炎龙侠-4",
		3,
		170,
		0,
		0,
		"",
		"破阵，且己方精灵存活数量≥4",
		"",
		""
	},
	{
		1005,
		"源起炎龙侠-5",
		3,
		170,
		0,
		0,
		"",
		"破阵，且己方精灵存活数量≥4",
		"",
		""
	},
	{
		1006,
		"源起炎龙侠-6",
		3,
		170,
		0,
		0,
		"",
		"破阵，且己方精灵存活数量≥4",
		"",
		""
	},
	{
		1007,
		"源起炎龙侠-7",
		3,
		188,
		0,
		0,
		"",
		"破阵，且己方精灵存活数量≥5",
		"",
		""
	},
	{
		1008,
		"源起炎龙侠-8",
		3,
		188,
		0,
		0,
		"",
		"破阵，且己方精灵存活数量≥5",
		"",
		""
	},
	{
		1009,
		"源起炎龙侠-9",
		3,
		188,
		0,
		0,
		"",
		"破阵，且己方精灵存活数量≥5",
		"",
		""
	},
	{
		1010,
		"源起炎龙侠-10",
		3,
		187,
		0,
		0,
		"",
		"破阵，且己方精灵存活数量≥6",
		"5",
		"6"
	},
	{
		1011,
		"源起炎龙侠-11",
		3,
		187,
		0,
		0,
		"",
		"破阵，且己方精灵存活数量≥6",
		"7",
		"8"
	},
	{
		1012,
		"源起炎龙侠-12",
		3,
		187,
		0,
		0,
		"",
		"破阵，且己方精灵存活数量≥6",
		"",
		""
	}
}
local t_dragon_man_clg_monster = {
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

t_dragon_man_clg_monster.dataList = dataList

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

return t_dragon_man_clg_monster
