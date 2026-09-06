-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_battle_crack_formation_race_plan.lua

module("logicconfig.config.t_star_battle_crack_formation_race_plan", package.seeall)

local title = {
	raceId = 2,
	formationRacePlanId = 1,
	scorePercent = 3
}
local dataList = {
	{
		1,
		11030,
		50
	},
	{
		1,
		11032,
		30
	},
	{
		2,
		16040,
		50
	},
	{
		2,
		11033,
		10
	},
	{
		3,
		14036,
		30
	},
	{
		4,
		11034,
		30
	}
}
local t_star_battle_crack_formation_race_plan = {
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

t_star_battle_crack_formation_race_plan.dataList = dataList

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

return t_star_battle_crack_formation_race_plan
