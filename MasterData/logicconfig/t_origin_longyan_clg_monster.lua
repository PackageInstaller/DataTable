-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_longyan_clg_monster.lua

module("logicconfig.config.t_origin_longyan_clg_monster", package.seeall)

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
		"源起龙炎-1",
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
		"源起龙炎-2",
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
		"源起龙炎-3",
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
		"源起龙炎-4",
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
		1005,
		"源起龙炎-5",
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
		"源起龙炎-6",
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
		1007,
		"源起龙炎-7",
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
		1008,
		"源起龙炎-8",
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
		"源起龙炎-9",
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
		"源起龙炎-10",
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
		"源起龙炎-11",
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
		"源起龙炎-12",
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
local t_origin_longyan_clg_monster = {
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

t_origin_longyan_clg_monster.dataList = dataList

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

return t_origin_longyan_clg_monster
