-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResStageBonusPredict.lua

local RT = {}

RT[1] = {
	1,
	1,
	12
}
RT[2] = {
	1,
	1,
	15
}
RT[3] = {
	1,
	2,
	6
}
RT[4] = {
	1,
	2,
	15
}
RT[5] = {
	1,
	2,
	24
}
RT[6] = {
	1,
	3,
	15
}
RT[7] = {
	1,
	3,
	24
}
RT[8] = {
	1,
	3,
	30
}
RT[9] = {
	1,
	4,
	6
}
RT[10] = {
	1,
	4,
	30
}
RT[11] = {
	1,
	5,
	1
}
RT[12] = {
	1,
	5,
	30
}
RT[13] = {
	1,
	6,
	6
}
RT[14] = {
	1,
	6,
	30
}
RT[15] = {
	1,
	7,
	30
}
RT[16] = {
	1,
	8,
	30
}
RT[17] = {
	1,
	9,
	1
}
RT[18] = {
	1,
	9,
	30
}
RT[19] = {
	1,
	10,
	30
}
RT[20] = {
	1,
	11,
	30
}
RT[21] = {
	1,
	12,
	30
}
RT[22] = {
	1,
	13,
	30
}
RT[23] = {
	1,
	14,
	30
}
RT[24] = {
	1,
	15,
	30
}
RT[25] = {
	1,
	16,
	1
}
RT[26] = {
	1,
	16,
	30
}
RT[27] = {
	1,
	17,
	30
}
RT[28] = {
	1,
	18,
	30
}
RT[29] = {
	1,
	19,
	30
}
RT[30] = {
	1,
	20,
	1
}
RT[31] = {
	1,
	20,
	30
}
RT[32] = {
	1,
	21,
	30
}
RT[33] = {
	1,
	22,
	30
}
RT[34] = {
	1,
	23,
	30
}
RT[35] = {
	1,
	24,
	30
}
RT[36] = {
	1,
	25,
	30
}
RT[37] = {
	1,
	26,
	1
}
RT[38] = {
	1,
	26,
	30
}
RT[39] = {
	1,
	27,
	30
}
RT[40] = {
	1,
	28,
	30
}
RT[41] = {
	1,
	29,
	30
}
RT[42] = {
	1,
	30,
	30
}
RT[43] = {
	1,
	31,
	30
}
RT[44] = {
	1,
	32,
	30
}
RT[45] = {
	1,
	33,
	30
}
RT[46] = {
	1,
	34,
	30
}
RT[47] = {
	1,
	35,
	30
}
RT[48] = {
	1,
	36,
	30
}
RT[49] = {
	1,
	37,
	30
}
RT[50] = {
	1,
	38,
	30
}
RT[51] = {
	1,
	39,
	30
}
RT[52] = {
	1,
	40,
	30
}
RT[53] = {
	1,
	41,
	30
}
RT[54] = {
	1,
	42,
	30
}
RT[55] = {
	1,
	43,
	30
}
RT[56] = {
	1,
	44,
	30
}

