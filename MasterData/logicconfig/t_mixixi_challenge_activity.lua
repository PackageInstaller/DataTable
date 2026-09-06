-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mixixi_challenge_activity.lua

module("logicconfig.config.t_mixixi_challenge_activity", package.seeall)

local title = {
	challengeId = 5,
	buffPlanId = 3,
	redPointId = 4,
	itemGoTo = 6,
	rankGoTo = 7,
	activityId = 1,
	challengePlanId = 2
}
local dataList = {
	{
		135001,
		1,
		1,
		237,
		35,
		"mibao#Skin",
		""
	},
	{
		135002,
		2,
		2,
		238,
		57,
		"func#43#201",
		"func#618#17007"
	},
	{
		135003,
		3,
		3,
		557,
		150,
		"func#545#52",
		"func#618#15024"
	}
}
local t_mixixi_challenge_activity = {
	[135001] = dataList[1],
	[135002] = dataList[2],
	[135003] = dataList[3]
}

t_mixixi_challenge_activity.dataList = dataList

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

return t_mixixi_challenge_activity
