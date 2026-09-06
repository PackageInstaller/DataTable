-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_music_game_stage.lua

module("logicconfig.config.t_music_game_stage", package.seeall)

local title = {
	symbolPrefabName = 7,
	oneCount = 5,
	symbolScoreRate = 4,
	stageId = 1,
	speedRate = 9,
	twoCount = 6,
	audioId = 8,
	mapId = 2,
	gameTime = 3
}
local dataList = {
	{
		1,
		1,
		60,
		1,
		40,
		10,
		"musicgame/musicgamesymbolcell",
		12000,
		1
	},
	{
		2,
		1,
		60,
		1,
		40,
		10,
		"musicgame/musicgamesymbolcell",
		10103,
		1
	},
	{
		3,
		1,
		60,
		1,
		40,
		10,
		"musicgame/musicgamesymbolcell",
		10301,
		1
	},
	{
		4,
		2,
		60,
		1,
		60,
		15,
		"musicgame/musicgamesymbolcell",
		12000,
		2
	},
	{
		5,
		2,
		60,
		1,
		60,
		15,
		"musicgame/musicgamesymbolcell",
		10103,
		2
	},
	{
		6,
		2,
		60,
		1,
		60,
		15,
		"musicgame/musicgamesymbolcell",
		10301,
		2
	}
}
local t_music_game_stage = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_music_game_stage.dataList = dataList

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

return t_music_game_stage
