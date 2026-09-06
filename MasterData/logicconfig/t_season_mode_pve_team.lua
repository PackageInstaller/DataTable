-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_team.lua

module("logicconfig.config.t_season_mode_pve_team", package.seeall)

local title = {
	campLv = 5,
	headSkinId = 4,
	teamName = 3,
	teamUpgradePlanId = 7,
	teamId = 2,
	lockTips = 8,
	redPointId = 9,
	maxLvPlanId = 6,
	teamPlanId = 1
}
local dataList = {
	{
		2001,
		1,
		"异界先遣队1",
		10016,
		1,
		2001,
		20011,
		"",
		385
	},
	{
		2001,
		2,
		"异界先遣队2",
		10017,
		3,
		2002,
		20011,
		"营地3级解锁",
		386
	},
	{
		2001,
		3,
		"异界先遣队3",
		10018,
		7,
		2003,
		20011,
		"营地7级解锁",
		387
	},
	{
		2002,
		1,
		"异界先遣队1",
		10016,
		0,
		2004,
		20012,
		"",
		385
	},
	{
		2002,
		2,
		"异界先遣队2",
		10017,
		3,
		2005,
		20012,
		"营地3级解锁",
		386
	},
	{
		2002,
		3,
		"异界先遣队3",
		10018,
		7,
		2006,
		20012,
		"营地7级解锁",
		387
	},
	{
		2003,
		1,
		"异界先遣队1",
		10016,
		0,
		2007,
		20013,
		"",
		385
	},
	{
		2003,
		2,
		"异界先遣队2",
		10017,
		3,
		2008,
		20013,
		"营地3级解锁",
		386
	},
	{
		2003,
		3,
		"异界先遣队3",
		10018,
		7,
		2009,
		20013,
		"营地7级解锁",
		387
	}
}
local t_season_mode_pve_team = {
	[2001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[2002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[2003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_season_mode_pve_team.dataList = dataList

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

return t_season_mode_pve_team
