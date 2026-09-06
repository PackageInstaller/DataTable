-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_noah_challenge.lua

module("logicconfig.config.t_noah_challenge", package.seeall)

local title = {
	challengeId = 1,
	buff = 6,
	buffTime = 7,
	payPlanId = 4,
	raceId = 2,
	lockPetSwitch = 5,
	challengePlanId = 3
}
local dataList = {
	{
		1,
		14000,
		1,
		1,
		true,
		20046602,
		"时段|2022-11-25 05:00:00,2022-12-09 05:00:00"
	},
	{
		2,
		10145,
		2,
		2,
		false,
		20046602,
		"时段|2022-11-25 05:00:00,2022-12-09 05:00:00"
	}
}
local t_noah_challenge = {
	dataList[1],
	dataList[2]
}

t_noah_challenge.dataList = dataList

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

return t_noah_challenge
