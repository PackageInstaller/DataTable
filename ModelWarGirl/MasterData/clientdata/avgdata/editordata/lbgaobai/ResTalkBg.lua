-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\LBgaobai\\ResTalkBg.lua

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
	18.68693,
	118.9092,
	-1.4e-05
}
RT[5] = {
	196.531,
	581.599,
	-67.471
}
RT[6] = {
	0,
	180,
	0
}
RT[7] = {
	250.62,
	181.78,
	12.51
}
RT[8] = {
	37.70001,
	178.33,
	0
}
RT[9] = {
	34.15,
	10.36,
	43.05
}
RT[10] = {
	3.556564,
	98.62774,
	1.019919
}
RT[11] = {
	-57.65039,
	-17.19043,
	-62.69043
}
RT[12] = {
	-10000,
	-10000,
	-10000
}
RT[13] = {
	-64.34,
	-9.709991,
	151.77
}

local Data = {
	[41101] = {
		41101,
		1,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_houzhai",
		RT[3]
	},
	[41102] = {
		41102,
		1,
		RT[4],
		RT[5],
		nil,
		20,
		"ModelStage/AVGModelStage",
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[41103] = {
		41103,
		2,
		RT[6],
		RT[7],
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
	[41104] = {
		41104,
		1070,
		RT[8],
		RT[9],
		nil,
		40,
		"ModelStage/AVGModelStage_chunjie"
	},
	[41105] = {
		41105,
		1050,
		RT[10],
		RT[11],
		nil,
		20,
		"ModelStage/AVGModelStage",
		RT[12]
	},
	[41106] = {
		41106,
		1,
		RT[1],
		RT[13],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_houzhai",
		RT[3]
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
