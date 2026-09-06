-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_verification_task_prize.lua

module("logicconfig.config.t_verification_task_prize", package.seeall)

local title = {
	activityId = 1,
	taskPlanId = 2,
	prizePlanId = 3
}
local dataList = {
	{
		111001,
		1,
		1
	}
}
local t_verification_task_prize = {
	[111001] = dataList[1]
}

t_verification_task_prize.dataList = dataList

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

return t_verification_task_prize
