-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\longnianqiandao\\ResTalkBg.lua

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
	14.67145,
	211.5251,
	4.6e-05
}
RT[2] = {
	19.35,
	3.38,
	23.03
}
RT[3] = {
	8.459975,
	179.2161,
	-0.000149
}
RT[4] = {
	-203.88,
	143.38,
	1538.69
}
RT[5] = {
	10.21004,
	107.4299,
	0.579975
}
RT[6] = {
	-336.64,
	4205.82,
	100.27
}

local Data = {
	[42501] = {
		42501,
		1,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/AVGModelStage_chunjie",
		nil,
		nil,
		"Effects/UI/efx_ui_yanhua.prefab"
	},
	[42502] = {
		42502,
		3001,
		RT[3],
		RT[4],
		nil,
		20,
		"ModelStage/AvgModelstage_chuyin_nowutai"
	},
	[42503] = {
		42503,
		1,
		RT[5],
		RT[6],
		nil,
		40,
		"ModelStage/AVGModelStage_1207",
		nil,
		nil,
		"Effects/UI/efx_ui_snow.prefab",
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
