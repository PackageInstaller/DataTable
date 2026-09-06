-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_hyur_challenge_info.lua

module("logicconfig.config.t_god_hyur_challenge_info", package.seeall)

local title = {
	score = 6,
	challengeId = 1,
	limitPrizeScore = 9,
	passSaleCost = 3,
	passSaleAward = 4,
	passSaleAwardTime = 5,
	bubbleDesc = 8,
	raceId = 2,
	limitPrize = 7
}
local dataList = {
	{
		60,
		15015,
		"204:4750:288",
		"4:64010:20",
		"2022-12-30T05:00:00",
		150,
		"",
		"本关卡通过后直接获得150修尔原石",
		0
	},
	{
		61,
		15015,
		"",
		"",
		nil,
		60,
		"4:64010:20",
		"通关后获得启示水晶*20",
		20
	}
}
local t_god_hyur_challenge_info = {
	[60] = dataList[1],
	[61] = dataList[2]
}

t_god_hyur_challenge_info.dataList = dataList

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

return t_god_hyur_challenge_info
