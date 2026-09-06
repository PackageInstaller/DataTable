-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_judgment_dragon_clg_monster.lua

module("logicconfig.config.t_judgment_dragon_clg_monster", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	ruleDesc = 11,
	skipTime = 3,
	retreatMsgType = 7,
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
		"命渊-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1002,
		"命渊-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1003,
		"命渊-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1004,
		"命渊-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1005,
		"命渊-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1006,
		"命渊-6",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		""
	},
	{
		1007,
		"命渊-7",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		""
	},
	{
		1008,
		"命渊-8",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1009,
		"命渊-9",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1010,
		"命渊-10",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		""
	},
	{
		1011,
		"命渊-11",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1012,
		"命渊-12",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1013,
		"命渊-13",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1014,
		"命渊-14",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1015,
		"命渊-15",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		""
	}
}
local t_judgment_dragon_clg_monster = {
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
	[1015] = dataList[15]
}

t_judgment_dragon_clg_monster.dataList = dataList

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

return t_judgment_dragon_clg_monster
