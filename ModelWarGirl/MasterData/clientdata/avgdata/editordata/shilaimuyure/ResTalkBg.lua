-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\shilaimuyure\\ResTalkBg.lua

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
	7.032903,
	113.7178,
	359.7929
}
RT[2] = {
	362.595,
	4221.177,
	120.585
}

local Data = {
	[23350] = {
		23350,
		1060,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/AVGModelStage_shop"
	},
	[23351] = {
		23351,
		1060,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/AVGModelStage_shop"
	},
	[23352] = {
		23352,
		1060,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/AVGModelStage_shop"
	},
	[23353] = {
		23353,
		1060,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/AVGModelStage_shop"
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
