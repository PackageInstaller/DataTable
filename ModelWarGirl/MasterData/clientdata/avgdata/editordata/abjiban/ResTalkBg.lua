-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\abjiban\\ResTalkBg.lua

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
	10.60841,
	180.1929,
	5e-06
}
RT[2] = {
	-64.1,
	-9.279999,
	152.26
}
RT[3] = {
	0,
	300,
	0
}
RT[4] = {
	0,
	180,
	0
}
RT[5] = {
	250.62,
	181.78,
	12.51
}
RT[6] = {
	36.64819,
	98.73031,
	-0.000134
}
RT[7] = {
	-57.65039,
	-11,
	-62.69043
}
RT[8] = {
	-10000,
	-10000,
	-10000
}
RT[9] = {
	5.948577,
	180.3553,
	0.000121
}
RT[10] = {
	48.7207,
	11.28003,
	14.90979
}
RT[11] = {
	0,
	600,
	0
}
RT[12] = {
	27.66583,
	146.8633,
	-9.4e-05
}
RT[13] = {
	16.99,
	-1.28,
	134.46
}
RT[14] = {
	0,
	0,
	0
}
RT[15] = {
	-64.34,
	-9.709991,
	151.77
}
RT[16] = {
	26.37253,
	154.1596,
	355.3583
}
RT[17] = {
	-186.8,
	68.5,
	1608.7
}
RT[18] = {
	17.54086,
	129.1679,
	357.6425
}
RT[19] = {
	-145.6413,
	74.2,
	1615.319
}
RT[20] = {
	-21.2,
	74.2,
	1645.3
}

local Data = {
	[37901] = {
		37901,
		1,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_houzhai",
		RT[3]
	},
	[37902] = {
		37902,
		2,
		RT[4],
		RT[5],
		nil,
		30,
		"ModelStage/NewDisplayModelStage",
		nil,
		nil,
		"-1",
		nil,
		1,
		0
	},
	[37903] = {
		37903,
		1050,
		RT[6],
		RT[7],
		nil,
		20,
		"ModelStage/AVGModelStage",
		RT[8]
	},
	[37904] = {
		37904,
		2,
		RT[4],
		RT[5],
		nil,
		30,
		"ModelStage/NewDisplayModelStage",
		nil,
		nil,
		"-1",
		nil,
		1,
		0
	},
	[37905] = {
		37905,
		1,
		RT[9],
		RT[10],
		nil,
		40,
		"ModelStage/AVGModelStage_chunjie",
		RT[11],
		nil,
		nil,
		-1
	},
	[37906] = {
		37906,
		1040,
		RT[12],
		RT[13],
		nil,
		20,
		"ModelStage/AvgModelstage_kitchen",
		RT[14]
	},
	[37907] = {
		37907,
		1,
		RT[1],
		RT[15],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_houzhai",
		RT[3]
	},
	[37908] = {
		37908,
		1060,
		RT[16],
		RT[17],
		"battle_jiedao_001/zhaopai_chunk_3.prefab",
		20
	},
	[37909] = {
		37909,
		1050,
		RT[18],
		RT[19],
		"battle_jiedao_001/zhaopai_chunk_3.prefab",
		20
	},
	[37910] = {
		37910,
		1050,
		RT[18],
		RT[20],
		"battle_jiedao_001/zhaopai_chunk_3.prefab",
		20
	},
	[37911] = {
		37911,
		2,
		RT[4],
		RT[5],
		nil,
		30,
		"ModelStage/NewDisplayModelStage",
		nil,
		nil,
		"-1",
		nil,
		1,
		0
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
