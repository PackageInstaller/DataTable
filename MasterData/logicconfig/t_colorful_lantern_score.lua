-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_colorful_lantern_score.lua

module("logicconfig.config.t_colorful_lantern_score", package.seeall)

local title = {
	score = 4,
	scorePlanId = 1,
	dailyActivity = 3,
	scoreId = 2
}
local dataList = {
	{
		1,
		1,
		30,
		10
	},
	{
		1,
		2,
		60,
		10
	},
	{
		1,
		3,
		100,
		10
	}
}
local t_colorful_lantern_score = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_colorful_lantern_score.dataList = dataList

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

return t_colorful_lantern_score
