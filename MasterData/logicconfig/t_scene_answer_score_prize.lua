-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scene_answer_score_prize.lua

module("logicconfig.config.t_scene_answer_score_prize", package.seeall)

local title = {
	score = 1,
	prize = 2
}
local dataList = {
	{
		400,
		"104:2:50#4:5000:5"
	},
	{
		800,
		"104:2:50#4:5000:8"
	},
	{
		1200,
		"104:2:60#4:5000:12"
	},
	{
		1600,
		"104:2:70#4:90015:1"
	},
	{
		2000,
		"104:2:80#4:90015:2"
	},
	{
		2500,
		"104:2:100#4:90015:3#4:5000:20"
	}
}
local t_scene_answer_score_prize = {
	[400] = dataList[1],
	[800] = dataList[2],
	[1200] = dataList[3],
	[1600] = dataList[4],
	[2000] = dataList[5],
	[2500] = dataList[6]
}

t_scene_answer_score_prize.dataList = dataList

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

return t_scene_answer_score_prize
