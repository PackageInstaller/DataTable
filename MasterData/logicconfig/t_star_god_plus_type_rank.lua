-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_god_plus_type_rank.lua

module("logicconfig.config.t_star_god_plus_type_rank", package.seeall)

local title = {
	raceType = 1,
	rank = 3,
	type = 2
}
local dataList = {
	{
		1,
		1,
		1
	},
	{
		1,
		10,
		2
	},
	{
		1,
		4,
		3
	},
	{
		1,
		7,
		4
	},
	{
		1,
		6,
		5
	},
	{
		1,
		9,
		6
	},
	{
		1,
		8,
		7
	},
	{
		1,
		5,
		8
	},
	{
		1,
		3,
		9
	},
	{
		1,
		2,
		10
	},
	{
		1,
		11,
		11
	},
	{
		2,
		1,
		1
	},
	{
		2,
		10,
		2
	},
	{
		2,
		4,
		3
	},
	{
		2,
		7,
		4
	},
	{
		2,
		6,
		5
	},
	{
		2,
		9,
		6
	},
	{
		2,
		8,
		7
	},
	{
		2,
		5,
		8
	},
	{
		2,
		3,
		9
	},
	{
		2,
		2,
		10
	},
	{
		2,
		11,
		11
	},
	{
		3,
		1,
		1
	},
	{
		3,
		10,
		2
	},
	{
		3,
		4,
		3
	},
	{
		3,
		7,
		4
	},
	{
		3,
		6,
		5
	},
	{
		3,
		9,
		6
	},
	{
		3,
		8,
		7
	},
	{
		3,
		5,
		8
	},
	{
		3,
		3,
		9
	},
	{
		3,
		2,
		10
	},
	{
		3,
		11,
		11
	},
	{
		4,
		1,
		1
	},
	{
		4,
		10,
		2
	},
	{
		4,
		9,
		3
	},
	{
		4,
		7,
		4
	},
	{
		4,
		6,
		5
	},
	{
		4,
		5,
		6
	},
	{
		4,
		8,
		7
	},
	{
		4,
		4,
		8
	},
	{
		4,
		3,
		9
	},
	{
		4,
		2,
		10
	},
	{
		4,
		11,
		11
	},
	{
		5,
		1,
		1
	},
	{
		5,
		10,
		2
	},
	{
		5,
		9,
		3
	},
	{
		5,
		7,
		4
	},
	{
		5,
		6,
		5
	},
	{
		5,
		5,
		6
	},
	{
		5,
		8,
		7
	},
	{
		5,
		4,
		8
	},
	{
		5,
		3,
		9
	},
	{
		5,
		2,
		10
	},
	{
		5,
		11,
		11
	},
	{
		6,
		1,
		1
	},
	{
		6,
		10,
		2
	},
	{
		6,
		7,
		3
	},
	{
		6,
		9,
		4
	},
	{
		6,
		6,
		5
	},
	{
		6,
		4,
		6
	},
	{
		6,
		8,
		7
	},
	{
		6,
		5,
		8
	},
	{
		6,
		3,
		9
	},
	{
		6,
		2,
		10
	},
	{
		6,
		11,
		11
	}
}
local t_star_god_plus_type_rank = {
	{
		dataList[1],
		[10] = dataList[2],
		[4] = dataList[3],
		[7] = dataList[4],
		[6] = dataList[5],
		[9] = dataList[6],
		[8] = dataList[7],
		[5] = dataList[8],
		[3] = dataList[9],
		dataList[10],
		[11] = dataList[11]
	},
	{
		dataList[12],
		[10] = dataList[13],
		[4] = dataList[14],
		[7] = dataList[15],
		[6] = dataList[16],
		[9] = dataList[17],
		[8] = dataList[18],
		[5] = dataList[19],
		[3] = dataList[20],
		dataList[21],
		[11] = dataList[22]
	},
	{
		dataList[23],
		[10] = dataList[24],
		[4] = dataList[25],
		[7] = dataList[26],
		[6] = dataList[27],
		[9] = dataList[28],
		[8] = dataList[29],
		[5] = dataList[30],
		[3] = dataList[31],
		dataList[32],
		[11] = dataList[33]
	},
	{
		dataList[34],
		[10] = dataList[35],
		[9] = dataList[36],
		[7] = dataList[37],
		[6] = dataList[38],
		[5] = dataList[39],
		[8] = dataList[40],
		[4] = dataList[41],
		[3] = dataList[42],
		dataList[43],
		[11] = dataList[44]
	},
	{
		dataList[45],
		[10] = dataList[46],
		[9] = dataList[47],
		[7] = dataList[48],
		[6] = dataList[49],
		[5] = dataList[50],
		[8] = dataList[51],
		[4] = dataList[52],
		[3] = dataList[53],
		dataList[54],
		[11] = dataList[55]
	},
	{
		dataList[56],
		[10] = dataList[57],
		[7] = dataList[58],
		[9] = dataList[59],
		[6] = dataList[60],
		[4] = dataList[61],
		[8] = dataList[62],
		[5] = dataList[63],
		[3] = dataList[64],
		dataList[65],
		[11] = dataList[66]
	}
}

t_star_god_plus_type_rank.dataList = dataList

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

return t_star_god_plus_type_rank
