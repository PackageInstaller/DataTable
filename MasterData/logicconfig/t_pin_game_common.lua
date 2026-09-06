-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pin_game_common.lua

module("logicconfig.config.t_pin_game_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CUR_ACTID",
		"325004"
	},
	{
		"WORLD_PROGRESS_ACTID",
		"262003"
	},
	{
		"DRAGON_EGG_TIME",
		"2024-03-22 04:59:59#2024-03-22 05:00:00"
	}
}
local t_pin_game_common = {
	CUR_ACTID = dataList[1],
	WORLD_PROGRESS_ACTID = dataList[2],
	DRAGON_EGG_TIME = dataList[3]
}

t_pin_game_common.dataList = dataList

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

return t_pin_game_common
