-- chunkname: @IQIGame\\Config\\CfgRestaurantOperationCardListTable.lua

local CfgRestaurantOperationCardListTable = {
	{
		Id = 1,
		ImageIcon = "/Icon/Item/Item_Icon_Ingredient_01.png"
	},
	{
		Id = 2,
		ImageIcon = "/Icon/Item/Item_Icon_Ingredient_02.png"
	},
	{
		Id = 3,
		ImageIcon = "/Icon/Item/Item_Icon_Ingredient_03.png"
	},
	{
		Id = 4,
		ImageIcon = "/Icon/Item/Item_Icon_Ingredient_04.png"
	},
	{
		Id = 5,
		ImageIcon = "/Icon/Item/Item_Icon_Ingredient_05.png"
	},
	{
		Id = 6,
		ImageIcon = "/Icon/Item/Item_Icon_Ingredient_06.png"
	},
	{
		Id = 7,
		ImageIcon = "/Icon/Item/Item_Icon_Ingredient_07.png"
	},
	{
		Id = 8,
		ImageIcon = "/Icon/Item/Item_Icon_Ingredient_08.png"
	},
	{
		Id = 9,
		ImageIcon = "/Icon/Item/Item_Icon_Ingredient_09.png"
	},
	{
		Id = 10,
		ImageIcon = "/Icon/Item/Item_Icon_Ingredient_10.png"
	},
	{
		Id = 11,
		ImageIcon = "/Icon/Item/Item_Icon_Ingredient_11.png"
	},
	{
		Id = 12,
		ImageIcon = "/Icon/Item/Item_Icon_Ingredient_12.png"
	}
}

setmetatable(CfgRestaurantOperationCardListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRestaurantOperationCardListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ImageIcon = ""
	}
}

for i, data in pairs(CfgRestaurantOperationCardListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRestaurantOperationCardListTable
