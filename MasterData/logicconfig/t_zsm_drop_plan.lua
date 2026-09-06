-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zsm_drop_plan.lua

module("logicconfig.config.t_zsm_drop_plan", package.seeall)

local title = {
	dropPlanId = 1,
	weight = 3,
	type = 2
}
local dataList = {
	{
		1,
		1,
		100
	},
	{
		1,
		2,
		100
	},
	{
		1,
		3,
		100
	}
}
local t_zsm_drop_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_zsm_drop_plan.dataList = dataList

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

return t_zsm_drop_plan
