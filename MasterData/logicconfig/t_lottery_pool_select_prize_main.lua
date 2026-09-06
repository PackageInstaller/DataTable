-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lottery_pool_select_prize_main.lua

module("logicconfig.config.t_lottery_pool_select_prize_main", package.seeall)

local title = {
	jumpTo = 2,
	poolId = 1
}
local dataList = {
	{
		59,
		"func#191#190#190001"
	},
	{
		63,
		"func#191#190#190002"
	},
	{
		75,
		"func#191#190#190003"
	},
	{
		86,
		"func#191#190#190004"
	},
	{
		91,
		"func#191#190#190005"
	},
	{
		95,
		"func#191#190#190006"
	},
	{
		105,
		"func#191#190#190007"
	},
	{
		112,
		"func#191#190#190008"
	},
	{
		118,
		"func#191#190#190009"
	},
	{
		119,
		"func#191#190#190010"
	},
	{
		121,
		"func#191#190#190011"
	},
	{
		122,
		"func#191#190#190012"
	},
	{
		123,
		"func#191#190#190013"
	},
	{
		124,
		"func#191#190#190014"
	},
	{
		125,
		"func#191#190#190015"
	},
	{
		126,
		"func#191#190#190016"
	},
	{
		127,
		"func#191#190#190017"
	},
	{
		128,
		"func#191#190#190018"
	},
	{
		129,
		"func#191#190#190019"
	},
	{
		130,
		"func#191#190#190020"
	},
	{
		131,
		"func#191#190#190021"
	},
	{
		132,
		"func#191#190#190022"
	},
	{
		133,
		"func#191#190#190023"
	},
	{
		134,
		"func#191#190#190024"
	},
	{
		135,
		"func#191#190#190025"
	},
	{
		136,
		"func#191#190#190026"
	},
	{
		137,
		"func#191#190#190027"
	},
	{
		138,
		"func#191#190#190028"
	},
	{
		139,
		"func#191#190#190029"
	},
	{
		140,
		"func#191#190#190030"
	},
	{
		141,
		"func#191#190#190031"
	},
	{
		142,
		"func#191#190#190032"
	},
	{
		143,
		"func#191#190#190033"
	},
	{
		144,
		"func#191#190#190034"
	},
	{
		145,
		"func#191#190#190035"
	},
	{
		146,
		"func#191#190#190036"
	},
	{
		147,
		"func#191#190#190037"
	},
	{
		148,
		"func#191#190#190038"
	},
	{
		149,
		"func#191#190#190039"
	},
	{
		150,
		"func#191#190#190040"
	}
}
local t_lottery_pool_select_prize_main = {
	[59] = dataList[1],
	[63] = dataList[2],
	[75] = dataList[3],
	[86] = dataList[4],
	[91] = dataList[5],
	[95] = dataList[6],
	[105] = dataList[7],
	[112] = dataList[8],
	[118] = dataList[9],
	[119] = dataList[10],
	[121] = dataList[11],
	[122] = dataList[12],
	[123] = dataList[13],
	[124] = dataList[14],
	[125] = dataList[15],
	[126] = dataList[16],
	[127] = dataList[17],
	[128] = dataList[18],
	[129] = dataList[19],
	[130] = dataList[20],
	[131] = dataList[21],
	[132] = dataList[22],
	[133] = dataList[23],
	[134] = dataList[24],
	[135] = dataList[25],
	[136] = dataList[26],
	[137] = dataList[27],
	[138] = dataList[28],
	[139] = dataList[29],
	[140] = dataList[30],
	[141] = dataList[31],
	[142] = dataList[32],
	[143] = dataList[33],
	[144] = dataList[34],
	[145] = dataList[35],
	[146] = dataList[36],
	[147] = dataList[37],
	[148] = dataList[38],
	[149] = dataList[39],
	[150] = dataList[40]
}

t_lottery_pool_select_prize_main.dataList = dataList

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

return t_lottery_pool_select_prize_main
