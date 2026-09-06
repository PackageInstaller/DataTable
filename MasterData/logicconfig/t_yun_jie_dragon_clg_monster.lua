-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_yun_jie_dragon_clg_monster.lua

module("logicconfig.config.t_yun_jie_dragon_clg_monster", package.seeall)

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
		"殒劫圣龙-1",
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
		"殒劫圣龙-2",
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
		"殒劫圣龙-3",
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
		"殒劫圣龙-4",
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
		"殒劫圣龙-5",
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
		"殒劫圣龙-6",
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
		"殒劫圣龙-7",
		3,
		0,
		0,
		0,
		"413029",
		"",
		"5",
		"6"
	},
	{
		1008,
		"殒劫圣龙-8",
		3,
		0,
		0,
		0,
		"",
		"",
		"7",
		"8"
	},
	{
		1009,
		"殒劫圣龙-9",
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
local t_yun_jie_dragon_clg_monster = {
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

t_yun_jie_dragon_clg_monster.dataList = dataList

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

return t_yun_jie_dragon_clg_monster
