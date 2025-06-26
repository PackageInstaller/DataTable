-- chunkname: @IQIGame\\Config\\CfgRestaurantOperationAttributeTable.lua

local CfgRestaurantOperationAttributeTable = {
	{
		Group = 1,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationUpdateUI/RestaurantOperationUpdate_Icon_2.png",
		Id = 1,
		AttName = getI18NValue(180828148)
	},
	{
		Group = 1,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationUpdateUI/RestaurantOperationUpdate_Icon_4.png",
		Id = 2,
		AttName = getI18NValue(180828149)
	},
	{
		Group = 1,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationUpdateUI/RestaurantOperationUpdate_Icon_3.png",
		Id = 3,
		AttName = getI18NValue(180828150)
	},
	{
		Group = 1,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationUpdateUI/RestaurantOperationUpdate_Icon_1.png",
		Id = 4,
		AttName = getI18NValue(180828151)
	},
	{
		Group = 1,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationUpdateUI/RestaurantOperationUpdate_Icon_5.png",
		Id = 5,
		AttName = getI18NValue(180828152)
	},
	{
		Group = 1,
		ImageIcon = "/Activity/RestaurantOperation/Batch1/RestaurantOperationUpdateUI/RestaurantOperationUpdate_Icon_6.png",
		Id = 6,
		AttName = getI18NValue(180828153)
	}
}

setmetatable(CfgRestaurantOperationAttributeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRestaurantOperationAttributeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		ImageIcon = "",
		AttName = ""
	}
}

for i, data in pairs(CfgRestaurantOperationAttributeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRestaurantOperationAttributeTable
