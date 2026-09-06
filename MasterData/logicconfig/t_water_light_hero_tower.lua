-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_water_light_hero_tower.lua

module("logicconfig.config.t_water_light_hero_tower", package.seeall)

local title = {
	jumpShop = 8,
	challengeId = 1,
	powerChallengeDailyTimes = 4,
	jumpTo = 6,
	jumpExchange = 9,
	shopId = 5,
	powerChallengeBuyTimeLimit = 2,
	jumpShenYao = 7,
	jumpRank = 10,
	powerChallengeBuyTimeCost = 3
}
local dataList = {
	{
		28,
		3,
		"105:194:50",
		6,
		12040,
		"goodid#12040",
		"",
		"",
		"",
		""
	},
	{
		115,
		3,
		"105:6064:200",
		40,
		38036,
		"func#43#87",
		"func#375",
		"mibao#shenyaolibao",
		"ui#tlcexchangeview#115",
		""
	},
	{
		138,
		3,
		"105:6091:200",
		40,
		14019,
		"",
		"func#375",
		"func#545#3",
		"ui#tlcexchangeview#138",
		"func#618#14019"
	}
}
local t_water_light_hero_tower = {
	[28] = dataList[1],
	[115] = dataList[2],
	[138] = dataList[3]
}

t_water_light_hero_tower.dataList = dataList

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

return t_water_light_hero_tower
