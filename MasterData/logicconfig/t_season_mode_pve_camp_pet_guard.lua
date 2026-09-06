-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_camp_pet_guard.lua

module("logicconfig.config.t_season_mode_pve_camp_pet_guard", package.seeall)

local title = {
	recommendPets = 3,
	normalAdditionPlanId = 6,
	recommendAdditionPlanId = 5,
	gridPlanId = 2,
	petGuardPlanId = 1,
	normalPets = 4
}
local dataList = {
	{
		1001,
		1001,
		"17006,13005,17002,17003,11002,12004,10314,15006,15007",
		"13006,13004,13002,13001,12008,12007,15011,11007,14008,10027,10324,17005",
		1,
		2
	},
	{
		1002,
		1002,
		"17009,17008,16010,15015,14011,15013,15014",
		"17007,14009,15012,13001,12008,12007,15011,11007,14008,10027,10324",
		1,
		2
	},
	{
		1003,
		1003,
		"11010,17010,11017,12016,13011,13008,11012",
		"11009,12017,13007,14015,15016,11015,12013,13012,11008,12015,11013,13010,12009,11018",
		1,
		2
	}
}
local t_season_mode_pve_camp_pet_guard = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3]
}

t_season_mode_pve_camp_pet_guard.dataList = dataList

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

return t_season_mode_pve_camp_pet_guard
