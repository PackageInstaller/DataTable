-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_richman_camplevel.lua

module("logicconfig.config.t_richman_camplevel", package.seeall)

local title = {
	exp = 3,
	campPlanId = 1,
	srcAddition = 4,
	level = 2
}
local dataList = {
	{
		1,
		1,
		100,
		100
	},
	{
		1,
		2,
		200,
		150
	},
	{
		1,
		3,
		300,
		200
	},
	{
		1,
		4,
		400,
		250
	},
	{
		1,
		5,
		500,
		300
	},
	{
		1,
		6,
		600,
		400
	},
	{
		1,
		7,
		700,
		500
	},
	{
		1,
		8,
		800,
		600
	},
	{
		1,
		9,
		900,
		700
	},
	{
		1,
		10,
		1000,
		800
	},
	{
		1,
		11,
		1100,
		900
	},
	{
		1,
		12,
		1200,
		1000
	},
	{
		2,
		1,
		100,
		100
	},
	{
		2,
		2,
		125,
		150
	},
	{
		2,
		3,
		150,
		200
	},
	{
		2,
		4,
		200,
		250
	},
	{
		2,
		5,
		250,
		300
	},
	{
		2,
		6,
		325,
		400
	},
	{
		2,
		7,
		400,
		500
	},
	{
		2,
		8,
		550,
		600
	},
	{
		2,
		9,
		700,
		700
	},
	{
		2,
		10,
		900,
		800
	},
	{
		2,
		11,
		1100,
		900
	},
	{
		2,
		12,
		1300,
		1000
	}
}
local t_richman_camplevel = {
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
		dataList[12]
	},
	{
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
		dataList[24]
	}
}

t_richman_camplevel.dataList = dataList

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

return t_richman_camplevel
