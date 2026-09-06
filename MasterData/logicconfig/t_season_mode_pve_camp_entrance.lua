-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_camp_entrance.lua

module("logicconfig.config.t_season_mode_pve_camp_entrance", package.seeall)

local title = {
	id = 2,
	needLv = 3,
	seasonId = 1,
	jumpTo = 4
}
local dataList = {
	{
		1,
		1,
		0,
		"ui#seasontrainingcourseview"
	},
	{
		1,
		2,
		2,
		"ui#seasontotempoleview"
	},
	{
		1,
		3,
		1,
		"ui#seasonelvenhallview"
	},
	{
		1,
		4,
		0,
		"ui#seasonmaincampview"
	},
	{
		2,
		1,
		0,
		"ui#seasontrainingcourseview"
	},
	{
		2,
		2,
		2,
		"ui#seasontotempoleview"
	},
	{
		2,
		3,
		1,
		"ui#seasonelvenhallview"
	},
	{
		2,
		4,
		0,
		"ui#seasonmaincampview"
	},
	{
		3,
		1,
		0,
		"ui#seasontrainingcourseview"
	},
	{
		3,
		2,
		2,
		"ui#seasontotempoleview"
	},
	{
		3,
		3,
		1,
		"ui#seasonelvenhallview"
	},
	{
		3,
		4,
		0,
		"ui#seasonmaincampview"
	}
}
local t_season_mode_pve_camp_entrance = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_season_mode_pve_camp_entrance.dataList = dataList

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

return t_season_mode_pve_camp_entrance
