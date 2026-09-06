-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hero_trial_boss.lua

module("logicconfig.config.t_hero_trial_boss", package.seeall)

local title = {
	btlBg = 5,
	name = 3,
	enableGainExp = 7,
	skipTime = 4,
	id = 1,
	heroSkillId = 6,
	creepsMasterId = 2,
	btlMode = 8
}
local dataList = {
	{
		1,
		1,
		"boss",
		15,
		"",
		"",
		false,
		""
	},
	{
		2,
		2,
		"boss",
		15,
		"",
		"",
		false,
		""
	},
	{
		3,
		3,
		"boss",
		15,
		"",
		"",
		false,
		""
	},
	{
		4,
		4,
		"boss",
		15,
		"",
		"",
		false,
		""
	}
}
local t_hero_trial_boss = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_hero_trial_boss.dataList = dataList

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

return t_hero_trial_boss
