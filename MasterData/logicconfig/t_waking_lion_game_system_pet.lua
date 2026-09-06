-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_waking_lion_game_system_pet.lua

module("logicconfig.config.t_waking_lion_game_system_pet", package.seeall)

local title = {
	awakenLv = 7,
	petPlanId = 1,
	creepsId = 2,
	onlyUseExtProperties = 10,
	faceId = 11,
	extproperties = 9,
	talentLv = 6,
	equipment = 8,
	creepsName = 4,
	raceId = 3,
	lv = 5
}
local dataList = {
	{
		1,
		1000001,
		10146,
		"是非王者·修尔",
		100,
		0,
		0,
		"",
		"生命+10000#攻击+3000#物防+369#魔防+400#速度+369",
		true,
		"1014603"
	},
	{
		1,
		1000002,
		14006,
		"时间神祇·诺亚",
		100,
		0,
		0,
		"",
		"生命+10000#攻击+3000#物防+646#魔防+646#速度+276",
		true,
		"1400601"
	}
}
local t_waking_lion_game_system_pet = {
	{
		[1000001] = dataList[1],
		[1000002] = dataList[2]
	}
}

t_waking_lion_game_system_pet.dataList = dataList

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

return t_waking_lion_game_system_pet
