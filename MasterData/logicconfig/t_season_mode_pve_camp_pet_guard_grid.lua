-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_camp_pet_guard_grid.lua

module("logicconfig.config.t_season_mode_pve_camp_pet_guard_grid", package.seeall)

local title = {
	gridId = 2,
	gridPlanId = 1,
	campLv = 3
}
local dataList = {
	{
		1001,
		1,
		5
	},
	{
		1001,
		2,
		10
	},
	{
		1001,
		3,
		15
	},
	{
		1002,
		1,
		5
	},
	{
		1002,
		2,
		10
	},
	{
		1002,
		3,
		15
	},
	{
		1003,
		1,
		5
	},
	{
		1003,
		2,
		10
	},
	{
		1003,
		3,
		15
	}
}
local t_season_mode_pve_camp_pet_guard_grid = {
	[1001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[1002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[1003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_season_mode_pve_camp_pet_guard_grid.dataList = dataList

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

return t_season_mode_pve_camp_pet_guard_grid
