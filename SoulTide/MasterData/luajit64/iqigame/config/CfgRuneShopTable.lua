-- chunkname: @IQIGame\\Config\\CfgRuneShopTable.lua

local CfgRuneShopTable = {
	[1001] = {
		RefreshNum = 999,
		RefreshPrice = 30,
		Id = 1001,
		RuneLibraryDrop = {
			115,
			115,
			116,
			116,
			117,
			117,
			0
		},
		RuneLibraryDiscount = {
			{
				100,
				100,
				100
			},
			{
				100,
				100,
				100
			},
			{
				100,
				100,
				100
			},
			{},
			{
				100,
				100,
				100
			},
			{
				100,
				100,
				100
			},
			{}
		}
	},
	[1002] = {
		RefreshNum = 999,
		RefreshPrice = 30,
		Id = 1002,
		RuneLibraryDrop = {
			115,
			115,
			116,
			116,
			117,
			117,
			0
		},
		RuneLibraryDiscount = {
			{
				100,
				100,
				100
			},
			{
				100,
				100,
				100
			},
			{
				100,
				100,
				100
			},
			{},
			{
				100,
				100,
				100
			},
			{
				100,
				100,
				100
			},
			{}
		}
	},
	[1003] = {
		RefreshNum = 999,
		RefreshPrice = 30,
		Id = 1003,
		RuneLibraryDrop = {
			115,
			115,
			116,
			116,
			117,
			117,
			0
		},
		RuneLibraryDiscount = {
			{
				100,
				100,
				100
			},
			{
				100,
				100,
				100
			},
			{
				100,
				100,
				100
			},
			{},
			{
				100,
				100,
				100
			},
			{
				100,
				100,
				100
			},
			{}
		}
	},
	[1004] = {
		RefreshNum = 999,
		Id = 1004,
		RefreshPrice = 30,
		RuneLibraryDrop = {
			115,
			115,
			116,
			116,
			117,
			117,
			110
		},
		RuneLibraryCondition = {
			0,
			0,
			0,
			0,
			0,
			0,
			40200123
		},
		RuneLibraryDiscount = {
			{
				100,
				100,
				100
			},
			{
				80,
				80,
				80
			},
			{
				100,
				100,
				100
			},
			{
				80,
				80,
				80
			},
			{
				100,
				100,
				100
			},
			{
				80,
				80,
				80
			},
			{
				80,
				80,
				80
			}
		}
	},
	[11004] = {
		RefreshNum = 999,
		Id = 11004,
		RefreshPrice = 30,
		RuneLibraryDrop = {
			10115,
			10115,
			10116,
			10116,
			10117,
			10117,
			10110
		},
		RuneLibraryCondition = {
			0,
			0,
			0,
			0,
			0,
			0,
			40200123
		},
		RuneLibraryDiscount = {
			{
				100,
				100,
				100
			},
			{
				80,
				80,
				80
			},
			{
				100,
				100,
				100
			},
			{
				80,
				80,
				80
			},
			{
				100,
				100,
				100
			},
			{
				80,
				80,
				80
			},
			{
				80,
				80,
				80
			}
		}
	}
}

setmetatable(CfgRuneShopTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRuneShopTable]")
	end
})

local defaultMetaTable = {
	__index = {
		RefreshNum = 0,
		RefreshPrice = 0,
		RuneLibraryDiscount = {
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		},
		RuneLibraryDrop = {
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		RuneLibraryCondition = {
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	}
}

for i, data in pairs(CfgRuneShopTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRuneShopTable
