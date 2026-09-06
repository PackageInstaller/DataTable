-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_challenge_support.lua

module("logicconfig.config.t_holy_challenge_support", package.seeall)

local title = {
	awakenLv = 6,
	talentLv = 5,
	creepsId = 1,
	maxHp = 12,
	faceId = 13,
	summonedPetId = 11,
	posId = 7,
	extproperties = 9,
	equipment = 8,
	creepsName = 3,
	summonMasterId = 10,
	raceId = 2,
	lv = 4
}
local dataList = {
	{
		1000000001,
		10027,
		"破空·圣光飞龙",
		10,
		0,
		0,
		5,
		"",
		"生命+2121#攻击+1550#物防+89#魔防+86#速度+179",
		"",
		"",
		"",
		""
	},
	{
		1000000002,
		10027,
		"破空·圣光飞龙",
		15,
		0,
		0,
		5,
		"",
		"生命+3395#攻击+2480#物防+143#魔防+137#速度+286",
		"",
		"",
		"",
		""
	},
	{
		1000000003,
		10027,
		"破空·圣光飞龙",
		20,
		0,
		0,
		5,
		"",
		"生命+4668#攻击+3410#物防+197#魔防+189#速度+394",
		"",
		"",
		"",
		""
	},
	{
		1000000004,
		10027,
		"破空·圣光飞龙",
		25,
		0,
		0,
		5,
		"",
		"生命+5941#攻击+4340#物防+250#魔防+241#速度+501",
		"",
		"",
		"",
		""
	},
	{
		1000000005,
		10027,
		"破空·圣光飞龙",
		30,
		0,
		0,
		5,
		"",
		"生命+7214#攻击+5270#物防+304#魔防+292#速度+609",
		"",
		"",
		"",
		""
	},
	{
		1000000006,
		10027,
		"破空·圣光飞龙",
		35,
		0,
		0,
		5,
		"",
		"生命+8487#攻击+6200#物防+358#魔防+344#速度+716",
		"",
		"",
		"",
		""
	}
}
local t_holy_challenge_support = {
	[1000000001] = dataList[1],
	[1000000002] = dataList[2],
	[1000000003] = dataList[3],
	[1000000004] = dataList[4],
	[1000000005] = dataList[5],
	[1000000006] = dataList[6]
}

t_holy_challenge_support.dataList = dataList

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

return t_holy_challenge_support
