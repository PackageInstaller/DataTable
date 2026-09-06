-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_legend_map.lua

module("logicconfig.config.t_legend_map", package.seeall)

local title = {
	challengeId = 2,
	bottomScale = 9,
	hide = 5,
	topScale = 8,
	zdl = 7,
	blockId = 6,
	direction = 4,
	raceId = 1,
	position = 3
}
local dataList = {
	{
		10337,
		16,
		{
			-80,
			-120
		},
		true,
		false,
		3,
		14000,
		0.8,
		0.55
	},
	{
		10082,
		6,
		{
			-20,
			-168
		},
		true,
		false,
		3,
		14000,
		0.8,
		0.55
	},
	{
		10130,
		11,
		{
			30,
			-120
		},
		true,
		false,
		3,
		14000,
		0.8,
		0.55
	},
	{
		10202,
		3,
		{
			80,
			-168
		},
		true,
		false,
		3,
		14000,
		0.8,
		0.55
	},
	{
		10159,
		18,
		{
			-555,
			20
		},
		true,
		false,
		1,
		14000,
		0.8,
		0.55
	},
	{
		10204,
		1,
		{
			-502,
			-56
		},
		true,
		false,
		1,
		14000,
		0.8,
		0.55
	},
	{
		10335,
		17,
		{
			-420,
			-10
		},
		true,
		false,
		1,
		14000,
		0.8,
		0.55
	},
	{
		10203,
		2,
		{
			-350,
			40
		},
		true,
		false,
		1,
		14000,
		0.8,
		0.55
	},
	{
		10083,
		7,
		{
			-280,
			-60
		},
		true,
		false,
		1,
		14000,
		0.8,
		0.55
	},
	{
		10129,
		14,
		{
			-510,
			275
		},
		true,
		false,
		2,
		14000,
		0.8,
		0.55
	},
	{
		10084,
		8,
		{
			-405,
			243
		},
		true,
		false,
		2,
		14000,
		0.8,
		0.55
	},
	{
		10127,
		13,
		{
			-350,
			270
		},
		true,
		false,
		2,
		14000,
		0.8,
		0.55
	},
	{
		10155,
		21,
		{
			-327,
			220
		},
		true,
		false,
		2,
		14000,
		0.8,
		0.55
	},
	{
		10131,
		12,
		{
			-278,
			271
		},
		true,
		false,
		2,
		14000,
		0.8,
		0.55
	}
}
local t_legend_map = {
	[10337] = dataList[1],
	[10082] = dataList[2],
	[10130] = dataList[3],
	[10202] = dataList[4],
	[10159] = dataList[5],
	[10204] = dataList[6],
	[10335] = dataList[7],
	[10203] = dataList[8],
	[10083] = dataList[9],
	[10129] = dataList[10],
	[10084] = dataList[11],
	[10127] = dataList[12],
	[10155] = dataList[13],
	[10131] = dataList[14]
}

t_legend_map.dataList = dataList

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

return t_legend_map
