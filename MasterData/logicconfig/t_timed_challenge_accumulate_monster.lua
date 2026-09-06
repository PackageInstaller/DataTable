-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_accumulate_monster.lua

module("logicconfig.config.t_timed_challenge_accumulate_monster", package.seeall)

local title = {
	challengeId = 1,
	name = 3,
	creepMasterHeadIcon = 4,
	skipTime = 5,
	btlMode = 9,
	btlBg = 6,
	enableGainExp = 8,
	creepsMasterId = 2,
	heroSkillId = 7
}
local dataList = {
	{
		2,
		1,
		"潘多拉",
		10167,
		15,
		"",
		"",
		false,
		""
	}
}
local t_timed_challenge_accumulate_monster = {
	[2] = dataList[1]
}

t_timed_challenge_accumulate_monster.dataList = dataList

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

return t_timed_challenge_accumulate_monster
