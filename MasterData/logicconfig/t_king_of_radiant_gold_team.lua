-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_of_radiant_gold_team.lua

module("logicconfig.config.t_king_of_radiant_gold_team", package.seeall)

local title = {
	creepsMasterId = 1,
	name = 2,
	WinDesc = 6,
	skipTime = 3,
	formCondition = 9,
	btlBg = 4,
	selfBuffProviderId = 10,
	winId = 7,
	perfectWinId = 8,
	heroSkillId = 5
}
local dataList = {
	{
		1001,
		"第1关",
		5,
		"",
		"",
		"暴击次数越多，获得符文越多",
		0,
		0,
		0,
		0
	},
	{
		1002,
		"第2关",
		5,
		"",
		"",
		"连击次数越多，获得符文越多",
		0,
		0,
		0,
		193
	},
	{
		1003,
		"第3关",
		5,
		"",
		"",
		"超杀次数越多，获得符文越多",
		0,
		0,
		0,
		396
	},
	{
		1004,
		"第4关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0
	},
	{
		1005,
		"第5关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0
	},
	{
		1006,
		"第6关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0
	},
	{
		1007,
		"第7关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0
	},
	{
		1008,
		"第8关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		411
	},
	{
		1009,
		"第9关",
		5,
		"",
		"",
		"",
		0,
		0,
		0,
		0
	}
}
local t_king_of_radiant_gold_team = {
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

t_king_of_radiant_gold_team.dataList = dataList

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

return t_king_of_radiant_gold_team
