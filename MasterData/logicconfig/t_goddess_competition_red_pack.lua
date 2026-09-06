-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_competition_red_pack.lua

module("logicconfig.config.t_goddess_competition_red_pack", package.seeall)

local title = {
	dailyGainLimit = 9,
	sendCost = 6,
	msgTemplate = 4,
	type = 3,
	activityId = 1,
	name = 11,
	gainCount = 7,
	duration = 12,
	param = 13,
	imgPath = 14,
	senderPrize = 10,
	dailySendTimesLimit = 8,
	redPackId = 2,
	incPopularity = 5
}
local dataList = {
	{
		453001,
		1,
		1,
		79,
		1000,
		"105:6107:1000",
		100,
		10,
		10,
		"10:453001:100",
		"普通红包",
		86400,
		"104:2:1000&5",
		"board_nshongbao_18#board_nshongbao_21#board_nshongbao_22#board_nshongbao_18#board_nshongbao_25"
	},
	{
		453001,
		2,
		1,
		81,
		3000,
		"105:6109:3000",
		100,
		10,
		7,
		"10:453001:300",
		"甄选红包",
		86400,
		"104:2:3000&10",
		"board_nshongbao_19#board_nshongbao_21#board_nshongbao_23#board_nshongbao_19#board_nshongbao_25"
	},
	{
		453001,
		3,
		1,
		82,
		5000,
		"105:6111:5000",
		100,
		10,
		5,
		"10:453001:500",
		"豪华红包",
		86400,
		"104:2:5000&15",
		"board_nshongbao_20#board_nshongbao_21#board_nshongbao_24#board_nshongbao_20#board_nshongbao_25"
	},
	{
		453001,
		4,
		2,
		83,
		6666,
		"204:9004:188",
		50,
		100,
		3,
		"10:453001:6666",
		"尊享红包",
		86400,
		"8:1:100000&1",
		"board_nshongbao_07#board_nshongbao_05#board_nshongbao_13#board_nshongbao_07#board_nshongbao_17"
	},
	{
		453001,
		5,
		2,
		84,
		18888,
		"204:9005:388",
		50,
		100,
		2,
		"10:453001:18888",
		"至尊红包",
		86400,
		"8:1:100000&2",
		"board_nshongbao_08#board_nshongbao_05#board_nshongbao_14#board_nshongbao_08#board_nshongbao_17"
	},
	{
		453002,
		1,
		1,
		79,
		1000,
		"105:6123:1000",
		100,
		10,
		10,
		"10:453003:100",
		"普通红包",
		86400,
		"104:2:1000&5",
		"board_nshongbao_18#board_nshongbao_21#board_nshongbao_22#board_nshongbao_18#board_nshongbao_25"
	},
	{
		453002,
		2,
		1,
		81,
		3000,
		"105:6124:3000",
		100,
		10,
		7,
		"10:453003:300",
		"甄选红包",
		86400,
		"104:2:3000&10",
		"board_nshongbao_19#board_nshongbao_21#board_nshongbao_23#board_nshongbao_19#board_nshongbao_25"
	},
	{
		453002,
		3,
		1,
		82,
		5000,
		"105:6125:5000",
		100,
		10,
		5,
		"10:453003:500",
		"豪华红包",
		86400,
		"104:2:5000&15",
		"board_nshongbao_20#board_nshongbao_21#board_nshongbao_24#board_nshongbao_20#board_nshongbao_25"
	},
	{
		453002,
		4,
		2,
		83,
		6666,
		"204:9007:188",
		50,
		100,
		3,
		"10:453003:6666",
		"尊享红包",
		86400,
		"8:1:100000&3",
		"board_nshongbao_07#board_nshongbao_05#board_nshongbao_13#board_nshongbao_07#board_nshongbao_17"
	},
	{
		453002,
		5,
		2,
		84,
		18888,
		"204:9008:388",
		50,
		100,
		2,
		"10:453003:18888",
		"至尊红包",
		86400,
		"8:1:100000&4",
		"board_nshongbao_08#board_nshongbao_05#board_nshongbao_14#board_nshongbao_08#board_nshongbao_17"
	}
}
local t_goddess_competition_red_pack = {
	[453001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[453002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_goddess_competition_red_pack.dataList = dataList

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

return t_goddess_competition_red_pack
