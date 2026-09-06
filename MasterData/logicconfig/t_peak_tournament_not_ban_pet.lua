-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_peak_tournament_not_ban_pet.lua

module("logicconfig.config.t_peak_tournament_not_ban_pet", package.seeall)

local title = {
	raceId = 2,
	notBanPlanId = 1
}
local dataList = {
	{
		1,
		18001
	},
	{
		1,
		13009
	},
	{
		1,
		17015
	},
	{
		1,
		12021
	},
	{
		1,
		14022
	},
	{
		2,
		15020
	},
	{
		2,
		13015
	},
	{
		2,
		17016
	},
	{
		2,
		14020
	},
	{
		2,
		14024
	},
	{
		3,
		17015
	},
	{
		3,
		18001
	},
	{
		3,
		12021
	},
	{
		3,
		13009
	},
	{
		3,
		14022
	},
	{
		4,
		14020
	},
	{
		4,
		15020
	},
	{
		4,
		13015
	},
	{
		4,
		11020
	},
	{
		4,
		18011
	},
	{
		5,
		18001
	},
	{
		5,
		13009
	},
	{
		5,
		12021
	},
	{
		5,
		17015
	},
	{
		5,
		14022
	},
	{
		6,
		15020
	},
	{
		6,
		14020
	},
	{
		6,
		18011
	},
	{
		6,
		11020
	},
	{
		6,
		13015
	},
	{
		7,
		18021
	},
	{
		7,
		18001
	},
	{
		7,
		13009
	},
	{
		7,
		14022
	},
	{
		7,
		12021
	},
	{
		8,
		12027
	},
	{
		8,
		18011
	},
	{
		8,
		17015
	},
	{
		8,
		14020
	},
	{
		8,
		13015
	},
	{
		9,
		18001
	},
	{
		9,
		13009
	},
	{
		9,
		18021
	},
	{
		9,
		12021
	},
	{
		9,
		14022
	},
	{
		10,
		12027
	},
	{
		10,
		18011
	},
	{
		10,
		17015
	},
	{
		10,
		14020
	},
	{
		10,
		13015
	},
	{
		11,
		18021
	},
	{
		11,
		18001
	},
	{
		11,
		14022
	},
	{
		11,
		12021
	},
	{
		11,
		13009
	}
}
local t_peak_tournament_not_ban_pet = {
	{
		[18001] = dataList[1],
		[13009] = dataList[2],
		[17015] = dataList[3],
		[12021] = dataList[4],
		[14022] = dataList[5]
	},
	{
		[15020] = dataList[6],
		[13015] = dataList[7],
		[17016] = dataList[8],
		[14020] = dataList[9],
		[14024] = dataList[10]
	},
	{
		[17015] = dataList[11],
		[18001] = dataList[12],
		[12021] = dataList[13],
		[13009] = dataList[14],
		[14022] = dataList[15]
	},
	{
		[14020] = dataList[16],
		[15020] = dataList[17],
		[13015] = dataList[18],
		[11020] = dataList[19],
		[18011] = dataList[20]
	},
	{
		[18001] = dataList[21],
		[13009] = dataList[22],
		[12021] = dataList[23],
		[17015] = dataList[24],
		[14022] = dataList[25]
	},
	{
		[15020] = dataList[26],
		[14020] = dataList[27],
		[18011] = dataList[28],
		[11020] = dataList[29],
		[13015] = dataList[30]
	},
	{
		[18021] = dataList[31],
		[18001] = dataList[32],
		[13009] = dataList[33],
		[14022] = dataList[34],
		[12021] = dataList[35]
	},
	{
		[12027] = dataList[36],
		[18011] = dataList[37],
		[17015] = dataList[38],
		[14020] = dataList[39],
		[13015] = dataList[40]
	},
	{
		[18001] = dataList[41],
		[13009] = dataList[42],
		[18021] = dataList[43],
		[12021] = dataList[44],
		[14022] = dataList[45]
	},
	{
		[12027] = dataList[46],
		[18011] = dataList[47],
		[17015] = dataList[48],
		[14020] = dataList[49],
		[13015] = dataList[50]
	},
	{
		[18021] = dataList[51],
		[18001] = dataList[52],
		[14022] = dataList[53],
		[12021] = dataList[54],
		[13009] = dataList[55]
	}
}

t_peak_tournament_not_ban_pet.dataList = dataList

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

return t_peak_tournament_not_ban_pet
