-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_play_music_rhythm.lua

module("logicconfig.config.t_play_music_rhythm", package.seeall)

local title = {
	score = 3,
	createSymbolCD = 5,
	maxOnceCDCreateSymbolCellCount = 6,
	maxRunningSymbolCellCount = 7,
	rhythmId = 2,
	symbolAnimSpeed = 4,
	rhythmPlanId = 1
}
local dataList = {
	{
		1,
		1,
		0,
		1,
		1.5,
		1,
		1
	},
	{
		2,
		1,
		0,
		2,
		1.5,
		1,
		1
	},
	{
		2,
		2,
		30,
		2.3,
		1.3,
		1,
		2
	},
	{
		2,
		3,
		60,
		2.5,
		1,
		1,
		2
	},
	{
		2,
		4,
		100,
		2.7,
		1.3,
		2,
		2
	},
	{
		2,
		5,
		150,
		2.9,
		0.9,
		1,
		3
	},
	{
		2,
		6,
		200,
		3.1,
		1.3,
		2,
		3
	},
	{
		2,
		7,
		250,
		3.3,
		1.1,
		2,
		3
	},
	{
		2,
		8,
		300,
		3.5,
		0.8,
		1,
		4
	},
	{
		2,
		9,
		350,
		3.7,
		0.6,
		1,
		4
	},
	{
		2,
		10,
		400,
		4,
		1,
		2,
		4
	}
}
local t_play_music_rhythm = {
	{
		dataList[1]
	},
	{
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	}
}

t_play_music_rhythm.dataList = dataList

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

return t_play_music_rhythm
