-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_lease_params.lua

module("logicconfig.config.t_pet_lease_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MAX_LEASE_SLOT_NUM",
		"3"
	},
	{
		"MAX_RENT_SLOT_NUM",
		"3"
	},
	{
		"RENT_DAYS",
		"1"
	},
	{
		"LEASE_PET_USED_FRIEND_PRIZE",
		"4:29:1"
	},
	{
		"LEASE_PET_USED_SCORE_PRIZE",
		"8:1:1"
	},
	{
		"LEASE_PET_USED_SCORE_FACTOR",
		"0.5"
	},
	{
		"LEASE_PET_RENT_TIMES_FACTOR",
		"20"
	},
	{
		"SCORE_PRIZE_MAX_NUM",
		"1000000"
	},
	{
		"FRIEND_SHIP_POINT_MAX_NUM",
		"1000"
	},
	{
		"RENT_PET_ZDL_LIMIT_FACTOR",
		"12000"
	}
}
local t_pet_lease_params = {
	MAX_LEASE_SLOT_NUM = dataList[1],
	MAX_RENT_SLOT_NUM = dataList[2],
	RENT_DAYS = dataList[3],
	LEASE_PET_USED_FRIEND_PRIZE = dataList[4],
	LEASE_PET_USED_SCORE_PRIZE = dataList[5],
	LEASE_PET_USED_SCORE_FACTOR = dataList[6],
	LEASE_PET_RENT_TIMES_FACTOR = dataList[7],
	SCORE_PRIZE_MAX_NUM = dataList[8],
	FRIEND_SHIP_POINT_MAX_NUM = dataList[9],
	RENT_PET_ZDL_LIMIT_FACTOR = dataList[10]
}

t_pet_lease_params.dataList = dataList

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

return t_pet_lease_params
