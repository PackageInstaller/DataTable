-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cute_pet_talent.lua

module("logicconfig.config.t_cute_pet_talent", package.seeall)

local title = {
	score = 4,
	petValidator = 2,
	grade = 5,
	talentType = 6,
	talentId = 1,
	desc = 3
}
local dataList = {
	{
		1011,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，暴击率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击率"
	},
	{
		1012,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，暴击率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击率"
	},
	{
		1013,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，暴击率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击率"
	},
	{
		1014,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，暴击率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击率"
	},
	{
		1021,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，防暴率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"防暴率"
	},
	{
		1022,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，防暴率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"防暴率"
	},
	{
		1023,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，防暴率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"防暴率"
	},
	{
		1024,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，防暴率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"防暴率"
	},
	{
		1031,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，命中率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"命中率"
	},
	{
		1032,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，命中率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"命中率"
	},
	{
		1033,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，命中率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"命中率"
	},
	{
		1034,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，命中率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"命中率"
	},
	{
		1041,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，闪避率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"闪避率"
	},
	{
		1042,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，闪避率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"闪避率"
	},
	{
		1043,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，闪避率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"闪避率"
	},
	{
		1044,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，闪避率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"闪避率"
	},
	{
		1051,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，格挡率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"格挡率"
	},
	{
		1052,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，格挡率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"格挡率"
	},
	{
		1053,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，格挡率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"格挡率"
	},
	{
		1054,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，格挡率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"格挡率"
	},
	{
		1061,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，破击率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"破击率"
	},
	{
		1062,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，破击率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"破击率"
	},
	{
		1063,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，破击率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"破击率"
	},
	{
		1064,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，破击率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"破击率"
	},
	{
		1071,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，暴击伤害增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击伤害"
	},
	{
		1072,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，暴击伤害增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击伤害"
	},
	{
		1073,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，暴击伤害增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击伤害"
	},
	{
		1074,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，暴击伤害增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击伤害"
	},
	{
		1081,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，普攻伤害增加6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻增伤"
	},
	{
		1082,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，普攻伤害增加9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻增伤"
	},
	{
		1083,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，普攻伤害增加13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻增伤"
	},
	{
		1084,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，普攻伤害增加18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻增伤"
	},
	{
		1091,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，超杀伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀增伤"
	},
	{
		1092,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，超杀伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀增伤"
	},
	{
		1093,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，超杀伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀增伤"
	},
	{
		1094,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，超杀伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀增伤"
	},
	{
		1101,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，受到普攻伤害减少6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻减伤"
	},
	{
		1102,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，受到普攻伤害减少9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻减伤"
	},
	{
		1103,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，受到普攻伤害减少13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻减伤"
	},
	{
		1104,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，受到普攻伤害减少18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻减伤"
	},
	{
		1111,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，受到超杀伤害减少4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀减伤"
	},
	{
		1112,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，受到超杀伤害减少6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀减伤"
	},
	{
		1113,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，受到超杀伤害减少9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀减伤"
	},
	{
		1114,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，受到超杀伤害减少12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀减伤"
	},
	{
		1121,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，反弹所有受到伤害4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"反弹伤害"
	},
	{
		1122,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，反弹所有受到伤害6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"反弹伤害"
	},
	{
		1123,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，反弹所有受到伤害9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"反弹伤害"
	},
	{
		1124,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，反弹所有受到伤害12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"反弹伤害"
	},
	{
		1131,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，附带伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"附带伤害"
	},
	{
		1132,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，附带伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"附带伤害"
	},
	{
		1133,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，附带伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"附带伤害"
	},
	{
		1134,
		"StrengthenRaceType$光",
		"宠物庇护的精灵为光系或源系精灵时，附带伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"附带伤害"
	},
	{
		2011,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，暴击率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击率"
	},
	{
		2012,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，暴击率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击率"
	},
	{
		2013,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，暴击率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击率"
	},
	{
		2014,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，暴击率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击率"
	},
	{
		2021,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，防暴率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"防暴率"
	},
	{
		2022,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，防暴率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"防暴率"
	},
	{
		2023,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，防暴率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"防暴率"
	},
	{
		2024,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，防暴率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"防暴率"
	},
	{
		2031,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，命中率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"命中率"
	},
	{
		2032,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，命中率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"命中率"
	},
	{
		2033,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，命中率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"命中率"
	},
	{
		2034,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，命中率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"命中率"
	},
	{
		2041,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，闪避率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"闪避率"
	},
	{
		2042,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，闪避率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"闪避率"
	},
	{
		2043,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，闪避率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"闪避率"
	},
	{
		2044,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，闪避率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"闪避率"
	},
	{
		2051,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，格挡率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"格挡率"
	},
	{
		2052,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，格挡率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"格挡率"
	},
	{
		2053,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，格挡率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"格挡率"
	},
	{
		2054,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，格挡率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"格挡率"
	},
	{
		2061,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，破击率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"破击率"
	},
	{
		2062,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，破击率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"破击率"
	},
	{
		2063,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，破击率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"破击率"
	},
	{
		2064,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，破击率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"破击率"
	},
	{
		2071,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，暴击伤害增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击伤害"
	},
	{
		2072,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，暴击伤害增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击伤害"
	},
	{
		2073,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，暴击伤害增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击伤害"
	},
	{
		2074,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，暴击伤害增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击伤害"
	},
	{
		2081,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，普攻伤害增加6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻增伤"
	},
	{
		2082,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，普攻伤害增加9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻增伤"
	},
	{
		2083,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，普攻伤害增加13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻增伤"
	},
	{
		2084,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，普攻伤害增加18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻增伤"
	},
	{
		2091,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，超杀伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀增伤"
	},
	{
		2092,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，超杀伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀增伤"
	},
	{
		2093,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，超杀伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀增伤"
	},
	{
		2094,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，超杀伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀增伤"
	},
	{
		2101,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，受到普攻伤害减少6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻减伤"
	},
	{
		2102,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，受到普攻伤害减少9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻减伤"
	},
	{
		2103,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，受到普攻伤害减少13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻减伤"
	},
	{
		2104,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，受到普攻伤害减少18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻减伤"
	},
	{
		2111,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，受到超杀伤害减少4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀减伤"
	},
	{
		2112,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，受到超杀伤害减少6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀减伤"
	},
	{
		2113,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，受到超杀伤害减少9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀减伤"
	},
	{
		2114,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，受到超杀伤害减少12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀减伤"
	},
	{
		2121,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，反弹所有受到伤害4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"反弹伤害"
	},
	{
		2122,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，反弹所有受到伤害6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"反弹伤害"
	},
	{
		2123,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，反弹所有受到伤害9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"反弹伤害"
	},
	{
		2124,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，反弹所有受到伤害12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"反弹伤害"
	},
	{
		2131,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，附带伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"附带伤害"
	},
	{
		2132,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，附带伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"附带伤害"
	},
	{
		2133,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，附带伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"附带伤害"
	},
	{
		2134,
		"StrengthenRaceType$暗",
		"宠物庇护的精灵为暗系或源系精灵时，附带伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"附带伤害"
	},
	{
		3011,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，暴击率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击率"
	},
	{
		3012,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，暴击率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击率"
	},
	{
		3013,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，暴击率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击率"
	},
	{
		3014,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，暴击率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击率"
	},
	{
		3021,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，防暴率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"防暴率"
	},
	{
		3022,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，防暴率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"防暴率"
	},
	{
		3023,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，防暴率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"防暴率"
	},
	{
		3024,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，防暴率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"防暴率"
	},
	{
		3031,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，命中率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"命中率"
	},
	{
		3032,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，命中率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"命中率"
	},
	{
		3033,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，命中率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"命中率"
	},
	{
		3034,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，命中率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"命中率"
	},
	{
		3041,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，闪避率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"闪避率"
	},
	{
		3042,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，闪避率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"闪避率"
	},
	{
		3043,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，闪避率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"闪避率"
	},
	{
		3044,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，闪避率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"闪避率"
	},
	{
		3051,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，格挡率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"格挡率"
	},
	{
		3052,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，格挡率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"格挡率"
	},
	{
		3053,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，格挡率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"格挡率"
	},
	{
		3054,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，格挡率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"格挡率"
	},
	{
		3061,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，破击率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"破击率"
	},
	{
		3062,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，破击率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"破击率"
	},
	{
		3063,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，破击率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"破击率"
	},
	{
		3064,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，破击率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"破击率"
	},
	{
		3071,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，暴击伤害增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击伤害"
	},
	{
		3072,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，暴击伤害增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击伤害"
	},
	{
		3073,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，暴击伤害增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击伤害"
	},
	{
		3074,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，暴击伤害增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击伤害"
	},
	{
		3081,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，普攻伤害增加6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻增伤"
	},
	{
		3082,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，普攻伤害增加9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻增伤"
	},
	{
		3083,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，普攻伤害增加13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻增伤"
	},
	{
		3084,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，普攻伤害增加18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻增伤"
	},
	{
		3091,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，超杀伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀增伤"
	},
	{
		3092,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，超杀伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀增伤"
	},
	{
		3093,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，超杀伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀增伤"
	},
	{
		3094,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，超杀伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀增伤"
	},
	{
		3101,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，受到普攻伤害减少6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻减伤"
	},
	{
		3102,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，受到普攻伤害减少9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻减伤"
	},
	{
		3103,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，受到普攻伤害减少13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻减伤"
	},
	{
		3104,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，受到普攻伤害减少18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻减伤"
	},
	{
		3111,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，受到超杀伤害减少4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀减伤"
	},
	{
		3112,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，受到超杀伤害减少6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀减伤"
	},
	{
		3113,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，受到超杀伤害减少9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀减伤"
	},
	{
		3114,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，受到超杀伤害减少12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀减伤"
	},
	{
		3121,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，反弹所有受到伤害4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"反弹伤害"
	},
	{
		3122,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，反弹所有受到伤害6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"反弹伤害"
	},
	{
		3123,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，反弹所有受到伤害9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"反弹伤害"
	},
	{
		3124,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，反弹所有受到伤害12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"反弹伤害"
	},
	{
		3131,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，附带伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"附带伤害"
	},
	{
		3132,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，附带伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"附带伤害"
	},
	{
		3133,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，附带伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"附带伤害"
	},
	{
		3134,
		"StrengthenRaceType$水",
		"宠物庇护的精灵为水系或源系精灵时，附带伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"附带伤害"
	},
	{
		4011,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，暴击率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击率"
	},
	{
		4012,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，暴击率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击率"
	},
	{
		4013,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，暴击率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击率"
	},
	{
		4014,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，暴击率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击率"
	},
	{
		4021,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，防暴率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"防暴率"
	},
	{
		4022,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，防暴率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"防暴率"
	},
	{
		4023,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，防暴率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"防暴率"
	},
	{
		4024,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，防暴率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"防暴率"
	},
	{
		4031,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，命中率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"命中率"
	},
	{
		4032,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，命中率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"命中率"
	},
	{
		4033,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，命中率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"命中率"
	},
	{
		4034,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，命中率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"命中率"
	},
	{
		4041,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，闪避率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"闪避率"
	},
	{
		4042,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，闪避率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"闪避率"
	},
	{
		4043,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，闪避率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"闪避率"
	},
	{
		4044,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，闪避率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"闪避率"
	},
	{
		4051,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，格挡率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"格挡率"
	},
	{
		4052,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，格挡率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"格挡率"
	},
	{
		4053,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，格挡率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"格挡率"
	},
	{
		4054,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，格挡率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"格挡率"
	},
	{
		4061,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，破击率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"破击率"
	},
	{
		4062,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，破击率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"破击率"
	},
	{
		4063,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，破击率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"破击率"
	},
	{
		4064,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，破击率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"破击率"
	},
	{
		4071,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，暴击伤害增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击伤害"
	},
	{
		4072,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，暴击伤害增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击伤害"
	},
	{
		4073,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，暴击伤害增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击伤害"
	},
	{
		4074,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，暴击伤害增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击伤害"
	},
	{
		4081,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，普攻伤害增加6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻增伤"
	},
	{
		4082,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，普攻伤害增加9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻增伤"
	},
	{
		4083,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，普攻伤害增加13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻增伤"
	},
	{
		4084,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，普攻伤害增加18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻增伤"
	},
	{
		4091,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，超杀伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀增伤"
	},
	{
		4092,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，超杀伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀增伤"
	},
	{
		4093,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，超杀伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀增伤"
	},
	{
		4094,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，超杀伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀增伤"
	},
	{
		4101,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，受到普攻伤害减少6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻减伤"
	},
	{
		4102,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，受到普攻伤害减少9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻减伤"
	},
	{
		4103,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，受到普攻伤害减少13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻减伤"
	},
	{
		4104,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，受到普攻伤害减少18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻减伤"
	},
	{
		4111,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，受到超杀伤害减少4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀减伤"
	},
	{
		4112,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，受到超杀伤害减少6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀减伤"
	},
	{
		4113,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，受到超杀伤害减少9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀减伤"
	},
	{
		4114,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，受到超杀伤害减少12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀减伤"
	},
	{
		4121,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，反弹所有受到伤害4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"反弹伤害"
	},
	{
		4122,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，反弹所有受到伤害6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"反弹伤害"
	},
	{
		4123,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，反弹所有受到伤害9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"反弹伤害"
	},
	{
		4124,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，反弹所有受到伤害12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"反弹伤害"
	},
	{
		4131,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，附带伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"附带伤害"
	},
	{
		4132,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，附带伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"附带伤害"
	},
	{
		4133,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，附带伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"附带伤害"
	},
	{
		4134,
		"StrengthenRaceType$火",
		"宠物庇护的精灵为火系或源系精灵时，附带伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"附带伤害"
	},
	{
		5011,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，暴击率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击率"
	},
	{
		5012,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，暴击率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击率"
	},
	{
		5013,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，暴击率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击率"
	},
	{
		5014,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，暴击率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击率"
	},
	{
		5021,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，防暴率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"防暴率"
	},
	{
		5022,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，防暴率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"防暴率"
	},
	{
		5023,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，防暴率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"防暴率"
	},
	{
		5024,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，防暴率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"防暴率"
	},
	{
		5031,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，命中率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"命中率"
	},
	{
		5032,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，命中率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"命中率"
	},
	{
		5033,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，命中率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"命中率"
	},
	{
		5034,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，命中率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"命中率"
	},
	{
		5041,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，闪避率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"闪避率"
	},
	{
		5042,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，闪避率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"闪避率"
	},
	{
		5043,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，闪避率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"闪避率"
	},
	{
		5044,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，闪避率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"闪避率"
	},
	{
		5051,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，格挡率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"格挡率"
	},
	{
		5052,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，格挡率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"格挡率"
	},
	{
		5053,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，格挡率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"格挡率"
	},
	{
		5054,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，格挡率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"格挡率"
	},
	{
		5061,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，破击率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"破击率"
	},
	{
		5062,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，破击率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"破击率"
	},
	{
		5063,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，破击率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"破击率"
	},
	{
		5064,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，破击率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"破击率"
	},
	{
		5071,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，暴击伤害增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击伤害"
	},
	{
		5072,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，暴击伤害增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击伤害"
	},
	{
		5073,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，暴击伤害增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击伤害"
	},
	{
		5074,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，暴击伤害增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击伤害"
	},
	{
		5081,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，普攻伤害增加6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻增伤"
	},
	{
		5082,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，普攻伤害增加9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻增伤"
	},
	{
		5083,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，普攻伤害增加13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻增伤"
	},
	{
		5084,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，普攻伤害增加18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻增伤"
	},
	{
		5091,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，超杀伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀增伤"
	},
	{
		5092,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，超杀伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀增伤"
	},
	{
		5093,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，超杀伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀增伤"
	},
	{
		5094,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，超杀伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀增伤"
	},
	{
		5101,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，受到普攻伤害减少6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻减伤"
	},
	{
		5102,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，受到普攻伤害减少9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻减伤"
	},
	{
		5103,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，受到普攻伤害减少13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻减伤"
	},
	{
		5104,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，受到普攻伤害减少18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻减伤"
	},
	{
		5111,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，受到超杀伤害减少4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀减伤"
	},
	{
		5112,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，受到超杀伤害减少6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀减伤"
	},
	{
		5113,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，受到超杀伤害减少9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀减伤"
	},
	{
		5114,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，受到超杀伤害减少12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀减伤"
	},
	{
		5121,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，反弹所有受到伤害4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"反弹伤害"
	},
	{
		5122,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，反弹所有受到伤害6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"反弹伤害"
	},
	{
		5123,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，反弹所有受到伤害9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"反弹伤害"
	},
	{
		5124,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，反弹所有受到伤害12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"反弹伤害"
	},
	{
		5131,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，附带伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"附带伤害"
	},
	{
		5132,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，附带伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"附带伤害"
	},
	{
		5133,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，附带伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"附带伤害"
	},
	{
		5134,
		"StrengthenRaceType$草",
		"宠物庇护的精灵为草系或源系精灵时，附带伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"附带伤害"
	},
	{
		6011,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，暴击率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击率"
	},
	{
		6012,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，暴击率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击率"
	},
	{
		6013,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，暴击率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击率"
	},
	{
		6014,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，暴击率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击率"
	},
	{
		6021,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，防暴率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"防暴率"
	},
	{
		6022,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，防暴率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"防暴率"
	},
	{
		6023,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，防暴率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"防暴率"
	},
	{
		6024,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，防暴率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"防暴率"
	},
	{
		6031,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，命中率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"命中率"
	},
	{
		6032,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，命中率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"命中率"
	},
	{
		6033,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，命中率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"命中率"
	},
	{
		6034,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，命中率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"命中率"
	},
	{
		6041,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，闪避率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"闪避率"
	},
	{
		6042,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，闪避率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"闪避率"
	},
	{
		6043,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，闪避率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"闪避率"
	},
	{
		6044,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，闪避率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"闪避率"
	},
	{
		6051,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，格挡率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"格挡率"
	},
	{
		6052,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，格挡率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"格挡率"
	},
	{
		6053,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，格挡率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"格挡率"
	},
	{
		6054,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，格挡率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"格挡率"
	},
	{
		6061,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，破击率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"破击率"
	},
	{
		6062,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，破击率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"破击率"
	},
	{
		6063,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，破击率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"破击率"
	},
	{
		6064,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，破击率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"破击率"
	},
	{
		6071,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，暴击伤害增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击伤害"
	},
	{
		6072,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，暴击伤害增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击伤害"
	},
	{
		6073,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，暴击伤害增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击伤害"
	},
	{
		6074,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，暴击伤害增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击伤害"
	},
	{
		6081,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，普攻伤害增加6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻增伤"
	},
	{
		6082,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，普攻伤害增加9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻增伤"
	},
	{
		6083,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，普攻伤害增加13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻增伤"
	},
	{
		6084,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，普攻伤害增加18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻增伤"
	},
	{
		6091,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，超杀伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀增伤"
	},
	{
		6092,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，超杀伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀增伤"
	},
	{
		6093,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，超杀伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀增伤"
	},
	{
		6094,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，超杀伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀增伤"
	},
	{
		6101,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，受到普攻伤害减少6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻减伤"
	},
	{
		6102,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，受到普攻伤害减少9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻减伤"
	},
	{
		6103,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，受到普攻伤害减少13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻减伤"
	},
	{
		6104,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，受到普攻伤害减少18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻减伤"
	},
	{
		6111,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，受到超杀伤害减少4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀减伤"
	},
	{
		6112,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，受到超杀伤害减少6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀减伤"
	},
	{
		6113,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，受到超杀伤害减少9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀减伤"
	},
	{
		6114,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，受到超杀伤害减少12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀减伤"
	},
	{
		6121,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，反弹所有受到伤害4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"反弹伤害"
	},
	{
		6122,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，反弹所有受到伤害6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"反弹伤害"
	},
	{
		6123,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，反弹所有受到伤害9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"反弹伤害"
	},
	{
		6124,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，反弹所有受到伤害12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"反弹伤害"
	},
	{
		6131,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，附带伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"附带伤害"
	},
	{
		6132,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，附带伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"附带伤害"
	},
	{
		6133,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，附带伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"附带伤害"
	},
	{
		6134,
		"StrengthenRaceType$创",
		"宠物庇护的精灵为创系或源系精灵时，附带伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"附带伤害"
	},
	{
		7011,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，暴击率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击率"
	},
	{
		7012,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，暴击率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击率"
	},
	{
		7013,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，暴击率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击率"
	},
	{
		7014,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，暴击率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击率"
	},
	{
		7021,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，防暴率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"防暴率"
	},
	{
		7022,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，防暴率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"防暴率"
	},
	{
		7023,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，防暴率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"防暴率"
	},
	{
		7024,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，防暴率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"防暴率"
	},
	{
		7031,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，命中率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"命中率"
	},
	{
		7032,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，命中率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"命中率"
	},
	{
		7033,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，命中率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"命中率"
	},
	{
		7034,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，命中率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"命中率"
	},
	{
		7041,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，闪避率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"闪避率"
	},
	{
		7042,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，闪避率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"闪避率"
	},
	{
		7043,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，闪避率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"闪避率"
	},
	{
		7044,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，闪避率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"闪避率"
	},
	{
		7051,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，格挡率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"格挡率"
	},
	{
		7052,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，格挡率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"格挡率"
	},
	{
		7053,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，格挡率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"格挡率"
	},
	{
		7054,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，格挡率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"格挡率"
	},
	{
		7061,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，破击率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"破击率"
	},
	{
		7062,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，破击率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"破击率"
	},
	{
		7063,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，破击率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"破击率"
	},
	{
		7064,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，破击率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"破击率"
	},
	{
		7071,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，暴击伤害增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击伤害"
	},
	{
		7072,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，暴击伤害增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击伤害"
	},
	{
		7073,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，暴击伤害增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击伤害"
	},
	{
		7074,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，暴击伤害增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击伤害"
	},
	{
		7081,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，普攻伤害增加6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻增伤"
	},
	{
		7082,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，普攻伤害增加9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻增伤"
	},
	{
		7083,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，普攻伤害增加13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻增伤"
	},
	{
		7084,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，普攻伤害增加18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻增伤"
	},
	{
		7091,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，超杀伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀增伤"
	},
	{
		7092,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，超杀伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀增伤"
	},
	{
		7093,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，超杀伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀增伤"
	},
	{
		7094,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，超杀伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀增伤"
	},
	{
		7101,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，受到普攻伤害减少6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻减伤"
	},
	{
		7102,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，受到普攻伤害减少9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻减伤"
	},
	{
		7103,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，受到普攻伤害减少13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻减伤"
	},
	{
		7104,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，受到普攻伤害减少18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻减伤"
	},
	{
		7111,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，受到超杀伤害减少4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀减伤"
	},
	{
		7112,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，受到超杀伤害减少6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀减伤"
	},
	{
		7113,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，受到超杀伤害减少9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀减伤"
	},
	{
		7114,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，受到超杀伤害减少12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀减伤"
	},
	{
		7121,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，反弹所有受到伤害4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"反弹伤害"
	},
	{
		7122,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，反弹所有受到伤害6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"反弹伤害"
	},
	{
		7123,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，反弹所有受到伤害9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"反弹伤害"
	},
	{
		7124,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，反弹所有受到伤害12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"反弹伤害"
	},
	{
		7131,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，附带伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"附带伤害"
	},
	{
		7132,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，附带伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"附带伤害"
	},
	{
		7133,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，附带伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"附带伤害"
	},
	{
		7134,
		"StrengthenRaceType$空",
		"宠物庇护的精灵为空系或源系精灵时，附带伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"附带伤害"
	},
	{
		8011,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，暴击率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击率"
	},
	{
		8012,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，暴击率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击率"
	},
	{
		8013,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，暴击率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击率"
	},
	{
		8014,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，暴击率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击率"
	},
	{
		8021,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，防暴率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"防暴率"
	},
	{
		8022,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，防暴率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"防暴率"
	},
	{
		8023,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，防暴率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"防暴率"
	},
	{
		8024,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，防暴率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"防暴率"
	},
	{
		8031,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，命中率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"命中率"
	},
	{
		8032,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，命中率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"命中率"
	},
	{
		8033,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，命中率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"命中率"
	},
	{
		8034,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，命中率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"命中率"
	},
	{
		8041,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，闪避率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"闪避率"
	},
	{
		8042,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，闪避率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"闪避率"
	},
	{
		8043,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，闪避率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"闪避率"
	},
	{
		8044,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，闪避率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"闪避率"
	},
	{
		8051,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，格挡率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"格挡率"
	},
	{
		8052,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，格挡率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"格挡率"
	},
	{
		8053,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，格挡率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"格挡率"
	},
	{
		8054,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，格挡率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"格挡率"
	},
	{
		8061,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，破击率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"破击率"
	},
	{
		8062,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，破击率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"破击率"
	},
	{
		8063,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，破击率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"破击率"
	},
	{
		8064,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，破击率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"破击率"
	},
	{
		8071,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，暴击伤害增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击伤害"
	},
	{
		8072,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，暴击伤害增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击伤害"
	},
	{
		8073,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，暴击伤害增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击伤害"
	},
	{
		8074,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，暴击伤害增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击伤害"
	},
	{
		8081,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，普攻伤害增加6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻增伤"
	},
	{
		8082,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，普攻伤害增加9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻增伤"
	},
	{
		8083,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，普攻伤害增加13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻增伤"
	},
	{
		8084,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，普攻伤害增加18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻增伤"
	},
	{
		8091,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，超杀伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀增伤"
	},
	{
		8092,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，超杀伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀增伤"
	},
	{
		8093,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，超杀伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀增伤"
	},
	{
		8094,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，超杀伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀增伤"
	},
	{
		8101,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，受到普攻伤害减少6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻减伤"
	},
	{
		8102,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，受到普攻伤害减少9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻减伤"
	},
	{
		8103,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，受到普攻伤害减少13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻减伤"
	},
	{
		8104,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，受到普攻伤害减少18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻减伤"
	},
	{
		8111,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，受到超杀伤害减少4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀减伤"
	},
	{
		8112,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，受到超杀伤害减少6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀减伤"
	},
	{
		8113,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，受到超杀伤害减少9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀减伤"
	},
	{
		8114,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，受到超杀伤害减少12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀减伤"
	},
	{
		8121,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，反弹所有受到伤害4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"反弹伤害"
	},
	{
		8122,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，反弹所有受到伤害6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"反弹伤害"
	},
	{
		8123,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，反弹所有受到伤害9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"反弹伤害"
	},
	{
		8124,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，反弹所有受到伤害12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"反弹伤害"
	},
	{
		8131,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，附带伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"附带伤害"
	},
	{
		8132,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，附带伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"附带伤害"
	},
	{
		8133,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，附带伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"附带伤害"
	},
	{
		8134,
		"Job$利爪",
		"宠物庇护的精灵为利爪精灵时，附带伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"附带伤害"
	},
	{
		9011,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，暴击率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击率"
	},
	{
		9012,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，暴击率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击率"
	},
	{
		9013,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，暴击率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击率"
	},
	{
		9014,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，暴击率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击率"
	},
	{
		9021,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，防暴率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"防暴率"
	},
	{
		9022,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，防暴率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"防暴率"
	},
	{
		9023,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，防暴率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"防暴率"
	},
	{
		9024,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，防暴率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"防暴率"
	},
	{
		9031,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，命中率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"命中率"
	},
	{
		9032,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，命中率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"命中率"
	},
	{
		9033,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，命中率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"命中率"
	},
	{
		9034,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，命中率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"命中率"
	},
	{
		9041,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，闪避率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"闪避率"
	},
	{
		9042,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，闪避率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"闪避率"
	},
	{
		9043,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，闪避率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"闪避率"
	},
	{
		9044,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，闪避率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"闪避率"
	},
	{
		9051,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，格挡率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"格挡率"
	},
	{
		9052,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，格挡率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"格挡率"
	},
	{
		9053,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，格挡率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"格挡率"
	},
	{
		9054,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，格挡率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"格挡率"
	},
	{
		9061,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，破击率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"破击率"
	},
	{
		9062,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，破击率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"破击率"
	},
	{
		9063,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，破击率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"破击率"
	},
	{
		9064,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，破击率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"破击率"
	},
	{
		9071,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，暴击伤害增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击伤害"
	},
	{
		9072,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，暴击伤害增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击伤害"
	},
	{
		9073,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，暴击伤害增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击伤害"
	},
	{
		9074,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，暴击伤害增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击伤害"
	},
	{
		9081,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，普攻伤害增加6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻增伤"
	},
	{
		9082,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，普攻伤害增加9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻增伤"
	},
	{
		9083,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，普攻伤害增加13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻增伤"
	},
	{
		9084,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，普攻伤害增加18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻增伤"
	},
	{
		9091,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，超杀伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀增伤"
	},
	{
		9092,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，超杀伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀增伤"
	},
	{
		9093,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，超杀伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀增伤"
	},
	{
		9094,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，超杀伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀增伤"
	},
	{
		9101,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，受到普攻伤害减少6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻减伤"
	},
	{
		9102,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，受到普攻伤害减少9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻减伤"
	},
	{
		9103,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，受到普攻伤害减少13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻减伤"
	},
	{
		9104,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，受到普攻伤害减少18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻减伤"
	},
	{
		9111,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，受到超杀伤害减少4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀减伤"
	},
	{
		9112,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，受到超杀伤害减少6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀减伤"
	},
	{
		9113,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，受到超杀伤害减少9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀减伤"
	},
	{
		9114,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，受到超杀伤害减少12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀减伤"
	},
	{
		9121,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，反弹所有受到伤害4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"反弹伤害"
	},
	{
		9122,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，反弹所有受到伤害6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"反弹伤害"
	},
	{
		9123,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，反弹所有受到伤害9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"反弹伤害"
	},
	{
		9124,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，反弹所有受到伤害12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"反弹伤害"
	},
	{
		9131,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，附带伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"附带伤害"
	},
	{
		9132,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，附带伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"附带伤害"
	},
	{
		9133,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，附带伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"附带伤害"
	},
	{
		9134,
		"Job$魔法",
		"宠物庇护的精灵为魔法精灵时，附带伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"附带伤害"
	},
	{
		10011,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，暴击率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击率"
	},
	{
		10012,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，暴击率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击率"
	},
	{
		10013,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，暴击率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击率"
	},
	{
		10014,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，暴击率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击率"
	},
	{
		10021,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，防暴率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"防暴率"
	},
	{
		10022,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，防暴率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"防暴率"
	},
	{
		10023,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，防暴率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"防暴率"
	},
	{
		10024,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，防暴率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"防暴率"
	},
	{
		10031,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，命中率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"命中率"
	},
	{
		10032,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，命中率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"命中率"
	},
	{
		10033,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，命中率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"命中率"
	},
	{
		10034,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，命中率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"命中率"
	},
	{
		10041,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，闪避率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"闪避率"
	},
	{
		10042,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，闪避率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"闪避率"
	},
	{
		10043,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，闪避率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"闪避率"
	},
	{
		10044,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，闪避率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"闪避率"
	},
	{
		10051,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，格挡率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"格挡率"
	},
	{
		10052,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，格挡率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"格挡率"
	},
	{
		10053,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，格挡率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"格挡率"
	},
	{
		10054,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，格挡率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"格挡率"
	},
	{
		10061,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，破击率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"破击率"
	},
	{
		10062,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，破击率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"破击率"
	},
	{
		10063,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，破击率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"破击率"
	},
	{
		10064,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，破击率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"破击率"
	},
	{
		10071,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，暴击伤害增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击伤害"
	},
	{
		10072,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，暴击伤害增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击伤害"
	},
	{
		10073,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，暴击伤害增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击伤害"
	},
	{
		10074,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，暴击伤害增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击伤害"
	},
	{
		10081,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，普攻伤害增加6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻增伤"
	},
	{
		10082,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，普攻伤害增加9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻增伤"
	},
	{
		10083,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，普攻伤害增加13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻增伤"
	},
	{
		10084,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，普攻伤害增加18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻增伤"
	},
	{
		10091,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，超杀伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀增伤"
	},
	{
		10092,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，超杀伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀增伤"
	},
	{
		10093,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，超杀伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀增伤"
	},
	{
		10094,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，超杀伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀增伤"
	},
	{
		10101,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，受到普攻伤害减少6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻减伤"
	},
	{
		10102,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，受到普攻伤害减少9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻减伤"
	},
	{
		10103,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，受到普攻伤害减少13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻减伤"
	},
	{
		10104,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，受到普攻伤害减少18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻减伤"
	},
	{
		10111,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，受到超杀伤害减少4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀减伤"
	},
	{
		10112,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，受到超杀伤害减少6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀减伤"
	},
	{
		10113,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，受到超杀伤害减少9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀减伤"
	},
	{
		10114,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，受到超杀伤害减少12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀减伤"
	},
	{
		10121,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，反弹所有受到伤害4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"反弹伤害"
	},
	{
		10122,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，反弹所有受到伤害6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"反弹伤害"
	},
	{
		10123,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，反弹所有受到伤害9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"反弹伤害"
	},
	{
		10124,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，反弹所有受到伤害12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"反弹伤害"
	},
	{
		10131,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，附带伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"附带伤害"
	},
	{
		10132,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，附带伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"附带伤害"
	},
	{
		10133,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，附带伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"附带伤害"
	},
	{
		10134,
		"Job$疾速",
		"宠物庇护的精灵为疾速精灵时，附带伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"附带伤害"
	},
	{
		11011,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，暴击率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击率"
	},
	{
		11012,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，暴击率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击率"
	},
	{
		11013,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，暴击率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击率"
	},
	{
		11014,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，暴击率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击率"
	},
	{
		11021,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，防暴率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"防暴率"
	},
	{
		11022,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，防暴率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"防暴率"
	},
	{
		11023,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，防暴率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"防暴率"
	},
	{
		11024,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，防暴率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"防暴率"
	},
	{
		11031,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，命中率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"命中率"
	},
	{
		11032,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，命中率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"命中率"
	},
	{
		11033,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，命中率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"命中率"
	},
	{
		11034,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，命中率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"命中率"
	},
	{
		11041,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，闪避率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"闪避率"
	},
	{
		11042,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，闪避率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"闪避率"
	},
	{
		11043,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，闪避率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"闪避率"
	},
	{
		11044,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，闪避率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"闪避率"
	},
	{
		11051,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，格挡率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"格挡率"
	},
	{
		11052,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，格挡率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"格挡率"
	},
	{
		11053,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，格挡率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"格挡率"
	},
	{
		11054,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，格挡率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"格挡率"
	},
	{
		11061,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，破击率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"破击率"
	},
	{
		11062,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，破击率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"破击率"
	},
	{
		11063,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，破击率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"破击率"
	},
	{
		11064,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，破击率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"破击率"
	},
	{
		11071,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，暴击伤害增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击伤害"
	},
	{
		11072,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，暴击伤害增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击伤害"
	},
	{
		11073,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，暴击伤害增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击伤害"
	},
	{
		11074,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，暴击伤害增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击伤害"
	},
	{
		11081,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，普攻伤害增加6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻增伤"
	},
	{
		11082,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，普攻伤害增加9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻增伤"
	},
	{
		11083,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，普攻伤害增加13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻增伤"
	},
	{
		11084,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，普攻伤害增加18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻增伤"
	},
	{
		11091,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，超杀伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀增伤"
	},
	{
		11092,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，超杀伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀增伤"
	},
	{
		11093,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，超杀伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀增伤"
	},
	{
		11094,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，超杀伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀增伤"
	},
	{
		11101,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，受到普攻伤害减少6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻减伤"
	},
	{
		11102,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，受到普攻伤害减少9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻减伤"
	},
	{
		11103,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，受到普攻伤害减少13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻减伤"
	},
	{
		11104,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，受到普攻伤害减少18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻减伤"
	},
	{
		11111,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，受到超杀伤害减少4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀减伤"
	},
	{
		11112,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，受到超杀伤害减少6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀减伤"
	},
	{
		11113,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，受到超杀伤害减少9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀减伤"
	},
	{
		11114,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，受到超杀伤害减少12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀减伤"
	},
	{
		11121,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，反弹所有受到伤害4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"反弹伤害"
	},
	{
		11122,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，反弹所有受到伤害6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"反弹伤害"
	},
	{
		11123,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，反弹所有受到伤害9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"反弹伤害"
	},
	{
		11124,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，反弹所有受到伤害12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"反弹伤害"
	},
	{
		11131,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，附带伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"附带伤害"
	},
	{
		11132,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，附带伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"附带伤害"
	},
	{
		11133,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，附带伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"附带伤害"
	},
	{
		11134,
		"Job$平衡",
		"宠物庇护的精灵为平衡精灵时，附带伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"附带伤害"
	},
	{
		12011,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，暴击率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击率"
	},
	{
		12012,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，暴击率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击率"
	},
	{
		12013,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，暴击率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击率"
	},
	{
		12014,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，暴击率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击率"
	},
	{
		12021,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，防暴率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"防暴率"
	},
	{
		12022,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，防暴率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"防暴率"
	},
	{
		12023,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，防暴率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"防暴率"
	},
	{
		12024,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，防暴率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"防暴率"
	},
	{
		12031,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，命中率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"命中率"
	},
	{
		12032,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，命中率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"命中率"
	},
	{
		12033,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，命中率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"命中率"
	},
	{
		12034,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，命中率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"命中率"
	},
	{
		12041,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，闪避率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"闪避率"
	},
	{
		12042,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，闪避率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"闪避率"
	},
	{
		12043,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，闪避率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"闪避率"
	},
	{
		12044,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，闪避率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"闪避率"
	},
	{
		12051,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，格挡率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"格挡率"
	},
	{
		12052,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，格挡率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"格挡率"
	},
	{
		12053,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，格挡率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"格挡率"
	},
	{
		12054,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，格挡率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"格挡率"
	},
	{
		12061,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，破击率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"破击率"
	},
	{
		12062,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，破击率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"破击率"
	},
	{
		12063,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，破击率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"破击率"
	},
	{
		12064,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，破击率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"破击率"
	},
	{
		12071,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，暴击伤害增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击伤害"
	},
	{
		12072,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，暴击伤害增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击伤害"
	},
	{
		12073,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，暴击伤害增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击伤害"
	},
	{
		12074,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，暴击伤害增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击伤害"
	},
	{
		12081,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，普攻伤害增加6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻增伤"
	},
	{
		12082,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，普攻伤害增加9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻增伤"
	},
	{
		12083,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，普攻伤害增加13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻增伤"
	},
	{
		12084,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，普攻伤害增加18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻增伤"
	},
	{
		12091,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，超杀伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀增伤"
	},
	{
		12092,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，超杀伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀增伤"
	},
	{
		12093,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，超杀伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀增伤"
	},
	{
		12094,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，超杀伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀增伤"
	},
	{
		12101,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，受到普攻伤害减少6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻减伤"
	},
	{
		12102,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，受到普攻伤害减少9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻减伤"
	},
	{
		12103,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，受到普攻伤害减少13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻减伤"
	},
	{
		12104,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，受到普攻伤害减少18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻减伤"
	},
	{
		12111,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，受到超杀伤害减少4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀减伤"
	},
	{
		12112,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，受到超杀伤害减少6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀减伤"
	},
	{
		12113,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，受到超杀伤害减少9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀减伤"
	},
	{
		12114,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，受到超杀伤害减少12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀减伤"
	},
	{
		12121,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，反弹所有受到伤害4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"反弹伤害"
	},
	{
		12122,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，反弹所有受到伤害6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"反弹伤害"
	},
	{
		12123,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，反弹所有受到伤害9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"反弹伤害"
	},
	{
		12124,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，反弹所有受到伤害12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"反弹伤害"
	},
	{
		12131,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，附带伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"附带伤害"
	},
	{
		12132,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，附带伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"附带伤害"
	},
	{
		12133,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，附带伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"附带伤害"
	},
	{
		12134,
		"Job$肉盾",
		"宠物庇护的精灵为肉盾精灵时，附带伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"附带伤害"
	},
	{
		13011,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，暴击率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击率"
	},
	{
		13012,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，暴击率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击率"
	},
	{
		13013,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，暴击率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击率"
	},
	{
		13014,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，暴击率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击率"
	},
	{
		13021,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，防暴率增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"防暴率"
	},
	{
		13022,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，防暴率增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"防暴率"
	},
	{
		13023,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，防暴率增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"防暴率"
	},
	{
		13024,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，防暴率增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"防暴率"
	},
	{
		13031,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，命中率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"命中率"
	},
	{
		13032,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，命中率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"命中率"
	},
	{
		13033,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，命中率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"命中率"
	},
	{
		13034,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，命中率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"命中率"
	},
	{
		13041,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，闪避率增加2.5%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"闪避率"
	},
	{
		13042,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，闪避率增加3.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"闪避率"
	},
	{
		13043,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，闪避率增加5.6%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"闪避率"
	},
	{
		13044,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，闪避率增加7.5%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"闪避率"
	},
	{
		13051,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，格挡率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"格挡率"
	},
	{
		13052,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，格挡率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"格挡率"
	},
	{
		13053,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，格挡率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"格挡率"
	},
	{
		13054,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，格挡率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"格挡率"
	},
	{
		13061,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，破击率增加3.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"破击率"
	},
	{
		13062,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，破击率增加4.8%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"破击率"
	},
	{
		13063,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，破击率增加7.2%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"破击率"
	},
	{
		13064,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，破击率增加9.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"破击率"
	},
	{
		13071,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，暴击伤害增加4.2%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"暴击伤害"
	},
	{
		13072,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，暴击伤害增加6.3%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"暴击伤害"
	},
	{
		13073,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，暴击伤害增加9.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"暴击伤害"
	},
	{
		13074,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，暴击伤害增加12.6%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"暴击伤害"
	},
	{
		13081,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，普攻伤害增加6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻增伤"
	},
	{
		13082,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，普攻伤害增加9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻增伤"
	},
	{
		13083,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，普攻伤害增加13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻增伤"
	},
	{
		13084,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，普攻伤害增加18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻增伤"
	},
	{
		13091,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，超杀伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀增伤"
	},
	{
		13092,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，超杀伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀增伤"
	},
	{
		13093,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，超杀伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀增伤"
	},
	{
		13094,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，超杀伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀增伤"
	},
	{
		13101,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，受到普攻伤害减少6%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"普攻减伤"
	},
	{
		13102,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，受到普攻伤害减少9%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"普攻减伤"
	},
	{
		13103,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，受到普攻伤害减少13.5%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"普攻减伤"
	},
	{
		13104,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，受到普攻伤害减少18%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"普攻减伤"
	},
	{
		13111,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，受到超杀伤害减少4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"超杀减伤"
	},
	{
		13112,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，受到超杀伤害减少6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"超杀减伤"
	},
	{
		13113,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，受到超杀伤害减少9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"超杀减伤"
	},
	{
		13114,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，受到超杀伤害减少12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"超杀减伤"
	},
	{
		13121,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，反弹所有受到伤害4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"反弹伤害"
	},
	{
		13122,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，反弹所有受到伤害6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"反弹伤害"
	},
	{
		13123,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，反弹所有受到伤害9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"反弹伤害"
	},
	{
		13124,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，反弹所有受到伤害12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"反弹伤害"
	},
	{
		13131,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，附带伤害增加4%<color=#20B376>（一般般）</color>",
		250,
		"2",
		"附带伤害"
	},
	{
		13132,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，附带伤害增加6%<color=#0083E7>（还不错）</color>",
		375,
		"3",
		"附带伤害"
	},
	{
		13133,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，附带伤害增加9%<color=#DF5BFF>（了不起）</color>",
		575,
		"4",
		"附带伤害"
	},
	{
		13134,
		"Job$治疗",
		"宠物庇护的精灵为治疗精灵时，附带伤害增加12%<color=#CD7800>（很完美）</color>",
		750,
		"5",
		"附带伤害"
	}
}
local t_cute_pet_talent = {
	[1011] = dataList[1],
	[1012] = dataList[2],
	[1013] = dataList[3],
	[1014] = dataList[4],
	[1021] = dataList[5],
	[1022] = dataList[6],
	[1023] = dataList[7],
	[1024] = dataList[8],
	[1031] = dataList[9],
	[1032] = dataList[10],
	[1033] = dataList[11],
	[1034] = dataList[12],
	[1041] = dataList[13],
	[1042] = dataList[14],
	[1043] = dataList[15],
	[1044] = dataList[16],
	[1051] = dataList[17],
	[1052] = dataList[18],
	[1053] = dataList[19],
	[1054] = dataList[20],
	[1061] = dataList[21],
	[1062] = dataList[22],
	[1063] = dataList[23],
	[1064] = dataList[24],
	[1071] = dataList[25],
	[1072] = dataList[26],
	[1073] = dataList[27],
	[1074] = dataList[28],
	[1081] = dataList[29],
	[1082] = dataList[30],
	[1083] = dataList[31],
	[1084] = dataList[32],
	[1091] = dataList[33],
	[1092] = dataList[34],
	[1093] = dataList[35],
	[1094] = dataList[36],
	[1101] = dataList[37],
	[1102] = dataList[38],
	[1103] = dataList[39],
	[1104] = dataList[40],
	[1111] = dataList[41],
	[1112] = dataList[42],
	[1113] = dataList[43],
	[1114] = dataList[44],
	[1121] = dataList[45],
	[1122] = dataList[46],
	[1123] = dataList[47],
	[1124] = dataList[48],
	[1131] = dataList[49],
	[1132] = dataList[50],
	[1133] = dataList[51],
	[1134] = dataList[52],
	[2011] = dataList[53],
	[2012] = dataList[54],
	[2013] = dataList[55],
	[2014] = dataList[56],
	[2021] = dataList[57],
	[2022] = dataList[58],
	[2023] = dataList[59],
	[2024] = dataList[60],
	[2031] = dataList[61],
	[2032] = dataList[62],
	[2033] = dataList[63],
	[2034] = dataList[64],
	[2041] = dataList[65],
	[2042] = dataList[66],
	[2043] = dataList[67],
	[2044] = dataList[68],
	[2051] = dataList[69],
	[2052] = dataList[70],
	[2053] = dataList[71],
	[2054] = dataList[72],
	[2061] = dataList[73],
	[2062] = dataList[74],
	[2063] = dataList[75],
	[2064] = dataList[76],
	[2071] = dataList[77],
	[2072] = dataList[78],
	[2073] = dataList[79],
	[2074] = dataList[80],
	[2081] = dataList[81],
	[2082] = dataList[82],
	[2083] = dataList[83],
	[2084] = dataList[84],
	[2091] = dataList[85],
	[2092] = dataList[86],
	[2093] = dataList[87],
	[2094] = dataList[88],
	[2101] = dataList[89],
	[2102] = dataList[90],
	[2103] = dataList[91],
	[2104] = dataList[92],
	[2111] = dataList[93],
	[2112] = dataList[94],
	[2113] = dataList[95],
	[2114] = dataList[96],
	[2121] = dataList[97],
	[2122] = dataList[98],
	[2123] = dataList[99],
	[2124] = dataList[100],
	[2131] = dataList[101],
	[2132] = dataList[102],
	[2133] = dataList[103],
	[2134] = dataList[104],
	[3011] = dataList[105],
	[3012] = dataList[106],
	[3013] = dataList[107],
	[3014] = dataList[108],
	[3021] = dataList[109],
	[3022] = dataList[110],
	[3023] = dataList[111],
	[3024] = dataList[112],
	[3031] = dataList[113],
	[3032] = dataList[114],
	[3033] = dataList[115],
	[3034] = dataList[116],
	[3041] = dataList[117],
	[3042] = dataList[118],
	[3043] = dataList[119],
	[3044] = dataList[120],
	[3051] = dataList[121],
	[3052] = dataList[122],
	[3053] = dataList[123],
	[3054] = dataList[124],
	[3061] = dataList[125],
	[3062] = dataList[126],
	[3063] = dataList[127],
	[3064] = dataList[128],
	[3071] = dataList[129],
	[3072] = dataList[130],
	[3073] = dataList[131],
	[3074] = dataList[132],
	[3081] = dataList[133],
	[3082] = dataList[134],
	[3083] = dataList[135],
	[3084] = dataList[136],
	[3091] = dataList[137],
	[3092] = dataList[138],
	[3093] = dataList[139],
	[3094] = dataList[140],
	[3101] = dataList[141],
	[3102] = dataList[142],
	[3103] = dataList[143],
	[3104] = dataList[144],
	[3111] = dataList[145],
	[3112] = dataList[146],
	[3113] = dataList[147],
	[3114] = dataList[148],
	[3121] = dataList[149],
	[3122] = dataList[150],
	[3123] = dataList[151],
	[3124] = dataList[152],
	[3131] = dataList[153],
	[3132] = dataList[154],
	[3133] = dataList[155],
	[3134] = dataList[156],
	[4011] = dataList[157],
	[4012] = dataList[158],
	[4013] = dataList[159],
	[4014] = dataList[160],
	[4021] = dataList[161],
	[4022] = dataList[162],
	[4023] = dataList[163],
	[4024] = dataList[164],
	[4031] = dataList[165],
	[4032] = dataList[166],
	[4033] = dataList[167],
	[4034] = dataList[168],
	[4041] = dataList[169],
	[4042] = dataList[170],
	[4043] = dataList[171],
	[4044] = dataList[172],
	[4051] = dataList[173],
	[4052] = dataList[174],
	[4053] = dataList[175],
	[4054] = dataList[176],
	[4061] = dataList[177],
	[4062] = dataList[178],
	[4063] = dataList[179],
	[4064] = dataList[180],
	[4071] = dataList[181],
	[4072] = dataList[182],
	[4073] = dataList[183],
	[4074] = dataList[184],
	[4081] = dataList[185],
	[4082] = dataList[186],
	[4083] = dataList[187],
	[4084] = dataList[188],
	[4091] = dataList[189],
	[4092] = dataList[190],
	[4093] = dataList[191],
	[4094] = dataList[192],
	[4101] = dataList[193],
	[4102] = dataList[194],
	[4103] = dataList[195],
	[4104] = dataList[196],
	[4111] = dataList[197],
	[4112] = dataList[198],
	[4113] = dataList[199],
	[4114] = dataList[200],
	[4121] = dataList[201],
	[4122] = dataList[202],
	[4123] = dataList[203],
	[4124] = dataList[204],
	[4131] = dataList[205],
	[4132] = dataList[206],
	[4133] = dataList[207],
	[4134] = dataList[208],
	[5011] = dataList[209],
	[5012] = dataList[210],
	[5013] = dataList[211],
	[5014] = dataList[212],
	[5021] = dataList[213],
	[5022] = dataList[214],
	[5023] = dataList[215],
	[5024] = dataList[216],
	[5031] = dataList[217],
	[5032] = dataList[218],
	[5033] = dataList[219],
	[5034] = dataList[220],
	[5041] = dataList[221],
	[5042] = dataList[222],
	[5043] = dataList[223],
	[5044] = dataList[224],
	[5051] = dataList[225],
	[5052] = dataList[226],
	[5053] = dataList[227],
	[5054] = dataList[228],
	[5061] = dataList[229],
	[5062] = dataList[230],
	[5063] = dataList[231],
	[5064] = dataList[232],
	[5071] = dataList[233],
	[5072] = dataList[234],
	[5073] = dataList[235],
	[5074] = dataList[236],
	[5081] = dataList[237],
	[5082] = dataList[238],
	[5083] = dataList[239],
	[5084] = dataList[240],
	[5091] = dataList[241],
	[5092] = dataList[242],
	[5093] = dataList[243],
	[5094] = dataList[244],
	[5101] = dataList[245],
	[5102] = dataList[246],
	[5103] = dataList[247],
	[5104] = dataList[248],
	[5111] = dataList[249],
	[5112] = dataList[250],
	[5113] = dataList[251],
	[5114] = dataList[252],
	[5121] = dataList[253],
	[5122] = dataList[254],
	[5123] = dataList[255],
	[5124] = dataList[256],
	[5131] = dataList[257],
	[5132] = dataList[258],
	[5133] = dataList[259],
	[5134] = dataList[260],
	[6011] = dataList[261],
	[6012] = dataList[262],
	[6013] = dataList[263],
	[6014] = dataList[264],
	[6021] = dataList[265],
	[6022] = dataList[266],
	[6023] = dataList[267],
	[6024] = dataList[268],
	[6031] = dataList[269],
	[6032] = dataList[270],
	[6033] = dataList[271],
	[6034] = dataList[272],
	[6041] = dataList[273],
	[6042] = dataList[274],
	[6043] = dataList[275],
	[6044] = dataList[276],
	[6051] = dataList[277],
	[6052] = dataList[278],
	[6053] = dataList[279],
	[6054] = dataList[280],
	[6061] = dataList[281],
	[6062] = dataList[282],
	[6063] = dataList[283],
	[6064] = dataList[284],
	[6071] = dataList[285],
	[6072] = dataList[286],
	[6073] = dataList[287],
	[6074] = dataList[288],
	[6081] = dataList[289],
	[6082] = dataList[290],
	[6083] = dataList[291],
	[6084] = dataList[292],
	[6091] = dataList[293],
	[6092] = dataList[294],
	[6093] = dataList[295],
	[6094] = dataList[296],
	[6101] = dataList[297],
	[6102] = dataList[298],
	[6103] = dataList[299],
	[6104] = dataList[300],
	[6111] = dataList[301],
	[6112] = dataList[302],
	[6113] = dataList[303],
	[6114] = dataList[304],
	[6121] = dataList[305],
	[6122] = dataList[306],
	[6123] = dataList[307],
	[6124] = dataList[308],
	[6131] = dataList[309],
	[6132] = dataList[310],
	[6133] = dataList[311],
	[6134] = dataList[312],
	[7011] = dataList[313],
	[7012] = dataList[314],
	[7013] = dataList[315],
	[7014] = dataList[316],
	[7021] = dataList[317],
	[7022] = dataList[318],
	[7023] = dataList[319],
	[7024] = dataList[320],
	[7031] = dataList[321],
	[7032] = dataList[322],
	[7033] = dataList[323],
	[7034] = dataList[324],
	[7041] = dataList[325],
	[7042] = dataList[326],
	[7043] = dataList[327],
	[7044] = dataList[328],
	[7051] = dataList[329],
	[7052] = dataList[330],
	[7053] = dataList[331],
	[7054] = dataList[332],
	[7061] = dataList[333],
	[7062] = dataList[334],
	[7063] = dataList[335],
	[7064] = dataList[336],
	[7071] = dataList[337],
	[7072] = dataList[338],
	[7073] = dataList[339],
	[7074] = dataList[340],
	[7081] = dataList[341],
	[7082] = dataList[342],
	[7083] = dataList[343],
	[7084] = dataList[344],
	[7091] = dataList[345],
	[7092] = dataList[346],
	[7093] = dataList[347],
	[7094] = dataList[348],
	[7101] = dataList[349],
	[7102] = dataList[350],
	[7103] = dataList[351],
	[7104] = dataList[352],
	[7111] = dataList[353],
	[7112] = dataList[354],
	[7113] = dataList[355],
	[7114] = dataList[356],
	[7121] = dataList[357],
	[7122] = dataList[358],
	[7123] = dataList[359],
	[7124] = dataList[360],
	[7131] = dataList[361],
	[7132] = dataList[362],
	[7133] = dataList[363],
	[7134] = dataList[364],
	[8011] = dataList[365],
	[8012] = dataList[366],
	[8013] = dataList[367],
	[8014] = dataList[368],
	[8021] = dataList[369],
	[8022] = dataList[370],
	[8023] = dataList[371],
	[8024] = dataList[372],
	[8031] = dataList[373],
	[8032] = dataList[374],
	[8033] = dataList[375],
	[8034] = dataList[376],
	[8041] = dataList[377],
	[8042] = dataList[378],
	[8043] = dataList[379],
	[8044] = dataList[380],
	[8051] = dataList[381],
	[8052] = dataList[382],
	[8053] = dataList[383],
	[8054] = dataList[384],
	[8061] = dataList[385],
	[8062] = dataList[386],
	[8063] = dataList[387],
	[8064] = dataList[388],
	[8071] = dataList[389],
	[8072] = dataList[390],
	[8073] = dataList[391],
	[8074] = dataList[392],
	[8081] = dataList[393],
	[8082] = dataList[394],
	[8083] = dataList[395],
	[8084] = dataList[396],
	[8091] = dataList[397],
	[8092] = dataList[398],
	[8093] = dataList[399],
	[8094] = dataList[400],
	[8101] = dataList[401],
	[8102] = dataList[402],
	[8103] = dataList[403],
	[8104] = dataList[404],
	[8111] = dataList[405],
	[8112] = dataList[406],
	[8113] = dataList[407],
	[8114] = dataList[408],
	[8121] = dataList[409],
	[8122] = dataList[410],
	[8123] = dataList[411],
	[8124] = dataList[412],
	[8131] = dataList[413],
	[8132] = dataList[414],
	[8133] = dataList[415],
	[8134] = dataList[416],
	[9011] = dataList[417],
	[9012] = dataList[418],
	[9013] = dataList[419],
	[9014] = dataList[420],
	[9021] = dataList[421],
	[9022] = dataList[422],
	[9023] = dataList[423],
	[9024] = dataList[424],
	[9031] = dataList[425],
	[9032] = dataList[426],
	[9033] = dataList[427],
	[9034] = dataList[428],
	[9041] = dataList[429],
	[9042] = dataList[430],
	[9043] = dataList[431],
	[9044] = dataList[432],
	[9051] = dataList[433],
	[9052] = dataList[434],
	[9053] = dataList[435],
	[9054] = dataList[436],
	[9061] = dataList[437],
	[9062] = dataList[438],
	[9063] = dataList[439],
	[9064] = dataList[440],
	[9071] = dataList[441],
	[9072] = dataList[442],
	[9073] = dataList[443],
	[9074] = dataList[444],
	[9081] = dataList[445],
	[9082] = dataList[446],
	[9083] = dataList[447],
	[9084] = dataList[448],
	[9091] = dataList[449],
	[9092] = dataList[450],
	[9093] = dataList[451],
	[9094] = dataList[452],
	[9101] = dataList[453],
	[9102] = dataList[454],
	[9103] = dataList[455],
	[9104] = dataList[456],
	[9111] = dataList[457],
	[9112] = dataList[458],
	[9113] = dataList[459],
	[9114] = dataList[460],
	[9121] = dataList[461],
	[9122] = dataList[462],
	[9123] = dataList[463],
	[9124] = dataList[464],
	[9131] = dataList[465],
	[9132] = dataList[466],
	[9133] = dataList[467],
	[9134] = dataList[468],
	[10011] = dataList[469],
	[10012] = dataList[470],
	[10013] = dataList[471],
	[10014] = dataList[472],
	[10021] = dataList[473],
	[10022] = dataList[474],
	[10023] = dataList[475],
	[10024] = dataList[476],
	[10031] = dataList[477],
	[10032] = dataList[478],
	[10033] = dataList[479],
	[10034] = dataList[480],
	[10041] = dataList[481],
	[10042] = dataList[482],
	[10043] = dataList[483],
	[10044] = dataList[484],
	[10051] = dataList[485],
	[10052] = dataList[486],
	[10053] = dataList[487],
	[10054] = dataList[488],
	[10061] = dataList[489],
	[10062] = dataList[490],
	[10063] = dataList[491],
	[10064] = dataList[492],
	[10071] = dataList[493],
	[10072] = dataList[494],
	[10073] = dataList[495],
	[10074] = dataList[496],
	[10081] = dataList[497],
	[10082] = dataList[498],
	[10083] = dataList[499],
	[10084] = dataList[500],
	[10091] = dataList[501],
	[10092] = dataList[502],
	[10093] = dataList[503],
	[10094] = dataList[504],
	[10101] = dataList[505],
	[10102] = dataList[506],
	[10103] = dataList[507],
	[10104] = dataList[508],
	[10111] = dataList[509],
	[10112] = dataList[510],
	[10113] = dataList[511],
	[10114] = dataList[512],
	[10121] = dataList[513],
	[10122] = dataList[514],
	[10123] = dataList[515],
	[10124] = dataList[516],
	[10131] = dataList[517],
	[10132] = dataList[518],
	[10133] = dataList[519],
	[10134] = dataList[520],
	[11011] = dataList[521],
	[11012] = dataList[522],
	[11013] = dataList[523],
	[11014] = dataList[524],
	[11021] = dataList[525],
	[11022] = dataList[526],
	[11023] = dataList[527],
	[11024] = dataList[528],
	[11031] = dataList[529],
	[11032] = dataList[530],
	[11033] = dataList[531],
	[11034] = dataList[532],
	[11041] = dataList[533],
	[11042] = dataList[534],
	[11043] = dataList[535],
	[11044] = dataList[536],
	[11051] = dataList[537],
	[11052] = dataList[538],
	[11053] = dataList[539],
	[11054] = dataList[540],
	[11061] = dataList[541],
	[11062] = dataList[542],
	[11063] = dataList[543],
	[11064] = dataList[544],
	[11071] = dataList[545],
	[11072] = dataList[546],
	[11073] = dataList[547],
	[11074] = dataList[548],
	[11081] = dataList[549],
	[11082] = dataList[550],
	[11083] = dataList[551],
	[11084] = dataList[552],
	[11091] = dataList[553],
	[11092] = dataList[554],
	[11093] = dataList[555],
	[11094] = dataList[556],
	[11101] = dataList[557],
	[11102] = dataList[558],
	[11103] = dataList[559],
	[11104] = dataList[560],
	[11111] = dataList[561],
	[11112] = dataList[562],
	[11113] = dataList[563],
	[11114] = dataList[564],
	[11121] = dataList[565],
	[11122] = dataList[566],
	[11123] = dataList[567],
	[11124] = dataList[568],
	[11131] = dataList[569],
	[11132] = dataList[570],
	[11133] = dataList[571],
	[11134] = dataList[572],
	[12011] = dataList[573],
	[12012] = dataList[574],
	[12013] = dataList[575],
	[12014] = dataList[576],
	[12021] = dataList[577],
	[12022] = dataList[578],
	[12023] = dataList[579],
	[12024] = dataList[580],
	[12031] = dataList[581],
	[12032] = dataList[582],
	[12033] = dataList[583],
	[12034] = dataList[584],
	[12041] = dataList[585],
	[12042] = dataList[586],
	[12043] = dataList[587],
	[12044] = dataList[588],
	[12051] = dataList[589],
	[12052] = dataList[590],
	[12053] = dataList[591],
	[12054] = dataList[592],
	[12061] = dataList[593],
	[12062] = dataList[594],
	[12063] = dataList[595],
	[12064] = dataList[596],
	[12071] = dataList[597],
	[12072] = dataList[598],
	[12073] = dataList[599],
	[12074] = dataList[600],
	[12081] = dataList[601],
	[12082] = dataList[602],
	[12083] = dataList[603],
	[12084] = dataList[604],
	[12091] = dataList[605],
	[12092] = dataList[606],
	[12093] = dataList[607],
	[12094] = dataList[608],
	[12101] = dataList[609],
	[12102] = dataList[610],
	[12103] = dataList[611],
	[12104] = dataList[612],
	[12111] = dataList[613],
	[12112] = dataList[614],
	[12113] = dataList[615],
	[12114] = dataList[616],
	[12121] = dataList[617],
	[12122] = dataList[618],
	[12123] = dataList[619],
	[12124] = dataList[620],
	[12131] = dataList[621],
	[12132] = dataList[622],
	[12133] = dataList[623],
	[12134] = dataList[624],
	[13011] = dataList[625],
	[13012] = dataList[626],
	[13013] = dataList[627],
	[13014] = dataList[628],
	[13021] = dataList[629],
	[13022] = dataList[630],
	[13023] = dataList[631],
	[13024] = dataList[632],
	[13031] = dataList[633],
	[13032] = dataList[634],
	[13033] = dataList[635],
	[13034] = dataList[636],
	[13041] = dataList[637],
	[13042] = dataList[638],
	[13043] = dataList[639],
	[13044] = dataList[640],
	[13051] = dataList[641],
	[13052] = dataList[642],
	[13053] = dataList[643],
	[13054] = dataList[644],
	[13061] = dataList[645],
	[13062] = dataList[646],
	[13063] = dataList[647],
	[13064] = dataList[648],
	[13071] = dataList[649],
	[13072] = dataList[650],
	[13073] = dataList[651],
	[13074] = dataList[652],
	[13081] = dataList[653],
	[13082] = dataList[654],
	[13083] = dataList[655],
	[13084] = dataList[656],
	[13091] = dataList[657],
	[13092] = dataList[658],
	[13093] = dataList[659],
	[13094] = dataList[660],
	[13101] = dataList[661],
	[13102] = dataList[662],
	[13103] = dataList[663],
	[13104] = dataList[664],
	[13111] = dataList[665],
	[13112] = dataList[666],
	[13113] = dataList[667],
	[13114] = dataList[668],
	[13121] = dataList[669],
	[13122] = dataList[670],
	[13123] = dataList[671],
	[13124] = dataList[672],
	[13131] = dataList[673],
	[13132] = dataList[674],
	[13133] = dataList[675],
	[13134] = dataList[676]
}

t_cute_pet_talent.dataList = dataList

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

return t_cute_pet_talent
