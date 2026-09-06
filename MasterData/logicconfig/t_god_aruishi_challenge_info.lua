-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_aruishi_challenge_info.lua

module("logicconfig.config.t_god_aruishi_challenge_info", package.seeall)

local title = {
	score = 5,
	challengeId = 1,
	challengeBossTimes = 9,
	storyId = 10,
	passSaleCost = 2,
	passSaleAward = 3,
	passSaleAwardTime = 4,
	stageNum = 7,
	ruleId = 11,
	waveNum = 6,
	bossWaveStageNum = 8
}
local dataList = {
	{
		47,
		"204:4750:288",
		"4:64009:20",
		"2022-09-09T05:00:00",
		10000,
		3,
		6,
		3,
		3,
		4300008,
		1
	},
	{
		50,
		"",
		"4:64009:20",
		"2022-09-09T05:00:00",
		1000,
		3,
		6,
		3,
		3,
		0,
		2
	}
}
local t_god_aruishi_challenge_info = {
	[47] = dataList[1],
	[50] = dataList[2]
}

t_god_aruishi_challenge_info.dataList = dataList

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

return t_god_aruishi_challenge_info
