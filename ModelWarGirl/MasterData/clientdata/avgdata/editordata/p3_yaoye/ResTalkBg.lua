-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\P3_yaoye\\ResTalkBg.lua

local indexMap = {
	ui_anim = 14,
	dynamic_path = 5,
	bg_aspec_mode = 17,
	cam_anim = 9,
	is_loop = 19,
	video_path = 20,
	camera_data = 2,
	material_path = 18,
	main_menu_light = 13,
	extra_eff = 11,
	shadow_dist = 6,
	stage_reflect = 12,
	bg_effect = 10,
	bg_path = 16,
	camera_pos = 4,
	camera_rot = 3,
	ui_stage = 7,
	bg_color = 15,
	model_stage_pos = 8,
	id = 1
}
local RT = {}

RT[1] = {
	3.995897,
	180.8341,
	0.130356
}
RT[2] = {
	-63.75,
	-10.56,
	154.18
}
RT[3] = {
	20.06008,
	218.9297,
	0.960006
}
RT[4] = {
	-189.375,
	112.06,
	1588.33
}
RT[5] = {
	12.41359,
	133.2914,
	-0.00017
}
RT[6] = {
	18.61,
	10.21,
	14.29
}
RT[7] = {
	16.25708,
	133.4,
	-2e-06
}
RT[8] = {
	11.81,
	-1.36,
	134.54
}
RT[9] = {
	28.44121,
	310.2931,
	1e-06
}
RT[10] = {
	-206.69,
	-252.822,
	-224.087
}
RT[11] = {
	4.161977,
	65.79607,
	4.7e-05
}
RT[12] = {
	178.144,
	162.448,
	10.254
}
RT[13] = {
	356.37,
	149.71,
	0
}
RT[14] = {
	377.59,
	4210.91,
	142.84
}
RT[15] = {
	17.2361,
	180.7037,
	0.551382
}
RT[16] = {
	-231.53,
	145.54,
	1533.75
}
RT[17] = {
	358.6609,
	141.6026,
	1.8e-05
}
RT[18] = {
	41.24,
	1.48,
	13.14
}
RT[19] = {
	5.847039,
	91.51009,
	0.834244
}
RT[20] = {
	178.29,
	162.57,
	19.04
}
RT[21] = {
	3.32316,
	269.9686,
	359.9536
}
RT[22] = {
	-226.54,
	143.56,
	1536.22
}
RT[23] = {
	100,
	100,
	100
}
RT[24] = {
	5.844203,
	269.8357,
	-3.3e-05
}
RT[25] = {
	227.66,
	157.93,
	33.538
}

local Data = {
	[35301] = {
		35301,
		1050,
		RT[1],
		RT[2],
		nil,
		nil,
		"ModelStage/AvgModelstage_chuyin_houzhai"
	},
	[35302] = {
		35302,
		1050,
		RT[3],
		RT[4],
		"battle_jiedao_001/yangtai_chunk_1.prefab",
		20
	},
	[35303] = {
		35303,
		1,
		RT[5],
		RT[6],
		nil,
		20
	},
	[35310] = {
		35310,
		2,
		RT[7],
		RT[8],
		nil,
		20,
		"ModelStage/AvgModelstage_kitchen"
	},
	[35311] = {
		35311,
		1,
		RT[9],
		RT[10],
		nil,
		20
	},
	[35312] = {
		35312,
		1060,
		RT[11],
		RT[12],
		nil,
		40
	},
	[35313] = {
		35313,
		1040,
		RT[13],
		RT[14],
		nil,
		90,
		"ModelStage/AVGModelStage_shop",
		nil,
		nil,
		nil,
		nil,
		1,
		0
	},
	[35314] = {
		35314,
		3004,
		RT[15],
		RT[16],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_nowutai",
		nil,
		nil,
		nil,
		1,
		1,
		0
	},
	[35315] = {
		35315,
		1060,
		RT[17],
		RT[18],
		nil,
		20,
		"ModelStage/AVGModelStage_chunjie"
	},
	[35316] = {
		35316,
		1070,
		RT[19],
		RT[20],
		nil,
		nil,
		"0"
	},
	[35317] = {
		35317,
		1040,
		RT[21],
		RT[22],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin",
		RT[23]
	},
	[35318] = {
		35318,
		1070,
		RT[24],
		RT[25],
		nil,
		nil,
		"0"
	}
}
local metaTable = {
	__index = function(table, key)
		local keyIndex = indexMap[key]

		if not keyIndex then
			return nil
		end

		return table[keyIndex]
	end
}

for k, v in pairs(Data) do
	setmetatable(v, metaTable)
end

return Data
