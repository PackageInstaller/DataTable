-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_summon_pet_obtain.lua

module("logicconfig.config.t_new_summon_pet_obtain", package.seeall)

local title = {
	taskPlanId = 3,
	comPlanId = 5,
	tierPlanId = 4,
	prizePlanId = 2,
	redPointId = 6,
	activityId = 1
}
local dataList = {
	{
		206001,
		1,
		1,
		1,
		1,
		361
	},
	{
		206002,
		2,
		1,
		2,
		2,
		549
	}
}
local t_new_summon_pet_obtain = {
	[206001] = dataList[1],
	[206002] = dataList[2]
}

t_new_summon_pet_obtain.dataList = dataList

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

return t_new_summon_pet_obtain
