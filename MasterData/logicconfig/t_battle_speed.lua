-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_battle_speed.lua

module("logicconfig.config.t_battle_speed", package.seeall)

local title = {
	id = 1,
	speed2 = 3,
	speed3 = 4,
	speed1 = 2
}
local dataList = {
	{
		1,
		1,
		1,
		1
	},
	{
		2,
		1,
		1,
		1
	},
	{
		3,
		1,
		1,
		1
	},
	{
		4,
		1,
		1,
		1
	},
	{
		5,
		1.25,
		1.25,
		1.25
	},
	{
		6,
		1.5,
		1.5,
		1.5
	},
	{
		7,
		1.5,
		1.5,
		1.5
	},
	{
		8,
		1.5,
		1.5,
		1.5
	},
	{
		9,
		1.5,
		1.5,
		1.5
	},
	{
		10,
		1.5,
		1.5,
		1.5
	},
	{
		11,
		1.5,
		1.5,
		1.5
	},
	{
		12,
		1.5,
		1.5,
		1.5
	},
	{
		13,
		1.5,
		1.5,
		1.5
	},
	{
		14,
		1.5,
		1.5,
		1.5
	},
	{
		15,
		1.5,
		1.5,
		1.5
	},
	{
		16,
		1.5,
		1.5,
		1.5
	},
	{
		17,
		1.5,
		1.5,
		1.5
	},
	{
		18,
		1.5,
		1.5,
		1.5
	},
	{
		19,
		1.5,
		1.5,
		1.5
	},
	{
		20,
		1.5,
		1.5,
		1.5
	},
	{
		21,
		1.5,
		1.5,
		1.5
	},
	{
		22,
		1.5,
		1.5,
		1.5
	},
	{
		23,
		1.5,
		1.5,
		1.5
	},
	{
		24,
		1.5,
		1.5,
		1.5
	},
	{
		25,
		1.5,
		1.5,
		1.5
	},
	{
		26,
		1.5,
		1.5,
		1.5
	},
	{
		27,
		1.5,
		1.5,
		1.5
	},
	{
		28,
		1.5,
		1.5,
		1.5
	},
	{
		29,
		1.5,
		1.5,
		1.5
	},
	{
		30,
		1.5,
		1.5,
		1.5
	}
}
local t_battle_speed = {
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

t_battle_speed.dataList = dataList

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

return t_battle_speed
