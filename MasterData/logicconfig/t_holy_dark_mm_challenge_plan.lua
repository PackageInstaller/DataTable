-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dark_mm_challenge_plan.lua

module("logicconfig.config.t_holy_dark_mm_challenge_plan", package.seeall)

local title = {
	activityId = 1,
	stageIds = 3,
	planId = 2
}
local dataList = {
	{
		284001,
		1,
		{
			1,
			2,
			3
		}
	},
	{
		284001,
		2,
		{
			4,
			5,
			6
		}
	},
	{
		284001,
		3,
		{
			1,
			2,
			3
		}
	}
}
local t_holy_dark_mm_challenge_plan = {
	[284001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_holy_dark_mm_challenge_plan.dataList = dataList

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

return t_holy_dark_mm_challenge_plan
