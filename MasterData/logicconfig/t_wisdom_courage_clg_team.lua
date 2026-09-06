-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wisdom_courage_clg_team.lua

module("logicconfig.config.t_wisdom_courage_clg_team", package.seeall)

local title = {
	description = 8,
	name = 2,
	video = 9,
	skipTime = 3,
	perfectWinId = 12,
	formCondition = 13,
	btlMode = 7,
	btlBg = 4,
	selfBuffProviderId = 14,
	enableGainExp = 15,
	winId = 11,
	creepsMasterId = 1,
	heroSkillId = 5,
	recommendZdl = 6,
	introdRaceId = 10
}
local dataList = {
	{
		1001,
		"智慧-1",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		1002,
		"智慧-2",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		1003,
		"智慧-3",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		1004,
		"智慧-4",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		1005,
		"智慧-5",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		2001,
		"勇气-1",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		117,
		0,
		0,
		0,
		false
	},
	{
		2002,
		"勇气-2",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		117,
		0,
		0,
		0,
		false
	},
	{
		2003,
		"勇气-3",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		117,
		0,
		0,
		0,
		false
	}
}
local t_wisdom_courage_clg_team = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[2001] = dataList[6],
	[2002] = dataList[7],
	[2003] = dataList[8]
}

t_wisdom_courage_clg_team.dataList = dataList

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

return t_wisdom_courage_clg_team
