-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_training_ground.lua

module("logicconfig.config.t_season_mode_pve_training_ground", package.seeall)

local title = {
	campLv = 3,
	barList = 4,
	seasonId = 1,
	teamPlanId = 2
}
local dataList = {
	{
		1,
		2001,
		1,
		"8:32"
	},
	{
		2,
		2002,
		1,
		"8:35"
	},
	{
		3,
		2003,
		1,
		"8:39"
	}
}
local t_season_mode_pve_training_ground = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_season_mode_pve_training_ground.dataList = dataList

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

return t_season_mode_pve_training_ground
