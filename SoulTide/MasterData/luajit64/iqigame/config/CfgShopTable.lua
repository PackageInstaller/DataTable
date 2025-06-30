-- chunkname: @IQIGame\\Config\\CfgShopTable.lua

local CfgShopTable = {
	[1001] = {
		npcGroupId = 3,
		PayRefreshNumber = 10,
		ShowType = 2,
		Timelast = 111600,
		Type = 1,
		Id = 1001,
		Name = getI18NValue(180465421),
		EngName = getI18NValue(180465420),
		ShowCost = {
			210
		},
		RefreshTime = {
			4
		},
		PayRefreshCost = {
			210,
			10,
			210,
			10,
			210,
			20,
			210,
			20,
			210,
			30,
			210,
			30,
			210,
			40,
			210,
			40,
			210,
			50,
			210,
			50
		},
		GoodsLibraryId = {
			1001,
			1,
			1002,
			1,
			1003,
			1,
			1004,
			1,
			1005,
			1,
			1006,
			1,
			1007,
			1,
			1008,
			1
		}
	},
	[1002] = {
		npcGroupId = 3,
		ShowType = 2,
		Type = 1,
		Id = 1002,
		Name = getI18NValue(180470110),
		EngName = getI18NValue(180470109),
		ShowCost = {
			210
		},
		RefreshTime = {
			4
		},
		GoodsLibraryId = {
			2001,
			1,
			2002,
			1,
			2003,
			1,
			2004,
			1,
			2005,
			1,
			2006,
			1,
			2007,
			1,
			2008,
			1,
			2009,
			1
		}
	}
}

setmetatable(CfgShopTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgShopTable]")
	end
})

local defaultMetaTable = {
	__index = {
		npcGroupId = 0,
		Timelast = 0,
		PayRefreshNumber = 0,
		ItemRefreshNumber = 0,
		ShowType = 0,
		FreeRefreshNumber = 0,
		Name = "",
		EngName = "",
		Type = 0,
		ItemRefreshCost = {},
		ShowCost = {},
		RefreshTime = {},
		GoodsLibraryId = {},
		PayRefreshCost = {}
	}
}

for i, data in pairs(CfgShopTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgShopTable
