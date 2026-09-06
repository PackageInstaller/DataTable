-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_long_nv_challenge_plan.lua

module("logicconfig.config.t_long_nv_challenge_plan", package.seeall)

local title = {
	bossHP = 4,
	bossRaceId = 3,
	monsterPlan = 2,
	planId = 1,
	maxDamageDiff = 5
}
local dataList = {
	{
		1,
		1,
		90345,
		10000000,
		1000000
	}
}
local t_long_nv_challenge_plan = {
	dataList[1]
}

t_long_nv_challenge_plan.dataList = dataList

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

return t_long_nv_challenge_plan
