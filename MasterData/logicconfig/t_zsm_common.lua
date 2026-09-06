-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zsm_common.lua

module("logicconfig.config.t_zsm_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"GAME_PLAN_ID",
		"1"
	},
	{
		"MAX_PIECE_SINGLE_GAME",
		"50"
	}
}
local t_zsm_common = {
	GAME_PLAN_ID = dataList[1],
	MAX_PIECE_SINGLE_GAME = dataList[2]
}

t_zsm_common.dataList = dataList

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

return t_zsm_common
