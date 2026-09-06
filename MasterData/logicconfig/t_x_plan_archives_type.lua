-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_x_plan_archives_type.lua

module("logicconfig.config.t_x_plan_archives_type", package.seeall)

local title = {
	costItemType = 3,
	typeId = 2,
	activityId = 1
}
local dataList = {
	{
		378001,
		1,
		"10:378001"
	},
	{
		378001,
		2,
		"10:378002"
	}
}
local t_x_plan_archives_type = {
	[378001] = {
		dataList[1],
		dataList[2]
	}
}

t_x_plan_archives_type.dataList = dataList

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

return t_x_plan_archives_type
