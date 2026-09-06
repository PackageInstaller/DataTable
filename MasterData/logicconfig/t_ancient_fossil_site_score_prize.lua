-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ancient_fossil_site_score_prize.lua

module("logicconfig.config.t_ancient_fossil_site_score_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	planId = 1,
	needScore = 3
}
local dataList = {
	{
		1,
		1,
		600,
		"4:14:120"
	},
	{
		1,
		2,
		800,
		"4:14:120"
	},
	{
		1,
		3,
		1200,
		"4:40008:1"
	},
	{
		1,
		4,
		1600,
		"4:14:120"
	},
	{
		1,
		5,
		2200,
		"4:40008:1"
	},
	{
		1,
		6,
		3000,
		"4:14:120"
	},
	{
		1,
		7,
		3800,
		"4:40008:1"
	},
	{
		1,
		8,
		4700,
		"4:14:120"
	},
	{
		1,
		9,
		5400,
		"4:40008:1"
	},
	{
		1,
		10,
		6400,
		"4:14:120"
	},
	{
		1,
		11,
		7600,
		"4:40008:1"
	},
	{
		1,
		12,
		9000,
		"4:40008:1"
	},
	{
		2,
		1,
		600,
		"60:1:200"
	},
	{
		2,
		2,
		1200,
		"60:1:200"
	},
	{
		2,
		3,
		1600,
		"60:1:200"
	},
	{
		2,
		4,
		2200,
		"60:1:200"
	},
	{
		2,
		5,
		3000,
		"4:90282:1"
	},
	{
		2,
		6,
		3800,
		"60:1:200"
	},
	{
		2,
		7,
		4500,
		"60:1:200"
	},
	{
		2,
		8,
		5300,
		"4:90284:1"
	}
}
local t_ancient_fossil_site_score_prize = {
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
		dataList[20]
	}
}

t_ancient_fossil_site_score_prize.dataList = dataList

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

return t_ancient_fossil_site_score_prize
