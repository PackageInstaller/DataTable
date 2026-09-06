-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_collect_clothes.lua

module("logicconfig.config.t_collect_clothes", package.seeall)

local title = {
	activityId = 1,
	redPointId = 4,
	collectPlanId = 2,
	prizePlanId = 3
}
local dataList = {
	{
		185001,
		1,
		1,
		323
	},
	{
		185002,
		2,
		2,
		323
	}
}
local t_collect_clothes = {
	[185001] = dataList[1],
	[185002] = dataList[2]
}

t_collect_clothes.dataList = dataList

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

return t_collect_clothes
