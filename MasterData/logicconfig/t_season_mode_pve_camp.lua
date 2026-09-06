-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_camp.lua

module("logicconfig.config.t_season_mode_pve_camp", package.seeall)

local title = {
	hangingMaxMinute = 4,
	hangingMinMinute = 5,
	seasonId = 1,
	upgradePlanId = 2,
	barList = 6,
	petGuardPlanId = 3
}
local dataList = {
	{
		1,
		101,
		1001,
		1440,
		5,
		"8:31#8:32#8:33"
	},
	{
		2,
		102,
		1002,
		1440,
		5,
		"8:34#8:35#8:36"
	},
	{
		3,
		103,
		1003,
		1440,
		5,
		"8:38#8:39#8:40"
	}
}
local t_season_mode_pve_camp = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_season_mode_pve_camp.dataList = dataList

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

return t_season_mode_pve_camp
