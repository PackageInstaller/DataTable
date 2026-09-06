-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_school_buff.lua

module("logicconfig.config.t_magic_school_buff", package.seeall)

local title = {
	activityId = 1,
	name = 5,
	buffId = 3,
	iconUrl = 7,
	campId = 2,
	unlockLv = 4,
	desc = 6
}
local dataList = {
	{
		514001,
		1,
		1,
		0,
		"获得气势",
		"进入战斗时获得50气势",
		"expevents/icon_expedition_xueliang"
	},
	{
		514001,
		1,
		2,
		1,
		"暴击提升",
		"暴击率+20%",
		"expevents/icon_expedition_wugong"
	},
	{
		514001,
		1,
		3,
		2,
		"攻击减疗",
		"攻击时，降低目标50%受疗效果",
		"expevents/icon_expedition_wufangqishi"
	},
	{
		514001,
		1,
		4,
		3,
		"爆伤提升",
		"暴击伤害+50%",
		"expevents/icon_expedition_shoujibingdong"
	},
	{
		514001,
		1,
		5,
		4,
		"受伤加深",
		"攻击时，使目标获得30%受伤加深",
		"expevents/icon_expedition_shenqi_huo"
	},
	{
		514001,
		1,
		6,
		5,
		"吸收气势",
		"攻击时，吸收目标30气势",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		514001,
		1,
		7,
		6,
		"攻击提升",
		"攻击力+80%",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		514001,
		2,
		1,
		0,
		"获得护盾",
		"进入战斗时获得最大生命值上限*15%的生命护盾",
		"expevents/icon_expedition_xueliang"
	},
	{
		514001,
		2,
		2,
		1,
		"受击护盾",
		"受击时，获得最大生命值上限*8%的生命护盾",
		"expevents/icon_expedition_wugong"
	},
	{
		514001,
		2,
		3,
		2,
		"治疗加盾",
		"使用治疗技能时，为受疗单位附加治疗量10%的护盾",
		"expevents/icon_expedition_wufangqishi"
	},
	{
		514001,
		2,
		4,
		3,
		"受击加盾",
		"受击时，获得最大生命值上限*12%的生命护盾",
		"expevents/icon_expedition_shoujibingdong"
	},
	{
		514001,
		2,
		5,
		4,
		"治疗加盾",
		"使用治疗技能时，为受疗单位附加治疗量20%的护盾",
		"expevents/icon_expedition_shenqi_huo"
	},
	{
		514001,
		2,
		6,
		5,
		"受疗提升",
		"受到的治疗效果+50%",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		514001,
		2,
		7,
		6,
		"生命提升",
		"最大生命上限+100%",
		"expevents/icon_expedition_suijidebuff"
	}
}
local t_magic_school_buff = {
	[514001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7]
		},
		{
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14]
		}
	}
}

t_magic_school_buff.dataList = dataList

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

return t_magic_school_buff
