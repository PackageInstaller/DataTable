-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saintknight_tian_prize.lua

module("logicconfig.config.t_saintknight_tian_prize", package.seeall)

local title = {
	ID = 2,
	prize = 3,
	prizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		"4:141:2"
	},
	{
		1,
		2,
		"4:141:2"
	},
	{
		1,
		3,
		"4:141:2"
	},
	{
		1,
		4,
		"4:141:2"
	},
	{
		1,
		5,
		"4:141:2"
	},
	{
		1,
		6,
		"4:141:2"
	},
	{
		1,
		7,
		"4:141:2"
	},
	{
		1,
		8,
		"4:141:2"
	},
	{
		1,
		9,
		"4:141:2"
	},
	{
		1,
		10,
		"4:141:2"
	},
	{
		1,
		11,
		"4:141:2"
	},
	{
		1,
		12,
		"4:141:2"
	},
	{
		1,
		13,
		"4:141:2"
	},
	{
		1,
		14,
		"4:141:2"
	},
	{
		1,
		15,
		"4:141:2"
	},
	{
		1,
		16,
		"4:141:2"
	},
	{
		1,
		17,
		"4:141:2"
	},
	{
		1,
		18,
		"4:141:2"
	},
	{
		1,
		19,
		"4:141:2"
	},
	{
		1,
		20,
		"4:141:2"
	},
	{
		1,
		21,
		"4:141:2"
	},
	{
		1,
		22,
		"4:141:2"
	},
	{
		1,
		23,
		"4:141:2"
	},
	{
		1,
		24,
		"4:141:2"
	},
	{
		1,
		25,
		"4:141:2"
	},
	{
		1,
		26,
		"4:141:2"
	},
	{
		1,
		27,
		"4:141:2"
	},
	{
		1,
		28,
		"4:141:2"
	},
	{
		1,
		29,
		"4:141:2"
	},
	{
		1,
		30,
		"4:141:2"
	}
}
local t_saintknight_tian_prize = {
	{
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

t_saintknight_tian_prize.dataList = dataList

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

return t_saintknight_tian_prize
