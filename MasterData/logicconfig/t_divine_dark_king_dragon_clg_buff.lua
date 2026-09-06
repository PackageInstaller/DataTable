-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dark_king_dragon_clg_buff.lua

module("logicconfig.config.t_divine_dark_king_dragon_clg_buff", package.seeall)

local title = {
	num = 2,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		526001,
		1,
		"敌阵造成的伤害，受到的伤害+30%，起始气势+30"
	},
	{
		526001,
		2,
		"敌阵造成的伤害，受到的伤害+60%，起始气势+60"
	},
	{
		526001,
		3,
		"敌阵造成的伤害，受到的伤害+90%，起始气势+90"
	},
	{
		526001,
		4,
		"敌阵造成的伤害，受到的伤害+120%，起始气势+120"
	},
	{
		526001,
		5,
		"敌阵造成的伤害，受到的伤害+150%，起始气势+150"
	},
	{
		526001,
		6,
		"敌阵造成的伤害，受到的伤害+180%，起始气势+180"
	},
	{
		526001,
		7,
		"敌阵造成的伤害，受到的伤害+210%，起始气势+210"
	},
	{
		526001,
		8,
		"敌阵造成的伤害，受到的伤害+240%，起始气势+240"
	},
	{
		526001,
		9,
		"敌阵造成的伤害，受到的伤害+270%，起始气势+270"
	},
	{
		526001,
		10,
		"敌阵造成的伤害，受到的伤害+300%，起始气势+300"
	}
}
local t_divine_dark_king_dragon_clg_buff = {
	[526001] = {
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
	}
}

t_divine_dark_king_dragon_clg_buff.dataList = dataList

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

return t_divine_dark_king_dragon_clg_buff
