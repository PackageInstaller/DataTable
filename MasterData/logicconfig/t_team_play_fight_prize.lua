-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_team_play_fight_prize.lua

module("logicconfig.config.t_team_play_fight_prize", package.seeall)

local title = {
	fightPrizePlanId = 1,
	damageRange = 3,
	prize = 4,
	prizeGearId = 2
}
local dataList = {
	{
		1,
		1,
		{
			10000,
			500000
		},
		"8:5:40#9:3001:5#8:6:5"
	},
	{
		1,
		2,
		{
			500000,
			1500000
		},
		"8:5:50#9:3001:5#8:6:5"
	},
	{
		1,
		3,
		{
			1500000,
			99999999
		},
		"8:5:60#9:3001:5#8:6:5"
	},
	{
		19,
		1,
		{
			10000,
			500000
		},
		"8:5:50#9:3001:5#8:6:5"
	},
	{
		19,
		2,
		{
			500000,
			1500000
		},
		"8:5:60#9:3001:5#8:6:5"
	},
	{
		19,
		3,
		{
			1500000,
			99999999
		},
		"8:5:70#9:3001:5#8:6:5"
	}
}
local t_team_play_fight_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[19] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_team_play_fight_prize.dataList = dataList

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

return t_team_play_fight_prize
