-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cynthia_challenge_common.lua

module("logicconfig.config.t_cynthia_challenge_common", package.seeall)

local title = {
	jumpItem = 8,
	openTime = 2,
	jumpStr2 = 13,
	challengeId = 1,
	jumpShop = 11,
	passMinAlive = 10,
	jumpStr1 = 12,
	passPrize = 3,
	jumpStr3 = 14,
	rankSize = 4,
	rankPrize = 5,
	jumpFuncId = 9,
	challengePrizeLimit = 7,
	challengePrize = 6,
	jumpStr4 = 15
}
local dataList = {
	{
		17,
		"05:00:00#23:59:59,00:00:00#05:00:00",
		"100:10328:1:1#62:57:1",
		5999,
		"14:35:1",
		"104:2:5",
		5,
		"100:10328",
		535,
		1,
		"mibao#Skin",
		"",
		"",
		"",
		""
	},
	{
		177,
		"05:00:00#23:59:59,00:00:00#05:00:00",
		"4:243:4000",
		0,
		"",
		"104:2:5",
		5,
		"",
		0,
		1,
		"mibao#Skin",
		"func#618#15025",
		"mibao#qijijianglin5",
		"func#1097",
		"func#191#340#340002"
	}
}
local t_cynthia_challenge_common = {
	[17] = dataList[1],
	[177] = dataList[2]
}

t_cynthia_challenge_common.dataList = dataList

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

return t_cynthia_challenge_common
