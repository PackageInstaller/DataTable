-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_powers_clg_team.lua

module("logicconfig.config.t_origin_powers_clg_team", package.seeall)

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
		"源起权天使-1",
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
		1002,
		"源起权天使-2",
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
		1003,
		"源起权天使-3",
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
		1004,
		"源起权天使-4",
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
		"源起权天使-5",
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
		"源起权天使-6",
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
local t_origin_powers_clg_team = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6]
}

t_origin_powers_clg_team.dataList = dataList

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

return t_origin_powers_clg_team
