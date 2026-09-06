-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_miya_boss_creeps.lua

module("logicconfig.config.t_timed_challenge_miya_boss_creeps", package.seeall)

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
		90147,
		"造化之神·弥娅",
		5,
		100,
		0,
		0,
		"",
		"生命+183677#攻击+6364#物防+1000#魔防+977",
		true,
		"",
		"",
		""
	},
	{
		2,
		1,
		90147,
		"造化之神·弥娅",
		5,
		100,
		0,
		0,
		"",
		"生命+229596#攻击+7956#物防+1250#魔防+1222",
		true,
		"",
		"",
		""
	},
	{
		3,
		1,
		90147,
		"造化之神·弥娅",
		5,
		100,
		0,
		0,
		"",
		"生命+229596#攻击+7956#物防+1250#魔防+1222",
		true,
		"",
		"",
		""
	},
	{
		4,
		1,
		90147,
		"造化之神·弥娅",
		5,
		100,
		0,
		0,
		"",
		"生命+275516#攻击+9547#物防+1500#魔防+1466",
		true,
		"",
		"",
		""
	},
	{
		5,
		1,
		90147,
		"造化之神·弥娅",
		5,
		100,
		0,
		0,
		"",
		"生命+275516#攻击+9547#物防+1500#魔防+1466",
		true,
		"",
		"",
		""
	},
	{
		6,
		1,
		90147,
		"造化之神·弥娅",
		5,
		100,
		0,
		0,
		"",
		"生命+367354#攻击+12729#物防+2000#魔防+1955",
		true,
		"",
		"",
		""
	},
	{
		7,
		1,
		90147,
		"造化之神·弥娅",
		5,
		100,
		0,
		0,
		"",
		"生命+367354#攻击+12729#物防+2000#魔防+1955",
		true,
		"",
		"",
		""
	},
	{
		8,
		1,
		90147,
		"造化之神·弥娅",
		5,
		100,
		0,
		0,
		"",
		"生命+367354#攻击+12729#物防+2000#魔防+1955",
		true,
		"",
		"",
		""
	}
}
local t_timed_challenge_miya_boss_creeps = {
	{
		dataList[1]
	},
	{
		dataList[2]
	},
	{
		dataList[3]
	},
	{
		dataList[4]
	},
	{
		dataList[5]
	},
	{
		dataList[6]
	},
	{
		dataList[7]
	},
	{
		dataList[8]
	}
}

t_timed_challenge_miya_boss_creeps.dataList = dataList

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

return t_timed_challenge_miya_boss_creeps
