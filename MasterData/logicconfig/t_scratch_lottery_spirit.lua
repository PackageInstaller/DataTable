-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scratch_lottery_spirit.lua

module("logicconfig.config.t_scratch_lottery_spirit", package.seeall)

local title = {
	displayId = 1,
	bgImg = 3,
	pos = 2
}
local dataList = {
	{
		1601602,
		{
			0,
			-400,
			0.95
		},
		"ui/bigbg/bgskin/bg_pfhd_05.png"
	},
	{
		1601002,
		{
			0,
			-400,
			1
		},
		"ui/bigbg/bgskin/bg_pfhd_04.png"
	},
	{
		1101103,
		{
			250,
			-15,
			-1
		},
		"ui/bigbg/bgskin/bg_pfhd_03.png"
	},
	{
		1401602,
		{
			210,
			-400,
			-0.9
		},
		"ui/bigbg/bgskin/bg_pfhd_02.png"
	},
	{
		1600102,
		{
			-30,
			-400,
			1
		},
		"ui/bigbg/bgskin/bg_pfhd_04.png"
	},
	{
		1700201,
		{
			100,
			-440,
			-1.2
		},
		"ui/bigbg/bgskin/bg_pfhd_02.png"
	},
	{
		1602401,
		{
			180,
			-400,
			0.85
		},
		"ui/bigbg/bgskin/bg_pfhd_05.png"
	},
	{
		1202001,
		{
			230,
			-420,
			-0.9
		},
		"ui/bigbg/bgskin/bg_pfhd_04.png"
	},
	{
		1800102,
		{
			350,
			-395,
			0.9
		},
		"ui/bigbg/bgskin/bg_pfhd_01.png"
	},
	{
		1602606,
		{
			220,
			-420,
			0.85
		},
		"ui/bigbg/bgskin/bg_pfhd_01.png"
	},
	{
		1503201,
		{
			0,
			-380,
			0.73
		},
		"ui/bigbg/bgskin/bg_pfhd_05.png"
	},
	{
		1603404,
		{
			90,
			-350,
			0.65
		},
		"ui/bigbg/bgskin/bg_pfhd_01.png"
	},
	{
		1603202,
		{
			50,
			-380,
			0.75
		},
		"ui/bigbg/bgskin/bg_pfhd_01.png"
	},
	{
		1802103,
		{
			90,
			-280,
			0.58
		},
		"ui/bigbg/bgskin/bg_pfhd_01.png"
	},
	{
		1402301,
		{
			150,
			-380,
			0.8
		},
		"ui/bigbg/bgskin/bg_pfhd_05.png"
	},
	{
		1604003,
		{
			65,
			-425,
			0.85
		},
		"ui/bigbg/bgskin/bg_pfhd_05.png"
	},
	{
		1403803,
		{
			120,
			-380,
			0.7
		},
		"ui/bigbg/bgskin/bg_pfhd_05.png"
	},
	{
		1802101,
		{
			0,
			-460,
			0.8
		},
		"ui/bigbg/bgskin/bg_pfhd_05.png"
	},
	{
		1800101,
		{
			25,
			-420,
			1.05
		},
		"ui/bigbg/bgskin/bg_pfhd_05.png"
	},
	{
		1601001,
		{
			0,
			-440,
			1
		},
		"ui/bigbg/bgskin/bg_pfhd_05.png"
	},
	{
		1202105,
		{
			40,
			-345,
			0.7
		},
		"ui/bigbg/bgskin/bg_pfhd_05.png"
	},
	{
		1103704,
		{
			0,
			-385,
			0.75
		},
		"ui/bigbg/bgskin/bg_pfhd_05.png"
	},
	{
		1702701,
		{
			0,
			-385,
			0.75
		},
		"ui/bigbg/bgskin/bg_pfhd_05.png"
	},
	{
		1802104,
		{
			-25,
			-385,
			0.75
		},
		"ui/bigbg/bgskin/bg_pfhd_05.png"
	},
	{
		1803102,
		{
			55,
			-385,
			0.7
		},
		"ui/bigbg/bgskin/bg_pfhd_05.png"
	}
}
local t_scratch_lottery_spirit = {
	[1601602] = dataList[1],
	[1601002] = dataList[2],
	[1101103] = dataList[3],
	[1401602] = dataList[4],
	[1600102] = dataList[5],
	[1700201] = dataList[6],
	[1602401] = dataList[7],
	[1202001] = dataList[8],
	[1800102] = dataList[9],
	[1602606] = dataList[10],
	[1503201] = dataList[11],
	[1603404] = dataList[12],
	[1603202] = dataList[13],
	[1802103] = dataList[14],
	[1402301] = dataList[15],
	[1604003] = dataList[16],
	[1403803] = dataList[17],
	[1802101] = dataList[18],
	[1800101] = dataList[19],
	[1601001] = dataList[20],
	[1202105] = dataList[21],
	[1103704] = dataList[22],
	[1702701] = dataList[23],
	[1802104] = dataList[24],
	[1803102] = dataList[25]
}

t_scratch_lottery_spirit.dataList = dataList

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

return t_scratch_lottery_spirit
