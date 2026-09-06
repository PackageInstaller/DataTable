-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_team_chapter_dora_stage.lua

module("logicconfig.config.t_dream_team_chapter_dora_stage", package.seeall)

local title = {
	stageId = 2,
	gameMode = 7,
	powerGeerList = 6,
	mapHeight = 5,
	roateList = 9,
	prize = 3,
	mapWidth = 4,
	puzzleList = 8,
	activityId = 1,
	useedPuzzleList = 10
}
local dataList = {
	{
		595001,
		1,
		"8:1:100000",
		5,
		5,
		{
			2,
			20
		},
		0,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			4,
			3,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			1,
			-1,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
			3,
			4
		}
	},
	{
		595001,
		2,
		"8:1:100000",
		5,
		5,
		{
			2,
			20
		},
		0,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			4,
			3,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			1,
			-1,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
			3,
			4
		}
	},
	{
		595001,
		3,
		"8:1:100000",
		5,
		5,
		{
			2,
			20
		},
		1,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			3,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			7,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0,
			0,
			0,
			-3,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			-6,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
			3,
			7
		}
	}
}
local t_dream_team_chapter_dora_stage = {
	[595001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_dream_team_chapter_dora_stage.dataList = dataList

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

return t_dream_team_chapter_dora_stage
