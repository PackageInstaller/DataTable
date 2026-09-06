-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pupil_challenge.lua

module("logicconfig.config.t_pupil_challenge", package.seeall)

local title = {
	challengeId = 1,
	rankSize = 2,
	fireTurns = 11,
	buyTimePlanId = 8,
	freeChallengeTimes = 5,
	petBubble = 12,
	hardRankSize = 3,
	prizeLimit = 13,
	maxFireNum = 15,
	GOODS_ID = 10,
	rankPrize = 4,
	spaceLimit = 6,
	demonRoundsDiffer = 14,
	JUMP_ITEM = 9,
	OPEN_TIME = 16,
	challengePlanId = 7
}
local dataList = {
	{
		21,
		5999,
		9999,
		"14:40:1",
		10,
		500,
		1,
		1,
		"100:10334",
		"12011",
		{
			15,
			11,
			8
		},
		"哥哥遇到我的时候，手里捧着鲜花，他其实是很温柔的人",
		"104:2:100",
		1,
		3,
		"09:00:00#23:59:59,00:00:00#05:00:00"
	}
}
local t_pupil_challenge = {
	[21] = dataList[1]
}

t_pupil_challenge.dataList = dataList

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

return t_pupil_challenge
