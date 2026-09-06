-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_game_collection_flappy_bird_revive.lua

module("logicconfig.config.t_game_collection_flappy_bird_revive", package.seeall)

local title = {
	consume = 2,
	times = 1
}
local dataList = {
	{
		1,
		"8:1:1000"
	},
	{
		2,
		"8:1:1000"
	},
	{
		3,
		"8:1:1000"
	}
}
local t_game_collection_flappy_bird_revive = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_game_collection_flappy_bird_revive.dataList = dataList

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

return t_game_collection_flappy_bird_revive
