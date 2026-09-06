-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_gate_type.lua

module("logicconfig.config.t_time_gate_type", package.seeall)

local title = {
	weeklyTimes = 2,
	timesLimit = 3,
	regressExtraTimes = 4,
	type = 1
}
local dataList = {
	{
		1,
		3,
		6,
		1
	},
	{
		2,
		3,
		6,
		1
	}
}
local t_time_gate_type = {
	dataList[1],
	dataList[2]
}

t_time_gate_type.dataList = dataList

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

return t_time_gate_type
