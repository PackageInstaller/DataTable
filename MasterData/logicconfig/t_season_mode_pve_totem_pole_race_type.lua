-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_totem_pole_race_type.lua

module("logicconfig.config.t_season_mode_pve_totem_pole_race_type", package.seeall)

local title = {
	totemPoleRaceTypePlanId = 1,
	index = 2,
	mainTotemPlanId = 5,
	totemItemPlanId = 4,
	raceType = 3
}
local dataList = {
	{
		3001,
		1,
		"水",
		30011,
		30051
	},
	{
		3001,
		2,
		"火",
		30012,
		30052
	},
	{
		3001,
		3,
		"草",
		30013,
		30053
	},
	{
		3001,
		4,
		"光",
		30014,
		30054
	},
	{
		3001,
		5,
		"暗",
		30015,
		30055
	},
	{
		3001,
		6,
		"空,创",
		30016,
		30056
	},
	{
		3002,
		1,
		"水",
		30021,
		30061
	},
	{
		3002,
		2,
		"火",
		30022,
		30062
	},
	{
		3002,
		3,
		"草",
		30023,
		30063
	},
	{
		3002,
		4,
		"光",
		30024,
		30064
	},
	{
		3002,
		5,
		"暗",
		30025,
		30065
	},
	{
		3002,
		6,
		"空,创",
		30026,
		30066
	},
	{
		3003,
		1,
		"水",
		30031,
		30071
	},
	{
		3003,
		2,
		"火",
		30032,
		30072
	},
	{
		3003,
		3,
		"草",
		30033,
		30073
	},
	{
		3003,
		4,
		"光",
		30034,
		30074
	},
	{
		3003,
		5,
		"暗",
		30035,
		30075
	},
	{
		3003,
		6,
		"空,创",
		30036,
		30076
	}
}
local t_season_mode_pve_totem_pole_race_type = {
	[3001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[3002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[3003] = {
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_season_mode_pve_totem_pole_race_type.dataList = dataList

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

return t_season_mode_pve_totem_pole_race_type
