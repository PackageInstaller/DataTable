-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_noah_clg_activity_plan.lua

module("logicconfig.config.t_divine_king_noah_clg_activity_plan", package.seeall)

local title = {
	darkLineBuffPlanId = 7,
	mapLength = 3,
	comboLineCount = 10,
	signBuffId = 11,
	darkLineBuffAddNum = 9,
	lightLineBuffPlanId = 6,
	activityPlanId = 1,
	stagePlanId = 5,
	lightLineBuffAddNum = 8,
	banItemCount = 2,
	mapWidths = 4
}
local dataList = {
	{
		1,
		2,
		4,
		4,
		1,
		1,
		1,
		50,
		50,
		3,
		30000080
	}
}
local t_divine_king_noah_clg_activity_plan = {
	dataList[1]
}

t_divine_king_noah_clg_activity_plan.dataList = dataList

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

return t_divine_king_noah_clg_activity_plan
