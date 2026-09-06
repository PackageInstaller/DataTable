-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fan_rui_lottery_pool.lua

module("logicconfig.config.t_fan_rui_lottery_pool", package.seeall)

local title = {
	prizeId = 2,
	prize = 3,
	actId = 1,
	tag = 4
}
local dataList = {
	{
		299001,
		1,
		"4:84396:1",
		"传说魂"
	},
	{
		299001,
		2,
		"4:12102:5",
		"萌宠"
	},
	{
		299001,
		3,
		"4:12102:5",
		"萌宠"
	},
	{
		299001,
		4,
		"4:11002:10000",
		""
	},
	{
		299001,
		5,
		"4:11002:10000",
		""
	},
	{
		299001,
		6,
		"4:11002:10000",
		""
	},
	{
		299001,
		7,
		"4:510022:2",
		""
	},
	{
		299001,
		8,
		"4:510022:2",
		""
	},
	{
		299001,
		9,
		"4:510022:1",
		""
	},
	{
		299001,
		10,
		"4:30006:40",
		""
	},
	{
		299001,
		11,
		"4:30006:40",
		""
	},
	{
		299001,
		12,
		"4:30006:40",
		""
	},
	{
		299001,
		13,
		"4:30006:40",
		""
	},
	{
		299001,
		14,
		"4:30006:40",
		""
	},
	{
		299001,
		15,
		"4:112:5",
		""
	},
	{
		299001,
		16,
		"4:112:5",
		""
	},
	{
		299001,
		17,
		"4:36:5",
		""
	},
	{
		299001,
		18,
		"4:36:5",
		""
	},
	{
		299001,
		19,
		"8:1:500000",
		""
	},
	{
		299001,
		20,
		"8:1:500000",
		""
	}
}
local t_fan_rui_lottery_pool = {
	[299001] = {
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
		dataList[20]
	}
}

t_fan_rui_lottery_pool.dataList = dataList

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

return t_fan_rui_lottery_pool
