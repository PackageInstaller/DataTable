-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_chapter.lua

module("logicconfig.config.t_boccaccio_chapter", package.seeall)

local title = {
	progressPlan = 6,
	name = 3,
	supportPetPlan = 5,
	chapterId = 2,
	openTime = 4,
	mustDeployPetId = 7,
	activityId = 1
}
local dataList = {
	{
		580001,
		1,
		"吞噬神",
		"2026-04-10T05:00:00",
		1,
		1,
		100000003
	},
	{
		580001,
		2,
		"醒世书",
		"2026-04-10T05:00:00",
		1,
		2,
		0
	},
	{
		580001,
		3,
		"负重行",
		"2026-04-10T05:00:00",
		0,
		3,
		0
	},
	{
		580001,
		4,
		"见天光",
		"2026-04-17T05:00:00",
		0,
		4,
		0
	}
}
local t_boccaccio_chapter = {
	[580001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_boccaccio_chapter.dataList = dataList

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

return t_boccaccio_chapter
