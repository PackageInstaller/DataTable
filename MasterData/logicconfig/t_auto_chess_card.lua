-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_auto_chess_card.lua

module("logicconfig.config.t_auto_chess_card", package.seeall)

local title = {
	rate = 2,
	raceId = 1,
	fettersId = 3,
	tip = 4
}
local dataList = {
	{
		10142,
		1,
		1,
		""
	},
	{
		11014,
		1,
		1,
		""
	},
	{
		11018,
		3,
		1,
		""
	},
	{
		11011,
		4,
		1,
		""
	},
	{
		11012,
		2,
		1,
		""
	},
	{
		11009,
		2,
		1,
		""
	},
	{
		11010,
		3,
		1,
		""
	},
	{
		10143,
		1,
		2,
		""
	},
	{
		10327,
		1,
		2,
		""
	},
	{
		10334,
		2,
		2,
		""
	},
	{
		12009,
		2,
		2,
		""
	},
	{
		12014,
		4,
		2,
		""
	},
	{
		12016,
		3,
		2,
		""
	},
	{
		12017,
		1,
		2,
		""
	},
	{
		12012,
		5,
		2,
		"荐"
	},
	{
		10129,
		1,
		3,
		""
	},
	{
		13009,
		1,
		3,
		""
	},
	{
		10328,
		2,
		3,
		""
	},
	{
		13008,
		3,
		3,
		""
	},
	{
		13005,
		2,
		3,
		""
	},
	{
		13013,
		4,
		3,
		""
	},
	{
		13007,
		1,
		3,
		""
	},
	{
		10181,
		1,
		4,
		""
	},
	{
		14016,
		2,
		4,
		""
	},
	{
		14006,
		2,
		4,
		""
	},
	{
		14010,
		1,
		4,
		""
	},
	{
		14011,
		3,
		4,
		""
	},
	{
		14014,
		4,
		4,
		""
	},
	{
		14015,
		1,
		4,
		""
	},
	{
		14013,
		5,
		4,
		"荐"
	},
	{
		14017,
		4,
		4,
		""
	},
	{
		14018,
		2,
		4,
		""
	},
	{
		14019,
		1,
		4,
		""
	},
	{
		14020,
		3,
		4,
		""
	},
	{
		14021,
		1,
		4,
		""
	},
	{
		10146,
		1,
		5,
		""
	},
	{
		10183,
		3,
		5,
		""
	},
	{
		10330,
		3,
		5,
		""
	},
	{
		15006,
		2,
		5,
		""
	},
	{
		15013,
		2,
		5,
		""
	},
	{
		15014,
		1,
		5,
		""
	},
	{
		15016,
		4,
		5,
		""
	},
	{
		15017,
		1,
		5,
		""
	},
	{
		15018,
		2,
		5,
		""
	},
	{
		15019,
		3,
		5,
		""
	},
	{
		15020,
		5,
		5,
		"荐"
	},
	{
		15021,
		4,
		5,
		""
	},
	{
		15022,
		2,
		5,
		""
	},
	{
		15023,
		1,
		5,
		""
	},
	{
		17010,
		1,
		6,
		""
	},
	{
		16009,
		2,
		6,
		""
	},
	{
		16011,
		1,
		6,
		""
	},
	{
		16013,
		2,
		6,
		""
	},
	{
		16014,
		3,
		6,
		""
	},
	{
		17003,
		3,
		6,
		""
	},
	{
		17006,
		4,
		6,
		""
	},
	{
		16010,
		5,
		6,
		"荐"
	}
}
local t_auto_chess_card = {
	[10142] = dataList[1],
	[11014] = dataList[2],
	[11018] = dataList[3],
	[11011] = dataList[4],
	[11012] = dataList[5],
	[11009] = dataList[6],
	[11010] = dataList[7],
	[10143] = dataList[8],
	[10327] = dataList[9],
	[10334] = dataList[10],
	[12009] = dataList[11],
	[12014] = dataList[12],
	[12016] = dataList[13],
	[12017] = dataList[14],
	[12012] = dataList[15],
	[10129] = dataList[16],
	[13009] = dataList[17],
	[10328] = dataList[18],
	[13008] = dataList[19],
	[13005] = dataList[20],
	[13013] = dataList[21],
	[13007] = dataList[22],
	[10181] = dataList[23],
	[14016] = dataList[24],
	[14006] = dataList[25],
	[14010] = dataList[26],
	[14011] = dataList[27],
	[14014] = dataList[28],
	[14015] = dataList[29],
	[14013] = dataList[30],
	[14017] = dataList[31],
	[14018] = dataList[32],
	[14019] = dataList[33],
	[14020] = dataList[34],
	[14021] = dataList[35],
	[10146] = dataList[36],
	[10183] = dataList[37],
	[10330] = dataList[38],
	[15006] = dataList[39],
	[15013] = dataList[40],
	[15014] = dataList[41],
	[15016] = dataList[42],
	[15017] = dataList[43],
	[15018] = dataList[44],
	[15019] = dataList[45],
	[15020] = dataList[46],
	[15021] = dataList[47],
	[15022] = dataList[48],
	[15023] = dataList[49],
	[17010] = dataList[50],
	[16009] = dataList[51],
	[16011] = dataList[52],
	[16013] = dataList[53],
	[16014] = dataList[54],
	[17003] = dataList[55],
	[17006] = dataList[56],
	[16010] = dataList[57]
}

t_auto_chess_card.dataList = dataList

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

return t_auto_chess_card
