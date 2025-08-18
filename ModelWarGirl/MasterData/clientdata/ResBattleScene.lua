-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResBattleScene.lua

local RT = {}

RT[1] = {
	187.99,
	70.185,
	247.47
}
RT[2] = {
	"Dynamic Scene Loder/battle_dachangjing_001(Clone)/weilan (17)",
	"Dynamic Scene Loder/battle_dachangjing_001(Clone)/weilan (14)"
}
RT[3] = {
	4,
	3
}
RT[4] = {
	2,
	1.1
}
RT[5] = {
	66.511,
	34.201,
	231.53
}
RT[6] = {
	1,
	3
}
RT[7] = {
	-15.3,
	-0.17,
	96.55
}
RT[8] = {
	"Dynamic Scene Loder/battle_dachangjing_001(Clone)/zhuangzi_002"
}
RT[9] = {
	-15.336,
	-0.141,
	312.001
}
RT[10] = {
	1.8,
	0,
	-0.28
}
RT[11] = {
	-1137.19,
	13.376,
	-145.93
}
RT[12] = {
	1,
	3,
	0.2
}
RT[13] = {
	-1083.54,
	4.33,
	-123.36
}
RT[14] = {
	-1189.65,
	29.98,
	-229.44
}
RT[15] = {
	-1231.76,
	8.28,
	-73.01
}
RT[16] = {
	-175.8,
	105.34,
	1581.6
}
RT[17] = {
	"art/yj_chongwudian_chaifen"
}
RT[18] = {
	3.5,
	3
}
RT[19] = {
	-242.2,
	56.75,
	1619.3
}
RT[20] = {
	-151.3,
	56.68,
	1588.1
}
RT[21] = {
	33.89,
	29.115,
	-15.32
}
RT[22] = {
	-175.8,
	105.31,
	1581.6
}
RT[23] = {
	-151.3,
	56.64,
	1586.7
}
RT[24] = {
	67.78,
	157.99,
	-165.3
}
RT[25] = {
	173.746,
	96.14,
	-116.17
}
RT[26] = {
	-14.2,
	51.71,
	-47.095
}
RT[27] = {
	0.5954,
	-6.01,
	6.42
}
RT[28] = {
	"art/zw/zhao_zw_yuanyi (21)",
	"art/zw/zhao_zw_yuanyi (22)",
	"art/zw/zhao_zw_yuanyi (23)"
}
RT[29] = {
	30.959,
	0.01,
	0.3
}
RT[30] = {
	32.57,
	6.22,
	14.18
}
RT[31] = {
	18,
	180,
	0
}
RT[32] = {
	1,
	2.8
}
RT[33] = {
	30.959,
	0.01,
	0.4
}
RT[34] = {
	1.5,
	1.9
}
RT[35] = {
	0.5,
	5
}
RT[36] = {
	1,
	5
}
RT[37] = {
	3.4,
	62.8,
	70.4
}
RT[38] = {
	35,
	180,
	0
}

