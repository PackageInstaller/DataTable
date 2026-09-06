-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hero_trial_activity.lua

module("logicconfig.config.t_hero_trial_activity", package.seeall)

local title = {
	bossId = 5,
	name = 7,
	progressPrizeId = 6,
	verifyRaceId = 3,
	petId = 2,
	rankId = 8,
	activityId = 1,
	verifyPlanId = 4
}
local dataList = {
	{
		9101,
		1000000001,
		10309,
		1,
		1,
		3,
		"霸王试炼",
		3
	},
	{
		9102,
		1000000002,
		10143,
		2,
		2,
		4,
		"宗师试炼",
		4
	},
	{
		9103,
		1000000003,
		10326,
		3,
		3,
		5,
		"枭雄试炼",
		5
	},
	{
		9104,
		1000000004,
		10324,
		4,
		4,
		6,
		"天神试炼",
		6
	}
}
local t_hero_trial_activity = {
	[9101] = dataList[1],
	[9102] = dataList[2],
	[9103] = dataList[3],
	[9104] = dataList[4]
}

t_hero_trial_activity.dataList = dataList

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

return t_hero_trial_activity
