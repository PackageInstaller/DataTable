-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_ji_buff.lua

module("logicconfig.config.t_summon_master_ji_buff", package.seeall)

local title = {
	name = 3,
	buffs = 2,
	buffId = 1,
	iconPath = 5,
	desc = 4
}
local dataList = {
	{
		1,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20054826:99"
				}
			}
		},
		"",
		"敌阵攻击前减少目标5%全属性（1回合,不可叠加）",
		""
	},
	{
		2,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20054827:99"
				}
			}
		},
		"",
		"敌阵攻击前减少目标10%全属性（1回合,不可叠加）",
		""
	},
	{
		3,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20054828:99"
				}
			}
		},
		"",
		"敌阵攻击前减少目标15%全属性（1回合,不可叠加）",
		""
	},
	{
		4,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20054828:99#20054829:99"
				}
			}
		},
		"",
		"敌阵攻击前减少目标15%全属性（1回合,不可叠加）并增加自身5%全属性（2回合,不可叠加）",
		""
	},
	{
		5,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20054828:99#20054830:99"
				}
			}
		},
		"",
		"敌阵攻击前减少目标15%全属性（1回合,不可叠加）并增加自身10%全属性（2回合,不可叠加）",
		""
	},
	{
		6,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20054828:99#20054831:99"
				}
			}
		},
		"",
		"敌阵攻击前减少目标15%全属性（1回合,不可叠加）并增加自身15%全属性（2回合,不可叠加）",
		""
	},
	{
		7,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20054834:99"
				}
			}
		},
		"",
		"敌阵精灵每次攻击后清除自身禁疗效果",
		""
	},
	{
		8,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20054835:99"
				}
			}
		},
		"",
		"敌阵精灵每次攻击前清除自身负面效果",
		""
	},
	{
		9,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20054836:99"
				}
			}
		},
		"",
		"敌阵精灵免疫负面效果",
		""
	},
	{
		10,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20054840:99"
				}
			}
		},
		"",
		"敌阵精灵受击时额外获得10点气势",
		""
	},
	{
		11,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20054841:99"
				}
			}
		},
		"",
		"敌阵精灵受击时额外获得30点气势",
		""
	},
	{
		12,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20054842:99"
				}
			}
		},
		"",
		"敌阵精灵受击时额外获得50点气势",
		""
	},
	{
		13,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20054847:99"
				}
			}
		},
		"",
		"敌阵首位死亡精灵在本个大回合结束时复活并恢复50%生命值",
		""
	},
	{
		14,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20054848:99"
				}
			}
		},
		"",
		"敌阵在每个大回合内死亡的首只精灵在本个大回合结束时复活并恢复50%生命值",
		""
	},
	{
		15,
		{
			{
				clazz = "Common",
				target = "enemy",
				params = {
					buffs = "20054849:99"
				}
			}
		},
		"",
		"敌阵在每个大回合内死亡的前两只精灵在本个大回合结束时复活并恢复50%生命值",
		""
	},
	{
		16,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20054805:99"
				}
			}
		},
		"伤害提升Ⅰ",
		"伤害+10%",
		"ui/icon/expevents/icon_expedition_shanghaitisheng.png"
	},
	{
		17,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20054810:99#20054815:99"
				}
			}
		},
		"属性提升Ⅰ",
		"全属性+10%",
		"ui/icon/expevents/icon_expedition_ydnzhufu.png"
	},
	{
		18,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20054806:99"
				}
			}
		},
		"伤害提升Ⅱ",
		"伤害+50%",
		"ui/icon/expevents/icon_expedition_shanghaitisheng.png"
	},
	{
		19,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20054811:99#20054816:99"
				}
			}
		},
		"属性提升Ⅱ",
		"全属性+50%",
		"ui/icon/expevents/icon_expedition_ydnzhufu.png"
	},
	{
		20,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20054807:99"
				}
			}
		},
		"伤害提升Ⅲ",
		"伤害+100%",
		"ui/icon/expevents/icon_expedition_shanghaitisheng.png"
	},
	{
		21,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20054812:99#20054817:99"
				}
			}
		},
		"属性提升Ⅲ",
		"全属性+100%",
		"ui/icon/expevents/icon_expedition_ydnzhufu.png"
	},
	{
		22,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20054808:99"
				}
			}
		},
		"伤害提升Ⅳ",
		"伤害+300%",
		"ui/icon/expevents/icon_expedition_shanghaitisheng.png"
	},
	{
		23,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20054813:99#20054818:99"
				}
			}
		},
		"属性提升Ⅳ",
		"全属性+300%",
		"ui/icon/expevents/icon_expedition_ydnzhufu.png"
	},
	{
		24,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20054809:99"
				}
			}
		},
		"伤害提升Ⅴ",
		"伤害+2000%",
		"ui/icon/expevents/icon_expedition_shanghaitisheng.png"
	},
	{
		25,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20054814:99#20054819:99"
				}
			}
		},
		"属性提升Ⅴ",
		"全属性+2000%",
		"ui/icon/expevents/icon_expedition_ydnzhufu.png"
	}
}
local t_summon_master_ji_buff = {
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
	dataList[20],
	dataList[21],
	dataList[22],
	dataList[23],
	dataList[24],
	dataList[25]
}

t_summon_master_ji_buff.dataList = dataList

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

return t_summon_master_ji_buff
