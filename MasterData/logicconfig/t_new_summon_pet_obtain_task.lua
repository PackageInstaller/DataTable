-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_summon_pet_obtain_task.lua

module("logicconfig.config.t_new_summon_pet_obtain_task", package.seeall)

local title = {
	score = 3,
	taskPlanId = 1,
	taskId = 2
}
local dataList = {
	{
		1,
		1,
		500
	},
	{
		1,
		2,
		500
	},
	{
		1,
		3,
		500
	},
	{
		1,
		4,
		500
	},
	{
		1,
		5,
		500
	}
}
local t_new_summon_pet_obtain_task = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_new_summon_pet_obtain_task.dataList = dataList

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

return t_new_summon_pet_obtain_task
