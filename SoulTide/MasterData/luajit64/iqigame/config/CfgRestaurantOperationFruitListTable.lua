-- chunkname: @IQIGame\\Config\\CfgRestaurantOperationFruitListTable.lua

local CfgRestaurantOperationFruitListTable = {
	{
		Id = 1,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantGameFruitResUI/RestaurantGameFruit_1.png"
	},
	{
		Id = 2,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantGameFruitResUI/RestaurantGameFruit_2.png"
	},
	{
		Id = 3,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantGameFruitResUI/RestaurantGameFruit_3.png"
	},
	{
		Id = 4,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantGameFruitResUI/RestaurantGameFruit_4.png"
	},
	{
		Id = 5,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantGameFruitResUI/RestaurantGameFruit_5.png"
	},
	{
		Id = 6,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantGameFruitResUI/RestaurantGameFruit_6.png"
	},
	{
		Id = 7,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantGameFruitResUI/RestaurantGameFruit_7.png"
	},
	{
		Id = 8,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantGameFruitResUI/RestaurantGameFruit_8.png"
	},
	{
		Id = 9,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantGameFruitResUI/RestaurantGameFruit_9.png"
	},
	{
		Id = 10,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantGameFruitResUI/RestaurantGameFruit_10.png"
	}
}

setmetatable(CfgRestaurantOperationFruitListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRestaurantOperationFruitListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ImageIcon = ""
	}
}

for i, data in pairs(CfgRestaurantOperationFruitListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRestaurantOperationFruitListTable
