-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_invincible_extreme_buff.lua

module("logicconfig.config.t_divine_invincible_extreme_buff", package.seeall)

local title = {
	id = 2,
	finishNum = 3,
	desc = 4,
	extremePlanId = 1
}
local dataList = {
	{
		1,
		1,
		0,
		"敌阵免伤+5%，且在击杀精灵后吸取其50%的属性"
	},
	{
		1,
		2,
		1,
		"敌阵免伤+5%，且在击杀精灵后吸取其50%的属性"
	},
	{
		1,
		3,
		2,
		"敌阵免伤+10%，且在击杀精灵后吸取其50%的属性"
	},
	{
		1,
		4,
		3,
		"敌阵免伤+10%，且在击杀精灵后吸取其50%的属性"
	},
	{
		1,
		5,
		4,
		"敌阵免伤+15%，且在击杀精灵后吸取其50%的属性"
	},
	{
		1,
		6,
		5,
		"敌阵免伤+15%，且在击杀精灵后吸取其50%的属性"
	},
	{
		1,
		7,
		6,
		"敌阵免伤+20%，且在击杀精灵后吸取其50%的属性"
	},
	{
		1,
		8,
		7,
		"敌阵免伤+25%，且在击杀精灵后吸取其50%的属性"
	},
	{
		1,
		9,
		8,
		"敌阵免伤+30%，且在击杀精灵后吸取其50%的属性"
	},
	{
		2,
		1,
		0,
		"敌阵免伤+5%，且在击杀精灵后吸取其50%的属性"
	},
	{
		2,
		2,
		1,
		"敌阵免伤+5%，且在击杀精灵后吸取其50%的属性"
	},
	{
		2,
		3,
		2,
		"敌阵免伤+10%，且在击杀精灵后吸取其50%的属性"
	},
	{
		2,
		4,
		3,
		"敌阵免伤+10%，且在击杀精灵后吸取其50%的属性"
	},
	{
		2,
		5,
		4,
		"敌阵免伤+15%，且在击杀精灵后吸取其50%的属性"
	},
	{
		2,
		6,
		5,
		"敌阵免伤+15%，且在击杀精灵后吸取其50%的属性"
	},
	{
		2,
		7,
		6,
		"敌阵免伤+20%，且在击杀精灵后吸取其50%的属性"
	},
	{
		2,
		8,
		7,
		"敌阵免伤+25%，且在击杀精灵后吸取其50%的属性"
	},
	{
		2,
		9,
		8,
		"敌阵免伤+30%，且在击杀精灵后吸取其50%的属性"
	}
}
local t_divine_invincible_extreme_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_divine_invincible_extreme_buff.dataList = dataList

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

return t_divine_invincible_extreme_buff
