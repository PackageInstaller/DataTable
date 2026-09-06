-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_global_celebrate_common_config.lua

module("logicconfig.config.t_global_celebrate_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"GLOBAL_DATA_REFRESH_RATE",
		"60"
	},
	{
		"ACT_OPEN_TIME",
		"2020-09-21"
	},
	{
		"ACT_END_TIME",
		"2020-09-30"
	},
	{
		"ADD_REWARD",
		"2:13:1"
	}
}
local t_global_celebrate_common_config = {
	GLOBAL_DATA_REFRESH_RATE = dataList[1],
	ACT_OPEN_TIME = dataList[2],
	ACT_END_TIME = dataList[3],
	ADD_REWARD = dataList[4]
}

t_global_celebrate_common_config.dataList = dataList

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

return t_global_celebrate_common_config
