-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_pet_palace.lua

module("logicconfig.config.t_season_mode_pve_pet_palace", package.seeall)

local title = {
	hireTimesPlanId = 5,
	campLv = 3,
	seasonId = 1,
	hirePetsNums = 4,
	randomHirePetNums = 2
}
local dataList = {
	{
		1,
		1,
		1,
		3,
		4001
	},
	{
		2,
		1,
		1,
		3,
		4001
	},
	{
		3,
		1,
		1,
		3,
		4001
	}
}
local t_season_mode_pve_pet_palace = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_season_mode_pve_pet_palace.dataList = dataList

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

return t_season_mode_pve_pet_palace
