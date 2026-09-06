-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_battle_defense_race_plan.lua

module("logicconfig.config.t_star_battle_defense_race_plan", package.seeall)

local title = {
	raceId = 2,
	defenseRacePlanId = 1,
	prize = 4,
	score = 3
}
local dataList = {
	{
		1,
		11030,
		500,
		"10:510001:500"
	},
	{
		1,
		11032,
		300,
		"10:510001:300"
	},
	{
		2,
		16040,
		500,
		"10:510001:500"
	},
	{
		2,
		11033,
		100,
		"10:510001:100"
	},
	{
		3,
		14036,
		300,
		"10:510001:300"
	},
	{
		4,
		11034,
		300,
		"10:510001:300"
	}
}
local t_star_battle_defense_race_plan = {
	{
		[11030] = dataList[1],
		[11032] = dataList[2]
	},
	{
		[16040] = dataList[3],
		[11033] = dataList[4]
	},
	{
		[14036] = dataList[5]
	},
	{
		[11034] = dataList[6]
	}
}

t_star_battle_defense_race_plan.dataList = dataList

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

return t_star_battle_defense_race_plan
