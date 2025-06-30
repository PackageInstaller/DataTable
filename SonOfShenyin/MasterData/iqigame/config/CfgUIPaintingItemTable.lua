-- chunkname: @IQIGame\\Config\\CfgUIPaintingItemTable.lua

local CfgUIPaintingItemTable = {
	[10000] = {
		PrefabPath = "Assets/03_Prefabs/Home/Parts/Painting_1600.prefab",
		ID = 10000,
		Icon = "/Item/1600.png",
		IsShow = true,
		Name = getI18NValue(180261073),
		ItemTips = getI18NValue(180261072)
	},
	[10001] = {
		PrefabPath = "Assets/03_Prefabs/Home/Parts/Painting_1601.prefab",
		ItemID = 1601,
		ID = 10001,
		Icon = "/Item/1601.png",
		IsShow = true,
		Name = getI18NValue(180261075),
		ItemTips = getI18NValue(180261074)
	},
	[10002] = {
		PrefabPath = "Assets/03_Prefabs/Home/Parts/Painting_1602.prefab",
		ItemID = 1602,
		ID = 10002,
		Icon = "/Item/1602.png",
		IsShow = true,
		Name = getI18NValue(180261077),
		ItemTips = getI18NValue(180261076)
	},
	[10003] = {
		PrefabPath = "Assets/03_Prefabs/Home/Parts/Painting_1603.prefab",
		ItemID = 1603,
		ID = 10003,
		Icon = "/Item/1603.png",
		IsShow = true,
		Name = getI18NValue(180261079),
		ItemTips = getI18NValue(180261078)
	},
	[10004] = {
		PrefabPath = "Assets/03_Prefabs/Home/Parts/Painting_1604.prefab",
		ItemID = 1604,
		ID = 10004,
		Icon = "/Item/1604.png",
		IsShow = true,
		Name = getI18NValue(180261081),
		ItemTips = getI18NValue(180261080)
	},
	[10005] = {
		PrefabPath = "Assets/03_Prefabs/Home/Parts/Painting_1605.prefab",
		ItemID = 1605,
		ID = 10005,
		Icon = "/Item/1605.png",
		IsShow = true,
		Name = getI18NValue(180263173),
		ItemTips = getI18NValue(180263172)
	}
}

setmetatable(CfgUIPaintingItemTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgUIPaintingItemTable]")
	end
})

local defaultMetaTable = {
	__index = {
		PrefabPath = "",
		Name = "",
		ItemID = 0,
		ItemTips = "",
		Icon = "",
		IsShow = false
	}
}

for i, data in pairs(CfgUIPaintingItemTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgUIPaintingItemTable
