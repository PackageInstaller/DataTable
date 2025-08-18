-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\3rd_qiandao\\ResTalkBg.lua

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
	180,
	0
}
RT[2] = {
	249.26,
	181.72,
	21.42
}
RT[3] = {
	12.88176,
	211.3055,
	0.799489
}
RT[4] = {
	223.69,
	581.34,
	-47.92
}
RT[5] = {
	352.1341,
	106.0977,
	-0.000153
}
RT[6] = {
	-181.92,
	173.45,
	-29.41
}
RT[7] = {
	7.478928,
	84.4818,
	359.0684
}
RT[8] = {
	-10.29,
	32.91003,
	1.47
}
RT[9] = {
	0,
	1200,
	0
}
RT[10] = {
	9.599193,
	180,
	0
}
RT[11] = {
	250.4,
	185.04,
	19.02
}

local Data = {
	[40302] = {
		40302,
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
	[40303] = {
		40303,
		1,
		RT[3],
		RT[4],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[40304] = {
		40304,
		1,
		RT[3],
		RT[4],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[40305] = {
		40305,
		1,
		RT[5],
		RT[6],
		nil,
		20
	},
	[40306] = {
		40306,
		1060,
		RT[7],
		RT[8],
		nil,
		nil,
		"ModelStage/avg_ms_seaside_night",
		RT[9],
		[10] = "Effects/UI/efx_ui_AVG_Sea_01.prefab"
	},
	[40307] = {
		40307,
		2,
		RT[10],
		RT[11],
		nil,
		20,
		"ModelStage/NewDisplayModelStage",
		nil,
		nil,
		"-1",
		nil,
		1,
		0
	},
	[40308] = {
		40308,
		2,
		RT[10],
		RT[11],
		nil,
		20,
		"ModelStage/NewDisplayModelStage",
		nil,
		nil,
		nil,
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
