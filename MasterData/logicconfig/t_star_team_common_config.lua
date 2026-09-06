-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_team_common_config.lua

module("logicconfig.config.t_star_team_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"ACT_START_TIME",
		"2020-09-05 05:00:00"
	},
	{
		"ACT_END_TIME",
		"2031-01-29 05:00:00"
	},
	{
		"FUNC_OPEN_ID",
		"107"
	}
}
local t_star_team_common_config = {
	ACT_START_TIME = dataList[1],
	ACT_END_TIME = dataList[2],
	FUNC_OPEN_ID = dataList[3]
}

t_star_team_common_config.dataList = dataList

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

return t_star_team_common_config
