-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dumpling_feast_boil_score.lua

module("logicconfig.config.t_dumpling_feast_boil_score", package.seeall)

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
		3,
		5
	},
	{
		562001,
		6,
		10
	}
}
local t_dumpling_feast_boil_score = {
	[562001] = {
		[0] = dataList[1],
		[3] = dataList[2],
		[6] = dataList[3]
	}
}

t_dumpling_feast_boil_score.dataList = dataList

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

return t_dumpling_feast_boil_score
