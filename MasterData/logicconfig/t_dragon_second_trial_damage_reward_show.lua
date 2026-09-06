-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_second_trial_damage_reward_show.lua

module("logicconfig.config.t_dragon_second_trial_damage_reward_show", package.seeall)

local title = {
	prize = 2,
	damageDesc = 1
}
local dataList = {
	{
		"0~500000",
		"10:108002:30"
	},
	{
		"500000~1000000",
		"10:108002:45"
	},
	{
		"1000000~3000000",
		"10:108002:60"
	},
	{
		">3000000",
		"10:108002:78"
	}
}
local t_dragon_second_trial_damage_reward_show = {
	["0~500000"] = dataList[1],
	["500000~1000000"] = dataList[2],
	["1000000~3000000"] = dataList[3],
	[">3000000"] = dataList[4]
}

t_dragon_second_trial_damage_reward_show.dataList = dataList

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

return t_dragon_second_trial_damage_reward_show
