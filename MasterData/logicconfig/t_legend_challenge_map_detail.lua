-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_legend_challenge_map_detail.lua

module("logicconfig.config.t_legend_challenge_map_detail", package.seeall)

local title = {
	challengeId = 2,
	areaId = 4,
	mapId = 1,
	jumpTo = 7,
	raceId = 5,
	unlockId = 6,
	sort = 3
}
local dataList = {
	{
		2,
		1,
		1,
		3,
		14028,
		1116,
		"func#1116"
	},
	{
		2,
		2,
		2,
		3,
		17023,
		1116,
		"func#1116"
	},
	{
		2,
		3,
		3,
		3,
		10343,
		43,
		"func#43#74"
	},
	{
		2,
		4,
		4,
		3,
		10339,
		236,
		"func#236"
	},
	{
		2,
		5,
		5,
		1,
		10338,
		221,
		"func#221"
	},
	{
		2,
		6,
		6,
		1,
		10342,
		43,
		"func#43#74"
	},
	{
		2,
		7,
		7,
		1,
		10341,
		5062,
		"func#43#74"
	},
	{
		2,
		8,
		8,
		1,
		14015,
		5063,
		"func#5063"
	},
	{
		2,
		9,
		9,
		1,
		15016,
		5065,
		"func#5065"
	},
	{
		2,
		10,
		10,
		2,
		11009,
		904,
		"func#904"
	},
	{
		2,
		11,
		11,
		2,
		12017,
		5078,
		"func#5078"
	},
	{
		2,
		12,
		12,
		2,
		13007,
		5062,
		"func#5062"
	},
	{
		2,
		13,
		13,
		2,
		11010,
		5064,
		"func#5064"
	},
	{
		3,
		1,
		1,
		3,
		15025,
		5122,
		"func#5122"
	},
	{
		3,
		2,
		2,
		3,
		12022,
		5123,
		"func#5123"
	},
	{
		3,
		3,
		3,
		3,
		13019,
		5117,
		"func#5117"
	},
	{
		3,
		4,
		4,
		3,
		14025,
		5121,
		"func#5121"
	},
	{
		3,
		5,
		5,
		1,
		11024,
		5118,
		"func#5118"
	},
	{
		3,
		6,
		6,
		1,
		16025,
		5120,
		"func#5120"
	},
	{
		3,
		7,
		7,
		1,
		14018,
		5081,
		"func#5081"
	},
	{
		3,
		8,
		8,
		1,
		15018,
		5086,
		"func#5086"
	},
	{
		3,
		9,
		9,
		1,
		12018,
		5105,
		"func#5105"
	},
	{
		3,
		10,
		10,
		2,
		13009,
		933,
		"func#933"
	},
	{
		3,
		11,
		11,
		2,
		11021,
		5109,
		"func#5109"
	},
	{
		3,
		12,
		12,
		2,
		16009,
		5148,
		"func#5148"
	}
}
local t_legend_challenge_map_detail = {
	[2] = {
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
		dataList[13]
	},
	[3] = {
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
		dataList[25]
	}
}

t_legend_challenge_map_detail.dataList = dataList

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

return t_legend_challenge_map_detail
