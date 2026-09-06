-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_of_radiant_gold_buff.lua

module("logicconfig.config.t_king_of_radiant_gold_buff", package.seeall)

local title = {
	cost = 5,
	name = 4,
	buffId = 2,
	buffDesc = 6,
	icon = 7,
	activityId = 1,
	level = 3
}
local dataList = {
	{
		462001,
		1,
		1,
		"全属性强化",
		1000,
		"我方精灵全属性+10%",
		"icon_expedition_xueliang"
	},
	{
		462001,
		1,
		2,
		"全属性强化",
		1000,
		"我方精灵全属性+30%",
		"icon_expedition_xueliang"
	},
	{
		462001,
		1,
		3,
		"全属性强化",
		1500,
		"我方精灵全属性+50%",
		"icon_expedition_xueliang"
	},
	{
		462001,
		1,
		4,
		"全属性强化",
		1500,
		"我方精灵全属性+80%",
		"icon_expedition_xueliang"
	},
	{
		462001,
		1,
		5,
		"全属性强化",
		1500,
		"我方精灵全属性+100%",
		"icon_expedition_xueliang"
	},
	{
		462001,
		1,
		6,
		"全属性强化",
		1500,
		"我方精灵全属性+300%",
		"icon_expedition_xueliang"
	},
	{
		462001,
		1,
		7,
		"全属性强化",
		2000,
		"我方精灵全属性+600%",
		"icon_expedition_xueliang"
	},
	{
		462001,
		1,
		8,
		"全属性强化",
		2000,
		"我方精灵全属性+900%",
		"icon_expedition_xueliang"
	},
	{
		462001,
		2,
		1,
		"气势提升",
		250,
		"我方精灵初始气势+5",
		"icon_expedition_wugong"
	},
	{
		462001,
		2,
		2,
		"气势提升",
		250,
		"我方精灵初始气势+10",
		"icon_expedition_wugong"
	},
	{
		462001,
		2,
		3,
		"气势提升",
		500,
		"我方精灵初始气势+15",
		"icon_expedition_wugong"
	},
	{
		462001,
		2,
		4,
		"气势提升",
		500,
		"我方精灵初始气势+20",
		"icon_expedition_wugong"
	},
	{
		462001,
		2,
		5,
		"气势提升",
		500,
		"我方精灵初始气势+25",
		"icon_expedition_wugong"
	},
	{
		462001,
		2,
		6,
		"气势提升",
		500,
		"我方精灵初始气势+30",
		"icon_expedition_wugong"
	},
	{
		462001,
		2,
		7,
		"气势提升",
		750,
		"我方精灵初始气势+35",
		"icon_expedition_wugong"
	},
	{
		462001,
		2,
		8,
		"气势提升",
		750,
		"我方精灵初始气势+40",
		"icon_expedition_wugong"
	},
	{
		462001,
		3,
		1,
		"暴击提升",
		250,
		"我方精灵暴击率+5%",
		"icon_expedition_wufangqishi"
	},
	{
		462001,
		3,
		2,
		"暴击提升",
		250,
		"我方精灵暴击率+8%",
		"icon_expedition_wufangqishi"
	},
	{
		462001,
		3,
		3,
		"暴击提升",
		500,
		"我方精灵暴击率+10%",
		"icon_expedition_wufangqishi"
	},
	{
		462001,
		3,
		4,
		"暴击提升",
		500,
		"我方精灵暴击率+12%",
		"icon_expedition_wufangqishi"
	},
	{
		462001,
		3,
		5,
		"暴击提升",
		500,
		"我方精灵暴击率+15%",
		"icon_expedition_wufangqishi"
	},
	{
		462001,
		3,
		6,
		"暴击提升",
		500,
		"我方精灵暴击率+20%",
		"icon_expedition_wufangqishi"
	},
	{
		462001,
		3,
		7,
		"暴击提升",
		750,
		"我方精灵暴击率+25%",
		"icon_expedition_wufangqishi"
	},
	{
		462001,
		3,
		8,
		"暴击提升",
		750,
		"我方精灵暴击率+30%",
		"icon_expedition_wufangqishi"
	}
}
local t_king_of_radiant_gold_buff = {
	[462001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		},
		{
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16]
		},
		{
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
}

t_king_of_radiant_gold_buff.dataList = dataList

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

return t_king_of_radiant_gold_buff
