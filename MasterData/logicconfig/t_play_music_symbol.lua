-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_play_music_symbol.lua

module("logicconfig.config.t_play_music_symbol", package.seeall)

local title = {
	prefabName = 4,
	compId = 3,
	hitPlanId = 2,
	symbolId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		"playmusic/symbol/circlesymbolcell"
	},
	{
		2,
		1,
		1,
		"playmusic/symbol/circlesymbolcell"
	},
	{
		3,
		1,
		1,
		"lionculture/circlesymbolcell"
	}
}
local t_play_music_symbol = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_play_music_symbol.dataList = dataList

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

return t_play_music_symbol
