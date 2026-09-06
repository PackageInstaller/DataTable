-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_vote_activity.lua

module("logicconfig.config.t_goddess_vote_activity", package.seeall)

local title = {
	wakeTimeDes = 9,
	votePrize = 5,
	wakeGoto = 12,
	skillGoto = 10,
	awakenStartTime = 7,
	voteTimeDes = 8,
	voteItem = 6,
	voteItemPrice = 3,
	perVoteScore = 4,
	equipGoto = 11,
	activityId = 1,
	voteItemDailyBuyLimit = 2
}
local dataList = {
	{
		127001,
		5,
		"105:200:100",
		10,
		"8:1:100000",
		"10:127001",
		"2022-03-18T05:00:00",
		"活动时间：2022.03.04--2022.03.18",
		"活动时间：2022.03.18--2022.04.01",
		"func#427#6",
		"func#5015",
		"func#523"
	}
}
local t_goddess_vote_activity = {
	[127001] = dataList[1]
}

t_goddess_vote_activity.dataList = dataList

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

return t_goddess_vote_activity
