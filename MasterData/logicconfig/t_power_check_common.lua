-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_power_check_common.lua

module("logicconfig.config.t_power_check_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"RATING_RANK_KEY",
		"0#20#40#60#80#90#95#100"
	},
	{
		"PROMOTE_KEY",
		"70#90"
	}
}
local t_power_check_common = {
	RATING_RANK_KEY = dataList[1],
	PROMOTE_KEY = dataList[2]
}

t_power_check_common.dataList = dataList

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

return t_power_check_common
