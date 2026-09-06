-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_challenge_trial_prize_plan.lua

module("logicconfig.config.t_holy_challenge_trial_prize_plan", package.seeall)

local title = {
	prize = 2,
	accDamage = 1
}
local dataList = {
	{
		100000,
		100
	},
	{
		250000,
		200
	},
	{
		550000,
		300
	},
	{
		1000000,
		600
	},
	{
		1800000,
		1000
	}
}
local t_holy_challenge_trial_prize_plan = {
	[100000] = dataList[1],
	[250000] = dataList[2],
	[550000] = dataList[3],
	[1000000] = dataList[4],
	[1800000] = dataList[5]
}

t_holy_challenge_trial_prize_plan.dataList = dataList

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

return t_holy_challenge_trial_prize_plan
