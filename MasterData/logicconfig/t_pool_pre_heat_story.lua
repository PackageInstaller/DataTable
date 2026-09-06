-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pool_pre_heat_story.lua

module("logicconfig.config.t_pool_pre_heat_story", package.seeall)

local title = {
	storyId = 3,
	storyPlanId = 1,
	day = 2
}
local dataList = {
	{
		1,
		1,
		9013001
	},
	{
		1,
		2,
		9013002
	},
	{
		1,
		3,
		9013003
	},
	{
		2,
		1,
		9013301
	},
	{
		2,
		2,
		9013302
	},
	{
		2,
		3,
		9013303
	},
	{
		3,
		1,
		7010001
	},
	{
		3,
		2,
		7010002
	},
	{
		3,
		3,
		7010003
	}
}
local t_pool_pre_heat_story = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_pool_pre_heat_story.dataList = dataList

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

return t_pool_pre_heat_story
