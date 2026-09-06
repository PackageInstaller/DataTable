-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bury_pit_game.lua

module("logicconfig.config.t_bury_pit_game", package.seeall)

local title = {
	eggPlanId = 6,
	gamePlanId = 5,
	buyGameTimesPlan = 2,
	specialPrizePlan = 4,
	activityId = 1,
	scorePrizePlan = 3
}
local dataList = {
	{
		50001,
		1,
		1,
		1,
		1,
		1
	},
	{
		50002,
		1,
		1,
		1,
		1,
		1
	},
	{
		50003,
		1,
		1,
		1,
		1,
		1
	},
	{
		50004,
		1,
		1,
		1,
		1,
		1
	},
	{
		50005,
		1,
		1,
		1,
		1,
		1
	}
}
local t_bury_pit_game = {
	[50001] = dataList[1],
	[50002] = dataList[2],
	[50003] = dataList[3],
	[50004] = dataList[4],
	[50005] = dataList[5]
}

t_bury_pit_game.dataList = dataList

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

return t_bury_pit_game
