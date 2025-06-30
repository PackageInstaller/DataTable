-- chunkname: @IQIGame\\Config\\CfgFacialEffectTable.lua

local CfgFacialEffectTable = {
	{
		Id = 1,
		Staytime = 1.1,
		skiptime = 1.1,
		Path = "Assets/03_Prefabs/Story/FX_Story/Fx_Bubble_Anger_Round.prefab"
	},
	{
		Id = 2,
		Staytime = 1.1,
		skiptime = 1.1,
		Path = "Assets/03_Prefabs/Story/FX_Story/Fx_Bubble_Black_Line_Ball.prefab"
	},
	{
		Id = 3,
		Staytime = 1.1,
		skiptime = 1.1,
		Path = "Assets/03_Prefabs/Story/FX_Story/Fx_Bubble_Black_Line_Round.prefab"
	},
	{
		Id = 4,
		Staytime = 1.1,
		skiptime = 1.1,
		Path = "Assets/03_Prefabs/Story/FX_Story/Fx_Bubble_Sweat_Round.prefab"
	},
	{
		Id = 5,
		Staytime = 1.1,
		skiptime = 1.1,
		Path = "Assets/03_Prefabs/Story/FX_Story/Fx_Exclamation_Mark_Round.prefab"
	},
	{
		Id = 6,
		Staytime = 1.1,
		skiptime = 1.1,
		Path = "Assets/03_Prefabs/Story/FX_Story/Fx_Light_Bulb.prefab"
	},
	{
		Id = 7,
		Staytime = 1.1,
		skiptime = 1.1,
		Path = "Assets/03_Prefabs/Story/FX_Story/Fx_Question_Mark_Round.prefab"
	},
	{
		Id = 8,
		Staytime = 1.8,
		skiptime = 1.8,
		Path = "Assets/03_Prefabs/Effect/FX_Scenes/FX_BG_yindao_02.prefab"
	}
}

setmetatable(CfgFacialEffectTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFacialEffectTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Staytime = 0,
		skiptime = 0,
		Path = ""
	}
}

for i, data in pairs(CfgFacialEffectTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFacialEffectTable
