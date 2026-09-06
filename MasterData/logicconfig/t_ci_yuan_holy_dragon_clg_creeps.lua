-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ci_yuan_holy_dragon_clg_creeps.lua

module("logicconfig.config.t_ci_yuan_holy_dragon_clg_creeps", package.seeall)

local title = {
	raceId = 3,
	creepsMasterId = 1,
	creepsId = 2,
	onlyUseExtProperties = 8,
	faceId = 11,
	summonedPetId = 10,
	posId = 5,
	summonMasterId = 9,
	creepsName = 4,
	extproperties = 7,
	lv = 6
}
local dataList = {
	{
		999001,
		1,
		11002,
		"神罚·秩序圣龙",
		4,
		100,
		"生命+700000000#攻击+600000#物防+150000#魔防+150000#速度+200000",
		true,
		"",
		"",
		""
	},
	{
		999001,
		2,
		10314,
		"烈焰·无烬圣龙",
		5,
		100,
		"生命+700000000#攻击+600000#物防+150000#魔防+150000#速度+200000",
		true,
		"",
		"",
		""
	},
	{
		999001,
		3,
		13008,
		"不朽枯木·永恒圣龙",
		6,
		100,
		"生命+700000000#攻击+600000#物防+150000#魔防+150000#速度+200000",
		true,
		"",
		"",
		""
	},
	{
		999002,
		1,
		10324,
		"圣域·黄金圣龙",
		4,
		100,
		"生命+700000000#攻击+600000#物防+150000#魔防+150000#速度+200000",
		true,
		"",
		"",
		""
	},
	{
		999002,
		2,
		15006,
		"无限时空·龙尊",
		6,
		100,
		"生命+700000000#攻击+600000#物防+150000#魔防+150000#速度+200000",
		true,
		"",
		"",
		""
	},
	{
		999003,
		1,
		17003,
		"天元·王者圣龙",
		4,
		100,
		"生命+700000000#攻击+600000#物防+150000#魔防+150000#速度+200000",
		true,
		"",
		"",
		""
	},
	{
		999003,
		2,
		16004,
		"星宙·超神圣龙",
		6,
		100,
		"生命+700000000#攻击+600000#物防+150000#魔防+150000#速度+200000",
		true,
		"",
		"",
		""
	}
}
local t_ci_yuan_holy_dragon_clg_creeps = {
	[999001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[999002] = {
		dataList[4],
		dataList[5]
	},
	[999003] = {
		dataList[6],
		dataList[7]
	}
}

t_ci_yuan_holy_dragon_clg_creeps.dataList = dataList

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

return t_ci_yuan_holy_dragon_clg_creeps
