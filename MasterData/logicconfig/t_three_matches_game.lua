-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_matches_game.lua

module("logicconfig.config.t_three_matches_game", package.seeall)

local title = {
	dailyGameLimit = 2,
	buyStepCost = 4,
	redPointId = 6,
	dailyBuyStepLimit = 3,
	addBuyStep = 5,
	itemId = 7,
	activityId = 1
}
local dataList = {
	{
		349001,
		3,
		5,
		"105:6095:10",
		10,
		569,
		"10:349002"
	},
	{
		349002,
		3,
		0,
		"105:6095:10",
		10,
		569,
		"10:349002"
	},
	{
		349003,
		3,
		0,
		"105:6095:10",
		10,
		569,
		"10:349003"
	},
	{
		349004,
		2,
		0,
		"105:6095:10",
		10,
		569,
		"10:349004"
	}
}
local t_three_matches_game = {
	[349001] = dataList[1],
	[349002] = dataList[2],
	[349003] = dataList[3],
	[349004] = dataList[4]
}

t_three_matches_game.dataList = dataList

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

return t_three_matches_game
