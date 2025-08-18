-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\CL_yure\\ResTalkBg.lua

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
	8.114663,
	192.9968,
	1.8e-05
}
RT[2] = {
	208.85,
	579.86,
	-42.65
}
RT[3] = {
	22.06839,
	83.46893,
	3.9e-05
}
RT[4] = {
	206.17,
	580.71,
	-43.57
}
RT[5] = {
	6.833878,
	128.7577,
	357.5577
}
RT[6] = {
	206.81,
	579.77,
	-40.46
}

local Data = {
	[39300] = {
		39300,
		1,
		RT[1],
		RT[2],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[39301] = {
		39301,
		1,
		RT[3],
		RT[4],
		nil,
		20,
		"ModelStage/AVGModelStage"
	},
	[39302] = {
		39302,
		1,
		RT[5],
		RT[6],
		nil,
		20,
		"ModelStage/AVGModelStage"
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
