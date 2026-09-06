-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kindergarten_classroom.lua

module("logicconfig.config.t_kindergarten_classroom", package.seeall)

local title = {
	activityId = 1,
	facilityPlanId = 4,
	classroomId = 2,
	desc = 3
}
local dataList = {
	{
		353001,
		1,
		"艺术教室",
		1
	},
	{
		353001,
		2,
		"科学教室",
		2
	},
	{
		353001,
		3,
		"体育教室",
		3
	}
}
local t_kindergarten_classroom = {
	[353001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_kindergarten_classroom.dataList = dataList

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

return t_kindergarten_classroom
