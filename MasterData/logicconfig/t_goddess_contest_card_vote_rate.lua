-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_card_vote_rate.lua

module("logicconfig.config.t_goddess_contest_card_vote_rate", package.seeall)

local title = {
	rankId = 2,
	cardVotePlanId = 1,
	voteAddRate = 3
}
local dataList = {
	{
		1,
		1,
		2
	},
	{
		1,
		2,
		1.5
	},
	{
		1,
		3,
		1.2
	},
	{
		1,
		4,
		1
	}
}
local t_goddess_contest_card_vote_rate = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_goddess_contest_card_vote_rate.dataList = dataList

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

return t_goddess_contest_card_vote_rate
