-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyngarde_chapter_story.lua

module("logicconfig.config.t_luyngarde_chapter_story", package.seeall)

local title = {
	storyId = 4,
	title = 3,
	activityId = 1,
	chapterId = 2
}
local dataList = {
	{
		466001,
		1,
		"龙塔探秘",
		4900006
	},
	{
		466001,
		2,
		"魔龙之心",
		4900007
	},
	{
		466001,
		3,
		"终湮神临",
		4900008
	},
	{
		466001,
		4,
		"对决命渊",
		4900009
	}
}
local t_luyngarde_chapter_story = {
	[466001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_luyngarde_chapter_story.dataList = dataList

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

return t_luyngarde_chapter_story
