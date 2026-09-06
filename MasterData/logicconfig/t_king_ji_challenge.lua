-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ji_challenge.lua

module("logicconfig.config.t_king_ji_challenge", package.seeall)

local title = {
	attrJumpTo = 9,
	rankJumpTo = 7,
	raceId = 10,
	posAndScale = 11,
	courierOpenTime = 4,
	soulOpenTime = 5,
	courierDailyChallengeTimes = 2,
	redPointId = 3,
	mixOpenTime = 6,
	lotterJumpTo = 8,
	ruleKeyMain = 12,
	actId = 1
}
local dataList = {
	{
		308001,
		5,
		517,
		"2023-10-01T05:00:00",
		"2023-10-01T05:00:00",
		"2023-10-01T05:00:00",
		"func#618#17010",
		"func#952",
		"mibao#shuangjiekuanghuan2",
		17010,
		{
			0,
			-600,
			1
		},
		"kingjichallengemainview"
	},
	{
		308002,
		5,
		696,
		"2023-10-01T05:00:00",
		"2023-10-01T05:00:00",
		"2023-10-01T05:00:00",
		"func#618#17010",
		"func#952",
		"mibao#shuangjiekuanghuan2",
		17010,
		{
			0,
			-600,
			1
		},
		"kingjichallengemainview2"
	}
}
local t_king_ji_challenge = {
	[308001] = dataList[1],
	[308002] = dataList[2]
}

t_king_ji_challenge.dataList = dataList

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

return t_king_ji_challenge
