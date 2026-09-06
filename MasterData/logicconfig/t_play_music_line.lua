-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_play_music_line.lua

module("logicconfig.config.t_play_music_line", package.seeall)

local title = {
	linePlanId = 1,
	lineProbability = 3,
	lineId = 2,
	symbolProbability = 4
}
local dataList = {
	{
		1,
		1,
		1,
		"1:1#2:1"
	},
	{
		1,
		2,
		1,
		"1:1#2:1"
	},
	{
		1,
		3,
		1,
		"1:1#2:1"
	},
	{
		1,
		4,
		1,
		"1:1#2:1"
	},
	{
		2,
		1,
		1,
		"3:1"
	},
	{
		2,
		2,
		1,
		"3:1"
	},
	{
		2,
		3,
		1,
		"3:1"
	},
	{
		2,
		4,
		1,
		"3:1"
	}
}
local t_play_music_line = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_play_music_line.dataList = dataList

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

return t_play_music_line
