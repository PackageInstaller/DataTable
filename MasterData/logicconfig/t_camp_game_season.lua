-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_game_season.lua

module("logicconfig.config.t_camp_game_season", package.seeall)

local title = {
	activityId = 1,
	buyPlanId = 3,
	seasonId = 2
}
local dataList = {
	{
		187001,
		1,
		1
	},
	{
		187002,
		2,
		2
	}
}
local t_camp_game_season = {
	[187001] = dataList[1],
	[187002] = dataList[2]
}

t_camp_game_season.dataList = dataList

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

return t_camp_game_season
