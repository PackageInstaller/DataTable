-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ao_qi_attack_force_model.lua

module("logicconfig.config.t_ao_qi_attack_force_model", package.seeall)

local title = {
	atkAni = 7,
	radius = 2,
	dieAni = 9,
	idleAni = 6,
	hitAni = 8,
	relativeScale = 4,
	modelId = 1,
	resPath = 5,
	relativePos = 3
}
local dataList = {
	{
		1,
		50,
		{
			0,
			-75,
			0
		},
		{
			0.23,
			0.23,
			0.23
		},
		"character/99992_tegongdui/99992_tegongdui-ui_p.prefab",
		"idle",
		"skill01",
		"hit",
		"fail"
	},
	{
		2,
		50,
		{
			0,
			-95,
			0
		},
		{
			0.14,
			0.14,
			0.14
		},
		"effect/prefabs/ui/fx_ui_longzun/xiaoyouxi/jxiaobing_xiaoren/jinzhanbingzhong-ui_p.prefab",
		"move",
		"atk",
		"hit",
		"die"
	},
	{
		3,
		50,
		{
			0,
			-95,
			0
		},
		{
			-0.25,
			0.25,
			0.25
		},
		"effect/prefabs/ui/fx_ui_longzun/xiaoyouxi/yxiaobing_xiaoren/yxiaobing_xiaoren-ui_p.prefab",
		"idle",
		"gongji",
		"hit",
		"die"
	},
	{
		4,
		40,
		{
			0,
			-95,
			0
		},
		{
			0.1,
			0.1,
			0.1
		},
		"effect/prefabs/ui/fx_ui_longzun/xiaoyouxi/jxiaobing_xiaoren/jinzhanbingzhong-ui_p.prefab",
		"move",
		"atk",
		"hit",
		"die"
	}
}
local t_ao_qi_attack_force_model = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_ao_qi_attack_force_model.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_ao_qi_attack_force_model
