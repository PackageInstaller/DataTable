-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_growth_path.lua

module("logicconfig.config.t_pet_growth_path", package.seeall)

local title = {
	taskPlanId = 6,
	openTime = 9,
	raceId = 3,
	id = 1,
	redPointId = 8,
	taskRule = 10,
	canGainPet = 4,
	scoreId = 5,
	activityId = 2,
	strengthenPlanId = 7
}
local dataList = {
	{
		1,
		76002,
		14003,
		true,
		1201,
		1,
		1,
		160,
		"2021-10-14T05:00:00",
		"growuproad1"
	},
	{
		1,
		76003,
		11000,
		false,
		1202,
		2,
		2,
		161,
		"2021-10-22T05:00:00",
		"growuproad2"
	}
}
local t_pet_growth_path = {
	{
		[76002] = dataList[1],
		[76003] = dataList[2]
	}
}

t_pet_growth_path.dataList = dataList

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

return t_pet_growth_path
