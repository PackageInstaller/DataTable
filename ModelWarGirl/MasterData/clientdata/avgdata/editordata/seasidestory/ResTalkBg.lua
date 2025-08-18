-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\seasidestory\\ResTalkBg.lua

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
	5.536804,
	167.4533,
	-9.2e-05
}
RT[2] = {
	-1144.201,
	6.422142,
	-119.2439
}
RT[3] = {
	4.161419,
	245.4907,
	-4.8e-05
}
RT[4] = {
	-1139.936,
	6.214738,
	-121.1292
}
RT[5] = {
	2.270938,
	132.2165,
	-0.000105
}
RT[6] = {
	-1145.708,
	6.112971,
	-118.9031
}
RT[7] = {
	32.52298,
	177.4226,
	-0.000127
}
RT[8] = {
	-1142.704,
	9.040907,
	-117.8159
}

local Data = {
	[31701] = {
		31701,
		1,
		RT[1],
		RT[2],
		nil,
		40
	},
	[31702] = {
		31702,
		1,
		RT[3],
		RT[4],
		nil,
		40
	},
	[31703] = {
		31703,
		1,
		RT[5],
		RT[6],
		nil,
		40
	},
	[31704] = {
		31704,
		1,
		RT[7],
		RT[8],
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
