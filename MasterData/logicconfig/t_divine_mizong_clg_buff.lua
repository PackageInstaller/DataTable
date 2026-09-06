-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mizong_clg_buff.lua

module("logicconfig.config.t_divine_mizong_clg_buff", package.seeall)

local title = {
	iconUrl = 6,
	buffType = 2,
	buffDesc = 5,
	upgradeCostItem = 4,
	activityId = 1,
	buffLevel = 3
}
local dataList = {
	{
		477001,
		1,
		0,
		0,
		"我方精灵全属性+0%",
		"ui/icon/expevents/icon_expedition_xueliang"
	},
	{
		477001,
		1,
		1,
		10,
		"我方精灵全属性+10%",
		"ui/icon/expevents/icon_expedition_xueliang"
	},
	{
		477001,
		1,
		2,
		10,
		"我方精灵全属性+30%",
		"ui/icon/expevents/icon_expedition_xueliang"
	},
	{
		477001,
		1,
		3,
		20,
		"我方精灵全属性+50%",
		"ui/icon/expevents/icon_expedition_xueliang"
	},
	{
		477001,
		1,
		4,
		20,
		"我方精灵全属性+80%",
		"ui/icon/expevents/icon_expedition_xueliang"
	},
	{
		477001,
		1,
		5,
		30,
		"我方精灵全属性+100%",
		"ui/icon/expevents/icon_expedition_xueliang"
	},
	{
		477001,
		1,
		6,
		30,
		"我方精灵全属性+150%",
		"ui/icon/expevents/icon_expedition_xueliang"
	},
	{
		477001,
		1,
		7,
		30,
		"我方精灵全属性+300%",
		"ui/icon/expevents/icon_expedition_xueliang"
	},
	{
		477001,
		1,
		8,
		30,
		"我方精灵全属性+500%",
		"ui/icon/expevents/icon_expedition_xueliang"
	},
	{
		477001,
		1,
		9,
		30,
		"我方精灵全属性+700%",
		"ui/icon/expevents/icon_expedition_xueliang"
	},
	{
		477001,
		1,
		10,
		30,
		"我方精灵全属性+1000%",
		"ui/icon/expevents/icon_expedition_xueliang"
	},
	{
		477001,
		2,
		0,
		0,
		"我方精灵初始气势+0",
		"ui/icon/expevents/icon_expedition_wugong"
	},
	{
		477001,
		2,
		1,
		1,
		"我方精灵初始气势+5",
		"ui/icon/expevents/icon_expedition_wugong"
	},
	{
		477001,
		2,
		2,
		1,
		"我方精灵初始气势+10",
		"ui/icon/expevents/icon_expedition_wugong"
	},
	{
		477001,
		2,
		3,
		2,
		"我方精灵初始气势+15",
		"ui/icon/expevents/icon_expedition_wugong"
	},
	{
		477001,
		2,
		4,
		2,
		"我方精灵初始气势+20",
		"ui/icon/expevents/icon_expedition_wugong"
	},
	{
		477001,
		2,
		5,
		3,
		"我方精灵初始气势+25",
		"ui/icon/expevents/icon_expedition_wugong"
	},
	{
		477001,
		2,
		6,
		3,
		"我方精灵初始气势+30",
		"ui/icon/expevents/icon_expedition_wugong"
	},
	{
		477001,
		2,
		7,
		4,
		"我方精灵初始气势+35",
		"ui/icon/expevents/icon_expedition_wugong"
	},
	{
		477001,
		2,
		8,
		4,
		"我方精灵初始气势+40",
		"ui/icon/expevents/icon_expedition_wugong"
	},
	{
		477001,
		3,
		0,
		0,
		"我方精灵暴击率+0%",
		"ui/icon/expevents/icon_expedition_wufangqishi"
	},
	{
		477001,
		3,
		1,
		1,
		"我方精灵暴击率+5%",
		"ui/icon/expevents/icon_expedition_wufangqishi"
	},
	{
		477001,
		3,
		2,
		1,
		"我方精灵暴击率+8%",
		"ui/icon/expevents/icon_expedition_wufangqishi"
	},
	{
		477001,
		3,
		3,
		2,
		"我方精灵暴击率+10%",
		"ui/icon/expevents/icon_expedition_wufangqishi"
	},
	{
		477001,
		3,
		4,
		2,
		"我方精灵暴击率+12%",
		"ui/icon/expevents/icon_expedition_wufangqishi"
	},
	{
		477001,
		3,
		5,
		3,
		"我方精灵暴击率+15%",
		"ui/icon/expevents/icon_expedition_wufangqishi"
	},
	{
		477001,
		3,
		6,
		3,
		"我方精灵暴击率+20%",
		"ui/icon/expevents/icon_expedition_wufangqishi"
	},
	{
		477001,
		3,
		7,
		4,
		"我方精灵暴击率+25%",
		"ui/icon/expevents/icon_expedition_wufangqishi"
	},
	{
		477001,
		3,
		8,
		4,
		"我方精灵暴击率+30%",
		"ui/icon/expevents/icon_expedition_wufangqishi"
	}
}
local t_divine_mizong_clg_buff = {
	[477001] = {
		{
			[0] = dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11]
		},
		{
			[0] = dataList[12],
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16],
			dataList[17],
			dataList[18],
			dataList[19],
			dataList[20]
		},
		{
			[0] = dataList[21],
			dataList[22],
			dataList[23],
			dataList[24],
			dataList[25],
			dataList[26],
			dataList[27],
			dataList[28],
			dataList[29]
		}
	}
}

t_divine_mizong_clg_buff.dataList = dataList

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

return t_divine_mizong_clg_buff
