-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_domain_adventure_boss_event.lua

module("logicconfig.config.t_domain_adventure_boss_event", package.seeall)

local title = {
	bossId = 2,
	dailyTimes = 5,
	skinId = 7,
	prizePlanId = 4,
	scale = 9,
	pos = 8,
	creepsMasterId = 3,
	unlockBlockCount = 6,
	activityId = 1
}
local dataList = {
	{
		402001,
		5001,
		5001,
		4,
		5,
		200,
		17012,
		{
			0.24,
			-0.85,
			-1300
		},
		{
			0.2,
			0.2,
			0.2
		}
	}
}
local t_domain_adventure_boss_event = {
	[402001] = {
		[5001] = dataList[1]
	}
}

t_domain_adventure_boss_event.dataList = dataList

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

return t_domain_adventure_boss_event
