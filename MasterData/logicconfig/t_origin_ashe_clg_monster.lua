-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ashe_clg_monster.lua

module("logicconfig.config.t_origin_ashe_clg_monster", package.seeall)

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
		"源起艾希-1",
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
		1002,
		"源起艾希-2",
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
		"源起艾希-3",
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
		"源起艾希-4",
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
		"源起艾希-5",
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
		1006,
		"源起艾希-6",
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
		"源起艾希-7",
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
		"源起艾希-8",
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
		"源起艾希-9",
		3,
		0,
		0,
		0,
		"",
		"",
		"5",
		"6"
	}
}
local t_origin_ashe_clg_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9]
}

t_origin_ashe_clg_monster.dataList = dataList

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

return t_origin_ashe_clg_monster
