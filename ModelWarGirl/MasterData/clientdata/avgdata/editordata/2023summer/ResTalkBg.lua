-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\2023summer\\ResTalkBg.lua

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
	3.132928,
	177.6531,
	359.6135
}
RT[2] = {
	-1162.63,
	6.01,
	-117.43
}
RT[3] = {
	18.5382,
	310.4372,
	0.179083
}
RT[4] = {
	-13.614,
	36.65002,
	-22.197
}
RT[5] = {
	0,
	1000,
	0
}
RT[6] = {
	17.30843,
	142.2581,
	359.7068
}
RT[7] = {
	-1078.29,
	11.7148,
	-113.76
}
RT[8] = {
	31.35048,
	284.4528,
	358.6757
}
RT[9] = {
	-1182.87,
	46.22,
	-482.45
}
RT[10] = {
	0,
	0,
	0
}

local Data = {
	[38001] = {
		38001,
		1055,
		RT[1],
		RT[2],
		nil,
		40
	},
	[38002] = {
		38002,
		1060,
		RT[3],
		RT[4],
		nil,
		nil,
		"ModelStage/avg_ms_seaside_day",
		RT[5]
	},
	[38003] = {
		38003,
		1055,
		RT[6],
		RT[7],
		nil,
		40,
		"0"
	},
	[38004] = {
		38004,
		1050,
		RT[8],
		RT[9],
		nil,
		40
	},
	[38005] = {
		[1] = 38005,
		[2] = 1050,
		[3] = RT[10],
		[4] = RT[10]
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
