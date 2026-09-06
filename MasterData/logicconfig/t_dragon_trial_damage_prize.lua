-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_trial_damage_prize.lua

module("logicconfig.config.t_dragon_trial_damage_prize", package.seeall)

local title = {
	score = 3,
	planId = 1,
	damage = 2
}
local dataList = {
	{
		2,
		0,
		"10:108002:30"
	},
	{
		2,
		500000,
		"10:108002:45"
	},
	{
		2,
		1000000,
		"10:108002:60"
	},
	{
		2,
		3000000,
		"10:108002:78"
	},
	{
		3,
		0,
		"10:108002:30"
	},
	{
		3,
		500000,
		"10:108002:45"
	},
	{
		3,
		1000000,
		"10:108002:60"
	},
	{
		3,
		3000000,
		"10:108002:78"
	}
}
local t_dragon_trial_damage_prize = {
	[2] = {
		[0] = dataList[1],
		[500000] = dataList[2],
		[1000000] = dataList[3],
		[3000000] = dataList[4]
	},
	[3] = {
		[0] = dataList[5],
		[500000] = dataList[6],
		[1000000] = dataList[7],
		[3000000] = dataList[8]
	}
}

t_dragon_trial_damage_prize.dataList = dataList

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

return t_dragon_trial_damage_prize
