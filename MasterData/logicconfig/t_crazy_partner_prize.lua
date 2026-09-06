-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_crazy_partner_prize.lua

module("logicconfig.config.t_crazy_partner_prize", package.seeall)

local title = {
	id = 2,
	gain = 4,
	activityId = 1,
	score = 3
}
local dataList = {
	{
		153001,
		1,
		100,
		"8:1:300000"
	},
	{
		153001,
		2,
		200,
		"4:112:2"
	},
	{
		153001,
		3,
		300,
		"10:149001:280"
	},
	{
		153001,
		4,
		400,
		"8:1:300000"
	},
	{
		153001,
		5,
		500,
		"4:112:2"
	},
	{
		153001,
		6,
		600,
		"10:149001:280"
	},
	{
		153001,
		7,
		700,
		"8:1:300000"
	},
	{
		153001,
		8,
		800,
		"4:112:2"
	},
	{
		153001,
		9,
		900,
		"10:149001:280"
	},
	{
		153001,
		10,
		1000,
		"8:1:300000"
	},
	{
		153001,
		11,
		1100,
		"4:112:2"
	},
	{
		153001,
		12,
		1200,
		"10:149001:280"
	},
	{
		153001,
		13,
		1300,
		"8:1:300000"
	},
	{
		153001,
		14,
		1400,
		"4:112:2"
	},
	{
		153001,
		15,
		1500,
		"10:149001:280"
	},
	{
		153001,
		16,
		1600,
		"8:1:300000"
	},
	{
		153001,
		17,
		1700,
		"4:112:2"
	},
	{
		153001,
		18,
		1800,
		"10:149001:280"
	},
	{
		153001,
		19,
		1900,
		"8:1:300000"
	},
	{
		153001,
		20,
		2000,
		"4:112:2"
	},
	{
		153001,
		21,
		2100,
		"10:149001:280"
	},
	{
		153001,
		22,
		2200,
		"8:1:300000"
	},
	{
		153001,
		23,
		2300,
		"4:112:2"
	},
	{
		153001,
		24,
		2400,
		"10:149001:280"
	},
	{
		153001,
		25,
		2500,
		"8:1:300000"
	},
	{
		153001,
		26,
		2600,
		"4:112:2"
	},
	{
		153001,
		27,
		2700,
		"10:149001:280"
	},
	{
		153001,
		28,
		2800,
		"8:1:300000"
	},
	{
		153001,
		29,
		2900,
		"4:112:2"
	},
	{
		153001,
		30,
		3000,
		"10:149001:280"
	}
}
local t_crazy_partner_prize = {
	[153001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	}
}

t_crazy_partner_prize.dataList = dataList

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

return t_crazy_partner_prize
