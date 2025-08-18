-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\signin-springfestival\\ResTalkBg.lua

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
	0,
	0,
	0
}
RT[2] = {
	51.22001,
	216.96,
	3e-06
}
RT[3] = {
	38.24,
	13.28,
	36.43
}
RT[4] = {
	19.11667,
	173.814,
	6.5e-05
}
RT[5] = {
	20.29618,
	-3.435979,
	128.1791
}
RT[6] = {
	6.051551,
	165.8708,
	1e-06
}
RT[7] = {
	18.6422,
	-5.152552,
	132.9506
}
RT[8] = {
	359.6938,
	202.795,
	8.2e-05
}
RT[9] = {
	-74.69162,
	-14.43774,
	127.3956
}
RT[10] = {
	23.58607,
	180.9654,
	8.7e-05
}
RT[11] = {
	-76.26,
	-14.32,
	125.3
}
RT[12] = {
	356.4261,
	52.08131,
	-4.2e-05
}
RT[13] = {
	-164.55,
	144.12,
	1505.18
}
RT[14] = {
	0.551395,
	151.0883,
	-4.8e-05
}
RT[15] = {
	17.49,
	-6.12,
	134.1
}
RT[16] = {
	18.42949,
	162.0578,
	8.3e-05
}
RT[17] = {
	-82.428,
	-13.867,
	128.544
}

local Data = {
	[25600] = {
		25600,
		1,
		RT[1],
		RT[1],
		[16] = "NoAlpha/PlayerGuide/Story/127"
	},
	[25610] = {
		25610,
		1055,
		RT[2],
		RT[3],
		nil,
		40,
		"ModelStage/AVGModelStage_chunjie"
	},
	[25611] = {
		25611,
		1055,
		RT[4],
		RT[5],
		nil,
		20,
		"ModelStage/AvgModelstage_kitchen"
	},
	[25612] = {
		25612,
		1055,
		RT[6],
		RT[7],
		nil,
		20,
		"ModelStage/AvgModelstage_kitchen"
	},
	[25620] = {
		25620,
		1075,
		RT[8],
		RT[9],
		nil,
		20,
		"ModelStage/AvgModelstage_kitchen"
	},
	[25621] = {
		25621,
		1075,
		RT[10],
		RT[11],
		nil,
		20,
		"ModelStage/AvgModelstage_kitchen"
	},
	[25630] = {
		25630,
		1065,
		RT[12],
		RT[13],
		nil,
		nil,
		"ModelStage/AvgModelstage_chuyin"
	},
	[25631] = {
		[1] = 25631,
		[2] = 1065,
		[3] = RT[1],
		[4] = RT[1]
	},
	[25640] = {
		25640,
		3005,
		RT[14],
		RT[15],
		nil,
		20,
		"ModelStage/AvgModelstage_kitchen",
		RT[1]
	},
	[25622] = {
		25622,
		1060,
		RT[16],
		RT[17],
		nil,
		20,
		"ModelStage/AvgModelstage_kitchen"
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
