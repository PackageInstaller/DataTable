-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiaonuoplaceprize.lua

module("logicconfig.config.t_xiaonuoplaceprize", package.seeall)

local title = {
	id = 1,
	prize = 3,
	target = 2
}
local dataList = {
	{
		0,
		"1000",
		"8:1:1000"
	},
	{
		1,
		"50000",
		"8:1:1000"
	},
	{
		2,
		"100000",
		"8:1:1000"
	},
	{
		3,
		"500000",
		"8:1:1000"
	},
	{
		4,
		"1000000",
		"8:1:1000"
	},
	{
		5,
		"5000000",
		"8:1:1000"
	},
	{
		6,
		"10000000",
		"8:1:1000"
	},
	{
		7,
		"50000000",
		"8:1:1000"
	},
	{
		8,
		"100000000",
		"8:1:1000"
	},
	{
		9,
		"500000000",
		"8:1:1000"
	},
	{
		10,
		"1000000000",
		"8:1:1000"
	},
	{
		11,
		"2000000000",
		"8:1:1000"
	},
	{
		12,
		"3000000000",
		"8:1:1000"
	},
	{
		13,
		"4000000000",
		"8:1:1000"
	},
	{
		14,
		"5000000000",
		"8:1:1000"
	},
	{
		15,
		"6000000000",
		"8:1:1000"
	},
	{
		16,
		"7000000000",
		"8:1:1000"
	},
	{
		17,
		"8000000000",
		"8:1:1000"
	},
	{
		18,
		"9000000000",
		"8:1:1000"
	},
	{
		19,
		"10000000000",
		"8:1:1000"
	},
	{
		20,
		"20000000000",
		"8:1:1000"
	}
}
local t_xiaonuoplaceprize = {
	[0] = dataList[1],
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
	dataList[21]
}

t_xiaonuoplaceprize.dataList = dataList

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

return t_xiaonuoplaceprize
