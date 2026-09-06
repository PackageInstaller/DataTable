-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_hope_clg.lua

module("logicconfig.config.t_summon_master_hope_clg", package.seeall)

local title = {
	rankPrize = 5,
	minScore2SubmitGodRank = 3,
	godRankLimit = 4,
	challengeClosedTimeRange = 2,
	comPlanId = 6,
	activityId = 1
}
local dataList = {
	{
		403001,
		"01:00:00-09:00:00",
		30000,
		1000,
		"100:18011:1:1",
		1
	}
}
local t_summon_master_hope_clg = {
	[403001] = dataList[1]
}

t_summon_master_hope_clg.dataList = dataList

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

return t_summon_master_hope_clg
