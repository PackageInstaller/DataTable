-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_boss_creeps.lua

module("logicconfig.config.t_family_boss_creeps", package.seeall)

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
		90360,
		"炽焰合金猪",
		5,
		40,
		0,
		0,
		"",
		"生命+73470962#攻击+7344#物防+833#魔防+814#速度+555",
		true,
		"",
		"",
		""
	},
	{
		2,
		1,
		90324,
		"圣域·黄金圣龙",
		5,
		60,
		0,
		0,
		"",
		"生命+146941925#攻击+14688#物防+1666#魔防+1629#速度+1111",
		true,
		"",
		"",
		""
	},
	{
		3,
		1,
		93005,
		"赫魔莉·青骨",
		5,
		100,
		0,
		0,
		"",
		"生命+146941925#攻击+50000#物防+5000#魔防+5000#速度+3333",
		true,
		"",
		"",
		""
	}
}
local t_family_boss_creeps = {
	{
		dataList[1]
	},
	{
		dataList[2]
	},
	{
		dataList[3]
	}
}

t_family_boss_creeps.dataList = dataList

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

return t_family_boss_creeps
