-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_angel_power_transfer_pet_plan.lua

module("logicconfig.config.t_angel_power_transfer_pet_plan", package.seeall)

local title = {
	raceId = 3,
	transferAttrId = 2,
	transferPetPlanId = 1,
	maskName = 4
}
local dataList = {
	{
		1,
		1,
		{
			13009,
			13010,
			13014,
			13019,
			13008,
			13013,
			13015,
			13017,
			13018
		},
		"友善"
	},
	{
		1,
		2,
		{
			11013,
			11014,
			11017,
			11023,
			11011,
			11019,
			11020,
			11021,
			11022
		},
		"温柔"
	},
	{
		1,
		3,
		{
			12015,
			12018,
			12020,
			12022,
			12012,
			12014,
			12016,
			12019,
			12021
		},
		"刚毅"
	},
	{
		1,
		4,
		{
			14013,
			14019,
			14021,
			14022,
			14017,
			14018,
			14020,
			14023,
			14024
		},
		"阳光"
	},
	{
		1,
		5,
		{
			10205,
			15013,
			15017,
			15021,
			15018,
			15019,
			15020,
			15022,
			15024
		},
		"沮丧"
	},
	{
		1,
		6,
		{
			16017,
			16019,
			16021,
			16024,
			16016,
			16018,
			16020,
			16022,
			16023
		},
		"超越"
	},
	{
		1,
		7,
		{
			17002,
			17007,
			17015,
			18008,
			17011,
			17012,
			17013,
			17014
		},
		"创造"
	}
}
local t_angel_power_transfer_pet_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_angel_power_transfer_pet_plan.dataList = dataList

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

return t_angel_power_transfer_pet_plan
