-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_chapter_activity.lua

module("logicconfig.config.t_boccaccio_chapter_activity", package.seeall)

local title = {
	chapter4CreepsMasterId = 4,
	ruleKeyC2 = 12,
	skinId = 6,
	jumpStrOne = 7,
	jumpStrThree = 9,
	chapter4DailyClgTimes = 3,
	jumpStrTwo = 8,
	ruleKeyC3 = 13,
	clientRedId = 5,
	ruleKeyC4 = 14,
	redPointId = 2,
	ruleKeyC1 = 11,
	ruleKeyMain = 10,
	activityId = 1
}
local dataList = {
	{
		580001,
		685,
		5,
		4001,
		-486,
		12021,
		"ui#boccacciochapter4rankview#580001",
		"func#191#580#580001",
		"ui#boccacciochapterstoryview#580001",
		"boccacciochapterhomeview_rule",
		"boccacciochapteronemainview_rule",
		"boccacciochaptertwomainview_rule",
		"boccacciochapterthreemainview_rule",
		"boccacciochapterfourmainview_rule"
	}
}
local t_boccaccio_chapter_activity = {
	[580001] = dataList[1]
}

t_boccaccio_chapter_activity.dataList = dataList

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

return t_boccaccio_chapter_activity
