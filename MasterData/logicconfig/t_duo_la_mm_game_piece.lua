-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_duo_la_mm_game_piece.lua

module("logicconfig.config.t_duo_la_mm_game_piece", package.seeall)

local title = {
	id = 2,
	prize = 3,
	activityId = 1,
	gainLimit = 4
}
local dataList = {
	{
		375001,
		1,
		"10:375001:1",
		350
	}
}
local t_duo_la_mm_game_piece = {
	[375001] = {
		dataList[1]
	}
}

t_duo_la_mm_game_piece.dataList = dataList

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

return t_duo_la_mm_game_piece
