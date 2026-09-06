-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_wheel_reset_strengthen.lua

module("logicconfig.config.t_time_wheel_reset_strengthen", package.seeall)

local title = {
	paramValue = 2,
	paramKey = 1
}
local dataList = {
	{
		"price",
		"200"
	},
	{
		"resetDailyCount",
		"15"
	},
	{
		"resetCD",
		"40"
	},
	{
		"minEffectiveTime",
		"80"
	}
}
local t_time_wheel_reset_strengthen = {
	price = dataList[1],
	resetDailyCount = dataList[2],
	resetCD = dataList[3],
	minEffectiveTime = dataList[4]
}

t_time_wheel_reset_strengthen.dataList = dataList

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

return t_time_wheel_reset_strengthen
