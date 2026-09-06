-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_correct_principle_challenge_helper.lua

module("logicconfig.config.t_correct_principle_challenge_helper", package.seeall)

local title = {
	awakenLv = 7,
	helpPetPlanId = 1,
	creepsId = 2,
	onlyUseExtProperties = 10,
	faceId = 11,
	extproperties = 9,
	talentLv = 6,
	isFixedPos = 12,
	equipment = 8,
	creepsName = 4,
	posId = 13,
	raceId = 3,
	lv = 5
}
local dataList = {
	{
		1,
		100000001,
		15014,
		"轮回之神·正理",
		100,
		0,
		0,
		"",
		"生命+31032#攻击+12723#物防+2017#魔防+1862#速度+1862",
		true,
		"",
		true,
		1
	},
	{
		2,
		100000002,
		15014,
		"轮回之神·正理",
		100,
		0,
		0,
		"",
		"生命+62064#攻击+25446#物防+4034#魔防+3724#速度+3724",
		true,
		"",
		true,
		1
	},
	{
		3,
		100000003,
		15014,
		"轮回之神·正理",
		100,
		0,
		0,
		"",
		"生命+93097#攻击+38170#物防+6051#魔防+5586#速度+5586",
		true,
		"",
		true,
		1
	},
	{
		4,
		100000004,
		15014,
		"轮回之神·正理",
		100,
		0,
		0,
		"",
		"生命+124129#攻击+50893#物防+8068#魔防+7448#速度+7448",
		true,
		"",
		true,
		1
	},
	{
		5,
		100000005,
		15014,
		"轮回之神·正理",
		100,
		0,
		0,
		"",
		"生命+155161#攻击+63616#物防+10085#魔防+9310#速度+9310",
		true,
		"",
		true,
		1
	},
	{
		6,
		100000006,
		15014,
		"轮回之神·正理",
		100,
		0,
		0,
		"",
		"生命+186193#攻击+76339#物防+12103#魔防+11172#速度+11172",
		true,
		"",
		true,
		1
	}
}
local t_correct_principle_challenge_helper = {
	{
		[100000001] = dataList[1]
	},
	{
		[100000002] = dataList[2]
	},
	{
		[100000003] = dataList[3]
	},
	{
		[100000004] = dataList[4]
	},
	{
		[100000005] = dataList[5]
	},
	{
		[100000006] = dataList[6]
	}
}

t_correct_principle_challenge_helper.dataList = dataList

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

return t_correct_principle_challenge_helper
