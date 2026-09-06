-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_draw_and_guess_score.lua

module("logicconfig.config.t_draw_and_guess_score", package.seeall)

local title = {
	score = 3,
	activityId = 1,
	order = 2
}
local dataList = {
	{
		536001,
		1,
		10
	},
	{
		536001,
		2,
		8
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
	},
	{
		536001,
		5,
		2
	}
}
local t_draw_and_guess_score = {
	[536001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_draw_and_guess_score.dataList = dataList

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

return t_draw_and_guess_score
