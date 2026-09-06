-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fuyao_story_enter.lua

module("logicconfig.config.t_fuyao_story_enter", package.seeall)

local title = {
	jumpStr = 6,
	basePlanId = 1,
	skinId = 4,
	stepId = 2,
	redId = 5,
	startTime = 3
}
local dataList = {
	{
		1,
		1,
		"2025-07-25T05:00:00",
		12033,
		{
			716
		},
		"func#1249"
	},
	{
		1,
		2,
		"2025-08-01T05:00:00",
		12035,
		{
			714,
			"o62"
		},
		"func#1250"
	},
	{
		1,
		3,
		"2025-08-08T05:00:00",
		12036,
		{
			715
		},
		"func#1251"
	}
}
local t_fuyao_story_enter = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_fuyao_story_enter.dataList = dataList

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

return t_fuyao_story_enter
