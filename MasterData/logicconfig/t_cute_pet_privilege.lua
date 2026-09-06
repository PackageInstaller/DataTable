-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cute_pet_privilege.lua

module("logicconfig.config.t_cute_pet_privilege", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"Privilege_GuestHouseGenCutePetPerNSecd",
		"28800"
	},
	{
		"PrivilegeTimePlan_GuestHouseGenCutePet",
		"67,68"
	},
	{
		"Privilege_TravelDailyMaxCount",
		"2"
	},
	{
		"PrivilegeTimePlan_TravelDailyMaxCount",
		"67,68"
	},
	{
		"Privilege_AdventureBuildingResMultiply",
		"2"
	},
	{
		"PrivilegeTimePlan_AdventureBuildingResMultiply",
		"67,68"
	}
}
local t_cute_pet_privilege = {
	Privilege_GuestHouseGenCutePetPerNSecd = dataList[1],
	PrivilegeTimePlan_GuestHouseGenCutePet = dataList[2],
	Privilege_TravelDailyMaxCount = dataList[3],
	PrivilegeTimePlan_TravelDailyMaxCount = dataList[4],
	Privilege_AdventureBuildingResMultiply = dataList[5],
	PrivilegeTimePlan_AdventureBuildingResMultiply = dataList[6]
}

t_cute_pet_privilege.dataList = dataList

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

return t_cute_pet_privilege
