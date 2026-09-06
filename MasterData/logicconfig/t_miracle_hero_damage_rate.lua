-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_hero_damage_rate.lua

module("logicconfig.config.t_miracle_hero_damage_rate", package.seeall)

local title = {
	damageRate = 2,
	elementNum = 1
}
local dataList = {
	{
		1,
		1
	},
	{
		2,
		1.5
	},
	{
		3,
		2
	},
	{
		4,
		1
	},
	{
		5,
		1.16666666666667
	},
	{
		6,
		1.41666666666667
	},
	{
		7,
		1.66666666666667
	},
	{
		8,
		1.91666666666667
	},
	{
		9,
		2.16666666666667
	},
	{
		10,
		2.41666666666667
	},
	{
		11,
		2.66666666666667
	},
	{
		12,
		2.91666666666667
	},
	{
		13,
		3.16666666666667
	},
	{
		14,
		3.41666666666667
	},
	{
		15,
		3.66666666666667
	},
	{
		16,
		3.91666666666667
	},
	{
		17,
		4.16666666666667
	},
	{
		18,
		4.41666666666667
	},
	{
		19,
		4.66666666666667
	},
	{
		20,
		4.91666666666667
	}
}
local t_miracle_hero_damage_rate = {
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
	dataList[20]
}

t_miracle_hero_damage_rate.dataList = dataList

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

return t_miracle_hero_damage_rate
