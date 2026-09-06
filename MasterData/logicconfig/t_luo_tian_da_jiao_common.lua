-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luo_tian_da_jiao_common.lua

module("logicconfig.config.t_luo_tian_da_jiao_common", package.seeall)

local title = {
	buffPlanId = 3,
	groupPlanId = 4,
	activityId = 1,
	challengePlanId = 2
}
local dataList = {
	{
		55001,
		1,
		1,
		1
	}
}
local t_luo_tian_da_jiao_common = {
	[55001] = dataList[1]
}

t_luo_tian_da_jiao_common.dataList = dataList

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

return t_luo_tian_da_jiao_common
