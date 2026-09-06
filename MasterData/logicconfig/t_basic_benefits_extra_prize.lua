-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_basic_benefits_extra_prize.lua

module("logicconfig.config.t_basic_benefits_extra_prize", package.seeall)

local title = {
	index = 1,
	vipLv = 2,
	prize = 3
}
local dataList = {
	{
		0,
		0,
		"4:2000:5#4:400002:2"
	},
	{
		0,
		1,
		"4:2000:5#4:400002:2#4:30:2"
	},
	{
		0,
		2,
		"4:2000:5#4:400002:3#4:30:4"
	},
	{
		0,
		3,
		"4:2000:5#4:400002:3#4:30:6"
	},
	{
		0,
		4,
		"4:2000:5#4:400002:4#4:30:8"
	},
	{
		0,
		5,
		"4:2000:5#4:400002:5#4:31:1"
	},
	{
		0,
		6,
		"4:2000:5#4:400002:5#4:31:1"
	},
	{
		0,
		7,
		"4:2000:5#4:400002:5#4:31:1"
	},
	{
		0,
		8,
		"4:2000:6#4:400002:6#4:31:2"
	},
	{
		0,
		9,
		"4:2000:6#4:400002:6#4:31:2"
	},
	{
		0,
		10,
		"4:2000:6#4:400002:6#4:31:2"
	},
	{
		1,
		0,
		"4:2000:5#4:400002:2"
	},
	{
		1,
		1,
		"4:2000:5#4:400002:3#4:400001:2"
	},
	{
		1,
		2,
		"4:2000:5#4:400002:3#4:400001:4"
	},
	{
		1,
		3,
		"4:2000:5#4:400002:3#4:400001:6"
	},
	{
		1,
		4,
		"4:2000:5#4:400002:4#4:400001:8"
	},
	{
		1,
		5,
		"4:2000:5#4:400002:5#4:36:1"
	},
	{
		1,
		6,
		"4:2000:5#4:400002:5#4:36:1"
	},
	{
		1,
		7,
		"4:2000:5#4:400002:5#4:36:1"
	},
	{
		1,
		8,
		"4:2000:6#4:400002:6#4:36:2"
	},
	{
		1,
		9,
		"4:2000:6#4:400002:6#4:36:2"
	},
	{
		1,
		10,
		"4:2000:6#4:400002:6#4:36:2"
	},
	{
		2,
		0,
		"4:2000:5#4:400002:2"
	},
	{
		2,
		1,
		"4:2000:5#4:400002:3#4:72003:1"
	},
	{
		2,
		2,
		"4:2000:5#4:400002:3#4:72003:1"
	},
	{
		2,
		3,
		"4:2000:5#4:400002:4#4:72003:1"
	},
	{
		2,
		4,
		"4:2000:5#4:400002:5#4:72003:1"
	},
	{
		2,
		5,
		"4:2000:5#4:400002:5#4:72003:2"
	},
	{
		2,
		6,
		"4:2000:5#4:400002:5#4:72003:2"
	},
	{
		2,
		7,
		"4:2000:5#4:400002:5#4:72003:2"
	},
	{
		2,
		8,
		"4:2000:6#4:400002:6#4:72003:3"
	},
	{
		2,
		9,
		"4:2000:6#4:400002:6#4:72003:3"
	},
	{
		2,
		10,
		"4:2000:6#4:400002:6#4:72003:3"
	}
}
local t_basic_benefits_extra_prize = {
	[0] = {
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
		dataList[11]
	},
	{
		[0] = dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22]
	},
	{
		[0] = dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30],
		dataList[31],
		dataList[32],
		dataList[33]
	}
}

t_basic_benefits_extra_prize.dataList = dataList

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

return t_basic_benefits_extra_prize
