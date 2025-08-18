-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\zhuxian39\\ResTalkBg.lua

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
	9.599193,
	180,
	0
}
RT[2] = {
	251.29,
	184.44,
	19.12
}
RT[3] = {
	8.262223,
	155.9921,
	359.3852
}
RT[4] = {
	-68.08008,
	-20.16992,
	-51.26953
}
RT[5] = {
	-10000,
	-10000,
	-10000
}
RT[6] = {
	0,
	180,
	0
}
RT[7] = {
	249.34,
	182.62,
	19.9
}
RT[8] = {
	6.391133,
	152.5389,
	-0.000137
}
RT[9] = {
	-41.39,
	43.19,
	-216.72
}
RT[10] = {
	6.874726,
	182.3117,
	-9e-05
}
RT[11] = {
	8.95,
	2.34,
	-69.37
}
RT[12] = {
	354.8878,
	143.7727,
	-0.00014
}
RT[13] = {
	64.6,
	1,
	-201.3
}
RT[14] = {
	64.6,
	0.7,
	-201.3
}
RT[15] = {
	0,
	0,
	0
}
RT[16] = {
	22.7247,
	170.5117,
	0
}
RT[17] = {
	-66.19386,
	-7.729004,
	154.505
}
RT[18] = {
	0,
	300,
	0
}
RT[19] = {
	13.64136,
	122.5291,
	0.302934
}
RT[20] = {
	-54.023,
	9.88,
	-149.34
}
RT[21] = {
	358.0181,
	121.2923,
	359.5922
}
RT[22] = {
	-2,
	1.5,
	76
}
RT[23] = {
	355.3997,
	251.4106,
	-0.000104
}
RT[24] = {
	-34.89,
	2.29,
	-94.65
}

local Data = {
	[33201] = {
		33201,
		2,
		RT[1],
		RT[2],
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
	[33202] = {
		33202,
		1,
		RT[3],
		RT[4],
		nil,
		20,
		"ModelStage/AVGModelStage",
		RT[5],
		nil,
		nil,
		2,
		nil,
		1
	},
	[33203] = {
		33203,
		2,
		RT[1],
		RT[2],
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
	[33204] = {
		33204,
		2,
		RT[6],
		RT[7],
		nil,
		30,
		"ModelStage/NewDisplayModelStage",
		nil,
		nil,
		nil,
		nil,
		1,
		0
	},
	[33205] = {
		33205,
		1060,
		RT[8],
		RT[9],
		nil,
		30
	},
	[33206] = {
		33206,
		1060,
		RT[10],
		RT[11],
		nil,
		30
	},
	[33207] = {
		[1] = 33207,
		[2] = 1055,
		[3] = RT[12],
		[4] = RT[13]
	},
	[33208] = {
		[1] = 33208,
		[2] = 1055,
		[3] = RT[12],
		[4] = RT[14]
	},
	[33209] = {
		[1] = 33209,
		[3] = RT[15],
		[4] = RT[15]
	},
	[33210] = {
		[1] = 33210,
		[2] = 1055,
		[3] = RT[12],
		[4] = RT[14]
	},
	[33211] = {
		33211,
		1,
		RT[16],
		RT[17],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_houzhai",
		RT[18]
	},
	[33212] = {
		[1] = 33212,
		[3] = RT[15],
		[4] = RT[15]
	},
	[33213] = {
		33213,
		1,
		RT[19],
		RT[20],
		nil,
		20
	},
	[33214] = {
		33214,
		1,
		RT[19],
		RT[20],
		nil,
		20
	},
	[33215] = {
		33215,
		1,
		RT[19],
		RT[20],
		nil,
		20
	},
	[33216] = {
		33216,
		1,
		RT[21],
		RT[22],
		nil,
		0
	},
	[33217] = {
		33217,
		1060,
		RT[23],
		RT[24],
		nil,
		60
	},
	[33218] = {
		[1] = 33218,
		[3] = RT[15],
		[4] = RT[15]
	},
	[33219] = {
		[1] = 33219,
		[2] = 1,
		[3] = RT[15],
		[4] = RT[15]
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
