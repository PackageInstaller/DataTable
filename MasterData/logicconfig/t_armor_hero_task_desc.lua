-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_armor_hero_task_desc.lua

module("logicconfig.config.t_armor_hero_task_desc", package.seeall)

local title = {
	taskdesc = 3,
	taskType = 4,
	taskDescPlanId = 1,
	taskId = 2
}
local dataList = {
	{
		1,
		1,
		"登录4天",
		"LoginDays"
	},
	{
		1,
		2,
		"分享预热",
		"IsShare"
	},
	{
		1,
		3,
		"预约版本",
		"IsBook"
	}
}
local t_armor_hero_task_desc = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_armor_hero_task_desc.dataList = dataList

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

return t_armor_hero_task_desc
