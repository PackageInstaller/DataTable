-- chunkname: @IQIGame\\Config\\CfgBattlePreloadTable.lua

local CfgBattlePreloadTable = {
	[11] = {
		Id = 11,
		Path = "/Common/Warlock/Profession/BattleProfession_1.png"
	},
	[12] = {
		Id = 12,
		Path = "/Common/Warlock/Profession/BattleProfession_2.png"
	},
	[13] = {
		Id = 13,
		Path = "/Common/Warlock/Profession/BattleProfession_3.png"
	},
	[14] = {
		Id = 14,
		Path = "/Common/Warlock/Profession/BattleProfession_4.png"
	},
	[21] = {
		Id = 21,
		Path = "/Icon/Attribute/shield_ice.png"
	},
	[22] = {
		Id = 22,
		Path = "/Icon/Attribute/shield_fire.png"
	},
	[23] = {
		Id = 23,
		Path = "/Icon/Attribute/shield_bolt.png"
	},
	[24] = {
		Id = 24,
		Path = "/Icon/Attribute/shield_water.png"
	},
	[25] = {
		Id = 25,
		Path = "/Icon/Attribute/shield_wind.png"
	},
	[31] = {
		Id = 31,
		Path = "/Icon/Attribute/element_ice.png"
	},
	[32] = {
		Id = 32,
		Path = "/Icon/Attribute/element_fire.png"
	},
	[33] = {
		Id = 33,
		Path = "/Icon/Attribute/element_bolt.png"
	},
	[34] = {
		Id = 34,
		Path = "/Icon/Attribute/element_water.png"
	},
	[35] = {
		Id = 35,
		Path = "/Icon/Attribute/element_wind.png"
	},
	[41] = {
		Id = 41,
		Path = "/Icon/Attribute/buff_defenceDown.png"
	},
	[42] = {
		Id = 42,
		Path = "/Icon/Attribute/buff_freeze.png"
	},
	[43] = {
		Id = 43,
		Path = "/Icon/Attribute/buff_silence.png"
	},
	[51] = {
		Id = 51,
		Path = "/Battle/Ground/An_Material_frozen.mat"
	},
	[52] = {
		Id = 52,
		Path = "/Battle/Ground/damageNumAssets.prefab"
	},
	[100] = {
		Id = 100,
		Path = "Assets/05_Images/DataResource/BattleResource/Num/normal%s.png"
	},
	[101] = {
		Id = 101,
		Path = "Assets/05_Images/DataResource/BattleResource/Num/wind%s.png"
	},
	[102] = {
		Id = 102,
		Path = "Assets/05_Images/DataResource/BattleResource/Num/fire%s.png"
	},
	[103] = {
		Id = 103,
		Path = "Assets/05_Images/DataResource/BattleResource/Num/bolt%s.png"
	},
	[104] = {
		Id = 104,
		Path = "Assets/05_Images/DataResource/BattleResource/Num/water%s.png"
	},
	[109] = {
		Id = 109,
		Path = "Assets/05_Images/DataResource/BattleResource/Num/heal%s.png"
	},
	[110] = {
		Id = 110,
		Path = "Assets/03_Prefabs/Effect/FX_UI/FX_UI_Element_Normal.prefab"
	},
	[111] = {
		Id = 111,
		Path = "Assets/03_Prefabs/Effect/FX_UI/FX_UI_Element_Wind.prefab"
	},
	[112] = {
		Id = 112,
		Path = "Assets/03_Prefabs/Effect/FX_UI/FX_UI_Element_Fire.prefab"
	},
	[113] = {
		Id = 113,
		Path = "Assets/03_Prefabs/Effect/FX_UI/FX_UI_Element_Thunder.prefab"
	},
	[114] = {
		Id = 114,
		Path = "Assets/03_Prefabs/Effect/FX_UI/FX_UI_Element_Water.prefab"
	},
	[115] = {
		Id = 115,
		Path = "Assets/03_Prefabs/Effect/FX_UI/FX_UI_Element_Wind.prefab"
	},
	[200] = {
		Id = 200,
		Path = "Assets/08_Fonts/TextFont_SDF/AaXinHuaShuangJianTi-2 SDF_BattleDamageEffect_Normal_Physical.mat"
	},
	[201] = {
		Id = 201,
		Path = "Assets/08_Fonts/TextFont_SDF/AaXinHuaShuangJianTi-2 SDF_BattleDamageEffect_Cure.mat"
	},
	[202] = {
		Id = 202,
		Path = "Assets/08_Fonts/TextFont_SDF/AaXinHuaShuangJianTi-2 SDF_BattleDamageEffect_Element_Water.mat"
	},
	[203] = {
		Id = 203,
		Path = "Assets/08_Fonts/TextFont_SDF/AaXinHuaShuangJianTi-2 SDF_BattleDamageEffect_Element_Fire.mat"
	},
	[204] = {
		Id = 204,
		Path = "Assets/08_Fonts/TextFont_SDF/AaXinHuaShuangJianTi-2 SDF_BattleDamageEffect_Element_Thunder.mat"
	},
	[205] = {
		Id = 205,
		Path = "Assets/08_Fonts/TextFont_SDF/AaXinHuaShuangJianTi-2 SDF_BattleDamageEffect_Element_Wind.mat"
	},
	[206] = {
		Id = 206,
		Path = "Assets/08_Fonts/TextFont_SDF/AaXinHuaShuangJianTi-2 SDF_BattleDamageEffect_ShieldReduce.mat"
	},
	[207] = {
		Id = 207,
		Path = "Assets/08_Fonts/TextFont_SDF/AaXinHuaShuangJianTi-2 SDF_BattleDamageEffect_DOT.mat"
	},
	[208] = {
		Id = 208,
		Path = "Assets/08_Fonts/TextFont_SDF/AaXinHuaShuangJianTi-2 SDF_BattleDamageEffect_Others.mat"
	},
	[300] = {
		Id = 300,
		Path = "Assets/03_Prefabs/Effect/FX_Universal/FX_Common_Broken.prefab"
	},
	[301] = {
		Id = 301,
		Path = "Assets/03_Prefabs/Effect/FX_UI/FX_UI_Element_Normal.prefab"
	}
}

setmetatable(CfgBattlePreloadTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgBattlePreloadTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Path = ""
	}
}

for i, data in pairs(CfgBattlePreloadTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgBattlePreloadTable
