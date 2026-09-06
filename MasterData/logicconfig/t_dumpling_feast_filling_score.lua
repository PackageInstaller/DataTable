-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dumpling_feast_filling_score.lua

module("logicconfig.config.t_dumpling_feast_filling_score", package.seeall)

local title = {
	score = 3,
	seconds = 2,
	activityId = 1
}
local dataList = {
	{
		562001,
		0,
		1
	},
	{
		562001,
		2,
		5
	},
	{
		562001,
		4,
		10
	}
}
local t_dumpling_feast_filling_score = {
	[562001] = {
		[0] = dataList[1],
		[2] = dataList[2],
		[4] = dataList[3]
	}
}

t_dumpling_feast_filling_score.dataList = dataList

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

return t_dumpling_feast_filling_score
