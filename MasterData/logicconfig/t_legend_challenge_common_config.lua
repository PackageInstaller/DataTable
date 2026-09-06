-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_legend_challenge_common_config.lua

module("logicconfig.config.t_legend_challenge_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"TIMES_LIMIT",
		"12"
	},
	{
		"RECOVERY_TIMES",
		"00:00:00|02:00:00|04:00:00|06:00:00|08:00:00|10:00:00|12:00:00|14:00:00|16:00:00|18:00:00|20:00:00|22:00:00"
	}
}
local t_legend_challenge_common_config = {
	TIMES_LIMIT = dataList[1],
	RECOVERY_TIMES = dataList[2]
}

t_legend_challenge_common_config.dataList = dataList

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

return t_legend_challenge_common_config
