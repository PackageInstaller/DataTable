-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_chen_clg_team.lua

module("logicconfig.config.t_divine_chen_clg_team", package.seeall)

local title = {
	description = 7,
	video = 8,
	name = 2,
	skipTime = 3,
	perfectWinId = 11,
	formCondition = 12,
	btlMode = 6,
	btlBg = 4,
	selfBuffProviderId = 13,
	enableGainExp = 14,
	winId = 10,
	creepsMasterId = 1,
	heroSkillId = 5,
	introdRaceId = 9
}
local dataList = {
	{
		1001,
		"阵-1",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		410,
		false
	},
	{
		1002,
		"阵-2",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		410,
		false
	},
	{
		1003,
		"阵-3",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		410,
		false
	},
	{
		1004,
		"阵-4",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		410,
		false
	},
	{
		1005,
		"阵-5",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		410,
		false
	},
	{
		1006,
		"阵-6",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		410,
		false
	},
	{
		2001,
		"全民挑战1",
		5,
		"",
		"",
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
		2002,
		"全民挑战2",
		5,
		"",
		"",
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
		2003,
		"全民挑战3",
		5,
		"",
		"",
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
		2004,
		"全民挑战4",
		5,
		"",
		"",
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
		2005,
		"全民挑战5",
		5,
		"",
		"",
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
		2006,
		"全民挑战6",
		5,
		"",
		"",
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
		2007,
		"全民挑战7",
		5,
		"",
		"",
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
		2008,
		"全民挑战8",
		5,
		"",
		"",
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
		2009,
		"全民挑战9",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	}
}
local t_divine_chen_clg_team = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[2001] = dataList[7],
	[2002] = dataList[8],
	[2003] = dataList[9],
	[2004] = dataList[10],
	[2005] = dataList[11],
	[2006] = dataList[12],
	[2007] = dataList[13],
	[2008] = dataList[14],
	[2009] = dataList[15]
}

t_divine_chen_clg_team.dataList = dataList

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

return t_divine_chen_clg_team
