-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\2ndspecial\\ResTalkBg.lua

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
	17.1,
	150.08,
	1e-06
}
RT[2] = {
	-247.92,
	145.79,
	1568.93
}
RT[3] = {
	32.49002,
	196.65,
	0
}
RT[4] = {
	-1186.56,
	34.82,
	-223
}
RT[5] = {
	24.78823,
	83.46893,
	3.7e-05
}
RT[6] = {
	206.3719,
	581.1705,
	-43.54851
}
RT[7] = {
	22.7247,
	170.5117,
	0
}
RT[8] = {
	-66.19386,
	-6.72879,
	154.505
}
RT[9] = {
	0,
	300,
	0
}
RT[10] = {
	12.20742,
	55.0453,
	-0.000132
}
RT[11] = {
	218.808,
	580.377,
	-52.801
}
RT[12] = {
	10.3511,
	202.1945,
	1.1e-05
}
RT[13] = {
	-233.7335,
	144.846,
	1536.67
}
RT[14] = {
	100,
	100,
	100
}
RT[15] = {
	0,
	180,
	0
}
RT[16] = {
	249.26,
	182.62,
	21.16
}
RT[17] = {
	0.32,
	200.02,
	359.86
}
RT[18] = {
	-1263.75,
	16.95,
	-396
}
RT[19] = {
	7.400077,
	151.23,
	-1e-05
}
RT[20] = {
	-1226.45,
	16.95,
	-390.63
}
RT[21] = {
	13.01001,
	183.82,
	-2e-06
}
RT[22] = {
	-1172.22,
	17.23,
	-175.75
}
RT[23] = {
	13.00005,
	200.82,
	3.6e-05
}
RT[24] = {
	-1112.22,
	17.23,
	-173
}
RT[25] = {
	16.27001,
	153.57,
	1.4e-05
}
RT[26] = {
	-1157.32,
	7.74,
	-117.97
}

local Data = {
	[33301] = {
		33301,
		3001,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_nowutai"
	},
	[33302] = {
		33302,
		1,
		RT[3],
		RT[4],
		"battle_youleyuan_001/taiyangsan_chunk_1.prefab",
		40
	},
	[33303] = {
		33303,
		1,
		RT[5],
		RT[6],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[33306] = {
		33306,
		1,
		RT[7],
		RT[8],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_houzhai",
		RT[9]
	},
	[33310] = {
		33310,
		1,
		RT[7],
		RT[8],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_houzhai",
		RT[9]
	},
	[33307] = {
		33307,
		1075,
		RT[10],
		RT[11],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[33308] = {
		33308,
		1070,
		RT[12],
		RT[13],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin",
		RT[14]
	},
	[33309] = {
		33309,
		2,
		RT[15],
		RT[16],
		nil,
		20,
		"ModelStage/NewDisplayModelStage",
		nil,
		nil,
		nil,
		nil,
		1,
		0
	},
	[33311] = {
		33311,
		1050,
		RT[17],
		RT[18],
		nil,
		40
	},
	[33304] = {
		33304,
		1,
		RT[19],
		RT[20],
		nil,
		40
	},
	[33312] = {
		33312,
		1,
		RT[21],
		RT[22],
		nil,
		40
	},
	[33305] = {
		33305,
		1,
		RT[23],
		RT[24],
		nil,
		40
	},
	[33313] = {
		33313,
		1,
		RT[25],
		RT[26],
		nil,
		40
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
