-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_empress_clg_support_pet.lua

module("logicconfig.config.t_empress_clg_support_pet", package.seeall)

local title = {
	awakenLv = 7,
	lv = 5,
	creepsId = 2,
	onlyUseExtProperties = 10,
	faceId = 13,
	summonedPetId = 12,
	talentLv = 6,
	summonMasterId = 11,
	equipment = 8,
	creepsName = 4,
	extproperties = 9,
	raceId = 3,
	activityId = 1
}
local dataList = {
	{
		342001,
		100000001,
		16019,
		"命运神谕·女帝",
		100,
		0,
		0,
		"",
		"生命+372308#攻击+40615#物防+22000#魔防+22000#速度+6769",
		true,
		"",
		"",
		""
	},
	{
		342001,
		100000002,
		16020,
		"造物王者·以撒",
		100,
		0,
		0,
		"",
		"生命+169231#攻击+69385#物防+11000#魔防+10154#速度+10154",
		true,
		"",
		"",
		""
	},
	{
		342001,
		100000003,
		16018,
		"断魂行者·正义",
		100,
		0,
		0,
		"",
		"生命+203077#攻击+57538#物防+11000#魔防+11000#速度+11846",
		true,
		"",
		"",
		""
	},
	{
		342001,
		100000004,
		16013,
		"继承者·以世",
		100,
		0,
		0,
		"",
		"生命+169231#攻击+69385#物防+10154#魔防+11000#速度+10154",
		true,
		"",
		"",
		""
	},
	{
		342002,
		100000001,
		16019,
		"命运神谕·女帝",
		100,
		0,
		0,
		"",
		"生命+372308#攻击+40615#物防+22000#魔防+22000#速度+6769",
		true,
		"",
		"",
		""
	},
	{
		342002,
		100000002,
		16020,
		"造物王者·以撒",
		100,
		0,
		0,
		"",
		"生命+169231#攻击+69385#物防+11000#魔防+10154#速度+10154",
		true,
		"",
		"",
		""
	},
	{
		342002,
		100000003,
		16018,
		"断魂行者·正义",
		100,
		0,
		0,
		"",
		"生命+203077#攻击+57538#物防+11000#魔防+11000#速度+11846",
		true,
		"",
		"",
		""
	},
	{
		342002,
		100000004,
		16013,
		"继承者·以世",
		100,
		0,
		0,
		"",
		"生命+169231#攻击+69385#物防+10154#魔防+11000#速度+10154",
		true,
		"",
		"",
		""
	}
}
local t_empress_clg_support_pet = {
	[342001] = {
		[100000001] = dataList[1],
		[100000002] = dataList[2],
		[100000003] = dataList[3],
		[100000004] = dataList[4]
	},
	[342002] = {
		[100000001] = dataList[5],
		[100000002] = dataList[6],
		[100000003] = dataList[7],
		[100000004] = dataList[8]
	}
}

t_empress_clg_support_pet.dataList = dataList

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

return t_empress_clg_support_pet
