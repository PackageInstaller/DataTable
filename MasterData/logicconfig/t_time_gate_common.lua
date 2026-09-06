-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_gate_common.lua

module("logicconfig.config.t_time_gate_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"REGRESS_EXTRA_TIMES_DURATION_WEEKS",
		"4"
	},
	{
		"POWER_LIMIT_YUANQI",
		"1500000"
	},
	{
		"POWER_LIMIT_SHENYAO",
		"1000000"
	}
}
local t_time_gate_common = {
	REGRESS_EXTRA_TIMES_DURATION_WEEKS = dataList[1],
	POWER_LIMIT_YUANQI = dataList[2],
	POWER_LIMIT_SHENYAO = dataList[3]
}

t_time_gate_common.dataList = dataList

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

return t_time_gate_common
