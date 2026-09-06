-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_brother_group_common.lua

module("logicconfig.config.t_brother_group_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MAX_MATCH_TIME",
		"60"
	},
	{
		"MAX_REQUEST_TIME",
		"60"
	},
	{
		"MIN_GAIN_PRIZE_NUM",
		"2"
	},
	{
		"SHOW_PET_SKIN",
		"10131"
	}
}
local t_brother_group_common = {
	MAX_MATCH_TIME = dataList[1],
	MAX_REQUEST_TIME = dataList[2],
	MIN_GAIN_PRIZE_NUM = dataList[3],
	SHOW_PET_SKIN = dataList[4]
}

t_brother_group_common.dataList = dataList

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

return t_brother_group_common
