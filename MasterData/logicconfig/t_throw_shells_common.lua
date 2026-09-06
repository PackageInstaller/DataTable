-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_throw_shells_common.lua

module("logicconfig.config.t_throw_shells_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"FREE_GAME_TIMES",
		"3"
	},
	{
		"GRAVITY_ACC",
		"10"
	},
	{
		"AIR_DRAG",
		"0.5"
	}
}
local t_throw_shells_common = {
	FREE_GAME_TIMES = dataList[1],
	GRAVITY_ACC = dataList[2],
	AIR_DRAG = dataList[3]
}

t_throw_shells_common.dataList = dataList

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

return t_throw_shells_common
