-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_waking_lion_game_creeps.lua

module("logicconfig.config.t_waking_lion_game_creeps", package.seeall)

local title = {
	awakenLv = 8,
	raceId = 3,
	creepsId = 2,
	onlyUseExtProperties = 11,
	faceId = 14,
	summonedPetId = 13,
	posId = 5,
	summonMasterId = 12,
	equipment = 9,
	creepsName = 4,
	talentLv = 7,
	extproperties = 10,
	creepsMasterId = 1,
	lv = 6
}
local dataList = {
	{
		1001,
		1,
		10369,
		"渊魔",
		5,
		100,
		0,
		0,
		"",
		"生命+10000#攻击+1000#物防+0#魔防+0#速度+100",
		true,
		"",
		"",
		""
	}
}
local t_waking_lion_game_creeps = {
	[1001] = {
		dataList[1]
	}
}

t_waking_lion_game_creeps.dataList = dataList

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

return t_waking_lion_game_creeps
