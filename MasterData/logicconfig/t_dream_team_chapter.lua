-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_team_chapter.lua

module("logicconfig.config.t_dream_team_chapter", package.seeall)

local title = {
	jumpViewName = 5,
	openTime = 4,
	chapterId = 2,
	chapterName = 3,
	activityId = 1
}
local dataList = {
	{
		595001,
		1,
		82056398,
		"2026-05-29T05:00:00",
		"dreamteamchapter1view"
	},
	{
		595001,
		2,
		82056399,
		"2026-06-05T05:00:00",
		"dreamteamchapter2view"
	},
	{
		595001,
		3,
		82056400,
		"2026-06-05T05:00:00",
		"dreamteamchapter3view"
	}
}
local t_dream_team_chapter = {
	[595001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_dream_team_chapter.dataList = dataList

local multiLanguageCells = {
	chapterName = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_dream_team_chapter
