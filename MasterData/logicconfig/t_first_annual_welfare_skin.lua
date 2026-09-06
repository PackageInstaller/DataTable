-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_first_annual_welfare_skin.lua

module("logicconfig.config.t_first_annual_welfare_skin", package.seeall)

local title = {
	planId = 1,
	skinId = 2
}
local dataList = {
	{
		1001,
		1600501
	},
	{
		1001,
		1600601
	},
	{
		1001,
		1033801
	},
	{
		1001,
		1033901
	},
	{
		1001,
		1034101
	},
	{
		1001,
		1034201
	},
	{
		1001,
		1034301
	},
	{
		1001,
		1002701
	},
	{
		1001,
		1032401
	},
	{
		1001,
		1009701
	},
	{
		1001,
		1010101
	},
	{
		1001,
		1013001
	},
	{
		1001,
		1014201
	},
	{
		1001,
		1014301
	},
	{
		1001,
		1014501
	},
	{
		1001,
		1014502
	},
	{
		1001,
		1014503
	},
	{
		1001,
		1014601
	},
	{
		1001,
		1014602
	},
	{
		1001,
		1014701
	},
	{
		1001,
		1014702
	},
	{
		1001,
		1016701
	},
	{
		1001,
		1030901
	},
	{
		1001,
		1031301
	},
	{
		1001,
		1032001
	},
	{
		1001,
		1032201
	},
	{
		1001,
		1032203
	},
	{
		1001,
		1032301
	},
	{
		1001,
		1032701
	},
	{
		1001,
		1032801
	},
	{
		1001,
		1033401
	},
	{
		1001,
		1034501
	},
	{
		1001,
		1100102
	},
	{
		1001,
		1100103
	},
	{
		1001,
		1400401
	},
	{
		1001,
		1500601
	},
	{
		1001,
		1020201
	},
	{
		1001,
		1020301
	},
	{
		1001,
		1020401
	},
	{
		1001,
		1020601
	},
	{
		1001,
		1000401
	},
	{
		1001,
		1000501
	},
	{
		1001,
		1000601
	}
}
local t_first_annual_welfare_skin = {
	[1001] = {
		[1600501] = dataList[1],
		[1600601] = dataList[2],
		[1033801] = dataList[3],
		[1033901] = dataList[4],
		[1034101] = dataList[5],
		[1034201] = dataList[6],
		[1034301] = dataList[7],
		[1002701] = dataList[8],
		[1032401] = dataList[9],
		[1009701] = dataList[10],
		[1010101] = dataList[11],
		[1013001] = dataList[12],
		[1014201] = dataList[13],
		[1014301] = dataList[14],
		[1014501] = dataList[15],
		[1014502] = dataList[16],
		[1014503] = dataList[17],
		[1014601] = dataList[18],
		[1014602] = dataList[19],
		[1014701] = dataList[20],
		[1014702] = dataList[21],
		[1016701] = dataList[22],
		[1030901] = dataList[23],
		[1031301] = dataList[24],
		[1032001] = dataList[25],
		[1032201] = dataList[26],
		[1032203] = dataList[27],
		[1032301] = dataList[28],
		[1032701] = dataList[29],
		[1032801] = dataList[30],
		[1033401] = dataList[31],
		[1034501] = dataList[32],
		[1100102] = dataList[33],
		[1100103] = dataList[34],
		[1400401] = dataList[35],
		[1500601] = dataList[36],
		[1020201] = dataList[37],
		[1020301] = dataList[38],
		[1020401] = dataList[39],
		[1020601] = dataList[40],
		[1000401] = dataList[41],
		[1000501] = dataList[42],
		[1000601] = dataList[43]
	}
}

t_first_annual_welfare_skin.dataList = dataList

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

return t_first_annual_welfare_skin
