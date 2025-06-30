-- chunkname: @IQIGame\\Config\\CfgTimelineTable.lua

local CfgTimelineTable = {
	[1001] = {
		Id = 1001,
		timeline = "模拟tl（召唤）"
	},
	[1002] = {
		Id = 1002,
		HitType = 1,
		HitBindingType = 3,
		timeline = "模拟tl（全体AOE，单次同时伤害）"
	},
	[1003] = {
		Id = 1003,
		HitType = 2,
		HitBindingType = 2,
		timeline = "模拟tl（横排or纵列AOE，次序单次伤害）"
	},
	[1004] = {
		Id = 1004,
		HitType = 4,
		HitBindingType = 3,
		timeline = "模拟tl（多人AOE，多次同时伤害）"
	},
	[1001101] = {
		Id = 1001101,
		timeline = "Battle/Role/Hero/An/Sources/Timeline/TL_An_born"
	},
	[1001102] = {
		Id = 1001102,
		timeline = "Battle/Role/Hero/An/Sources/Timeline/TL_An_die"
	},
	[1001103] = {
		Id = 1001103,
		timeline = "Battle/Role/Hero/An/Sources/Timeline/TL_An_hit"
	},
	[1001104] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Hero/An/Sources/Timeline/TL_An_attack_1",
		Id = 1001104,
		HitBindingType = 1
	},
	[1001105] = {
		Id = 1001105,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/An/Sources/Timeline/TL_An_special_1",
		Cinemachine = "Battle/Role/Hero/An/Sources/Cinemachine/TL_An_special_1",
		HitBindingType = 1
	},
	[1001201] = {
		Id = 1001201,
		timeline = "Battle/Role/Hero/An_Skin_01/Sources/Timeline/TL_An_Skin_01_born"
	},
	[1001202] = {
		Id = 1001202,
		timeline = "Battle/Role/Hero/An_Skin_01/Sources/Timeline/TL_An_Skin_01_die"
	},
	[1001204] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Hero/An_Skin_01/Sources/Timeline/TL_An_Skin_01_attack_1",
		Id = 1001204,
		HitBindingType = 1
	},
	[1001205] = {
		Id = 1001205,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/An_Skin_01/Sources/Timeline/TL_An_Skin_01_special_1",
		Cinemachine = "Battle/Role/Hero/An_Skin_01/Sources/Cinemachine/TL_An_Skin_01_special_1",
		HitBindingType = 1
	},
	[1001301] = {
		Id = 1001301,
		timeline = "Battle/Role/Hero/An_Skin_02/Sources/Timeline/TL_An_Skin_02_born"
	},
	[1001302] = {
		Id = 1001302,
		timeline = "Battle/Role/Hero/An_Skin_02/Sources/Timeline/TL_An_Skin_02_die"
	},
	[1001304] = {
		ForceHitTarget = true,
		HitType = 4,
		timeline = "Battle/Role/Hero/An_Skin_02/Sources/Timeline/TL_An_Skin_02_attack_1",
		Id = 1001304,
		HitBindingType = 1
	},
	[1001305] = {
		Id = 1001305,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/Hero/An_Skin_02/Sources/Timeline/TL_An_Skin_02_special_1",
		Cinemachine = "Battle/Role/Hero/An_Skin_02/Sources/Cinemachine/TL_An_Skin_02_special_1",
		ForceHitTarget = true,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[1002101] = {
		Id = 1002101,
		timeline = "Battle/Role/Hero/LongSS/Sources/Timeline/TL_LongSS_born"
	},
	[1002102] = {
		Id = 1002102,
		timeline = "Battle/Role/Hero/LongSS/Sources/Timeline/TL_LongSS_die"
	},
	[1002103] = {
		Id = 1002103,
		HitType = 1,
		HitBindingType = 1,
		timeline = "Battle/Role/Hero/LongSS/Sources/Timeline/TL_LongSS_hit"
	},
	[1002104] = {
		Id = 1002104,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Hero/LongSS/Sources/Timeline/TL_LongSS_attack_1"
	},
	[1002105] = {
		Id = 1002105,
		IsHideTile = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/LongSS/Sources/Timeline/TL_LongSS_special_1",
		Cinemachine = "Battle/Role/Hero/LongSS/Sources/Cinemachine/TL_LongSS_special_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1003101] = {
		Id = 1003101,
		timeline = "Battle/Role/Hero/Fei/Sources/Timeline/TL_Fei_born"
	},
	[1003102] = {
		Id = 1003102,
		timeline = "Battle/Role/Hero/Fei/Sources/Timeline/TL_Fei_die"
	},
	[1003103] = {
		Id = 1003103,
		timeline = "Battle/Role/Hero/Fei/Sources/Timeline/TL_Fei_hit"
	},
	[1003104] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Hero/Fei/Sources/Timeline/TL_Fei_attack_1",
		Id = 1003104,
		HitBindingType = 1
	},
	[1003105] = {
		Id = 1003105,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/Fei/Sources/Timeline/TL_Fei_special_1",
		Cinemachine = "Battle/Role/Hero/Fei/Sources/Cinemachine/TL_Fei_special_1",
		HitBindingType = 1
	},
	[1004101] = {
		Id = 1004101,
		timeline = "Battle/Role/Hero/NanXS/Sources/Timeline/TL_NanXS_born"
	},
	[1004102] = {
		Id = 1004102,
		timeline = "Battle/Role/Hero/NanXS/Sources/Timeline/TL_NanXS_die"
	},
	[1004103] = {
		Id = 1004103,
		timeline = "Battle/Role/Hero/NanXS/Sources/Timeline/TL_NanXS_hit"
	},
	[1004104] = {
		Id = 1004104,
		HitType = 6,
		timeline = "Battle/Role/Hero/NanXS/Sources/Timeline/TL_NanXS_attack_1"
	},
	[1004105] = {
		Id = 1004105,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/NanXS/Sources/Timeline/TL_NanXS_special_1",
		Cinemachine = "Battle/Role/Hero/NanXS/Sources/Cinemachine/TL_NanXS_special_1",
		HitBindingType = 1
	},
	[1005101] = {
		Id = 1005101,
		ForceHitTarget = true,
		timeline = "Battle/Role/Hero/YinFT/Sources/Timeline/TL_YinFT_born"
	},
	[1005102] = {
		Id = 1005102,
		timeline = "Battle/Role/Hero/YinFT/Sources/Timeline/TL_YinFT_die"
	},
	[1005103] = {
		Id = 1005103,
		timeline = "Battle/Role/Hero/YinFT/Sources/Timeline/TL_YinFT_hit"
	},
	[1005104] = {
		Id = 1005104,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Hero/YinFT/Sources/Timeline/TL_YinFT_attack_1"
	},
	[1005105] = {
		Id = 1005105,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Hero/YinFT/Sources/Timeline/TL_YinFT_special_1",
		Cinemachine = "Battle/Role/Hero/YinFT/Sources/Cinemachine/TL_YinFT_special_1",
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1006101] = {
		Id = 1006101,
		timeline = "Battle/Role/Hero/Bai/Sources/Timeline/TL_Bai_born"
	},
	[1006102] = {
		Id = 1006102,
		timeline = "Battle/Role/Hero/Bai/Sources/Timeline/TL_Bai_die"
	},
	[1006103] = {
		Id = 1006103,
		timeline = "Battle/Role/Hero/Bai/Sources/Timeline/TL_Bai_hit"
	},
	[1006104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Hero/Bai/Sources/Timeline/TL_Bai_attack_1",
		Id = 1006104,
		HitBindingType = 1
	},
	[1006105] = {
		Id = 1006105,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Hero/Bai/Sources/Timeline/TL_Bai_special_1",
		Cinemachine = "Battle/Role/Hero/Bai/Sources/Cinemachine/TL_Bai_special_1",
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1007101] = {
		Id = 1007101,
		timeline = "Battle/Role/Hero/KanJYL/Sources/Timeline/TL_KanJYL_born"
	},
	[1007102] = {
		Id = 1007102,
		timeline = "Battle/Role/Hero/KanJYL/Sources/Timeline/TL_KanJYL_die"
	},
	[1007103] = {
		Id = 1007103,
		timeline = "Battle/Role/Hero/KanJYL/Sources/Timeline/TL_KanJYL_hit"
	},
	[1007104] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Hero/KanJYL/Sources/Timeline/TL_KanJYL_attack_1",
		Id = 1007104,
		HitBindingType = 4
	},
	[1007105] = {
		Id = 1007105,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Hero/KanJYL/Sources/Timeline/TL_KanJYL_special_1",
		Cinemachine = "Battle/Role/Hero/KanJYL/Sources/Cinemachine/TL_KanJYL_special_1",
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1008101] = {
		Id = 1008101,
		timeline = "Battle/Role/Hero/YuM/Sources/Timeline/TL_YuM_born"
	},
	[1008102] = {
		Id = 1008102,
		timeline = "Battle/Role/Hero/YuM/Sources/Timeline/TL_YuM_die"
	},
	[1008103] = {
		Id = 1008103,
		timeline = "Battle/Role/Hero/YuM/Sources/Timeline/TL_YuM_hit"
	},
	[1008104] = {
		Id = 1008104,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Hero/YuM/Sources/Timeline/TL_YuM_attack_1"
	},
	[1008105] = {
		Id = 1008105,
		HitType = 1,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/YuM/Sources/Timeline/TL_YuM_special_1",
		Cinemachine = "Battle/Role/Hero/YuM/Sources/Cinemachine/TL_YuM_special_1",
		HitBindingType = 1
	},
	[1009101] = {
		Id = 1009101,
		timeline = "Battle/Role/Hero/BoZ/Sources/Timeline/TL_BoZ_born"
	},
	[1009102] = {
		Id = 1009102,
		timeline = "Battle/Role/Hero/BoZ/Sources/Timeline/TL_BoZ_die"
	},
	[1009103] = {
		Id = 1009103,
		timeline = "Battle/Role/Hero/BoZ/Sources/Timeline/TL_BoZ_hit"
	},
	[1009104] = {
		Id = 1009104,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Hero/BoZ/Sources/Timeline/TL_BoZ_attack_1"
	},
	[1009105] = {
		Id = 1009105,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Hero/BoZ/Sources/Timeline/TL_BoZ_special_1",
		Cinemachine = "Battle/Role/Hero/BoZ/Sources/Cinemachine/TL_BoZ_special_1",
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1009201] = {
		Id = 1009201,
		timeline = "Battle/Role/Hero/BoZ_Skin_01/Sources/Timeline/TL_BoZ_Skin_01_born"
	},
	[1009202] = {
		Id = 1009202,
		timeline = "Battle/Role/Hero/BoZ_Skin_01/Sources/Timeline/TL_BoZ_Skin_01_die"
	},
	[1009204] = {
		Id = 1009204,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Hero/BoZ_Skin_01/Sources/Timeline/TL_BoZ_Skin_01_attack_1"
	},
	[1009205] = {
		Id = 1009205,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/Hero/BoZ_Skin_01/Sources/Timeline/TL_BoZ_Skin_01_special_1",
		Cinemachine = "Battle/Role/Hero/BoZ_Skin_01/Sources/Cinemachine/TL_BoZ_Skin_01_special_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1010101] = {
		Id = 1010101,
		timeline = "Battle/Role/Hero/Huan/Sources/Timeline/TL_Huan_born"
	},
	[1010102] = {
		Id = 1010102,
		timeline = "Battle/Role/Hero/Huan/Sources/Timeline/TL_Huan_die"
	},
	[1010103] = {
		Id = 1010103,
		timeline = "Battle/Role/Hero/Huan/Sources/Timeline/TL_Huan_hit"
	},
	[1010104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Hero/Huan/Sources/Timeline/TL_Huan_attack_1",
		Id = 1010104,
		HitBindingType = 1
	},
	[1010105] = {
		Id = 1010105,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/Huan/Sources/Timeline/TL_Huan_special_1",
		Cinemachine = "Battle/Role/Hero/Huan/Sources/Cinemachine/TL_Huan_special_1",
		HitBindingType = 2
	},
	[1011101] = {
		Id = 1011101,
		timeline = "Battle/Role/Hero/He/Sources/Timeline/TL_He_born"
	},
	[1011102] = {
		Id = 1011102,
		timeline = "Battle/Role/Hero/He/Sources/Timeline/TL_He_die"
	},
	[1011103] = {
		Id = 1011103,
		timeline = "Battle/Role/Hero/He/Sources/Timeline/TL_He_hit"
	},
	[1011104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Hero/He/Sources/Timeline/TL_He_attack_1",
		Id = 1011104,
		HitBindingType = 1
	},
	[1011105] = {
		Id = 1011105,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/He/Sources/Timeline/TL_He_special_1",
		Cinemachine = "Battle/Role/Hero/He/Sources/Cinemachine/TL_He_special_1",
		HitBindingType = 1
	},
	[1012101] = {
		Id = 1012101,
		timeline = "Battle/Role/Hero/LiuLY/Sources/Timeline/TL_LiuLY_born"
	},
	[1012102] = {
		Id = 1012102,
		timeline = "Battle/Role/Hero/LiuLY/Sources/Timeline/TL_LiuLY_die"
	},
	[1012103] = {
		Id = 1012103,
		timeline = "Battle/Role/Hero/LiuLY/Sources/Timeline/TL_LiuLY_hit"
	},
	[1012104] = {
		Id = 1012104,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Hero/LiuLY/Sources/Timeline/TL_LiuLY_attack_1"
	},
	[1012105] = {
		Id = 1012105,
		HitType = 1,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/LiuLY/Sources/Timeline/TL_LiuLY_special_1",
		Cinemachine = "Battle/Role/Hero/LiuLY/Sources/Cinemachine/TL_LiuLY_special_1",
		HitBindingType = 3
	},
	[1013101] = {
		Id = 1013101,
		timeline = "Battle/Role/Hero/Liao/Sources/Timeline/TL_Liao_born"
	},
	[1013102] = {
		Id = 1013102,
		timeline = "Battle/Role/Hero/Liao/Sources/Timeline/TL_Liao_die"
	},
	[1013103] = {
		Id = 1013103,
		timeline = "Battle/Role/Hero/Liao/Sources/Timeline/TL_Liao_hit"
	},
	[1013104] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Hero/Liao/Sources/Timeline/TL_Liao_attack_1",
		Id = 1013104,
		HitBindingType = 1
	},
	[1013105] = {
		Id = 1013105,
		HitType = 1,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/Liao/Sources/Timeline/TL_Liao_special_1",
		Cinemachine = "Battle/Role/Hero/Liao/Sources/Cinemachine/TL_Liao_special_1",
		HitBindingType = 1
	},
	[1014101] = {
		Id = 1014101,
		timeline = "Battle/Role/Hero/YouS/Sources/Timeline/TL_YouS_born"
	},
	[1014102] = {
		Id = 1014102,
		timeline = "Battle/Role/Hero/YouS/Sources/Timeline/TL_YouS_die"
	},
	[1014103] = {
		Id = 1014103,
		timeline = "Battle/Role/Hero/YouS/Sources/Timeline/TL_YouS_hit"
	},
	[1014104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Hero/YouS/Sources/Timeline/TL_YouS_attack_1",
		Id = 1014104,
		HitBindingType = 1
	},
	[1014105] = {
		Id = 1014105,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/YouS/Sources/Timeline/TL_YouS_special_1",
		Cinemachine = "Battle/Role/Hero/YouS/Sources/Cinemachine/TL_YouS_special_1",
		HitBindingType = 1
	},
	[1015101] = {
		Id = 1015101,
		timeline = "Battle/Role/Hero/SiY/Sources/Timeline/TL_SiY_born"
	},
	[1015102] = {
		Id = 1015102,
		timeline = "Battle/Role/Hero/SiY/Sources/Timeline/TL_SiY_die"
	},
	[1015103] = {
		Id = 1015103,
		timeline = "Battle/Role/Hero/SiY/Sources/Timeline/TL_SiY_hit"
	},
	[1015104] = {
		Id = 1015104,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Hero/SiY/Sources/Timeline/TL_SiY_attack_1"
	},
	[1015105] = {
		Id = 1015105,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Hero/SiY/Sources/Timeline/TL_SiY_special_1",
		Cinemachine = "Battle/Role/Hero/SiY/Sources/Cinemachine/TL_SiY_special_1",
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1016101] = {
		Id = 1016101,
		CloseRoleEffect = true,
		timeline = "Battle/Role/Hero/WuN/Sources/Timeline/TL_WuN_born"
	},
	[1016102] = {
		Id = 1016102,
		CloseRoleEffect = true,
		timeline = "Battle/Role/Hero/WuN/Sources/Timeline/TL_WuN_die"
	},
	[1016103] = {
		Id = 1016103,
		CloseRoleEffect = true,
		timeline = "Battle/Role/Hero/WuN/Sources/Timeline/TL_WuN_hit"
	},
	[1016104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Hero/WuN/Sources/Timeline/TL_WuN_attack_1",
		Id = 1016104,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[1016105] = {
		Id = 1016105,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Hero/WuN/Sources/Timeline/TL_WuN_special_1",
		Cinemachine = "Battle/Role/Hero/WuN/Sources/Cinemachine/TL_WuN_special_1",
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1016204] = {
		HitType = 1,
		timeline = "Battle/Role/Hero/WuN/Sources/Timeline/TL_WuN_Skin_01_attack_1",
		Id = 1016204,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1016205] = {
		Id = 1016205,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/Hero/WuN/Sources/Timeline/TL_WuN_Skin_01_special_1",
		Cinemachine = "Battle/Role/Hero/WuN/Sources/Cinemachine/TL_WuN_special_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1017101] = {
		Id = 1017101,
		timeline = "Battle/Role/Hero/Zhao/Sources/Timeline/TL_Zhao_born"
	},
	[1017102] = {
		Id = 1017102,
		timeline = "Battle/Role/Hero/Zhao/Sources/Timeline/TL_Zhao_die"
	},
	[1017103] = {
		Id = 1017103,
		timeline = "Battle/Role/Hero/Zhao/Sources/Timeline/TL_Zhao_hit"
	},
	[1017104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Hero/Zhao/Sources/Timeline/TL_Zhao_attack_1",
		Id = 1017104,
		HitBindingType = 1
	},
	[1017105] = {
		Id = 1017105,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Hero/Zhao/Sources/Timeline/TL_Zhao_special_1",
		Cinemachine = "Battle/Role/Hero/Zhao/Sources/Cinemachine/TL_Zhao_special_1",
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1018101] = {
		Id = 1018101,
		timeline = "Battle/Role/Hero/Shun/Sources/Timeline/TL_Shun_born"
	},
	[1018102] = {
		Id = 1018102,
		timeline = "Battle/Role/Hero/Shun/Sources/Timeline/TL_Shun_die"
	},
	[1018103] = {
		Id = 1018103,
		timeline = "Battle/Role/Hero/Shun/Sources/Timeline/TL_Shun_hit"
	},
	[1018104] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Hero/Shun/Sources/Timeline/TL_Shun_attack_1",
		Id = 1018104,
		HitBindingType = 1
	},
	[1018105] = {
		Id = 1018105,
		HitType = 1,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/Shun/Sources/Timeline/TL_Shun_special_1",
		Cinemachine = "Battle/Role/Hero/Shun/Sources/Cinemachine/TL_Shun_special_1",
		HitBindingType = 1
	},
	[1019101] = {
		Id = 1019101,
		timeline = "Battle/Role/Hero/ZhuY/Sources/Timeline/TL_ZhuY_born"
	},
	[1019102] = {
		Id = 1019102,
		timeline = "Battle/Role/Hero/ZhuY/Sources/Timeline/TL_ZhuY_die"
	},
	[1019103] = {
		Id = 1019103,
		timeline = "Battle/Role/Hero/ZhuY/Sources/Timeline/TL_ZhuY_hit"
	},
	[1019104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Hero/ZhuY/Sources/Timeline/TL_ZhuY_attack_1",
		Id = 1019104,
		HitBindingType = 1
	},
	[1019105] = {
		Id = 1019105,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/ZhuY/Sources/Timeline/TL_ZhuY_special_1",
		Cinemachine = "Battle/Role/Hero/ZhuY/Sources/Cinemachine/TL_ZhuY_special_1",
		HitBindingType = 4
	},
	[1020101] = {
		Id = 1020101,
		timeline = "Battle/Role/Hero/ChunRX/Sources/Timeline/TL_ChunRX_born"
	},
	[1020102] = {
		Id = 1020102,
		timeline = "Battle/Role/Hero/ChunRX/Sources/Timeline/TL_ChunRX_die"
	},
	[1020103] = {
		Id = 1020103,
		timeline = "Battle/Role/Hero/ChunRX/Sources/Timeline/TL_ChunRX_hit"
	},
	[1020104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Hero/ChunRX/Sources/Timeline/TL_ChunRX_attack_1",
		Id = 1020104,
		HitBindingType = 1
	},
	[1020105] = {
		Id = 1020105,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/ChunRX/Sources/Timeline/TL_ChunRX_special_1",
		Cinemachine = "Battle/Role/Hero/ChunRX/Sources/Cinemachine/TL_ChunRX_special_1",
		HitBindingType = 2
	},
	[1021101] = {
		Id = 1021101,
		timeline = "Battle/Role/Hero/Ling/Sources/Timeline/TL_Ling_born"
	},
	[1021102] = {
		Id = 1021102,
		timeline = "Battle/Role/Hero/Ling/Sources/Timeline/TL_Ling_die"
	},
	[1021103] = {
		Id = 1021103,
		timeline = "Battle/Role/Hero/Ling/Sources/Timeline/TL_Ling_hit"
	},
	[1021104] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Hero/Ling/Sources/Timeline/TL_Ling_attack_1",
		Id = 1021104,
		HitBindingType = 1
	},
	[1021105] = {
		Id = 1021105,
		IsHideTile = true,
		MaskType = 1,
		timeline = "Battle/Role/Hero/Ling/Sources/Timeline/TL_Ling_special_1",
		Cinemachine = "Battle/Role/Hero/Ling/Sources/Cinemachine/TL_Ling_special_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1022101] = {
		Id = 1022101,
		timeline = "Battle/Role/Hero/Kui/Sources/Timeline/TL_Kui_born"
	},
	[1022102] = {
		Id = 1022102,
		timeline = "Battle/Role/Hero/Kui/Sources/Timeline/TL_Kui_die"
	},
	[1022103] = {
		Id = 1022103,
		timeline = "Battle/Role/Hero/Kui/Sources/Timeline/TL_Kui_hit"
	},
	[1022104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Hero/Kui/Sources/Timeline/TL_Kui_attack_1",
		Id = 1022104,
		HitBindingType = 1
	},
	[1022105] = {
		Id = 1022105,
		HitType = 1,
		MaskType = 1,
		timeline = "Battle/Role/Hero/Kui/Sources/Timeline/TL_Kui_special_1",
		Cinemachine = "Battle/Role/Hero/Kui/Sources/Cinemachine/TL_Kui_special_1",
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1023101] = {
		Id = 1023101,
		timeline = "Battle/Role/Hero/HeiT/Sources/Timeline/TL_HeiT_born"
	},
	[1023102] = {
		Id = 1023102,
		timeline = "Battle/Role/Hero/HeiT/Sources/Timeline/TL_HeiT_die"
	},
	[1023103] = {
		Id = 1023103,
		timeline = "Battle/Role/Hero/HeiT/Sources/Timeline/TL_HeiT_hit"
	},
	[1023104] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Hero/HeiT/Sources/Timeline/TL_HeiT_attack_1",
		Id = 1023104,
		HitBindingType = 1
	},
	[1023105] = {
		Id = 1023105,
		HitType = 1,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/HeiT/Sources/Timeline/TL_HeiT_special_1",
		Cinemachine = "Battle/Role/Hero/HeiT/Sources/Cinemachine/TL_HeiT_special_1",
		HitBindingType = 1
	},
	[1024101] = {
		Id = 1024101,
		timeline = "Battle/Role/Hero/YaY/Sources/Timeline/TL_YaY_born"
	},
	[1024102] = {
		Id = 1024102,
		timeline = "Battle/Role/Hero/YaY/Sources/Timeline/TL_YaY_die"
	},
	[1024103] = {
		Id = 1024103,
		timeline = "Battle/Role/Hero/YaY/Sources/Timeline/TL_YaY_hit"
	},
	[1024104] = {
		Id = 1024104,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Hero/YaY/Sources/Timeline/TL_YaY_attack_1"
	},
	[1024105] = {
		Id = 1024105,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/YaY/Sources/Timeline/TL_YaY_special_1",
		Cinemachine = "Battle/Role/Hero/YaY/Sources/Cinemachine/TL_YaY_special_1",
		HitBindingType = 2
	},
	[1025101] = {
		Id = 1025101,
		timeline = "Battle/Role/Hero/Bei/Sources/Timeline/TL_Bei_born"
	},
	[1025102] = {
		Id = 1025102,
		timeline = "Battle/Role/Hero/Bei/Sources/Timeline/TL_Bei_die"
	},
	[1025103] = {
		Id = 1025103,
		timeline = "Battle/Role/Hero/Bei/Sources/Timeline/TL_Bei_hit"
	},
	[1025104] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Hero/Bei/Sources/Timeline/TL_Bei_attack_1",
		Id = 1025104,
		HitBindingType = 1
	},
	[1025105] = {
		Id = 1025105,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/Bei/Sources/Timeline/TL_Bei_special_1",
		Cinemachine = "Battle/Role/Hero/Bei/Sources/Cinemachine/TL_Bei_special_1",
		HitBindingType = 1
	},
	[1026101] = {
		Id = 1026101,
		timeline = "Battle/Role/Hero/BeiTND/Sources/Timeline/TL_BeiTND_born"
	},
	[1026102] = {
		Id = 1026102,
		timeline = "Battle/Role/Hero/BeiTND/Sources/Timeline/TL_BeiTND_die"
	},
	[1026103] = {
		Id = 1026103,
		timeline = "Battle/Role/Hero/BeiTND/Sources/Timeline/TL_BeiTND_hit"
	},
	[1026104] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Hero/BeiTND/Sources/Timeline/TL_BeiTND_attack_1",
		Id = 1026104,
		HitBindingType = 1
	},
	[1026105] = {
		Id = 1026105,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/BeiTND/Sources/Timeline/TL_BeiTND_special_1",
		Cinemachine = "Battle/Role/Hero/BeiTND/Sources/Cinemachine/TL_BeiTND_special_1",
		HitBindingType = 1
	},
	[1027101] = {
		Id = 1027101,
		timeline = "Battle/Role/Hero/On/Sources/Timeline/TL_On_born"
	},
	[1027102] = {
		Id = 1027102,
		timeline = "Battle/Role/Hero/On/Sources/Timeline/TL_On_die"
	},
	[1027103] = {
		Id = 1027103,
		timeline = "Battle/Role/Hero/On/Sources/Timeline/TL_On_hit"
	},
	[1027104] = {
		Id = 1027104,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Hero/On/Sources/Timeline/TL_On_attack_1"
	},
	[1027105] = {
		Id = 1027105,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Hero/On/Sources/Timeline/TL_On_special_1",
		Cinemachine = "Battle/Role/Hero/On/Sources/Cinemachine/TL_On_special_1",
		IsHideTile = true,
		CloseRoleEffect = true
	},
	[1028101] = {
		Id = 1028101,
		timeline = "Battle/Role/Hero/JuYY/Sources/Timeline/TL_JuYY_born"
	},
	[1028102] = {
		Id = 1028102,
		timeline = "Battle/Role/Hero/JuYY/Sources/Timeline/TL_JuYY_die"
	},
	[1028103] = {
		Id = 1028103
	},
	[1028104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Hero/JuYY/Sources/Timeline/TL_JuYY_attack_1",
		Id = 1028104,
		HitBindingType = 1
	},
	[1028105] = {
		Id = 1028105,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Hero/JuYY/Sources/Timeline/TL_JuYY_special_1",
		Cinemachine = "Battle/Role/Hero/JuYY/Sources/Cinemachine/TL_JuYY_special_1",
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1028111] = {
		Id = 1028111,
		timeline = "Battle/Role/Hero/Summon_DieW/Sources/Timeline/TL_Summon_DieW_born"
	},
	[1028112] = {
		Id = 1028112,
		timeline = "Battle/Role/Hero/Summon_DieW/Sources/Timeline/TL_Summon_DieW_die"
	},
	[1028114] = {
		Id = 1028114,
		HitType = 1,
		timeline = "Battle/Role/Hero/Summon_DieW/Sources/Timeline/TL_Summon_DieW_skill"
	},
	[1029101] = {
		Id = 1029101,
		timeline = "Battle/Role/Hero/Bao/Sources/Timeline/TL_Bao_born"
	},
	[1029102] = {
		Id = 1029102,
		timeline = "Battle/Role/Hero/Bao/Sources/Timeline/TL_Bao_die"
	},
	[1029103] = {
		Id = 1029103,
		HitType = 1,
		HitBindingType = 1,
		timeline = "Battle/Role/Hero/Bao/Sources/Timeline/TL_Bao_hit"
	},
	[1029104] = {
		Id = 1029104,
		HitType = 6,
		ForceHitTarget = true,
		timeline = "Battle/Role/Hero/Bao/Sources/Timeline/TL_Bao_attack_1"
	},
	[1029105] = {
		Id = 1029105,
		IsHideTile = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/Bao/Sources/Timeline/TL_Bao_special_1",
		Cinemachine = "Battle/Role/Hero/Bao/Sources/Cinemachine/TL_Bao_special_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1030101] = {
		Id = 1030101,
		timeline = "Battle/Role/Hero/XiaoW/Sources/Timeline/TL_XiaoW_born"
	},
	[1030102] = {
		Id = 1030102,
		timeline = "Battle/Role/Hero/XiaoW/Sources/Timeline/TL_XiaoW_die"
	},
	[1030103] = {
		Id = 1030103
	},
	[1030104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Hero/XiaoW/Sources/Timeline/TL_XiaoW_attack_1",
		Id = 1030104,
		HitBindingType = 1
	},
	[1030105] = {
		Id = 1030105,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/XiaoW/Sources/Timeline/TL_XiaoW_special_1",
		Cinemachine = "Battle/Role/Hero/XiaoW/Sources/Cinemachine/TL_XiaoW_special_1",
		HitBindingType = 1
	},
	[1031101] = {
		Id = 1031101,
		timeline = "Battle/Role/Hero/ZhuYu/Sources/Timeline/TL_ZhuYu_born"
	},
	[1031102] = {
		Id = 1031102,
		timeline = "Battle/Role/Hero/ZhuYu/Sources/Timeline/TL_ZhuYu_die"
	},
	[1031103] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Hero/ZhuYu/Sources/Timeline/TL_ZhuYu_attack_1",
		Id = 1031103,
		HitBindingType = 1
	},
	[1031104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Hero/ZhuYu/Sources/Timeline/TL_ZhuYu_attack_2",
		Id = 1031104,
		HitBindingType = 1
	},
	[1031105] = {
		Id = 1031105,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/ZhuYu/Sources/Timeline/TL_ZhuYu_special_1",
		Cinemachine = "Battle/Role/Hero/ZhuYu/Sources/Cinemachine/TL_ZhuYu_special_1",
		HitBindingType = 1
	},
	[1032101] = {
		Id = 1032101,
		timeline = "Battle/Role/Hero/Ying/Sources/Timeline/TL_Ying_born"
	},
	[1032102] = {
		Id = 1032102,
		timeline = "Battle/Role/Hero/Ying/Sources/Timeline/TL_Ying_die"
	},
	[1032103] = {
		Id = 1032103,
		HitType = 1,
		HitBindingType = 1,
		ForceHitTarget = true
	},
	[1032104] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Hero/Ying/Sources/Timeline/TL_Ying_attack_1",
		Id = 1032104,
		HitBindingType = 1
	},
	[1032105] = {
		Id = 1032105,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/Ying/Sources/Timeline/TL_Ying_special_1",
		Cinemachine = "Battle/Role/Hero/Ying/Sources/Cinemachine/TL_Ying_special_1",
		HitBindingType = 1
	},
	[1033101] = {
		Id = 1033101,
		timeline = "Battle/Role/Hero/JiuBJJY/Sources/Timeline/TL_JiuBJJY_born"
	},
	[1033102] = {
		Id = 1033102,
		timeline = "Battle/Role/Hero/JiuBJJY/Sources/Timeline/TL_JiuBJJY_die"
	},
	[1033103] = {
		Id = 1033103,
		HitType = 1,
		HitBindingType = 1,
		ForceHitTarget = true
	},
	[1033104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Hero/JiuBJJY/Sources/Timeline/TL_JiuBJJY_attack_1",
		Id = 1033104,
		HitBindingType = 1
	},
	[1033105] = {
		Id = 1033105,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Hero/JiuBJJY/Sources/Timeline/TL_JiuBJJY_special_1",
		Cinemachine = "Battle/Role/Hero/JiuBJJY/Sources/Cinemachine/TL_JiuBJJY_special_1",
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[1034101] = {
		Id = 1034101,
		timeline = "Battle/Role/Hero/YiCQ/Sources/Timeline/TL_YiCQ_born"
	},
	[1034102] = {
		Id = 1034102,
		timeline = "Battle/Role/Hero/YiCQ/Sources/Timeline/TL_YiCQ_die"
	},
	[1034103] = {
		Id = 1034103
	},
	[1034104] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Hero/YiCQ/Sources/Timeline/TL_YiCQ_attack_1",
		Id = 1034104,
		HitBindingType = 1
	},
	[1034105] = {
		Id = 1034105,
		HitType = 6,
		IsHideTile = true,
		ForceHitTarget = true,
		CloseRoleEffect = true,
		MaskType = 4,
		timeline = "Battle/Role/Hero/YiCQ/Sources/Timeline/TL_YiCQ_special_1",
		Cinemachine = "Battle/Role/Hero/YiCQ/Sources/Cinemachine/TL_YiCQ_special_1",
		HitBindingType = 1
	},
	[1034111] = {
		Id = 1034111,
		timeline = "Battle/Role/Hero/Summon_GuaG/Sources/Timeline/TL_Summon_GuaG_born"
	},
	[1034112] = {
		Id = 1034112,
		timeline = "Battle/Role/Hero/Summon_GuaG/Sources/Timeline/TL_Summon_GuaG_die"
	},
	[1034114] = {
		Id = 1034114,
		ForceHitTarget = true,
		timeline = "Battle/Role/Hero/Summon_GuaG/Sources/Timeline/TL_Summon_GuaG_skill"
	},
	[10110101] = {
		Id = 10110101,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_born"
	},
	[10110102] = {
		Id = 10110102,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_die"
	},
	[10110103] = {
		Id = 10110103,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_die"
	},
	[10110104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_attack_1",
		Id = 10110104,
		HitBindingType = 1
	},
	[10120101] = {
		Id = 10120101,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_born"
	},
	[10120102] = {
		Id = 10120102,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_die"
	},
	[10120103] = {
		Id = 10120103,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_die"
	},
	[10120104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_attack_1",
		Id = 10120104,
		HitBindingType = 1
	},
	[10120105] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_skill_1",
		Id = 10120105,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10120201] = {
		Id = 10120201,
		timeline = "Battle/Role/Monster/PingAY_S/Sources/Timeline/TL_PingAY_S_born"
	},
	[10120202] = {
		Id = 10120202,
		timeline = "Battle/Role/Monster/PingAY_S/Sources/Timeline/TL_PingAY_S_die"
	},
	[10120203] = {
		Id = 10120203,
		timeline = "Battle/Role/Monster/PingAY_S/Sources/Timeline/TL_PingAY_S_die"
	},
	[10120204] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Monster/PingAY_S/Sources/Timeline/TL_PingAY_S_attack_1",
		Id = 10120204,
		HitBindingType = 1
	},
	[10120205] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Monster/PingAY_S/Sources/Timeline/TL_PingAY_S_skill_1",
		Id = 10120205,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10120301] = {
		Id = 10120301,
		timeline = "Battle/Role/Monster/PingAY_Z/Sources/Timeline/TL_PingAY_Z_born"
	},
	[10120302] = {
		Id = 10120302,
		timeline = "Battle/Role/Monster/PingAY_Z/Sources/Timeline/TL_PingAY_Z_die"
	},
	[10120303] = {
		Id = 10120303,
		timeline = "Battle/Role/Monster/PingAY_Z/Sources/Timeline/TL_PingAY_Z_die"
	},
	[10120304] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/PingAY_Z/Sources/Timeline/TL_PingAY_Z_attack_1",
		Id = 10120304,
		HitBindingType = 1
	},
	[10120305] = {
		Id = 10120305,
		CloseRoleEffect = true,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/PingAY_Z/Sources/Timeline/TL_PingAY_Z_skill_1"
	},
	[10120401] = {
		Id = 10120401,
		timeline = "Battle/Role/Monster/PingAY_P/Sources/Timeline/TL_PingAY_P_born"
	},
	[10120402] = {
		Id = 10120402,
		timeline = "Battle/Role/Monster/PingAY_P/Sources/Timeline/TL_PingAY_P_die"
	},
	[10120403] = {
		Id = 10120403,
		timeline = "Battle/Role/Monster/PingAY_P/Sources/Timeline/TL_PingAY_P_die"
	},
	[10120404] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/PingAY_P/Sources/Timeline/TL_PingAY_P_attack_1",
		Id = 10120404,
		HitBindingType = 1
	},
	[10120405] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/PingAY_P/Sources/Timeline/TL_PingAY_P_skill_1",
		Id = 10120405,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10120501] = {
		Id = 10120501,
		timeline = "Battle/Role/Monster/ShuiHJ/Sources/Timeline/TL_ShuiHJ_born"
	},
	[10120502] = {
		Id = 10120502,
		timeline = "Battle/Role/Monster/ShuiHJ/Sources/Timeline/TL_ShuiHJ_die"
	},
	[10120503] = {
		Id = 10120503
	},
	[10120504] = {
		Id = 10120504,
		HitType = 1,
		HitBindingType = 1,
		timeline = "Battle/Role/Monster/ShuiHJ/Sources/Timeline/TL_ShuiHJ_attack_1"
	},
	[10120505] = {
		Id = 10120505,
		MaskType = 4,
		timeline = "Battle/Role/Monster/ShuiHJ/Sources/Timeline/TL_ShuiHJ_special_1",
		Cinemachine = "Battle/Role/Monster/ShuiHJ/Sources/Cinemachine/TL_ShuiHJ_special_1",
		CloseRoleEffect = true
	},
	[10120506] = {
		Id = 10120506,
		Cinemachine = "Battle/Role/Monster/ShuiHJ/Sources/Cinemachine/TL_ShuiHJ_skill_1",
		CloseRoleEffect = true,
		timeline = "Battle/Role/Monster/ShuiHJ/Sources/Timeline/TL_ShuiHJ_skill_1"
	},
	[10120601] = {
		Id = 10120601,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_born"
	},
	[10120602] = {
		Id = 10120602,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_die"
	},
	[10120603] = {
		Id = 10120603,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_die"
	},
	[10120604] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_attack_1",
		Id = 10120604,
		HitBindingType = 1
	},
	[10120605] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_skill_1",
		Id = 10120605,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10210101] = {
		Id = 10210101,
		timeline = "Battle/Role/Monster/TunSZ1/Sources/Timeline/TL_TunSZ1_born"
	},
	[10210102] = {
		Id = 10210102,
		timeline = "Battle/Role/Monster/TunSZ1/Sources/Timeline/TL_TunSZ1_die"
	},
	[10210103] = {
		Id = 10210103,
		timeline = "Battle/Role/Monster/TunSZ1/Sources/Timeline/TL_TunSZ1_hit"
	},
	[10210104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/TunSZ1/Sources/Timeline/TL_TunSZ1_attack_1",
		Id = 10210104,
		HitBindingType = 1
	},
	[10210105] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/TunSZ1/Sources/Timeline/TL_TunSZ1_attack_1",
		Id = 10210105,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10210111] = {
		Id = 10210111,
		timeline = "Battle/Role/Monster/Jing_TunSZ1/Sources/Timeline/TL_Jing_TunSZ1_born"
	},
	[10210112] = {
		Id = 10210112,
		timeline = "Battle/Role/Monster/Jing_TunSZ1/Sources/Timeline/TL_Jing_TunSZ1_die"
	},
	[10210113] = {
		Id = 10210113,
		timeline = "Battle/Role/Monster/Jing_TunSZ1/Sources/Timeline/TL_Jing_TunSZ1_hit"
	},
	[10210114] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/Jing_TunSZ1/Sources/Timeline/TL_Jing_TunSZ1_attack_1",
		Id = 10210114,
		HitBindingType = 1
	},
	[10210115] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/Jing_TunSZ1/Sources/Timeline/TL_Jing_TunSZ1_attack_1",
		Id = 10210115,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10210201] = {
		Id = 10210201,
		timeline = "Battle/Role/Monster/TunSZ2/Sources/Timeline/TL_TunSZ2_born"
	},
	[10210202] = {
		Id = 10210202,
		timeline = "Battle/Role/Monster/TunSZ2/Sources/Timeline/TL_TunSZ2_die"
	},
	[10210203] = {
		Id = 10210203,
		timeline = "Battle/Role/Monster/TunSZ2/Sources/Timeline/TL_TunSZ2_hit"
	},
	[10210204] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/TunSZ2/Sources/Timeline/TL_TunSZ2_attack_1",
		Id = 10210204,
		HitBindingType = 1
	},
	[10210205] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/TunSZ2/Sources/Timeline/TL_TunSZ2_attack_1",
		Id = 10210205,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10210211] = {
		Id = 10210211,
		timeline = "Battle/Role/Monster/Jing_TunSZ2/Sources/Timeline/TL_Jing_TunSZ2_born"
	},
	[10210212] = {
		Id = 10210212,
		timeline = "Battle/Role/Monster/Jing_TunSZ2/Sources/Timeline/TL_Jing_TunSZ2_die"
	},
	[10210213] = {
		Id = 10210213,
		timeline = "Battle/Role/Monster/Jing_TunSZ2/Sources/Timeline/TL_Jing_TunSZ2_hit"
	},
	[10210214] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/Jing_TunSZ2/Sources/Timeline/TL_Jing_TunSZ2_attack_1",
		Id = 10210214,
		HitBindingType = 1
	},
	[10210215] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/Jing_TunSZ2/Sources/Timeline/TL_Jing_TunSZ2_attack_1",
		Id = 10210215,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10210301] = {
		Id = 10210301,
		timeline = "Battle/Role/Monster/TunSZ3/Sources/Timeline/TL_TunSZ3_born"
	},
	[10210302] = {
		Id = 10210302,
		timeline = "Battle/Role/Monster/TunSZ3/Sources/Timeline/TL_TunSZ3_die"
	},
	[10210303] = {
		Id = 10210303,
		timeline = "Battle/Role/Monster/TunSZ3/Sources/Timeline/TL_TunSZ3_hit"
	},
	[10210304] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/TunSZ3/Sources/Timeline/TL_TunSZ3_attack_1",
		Id = 10210304,
		HitBindingType = 1
	},
	[10210305] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/TunSZ3/Sources/Timeline/TL_TunSZ3_attack_1",
		Id = 10210305,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10210311] = {
		Id = 10210311,
		timeline = "Battle/Role/Monster/Jing_TunSZ3/Sources/Timeline/TL_Jing_TunSZ3_born"
	},
	[10210312] = {
		Id = 10210312,
		timeline = "Battle/Role/Monster/Jing_TunSZ3/Sources/Timeline/TL_Jing_TunSZ3_die"
	},
	[10210313] = {
		Id = 10210313,
		timeline = "Battle/Role/Monster/Jing_TunSZ3/Sources/Timeline/TL_Jing_TunSZ3_hit"
	},
	[10210314] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/Jing_TunSZ3/Sources/Timeline/TL_Jing_TunSZ3_attack_1",
		Id = 10210314,
		HitBindingType = 1
	},
	[10210315] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/Jing_TunSZ3/Sources/Timeline/TL_Jing_TunSZ3_attack_1",
		Id = 10210315,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10210401] = {
		Id = 10210401,
		timeline = "Battle/Role/Monster/TunSZ4/Sources/Timeline/TL_TunSZ4_born"
	},
	[10210402] = {
		Id = 10210402,
		timeline = "Battle/Role/Monster/TunSZ4/Sources/Timeline/TL_TunSZ4_die"
	},
	[10210403] = {
		Id = 10210403,
		timeline = "Battle/Role/Monster/TunSZ4/Sources/Timeline/TL_TunSZ4_hit"
	},
	[10210404] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/TunSZ4/Sources/Timeline/TL_TunSZ4_attack_1",
		Id = 10210404,
		HitBindingType = 1
	},
	[10210405] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/TunSZ4/Sources/Timeline/TL_TunSZ4_attack_1",
		Id = 10210405,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10210411] = {
		Id = 10210411,
		timeline = "Battle/Role/Monster/Jing_TunSZ4/Sources/Timeline/TL_Jing_TunSZ4_born"
	},
	[10210412] = {
		Id = 10210412,
		timeline = "Battle/Role/Monster/Jing_TunSZ4/Sources/Timeline/TL_Jing_TunSZ4_die"
	},
	[10210413] = {
		Id = 10210413,
		timeline = "Battle/Role/Monster/Jing_TunSZ4/Sources/Timeline/TL_Jing_TunSZ4_hit"
	},
	[10210414] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/Jing_TunSZ4/Sources/Timeline/TL_Jing_TunSZ4_attack_1",
		Id = 10210414,
		HitBindingType = 1
	},
	[10210415] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/Jing_TunSZ4/Sources/Timeline/TL_Jing_TunSZ4_attack_1",
		Id = 10210415,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10310101] = {
		Id = 10310101,
		timeline = "Battle/Role/Monster/ChangSZT/Sources/Timeline/TL_ChangSZT_born"
	},
	[10310102] = {
		Id = 10310102,
		timeline = "Battle/Role/Monster/ChangSZT/Sources/Timeline/TL_ChangSZT_die"
	},
	[10310103] = {
		Id = 10310103,
		timeline = "Battle/Role/Monster/ChangSZT/Sources/Timeline/TL_ChangSZT_hit"
	},
	[10310104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/ChangSZT/Sources/Timeline/TL_ChangSZT_attack_1",
		Id = 10310104,
		HitBindingType = 1
	},
	[10310201] = {
		Id = 10310201,
		timeline = "Battle/Role/Monster/JiK/Sources/Timeline/TL_JiK_born"
	},
	[10310202] = {
		Id = 10310202,
		timeline = "Battle/Role/Monster/JiK/Sources/Timeline/TL_JiK_die"
	},
	[10310203] = {
		Id = 10310203,
		timeline = "Battle/Role/Monster/JiK/Sources/Timeline/TL_JiK_hit"
	},
	[10310204] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/JiK/Sources/Timeline/TL_JiK_attack_1",
		Id = 10310204,
		HitBindingType = 1
	},
	[10310211] = {
		Id = 10310211,
		timeline = "Battle/Role/Monster/Jing_JiK/Sources/Timeline/TL_Jing_JiK_born"
	},
	[10310212] = {
		Id = 10310212,
		timeline = "Battle/Role/Monster/Jing_JiK/Sources/Timeline/TL_Jing_JiK_die"
	},
	[10310213] = {
		Id = 10310213,
		timeline = "Battle/Role/Monster/Jing_JiK/Sources/Timeline/TL_Jing_JiK_hit"
	},
	[10310214] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/Jing_JiK/Sources/Timeline/TL_Jing_JiK_attack_1",
		Id = 10310214,
		HitBindingType = 1
	},
	[10310215] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Monster/Jing_JiK/Sources/Timeline/TL_Jing_JiK_special_1",
		Id = 10310215,
		HitBindingType = 3,
		CloseRoleEffect = true
	},
	[10310301] = {
		Id = 10310301,
		timeline = "Battle/Role/Monster/MangM/Sources/Timeline/TL_MangM_born"
	},
	[10310302] = {
		Id = 10310302,
		timeline = "Battle/Role/Monster/MangM/Sources/Timeline/TL_MangM_die"
	},
	[10310303] = {
		Id = 10310303,
		timeline = "Battle/Role/Monster/MangM/Sources/Timeline/TL_MangM_hit"
	},
	[10310304] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Monster/MangM/Sources/Timeline/TL_MangM_attack_1",
		Id = 10310304,
		HitBindingType = 1
	},
	[10310305] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Monster/MangM/Sources/Timeline/TL_MangM_special_1",
		Id = 10310305,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10310311] = {
		Id = 10310311,
		timeline = "Battle/Role/Monster/Jing_MangM/Sources/Timeline/TL_Jing_MangM_born"
	},
	[10310312] = {
		Id = 10310312,
		timeline = "Battle/Role/Monster/Jing_MangM/Sources/Timeline/TL_Jing_MangM_die"
	},
	[10310313] = {
		Id = 10310313,
		timeline = "Battle/Role/Monster/Jing_MangM/Sources/Timeline/TL_Jing_MangM_hit"
	},
	[10310314] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Monster/Jing_MangM/Sources/Timeline/TL_Jing_MangM_attack_1",
		Id = 10310314,
		HitBindingType = 1
	},
	[10310315] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Monster/Jing_MangM/Sources/Timeline/TL_Jing_MangM_special_1",
		Id = 10310315,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10310401] = {
		Id = 10310401,
		timeline = "Battle/Role/Monster/WuC/Sources/Timeline/TL_WuC_born"
	},
	[10310402] = {
		Id = 10310402,
		timeline = "Battle/Role/Monster/WuC/Sources/Timeline/TL_WuC_die"
	},
	[10310403] = {
		Id = 10310403,
		timeline = "Battle/Role/Monster/WuC/Sources/Timeline/TL_WuC_hit"
	},
	[10310404] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/WuC/Sources/Timeline/TL_WuC_attack_1",
		Id = 10310404,
		HitBindingType = 1
	},
	[10310405] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/WuC/Sources/Timeline/TL_WuC_special_1",
		Id = 10310405,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10310501] = {
		Id = 10310501,
		timeline = "Battle/Role/Monster/WuL/Sources/Timeline/TL_WuL_born"
	},
	[10310502] = {
		Id = 10310502,
		timeline = "Battle/Role/Monster/WuL/Sources/Timeline/TL_WuL_die"
	},
	[10310503] = {
		Id = 10310503,
		timeline = "Battle/Role/Monster/WuL/Sources/Timeline/TL_WuL_hit"
	},
	[10310504] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Monster/WuL/Sources/Timeline/TL_WuL_attack_1",
		Id = 10310504,
		HitBindingType = 1
	},
	[10310505] = {
		ForceHitTarget = true,
		HitType = 4,
		timeline = "Battle/Role/Monster/WuL/Sources/Timeline/TL_WuL_attack_1",
		Id = 10310505,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10310601] = {
		Id = 10310601,
		timeline = "Battle/Role/Monster/XiaoH_S/Sources/Timeline/TL_XiaoH_S_born"
	},
	[10310602] = {
		Id = 10310602,
		timeline = "Battle/Role/Monster/XiaoH_S/Sources/Timeline/TL_XiaoH_S_die"
	},
	[10310604] = {
		Id = 10310604,
		HitType = 1,
		HitBindingType = 1,
		timeline = "Battle/Role/Monster/XiaoH_S/Sources/Timeline/TL_XiaoH_S_attack_1"
	},
	[10310605] = {
		HitType = 1,
		timeline = "Battle/Role/Monster/XiaoH_S/Sources/Timeline/TL_XiaoH_S_skill_1",
		Id = 10310605,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[10320101] = {
		Id = 10320101,
		timeline = "Battle/Role/Monster/ChangSZT/Sources/Timeline/TL_ChangSZT_born"
	},
	[10320102] = {
		Id = 10320102,
		timeline = "Battle/Role/Monster/ChangSZT/Sources/Timeline/TL_ChangSZT_die"
	},
	[10320103] = {
		Id = 10320103,
		timeline = "Battle/Role/Monster/ChangSZT/Sources/Timeline/TL_ChangSZT_hit"
	},
	[10320104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/ChangSZT/Sources/Timeline/TL_ChangSZT_attack_1",
		Id = 10320104,
		HitBindingType = 1
	},
	[10320105] = {
		Id = 10320105,
		CloseRoleEffect = true,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/ChangSZT/Sources/Timeline/TL_ChangSZT_skill_1"
	},
	[10320201] = {
		Id = 10320201,
		timeline = "Battle/Role/Monster/ChangSZT/Sources/Timeline/TL_ChangSZT_born"
	},
	[10320202] = {
		Id = 10320202,
		timeline = "Battle/Role/Monster/ChangSZT/Sources/Timeline/TL_ChangSZT_die"
	},
	[10320203] = {
		Id = 10320203,
		timeline = "Battle/Role/Monster/ChangSZT/Sources/Timeline/TL_ChangSZT_hit"
	},
	[10320204] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/ChangSZT/Sources/Timeline/TL_ChangSZT_attack_1",
		Id = 10320204,
		HitBindingType = 1
	},
	[10320205] = {
		Id = 10320205,
		CloseRoleEffect = true,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/ChangSZT/Sources/Timeline/TL_ChangSZT_skill_1"
	},
	[10320206] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/ChangSZT/Sources/Timeline/TL_ChangSZT_skill_2",
		Id = 10320206,
		HitBindingType = 1
	},
	[10320301] = {
		Id = 10320301,
		timeline = "Battle/Role/Monster/HuangL/Sources/Timeline/TL_HuangL_born"
	},
	[10320302] = {
		Id = 10320302,
		timeline = "Battle/Role/Monster/HuangL/Sources/Timeline/TL_HuangL_die"
	},
	[10320303] = {
		Id = 10320303,
		timeline = "Battle/Role/Monster/HuangL/Sources/Timeline/TL_HuangL_hit"
	},
	[10320304] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Monster/HuangL/Sources/Timeline/TL_HuangL_attack_1",
		Id = 10320304,
		HitBindingType = 1
	},
	[10320305] = {
		Id = 10320305,
		CloseRoleEffect = true,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/HuangL/Sources/Timeline/TL_HuangL_special_1"
	},
	[10320401] = {
		Id = 10320401,
		Cinemachine = "Battle/Role/Monster/ShuiX/Sources/Cinemachine/TL_ShuiX_born",
		timeline = "Battle/Role/Monster/ShuiX/Sources/Timeline/TL_ShuiX_born"
	},
	[10320402] = {
		Id = 10320402,
		timeline = "Battle/Role/Monster/ShuiX/Sources/Timeline/TL_ShuiX_die"
	},
	[10320403] = {
		Id = 10320403,
		timeline = "Battle/Role/Monster/ShuiX/Sources/Timeline/TL_ShuiX_hit"
	},
	[10320404] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/ShuiX/Sources/Timeline/TL_ShuiX_attack_1",
		Id = 10320404,
		HitBindingType = 1
	},
	[10320405] = {
		Id = 10320405,
		HitType = 6,
		timeline = "Battle/Role/Monster/ShuiX/Sources/Timeline/TL_ShuiX_skill_1",
		Cinemachine = "Battle/Role/Monster/ShuiX/Sources/Cinemachine/TL_ShuiX_skill_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[10320406] = {
		Id = 10320406,
		HitType = 1,
		MaskType = 4,
		timeline = "Battle/Role/Monster/ShuiX/Sources/Timeline/TL_ShuiX_special_1",
		Cinemachine = "Battle/Role/Monster/ShuiX/Sources/Cinemachine/TL_ShuiX_special_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[10320407] = {
		Id = 10320407,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/ShuiX/Sources/Timeline/TL_ShuiX_attack_a"
	},
	[10410101] = {
		Id = 10410101,
		timeline = "Battle/Role/Monster/YiQS/Sources/Timeline/TL_YiQS_born"
	},
	[10410102] = {
		Id = 10410102,
		timeline = "Battle/Role/Monster/YiQS/Sources/Timeline/TL_YiQS_die"
	},
	[10410104] = {
		ForceHitTarget = true,
		HitType = 4,
		timeline = "Battle/Role/Monster/YiQS/Sources/Timeline/TL_YiQS_attack_1",
		Id = 10410104,
		HitBindingType = 1
	},
	[10410105] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/YiQS/Sources/Timeline/TL_YiQS_special_1",
		Id = 10410105,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10410201] = {
		Id = 10410201,
		timeline = "Battle/Role/Monster/ShenJBDS/Sources/Timeline/TL_ShenJBDS_born"
	},
	[10410202] = {
		Id = 10410202,
		timeline = "Battle/Role/Monster/ShenJBDS/Sources/Timeline/TL_ShenJBDS_die"
	},
	[10410204] = {
		Id = 10410204,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/ShenJBDS/Sources/Timeline/TL_ShenJBDS_attack_1"
	},
	[10410205] = {
		HitType = 1,
		timeline = "Battle/Role/Monster/ShenJBDS/Sources/Timeline/TL_ShenJBDS_special_1",
		Id = 10410205,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[10410301] = {
		Id = 10410301,
		timeline = "Battle/Role/Monster/LuZ/Sources/Timeline/TL_LuZ_born"
	},
	[10410302] = {
		Id = 10410302,
		timeline = "Battle/Role/Monster/LuZ/Sources/Timeline/TL_LuZ_die"
	},
	[10410304] = {
		Id = 10410304,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/LuZ/Sources/Timeline/TL_LuZ_attack_1"
	},
	[10410305] = {
		Id = 10410305,
		HitType = 1,
		CloseRoleEffect = true,
		timeline = "Battle/Role/Monster/LuZ/Sources/Timeline/TL_LuZ_special_1"
	},
	[10420101] = {
		Id = 10420101,
		timeline = "Battle/Role/Monster/FengL/Sources/Timeline/TL_FengL_born"
	},
	[10420102] = {
		Id = 10420102,
		timeline = "Battle/Role/Monster/FengL/Sources/Timeline/TL_FengL_die"
	},
	[10420103] = {
		Id = 10420103,
		timeline = "Battle/Role/Monster/FengL/Sources/Timeline/TL_FengL_hit"
	},
	[10420104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/FengL/Sources/Timeline/TL_FengL_attack_1",
		Id = 10420104,
		HitBindingType = 1
	},
	[10420105] = {
		ForceHitTarget = true,
		HitType = 2,
		timeline = "Battle/Role/Monster/FengL/Sources/Timeline/TL_FengL_special_1",
		Id = 10420105,
		HitBindingType = 2,
		CloseRoleEffect = true
	},
	[10420201] = {
		Id = 10420201,
		timeline = "Battle/Role/Monster/HuoK/Sources/Timeline/TL_HuoK_born"
	},
	[10420202] = {
		Id = 10420202,
		timeline = "Battle/Role/Monster/HuoK/Sources/Timeline/TL_HuoK_die"
	},
	[10420203] = {
		Id = 10420203,
		timeline = "Battle/Role/Monster/HuoK/Sources/Timeline/TL_HuoK_hit"
	},
	[10420204] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/HuoK/Sources/Timeline/TL_HuoK_attack_1",
		Id = 10420204,
		HitBindingType = 1
	},
	[10420205] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/HuoK/Sources/Timeline/TL_HuoK_special_1",
		Id = 10420205,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10420301] = {
		Id = 10420301,
		timeline = "Battle/Role/Monster/LeiJ/Sources/Timeline/TL_LeiJ_born"
	},
	[10420302] = {
		Id = 10420302,
		timeline = "Battle/Role/Monster/LeiJ/Sources/Timeline/TL_LeiJ_die"
	},
	[10420303] = {
		Id = 10420303,
		timeline = "Battle/Role/Monster/LeiJ/Sources/Timeline/TL_LeiJ_hit"
	},
	[10420304] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/LeiJ/Sources/Timeline/TL_LeiJ_attack_1",
		Id = 10420304,
		HitBindingType = 1
	},
	[10420305] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/LeiJ/Sources/Timeline/TL_LeiJ_special_1",
		Id = 10420305,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10420401] = {
		Id = 10420401,
		timeline = "Battle/Role/Monster/QingTWW/Sources/Timeline/TL_QingTWW_born"
	},
	[10420402] = {
		Id = 10420402,
		timeline = "Battle/Role/Monster/QingTWW/Sources/Timeline/TL_QingTWW_die"
	},
	[10420404] = {
		Id = 10420404,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/QingTWW/Sources/Timeline/TL_QingTWW_attack_1"
	},
	[10420405] = {
		HitType = 6,
		timeline = "Battle/Role/Monster/QingTWW/Sources/Timeline/TL_QingTWW_special_1",
		Id = 10420405,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[10420501] = {
		Id = 10420501,
		timeline = "Battle/Role/Monster/DuoMKSC/Sources/Timeline/TL_DuoMKSC_born"
	},
	[10420502] = {
		Id = 10420502,
		timeline = "Battle/Role/Monster/DuoMKSC/Sources/Timeline/TL_DuoMKSC_die"
	},
	[10420504] = {
		Id = 10420504,
		HitType = 2,
		timeline = "Battle/Role/Monster/DuoMKSC/Sources/Timeline/TL_DuoMKSC_skill_1"
	},
	[10420505] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Monster/DuoMKSC/Sources/Timeline/TL_DuoMKSC_attack_1",
		Id = 10420505,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10510101] = {
		Id = 10510101,
		timeline = "Battle/Role/Monster/LengM/Sources/Timeline/TL_LengM_born"
	},
	[10510102] = {
		Id = 10510102,
		timeline = "Battle/Role/Monster/LengM/Sources/Timeline/TL_LengM_die"
	},
	[10510103] = {
		Id = 10510103,
		timeline = "Battle/Role/Monster/LengM/Sources/Timeline/TL_LengM_hit"
	},
	[10510104] = {
		Id = 10510104,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/LengM/Sources/Timeline/TL_LengM_attack_1"
	},
	[10510105] = {
		HitType = 1,
		timeline = "Battle/Role/Monster/LengM/Sources/Timeline/TL_LengM_special_1",
		Id = 10510105,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[10510111] = {
		Id = 10510111,
		timeline = "Battle/Role/Monster/Jing_LengM/Sources/Timeline/TL_Jing_LengM_born"
	},
	[10510112] = {
		Id = 10510112,
		timeline = "Battle/Role/Monster/Jing_LengM/Sources/Timeline/TL_Jing_LengM_die"
	},
	[10510113] = {
		Id = 10510113,
		timeline = "Battle/Role/Monster/Jing_LengM/Sources/Timeline/TL_Jing_LengM_hit"
	},
	[10510114] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/Jing_LengM/Sources/Timeline/TL_Jing_LengM_attack_1",
		Id = 10510114,
		HitBindingType = 1
	},
	[10510115] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/Jing_LengM/Sources/Timeline/TL_Jing_LengM_special_1",
		Id = 10510115,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10510201] = {
		Id = 10510201,
		timeline = "Battle/Role/Monster/XiaoM/Sources/Timeline/TL_XiaoM_born"
	},
	[10510202] = {
		Id = 10510202,
		timeline = "Battle/Role/Monster/XiaoM/Sources/Timeline/TL_XiaoM_die"
	},
	[10510203] = {
		Id = 10510203,
		timeline = "Battle/Role/Monster/XiaoM/Sources/Timeline/TL_XiaoM_hit"
	},
	[10510204] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/XiaoM/Sources/Timeline/TL_XiaoM_attack_1",
		Id = 10510204,
		HitBindingType = 1
	},
	[10510205] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/XiaoM/Sources/Timeline/TL_XiaoM_special_1",
		Id = 10510205,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10510211] = {
		Id = 10510211,
		timeline = "Battle/Role/Monster/Jing_XiaoM/Sources/Timeline/TL_Jing_XiaoM_born"
	},
	[10510212] = {
		Id = 10510212,
		timeline = "Battle/Role/Monster/Jing_XiaoM/Sources/Timeline/TL_Jing_XiaoM_die"
	},
	[10510213] = {
		Id = 10510213,
		timeline = "Battle/Role/Monster/Jing_XiaoM/Sources/Timeline/TL_Jing_XiaoM_hit"
	},
	[10510214] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/Jing_XiaoM/Sources/Timeline/TL_Jing_XiaoM_attack_1",
		Id = 10510214,
		HitBindingType = 1
	},
	[10510215] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/Jing_XiaoM/Sources/Timeline/TL_Jing_XiaoM_special_1",
		Id = 10510215,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10510301] = {
		Id = 10510301,
		timeline = "Battle/Role/Monster/KuangM/Sources/Timeline/TL_KuangM_born"
	},
	[10510302] = {
		Id = 10510302,
		timeline = "Battle/Role/Monster/KuangM/Sources/Timeline/TL_KuangM_die"
	},
	[10510303] = {
		Id = 10510303,
		timeline = "Battle/Role/Monster/KuangM/Sources/Timeline/TL_KuangM_hit"
	},
	[10510304] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/KuangM/Sources/Timeline/TL_KuangM_attack_1",
		Id = 10510304,
		HitBindingType = 1
	},
	[10510305] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Monster/KuangM/Sources/Timeline/TL_KuangM_special_1",
		Id = 10510305,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10510311] = {
		Id = 10510311,
		timeline = "Battle/Role/Monster/Jing_KuangM/Sources/Timeline/TL_Jing_KuangM_born"
	},
	[10510312] = {
		Id = 10510312,
		timeline = "Battle/Role/Monster/Jing_KuangM/Sources/Timeline/TL_Jing_KuangM_die"
	},
	[10510313] = {
		Id = 10510313,
		timeline = "Battle/Role/Monster/Jing_KuangM/Sources/Timeline/TL_Jing_KuangM_hit"
	},
	[10510314] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/Jing_KuangM/Sources/Timeline/TL_Jing_KuangM_attack_1",
		Id = 10510314,
		HitBindingType = 1
	},
	[10510315] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Monster/Jing_KuangM/Sources/Timeline/TL_Jing_KuangM_special_1",
		Id = 10510315,
		HitBindingType = 3,
		CloseRoleEffect = true
	},
	[10610101] = {
		Id = 10610101,
		timeline = "Battle/Role/Monster/PingAY_Z/Sources/Timeline/TL_PingAY_Z_born"
	},
	[10610102] = {
		Id = 10610102,
		timeline = "Battle/Role/Monster/PingAY_Z/Sources/Timeline/TL_PingAY_Z_die"
	},
	[10610103] = {
		Id = 10610103,
		timeline = "Battle/Role/Monster/PingAY_Z/Sources/Timeline/TL_PingAY_Z_hit"
	},
	[10610104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/PingAY_Z/Sources/Timeline/TL_PingAY_Z_attack_1",
		Id = 10610104,
		HitBindingType = 1
	},
	[10610105] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/PingAY_P/Sources/Timeline/TL_PingAY_P_skill_1",
		Id = 10610105,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10610201] = {
		Id = 10610201,
		timeline = "Battle/Role/Monster/PingAY_S/Sources/Timeline/TL_PingAY_S_born"
	},
	[10610202] = {
		Id = 10610202,
		timeline = "Battle/Role/Monster/PingAY_S/Sources/Timeline/TL_PingAY_S_die"
	},
	[10610203] = {
		Id = 10610203,
		timeline = "Battle/Role/Monster/PingAY_S/Sources/Timeline/TL_PingAY_S_die"
	},
	[10610204] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Monster/PingAY_S/Sources/Timeline/TL_PingAY_S_attack_1",
		Id = 10610204,
		HitBindingType = 1
	},
	[10610205] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Monster/PingAY_S/Sources/Timeline/TL_PingAY_S_skill_1",
		Id = 10610205,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10610301] = {
		Id = 10610301,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_born"
	},
	[10610302] = {
		Id = 10610302,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_die"
	},
	[10610303] = {
		Id = 10610303,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_die"
	},
	[10610304] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_attack_1",
		Id = 10610304,
		HitBindingType = 1
	},
	[10610305] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/PingAY_Y/Sources/Timeline/TL_PingAY_Y_skill_1",
		Id = 10610305,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10610401] = {
		Id = 10610401,
		timeline = "Battle/Role/Monster/PingAY_P/Sources/Timeline/TL_PingAY_P_born"
	},
	[10610402] = {
		Id = 10610402,
		timeline = "Battle/Role/Monster/PingAY_P/Sources/Timeline/TL_PingAY_P_die"
	},
	[10610403] = {
		Id = 10610403,
		timeline = "Battle/Role/Monster/PingAY_P/Sources/Timeline/TL_PingAY_P_die"
	},
	[10610404] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/PingAY_P/Sources/Timeline/TL_PingAY_P_attack_1",
		Id = 10610404,
		HitBindingType = 1
	},
	[10610405] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/PingAY_P/Sources/Timeline/TL_PingAY_P_skill_1",
		Id = 10610405,
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[10710101] = {
		Id = 10710101,
		timeline = "Battle/Role/Monster/XiJZ_b/Sources/Timeline/TL_XiJZ_b_born"
	},
	[10710102] = {
		Id = 10710102,
		timeline = "Battle/Role/Monster/XiJZ_b/Sources/Timeline/TL_XiJZ_b_die"
	},
	[10710104] = {
		Id = 10710104,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/XiJZ_b/Sources/Timeline/TL_XiJZ_b_attack_1"
	},
	[10710105] = {
		HitType = 1,
		timeline = "Battle/Role/Monster/XiJZ_b/Sources/Timeline/TL_XiJZ_b_skill_1",
		Id = 10710105,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[36021] = {
		Id = 36021,
		timeline = "Battle/Role/Monster/XiJZ_c/Sources/Timeline/TL_XiJZ_c_born"
	},
	[36022] = {
		Id = 36022,
		timeline = "Battle/Role/Monster/XiJZ_c/Sources/Timeline/TL_XiJZ_c_die"
	},
	[36023] = {
		Id = 36023,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/XiJZ_c/Sources/Timeline/TL_XiJZ_c_attack_1"
	},
	[10720101] = {
		Id = 10720101,
		timeline = "Battle/Role/Monster/XiJSJZ_1/Sources/Timeline/TL_XiJSJZ_1_born"
	},
	[10720102] = {
		Id = 10720102,
		timeline = "Battle/Role/Monster/XiJSJZ_1/Sources/Timeline/TL_XiJSJZ_1_die"
	},
	[10720103] = {
		Id = 10720103,
		timeline = "Battle/Role/Monster/XiJSJZ_1/Sources/Timeline/TL_XiJSJZ_1_hit"
	},
	[10720104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/XiJSJZ_1/Sources/Timeline/TL_XiJSJZ_1_attack_1",
		Id = 10720104,
		HitBindingType = 1
	},
	[10720105] = {
		HitType = 1,
		timeline = "Battle/Role/Monster/XiJSJZ_1/Sources/Timeline/TL_XiJSJZ_1_special_1",
		Id = 10720105,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[10720201] = {
		Id = 10720201,
		timeline = "Battle/Role/Monster/XiJSJZ_2/Sources/Timeline/TL_XiJSJZ_2_born"
	},
	[10720202] = {
		Id = 10720202,
		timeline = "Battle/Role/Monster/XiJSJZ_2/Sources/Timeline/TL_XiJSJZ_2_die"
	},
	[10720203] = {
		Id = 10720203,
		timeline = "Battle/Role/Monster/XiJSJZ_2/Sources/Timeline/TL_XiJSJZ_2_hit"
	},
	[10720204] = {
		Id = 10720204,
		HitType = 4,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/XiJSJZ_2/Sources/Timeline/TL_XiJSJZ_2_attack_1"
	},
	[10720205] = {
		Id = 10720205,
		HitType = 1,
		timeline = "Battle/Role/Monster/XiJSJZ_2/Sources/Timeline/TL_XiJSJZ_2_skill_1",
		Cinemachine = "Battle/Role/Monster/XiJSJZ_2/Sources/Cinemachine/TL_XiJSJZ_2_skill_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[10720206] = {
		Id = 10720206,
		HitType = 1,
		MaskType = 4,
		timeline = "Battle/Role/Monster/XiJSJZ_2/Sources/Timeline/TL_XiJSJZ_2_special_1",
		Cinemachine = "Battle/Role/Monster/XiJSJZ_2/Sources/Cinemachine/TL_XiJSJZ_2_special_1",
		ForceHitTarget = true,
		HitBindingType = 3,
		CloseRoleEffect = true
	},
	[20130101] = {
		Id = 20130101,
		Cinemachine = "Battle/Role/Monster/BanBCL/Sources/Cinemachine/TL_BanBCL_born",
		CloseRoleEffect = true,
		timeline = "Battle/Role/Monster/BanBCL/Sources/Timeline/TL_BanBCL_born"
	},
	[20130102] = {
		Id = 20130102,
		timeline = "Battle/Role/Monster/BanBCL/Sources/Timeline/TL_BanBCL_die"
	},
	[20130104] = {
		Id = 20130104,
		HitType = 1,
		timeline = "Battle/Role/Monster/BanBCL/Sources/Timeline/TL_BanBCL_attack_1",
		Cinemachine = "Battle/Role/Monster/BanBCL/Sources/Cinemachine/TL_BanBCL_attack_1",
		ForceHitTarget = true
	},
	[20130105] = {
		Id = 20130105,
		Cinemachine = "Battle/Role/Monster/BanBCL/Sources/Cinemachine/TL_BanBCL_skill_1",
		timeline = "Battle/Role/Monster/BanBCL/Sources/Timeline/TL_BanBCL_skill_1"
	},
	[20130106] = {
		Id = 20130106,
		HitType = 1,
		timeline = "Battle/Role/Monster/BanBCL/Sources/Timeline/TL_BanBCL_skill_2",
		Cinemachine = "Battle/Role/Monster/BanBCL/Sources/Cinemachine/TL_BanBCL_skill_2",
		ForceHitTarget = true
	},
	[20130107] = {
		Id = 20130107,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Monster/BanBCL/Sources/Timeline/TL_BanBCL_special_1",
		Cinemachine = "Battle/Role/Monster/BanBCL/Sources/Cinemachine/TL_BanBCL_special_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[20130201] = {
		Id = 20130201,
		Cinemachine = "Battle/Role/Monster/WeiMZY/Sources/Cinemachine/TL_WeiMZY_born",
		CloseRoleEffect = true,
		timeline = "Battle/Role/Monster/WeiMZY/Sources/Timeline/TL_WeiMZY_born"
	},
	[20130202] = {
		Id = 20130202,
		Cinemachine = "Battle/Role/Monster/WeiMZY/Sources/Cinemachine/TL_WeiMZY_die",
		timeline = "Battle/Role/Monster/WeiMZY/Sources/Timeline/TL_WeiMZY_die"
	},
	[20130203] = {
		Id = 20130203,
		timeline = "Battle/Role/Monster/WeiMZY/Sources/Timeline/TL_WeiMZY_hit"
	},
	[20130204] = {
		Id = 20130204,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/WeiMZY/Sources/Timeline/TL_WeiMZY_attack_1",
		Cinemachine = "Battle/Role/Monster/WeiMZY/Sources/Cinemachine/TL_WeiMZY_attack_1",
		HitBindingType = 1
	},
	[20130205] = {
		Id = 20130205,
		HitType = 6,
		timeline = "Battle/Role/Monster/WeiMZY/Sources/Timeline/TL_WeiMZY_skill_2",
		Cinemachine = "Battle/Role/Monster/WeiMZY/Sources/Cinemachine/TL_WeiMZY_skill_2",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[20130206] = {
		Id = 20130206,
		HitType = 6,
		timeline = "Battle/Role/Monster/WeiMZY/Sources/Timeline/TL_WeiMZY_skill_1",
		Cinemachine = "Battle/Role/Monster/WeiMZY/Sources/Cinemachine/TL_WeiMZY_skill_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[20130207] = {
		Id = 20130207,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Monster/WeiMZY/Sources/Timeline/TL_WeiMZY_special_1",
		Cinemachine = "Battle/Role/Monster/WeiMZY/Sources/Cinemachine/TL_WeiMZY_special_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[20130301] = {
		Id = 20130301,
		Cinemachine = "Battle/Role/Monster/XiaQ/Sources/Cinemachine/TL_XiaQ_born",
		CloseRoleEffect = true,
		timeline = "Battle/Role/Monster/XiaQ/Sources/Timeline/TL_XiaQ_born"
	},
	[20130302] = {
		Id = 20130302,
		Cinemachine = "Battle/Role/Monster/XiaQ/Sources/Cinemachine/TL_XiaQ_die",
		timeline = "Battle/Role/Monster/XiaQ/Sources/Timeline/TL_XiaQ_die"
	},
	[20130304] = {
		Id = 20130304,
		HitType = 1,
		timeline = "Battle/Role/Monster/XiaQ/Sources/Timeline/TL_XiaQ_attack_1",
		Cinemachine = "Battle/Role/Monster/XiaQ/Sources/Cinemachine/TL_XiaQ_attack_1",
		HitBindingType = 1
	},
	[20130305] = {
		Id = 20130305,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/XiaQ/Sources/Timeline/TL_XiaQ_skill_2",
		Cinemachine = "Battle/Role/Monster/XiaQ/Sources/Cinemachine/TL_XiaQ_skill_2",
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[20130306] = {
		Id = 20130306,
		timeline = "Battle/Role/Monster/XiaQ/Sources/Timeline/TL_XiaQ_skill_3",
		Cinemachine = "Battle/Role/Monster/XiaQ/Sources/Cinemachine/TL_XiaQ_skill_3",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[20130307] = {
		Id = 20130307,
		HitType = 1,
		MaskType = 4,
		timeline = "Battle/Role/Monster/XiaQ/Sources/Timeline/TL_XiaQ_special_1",
		Cinemachine = "Battle/Role/Monster/XiaQ/Sources/Cinemachine/TL_XiaQ_special_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[20130308] = {
		Id = 20130308,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/XiaQ/Sources/Timeline/TL_XiaQ_skill_1",
		Cinemachine = "Battle/Role/Monster/XiaQ/Sources/Cinemachine/TL_XiaQ_skill_1",
		HitBindingType = 1
	},
	[20210101] = {
		Id = 20210101,
		timeline = "Battle/Role/Monster/XiaoH_S/Sources/Timeline/TL_XiaoH_S_born"
	},
	[20210102] = {
		Id = 20210102,
		timeline = "Battle/Role/Monster/XiaoH_S/Sources/Timeline/TL_XiaoH_S_die"
	},
	[20210104] = {
		Id = 20210104,
		HitType = 1,
		HitBindingType = 1,
		timeline = "Battle/Role/Monster/XiaoH_S/Sources/Timeline/TL_XiaoH_S_attack_1"
	},
	[20210201] = {
		Id = 20210201,
		timeline = "Battle/Role/Monster/XiaoH_S/Sources/Timeline/TL_XiaoH_S_born"
	},
	[20210202] = {
		Id = 20210202,
		timeline = "Battle/Role/Monster/XiaoH_S/Sources/Timeline/TL_XiaoH_S_die"
	},
	[20210204] = {
		Id = 20210204,
		HitType = 1,
		HitBindingType = 1,
		timeline = "Battle/Role/Monster/XiaoH_S/Sources/Timeline/TL_XiaoH_S_attack_1"
	},
	[20230101] = {
		Id = 20230101,
		Cinemachine = "Battle/Role/Monster/YuHSZL/Sources/Cinemachine/TL_YuHSZL_born",
		CloseRoleEffect = true,
		timeline = "Battle/Role/Monster/YuHSZL/Sources/Timeline/TL_YuHSZL_born"
	},
	[20230102] = {
		Id = 20230102,
		Cinemachine = "Battle/Role/Monster/YuHSZL/Sources/Cinemachine/TL_YuHSZL_die",
		timeline = "Battle/Role/Monster/YuHSZL/Sources/Timeline/TL_YuHSZL_die"
	},
	[20230103] = {
		Id = 20230103,
		timeline = "Battle/Role/Monster/YuHSZL/Sources/Timeline/TL_YuHSZL_hit"
	},
	[20230104] = {
		ForceHitTarget = true,
		HitType = 6,
		timeline = "Battle/Role/Monster/YuHSZL/Sources/Timeline/TL_YuHSZL_attack_1",
		Id = 20230104,
		HitBindingType = 1
	},
	[20230105] = {
		Id = 20230105,
		HitType = 1,
		timeline = "Battle/Role/Monster/YuHSZL/Sources/Timeline/TL_YuHSZL_skill_2_1",
		Cinemachine = "Battle/Role/Monster/YuHSZL/Sources/Cinemachine/TL_YuHSZL_skill_2",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[20230106] = {
		Id = 20230106,
		HitType = 1,
		timeline = "Battle/Role/Monster/YuHSZL/Sources/Timeline/TL_YuHSZL_skill_1",
		Cinemachine = "Battle/Role/Monster/YuHSZL/Sources/Cinemachine/TL_YuHSZL_skill_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[20230107] = {
		Id = 20230107,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Monster/YuHSZL/Sources/Timeline/TL_YuHSZL_special_1",
		Cinemachine = "Battle/Role/Monster/YuHSZL/Sources/Cinemachine/TL_YuHSZL_special_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[20230108] = {
		Id = 20230108,
		HitType = 1,
		timeline = "Battle/Role/Monster/YuHSZL/Sources/Timeline/TL_YuHSZL_skill_2",
		Cinemachine = "Battle/Role/Monster/YuHSZL/Sources/Cinemachine/TL_YuHSZL_skill_2",
		ForceHitTarget = true
	},
	[20230201] = {
		Id = 20230201,
		Cinemachine = "Battle/Role/Monster/XiaoH/Sources/Cinemachine/TL_XiaoH_born",
		CloseRoleEffect = true,
		timeline = "Battle/Role/Monster/XiaoH/Sources/Timeline/TL_XiaoH_born"
	},
	[20230202] = {
		Id = 20230202,
		timeline = "Battle/Role/Monster/XiaoH/Sources/Timeline/TL_XiaoH_die"
	},
	[20230204] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/XiaoH/Sources/Timeline/TL_XiaoH_attack_1",
		Id = 20230204,
		HitBindingType = 1
	},
	[20230205] = {
		Id = 20230205,
		HitType = 1,
		timeline = "Battle/Role/Monster/XiaoH/Sources/Timeline/TL_XiaoH_skill_1",
		Cinemachine = "Battle/Role/Monster/XiaoH/Sources/Cinemachine/TL_XiaoH_skill_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[20230301] = {
		Id = 20230301,
		Cinemachine = "Battle/Role/Monster/Z_YuHSZL/Sources/Cinemachine/TL_Z_YuHSZL_born",
		CloseRoleEffect = true,
		timeline = "Battle/Role/Monster/Z_YuHSZL/Sources/Timeline/TL_Z_YuHSZL_born"
	},
	[20230302] = {
		Id = 20230302,
		Cinemachine = "Battle/Role/Monster/Z_YuHSZL/Sources/Cinemachine/TL_Z_YuHSZL_die",
		timeline = "Battle/Role/Monster/Z_YuHSZL/Sources/Timeline/TL_Z_YuHSZL_die"
	},
	[20230304] = {
		Id = 20230304,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/Z_YuHSZL/Sources/Timeline/TL_Z_YuHSZL_B_attack_1",
		Cinemachine = "Battle/Role/Monster/Z_YuHSZL/Sources/Cinemachine/TL_Z_YuHSZL_B_attack_1",
		HitBindingType = 1
	},
	[20230305] = {
		Id = 20230305,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Monster/Z_YuHSZL/Sources/Timeline/TL_Z_YuHSZL_B_skill_1",
		Cinemachine = "Battle/Role/Monster/Z_YuHSZL/Sources/Cinemachine/TL_Z_YuHSZL_B_skill_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[20230306] = {
		Id = 20230306,
		Cinemachine = "Battle/Role/Monster/Z_YuHSZL/Sources/Cinemachine/TL_Z_YuHSZL_B_skillcharge_1",
		CloseRoleEffect = true,
		timeline = "Battle/Role/Monster/Z_YuHSZL/Sources/Timeline/TL_Z_YuHSZL_B_skillcharge_1"
	},
	[20230307] = {
		Id = 20230307,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/Monster/Z_YuHSZL/Sources/Timeline/TL_Z_YuHSZL_B_special_1",
		Cinemachine = "Battle/Role/Monster/Z_YuHSZL/Sources/Cinemachine/TL_Z_YuHSZL_B_special_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[20230314] = {
		Id = 20230314,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/Z_YuHSZL/Sources/Timeline/TL_Z_YuHSZL_L_attack_1",
		Cinemachine = "Battle/Role/Monster/Z_YuHSZL/Sources/Cinemachine/TL_Z_YuHSZL_L_attack_1",
		HitBindingType = 1
	},
	[20230315] = {
		Id = 20230315,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/Z_YuHSZL/Sources/Timeline/TL_Z_YuHSZL_L_skill_1",
		Cinemachine = "Battle/Role/Monster/Z_YuHSZL/Sources/Cinemachine/TL_Z_YuHSZL_L_skill_1",
		HitBindingType = 1
	},
	[20230324] = {
		Id = 20230324,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/Z_YuHSZL/Sources/Timeline/TL_Z_YuHSZL_R_attack_1",
		Cinemachine = "Battle/Role/Monster/Z_YuHSZL/Sources/Cinemachine/TL_Z_YuHSZL_R_attack_1",
		HitBindingType = 1
	},
	[20230325] = {
		Id = 20230325,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/Z_YuHSZL/Sources/Timeline/TL_Z_YuHSZL_R_skill_1",
		Cinemachine = "Battle/Role/Monster/Z_YuHSZL/Sources/Cinemachine/TL_Z_YuHSZL_R_skill_1",
		HitBindingType = 1
	},
	[20330101] = {
		Id = 20330101,
		Cinemachine = "Battle/Role/Monster/ZhuiHZKL_1/Sources/Cinemachine/TL_ZhuiHZKL_1_born",
		CloseRoleEffect = true,
		timeline = "Battle/Role/Monster/ZhuiHZKL_1/Sources/Timeline/TL_ZhuiHZKL_1_born"
	},
	[20330102] = {
		Id = 20330102,
		Cinemachine = "Battle/Role/Monster/ZhuiHZKL_1/Sources/Cinemachine/TL_ZhuiHZKL_1_die",
		timeline = "Battle/Role/Monster/ZhuiHZKL_1/Sources/Timeline/TL_ZhuiHZKL_1_die"
	},
	[20330104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/ZhuiHZKL_1/Sources/Timeline/TL_ZhuiHZKL_1_attack_1",
		Id = 20330104,
		HitBindingType = 1
	},
	[20330105] = {
		Id = 20330105,
		Cinemachine = "Battle/Role/Monster/ZhuiHZKL_1/Sources/Cinemachine/TL_ZhuiHZKL_1_skillcharge_1",
		CloseRoleEffect = true,
		timeline = "Battle/Role/Monster/ZhuiHZKL_1/Sources/Timeline/TL_ZhuiHZKL_1_skillcharge_1"
	},
	[20330106] = {
		Id = 20330106,
		Cinemachine = "Battle/Role/Monster/ZhuiHZKL_1/Sources/Cinemachine/TL_ZhuiHZKL_1_skillcharge_2",
		CloseRoleEffect = true,
		timeline = "Battle/Role/Monster/ZhuiHZKL_1/Sources/Timeline/TL_ZhuiHZKL_1_skillcharge_2"
	},
	[20330107] = {
		Id = 20330107,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Monster/ZhuiHZKL_1/Sources/Timeline/TL_ZhuiHZKL_1_special_1",
		Cinemachine = "Battle/Role/Monster/ZhuiHZKL_1/Sources/Cinemachine/TL_ZhuiHZKL_1_special_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[20330108] = {
		Id = 20330108,
		Cinemachine = "Battle/Role/Monster/ZhuiHZKL_1/Sources/Cinemachine/TL_ZhuiHZKL_1_skill_1",
		timeline = "Battle/Role/Monster/ZhuiHZKL_1/Sources/Timeline/TL_ZhuiHZKL_1_skill_1"
	},
	[20330201] = {
		Id = 20330201,
		Cinemachine = "Battle/Role/Monster/ZhuiHZKL_2/Sources/Cinemachine/TL_ZhuiHZKL_2_born",
		CloseRoleEffect = true,
		timeline = "Battle/Role/Monster/ZhuiHZKL_2/Sources/Timeline/TL_ZhuiHZKL_2_born"
	},
	[20330202] = {
		Id = 20330202,
		Cinemachine = "Battle/Role/Monster/ZhuiHZKL_2/Sources/Cinemachine/TL_ZhuiHZKL_2_die",
		timeline = "Battle/Role/Monster/ZhuiHZKL_2/Sources/Timeline/TL_ZhuiHZKL_2_die"
	},
	[20330204] = {
		Id = 20330204,
		HitType = 1,
		timeline = "Battle/Role/Monster/ZhuiHZKL_2/Sources/Timeline/TL_ZhuiHZKL_2_attack_1",
		Cinemachine = "Battle/Role/Monster/ZhuiHZKL_2/Sources/Cinemachine/TL_ZhuiHZKL_2_attack_1",
		ForceHitTarget = true
	},
	[20330205] = {
		Id = 20330205,
		Cinemachine = "Battle/Role/Monster/ZhuiHZKL_2/Sources/Cinemachine/TL_ZhuiHZKL_2_skill_1",
		CloseRoleEffect = true,
		timeline = "Battle/Role/Monster/ZhuiHZKL_2/Sources/Timeline/TL_ZhuiHZKL_2_skill_1"
	},
	[20330206] = {
		Id = 20330206,
		HitType = 1,
		timeline = "Battle/Role/Monster/ZhuiHZKL_2/Sources/Timeline/TL_ZhuiHZKL_2_skill_3",
		Cinemachine = "Battle/Role/Monster/ZhuiHZKL_2/Sources/Cinemachine/TL_ZhuiHZKL_2_skill_3",
		HitBindingType = 1,
		CloseRoleEffect = true
	},
	[20330207] = {
		Id = 20330207,
		HitType = 6,
		timeline = "Battle/Role/Monster/ZhuiHZKL_2/Sources/Timeline/TL_ZhuiHZKL_2_skill_2",
		Cinemachine = "Battle/Role/Monster/ZhuiHZKL_2/Sources/Cinemachine/TL_ZhuiHZKL_2_skill_2",
		HitBindingType = 2,
		CloseRoleEffect = true
	},
	[20330208] = {
		Id = 20330208,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/Monster/ZhuiHZKL_2/Sources/Timeline/TL_ZhuiHZKL_2_special_1",
		Cinemachine = "Battle/Role/Monster/ZhuiHZKL_2/Sources/Cinemachine/TL_ZhuiHZKL_2_special_1",
		ForceHitTarget = true
	},
	[50061] = {
		Id = 50061,
		Cinemachine = "Battle/Role/Monster/XiJSJZ_3/Sources/Cinemachine/TL_XiJSJZ_3_born",
		timeline = "Battle/Role/Monster/XiJSJZ_3/Sources/Timeline/TL_XiJSJZ_3_born"
	},
	[50062] = {
		Id = 50062,
		timeline = "Battle/Role/Monster/XiJSJZ_3/Sources/Timeline/TL_XiJSJZ_3_die"
	},
	[50063] = {
		Id = 50063,
		timeline = "Battle/Role/Monster/XiJSJZ_3/Sources/Timeline/TL_XiJSJZ_3_hit"
	},
	[50064] = {
		Id = 50064,
		HitType = 4,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/XiJSJZ_3/Sources/Timeline/TL_XiJSJZ_3_attack_1"
	},
	[50065] = {
		Id = 50065,
		HitType = 1,
		timeline = "Battle/Role/Monster/XiJSJZ_3/Sources/Timeline/TL_XiJSJZ_3_skill_1",
		Cinemachine = "Battle/Role/Monster/XiJSJZ_3/Sources/Cinemachine/TL_XiJSJZ_3_skill_1",
		ForceHitTarget = true
	},
	[50066] = {
		Id = 50066,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/Monster/XiJSJZ_3/Sources/Timeline/TL_XiJSJZ_3_special_1",
		Cinemachine = "Battle/Role/Monster/XiJSJZ_3/Sources/Cinemachine/TL_XiJSJZ_3_special_1",
		ForceHitTarget = true
	},
	[50067] = {
		Id = 50067,
		HitType = 1,
		timeline = "Battle/Role/Monster/XiJSJZ_3/Sources/Timeline/TL_XiJSJZ_3_skill_2",
		Cinemachine = "Battle/Role/Monster/XiJSJZ_3/Sources/Cinemachine/TL_XiJSJZ_3_skill_2",
		ForceHitTarget = true
	},
	[50068] = {
		Id = 50068,
		HitType = 1,
		timeline = "Battle/Role/Monster/XiJSJZ_3/Sources/Timeline/TL_XiJSJZ_3_skill_3",
		Cinemachine = "Battle/Role/Monster/XiJSJZ_3/Sources/Cinemachine/TL_XiJSJZ_3_skill_3",
		ForceHitTarget = true
	},
	[30210101] = {
		Id = 30210101,
		timeline = "Battle/Role/Monster/DiYSQ/Sources/Timeline/TL_DiYSQ_born"
	},
	[30210102] = {
		Id = 30210102,
		timeline = "Battle/Role/Monster/DiYSQ/Sources/Timeline/TL_DiYSQ_die"
	},
	[30210104] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/DiYSQ/Sources/Timeline/TL_DiYSQ_attack_1",
		Id = 30210104,
		HitBindingType = 1
	},
	[30210105] = {
		HitType = 1,
		timeline = "Battle/Role/Monster/DiYSQ/Sources/Timeline/TL_DiYSQ_attack_1",
		Id = 30210105,
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[30230101] = {
		Id = 30230101,
		Cinemachine = "Battle/Role/Monster/LunRD/Sources/Cinemachine/TL_LunRD_born",
		CloseRoleEffect = true,
		timeline = "Battle/Role/Monster/LunRD/Sources/Timeline/TL_LunRD_born"
	},
	[30230102] = {
		Id = 30230102,
		Cinemachine = "Battle/Role/Monster/LunRD/Sources/Cinemachine/TL_LunRD_die",
		timeline = "Battle/Role/Monster/LunRD/Sources/Timeline/TL_LunRD_die"
	},
	[30230104] = {
		Id = 30230104,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/LunRD/Sources/Timeline/TL_LunRD_attack_1",
		Cinemachine = "Battle/Role/Monster/LunRD/Sources/Cinemachine/TL_LunRD_attack_1",
		HitBindingType = 1
	},
	[30230105] = {
		Id = 30230105,
		HitType = 1,
		MaskType = 4,
		timeline = "Battle/Role/Monster/LunRD/Sources/Timeline/TL_LunRD_skill_1",
		Cinemachine = "Battle/Role/Monster/LunRD/Sources/Cinemachine/TL_LunRD_skill_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[30230106] = {
		Id = 30230106,
		HitType = 1,
		MaskType = 4,
		timeline = "Battle/Role/Monster/LunRD/Sources/Timeline/TL_LunRD_skill_1",
		Cinemachine = "Battle/Role/Monster/LunRD/Sources/Cinemachine/TL_LunRD_skill_1",
		ForceHitTarget = true,
		CloseRoleEffect = true
	},
	[30231] = {
		Id = 30231,
		HitType = 1,
		HitBindingType = 1,
		timeline = "Battle/Role/Monster/AiH/Sources/Timeline/TL_AiH_attack_1"
	},
	[30232] = {
		Id = 30232,
		timeline = "Battle/Role/Monster/AiH/Sources/Timeline/TL_AiH_born"
	},
	[30233] = {
		Id = 30233,
		timeline = "Battle/Role/Monster/AiH/Sources/Timeline/TL_AiH_die"
	},
	[30234] = {
		Id = 30234,
		MaskType = 4,
		timeline = "Battle/Role/Monster/AiH/Sources/Timeline/TL_AiH_special_1"
	},
	[30241] = {
		Id = 30241,
		HitType = 1,
		HitBindingType = 1,
		timeline = "Battle/Role/Monster/EY/Sources/Timeline/TL_EY_attack_1"
	},
	[30242] = {
		Id = 30242,
		timeline = "Battle/Role/Monster/EY/Sources/Timeline/TL_EY_born"
	},
	[30243] = {
		Id = 30243,
		timeline = "Battle/Role/Monster/EY/Sources/Timeline/TL_EY_die"
	},
	[30244] = {
		Id = 30244,
		MaskType = 4,
		timeline = "Battle/Role/Monster/EY/Sources/Timeline/TL_EY_special_1"
	},
	[30251] = {
		Id = 30251,
		HitType = 1,
		HitBindingType = 1,
		timeline = "Battle/Role/Monster/QianCZ/Sources/Timeline/TL_QianCZ_attack_1"
	},
	[30252] = {
		Id = 30252,
		timeline = "Battle/Role/Monster/QianCZ/Sources/Timeline/TL_QianCZ_born"
	},
	[30253] = {
		Id = 30253,
		timeline = "Battle/Role/Monster/QianCZ/Sources/Timeline/TL_QianCZ_die"
	},
	[30254] = {
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Monster/QianCZ/Sources/Timeline/TL_QianCZ_special_1",
		Id = 30254,
		HitBindingType = 3
	},
	[30261] = {
		Id = 30261,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/YuX/Sources/Timeline/TL_YuX_attack_1"
	},
	[30262] = {
		Id = 30262,
		timeline = "Battle/Role/Monster/YuX/Sources/Timeline/TL_YuX_born"
	},
	[30263] = {
		Id = 30263,
		timeline = "Battle/Role/Monster/YuX/Sources/Timeline/TL_YuX_die"
	},
	[40111] = {
		Id = 40111,
		HitType = 4,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/ShuXS/Sources/Timeline/TL_ShuXS_attack_1"
	},
	[40112] = {
		Id = 40112,
		timeline = "Battle/Role/Monster/ShuXS/Sources/Timeline/TL_ShuXS_born"
	},
	[40113] = {
		Id = 40113,
		timeline = "Battle/Role/Monster/ShuXS/Sources/Timeline/TL_ShuXS_die"
	},
	[40114] = {
		Id = 40114,
		HitType = 1,
		timeline = "Battle/Role/Monster/ShuXS/Sources/Timeline/TL_ShuXS_special_1",
		Cinemachine = "Battle/Role/Monster/ShuXS/Sources/Cinemachine/TL_ShuXS_special_1",
		ForceHitTarget = true
	},
	[40121] = {
		Id = 40121,
		HitType = 1,
		HitBindingType = 1,
		timeline = "Battle/Role/Monster/ShiH/Sources/Timeline/TL_ShiH_attack_1"
	},
	[40122] = {
		Id = 40122,
		timeline = "Battle/Role/Monster/ShiH/Sources/Timeline/TL_ShiH_born"
	},
	[40123] = {
		Id = 40123,
		timeline = "Battle/Role/Monster/ShiH/Sources/Timeline/TL_ShiH_die"
	},
	[40124] = {
		Id = 40124,
		timeline = "Battle/Role/Monster/ShiH/Sources/Timeline/TL_ShiH_skill_1"
	},
	[40125] = {
		Id = 40125,
		MaskType = 4,
		timeline = "Battle/Role/Monster/ShiH/Sources/Timeline/TL_ShiH_special_1"
	},
	[40131] = {
		Id = 40131,
		HitType = 6,
		HitBindingType = 1,
		timeline = "Battle/Role/Monster/HunDEY/Sources/Timeline/TL_HunDEY_attack_1"
	},
	[40132] = {
		Id = 40132,
		Cinemachine = "Battle/Role/Monster/HunDEY/Sources/Cinemachine/TL_HunDEY_born",
		timeline = "Battle/Role/Monster/HunDEY/Sources/Timeline/TL_HunDEY_born"
	},
	[40133] = {
		Id = 40133,
		timeline = "Battle/Role/Monster/HunDEY/Sources/Timeline/TL_HunDEY_die"
	},
	[40134] = {
		Id = 40134,
		HitType = 2,
		MaskType = 4,
		timeline = "Battle/Role/Monster/HunDEY/Sources/Timeline/TL_HunDEY_special_1",
		Cinemachine = "Battle/Role/Monster/HunDEY/Sources/Cinemachine/TL_HunDEY_special_1"
	},
	[40141] = {
		Id = 40141,
		HitType = 1,
		HitBindingType = 1,
		timeline = "Battle/Role/Monster/NingSZ/Sources/Timeline/TL_NingSZ_attack_1"
	},
	[40142] = {
		Id = 40142,
		timeline = "Battle/Role/Monster/NingSZ/Sources/Timeline/TL_NingSZ_born"
	},
	[40143] = {
		Id = 40143,
		timeline = "Battle/Role/Monster/NingSZ/Sources/Timeline/TL_NingSZ_die"
	},
	[40144] = {
		Id = 40144,
		timeline = "Battle/Role/Monster/NingSZ/Sources/Timeline/TL_NingSZ_skill_1"
	},
	[40145] = {
		Id = 40145,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Monster/NingSZ/Sources/Timeline/TL_NingSZ_special_1"
	},
	[50011] = {
		Id = 50011,
		Cinemachine = "Battle/Role/Monster/Ya/Sources/Cinemachine/TL_Ya_born",
		timeline = "Battle/Role/Monster/Ya/Sources/Timeline/TL_Ya_born"
	},
	[50012] = {
		Id = 50012,
		Cinemachine = "Battle/Role/Monster/Ya/Sources/Cinemachine/TL_Ya_die",
		timeline = "Battle/Role/Monster/Ya/Sources/Timeline/TL_Ya_die"
	},
	[50013] = {
		Id = 50013,
		timeline = "Battle/Role/Monster/Ya/Sources/Timeline/TL_Ya_hit"
	},
	[50014] = {
		Id = 50014,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/Ya/Sources/Timeline/TL_Ya_attack_1",
		Cinemachine = "Battle/Role/Monster/Ya/Sources/Cinemachine/TL_Ya_attack_1",
		HitBindingType = 1
	},
	[50015] = {
		Id = 50015,
		HitType = 4,
		timeline = "Battle/Role/Monster/Ya/Sources/Timeline/TL_Ya_skill_1",
		Cinemachine = "Battle/Role/Monster/Ya/Sources/Cinemachine/TL_Ya_skill_1",
		ForceHitTarget = true
	},
	[50016] = {
		Id = 50016,
		HitType = 1,
		timeline = "Battle/Role/Monster/Ya/Sources/Timeline/TL_Ya_skill_2",
		Cinemachine = "Battle/Role/Monster/Ya/Sources/Cinemachine/TL_Ya_skill_2",
		ForceHitTarget = true
	},
	[50017] = {
		Id = 50017,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/Monster/Ya/Sources/Timeline/TL_Ya_special_1",
		Cinemachine = "Battle/Role/Monster/Ya/Sources/Cinemachine/TL_Ya_special_1",
		ForceHitTarget = true
	},
	[50091] = {
		Id = 50091,
		Cinemachine = "Battle/Role/Monster/HaiS_1/Sources/Cinemachine/TL_HaiS_1_born",
		MaskType = 1,
		timeline = "Battle/Role/Monster/HaiS_1/Sources/Timeline/TL_HaiS_1_born"
	},
	[50092] = {
		Id = 50092,
		timeline = "Battle/Role/Monster/HaiS_1/Sources/Timeline/TL_HaiS_1_die"
	},
	[50093] = {
		Id = 50093,
		HitType = 6,
		timeline = "Battle/Role/Monster/HaiS_1/Sources/Timeline/TL_HaiS_1_attack_1",
		Cinemachine = "Battle/Role/Monster/HaiS_1/Sources/Cinemachine/TL_HaiS_1_attack",
		HitBindingType = 1
	},
	[50094] = {
		Id = 50094,
		Cinemachine = "Battle/Role/Monster/HaiS_1/Sources/Cinemachine/TL_HaiS_1_skill_1",
		MaskType = 4,
		timeline = "Battle/Role/Monster/HaiS_1/Sources/Timeline/TL_HaiS_1_skill_1"
	},
	[50095] = {
		Id = 50095,
		Cinemachine = "Battle/Role/Monster/HaiS_1/Sources/Cinemachine/TL_HaiS_1_skill_2",
		MaskType = 4,
		timeline = "Battle/Role/Monster/HaiS_1/Sources/Timeline/TL_HaiS_1_skill_2"
	},
	[50096] = {
		Id = 50096,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Monster/HaiS_1/Sources/Timeline/TL_HaiS_1_special_1",
		Cinemachine = "Battle/Role/Monster/HaiS_1/Sources/Cinemachine/TL_HaiS_1_special_1"
	},
	[50097] = {
		Id = 50097,
		HitType = 5,
		Cinemachine = "Battle/Role/Monster/HaiS_1/Sources/Cinemachine/TL_HaiS_1_transform",
		timeline = "Battle/Role/Monster/HaiS_1/Sources/Timeline/TL_HaiS_1_transform"
	},
	[50101] = {
		Id = 50101,
		Cinemachine = "Battle/Role/Monster/HaiS_2/Sources/Cinemachine/TL_HaiS_2_born",
		timeline = "Battle/Role/Monster/HaiS_2/Sources/Timeline/TL_HaiS_2_born"
	},
	[50102] = {
		Id = 50102,
		Cinemachine = "Battle/Role/Monster/HaiS_2/Sources/Cinemachine/TL_HaiS_2_die",
		timeline = "Battle/Role/Monster/HaiS_2/Sources/Timeline/TL_HaiS_2_die"
	},
	[50103] = {
		Id = 50103,
		HitType = 6,
		HitBindingType = 1,
		timeline = "Battle/Role/Monster/HaiS_2/Sources/Timeline/TL_HaiS_2_attack_1"
	},
	[50104] = {
		Id = 50104,
		Cinemachine = "Battle/Role/Monster/HaiS_2/Sources/Cinemachine/TL_HaiS_2_skill_1",
		MaskType = 4,
		timeline = "Battle/Role/Monster/HaiS_2/Sources/Timeline/TL_HaiS_2_skill_1"
	},
	[50105] = {
		Id = 50105,
		HitType = 1,
		MaskType = 4,
		timeline = "Battle/Role/Monster/HaiS_2/Sources/Timeline/TL_HaiS_2_skill_2"
	},
	[50106] = {
		Id = 50106,
		HitType = 6,
		MaskType = 4,
		timeline = "Battle/Role/Monster/HaiS_2/Sources/Timeline/TL_HaiS_2_special_1",
		Cinemachine = "Battle/Role/Monster/HaiS_2/Sources/Cinemachine/TL_HaiS_2_special_1"
	},
	[70001] = {
		Id = 70001,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/DIY/YingMTS/Sources/Timeline/TL_Water_DiySkill_01",
		Cinemachine = "Battle/Role/DIY/YingMTS/Sources/Cinemachine/TL_DIY_YingMTS_special_1",
		Caster = 150001,
		ForceHitTarget = true
	},
	[70003] = {
		Id = 70003,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/DIY/YingMTS/Sources/Timeline/TL_Water_DiySkill_01",
		Cinemachine = "Battle/Role/DIY/YingMTS/Sources/Cinemachine/TL_DIY_YingMTS_special_1",
		Caster = 150001,
		ForceHitTarget = true
	},
	[70004] = {
		Id = 70004,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/DIY/YingMTS/Sources/Timeline/TL_Water_DiySkill_01",
		Cinemachine = "Battle/Role/DIY/YingMTS/Sources/Cinemachine/TL_DIY_YingMTS_special_1",
		Caster = 150001,
		ForceHitTarget = true
	},
	[70005] = {
		Id = 70005,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/DIY/YingMTS/Sources/Timeline/TL_Water_DiySkill_01",
		Cinemachine = "Battle/Role/DIY/YingMTS/Sources/Cinemachine/TL_DIY_YingMTS_special_1",
		Caster = 150001,
		ForceHitTarget = true
	},
	[70006] = {
		Id = 70006,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/DIY/YingMTS/Sources/Timeline/TL_Water_DiySkill_01",
		Cinemachine = "Battle/Role/DIY/YingMTS/Sources/Cinemachine/TL_DIY_YingMTS_special_1",
		Caster = 150001,
		ForceHitTarget = true
	},
	[70007] = {
		Id = 70007,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/DIY/YingMTS/Sources/Timeline/TL_Water_DiySkill_01",
		Cinemachine = "Battle/Role/DIY/YingMTS/Sources/Cinemachine/TL_DIY_YingMTS_special_1",
		Caster = 150001,
		ForceHitTarget = true
	},
	[70008] = {
		Id = 70008,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/DIY/YingMTS/Sources/Timeline/TL_Water_DiySkill_01",
		Cinemachine = "Battle/Role/DIY/YingMTS/Sources/Cinemachine/TL_DIY_YingMTS_special_1",
		Caster = 150001,
		ForceHitTarget = true
	},
	[70009] = {
		MaskType = 4,
		timeline = "Battle/Role/DIY/YingMTS/Sources/Timeline/TL_Water_DiySkill_02",
		Id = 70009,
		Caster = 150001,
		ForceHitTarget = true
	},
	[70100] = {
		Id = 70100,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/DIY/HuaL/Sources/Timeline/TL_HuaL_special_1",
		Cinemachine = "Battle/Role/DIY/HuaL/Sources/Cinemachine/TL_Diy_HuaL_special_1",
		Caster = 150002,
		HitBindingType = 1,
		ForceHitTarget = true
	},
	[70101] = {
		Id = 70101,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/DIY/HuaL/Sources/Timeline/TL_HuaL_special_2",
		Cinemachine = "Battle/Role/DIY/HuaL/Sources/Cinemachine/TL_Diy_HuaL_special_2",
		Caster = 150002,
		HitBindingType = 3,
		ForceHitTarget = true
	},
	[70102] = {
		Id = 70102,
		MaskType = 4,
		timeline = "Battle/Role/DIY/HuaL/Sources/Timeline/TL_HuaL_special_3",
		Cinemachine = "Battle/Role/DIY/HuaL/Sources/Cinemachine/TL_Diy_HuaL_special_3",
		Caster = 150002,
		ForceHitTarget = true
	},
	[70103] = {
		Id = 70103,
		MaskType = 4,
		timeline = "Battle/Role/DIY/HuaL/Sources/Timeline/TL_HuaL_special_4",
		Cinemachine = "Battle/Role/DIY/HuaL/Sources/Cinemachine/TL_Diy_HuaL_special_4",
		Caster = 150002,
		ForceHitTarget = true
	},
	[70200] = {
		Id = 70200,
		HitType = 1,
		MaskType = 4,
		timeline = "Battle/Role/DIY/GongS/Sources/Timeline/TL_GongS_special_1",
		Cinemachine = "Battle/Role/DIY/GongS/Sources/Cinemachine/TL_Diy_GongS_special_1",
		Caster = 150003,
		HitBindingType = 1,
		ForceHitTarget = true
	},
	[70201] = {
		Id = 70201,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/DIY/GongS/Sources/Timeline/TL_GongS_special_2",
		Cinemachine = "Battle/Role/DIY/GongS/Sources/Cinemachine/TL_Diy_GongS_special_2",
		Caster = 150003,
		HitBindingType = 3,
		ForceHitTarget = true
	},
	[70202] = {
		Id = 70202,
		MaskType = 4,
		timeline = "Battle/Role/DIY/GongS/Sources/Timeline/TL_GongS_special_3",
		Cinemachine = "Battle/Role/DIY/GongS/Sources/Cinemachine/TL_Diy_GongS_special_3",
		Caster = 150003,
		ForceHitTarget = true
	},
	[70203] = {
		Id = 70203,
		MaskType = 4,
		timeline = "Battle/Role/DIY/GongS/Sources/Timeline/TL_GongS_special_4",
		Cinemachine = "Battle/Role/DIY/GongS/Sources/Cinemachine/TL_Diy_GongS_special_4",
		Caster = 150003,
		ForceHitTarget = true
	},
	[70300] = {
		Id = 70300,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/DIY/Six/Sources/Timeline/TL_SiX_special_1",
		Cinemachine = "Battle/Role/DIY/Six/Sources/Cinemachine/TL_Diy_SiX_special_1",
		Caster = 150004,
		HitBindingType = 1,
		ForceHitTarget = true
	},
	[70301] = {
		Id = 70301,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/DIY/Six/Sources/Timeline/TL_SiX_special_2",
		Cinemachine = "Battle/Role/DIY/Six/Sources/Cinemachine/TL_Diy_SiX_special_2",
		Caster = 150004,
		HitBindingType = 3,
		ForceHitTarget = true
	},
	[70302] = {
		Id = 70302,
		HitType = 1,
		MaskType = 4,
		timeline = "Battle/Role/DIY/Six/Sources/Timeline/TL_SiX_special_3",
		Cinemachine = "Battle/Role/DIY/Six/Sources/Cinemachine/TL_Diy_SiX_special_3",
		Caster = 150004,
		HitBindingType = 1,
		ForceHitTarget = true
	},
	[70303] = {
		Id = 70303,
		HitType = 1,
		MaskType = 4,
		timeline = "Battle/Role/DIY/Six/Sources/Timeline/TL_SiX_special_4",
		Cinemachine = "Battle/Role/DIY/Six/Sources/Cinemachine/TL_Diy_SiX_special_4",
		Caster = 150004,
		HitBindingType = 1,
		ForceHitTarget = true
	},
	[70400] = {
		Id = 70400,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/DIY/XiangZ/Sources/Timeline/TL_XiangZ_special_1",
		Cinemachine = "Battle/Role/DIY/XiangZ/Sources/Cinemachine/TL_Diy_XiangZ_special_1",
		Caster = 150005,
		HitBindingType = 1,
		ForceHitTarget = true
	},
	[70401] = {
		Id = 70401,
		HitType = 4,
		MaskType = 4,
		timeline = "Battle/Role/DIY/XiangZ/Sources/Timeline/TL_XiangZ_special_2",
		Cinemachine = "Battle/Role/DIY/XiangZ/Sources/Cinemachine/TL_Diy_XiangZ_special_2",
		Caster = 150005,
		HitBindingType = 3,
		ForceHitTarget = true
	},
	[70402] = {
		Id = 70402,
		MaskType = 4,
		timeline = "Battle/Role/DIY/XiangZ/Sources/Timeline/TL_XiangZ_special_3",
		Cinemachine = "Battle/Role/DIY/XiangZ/Sources/Cinemachine/TL_Diy_XiangZ_special_3",
		Caster = 150005,
		ForceHitTarget = true
	},
	[70403] = {
		Id = 70403,
		MaskType = 4,
		timeline = "Battle/Role/DIY/XiangZ/Sources/Timeline/TL_XiangZ_special_4",
		Cinemachine = "Battle/Role/DIY/XiangZ/Sources/Cinemachine/TL_Diy_XiangZ_special_4",
		Caster = 150005,
		ForceHitTarget = true
	},
	[38011] = {
		Id = 38011,
		timeline = "Battle/Role/Monster/AiH/Sources/Timeline/TL_AiH_born"
	},
	[38012] = {
		Id = 38012,
		timeline = "Battle/Role/Monster/AiH/Sources/Timeline/TL_AiH_die"
	},
	[38013] = {
		Id = 38013,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/AiH/Sources/Timeline/TL_AiH_attack_1"
	},
	[38014] = {
		Id = 38014,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/AiH/Sources/Timeline/TL_AiH_special_1"
	},
	[38021] = {
		Id = 38021,
		timeline = "Battle/Role/Monster/QianCZ/Sources/Timeline/TL_QianCZ_born"
	},
	[38022] = {
		Id = 38022,
		timeline = "Battle/Role/Monster/QianCZ/Sources/Timeline/TL_QianCZ_die"
	},
	[38023] = {
		Id = 38023,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/QianCZ/Sources/Timeline/TL_QianCZ_attack_1"
	},
	[38024] = {
		Id = 38024,
		HitType = 2,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/QianCZ/Sources/Timeline/TL_QianCZ_special_1"
	},
	[38031] = {
		Id = 38031,
		timeline = "Battle/Role/Monster/EY/Sources/Timeline/TL_EY_born"
	},
	[38032] = {
		Id = 38032,
		timeline = "Battle/Role/Monster/EY/Sources/Timeline/TL_EY_die"
	},
	[38033] = {
		Id = 38033,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/EY/Sources/Timeline/TL_EY_attack_1"
	},
	[38034] = {
		Id = 38034,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/EY/Sources/Timeline/TL_EY_special_1"
	},
	[48011] = {
		Id = 48011,
		timeline = "Battle/Role/Monster/ShiH/Sources/Timeline/TL_ShiH_born"
	},
	[48012] = {
		Id = 48012,
		timeline = "Battle/Role/Monster/ShiH/Sources/Timeline/TL_ShiH_die"
	},
	[48013] = {
		Id = 48013,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/ShiH/Sources/Timeline/TL_ShiH_attack_1"
	},
	[48014] = {
		Id = 48014,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/ShiH/Sources/Timeline/TL_ShiH_special_1"
	},
	[48015] = {
		Id = 48015,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/ShiH/Sources/Timeline/TL_ShiH_skill_1"
	},
	[48021] = {
		Id = 48021,
		timeline = "Battle/Role/Monster/NingSZ/Sources/Timeline/TL_NingSZ_born"
	},
	[48022] = {
		Id = 48022,
		timeline = "Battle/Role/Monster/NingSZ/Sources/Timeline/TL_NingSZ_die"
	},
	[48023] = {
		Id = 48023,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/NingSZ/Sources/Timeline/TL_NingSZ_attack_1"
	},
	[48024] = {
		Id = 48024,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/NingSZ/Sources/Timeline/TL_NingSZ_skill_1"
	},
	[48025] = {
		Id = 48025,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/NingSZ/Sources/Timeline/TL_NingSZ_special_1"
	},
	[48031] = {
		Id = 48031,
		timeline = "Battle/Role/Monster/HunDEY/Sources/Timeline/TL_HunDEY_born"
	},
	[48032] = {
		Id = 48032,
		timeline = "Battle/Role/Monster/HunDEY/Sources/Timeline/TL_HunDEY_die"
	},
	[48033] = {
		Id = 48033,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/HunDEY/Sources/Timeline/TL_HunDEY_attack_1"
	},
	[48034] = {
		Id = 48034,
		HitType = 1,
		ForceHitTarget = true,
		timeline = "Battle/Role/Monster/HunDEY/Sources/Timeline/TL_HunDEY_special_1"
	},
	[63064] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/YuHSZL_Hand_R/Sources/Timeline/TL_YuHSZL_Hand_R",
		Id = 63064,
		HitBindingType = 1
	},
	[63074] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/YuHSZL_Hand_L/Sources/Timeline/TL_YuHSZL_Hand_L",
		Id = 63074,
		HitBindingType = 1
	},
	[90001] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/YuHSZL_Body/Sources/Timeline/TL_YuHSZL_Body",
		Id = 90001,
		HitBindingType = 1
	},
	[90002] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/YuHSZL_Hand_R/Sources/Timeline/TL_YuHSZL_Hand_R",
		Id = 90002,
		HitBindingType = 1
	},
	[90003] = {
		ForceHitTarget = true,
		HitType = 1,
		timeline = "Battle/Role/Monster/YuHSZL_Hand_L/Sources/Timeline/TL_YuHSZL_Hand_L",
		Id = 90003,
		HitBindingType = 1
	}
}

setmetatable(CfgTimelineTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTimelineTable]")
	end
})

local defaultMetaTable = {
	__index = {
		HitShowType = 0,
		HitType = 0,
		IsHideTile = false,
		ForceHitTarget = false,
		CloseRoleEffect = false,
		BehaviorTree = "",
		MaskType = 0,
		timeline = "",
		Cinemachine = "",
		Caster = 0,
		HitBindingType = 0
	}
}

for i, data in pairs(CfgTimelineTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTimelineTable
