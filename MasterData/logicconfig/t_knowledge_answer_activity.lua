-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_knowledge_answer_activity.lua

module("logicconfig.config.t_knowledge_answer_activity", package.seeall)

local title = {
	ruleKey = 9,
	playerLimit = 10,
	dailyAnswerTimes = 3,
	playerQuestionTime = 5,
	questionInterval = 4,
	addScore = 6,
	redPointId = 2,
	endTime = 8,
	activityId = 1,
	startTime = 7
}
local dataList = {
	{
		449001,
		670,
		20,
		20,
		15,
		10,
		"05:00:00",
		"23:59:59",
		"konwledge_answer_rule",
		10
	}
}
local t_knowledge_answer_activity = {
	[449001] = dataList[1]
}

t_knowledge_answer_activity.dataList = dataList

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

return t_knowledge_answer_activity
