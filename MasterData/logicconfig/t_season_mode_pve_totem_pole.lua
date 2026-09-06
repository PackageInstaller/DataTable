-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_totem_pole.lua

module("logicconfig.config.t_season_mode_pve_totem_pole", package.seeall)

local title = {
	totemPoleRaceTypePlanId = 2,
	barList = 4,
	seasonId = 1,
	campLv = 3
}
local dataList = {
	{
		1,
		3001,
		2,
		"8:33"
	},
	{
		2,
		3002,
		2,
		"8:36"
	},
	{
		3,
		3003,
		2,
		"8:40"
	}
}
local t_season_mode_pve_totem_pole = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_season_mode_pve_totem_pole.dataList = dataList

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

return t_season_mode_pve_totem_pole
