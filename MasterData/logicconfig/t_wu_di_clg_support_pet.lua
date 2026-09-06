-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wu_di_clg_support_pet.lua

module("logicconfig.config.t_wu_di_clg_support_pet", package.seeall)

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
		317001,
		100000001,
		14017,
		"无上战主·无敌",
		100,
		0,
		0,
		"",
		"生命+199385#攻击+56492#物防+10800#魔防+10800#速度+11631",
		true,
		"",
		"",
		""
	},
	{
		317002,
		100000001,
		14017,
		"无上战主·无敌",
		100,
		0,
		0,
		"",
		"生命+199385#攻击+56492#物防+10800#魔防+10800#速度+11631",
		true,
		"",
		"",
		""
	}
}
local t_wu_di_clg_support_pet = {
	[317001] = {
		[100000001] = dataList[1]
	},
	[317002] = {
		[100000001] = dataList[2]
	}
}

t_wu_di_clg_support_pet.dataList = dataList

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

return t_wu_di_clg_support_pet
