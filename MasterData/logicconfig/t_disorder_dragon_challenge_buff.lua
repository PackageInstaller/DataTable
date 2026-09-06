-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_disorder_dragon_challenge_buff.lua

module("logicconfig.config.t_disorder_dragon_challenge_buff", package.seeall)

local title = {
	name = 2,
	buffId = 1,
	des = 3
}
local dataList = {
	{
		1,
		"变身",
		"当前血量处于1-100万，变身为无序"
	},
	{
		2,
		"变身",
		"当前血量处于100-1000万，变身为王者龙"
	},
	{
		3,
		"变身",
		"当前血量处于1000-2000万，变身为敖久"
	},
	{
		4,
		"变身",
		"当前血量处于2000-3000万，变身为超神龙"
	},
	{
		5,
		"变身",
		"当前血量处于3000-4000万，变身为解神·赤"
	},
	{
		6,
		"变身",
		"当前血量处于4000-5000万，变身为解神·亦"
	},
	{
		7,
		"变身",
		"当前血量处于5000-6000万，变身为秩序龙"
	},
	{
		8,
		"变身",
		"当前血量处于6000-7000万，变身为黄金龙"
	},
	{
		9,
		"变身",
		"当前血量处于7000-8000万，变身为无烬龙"
	},
	{
		10,
		"变身",
		"当前血量处于8000-9000万，变身为次元龙"
	},
	{
		11,
		"变身",
		"当前血量处于9000-10000万，变身为龙尊圣主"
	},
	{
		21,
		"属性加成",
		"己阵全属性+20%"
	},
	{
		22,
		"光系加成",
		"敌阵受到的光系伤害+20%"
	},
	{
		23,
		"暗系加成",
		"敌阵受到的暗系伤害+20%"
	},
	{
		24,
		"气势加成",
		"每回合结束时气势+30"
	},
	{
		25,
		"暴击加成",
		"己阵暴击率+40%"
	},
	{
		26,
		"暴伤加成",
		"敌阵受到暴击伤害增加100%"
	},
	{
		27,
		"必定闪避",
		"己阵首次受击时必定闪避"
	}
}
local t_disorder_dragon_challenge_buff = {
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
	[21] = dataList[12],
	[22] = dataList[13],
	[23] = dataList[14],
	[24] = dataList[15],
	[25] = dataList[16],
	[26] = dataList[17],
	[27] = dataList[18]
}

t_disorder_dragon_challenge_buff.dataList = dataList

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

return t_disorder_dragon_challenge_buff
