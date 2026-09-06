-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_active_get_activity.lua

module("logicconfig.config.t_pet_active_get_activity", package.seeall)

local title = {
	lvUpCost = 5,
	awakenUp = 8,
	costMaterialKey = 4,
	payPrice = 3,
	exchangePlanId = 10,
	awakenUpCost = 7,
	gainPetCost = 9,
	lvUp = 6,
	raceId = 2,
	activityId = 1
}
local dataList = {
	{
		401001,
		17023,
		"204:191001:188",
		"4:249",
		500,
		100,
		1500,
		6,
		4200,
		0
	},
	{
		401002,
		14028,
		"204:191002:188",
		"4:250",
		500,
		100,
		1500,
		6,
		4200,
		0
	},
	{
		401003,
		11033,
		"204:191003:188",
		"",
		0,
		100,
		0,
		6,
		0,
		1
	}
}
local t_pet_active_get_activity = {
	[401001] = dataList[1],
	[401002] = dataList[2],
	[401003] = dataList[3]
}

t_pet_active_get_activity.dataList = dataList

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

return t_pet_active_get_activity
