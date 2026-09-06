-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_king_aruishi_challenge_team.lua

module("logicconfig.config.t_dragon_king_aruishi_challenge_team", package.seeall)

local title = {
	description = 8,
	name = 2,
	video = 9,
	skipTime = 3,
	perfectWinId = 12,
	formCondition = 13,
	redPoint = 15,
	btlMode = 7,
	btlBg = 4,
	selfBuffProviderId = 14,
	winId = 11,
	creepsMasterId = 1,
	heroSkillId = 5,
	recommendZdl = 6,
	introdRaceId = 10
}
local dataList = {
	{
		101,
		"龙魂试炼1",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		175,
		0,
		0,
		0,
		0
	},
	{
		102,
		"龙魂试炼2",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		176,
		0,
		0,
		0,
		0
	},
	{
		103,
		"龙魂试炼3",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		177,
		0,
		0,
		0,
		0
	},
	{
		104,
		"龙魂试炼4",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		178,
		0,
		0,
		0,
		0
	},
	{
		105,
		"龙魂试炼5",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		179,
		0,
		0,
		0,
		0
	},
	{
		106,
		"龙魂试炼6",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		180,
		0,
		0,
		0,
		0
	},
	{
		107,
		"龙魂试炼7",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		181,
		0,
		0,
		0,
		0
	},
	{
		108,
		"龙魂试炼8",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		182,
		0,
		0,
		0,
		0
	},
	{
		109,
		"龙魂试炼9",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		183,
		0,
		0,
		0,
		0
	}
}
local t_dragon_king_aruishi_challenge_team = {
	[101] = dataList[1],
	[102] = dataList[2],
	[103] = dataList[3],
	[104] = dataList[4],
	[105] = dataList[5],
	[106] = dataList[6],
	[107] = dataList[7],
	[108] = dataList[8],
	[109] = dataList[9]
}

t_dragon_king_aruishi_challenge_team.dataList = dataList

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

return t_dragon_king_aruishi_challenge_team
