-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ci_yuan_dragon_nuo_ya_clg_support_pet.lua

module("logicconfig.config.t_ci_yuan_dragon_nuo_ya_clg_support_pet", package.seeall)

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
		408001,
		100000001,
		14030,
		"次元龙皇·诺亚",
		100,
		0,
		0,
		"",
		"生命+615384#攻击+180219#物防+36923#魔防+40000#速度+36923",
		true,
		"",
		"",
		""
	},
	{
		408001,
		100000002,
		14030,
		"次元龙皇·诺亚",
		100,
		0,
		0,
		"",
		"生命+615384#攻击+180219#物防+36923#魔防+40000#速度+36923",
		true,
		"",
		"",
		""
	},
	{
		408001,
		100000003,
		14030,
		"次元龙皇·诺亚",
		100,
		0,
		0,
		"",
		"生命+615384#攻击+180219#物防+36923#魔防+40000#速度+36923",
		true,
		"",
		"",
		""
	}
}
local t_ci_yuan_dragon_nuo_ya_clg_support_pet = {
	[408001] = {
		[100000001] = dataList[1],
		[100000002] = dataList[2],
		[100000003] = dataList[3]
	}
}

t_ci_yuan_dragon_nuo_ya_clg_support_pet.dataList = dataList

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

return t_ci_yuan_dragon_nuo_ya_clg_support_pet
