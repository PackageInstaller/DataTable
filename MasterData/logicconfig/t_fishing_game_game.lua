-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fishing_game_game.lua

module("logicconfig.config.t_fishing_game_game", package.seeall)

local title = {
	limitTreasureCountDownTime = 18,
	atkFishInterval = 21,
	limitTreasureBoxNum = 15,
	grassNum = 10,
	atkFishAttackNum = 22,
	hookAddSpeed = 7,
	gamePlanId = 1,
	grassPosX = 11,
	electricGridInterval = 19,
	blood = 4,
	hookAngleSpeed = 8,
	time = 3,
	treasureBoxYRange = 13,
	grassPosY = 12,
	limitTreasureBoxX = 16,
	limitTreasureOpenTime = 17,
	unLimitTreasureBoxX = 14,
	fishPlanId = 2,
	fishNum = 5,
	hookMaxAngle = 9,
	electricGridXRange = 20,
	boatSpeed = 6
}
local dataList = {
	{
		1001,
		1,
		60,
		3,
		10,
		200,
		200,
		8,
		10,
		5,
		{
			-540,
			540
		},
		{
			-215,
			-310
		},
		{
			-280,
			-220
		},
		{
			-340,
			340
		},
		{
			1,
			2
		},
		{
			-440,
			440
		},
		{
			10,
			50
		},
		30,
		10,
		{
			-540,
			540
		},
		5,
		3
	}
}
local t_fishing_game_game = {
	[1001] = dataList[1]
}

t_fishing_game_game.dataList = dataList

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

return t_fishing_game_game
