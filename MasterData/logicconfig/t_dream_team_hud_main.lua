-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_team_hud_main.lua

module("logicconfig.config.t_dream_team_hud_main", package.seeall)

local title = {
	id = 1,
	redPointIds = 3,
	viewname = 2,
	reportBehavior = 4
}
local dataList = {
	{
		1,
		"dreamteamhudfirstview",
		{
			-184,
			-185,
			197
		},
		200706
	},
	{
		2,
		"dreamteamhudskinview",
		{
			-186,
			-179,
			-180,
			-181,
			182,
			-183
		},
		200707
	},
	{
		3,
		"dreamteamhudequipview",
		{
			-187
		},
		200708
	},
	{
		4,
		"dreamteamhudgiftview",
		{
			-178
		},
		200709
	}
}
local t_dream_team_hud_main = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_dream_team_hud_main.dataList = dataList

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

return t_dream_team_hud_main
