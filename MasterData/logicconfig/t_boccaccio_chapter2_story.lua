-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_chapter2_story.lua

module("logicconfig.config.t_boccaccio_chapter2_story", package.seeall)

local title = {
	activityId = 1,
	storyId = 2
}
local dataList = {
	{
		580001,
		1
	},
	{
		580001,
		2
	}
}
local t_boccaccio_chapter2_story = {
	[580001] = {
		dataList[1],
		dataList[2]
	}
}

t_boccaccio_chapter2_story.dataList = dataList

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

return t_boccaccio_chapter2_story
