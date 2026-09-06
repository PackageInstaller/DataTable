-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_accumulate_creeps.lua

module("logicconfig.config.t_timed_challenge_accumulate_creeps", package.seeall)

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
		1,
		1,
		90016,
		"撒古特",
		2,
		80,
		0,
		0,
		"",
		"生命+9923385#攻击+7585",
		true,
		"",
		"",
		""
	},
	{
		1,
		2,
		90016,
		"撒古特",
		5,
		80,
		0,
		0,
		"",
		"生命+9923385#攻击+7585",
		true,
		"",
		"",
		""
	},
	{
		1,
		3,
		90167,
		"梦蝶·潘多拉",
		8,
		80,
		0,
		0,
		"",
		"生命+7083255#攻击+40657",
		true,
		"",
		"",
		""
	}
}
local t_timed_challenge_accumulate_creeps = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_timed_challenge_accumulate_creeps.dataList = dataList

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

return t_timed_challenge_accumulate_creeps
