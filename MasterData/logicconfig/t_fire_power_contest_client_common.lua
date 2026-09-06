-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fire_power_contest_client_common.lua

module("logicconfig.config.t_fire_power_contest_client_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MaxPrepareTime",
		"8"
	},
	{
		"MaxReadyTime",
		"3"
	},
	{
		"MatchCD",
		"10"
	},
	{
		"MaxMatchingSec",
		"120"
	}
}
local t_fire_power_contest_client_common = {
	MaxPrepareTime = dataList[1],
	MaxReadyTime = dataList[2],
	MatchCD = dataList[3],
	MaxMatchingSec = dataList[4]
}

t_fire_power_contest_client_common.dataList = dataList

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

return t_fire_power_contest_client_common
