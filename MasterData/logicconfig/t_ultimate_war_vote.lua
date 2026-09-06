-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_war_vote.lua

module("logicconfig.config.t_ultimate_war_vote", package.seeall)

local title = {
	activityId = 1,
	voteId = 2,
	desc = 3
}
local dataList = {
	{
		434001,
		1,
		"究"
	},
	{
		434001,
		2,
		"终绯"
	}
}
local t_ultimate_war_vote = {
	[434001] = {
		dataList[1],
		dataList[2]
	}
}

t_ultimate_war_vote.dataList = dataList

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

return t_ultimate_war_vote
