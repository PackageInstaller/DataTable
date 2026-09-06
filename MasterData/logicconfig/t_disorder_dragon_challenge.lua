-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_disorder_dragon_challenge.lua

module("logicconfig.config.t_disorder_dragon_challenge", package.seeall)

local title = {
	allFire = 6,
	extremeTime = 7,
	extremeId = 3,
	allStage = 4,
	extremeChangePlan = 8,
	allPlanId = 2,
	activityId = 1,
	allPrize = 5
}
local dataList = {
	{
		252001,
		1,
		1,
		5,
		"8:1:10000",
		20,
		3,
		1
	}
}
local t_disorder_dragon_challenge = {
	[252001] = dataList[1]
}

t_disorder_dragon_challenge.dataList = dataList

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

return t_disorder_dragon_challenge
