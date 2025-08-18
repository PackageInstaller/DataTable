-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\tu2ye_qiandao\\ResTalkBg.lua

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
	8.286565,
	345.3569,
	1.4e-05
}
RT[2] = {
	-228.72,
	143.55,
	1525.61
}
RT[3] = {
	100,
	100,
	100
}
RT[4] = {
	356.4261,
	52.08131,
	-4.2e-05
}
RT[5] = {
	-164.32,
	143.95,
	1505.37
}
RT[6] = {
	20.06,
	222.44,
	0.96
}
RT[7] = {
	-190.98,
	112.06,
	1587.05
}
RT[8] = {
	10.21004,
	107.4299,
	0.579975
}
RT[9] = {
	-336.64,
	4205.82,
	100.27
}
RT[10] = {
	358.4585,
	70.09526,
	0.396877
}
RT[11] = {
	-5.58,
	31.56995,
	-2.69
}
RT[12] = {
	0,
	1000,
	0
}
RT[13] = {
	357.8586,
	39.92855,
	358.2514
}
RT[14] = {
	-0.84,
	31.34998,
	-14.5
}

local Data = {
	[35021] = {
		35021,
		1070,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin",
		RT[3]
	},
	[35022] = {
		35022,
		1065,
		RT[4],
		RT[5],
		nil,
		nil,
		"ModelStage/AvgModelstage_chuyin"
	},
	[35023] = {
		35023,
		1050,
		RT[6],
		RT[7],
		"battle_jiedao_001/yangtai_chunk_1.prefab",
		20
	},
	[35024] = {
		35024,
		1,
		RT[8],
		RT[9],
		nil,
		40,
		"ModelStage/AVGModelStage_1207",
		nil,
		nil,
		"Effects/UI/efx_ui_snow.prefab",
		nil,
		1,
		0
	},
	[35025] = {
		35025,
		1060,
		RT[10],
		RT[11],
		nil,
		nil,
		"ModelStage/avg_ms_seaside_day",
		RT[12],
		[11] = 1
	},
	[35026] = {
		35026,
		1060,
		RT[13],
		RT[14],
		nil,
		nil,
		"ModelStage/avg_ms_seaside_day",
		RT[12],
		[11] = 1
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
