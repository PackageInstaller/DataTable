-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_material_challenge_other.lua

module("logicconfig.config.t_material_challenge_other", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_DOUBLE_TIMES",
		"5"
	},
	{
		"MULTIPLY_TIME",
		"2026-08-07 05:00:00#2026-08-14 05:00:00"
	},
	{
		"MULTIPLY_DAILY_DOUBLE_TIMES",
		"10"
	}
}
local t_material_challenge_other = {
	DAILY_DOUBLE_TIMES = dataList[1],
	MULTIPLY_TIME = dataList[2],
	MULTIPLY_DAILY_DOUBLE_TIMES = dataList[3]
}

t_material_challenge_other.dataList = dataList

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

return t_material_challenge_other
