-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_integration_challenge.lua

module("logicconfig.config.t_integration_challenge", package.seeall)

local title = {
	challengeId = 1,
	payPlanId = 5,
	buffPlanId = 7,
	raceIds = 3,
	shopId = 6,
	redPointId = 8,
	bossRaceId = 4,
	challengePlanId = 2
}
local dataList = {
	{
		1,
		1,
		{
			14003,
			11000
		},
		11001,
		1,
		12036,
		1,
		178
	}
}
local t_integration_challenge = {
	dataList[1]
}

t_integration_challenge.dataList = dataList

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

return t_integration_challenge
