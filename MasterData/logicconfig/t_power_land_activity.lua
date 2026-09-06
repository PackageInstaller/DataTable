-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_power_land_activity.lua

module("logicconfig.config.t_power_land_activity", package.seeall)

local title = {
	activityId = 1,
	name = 2,
	petPlanId = 3,
	redPointId = 5,
	canFormPetCount = 4
}
local dataList = {
	{
		156001,
		"勇闯力量秘境",
		1,
		6,
		289
	},
	{
		156002,
		"勇闯力量秘境",
		1,
		6,
		289
	},
	{
		156003,
		"勇闯力量秘境",
		1,
		6,
		289
	},
	{
		156004,
		"勇闯力量秘境",
		1,
		6,
		289
	}
}
local t_power_land_activity = {
	[156001] = dataList[1],
	[156002] = dataList[2],
	[156003] = dataList[3],
	[156004] = dataList[4]
}

t_power_land_activity.dataList = dataList

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

return t_power_land_activity
