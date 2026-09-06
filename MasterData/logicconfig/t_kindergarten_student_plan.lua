-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kindergarten_student_plan.lua

module("logicconfig.config.t_kindergarten_student_plan", package.seeall)

local title = {
	studentType = 2,
	growthRatePlanId = 3,
	studentPlanId = 1
}
local dataList = {
	{
		1,
		1,
		1
	},
	{
		1,
		2,
		2
	},
	{
		2,
		2,
		2
	}
}
local t_kindergarten_student_plan = {
	{
		dataList[1],
		dataList[2]
	},
	{
		[2] = dataList[3]
	}
}

t_kindergarten_student_plan.dataList = dataList

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

return t_kindergarten_student_plan
