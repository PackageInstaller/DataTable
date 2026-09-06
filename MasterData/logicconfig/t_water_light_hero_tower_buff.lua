-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_water_light_hero_tower_buff.lua

module("logicconfig.config.t_water_light_hero_tower_buff", package.seeall)

local title = {
	challengeId = 1,
	des = 3,
	level = 2
}
local dataList = {
	{
		28,
		1,
		"己方精灵全属性+10%"
	},
	{
		28,
		2,
		"己方精灵全属性+20%"
	},
	{
		28,
		3,
		"己方精灵全属性+30%"
	},
	{
		28,
		4,
		"己方精灵全属性+40%"
	},
	{
		28,
		5,
		"己方精灵全属性+50%"
	},
	{
		28,
		6,
		"己方精灵全属性+60%"
	},
	{
		28,
		7,
		"己方精灵全属性+70%"
	},
	{
		28,
		8,
		"己方精灵全属性+80%"
	},
	{
		28,
		9,
		"己方精灵全属性+90%"
	},
	{
		28,
		10,
		"己方精灵全属性+100%"
	},
	{
		115,
		1,
		"己方精灵全属性+10%"
	},
	{
		115,
		2,
		"己方精灵全属性+20%"
	},
	{
		115,
		3,
		"己方精灵全属性+30%"
	},
	{
		115,
		4,
		"己方精灵全属性+40%"
	},
	{
		115,
		5,
		"己方精灵全属性+50%"
	},
	{
		115,
		6,
		"己方精灵全属性+60%"
	},
	{
		115,
		7,
		"己方精灵全属性+70%"
	},
	{
		115,
		8,
		"己方精灵全属性+80%"
	},
	{
		115,
		9,
		"己方精灵全属性+90%"
	},
	{
		115,
		10,
		"己方精灵全属性+100%"
	},
	{
		138,
		1,
		"己方精灵全属性+10%"
	},
	{
		138,
		2,
		"己方精灵全属性+20%"
	},
	{
		138,
		3,
		"己方精灵全属性+30%"
	},
	{
		138,
		4,
		"己方精灵全属性+40%"
	},
	{
		138,
		5,
		"己方精灵全属性+50%"
	},
	{
		138,
		6,
		"己方精灵全属性+60%"
	},
	{
		138,
		7,
		"己方精灵全属性+70%"
	},
	{
		138,
		8,
		"己方精灵全属性+80%"
	},
	{
		138,
		9,
		"己方精灵全属性+90%"
	},
	{
		138,
		10,
		"己方精灵全属性+100%"
	}
}
local t_water_light_hero_tower_buff = {
	[28] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[115] = {
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
	},
	[138] = {
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
}

t_water_light_hero_tower_buff.dataList = dataList

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

return t_water_light_hero_tower_buff
