-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_nuo_ya_extreme_clg_support_pet.lua

module("logicconfig.config.t_miracle_nuo_ya_extreme_clg_support_pet", package.seeall)

local title = {
	awakenLv = 6,
	raceId = 2,
	creepsId = 1,
	onlyUseExtProperties = 9,
	faceId = 12,
	summonedPetId = 11,
	talentLv = 5,
	summonMasterId = 10,
	equipment = 7,
	creepsName = 3,
	extproperties = 8,
	lv = 4
}
local dataList = {
	{
		100000001,
		20021,
		"奥奇",
		100,
		0,
		0,
		"",
		"生命+10000000#攻击+0#物防+0#魔防+0#速度+0",
		true,
		"",
		"",
		""
	},
	{
		100000002,
		20021,
		"奥奇",
		100,
		0,
		0,
		"",
		"生命+10000000#攻击+0#物防+0#魔防+0#速度+0",
		true,
		"",
		"",
		"2002101"
	}
}
local t_miracle_nuo_ya_extreme_clg_support_pet = {
	[100000001] = dataList[1],
	[100000002] = dataList[2]
}

t_miracle_nuo_ya_extreme_clg_support_pet.dataList = dataList

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

return t_miracle_nuo_ya_extreme_clg_support_pet
