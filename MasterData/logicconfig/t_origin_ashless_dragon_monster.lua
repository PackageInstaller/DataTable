-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ashless_dragon_monster.lua

module("logicconfig.config.t_origin_ashless_dragon_monster", package.seeall)

local title = {
	skipTime = 3,
	name = 2,
	WinDesc = 8,
	formCondition = 6,
	heavenAwakenMasterId = 9,
	heavenAwakenSummonPetId = 10,
	selfBuffProviderId = 5,
	winId = 4,
	creepsMasterId = 1,
	heroSkillId = 7
}
local dataList = {
	{
		1001,
		"源起无烬龙-1",
		3,
		0,
		0,
		0,
		"",
		"本关建设度：存活精灵1只 建设度+10",
		"5",
		"6"
	},
	{
		1002,
		"源起无烬龙-2",
		3,
		0,
		0,
		0,
		"",
		"本关建设度：超杀数1次 建设度+5",
		"",
		""
	},
	{
		1003,
		"源起无烬龙-3",
		3,
		0,
		0,
		0,
		"",
		"本关建设度：存活精灵1只 建设度+10",
		"",
		""
	},
	{
		1004,
		"源起无烬龙-4",
		3,
		0,
		0,
		0,
		"",
		"本关建设度：超杀数1次 建设度+5",
		"5",
		"6"
	},
	{
		1005,
		"源起无烬龙-5",
		3,
		0,
		0,
		0,
		"",
		"本关建设度：存活精灵1只 建设度+10",
		"8",
		"9"
	},
	{
		1006,
		"源起无烬龙-6",
		3,
		0,
		0,
		0,
		"",
		"本关建设度：超杀数1次 建设度+5",
		"",
		""
	},
	{
		1007,
		"源起无烬龙-7",
		3,
		0,
		0,
		0,
		"",
		"本关建设度：存活精灵1只 建设度+10",
		"",
		""
	},
	{
		1008,
		"源起无烬龙-8",
		3,
		0,
		0,
		0,
		"",
		"本关建设度：超杀数1次 建设度+5",
		"",
		""
	}
}
local t_origin_ashless_dragon_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8]
}

t_origin_ashless_dragon_monster.dataList = dataList

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

return t_origin_ashless_dragon_monster
