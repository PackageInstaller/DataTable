-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_buddy_pet_lease_common.lua

module("logicconfig.config.t_buddy_pet_lease_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"HIRE_FETTER",
		"200"
	},
	{
		"LIMIT_ZDL",
		"50000"
	},
	{
		"RENT_OUT_NUM",
		"1"
	},
	{
		"HIRE_NUM",
		"3"
	},
	{
		"USE_TIMES",
		"2"
	},
	{
		"PRIZE",
		"4:106:1"
	},
	{
		"RENT_OUT_RACE",
		"10027,10070,10097,10098,10099,10100,10101,12006,12007"
	},
	{
		"RULE_ID",
		"friendrent_rule"
	}
}
local t_buddy_pet_lease_common = {
	HIRE_FETTER = dataList[1],
	LIMIT_ZDL = dataList[2],
	RENT_OUT_NUM = dataList[3],
	HIRE_NUM = dataList[4],
	USE_TIMES = dataList[5],
	PRIZE = dataList[6],
	RENT_OUT_RACE = dataList[7],
	RULE_ID = dataList[8]
}

t_buddy_pet_lease_common.dataList = dataList

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

return t_buddy_pet_lease_common
