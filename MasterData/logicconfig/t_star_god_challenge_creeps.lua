-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_god_challenge_creeps.lua

module("logicconfig.config.t_star_god_challenge_creeps", package.seeall)

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
	maxHp = 15,
	lv = 6,
	runeSuitSeq = 16
}
local dataList = {
	{
		1,
		1,
		10144,
		"生命王者·阿瑞斯",
		2,
		100,
		0,
		0,
		"",
		"生命+705059#攻击+76915#物防+41662#魔防+41662#速度+12819",
		true,
		"",
		"",
		"",
		"",
		""
	},
	{
		1,
		2,
		10099,
		"战神·天蛮王",
		1,
		100,
		0,
		0,
		"",
		"生命+539370#攻击+101528#物防+33314#魔防+33314#速度+14277",
		true,
		"",
		"",
		"",
		"",
		""
	},
	{
		1,
		3,
		10129,
		"混元天命·真龙",
		5,
		100,
		0,
		0,
		"",
		"生命+690958#攻击+75377#物防+40829#魔防+40829#速度+12562",
		true,
		"",
		"",
		"",
		"",
		""
	},
	{
		1,
		4,
		10341,
		"炼金梦梦",
		8,
		100,
		0,
		0,
		"",
		"生命+539370#攻击+101528#物防+33314#魔防+33314#速度+14277",
		true,
		"",
		"",
		"",
		"",
		""
	},
	{
		1,
		5,
		10070,
		"大师·九九",
		4,
		100,
		0,
		0,
		"",
		"生命+317276#攻击+130083#物防+20622#魔防+19036#速度+19036",
		true,
		"",
		"",
		"",
		"",
		""
	},
	{
		1,
		6,
		10202,
		"真元玄武",
		3,
		100,
		0,
		0,
		"",
		"生命+690958#攻击+75377#物防+40829#魔防+40829#速度+12562",
		true,
		"",
		"",
		"",
		"",
		""
	}
}
local t_star_god_challenge_creeps = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_star_god_challenge_creeps.dataList = dataList

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

return t_star_god_challenge_creeps
