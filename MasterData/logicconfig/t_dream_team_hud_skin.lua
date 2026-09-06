-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_team_hud_skin.lua

module("logicconfig.config.t_dream_team_hud_skin", package.seeall)

local title = {
	redpoint = 5,
	startTime = 3,
	skinId = 2,
	id = 1,
	reportBehavior = 4
}
local dataList = {
	{
		1,
		1034301,
		"2022-01-14T05:00:00",
		200710,
		-179
	},
	{
		2,
		1033901,
		"2022-01-14T05:00:00",
		200711,
		-180
	},
	{
		3,
		1033801,
		"2022-01-28T05:00:00",
		200712,
		-181
	},
	{
		4,
		1034201,
		"2022-01-28T05:00:00",
		200713,
		-182
	},
	{
		5,
		1034101,
		"2022-02-01T05:00:00",
		200714,
		-183
	}
}
local t_dream_team_hud_skin = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_dream_team_hud_skin.dataList = dataList

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

return t_dream_team_hud_skin
