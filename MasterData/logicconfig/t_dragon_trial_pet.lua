-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_trial_pet.lua

module("logicconfig.config.t_dragon_trial_pet", package.seeall)

local title = {
	awakenLv = 8,
	talentLv = 7,
	creepsId = 2,
	onlyUseExtProperties = 11,
	faceId = 14,
	summonedPetId = 13,
	posId = 5,
	summonMasterId = 12,
	equipment = 9,
	creepsName = 4,
	planId = 1,
	extproperties = 10,
	raceId = 3,
	lv = 6
}
local dataList = {
	{
		1,
		1,
		10338,
		"哆啦梦梦",
		1,
		100,
		0,
		0,
		"",
		"生命+393524#攻击+42928#物防+23250#魔防+23250#速度+6400",
		true,
		"",
		"",
		""
	},
	{
		1,
		2,
		10339,
		"暗黑梦梦",
		3,
		100,
		0,
		0,
		"",
		"生命+181280#攻击+74325#物防+10873#魔防+11781#速度+9600",
		true,
		"",
		"",
		""
	},
	{
		1,
		3,
		10341,
		"炼金梦梦",
		5,
		100,
		0,
		0,
		"",
		"生命+305014#攻击+57412#物防+18838#魔防+18838#速度+7199",
		true,
		"",
		"",
		""
	},
	{
		1,
		4,
		10342,
		"热血梦梦",
		9,
		100,
		0,
		0,
		"",
		"生命+181280#攻击+74325#物防+11781#魔防+10873#速度+9600",
		true,
		"",
		"",
		""
	},
	{
		1,
		5,
		10343,
		"爱心梦梦",
		7,
		100,
		0,
		0,
		"",
		"生命+262857#攻击+54382#物防+18127#魔防+18450#速度+9600",
		true,
		"",
		"",
		""
	},
	{
		2,
		1,
		10338,
		"哆啦梦梦",
		1,
		100,
		0,
		0,
		"",
		"生命+393524#攻击+42928#物防+23250#魔防+23250#速度+6400",
		true,
		"",
		"",
		""
	},
	{
		2,
		2,
		10339,
		"暗黑梦梦",
		3,
		100,
		0,
		0,
		"",
		"生命+181280#攻击+74325#物防+10873#魔防+11781#速度+9600",
		true,
		"",
		"",
		""
	},
	{
		2,
		3,
		10341,
		"炼金梦梦",
		5,
		100,
		0,
		0,
		"",
		"生命+305014#攻击+57412#物防+18838#魔防+18838#速度+7199",
		true,
		"",
		"",
		""
	},
	{
		2,
		4,
		10342,
		"热血梦梦",
		9,
		100,
		0,
		0,
		"",
		"生命+181280#攻击+74325#物防+11781#魔防+10873#速度+9600",
		true,
		"",
		"",
		""
	},
	{
		2,
		5,
		10343,
		"爱心梦梦",
		7,
		100,
		0,
		0,
		"",
		"生命+262857#攻击+54382#物防+18127#魔防+18450#速度+9600",
		true,
		"",
		"",
		""
	}
}
local t_dragon_trial_pet = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_dragon_trial_pet.dataList = dataList

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

return t_dragon_trial_pet
