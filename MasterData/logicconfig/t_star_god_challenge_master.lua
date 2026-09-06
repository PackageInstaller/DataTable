-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_god_challenge_master.lua

module("logicconfig.config.t_star_god_challenge_master", package.seeall)

local title = {
	description = 7,
	video = 9,
	perfectWinId = 12,
	skipTime = 2,
	formCondition = 13,
	showPet = 14,
	showPetLv = 15,
	btlMode = 6,
	btlBg = 3,
	selfBuffProviderId = 8,
	winId = 11,
	creepsMasterId = 1,
	heroSkillId = 4,
	recommendZdl = 5,
	introdRaceId = 10
}
local dataList = {
	{
		1,
		3,
		"",
		"410144",
		700000,
		"",
		"",
		0,
		false,
		0,
		0,
		0,
		0,
		10070,
		100
	}
}
local t_star_god_challenge_master = {
	dataList[1]
}

t_star_god_challenge_master.dataList = dataList

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

return t_star_god_challenge_master