local Data = {
	[10001] = {
		id = 10001,
		dir = 0,
		path = "Scenes/Battles/battle_dachangjing_01.unity",
		origin_point = {
			-15.3,
			-0.18,
			96.55
		}
	},
	[10002] = {
		enter_camera = "start_chaokujiequ_tiantai.anim",
		path = "Scenes/Battles/battle_dachangjing_01.unity",
		result_camera = "end_tiantai.anim",
		dynamic_path = "battle_dachangjing_01/tiantai_chunk_4.prefab",
		dir = 0,
		result_light = 0,
		bgm = 10,
		id = 10002,
		chuyin_pos = RT[3],
		hide_go_name = RT[2],
		origin_point = RT[1],
		pet_skill_pos = RT[4]
	},
	[10003] = {
		enter_camera = "start_chaokujiequ_changyi.anim",
		path = "Scenes/Battles/battle_dachangjing_01.unity",
		result_camera = "end_changyi.anim",
		dynamic_path = "battle_dachangjing_01/changyi_chunk_3.prefab",
		dir = 0,
		result_light = 0,
		bgm = 10,
		id = 10003,
		chuyin_pos = RT[6],
		origin_point = RT[5],
		pet_skill_pos = RT[4]
	},
	[10004] = {
		enter_camera = "start_chaokujiequ_malujinggai.anim",
		path = "Scenes/Battles/battle_dachangjing_01.unity",
		result_camera = "end_malujinggai.anim",
		dynamic_path = "battle_dachangjing_01/malujinggai_chunk_1.prefab",
		dir = 0,
		result_light = 0,
		bgm = 10,
		id = 10004,
		chuyin_pos = RT[3],
		hide_go_name = RT[8],
		origin_point = RT[7],
		pet_skill_pos = RT[4]
	},
	[10005] = {
		enter_camera = "start_chaokujiequ_maluyouqi.anim",
		path = "Scenes/Battles/battle_dachangjing_01.unity",
		result_camera = "end_maluyouqi.anim",
		dynamic_path = "battle_dachangjing_01/maluyouqi_chunk_2.prefab",
		dir = 0,
		result_light = 0,
		bgm = 10,
		id = 10005,
		chuyin_pos = RT[3],
		origin_point = RT[9],
		pet_skill_pos = RT[4]
	},
	[10006] = {
		id = 10006,
		dir = 0,
		path = "Scenes/Battles/battle_commonroom.unity",
		origin_point = RT[10]
	},
	[10011] = {
		id = 10011,
		dir = 0,
		path = "Scenes/Battles/battle_commonroom.unity",
		origin_point = RT[10]
	},
	[10012] = {
		result_light = 0,
		result_camera = "end_tiantai.anim",
		path = "Scenes/Battles/battle_dachangjing_01.unity",
		dynamic_path = "battle_dachangjing_01/tiantai_chunk_4.prefab",
		dir = 0,
		bgm = 10,
		id = 10012,
		chuyin_pos = RT[3],
		hide_go_name = RT[2],
		origin_point = RT[1],
		pet_skill_pos = RT[4]
	},
	[10013] = {
		result_light = 0,
		result_camera = "end_changyi.anim",
		path = "Scenes/Battles/battle_dachangjing_01.unity",
		dynamic_path = "battle_dachangjing_01/changyi_chunk_3.prefab",
		dir = 0,
		bgm = 10,
		id = 10013,
		chuyin_pos = RT[6],
		origin_point = RT[5],
		pet_skill_pos = RT[4]
	},
	[10014] = {
		result_light = 0,
		result_camera = "end_malujinggai.anim",
		path = "Scenes/Battles/battle_dachangjing_01.unity",
		dynamic_path = "battle_dachangjing_01/malujinggai_chunk_1.prefab",
		dir = 0,
		bgm = 10,
		id = 10014,
		chuyin_pos = RT[3],
		hide_go_name = RT[8],
		origin_point = RT[7],
		pet_skill_pos = RT[4]
	},
	[10015] = {
		result_light = 0,
		result_camera = "end_maluyouqi.anim",
		path = "Scenes/Battles/battle_dachangjing_01.unity",
		dynamic_path = "battle_dachangjing_01/maluyouqi_chunk_2.prefab",
		dir = 0,
		bgm = 10,
		id = 10015,
		chuyin_pos = RT[3],
		origin_point = RT[9],
		pet_skill_pos = RT[4]
	},
	[20001] = {
		enter_camera = "start_youleyuan_huatan.anim",
		path = "Scenes/Battles/battle_youleyuan_001.unity",
		result_light = 0,
		dynamic_path = "battle_youleyuan_001/huatan_chunk_2.prefab",
		dir = 0,
		bgm = 10,
		id = 20001,
		chuyin_pos = RT[12],
		origin_point = RT[11],
		pet_skill_pos = RT[4]
	},
	[20002] = {
		enter_camera = "start_youleyuan_qinshuitai.anim",
		path = "Scenes/Battles/battle_youleyuan_001.unity",
		result_light = 0,
		dynamic_path = "battle_youleyuan_001/qinshuitai_chunk_3.prefab",
		dir = 0,
		bgm = 10,
		id = 20002,
		chuyin_pos = RT[12],
		origin_point = RT[13],
		pet_skill_pos = RT[4]
	},
	[20003] = {
		enter_camera = "start_youleyuan_taiyangsan.anim",
		path = "Scenes/Battles/battle_youleyuan_001.unity",
		result_light = 0,
		dynamic_path = "battle_youleyuan_001/taiyangsan_chunk_1.prefab",
		dir = 0,
		bgm = 10,
		id = 20003,
		chuyin_pos = RT[6],
		origin_point = RT[14],
		pet_skill_pos = RT[4]
	},
	[20004] = {
		enter_camera = "start_youleyuan_youting.anim",
		path = "Scenes/Battles/battle_youleyuan_001.unity",
		result_light = 0,
		dynamic_path = "battle_youleyuan_001/youting_chunk_4.prefab",
		dir = 0,
		bgm = 10,
		id = 20004,
		chuyin_pos = RT[6],
		origin_point = RT[15],
		pet_skill_pos = RT[4]
	},
	[20011] = {
		result_light = 0,
		path = "Scenes/Battles/battle_youleyuan_001.unity",
		dynamic_path = "battle_youleyuan_001/huatan_chunk_2.prefab",
		dir = 0,
		bgm = 10,
		id = 20011,
		chuyin_pos = RT[12],
		origin_point = RT[11],
		pet_skill_pos = RT[4]
	},
	[20012] = {
		result_light = 0,
		path = "Scenes/Battles/battle_youleyuan_001.unity",
		dynamic_path = "battle_youleyuan_001/qinshuitai_chunk_3.prefab",
		dir = 0,
		bgm = 10,
		id = 20012,
		chuyin_pos = RT[12],
		origin_point = RT[13],
		pet_skill_pos = RT[4]
	},
	[20013] = {
		result_light = 0,
		path = "Scenes/Battles/battle_youleyuan_001.unity",
		dynamic_path = "battle_youleyuan_001/taiyangsan_chunk_1.prefab",
		dir = 0,
		bgm = 10,
		id = 20013,
		chuyin_pos = RT[6],
		origin_point = RT[14],
		pet_skill_pos = RT[4]
	},
	[20014] = {
		result_light = 0,
		path = "Scenes/Battles/battle_youleyuan_001.unity",
		dynamic_path = "battle_youleyuan_001/youting_chunk_4.prefab",
		dir = 0,
		bgm = 10,
		id = 20014,
		chuyin_pos = RT[6],
		origin_point = RT[15],
		pet_skill_pos = RT[4]
	},
	[30001] = {
		id = 30001,
		path = "Scenes/Battles/battle_commonroom.unity",
		bgm = 10,
		origin_point = RT[10]
	},
	[30002] = {
		enter_camera = "start_juminqu_yangtai.anim",
		path = "Scenes/Battles/battle_jiedao_001.unity",
		result_light = 0,
		dynamic_path = "battle_jiedao_001/yangtai_chunk_1.prefab",
		dir = 0,
		bgm = 10,
		id = 30002,
		chuyin_pos = RT[18],
		hide_go_name = RT[17],
		origin_point = RT[16],
		pet_skill_pos = RT[4]
	},
	[30003] = {
		enter_camera = "start_juminqu_chongwufanwan.anim",
		path = "Scenes/Battles/battle_jiedao_001.unity",
		result_light = 0,
		dynamic_path = "battle_jiedao_001/chongwufanwan_chunk_2.prefab",
		dir = 0,
		bgm = 10,
		id = 30003,
		chuyin_pos = RT[6],
		origin_point = RT[19],
		pet_skill_pos = RT[4]
	},
	[30004] = {
		enter_camera = "start_juminqu_zhaopai.anim",
		path = "Scenes/Battles/battle_jiedao_001.unity",
		result_light = 0,
		dynamic_path = "battle_jiedao_001/zhaopai_chunk_3.prefab",
		dir = 0,
		bgm = 10,
		id = 30004,
		chuyin_pos = RT[6],
		origin_point = RT[20],
		pet_skill_pos = RT[4]
	},
	[30012] = {
		result_light = 0,
		path = "Scenes/Battles/battle_jiedao_001.unity",
		dynamic_path = "battle_jiedao_001/yangtai_chunk_1.prefab",
		dir = 0,
		bgm = 10,
		id = 30012,
		chuyin_pos = RT[18],
		hide_go_name = RT[17],
		origin_point = RT[16],
		pet_skill_pos = RT[4]
	},
	[30013] = {
		result_light = 0,
		path = "Scenes/Battles/battle_jiedao_001.unity",
		dynamic_path = "battle_jiedao_001/chongwufanwan_chunk_2.prefab",
		dir = 0,
		bgm = 10,
		id = 30013,
		chuyin_pos = RT[6],
		origin_point = RT[19],
		pet_skill_pos = RT[4]
	},
	[30014] = {
		result_light = 0,
		path = "Scenes/Battles/battle_jiedao_001.unity",
		dynamic_path = "battle_jiedao_001/zhaopai_chunk_3.prefab",
		dir = 0,
		bgm = 10,
		id = 30014,
		chuyin_pos = RT[6],
		origin_point = RT[20],
		pet_skill_pos = RT[4]
	},
	[30015] = {
		enter_camera = "BattleTargetvCamera1001.anim",
		id = 30015,
		dynamic_path = "battle_jiedao_001/zhaopai_chunk_3.prefab",
		dir = 0,
		path = "Scenes/Battles/battle_jiedao_001.unity",
		result_light = 0,
		bgm = 10,
		origin_point = {
			-151.3,
			56.68,
			1586.7
		}
	},
	[30016] = {
		id = 30016,
		path = "Scenes/Battles/f_novice_01.unity",
		chuyin_pos = {
			1.4,
			3
		},
		origin_point = RT[21],
		pet_skill_pos = RT[4]
	},
	[30017] = {
		id = 30017,
		enter_camera = "start_xinshou.anim",
		path = "Scenes/Battles/f_novice_01.unity",
		origin_point = RT[21]
	},
	[31002] = {
		enter_camera = "start_juminqu_yangtai.anim",
		id = 31002,
		dynamic_path = "battle_jiedao_yj_002/yj_yangtai_chunk_1.prefab",
		dir = 0,
		path = "Scenes/Battles/battle_jiedao_yj_002.unity",
		bgm = 10,
		origin_point = RT[22]
	},
	[31003] = {
		enter_camera = "start_juminqu_chongwufanwan.anim",
		id = 31003,
		dynamic_path = "battle_jiedao_yj_002/yj_chongwufanwan_chunk_2.prefab",
		dir = 0,
		path = "Scenes/Battles/battle_jiedao_yj_002.unity",
		bgm = 10,
		origin_point = RT[19]
	},
	[31004] = {
		enter_camera = "start_juminqu_zhaopai.anim",
		id = 31004,
		dynamic_path = "battle_jiedao_yj_002/yj_zhaopai_chunk_3.prefab",
		dir = 0,
		path = "Scenes/Battles/battle_jiedao_yj_002.unity",
		bgm = 10,
		origin_point = RT[23]
	},
	[31012] = {
		dir = 0,
		path = "Scenes/Battles/battle_jiedao_yj_002.unity",
		id = 31012,
		bgm = 10,
		origin_point = RT[22]
	},
	[31013] = {
		dir = 0,
		path = "Scenes/Battles/battle_jiedao_yj_002.unity",
		id = 31013,
		bgm = 10,
		origin_point = {
			-242.2,
			56.68,
			1619.3
		}
	},
	[31014] = {
		dir = 0,
		path = "Scenes/Battles/battle_jiedao_yj_002.unity",
		id = 31014,
		bgm = 10,
		origin_point = RT[23]
	},
	[40001] = {
		dynamic_path = "battle_feiting_01/bridge_chunk_1.prefab",
		dir = 0,
		path = "Scenes/Battles/battle_feiting_01.unity",
		id = 40001,
		bgm = 10,
		chuyin_pos = RT[12],
		origin_point = {
			-33.3,
			89.144,
			139.77
		},
		pet_skill_pos = RT[4]
	},
	[40002] = {
		dynamic_path = "battle_feiting_01/cheding_chunk_2.prefab",
		dir = 0,
		path = "Scenes/Battles/battle_feiting_01.unity",
		id = 40002,
		bgm = 10,
		chuyin_pos = {
			3.5,
			3,
			0.2
		},
		origin_point = {
			-61.99,
			39.74,
			170.26
		},
		pet_skill_pos = RT[4]
	},
	[40003] = {
		dynamic_path = "battle_feiting_01/caozuoxiang_chunk_3.prefab",
		dir = 0,
		path = "Scenes/Battles/battle_feiting_01.unity",
		id = 40003,
		bgm = 10,
		chuyin_pos = RT[12],
		origin_point = {
			53.9,
			20.61,
			215.63
		},
		pet_skill_pos = RT[4]
	},
	[40004] = {
		dynamic_path = "battle_feiting_01/weixiuche_chunk_4.prefab",
		dir = 0,
		path = "Scenes/Battles/battle_feiting_01.unity",
		id = 40004,
		bgm = 10,
		chuyin_pos = RT[12],
		origin_point = {
			-45.94119,
			20.555,
			212.919
		},
		pet_skill_pos = RT[4]
	},
	[50001] = {
		dynamic_path = "battle_feiqifactory_01/fadianji_chunk_1.prefab",
		dir = 0,
		path = "Scenes/Battles/battle_feiqifactory_01.unity",
		id = 50001,
		bgm = 10,
		chuyin_pos = RT[18],
		origin_point = {
			99.1701,
			316.02,
			454.4899
		},
		pet_skill_pos = RT[4]
	},
	[50002] = {
		dynamic_path = "battle_feiqifactory_01/gongjuxiang_chunk_2.prefab",
		dir = 0,
		path = "Scenes/Battles/battle_feiqifactory_01.unity",
		id = 50002,
		bgm = 10,
		chuyin_pos = RT[6],
		origin_point = {
			-63.5072,
			316.02,
			444.1987
		},
		pet_skill_pos = RT[4]
	},
	[50003] = {
		dynamic_path = "battle_feiqifactory_01/youtong_chunk_3.prefab",
		dir = 0,
		path = "Scenes/Battles/battle_feiqifactory_01.unity",
		id = 50003,
		bgm = 10,
		chuyin_pos = RT[6],
		origin_point = {
			208.9955,
			326.187,
			331.9965
		},
		pet_skill_pos = RT[4]
	},
	[50004] = {
		dynamic_path = "battle_feiqifactory_01/lupai_chunk_4.prefab",
		dir = 0,
		path = "Scenes/Battles/battle_feiqifactory_01.unity",
		id = 50004,
		bgm = 10,
		chuyin_pos = RT[18],
		origin_point = {
			244.9755,
			315.996,
			269.4285
		},
		pet_skill_pos = RT[4]
	},
	[70001] = {
		enter_camera = "start_pata_01.anim",
		id = 70001,
		dir = 0,
		path = "Scenes/Battles/battle_pata_01.unity",
		bgm = 10,
		chuyin_pos = RT[6],
		origin_point = RT[24],
		pet_skill_pos = RT[4]
	},
	[70002] = {
		enter_camera = "start_pata_02.anim",
		id = 70002,
		dir = 0,
		path = "Scenes/Battles/battle_pata_01.unity",
		bgm = 10,
		chuyin_pos = RT[18],
		origin_point = RT[25],
		pet_skill_pos = RT[4]
	},
	[70003] = {
		enter_camera = "start_pata_03.anim",
		id = 70003,
		dir = 0,
		path = "Scenes/Battles/battle_pata_01.unity",
		bgm = 10,
		chuyin_pos = RT[6],
		origin_point = RT[26],
		pet_skill_pos = RT[4]
	},
	[70004] = {
		enter_camera = "start_pata_04.anim",
		path = "Scenes/Battles/battle_pata_01.unity",
		dir = 0,
		bgm = 10,
		id = 70004,
		chuyin_pos = RT[18],
		hide_go_name = RT[28],
		origin_point = RT[27],
		pet_skill_pos = RT[4]
	},
	[70005] = {
		enter_camera = "start_pata_02.anim",
		dir = 0,
		path = "Scenes/Battles/battle_pata_02.unity",
		id = 70005,
		bgm = 10,
		origin_point = RT[25]
	},
	[70011] = {
		path = "Scenes/Battles/battle_pata_01.unity",
		id = 70011,
		dir = 0,
		bgm = 10,
		chuyin_pos = RT[6],
		origin_point = RT[24],
		pet_skill_pos = RT[4]
	},
	[70012] = {
		path = "Scenes/Battles/battle_pata_01.unity",
		id = 70012,
		dir = 0,
		bgm = 10,
		chuyin_pos = RT[18],
		origin_point = RT[25],
		pet_skill_pos = RT[4]
	},
	[70013] = {
		path = "Scenes/Battles/battle_pata_01.unity",
		id = 70013,
		dir = 0,
		bgm = 10,
		chuyin_pos = RT[6],
		origin_point = RT[26],
		pet_skill_pos = RT[4]
	},
	[70014] = {
		path = "Scenes/Battles/battle_pata_01.unity",
		dir = 0,
		id = 70014,
		bgm = 10,
		chuyin_pos = RT[18],
		hide_go_name = RT[28],
		origin_point = RT[27],
		pet_skill_pos = RT[4]
	},
	[70015] = {
		dir = 0,
		path = "Scenes/Battles/battle_pata_02.unity",
		id = 70015,
		bgm = 10,
		origin_point = RT[25]
	},
	[70021] = {
		dir = 0,
		path = "Scenes/Battles/battle_pata_01.unity",
		id = 70021,
		bgm = 10,
		origin_point = RT[24]
	},
	[70022] = {
		dir = 0,
		path = "Scenes/Battles/battle_pata_01.unity",
		id = 70022,
		bgm = 10,
		origin_point = RT[25]
	},
	[70023] = {
		dir = 0,
		path = "Scenes/Battles/battle_pata_01.unity",
		id = 70023,
		bgm = 10,
		origin_point = RT[26]
	},
	[70024] = {
		dir = 0,
		path = "Scenes/Battles/battle_pata_01.unity",
		id = 70024,
		bgm = 10,
		hide_go_name = RT[28],
		origin_point = {
			0.5954,
			-6.01,
			5.92
		}
	},
	[70025] = {
		dir = 0,
		path = "Scenes/Battles/battle_pata_02.unity",
		id = 70025,
		bgm = 10,
		origin_point = RT[25]
	},
	[70026] = {
		result_light = 0,
		path = "Scenes/Battles/battle_dachangjing_01.unity",
		dynamic_path = "battle_dachangjing_01/changyi_chunk_3.prefab",
		id = 70026,
		dir = 0,
		bgm = 10,
		origin_point = {
			66.511,
			34.211,
			234
		}
	},
	[70027] = {
		result_light = 0,
		path = "Scenes/Battles/battle_jiedao_001.unity",
		dynamic_path = "battle_jiedao_001/chongwufanwan_chunk_2.prefab",
		id = 70027,
		dir = 0,
		bgm = 10,
		origin_point = {
			-240.73,
			56.75,
			1621.36
		}
	},
	[70028] = {
		dir = 0,
		path = "Scenes/Battles/battle_feiting_01.unity",
		dynamic_path = "battle_feiting_01/weixiuche_chunk_4.prefab",
		id = 70028,
		bgm = 10,
		origin_point = {
			-44.7,
			20.532,
			215
		}
	},
	[80001] = {
		camera_fov = 26,
		path = "Scenes/Battles/battle_maze_01.unity",
		dir = 0,
		bgm = 17,
		id = 80001,
		camera_pos = RT[30],
		camera_rot = RT[31],
		chuyin_pos = RT[32],
		origin_point = RT[29],
		pet_skill_pos = RT[4]
	},
	[80002] = {
		camera_fov = 26,
		path = "Scenes/Battles/battle_maze_02.unity",
		dir = 0,
		bgm = 17,
		id = 80002,
		camera_pos = RT[30],
		camera_rot = RT[31],
		chuyin_pos = RT[32],
		origin_point = RT[29],
		pet_skill_pos = RT[4]
	},
	[80003] = {
		camera_fov = 26,
		path = "Scenes/Battles/battle_maze_03.unity",
		dir = 0,
		bgm = 17,
		id = 80003,
		camera_pos = RT[30],
		camera_rot = RT[31],
		chuyin_pos = RT[32],
		origin_point = RT[29],
		pet_skill_pos = RT[4]
	},
	[80004] = {
		camera_fov = 26,
		path = "Scenes/Battles/battle_maze_04.unity",
		dir = 0,
		bgm = 17,
		id = 80004,
		camera_pos = RT[30],
		camera_rot = RT[31],
		chuyin_pos = RT[32],
		origin_point = RT[29],
		pet_skill_pos = RT[4]
	},
	[80005] = {
		camera_fov = 26,
		path = "Scenes/Battles/battle_maze_05.unity",
		dir = 0,
		bgm = 17,
		id = 80005,
		camera_pos = RT[30],
		camera_rot = RT[31],
		chuyin_pos = RT[32],
		origin_point = RT[29],
		pet_skill_pos = RT[4]
	},
	[80006] = {
		camera_fov = 26,
		path = "Scenes/Battles/battle_maze_new_01.unity",
		dir = 0,
		bgm = 17,
		id = 80006,
		camera_pos = {
			33.57,
			6.22,
			15.18
		},
		camera_rot = RT[31],
		chuyin_pos = RT[32],
		origin_point = RT[33],
		pet_skill_pos = RT[4]
	},
	[80007] = {
		camera_fov = 26,
		path = "Scenes/Battles/battle_maze_new_02.unity",
		dir = 0,
		bgm = 17,
		id = 80007,
		camera_pos = {
			33.57,
			6.36,
			15.18
		},
		camera_rot = RT[31],
		chuyin_pos = RT[32],
		origin_point = RT[33],
		pet_skill_pos = RT[4]
	},
	[90001] = {
		path = "Scenes/Battles/battle_jingjichang_01.unity",
		id = 90001,
		dir = 0,
		bgm = 11,
		chuyin_pos = RT[6],
		origin_point = {
			18.04,
			0.18,
			-0.47
		},
		pet_skill_pos = RT[4]
	},
	[90011] = {
		dir = 0,
		id = 90011,
		noise = 1101,
		path = "Scenes/Battles/battle_yuye_01.unity",
		chuyin_pos = RT[6],
		origin_point = {
			1.79,
			0.04,
			-0.82
		},
		pet_skill_pos = RT[4]
	},
	[90021] = {
		path = "Scenes/Battles/battle_boss_01.unity",
		id = 90021,
		dir = 0,
		bgm = 10,
		chuyin_pos = {
			3.5,
			3.5
		},
		origin_point = {
			7.68,
			0.975,
			9.2
		},
		pet_skill_pos = RT[4]
	},
	[90022] = {
		enter_camera = "start_Boss.anim",
		id = 90022,
		dir = 0,
		path = "Scenes/Battles/battle_boss_01.unity",
		bgm = 10,
		chuyin_pos = {
			4.5,
			4.5
		},
		origin_point = {
			7.59,
			74.11,
			9.92
		},
		pet_skill_pos = RT[34]
	},
	[90031] = {
		result_light = 0,
		result_camera = "end_changyi.anim",
		path = "Scenes/Battles/battle_dachangjing_01.unity",
		dynamic_path = "battle_dachangjing_01/changyi_chunk_3.prefab",
		dir = 0,
		bgm = 10,
		id = 90031,
		chuyin_pos = {
			-0.5,
			5
		},
		origin_point = {
			64.511,
			34.211,
			233.53
		},
		pet_skill_pos = RT[34]
	},
	[90032] = {
		result_light = 0,
		path = "Scenes/Battles/battle_jiedao_001.unity",
		dynamic_path = "battle_jiedao_001/chongwufanwan_chunk_2.prefab",
		dir = 0,
		bgm = 10,
		id = 90032,
		chuyin_pos = RT[35],
		origin_point = {
			-242.2,
			56.75,
			1621.3
		},
		pet_skill_pos = RT[34]
	},
	[90033] = {
		dynamic_path = "battle_feiting_01/caozuoxiang_chunk_3.prefab",
		dir = 0,
		path = "Scenes/Battles/battle_feiting_01.unity",
		id = 90033,
		bgm = 10,
		chuyin_pos = RT[35],
		origin_point = {
			54.88,
			20.57,
			217.87
		},
		pet_skill_pos = RT[34]
	},
	[90034] = {
		dynamic_path = "battle_feiqifactory_01/fadianji_chunk_1.prefab",
		dir = 0,
		path = "Scenes/Battles/battle_feiqifactory_01.unity",
		id = 90034,
		bgm = 10,
		chuyin_pos = {
			3.5,
			5
		},
		origin_point = {
			99.1701,
			315.999,
			456.4899
		},
		pet_skill_pos = RT[34]
	},
	[90035] = {
		dynamic_path = "battle_feiqifactory_01/youtong_chunk_3.prefab",
		dir = 0,
		path = "Scenes/Battles/battle_feiqifactory_01.unity",
		id = 90035,
		bgm = 10,
		chuyin_pos = RT[36],
		origin_point = {
			208.9955,
			326.187,
			332.4965
		},
		pet_skill_pos = RT[34]
	},
	[90036] = {
		path = "Scenes/Battles/battle_dachangjing_01.unity",
		id = 90036,
		dir = 0,
		bgm = 10,
		chuyin_pos = {
			3,
			5
		},
		origin_point = {
			33.26,
			0.49,
			34.76
		},
		pet_skill_pos = RT[34]
	},
	[90041] = {
		camera_fov = 26,
		path = "Scenes/Battles/battle_gonghuizhan_01.unity",
		dir = 0,
		bgm = 137,
		id = 90041,
		camera_pos = RT[37],
		camera_rot = RT[38],
		chuyin_pos = {
			-1.2,
			4.1
		},
		origin_point = {
			137.8,
			0.1,
			28.61
		},
		pet_skill_pos = RT[34]
	},
	[90042] = {
		camera_fov = 26,
		path = "Scenes/Battles/battle_gonghuizhan_01.unity",
		dir = 0,
		bgm = 137,
		id = 90042,
		camera_pos = RT[37],
		camera_rot = RT[38],
		chuyin_pos = RT[18],
		origin_point = {
			217.85,
			0,
			26.9
		},
		pet_skill_pos = RT[34]
	},
	[90051] = {
		dir = 0,
		id = 90051,
		path = "Scenes/Battles/battle_yuye_02.unity",
		chuyin_pos = RT[36],
		origin_point = {
			1.79,
			0.04,
			1.5
		},
		pet_skill_pos = RT[34]
	}
}

return Data
