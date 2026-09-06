-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_2023_annual_fee_preheat_creeps.lua

module("logicconfig.config.t_2023_annual_fee_preheat_creeps", package.seeall)

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
		10373,
		"巨怪",
		5,
		100,
		0,
		0,
		"",
		"生命+156923#攻击+29538#物防+9692#魔防+9692#速度+4154",
		true,
		"",
		"",
		""
	},
	{
		1002,
		1,
		10020,
		"怨毒灵宝",
		1,
		100,
		0,
		0,
		"",
		"生命+15385#攻击+6308#物防+923#魔防+1000#速度+923",
		true,
		"",
		"",
		""
	},
	{
		1002,
		2,
		10072,
		"暗影所罗",
		2,
		100,
		0,
		0,
		"",
		"生命+15385#攻击+6308#物防+1000#魔防+923#速度+923",
		true,
		"",
		"",
		""
	},
	{
		1002,
		3,
		10196,
		"暗怪怪",
		3,
		100,
		0,
		0,
		"",
		"生命+15385#攻击+6308#物防+1000#魔防+923#速度+923",
		true,
		"",
		"",
		""
	},
	{
		1002,
		4,
		10020,
		"怨毒灵宝",
		8,
		100,
		0,
		0,
		"",
		"生命+15385#攻击+6308#物防+923#魔防+1000#速度+923",
		true,
		"",
		"",
		""
	},
	{
		1002,
		5,
		10072,
		"暗影所罗",
		7,
		100,
		0,
		0,
		"",
		"生命+15385#攻击+6308#物防+1000#魔防+923#速度+923",
		true,
		"",
		"",
		""
	},
	{
		1002,
		6,
		10196,
		"暗怪怪",
		5,
		100,
		0,
		0,
		"",
		"生命+15385#攻击+6308#物防+1000#魔防+923#速度+923",
		true,
		"",
		"",
		""
	},
	{
		1003,
		1,
		10319,
		"哈桑",
		4,
		100,
		0,
		0,
		"",
		"生命+15385#攻击+6308#物防+1000#魔防+923#速度+923",
		true,
		"",
		"",
		""
	},
	{
		1003,
		2,
		10351,
		"蝎尾砂蛇",
		6,
		100,
		0,
		0,
		"",
		"生命+15385#攻击+6308#物防+1000#魔防+923#速度+923",
		true,
		"",
		"",
		""
	},
	{
		1003,
		3,
		10348,
		"魇魔",
		5,
		100,
		0,
		0,
		"",
		"生命+26154#攻击+4923#物防+1615#魔防+1615#速度+692",
		true,
		"",
		"",
		""
	},
	{
		1003,
		4,
		10350,
		"曙光树精",
		1,
		100,
		0,
		0,
		"",
		"生命+33846#攻击+3692#物防+2000#魔防+2000#速度+615",
		true,
		"",
		"",
		""
	},
	{
		1003,
		5,
		10348,
		"魇魔",
		8,
		100,
		0,
		0,
		"",
		"生命+26154#攻击+4923#物防+1615#魔防+1615#速度+692",
		true,
		"",
		"",
		""
	},
	{
		1003,
		6,
		10350,
		"曙光树精",
		3,
		100,
		0,
		0,
		"",
		"生命+33846#攻击+3692#物防+2000#魔防+2000#速度+615",
		true,
		"",
		"",
		""
	}
}
local t_2023_annual_fee_preheat_creeps = {
	[1001] = {
		dataList[1]
	},
	[1002] = {
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[1003] = {
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13]
	}
}

t_2023_annual_fee_preheat_creeps.dataList = dataList

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

return t_2023_annual_fee_preheat_creeps
