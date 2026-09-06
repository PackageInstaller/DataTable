-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_light_buff.lua

module("logicconfig.config.t_holy_light_buff", package.seeall)

local title = {
	des = 6,
	name = 4,
	buffId = 1,
	index = 2,
	iconPath = 5,
	level = 3
}
local dataList = {
	{
		1,
		1,
		1,
		"圣剑羽粹-攻",
		"icon/expevents/icon_expedition_wushifangyu",
		"我方全阵攻击增加<color=#c54949>10%</color>"
	},
	{
		1,
		2,
		2,
		"圣剑羽粹-攻",
		"icon/expevents/icon_expedition_wushifangyu",
		"我方全阵攻击增加<color=#c54949>20%</color>"
	},
	{
		1,
		3,
		3,
		"圣剑羽粹-攻",
		"icon/expevents/icon_expedition_wushifangyu",
		"我方全阵攻击增加<color=#c54949>30%</color>"
	},
	{
		1,
		4,
		4,
		"圣剑羽粹-攻",
		"icon/expevents/icon_expedition_wushifangyu",
		"我方全阵攻击增加<color=#c54949>40%</color>"
	},
	{
		1,
		5,
		5,
		"圣剑羽粹-攻",
		"icon/expevents/icon_expedition_wushifangyu",
		"我方全阵攻击增加<color=#c54949>50%</color>"
	},
	{
		2,
		1,
		1,
		"圣盾羽粹-防",
		"icon/expevents/icon_expedition_guijia01",
		"我方全阵防御增加<color=#c54949>15%</color>"
	},
	{
		2,
		2,
		2,
		"圣盾羽粹-防",
		"icon/expevents/icon_expedition_guijia01",
		"我方全阵防御增加<color=#c54949>30%</color>"
	},
	{
		2,
		3,
		3,
		"圣盾羽粹-防",
		"icon/expevents/icon_expedition_guijia01",
		"我方全阵防御增加<color=#c54949>45%</color>"
	},
	{
		2,
		4,
		4,
		"圣盾羽粹-防",
		"icon/expevents/icon_expedition_guijia01",
		"我方全阵防御增加<color=#c54949>60%</color>"
	},
	{
		2,
		5,
		5,
		"圣盾羽粹-防",
		"icon/expevents/icon_expedition_guijia01",
		"我方全阵防御增加<color=#c54949>75%</color>"
	},
	{
		3,
		1,
		1,
		"圣盾羽粹-血",
		"icon/expevents/icon_expedition_numu",
		"我方全阵生命增加<color=#c54949>10%</color>"
	},
	{
		3,
		2,
		2,
		"圣盾羽粹-血",
		"icon/expevents/icon_expedition_numu",
		"我方全阵生命增加<color=#c54949>20%</color>"
	},
	{
		3,
		3,
		3,
		"圣盾羽粹-血",
		"icon/expevents/icon_expedition_numu",
		"我方全阵生命增加<color=#c54949>30%</color>"
	},
	{
		3,
		4,
		4,
		"圣盾羽粹-血",
		"icon/expevents/icon_expedition_numu",
		"我方全阵生命增加<color=#c54949>40%</color>"
	},
	{
		3,
		5,
		5,
		"圣盾羽粹-血",
		"icon/expevents/icon_expedition_numu",
		"我方全阵生命增加<color=#c54949>50%</color>"
	},
	{
		4,
		1,
		1,
		"圣剑羽粹-怒",
		"icon/expevents/icon_expedition_baojilv1",
		"我方全阵暴击率增加<color=#c54949>10%</color>"
	},
	{
		4,
		2,
		2,
		"圣剑羽粹-怒",
		"icon/expevents/icon_expedition_baojilv1",
		"我方全阵暴击率增加<color=#c54949>20%</color>"
	},
	{
		4,
		3,
		3,
		"圣剑羽粹-怒",
		"icon/expevents/icon_expedition_baojilv1",
		"我方全阵暴击率增加<color=#c54949>30%</color>"
	},
	{
		4,
		4,
		4,
		"圣剑羽粹-怒",
		"icon/expevents/icon_expedition_baojilv1",
		"我方全阵暴击率增加<color=#c54949>40%</color>"
	},
	{
		4,
		5,
		5,
		"圣剑羽粹-怒",
		"icon/expevents/icon_expedition_baojilv1",
		"我方全阵暴击率增加<color=#c54949>50%</color>"
	}
}
local t_holy_light_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	},
	{
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_holy_light_buff.dataList = dataList

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

return t_holy_light_buff
