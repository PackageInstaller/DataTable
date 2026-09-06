-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_hire_pet_times.lua

module("logicconfig.config.t_season_mode_pve_hire_pet_times", package.seeall)

local title = {
	hireTimesPlanId = 1,
	hireMaxTimes = 3,
	days = 2
}
local dataList = {
	{
		4001,
		1,
		1
	},
	{
		4001,
		2,
		2
	},
	{
		4001,
		3,
		3
	}
}
local t_season_mode_pve_hire_pet_times = {
	[4001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_season_mode_pve_hire_pet_times.dataList = dataList

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

return t_season_mode_pve_hire_pet_times
