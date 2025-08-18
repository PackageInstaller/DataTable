-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\LByure\\ResTalkBg.lua

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
	9.320026,
	134.55,
	0
}
RT[2] = {
	361.09,
	4221.4,
	124.8
}
RT[3] = {
	9.320039,
	199.9763,
	-2e-06
}
RT[4] = {
	363.62,
	4217.78,
	127.31
}
RT[5] = {
	5.059994,
	258.3622,
	2.859994
}
RT[6] = {
	396.36,
	4232.73,
	103.46
}
RT[7] = {
	10.96003,
	175.6712,
	-2e-06
}
RT[8] = {
	387.9,
	4211.95,
	119.31
}

local Data = {
	[41000] = {
		41000,
		1060,
		RT[1],
		RT[2],
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
	[41001] = {
		41001,
		1060,
		RT[3],
		RT[4],
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
	[41002] = {
		41002,
		1,
		RT[5],
		RT[6],
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
	[41003] = {
		41003,
		1060,
		RT[3],
		RT[4],
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
	[41004] = {
		41004,
		1060,
		RT[3],
		RT[4],
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
	[41005] = {
		41005,
		2070,
		RT[7],
		RT[8],
		nil,
		40,
		"ModelStage/AVGModelStage_shop",
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
