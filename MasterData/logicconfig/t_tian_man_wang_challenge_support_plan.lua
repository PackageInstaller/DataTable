-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tian_man_wang_challenge_support_plan.lua

module("logicconfig.config.t_tian_man_wang_challenge_support_plan", package.seeall)

local title = {
	awakenLv = 8,
	creepsId = 2,
	isFixedPos = 3,
	supportPlanId = 1,
	faceId = 15,
	summonedPetId = 14,
	talentLv = 7,
	onlyUseExtProperties = 12,
	equipment = 10,
	creepsName = 5,
	summonMasterId = 13,
	extproperties = 11,
	raceId = 4,
	posId = 9,
	lv = 6
}
local dataList = {
	{
		1001,
		1000000001,
		true,
		10099,
		"战神·天蛮王",
		100,
		0,
		0,
		9,
		"",
		"生命+41846#攻击+7876#物防+2584#魔防+2584#速度+1107",
		true,
		"",
		"",
		""
	},
	{
		1001,
		1000000002,
		true,
		10159,
		"功夫熊猫",
		100,
		0,
		0,
		3,
		"",
		"生命+41846#攻击+7876#物防+2584#魔防+2584#速度+1107",
		true,
		"1000000001",
		"",
		""
	},
	{
		1001,
		1000000003,
		true,
		10202,
		"真元玄武",
		100,
		0,
		0,
		3,
		"",
		"生命+54153#攻击+5907#物防+3200#魔防+3200#速度+984",
		true,
		"1000000001",
		"",
		""
	},
	{
		1001,
		1000000004,
		true,
		10129,
		"混元天命·真龙",
		100,
		0,
		0,
		3,
		"",
		"生命+54153#攻击+5907#物防+3200#魔防+3200#速度+984",
		true,
		"1000000001",
		"",
		""
	},
	{
		1001,
		1000000005,
		true,
		10328,
		"飒影猎手·辛西娅",
		100,
		0,
		0,
		3,
		"",
		"生命+29538#攻击+8369#物防+1600#魔防+1600#速度+1723",
		true,
		"1000000001",
		"",
		""
	}
}
local t_tian_man_wang_challenge_support_plan = {
	[1001] = {
		[1000000001] = dataList[1],
		[1000000002] = dataList[2],
		[1000000003] = dataList[3],
		[1000000004] = dataList[4],
		[1000000005] = dataList[5]
	}
}

t_tian_man_wang_challenge_support_plan.dataList = dataList

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

return t_tian_man_wang_challenge_support_plan
