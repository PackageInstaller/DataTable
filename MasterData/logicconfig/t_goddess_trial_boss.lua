-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_trial_boss.lua

module("logicconfig.config.t_goddess_trial_boss", package.seeall)

local title = {
	damageScorePlanId = 4,
	score = 3,
	bossId = 1,
	raceId = 5,
	creepsMasterId = 2
}
local dataList = {
	{
		1,
		7001,
		5,
		1,
		11036
	},
	{
		2,
		7002,
		5,
		1,
		11037
	},
	{
		3,
		7003,
		5,
		1,
		11040
	}
}
local t_goddess_trial_boss = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_goddess_trial_boss.dataList = dataList

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

return t_goddess_trial_boss
