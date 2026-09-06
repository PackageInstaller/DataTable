-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_music_game_map.lua

module("logicconfig.config.t_music_game_map", package.seeall)

local title = {
	lineSeven = 8,
	lineTwo = 3,
	lineFour = 5,
	lineSix = 7,
	lineEight = 9,
	lineThree = 4,
	lineFive = 6,
	mapId = 1,
	lineOne = 2
}
local dataList = {
	{
		1,
		{
			-500,
			267,
			-500,
			-100
		},
		{
			-300,
			132,
			-300,
			-235
		},
		{
			-100,
			77,
			-100,
			-290
		},
		{
			100,
			77,
			100,
			-290
		},
		{
			300,
			132,
			300,
			-235
		},
		{
			500,
			267,
			500,
			-100
		}
	},
	{
		2,
		{
			-450,
			250,
			-450,
			-130
		},
		{
			-300,
			145,
			-300,
			-235
		},
		{
			-150,
			100,
			-150,
			-280
		},
		{
			0,
			80,
			0,
			-300
		},
		{
			150,
			100,
			150,
			-280
		},
		{
			300,
			145,
			300,
			-235
		},
		{
			450,
			250,
			450,
			-130
		}
	}
}
local t_music_game_map = {
	dataList[1],
	dataList[2]
}

t_music_game_map.dataList = dataList

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

return t_music_game_map
