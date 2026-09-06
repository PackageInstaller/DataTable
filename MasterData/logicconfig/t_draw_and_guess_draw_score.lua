-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_draw_and_guess_draw_score.lua

module("logicconfig.config.t_draw_and_guess_draw_score", package.seeall)

local title = {
	score = 3,
	answerNum = 2,
	activityId = 1
}
local dataList = {
	{
		536001,
		1,
		4
	},
	{
		536001,
		2,
		6
	},
	{
		536001,
		3,
		6
	},
	{
		536001,
		4,
		4
	}
}
local t_draw_and_guess_draw_score = {
	[536001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_draw_and_guess_draw_score.dataList = dataList

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

return t_draw_and_guess_draw_score
