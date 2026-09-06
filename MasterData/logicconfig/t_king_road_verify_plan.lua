-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_road_verify_plan.lua

module("logicconfig.config.t_king_road_verify_plan", package.seeall)

local title = {
	validator = 2,
	buffPlanId = 4,
	planId = 1,
	type = 3
}
local dataList = {
	{
		4,
		"10018,10016,10017,10019,10072,10020,10075",
		"星级",
		4
	}
}
local t_king_road_verify_plan = {
	[4] = dataList[1]
}

t_king_road_verify_plan.dataList = dataList

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

return t_king_road_verify_plan
