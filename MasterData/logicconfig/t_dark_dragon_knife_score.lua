-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_dragon_knife_score.lua

module("logicconfig.config.t_dark_dragon_knife_score", package.seeall)

local title = {
	id = 2,
	gameTime = 3,
	score = 4,
	scorePlan = 1
}
local dataList = {
	{
		1,
		1,
		10,
		10
	},
	{
		1,
		2,
		20,
		20
	},
	{
		1,
		3,
		30,
		30
	},
	{
		1,
		4,
		40,
		40
	},
	{
		1,
		5,
		50,
		50
	},
	{
		1,
		6,
		60,
		60
	},
	{
		1,
		7,
		70,
		70
	},
	{
		1,
		8,
		80,
		80
	},
	{
		1,
		9,
		90,
		90
	},
	{
		1,
		10,
		100,
		100
	},
	{
		1,
		11,
		110,
		110
	},
	{
		1,
		12,
		120,
		120
	},
	{
		1,
		13,
		130,
		130
	},
	{
		1,
		14,
		140,
		140
	},
	{
		1,
		15,
		150,
		150
	},
	{
		1,
		16,
		160,
		160
	},
	{
		1,
		17,
		170,
		170
	},
	{
		1,
		18,
		180,
		180
	},
	{
		1,
		19,
		190,
		190
	},
	{
		1,
		20,
		200,
		200
	},
	{
		1,
		21,
		250,
		250
	},
	{
		1,
		22,
		300,
		300
	},
	{
		1,
		23,
		350,
		350
	},
	{
		1,
		24,
		400,
		400
	}
}
local t_dark_dragon_knife_score = {
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
		dataList[24]
	}
}

t_dark_dragon_knife_score.dataList = dataList

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

return t_dark_dragon_knife_score
