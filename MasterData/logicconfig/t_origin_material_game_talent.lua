-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_material_game_talent.lua

module("logicconfig.config.t_origin_material_game_talent", package.seeall)

local title = {
	weaponId = 5,
	name = 8,
	buffId = 6,
	iconUrl = 7,
	cost = 2,
	desc = 9,
	pos = 4,
	lockIds = 3,
	talentId = 1
}
local dataList = {
	{
		1,
		"8:46:500",
		{},
		{
			1,
			2
		},
		0,
		59,
		"expevents/icon_expedition_wugong",
		"增伤Ⅰ",
		"增加<color=#C54949>10%</color>基础攻击"
	},
	{
		2,
		"8:46:500",
		{
			1
		},
		{
			2,
			1
		},
		0,
		59,
		"expevents/icon_expedition_wushang",
		"增伤ⅠⅠ",
		"增加<color=#C54949>10%</color>基础攻击"
	},
	{
		3,
		"8:46:500",
		{
			1
		},
		{
			2,
			2
		},
		0,
		60,
		"expevents/icon_expedition_xueliangtishengshanghai",
		"速攻Ⅰ",
		"减少<color=#C54949>5%</color>攻击间隔"
	},
	{
		4,
		"8:46:500",
		{
			1
		},
		{
			2,
			3
		},
		0,
		61,
		"expevents/icon_expedition_shenqi_huo",
		"强攻Ⅰ",
		"第5次出手时伤害增加<color=#C54949>1</color>倍"
	},
	{
		5,
		"8:46:500",
		{
			2
		},
		{
			3,
			1
		},
		0,
		59,
		"expevents/icon_expedition_yadao01",
		"增伤ⅠⅠⅠ",
		"增加<color=#C54949>10%</color>基础攻击"
	},
	{
		6,
		"8:46:500",
		{
			3
		},
		{
			3,
			2
		},
		0,
		60,
		"expevents/icon_expedition_meilunkouxue",
		"速攻ⅠⅠ",
		"减少<color=#C54949>5%</color>攻击间隔"
	},
	{
		7,
		"8:46:500",
		{
			4
		},
		{
			3,
			3
		},
		0,
		61,
		"expevents/icon_expedition_chaoshahoumianyi",
		"强攻ⅠⅠ",
		"第5次出手时伤害增加<color=#C54949>1</color>倍"
	},
	{
		8,
		"8:46:500",
		{
			5,
			6,
			7
		},
		{
			4,
			2
		},
		0,
		60,
		"expevents/icon_expedition_zhuiji",
		"速攻ⅠⅠⅠ",
		"减少<color=#C54949>5%</color>攻击间隔"
	},
	{
		9,
		"8:46:500",
		{
			8
		},
		{
			5,
			2
		},
		0,
		61,
		"expevents/icon_expedition_meicigongjizengshang",
		"强攻ⅠⅠⅠ",
		"第5次出手时伤害增加<color=#C54949>1</color>倍"
	},
	{
		10,
		"8:46:500",
		{
			9
		},
		{
			6,
			1
		},
		0,
		59,
		"expevents/icon_expedition_zhenying_06",
		"增伤ⅠⅠⅠⅠ",
		"增加<color=#C54949>10%</color>基础攻击"
	},
	{
		11,
		"8:46:500",
		{
			9
		},
		{
			6,
			2
		},
		0,
		60,
		"expevents/icon_expedition_shayi",
		"速攻ⅠⅠⅠⅠ",
		"减少<color=#C54949>5%</color>攻击间隔"
	},
	{
		12,
		"8:46:500",
		{
			9
		},
		{
			6,
			3
		},
		0,
		61,
		"expevents/icon_expedition_shanghaitisheng",
		"强攻ⅠⅠⅠⅠ",
		"第5次出手时伤害增加<color=#C54949>1</color>倍"
	}
}
local t_origin_material_game_talent = {
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
	dataList[12]
}

t_origin_material_game_talent.dataList = dataList

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

return t_origin_material_game_talent
