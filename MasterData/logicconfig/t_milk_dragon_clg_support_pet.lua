-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_milk_dragon_clg_support_pet.lua

module("logicconfig.config.t_milk_dragon_clg_support_pet", package.seeall)

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
		451001,
		100000001,
		14031,
		"御金耀世·光耀圣龙",
		100,
		0,
		0,
		"",
		"生命+2030769#攻击+221538#物防+120000#魔防+120000#速度+36923",
		true,
		"",
		"",
		"1403101"
	},
	{
		451001,
		100000002,
		14031,
		"御金耀世·光耀圣龙",
		100,
		0,
		0,
		"",
		"生命+4061538#攻击+443077#物防+240000#魔防+240000#速度+73846",
		true,
		"",
		"",
		"1403101"
	},
	{
		451001,
		100000003,
		14031,
		"御金耀世·光耀圣龙",
		100,
		0,
		0,
		"",
		"生命+5415385#攻击+590769#物防+320000#魔防+320000#速度+98462",
		true,
		"",
		"",
		"1403101"
	}
}
local t_milk_dragon_clg_support_pet = {
	[451001] = {
		[100000001] = dataList[1],
		[100000002] = dataList[2],
		[100000003] = dataList[3]
	}
}

t_milk_dragon_clg_support_pet.dataList = dataList

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

return t_milk_dragon_clg_support_pet
