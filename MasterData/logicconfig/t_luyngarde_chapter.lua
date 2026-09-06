-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyngarde_chapter.lua

module("logicconfig.config.t_luyngarde_chapter", package.seeall)

local title = {
	supportPetPoolId = 4,
	openTime = 3,
	activityId = 1,
	chapterId = 2
}
local dataList = {
	{
		466001,
		2,
		"2025-04-03T05:00:00",
		1
	},
	{
		466001,
		3,
		"2025-04-11T05:00:00",
		-1
	},
	{
		466001,
		4,
		"2025-04-18T05:00:00",
		3
	}
}
local t_luyngarde_chapter = {
	[466001] = {
		[2] = dataList[1],
		[3] = dataList[2],
		[4] = dataList[3]
	}
}

t_luyngarde_chapter.dataList = dataList

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

return t_luyngarde_chapter
