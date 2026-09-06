-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_jiu_clg_team.lua

module("logicconfig.config.t_origin_jiu_clg_team", package.seeall)

local title = {
	skipTime = 3,
	name = 2,
	WinDesc = 5,
	formCondition = 7,
	heavenAwakenMasterId = 9,
	heavenAwakenSummonPetId = 10,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 4
}
local dataList = {
	{
		1001,
		"源起究-1",
		5,
		"",
		"敌阵精灵获得50点气势和免伤及非伤免伤+20%，并在受到非克制伤害时，将此次伤害降低30%",
		0,
		0,
		0,
		"5",
		"6"
	},
	{
		1002,
		"源起究-2",
		5,
		"",
		"敌阵精灵获得50点气势和免伤及非伤免伤+20%，并在受到非克制伤害时，将此次伤害降低30%",
		0,
		0,
		0,
		"",
		""
	},
	{
		1003,
		"源起究-3",
		5,
		"",
		"敌阵精灵获得50点气势和免伤及非伤免伤+20%，并在受到非克制伤害时，将此次伤害降低30%",
		0,
		0,
		0,
		"",
		""
	},
	{
		1004,
		"源起究-4",
		5,
		"413029",
		"敌阵精灵获得50点气势和免伤及非伤免伤+20%，并在受到非克制伤害时，将此次伤害降低30%",
		0,
		0,
		0,
		"5",
		"6"
	},
	{
		1005,
		"源起究-5",
		5,
		"",
		"敌阵精灵获得50点气势和免伤及非伤免伤+20%，并在受到非克制伤害时，将此次伤害降低30%",
		0,
		0,
		0,
		"7",
		"8"
	},
	{
		1006,
		"源起究-6",
		5,
		"",
		"敌阵精灵获得50点气势和免伤及非伤免伤+20%，并在受到非克制伤害时，将此次伤害降低30%",
		0,
		0,
		0,
		"5",
		"6"
	},
	{
		1007,
		"源起究-7",
		5,
		"",
		"敌阵精灵获得50点气势和免伤及非伤免伤+20%，并在受到非克制伤害时，将此次伤害降低30%",
		0,
		0,
		0,
		"8",
		"9"
	},
	{
		1008,
		"源起究全民-1",
		5,
		"",
		"",
		0,
		0,
		0,
		"",
		""
	},
	{
		1009,
		"源起究全民-2",
		5,
		"",
		"",
		0,
		0,
		0,
		"",
		""
	},
	{
		1010,
		"源起究全民-3",
		5,
		"",
		"",
		0,
		0,
		0,
		"",
		""
	},
	{
		1011,
		"源起究全民-4",
		5,
		"",
		"",
		0,
		0,
		0,
		"",
		""
	},
	{
		1012,
		"源起究全民-5",
		5,
		"",
		"",
		0,
		0,
		0,
		"",
		""
	},
	{
		1013,
		"源起究全民-6",
		5,
		"",
		"",
		0,
		0,
		0,
		"",
		""
	},
	{
		1014,
		"源起究全民-7",
		5,
		"",
		"",
		0,
		0,
		0,
		"",
		""
	}
}
local t_origin_jiu_clg_team = {
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
	[1014] = dataList[14]
}

t_origin_jiu_clg_team.dataList = dataList

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

return t_origin_jiu_clg_team