local Data = {
	{
		bonus_num = 10,
		target_desc = "1-12",
		spec_icon_path = "Atlas/TaskAtlas/TaskPreviewAtlas01",
		bonus_id = 590601,
		relate_achieve = 4,
		rec_level = 15,
		spec_icon = "IconPreviewReward01",
		id = 1,
		begin_stage = {
			1,
			1,
			1
		},
		bonus_desc = Lang.get(15364),
		end_stage = RT[1]
	},
	{
		ban_stage_show = 1,
		bonus_num = 1,
		bonus_id = 590602,
		relate_achieve = 5,
		rec_level = 15,
		id = 2,
		begin_stage = RT[1],
		end_stage = RT[2],
		target_desc = Lang.get(45453)
	},
	{
		target_desc = "2-6",
		play_des_id = 186,
		bonus_id = 590691,
		bonus_num = 1,
		rec_level = 20,
		id = 3,
		begin_stage = RT[2],
		bonus_desc = Lang.get(45410),
		end_stage = RT[3]
	},
	{
		target_desc = "2-15",
		jump_id = 78,
		play_des_id = 187,
		bonus_id = 590651,
		bonus_num = 1,
		rec_level = 20,
		id = 4,
		begin_stage = RT[3],
		bonus_desc = Lang.get(15366),
		end_stage = RT[4]
	},
	{
		ban_stage_show = 1,
		bonus_num = 1,
		bonus_id = 590603,
		relate_achieve = 13,
		rec_level = 25,
		id = 5,
		begin_stage = RT[4],
		end_stage = RT[5],
		target_desc = Lang.get(45454)
	},
	{
		spec_icon_path = "Atlas/TaskAtlas/TaskPreviewAtlas01",
		play_des_id = 192,
		bonus_id = 590694,
		bonus_num = 1,
		rec_level = 25,
		spec_icon = "IconPreviewReward02",
		id = 6,
		begin_stage = RT[4],
		bonus_desc = Lang.get(45413),
		end_stage = RT[5],
		target_desc = Lang.get(45454)
	},
	{
		target_desc = "3-15",
		play_des_id = 188,
		bonus_id = 590692,
		bonus_num = 1,
		rec_level = 30,
		id = 7,
		begin_stage = RT[5],
		bonus_desc = Lang.get(45583),
		end_stage = RT[6]
	},
	{
		target_desc = "3-24",
		jump_id = 79,
		play_des_id = 189,
		bonus_id = 590652,
		bonus_num = 1,
		rec_level = 35,
		id = 8,
		begin_stage = RT[6],
		bonus_desc = Lang.get(15368),
		end_stage = RT[7]
	},
	{
		jump_id = 80,
		play_des_id = 190,
		bonus_id = 590653,
		bonus_num = 1,
		rec_level = 35,
		id = 9,
		begin_stage = RT[7],
		bonus_desc = Lang.get(15370),
		end_stage = RT[8],
		target_desc = Lang.get(45455)
	},
	{
		target_desc = "4-6",
		play_des_id = 191,
		bonus_id = 590693,
		bonus_num = 1,
		rec_level = 40,
		id = 10,
		begin_stage = RT[8],
		bonus_desc = Lang.get(45412),
		end_stage = RT[9]
	},
	{
		ban_stage_show = 1,
		jump_id = 34,
		relate_achieve = 34,
		bonus_id = 590653,
		bonus_num = 1,
		rec_level = 45,
		id = 11,
		begin_stage = RT[9],
		end_stage = RT[10],
		target_desc = Lang.get(45456)
	},
	{
		target_desc = "5-1",
		jump_id = 81,
		play_des_id = 193,
		bonus_id = 590654,
		bonus_num = 1,
		rec_level = 45,
		id = 12,
		begin_stage = RT[10],
		bonus_desc = Lang.get(15372),
		end_stage = RT[11]
	},
	{
		ban_stage_show = 1,
		jump_id = 73,
		relate_achieve = 44,
		bonus_id = 590606,
		bonus_num = 1,
		rec_level = 55,
		id = 13,
		begin_stage = RT[11],
		end_stage = RT[12],
		target_desc = Lang.get(45355)
	},
	{
		target_desc = "6-6",
		play_des_id = 194,
		bonus_id = 590695,
		bonus_num = 1,
		rec_level = 60,
		id = 14,
		begin_stage = RT[12],
		bonus_desc = Lang.get(45473),
		end_stage = RT[13]
	},
	{
		relate_achieve = 54,
		jump_id = 73,
		bonus_id = 590607,
		bonus_num = 1,
		rec_level = 70,
		id = 15,
		begin_stage = RT[13],
		bonus_desc = Lang.get(15376),
		end_stage = RT[14],
		target_desc = Lang.get(45356)
	},
	{
		relate_achieve = 64,
		jump_id = 73,
		bonus_id = 590608,
		bonus_num = 1,
		rec_level = 85,
		id = 16,
		begin_stage = RT[14],
		bonus_desc = Lang.get(15378),
		end_stage = RT[15],
		target_desc = Lang.get(45357)
	},
	{
		ban_stage_show = 1,
		jump_id = 73,
		relate_achieve = 74,
		bonus_id = 590609,
		bonus_num = 1,
		rec_level = 95,
		id = 17,
		begin_stage = RT[15],
		end_stage = RT[16],
		target_desc = Lang.get(45358)
	},
	{
		spec_icon_path = "Atlas/TaskAtlas/TaskPreviewAtlas01",
		target_desc = "9-1",
		play_des_id = 195,
		bonus_id = 590696,
		bonus_num = 1,
		rec_level = 95,
		spec_icon = "IconPreviewReward03",
		id = 18,
		begin_stage = RT[16],
		bonus_desc = Lang.get(45415),
		end_stage = RT[17]
	},
	{
		ban_stage_show = 1,
		jump_id = 73,
		relate_achieve = 84,
		bonus_id = 590610,
		bonus_num = 1,
		rec_level = 110,
		id = 19,
		begin_stage = RT[17],
		end_stage = RT[18],
		target_desc = Lang.get(45359)
	},
	{
		relate_achieve = 94,
		jump_id = 73,
		bonus_id = 590611,
		bonus_num = 1,
		rec_level = 120,
		id = 20,
		begin_stage = RT[18],
		bonus_desc = Lang.get(15384),
		end_stage = RT[19],
		target_desc = Lang.get(45360)
	},
	{
		relate_achieve = 104,
		jump_id = 73,
		bonus_id = 590612,
		bonus_num = 1,
		rec_level = 130,
		id = 21,
		begin_stage = RT[19],
		bonus_desc = Lang.get(15386),
		end_stage = RT[20],
		target_desc = Lang.get(45361)
	},
	{
		relate_achieve = 114,
		jump_id = 73,
		spec_icon_path = "Atlas/TaskAtlas/TaskPreviewAtlas01",
		bonus_id = 590613,
		bonus_num = 1,
		rec_level = 135,
		spec_icon = "IconPreviewReward04",
		id = 22,
		begin_stage = RT[20],
		bonus_desc = Lang.get(15388),
		end_stage = RT[21],
		target_desc = Lang.get(45362)
	},
	{
		relate_achieve = 124,
		jump_id = 73,
		bonus_id = 590614,
		bonus_num = 1,
		rec_level = 140,
		id = 23,
		begin_stage = RT[21],
		bonus_desc = Lang.get(15388),
		end_stage = RT[22],
		target_desc = Lang.get(45363)
	},
	{
		relate_achieve = 134,
		jump_id = 73,
		bonus_id = 590615,
		bonus_num = 1,
		rec_level = 145,
		id = 24,
		begin_stage = RT[22],
		bonus_desc = Lang.get(15388),
		end_stage = RT[23],
		target_desc = Lang.get(45364)
	},
	{
		ban_stage_show = 1,
		jump_id = 73,
		relate_achieve = 144,
		bonus_id = 590616,
		bonus_num = 1,
		rec_level = 150,
		id = 25,
		begin_stage = RT[23],
		end_stage = RT[24],
		target_desc = Lang.get(45365)
	},
	{
		spec_icon_path = "Atlas/TaskAtlas/TaskPreviewAtlas02",
		target_desc = "16-1",
		play_des_id = 196,
		bonus_id = 590697,
		bonus_num = 1,
		rec_level = 150,
		spec_icon = "IconPreviewReward05",
		id = 26,
		begin_stage = RT[24],
		bonus_desc = Lang.get(45416),
		end_stage = RT[25]
	},
	{
		relate_achieve = 154,
		jump_id = 73,
		bonus_id = 590617,
		bonus_num = 1,
		rec_level = 155,
		id = 27,
		begin_stage = RT[25],
		bonus_desc = Lang.get(15388),
		end_stage = RT[26],
		target_desc = Lang.get(45366)
	},
	{
		relate_achieve = 164,
		jump_id = 73,
		bonus_id = 590618,
		bonus_num = 1,
		rec_level = 160,
		id = 28,
		begin_stage = RT[26],
		bonus_desc = Lang.get(15388),
		end_stage = RT[27],
		target_desc = Lang.get(45367)
	},
	{
		relate_achieve = 174,
		jump_id = 73,
		bonus_id = 590619,
		bonus_num = 1,
		rec_level = 165,
		id = 29,
		begin_stage = RT[27],
		bonus_desc = Lang.get(15388),
		end_stage = RT[28],
		target_desc = Lang.get(45368)
	},
	{
		ban_stage_show = 1,
		jump_id = 73,
		relate_achieve = 184,
		bonus_id = 590620,
		bonus_num = 1,
		rec_level = 170,
		id = 30,
		begin_stage = RT[28],
		end_stage = RT[29],
		target_desc = Lang.get(45369)
	},
	{
		spec_icon_path = "Atlas/TaskAtlas/TaskPreviewAtlas02",
		target_desc = "20-1",
		play_des_id = 197,
		bonus_id = 590698,
		bonus_num = 1,
		rec_level = 170,
		spec_icon = "IconPreviewReward06",
		id = 31,
		begin_stage = RT[29],
		bonus_desc = Lang.get(45620),
		end_stage = RT[30]
	},
	{
		relate_achieve = 194,
		jump_id = 73,
		bonus_id = 590621,
		bonus_num = 1,
		rec_level = 175,
		id = 32,
		begin_stage = RT[30],
		bonus_desc = Lang.get(15388),
		end_stage = RT[31],
		target_desc = Lang.get(45370)
	},
	{
		relate_achieve = 204,
		jump_id = 73,
		bonus_id = 590622,
		bonus_num = 1,
		rec_level = 180,
		id = 33,
		begin_stage = RT[31],
		bonus_desc = Lang.get(15388),
		end_stage = RT[32],
		target_desc = Lang.get(45371)
	},
	{
		relate_achieve = 214,
		jump_id = 73,
		bonus_id = 590623,
		bonus_num = 1,
		rec_level = 180,
		id = 34,
		begin_stage = RT[32],
		bonus_desc = Lang.get(15388),
		end_stage = RT[33],
		target_desc = Lang.get(45372)
	},
	{
		relate_achieve = 224,
		jump_id = 73,
		bonus_id = 590624,
		bonus_num = 1,
		rec_level = 185,
		id = 35,
		begin_stage = RT[33],
		bonus_desc = Lang.get(15388),
		end_stage = RT[34],
		target_desc = Lang.get(45373)
	},
	{
		relate_achieve = 234,
		jump_id = 73,
		bonus_id = 590625,
		bonus_num = 1,
		rec_level = 190,
		id = 36,
		begin_stage = RT[34],
		bonus_desc = Lang.get(15388),
		end_stage = RT[35],
		target_desc = Lang.get(45374)
	},
	{
		relate_achieve = 244,
		jump_id = 73,
		bonus_id = 590626,
		bonus_num = 1,
		rec_level = 195,
		id = 37,
		begin_stage = RT[35],
		bonus_desc = Lang.get(15388),
		end_stage = RT[36],
		target_desc = Lang.get(45375)
	},
	{
		target_desc = "26-1",
		play_des_id = 217,
		bonus_id = 590699,
		bonus_num = 1,
		rec_level = 195,
		id = 38,
		begin_stage = RT[36],
		bonus_desc = Lang.get(50091),
		end_stage = RT[37]
	},
	{
		relate_achieve = 254,
		jump_id = 73,
		bonus_id = 590627,
		bonus_num = 1,
		rec_level = 205,
		id = 39,
		begin_stage = RT[37],
		bonus_desc = Lang.get(15388),
		end_stage = RT[38],
		target_desc = Lang.get(45376)
	},
	{
		relate_achieve = 264,
		jump_id = 73,
		bonus_id = 590628,
		bonus_num = 1,
		rec_level = 210,
		id = 40,
		begin_stage = RT[38],
		bonus_desc = Lang.get(15388),
		end_stage = RT[39],
		target_desc = Lang.get(45377)
	},
	{
		relate_achieve = 274,
		jump_id = 73,
		bonus_id = 590629,
		bonus_num = 1,
		rec_level = 215,
		id = 41,
		begin_stage = RT[39],
		bonus_desc = Lang.get(15388),
		end_stage = RT[40],
		target_desc = Lang.get(45378)
	},
	{
		relate_achieve = 284,
		jump_id = 73,
		bonus_id = 590630,
		bonus_num = 1,
		rec_level = 220,
		id = 42,
		begin_stage = RT[40],
		bonus_desc = Lang.get(15388),
		end_stage = RT[41],
		target_desc = Lang.get(45379)
	},
	{
		relate_achieve = 294,
		jump_id = 73,
		bonus_id = 590631,
		bonus_num = 1,
		rec_level = 220,
		id = 43,
		begin_stage = RT[41],
		bonus_desc = Lang.get(15388),
		end_stage = RT[42],
		target_desc = Lang.get(45380)
	},
	{
		relate_achieve = 304,
		jump_id = 73,
		spec_icon_path = "Atlas/TaskAtlas/TaskPreviewAtlas02",
		bonus_id = 590633,
		bonus_num = 1,
		rec_level = 220,
		spec_icon = "IconPreviewReward07",
		id = 44,
		begin_stage = RT[42],
		bonus_desc = Lang.get(15408),
		end_stage = RT[43],
		target_desc = Lang.get(45381)
	},
	{
		relate_achieve = 314,
		jump_id = 73,
		bonus_id = 590635,
		bonus_num = 1,
		rec_level = 220,
		id = 45,
		begin_stage = RT[43],
		bonus_desc = Lang.get(15410),
		end_stage = RT[44],
		target_desc = Lang.get(45382)
	},
	{
		relate_achieve = 324,
		jump_id = 73,
		bonus_id = 510009,
		bonus_num = 30,
		rec_level = 220,
		id = 46,
		begin_stage = RT[44],
		bonus_desc = Lang.get(47517),
		end_stage = RT[45],
		target_desc = Lang.get(47518)
	},
	{
		relate_achieve = 334,
		jump_id = 73,
		bonus_id = 520045,
		bonus_num = 3,
		rec_level = 220,
		id = 47,
		begin_stage = RT[45],
		bonus_desc = Lang.get(48316),
		end_stage = RT[46],
		target_desc = Lang.get(48317)
	},
	{
		relate_achieve = 344,
		jump_id = 73,
		bonus_id = 520045,
		bonus_num = 3,
		rec_level = 220,
		id = 48,
		begin_stage = RT[46],
		bonus_desc = Lang.get(48316),
		end_stage = RT[47],
		target_desc = Lang.get(54760)
	},
	{
		relate_achieve = 354,
		jump_id = 73,
		bonus_id = 520045,
		bonus_num = 3,
		rec_level = 220,
		id = 49,
		begin_stage = RT[47],
		bonus_desc = Lang.get(48316),
		end_stage = RT[48],
		target_desc = Lang.get(67060)
	},
	{
		relate_achieve = 364,
		jump_id = 73,
		bonus_id = 520045,
		bonus_num = 3,
		rec_level = 220,
		id = 50,
		begin_stage = RT[48],
		bonus_desc = Lang.get(48316),
		end_stage = RT[49],
		target_desc = Lang.get(75203)
	},
	{
		jump_id = 73,
		play_des_id = 352,
		bonus_id = 590700,
		bonus_num = 1,
		rec_level = 70,
		id = 51,
		begin_stage = RT[13],
		bonus_desc = Lang.get(75903),
		end_stage = RT[14],
		target_desc = Lang.get(45356)
	},
	{
		relate_achieve = 374,
		jump_id = 73,
		bonus_id = 520045,
		bonus_num = 3,
		rec_level = 220,
		id = 52,
		begin_stage = RT[49],
		bonus_desc = Lang.get(48316),
		end_stage = RT[50],
		target_desc = Lang.get(80341)
	},
	{
		relate_achieve = 384,
		jump_id = 73,
		bonus_id = 520045,
		bonus_num = 3,
		rec_level = 220,
		id = 53,
		begin_stage = RT[50],
		bonus_desc = Lang.get(48316),
		end_stage = RT[51],
		target_desc = Lang.get(85201)
	},
	{
		relate_achieve = 394,
		jump_id = 73,
		bonus_id = 520045,
		bonus_num = 3,
		rec_level = 220,
		id = 54,
		begin_stage = RT[51],
		bonus_desc = Lang.get(48316),
		end_stage = RT[52],
		target_desc = Lang.get(92948)
	},
	{
		relate_achieve = 404,
		jump_id = 73,
		bonus_id = 520045,
		bonus_num = 3,
		rec_level = 220,
		id = 55,
		begin_stage = RT[52],
		bonus_desc = Lang.get(48316),
		end_stage = RT[53],
		target_desc = Lang.get(98048)
	},
	{
		relate_achieve = 414,
		jump_id = 73,
		bonus_id = 520045,
		bonus_num = 3,
		rec_level = 220,
		id = 56,
		begin_stage = RT[53],
		bonus_desc = Lang.get(48316),
		end_stage = RT[54],
		target_desc = Lang.get(102995)
	},
	{
		relate_achieve = 424,
		jump_id = 73,
		bonus_id = 520045,
		bonus_num = 3,
		rec_level = 220,
		id = 57,
		begin_stage = RT[54],
		bonus_desc = Lang.get(48316),
		end_stage = RT[55],
		target_desc = Lang.get(106961)
	},
	{
		relate_achieve = 434,
		jump_id = 73,
		bonus_id = 520045,
		bonus_num = 3,
		rec_level = 220,
		id = 58,
		begin_stage = RT[55],
		bonus_desc = Lang.get(48316),
		end_stage = RT[56],
		target_desc = Lang.get(114921)
	},
	{
		relate_achieve = 444,
		jump_id = 73,
		bonus_id = 520045,
		bonus_num = 3,
		rec_level = 220,
		id = 59,
		begin_stage = RT[56],
		bonus_desc = Lang.get(48316),
		end_stage = {
			1,
			45,
			30
		},
		target_desc = Lang.get(117277)
	}
}

return Data
