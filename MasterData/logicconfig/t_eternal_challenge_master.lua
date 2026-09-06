-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_challenge_master.lua

module("logicconfig.config.t_eternal_challenge_master", package.seeall)

local title = {
	description = 8,
	name = 2,
	video = 9,
	skipTime = 3,
	perfectWinId = 12,
	formCondition = 13,
	btlMode = 7,
	btlBg = 4,
	selfBuffProviderId = 14,
	enableGainExp = 15,
	winId = 11,
	creepsMasterId = 1,
	heroSkillId = 5,
	recommendZdl = 6,
	introdRaceId = 10
}
local dataList = {
	{
		101,
		"boss",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		117,
		0,
		0,
		0,
		false
	}
}
local t_eternal_challenge_master = {
	[101] = dataList[1]
}

t_eternal_challenge_master.dataList = dataList

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

return t_eternal_challenge_master
